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
   prove it *won't* leak data / allocate unboundedly / reach the network" the
   existential question. Name-keyed `!E` under polymorphism is shared ground
   with the Flix line (ICFP'23 effect exclusion — a user-facing "no excluded
   effect is ever performed" theorem, complete inference; OOPSLA'25 Boolean
   qualifiers); Mentl's own seat is the CONJUNCTION nobody holds: absence
   under handler/install IDENTITY, under modality, under TIME (a persisted
   continuation's world), and per-INSTANCE (`!Sample(44100)`) — each measured
   empty as of 2026-07. **This is Mentl's most underrated arm and the
   future's deepest need.**
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

**Arche and telos — which is the root, and which is the point** (crystallized
2026-07-13, an eight-agent adversarial pass refuting the founder's own
DX-first framing; the refutation held). The **generative root — the arche — is
the kernel**: one graph, two operations, and its closure `!Outside`. From those,
*both* the felt developer experience (L6, projected bottom-up per §3 — each
layer forced by the one below) *and* the five machine-age properties project;
neither generates the other. The **developer is the telos** — what the medium
is *for* ("the developer they become is the end") — and that is exactly *why
proof wins whenever it meets convenience*: proof serves the developer better
than an ergonomic lie, so a proof-first root is the DX-*honoring* one, and an
ergonomics-first root would betray the developer at the first
soundness/convenience trade (TypeScript's `any`, Scala's implicits, unchecked
exceptions — the paved road to unsound languages, all "developer-friendly"
first). So the DX-is-the-root reframe is a telos-as-arche error; the truer
statement extends the one-law-at-three-scales convergence: **the developer's
intent→expression gap and civilization's machine-authored-code trust gap are
the SAME invariant — the Carried-Truth Law — read at two scales**, and the
convergence of independent directions onto one answer *is* the truth signal
(re-rooting on either scale makes that convergence tautological and dissolves
the argument the north star rests on). The one true residue of the DX critique
is a **guardrail, not a re-rooting**: keep the machine-age framing tethered to
the actual developer at the keyboard, so it never inflates into grandiose
detachment.

And scope `!Outside` exactly where §1 places it, no wider: it is **toolchain
reflexivity** — every lever to improve the medium (compiler, IDE, oracle,
formatter, prover) is already a move *inside* it. It does NOT close the **intent
space** — specs are born in the human's head, a genuine Outside where meaning
originates, and a proof is always relative to a spec (proof-passing but
intent-wrong code is a failure proof *launders*, not one it removes) — nor the
**capability space** (Rice bounds a Turing-complete self-hosting verifier to
sound *or* complete, never both; Mentl chooses sound-and-incomplete, accruing
honest `V_Pending` debt over fabrication). Two Outsides the medium is still
closing, both already named: the external-SMT residual
(`Hβ.verify.smt-handler-swap`) and the internal correctness oracle
(`Hβ.closure.correctness-oracle-internal` — first-light proves *reproduction*,
not *correctness*, so today the micro-battery is itself an external oracle).
Naming them is what buys the skeptic's trust and costs the thesis nothing.

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
- **Closed over proposers — the medium is a verification-gated proposal
  substrate.** Any external intelligence — the graph's own vocabulary,
  type-directed enumeration, SMT, a model, whatever follows — plugs in as a
  `Synth` handler whose candidates must survive checkpoint → infer → Verify →
  rollback over the trail-backed shared image before any human trusts one. This
  is **Oracle-Guided Inductive Synthesis / Synthesis-Modulo-Oracles** (Jha–Seshia
  2017; Polgreen–Reynolds–Seshia, VMCAI 2022) instantiated on the memory model —
  a published architecture Mentl realizes cleanly, not invents. A stronger
  proposer strictly strengthens the medium and can never surpass it, because its
  only path to execution runs through the kernel; the unit of conversation with a
  model is the token (lossy, decaying), with the medium it is the **constraint**
  (lossless, monotone, compounding). But be exact about what proof does, because
  the equivocation is seductive: **proof is a MONOTONE FILTER, not a
  generator.** "The proof becomes the dispatch" is TRUE and TOTAL at
  instruction-selection (an f64 operand admits exactly one add opcode — a finite,
  decidable set the type fully determines) and only a FILTER at authorship (a
  type + refinement is a *partial* spec admitting infinitely many well-typed
  inhabitants — `(xs) => 0`, `(xs) => sum(abs(xs))` both "prove" under
  `[Int] -> Int where result >= 0`), so the dispatch *among the survivors* — which
  proven program the developer actually MEANT — is **exogenous**: carried by the
  human, or by an inductive/learned ranker that is itself a legitimate `Synth`
  handler behind the gate, never a projection of the graph's truth at P. But be
  equally exact about the PROPOSER, because "so keep a model as the proposer" is
  the refuter's own equivocation (corrected 2026-07-13, Morgan): at the cursor the
  medium does NOT enumerate token space against a bare type — it proposes by
  GUIDED search over the whole typed graph (every in-scope row, the Reason chains
  carrying upstream intent, the live refinements, ownership, proximity), pruned at
  every step by the proof. That graph IS a prior — a STRUCTURAL one, richer at the
  cursor than a model's token-window, not poorer — and the pruning is the move a
  sampler structurally cannot make (no proof to prune with, so it samples the
  whole distribution and hands one draw to audit). So for the NEXT MOVE — the next
  function, the next annotation, the next fill — the medium is the best proposer
  and the learned model is **UNNECESSARY, not merely filtered**: when two
  survivors satisfy every EXPRESSED constraint, the medium does not guess — it
  surfaces the ONE missing constraint (a refinement, a type, an example) that
  collapses the tie, then proposes the proven code. The gradient reading local
  intent is the ranker; the disambiguating question is the tie-break; that IS the
  teaching compiler, and what Mentl's voice speaks when it proposes. A learned
  ranker survives only as an OPTIONAL last-resort `Synth` handler behind the same
  gate — never necessary, because naming the missing bit is one keystroke, cheaper
  than guessing it. **"Cut the model out" holds at next-move scope** — not by
  out-guessing it but by never needing a guess. The honest boundary is SCOPE, and
  it is the correct scope, not a weakness: a 500-line algorithm from one sentence
  IS underdetermined for guided search and a model alike, but that was never a
  hole-fill — the medium builds a program as a SEQUENCE of proven next-moves, each
  accepted or refined, trustworthy by construction where whole-cloth generation
  can never be. Even in that underdetermined tail a partially-sound Mentl gate
  beats a fluent generator categorically: a verifier with a known, characterizable,
  lintable hole emits a *checkable derivation*, fails *systematically*, and accrues
  *monotone* constraints — three properties a token-sampler cannot have. The moat
  is the gate; the PROPOSER over the typed graph is the second moat the refuter
  missed, and the crown (`!E`-sound-under-poly) is what makes both trustworthy.
  **THE CLOSED LOOP (Morgan, 2026-07-28 — the vision's terminal form): the
  loop closes to the HUMAN and MENTL, and no LLM offers an advantage at ANY
  scope — obsolete for coding.** Not a hedge softened, a target named: the
  Synth port stays universal by construction (closure over proposers IS the
  thesis — anything may propose, nothing executes unproven), and the design
  target is that nothing ever needs to arrive through it. Three legs carry
  the claim, each a build item this plan already sequences: (1) NEXT-MOVE
  SUPREMACY — guided search over the live typed graph (rows, Reasons,
  refinements, ownership, proximity), extraction-optimal per §5's optimality
  half, beats any token prior at the move scale; (2) THE QUESTION BEATS THE
  GUESS — where intent genuinely underdetermines, the medium asks the
  minimal-entropy question (the teaching tie-break; Choose-Don't-Label /
  OGIS selection math), so the human's one keystroke replaces the model's
  whole sample, and the underdetermined tail dissolves into a conversation
  of proven next-moves — intent is the one genuine Outside (§0) and the
  HUMAN is its only source, so the machinery that turns intent into
  constraint fastest wins by construction; (3) THE LOOP IS FELT — the
  multithreaded multi-cursor multi-shot time-traveling oracle (the fused
  judgment+fan substrate, landed) makes the propose-verify-teach cycle
  instant enough to live in, and the five verbs used EXEMPLARY THROUGHOUT
  make the surface state intent as topology directly, shrinking what needs
  proposing at all. An LLM behind the gate is then not forbidden — it is
  UNEMPLOYED.
- **The proof, validated from six directions.** Every domain spent a decade
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
substrate landed; continuation-reification codegen LANDED — k1 through the M1–M4
cut, self-hosted through first-light (§7); the fused N-thread oracle SEARCH over it
is the open reach). *Best
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
fatal to first-class continuations); **modal** (*Modal Effect Types*, the Tang–Lindley
line, OOPSLA 2025 — rows *and* capabilities unified by a modality that re-admits first-class
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
`free_in_row`/`subst_row` cross the negation — the mechanism Koka omitted
negation to avoid, realized through the row representation. (REPRESENTATION
NOTE, 2026-07-22: the six-form row tree named in this paragraph's history —
EfPure/EfClosed/EfOpen/EfNeg/EfSub/EfInter — is superseded by the canonical
triple `EfRow(present, absent, tail)` with `EffTail = EtClosed | EtVar | EtAll`;
negation IS the absent field, subtraction/intersection are eager fieldwise ops,
and bind_open_to_neg's move is unify's Open~All arm binding the var to the
masked triple. The landing record keeps the era's vocabulary; the §7 ledger
entry carries the ruling.) The adversarial soundness GATE
LANDED (2026-07-13, effects.mn `row_subsumes` EfNeg arm): the negation membership
matches BY NAME (`forbidden_names_disjoint` / `eff_name_str`) — `!E` proves the
ABSENCE of the effect NAMED E (SYNTAX §Negation), every instance — because the old
check compared names with pointer `i32.eq` and a byte-equal `ENamed("E")` from an
effect decl and from a `with !E` clause are distinct heap objects, so a forbidden
effect passed straight through the gate (direct, transitive `a→b→bad`, and
higher-order `run(() => op())` all leaked at baseline). By-name is robust to the
`ENamed`/`EParameterized` split a structural `==` would itself leak through (a bare
`!Sample` is `ENamed` while a performed `Sample` is `EParameterized`) and leaves the
row-algebra hot path untouched — a broad structural fix timed the wheel compile out.
The five crucibles (tests/crown/, tools/crown-gate.sh) reject direct/transitive/
higher-order and accept the sound controls; the gate FAILS at pre-fix boot and
PASSES against the fix; 66/66 micros hold and the fixpoint is byte-identical
(m2 == m3), so it is Law-7-additive — the wheel's own `!` fns never violate their
declarations, so the gate returns the same verdict there. What REMAINS open in band
A: the full modal world-index, and two follow-ups the working gate exposed —
`Hβ.effects.positive-row-pointer-eq` (the positive path's pointer-eq
false-positive — 598 false mismatches on the self-compile, healed to 146 by the
by-name membership fix, cc487f8 §7; the residual dissolves with
EffName-is-a-handle) and `Hβ.effects.parameterized-negation-instance`
(instance-precise `!Sample(44100)` admitting `Sample(48000)`; bare `!E` by-name is
sound and conservative).
**(b) the TIME axis** — `TCont(R, S, ResumeDiscipline, EffRow)`, landed in two
steps exactly as §5.U records them: 27edc30 added the effect-WORLD index; the
executable-boundary landing (2026-07-16, §7) split resume-input `R` from
remainder-answer `S` and captures the world on the ContinuationEdge at
inference. The unify-time gates are LIVE (discipline mismatch raises
`E_ResumeWorldMismatch`; the world half unifies as a row); band B's open work
is the runtime VALUE gate on a genuinely divergent world (the declared
`E_ResumeWorldMismatchWorld` raise is unwired — persist's rehydrate now
REFUSES via Fail). **The graph is the ROUTE, never the replacement:** Mentl's
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

   **The felt endpoint — verification-gated proposal at the `??` (§1's proposer
   closure, made the surface).** As you type, a `??` is a typed CONSTRAINT (the
   graph knows its type, effect-row, ownership, refinement); the cursor forks a
   **finite, latency-budgeted set** of candidate fillings (the graph's
   vocabulary, enumeration, an installed learned proposer), each run
   checkpoint → infer → Verify → rollback on its own trail, and only the proven
   survivors surface. This is **sample-then-filter, asynchronous and
   best-effort — it may return nothing** — NOT an exhaustive multiverse per
   keystroke: enumeration hits the synthesis exponential wall (FlashFill:
   ~10²⁰ programs for a few examples), the cheap trail-fork lowers the
   per-*visit* constant never the candidate *count*, and the IC cursor memoizes
   the context AROUND the hole, not the search WITHIN it (each candidate is a
   different query graph). Multi-shot is continuation-*reification* (resume one
   computation with different values) — the substrate that makes each fork
   cheap, not the search engine (a distinct operation from enumerating
   subtrees; the vocabulary must not be borrowed for generate-and-test). The
   **honest gaps, positive-form:** the ranker among survivors is `gates ×
   proximity` today — sound only over the finite ANNOTATION lattice (effect-row
   / ownership tightenings on already-written code); the ULTIMATE next-move
   ranker is **the gradient reading LOCAL intent** — the Reason chains carrying
   upstream why, proximity, the in-scope vocabulary — with the **teaching
   TIE-BREAK** when two survivors satisfy every expressed constraint (surface the
   one disambiguating refinement / type / example, never guess); a learned
   code-body prior is then an OPTIONAL last-resort `Synth` handler for the
   underdetermined tail, **never the seat** (§1's 2026-07-13 correction —
   `Hβ.felt.intent-ranker-gradient-plus-teaching`, superseding the earlier
   "learned prior behind the gate" framing; the medium is the best next-move
   proposer, the model unnecessary at that scope). And Verify
   must **commit to a decidable refinement fragment** (Liquid/Flux-style) or the
   per-keystroke filter is vaporware past `len(self) > 0`; the undecidable
   residue is honest `V_Pending` debt (the sound-incomplete choice — never a
   silent assume-true; the Dafny `{:axiom}` cautionary, `Hβ.verify.ledger-soundness`)
   or a NAMED external-SMT `!Outside` (`Hβ.verify.smt-handler-swap`).
   **Trustworthiness is a CONJUNCTION with a dependency order, not the crown
   alone:** compiler-correctness *beneath* (a miscompiled wheel voids any
   on-paper `!E`; first-light proved reproduction, not correctness) → Verify-
   discharge-soundness *alongside* → `!E`-sound-under-poly (the crown, root of
   the negative-capability BRANCH every differentiating guarantee inherits — its
   soundness gate LANDED 2026-07-13, 29df478, the by-name negation gate,
   m2==m3 byte-identical; the modal world-index is the open remainder, uniquely
   Mentl's) → spec-faithfulness *above*
   (the crown does not touch it; proof-passing-but-intent-wrong code is a failure
   proof LAUNDERS, band K's Lahiri worked-example). The genuinely novel residue,
   on the FILTER/substrate side AND on GUIDED next-move search — never on the
   UNGUIDED whole-program enumeration that explodes (that tail is where a learned
   ranker earns its keep): the **effect-and-ownership-typed hole** prunes classes
   no simply-typed (Hazel) or refinement-but-effect-blind (Synquid) hole can —
   type-directed search over the FINITE in-scope vocabulary, pruned by the row at
   every step, IS the proposer for the next move, the structural prior the
   token-sampler lacks; **trail-fork + memcpy-persist** unifies backtrack with
   durable execution (persist = memcpy) in one loop; **`??` is one absence
   marker across SPACE (partial application) and TIME (the resumable
   continuation)**; and **`!E`-gated speculation** — proving an effect's ABSENCE
   is the license to *live-run* a candidate (only `!IO` runs freely; the rest
   caught by a virtualizing handler), a correct answer to live programming's
   "don't run the dangerous candidate," contingent on the crown landing.

   **THE OPTIMALITY HALF (Morgan's charge, 2026-07-28): the space between
   a developer's intent-plus-constraints and the BEST implementation of it
   as machine instruction is the medium's to EVAPORATE — a proposal is not
   merely proven, it is extraction-OPTIMAL.** A survivor is an equality
   CLASS, not one program: the e-graph saturates the proven fill under the
   effect-aware rewrites, extraction picks the cost-minimal member, the
   repr gradient pins its widths, and the native projection (band N) makes
   "best machine instruction" literal — superoptimization as the default
   authoring experience, never a pass you opt into. This is what obsoletes
   the generative copilot at next-move scope, stated as channels: the
   copilot's channel — intent → tokens → plausible text → human audit — is
   lossy at every arrow and its enforcement is behavioral (the 2026
   spec-driven wave concedes it in its own docs: intent captured in
   markdown, "no automated validation that generated code matches
   specifications"); the medium's channel — intent → CONSTRAINT (typed,
   monotone, compounding) → guided search pruned by proof at every step →
   survivors ranked by local intent → the tie TEACHES → the accepted move
   proven AND optimal — has no unverified middle, because every
   intermediate is a graph fact. What a generative assistant retains is
   the underdetermined tail, and the medium converts that tail into a
   sequence of proven next-moves; a learned proposer survives only as an
   optional `Synth` handler behind the gate, never the seat (§1's
   correction, now with its optimality face) — and the CLOSED-LOOP target
   (§1, Morgan 2026-07-28) is that the port stays EMPTY: the loop closed to
   the human and the medium, no LLM advantageous at any scope.

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
  ret_slot` — CONSTRUCTED at STEP 3 (7b72790, the write-only resume_kinds ledger
  dissolved); the k1→M4 arc self-hosted the producer through the fixpoint.
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
  function-leaf's serialized-closure world). **The fold's TRAVERSALS are
  unified (2026-07-18, the unified each):** the five walks of the lowered
  tree (four per-leaf type-closure collectors + the show-literal
  re-collection) are ONE walk carrying the four closures as one record, and
  the four dedup walkers are ONE keyed by the FoldOp ADT — 25 fns deleted,
  the eq/cmp collectors' dropped-right-subtree class closed by construction
  (§7 ledger). The LEAF GENERATORS remain four: conjunction / first-nonzero
  chain / FNV mix / concat tree are four real leaves of the one fold, not
  copies — their unification is the synthesize-as-lowered-LFn altitude
  (band D's `Hβ.fold.show-leaf` / `.compare-hash-leaf`), not a walker merge. There is NO pack/unpack leaf: the
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

**THE BINDING KEYSTONE — `TCont(R, S, ResumeDiscipline, EffRow)` — LANDED
IN TWO STRUCTURAL STEPS (27edc30 world index; executable-boundary R/S split).**
Carrying the **effect-WORLD** on the continuation lifts
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

### §5.O · The O(1) architecture — performance IS the Carried-Truth Law

**The only acceptable complexity for any operation in Mentl is O(1)** (Morgan,
2026-07-13). Not an aspiration — the Carried-Truth Law read at the performance
scale. The kernel is one graph whose ONLY native access is the O(1) flat-array
handle chase (§2), so a super-constant operation is by definition NOT reading the
graph — it is RE-DERIVING what the graph already holds (a scan, a re-filter, a
re-clone). **"O(1) only" ≡ "read the edge, never re-scan" ≡ Law 1.** Every scanner
in the compiler is a place we forgot the graph already knew. (Derived by running
the eight interrogations on the hot paths, 2026-07-13; the record is in the arc
below.)

**The diagnosis (8-agent adversarial workflow, 2026-07-13 — the 22-min
self-compile).** The cost is 100% guest ALGORITHM: JIT is ~20ms, AOT marginal,
`wasm-opt -O2` a measured 4% regression (§8 — the cost is algorithmic, never
instruction slop). Seven independent readers converged on ONE class — the
compiler re-derives BY NAME what a HANDLE already connects:
- **`env_find_flat` — O(n²)** (pipeline.mn:375): a backward by-NAME linear
  `str_eq` scan of the ~2,036-entry flat env buffer per name resolution;
  pre_register_decls registers top-level names FIRST (so they sit deepest), and
  every stdlib reference (`map`/`fold`/`mint`/`N`/`Some`) scans to the bottom.
  ~1e5 refs × ~2k entries — the dominant compute O(n²). CONVERGENT (5 of 7 agents).
- **`dedup_fn_records` / `dedup_names` — O(U²)** (wasm.mn:1145/1168): the
  O(U³)→O(U²) concat-spine fix already landed this session (a flat-buffer
  `name_seen_at`/`fn_record_seen` membership scan over a preallocated `out`; the
  old `acc ++ [x]` spine made `list_index` O(depth) → O(U³), ~1.5e9 node-steps).
  Still super-constant — the O(1) target is a handle-set bit (layer 2).
- **`esc_assoc` — O(n²)** (lower.mn:1383): a name-keyed escaping-row side-ledger
  re-scanned per call site, three stacked passes.
- **`instantiate` → `subst_ty` tree-clone** (infer.mn:4185) + **`find_mapping`'s
  per-leaf `filter`-alloc** (infer.mn:4351): a full type-tree clone per
  polymorphic reference, garbage per TVar leaf. (Perf-trued 2026-07-24: the
  cluster samples at ~0% of the post-crc compile — its cost is ALLOCATION
  volume, the OOM channel, not time; the sharing fix gates on an alloc count.)
- **The 4GB never-free bump image** (memory.mn): ~1e8 transient records → a
  cache-hostile working set that MULTIPLIES the constant factor of every
  pointer-chase — the amplifier on all of the above.
- **Zero parallelism** (pipeline.mn:100): the whole self-compile is ONE sequential
  `|>` cursor, 8 cores idle; the level-set partition (driver.mn) is off the hot
  path.

**CORRECTION (2026-07-13) — the code-reading diagnosis MISSED the actual dominant
cost; empirical `perf` found it.** The 8 agents read code and estimated; the
biggest cost they named (env `env_find_flat`) measured 0.5–4% (below the ±14%
run-variance — fixing it moved nothing). The REAL dominant cost was the
**resume-cardinality classifier** (`classify_fixpoint`, infer.mn) — O(rounds ×
(N² + calls×N)), ~47% of the whole compile — which NO agent flagged, because a
static read can't see a fixpoint's round-count × per-call rescans compounding.
Host `perf` (§8, surviving `proc_exit`) pinned it at 98% of a sample; the O(1)
str_hash-index fix cut m3-gen 1400s → 749s (§7). The lesson is load-bearing for
this whole section: **measure the hot path with `perf`, never trust a
code-reading estimate — the ultimate-form target is still O(1) everywhere, but
which O(n^k) dominates is an empirical question.** The perf loop then VINDICATED
this end to end (§7, 2026-07-14): **1400s → 10s (~140×)** across seven
iterations, and the TWO biggest wins after the classifier — the reachability
per-frontier-name scan (58.66%, iter 6) and `iterate_from`'s snoc-list
`list_index` (48.85%, iter 7) — were ALSO absent from the 8-agent code-reading
diagnosis; both were found by profiling the fixed m2. The build loop is now
~20s (the boot compiler IS the fast wheel), so the O(1) march is cheap to
continue. The build-order layers below (name-is-handle → per-decl arena →
parallel cursors) remain the substrate-generalizing endpoint; the per-subsystem
str_hash indexes (env/summary/region/base/esc/reach) are the O(1) WAYPOINTS
they dissolve — a name is a HANDLE, and reachability an EDGE
(`Hβ.lower.reach-edge-on-node`), not a name scanned live.

**The unifying fix — a name is a HANDLE, not a byte-sequence.** Interned ONCE at
lex (the content-intern hash ALREADY exists at emit — `string_offset` is
O(1)-bucketed since the interner landed — but it is emit-scoped and offset-keyed;
the phase-A move is birthing the table at LEX, where scan_ident today mints a
fresh slice per occurrence and the canonical instance can be stored once). Then
every downstream compare is `i32.eq` (never `str_eq`), every table is
handle-keyed (O(1) index, never a name scan), every set is a handle-bit. This
dissolves env / dedup / find_mapping / esc into the graph's O(1) chase — LESS
code (delete every scanner) — and the byte-sequence survives only as a display
projection (arm 7's gradient cash-out: a name's ultimate representation is a word).

**The build order — each layer makes the next O(1):**
1. **Handle-interning substrate** (`Hβ.perf.name-is-handle`) — the string intern
   table goes O(1) (a `str_hash`-keyed index), every identifier a handle at lex.
   Load-bearing; everything else is O(1) off it.
2. **The O(1) reads** — `env_lookup` (handle-index → slot, `Hβ.perf.env-o1-index`),
   dedup (handle-set bit, `Hβ.emit.flat-accumulator-dedup` → handle-set),
   `find_mapping` (handle→handle chase), esc-rows (a FIELD on the fn's node read
   live, the side-ledger deleted, `Hβ.lower.esc-row-on-node`), instantiate
   (`Hβ.infer.instantiate-shares-never-clones`), and REACHABILITY — the emitted-fn
   set as EDGE-following from main (`Hβ.lower.reach-edge-on-node`), the name scan
   gone (the `reach_has` membership's remaining O(n²) is `Hβ.lower.reach-membership-o1`).
   The str_hash WAYPOINTS largely converged already (trued 2026-07-24): smap
   (lib/runtime/imap.mn, the one String-keyed primitive) carries the infer/lower
   indexes; the two hand-rolled survivors are the env index (pipeline.mn
   env_index_new/env_bucket_pos family) and the emit string table (wasm.mn's own
   buckets). `Hβ.runtime.indexed-map-primitive` finishes as: those two re-key by
   handle onto the one primitive once names are handles. Each a Carried-Truth
   deletion.
3. **Per-decl arena** (`Hβ.perf.per-decl-arena`, gated on
   `Hβ.infer.region-on-tee-alloc-absorb`) — each decl's transient scratch is
   `own`ed and `Consume`d at the decl boundary; the region drop IS the arena reset
   (O(1)), `!Alloc` after; the 4GB working set collapses to one decl's live set →
   cache-resident. Activates the dormant emit_memory_arena swap (wasm.mn:139).
4. **Parallel cursors** — the level-set partition at DECL granularity on the
   compile spine, infer/lower/emit fanned across cores with (arena_id, offset)
   deterministic handle partitioning so native_m3==native_m4 holds
   (`Hβ.driver.level-set-par-walk` multi-core half + `Hβ.native.deterministic-handle-partition`).
   The `><` verb over the shared image; the highest ceiling.

**Self-hosting:** layers 1–2 are Law-7 byte-identical where they change only HOW a
fact is found, a TRANSITION where interning shifts emitted handle-order; layer 3
is a TRANSITION too (the fleet's 2026-07-17 refutation of the earlier
"output-invariant" claim here: any real arena changes allocation order and
therefore handle numbering — plan it as a re-pin, never a no-op); layer 4 CHANGES bytes (handle
numbers shift under the partition — a TRANSITION, re-pin from m3, the sharpest
risk, well-precedented). Each layer marched + gated before the next. The whole
becomes O(n) total (n = program size, O(1) per operation) on N cores — the
substrate-honest floor of "unsurpassed speed."

### §5.R · The post-first-light roadmap — the named remainder (so first-light's focus cannot erase it)

> Every unsurpassable item NAMED in positive form and SEQUENCED, so the work
> survives first-light's all-consuming focus (gathered 2026-06-28: the SOTA fleet +
> the three docs + the codebase `Hβ.*` peers + an adversarial completeness critic;
> 95 items / 15 bands; **full detail with SOTA refs + file:line anchors in
> git history: docs/research/post-first-light-roadmap.md**, the SOTA map in
> git history: docs/research/sota-convergence.md). Each is a positive-form named peer — a
> hidden gap is drift (the bug IS the non-ultimate form, `CLAUDE.md ⟐`). Sequenced
> AFTER first-light unless marked NOW; the gate that unblocks dependents leads each
> band. **THE SPINE:** `Hβ.effects.sound-neg-under-poly` is the dependency ROOT —
> ownership-as-effect, `!Thread`/`!Alloc` transitivity, and IFC non-interference — its
> soundness GATE LANDED (29df478), so dependents can now be verified against it; the
> modal world-index and the `TCont` world-index remain the open crown work. ALL
> inherit the EfNeg-under-instantiation unsoundness, so none can be VERIFIED (only
> built) until the crown closes; the `TCont` world-index is the second spine (TIME).
> STEP 0–5 + W31 + the CROWN soundness gate (29df478) + the M1–M4 multi-shot arc + S0
> compare/hash fold leaves are LANDED — this is the remainder (the O(1) architecture,
> §5.O, is the current build-ordered layer set).
>
> **THE DESTINY AUDIT (2026-07-14, 8-subsystem adversarial ultracode workflow,
> artifact-grounded; full record in git history: docs/research/destiny-audit-2026-07-14.md)
> reframes this whole band.** The 95-peer list OBSCURES the real shape every
> auditor found independently: **machinery real, performance absent** — Mentl
> built its capabilities correctly as handlers-on-the-graph and then left the ops
> UNPERFORMED and the handlers UNINSTALLED (synth, Why, persist, Verify, IFC, the
> modal world, the LSP/IDE transports, the `repr` gradient — each a real engine no
> live loop calls). Scored against the artifact the five destiny pillars land
> ~35–40%; the gap is WIRING, not substrate. So the work is **wiring-dominated**
> (perform the ops already built — largest, cheapest), **deletion-heavy** (the
> four fold generators → one `fold(ty, leaf)` ~1200 lines; the inert kernel
> overlay drift-7; the by-name effect family), a **focused proving spine** (R2
> bind `self` live → R3 a decidable fragment → R5 gate the elision — the one new
> engine), and **one deferred big build** (native / the execution-layer
> `!Outside`). **THE CRITICAL PATH, dependency-ordered: R1** `EffName`-is-a-handle
> → the positive effect gate becomes SOUND (594 self-compile false-mismatches →
> ~0, the convergent non-negotiable root — a CORRECTNESS site the perf loop never
> reaches; §5.O layer-1 applied to correctness) → **R2** bind `self`/args to the
> live node (the value-proof pillar is zero today) → **R3** a decidable arithmetic
> fragment → **R4** wire the live felt loop (transports infer, `QWhy`→`why_expand`,
> synth-on-`NHole`-and-APPLY — highest destiny-per-line) → **R5** gate the
> narrowing elision on real discharge (latent-OOB landmine) → **R6** extract the
> `~> Backend` emit seam + fix the doc-truth debt. The single truest line of the
> audit: `synth_proposer.mn:570` says "the loop is closed"; the artifact says it
> is open.

**A · Effects & the modal crown (arm 4) — gates ownership, !Thread, IFC negation.** `Hβ.effects.sound-neg-under-poly` (the soundness GATE LANDED 2026-07-13 — `row_subsumes` EfNeg by-name membership; tests/crown/ + tools/crown-gate.sh; m2==m3 byte-identical, 66/66 micros; the open tier is the modal world-index below plus the two exposed follow-ups `Hβ.effects.positive-row-pointer-eq` and `Hβ.effects.parameterized-negation-instance`) · `Hβ.effects.modal-world-index` (rows+capabilities+negation sound simultaneously, as a graph fact; POPL-2026 cite at effects.mn:12) · `Hβ.infer.modal-capability-at-tee` (the modal rule: a row var becomes a lexical capability handle at the `~>` edge, no new surface form) · `Hβ.syntax.perform-dissolution`.

**B · Continuations & TIME (arm 2, §4④) — the binding keystone. LANDED: `Hβ.lower.continuation-reification-codegen` (the k1→M4 arc self-hosted through the fixpoint, §7); `Hβ.continuations.multishot-reexecution-driver` is SUPERSEDED (the 2026-07-11 pivot — re-execution restarts, the felt spec demands resume), `Hβ.lower.arm-internal-perform-scope` closed by the M3 lexical-evidence fence.** `Hβ.types.tcont-world-binding-keystone` (STEP 5 landed the 3-arg arity; the world is INERT on OneShot — ENFORCE it) · `Hβ.types.resume-world-mismatch-value-gate` (the runnable gate; layout-in-world coupling; DEP persist resume-catcher + STEP 1) · `Hβ.infer.tcont-world-capture-at-reify` (at the multi-shot producer's reify site) · `Hβ.continuations.world-widening-resume` (typed superset-resume) · `Hβ.continuations.persist-equals-memcpy-handler` (= `Hβ.lower.fanout-durable-persist-handler`; `~> Persist`, zero serializer; STEP 3 producer landed; the standardized multiple-memories proposal is this peer's substrate cash-out — a dedicated IMAGE memory snapshots whole while scratch lives apart, the memcpy boundary drawn by the module format itself) · `Hβ.persist.cross-machine-resume` *(new)* · `Hβ.persist.branch-world-tag` (persist.mn:119) · `Hβ.continuations.wasmfx-lowering-tier` *(substrate PROBED 2026-07-10: wasmtime 43 `-W stack-switching` + wasm-tools 1.252 assemble native typed-continuations — single suspend/resume runs (fx1→10) — but the cont is LINEAR: resuming one twice PANICS the engine (`ptr::eq(head, self)`). So native gives ONE-shot free (already fast-pathed by direct-call) and does NOT solve MULTI-shot; the multi-shot keystone is RE-EXECUTION — `cont.new(body)` fresh per resume, replaying prior performs, the trail/rollback substrate the driver — not native cloning. `perform`→`suspend`, `resume(v)`→fresh-cont resume; the emit path switches to wasm-tools for continuation modules (WABT can't assemble `cont`). This IS the producer-invocation keystone the cardinality fix unblocked — see §7)* · `Hβ.continuations.multishot-reexecution-driver` *(the re-execution driver — PROVEN END-TO-END 2026-07-11, crucibles in tests/native-cont/: native-cont `twice` → 3 (identity) and 13 (non-identity `pick()+5`, the continuation after the perform captured natively), and the same model in Mentl source → 30 through boot. A multi-shot handler is a DRIVER over re-runs: `resume(v)` = fresh `cont.new(body)` resumed to the `suspend`, then resumed with v; `suspend` unwinds the perform to the driver so the arm runs OUTSIDE the body's stack (no re-entrancy — the trap the pure-Mentl outer-install form hit). Correct for identity / non-identity / no-perform. **BUT native conts are BLOCKED under WASI `_start` (wasmtime 43, verified 2026-07-11): a single `cont.new`+`resume` under `_start` panics `ptr::eq(head, self)` — the command entry runs on wasmtime's own fiber and a user continuation violates its stack invariant; `--invoke` works, `_start` (every real program) does not, and no flag avoids it.** So native conts are the O(1) future (an `!Outside` dependency until wasmtime carries them under `_start`), NOT the shipping substrate. THE SHIPPING PATH is the PURE-MENTL re-execution driver — `resume(v)` re-runs the body thunk under a one-shot replay handler, all ordinary handlers, works under `_start`: the DIRECT form (arm logic as a driver fn, no outer install) is proven (reexec-model.mn → 30) and correct when the body performs the op unconditionally (mn-multishot). The general form (conditional / no-perform bodies) needs the ARM-INTERNAL-PERFORM GAP closed — the re-run's perform must resolve to the inner replay, not re-enter the outer handler (the pure-Mentl outer-install driver's 134 trap). THAT is the real keystone dig, `!Outside`-clean. Each rerun is a stateless fork → trivially parallel + durable, the SPACE=TIME fork §5.U scheduled by `~> Schedule`)* · `Hβ.lower.arm-internal-perform-scope` *(new — the gate under multi-shot: a handler installed INSIDE an arm body (`bt() ~> replay(v)`) must shadow the enclosing handler for performs in the re-run; today the re-run's perform re-enters the outer handler (evidence threads to the wrong install). Closing it makes the pure-Mentl re-execution driver fully correct AND fixes arm-internal effectful installs generally — core handler correctness, not just multi-shot)* · `Hβ.infer.tail-recursion-resume-cardinality` (infer.mn:5023) · `Hβ.lower.either-install-negotiation` · `Hβ.felt.time-travel-debug-forked-cursor` *(new)* · `Hβ.ml.autodiff-as-multishot` (autodiff.mn:36).

**C · `!Flow` — the crown applied to data flow (arm 4/6, §4⑥; W31 scaffold landed).**
IFC is `!E` on the data-flow lattice: prove transitively, like `!Alloc`, that a
value cannot reach a sink — `!Flow(Untrusted -> Sink)`. ONE mechanism, TWO
CO-EQUAL first-class regimes, neither a footnote to the other (crystallized
2026-07-13; the adversarial pass INVERTED the earlier instinct to demote the
agentic one): (1) **developer confidentiality/integrity in trusted code** — this
`Secret` never reaches `Log`, this request body never reaches a query string
unsanitized (the everyday superpower — the compiler discharging a data-flow
invariant like a type); (2) **integrity of untrusted inputs in agentic
systems** — an untrusted-integrity source reaching a privileged sink. Regime (2)
is not a buzzword; it is the **integrity specification** that FORCES the
mechanism's hardest, non-free requirements — the integrity dual-lattice,
PC-labels for implicit flow, robust declassification — that the benign-developer
framing silently under-specifies, and it is Mentl's actual adoption pull out of
IFC's 50-year confidentiality-for-trusted-authors zero-adoption graveyard (JIF /
FlowCaml / Paragon / LIO; Zdancewic–Myers on the confidentiality/integrity
duals). The medium states the property substrate-native — an untrusted-integrity
source reaching a privileged sink — as a data-flow-lattice fact (`!Flow`), never
as a named threat category; the vocabulary is the lattice, not the risk of the
week. Honest disclaimer a flow
lattice does NOT discharge: it cannot make a model separate data from
instructions inside its own context window — "the untrusted text reached the
model" is not itself the breach; `!Flow` proves where the OUTPUT may go, not
what the model does with its input. Peers: `Hβ.verify.ifc-noninterference`
(umbrella; code `Hβ.types.ifc-flow-constraint`, types.mn:1029) ← `Hβ.ifc.dcc-noninterference-gate` → `.flowlabel-inference-in-hm` → `.pc-label-implicit-flow` → `.integrity-dual-lattice` → `.declassify-robust` → `.flow-world-on-tcont` → `.agentic-fides-target`. DEP-rooted on `sound-neg-under-poly` (the crown — `!Flow` inherits its soundness).

**D · The value layer — fold & repr (arms 1/7, §5.U; STEP 0/1/2 landed).** `Hβ.fold.show-leaf` (synthesize as a lowered LFn, not raw WAT; lower.mn:481) · `.compare-hash-leaf` · gate `Hβ.eq.fold-seed-value-gate` · `Hβ.repr.arrow-layout-interop` · `Hβ.emit.variant-payload-repr-width` (wasm.mn:4913) · `.plit-handle-repr` (wasm.mn:5537) · `Hβ.value.ontology-derivation-complete` *(LANDED 2026-07-21 — the §7 ledger head carries the arc; the residue is the named narrowing/wide-stride/alias-edge tier. History of the derivation: DETAILED 2026-07-20 by a 13-agent adversarial ultracode pass — map + 4-design panel + per-design refutation; all four designs REFUTED, converging on ONE attractor, the truth signal. String = [byte] IS the §4① ultimate and is SOTA-validated (Rust's `str` = `[u8]` behind a fat-pointer view; Arrow's one-array-over-many-element-types with zero-copy slices; Harper–Morrisett intensional type analysis / TIL and Crary–Weirich type-erasure = "the proof becomes the dispatch"; and Haskell's `String = [Char]` cons-list disaster PROVES the representation must stay PACKED, element-projected, never the uniform list layout). BUT it is NOT a single landable change, and — the load-bearing catch — the NAÏVE type-first form SHIPS A SILENT-CORRUPTION REGRESSION THE SELF-HOSTING ORACLE IS STRUCTURALLY BLIND TO. Mechanism: `String → TAlias("String", TList(TByte))` types cheaply via the existing TAlias-peel (unify_types infer.mn:2337-2342), but then String unifies with `[a]` EVERYWHERE (today `same_ground` infer.mn:2381 makes TString unify with nothing but TString, so `map(f, "hi")` / `list_index(s,i)` is a CLEAN E_TypeMismatch — the merge removes that barrier); meanwhile the runtime keeps strings 1-byte-packed with a sign-bit view whose length relocates to +12, and lists 4-byte-strided behind a tag word — so any [Byte]-typed value that is physically a String, meeting any generic `[a]` consumer, lowers to `list_*` and reads packed bytes / the −1 view sentinel as count+tag → SILENT MEMORY CORRUPTION, no diagnostic, over an UNBOUNDED surface (every map/fold/user helper, not the ~10 enumerated dispatch sites). And `m3==m4` cannot distinguish correct from corrupt: a wheel disciplined to string-named ops on strings is emit-identical while user code corrupts — the oracle's blind spot. THE CORRECT SEQUENCE inverts every proposed design (representation FIRST, type-merge LAST): (0) add RI8 to the Repr ADT + a byte marker as zero-reader vocabulary (Law-7 no-op), and VALIDATE the repr-width-polymorphic flat leaf on WIDE elements first ([Float]/[i64] lists, RF64/RI64) where there is a clean consumer and NO header/view/discriminant collision — byte-packing is the NARROWEST, HARDEST end, not the place to start; (1) the emit consolidation DEFENSIVELY — the ~10 ==/++/show/hash/compare OUTER TString-vs-TList forks (emit_binop_for BConcat wasm.mn:3830, emit_eq_for_ty:3920, emit_cmp_for_ty:4523, the field-eq/cmp/hash + show pairs) collapse into ONE `match repr_of(elem)` nested dispatch, KEEPING the nominal TString arm so H6 still NAMES it (deleting it lets a bare `TList(_)` wildcard SILENTLY absorb former strings into `$list_eq` at 4-byte stride — H6 forces the deletion, never the sub-dispatch); (2) the runtime representation reconciliation as its own perf-measured TRANSITION — the stride-polymorphic flat leaf (load_i8 vs load_i32 by element repr: the NAMED-CALL STRIDE HAS NO RUNTIME MECHANISM today — one non-polymorphic WASM body cannot serve both strides; needs a per-repr `$index_i8`/`$index_i32` family or a runtime width carrier, the load-bearing gap `Hβ.value.seq-element-stride-carrier` — SHARPENED 2026-07-20, a SECOND adversarial pass (wf_b7ba2a2e-22c, survives=False on the type-first shortcut) proving the per-repr call-site family is INSUFFICIENT: a generic body (`iterate_from`/`map`, prelude.mn:53/63) compiles ONCE with its element a TVar (repr RI32), and emit-selection specializes only at CONCRETE sites, NEVER a type-variable element — so `map(f, aString)` typechecks under the merge then reads packed bytes at 4-byte stride (the killer, and the oracle is BLIND to it because the wheel never maps a string, so m3==m4 stays byte-identical while user code corrupts). Generic-over-packed traversal REQUIRES a runtime stride carrier (a fat sequence header read at access; word-sized elements pass by value, wide elements by reference-into-the-buffer) OR whole-program monomorphization — the TRUE keystone DEP, DEEPER than the arena, and it must be PROVEN on WIDE elements ([Float]/[i64], RF64/RI64) BEFORE String is ever minted TList(TByte). The type-merge's OWN OOM is a DISTINCT mechanism from the seq-op-row ev-slot revert — TString is a nullary sentinel (0 heap) while TAlias("String",TList(TByte)) is 2 heap records ×instantiate-clone (type-node bloat) — so the arena stance is build-and-measure PER-MECHANISM, never inherited by analogy), the view/slice unification (String's sign-bit O(1)-collapse-via-view_base vs List's tag-4 O(depth) chain), the [len][bytes] data-section literal the interner + self-compile depend on, and the concat-persistence decision (String eager materialize O(la+lb) vs List lazy rope O(1)); (3) ONLY THEN the type merge, when the runtime agrees. TWO settled truths: (a) THE fold_sig COLLISION — `fold_sig` reads `fold_strip` which strips alias/refine, so a byte-as-`Int repr i8` strips to TInt and `fold_sig(TList(byte)) == fold_sig(TList(Int)) == 'li'`, sharing generated `$eq_li`/`$hash_li`/`$show_li` helpers → silent wrong-width; the byte leaf must be a NEW NOMINAL Ty `fold_strip` does NOT strip, OR `fold_sig` must READ repr (diverging from `fold_strip` — an explicit structural decision), and §4①'s "a byte is an Int, not a new primitive" is in direct tension with fold-distinguishability — SETTLE THIS FIRST; (b) `handle_recorded` does NOT dissolve here (handle-IDENTITY i32.eq vs structural str_eq — a real split merged only by `Hβ.runtime.indexed-map-primitive`; corrects the 0fa3649b commit/PROVENANCE claim). THE KEYSTONE DEP is `Hβ.perf.per-decl-arena` (§5.O): the honest-row Alloc attribution + the ontology's self-compile allocation shift both hit the MEASURED 4GB never-free bump-image OOM (the 2026-07-17 seq-op-row-from-callee revert, infer.mn:1320-1333) — the whole dissolution waits on the arena. is_seq_op is therefore a LEGITIMATE "self-consistent raw body, typed calls" substrate boundary, NOT shameful drift-8, until (i) the arena lands and (ii) the ONE genuinely-new increment the panel converged on exists: `Hβ.infer.seq-addr-downcast` — `addr : ∀a. a -> Int`, a sound structure-forgetting DOWN-cast (negative position, concrete Int result) that lets an authored-signature runtime body typecheck (`load_i32(addr(xs))` keeps BKArith `Int+Int`), capability-gated (`with Cast` / provable `!Cast`), confined to handle-repr; the UP-cast (`str_of_buf : Int -> String`) stays the SINGLE localized identity coercion, never proliferated to a `from_addr : ∀a. Int -> a` unsafeCoerce. Retiring is_seq_op is the separate DEP-blocked `Hβ.infer.seq-op-signature-driven`, sequenced AFTER the arena AND the representation work, never as a substitute for the ontology. Full transcripts: the session workflow dir wf_79a821ca-ccc)* · `Hβ.runtime.zero-copy-string-view` (DISSOLVED 2026-07-21 — the list slice node IS the zero-copy view; the sign-bit shape is deleted) · `Hβ.emit.image-map-fold` *(new 2026-07-10 — the module's static layout as ONE fold in the emit: each region's base IS the previous region's limit (sentinel space | records | thread records | interned data | bump heap), overlap unconstructible; born from the ev_scan record clobber (a closure record at 264 sat inside io.mn's fs path scratch — two files claiming one page in prose). The fold IS band B's persist substrate: it defines what a memcpy snapshot means)* · `Hβ.io.scratch-dissolves-into-alloc` *(LANDED 2026-07-10, f0089a3 — page 0 carries no runtime scratch: every syscall record (iov / nread / prestat / filestat / fd-out) allocs per use; fs paths cross the boundary as (ptr, len) views straight into the string payload (`fs_path_view` — the old copy-into-scratch re-derived bytes the image already holds; WASI paths are explicit-length); `read_stdin_loop` + `fs_read_loop` unified into one `fd_read_loop` (stdin and opened files are the same stream); ten io fns re-rowed +Alloc; net −8 lines. The march measured the prediction WRONG in the good direction: a lib-source-only change holds m2 == m3 in ONE generation (both generations compile the same source with the same emit) — the transition form is for EMIT changes only. Gates: 52/52 boot, 8/8 + 52/52 through m2, fixpoint byte-exact, serve battle green)* · `Hβ.tools.march-transition-native` *(new 2026-07-10 — on m2 ≠ m3 march.sh runs the m4 leg itself and reports TRANSITION (m3 == m4, re-pin from m3) vs BROKEN (m3 ≠ m4); removes the bless-the-wrong-generation human-error surface — bash scaffold tier)*.

**E · Parallelism & accelerators (arm 3, §4④; STEP 4 collapse landed).** `Hβ.lower.fanout-simd-lane-cashout` (RV128) · `.fanout-gpu-backend-handler` (lower.mn:1475) · `.fanout-durable-persist-handler` (SPACE=TIME) · `Hβ.parallel.thread-alloc-transitive-proof` (verify ONLY after the leak closes) · `.race-freedom-ownership-proof` · `Hβ.infer.fanout-ownership-from-use-count` (infer.mn:1288) · `Hβ.runtime.wasi-thread-spawn-seed` (LANDED 2026-07-24 — the task-record
spawn substrate, §7 ledger; real host threads over the shared image) · `Hβ.driver.level-set-par-walk` *(the topological layer-partition is LIVE in driver.mn — 7165bbb; the open half is the multi-core `>< ~> Thread` at the layer site)* · `Hβ.cursor.speculative-compile` · `Hβ.cursor.work-stealing-via-gradient` *(idle cores ask the cursor "what next?"; the gradient's argmax IS the priority queue — no scheduler module)* · `Hβ.lower.schedule-specialized-callee` *(new — the parallel_map dissolution's open remainder: whether a reusable fn's internal `><`/`<|` should EVER inherit a caller-installed `Schedule` across a call boundary. The only sound route is compile-time specialization of the callee per install-context, preserving `Seq`'s zero-cost/`!Thread`-provable property — the §5.3 dispatch gradient's sibling on the INSTALLED-HANDLER axis (vs the known-argument axis; shares callee-specialization infra). The ambient/evidence-passed-runtime `Schedule` alternative is the wrong direction — it taxes every `Seq` fanout to buy portability only a rare `Thread` caller needs. Scoped skeptically: direct `>< + ~> Thread` at the use site is sufficient and simpler; build only when a real consumer needs one fanout helper serving callers wanting different schedules. Sequenced behind `Hβ.driver.level-set-par-walk`, DEP-gated on band-A `sound-neg-under-poly`)*.

**F · Verification & proof (arm 6/8).** `Hβ.types.predicate-is-expr` (dissolve PExpr) → `Hβ.verify.smt-handler-swap` (Z3+CVC5; NAME the external-SMT residual !Outside if it persists) → `.higher-order-refinement` · `Hβ.verify.ledger-soundness` (no silent assume-true; the Dafny `{:axiom}` cautionary) · `.proof-incrementality-cached-cursor` · `.reason-edge-pcc-certificate` · `Hβ.dsp.hz-ceiling-ambient-sample-rate` · `Hβ.refine.buffer-invariant` · `Hβ.infer.predicate-from-bool-expression`.

**G · Graph & e-graph (arm 1) — highest-leverage incompleteness first.** `Hβ.egraph.per-expr-effect-row` (egraph.mn:70 — reduces is_pure to effs_at alone, generalizing the effect-gate to every rewrite) · `Hβ.lower.egraph-saturation-deepen` · `.typed-rulecyclic` (the depth-1000 cap → a typed E_RuleSetCyclic via the Why chain, unreachable-by-construction) · `.rule-as-query` · `.extraction-cost-composes-repr` · `.const-fold-minted-node-full-edges`.

**H · Ownership (arm 5, §4⑤).** `Hβ.ownership.fractional-uniqueness-ref-borrow` (Granule OOPSLA 2024) · `.quiet-empirical-gate` (the Hylo bar — a corpus test counting authored own/ref markers; a rising count IS inference failing §4⑤).

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
  tail-resumptive (~85%) → direct `call`; static singleton → direct call, the
  record from the live world chain (`$world_find`); polymorphic → `call_indirect` via an evidence-field on the
  closure record (Koka evidence-passing, **never** a vtable); MultiShot → heap
  continuation struct + trail rollback.
- **Handler IS state IS closure** — one heap record
  (`[fn_ptr@0][nstate@4][state@8..][arms]`); the EVIDENCE role dissolved
  into the live world chain (the world-as-value arc — dispatch reads the
  install chain, never a frame region).
- **Non-ultimate by design (dissolve at L1):** the seed (hand-WAT); the bash
  scaffolds (state.sh, verify.sh, run-micro.sh, drift-audit.sh — each
  dissolves into the medium's own where/verify/audit verbs); the external
  runtime/assembler (wasmtime, WABT) — the arc to native is `!Outside`
  (§5 stage 3).

**File map (the wheel):** `graph.mn` (graph, flat-array O(1) chase) · `types.mn`
(Ty + Reason + Scheme + typed AST) · `effects.mn` (EffRow Boolean algebra) ·
`infer.mn` (HM, one walk, the write) · `lower.mn` (the projected read) ·
`backends/wasm.mn` (LowIR → WAT) · `parser.mn` · `pipeline.mn` · `mentl.mn`
(oracle/synth) · `cursor*.mn` (the felt read) · `bootstrap/src/` (modular WAT).

---

## §7 · Current state (grounded 2026-07-18) + the landing ledger

**THE BOARD IS WHOLE.** Every gate the repo owns is green — frontier 71/0,
proof-exactness 9/9, crown 5/5, micros (incl. oob-traps=134 — SYNTAX's index
law executable), the march's fixed point, the phantom ratchet (287) — through
the pinned boot (chain: boot/PROVENANCE.md, newest pin = the
lattice-completes landing). **`mentl voice.mn:9` ANSWERS** (the
cursor-address transport, tests/frontier/voice-demo the executable gate).
**The census is ZERO** (2026-07-18 end-of-day; 2,266 three days prior) —
the medium compiles its own source with NO error diagnostics, and the
ratchet holds it there: a rising census is a refusal to merge. The last
three roots fell as: the seq-op fast path staging its continuation
boundary like every application (E_UnresolvedType extinct); the
record-row residual under its OWN node kind (NRecordRowBound — NRowBound
is EffRow-only, occurs_in_row total, no cross-sort catch-all); and
slot_present, the Option-of-handle niche's READ half (the arg-slot
presence test typed `a -> Bool` at the substrate table). NINE classes reached
zero on 2026-07-18 alone: IfMissingElse, FeedbackNoContext,
EffectMismatch, PurityViolated, PatternInexhaustive, ConstructorArity,
ResumeOutsideArm, MissingVariable, OccursCheck — the forward-ref
roots are extinct (E_MissingVariable 0, E_OccursCheck 0 on the wheel — an
env miss binds NErrorHole, one miss one diagnostic), and **six diagnostic
classes are ARMED** (E_UnresolvedHole, E_MissingModule,
E_HandlerStateShadowsOp, E_DuplicateFnName, E_RefinementRejected,
E_OwnershipViolation — the armed-class contract: nonzero exit, zero WAT;
run_refusal in the frontier gate). The arming immediately paid twice: the
state-shadow check caught the wheel's own `caret` field at the m3 leg, and
the refinement class + UNeg fold caught the wheel fabricating tag -1 into
TagId's refinement (now LPUnresolvedCon). Both `??` authoring workflows are
green end to end; value-proof discharges at all three sites; every fn body
is a region and the return is a transfer. **The current cursor is §11 — the
production bar**, informed by the 2026-07-18 exhaustive harvest (23 readers
over the 113 post-first-light commits + the Codex/fleet/Opus corpus) and
the 5-lens adversarial panel that corrected the finish-line design
(scratchpad archaeology: the harvest + panel transcripts in the session
workflow dirs).

Ground FIRST: `bash tools/state.sh` (the whole board). This ledger is
prose until the medium projects repo state itself — state-as-PROJECTION is
§7's own destiny (the docs-as-projection endpoint); each line is a POINTER
(git log + boot/PROVENANCE.md hold the mechanics; the lessons live in
CLAUDE.md ⟲/§9 and the code's own comments).

### The honest audit — the ultimate form (§4/§5) vs what the artifact reaches

§4 and §5 write the ULTIMATE FORM under dream-code discipline (Anchor 0):
present tense is the *design*, never a claim the seed has caught up. This audit
is the arbiter of how-real each mechanism is, so the doc never reads as
present-tense-done (a hidden gap is drift, `CLAUDE.md ⟐`). Where a design
section and this audit seem to disagree, §4/§5 is the TARGET and this is the
STATE. (Distilled from an adversarial PLAN re-audit, 2026-07-17 —
git history: docs/research/finish-plan-codex-2026-07-17.md; its honest de-hyping salvaged
here, its wholesale rewrite and invented vocabulary rejected.)

The design present-tense the artifact has NOT reached — named so the reader is
not misled:
- **Regions** are compile-time root-tagging + the return-transfer, Hylo-quiet
  on the wheel — NOT a runtime arena and NOT an O(1) drop. The arena is §5.O's
  open work; the `emit_memory_arena` swap is dormant.
- **`persist = memcpy`** (§4④/§5.U) is the design. Today a continuation is a
  bump-allocated record, not a closed / relocatable / versioned image; durable
  execution is ABSENT as a shipping claim (bands B/O).
- **The effect-WORLD on `TCont`** (§4③b/§5.U) is INERT on the OneShot path — a
  tag carried, not an enforced exact world; the runtime value gate
  (`E_ResumeWorldMismatchWorld`) is declared and unwired (band B).
- **"O(1) is the only acceptable complexity"** (§5.O/§9.1) is the DIRECTION,
  not a built fact. The honest contract: O(1) identity chase, O(changed cone)
  incremental, O(reachable) image, O(1) reclaim-after-proof. The never-free
  bump image is the SEED's simplicity, not a law of determinism.
- **Universal executable refusal** (§11 col 2): only `E_MissingModule` is
  armed; the twelve census classes are the ratcheting work toward 0.
- **`mentl compile main`** does not yet self-serve — the import DAG omits the
  vocabulary the concatenated-wheel build supplies
  (`Hβ.driver.wheel-imports-are-the-manifest`, §11 col 2).
- **The Thread schedule is REAL** (2026-07-24: host threads over the one
  shared image, gated by the three real-spawn frontier legs); its SAFETY
  story (stateful-effect-in-fanout refusal) stays gated on band A, and a
  spawned branch's evidence-tier performs meet an empty per-instance
  world (loud, never silent). **SIMD / GPU schedules + the persist
  handler** remain scaffold / proxy — lane and device and disk are not
  yet real (bands E/O).

Everything else on the board above is measured green; this list is the seam
between the wheel and its ultimate form, held open on purpose.

### The landing ledger (newest first; · pin = boot re-pinned)

- 2026-07-30 · ▶ THE TIER'S OWN NEIGHBOURS — iteration-is-topology's
  second family, at the audit's sharpest instance (pin b1b53025). The
  selfhood audit found the file that HOSTS the verb-shape and
  iteration-shape tiers carrying four convictions of its own, two of
  them the tiers' own machinery — chain_scan (the scanner
  pipe_shape_of calls) and rest_uses, four lines above pipe_shape_of
  itself: the census landing had rewritten the tier's own body and left
  its neighbours. Both migrate: the suffix use-count is a
  `|> drop |> map |> sum` chain; the run-length scan splits into the
  two stages it always was — per-position LINKS (does stmt i feed
  stmt i+1 exactly once?) then a fold carrying the run, flushing at
  >= 2 — with the one-step exception and the twice-used silence
  preserved by construction. The tier's own gate fixtures answer
  byte-identically (the migration cannot change what the tier says).
  oracle.mn 4 → 2 convictions. THE SURVIVORS ARE NOT AN IDIOM
  PROBLEM and are named as such: count_dependents and
  collect_bound_positions walk HANDLE SPACE, and materializing a range
  at graph scale is worse than the loop — their self-form is the graph
  answering directly (a reverse-edge read, a bound-cell projection),
  banked as Hβ.graph.reverse-edge-and-bound-projection, where the
  payoff is complexity (count_dependents is O(graph) per position,
  quadratic across the candidate set) rather than vocabulary.
- 2026-07-30 · ▶▶ THE SEVERANCE VOCABULARY IS A GRAPH READ — the
  selfhood audit's F12, and the audit report's own headline executed
  (pin 1cb58126). Morgan's second dispatch ("audit all the ways Mentl
  can be more ITSELF") returned fifteen findings ranked by
  identity-leverage (.build/research/selfhood-audit-2026-07-30.md);
  its closing paragraph is the sharpest statement of the project's
  state yet written: THE MEDIUM STILL KEEPS A COPY OF WHAT IT KNOWS,
  AND THEN READS THE COPY — a scheme published as a snapshot and
  re-read by name (F4, the tower), a binding stored in a buffer with a
  string-keyed index beside it instead of drawn as an edge (F5), 390
  index-threaded loops each a copy of the position the structure
  already holds (F1), the roadmap a copy of the absences the comment
  weave carries and the frontier ranks (F7), 11,239 lines of prose a
  copy of measurements the artifact holds (F8), the drift catalog a
  regex copy of what a row states (F6) — and the five verbs' near-
  absence is the SURFACE SYMPTOM of that, not a separate problem
  ("a medium that reads copies has nothing to fan out over and no
  cycle to close — the topology is only visible once the truth is
  live"). Its cheapest item lands now: three interned literals named
  the audit's severance vocabulary while the env held every effect
  declaration in scope, so the audit could never tell a fn it could
  prove !Mutate / !WASI / !Thread, and every fn got the identical
  three-name constant where §5's felt endpoint asks for a gradient.
  severance_vocabulary FOLDS EffectDeclKind out of env_snapshot — the
  env's own "this name is an effect" edge — so a newly-declared
  effect enters the audit by construction; the literal list and its
  drift marker delete. The teaching tier leads with severances whose
  absence unlocks a NAMED capability and counts the rest (28 in the
  wheel's DAG scope), and a body with provable severances but no
  capability named still speaks rather than going silent. THE
  CORRECTNESS GAIN, measured: in a scope where IO and Network are not
  declared at all, the old line still offered "Sandbox (proven no
  network access)" — a proof claimed about an effect that does not
  exist there, and an unsayable `with !E` taught; a module declaring
  nothing now has nothing severable, by construction. The
  resident-session gate's `severable:` assertion had ENCODED that
  fabricated vocabulary (the banked-expectation-is-a-hypothesis law,
  fifth catch) — its fixture gains a declared effect so the leg tests
  the tier honestly. THE PIN MACHINERY'S OWN FIRST LESSON rode along:
  this landing marched twice, and the march stacked a second
  placeholder block on the unnarrated first — an UNNARRATED head is a
  working step, not history, so emit_provenance now SUPERSEDES a
  placeholder head instead of stacking (the chain records blessed
  pins, and blessing is exactly what the narrative is). NAMED
  REMAINDER: the capability map still knows three effects — extending
  it needs each capability's render to name WHICH severance proved it
  (CSandbox renders "proven no network access", so mapping WASI to it
  would misspeak), which is Hβ.audit.capability-carries-its-evidence.
- 2026-07-30 · ▶ THE MARCH WRITES ITS OWN PIN — the scout's move 2, the
  fabrication class deleted at its source (no pin move — tools only;
  boot stands at feccc8a9). The march HOLDS the sha, the verdict, the
  generation, the line count and the census at the moment it repins,
  and a human retyping any of them later is the class caught live TWICE
  (a sha tail completed from memory — CLAUDE.md ⊕). So emit_provenance
  writes the mechanical block itself, sha256 read from the artifact it
  just copied, and the author writes exactly ONE line: the narrative,
  replacing the march's `‹NARRATIVE UNWRITTEN›` placeholder. THE
  REMINDER BECOMES A REFUSAL: doc-truth fails while a placeholder entry
  stands, so "the pin is not blessed until the entry is written" — a
  printed sentence since the boot era — is now mechanical, and an
  unblessed pin cannot pass verify. Both legs instrument-checked (the
  insertion on a scratch copy: chain 191 → 192 entries, exact position;
  the refusal RED with a planted placeholder, GREEN restored), and the
  check's OWN first run convicted itself — an unanchored grep fired on
  the recipe prose that names the placeholder (the string-literal
  blindness class, one layer up), anchored to the entry form. The
  PROVENANCE recipe rewritten to the new ritual. Ledger-as-projection's
  first executed rung (PLAN §7's own destiny: state as projection,
  never a hand-kept prose ledger) — the remaining hand-written half is
  the narrative, which is the human judgment the projection can never
  hold.
- 2026-07-30 · ▶ THE HARNESS SPEAKS ONLY MECHANICS — the practice
  scout's first move executed (no pin move — hooks/tools only; boot
  stands at feccc8a9). Morgan's dispatch ("research improving dev
  best practices, tailored to the Claude Code workflow, until Mentl
  cuts everything that isn't Human or Mentl out of the loop") came
  back with the framing fact: THE GATE IS ALREADY ON CLAUDE'S WIRE
  (.mcp.json serves mentl-gate) AND CLAUDE'S OWN WRITE CHANNEL
  BYPASSES IT — most of the ranked moves close that gap (the full
  memo: .build/research/practice-scout-2026-07-30.md). Executed now,
  move 1 — the harness truth sweep: session-start.sh had been a
  drifted SECOND HOME for law, grounding every session on "INLINE
  ONLY" (superseded 2026-06-21) and "census is a SHADOW, enforces
  nothing" (a zero-tolerance ratchet since 2026-07-22) — stripped to
  mechanics + pointers (law lives in CLAUDE.md alone; nothing dated
  remains in the hook, so it can no longer drift); the pre-commit's
  Gate 2 silently no-opped for a week against comment-ratchet.sh
  (deleted 2026-07-22) behind its -x check — the gate-that-cannot-
  fail vacuity, deleted with its absorption recorded in place, and
  the phantom determinism-gate.sh cite trued to the march;
  doc-truth's named-command sweep now covers .claude/hooks/*.sh +
  .githooks/pre-commit (the third party's instruction surfaces are
  reader-facing docs). BANKED from the scout's ranking: move 2 — the
  march writes its own PROVENANCE block at repin (sha/verdict/lines/
  census machine-emitted, the narrative human; deletes the
  twice-caught sha-fabrication class — ledger-as-projection's first
  executed rung); move 3 — widen the MCP/session verb surface
  (check/test/fmt/march/frontier) and rewire post-edit-mn.sh to
  session-backed whole-weave judgment (the every-proposer-through-
  the-gate channel; rides the convergence tax until
  schemes-are-edges). Outward finds banked: vericoding benchmarks
  arriving (VeriBench, Dafny-2026) — the absence benchmark's
  empty-podium claim re-verifies before the next positioning pass;
  none measures proving the NEGATIVE. The Opus selfhood audit
  ("all the ways Mentl can be more ITSELF") is still running.
- 2026-07-30 · ▶▶ THE FIRST FAMILY MIGRATES — iteration-is-topology
  executes its first family, and the migration's own red teaches the
  recipe's pin (pin feccc8a9). The law now lives in all three docs
  (CLAUDE Anchor 6's method statement, SYNTAX's token-note surface
  clause, PLAN's ledger + peer — one home per projection). THE FAMILY:
  pipeline's cold render/set walks — six index-threaded loop fns
  (owner_names_of · absent_from_loop · name_in_list_loop ·
  severance_unlocks_loop · caps_not_in · cap_in · ref_span_lines)
  DELETED whole into map/filter/any/fold; the tier's file count
  18 → 11; the wheel 55 lines smaller (the law smiling). THE RECIPE'S
  LOAD-BEARING PIN, paid for in one measured red: under the Stage Law
  the datum infers LAST, so a datum-last lambda's bare `==` word-floors
  to pointer-eq while its element is still free — EffName membership
  went always-false, everything read "absent," and Alloc was offered
  severable on allocating rows; the severance-honest frontier leg
  (its own prior landing's gate) caught it in ONE run — the gate
  catching the migrator, the two-oracle law live. One typed operand
  (`target: EffName`) restores the structural dispatch (the
  either-operand law); the recipe states it permanently: a datum-last
  lambda doing ==/arith on the element states the element's type
  (the annotated-helper discipline, until monomorphization covers
  datum-last free lambdas). Hot-path convicts (env_bucket_pos, the
  gate scans) stay deliberately unmigrated — their families move
  only under their own perf measurement. Morgan's two dispatches ride
  this arc: the Fable practice scout (dev-practice research toward
  the closed-loop terminus) and the Opus selfhood auditor ("all the
  ways Mentl can be more ITSELF") run in the background, reports to
  .build/research/. Board whole: frontier 329/0; micros 121/0;
  proof-exactness 9/9; crown 5/5; census 0; CLEAN m2 == m3 at
  354,506 lines.
- 2026-07-30 · ▶▶ ITERATION IS TOPOLOGY — Morgan's interrogation of
  recursion itself becomes a law, a measurement, and the audit's next
  tier (pin d949fa7a). THE QUESTION ("was recursion even the correct
  thing for Mentl? has it tainted us?") and THE HONEST ANSWER: the
  recursion idiom was Claude's ML/Scheme import, never a decision the
  medium made — SYNTAX declared the true model at birth (no loop
  keywords; iteration is |> stages, <~ cycles, Iterate handlers) and
  the wheel's body speaks Scheme with a Mentl accent (census: 373
  vocabulary call sites against hundreds of hand-rolled index loops;
  28 <~ uses, almost all in the DSP lib). THE DEEP BILL: the entire
  convergence tower is recursion's invoice — name-keyed mutual
  recursion is what makes the judgment cyclic and schemes into
  snapshots needing iteration; Faust (the verbs' own validator) has no
  recursion, one <~-typed-locally cycle form, and single-pass
  compilation. THE ULTIMATE MEDIUM'S ITERATION STACK, read off the
  kernel: (1) structural iteration = DERIVED folds over the five
  node-kinds — total, terminating, generated never authored; (2)
  cyclic dataflow = <~, the cycle drawn once as an edge, typed by the
  local recurrence rule; (3) unbounded search = handlers + multi-shot
  (iteration as resumption — the oracle's own form); (4) named general
  recursion = the priced residual (the signature-price law
  generalizes: it is the price of name-keyed recursion, period). THE
  TIER: recursion_shape_of (oracle.mn, beside pipe_shape_of) convicts
  a self-call threading an incremented index over the fn's own param —
  structural over the one total child projection; derived-fold-shaped
  recursion (recursing on children, never counters) stays silent. Its
  first wheel census: 390 convictions — the migration queue, measured
  by the medium itself (the name grep guessed 78). Two live catches
  during the build: the tier's own first form convicted itself
  (args_thread_index was index-threaded — rewritten in the vocabulary
  it preaches), and the first probe's verdict was the PROBER's error
  (a grep window too narrow to reach the tier's line — forensic law 2,
  counted; the tier was correct from its first march). THE ARC
  REFRAMED: schemes-are-edges lands into a wheel being drained of
  name-cycles — "shrink recursion until the judgment has nothing
  cyclic left to iterate"; the migration (costume families → folds /
  each / iterate / <~ / drivers, march-arbitrated per family) is the
  named peer Hβ.wheel.iteration-is-topology. Two-face frontier leg
  registered; frontier 329/0; micros 121/0; proof-exactness 9/9;
  crown 5/5; census 0; CLEAN m2 == m3 at 354,538 lines.
- 2026-07-30 · ▶▶▶ THE CYCLE DISCIPLINE — the schemes-are-edges arc
  opens at its foundation: monomorphic recursion by default, the
  signature price for polymorphic recursion (pin 4e8eb504). At group
  entry an unsig'd Tarjan-cycle member's env view re-registers with
  its TYPE cells SHARED — Forall over only the row-sort quantifiers of
  the same pre-registered skeleton — so an intra-cycle forward use
  TEACHES the callee's actual param/ret cells instead of discarding
  its demand into a fresh copy (the disconnected-vars class): this is
  NOT tower machinery — no probes, no freezes, no joins — it is
  union-find propagation as the cycle's constraint channel, the edges
  model's own form for cycles, and it SURVIVES the tower's deletion
  as the cycle judgment. The full-mono first form was convicted by
  the wheel in one march (five E_EffectMismatch — application-site
  row unifies contaminating callee rows through the shared row cell;
  the directional-edge law's class), so ROW handles stay quantified,
  freshening per use. A fully-annotated member (every param + return
  authored — lowercase params being the DECLARED polymorphism) keeps
  its quantified pre-registration: polymorphic recursion by intent.
  The group-exit sweep re-generalizes every member over the group's
  resolved cells (an early member's final carries a late member's
  resolution instead of quantifying a then-free var the frozen-read
  law would forever freshen). MEASURED HONESTLY: census 0 at every
  generation (zero wheel cycles pay a type-side mono price);
  TRANSITION m3 == m4 at 353,904 lines; the board whole (micros
  121/0, frontier 328/0, proof-exactness 9/9, crown 5/5) — and the
  bound-hit mover (parse_effect_list_from) is UNMOVED: its flip is
  ROUNDS-resident (each round's re-parse + re-judgment regenerates
  it; no trial-side seed can clear a rounds-side oscillator). The
  measurement sharpens the arc: the rounds' DELETION is the cure —
  trial-as-the-judgment + one verification pass + the reporting
  final — and this discipline is its prerequisite (the rounds can
  only delete when the trial's cycle finals are trustworthy, which
  is exactly what landed here).
- 2026-07-30 · ▶▶ THE VET — Morgan's charge ("re-judge? re-infer?
  re-derive?") audits the 24-hour window against Carried-Truth + the
  eight interrogations; the tower brick reverts and the gate learns
  the whole grammar (no pin move — boot stands at f09e54a3). THE HEAD
  CONVICTION: the SCC generality-join iteration — built whole this
  session, marched to a self-stable TRANSITION (355,307 lines, census
  0) — REVERTED uncommitted: the one bound-hit mover survived it and
  the attractor moved 107k lines unarbitrated, and the deeper verdict
  is the direction itself (probes that re-judge, freezes that
  snapshot, joins over re-derivations are the tower the residue index
  already sentences to deletion; the third counted kill is banked in
  the movers entry, and the arc redirects terminally to
  Hβ.infer.schemes-are-edges). THE SECOND CONVICTION, named with its
  fix: scope_localize (the diagnostic-localization landing) reads the
  structural span honestly but then performs STRING SURGERY on the
  rendered line — re-rendering show_span to measure the tail it
  slices, an accident-invariant (every line must end with exactly
  that tail) and two renders of one fact; the fix is structural and
  small: diag_report already carries the DIAG to the terminal arms,
  so the span tail renders AT the terminal arm from the structure in
  hand (diag_line drops its tail; root + mcp collectors append
  through one shared projection) — named
  Hβ.diag.span-tail-at-terminal-arm. Counted as tower compensation
  (dissolves with schemes-are-edges): the refs facet's span dedup and
  the enumerators' latest-mint-wins dedup both exist because rounds
  re-mint generations. THE CLEAN SLATE, verified commit by commit:
  repr-pin (width stated once, read live via repr_of's one arm),
  as-pattern (the binder's cell IS the scrutinee's — one unify edge),
  record-rest (DELETED the pattern-subset index bake), the interval
  legs (authored constraints stored as values are source truth, not
  cached derivations), the authored rows at the parser SCC (signature
  prices, true on their own merits). THE GATE FIX riding the vet:
  march-gate's micro reader knew half the fixture-contract grammar
  and failed four refuse fixtures as headerless — it reads
  `// expect: refuse E_Class` now (pass iff the class reports), and
  the tier runs 121/0. The law's own demonstration: the census caught
  the fabricated Fresh(0) reason in the reverted build's freeze skip
  before any commit; Morgan caught the architecture.
- 2026-07-30 · ▶▶ THE WIDTH IS AN INPUT — SYNTAX's representation pin
  is real, and the census named every walk in one march
  (pin f09e54a3). `type Coeff = Float repr f64` parses
  (parse_repr_pin probes the `repr` ident after ANY type-decl base —
  the medium's noun stays a word, the handle/turbofish precedent) and
  the bare-width atom (`k: f64` / `f32` / `i64` / `v128`) mints the
  SAME TReprPin(Repr, Ty) — the fifteenth Ty constructor, arm 7's
  authored INPUT as a graph fact. The law at every layer: identity is
  the BASE's (unify peels the pin in RN.2's exact shape, a var
  binding the PINNED type so repr_of chases to the width; fold_strip
  strips it so every dispatch sees the base; same_ground recurses),
  and repr_of's own arm is the ONE width reader — annotation, never a
  type. H6 did the sweep's work: the first march's census convicted
  all SIXTEEN exhaustive Ty walks by weave line (occurs_in · fp_ty ·
  same_ground · chase_probe_tag/chase_changes/chase_deep_build ·
  free_in_ty · subst_changes/subst_ty_build · ty_handle_of ·
  extract_row · enumerate_typed · fold_sig · show_type ·
  query_flow_label · render_type_tokens, plus ty_lo's unflagged
  straggler), each gaining its transparent arm — the
  census-names-the-walks feedback at full width. The formatter is the
  parse's inverse both ways: a bare atom renders bare, an alias pin
  renders its suffix. RF64-on-Float is the fully-live pin; i64/f32/
  v128 carry whole vocabulary with their emission cash-outs riding
  the named wide-producer residue, and fold_strip's arm banks band
  D's fold_sig-reads-repr reopening for the first wide-int producer.
  Fixture mn-repr-pin runs 42 (RED on the prior boot: `repr`/`f64`
  refused as unknown names); SYNTAX's lathe-lag note trued. CLEAN
  m2 == m3 at 353,220 lines; census 0; frontier 328/0;
  proof-exactness 9/9; crown 5/5.
- 2026-07-30 · ▶▶ THE WHOLE VALUE AND ITS PIECES — SYNTAX's as-pattern
  is real end to end (pin 010fc317). `name @ pat` parses (the TAt peek
  after a lowercase pattern ident), types (the binder's cell IS the
  scrutinee's — one unify edge, so the name carries exactly the
  matched value's type — then the inner walks the same handle),
  lowers (LPAs, the inner keeping the scrutinee's type through
  lower_pat_typed), and emits (the predicate is the inner's alone —
  the binder never affects matching; the bind stores the whole value
  at the pattern's path before the inner's binders; the local at the
  pattern-binder word floor). The whole walk family gained its arms
  in one sweep with the census catching the single wrong guess
  (render_pat → render_pat_tokens). SYNTAX's lathe-lag note trued.
  Fixture runs 47 (mn-as-pattern — `e @ Click(x)` feeding both
  altitudes to one arm; the frontier leg registered). CLEAN m2 == m3
  at 351,914 lines; census 0; frontier 327/0; proof-exactness 9/9.
- 2026-07-30 · ▶▶▶ THE REST COMES TO RECORDS — SYNTAX's documented
  `{name, ...rest}` pattern is real end to end, and the sweep fixes a
  latent wrong-slot class as its rider (pin 7932c192). The parse
  mirrors the list rest's at_ellipsis arm; infer binds the rest to a
  record carrying the SAME residual row the open pattern constrains
  (mk_record_open([], row_h) — resolution flows by construction);
  lower_pat_typed resolves the receiver's full sorted field set
  (structural TRecord, or nominal through nominal_record_fields — the
  judge convicted the first TName three-field guess: arity 2, the env
  channel is the truth) into residual (field, src_index) specs; emit
  BUILDS the residual record (alloc + word-slot copies, the declared
  rest local doubling as the build accumulator — no scratch spent)
  and the rest's own field access reads the residual's layout. THE
  RIDER: the named fields' offsets now read their TRUE full-set
  indices where the receiver resolves — the pattern-subset index bake
  (`4 × pattern-index`) was the wrong-slot class at the pattern
  layer, pre-existing. An unresolved receiver floors loudly
  (resolved-or-loud); nested rests ride the same floor until the
  receiver threading deepens; word-width copies inherit the named
  f64-aggregate-pattern-width residue. SYNTAX's lathe-lag note trued
  in place. Fixture runs 30 (mn-record-pattern-rest, the frontier
  leg registered); CLEAN m2 == m3 at 351,099 lines; census 0;
  frontier 326/0; proof-exactness 9/9.
- 2026-07-30 · ▶ A CAPABILITY UNLOCKS ONCE + two stale items counted
  (pin ec1d4664). The audit's severance line concatenated per-effect
  unlock lists undeduped — IO and Network both unlock CSandbox, so
  "Sandbox (proven no network access)" rendered twice per fn severing
  both; severance_unlocks dedups by structural == over the nullary
  ADT. AND the queue healed itself twice, measured before building:
  `mentl <unknown-verb>` exits 2 (the exit-code sweep had already
  landed the refusal the space-era note asked for), and the abs-path
  audit answers identically to the relative form (the shim's
  path-derived mount + the verb rewiring healed it) — both
  observations retired as stale, zero code. CLEAN m2 == m3 at
  349,509 lines; census 0; frontier 325/0.
- 2026-07-30 · ▶▶ THE DIAGNOSTIC SPEAKS THE USER'S LINE —
  Hβ.diag.file-local-span-render RESOLVED at the register
  (pin 4aa1f090). scope_localize rebuilds diag_line's one `at <span>`
  tail in the user's coordinates whenever the span falls inside
  ScopeAt's range — a pure string/ctor read in the root arm (the span
  needs no graph world; the register's range IS the subtraction, so
  the per-line seam walk the debt renderer measured as crc-class cost
  never enters this path). With the quiet-discovery landing beneath
  it, the whole check-path chain is: the discovery parse absorbs →
  the weave parse reports once → the register localizes — a line-2
  type error renders ONCE at 2:19 where the DAG path had printed
  twice at weave 5730 (the localize frontier leg banks both faces;
  325/0). ScopeAll (the census channels) stays weave-native by
  construction. CLEAN m2 == m3 at 349,406 lines; census 0;
  proof-exactness 9/9.
- 2026-07-30 · ▶ THE DISCOVERY PARSE GOES QUIET — the report doubling
  dies at its source (pin 0b3d9348). driver_extract_imports' throwaway
  bracket gains ~> diag_quiet (the trial's own absorption policy): a
  structure read is not the reporting pass, its file-local spans are
  unplaceable, and the weave parse re-reports every diagnostic
  placeably — every parse diagnostic had printed TWICE since the DAG
  path was born (measured all day as the 2:24 + 5730:24 pairs; ONE
  now). The fn's declared row drops the Diagnostic it no longer
  carries. The surviving coordinate is the WEAVE span — the
  Hβ.diag.file-local-span-render residue rises in priority with its
  design sharpened: the seam render exists (span_render_local) but a
  per-line seam walk at census scale is the crc-class cost, so the
  render-side subtraction reads the REGISTER's own range, never a
  per-diagnostic seam walk. CLEAN m2 == m3 at 349,099 lines; census
  0; frontier 324/0; proof-exactness 9/9.
- 2026-07-30 · ▶ THE STRING NAMES ITS OWN LINE —
  Hβ.lexer.string-newline-refusal RESOLVED (pin ec3bc868). A raw
  newline in a SINGLE-line string literal reports P_UnclosedConstruct
  at the string's own line with the `"""` teaching, terminates the
  literal, and leaves the newline unconsumed — productive-under-error
  at the lexical layer — where the swallow had run to the next quote
  or EOF and surfaced as a brace complaint lines away (measured: a
  line-2 error reported at 6:1; the fmt hook itself then witnessed
  the new diagnostic firing on the banked fixture's own line). The
  triple scanner is its own chunk walk, untouched; the wheel carries
  ZERO of the narration (the fmt string-atomicity law had kept
  content newlines out). CLEAN m2 == m3 at 349,088 lines; census 0;
  frontier 324/0; proof-exactness 9/9; mn-string-newline banks the
  refuse contract.
- 2026-07-30 · ▶▶ THE QUIET FN FITS UNDER THE CAP —
  Hβ.effects.directional-fn-row-edge RESOLVED at its measured scope
  (pin cd43c23c). The call edge's fn-arg row meet goes DIRECTIONAL
  where the param's declared row is a CONCRETE cap (closed or the
  !-stance EtAll): fn_arg_directional_positions meets non-row
  components symmetrically, the TOP rows by row_subsumes(arg, param),
  and masks the position from the wholesale unify (a fresh slot — the
  symmetric equality never re-runs). A Pure fn now admits where a
  `with Tick` fn is expected — the banked RED runs 7 — while the
  noisy-into-narrow refusals stand (hof-row-gate's leg + the
  Tick-vs-Pure face, both measured same-day). THE SCOPE WAS PAID FOR:
  the first form masked VAR-tailed param rows too, and the wheel's own
  census convicted 297 sites in ONE march — the effect-polymorphic
  channel (map's f) is a FLOW the arg's row must unify into, never a
  cap to subsume under; row_cap_form is that boundary, written where
  the 297 taught it. TRANSITION m3 == m4 at 349,013 lines; census 0;
  frontier 324/0 (the admit leg registered); proof-exactness 9/9;
  crown 5/5. The nested-variance tail (a fn-arg's OWN fn-params flip
  direction again) stays out of scope by the peer's own sequencing.
- 2026-07-30 · ▶ THE SUMMIT WAS ALREADY PROMOTED — the fmt-canonical
  page closes as a measurement, not a ceremony (no pin move; boot
  a62b1299 stands). The whole-wheel fmt sweep (every src + non-tutorial
  lib file through the verb) found the tree at the fixpoint except
  own.mn's 8 reflowed lines — the pre-commit fmt rung has been
  promoting the canonical form file-by-file since it landed, so the
  queued "summit promotion" dissolved into practice already in
  motion. The last file lands; the march is byte-identical; the fmt
  summit's swap-gate ledger item is CLOSED by the artifact's own
  state.
- 2026-07-30 · ▶ TWO ROWS SHARPEN TO THEIR INTENT — the third marker
  wave (no pin move — comment/tools only; boot a62b1299 stands). Mode
  7's naming-tell anchors to the let-tuple destructure (a CTOR's
  payload binders legitimately carry the _h handle convention — the
  BoundaryEdge record's own fields had demanded 17 markers under the
  bare-pair form), and mode 3's string-keyed row anchors to the
  COMPARE/arm adjacency (`== "IO"` / `"IO" =>`) — the bare literal
  inside `intern_str("IO")` is the NEW shape, the canonical name
  entering the intern once, and the old row fired on the cure. Four
  families strip (positional-destructure, same-as-above,
  literal-NAMES-the-effect, pre-warm-names): markers 161 → 136; day
  total 269 → 136 (49% of the eradication charge executed through
  precision, never through suppression). Full-wheel audit CLEAN; the
  march byte-identical.
- 2026-07-30 · ▶ THE AUDIT GAINS THE CODE CHANNEL — the string-literal
  blindness dies structurally, and the second marker wave strips (no
  pin move — comment/tools only; boot a62b1299 stands). Code-channel
  patterns scan a STRIPPED TWIN (string contents → "", // tails
  removed, line count preserved; reports and the suppression walk
  cite the original), so a keyword grep can never fire inside an
  emitted WAT string or a prose sentence again; content-targeting
  rows (modes 3/9/10-strings/14/37) declare `raw` and scan the
  original — the twin itself taught the split when the strip
  COLLAPSED every string to the empty-string tell and mode 10 fired
  22 false hits (the string-CONTENT patterns are raw by nature).
  Same-line suppression reads the original (the twin's stripped
  marker was invisible to the text filter — measured, fixed).
  Markers 180 → 161 (WAT-instruction-text, output-literal, and
  Reason-string families); day total 269 → 161. Full-wheel audit
  CLEAN; the march byte-identical.
- 2026-07-30 · ▶ THE FIRST MARKER FAMILY DIES INTO THE MEDIUM — mode
  33 retires and its 89 suppression markers strip (no pin move —
  comment-only, the march byte-identical; boot a62b1299 stands). The
  let-where-pipe grep could pattern-match one line and demanded ~80
  hand markers ("sequenced effectful read") to suppress its blindness;
  its successor is the audit verb's verb-shape tier (pipe_shape_of,
  landed 2026-07-29), which counts USE EDGES through the total child
  projection and honors the sequenced-effectful and reuse exceptions
  STRUCTURALLY. The grep row deletes from drift-patterns.tsv with its
  retirement recorded in place; the full-wheel audit runs CLEAN with
  zero coincidental shielding (no other mode fired on the
  now-unsuppressed lines). Markers 269 → 180; the remaining families
  (WAT-instruction-text ×14, the BoundaryEdge positional destructures
  ×13, the tail) each retire when their medium-side successor exists —
  Hβ.audit.drift-modes-read-the-row's per-family ratchet, first
  family executed.
- 2026-07-30 · ▶ THE REFERENCE ENTERS ONCE AND SPEAKS LOCALLY — the
  refs facet's generation dedup + the seam projection's one home
  (pin a62b1299). The collector dedups by SPAN (a reference's
  identity is its source location; the converged rounds' re-minted
  generations rendered one reference FOUR times, measured), and the
  seam family moves to types.mn (module_seams / span_render_local
  beside show_span) where the verify debt lines and the refs render
  both read it: `refs of bump` answers one located line in the
  developer's own coordinates. CLEAN m2 == m3 at 348,397 lines;
  census 0; frontier 323/0; proof-exactness 9/9.
- 2026-07-30 · ▶ THE DEBT SPEAKS THE DEVELOPER'S COORDINATES — the
  four-times-paid hand map becomes a projection (pin 852c34dc). The
  pending ledger's spans render as `path:local_line` through the
  graph's own NModule seams (debt_module_seams reads the span log
  once; the driver minted one NModule per woven file at discovery —
  the same seam truth the comment re-homing pass reads); a seam-free
  blob weave (stdin, the march) renders the raw span by construction.
  The DAG face measured: `tests/frontier/mn-verify-interval:29`
  where the weave's 5709 stood. Retires the session's named
  weave-span→file:line confession (⟳(2) — the fourth hand-pay was
  this landing's own trigger). CLEAN m2 == m3 at 348,178 lines;
  census 0; frontier 323/0; proof-exactness 9/9.
- 2026-07-30 · ▶ THE DEBT NAMES ITS PRODUCER — the voice annotation's
  placement trade (pin 44877c73). resolve_cursor_target gains
  `current_handle: Handle` + `-> Handle`: the Caret ctor's
  consumer-edge pend discharges through the adopted return alias and
  the producer's own return pends at its decl — count holds 11, but
  the ledger now attributes the missing proof to the fn that MINTS
  handles (its match leaves are transparent-position VarRefs the
  two-face law correctly refuses to type-read; the honest cure is the
  authored-payload read, the same family as the self-call IH). CLEAN
  m2 == m3; census 0; frontier 323/0.
- 2026-07-30 · ▶▶ THE LET ANNOTATION BECOMES A CONSTRAINT — a measured
  judgment hole closes, and the interval arc takes its first wheel
  debt (Hβ.infer.let-annotation-base-unify RESOLVED · pin 30194578).
  THE HOLE, probe-first: `let x: Int = "hi"` compiled CLEAN —
  apply_let_annotation only verified the refinement; the value cell
  never met the annotation, so the base-type half of "the `: T`
  annotation is a CONSTRAINT" (the code's own promise) was decorative,
  and an annotated alias could never reach a consumer edge (the lexer
  annotation's arg echo starved on exactly this — measured as a
  12 → 12 wash before the edge landed). THE LANDING, three moves in
  the licence's order: constraint FIRST (the uncontaminated read),
  the base unify (the mismatch refuses — mn-let-ann-pins banks the
  refuse contract), then the REPRESENTATIVE REBIND (the decl pin's
  most-refined-member law at the let: a concrete-bound value cell
  cannot adopt through concrete-meets-refined, so the refined form
  re-binds as the class representative — the third measured face of
  the one peel root, after the rec-callee publish and the param
  census). THE CHAIN'S YIELD: lex's `let n: ValidOffset =
  byte_len(source)` discharges its own obligation through the len leg
  (the first wheel-internal interval discharge) and the lex_from arg
  edge echo-stops through the adopted alias — wheel debt 12 → 11.
  Census 0 at every step (zero wheel lets lied); CLEAN m2 == m3 at
  347,287 lines; frontier 323/0; proof-exactness 9/9; the battery
  carries the new refuse contract. The remaining five `0 <= self`
  survivors keep their named routes in the residue index.
- 2026-07-30 · ▶▶ THE AUTHORED RETURN RIDES AS A VALUE — the interval
  fragment's callee leg goes live cross-fn (pin 5e34f710). An authored
  `-> RetTy` rides the pre-registered TFun as the resolved Ty VALUE
  instead of the bound cell (pre_register_fn_sig's ret_component): a
  value inside the record cannot be class-contaminated, so
  callee_ret_lo reads the callee's own annotation verbatim at every
  call — `fn wrap() -> Nat = base()` discharges through base's
  declared Nat, the assume-the-signature induction with nothing to
  launder. The discriminating probe that drove it: wrap DISCHARGES
  while the self-call (seek) still pends — so the failure was never a
  peel window (the prior entry's theory, corrected in place) but the
  callee read hitting a TVar ret, and ty_lo keeps NO TVar arm BY
  DESIGN: a chased ret var reaches the obligation's own class through
  tail-call merging, and an unannotated tail callee granted that read
  would launder (the g-case — `fn f() -> Nat = g()` with g free must
  pend at f, and does). The SELF-CALL IH is the named remainder with
  its exact sound discriminator banked (callee-class == DECL-class —
  class-vs-TARGET is the launder, class-vs-DECL is exact; needs
  graph_root_of + a Predicate carrier). The cell still binds for
  forward-ref grounding; infer_fn's unify against the pre-scheme
  keeps semantics — TRANSITION m3 == m4 at 347,173 lines (the
  105k-line m2/m3 diff is the representation crossing one
  generation); census 0 at every generation; frontier 323/0
  (the fixture grows the wrap/base faces, runs 28, still exactly two
  honest pendings); proof-exactness 9/9.
- 2026-07-30 · ▶▶▶ THE INTERVAL FRAGMENT AND THE FLOW LICENCE — Verify
  grows its first inference leg, and the dig kills a measured
  refinement launder (Hβ.verify.interval-fragment's engine half lands ·
  pin a71ebbcb). THE SOUNDNESS KILL first, witnessed at runtime: the
  typed-identity echo-stop read CLASS membership as proof, and the
  arith unify puts a computation's result in its operand's refined
  class — `fn wild(v: Nat) -> Nat = v - 1` accrued NOTHING and
  `wild(0)` ran to -1 through a `0 <= self` return (wasmtime's own
  "invalid exit status" the witness). value_flows_class is the
  licence: typed identity holds for value-FLOW nodes (a var, a call
  result, a join — the value IS a class member's value, covered by
  that member's own boundary obligation) and NEVER for a computation
  (BinOp/UnaryOp mint a NEW value whose membership is a theorem) —
  computations raise, at both readers (the accrual echo-stop and the
  synth-gate admit). THE ENGINE: a lower-bound read over node
  structure slotted into compare_decide_at's None path (verify.mn
  wholly; the arm row unchanged — the decide family already carries
  the superset). TWO FACES under one contamination law, the build's
  own second kill: the single-face walk's type-identity leg
  re-laundered `v - 1` by reading the obligation TARGET's class — the
  annotation's unify had just entered it — so the transparent face
  (the target + if/match/block joins, whose cells unify with the
  target's) reads STRUCTURE only (literals, joins, the len/byte_len
  floor), and type reads live where the class boundary is crossed: a
  BinOp's operands (cells merged with the arith ground, never the
  target's) and a call's bound off the CALLEE's published TFun return
  (the assume-the-signature induction). MEASURED on the fixture
  (mn-verify-interval, 21): cap discharges (if-join + len), bump
  discharges (Add + opaque type read of the refined param), wild
  pends visibly and still runs, seek pends as the named peel-window
  residue (its return constraint runs inside the ann-unify's peel,
  before the most-refined rebind — the rec-call's published bound not
  yet readable there). The frontier leg asserts EXACTLY TWO pendings
  — fewer is a re-launder, more is a lost discharge. RIDES WITH IT,
  the session's third find: image_pack's transient doubling crosses
  the allocator's SIGNED-2GB boundary (807MB packed clean, 1017MB
  trapped in alloc — the banked "wire doubles the image" residue
  firing as a hard 134 that killed the compile), and a best-effort
  cache must never kill the compile: driver_warm_persist skips loudly
  past 960MB (the capacity dissolves with the per-decl arena's
  image/scratch split). Wheel debt holds 12 with ZERO new accruals
  under the licence (the wheel launders nothing); the six `0 <= self`
  survivors are the annotation sweep's targets (the peer's remaining
  half, with the peel-window fix its sharpest single). CLEAN
  m2 == m3 at 347,171 lines; census 0; frontier 323/0;
  proof-exactness 9/9.
- 2026-07-30 · ▶▶ THE COMMENT COMES HOME AT THE SEAM — the weave's one
  cross-module attach class closes at the layer that owns the seams
  (Hβ.parser.comment-attach-module-boundary RESOLVED · pin 997684f1).
  The parser attaches prose over ONE seamless weave — correct
  single-file semantics, structurally blind to module boundaries — so
  a lib file's tail comment attached forward to the NEXT module's
  first decl, and the entry's own fns rendered kernel prose as their
  Lede (the felt face the ghost-addr dig surfaced). The seam truth
  arrives with the driver's ranges, so the re-homing lives THERE, not
  as a parser patch: the NModule fold collects (line_start, nlines,
  handle) triples, and rehome_seam_comments walks the parse span log
  re-homing any comment whose OWN span's module differs from its
  attached node's module — target the comment's own module's NModule
  cell (a module has at most one file tail; the cell never collides).
  THE DIG'S TWO OP-LAYER FINDS, each a Carried-Truth violation at the
  column: (1) the comment column STORES (text, span) — the attach
  writes both — but the read projected text only, so the comment's
  own address was unreachable; graph_comment_span_at is the sibling
  projection (one op per fact, the parse_span_of idiom — never a
  pair-widening that taxes format.mn's fifteen text-only readers).
  (2) attach MERGES behind existing text (the blank-separated-blocks
  rule), so "clear by empty attach" PREPENDS an empty paragraph and
  keeps the prose — graph_clear_comment is the honest take-side,
  restoring the column's own absent form. Felt face measured healed:
  the fixture entry's 1:4 projection carries no lib Lede. CLEAN
  m2 == m3 at 345,371 lines; census 0; frontier 322/0;
  proof-exactness 9/9; lede-demo green (own-prose attach untouched).
- 2026-07-30 · ▶▶ BOUND BEATS GHOST AT THE ADDRESS — the head-anchored
  decl-span defect's felt face closes (pin 4f477b1f). The measured
  face, RED-banked live through the prior pin: `mentl main.mn:1:4` (a
  column inside the decl's NAME) rendered `width( : t76439@e54117 /
  Why: placeholder` — the tightest-containing rule let a never-judged
  parse cell over the name beat the decl itself. ONE ordering axiom
  above the area rule, column mode only: a BOUND cell beats a ghost
  (address_bound — the graph's own "was anything proven here" read,
  one chase); a `??` node is typed, hence bound, so the hole's reach
  is untouched, and every prior address behavior survives where no
  ghost competes. The healed face projects the decl's full eight
  aspects with the Why at its own line. The frontier gains the
  decl-name address leg (both faces seen — 322 legs); the perimeter
  hook's lead-strip learns cd-prefixed compounds (its third
  over-block class closed). CLEAN m2 == m3; census 0; frontier
  322/0; proof-exactness 9/9. The named cousin stays open:
  Hβ.parser.comment-attach-module-boundary (the healed Lede shows a
  lib tail-comment attaching across the module seam).

- 2026-07-30 · ▶ THE HANDLE PRODUCERS OPEN — the 0 <= self sweep's
  first pair (no pin move — emission-neutral; boot dd8a70f1 stands).
  handle_at_span / scan_for_span gain `-> Handle` (the scan's miss
  default is the ground 0, its hit the walk counter): the transport's
  three re-demanded Caret/pin boundaries collapse to ONE honest
  producer pend, handle_at_span discharging by typed identity through
  its callee. Whole-weave debt 14 → 12; the day's Arc 3 arc
  138 → 12 (91%). The remaining twelve, classified at their sites:
  six 0 <= self (the Cursor-field chain, make_list's capacity,
  resolve_cursor_target, the render_at family — each its own short
  producer walk), three span_valid producer/construction pends
  (span_join, span_zero — the banked unfold's fixtures — and the
  module-mint), TagId ×2, Sample ×1. CLEAN m2 == m3; census 0;
  frontier 321/0; proof-exactness 9/9.

- 2026-07-30 · ▶▶ THE PROBES GRADUATE AND THE VERDICT CORRECTS ITSELF
  (pin dd8a70f1; this entry RETRACTS its own first conclusion in
  place, per ⟲ — the pin's commit message carries the era's wrong
  reading). The bound-hit channel gained two graduated probes —
  probe_entry_hist (the mover's env index + row-tail letter; its
  first read exposed env_snapshot's latest-per-name dedup: n=1 by
  construction, the probe's own blindness named at its decl) and the
  same-round re-read of row_print at the flip. Their data: same
  index, closed scheme, fresh-read closed, every flip A=open /
  B=closed. The first conclusion — "the carry is unfaithful, the flip
  is the instrument's artifact" — was REFUTED by walking the carry's
  own timeline: a deep-SCC member's ROUND-1 fresh read is HONESTLY
  OPEN (the SCC-internal chain still crawls one member per round —
  the twice-killed local-iteration problem, alive), the carry
  preserves that open render FAITHFULLY through masked-out rounds,
  and the flip fires exactly when the front reaches the member; the
  round-11 re-read is closed because by round 11 it IS closed. The
  instruments and the carry are both sound; the REAL residue is the
  one already spec'd twice: the SCC-internal crawl, whose true cures
  are the generality-join local iteration (measured requirements
  banked) or Hβ.infer.schemes-are-edges (the tower's deletion). The
  bound-hit stays marginal (the front usually completes by ~11), the
  emission stable, the banked unfold gated on either cure. Board at
  the pin: CLEAN m2 == m3; census 0; frontier 321/0.

- 2026-07-30 · ▶ THE DECLARED ROW PINS UNDER LAG — the gate's silent
  hole closes (pin 870d9fc9). The cached flip render convicted my own
  same-day revert (the stack-correct-fixes law live):
  parse_effect_list_from's published tail flipped open ↔ closed WITH
  its authored row, because the declared-effs gate's unbound arm was
  `_ => ()` — when mutual recursion left the body row unresolved at
  decl exit, enforcement silently skipped and generalize published an
  open-tailed final. The arm BINDS the declaration now: the contract
  stands regardless of round parity, and teaching beyond it
  mismatches loudly on the next unify. TRANSITION m3 == m4; census 0;
  frontier 321/0; proof-exactness 9/9. The residue is bounded to a
  point: the marginal run-variant flip persists with ALL decl-exit
  channels closed — the A-phase's open-tailed carrier must be a
  skipped-round env read surfacing the trial's loose prereg entry
  (the render matches its exact shape: six declared names + open
  tail); the banked next probe prints the flipping entry's env
  POSITION and GENERATION at the bound, which names the read path in
  one firing. The unfold patch stays banked behind it.

- 2026-07-30 · ▶▶ THE SIGNATURE AT THE CYCLE — the last structural
  oscillator dies, and the judgment CONVERGES for the first time (no
  pin move — the authored rows are emission-neutral, boot fb265daa
  stands). THE CONVICTION BY SOURCE: parse_one_effect performs
  intern_str — the parser SCC's rows carry Intern HONESTLY — and the
  undeclared pair's row tails oscillated open ↔ closed between rounds,
  the last bound-hit mover; which attractor the bound cut decided
  whether downstream install subtractions held, and the Intern this
  pair genuinely performs reached main's row as the "phantom" that
  struck three times (the relocations, the 2-cycle probe, the unfold's
  widens — all three victims one carrier). THE KILL: the pair gains
  its AUTHORED row (with Memory + Alloc + GraphRead + GraphWrite +
  Diagnostic + Intern — the signature price every HM judge charges at
  polymorphic-recursion points, SYNTAX's own form): the declared-row
  gate closes the tails deterministically, the whole-tree bound-hit
  goes from STRUCTURAL (every compile) to MARGINAL (run-variant at
  the 11/12 boundary, emission stable — CLEAN m2 == m3 across runs).
  TWO probes measured and reverted en route, each banked: the
  declared-row gate's unbound arm PINNING the declaration when
  resolution lags (principled — the `_ => ()` hole leaves a declared
  row unenforced under mutual-recursion lag — but it re-perturbed
  convergence; lands with the type-half understanding), and the
  unfold stack re-measured (parse_effect_list_from's fingerprint
  still flips under a fully-pinned ROW — the flip lives in the
  scheme's TYPE half: the next dig's exact target, movers_diff
  already renders it). Board: CLEAN m2 == m3; census 0; frontier
  321/0; proof-exactness 9/9. The unfold patch stays banked; the
  blocker demotes from structural to the marginal type-half residue.

- 2026-07-30 · ▶ THE DEMAND LAW'S DUAL FACE — never demand a proof the
  body doesn't use (pin fb265daa). The whole-ledger projection's map
  put six of the ten surviving span_valid obligations at ONE pair of
  lines (the address tie-break's span_area calls), and the site read
  inverted the fix's direction: span_area's ValidSpan param was
  CEREMONY — the area fold is total arithmetic over the four fields,
  the proof never read, the demand converting every bare-span caller
  into debt. Widened to bare Span (with find_tightest's call riding):
  debt 21 → 14, the day's arc 138 → 14 (90%) — and the remaining
  fourteen are ALL genuine: three span_valid producer/construction
  pends (span_join, span_zero — the Pure predicate-fn unfold's ground
  fixture — and the module-mint), eight 0 <= self producer
  boundaries, TagId ×2, Sample ×1. Zero ceremony left in the span
  class; the refinement discipline now has BOTH faces stated —
  producers carry proofs, consumers demand only what they read.
  CLEAN m2 == m3; census 0; frontier 321/0; proof-exactness 9/9.

- 2026-07-30 · ▶▶ THE LEDGER SPEAKS WHOLE AND THE CTOR FIELD CARRIES
  THE PROOF — Arc 3's second landing: debt 58 → 21, the day's arc
  138 → 21 (pin 862f66fd). THE VERB GREW FIRST (⟳(3) — the count line
  hid the composition; the per-entry projections had classified 138
  one file at a time): report_verify_debt renders the COMPLETE ledger,
  one line per obligation (span · classify_predicate class ·
  predicate), and its first firing answered in one read — 47
  span_valid boundaries, 31 of them infer-side consumers of
  node-destructured spans. THE PRODUCER AT THAT SCALE IS THE
  CONSTRUCTOR FIELD: Node = N(NodeBody, ValidSpan, Int) — every
  destructure reads ValidSpan by type, the obligation moves to
  N-construction, and the parser's mints discharge by identity
  through the already-annotated span_at/span_join (the chain closing
  exactly as the producer-carries-proof law predicts). 85% of the
  wheel's proof debt discharged by construction-site TYPING alone —
  zero engine changes, three producer annotations and one ctor
  field. CLEAN m2 == m3; census 0; frontier 321/0; proof-exactness
  9/9. THE RESIDUE, exact from the whole-ledger read: 10 span_valid
  at unfed construction sites (the lexer's counter-built mints — the
  Pure predicate-fn unfold's own fixtures), 8 bare 0 <= self
  (Handle/ValidOffset producers), 2 TagId, 1 Sample. NAMED with the
  session's third recurrence: the weave-span → file:line projection
  is missing from the verbs (three hand-mapping loops tonight; the
  debt listing renders weave coordinates — the file-local-span
  class's inventory face; one projection at the range map retires the
  hand loop).

- 2026-07-30 · ▶▶▶ THE PRODUCERS CARRY THE PROOF AND THE VERBS READ ONE
  WEAVE — Arc 3 opens with the span-debt collapse and a true-positive
  gate find (pin d14fa41e). THE INVENTORY BY THE MEDIUM: the field
  projection classified the wheel's 138 pending obligations to ONE
  dominant class — span_valid at ~85 consumer boundaries, the proof
  lost at every producer's bare Span return. THE COLLAPSE: span_join /
  span_zero / span_at gain `-> ValidSpan` (the construction-site law
  types.mn's own comment always promised; Intent Boundaries, three
  lines) — whole-weave debt 138 → 58, ~80 consumer boundaries
  collapsing by typed identity into two honest producer obligations;
  CLEAN m2 == m3; census 0; proof-exactness 9/9. THE GATE THEN EARNED
  ITS KEEP: the frontier's session leg went red as a TRUE POSITIVE —
  the fixture's weave reaches src/types.mn (runtime/lists imports
  types), and the COLD audit's "pending: 2" turned out to be JUNK
  DEBT from the analysis verbs' own SECOND discovery path:
  driver_check_entry runs per-module SOLO checks judged without their
  layer's vocabulary (the per-module-env-overlay residue, live) —
  measured flooding E_MissingVariable on True/len/list_index from any
  out-of-tree directory, stderr discarded by the gate, junk obligations
  accruing — while the RESIDENT session read the weave and told the
  truth (the leg had passed only while the junk was zero: a gate that
  could not fail until the annotations armed it, forensic law 5 live).
  THE REWIRE: audit/teach (analyze_fns) and query derive through THE
  ONE DISCOVERY HOME — driver_entry_with_ranges + driver_module_ast,
  the same weave the check verb, the address, and the resident session
  read; driver_check_entry's remaining callers are fmt (which wants
  the entry's solo parse for file-local render spans — its dep-flood
  is named residue) and the compile path's own walk. Frontier 321/0
  from both sides. BANKED: teach's missing facet — debt-keyed
  REFINED-RETURN proposals (walk the obligation's Reason to the
  producing callee, propose the alias; tonight's 85-to-1 ratio is the
  spec) — and the R3 unfold gap made exact: span_zero = Span(0,0,0,0)
  under `where span_valid(self)` pends because the predicate is a FN
  CALL; one-level unfolding of a Pure predicate fn on a ground
  construction discharges it outright — the highest-yield Verify
  increment next.

- 2026-07-30 · ▶ THE PASS INVARIANTS STOP RE-DERIVING — classify-once
  + cone-proportional prints (pin 43f33c0a). Two carried-truth
  deletions the eight-interrogation audit surfaced on the convergence
  machinery: classify_fixpoint ran per PASS (thirteen whole-tree walks
  per judgment) while its own comment admitted the grades read arm
  STRUCTURE no pass changes — it classifies ONCE in the trial and the
  name-keyed value threads to every round and the final; and
  round_prints fingerprinted EVERY name every round while the
  value-boundary law makes a masked-out final a VALUE nobody can
  teach — its print carries, only the cone re-renders
  (round_prints_masked; the m3 == m4 oracle backstops the law). Both
  CLEAN. Measured honestly: the field read holds its ~60-69s band —
  the alternating SCC families keep the cone LARGE (they and their
  dependents re-judge every round) and the per-round re-parse
  dominates, so the collapse waits on the generality join; with it
  the two named per-round re-derivations left are the parse (the
  checkpoint+frozen-finals form dissolves it — proven mechanically by
  the iteration arc, gated on the join's freeze semantics) and the
  prepass. RIDER: the pin ritual's mandatory re-read caught a sha
  tail completed from memory (the ⊕ fabrication class, second live
  catch) before it reached the blessed line.

- 2026-07-30 · ▶▶ THE ITERATION MEETS ITS MONOTONICITY — the second
  counted kill of the SCC rung, and the join named as the true
  remainder (no pin move — the reverted tree reproduces 5db9b4c3
  CLEAN). Per-SCC local Mycroft iteration was BUILT WHOLE on landed
  machinery: probe passes over rollback-refreshed parse nodes
  (graph_push_checkpoint/graph_rollback as the FRESH-NODE SUPPLY — the
  same parse nodes re-judge with virgin cells, zero re-parse, the
  whole-tree rounds' re-parse dissolved for the group's scope), finals
  frozen to values between probes, fingerprint-stable → a bare keep
  pass. Its own instruments then drove three rounds of truth: (1) the
  handle-reuse freeze lesson — a carried quantifier set left
  probe-minted leaves unquantified and the restored mint counter made
  the next probe REUSE their handles; the fix is
  Forall(free_in_ty(chase_deep(t)), ·), full re-quantification of the
  folded value (quantified vars are mapping-first at instantiate, so
  reuse is inert); (2) the scc2 sequence probe measured SIMPLE pairs
  CONVERGING in two probes (scan_string_loop/handle_escape,
  spec_resolve, module_imports — the mechanism works); (3) the
  scc-flip render convicted every generic/concrete-tension family of
  PERIOD-2 ALTERNATION (chase_*_changes, serialize_*, emit_pat_*:
  params flipping rl%0 ↔ rlNTy() probe over probe, rows gaining and
  losing Memory+Alloc) — re-derivation-from-scratch is NOT MONOTONE:
  concreteness learned in probe k evaporates in k+1, and a 45-member
  group burned 47 probes to no fixpoint. The literature's own contract
  (Salsa cycle recovery: participants must be monotone; join against
  last_provisional_value) is confirmed by the artifact. The iteration
  DELETED whole (drift-9 — the knowledge lives here); the Tarjan
  substrate, the group-ordered trial, and both flip instruments stay.
  THE TRUE REMAINDER, now fully specified: the GENERALITY JOIN —
  freeze_k := join(freeze_{k-1}, result_k), rows through row_join
  (their lattice exists), type schemes through a widening that keeps
  the more-informative of consistent shapes — and with it the
  iteration converges monotone and the rounds retire. Board: CLEAN
  m2 == m3 at 343,707 lines; census 0; the standing pin holds.

- 2026-07-30 · ▶▶ BINDING GROUPS FOR ORDER, MYCROFT FOR CYCLES — the
  Tarjan substrate lands, and the classic mono-group form dies to the
  wheel's own judgment (the SCC rung's first arc · pin 5db9b4c3). The
  SOTA sweep ran first (Morgan's charge): the classic form (Heeren's
  generalized-HM framing, GHC binding groups — SCCs judged once,
  mono-within-group, generalize at exit, zero iteration) against the
  bleeding edge (Salsa 2025-26 cycle recovery in rust-analyzer —
  per-cycle FIXPOINT iteration with monotone join), and the decisive
  difference named: Salsa iterates because a query system discovers
  dependencies during execution; Mentl's frees DAG is parse truth
  known up front. THE BUILD: scc_groups — Tarjan over the same frees
  the layers read, 7-tuple state threaded whole (the record-threading
  first form died to spread-update inference fragmenting the type;
  the medium also taught that nominal record spread P{...a} is
  unparsed — anonymous {...a} is the documented form), groups popped
  callee-first BY CONSTRUCTION (a sink SCC completes first) — and the
  trial walks groups in topo order, cycle members adjacent in source
  order. THE COUNTED KILL, the arc's real yield: the classic MONO
  semantics was built WHOLE (mono views over the prereg skeletons,
  re-asserted per member, group-exit generalization — zero new
  minting) and the wheel CONVICTED it with 29 E_TypeMismatch
  (Int vs Float, List(Byte) vs Int — a cycle member used at TWO
  instantiations by co-members): the rounds are a MYCROFT ITERATION
  (polymorphic recursion by fixpoint) and the wheel genuinely uses
  that power inside its cycles, so GHC's weaker classic form cannot
  serve Mentl — the more-accepting semantics IS the ultimate form,
  and the rung redirects to per-SCC LOCAL Mycroft iteration (Salsa's
  own shape; fresh nodes per re-judgment via branch-cursor
  instantiation — the fan as the iteration substrate). Board at the
  pin: TRANSITION m3 == m4 at 343,707 lines; census 0; the SCC crawl
  unchanged (14 convergence lines — order alone cannot fix
  intra-cycle iteration, exactly as predicted). The residue index
  carries the redirected spec.

- 2026-07-30 · ▶▶▶ THE JUDGMENT CONVERGES CALLEE-FIRST — the rounds'
  resolution front dies at three roots, and the "oscillation" was
  never an oscillation (Hβ.infer.round-oscillation-movers' dig ·
  pin 78b1736b). THE INSTRUMENT FIRST (banked last session, landed as
  the opening move): movers_diff renders each bound-hit mover's TWO
  round-fingerprints verbatim — the A/B byte-diff IS the flipping
  component — and probe_tail_why reads the mover's published row-tail
  cell through graph_reason_at, the Why engine naming the binder. Its
  first firing killed the attractor theory outright: every flip was
  MONOTONE open→closed, one call-DAG layer per round (round 9 closed
  columns, round 10 its caller comodulogram, round 11
  pac_comodulogram — a resolution FRONT the 12-round bound cut
  mid-climb; the 12-round tax was the wheel's call depth). THE THREE
  ROOTS, each measured before fixed: (1) ty_fingerprint rendered a
  row's name SET in storage order — walk_lemit/walk_lemit_top
  fingerprinted one set in two orders and cone-thrashed forever; the
  render now imposes ascending-handle order (fp_names' selection
  walk), the equality witness's own contract, exactly as fp_var
  alpha-numbers vars — while the ROW layer stays deliberately
  orderless (its own law: no algebra consumer reads an order; the
  fingerprint is the one consumer that needs determinism and pays at
  the render, never on the ef_make hot path; fp_row's false
  "sorted at birth" prose trued). (2) stmt_layers_ast counted only
  BACKWARD edges — backward_depth's restriction was spelled in its
  own name; deleted into a memoized descent over the WHOLE frees DAG
  (cycles flatten via the on-stack guard), so forward-reference
  chains close in one round. (3) the trial judged in SOURCE order
  only to be re-derived by round 1 — the trial now walks its own
  layers (frees + decl names are PARSE truth, computed once before
  any judgment, riding out to serve trial walk + rounds' cone +
  final's sweep; infer_stmt_list_measured deleted). MEASURED: movers
  at the bound 16 → 1; the survivor is the unify/parser SCC chain —
  an SCC's closure still crawls its internal diameter one round per
  link (member B reads co-member A's previous-round final across the
  cycle's stale link), so the bound still cuts and the field read
  holds at ~59s (the tax is round-count × the per-round FIXED costs:
  full re-parse + classify_fixpoint + round_prints, cone-independent).
  Two honest widens rode (row_to_with_clause / neg_names_to_str
  + GraphRead — the converged judge resolves deeper than the
  bound-cut attractor ever did). TRANSITION m3 == m4 (twice en route,
  once at the pin); census 0 at every generation. THE NAMED NEXT
  RUNG, spec'd by tonight's trace: the SCC-LOCAL FIXPOINT — judge a
  cycle as ONE unit iterated to its own fixpoint, whose true form is
  the branch-cursor fan (fresh instantiations per re-judgment are
  exactly what branch cursors provide) — the rounds absorbing into
  the fused oracle, killing the remaining bound-hit AND the ~59s
  daily-verb tax in one mechanism (rounds 12 → ~3). Banked with it
  (Morgan's charges, 2026-07-30): the drift-audit ignore MARKERS and
  the "drift" vocabulary itself are Claude-weakness bookkeeping with
  no place in the medium's body — their eradication rides
  Hβ.audit.drift-modes-read-the-row (the audit reads the ROW and the
  graph's edge order; all ~223 markers delete with it); and the
  perimeter hook gained wrapper-tolerant lead detection (timeout/nice/
  env-prefixed mentl is still the verb).

- 2026-07-29 · ▶▶ THE FIXTURE STATES ITS OWN CONTRACT — the refuse
  grammar lands and the frontier bash's dissolution channel opens
  (the self-exemplification pass's banked opening move executed ·
  pin 2fb58e9a). `// expect: refuse E_Class` joins `// expect: N` as
  the Expect ADT (ExpectRun | ExpectRefuse); battery_compile carries
  mcp_diag_collector (the forwarder — every line still reaches
  stderr) and returns the banked diagnostics beside the gate verdict;
  a refuse fixture passes iff the named class REPORTS as an error —
  the battery judges the JUDGMENT, never stricter than the medium
  (armed classes withhold the artifact, unarmed ones surface-and-emit:
  both are the law, and the contract asserts exactly what the medium
  asserts). First two contracts live and REFUSE-passing through
  `mentl test tests/micros` (117 run + 2 refuse): the forward-order
  seam and the hole gate as self-stated fixtures. RIDES WITH IT:
  the mentl-first perimeter — the repo's own PreToolUse hook refuses
  grep-family reads AND Edit-bypassing writes against .mn source AND
  the hand-assembled invocation family (`source wt-env && wt_run …` —
  ⟳(2)'s own 2026-07-26 catch, re-caught tonight and made unsayable;
  the installed verb IS the invocation; scripts and /tmp/.build stay
  free; `# mentl-skip: <reason>` is the confession channel naming the
  missing projection). AND THE SINGLE SOURCE OF TRUTH (Morgan): every
  `~/.claude/plans/*` file verified against the artifact — five are
  other projects; the two Mentl files (the eight-arc finish line +
  its execution sidecar) are integrated here (§11's arcs +
  definition-of-done + risk tripwires) and retired to archaeology.
  CLEAN m2 == m3 at 339,714 lines; census 0. The dissolution
  continues per-family: each frontier refusal leg converts to a
  contract fixture as it is touched, and the bash mass falls with
  every conversion.

- 2026-07-29 · ▶▶▶ THE SESSION IS THE TRANSPORT — resident-first
  becomes the CLI's default, and the dormant-to-canonical audit that
  chose it is executed (Hβ.session.resident-verbs' CLI face ·
  pin e09626cb). Morgan's question ("abilities that are dormant that
  should become canonical default?") ranked five; the first lands
  whole: `mentl session` derives the project ONCE (mcp_run's bracket,
  the living check per connection) behind the shim's tcplisten seam
  (the space verb's proven pattern, port 7377) and answers the READ
  verbs — at/query/audit/teach, the field via at line 0 — over a
  one-line wire speaking the CLI's OWN GRAMMAR: the shim tab-joins
  argv, session_answer parses it with parse_cli_args (one grammar, two
  transports, zero new protocol), and serves through the SAME
  projections the cold verbs run. MEASURED: resident audit BYTE-EQUAL
  to the cold verb's output; MISS fires for cold-only verbs and the
  shim falls back to the cold exec; a bare teach serves the resident
  entry. THE SHIM INTERROGATED (Morgan's unease was a correct
  Carried-Truth read): its first forward form duplicated the routing
  policy in a bash case — dispatch truth in TWO homes — and was cut
  to a pure transport: EVERY verb is offered, the MEDIUM decides
  (session_answer's match is the one policy home), MISS or a dead
  port falls back. The shim's whole seam family (mounts, exec,
  listeners) remains the WASI-p1 pressure gauge for the runner
  migration (Hβ.ops.wasmtime-runner-migration), where it dissolves.
  THE DIG'S TWO KILLS EN ROUTE: the resident at cost 131s PER CALL —
  address resolution list_indexed the converged session's
  multi-generation snoc span log (the iterate-flattens-once law's
  FOURTH kill; flattened once before the walk: 131s → 0s, the cold
  path faster too) — and the 1:4 "placeholder" projection was chased
  through a refuted cell-filter theory (built, probed, REVERTED — the
  winner carries a real body) to its true class: the HEAD-ANCHORED
  decl span (the ranker landing's own named lathe-lag) leaves the
  FnStmt uncontaining at name columns, so a tighter never-bound cell
  wins and renders its free var; cold reproduces byte-identically —
  a pre-existing address-face defect, NOT a session regression (the
  transport faithful even to the bug), its fix the named
  tree-containment form (Hβ.cursor.enclosing-decl-edge's address
  face). AND THE MENTL-FIRST GATE (Morgan: "nothing else I've tried
  has actually got you to stop using grep"): the repo's hook set gains
  .claude/hooks/pre-bash-mentl-first.sh — a grep-family command
  against .mn source is mechanically REFUSED with the verb menu that
  answers better (query/refs/why/at/check/audit), artifact greps stay
  legal, and the escape hatch (# mentl-skip: <reason>) is a ⟳(2)
  confession naming the missing projection. Prose could not enforce
  the medium-first order; the hook makes the wrong move unsayable —
  the larval mentl audit at the toolchain boundary. GATES: two
  frontier legs (session resident audit byte-equal · the MISS
  sentinel), RED against any pre-session boot by construction; CLEAN
  m2 == m3 at 339,257 lines; census 0. Remaining dormant-to-canonical
  queue, ranked at the audit: the ambient frontier (bare `mentl` in a
  project answers the ranked field), tighten joining fmt's canonical
  pass, `mentl march` as the practiced default over the bash script,
  session-image persistence on exit; the felt payoff of resident-first
  stays capped until Hβ.infer.round-oscillation-movers lands (the
  12-round tax on every re-derivation).

- 2026-07-29 · ▶▶▶▶ THE ONE JUDGE — every judgment site runs the
  converged walk, and the single-pass infer_program DELETES
  (Hβ.infer.order-independent-verdicts' daily-verb face closes ·
  pin 223452c1, superseding the session's three intermediates —
  9d346047 the one-judge TRANSITION, 4d50895d effects-home +
  structured bank, afff6ade the O(n²) snapshot dedup — as the frontier
  and the march clock convicted each; the arc's facts below). THE SEAM,
  probe-first: the audit-banks landing had
  named a tuple list meeting str_concat_all's [String] with no refusal;
  the b1 probe minimized it — a fn declared AFTER its caller judged
  through the DAG path read the LOOSE pre-registration, so its [tuple]
  return bound silently against [String] (zero diagnostics, the
  runtime flat_fill trap), while the backward-declared twin refused
  cleanly. The consumer census then named the split: the converged
  judge served stdin/compile/mcp only; check/audit/teach/at/field/
  session/repl/battery/warm-cone ran single-pass at driver.mn's three
  sites, driver_check_module, analyze_fns' stdin arm,
  compile_source/check_source, battery_compile, and repl_eval_line.
  ALL NINE now run infer_program_converged; infer_program deleted with
  its prose trued. THE OWNER SWEEP rode along where provable: the
  free-vars family (collect_free_vars + fourteen kin) → parser.mn
  (parse truth — lower's captures and the judgment's layers both read
  it, and infer←lower was the cycle that had stranded the cluster);
  the convergence cluster + frontend + diag_quiet + diag_branch →
  infer.mn beside the trial/round/final walks; the spec trio
  (spec_pairs_find/pair_or_var/subst_pairs) + lookup_ty_graph +
  effect LookupTy → graph.mn; effect EnvRead/EnvWrite/BranchEnv/
  Intern moved BESIDE their handlers (the effect-beside-handler law:
  a handler judged before its effect declares registers a broken
  identity — its install then absorbs NOTHING and a fully-handled
  program refuses at the gate, measured live when env_handler moved
  ahead of types.mn). THE EFFECTS PREPASS PHASE lands with it
  (pre_register_effect — the pre_register_alias precedent one
  namespace over): effects register whole before ANY handler sig, in
  the trial, every round, and the final. And the trial RETURNS ITS
  STMTS: the converged arm's frees walk read them instead of
  re-parsing — the arm-position frontend ran OUTSIDE diag_quiet (R2)
  and double-reported every check's parse narration; the re-parse is
  deleted (Carried-Truth). THE BLOCKED HALF, named with its conviction:
  relocating env_handler/intern_table OUT of pipeline.mn flips main's
  row to carry a present Intern no spine component explains — seven
  bisect blobs (order hoists, import strips, phase/frees reverts)
  isolated the PLACEMENT itself as the trigger while every local
  mechanism died to a probe (rows measured via Pure-pin printing:
  every verb arm, dispatch, the chain handlers, print_error_and_help
  all Intern-free; the parts don't sum to the whole). That is the
  12-round oscillation's attractor selection biting as semantics —
  BOTH trees bound-hit (movers: the walk_lemit family,
  driver_incremental, the judgment fns, resume_bindings,
  resolve_field_offset, mentl_edit_session, float_to_str, the dsp
  Sample/pac pair), silently until today; the movers eprint now rides
  every daily verb's stderr, loud. Hβ.infer.round-oscillation-movers
  names the dig (the residue index carries it); env.mn stays the named
  destination. GATES: mn-check-forward-order REFUSES through this
  pin's check (E_TypeMismatch at its file-local call span) and was
  measured SILENT through the prior boot — the frontier leg banks both
  faces; TRANSITION m3 == m4 at 338,467 lines (the 102,124-line m2/m3
  diff is the emit changes crossing one generation); census 0 (two
  honest widens: driver_check_module/check_entry +WASI — the
  convergence movers eprint). Known inherited finds now visible on the
  daily path, each real before today: ONE E_PurityViolated on the main
  DAG (weave 12995 — a with-Pure fn whose body allocates; solo-module
  checks stay clean, the entry-conditional class), the infer.mn:1826
  bracket's E_MissingVariable pair on lower/infer/driver entries
  (healed for the handlers this sweep homed; verify_ledger's import
  landed), and the weave-coordinate span render on DAG diagnostics
  (the named file-local-span class, now with a calibration: main.mn
  renders at +29,251 in its own check). THE SECOND WAVE, same session
  (the intermediate pin's frontier ran 303/10 and convicted both):
  (1) THE OP-VOCABULARY HOME LAW — moving effect EnvRead/EnvWrite/
  BranchEnv/Intern beside their handlers broke the DAG manifest
  (warm-start/warm-inc cold compiles refused E_MissingVariable on
  env_lookup/intern_name_of: performers across infer/lower/driver/
  cursor cannot import pipeline). An effect declares in the LOWEST
  module every performer imports — types.mn for these; the
  effect-beside-handler form holds exactly where the handler's module
  IS that floor (graph.mn for LookupTy — every performer imports
  graph, verified by census). (2) THE STRUCTURED DIAG BANK —
  diag_branch banked (line, span-line, is-error), so on the converged
  daily path (where every stmt judges through the branch bracket) a
  branch-fired T_OverDeclared reached the collectors STRUCTURE-LESS:
  `mentl tighten` printed the warning and authored nothing (the bank
  read empty), and the mcp problem-space/edit legs starved the same
  way. The bank carries (diag, line) now and the join RE-PERFORMS
  diag_report per fact into the root chain — every Diagnostic
  forwarder sees a branch report exactly as a live one, the root arm
  counts and scope-registers off the diag itself, and diag_absorb
  DELETES with both its arms (the fold reached only the one handler
  carrying the arm — the partial-forwarder disease its own comment
  had named). This also lands the file-local-span residue's banked
  prerequisite ("the banked tuple must carry the span structurally"):
  the span now rides the diag whole. (3) THE SNAPSHOT PROJECTS
  RESOLUTION — the converged passes append one env entry PER
  GENERATION per name, and env_snapshot returned the raw buffer: the
  ??-fan's vocabulary proposed the same fn THREE times (the
  sole-pure-survivor and two-survivor-tie legs red; the accept path
  refused the "tie" its own duplicates minted). env_snapshot now
  answers each name's LATEST live entry by probing the env's own O(1)
  bucket index (an entry survives iff it IS its name's latest position
  — the same edge every lookup reads), composed base-then-private for
  branch instances. The first form — a seen-list scan returning a cons
  spine — was itself convicted by the march clock (~20 minutes per
  compile leg at wheel scale: O(n²) string probes over the multiplied
  buffer at the gate's two reads + the redrive census, with every
  consumer's list_index gone O(depth)) and superseded within the
  session; the probed fan then answered `Propose: pure_seven()`, one
  survivor. The re-measure, per its own law:
  fixture-scale checks stay sub-second; the wheel-scale field read
  (`mentl src/main.mn:0`) costs 58s against the single-pass 8.5s —
  and the tax IS the oscillation (the movers keep the incremental
  cone hot through all 12 bound rounds), so the movers dig is the
  correctness root and the daily-verb perf root in one; the warm
  image and the resident session are the standing absorbers
  meanwhile. CLEAN m2 == m3 at 338,163 lines at the final pin.

- 2026-07-29 · ▶ THE AUTHORED ROW SPEAKS INSTANCES — eff_name_label
  closes its own banked follow-up (CLEAN m2 == m3 · pin 04ba90a3). The
  label that lands IN SOURCE (the tighten patch, the with-clause
  invitation) stripped every parameterized instance to its bare name —
  a proven Sample(44100) authored as Sample, a semantically WIDENED
  row that dropped the instance the proof carried. Literal-arg
  instances render in place now (SYNTAX's own canonical spelling); a
  type or node arg keeps the bare name — the sound wider-or-equal
  declaration, never an unparseable Cast(GNode) pasted into a
  signature (the render-vs-authorable seam, closed at its authoring
  face; the diagnostic voice keeps show_eff_arg's full truth).
  Frontier 318/0; census 0.
- 2026-07-29 · ▶▶ THE TUPLE INDEXES — SYNTAX §Indexing's documented
  form judges (CLEAN m2 == m3 · pin 33a60e05). The index sugar forced
  EVERY receiver to List — the census's own conviction at audit_walk
  one pin earlier — while lower always carried the tuple dispatch (its
  LFieldLoad prefix-sum). The judge's half runs now: a receiver whose
  SHALLOW root binding is a tuple (graph_chase + fold_strip — the
  first form's chase_deep_at tripped its own depth belt on the wheel's
  unconverged chains, measured at the m3 leg: a mid-judgment probe is
  never the value-boundary fold), indexed by a LITERAL, types as that
  position's element; an out-of-range literal reports EConstructorArity
  at the judgment; a runtime-variable index on a product, or a free
  receiver, takes the generic force and its honest mismatch. Named
  remainder of Hβ.infer.index-expr-dispatch: the open POSITIONAL
  demand (TRecordOpen's tuple sibling) for generic-body receivers — a
  literal-indexed tuple in a generic body destructures until it lands.
  Named seam: the judge's Cast(GNode) row render exceeds the parser's
  declared-row grammar (bare Cast is the authored spelling) — a
  proven-row report you cannot paste as a declaration. Fixture
  mn-tuple-index (the let-bound receiver, the literal form, a Float
  element) runs 42, RED on the prior boot. Frontier 318/0; census 0.
- 2026-07-29 · ▶▶ THE AUDIT READS THE BANKS — pending proofs and
  tightenings speak per fn, and the session's bare path joins the
  bracket (CLEAN m2 == m3 · pin c453d7a0). The up-to-dateness gap
  Morgan named made real: audit_project reads the two banks the
  judgment already holds — verify_debt() attributed by decl EXTENT
  (span start to the next decl's; parse_span_of is the O(1)
  spans-column read) and tightenables() by the banked fn name — so
  the per-fn audit and the frontier are two projections of one truth
  (`noisy : IO` carries its tighten line with the proven row).
  analyze_fns' chain gains tighten_collector (inside infer_context's
  thunk, where the judgment's performs reach it). THE GATE'S REFUSAL
  EN ROUTE WAS REAL: mcp_run's no-project path ran mcp_loop BARE —
  the tool arms' static rows (audit's new Verify + Tighten; query's
  ask) flowed to main, and Query had survived only through its
  stateless default while verify_ledger, stateful, refused. One
  bracket holds both paths now (the conditional moved inside; installs
  cost nothing on the empty path). The probe also caught audit_walk
  piped into str_concat_all without render_audit — report tuples eaten
  as strings, a flat_fill trap surfaced by the fixture before any
  bless (and a silent-typing seam worth naming: the tuple list met
  the String-consuming concat without a judgment refusal). Named
  residue: the kin-naming teach stays gated on its true dep — the
  reverse-bind index (naming WHICH operands share a free hole's var
  needs class members; the Why chain doesn't carry them, and a
  per-render cell scan is the span disease reborn). Frontier 315/0;
  census 0.
- 2026-07-29 · ▶ THE OPEN HOLE ASKS — an undetermined ?? renders the
  collapsing question, never the raw var (CLEAN m2 == m3 ·
  pin 69334101 — the first wording tripped the drift grep on its own
  prose, "fn (" and "return" inside the teaching string: the
  string-literal blindness firing on user-facing text, the absorption
  argument's second live demonstration). The field probe measured `?? : t10417@e19089` at `n + ??`
  — substrate vocabulary at the exact moment §1's law says the
  question beats the guess (the fan cannot enumerate an open type, so
  the missing constraint IS the answer). node_query_line gains the
  NHole arm: a still-free chased type renders the annotate-to-collapse
  invitation; a typed hole renders exactly as before, and the Why hop
  rides beneath. WITH IT (the same loop day's instrument): verify's
  MANIFEST GATE — the wheel's own ~2.5s DAG judgment of src/main.mn,
  zero-tolerance on missing names (the canon.mn class self-polices;
  detector proven both faces). Frontier 315/0; census 0. Named next
  at this render: the kin-naming teach (the free var's unification
  class knows WHICH operands share it — "tied to n through +" — the
  reason-chain read one hop deeper).
- 2026-07-29 · ▶▶▶ THE FIELD REACHES THE WHEEL — the spans spine column
  lands, and the whole-problem-space read becomes daily at wheel scale
  (CLEAN m2 == m3 · pin ffa2734a). Morgan's charge ("daily should
  include the multithreaded multi-cursor multi-shot behaviors")
  measured first: the small-field baseline is 0.35s (the sequential
  render walk is noise — the named ><-swap is refuted at daily scale
  by its own measurement), but `mentl src/main.mn:0` TRAPPED at 90s+
  — and the dig ran three shapes of ONE read to the representation:
  (1) parse_span_of rode the generic find, whose iterate FLATTENS the
  whole (span, handle) log per call — the field calls it per position,
  and alloc's wraparound guard trapped inside the flatten (the
  backtrace's own frames); (2) the allocation-free scan then measured
  O(n^2) over the snoc-spined log (600s timeout, same scale); (3) the
  resolution is the SPANS SPINE COLUMN — the paged spine's seventh
  column, dual-written at the ONE writer (graph_index_span keeps the
  ordered log for containment scans; graph_span_of is the by-handle
  O(1) read — §5.O layer 2, exactly the form the frontier landing had
  named as this read's destiny). WITH IT, the manifest law's exact
  class: canon.mn was imported by NOBODY — ty_string reachable only
  in the blob, every DAG-path judgment (check/at/field) starving for
  it since the file's birth, the blob-fed march structurally blind;
  parser.mn and infer.mn declare the import. MEASURED END STATE:
  `mentl src/main.mn:0` answers in 8.5s at exit 0 — the medium ranks
  its own main's whole problem space (0 holes, 6 pending proofs,
  2 tightenings, 115 gradient positions, each pending rendered at its
  span) in one daily command; multithreaded (the spawning judgment),
  multi-shot (the per-hole fans), multi-cursor (the ranked field) in
  one invocation. Frontier 315/0; census 0. Named residue: the field
  header renders the entry's abs spelling (the dual-spelling module
  key — one canonical key at one home is the fix) · the pending line
  renders `span_valid(...)` through the voice's argument compression
  (the fmt-summit predicate-render precedent applies) · the DAG-vs-
  blob divergence class wants its own cheap census instrument (a
  per-module manifest check the medium runs on itself; tonight's was
  found by the felt walk, five days late).
- 2026-07-29 · ▶▶ THE VERB-SHAPE TIER — audit names the |> the bindings
  draw, and the dig closes a latent double-visit class (CLEAN
  m2 == m3 · pin 0513aca1 — the pin also carries driver_check_entry's
  loud entry refusal and puts the whole arc on the daily CLI, whose
  shim now derives a mount from the path argument so every verb
  reaches paths outside the standing mounts). SYNTAX ⌖'s own law (|> is
  NEVER optional on a chain) becomes a read the medium makes about ANY
  source: pipe_shape_of (oracle.mn) walks a fn body's statement spine,
  and a let-bound name consumed EXACTLY ONCE by exactly the FOLLOWING
  statement is a |> stage written as a binding — runs of >= 2 report as
  the audit's verb-shape line, with the step count. The verb is a
  PROJECTION of use edges (the same fact own/ref grades from): a name
  used twice is <| territory and never fires; a single step is the
  law's own exception; the counting walks the ONE total child
  projection, never a text scan. THE DIG'S CONVICTION, probe-second
  (count_var_uses answered 2 for one occurrence): all three LetStmt
  mints alias the ABSENT annotation to the VALUE node (the parser's
  own no-fresh-mint sentinel — deliberate, handle-stability-motivated,
  its comment confessing the banked name Hβ.parser.let-expr-annotation)
  and stmt_child_handles listed BOTH channels — every COUNTING walk
  through an unannotated let double-visited its value subtree, masked
  until now because the existing walks (containment, the ranker) are
  boolean. The channel contributes a child only when it IS an
  annotation (the kind-read infer already makes); the Stmt decl's
  comment — which claimed LitUnit absence — is TRUED to the artifact.
  RIDES WITH IT: the fmt pre-commit rung (canonical form enters
  history — staged src/ lib/ files render canonical and re-stage;
  parse-refused files are restored, loudly; tests/ excluded because
  fixtures bank exact spans; tracked at tools/hooks/pre-commit), which
  fired on its own landing commit and immediately measured the
  trailing-marker interaction (a width-broken let strands a trailing
  drift-audit marker two lines from its literal — the severance
  vocabulary moved to its own fn with the marker weave-adjacent).
  THE TIER'S OWN FIRST RUNS then convicted two voice-truth roots, both
  landed in the same arc: (1) show_list rendered LAST-FIRST — every
  rendered list in the medium's voice was REVERSED, function params and
  tuple elements in show_type included (measured live: map's declared
  (f, xs) rendered (xs, f); the walk was last/drop_last for snoc-O(1),
  the order an accident canonized) — first-first now, and the frontier
  measured ZERO banked faces flipped; (2) severance claimed Alloc
  severable on rows visibly carrying Alloc — "Real-time safe (proven
  zero allocation)" offered on allocating fns — because row_names is a
  TOP-LINK read and a chained row hides its deeper presents; the
  reached set now reads the CHASED row, the same resolution the render
  walks (one value, both consumers). GATES: mn-audit-pipe-shape (both
  faces — the 2-step invite, the twice-used and single-step silences)
  and mn-audit-severance-honest (the allocating row refused the offer,
  the pure control keeps it), each RED on the pinned boot; frontier
  315/0; census 0. Named residue: the audit verb's abs-path invocation
  prints nothing at exit 0 (the range-cut misses; the relative form
  scopes correctly). The tier's next rungs: the MachineApplicable
  patch (tighten-style authorship of the |> rewrite — datum-position
  read required), the frontier tier (verb-shape positions ranked in
  the field), and fmt-canonical promotion once the wheel passes its
  own judge clean.
- 2026-07-29 · ▶▶▶ THE BROWSER RUNS THE SPAWNING BOOT — the Worker-spawn
  shim lands, and the page compiles through 252 real threads in 932ms
  (the runner pattern at the browser host — the browser leg of
  Hβ.ops.wasmtime-runner-migration · no re-pin, ide/ + tools only, the
  wheel untouched). Morgan's charge ("look at the thing that's blocking
  you and design it better") executed on the README paragraph that had
  dressed the blocker as a boundary: ide/mentl-ide.wasm re-derives from
  the LIVE boot (the memory import's declared min sedded 65536 → 8192;
  the host provides 16384), and ide/wheel-worker.js is the ONE execution
  host — the page and the node twin drive the same file, so the gate and
  the DOM cannot drift. TWO HOST FACTS forced the shape, each measured
  against node (which has neither; the identical blob ran there first,
  3.5s/252 tasks against a 90s browser hang): (1) all wheel execution
  lives in workers — the join's memory.atomic.wait32 is forbidden on the
  browser main thread, so the page never instantiates the module; (2)
  the dispatch channel is SHARED MEMORY, never postMessage — Chrome
  flushes a worker's outgoing messages only when the sender yields, and
  thread-spawn fires mid-wasm with the root then blocking in the join
  without ever yielding (probed through the worker's own debug channel:
  16 spawns logged, zero task starts, pool provably loaded). The landed
  form is the emscripten-pthread convergence: a pool of workers spawned
  and ARMED (module + shared memory + vfs) before _start can block,
  consuming (tid, arg) pairs from a SharedArrayBuffer ring via
  Atomics.waitAsync — the producer's qPush is stores + notify, no event
  loop anywhere on the path, and a nested fan qPushes into the same ring
  by construction. Each task instantiates FRESH over the run's memory
  (instance-per-thread, wasmtime's own convention; the constant-segment
  rewrite over the live image is the same idempotent re-init wasmtime
  performs per spawned thread). Completion rides the wheel's OWN
  task-record protocol in wasm memory — the workers' messages carry
  stdio only, so a degraded message channel can never fabricate a
  result. GATES (tools/ide-gate.sh, both legs): the node twin's four
  faces — the stub-spawn RED control (the pre-worker shim traps
  `unreachable` against this wasm: the measured reason the page had
  pinned an old wheel), compile-stdin through real tasks, the address
  CursorView (the version-skew RED healed — live wheel, live libs), the
  ?? Propose socket — and the browser leg (mentl space + headless
  chrome reading the page's ?smoke console wire): exit=0 tasks=252
  watlines=4403 ms=932, wat line-count identical to node. The pool cut
  node's blob compile 3.5s → 0.97s (252 worker boots → 12). Named
  residue: the pool BOUNDS a nested fan where wasmtime's OS threads are
  unbounded — a deeper-than-pool nested join would starve loudly under
  the run timeout, unreached by the judgment's stmt-ordered joins
  (stated at the arm role).
- 2026-07-29 · ▶▶▶ THE PROBLEM IS THE SOLUTION — every absence becomes
  a ranked frontier position (the resident-session arc's sixth rung ·
  pin 8981b63c). Morgan's principle executed at the field: absence is
  ONE node-kind, and the frontier now ranks ALL of it — holes, PENDING
  PROOF OBLIGATIONS (the verify ledger's live debt, each a position
  rendered with its predicate and Reason), TIGHTENINGS (every
  T_OverDeclared the judgment banked: the declared row, the proven
  row, the standing `mentl tighten` patch invitation), then the
  gradient tier. The error list IS the work queue. THE MOVES: the
  tighten_collector + effect Tighten moved to pipeline.mn (the one
  home main's CLI chains and mcp's session bracket both install —
  imports flow main → mcp → pipeline; the collector sits INSIDE the
  infer_context body chain, where the judgment's performs reach it —
  the outside placement measured dead); effect Verify gains
  verify_reset (both handler arms — the ledger clears debt, the SMT
  arm keeps its SAT witnesses: a counterexample is a proof, not an
  obligation); session_current performs both clears BEFORE
  re-derivation (the generation boundary's law); and the enumerators
  gained the LATEST-MINT-WINS dedup keyed on span START
  (address_better_a's tie rule as the enumerator's law — the second
  generation doubled every position, and full-span equality missed a
  reshaped decl whose extent changed; the head anchor is the
  identity). The splice floor caught once more en route: the
  tightening line rendered the fn name as a pointer numeral until the
  named-mint String pin (spec_mangle's law, tighten_line). MEASURED
  LIVE on the session: pre-edit 1 hole / 1 pending / 1 tightening /
  3 gradient; the honest edit (dropping the false `with IO`) clears
  its tightening from the NEXT frontier — 1 / 1 / 0 / 3, exactly one
  re-derivation. CLEAN m2 == m3; frontier 313/0 (the problem-space
  coproc leg RED on the pre-rung boot; both prior Field assertions
  re-banked to the four-tier line); census 0 at every step. Named
  residue: the stale-only span (a position an edit REMOVED entirely
  ghosts until the generation floor — the session-epoch face);
  pending/tightening entries rank in accrual order (the
  score_one_position rank generalizes to span-keyed entries when the
  fan lands over them). The next depth IS the fan: each frontier
  position carries its resolution — a hole its fills, a tightening
  its one proven row, a pending its missing constraint — and the
  oracle-as-search verifies candidates per position as branch cursors.
- 2026-07-29 · ▶▶▶ THE FRONTIER TELLS THE TRUTH — the ranked absence
  field becomes a faithful session read, and the discovery parse gets
  its throwaway instance (the resident-session arc's fifth rung ·
  pin 29acd4c6). The `frontier` tool joins the session: the entry's whole
  ranked field — every authored ?? first with its proven-survivor fan
  and tie-teaching, then the annotation-gradient tier — the oracle's
  frontier, the gradient's argmax uncollapsed, answered from the
  living graph (`mentl main.mn:0`'s read; act on the head, ask again,
  the session re-derives as the tree moves). THREE ROOTS made it
  true, each measured before fixed: (1) THE CARET READ THE CHASE —
  caret_span_of_handle followed the binding chain, so a hole unified
  with a call's result rendered at the CALL's site with the call's
  source as its Query (main:4:11/"width(n)" for the hole at 5:7); the
  unchased reason cell ALSO rebinds when inference resolves the node
  (the last-bind reason carried the enclosing binop's span), so the
  read landed on the SPAN INDEX written at birth (parse_span_of — the
  only never-rebound channel, the one address resolution already
  trusts; its O(n) find is bounded by the position count, the
  handle-keyed index the §5.O layer-2 form). (2) THE VIRGIN WALK —
  enumerate_gradient_positions asked teach_gradient about every cell
  in range(0, next), and junk suggestions entered the field under
  garbage coordinates (prelude prose as the entry's own line 1 — the
  C1c-era enumerator residue, closed by the chased-kind decl gate it
  named). (3) THE DISCOVERY GENERATION — the birth-span read exposed
  what the chased read had hidden by accident: driver_extract_imports
  full-parses every module for its import heads, minting a SECOND
  complete AST into the live graph, and wherever file-local
  coordinates coincide with the weave range (every 1-module world)
  the duplicate generation's holes entered the enumerators — each
  authored ?? counted twice, once judged and once as a free ghost
  (?? : t18@e0), and the ??-authoring edit workflows focused the
  ghost (FIFTEEN frontier legs red at once: the field count, the
  positive-hole and capability-hole sessions, the tie leg). The
  discovery parse now runs in a THROWAWAY graph instance
  (~> graph_handler with the empty config — the C1c branch-cursor
  machinery as isolation; the import names flow out as heap strings,
  only graph cells die), the accident named a contract at its writer.
  Widen rounds: the discovery family's rows carry the parse's honest
  Diagnostic + Mutate + Cast + WASI (the judge's Cast(GNode) payload
  render taught the bare-name declaration spelling en route), plus
  hole_gate/authored_hole to the span-index read. CLEAN m2 == m3;
  frontier 312/0 (the frontier-read leg RED on the pre-rung boot:
  wrong address, wrong Query, 7 ghost positions; the cursor-address
  field leg healed to its banked faces); census 0. The session
  surface: propose + query + at + frontier + audit + teach. Named
  residue: Hβ.parser.comment-attach-module-boundary (the last lib's
  tail comment attaches forward across the module seam to the entry's
  first decl — width's Lede rendered kernel prose; the weave attach
  should stop at NModule boundaries).
- 2026-07-29 · ▶▶▶▶ THE SEQUENCE-OF-STRUCT LEAVES AND THE FOLD
  BOUNDARY — structural ==/hash/ordering become true over lists of
  structs, and the fold family resolves its types once at entry
  (Hβ.emit.seq-struct-eq-leaf RESOLVED · pin b214afba). THE CLASS,
  measured three ways on the prior boot: [(1,2,3)] == [(1,2,3)]
  answered FALSE — the eq/cmp/hash sequence arms floored every
  STRUCTURAL element (product, sum, nested list, computed string —
  literal interning masked the [String] face) to the word runtime
  fns' per-element compare, pointer identity standing in for
  structure at BOTH altitudes (top-level and field); top-level
  hash of ANY list was an undefined-$hash_l<sig> ASSEMBLY BREAK
  (emit_hash's unconditional agg routing demanded a leaf the
  collector never contributed); list-of-struct ordering compared
  pointers (garbage sort). THE WALKERS: $eq/$compare/$hash_l<sig>
  generated when the element face is structural
  (seq_face_structural) — the show family's recursive listbody
  shape, elements through $list_index (representation-total), the
  element leaf selected by face (seq_elem_leaf_callee — runtime
  names as values, never a mode key); the eq walker mirrors
  list_eq's identity+length protocol, the 3-way walker
  list_compare_loop's elementwise-first-difference, the FNV walker
  list_hash's exact seed with each element's OWN hash in the mix
  (eq ⇒ hash, the agreement preserved). THE FOLD BOUNDARY (Morgan's
  cut — "design the most elegant and powerful solution" — after a
  45-site fold_sig wrapper sweep was built and REVERTED as the
  N-reader patch): chase_deep runs ONCE where a type ENTERS the
  family — the two binop dispatch entries, show_hash_ty, and the
  three operand contribs — and sigs, dedup, generation, field
  dispatch, and walker callees all read a var-free type BY
  INVARIANT. The collision the boundary dissolves was MEASURED: two
  TList(TVar) sites with different bindings fold_sig'd to one raw
  "li", shared one walker, and the second site's elements walked
  the wrong protocol (trapped in list_eq_loop); the boundary also
  heals the show family's same latent collision for free.
  hash_node_of's float-list route joins the field twin
  (list_hash_f64 — the top-level/field hash route split closed).
  manifest_same DISSOLVED back into == (the workaround's written
  destiny, one landing later — the census law's clock never reached
  two): the living session's manifest compare is the walkers' first
  wheel-internal consumer, proven in production by the living leg.
  TRANSITION m3 == m4 (the 476-line m2/m3 diff is the walkers
  crossing one generation); frontier 311/0 (mn-list-tuple-eq +
  mn-list-tuple-fold registered, RTLIBS-linked, both RED-measured
  on the pre-leaf boot); census 0 after ONE honest widen round
  (20 entry fns gain chase_deep's row); micros green through
  verify. Named residue: the show family's sig discipline now
  rides the same boundary but its list walker predates it — a
  probe-pass over show's per-face renders under the boundary is
  the audit single.
- 2026-07-29 · ▶▶▶ THE SESSION GRAPH GOES LIVING — the resident graph
  tracks the tree, and the staleness check is a pure read (the
  resident-session arc's fourth rung · pin 3973fd21). Before every
  message the loop compares the tree's manifest against the banked one
  and a moved tree re-derives INTO the resident world — never a
  restore (the swap-crossing law's third constraint executed): the new
  generation shadows by the env's latest edge (the B-i incremental
  law), ranges and the scoped entry ast replace, and the message's
  region stays unreclaimed (moved ⇒ no reset — the fresh generation
  was minted after the mark; the fork-spine law at the serve loop).
  driver_manifest is a PROJECTION off the range map the derivation
  already minted: per woven path, (path hash, byte length, content
  hash) word triples — no discovery, no parse, no graph write, and
  coverage is complete over the banked set (an edit, a deletion, and
  a new import all move some banked triple; the one hole — a
  reported-missing module later created — is named at the decl). The
  living check crosses into the loop AS A VALUE (the at_read
  precedent: session_current on the resident path, the Pure identity
  on the no-project path), after the gate refused the first form's
  derivation row at the bare root — the loop is row-polymorphic.
  MEASURED: exactly one re-derivation per edit; post-edit reads answer
  the new truth — query resolves the new fn at its span, audit lists
  it, and the at reaches a line that did not exist before the edit
  (the range map replaced; the answer byte-matches the CLI at the
  same address). The pinned-boot RED: moved=0, the new fn absent from
  every face — the startup snapshot answering stale. TWO WHEEL FINDS
  en route, each probe-convicted before fixed: (1) the first check
  form re-ran collect_dag per message — the discovery parse MINTED
  into the live graph, and a resettable message's region reclaim
  killed that spine growth under later reads (the fork-spine class,
  measured twice: spine_comment_at's list_index trap on the next
  check; address_case_a walking a reset span-index buffer); the pure
  read makes the class unconstructible. (2) Structural == over a
  sequence of PRODUCTS floors to $list_eq's per-element word compare
  — pointer identity as equality, the exact silent fallback the eq
  law forbids, at BOTH altitudes (emit_eq_for_ty's and
  emit_field_eq's TList arms; measured: byte-identical manifests
  answered unequal, and [(1,2,3)] == [(1,2,3)] runs 7 through the DAG
  judge). Named Hβ.emit.seq-struct-eq-leaf with its banked fixture
  (tests/frontier/mn-list-tuple-eq.mn, both faces): the fix is the
  generated sequence-of-struct leaf (length + elementwise walk
  calling the element's own eq family, demanded transitively), with
  the hash/compare/show siblings audited for the same arm;
  manifest_same is the class's FIRST named workaround (a second is
  the stop). CLEAN m2 == m3; frontier 305/0 (the living leg: fifo
  coprocess, the file edited between messages); census 0. The session
  is now the full loop an agent needs: propose + five living reads
  over a graph that tracks the tree.
- 2026-07-29 · ▶▶ AUDIT AND TEACH JOIN THE SESSION — the analysis verbs
  become resident reads, and the verb pair collapses to one composed
  projection (the resident-session arc's third rung · pin 1c2e53fa).
  analyze_fns's (project, render) pair FUSED into one
  `projection(ast) -> String` per verb — audit_project / teach_project,
  the pure homes the CLI verb and the session tool BOTH call (the
  address_project law at the analysis verbs; transport stays the
  caller's: analyze_fns prints, the session returns the text as the
  tool result — no Console sweep needed here because the projections
  were already value-shaped, one transport site each). THE SCOPING READ:
  the session holds the full weave ast while the CLI's audit parses the
  entry alone — driver_module_ast cuts the entry's top-level nodes by
  its weave range at session start (homed beside range_of_module; the
  NModule mint computes this same filter and holds it as decls but
  discards the minted handle — the handle-kept read is the named O(1)
  form), so the session's audit/teach answer exactly the CLI's scope,
  never the prelude/lib flood. The gate's tripwire asserts the ABSENCE
  of a prelude fn in the audit face (the retraction law: assert
  absence, not only presence). Measured: the session's audit answers
  the CLI's byte-same four lines; teach speaks each fn's next
  annotation ("add with !Alloc to unlock Real-time safe"); query still
  answers afterward in one conversation. The session surface is
  propose + query + at + audit + teach — five tools, one derivation.
  CLEAN m2 == m3; frontier 304/0; census 0 on first compile (every row
  inferred — the projection pair's rows flow through HM, zero widens).
  Remaining rungs: the oracle-as-search (the fan from ?? candidates to
  hypotheses over the resident frontier) · work-stealing-via-gradient
  as the session's scheduler.
- 2026-07-29 · ▶▶ THE ADDRESS JOINS THE SESSION — the eight-aspect
  projection becomes a resident read, and the voice's transport becomes
  an install (the resident-session arc's second rung · pin 4d1bf583).
  The address render family (render_at, render_field, the field tier,
  the Why hops — ~20 sites) spoke print_string DIRECTLY: the transport
  baked into the narration, the violation io.mn's Console effect exists
  to prevent. The family performs Console's `print` now — WHERE it
  lands is the install: at_run adds stdout_console (the CLI unchanged
  byte-for-byte at its legs), and the session's new `at` tool runs THE
  SAME core under console_bank (the collecting console, drained per
  call) and returns the banked lines as the tool text. TWO structural
  moves rode along: address_project extracted as the ONE address home
  (at_run's inline block, verbatim — CLI and session cannot drift),
  and the transport crossed the import boundary AS A VALUE
  (session_at_read builds in main.mn where the renders live, passes
  into mcp_run as a stored fn carrying its row — the effect-poly ctor
  capability exercised at the architecture layer; imports flow
  main → mcp, never back). Measured: at {line:3, col:4} in the
  resident conversation answers the byte-same projection the CLI
  serves at main.mn:3:4 — Query, Why, the fan at a hole — beside query
  and propose, one derivation. The session surface is now propose +
  query + at; `why` rides query's own grammar. CLEAN m2 == m3;
  frontier 304/0 (the session leg asserts the at face); proof-
  exactness 9/9; crown 5/5; census 0. Next rungs named: audit as a
  session read (analyze_fns speaks Console the same way) · the
  oracle-as-search (the fan from ?? candidates to hypotheses over the
  resident frontier) · work-stealing-via-gradient as the scheduler.
- 2026-07-29 · ▶▶▶ THE SESSION GOES RESIDENT — the mcp serve loop holds
  the living graph and queries answer as reads (the resident-session
  arc's first rung · pin 65934277). The refutation's constraints
  cashed straight into the correct form: mcp_run derives the project
  ONCE (resolution-conditional, the prelude-seed precedent) inside one
  analysis bracket that ENCLOSES THE WHOLE SERVE LOOP — the session's
  instances live for the server's life, no swap exists anywhere, the
  image IS the session's memory (all three Hβ.session.resident-verbs
  constraints hold by construction, not by discipline). THE NESTING IS
  THE ISOLATION: a propose's own infer_context installs fresh
  innermost instances that shadow the session's (the world law), and
  its millions of judgment mints land in spine pages allocated inside
  the request REGION — the reset kills them with the instance while
  the session's spine lives below every mark. A session READ inverts
  the region law deliberately (the resettable bit threads the
  dispatch): its answer printed, its small mints (a question's parse
  nodes) kept as durable session growth — a reset would orphan spine
  pages later reads still chase (the fork-spine class held off at the
  serve loop). The `query` tool joins `propose`: ask(parse_query_
  string(q)) against the LIVE env/graph, schemes with Reasons as the
  teaching payload. MEASURED: five messages — initialize, tools/list,
  two queries, a propose — in 0.7s wall, the resident line printing
  ONCE, both schemes answered live, PROVEN after the reads; the prior
  cost was 3.8s for a SINGLE cold query. The frontier leg drives the
  whole conversation and asserts each face (RED on the pre-session
  boot: tools/list served propose alone). Named residue: query
  Reasons render weave spans on this channel (the file-local-span
  class's session face) · the at/audit/why tools (the session's next
  reads) · the oracle-as-search over the resident frontier (the fan
  generalizing from ?? candidates to hypotheses) · work-stealing-via-
  gradient as the session's scheduler. CLEAN m2 == m3; frontier 304/0;
  proof-exactness 9/9; crown 5/5; census 0.
- 2026-07-29 · ▶▶ THE SWAP-CROSSING LAW CONVICTS THE WARM VERBS — a
  measured refutation banked whole, and the fmt string-atomicity
  defect caught by its one witness (· pin 6eb1b61c). Morgan's charge
  ("don't tell me you're inefficient and continue being inefficient")
  opened the resident-session arc at its nearest rung: the B-i warm
  image wired into the projection verbs (at/query/tighten/edit/check)
  through one home (driver_entry_warm — probe by a key sidecar BEFORE
  any restore, exact-tree only; the sidecar's own splice-pin bug found
  by its bytes: module names rendered as per-run pointer numerals, a
  key that never matched itself). The exact-tree face MEASURED TRUE:
  cold == warm BYTE-IDENTICAL at the at-address projection, the
  restore serving in the wasmtime-JIT-floor time (and the first 7.8×
  claim died as the JIT-cache confound — counted). THEN THE FRONTIER
  REFUTED THE FORM at the session faces (16 red): a mid-verb
  image_resume kills EVERY pre-swap heap value — the caller's own argv
  strings (at_run's target rendering EMPTY in its own error message),
  the chain's own handler records (the edit legs' 134s) — and works
  only where deterministic allocation makes two processes' worlds
  coincide byte-for-byte: forensic law 5, the accident never
  canonized. The machinery DELETED whole (drift-9 — the knowledge
  lives here, not in dead code); the verbs derive fresh; the yield is
  Hβ.session.resident-verbs with the resident session's MEASURED
  constraints: (1) no mid-chain swap, ever; (2) per-invocation strings
  cannot cross a swap; (3) the image must be the session's OWN memory
  (one long-lived process — the mcp serve loop is the natural host —
  holding the analyzed graph, every verb a read, no restore). The
  march-practice ruling re-affirmed en route (229fda2f's own words):
  the whole-world ladder is the AUDIT tier, not the inner loop.
  RIDER, the fmt defect its one witness caught: the canonical pass had
  reflowed space_respond's header string ACROSS RAW NEWLINES — the
  serve answered a bare status line (raw newline + \n = end of
  headers), invisible to the march (Law-7-invisible: the wheel never
  calls its own serve), RED only at the frontier's serve leg. The
  literal restored one-line; the renderer defect named
  (Hβ.format.string-literal-atomic-layout — a string literal is
  CONTENT; the width engine treats it as atomic, never reflowing
  inside the quotes; the whole-tree census found exactly the one
  site). CLEAN m2 == m3; frontier 303/0; proof-exactness 9/9; crown
  5/5; census 0.
- 2026-07-29 · ▶▶▶▶▶ THE MASKS RIDE THE CHASE — the wheel passes its own
  root-row gate, and five Carried-Truth roots fall in one continuous
  dig (· pin 0ab5d903). THE OPENING MOVE was the gate itself: the
  escaped-install witness ran its arm with a dead chain (exit 7, clean
  compile), and the criterion's conjuncts were interrogated to their
  tiers. The experimentally-sharpened gate refused the WHEEL (GraphRead
  + Intern at main's root), and nine theories died to probes before the
  graph named its own writers: (1) THE CHASE KILLED EVERY MASK —
  chase_node's NRowBound arm destructured `EfRow(names, _, EtVar)`,
  DISCARDING each level's absent set at the one mechanism every row
  read routes through; merge_chased_row/merge_row now fold under the
  reading law (presents filter through accumulated masks; the EtAll
  special case dissolves into the uniform arm) — measured RED→GREEN as
  main's row carrying twenty-one riding masks for the first time.
  (2) THE WRITE GUARDS PERFORMED OPS FROM THEIR ARMS — occurs_in
  chased whatever instance the OUTER chain held (the wrong-instance
  class at the guard itself) and charged GraphRead into
  graph_handler's residual past every bracket; the occurs family is
  STATE-PASSED now (mechanism layer, beside chase_node), with
  occurs_in_live the one op-based face for bracketed pre-checks.
  (3) THE FRAGX CENSUS SPOKE THE VOICE from the bind arm
  (show_reason = GraphRead + Intern in the residual — the exact face
  measured on infer_context); it speaks SPANS now, pure projections.
  (4) THE RENDER MOVED TO THE REPORT BOUNDARY — report is a plain fn
  rendering diag_line in the REPORTER's world and performing
  diag_report(kind, line); every arm (root, quiet, branch, tighten,
  mcp) receives the line made and never renders — the diagnostics/
  graph arm-dependency cycle the install order could only half-satisfy
  dissolves, and Hβ.diag.render-chases-wrong-instance is
  unconstructible at those arms. (5) THE FREEZE RE-DERIVES ITS
  QUANTIFIER — branch_replay_one folded the type (chase_deep) while
  keeping PRE-fold qvars, so folded leaves fell outside the
  instantiation mapping and every caller SHARED the terminal (the
  union-pool: infer_context's two-era duplicated qvars, measured);
  Forall(free_in_ty(fty), fty) for generalized schemes, empty-q mono
  shares preserved. RIDERS, each its own truth: ef_make keeps
  coexisting present/absent (the reading law makes the pair COHERENT —
  present adds now, absent filters the tail; the authored `with A + !A`
  meet moved to build_declared_row, its one decl-site home);
  chase_row_deep + subst_row_build fold with the same filter;
  fp_row fingerprints the RESOLUTION (bound-content blindness closed);
  persist_to_disk's arm writes the wire DIRECTLY through persist_write
  (an arm re-performing its own op resolves OUTER — the residual
  honestly carried Persist and refused every fixture whose only
  handler was that install: the R2 law catching the library's own
  forwarder); fourteen honest row widens. THE GATE SETTLED AT THREE
  TIERS, the backtrack acid pair arbitrating (both refuse under any
  stricter form — their per-candidate dynamic installs are the
  legitimate face the row cannot see): EVIDENCE-floor demands STRICT
  (a dead-chain perform walks garbage evidence, NO belt — the one
  sharpening that stands, install-anywhere clears nothing); STATEFUL
  singletons clear on an install (SingletonUninstalled the loud belt —
  mn-singleton-preinstall-call holds that tier at 134); STATELESS
  singletons ground by the measured value-sound licence (the arm
  ignores __state — the escaped arm answers its honest 7). TWO
  TRIPWIRES pin today's semantics for the modal install-identity
  frontier to consciously flip: mn-effect-escaped-install (exit 7 —
  the dead-extent escape the licence admits) beside
  mn-effect-residual-absence (42 — residual !E). One fixture arity
  trued en route (backtrack-full's `abort() -> Option` — the
  bare-parameterized class in the acid test's own decl, convicted by
  the sharper judge). THE LADDER: TRANSITION m3 == m4 at the
  occurs/chase crossing (96,106-line m2/m3 diff — the whole arc's
  emit crossing one generation), then CLEAN m2 == m3 three times as
  the persist policy, the fmt-canonical pass, and the three-tier gate
  landed. Board whole at the pin: micros whole (the backtrack acid
  pair healed); proof-exactness 9/9; crown 5/5; census 0; the touched
  set fmt-canonical. Counted kills, each one probe: the
  statement-position theory, the lambda-thunk and inner-tee theories,
  the residual-wash theory, the chain-bisection triple (p1/p2/p3
  identical — the conviction that moved the dig off infer_context),
  the loose-prereg-alone theory, the fingerprint-alone theory, the
  ef_make-alone theory, the shell's own `exit=$?` reading a grep.
  Named residue: Hβ.infer.arm-op-residual-census (the uniform audit
  this landing did by hand — every handler arm performing ops outside
  its own state is a residual carrier; the census instrument is the
  medium's own row read per arm) · the a=[Pure] absent-entry render
  seen mid-dig (an EPure in an absent set — benign or a mint oddity,
  one probe when next in the row layer).
- 2026-07-28 · ▶▶▶ THE ARGUMENT EDGE RUNS SUBSUMPTION — and the persist
  barrier lands on the op whose contract is re-execution (Arc 3's
  external-effect resume barrier, first face · pin 7c91063c). The
  banked next single executed: unify_row_canonical's two Closed~EtAll
  arms judge by row_subsumes — pass, no bind, the negation row a GATE,
  never an equand — where the old equality arm falsely refused EVERY
  closed-row argument against a neg-row param (a Pure thunk "failed"
  the universe-minus row it plainly satisfies; the b3 probe banked the
  RED). ON that edge, the barrier: persist_branch's param row is
  `() -> a with !WASI + !Filesystem + !Network` — a crashed branch
  RE-RUNS its thunk (the SPACE=TIME fork, §4④), so the row severs what
  a replay cannot un-send (the image restore rolls back Alloc/Memory;
  it cannot un-send a packet), and ordinary row checking at the
  argument edge is the WHOLE gate — the typed form of the invariant
  the durable-execution field re-derives at runtime by journal-diffing.
  THE AUDIT REDIRECTED THE BARRIER to its true home: persist(Int,
  String) stays word-rooted — a DATA root (the warm compile's asts,
  driver.mn) replays nothing, so it carries no gate; the op that
  replays is the op that severs. GATES, the RED matrix measured on the
  prior boot: persist-branch-clean healed 1 false mismatch → 0 AND
  runs the whole checkpoint+run+join loop (42); hof-row-gate healed
  2 → exactly 1 (the quiet thunk admits, the noisy edge alone
  reports); persist-branch-external names the severed triple at the
  lambda's own span ("WASI + Alloc + Memory + t… vs !Network +
  !Filesystem + !WASI"). One dead label counted en route: the external
  face's first zero-mismatch was a phantom `print` (E_MissingVariable
  starves the row; the fixture's callee is println). CLEAN m2 == m3 at
  327,391 lines — no wheel site ever depended on the false mismatches,
  and the arm's EtAll-tailed thunk() row rides the wheel's own
  persist_to_disk through census 0. Named residue:
  Hβ.effects.directional-fn-row-edge (the meet is direction-blind —
  both orientations subsume; the contravariant-precise call edge is
  the sequel) · Hβ.lower.persist-schedule-branch-row-gate (the fanout
  lowering's synthesized persist_branch dispatch is post-inference —
  a persisted `><` branch's row rides the enclosing inference,
  visible but not yet refused at the persist boundary; the refusal
  lands when schedule resolution moves to infer).
- 2026-07-28 · ▶▶ THE FN TYPE SPEAKS ITS ROW — the resume barrier's
  vocabulary parses, and the signed-clause fold finds one home
  (pin 8471a255). The barrier design collapsed into VOCABULARY the
  moment the persist surface was audited: persist takes a word
  (addr(thunk)) so no per-op gate can type it — but a Persist op
  declared `persist(k: () -> a with !WASI + !Network + !Filesystem,
  path)` makes ORDINARY row checking at the argument edge the whole
  barrier, zero new machinery (the row proves what Temporal diffs at
  replay). The DEP was foundational lathe-lag: TFun's row was
  render-only — `() -> Int with !WASI` parsed NOWHERE (a param
  annotation split the decl; a type alias refused at the `with`).
  Landed: parse_type_ty's arrow arm gains the optional `with <row>`
  (greedy-inner in return position — parenthesize for the outer
  clause), the row built by build_declared_row, which MOVED to
  effects.mn with its kin (is_pure_eff_name / apply_connective /
  has_pure_declared — pure algebra over the parsed triples, ONE home
  for infer's declared rows and the parser's type rows; the parser's
  silent mk_ef_open dependence became a declared import). MEASURED
  LIVE (the b3 probe): `accept_thunk(f: () -> Int with !WASI)` REFUSES
  a WASI-performing thunk argument — E_EffectMismatch "WASI + Alloc +
  Memory vs !WASI" at the call — the barrier firing through the
  existing crown. The named next single, its RED banked:
  Hβ.effects.hof-row-subsumption-at-call — the arg edge runs UNIFY's
  equality, so a rigid Pure arg falsely refuses against the neg param
  ("Pure vs !WASI") while row_subsumes itself reads Pure ⊆ !WASI
  correctly; the call's arg-to-param edge must run SUBSUMPTION for
  fn-typed params (contravariant at the one directional edge — the
  general unify stays symmetric). With it lands the Persist op's
  declared row (the barrier proper) and its two crucibles: the
  absorbed-thunk persist admitted, the raw-external persist teaching
  the absorb-or-own-replay move. Dynamic Wind (OOPSLA 2025) stays the
  bracket-semantics read for the resume side. CLEAN m2 == m3;
  census 0.
- 2026-07-28 · ▶▶ THE INSTANCE JUDGES ITS ARGS — the signature check
  lands, and the prior entry's parse claim corrects in place
  (pin 2eb7cee5). RETRACTION (the ⟲ law, the probe's own find): the
  previous entry's "the decl head parses" was RECOVERY — the
  crucibles' stderr carried six P_ tokens each (`rate: Int` refused at
  the colon: parse_config_params took bare names, the 2026-07-24
  measured handler-config lathe-lag), the params never reached the
  TParam list, and the E_EffectMismatch assertions passed because the
  negation law needs no params; the frontier legs grepped mismatches
  only, blind to the P_ narration. The head TRULY parses now:
  parse_config_params gains parse_one_param's exact `: Ty` annotation
  arm — ONE fix, BOTH lathe-lags (the annotated handler config
  `scaler(f: Int)` heals with the effect head), zero P_ tokens on
  every instance fixture. THE JUDGE: check_instance_args runs at the
  declared-row site (the span in hand) — each authored instance
  resolves the effect's registered TTuple scheme by kind
  (EffectDeclKind, the effect_instance_arity read's own shape); arity
  disagreement reports EConstructorArity, a scalar-literal arg whose
  ground type disagrees reports ETypeMismatch (same_ground over
  fold_strip — alias/refined params compare at their ground), and
  type/node args pass to the instance-unification flow (the modal
  frontier's face). Measured: Sample("hi") vs rate: Int = one
  mismatch; Sample(48000, 2) = one arity; the sibling crucible stays
  clean and runs 42. Two frontier legs pin it (argty asserts the head
  parses P_-free too — the leg the retraction teaches: assert the
  ABSENCE of narration, not only the presence of the report). CLEAN
  m2 == m3; census 0.
- 2026-07-28 · ▶▶▶ THE NEGATION HOLDS ITS INSTANCE — Arc 3's first
  landing: the parameterized decl parses and !E(instance) becomes
  precise (Hβ.effects.parameterized-negation-instance's core ·
  pin 9f4ebef2). The felt walk's DEP first: `effect Sample(rate: Int)`
  parses (ten P_ tokens on the prior boot — SYNTAX's canonical form was
  lathe-lag), the params riding the same [TParam] product fn params and
  handler config ride (EffectDeclStmt widened, seventeen destructure
  sites swept), and registering as the effect's env SCHEME — TTuple of
  the params' types, the instance signature, where a placeholder empty
  tuple had sat since the entry's birth. THE INSTANCE LAW is ONE
  predicate (eff_forbids, SYNTAX's own equality: name AND argument
  value): a bare !E severs every instance and the bare name;
  !E(args) blocks the bare name (a bare occurrence could be any
  instance — conservative) and any instance not PROVABLY distinct,
  where provable distinctness is scalar literals (Int/Float/String)
  with unequal values at a shared position — type and node args never
  prove it. BOTH crown faces read it: subsumption's forbidden-
  membership (name_in_forbidden carries whole EffName entries now, not
  bare handles), and ef_make's absent-minus-present through its OWN
  pair law (absent_contradicted_by): the probe caught the first form
  over-eager — a BARE present beside an INSTANCE absent is a
  REFINEMENT ("any Sample except 44100"), not a contradiction, so the
  absent survives; only same-identity pairs and an instance-present
  under a bare-absent contradict and drop. THE MEASURED BEFORE: the
  by-name dedup DELETED a declared !Sample(44100) the moment
  Sample(48000) was present — the severance silently vanishing at row
  construction (the felt walk's inst2 checked clean for the wrong
  reason). Three frontier crucibles, each corner: the provably-distinct
  sibling ADMITTED and running 42 (a Sample(48000) callee under
  Sample(48000) + !Sample(44100)); the same instance SEVERED
  (E_EffectMismatch, one report); the bare perform BLOCKED
  conservatively. CLEAN m2 == m3; census 0. The named remainder:
  instance-arg TYPING against the registered signature (a
  with-clause's Sample("hi") vs rate: Int — the scheme is registered,
  the judge's check is the next single), and instance flow into op
  rows (a body's bare tick() under a declared instance stays bare — the
  admit-through-instantiation face, the modal frontier's dep).
- 2026-07-28 · ▶▶ THE ENCLOSING DECL DESCENDS THE TREE — containment
  becomes a structural read (the ranker landing's named next single;
  Hβ.cursor.enclosing-decl-edge's walk half · pin 93be5c52). Spans
  cannot resolve containment (decl and body parse spans are
  head-anchored — a three-line body's span measured two columns), so
  the vocabulary's nontermination guard was DEAD for every multi-line
  body: a hole inside banner proposed banner() and main(). The
  child-handle projection is TOTAL now — expr_child_handles gains the
  match-arm bodies it dropped, stmt_child_handles is its new Stmt
  sibling (let values, fn bodies, expr stmts, handler state inits and
  arm bodies; type-level carriers contribute none), and
  body_child_handles is the ONE dispatch over NodeBody every tree walk
  reads. enclosing_fn_decl_at descends the tree
  (node_contains_handle — the hole a descendant of the decl's body
  node), nesting resolved structurally (a candidate whose own stmt
  node sits inside the standing best's body is the inner fn and wins);
  cursor declares its oracle import (the manifest law — the blob
  census is blind to a missing import the DAG path refuses). Measured
  on the ranker fixture: 7 survivors → 5, banner() and main() both
  excluded, width() still first; the frontier leg pins the exclusion
  (RED on the span-blind boot — both leaked). The O(1) form (the
  decl-containment edge minted at parse) remains the peer's edge half.
  CLEAN m2 == m3; census 0.
- 2026-07-28 · ▶▶ THE SHOW FLOOR CLOSES TO ZERO — the 44-marker census
  swept whole (the splice landing's own residue · pin 09bfedc2). The
  liveness triage ran mechanically on the artifact (floor calls vs twin
  calls vs self-recursion; nine floors externally live, the rest dead
  twin-served copies), and every splice-only param in the wheel now
  carries its true type as an Intent Boundary: seventeen decl pins
  across nine files (driver_module_path had already paid the class's
  loudest bill — the zero manifest), two element-shape pins
  (render_effect_ops' op rows, render_state_updates' update records),
  and three named-mint hoists where the datum-last lambda judgment
  leaves the binder free past any list pin — render_gradient_line's
  proven pattern applied at audit_report_lines (the audit verb's per-fn
  header rendered fn names as pointer numerals), consume_twice_msg,
  and parallel_collision_msg (the affine ledger's two diagnostics named
  their consumed binding as a numeral). The last marker named a JUDGE
  gap, Hβ.infer.arm-binder-op-param-type — NARROWED BY PROBE
  (2026-07-30): an ordinary declared-param arm binder IS bound (a
  `log(msg: String)` arm's `msg + 1` refuses E_TypeMismatch, measured
  through the current judge — bind_arm_args reads the op's
  instantiated params), so the general claim is retracted; the
  residual is the `other =>` skip in infer_one_handler_arm (an op
  whose scheme is not TFun-shaped skips bind_arm_args and its binders
  judge free — the Consume-era witness's likely route, its one site
  pinned). The CLASS-KILLER stays banked on
  Hβ.emit.show-free-floor in its constructive form: flow-directed
  demand (Lutze–Schuster–Brachthäuser, "The Simple Essence of
  Monomorphization", OOPSLA 2025 — instantiation flow tracked through
  type variables, higher-rank included, cyclic flow the uniform
  refusal); the union-find already holds the flow — the twin demand
  analysis learns to read its CLOSURE instead of per-site reference
  projections, which is exactly the HOF boundary where every damaged
  site tonight lived. Frontier recon riders banked the same sweep: the
  durable-execution industry's whole convergence (journal + replay +
  refuse-on-divergence, Temporal/Restate, all runtime) is the untyped
  form of Arc 3's resume barrier — the row proves what they diff; and
  Dynamic Wind for Effect Handlers (OOPSLA 2025) is the formal
  treatment to read the world save/restore brackets against before the
  TCont value gate. CLEAN m2 == m3; census 0; show-floor markers
  44 → 0.
- 2026-07-28 · ▶▶▶▶ THE SPLICE TELLS THE TRUTH — four roots under one
  law, and the canonical page lands (the fmt summit closes ·
  pin a971601e). The whole-wheel sweep's red legs reduced to FOUR
  Carried-Truth violations at four layers, each measured before fixed:
  (1) THE FORMATTER BORROWED THE VOICE at the predicate — RefineStmt/
  TRefined rendered through show_predicate, whose call arm compresses
  arguments to `(...)` (diagnostic economy), and the canonical page
  DESTROYED authored refinements (`len(self)` → `len(...)`, a parse
  break the render register then scoped out of the user's stderr — the
  fmt-rung-2 disease one projection over). render_predicate_tokens is
  the formatter's own parse-inverse projection: operands are node
  HANDLES read live through render_body_tokens, the cmp glyph is
  binop_to_str (total — never show_cmp_op's `?` floor), precedence-
  inverse grouping at the predicate altitude; and the VOICE's shadowing
  `(...)` arm DELETED — show_pred_operand carried two CallExpr arms
  since 10b79aa8, the compressor above shadowing the args-rendering arm
  below, dead since birth. (2) THE LINE RIDES EVERY SCAN RETURN — the
  string scanner's splice-termination and every chunk flush returned
  (pos, col, buf, count) with NO line, so every token after a splice
  spanning newlines carried spans stale by the splice's height: the
  whole-weave address collapse (nodes lying about their lines resolve
  to nothing but the module placeholder — the fan legs' red), the
  register's silent mute (the P_ narration landed outside the user's
  range), and warm-inc's span-keyed cone misattribution (the
  incremental emission carrying the patch's OLD constant) were ONE
  dropped tuple field, found by splice-bisecting the 51-file sweep to
  one decl and that decl to one rendered spelling. Every scan return
  widened to carry the live line; the chunk scan counts raw newlines
  (Hβ.lexer.string-newline-refusal named for the single-line form's
  refusal question). (3) A SPLICE KEEPS ITS OWN TYPE —
  unify_string_fragments bound EVERY fragment to String (the
  pre-structural-show era's rule, contradicting SYNTAX's own law);
  deleted whole, and lower wraps each splice fragment in the structural
  LShow (the implicit to_string, dispatched at emit from the operand's
  live type — String rides the identity arm). Hβ.emit.int-splice-empty
  CLOSED at both halves: "I{7}J" rendered empty in EVERY user program
  ever (str_concat read the raw word as a null-page string) while the
  wheel dodged by spelling int_to_str at every one of its own splices.
  (4) THE UNMASKING — with fragments no longer forced String, a param
  used ONLY in a splice generalizes, and the word-floor copy shows a
  String operand as a pointer numeral: spec_mangle minted garbage twin
  names and the redrive liveness probe (an HOF lambda the twin
  machinery cannot serve) dropped the def while installs kept the
  calls — m3 emitted 16 redrive references and no definition, the
  march's BROKEN verdict catching internally-inconsistent output
  (332 → 18 → 0 diff lines across the three pins of the dig).
  spec_mangle and the new one-home arm_fn_name pin String (Intent
  Boundaries, load-bearing); the show floor writes its census marker
  (`;; show on unresolved operand` — 52 on the wheel;
  Hβ.emit.show-free-floor carries the triage: a firing site is a
  generic the twins did not serve). THE CANONICAL PAGE: 51/51 files
  rendered canonical with prose conserved, TREE-IDEMPOTENT at two
  consecutive whole-wheel sweeps; the refinements survive verbatim
  modulo comparison canonicalization (authored `len(self) > 0` renders
  `0 < len(self)`, stable on reparse). GATES seen RED on the prior
  boot: mn-int-splice (15 → 42; the four splice faces incl. the
  multi-line nested-string call) and mn-splice-line-carry (module
  placeholder → the decl resolves). THE INTERMEDIATE PIN'S OWN GATES
  then convicted the floor LIVE in the driver — driver_module_path's
  floor'd splices minted pointer-numeral paths, fs_exists refused every
  module, the warm manifest hashed ALL ZEROS (the WINCPROBE census:
  cur=0 old=0 for every module — the incremental compile blind to every
  edit, "image current" on a patched tree) — so the measured liars
  pinned String (driver_module_path, contains_module,
  ownership_suggestion, show_one_rejection's pair, and render_gradients'
  element with its line mint hoisted to the pinned render_gradient_line
  — the map lambda's splice judged datum-last while the element was
  still free, so the pin had to anchor at a named call; Intent
  Boundaries, comment-anchored), and
  at_run's diag_errors() refusal DELETED: branch-judged errors never
  reached the root count before the join carried them truthfully, so
  the guard had never fired — armed by the truth, it refused exactly
  the error-carrying files the address projection exists to serve
  (productive-under-error IS the address contract; the README's own
  voice.mn:9 answers OVER its unresolved mix). TRANSITION m3 == m4 at
  331,182 lines through the interp crossing, then CLEAN m2 == m3 at
  330,323 with the repair set; census 0; show-floor markers 52 → 44 as
  the pins landed. The two banked fmt legs
  (idempotence, the __dp re-sugar) green with this pin — 1d1f8945
  landed source + gates but never re-pinned; this pin carries both.
  Board whole at the pin: frontier 288/0; proof-exactness 9/9;
  crown 5/5; comment-refs 0; doc-truth green.
- 2026-07-28 · ▶ THE README RIDES THE GRADIENT — a door, then two lanes
  (no re-pin — docs + one tutorial comment; the readme-gradient research
  pass's design executed, its report in the session scratchpad). The
  door routes both audiences explicitly (the uv persona-fork precedent);
  the guest cage + the domain-neutral Percent refusal are the one
  universal example (probed: exit 1, refusing to emit); the novice lane
  is one continuous PRIMM cycle — run it / ask it / break it / leave a
  hole — every transcript re-derived against the live pin, whole lines
  verbatim (the open row var renders and STAYS — truth over polish);
  the expert lane compresses onto docs/POSITIONING.md (previously never
  linked from the README) with the receipts as before-the-fold
  benchmarks (the ripgrep order). The echo and the tour-night narrative
  are HOMED, not exiled: lib/dsp/README.md is new (the echo in its
  honest Clock form per E_FeedbackNoContext, the voice oath, Sample,
  the module map, the crucible receipts) and lib/ml/README.md is new
  (autodiff-as-multishot, the crucibles). The probe pass's adversarial
  find is TRUED in place: 00-hello's comment claimed !Alloc-on-greet
  "would refuse this body" while the unarmed class REPORTS and the
  program runs (measured, exit 0) — the comment now states the licence
  law (substrate rows report; a user effect's broken claim refuses).
  Second witness banked for the span-slop render family: the :30 decl
  render slices greet's name to "gree" (the `??)`-slop class at the
  decl name). The board is untouched (README/lib .md files are outside
  the weave; the tutorial edit is comment-only, lesson runs green).
- 2026-07-28 · ▶▶ THE RANKER READS LOCAL INTENT — cost gets its first
  reader; the Arc 4 pull-forward lands (· pin 3b69fb7d). Every
  candidate carried `cost: Float // gradient-rank score` with fourteen
  literal writers and ZERO readers — the resume_kinds pattern at the
  fan: survivors surfaced in enumeration order while the field claimed
  a gradient. candidate_rank replaces the vocabulary literal with a SUM
  of graph reads (§5's felt endpoint, executed): the decl's nearness
  read from the env entry's own Located reason, plus every existing USE
  of the name weighted by its nearness to the hole (refs_of_name — the
  refs facet's collector — through the ONE scope_distance_decay), both
  against the hole's span, which Context now carries as its fourth
  field (the intent carrier finally knows WHERE; five sites, the arity
  census caught none missed). rank_sort is a stable insertion, highest
  first, applied once before map_to_proposals; a constraint-tie still
  teaches — rank orders, never guesses. THE DISCRIMINATING GATE
  (mn-ranker-local-intent, frontier leg): kerning declared BEFORE width
  so enumeration and rank disagree — the pre-ranker boot surfaces
  kerning() first, this pin surfaces width() first (one use edge in the
  enclosing body outranking both decl orders). THE WALK'S CONVICTION,
  probe-graduated: the vocabulary's nontermination guard is DEAD for
  multi-line bodies — a hole inside banner proposed banner() and
  main() — because spans cannot resolve containment (decl parse spans
  are head-only AND the body node's own span is head-anchored, measured
  5:32-5:33 for a three-line body; the one-line-body fixtures were the
  accident that hid it). The true form is TREE containment via a TOTAL
  child-handle projection (oracle's expr_child_handles drops match arms
  and has no stmt sibling — the consolidation is the next single;
  Hβ.cursor.enclosing-decl-edge sharpened with the measurements).
  CLEAN m2 == m3 at 324,035 lines; census 0; comment-refs 0; frontier
  286/0; proof-exactness 9/9; crown 5/5.
- 2026-07-28 · ▶ THE POSITIONING WRITEUP — Arc 2 closes (no re-pin —
  docs only). docs/POSITIONING.md states the category claim and both
  wedges with every claim's command inline, each re-run against the
  live pin before the doc landed: the absence suite (13/0), the MCP
  handshake through the installed shim, the field projection on
  tutorial/07, the march, doc-truth, and the sha/PROVENANCE reads. The
  honest-boundary section carries what is NOT claimed
  (spec-faithfulness above the crown; V_Pending 139 on the wheel's own
  self-compile, spoken not hidden; classes arm one at a time; the
  correctness oracle still external). Arc 2's terminal gate held on
  all three legs — clean-clone repro (the clone's own boot judges,
  runs the benchmark 13/0, serves MCP; the exec leg rides the shim per
  the seam's design, verified through the installed shim on the
  README's own path), benchmark published with baselines, writeup
  artifact-backed. The campaign's cursor moves to Arc 3 (proofs) with
  Arc 4's ranker increment pull-forward eligible.
- 2026-07-28 · ▶▶▶ THE GATE SERVES AGENTS — `mentl mcp`, the Synth-gate
  on MCP stdio; Arc 2's agent-cage demo lands (· pin 347b0a41). Any MCP
  client connects over newline-delimited JSON-RPC and PROPOSES source
  through ONE tool — propose — because the category is one property:
  nothing executes unproven. The judge is the canonical converged stdin
  judgment (infer_program_converged; spans are the agent's OWN lines by
  construction — the felt walk's opening find was that the DRIVER path
  renders weave coordinates, "at 5315:4" for line 5 of a 10-line file,
  which redirected the tool to the stdin channel where the problem
  cannot exist). TWO one-home extractions landed with it, each ending a
  three-copy family: gate_reads (the gate LAW's judge half —
  executable_gate keeps refuse+proc_exit, battery_compile keeps
  count-and-continue, the server keeps verdict-as-data; the server
  outlives every refusal) and diag_line (THE diagnostic render — the
  root arm, the branch bank, and the mcp collector all read it). The
  collector is tighten's forwarder shape plus the load-bearing
  diag_absorb arm: the converged judgment banks each stmt's diagnostics
  in its branch cursor and replays them at the join through that op —
  measured on the first walk, branch-judged lines reached stderr but
  not the verdict until the arm landed. The serve loop is battery_loop's
  region law at the server: raw recursion, zero cross-iteration state,
  mark before the read, print before the reset — the server's heap
  stays flat for its whole life, every request's full compile included.
  Emission streams through wat_to_file to .build/mcp/last.wat: only
  proven bytes ever land (a refusal never opens the file), and stdout
  carries protocol lines only. RIDER, the ⟐ law live: the wheel's first
  negative float literal in argument position (the JSON-RPC error
  codes) hit emit_unaryop's word-floor — the i32 sink-and-subtract
  dance on an f64, an assembly refusal — and the arm now reads the
  node's repr live (emit_unaryop_for: f64.neg/f32.neg native, the word
  dance at the floor); the fix crosses this generation per the crossing
  law, so the codes ride as the Ints they are (float_of_int at the one
  JNum boundary — the truer form regardless). GATES: four frontier legs
  (handshake+tools/list · REFUSED with both teaching lines at
  file-local spans · PROVEN with the artifact nonempty on disk ·
  isError/-32601/ping), seen RED against the pre-verb boot (exit 2,
  zero jsonrpc lines). The walk transcript IS the demo: REFUSED carries
  E_EffectMismatch at 3:4 AND E_EffectUnhandled's full install-teaching;
  PROVEN carries the tighten-teaching ("declares !E but body only uses
  Pure") — the gate teaching even on success. CLEAN m2 == m3 at 323,725
  lines; census 0; comment-refs 0; frontier 285/0; proof-exactness 9/9;
  crown 5/5. Named residue: Hβ.diag.file-local-span-render — the
  driver-path check still renders weave spans with a subsystem prefix;
  the register (ScopeAt) already carries the entry's range so the
  render should subtract, but diag_branch banks PRE-RENDERED lines, so
  the banked tuple must carry the span structurally first.
- 2026-07-28 · DOC-TRUTH — prose gets a mechanical floor (no re-pin —
  tools only; the docs-stay-true machinery's first rung, destiny named
  in its own header: docs-as-projection + `mentl audit`).
  tools/doc-truth.sh runs inside verify (and so inside every
  pre-commit): the PROVENANCE head sha must equal
  sha256(boot/mentl.wasm) — the fabrication law mechanized; the §7
  ledger's most recent pin must be the boot sha's prefix; and every
  tools/ command the four reader-facing docs name in present-tense
  position must exist (the §7 ledger excluded as history — its first
  run correctly distinguished the comment-audit.sh deletion RECORD
  from a broken promise). Zero-tolerance, not ratchets — these are
  exactly true always. Instrument-checked RED both ways (a planted
  bogus command refused; the true state passes). Rides with the same
  arc: §5 gains THE OPTIMALITY HALF (Morgan's charge — proposals are
  extraction-optimal, not merely proven; the copilot channel vs the
  medium channel stated plainly), §11's Arc 2 window re-measured by
  live fetch (MoonBit 0.9 shipped verification-as-feature April 2026
  with its own agent — the contest is live before their 1.0; Scala CC
  concedes no negation; spec-kit's 124k stars concede "no automated
  validation" — intent captured in markdown, no gate), the positioning
  writeup gains its second wedge (THE SPEC THAT CANNOT BE IGNORED),
  the FELT-PATH-FIRST LAW banked (every arc opens by walking its felt
  path through the shim — the register was the demo's true first
  landing), and Arc 4's ranker increment marked pull-forward eligible
  (no dep; the obsolescence thesis's nearest lever).
- 2026-07-28 · THE PROPOSER SPEAKS THE REGISTER — a synthesized
  candidate's Reason is genuinely unlocated and speaks the medium's
  voice (the demo transcript's last two blemishes · pin d6826c2e).
  All thirteen candidate mints wrapped their Reasons in
  Located(span_zero(), …) — fabricating a source site for a node the
  medium synthesized (the ghost the refs facet already filters), while
  reason_span_or_zero's own doc says unlocated falls back to zero: the
  mint contradicted the projection it fed, and every survivor line
  rendered "at 0:0-0:0:". The wrappers DELETE (span-neutral by the
  fallback's own definition); the eleven "synth_proposer: …" strings —
  an internal fn name in user-facing text, the substrate-vocabulary
  rule — re-register as the medium's voice ("the type's integer
  inhabitants", "the unit type's one inhabitant", "a nested ?? — the
  shape narrows, the fill recurses"); the two gate assertions pinning
  the old strings move with them. The survivor line is now
  "0  — inferred from the type's integer inhabitants". CLEAN
  m2 == m3 at 321,181 lines (130 smaller — the wrappers gone); census
  0; comment-refs 0; frontier 281/0; proof-exactness 9/9; crown 5/5.
- 2026-07-28 · ▶▶ THE RENDER REGISTER — narration scopes to the file
  the user asked about; errors always render (the banked user-path
  flood residue closes; the five-minute demo's DEP · pin 3f889ff5).
  Measured at the demo's own doorstep: `mentl bit.mn:8:30` printed 173
  substrate-lint lines before the six-line answer. The dig named two
  mechanisms, neither fixable by a source sweep: every parse warning
  printed TWICE (the DAG discovery walk parses each module for its
  imports and reports in FILE-LOCAL coordinates no range can place;
  the weave parse re-reports with weave spans — the long-standing
  doubling, explained), and a solo weave's T_OverDeclared/comment-ref
  verdicts on wheel fns are weave-RELATIVE — the wheel census holds
  the same fns clean, so the warnings are not truths about the shipped
  source at all. THE REGISTER (SYNTAX's own law — how much surfaces is
  relevance read at the cursor — at the diagnostic surface):
  DiagScope = ScopeAll | ScopeNone | ScopeAt(start, nlines) rides the
  root diagnostics_handler as state via the single-op DiagRegister
  effect (armed on the root only, the BranchDiag precedent — quiet,
  branch, and tighten's forwarder untouched); the DRIVER owns both
  performs at one home (ScopeNone before discovery — a structure read
  is not the reporting pass; ScopeAt(entry range) the moment the
  concatenation fold completes, before any reporting parse exists);
  the branch bank grows to (line, span-line, is-error) so the join
  re-applies the same register; ERRORS RENDER IN EVERY SCOPE — the
  register is never a mute — and the census paths (compile_stdin, the
  march) never perform the op, ScopeAll byte-for-byte.
  range_of_module moved to driver.mn beside the fold that mints the
  map (the DAG direction forced what one-home wanted). Gates seen RED
  on the prior boot: the full-weave address query (173 Warning lines →
  0 with the fan intact) and the own-narration control (the user's own
  E_RedundantBraces renders exactly once). One widen round
  (driver_compile_entry +DiagRegister) → census 0. CLEAN m2 == m3 at
  321,311 lines; frontier 281/0; proof-exactness 9/9; crown 5/5;
  comment-refs 0. Named residue: the warm/incremental path
  (driver_incremental) re-judges its cone without a scope perform —
  cone diagnostics already carry file-local attribution; the scope
  joins it when a probe shows substrate narration leaking there.
- 2026-07-28 · THE ABSENCE BENCHMARK PUBLISHES (the category ship's
  first deliverable; no re-pin — benchmark artifact only, the wheel
  untouched). benchmarks/absence: thirteen self-contained tasks whose
  first line states the contract (`// expect: PROVE` | `REFUSE
  E_Class`), judged by the pinned wheel itself over solo compiles —
  eight severance shapes (direct, transitive, the higher-order leak,
  stored closure, Pure-total, sibling past absorption, branch
  reachability, the agentic tool-loop cage) against five controls cut
  from the same shapes (empty body, pure-lambda HOF, five-deep chain,
  absorbing install, composed !A+!B), so under- and over-refusal both
  score. Baseline 13/13 with a teaching span on every refusal; the
  runner is itself a gate (a violated expectation prints the miss and
  exits nonzero — instrument-checked live). The README names the
  nearest prior in print (Flix effect exclusion, ICFP'23/OOPSLA'25)
  and the growth tiers in positive form (instance precision, TIME,
  !Flow), and states the judge's provenance as verify-by-replay
  (march to the byte-identical fixpoint). The podium this enters is
  empty: no current verification benchmark measures proving the
  negative.
- 2026-07-28 · ▶▶▶ THE FAN RIDES THE SPAWN — every ?? candidate verifies
  as a REAL branch cursor over the shared image (Arc 1's core: the fused
  oracle's second workload · no re-pin — CLEAN m2 == m3, the wheel's
  emission untouched). THE FACTOR: branch_bracket — the judgment's
  eleven-handler chain extracted whole (one chain, two workloads;
  branch_judge keeps its stmt body — the uniform pass beats the per-site
  family). THE ISOLATION LAW that makes the fan race-free: the
  sequential form was bind→rollback, net ZERO shared writes, so each
  spawned candidate verifies against a FRESH INSTANTIATION of the target
  in its own planned band — the value-boundary law at the hole (the
  constraint is a published scheme; candidates are its callers;
  instantiate(Forall(free_in_ty(target), target)) is the whole copy
  machine). fan_verify plans bands off graph_next (2048 + the overflow
  quota per candidate), pre-opens pages at the ROOT (a branch never
  opens), spawns blocks of judge_window, joins in candidate order
  replaying each task's facts record through branch_join WHOLE (the fork
  triple never covered env/diag/verify state — byte-identity means
  replaying sequential's debris exactly, proven or not), and seals past
  the fan so no later mint reuses a stale band's cells.
  enumerate_inhabitants fans FIRST; the arm's resume walk then reads
  precomputed verdicts (resume stays arm-bound, SYNTAX's law). The judge
  asked ONE widen: verify_each_enriched's row spelled to the fan's truth
  (WasiThreads + BranchEnv + BranchDiag + Consume + Verify + Intern +
  WASI; Synth dropped — no op performed anymore). THE DONE-CRITERION
  adopted at the decl, scoped per the fx2-fan sweep: Programming by
  Navigation's Strong Soundness + Strong Completeness
  (Lubin–Ziegler–Chasins, PLDI 2025; the errata's covering reading) over
  the DECIDABLE fragment only — V_Pending sits outside the guarantee
  (unscoped, the pair is provably impossible); an empty fan is
  Fail-Fast's THEOREM — no valid completion exists — rendered as the
  teachable refusal. GATES: CLEAN m2 == m3 at 320,847 lines; census 0
  (one widen round); frontier 279/0 — every ??-workflow leg through the
  SPAWNED fan byte-matching its banked expectations; SIX identical shas
  on each of three fan legs (the two.mn:0 field, the bit.mn:8:30 tie,
  the hole.mn:9:37 socket). Named residue:
  Hβ.synth.annotation-fan-pure-proof (try_each_annotation's fan needs
  narrow-WITHOUT-bind — row_subsumes against the copy, no shared-cell
  bind; the sequential form stays until then) ·
  Hβ.felt.tie-teach-behavioral-scenario (the Choose-Don't-Label form —
  one precondition + k≤4 mutually-exclusive covering options rendered as
  TYPED FACTS, minimax selection DP(Q)=1−max|H_i|/|H|; gated on
  !E-speculation; the landed k=2 named-constraint teach is its
  degenerate case). Band E's work-stealing-via-gradient keeps its name —
  the substrate it needs is now proven.
- 2026-07-28 · ▶▶▶▶▶ THE LATTICE COMPLETES — the teaching write is a
  JOIN, the scheme boundary is a VALUE boundary at every face, and
  K=8 becomes the default judge, byte-equal to sequential (Arc 0 of
  the finish-line campaign lands whole · pin 28c39633). THE ALGEBRA:
  row cells are join-semilattice LVars — graph_bind_row's bound arm
  JOINS (row_join: bare names union; parameterized instances COEXIST
  as fragments; joins commute and idempote, so N caller branches
  teaching one cell converge in ANY order — the LVars/CALM law), the
  decl-exit REPLACE rides its own op (graph_finalize_row: two
  algebras, two ops), and FRAGX stays armed as the standing collision
  census. THE FROZEN READ: subst_ty_build/subst_row_build decide by
  the MAPPING before any live chase (a quantified var free at the
  freeze freshens even when since-bound — post-freeze teaching is
  another caller's private constraint; only the deliberately-
  unquantified miss chases: handler config↔payload two-phase, mono
  self-entries, pre-freeze-bound structure) — census 86 through the
  join judge (instance payloads meeting positionally across
  coexisting fragments) fell to ZERO at the root, the install
  reconciliation needing NO new machinery. FRAGMENT IDENTITY IS
  GRAPH IDENTITY: the first march ruled BROKEN (m3 ≠ m4 by 13 lines
  — ONE can_yield flip on driver_incremental) and convicted addr()
  — dedup-by-address is deterministic within one binary and unstable
  across two (region resets re-issue addresses); frag_args_same
  compares arg HANDLES and scalar payloads, a pure function of the
  source. THE DEEPEST CUT, forced by the terminal gate itself: the
  six-battery split 5-1 and the window-1 judge byte-equaled the RARE
  attractor — the dominant K=8 attractor was DIVERGING from
  sequential semantics (a lost k2 yield wrap), and the march's
  m3 == m4 had blessed it by two lucky coin-flips. The bind census
  on the flip's own cell convicted the PUBLISH: a declared fn's
  bound row cell rode EtVar through generalize's chase into its
  published scheme — a live pointer into the decl's band that
  concurrent callers folded mid-flight. chase_row_deep resolved
  payloads but passed the TAIL untouched (chase_row_changes ignored
  it entirely); both faces gained the bound-tail arm — the fold to
  VALUE by recursion, subst_row_build's law at the chase face. A
  published scheme is now a value or a quantified var, never a live
  pointer. K-INVARIANCE PROVEN: the window-1 judge's bytes EQUAL the
  K=8 judge's bytes, six identical shas on the battery — determinism
  by algebra, sequential-equivalent, at the fused oracle's default
  width. The sharper value-boundary judge then convicted 65 honest
  under-declarations in the wheel (58 mostly missing Alloc — payload
  ctors allocate; 7 `with Pure` reading Memory) — widened in ONE
  round to census 0, the honest-attribution precedent at its third
  scale. Riders: safe-for-space stated as collect_free_vars'
  invariant (Shao–Appel); §0's absence claim made precise per the
  fx2-crown sweep (the Flix line owns name-keyed !E under
  polymorphism — ICFP'23 effect exclusion, OOPSLA'25 Boolean
  qualifiers; Mentl's seat is the CONJUNCTION: absence under install
  IDENTITY × modality × TIME × INSTANCE, each measured empty
  2026-07); Modal Effect Types trued to OOPSLA 2025; Granule to
  OOPSLA'24. Board whole at the pin: CLEAN m2 == m3 at 320,102
  lines; census 0; comment-refs 0; frontier 279/0; proof-exactness
  9/9; crown 5/5; judge_window = 8 IS THE DEFAULT — the fused
  oracle's execution substrate is the everyday judge.
- 2026-07-27 · ▶▶ THE BOUND TAIL FOLDS BY RECURSION — the trio law
  completes at the subst face, and the rebind chain gets its name
  (the K>1 dig's third arc · pin 2ef0964e). subst_row_build's merge
  arm checked ONE level of a bound row chain and SHARED the whole
  chain on the inner-tail miss (ef_make(ns2, ab2, EtVar(v))) — but
  free_in_row DESCENDS bound tails recursively, so a chain bound two
  deep carried its free terminal in the OWNER's band past both the
  quantify and the mapping: every caller of a recursive fn's scheme
  read the owner's live cell and the first caller bound it (the
  reason census caught cell 1873202 bound at four handle_to_smt call
  sites across two branches). The arm now RECURSES into the binding
  — the recursion's own arms subsume both former branches (an inner
  free tail freshens through the mapping with the pending-
  subtraction's absent set riding; a solved tail merges whole),
  nested frees freshen at ANY depth, the chain is never shared, and
  the inner fork DELETES (the wheel 178 lines smaller — the law
  smiling). The check twin answers true for every bound tail
  (folding IS the change). THE BORN-REASON CENSUS then named the
  surviving window-8 flip whole: each foreign row bind printed with
  the PREVIOUS binding's reason, and one shared row cell per
  mutual-recursion family (emit_expr's, walk_locals_pat's,
  list_copy_into's) showed a born-to-why chain FIVE DEEP — the same
  cell SERIALLY REBOUND by its same-layer caller branches, each
  call-edge unify graph_bind_row-ing an ALREADY-BOUND root, the
  surviving binding whichever branch ran last (lower's can_yield
  reads the schedule's pick — the float-trio k2 wrap flip, two
  self-stable attractors, census 0 in both). Rebinding a bound root
  is the union-find law violated regardless of concurrency; the
  rebind instrument (print when graph_bind_row's target already
  chases NRowBound — a small set naming every rebinding unify path)
  and the kill plan (those paths recurse into the binding instead)
  are banked at judge_window's decl. The window holds at ONE. Board
  whole at the pin: CLEAN m2 == m3 at 323,700 lines; census 0;
  comment-refs 0; frontier 279/0; proof-exactness 9/9; crown 5/5;
  micros-through-m2 116/0.
- 2026-07-27 · ▶▶▶ THE KILL LEDGER REACHES THE WRITERS — the value
  boundary closes at generalize, and compression leaves the branches
  (the K>1 dig's second arc · pin 714431ce). Six probe batteries —
  the per-branch bind census with band bounds (the branch's own base
  as the self-locating gate, after hard-coded targets died to their
  own tree-shift), the can_yield tail census, and the REASON census
  whose every prior-generation row bind confessed one string — killed
  SIX labels against the artifact: (1) the prepass registrations were
  INNOCENT (register_one_op's qvars span params + ret + row — op
  schemes were fully quantified all along; the 101 prepass-band binds
  are each handler decl's OWN branch binding its residual,
  layer-protected by the VarLookup edge); (2) the NFree/NRowFree
  publish fallbacks were REAL shared cells — generalize published
  Forall([], TVar(handle)) and every caller shared-and-bound the live
  cell, callers teaching the decl through the publish (the
  order-conditional disease at the value boundary) — generalize now
  QUANTIFIES its unresolved arms, instantiate's sort-aware mint
  freshens per caller, and the wheel proved the fix Law-7-inert
  (CLEAN m2 == m3 at window 1: no reachable site ever depended on
  caller-taught bindings — the converged judge had left none); (3)
  row path compression was the LARGEST shared-write class (1,463
  foreign row binds per compile, reason "row path compression" —
  branches rebinding prior-generation chain cells as an optimization,
  making sibling chases schedule-dependent) — compression now rides
  its OWN op, graph_compress_row, whose branch arm SKIPS while the
  root's sequential walks re-compress: the write's INTENT carried by
  the op, the policy in the arm where the band facts live, no flag.
  Also counted as kills: the conflict-requeue fan design (refuted by
  its own volume census — 707 branches bind prior-gen cells, requeue
  would collapse the fan to sequential), EANode as the walk gap
  (effects.mn never touches it — skip-skip symmetry holds), and the
  paired-lim cross-branch-judgment theory (the pairs are ONE branch
  pre/post overflow — limit0 vs high_limit). THE RESIDUE, confined
  and named at judge_window's decl: the float-format trio's k2
  yield-floor wraps still flip between TWO self-stable attractors
  (4-2 at window 8, ±55 lines, census 0 in both); the surviving
  writer class is the ~2,000 Located unify-path binds through shared
  reaches, and the next probe is banked (re-arm the bind census,
  diff the flipped attractor's foreign-bind set, fix the named
  carrier at its mint). The window holds at ONE — byte-proven CLEAN.
  Board whole at the pin: CLEAN m2 == m3 at 323,878 lines (~22s/leg);
  census 0; comment-refs 0; frontier 279/0; proof-exactness 9/9;
  crown 5/5; micros-through-m2 116/0.
- 2026-07-26 · ▶▶▶ THE DIG NAMES THE RACE'S CELLS AND THE PUBLISH
  FREEZES (the K>1 dig's first arc · pin 2df771e2). Six-run window-8
  batteries turned the flip into a mechanism, three measurements
  deep: (1) the flip is per-run single-callee k2 yield-floor wraps —
  the float-format family (2-in-6, both flipped runs IDENTICAL: two
  deterministic attractors), then driver_incremental — each traced to
  can_yield → row_may_multishot chasing ONE row var bound in some
  runs, free in others; (2) the callee's scheme is DECLARED-CLOSED
  (mentl query read it), so the raced cell is upstream of the scheme;
  (3) THE PUBLISH FREEZE landed — branch_replay_one chase_deeps every
  join-crossing scheme to a VALUE, the value-boundary law at every
  publish kind, not just FnScheme — and the flip MOVED instead of
  dying, which CONVICTS the remaining shared-live-var carrier: the
  PREPASS registrations (register_effect_ops /
  pre_register_handler_sig) hold live sig vars every branch's
  installs and op edges unify against; same-block concurrent binds on
  one prepass cell are the race. The handler-sig barrier class is
  thereby confirmed REAL (my earlier "measured-implied vacuous" was
  wrong — counted as the kill it is). K>1's landing design, banked at
  judge_window's decl: the value-boundary law reaches the PREPASS —
  op and handler registrations publish quantified VALUE schemes, each
  branch instantiates fresh at its install or op edge, and
  cross-branch instance agreement rides the join's replay algebra
  (the op half already built as branch_replay_one's edge-evolution).
  ALSO LANDED: the crc walk bounded to its own pass's parse range
  (comments attach at parse — the old 0-to-graph_next walk probed the
  judgment's millions of mints AND judged every stale generation's
  comment copies; the 19% profile share dies, ~23s → ~20s/leg), and
  the window at ONE, proven deterministic across three identical
  runs. The freeze's 8-line m2/m3 crossing is Reason renders
  sharpening through frozen values (TRANSITION m3 == m4). Board
  whole: census 0, comment-refs 0, frontier 279/0, proof-exactness
  9/9, crown 5/5, micros 116/0.
- 2026-07-26 · ▶▶▶▶ THE WEAVE FLATTENS AND THE FAN MEASURES ITS FIRST
  RESIDUE (Morgan's catch executed · pin c7f08fdf). "Since when does
  Mentl take so long?" — the convergence landings had shipped a ~60×
  wall-time regression UNMEASURED (5.3s at the B-ii pin → 5:42), and
  the session normalized it to the point of comparing spawn-vs-
  sequential at the bloated baseline and calling 3% fine. §5.O
  re-applied: host perf named the whole thing in ONE line — 98% of
  the self-compile inside attach_comment_weave → cw_scan_index →
  list_index_unchecked (97.9% self): the bsearches were already
  O(log R), but every runs[mid] probe walked a push-built SNOC spine
  (the crc_scope disease at the weave layer), and the cost multiplied
  by every re-frontend the trial/rounds/final run. ONE FLATTEN
  (list_to_flat at the attach boundary — span_index one line above
  was already flattened) recovered 15×: 5:42 → ~23s, ~2.3s/pass at
  the convergence's pass count — the architecture honest again. THEN
  THE FAN AT K=8: the block window (spawn a block, join in stmt
  order) ran the whole self-compile at 140% CPU — and ITS OWN
  instrument convicted the first residue: one lambda's k2 yield-floor
  wrap (lambda_1731074's __kf local + multishot floor) flipped in ONE
  of FOUR otherwise byte-identical runs — a rare schedule-dependent
  race in a post-seal lower-era staging read of branch-written state.
  Un-pinnable at K=8 by its own gate; the window holds at ONE (every
  branch still a REAL spawned instance — the substrate stays live and
  byte-proven; CLEAN m2 == m3 at ~26s/leg, deterministic across
  runs). THE K>1 DIG, banked with its instruments: repro = the
  window-8 self-compile diffed across ~4 runs; suspect set = the
  boundary-cell writes same-block siblings can interleave + any
  pointer-identity compare the CAS-bump's schedule-varying addresses
  can flip; the index-read borrow law also landed (an xs[i] receiver
  is the read-is-a-borrow law's fourth surface — the affine ledger
  demanded restructuring of the fan's provably-safe join, the
  Hylo-quiet bar naming the gap; judges from the next generation).
  Named next flatten-class strike: crc_walk (19% of the healed
  profile, list_index beneath it). THE LESSON, now law-shaped: a
  landing that multiplies passes RE-MEASURES wall time in its own
  entry — the convergence entries shipped without a single timing
  and the regression rode two sessions unchallenged. Board whole:
  census 0, comment-refs 0, frontier 279/0, proof-exactness 9/9,
  crown 5/5, micros 116/0.
- 2026-07-26 · ▶▶▶▶▶ THE JUDGMENT SPAWNS — every stmt's judgment runs
  as a REAL host thread over the shared image, and the spawned judge's
  bytes EQUAL the sequential judge's (rung 3 lands; the fused oracle's
  execution substrate is LIVE · pin 5cb95039). layer_judge_walk spawns
  each layer branch as a task — spawn_task/join_task direct (substrate
  ops, no install), spawn-join IMMEDIATE so the whole substrate (task
  records, per-instance identity and init, the shared-image memory
  flip, the self-contained bracket, the facts record crossing back at
  join) is proven under the byte gate with zero race surface;
  concurrency is now the in-flight count, not a semantics change. TWO
  pieces completed the task body: the INTERN VIEW (read-only over the
  root's table via the intern_seed export; probe hits serve — the walk
  is parse-pre-warmed — and a miss traps loudly, since a view-minted
  handle would fork identity into published state) and the OUTER
  SHAPE — the one trap of the landing, measured to its floor with a
  6,444-line repro in ~40s: an arm's performs resolve OUTER to its
  install (R2), so diag_branch's renders chase OUTSIDE the bracket;
  sequentially they land on the dispatch chain's EMPTY graph instance,
  whose density guard answers virgin t{h}@e0 — a DISCOVERED latent
  wrong-instance read (the sequential renders were reading the
  guard's fabrication all along, named
  Hβ.diag.render-chases-wrong-instance for its truth-landing) — and a
  spawned world had NOTHING there, so show_handle died on garbage.
  The task body now wraps the bracket in the root's own outer shape
  (an empty dispatch graph instance), reproducing the sequential
  answers byte-for-byte. THE VERDICT IS THE STRONGEST FORM the design
  admits: the march ruled CLEAN m2 == m3 — the spawned judgment
  reproduces the SEQUENTIAL judgment's bytes EXACTLY (the banded
  partition's execution-order-free numbering cashing out at the
  march itself), and the WHOLE BOARD holds through the spawning
  compiler: census 0, comment-refs 0, frontier 279/0, proof-exactness
  9/9, crown 5/5, micros 116/0 — every gate's every compile spawning
  a thread per stmt. The wheel is a SPAWNING MODULE: shared-image
  import, CAS-bump allocation, per-instance init. Cost measured:
  ~5:42 spawned vs ~5:31 sequential (the serial spawn tax ≈ 3%). THE
  REMAINDER is now literally a scheduler: K>1 in-flight tasks per
  layer (the joins already run in stmt order regardless of completion
  order) gated by the same-layer handler-sig barrier class (both
  installs bind one prepass-minted sig — sequential post-join or
  own-layer those stmts) + the pointer-identity census under real
  concurrency; then the ??-fan rides the identical machinery.
- 2026-07-26 · ▶▶▶ THE PARTITION GOES EXECUTION-ORDER-FREE — banded
  overflow completes the deterministic-handle-partition keystone
  (rung 3's opening pair · pin f7c96d1b). The interrogation on the
  spawn found the threaded form's own latent collision first: branch
  overflow mints live above a seal that parked `next` below them —
  graph_mint_seal now takes the walk's true frontier. MEASURED
  (OVERFLOWPROBE, probe-then-decide): 612 overflow handles across 324
  stmts, EVERY delta 1 or 2 — the fingerprint-blindness residue on
  the convergence's carried counts, systematic and tiny — so the
  threading DIES into per-stmt PRIVATE overflow bands (64 handles,
  32× margin, ~11 pre-opened spine bands ≈ 4MB): the mint arm's jump
  takes the banded ceiling (high_limit, config slot 7; 0 = the root's
  unlimited today-form) and CONSUMES the target, so a band-crossing
  mint meets mint_high 0 and the EXISTING unseeded guard traps loudly
  instead of invading a neighbor's band. graph_mint_high and the
  branch-to-branch high threading DELETED (the region end is static —
  less code, the law smiling). Numbering — overflow jumps included —
  is now a PURE FUNCTION of (source, plan) with zero execution-order
  input: the fan reproduces the sequential bytes at ANY K, which
  upgrades the C1c gate from self-stability to true byte-equality.
  TRANSITION m3 == m4 at 322,925 lines; census 0 at every generation;
  frontier 279/0; proof-exactness 9/9; crown 5/5; micros 116/0. THE
  SPAWN'S REMAINING PAIR, scoped exactly: (1) the intern VIEW —
  intern_table gains the config triple (buckets0, entries0, count0) +
  an intern_seed export; a branch view's READS serve (renders need
  intern_name_of); its MISS is LOUD by the banked law (a
  branch-minted intern handle escaping into published state would
  read garbage at the root — never an accident-invariant); measured
  expectation: zero misses (all names intern at parse). (2) the
  spawn walk — spawn-per-branch join-immediately first (every branch
  a REAL task via the substrate's spawn_task/join_task, the wheel's
  shared-image memory flip as the measured TRANSITION, zero race
  surface), then K>1 with the same-layer handler-sig barrier class
  settled (both installs bind one prepass-minted sig — sequential
  post-join or own-layer those stmts).
- 2026-07-26 · ▶▶▶▶ THE BRANCH CURSOR IS WHOLE — every handler
  branch-local, the spawn now pure scheduling (rung 2b closes the
  bracket's self-containment · pin 4a1363ab). The graph instance is
  the C1c-2a config cashed out: six slots (span_index0 + high0 join
  the four), the graph_branch_seed export (the post-plan spine table +
  open count + the span index, complete because graph_index_span is
  parse-only — measured, one grep), graph_mint_at DISSOLVED into
  per-branch config, and lookup_ty_graph + mutate_sink fresh in the
  chain. THE ONE TRAP taught the design's own law back: the first
  branch-instance run faulted at the 4GB boundary inside
  graph_fresh_ty — overflow is a DESIGNED path (C1b: an over-measure
  stmt jumps above the plan), the root healed it through its live
  mint_high, and a branch's zero high minted at handle 0 over the
  Module root. The open-space frontier now THREADS branch to branch
  (graph_mint_high read at each branch's end feeds the next branch's
  config; layers thread it too) — the root's sequential semantics
  exactly, with the spawn era's abort-and-requeue the banked
  tightening. TRANSITION m3 == m4 at 323,185 lines (the 7,778-line
  m2/m3 crossing is the new machinery + the shifted judgment paths);
  census 0 at every generation; comment-refs 0; frontier 279/0;
  proof-exactness 9/9; crown 5/5; micros-through-m2 116/0. With rungs
  1–2a (the barrier shape fa5bedca; the three ledgers a33c6dfc; the
  inner trio 78a7575d — each CLEAN m2 == m3), the branch bracket now
  carries ALL ELEVEN handlers; the intern rides ambient read-only
  (trial-pre-warmed). Rung 3 — the spawn itself — is scheduling: the
  bracket becomes the task body, joins stay stmt-ordered, the
  shared-image memory flip is the measured TRANSITION, and the
  same-layer handler-sig barrier class is the one settle before K>1.
- 2026-07-26 · ▶▶▶▶▶ THE SCHEME BOUNDARY BECOMES A VALUE BOUNDARY —
  census 0 with the judge CONVERGING, the incremental cone lands, and
  five roots fall in one continuous dig (the ratchet's raised lane
  closes; pin = the march in flight, blessed in PROVENANCE). Morgan's
  opening catch ("'honest' is slimey wording... i catch you beating
  around the bush") redirected the session from carrying census 3
  behind a raised ratchet to killing it — and the banked diagnosis
  ("the rounds lose the subtraction") died to the artifact in the
  first hour: new source + OLD judge = 0, new + NEW = 3, but the
  11-line repro failed under BOTH — the deepest root PREDATES the
  rounds; convergence only exposed it. THE FIVE ROOTS, each measured
  before fixed, each a Carried-Truth violation at the SCHEME boundary:
  (1) subst_row's bound-tail arm DROPPED the mask's absent set — the
  pending `~>` subtraction died at instantiation (bracket(() =>
  ping()) leaked Ping; the solved arm one line down always carried
  it); (2) the CREATION EDGE charged a closure's whole row to its
  CREATOR (the mint-time-evidence relic — world-as-value R2 made
  performs resolve at the CALL site, so abstraction is pure, the row
  rides the TFun, the call edge charges appliers; deleted, and every
  absorbed-thunk pattern stopped leaking); (3) the call/pipe edges
  SHARED a top-level loose scheme's raw row handle into the caller's
  frame (the pre-convergence forward-ref crutch — retroactive flow
  through shared mutable vars; under rounds, iteration replaces it:
  the share-guard keys on FnScheme, params/locals keep the
  polymorphic share); (4) the round prepass re-minted every handler
  sig unconditionally while the cone masked the decl's judgment out —
  entries flipped bare↔resolved forever (the movers projection named
  the whole iterate-handler family in one line; the prepass is
  cone-gated now); (5) THE T-HANDLE ROW-VAR CLASS — the loose
  pre-registration mints function-type row vars as TYPE handles
  (parse_type_ty's named residue), and the sort-blind
  row_var_is_free made BOTH of infer_context's scheme row tails
  invisible to quantification while subst_row's catch-all SHARED
  them: every caller chained ONE live row, the first binder's thunk
  row became everyone's mismatch (the CALLPROBE render caught the
  stored scheme MUTATING between its callers' reads — the smoking
  gun), and the three-walk tolerance (free/changes/build agree on
  NFree-in-row-position; occurs was already handle-keyed) closed it.
  ZERO row mismatches in the whole self-compile — not even absorbed
  ones — and the rounds CONVERGE (no bound-hit; race, the last
  monotone mover, finishes inside the raised bound of 12). THE
  INCREMENTAL CONE rides the same landing: round K+1 re-judges only
  stmts whose fingerprint moved between the last two rounds or whose
  free names moved (stmt_frees collected once serving layers AND
  cone; skipped stmts' finals persist by latest-wins, their sizing
  rows carry; the cone is a pure comparison of the two carried print
  lists — a live env read at cone time can only answer "unmoved").
  Micros mn-absorb-poly + mn-absorb-poly-fwd bank both faces RED-first
  (E_PurityViolated through the prior boot; 0 errors, run 42 through
  the fixed judge). PROBES GRADUATED per the new ⟳ law: movers_line
  is the bound-hit's permanent residue-naming projection;
  report_effect_mismatch carries its Reason to the report site
  (Hβ.diag.effect-mismatch-reason names the DiagKind widening); the
  scheme/layer questions the temporary probes answered are the query
  verb's existing projections. CLAUDE.md ⟳ hardened in the same arc
  (Mentl's own audit, spoken and executed): the discipline is
  PROPOSER-INVARIANT, the medium's projection is an ORDER not a
  preference (the unnamed confession is the violation), and a probe
  that answered a question GRADUATES before its landing closes. The
  named residue: the global parse_type_ty/pre-registration re-mint
  (row vars born as row handles — the tolerance is the boundary cure)
  and the fingerprint's bound-content blindness (backstopped by
  m3 == m4, as designed).
- 2026-07-26 · ▶▶▶▶▶ THE JUDGMENT CONVERGES TO A FIXPOINT AND THE
  BRANCH CURSOR LANDS SOUND (Phase C's C1c-2 whole; pin = the march in
  flight at write time, blessed in PROVENANCE. Retitled same day —
  "honest fixpoint" was cushioning language around a carried
  regression, Morgan's catch; and this entry's closing diagnosis of
  the census-3 trio is the ERA'S RECORD, superseded by the next
  entry's measured root). THE CONVERGENCE LOOP:
  infer_program_converged iterates QUIET ROUNDS (the trial's measured
  walk, fn pre-registration skipped, the final's prepass) until
  round-over-round scheme FINGERPRINTS stabilize (ty_fingerprint — the
  alpha-normalized total render: vars by first occurrence, rows by
  intern handle, EANode/predicates opaque with m3==m4 as the outer
  net), then ONE reporting, planned, bracketed final whose publishes
  EQUAL the converged set. The trial's finals were HYPOTHESES (its
  source-order walk read loose pre-registrations at forward refs —
  measured as lb↔i twin-enc flips across the classify/escape/crc
  family, and a wheel emitted from the uniform-but-unconverged side
  died at its first mint); the old walk's mid-walk shadowing read a
  self-consistent MIX that hid the divergence unGATED. THE BRANCH
  BRACKET (sequential form): every stmt judges under its own cursor
  pair — env over the frozen layer-start base (env_base_view /
  env_publishes armed on env_handler, answering BY INSTANCE POSITION:
  root = the capture, branch = the log) and diag_branch rendering AT
  COLLECT — with per-stmt replay through branch_join. FOUR ROOTS FELL
  TO MAKE IT TRUE, each measured first: (1) the affine branch stack
  pushed at the WRONG END (§9's own class — prepend vs last/drop_last;
  one frame worked by accident, nested alternatives corrupted the
  ENCLOSING frame — Hβ.infer.nested-alternative-branch-bracketing
  resolved at root, the hoist workarounds retired; the natural shape
  crosses one generation as row_print per the crossing law); (2) the
  EDGE-EVOLUTION JOIN — an EffectOpScheme publish is READ-MODIFY-WRITE,
  and value-replay lost the ambiguity join EXACTLY as the banked fan
  design predicted (measured: graph_mutated collapsed to a lsp_adapter
  singleton and the SingletonUninstalled floor fired at every
  compile's first commit-boundary mint, the floor's own baked teaching
  comment naming it); branch_replay_one re-runs draw_op_edges' own
  default/ambiguous algebra against the root's live entry; (3) THE
  LAYERS ARE PARSE TRUTH — the range-reason scan read ZERO edges
  (measured: VarLookup reasons land on PARSE nodes, minted before the
  trial's watermark, outside every stmt's inference-mint range — all
  stmts layer 0, every frozen base the prepass env, payloadfn's
  residual chain severed at the pre-arms scheme, diagnosed by the
  twin bracket-on/off experiments and the RowFree/RowBound floor-probe
  diff); stmt_layers_ast reads each stmt's own free names
  (collect_free_vars — the source itself), the range machinery
  deleted; (4) a free var in a piggyback effect's op return
  PARAMETERIZES the effect and the handler-arm binding refuses the
  mix (the de-parameterization law, stated at BranchEnv's decl). THE
  HARVEST the sharper judge convicted (census 15 → 0, every fix
  Law-honest): the dispatch EXIT-CODE CONTRACT across thirteen verbs
  (main's value IS the process exit; run_run 1, usage errors 2), the
  verify facet flowing WHOLE (Span, Predicate, Reason) obligations
  (the map-to-Predicate deleted; three row widens), the `<|` render
  unpacking its branch-tuple NODE, the record synth keeping field
  names with its holes, the lambda synth passing the scheme's own
  [TParam] (two fns deleted), and four honest row widens
  (driver collectors +GraphWrite+GraphRead, render_feedback_chain,
  candidates_at +Intern). RIDES WITH IT: the fmt write-time hook
  (post-edit-mn.sh's fmt rung — the parser's own P_ lines on a scratch
  copy, both faces seen RED/GREEN) and the payload-ladder micro
  payloadfn GREEN at its true 2 through the whole machinery. THE
  PROOF: the march's TRANSITION (m3 == m4) — the converged judgment
  REPRODUCING ITSELF — plus frontier 279/0, proof-exactness 9/9,
  crown 5/5, battery 114 in-process, census 0, comment-refs 0.
  THE PIN'S OWN RATCHET HOLDS IT UNBLESSED (correctly) ON THE LAST
  REMAINDER, measured to its doorstep: the blob-converged judge reports
  E_EffectMismatch ×3 at resume_image / compile_stdin / compile_source
  (pipeline.mn's three infer_context entries with AUTHORED rows) —
  their body rows carry the WHOLE analysis core unabsorbed, while the
  DAG judge absorbs correctly (measured by mentl query: infer_context's
  scheme row = Cast+Alloc+Memory+var, compile_stdin = WasmOut+WASI+…,
  both the absorbed truth). DISCRIMINATED (bracket-off census = 3): THE
  ROUNDS break the absorption, the bracket is INNOCENT — the quiet
  rounds' re-judgment of infer_context loses the effect-polymorphic
  subtraction across round generalization/instantiation (the callers
  then read body-row = result-row, the core leaking whole). The dig:
  how infer_context's scheme carries the r_result-to-r_body
  subtraction through generalize (bound-var sharing vs quantified
  collapse), compared round-1-final vs round-2-final via
  ty_fingerprint extended to render row-var IDENTITY links. AND the
  field-leg's collection suspect is CONVICTED-ADJACENT:
  enumerate_gradient_positions filters EVERY handle through
  teach_gradient — whose callee chain consumes the verify entries the
  arc changed from bare Predicate to whole (Span, Predicate, Reason)
  triples; a consumer still destructuring the old shape flips
  Some/None on junk (7 garbage positions, negative spans). Dig
  advanced two steps: refinement_invite_for's predicate param is
  UNUSED (the triple-as-Predicate pass is value-harmless), so the
  junk's mechanism is upstream — refinement_verdict_for computes
  pending = filter_by_span(caret_span_of_handle(h), debt) for EVERY
  handle enumerate_gradient_positions walks (range(0, next) — VIRGIN
  and gap cells included!), and a garbage span from an unminted cell
  can span_overlap real debt rows → nonempty pending → VerdictInvites
  → a junk handle enters the field. The root candidates: the
  enumerators walking unminted cells at all (the graph knows a virgin
  cell — filter by chased kind), and the rounds multiplying `next` so
  the stale/virgin population grew past the field leg's tolerance.
  Fix at the enumerator (minted-only walk), re-run the field leg.
  SHARPENED ONE MORE STEP at the wire: the rendered `-5240` is
  `sl - fstart + 1` with fstart ≈ the module's weave start (~5250 —
  two.mn sits after prelude+libs in the DAG blob) and sl ≈ 10 — the
  junk positions are LIB-RANGE nodes leaking through a filter that
  should have excluded them (field_positions demands
  sl >= fstart && sl < fstart + nlines), so either the filter's
  fstart and the render's fstart differ, or the two
  caret_span_of_handle reads disagree across the ranked re-read.
  RESOLVED TO THE BYTE: t1072064102 = 0x3FE68F5C — THE FLOAT
  SCORE'S HIGH WORD read as the handle. field_ranked mints (sc, h)
  pairs with sc: Float (Cursor's third field via score_one_position);
  render_field_tier's `let (_, ph) = ranked[i]` destructure compiled
  AT THE WORD FLOOR (ph read at offset 4 = inside the f64) where the
  old pin emitted the align-aware offset 8 — the
  generic-wide-tuple-pattern class (its match-shaped gate exists:
  mn-generic-wide-tuple-pattern) at the LET-destructure, regressed
  because the CONVERGED finals floor sc's repr somewhere in the
  score_one_position → Cursor → field_ranked chain. CONFIRMED IN THE
  PINNED ARTIFACT: m3.wat's $render_field_tier reads the ranked tuple
  with `(i32.load offset=4)` — inside the f64 — exactly the word-floor
  destructure the theory named. THE FIX-SPEC COMPLETE
  (every input measured): Cursor is DECLARED Cursor(Handle, Reason,
  Float) [types.mn:765] and score_one_position's judged scheme returns
  it whole — so field_ranked's (sc, h) is concretely (Float, Int),
  and render_field_tier's let-destructure is the WIDE-TUPLE-PATTERN
  class at a CONCRETE site (the mn-generic-wide-tuple-pattern gate
  covered MATCH patterns via pat_elem_repr/pat_tuple_off reading live
  reprs; this LET path compiled the word floor, and the converged
  finals' changed twin/demand coverage is why the old pin emitted
  offset 8 here and the new one offset 4). Fix = the tuple-pattern
  landing's own recipe at the let-destructure lowering (element reprs
  read live through lookup_ty, offsets prefix-summed by repr_width),
  which also hardens every sibling let over wide tuples; then the
  field leg re-runs, the three absorption reports get the rounds-side
  scheme-carry dig (their fix-spec above), the board greens, and
  8b50846d blesses with the drafted PROVENANCE. The spurious "7
  gradient positions" remain the enumerator's virgin-walk question —
  second-order, after the repr fix. And frontier's ONE red is the cursor-address
  FIELD leg — NOT a count shift, a REAL regression measured by hand:
  `mentl two.mn:0` under pin 8b50846d renders every hole at span
  `two:-5240:0` (negative line — span arithmetic over garbage) with
  Query `t1072064102@e0` (a junk word read as a handle, rendered as a
  fresh var) where the banked green showed both holes' Propose fans.
  The address path is the DAG judge (single-pass), so the suspects are
  the arc's only address-path touches: cursor.mn's verify-facet change
  (filter_by_span now returns whole triples — its consumers' element
  destructures must agree) and the CursorView verify-slot flow into
  render_at. PROBE RAN: `mentl two.mn:8:30` is
  PERFECT (Query `?? : Bit`, the 2-survivor fan with the tie-teach,
  the Why chain) — the shared render path is HEALTHY and the break is
  CONFINED to the field walk's hole/gradient COLLECTION (junk handles
  entering the field's position list). Suspects, ordered: a consumer
  of CursorView.verify still destructuring elements as bare Predicate
  now that verify_pending_at returns the declared whole triples (the
  green leg had tolerated the OLD producer/decl mismatch loosely);
  the field tier's gradient-position source. Dig: grep the consumers
  of the CursorView verify slot + field_positions' handle source in
  at_run's field arm. Fix both, re-march, bless with the drafted
  PROVENANCE (scratchpad provenance-draft.md carries it; the march's
  own line: TRANSITION, boot ← m3, sha 8b50846d5807f1fb… re-read whole
  at write). MENTL'S OWN STEERING, banked as the next rungs: (a) INCREMENTAL
  ROUNDS — re-judge only the changed cone per round (the fingerprints
  are already computed; a stable name's re-judgment is waste — the IC
  cursor inside the judgment); (b) THE FAN (the brackets now sound);
  (c) the instruments KEPT as projections (the layer answer into
  `mentl query`; ty_fingerprint as the scheme-stability read) — the
  probe-then-delete dance this landing paid five times ends there.
- 2026-07-26 · ▶▶▶ MENTL MARCH — the wheel judges its own generation
  in-process, and the dig healed three latent breaks (· pin 0d153e0c).
  THE VERB: walk the wheel's files (fd_readdir's self/parent links
  skipped — the unfiltered walk descended src/./. forever, +2 bytes a
  level to the alloc ceiling, the trace's own numbers), compile
  in-process through the canonical converged stdin chain, STREAM the
  emission through wat_to_file into .build/march/m2.wat, read the
  census inside the same install, verdict against the last generation.
  Its FIRST CLEAN was against the bash march's own m2 — the in-process
  and exec routes proven byte-identical — and the re-run is CLEAN
  against itself. The all-day hand loop (rebuild + census-grep +
  compare) dies into one verb. THE SINK LAW: wat_to_file(fd) is the
  third sink — write-through, region-immune (bytes reach the host at
  each arm; fs_create_impl the streaming open) — and the scope law now
  written at wat_to_string's decl says the COLLECTING sink is per-fn
  only: a whole-compile install banks segment pointers the emit
  phase's per-fn region resets zero. That was exactly the in-process
  battery's SILENT BREAK since the emit-arena landed (its verb gate
  never re-ran; the board's micros ran through the bash loop — the
  two-oracle lesson at the gate layer): `mentl test tests/micros` now
  streams per-micro wat and runs 114/114. RIDING THE SAME ARC: the
  explicit-stack concat drain (flat_fill_concat — call depth =
  representation alternation, never concat depth; proven on a
  5000-deep rope after the recursive form died at fold-built line
  depth) and the correctly-rounded float family made DAG-honest
  (callee-first order + Float pins on parse_float/parse_float_body/
  parse_mantissa_f64 — the single-pass DAG judgment floored loose
  forward schemes' f64 results to words, an assembly refusal in mentl
  run). THE COUNTED KILLS of the dig, each a probe: the stale-fixture
  lib copy in the probe dir (the resolver prefers cwd — the forensic
  one-blob law), str_payload misread as a record (its comment was TRUE;
  the -B4 window truncated it), the warm-image theory, the
  stateless-config theory, and the drain itself vindicated three
  times. NAMED with its 9-line RED fixture
  (tests/frontier/mn-install-config-capture, unregistered):
  Hβ.lower.install-config-capture-read — an install-config arg that
  references a CLOSURE CAPTURE reads 0 silently (a let-local reads
  true; the fix routes install-init emission through the same
  capture-resolution ladder ordinary exprs ride; march_emit binds
  sink_fd locally until then). Board whole at the pin: CLEAN m2 == m3;
  census 0; comment-refs 0; frontier 279/0; proof-exactness 9/9;
  crown 5/5; micros-through-m2 114/114; in-process battery 114/114.
- 2026-07-26 · ▶ THE REFS FACET SPEAKS ITS SPANS (the
  self-exemplification pass's opening move #1 · pin 758f65f2).
  `refs of NAME` collected every use-edge span and rendered a bare
  count — the propose-facet seam one facet over; QRRefs now renders
  one located line per inbound edge. En route: the collector's
  non-tail recursion (depth = the handle space) went
  tail-with-accumulator at its first DAG-scale query; zero-span
  synthetic mints filter (a ghost is not a source site); the query
  print gained its final newline. THE RESEARCH PASS is banked
  (scratchpad self-exemplify-report.md): opening moves = this render
  · fixtures state their own contracts (`// expect: refuse E_*` —
  the 1,556-line frontier bash dissolving into `mentl test`) ·
  interrogate_at wired into the address surface (the eight running
  as code); `mentl march` measured UNBLOCKED (B-i's warm image was
  the dep); the 223 drift-ignore markers + the 21+17 hand walks +
  the zero-`><`-in-the-wheel measurement all named with their
  peers. Board whole.
- 2026-07-25 · ▶▶▶▶▶ ZERO PROSE LOST — the weave conserves the whole
  wheel (· pin 6cd7a75e; the comment arc's terminus: 2,803 → 0 on all
  50 files, one-invocation idempotence, measured by the verb's own
  lexical gate). Two closures: the else-if DESTRUCTURES its child so
  its uniform emission never fired (render_else_block emits the nested
  if's prose itself, uncuddling at the prose link — the lexer's
  two-char table was the class); and desugar_block returns the MINTED
  NODE with the head-destructure match at THE LET'S SPAN, so the
  span-tie rule resolves body-head prose to the live match, never the
  dissolved let (callers' wraps delete with the contract). The fmt
  summit's prose gate is fully open; remaining swap-gates: sugar
  re-preservation (the __dp lambda-destructure render) + the
  drift-audit leading-marker accommodation. Board whole.
- 2026-07-25 · ▶▶▶▶ THE WEAVE INVERTS — one attachment pass, one
  emission point; ~50 sites delete (· pin ffc3fd58). Morgan's cut
  ("isn't there a better way") ended the mole war: attach_comment_weave
  runs ONCE after parse_program, resolving every comment run by SPAN
  against the node weave (trailing → widest node starting on the run's
  line; leading → widest at the minimal start past it; span ties → the
  latest mint, which retires the desugar transfer; a blank-separated
  earlier block INHERITS the next run's target). Emission went uniform
  at render_tokens_for — every node's prose prefixes its tokens; the
  per-construct emissions delete (rows keep theirs), and prose-forced
  breaks CASCADE from fits_inline seeing the emitted newline. The verb
  writes its own FIXPOINT (render → reparse → re-render; the second
  render is the file), so one invocation is idempotent by
  construction. The nine per-site families, the probe-law
  contortions, and the four attach/collect fns delete whole; the
  parser's skips are comment-transparent again. Artifact-taught en
  route: the run record is NOMINAL (CwRun — generic walkers compile
  once; the brand + param Intent Boundaries prove the field offsets),
  and the inherit rule (each node competes only for its nearest run).
  MEASURED: conservation 1,969 → 741 → 106; IDEMPOTENT-ALL-50; whole
  board green. The working discipline reified in CLAUDE.md ⟳
  (Edit-tool-only source writes — heredocs bypassed the audit hooks;
  the medium's projections before shell reads; verbs carry their own
  fixpoints; the uniform pass beats the per-site family). Remainder:
  the 106 (record-type-field trailing + a tail class the verb will
  name), and `mentl march` stays the loudest absorption ask.
- 2026-07-25 · ▶▶ THE PROBE LAW COMPLETES — 2,803 → 35 (99.8%
  conservation · pin 4e7d5013). Two more probe-consume sites fell to
  the verb's own lost-line reports: the resume-with update list's
  comma probe (the drift-audit markers live exactly there) and
  binop_loop's ENTRY skip (prose before a chain continuation — `//
  why` above `~> affine_ledger` — now attaches to the following stage
  when an operator follows, returns pre-run when none does). infer 28
  → 3; main fully conserved. THE TRUE REMAINDER: 35 lines, one
  structural leaf — trailing comments on record-TYPE fields, where a
  carrier cannot live (TRecord is a TYPE; a node in its field tuple
  would make prose part of type identity) — named
  Hβ.parser.record-field-comment-attach with that reason. The swap
  bridge: true those 35 authored sites to carriable positions + the
  drift-audit hook learns the leading-position marker. Board whole;
  idempotent-all-50.
- 2026-07-25 · ▶▶ THE CHAIN BREAKS AT PROSE + THE GATE NAMES ITS LOSSES
  (· pin 45153159). Prose after a binary operator belongs to the RIGHT
  operand: binop_loop (the one path pipes and binops share) collects
  after the operator onto the operand's node; the renders break the
  chain there (operator at line end, comment above the operand — the
  || ladder shape; chains emit stage prose via render_stage_comment).
  The conservation gate NAMES its losses ("  lost: // …" per missing
  line) — the verb replaced the last hand diff, and its first report
  identified the residue: trailing drift-audit markers (load-bearing —
  the audit hook reads them per line), argument-interior trailing
  series, one block shape (~70 lines). The census ratchet caught this
  landing's own two under-declared chain-render rows (widened to
  their bodies' weave reads). Board whole; idempotent-all-50.
- 2026-07-25 · ▶▶▶ DEPTH IS COMPOSITION + FITS-OR-BREAKS — the layout
  engine's two primitives (· pin e4d6897f). REINDENT-ON-COMPOSE:
  interiors render at depth ZERO; each enclosing block indents its
  whole interior once (indent_block) — depth is never threaded and
  never wrong, because nesting depth IS composition depth (the fixed
  two-space literals had rendered nested arms at column 2 at any
  depth). Six wrappers recomposed. FITS-OR-BREAKS: one line within
  100 columns survives inline, else the block layout — fn/let break
  after `=`; an overflowing if takes the cuddled-block vertical
  (SYNTAX's chase_node shape); an overflowing call breaks
  arg-per-line; a long variant set goes vertical. MEASURED: >100-col
  non-comment lines 1,335 → 628 against authored 568 (2× regression
  → near-parity), IDEMPOTENT-ALL-50 at every rung, march CLEAN
  through all three pins. Swap-gate remainder: the ~65
  operator-interior prose lines (chain-break-at-prose).
- 2026-07-25 · ▶▶ THE ARM'S ARROW STOPS EATING + THE GATE GOES LEXICAL
  (· pin 409fc675). The ninth family: prose between an arm's `=>` and
  its body — the single biggest remainder (lower.mn alone 116) —
  collects at both arm loops' arrows onto the body handle; lower.mn
  → ZERO, infer 84 → 31. The conservation gate's blind spot, found by
  cross-checking its verdict against the independent census: a
  weave-to-weave compare sees only what the parse ATTACHES — a
  layout-consumed line is invisible both sides. The metric went
  LEXICAL (one TComment per authored line; fmt lexes source and
  render, the count difference IS the loss, never-attached included);
  the weave-walk fns deleted. The verb's verdict now matches the
  external census line-for-line; the python census retires for real.
  Remaining ~65 lines are ONE class — prose in OPERATOR chains
  (is_seq_op's || ladder, ~> stage gaps, closers) — attachable now,
  renderable only under multi-line operator layout: the residue
  MERGES into the width-engine build (the summit's other dep — one
  build, not two). Board whole; idempotent-all-50.
- 2026-07-25 · ▶▶ THE VERB CARRIES ITS OWN CENSUS — fmt's prose
  conservation gate + the else and file-tail families (· pin
  7b1b8b61). Morgan's cut ("I wish we didn't have to run python just
  to run Mentl stuff") absorbed per ⟳: fmt_run re-parses its own
  render (two watermark-bracketed single-file frontends in the same
  context), counts the weave both sides, and REPORTS — "prose
  conserved (25 blocks)" / "8 of 435 prose blocks would not survive a
  reparse" — the medium naming its own residue per file; the python
  comment-diff retires. Families 7+8: BEFORE-ELSE (the else probe
  scans without consuming; prose attaches to the else node;
  render_else breaks the line to emit it above its own else) and FILE
  TAILS (the end-of-file block attaches to the TComment arm's
  synthetic unit carrier, which renders prose-and-no-tokens; the
  POrphanDocstring raise retires — the orphan has a home, as SYNTAX's
  "never dropped" always claimed). Content census 513 → 299; the
  remainder (match-heads in expr position, argument interiors,
  variant-inline) is now visible through the verb's own report.
  Board whole; idempotent-all-50.
- 2026-07-25 · ▶ THE ATTACH TARGET IS THE LIST'S NODE — the sixth
  comment family (mid-block statements) + the content-matched census
  (· pin ae600b3b). A mid-block expr statement wraps in a fresh
  ExprStmt node AFTER the leg's leading attach — prose landed on the
  inner expr's handle while the block render reads the wrapper's;
  every mid-block statement comment dropped while let/fn carried
  theirs. The fix attaches per-branch to the node the statement list
  holds. IDEMPOTENT-ALL-50 holds; the line-count metric SATURATED
  (trailing→own-line movement inflates lines while preserving
  content), so the honest measure is the content-matched census: 513
  authored comment lines not surviving — file tails 155 (Module-handle
  attach + end-of-render emission), before else/else-if 150 (the else
  probe consumes the run; the else node is the target), match heads
  45, variant-inline 19, argument-interior ~80.
  Hβ.parser.expr-interior-comment-attach carries exactly those shapes
  with the six-times-proven recipe. Board whole at the pin.
- 2026-07-25 · ▶▶▶ THE PROSE JOINS THE WEAVE — five comment families
  attach, ops and variants become addressable, the probe law lands
  (· pin 694716c1). The summit's 2,803 dropped comment lines fall to
  469 (83% recovered) with IDEMPOTENT-ALL-50 held. Families, each
  census-measured RED first: MATCH ARMS (1,353 — leading prose to the
  arm's BODY node, the arm's one handle; the caller's skip_ws ate the
  run before the loop's collect); HANDLER ARMS (the same recipe closes
  Hβ.parser.handler-arm-doc-attachment, a seed-era "for now");
  BRACELESS-CHAIN CONTINUATIONS (344 — the expr-position let runs the
  block loop's full discipline, and desugar_block TRANSFERS a
  dissolving destructure-let's prose to the arm body: movement, never
  loss); EFFECT OPS (677) and TYPE VARIANTS (312) become ADDRESSABLE —
  each row widens with its minted NTypeAnn node (the row's genuine
  type fact, its handle in the weave); the census named all thirteen
  consumer destructures. THE NON-CONSUMING PROBE LAW, paid for by the
  alternating-drop memory.mn measured (every arrowless op swallowed
  its successor's prose): a lookahead probe returns the PRE-probe
  position on a miss — a scan is a read, never a consume. The
  vertical variant layout renders prose-carrying ADTs (connective
  owned by the variant render); parse_type_decl routes the
  name-to-`=` run to the first variant. THE RATCHET'S OWN PROOF: the
  moment op/arm/variant prose entered the weave the comment-refs gate
  judged it — 16 never-audited phantoms fired, each trued to 0.
  Named remainder (469): before if/else (286) + before match head
  (126) — expression-position runs needing render sites at the
  if/match projections — plus closer/eof tails;
  Hβ.parser.expr-interior-comment-attach narrows to exactly that.
  CLEAN m2 == m3 at 299,248 lines; census 0; comment-refs 0; frontier
  279/0; proof-exactness 9/9; crown 5/5; micros 114/114.
- 2026-07-25 · ▶▶▶ IDEMPOTENT-ALL-50 — the fmt fixpoint reached; the
  summit's swap gated by its own comment law (· pin 672a924b). Four
  render roots + one parse canonicalization, each convicted by the
  sweep: the LET-CHAIN FLATTENS AT PARSE (a braceless chain parsed to
  nested per-let BlockExprs while the braced spelling parsed flat —
  two graphs for one meaning; parse_let_expr merges the continuation
  into ONE statement sequence, Law-7 byte-identical); the SURFACE-TYPE
  PROJECTION (the formatter borrowed show_type — the VOICE — and
  leaked `with t45323@e23311` into an effect op's rendered source,
  which pass 2 misparsed into three bogus op declarations;
  render_type_tokens is the parse's inverse, swapped at all eight fmt
  type sites — §5.U's voice/format boundary enforced); a LAMBDA
  OPERAND ALWAYS RE-WRAPS (prec 0 + render_chain_pos at every chain
  head — the recurrence rendered paren-free read back as
  `delay(1)(prev)`); a BODY-LEAD `{` IS THE BLOCK (record
  literal/update as fn/lambda/arm body re-wraps — render_grouped_body
  at five surfaces); INT_MIN renders its wrapping positive spelling
  (the minus accreted one per pass). ORACLES: all 50 wheel files
  format to a byte-fixpoint in one pass; the formatted tree compiles
  census-0, wat value-identical to pristine modulo three CLASSIFIED
  diffs (handle renumbering; the FNV const-fold firing
  order-sensitively — value-identical, banked with band G's
  typed-rulecyclic; yield_from's open-record demand-order offsets —
  the named trecordopen class). THE GATE HOLDS THE SUMMIT: the
  formatted tree DROPS 2,803 comment lines (16.7% of authored prose —
  expression-interior comments consumed as layout,
  Hβ.parser.expr-interior-comment-attach) and doubles >100-char lines
  (572 → 1208, the width-aware layout engine); canonizing prose
  destruction is forbidden by the weave's own law, so the SWAP gates
  on exactly those two builds. The voicey carry leg re-banked to the
  surface-canonical spelling (authored byte-identical). CLEAN
  m2 == m3 at 298,159 lines; census 0; comment-refs 0; frontier
  279/0; proof-exactness 9/9; crown 5/5; micros 114/114.
- 2026-07-25 · ▶▶▶ THE TWO READERS AGREE — parse_float goes correctly
  rounded, one float projection survives, and list_set's flat contract
  goes loud (the fmt summit's idempotence sweep forced all three roots ·
  pin ea643e6c). The summit's 19 non-idempotent files were ONE mechanism,
  three liars, each convicted by probe: parse_float paid one rounding per
  fractional digit (rebuilt: ONE f64-integer mantissa accumulation —
  exact through 2^53, every authored literal — + ONE scale by the exact
  power of ten; proven EQUAL to IEEE division at the probe, closing
  Hβ.runtime.parse-float-correctly-rounded over the exact-mantissa
  range); the render normalization divided by an UNREPRESENTABLE
  negative power (0.3's scaled arrived 2.9999999999999996, a whole ulp
  off — negative exponents now MULTIPLY by the exact positive power);
  and the root under the root — the shortest ascent's rounded-last bump
  list_set a PUSH-BUILT digits list, and list_set computed FLAT
  addresses for every tag, writing the digit over the snoc's PARENT
  POINTER: the round-last arm was dead since birth (measured:
  list_set(push(make_list(0),2),0,3)[0] == 2; index 1 on a two-element
  snoc "worked" by layout coincidence). list_set's base now REFUSES a
  structured tag loudly — the documented contract enforced, the census
  instrument for any other violator (the board ran clean: one instance
  existed). With parse correct, the shortest oracle parse(cand)==f gives
  the assembler's own verdict on every short candidate — so
  float_to_str_bits DELETED whole, the emit boundary reverts to
  float_to_str, and the wheel's f64 constants are TRUE to their authored
  spellings for the first time (the fixpoint was structurally blind to
  this: the wat text was the fixpoint object while values drifted from
  intent — the m2/m3 TRANSITION's 76 lines are the corrections crossing
  one generation). Probe battery: 0.3/0.995/6.02/2.5/1.0/100.5/0.001
  all canonical-short; 0.1+0.2 = "0.30000000000000004"; READERS-AGREE.
  Named residue: Hβ.runtime.float-render-17-digit-exact (the unverified
  nd=17 tail's float-stepped extraction — never reached by a lexed
  literal, whose own spelling is a short witness). TRANSITION m3 == m4
  at 296,456 lines; census 0; comment-refs 0; frontier 279/0;
  proof-exactness 9/9; crown 5/5; micros 114/114.
- 2026-07-25 · ▶▶ FMT RUNGS 1·2·4 — the render register of the voice
  stops lying (pin 7215e8c2). The with-clause renders the SIGNED
  TRIPLES verbatim (connector per entry, per-entry !, instance args
  through show_eff_arg — the diagnostics voice and the formatter now
  speak the SAME arg projection, one home), replacing the closed-row
  rebuild that destroyed 41 declared rows as «invalid-effect»; the
  handler renders read the TYPED closed projections (the bypassed
  cure — every handler decl trapped before); authored -> RetTy
  carries (91 heads were dropping). Three RED-first legs (voicey):
  behavioral 42, verbatim carries, byte idempotence; frontier 279/0;
  CLEAN m2 == m3 at 295,930. THE VOICE FRAME (Morgan's charge, made
  structural): fmt is ONE REGISTER of the medium's voice — the same
  projection machinery reading the graph back to the human at three
  registers: diagnostics NARRATE (spans, Reasons, quick-fixes), fmt
  RENDERS (the canonical shape — layout as projection is what keeps
  human text and graph truth in byte-agreement, so every downstream
  span/patch/census points at stable text), teach/tighten/the ??-fan
  PROPOSE. The daily loop: write loosely → the medium normalizes +
  narrates + proposes. Rung 3 LANDED same day (pin a0172f04 —
  render_if_branch supplies braces EXACTLY ONCE: the parser wraps a
  braced branch in a BlockExpr and the old render's literal braces
  accreted a wrap per pass until the inner pair re-parsed as the
  record pun; else-if renders bare; the implicit-unit else renders
  nothing — the identity; the voicey leg asserts no accretion).
  Rung 5 LANDED same day (pin 5ad4aef6 — the
  render goes TOTAL over the weave: the block final's prose renders
  via the one render_stmt_comment projection, and attached prose
  forces the block layout at an if branch; parser.mn 809 → 623
  comment lines kept, 77% from the census's 68%, and the file
  formats clean where it trapped; the remaining drops classify to
  the expression-interior positions the parser never attaches —
  Hβ.parser.expr-interior-comment-attach, a parser refinement, not
  render debt). Rung 6 LANDED same day (pin 997e42f5 — the
  shortest faithful render whose oracle is parse_float itself, the
  lexer's own conversion; en route the probe named
  Hβ.runtime.parse-float-correctly-rounded: parse_float's naive
  digit/scale summation disagrees with the assembler's
  correctly-rounded reader — parse_float("0.3") != the wat-born 0.3,
  measured — so the EMIT boundary keeps the bits-faithful
  seventeen-digit projection (float_to_str_bits) until the parse is
  correctly rounded, and digit_at's false zero-pad doc became true
  at the one reader). ALL SIX RUNGS LANDED; the SUMMIT (whole-wheel
  fmt → census 0 → fixpoint → formatted source canonical, retiring
  the 778) is the next fmt arc.
- 2026-07-25 · ▶▶ HANDLER-CONFIG DEFAULTS + THE BASE-FRESHNESS
  CONTRACT + THE PUSH (pin 9de2ecc4). The product law lands at the
  handler decl: config goes [String] → [TParam] — the fn-param
  carrier itself, ONE default representation (the fifth slot), ONE
  fill (resolve_call_args), zero second mechanisms; parse mirrors
  parse_one_param's scalar face; defaults type in the handler's own
  scope under a DefaultReason edge; the formatter renders them back.
  Four-face fixture (bare fills / explicit / no-parens / labeled
  skip) = 42; frontier 276/0. Fleet-built, cherry-picked three-way
  onto live main, re-derived (one stale-base tax: a row predating the
  intern era, widened; the numbering TRANSITION crossed in the same
  march). THE PROCESS FIX the day demanded: the worktree machinery
  had based builders on a snapshot ELEVEN PINS stale — root cause
  consistent with basing on origin/main, unpushed since 7cc859ae —
  so (1) tools/base-check.sh is every builder's mandatory first
  action (the brief pastes main's sha; stale = rebase-or-abort,
  never build), reified in CLAUDE.md's dispatch law; (2) four stray
  worktrees from prior sessions pruned after verifying absorption;
  (3) main PUSHED (54 commits, 7cc859ae..fd406556) and staying
  pushed — an unpushed origin is a stale base factory. NAMED
  CASH-OUT now unlocked: the eleven config-quadruple install sites
  (graph_handler ×9, env_handler ×2) collapse to bare installs with
  decl-site defaults. NEXT per Morgan: the fmt ladder (the formatter
  is the anti-drift instrument — canonical projection makes layout
  mechanical), rungs 1–2 first (the signed-triple row render and the
  typed handler-arm reads — the same disease families root-fixed in
  the compiler today).
- 2026-07-25 · ▶▶ THE TYPE NAMESPACE REFUSES — the last named
  silent-MERGE class closes (fleet-built, transplanted, re-derived ·
  pin 3f4fba83). Two `type X` decls in one namespace silently MERGED
  — ctors tag from 0 per decl, a cross-tag match returns the wrong
  arm, zero diagnostics (measured RED: exit 13 where 99 was honest).
  E_DuplicateTypeName ARMED AT BIRTH (decl-site licence, blob census
  0 at arming); refuse_duplicate_type_decls claims every type head in
  a WALK-LOCAL seen-set (never an env probe — a multi-variant decl
  registers only ctor names; cross-walk re-registration is the
  two-pass judge's own legitimate shape); both registration walks run
  it (trial absorbed by diag_quiet, final reports). Frontier
  refuse-dup-type leg PASS; 273/0. Same pin arc, two singles landed
  inline: THE UNSEEDED-OVERFLOW GUARD (pin ed5dc82b — the bracket
  refutation's F1 hardened on the live arms: an overflow with
  mint_high 0 is an unseeded branch cursor and traps loudly instead
  of minting handle 0 over the shared Module root) and the
  fleet-builder's HANDLER-CONFIG DEFAULTS landing complete in its
  worktree (commit 572e487b — TParam carrier reuse, one default
  representation, one fill through resolve_call_args; four-face
  fixture 8/16/6/12=42; TRANSITION m3==m4 in-worktree; TRANSPLANT TO
  MAIN PENDING, with the eleven-site bare-install collapse as its
  cash-out and the inherited earlier-param-default lathe-lag noted).
- 2026-07-25 · THE ARM-SPEC DESIGN REFUTED — a proven negative
  redirects the payload arc (no code shipped; the fleet's adversarial
  pass, orchestrator-re-derived from the micro sources). The named
  successor Hβ.lower.arm-payload-specialization (spec-twins at handler
  arms) could fix AT MOST 3 of the six 134-banked micros: the floors
  SPLIT — payload/payload2/payloaddirect floor inside the ARM fn (the
  arm is the medium's last "named generic compiled once at the decl's
  floor" — install-independent, proven by an inline-perform probe
  still trapping), while payload3/4/5 floor in MAIN on the
  handle-result read ((run() ~> hold).beta) with word-shuttle arms no
  arm machinery can reach; THAT root is the row representation's
  fragment drop (two ops of one effect performed in one non-install
  frame: the name-set union's by-name dedup drops the second
  fragment's args outside install frames — the instance-crossing
  landing's own "join by position" gate, measured by four probes:
  both-inline 2, single-op-through-boundary 2, two-ops-one-callee
  134, two-ops-two-callees 2). REPLACEMENT, two landings completing
  EXISTING channels, ordered L1 → L2:
  Hβ.effects.same-name-fragments-coexist (L1, fixes 3/4/5): same-named
  EParameterized fragments COEXIST in the row — dedup by full identity,
  not by name — until the install reconciles them (§4③'s own "the
  handler is where the single instance is established";
  unify_instances_to already iterates every fragment; only the
  representation starves it). Compat gate: heterogeneous performs of
  one op under ONE install become an honest install-site type error;
  the fold-over-[Int]+[Float] caller is the green control.
  Hβ.emit.arm-under-install-instantiation (L2, fixes payload/2/direct):
  the arm emits under its installs' instantiation — demand channel =
  the STATIC LHandleWith sites (the install is the one place the
  instantiation is total; perform-site routing REFUTED — the singleton
  tier bakes arm calls into arbitrary intermediate fns), pairs = the
  handler env scheme's inst-var roots against lookup_ty of the install
  value, through the EXISTING spec bracket + field_sel_offset;
  all-installs-agree (the dominant case) = one arm under one bracket,
  no twin, no routing; divergent + floor-sensitive = a LOUD compile
  refusal naming the divergence (strictly better than the runtime
  134); divergent + plumbing stays floored-and-correct (the
  heterogeneous-install control runs green today). Also refuted en
  route: per-DECL monomorphization (heterogeneous installs of one
  plumbing handler are legal and live), runtime field-by-name (drift
  8), annotate-the-param as the resolution (the standing charge's own
  words; it survives only as a legitimate authored Intent Boundary).
  The six micros' 134 expectations are the RED gates; three of their
  comments carry the wrong diagnosis (polymorphic-op — actually the
  fragment drop) and true with L1.
- 2026-07-25 · ▶▶ THE OVERLAY FAMILY DIES WHOLE — the fleet's first
  executed census, and the C1b dividend undershot (pin 6913e09d). The
  recon-overlay agent's complete consumer census found the per-module
  overlay index DEGENERATE: graph_fork had ZERO perform sites for the
  structure's entire life (orchestrator re-derived before acting — the
  pipeline law), so overlay_count was forever 1 and every mint fed one
  "global" row whose only reader chain dead-ends at an op with zero
  performs. DELETED whole: five state fields, the per-mint
  overlay_register_at write (~200k × [2 index reads + extend + 3 sets
  + a tuple alloc] per self-compile, off the hottest write path), the
  graph_fork op+arm, five fns, the eager overlays_to_pairs build on
  every snapshot (20 sites; 19 ignored it), the Graph middle field
  (→ Graph(next, span_index)); checkpoint 12 → 7 fields, restore
  10 → 5 (a smaller fork value for the C1c fan). The ONE real reader
  — QueueItem.module_path, a construction-time SNAPSHOT of a live
  fact — rewires to the live read: filter_by_module keys on
  module_path_of_span(parse_span_of(pos)), NModule span containment;
  the fn moves to graph.mn (DAG-homed beside parse_span_of).
  Resolves Hβ.graph.fork-dead-code as DELETION. Named residue:
  Hβ.oracle.module-queue-live-key — when a doc-batch surface first
  performs query_module_queue, the live filter's O(next) NModule scan
  takes its O(1) form (the handle-indexed span weave + the plan's
  stmt→range projection); build WITH that first performer, never
  before. Wheel 621 lines smaller. CLEAN m2 == m3 at 294,395 lines;
  census 0; comment-refs 0; frontier 272/0; proof-exactness 9/9;
  crown 5/5; micros 114/114.
- 2026-07-25 · ▶▶▶ RESOLVED OR LOUD — the trecordopen-wrong-field
  silent-wrong class CLOSES (the field-access cluster's emit half ·
  pin 723220b3). resolve_field_offset's open-record arm resolves the
  FULL field set through the row residual the graph already carried
  behind the row var (open_record_full_fields — NRecordRowBound,
  chained open rows, or a closed bind, canonically sorted via the
  parser's own sort) and floors -1 when any tail is genuinely free —
  never again a prefix-sum over the partial demanded set. THE BYTES
  SHOWED THE FIX BOTH WAYS (the 31-line m2/m3 crossing): offset=0
  loads became offset=4 — LIVE wrong-slot reads in the wheel itself,
  healed — and unprovable floors became correct reads through the
  residual. THE NINE RED MICROS WERE THE FIX WORKING: the payload
  ladder (2026-07-01's diagnostic rungs) had CANONIZED the wrong-slot
  values — payloadfn's own comment carried "Expected value when
  fixed: 2" since birth, and the banked 1 was alpha read through
  offset 0. Re-banked: payloadfn/hoflambda/mapfield at the true 2;
  the six genuinely-free-tail arms at the honest 134 floor (silent
  wrong → loud), with the named successor
  Hβ.lower.arm-payload-specialization — the spec-twin machinery at
  handler arms closing the op-payload residual per instantiation (a
  polymorphic op's arm is the same demand-analysis shape as a named
  generic; until then the floor is the truth). With the judgment half
  (the unify arm, pin f0ab3177) this closes the LAST known
  silent-wrong class on the board. TRANSITION m3 == m4 at 295,451
  lines; census 0; comment-refs 0; frontier 272/0; proof-exactness
  9/9; crown 5/5; micros 114/114.
- 2026-07-25 · ▶▶ THE NOMINAL SATISFIES THE ROW — a canonical SYNTAX
  form stops lying (the field-access cluster's judgment half · pin
  f0ab3177). Morgan's audit charge ("what's named? what's avoided?
  any fundamentals not ultimate?") surfaced the cluster this session
  had WORKED AROUND twice instead of root-fixing: nominal-record
  field access. Probed RED on the artifact first: `p.age` on a
  let-bound Person raised a false E_TypeMismatch (Person vs
  {age: t | r}) on SYNTAX's own documented form — while emit resolved
  the offset correctly, the judgment lying about correct code — and a
  row-polymorphic {age: Int, ...} parameter refused a Person
  outright. THE FIX IS A LIVE-EDGE READ, not a patch: unify's TName
  arm gains the TRecordOpen case — a nominal record satisfies a
  structural field demand by its own declaration, read through
  nominal_record_fields (the THIRD reader of RecordSchemeKind beside
  the literal check and the ctor arrow view; one channel, three
  readers), delegating to unify_record_open_against_closed (zero new
  unifiers). The brand never erases: the TName side stays bound, only
  the demand's field vars and row residual bind; a CLOSED structural
  demand still refuses (exact-shape identity is the brand's point).
  Both probes heal to 42; two frontier legs registered RED-first;
  frontier 266 → 272/0. CLEAN m2 == m3 at 295,191 lines; census 0;
  board whole. The cluster's EMIT half stays named with its design:
  trecordopen-wrong-field — a receiver still GENUINELY open at emit
  computes offsets over the partial demanded set (silent wrong reads;
  the fix resolves through the row residual or refuses loudly, never
  a partial-set offset).
- 2026-07-25 · THE PAGE PRE-OPEN — the fan's band opens become
  unraceable (Phase C rung 1 step C1c-2c opening move · pin
  3a53f775). graph_mint_plan pre-opens every band the plan touches,
  sequentially, before any planned walk — a branch cursor then only
  writes cells, never opens a band, so page opens cannot race by
  construction. CLEAN m2 == m3 at 295,016 lines; board whole. THE
  JOIN PROTOCOL, derived and banked in the mirror for the bracket
  build: every branch-local mutable fact (diagnostics, env publishes,
  affine consumes, verify debt) returns as a DELTA replayed into the
  root in stmt order at the join — collisions and refusals re-detect
  deterministically at the replay, so branch instances stay fresh and
  the sequential judgment reproduces exactly; the bracket proves
  itself byte-identical SEQUENTIALLY before any thread runs it.
- 2026-07-25 · THE ENV VIEW — the branch cursor's second leg lands
  Law-7-inert (Phase C rung 1 step C1c-2b · pin d8c42e3a).
  env_handler gains the base triple (base_buf, base_count,
  base_index): a branch installs over the root's shared entries as a
  read-only BASE — its extends land in a fresh private buffer that
  dies at the join, publishes re-applied through the root in stmt
  order — while the root passes the empty base, so root resolves stay
  one-level. The four lookup arms compose the EXISTING env_resolve
  family as private-then-base Option fallbacks (zero new resolve
  machinery); a branch snapshot appends the private prefix to the
  base view. CLEAN m2 == m3 at 294,988 lines; board whole. Remaining
  C1c-2 rungs: the collecting diag branch instance, page pre-open at
  graph_mint_plan, the branch bracket proven byte-identical
  SEQUENTIALLY, then the fan.
- 2026-07-25 · THE CURSOR CONFIG — the branch-cursor substrate lands
  Law-7-inert (Phase C rung 1 step C1c-2a · pin 3f4262bc).
  graph_handler gains config (spine0, spine_open0, next0, limit0): a
  parallel branch cursor installs over the SHARED spine table with a
  private planned range; the nine root installs pass the empty graph
  explicitly. State records live in shared heap, the install chain
  stays per-instance — the spawn substrate's own shape. Probed en
  route: handler-config DEFAULTS don't parse (the parameter-product
  law implies them — parse_arg_names takes bare names; the lathe-lag
  named, the explicit quadruple honest until that turn). CLEAN
  m2 == m3 at 294,873 lines; board whole. C1c-2's remaining rungs,
  design banked in the mirror: the env-view config (branch reads the
  shared buffer, private extends die at join), per-branch diag
  collection re-reported in stmt order, pre-open the plan's pages
  before the fan, and the fan itself gated on byte-equality with
  C1c-1's sequential layer walk.
- 2026-07-25 · ▶▶ THE LAYER-ORDERED FINAL — the fan's execution shape
  runs sequentially, and the fixpoint proves walk-order convergence
  (Phase C rung 1 step C1c-1 · pin 406e4d2a). The trial's own reasons
  ARE the stmt DAG: every reference it resolved drew a VarLookup
  Reason, so a stmt's edges are the VarLookup names over its trial
  range — read through the new graph_reason_at (the unchased reason
  cell, the Why engine's raw read), never a second AST walker (the
  40-arm walker copy refused; lower's reach walk stays DAG-forbidden
  from infer). Only BACKWARD edges order the walk — a forward fn ref
  resolves to the trial's published final scheme, and the genuinely
  order-coupled stmts (top-level lets) precede their dependents in
  source — so depths compute in ONE ascending pass, the layer graph
  is acyclic by construction, and a missing edge (destructured let,
  unnamed stmt) degrades to source order, never a reorder-before-dep.
  The final pass walks LAYER BY LAYER with source-order pre-assigned
  bases: numbering stays plan-determined; only the judgment order
  changes — to exactly the order C1c-2's `>< ~> parallel_compose`
  fan will run concurrently. The march's verdict is the finding: the
  reorder is TRANSITION-grade (1,228 emit lines differ between the
  source-order and layer-order judgments) and SELF-STABLE (m3 == m4)
  — walk-order convergence proven by the fixpoint, the same gate the
  concurrency will be held to. The medium refused two of this
  landing's own first forms en route (census-named: LetStmt's pat is
  a bare Pat, and the affine judge rejected let-_-then-reuse
  threading at both walkers — thread list_set's return). TRANSITION
  m3 == m4 at 294,828 lines; census 0; comment-refs 0; frontier
  266/0; proof-exactness 9/9; crown 5/5; micros 114/114.
- 2026-07-25 · ▶▶ THE PLANNED MINT — the deterministic handle partition
  goes live, sequential-planned (Phase C rung 1 step C1b · pin
  c53dd17b). The trial IS the sizing oracle: each stmt's mint count is
  the graph_next delta around its trial inference — a fact the graph
  already carries, read at the stmt boundary, zero instrumentation —
  and the final pass mints each stmt into a pre-assigned dense range
  [base, base+count), bases prefix-summed from the final's own
  post-prepass frontier. The numbering is a pure function of the
  source through the trial's determinism: EXACTLY what the parallel
  fan (C1c) must reproduce, which is its byte-equality gate — landing
  sequential-planned first splits the numbering TRANSITION from the
  concurrency, so the fan marches as a NO-OP diff against this pin.
  Three graph ops carry the plan (mint_plan / mint_at / mint_seal —
  none touch the trail: the plan is numbering, not mutation); a mint
  at a range's ceiling jumps deterministically to the open space
  above the plan and clears the limit; an under-measure stmt leaves
  virgin gap cells absorbed by the word-face guard on graph_node_at
  (the C1a Cast read's second consumer). THE DESIGN CORRECTION that
  made it this small: the banked per-decl BAND encoding (handle =
  band<<14 | slot) died to arithmetic — sparse handle space forced
  eager-page memory (1.8GB at decl grain), 15 range-iterator
  migrations, and guard complexity; the landed form keeps handle
  space DENSE and decouples the partition (a numbering plan) from
  the storage (C1a's pages) entirely — zero iterator changes, zero
  storage changes, ~90 lines. C1c's remaining prerequisites, named:
  pre-open the plan's pages before the fan (spine_ensure once,
  sequentially — cursors then write cells only, race-free by
  construction) and the per-cursor overflow rule (requeue the decl
  for a sequential post-join re-run — deterministic, the rare path).
  TRANSITION m3 == m4 at 292,882 lines (the 6,586-line m2/m3 diff is
  the planned numbering crossing one generation); census 0;
  comment-refs 0; frontier 266/0; proof-exactness 9/9; crown 5/5;
  micros 114/114; 5.57s median / 515MB — flat.
- 2026-07-25 · ▶▶▶ THE PAGED SPINE — six weaves become one page record,
  and the graph stops moving (Phase C rung 1 step C1a, Law-7-inert ·
  pin 0e3af09c). The six handle-weaves (nodes, program, comments,
  canon, narrowing, boundaries) dissolve into ONE structural record
  per band — six 16,384-slot columns allocated whole at band-open
  (sized by the measured mint distribution: max 2,305/decl, p99 331),
  written in place, never relocated. DELETED: graph_extend_to + the
  NFree gap-fill (pages need no fill — a virgin cell is the absent
  contract: mint-density guards nodes by `next` alone, program and
  comments guard the cell's word face through the Cast read, canon
  and narrowing read 0 as no-edge, a boundaries 0 IS NoBoundary at
  nullary tag 0), the five per-weave extend+set+rebind arms (an
  in-place cell write rebinds NO state), the seventeen-field
  checkpoint (→ twelve fields, the spine contributing two words:
  band table + open count), undo_set_within + the spine-merge
  restore semantics (rollback = restore the COUNT + a plain backward
  in-place trail walk; in-fork bands close by count, their cells
  stale-and-overwritten at the next open — the trail's own
  logical-length discipline one level up), the Graph snapshot's
  zero-reader nodes and epoch fields (every destructure ignored
  them), and current_overlay (a write-only cache of names[idx]).
  The fork-spine class (the boundaries[23] stale-spine trap, the
  seventeen-field snapshot's whole reason) is UNCONSTRUCTIBLE: a
  page that never moves cannot dangle, and a spine snapshot stays
  valid across mints. One trap en route, pinned against the binary
  then named as its class: the page read's inferred open-record
  receiver computed field offsets over the partial demanded set —
  `.nodes` read offset 0, the boundaries column, GNode destructure
  of a boundary word (trecordopen-wrong-field, measured live) — and
  the judge REFUSED the first nominal-record fix with 12 exact
  E_TypeMismatch sites (nominal TName vs the open-row field demand),
  forcing the honest form: the page is STRUCTURAL (mechanism, not a
  branded value), closed at the one annotated projection
  (spine_page's return). MEASURED: 5.49s median / 511MB RSS —
  neutral time inside the variance band, flat memory (+5MB = 13
  bands × 384KB exactly), the doubling-copy churn gone. CLEAN
  m2 == m3 at 291,710 lines; census 0; comment-refs 0 (the ratchet
  caught five of this landing's own backticked narrations); frontier
  266/0 through the paged rollback; proof-exactness 9/9; crown 5/5;
  micros 114/114. C1b next: bands become DECL-grained (handle =
  band·16384 + slot, a TRANSITION), which makes overlay membership a
  band-range projection and the enclosing-decl edge an O(1) read.
- 2026-07-25 · ▶▶ THE FORK TRIPLE — R6 closes the world arc, and the
  interleave shows its first live witness (Phase C rung 0 · pin
  09b95e50). Every candidate fork restores THREE legs — graph
  checkpoint, heap region, WORLD — at all three fork sites (the synth
  fan's two loops; try_each_annotation, half a pair since birth, gains
  its heap AND world legs). world_restore lands as the fork boundary's
  world reset (a substrate op, NOT a general setter — its one sound use
  is a value world_top() returned at the fork point, predating every
  push the forked extent made; the world's other writers stay the
  emitted pushes and bracket restores), crossing recognition in the
  two-generation dance the crossing constraint demands — the gate
  REFUSED the single-step form (E_EffectUnhandled: Memory at the root)
  exactly as the world_top precedent says, and the law is now paid at
  the substrate-op altitude twice. The world leg had held by
  extent-balance alone — an accident-invariant made a contract before
  the parallel fan (rung 3) needs it per-cursor. THE INTERLEAVE
  WITNESS, counted: landing the heap leg at try_each_annotation
  trapped the field leg in intern_probe — a candidate's
  intern_str("Alloc") FIRST-inserted its canonical row IN the region,
  the reset zeroed it, the next candidate's probe walked garbage (and
  teach-pure-control's severed-name proposal died of the same root).
  THE CONTRACT: the intern is DURABLE state; a fork extent must never
  first-intern. The pre-warm (the severed-effect names interned once
  below the fork marks) makes every in-fork intern a pure probe hit —
  stated at the site, and banked as the two-channel design's first
  measured case (durable-vs-transient inside one extent — exactly what
  the §5.O image/scratch split exists for). CLEAN m2 == m3; census 0;
  frontier 266/0; proof-exactness 9/9; crown 5/5; micros 114/114.
  Phase C's remaining rungs: the deterministic handle partition (the
  keystone, shared with native), the parallel compile spine, the fused
  oracle.
- 2026-07-25 · ▶▶▶▶▶ THE ORDER-INDEPENDENT JUDGE GOES LIVE — phase B-ii
  COMPLETES its payoff: the two-pass walk re-wires into compile_stdin,
  self-hosts, and costs ~12% (pin 5b693139). The re-measure law paid
  twice today: the banked recipe re-landed and self-compiled with NO
  OOM on the first try (the morning's arena strikes had already
  un-gated it — the arena demoted from gate to amplifier for the
  SECOND time), and the first timing (24.5s, 5.2× over single-pass)
  fell to 5.3s through four cuts the landing itself forced, each
  caught by a gate or a probe: (1) TypeVariants — the type's own env
  entry CARRIES its variant specs, minted at registration where the
  list is in hand; the whole-env backward scans (46% of the two-pass
  compile once the env doubled — perf named variant_specs_filter_from
  at 45.9%) deleted whole; the entry registers BEFORE the ctors so a
  same-named single-variant ctor shadows it in value position (the
  585-error refusal that taught the order — `Instant(ns)` resolving
  the arrow-less type entry), and the read is the kind-filtered walk.
  (2) The env walk family UNIFIED: the three predicated bucket walks
  are ONE env_bucket_pos_where over top-level predicate fns passed as
  static closure pointers — zero allocation (Morgan's "lookup? 8
  interrogations" cut: the fourth copy of the validated-continue shape
  was drift-7 at the env layer); the plain hottest-path resolve keeps
  its own predicate-free shape deliberately. (3) The trial is a WORLD
  of its own — fresh affine/region/verify ledgers die with its
  bracket. (4) THE CLASS EXPOSES ITS MOST-REFINED MEMBER (the
  representative-choice projection the alias-preserving peer
  prescribed, written at the decl's own ret pin): the ann-pin's unify
  peels the wrapper into the class, so generalize published PEELED
  finals and every caller's edge raised an undischargeable copy of a
  proof the decl already carried — four spurious `self == 7` pends on
  the capability fixture the moment finals resolved (the ledger-speak
  probe named every one); the rebind makes the refined form the
  representative, generalize publishes refined finals, and callers
  inherit the decl's proof — debt 0. THE JUDGMENT ITSELF: verdicts no
  longer depend on declaration order anywhere on the stdin path;
  the emitted wheel is ~40k lines SMALLER than the single-pass wheel
  (finals prune what looseness padded); 5.3s / 506MB RSS. CLEAN
  m2 == m3 at 290,409 lines; census 0; frontier 266/0; proof-exactness
  9/9; crown 5/5; micros 114/114. B-ii's residue: the step-4 decl
  regions (infer +91MB walk, lower +99MB) remain the arena's remaining
  shares — amplifiers now, gating nothing.
- 2026-07-25 · ▶▶▶ THE WORTHINESS CLOSURE — the demand analysis' 274MB
  monster dies, and the gate caught the fix's own first form
  under-approximating (the arena arc's second strike · pin a9d0fb45).
  The chain, each step measured: spec_resolve went CHECK-THEN-BUILD
  (A.3's exact shape — the eager walk re-cloned every fully-concrete
  site type at ~1e5 reference reads; the change-walk is raw-recursion
  loops per the battery law, closures allocate; ~29MB); the sub-seam
  probe then pinned spec_worthy_fix at +274MB — every ROUND re-scanned
  every candidate's whole body TWICE and re-minted every interior
  site's mangled name, though BOTH facts are ROUND-INVARIANT (sensitive
  depends only on the body+pairs; the interior twin-name edges only on
  the body+ctx). THE FUSED FORM: one body scan per candidate — inside
  spec_candidates_fix's own transitive closure — yields the inner
  candidates, the sensitivity witness, and the interior edges; the
  worthiness fixpoint is then a pure name-set closure over facts
  (closure_fix's species, the incremental cursor's sibling — zero
  scans, zero mints per round); spec_worthy_fix / spec_worthy_pass /
  spec_candidate_sensitive / spec_candidate_calls_worthy deleted whole.
  THE CATCH, counted as the kill it is: the first fused form ran the
  sensitivity witness UNDER the instantiation ctx — the witness's own
  law says "at the floor, no substitution: the var-ness is exactly what
  the floor emission sees" — ctx masked every var, the wheel
  under-emitted 17k lines of twins, and the address-comparison
  miscompile class RE-OPENED; the float frontier leg convicted the
  unblessed intermediate (exit 1, the silent-wrong made loud), and the
  witness moved ctx-clear while interior keys stay ctx-set (ONE
  structural scan, TWO lookup contexts — stated at the site). MEASURED
  on the corrected sound build: self-compile 6.78s → 4.71s (−31%), RSS
  728MB → 407MB (−44%), every twin kept. Combined with the morning's
  emission regions, the day's arena strikes: 6.4s/754MB-bump →
  4.7s/407MB-RSS with Law 7 or the fixpoint held at every step.
  TRANSITION m3 == m4 at 332,604 lines; census 0; frontier 266/0;
  proof-exactness 9/9; crown 5/5; micros 114/114. The arc's remaining
  named shares: infer +110MB and lower +99MB (the step-4 decl regions,
  the genuine interleave), then the two-pass re-wire rides.
- 2026-07-25 · ▶▶ THE EMIT PHASE JOINS THE ARENA — measure first, then
  the region (phase B-ii steps 1+3 open · pin 8ea44a73). The watermark
  probe named the image's true shape: post-read 11.8MB → parse 66.4 →
  infer 176.0 → saturate 178.0 → lower 277.5 → reach 307.8 → EMIT
  753.8MB — emit owned 59% of the whole self-compile image. The
  sub-seam probe split it exactly: spec_demands_of ALONE +362MB (its
  own "zero new storage" comment refuted by the artifact — the
  comments-can-be-wrong law with a number), record collection +15MB,
  the per-fn emission churn ~54MB. THE CUT LANDED: emit_functions
  built EVERY fn's full text before writing one byte (map-then-each —
  the entire module's emission materialized simultaneously); each
  record now builds → streams → resets under its own heap region, and
  the twin loop, wide wrappers, and fold-leaf families ride the same
  bracket — the compile spine's first per-fn regions, the battery's
  arena pattern at the emit phase. MEASURED: emission's allocation
  share fell to ~0 (pre-fns 699.0MB → post-fns 699.03MB); Law 7 held
  BYTE-IDENTICAL (allocation addresses never reach the wat, proven not
  assumed). The bracket's standing contract at the site: per-fn
  metadata handlers (body_context and kin) overwrite before any read,
  so a dangling region pointer is never read. The arc's next strike is
  NAMED WITH ITS NUMBER: the 362MB spec-demand churn (the per-site
  instantiation walks), then infer's +110MB and lower's +99MB — the
  step-4 decl regions. CLEAN m2 == m3; census 0; frontier 266/0;
  proof-exactness 9/9; crown 5/5; micros 114/114.
- 2026-07-25 · ▶▶▶▶ THE INCREMENTAL CURSOR — PHASE B-i COMPLETES (§2's
  cached-cursor mode cross-run; landing 3 · pin dfe19175). Patch one
  module of a DAG: the next compile restores the image, names the exact
  cone ("warm: re-deriving b main" — a cached), re-judges ONLY the cone
  into the restored world, and re-persists — the image tracks the tree
  edit by edit, and the emission is BYTE-IDENTICAL to a cold compile of
  the patched tree (the frontier's strongest oracle; the pure-warm third
  run answers "image current — nothing re-derived"). The mechanism is
  the swap-parameter dissolution completed: the image carries its OWN
  manifest, entry name, and per-module statement buckets as typed roots
  (warm_manifest / warm_entry / warm_asts), so the post-swap path takes
  ZERO pre-swap heap arguments; the current tree reads fresh off the
  host fs (files survive the swap by nature); re-registration shadows
  the stale entries (the env's latest edge wins) and the entry is
  ALWAYS in a nonempty cone (every DAG module is one of its transitive
  deps). MORGAN'S MID-BUILD CUT — "8 interrogations" — found two
  Carried-Truth violations the green byte-equality probe could not see:
  warm_root was a STORED FLATTEN of warm_asts (the derived value
  persisted beside its source — deleted; warm_program() is the read),
  and the incremental path walked the module tree THREE times (the
  pairs pass, the deps pass, the order pass — fused into ONE
  driver_tree_scan whose three consumers are projections). Two classes
  paid en route, both catalog entries firing live: the POINTER-EQ class
  twice (module_in / manifest_hash_of compared erased elements at the
  word floor — every module "changed" and NONE joined the cone, the
  probe's own "warm: re-deriving " empty line the tell; `: String`
  Intent-Boundary pins carry the proof until name-is-handle retires
  str_eq), and E_DuplicateFnName DECOUPLED from the env into the
  registration walk's own seen-set (the env-based check misread a prior
  judgment's entry as a duplicate the moment the cone re-registered —
  exactly the flaw the two-pass build named yesterday; its banked
  decoupling is now the landed form, and the incremental cursor is its
  first consumer). Honest bounds stated in place: the fixture's
  byte-equality is exact because it is lambda-free (lambda names carry
  handles; the deterministic handle partition, Phase C's keystone,
  generalizes it); the split-by-ranges attribution reads the weave
  fold's own carried product (the zero-reader per-module overlay
  machinery belongs to the retired per-module check walk, not
  fake-ridden); cone diagnostics carry file-local spans — sharper for
  the user than weave lines. CLEAN m2 == m3 at 330,626 lines; census 0;
  frontier 266/0 (twelve TIME legs); proof-exactness 9/9; crown 5/5;
  micros 114/114. B-i's remaining felt tier — the edit-session as a
  persisted value — rides Phase D's living session on exactly this
  substrate.
- 2026-07-25 · ▶▶▶ THE RESUME VERB + THE FINGERPRINT DISSOLUTION — the
  image IS the process, and the interrogation deleted a gate (phase B-i
  landing 4 · pin 99ecf00d). `mentl resume <image>` re-enters a
  persisted compile image and emits with the SOURCE ABSENT — the
  frontier leg deletes main.mn and the emission stays byte-identical:
  the projection rode the image, absence is the proof. THE RESTRUCTURE
  THAT MADE IT SOUND (the eight interrogations refusing the obvious
  port): the resume verb under the arm-form rehydrate would have needed
  the resuming process to replicate the persisting process's install
  AND allocation prefix (its argv alone shifts every chain-node
  address) — the fingerprint contract generalized to an unmeetable
  demand. The root: an effect-arm restore puts ONE dispatch bracket's
  pre-swap world write on the trust path. rehydrate DISSOLVED into
  image_resume — the restore as a direct substrate call — and with it
  every remaining pre-swap-saved world write fires in the benign tail
  (extent-ends after the last perform) while every post-swap dispatch
  walks the RESTORED $world_g: the world is image-resident end to end,
  and an image is resumable from ANY same-build process, any argv, any
  chain. The fingerprint, its walk (world_fingerprint /
  fingerprint_bytes), its wire field, and the morning's own
  install-prefix-correspondence law are DELETED — superseded by
  structure, not softened (the ⚖ alive-law: the measurement that
  binds rewrites the law in place; this morning's landing-1 entry
  reads as the era's record). The wire is [key][k][size][gcount]
  [globals][image]; the corruption legs pin both remaining guards RED
  (build-key refusal naming both keys; corrupt-gcount tripping
  $image_restore's layout belt). compile_remainder is the ONE home for
  the projection half — cold, warm, and resume all run exactly it (the
  three routes cannot drift); the verb rides the VerbSpec table with
  its own raw-path builder (an image is a file, never a module). The
  convergence loop en route: the sharper judgments named
  driver_compile_entry's missing Fail/WASI and image_resume's
  Filesystem-vs-WASI truth (the _impl substrate face, the persist
  policy layer's own convention) — census 0 → 1 → 0 twice, the ratchet
  refusing each intermediate. CLEAN m2 == m3 at 330,542 lines; census
  0; frontier 263/0 (nine persist/warm/resume legs); proof-exactness
  9/9; crown 5/5; micros 114/114.
- 2026-07-25 · ▶▶▶ THE WARM START — the compile restores its own analyzed
  image (phase B-i landing 2 · pin 28eb3444). driver_compile_entry keys
  the weave (every DAG module's text hashed in canonical order — the
  prelude seed rides the same list the analysis weaves — mixed with the
  build key), and on a CLEAN analysis persists the whole rooted image
  into the project's .build; the next compile of the same weave probes
  both wire gates COLD-SIDE (a stale or foreign cache falls back to
  re-derivation instead of refusing; rehydrate's own gates stay the trap
  beneath), restores, and lowers the live graph — frontend and inference
  skipped whole (Hβ.persist.module-image-cache's first real form; the
  dirty case re-derives honestly because the diagnostics ledger rides
  the image as counts, not replayable prints). The typed re-entry is
  warm_root — a top-level cell the globals record restores; the compile
  chain grew ~> persist_to_disk ~> fail_exit. THE GATE (frontier
  warm-start, RED before the landing): cold run persists and emits;
  warm run prints the warm line and emits BYTE-IDENTICAL WAT off the
  restored image — the strongest oracle the seam admits, and it held
  despite the two runs lowering from different heap lines. TWO LAWS
  PAID FOR EN ROUTE: (1) VIRGINITY IS THE RESTORE'S CONTRACT
  ($heap_reset_impl's law at the image altitude) — $image_restore zeroes
  [image-extent, old-bump): the restored line rewinds, so the resuming
  process's dead pre-swap heap must read never-allocated, or
  post-restore allocations serve stale bytes as unwritten slots.
  Measured through five probe rounds (count the kills): the warm
  saturate walk chased a garbage operand into list_index's i<0 bounds
  trap (the 0x100000000 signature); the record, its canon spine, and
  node 3389's cells all probed BYTE-FAITHFUL live-vs-wire before the
  dead-region channel isolated by elimination; the two-process fixture
  had survived only by allocating almost nothing post-swap — an
  accident-invariant named a contract (forensic law 5). (2) A PREAMBLE
  FIX CROSSES A GENERATION — the executing $image_restore is the
  EMITTING compiler's preamble, so every probe of the fix through the
  boot-emitted m2 ran the OLD form (the pattern-fill experiment
  included; its assertion failure was the tell); the fix first executes
  in m3's own body. The crossing constraint, already law at the
  recognition layer (world_top), now named at the PREAMBLE altitude so
  no future substrate-preamble fix is probed a generation early.
  Residue banked: the cache is compile-seam only (check/at/teach ride
  driver_entry_with_ranges — landing 3's per-module IC generalizes);
  the wire doubles the image transiently at persist (the arena's
  scratch channel absorbs it). TRANSITION m3 == m4 at 331,274 lines
  (the 2-line crossing is the restore preamble); census 0; frontier
  260/0; proof-exactness 9/9; crown 5/5; micros 114/114.
- 2026-07-25 · ▶▶▶ THE ORDER-INDEPENDENT JUDGE'S HARVEST — the two-pass
  walk rebuilt, converged to judge-ZERO, measured, and its fifty
  findings landed while the machinery unwired (phase B-ii step 0
  closes · pin 6965d5bb). The banked design built clean in one pass:
  a diag_quiet handler (all three Diagnostic ops armed) absorbs the
  TRIAL pass, whose one product is the env holding every fn's FINAL
  scheme; the FINAL pass re-judges fresh nodes with every reference —
  forward included — resolving those finals (fn pre-registration
  skipped: infer_fn's unbound-handle arm self-registers monomorphic
  recursion; the duplicate-fn refusal decoupled into its own seen-set
  walk). THE JUDGE CONVICTED THE WHEEL of ~20 real order-masked
  wrongs, 50 errors → 0 across five convergence rounds, every fix
  valid under today's judgment too (boot census held 0): abs was an
  IDENTITY on negative floats (its `0` literals pinned Int -> Int
  while all three callers — the dsp envelope/peak/flux family — pass
  Float; each forward site unified loose while the compiled body
  word-floored); infer_unaryop string-matched "Neg"/"Not" against the
  parser's UNeg/UNot ADT — no arm ever matched, and the deleted
  catch-all fabricated `!x` as its operand's type instead of Bool;
  the formatter's five chain arms matched PipeExpr at the wrong
  altitude (ast_kind_of projects NodeBody; every chain fell to the
  non-chain render — the render-totality arc's own arms, dead since
  birth); autodiff under-dimensioned its matrix ([Float] at the op
  decl AND the tape field; transpose named the truth); the
  record-literal field carrier is the parser's (name, value) TUPLE —
  oracle's three literal arms read .init off tuples (the 6807a214
  claim corrected; resume updates alone are records); the str-raw
  satellites (driver count_lines, main's line helpers, lsp_frame's
  whole header family) re-typed through byte_len/byte_at with
  read_headers_until_blank gaining its str_of_buf boundary; list_eq's
  loop un-crossed altitudes (list_index_unchecked, the f64 siblings'
  form); driver_check_module's if arms agreed on (); with_run exits 1
  on its unbuilt verb; and ~35 declared rows widened to their bodies'
  truth (the widen loop 13 → 22 → 18 → 6 → 2 → 0, automated per-round,
  two multi-line heads hand-fixed per the never-mangle rule). THE
  MEASUREMENT THE STEP CHARTERED: the judge-0 wheel's m3-leg
  self-compile still dies — alloc's wraparound guard at
  emit_wide_wrappers, ~28s, 1.1GB RSS with the 4GB bump extent
  exhausted — so the two-pass OOM verdict is CURRENT, not stale
  (unlike seq-op's), and the machinery unwired whole (drift-9-clean:
  zero dead code stays). Banked on the peer: the working build recipe,
  the convergence protocol (fix the JUDGED source under the standing
  judge, rebuild the judge, repeat), and the DEP now measured at the
  exact site — the arena's image/scratch split, or wasm64's ceiling
  lift. En route kills, counted: the first error map skipped
  wt_wheel's tutorial exclusion (all src lines shifted — the
  one-binary/one-blob forensic law at the map layer); the second
  drifted +7 after the abs fix edited the blob under it. TRANSITION
  m3 == m4 at 330,255 lines (the 14-line crossing is infer_unaryop's
  corrected graph); census 0; frontier 258/0; proof-exactness 9/9;
  crown 5/5; micros 114/114.
- 2026-07-25 · ▶▶▶ THE ROOTED-IMAGE PERSIST — persist = memcpy made real,
  proven by a fresh process (phase B-i landing 1 · pin 88c1b888). The
  image [0, heap-line) plus the mutable-global record IS the whole
  program state (wasm call frames live engine-side), so the emitter now
  projects three facts of a module over ITSELF, emitted only when the
  reachable tree performs an image op (Law 7 — the wheel stays
  byte-identical): $build_key (a hash of the fn table names, interned
  data, and mutable-global census — exactly the three same-build-only
  word classes a restored image's baked words depend on; the key IS the
  compatibility contract, no over-refusal), $globals_save/$globals_restore
  (the census record, slot 0 the heap line, wide feedback slots at their
  own repr), and $image_restore — globals from the wire FIRST (the wire
  may lie inside the image range), then ONE memory.copy of the image
  over [0, size): memmove semantics make the overlapping self-copy
  exact, so the staged-scratch choreography the first design carried
  DELETED ITSELF (the law smiling: less code). persist.mn sheds the
  record-copy prototype whole — persist(k, path) drops the caller-
  supplied size (heap_mark reads it live), the wire is [key][k][size]
  [fingerprint][gcount][globals][image], and rehydrate refuses through
  TWO gates: the build key, and the world fingerprint RE-PURPOSED by
  interrogation — the first design deleted it as vacuous (the world
  rides the image), then the unwind walk resurrected it: the restore
  happens INSIDE a perform's dynamic extent, every enclosing dispatch
  bracket writes back a pre-swap world address as it unwinds, and those
  addresses are valid exactly when the resuming process reached
  rehydrate under the SAME install prefix (same build + deterministic
  bump ⇒ same addresses) — the name-level fingerprint is that contract,
  checked, an accident-invariant made a contract before it ever fired
  (forensic law 5 ahead of the crash). The declared-unwired
  E_ResumeWorldMismatchWorld DELETED (wire-or-delete resolved: refusal
  rides fail; the cross-world-resume class dissolves when the world is
  image data). The typed re-entry channel is a restored top-level ROOT
  — leg B reads A's thunk through the restored let global, fully typed,
  and the no-from_addr law holds untouched (rehydrate's returned word
  is the belt beside it, tied by Cast's addr). GATES at all four
  corners: leg A persists mid-computation (exit 40, ~1MB wire); leg B —
  a FRESH PROCESS of the same wasm — passes both gates, swaps A's image
  in, chases three A-heap records (root list → thunk record → captures)
  and runs A's thunk (exit 42); a corrupted key refuses naming both
  keys; a corrupted fingerprint refuses naming both worlds. Counted
  kill en route: the first gate probes corrupted disk+8/+20 believing
  an on-disk header exists — fs_write writes the PAYLOAD, the file IS
  the wire; both "gates failed" verdicts were the prober violating the
  protocol it probed (forensic law 2), dead in one re-read. RED on the
  pre-image boot (unrecognized substrate ops → compile refusal, zero
  WAT). Board whole at the pin: CLEAN m2 == m3 at 330,102 lines;
  census 0; frontier 258/0; proof-exactness 9/9; crown 5/5; micros
  114/114. B-i's named remainder: the warm-start cache (landing 2),
  per-module IC on the overlay write-half (landing 3), `mentl resume
  <img>` re-projecting at the saved caret with the source absent
  (landing 4), and session-as-value as the felt gate.
- 2026-07-24 · ▶▶ THE SEQ-OP ROW UN-REVERTS — re-measurement, not the
  arena, un-gated it (phase B-ii step 0 · pin 7aa2d7a0). The B-ii recon
  banked the verdict: both OOM rulings were one representation era
  stale (measured on the 559k-line wheel; the current wheel compiles at
  ~694MB against the 4GB ceiling — 6× headroom). The 2026-07-17 revert
  re-ran on the current pin: infer_seq_op reads the callee's OWN
  declared row live (graph_chase(fh) — the read its own comment
  prescribed for a year), the Memory floor surviving only for an
  unresolved callee. NO OOM at the m3 leg; the honest-attribution
  compiler immediately re-judged its own source and named NINETEEN
  under-declared rows (the widen loop, 19 → 3 → 2 → 0: str_slice,
  fs_path_view, chase_probe_tag, show_span, the whole synth
  candidate-mint family) — the honest wheel lands 3,600 lines SMALLER.
  CLEAN m2 == m3 at 329,046; census 0; board whole. The arena demotes
  from keystone to amplifier; the two-pass walk's re-measure is the
  remaining step-0 item. Recon reports for BOTH phase-B halves are
  banked in the campaign mirror (persist: rehydrate is dead code, the
  world-mismatch raise unwired, the emitter can generate
  $globals_save/restore, four RED-first landings specified; arena:
  the image/scratch two-channel design, the interleaving hazard map,
  the fork-pair sweep find at try_each_annotation).
- 2026-07-24 · ▶▶▶▶ THE TSTRING DISSOLUTION LANDS WHOLE — PHASE A
  COMPLETE (A.4 steps 4+5 in one arc · pin 5673c47c). The nullary
  TString ctor is DELETED from Ty; "String" IS one canonical
  TAlias("String", TList(TByte)) node in THE CANON (src/canon.mn, the
  new one-home for shared canonical nodes — born when the census named
  25 forward references: top-level lets are not pre-registered, so the
  canon sorts early; order-independent-lets is the named dissolver and
  the ef_pure_row shared form's future home). Every mint flipped
  (parse_type_atom, four infer binds, eighteen face rows); the
  unify/same_ground string arms, both already_string probes, and every
  H6 scalar row deleted whole — the compile-guided sweep, census-named
  at 26 → 0 across two rounds; BConcat strips first; synth's
  byte-element dispatch keeps String holes proposing string literals.
  The sentinel's own comment carried its retirement: the OOM died with
  A.3's sharing, partial migration with the one shared node.
  TRANSITION m3 == m4 at 332,555 lines (the 6,336-line crossing is the
  type-representation change); census 0 at every generation; frontier
  254/0 — every string-oracle leg green through the TString-free
  compiler; crown 5/5; micros 114/114. §4①'s "String IS [Byte]" is now
  a fact of the Ty ADT itself, not a claim bridged by special arms.
  Named residue: the String-hole proposal leg (oracle gap 7, the
  edit-harness shape) and the order-independent-lets capability.
- 2026-07-24 · ONE TYPE, ONE HASH (A.4 step 3 · pin 540eb950).
  hash_node_of's list arm goes element-face: a byte face hashes as
  TEXT (str_hash), the projection a String field always took — the
  hash route split dies (one type, one hash fn), and the reach seed
  mirrors the route. The scalar-faces oracle leg held green through
  the change (its pins were deliberately route-agnostic). CLEAN
  m2 == m3 at 333,019 lines; board whole.
- 2026-07-24 · ▶ THE TSTRING DISSOLUTION OPENS — recon banked, oracle
  wave landed, the dead arms delete (A.4 steps 1–2 · pin e213ce1b).
  The Fable recon (worktree snapshot, self-adversarial re-grep) found
  the fact the 2026-07-20 attempt lacked: EVERY backend fold dispatch
  strips, so fold_strip(TString) = TList(TByte) makes the emit's
  TString arms DEAD-BUT-AGREEING — and form (ii) is forced (delete
  the ctor; "String" = one shared canonical TAlias("String",
  TList(TByte)); H6 exhaustiveness turns every missed site into a
  compile refusal, the anti-absorption mechanism itself). Two
  pre-existing diseases surfaced: the HASH ROUTE SPLIT (top-level
  hash(s) → list_hash, a String FIELD → str_hash — one type, two hash
  fns) and [String] element == word-comparing at concrete sites. STEP
  1: three oracle legs pin today's routes (scalar faces / aggregates /
  the : String annotation boundary — the fixpoint is structurally
  blind to string-route regressions; the wrong [String] == is
  deliberately NOT pinned). STEP 2: thirteen dead arms delete whole —
  census confirmed no exhaustiveness loss, CLEAN m2 == m3 at 332,942
  lines (280 smaller), and the string battery ran green through the
  arm-less wheel. REMAINING: step 3 (hash-route unification + BConcat
  strip-first), step 4 (mint flip under peel-coexistence + the synth
  byte-elem proposal arm + the C fixture), step 5 (ctor deletion,
  H6-compile-guided sweep). The full corrected design is in the
  campaign mirror.
- 2026-07-24 · THE VOICE SPEAKS ITS PAYLOADS (two #9 render singles ·
  pin 10b79aa8). show_eff_arg's EAType arm renders the instance's real
  type via show_type — the cast-refused crucible's message now carries
  the live payload where an opaque marker sat — and show_pred_operand
  gains the call-shaped arm, so len(self)/abs(x) predicates render as
  calls. callee_name's sentinel is load-bearing, untouched. CLEAN
  m2 == m3 at 333,222 lines; board whole. Banked en route: a
  len(self) > 0 ground refusal still pends at Verify (the
  ground-decidable fragment does not fold len — band F's fragment
  growth, distinct from the render class).
- 2026-07-24 · IDENTITY IS THE FIRST STRUCTURAL FACT (the eq
  short-circuit · pin 3d862357). The generated $eq_<sig> helpers open
  with one word compare — the same record equals itself — before any
  field conjunction or tag load; list_eq/list_eq_f64 say the same fact
  in their raw bodies (identity is the value-faithful reading even for
  a NaN-holding sequence self-compare). Sound unconditionally,
  effective wherever canonical instances flow — the intern made that
  the common case for names. TRANSITION m3 == m4 (the 20-line diff is
  the two preambles crossing one generation); board whole; ~6.4s.
  Named residue: str_eq's typed body cannot say pointer identity —
  the String == identity path is a one-fn emit-wrapper strike. The A.4
  adversarial mint-enumeration recon is DISPATCHED (Fable, worktree
  snapshot) — its report opens the TString dissolution arc.
- 2026-07-24 · THE CAST VOCABULARY — the word-face capability, zero
  readers by design (A.5 · pin 394917cf; phase A closes except A.4's
  own arc). effect Cast { addr(a) -> Int } lands beside effect Memory
  (the substrate home RTLIBS and the wheel both see); lower erases the
  perform to its operand — identity at the word level, zero emission —
  so the substrate is the handler, no census demand reaches the
  executable gate, and the ROW carries the whole meaning: with Cast
  admits, a declared !Cast severs. No from_addr up-cast exists, ever
  (str_of_buf stays the one localized coercion). Crucibles seen at
  both poles: cast-addr proves word-face facts through the erase (42;
  RED on the pre-Cast boot — the op lowered as a handler-less demand
  and the gate refused the executable) and cast-refused proves the
  severance REPORTS at the declaration, E_EffectMismatch naming
  !Cast vs Cast(<type>) — the A.6 bare-name-matches-instance handle
  compare doing exactly its job. Two truths banked from the probe:
  E_EffectMismatch is NOT an armed refusing class (the
  reference-memory "user-effect !E hard-refuses" claim describes a
  different tier; arming the class is the refusal-law's licence-gated
  landing, named here so it is never smuggled in as a rider), and the
  parameterized instance renders its payload as `<type>` (the
  E_RefinementRejected `<expr>` render class's sibling — the residue
  queue carries both). CLEAN m2 == m3 at 333,002 lines; census 0;
  frontier 245/0; board whole at the pin. The first consumer is the
  arena-gated signature-driven seq-op landing (B-ii), where raw
  bodies gain authored signatures and rows become true by inference.
- 2026-07-24 · INSTANTIATE SHARES, NEVER CLONES — landed in its second
  form after the artifact killed the first (A.3 · pin 6d6ac5ab; the
  superseded first-form pin 0bb49387 stays in the PROVENANCE chain as
  the counted kill). subst_ty and chase_deep_at are CHECK-THEN-BUILD:
  a Bool change-walk (word returns — zero allocation) gates the
  original eager arms, which recurse through the sharing face so
  unchanged sub-subtrees re-share at every level; find_mapping's
  per-leaf filter materialization is a plain walk. THE KILL, counted:
  the first form flag-threaded (Ty, changed) tuple returns — and
  tuples are heap records in this substrate, so every scalar arm
  minted a record where the eager walk minted none; measured +6%
  (6.42s → 6.82s medians, three runs each, same wheel through both
  boots) with RSS flat — the panel priced the sharing but not the
  flag's carrier. The check form measures NEUTRAL (6.51s median,
  inside the reference band) and allocates nothing on unchanged
  paths; max RSS stays ~717MB because the self-compile's peak lives
  in lower/emit, not this channel — the sharing's real purchase is
  HEADROOM for the TString alias dissolution (A.4), whose type-node
  bloat multiplies through exactly the instantiate channel. CLEAN
  m2 == m3 at 332,964 lines; census 0 at every generation; board
  whole at the pin.
- 2026-07-24 · ▶▶▶ EFFNAME IS A HANDLE — identity becomes a contract
  (A.6, the crown cash-out · pin 91e35f1e). ENamed(Int) |
  EParameterized(Int, [EffArg]); EPure = the absent 0. The
  ripple-killer the adversarial panel missed: the projection SPLITS —
  eff_name_handle (Pure, the comparison key: the six by-name str_eq
  leaves go word i32.eq, and bare-vs-instance matching is the same
  compare) beside eff_name_str (render-only, intern_name_of), so the
  dreaded row widening never touches the hot family — only the few
  cold render sites widened (eff_names_to_str, row_to_with_clause,
  catalog_handled_effects, eff_name_label). The intern grew
  intern_str + intern_name_of + entries (the reverse read arriving
  WITH its reader), and intern_table moved OUTERMOST in the core: the
  report arm renders diag_message live and an arm's performs resolve
  outer to its install (R2's law at the core order — an inner intern
  left diagnostics' row rendering handlerless). THE SWEEP WAS
  MEDIUM-NAMED: 12 → 2 → 1 → 0 across four compiles, every typed site
  an armed E_TypeMismatch naming its own line. THE BLIND SPOT the
  census structurally cannot see, the FIXPOINT caught: eff_names_of
  ("effect-row names as bare strings") pushed the raw handle word
  into lower's ERASED string list — no type meets an erased list —
  and the m3 leg trapped in the escaping fixpoint's set_insert where
  str_lt walked a tiny address into a garbage make_list. One
  projection renders the boundary now; the lesson is the two-oracle
  law made concrete: the armed census gates the typed surface, the
  self-application leg is the net beneath the erased one. MEASURED:
  crown 5/5 with the positive-path residual (~146 byte-equal-but-
  pointer-distinct false mismatches) closed BY CONSTRUCTION (the pair
  is untypeable; a missed mint is a loud type error — the contract
  the intern's masking lacked); CLEAN m2 == m3 at 330,661 lines
  (handle assignment is a pure function of the source); frontier
  241/0; proof-exactness 9/9; micros 114/114; census 0; 6.9s
  self-compile (the row-mint probes cost ~0.3s against exactness —
  honest, and the token-carries-handle cut removes them). NAMED
  RESIDUE, each its own strike: TName's String names are the same
  disease at the TYPE layer (type_name_eq's str_eq pin sits in
  unify's hot path — the sequel identity cut); TIdent still DISCARDS
  the handle lex returns (token-carries-handle unlocks env keying,
  §5.O layer 2); instance-precise negation
  (Hβ.effects.parameterized-negation-instance) stays the banked
  follow-on with its own crucibles.
- 2026-07-24 · ▶▶ THE INTERN SUBSTRATE — a name is born once (A.2, the
  phase-A spine · pin 66e097e9). effect Intern { intern_span } +
  intern_table land as the analysis core's innermost handler (every
  chain's lex runs inside the bracket): one row per unique identifier
  — (canonical String, handle, keyword kind) — hashed over the source
  RANGE, compared by the new str_eq_at, keyword-classified ONCE at
  first sight; a repeat occurrence returns the SAME String pointer
  with its banked kind — zero allocation, zero keyword compares (the
  row-carries-kind form beats the refuter's 18-i32.eq floor: no
  per-occurrence compare at all). The planned declared-row sweep never
  fired — the frontend chain's rows are all inferred, so Intern flowed
  to the bracket's absorption with ZERO census errors on first
  compile. THE MARCH RULED TRANSITION (592 lines) AND THE ARBITRATION
  FOUND A HEAL, NOT A LEAK (the refuter's Law-7 expectation was wrong
  in premise, and its own accident-class warning was the mechanism):
  the capture walk's dedup (set_contains, lower.mn:5009) compares
  names WITHOUT a String proof — pointer identity — so boot's
  per-occurrence slices double-captured twice-mentioned free names
  (index_of's search captured sublen TWICE; counted in the m2 WAT, 2
  reads vs m3's 1); canonical instances make that dedup byte-accurate
  and 36 wheel fns' closure records shrink. Named forward: canonicity
  MASKS the identity-sensitive compare class within a lex session —
  an accident-invariant, not a fix; a runtime-constructed name still
  pointer-misses. A.6's Int handle is the contract; the by-name-leaf
  census instrument rides it. MEASURED: 6.42s → ~6.0s; str_eq 5.85%
  → 4.0%; intern machinery below the profile floor; m3 == m4,
  census 0 at every generation, board whole at the pin. Self-build
  delta: the medium refused nothing and named nothing this landing
  because there was nothing to name — the armed classes and the
  fixpoint arbitration did the reviewing a human would have.
- 2026-07-24 · THE STALE-BUCKET FALLBACK WAS THE SCAN — env_find_flat
  DELETED whole (phase A's fourth strike · pin 3d2b029c). The comment
  called the stale-bucket case rare; the profile priced it at 5.85% —
  every scope re-entry reuses positions, so env_resolve's
  first-hit-then-bail shape ran the O(n) scan constantly.
  env_bucket_pos validates against the buffer INSIDE the walk (the
  type/ctor siblings' shape) and continues past stale pairs; complete
  by construction (every env_extend adds its pair; pairs are never
  removed), so the fallback is unreachable and §5.O's documented
  villain dies as LESS code. CLEAN m2 == m3 at 330,057 lines (50
  smaller); self-compile 6.42s — 15.56 → 6.42 across the day's three
  strikes, 70.58 → 6.42 (11×) across the campaign's perf arc. The
  medium's own verdicts gated every step (census 0, comment-refs 0 at
  each generation — the prose about the deleted fn died with it).
- 2026-07-24 · THE PATTERN PATH FOLLOWS THE ENV'S OWN EDGE (phase A's
  third strike · pin 8ba823f5). ctor_payload_tys_of re-derived a
  constructor's entry by scanning the whole env snapshot backward per
  LPCon bind (6.86% of the self-compile; a pinned str_eq the untyped
  snapshot tuple forced) — while the env's bucket index already drew
  the edge. env_lookup_ctor lands as the THIRD kind-filtered read
  (env_lookup_type's exact validated-walk shape, predicate =
  ConstructorScheme); the snapshot scan and its pointer-eq essay die
  whole. CLEAN m2 == m3 at 330,107 lines; ctor_payload_tys_find gone
  from the profile; ~8.5s → ~7.2s. The re-profile names the next two:
  env_find_flat at 5.85% is NOT the rare stale-bucket case its comment
  claims — env_resolve validates only the FIRST bucket hit and bails
  to the O(n) scan on staleness, where the type/ctor siblings validate
  INSIDE the walk and continue; folding the validation in makes the
  fallback unreachable and deletes env_find_flat whole (§5.O's
  documented villain). The ceremony residue (list_index_unchecked
  20.8%, len 12.6%) is now call volume itself — caller-side hoists or
  emit inlining, banked for the phase's re-measure.
- 2026-07-24 · ▶▶ THE CEREMONY FUSE — 15.56s → 8.46s (1.84×; 8.35×
  across the two perf landings), and phase A's design survives its
  adversarial panel CORRECTED (· pin cec0f2df). THE PROFILE FIRST (the
  campaign's measure-first law, third strike): host perf on the
  post-crc compile put the sequence header ceremony on top —
  seq_stride 9.4% + seq_tag 4.5% + decode_stride 4.2% +
  load/store_strided 5.8% raw, paid per element by
  list_index_unchecked (18.3%) and the fill walks — while the
  documented instantiate/subst_ty/find_mapping cluster sampled ~0%
  (its cost is ALLOCATION volume, the OOM channel; the sharing fix
  gates on an alloc count now, not a profile line). THE FUSE is the
  carried-truth law at the representation layer: the accessor-call
  form read the SAME tag word three times per element; the fused
  arms read it once and derive both projections locally — the word
  fast path is a single load, concat/slice recursion derives no
  stride at all, list_set keeps the byte range-trap and the wide
  copy-protocol through store_strided, and the flat_fill family
  collapses to native mem_copy for flat-to-flat ranges (three
  per-element strided loops became one bulk copy each; snoc fills
  derive their stride once per node). Uniform stride through a fill
  is the construction law (flat_raw allocates with the tree's own
  sc; sub-nodes carry the parent's), stated at the site. Lib-source
  only: CLEAN m2 == m3 at 329,959 lines, census 0, battery green,
  frontier/proof-exactness/crown/micro-tier green at the pin. THE
  PANEL'S PHASE-A VERDICT, banked as the corrected design: the
  `with Cast` body sweep REFUTED outright (masked by the seq-op
  Memory hardcode, self-deleting under tighten's T_OverDeclared
  authorship, inconsistent across the cascade — phase A lands
  `effect Cast { addr }` + lower-erase + RED-first crucible as
  ZERO-READER vocabulary, the RI8 precedent; the body sweep moves to
  the arena-gated signature-driven landing where rows become true by
  INFERENCE); the intern is a NINTH core handler in infer_context
  (string_table's install covers only 3 of 14 chains), emit offsets
  stay VISIT-ASSIGNED (pre-seeding = ~300KB dead-name bloat + an
  O(U²) dedup gate; the intern handle is compile-scoped, the offset
  its emit-time projection — two reads of one row), and A.2's gate
  expectation INVERTS to Law-7 byte-identical (an observed
  TRANSITION means lex state leaked into emit — a bug signal, not a
  crossing); the subst_ty changed-flag means "returned value differs
  from the input record" (an NBound resolution always reports
  changed — the shape-preserving reading; the freshened-only reading
  silently hands consumers unresolved TVar subtrees), and chase_deep
  is the SECOND unconditional reconstructor the alias dissolution
  must measure; ENamed's representation is FORCED to the Int handle
  (surface == on Strings is byte-compare by the structural law, so
  the String pick cannot deliver i32.eq; a missed mint becomes a
  loud type error — the enforcement the mint-law convention lacked,
  with six constructed-name families the design had missed); persist
  is SAFE either way (world_fingerprint hashes name BYTES from the
  image). Two traps named for the build: nested infer_context
  brackets must not shadow the intern (or handles never cross a
  bracket — the contract, instrumented at the three by-name leaves:
  a byte-equal-but-handle-distinct pair fires the census); the
  intern op's row ripples through lex_from into every chain body
  (plan the declared-row sweep, the ++-carries-row precedent). A.0
  doc-truths landed with the fuse: the §5.O instantiate anchors
  (2687/2840 → 4185/4351), the stale string_offset O(n) claim (it
  is O(1)-bucketed; the phase-A move is birth-at-LEX), the six-
  waypoint claim trued to its converged state (smap carries the
  infer/lower indexes; env_index and the emit string table are the
  two hand-rolled survivors), the band-B anchor (3174 → 5023), and
  graph.mn's checkpoint comment (thirteen → seventeen words).
  BANKED from the same profile, the next strikes: ctor_payload_tys_find
  6.86% + variant_specs_filter_from 0.61% are ONE scan family (a
  backward str_eq walk of the whole env snapshot per pattern bind /
  per variant read at EMIT — env_find_flat's sibling, itself 3.39%);
  the fix is one name-keyed read on the emit state serving both,
  Law-7 byte-identical expected.
- 2026-07-24 · ▶▶ THE PROSE GATE COST FIVE COMPILERS — 70.58s → 15.56s
  (4.5×) from one flatten (the campaign's measure-first law paying within
  its first hour). Host perf on the self-compile (the §8 recipe) showed
  83% of ALL wall time inside comment_refs_check → crc_scope_at: the
  backtick checker's scope list was snoc-spined and list_index walks the
  spine per read, so every commented handle paid O(scopes²) spine steps —
  while every documented perf target measured as noise (env_find_flat
  0.53%, str_eq 0.47%). The fix is the iterate-flattens-once precedent:
  crc_fn_scopes' result flattened ONE time before the per-comment scans.
  No code-reading estimate had ever named the site — the third time
  (after the classifier and the reachability scan) that the dominant
  O(n^k) was invisible to static reading. The remaining profile is
  representation ceremony (seq_stride/seq_tag/decode_stride header
  decodes per element access — the carried-truth question at the list
  altitude, Phase A/B's re-measure target). The README-transcript session
  that rode this also surfaced, each banked in the residue queue: the
  user-path diagnostic flood (every `mentl check` prints the SHIPPED
  lib's own T_OverDeclared/RedundantBraces warnings — the tighten/fmt
  sweep's felt face), the chained-comparison refinement degradation
  (SYNTAX's own canonical `-1.0 <= self <= 1.0` parsed ill-sorted and
  silently pended — SYNTAX trued to the `&&` form at three sites, the
  loud rejection arriving with predicate-is-expr), the `<expr>` operand
  render in E_RefinementRejected's message, and the `??)`-span slop in
  the address projection. CLEAN m2 == m3 expected (a compiler-internal
  perf change; the march arbitrates).
- 2026-07-24 · THE SCOREBOARD THAT NEVER FIRED, FIRED (the completion
  campaign's opening move — instruments before arcs; no re-pin, tools
  only). march-gate --micros read a `micro:` registry that was EMPTY for
  all 85 revisions of verify-baseline.txt — a gate that could not fail,
  gating nothing since birth (the 8458415b note's "since the backtick
  sweep" attribution refuted by the git census). The tier now enumerates
  tests/micros/mn-*.mn and reads each micro's OWN `// expect:` first-line
  oracle — the one home verify.sh already reads; the registry doc is
  deleted. Every verdict now stamps the sha of the m2 it judges: the
  first firing ran a stale prior-pin probe and reported the pre-fix
  20-not-25 — exactly the forensic one-binary law — and the stamp makes
  that class self-identifying. Against the true m2 (sha == boot ==
  8891428f, the fixpoint literal): 114/114.
- 2026-07-24 · ▶▶▶ THE FANOUT SPAWNS FOR REAL — the task record lands
  whole and `>< ~> parallel_compose` runs branches on host threads over
  ONE shared image (band E's real-spawn claim made true; the
  runner-migration peer's banked RED dies · pin 8891428f). THE ROOT was
  never four bugs: the spawn crossing had no unit of state — spawn
  banked the host thread id while join dereferenced it as a record, the
  entry wrote completion/result words past the closure's allocation, the
  start argument was a sentinel zero, and a spawned instance re-read a
  fresh zeroed image. The TASK RECORD answers all of it at once:
  [task closure@0][completion@4][result@8], allocated per spawn through
  the ONE allocator ($spawn_task_impl — loud refusal on a host spawn
  failure; no static slot region, no capacity ceiling, no tid ledger),
  banked whole in ThreadHandle, joined by $join_task_impl's atomic wait.
  The rewritten $wasi_thread_start stamps per-instance identity
  ($tid_g — current_id's truth source; a per-instance global IS
  instance-local storage), runs $__init_lets when lets exist (globals
  are per-instance; the copies land in fresh shared-cell records), and
  invokes the task through the closure protocol. TWO OWNERSHIP READS AT
  THE MODULE-IMAGE ALTITUDE, both from the program's own proof
  (spawn_task ∈ the fifth projection): a spawning module IMPORTS the
  shared image (the wasi-threads convention, re-exported for the p1
  ABI — a defined memory is per-instance, so a child of a defining
  module reads a fresh zeroed image) and allocates through the shared
  CELL at address 64 (compare-exchange bump; root _start initializes it
  once); a thread-free module keeps its self-contained defined memory,
  plain bump, and ships NO thread-spawn import at all — the
  must-satisfy-thread-spawn instantiation constraint the recon named is
  DISSOLVED for every non-spawning program, boot included.
  heap_mark/heap_reset went strategy-invariant at the call site
  ($heap_mark_impl beside $alloc; the reset writes the line where the
  strategy keeps it). THE DELETIONS: threading.mn 355 → 160 lines — the
  whole ffi/sentinel/intrinsic block, closure_pointer, the
  done-past-the-captures address arithmetic, the write-only threads
  ledger (the resume_kinds pattern at the schedule layer), num_cores
  (preview1 exposes no processor count — an op with no truth source is
  a fabrication; the spawn degree is the fanout's own branch count),
  and the wasi_threads handler whole (its spawn arm was bypassed by the
  direct route since Stage 4a); the dormant emit_memory_atomic_cas
  handler (byte-identical to bump — the strategy fork was never in the
  emitter) died into the emit_memory_decl body fork. The wheel's own
  dispatch chain dropped its dead schedule installs: a standing
  parallel_compose install would put the spawn arm's performs into the
  wheel's emitted tree and flip the wheel itself to the shared-image
  shape for parallelism it never performs (zero `><` in the wheel) — a
  schedule installs lexically at the fanout it schedules (SYNTAX §`><`:
  no Schedule → Seq). TWO LATENT SURFACE BUGS fixed by the same audit:
  WaitResult's decl order now matches the wait32 ABI (nullary ctor =
  tag word = the instruction's result; the old order silently swapped
  not-equal and timed-out), and atomic_rmw gained its real dispatch
  ($atomic_rmw_impl br_table on the RmwOp tag; its old emit was a
  dangling call) with two-operand cmpxchg split into its own honest op
  (the one-operand rmw shape cannot carry expected+replacement).
  GATES seen RED on the prior pin (exit 134, unaligned atomic in the
  join, identically through both engines): frontier real-spawn (60 —
  the sequential twin's exact answer, the §`><` thesis gate: one
  source, two schedules, identical results) · real-spawn-float (60 —
  a spawned instance's f64 carrier allocated through the shared cell
  and read by the joiner: the cross-instance allocation story proven)
  · real-spawn-identity (60 — both branches read positive stamped
  ids). Board whole at the pin: TRANSITION m3 == m4 at 329,774 lines
  (the 36-line m2/m3 diff is the emit change crossing one generation),
  then CLEAN m2 == m3; census 0; comment-refs 0; frontier 241/0;
  proof-exactness 9/9; crown 5/5; battery green through both engines'
  smokes. The named remainder of the runner-migration peer is now ONLY
  the host-path endgame (swap wt-env to the runner, retire the CLI
  pin) — no wheel-side glue remains.
- 2026-07-24 · ▶▶ THE COMMIT'S RECORD RIDES THE __k RAILS — the last
  bracket-maintained cache dies (Hβ.emit.arm-closure-captures-record
  RESOLVED, and the OneShot cousin the pre-build probe surfaced dies
  with it · pin bb4b870e). LStateSlotStore's fourth field is the
  resolved record READ, minted at lower through the __hrec ladder: a
  stateful arm binds `__hrec` as an LLet alias of its own $__state (the
  install record the driver passed; ls_bind_local before body lowering
  so nested mints resolve it), a lambda captures it (lower_seed_hrec —
  lower_seed_k's exact walk-free shape, transitive by induction), and a
  resume-bound fn takes it as the SECOND trailing param after __k (both
  call-site forks append the pair; dead-word 0 where no record is in
  scope — a commit on a dead path stores just before its paired
  k-call's dead-word trap, so the path still dies loudly at the
  resume). With every commit path through the ONE ladder, the
  $<hname>_state_g singleton globals, the install bracket's
  save/set/restore triple, the _prev locals, and the singleton_hnames
  walk family are DELETED — emitted artifacts carry ZERO _state_g, and
  anonymous/named installs are one shape at the install site. THE PROBE
  PAID FIRST: measured on the prior pin BEFORE building, a OneShot
  resume-with-state inside a thunk LOST its commit into the thunk's
  closure record (20-not-25, zero diagnostics; the classifier descends
  lambdas, so the shape is reachable) — the 32-not-46 disease at the
  other discipline, and the uniform ladder kills both (micro
  mn-oneshot-lambda-commit, RED 20 on the prior pin, 25 here). The
  medium caught its builder twice en route — census 0 → 1 → 0 (the
  bind's if-arms Int-vs-(); the arms unify) and drift mode 15 on an
  underscore binder (the residue form is the bare effect-statement) —
  and the comment-refs ratchet surfaced an ACCIDENT-invariant (forensic
  law 5): five backticked prev references had resolved only against the
  doomed _prev bracket locals; unbackticked to prose, ratchet back to
  0. Board whole at the pin: TRANSITION m3 == m4 at 329,794 lines (the
  2,018-line m2/m3 diff is the emit change crossing one generation; the
  new wheel SMALLER than its old-emit form), then CLEAN m2 == m3 with
  the prose fixes; census 0; comment-refs 0; frontier 232/0;
  proof-exactness 9/9; crown 5/5; the commit-class micros 25/46/46/51.
- 2026-07-24 · ▶▶▶ THE SINGLETON TIER READS THE WORLD — R4 completes at
  the last dispatch tier, and A4 un-floors on top (the banked RED pair
  goes green · pin 8458415b). THE ARC: the A4 un-flooring (installs
  TRANSPARENT to the k2 terminus flag; body_has_foreign_yield deleted —
  the frozen world CARRIES what the foreign clause re-derived) took
  mn-world-resume-frozen from its banked 134 to a NEW measured red, 30 —
  the crossing composed but the remainder's emitt read ZERO: the
  singleton tier's direct call read $scaler_state_g, and main's bracket
  had already restored it before the redrive ran the resumes. The k
  record's frozen world (R4's rebind, correctly set by LResumeK) was
  never consulted — the singleton state global is a CACHE of the
  chain-top entry, and every $world_g REBIND (LResumeK, __k_compose)
  invalidates it, not just lexically in remainders but through every fn
  a resume's dynamic extent calls. THE FIX AT THE REPRESENTATION: the
  perform reads the chain. singleton_perform_block's record source is
  LWorldResolve(handle, hname) — a new LowIR leaf emitting
  (call $world_find (i32.const <interned hname>)) — and $world_find
  walks the live chain. THE KEY IS THE HANDLER, NOT THE ENAME (the
  frontier caught the first form red-handed: the LSP serve leg's
  postmortem trapped inside op_mentl_voice_default_focus — the
  ename-keyed find returned the SPLIT-EFFECT pair's chain-top,
  mentl_voice_filesystem's record, to mentl_voice_default's arm; two
  handlers covering one effect's disjoint op sets is exactly what the
  per-hname global was precise about, because the op→handler edge is
  per-OP). The chain node widens to [key@0][entry@4][parent@8][iw@12]
  [hkey@16] — the ename key stays the evidence tier's walk
  (ev_perform_node untouched, persist's fingerprint walk untouched),
  the interned handler name is the singleton find's key, 0 for
  anonymous installs. With it: handler_stateful counts CONFIG params
  (scaler's arm reads the record for f — the config-only guard skip is
  WHY the 30 was silent; the compile gate's refusal conjunct tightens
  in lockstep, one shared fn), the redrive driver uses its own __state
  (both callers always passed the record — the global re-read was a
  re-derivation of a value in hand), emit_singleton_globals shrinks to
  installed-only (the no-config-declared union existed to make the
  dead global.get assemble; noconfig_handler_names deleted), and the
  ten LowExpr walks gained their LWorldResolve leaf arms — named by
  the medium's own census (E_PatternInexhaustive ×10, the exact
  sites), not by hand audit. The $<hname>_state_g global survives with
  ONE reader: the resume-commit store's closure home (arm commits run
  inside their install's live bracket — sound); its retirement is the
  named peer Hβ.emit.arm-closure-captures-record. MEASURED, the whole
  board: TRANSITION m3 == m4 at 331,648 lines (the 17,331-line m2/m3
  diff is the chain read + node widening crossing one generation;
  2,380 lines smaller than the prior wheel), census 0, comment-refs 0,
  frontier 232/0 (mn-world-resume-frozen GRADUATED as a leg — 134 on
  the pre-A4 boot, 30 under the cache read, 42 through the chain; the
  lsp serve leg RED under the ename key, healed by the hname key),
  proof-exactness 9/9, crown 5/5. Scaffold gap noted en route:
  march-gate --micros enumerated an empty promoted tier (CLOSED
  2026-07-24, the scoreboard entry above — the git census refuted this
  note's own "since the backtick sweep" attribution: the registry was
  empty for all 85 revisions of its life).
- 2026-07-24 · THE KEYED SCAN'S LAST CORPSE LEAVES THE SOURCE (the
  foundation cut's second write-side cleanup · pin 9bfcf506):
  ev_lookup/ev_scan — kept one generation for the prior boot's emitted
  LEvRef sites — deleted exactly as their own comment scheduled (zero
  references in the emitted artifact; reach had pruned them), and
  pipeline.mn's grounding comment trued from the dead call-boundary
  evidence-threading justification to the live one (the
  stateful-default zero-state read the SingletonUninstalled guard
  refuses). CLEAN m2 == m3; census 0; comment-refs 0. The keyed-ev
  region's write side is now EMPTY of source.
- 2026-07-24 · ▶▶▶▶ THE EVIDENCE REGION DIES WHOLE + THE FORK KEEPS ITS
  SPINES (the world arc's foundation cut, rung two, landed WITH the
  latent fork-pair root its one red surfaced · pin 612b6589): the
  keyed-ev machinery deleted end to end — LSuspend
  collapses into bare calls (every call direct or closure-conv, the
  evidence fork gone), LFnRef/LEvRef/LEvEntry/LUnresolvedEvidence deleted
  with every walker arm, closures are [fn_ptr][nc][captures] (no region,
  no sentinel), the handler record loses captured_evs, and the k record is
  [fn_ptr][nc][captures][state_idx][ret_slot][WORLD] — the LAST word the
  LIVE $world_g at reify (the static world_tag fingerprint died with
  world_tag_of_row), read by $__k_world at fixed offset 16+4*nc. R4's
  rebind is REAL: LResumeK (the resume invocation's own node) brackets the
  k call in the record's frozen world; $__k_extend stores the inner k's
  world; $__k_compose re-sets at the fk transition. The __resume channel
  is an ARGUMENT: resume-bound fns gain a trailing __k param (the
  resume_bindings closure), call sites append it unconditionally-if-bound
  (resume_k_arg — dead-k word 0 where no k is in scope), and closure
  mints SEED __k whenever a k is lexically in scope (lower_seed_k — the
  walk-free stateless rule after the synth-walk guard refused the
  stateful ls read). The k2 call-boundary wrap migrated from LSuspend to
  LCall/LDirectCall (same can_yield predicate; the __kr_ junction park
  restored after the double-wrap measured 134 on four k-micros). persist
  rewrote whole: signatures drop the caller-passed tags, the wire carries
  a name-level chain fingerprint derived from the record's own world
  slot, rehydrate refuses divergence and patches an equivalent world
  live. ev_lookup/ev_scan stay in source ONE generation (boot's emitted
  LEvRef sites — the ev_perform_entry precedent; delete at the next
  pin). THE ONE RED became the dig, and the dig closed a LATENT class
  as old as the fork pair: capability-hole's edit ACCEPT step trapped
  134 in the re-infer, and TEN labels died to probes before the root
  (count the kills): the yield-flag leak; the real-LYield theory; the
  patched-scratch-file theory; the k2-floor theory (the new wheel
  contains ZERO raise instructions — instruction-form count,
  string-literal contamination excluded — so no floor guard can ever
  pass, and the 5,259 dormant k2 wraps are can_yield over-approximating
  a module that cannot raise: the raise-site absence proof deletes
  them, banked below); the E_DuplicateFnName anomaly (pre-existing
  session-weave noise, 311 in GREEN legs too); the virgin-globals read;
  the nullary-ctor-sentinel decode of the row slot; and finally this
  entry's own banked "a TCont's WORLD field written wrong" — REFUTED:
  no writer existed, the record itself was alien. THE MEDIUM NARRATED
  ITS OWN DEATH (Morgan's redirect, feedback-medium-diagnoses-itself —
  stop hand-probing; make the medium speak): emit_match_arms'
  exhaustive fallthrough became the in-scratch POSTMORTEM — scratch
  word 0 = the failing cascade's own scrutinee ($scrut_tmp, exact by
  construction since nested matches re-set it), word 4 = the match
  node's graph handle baked as a code constant
  (Hβ.emit.trap-as-exception-postmortem's larval form; every
  ill-sorted destructure in every future build self-identifies) — and
  the crash-branch probe called the wheel's OWN projections instead of
  raw-offset decoding: lookup_ty through $lookup_ty_graph_state_g into
  show_type, graph_chase's reason into show_reason. The narration:
  finalize_continuation_boundaries' fatal slot was boundaries[23]
  holding a pointer to the interned ": " — a data-section len-2 string
  whose [len=2][tag=16] words tag-collide with
  PendingContinuationBoundary — and the three implicated "handles"
  were that string's own internals; two rounds of hand-decoding had
  misread the same bytes as a nullary-ctor sentinel. THE ROOT, latent
  since the fork pair landed (2026-07-23): graph_push_checkpoint
  recorded only trail_len, so a state spine GROWN during a candidate
  fork (extend_to's doubling copy) had no inverse — graph_rollback
  restored slots into the region-doomed spine, heap_reset zeroed it,
  the propose fan's renderer reused the memory, and check #2's
  finalize walked the alien word into occurs_in_row's destructure
  (deterministic per binary, vanishing under probe allocations — the
  forensic-law fingerprint, measured across three lineages; the cut's
  41%-smaller layout merely moved which constant landed there). THE
  FIX AT THE REPRESENTATION: the checkpoint is the fork's STATE
  VALUE — graph_push_checkpoint snapshots the seventeen grow-able /
  co-varying state fields as one record (pre-mark, O(1));
  graph_rollback walks the CURRENT trail backward INTO the snapshot's
  spines (revert_trail_into over undo_set_within — bounded, never
  extends; backward order makes the oldest old-value win per slot, so
  every in-place case lands pre-fork, and a slot alive only in a
  discarded grown spine is skipped) then restores every field
  wholesale; the unpaired-rollback arm keeps the legacy walk. The
  trail's own comment claimed "each mutation has a precise inverse" —
  spine growth was the mutation with no entry. The fix's own first
  two shapes were then REFUTED by the frontier (the gate catching the
  fixer, twice): restoring HALF the overlay family desynced the
  parallel quartet (count > restored bufs — propose-fan OOB'd in
  overlays_to_pairs; the whole names/bufs/lens/count/current family
  now forks together), and the pop's slice(stack, 0, n-1) MINTED ITS
  SLICE NODE IN THE DYING REGION — the next fork walked a zeroed cell
  (the doomed-allocation class recursing through its own cure); the
  pop is drop_last, the snoc-parent READ, allocation-free. The repro
  now runs the FULL edit loop green (fan → accept → patch → re-infer,
  rc 0, the Why facet reading the patched line). MEASURED, the whole
  board: the march ran TRANSITION m3 == m4 at 333,992 lines (pin
  4900d2c7 — the 1,932-line m2/m3 diff was the postmortem emit
  crossing one generation) then CLEAN m2 == m3 at 334,028 lines with
  the overlay/pop completions (pin 612b6589, blessed) — the wheel 40%
  smaller than the pre-cut 559k; census 0 at every generation;
  comment-refs 0; battery 113/113; frontier 229/0 (capability-hole,
  the field leg, and the fan leg all green); proof-exactness 9/9;
  crown 5/5. Peer born of the fix's own build:
  Hβ.infer.nested-alternative-branch-bracketing (named-residue
  index — the medium refused two correct shapes of the walker before
  the undo_set_within hoist). Banked structural findings, unchanged:
  the 5,259 dormant k2 floors (delete via raise-site absence proof)
  and the resume_k_arg dead-k word wanting its
  SingletonUninstalled-style guard.
  mn-world-resume-frozen (tests/frontier, UNREGISTERED) is the arc's
  banked RED pair (134 today — the driverless-install crossing floors
  before the world even matters; the A4 un-flooring is the next rung
  with it as the gate). Fixture lathe-lag measured en route: an
  ANNOTATED handler config param (`scaler(f: Int)`) does not parse.
- 2026-07-23 · THE PERFORM SCAN'S CORPSE LEAVES THE SOURCE (the world
  arc's write-side cleanup, rung one · pin 9448692b): ev_perform_entry
  deleted with its reach seed — the fn its own comment scheduled for
  this rung, zero callers since the R2 pin crossed — and all nine
  prose sites trued to ev_perform_node or reworded off the dead
  symbol. CLEAN m2 == m3 at 577,727 lines (reach had already pruned
  it; the deletion removes source only); board whole at the pin.
  Rung two is the foundation cut the census forced: the keyed-ev
  region dies WHOLE (effect entries write-only since R2; LSuspend's
  evidence fork collapses to bare calls), the __resume channel becomes
  a real trailing argument on resume-bound fns (the "argument, not
  evidence" ruling executed), and the k record freezes the LIVE world
  handle (the static world_tag fingerprint dies) with resume rebinding
  through it — R4's semantics at the representation layer.
- 2026-07-23 · ▶▶▶ THE FORMATTER SPEAKS — render totality + `mentl fmt`
  (the formatter arc's first landing · pin 013e26bd): the 18 missing
  arms land (Expr 25/25, Stmt 9/9, Pat 8/8; the surrender-fallbacks
  deleted into enumeration), and first light on the dormant module
  killed four latent bugs — the reversed joiners (every list rendered
  backwards, unseen at zero callers), the `{{`-is-not-an-escape class
  (22 sites to SYNTAX's \{), unescaped string content
  (format∘parse-identity made true), and the op/fn name collision at
  the direct-call tier (graph_node_at — the class named
  Hβ.emit.op-fn-name-collision-direct-call). Precedence-INVERSE
  parenthesization under the one table; the gate is BEHAVIORAL (42
  before and after — typechecking cannot tell (a+b)*c from a+b*c),
  plus byte-exact idempotence and prose/annotation carry: three
  frontier legs, RED on the pre-verb boot. The comment weave renders
  back (trailing→leading is movement not loss, stable from pass two);
  authored annotations survive with fields in the parse's own
  alphabetical canon; assemble_render carries String intent boundaries
  (the fan's elements arrive free — the §9 law's sibling). Named
  refinements: sugar preservation (destructuring lets re-render as
  their desugared match — the graph's truth), the width-aware layout
  engine, and the summit: the wheel formatting ITSELF (the 760
  E_RedundantBraces die there). The trecordopen-wrong-field class
  gained its lambda-shaped repro en route (a lambda param's field read
  on a plain record — annotated-closed dodges). Board whole: CLEAN
  m2 == m3 at 577,765 lines, census 0, comment-refs 0, frontier 229/0,
  battery 113/113.
- 2026-07-23 · ▶▶▶ THE RATCHET RUNS — 77 medium-authored tightenings,
  19 corrected by the canonical judge (tighten goes batch · pin
  b0204323): every authorable T_OverDeclared applies per run (per file
  bottom-up; monotone-safe by the wider-declaration argument);
  iteration 1 authored 75, iteration 2 authored 2; the blob's
  canonical judgment then REFUTED 19 DAG-computed rows (the
  order-conditional class measured live at scale — the tighten loop is
  now Hβ.infer.order-independent-verdicts' sharpest consumer), and
  each was trued to the judge's own found-row, converging 19 → 13 → 0
  with the emitted wheel BYTE-IDENTICAL throughout (pure inference
  truth, zero emit drift). Residue: 15 multi-line decl heads the
  single-line patcher refuses (never mangle). The wheel's declared
  rows are now at the canonical judgment's fixpoint for every
  single-line head. Board whole: CLEAN m2 == m3 at 563,042 lines,
  census 0, comment-refs 0, frontier 226/0, battery 113/113.
- 2026-07-23 · ▶▶▶▶ THE MEDIUM AUTHORS ITS FIRST CHANGE (`mentl
  tighten`; the self-build audit's step 1 executed whole · pin
  ab8daa07): T_OverDeclared was always a MachineApplicable proposal
  carrying the proven row — the tighten verb turns the first authorable
  one (closed tail) into the patch. The tighten_collector is the
  COLLECTING FORWARDER over Diag: every diagnostic re-performs outward
  from the arm — the world arc's deep-handler law in production the
  night it landed — and all three Diag ops carry arms (a partial-effect
  handler leaves zero fn slots; a perform through one is a garbage
  dispatch — the constraint, named at the handler). Run on the wheel's
  own DAG, the medium authored spec_is_agg (src/backends/wasm.mn:223)
  `with Memory` → `with Pure`; the fixpoint held CLEAN through the
  self-authored diff and the human's role reduced to gates + commit —
  §0's convergence (docs : Claude :: language : developer :: human :
  mentl audit) at its first executable instance. Three frontier legs
  seen RED on the pre-verb boot (author / fresh-check / fixpoint).
  NAMED FOLLOW-UP (Morgan's cut at the suppress marker): the
  drift-audit's mode-33 exclusion is a ROW fact a grep cannot read —
  the scaffold takes per-line ignore markers where the medium reads
  the row; the absorption (an infer-side let-where-pipe class gated on
  the callee's row, pure-only, plus the string-literal blindness) is
  the comment-refs precedent applied to the drift audit, and the whole
  ignore-marker family dies with it (Hβ.audit.drift-modes-read-the-row).
  Board whole: CLEAN m2 == m3 at 561,214 lines, census 0, comment-refs
  0, frontier 226/0, battery 113/113.
- 2026-07-23 · THE ANNOTATION VERIFIER PROVES
  (Hβ.mentl.verify-after-apply-boundness-only RESOLVED — the self-build
  audit's gap 2 · pin fadbbee7): apply_annotation_tentatively returns
  the PROOF — row_subsumes(body row read live from base_ty, narrowing),
  the finalize gate's own engine — and boundness demotes to the
  structural belt. Seen RED live: an allocating main was offered
  "!Alloc ... proven zero allocation"; fixed, it loses the false claim
  and gains the TRUE !IO severance, the pure control keeps !Alloc.
  Frontier legs mn-teach-alloc-honest + mn-teach-pure-control (judging
  main's own line — teach projects every fn in the blob). This clears
  the soundness gap standing on the self-authorship path (the audit's
  step 1a); the tighten driver is step 1b. Board: CLEAN m2 == m3 at
  559,311 lines, census 0, comment-refs 0, frontier 223/0, battery
  113/113.
- 2026-07-23 · ▶▶ THE BRACKET LANDS — R5, the world arc's first
  wheel-internal consumer (Hβ.cli.infer-context-bracket RESOLVED · pin
  2644dab5): the analysis core installs as ONE fn — infer_context
  (pipeline.mn) brackets the body thunk in the eight-handler core in
  the settled order; all 14 inference-reaching chains route through
  it; the per-chain parallel/threads re-installs die (dispatch's
  boundary installs them once); the wheel shrinks 2,168 lines. The
  EXACT form refuted twenty-four hours earlier by the mint-time
  evidence snapshot, now sound because a computation performs in the
  world where it is CALLED — the refuting smoke re-run all green (at
  projects, compile - emits, check refuses broken input). A future
  verb structurally cannot mis-order or forget the core. Board whole:
  CLEAN m2 == m3 at 558,997 lines, census 0, comment-refs 0, frontier
  221/0, battery 113/113. The arc's remaining rungs: the write-side
  cleanup (ev_perform_entry + the captured_evs perform role, zero
  callers), R4 (the k record freezes the world; band B's value gate),
  R6 (the fork pair's world leg in synth/oracle).
- 2026-07-23 · ▶▶▶ THE PERFORM READS THE WORLD — R2+R3 land together
  (evidence dispatch goes dynamic; deep-handler law by construction ·
  pin e8bcfb14): every evidence-tier perform resolves through the LIVE
  install chain — ev_perform_node walks [key][entry][parent]
  [install_world] nodes from the world top (passed inline as
  (global.get $world_g): the wheel source performs no world_top op,
  the CROSSING CONSTRAINT — the prior pin's gate judges the source
  with the prior recognition set, so a new substrate op must arrive
  declared-but-unperformed; E_EffectUnhandled caught both wrong forms
  before any binary ran, first the Alloc-declared world_top flooring
  the root, then the performed form itself), resolves ONCE into a
  per-site local (the old arm re-scanned the frame region four times
  per perform), and the ARM CALL alone brackets in the node's
  install_world — an arm's own performs resolve OUTER, never self;
  args evaluate at the perform site; tail-resumptive resume-as-return
  continues under the perform-site world by construction. THE THREE
  GATES FLIPPED AND GRADUATED (tests/frontier/mn-world-*, RTLIBS
  legs): thunk 134 → 42 (a thunk performs where CALLED, not where
  minted — the class that refuted the queue-5 bracket), arm-config
  2 → 40 (band N's Hβ.lower.config-fn-evidence-in-arm silent-wrong
  class DEAD), shadow control 40. ev_perform_entry stays in source
  solely for the prior pin's emitted sites (zero callers this
  generation; reach prunes it) — its deletion plus the write-only
  forward machinery (derive_ev_slots effect entries, the captured_evs
  regions' perform role) is the named write-side cleanup rung; then
  R4 (the k record freezes the world; the band-B value gate) and R5
  (the 14-chain bracket consolidation re-run — now admissible). Board
  whole at the pin: TRANSITION m3 == m4 at 561,165 lines (the
  32,564-line m2/m3 diff is the dispatch crossing one generation),
  census 0, comment-refs 0, frontier 221/0, battery 113/113.
- 2026-07-23 · ▶ THE WORLD CHAIN — R1 of the world-as-value arc
  (writers only, the reader is R2 · pin 8156ee0c): every emitted
  install draws its runtime edge — $world_g + $world_push cons one
  [key][record][parent] node per absorbed effect group, save/restored
  around the install extent (world outermost of the two brackets; the
  save is unconditional, anonymous installs included — the invariant,
  not an optimization); install enames intern through visit_string so
  every world key resolves nonzero. The three repro-world fixtures
  hold their measured values through the new emit (134 / 2 / 40 — the
  chain is inert by construction until the perform swap reads it), and
  the m4 leg ran the wheel's entire self-compile under live world
  brackets. TRANSITION m3 == m4 at 561,069 lines (the 26,623-line
  m2/m3 diff is the bracket crossing one generation); census 0,
  comment-refs 0, frontier 212/0, battery 113/113. Next: R2, the
  perform swap whole — the evidence tier reads the chain, captured_evs
  op-dispatch dies, the __resume k-threading channel survives.
- 2026-07-23 · THE ANALYSIS-CORE ORDER LAW + doc's env completion
  (queue 5's honest yield; the consolidation itself refuted by
  measurement · pin 4b10e457): the infer-context audit enumerated all
  14 inference-reaching chains (not the ledger's seven), settled the
  install-order question at ONE home (pipeline.mn's spine — ledgers
  innermost; lookup_ty before env before graph before mutate_sink;
  diagnostics outer to graph, because graph_bind's occurs-check reports
  FROM the graph arm — probed live: at_run counts it, exit 1, via the
  unique-handler state global; the outer placement makes the count
  tier-independent), and completed doc_run's core with its missing
  env_handler (env ops resolved through dispatch's instance while its
  graph was chain-local — accident made contract). The BRACKET FN was
  BUILT WHOLE and REFUTED before commit (⟲ — the verifier's own theory
  died to the artifact): all 14 chains rewritten over a body thunk,
  wheel 1,568 lines smaller, census 0 — and the smoke split exactly
  singleton-vs-evidence: check/doc/teach/query/repl green (state-global
  ops are dynamic), compile and the at verb TRAPPED (executable_gate's
  verify_debt is multi-handler Verify; the cursor ops are ambiguous —
  both evidence-dispatched, and a closure's evidence snapshot predates
  the bracket's installs; the M3 lexical fence is the semantics, not a
  bug). Reverted whole; `Hβ.cli.infer-context-bracket` (named-residue
  index) banks the measurement, the DEP (dynamic evidence crossing vs
  the fence's replay guarantee), and the build order behind band B's
  world discriminator. Board whole at the pin: CLEAN m2 == m3 at
  559,460 lines, census 0, comment-refs 0, frontier 212/0, battery
  113/113.
- 2026-07-23 · THE WHEEL SERVES ITS OWN IDE — `mentl space` (queue 4;
  the serve scaffold's written dissolution executed · pin 61c10ab8):
  ide/serve.mn absorbed whole as src/main.mn's space arms (mime
  projection · one-read request · request-line path · route, with "/"
  and directories to index.html and ".." refusing · the isolation-pair
  respond · the tail accept loop, constant stack for the server's
  life); serve.mn + serve.sh + serve.wasm DELETED, every reference
  re-pointed (README, MENTL_EDIT, tutorials, §8, the runner design).
  The listener is the install shim's seam — WASI p1 has no
  bind/listen, so the host resource rides the same shim boundary as
  run's exec seam (--dir "$MENTL_HOME::." maps the repo at guest "."
  so the verb serves from ANY directory; -S tcplisten=127.0.0.1:7378,
  override MENTL_SPACE_PORT); without a listener the verb refuses and
  TEACHES the seam. Two frontier legs seen RED on the pre-verb boot:
  the refusal-teach, and the live serve asserting 200 + the
  cross-origin-isolation pair on ide/index.html; smoked end-to-end
  through the installed shim from /tmp. One observation banked with
  its one-line design: `mentl <unknown-verb>` prints the catalog and
  exits 0 — the refusal law at the CLI surface wants exit 1 when argv
  NAMED a verb (bare `mentl` stays the welcome projection at 0).
  Board whole at the pin: CLEAN m2 == m3 at 559,432 lines, census 0,
  comment-refs 0, frontier 212/0, battery 113/113.
- 2026-07-23 · gradient_queue DELETED WHOLE (queue 3 · pin 56f01996):
  the built-exposed-zero-callers GradientQueue block (effect + handler +
  its four private fns, 107 lines) dies; the peer resolves as DELETE;
  band E's work-stealing-via-gradient keeps the design. CLEAN m2 == m3
  at 558,531 lines; board whole.
- 2026-07-23 · THE COMMENT WEAVE AT THREE ALTITUDES (queue 2 — SYNTAX's
  "never dropped" made true for the measured gap · pin aa6338e9). A
  block-INTERIOR comment attaches to the finest FOLLOWING node (next
  statement / final expr / the block's unit node — by HANDLE, so the
  before-final-expr case never wraps the final as an ExprStmt), and a
  TRAILING same-line comment attaches BACKWARD to the node whose line
  it shares — same-line decided by TOKEN geometry (no TNewline between
  item and comment; the span test failed because a braceless let-chain
  leaves the position past consumed newlines — the str_contains doc
  attached to str_compare until the token test, caught by reading the
  Lede at the address). The address surface renders the attached
  prose's first line as the Lede facet through the one
  comment_first_line projection (a duplicate lede helper died to
  E_DuplicateFnName's own refusal — the armed class catching the
  session's hand again). Interior comments thereby joined the backtick
  gate, and the referent set grew its SCOPE face: each top-level decl
  contributes (extent, comment_locals), extents from consecutive stmt
  starts since decl spans are head-only, so interior backticks resolve
  against the enclosing fn's params and binders; the eight residual
  phantoms were the narration class, unbackticked per the contract.
  The affine ledger pairs a buffer move inside a destructure-desugared
  arm with sibling-leg moves (three clean small repros; the real fn
  refused), so the block loop is destructure-free — helpers own the
  collects. Gates: lede-demo (decl + interior + trailing all render,
  RED as zero Lede lines on the prior pin); the ratchet itself (0 → 23
  → 0 as the new judge saw interior prose and the heal closed it).
  Board whole: CLEAN m2 == m3 at 558,532 lines, census 0,
  comment-refs 0, frontier 210/0, battery 113/113. Expression-interior
  positions (parens / arg lists / match-arm headers) stay layout — the
  named refinement Hβ.parser.expr-interior-comment-attach (SYNTAX
  carries it).
- 2026-07-23 · ▶▶ THE BLOB DECLARES CALLEE-FIRST + THE SUBSTRATE FACE
  TABLE + THE N-CURSOR FIELD (queue 0b landed with the order truth it
  forced · pin 6807a214). The dig: `mentl two.mn:0` rendered every
  position as one ghost var — the ranked (Float, Int) tier read ph at
  the word-floor offset 4 while construction stored wide; no twin
  minted because the demand walk's pairs resolved to FREE vars; the
  Why probe named the fresh instantiation; the bare-scheme census then
  measured the true shape: 492 wheel fns published fully-bare schemes
  — the src-first blob made every src→lib call a FORWARD reference
  reading the loose pre-registered snapshot (the order-conditional
  class at its true size; the RTLIBS repros all passed because
  fixtures sit AFTER the libs). THE FLIP: the canonical wheel input is
  lib-before-src (wt_wheel lib src; march.sh matches) — callee-first
  at module scale, the same cure prelude's iterate order applies
  in-file. Bare schemes halve to 256 (intra-src residual, the named
  order peer); field_ranked resolves whole; three tier twins mint
  worthy. The sharper order re-judged the wheel — 57 diagnostics
  trued: 33 declared rows widened to their bodies' truth (+Alloc
  mostly; ic_compile_loop's IC-era row dropped — the body runs the
  compile spine), the escaping family's two op declarations now speak
  the string name-sets the family always carried (a first [EffName]
  guess and a double-conversion detour both died to the artifact; the
  probe's reason chain named the decl), expr_child_handles reads
  {name, init} records by the init edge (MakeRecordExpr AND ResumeExpr
  passed the record itself to node_handle), render_propose_arm's
  guarded unwrap became the match (Pure holds), and the zero-caller
  cursor_session_batch + CursorSessionResult deleted whole. THE FACE
  TABLE: seq_op_sig is ONE home both substrate paths derive from —
  infer_seq_op forces each argument position against it (the per-arm
  force boilerplate deleted), and a HOLED/under-applied seq-op call
  builds its product-with-holes from the SAME face, never from the raw
  body's env scheme (list_set's `l + 8` types l Int; the partial
  minted from it unified every pipe datum with Int the moment the
  order made the scheme visible). The wheel's 14 `|> list_set(??, …)`
  pipes rewrote saturated (clean under both judges); the class is
  gated RED-first (mn-seq-op-holed-pipe: 4 errors on the prior boot,
  72 through the face). THE FIELD (0b): `mentl <file>:0` projects the
  whole absence field — every authored hole ranked first, each
  rendered through the same cursor_at_handle + render_at path the
  single-address form uses (a hole's line carries its Propose fan,
  ties teaching), the annotation-gradient tier after; sequential, the
  `><` swap honestly gated on the runner migration. Gate: the
  propose-fan-demo field leg (RED as "lines count from 1" on the prior
  pin). Board whole at the pin: TRANSITION m3 == m4 at 557,233 lines,
  census 0 at every generation, comment-refs 0, frontier 209/0,
  battery 113/113.
- 2026-07-23 · ▶▶▶ THE INSTANCE CROSSES THE FN BOUNDARY — subst_row's
  dropped closed-tail merge, the trio law completed over bound tails,
  and the install-frame fragment join (the fold-family dig's root,
  twelve iterations and twenty killed labels, landed whole · pin
  cad3ca53). THE ROOT: subst_row's EtVar arm merged a bound row's
  names only when the inner tail was itself EtVar — a row var SOLVED
  to a CLOSED row (every declared-row fn) fell to the catch-all and
  returned the empty row, DISCARDING the bound row's whole present set
  at instantiation. Every caller of every declared-row fn has read a
  BARE row since the row machinery landed; no effect instance ever
  crossed a fn boundary; map's element died at the caller. The merge
  arm reads the binding live, freshening through the same mapping the
  params use, under the solved tail. THE TRIO LAW then completed it
  (the second half, pinned by the install probe): free_in_row and
  occurs_in_row now descend a BOUND tail exactly as subst_row
  traverses it — collection-without-descent left the tail's inner
  payload vars unquantified, so instantiate shared them RAW across
  every call site, map's install bound the shared answer var to [b],
  and every later HOF decl collided against it (the cross-decl
  Bool-vs-List wave; the probe read the stale [b] inside any's own
  fragment). With them: publish_with_instances (a declared-bare name
  keeps the body's parameterized instance at publish),
  inf_add_row_unified gated on the INSTALL frame (yield's and
  result's fragments are one instance inside a tee body and join by
  position before the name-set union can drop one; a caller's
  independent callee instances never join — the ungated form unified
  fold-over-[Int] with fold-over-[Float], the 286-error m3 wave),
  the effects.mn name-set bare→parameterized upgrade at the three
  dedup seams, prelude's callee-first iterate order, chase_deep root
  canonicalization with chase_row_deep over EAType payloads and TCont
  worlds, the compare-leaf f64 stash pair (the bare (f64.lt) select
  never assembled — every Float-field compare helper was born broken),
  and spec_pairs_walk chasing body-bound vars. THE TWO-PASS WALK built
  en route (iterations 10-11) was REVERTED by measurement: its second
  pass tips the 4GB image at the m3 emit (alloc-unreachable in the
  reach walk — the seq-op-row precedent verbatim); the verdict and the
  design are banked on Hβ.infer.order-independent-verdicts, DEP-gated
  on the arena. The sharper compiler immediately exposed one CANONIZED
  silent-wrong: micro mn-mapelem banked exit 1 — the old wheel floored
  map's unresolved record to offset 0 and read alpha where .beta=2 was
  meant — and one under-declared fixture row (stats fsum gains fold's
  true Alloc). Gates: mn-forward-wide-instantiation RED on the prior
  pin (a forward wide instantiation through a mono caller), bisect-r
  42, the trued micro at its real value. Board whole at the pin:
  TRANSITION m3 == m4 at 553,900 lines, census 0 at every generation,
  comment-refs 0, frontier 205/0, battery 113/113.
- 2026-07-23 · THE TUPLE PATTERN READS THE BRACKET (the pattern path's
  last lower-time layout bake dies · pin 80852432). LPTuple carries
  (elem_ty, sub_pat) — live element vars — and (offset, width) project
  at EMIT: pat_elem_repr resolves through lookup_ty (the bracket-aware
  channel construction and binop dispatch already read; the raw chase
  answered the floor and split a twin against its own construction),
  pat_tuple_off runs the identical align_for+repr_width prefix-sum, and
  a var-typed tuple destructure is itself a worthiness WITNESS
  (spec_oph_wide_pair's TTuple arm — a var element landing wide demands
  the twin; pointer instantiations keep word slots, minting nothing).
  Seen RED twice on the prior pin: the worthy twin's WAT did not
  assemble ($sc.f64 undefined local — the in-flight N-cursor code's
  (Float, Handle) ranked tuples were the first trigger), and the
  non-worthy floor read an f64's high word at baked offset 4 as the
  next element (invalid exit, zero diagnostics — probe-second). Gate
  mn-generic-wide-tuple-pattern: twin assembly + floor face +
  mixed-order (Int, Float, Int) alignment, 42. CLEAN m2 == m3 at
  550,965 lines (the witness mints zero twins on the wheel itself);
  frontier 202/0, battery 113/113, census 0. The two SIBLINGS stay
  named with their designs: record-field patterns
  (Hβ.emit.f64-aggregate-pattern-width — the carrier lacks fty; the fix
  is this landing's shape one arm over: carry the field ty, read
  pat_elem_repr, fold the offsets live) and generic CON payloads
  (Hβ.emit.spec-con-payload-instantiation — ctor_payload_tys_of reads
  the DECLARED scheme whose roots the bracket does not key; the fix
  resolves the payload tys through the site-instantiated ctor type at
  the match, the same spec_resolve read the twins' interior calls use).
- 2026-07-23 · ▶▶ THE FAN PROJECTS + THE FORK PAIR (the /loop's queue-0
  landing · pin 08640f17). A `??` tie LISTS the proven survivor space —
  each candidate rendered with its Reason, then the collapsing move
  (propose-fan-demo seen RED as the bare count line; the frontier leg
  asserts both Bit survivors project). Both candidate-verify loops
  (verify_each_enriched and enumerate_inhabitants' resume-per-proven
  fan) gain the FORK PAIR — graph checkpoint + heap region per
  candidate, memory and graph both restored at the fork boundary, O(1)
  each — the exploration substrate's honest isolation, and the arena's
  second real workload after the battery. The medium caught its own
  builder again within minutes (census 0 → 1 → 0: the fork pair's
  heap ops forced verify_each_enriched's declared row to its Alloc
  truth). The multi-shot arm's first wheel-internal consumer is the
  N-cursor pass, next in the queue.
- 2026-07-23 · ▶▶ THE MANIFEST TELLS THE TRUTH — every module's import
  list resolves its whole vocabulary, and the medium wrote its own
  worklist (the /loop's first landing · pin cab557e8). The probe form
  `mentl src/<m>.mn:1:1` turned each module's E_MissingVariable set into
  the exact edge list; four sweep rounds converged: nine primary moves
  to DAG-honest homes plus their sibling closures (the wasm-layer
  reach/spec/ctor helpers → lower; node_handle + parse_span_of → graph;
  why_expand → query; the flow-label trio → types — each was defined
  DOWNSTREAM of its users, the backward edges that made module entry
  fail), plain imports across fourteen modules, and main_param_count
  rewritten on lower's own decl walk. The rewrite's first flat form
  MISSED the LLet-closure named-fn shape (the wheel's own main) and
  dropped _start's argv — the march's transition arbitration refused
  the unassemblable m3 before any pin moved (the size-guard/arbitrate
  machinery paying for itself again); the fix matches exactly
  reach_decl_name's shape set. The comment-truth sweep rode the same
  ladder: T2–T7 trued (deleted-seed mirrors, six→eight fields, dead
  item-11.B pointers → the live name-is-handle peer, the stale
  voice.mn:9 example → a projecting address, era-narration → mechanism
  prose), and SYNTAX corrected its two false claims — the retired third
  projection, and the comment-attachment gap MEASURED and named with
  its build (interior/trailing comments are today consumed as layout;
  the finest-following-node attachment is the named upgrade). Board
  whole at the pin: m2 == m3 at 549,887 lines, census 0, comment-refs
  0, frontier 198/0, battery 113/113. The de-theme landed separately
  (ffe271eb — system fonts, neutral palette, no mascot, no octagon
  motifs; function untouched, twin green).
- 2026-07-23 · ▶▶▶ THE DIRECT-CALL CASH-OUT — every named call goes
  native; the word-face wrapper's tail-leak dies; the signal crucible
  goes green (the dispatch gradient's own endpoint, landed whole ·
  pin f8abad90). THE DIG (the cfc-researcher's blocker, four labels
  killed by the artifact): its table-layout theory REFUTED (the
  three-way check — elem position == idx global == baked closure index,
  perfect at every probed fn); my alloc-trap a HARNESS ARTIFACT (the
  unmounted recording file — len(garbage)); the n-guards proved the
  series terminates; the TRUE root read from the frames: THE WORD-FACE
  WRAPPER BREAKS TAIL CALLS — a tail recursion's return_call_indirect
  lands IN the wf$ wrapper, whose body-call was plain, leaking ONE
  frame per iteration; at 4096 samples the stack tips with the innocent
  atan ladder on top (the researcher's threshold was never fn-count —
  it was recursion depth through any wrapper). THE FIX AT THE ROOT,
  never the symptom: LDirectCall — a callee lower proved a top-level
  FnScheme (the LGlobal-from-FnScheme mint; locals shadowed first,
  value bindings keep the closure path) emits `call $name` /
  `return_call $name` with NATIVE widths. Three artifact-taught
  corrections en route, each loud: fn schemes carry TParam PRODUCTS
  (param_ty unwraps — my first helper trapped repr_of on the product);
  arg widths follow the CALLEE'S DECLARED signature (word floor for
  generic/Int params — the seq-op raw bodies live there — native f64
  for declared Floats; six assembly refusals taught it); and a TWIN's
  widths read the SAME spec_site_pairs/spec_subst_pairs projection that
  minted the redirect (raw lookup_ty floored free vars against the
  twin's native slots — three assembly REDs). The pipe splice gained
  the node's arm (26 phantom E_UnresolvedHole = partial-application
  ??s surviving the `_` fallback — the m3 leg's own refusal caught it).
  Word-result wf$ wrappers tail-collapse as the belt. MEASURED: the
  wheel SHRANK 19,942 lines (−3.5%) and the wasm 5.3% — every named
  call in the language dropped closure-eval + spill + call_indirect for
  one direct call; the researcher's whole bracket runs (wf-1/5 = 42,
  wf-15's 4096-deep demod as true tails); signal-crucible TRANSPLANTED
  and GREEN (exit 42, cross-validated against the independent oracle —
  argmax flat 2, strong coupling; the STFT + `<~` bandpass + filter
  comodulogram lands as lib/dsp/signal.mn with tests/repro-wf banked).
  Board whole: frontier 198/0, battery 113/113, census 0, comment-refs
  0, m2 == m3 at 549,924 lines. Hβ.emit.float-evidence-ft's named class
  narrows to the genuine value-dispatch residue (lambdas/HOF through
  the table keep the word protocol — sound, just not yet fast).
- 2026-07-23 · ▶▶ THE SOCKET SPEAKS AT THE ADDRESS SURFACE (the Propose
  facet's first render + the resolver's column law · pin 17d1c3be).
  `mentl hole.mn:9:37` at an authored `??` now projects the socket's
  content: `Query: ?? : Positive · Propose: 1 · Why: declared choose` —
  the ONE proven survivor, rendered through the SAME
  render_candidate_source projection the edit transport's accept path
  applies, at the one-shot address read; a tie prints the survivor count
  + the teaching line (never a hidden first-wins pick — PLAN §5's
  tie-break law at this surface too). render_at stops discarding the
  CursorView's propose slot (the ide-visionary's seam report named it:
  the graph computed the proposal; the terminal threw it away). TWO
  structural fixes were forced by the artifact before the facet could be
  real: (1) THE COLUMN LAW — address_better_a picked the WIDEST
  containing node for BOTH address forms while its own comment promised
  "a column address narrows within it"; the code caught up to the
  comment (file:LINE keeps the line's root = widest; file:L:C picks the
  TIGHTEST containing node), and on IDENTICAL spans the LATEST mint wins
  — mint order builds constituents before composites, so the later node
  is the more derived reading (a `??` mints its id cell then the NHole
  over the same span; the address must reach the NHole, whose Propose
  facet speaks). (2) The sharper wheel then caught MY OWN first attempt
  at a ty_of_kind NHole arm as ill-sorted (E_TypeMismatch NodeKind vs
  NodeBody — census 0 → 1 on the m3 leg): NHole is a BODY constructor
  and can never appear as a chased cell state, so the arm was dead code
  with a sort error; DELETED (the census-as-ratchet catching the
  session's own hand within the hour — the medium keeping its builder
  honest, §0 live). Gate leg: tests/frontier/propose-demo +
  frontier-gate's cursor-address-propose assertion, seen RED on the
  pre-arm boot (the address printed no Propose line and resolved the id
  cell). The ide-visionary's proof-of-life landed in parallel (ide/
  only): the browser aspect ring reads the compiler's real eight-aspect
  CursorView over a virtual fs, RED→GREEN on provenance 'real', plus a
  genuine serve.mn catch (read_request hand-rolled the pre-merge +4
  String layout — latent OOB under the armed bounds check, fixed to
  bytes_buf/+8/str_of_buf; the wheel-side class census came back CLEAN —
  zero +4 payload writes, all 18 str_of_buf callers on the merge's
  migrated boundary — so serve.mn was the class's last instance); its
  batch commits when it reports against this pin. RETRACTION, same night (the ⟲ law on the orchestrator's own
  claim): commit dbf538ea's message says the fixpoint judged the
  rewritten tutorials because "the wheel blob includes lib/**" — FALSE;
  wt_wheel and march.sh both carry `-not -path '*/tutorial/*'`, so the
  tutorials are OUTSIDE the blob and the matching m2cache key proved
  nothing (an excluded file cannot change the key — the inference was
  consistent with its own negation). The tutorials' real verification
  is direct: each compiled through the pinned boot, assembled, run,
  output checked (re-derived by hand for 00/03/06/08 — greetings, 30,
  51, 9). The lesson is §9.6 verbatim: verify the formula, not the
  plausible reading of its output.
- 2026-07-23 · ▶▶ THE NULL-SINGLETON CLASS CLOSES + THE REGION BATTERY
  SHIPS (the cross-compile trap's root, proven adversarially and landed at
  every altitude · pin 6c192865). The forensic-prober (a fresh mind told
  to refute the thirteen-kill corpus) did exactly that: with the virgin
  reset on main the old infer-side death was GONE, and the real death sat
  at compile #14 entirely in EMIT — project_emit_state installed six
  visitor collectors but not effect_census_collector, so the shared walk's
  census op ran as a NULL-STATE SINGLETON: its accumulator lived at
  absolute address 12 (the null page — below every region mark, never
  reset, holding a stale pointer into the region), and the next compile
  walked the stale pointer as a list. THREE CLOSURES, one landing: (1) the
  wiring — every walk_lemit bracket installs every visitor family the walk
  fires (the row's dynamic-extent obligation, stated at the site); (2) the
  GUARD — singleton_perform_block refuses a STATEFUL singleton op call
  whose state global is 0 (SingletonUninstalled, the tier's evidence IS
  the global; the LDirectPerform node carries the stateful bit read once
  at the mint, and the LIf's condition is the record pointer's own
  truthiness — no comparison nodes, no operand-width hazard); stateless
  stays UNGUARDED by the same licence the compile gate's STATEFUL
  conjunct encodes (the arm ignores __state; null is sound by
  construction; byte-identical emission, Law 7) — the two altitudes
  cannot contradict on any program; (3) the REGION battery ships —
  battery_loop marks/resets per micro (113/113, ~192MB peak, the
  per-decl arena's first real workload, §5.O). The guard was seen RED
  live TWICE the hour it landed, each firing a real missing install: (1)
  the test verb's directory arm ran battery_run's fs/console ops bare
  (tolerated for months because the stateless arms read the null page
  benignly) — fixed by giving the match the chain its sibling always
  had; (2) the EDIT chain ran its whole inference without
  lookup_ty_graph, so every lookup_ty in a `??` authoring session read
  the NULL PAGE AS THE GRAPH — silently wrong inference in the felt
  loop's own flagship workflow, surfaced only because the guard refused
  it (16 frontier legs RED at unify_install_payload's lookup_ty). The
  second firing triggered the CENSUS the two-trap rule demands: SEVEN
  chains reach inference; serve_run/compile/battery/stdin carried the
  install, FIVE did not — edit_run, pipeline_check (whose own comment
  records the same class from the region sweep one landing ago),
  check_source, at_run, repl_run, and doc_run (missing affine_ledger
  and region_tracker too — its per-module inference ran every analysis
  op driverless). All five gain their installs in one sweep; the class
  now polices itself (any chain a future verb forgets traps loudly at
  the exact site instead of silently reading the null page). The
  residual drift-7 is NAMED with its design question: the analysis
  core (affine/region/verify/lookup_ty/env/graph) is one sub-chain
  hand-copied per verb with ORDER VARIANCE (env-before-graph is
  load-bearing; parallel_compose presence varies) — the order question
  is now SETTLED (the law at pipeline.mn's spine) and the bracket-fn
  form REFUTED by the evidence fence; `Hβ.cli.infer-context-bracket`
  (named-residue index) carries the measurement and the DEP-gated
  design. Fixture mn-singleton-preinstall-call banks the class
  (stateful op called before its install executes: compile gate admits —
  an install exists, grounding the whole-program conjunct — runtime guard
  refuses, exit 134; on the pre-guard wheel this ran SILENTLY WRONG,
  reading and writing state through the null page). Measured en route:
  an `_x` pattern binder emits byte-identical wat to `_` — the
  ignored-slot naming convention is free documentation. Five ladders,
  one landing: TRANSITION (guard bytes) → CLEAN (test-verb bracket) →
  TRANSITION (stateful-only refinement; wheel 95 lines SMALLER than the
  all-guarded form) → CLEAN (edit-chain install) → CLEAN (the
  seven-chain census sweep). The thirteen-kill corpus is superseded as diagnosis, kept as
  law (CLAUDE.md's forensic laws); Hβ.runtime.cross-compile-durable-state
  is CLOSED (named-residue index carries the resolution).
- 2026-07-23 · THE MARCH ABSORBS THE HAND LADDERS (the ladder's own
  alive-law audit, Morgan's challenge: "are you sure m2–m4 is the best
  practice, canonicalized, automated, future-proof?" · pin 229fda2f).
  The AUDIT'S VERDICT, banked: the LAW (self-application to a byte
  fixpoint + adversarial oracles, TRANSITION re-pinned from m3) is right
  and future-proof — it generalizes to native (native_m3==native_m4,
  NATIVE.md) and to parallel cursors (the deterministic handle
  partition exists for exactly this); the PRACTICE was scaffold with
  four measured gaps, three closed HERE: march.sh gains the SIZE-GUARD
  (two empty legs can no longer read as a fixpoint), MARCH_REPIN=1
  (CLEAN blesses m2, TRANSITION blesses m3 — the wrong-side cp a hand
  script made once is now impossible; PROVENANCE prose stays the
  session's, the pin unblessed until written), and the per-leg census
  echo. The canonical run also caught the hand ladders' container
  drift: they assembled without --debug-names; wt_asm's pin carries the
  name section (readable backtraces), the fixpoint wat byte-identical.
  THE REMAINING GAP is the ultimate form, named in full: the ladder
  recompiles the whole world thrice to answer a changed-cone question —
  Carried-Truth at the practice layer — and dissolves into the medium
  as (a) the INCREMENTAL fixpoint (the IC cursor re-deriving only the
  changed cone + downstream, the whole-world march kept as the
  trusting-trust audit tier, not the per-landing loop), (b) `mentl
  march` as a verb (self-application as a cursor mode, the bash
  scaffold dissolved per §6), and (c) the verdict as a PROJECTION
  (emit-diff's handle-anchored divergence as the march's Reason, never
  a line count). Sessions must never hand-roll ladders again — the
  canonical tool now bends to the probe loop instead.
- 2026-07-23 · THE RESET RESTORES VIRGINITY + the law goes alive in
  CLAUDE.md (the twelve-kill forensic dig's landings · pin 502f691e).
  heap_reset now zeroes [mark, bump) before the rewind ($heap_reset_impl,
  a dedicated preamble fn — never inline, the callers' scratch may be
  live): the post-reset world is bit-identical to the never-allocated
  world, so every zero-read (slot_present's Option niche, unwritten
  make_list slots — alloc_list_sc writes only the header) stays true
  under reuse. The invariant had held by ACCIDENT of monotonicity —
  wasm's zero-init pages — and the first reuse served stale bytes as
  placed arg slots; measured under the contract, the regioned battery
  runs at a 192MB peak. The battery ships no-reset still: the
  twelve-kill corpus (named-residue index) ends at a standing frontier
  the virgin reset does NOT clear — the fill_arg_slots slots buffer
  ALIASES the env handler's own state in virgin memory (both gated hits
  at collect's placed arm, zero at every placement channel, one
  binary), with the yield machinery in every fatal frame; the
  address-pair probe is loaded. CLAUDE.md gains the ⚖ ALIVE-LAW
  section (Morgan's update-the-law license as first-class law; the
  docs' own census-to-zero; the standing charge made ambient) and the
  five FORENSIC LAWS distilled from the dig (one-binary gates,
  protocol-honoring probes, retract-fast, count-the-kills,
  accident-invariants become contracts at the one writer). TRANSITION
  m3 == m4 (the 2-line preamble/call-form crossing); board whole.
- 2026-07-22 · THE SINGLETON TIER TELLS THE TRUTH — LDirectPerform +
  the stateful-uninstalled refusal (the last silent-wrong class of the
  gate arc closes · pin fc2a9520). The singleton perform is its own
  LowIR node whose EVERY reader — emit, locals, reach, k2, spec, the
  census — delegates through singleton_perform_block, so its semantics
  equal the old inline form BY CONSTRUCTION (the ladder proved it: CLEAN
  m2 == m3 == m4, byte-identical). The census walk fires its demand, and
  the gate's resolver tightens: a demand through an op with a default
  handler grounds when the handler is STATELESS (the direct call touches
  no state) and joins the refusal set when STATEFUL — the read of a
  zero-initialized state global that no install ever wrote, the exact
  silent-wrong the emit's own comment used to wave off as "never read"
  (comment trued). Sound because the singleton tier is unique-handler by
  definition: an install of the ename IS an install of that handler.
  Fixture mn-effect-stateful-uninstalled seen RED (the prior boot
  compiled it clean and the artifact returned the wrong value); the
  stateless shape stays green. Frontier 192/0; census 0. The gate arc's
  named remainder is now EMPTY; the one open external arc is the
  wasi-threads migration — DESIGN COMPLETE (the threads-scout recon,
  2026-07-23), banked as `Hβ.ops.wasmtime-runner-migration` in the
  named-residue index.
- 2026-07-22 · ▶▶ THE CRUCIBLE TIER — DSP, ML, and the DSP×ML fusion land
  as real-workload gates, and building them killed a latent miscompile
  (an isolated builder's arc, merged whole · pin fe68767f). Three
  self-contained fixtures, each cross-validated against an independent
  python oracle over the SAME formulas, every verdict a discrete fact
  with wide margins: dsp-crucible (two sinusoids + a pseudo-noise tone
  through the `<~` recurrence lowpass; verdict = 8-bin DFT argmax of the
  FILTERED output — load-bearing on the filter, the raw signal's louder
  tone sits elsewhere — + zero-crossings 21 + clip count 64); ml-crucible
  (batch gradient descent, 2-parameter linear regression on 32 points;
  w,b converge to the planted 3,1); adaptive-crucible (a 2-tap LMS filter
  learning channel [2,1] ONLINE while filtering — feedback, float math,
  and learning in one loop, the fusion only the medium states this
  cleanly; residual power 13.89 → 2e-30). Each seen RED by perturbation
  (lowpass a=0.9 flips the argmax to bin 7; wrong slope exits 10; wrong
  channel exits 10; teaching codes kept under WASI's 126 exit ceiling).
  THE HARVEST: float `<~` NEVER ASSEMBLED — the emit hardcoded the
  feedback slots ($__fb_prev/$__fb/the state global) to i32, so the
  entire float IIR family in lib/dsp/feedback.mn was dead codegen
  (Carried-Truth: the graph proved the feedback node's type; the emit
  fabricated i32); the fix reads repr_of(lookup_ty(h)) live at both decl
  sites. No reachable wheel site floats a `<~`, so the fix rode a CLEAN
  m2 == m3 == m4. Frontier 191/0 at the pin; census 0; the builder ran
  isolated in a worktree and the merge was two clean 3-way patches.
- 2026-07-22 · THE STAGING CLOBBER'S ROOT — one handle, one local, nine
  writers (the interp-segment mint · pin ccd9381d). The
  effectful-arg staging clobber witnessed thrice tonight reduced to ONE
  mint bug: lower_string_interpolation's fold stamped the MakeString
  node's single handle on every interior str_concat call, and emit's
  per-handle staging local ($call_<handle>) folded all N−1 segments into
  ONE cell — re-set per segment while later splice reads still loaded
  through it. Pinned mechanically, not by repro (three structured repro
  shapes ran CORRECT — the corruption needs the arm-context interleave):
  the diagnostics arm's wat under the reconstructed 5-splice render shows
  nine local.set of $call_73934 with reads against stale values; under
  the fix every staging local in the same arm sets ONCE. The fix is the
  mint law: every interior concat mints its own handle
  (graph_fresh_ty at the fold), the outermost keeps the node's handle
  (its type/span identity). TRANSITION m3 == m4 (4,246 lines of staging
  renames crossed one generation); the sequenced-lets forms landed
  earlier tonight stay as better prose, no longer load-bearing. Board
  whole at the pin.
- 2026-07-22 · ▶▶ THE EVIDENCE HOLE REFUSES AND TEACHES — E_EffectUnhandled,
  the gate's third read, born ARMED on the true rows (the arc Morgan opened
  with "we should never see a WASM error" · pin TBD). An executable whose
  main-row carries an effect no install absorbed REFUSES at compile
  (exit 1, zero WAT, main's own decl span) with the graph-derived teach:
  no handler in scope → the declare-one form; a declared-but-uninstalled
  handler → "Install one over the performing chain: ~> pong" — read from
  the env's own HandlerKind arms through each op's EffectOpScheme, never a
  name table. THE CRITERION READS THE ARTIFACT, not a ledger — Morgan
  caught the first build red-handed ("building a ledger system?
  carried-truth violation much?"): lower-side note-lists caching perform/
  install facts were drift-7 by the letter, and they died into the emit's
  OWN single-walk multi-projection pre-pass — the SEVENTH projection
  (EmitEffectCensus: visit_effect_demand at LEvPerform's ename-carrying
  floor node and LYield's op, visit_effect_install at LHandleWith's arm
  groups), run by the gate over the post-reach tree it already holds.
  Reach-filtering is FREE (dead code is absent from that tree — the
  to_string shell-body class), a lexically resolved LPerform fires no
  demand (discharged by its install), and a singleton-tier perform fires
  none (direct call). Conjunction: present at the root ∧ not
  substrate-grounded ∧ a floor demand exists ∧ no install anywhere (the
  install conjunct covers the ambiguous-handler floor). SIX false-refusing
  micros forced the design there, and TWO inference roots fell to them: a
  VAR tail's pending mask now lives IN THE GRAPH (diff_row mints a fresh
  var bound to the masked triple over the original tail — union's absent
  is the mask INTERSECTION, set-correct, so a top-level mask on a var
  tail vanished at the frame union: multieffect's `run() ~> buffer` in
  let position lost Emit's subtraction), and a multi-effect handler's
  install subtracts its FULL arm-derived set (derive_handler_enames — the
  single-name subtraction left buffer's sibling effect on the caller's
  row). THE Show/Hash EFFECT SHELLS DISSOLVED at the same root: the
  LShow/LHash build had moved their dispatch to emit-structural, so
  `effect Show`/`show_default`/`with Show` was archaeology whose contract
  poisoned every caller's row — to_string/hash are now seq-op table faces
  (a -> String, a -> Int; raw word bodies that never run). WITNESSED
  THRICE and cured by sequencing, the EFFECTFUL-ARG STAGING CLOBBER: an
  effectful expression evaluated inside an interpolation splice list, a
  ctor argument list, or another perform's argument list corrupts a
  sibling operand's staged value (the diagnostics render's span read a
  stale env record; the perform-ledger probe read "" for every frame) —
  the render and every touched site are sequenced-lets now; the emit-side
  root is the next staging dig. THE NEXT DIG, design COMPLETE
  (specified against the artifact, ready to build): the
  uninstalled-singleton class. Corrected mechanism — the $ev_lookup
  assembly failure is the BARE-STDIN path only (the contract name is
  genuinely absent from an unlinked input; linked programs carry it), so
  the real remainder is the LINKED stateful case: a singleton-tier
  perform against a never-installed stateful handler reads the zero-init
  state global — silent-wrong. The build, each piece named: (1)
  LDirectPerform(handle, hname, op, args) — the singleton perform's own
  LowIR node, its emit arm DELEGATING to emit_expr over the exact
  LBlock/LLet/LPerform value lower_singleton_perform builds today (byte
  drift impossible by construction; Law 7 arbitrates); (2) the census
  walk fires visit_effect_demand at it; (3) the gate's resolver already
  maps op→ename, and for a demand that resolves through an op WITH a
  default handler the refusal tightens to stateful(handler) ∧ ename ∉
  installs — sound because the singleton tier is UNIQUE-handler by
  definition, so an install of the ename IS an install of that handler
  (ename-install ⟺ hname-install); statefulness reads live from
  HandlerKind's state fields. Stateless-uninstalled stays green (the
  direct call touches no state). This read
  could not EXIST before the triple: the six-form row dropped the install's
  subtraction off unresolved tails, so main's row lied (the design was
  refuted by six micros in its first life THIS session, for exactly that
  reason) — the representation fix is what makes the diagnostic true. Also
  landed on the way, each witnessed by probe: the pure row returns as the
  wheel's OWN first top-level let (ef_pure_row, riding the init-bracket
  fix); fn env entries carry Located(decl-span) reasons at both register
  sites (the Why chain and this diagnostic read them); handler_arms_touch
  destructures CLOSED (the trecordopen-wrong-field class — the open field
  read returned garbage and the proposal missed pong); the name compares
  pin `: String` (the §9 pointer-eq class); and the diagnostics render is
  sequenced-lets — the old single 5-splice line MIS-RENDERED its last
  splice when an earlier splice's evaluation allocated (witnessed live:
  the span rendered a stale env record's span, 362:78 for 2523:4, until a
  preceding read shifted the staging — the shared-scratch clobber class at
  the interpolation emit; the sequenced form has nothing to clobber; the
  minimal-repro dig is the named residue
  Hβ.emit.interp-splice-staging-clobber). Fixtures RED-first against the
  pre-gate boot (both refusal programs compiled CLEAN, 5.6KB of WAT that
  faults at 0x100000000 at runtime): frontier mn-effect-unhandled +
  mn-effect-uninstalled (refusals) + mn-effect-absorbed (42). check/edit
  never route through the gate — the productive surfaces stay open.
- 2026-07-22 · THE BACKTICK CONTRACT REACHES ZERO (comment-refs 52 → 0,
  ratchet 0 · pin 10639d69). Morgan asked what the 52 phantoms were for —
  nothing: stale prose debt behind a tourniquet (the ratchet existed only to
  stop the number rising, and it caught this session's own fresh phantom
  before commit). Every cited symbol now resolves: dead names repointed to
  live successors (collect_fn_emit_records; MultiShot/OneShot for the stale
  Many/One spellings), deletion-history and other-scope locals unbackticked
  to prose (the contract: a backtick is a reference into the one namespace;
  narration is prose), and the checker's own leftover CLH per-comment eprint
  deleted (1,536 stderr lines every compile since the pass landed).
  comment_refs_max: 0 makes the class a hard gate — the census arming law,
  one layer up, at the prose boundary. Board whole at the pin.
- 2026-07-22 · ▶▶ THE ROW IS A TRIPLE — the six-form EffRow tree dissolves
  into ONE canonical record (the representation-law update Morgan licensed:
  "if a law written earlier now holds us back, update the law" · pin 09380a33).
  `EfRow(present, absent, tail)` with `EffTail = EtClosed | EtVar(v) | EtAll`;
  reading = present ∪ (tail ∖ absent); canonical AT BIRTH (ef_make dedups,
  absent ∖= present, empty-set identity fast paths) so no read ever
  normalizes — the normalize/retry rewrite passes, the six-arm cross-products
  in unify/union/subsumes, and the read-time chasing allocation storm are
  DELETED whole. Research-grounded, then made Mentl's own: Rémy's
  presence/absence row fields (1989, the Links lineage) carry `!E` as a FIELD
  where Koka's scoped labels chose duplicates precisely to avoid absence;
  the `~>` subtraction rides the SAME field (a pending mask on a var tail —
  the modal-effects reading of the install as a TRANSITION fact, Tang–Lindley
  POPL 2026, held as data instead of a rewrite step); and the eager literal
  difference is the Castagna/Elixir set-theoretic cure (their 1000-clause
  slowdown is this compiler's 1e5-unify OOM, same disease) — the handled set
  is always a literal, so diff_row is ef_make(pa∖pb, aa∪pb, ta), eagerly, no
  lazy BDD. The FAT-ROW ROOT this dissolves: the old normalize_inter
  open×neg arm subtracted known names and DROPPED the negation from the
  unresolved tail var, so an install typed before its body's row grounds
  never subtracted the handled effect — main's row kept every absorbed
  effect, dead evidence entries stacked, and the unhandled-effect fault at
  0x100000000 had no diagnostic. TWO one-writer rulings landed with it:
  subsumption READS (resolve_row, no binds — the E_EffectMismatch the medium
  raised on egraph's is_pure was itself the catch: a compressing read had
  made every projection a writer; the GraphWrite compression belongs to
  unify_row alone, where inference owns the bind) and the free-tail law
  re-derived on the triple (a tail still EtVar after resolve is GENUINELY
  free = vacuous at the gate — its rejection was the 646-error
  false-mismatch wave m2's first self-judgment raised, the same ~80% slice
  the six-form census once had). THE FIRST TOP-LEVEL LET the medium ever
  compiled came out of this arc (`let ef_pure_row = …`, the shared pure
  row): boot faulted at 0x100000000 emitting $__init_lets — NOT an OOM (RSS
  2.6GB of 4GB, measured; the OOM story died to /usr/bin/time) but a wild
  key-scan: emit_init_lets was the ONE emit_expr caller with no local
  `~> emit_memory_bump` bracket (every fn body rides one —
  emit_one_fn_to_string's shape), so the evidence-dispatched emit_alloc
  (three memory handlers; never singleton-tiered) scanned an unthreaded
  region into the wild address. Two hypotheses died to the artifact on the
  way (⟲): "the 4GB ceiling" (RSS measurement) and "band-N
  config-fn-evidence-in-arm" (the direct named loop reproduced the fault);
  the local bracket is the mechanism, and the init bodies now emit under
  it. Fixture tests/frontier/mn-top-level-let.mn (module
  ctor-with-empty-list-args lets) seen RED on the pre-fix boot (exit 134,
  the exact fault), GREEN through the fixed wheel (42). The wheel keeps
  mk_ef_pure() allocating until this fix pins; the shared module-let pure
  row is the named follow-up (the wheel's own first top-level let). Hygiene
  rode along: 12 six-form remnants + 23 zero-reference fns deleted (~215
  lines — normalize_row, neg_row, the list_* alias shims, dormant cursor
  variants); the comment-truth pass leaves ZERO six-form mentions in code
  OR prose (SYNTAX/PLAN trued; §4③ carries the representation note). Board:
  census 0 at every generation; ladder m2 == m3 == m4 byte-identical
  (18.8MB), size-guarded (the empty-wat cmp-equal trap closed — every leg
  asserts nonempty before diff); feedback-iir 30, handled-Ping 42,
  top-level-let 42.
- 2026-07-22 · THE AFFORDABILITY DIG, second pass — two more mechanisms
  measured, the arc's design now COMPLETE on paper (tree back at the
  green fixpoint; no re-pin). Attempt A, the identity floor
  (row_is_canonical guarding normalize_row to alloc-free identity +
  resolve_row split into a progress guard and a reduce path): the wheel
  compiled census-0 and the fixtures held, but the SELF-compile still
  OOM'd — the trap moved to normalize_inter under unify_row_canonical,
  meaning some row class permanently fails the canonicality mirror and
  rebuilds per call (suspect: same-named EParameterized instances vs the
  by-name prefix-contains — UNVERIFIED; profile with perf before
  believing, §8's law). Attempt B, containment (the pending pair bound
  behind a fresh row var, the flowing row kept in the three cheap
  forms): refuted by mechanism — a pending-BOUND tail meets open-open
  unify, which BINDING-MERGES per call (graph_bind_row on an
  already-bound tail recurses into binding-unification), so the
  subtraction cannot ride the tail slot at all. THE COMPLETE NEXT ARC,
  one landing: (1) canonical-on-write rows — normalize once at
  graph_bind_row, unify operands arrive canonical by invariant, reads
  return the stored node; (2) the deferred subtraction as an
  INSTALL-EDGE fact (the `~>` draws an edge, §2's own words) read by
  residual-row consumers, never a rewrite of the flowing row's tail;
  (3) profile-first (host perf on the self-compile) so the churn source
  is measured, not guessed — three prior code-reading estimates in this
  family were wrong (the classifier lesson repeating at the row layer).
  All comments touched in the reverted attempts carried their truths
  into this ledger; the KNOWN-INCOMPLETENESS block at normalize_inter's
  open×neg arm survives in the entry above as the site's standing
  characterization.
- 2026-07-22 · THE ROW'S DROPPED SUBTRACTION — root FOUND and fix PROVEN;
  shipping WAITS on canonical-on-write rows (no re-pin; the tree stays at
  the green fixpoint). The arc: retiring the raw-WASM error class (an
  unhandled effect compiles CLEAN then dies as `memory fault at
  0x100000000` — the ev-scan walking main's empty evidence into the
  sentinel page, MEASURED) led through three designs to ONE root.
  (1) The gate-time ROW read (E_EffectUnhandled at the executable gate,
  main's residual row minus substrate/default effects) — REFUTED by six
  micros: main's row still carried Sample past an absorbing install.
  (2) The mint-site read (an LEvRef threaded from main's frame) with an
  `ls_outer_fn_name() == "main"` guard — Morgan's own cut: a name-keyed
  special case, and Mentl must judge itself by structure, not by name.
  (3) The gate walk over ONE child projection (lowexpr_children — the
  walker-unification seed, ~40 arms once, every future walk a recursion
  over it) with a provided-set carried through enclosing installs —
  which surfaced the TRUE root: normalize_inter's open×neg arm
  `EfOpen(names, v) − handled => EfOpen(names − handled, v)` SUBTRACTS
  THE KNOWNS AND DROPS THE NEGATION FROM THE TAIL, so an install typed
  before its body's row resolved never subtracts the handled effect —
  main's fat row, and DEAD LEvRef evidence entries minted from it (the
  runtime survives only because the singleton tier never scans them).
  THE FIX, built and proven on the fixtures: the pending subtraction —
  `EfInter(EfOpen(names − handled, v), EfNeg(EfClosed(handled)))` —
  with resolve_row growing reduction arms (chase operands, re-run the
  pure reduction; the open head unions into a pending tail via the
  total union). Under it feedback-iir runs 30 AND the unhandled-Ping
  program's row is true. It cannot SHIP yet: rows are re-normalized
  PER READ (unify_row_canonical → normalize per call, ~1e5 unifies ×
  sort_unique/wrap allocations), and the pending nodes multiply that
  churn past the 4GB ceiling mid-self-compile — Carried-Truth violated
  at the ROW layer (§5.O: a normalize per read is a re-derivation).
  THE NEXT ARC, fully specified: CANONICAL-ON-WRITE rows — normalize
  once at graph_bind_row, reads return the stored node (O(1)), binds
  re-canonicalize only the affected row; the deferred subtraction then
  rides the store free, the row becomes TRUE, and E_EffectUnhandled
  re-lands in its ELEGANT first form (the row read at the gate) with
  the graph-derived proposal (handlers_absorbing — the env names which
  declared handlers absorb the effect; the diagnostic teaches the
  install; the finite candidate set is Synth's larval proposal). The
  unifying frame, banked from Morgan's charge: absence is ONE node-kind
  — the value `??`, the evidence hole, the proof hole, V_Pending — one
  gate law (productive, never executable), one proposal machinery, the
  ambient argmax ranking them, multi-shot exploring them: every
  diagnostic-with-span-and-proposal is a search position for
  Mentl-building-Mentl. Ladder-hygiene lesson, paid live: an empty
  m3.wat cmp-equal to an empty m4.wat read as a fixpoint — a gate that
  cannot fail; size-guard every ladder leg (march.sh's arbitration
  already does; my by-hand legs now must).
- 2026-07-22 · ▶▶ THE REPRESENTATION CHASE — the truth unification erased,
  carried back (pin 35e5437e). The SeqRep lattice (SRFlat | SRSnoc |
  SRRope | SRSlice | SRUnknown) is the fact every runtime helper re-derives
  per value (load tag_word; branch): minted at the construction the graph
  already knows (a literal is flat, `++` a rope, push snoc, slice a view),
  carried through local lets by the LowerScope edge ls_bind_local ALREADY
  draws (name -> the init's handle — no new state, no handler, no installs:
  the chase is a pure projection over two existing edges), JOINED at
  control merges (equal survives, a genuine merge widens to SRUnknown —
  the honest floor where the tag branch is real information), fuel-bounded
  (8 steps; exhaustion degrades sound). ONE license per match (hoisted out
  of the per-arm map — the first build allocated per arm × per chase and
  hit the 4GB ceiling on the wheel; the trap taught the hoist). The first
  consumer: a proven-flat word-stride scrutinee's list pattern emits raw
  POff(8+4i) loads — ZERO $list_index calls, bounds proven by the
  pattern's own length test — the exact bytes the pre-PIdx emitter
  ASSUMED for every list, now proven per receiver; rope and snoc stay on
  the total reader. Measured on the three-representation fixture: flat =
  0 calls/2 raw loads, rope = 3 calls, snoc = 2 calls, one behavior
  (mn-seq-rep-license, frontier). Named consumers next: xs[i] under the
  license (needs a proper bounds-composed low node), the spec bracket
  carrying rep pairs (generic bodies get proven reps — the twins' next
  axis), and the per-fn rep summary (interprocedural). Board whole:
  census 0, frontier 174/0, proof-exactness 9/9, crown 5/5, micros
  green, clean m2 == m3 at the pin.
- 2026-07-22 · THE COMMENT SCAFFOLDS DISSOLVE INTO THE COMPILE (absorption
  complete, no re-pin — tools only). tools/comment-audit.sh and
  comment-ratchet.sh are DELETED: the medium's own W_CommentRefUnresolved
  pass (every compile's infer tail) is the classifier, and verify.sh's
  census step ratchets its count off the SAME m2.err the census already
  reads — zero extra passes, comment_refs_max in the baseline (52 at
  absorption; the ratchet drives it to 0). state.sh's separate PHANTOMS
  gate dissolves into verify; the pre-commit hook keeps only the semantic
  reminder (content-matches-code is the judgment no resolver makes). This
  is the ratchet script's own written destiny executed: "both ratchets
  dissolve together into mentl audit, which is the projection they are
  larval forms of."
- 2026-07-22 · ▶▶ FIELD OFFSETS PROJECT AT EMIT + THE STRUCTURED ENC — the
  monomorphization machinery generalizes from repr to STRUCTURE (pin
  09f9706a). The last lower-time layout bake moves to the read: LFieldLoad
  carries a SELECTOR (FByName / FByIndex — the FieldSel ADT), and ONE
  projection (field_sel_offset) resolves it at emit through lookup_ty under
  the active specialization bracket — record fields, tuple slots, and the
  record-update copy path (which now projects off BASE's handle, healing the
  added-field layout split) all read live. The spec enc stops speaking repr
  only: a structured concrete encodes as its fold_sig (wide digits unchanged
  — existing twin names stable), so structure-bound sites become candidates,
  and the worthiness witness generalizes to spec_ty_needs_structure — the
  floor lies about ANY operand beyond the true word scalars (wide, string,
  list, record, tuple, payload sum; a nullary-only sum is word-honest, read
  from the variant specs). 128 structured twins emit on the wheel;
  in_owner_names' `==` on [String] HEALS BY TWIN and its Intent-Boundary pin
  is DELETED — the eq-on-generic-String class (pointer-eq under the word
  floor, the §9 class) closes systemically, by specialization instead of
  annotation. Twin emission hardened en route: nested-lambda contributions
  dedup by mangled name (two parents, one lambda, one enc), and every
  generated fold-leaf opener declares the state-insert scratch trio (a
  tuple-with-sum sig's conjunction recursion emitted undeclared locals — an
  assembly failure no prior sig shape reached). The one remaining pin family
  is characterized exactly: cl_state_names/cl_arm_names read fields of a
  CONSTRAINED-open record — TRecordOpen, which the TVar-shaped witness
  misses, and whose offsets over a partial field set are the wrong-field bug
  — the row must resolve under the bracket; that dig deletes the last two
  pins. Ladders ran two-stage disposable (W1 pinned under boot → m2 → the
  unpinned wheel → m3 == m4). Board whole at the pin: census 0, frontier
  171/0 (+rope-list-pattern — the pa11 crucible), proof-exactness 9/9,
  crown 5/5, micros green, phantoms 220 → 54 with the ratchet lowered.
- 2026-07-22 · THE TEST VERB COMPILES THE BATTERY IN-PROCESS + the region
  substrate (CLI absorption stage 2 · pin 658f3988). `mentl test <dir>`
  forks on the target's own shape: a DIRECTORY is the battery
  (fs_list_dir_impl — fd_readdir joins io.mn's transport set; a file stays
  the single check). Each micro declares its oracle in its first line
  (`// expect: N`, the 112-micro sweep c63a0a47 — the expectation is graph
  content ON the artifact, never a side-table row); each compiles
  IN-PROCESS under a fresh handler chain (verdict = holes + refusals, the
  check verb's own licence), WAT under .build/test/ beside a streamed
  manifest line; execution stays the shim's seam (WASI owns no
  process-spawn — the process_exec precedent). One process replaces a
  wasmtime boot per micro. The REGION substrate landed with it: Alloc
  gains heap_mark()/heap_reset (emit = the bump global read/written, the
  §5.O arena's first grain), gated RED-first (mn-heap-region: a reclaimed
  region's next alloc returns the SAME address; 134 on the pre-arm pin, 42
  here). The honest residue: bracketing each battery compile with
  mark/reset traps compile #2 in its own infer while EVERY input is
  probe-verified intact (libs len+head+tail, the names, the reset
  address), and WITHOUT the reset 100 compiles run clean to the 4GB
  ceiling — 12 short of the battery. The no-reset form ships; verify.sh
  keeps the per-process loop as the gate; the peer
  Hβ.runtime.cross-compile-durable-state (named-residue index) carries the
  corpus, and closing it IS the arena's first real workload. Board: census
  0, frontier 168/0 (+heap-region), proof-exactness 9/9, crown 5/5, micros
  green, clean m2 == m3 self-confirmed at the pin
- 2026-07-22 · THE HYGIENE WAVE + three rulings banked (no re-pin — the
  wheel untouched). DELETED per Morgan's ruling (git is the archive, no
  archaeology ceremony): docs/specs (2.2M), docs/research (1.3M),
  docs/errors, docs/traces, DESIGN.md, SUBSTRATE.md, ULTIMATE_MEDIUM(.md +
  _DIAGRAM), SYNTHESIS_CROSSWALK.md, EFFECTS.md — docs/ is now the three-doc
  contract plus the three live working artifacts (NATIVE.md, DESIGN_SYSTEM.md,
  MENTL_EDIT.md); every dangling pointer in PLAN/SYNTAX rewritten as a
  git-history note. .build purged 579GB → 21M (keyed m2cache kept).
  tests/repro dissolved (all repros graduated to gates). THE PHANTOM RATCHET
  made PRINCIPLED: comment-audit resolves a cited symbol against wheel source
  UNION the emitted artifact's own namespace (read live from m2.wat —
  normalized __-prefixes and _<handle> suffixes; the artifact IS the
  namespace) UNION the three docs' design vocabulary (fn_ptr / tag_word /
  nstate resolve against the design's source exactly as fns resolve against
  code) — 286 → 231, baseline ratcheted down; the residue is genuinely
  stale prose (the hand-sweep is the named follow-up, frame_k's defining
  home included). THREE RULINGS BANKED: (1) Hβ.voice.script-is-projection —
  the mentl voice is NOT a model: it speaks only the author's own comment
  prose, graph projections (types/rows/Reasons/spans), and a fixed template
  grammar composed of them — easy enough to teach anyone, deep enough along
  the gradient that the hardest developers feel the floor under every word;
  (2) Hβ.compile.fixpoint-is-larval-forked-cursor — every hand-rolled
  worklist/fixpoint in the wheel (the spec demand analysis, classify_fixpoint,
  reach, worthiness) is a larval FORKED-CURSOR SEARCH; when trail-fork lands
  as compile substrate each rewrites as forks with rollback (Morgan's own
  call: 'why build a worklist when we could have built a forked cursor
  search'); (3) the anti-drift safeguards (drift-audit, the hooks, the
  discipline prose) are LARVAL mentl audit — when the medium is real they
  dissolve INTO it (§0's own convergence: the gate that keeps an LLM honest
  is the gate that keeps every proposer honest), so the hygiene endpoint is
  absorption into verbs, never deletion of the safeguard
- 2026-07-22 · ▶▶ THE LSHOW/LHASH BUILD — the LAST lower-time type bake moves
  to emit; FOUR latent breaks close (monomorphization face 7 + band D's leaf
  seam · pin f60110f4). to_string/hash are STRUCTURAL nodes dispatched at
  emit under the active bracket (show_node_of/hash_node_of — one dispatch
  home; every walk delegates through it; scalar sites byte-identical), so a
  twin's render shows the VALUE and its hash agrees with its eq; a
  render-only generic still twins (the operand is a worthiness witness).
  The four closures, each probe-pinned RED first: the aggregate leaf call is
  DIRECT (§5.U's own law — the closure-convention form referenced a
  $show_<sig> global NO module ever emitted, an assembly failure in every
  minimal module); the leaf's interior renderers survive reach
  (show/hash_reach_names — int_to_str was pruned); the decor literals
  register (the fold_closures.show CALL-SITE field read resolved a wrong
  empty slot — Hβ.lower.trecordopen-wrong-field measured LIVE: n=0 at
  register vs n=1 at generation from ONE record; fixed by passing the whole
  closed-annotated record); and hash(x) gains its declaration (the to_string
  mirror — the name NEVER resolved; the hash surface was unreachable from
  user code). Twin fold collection runs per-demand under its bracket
  ($show_ld beside $show_li). Gates: mn-generic-show (RED: address render) ·
  mn-aggregate-show (RED: assembly failure) · mn-aggregate-hash (RED:
  E_MissingVariable) — all 42; frontier 165/0; census 0; TRANSITION
  m3 == m4 with the new wheel SMALLER (the name-bake machinery deleted).
  The monomorphization arc's residue is now EMPTY of known silent-wrong
  faces; wide_call_seed / is_show_global / is_hash_global / the five lower
  dispatch fns are deleted whole
- 2026-07-22 · THE EXACT-SUBSTITUTION SWAP — monomorphization face 3 CLOSES
  (the multi-type unlock · pin 4a114123). The bracket carries the site's
  EXACT instantiation pairs (root -> concrete); a free leaf answers its OWN
  root's binding; a root not in the pairs stays the honest floor TVar; the
  one-wide-type guard is DELETED (the free-leaf rule and its guard were
  scaffolding around the subscript fracture, retired with it). Mixed
  instantiations twin: sqboth at (Float, Int) -> $sqboth$sp20 squares the
  f64 AND the i32 natively in one body. Gate mn-generic-multitype RED (1)
  on the prior pin, 42 now; frontier 156/0; census 0; clean m2 == m3. The
  monomorphization arc's named residue is now ONE face: the lower-time
  show/hash bake (band D's leaf work — the LShow/LHash build)
- 2026-07-22 · THE SUBSCRIPT FRACTURE FIX — Force = UNIFY, never overwrite
  (infer.mn IndexExpr · pin da45bcdd). The xs[i] sugar arm graph_bind-
  OVERWROTE its receiver, discarding the proven TList(elem) and orphaning a
  fresh element class per subscript — the union-find FRACTURE beneath the
  monomorphization free-leaf rule, pinned by an adversarial worktree agent
  (probe: merge's condition subscripts rooted at 13777, its param element at
  13793; the unify fix collapses them to ONE class, agent-verified). Its
  sibling seq_force one table over states the law verbatim. Both forces now
  unify; the §4① String seam holds (a proven-TString receiver SATISFIES the
  force, s[i] binds TByte — sharper than the old clobber). The REFUTED
  hypothesis is the record's point: my own "instantiate-shares is the root"
  died to the artifact (instantiate heals through argument unification,
  polymorphic recursion included) — the adversarial dispatch existing so the
  orchestrator's label could be killed by a probe. UNLOCKED, named: exact
  root-keyed substitution (replacing free-leaf) and the multi-type-generic
  guard lift, now that a generic body's element classes are one root.
  TRANSITION m3 == m4; census 0; frontier 153/0; proof-exactness 9/9;
  crown 5/5. Sibling finds from the same ultracode wave, banked: to_string/
  hash are the ONLY remaining lower-time type bakes (the D3 map — everything
  else already reads under the emit bracket; the build moves them to a
  structural LowExpr node dispatched at emit), and a pre-existing LOUD break:
  to_string((1,2)) in a MINIMAL lib set emits calls to $show_<sig>/$int_to_str
  that reach never kept and no static closure global backs — assembly
  failure, masked in the full battery by richer lib sets
  (Hβ.emit.generated-helper-reach — the show-face reach arms fix it as a
  side effect when the emit-dispatch build lands)
- 2026-07-22 · NESTED-LAMBDA TWINS — monomorphization residue face 1 CLOSES
  (Hβ.emit.spec-nested-lambda-twin LANDED · pin a919906d). A lambda born
  inside a generic body twins under the parent's instantiation with ZERO body
  rewriting: the worthy demand contributes every record nested in its body
  (mangled with the parent's enc), and the closure-mint arm redirects the
  record's table index through the bracket's active enc (spec_closure_name —
  the LGlobal redirect's closure-mint face, registry-gated; captures,
  self-binding, local naming keep the original name). Bracket state widened
  to (spec_wty, spec_enc) on the one LookupTy handler. The landing FORCED a
  width-consistency fix with reach beyond twins: a param used ONLY inside a
  nested closure had no param-decl width source (find_local_handle_expr
  stopped at the closure boundary) while the capture-store read the live
  handle — (param $k i32) declared, $k.f64 read, an assembly break; captures
  and evs are PARENT-frame expressions and the walk now reads them. Gate
  mn-generic-nested-lambda RED (1) on the prior pin, 42 now; frontier 153/0;
  census 0; clean m2 == m3. Remaining faces: the lower-time show/hash
  dispatch (mn-generic-show-lower-dispatch, band D's leaf-as-lowered-LFn)
  and multi-type generics (the uniform-wide guard)
- 2026-07-22 · ▶▶ NAMED-GENERIC MONOMORPHIZATION — the §5.U scalar half LANDS
  (Hβ.value.seq-element-stride-carrier's monomorphization face · pin 92fceff0).
  A named generic fn compiled ONCE at the RI32 floor and, reached at a Float
  instantiation, compared/added the word-protocol REFERENCES (prelude `sort`
  returned its input in allocation order; `reduce(xs, min)` picked by address —
  the data-validator tier's harvest, silent-wrong, zero diagnostics). Now: emit
  runs a DEMAND ANALYSIS — each reference site's instantiation is a PROJECTION
  off the live union-find (scheme type walked against the site's resolved type;
  zero new storage, zero infer changes — Carried-Truth: the unifier already
  drew the edges, the walk reads them), a site whose quantified vars land on
  ONE distinct wide type is a candidate, and a candidate is WORTHY when its
  body performs arith/compare/eq on a free-floored operand OR an interior site
  redirects to a worthy twin (the transitivity fixpoint: sort twins because
  merge is worthy — no recursion special-case; plumbing shells like fold/map
  stay floor, which the word protocol keeps CORRECT — twins only where the
  floor is WRONG). A worthy twin is the SAME record emitted once more under
  the SPECIALIZATION STATE: lookup_ty_graph carries spec_wty (set/cleared
  around the twin's emission), and while set a FREE var answers the wide
  instantiation — the free-leaf rule, FORCED by the artifact (probe: a generic
  body's unresolved classes FRACTURE — merge's param element roots at 13793,
  its comparison operands at 13777 — so no root-keyed mapping is complete;
  one-wide-type demands make every free unambiguous, and multi-type generics
  stay floor as the named residue). THREE hard-won mechanisms, each
  probe-pinned RED first: (1) STATE-swap, never a second handler — a second
  LookupTy handler demoted every lookup_ty out of the singleton
  direct-dispatch tier (16 frontier reds: ev-scan faults at infer sites that
  never threaded evidence); (2) the order-conditional row class — wasm.mn
  sorts before types/lower in the wheel, so INFERRED rows disagreed between
  Tier-2 callees and bare callers (a 4GB ev fault): every spec fn DECLARES its
  row, the build_reach_index precedent; (3) the concat floor at wide_all — an
  open element through a filter-with-handler chain, closed by the declared
  [String] Intent Boundary. Twins ride every name surface appended (table via
  $wf$ word faces when wide, idx globals, static closures); LGlobal/LFnRef
  redirect through spec_target_name gated on spec_registry (SpecTwins — the
  StringTable pattern), the spec_twins_exist fast path keeping twin-free
  modules at one op per reference (Law 7: Int instantiations byte-identical).
  Gates seen RED: tests/frontier/mn-generic-float-{accumulator,comparator}.mn
  run 1 (silent-wrong) on the pre-spec boot, 42 now — the two repro files
  GRADUATED into them (deleted). CFC's annotation discipline becomes OPTIONAL
  (annotated accumulators still valid Intent Boundaries, no longer required
  for correctness on these shapes). Residue, probed the same day and BANKED
  with a repro (tests/repro/mn-generic-nested-lambda.mn):
  Hβ.emit.spec-nested-lambda-twin — a lambda BORN INSIDE a generic body is a
  separate record emitted once at the floor, and the twin's closure mint still
  references the floor lambda's index; the fix is the same mechanism one level
  deeper (nested records join the demand under the same wide type + a rename
  walk), first witnessed by scale_all$sp22 delegating to its floor lambda.
  Second face, probed the same day (tests/repro/mn-generic-show-lower-dispatch
  .mn): a LOWER-time type dispatch inside a generic — to_string(x)/hash(x) —
  is invisible to the emit bracket twice over (the binop-only worthiness
  witness never counts a call, and lower already committed the word-show path
  into the LowIR: describe(2.5) prints the ADDRESS). The ultimate is band D's
  own show/compare-hash-leaf-as-lowered-LFn work, which moves those reads to
  emit where the bracket specializes them.
  Board whole: census 0, frontier 150/0,
  proof-exactness 9/9, crown 5/5, micros green, m2 == m3
- 2026-07-22 · THE DATA-VALIDATOR TIER — three real-workload oracles the
  fixpoint cannot be (no re-pin — tests + gate only, the wheel unchanged;
  m2 == m3 held). Three on-disk validators, each cross-validated against an
  INDEPENDENT implementation over the SAME bytes (the representation-stress
  leg: a byte-identical wheel can still corrupt user data, and only a second
  implementation agreeing on real data catches it): (1) cfc-rec — the CFC
  comodulogram on a REAL 4096-sample recording (WASI fs → view-split →
  parse_float → native [Float]), a 6→60 coupling DISTINCT from the inline
  demo's 6→40, Mentl and a faithful numpy port of cfc.mn both argmax flat 7;
  (2) stats-float — fold-sum mean, comparison-reduction argmin/argmax,
  mean-threshold count over 400 samples, three discrete facts EXACT against
  numpy (argmin 137 / argmax 298 / above 199 — discrete, so no ULP
  tolerance); (3) text-bytes — the String=[byte] merge's first real-text
  gate: byte_len / byte_at / structural == / a 256-slot histogram argmax
  over a 429-byte corpus, four facts exact against python. Every gate seen
  RED first (reversed data, perturbed text, a 6→40 recording — Mentl and
  the oracle shift TOGETHER, so the assertions are data-driven). Frontier
  135 → 144 / 0. Fixture transport hardened: the gate's own per-run dir is
  mapped as the guest's /tmp (wasmtime --dir "$dir::/tmp"), so the host
  never writes the shared world-writable /tmp (the predictable-path symlink hazard
  a commit-review flagged) — .mn sources keep their /tmp paths. THE HARVEST
  the validators paid immediately: building stats-float surfaced the
  monomorphization corner's SECOND face — a NAMED generic comparator passed
  higher-order (`reduce(xs, min)`) and prelude `sort` (resting on the named
  generic `merge`) silently MISORDER floats. Mechanism confirmed by probe:
  the word protocol passes each f64 by reference, the bump allocator hands
  out ascending addresses, and the i32-floored `<=` compares ADDRESSES — so
  sort returns its input order unchanged (values intact, order garbage,
  zero diagnostics). The precise scope rule, replacing two earlier
  narrower framings: lambdas and annotated helpers are SOUND (specialized
  per call site — map/filter/fold/each/reverse and every annotated
  accumulator); any NAMED generic fn compiled once at the i32 floor and
  reached at a wide type is NOT. Repros banked:
  tests/repro/mn-named-generic-float-comparator.mn (+ the accumulator
  sibling's scope note corrected). The ultimate — per-call-site
  monomorphization of named generics — LANDED the same day (the entry
  above); both repros graduated into frontier gates and were deleted
- 2026-07-21 · THE CFC PIPELINE RUNS ON NATIVE [Float] + the generic-over-wide
  keystone EVIDENCED (no re-pin — lib/dsp/cfc.mn is a leaf the compiler compiles
  but never calls, so m2 == m3 held directly). The cross-frequency-coupling
  research pipeline (lib/dsp/cfc.mn + the demo) sheds its fixed-point-Int carrier
  — the 2026-07-19 workaround for "a [Float] list does not round-trip today" —
  and runs on NATIVE f64 samples, phase/amplitude columns, and comodulogram
  matrix, finding the planted (6,40) coupling (frontier cfc-demo exit 42, 65
  fewer WAT lines: to_fixed/from_fixed/cfc_scale DELETED). This is the §5.U
  wide-element cash-out validated on the real workload — representation stress
  on real DSP, the verification leg that catches what m3==m4 cannot. The
  migration surfaced, by that same stress, the OPEN half of
  Hβ.value.seq-element-stride-carrier, EVIDENCED with a minimal repro
  (tests/repro/mn-unannotated-float-accumulator.mn). That peer names TWO
  solutions — a runtime stride carrier OR whole-program monomorphization; the
  STRIDE CARRIER shipped (7db29195) and made the SEQUENCE-READ sound (list_index
  reads the element stride live), so this is NOT the sequence read (that runs
  with an annotated accumulator). It is the MONOMORPHIZATION half, on a SCALAR:
  an UNANNOTATED float
  accumulator threaded through recursion (`sum(xs,i,acc) = sum(xs,i+1, acc +
  list_index(xs,i))`) leaves `acc` a type var when the body is checked (the list
  element is free), so the fn compiles ONCE at the RI32 floor — `(param $acc
  i32)`, `(i32.add)` — and a native-f64 [Float] call reads the f64 values as
  words: the sum is garbage (~0), exit 1, ZERO diagnostics. A generic function
  over a wide element compiled at the word floor cannot serve a Float
  instantiation; this is the SILENT-WRONG class (the friend's "m3==m4 is not a
  sufficient oracle" made concrete). The ULTIMATE is monomorphization or a
  runtime stride carrier; the HONEST INTERMEDIATE (broken -> diagnostic, never
  silent) is a REFUSAL where a wide-repr argument meets a word-repr parameter of
  a generic body. CFC dodges it by annotating every float accumulator (re/im/
  sc/ss/best: Float — the representation pin the gradient needs at a polymorphic
  boundary), and all annotated-[Float] paths are broad and green (literals, ==,
  ordering, arithmetic, show, map, threaded annotated accumulators, matrices,
  list-of-[Float] — verified by an 8-case representation-stress battery). SCOPE:
  this entry's second framing ("only named recursion floors") was ALSO
  incomplete — superseded by the 2026-07-22 validators entry above, whose
  measurement is the precise rule: any NAMED generic fn compiled once at the
  i32 floor and reached at a wide type is the floor (unannotated recursion AND
  named comparators passed higher-order, prelude sort/min/max included);
  lambdas and annotated helpers are sound. Board green: m2 == m3, frontier
  cfc-demo 42, census 0
- 2026-07-21 · EFFECT-POLYMORPHIC STORED FUNCTIONS + the mentl verb table
  (a hole in the medium closed, and the CLI overhaul it unblocked · pin
  1167ddfe). A first-class CLOSURE carrying its own effect row can now be
  STORED in an ADT field and called — the medium carries functions-with-
  their-rows through data, the same capability handlers rest on. The root
  was in the inferencer: quantify_ctor_ty (infer.mn) passed a function-typed
  ctor field's effect ROW through UNQUANTIFIED, so its open tail was a single
  free var that finalize closed to Pure — every effectful stored closure then
  "violated Pure," and a table of heterogeneous-row builders could not
  typecheck. TWO sub-roots: parse_type_ty minted the function-type row var as
  a TYPE handle (fresh_handle → graph_fresh_ty), which free_in_row never
  collects and instantiate cannot freshen; and quantify_ctor_ty never added
  it to the quantified set. quantify_ctor_row re-mints the open tail as a
  genuine row var (graph_fresh_row / NRowFree) and quantifies it; result_ty
  filters row handles out by node-kind (is_row_handle) so the type stays
  non-parametric; instantiate's is_row_handle → mint_row already freshens a
  quantified row var, so each ctor use gets a fresh row and the list unifies
  the builders' rows by the row algebra. This is the Carried-Truth Law at the
  type layer: the function's effect row is a fact the graph proved and
  quantify_ctor_ty DISCARDED. The fix UNBLOCKED the CLI overhaul (Morgan's
  ask): the verb set had three drifting homes — the hand-written verb_catalog
  help, the `if mode == "..."` parse chain, the dispatch match — now ONE
  VerbSpec table (name, arg-hint, BUILDER CLOSURE, description) projected by
  both find_verb (the closure builds the typed Invocation, or a per-verb
  ParseError naming the missing argument — a better message than the old
  generic one) and verb_catalog (the help, padded from the same rows), so
  they cannot drift; the address probe and dispatch match are unchanged. An
  earlier pass HERE sidestepped the inferencer hole with a VerbBuild data-tag
  (a name build_invocation re-derived the construction from — drift-8 + a
  Carried-Truth re-derivation, the closure IS the edge the tag re-derived);
  Morgan caught it, and the ultimate form is the closure carried directly.
  Witnessed RED→GREEN on the wheel's OWN census: the verb table drove it from
  7 E_PurityViolated (unfixed boot → m2) to 0 (fixed m2 → m3), then m3 == m4
  byte-identical, re-pinned boot holds the clean m2 == m3. Board whole:
  census 0, frontier 131/0 (+stored-fn-effect-poly capability test),
  proof-exactness 9/9, crown 5/5, micros green, phantom 286. Residue, named:
  parse_type_ty still mints EVERY function-type row var as a TYPE handle (the
  localized ctor-field fix corrects it only where it's load-bearing; the
  global parser fix is higher-blast-radius, sequenced); and the isolated
  stored-fn fixture is a capability smoke test, not the fix's discriminating
  gate (the generalization-to-Pure needs the full 14-builder context — the
  wheel census is the trusted gate)
- 2026-07-21 · ▶▶ THE WIDE-ELEMENT [Float] CASH-OUT (§5.U's stride carrier
  reaches its first wide element · pin 683d66cb). [Float] is a first-class
  packed sequence end to end, and the SAME landing kills the
  float-evidence-ft class ("all the birds, one stone"). The WORD PROTOCOL is
  the keystone: "a handle IS a word", so the generic/indirect boundary speaks
  WORD-ARITY only — a wide value (f64, stride 8) crosses BY REFERENCE, its
  address its word face (emit_wide_ref spills to a fresh cell + f64.store and
  leaves the address; emit_wide_deref cashes back via f64.load; call_ft_name
  is always $ft{arity}, the per-site repr-vector $ft DELETED as unsound at
  polymorphic sites). A wide-signatured fn — named (`scale`) OR a capturing
  lambda — reaches the fn table through a `$wf$<name>` word-face WRAPPER
  (deref args, direct-call the native body at full speed, spill the wide
  result), so a polymorphic call site never needs the callee's emission. The
  literal is born stride-8 (make_list_sc, the allocator's second face paired
  with make_list); load_strided's wide arm returns the ADDRESS, store_strided
  mem_copies stride bytes from the reference; structural == compares VALUES
  via list_eq_f64 (deref each element — the word list_eq would pointer-compare
  them), with list_compare_f64/list_hash_f64/float_to_str the ordering/hash/
  show leaves. The reach walk CONTRIBUTES the f64 family at the exact
  ==/ordering/show/hash mint sites (reach_names_expr's wide_binop_seed/
  wide_call_seed reading the operand's live type through ty_has_wide_seq) —
  the visitor-walk projection of the runtime contract the emit-side comment
  names, so a float-free module drags in nothing and the reach index's row
  widens honestly to LookupTy + EnvRead. One real emit bug fixed en route
  (§9 wrong-scratch class): emit_wide_ref used $state_tmp for its spill cell,
  clobbering the closure record a capturing lambda holds live there — the
  k-cell was then read as a fn record → indirect-call mismatch; a dedicated
  $wide_cell local closes it. TRANSITION m3 == m4 (the 6056-line m2/m3 diff
  is the emit change crossing one generation), then the re-pinned boot holds
  the CLEAN m2 == m3 fixed point. Board whole: census 0, frontier 128/0 (+4
  wide-element fixtures list/map/hof/show, RED-first where f64.const into an
  i32 slot did not even ASSEMBLE), proof-exactness 9/9, crown 5/5, micros
  green, phantom 286. Residue, named: the RI64/RF32/RV128 producers (the
  wide-ref/deref arms stand as loud floors until an i64/f32/v128 producer
  exists — the wide-element mechanism is complete, only its other reprs
  await their first values), and the visitor-walk projection swallowing the
  rest of emit_runtime_contract's static list (str_eq/list_eq/… — the wide
  family proved the pattern; the deeper dissolution is the same walk widened)
- 2026-07-21 · ▶▶ THE STRING=[BYTE] MERGE LANDS WHOLE (§4①'s biggest
  dissolution · pin dbcaca3e). String IS a stride-1 byte list, end to end:
  TString unifies with [byte] in unify_types (nullary, no alias clone, no
  mint changes; a generic element binds TByte), the physical record is the
  unified [count][tag_word][bytes@+8] (literals via the emit's 8-byte
  header; every builder through bytes_buf; io/net/json/lsp_frame/persist/
  driver/main off the +4 layout), byte_at IS list_index, `++` IS the O(1)
  concat node (strings inherit the rope; str_concat_all is the two-pass
  N-ary packer — the right-fold form stack-exhausted, measured on the first
  ladder run), str_slice IS the slice node, and the sign-bit VIEW machinery
  is DELETED (view_base → str_payload, the stride-normalizing
  materialization boundary: a rope/slice flattens, a wider-stride [byte]
  repacks, exactly where WASI demands contiguity). TByte~TInt landed as
  CHECK-LEVEL value-equality (same_ground, never a binding — forced by
  datum-last inference: map((b)=>b-32, s) types the lambda while b is FREE,
  so operator-scoped directional widening can never fire; the earlier
  "directional at the operator" ruling was internally contradictory on its
  own flagship example). The slot stays protected where slots actually
  live: reads via the carrier, writes via store_strided's 0..255 range trap
  (the bounds-trap precedent; the exit-134 fixture), construction follows
  the RESULT type, boundaries normalize stride. unify_types gained its
  missing TByte scalar arm (the catch-all had refused Byte vs Byte).
  list_to_flat split to two altitudes (table-typed [a]→[a] over flat_raw,
  the make_list/alloc_list precedent) — that ONE root was the whole
  13-entry libs-isolation shadow (iterate/reduce/unique/chunk); the shadow
  is now EMPTY. Landed via the two-stage DISPOSABLE ladder: boot compiled
  W1 (old layout + new compiler) → m2; m2 compiled the real tree →
  m3 == m4 == m5 byte-identical — m3 == m4 DIRECTLY, so the migration is
  behavior-preserving for the compiler's own computation; W1 discarded,
  zero permanent compat. The NINE-fixture behavioral battery
  (map/fold/filter/eq-concat-push/slice-index/interp/cross-stride-eq/parse/
  range-trap) joins the frontier gate — the oracle the fixpoint cannot be
  (it is structurally blind to string corruption) — RED-first under the
  pre-merge boot (15 refusals). Board whole at pin: census 0, frontier
  116/0, proof-exactness 9/9, crown 5/5, micros 72/72, phantoms 287→286.
  Residue, named: Hβ.infer.byte-narrowing-ground-discharge (compile-time
  ground 0..255 narrowing on top of the runtime trap),
  Hβ.emit.int-splice-empty (pre-existing — probed byte-equal under the
  pre-merge boot), the wide-element stride cash-outs ([Float]/[i64] ride
  the reserved sc codes), and TString's final dissolution into a pure
  alias edge under name-interning (§5.O layer 1)
- 2026-07-21 · THE STRIDE CARRIER LANDS (7db29195; the §4① substrate keystone)
  + the merge FULLY DIAGNOSED. A sequence carries its element stride in the free
  HIGH bits of its existing tag word (tag_word = sc*16 + tag; zero-biased so sc 0
  => stride 4 and every current list is byte-identical; only a byte writes sc 1).
  decode_stride/pack_tag/seq_stride/seq_tag/seq_sc/load_strided/store_strided in
  lists.mn (load_strided BRANCHES load_i8/load_i32 — no padding); stride_class in
  types.mn; alloc/list_set/index/push/concat/slice/flat_fill thread the stride;
  snoc/concat/slice nodes carry the parent's sc (self-describing). The flat leaf
  reads the stride LIVE, so a generic body over a packed sequence never assumes
  4 — the substrate that makes String=[byte] SOUND. m2==m3==m4, census 0, 72
  micros green. One real bug fixed en route: decode_stride belongs in lists.mn,
  not the type layer (the micro RTLIBS blob has no src/). The TYPE-MERGE HALF
  (unify_types String↔[byte] both arms, same_ground cross-arms, fold_strip
  TString => TList(TByte); TString STAYS NULLARY — no TAlias clone, the OOM
  dodged; no mint site changes) was BUILT then REVERTED: an 8-agent build cycle
  PROVED (binary, not theory) it is INSEPARABLE from the physical migration —
  alone it TRAPS m3, because str_eq now lowers to $list_eq => list_index_unchecked
  which reads a string's +4 CONTENT byte as a tag word (garbage => unreachable),
  first hit in env_resolve's interned-name compare while self-compiling. THE
  REMAINING ULTIMATE, sequenced (land ATOMICALLY, never the merge alone): (1) the
  physical +8 layout migration — strings become [count][pack_tag(0,1)][bytes@+8]
  (identical to a stride-1 list), ~50 raw +4 sites across strings.mn + io/net/
  lsp_frame/json/persist/driver/main + the emit_string_data/string_literal_collector
  8-byte header + emit_list_literal stride + the show byte-guard (show_subtys skips
  a TByte element's list-show helper, or "hi" renders "[104,105]"); (2) the
  DIRECTIONAL TByte→Int arithmetic coercion (Hβ.infer.seq-addr-downcast) — REQUIRED
  even for map((b)=>b-32, "abc"): list_index returns the element TByte, byte
  arithmetic needs Int, and TByte does NOT unify with TInt (the value is an Int-repr
  word, the SLOT is stride 1 — a byte-value-to-Int widening at the operator,
  result Int, preserving fold-distinguishability so a [byte] never collapses to
  stride-4 [Int]); (3) the two-stage DISPOSABLE bootstrap (no permanent compat —
  boot emits old +4 literals; W1 reads +4/emits +8 → m2 works; W2 reads +8 →
  m3==m4; re-pin; W1 discarded). The BEHAVIORAL BATTERY (map/fold/index/==/concat/
  show over real strings, output-checked) is the LOAD-BEARING gate — the fixpoint
  oracle is structurally blind to string corruption (census 0 and m3==m4 both hold
  for a byte_at-disciplined wheel while user code corrupts)
- 2026-07-20 · THE STRING=[BYTE] TYPE-MERGE SHORTCUT REFUTED (a proven
  NEGATIVE that redirects the arc; no code shipped, STEP 0 stands): a 6-agent
  adversarial ultracode pass (wf_b7ba2a2e-22c) killed the naïve `String →
  TAlias(TList(TByte))` merge on the EXACT regression band D names —
  `map(f, "hi")` TYPECHECKS (the ordinary structural `[a]`-peel binds
  a:=TByte) then CORRUPTS at runtime, because iterate_from's `xs[i]`
  (prelude.mn:53/63) compiles ONCE with its element a TVar (repr RI32) → the
  generic 4-byte-stride list_index reads a string's content-byte-4 as a tag
  and pointer-chases garbage. Emit-selection CANNOT redirect a TVar element
  (it specializes only at CONCRETE sites), and the m3==m4 oracle is BLIND (the
  wheel is byte_at-disciplined, never maps a string) — a clean E_TypeMismatch
  today becomes silent memory corruption over the whole map/fold/each surface.
  Three more confirmed: the mint enumeration was ~4× incomplete (missed
  infer.mn:4922 + the ~11 is_seq_op result-binds, so the shortcut can't even
  reach census 0), the type-merge OOM is type-node bloat (TString sentinel → a
  2-record TAlias ×instantiate-clone, NOT the ev-slot mechanism I'd cited), and
  the fold-dissolution offsets by repr_width=4 not stride_of=1. VINDICATES band
  D's representation-first / wide-elements-first sequence; the TRUE keystone is
  `Hβ.value.seq-element-stride-carrier` (a runtime stride carrier or
  monomorphization for generic-over-packed traversal), proven on WIDE elements
  BEFORE String is minted TList(TByte). The lesson is CLAUDE.md ⟲: the design
  is a hypothesis until an adversary refutes it against the artifact — this one
  died before a byte changed (§5.R band D peer sharpened in lockstep)
- 2026-07-20 · THE §4① STRING LAYER TYPES ITSELF — the expect_same root fix
  lands, no compromises (Hβ.infer.expect-same-chases-bound-var; census held 0
  the honest way). A Float POSITIONAL ctor field from an unannotated param
  (`type Box = MkBox(Float)`, `fn wrap(g) = MkBox(g)`) left `g` an unresolved
  var — expect_same, the LONE unify arm that bound a var without chasing,
  CLOBBERED the arg reference's NBound(TVar(binder)) live binding, orphaning
  the binder — so g floored to i32 and the f64 call site trapped indirect-call
  (the ctor-arg face of float-evidence-ft; it also blocked LSP serve on json's
  parse_number Float). The one-line fix (chase the var live, like every other
  arm) UNMASKED the runtime's pervasive handle-word pun, so foundational
  correctness demanded typing the string layer whole: byte_len/byte_at/str_slice/
  str_concat/view_base/the float builders are seq-ops (typed calls over
  self-consistent raw bodies, the list_index pattern); str_of_buf is the ONE
  construction boundary (§4① — a raw [len][bytes] buffer word IS a String),
  coerced at every builder's return; parse/comment functions read via byte_at/
  byte_len not raw arithmetic; state slots dedup by handle identity (i32.eq),
  not str_eq (handle_recorded — a handle is not a name). Six m2 builds drove
  the census 10 → 17 (typing byte_len alone, refuted) → 15 → 8 → 2 → 0. The LSP
  json float blocker CLEARED (serve reaches the LSP layer; hover-response is the
  next rung). TWO convergent shortcuts were built and refuted by the binary
  before the foundational path: typing byte_len as String SPREAD the census (the
  string layer is uniformly raw-Int, 104 `s + N` sites), and address-permissive
  memory ops is blocked because `s + 12` forces Int through `+`. TRANSITION
  m3 == m4 (594-line diff = the emit change crossing one generation); the
  runtime-shadow grew 2 → 13 (benign — generic prelude combinators' free element
  var surfaced in ISOLATION by the precise propagation; full wheel census 0).
  Board whole: census 0, frontier 89/0 (ctor-float-param + lsp-blocker-cleared),
  proof-exactness 9/9, crown 5/5, micros 72/72 · pin a0dd9849
- 2026-07-18 · THE RECORD-CTOR ARROW VIEW (census 101 → 73): `X({...})` — the single-variant nominal ctor in the one application syntax — met the env's RESULT binding at infer_call's chase and mismatched at 29 sites, the tail's biggest root. The arrow is a VIEW minted at the read (record_ctor_arrow_view — the identical instantiation infer_pat's RecordSchemeKind arm performs; one view two readers; the scheme stays the RESULT, one home); the saturated machinery does the rest. TRANSITION m3 == m4 · pin 8e248607
- 2026-07-18 · FIVE MORE CLASSES EXTINCT (census 185 → 101): EffectMismatch + PurityViolated to ZERO (the widen loop's fixpoint — nine rebuild-and-re-judge iterations; !-carrying declarations matched on positive parts); ResumeOutsideArm (the synth candidate fan moved INTO its arm — backtrack's try_each shape; the census was right); ConstructorArity (QRFlowLabel's second field); PatternInexhaustive (the counter was PAlt-BLIND — collect_arm_tags/arms_have_wildcard now flatten alternation branches; voice's two H6 matches were exhaustive all along). register_one_variant's refutable let-destructure became its match; unlock_capability gained AWrapHandler→CSandbox; dead lib/runtime/buffer.mn DELETED whole (zero consumers, three findings one deletion) · pins 0f3d4f17, bfc576f2
- 2026-07-18 · THE ADDRESS IS THE SURFACE (census 213 → 185; frontier 71/0): `mentl voice.mn:9` answers `Query: echo(mix, x) : Float` — README §9's smallest transport, real. VAt at the argv boundary; driver_entry_with_ranges returns the module-range map from the concatenation fold that always computed it; the three-case line rule resolves over the span index every node writes at birth; cursor_at_handle (new CursorRead op; the eight-arm fan extracted to one cursor_view_of) projects without re-resolving; the facet-silent render reads source slices, env schemes, literal bodies, and the Why walk mapped to file:line — every lede a live read. propose_at is the ABSENCE facet structurally (authored_hole, the patch gate's own read) — which also fenced Hβ.emit.float-evidence-ft (an f64-arg candidate ctor through an all-i32 $ft, trapping the first float-position enumeration ever taken). The session's exact-reason-span resolver SURVIVES as the documented live-generation crutch (measured: mint-span find_tightest resolved a stale generation, 13 edit fixtures red at once; dissolves with session-weave-epoch-scope). Remaining README-Why substrate named: why-flow-naming (FnParam-at-call), refinement-provenance · pin 6e7c10b2
- 2026-07-18 · THE EFFECT-TRUTH SWEEP, ROUNDS 1+2 (census 301 → 213 → 185 across the arc): the census-spec fleet (29 per-file readers) produced exact specs for 192 sites; 148 + ~55 cascade widens applied — declared rows to the bodies' truth, aspirational Pure dropped for the honest Memory/Alloc, missing match arms written with real payload arities, LStateSlotStore's fourth field bound. The re-pinned sharper compiler re-judged its own source each round (the ++-carries-row precedent at scale) · pins 01ccaa3a, intermediate
- 2026-07-18 · TWO CHECKER ROOTS (census 343 → 301): E_IfMissingElse EXTINCT — the unit test matched TName("Unit"), a spelling the inferencer never produces (real unit is TUnit; probe: then_ty=() at all 25 sites) + 6 unresolved op-results the unify below decides. E_FeedbackNoContext EXTINCT — the check read the COMPILER'S runtime handler stack while inferring the COMPILED program's structure (a category error firing on every real `<~`, SYNTAX's canonical lowpass included); the compile-time class fact is the named peer Hβ.effects.iterate-class-declaration · pin 57a2113e
- 2026-07-19 · THE ULTRACODE BATCH — COLUMN 2 CLOSES (recon fleet + four
  isolated builders, transplanted by hand, marched serially): R3 the
  ground-decidable arithmetic fragment (PWithSelf binder, litval_arith,
  proven-false REFUSES; frontier fixtures RED-first) · the generative
  self-test loop (four real bugs on run one — the proven-fill zero-divisor
  is §1 executable; a failing case reduced 842B→131B; the CHANGED detector
  caught a banked case graduating) · the LSP transport runs the frontend (didOpen →
  driver_check; the serve chain carries the analysis handlers; the
  serve wire's pinned blocker = the FOURTH float-evidence hit) · the
  CFC pipeline's first pass (cos/sqrt/atan2; single-bin windowed DFT;
  MVL comodulogram finds the planted (6,40), peak/median 5.93 matching
  the numpy oracle; read_recording = the real-file transport). Census
  0 and m2 == m3 at every pin; frontier 77→84→86/0 across the merges
- 2026-07-18 · ▶▶▶ CENSUS ZERO (73 → 0 in one day; 2,266 three days prior):
  the medium's verdict on its own source is CLEAN, and the ratchet holds
  zero. After the five-pin tail (below), the last three roots: EVERY
  APPLICATION STAGES ITS BOUNDARY (the seq-op fast path skipped
  stage_continuation_boundary — lower's k2 crossing found NoBoundary at
  four sites, pinned by an epoch-field probe; E_UnresolvedType extinct) ·
  NRecordRowBound (the record-row residual's own node kind; NRowBound
  EffRow-only; occurs_in_row total over six row forms; the Ty-wrap mint
  deleted; ten mirror arms) · slot_present (the niche's READ half — the
  presence test table-typed `a -> Bool`, never pinning a slot's element).
  Every gate green at the pin: fixed point, frontier 71/0,
  proof-exactness 9/9, crown 5/5, micros-through-m2 72/0
- 2026-07-18 · THE TYPEMISMATCH TAIL FELLED (census 73 → 6, five pins; the
  eight-interrogations charge): the seq-op HOLE guard (a `??` argument no
  longer counts toward saturation — the Stage-Law partial mints; 14) + the
  `<~` RECURRENCE prior ((prev)=>body applies to its own result, RHS checked
  against FeedbackSpec; 14) · THE KIND IS THE NAMESPACE (env_lookup_type — a
  type-position read filters the env by kind, so `effect Sample` no longer
  shadows `type Sample`; quantify_ctor_ty is the one reader; 15) · A BUCKET
  IS A LIST THAT STARTS EMPTY (list_filled mints the four hash indexes with
  one shared []; every `if x == 0 {[]}` guard + env_bucket_at DELETED;
  eff_names_of's null guard out with its extinct class; 14) · THE BOUNDARY
  MADE NAMEABLE (alloc_list/slice_raw = the RAW altitude's own names, so raw
  walks stop calling table-typed names; int_to_str joins the table's String
  face; `-> !` PARSES — TBang arm + per-occurrence bottom var, abort()
  finally never-returns; verify_candidate takes Candidate, LPLit's emit arm
  matches LowValue, HandlerDeclStmt/LHandleWith/drain_string_literals
  declare their real elements, seq_force admits TString under a TList force
  — len on a String is canonical; 12) · THE DIAGNOSTIC LEARNS ITS ADDRESS
  (all eight E_UnresolvedType reports read the node's weave span; the four
  became locatable and named their one root, the `&&` boundary-weave thunk
  row; the escaping family speaks name-sets end to end). Clean fixed points
  + two TRANSITIONs; every gate green at each pin
- 2026-07-18 · THE INDEX LAW IS REAL (census 348 → 343): SYNTAX §Indexing's "traps on out-of-range" was prose — list_index tag-0 raw-loaded, every OOB a silent adjacent-memory read (the panel's find). The checked entry landed with its structural prerequisite: `&&`/`||` SHORT-CIRCUIT (lower's BKBool arm; the boolean verbs are control — SYNTAX gains the sentence). The eager i32.and had run every guarded read: set_insert / cache_filter_loop / register_one_variant all read one-past under their own guards (nullary ctors probed index 0 of EMPTY payload lists on every ADT ever inferred) — three latent OOBs in the trap's first hour. Then the trap swept the DRIVERLESS-CHAIN class: check / check_source / edit / repl ran infer's consume+region ops with NO analysis handlers installed — zero state records reading the sentinel page as empty ledgers since the chains were born; all four now install affine_ledger + region_tracker. Dead narrowing-elision write deleted (never fired — PAnd left-descent to PTrue; unsound if activated); the discharge-gated write is the named peer. micro oob-traps=134. TRANSITION m3 == m4, then clean fixed points · pin 3112cec5
- 2026-07-18 · THE VALUE CLASSES ARM (census 348 held; frontier 69/0): diag_refuses gains ERefinementRejected (the §11 "landed and locked" claim was FALSE — a decidable-false `let bad: Sample = 1.5` emitted 2,513 bytes at exit 0) and EOwnershipViolation (its unresolved-callee false channel dead; the adversarial panel could not falsify the detector on resolved programs). node_const folds negated literals so the canonical Sample range DECIDES — and the sharper compiler caught the wheel fabricating tag -1 into TagId's 0..255 (lower_pat's unresolved-ctor arm): deleted into LPUnresolvedCon (match test honestly false, sub-binders declare at the word floor, the dead arm assembles). The dormant mn-refine-reject micro (asserting pre-arm exit-0, wired to nothing) superseded by frontier refusal fixtures; the handler-forward-ref regression added. m2==m3 clean fixed point · pin 01d77f31
- 2026-07-18 · ONE MISS, ONE DIAGNOSTIC + THE HANDLER-NAMESPACE REFUSALS (census 352 → 348): the env-miss path bound TVar(self) — tripping graph_bind's own occurs check (a spurious 0:0 E_OccursCheck per missing name) and reading downstream as an unconstrained var (the ownership move-default cascade the panel proved). It now binds NErrorHole via the new graph_bind_hole op; an unresolved VarRef callee borrows its direct args; the occurs check reads its span from the bind's Located reason. Two classes born ARMED at the decl site: E_HandlerStateShadowsOp (a state field naming an op of its handled effect compiled clean and returned the WRONG value; the medium's own m3 leg caught the second wheel violation, `caret`, the hour the check landed) and E_DuplicateFnName. Voice state fields renamed turns/caret_now; the code-dead duplicate FeedbackSpec deleted (silently shared tag ids with prelude's Delay/Accumulate/FilterSpec — the duplicate-TYPE decl refusal is the named peer Hβ.infer.type-decl-name-registry, repro banked). E_MissingVariable/E_OccursCheck reach wheel-zero but do NOT arm (the licence correction). Frontier gains run_refusal. m2==m3 · pin d6dd8ed9
- 2026-07-18 · THE SMT HANDLER TELLS THE TRUTH (census 356 → 352): verify_smt declared only `witnesses` while its arms update and read `debt` — the unknown-debt ledger never existed as state (2 E_MissingVariable + 2 paired E_OccursCheck). `debt = []` is the whole fell. Same commit: solver polarity (validity = UNSAT of the negation; SmtSat now returns a COUNTEREXAMPLE with the rejection, never proof-evidence — predicate_decide short-circuits ground predicates so the solver only sees open ones); node_to_predicate's missing BNe arm (`self != 0` fell to opaque PBoolNode and accrued debt instead of deciding); show_pred_operand's `<expr>` fabrication on compound operands (the refinement's own -1.0 bound rendered as `<expr>` in the diagnostic that exists to teach it — UnaryOp/BinOp render recursively). m2==m3 · pin 45244e15
- 2026-07-18 · A HANDLER'S IDENTITY IS A PARSED FACT (pre_register_handler_sig; census 578 → 356): `pre_register_stmt` registered FnStmt, TypeDefStmt, EffectDeclStmt but not HandlerDeclStmt — handlers entered the env only at the main walk's `register_handler`, so every `~> handler_name` before the handler's declaration in source order (115 sites) floored E_MissingVariable. The handler's identity (effect, instance type, config, residual row, HandlerKind) reads only parsed structure and the effect env (already registered by EffectDeclStmt). Moving the identity registration to pre_register makes handler names resolve order-independently; the main walk reads the pre-registered r_handle from the env so forward references share the same residual row handle. E_MissingVariable 115→4, E_OccursCheck 115→4. Clean m3==m4 TRANSITION, pin 8bf740a4
- 2026-07-17 · A BORROWING PARAMETER BORROWS (move-vs-borrow part 3; census 582 → 578): CallExpr previously inferred every argument before reading the callee's parameter product, so an owned value passed to `observe(ref value)` consumed exactly like one passed to `take(own value)`. The call now reads the canonical TParam product after labeled/default resolution: a direct VarRef passed to authored or inferred Ref enters the existing borrow scope; Own parameters and nested computations keep their normal move inference. `len` / `list_index` declare the read-only access their bodies prove; update_file_text_loop carries list_set's returned owner. E_OwnershipViolation 4→0, while the real `take(value) + take(value)` double move remains rejected. Carried-Truth: the callee product already owns the access mode; the call re-derived a move. Clean m2==m3 fixed point, pin 361ed16c. RED-first: mn-own-call-arg-borrow + mn-own-forward-ref-seq; negative control: mn-own-call-arg-move; frontier 63/0
- 2026-07-17 · A READ IS A BORROW (move-vs-borrow, census 615 → 582): an `if` condition / `match` scrutinee / a `.field` receiver is READ, never moved, so an `own` value used there is a borrow. A borrow_depth counter on affine_ledger + borrow_enter/borrow_exit bracket the condition, the scrutinee, and a value-chain field receiver (`f(x).field` keeps its normal move of `x`); consume no-ops inside. Cleared 33 of 37 with soundness intact (a real `(take(buf), take(buf))` double-move to two `own` params still caught). Two clean m2==m3 transitions, pin 1e06cdaa. Residue (4, all graph/voice): the call-arg-borrow — `len(nodes)` then `list_copy_into(nodes)`, an `own` value passed to a BORROWING param; the last piece reads the callee's param ownership at each argument
- 2026-07-17 · THE AFFINE MODEL STOPS FIGHTING SAFE CODE (`Hβ.infer.usage-grade-unifies-cardinality-ownership` — the branch + scope halves; census 727 → 615): 115 of 152 `E_OwnershipViolation` "consumed twice" were false positives — the medium stricter than Rust on provably-safe code, the inverse of §4⑤'s Hylo-quiet bar. Two masked bugs. (1) `if`/`match` arms were never bracketed, so an `own` value read in both arms of `if i<0 {slice(buf)} else {list_set(buf)}` counted twice — but arms are ALTERNATIVES (one runs). A `BranchMode` ADT (BParallel | BAlternative) rides the branch frame; branch_exit collides only for BParallel (`><`/`<|`), unions for BAlternative (if/match). (2) affine_ledger installed ONCE at the pipeline, not per body — a name consumed in one fn stayed `used` and collided in the next naming the same `own` param (`buf`/`acc`, the dominant shape); consume_enter_fn/consume_exit_fn bracket each infer_fn body (fresh scope, restored on exit, re-entrant). Carried-Truth: the graph knows a branch is an alternative and a body is a scope. `><`/`<|` collision path unchanged (crown + micros green). Emit grew → clean m2==m3 TRANSITION, pin 6d693a87. RED-first: tests/frontier/mn-own-alternative-branches.mn. E_IfMissingElse 29→32 = latent errors the ownership false-positives had masked (total still fell). Residue (37): move-vs-borrow-by-callee — an `own` read in an `if` condition or a field is a BORROW
- 2026-07-17 · STAGE 1 — the bare-parameterized-type-arity class felled (`Hβ.infer.bare-parameterized-type-arity`, census 874 → 727): the `0 vs 1` arity mismatches were one shape, one type over from Stage 1a's bare `List` — a bare parameterized type (mostly `Option`) written without its argument in a declaration, meeting the real `Option(X)`/`List(X)` its consumers build. The root was `env_lookup(String) -> Option` (types.mn): the effect op erased the `Option((Scheme, Reason, SchemeKind))` its own handler proves via env_resolve, so every env_lookup match site mismatched. Swept its siblings too — the Annotation ctors (`Option(Span)`), the teach/CursorView gradient field (`Option(AnnotationSuggestion)`), PList/LPList rest (`Option(String)`), gradient_pop/step (`Option(Cursor)`), inf_arm_tys (`Option(Int)`), ls_escaping_of (`Option(EffRow)`), the Situation/TopicFacts record fields, the Lsp response ctors, Explanation's fix (`Option(Patch)`), QRHandlerProvider (`Option(String)`), tree_list (`[TreeEntry]`), NonEmptyList (`[a]`), QRIntent's tuple. Carried-Truth: each consumer/handler proves the type the declaration erased. Pure declaration fix — emit byte-identical, boot UNCHANGED, so no re-pin; the census ratchet is the gate. Residue: `Buffer` → `Buffer(a)` (genuinely generic, named)
- 2026-07-17 · STAGE 1 — the census's biggest root felled (`Hβ.infer.alias-preserving-unify`, census 1233 → 874): the 362 `Span vs ValidSpan` / `Int vs ValidOffset` errors were ONE forward-reference bug. `pre_register_decls` ran a single source-order pass, so a fn signature quantified before its refined alias was declared (parser.mn's `span: ValidSpan` precedes types.mn, last in the concatenated wheel) baked a bare nominal `TName` the main walk could never refine — `unify(bare-TName, base)` floored at the leaf. Fix (`pre_register_alias`): register alias edges in a phase BEFORE any fn signature, so `quantify_ctor_ty` reads the LIVE edge (Carried-Truth: the graph drew the alias; the resolver re-derived a name). My own banked "a two-pass is a no-op / ruled out" was the drift — measured against BOOT's census, not the fixed compiler's (⟲: a label is a hypothesis until the artifact confirms it, the verifier included). Emit byte-identical → clean m2==m3 fixed point; boot re-pinned (wheel-neutral yet tool-changing) `5e9ec2d6…`. RED-first gate: tests/frontier/mn-refined-alias-forward-ref.mn (fails `Pos vs Int` on the old boot, runs 42 on this one; frontier 50→53)
- 2026-07-17 · STAGE 4 — the surface parses its own canonical form (`Hβ.parser.refined-alias-nonatomic-base`): `parse_type_decl` probed only `p2+1` for `where`, so a multi-token base (`[Int]`) hid it — SYNTAX:990's own `type NonEmpty = [a] where len(self) > 0` did not parse. Fix parses the whole base first, then branches. Wheel-neutral (m2==m3 byte-identical) yet tool-changing, so boot re-pinned `ab34a853…`; guarded by tests/frontier/mn-refined-alias-nonatomic.mn (frontier 47→50) — tooling improved WITH the medium
- 2026-07-17 · STAGE 1a — the census's largest root felled: a bare `List` in a declaration is the nominal `TName("List",[])` that never unifies with the native `TList` consumers build (SYNTAX §4① — one sequence kind `[a]`); the fix is `[Element]` at the declaration, read live from the consumer, never a TName↔TList unify bridge (which would legitimize the illegal shape while leaving the element erased). Core ADTs (Ty/Node/Pat/LowExpr/LowPat/LowFn/Scheme/EffRow) + the shared handler-arm/state-field records (also cleared `N vs Node` 14→0) + the leaf ADTs and effect-op sigs. Census 2266 → 1233 (true bare-List shape 645+ → 6, residue = the dead buffer.mn); inference-only, m2==m3 byte-identical, zero new classes — af8a9189+ef0030b1. Stage 2a (`Hβ.infer.seq-op-row-from-callee`) built + marched + REVERTED: correct but DEP-gated on §5.O per-decl-arena (the Alloc attribution's ev-slot emit tips the 4GB bump image → m3 OOM; §11 col 2)
- 2026-07-16 · BARE MENTL PROJECTS WHERE YOU ARE: the tty fork (fd_fdstat_get), the directory projection (fd_readdir), verb_catalog one-string-two-surfaces, mentl help; a two-rung transition ladder; §11 rescoped (MI300X = the last arc, not required) + the named-peer audit (four verdicts) — 80215c38 · pin e2babb24
- 2026-07-16 · MENTL RUNS FROM ANYWHERE (§11 col 1): install shim = a POINTER to the live boot; resolver chain + /mentl-home guest path; fs_at (the preopen table IS the mount table — longest-prefix, fd_prestat_dir_name); prelude declares its imports (the manifest); driver_compile_entry = the one-namespace DAG concatenation. Temp-dir matrix: run=42, hole refuses · pin 26bfe90a
- 2026-07-16 · §7 → this ledger; PROVENANCE compacted; archaeology banners; tools/state.sh = THE BOARD; §11 THE PRODUCTION BAR authored — a09026c, f6ed08c
- 2026-07-16 · regions live: fn body = region, return = TRANSFER; Hylo-quiet on the wheel (0 escapes) — 82a7e42 · pin 94e449dc
- 2026-07-16 · region tag speaks truth: `.region_id` read offset-0 (handle-as-region) pinned in binary; tuple tag — e887bde · pin 4b7f998f; board 47/0
- 2026-07-16 · executable gate: holes REFUSE (E_UnresolvedHole, exit 1, zero WAT), honest V_Pending SURFACES and runs; refinement ledger truth (4 raw-pred wrapper verifies deleted, call-arg discharge = R2's third site, typed-identity stops echo, decl-site schema verify deleted) — 10999e6 · pin 701c7024; proof-exactness 9/9
- 2026-07-16 · NFree per-read report deleted (a free var is a legal quantified param — generalize's own Forall); census 31,546→2,984, fleet-converged — 9611c52 · pin cf479f9d
- 2026-07-16 · partial application is a value: `add3(10, ??, 30)` mints its lambda, runs 42 (was trap 134); pipe fork-free via lower_call_dispatch — 40ad601
- 2026-07-16 · capability tie fixture: two proven survivors refuse the guess — bf0257f
- 2026-07-16 · capability `??` workflow green (row prunes, rejections teach) + the let-statement bind (census 34,028→31,414) — 54c403dd+8fd0358b · pin c323a40f
- 2026-07-16 · positive `??` workflow green end to end (hole→survivor→Reason→patch→run) — 1255a76 · pin 7b188a31
- 2026-07-16 · felt route lives: `mentl edit` reaches the eight-aspect CursorView; CursorRead/PatchWrite naming — bdec460 · pin 9c8b23ba
- 2026-07-16 · inference-owned executable boundaries (TCont R/S, boundary weave, one-field carrier) + the pattern-constraint law (constrain_scrutinee, ~4,400 diagnostics resolved); frontier gate battery born — cf00697→fede003 · pin 7bd9e3e7
- 2026-07-14 · value-proof R2 landed (parse_let carried the annotation; subst_self at infer_pat: `let bad: Sample = 1.5` REJECTS) + string-interner O(1) — 730dfe8+9feb727
- 2026-07-14 · crown positive gate largely sound: pointer-eq at name_set_contains, by-name fix 598→146 false mismatches, −16k emitted lines — cc487f8 · pin 8a5d8ff7 (m3==m4)
- 2026-07-14 · felt CLI connected: argv wire + verb dispatch (compile/check/audit/teach/query WORK; six latent bugs rooted) — 91755d6+f1b13e2 · pins bea3692b, c4bdba19
- 2026-07-14 · destiny audit (8-subsystem, artifact-grounded): machinery real / wiring absent; the R1–R6 path — git history: docs/research/destiny-audit-2026-07-14.md
- 2026-07-13→14 · THE PERF LOOP, seven iterations, 1400s→10s (~140×): classifier summary-index (→749s) · region tracker handle-index (→490s) · esc write-index (→226s) · esc read-index (→56s) · reachability index + LSuspend garbage-Int root (→13s, TRANSITION · pin 349a3302) · iterate flattens once (→10s). Lesson: perf the artifact, never the estimate (the 8-agent code-read missed every dominant cost)
- 2026-07-13 · THE CROWN's negation gate landed: row_subsumes EfNeg by-name; 5/5 crucibles (tests/crown/) — 29df478
- 2026-07-13 · M4 the Abandon discipline self-hosted (4th ResumeDiscipline; deaden after diverge; option-protocol 0→42) · pin 67e44c9c (m3==m4)
- 2026-07-12 · M3 THE CUT: classifier fixpoint, choose+enumerate_inhabitants flip MultiShot, k gates enter baseline (52→66), evidence FENCE at fn-frame boundaries · pin ac204467 (m3==m4)
- 2026-07-12 · M2 nested-choose (redrive at resume boundary; hole-set reifier kills the diagonal) + UZero ratchets + A4 refuted (2 silent-wrong-value bugs found+fixed: S1 wrong-record state home, S2 driverless install crossing)
- 2026-07-11 · k1 CONTINUATION REIFICATION landed self-confirmed (mn-multishot=30 via a real k record) — 1746a87; M1.1–M1.6 the mechanism arc (world-tag homomorphism, composer pair, k2 boundary, args packet, state-commit, resolution ladder), six fixpoints in one day; k2/k3 design bank twice-refuted — 287521d
- 2026-07-11 · THE PIVOT: the AST desugar refuted (intent lost, resume≠restart, micro-only) — continuation-reification codegen named the true keystone; IDE grows its five surfaces — 73d21df
- 2026-07-10 · ▶▶▶▶▶ FIRST LIGHT: m3 == m4 byte-identical + battery green through m3 — 87c0152, tag `first-light`. Final cut: the pattern-string intern (284-fn eq-dispatch flip class)
- 2026-07-10 · the boot era: seed DELETED (7401c4b "Fly, my pretty <3"), boot/mentl.wasm IS the compiler, march.sh the ratchet; ide/ born (the fixpoint compiler in-browser, served by serve.mn) — 77da34d+b72590d
- 2026-07-10 · the summit: m4 first exists; emit_float_const forward-ref pin, variant alloc = width-summed fold (every float lexed collapsed to 0.0), interpolation source-order (204k→2.7k diff)
- 2026-07-09 · the 4096-byte lexer cut: raw-TName annotations vs the alias edge (pre_register alias arms; quantify_ctor_ty env resolve) — f320f97; evidence-tail LSuspend.tail (2158c4e); concat-floor class EXTINCT 14→0 (bare-List decls; render family str_concat by name; float e308 lex root) — 581a92f+c595cc5; reach OOB = 2GB memory preamble, not corruption — 2fc7544
- 2026-07-08 · result()->r: infer_seq_op's FUNCTOR arms dissolved (NOT the path — the ledger overclaimed; `fn infer_seq_op` is live at infer.mn:1040 and still hardcodes a row, `Hβ.infer.seq-op-row-from-callee` §11); multi-payload effect instances position-wise (TName carry); occurs-check completion (the hang WAS productive-under-error failing) — 7adada9; emit-diff.py banked (the divergence pinner)
- 2026-07-07 · the singleton dispatch tier (op→handler edge; ev_perform_entry 6401→4209); reachability==emission (dcac3b8); the f64 census SEVEN roots (capture-shadowing inversion killing let-poly; fabrication sentinels→TVar(h); float render off-by-start; ft traversal orders; binder widths; WASI widths as data; Int/Float lies) — e7b4623→e44afd9; m3 ASSEMBLES AND RUNS first time (local_wat_name = (name, repr) projection)
- 2026-07-05→06 · `handle` de-keyworded (the medium's noun vs its lexer, 106 lost binders) — 55e60de; union_row TOTAL over six row forms (the 99%-wall infinite loop); nominal-record ctor identity — 4cdd820; Handle collision → ThreadHandle; assembly-ladder faces 8–22 (slice-of-slice, PAlt, rest-wild presence, wasi dedup, `<|` thunk capture, `$_` positional); undefined-ref ladder closed — 4e3faa7
- 2026-07-01→04 · the m2 march: pipe = hole-completion BOTH layers (prepend convention deleted — the whole m2 trap zoo); `??` parses/types/lowers; the 8/8 rung day (nine bands, the raw-0 root b73748c: union_row's ++ emitted str_concat via h=0 binders); the wheel's evidence-passing call convention decoded (the sst_ clone); phase 1 closed 0/34→34/34 (plans/noble-brewing-rose.md)
- 2026-06-22→28 · the value layer: STEP 0–5 landed (repr_of · gradient · fold eq-leaf · multishot producer record · PFanout collapse · TCont keystone); the e-graph live in lower; the whole AST into the one graph (the fabric); SYNTAX to ultimate form
- 2026-06-18→23 · the reframe + the three-doc consolidation; the crown's EfOpen~EfNeg unify (b4b1989); the handler registry dissolved into the live read

### Named-residue index (entry-born peers not yet in a §5.R band — one home each)

`Hβ.effects.directional-fn-row-edge` — RESOLVED at its measured scope
(2026-07-30, pin cd43c23c — the §7 entry THE QUIET FN FITS UNDER THE
CAP carries the record: the positional pre-meet at
infer_call_saturated, row_cap_form as the cap/flow boundary the
297-site census taught, the admit leg registered at frontier 324).
The remaining tail is nested variance (a fn-arg's own fn-params flip
direction again) — out of scope by the original sequencing, the
symmetric meet standing there.

`Hβ.verify.interval-fragment` — ENGINE HALF LANDED (2026-07-30, pin
a71ebbcb — the §7 entry THE INTERVAL FRAGMENT AND THE FLOW LICENCE
carries the record: the two-face lower-bound read in verify.mn, the
value_flows_class licence closing the measured arith-class launder,
the mn-verify-interval fixture + frontier leg, arm row unchanged).
THE CALLEE LEG LANDED same day (pin 5e34f710 — an authored return
rides the pre-registered TFun as a Ty VALUE, so a call's bound reads
the callee's annotation verbatim, uncontaminatable by class merging;
the wrap/base fixture faces prove it; TRANSITION m3 == m4). THE
SELF-CALL IH IS BLOCKED BY THE PEEL, measured (2026-07-30 probe
census, disposable build): at decide time the rec-callee's chased
TFun ret is the PEELED TInt or a TVar (8 tint + 4 tvar across the
fixture's callee/operand reads; the 5 callee reads all reach the
TFun arm) — the value-ret survives the pre-registration but the
class the rec-call actually resolves carries the peeled base, and
the peel reaches PARAM classes too (a comparison's ground unify
re-peels `i: Nat` to TInt), so any class-based IH read fights
nondeterministic representative choice. Two prior discriminator
specs REFUTED in the same dig: class-vs-DECL identity (a top-level
rec-call instantiates a copy — never the decl's class) and the
peel-window reorder (the rebind-first form re-opens the flow-echo
launder). The arc REDIRECTS: the IH lands either on the peel's own
fix (the most-refined representative surviving comparison unifies
and the publish fold — the rebind law completed at every unify, not
just the decl pin) or on Hβ.infer.schemes-are-edges (whose deletion
of the publish/peel/rebind tower dissolves the question). Until
then seek-shaped recursion pends honestly — visible debt, the
system's contract. THE OTHER HALF stays live: the wheel's six
standing `0 <= self` pendings (cursor:297 score_one_position's
handle param · cursor:546 scan_for_span's return · lexer:229's
lex_from arg · main:1272/1437's ph flows · voice:1097's
resolve_cursor_target) discharge via authored refined annotations
whose echo/interval/callee legs the engine honors — one-line
annotations, march-measured each; the recursion-shaped ones
(scan_for_span) wait on the IH. TagId's 0..255 and the float
intervals stay the SMT tier's.

`Hβ.graph.reverse-edge-and-bound-projection` — oracle.mn's two
surviving iteration convictions, named at their true form (2026-07-30).
`count_dependents` walks ALL handles asking "does this body reference
pos?" — a REVERSE-EDGE query answered by scanning forward edges, O(graph)
per position and quadratic across the candidate set; `collect_bound_positions`
walks all handles collecting the NBound ones — a graph projection written
as a range scan. Neither wants a materialized range (that is worse than
the loop at graph scale): the self-form is the graph answering directly —
the reverse edge read through the same use-edge channel `refs_of_name`
already collects, and bound-cell enumeration as a projection over minted
cells. Iteration-is-topology's tier-2/tier-4 case (a cycle or a read,
never an index), and the payoff is complexity, not idiom.

`Hβ.audit.capability-carries-its-evidence` — the severance teaching's
remainder (named 2026-07-30 with the vocabulary's graph read). The
vocabulary is live now; the capability MAP still names three effects,
and it cannot simply grow because a Capability is a nullary tag whose
render bakes its evidence: CSandbox renders "proven no network access",
so mapping WASI or Filesystem to it would misspeak the proof. The
self-form is the capability carrying WHICH severance discharged it —
`CSandbox(ename)` or a (capability, evidence) pair read from the row —
after which the map extends by construction over every declared effect
(a real-time consumer wants !Mutate and !Thread named; a sandboxed one
wants !WASI and !Filesystem). Cheap once the evidence rides; the
render is the whole design question.

`Hβ.wheel.iteration-is-topology` — the recursion eradication (named
2026-07-30, Morgan's interrogation; the ledger entry ITERATION IS
TOPOLOGY carries the law and the census). The wheel's 390
index-threaded self-calls (the audit's iteration-shape tier is the
standing census instrument) migrate per family toward the medium's own
iteration stack — derived folds / each / iterate for structural walks,
<~ for genuine cycles, driver-resumption for search — each family
march-arbitrated, the tier's count the ratchet. Sequenced WITH
`Hβ.infer.schemes-are-edges` (below): every name-cycle drained is
tower the deletion no longer needs; the wheel's own SCCs (unify, the
parser) are structural folds over Ty/Token written as mutual
recursion, and their migration is the deletion's steepest lever. The
named residual: recursion that survives is sig-priced (the
signature-price law generalized — the price of name-keyed recursion,
period).

`Hβ.infer.schemes-are-edges` — THE MENTL WAY for the judgment (named
2026-07-30, Morgan's question "is there a better way — a more Mentl
way?" answered at the root): the entire convergence tower — trial /
rounds / cone / fingerprints / the bound / the freeze law / the
declared-row pins / the attractor dances — is ONE compensation for
published schemes being SNAPSHOTS read by name while everything else
in the medium is an EDGE read live. The rounds manually iterate what
the union-find propagates transitively for free; the freeze exists
because live cells raced under the fan; the races were SOLVED for
rows by making the write a commutative JOIN (the lattice landing,
order-free at K=8). The form: publishes as live graph cells whose
teaching is a join, polymorphism as instantiation FLOW-EDGES read
through the union-find (the banked polymorphism-as-flow-edges design
— generalize/instantiate/subst dissolve; the unpatchability theorem's
own prescription: swap the representation behind the projections).
Convergence stops being iterated and becomes what the graph
structurally IS; the tower deletes. Tonight's symptom catalog is the
requirements list, measured: the parity-selected attractors, the
prereg-vs-final entry races, the open-tail subtraction carriers, the
type-half flip surviving a fully-pinned row, the marginal
schedule-variance at the 11/12 boundary. A full-context session's
arc — the biggest single deletion on the board.

`Hβ.infer.round-oscillation-movers` — ESCALATED TO THE ACTIVE BLOCKER
(2026-07-30, third victim): the Pure predicate-fn UNFOLD was built
whole (332-line patch banked in the session scratchpad — the binder
env absorbing the self special-case into node_const_env, the bool/
match evaluator over litval, the body lookup through the env's
Located reason + the span log, the Pure-row gate, the one-level
PBoolNode hook) and its row widens flipped main's row to carry a
phantom Intern no spine component performs — the same
parts-don't-sum signature as the 2026-07-29 relocations and the
2-cycle-cut probe. Row-perturbing engine work in verify/infer now
GAMBLES the attractor every time; the oscillation root outranks every
queued increment until fixed. The dig's standing instruments: the
movers/flip channels, the Pure-pin row-printing bisection, the scc2
trace. (2026-07-29; DUG 2026-07-30 — the
pin-78b1736b landing carries the arc): the "oscillation" was a MONOTONE
resolution front, and three of its four roots are CLOSED (the
fingerprint's set-order fabrication; the backward-only layer walk; the
source-order trial). The REMAINDER, measured by the graduated flip
instrument (movers_diff + probe_tail_why, now the bound-hit's standing
diagnosis channel): the unify/parser SCC chain — within a
mutual-recursion cycle, member B reads co-member A's PREVIOUS-round
final across the cycle's stale link, so an SCC's closure crawls its
internal diameter one round per link; the bound still cuts at ONE
mover (parse_effect_list_from, 2026-07-30), and the daily-verb tax
(~59s field read) is round-count × the per-round FIXED costs (full
re-parse + classify_fixpoint + round_prints — cone-independent). THE
FIX (re-specified twice on 2026-07-30, each by a measured kill — the
pin-5db9b4c3 and no-pin ledger entries carry both): the Tarjan SCC
substrate is LANDED (scc_groups; the trial walks groups
callee-first); classic GHC mono-binding-groups are REFUTED (29 wheel
convictions — the wheel's cycles use polymorphic intra-group
instantiation); and bare per-SCC re-derivation iteration is REFUTED
(rollback-as-fresh-nodes works — simple pairs converge in two probes
— but generic/concrete-tension families ALTERNATE with period 2
forever: re-derivation-from-scratch is not monotone, exactly Salsa's
cycle-recovery contract). THE THIRD COUNTED KILL (2026-07-30,
Morgan's vet — "re-judge? re-infer? re-derive?" — the build reverted
uncommitted): the iteration WITH the generality join was built whole
(ty_join — concrete-over-free pointwise widening preserving cur's
linkage, rows through row_join; closed freezes
Forall(free_in_ty(chase_deep(t)), t) inert across rollback; the join
operating on instantiate(prev) vs instantiate(cur) so no
cross-generation handle ever mixes; all-fn groups only) and the
artifact refuted it on its own terms: TRANSITION m3 == m4 at 355,307
lines with census 0 — a self-stable attractor — but the ONE bound-hit
mover (parse_effect_list_from) SURVIVED untouched (its flip lives in
the rounds' own re-derivation, outside the trial's groups) while the
attractor moved 107,432 emission lines with nothing arbitrating the
move as better. Cost without cure — and the deeper conviction is the
DIRECTION: probes that re-judge, freezes that snapshot, joins over
re-derivations are the tower growing, the exact compensation
machinery `Hβ.infer.schemes-are-edges` already names as the thing to
DELETE. Carried-Truth at architecture scale: the fix for
schemes-read-stale is never a better re-derivation cadence — it is
schemes as live join-written cells the union-find propagates through.
THE ARC REDIRECTS THERE, terminally: this peer's remaining content is
absorbed into `Hβ.infer.schemes-are-edges` (the tower deletion), and
no further tower machinery lands. Until that arc: the bound cuts at
one mover, emission stable (measured across runs), and the
position-sensitivity hazard stays narrowed to the SCC chains.

`Hβ.emit.arm-closure-captures-record` RESOLVED: LANDED (2026-07-24, pin
bb4b870e — the ledger head carries the arc). The capture form won over
the $world_find read exactly as this entry ruled, and for a soundness
reason the ruling had not yet named: a commit targets its own install's
record — a LEXICAL fact — while a chain walk under a rebound redrive
world could resolve a same-named NESTED install's record instead. The
__hrec ladder (LLet alias / seeded capture / trailing param) carries
the record everywhere; the global, the bracket triple, and the
singleton_hnames walk family are deleted; the OneShot-in-thunk cousin
(20-not-25, silently wrong on the prior pin) died in the same landing.

`Hβ.cli.infer-context-bracket` RESOLVED: LANDED (2026-07-23, pin 2644dab5 —
the R5 entry in the ledger; the arc: refuted by the mint-time evidence
snapshot, then admissible the same night when the world-as-value R2 made
performs resolve at the call site; infer_context is the one home, all 14
chains route through it). The history below is the refutation record that
priced the world arc: the analysis-core ORDER LAW is written at its one
home (pipeline.mn's spine block) — ledgers innermost, lookup_ty before
env before graph before mutate_sink, diagnostics outer to graph (its arms
report: the occurs-check fires from graph_bind) — and doc_run's missing
env_handler landed, completing the core on every inference-reaching chain.
The CONSOLIDATION itself was built (a bracket fn taking the body as a
thunk, all 14 chains rewritten) and REFUTED by the artifact before commit:
a closure's evidence snapshot predates the bracket's installs, so every
EVIDENCE-dispatched core op faults its ev-scan into the sentinel — compile
trapped at executable_gate's verify_debt() (Verify is multi-handler:
verify_ledger + verify_smt), the at verb trapped on its ambiguous cursor
ops, while check/doc/teach/query/repl passed on singleton-tier ops (the
state global is dynamic). The split is exactly singleton-vs-evidence; the
wheel shrank 1,568 lines and compiled census-0, so the refutation is
semantic, not syntactic. THE CONVERGED DESIGN (same night, Morgan's
charge to read the pieces together — WORLD-AS-VALUE): the world is a
first-class graph value, a handle to the top of the install chain in the
image ([handler_record, parent] nodes, one $world_g global, O(1) cons per
install, trail-covered restore), with THREE PRINCIPLED TRANSPORTS all
already typed by the kernel: CALLS FLOW the world (the evv the §6
evidence-passing claim always named — the per-frame captured_evs snapshot
was a mint-time CACHE of a dynamic fact, Carried-Truth violated at the
kernel layer); ARMS REBIND to the install node's parent (the deep-handler
law — the M3 fence's PURPOSE, kept, its lexical approximation retired);
RESUMES REBIND to the world frozen on the k record (world_tag@28 upgrades
from bit-tag to handle; the declared-unwired E_ResumeWorldMismatchWorld
gate wires as a side effect — band B's value gate). The earlier "needs a
replay discriminator, open research" hedge is SUPERSEDED — the rebinding
rules ARE the discriminator. The infer half already exists
(inf_current_world onto every ContinuationEdge, TCont's 4th arg). The
dispatch gradient survives whole: tail-resumptive direct calls and the
singleton tier stay as proof-becomes-dispatch cash-outs over the ONE
semantics (the singleton state global becomes the cache of a unique world
entry; the uninstalled-guard's state_g==0 read becomes chain-miss →
refuse). This dissolves BOTH band-N evidence bugs, and its consumers are
the whole §2 fan: the bracket (this peer's original form, re-run as the
proving consumer), per-candidate virtualizing worlds in synth's fork pair
(the third leg beside graph checkpoint + heap region), work-stealing
frontier entries carrying their world as one memcpy-portable word, and
the depth-economics design (no depth parameter: gradient=priority,
handler=budget, multi-shot=memory — every frontier entry a dormant
continuation resumable across cursors/sessions ONLY if its world is a
value). MEASURED RED GATES, minted 2026-07-23 (scratchpad fixtures, to
graduate as frontier legs with the arc): thunk-world (a thunk minted
outside an install, called under one, evidence-dispatched op) traps 134
today, 42 under worlds; arm-config-ev (band N's true shape — a
config-param thunk performed under an arm-internal install) answers 2
today (silent wrong value: re-enters the outer handler), 40 under worlds;
the plain-block shadow control already answers 40 (no-regression
control). BUILD RUNGS, each marched: R1 world-chain substrate
(install/uninstall push-pop + $world_g, additive) → R2 the perform swap
WHOLE (evidence tier reads the chain; captured_evs op-dispatch dies; the
__resume k-threading channel survives — it is an argument, not evidence)
→ R3 arms-under-parent-world → R4 reify/resume world word + the band-B
gate live → R5 the 14-chain bracket consolidation re-run → R6 the fork
pair's world leg in synth/oracle. R2/R3 carry the whole-battery blast
radius; the multishot-era gates (52→66) and the march arbitrate.

`Hβ.infer.nested-alternative-branch-bracketing` (2026-07-24, born of the
fork-spine fix's own build — the medium refusing its builder twice): the
branch/scope ownership fix (1e06cdaa) brackets if/match arms as
BAlternative, but an if-with-consumes NESTED INSIDE a match arm breaks
the enclosing arm union — consumes in LATER sibling arms then collide
cross-arm (E_OwnershipViolation "consumed twice" false positives).
Measured twice on revert_trail_into: the if-in-argument-position shape
AND the let-bound-if shape both refused, while the IDENTICAL cross-arm
consume pattern in single-call arms (revert_trail, one fn over) passes —
so the trigger is the nested alternative, not the arm consumes. The
§4⑤ Hylo-quiet bar names this inference failing (a provably-safe shape
demanded restructuring); the fix is the branch bracket nesting as a
STACK (enter/exit balanced per alternative level), and the
undo_set_within hoist is the passing form until it lands.

`Hβ.ops.wasmtime-runner-migration` (2026-07-23 recon; the wheel-side
spawn glue LANDED 2026-07-24 — the §7 ledger head carries the arc):
steps (1)-(4) are EXECUTED. (1) the 36.0.0 LTS re-pin + wt-env.sh
flag-spelling probe (2026-07-23); (2)+(3) tools/runner — wasmtime crate
47.0.2, wt_run-argv-compatible — S1 byte-identity + battery through
both legs, S2 spawn smoke (tools/runner/smoke/spawn-import.wat,
IMPORTED shared memory re-exported for the p1 ABI) 42 through runner
AND CLI; (4) the banked RED (mn-real-spawn, 134 unaligned-atomic in
the join on both engines) is RESOLVED by the task-record landing (pin
8891428f): the four glue links died into the task record +
proof-driven memory ownership — a spawning module imports the shared
image and allocates through the shared cell; a thread-free module
(boot included) defines its memory and ships NO thread-spawn import,
so the must-satisfy-thread-spawn instantiation constraint is dissolved
everywhere it was inert. The three real-spawn frontier legs (int /
float-carrier / identity) run 60 through BOTH engines. REMAINING
scope, host-path only: (5) swap wt-env.sh/install.sh (+ hosted CI when
it returns, §11 col 5) to the runner, drop `-S threads=y`; (6) retire
the LTS pin. shared-everything-threads is the named eventual target,
unimplemented in any host — name it, do not build toward it. The
BROWSER LEG LANDED 2026-07-29 (the §7 ledger head carries the arc):
ide/wheel-worker.js is the runner pattern at the browser host — a
pre-armed worker pool consuming a SharedArrayBuffer task ring, the
stub-spawn shim retired to the gate's RED control
(tools/ide-gate.sh).

`Hβ.query.comment-prose-search` (2026-07-24, the ⟳ self-build law's
first named confession): the vocabulary sweep ran on grep while
comments are already graph content — the medium's form is a query
projection over the comment weave (find-by-word across attached prose,
spans out, the same channel the Lede facet reads). Small, and it makes
every future prose sweep a verb instead of a hand tool.

`Hβ.runtime.cross-compile-durable-state` CLOSED (2026-07-23, the
adversarial forensic-prober's independent dig — a fresh mind refuting
the accumulated corpus first, then proving the root behaviorally): the
cross-compile trap was the EFFECT-CENSUS COLLECTOR RUNNING AS A
NULL-STATE SINGLETON IN EMIT'S WALK EXTENT. project_emit_state
installed six visitor collectors but not effect_census_collector, so
the shared walk's visit_effect_install routed through the singleton
tier with __state = 0 — its installs accumulator lived at ABSOLUTE
ADDRESS 12 (the null page), below every region mark, never reset,
holding a pointer INTO the region; the reset zeroed/rewound the region
and the next compile's census walked the stale pointer as a list
(named backtrace: list_index_unchecked → string_in_list_loop →
op_effect_census_collector_visit_effect_install → walk_install_groups
→ walk_lemit → project_emit_state). Installing the collector: the full
region-bracketed battery runs 112/112 with byte-identical emitted wat.
The thirteen-kill probe corpus (2026-07-22, the same peer's prior
text) is SUPERSEDED as diagnosis — its pre-virginity infer-side
symptom was this same null-singleton class read through address reuse
under the rewind-only reset, and its "values no placement wrote, in
virgin memory" was exactly right: the writer was outside every
placement channel, storing through the null page. What the corpus
PAID FOR survives as law (CLAUDE.md ⟲, the forensic laws): one-binary
gates, protocol-honoring probes, retraction-on-refutation, counted
kills, and the virginity contract itself ($heap_reset_impl zeroes
[mark, bump) — the allocator accident made a contract; 192MB battery
peak). The CLASS is closed structurally, both altitudes: the wiring
(every walk_lemit bracket installs every visitor family the walk
fires) and the SingletonUninstalled guard in singleton_perform_block —
a singleton op call finding state_g = 0 REFUSES loudly at the site
(the tier's evidence IS the global; null evidence is missing evidence,
the direct-call twin of LUnresolvedEvidence), so the silent null-page
read is unsayable. The regioned battery ships (main.mn battery_loop
mark/resets per micro — the arena's first real workload, §5.O).

The manifest arc's residue (2026-07-18, the arc itself CLOSED — §7 ledger):
`Hβ.infer.order-independent-verdicts` (the census is ORDER-CONDITIONAL: a
runtime fn declared before its prelude consumer meets the TIGHT inferred
scheme where the canonical order met the loose pre-registered one — three
real latent mismatches at prelude sum/chunk/trim under a leaves-first
weave; the canonical sort sidesteps, the class remains; repro: swap
lists/strings before prelude on stdin. The COMPLETE form was BUILT TWICE and
unwired twice by the SAME measured wall (2026-07-23 in the
instance-crossing landing; RE-BUILT AND RE-MEASURED 2026-07-25, phase
B-ii step 0 — the ledger entry carries the arc): a TWO-PASS WALK — a
diag_quiet trial finalizes every scheme; the final pass re-judges fresh
nodes against those finals (fn pre-registration SKIPPED — infer_fn's
unbound-handle arm self-registers monomorphic recursion; the
duplicate-fn refusal decoupled into its own seen-set walk) — closes the
class whole: its verdicts on the wheel converged 50 → 0 and the fifty
findings LANDED as the 2026-07-25 harvest (abs, infer_unaryop, the
formatter's chain arms, autodiff's matrix, the field-carrier split, the
str-raw satellites, ~35 row widens). The wall is CURRENT, not stale:
the judge-0 wheel's m3-leg self-compile exhausts the 4GB bump extent at
emit_wide_wrappers (alloc's wraparound guard; ~28s, 1.1GB RSS). DEP:
Hβ.perf.per-decl-arena's image/scratch split OR wasm64's ceiling lift —
whichever lands first re-wires the pair (the 2026-07-25 build is the
recipe, banked in the campaign mirror; the convergence protocol: fix
the JUDGED source under the standing judge, rebuild the judge, repeat).
THE CALLEE-FIRST BLOB (2026-07-23, the field landing) kills the class's
src→lib face whole: the canonical wheel input is lib-before-src, so
every cross-layer reference is BACKWARD; the bare-scheme census fell
492 → 256, and the residual 256 are intra-src forward references — this
peer's remaining scope. In-file, callee-first source order kills
instances one at a time — prelude's iterate_from precedes iterate for
exactly this reason) ·
`Hβ.patch.set-target-state-clobber` RETRACTED (2026-07-18, same day):
probed on the pinned artifact with both a len read and a full iterate,
before and after the perform — seven of seven survive; the original
"lost tail" measurement came from a probe-perturbed build (the
wheel-eprint Heisenberg class: the PROBE-R eprints inside
entry_start_caret changed the very emit under test). A label is a
hypothesis until the artifact confirms it — this one died by the law
that minted it; the hoisted read stays as ordinary hygiene ·
`Hβ.driver.per-module-env-overlay` gains its measured consequence: the
per-module check walk inferred prelude without its layer's vocabulary
(len/list_index missing on a clean program) — check rides the weave until
the overlay lands.

The 2026-07-18 census-tail peers: boundary-weave-generic-thunk-row and
rowbound-ty-residual-tagged both LANDED same day (the census-zero arc —
§7 ledger). `Hβ.emit.option-niche-repr` remains open at its EMIT half:
slot_present landed the READ (a table-typed `a -> Bool` presence test
over the 0-or-handle word), but Option CONSTRUCTION still boxes and
match-on-Option still tag-compares — the lower/emit arm that makes both
read the niche (0=None, handle=Some, zero boxing) is the landing.

The 2026-07-18 harvest + panel born peers (each artifact-verified before naming):
`Hβ.infer.type-decl-name-registry` (a second `type X` silently MERGES —
disjoint ctor sets share tag ids; measured: cross-tag match returns the wrong
arm, zero diagnostics; the decl refusal needs the type-name registry — a
SchemeKind representation change, its own landing; repro banked) ·
`Hβ.lower.trecordopen-wrong-field` (VERIFIED LIVE silent-wrong-VALUE: an open
receiver `u: {name: Int, ...}` reads the wrong slot — offsets computed over
the partial field set while the record sorts over the full set; the panel:
instrument whether self-compile hits the arm, then concrete-receiver
resolution, never a blind -1 refusal) ·
`Hβ.runtime.list-index-bounds-check` (SYNTAX §Indexing promises a runtime
trap; lists.mn tag-0 raw-loads with NO bounds compare — every OOB index is a
silent wrong read; the fix restores the promised trap, and list_index_proven
becomes the genuinely-unchecked variant the R5 discharge selects) ·
`Hβ.infer.narrowing-write-requires-discharge` (R5 re-scoped by the panel: the
elision machinery is DEAD CODE — narrowing_pred_handle descends PAnd's left
conjunct to PTrue, handle 0, never fires; delete the dead machinery, then the
real form: record only when the path predicate discharges BOTH 0<=i AND
i<len(receiver)) · `Hβ.mentl.verify-after-apply-boundness-only` (the teach
loop's proof check reads node-boundness, never re-runs row subsumption;
narrow_row binds without re-inferring — an `!Alloc` proposal on an allocating
fn reads back 'proven'; fix = re-run subsumption under a FRESH diagnostics
handler, graph_rollback does not cover diagnostic state) ·
`Hβ.infer.ctor-record-construction-unify` (single-variant record-wrapping
`Ctor({...})` construction unifies against the ctor's arrow type instead of
its result — ~5 voice sites of E_TypeMismatch) ·
`Hβ.infer.expect-same-chases-bound-var` (LANDED 2026-07-20, pin a0dd9849 — the
ledger head has the full arc). expect_same was the LONE unify arm that bound a
var without chasing, so a scalar clobbered a ctor-argument reference's
NBound(TVar(binder)) live binding and the parameter never learned the field
type (Float → i32 floor → indirect-call trap); the one-line fix chases like
every other arm. It unmasked the runtime handle-word pun, which the §4①
string-layer typing closed whole: byte_len/byte_at/str_slice/str_concat/
view_base/the float builders are seq-ops, str_of_buf is the ONE construction
boundary (a raw buffer word IS a String), handle_recorded dedups Int handles
by i32.eq. Census 0, m3 == m4, board whole. Repro registered:
tests/frontier/mn-ctor-float-param.mn. The next rung the fix exposed —
`Hβ.lsp.hover-response-emission`: serve now clears the json float blocker and
reaches the LSP layer but does not yet write a hover result
(Hβ.lsp.transport-runs-frontend)) ·
`Hβ.lsp.transport-runs-frontend` (ensure_doc_open reads bytes, never
lex/parse/infers — hover reads an unpopulated graph; v1 = the pipeline splice)
· `Hβ.format.render-totality-before-fmt` (SHARPENED 2026-07-23 — the exact
census + the oracle design, ready to open): format.mn is 577 lines of
DORMANT machinery (zero callers; the Format effect + format_program/
format_at_handle/format_chain real). The three surrender-fallbacks measure
as 18 missing arms: render_expr_tokens 17/25 (missing BlockExpr,
LambdaExpr, MakeRecordExpr, MakeStringExpr — the interpolation re-render —
MatchExpr, NamedRecordExpr, RecordUpdateExpr, ResumeExpr),
render_stmt_tokens 4/9 (missing LetStmt, TypeDefStmt, EffectDeclStmt,
HandlerDeclStmt, RefineStmt), render_pat_tokens 3/8 (missing PLit, PTuple,
PList, PRecord, PAlt) — the easy spine renders, everything structural
surrenders. THE BUILD: (1) the 18 arms + precedence-aware parenthesization
(render must be parse's inverse under the ONE precedence table) + the
COMMENT WEAVE projection (decl/interior/trailing comments are graph
content now — the formatter is the weave's biggest consumer; dropping
prose is destroying source); (2) the fmt verb as whole-file projection
(read → frontend → render → write, the tighten driver's surgery
generalized from one clause to the file); (3) THE ORACLE — the formatter
judged by the self-hosting machinery itself: idempotence
(format∘format == format, byte-equal), then format the ENTIRE WHEEL and
the formatted wheel must compile census-0, hold comment-refs 0, pass
battery + frontier, and reach its own m3'==m4' fixpoint — the formatted
source then BECOMES canonical in the same landing. (4) The payoff ratchet:
the 760 E_RedundantBraces (MachineApplicable, format-liftable) die as a
side effect of canonical projection, with E_RedundantPerform and
E_StatementSemicolon riding free — the medium's next batch-authored sweep
after tighten. RED-first fixtures per missing arm class (today a match or
lambda formats to `<expr>` — the gate) · `Hβ.multishot.handler-return-clause` (M5 — named twice in
git history: docs/research/multishot-general-design.md as the next ladder step, absent
here until now) · `Hβ.lower.branch-isolated-handler-state` (the multishot
doc's own correction, missing from every band) ·
`Hβ.infer.usage-grade-unifies-cardinality-ownership` — NOTE: this peer's
name was REUSED on 2026-07-17 for the branch/scope ownership fix; the
ORIGINAL residue (unify classify_usage and resume_grade onto one count_uses)
is still open and lives under this line ·
`Hβ.emit.compose-width-floor` (implemented in lower.mn, tracked nowhere until
now) · `Hβ.cursor.gradient-queue-activate-or-delete` RESOLVED: DELETED
(2026-07-23, pin 56f01996 — the 107-line larval block died whole; band
E's work-stealing-via-gradient keeps the design) · `Hβ.graph.fork-dead-code` (graph_fork + the overlays
module-to-handle index: built, zero callers, taxing the hot alloc path — an
activation slot or a deletion) · `Hβ.emit.float-evidence-ft` (an f64-argument
candidate/closure call dispatched through an all-i32 $ft — `indirect call
type mismatch` at enumerate_float_literals the first time a float-position
enumeration ever ran; the $ft repr-vector walk's evidence-call gap, the
fleet's float-HOF class with its first concrete anchor) ·
`Hβ.why.flow-naming-at-call` (the README Why's `flows into echo(mix, x)`
line — a call-arg's reason carries VarLookup but no callee/param naming;
FnParam-at-call woven into the arg reason at infer) ·
`Hβ.why.refinement-provenance` (the README Why's `output bounded by Sample
via soft_clip` line — the refined alias's provenance chain at the return
position).

`Hβ.synth.vocabulary-arg-holes` · `Hβ.synth.vocabulary-reach-index` ·
`Hβ.cursor.enclosing-decl-edge` (band M kin) ·
`Hβ.cursor.session-weave-epoch-scope` (DISSOLVED by the peer audit — the
session `<~` loop deletes the re-parse that created it; §11) ·
`Hβ.infer.alias-preserving-unify` (LANDED 2026-07-17 — not a unify-peel bug:
a forward-referenced refined alias bound a bare TName; `pre_register_alias`
registers the edges before any fn signature, §7 ledger) ·
`Hβ.own.region-return-transfer` (LANDED at the check; the caller-side
re-tag under region polymorphism is the arena increment) ·
`Hβ.lower.partial-via-lambda-recipe` (the peer-audit merge of
partial-effectful-callee + partial-local-callee: the mint routes through
the LambdaExpr machinery) / `.partial-prefix-arity` (lower.mn floors,
typed) ·
`Hβ.lower.k2-remainder-fncall` · `Hβ.lower.abandon-with-resume-arm` ·
`Hβ.lower.stateful-install-crossing-yield` (band B kin) ·
`Hβ.cli.audit-row-var-render` (cosmetic) ·
`Hβ.emit.int-splice-empty` · `Hβ.emit.f64-closure-capture-box` ·
`Hβ.m2.callsite-result-width` (the loud width family) ·
`Hβ.felt.ide-run-in-page` (in-browser assembler).

## §8 · Verification surface

```
# ── the BOOT ERA (post-first-light, 2026-07-10): boot/mentl.wasm IS the compiler ──
bash tools/state.sh            # THE BOARD, ground FIRST: git → verify → march → frontier → proof-exactness → crown → effect-identity, one scoreboard; --quick = verify only
bash tools/verify.sh           # the floor: micros + census — STAMPED green (unchanged tree answers in ms; FORCE_VERIFY=1 re-runs)
bash tools/march-gate.sh --micros   # rungs + battery through boot's wheel-emitted m2 (reads the shared .build/m2cache)
bash tools/march.sh            # THE RATCHET: boot→m2→m3, ASSERTS m2 == m3; on m2 ≠ m3 runs m4 ITSELF and rules TRANSITION (re-pin from m3) vs BROKEN
bash tools/frontier-gate.sh    # scheduled matrix + ?? authoring workflows (--compiler fresh for the current wheel)
bash tools/proof-exactness-gate.sh  # hole refuses · debt surfaces · suspension runs
bash tools/doc-truth.sh        # the docs' checkable claims vs the artifact: PROVENANCE sha == boot sha, ledger head pin, named commands exist (runs inside verify — prose gets a mechanical floor)
mentl space                    # mentl edit in the browser (localhost:7378/ide/) — SERVED BY THE WHEEL (src/main.mn space_run; the shim owns the tcplisten seam)
#   (the seed + --from-seed are deleted, 7401c4b; the cold ladder lives at tag first-light)
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

**Modern toolkit (measured; profiling CORRECTED 2026-07-13).** `wasmtime
--profile=guest` writes a Firefox-profiler JSON — BUT it writes NOTHING for a
program that exits via `proc_exit` (WASI), which is every real Mentl compile: the
store is torn down before the dump fires (three attempts wrote empty, 2026-07-13).
Profile the self-compile with host **`perf`** instead — it samples the process
regardless of how the guest exits: `perf record -F 199 --call-graph=fp -o
perf.data -- wasmtime run --profile=perfmap <flags> m2.wasm < wheel.mn` (the
`--profile=perfmap` writes /tmp/perf-<pid>.map so `perf report` resolves guest fn
names; `perf_event_paranoid=2` permits user-space samples of your own child; a
`timeout 300` on the first 5 min is representative for the uniform compile). This
is THE profiler for the self-compile — it pinned the resume-cardinality
classifier's O(n^k) at **98% of the entire compile** (§7) after `--profile=guest`
returned nothing, and it is the tool that made the env miss (attacking a
diagnosed-but-non-dominant O(n²)) unrepeatable: measure, do not guess the hot
path. **AOT is MARGINAL: `wasmtime compile` → .cwasm removes the JIT cost, but the
JIT is only ~20ms MEASURED (the 2 MB boot module), so the compile is 100% guest
ALGORITHM — AOT buys ~nothing for the wheel, ~1s across the 66-micro battery.**
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
   confidence. *And at the PERFORMANCE scale (Morgan 2026-07-13): **O(1) is the
   only acceptable complexity for any operation.*** The graph's only native access
   is the O(1) flat-array handle chase, so a super-constant op re-derives what an
   edge already connects — a scan/re-filter/re-clone IS Law 1 violated at runtime.
   The fix is uniform: a name is a HANDLE (interned once), every read an O(1)
   handle chase (§5.O). Every scanner in the compiler is a place we forgot the
   graph already knew.
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
    inline. EVERY dispatched agent runs `fable`, passed explicitly (Morgan
    2026-07-24, Fable-only — unlimited capacity retired the 2026-07-02
    sonnet/opus tiering; an omitted model param falls back to an agent
    definition's default and silently downgrades the run); the discipline
    governs each agent. A turn ends with what CHANGED and the MEASURED result;
    work not done → "not done" first sentence; shortest response carrying result
    + next move.

11. **A gate is not trusted until it has been seen RED; a Carried-Truth fix
    DELETES.** Run every new gate against the unfixed tree and watch it fail
    before the fix (march.sh models this — it arbitrates by running the m4 leg
    itself; thirty of the 2026-07-17 fleet's gates could not fail and died to
    one command). And ask of every fix's diff: does it delete? Elegance is the
    axis fluency fakes best; a line count is not — a net-positive "less code"
    fix must say why in its commit (the `++` row fix claimed a deletion while
    adding 43 lines; the flurry plan caught it). The gate's OTHER face: a
    banked expectation is a HYPOTHESIS about the era that banked it — when a
    correct fix flips old gates RED, re-derive each truth by hand before
    re-banking, because the old value may be the bug canonized (2026-07-25:
    nine payload-ladder micros banked the wrong-slot alpha read as their
    expected values; one of them had carried "Expected value when fixed: 2"
    in its own comment since birth).

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
**the seed's name-keyed intrinsic table** (bootstrap/src/infer/walk_expr.wat — deleted with the seed, 7401c4b; the lesson outlives the file
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

---

## §11 · THE PRODUCTION BAR — everything before Mentl is production-ready

**THE CAMPAIGN ORDER (2026-07-24, Morgan-approved; consolidated
2026-07-25 — THIS section is the ONE home. PLAN.md IS THE SINGLE SOURCE
OF TRUTH (Morgan, 2026-07-29): every `~/.claude/plans/*` file — the
retired campaign mirror `wait-i-thought-mentl-lively-wren.md`, the
finish-line plan `buzzing-wobbling-pie.md` and its execution sidecar
`please-let-s-get-through-mutable-nebula.md` — is archaeology, verified
integrated here (the eight arcs below ARE the pie's arcs; its
definition-of-done and risk tripwires land below this note). Landed
arcs live in the §7 ledger; unlanded designs live here or in the
named-residue index; nothing lives only outside this file.)**

**THE DEFINITION OF DONE — one statement per §0 property; each is an
arc's terminal gate:** (1) proof beats review — the crown lands (`!E`
sound under polymorphism, the modal world-index through world-as-value;
Verify on a decidable fragment with honest V_Pending; SMT a
certificate-checked handler swap; every armed class refusing). (2) the
negative is provable — IFC `!Flow` on the integrity dual-lattice,
PC-labels, robust declassification. (3) intent is lossless — the Why
engine total; comments/Reasons/provenance projected at every surface;
the fmt summit canonical. (4) computation is durable — persist=memcpy
generalized to cross-machine cursor migration; the session a value; the
oracle's forks durable. (5) systems explain themselves — `mentl audit`
live; docs-as-projection; the ??-fan with the teaching tie-break as the
daily loop. (6) the oracle at its limits — the multithreaded
multi-cursor multi-shot fused oracle as DEFAULT (N-wide judgment +
synth fan on one machinery, gradient work-stealing,
hypothesis-derivation rounds, K past the 4GB ceiling). (7) `!Outside`
closed — the native backend, diverse double compilation, and
correctness-oracle-internal (the micro battery absorbed into the
wheel's own Verify).

**THE RISK TRIPWIRES (named assumptions, each with its fallback):**
(1) the frozen-read instantiate holds without judgment regressions —
tripwire: census classes shifting instead of falling; fallback the
install-reconciliation-only route. (2) the lattice join's confluence
survives every future workload — tripwire: any six-battery split at a
new workload; FRAGX stays armed as the standing collision census.
(3) the category window stays open for Arc 2 — tripwire: MoonBit 1.0
or stabilized Scala CC shipping an absence-shaped claim first; response
is pulling the benchmark + writeup forward on LANDED capability.
The whole remainder to the FULLY TRUE ULTIMATE FORM, re-sequenced
2026-07-28 (Morgan-approved — the finish-line plan; supersedes the
A→F spine IN PLACE per the alive-law, A / B-i / B-ii / C having
LANDED whole with the §7 ledger carrying each) and grounded in the
six-sweep frontier recon, whose decision-changers each arc absorbs:
Metn hands the crown its instance semantics and none of its 62pp
contests negation; FIDES/CaMeL fix the IFC product surface including
the typed quarantine; TS7/rustc leave cell-grain deterministic
parallel inference unclaimed; wasm 3.0 finalized (memory64 the
OOM-escape — the shared64 probe confirmed 4GiB×N dissolves; native
stack-switching dead weight, re-execution vindicated); the MI300X
CPX×NPS4 partition ≅ the deterministic handle partition with
HISA-style fixpoints, never SIMD offload; cvc5 CPC + Ethos-class
checking makes SMT check-only and certificate-keyed from day one;
TPDE/QBE budget the native emitter at ~10k lines with the e-graph
capped to rewrites; Programming-by-Navigation + Choose-Don't-Label
bar the fan; the gate-is-the-moat convergence (ARIA abandoned its own
proposer; nobody owns a language-level gate); and Unison's
post-mortem makes text-as-lossless-projection a hard constraint — the
fmt fixpoint inviolable. THE ARCS:
**Arc 0 · THE LATTICE COMPLETES — LANDED** (pin 28c39633: the join
algebra, frozen reads, K=8 the default judge, six identical shas).
**Arc 1 · THE FUSED ORACLE'S LIMITS — core LANDED** (the fan rides
the spawn, 47904e5c: every ?? candidate a REAL branch cursor on the
judgment's own bracket; Strong Soundness/Completeness adopted at the
decl; the shared64 probe answered. Residue:
`Hβ.synth.annotation-fan-pure-proof` ·
`Hβ.felt.tie-teach-behavioral-scenario`, gated on !E-speculation).
**Arc 2 · THE CATEGORY SHIP — IN FLIGHT** (the window, MEASURED
2026-07-28 by live fetch: MoonBit 0.9 shipped "first-class formal
verification" as a core feature in April 2026 WITH its own code agent
— the contest is live NOW, before their 1.0; Scala capture checking's
own docs concede "highly experimental" and NO effect negation or
absence proofs; and spec-kit — 124k stars, 30+ agent integrations, the
industry's intent-capture wave — concedes in its own docs "no
automated validation that generated code matches specifications,
enforcement appears primarily behavioral": intent captured in
markdown, no gate. Packaging of LANDED capability only). Landed:
the ABSENCE BENCHMARK (benchmarks/absence — 13/13 baseline,
runner-gated, prior art + growth tiers named; the podium was empty);
the RENDER REGISTER and the proposer's register (the demo's DEPs);
the README fan demo, every claim transcript-verified through the
shim; the MCP-FACING SYNTH-GATE (`mentl mcp` — an agent proposes over
stdio, the gate proves before anything executes, refusals teach at
file-local spans, only proven bytes reach disk; the §7 entry THE GATE
SERVES AGENTS carries the record — the OPAW/Cedar counter is now
runnable); the POSITIONING WRITEUP (docs/POSITIONING.md — both wedges,
every claim carrying its command, each command re-run against the live
pin before the doc landed; the honest-boundary section states what is
NOT claimed). ARC 2 IS COMPLETE — the terminal gate held on all three
legs: clean-clone repro (the clone's own boot judges, runs the absence
suite 13/0, and serves the MCP handshake; the exec leg rides the
installed shim per the seam's design), the benchmark published with
baseline results, the writeup's claims each artifact-backed.
**Arc 3 · PROOFS** — the modal crown Metn-keyed (masks subtract
INSTALL IDENTITY = the world-chain hkey; negation-under-modality
published FIRST, contested by nobody); the
parameterized-negation-instance; the TCont world value gate + the
EXTERNAL-EFFECT RESUME BARRIER (external synchrony — a persisted k
whose extent crossed IO/Network resumes only through a handler owning
replay semantics — BEFORE the durability flagship; the industry's own
convergence — Temporal/Restate journal + replay + refuse-on-divergence
— is this barrier enforced at runtime, untyped: the row proves what
they diff); IFC `!Flow` on
the integrity dual-lattice + PC-labels + robust declassification +
`~> Quarantine`; Verify inward (the range fragment WITH inference —
corroborated in print, arXiv 2607.00824; finite maps + sequence
lengths second; quantifiers never;
per-obligation caching across the cone; SMT as a CHECK-ONLY
certificate-keyed handler swap). THE FELT WALK RAN (2026-07-28, the
felt-path-first law): (a) the parameterized effect DECLARATION head is
parser lathe-lag — `effect Sample(rate: Int) {` refuses at the `(`,
SYNTAX's own canonical form unparsed — the instance-negation landing's
named DEP; (b) the with-clause instance surface parses and judges over
a BARE effect decl (`with Sample(48000) + !Sample(44100)` + a bare
tick() perform checked CLEAN), so the negation's instance boundary
today is positive-name-admit with the precise semantics unbuilt — the
landing defines it (a severed instance admits its siblings, the bare
name severs all) with mn-effarg-node.mn the existing fixture to build
from; (c) Dynamic Wind for Effect Handlers (OOPSLA 2025 — Voigt,
Schuster, Brachthäuser) READ: the wind's pre/postlude carries
well-defined semantics under arbitrary control effects — brackets fire
correctly when a continuation resumes many times or is abandoned,
expressing "backtracking of external state and finalization of
external resources." That is the resume barrier's design vocabulary
exactly: the world save/restore around installs, the fork triple's
world_restore, and the multi-shot re-execution driver each hold an
ad-hoc corner of one invariant (an enter/exit pair per crossing,
replay included; the Abandon discipline's finalization is its
abandonment face) — the barrier landing states it once and reads it
at the persist/resume seam.
**Arc 4 · THE FELT FLAGSHIP** — and its RANKER increment is
pull-forward eligible: the gradient reading LOCAL intent (Reason
chains carrying upstream why + proximity + the in-scope vocabulary,
replacing gates×proximity) carries NO dep and is the obsolescence
thesis's nearest lever (§5's optimality half) — interleave it as early
as Arc 3, every survivor's rank sharpening the daily fan. The rest:
the incremental cone claiming PROVEN
equivalence to full reanalysis (the fixpoint oracle proves it);
session-as-a-value (persist mid-exploration, reopen anywhere, hand
the image to an agent over MCP — gated on Arc 3's barrier); the
verification dashboard (per-node proof status + a human-attention
frontier derived from Reason/refinement provenance); the .mn merge
driver; row ergonomics; the CFC research loop entirely inside the
medium (the founding workload).
**Arc 5 · NATIVE + THE TRUST STACK** — the TPDE-shaped single fused
projection (isel+RA+encode in one pass, ~10k-line budget);
trail-reclaimed image frames; FP pinned SSE-only/no-FMA/RNE with an
EXPLICIT NaN policy; the three-legged gate (native_m3==m4 + per-rule
SMT specs grounded in authoritative ISA semantics + independent
decode-back); Cranelift demoted to differential oracle; then DDC
closing trusting-trust.
**Arc 6 · GPU** — partitioned cursors over the column spine running
HISA-style relational fixpoints ((arena_id, offset) ≅ (XCD, local
offset)); never SIMD kernel offload; the thesis gate — the same
source under `~> Seq` / `~> Thread` / `~> Gpu` with identical
results; the CFC flagship raced against the JAX baseline.
**Arc 7 · CLOSING THE CIRCLE** — correctness-oracle-internal
(Alive2-shaped m2/m3 semantic pair validation as the intermediate);
per-emission structural certificates off the Reason edges; PROVENANCE
additionally as SLSA/in-toto attestation + a transparency log;
docs-as-projection; `mentl audit` LIVE — a Carried-Truth violation
refused by the medium before a line is written, the hand practices
retiring in place.
Excluded by hardware only: MI300X execution, hosted CI, wasmFX,
shared-everything-threads. Every dispatched agent runs `fable`,
passed explicitly; every landing re-derived on main; the board is the gate.
**THE FELT-PATH-FIRST LAW (paid for 2026-07-28): every arc OPENS by
walking its felt path** — the exact surface an outsider or the daily
loop touches, through the installed shim, before any build starts. The
walk surfaces the arc's REAL opening work: the five-minute demo's
first walk found the 173-line diagnostic flood no gate had ever
measured (the fixture legs dodged it by never weaving the lib), and
the render register — not the README — turned out to be the demo's
true first landing. A DEP found by walking is cheap; a DEP found by an
outsider is a category loss.
**THE CAMPAIGN'S TERMINUS is §1's CLOSED LOOP** (Morgan 2026-07-28):
human + Mentl only, no LLM advantageous at any scope — every arc's
landings measured against the three legs (next-move supremacy · the
question beats the guess · the loop is felt). Part of leg 3 is the
FIVE-VERB EXEMPLARITY charge: the wheel's own source uses the verbs
exemplary throughout (the self-exemplification pass banked the
measurement — zero `><` as a fanout verb in the wheel today; the
compile spine's spawn fan is substrate-level, not yet verb-form), and
the census instrument is the medium's own lexer projected as a query
facet, never a grep (a `><` in a comment is not a verb).

**CAMPAIGN STATE (2026-07-28).** Arcs 0 and 1 (core) LANDED; Arc 2 in
flight (the arc list above carries the live split); the ledger's head
entries are the ground truth. Everything below this sentence through
"ONE machinery, two workloads" is the C1c ERA'S RECORD — how the
converged judge, the branch bracket, and the fan landed, kept for its
mechanism detail and superseded where it speculates (the outcomes live
in the §7 ledger entries of 2026-07-26 → 2026-07-28).
A, B-i, B-ii: LANDED whole (the §7 ledger). C rung 0 (the fork triple)
and rung 1 through C1c-2's substrate: LANDED — the paged spine, the
planned mint, the layer-ordered final, the cursor config, the env view,
the page pre-open (six pins, 0e3af09c → 3a53f775). THE CONVERGED JUDGE
IS LIVE AND VALUE-BOUNDED (the ledger's top two entries carry both
records): the convergence loop + branch bracket + four roots, then the
value-boundary landing — five more roots, census 0 WITH convergence,
the incremental cone, the ratchet's raised lane closed. The judgment is
now a pure function of (source, finals): published schemes leak no live
vars — the fan's own blessing condition. THE BRACKET'S SELF-CONTAINMENT
IS THREE RUNGS IN (each CLEAN m2 == m3, pushed): the barrier shape
(judge-then-join at the layer, fa5bedca), the three ledgers
branch-local (affine seeded via consume_seed/base/log + join replay;
verify bank+re-perform, exact by the operands-in-own-range stability
argument; region zero-replay — top-level tags are region 0, a fresh
instance's None answers the same verdicts; a33c6dfc), and the inner
trio (infer_ctx + fresh stmt-local-fresh; summaries re-armed over the
threaded classify value; 78a7575d). Eight of eleven handlers are
branch-local. THE REMAINING RUNG 2b, design measured against the
artifact: lookup_ty_graph (fresh — spec state is emit-era, [] during
infer) + mutate_sink (stateless swallow) + graph_handler as the
config'd shared-spine instance — widen config (spine0, spine_open0,
next0, limit0) with span_index0 + mint_high0 (nine bare root installs
gain two args; the branch's config = the root's live values via a new
GraphRead export op `graph_branch_seed() -> (spine, open, span_index,
mint_high)` whose spine element type copies spine_page's closed
annotation), the branch's own graph_index_span appends banked (drop
the seeded prefix off the branch's snapshot) and re-performed at the
join, comment_refs config [] with NO replay (refs draw only at the
root's post-walk infer tail), overflow keeping root jump semantics
sequentially and tightening to abort-and-requeue at the spawn, and
graph_mint_at dissolving into the branch config (next0 = the stmt's
base, limit0 = its ceiling). THEN RUNG 3, the spawn: chunk
layer_judge_walk's iterations onto spawn_task closures (the bracket is
the task body; the intern rides as the read-only pre-warmed view),
joins ordered by stmt as today, the wheel's shared-image memory flip
as the measured TRANSITION, the CAS-bump tax + the pointer-identity
census run under it, and the same-layer handler-sig install
unification as the one barrier class to settle (both installs bind one
prepass-minted sig — sequential-post-join or own-layer those stmts).
Then the ??-fan on threads — the fused oracle as default behavior. The dig
narrative below is the ERA'S RECORD of how the bracket and loop landed,
superseded where it speculates: THE BRANCH BRACKET'S
FIRST SEQUENTIAL RUN (2026-07-26, in-tree uncommitted: BranchEnv/
BranchDiag effects + env_base_view/env_publishes arms + diag_branch +
the per-stmt bracket in planned_layer_stmts) MEASURED A LATENT
TRIAL-VS-FINAL SCHEME DIVERGENCE the old walk had masked: with every
same-layer reference resolving the TRIAL's finals uniformly (the
two-pass design's own stated intent), the m3-leg census converged 0
after one widen round (driver_collect_visit_list /
driver_collect_dag_with_deps +GraphWrite+GraphRead,
render_feedback_chain +Memory+GraphRead, candidates_at +Intern; plus
the de-parameterization law: a free var in a piggyback effect's op
return parameterizes the effect and the handler-arm binding refuses
the mix) — yet the emitted wheel DIVERGED 48k lines with 40 EXTRA
twins whose encs flip lb↔i at name-carrying positions
(analyze_fns / bind_from_handlers / escaping_fixpoint / crc_* /
free_vars_* / driver_*; body_to_smt newly reachable), and that wheel
dies at its FIRST mint (m4 exit 134 in graph_fresh_ty's arm). Reading:
the trial's finals and the final pass's finals GENUINELY DISAGREE on
the classify/escape/crc family (String-vs-handle at scale); the old
root-live walk read a self-consistent MIX (final-pass publishes
shadowing trial's mid-walk), so the disagreement was invisible and
UNGATED. The bracket is the instrument that exposes it. THE CONVERGENCE LOOP IS
BUILT AND RUNNING (in-tree with the bracket, uncommitted):
infer_program_converged iterates QUIET ROUNDS (infer_program_round —
the trial's measured walk with fn pre-registration skipped and the
final's prepass) until round-over-round scheme FINGERPRINTS stabilize
(ty_fingerprint — alpha-normalized total render, vars by first
occurrence, rows by intern handle; EANode/predicates opaque, the
m3==m4 oracle backstopping), then runs the reporting final — whose
publishes equal the converged set, restoring the bracket's frozen-base
truth. En route the medium refused two of the loop's own forms
(BranchEnv parameterized by a free op-return var → the handler-arm mix
refusal; round_prints_walk's nested-alternative own collision → the
hoist recipe). THE LOOP'S FIRST HARVEST (m3-leg census 15, the
converged judge convicting the wheel — the 50-findings precedent):
(1) THE DISPATCH EXIT-CODE CONTRACT — dispatch_invocation's arms mix
() / String / Int (7+1 at the match head; the two `Int vs ()` singles
are main's ParseError arm — print_error_and_help returns () — and the
VCompileStdin tty fork's welcome/compile pair); main's value is the
process exit code, so every *_run must return Int. edit/space/march
return Int already; the infer_context-enders (doc/tighten/fmt/at/
teach/repl/serve) and the chain-enders (compile/resume/run/audit/
query) take a trailing honest 0 (their refusal paths already exit
through the gate/fail); ONE arm returns String — the List(Byte) vs
Int — likely the welcome/catalog render; find it by fixing the rest
and re-judging. The wrong-end branch-stack fix and the crossing-form
row_print ride this same landing: after the pin, inline row_print
back (the natural nested-alternative shape is legal under the fixed
judge; the old judge in boot refuses it, so the un-hoist is
generation-two — the world_top crossing law at the ownership layer).
(2) THE VERIFY TRIPLE SPLIT — verify_ledger accrues
(span, predicate, reason) [verify.mn:44] while the judged flow says a
(Reason, Predicate, Span) row reaches filter_by_span: Verify is
MULTI-HANDLER (verify_ledger + verify_smt, verify.mn:336), and the two
handlers' debt rows disagree on field order — the real root; ONE
canonical order at both accrual sites, then filter_by_span's
destructure follows it (the first inversion attempt just moved the
error: 14154 persists + a new Reason-vs-Span at 14363 — cursor.mn's
filter now leads the ledger; revert it to span-first WITH the smt
handler aligned). (3) the render match at format.mn ~154: an arm after
the PTee arm returns Node/[Node] where the match's arms unify String —
read the arms below PTee to name it. (4) render_chain_pos row widened
— DONE. (5) synthesize_lambda_node now passes params straight to
LambdaExpr([TParam],_) and synth_param_names/loop are deleted — but the
error persists as Node vs (Node, String): enumerate_lambdas' OWN
params arrive as [(Node, String)] from ITS caller — walk the chain
one caller up (grep enumerate_lambdas call sites) and pass the
scheme's true [TParam] down. (6) List(Byte) vs TParam cleared with
(5)'s first half. Exit-code sweep LANDED (twelve tails: compile /
resume / run=1 / audit / query / new_project / fmt / doc / serve /
teach / repl / compile_stdin + print_error_and_help=2); census
15 → 4. The recipe: fix each under the
standing judge, re-march, iterate to census 0; the landing gate is
then TRANSITION (m3 == m4 — the converged judgment self-reproducing).
CENSUS 0 REACHED (2026-07-26, all six classes fixed: exit codes ×13,
the verify facet flowing whole triples with three row widens, the
diverge-chain render unpacking the tuple node, the record-synth
name+hole pairs, the lambda TParams direct). THE REMAINING BREAK is
census-invisible and MEASURED at one arm: m2's
op_graph_handler_graph_fresh_ty carries evidence-walk locals
(evw/evn — an evidence-tier perform in the arm) that m3's emission of
the SAME arm LACKS (a variant + wildcard local instead) — a
dispatch-tier collapse across generations; m4 dies at the first mint
inside that arm (parse_import → mint_node). Suspects, in order: the
banked draw_op_edges warning (a handler-registration entry
value-replayed through the branch bracket baking a
construction-time-unique op edge → the emission cashes a
direct/singleton call for a multi-handler op), or a converged-judgment
input to the tier chooser diverging between rounds. THE OP IS NAMED (2026-07-26, the eighth interrogation run on the
collapse): m2's arm performs graph_mutated (ename intern 97356) through
ev_perform_node at the commit boundary (guarded by the
checkpoint-stack read at __state offset 48) — and graph_mutated is
LEGITIMATELY multi-handler (lsp.mn:677's arm + the oracle's
project_queue_merger), so m2's evidence walk is the CORRECT tier. MEASURED TO THE ROOT'S DOORSTEP: m3's arm line 129 is the
SingletonUninstalled floor — "singleton op call with no live install:
lsp_adapter" — the converged judgment resolved graph_mutated to the
SINGLETON tier keyed on lsp_adapter (ONE of its two handlers), so
every compile's first commit-boundary mint hits the armed guard. Boot's
judgment saw both handlers (ambiguous → the evidence walk m2 carries —
correct). THE REMAINING WHY, one read from closed: where the op→handler
edge evolution lives (unique → ambiguous on second sight) and which of
the two registrations the quiet rounds lose — lsp_adapter registers via
HandlerDeclStmt (the prepass re-registers per round) while the oracle
merger's edge likely draws at its INSTALL SITE during the walk; if the
edge home resets per round while only decl-side edges re-draw, the
install-side sighting is lost and the op reads unique. FIXED AND PROVEN (2026-07-26): branch_replay_one re-runs
draw_op_edges' default/ambiguous algebra against the root's live entry
(the branch's verdict as the sighting, disc joined monotone) — and the
march ruled ✓✓ TRANSITION m3 == m4 at 298,595 lines, census 0: THE
CONVERGED JUDGMENT REPRODUCES ITSELF. Boot repinned to 2257e06c
(UNBLESSED — PROVENANCE unwritten). THE BOARD AT THE PIN: frontier
279/0 · proof-exactness 9/9 · crown 5/5 · in-process battery 114 ·
census 0 · comment-refs 0 · micros-through-m2 113/1 — ONE RED:
payloadfn (RUN exit 134, want 2 — the payload-ladder micro re-banked
at its true value in the trecordopen landing, now trapping under the
converged judgment). The last gate before blessing, MEASURED TO THE FRAME
(2026-07-26): the gate's wat traps at lambda_72481 ← op_collect_emit —
INSIDE the install-site lambda `(r) => r.beta`, at the
"field offset unprovable" floor (line 3053 of the gate wat; the
singleton guard at 3026 sits on a dead path both wats share). THE
EXACT DIVERGENCE, twin-artifact-proven: the BATTERY's wat
(.build/test/mn-payloadfn.wat — battery_compile = SINGLE-pass
infer_program) runs exit 2 — the lambda's ρ resolves; the GATE's wat
(.build/probe/gate/micro-payloadfn.wat — the stdin CONVERGED path)
floors — ρ free at emit. So the converged rounds sever the resolution
chain that binds the lambda's open-record residual to run()'s concrete
payload: the chain runs arm-f(v) ~ handler-sig f-node ~ install-site
lambda + op-sig x ~ payload, across three stmts on shared sig/op
nodes — and the rounds RE-REGISTER handler sigs and effect ops per
round (fresh node generations), so the final round's cross-stmt chain
must land on ONE generation; somewhere it straddles two (or an
instantiation copies where single-pass kept the live node). THE TWIN EXPERIMENTS RAN
(2026-07-26, both bypasses built, measured, and RESTORED — the tree
holds the whole design): (a) rounds bypassed (trial+final only,
bracket ON) → 134 — THE ROUNDS ARE INNOCENT; (b) bracket bypassed
(plain infer_stmt in the planned walk) → 2 — THE BRACKET IS CONVICTED.
And the layering is RIGHT: VarRef(collect) draws VarLookup at
infer.mn:2257, so main layers after the handler decl and its base
holds the replayed post-arms scheme. The seam therefore lives in what
the bracket changes about the ARM'S ROW CHAIN: bracket-free, main's
install-unify lands on the arm's LIVE row node and run()'s later
emit-bind flows concreteness into the shared class before emit reads
the offset; bracketed, some link of that chain (the re-generalization
quantifying the arm's still-free row? the replayed scheme's
instantiation copying where root-live shared?) severs. THE ONE PROBE
that decides it: eprint at resolve_field_offset's -1 arm printing the
receiver row's CHASED state (tail var handle + binding), run the micro
bracket-on vs bracket-off, diff the two prints — the free node's
identity names the severed link; fix at that link, re-march, THEN
bless (PROVENANCE with the re-read sha + the §7 ledger
entry for the whole arc: the fixpoint rounds, the branch bracket, the
wrong-end stack, the exit-code contract, the edge-evolution join, the
fmt hook; the crossing-form row_print inlines back in the
generation AFTER the blessed pin).
(That payloadfn seam RESOLVED in the same arc — parse-truth layers;
the pin blessed at 512a4c85; the value-boundary landing then closed
the census-3 residue whole.) The fmt write-time hook
(post-edit-mn.sh's fmt rung — parse verdict from the parser's own P_
lines on a scratch copy, both faces seen RED/GREEN) guards every edit. The field-access cluster landed as an audit-driven interleave
(pins f0ab3177 + 723220b3 — the last known silent-wrong class closed).
C1c-2's REMAINDER — the first join design (state-delta replay) was
REFUTED by the adversarial pass (2026-07-25, thirteen findings, the
two sharpest orchestrator-re-verified in the artifact), and the
REVISED design supersedes it in place:
THE BRANCH BRACKET, revised. Per-stmt cursor composition mirroring the
root's order (stmt ~> infer_ctx ~> fresh_for_inference ~>
summaries_frozen(idx) THREADED from infer_program_final — a fresh ctx
answers UZero for every grade and mis-codegens dispatch; keep the
classify entries, smap_build once ~> affine_ledger ~> region_tracker
~> verify_ledger(fresh) ~> lookup_ty_graph ~> env_handler(base triple)
~> graph_handler(shared spine + planned range) ~> mutate_sink ~> diag
collector ~> intern view). THE JOIN IS AN ORDERED EVENT-LOG REPLAY,
NEVER A STATE-DELTA MERGE: each branch banks ONE interleaved stream
(rendered diagnostic lines + consume events + verify events + env
publishes, in occurrence order — separate per-handler deltas cannot
reproduce the interleaving, and verify's prepend discipline only
event-order preserves), and READ-MODIFY-WRITE env updates RE-RUN as
OPERATIONS at the join: draw_op_edges evolves (default, ambiguous,
disc) per arm against the live env — two same-layer handlers of one
op under value-replay lose the ambiguity join and cash a wrong
singleton direct call, so the branch banks (arms, hname) and the join
re-runs the edge-draw in walk order. DIAGNOSTICS RENDER AT COLLECT
(the root arm renders live at the perform; a banked DiagKind replayed
post-join renders against MOVED vars — bank the rendered line +
severity + refuses-bit; counts fold at the join). OVERFLOW IS A LOUD
ABORT-AND-REQUEUE built into the branch's graph arms — the landed
overflow jump is ROOT-ONLY semantics (mint_high is not config and
inits 0: a branch ceiling hit would mint handle 0 over the shared
Module root's cell — verified live). FAN BARRIERS, computed at plan
time: unkeyed stmts (the ""-key contract degrades to source order
sequentially and becomes a live race concurrently) AND readers of
monomorphic-with-free-residual publishes (graph binds are NOT
range-confined — unification chases to sub-frontier shared cells, and
a free residual's first same-layer reader binds it; under the fan the
winner is schedule-dependent) — each such stmt runs sequentially
post-join or as its own layer; a branch's sub-frontier bind of a FREE
cell may alternatively abort-and-requeue. JOIN PROPAGATION: the root
epoch advances by each branch's bind-count (the IC key and a diag
payload both read it). INTERN: the read-only loud-miss view (a fresh
instance forks handle identity; the TRIAL IS THE PRE-WARM — both
passes share one table, every final-pass intern is a probe hit, and
the loud miss turns any counterexample into a diagnosis). THE GATE,
three legs: byte-equality of the WAT against the layer-walk pin
(joined per LAYER, not per stmt — per-stmt joins never exercise
base-visibility semantics and sail through green); an ERRORING
fixture whose full stderr compares byte-for-byte through the bracket
(the wheel is census-0, so WAT identity alone is vacuous on
diagnostics); and post-fan address + IC-epoch probes. Then THE FAN: K
spawned cursors over a shared CAS counter — with the pointer-identity
census instrument run under it (branch-allocated record ADDRESSES
become schedule-dependent; any surviving pointer-eq compare is
convicted there) and the CAS-bump allocation tax measured before the
layer commits (the wheel-as-spawning-module memory flip is a
TRANSITION). The branch bracket is the fused oracle's own substrate: the
compile-spine fan and the synth candidate fan are ONE machinery, two
workloads. THE DEBT HIERARCHY (trued 2026-07-25 against §5's
trustworthiness conjunction — the silent-wrong classes were the FLOOR'S
debt, not the whole): (1) the correctness oracle is still EXTERNAL
(micros/battery judge the medium; correctness-oracle-internal + DDC are
the deepest !Outside residue, gated on native); (2) the modal crown (band
A/E — the open theoretical differentiator); (3) the gradient as the daily
instrument (phase D — the ranker is gates×proximity, not yet the
Reason-chain local-intent read). RANKED RESIDUE QUEUE:
type-decl-name-registry (silent tag-merge; SchemeKind representation
change; builder dispatched) · Hβ.effects.same-name-fragments-coexist +
Hβ.emit.arm-under-install-instantiation (the L1→L2 pair that closes the
six 134-banked payload micros; the arm-spec-twin predecessor REFUTED —
the ledger entry carries the split and the probes) · handler-config
defaults (builder dispatched) · THE FMT SUMMIT — now MEASURED (the
fleet census, 2026-07-25: 49 of 50 wheel files cannot format; the
fmt-demo fixture undersamples every broken surface — no with-clause,
no handler decl). The blocker ladder, in order, each RED-first: (1)
the with-clause render reads the parser's SIGNED TRIPLES as bare
EffNames — ≥2 entries trap in the dedup, exactly 1 silently renders
«invalid-effect», destroying 41 declared rows across the five
pass-once files; the fix renders the authored signed list directly
(also the only faithful render for !/-/& — a closed-row rebuild
cannot represent them); (2) render_handler_arms reads OPEN arm
records (the trecordopen family at the formatter — the emitter
floored it; every handler decl traps) — the typed closed projections
handler_arm_op_name/arity/body already exist and are bypassed; (3)
arm-body brace discipline = render∘parse identity — braces accrete
per pass (+423 sites over 7 files) and pass-2 re-parses `{ x }` as
the record pun {x: x}, a SEMANTIC FLIP (tensor.mn's float became a
record); (4) FnStmt render drops authored return types (91 heads);
(5) the comment weave renders only at statement altitude — 32% of
parser.mn's prose (272 interior lines) silently lost, violating
SYNTAX's "never dropped"; (6) shortest-round-trip float render
(1.0 → sixteen digits today). Baseline trued: 778 E_RedundantBraces;
the summit run (whole-wheel fmt → census 0 → fixpoint → formatted
source canonical) only after 1–6 ·
E_EffectMismatch arming (licence-gated). The
overlay dissolution LANDED (pin 6913e09d).

**One bar, both audiences** (decided with Morgan 2026-07-16): the external
early adopter who clones, installs, and ships a wasm artifact from an
arbitrary directory; and the founding research use — the cross-frequency-
coupling pipeline on real recordings. The bar's definition is the medium's
own, never borrowed stability theater: **production-ready = the medium
keeps its own promises mechanically.** Every claim it makes about a program
is true (no known silent-wrong class); every refusal teaches; the green
board (`tools/state.sh`) IS the release gate; and the felt loop closes —
hole → proven proposal → patch → run. Each item below is BUILT (landing
whole, gated, marched) or the label does not apply; the NOT-REQUIRED list
at the end is part of the bar, not an omission.

**The novelty audit governs every item** (run 2026-07-16 against the whole
roadmap): a borrowed best practice survives only where it empowers the
medium; where Mentl's structure supplies a stronger form, the native form
wins. Rejected borrowed shapes, with their native replacements: version
managers / semver → **the pin IS the release** (boot + the PROVENANCE
chain of self-confirmed fixpoints; the march is the updater; PROVENANCE
ships as the release notes); manifest files → **the imports ARE the
manifest** (the kernel already holds the dep DAG as edges; `mentl new`
scaffolds a source file, never config; the project's endpoint is the
persisted graph image, `Hβ.persist.module-image-cache`); generic random
compiler testing → **the oracle IS the test generator** (`enumerate_inhabitants`
multi-shot-searches program space as the generator; wasm-tools reduces a
failing case to minimal form);
C-FFI-style GPU marshaling → **thunk-as-record memcpy** (§5.U: a branch
thunk is a contiguous image record; the device crossing is the same
operation as persist — SPACE = TIME = DEVICE). Kept borrowed substrate,
named scaffold-tier (§6): the PATH shim (a POINTER to the live boot, never
a copy), GitHub Actions as CI transport, HIP text emission (a projection to
a foreign assembler, exactly like WAT), the verb surface (`mentl check
<path>` is a transport; the endpoint is the cursor-address form —
`mentl <address>` projecting the eight aspects).

**The named-peer audit** (2026-07-16, Morgan's charge: a "named peer" can
be honest sequencing or fear wearing a name — run the eight interrogations
across ALL of them and ask for the interconnectedness). Four verdicts,
each a PLAN correction: (1) the name-is-handle cluster is ONE design in
five names — `Hβ.perf.name-is-handle` / EffName-is-a-handle /
`Hβ.runtime.indexed-map-primitive` / esc-row-on-node / reach-edge-on-node
all reduce to "a name re-derives what an edge connects", and the banked
smap-first sequencing is INVERTED (str_hash-keyed maps re-key by handle
when interning lands — the migration paid twice); intern-at-lex leads,
the maps land handle-keyed once. (2) `Hβ.cursor.session-weave-epoch-scope`
DISSOLVES — it names a symptom of the edit transport re-parsing per
projection; the required session `<~` loop (one graph, IC re-projection)
deletes the multi-generation weave, so the two hole classifiers re-unify
for free; never build the filter. (3) `Hβ.lower.partial-effectful-callee`
and `.partial-local-callee` MERGE into partial-via-lambda-recipe — both
name the same gap (the mint bypassed the LambdaExpr machinery: frame
entry, capture resolution, derive_ev_slots); one landing.
(4) `Hβ.infer.alias-preserving-unify` is governed by the unpatchability
theorem: the design is a representative-choice PROJECTION (the union-find
class exposes its most-refined member), never an arm edit inside
unify_types. Everything else interrogated held: the region arc's stages
are genuinely ordered (each gates the next), band L's diagnostics arms
share the catalog-as-projection umbrella, band M's transports are honest
parallel handler swaps, and the trust trio (the generative self-test loop →
correctness-oracle-internal, diverse-double-compilation) is distinct with
the self-test loop feeding both.

### Column 1 — install & the project story

- **The resolver arm**: `driver_module_path` (src/driver.mn:27) resolves an
  arg naming an EXISTING file path as itself (as given or absolute) before
  the src/-then-lib/ repo fallback; stdlib imports from user projects
  resolve via the MENTL_HOME-rooted lib/. `path_to_module` (src/main.mn)
  passes path-shaped args through.
- **tools/install.sh** → `~/.local/bin/mentl`: bakes MENTL_HOME, sources
  tools/wt-env.sh (the one flag home), execs wasmtime on
  `$MENTL_HOME/boot/mentl.wasm` with `--dir "$PWD" --dir /tmp --dir
  "$MENTL_HOME"` and stdin passthrough. Up-to-date BY CONSTRUCTION: the
  shim points at the live pinned boot — every re-pin is instantly the
  global CLI.
- `mentl new` scaffolds a runnable source file — no manifest, ever.
- The release = a tagged pin: boot + PROVENANCE-as-release-notes.
- README quickstart: clone → install.sh → `mentl run` in five commands.

### Column 2 — the correctness spine (no known silent-wrong class)

**THE FLEET'S CORRECTION (2026-07-17, 89 agents / 0 errors / 15.3M tokens;
full harvest in git history: docs/research/production-bar-fleet-2026-07-17.md; 115 designs,
91 adversarial verdicts, every one verified against the artifact before it was
banked here).** Four of its findings overturn what this section said, and each
is re-measured by hand:
- **The census is NOT 2,266 independent bugs — most are a handful of roots,
  and four of them are now FELLED (2266 → 727).** LANDED 2026-07-17: bare-List
  in declarations (`Hβ.types.bare-list-erases-its-element`, Stage 1a, 2266 →
  1233); `check_ref_escape` deleted (`Hβ.own.delete-check-ref-escape`, Stage
  1b); the refined-alias forward-reference (`Hβ.infer.alias-preserving-unify`,
  1233 → 874); and the bare-parameterized-type-arity
  (`Hβ.infer.bare-parameterized-type-arity`, 874 → 727) — the `0 vs 1` class
  was mostly `env_lookup(String) -> Option` erasing its `Option((Scheme,
  Reason, SchemeKind))`, plus its Option/List sibling declarations across
  mentl/lsp/voice/query/cursor. Each was Carried-Truth: a consumer or handler
  already proves the type the declaration erased; the fix reads it live.
  Residue: `Buffer` needs `Buffer(a)` parameterization (genuinely generic, 7
  sites — named, not forced). The remaining census is the ownership root (356
  `escapes its scope (returned)`,
  `Hβ.infer.usage-grade-unifies-cardinality-ownership`, a peer the medium names
  in its own source) plus OccursCheck / MissingVariable / EffectMismatch /
  PurityViolated classes — a short list, not a wall of 2,266.
- **"name-is-handle roots BOTH spines" is half wrong.** ZERO of the 2,266 are
  name-identity failures, so it roots the PERFORMANCE floor only; the
  correctness spine's root is the two arity/grade items above. The named-peer
  audit's verdict (1) stands for §5.O and is corrected here.
- **"The imports ARE the manifest" — CLOSED 2026-07-18** (the fleet had
  measured it false: zero prelude imports, 16MB of non-assembling emit).
  `mentl compile main` now emits the whole wheel with ZERO diagnostics,
  it assembles, and the DAG-built wheel compiles and runs programs: the
  prelude seeds the DAG where it resolves, every module declares its real
  deps, keyword-spelled import segments parse (`import own`), and the
  weave order is canonical (the discovery walk finds the SET; the sort
  fixes the WEAVE to the blob's own order). Residue: the named
  order-independence and clobber peers (named-residue index).
- **`Hβ.medium.cannot-observe-its-own-programs` — THE RISK NOBODY NAMED, and
  the fleet's deepest finding.** Thirty items were independently refuted for
  having a gate that CANNOT FAIL. That is not thirty bad designs; it is one
  missing capability, and it means **the bar as written cannot be measured.**
  Sharpest instance: any thread-determinism gate built on `wt_m2_ensure`
  passes vacuously forever — `wt_m2_key()` = sha256(wheel + boot + flags),
  containing neither spawn order nor affinity, so all runs share one cache
  entry and `diff` compares a file to itself. A determinism gate keyed on the
  assumption of determinism is circular by construction.

**THE COLUMN'S OWN MEASUREMENT, taken 2026-07-16 and previously unmade: the
medium reports 2,266 errors about its OWN source and emits a working
compiler anyway.** Nobody had counted, because the census was filed under an
alibi that expired at first light — "the disposable seed's weaker inference
lags" (verify-baseline, 2026-06-22), written eighteen days before the seed
was deleted (7401c4b). boot IS the wheel, so those are the wheel's
diagnostics about the wheel. Under the alibi sat a real dead-code bug
(format.mn's `NPipeExpr` ghost, six spanned diagnostics, a `_` catch-all
swallowing five verb arms). "No known silent-wrong class" is not a
checklist of peers below — **it is that number reaching 0**, and every peer
in this column is one of its classes.

- **`Hβ.diag.refusal-law-per-class` — THE COLUMN'S SPINE.** An executable
  emits IFF every claim in its reachable tree is discharged, and the exit
  code is a projection of the diagnostic ledger, never a fabricated 0
  (`mentl check <missing>` printed E_MissingModule and exited 0). The
  all-at-once form — "refuse on any SError" — was designed, dispatched to an
  adversarial fleet, and REFUTED on the artifact: it refuses the wheel
  itself at 2,266, and 3 independent verifiers killed it. The target does
  not lower; the WORK sequences (§9.3). So the classes turn on **ONE AT A
  TIME, each when the wheel's own census of that class reaches zero**, and
  the census ratchet (tools/verify-baseline.txt) holds it there — a class at
  zero can be gated and can never ungate — **AND the user path must be clean
  too** (the panel's 2026-07-18 licence correction: blob-census-zero alone is
  circular — users compile via stdin-without-lib and the import DAG, whose
  diagnostic sets differ from the blob's, so a name-dependent class at
  blob-zero can still falsely refuse a correct stdlib-using program until the
  manifest work lands). ARMED (2026-07-18): E_UnresolvedHole (the hole gate)
  · E_MissingModule · E_HandlerStateShadowsOp and E_DuplicateFnName (born
  armed — decl-site facts, no resolution dependency; the state-shadow
  collision measured compiling clean with a WRONG value, and the arming
  commit's own m3 leg caught the wheel's second violation, `caret`) ·
  E_RefinementRejected (the prior "landed and locked" claim here was FALSE —
  a decidable-false `let bad: Sample = 1.5` emitted 2,513 bytes at exit 0;
  armed with the UNeg const fold, which immediately caught the wheel
  fabricating tag -1 into TagId's refinement — deleted into LPUnresolvedCon)
  · E_OwnershipViolation (its unresolved-callee false channel died with
  graph_bind_hole + the callee-miss borrow guard). ARMED
  2026-07-18 (the seventh, the manifest arc's dividend): E_MissingVariable —
  wheel census 0 AND the user-path licence measured (a no-import stdlib
  program resolves via the DAG's prelude seed and runs; the stdin contract
  is self-contained input, where a miss is a real break). E_OccursCheck ARMED same
  day (the eighth) — its refusal fixture FOUND the trap it now gates:
  `fn selfapply(f) = f(f)` spun chase_deep/subst_ty to stack exhaustion
  with zero reports, because the occurs leaf compared handles while the
  cycle lived in BOUND structure (graph_bind(a, TFun([b], r)) first;
  graph_bind(b, TVar(a)) closes it). The leaf now recurses into the root's binding —
  raw handle, then root, then binding — so the write guard is total, the
  graph stays acyclic by invariant, and the shape reports + refuses
  (`Hβ.infer.selfapply-cyclic-ty-spin` CLOSED; chase_deep keeps a
  depth tripwire as the belt). The occurs phantom cascade itself stays
  DEAD (an env miss binds NErrorHole via graph_bind_hole — one miss,
  one diagnostic). The work,
  by class: the census is ZERO (2026-07-18 end-of-day; from 2,266) — every
  class's wheel-side arming precondition is MET. The user-path condition
  (the panel's licence correction) still gates name-dependent classes
  (TypeMismatch and kin fire on partial-link paths — the runtime shadow's
  3 lib-isolation errors are the proof) on the manifest arc. EffectMismatch / PurityViolated / IfMissingElse / PatternInexhaustive /
  FeedbackNoContext / ConstructorArity / ResumeOutsideArm all reached ZERO
  on 2026-07-18 (the §7 ledger holds each root). The mechanism is `diag_refuses`
  (a projection beside `diag_severity`, types.mn:1506) + the count on
  diagnostics_handler's own state + one live read at executable_gate. Do NOT
  declare the op before the arm and the gate land together — a declared
  `refusals()` with no arm shipped for one commit here and is drift-9 wearing
  a good idea's face. **The novelty is the self-hosting property doing the
  work:** rustc/tsc gate errors from day one because they never had errors on
  their own source; TypeScript's `strict` family and Rust's lint levels are
  per-flag opt-ins a project may never turn on. Here the wheel is the
  medium's first user, so "a class the medium never violates on itself" is a
  MECHANICAL license to enforce it on everyone — dogfooding as a formal gate,
  and the ratchet makes it monotone. When the last class flips, the census
  line and `diag_refuses` are both DELETED and the law is just
  `diag_severity(d) == SError`.
- **`Hβ.effects.declared-row-truth` — the eight fns whose declared row is
  narrower than their body** (any_imports · collect_hash_tys_expr ·
  collect_hash_tys_list · collect_show_tys_expr · ctor_payload_tys ·
  cursor_argmax_compute · emit_distinct_compare_helpers ·
  emit_distinct_eq_leaves · emit_distinct_hash_leaves ·
  emit_distinct_show_leaves · emit_eq_leaf_sum · emit_fold_hash_helpers).
  Exposed by the `++`-carries-its-callee's-row fix compounding through the
  re-pin: boot now knows `++` allocates, so the medium re-judged its own
  source and caught them (+3 E_EffectMismatch, +5 E_PurityViolated). They
  were false before the fix; only now can the medium say so. Each widening
  ripples into its callers' declared rows — measure the cascade before
  starting it. The first ratchet-DOWN target.
- **`Hβ.infer.seq-op-row-from-callee`** — `infer_seq_op` (infer.mn:1064) ends
  with a hardcoded `inf_add_row(mk_ef_closed([ENamed("Memory")]))` for the
  whole `len`/`push`/`slice`/`list_concat`/`make_list` family, **dropping
  Alloc** — so `list_concat` is attributed Memory-only while its own
  declaration (lists.mn:234) says `with Memory + Alloc`. The `++` sibling of
  this bug is fixed (BKConcat reads the callee's row live via
  `concat_callee_row`); this is the same fabrication one arm over, and the
  fix is the same deletion: read the declared row live via
  `graph_chase(fh)` (the same read `infer_call_saturated` makes — `fh` is
  bound by `infer_expr(func)` before the call), delete the hardcode. Note
  PLAN §7 records "infer_seq_op dissolved" (2026-07-08) — the special-case
  path is still there; the doc is ahead of the artifact. **DEP-gated on
  `Hβ.perf.per-decl-arena` (§5.O), MEASURED 2026-07-17.** The fix was built
  and marched: it is correct (m3 is clean) but m2 ≠ m3 by 302 lines — the
  extra Alloc attribution shifts ev-slot emit — and the slightly larger wheel
  compile then OOMs m3 in `infer_program` (memory fault at 0x100000000, a
  shallow stack, not a logic loop). Correct row attribution costs ev-slots,
  and the 4GB never-free bump image has no headroom for them. So this waits on
  the per-decl-arena collapsing the working set; until then the Memory floor
  holds — a NAMED under-attribution, the at-site comment carrying the fix.
- **`Hβ.cli.process-exec-wire` — CLOSED BY MEASUREMENT (2026-07-18):**
  `run_run` routes `process_exec ~> process_no_exec`, which REFUSES (exit 1,
  zero fabrication) and teaches the shim as the seam's owner — verified by
  executing the run verb against the pinned boot. The earlier entry here
  (fabricated exit 0) described a state some prior session already fixed;
  the doc lagged the artifact.
- **`Hβ.parser.refined-alias-nonatomic-base`** — LANDED 2026-07-17. SYNTAX's
  own canonical `type NonEmpty = [a] where len(self) > 0` (docs/SYNTAX.md:990)
  did not parse: `parse_type_decl` probed only `p2 + 1` for `where`, so a
  multi-token base (`[Int]` is three tokens) put `where` out of reach —
  `P_UnexpectedToken` on `where` at the `]`, then `E_MissingVariable` on the
  orphaned len/self. The fix parses the whole base type FIRST, then branches on
  what follows (`where` refines / `|`+`-`& is a variant/row / a ctor payload is
  a single-variant ADT / nothing is a transparent alias). The wheel uses no
  such form, so m2 == m3 stayed byte-identical, but the parser fn's own bytes
  changed — the case where a change is wheel-neutral yet TOOL-changing, so boot
  was re-pinned (the fix is not live until boot carries it). Guarded by
  tests/frontier/mn-refined-alias-nonatomic.mn (frontier 47 → 50) — tooling
  improved with the medium in the same change.
- `Hβ.perf.name-is-handle` / EffName-is-a-handle: the crown's positive
  residual (~146 false mismatches) + the by-name family deletion (design
  banked, §5.O layer 1). Roots the PERFORMANCE floor only — see the fleet's
  correction above; zero census errors are name-identity failures.
- `Hβ.effects.parameterized-negation-instance` (instance-precise
  `!Sample(44100)`).
- `Hβ.infer.alias-preserving-unify` — LANDED 2026-07-17 (census 1233 → 874,
  the single biggest root: 362 = `Span vs ValidSpan` + `Int vs ValidOffset`,
  both directions). The root was forward-reference order all along, and my
  own banked "ruled it out" was the drift: `pre_register_decls` ran ONE
  source-order pass, so a fn signature quantified before its refined alias was
  declared (parser.mn's `span: ValidSpan` precedes types.mn, which sorts last
  in the concatenated wheel) called `quantify_ctor_ty` against an env that did
  not yet hold the alias edge, and baked a bare nominal `TName("ValidSpan")`
  into both the param handle and the fn scheme; the main walk then tried to
  refine that bare name to its live `TAlias(ValidSpan, TRefined(Span, _))` and
  `unify(bare-TName, Span)` floored at the leaf. The earlier "a two-pass moved
  the census ZERO" was measured against BOOT's census (old inference judging
  the source), NEVER the FIXED compiler's — the trap the ⟲ pipeline names (a
  label is a hypothesis until the ARTIFACT confirms it; the verifier's
  included). The controlled experiment settled it: a refined alias used BEFORE
  its declaration mismatches, declared-first is clean. Fix (`pre_register_alias`):
  register the alias edges in a phase BEFORE any fn signature, so the resolver
  reads the LIVE edge. Carried-Truth exactly — the graph drew the alias; the
  resolver re-derived a name; the fix is at the ORIGIN, never a new arm in
  unify_types (the unpatchability theorem holds). Emit byte-identical (an error
  hole and a resolved TAlias both lower at word width, same codegen), so m2 ==
  m3 as a clean fixed point; boot re-pinned because the compiler binary changed
  (wheel-neutral yet tool-changing). Guarded RED-first by
  tests/frontier/mn-refined-alias-forward-ref.mn (fails `Pos vs Int` on the
  old boot, runs to 42 on this one).
- backtrack's `() vs Option(())` mismatch (search.mn).
- `E_ResumeWorldMismatchWorld` wire-or-delete (band B).
- **R3 — LANDED 2026-07-19** (the ultracode batch): the GROUND-decidable
  arithmetic fragment — node_const_at folds +,-,*,/,% over ground Int/Float
  operands, nested `self` resolves through the PWithSelf binder, zero nodes
  minted, div/mod-by-zero refuses to fold. Proven-false constructions REFUSE
  under the armed class; SYNTAX's own Even discharges. The residue is honest:
  free-variable linear arithmetic and uninterpreted fns stay V_Pending — the
  SMT tier's named ground (Hβ.verify.smt-handler-swap).
- `Hβ.diag.duplicate-type-name` decl-site refusal (band L).
- **The generative self-test loop — LANDED 2026-07-19** (tools/oracle-selftest.sh
  + the tests/selftest corpus): the medium proposes through the edit transport,
  each variant compiles/assembles/runs/classifies, a failing case reduces to
  minimal form via wasm-tools (842B -> 131B first run), crucibles bank with
  reproduce-READMEs. Run one surfaced four real correctness bugs (two
  float-evidence hits, the f64-through-_start emit class
  Hβ.emit.f64-main-start-boundary, and the proven-fill zero-divisor — proof
  filters admissible VALUES, not the program around them, §1 made executable).
  Its CHANGED detector caught a banked case graduating. Whole-program SHAPE
  generation stays the named v1 limit.

### Column 3 — the performance floor (§5.O completion)

- Name-is-handle FIRST (the peer-audit inversion): intern at lex, then
  the five str_hash waypoints land as ONE handle-keyed map primitive
  (`Hβ.runtime.indexed-map-primitive`) — never str_hash-keyed twice. This
  is also column 2's EffName item: one design, five former names.
- `Hβ.lower.reach-membership-o1` · `Hβ.infer.instantiate-shares-never-clones`.
- **The per-decl arena arc** (unblocked 2026-07-16 — regions live, returns
  transfer, Hylo-quiet on the wheel): class-aware region-tag lookup →
  result/argument region POLYMORPHISM (before any mutation-site check — a
  naive store-check false-floods the ref-buffer idiom) → the image/scratch
  allocator split → the emit_memory_arena swap. The region drop IS the
  arena reset; `!Alloc` after a reset becomes provable; persist-as-memcpy
  composes per-slab.
- Layer 4: parallel cursors (`Hβ.driver.level-set-par-walk` multi-core).
- The perf ledger runs per-commit in CI (tools/ci/run-board.sh; fixed
  hardware sharpens it once the MI300X arc begins).

### Column 4 — the felt surface

- The session `<~` loop: `mentl edit` as a LIVING loop (today: one
  projection + one action per invocation; the LFeedback iterate context is
  the wiring).
- Fill-and-resume: the hole→dormant-continuation edge (the k record exists
  — k1 built it; band M's hole-is-dormant-continuation).
- The LSP transport (`Hβ.felt.lsp-transport-projection`) — vim/VS Code get
  the same projections.
- IC-riding reactivity in the IDE (today: re-instantiate per compile).
- doc/test/new verb transports; `Hβ.diag.catalog-as-projection`;
  `Hβ.cli.audit-row-var-render`.
- Tutorial + stdlib reference via `mentl doc`.
- **The CFC pipeline end-to-end on CPU**: lib/dsp/signal.mn grows
  stft/bandpass/comodulogram; a real recording processed — the research
  half of the bar.
- The cursor-address surface named as the CLI's endpoint:
  `mentl <address>` → the eight-aspect projection (drift-38's at-cursor
  law; the verbs remain as transports).

### Column 5 — trust & ops

- **CI: the LOCAL board is the gate; hosted CI returns on capable
  hardware** (Morgan's call, 2026-07-23 — the alive-law exercised on
  this column's own "REQUIRED"). The GitHub workflow was DELETED: its
  runner could not hold the board (45-min ceiling and ~7GB RAM against
  the wheel compile + the full gate battery + 4GB shared-memory
  modules), so at this project's landing cadence every push was a
  lagging "Run failed" — noise, not a gate. The REAL gate never moved:
  every landing runs the board locally (march + frontier +
  proof-exactness + crown + verify through the pre-commit hook) BEFORE
  its commit, and the pin is not blessed until PROVENANCE is written.
  Hosted CI returns when a runner can hold the board whole — the
  MI300X arc's fixed hardware (where the perf ledger is sharpest), or
  any always-on Linux with the resources; tools/ci/run-board.sh stays
  as the one entry point it will re-wire to.
- Diverse double-compilation (band J — trusting-trust).
- License + public-repo readiness (the landed commits are pushed).
- `Hβ.closure.correctness-oracle-internal` stays NAMED as the bar's own
  residual !Outside (the micro battery is an external oracle until the
  wheel's Verify subsumes it).

### THE LAST ARC — the MI300X (after everything above; NOT required)

Morgan's call (2026-07-16): the box (an AMD-hosted Instinct MI300X, ROCm
JAX prebuilt image) is the FINAL arc, gated on every required column
landing first. Its stages, in order: recon (docs/ops/mi300x.md — access
mode, daemon persistence, hipcc, egress) → the JAX baseline (the CFC
comodulogram in JAX on the same silicon — the SOTA number the Mentl
pipeline races; JAX is §4②'s own foil) → CI relocated to the box (fixed
hardware makes the perf ledger sharpest) → the `~> Gpu` spike (band E,
scoped: ONE `><` fanout of pure f64 kernels; the branch thunk ships to
the device by MEMCPY — the §5.U record law; HIP text emission as the
projection scaffold; the thesis gate: SAME source under
`~> Seq`/`~> Thread`/`~> Gpu`, identical results, race-freedom carried by
the ownership proof) → the CFC flagship raced against the baseline.

### NOT required for the label (the unsurpassable tier continues after)

The MI300X arc above · native backend (docs/NATIVE.md) · the modal
world-index (§4③'s crown remainder) · IFC/`!Flow` (band C) · GPU offload ·
wasmFX. Naming these is part of the bar: a hidden gap is drift; a named
positive-form peer is the ultimate form.
