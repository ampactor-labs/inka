# Mentl — PLAN.md

> **THE THREE-DOCUMENT CONTRACT.** Claude reads and updates exactly three
> self-contained documents, and reads ALL THREE every session:
> - **`CLAUDE.md`** — *method*: how to work (anchors, verbs, drift modes, the
>   interrogate-don't-absorb law).
> - **`PLAN.md`** (this file) — *substance*: what is true (the reframe, the
>   kernel, the resolved decisions, the arc, the state, the laws).
> - **`SYNTAX.md`** — *surface*: the authoritative language form; supersedes any
>   syntactic claim made here or in `CLAUDE.md`.
>
> Method / substance / surface — the three docs are shaped like the medium
> itself (three projections of one graph), so a claim that fits no layer has
> nowhere to hide. Each truth has **exactly one home**; the other docs point by
> layer, never re-assert (this is how the docs can't drift against each other).
> The 56k lines of `docs/specs/**`, the `~/.claude/plans/*` variations, and the
> 85 memory protocols are **git archaeology, out of the read-path**. "Read the
> three docs" is sufficient, forever. **Context cost is NOT a constraint
> (Morgan, 2026-06-18): completeness wins** — Claude must hold the ENTIRETY of
> what Mentl is, every session, not a distilled recollection. Exhaustive in
> coverage; elegant where it can be; never abbreviated at the cost of a truth.

---

## §0 · What Mentl IS — the reframe (the north star)

**Mentl is humanity's verification substrate for the age of machine-generated
code.** Any intelligence may *propose*; nothing *executes* unproven; intent is
never lost; capability is always bounded.

This reframe is load-bearing and was earned, not assumed (round-table + SOTA
deliberation, 2026-06-18). The received wisdom — "AI writes the code, so the
language stops mattering" — is **backwards**. The more code machines generate,
the more the bottleneck moves from *writing* to *trusting*. A world drowning in
machine-authored code does not need better generation; it needs a substrate
where:

1. **Proof beats review** — when no human authored it, "looks right" is
   worthless. Proof has no ceiling; approximation asymptotes.
2. **The negative is provable** — autonomous, *acting* software makes "can it
   prove it *won't* exfiltrate / allocate unboundedly / reach the network" the
   existential question. `!E` negation is the only system on Earth that proves
   absence transitively. **This is Mentl's most underrated arm and the future's
   deepest need.**
3. **Intent is lossless** — code modified by non-authors (AI, future-selves) is
   archaeology instantly. The Reason chain carries the *why*, walkable to root.
4. **Computation is durable** — long-running agents, cross-machine workflows,
   failure-surviving computation. Multi-shot continuation, persisted.
5. **Systems explain themselves** — when systems exceed any human's grasp,
   oversight requires the system to project its live truth at any point (the
   cursor, the Why chain). A survival requirement, not a nicety.

**Mentl's value is *inversely* correlated with human authorship — antifragile to
AI progress.** Every leap in generation makes the verification substrate more
necessary. The 2026 founding thesis ("close the gap between intent and what
you're forced to write") matured into exactly the thing the machine-code age
needs.

**The convergence (why these are the right decisions).** When the same choices
return from three independent directions — what makes Mentl *ultimate*, what
*humanity* will need, and what's best for *the makers* — that alignment is the
signal of truth, not preference. The Carried-Truth Law turns out to be one law
at three scales: Mentl's kernel never fabricates a fact it can read live;
software for humanity must never hallucinate intent; and Claude must carry the
real reasoning, never perform unearned confidence.

Mentl is not a programming language with good features. It is a **medium** — a
lens so clear the developer looks through it and sees their program, not the
language. The programs are the means; **the developer they become is the end.**

---

## §1 · The thesis — the fixed point (`!Outside`)

A tool you can surpass has its means of improvement *outside* it (to beat X you
write Y). **The ultimate medium has no outside.** The compiler is a handler on
its own graph (self-hosting); the IDE is a projection; the proof system is the
kernel; the oracle is incremental-computation plus one cached value; even
*designing* the medium is a `<~` loop folding back into its docs. Every lever
that could build a better medium is already a move *inside* this one.

- **Unsurpassability is `!Outside`** — the medium's own negation primitive at
  topology altitude. As `!E` proves the absence of a capability, the fixed point
  proves the absence of an outside.
- **Closed over proposers.** Any external intelligence — enumerative, SMT, a
  model, whatever follows — plugs in as a `Synth` handler whose candidates must
  survive checkpoint → infer → Verify → rollback before any human sees them. A
  stronger proposer makes the medium stronger; it can never surpass the medium,
  because its only path to execution runs through the kernel. The unit of
  conversation with a model is the token (lossy, decaying); with the medium it
  is the **constraint** (lossless, monotone, compounding).
- **The proof, validated from eight directions.** Every domain spent a decade
  building *one of Mentl's arms* in isolation and stopped where it lacked the
  others: Faust has the verbs and no effects; JAX has the handlers and no real
  graph; Temporal has the continuation and no types; Rust has the ownership and
  no effect row; Effect-TS has the effects and a hostile host; Solid has the
  feedback and no proof. **Mentl is the convergence point they were all reaching
  toward — the body none of them had, only a tentacle.** (SOTA detail: §4.)

---

## §2 · The kernel — one graph, two operations, eight arms

> **One graph. Two operations: draw an edge (write), project (read). There is no
> third.** THE UNIVERSAL AUDIT: *Is this fact computed, copied, snapshotted, or
> re-derived anywhere it could be read live? If yes, it is the bug.* The fix is
> always toward LESS code.

**The irreducible bottom is not eight things.** It is the **graph** (nodes carry
values; typed edges carry types, effects, ownership, refinement, Reasons) and
two operations: **WRITE** = inference (the one writer, HM-live, every edge
justified by a Reason) and **READ** = the cursor projecting the graph at a
position. "The Graph IS the Program — source, WAT, docs, LSP, errors are all
*projections*; the graph is the truth, everything else a shadow."

**The octopus is one nervous system with eight arms — not eight brains.** The
"eight primitives" are the **eight aspects of every cursor-read** (= the eight
interrogations = the eight tentacles = the method and the voice). Three of them
(ownership, refinement, gradient) are *grown from* the others, exactly as the
substrate already admits ("ownership IS an effect"; the gradient is "derived";
refinement is `Verify`+a predicate). Keeping them as eight independent axioms
over-counts the bottom; keeping them as eight arms of one read is the honest
ultimate form — fewer axioms, identical reach, and it resolves the long-standing
"eight primitives" vs "eight aspects of one read" contradiction the old docs
held in two places.

**Every subsystem is the one read in a different mode** — there is no second
mechanism:

| Subsystem | = cursor-read mode |
|---|---|
| compile order | sequential cursor |
| incrementality (the oracle's IC) | cached cursor |
| multi-shot exploration / durable execution | forked cursor |
| truth / the Why Engine | reasoned cursor (a Reason edge per read) |
| proof | verified cursor (`~> verify`) |
| multithreading | parallel cursor (Thread handler) |
| infer / lower / emit / native / GPU | projected cursor (each aspect → a target token; "the handler IS the backend") |
| the felt surface / propose / reactivity | proposing cursor (gradient at `??`) |

**The eight arms** (project all eight at every cursor before a line; type the
residue): **Graph?** (handle/edge/Reason) · **Handler?** (which projects this,
with what resume cardinality) · **Verb?** (`\|> <\| >< ~> <~`) · **Row?**
(`+ - & ! Pure`) · **Ownership?** (`own`/`ref`, `Consume`/`!Alloc`/`!Mutate`) ·
**Refinement?** (predicate / `Verify`) · **Gradient?** (annotation-as-input
unlocking capability) · **Reason?** (the edge for the Why Engine).

---

## §3 · The bottom-up construction — every layer a mode of the one read

Build L0 upward; each layer's shape is forced by the one below; a non-ultimate
fundamental poisons everything above (the `++`/`String` trap was L1 poisoning
L2). Each layer is the cursor-read in a mode.

- **L0 · The graph.** Nodes + typed edges, live, flat-array O(1) chase,
  epoch-versioned, trail-backed for checkpoint/rollback. The universal
  representation. *Only inference writes.*
- **L1 · The value ontology** — **five node-kinds**: *word* (the machine atom),
  *sequence* (ordered), *product* (record; tuple = positional product), *sum*
  (variant), *function* (closure-with-evidence). Everything else is a **view**
  (§4①).
- **L2 · Topology + cost.** The five verbs draw the shape; the Boolean effect
  row says what crossing an edge requires or forbids (§4②, §4③).
- **L3 · The dynamics.** Handlers + typed resume — the one mechanism;
  themselves graph content (installed via `~>`, typed by inference, projected to
  a backend by the read). Multi-shot is the universal substrate (§4④).
- **L4 · The write.** HM inference, one walk, productive-under-error, every bind
  a Reason. Ownership / effect-row / refinement all *inferred*; authored
  annotations are *constraints verified against* the inferred (§4⑤).
- **L5 · The surface.** The minimal text that makes each kernel aspect reachable
  — `SYNTAX.md`'s domain. Annotations are *inputs to the cursor*, never the
  emergent property.
- **L6 · The felt experience.** The cursor as the gradient's argmax: the Why
  button, `mentl where/edit`, the verification dashboard, fine-grained
  reactivity — all the graph projected for a human. Co-equal, not an afterthought
  (§4⑦).
- **L7 · The closure.** `!Outside` / self-hosting. First-light (`mentl2.wat ==
  mentl3.wat`) is **the smallest instance of the fixed point — the medium
  reproduced exactly by itself**, not a build chore.

---

## §4 · The resolved decisions — the kernel, not questions

*Decided 2026-06-18 through domain role-play + SOTA research. Resolved as kernel
with reasoning preserved, so they are never re-litigated. Interrogate them still
(CLAUDE.md) — but the burden of proof is now on the challenger.*

**① Value ontology — five node-kinds, everything else derived.** `Bool` already
proves the pattern (`type Bool = False | True`, a derived ADT — not a
primitive). `Int`/`Float` = *word* + a representation-gradient (i32 is the floor;
i64/f64 are gradient cash-outs, annotations not types). `String` = *sequence of
byte* + a text/interpolation view. The four §IX "ordered-keyed-set"
implementations (string-set, name-set, field-set, tagged-values) unify into one
operation over sequence/product. *SOTA:* Arrow/Polars/DuckDB all converged on
"one sequence type, many element types." *Consequence:* the `str_concat`-vs-
`list_concat` split does not exist at the bottom — there is sequence-concat, and
the read picks the representation ("the proof becomes the dispatch"). The trap
that ate this session was the bottom signalling the ontology wasn't ultimate.

**② The verbs — five, validated from outside by Faust.** Faust's DSP block-
diagram algebra independently arrived at four of the five: split `<:` ≡ `<|`
(same glyph), recursive `~` ≡ `<~`, sequential `:` ≡ `|>`, parallel `,` ≡ `><`.
*Resolution of the merge question:* Faust needs a merge `:>` because it is
point-free; Mentl folds merge into `|> merge_fn` because it has named values +
tuple-unification — **not a missing verb, a consequence of not being point-
free.** `~>` (handler/effects) is the arm Faust lacks: **Mentl = Faust's
topology + handlers.** Five verbs, settled.

**③ THE CROWN — the effect system: rows-with-negation, evolving toward modal.**
Three forms exist (current PL research): **rows** (Koka — parametric row
variables; gives negation `!E`; *leaks* through higher-order functions — this
session's L1 trap is the textbook failure mode, not a bug); **capabilities**
(Effekt — lexical, no effect variables, so the leak *cannot occur*, but negation
isn't native); **modal** (2025, Lindley et al. — rows *and* capabilities
unified). **Decision: keep rows-with-negation — never trade away `!E`** (it is
both Mentl's unique power and humanity's proving-the-negative need) — and
**evolve toward the modal synthesis** to kill the higher-order leak without
losing negation. The question that defines ultimacy: *can capabilities' no-leak
threading coexist with rows' Boolean negation?* That is the modal frontier, and
it is Mentl's to claim. **But — real before perfect (§5):** kill the leak
*enough to self-host* now (pragmatic effect-row completion for higher-order
functions); pursue the modal form as the long game. Do NOT stall the medium's
existence on unshipped research.

**④ Multi-shot is ONE substrate for five things.** Search (the oracle),
sampling (ML), backtracking, *and durable execution* (the entire 2025 cloud
field — Temporal/Restate/DBOS) are the same primitive: a resumable continuation,
distinguished only by which handler catches the resume and whether it is
persisted. **Persistence is a handler swap.** Mentl's oracle and the workflow
engine are *literally the same arm*. (SOTA: durable execution = "a function that
resumes exactly where it left off after a crash" = persisted multi-shot; Effekt
ICFP-2025 "multiple resumptions + local state, directly" is the live frontier
for Mentl's multi-shot-with-handler-state.) Claim this unification explicitly.

**⑤ Ownership — inferred `own`/`ref`, held to the Hylo-quiet bar.** Hylo's
mutable-value-semantics experiment proved the hard lesson: *moves metastasize* —
add a move anywhere and you need borrows everywhere; you can't escape borrows,
only escape *annotating* them. So ownership-as-inferred-effect (`own` performs
`Consume`; `ref` is a row constraint; filled from use-count 0/1/2+) is the right
shape. **The measured invariant: if the developer has to think about it, the
inference failed.** Quietness is a bar, not a hope.

**⑥ The IFC frontier — the row should carry information *flow*, not only
capability presence.** Capability-security (ocap: E, Pony, seL4-proven-by-hand)
is already subsumed by `!E` + the `~>` trust hierarchy ("the handler chain IS
the capability stack, proven not audited"). The open extension: can a row
express "this `Secret` may not flow to `Log`," proving non-interference the way
`!Alloc` is proven? If yes, Mentl absorbs information-flow control into the same
Boolean algebra. *In scope for ultimate; sequenced as a post-real handler (§5).*

**⑦ The felt experience is co-equal — reactivity IS the cursor's `<~`.** Fine-
grained reactivity (Solid/Svelte signals; Effect-TS bolting effects onto a
hostile host) is the cursor re-projecting on graph delta at the human boundary —
the *same machinery* as incremental compilation (cached cursor) and collab
(shared cursor). Legibility is a survival need for human oversight of autonomous
systems, so L6 is not Stage-3 garnish.

---

## §5 · The arc — real → felt → unsurpassable

**Apply Mentl's own gradient to Mentl's own development.** The three stages each
serve Mentl, humanity, and the makers at once:

1. **REAL — close first-light (L7).** The forcing function: the substrate must
   compile *itself* (the hardest program) end-to-end. Use the pragmatic
   effect-row fix (§4③) — kill the higher-order leak enough to self-host. Reframe
   from the old plan: first-light is not scaffolding, it is the smallest instance
   of `!Outside`.
2. **FELT — the human surface (L6).** Once the substrate is real, the felt
   experience *falls out as projections*: `mentl where/why/edit`, the gradient,
   the Why button, reactivity. This is the founding's payoff and the point.
3. **UNSURPASSABLE — the long game.** The modal effect synthesis (§4③), the IFC
   frontier (§4⑥), durable-execution-as-handler (§4④), the value-ontology
   derivation (§4①), Verify→SMT, native/GPU backends (handler swaps). Each a move
   *within* the medium.

Do them in this order. Each layer above inherits the one below, so a perfect
upper layer on a non-real lower one helps no one — but a real lower layer with a
merely-pragmatic effect system still lets the felt experience exist and be used,
then improves underneath without source change (the gradient).

---

## §6 · The bootstrap reality

Mentl bootstraps **backward**. The VFINAL codebase in `src/**.mn` (+ `lib/**`)
IS the compiler — the wheel. A disposable hand-WAT **seed** (`bootstrap/`,
assembled to `bootstrap/mentl.wasm`) compiles the wheel **once** → `mentl2`;
then Mentl compiles itself; the seed is deleted. The seed is the largest
non-ultimate thing in the repo *by design* — it dissolves at first-light.

- **Build:** `bootstrap/build.sh` → `find src -name '*.mn' | sort | xargs cat` +
  `find lib` piped to `wasmtime run bootstrap/mentl.wasm > mentl2.wat` →
  `wat2wasm` → `mentl2.wasm` compiles the wheel → `mentl3.wat` →
  `diff mentl2.wat mentl3.wat` (empty = first-light). Wheel input is `find`, NOT
  `cat src/*.mn` (which omits `backends/wasm.mn`).
- **WASM substrate.** Linear memory, no GC, tail-call via wasmtime. Bump
  allocator, monotonic, never frees (determinism = fixpoint). Strings: flat
  `[len][bytes]` + view `[-1][buf][start][len]` (sign of first word =
  discriminant) — note §4①: this flat form IS a sequence; the type split is the
  artifact to dissolve. Lists: tag 0=flat, 1=snoc, 3=concat, 4=slice.
- **Handler elimination (the three tiers, "the proof becomes the dispatch"):**
  tail-resumptive (~85%) → direct `call`; static singleton → direct call against
  `$<hname>_state_g`; polymorphic → `call_indirect` via an evidence-field on the
  closure record (Koka evidence-passing, **never** a vtable); MultiShot → heap
  continuation struct + trail rollback.
- **Handler IS state IS closure IS evidence** — one heap record, four roles
  (`[fn_ptr@0][nstate@4][state@8..][arms][captured_evs]`).
- **Non-ultimate by design (dissolve at L1):** the seed (hand-WAT); the bash
  scaffolds (`build.sh`, `state.sh`→`mentl where`, `faithful.sh`→`mentl verify`,
  `run-micro.sh`, `drift-audit.sh`→`mentl audit`); the external runtime/assembler
  (wasmtime, WABT) — the arc to native is `!Outside` (§5 stage 3).

**File map (the wheel):** `graph.mn` (graph, flat-array O(1) chase) · `types.mn`
(Ty + Reason + Scheme + typed AST) · `effects.mn` (EffRow Boolean algebra) ·
`infer.mn` (HM, one walk, the write) · `lower.mn` (the projected read) ·
`backends/wasm.mn` (LowIR → WAT) · `parser.mn` · `pipeline.mn` · `mentl.mn`
(oracle/synth) · `cursor*.mn` (the felt read) · `bootstrap/src/` (modular WAT).

---

## §7 · Current state (grounded 2026-06-18; verify with `state.sh`)

> **GROUND IN REALITY FIRST.** Run `bash tools/state.sh` before any theory or
> edit — it derives real state from THIS run's artifacts. Prose drifts; artifacts
> do not. On a runtime bug the first move is a PROBE, not a hypothesis.

- **Census 192** (baseline 165; ~75 UnresolvedType / ~69 TypeMismatch / 37
  MissingVariable / 8 FeedbackNoContext). 7/7 micros green. Seed builds. The +2
  over 190 is effect-poly residue from the uncommitted multi-shot producer.
- **Pass-2 reaches the LOWER phase (parser clean).** The `[T]` list-type parser
  gap was a genuine wheel gap, fixed. The trap then marched: `collect_resume_walk`
  `_`-less match (fixed, total) → `build_handler_arm_names` effectful-`map`
  (fixed via `build_arm_groups` direct loop).
- **THE L1 BLOCKER, correctly framed (§4③ + §4①):** `mentl2` traps compiling any
  handler because the seed's `++` emits unconditional `str_concat`
  (`bootstrap/src/emit_expr.wat:224`; the seed's emit has no type-of-node
  accessor, so it structurally cannot dispatch). This is a *symptom*, not the
  disease — the disease is (a) the row-effect-poly higher-order leak (§4③: the
  effect variable doesn't ride through `map`, so an effectful lambda loses its
  row → wrong evidence slot) and (b) the un-derived value ontology (§4①: str vs
  list shouldn't be two types). **Pragmatic path (§5 stage 1):** complete the
  effect-row inference for higher-order functions enough to self-host (kill the
  leak), and give the seed's `++` the type-dispatch the wheel already has. Do not
  chase the modal form yet.
- **Multi-shot producer — uncommitted, INNOCENT of the blocker.** The rail
  dissolved the write-only `resume_kinds` ledger (cardinality is a live
  projection). Closure-based producer built but runtime-unverifiable pre-L1.
- **Self-audit — bolts to unwind toward ultimate (§4③):** `build_arm_groups`
  (a direct-loop *workaround* for the effect-poly gap, not the ultimate `map`+row)
  and `collect_resume_walk _=>()` (catch-all). Diagnostically load-bearing; they
  are decoration. They dissolve when §4③'s effect-row completion lands.

---

## §8 · Verification surface

```
bash tools/state.sh            # seed build · wheel census · micro battery · two-pass (run FIRST)
bash tools/state.sh --quick    # census + micros only (one wasmtime pass)
tools/faithful.sh <file.mn>    # proto-`mentl verify`: does mentl2 agree with the seed?
tools/faithful.sh --wheel      # live L1 status   ·   --bisect: ddmin to the minimal failing file-set
wat2wasm m2.wat -o m2.wasm --debug-names --enable-threads --enable-tail-call
wasm-validate / wasm-objdump -d / wasm2wat / wasm-stats / wasm-interp   # WABT, per task
```

`.build/` (luks-backed) holds intermediates, not the 6 GB tmpfs (the `TMPDIR`
fix stops EDQUOT). Tooling can lie: a diagnostic's NAME can lie (instrument the
actual emit site); diagnostics print to STDERR not the wat; verify before
asserting.

---

## §9 · The hard-won laws

1. **THE CARRIED-TRUTH LAW (root, at three scales).** Every Mentl bug is ONE
   bug: the graph proved X; a consumer re-derived / discarded / fabricated /
   cached X instead of reading it live. Carry the handle, read live; the fix is
   always LESS code. *Same law:* humanity needs software that never hallucinates
   intent; the collaboration needs Claude to carry real reasoning, never perform
   confidence.
2. **Don't patch — restructure or stop.** If a fix fits in a patch, the
   architecture is wrong. A silent failure / surrender-fallback (`_ => str_concat`,
   `_ => 0`) is *deleted*, not wrapped.
3. **Dream-code first.** Write the final form; make the seed match; verify by
   coherence + census, not by checking a mutation.
4. **Mentl solves Mentl.** Reaching for a framework = a missing primitive. Every
   subsystem is the cursor in a different mode.
5. **Build the wheel; never wrap the axle.** No V1 to wrap — only the final form.
6. **The trap marches deeper per fix = progress.** Probe before hypothesis;
   trace to bedrock; each fix exposing the next is the signal you're descending
   correctly.
7. **Never force the dispatch floor unverified.** A silent multi-shot miscompile
   is the worst failure. Verify via `mentl2`/WABT before claiming.
8. **No bolts onto non-ultimate forms.** When the audit finds you working around
   a gap, the move is the ultimate restructure, not another per-layer patch.
9. **Interrogate, don't absorb** (the law that prevents the next re-grounding —
   see CLAUDE.md). These docs are the current best answer, not authority; at
   every claim ask "is this the ultimate form?" The decisions in §4 are resolved,
   but the burden is on the challenger, not assumed away.
10. **Inline only; report, don't perform.** All work in the single accumulated
    context (no agents/Workflows/model-params/skill-ceremony). A turn ends with
    what CHANGED and the MEASURED result; work not done → "not done" first
    sentence; shortest response carrying result + next move.

**Bug classes that cost hours:** `match … with _` masking type errors · dup
top-level fn names (emitter picks one silently) · flat-array ops in Snoc paths
(O(N²)) · `println`/`report` in `report(...)` arms corrupting WAT stdout ·
`acc ++ [X]` in a loop (O(N²); use buffer-counter) · flag-as-int (→ ADT) · a
diagnostic's NAME can lie.

---

## §10 · How to resume — the three-document loop

1. **Read `CLAUDE.md`, `PLAN.md`, `SYNTAX.md`.** That is the entire required
   context. Reference nothing else unless debugging a specific artifact.
2. **Run `bash tools/state.sh`.** Trust its numbers over any prose here; if they
   disagree, the prose is stale — fix it.
3. **The cursor is §5 (real → felt → unsurpassable) at its first un-done stage:
   close first-light** via §7's pragmatic path (complete effect-row inference for
   higher-order functions; give the seed's `++` type-dispatch). Then the felt
   surface; then the long game.
4. **Every edit:** project the eight arms (§2); obey Carried-Truth (§9.1);
   dream-code first (§9.3); never bolt (§9.8); interrogate, don't absorb (§9.9).
   Ask: *what does the ultimate medium do here?* Implement that.
5. **Keep the three docs in ultimate form.** Each touch consolidates toward the
   tightest *complete* prefix, one home per truth. They are the only durable
   memory — the investment that means this session never recurs.
