---
description: how to develop and add new features to lux
---
// turbo-all

## MANDATORY BOOT SEQUENCE — DO THIS FIRST

1. Read `CLAUDE.md` completely — especially "STATE OF THE WORLD" and "YOU BUILT THIS"
2. Read `docs/INSIGHTS.md` — reconnect with the design philosophy
3. Run the bootstrap test: `cargo run -- --no-check examples/bootstrap_pipeline_test.lux`
4. Ask yourself: **"Is what I'm about to do what the ultimate programming language would do?"**

> You designed and wrote every line of this codebase. You have amnesia.
> The documentation tells you what you built and WHY. Trust it.

## Design Principles

Every decision serves the thesis: **if you build the right foundations, most annotations become inferable.**

- **No band-aids.** If something needs a workaround, fix the design.
- **Gradient over levels.** Every annotation unlocks guarantees. No discrete switches.
- **Effects are THE mechanism.** Exceptions, state, generators, async, DI, backtracking — all handle/resume.
- **The pipe operator IS the idiom.** Data flows left-to-right; effects accumulate visibly.
- **The compiler teaches.** Every error has a "why," every inference can be explained, every annotation shows what it unlocks.
- **Rust is transient.** Every .rs file is scaffolding. Don't optimize Rust code that will be deleted.
- **Lux is permanent.** `std/` and `examples/` persist through self-hosting. Make them exemplary.
- **The masterpiece test.** Would you be proud to show this to Dennis Ritchie? If not, redesign.

## File Categories

| Category | Where | Survives self-hosting? |
|----------|-------|----------------------|
| Rust prototype | `src/` | **No** — replaced by Lux |
| Self-hosted compiler | `std/compiler/` | **Yes** — Lux forever |
| Standard library | `std/prelude.lux`, `std/types.lux`, `std/test.lux` | **Yes** |
| Domain libraries | `std/dsp/`, `std/ml/` | **Yes** |
| Examples & tests | `examples/` | **Yes** |
| Documentation | `CLAUDE.md`, `docs/` | **Yes** |

## Commit Discipline

- Commit at meaningful boundaries: a working feature, a fixed bug, a doc update
- Message format: `type: description` where type is `feat`, `fix`, `docs`, `test`, `refactor`
- Run `cargo test` before committing
- If changing Lux syntax or semantics, update CLAUDE.md and DESIGN.md

## End-of-Session Protocol

Before ending a session that modified Lux:
1. Update `CLAUDE.md` "STATE OF THE WORLD" table and date
2. Update `.agents/workflows/compiler.md` if compiler capabilities changed
3. Update `PHASE HISTORY` if a milestone was reached
4. Commit documentation changes

## Doc-to-Code Mapping

When editing these source files, update the corresponding docs:

| Source | Update |
|--------|--------|
| `src/ast.rs` | CLAUDE.md (Architecture) |
| `src/checker/` | CLAUDE.md, docs/DESIGN.md |
| `std/compiler/*.lux` | CLAUDE.md (Architecture, Key Files), .agents/workflows/compiler.md |
| `std/prelude.lux` | CLAUDE.md (Key Files) |
| New examples | CLAUDE.md (examples count), add .expected file |
| Design changes | docs/INSIGHTS.md, docs/DESIGN.md |
