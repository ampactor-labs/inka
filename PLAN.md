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

**The deepest scale of that same law — the medium is its own builder's
safeguard.** This session proved, pointedly, that *discipline written down cannot
enforce itself*: with the most rigorous docs that could be written (the
Carried-Truth Law as the first anchor, the Universal Audit as the first
interrogation), Claude still drifted repeatedly — debugging the symptom before
auditing the structure, trusting memory over the artifact, offering a risk-hedge
as if it were a decision — until the human caught it. Discipline-as-prose fails
exactly the way a language fails its developers: it *asks* for correctness
instead of *enforcing* it (`// please don't allocate here` has never saved
anyone). The only real safeguard is the medium making the wrong move *unsayable* —
which is precisely what `mentl audit` will do: flag a Carried-Truth violation
(the §7 registry) *before a line is written*. **So first-light is not merely
self-compilation — it is the medium becoming able to enforce its own discipline
on its own construction.** Until it is real, the human is `mentl audit` by hand
and these docs are the *spec, not the guarantee* — the discipline is an ACTION
taken first, every time, never a paragraph trusted-as-absorbed. The convergence
completes: **docs : Claude :: language : developer :: human : `mentl audit`** —
when Mentl is real, all three collapse into one (the graph, projected, keeping
its own truth). This is the deepest reason to get the medium real (§5): so it
keeps every builder — Claude included — honest, the way it will keep developers
honest.

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
>
> **A verb DRAWS an edge.** `~> h` connects the install to handler `h`'s node;
> `|>` connects stage to stage; `<~` closes a cycle. Reading what an edge already
> connects **by name** (a ledger, an index, an env re-lookup) instead of
> following the edge is the canonical re-derivation — the §7 registry trap in one
> sentence. Follow the edge; read the live node; never re-resolve by name what the
> graph already connected.

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

**The three deepest capabilities are not features — they are the three AXES of
the one read, and every primitive is interrogated against them (the generative
audit, run alongside the reductive "does the graph already know this?").**
- **Memory = the SUBSTRATE.** One flat linear-memory image; every node and value
  a handle-addressed record; the bump allocator monotonic (determinism =
  fixpoint); sequences are `[len][bytes]`/`[−1][buf][start][len]` views. The
  **unified heap record** makes *handler = state = closure = evidence =
  continuation* ONE shape — so a continuation is a contiguous record and thus
  `memcpy`-serializable: **durable execution falls out of the memory model**
  (the 2025 cloud field reimplements this with bespoke heap-walking serializers).
- **Multi-shot = TIME.** Fork (trail-checkpoint) / cache (the IC cursor memoizes
  live reads by epoch — so "read live" is the semantics and "cached" is the
  mechanism, never hand-rolled) / persist (continuation to disk) the graph across
  versions. The oracle's search, the cached cursor, and durable execution are ONE
  primitive distinguished only by which handler catches the resume (§4④).
- **Threading = SPACE.** Parallel cursors read the shared image lock-free and fork
  to per-thread trails; compile, IDE, prover, and oracle-search are the same graph
  read at many positions (per-thread bump arenas + inference-stable handles =
  deterministic parallel codegen).

The cursor projected through {substrate, time, space} IS the subsystem table
above; **the oracle FUSES all three** — N forked cursors on N threads over one
shared-memory graph with per-fork rollback (trail/rollback + wasi-threads
substrate landed; continuation-reification codegen is the open keystone). *Best
current organizing answer; interrogate it (§9.9).*

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
- **L7 · The closure.** `!Outside` / self-hosting. First-light is **the FIXED
  POINT — the medium reproduced exactly by itself**: `m_n.wat == m_{n+1}.wat`,
  paired with correctness (a buggy compiler self-reproduces to a *wrong*
  fixpoint, so the micros + repro are the second half of the check). The smallest
  instance of `!Outside`, not a build chore. NOT `m2 == m3`: the seed is
  disposable and its bytes need not match the wheel's own output — for a change
  to the compiler's OWN inference the fixed point lands at `m3 == m4` (mechanics:
  §6). The seed's one job is a *correct* `m2`; the flame reproducing itself is
  first-light.

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

**③ THE CROWN — the effect system: rows-with-negation; modal is the TARGET, the
graph is the ROUTE.** Three forms exist (current PL research): **rows** (Koka —
parametric row variables; gives negation `!E`; *leaks* through higher-order
functions — this session's L1 trap is the textbook failure mode, not a bug);
**capabilities** (Effekt — lexical/second-class, no effect variables, so the leak
*cannot occur*, but negation isn't native AND effects can't escape — fatal to
first-class continuations); **modal** (Tang–Lindley, *Modal Effect Types*, POPL
2025 — rows *and* capabilities unified by a modality that re-admits first-class
escape *under proof*; cited live at `src/effects.mn:12`). **Decision: keep
rows-with-negation — never trade away `!E`** (Mentl's unique power and humanity's
proving-the-negative need) — and hold the **modal synthesis as the
unsurpassable-tier TARGET** (the strongest published candidate); the defining
question — *can capabilities' no-leak threading coexist with rows' Boolean
negation?* — is its burden to discharge, **and any rival's, including Mentl's own
graph-native route** (interrogate, don't absorb: name the frontier, don't crown a
destination). Two artifact-grounded reasons it is correctly targeted — not a hedge
(adversarially verified 2026-06-21): **(a) `!E` under polymorphism is currently
UNSOUND** — `unify_row` punts `EfOpen ~ EfNeg` ("exact match or error for
universe-minus open rows", `effects.mn:378`) and `free_in_row`/`subst_row` cross
`EfNeg` unguarded, so an open row var can be instantiated to include the very
effect a `!E` forbade — exactly why Koka omits negation, exactly what a modality
fixes; **(b) the TIME axis needs it irreducibly** — a continuation persisted under
handler-set H1 and resumed under H2 (or across a recompile) is the canonical
world-change, but `TCont(Ty, ResumeDiscipline)` carries cardinality and NO
effect-world (`types.mn:47`), so neither the type nor the memcpy'd evidence-record
can detect a now-unhandled or layout-shifted resume (the silent multi-shot
miscompile, Law 7). **The graph is the ROUTE, never the replacement:** Mentl's
first-class unified-evidence substrate — dispatch decoupled from the type-row
(413bdc2) — is a degree of freedom Koka/Effekt/the modal calculus lack; it lets
the modality be **inferred and cursor-projected** (a graph fact, §4⑤ quiet, never
authored). The flow-edge representation soundly fixes the *positive* higher-order
leak; it does NOT alone make `!E`-under-polymorphism or cross-context resume sound
— that is the modal synthesis's work, realized *through* the substrate. **Real
before perfect (§5):** kill the positive leak *enough to self-host* now (the
flow-edge completion); land the modal world-index as the long game. Do NOT stall
the medium's existence on unshipped research — and do NOT crown the unproven route
as the destination (the 2026-06-21 fluency trap: a session-built flow-edge form
rationalized as "already modal" while pass-2 still trapped; the five-lens
adversarial panel refuted it 4/4 on verified soundness grounds).

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

- **Build & the FIXED-POINT oracle:** `bootstrap/build.sh` → `find src -name
  '*.mn' | sort | xargs cat` + `find lib` piped to `wasmtime run
  bootstrap/mentl.wasm > mentl2.wat` → `wat2wasm` → `mentl2.wasm` compiles the
  wheel → `mentl3.wat` → `mentl3.wasm` compiles the wheel → `mentl4.wat`.
  **First-light = `diff m3.wat m4.wat` EMPTY *and* correctness (micros + repro
  green)** — the fixed point `m_n == m_{n+1}`, the medium reproduced by itself.
  **NOT `m2 == m3`.** Why: `m2` is the wheel compiled by the DISPOSABLE seed, so
  `m2`'s bytes are the seed's output, not the wheel's own — for a change to the
  compiler's own inference `m2 ≠ m3` *even when correct*, while `m3 == m4`
  (`W` reproduced by `W`, seed already out of the loop). The seed's ONE job is to
  spark a *correct* `m2` (offsets resolve, no traps); its bytes are thrown away,
  never matched. Pair the diff with correctness — a buggy compiler self-
  reproduces to a *wrong* fixpoint, so micros/repro are the second half. The old
  `m2 == m3` check was a seed-matches-wheel PROXY: it forced mirroring every wheel
  refinement into the hand-WAT seed (the mirror-grind); the fixed point frees the
  seed to be coarse, only correct. Wheel input is `find`, NOT `cat src/*.mn`
  (which omits `backends/wasm.mn`).
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

- **Census 189**, 7/7 micros green, seed builds, m2.wat assembles, pass-1 (seed
  compiles the wheel) OK.
- **LANDED — the handler registry dissolved into the one-graph live-read.** The
  `handler_state_inits_registry` + its pre-register pass + `build_arm_kinds` +
  `arm_kind_in` are gone; `HandlerKind` now carries the decl's (config, state,
  arms) so the env *names the handler's node* and lower reads its dispatch LIVE
  (`handler_decl_of` / `handler_op_kind`). A real Carried-Truth fix (census
  192→189, −271 WAT lines, audit-clean). It STANDS.
- **But the registry was NOT the pass-2 blocker — §7's prior "VERIFIED backtrace"
  was stale.** Parsing runs wholly before lowering, so a `lower_handler_arms_as_decls`
  trap cannot be the live pass-2 blocker when the live trap is in PARSING. The
  lesson is §9.6's own rule, paid for: the prior backtrace was trusted from prose,
  not re-pulled with a tool at session start.
- **THE VERIFIED BLOCKER — the effect-row→ev-slot SEAM (compiled-WAT read,
  2026-06-20).** The prior 2026-06-19 entry ("parse-path `node_to_pexpr → map →
  iterate_from`, nondeterministic OOB, funcref-floor corruption") was a STALE read
  of a MASKED trap — DISPROVEN by reading `m2.wat`. The live FIRST trap is a
  DETERMINISTIC `unreachable` in `op_lookup_ty_graph_lookup_ty ← param_handles_of
  ← lower_stmt_body` (LOWER, not parse). At `m2.wat:50735/50796` it is the
  `let GNode(kind,_) = graph_chase(h)` destructure's `(else (unreachable))`: it
  fires because `graph_chase(h)` returns a NON-GNode. graph_chase is an evidence
  `call_indirect` whose handler pointer is read from `__state` at an ev-slot THE
  SEAM computes. `lookup_ty` succeeds thousands of times (the 75 E_UnresolvedType
  ARE its NFree arm) — only ONE call misroutes ⇒ a per-row ev-slot DISAGREEMENT,
  not a blanket dispatch break, and NOT a seed funcref bug.
- **THE ROOT — `effects_of_row` drops the EfOpen row-var (lower.mn:528-621).** The
  seam's two consumers must agree: `derive_ev_slots` (caller — PLACES evidence)
  reads the callee's type AT THE CALL SITE, where effects are often INLINE
  (post-instantiation); `lower_compute_ev_index_for_effect` (callee — READS its
  slot) reads the GENERALIZED scheme, where effects live in the row-VAR (infer
  rebinds it at the declared-row enforcement; generalize does NOT quantify it).
  `effects_of_row(EfOpen(names,_))` reads only inline `names` and IGNORES the var,
  so the two sides disagree whenever an effect sits inline on one and in the var on
  the other ⇒ wrong ev-slot ⇒ garbage evidence ⇒ non-GNode ⇒ `unreachable`.
  (Probe corollary: adding ONE `Diagnostic` effect to param_handles_of's row
  flipped the trap to `indirect call type mismatch` — the evidence layer is
  acutely fragile to ANY row delta. That fragility IS §4③'s higher-order leak,
  surfaced at the dispatch layer.)
- **DEAD ENDS (both proven) — the threaded-slot is not fixable by reading the row
  harder.** The naive var-chase (chase the EfOpen var in `effects_of_row` so both
  seam consumers read the complete row) was TESTED 2026-06-20: it DISSOLVES the
  param_handles_of trap but MARCHES it to `node_to_pexpr → map → iterate_from →
  yield → wat_emit` (an OOB ev-misroute) at +2 census — a more-complete row-READ
  still inherits instantiation divergence AND perturbs the fragile slot layout.
  Reverted. Its dual, snapshot-at-generalize (`chase_deep_row`), was reverted
  earlier (generalize-time vs lower-time graph diverge → ev-slot shift). The
  threaded tier itself is CORRECT: handler arms lower ONCE, context-free (a
  top-level decl may install under any enclosing handler), so `lookup_ty`'s arm
  cannot bake in a lexical graph_handler — it MUST thread. The bug is THREADING A
  COPY where a singleton should be read LIVE.
- **THE CURSOR — the dispatch-gradient SINGLETON tier (§5.3, viability-CONFIRMED
  2026-06-20, BOTH layers).** THE UNIFY (Universal Audit): `graph_handler` is THE
  static singleton — one graph, installed once per route; threading copies of its
  record through ev-slots is the re-derivation. Read it LIVE from its
  `$<hname>_state_g` home (413bdc2's static-singleton tier, EXTENDED to cross-arm
  performs). VIABLE: handler state is mutated IN PLACE (`LStateSlotStore`,
  wasm.mn:2023 — `(local.get $__state)(value)(i32.store offset)`), the record
  pointer is stable, and the arm's `__state` IS the record bound to
  `$<hname>_state_g`, so a direct read sees current state. THE BUILD: (1) lower —
  when NO lexical handler covers an ename but a PROVEN singleton does, resolve to a
  direct per-effect-entry read of `$<hname>_state_g` instead of `LEvSlotRef`; (2) a
  `LSingletonEv` LowIR + emit computing the entry offset into the global record
  (same [record, base] view the threaded entry exposes); (3) singleton-ness PROOF
  (install-graph: installed once, not under loop/recursion — pragmatically the
  route-infra handlers graph/env/…); (4) seed mirror; (5) byte-parity. LAW 7: a
  wrong dispatch resolution is a SILENT miscompile — verify each increment against
  the 189 baseline before the next; never rush it. (The general peer — make the
  THREADED slot itself agree via `effects_of` as the body flow-closure — stays the
  long-form §5.3 target for genuinely-polymorphic, non-singleton handlers.)
- **THE UNSURPASSABLE FORM (§5.3 — work sequenced, target preserved): the
  FUNCTION-DISPATCH GRADIENT.** Dispatch is READ, not recovered — a graph-known
  operator → a DIRECT call (the proof IS the dispatch); the funcref floor is for
  genuinely runtime-variable operators only (the SAME evidence path a polymorphic
  handler takes). ONE gradient for functions AND handlers (symmetric completion of
  413bdc2). Every trained compiler defaults to indirect dispatch and claws back
  direct calls in an optimization pass; the medium that never forgets the call
  graph never virtualizes a known operator — nothing to devirtualize. This is a
  §5.3 long-game form (peer of modal effects / native backends); §5 ships the
  floor for REAL, then it "improves underneath without source change (the
  gradient)" — so it lands in the UNSURPASSABLE phase, NOT as a first-light
  blocker. The proven dream-code form (general monomorphization: lower specializes
  a callee on a known-operator arg, transitive; the env resolves the operator's
  `FnStmt` live since `FnScheme` is tag-0) was built and reverted this session —
  re-land it then. (§0 lesson: it was over-reached as the first-light cursor AND
  forked to the user — both drifts the docs already forbid; the docs are the spec,
  the ACTION of reading them is the safeguard.)
- **Peer (also §5.3) — predicate-is-Expr.** node_to_pexpr translates Expr→`PExpr`,
  a parallel ADT re-deriving the predicate the graph already holds as an Expr — a
  Carried-Truth violation at the representation layer (the dispatch gradient is the
  peer at the dispatch layer). A refinement predicate as a refined Expr (no
  `PExpr`, Verify reads the Expr) dissolves it (Hβ.types.predicate-is-expr).
  Neither is the first-light blocker (that is the seed funcref-floor bug); both are
  unsurpassable-tier Carried-Truth cleanups.

---

## §8 · Verification surface

```
bash tools/state.sh            # seed build · wheel census · micro battery · FIXED-POINT m3==m4 (run FIRST)
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

**Pin a wasm trap with the binary toolkit, NEVER grep the minified emit** (the
fragile path that ate this session): the wasmtime backtrace gives `<addr> <fn>`;
`wasm-objdump -d m2.wasm` maps it to the exact instruction with the `name`
section making locals readable (`<__state>`, `<h>`, `<kind>`) — e.g. it proved
the `lookup_ty_graph` arm threads `graph_chase` from `__state` offset 12 with NO
`*_state_g` home-read; `wasm2wat --fold-exprs m2.wasm` renders readable canonical
WAT for archaeology. `wasm-interp` CANNOT run m2 (no WASI — fails on the
`proc_exit` import); use it only on WASI-free micros, else wasmtime + a targeted
`eprint` for runtime values.

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
3. **Dream-code first — and the dream is INVARIANT to the substrate.** Write the
   final form (perfect Mentl source for the perfect substrate); make the
   disposable seed match it; verify by coherence + census, not by checking a
   mutation. A substrate that can't express the form means the SEED is
   incomplete — complete the seed; NEVER lower the target to fit it. "Ultimate
   form reachable now" / "realistic ultimate" / "the deeper ideal is a follow-up"
   is the target equivocated downward — the underhanded drift wearing the
   discipline's costume. Sequence the WORK (§5); never sequence the TARGET. And
   the dream GROWS: run the generative audit (§2 — multi-shot/threading/memory +
   frontier) so each touch reaches toward a newer ultimate, not only less code.
4. **Mentl solves Mentl.** Reaching for a framework = a missing primitive. Every
   subsystem is the cursor in a different mode.
5. **Build the wheel; never wrap the axle.** No V1 to wrap — only the final form.
6. **Audit before the symptom; probe before hypothesis** (the lesson of
   2026-06-18, paid for in a full session of drift). Your FIRST move on any work —
   above all a bug — is the Universal Audit of the structures you'll touch (*does
   the graph already know this? is this copied / cached / re-derived?*) BEFORE
   tracing any trap; debugging a symptom's mechanism before auditing whether the
   structure should EXIST is the drift itself. Then probe the artifact, never a
   hypothesis; the trap marches deeper per fix (progress). A probe that disproves
   you does NOT crown the next symptom as the root — keep digging until it cannot
   reduce; verify every claim with a tool (memory and prose drift; the artifact is
   truth). And a "choice" between the ultimate form and a safer/lower-risk hedge
   is itself the drift — the ultimate form wins; never hedge the wheel against the
   seed.
7. **Never force the dispatch floor unverified.** A silent multi-shot miscompile
   is the worst failure. Verify via `mentl2`/WABT before claiming.
8. **No bolts onto non-ultimate forms.** When the audit finds you working around
   a gap, the move is the ultimate restructure, not another per-layer patch.
9. **Interrogate, don't absorb** (the law that prevents the next re-grounding —
   see CLAUDE.md). These docs are the current best answer, not authority; at
   every claim ask "is this the ultimate form?" The decisions in §4 are resolved,
   but the burden is on the challenger, not assumed away.
10. **Power × anti-drift is the dispatch criterion (not token-frugality);
    report, don't perform.** Token cost is NOT a constraint (Morgan upgraded
    2026-06-21). Choose the most powerful structure: DEEP kernel/novel-concept
    reasoning stays INLINE (the single accumulated context is the handler; a
    cold-brief dispatch loses the altitude = the proven, token-independent
    drift); VERIFY my own conclusions via ADVERSARIAL/independent agents told to
    refute (the anti-fluency-trap tool, a systematic proxy for the
    human-catches-the-drift loop); BREADTH via Workflow fan-out; synthesis
    inline. Omit model-params (agents inherit the session model); the discipline
    governs each agent. A turn ends with what CHANGED and the MEASURED result;
    work not done → "not done" first sentence; shortest response carrying result
    + next move.

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
3. **The cursor is §5's first stage — *real*: close first-light.** Per §7: the
   handler registry is dissolved (landed). The live blocker is a BUG in the
   legitimate funcref FLOOR (§6), inside the disposable seed — its funcref/
   static-closure machinery corrupts on the re-entrant `map(node_to_pexpr)` of
   refinement parsing. PROBE it to bedrock and fix it in the seed (completing the
   by-design non-ultimate seed enough to self-host — not a wheel patch). The
   FUNCTION-DISPATCH GRADIENT (direct for known operators, funcref the floor) is
   §5.3 unsurpassable, not a first-light blocker. Then *felt*, then *unsurpassable*.
4. **Open with the Universal Audit, not the trap (§9.6).** Then every edit:
   project the eight arms (§2); obey Carried-Truth (§9.1); dream-code first
   (§9.3); never bolt (§9.8); interrogate, don't absorb (§9.9). Ask: *what does
   the ultimate medium do here?* Implement that.
5. **Keep the three docs in ultimate form.** Each touch consolidates toward the
   tightest *complete* prefix, one home per truth. They are the only durable
   memory — the investment that means this session never recurs.
