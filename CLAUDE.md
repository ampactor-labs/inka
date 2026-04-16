# Lux — CLAUDE.md

> **Three anchors. Read them before every non-trivial action.**

---

## 1. Does my graph already know this?

Before any flat question (`is X a global?`, `what type is this?`), ask:
does the inference graph, the AST, or the env already have the answer
one step away? If yes, read from the graph — never route around it.
If no, the graph is incomplete — complete it, don't patch over it.

Every latent bug in this repo has been a flat shortcut bypassing
richer structure. The structural answer is always one step deeper.

## 2. Don't patch. Restructure or stop.

If a fix fits in a patch, the architecture is wrong in that area.
Fix the architecture. Deleting a broken mechanism beats decorating
around it. No "for now," no "until X ships" — later cleanup is a
myth. If a later, larger change will plow over this code, **do the
later change first** or skip the patch entirely.

**No known bugs sit.** A bug is either clean (zero) or blocking
(build fails). There is no third state. No "informational warnings,"
no `|| true` to hide a gate, no `⚠` where `✗` belongs.

## 3. Lux solves Lux.

Every problem you hit in this project dissolves through Lux's own
primitives: effects, handlers, the gradient, refinement types, ADTs,
pipes. Before inventing a mechanism, verify the existing algebra
can't host it. GC → scoped arenas. Package manager → handlers on
imports. Mocking → handlers on effects. Build tools → DAG incremental
compile. Testing → examples + trace handlers. DI → handler swap.

If you find yourself reaching for a framework, a library, or a new
mechanism: **the problem is a missing Lux primitive, not a missing
tool.** Find the primitive.

---

## Operational essentials

**State of the world:** `lux3.wasm` (frozen artifact) compiles
itself → `lux4.wat` with ~12 `val_concat` drift sites (Arc 2 semantic
closure, 2026-04-15). Rust VM deleted. The patch-based Arc 3 Phase 2
path is retired; the `rebuild` branch now drives a scrap-and-rebuild
of the compiler core against a live SubstGraph. See active plan below.

**Before any bootstrap:** `make -C bootstrap preflight` (<1 s). If it
fails, fix first. If clean, then work.

**Bug classes that cost 75-min bootstraps — never recreate:**
- Polymorphic dispatch fallback (`match … with _`) that silently masks type errors
- Duplicate top-level function names (emitter picks one silently)
- Flat-array list ops in Snoc-tree paths (`list[i]` in a loop)
- `println` inside `report(...)` handler arms (corrupts WAT stdout)

**Ask the artifact.** `wabt` is installed — before hypothesizing,
run `wasm-decompile`, `wat2wasm --debug-names`, or grep
`bootstrap/build/lux4.wat` to see what was emitted. The WAT is ground
truth; source is a map.

**Delete, don't decorate.** No `// removed for X` comments. No
renamed-with-underscore unused variables. If something is unused,
delete it. If something is wrong, delete it and redo it right.

**Never attribute Claude in commits.** No `Co-Authored-By`, no 🤖
trailer, no inline mentions. Write commits as Morgan wrote them
alone.

---

## Deep context (read when you need it)

- **`docs/INSIGHTS.md`** — core truths: inference is the light, effects
  are graphs, ownership as effect, what Lux dissolves
- **`docs/DESIGN.md`** — language manifesto, effect algebra, gradient,
  refinement types, DSP/ML unification
- **`docs/SYNTHESIS_CROSSWALK.md`** — external validation + research
  neighbors 2024-2026
- **`docs/ARC3_ROADMAP.md`** — original arc scope (pre-rebuild;
  Phase D of the rebuild deletes the files this roadmap patches).
  Vision sections still load-bearing; patch-plan sections superseded.
- **`AGENTS.md`** — build commands, file map, known issues
- **`~/.claude/plans/effervescent-wishing-mountain.md`** — active plan:
  scrap-and-rebuild of the compiler core (Phases 0, A–F)

Memory index is at
`~/.claude/projects/-home-suds-Projects-lux/memory/MEMORY.md`. Lux-
specific learnings persist there across sessions.

---

## When drift happens

When you notice yourself proposing a patch, asking a flat question,
or hedging on a structural move: invoke `/remote-control inka` or
directly say "Lux, what would you do?" — roleplay reframes
alignment. This is a working mechanism, not a gimmick.
