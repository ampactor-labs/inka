//! Effect dispatch for the Lux VM: PushHandler, Perform, Resume, PopHandler.
//!
//! Handler bodies are compiled as separate `FnProto`s. When `Perform` dispatches
//! to a handler, the VM pushes a new call frame for the handler body. `Resume`
//! unwinds back to the perform site and pushes the resume value.

use std::sync::Arc;

use super::chunk::{Constant, FnProto};
use super::error::VmError;
use super::frame::{CallFrame, VmHandlerEntry, VmHandlerFrame};
use super::value::VmValue;
use super::vm::Vm;

impl Vm {
    /// Process the `PushHandler` opcode.
    ///
    /// Reads handler table from the current chunk, resolves entries to
    /// concrete strings and FnProtos, copies state from stack locals,
    /// and pushes a `VmHandlerFrame` onto the handler stack.
    pub(super) fn op_push_handler(&mut self, frame_idx: usize) -> Result<(), VmError> {
        let table_idx = self.frames[frame_idx].read_u16() as usize;
        let _state_base = self.frames[frame_idx].read_u16() as usize;
        let state_count = self.frames[frame_idx].read_byte() as usize;

        // Pop state init values from the stack (pushed by compile_handle).
        let start = self.stack.len() - state_count;
        let state: Vec<VmValue> = self.stack.drain(start..).collect();

        // Resolve handler entries from the current chunk's handler table.
        let entries = self.resolve_handler_entries(frame_idx, table_idx)?;

        self.handler_stack.push(VmHandlerFrame {
            entries,
            frame_idx: self.frames.len() - 1,
            stack_height: self.stack.len(),
            state,
            resume_ip: 0,
            resume_frame_idx: 0,
            resume_stack_height: 0,
        });

        Ok(())
    }

    /// Process the `PopHandler` opcode.
    pub(super) fn op_pop_handler(&mut self) {
        self.handler_stack.pop();
    }

    /// Process the `Perform` opcode.
    ///
    /// Pops effect args, searches the handler stack for a matching handler,
    /// saves resume state, and pushes a call frame for the handler body.
    pub(super) fn op_perform(&mut self, frame_idx: usize) -> Result<(), VmError> {
        let op_name_idx = self.frames[frame_idx].read_u16();
        let argc = self.frames[frame_idx].read_byte() as usize;

        // Resolve the operation name from the current chunk.
        let op_name = self.frames[frame_idx]
            .proto
            .chunk
            .names
            .get(op_name_idx as usize)
            .cloned()
            .unwrap_or_default();

        // Pop effect arguments from the stack.
        let args_start = self.stack.len() - argc;
        let args: Vec<VmValue> = self.stack.drain(args_start..).collect();

        // Search handler stack (top-down) for a matching handler.
        let found = self.find_handler(&op_name);

        if let Some((handler_idx, entry_idx)) = found {
            // Save resume state on the handler frame.
            let resume_ip = self.frames[frame_idx].ip;
            let resume_stack_height = self.stack.len();

            let handler = &mut self.handler_stack[handler_idx];
            handler.resume_ip = resume_ip;
            handler.resume_frame_idx = frame_idx;
            handler.resume_stack_height = resume_stack_height;

            // Get the handler proto and state.
            let proto = handler.entries[entry_idx].proto.clone();
            let state = handler.state.clone();

            // Push call frame for the handler body.
            self.dispatch_handler_body(proto, &args, &state)?;

            // Track that we're in a handler dispatch (stack for nesting).
            self.handler_dispatch_stack
                .push((handler_idx, self.frames.len() - 1));

            Ok(())
        } else {
            let line = self.frames[frame_idx].current_line();
            Err(VmError::new(
                format!("unhandled effect operation: {op_name}"),
                line,
            ))
        }
    }

    /// Process the `Resume` opcode.
    ///
    /// Pops state update values and resume value from the stack, applies
    /// state updates to the handler frame, unwinds the handler body frame,
    /// and restores execution at the perform site with the resume value.
    pub(super) fn op_resume(&mut self, frame_idx: usize) -> Result<(), VmError> {
        let update_count = self.frames[frame_idx].read_byte() as usize;

        // Read state offset indices.
        let mut state_offsets = Vec::with_capacity(update_count);
        for _ in 0..update_count {
            state_offsets.push(self.frames[frame_idx].read_u16());
        }

        // Pop state update values (reverse order: last pushed = last offset).
        let mut update_values = Vec::with_capacity(update_count);
        for _ in 0..update_count {
            update_values.push(self.stack.pop().unwrap_or(VmValue::Unit));
        }
        update_values.reverse();

        // Pop resume value.
        let resume_value = self.stack.pop().unwrap_or(VmValue::Unit);

        if let Some((h_idx, body_frame_idx)) = self.handler_dispatch_stack.pop() {
            // Apply state updates to the handler frame.
            let handler = &mut self.handler_stack[h_idx];
            for (offset, value) in state_offsets.iter().zip(update_values.into_iter()) {
                let idx = *offset as usize;
                if idx < handler.state.len() {
                    handler.state[idx] = value;
                }
            }

            let resume_ip = handler.resume_ip;
            let resume_frame_idx = handler.resume_frame_idx;
            let resume_stack_height = handler.resume_stack_height;

            // Unwind all frames above and including the handler body frame.
            while self.frames.len() > body_frame_idx {
                let base = self.frames.last().unwrap().stack_base;
                self.stack.truncate(base);
                self.frames.pop();
            }

            // Restore stack to the perform site's height.
            self.stack.truncate(resume_stack_height);

            // Push resume value — this becomes the Perform expression's result.
            self.stack.push(resume_value);

            // Set IP in the performing frame to continue from after Perform.
            self.frames[resume_frame_idx].ip = resume_ip;

            Ok(())
        } else {
            let line = self.frames.last().map(|f| f.current_line()).unwrap_or(0);
            Err(VmError::new("resume outside of handler dispatch", line))
        }
    }

    /// Search the handler stack (top-down) for a handler matching `op_name`.
    /// Returns `(handler_stack_idx, entry_idx)`.
    fn find_handler(&self, op_name: &str) -> Option<(usize, usize)> {
        for (h_idx, frame) in self.handler_stack.iter().enumerate().rev() {
            for (e_idx, entry) in frame.entries.iter().enumerate() {
                if entry.op_name == op_name {
                    return Some((h_idx, e_idx));
                }
            }
        }
        None
    }

    /// Resolve handler table entries from the current chunk.
    fn resolve_handler_entries(
        &self,
        frame_idx: usize,
        table_idx: usize,
    ) -> Result<Vec<VmHandlerEntry>, VmError> {
        let chunk = &self.frames[frame_idx].proto.chunk;
        let table = chunk.handler_tables.get(table_idx).ok_or_else(|| {
            VmError::new(
                format!("invalid handler table index: {table_idx}"),
                self.frames[frame_idx].current_line(),
            )
        })?;

        let mut entries = Vec::with_capacity(table.entries.len());
        for entry in &table.entries {
            let op_name = chunk
                .names
                .get(entry.op_name_idx as usize)
                .cloned()
                .unwrap_or_default();

            let proto = match chunk.constants.get(entry.proto_idx as usize) {
                Some(Constant::FnProto(p)) => p.clone(),
                _ => {
                    return Err(VmError::new(
                        "invalid handler proto constant",
                        self.frames[frame_idx].current_line(),
                    ));
                }
            };

            entries.push(VmHandlerEntry {
                op_name,
                proto,
                param_count: entry.param_count,
            });
        }

        Ok(entries)
    }

    /// Push a call frame for a handler body FnProto.
    ///
    /// The handler body's parameters are: `[effect_args..., state_vars...]`.
    fn dispatch_handler_body(
        &mut self,
        proto: Arc<FnProto>,
        args: &[VmValue],
        state: &[VmValue],
    ) -> Result<(), VmError> {
        let stack_base = self.stack.len();

        // Push effect args.
        for arg in args {
            self.stack.push(arg.clone());
        }

        // Push state values.
        for s in state {
            self.stack.push(s.clone());
        }

        // Push extra locals (beyond params).
        let total_params = args.len() + state.len();
        let extra = proto.local_count as usize - total_params.min(proto.local_count as usize);
        for _ in 0..extra {
            self.stack.push(VmValue::Unit);
        }

        self.frames.push(CallFrame {
            proto,
            upvalues: Vec::new(),
            ip: 0,
            stack_base,
            has_func_slot: false, // handler body, no function value below
        });

        Ok(())
    }
}
