/// Item registration (first pass) and checking (second pass).
use crate::ast::{
    EffectDecl, FnDecl, HandlerDecl, HandlerOp, ImplBlock, Item, LetDecl, TraitDecl, TypeDecl,
};
use crate::error::{CompilerHint, HintKind, HintSuggestion, TypeError, TypeErrorKind};
use crate::types::{AdtDef, EffectDef, EffectOpDef, EffectRow, Type, VariantDef};

use super::{OpInfo, TypeEnv, type_expr_to_name};

#[allow(clippy::result_large_err)]
impl TypeEnv {
    // ── Registration (first pass) ─────────────────────────────

    pub(crate) fn register_type_decl(&mut self, td: &TypeDecl) -> Result<(), TypeError> {
        let mut variants = Vec::new();
        for (i, v) in td.variants.iter().enumerate() {
            let fields: Vec<(String, Type)> = v
                .fields
                .iter()
                .enumerate()
                .map(|(idx, f)| {
                    let name = f.name.clone().unwrap_or_else(|| format!("_{idx}"));
                    let ty = self.resolve_type_expr(&f.ty).unwrap_or(Type::Error);
                    (name, ty)
                })
                .collect();
            variants.push(VariantDef {
                name: v.name.clone(),
                fields,
            });
            self.constructors
                .insert(v.name.clone(), (td.name.clone(), i));
        }
        self.adts.insert(
            td.name.clone(),
            AdtDef {
                name: td.name.clone(),
                type_params: td.type_params.clone(),
                variants,
            },
        );
        Ok(())
    }

    pub(crate) fn register_effect_decl(&mut self, ed: &EffectDecl) -> Result<(), TypeError> {
        let mut ops = Vec::new();
        for op in &ed.operations {
            let param_types: Vec<Type> = op
                .params
                .iter()
                .map(|p| {
                    p.type_ann
                        .as_ref()
                        .map(|t| self.resolve_type_expr(t).unwrap_or(Type::Error))
                        .unwrap_or_else(|| self.fresh_var())
                })
                .collect();
            let return_type = self
                .resolve_type_expr(&op.return_type)
                .unwrap_or(Type::Error);

            self.op_index.insert(
                op.name.clone(),
                OpInfo {
                    effect_name: ed.name.clone(),
                    param_types: param_types.clone(),
                    return_type: return_type.clone(),
                },
            );

            ops.push(EffectOpDef {
                name: op.name.clone(),
                param_types,
                return_type,
            });
        }
        self.effects.insert(
            ed.name.clone(),
            EffectDef {
                name: ed.name.clone(),
                operations: ops,
            },
        );
        Ok(())
    }

    pub(crate) fn register_trait_decl(&mut self, td: &TraitDecl) -> Result<(), TypeError> {
        let mut methods = Vec::new();
        for m in &td.methods {
            let param_types: Vec<Type> = m
                .params
                .iter()
                .map(|p| {
                    p.type_ann
                        .as_ref()
                        .map(|t| self.resolve_type_expr(t).unwrap_or(Type::Error))
                        .unwrap_or_else(|| self.fresh_var())
                })
                .collect();
            let return_type = m
                .return_type
                .as_ref()
                .map(|t| self.resolve_type_expr(t).unwrap_or(Type::Error))
                .unwrap_or(Type::Unit);
            methods.push((m.name.clone(), param_types, return_type));
        }
        self.traits.insert(td.name.clone(), methods);
        Ok(())
    }

    pub(crate) fn register_impl_block(&mut self, ib: &ImplBlock) -> Result<(), TypeError> {
        let type_name = type_expr_to_name(&ib.target_type);
        for method in &ib.methods {
            let mut param_types = Vec::new();
            for p in &method.params {
                let ty = p
                    .type_ann
                    .as_ref()
                    .map(|t| self.resolve_type_expr(t).unwrap_or(Type::Error))
                    .unwrap_or_else(|| self.fresh_var());
                param_types.push(ty);
            }
            let return_type = method
                .return_type
                .as_ref()
                .map(|t| self.resolve_type_expr(t).unwrap_or(Type::Error))
                .unwrap_or(Type::Unit);
            let fn_type = Type::Function {
                params: param_types,
                return_type: Box::new(return_type),
                effects: EffectRow::pure(),
            };
            self.impl_methods
                .insert((type_name.clone(), method.name.clone()), fn_type);
        }
        Ok(())
    }

    // ── Item checking (second pass) ───────────────────────────

    pub(crate) fn check_item(&mut self, item: &Item) -> Result<(), TypeError> {
        match item {
            Item::FnDecl(fd) => self.check_fn_decl(fd),
            Item::LetDecl(ld) => self.check_let_decl(ld),
            Item::TypeDecl(_) | Item::EffectDecl(_) => Ok(()), // already registered
            Item::TraitDecl(_) | Item::ImplBlock(_) => Ok(()), // already registered in first pass
            Item::Import(_) => Ok(()),                         // resolved before checking
            Item::HandlerDecl(hd) => self.check_handler_decl(hd),
            Item::Expr(e) => {
                self.infer_expr(e)?;
                Ok(())
            }
        }
    }

    pub(crate) fn check_handler_decl(&mut self, hd: &HandlerDecl) -> Result<(), TypeError> {
        // Verify base handler exists if specified
        if let Some(base_name) = &hd.base {
            if !self.handler_decls.contains_key(base_name) {
                return Err(TypeError {
                    kind: TypeErrorKind::UnboundVariable(base_name.clone()),
                    span: hd.span.clone(),
                });
            }
        }
        // Validate clauses: op names must be known, nested UseHandler refs must exist
        for clause in &hd.clauses {
            match &clause.operation {
                HandlerOp::OpHandler { op_name, .. } => {
                    if !self.op_index.contains_key(op_name) {
                        return Err(TypeError {
                            kind: TypeErrorKind::UnboundEffectOp(op_name.clone()),
                            span: clause.span.clone(),
                        });
                    }
                }
                HandlerOp::UseHandler { name } => {
                    if !self.handler_decls.contains_key(name) {
                        return Err(TypeError {
                            kind: TypeErrorKind::UnboundVariable(name.clone()),
                            span: clause.span.clone(),
                        });
                    }
                }
            }
        }
        Ok(())
    }

    pub(crate) fn check_fn_decl(&mut self, fd: &FnDecl) -> Result<(), TypeError> {
        let mut child = self.child();

        // Bind type parameters as fresh type variables
        for tp in &fd.type_params {
            let var = child.fresh_var();
            child.type_params.insert(tp.clone(), var);
        }

        let mut param_types = Vec::new();
        for p in &fd.params {
            let ty = if let Some(ann) = &p.type_ann {
                child.resolve_type_expr(ann)?
            } else {
                child.fresh_var()
            };
            child.bind(&p.name, ty.clone());
            param_types.push(ty);
        }

        // Pre-bind function name for recursion (with fresh return type var)
        let ret_var = child.fresh_var();

        // Separate positive effects from negation constraints / Pure.
        let has_pure = fd.effects.iter().any(|e| !e.negated && e.name == "Pure");
        let positive_effects: Vec<&crate::ast::EffectRef> = fd
            .effects
            .iter()
            .filter(|e| !e.negated && e.name != "Pure")
            .collect();

        // If effects are declared, use a closed row; otherwise open (polymorphic).
        // Negation-only constraints (no positive effects) leave the row open.
        let prelim_effects = if fd.effects.is_empty() {
            child.fresh_eff_var()
        } else if has_pure || !positive_effects.is_empty() {
            let mut closed = EffectRow::pure();
            for eff_ref in &positive_effects {
                closed.insert(&eff_ref.name);
            }
            closed
        } else {
            // Only negation constraints — keep row open (polymorphic)
            child.fresh_eff_var()
        };
        // Set declared effects for disambiguating effect ops vs bindings.
        // When a name exists as both (e.g. builtin `log` vs effect op `log`),
        // this determines which one wins during call resolution.
        if has_pure || !positive_effects.is_empty() {
            let mut declared = std::collections::BTreeSet::new();
            for eff_ref in &positive_effects {
                declared.insert(eff_ref.name.clone());
            }
            child.fn_declared_effects = Some(declared);
        }
        // else: fn_declared_effects stays None → effect ops always dispatch (polymorphic)

        let preliminary_fn_type = Type::Function {
            params: param_types.clone(),
            return_type: Box::new(ret_var.clone()),
            effects: prelim_effects.clone(),
        };
        child.bind(&fd.name, preliminary_fn_type);

        let (body_ty, body_effects) = child.infer_expr(&fd.body)?;
        child.unify(&ret_var, &body_ty, &fd.span)?;
        child.unify_effects(&prelim_effects, &body_effects, &fd.span)?;

        // Check return type annotation inside child scope (so type params are in scope)
        if let Some(ret_ann) = &fd.return_type {
            let ret_ty = child.resolve_type_expr(ret_ann)?;
            child.unify(&body_ty, &ret_ty, &fd.span)?;
        }

        self.merge_child(&child);

        // Check effect annotations
        if !fd.effects.is_empty() {
            // Positive effects: body effects must be a subset of declared
            if !positive_effects.is_empty() {
                let mut declared = EffectRow::pure();
                for eff_ref in &positive_effects {
                    declared.insert(&eff_ref.name);
                }
                for eff in body_effects.effects() {
                    if !declared.contains(&eff.name) {
                        return Err(TypeError {
                            kind: TypeErrorKind::UnhandledEffect(eff.name.clone()),
                            span: fd.span.clone(),
                        });
                    }
                }
            }

            // Pure constraint: body must have no effects
            if has_pure {
                if let Some(eff) = body_effects.effects().iter().next() {
                    return Err(TypeError {
                        kind: TypeErrorKind::EffectConstraintViolation {
                            effect: eff.name.clone(),
                            constraint: "Pure".to_string(),
                        },
                        span: fd.span.clone(),
                    });
                }
            }

            // Negation constraints: body must NOT contain negated effects
            for neg in fd.effects.iter().filter(|e| e.negated) {
                if body_effects.contains(&neg.name) {
                    return Err(TypeError {
                        kind: TypeErrorKind::EffectConstraintViolation {
                            effect: neg.name.clone(),
                            constraint: format!("!{}", neg.name),
                        },
                        span: fd.span.clone(),
                    });
                }
            }
        }

        let resolved_params: Vec<Type> = param_types.iter().map(|p| self.apply_subst(p)).collect();
        let resolved_ret = self.apply_subst(&body_ty);
        let resolved_effects = self.apply_eff_subst(&body_effects);

        let fn_type = Type::Function {
            params: resolved_params.clone(),
            return_type: Box::new(resolved_ret.clone()),
            effects: resolved_effects.clone(),
        };
        self.bind(&fd.name, fn_type);

        self.effect_routing
            .insert(fd.span.clone(), resolved_effects.clone());

        // Progressive teaching: emit hints for user's unannotated functions.
        let is_user_code = self.current_item_index >= self.import_item_count;
        if is_user_code && fd.effects.is_empty() && !fd.name.starts_with('_') {
            self.emit_fn_hint(fd, &resolved_params, &resolved_ret, &resolved_effects);
        }

        Ok(())
    }

    /// Emit a teaching hint for a function with unannotated effects.
    fn emit_fn_hint(&mut self, fd: &FnDecl, params: &[Type], ret: &Type, effects: &EffectRow) {
        // Map type variables to friendly names: a, b, c, ...
        let mut var_names: std::collections::HashMap<u32, char> = std::collections::HashMap::new();
        let mut next_letter = 'a';
        for ty in params.iter().chain(std::iter::once(ret)) {
            collect_type_vars(ty, &mut var_names, &mut next_letter);
        }

        let param_strs: Vec<String> = params
            .iter()
            .map(|p| friendly_type(p, &var_names))
            .collect();
        let ret_str = friendly_type(ret, &var_names);
        let effects_label = friendly_effects(effects);
        let inferred = format!(
            "({}) -> {} with {}",
            param_strs.join(", "),
            ret_str,
            effects_label,
        );

        let mut suggestions = Vec::new();

        if effects.is_pure() {
            suggestions.push(HintSuggestion {
                annotation: "with Pure".to_string(),
                unlocks: "parallelization, memoization, compile-time evaluation".to_string(),
            });
        } else {
            let eff_str = friendly_effects(effects);
            let unlocks = if matches!(effects, EffectRow::Open { .. }) {
                "effect polymorphism — callers can provide any handler".to_string()
            } else {
                "explicit effect tracking — callers see their dependencies".to_string()
            };
            suggestions.push(HintSuggestion {
                annotation: format!("with {eff_str}"),
                unlocks,
            });
        }

        self.hints.push(CompilerHint {
            kind: if effects.is_pure() {
                HintKind::PurityOpportunity
            } else {
                HintKind::EffectsUndeclared
            },
            fn_name: fd.name.clone(),
            span: fd.span.clone(),
            inferred,
            suggestions,
        });
    }

    pub(crate) fn check_let_decl(&mut self, ld: &LetDecl) -> Result<(), TypeError> {
        let (val_ty, _effects) = self.infer_expr(&ld.value)?;

        if let Some(ann) = &ld.type_ann {
            let ann_ty = self.resolve_type_expr(ann)?;
            self.unify(&val_ty, &ann_ty, &ld.span)?;
        }

        self.bind_pattern_types(&ld.pattern, &self.apply_subst(&val_ty), &ld.span)
    }
}

// ── Friendly type display for hints ────────────────────────────

/// Collect all type variable IDs in a type, assigning sequential letters.
fn collect_type_vars(
    ty: &Type,
    var_names: &mut std::collections::HashMap<u32, char>,
    next: &mut char,
) {
    match ty {
        Type::Var(crate::types::TypeVar(id)) => {
            var_names.entry(*id).or_insert_with(|| {
                let c = *next;
                *next = ((*next as u8) + 1) as char;
                c
            });
        }
        Type::Function {
            params,
            return_type,
            ..
        } => {
            for p in params {
                collect_type_vars(p, var_names, next);
            }
            collect_type_vars(return_type, var_names, next);
        }
        Type::List(inner) => collect_type_vars(inner, var_names, next),
        Type::Tuple(elems) => {
            for e in elems {
                collect_type_vars(e, var_names, next);
            }
        }
        Type::Adt { type_args, .. } => {
            for a in type_args {
                collect_type_vars(a, var_names, next);
            }
        }
        _ => {}
    }
}

/// Format a type using friendly variable names (a, b, c) instead of ?N.
fn friendly_type(ty: &Type, var_names: &std::collections::HashMap<u32, char>) -> String {
    match ty {
        Type::Var(crate::types::TypeVar(id)) => {
            if let Some(c) = var_names.get(id) {
                c.to_string()
            } else {
                format!("?{id}")
            }
        }
        Type::Error => "_".to_string(),
        Type::Function {
            params,
            return_type,
            effects,
        } => {
            let ps: Vec<String> = params.iter().map(|p| friendly_type(p, var_names)).collect();
            let ret = friendly_type(return_type, var_names);
            let mut s = format!("({}) -> {ret}", ps.join(", "));
            if !effects.is_pure() {
                s.push_str(&format!(" with {}", friendly_effects(effects)));
            }
            s
        }
        Type::List(inner) => format!("List<{}>", friendly_type(inner, var_names)),
        Type::Tuple(elems) => {
            let es: Vec<String> = elems.iter().map(|e| friendly_type(e, var_names)).collect();
            format!("({})", es.join(", "))
        }
        Type::Adt { name, type_args } if !type_args.is_empty() => {
            let args: Vec<String> = type_args
                .iter()
                .map(|a| friendly_type(a, var_names))
                .collect();
            format!("{name}<{}>", args.join(", "))
        }
        _ => format!("{ty}"),
    }
}

/// Format an effect row with friendly display (open rows show as "effects, ..."
/// instead of "effects, E0").
fn friendly_effects(row: &EffectRow) -> String {
    match row {
        EffectRow::Closed(s) if s.is_empty() => "Pure".to_string(),
        EffectRow::Closed(s) => {
            let names: Vec<&str> = s.iter().map(|e| e.name.as_str()).collect();
            names.join(", ")
        }
        EffectRow::Open { known, .. } => {
            if known.is_empty() {
                "...".to_string()
            } else {
                let names: Vec<&str> = known.iter().map(|e| e.name.as_str()).collect();
                format!("{}, ...", names.join(", "))
            }
        }
    }
}
