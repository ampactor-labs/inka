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
   brief: `docs/DESIGN_SYSTEM.md` — a draft ARTIFACT of this aspect, not
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

**B · Continuations & TIME (arm 2, §4④) — the binding keystone.** `Hβ.types.tcont-world-binding-keystone` (STEP 5 landed the 3-arg arity; the world is INERT on OneShot — ENFORCE it) · `Hβ.types.resume-world-mismatch-value-gate` (the runnable gate; layout-in-world coupling; DEP persist resume-catcher + STEP 1) · `Hβ.infer.tcont-world-capture-at-reify` (at the multi-shot producer's reify site) · `Hβ.continuations.world-widening-resume` (typed superset-resume) · `Hβ.continuations.persist-equals-memcpy-handler` (= `Hβ.lower.fanout-durable-persist-handler`; `~> Persist`, zero serializer; STEP 3 producer landed; the standardized multiple-memories proposal is this peer's substrate cash-out — a dedicated IMAGE memory snapshots whole while scratch lives apart, the memcpy boundary drawn by the module format itself) · `Hβ.persist.cross-machine-resume` *(new)* · `Hβ.persist.branch-world-tag` (persist.mn:119) · `Hβ.continuations.wasmfx-lowering-tier` · `Hβ.infer.tail-recursion-resume-cardinality` (infer.mn:3174) · `Hβ.lower.either-install-negotiation` · `Hβ.felt.time-travel-debug-forked-cursor` *(new)* · `Hβ.ml.autodiff-as-multishot` (autodiff.mn:36).

**C · IFC — flow in the row (arm 4/6, §4⑥; W31 scaffold landed).** `Hβ.verify.ifc-noninterference` (umbrella; code `Hβ.types.ifc-flow-constraint`, types.mn:1029) ← `Hβ.ifc.dcc-noninterference-gate` → `.flowlabel-inference-in-hm` → `.pc-label-implicit-flow` → `.integrity-dual-lattice` (prompt-injection IS an integrity-flow violation) → `.declassify-robust` → `.flow-world-on-tcont` → `.agentic-fides-target`. DEP-rooted on `sound-neg-under-poly`.

**D · The value layer — fold & repr (arms 1/7, §5.U; STEP 0/1/2 landed).** `Hβ.fold.show-leaf` (synthesize as a lowered LFn, not raw WAT; lower.mn:481) · `.compare-hash-leaf` · gate `Hβ.eq.fold-seed-value-gate` · `Hβ.repr.arrow-layout-interop` · `Hβ.emit.variant-payload-repr-width` (wasm.mn:4913) · `.plit-handle-repr` (wasm.mn:5537) · `Hβ.value.ontology-derivation-complete` · `Hβ.runtime.zero-copy-string-view` (lexer.mn:316).

**E · Parallelism & accelerators (arm 3, §4④; STEP 4 collapse landed).** `Hβ.lower.fanout-simd-lane-cashout` (RV128) · `.fanout-gpu-backend-handler` (lower.mn:1475) · `.fanout-durable-persist-handler` (SPACE=TIME) · `Hβ.parallel.thread-alloc-transitive-proof` (verify ONLY after the leak closes) · `.race-freedom-ownership-proof` · `Hβ.infer.fanout-ownership-from-use-count` (infer.mn:1288) · `Hβ.runtime.wasi-thread-spawn-seed` (threading.mn:296) · `Hβ.driver.level-set-par-walk` *(the topological layer-partition is LIVE in driver.mn — 7165bbb; the open half is the multi-core `>< ~> Thread` at the layer site)* · `Hβ.cursor.speculative-compile` · `Hβ.cursor.work-stealing-via-gradient` *(idle cores ask the cursor "what next?"; the gradient's argmax IS the priority queue — no scheduler module)* · `Hβ.lower.schedule-specialized-callee` *(new — the parallel_map dissolution's open remainder: whether a reusable fn's internal `><`/`<|` should EVER inherit a caller-installed `Schedule` across a call boundary. The only sound route is compile-time specialization of the callee per install-context, preserving `Seq`'s zero-cost/`!Thread`-provable property — the §5.3 dispatch gradient's sibling on the INSTALLED-HANDLER axis (vs the known-argument axis; shares callee-specialization infra). The ambient/evidence-passed-runtime `Schedule` alternative is the wrong direction — it taxes every `Seq` fanout to buy portability only a rare `Thread` caller needs. Scoped skeptically: direct `>< + ~> Thread` at the use site is sufficient and simpler; build only when a real consumer needs one fanout helper serving callers wanting different schedules. Sequenced behind `Hβ.driver.level-set-par-walk`, DEP-gated on band-A `sound-neg-under-poly`)*.

**F · Verification & proof (arm 6/8).** `Hβ.types.predicate-is-expr` (dissolve PExpr) → `Hβ.verify.smt-handler-swap` (Z3+CVC5; NAME the external-SMT residual !Outside if it persists) → `.higher-order-refinement` · `Hβ.verify.ledger-soundness` (no silent assume-true; the Dafny `{:axiom}` cautionary) · `.proof-incrementality-cached-cursor` · `.reason-edge-pcc-certificate` · `Hβ.dsp.hz-ceiling-ambient-sample-rate` · `Hβ.refine.buffer-invariant` · `Hβ.infer.predicate-from-bool-expression`.

**G · Graph & e-graph (arm 1) — highest-leverage incompleteness first.** `Hβ.egraph.per-expr-effect-row` (egraph.mn:70 — reduces is_pure to effs_at alone, generalizing the effect-gate to every rewrite) · `Hβ.lower.egraph-saturation-deepen` · `.typed-rulecyclic` (the depth-1000 cap → a typed E_RuleSetCyclic via the Why chain, unreachable-by-construction) · `.rule-as-query` · `.extraction-cost-composes-repr` · `.const-fold-minted-node-full-edges`.

**H · Ownership (arm 5, §4⑤).** `Hβ.ownership.fractional-uniqueness-ref-borrow` (Granule ICFP 2024) · `.quiet-empirical-gate` (the Hylo bar — a corpus test counting authored own/ref markers; a rising count IS inference failing §4⑤).

**I · Dataflow & DSP (arm 3/6).** `Hβ.dataflow.causality-compile-error` (a zero-delay `<~` cycle is a compile error, Faust's causality rule; no code anchor yet — the peer is named here, not in a comment) · `.clock-calculus-sample-rate` · `.point-free-fusion-via-egraph`.

**J · Self-hosting & !Outside hardening (L7, §1).** `Hβ.closure.diverse-double-compilation` (Thompson/Wheeler 2009 — a second disposable seed converging to identical m3 closes trusting-trust, which the byte-fixpoint alone cannot; DEP native backend) · `.correctness-oracle-internal` (the external micro-battery → the wheel's own Verify; until then first-light's correctness half is itself an !Outside) · `.reflexive-over-proposers` (code `Hβ.synth.proposer-gauntlet`).

**K · AI-proposer / Synth (arm 2, §0/§1).** `Hβ.proposer.constraint-not-token-worked-example` (Lahiri 2026 — answer the spec-oracle problem with a worked example, not a claim) · `.synth-handler-error-fed-back` (the lossless constraint, not the lossy token).

**L · The Why-engine & `mentl audit` (arm 8/1, §0 — the medium enforcing its own discipline).** `Hβ.audit.carried-truth-projection` *(new — the §0 keystone: project a Carried-Truth violation BEFORE a line is written, making the wrong move unsayable)* · `Hβ.diag.minimal-inconsistent-core` (= `.why.minimal-cause-set`) · `Hβ.infer.marked-lambda-totality-invariant` (POPL 2024) · `Hβ.diag.catalog-as-projection` (report takes a DiagKind ADT) · `Hβ.diag.duplicate-type-name` *(new — two `type X` decls in one namespace shadow silently today (the Handle collision, 2026-07-05); the decl site deserves the refusal, per the E_ImportNameCollision precedent)* · `Hβ.diag.declared-row-contradiction` *(new — `with IO + !IO` today surfaces only downstream when the body performs the dropped effect (the subsumption gate, loud); the ultimate teaching surface is a decl-site diagnostic at the signed-set build, MachineApplicable. Named 2026-07-05 so the gate doesn't silently stand in for it)* · `Hβ.query.graph-projection-surface` *(new)* · `Hβ.emit.trap-as-exception-postmortem` *(new 2026-07-05 — wasm exception-handling (exnref, standardized) lets a BUG-trap unwind with a payload instead of `unreachable`+stderr: the payload is the graph state at death, projected — the coredump autopsy face 7 needed, as a structured projection instead of a heap read; zero steady-state cost, diagnostics-tier only)*.

**M · The felt surface / `mentl edit` (L6, §4⑦, §0 pt 5 — oversight is survival, NOT garnish; the thinnest-swept band, most at risk of erasure).** `Hβ.felt.mentl-edit-runtime` *(new — the canonical IDE as a running keystroke→parse→format→render loop)* · `.reactivity-typed-demand-driven` · `.lsp-transport-projection` *(new)* · `.collab-grove-cmrdt-semantic` (Grove POPL 2025, over the TYPED graph) · `.legibility-derived-not-molded` · `.verification-dashboard` *(new — live V_Pending / transitive-!E / Why-chain for oversight)* · `.hole-is-dormant-continuation` (Hazel fill-and-resume = the multishot record).

**N · Backends — the handler IS the backend (§5 stage 3).** `Hβ.backend.native-codegen-handler` (retire wasmtime/WABT) · `Hβ.native.wasm64-backend-handler` *(new)* · `Hβ.emit.memory-gc-handler`.

**O · Self-hosting infra (resolves AT/around first-light; captured so it is not forgotten — NOT post-first-light work).** `Hβ.seed.float-gradient` · `Hβ.seed.multishot-producer` (both dissolve at first-light) · `Hβ.persist.module-image-cache` *(cross-run module skip as §4④ image-persist: the graph image memcpy'd whole — env entries, oracle queue, Reason chains intact — keyed by source hash + transitive dep hashes, the invalidation design the deleted .kai layer proved; rides band B's persist-equals-memcpy substrate; supersedes the deleted `Hβ.cache.cross-file-resolved-row`)* · `Hβ.driver.per-module-env-overlay` · `Hβ.f1.handler-substrates`.

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

## §7 · Current state (grounded 2026-07-07 — **the SINGLETON DISPATCH TIER built and m2-GREEN (ev_perform_entry 6401→4209, 2200 route-ops direct-dispatch, hof-map rung CLEARED). The m3-ASSEMBLY reachability-consistency root CLOSED (dcac3b8): the four undefined fn-value globals were NOT the dead cursor_default subsystem — 3 of 4 belong to the INSTALLED project_queue_merger; the wheel walked only individually-reached arms while the container-keep filter emits the whole container. `reach_decl_refs` now walks every arm the filter emits (emission == reachability). rungs 8/0, micros-through-m2 45/0; the detached fixpoint march is the oracle confirming m3 assembles**; gates: `verify.sh` + `march-gate.sh --micros`)

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
> micros-through-m2 45/0, m2 +5 lines (the newly-walked arms); the detached
> `march.sh --fixpoint` is the oracle confirming m3 now assembles (the four globals
> defined) → `GATE_WASM=m3.wasm march-gate --micros` → `march.sh --fixpoint` (m4).
>
> **THE CO-EQUAL CORRECTNESS FOLLOW-UP — proven-singleton dispatch (`Hβ.lower.
> singleton-dispatch-gated-on-install`), NOT the assembly blocker but a real bug.**
> The reachability fix makes m3 assemble WITH cursor_default's dead subsystem
> emitted (force-linked because its `cursor_at`, performed at
> cursor_transport.mn:247, singleton-dispatches even though cursor_default is
> NEVER `~>`-installed, cursor.mn:82). Singleton-dispatching an UNINSTALLED handler
> is SEMANTICALLY WRONG independent of assembly: `lower_singleton_perform` reads
> `$cursor_default_state_g`, a state record NO install ever initialized — garbage
> if that perform executes. THE CUT (resolved to the cleaner form): the op→handler
> dispatch edge (`EffectOpScheme.default_handler`) must mean "installed =
> dispatchable," so DRAW IT AT THE INSTALL, not the decl. Move `draw_op_edges` out
> of `register_handler` (the pre-register DECL pass, where it fires for every
> declared handler incl. the never-installed cursor_default) and INTO
> `infer_pipe_tee` (the `~>` install): read the installed handler's arms from its
> `HandlerKind`'s 5th field (already registered — `pre_register_decls`, infer.mn:149,
> runs before any body/install is inferred, so no ordering gap) and draw the edges
> there. Then `lower_op_default_handler` reads the edge UNCHANGED — no install-set
> scan, no lower gate, the edge itself carries the install fact live (Carried-Truth).
> An uninstalled handler gets NO edge → `lower_op_default_handler` None → evidence
> (which correctly finds no handler → a genuine unhandled effect, not garbage) →
> reaches NO arm (evidence dispatch has no static arm target) → its container is
> dropped → cursor_default's dead subsystem no longer emits (LESS
> code, and it retires the `noconfig_handler_names` union 9a03abd added ONLY to
> serve dead handlers' `_state_g`). HIGH-RISK per Law 7 (moving the edge silently
> changes dispatch for every op — if a currently-singleton route-infra handler
> graph/env is installed by a NON-`~>`-PTee path, its edge would vanish and the
> deep-chain `ev_perform_entry` trap b00e94c fixed RETURNS), so the ONE
> pre-implementation check: confirm every singleton-dispatched route-infra handler
> reaches `infer_pipe_tee` (a `~>` install), and land it as its own gated commit
> AFTER the reachability fix march-confirms. Named future refinement (not a
> blocker — no handler is loop-installed today): a `~>` inside a loop/recursion is
> NOT a proven singleton (§5.3 step 3 "installed exactly once"), so Approach B's
> draw-at-install eventually needs the not-under-loop guard. Not required for
> first-light.
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
bash tools/state.sh            # seed build · wheel census · micro battery · FIXED-POINT m3==m4 (run FIRST)
bash tools/state.sh --quick    # census + micros only (one wasmtime pass)
bash tools/march-gate.sh       # the LIVE m2 rung scoreboard (7 pass / 1 fail; hof-map the open rung)
bash tools/march-gate.sh --micros   # + micros-through-m2 (the wheel's own emit runs the battery — 0/34, the seam's blast radius)
tools/faithful.sh <file.mn>    # proto-`mentl verify`: does mentl2 agree with the seed?
tools/faithful.sh --wheel      # live L1 status   ·   --bisect: ddmin to the minimal failing file-set
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
