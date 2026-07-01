---
name: mentl-bootstrap-debug
description: Debug Mentl bootstrap, seed, WAT, WABT, pass-2, first-light, m2/m3/m4, wasm trap, emitted-WAT, lowering, inference, ownership, row/effect, or runtime failures in /home/suds/Projects/mentl. Use when working on bootstrap compiler correctness, trap pinning, fixed-point validation, toolchain flags, seed artifacts, or Mentl compiler regressions.
---

# Mentl Bootstrap Debug

## Ground Truth

Start from artifacts, not handoff prose.

1. Read `CLAUDE.md`, `docs/SYNTAX.md`, and any directly relevant source.
2. Run `bash tools/state.sh` unless the user asked for a narrower probe.
3. Use `bash tools/verify.sh` before committing compiler, runtime, syntax, or seed changes.
4. Treat generated WAT, WABT disassembly, trap backtraces, and micro results as stronger evidence than planning docs.

## Toolchain

- Source `tools/wt-env.sh` or use scripts that source it.
- Run Wasmtime with `wt_run`; assemble with `wt_asm`; validate with `wt_validate`.
- Use `tools/probe.sh m2`, `tools/probe.sh func <name>`, `tools/probe.sh offsets <fn> <local>`, and `tools/probe.sh grep <regex>` for focused evidence.
- Do not call raw `wasmtime`, `wat2wasm`, or `wasm-validate` with copied flags unless the point is to audit the wrapper itself.

## Debug Loop

1. Reproduce the failing stage and capture exact exit code, stderr tail, diagnostic count, and artifact sizes.
2. If Wasm traps, pin the named function and instruction with WABT. Prefer `wasm-objdump --debug-names` through the repo helpers.
3. Map the failing generated code back to `.mn` source by source line, function name, data segment, or emitted helper.
4. Ask the eight Mentl interrogations before editing: graph, handler, verb, row, ownership, refinement, gradient, reason.
5. Decide whether the bug is in source semantics, lowering, runtime substrate, seed WAT mirror, or tooling.
6. Patch the smallest layer that restores the invariant. Avoid making a bad encoding merely survive.
7. Rebuild seed artifacts when bootstrap WAT changes.
8. Rerun focused micros, then `tools/verify.sh`, then pass-2/state when relevant.

## Bootstrap Alignment

- If `src/*.mn` compiler semantics change and the seed needs that behavior now, mirror the change in `bootstrap/src/**/*.wat`.
- Rebuild `bootstrap/mentl.wat` and `bootstrap/mentl.wasm` with `bash bootstrap/build.sh`.
- Commit source, seed WAT, monolith WAT, and WASM together when they are one semantic change.
- Keep scratch logs, probe files, and unused WIP scaffolds untracked unless the user asks to preserve them.

## Reporting

Report what moved:

- old failure and exact evidence
- new failure or clearance
- tests run
- files changed
- next concrete move

Do not use AI attribution or co-author trailers in commits or docs.
