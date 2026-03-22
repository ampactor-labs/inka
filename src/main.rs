#![allow(clippy::result_large_err)]

use std::env;
use std::fs;
use std::path::Path;
use std::process;
use std::sync::Arc;

fn main() {
    let args: Vec<String> = env::args().collect();

    // Flags: --teach is the default (Lux teaches by design)
    // Use --quiet to suppress teaching output.
    let quiet_mode = args.iter().any(|a| a == "--quiet");
    let teach_mode = !quiet_mode;
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
            let result = run_source(&source, path, teach_mode);
            if let Err(e) = result {
                eprintln!(
                    "{}",
                    lux::error::format_error_with_source(&e, &source, Some(path))
                );
                process::exit(1);
            }
        }
        _ => {
            eprintln!("Usage: lux [--quiet] [file.lux | repl]");
            process::exit(1);
        }
    }
}

fn run_source(source: &str, file_path: &str, teach: bool) -> Result<(), lux::error::LuxError> {
    let mut checker = lux::checker::ReplChecker::new();

    // Load and check prelude.
    let prelude = lux::load_prelude();
    let mut prelude_program = None;
    if !prelude.is_empty() {
        lux::token::CURRENT_FILE_ID.with(|id| id.set(lux::token::next_file_id()));
        let tokens = lux::lexer::lex(&prelude)?;
        let program = lux::parser::parse(tokens)?;
        let _ = checker.check_line(&program);
        checker.freeze();
        prelude_program = Some(program);
    }

    lux::token::CURRENT_FILE_ID.with(|id| id.set(lux::token::next_file_id()));
    let tokens = lux::lexer::lex(source)?;
    let program = lux::parser::parse(tokens)?;

    // Resolve imports before checking/compiling.
    let (base_dir, std_dir) = resolve_dirs(file_path);
    let (program, import_count) = lux::loader::resolve_imports(&program, &base_dir, &std_dir)?;

    checker.set_import_count(import_count);
    checker.check_line(&program)?;
    for (msg, span) in checker.take_warnings() {
        eprintln!(
            "warning: {msg}\n  --> {file_path}:{}:{}",
            span.line, span.column
        );
    }
    if teach {
        let hints = checker.take_hints();
        if !hints.is_empty() {
            eprintln!("=== lux teach ===\n");
            for hint in &hints {
                eprint!("{}", lux::error::format_hint(hint, Some(file_path)));
            }
            eprintln!("{}\n", lux::error::format_hint_summary(&hints));
        }
    }

    // Compile: prepend prelude items to the user program.
    let mut combined = lux::ast::Program { items: Vec::new() };
    if let Some(prelude) = prelude_program {
        combined.items.extend(prelude.items);
    }
    combined.items.extend(program.items);

    let effect_routing = checker.take_effect_routing();
    let proto = lux::compiler::compile(&combined, effect_routing)?;
    let mut vm = lux::vm::vm::Vm::new();
    let result = vm.run(Arc::new(proto)).map_err(|e| {
        lux::error::LuxError::Runtime(lux::error::RuntimeError {
            kind: lux::error::RuntimeErrorKind::TypeError(e.message),
            span: lux::token::Span {
                file_id: 0,
                line: e.line as usize,
                column: 0,
                start: 0,
                end: 0,
            },
        })
    })?;

    // Don't print the final value — file execution uses println for output.
    let _ = result;
    Ok(())
}

/// Derive the base directory (for relative imports) and std directory
/// from the source file path.
fn resolve_dirs(file_path: &str) -> (std::path::PathBuf, std::path::PathBuf) {
    let path = Path::new(file_path);
    let base_dir = path.parent().unwrap_or(Path::new(".")).to_path_buf();

    // std dir: try relative to executable, then cwd
    let std_dir = std::env::current_exe()
        .ok()
        .and_then(|p| p.parent().map(|d| d.join("../std")))
        .filter(|d| d.exists())
        .unwrap_or_else(|| std::path::PathBuf::from("std"));

    (base_dir, std_dir)
}
