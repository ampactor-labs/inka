//! Pattern matching for the Lux interpreter.
//!
//! Self-contained recursive function for matching values against patterns.

use std::collections::HashMap;

use crate::ast::{LitPattern, Pattern};
use crate::interpreter::Value;

/// Try to match a value against a pattern, populating bindings on success.
pub fn match_pattern(
    pattern: &Pattern,
    value: &Value,
    bindings: &mut HashMap<String, Value>,
) -> bool {
    match pattern {
        Pattern::Wildcard(_) => true,
        Pattern::Binding(name, _) => {
            bindings.insert(name.clone(), value.clone());
            true
        }
        Pattern::Literal(lit, _) => match (lit, value) {
            (LitPattern::Int(a), Value::Int(b)) => a == b,
            (LitPattern::Float(a), Value::Float(b)) => a == b,
            (LitPattern::String(a), Value::String(b)) => a == b,
            (LitPattern::Bool(a), Value::Bool(b)) => a == b,
            _ => false,
        },
        Pattern::Variant {
            name, fields: pats, ..
        } => match value {
            Value::AdtVariant {
                name: vname,
                fields,
            } => {
                if name != vname || pats.len() != fields.len() {
                    return false;
                }
                pats.iter()
                    .zip(fields.iter())
                    .all(|(p, v)| match_pattern(p, v, bindings))
            }
            _ if pats.is_empty() => {
                matches!(value, Value::AdtVariant { name: vn, fields } if vn == name && fields.is_empty())
            }
            _ => false,
        },
        Pattern::Tuple(pats, _) => {
            let vs = match value {
                Value::Tuple(vs) | Value::List(vs) => vs,
                _ => return false,
            };
            if pats.len() != vs.len() {
                return false;
            }
            pats.iter()
                .zip(vs.iter())
                .all(|(p, v)| match_pattern(p, v, bindings))
        }
        Pattern::Record { name, fields, .. } => match value {
            Value::AdtVariant {
                name: vname,
                fields: vfields,
            } => {
                if name != vname {
                    return false;
                }
                // For record patterns, fields are (field_name, pattern) pairs.
                // We need the variant definition to map names to indices.
                // Since we don't have the def here, we use the convention that
                // the fields vec in the pattern lines up with the runtime fields
                // by index (resolved during checking/construction).
                // The caller must provide a pre-resolved pattern where field indices
                // match positional fields.
                for (_, sub_pat) in fields {
                    // This will be resolved via field_indices stored during checking
                    // For now, fall through to positional matching
                    let _ = sub_pat;
                }
                // Fallback: match positionally (caller resolves field order)
                if fields.len() != vfields.len() {
                    return false;
                }
                fields
                    .iter()
                    .zip(vfields.iter())
                    .all(|((_, p), v)| match_pattern(p, v, bindings))
            }
            _ => false,
        },
        Pattern::List { elements, rest, .. } => match value {
            Value::List(items) => {
                if let Some(_rest_pat) = rest {
                    // [a, b, ...rest] — need at least `elements.len()` items
                    if items.len() < elements.len() {
                        return false;
                    }
                    for (pat, val) in elements.iter().zip(items.iter()) {
                        if !match_pattern(pat, val, bindings) {
                            return false;
                        }
                    }
                    let remaining = Value::List(items[elements.len()..].to_vec());
                    match_pattern(_rest_pat, &remaining, bindings)
                } else {
                    // [a, b, c] — exact length match
                    if items.len() != elements.len() {
                        return false;
                    }
                    elements
                        .iter()
                        .zip(items.iter())
                        .all(|(p, v)| match_pattern(p, v, bindings))
                }
            }
            _ => false,
        },
        Pattern::Or(alternatives, _) => {
            for alt in alternatives {
                let mut alt_bindings = HashMap::new();
                if match_pattern(alt, value, &mut alt_bindings) {
                    bindings.extend(alt_bindings);
                    return true;
                }
            }
            false
        }
    }
}
