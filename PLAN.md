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

**B · Continuations & TIME (arm 2, §4④) — the binding keystone.** `Hβ.types.tcont-world-binding-keystone` (STEP 5 landed the 3-arg arity; the world is INERT on OneShot — ENFORCE it) · `Hβ.types.resume-world-mismatch-value-gate` (the runnable gate; layout-in-world coupling; DEP persist resume-catcher + STEP 1) · `Hβ.infer.tcont-world-capture-at-reify` (at the multi-shot producer's reify site) · `Hβ.continuations.world-widening-resume` (typed superset-resume) · `Hβ.continuations.persist-equals-memcpy-handler` (= `Hβ.lower.fanout-durable-persist-handler`; `~> Persist`, zero serializer; STEP 3 producer landed) · `Hβ.persist.cross-machine-resume` *(new)* · `Hβ.persist.branch-world-tag` (persist.mn:119) · `Hβ.continuations.wasmfx-lowering-tier` · `Hβ.infer.tail-recursion-resume-cardinality` (infer.mn:3174) · `Hβ.lower.either-install-negotiation` · `Hβ.felt.time-travel-debug-forked-cursor` *(new)* · `Hβ.ml.autodiff-as-multishot` (autodiff.mn:36).

**C · IFC — flow in the row (arm 4/6, §4⑥; W31 scaffold landed).** `Hβ.verify.ifc-noninterference` (umbrella; code `Hβ.types.ifc-flow-constraint`, types.mn:1029) ← `Hβ.ifc.dcc-noninterference-gate` → `.flowlabel-inference-in-hm` → `.pc-label-implicit-flow` → `.integrity-dual-lattice` (prompt-injection IS an integrity-flow violation) → `.declassify-robust` → `.flow-world-on-tcont` → `.agentic-fides-target`. DEP-rooted on `sound-neg-under-poly`.

**D · The value layer — fold & repr (arms 1/7, §5.U; STEP 0/1/2 landed).** `Hβ.fold.show-leaf` (synthesize as a lowered LFn, not raw WAT; lower.mn:481) · `.compare-hash-leaf` · gate `Hβ.eq.fold-seed-value-gate` · `Hβ.repr.arrow-layout-interop` · `Hβ.emit.variant-payload-repr-width` (wasm.mn:4913) · `.plit-handle-repr` (wasm.mn:5537) · `Hβ.value.ontology-derivation-complete` · `Hβ.runtime.zero-copy-string-view` (lexer.mn:316).

**E · Parallelism & accelerators (arm 3, §4④; STEP 4 collapse landed).** `Hβ.lower.fanout-simd-lane-cashout` (RV128) · `.fanout-gpu-backend-handler` (lower.mn:1475) · `.fanout-durable-persist-handler` (SPACE=TIME) · `Hβ.parallel.thread-alloc-transitive-proof` (verify ONLY after the leak closes) · `.race-freedom-ownership-proof` · `Hβ.infer.fanout-ownership-from-use-count` (infer.mn:1288) · `Hβ.runtime.wasi-thread-spawn-seed` (threading.mn:296) · `Hβ.driver.level-set-par-walk` *(the topological layer-partition is LIVE in driver.mn — 7165bbb; the open half is the multi-core `>< ~> Thread` at the layer site)* · `Hβ.cursor.speculative-compile` · `Hβ.cursor.work-stealing-via-gradient` *(idle cores ask the cursor "what next?"; the gradient's argmax IS the priority queue — no scheduler module)* · `Hβ.lower.schedule-specialized-callee` *(new — the parallel_map dissolution's open remainder: whether a reusable fn's internal `><`/`<|` should EVER inherit a caller-installed `Schedule` across a call boundary. The only sound route is compile-time specialization of the callee per install-context, preserving `Seq`'s zero-cost/`!Thread`-provable property — the §5.3 dispatch gradient's sibling on the INSTALLED-HANDLER axis (vs the known-argument axis; shares callee-specialization infra). The ambient/evidence-passed-runtime `Schedule` alternative is the wrong direction — it taxes every `Seq` fanout to buy portability only a rare `Thread` caller needs. Scoped skeptically: direct `>< + ~> Thread` at the use site is sufficient and simpler; build only when a real consumer needs one fanout helper serving callers wanting different schedules. Sequenced behind `Hβ.driver.level-set-par-walk`, DEP-gated on band-A `sound-neg-under-poly`)*.

**F · Verification & proof (arm 6/8).** `Hβ.types.predicate-is-expr` (dissolve PExpr) → `Hβ.verify.smt-handler-swap` (Z3+CVC5; NAME the external-SMT residual !Outside if it persists) → `.higher-order-refinement` · `Hβ.verify.ledger-soundness` (no silent assume-true; the Dafny `{:axiom}` cautionary) · `.proof-incrementality-cached-cursor` · `.reason-edge-pcc-certificate` · `Hβ.dsp.hz-ceiling-ambient-sample-rate` · `Hβ.refine.buffer-invariant` · `Hβ.infer.predicate-from-bool-expression`.

**G · Graph & e-graph (arm 1) — highest-leverage incompleteness first.** `Hβ.egraph.per-expr-effect-row` (egraph.mn:70 — reduces is_pure to effs_at alone, generalizing the effect-gate to every rewrite) · `Hβ.lower.egraph-saturation-deepen` · `.typed-rulecyclic` (the depth-1000 cap → a typed E_RuleSetCyclic via the Why chain, unreachable-by-construction) · `.rule-as-query` · `.extraction-cost-composes-repr` · `.const-fold-minted-node-full-edges`.

**H · Ownership (arm 5, §4⑤).** `Hβ.ownership.fractional-uniqueness-ref-borrow` (Granule ICFP 2024) · `.quiet-empirical-gate` (the Hylo bar — a corpus test counting authored own/ref markers; a rising count IS inference failing §4⑤).

**I · Dataflow & DSP (arm 3/6).** `Hβ.dataflow.causality-compile-error` (a zero-delay `<~` cycle is a compile error, Faust's causality rule; no code anchor yet — the peer is named here, not in a comment) · `.clock-calculus-sample-rate` · `.point-free-fusion-via-egraph`.

**J · Self-hosting & !Outside hardening (L7, §1).** `Hβ.closure.diverse-double-compilation` (Thompson/Wheeler 2009 — a second disposable seed converging to identical m3 closes trusting-trust, which the byte-fixpoint alone cannot; DEP native backend) · `.correctness-oracle-internal` (the external micro-battery → the wheel's own Verify; until then first-light's correctness half is itself an !Outside) · `.reflexive-over-proposers` (code `Hβ.synth.proposer-gauntlet`).

**K · AI-proposer / Synth (arm 2, §0/§1).** `Hβ.proposer.constraint-not-token-worked-example` (Lahiri 2026 — answer the spec-oracle problem with a worked example, not a claim) · `.synth-handler-error-fed-back` (the lossless constraint, not the lossy token).

**L · The Why-engine & `mentl audit` (arm 8/1, §0 — the medium enforcing its own discipline).** `Hβ.audit.carried-truth-projection` *(new — the §0 keystone: project a Carried-Truth violation BEFORE a line is written, making the wrong move unsayable)* · `Hβ.diag.minimal-inconsistent-core` (= `.why.minimal-cause-set`) · `Hβ.infer.marked-lambda-totality-invariant` (POPL 2024) · `Hβ.diag.catalog-as-projection` (report takes a DiagKind ADT) · `Hβ.query.graph-projection-surface` *(new)*.

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

## §7 · Current state (grounded 2026-07-04, HEAD 2456137; gates: `verify.sh` + `march-gate.sh`)

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
  **THE ACTIVE CURSOR — the infer_ctx NESTING DISCIPLINE (hypothesis
  carrying a 3-edit test; the §9 wrong-end class IN THE WHEEL):**
  `inf_enter_fn` / `inf_enter_arm` push at the FRONT (`[frame] ++
  stack`) while `last`/`drop_last` and the add-arms' rebuilds
  (`[updated] ++ drop_last(stack)`) work the END; third limb, `declared`
  is a SCALAR nested fns overwrite. Depth-1 is coherent (why 7 rungs
  pass); nesting scrambles — inner frames accumulate into outer, inner
  rows come out EMPTY (hof-map's exact pin), and lambdas DO push frames
  (infer.mn:32). The full arc from here: plans/noble-brewing-rose.md
  (the gate-coupled line to first-light and through it).
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
