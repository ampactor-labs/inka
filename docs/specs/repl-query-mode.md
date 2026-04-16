# REPL Query Mode — Forensic Interface to the Inference Graph

**Status:** Scoped. Next session to implement.
**Motivation:** Collapse "Claude waits 75 minutes for stage2 to surface a type" into "Claude asks the graph, gets answer in seconds."

## The gap

The existing `std/repl.lux` is a full interactive REPL with `:teach`/`:why`/`:trace`/`:normal` modes. It's blocked on `load_chunk`, a Rust VM builtin that Phase 0 deleted — the REPL can compile source to bytecode but has no runtime to execute it.

For forensic work, **execution isn't needed**. What's needed is observation: query the inference graph after check_program runs, without running anything.

## What's missing

A way to answer these questions without a full bootstrap rebuild:

- What type does the checker infer for `check_return_pos` in `own.lux`?
- What's the full substitution chain for `TVar(42)`?
- Which env entries still contain unresolved TVars after inference?
- What effects does `compile_wasm` perform transitively?

Today's answer: modify source, rebuild stage2 (~6 min), grep lux4.wat. Repeat per question. The feedback loop is the bottleneck on every forensic dig.

## Scope (MVP)

**One new subcommand: `lux query <file> <question>`.**

Invocations:

```bash
lux query std/compiler/own.lux "type of check_return_pos"
# → check_return_pos : (SExpr, List[String]) -> List[OwnershipViolation] with Pure

lux query std/compiler/pipeline.lux "unresolved"
# → 3 env entries with remaining TVars:
#     check_return_pos → (SExpr, List[String]) -> List[TVar(142)]
#     js_at → (List[TVar(83)], String, Int) -> String
#     walk_list_at → …

lux query std/compiler/infer.lux "subst trace for TVar(42)"
# → TVar(42) → TList(TVar(43)) → TList(RefEscaped) via unify at line 176
```

Runs the checker. Returns types / effects / subst chains. Does NOT emit WAT. Does NOT execute anything. ~100ms per query (just lex + parse + check of one file).

## Implementation sketch

**File:** `std/compiler/query.lux` (new)

```lux
import compiler/pipeline
import compiler/check
import compiler/ty
import compiler/display

fn query(file, question) = {
  let source = read_file(file)
  let ast = source |> frontend
  let (env, subst) = ast |> check_program

  match parse_query(question) {
    TypeOf(name) => {
      let (_, ty, reason) = env_lookup(env, name)
      println(name ++ " : " ++ show_type(apply(subst, ty)))
      println("  " ++ show_reason(reason))
    },
    Unresolved => dump_unresolved(env, subst),
    SubstChain(tvar_id) => dump_chain(subst, tvar_id),
    Unknown(q) => println("unknown query: " ++ q)
  }
}

fn parse_query(q) = {
  // "type of X" → TypeOf("X")
  // "unresolved" → Unresolved
  // "subst trace for TVar(N)" → SubstChain(N)
  // …
}
```

**Entry point:** add to `std/compiler/main.lux` (or wherever CLI dispatches live) under the `"query"` branch.

## Non-goals

- Interactive loop (the existing `std/repl.lux` covers that when execution is available)
- Write operations (no `:bind`, no `:set`)
- Cross-file multi-module queries (one file per invocation; fall back to full bootstrap for whole-program questions)

## Success criteria

- Running `lux query std/compiler/own.lux "type of check_return_pos"` returns in under 1 second.
- The output tells Claude, unambiguously, whether the function's type has unresolved TVars or is fully ground.
- Claude's forensic dig from 2026-04-15 (30 minutes of wasm-decompile + grep + stage2) takes under 2 minutes using this tool instead.

## When to build

Arc 3.5 — opening move before Phase 3 (arenas + ownership) begins. Rationale: the forensic dig during Phase 2 debugging WOULD have saved time had this existed. Phase 3 will have similar debug cycles (arena reclamation, ownership escape checking). Build the tool that shortens the loop before entering the territory that needs the loop.

## Extension path

Once `lux query` ships:

- **Query effect.** Make `query` an effect op: `effect Query { ask(q) -> Result }`. The self-hosted checker performs Query; handlers decide the backend (stdout print, JSON dump, LSP response, IDE overlay). The same query mechanism that serves Claude's forensics serves LSP hover, serves teaching mode.
- **Live graph observation.** Once Phase 2 completes (lowering observes live subst), `query` can ask "what if" questions by adding a constraint temporarily and observing what resolves.
- **Replace print-debugging in the compiler.** Every `println` left in the compiler's source for diagnostic reasons becomes a `perform query_report(…)` that handlers route appropriately.

The REPL query mode is the **first visible surface of the live graph**. Everything else — LSP, teaching, gradient display — is more handlers on the same mechanism.
