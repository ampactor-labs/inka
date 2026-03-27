//! Golden-file integration tests for Lux examples.
//!
//! Each `examples/*.lux` file has a corresponding `examples/*.expected` file
//! containing the expected stdout. Tests run the example via the VM
//! (the sole execution engine) and compare output.
//!
//! To regenerate baselines: `cargo test -- --ignored regenerate_baselines`

use std::path::Path;
use std::process::Command;

/// Run a `.lux` file and return (stdout, stderr, success).
fn run_lux(file: &str) -> (String, String, bool) {
    let output = Command::new(env!("CARGO_BIN_EXE_lux"))
        .arg("--quiet")
        .arg(file)
        .output()
        .unwrap_or_else(|e| panic!("failed to run lux on {file}: {e}"));
    (
        String::from_utf8_lossy(&output.stdout).into_owned(),
        String::from_utf8_lossy(&output.stderr).into_owned(),
        output.status.success(),
    )
}

/// Run with --rust (Rust pipeline, legacy fallback).
fn run_lux_rust(file: &str) -> (String, String, bool) {
    let output = Command::new(env!("CARGO_BIN_EXE_lux"))
        .arg("--rust")
        .arg("--quiet")
        .arg(file)
        .output()
        .unwrap_or_else(|e| panic!("failed to run lux on {file}: {e}"));
    (
        String::from_utf8_lossy(&output.stdout).into_owned(),
        String::from_utf8_lossy(&output.stderr).into_owned(),
        output.status.success(),
    )
}

/// Find all examples that have a `.expected` golden file.
fn golden_examples() -> Vec<(String, String)> {
    let examples_dir = Path::new(env!("CARGO_MANIFEST_DIR")).join("examples");
    let mut pairs = Vec::new();
    for entry in std::fs::read_dir(&examples_dir).expect("examples/ dir") {
        let entry = entry.unwrap();
        let path = entry.path();
        if path.extension().is_some_and(|e| e == "lux") && path.is_file() {
            let expected = path.with_extension("expected");
            if expected.exists() {
                pairs.push((
                    path.to_string_lossy().into_owned(),
                    expected.to_string_lossy().into_owned(),
                ));
            }
        }
    }
    pairs.sort();
    pairs
}

#[test]
fn vm_matches_golden_files() {
    let pairs = golden_examples();
    assert!(
        !pairs.is_empty(),
        "no .expected files found — run regenerate_baselines first"
    );

    let mut failures = Vec::new();
    for (lux_file, expected_file) in &pairs {
        let expected = std::fs::read_to_string(expected_file)
            .unwrap_or_else(|e| panic!("can't read {expected_file}: {e}"));
        let (stdout, stderr, success) = run_lux(lux_file);

        if !success {
            failures.push(format!(
                "FAIL (exit code): {}\n  stderr: {}",
                lux_file,
                stderr.lines().take(3).collect::<Vec<_>>().join("\n  ")
            ));
            continue;
        }
        if stdout != expected {
            failures.push(format!(
                "FAIL (output mismatch): {}\n  expected: {:?}\n  actual:   {:?}",
                lux_file,
                expected.lines().take(3).collect::<Vec<_>>(),
                stdout.lines().take(3).collect::<Vec<_>>(),
            ));
        }
    }

    if !failures.is_empty() {
        panic!(
            "\n{} example(s) failed:\n\n{}\n",
            failures.len(),
            failures.join("\n\n")
        );
    }
}

/// Error-expecting tests: `examples/errors/*.lux` files must fail to compile,
/// and stderr must contain each `// EXPECT_ERROR: <substring>` from the file.
#[test]
fn error_examples_produce_expected_errors() {
    let errors_dir = Path::new(env!("CARGO_MANIFEST_DIR")).join("examples/errors");
    if !errors_dir.exists() {
        return; // no error examples yet
    }

    let mut files: Vec<_> = std::fs::read_dir(&errors_dir)
        .expect("examples/errors/ dir")
        .filter_map(|e| {
            let p = e.ok()?.path();
            (p.extension()?.to_str()? == "lux").then(|| p)
        })
        .collect();
    files.sort();

    assert!(!files.is_empty(), "no .lux files in examples/errors/");

    let mut failures = Vec::new();
    for path in &files {
        let name = path.file_stem().unwrap().to_string_lossy();
        let source = std::fs::read_to_string(path)
            .unwrap_or_else(|e| panic!("can't read {}: {e}", path.display()));

        // Extract expected error substrings.
        let expectations: Vec<&str> = source
            .lines()
            .filter_map(|l| l.strip_prefix("// EXPECT_ERROR: "))
            .collect();

        if expectations.is_empty() {
            failures.push(format!("FAIL: {name} — no EXPECT_ERROR comments found"));
            continue;
        }

        // Error examples test Rust checker diagnostics (ownership, refinements).
        // Route through the Rust pipeline so these errors are enforced.
        let (_, stderr, success) = run_lux_rust(&path.to_string_lossy());

        if success {
            failures.push(format!(
                "FAIL: {name} — expected error but program succeeded"
            ));
            continue;
        }

        for exp in &expectations {
            if !stderr.contains(exp) {
                failures.push(format!(
                    "FAIL: {name} — expected stderr to contain: {exp:?}\n  actual stderr: {}",
                    stderr.lines().take(3).collect::<Vec<_>>().join("\n  ")
                ));
            }
        }
    }

    if !failures.is_empty() {
        panic!(
            "\n{} error example(s) failed:\n\n{}\n",
            failures.len(),
            failures.join("\n\n")
        );
    }
}

/// Oracle test: compare self-hosted pipeline (default) vs Rust pipeline (`--rust`).
///
/// Runs each example with both `lux --quiet` (self-hosted, default) and
/// `lux --rust --quiet` (Rust pipeline), then reports parity.
/// Does not fail on mismatches — diagnostic only.
///
/// Examples that can only run on the self-hosted pipeline (they import
/// self-hosted compiler modules) are skipped for the Rust comparison.
#[test]
fn oracle_self_hosted_parity() {
    let pairs = golden_examples();
    assert!(
        !pairs.is_empty(),
        "no .expected files found — run regenerate_baselines first"
    );

    // Examples that import self-hosted modules and can't run through the Rust
    // pipeline due to known evidence-passing limitations.
    let rust_only_skip = |name: &str| -> bool {
        matches!(
            name,
            "parser_test"
                | "lexer_test"
                | "checker_test"
                | "codegen_test"
                | "vm_test"
                | "effect_unification"
                | "gradient_test"
                | "type_error_test"
                | "ownership_check_test"
                | "suggest_test"
                | "refinement_check_test"
        )
    };

    let mut matches = 0usize;
    let mut mismatches = 0usize;
    let mut errors = 0usize;
    let mut mismatch_details: Vec<String> = Vec::new();

    for (lux_file, _expected_file) in &pairs {
        let name = Path::new(lux_file).file_stem().unwrap().to_string_lossy();

        // Skip examples that can't run through the Rust pipeline at all.
        if rust_only_skip(&name) {
            continue;
        }

        let (self_stdout, self_stderr, self_ok) = run_lux(lux_file);
        let (rust_stdout, rust_stderr, rust_ok) = run_lux_rust(lux_file);

        if !rust_ok && !self_ok {
            // Both fail — still a form of parity.
            matches += 1;
            continue;
        }

        if !rust_ok {
            errors += 1;
            mismatch_details.push(format!(
                "  {name}: Rust FAILED, self-hosted OK\n    rust stderr: {}",
                rust_stderr.lines().next().unwrap_or("(empty)")
            ));
            continue;
        }

        if !self_ok {
            errors += 1;
            mismatch_details.push(format!(
                "  {name}: Rust OK, self-hosted FAILED\n    self stderr: {}",
                self_stderr.lines().next().unwrap_or("(empty)")
            ));
            continue;
        }

        if rust_stdout == self_stdout {
            matches += 1;
        } else {
            mismatches += 1;
            let rust_lines: Vec<&str> = rust_stdout.lines().collect();
            let self_lines: Vec<&str> = self_stdout.lines().collect();
            let first_diff = rust_lines
                .iter()
                .zip(self_lines.iter())
                .position(|(a, b)| a != b)
                .unwrap_or_else(|| rust_lines.len().min(self_lines.len()));
            let detail = if first_diff < rust_lines.len() && first_diff < self_lines.len() {
                format!(
                    "  {name}: line {} differs\n    rust: {}\n    self: {}",
                    first_diff + 1,
                    rust_lines[first_diff],
                    self_lines[first_diff]
                )
            } else {
                format!(
                    "  {name}: output length differs (rust: {} lines, self: {} lines)",
                    rust_lines.len(),
                    self_lines.len()
                )
            };
            mismatch_details.push(detail);
        }
    }

    let total = matches + mismatches + errors;
    eprintln!("\n=== Oracle Parity Report ===");
    eprintln!("{matches}/{total} match, {mismatches} mismatches, {errors} errors\n");
    if !mismatch_details.is_empty() {
        eprintln!("Details:");
        for d in &mismatch_details {
            eprintln!("{d}");
        }
    }

    // Diagnostic only — does not fail. Once parity is proven, flip to:
    // assert_eq!(mismatches + errors, 0, "oracle parity failed");
}

#[test]
#[ignore]
fn regenerate_baselines() {
    let examples_dir = Path::new(env!("CARGO_MANIFEST_DIR")).join("examples");
    for entry in std::fs::read_dir(&examples_dir).expect("examples/ dir") {
        let entry = entry.unwrap();
        let path = entry.path();
        if path.extension().is_some_and(|e| e == "lux") && path.is_file() {
            let (stdout, _, success) = run_lux(&path.to_string_lossy());
            if success {
                let expected = path.with_extension("expected");
                std::fs::write(&expected, &stdout)
                    .unwrap_or_else(|e| panic!("can't write {}: {e}", expected.display()));
                println!("wrote {}", expected.display());
            } else {
                println!("SKIP (VM fails): {}", path.display());
            }
        }
    }
}
