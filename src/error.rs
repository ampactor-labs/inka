/// Error types and pretty-printing for Lux.

use crate::token::Span;
use crate::types::Type;
use std::fmt;

/// All errors that can occur in Lux compilation / interpretation.
#[derive(Debug, Clone)]
pub enum LuxError {
    Lexer(LexError),
    Parser(ParseError),
    Type(TypeError),
    Runtime(RuntimeError),
}

// ── Lexer errors ──────────────────────────────────────────────

#[derive(Debug, Clone)]
pub struct LexError {
    pub kind: LexErrorKind,
    pub span: Span,
}

#[derive(Debug, Clone)]
pub enum LexErrorKind {
    UnexpectedChar(char),
    UnterminatedString,
    InvalidNumber(String),
    InvalidEscape(char),
}

// ── Parser errors ─────────────────────────────────────────────

#[derive(Debug, Clone)]
pub struct ParseError {
    pub kind: ParseErrorKind,
    pub span: Span,
}

#[derive(Debug, Clone)]
pub enum ParseErrorKind {
    UnexpectedToken { expected: String, found: String },
    UnexpectedEof,
    InvalidPattern,
    InvalidTypeExpr,
    InvalidExpression,
}

// ── Type errors ───────────────────────────────────────────────

#[derive(Debug, Clone)]
pub struct TypeError {
    pub kind: TypeErrorKind,
    pub span: Span,
}

#[derive(Debug, Clone)]
pub enum TypeErrorKind {
    Mismatch { expected: Type, found: Type },
    UnboundVariable(String),
    UnboundType(String),
    UnboundEffect(String),
    UnboundEffectOp(String),
    NotAFunction(Type),
    WrongArity { expected: usize, found: usize },
    UnhandledEffect(String),
    InfiniteType,
    NonExhaustiveMatch,
    DuplicateDefinition(String),
}

// ── Runtime errors ────────────────────────────────────────────

#[derive(Debug, Clone)]
pub struct RuntimeError {
    pub kind: RuntimeErrorKind,
    pub span: Span,
}

#[derive(Debug, Clone)]
pub enum RuntimeErrorKind {
    DivisionByZero,
    IndexOutOfBounds { index: i64, length: usize },
    TypeError(String),
    UnhandledEffect { effect: String, operation: String },
    MatchFailed,
    StackOverflow,
    /// User-triggered failure via the Fail effect
    UserFail(String),
    /// Internal: should not happen
    Internal(String),
}

// ── Display implementations ───────────────────────────────────

impl fmt::Display for LuxError {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        match self {
            LuxError::Lexer(e) => write!(f, "{e}"),
            LuxError::Parser(e) => write!(f, "{e}"),
            LuxError::Type(e) => write!(f, "{e}"),
            LuxError::Runtime(e) => write!(f, "{e}"),
        }
    }
}

impl fmt::Display for LexError {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        match &self.kind {
            LexErrorKind::UnexpectedChar(c) => {
                write!(f, "unexpected character '{c}' at line {}", self.span.line)
            }
            LexErrorKind::UnterminatedString => {
                write!(f, "unterminated string at line {}", self.span.line)
            }
            LexErrorKind::InvalidNumber(s) => {
                write!(f, "invalid number '{s}' at line {}", self.span.line)
            }
            LexErrorKind::InvalidEscape(c) => {
                write!(f, "invalid escape '\\{c}' at line {}", self.span.line)
            }
        }
    }
}

impl fmt::Display for ParseError {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        match &self.kind {
            ParseErrorKind::UnexpectedToken { expected, found } => {
                write!(
                    f,
                    "expected {expected}, found {found} at line {}",
                    self.span.line
                )
            }
            ParseErrorKind::UnexpectedEof => write!(f, "unexpected end of file"),
            ParseErrorKind::InvalidPattern => {
                write!(f, "invalid pattern at line {}", self.span.line)
            }
            ParseErrorKind::InvalidTypeExpr => {
                write!(f, "invalid type expression at line {}", self.span.line)
            }
            ParseErrorKind::InvalidExpression => {
                write!(f, "invalid expression at line {}", self.span.line)
            }
        }
    }
}

impl fmt::Display for TypeError {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        match &self.kind {
            TypeErrorKind::Mismatch { expected, found } => {
                write!(
                    f,
                    "type mismatch: expected {expected}, found {found} at line {}",
                    self.span.line
                )
            }
            TypeErrorKind::UnboundVariable(name) => {
                write!(f, "unbound variable '{name}' at line {}", self.span.line)
            }
            TypeErrorKind::UnboundType(name) => {
                write!(f, "unknown type '{name}' at line {}", self.span.line)
            }
            TypeErrorKind::UnboundEffect(name) => {
                write!(f, "unknown effect '{name}' at line {}", self.span.line)
            }
            TypeErrorKind::UnboundEffectOp(name) => {
                write!(
                    f,
                    "unknown effect operation '{name}' at line {}",
                    self.span.line
                )
            }
            TypeErrorKind::NotAFunction(ty) => {
                write!(
                    f,
                    "expected a function, found {ty} at line {}",
                    self.span.line
                )
            }
            TypeErrorKind::WrongArity { expected, found } => {
                write!(
                    f,
                    "wrong number of arguments: expected {expected}, found {found} at line {}",
                    self.span.line
                )
            }
            TypeErrorKind::UnhandledEffect(name) => {
                write!(
                    f,
                    "unhandled effect '{name}' at line {}",
                    self.span.line
                )
            }
            TypeErrorKind::InfiniteType => {
                write!(f, "infinite type at line {}", self.span.line)
            }
            TypeErrorKind::NonExhaustiveMatch => {
                write!(f, "non-exhaustive match at line {}", self.span.line)
            }
            TypeErrorKind::DuplicateDefinition(name) => {
                write!(
                    f,
                    "duplicate definition '{name}' at line {}",
                    self.span.line
                )
            }
        }
    }
}

impl fmt::Display for RuntimeError {
    fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::Result {
        match &self.kind {
            RuntimeErrorKind::DivisionByZero => write!(f, "division by zero"),
            RuntimeErrorKind::IndexOutOfBounds { index, length } => {
                write!(f, "index {index} out of bounds (length {length})")
            }
            RuntimeErrorKind::TypeError(msg) => write!(f, "runtime type error: {msg}"),
            RuntimeErrorKind::UnhandledEffect { effect, operation } => {
                write!(f, "unhandled effect: {effect}.{operation}")
            }
            RuntimeErrorKind::MatchFailed => write!(f, "match failed: no pattern matched"),
            RuntimeErrorKind::StackOverflow => write!(f, "stack overflow"),
            RuntimeErrorKind::UserFail(msg) => write!(f, "fail: {msg}"),
            RuntimeErrorKind::Internal(msg) => write!(f, "internal error: {msg}"),
        }
    }
}

impl std::error::Error for LuxError {}

// ── Conversions ───────────────────────────────────────────────

impl From<LexError> for LuxError {
    fn from(e: LexError) -> Self {
        LuxError::Lexer(e)
    }
}

impl From<ParseError> for LuxError {
    fn from(e: ParseError) -> Self {
        LuxError::Parser(e)
    }
}

impl From<TypeError> for LuxError {
    fn from(e: TypeError) -> Self {
        LuxError::Type(e)
    }
}

impl From<RuntimeError> for LuxError {
    fn from(e: RuntimeError) -> Self {
        LuxError::Runtime(e)
    }
}
