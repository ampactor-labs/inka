# NS-naming — Naming-audit walkthrough

> **Status:** `[PENDING]`. Gates Pending Work items 10–16 (extension migration + simplification execution + doc updates). This walkthrough resolves every naming decision the simplification audit needs to proceed mechanically. After this walkthrough closes, item 11 (simplification execution) has no design left — only transcription.

*One walkthrough; one simplification audit; one commit sequence. No "for now," no "until later" — the naming form that lands after this walkthrough is Inka's canonical form, kept forever.*

---

## 0. Framing — why naming is substrate, not style

Inka is the ultimate intent → machine instruction medium. Every line a developer reads is Mentl's voice made visible in source. Names are not cosmetic; they are the interface through which the graph speaks to a human. A name that carries a foreign-language pattern carries that language's cognitive shape into the human's thinking. **Inka's names must be Inka-native, or the medium leaks.**

This walkthrough resolves six naming decisions, then sequences their mechanical application. Every decision passes the eight interrogations; every rewrite rule is prescriptive at source-site resolution.

**What this walkthrough gates:**
- Item 10 — `.nx` → `.nx` extension migration
- Item 11 — simplification audit execution (dot-access conversion, rename sweep, drift-mode audit)
- Items 12–16 — doc updates reflecting the naming changes
- Indirectly, every downstream walkthrough inherits the canonical names this walkthrough fixes

**What this walkthrough does NOT cover:**
- Directory restructure (that's `NS-structure.md`, item 5)
- Entry-handler paradigm (that's `EH-entry-handlers.md`, item 6)
- Simplification discipline itself (that's `SIMP-simplification-audit.md`, item 7)

---

## 1. The six naming decisions

### 1.1 Module-function access: dot-access, not C-style prefix

**Current form (drift).** Functions inside a module are named with the module as a prefix:

```
fn graph_chase(h) = ...
fn cache_write(kai) = ...
fn parse_atom(tokens) = ...
fn lower_pipe(node) = ...
```

Call sites:

```
let node = graph_chase(h)
let ok = unify_apply(a, b)
cache_write(kai)
```

This is **drift mode 5 (C calling convention).** C/Rust/Go use module-name-as-prefix because their module systems can't carry the namespace automatically; every function's fully-qualified name is the module prefix + local name. **Inka has proper modules + imports.** The namespace IS the module. Prefixing is redundant ceremony duplicating information `import` already carries.

**Inka-native form.** Bare names inside the module; dot-access from importers:

```
// inside src/graph.nx
fn chase(h) = ...
fn bind(h, ty, r) = ...

// inside src/infer.nx
import src/graph

fn expr(node) = {
  let h = graph.chase(node_handle(node))
  ...
}
```

Or, for extra-hot names, selective import brings bare names into scope:

```
import src/graph {chase, bind}

fn expr(node) = {
  let h = chase(node_handle(node))
  ...
}
```

**Substrate requirement** (verified against current parser + infer state). Dot-access on imported modules requires inference to accept `FieldExpr(VarRef(module_name), field_name)`. The parser already constructs this shape (`parser.nx:704`); inference currently constrains the left-hand side of `FieldExpr` to a record (record-open unification at `infer.nx:602`).

**Resolution (REVISED 2026-04-21 per Inka-solves-Inka re-audit):** ~~modules are records at the type level~~ — that framing was drift-1-adjacent. Corrected: **dotted names are env entries.** When driver installs an imported module's exports, it registers each export under TWO env keys: the flat short name (current behavior) AND the qualified `module_short_name.export_name` form. `FieldExpr(VarRef(m), f)` tries the qualified lookup first; on miss falls through to record-field unification.

**Implementation scope** (folded into item 11 simplification execution):
- `src/driver.nx` gains qualified-name dual-install in `driver_install_loop` (~10 lines). For each export, extend env twice: flat key and `module.export` key.
- `src/infer.nx` gains FieldExpr qualified-lookup attempt before record unification (~5 lines). Check `env_lookup(left_name ++ "." ++ field)`; hit → use that Scheme; miss → existing record-access path.
- ~15 lines total. No new ADT variant. No new effect. No new type-system concept — dotted names are just more qualified env keys.

**Why this is Inka-native, per the eight interrogations:**
- **Graph?** Env already keys by strings; dotted names are qualified strings. No new substrate.
- **Handler?** `env_lookup` (EnvRead) is the existing handler; no new handler.
- **Verb?** No verb change.
- **Row?** No row change.
- **Ownership / Refinement / Gradient / Reason?** N/A at the lookup level.

**Drift modes foreclosed:**
- **Drift 1 (Rust vtable):** rejected the record-of-functions-as-namespace interpretation. Just env entries.
- **Drift 6 (primitive-type-special-case):** modules aren't a special kind of thing; they contribute env entries like every other declaration.
- **Drift 8 (string-keyed):** the string IS the structured form here; env is already string-keyed.

**Call-site rewrite rules** (prescriptive for simplification execution):

| Current form | New form (dot-access) | Alternative (selective import) |
|---|---|---|
| `graph_chase(h)` inside `graph.nx` | `chase(h)` | — |
| `graph_chase(h)` inside another module | `graph.chase(h)` | `chase(h)` w/ `import graph {chase}` |
| `cache_write(kai)` inside `cache.nx` | `write(kai)` | — |
| `cache_write(kai)` elsewhere | `cache.write(kai)` | `write(kai)` w/ selective import |

**Heuristic for dot vs. selective-import:** if a module's function is called ≥5 times in one importer, selective-import is worth it (terser at each call site); if ≤4, dot-access keeps origin visible without bloating imports. Simplification audit applies this heuristic mechanically.

**Savings.** ~548 top-level `fn` declarations across the compiler lose their module prefix. Average savings per prefix: 6-8 characters × ~3 call sites per function ≈ ~12k characters reduced in source. Each WAT function name shrinks proportionally (~30% on average).

**Drift modes foreclosed at this site:**
- **#1 (Rust vtable)** — selective-import + bare name DOESN'T mean "namespace as vtable lookup"; it's import resolution at compile time, fully monomorphic.
- **#5 (C calling convention)** — directly addressed; prefix-in-name dissolved.
- **#8 (string-keyed-when-structured)** — dot-access IS the structured form; prefix-in-name was the string-key form.

---

### 1.2 `Graph` → `Graph` ADT rename

**Current form.** The flat-array, O(1)-chase substrate is named `Graph` throughout the compiler.

**Why it's drift.** "Graph" encodes history — "substitution graph" from type-theory tradition where "subst" refers to the substitution a unifier produces. The name answers "what was its origin?" not "what is it?" A newcomer reads `Graph` and asks "sub-what? substitute for what? is there another graph?" — legitimate questions the name doesn't answer.

**What it IS, per INSIGHTS crystallization #6: *The Graph IS the Program.*** The substrate is the graph. There is no other graph in Inka's vocabulary (not a neural graph — that's `Tensor`; not a dependency graph — that's handler composition; not a parse graph — that's the AST which is projections of the graph). **One graph; name it `Graph`.**

**Verified non-collisions.**
- No user-space collision expected: users interact with `GraphRead`/`GraphWrite` effects; the ADT is compiler-internal.
- The `graph.nx` module name stays (the module is `graph`, not `Graph`; lowercase module, PascalCase ADT — canonical naming convention).
- Effect names stay `GraphRead` / `GraphWrite` (already shortened in earlier session).

**Rewrite rules:**

| Current | New |
|---|---|
| `Graph` (ADT) | `Graph` |
| `GraphRead` (effect) | `GraphRead` (already landed) |
| `GraphWrite` (effect) | `GraphWrite` (already landed) |
| `graph.md` (spec filename) | `graph.md` (retitled with restructure) |
| `the Graph` (prose) | `the Graph` (occasionally lowercase "the graph" in informal prose) |

**Files affected:**
- `src/types.nx` — ADT declaration + ~5 references
- `src/graph.nx` — the module implementing it (~40 refs)
- `src/infer.nx`, `src/lower.nx`, `src/query.nx`, `src/mentl.nx`, others — chase calls + type mentions
- `docs/DESIGN.md` §0.5 + Ch 4 (~40 refs)
- `docs/SUBSTRATE.md` (kernel shorthand + various)
- `docs/CLAUDE.md` (kernel anchor, interrogations, file map)
- `docs/README.md` (kernel enumeration)
- `docs/specs/00-graph.md` → `docs/specs/00-graph.md` (retitled)
- `docs/specs/simulations/H*.md` — various references
- `docs/traces/a-day.md`
- Memory files

**Drift modes foreclosed:**
- **#8 (string-keyed-when-structured)** — the name now describes what it IS, not where it came from.

---

### 1.3 `lexer` / `parser` → `lex` / `parse`

**Current form.** `src/compiler/lexer.nx` and `src/compiler/parser.nx`. Agent-named ("the thing that acts").

**Why it's drift.** Other compiler modules are action-named (`infer.nx`, `lower.nx`, `verify.nx`, `query.nx`) or subject-named (`types.nx`, `effects.nx`, `graph.nx`, `clock.nx`). The `-er` agent suffix is German-programming-textbook residue ("The Lexer processes..."), not Inka-native.

**Inka-native form.** Match the majority pattern — verb form:

- `lexer.nx` → `lex.nx`
- `parser.nx` → `parse.nx`

**Side effect (synergy with decision 1.1):** with dot-access, the call sites become `lex.tokenize(source)`, `parse.program(tokens)` — literal statements of what's happening. The subject-verb pairing reads naturally; agent-form would have been `lexer.tokenize` which redundantly expresses "the lex-er does lex."

**Rewrite rules:** trivial — two filename renames + every `import compiler/lexer` → `import src/lex` (also item 17' restructure), every call-site reference updated as part of decision 1.1's dot-access sweep.

**Drift modes foreclosed:**
- **#5 (C calling convention)** adjacent — agent-naming is a C/Java habit importing the "object-doing-action" shape.

---

### 1.4 Effect-name normalization

**Current forms, mixed:**

- **Short nouns:** `IO`, `Tick`, `Clock`, `Consume`, `Iterate`, `Memory`, `Alloc` — ✓
- **Action-named:** `Verify`, `Teach`, `Synth`, `Deadline` — ✓
- **Compound scoped:** `GraphRead`, `GraphWrite`, `EnvRead`, `EnvWrite`, `LookupTy` — ✓
- **Parameterized:** `Sample(44100)`, `Tick(48000)` — ✓
- **Legacy long forms** (to fix): `HostClock`, `IterativeContext`, any lingering `GraphRead`/`GraphWrite` not yet cleaned up
- **Over-specific:** `GraphRead`/`GraphWrite` already renamed; any residual `Subst*` flagged for rename

**Normalization rule** (prescriptive):
- **One-word PascalCase** for simple effects: `IO`, `Alloc`, `Memory`, `Iterate`, `Consume`, `Verify`, `Teach`, `Synth`, `Interact`.
- **Compound PascalCase** for scoped effects: `GraphRead`, `GraphWrite`, `EnvRead`, `EnvWrite`, `LookupTy`.
- **Parameterized** uses explicit parens: `Sample(rate)`, `Tick(rate)`, `Budget(ns)`.
- **No `Host*` or `Iterative*` prefixes.** `HostClock` is just `Clock` with a specific handler; it's not a separate effect. `IterativeContext` is an effect-row constraint (`<~` requires iterative ctx), not a separate effect — the constraint is `Tick | Sample | Clock` in the row.

**Rewrite rules:**

| Current | New | Rationale |
|---|---|---|
| `HostClock` effect | merged into `Clock` | Different handlers of `Clock` (real vs test vs record vs replay); not a separate effect |
| `IterativeContext` effect | deleted; replaced by row constraint `Tick + Sample + Clock` (intersection) | Was an artificial sentinel |
| `GraphRead` | `GraphRead` | Already shortened; audit for any residual |
| `GraphWrite` | `GraphWrite` | Same |

**Files affected:** `src/effects.nx`, `src/clock.nx`, any module performing `HostClock` ops, any `with IterativeContext` constraints.

**Drift modes foreclosed:**
- **#6 (primitive-type-special-case)** — `HostClock`-as-separate-effect treated "real time" as special; it's not; it's a handler choice.
- **#8 (string-keyed-when-structured)** — over-specific names hide the actual substrate shape.

---

### 1.5 Docstring consistency

**Current state.** Some modules open with rich purpose statements (e.g., `src/types.nx`'s "THE vocabulary of Inka"). Others open with one-liners. No canonical top-of-module documentation form.

**Canonical top-of-module docstring** (prescriptive):

```
// <module-name>.nx — <one-line purpose>
//
// Kernel primitive served: <#N — primitive name>
// Mentl tentacle projected: <tentacle name, e.g., Query>
//
// <2-5 lines of what this module does; what it hosts; what's
// load-bearing about its role in the graph.>
//
// ─── Invariants / discipline ─────────────────────────────────
// <bulleted invariants the module maintains>

<imports>
```

**Every module in `src/` and `lib/` opens with this form after the simplification audit.** Existing docstrings get harmonized; modules without opening docs get one written.

**Drift modes foreclosed:**
- **#9 (deferred-by-omission)** — every module explicitly names its kernel primitive, so "which primitive does this serve?" is never deferred to the reader.

---

### 1.6 Delete `docs/SYNTHESIS_CROSSWALK.md`

**Current state.** The file opens with: *"Status: historical context, not a living spec. This doc predates the rebuild plan..."*

**Why it's drift.** Anchor 8 of CLAUDE.md: **"Delete fearlessly. Nobody uses Inka. No backwards compatibility. No archive folders. No 'for reference.'"** A file marked historical is an archive-folder-as-file. Its presence is archaeology kept as decoration.

**Resolution:** delete the file. If any nugget remains load-bearing, it's moved into DESIGN.md or SUBSTRATE.md first (verified during simplification execution). Then delete.

**Files affected:** `docs/SYNTHESIS_CROSSWALK.md` (deleted); CLAUDE.md's "Deep context" section (remove the pointer to it).

**Drift modes foreclosed:**
- **#9 (deferred-by-omission)** — marking something historical without deleting it is deferring the deletion.

---

## 2. The four interrogations, applied to this walkthrough

### Graph?

What does the graph already know about naming? After item 11 (simplification execution), the graph will know each function's bare name + its owning module. The graph already indexes functions; it doesn't need module-name-as-prefix for disambiguation. **Currently the prefix is redundant with the graph's own indexing.** Removing it doesn't lose information; it lets the graph speak.

### Handler?

What handler currently projects "module.function" call sites? `infer.nx`'s VarRef arm currently resolves bare names; the FieldExpr arm constrains to records. After module-as-record synthesis, **one handler projects both `bare_name` and `module.name` access** through the same type-level substrate. One less special case; one more unified projection.

### Verb?

No pipe verb is directly at stake in this walkthrough. All naming work is at the source-site level; the topology (what gets piped to what) is unchanged. **N/A.**

### Row?

No effect-row constraint is at stake. Naming is structural; it doesn't alter what effects are performed. **N/A.**

### Ownership?

No `own`/`ref` or `Consume`/`!Alloc`/`!Mutate` change. **N/A.**

### Refinement?

No refinement predicate change. **N/A.**

### Gradient?

Does any annotation unlock something here? Docstring consistency (#1.5) makes each module's kernel-primitive and tentacle explicit, which is a gradient surface for documentation projection. Post-first-light, the `doc_handler` reads these to generate docs. **Pre-commitment, not a runtime gradient.**

### Reason?

Every rename site gets a `Reason::Inferred("renamed per NS-naming.md:<decision-number>")` attached at the infer arm, so future Why Engine walks can trace the provenance. This is discipline #1.5's obligation in action.

---

## 3. Forbidden-pattern list, per decision

### Decision 1.1 — module-function dot-access

- Drift 1 (Rust vtable): selective-import is NOT vtable lookup; it's compile-time resolution. Forbidden: treating `import X {f}` as runtime indirection.
- Drift 5 (C calling convention): the WHOLE POINT is dissolving module-prefix-as-C-namespace. Forbidden: leaving any `module_function` name behind.
- Drift 8 (string-keyed-when-structured): forbidden to introduce stringly-typed module-member lookup; dot-access resolves structurally through the synthesized record.

### Decision 1.2 — Graph → Graph

- Drift 1 (Rust vtable): N/A
- Drift 6 (primitive-type-special-case): forbidden to treat `Graph` as "the special graph" with separate dispatch; it's one ADT among many.
- Drift 8 (string-keyed): the rename is structural, not stringly — every reference updated at the source.

### Decision 1.3 — lexer/parser → lex/parse

- Drift 5 (C calling convention): forbidden to leave `lexer.` or `parser.` prefixes anywhere.
- Drift 9 (deferred-by-omission): the rename lands whole, not in halves.

### Decision 1.4 — effect-name normalization

- Drift 6 (primitive-type-special-case): forbidden to keep `HostClock` as "the real one" separate from `Clock`. Handler choice differentiates; effect name doesn't.
- Drift 8 (string-keyed): `IterativeContext` as a sentinel effect is drift; the constraint IS a row, not an effect.
- Drift 9 (deferred-by-omission): every affected site renamed in the simplification audit commit.

### Decision 1.5 — docstring consistency

- Drift 9 (deferred-by-omission): every module gets the canonical docstring in the same commit; none deferred as "later."

### Decision 1.6 — delete SYNTHESIS_CROSSWALK

- Drift 9 (deferred-by-omission): the file marked "historical" for months is deferred-deletion. Land the deletion now.

### Bug classes applicable at simplification-execution sites

- **`_ => <fabricated>` on load-bearing ADT:** during rename, every match arm updated for renamed ADT variants. Forbidden: using wildcard default to "not worry about some cases." Each variant enumerated explicitly.
- **`acc ++ [x]` loops:** simplification might expose such loops as it rewrites; convert to buffer-counter substrate per established discipline.
- **`if str_eq(a, b) == 1`:** Ω.2 legacy shape; simplification pass converts to `if str_eq(a, b) {}`.
- **Flag/mode-as-int:** rename sweep surfaces any `mode == 0` style dispatch; convert to ADT.

---

## 4. Edits as literal tokens (prescriptive)

**This walkthrough does NOT itself land edits** — it prescribes the edits that the simplification audit execution (item 11) performs. Below are representative transformation rules; simplification execution applies them across every affected site.

### Rule 1A — function declaration, same-module reference

**Pattern:**
```
// inside X.nx
fn X_foo(args) = body
...
let v = X_foo(args_here)
```

**Rewrite:**
```
// inside X.nx
fn foo(args) = body
...
let v = foo(args_here)
```

### Rule 1B — function call, cross-module, dot-access form

**Pattern:**
```
// inside Y.nx, which imports X
import src/X

let v = X_foo(args_here)
```

**Rewrite:**
```
// inside Y.nx
import src/X

let v = X.foo(args_here)
```

### Rule 1C — function call, cross-module, hot-path selective import

**Pattern:** `X_foo` called ≥ 5 times in Y.nx

**Rewrite:**
```
// inside Y.nx
import src/X {foo}

let v = foo(args_here)    // every call site drops X. prefix
```

### Rule 2 — ADT rename Graph → Graph

**Pattern:**
```
type Graph
  = Graph(List, Int, Int, List)

let Graph(nodes, epoch, next, overlays) = g
```

**Rewrite:**
```
type Graph
  = Graph(List, Int, Int, List)

let Graph(nodes, epoch, next, overlays) = g
```

### Rule 3 — file rename

```
mv src/compiler/lexer.nx → src/lex.nx
mv src/compiler/parser.nx → src/parse.nx
```

Plus every `import compiler/lexer` → `import src/lex`, every `import compiler/parser` → `import src/parse`. (Note: `src/` prefix drops post-restructure per item 17' since imports become project-relative; either form works during transition.)

### Rule 4 — effect rename

```
// before
effect HostClock { host_now() -> Instant ... }

// after: merged into Clock; the "host" variant IS a handler of Clock.
effect Clock { now() -> Instant; ... }
handler clock_real { now() => resume(system_time()) }
handler clock_test with s = 0 { now() => resume(s); ... }
```

### Rule 5 — docstring harmonization

Every `src/` and `lib/` module's top gets the canonical form from decision 1.5. Representative:

**Before** (current `src/compiler/cache.nx`, approximate):
```
// cache.nx — IC cache for module envs
```

**After:**
```
// cache.nx — per-module env cache via .kai interface files
//
// Kernel primitive served: #1 (Graph + Env)
// Mentl tentacle projected: Query (for cache-hit reporting)
//
// The cache projects each module's post-inference env into a
// content-addressed .kai file keyed by source-hash. driver.nx
// consults cache before re-inferring; hit returns env without
// re-work. Closes drift mode 10 ("the graph as stateless cache")
// at the driver level.
//
// ─── Invariants ────────────────────────────────────────────
// - cache.read returns None on source-hash mismatch; never stale.
// - cache.write happens post-inference; never mid-walk.
// - cache format v2 is textual; v3 binary follows if measured.
```

### Rule 6 — file deletion

```
rm docs/SYNTHESIS_CROSSWALK.md
```

Plus remove the pointer from `CLAUDE.md`'s "Deep context" section.

---

## 5. Post-edit audit command

After simplification execution (item 11) applies these rules, the audit is:

```
bash ~/Projects/inka/tools/drift-audit.sh src/*.nx lib/**/*.nx
```

**The audit MUST exit 0** or the simplification commit doesn't land. The audit checks for:
- Residual `Graph` references (rename incomplete)
- Residual `*_fn_name(` patterns indicating prefix-style naming (decision 1.1 incomplete)
- Residual `lexer.` or `parser.` (decision 1.3 incomplete)
- `HostClock` or `IterativeContext` residue (decision 1.4 incomplete)
- `SYNTHESIS_CROSSWALK.md` existence (decision 1.6 incomplete)
- Standard drift patterns (`_ => Fabricated`, `str_eq(a, b) == 1`, etc.)

If any pattern matches, the audit exits non-zero with the specific offending sites; the commit is refused until addressed.

**New drift patterns added to `tools/drift-patterns.tsv` as part of this walkthrough's deliverables:**
- `\bsubst_?graph\b` (case-insensitive) → flags `Graph`/`subst_graph` residue.
- `\b([a-z]+)_([a-z]+)\(` where `$1` is a known module name → flags prefix-style calls. **Cautious** (may false-positive on legitimate snake_case); implementer reviews each hit.
- `\b(lexer|parser)\.` → flags agent-form module refs.
- `\b(HostClock|IterativeContext)\b` → flags legacy effect names.
- `SYNTHESIS_CROSSWALK` → flags the archaeology file.

---

## 6. Landing discipline

**This walkthrough lands as a single focused sequence**, not split across "naming part 1 / naming part 2":

1. Walkthrough drafted (this file) — LANDED once committed.
2. `tools/drift-patterns.tsv` updated with the new patterns (small commit).
3. Simplification execution (item 11) runs across the whole `src/` + `lib/` tree in ONE focused series of commits:
   - Commit A: `Graph → Graph` ADT rename sweep (mechanical, grep-safe).
   - Commit B: module-to-record infer synthesis (~30 lines in `infer.nx`); test compiles.
   - Commit C: dot-access / selective-import conversion across all `src/` + `lib/` modules (largest commit; audit clean before closing).
   - Commit D: effect normalization (`HostClock` → `Clock`, `IterativeContext` dissolution).
   - Commit E: file renames (`lexer.nx` → `lex.nx`, `parser.nx` → `parse.nx`) + every import updated. (Fold into restructure item 17' for extension migration.)
   - Commit F: docstring harmonization (per-module passes; can split by directory if size warrants).
   - Commit G: delete `SYNTHESIS_CROSSWALK.md` + remove CLAUDE.md pointer.
   - Commit H: doc updates propagating the renames into DESIGN.md, SUBSTRATE.md, CLAUDE.md, README.md, SYNTAX.md, specs, walkthroughs, traces, memory files (this is items 12-16, 19, 20, 21, 22 combined).

**No commit in the sequence lands with a non-zero drift audit.** Each commit is a functioning intermediate state. The sequence closes when commit H clears; after that, the whole naming reform is complete and irreversible.

**This walkthrough does NOT split into sub-handles.** NS-naming is one handle; it lands whole. No deferred-by-omission.

---

## 7. Dispatch

This walkthrough has the contract-shape required for dispatch. Three options:

**Option A — dual-tier (default, cheapest for planner context):**
```
Agent({
  subagent_type: "inka-implementer",
  prompt: "<this walkthrough, verbatim, + pending work item 11 framing>"
})
```
Inka-implementer (Sonnet by default) executes the sweep mechanically; simplification audit discipline is in its system prompt.

**Option B — Opus-on-Opus (for the most delicate renames):**
```
Agent({
  subagent_type: "inka-implementer",
  model: "opus",
  prompt: "<walkthrough verbatim>"
})
```
Same walkthrough; Opus for the subagent preserves full reasoning capability on subtle rewrite sites.

**Option C — Opus inline (current session):**
Opus (this session) applies edits directly, one commit at a time, per the sequence in §6. Slower per-commit but keeps the cascade reasoning in one coherent session.

**My recommendation: Option C for commits A+B+G (substantive, small); Option A or B for commits C+D+E+F+H (mechanical, large).** Reasoning: the ADT rename + infer synthesis + file deletion are the "surgery" steps where subtle decisions might surface (e.g., an edge case in module-to-record synthesis); the sweep commits are mechanical and safe for subagent dispatch.

---

## 8. What closes when NS-naming lands

- Item 10 (extension migration) ready to ride through the same sweep.
- Item 11 (simplification execution) fully specified; no design left, only transcription.
- Items 12–16 (doc updates) scoped; they ride through commit H.
- Item 17' (structural migration) can now reference canonical names in its own walkthrough (`NS-structure.md`) without re-litigating.
- Items 19, 20, 21, 22 (spec + walkthrough + trace + memory updates) scoped as part of commit H.
- The compiler source becomes Inka-native-named throughout; every call site reads as structural access, not C-style mangling.
- The drift-audit gets five new patterns permanently defending against regression.

**Sub-handles split off for future walkthroughs:**

None. Every decision in this walkthrough is complete and self-contained.

---

## 9. Riffle-back items (audit after NS-naming lands)

1. **Re-read H1 (evidence reification) walkthrough** in light of module-as-record synthesis. Evidence ADTs might benefit from the same synthesis shape; check for unification. Cascade discipline #4 (audit-after-land) applies.
2. **Re-read H2.3 (nominal records) walkthrough** — module-as-record brings module naming into the record family. Does H2.3 need addenda? Likely: nominal vs. structural records; modules are their own record-identity kind. Note as "riffle-back" in H2.3.
3. **Audit the docstring template** against actual usage. If every module ends up with 3-5 boilerplate lines that say the same thing, the template is too rigid; tighten in a subsequent pass.
4. **Confirm drift-audit performance** after the new patterns land. Grep over ~20k lines should stay sub-second; if not, pattern refinement needed.

---

## 10. Closing

NS-naming turns a 548-function C-style-prefixed compiler into Inka-native dot-access notation, renames the substrate to what it IS (`Graph`), matches filenames to the verb form that already dominates, normalizes effect names, harmonizes docstrings around kernel-primitive-served, and deletes the last archaeology file. The simplification audit that follows this walkthrough has no design questions left — only mechanical application of these rules across the `src/` + `lib/` tree, gated by drift audit.

**One walkthrough, one sequence of commits, one Inka-native compiler.**
