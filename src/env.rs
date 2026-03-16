/// Scoped environment for runtime value bindings.
///
/// Implements lexical scoping via a parent chain. Each scope holds its own
/// bindings and delegates lookups to its parent when a name is not found locally.
use std::collections::HashMap;

use crate::interpreter::Value;

/// A scoped environment mapping names to runtime values.
#[derive(Debug, Clone)]
pub struct Environment {
    bindings: HashMap<String, Value>,
    parent: Option<Box<Environment>>,
}

impl Environment {
    /// Create a new top-level environment with no parent.
    pub fn new() -> Self {
        Self {
            bindings: HashMap::new(),
            parent: None,
        }
    }

    /// Create a child environment that inherits from `parent`.
    pub fn with_parent(parent: Environment) -> Self {
        Self {
            bindings: HashMap::new(),
            parent: Some(Box::new(parent)),
        }
    }

    /// Look up a binding by name, searching parent scopes.
    pub fn get(&self, name: &str) -> Option<&Value> {
        self.bindings
            .get(name)
            .or_else(|| self.parent.as_ref().and_then(|p| p.get(name)))
    }

    /// Bind a name to a value in the current scope.
    pub fn set(&mut self, name: &str, value: Value) {
        self.bindings.insert(name.to_string(), value);
    }

    /// Flatten all visible bindings into a single scope (for closure capture).
    pub fn clone_flat(&self) -> Self {
        let mut flat = HashMap::new();
        self.collect_bindings(&mut flat);
        Self {
            bindings: flat,
            parent: None,
        }
    }

    fn collect_bindings(&self, out: &mut HashMap<String, Value>) {
        if let Some(parent) = &self.parent {
            parent.collect_bindings(out);
        }
        // Current scope wins over parent (inserted last).
        for (k, v) in &self.bindings {
            out.insert(k.clone(), v.clone());
        }
    }
}

impl Default for Environment {
    fn default() -> Self {
        Self::new()
    }
}
