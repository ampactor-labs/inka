//! Refinement type solver — decides predicates at compile time.
//!
//! Phase 6C: When a known literal value flows into a refined type position,
//! the solver evaluates the predicate by substituting `self` with the literal
//! and reducing. This is the simplest useful solver — literal substitution
//! + boolean evaluation. Full Fourier-Motzkin variable elimination comes
//!   later when we have multi-variable predicates.
//!
//! Design: the solver interface is `check_refinement(predicate, known_value) -> SolverResult`.
//! Conceptually this is a handler for `prove(predicate, context) -> ProofResult` —
//! when the self-hosted compiler takes over, it becomes a literal effect handler.

use crate::ast::{BinOp, Expr, UnaryOp};

/// Result of attempting to verify a refinement predicate.
#[derive(Debug, Clone, PartialEq)]
pub enum SolverResult {
    /// Predicate provably holds for the given value.
    Proven,
    /// Predicate provably fails for the given value.
    Disproven(String), // reason
    /// Outside the decidable fragment — defer to runtime.
    Unknown,
}

/// A concrete value for substitution.
#[derive(Debug, Clone)]
pub enum LitValue {
    Int(i64),
    Float(f64),
}

/// Check a refinement predicate against a known literal value.
///
/// Substitutes `self` with the literal in the predicate expression,
/// then evaluates the resulting boolean expression.
pub fn check_refinement(predicate: &Expr, known_value: Option<&LitValue>) -> SolverResult {
    let Some(value) = known_value else {
        return SolverResult::Unknown;
    };

    // Evaluate the predicate with self = value
    match eval_pred(predicate, value) {
        Some(true) => SolverResult::Proven,
        Some(false) => {
            let reason = format!(
                "value {} violates predicate",
                match value {
                    LitValue::Int(n) => format!("{n}"),
                    LitValue::Float(f) => format!("{f}"),
                }
            );
            SolverResult::Disproven(reason)
        }
        None => SolverResult::Unknown,
    }
}

/// Evaluate a predicate expression with `self` bound to a known value.
/// Returns Some(bool) if fully reducible, None if unknown.
fn eval_pred(expr: &Expr, self_val: &LitValue) -> Option<bool> {
    match expr {
        // Boolean operators
        Expr::BinOp {
            op: BinOp::And,
            left,
            right,
            ..
        } => {
            let l = eval_pred(left, self_val)?;
            let r = eval_pred(right, self_val)?;
            Some(l && r)
        }
        Expr::BinOp {
            op: BinOp::Or,
            left,
            right,
            ..
        } => {
            let l = eval_pred(left, self_val)?;
            let r = eval_pred(right, self_val)?;
            Some(l || r)
        }
        Expr::UnaryOp {
            op: UnaryOp::Not,
            operand,
            ..
        } => {
            let v = eval_pred(operand, self_val)?;
            Some(!v)
        }
        // Comparison operators — evaluate both sides as numbers
        Expr::BinOp {
            op, left, right, ..
        } if is_comparison(op) => {
            let l = eval_numeric(left, self_val)?;
            let r = eval_numeric(right, self_val)?;
            Some(compare_f64(op, l, r))
        }
        // Boolean literals
        Expr::BoolLit(b, _) => Some(*b),
        _ => None,
    }
}

/// Evaluate a numeric expression with `self` bound to a known value.
/// Returns Some(f64) if fully reducible, None if unknown.
fn eval_numeric(expr: &Expr, self_val: &LitValue) -> Option<f64> {
    match expr {
        // `self` — the refined value
        Expr::Var(name, _) if name == "self" => Some(lit_to_f64(self_val)),
        // Literals
        Expr::IntLit(n, _) => Some(*n as f64),
        Expr::FloatLit(f, _) => Some(*f),
        // Unary negation
        Expr::UnaryOp {
            op: UnaryOp::Neg,
            operand,
            ..
        } => {
            let v = eval_numeric(operand, self_val)?;
            Some(-v)
        }
        // Binary arithmetic
        Expr::BinOp {
            op, left, right, ..
        } if is_arithmetic(op) => {
            let l = eval_numeric(left, self_val)?;
            let r = eval_numeric(right, self_val)?;
            Some(arithmetic_f64(op, l, r))
        }
        _ => None,
    }
}

fn lit_to_f64(v: &LitValue) -> f64 {
    match v {
        LitValue::Int(n) => *n as f64,
        LitValue::Float(f) => *f,
    }
}

fn is_comparison(op: &BinOp) -> bool {
    matches!(
        op,
        BinOp::Lt | BinOp::LtEq | BinOp::Gt | BinOp::GtEq | BinOp::Eq | BinOp::Neq
    )
}

fn is_arithmetic(op: &BinOp) -> bool {
    matches!(
        op,
        BinOp::Add | BinOp::Sub | BinOp::Mul | BinOp::Div | BinOp::Mod
    )
}

fn compare_f64(op: &BinOp, l: f64, r: f64) -> bool {
    match op {
        BinOp::Lt => l < r,
        BinOp::LtEq => l <= r,
        BinOp::Gt => l > r,
        BinOp::GtEq => l >= r,
        BinOp::Eq => (l - r).abs() < f64::EPSILON,
        BinOp::Neq => (l - r).abs() >= f64::EPSILON,
        _ => false,
    }
}

fn arithmetic_f64(op: &BinOp, l: f64, r: f64) -> f64 {
    match op {
        BinOp::Add => l + r,
        BinOp::Sub => l - r,
        BinOp::Mul => l * r,
        BinOp::Div => {
            if r != 0.0 {
                l / r
            } else {
                f64::NAN
            }
        }
        BinOp::Mod => {
            if r != 0.0 {
                l % r
            } else {
                f64::NAN
            }
        }
        _ => f64::NAN,
    }
}
