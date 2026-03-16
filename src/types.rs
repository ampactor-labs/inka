/// Internal type representation for the Lux type checker.
///
/// These are the types the checker works with — distinct from `ast::TypeExpr`
/// which represents what the programmer wrote.
use std::collections::{BTreeSet, HashMap};
use std::fmt;

/// A unique identifier for type variables during inference.
#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash)]
pub struct TypeVar(pub u32);

/// The internal representation of Lux types.
#[derive(Debug, Clone, PartialEq)]
pub enum Type {
    /// Primitive types
    Int,
    Float,
    String,
    Bool,
    Unit,
    /// The bottom type — `Never` (return type of `fail`)
    Never,

    /// A type variable (for inference)
    Var(TypeVar),

    /// Function type with effect annotation
    Function {
        params: Vec<Type>,
        return_type: Box<Type>,
        effects: EffectSet,
    },

    /// An algebraic data type (after resolution)
    Adt {
        name: String,
        type_args: Vec<Type>,
    },

    /// List type
    List(Box<Type>),

    /// Tuple type
    Tuple(Vec<Type>),

    /// An error placeholder (allows type checking to continue after errors)
    Error,
}

impl Type {
    /// Check if this type is a concrete (non-variable, non-error) type.
    pub fn is_concrete(&self) -> bool {
        match self {
            Type::Var(_) | Type::Error => false,
            Type::Function {
                params,
                return_type,
                ..
            } => params.iter().all(|p| p.is_concrete()) && return_type.is_concrete(),
            Type::List(inner) => inner.is_concrete(),
            Type::Tuple(elems) => elems.iter().all(|e| e.is_concrete()),
            Type::Adt { type_args, .. } => type_args.iter().all(|a| a.is_concrete()),
            _ => true,
        }
    }

    /// Substitute type variables using a mapping.
    pub fn substitute(&self, subst: &HashMap<TypeVar, Type>) -> Type {
        match self {
            Type::Var(v) => subst.get(v).cloned().unwrap_or_else(|| self.clone()),
            Type::Function {
                params,
                return_type,
                effects,
            } => Type::Function {
                params: params.iter().map(|p| p.substitute(subst)).collect(),
                return_type: Box::new(return_type.substitute(subst)),
                effects: effects.clone(),
            },
            Type::List(inner) => Type::List(Box::new(inner.substitute(subst))),
            Type::Tuple(elems) => Type::Tuple(elems.iter().map(|e| e.substitute(subst)).collect()),
            Type::Adt { name, type_args } => Type::Adt {
                name: name.clone(),
                type_args: type_args.iter().map(|a| a.substitute(subst)).collect(),
            },
            _ => self.clone(),
        }
    }
}

impl fmt::Display for Type {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        match self {
            Type::Int => write!(f, "Int"),
            Type::Float => write!(f, "Float"),
            Type::String => write!(f, "String"),
            Type::Bool => write!(f, "Bool"),
            Type::Unit => write!(f, "()"),
            Type::Never => write!(f, "Never"),
            Type::Var(TypeVar(id)) => write!(f, "?{id}"),
            Type::Function {
                params,
                return_type,
                effects,
            } => {
                write!(f, "(")?;
                for (i, p) in params.iter().enumerate() {
                    if i > 0 {
                        write!(f, ", ")?;
                    }
                    write!(f, "{p}")?;
                }
                write!(f, ") -> {return_type}")?;
                if !effects.is_pure() {
                    write!(f, " with {effects}")?;
                }
                Ok(())
            }
            Type::Adt { name, type_args } => {
                write!(f, "{name}")?;
                if !type_args.is_empty() {
                    write!(f, "<")?;
                    for (i, a) in type_args.iter().enumerate() {
                        if i > 0 {
                            write!(f, ", ")?;
                        }
                        write!(f, "{a}")?;
                    }
                    write!(f, ">")?;
                }
                Ok(())
            }
            Type::List(inner) => write!(f, "List<{inner}>"),
            Type::Tuple(elems) => {
                write!(f, "(")?;
                for (i, e) in elems.iter().enumerate() {
                    if i > 0 {
                        write!(f, ", ")?;
                    }
                    write!(f, "{e}")?;
                }
                write!(f, ")")
            }
            Type::Error => write!(f, "<error>"),
        }
    }
}

// ── Effects ───────────────────────────────────────────────────

/// A set of effects that a computation may perform.
#[derive(Debug, Clone, PartialEq)]
pub struct EffectSet {
    pub effects: BTreeSet<EffectName>,
}

/// A named effect, possibly with type arguments.
#[derive(Debug, Clone, PartialEq, Eq, PartialOrd, Ord, Hash)]
pub struct EffectName {
    pub name: String,
    // Type args omitted for MVP — effects are identified by name only
}

impl EffectSet {
    pub fn pure() -> Self {
        Self {
            effects: BTreeSet::new(),
        }
    }

    pub fn single(name: impl Into<String>) -> Self {
        let mut effects = BTreeSet::new();
        effects.insert(EffectName { name: name.into() });
        Self { effects }
    }

    pub fn is_pure(&self) -> bool {
        self.effects.is_empty()
    }

    pub fn union(&self, other: &EffectSet) -> EffectSet {
        EffectSet {
            effects: self.effects.union(&other.effects).cloned().collect(),
        }
    }

    pub fn contains(&self, name: &str) -> bool {
        self.effects.iter().any(|e| e.name == name)
    }

    pub fn insert(&mut self, name: impl Into<String>) {
        self.effects.insert(EffectName { name: name.into() });
    }
}

impl fmt::Display for EffectSet {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        if self.is_pure() {
            write!(f, "Pure")
        } else {
            let names: Vec<&str> = self.effects.iter().map(|e| e.name.as_str()).collect();
            write!(f, "{}", names.join(", "))
        }
    }
}

// ── Effect Declaration (resolved) ─────────────────────────────

/// A resolved effect declaration stored in the type environment.
#[derive(Debug, Clone)]
pub struct EffectDef {
    pub name: String,
    pub operations: Vec<EffectOpDef>,
}

/// A resolved effect operation.
#[derive(Debug, Clone)]
pub struct EffectOpDef {
    pub name: String,
    pub param_types: Vec<Type>,
    pub return_type: Type,
}

// ── ADT Definition (resolved) ─────────────────────────────────

/// A resolved algebraic data type definition.
#[derive(Debug, Clone)]
pub struct AdtDef {
    pub name: String,
    pub type_params: Vec<String>,
    pub variants: Vec<VariantDef>,
}

/// A resolved ADT variant.
#[derive(Debug, Clone)]
pub struct VariantDef {
    pub name: String,
    pub fields: Vec<Type>,
}
