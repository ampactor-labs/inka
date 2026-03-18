#![allow(clippy::result_large_err)]

use std::env;
use std::fs;
use std::process;
use std::sync::Arc;

fn main() {
    let args: Vec<String> = env::args().collect();

    // Check for --interpret flag
    let use_interpreter = args.iter().any(|a| a == "--interpret");
    let file_args: Vec<&str> = args
        .iter()
        .skip(1)
        .filter(|a| !a.starts_with("--"))
        .map(|s| s.as_str())
        .collect();

    match file_args.len() {
        0 => {
            // No arguments — start REPL
            println!("Lux 0.1.0 — A language of light\n");
            if let Err(e) = lux::repl::run() {
                eprintln!("REPL error: {e}");
                process::exit(1);
            }
        }
        1 if file_args[0] == "repl" => {
            println!("Lux 0.1.0 — A language of light\n");
            if let Err(e) = lux::repl::run() {
                eprintln!("REPL error: {e}");
                process::exit(1);
            }
        }
        1 => {
            // One argument — run file
            let path = file_args[0];
            let source = match fs::read_to_string(path) {
                Ok(s) => s,
                Err(e) => {
                    eprintln!("error: could not read '{path}': {e}");
                    process::exit(1);
                }
            };
            let result = if use_interpreter {
                run_source_interpret(&source)
            } else {
                run_source_vm(&source)
            };
            if let Err(e) = result {
                eprintln!(
                    "{}",
                    lux::error::format_error_with_source(&e, &source, Some(path))
                );
                process::exit(1);
            }
        }
        _ => {
            eprintln!("Usage: lux [--interpret] [file.lux | repl]");
            process::exit(1);
        }
    }
}

fn run_source_interpret(source: &str) -> Result<(), lux::error::LuxError> {
    let mut checker = lux::checker::ReplChecker::new();
    let mut interpreter = lux::interpreter::Interpreter::new();

    // Load prelude: check and execute it first, then freeze the type env.
    // Freezing applies all substitutions and clears type variable maps so
    // that polymorphic prelude functions don't compound the type-checker
    // complexity when checking user code.
    let prelude = lux::load_prelude();
    if !prelude.is_empty() {
        let tokens = lux::lexer::lex(&prelude)?;
        let program = lux::parser::parse(tokens)?;
        let _ = checker.check_line(&program); // best-effort; prelude is trusted
        checker.freeze();
        interpreter.eval_line(&program)?;
    }

    let tokens = lux::lexer::lex(source)?;
    let program = lux::parser::parse(tokens)?;
    checker.check_line(&program)?;
    let result = interpreter.eval_line(&program)?;
    if let Some(val) = result {
        println!("{val}");
    }
    Ok(())
}

fn run_source_vm(source: &str) -> Result<(), lux::error::LuxError> {
    let mut checker = lux::checker::ReplChecker::new();

    // Load and check prelude.
    let prelude = lux::load_prelude();
    let mut prelude_program = None;
    if !prelude.is_empty() {
        let tokens = lux::lexer::lex(&prelude)?;
        let program = lux::parser::parse(tokens)?;
        let _ = checker.check_line(&program);
        checker.freeze();
        prelude_program = Some(program);
    }

    let tokens = lux::lexer::lex(source)?;
    let program = lux::parser::parse(tokens)?;
    checker.check_line(&program)?;

    // Compile: prepend prelude items to the user program.
    let mut combined = lux::ast::Program { items: Vec::new() };
    if let Some(prelude) = prelude_program {
        combined.items.extend(prelude.items);
    }
    combined.items.extend(program.items);

    let proto = lux::compiler::compile(&combined)?;
    let mut vm = lux::vm::vm::Vm::new();
    let result = vm.run(Arc::new(proto)).map_err(|e| {
        lux::error::LuxError::Runtime(lux::error::RuntimeError {
            kind: lux::error::RuntimeErrorKind::TypeError(e.message),
            span: lux::token::Span {
                line: e.line as usize,
                column: 0,
                start: 0,
                end: 0,
            },
        })
    })?;

    // Don't print the final value — file execution uses println for output.
    // (REPL would print it, but that's a different path.)
    let _ = result;
    Ok(())
}
