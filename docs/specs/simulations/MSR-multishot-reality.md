# MSR — Multi-Shot Reality · gap audit and implementation design

> **Status:** `[DRAFT 2026-04-23]`. MS2-multishot-full-territory.md
> mapped the territory. MSR audits which claims are already real,
> which are executable-but-blocked, which need new substrate, and
> which are domain aspirations that earn their own crucibles. Then
> designs the gap-closing implementation path.
>
> **Surprising finding:** the oracle loop substrate is ALREADY
> implemented in `src/mentl.nx` (gradient_next + try_each_annotation_loop
> + apply_annotation_tentatively + verify_after_apply + trail-based
> rollback via graph_push_checkpoint / graph_rollback). The
> speculative gradient is real substrate, not aspiration. What's
> missing is execution (bootstrap at first-light) and four specific
> kernel-surface pieces.

---

## 0. Framing

MS2's territory map makes ~60 claims about multi-shot composition
with Inka's kernel. This audit classifies each claim:

- **Category A — Substrate exists, bootstrap-gated.** The VFINAL
  code in `src/*.nx` implements the claim. Needs first-light to
  actually run. Closing BT (cross-module linker) unblocks.
- **Category B — Substrate missing, new code needed.** Specific,
  bounded pieces. Each named with a design below.
- **Category C — Domain aspiration.** MS2 §2.1–§2.13 claims about
  specific ecosystems (PyTorch, Stan, Prolog, etc.) collapsing
  into handler stacks. Each earns its own crucible per CRU; not
  a single substrate delivery.
- **Category D — Downstream of substrate.** MV voice register,
  pedagogical ladder, self-modifying-programs guardrails. Land
  after substrate + first-light.

**Counting exercise** (approximate):

| Category | Count | Landing surface |
|----------|-------|-----------------|
| A (exists, bootstrap-gated) | ~25 | First-light (BT + Hβ §12 Leg 1) |
| B (substrate-missing) | 6 | This walkthrough designs each |
| C (domain aspiration) | ~10 | Per-crucible work (CRU) |
| D (downstream) | ~5 | MV.2 + tutorial + guardrails |

The finding: **MS is not primarily missing substrate. It is
mostly present and waiting for first-light to run, with a handful
of bounded kernel-surface extensions.**

---

## 1. Reality matrix — MS2 claim by claim

*Format: MS2 §X.Y claim | status (A/B/C/D) | evidence or gap description.*

### §1.1 MS × Graph + Env

| Claim | Status | Evidence / gap |
|-------|--------|----------------|
| Trail is flat buffer + counter (`trail_len`) | **A: REAL** | `src/graph.nx:38` (layout), `:57` (handler init), `:431-434` (trail_append) |
| `graph_push_checkpoint` / `graph_rollback` effects | **A: REAL** | `src/types.nx:609,618` (decls), `src/graph.nx:90-91,218-224` (impl) |
| Rollback is O(M) exact | **A: REAL** | `src/graph.nx:410-428` (revert_trail — recursive backward walk) |
| Per-fork state preservation by identity | **A: REAL** | Graph handler's state IS the rolled-back state; semantics correct by construction |
| Env extension/scope rolled back | **A: REAL** (for graph) / **B partial** (for env overlay) | Graph trail includes graph bindings; env_scope rollback is a separate trail-adjacent mechanism — verify coherence |

**Verdict:** §1.1 is substantively real. Minor gap: verify env rollback composes cleanly with graph rollback in speculation.

### §1.2 MS × Handlers with typed resume discipline

| Claim | Status | Evidence / gap |
|-------|--------|----------------|
| `ResumeDiscipline = OneShot | MultiShot` ADT | **A: REAL** | `src/types.nx:70-72` |
| `@resume=OneShot` pervasively declared | **A: REAL** | 30+ sites in `src/types.nx` |
| `@resume=MultiShot` used on actual ops | **A: PARTIAL** | ONE site: `enumerate_inhabitants` in `src/mentl.nx:94`. Need more MS-typed ops for the substrate's claim to be live. |
| `TCont(Ty, ResumeDiscipline)` continuation type | **A: REAL** | `src/types.nx:48` |
| MS runtime — heap-captured closure with captures + evidence + return slot | **B: MISSING** | No `LMakeContinuation` or equivalent in `src/lower.nx`. Bootstrap emit path undefined for MS arms. |
| Compile-time detection of >95% ground (OneShot direct call) | **A: REAL** in substrate, **A: UNPROVEN** in emitted code — pending first-light |
| Nesting composition (MS-in-OneShot, OneShot-in-MS) | **C: UNEXERCISED** | Substrate supports it; no crucible tests nested composition yet |
| Capability stack × resume discipline at install | **A: PARTIAL** | Row subsumption checks at handler install; resume discipline enforcement in row-subsumes NOT explicit (TBD) |

**Verdict:** §1.2 half real, half pending. The big gap is the **runtime MS emit path** — required for any MS op to actually fork at runtime. Design: **Edit 1 below.**

### §1.3 MS × Five verbs

| Claim | Status | Evidence / gap |
|-------|--------|----------------|
| `|>` × MS (pipe re-evaluates per fork) | **A: REAL at AST/inference level** | Semantics follow from handler discipline; pending runtime emit |
| `<|` × MS (inline-Form-B contains, block-Form-A propagates) | **A: REAL** | SYNTAX Σ + parser lands Form A vs B distinction |
| `><` × MS (independent tracks fork independently) | **A: REAL** at semantics; **C: UNEXERCISED** |
| `~>` × MS (handler install IS where MS lives) | **A: REAL** | Handler install composes fine with MS |
| `<~` × MS (feedback × fork = particle filter) | **B: LF substrate PENDING** | LF walkthrough (PLAN item 1) not yet implemented; `<~` lowering is the Priority-1 gap in PLAN Pending Work |

**Verdict:** four of five verbs real; `<~` blocked by LF substrate (already named in PLAN item 1; not new work).

### §1.4 MS × Boolean effect algebra

| Claim | Status | Evidence / gap |
|-------|--------|----------------|
| Row carries resume discipline | **A: PARTIAL** | Types carry it via `TCont`; row algebra not yet explicitly typed by resume discipline (future extension per MS2 §9.1) |
| `!Choice` proves determinism | **B: MISSING** | `Choice` effect not declared anywhere — design Edit 2 below |
| Subsumption admits MS-capable handlers | **A: REAL** at types; row_subsumes does not yet check resume-compat explicitly |
| `!MultiShot` as row modifier | **C: ASPIRATION** | Explicitly named by MS2 §9.1 as open substrate question; punt until exercised |

**Verdict:** The canonical MS op surface (`Choice`) is missing. **Edit 2 below.**

### §1.5 MS × Ownership

| Claim | Status | Evidence / gap |
|-------|--------|----------------|
| D.1 three handlers (replay_safe / fork_deny / fork_copy) | **B: MISSING** | None implemented. Named in DESIGN Ch 6.D.1. Design Edit 4. |
| Replay-safe MS admissible in `!Alloc` | **A: REAL at type level** (no fork alloc); **B: UNVERIFIED** (no replay_safe handler exists) |
| MS with `own` through graph | **A: REAL at type level** | `own` + Consume effect trail through graph |
| Fork-allocating MS forbidden in `!Alloc` | **A: REAL at type level** | Row subsumption enforces |

**Verdict:** the three-handler substrate is named and scoped but unwritten. **Edit 4 below.**

### §1.6 MS × Refinement

| Claim | Status | Evidence / gap |
|-------|--------|----------------|
| Speculative verification: candidate + Verify discharge + rollback | **A: REAL** | `src/mentl.nx:163-175` (the full pattern: checkpoint → apply_tentative → verify_after_apply → rollback) |
| `verify_ledger` accumulates | **A: REAL** | `src/verify.nx:20-30` |
| `verify_smt` handler swap | **B: MISSING** | Arc F.1 pending. Design Edit 3 below. |
| Refinement SMT as handler race | **B: DEPENDS ON race + verify_smt** | Compound gap |

**Verdict:** Ledger path real; SMT path missing. **Edits 3 + 5 below.**

### §1.7 MS × Gradient (the oracle loop)

| Claim | Status | Evidence / gap |
|-------|--------|----------------|
| **The oracle loop** per MO §1 | **A: REAL** | `src/mentl.nx:155-175` — this IS the loop, line-for-line per MO |
| 8-candidate cap per hole | **A: REAL by intent** | `gradient_next` enumerates 4 base + N ownership candidates; policy enforceable |
| Tiebreak chain (row-minimality → chain depth → intent → span → lex) | **B: PARTIAL** | `pick_highest_leverage` uses a priority list; full tiebreak chain not yet encoded. Minor design. |
| 50ms interactive latency budget | **C: UNMEASURED** | Once bootstrap runs, measure |
| race combinator for parallel speculation | **B: MISSING** | No `race` handler. Design Edit 5 below. |
| SMT cache | **C: POST-first-light** | Cache substrate exists (PLAN Phase B); SMT layer needs it plus `.inka/handlers/` |

**Verdict:** the loop itself is real; tiebreak + race are the bounded gaps.

### §1.8 MS × Reason

| Claim | Status | Evidence / gap |
|-------|--------|----------------|
| MS fork records Reasons on graph_bind | **A: REAL** | Graph handler records `Reason` with every `graph_bind` |
| Rollback unwinds Reasons | **A: REAL** | Trail includes the full binding record; rollback is complete |
| "Why did Mentl propose X?" traceable | **A: SUBSTRATE REAL** | `why_from_handle` + Reason chain walk in mentl.nx; **C: UNSURFACED** via voice |

**Verdict:** §1.8 fully real at substrate; voice surfacing is Category D.

### §2 Domain traversals

**All Category C.** MS2 §2.1-§2.13 enumerates 13 domains where
the claim is "this industry framework dissolves into a handler
stack." Each is an aspiration claim, not current reality. Each
earns one crucible under CRU. PLAN's Convergence entry names the
five crucibles to land; additional domains get additional
crucibles as they're exercised.

### §3 Mentl's substrate

**Mostly Category D.** The oracle loop substrate (§3.3) IS real.
The voice register (§3.4) is Category D — implementation in MV.2
per PLAN.

### §4 Emergent topology

Category C — aspirational map of frameworks that CAN dissolve.
Each row of the 15-row table is a potential crucible.

### §5–6 Drift risks + forbidden compositions

**Meta-discipline, not code.** Documented in MS2 as the
responsibility of implementers. Enforced via drift-audit.sh
(fluency-trap sentinel) + code review. No substrate to "land."

### §7 Pedagogical ladder

**Category D.** `lib/tutorial/02b-multishot.nx` does not exist.
Design Edit 6 below.

---

## 2. The gap inventory — six Category-B edits

The design closes these six concrete substrate pieces. Each is a
single file or adjacent files; each has a walkthrough citation
OR is itself named as a new walkthrough item.

**Edit 1:** MS runtime emit path (heap-captured continuation) — `src/lower.nx` + `src/backends/wasm.nx` + `bootstrap/src/emit_*.wat`.

**Edit 2:** `Choice` effect + `choose` MS op — `src/types.nx` (declaration) + `lib/prelude.nx` (possibly).

**Edit 3:** `verify_smt` handler — `src/verify.nx` extend (Arc F.1).

**Edit 4:** Arena-aware MS handlers — `replay_safe` / `fork_deny` / `fork_copy` — new file or extend `src/own.nx`.

**Edit 5:** `race` handler combinator — `lib/prelude.nx` or new `lib/runtime/combinators.nx`.

**Edit 6:** `lib/tutorial/02b-multishot.nx` — the learner's first MS.

Plus **Blockers (Category A resolution):** BT linker work (separate from this walkthrough; see BT).

---

## 3. Edit designs

*Each edit: eight interrogations, forbidden patterns, and the literal shape of the new code.*

### Edit 1 — MS runtime emit path

**Problem:** `@resume=MultiShot` ops have no emit path. `lower.nx` can produce `LMakeClosure` for evidence-passing (per H1 walkthrough); a MS continuation is a variant of that shape — captures + evidence + return slot + trail-rollback awareness — but no corresponding `LMakeContinuation` (or `LMakeMultiShot`) constructor exists.

**Graph?** The graph encodes `@resume=MultiShot` on each op; `TCont(ret, MultiShot)` at perform sites; inference proves which sites are polymorphic (requiring `call_indirect`).

**Handler?** The `emit_alloc` handler (per γ crystallization #8 "the heap has one story") allocates the MS closure struct — same swap surface as OneShot closures + records + variants.

**Verb?** `~>` for handler install at MS sites; the continuation struct is the runtime residue of `~>` ordering.

**Row?** Resume discipline already in `TCont`; row carries effect identity. No change to row algebra.

**Ownership?** MS fork captures closure state — `own` fields deep-copied on fork-copy, re-performed on replay-safe, forbidden on fork-deny. The three arena handlers (Edit 4) distinguish.

**Refinement?** No refinement changes; MS is orthogonal to refinement types.

**Gradient?** This edit unlocks the oracle loop to actually execute at runtime. Gradient capability: MultiShot → CGradientOracle (new Capability variant for clarity).

**Reason?** Each MS fork's `graph_bind` records `Reason` per current substrate; no change needed.

**Landing:** land alongside Hβ Tier 3 (incremental self-hosting). Specifically, when `src/lower.nx` self-compiles, the MS emit path is one of the earliest modules to exercise because `mentl.nx` depends on it.

**Forbidden patterns at this edit:**

- **Drift 1 (Rust vtable):** CRITICAL. MS dispatch through closure's `fn_index` FIELD, NEVER through a `multishot_dispatch_table`. Per CLAUDE.md / INSIGHTS §8.
- **Drift 5 (C calling convention):** One `$continuation_ptr` parameter; offsets into it for captures + evidence + return slot. NEVER separate `$closure` + `$ev` + `$rs` parameters.
- **Drift 6 (primitive-type-special-case):** MS closure allocates via SAME `emit_alloc` as ADT variants + records. No special "MS allocator."
- **Drift 9 (deferred-by-omission):** Either emit MS for ALL `@resume=MultiShot` ops, or reject such ops at emit time with `E_UnimplementedMultiShot`. No "some MS works, some doesn't."

**Substrate touch sites (design; literal tokens pending inka-plan at execution):**

| File | Section | Purpose |
|------|---------|---------|
| `src/types.nx` | Add `LMakeContinuation(captures, ev_list, ret_slot)` variant to `LowExpr` | IR shape for MS capture |
| `src/lower.nx` | `lower_perform` arm on `@resume=MultiShot` op | Emit `LMakeContinuation` + continuation-resume call site |
| `src/backends/wasm.nx` | Match `LMakeContinuation` | Emit `emit_alloc(size) + store_captures + store_ev + return_slot_placeholder` |
| `bootstrap/src/emit_expr.wat` | Hand-WAT the MS continuation allocation | Mirror for bootstrap |

**Walkthrough:** NEW — `H7-multishot-runtime.md` (name for the peer to H1 evidence reification; H1 did OneShot, H7 does MultiShot). Scope: design the emit shape with full walkthrough discipline (layer trace, three design candidates, Mentl's choice). PLAN adds this as **Priority-1 substrate item 1.5** (after current item 1 LFeedback).

**Dispatch:** Opus-level substrate work. Not Sonnet-suitable.

---

### Edit 2 — `Choice` effect + `choose` op

**Problem:** MS2 claims `Choice` is canonical MS; no `Choice` effect exists in repo.

**Graph?** `Choice` is a new effect; its declaration adds one entry to the effect registry (primitive #1 — graph extension).

**Handler?** One op: `choose(options: List<A>) -> A @resume=MultiShot`. Handlers for `Choice` are where search strategies live (DPLL, enumerative, probabilistic).

**Verb?** `Choice` is composed into user code via `perform choose(...)` — typically inside a `~>` chain.

**Row?** `Choice` is an effect name (EffName variant). `with Choice` in rows allows forking; `with !Choice` proves determinism (§1.4).

**Ownership?** `choose(options)` borrows `options`; the chosen `A` is ownership-polymorphic (per generic type).

**Refinement?** Not required for declaration.

**Gradient?** `Choice` unlocks search domains (§2.1 in MS2).

**Reason?** Each `perform choose` site carries a Reason edge; handler's resume per-candidate records a fork reason.

**Forbidden patterns:**

- **Drift 3 (Python dict / string-keyed effect):** `Choice` is an `EffName` ADT variant (one of `EChoice` per effect-name registry), NOT `"Choice"` string.
- **Drift 6 (primitive-type-special-case):** `Choice` declares like any user effect; no compiler special-case.
- **Drift 9 (deferred):** Declare `Choice` + one example handler together; NOT "Choice today, handler later."

**Substrate touch sites:**

| File | Change |
|------|--------|
| `src/types.nx` | Add `Choice` to `EffName` ADT (enumerate alongside Alloc, IO, Network, etc.) — tracked alongside the existing ENamed drift-mode-8 item in PLAN 11.B |
| `lib/prelude.nx` or new `lib/runtime/search.nx` | Declare `effect Choice { choose(options: List<A>) -> A @resume=MultiShot }` |
| `lib/runtime/search.nx` | Example handler — `handler pick_first` (OneShot terminates at first) + `handler backtrack` (MS, tries each option, accepts first that doesn't Abort) |

**Walkthrough:** NEW — `CE-choice-effect.md`. Scope: one op, two canonical handlers, interaction with trail rollback. Small.

**Dispatch:** Opus or inka-implementer with the walkthrough + existing effect-declaration patterns from prelude.

---

### Edit 3 — `verify_smt` handler (Arc F.1)

**Problem:** SMT dispatch path is named in DESIGN 9.7 + multiple specs but unimplemented. Without it, refinement obligations accumulate in `verify_ledger` indefinitely; the handler-swap thesis claim for Verify is not demonstrably real.

**Graph?** `verify_ledger` exists; `verify_smt` is a peer handler, same effect signature, different resolution strategy.

**Handler?** This IS a handler edit. `handler verify_smt` with state tracking solver backend + cache. Dispatches per predicate shape to Z3 / cvc5 / Bitwuzla per residual theory (DESIGN 9.7).

**Verb?** Installed via `~>` at the pipeline head for invocations that require full SMT. Typical: `main() ... ~> verify_smt` at the outermost.

**Row?** Handles `Verify` effect, same as `verify_ledger`. Row subsumption is preserved.

**Ownership?** SMT session state is handler-local; predicates are `ref`-passed.

**Refinement?** Verify handler IS the refinement discharge mechanism. This edit closes the loop.

**Gradient?** Installing `verify_smt` unlocks CRefinementVerified capability.

**Reason?** Rejected predicates carry the SMT's unsat core as Reason. Accepted predicates carry the SMT's proof sketch.

**Forbidden patterns:**

- **Drift 1 (Rust vtable):** SMT solver dispatch is NOT a dispatch table. Per-theory routing is a nested handler chain (`~> verify_z3 ~> verify_cvc5 ~> verify_bitwuzla`), fall-through per MS2 §1.6. Each solver handler matches on predicate shape.
- **Drift 3 (string-keyed effect):** predicate classification via `type TheoryClass = TLinearArith | TBitvector | TArray | TUF | TNonlinear` ADT, NOT `"linear_arith"` string.
- **Drift 6 (primitive-type-special-case):** SMT solvers are regular handlers; no compiler-intrinsic SMT knowledge.
- **Drift 9 (deferred):** Land `verify_smt_ledger` (delegates to ledger for unsupported theories + caches decisions) + at least one theory solver stub (even if it's a trivial linear arith prover) together. NOT "framework shell now, solvers later."

**Substrate touch sites:**

| File | Change |
|------|--------|
| `src/verify.nx` | Add `handler verify_smt` state + theory-classify + dispatch + cache |
| `src/verify.nx` | Add `classify_theory(predicate) -> TheoryClass` (complements existing `classify_predicate`) |
| `lib/runtime/smt/` (NEW dir) | Stub solver-bridge handlers: `smt_linear_arith`, `smt_bitvector`, `smt_nonlinear`. Each stub returns `V_Pending` with solver-specific reason until real bindings land |

**Walkthrough:** Existing placeholder in DESIGN 9.7 + specs 02, 11. Formalize into new `VK-verify-kernel.md` or extend existing `RT-refinement-boundaries.md`. Design decision: one walkthrough covers verify_smt + three theory bridges.

**Dispatch:** Opus for architecture + at least one real solver bridge (likely linear arith for immediate utility).

---

### Edit 4 — Arena-aware MS handlers (D.1)

**Problem:** DESIGN Ch 6.D.1 names three handlers — `replay_safe`, `fork_deny`, `fork_copy` — to resolve MS × arena. None implemented. Without them, MS is unusable in any program that also uses `temp_arena` (which is every non-trivial program).

**Graph?** Three handlers, each intercepting `Alloc` + `Consume` + the MS resume discipline. Each implements a different capture semantics.

**Handler?** This edit IS three handlers. Each differs in its resume arm's behavior.

**Verb?** Installed via `~>` inside `temp_arena` scope. Stack: `main() ... ~> temp_arena(4MB) ~> replay_safe (or fork_deny, or fork_copy) ~> synth_enumerative`.

**Row?** Each handler manages `Alloc + Consume + @MS-capture` interaction at row level; row subsumption at install time enforces compatibility.

**Ownership?** Heart of the composition. `replay_safe` re-performs upstream ops on resume; `fork_deny` rejects captures at capture time; `fork_copy` deep-copies into parent arena.

**Refinement?** `!Alloc` under MS admits only `replay_safe` — this IS the refinement-level enforcement (proven at handler install, not runtime).

**Gradient?** Three handlers for three policies; user picks per need. The gradient surfacing: Mentl's Teach tentacle suggests `replay_safe` as default (proof-preserving); Trace tentacle diagnoses if `fork_deny` would have caught an escape.

**Reason?** Each handler's arms record why a fork succeeded (replay trace) or failed (fork_deny's rejection reason).

**Forbidden patterns:**

- **Drift 1 (vtable):** Three handlers are three handler declarations, NOT one handler with a `mode` field. Drift 8 too.
- **Drift 8 (mode-as-int):** NEVER `capture_mode == 0 (replay) | 1 (deny) | 2 (copy)`. Each handler is a named declaration.
- **Drift 9 (deferred):** All three land together. `replay_safe` is default (matches current trail semantics); `fork_deny` + `fork_copy` are the richer policies.

**Substrate touch sites:**

| File | Change |
|------|--------|
| NEW `lib/runtime/arena_ms.nx` | Three handlers + their state records + arms |
| `src/own.nx` | Add escape-analysis extension for fork-deny detection (TContinuationEscapes diagnostic) |

**Walkthrough:** NEW — `AM-arena-multishot.md`. Scope: the D.1 question with concrete handler shapes.

**Dispatch:** Opus — ownership substrate is subtle.

---

### Edit 5 — `race` handler combinator

**Problem:** MS2 §1.3.4, §1.6 use `~> race(...)` for parallel speculation. `race` is named in DESIGN Ch 8.10.3 as a "library function, not a new operator." Library function not yet written.

**Graph?** `race` reads handlers' declared effect rows; proves the three it's combining share an effect signature; installs a single handler that dispatches via MS to each.

**Handler?** `race` is a handler-combinator. Not a handler directly; it RETURNS a handler that races its inputs.

**Verb?** Used as `~> race(h1, h2, h3)`.

**Row?** The row handled by `race(h1, h2, h3)` is the intersection of the rows handled by each input. Enforced at install.

**Ownership?** Input handlers are `ref`; the returned composite handler is `own` (new handler identity).

**Refinement?** The first-verified-wins semantic requires a canonical
ordering on survivors — tiebreak chain from the roadmap's
survivor-ordering discipline.

**Gradient?** Capability: CProvenFastest — the first verified candidate wins its own latency budget.

**Reason?** The winning handler's Reason chain is committed; losers' Reasons are discarded on rollback (trail handles this).

**Forbidden patterns:**

- **Drift 1 (vtable):** `race` is a function returning a handler; NOT a handler-dispatch-table with three entries.
- **Drift 4 (nested handle):** `race(h1, h2, h3)` is one installation, not `handle (handle (handle body with h1) with h2) with h3`.
- **Drift 24 (async/await):** "race" is a common JS idiom. Inka's `race` is NOT thread racing — it's MS candidate racing. Vocabulary matters.

**Substrate touch sites:**

| File | Change |
|------|--------|
| `lib/runtime/combinators.nx` (NEW) | `fn race(handlers: List<Handler>) -> Handler` |
| `lib/runtime/combinators.nx` | Supporting: `first_verified_wins` tiebreak helper |

**Walkthrough:** Short — extend CE-choice-effect.md or new `HC2-handler-combinators.md`. Scope is small.

**Dispatch:** Opus for the tiebreak + rollback discipline; implementer for the mechanical expansion.

---

### Edit 6 — `lib/tutorial/02b-multishot.nx`

**Problem:** Pedagogical gap per MS2 §7. Tutorial has 00–08 files keyed to the kernel primitives; MS (primitive #2's resume discipline) doesn't have a dedicated file.

**Graph?** This is a learner-facing file; uses existing graph vocabulary.

**Handler?** Demonstrates `Choice` handler; demonstrates speculative rollback visible to the learner.

**Verb?** `|>` + `~>` within the example.

**Row?** `with Choice`; one handler absorbs.

**Ownership?** `ref` options; `own` returned values.

**Refinement?** Not the tutorial's focus.

**Gradient?** This file IS a gradient step — teaching MS in residue form.

**Reason?** Each `choose` call's Reason is visible to the reader via `inka query`.

**Forbidden patterns:**

- **Drift 11 (`acc ++ [x]`):** CRITICAL — the tutorial sets the tone. Any example that accumulates via `++ [x]` gets copied by learners.
- **Drift 9 (deferred):** The tutorial is 30-50 lines running; no "TODO more examples."
- **Drift 30 (for/while):** The canonical MS example (N-queens style) uses `choose` + recursion, NOT a for loop.

**Substrate touch sites:**

| File | Change |
|------|--------|
| NEW `lib/tutorial/02b-multishot.nx` | ~40 lines: N-queens or equivalent canonical backtracking problem |

**Walkthrough:** None needed; tutorial files are exemplars, not substrate.

**Dispatch:** inka-implementer with CE walkthrough + the existing 00-08 tutorial patterns.

---

## 4. Sequence — Phases α / β / γ / δ

*Closing MS2's reality gap. Dependencies forced left-to-right.*

### Phase α — Unblock execution (Category A activation)

**α.1:** BT linker pass — cross-module reference resolution. Per
BT walkthrough §5 (sequential close-out; structural continuation
signals per BT §4, not temporal). Unblocks most Category A claims
simultaneously.

**α.2:** Hβ §12 Leg 1 — byte-identical self-compilation. Tag
`first-light-L1`.

**Critical refinement (2026-04-23):** self-compilation EXERCISES
`@resume=OneShot` ops ONLY. The code path lex → parse → infer →
lower → emit has zero MultiShot perform sites in its trace, even
though `src/mentl.nx` DECLARES MS ops that aren't invoked during
self-compile (they fire under `inka teach`, not `inka compile`).

**Consequence:** `first-light-L1` can close on the CURRENT hand-WAT
substrate, without H7 (Edit 1 / MS runtime emit). The ~18 of ~25
Category A claims that compose into the self-compile path are
activated at L1; the ~7 that require MS runtime wait for β.1.

At end of α, the OneShot Category A claims EXECUTE (trail rollback
usable at compile time by inference; graph substrate live; etc.).
MS-dependent Category A claims (the oracle loop actually
TRANSFERRING CONTROL to multi-shot arms) wait for β.1.

### Phase β — Complete the kernel surface (Category B)

**β.1:** Edit 1 — MS runtime emit (H7 walkthrough + substrate).
MOST IMPORTANT single β piece. Unblocks every MS-op runtime.
Walkthrough-first per Anchor 7; lands when its walkthrough
paragraphs resolve every design question. Hand-WAT grows via
Tier 3 (Hβ §2 + §12.2) — VFINAL-on-partial-WAT compiles
H7-extended `src/lower.nx` + `src/backends/wasm.nx`; diff into
hand-WAT; audit per walkthrough paragraph. No foreign-language
shortcut; no session budget.

**β.2:** Edit 2 — `Choice` effect (CE walkthrough). Small
substrate addition.

**β.3:** Edit 5 — `race` combinator. Library-level.

**β.4:** Edit 4 — Arena-aware MS handlers (AM walkthrough).
Ownership substrate.

**β.5:** Edit 3 — `verify_smt` + theory stubs. Handler-swap
substrate + at least one real solver bridge.

Ordering within β is partially independent: β.2 (Choice) and
β.3 (race) can land before β.1 (they're declarations + library
code, no emit-path change); β.4 and β.5 have real dependencies
on β.1 since they exercise MS at runtime.

### Phase γ — Crucibles run (Category C — MS2 §2 + §4)

**γ.1:** CRU seeds land (Convergence thread 6) — five crucible
`.nx` files per the plan.

**γ.2:** `crucible_oracle.nx` passes first — proves the oracle
loop at interactive latency.

**γ.3:** Remaining four crucibles (`dsp`, `ml`, `realtime`, `web`)
each fail on one named substrate piece; pass as that piece lands.

**γ.4:** Additional domain crucibles for MS2 §2.5-§2.13 (search /
logic prog / testing / games / debug / graphics / etc.) — each its
own crucible + landing.

Per PLAN, each domain-crucible pass is a milestone; Phase γ is
open-ended by design.

### Phase δ — Voice, guardrails, pedagogy (Category D)

**δ.1:** MV.2 — voice implementation per MV walkthrough §2.7-§2.8.
Renders the 20 VoiceLines (§2.9) over real MS data.

**δ.2:** Edit 6 — `lib/tutorial/02b-multishot.nx`.

**δ.3:** Hβ §12 Leg 2 — `verify_smt` on refinement witness. Tag
`first-light-L2`.

**δ.4:** Hβ §12 Leg 3 — all five crucibles pass. Tag `first-light`
FINAL.

**δ.5:** Drift-risk guardrails land as drift-audit.sh patterns
for MS-specific drift modes (§5 of MS2).

---

## 5. Order dependency graph

```
α.1 (BT linker) ────────────────────────────┐
                                            │
α.2 (first-light-L1) ──┬──────────────┐     │
                       │              │     │
β.2 (Choice)* ─────────┤              │     │
β.3 (race)* ───────────┤              │     │
                       │              │     │
β.1 (H7 MS runtime) ───┤              │     │
                       │              │     │
β.4 (arena MS) ────────┤              │     │
β.5 (verify_smt) ──────┘              │     │
                                      │     │
γ.1 (CRU seeds land) ─────────┐       │     │
γ.2 (oracle crucible pass) ───┤       │     │
γ.3-4 (domain crucibles) ─────┤       │     │
                              │       │     │
δ.1 (MV.2 voice) ─────────────┤       │     │
δ.2 (tutorial 02b) ───────────┤       │     │
δ.3 (first-light-L2) ─────────┘       │     │
                                      │     │
δ.4 (first-light FINAL) ──────────────┘─────┘
```

*β.2 (Choice) and β.3 (race) can land before β.1 — they're
declarations + library code, no emit-path changes. β.4 and β.5
require β.1 because they exercise MS at runtime.

**Critical path** (structural, not temporal): α.1 → α.2 → β.1 →
γ.2 → δ.3 → δ.4. Each node closes when its walkthrough-paragraph
→ substrate mapping is clean and audit returns 0. No budget;
scope emerges from substrate necessity.

---

## 6. Risk assessment

| Risk | Probability | Mitigation |
|------|-------------|------------|
| H7 MS runtime emit is harder than scoped (unexpected nesting cases) | Medium | Walkthrough first, per Anchor 7; if walkthrough reveals additional substrate questions (e.g., continuation lifetime across module boundaries), split into named peer walkthroughs H7.1 + H7.2 rather than one over-scoped walkthrough |
| Cross-module MS composition (MS2 §9.3 open question) surfaces during β.1 | Medium | Addressed alongside BT linker (α.1) — linker preserves resume discipline metadata |
| `verify_smt` bindings heavier than expected (z3 FFI via WASI preview 1) | Medium | Stub theory solvers with pure-Inka linear arith first; real solver FFI is Arc F.1 follow-on |
| Oracle loop latency exceeds 50ms budget on real codebases | Medium | Per MO §3 mitigations: hoist checkpoint, race, incremental re-infer, SMT cache; measure continuously |
| MS behavior diverges across wasmtime/wasm-interp | Low | DET walkthrough already names this; cross-check in first-light harness |
| Domain crucible fails in unexpected ways (thesis regression) | Medium | Each crucible names its own gap; if thesis-scale fail, earns its own substrate walkthrough |

---

## 7. What this walkthrough is NOT

- NOT a complete H7 walkthrough (H7 is its own deliverable).
- NOT a complete CE / VK / AM walkthrough (each is its own deliverable).
- NOT a schedule. Inka doesn't measure in sessions; it measures in substrate clarity per walkthrough paragraph. The territory in MS2 §2-§4 is open-ended per CRU's "crucibles lead the language" protocol — each domain crucible lands when its substrate is ready.
- NOT a commitment to land ALL six edits sequentially — some (Edit 2, 5, 6) can parallelize with Edit 1 if cheap subagent dispatch is exercised.

---

## 8. Landing

**This walkthrough lands as design contract.** `ROADMAP.md`
gets a 2026-04-23 entry naming MSR as the MS2 implementation
design.

Subsequent PLAN items derived from MSR:

- Pending Work **Priority-1 item 1.5** (new): **H7 MS runtime
  walkthrough + substrate** (Edit 1).
- Pending Work **new items**: CE-choice-effect (Edit 2),
  AM-arena-multishot (Edit 4), `race` combinator (Edit 5),
  extended VK-verify-kernel for `verify_smt` (Edit 3), tutorial
  02b (Edit 6).

Each new walkthrough is scheduled after H7 (Edit 1) per the
dependency graph in §5.

---

## 9. Closing

**Reality audit finding: the oracle loop substrate is more real
than MS2 suggests.** `src/mentl.nx:155-175` IS the loop. The
graph's trail-based rollback IS the substrate MS rolls against.
`Synth` + `Teach` + `Verify` effects are all declared. The
`apply → verify → rollback` checkpoint pattern is in VFINAL code
today.

**What's missing is narrower than it first appears:**
- One emit path (Edit 1 — H7 walkthrough).
- One canonical user effect (Edit 2 — Choice).
- One handler (Edit 3 — verify_smt).
- Three arena handlers (Edit 4).
- One combinator (Edit 5).
- One tutorial file (Edit 6).

**And execution is unblocked by closing bootstrap (BT + α).**

The MS2 aspiration isn't a cloud of research risks; it's an
extant substrate + six bounded kernel extensions + a bootstrap
close + crucible exercise. **MSR is the design that makes MS2
real.**

*The medium is mostly there. Close first-light, land six edits,
run five crucibles. What looks like a research program is actually
a walkthrough-sequenced substrate build — each piece lands when
its contract is on the page and its audit returns clean. No
schedule, no budget, no pivot to a foreign tool. The oracle proves
its own claims through the medium expressing itself.*
