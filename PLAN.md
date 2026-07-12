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
parametric row variables: the row FORM Mentl adopts. Koka itself OMITS Boolean
negation — its scoped duplicate-labeled rows were chosen *to avoid* absence/lacks
constraints — so `!E` is Mentl-NATIVE, not inherited from Koka; the form *leaks*
through higher-order functions, this session's L1 trap, the textbook failure mode
not a bug); **capabilities** (Effekt — lexical/second-class, no effect variables,
so the leak *cannot occur*, but negation isn't native AND effects can't escape —
fatal to first-class continuations); **modal** (Tang–Lindley, *Modal Effect Types*,
POPL 2025 — rows *and* capabilities unified by a modality that re-admits first-class
escape *under proof*; the follow-up *Rows and Capabilities as Modal Effects* (POPL
2026, arXiv 2507.10301) PROVES both macro-encode into the one modal frame, types
and semantics preserved; cited live at `src/effects.mn:12`). **Decision: keep
rows-with-negation — never trade away `!E`** (Mentl's unique power and humanity's
proving-the-negative need) — and hold the **modal synthesis as the
unsurpassable-tier TARGET** (the strongest published candidate); the defining
question — *can capabilities' no-leak threading coexist with rows' Boolean
negation?* — now has its rows≡capabilities HALF discharged in the literature (POPL
2026), leaving the **NEGATION half** the open burden — **its, any rival's, and
Mentl's own graph-native route's** (interrogate, don't absorb: name the frontier,
don't crown a destination). Two artifact-grounded reasons it was correctly targeted
(adversarially verified 2026-06-21) — and the STATE of each, trued 2026-07-02
against the lines they cite: **(a) `!E` under polymorphism** — the one unify_row
punt (`EfOpen ~ EfNeg` errored instead of unifying) is CLOSED (b4b1989,
2026-06-23): `bind_open_to_neg` binds the open var to the NEGATION itself so the
var carries the forbidden set forward through generalize/instantiate, and
`free_in_row`/`subst_row` cross `EfNeg` — the mechanism Koka omitted negation to
avoid, realized through the row representation. What remains open in band A is
the PROOF tier, not the mechanism: the adversarial soundness GATE that tries to
smuggle a forbidden effect through instantiation, and the full modal world-index.
**(b) the TIME axis** — `TCont(Ty, ResumeDiscipline, EffRow)` carries the
effect-WORLD since STEP 5 (27edc30): the type CAN now detect a cross-world
resume; band B's open work is ENFORCEMENT (the world is inert on OneShot; the
`E_ResumeWorldMismatch` value gate and capture-at-reify remain). **The graph is the ROUTE, never the replacement:** Mentl's
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

## §5 · real · felt · unsurpassable — three aspects of one ultimate form

**Apply Mentl's own gradient to Mentl's own development.** These are NOT a
sequence to march through — they are three ASPECTS of the one ultimate form,
written in FULL. The discredited reading ("do real first, then felt, then
unsurpassable; close first-light before anything above it") is the phasing the
makers rejected. You write the ultimate `.mn` answering ONLY to "what is the
ultimate form?"; the disposable seed's weaker inference catches up afterward
("write the ultimate form, THEN we make it work"). first-light is not a phase to
*close first* — it ARRIVES when the complete wheel meets a caught-up seed.

1. **REAL — it WORKS.** The substrate compiles real programs end-to-end; the
   micros run; the wheel emits correct WAT. first-light (the wheel compiling
   ITSELF to a fixed point) is the smallest instance of `!Outside` — a milestone
   that arrives when the wheel is complete, never a gate chased ahead of the form.
2. **FELT — the human surface (L6).** The felt experience *falls out as
   projections*: `mentl where/why/edit`, the gradient, the Why button,
   reactivity. The founding's payoff and the point. (Working brand/IDE design
   brief: `docs/DESIGN_SYSTEM.md`; the interaction architecture: `docs/MENTL_EDIT.md` — draft ARTIFACTS of this aspect, not
   read-path; the three-doc contract stands.)
3. **UNSURPASSABLE — the frontier.** The modal effect synthesis (§4③), the IFC
   frontier (§4⑥), durable-execution-as-handler (§4④), the value-ontology
   derivation (§4①), Verify→SMT, native/GPU backends (handler swaps), the
   e-graph (effect-aware equality saturation, live in lower). Each a move
   *within* the medium.

### §5.U · The value layer — four projections of one cursor on one heap record

*Verified by a 21-agent adversarial workflow; the inevitable form, not a choice.*

**The four deepest value-layer axes are NOT four features — they are ONE cursor
reading ONE heap record at four altitudes, joined at one emit-time read:
`match lookup_ty(h)`.** That read already exists — `emit_binop_for`
(`backends/wasm.mn`) dispatches `++`/`==` on `lookup_ty(left)` ("the proof
becomes the dispatch"); the AST-in-graph fabric put the handle on every node, and
lower threads it on every LowExpr. There is no second mechanism to build — only a
**refusal-to-read at four slots, deleted**. The shared record is PLAN §6's
`[fn_ptr@0][nstate@4][state@8..][arms][captured_evs]` — *handler = state =
closure = evidence = continuation*, now extended: **= branch-thunk = fold-target =
representation-host**, ONE contiguous handle-addressed shape:

- **REPRESENTATION GRADIENT (the field widths).** `repr_of(lookup_ty(h))` projects
  `Repr = RI32 | RI64 | RF64 | RF32 | RV128` (an ADT; `repr_width` 4/8/16 by match,
  never `==4`). i32 is the floor; i64/f64/f32/v128 are gradient cash-outs. The
  record POINTER stays a word (a handle IS a word) — handle-uniformity and
  memcpy-serializability survive while fields gain real precision. Today `3.14`
  silently emits `(i32.const 0)` (the developer's value becomes ZERO); the gradient
  makes it native unboxed f64 — no NaN-tax, no box, no tag, and the boxed-float
  peer (OCaml's alloc-per-op disease, fatal to DSP) is unsayable.
- **MULTI-SHOT CONTINUATION (the same record FROZEN at a resume site, TIME
  altitude).** `LMakeContinuation` is dimensionally `LMakeClosure + state_index +
  ret_slot` — emittable today, **constructed nowhere**; lower fabricates OneShot.
  Read the op's cardinality LIVE: OneShot → `LReturn` (byte-identical, ~85%);
  MultiShot → the dormant continuation record. Because it is one contiguous
  handle-addressed record in the monotonic bump image, **persist = `memcpy`** —
  durable execution falls out of the memory model, zero serializer. The
  write-only `resume_kinds` side-ledger (zero readers) is the textbook
  Carried-Truth violation; the cardinality rides the TCont.
- **PARALLEL TOPOLOGY (the same record FORKED as N branch thunks, SPACE
  altitude).** The thunk is portable across a thread boundary, packable into a
  v128 lane (the gradient's vector cash-out), shippable to a device, or persisted
  mid-flight (a crashed branch re-runs from its memcpy'd thunk — SPACE and TIME
  are the same arm, §4④). The verb is PURE TOPOLOGY contributing zero effects
  (delete the hardwired `Thread` injection); a `~> Schedule` handler reads the
  live handler stack to pick `Seq | Thread | Simd | Gpu` (an ADT, never an int).
- **STRUCTURAL FOLD (the record's TYPE-node recursed by SHAPE, the read itself).**
  `==`/compare/hash/show/pack/unpack are one `fold(ty, leaf)` over the five
  node-kinds; the word-leaf reads the gradient (`f64.eq` for an f64 field), the
  function-leaf serializes a continuation by memcpy. **The eq leaf is total NOW**
  (`emit_eq_leaves`, `backends/wasm.mn`): word / sequence / product landed
  earlier, and the SUM leaf (`emit_eq_leaf_sum` — sentinel-guard + tag-
  compare + per-variant payload recursion, the variant specs read LIVE from the
  env's `ConstructorScheme` via `variant_specs_of`, the same channel synth's
  `ctors_of_type` reads) closes the fifth node-kind — so `==` is total over every
  ADT to the bottom, the eq/hash-divergence footgun structurally unsayable. The
  remaining leaves (show / compare / hash) generalize the SAME generator into
  `fold(ty, leaf)`, retiring the two hand-copies (the `lower_to_string`
  aggregate fall-through; a generated `compare`/`hash` leaf) — LESS code,
  sequenced on STEP 0/1's repr word-leaf and STEP 5's `TCont`-world (the
  function-leaf's serialized-closure world). There is NO pack/unpack leaf: the
  `.kai` cache layer and its `IKAI` tag-byte serializer were DELETED whole
  (2026-07-02 — the Inka-era incremental-compilation side-file; it snapshotted
  env entries lossily, DROPPING Reason chains, and pinned an archaeology wire
  format the fold was contorting around). Durability is persist-as-memcpy of
  the image (§4④) — a serializer leaf has nothing to serialize.
  **BOUNDARY (do not mis-flag):** types.mn's
  `show_type` / `show_reason` / `show_effrow` are the DOMAIN pretty-renderer — the
  *mentl voice*, a `~> Format` projection of the compiler's own metaschema for the
  Why engine and diagnostics — NOT the generic `show`-leaf of `fold(ty, leaf)`
  (which renders an arbitrary USER value). They are a different fold over a fixed
  ADT for a human reader, kept; never retired as a fold-copy.

**THE BINDING KEYSTONE — `TCont(Ty, ResumeDiscipline, EffRow)` — LANDED
(27edc30, STEP 5).** Carrying the **effect-WORLD** on the continuation lifts
`!E` to TIME (the modal frontier §4③ lands HERE): a persisted `k` resumed under
a changed handler-set is `E_ResumeWorldMismatch` — a compile-time error, not a
3am production corruption. The one arity change (the coordinated edit across
~14 destructure sites — a representation change, not a patch, per the
unpatchability theorem) went in with the seed mirrored in lockstep; the world
is INERT on the single-world OneShot path (resume-world micro = 42), and band
B's enforcement tier (the value gate, capture-at-reify) is the named remainder.
One edge, two arms.

**The six-step build arc** (each a Carried-Truth deletion the artifact already
names): **(0)** `repr_of(Ty) -> Repr` — the shared read, built once. **(1)** the
representation gradient — delete the arity-keyed i32 deciders, read the handle;
the `$ft`-table keys on the interned Repr-vector (a function type is a product;
`call_indirect`'s match IS structural-equality, so the arity-`$ftN` fork
dissolves). **(2)** the structural fold — three hand-walks → one
`fold(leaf, ty)`; lowest-risk, no arity ripple. **(3)** the multi-shot producer —
the additive half (OneShot byte-identical). **(4)** the parallel-topology collapse
— `PDiverge | PCompose` → one `PFanout` (share-vs-distribute an ownership aspect
read from use-count; Carried-Truth at the node layer). **(5)** the `TCont` arity —
the one coordinated breaking edit, the seed mirrored in lockstep (NOT a
census-shadow follow-up).

**The inevitability.** The four cannot be separated without re-introducing the
bug: you cannot reify a continuation without the gradient (its fields need real
widths or the persisted f64 state corrupts); you cannot persist a thunk without
the unified record (no other serializer to write); you cannot type the fold's
function-leaf without TCont's world; you cannot schedule a fanout without the
record's portability (thunk = closure = continuation). The medium's own comments
named every fix, and every one is CLOSED: the Thread-drift peer (STEP 4,
600bc88), attach-to-TCont (STEP 5, 27edc30), the `$ftN` fork (deleted into the
one repr-vector walk, the m2 march), the product/sum eq floor (STEP 2 + the
sum leaf). This is
`!Outside` at the value layer: a better representation is a deeper `repr_of` arm;
a better schedule is a different `~>` handler; a sixth structural operation is
another leaf; stronger persistence is a different `Persist` catcher. Every lever
is already a move INSIDE the medium.

Write the ultimate form in FULL — all three aspects at once. A leap that advances
*unsurpassable* (the e-graph, the value layer) before the seed can self-host is
NOT premature: the seed catches up, and the census it raises is a SHADOW (§8),
never a reason to hedge the wheel against the seed (the one named drift, §9.6).

### §5.R · The post-first-light roadmap — the named remainder (so first-light's focus cannot erase it)

> Every unsurpassable item NAMED in positive form and SEQUENCED, so the work
> survives first-light's all-consuming focus (gathered 2026-06-28: the SOTA fleet +
> the three docs + the codebase `Hβ.*` peers + an adversarial completeness critic;
> 95 items / 15 bands; **full detail with SOTA refs + file:line anchors in
> `docs/research/post-first-light-roadmap.md`**, the SOTA map in
> `docs/research/sota-convergence.md`). Each is a positive-form named peer — a
> hidden gap is drift (the bug IS the non-ultimate form, `CLAUDE.md ⟐`). Sequenced
> AFTER first-light unless marked NOW; the gate that unblocks dependents leads each
> band. **THE SPINE:** `Hβ.effects.sound-neg-under-poly` is the dependency ROOT —
> ownership-as-effect, `!Thread`/`!Alloc` transitivity, and IFC non-interference ALL
> inherit the EfNeg-under-instantiation unsoundness, so none can be VERIFIED (only
> built) until the crown closes; the `TCont` world-index is the second spine (TIME).
> STEP 0–5 + W31 are LANDED — this is the remainder.

**A · Effects & the modal crown (arm 4) — gates ownership, !Thread, IFC negation.** `Hβ.effects.sound-neg-under-poly` (sound transitive `!E` under polymorphism; unify_row punts EfOpen~EfNeg, effects.mn:378 — build the soundness GATE, never claim "already modal", the 4/4-refuted 2026-06-21 trap) · `Hβ.effects.modal-world-index` (rows+capabilities+negation sound simultaneously, as a graph fact; POPL-2026 cite at effects.mn:12) · `Hβ.infer.modal-capability-at-tee` (the modal rule: a row var becomes a lexical capability handle at the `~>` edge, no new surface form) · `Hβ.syntax.perform-dissolution`.

**B · Continuations & TIME (arm 2, §4④) — the binding keystone.** `Hβ.types.tcont-world-binding-keystone` (STEP 5 landed the 3-arg arity; the world is INERT on OneShot — ENFORCE it) · `Hβ.types.resume-world-mismatch-value-gate` (the runnable gate; layout-in-world coupling; DEP persist resume-catcher + STEP 1) · `Hβ.infer.tcont-world-capture-at-reify` (at the multi-shot producer's reify site) · `Hβ.continuations.world-widening-resume` (typed superset-resume) · `Hβ.continuations.persist-equals-memcpy-handler` (= `Hβ.lower.fanout-durable-persist-handler`; `~> Persist`, zero serializer; STEP 3 producer landed; the standardized multiple-memories proposal is this peer's substrate cash-out — a dedicated IMAGE memory snapshots whole while scratch lives apart, the memcpy boundary drawn by the module format itself) · `Hβ.persist.cross-machine-resume` *(new)* · `Hβ.persist.branch-world-tag` (persist.mn:119) · `Hβ.continuations.wasmfx-lowering-tier` *(substrate PROBED 2026-07-10: wasmtime 43 `-W stack-switching` + wasm-tools 1.252 assemble native typed-continuations — single suspend/resume runs (fx1→10) — but the cont is LINEAR: resuming one twice PANICS the engine (`ptr::eq(head, self)`). So native gives ONE-shot free (already fast-pathed by direct-call) and does NOT solve MULTI-shot; the multi-shot keystone is RE-EXECUTION — `cont.new(body)` fresh per resume, replaying prior performs, the trail/rollback substrate the driver — not native cloning. `perform`→`suspend`, `resume(v)`→fresh-cont resume; the emit path switches to wasm-tools for continuation modules (WABT can't assemble `cont`). This IS the producer-invocation keystone the cardinality fix unblocked — see §7)* · `Hβ.continuations.multishot-reexecution-driver` *(the re-execution driver — PROVEN END-TO-END 2026-07-11, crucibles in tests/native-cont/: native-cont `twice` → 3 (identity) and 13 (non-identity `pick()+5`, the continuation after the perform captured natively), and the same model in Mentl source → 30 through boot. A multi-shot handler is a DRIVER over re-runs: `resume(v)` = fresh `cont.new(body)` resumed to the `suspend`, then resumed with v; `suspend` unwinds the perform to the driver so the arm runs OUTSIDE the body's stack (no re-entrancy — the trap the pure-Mentl outer-install form hit). Correct for identity / non-identity / no-perform. **BUT native conts are BLOCKED under WASI `_start` (wasmtime 43, verified 2026-07-11): a single `cont.new`+`resume` under `_start` panics `ptr::eq(head, self)` — the command entry runs on wasmtime's own fiber and a user continuation violates its stack invariant; `--invoke` works, `_start` (every real program) does not, and no flag avoids it.** So native conts are the O(1) future (an `!Outside` dependency until wasmtime carries them under `_start`), NOT the shipping substrate. THE SHIPPING PATH is the PURE-MENTL re-execution driver — `resume(v)` re-runs the body thunk under a one-shot replay handler, all ordinary handlers, works under `_start`: the DIRECT form (arm logic as a driver fn, no outer install) is proven (reexec-model.mn → 30) and correct when the body performs the op unconditionally (mn-multishot). The general form (conditional / no-perform bodies) needs the ARM-INTERNAL-PERFORM GAP closed — the re-run's perform must resolve to the inner replay, not re-enter the outer handler (the pure-Mentl outer-install driver's 134 trap). THAT is the real keystone dig, `!Outside`-clean. Each rerun is a stateless fork → trivially parallel + durable, the SPACE=TIME fork §5.U scheduled by `~> Schedule`)* · `Hβ.lower.arm-internal-perform-scope` *(new — the gate under multi-shot: a handler installed INSIDE an arm body (`bt() ~> replay(v)`) must shadow the enclosing handler for performs in the re-run; today the re-run's perform re-enters the outer handler (evidence threads to the wrong install). Closing it makes the pure-Mentl re-execution driver fully correct AND fixes arm-internal effectful installs generally — core handler correctness, not just multi-shot)* · `Hβ.infer.tail-recursion-resume-cardinality` (infer.mn:3174) · `Hβ.lower.either-install-negotiation` · `Hβ.felt.time-travel-debug-forked-cursor` *(new)* · `Hβ.ml.autodiff-as-multishot` (autodiff.mn:36).

**C · IFC — flow in the row (arm 4/6, §4⑥; W31 scaffold landed).** `Hβ.verify.ifc-noninterference` (umbrella; code `Hβ.types.ifc-flow-constraint`, types.mn:1029) ← `Hβ.ifc.dcc-noninterference-gate` → `.flowlabel-inference-in-hm` → `.pc-label-implicit-flow` → `.integrity-dual-lattice` (prompt-injection IS an integrity-flow violation) → `.declassify-robust` → `.flow-world-on-tcont` → `.agentic-fides-target`. DEP-rooted on `sound-neg-under-poly`.

**D · The value layer — fold & repr (arms 1/7, §5.U; STEP 0/1/2 landed).** `Hβ.fold.show-leaf` (synthesize as a lowered LFn, not raw WAT; lower.mn:481) · `.compare-hash-leaf` · gate `Hβ.eq.fold-seed-value-gate` · `Hβ.repr.arrow-layout-interop` · `Hβ.emit.variant-payload-repr-width` (wasm.mn:4913) · `.plit-handle-repr` (wasm.mn:5537) · `Hβ.value.ontology-derivation-complete` · `Hβ.runtime.zero-copy-string-view` (lexer.mn:316) · `Hβ.emit.image-map-fold` *(new 2026-07-10 — the module's static layout as ONE fold in the emit: each region's base IS the previous region's limit (sentinel space | records | thread records | interned data | bump heap), overlap unconstructible; born from the ev_scan record clobber (a closure record at 264 sat inside io.mn's fs path scratch — two files claiming one page in prose). The fold IS band B's persist substrate: it defines what a memcpy snapshot means)* · `Hβ.io.scratch-dissolves-into-alloc` *(LANDED 2026-07-10, f0089a3 — page 0 carries no runtime scratch: every syscall record (iov / nread / prestat / filestat / fd-out) allocs per use; fs paths cross the boundary as (ptr, len) views straight into the string payload (`fs_path_view` — the old copy-into-scratch re-derived bytes the image already holds; WASI paths are explicit-length); `read_stdin_loop` + `fs_read_loop` unified into one `fd_read_loop` (stdin and opened files are the same stream); ten io fns re-rowed +Alloc; net −8 lines. The march measured the prediction WRONG in the good direction: a lib-source-only change holds m2 == m3 in ONE generation (both generations compile the same source with the same emit) — the transition form is for EMIT changes only. Gates: 52/52 boot, 8/8 + 52/52 through m2, fixpoint byte-exact, serve battle green)* · `Hβ.tools.march-transition-native` *(new 2026-07-10 — on m2 ≠ m3 march.sh runs the m4 leg itself and reports TRANSITION (m3 == m4, re-pin from m3) vs BROKEN (m3 ≠ m4); removes the bless-the-wrong-generation human-error surface — bash scaffold tier)*.

**E · Parallelism & accelerators (arm 3, §4④; STEP 4 collapse landed).** `Hβ.lower.fanout-simd-lane-cashout` (RV128) · `.fanout-gpu-backend-handler` (lower.mn:1475) · `.fanout-durable-persist-handler` (SPACE=TIME) · `Hβ.parallel.thread-alloc-transitive-proof` (verify ONLY after the leak closes) · `.race-freedom-ownership-proof` · `Hβ.infer.fanout-ownership-from-use-count` (infer.mn:1288) · `Hβ.runtime.wasi-thread-spawn-seed` (threading.mn:296) · `Hβ.driver.level-set-par-walk` *(the topological layer-partition is LIVE in driver.mn — 7165bbb; the open half is the multi-core `>< ~> Thread` at the layer site)* · `Hβ.cursor.speculative-compile` · `Hβ.cursor.work-stealing-via-gradient` *(idle cores ask the cursor "what next?"; the gradient's argmax IS the priority queue — no scheduler module)* · `Hβ.lower.schedule-specialized-callee` *(new — the parallel_map dissolution's open remainder: whether a reusable fn's internal `><`/`<|` should EVER inherit a caller-installed `Schedule` across a call boundary. The only sound route is compile-time specialization of the callee per install-context, preserving `Seq`'s zero-cost/`!Thread`-provable property — the §5.3 dispatch gradient's sibling on the INSTALLED-HANDLER axis (vs the known-argument axis; shares callee-specialization infra). The ambient/evidence-passed-runtime `Schedule` alternative is the wrong direction — it taxes every `Seq` fanout to buy portability only a rare `Thread` caller needs. Scoped skeptically: direct `>< + ~> Thread` at the use site is sufficient and simpler; build only when a real consumer needs one fanout helper serving callers wanting different schedules. Sequenced behind `Hβ.driver.level-set-par-walk`, DEP-gated on band-A `sound-neg-under-poly`)*.

**F · Verification & proof (arm 6/8).** `Hβ.types.predicate-is-expr` (dissolve PExpr) → `Hβ.verify.smt-handler-swap` (Z3+CVC5; NAME the external-SMT residual !Outside if it persists) → `.higher-order-refinement` · `Hβ.verify.ledger-soundness` (no silent assume-true; the Dafny `{:axiom}` cautionary) · `.proof-incrementality-cached-cursor` · `.reason-edge-pcc-certificate` · `Hβ.dsp.hz-ceiling-ambient-sample-rate` · `Hβ.refine.buffer-invariant` · `Hβ.infer.predicate-from-bool-expression`.

**G · Graph & e-graph (arm 1) — highest-leverage incompleteness first.** `Hβ.egraph.per-expr-effect-row` (egraph.mn:70 — reduces is_pure to effs_at alone, generalizing the effect-gate to every rewrite) · `Hβ.lower.egraph-saturation-deepen` · `.typed-rulecyclic` (the depth-1000 cap → a typed E_RuleSetCyclic via the Why chain, unreachable-by-construction) · `.rule-as-query` · `.extraction-cost-composes-repr` · `.const-fold-minted-node-full-edges`.

**H · Ownership (arm 5, §4⑤).** `Hβ.ownership.fractional-uniqueness-ref-borrow` (Granule ICFP 2024) · `.quiet-empirical-gate` (the Hylo bar — a corpus test counting authored own/ref markers; a rising count IS inference failing §4⑤).

**I · Dataflow & DSP (arm 3/6).** `Hβ.dataflow.causality-compile-error` (a zero-delay `<~` cycle is a compile error, Faust's causality rule; no code anchor yet — the peer is named here, not in a comment) · `.clock-calculus-sample-rate` · `.point-free-fusion-via-egraph`.

**J · Self-hosting & !Outside hardening (L7, §1).** `Hβ.closure.diverse-double-compilation` (Thompson/Wheeler 2009 — a second disposable seed converging to identical m3 closes trusting-trust, which the byte-fixpoint alone cannot; DEP native backend) · `.correctness-oracle-internal` (the external micro-battery → the wheel's own Verify; until then first-light's correctness half is itself an !Outside) · `.reflexive-over-proposers` (code `Hβ.synth.proposer-gauntlet`).

**K · AI-proposer / Synth (arm 2, §0/§1).** `Hβ.proposer.constraint-not-token-worked-example` (Lahiri 2026 — answer the spec-oracle problem with a worked example, not a claim) · `.synth-handler-error-fed-back` (the lossless constraint, not the lossy token).

**L · The Why-engine & `mentl audit` (arm 8/1, §0 — the medium enforcing its own discipline).** `Hβ.audit.carried-truth-projection` *(new — the §0 keystone: project a Carried-Truth violation BEFORE a line is written, making the wrong move unsayable)* · `Hβ.diag.minimal-inconsistent-core` (= `.why.minimal-cause-set`) · `Hβ.infer.marked-lambda-totality-invariant` (POPL 2024) · `Hβ.diag.catalog-as-projection` (report takes a DiagKind ADT) · `Hβ.diag.duplicate-type-name` *(new — two `type X` decls in one namespace shadow silently today (the Handle collision, 2026-07-05); the decl site deserves the refusal, per the E_ImportNameCollision precedent)* · `Hβ.diag.declared-row-contradiction` *(new — `with IO + !IO` today surfaces only downstream when the body performs the dropped effect (the subsumption gate, loud); the ultimate teaching surface is a decl-site diagnostic at the signed-set build, MachineApplicable. Named 2026-07-05 so the gate doesn't silently stand in for it)* · `Hβ.query.graph-projection-surface` *(new)* · `Hβ.emit.trap-as-exception-postmortem` *(new 2026-07-05 — wasm exception-handling (exnref, standardized) lets a BUG-trap unwind with a payload instead of `unreachable`+stderr: the payload is the graph state at death, projected — the coredump autopsy face 7 needed, as a structured projection instead of a heap read; zero steady-state cost, diagnostics-tier only)*.

**M · The felt surface / `mentl edit` (L6, §4⑦, §0 pt 5 — oversight is survival, NOT garnish; the thinnest-swept band, most at risk of erasure).** `Hβ.felt.mentl-edit-runtime` *(new — the canonical IDE as a running keystroke→parse→format→render loop)* · `.reactivity-typed-demand-driven` · `.lsp-transport-projection` *(new)* · `.collab-grove-cmrdt-semantic` (Grove POPL 2025, over the TYPED graph) · `.legibility-derived-not-molded` · `.verification-dashboard` *(new — live V_Pending / transitive-!E / Why-chain for oversight)* · `.hole-is-dormant-continuation` (Hazel fill-and-resume = the multishot record).

**N · Backends — the handler IS the backend (§5 stage 3). FULL PLAN: docs/NATIVE.md (the graph-is-the-machine native backend, designed + 24-agent-refuted 2026-07-11; the build spine S0–S18, WASM-peer-verifiable through S12, native first-light at S13).** The two keystones: `Hβ.native.frame-rep-from-cardinality-trail` *(new — KEYSTONE 1: frame representation IS the resume-cardinality/ownership grade — OneShot activations are trail-reclaimed image frames (graph.mn's graph_rollback is the activation spine, NOT %rsp which demotes to a bounded CPU-mandated trap scratch), MultiShot captures the delimited frame segment as a memcpy-able image record; "continuation = memcpy" becomes true because every frame is in the image; the "no stack" thesis was SML/NJ heap-CPS without its GC — the trail is the GC-free reclaimer, !Outside-clean)* · `Hβ.native.deterministic-handle-partition` *(new — KEYSTONE 2: fixed per-core (arena_id, offset) partition so handle assignment / code layout / rel-offsets are a pure function of the graph → native_m3==native_m4; work-stealing a value-reproducible-only ~> Schedule handler never on the self-hosting path; kills the two-modes header flag, drift-8)* · `Hβ.native.repr-regclass` *(repr_regclass(Repr)→GPR|FP|VEC, the third terminal projection beside repr_wat/repr_width; S1, Law-7 no-op for WASM)* · `Hβ.infer.use-profile` *(S2 — count_uses→(grade, use-positions, escape-bit), the ONE liveness analysis five native layers each deferred; escape set from lower's capture set, zero new analysis)* · `Hβ.native.reg-residency-egraph-remat` *(register allocation = use-count residency; eviction = e-graph rematerialization at extraction cost, NOT Belady/linear-scan)* · `Hβ.backend.native-codegen-handler` (native.mn as ~> NativeOut peer on the same LowIR; retire wasmtime/WABT) · `Hβ.native.fp-simd-determinism` *(new — S10 THE fixpoint-killer: pin SSE-only/no-FMA/RNE so native float bytes match WASM's strict IEEE-754, else native_m3≠native_m4 on the first float the wheel computes)* · `Hβ.native.foreign-handler` *(new — ~> Foreign, maximal-unknown !Pure row, copy-at-boundary; the one !Outside seam for the un-Mentl world)* · `Hβ.native.effect-state-parallel-safety` *(new — S12: a stateful effect in >< ~> Thread is a compile-time refusal unless replicated-and-merged or !<effect>; the native face of band-A sound-neg-under-poly; native codegen SHIPS before band A but its safety story is only PROVEN after)* · `Hβ.native.wasm64-backend-handler` · `Hβ.emit.memory-gc-handler`. **The WASM multi-shot (S3/S4 in the peer, proven this session, tests/native-cont/): `Hβ.lower.multishot-uzero-abort` *(a multi-shot driver arm is UZero-grade — never resumes its own op — so it must ABORT the triggering continuation, not tail-resume; Mentl currently tail-resumes a zero-resume arm; the fix is cardinality-driven)* · `Hβ.lower.config-fn-evidence-in-arm` *(a handler-config-param function called in an arm carries the wrong evidence — a re-performed effect re-enters the arm's own handler; the body thunk must be a direct-named global, not a config lambda).**

**O · Self-hosting infra (resolves AT/around first-light; captured so it is not forgotten — NOT post-first-light work).** `Hβ.seed.float-gradient` · `Hβ.seed.multishot-producer` (both dissolve at first-light) · `Hβ.persist.module-image-cache` *(cross-run module skip as §4④ image-persist: the graph image memcpy'd whole — env entries, oracle queue, Reason chains intact — keyed by source hash + transitive dep hashes, the invalidation design the deleted .kai layer proved; rides band B's persist-equals-memcpy substrate; supersedes the deleted `Hβ.cache.cross-file-resolved-row`)* · `Hβ.driver.per-module-env-overlay` · `Hβ.f1.handler-substrates`.

---

## §6 · The bootstrap reality

> **THE SEED IS DELETED (7401c4b "Fly, my pretty <3", 2026-07-10 — Morgan's own
> hands, the day after first light).** The build loop is `boot/mentl.wasm` (the
> pinned fixpoint wheel, boot/PROVENANCE.md); the ladder below is git
> archaeology — the cold-bootstrap recipe lives at tag `first-light` (band J,
> diverse-double-compilation). Everything in this section phrased as present
> tense about the seed is HISTORY of how the wheel was sparked.

Mentl bootstrapped **backward**. The VFINAL codebase in `src/**.mn` (+ `lib/**`)
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
  scaffolds (`state.sh`→`mentl where`, `verify.sh`→`mentl verify`,
  `run-micro.sh`, `drift-audit.sh`→`mentl audit`); the external runtime/assembler
  (wasmtime, WABT) — the arc to native is `!Outside` (§5 stage 3).

**File map (the wheel):** `graph.mn` (graph, flat-array O(1) chase) · `types.mn`
(Ty + Reason + Scheme + typed AST) · `effects.mn` (EffRow Boolean algebra) ·
`infer.mn` (HM, one walk, the write) · `lower.mn` (the projected read) ·
`backends/wasm.mn` (LowIR → WAT) · `parser.mn` · `pipeline.mn` · `mentl.mn`
(oracle/synth) · `cursor*.mn` (the felt read) · `bootstrap/src/` (modular WAT).

---

## §7 · Current state (grounded 2026-07-08 — **m3 ASSEMBLES (wat2wasm 0 errors) for the first time this arc, AND PARSES — the trap has marched all the way to the FIRST INFER PERFORM. Two Carried-Truth roots closed this session: (1) the fn-result-repr REGISTRY DELETED (8e… earlier: cfbdf8e's "wheel trusts the floored inference type" was REFUTED — the `$w.f64` USE node proved `repr_of(lookup_ty)` holds Float LIVE; the registry was a §2 side-ledger AND inert via the ev-seam; deleted whole, every call/ft width now reads `repr_of(lookup_ty(call_node))` live; m3 9→1 errors). (2) `float_of_int`/`float_to_int` TYPED AS ENV PRIMITIVES (8e9f7f3): they were recognized ONLY at lower (→ f64.convert_i32_s / i32.trunc_f64_s), UNTYPED at inference → 175 E_MissingVariable → a FREE VAR that cannot force `float_of_int(n) * x` to Float, so x floored to i32 and the product emitted `f64.mul [f64, i32]` (the standing score_one_position error). `register_primitives()` in infer_program registers `float_of_int : Int→Float`, `float_to_int : Float→Int` (pure, monomorphic) before pre_register → the multiply unifies its operand to Float. m3 wat2wasm 1→0 errors, E_MissingVariable 175→148 (the rest are OTHER recovered undefined names, pre-existing), rungs 8/0, micros-through-m2 45/0 (NO regression). THE SCORE ERROR WAS NOT A FORWARD-REF FLOOR (that framing was a partial picture — the multiply WOULD resolve proximity once float_of_int is Float). A dependency-order inference reorder (Hβ.infer.scc-ordered-walk) WAS built + verified (fbare/lit/chain forward-ref micros fixed, 45/0 no regression) then REVERTED: not needed for m3 (float_of_int typing fixes the site), and the naive `driver_partition_layers` peel is O(n²) over ~1605 decls (too slow — m3 gen ~8min). Kept as a NAMED future improvement — the ULTIMATE form is the call graph as REAL GRAPH EDGES (fn handle→dep handles, in-degree a node field, topo-order a graph traversal, composes with the IC cursor); build it ONLY when a bare-forward-float case (no forcing multiply) actually bites. **THE ev-seam FIXED (10124f1) — and the root was NOT "emit lacks sst_".** The wheel's emit HAS the sst_ evidence-clone (for LSuspend, walk_locals wasm.mn:1688 + emit). The real root was in LOWER: `lower_call_default` (lower.mn:669) produces `LCall` (bare, no evidence) vs `LSuspend` (sst_) by `len(derive_ev_slots(fh))==0`, and `derive_ev_slots` read the FROZEN LEAF `effects_of(lookup_ty(callee_handle))` — which DROPS a forward-ref callee's effect (mint_param_placeholders, defined AFTER pre_register_fn_sig at infer.mn:2768>204 — its Graph effect never entered the frozen instantiated row). So the effectful call lowered to a bare LCall, no evidence, and the callee's strict `ev_perform_entry` key-scan met an empty region → OOB. `escaping_row` (the flow-closure `own∪callees_escaping−handled`, precomputed at `lower_program` via `ls_register_escaping`) was BUILT precisely to recover forward-ref-dropped effects and its own doc names `derive_ev_slots` as the consumer — but derive_ev_slots was never wired to it. FIX: `evidence_effects_of` unions the per-call-site leaf with the flow-closure (`escaping_row(callee name)` / `lambda_escaping_row`). Verified: `.build/probe/evfwd.mn` (caller→forward-ref deep(), both `with Poke`) threads sst_, runs exit 9; m2 rungs 8/0 + micros 45/0 (NO regression). m3 wat2wasm 0 errors, RUNS PAST the pre_register seam — the trap MARCHED (progress) to `infer_fn`'s `inf_exit_fn`. m3.wat 285k→513k lines = the correct forward-ref evidence threading (previously dropped); the escaping_row `esc_assoc` O(n) lookup + the per-call sst_ clone are named efficiency follow-ups, and `Hβ.infer.order-free-live-row` (leaf==flow-closure, the union dissolves) is the deeper form. **THE NEW WALL — inf_exit_fn HANDLER-STATE RECORD-TYPE FLOOD (a THIRD freeze class, NOT forward-ref, NOT ev-seam).** m3 traps `unreachable` (`field offset unprovable`): `inf_exit_fn` reads `frame.row_handle` where `frame = last(stack)`, `stack` = the `infer_ctx` handler's list-state of ANONYMOUS records `{accumulated_row: EffRow, declared: List, fn_span: Span, row_handle: Int}`; the wheel's inference has LOST the frame's record type by the READ, so the field offset is unprovable. `bind_handler_state_names` (infer.mn) binds `stack` as a SHARED `Forall([], TVar(ih))` (state_binds computed ONCE at infer.mn:3111), so it SHOULD ground across arms (inf_enter_fn's `stack ++ [frame]` unifies ih=[frame_type]) — yet it floors, so the model is incomplete. NOT reproduced by the simple micro (`.build/probe/hstate.mn`: 2-arm list-of-records, one push + one field-read → runs CLEAN, exit 0). The trigger is SPECIFIC: the frame field flows into an EFFECTFUL call (`graph_bind_row`, now LSuspend via the ev-seam fix), AND/OR the multi-arm construction (inf_enter_fn/inf_add_effect/inf_add_row each build/update the frame), AND/OR the `EffRow`-typed field. NEXT: a FAITHFUL minimal repro (field-of-`last(state)` → effectful-call arg; ≥3 record-constructing arms; an EffRow field), then ground the frame record type live at the read — the next freeze→live. THE SYNTHESIS (Morgan 2026-07-08): there is NO single freeze — the wheel floors in distinct ways (forward-ref call-order; handler-state arm-propagation; missing primitives), unified only by "frozen where it should be live"; the trap-march DONE RIGHT (each fix a genuine snapshot→live conversion, never a patch) IS the incremental dissolution, converging on order-free-live inference at first-light. **CRUCIBLES to promote: `.build/probe/evfwd.mn` (forward-ref effectful call, the ev-seam) + `ffwd.mn`/`fbare.mn`/`fback.mn`/`lit.mn` (forward-ref float).** first-light = diff(m3,m4) empty AND battery green THROUGH m3. #1 proven-singleton (Approach B) REFUTED — abort_exit is a LIVE uninstalled default handler**; gates: `verify.sh` + `march-gate.sh --micros`)

> **▶▶▶ THE 4096-BYTE LEXER CUT = RAW-TNAME ANNOTATIONS — CLOSED (f320f97,
> 2026-07-09); m3 now reads WHOLE inputs; the trap MARCHED into m3's own emit /
> e-graph layers, three faces named.** The GPT/Gemini days (b9aec57→2eea30b) were
> triaged against the artifact and KEPT: the instance-flow root (derive_handler_ename
> live from arms; unify-ALL-instances at the install — the banked "(B) at a non-hot
> seam", realized as allocation-free handle joins), the fold-accumulator threading
> (type_name_eq String pin, chase-to-root, config-before-state + post-arms
> re-generalize; crucible fold-accumulator=4 GREEN through m2), the seed TAlias
> registration (pass-2 E_MissingVariable 139→46), and the NHole handle fix — 2eea30b
> was committed one brace short (infer.mn 694/693, did not parse standalone) with the
> repair sitting uncommitted; completed (839680c), the mixed working tree split into
> per-concern gated commits (acef612 io read_stdin 64KB/alloc-iov, 4597fce
> name_set_union one-home, 2026d49 the three concat pins as NAMED residue + stray
> file dropped). m2-tier after: **8/8 rungs, 47/47 micros-through-m2**.
>
> **THE ROOT (this session's dig, probe chain in f320f97): `pos: ValidOffset`
> annotations bound the raw SYNTACTIC TName onto the param handle — the env's
> TAlias(name, TRefined(base, pred)) edge was never read** (build_param_types →
> quantify_ctor_ty kept capitalized names verbatim; aliases registered only in the
> MAIN walk, which in the sorted wheel runs AFTER src/'s annotations convert). The
> compare dispatch (emit_one_compare_helper keying on fold_strip) saw a bare nominal
> → minted $compare_nValidOffset, the SUM compare: scalar below heap_base(4096),
> TAG-COMPARE OF DEREFERENCED OPERANDS above — so m3's lex_from `pos >= n` went to
> garbage the moment the input crossed 4096 BYTES and the lexer took the EOF branch.
> Every m3 compile saw ≤4KB: lib/ (sorted after src/) never registered — m4.err's
> six E_MissingVariable (print_string/make_list/list_extend_to/list_set/
> str_concat_all/slice) are ALL lib fns — reachability collapsed 2560→2129 fns, m4 =
> 6KB scaffolding. Surfaced BY 8042ea2 (before it the annotation was an inert free
> var → scalar compares by default). FIX (three cuts, one home each):
> pre_register_stmt gains RefineStmt/AliasStmt arms (aliases are pure env writes —
> order-free registration); the main walk keeps only the Verify obligation;
> quantify_ctor_ty's uppercase-nullary leaf resolves through env_lookup (a
> Forall(_, TAlias(..)) entry binds as the LIVE alias; nominal records / ADTs /
> undeclared names stay TName). Crucible mn-refined-cmp=3 (operands 4200/5000 above
> heap_base, alias declared LAST = the wheel's hostile order; broken path returns 7).
> Method note: the probes ran against the EXISTING m3.wasm in seconds each
> (blank-line ladder bracketing [4015,4109] bytes → byte-content map proving the
> source intact → value probes total/n/final_count → lex_from's first compare read
> in the extraction) — no wheel-eprints, no re-marches, exactly the ⟲ toolkit.
>
> **THE MARCH AFTER (2026-07-09): m2 103,601 lines; m3 409,553 lines, exit 0, NO
> trap. m4 generation now TRAPS exit 134 — call stack exhausted in iterate_from —
> and the battery-through-m3 is 0/47 on TWO NEW faces (not the old concat wall):**
> - **Face A — EVIDENCE-TAIL: CLOSED (2158c4e, same day).** mark_tail had no
>   LSuspend arm, so evidence-threading recursions stayed plain call_indirect
>   (m2's iterate_from carried the seed's 1× return_call_indirect; m3's had 0).
>   LSuspend gains a sixth field `tail: Bool` — mark_tail the ONE writer, the
>   arity change over a new node so no walker's wildcard swallows it (the TCont
>   lockstep precedent; 19 sites moved together); the emit's dispatch picks
>   return_call_indirect when tail (the sst_ clone is argument computation — the
>   seed's clone-then-tail form). Sound for every resume discipline: a
>   return_call gives the callee the caller's continuation, and continuations
>   here are heap records, never native-stack captures. Crucible
>   mn-effectful-tail=7 (200k-deep with-Tick tail recursion; was exit 134
>   stack-exhausted). m2-tier 8/8 + 48/48. **THE MARCH AFTER: m3 now reads,
>   lexes, parses, and INFERS the whole 36,754-line wheel — m4 gen traps in
>   m3's own LOWER (`lower_pipe`, an `unreachable`): one of lower_pipe's four
>   `++ on unresolved element type` concat floors EXECUTES.** The m4 blocker
>   has CONVERGED onto the known 14-floor concat class (band D / the state→param
>   root) — no longer latent, now the live frontier. lower_pipe's floors are the
>   pipe hole-completion appends (`args ++ [lo_l]`); the root question is why
>   the args list's element type is unresolved at m2's compile of the wheel.
> - **Face B — EMITTED-TEXT FRAGMENT GLUE:** m3-as-compiler emits malformed WAT for
>   even pure rungs — `unexpected token "i32call_7"` (a locals decl and the next
>   fragment glued, separator lost). The view-splice-following-chunk class
>   (`Hβ.emit.view-splice-following-chunk`, named 2026-07-07) detonating inside the
>   emit strings themselves; the same scrambling garbles m3's diagnostic spans
>   (`0handle 25 @epoch=`). Likely the cheapest face — it gates the pure rungs
>   through m3.
> - **Face C — rw_const_fold trap:** every +rt compile through m3 traps in the
>   e-graph's const-fold rewrite. Un-dug; census after B.
> **THE CONCAT-FLOOR CLASS IS EXTINCT — 14 → 0 (581a92f + c595cc5, same day).**
> The 14 floors mapped to three homes, each a distinct dishonesty, each fixed at
> its source: (1) lower_pipe + driver_partition_peel — LCall/LTailCall/LSuspend
> args and LMakeVariant fields were declared bare `List`, an UNREGISTERED nominal
> that erases the element type at the declaration (grep `type List` = zero hits);
> `[LowExpr]` + the driver's `[String]`/`[[String]]` pins ground them (crucible
> mn-adt-list-payload=3: the bare-List twin traps 134, the honest decl runs). (2)
> the render family (9 floors) — int_to_str/float_to_str/float_format_* build
> flat strings by ADDRESS ARITHMETIC (`p + 4` types the value a word), so `++`'s
> sequence proof CANNOT arrive until §4① String=[Byte]; eleven `-> String`
> return-pin attempts were REFUTED at the artifact (they CONFLICT with the
> Int-typed bodies — +58 recovered mismatches, floors unmoved) and the honest
> today-form is `str_concat` BY NAME (the names_concat precedent — the author
> states the representation; no dispatch, no guess; §4① residue). (3)
> render_gradients' join fold → `str_concat_all` (one home). **Grounding the
> floors gave the family its FIRST-EVER execution, which found float_is_inf
> comparing against `1.79…e308` — TFloatLit has NO exponent form (SYNTAX §Token
> enumeration), so `e308` lexed as an IDENTIFIER and every finite float rendered
> "Inf". Fixed with the IEEE identity `f == f && f - f != f - f` (the only
> e-notation literal in the wheel, censused; float_is_nan already the sibling).**
> Crucible mn-float-render=3 (trim-invariant). Named cosmetic residue: the
> 17-significant-digit untrimmed tail (`2.5000000000000000`).
>
> **THE m4 FRONTIER AFTER (march 2026-07-09 late): m3 409,567 lines clean, ZERO
> concat floors, 5 field-offset floors (render_audit ×4 +
> ls_current_lambda_handle_loop).**
>
> **THE REACH OOB WAS MEMORY EXHAUSTION, NOT CORRUPTION — CLOSED (2fc7544).**
> Three binary-probe cycles (huge-pointer threshold, exact `memory.size` bound,
> view-field validation) found structurally perfect operands because nothing was
> corrupt: the wheel emitted `(memory 32768 65536 shared)` — 2GB initial — while
> the seed gives m2 the full 65536 pages, and the bump allocator NEVER grows
> memory, so a wheel-scale compile "allocated" past 2GB arithmetically and the
> first READ trapped (in reach's str_eq, whatever happened to live past the
> line). One line: initial = max = 65536 (wasm.mn). The probe lesson: when
> operands keep proving clean, suspect the SUBSTRATE bounds — the two layers'
> module preambles diff in one grep. **WITH 4GB, m4 GENERATION RAN THE FULL
> PIPELINE — read, lex, parse, infer, lower, reachability — AND EMITTED 6,788
> LINES of m4.wat (type section, imports, memory, data, globals) for the first
> time in project history, dying at the FIRST FN BODY: indirect call type
> mismatch in emit_const → emit_float_const.**
>
> **▶▶▶ THE BOOT ERA (2026-07-10, 77da34d + b72590d — same day as first
> light).** The seed LEFT THE LOOP: `boot/mentl.wasm` IS first light (sha
> b3314001…, provenance + re-pin recipe in boot/PROVENANCE.md), and every tool
> boots from it — verify.sh (no seed build; the census is now the compiler's
> own count on the wheel), march-gate.sh (m2 := boot(wheel): every rung and
> micro runs through a WHEEL-emitted compiler, strictly stronger), and
> march.sh, which ASSERTS `m2 == m3` ON EVERY RUN — the fixpoint RATCHET, a
> two-generation loop (measured: "✓✓ FIXED POINT holds", 8/8 + 52/52 through
> it). The seed + its `--from-seed` ladder are deleted
> (7401c4b); the cold recipe lives at tag `first-light` (band J). **And band M's first artifact
> exists: `ide/` — mentl edit in the browser, RUNNING THE FIXPOINT COMPILER
> ITSELF** (a 512MB-initial repack, derivation in ide/README.md): the
> keystroke→compile→project loop live (fresh instance per compile — the bump
> allocator never frees, so instantiation IS the reset), clickable
> diagnostics that jump to the source line, the emitted WAT + stats, six
> demos, the five verbs and `??` accented. Verified headlessly under V8
> (`node ide/test-shim.mjs`) + COOP/COEP isolation headers (shared memory
> needs cross-origin isolation). Run: `bash ide/serve.sh` →
> localhost:7378/ide/ — THE SERVER IS MENTL (ide/serve.mn, an HTTP/1.1
> file server on the WASI socket substrate lib/runtime/net.mn; serve.py
> is deleted — no python in the run path). Named follow-up:
> `Hβ.felt.ide-run-in-page` (an in-browser assembler). **THE IDE GREW ITS FIVE
> SURFACES (2026-07-11, 73d21df): mentl edit is now the DESIGN_SYSTEM/MENTL_EDIT
> cursor-mode rail — one caret is the one reader, every panel a projection of it.
> Canvas (SYNTAX-faithful, each glyph its kernel-role hue), Aspect ring (eight
> facets, each an always-visible provenance badge surface/declared/real/socket),
> Lens (real stderr gradient-ranked to one teaching step + the two real
> canonicalization fixes), Ledger (with-rows + the !E proof surface), Wavefront
> (Why strip + dormant band-B realities/trail gates). Every pixel is real compiler
> output or a LABELED source parse — no guess posing as graph truth; the magic
> (fill-and-resume, realities) is an honest socket naming its gate, never a mock.
> Served by ide/serve.mn under COOP/COEP; verified end-to-end. Design + surface
> honesty adversarially checked (18-agent workflow, all seven surfaces
> SHIP_WITH_FIX, folded in).**
>
> **THE MULTI-SHOT PRODUCER — FULLY ADVERSARIALLY VERIFIED (3-refuter pass,
> 2026-07-11); the verdict: do NOT ship the narrow lower-time driver — it is the
> band-aid the discipline forbids.** (1) EVIDENCE axis PROVEN SOUND through boot
> (hand-written form): the re-run's perform resolves to the INNERMOST replay,
> co-performed effects pass to the outer handler, NO re-entry — because ms_handler
> is never installed (its arm body BECOMES the install expression) and the body is
> a captureless top-level global taking fresh evidence per call site. (2) Holds
> ONLY under three conditions: body emitted as a captureless top-level global with
> an EMPTY lexical handler stack (bypass the PTee ms_handler push); free vars +
> handler state threaded as PARAMS, never closure captures (a closure under a
> same-effect outer handler is the D2 `undefined local $__hstate` assemble trap);
> and the replay handler REGISTERED so the op is non-singleton → Tier-2 evidence
> (an unregistered lower-synthesized replay leaves the op singleton → Tier-1
> `lower_singleton_perform` re-reads `$ms_handler_state_g` → re-enters the driver —
> the synthesis refutation). The "therefore an AST-level desugar" conclusion
> this produced was itself REFUTED same-day (Morgan's interrogation — see THE
> PIVOT below): the desugar bakes the WASM workaround into the SOURCE graph.
> The refuter FACTS stand (evidence-soundness, the three conditions, the
> classifier coupling); only the destination moved. (3) The direct-driver is correct ONLY for mn-multishot's shape (pure
> prefix-free body, single arg-independent perform, stateless arm); the GENERAL
> form needs op-ARGS (the trigger form, not the direct-driver), per-resume STATE
> (thread ms_handler's record through re-runs), and re-duplicates any effectful
> PREFIX (native-cont O(1) is the exact-semantics `!Outside` future). (4) THE
> FIXPOINT COUPLING (the sharpest finding): the wheel's TWO real multi-shot
> handlers — `backtrack` (search.mn:134) and `Synth.enumerate_inhabitants`
> (synth_proposer.mn:131) — are exactly the hard case (op-args + recursion +
> effectful), MISCLASSIFIED OneShot today by the `Hβ.infer.tail-recursion-resume-
> cardinality` gap (resume_grade skips called top-level fns). So "fixpoint-safe by
> construction" is really "safe by classifier-gap": completing the classifier flips
> them to MultiShot, fires the new lowering ON THE WHEEL, and breaks the fixpoint
> UNLESS the general form is built — so the classifier completion and the general
> lowering must CO-LAND. Crucibles:
> tests/native-cont/reexec-model.mn (→30, the model, PROVEN) +
> twice-handler-nonidentity.mn (the non-identity lowering gate, dormant → will be
> 36). `mn-float-arith` = assembly `expected [i32] but got [f64]` at a call — the
> callsite-result-width family (`Hβ.m2.callsite-result-width`), fast repro via
> run-micro. Named, not chased same-day.**
>
> **▶ THE PIVOT (2026-07-11, same day — Morgan's interrogation "is this the most
> powerful, future-proof, Mentl-native multi-shot?"; the answer was NO, the
> half-wired AST desugar REVERTED uncommitted): the desugar is the WORKAROUND
> CANONIZED — refuted on three cuts.** (1) It erases the authored `~>` install
> from the source graph before inference — intent LOST (§0 pillar 3: the Why
> chain sees synthetic `__ms_driver` noise), and the native backend (NATIVE.md
> keystone 1: MultiShot = a memcpy'd image frame segment) inherits a pre-chewed
> form it can never re-project — the wheel shaped around the substrate's
> silhouette, the forbidden hedge at the graph layer. (2) Re-execution RESTARTS;
> the felt spec demands RESUME — MENTL_EDIT §4.1 ("filling the hole resumes from
> the suspension — no restart") and band M's hole-is-dormant-continuation
> require k as a HOLDABLE RECORD; re-run-from-zero can never power
> fill-and-resume or reality-scrubbing. The IDE's soul structurally excludes the
> desugar. (3) It fires only on the FV-empty/argless/stateless shape — the
> micro, not the capability. **THE TRUE KEYSTONE is the one §2 always named:
> CONTINUATION-REIFICATION CODEGEN (`Hβ.lower.continuation-reification-codegen`,
> band B's real center)** — generalized evidence passing with YIELD-BUBBLING
> through the unified record, the Koka-lineage compilation the dispatch tiers
> already follow: a MultiShot-classified perform does not call the arm — it
> YIELDS; each frame between the perform and the install appends its
> remainder-as-closure onto the continuation (LMakeContinuation — §5.U's
> "emittable today, constructed nowhere" — at last CONSTRUCTED; handler = state
> = closure = evidence = CONTINUATION, one record); the install's driver runs
> the arm with k BOUND; `resume(v)` = call the k record — N times, it is
> immutable data. Pay-as-you-go: tail-resumptive/OneShot paths never build a
> frame (byte-identical, Law 7; no wheel op classifies MultiShot → the fixpoint
> held by the same gate as before, now guarding the TRUE mechanism). Correct for
> EVERY refuted shape — op-args (the yield carries them), per-resume state (the
> Effekt-ICFP-2025 semantics question stays named), effectful prefixes (ran
> once; k resumes AT the perform, never from zero), conditional/multiple
> performs. What the substrate gives Mentl that Koka cannot have: k is a
> contiguous image record → persist = MEMCPY (durable multi-shot, band B whole),
> thread-shippable (SPACE=TIME, `~> Schedule`), world-tagged
> (E_ResumeWorldMismatch reads k's frozen world), and the IDE hole IS a dormant
> k — fill-and-resume is the same record. Composes with the TRAIL (heap rollback
> between branch runs — §2's per-fork rollback), never competes with it;
> re-execution DEMOTES to the degenerate stateless-replay fork (the oracle's),
> and native conts/wasmFX stay the future O(1) control swap — a backend handler
> swap over an UNCHANGED graph (the future-proofing the desugar destroyed).
> Increments, each gated + byte-identical off the MultiShot path: **(k1)**
> direct-shape reification — the remainder-closure at the perform's own fn + the
> install driver loop + resume = k-call (mn-multishot=30,
> twice-handler-nonidentity=36 via a REAL k); **(k2)** the call-boundary bubble
> (the yield protocol at effectful call sites in MultiShot-capable rows — the
> sst_ choke point); **(k3)** the general spine (recursion; state semantics;
> the classifier completion `Hβ.infer.tail-recursion-resume-cardinality`
> CO-LANDS here, the same coupling as before, now on the mechanism that can
> carry `backtrack` and `enumerate_inhabitants`).**
>
> **▶▶ k1 LANDED, SELF-CONFIRMED (2026-07-11, 1746a87 — the same day as the
> pivot; scouted + designed + twice-refuted by an 8-agent workflow, built
> inline, every edit hook-audited).** THE MULTI-SHOT PRODUCER IS ALIVE:
> `mn-multishot` = **30** (was 10 since the gate existed) through the rebuilt
> m2; `twice-handler-nonidentity` = **36** (the `+3` remainder carried per
> fork); `twice-capture` = **40** (the NEW crucible closing refuter hole H1 —
> captures read through the record). The mechanism as built: a MultiShot
> perform YIELDS via the global triple ($yield_flag/$yield_op/$yield_k — the
> Koka-lineage yielding bit, zero signature changes, thread-local by
> construction, emitted only when the module yields); the performing frame's
> remainder reifies through the VERBATIM LambdaExpr capture recipe
> (collect_free_vars → resolve_captures_outer → ls frame; RGlobal fences the
> op name away); the LMakeContinuation record RELAID to the closure-identical
> head (fn_ptr@0, nc@4, captures@8 — LUpval and the ev-scan read it verbatim;
> state_idx/ret_slot/world_tag ride the tail after the ev sentinel, one
> contiguous memcpy-able record); the install's driver loop runs INSIDE the
> $<hname>_state_g bracket (deep-handler routing by construction — verified:
> a foreign OneShot install between the yield and its driver bubbles clean,
> exit 30) and binds k to the arm's leading __k param; `resume(v)` = LCall on
> __k (the W7 closure-call, N times). EVERY dishonest exit is LOUD: an
> off-spine/args/arm-state perform is a comment-marked emit floor; a
> mid-remainder re-yield traps at the k-call boundary (measured 134 — the k2
> composition floor, never a silent dummy); a DRIVERLESS yield traps at the
> `_start` unhandled-yield backstop (measured 134 — H2 made unsayable). LAW 7
> HELD AND RE-DERIVED BY HAND: 8/8 rungs + 52/52 micros through the k1-m2,
> and the march's fixed point — m2 == m3 BYTE-IDENTICAL, sha 74136aec…, cmp
> clean, provenance genuine (m3 generated by running m2 on the wheel 11
> minutes later) — with the whole k machinery COMPILED INTO the fixpoint
> compiler (defs confirmed present) and exercised on ZERO wheel installs.
> The dormant inverted producer (k minted at the RESUME site from the arm
> snapshot — the arm summed two record POINTERS, the measured invalid-exit)
> is DELETED. What k unlocks is §5.U's whole TIME column: the record is the
> persist=memcpy payload, the thread-shippable fork, the world-tagged resume,
> and the IDE hole's dormant continuation — fill-and-resume is THIS record.
> Instrument lesson re-paid twice in one session: the three "failing gates"
> were zsh passing $LIBS unsplit (the crucible compiled without libs — 14
> fns, no $ev_lookup); the "missing" k1 fn defs were shell-quoting noise
> (python re-count: all present). Verify the INSTRUMENT before the claim.
> **THE k2/k3 DESIGN IS BANKED, TWICE-REFUTED (287521d, 2026-07-11):
> `docs/research/multishot-general-design.md` — 8 scouts + a first-principles
> challenger + 2 independent refuters; every fork ruled with its decisive
> artifact fact (the prove-absence can_yield gate, the evidence-layer
> capability mark, the self-re-composing composer, re-install-in-k,
> dynamic dispatch in resumed segments, the JOIN world). The flip-list is
> censused complete (exactly choose + enumerate_inhabitants; 364 resume
> sites swept); the cut ships only with mn-backtrack-full green (backtrack
> is DEAD CODE in the wheel — no wheel gate can see it). Build order M1 →
> M2 → M3 lives in the doc.**
>
> **▶ THE M1 ARC IS EXECUTING (2026-07-11, same day as the bank).
> M1.1 LANDED (eec974c) — the union-homomorphic world_tag:** one bit per
> effect name (FNV mod 32), row tag = OR of bits, so tag(A∪B) ==
> i32_or(tag(A), tag(B)) — compose is one i32.or and the future value gate
> is a subset test (world-widening-resume in the representation);
> i32_or/i32_and/i32_shl land as Memory-op substrate siblings (3 homes:
> effect decl, is_substrate_mem_op, emit projection). The march ruled
> TRANSITION (the wheel CALLS the new projections while boot's emit
> predated them — m2 != m3 by design, m3 == m4 self-confirmed; battery
> 52/52 + k gates verified THROUGH m3 before the bless); boot RE-PINNED
> from m3 (sha 70d184a0…; PROVENANCE recipe corrected first — on a
> transition the self-reproducing generation is m3, NEVER the fresh m2,
> the trusting-trust mistake); the IDE re-packed from the same m3 — the
> browser compiler carries the k1 producer, the multi-shot demo runs → 30
> live under the keystroke. **M1.2 LANDED — the composer pair (bank
> Ruling 1):** $__k_compose, the ONE generic self-re-composing junction k —
> a composed k is ITSELF a k (closure-identical head [fn_ptr=
> $__k_compose_idx][nc=2][inner@8][frame_k@12][sentinel@16][0][0]
> [world_tag@28]), resume calls it through the same W7 convention, no
> second calling convention, no chain walker; body: r = inner(v); flag
> still raised → $__k_extend re-composes the fresh $yield_k onto its own
> frame_k and the dummy propagates with $yield_flag AND $yield_op
> untouched (the chain rebuilds lazily, one fresh record per crossed
> suspension — the mint is the only write); flag clear →
> return_call_indirect into frame_k (constant stack at any depth).
> Composed world_tag = OR-join of the children — M1.1's homomorphism doing
> the job it was built for ($__k_world_tag walks the keyed-ev sentinel to
> the tail, the same scan ev_perform_entry keys). Table-resident (the one
> new plumbing seam: appended fn-name slot + $__k_compose_idx from the
> same index-global projection every closure mint reads) with $ft2
> FLOORED in when the module yields (the bank's FT SEAM — a yielding
> module with only UZero arms may lack any other 2-arg site). Width pinned
> word-uniform $ft2: a non-i32 frame k meets a LOUD call_indirect type
> trap (Hβ.emit.compose-width-floor; f64 variant the named after). All
> yield_seen-gated — march self-confirmed **✓✓ FIXED POINT m2 == m3**
> (cmp byte-identical, sha 1009d959…; the composer emitter is compiled
> INTO the fixpoint compiler and emits into ZERO of its own bytes — Law 7
> exact). Proven standalone on the VERBATIM emitted text (scratchpad
> crucible: compose(k,k)(5)=25; composed tag 2|4=6; re-yield propagation
> preserving $yield_op → drained 25) AND through the m2 tier: rungs 8/8,
> micros 52/52, mn-multishot=30 + twice-handler-nonidentity=36 +
> twice-capture=40, the trio + table slot 28 + $ft2 censused in
> mn-multishot's emitted module, wasm-tools validates. Instrument lesson
> re-paid: the first census greps returned 0 on a module that HELD the
> trio (BRE `\$`-quoting) — grep -F before the claim; and mn-multishot is
> NOT in the 52-micro baseline, so the k gates are run explicitly, never
> assumed covered (they enter the baseline only when a TRANSITION re-pins
> boot with the k machinery — the boot tier compiles them wrong until
> then, the k1-era precedent). **M1.3 LANDED (same day) — the k2
> call-boundary check + the dual-residency split (bank Ruling 5 + A1):
> THE BUBBLE IS ALIVE — mn-k2-frame=29 (a yield composing across an
> intermediate frame) and mn-k2-pipe=26 (a `|>` chain crossing a yield,
> composition ORDER pinned: swapped composes to 16), both green on the
> FIRST run through the M1.3 m2; M1.2's pair went dormant→exercised in
> one increment ($__k_extend ×2 in the artifact = the boundary + the
> composer's self-re-compose arm).** The mechanism as built: can_yield is
> the A1 PROVE-ABSENCE gate — check UNLESS the row proves no MultiShot op
> — three tiers, cheapest first: the global short-circuit
> (ls_program_may_yield: zero MS-graded ops declared ⇒ nothing can yield,
> one stmts walk at lower_program over the LIVE EffectDeclKind +
> EffectOpScheme env edges — no side registry), the name tier (leaf row ∪
> flow-closure — the SAME union derive_ev_slots threads, so an effect
> handled inside the callee subtracts out and the gate goes quiet), the
> tail tier (closed/chased-bound rows PROVE; free tails, ¬/∩ forms, and
> untyped callees CHECK — the one-global.get price of the A1 hole). The
> spine split (k2_spine_call: binop-left · stmt-free-block ·
> PForward-left + the bare-VarRef stage, whose LSuspend carries the PIPE
> node's handle so mint and wrap agree on the key BY CONSTRUCTION; PTee
> is a boundary, never descended — the driver guards its body, and A4's
> re-install-in-k rides mn-resume-across-install at M2) finds the
> first-evaluated can-yield call; ONE remainder builder (k_remainder =
> k1_remainder + the hole-name param + the PForward arm over
> lower_pipe_complete, factored whole from the pipe) builds BOTH
> residencies — the k fn (hole __resume_in; reify_frame_k, now SHARED by
> k1 and k2) and the inline else (hole = the parked __kr_<ph>). The check
> block is PURE DATAFLOW — LBlock[LLet(__kr, S); LIf(flag,
> [LKExtend(frame_k)], [C_inline])] — the then-value is the frame's
> width-honest dummy with $yield_flag AND $yield_op untouched, flowing
> through the SAME value position the fast path uses: a `(return)` would
> skip an install's driver bracket (the design flaw caught in trace
> before a byte landed — "the check block holds BOTH" was the bank's
> exact sentence, read right the second time). LKExtend = the one new
> LowIR node (~15 lockstep walker arms across lower.mn + wasm.mn, the
> TCont precedent); frame_k mints INSIDE the then-branch — zero fast-path
> allocation. The INVARIANT walk (k2_floor_guard at all FOUR seams —
> fn/lambda/thunk/arm — plus inside reify_frame_k): every remaining
> non-tail can-yield LSuspend parks and traps LOUDLY at a raised flag
> (the comment-marked floor, censusable); every skip is a real boundary
> elsewhere — tail==true → the caller's check; install-body terminus →
> the driver's own loop (wrapping there would trap every owned yield
> before its driver); under LReturn → the fn exit IS the propagation;
> __kr_ parks → already composed; LFn bodies → each frame guards itself.
> Degradation is SOUND by construction: an unwalkable spine form yields
> the identity remainder ⇒ no wrap ⇒ the flag propagates to the caller's
> boundary — never a wrong remainder. Gates, all self-confirmed through
> the M1.3 m2: rungs 8/8 + micros 52/52; the five k gates 30/36/40 (k1
> held) + 29 + 26; march **✓✓ FIXED POINT m2 == m3** (cmp byte-identical,
> sha d866ee4d…; ZERO __kf_ parks and ZERO $__k_extend calls in the
> wheel's own module — the prove-absence gate false wheel-wide, Law 7
> exact). zsh no-split re-paid a THIRD time (`set -- $spec` — spell the
> argv, never rely on splitting). NEXT: M1.4 — LYield args (the ~18-site
> lockstep) + $yield_args + the driver args push + lift ms_op_of_call's
> argless gate; then M1.5 state-commit tail (cross-commit m2.wat diff
> gate); M1.6 the "__resume" keyed evidence (dormant); M2 crucible
> ladder; M3 THE CUT.**

> **▶▶▶▶▶ FIRST LIGHT (2026-07-10, 87c0152): m3 == m4 — THE FIXED POINT, BOTH
> HALVES SELF-CONFIRMED.** `diff m3.wat m4.wat` EMPTY by the orchestrator's own
> hands — identical sha256 (`0536240b…`) on both 410,732-line wats; provenance
> genuine (m3.wat 02:54, m4.wat 03:07 — m4 generated by RUNNING m3 on the
> wheel, its m4.err carrying 2.1MB of real compile diagnostics, never a copy).
> Correctness half on the SAME build: **8/8 rungs + 52/52 micros through the
> fixpoint m3**. The medium reproduces itself exactly, and the reproduction
> compiles and runs the whole battery — `m_n == m_{n+1}` AND correct, §6's
> definition satisfied. The final cut was the PATTERN-STRING INTERN (87c0152):
> a string literal in pattern position emitted `(i32.const 0)` (its own
> comment: "string literal pattern unsupported") while the compare around it
> was already str_eq — 80234c5 taught the dispatch, never the operand; the
> seed's half interned, the wheel's half floored. Every string-literal match
> in m3 compared against address 0 → every arm missed → wildcards swallowed →
> infer_seq_op typed every len/list_index/slice/... call TList(elem) — the
> ENTIRE 284-fn eq-dispatch flip class separating m3 from m4. Two cuts, one
> truth: walk_lemit_pat (patterns intern through the same visit_string the
> expression position fires) + emit_low_value_const's LString arm reads
> string_offset. Crucible mn-strpat-dispatch=66. **What first-light unlocks is
> §5.R — and the seed's deletion is now Morgan's call, not a build step.**

> **▶▶▶ THE SUMMIT (2026-07-10): m4 EXISTS, ASSEMBLES (1.88MB), diff(m3,m4) =
> 2,715 lines of 409,629 (99.3% fixpoint convergence) — and the BATTERY THROUGH
> m3 IS 8/8 RUNGS + 51/51 MICROS (was 0/47): the correctness half of
> first-light is GREEN for the first time in project history.** Three roots in
> one arc, each probe-pinned then one-line-or-one-fold fixed:
> **(1) emit_float_const's f: Float pin (defdc91)** — the forward-ref param
> floor; the "13-fn f64-param-drop" was 12/13 my census regex's dot-blindness
> (`local_wat_name`'s `$f.f64` mangle — every sig-parsing regex needs `[\w.]+`;
> verify the INSTRUMENT before the claim).
> **(2) variant allocation = the width-summed fold (328acb2)** — LMakeVariant
> alloc'd `4 + n*4` while its store fold writes f64 payloads as 8 aligned inline
> bytes: every f64-payload variant under-allocated, the next alloc clobbered the
> payload's high half, and EVERY FLOAT LITERAL m3 EVER LEXED collapsed to ~0.0
> (probe chain: `2.5` → `(f64.const 0.0)`; parse_float's input byte-perfect;
> int_part/dot_pos/frac/base ALL correct inside parse_float_body — the value
> died between mk_tok and push_tok's next alloc). Size is now
> `product_byte_size_acc(fields, 0, n, 4)` — one fold, four readers (store,
> size, variant_payload_offset, eq/match-bind). With it, m4 generation
> COMPLETED end-to-end for the first time (exit 0, 403k lines).
> **(3) interpolation assembles in source order (4486a44)** —
> lower_string_interpolation folded from `head = last(fragments)`, so every
> baked str_concat tree put the FINAL fragment first ("$ft_{codes}_{rc}" →
> `d$ft_iiiid_`, m4's first assembly wall). The seed's own $lower_make_string
> is source-ordered, so m2's strings were always fine and the wheel's copy was
> never order-gated (the fold crucibles — sums, lengths — are order-invisible;
> mn-interp-order=10 now gates it byte-exactly). This ONE fix collapsed the m4
> diff 204,293 → 2,715 and dissolved Face B AND Face C (rw_const_fold was
> downstream of the rotated/corrupted values, never its own face).
> **THE REMAINING ROAD TO diff-EMPTY: 284 fns, ONE class** — `str_eq` vs
> `list_eq` vs `i32.eq` dispatch flips: sites where m2's and m3's inference of
> the same wheel resolve `==`'s operand differently (the ~26k-unresolved-handle
> population making different proof-becomes-dispatch calls per generation).
> This is `Hβ.infer.order-free-live-row`'s endgame with its census in hand:
> when the two generations' inference AGREES, the fixpoint closes. Remaining
> named residue: the 5 field-offset floors (render_audit ×4), handler
> pre-registration (E_MissingVariable 139), trailing-zero trim,
> int-splice-empty. first-light = diff(m3,m4) empty AND battery green through
> m3 — the second half is DONE; the first is 2,715 lines away.**

> **THE m4 FACE WAS ONE FN — emit_float_const's forward-ref param floor (the
> "13-fn census" REFUTED: 12 of 13 were the census REGEX's dot-blindness).**
> `\(param \$\w+` stops at the `.` in the two-width mangle (`$f.f64`), so
> float_to_str/the scan family/the float predicates all LOOKED param-dropped
> while their m3 headers are correct (`(param $f.f64 f64)`). The dot-aware
> census (`[\w.]+`) finds EXACTLY ONE genuine divergence: m3 defines
> `$emit_float_const (param i32 i32 i32)` while its emit_const callsite uses
> `$ft_idi_i` (i32 f64 i32 → i32) — the first-fn-body ft mismatch that stops
> m4 generation. ROOT: `f`'s only unpinned grounding flows through
> float_to_str, defined in strings.mn — AFTER wasm.mn in the sorted wheel —
> so the forward-ref pre-scheme's fresh param var never grounds the
> DEFINITION (floored RI32) while the CALLSITE reads the literal's proven
> Float. FIX: the `f: Float` Intent-Boundary pin (the float_render_positive
> precedent), one annotation. Instrument lesson banked: verify the
> INSTRUMENT before the claim — one raw-header grep refuted the sweep; and
> WAT names may carry dots (`local_wat_name`'s width mangle), so every
> sig-parsing regex needs `[\w.]+`.** m2-gen E_MissingVariable 139, top =
> HANDLER decl names = the pre_register HandlerDeclStmt gap. SEQUENCE: the
> emit_float_const pin's march (does m4 gen pass the first fn body → next
> face) → Face B (emitted-text fragment glue, "i32call_7") → Face C
> (rw_const_fold on +rt) → the 5 field-offset floors (render_audit ×4) →
> handler pre-registration → trailing-zero trim. first-light = diff(m3,m4)
> empty AND battery green through m3.**

> **▶▶▶ THE m3 CONCAT FLOORS = MULTI-PAYLOAD EFFECT FRAGMENTATION; the fix is PROVEN
> (E_UnresolvedType 332→4) but the accumulation SEAM corrupts the heap — reverted to
> HEAD, banked for a clean re-seam (2026-07-08, HEAD bcf67fd).** The march re-derived
> m3: it GENERATES + assembles + `wasm-tools validate`s clean (515k lines, the
> inf_exit_fn wall GONE) — but battery-through-m3 is **0/45**: m3 traps at runtime in
> flatten's `acc ++ xs`. **THE TOOL (built + banked, Morgan's ask): `tools/emit-diff.py`**
> (the divergence pinner, PLAN §8) + the floor CENSUS (`grep -B3 '(unreachable)' m3.wat
> | grep ';;' | sort | uniq -c`): the m3 trap is NOT one site — **24 concat floors
> (`;; ++ on unresolved`) + 5 field-offset floors, ONE root**. (A bare `(else
> (unreachable))` is a BENIGN exhaustive-match else — SYNTAX §exhaustiveness — filter
> to comment-marked floors, never raw unreachables.) **THE ROOT (probe-confirmed —
> fold's inferred type is `(xs, f:(t5148,t5147)->t10879, init:t10980) -> t10983`: the
> accumulator `b` is FOUR SEPARATE VARS, never threaded):** `result()->r` made
> `Iterate` a TWO-payload instance `(element, r)`, but multi-payload instances
> FRAGMENT — (a) `iterate`'s `with Iterate` (prelude.mn:36/45) builds a BARE `ENamed`,
> not `Iterate(fresh)`; (b) yield's `Iterate(el,r)` and result's `Iterate(el',r')` are
> SEPARATE performs; (c) `name_set_union` (effects.mn:700) dedups by STRUCTURAL `==`,
> so different-payload same-named effects never merge (the `Iterate(<type>,<type>) +
> Iterate` DUPLICATE in fold's row). So `r` (= the accumulator, via `resume(acc)`) never
> threads → `acc ++ xs`'s operand stays unresolved → `emit_concat_unresolved` → the
> floor. **THE FIX, PROVEN CORRECT (grounds E_UnresolvedType 332→4):** (A)
> **parameterize declared effects** — `with Iterate` → `Iterate(fresh vars)`, arity read
> live (`parameterize_declared_name` at `build_declared_row`); CLEAN alone, 45/45. (B)
> **reconcile same-named parameterized effects' type args** (unify el~el', r~r'
> position-wise) so the fragments merge. **THE BLOCKER: (B) at `inf_add_row` (the
> HOTTEST inference path) CORRUPTS the heap — universal `flat_fill` bad-list-tag trap —
> EVEN functor-free.** Likely the per-add mint/unify VOLUME wrapping the never-freeing
> bump allocator (PLAN §7 face-7 precedent: heap_ptr crossed 2^32), OR a seed miscompile
> of the nested-match helpers. (A) + the install-side "unify ALL body instances" (C)
> alone are CLEAN but do NOT ground (still 332) — the grounding NEEDS the accumulation-
> level (B). **NEXT (the precise re-seam):** run (B) at a NON-HOT seam — once-per-row at
> `inf_exit_fn`/row-publish, or allocation-bounded (skip idempotent unifies via a
> chase-compare) — and COREDUMP-AUTOPSY the `flat_fill` corruption first (`wasmtime -D
> coredump` on a trapping micro; bump-order = birth-time, PLAN §8) to pin wrap-vs-
> miscompile before re-implementing. The reconcile LOGIC is correct — pure index loops
> `row_names_flat`/`reconcile_names`/`find_eparam_args`/`unify_eargs`; re-derive at the
> right seam. Crucibles: `.build/probe/{flat,sum,f-initconcrete,linkflat}.mn` + the
> census. (The earlier "§4① is the root" and "fold's config-fn state-grounding" framings
> below are SYMPTOMS of this deeper multi-payload fragmentation root — superseded.)

> **▶▶▶ result()->r LANDED — infer_seq_op DISSOLVED, the multi-payload effect-
> instance flow fixed, m2 45/45 micros + 8/8 rungs (2026-07-08, 7adada9). The
> order-free-live inference arc's Increment 2.** `Iterate.result()` returned a
> fabricated `()`, which FORCED `infer_seq_op` — a name-keyed table re-deriving each
> functor's real return BY NAME (the §2 side-ledger at the functor layer).
> `result() -> r` (the handler-delivered value, prelude.mn) dissolves it:
> map/fold/filter/each/take/… DERIVE their types from their bodies; `is_seq_op`
> keeps only the 9 substrate primitives (len/list_index/…, the §4① repr-projection
> boundary). Carried-Truth: the type is read from the one place it lives.
>
> **The cascade result()->r forced (the real depth).** `result() -> r` makes
> `Iterate` a TWO-payload instance `(element, r)`. The effect-instance flow
> (`unify_op_payload`/`unify_install_payload` → the deleted `unify_payload_in_names`)
> unified EVERY payload arg to ONE var — fine for a single-payload effect, but it
> cross-wired `element ~ r`, so `map`'s type became `a ~ [b] ~ [f(a)] ~ …`, an
> INFINITE type. FIX (the design's own promise, register_effect_ops: "the install
> unifies the whole instance per-position"): carry the effect instance as the
> nominal type `TName(E, [a1..an])` and unify POSITION-WISE via `unify_types` (it
> walks TName args); the handler exposes `Handler<E(v1..vn)>` with the arity read
> LIVE from the effect (`effect_instance_arity`), each var quantified so every
> install freshens the whole instance. Single-payload effects byte-identical (zero
> regression) — that is why the 8 rungs held while the +rt battery went 0→45.
>
> **The occurs-check completion (why it HUNG before the fix).** The cycle escaped
> because `occurs_in` skipped the `TFun` row + `TCont` world that `free_in_ty` and
> `subst_ty` BOTH traverse — so `unify` built the cyclic type and `subst_ty` spun
> forever (the three "vars of a type" traversals must AGREE). Completed `occurs_in`
> (`occurs_in_row` over parameterized payloads, delegating the record-residual Ty
> case — `graph_bind_row` is dual-use, EffRow AND a TRecord residual — to
> `occurs_in`) and `free_in_ty`'s TCont world. `graph_bind_row` gains the union-find
> law at the ROW sort: a row is a SET, so `v = names ∪ v` is idempotent (never an
> infinite row) — leave the tail free, never bind the cycle. PRODUCTIVE-UNDER-ERROR
> restored: the hang WAS that law failing (a diagnostic path looping instead of
> recovering); now broken input → diagnostic, never a hang.
>
> **THE MARCH RE-DERIVED m3 — the inf_exit_fn wall is GONE; m3 GENERATES + ASSEMBLES
> + `wasm-tools validate`s clean (515073 lines). The trap MARCHED to a new, deeper
> frontier: `++` never grounds its operands (2026-07-08).** With result()->r the
> pass-2 march ran end-to-end: seed → m2 (45/45, 8/8) → m3 (exit 0, clean generation,
> assembles, validates). The PRE-result()->r m3-frontier below (inf_exit_fn
> handler-state flood, ev-seam, float_of_int) is CLEARED/archaeology — the changed
> inference dissolved it. **BUT the battery THROUGH m3 is 0/45**: m3 assembles+
> validates yet TRAPS at runtime compiling anything — `unreachable` in
> `lower_program → compute_escaping_rows → collect_fn_bases → flatten → fold →
> op_fold_handler_yield → lambda` (flatten's `acc ++ xs`). The classic self-hosting
> gap: m2 works, m2's EMIT of the wheel (m3) diverges.
>
> **THE ROOT (fast-loop reproduced, `.build/probe/flat.mn` =
> `fn myflat(xss) = fold([], (acc, xs) => acc ++ xs, xss)`): `++` does not ground
> its operands.** `myflat`'s `acc ++ xs` emits `(unreachable)` ("no element type
> proven"); `mysum` (`fold(0, (acc,x) => acc + x, …)`) emits `(i32.add)` — SAME
> fold, so it is `++`-SPECIFIC. `++`'s inference (infer.mn:1979) is
> `graph_bind(handle, TVar(lh))` — binds result = left operand and NOTHING else: it
> never proves the operands are sequences nor unifies their element types, contra
> SYNTAX §"Concatenation" ("typecheck that the operands' element types unify").
> `+` grounds its accumulator; `++` drops it. Surfaced now because dissolving
> infer_seq_op removed the `seq_force` (the name-keyed side-ledger, infer.mn:951)
> that used to ground fold's accumulator from OUTSIDE — the general inference must
> carry that truth itself, and at `++` it doesn't. NOT an emit bug: defaulting the
> emit floor to list_concat is the forbidden side-car (Morgan 2026-07-08: no
> subversion disguised as a fallback).
>
> **§4① REFUTED as the root (the binary spoke) — the real gap is fold's ACCUMULATOR
> never reaching the lambda's `acc` param.** Probe ladder through m2: `a ++ [1,2]`
> (bare left, known right) → **list_concat** (grounds!); `[] ++ [1,2]` → list_concat;
> `[9] ++ [1,2]` → list_concat. So `++` DOES propagate from a known operand — it is
> NOT the §4① sequence-proof that flatten needs. BUT `fold([9], (acc,xs) => acc ++
> xs, xss)` (concrete init) AND `fold([], …)` BOTH floor the lambda → the fold
> ACCUMULATOR (init) never grounds the lambda's `acc`, regardless of init. THE TELL:
> `map` works (hof-map 8/8) — its config-`f` is applied to the PAYLOAD element
> (`f(elem)`, grounds via the position-wise payload flow); `fold` applies `f` to the
> HANDLER-STATE accumulator (`f(acc, elem)`, `acc = init` state), and THAT grounding
> is the gap. A config-fn applied to a handler-STATE value does not ground its param
> to the state's type, while one applied to a PAYLOAD value does. Exposed by
> dissolving infer_seq_op's `seq_force` (which used to ground fold's accumulator from
> outside); the general inference must now carry it, and the state→f-param link is
> missing. Likely kin to `config-fn/HOF field-access` (memory: unify_types
> chase-first). NOT §4①, NOT an emit floor-default (the forbidden side-car).
>
> **NEXT: ground the config-fn's param from the handler-state value it is applied
> to.** `f(acc, elem)` in fold_handler must unify f's first param with `acc`'s state
> type (= init), the way `f(elem)` grounds via the payload. Root-fix the state→f-param
> link (Carried-Truth: acc's type is init's; read it live), NOT the `++` emit. Then
> `acc` is TList → `++` reads it → list_concat, no floor. (SYNTAX §"Concatenation"
> completeness — `++` proving sequence-ness for a genuinely-bare BOTH-operand concat —
> stays a separate, rarer item; the §4① String=[Byte] unification is the eventual
> value-ontology endpoint, 80 TString sites, sequenced whole, NOT this trap's fix.)
> first-light = diff(m3,m4) empty AND battery through m3 green. Crucibles:
> `.build/probe/flat.mn` (fold acc ++ xs → unreachable) · `sum.mn` (arith fold →
> i32.add, grounded control) · `f-initconcrete.mn` (concrete-init fold STILL floors —
> proves it is the state→param link, not the element type). Named efficiency
> follow-up: `effect_instance_arity` caches on EffectDeclKind; `Hβ.infer.order-free-
> live-row` the deeper endpoint.

> **THE SINGLETON DISPATCH TIER — the m3 `ev_perform_entry` trap's ROOT, closed
> at the dispatch layer (2026-07-07).** The trap (m3 traps at `ev_perform_entry`
> during `parse_import`: `fresh_handle` performs `graph_fresh_ty`, evidence never
> reaches the perform ~10 frames down) was NOT a threading bug to patch — it was a
> MISSING TIER. The wheel's `lower_perform_dispatch` had only TWO tiers: lexical
> (`LPerform` vs `__hstate_<h>`) → evidence (`LEvPerform`, the deep chain that
> drops). It LACKED the seed's THIRD, MIDDLE tier (§5.3, "viability-CONFIRMED BOTH
> layers" but never built in the wheel): the **static-singleton** — a route-infra
> handler (graph/env/…) installed ONCE at the compile boundary is read LIVE from
> its `$<hname>_state_g` home, direct-call `$op_<hname>_<op>`, never a threaded
> copy (Carried-Truth: read the once-installed record; the seed's `lower_direct_
> from_evidence`). graph_fresh_ty fell to evidence → the parse chain dropped it →
> trap. The seed reads the global. **MEASURED after building it: ev_perform_entry
> 6401→4209 (2200 ops singleton-dispatch), `graph_handler_state_g` reads 0→290,
> rungs 7/1→**8/0** (the hof-map map-with-effects rung CLEARED), micros 45/45.**
>
> **The build (all m2-green):** (1) `EffectOpScheme(String)` → `EffectOpScheme(
> String, String, Bool)` = (effect_name, default_handler, ambiguous) — "the op
> binding IS the dispatch fact" (types.mn:318). (2) `register_one_op` constructs
> it default="", not-ambiguous. (3) `register_handler` DRAWS the op→handler edge
> via `draw_op_edges(arms, hname)` — a top-level RECURSION in the fn BODY, AFTER
> `inf_exit_fn`, NOT inside the arm `each`-lambda: an `env_extend` performed inside
> an Iterate-yield arm body does NOT reach the outer `env_handler` (the
> arm-internal-perform gap, prelude.mn — proven: inline/set_op_edge-in-lambda both
> left ev_perform_entry at ~6401; body-level draw_op_edges dropped it to 4209).
> `handler_arm_op_name` (annotated param) reads op_name from any context.
> `field_name_eq` for the `""` compares (a bare `==` is pointer-eq under the seed,
> §9). (4) `lower_perform_dispatch` gains the middle tier: lexical → `lower_op_
> default_handler` (reads the edge; None if ambiguous or unset) → `lower_singleton_
> perform` (`LBlock([LLet(rec, LGlobal("<hname>_state_g")), LPerform("<hname>_<op>",
> args, rec)])`, all existing LowIR) → evidence.
>
> **THE m3-ASSEMBLY ROOT — REACHABILITY == EMISSION, closed (dcac3b8, 2026-07-07;
> march confirming).** The prior framing — "proven-singleton is the cut, the four
> undefined globals are the dead cursor_default subsystem" — was REFUTED by the
> artifact (the exact lesson of reading the last-20 commits: ground, don't absorb).
> The census: m3 assembly failed on FOUR undefined fn-value globals —
> `cursor_argmax_compute`, `filter_at_position`, `filter_by_module`,
> `filter_by_locality` — and only ONE (`cursor_argmax_compute`) belongs to the
> uninstalled `cursor_default`. The other THREE belong to **`project_queue_merger`,
> a handler INSTALLED twice** (oracle.mn:438, pipeline.mn:315) — LIVE code, so the
> proven-singleton cut would have left them undefined. The real root was a
> Carried-Truth split in the wheel's own reachability: `reachable_from_main`'s
> container-keep filter emits the WHOLE handler container the moment ANY arm is
> reached (install makes every arm dispatchable), but `reach_grow` walked only the
> INDIVIDUALLY-reached arms' bodies. Both handlers emit ALL their arms; only the
> arm actually performed (query_project_queue; cursor_at) had its refs walked, so
> the container-kept siblings' fn-value edges dangled. The seed proved the
> contrast: m2 had 10 `project_queue_merger_state_g` refs to m3's 5 — the seed
> walks the whole container the wheel left partial. **FIX (wheel-only, LESS
> derivation): `reach_decl_refs` returns the found arm's refs PLUS the container's
> full nested-name set (`reach_nested_names(d, [])`), so the frontier walks every
> arm the filter will emit — emission == reachability, one truth.** rungs 8/0,
> micros-through-m2 45/0, m2 +5 lines (the newly-walked arms). CONFIRMED: the
> march regenerated m3 and the four undefined globals are GONE.
>
> **THE TRAP MARCHED to 3 wat2wasm errors (m3.wat, 284730 lines); ONE closed, TWO
> remain.** (1) `op_abort_exit_fail` — `(call $proc_exit)` with no following
> `(unreachable)`, leaving `(result i32)` unsatisfied. CLOSED (e1899f9): proc_exit
> is noreturn, the LWasiCall emit now appends `(unreachable)` (the seed's form).
> (2+3) `score_one_position` (cursor.mn:252) — `float_of_int(gates) * proximity`
> emits `(f64.convert_i32_s)…(i32.mul)`: the LEFT operand is f64 but the multiply
> is i32.mul and `proximity` loads as i32. **THE OPEN CURSOR — the f64 floor.**
> `proximity = caret_proximity_weight(…) = scope_distance_decay(…)`, which returns
> Float (weight fns 1.0/0.85/… at cursor.mn:305+), but both are FORWARD-refs from
> score_one_position (283/294 > 252), so proximity floors to Int and the multiply
> node's repr is RI32 → `i32.mul` against an f64 left operand. **THE RETURN-PIN
> DOES NOT WORK (refuted at the artifact): `pre_register_fn_sig` (infer.mn:189)
> ALWAYS builds the return as a fresh `TVar(ret_handle)`, IGNORING the declared
> `-> RetTy`** (it is inferred from the body, checked later) — so `-> Float` is
> inert at forward-ref time. **THE SURFACE IS CORRECT (SYNTAX.md re-read, §4①):
> Int and Float are DISTINCT types; there is NO mixed `Float * Int` arithmetic** —
> `float_of_int` IS the explicit convert, so `float_of_int(gates) * proximity` is
> `Float * Float` and the "promote/repr-join over mixed operands" idea is DRIFT.
> **ROOT — the SEED TEST refutes scc-ordered-walk; the fix is the EMIT structural
> width-predictor the seed HAS and the wheel LACKS.** The minimal repro `fn
> caller(x) = float_of_int(x) * weight()` / `fn weight() = 0.85` compiled through
> BOTH layers: **the SEED emits `(call_indirect (param i32)(result f64))(f64.mul)`
> — CORRECT, assembles**; m2 (the wheel's emit) emits `i32.mul` on `[f64,i32]` —
> WRONG. So source-order is NOT the problem (the seed handles the forward-ref in
> source order) — `Hβ.infer.scc-ordered-walk` is REFUTED as the fix. The seed's
> inference ALSO floors the width (its own comment: a graph handle's inference type
> "often DISAGREES with the decl"); it compensates at EMIT with **`emit_expr_is_f64`
> (bootstrap/src/emit/lookup.wat:218)** — a STRUCTURAL width predictor that reads
> RELIABLE LEAVES and never trusts the floored inference: `LConvert(IntToFloat)`→f64
> by construction, a float literal→f64, `LBinOp(arith)`→f64 iff EITHER operand is
> f64, `LCall`→the callee's result width from a **fn-result-repr registry**
> (`Hβ.seed.fn-result-repr-registry`, populated by a pre-pass). "The prediction
> reads what emission ACTUALLY produces, so decl and every use agree by
> construction." **THE WHEEL LACKS ALL OF THIS:** `tail_expr_repr` (wasm.mn:1896) is
> a PARTIAL predictor — it handles LReturn/LBlock/LIf/LMatch but falls to the
> floored `repr_of(lookup_ty(h))` for LConvert/LConst/LBinOp/LCall; `emit_binop_for`
> (wasm.mn:3251) reads `repr_of(lookup_ty(left_h))` (floored) not the structural
> repr; `vec_push` (wasm.mn:1119) reads the floored `result_h` for the call ft; and
> there is NO fn-result-repr registry. **THE FIX (fresh context — mirror the seed's
> emit design, substantial + Law-7 risky):** (1) complete `tail_expr_repr` — LConvert
> IntToFloat→RF64, LConst(LVFloat)→RF64, LBinOp arith→`repr_join`(l,r), LCall→the
> registry; (2) add the fn-result-repr registry (pre-pass over fn decls recording
> each fn's STRUCTURAL result repr = `tail_expr_repr(body tail)`; the registry has
> its OWN forward-ref so compute in dependency order OR iterate to fixpoint OR
> fall-to-floor-then-second-pass, as the seed does); (3) rewire `emit_binop_for` and
> `vec_push` (and check `llet_repr`, param widths) to read the structural predictor.
> proximity needs BOTH the LConvert-left (→ f64.mul) AND its own local declared f64
> (llet_repr reads `tail_expr_repr(LCall)`→registry) or its store truncates. **DO
> NOT reorder cursor.mn** (hedges wheel vs seed, §9.6) and **DO NOT scc-ordered-walk**
> (the seed proves source-order works). Micros: `.build/probe/f64repro-*.mn` (seed
> f64.mul, m2 i32.mul). m3 assembly stands on THIS one root — 2 errors, both
> `score_one_position`. Peers: `Hβ.m2.callsite-result-width`, `Hβ.emit.structural-
> width-predictor`.
>
> **EXECUTION ANCHORS (scoped to mechanical — mirror `string_table` EXACTLY, a
> proven compile-time registry read deep via a boundary handler; the ev-seam does
> NOT break it):** (a) `effect FnResultRegistry { lookup_fn_result(String) -> Repr,
> set_fn_result_registry(List) -> () }` in types.mn beside `StringTable` (types.mn:934;
> `Repr` is types.mn:65, in scope; effect FORWARD-ref works — string_table's handler
> in wasm.mn precedes its effect in types.mn). (b) `handler fn_result_registry with
> entries = [] { lookup_fn_result(name) => resume(fn_result_lookup(entries, name, 0,
> len(entries))), set_fn_result_registry(es) => resume() with entries = es }` +
> `fn fn_result_lookup(entries, target: String, i, n)` (mirror `string_offset_lookup`
> wasm.mn:196 — the `target: String` pin makes `name == target` str_eq, floor RI32
> when absent). (c) `~> fn_result_registry` at pipeline.mn:68/104/145 (beside
> `~> string_table`). (d) `tail_expr_repr` (wasm.mn:1896) new arms BEFORE `other`:
> `LConvert(_h, IntToFloat, _) => RF64`, `LConvert(_h, FloatToInt, _) => RI32`,
> `LBinOp(_h, op, l, r) => match binop_kind(op) { BKArith => repr_join(tail_expr_repr(l),
> tail_expr_repr(r)), _ => RI32 }` (binop_kind types.mn:478), `LCall(_h, LGlobal(_,
> name), _) => lookup_fn_result(name)` + same for `LTailCall`. (e) `seed_fn_result_
> registry(lowered)` = collect TOP-LEVEL `(name, body)` from `LDeclareFn(LFn(name,…,
> body,…))` (top-level only — the seed floors arm callees, `Hβ.seed.arm-result-
> registry`), seed all `(name, RI32)`, then a FIXPOINT as a fn-BODY RECURSION (NOT a
> map-lambda — the arm-internal-perform gap): `recompute` each fn's
> `body_result_repr(body)` (performs lookup_fn_result, reads the current registry),
> `set_fn_result_registry(next)`, repeat until the repr-list is unchanged (MONOTONE —
> repr_join only raises RI32→RF64, so it converges). (f) call `seed_fn_result_registry`
> at the TOP of `emit_module` BEFORE `emit_type_section` (vec_push runs there). (g)
> rewire `emit_binop_for`: pass `l, r` (not just `left_h`); arith arm →
> `emit_binop_repr(op, repr_join(tail_expr_repr(l), tail_expr_repr(r)))` (keep left_h
> for the BConcat/BEq/cmp arms). (h) rewire `vec_push` (wasm.mn:1119) / the LCall ft
> to read `lookup_fn_result(callee_name)` for a direct `LGlobal` callee, else the
> floored `result_h`. Gate: micro `.build/probe/f64repro-forwardref-fails.mn` through
> m2 → f64.mul + assembles; then verify.sh + march-gate --micros; then march.
>
> **REFUTED — proven-singleton dispatch gated on install (the prior "Approach B").**
> The artifact killed it: `fail` (Abort) is performed in LIVE code — `unwrap`
> (prelude.mn:335) calls `fail`, and unwrap is pervasive. So `abort_exit`
> (io.mn:83) is a LEGITIMATE uninstalled DEFAULT handler (the last-resort
> print+exit), NEVER `~>`-installed yet correctly singleton-dispatched. Gating
> singleton dispatch on `~>`-install would drop abort_exit → break unwrap
> program-wide. The proven-singleton property is NOT "installed via `~>`"; abort_exit
> and cursor_default are both uninstalled stateless handlers, and the distinction
> (one live, one felt-dead) is reachability of the PERFORM site, not the install.
> So dead-cursor emission is a reachability question, not a dispatch-gating one —
> and it is NOT a blocker (m3's cursor code is emitted but the f64 floor there is a
> real repr bug worth fixing regardless). The `noconfig_handler_names` union stays.
>
> **THE USER-CHOSEN DEEP FRONTIER (the arm-internal / each-with-effects gap).**
> Once the singleton tier lands, `draw_op_edges` should become `arms |> each(draw)`
> (verb-idiomatic) — blocked TODAY by the arm-internal-perform gap: lower's lexical
> handler stack (`lower_handler_stack_ctx`) is NOT scoped to closure boundaries, so
> a perform inside a lambda (`[..] |> each((x) => inc())`) resolves Tier-1 lexical
> to the enclosing install's OUT-OF-SCOPE `__hstate` (undefined-local at assembly —
> reproduced: the each-micro fails, the direct-nested-handler micro returns 3). This
> IS the hof-map frontier (the singleton tier CLEARED the rung, but the general
> user-lambda-with-effects case remains). FIX (user's pick): reset the handler
> stack at `LMakeClosure` so a lambda-internal perform uses the CAPTURED evidence
> (`derive_ev_slots` already captures it) — transparent effect-forwarding with
> state, the SOTA capability. Micros banked in scratch: ai.mn (each), ai2.mn
> (direct-nested, =3).


> **THE TRAP IS MARCHING — three faces closed, each let m3 run FURTHER into
> its own self-compile (2026-07-07, 80234c5→986ae46).** The trajectory is the
> proof of progress: m3 went from dispatching the wheel-input to CLI-help
> (empty m4) → running the lexer and trapping there → running the PARSER and
> trapping there. Each fix a wheel-emit divergence from the seed (m2 works,
> m3 = m2-emitted-wheel traps), each reproduced + fixed in the FAST m2 LOOP
> (no discovery-march), each confirmed by the next march marching the trap
> deeper.
> **(1) STRING-LITERAL PATTERNS → str_eq, not pointer-eq (80234c5).** A
> `match s { "lit" => }` is `s == "lit"`, so it must be the structural
> sequence-eq — but LPLit(LVString) emitted `(i32.eq)` on the two string
> POINTERS in BOTH layers. The token's interned "len" and the pattern
> literal's "len" share an address only when interned together, so every
> string pattern was a layout lottery: m2 lucked `infer_seq_op`'s
> `match cname { "len" }` right, m3 did not → m3 mistyped `len(argv)` as
> List → emitted `list_compare` for `len(argv) < 2` → the CLI dispatched
> every stdin compile (incl. the wheel → m4) to help. Closes
> `Hβ.lower.lpat-typed-equality`. Fixed at wheel emit (LVString → str_eq),
> seed lower (LPLit stores the whole LowValue record so the kind survives),
> seed emit (dispatch the LV tag; intern the const via emit_string_intern —
> the static-data path, NOT the broken emit_string_lit `$str_alloc` stub;
> scalars byte-identical). The refutation ladder was the method working:
> is_seq_op-dispatch and the e-graph were each PROBED and refuted before the
> pattern layer; the decisive fact was `IC cname=[len] seq=Y` firing 35× while
> `SEQOP-LEN` fired 0× — the `==` pin worked, the `match` did not.
> **(2) SELF-RECURSIVE CLOSURE self-capture (986ae46).** `parse_int`'s nested
> `go` captures itself; the wheel filled its self-capture (offset 8) with
> `(local.get $go)` BEFORE the LLet set `$go` — a null fn_ptr, so `go`'s
> recursive `call_indirect (type $ft3)` on 0 trapped "indirect call type
> mismatch" the first time m3 ran the lexer (parse_int lexes number literals).
> The seed binds every let-bound closure's local right after alloc; the wheel
> filled captures first. LMakeClosure now binds `$fn_name` to the record
> before `emit_capture_stores` when `captures_self` (a capture is an LLocal on
> fn_name → `$fn_name` is the declared let-binding, always safe). Reproduced
> in the fast loop: `parse_int("42")` trapped exit 134, now = 42.
>
> **NEXT — THE `ev_perform_entry` OOB (the deep evidence-seam, PLAN §7's
> central open blocker).** m3 now parses, and traps: `_start → … →
> parse_import → nstmt → mint_node → fresh_handle → ev_perform_entry`, an
> OUT-OF-BOUNDS memory access. `fresh_handle` performs `graph_fresh_ty` (a
> Graph effect handled at the compile boundary, ~10 frames up); the OOB means
> the evidence didn't reach the perform — a mid-chain evidence-drop the
> shallow micros (45/45) don't exercise. NOT reproduced by simple constructs:
> a 4-frame deep-chain perform (exit 5) and a stacked-handler deep perform of
> the outer effect (exit 10) both PASS — the trigger is subtler (the wheel's
> specific graph_fresh_ty-during-parse shape, many effects threaded, the
> outermost install). This is an EVIDENCE-LAYER question → binary-patch-probe
> `ev_perform_entry` in the built m3.wasm (the ⟲ method; wheel-eprints are
> Heisenberg here), print the key/base/scan-bounds at the OOB to pin WHICH
> effect's evidence is missing and WHERE in the chain it dropped. m2's
> fresh_handle (seed-emitted) works, so it is again the WHEEL's emit of the
> perform's evidence dispatch that diverges. First-light = diff(m3,m4) empty
> AND battery green through m3; m4 is still empty (m3 traps before emitting).

> **THE f64 CENSUS DECOMPOSED INTO SEVEN ROOTS (2026-07-07, e7b4623→e44afd9)
> — the "~44 type mismatches" were never one class; probing them end to end
> surfaced two catastrophic pre-existing invisibles the i32 word-width had
> masked.** Each root, its fix, and its proof:
> **(1) DEAD LET-POLYMORPHISM — the seed's capture-shadowing inversion.** A
> lambda's free name that was BOTH a top-level global and an enclosing
> param/let resolved to the GLOBAL: `$ls_lookup_or_capture` ran its global
> fence before the outer-frame scan; `$lower_cap_materialize` likewise
> (bootstrap/src/lower). find_mapping's predicate read its captured `id` as
> the prelude fn's closure record → instantiate NEVER freshened a free
> quantified var → every generic fn's callers collided on shared vars (the
> m3 build's 2370 E_TypeMismatch; zip_with's body emitted `$ft_iii_d`
> against list_index). Nine corpus sites censused (id/rest/count/
> handler_name across infer/lexer/parser/types/emit/main/voice). Pinned by
> a 5-line micro (two callers, Int+Float) + probe eprints (qs=2 at both
> generalize and instantiate, `out==in` from subst) + the m2.wat binary
> (`global.get $id` where the capture init belonged). Fixed at BOTH seed
> deciders: lexical scan first, fence for un-shadowed names only.
> **(2) THE FABRICATION SENTINELS.** Healing (1) regressed effarg-node:
> lookup_ty's NFree/NErrorHole arms resumed `TName("UNRESOLVED")`/
> `TName("ERROR_HOLE")` — fabricated nominals for provably-unresolved
> nodes; the eq dispatch minted `$eq_nUNRESOLVED` and read Int 44100 as a
> variant pointer. Both arms resume `TVar(h)` — carry the handle; every
> consumer already floors a free var honestly (repr RI32, fold_sig "i",
> word eq).
> **(3) THE FLOAT RENDER OFF-BY-START.** `float_fill_digit_bytes` read
> `digit_at(digits, i - start)` — i already walks [start, end), so every
> fraction after a nonzero int part re-copied the integer digits: 1.5
> rendered "1.15", 2.0 "2.2" — EVERY f64 constant m2 emitted into m3 was
> textually corrupt, and float-gate passed by luck (2.25*2.2 >= 4.49).
> One word: `digit_at(digits, i)`. m2 now emits `1.5` as `1.5`.
> **(4) THE ft PRODUCT'S THREE TRAVERSAL ORDERS.** arg_reprs consed
> last-first, repr_codes rendered last-first, emit_repr_ft_type walked list
> order: `$ft_iiidi_i` NAMED an (i,d,i,i,i) definition while callers pushed
> (i,i,i,i,d). One canonical order (state, args source-order, result), four
> readers; all_ri32 dissolved into `all(repr_is_i32, ...)`.
> **(5) BINDER WIDTHS + THE HANDLE CARRIERS.** walk_locals_pat hardcoded
> `" i32"` while the bind emit loaded ctor payloads f64-wide (the 20-site
> local.set class) — the decl walk now reads the SAME channels
> (ctor_payload_tys_of, the tuple's carried elem_ty). lower's VarRef arm
> falls back to the USE node's handle when the binding-time handle is 0
> (ground types) — dissolving Hβ.lower.bind-handle-typed-subpattern (zero
> writes; infer already bound the use node). mint_params graph_binds an
> authored CONCRETE annotation onto the param HANDLE (it lived only in the
> signature; `a: String` params compared by pointer, `scaled: Float`
> declared i32 — the annotation was inert on every body read).
> **(6) THE WASI WIDTHS AS DATA.** wasi_import_reprs: the preview1 ABI as
> Repr vectors, ONE home with two projections — the import-decl string and
> per-arg call-site widths (path_open's rights + fd_readdir's cookie extend
> i32→i64; the wait_i32 precedent generalized). The eq word-leaf gained the
> TFloat arm (f64.eq/ne — the cmp twin had it; float_is_zero emitted
> i32.eq on f64s).
> **(7) SOURCE Int/Float LIES.** json's scan parts mixed Int digits into
> Float math; lsp built JNum(Float) from Int line/col/id/severity/kind —
> explicit float_of_int at each edge (the seed's floor had hidden them; the
> wheel's honest f64.store refused). Plus the QUEUED str_contains band:
> each candidate window is an O(1) [Byte] view compared by structural `==`
> via `range |> any` (params pinned `: String` — the Intent Boundary the eq
> dispatch reads); str_matches_at + str_contains_scan DELETED.
>
> **NAMED PEERS from this dig (each artifact-pinned):**
> `Hβ.seed.effectful-lambda-ev-capture` (the seed drops a lambda-captured
> effect's evidence — a `map((a) => ... lookup_ty ...)` form floored every
> read; px/h2 repro) · `Hβ.emit.view-splice-following-chunk` (the
> interpolation chunk AFTER a view-string splice is dropped through m2 —
> "slice=[1.5" lost its "]") · `Hβ.emit.f64-aggregate-pattern-width`
> (record/list sub-binders stay word slots, both walk + bind) ·
> `Hβ.emit.generic-boundary-repr-coercion` (a proven-f64 value/closure
> crossing a word-generic edge boxes/wraps — the vec_add lambda-into-
> zip_with case; latent, zero battery paths) · `Hβ.infer.authored-typaram-
> rigid` (w5 probe: `xs: [a]` refuses to unify — "Int vs a"; the case-rule
> lowercase param must be a fresh quantifiable var) · `Hβ.parser.fn-type-
> param-ann` (w6 probe: SYNTAX's documented `f: a -> b` param form does not
> parse — E_MissingVariable x/a/b; the lathe lags the spec).
>
> **THE MARCH'S VERDICT (five iterations, 2026-07-07 00:30→01:45) — m3
> ASSEMBLES AND RUNS for the first time in the project's history; the m4
> gate stands on ONE pinned face.** The census trajectory, each iteration
> a whole-class measurement then one root fix: 44 type errors → 1
> structural paren (the generated $show_listbody helper emitted four
> closers for five opens — the whole-file paren census measured exactly
> −1; df43d69) → 1 duplicate local (lower_expr_body binds `v` at f64 AND
> i32 in sibling arms — the register NAME is now a projection of (source
> name, proven repr): local_wat_name, one decider for width AND name,
> params included since a param's WAT name is fn-internal) → 1 starved
> param (float_render_positive's f: every float contact was a FORWARD
> call, so the body inferred against pre-scheme free vars and f floored —
> pinned : Float per the Intent-Boundary precedent; the inference-order
> completion is the named band `Hβ.infer.scc-ordered-walk`) → **wat2wasm
> exit 0, 283,787 lines, zero errors** → m3 RAN over the wheel (exit 0)
> but emitted NOTHING: the CLI dispatched to help because _start passed
> literal 0 as argv and `len(0)` read address 0's scratch (0 in m2's
> layout, ≥2 in m3's — undefined-by-luck); _start now passes a fresh
> alloc'd word (virgin-zero = a len-0 flat list; real WASI argv is
> `Hβ.emit.wasi-argv-in-start`).
>
> **THE STANDING FACE (the m4 blocker, banked with its repro + method):**
> even with a true empty argv, m3's `parse_cli_args` lands in
> ParseError/help — its `len(argv) < 2` is emitted as `(call
> $list_compare)`: the len-CALL node is BOUND TO A LIST in the graph
> (binary-probe: type tag 4 at node 6436) while the len-VarRef child sits
> at epoch 0 — NEVER INFERRED. 6-line repro: `let xs = [1,2,3]; if
> len(xs) < 2 {3} else {7}` through m2 emits list_compare(len-result, 2)
> — a garbage compare that lucks RIGHT in the micro (exit 7) and lucked
> WRONG in m3's dispatch (help). LAYOUT-SENSITIVE: adding one
> wheel-eprint flips the emission (the handle numbering shifts the
> lottery) — so probe it ONLY with binary patches on the built m2.wat
> (the ⟲ method; the working patch shape is banked in the handoff). The
> epoch-0 VarRef says the INFER WALK never reached these nodes — find
> which walk skips them (the if-condition path? the e-graph's canonical
> read feeding lower a node infer never visited?), fix the walk, and the
> `List(tN) vs Int` flood class (×245 — the runtime's word-idiom
> signatures meeting healed inference) likely shrinks with it. THEN:
> `GATE_WASM=$PWD/.build/march/m3.wasm bash tools/march-gate.sh
> --no-build --micros` (the battery through the wheel's CHILD) → the m4
> diff. First-light = diff(m3,m4) empty AND battery green through m3.

> **THE UNDEFINED-REFERENCE LADDER CLOSED (4e3faa7, 2026-07-06) — the paren
> band gave the first WHOLE m3.wat, then ONE census closed the whole undefined
> class at root.** After the eq/compare sum-fold helpers stopped emitting
> `)))))` (one paren over — the stray paren closed the module early and orphaned
> the entire emit tail, the phantom-undefined wall), m3.wat parsed whole and
> wat2wasm's undefined-ref census came back COMPLETE at four refs / two classes,
> each fixed at its STRUCTURE, not its symptom:
> **($Float)** the parser accepts a variant payload only after `(`, so
> `TapeVecAdd { … }` orphaned the record-type brace → the outer parser misread
> it as a value literal → the field TYPE `[Float]` lowered as a VALUE whose
> element is the bare type-name `Float` → `global.get $Float`. autodiff's
> variants now use the canonical parenthesized payload `TapeVecAdd({ … })`,
> matching their own construction sites. (The prior-session `List`→`[Float]`
> edit was a BAND-AID — it only renamed the leaked global from `$List` to
> `$Float`; the root was the missing parens. Caught and reversed — the exact
> no-band-aid discipline, self-applied.)
> **(wasi_num_cores)** it has a wasi_threads handler arm → it is an effect-op
> PERFORM, not a raw import; removed from `is_wasi_import_op`, it routes through
> `lower_perform_dispatch` (the handler), matching the seed's op-index dispatch.
> **(atomic_load_i32 / wait_i32)** direct-substrate atomic instructions with NO
> handler arm, emitted as dangling calls → they project to `i32.atomic.load` /
> `memory.atomic.wait32` (the latter extending the i32 timeout to the
> instruction's i64), the threading peer of the existing memory-op instruction
> projections. `is_wasi_import_op` had conflated THREE substrates (host imports,
> effect-ops-with-handlers, atomic instructions), all emitting `call $op`; each
> emits its true form now. `atomic_rmw` is unreached (0 sites; its RmwOp arg
> needs static dispatch) — named peer `Hβ.emit.atomic-rmw-op-dispatch`.
>
> **NEXT — the f64/i64 REPRESENTATION GRADIENT (§5.U STEP 1).** m3.wat now has
> ZERO undefined refs but ~44 TYPE mismatches on wat2wasm, all in compiler-core
> float/FFI emit (`emit_const`, `emit_low_value_const`, `lower_lit_value`,
> `path_open` FFI): 18 `local.set $f expected [i32] got [f64]`, 8 `f64.store got
> [i32,i32]`, plus f64/i32 call-arg mismatches and `path_open`'s two i64 params
> passed as i32. The seed FLOORS floats to i32 (`Hβ.seed.float-gradient`) so m2
> assembles; the wheel's REAL f64/i64 emit is internally INCONSISTENT — the
> local DECLARATION (`walk_locals`, backends/wasm.mn) and the VALUE emit disagree
> on width. THE ROOT (Carried-Truth): `repr_of` (types.mn) must be the SINGLE
> width-decider read live at BOTH the local decl AND the value emit, so they
> cannot disagree; and the i64 FFI args (`path_open`) extend like `wait_i32`'s
> timeout now does. Then reassemble m3 → `GATE_WASM=$PWD/.build/march/m3.wasm
> bash tools/march-gate.sh --no-build --micros` (correctness half) →
> `bash tools/march.sh --fixpoint` (m4, diff). First-light = diff(m3,m4) empty
> AND battery green through m3. **QUEUED BAND:** str_contains
> (lib/runtime/strings.mn) → `str_eq(needle, str_slice(haystack, i, i+nlen))`
> over the O(1) [Byte] view + `range |> any`, DELETING str_matches_at +
> str_contains_scan (Carried-Truth: reuse the one structural `==`; row honestly
> widens to +Alloc until band-I fusion tightens it — the ultimate form, seed
> catches up).

> **THE ASSEMBLY LADDER (faces 15-22, 2026-07-06) — every one the wheel's
> own emit refusing a disparateness the seed tolerated; each fix collapses
> two mechanisms into one (Morgan's "elegantly whole, not disparate", paid
> down in code).** Pass-2 completing gave the first whole m3.wat (#19);
> wat2wasm then walked it, refusing one lie at a time, each named by its
> line so each cost minutes not the hours the trap-faces did:
> **(15)** triple fd_write imports — the wasi-ops dedup was pointer-eq (String
> pin). **(16)** span_of_handle defined twice — three name collisions across
> files (§9 dup-fn class the seed silently one-of'd); one deleted, two
> renamed to their honest truths (caret_span_of_handle, flow_label_join).
> **(17)** ft_name: $call_2503 declared 3× — the locals preamble carried TWO
> disciplines (named set-deduped, handle-suffixed streamed-inline "unique by
> construction"); the e-graph shares pure nodes so one node declared its
> register 3×. Now ONE set (walk_locals purely accumulative);
> Hβ.emit.shared-node-cse the deeper peer (emit a shared pure node once).
> **(18)** $__fanout_input at diverge_0 — the `<|` diverge thunk captured its
> input wrong (bare LLocal, not upval) AND none of the branch's frees; two
> thunk-synthesis disciplines for one thing. Now `<|` captures exactly like
> `><` (collect_free_vars + resolve_captures_outer + frame; input a synthetic
> slot-0 upval). The `<|` path had ZERO micro coverage — mn-diverge-share=105,
> mn-diverge-lambda=125 close it. **(19)** $_ redefined at lambda_19470 — two
> wildcard params both emitted `$_`; `_` is the ABSENCE of a name, so it gets
> a positional `$_<i>` (never referenced; String-proof on the check).
> mn-wildcard-params=42. **(20)** $lower_handle_of undefined — lexpr_handle's
> LEvEntry arm called a phantom (stale rename); recurses to lexpr_handle(ev).
> **(21+22)** a CENSUS of called-but-undefined names (census-not-moles, before
> waiting a pass-2 per face) preempted the whole phantom class: str_contains
> (IFC flow-label, defined now as a [Byte] substring scan; mn-str-contains=15)
> and doc_emit_for_module (the `doc` verb's phantom render — removed, the
> md/html render named as Hβ.f1.doc-handler-substrate). float_of_int dismissed
> (lowers to LConvert, never a global ref). **NEXT: pass-2 #26 → m3 assembles
> clean → `GATE_WASM=$PWD/.build/march/m3.wasm bash tools/march-gate.sh
> --no-build --micros` (the 45-micro battery through the wheel's CHILD, the
> correctness half) → `march.sh --fixpoint` (m4, the diff). First-light =
> diff(m3,m4) empty AND battery green through m3.**

> **FACES 8–15, the emit corridor (2026-07-06).** After face 7's indexed
> fixpoint, the sub-hour run cadence let eight more faces close in one
> sitting: (8) collect_resume_walk lacked MakeStringExpr + nested-Stmt
> arms (0b1883a; census: the ONE walker with the hole). (9+10)
> free_vars_pat_binds and bind_pat_locals lacked PAlt (3c745b5, 2cc3896 —
> the flat census was fooled by an INNER match's wildcard; the census is
> now brace-depth-aware and reports zero missing Pat arms). (11) the
> flat-buffer env made snapshots slice views and four consumers still
> drop_last-walked them — slice-of-slice stacking killed the stack inside
> `last` (07d9457; all index-walks now). (12) face 10's own identity arm
> read list_index(sub, 0) unguarded on bare nominal patterns (b269c59;
> zero-guards both identity arms; Hβ.seed.bare-nominal-pattern named).
> (13) collector drains returned slice VIEWS while both layers' list-
> pattern emission assumes the flat contract — [b0, ..._] on any map
> result misread the slice's buf field as the element (3cf04cb; drains
> return list_to_flat; Hβ.emit.list-pattern-shape-honest named as the
> ultimate reader; verify's RTLIBS now link prelude like march-gate).
> (14) THE TRIPLE-KILLER: `..._` compiled as an EXACT-LENGTH pattern in
> BOTH layers — each independently mapped the "_" rest to None to answer
> binding, destroying the PRESENCE fact the predicate reads; runs
> #16/#17/#18 died byte-identically at walk_locals_pat's inner floor on
> the wheel's first 2+-branch alternation (fba6995; presence survives
> both layers, the four _-skips route through field_name_eq — they were
> pointer-eq dead code under m2). (15) the wasi-ops dedup
> (slot_already_recorded) was proof-less == — pointer-eq dead through
> m2, triple fd_write imports in m3 (d56a417; the String pin).
> METHOD NOTES banked: the probe pattern (victim-name eprint at
> emit_one_fn entry + class ladders at floors) pins an emit face in ONE
> ~40min run; micro-scale extraction (palt-arms) turns it into seconds;
> a ladder MUST cover tag-0 explicitly (the "str_eq" misread cost one
> cycle). RATCHETS: mn-resume-splice=8, mn-nominal-ctor=42,
> mn-listpat-stage=42, mn-rest-wild=44, mn-palt-arms=42 (41 micros).
> NEXT: m3 assembly (face-15 fix in flight on #20) → GATE_WASM=m3.wasm
> march-gate --no-build --micros (the battery through the wheel's CHILD)
> → march.sh --fixpoint (m4, the diff).

> **FACE 7 (ef842ff) — pass-2 reached LOWER for the first time, and the
> escaping fixpoint wrapped the heap.** Runs #8/#9 completed INFER over the
> whole wheel (the first in history), then died in lower at assoc_row with
> an indirect-call type mismatch. The first coredump autopsy (wasmtime
> `-D coredump`, 4.0GB image; march.sh gen() now always arms it) read the
> corpse directly: heap_ptr = 0x2250 — the bump pointer had crossed 2^32
> and was minting records OVER the init-built fn-record region; assoc_row's
> own record held [1839][4][8752] where [fn_idx][0] belonged. The fuel:
> assoc_row/esc_assoc scanned a 2,500-entry assoc list via drop_last,
> minting a 16-byte slice per step — ~2GB PER ROUND of escaping_round on
> top of infer's ~2GB. TWO CUTS: (1) the Carried-Truth index form — callee
> names resolve to base POSITIONS once at collect; rounds are rows-only
> list_index reads (zero allocation, zero name scans); the name-keyed view
> is zipped once at the end; assoc_row DELETED. (2) the allocator RATCHET —
> the emitted $alloc traps LOUDLY on wrap (br_if-0 return on the sane path,
> fallthrough unreachable), both layers byte-identical (seed template
> relocated 1275→8080), so every future ceiling is a clean trap AT $alloc,
> never a corrupted dispatch three fns later. Also measured en route:
> wasm-opt -O2 is a 4% guest-time REGRESSION (§8 toolkit block) — the cost
> is algorithmic, exactly this class of fix, never module-level polish.

> **FACES 5+6 (4ababd7, 7fe2f64) — the seed's leniency was hiding authored
> source bugs.** (5) threading.mn's Thread effect carried uppercase `A` in
> type position — pre-case-rule archaeology; by the case rule that is an
> UNDECLARED NOMINAL, not a parameter (`a` IS the declaration; censused: no
> other single-uppercase type refs remain). (6) TWO types named `Handle` in
> the one concatenated namespace: types.mn's refined alias (`Int where
> 0 <= self`, the graph handle — the kernel's noun) and threading.mn's ADT
> (the thread token). src registers before lib, so the alias shadowed the
> ctor in-order; `Handle(len(results))` instantiated
> TRefined(TAlias(…)) instead of an arrow, and occurs_in — exhaustive over
> Ty but MISSING the TAlias arm — floored walking it (the sixth run died at
> the same 35399 span as the fifth). The token renames ThreadHandle (the
> kernel's claim on the noun wins — the de-keywording's own reasoning);
> occurs_in gains the transparent-alias recursion (unify_types / subst_ty /
> free_in_ty / repr_of censused, already total). NAMED PEER:
> `E_DuplicateTypeName` (band L) — same-name type decls shadow SILENTLY
> today; the decl site deserves the refusal, per the import-collision
> precedent. Pass-2 runs died, in order, at: line 6014 (union_row loop) →
> 6700 (refinement tuple) → 35414 (handle keyword) → 35399 (nominal-ctor
> binders) → 35399 (Handle collision) — each run STRICTLY deeper or a
> deeper root at the same line. #8 runs with all six closed.

> **THE NOMINAL-RECORD CTOR IS THE IDENTITY (4cdd820) — three limbs, one
> face, a 2×2 micro matrix as the pin.** After the de-keyworded run died at
> 99% in occurs_in under sequential_compose's arms, the s/r/pa/pb
> missing-binder census led to `type Pri = Pri({…})` — the wheel's OWN
> idiom (OraclePriority, TransportState). (1) infer's PCon arm DISCARDED
> the entry's kind: RecordSchemeKind binds the bare TName (construction
> view, no arrow), so instantiate returned non-TFun and sub-pat binding
> silently skipped — every `let Pri(pa) = a` lost pa; the arm now rebuilds
> the single-field arrow AROUND the scheme (one instantiate, both halves).
> (2) unify_record_fields_loop's proof-less `==` on field names emitted
> POINTER-eq — decl-interned "tier" ≠ literal-interned "tier", so
> byte-identical records refused to unify and 136 unresolved types cascaded
> into `field offset unprovable` unreachables; `field_name_eq(a: String,
> b: String)` is the ONE pinned compare home (effects.mn, beside the field
> family; unify / check_nominal_record_fields / field_byte_offset /
> find_record_field_pos route through it; dissolves with band D). (3)
> lower had NO RecordSchemeKind arm at either value site: call-form
> construction `Pri({…})` fell to LGlobal (undefined `$Pri`), the pattern
> fell to tag −1 (never-match). Both are now the IDENTITY — the runtime
> value IS the bare record (NamedRecordExpr's own LMakeRecord law):
> construction lowers to its argument, the pattern to its sub-pattern.
> mn-nominal-ctor=42 is the 37th micro. The matrix that pinned it:
> ctor==type × Int/record payload — Int cells always passed; the record
> column carried all three limbs.

> **`handle` IS NOT A KEYWORD (55e60de) — the medium's own noun collided
> with its own lexer.** THandle existed solely so the legacy
> `handle { body } with h` spelling could be format-lifted to `~>` — but
> `handle` is the codebase's most common identifier (the graph's node
> pointer), and the wheel's lexer keyworded it: every `let handle = …`
> binder parsed to PWild through m2 (the parser's contextual-recovery arms
> covered params/fields/operands but NOT binders — the half-patched
> bespoke-recognizer disease), losing 106 bindings across the wheel compile
> and detonating as occurs_in's exhaustive floor at 99% of pass-2. The seed
> never keyworded it — pass-1 was blind to the face. Pinned by
> branch-marker binary-patch probes on m2's lower_stmt_body (215 lets; 214
> → PVar; exactly ONE → wildcard, as immediate 1 = PWild's sentinel).
> Retired per the turbofish precedent: no bespoke keyword for a foreign
> spelling — the lexer line, THandle, ERedundantHandleBlock (7 arms),
> parse_handle, and every recovery arm DELETED; SYNTAX.md now 18 keywords /
> checksum 63 with the ruling at §«Installation». mn-let-handle=37 is the
> 36th micro (fn-let + arm-let + param, all named `handle`). En route the
> refinement walk's record-literal face closed too (6b1e6b7:
> walk_refinement_fields read `.value` on the (name, value) TUPLES
> MakeRecordExpr carries — one-site census, destructured). Pass-2 now
> marches to 99% of the wheel input (~65min, peak <1GB — the alloc-profile
> face never gated at 4GB; Hβ.m2.compile-alloc-profile stays a wall-time
> band, not a correctness band). Residue faces from the 99% run's
> diagnostics, to re-measure on the post-dekeyword run: E_MissingVariable
> `r`/`s`/`l` (×21/×11/×5 — likely collateral of the handle corruption;
> `let r` micros pass in isolation both tiers), the `e308`-as-identifier
> lex face in the float-render prelude, occurs-check spam (t_N occurs in
> t_N), and forward `~> handler` refs (×2 — pre_register_decls has no
> HandlerDeclStmt arm; needs the infer_fn-style two-phase register split).

> **THE UNION_ROW DIVERGENCE CLOSED (2026-07-05) — pass-2's three
> memory-ceiling deaths were ONE infinite loop.** union_row's `_ =>` arms
> normalize-and-retried on the assumption normalization yields
> Pure/Closed/Open — but ¬X IS a normal form, so `Closed ∪ Neg` re-entered
> itself forever, allocating per cycle (sort_unique copies + fresh EfNeg
> mints) in the never-freeing bump image: 512MB OOB, 2GB OOB, and at 4GB the
> bump pointer WRAPPED past 2^32, minting sub-4096 "records" →
> normalize_row's exhaustive-match floor (`unreachable`). Detonated at the
> wheel's FIRST mixed declared row (cursor_ic_fixpoint,
> `with Cursor + IC + !Mutate`, input line ~6014 of 35687 — solo-neg rows
> never touch the path via the `EfPure => b` arm, which is why 34 micros and
> 8 rungs never saw it; mn-negation-declared=42 is the 35th micro, the
> ratchet). THREE CUTS, one band: (1) **union_row TOTAL over the six row
> forms** — `Closed[a] ∪ ¬X = ¬(X∖a)` (neg_minus_names), `¬X ∪ ¬Y = ¬(X∩Y)`,
> union DISTRIBUTES over Inter (`c ∪ (P∩Q) = (c∪P) ∩ (c∪Q)`), Sub reduces
> once by De Morgan; the surrender arms deleted. (2) **build_declared_row is
> a SIGNED SET** — positives compose by the authored connective, negations
> pool into ONE forbidden set; mixed = `Closed[P] ∩ ¬Closed[N] = Closed[P∖N]`
> via normalize_inter, so the positives SURVIVE for evidence threading (a raw
> ∪ would collapse `Cursor + IC + !Mutate` to ¬Mutate and starve callers of
> Cursor/IC evidence); authored Pure dominates INSIDE the build (infer_fn's
> pre-collapse ternary deleted — less code). (3) **infer_fn publishes the
> MEET for neg-bearing declared rows** (body ∩ ¬N = the body row, gate-
> proven) — publishing raw ¬N would union near-universe into every caller's
> accumulation. Board after: verify 34/34 through the seed, rungs 8/8,
> micros-through-m2 **35/35**; the mixed-row oracle compiles in 6s through m2
> and runs exit 42.
>
> **SEED GAP NAMED — `Hβ.seed.recursive-scheme-without-selfpartial`.** The
> seed mis-schemes union_row's total-matrix body when it contains ZERO
> `union_row(??, _)` self-partials: a 16-variant bisect lattice over the four
> wildcard arms proved death ⇔ all three inner `_ => … |> union_row(??, a)`
> arms removed (any ONE saves it; the outer is irrelevant), detonating as a
> unify `unreachable` in graph_handler's arms-walk — the first
> ??-partial-heavy consumer downstream. An isolated micro of the same shape
> PASSES, so the trigger needs file-scale context: pinned to the shape, not
> reduced. MOOT for the corridor: the ultimate form was the PIPE form all
> along (`|>` is never optional) — the total matrix written natively
> (`a |> union_row(??, neg_row(q)) |> normalize_inter(??, union_row(a, p))`,
> operand order preserving the flow-edge first-var law) carries slot-1
> self-partials in every distribution arm and the seed digests it. The
> C-style nested-call draft was the drift; the medium's own idiom is what the
> seed compiles.

> **PHASE 1 CLOSED (plans/noble-brewing-rose.md) — 0/34 → 34/34 in one day,
> sixteen bands.** After the 28/34 entry below, the closing arc: the match
> cascade tested arms from the WRONG END (8606e47 — any wildcard-last match
> collapsed to the wildcard's body; is_pure ≡ false); the pattern sub-walkers
> paired last(subs) with a climbing index (713dddd — every multi-sub pattern
> bound REVERSED; compare-fold's 23 reproduced arithmetically from the
> fst/snd swap); the pipe's bare-stage completion never ran the evidence
> fork (de94902 — ev4 vs ev2, one line apart); identifiers wearing the
> ownership-marker keyword derailed the seed's param parser (65e6b27 —
> infer_fanout emitted with ZERO params; renamed fan_own/own_effs, zero
> own-as-ident sites remain); branch thunks minted with the parent fanout's
> handle declared duplicate scratch locals (65e6b27 — a thunk's identity is
> its branch); and float_extract_digits pushed significant digits onto the
> recursion's result — push appends, so every digit list read REVERSED and
> 2.5 rendered "0.000…" (dc62df4 — accumulate-forward; floor_log10's f<1
> branch also negated its recursion, fixed). PASS-2 fired the same night on
> the completed wheel. Residue named peers: `Hβ.emit.int-splice-empty`
> ("{n}" for Int renders empty through m2; String splices fine) ·
> `Hβ.seed.ftNf-result-width` (the seed's indirect-call fts are arity-keyed
> all-i32 while 140 signatures carry (result f64); f64-result calls ride
> inline fts today — the pass-2 gate arbitrates whether the class needs the
> full repr-vector mint).

> **THE 8/8 DAY (2026-07-04, nine bands).** The exit-134 floor that gated the
> whole runtime battery fell in one continuous dig: the raw-0 root (b73748c —
> union_row's `na ++ nb` emitted as str_concat via h=0 binders; the "corrupt
> element" was virgin zero memory inside a 2-byte string wearing a list's
> clothes; census 23→17, h=0 RATCHETED at 0) · the wrong-end frame stacks
> flipped (ea7bdd3) · declared-rides-the-frame, both ambient ops dissolved
> (23b1af4) · the call fork reads derive_ev_slots and derive reads THE GRAPH
> at the call site, the esc-map side-ledger query deleted (b46aa7c — first
> two micros ever green through m2) · _start calls main DIRECT with zeroed
> declared params (60d880d — 2→28 in one build) · the evidence-chain
> completion (91eb654): the call edge carries the CALLEE's whole row
> expression (names AND tail — the var-only chase dropped inline names
> whenever open-open unification left the call's fresh var free: the
> RECURSIVE-CALLEE class, t-rec's oracle); row_without_self (μR. names∪R =
> names — no row ever contains its own handle); LSuspend's transient in a
> per-site `sst_{h}` local (the shared $state_tmp was clobbered by argument
> emission — the dispatch called the ARGUMENT's fn index); string_offset_
> lookup's target pinned `: String` (pointer-eq zeroed every COPIED evidence
> key — the intern-table gate). **SIX RESIDUE FACES on the micros tier:**
> ev4 (134, one evidence shape) · fanout-seq (COMPILE `!infer_expr`) ·
> compare-fold 23≠47 / effname-pure 117≠18 / cli-dispatch 15≠63 (the
> wrong-value silent-miscompile class, now RUNNABLE) · float-gate 0≠3
> (`Hβ.m2.callsite-result-width`). Plus one new named face:
> `Hβ.emit.int-splice-empty` — `"{n}"` for an Int renders EMPTY through m2
> (String splices work; two-line repro). Pass-2 (march.sh) fired the same
> evening. The full arc: plans/noble-brewing-rose.md.

> **GROUND IN REALITY FIRST — the commands and their purposes.** `bash
> tools/verify.sh` is the FLOOR (seed builds + the micro battery — 34 `micro:`
> lines in `verify-baseline.txt`, run through the SEED); `bash tools/march-gate.sh`
> is the LIVE m2 rung scoreboard (compile→assemble→run→exit per rung — the march
> iterates against IT), now **7 pass / 1 fail** (hof-map(+rt) the one open rung,
> RUN exit=134 = the seam); `bash tools/march-gate.sh --micros` adds the
> micros-through-m2 tier (every baseline micro compiled by the WHEEL's own emit —
> a SCOREBOARD, first reading **0/34**: 32 at the exit-134 ev-scan floor, proving
> the ONE seam gates the whole runtime-linked battery); `bash tools/state.sh`
> adds census + the m3==m4 fixpoint check (§8). Run verify + march-gate before any
> theory or edit. Census is a SHADOW (the seed lagging the wheel), never enforced.
> Prose drifts; artifacts do not. On a runtime bug the first move is a PROBE.

- **THE m2 MARCH (2026-07-01→02, 38c6835→e791bf3) — pass-2's road has
  pavement; `bash tools/march-gate.sh` IS the live rung scoreboard.** The
  pipe law realized: `|>` is HOLE-COMPLETION in BOTH layers (SYNTAX
  §«Partial application» — the prepend convention DELETED; it passed the
  piped value as arg 1, so every piped partial into an (f, xs) fn
  dispatched a LIST as a CLOSURE, fn_idx = load(count) — the whole m2 trap
  zoo: 10MB heap dumps to stdout, "no main defined", wrong-type/OOB
  call_indirects). `??` now parses/types/lowers in wheel AND seed (NHole =
  typed absence; infer: k<n or `??` = the product-with-holes,
  `TFun(unfilled, ret, row)`); 42 subject-first sites carry the explicit
  `??` first slot; `parallel_map` DISSOLVED into `map` 2026-07-02 (the
  schedule is read at the fanout's own install site, never across a call —
  a helper's `><` was permanently Seq under a "parallel" name; genuine
  multi-core is `>< ~> Thread` at the use site, open peer
  `Hβ.lower.schedule-specialized-callee`, band E). MEASURED FIRSTS: m2 compiles
  AND RUNS one-main / call / branch rungs with CORRECT exits (`id(7)` → 7
  through seed → m2 → program). Roots closed en route, each pinned in the
  binary before a byte changed: the phantom-capture FENCE (handler decl
  names ARE top-level globals — both collectors; each `~>` name had become
  a capture, inflating the ev-region base 8+4×installs vs records built at
  ncap=0); the POINTER-EQ lie (generic `==` with no String proof silently
  emitted i32.eq — interned "main" ≠ heap "main"; pinned at
  ls_find_str_local/assoc_row/esc_assoc/split_group — dissolves with band
  D); str-concat-on-lists (bare-TVar `++`; names_concat pin at
  flow_join/PTee/escaping_round); the $ftN fork DELETED into the one
  repr-vector walk (§5.U realized — max_arity was a shallow second reader
  that missed every call inside a fn body; net −40 lines); exit-code canon
  (main's result IS the exit code — the wheel dropped it); the
  NOMINAL-RECORD read (`type X = {…}` = the single-variant ctor
  `X : TRecord → TName`, so the ctor scheme ALREADY carries the shape —
  the seed's TName arm now reads kind-132's body; RecordSchemeKind had
  four readers, zero writers); the SCOPED SINGLETON (`$<hname>_state_g`
  save/restore around every named install, both layers — a nested
  same-handler session no longer leaves the outer session's Tier-1 reads
  on the inner exhausted record). SCOREBOARD 2026-07-02: 5 pass / 3 fail —
  two-lets CLOSED (declaration/init path); match-adt CLOSED (two stacked
  wheel roots: fn-body emit_alloc leaked module-scope WAT past the per-fn
  buffer — emit_memory_bump now installs inner to wat_to_string — and the
  ctor payload read's pointer-eq lie, d5c13b6). THE SEED-F64 BAND IS
  COMPLETE (five ratcheted cycles, 2026-07-02→03: f11daa8 the stack-life
  substrate, error ladder 159→70→10→0; 26e4e28 heap boxing — f64 crosses
  into aggregates as 8-byte cells behind word pointers, unbox at typed
  loads; f62b468 pattern binders carry payload repr — LPVar(handle,
  name, repr) stamped from the ConstructorScheme channel, `.f64` mangle
  for the measured two-width collision, typed-ev-dispatch realized;
  3edf51b + 02929b2 wheel truths the first real f64 execution exposed:
  the Float pins on the render predicates, and float_extract_digits
  NEVER WORKED — it minted the correct next value into `remainder` and
  DISCARDED it, recursing unbounded; fixed by carrying the bounded
  scaled). float-gate=3 is the 34th (last) micro; every remaining untypable
  f64 boundary is a LOUD censused floor (closure captures,
  Hβ.emit.f64-closure-capture-box). NO float fault remains anywhere on
  the rung path. **THE STDOUT-GARBAGE BLOCKER IS CLOSED (837948c,
  2026-07-03 — a seed PARSER root, not the seam):** the +rt rungs'
  "garbage before (module" was mint_row's arm swallowed by
  $skip_to_arm_terminator's depth-0 blind walk (comma-less newline-
  separated arms lost every arm after the first; the one-arm record's
  slot-1 word 0 = table idx 0 = wat_emit, so inference printed 289
  Instantiation reason records to stdout). The walk is DELETED —
  parse_resume_expr already lifts `resume(v) with …` into AST and
  lower reads the updates (walk_call.wat:1777), so parse_expr's return
  IS the arm boundary, both layers stopping at the same token. Dig +
  3-refuter adversarial verify (1/3 refuted: the proposed replacement
  with-absorb loop was proven unreachable dead code re-deriving
  parse_resume_state_updates — deleted before commit, the ⟲ loop
  working as designed). **THE ULTIMATE-SYSTEM ARC (2026-07-03, f786f93 + 6cc5721 + da65f62 —
  BOARD 6/2 at the time, now 7/1: handler(+rt)=5 has since GREENED
  (167d7f0/92cefe3), hof-map(+rt) the sole open +rt rung;
  pipe-hole(+rt)=15 the FIRST green runtime rung; handler /
  hof-map now parse, infer, lower, emit, assemble, and RUN, trapping at
  runtime exit 134 — the deepest the +rt frontier has ever stood).**
  Eleven roots closed in one continuous dig, each pinned in the
  artifact first: the locals-row SET (dup `$grown`/`$decoded` decls);
  the seed's symmetric `==` (a match binder's LLocal is minted h=0 —
  the handle-less-left early exit forced pointer-eq past the
  adopt-right read; 23 i32.eq-against-intern sites censused, one law);
  the march-gate link set (prelude was always the true scope —
  hof-map calls `map`); the brace-header grammar ruling (SYNTAX
  §Nominal records: `with found = None {` — the { closes the header;
  ExprSlot mode through the parser spine, seed already agreed); the
  field-proof projections (typed projections at each record's mint —
  state fields, stack entries, resolve results, ledger entries, arm
  records; match arms and record fields are TUPLES, destructured);
  the Reason head-renderer trued (nine phantom arms deleted, nine real
  variants added); Option to prelude (one home); the statement-drop
  law (every expression yields the kernel-uniform word; a statement
  drops it); the if/match width JOIN (`repr_join` — the i32 floor
  yields to either branch's proof; baked `(result i32)` deleted); and
  **REACHABILITY-FROM-MAIN (da65f62)** — `lower_program |>
  reachable_from_main |> emit_module`: emission projects the
  main-rooted subgraph over LowIR's own edges + the emit layer's
  substrate contract (`emit_runtime_contract`, one home beside the
  arms that mint the calls); arm fns reach through their containers;
  libraries emit whole; both compilers now converge on the same
  emitted set. NAMED NEXT FACES: (1) the handler/hof-map RUNTIME trap
  (exit 134 — the first m2-emitted handler installs to ever execute);
  (2) `Hβ.m2.callsite-result-width` — a call site's ft result width
  under the weak seed-era infer needs the callee's declared result
  repr (the f64 show leaf's undefined-`$float_to_str` is its loud
  floor; the float rungs land with this band); (3)
  `Hβ.emit.match-arms-call-vectors` — collect_call_vectors' LMatch arm
  skips the arms' calls (latent $ft gap); (4)
  `Hβ.seed.arm-result-registry` and the walk_refinement_fields
  record-literal trap remain behind those. The method that closed eight roots in two days
  is crystallized in `CLAUDE.md ⟲` (census-not-moles; binary-patch
  probes). ALLOCATOR CONSOLIDATED (7027f60): the inline-bump category
  deleted — ~5996 per-family unaligned bump groups → 5720 `call $alloc`
  against ONE aligned (size+7)&-8 body; the wheel emits the same form,
  so m3 inherits one allocator; m2 has exactly two heap_ptr writers
  (the $alloc body + the data-string emitting m3's); −32160 wasm
  bytes; per-strategy body-swap = named peer
  `Hβ.emit.memory-strategy-body-swap`, gated on the seam close (two
  reverted experiments re-pinned the seam: a NEW perform's evidence is
  unplaced; an arm→fn boundary threads WatOut evidence across it).
- **THE CURSOR — the value layer (2026-06-23, design VERIFIED, six-step build
  LANDED — all 6 commits in, Law 7 held).** The four deep value-layer axes —
  representation gradient, multi-shot continuation reification, parallel-topology
  execution, total structural fold — are FOUR PROJECTIONS OF ONE CURSOR ON ONE
  HEAP RECORD joined at `match lookup_ty(h)` (full design + arc: §5.U). Verified
  by a 21-agent adversarial workflow; each step a Carried-Truth deletion the
  artifact had named in its own comments (the Thread-drift peer, the
  attach-to-TCont note, the `$ftN` blocker, the `emit_struct_eq` product/sum
  floor — every one since closed). **Landed:** STEP 0 `repr_of` (46e4801); STEP 1 the representation
  gradient, i32-floor + boxed-f64 peer DELETED (2cf717b); STEP 2 the structural
  fold's eq leaf, the loud product/sum floor dissolved (d138274); STEP 3 the
  multi-shot producer minting the dormant `LMakeContinuation`, the write-only
  `resume_kinds` ledger DELETED (7b72790); STEP 4 the `PDiverge|PCompose` →
  `PFanout` verb-collapse + the hardwired `inf_add_row(Thread)` DELETED, schedule
  read live (600bc88); STEP 5 the binding keystone `TCont(Ty, ResumeDiscipline,
  EffRow)` — the effect-WORLD on the continuation (`!E` lifted to TIME; the modal
  frontier §4③ landing here), all ~14 destructure sites + the seed's
  `$ty_make_tcont` + 6 classify/scheme/render seed-tests moved in lock-step
  (27edc30). The docs (SYNTAX §Type aliases `repr` pin, §`<|`/`><` the Schedule
  handler + the `PFanout` kernel-merge) LED; the build implemented against them.
  **LAW 7 held:** the existing i32 / OneShot / sequential paths are
  BYTE-IDENTICAL — ev2/4/8=57, ev5=21, ev16=18, eq=73, interp=59 green before AND
  after; the new forms (f64 / multishot / fanout) are ADDED arms. **Enforced
  gates (run through the seed):** repr-width=40, struct-eq-deep=20 (fold control
  shape), fanout-seq=30 (`><` default-sequential value gate), resume-world=42
  (world-index inert on the single-world OneShot path). **Seed-lag gates named as
  positive-form peers (the .mn leads, the seed catches up):**
  `Hβ.seed.float-gradient` (mn-float-arith → exit 3 needs the wheel's f64 emit;
  the seed still floors LFloat to i32, exit 0); `Hβ.seed.multishot-producer`
  (mn-multishot → exit 30 needs the producer in the compiler that compiles it;
  the seed lowers OneShot, exit 10). **Unsurpassable-tier follow-ups (named, not
  built):** `Hβ.lower.fanout-simd-lane-cashout` (reads STEP 1's v128),
  `fanout-gpu-backend-handler`, `fanout-durable-persist-handler` (reads STEP 3's
  persist); `Hβ.types.resume-world-mismatch-value-gate` + `Hβ.infer.tcont-world-
  capture-at-reify` (cross-world boundary needs STEP 3's persist resume-catcher);
  `Hβ.eq.fold-seed-value-gate`. The m3==m4 fixed point stays blocked on the
  pre-existing effect-row→ev-slot seam (the raw-0 name-set element,
  confirmed §7 below) — UNTOUCHED by the value layer.
- **THE CURSOR — the ultimate-form arc (2026-06-22, all landed + pushed):**
  SYNTAX.md to ultimate form; PExpr dissolved into live operand nodes; the whole
  AST in the one graph (the fabric — `mint_node` edge-links every node's body at
  birth; any handle resolves live via `graph_node_body`); the e-graph engine
  (effect-aware equality saturation, the union-find pointed at the cheaper node)
  LIVE in lower (`lower_expr` reads the canonical form via `egraph_extract`).
  Micros 5/5 green — the seam HELD (EGraph in the lowering row did not perturb
  the ev-slots); census 184 (shadow — the seed lags the e-graph code; "make it
  work" catches it up). The detail below is 2026-06-18 first-light-blocker
  archaeology, kept for the substrate mechanics it documents — NOT the cursor.
- **Census 189** (2026-06-18 reading), 7/7 micros green, seed builds, m2.wat
  assembles, pass-1 (seed compiles the wheel) OK.
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
  2026-06-20; FRESH LIVE PIN 2026-07-03).** The prior 2026-06-19 entry
  ("parse-path `node_to_pexpr → map → iterate_from`, nondeterministic OOB,
  funcref-floor corruption") was a STALE read of a MASKED trap — DISPROVEN by
  reading `m2.wat`. The live FIRST trap is a DETERMINISTIC `unreachable` in
  `op_lookup_ty_graph_lookup_ty ← param_handles_of ← lower_stmt_body` (LOWER,
  not parse). At `m2.wat:50735/50796` it is the `let GNode(kind,_) =
  graph_chase(h)` destructure's `(else (unreachable))`: it fires because
  `graph_chase(h)` returns a NON-GNode. graph_chase is an evidence
  `call_indirect` whose handler pointer is read from `__state` at an ev-slot THE
  SEAM computes. `lookup_ty` succeeds thousands of times (the 75 E_UnresolvedType
  ARE its NFree arm) — only ONE call misroutes ⇒ a per-row ev-slot DISAGREEMENT,
  not a blanket dispatch break, and NOT a seed funcref bug.
  **THE 2026-07-03 LIVE PIN — RESOLVED, and it was NOT the seam (837948c):**
  the mint_row→wat_emit misroute (Instantiation records on stdout, the +rt
  ASSEMBLE failure) decoded one layer deeper than the pin: the captured_evs
  chain `instantiate → build_inst_mapping → map-closure` was CORRECT and
  identity-keyed all the way down (binary-patch probe on ev_perform_entry:
  the FreshHandle entry's record is ALWAYS fresh_for_inference, 0 misroute
  hits) — the handler RECORD ITSELF was built one arm short. The seed
  parser's $skip_to_arm_terminator blind-walked to the next `,`/`}` and
  swallowed every comma-less following arm: fresh_for_inference lost
  `mint_row`, its slot-1 word stayed 0, table idx 0 = wat_emit. A label is
  a hypothesis until the artifact confirms it — the pin's SEAM attribution
  was the refuted label; the walk is deleted (the wheel parser was already
  correct). Child peer `Hβ.infer.instantiate-mint-ev-slot-misroute` CLOSED.
  **The seam itself REMAINS OPEN** — re-pinned twice during the allocator
  consolidation (2026-07-03): a NEW perform on an existing effect leaves
  its evidence unplaced (strict ev_perform_entry trap at emit_memory_decl),
  and factoring an arm's call site into a shared fn threads WatOut evidence
  across the fn boundary (match-adt regressed; both experiments reverted).
  The strict two-population scan (949ac34) now makes every seam hit LOUD.
  **THE SEAM CONFIRMED TO A CLEAN NUMBER (2026-07-04, non-Heisenberg
  binary-patch at show_eff_name's `«invalid-effect»` arm — the diagnostic
  render path, reads an already-built value, does NOT shift the
  accumulation layout under test):** a body-accumulated name-set element
  is a raw `0` (null pointer), NOT a record with a corrupt tag — the
  immediate 0 where an `ENamed` record belongs. show_eff_name(0) fails
  its `>=4096` heap check → `«invalid-effect»`; eff_names_of masks the
  SAME 0 (`name==0 => []`) → empty escaping row → bare call → the strict
  ev-scan floor (exit 134). BOTH the render symptom and the runtime trap
  are ONE root: a 0 in the name set. The 0 hits rows added by DIRECT
  LITERAL construction (`inf_add_row(mk_ef_closed([ENamed("Memory")]))`,
  infer.mn:977 — no evidence read), so it is a CONSTRUCTION miscompile,
  exactly subst_eff_names' own warning (infer.mn:2672: the seed can
  miscompile an ENamed reconstruction to a raw 0). Layout-dependent
  (wf_00fe3588's two perturbation tests: eprint probes flip 0↔It3;
  union_row→name_set_union flips the immediate 0↔1) ⇒ the SEED's codegen
  for the EffName construction / name-set path emits a wrong immediate
  under certain ev-slot layouts. The unbind-witness (I-BOUND→FREE) was
  REFUTED 3/3 — the var stays bound; the NAME inside is 0. GENUINE
  SEED-LAYER FORK (the workflow's own verdict, refuter-confirmed): fix
  the seed's ev-slot/codegen for the EffName-name-set functions, OR a
  coordinated seed+wheel EffName representation change (large blast
  radius). The harness (march-gate --micros, 8867e04) proves the blast
  reward: 0/34 micros, 32 at this exact floor — closing it greens the
  whole runtime battery + unblocks pass-2 (m2 compiling the full wheel
  traps here too). NEXT DIG (clean-probe method, NEVER wheel-eprint —
  Heisenberg): binary-patch the name-set construction sites in the
  baseline m2 to pin which seed-emitted variant-construction yields 0,
  then correct the seed's emission (bootstrap/src) for that shape. The
  singleton-tier route (§5.3) is REFUTED for the multi-handler-op case
  (prelude has many Iterate handlers — no static pick); the two dead
  ends (naive var-chase, snapshot-at-generalize) still stand fenced.
- **THE RAW-0 ROOT CLOSED (2026-07-04, b73748c — the probe ladder ran
  ghost→root in seven binary-patch rounds, one sitting):** the corrupt
  element was never a corrupted pointer. union_row's `na ++ nb` was
  EMITTED AS str_concat — the seed's BConcat dispatch fell to its string
  default because match-binder LLocals carry handle 0 — and str_concat
  on a flat list mints a 2-byte "string" whose fresh-zero bytes read
  back as a flat list holding element 0. One emission = every symptom:
  the «invalid-effect» renders, eff_names_of masking to empty escaping
  rows, the exit-134 floor, the layout-dependent 0↔1 flips (the "corrupt
  immediate" was the sides' byte-count, not a variant tag). FIX at the
  seed layer: `$bind_pat_locals_ctor` mints a bound proof handle per
  declared ctor payload (`$graph_fresh_ty` + `$graph_bind`);
  `$pty_canon_seq` canonicalizes the NAMED sequence spellings
  (`EfClosed(List)`, `ENamed(String)`) to structural tags; nested
  patterns inherit the payload type. CENSUS CLOSED: W_ConcatUnproven
  23→17, h=0 count 0 (union_row×4 + resolve_row×2 all proven) —
  RATCHETED in march-gate (h=0 must stay 0, fail-loud). verify 34/34;
  rungs 7/1 unchanged; micros-through-m2 STILL 0/34 — the conjunction
  law: the corruption root is closed, the EMPTY-ROW face stands alone.
  **The nesting-discipline flips LANDED (the §9 wrong-end class in the
  wheel, 4 sites: enter_fn/enter_arm pushed FRONT while last/drop_last
  read END):** semantically forced, verified no-regression (rungs hold
  7/1), measured INSUFFICIENT alone — micros stayed 0/34. Depth-1 was
  coherent either way; the flip matters for nested inference (the
  wheel's own lambdas at pass-2). Remaining limb SPECCED, not landed:
  `declared` rides the frame — `inf_enter_fn(h, span, effs)` born-with
  + `inf_exit_fn() -> List` returns the popped frame's declared;
  BOTH ambient ops (inf_set_declared / inf_declared_effs) dissolve
  (nested FnStmts currently wipe the outer's enforcement list via the
  set_declared([]) bracket — silent enforcement skip).
  **THE ACTIVE CURSOR — the 0/34 floor DECODED (2026-07-04, artifact-
  read end to end): the WHEEL'S EMIT HAS NO CALLER-SIDE EVIDENCE
  MECHANISM.** The exit-134s are the strict scan working as designed:
  `ev_perform_entry` = `entry==0 → postmortem(key@0,base@4) → load(-8)`
  — a genuine MISS every time, because m2-emitted callers call
  effectful callees BARE (iterate → return_call iterate_from passing
  the RAW $iterate_from global record; the scan walks record+8 for the
  key = the INTERNED EFFECT-NAME ADDRESS, e.g. "Iterate"@65536, and
  nobody ever wrote the pair). The SEED's working convention, decoded
  at hm-seed.wat:4305: at each effectful call boundary the caller
  CLONES the callee's record (alloc 8+12+ncap·4), copies fn_ptr/ncap/
  captured_evs, APPENDS [key=intern_addr, entry=[hstate,base] record],
  and passes the EXTENDED CLONE as __state — the sst_ family (48 sites
  in the seed's emit of the hof-map source; 0 in m2's; `sst` absent
  from src/lower.mn + src/backends/wasm.mn entirely). Rung `handler`
  passes because Tier-1 (direct perform under the install, scoped
  singleton) never needs the extension; EVERY Tier-2 micro converges
  on this one absence. NOT a patch — a missing subsystem: the wheel
  needs its evidence-passing call convention (lower derives the
  callee's needed [ename→entry] set at the call site; emit extends).
  Design-first: build it as ONE projection both consumers read (the
  original two-consumer seam dissolves by construction). The full arc:
  plans/noble-brewing-rose.md (phase 1's center).
- **PRIOR ROOT THESIS — `effects_of_row` drops the EfOpen row-var
  (lower.mn:528-621).** (The EfOpen-var chase LANDED be2502e — the read reads
  the var now; the CONFIRMED deeper root is the raw-0 name-set element, §7
  header above. This entry is the mechanism history that led there, kept
  because the two-consumer disagreement it documents is the shape the raw-0
  detonates through.) The
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
# ── the BOOT ERA (post-first-light, 2026-07-10): boot/mentl.wasm IS the compiler ──
bash tools/verify.sh           # the floor: micros + census — STAMPED green (unchanged tree answers in ms; FORCE_VERIFY=1 re-runs)
bash tools/march-gate.sh --micros   # rungs + battery through boot's wheel-emitted m2 (reads the shared .build/m2cache)
bash tools/march.sh            # THE RATCHET: boot→m2→m3, ASSERTS m2 == m3; on m2 ≠ m3 runs m4 ITSELF and rules TRANSITION (re-pin from m3) vs BROKEN
bash ide/serve.sh              # mentl edit in the browser (localhost:7378/ide/) — SERVED BY MENTL (ide/serve.mn)
#   (the seed + --from-seed are deleted, 7401c4b; the cold ladder lives at tag first-light)
bash tools/state.sh            # ground FIRST: git state → verify (stamped) → march (the ratchet); --quick = verify only
bash tools/march-gate.sh       # the LIVE m2 rung scoreboard
python3 tools/emit-diff.py m2.wat m3.wat        # the divergence pinner — run FIRST on any m3 trap (CLAUDE.md ⟲)
python3 tools/emit-diff.py m2.wat m3.wat --trap # m3-side unreachable bodies m2 lacks (filter to comment-marked floors — bare else-unreachable is benign, SYNTAX §exhaustiveness)
grep -B3 '(unreachable)' m3.wat | grep ';;' | sort | uniq -c   # the floor CENSUS in one measurement (concat / field-offset markers)
wat2wasm m2.wat -o m2.wasm --debug-names --enable-threads --enable-tail-call
# WABT (per task) — EVERY tool needs --enable-tail-call --enable-threads or it chokes on
# opcode 0x13 (return_call_indirect); with the flags ALL work on m2:  objdump -d (disasm,
# the trap-pin workhorse) · -h (section sizes — the runaway-emit diagnostic;
# read the live Code-section size, never a hard-coded number) · wasm-stats
# (opcode distribution — fat/runaway-emit diagnosis) · wasm2wat
# --fold-exprs (readable canonical WAT — NEVER the raw 12MB m2.wat) · wasm-validate · wasm-decompile (C-like)
```

**Modern toolkit (2026-07-05, measured):** `wasmtime --profile=guest` writes a
Firefox-profiler JSON with per-fn guest time (name-section names — the
alloc-profile band's measurement; incompatible with `--allow-precompiled`,
profile the plain module). `wasmtime compile` (AOT → .cwasm, run with
`--allow-precompiled`) removes the ~seconds-per-invocation JIT cost — worth it
for the 37-invocation micro battery, required for fair guest-speed timing.
`wasm-opt -O2 -all` was MEASURED A 4% REGRESSION on real guest work (82.7s vs
86.0s AOT on a 2k-line slice): the wheel's cost is ALGORITHMIC (bump-image
allocation churn, linear scans), not instruction slop — wasm-opt stays OUT of
the march loop (module-size hygiene only: −41%). `wasm-tools` (1.252+, the
maintained WABT successor) adds `shrink` (predicate-driven module reduction —
the seed-miscompile pinning tool) and `validate --features all`; WABT's
objdump/wasm2wat remain fine with the tail-call/threads flags.

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
7. **Verify the dispatch floor with a GATE; never DEFER the ultimate form for
   it.** A wrong dispatch / evidence / wire-format resolution is a real trap, so
   PROVE each new path: keep the cheap no-regression signal (the existing micros
   stay byte-identical, which catches a broken *working* path early) AND write the
   gate that exercises the NEW path (a round-trip equality, a fresh micro) where
   the seed can run it, structural otherwise. FORBIDDEN is the *other* response to
   risk — SEQUENCING or hedging an ultimate-form feature because the seed might
   miscompile it: the seed-compiled micros are a SHADOW (they prove the seed's
   behaviour, not the wheel's self-hosted correctness); the real oracle is
   first-light (§6); deferring the wheel to protect the shadow is the §3 / §10
   hedge inverted. Risky path → add the gate, write the FULL form (Anchor 0), move
   on. Caution that VERIFIES, yes; caution that DEFERS the ultimate form, no.
   (Corrected 2026-06-23 — Tier-1 sequenced two *verifiable* completions, W03 the
   fold family and W10 tuple-index, under the old wording; Morgan caught it.)
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
diagnostic's NAME can lie · **wrong-end stack ops** (push at one end, pop/read
the other — six sites in one commit, b93978f; every Mentl stack pushes at the
END) · **phantom captures** (handler-decl names are top-level globals; a
collector that counts them as captures inflates the ev-region base, e791bf3) ·
**pointer-eq on names** (`==` with no String proof emits i32.eq; byte-equal
strings interned by different passes never match — annotate the name param
`: String`, the Intent Boundary carrying the proof) · **one-operand dispatch**
(a binop's emit reading only ONE operand's type proof; read EITHER, 4fb8e68) ·
**the seed's name-keyed intrinsic table** (bootstrap/src/infer/walk_expr.wat
types prelude stages BY NAME with byte-pinned offsets — ANY prelude rename or
re-signature is a same-cut three-layer edit: wheel decl, wheel callers, seed
table; miss it and the seed silently mistypes every call) · **blind token-walk
absorbers** (a parser "skip-to-terminator" that walks tokens instead of parsing
structure eats every comma-less sibling — the mint_row arm-drop, 837948c; the
symptom surfaces LAYERS away as a dispatch misroute. Parse structurally or
delete the walk; and a dropped ARM means the record's next slot reads 0 =
table idx 0, so "prints WAT mid-inference" can mean "the parser ate my arm").

---

## §10 · How to resume — the three-document loop

1. **Read `CLAUDE.md`, `PLAN.md`, `SYNTAX.md`.** That is the entire required
   context. Reference nothing else unless debugging a specific artifact.
2. **Run `bash tools/verify.sh` + `bash tools/march-gate.sh`.** The gate is the wheel WORKING (the micros
   compile-and-run) + coherence (the drift-audit). Census is a SHADOW it reports,
   never enforces — a rising count is the seed lagging the ultimate wheel,
   expected progress. Trust the micros + the artifact over any prose here; if
   prose disagrees, fix the prose.
3. **The cursor is the ULTIMATE-FORM arc — write the `.mn` in full.** NOT a
   first-light blocker to chase. Recent leaps that ARE the cursor: the whole AST
   in the one graph (the fabric — every node a resolvable handle); the e-graph
   engine (effect-aware equality saturation) live in lower. The seed's weaker
   inference lags this and catches up ("then we make it work"); NEVER hedge the
   wheel against the seed — that fork (ultimate form vs safer-for-the-seed) IS
   the drift, paid for in a wrongful revert (2026-06-22). All three §5 aspects in
   full — real, felt, unsurpassable — never one phase chased before the others.
4. **Open with the Universal Audit, not the trap (§9.6).** Then every edit:
   project the eight arms (§2); obey Carried-Truth (§9.1); dream-code first
   (§9.3); never bolt (§9.8); interrogate, don't absorb (§9.9). Ask: *what does
   the ultimate medium do here?* Implement that.
5. **Keep the three docs in ultimate form.** Each touch consolidates toward the
   tightest *complete* prefix, one home per truth. They are the only durable
   memory — the investment that means this session never recurs.
