#![allow(clippy::result_large_err, clippy::collapsible_if)]

pub mod ast;
pub mod checker;
pub mod env;
pub mod error;
pub mod interpreter;
pub mod lexer;
pub mod parser;
pub mod repl;
pub mod token;
pub mod types;
