//! Effect compilation: Handle, Perform, Resume → bytecode.
//!
//! Handler bodies are compiled as separate `FnProto`s (their own call frames),
//! which naturally handles cross-frame effect dispatch. State variables are
//! passed as extra parameters after the effect operation's parameters.

use std::sync::Arc;

use crate::ast::{Expr, HandlerOp, StateBinding, StateUpdate};
use crate::error::LuxError;
use crate::vm::chunk::{Constant, HandlerEntry, HandlerTable};
use crate::vm::opcode::OpCode;

use super::compiler::Compiler;

/// Context for compiling `resume` expressions inside handler bodies.
/// Maps state variable names to their indices in the handler's state array.
pub(super) struct HandlerCtx {
    pub state_names: Vec<String>,
}

impl Compiler {
    /// Compile a `handle { body } [with state = init, ...] { handlers }` expression.
    ///
    /// Each handler body becomes a separate `FnProto` stored in the chunk's
    /// constants. The `HandlerTable` maps operation names to these protos.
    pub(super) fn compile_handle(
        &mut self,
        body: &Expr,
        handlers: &[crate::ast::HandlerClause],
        state_bindings: &[StateBinding],
        span: &crate::token::Span,
    ) -> Result<(), LuxError> {
        let line = Self::current_line(span);

        // Compile state init expressions. Values are left on the stack
        // and consumed by PushHandler (stored in VmHandlerFrame.state).
        // State variables are NOT declared as locals — the handle body
        // only accesses state through effect operations, and handler bodies
        // receive state as FnProto parameters.
        for binding in state_bindings {
            self.compile_expr(&binding.init)?;
        }
        let state_count = state_bindings.len();

        // Collect state variable names for handler body compilation.
        let state_names: Vec<String> = state_bindings.iter().map(|sb| sb.name.clone()).collect();

        // Compile each handler body as a separate FnProto.
        let mut table = HandlerTable {
            entries: Vec::new(),
        };
        for clause in handlers {
            if let HandlerOp::OpHandler {
                op_name,
                params,
                body: handler_body,
                ..
            } = &clause.operation
            {
                let proto =
                    self.compile_handler_body(op_name, params, handler_body, &state_names, line)?;

                let proto_idx = self.chunk.add_constant(Constant::FnProto(Arc::new(proto)));
                let op_name_idx = self.chunk.intern_name(op_name);
                table.entries.push(HandlerEntry {
                    op_name_idx,
                    proto_idx,
                    param_count: params.len() as u8,
                });
            }
        }

        // Add handler table to chunk.
        let table_idx = self.chunk.handler_tables.len() as u16;
        self.chunk.handler_tables.push(table);

        // Emit PushHandler: table_idx, state_count.
        // state_slot_base is unused (0) — state is popped from stack.
        self.emit_op(OpCode::PushHandler, line);
        self.emit_u16(table_idx, line);
        self.emit_u16(0, line); // state_slot_base unused
        self.emit_u8(state_count as u8, line);

        // Compile handle body.
        self.compile_expr(body)?;

        // PopHandler (body completed normally, result is on TOS).
        self.emit_op(OpCode::PopHandler, line);

        Ok(())
    }

    /// Compile a handler body as a standalone `FnProto`.
    ///
    /// Parameters: `[effect_params..., state_vars...]`
    /// The VM passes effect args and current state when dispatching.
    fn compile_handler_body(
        &mut self,
        op_name: &str,
        params: &[String],
        body: &Expr,
        state_names: &[String],
        line: u32,
    ) -> Result<crate::vm::chunk::FnProto, LuxError> {
        let mut sub = Compiler::new(&format!("handler:{op_name}"));
        sub.effect_ops = self.effect_ops.clone();
        sub.scope.begin_scope();

        // Declare effect params as locals.
        for param in params {
            sub.scope.declare_local(param);
        }

        // Declare state vars as locals (passed by VM as extra args).
        for name in state_names {
            sub.scope.declare_local(name);
        }

        // Set handler context so Resume can resolve state update names.
        sub.handler_ctx = Some(HandlerCtx {
            state_names: state_names.to_vec(),
        });

        // Compile handler body expression.
        sub.compile_expr(body)?;

        // Emit Return for the fall-through case (HandleDone — handler
        // returned without calling resume).
        sub.emit_op(OpCode::Return, line);

        let mut proto = sub.finish();
        proto.arity = (params.len() + state_names.len()) as u16;
        Ok(proto)
    }

    /// Compile a `perform Effect.op(args)` expression.
    ///
    /// Emits: `[args...] Perform op_name_idx argc`
    /// The VM dispatches to the nearest handler on the handler stack.
    pub(super) fn compile_perform(
        &mut self,
        _effect: &str,
        operation: &str,
        args: &[Expr],
        span: &crate::token::Span,
    ) -> Result<(), LuxError> {
        let line = Self::current_line(span);

        // Compile effect arguments.
        for arg in args {
            self.compile_expr(arg)?;
        }

        // Emit Perform opcode.
        let op_name_idx = self.chunk.intern_name(operation);
        self.emit_op(OpCode::Perform, line);
        self.emit_u16(op_name_idx, line);
        self.emit_u8(args.len() as u8, line);

        Ok(())
    }

    /// Compile a `resume(value) [with name = expr, ...]` expression.
    ///
    /// Stack before Resume: `[resume_value, update_val_0, update_val_1, ...]`
    /// Operands after Resume: `u8 count`, then `count` x `u16 state_offset`.
    pub(super) fn compile_resume(
        &mut self,
        value: &Expr,
        state_updates: &[StateUpdate],
        span: &crate::token::Span,
    ) -> Result<(), LuxError> {
        let line = Self::current_line(span);

        // Compile resume value.
        self.compile_expr(value)?;

        // Compile state update value expressions.
        for update in state_updates {
            self.compile_expr(&update.value)?;
        }

        // Emit Resume opcode.
        self.emit_op(OpCode::Resume, line);
        self.emit_u8(state_updates.len() as u8, line);

        // Emit state slot offsets for each update.
        for update in state_updates {
            let offset = self
                .handler_ctx
                .as_ref()
                .and_then(|ctx| ctx.state_names.iter().position(|n| n == &update.name))
                .unwrap_or(0);
            self.emit_u16(offset as u16, line);
        }

        Ok(())
    }
}
