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
masked triple. The landing record keeps the era's vocabulary; the `LEDGER.md`
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

   **THE FORK/MERGE DUALITY — why the two halves compose, and where the
   human is irreducible (crystallized 2026-07-30, the words Morgan had
   been reaching for).** The fan and the e-graph are not one mechanism
   and not two features: they are DUALS over two different spaces, and
   the composition's direction is forced.
   - **MEANING-space is explored by FORKING; FORM-space by MERGING.** The
     fan's candidates MEAN different things (`0` and `sum(abs(xs))` are
     rivals), so each needs isolation — checkpoint, per-branch world,
     rollback — because candidates CONFLICT. The e-graph's members mean
     the SAME thing by construction, so merging needs no isolation at
     all: equals compose, saturation is monotone, nothing is ever undone.
     That asymmetry IS why one required the whole trail-and-spawn
     substrate and the other runs free inside lower — not an
     implementation accident.
   - **Proof is a FILTER over meaning (binary: admit / refuse); cost is
     an ORDER over form (total: take the minimum).**
   - **A TIE IN FORM-SPACE IS FREE; A TIE IN MEANING-SPACE IS A
     QUESTION.** Two cost-minimal members are EQUAL — pick either, it
     cannot matter. Two proven survivors MEAN different things and the
     graph does not contain the answer, so the medium cannot pick and
     must ASK. This is where the human is irreplaceable, and it is
     DERIVED here rather than asserted: §1's teaching tie-break is not a
     nicety bolted onto the fan — it is what the fork side IS when it
     terminates with more than one survivor, and §0's "intent is the one
     genuine Outside" is the same fact read at the thesis altitude.
   - **The order is FORCED.** Extract-then-prove would optimize a
     program that may be inadmissible; prove-then-extract is the only
     composition that holds. "Proven AND optimal" is therefore one
     pipeline with a mandatory direction, never two features stapled.
   - **The effect row plays BOTH halves, differently:** it gates which
     REWRITES are legal (a dropping rewrite fires only when the dropped
     operand's row subsumes pure) and which CANDIDATES are legal (no
     survivor violates its `!E`). Form-legality and meaning-legality,
     one algebra at two altitudes — the crown paying for both.
   STATE, honestly: the fan rides real spawned branch cursors and the
   e-graph is live and effect-aware in lower, and they are NOT yet
   fused — the composition above is designed, not built. Building it is
   what makes a proposal extraction-optimal rather than merely proven.

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
  (`LEDGER.md`). The LEAF GENERATORS remain four: conjunction / first-nonzero
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

**COST IS ON THE BOARD (Morgan 2026-07-31, the OOM's law) —
RE-INSTRUMENTED 2026-08-07 (the arena's build step 0,
`Hβ.perf.per-decl-arena`).** The march's m3 leg — the self-compile —
runs under GNU time: the cost line prints per run, the pin's mechanical
block carries it, and `selfcompile_peak_kb_max` in verify-baseline
ratchets the peak (a breach refuses the repin, seen RED at ceiling 1).
Measured at the landing: ~8.4s wall, ~1.70GB peak RSS (three reads
within ±0.03% — the earlier "~694MB" claim was an era-stale number this
read corrects). The arena's win lands as that ceiling FALLING. state.sh
still shows the footprint; raising any ceiling stays an explicit
in-commit act, the census pattern applied to cost. Paid for by measurement: the judgment's peak moved
563MB → 3,044MB (07-25 → 07-29) across unmeasured landings and fell 823MB at
the rounds deletion, also unmeasured; a frontier edit-leg holding generations
in the never-free image reached 2,366MB and was the process the kernel killed
(2026-07-31) — layer 3's first field kill. The era-profile method (a
git-extracted boot compiling its own era's source under /usr/bin/time,
sha-stamped rows) is the standing backfill instrument; the 2026-07-31
session's reports under .build/research are its first corpus
(untracked session artifacts).

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

**D · The value layer — fold & repr (arms 1/7, §5.U; STEP 0/1/2 landed).** `Hβ.fold.show-leaf` (synthesize as a lowered LFn, not raw WAT; lower.mn:481) · `.compare-hash-leaf` · gate `Hβ.eq.fold-seed-value-gate` · `Hβ.repr.arrow-layout-interop` · `Hβ.emit.variant-payload-repr-width` (wasm.mn:4913) · `.plit-handle-repr` (wasm.mn:5537) · `Hβ.value.ontology-derivation-complete` *(LANDED 2026-07-21 — the `LEDGER.md` head carries the arc; the residue is the named narrowing/wide-stride/alias-edge tier. History of the derivation: DETAILED 2026-07-20 by a 13-agent adversarial ultracode pass — map + 4-design panel + per-design refutation; all four designs REFUTED, converging on ONE attractor, the truth signal. String = [byte] IS the §4① ultimate and is SOTA-validated (Rust's `str` = `[u8]` behind a fat-pointer view; Arrow's one-array-over-many-element-types with zero-copy slices; Harper–Morrisett intensional type analysis / TIL and Crary–Weirich type-erasure = "the proof becomes the dispatch"; and Haskell's `String = [Char]` cons-list disaster PROVES the representation must stay PACKED, element-projected, never the uniform list layout). BUT it is NOT a single landable change, and — the load-bearing catch — the NAÏVE type-first form SHIPS A SILENT-CORRUPTION REGRESSION THE SELF-HOSTING ORACLE IS STRUCTURALLY BLIND TO. Mechanism: `String → TAlias("String", TList(TByte))` types cheaply via the existing TAlias-peel (unify_types infer.mn:2337-2342), but then String unifies with `[a]` EVERYWHERE (today `same_ground` infer.mn:2381 makes TString unify with nothing but TString, so `map(f, "hi")` / `list_index(s,i)` is a CLEAN E_TypeMismatch — the merge removes that barrier); meanwhile the runtime keeps strings 1-byte-packed with a sign-bit view whose length relocates to +12, and lists 4-byte-strided behind a tag word — so any [Byte]-typed value that is physically a String, meeting any generic `[a]` consumer, lowers to `list_*` and reads packed bytes / the −1 view sentinel as count+tag → SILENT MEMORY CORRUPTION, no diagnostic, over an UNBOUNDED surface (every map/fold/user helper, not the ~10 enumerated dispatch sites). And `m3==m4` cannot distinguish correct from corrupt: a wheel disciplined to string-named ops on strings is emit-identical while user code corrupts — the oracle's blind spot. THE CORRECT SEQUENCE inverts every proposed design (representation FIRST, type-merge LAST): (0) add RI8 to the Repr ADT + a byte marker as zero-reader vocabulary (Law-7 no-op), and VALIDATE the repr-width-polymorphic flat leaf on WIDE elements first ([Float]/[i64] lists, RF64/RI64) where there is a clean consumer and NO header/view/discriminant collision — byte-packing is the NARROWEST, HARDEST end, not the place to start; (1) the emit consolidation DEFENSIVELY — the ~10 ==/++/show/hash/compare OUTER TString-vs-TList forks (emit_binop_for BConcat wasm.mn:3830, emit_eq_for_ty:3920, emit_cmp_for_ty:4523, the field-eq/cmp/hash + show pairs) collapse into ONE `match repr_of(elem)` nested dispatch, KEEPING the nominal TString arm so H6 still NAMES it (deleting it lets a bare `TList(_)` wildcard SILENTLY absorb former strings into `$list_eq` at 4-byte stride — H6 forces the deletion, never the sub-dispatch); (2) the runtime representation reconciliation as its own perf-measured TRANSITION — the stride-polymorphic flat leaf (load_i8 vs load_i32 by element repr: the NAMED-CALL STRIDE HAS NO RUNTIME MECHANISM today — one non-polymorphic WASM body cannot serve both strides; needs a per-repr `$index_i8`/`$index_i32` family or a runtime width carrier, the load-bearing gap `Hβ.value.seq-element-stride-carrier` — SHARPENED 2026-07-20, a SECOND adversarial pass (wf_b7ba2a2e-22c, survives=False on the type-first shortcut) proving the per-repr call-site family is INSUFFICIENT: a generic body (`iterate_from`/`map`, prelude.mn:53/63) compiles ONCE with its element a TVar (repr RI32), and emit-selection specializes only at CONCRETE sites, NEVER a type-variable element — so `map(f, aString)` typechecks under the merge then reads packed bytes at 4-byte stride (the killer, and the oracle is BLIND to it because the wheel never maps a string, so m3==m4 stays byte-identical while user code corrupts). Generic-over-packed traversal REQUIRES a runtime stride carrier (a fat sequence header read at access; word-sized elements pass by value, wide elements by reference-into-the-buffer) OR whole-program monomorphization — the TRUE keystone DEP, DEEPER than the arena, and it must be PROVEN on WIDE elements ([Float]/[i64], RF64/RI64) BEFORE String is ever minted TList(TByte). The type-merge's OWN OOM is a DISTINCT mechanism from the seq-op-row ev-slot revert — TString is a nullary sentinel (0 heap) while TAlias("String",TList(TByte)) is 2 heap records ×instantiate-clone (type-node bloat) — so the arena stance is build-and-measure PER-MECHANISM, never inherited by analogy), the view/slice unification (String's sign-bit O(1)-collapse-via-view_base vs List's tag-4 O(depth) chain), the [len][bytes] data-section literal the interner + self-compile depend on, and the concat-persistence decision (String eager materialize O(la+lb) vs List lazy rope O(1)); (3) ONLY THEN the type merge, when the runtime agrees. TWO settled truths: (a) THE fold_sig COLLISION — `fold_sig` reads `fold_strip` which strips alias/refine, so a byte-as-`Int repr i8` strips to TInt and `fold_sig(TList(byte)) == fold_sig(TList(Int)) == 'li'`, sharing generated `$eq_li`/`$hash_li`/`$show_li` helpers → silent wrong-width; the byte leaf must be a NEW NOMINAL Ty `fold_strip` does NOT strip, OR `fold_sig` must READ repr (diverging from `fold_strip` — an explicit structural decision), and §4①'s "a byte is an Int, not a new primitive" is in direct tension with fold-distinguishability — SETTLE THIS FIRST; (b) `handle_recorded` does NOT dissolve here (handle-IDENTITY i32.eq vs structural str_eq — a real split merged only by `Hβ.runtime.indexed-map-primitive`; corrects the 0fa3649b commit/PROVENANCE claim). THE KEYSTONE DEP is `Hβ.perf.per-decl-arena` (§5.O): the honest-row Alloc attribution + the ontology's self-compile allocation shift both hit the MEASURED 4GB never-free bump-image OOM (the 2026-07-17 seq-op-row-from-callee revert, infer.mn:1320-1333) — the whole dissolution waits on the arena. is_seq_op is therefore a LEGITIMATE "self-consistent raw body, typed calls" substrate boundary, NOT shameful drift-8, until (i) the arena lands and (ii) the ONE genuinely-new increment the panel converged on exists: `Hβ.infer.seq-addr-downcast` — `addr : ∀a. a -> Int`, a sound structure-forgetting DOWN-cast (negative position, concrete Int result) that lets an authored-signature runtime body typecheck (`load_i32(addr(xs))` keeps BKArith `Int+Int`), capability-gated (`with Cast` / provable `!Cast`), confined to handle-repr; the UP-cast (`str_of_buf : Int -> String`) stays the SINGLE localized identity coercion, never proliferated to a `from_addr : ∀a. Int -> a` unsafeCoerce. Retiring is_seq_op is the separate DEP-blocked `Hβ.infer.seq-op-signature-driven`, sequenced AFTER the arena AND the representation work, never as a substitute for the ontology. Full transcripts: the session workflow dir wf_79a821ca-ccc)* · `Hβ.runtime.zero-copy-string-view` (DISSOLVED 2026-07-21 — the list slice node IS the zero-copy view; the sign-bit shape is deleted) · `Hβ.emit.image-map-fold` *(new 2026-07-10 — the module's static layout as ONE fold in the emit: each region's base IS the previous region's limit (sentinel space | records | thread records | interned data | bump heap), overlap unconstructible; born from the ev_scan record clobber (a closure record at 264 sat inside io.mn's fs path scratch — two files claiming one page in prose). The fold IS band B's persist substrate: it defines what a memcpy snapshot means)* · `Hβ.io.scratch-dissolves-into-alloc` *(LANDED 2026-07-10, f0089a3 — page 0 carries no runtime scratch: every syscall record (iov / nread / prestat / filestat / fd-out) allocs per use; fs paths cross the boundary as (ptr, len) views straight into the string payload (`fs_path_view` — the old copy-into-scratch re-derived bytes the image already holds; WASI paths are explicit-length); `read_stdin_loop` + `fs_read_loop` unified into one `fd_read_loop` (stdin and opened files are the same stream); ten io fns re-rowed +Alloc; net −8 lines. The march measured the prediction WRONG in the good direction: a lib-source-only change holds m2 == m3 in ONE generation (both generations compile the same source with the same emit) — the transition form is for EMIT changes only. Gates: 52/52 boot, 8/8 + 52/52 through m2, fixpoint byte-exact, serve battle green)* · `Hβ.tools.march-transition-native` *(new 2026-07-10 — on m2 ≠ m3 march.sh runs the m4 leg itself and reports TRANSITION (m3 == m4, re-pin from m3) vs BROKEN (m3 ≠ m4); removes the bless-the-wrong-generation human-error surface — bash scaffold tier)*.

**E · Parallelism & accelerators (arm 3, §4④; STEP 4 collapse landed).** `Hβ.lower.fanout-simd-lane-cashout` (RV128) · `.fanout-gpu-backend-handler` (lower.mn:1475) · `.fanout-durable-persist-handler` (SPACE=TIME) · `Hβ.parallel.thread-alloc-transitive-proof` (verify ONLY after the leak closes) · `.race-freedom-ownership-proof` · `Hβ.infer.fanout-ownership-from-use-count` (infer.mn:1288) · `Hβ.runtime.wasi-thread-spawn-seed` (LANDED 2026-07-24 — the task-record
spawn substrate, `LEDGER.md`; real host threads over the shared image) · `Hβ.driver.level-set-par-walk` *(the topological layer-partition is LIVE in driver.mn — 7165bbb; the open half is the multi-core `>< ~> Thread` at the layer site)* · `Hβ.cursor.speculative-compile` · `Hβ.cursor.work-stealing-via-gradient` *(idle cores ask the cursor "what next?"; the gradient's argmax IS the priority queue — no scheduler module)* · `Hβ.lower.schedule-specialized-callee` *(new — the parallel_map dissolution's open remainder: whether a reusable fn's internal `><`/`<|` should EVER inherit a caller-installed `Schedule` across a call boundary. The only sound route is compile-time specialization of the callee per install-context, preserving `Seq`'s zero-cost/`!Thread`-provable property — the §5.3 dispatch gradient's sibling on the INSTALLED-HANDLER axis (vs the known-argument axis; shares callee-specialization infra). The ambient/evidence-passed-runtime `Schedule` alternative is the wrong direction — it taxes every `Seq` fanout to buy portability only a rare `Thread` caller needs. Scoped skeptically: direct `>< + ~> Thread` at the use site is sufficient and simpler; build only when a real consumer needs one fanout helper serving callers wanting different schedules. Sequenced behind `Hβ.driver.level-set-par-walk`, DEP-gated on band-A `sound-neg-under-poly`)*.

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

## §7 · Current state — the honest audit

**THE BOARD'S NUMBERS LIVE IN `state.sh`, NOT HERE** (trued 2026-07-31: this
header had carried `frontier 71/0` against a live 332/0 and a phantom ratchet
of 287 against a class that reached ZERO on 2026-07-22 — a snapshot of facts
the artifact holds live, which is §7's own destiny sentence violated by §7's
own opening paragraph, and the Carried-Truth Law at the doc layer). The
standing claim is structural, and it is the one worth reading: **every gate
the repo owns is green through the pinned boot** — the march's fixed point,
the frontier contracts, proof-exactness, the `!E` crucibles, the micro
battery, the census ratchet — and a rising census is a refusal to merge. Run
`bash tools/state.sh` for the counts; the pin chain is boot/PROVENANCE.md,
newest first. **`mentl voice.mn:9` ANSWERS** (the
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
- **Universal executable refusal** (§11 col 2) is PARTIAL, and this bullet
  said "only `E_MissingModule` is armed" while the paragraph above it listed
  six — a contradiction inside one section, both wrong against the artifact
  (trued 2026-07-31 by reading `diag_refuses`' own arms): NINE classes refuse
  — EMissingModule, EHandlerStateShadowsOp, EDuplicateFnName,
  EDuplicateTypeName, EEffectUnhandled, ERefinementRejected,
  EOwnershipViolation, EMissingVariable, EOccursCheck — plus the hole gate,
  which is the executable gate's own read rather than a `diag_refuses` arm.
  The remaining census classes (E_TypeMismatch and kin, name-dependent on
  partial-link paths) are the ratcheting work toward universal. Read the arms,
  never this list: the ONE home is `diag_refuses`.
- **`mentl compile main` self-serves at the ENTRY and not per MODULE.** The
  entry half CLOSED 2026-07-18 (the manifest landing — the whole wheel emits
  from the import DAG with zero diagnostics, assembles, and compiles
  programs), and this bullet had carried the pre-landing text for thirteen
  days. The open half is per-module: 29 solo-check violations across 18 src
  modules (measured 2026-07-31 — verify 12, format 5, six files at 2, ten
  clean), invisible to the blob-fed march because concatenation resolves every
  name whether its module declared the dep or not. `Hβ.driver.wheel-imports-are-the-manifest`
  is therefore CLOSED-at-entry / OPEN-per-module, and the per-module check
  ratchet is what drives it to zero (§11 col 2 — it gates the drift-catalog
  retirement).
- **The Thread schedule is REAL** (2026-07-24: host threads over the one
  shared image, gated by the three real-spawn frontier legs); its SAFETY
  story (stateful-effect-in-fanout refusal) stays gated on band A, and a
  spawned branch's evidence-tier performs meet an empty per-instance
  world (loud, never silent). **SIMD / GPU schedules + the persist
  handler** remain scaffold / proxy — lane and device and disk are not
  yet real (bands E/O).

- **"Every subsystem is the cursor in a traversal mode"** (§2) is ~60%
  EARNED, with a mechanical test for the rest (2026-07-31, the architecture
  audit): does the subsystem's per-handle fact live in a spine COLUMN? Seven
  do — the type graph, the AST, the comment weave, the e-graph's canon,
  narrowing, executable boundaries, spans — and the e-graph is the strongest
  case (a column write and a live read, no side-ledger anywhere). Still
  bespoke, ranked by the size of the gap: LOWERING (a whole second tree — 39
  handle-first constructors and sixteen walkers, whose own file header denies
  a GraphWrite the medium's audit reports it performing), the ENV (a flat
  buffer + a 4096-bucket index + a per-generation dedup walk, all three
  downstream of the scheme being a name-keyed snapshot), the REVERSE EDGE
  (absent entirely — three subsystems re-derive it), and the affine / verify /
  tighten LEDGERS. The remaining 40% is ONE repeated move, four-for-four so
  far: put the per-handle fact in a column, dual-write at the one writer,
  migrate the readers, delete the side-structure.
- **Published schemes are VALUES, not edges** — the root the whole judgment
  tower compensates for, and the one the honest audit was missing until it
  had an artifact (2026-07-31): a cycle member's row is published at its own
  decl exit, before its co-members are judged, so their effects never reach
  it (930 measured trial/final divergences on the wheel; fifteen-line
  reproduction at tests/frontier/mn-cycle-charge-freeze.mn). Three measured
  `!E` blindness faces inherit it. `Hβ.infer.schemes-are-edges` rung 3 is the
  dissolution, and it is a SOUNDNESS closure, not a perf arc. THE ROW HALF
  LANDED 2026-08-07 (§11 5.2 carries the arc; movers 678 → 453 with the
  remaining classes measured and named); the OPEN soundness seam is
  `Hβ.infer.forward-hof-row-underpublish` — the shipping pass publishes
  PURE for some HOF-chained rows (neg_names_to_str: declared Memory +
  Alloc + Intern + GraphRead, final publishes pure), a live false-absence
  channel until its root-trace arc closes.
- **The planned layer sweep runs SERIALIZED (judge_window 1)** since
  2026-08-07: the K=8 parallel final's correctness rested on published
  schemes being live-var-free — exactly the property rung 3 deletes — and
  live cells raced its branches (the trap-on-spawn conviction). The
  parallel form returns at Phase 9.2 with the deterministic handle
  partition and ATOMIC join writes; until then the ~3s wall delta is the
  serialization's honest price.

Everything else on the board above is measured green; this list is the seam
between the wheel and its ultimate form, held open on purpose.

### The landing record → `LEDGER.md`

Every landing since first light, newest first, with its mechanics and its
measurements. **It left this file on 2026-08-05** — 7,002 of PLAN's 10,809
lines were a hand-written prose copy of 448 commits, which is the Carried-Truth
Law violated at the doc layer and precisely what §7's own destiny sentence had
been saying for months. Nothing was deleted or edited; it is reference now, not
read-path. Consult it for *what happened at pin X and why*; consult `git log`
for the diff. `tools/doc-truth.sh` reads its head pin and asserts it against the
boot sha, so the chain stays mechanical.

### The named peers → `RESIDUE.md`

Every named positive-form gap, one home each. **It left this file on
2026-08-05** — 1,474 lines of catalog against the program §11 actually runs.
The law is untouched: a hidden gap is drift, and a gap that lives only in a
comment or only in a session's memory is not named. It lands in `RESIDUE.md` or
it does not exist. §11 names the peers each phase touches; the catalog holds the
rest.

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
    inline. EVERY dispatched agent runs Opus 5 or Fable 5 — whichever is most
    effective for that job — passed explicitly (Morgan 2026-08-05, superseding
    the 2026-07-24 Fable-only rule; both are unlimited, so the pick is FIT,
    never scarcity, and an omitted model param falls back to an agent
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
   context. `LEDGER.md` (what happened at a pin) and `RESIDUE.md` (the full peer
   catalog) are REFERENCE — consult on demand, never read whole; they left this
   file on 2026-08-05 because 78% of the substance document was a prose copy of
   git. Reference nothing else unless debugging a specific artifact.
2. **Run `bash tools/state.sh`.** The whole board, not a slice: verify (micros +
   census + doc-truth), the march's fixed point, frontier, proof-exactness,
   crown, effect identity. The census is a ZERO-TOLERANCE RATCHET, not a shadow —
   a rising count is a refusal to merge (it has been since 2026-07-22, and the
   older "census is a shadow, expected progress" reading was a seed-era alibi
   that outlived the seed by weeks). Trust the artifact over any prose here; if
   prose disagrees, fix the prose. **A gate you did not run is not green** — the
   crown proved that over eleven landings.
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

## §11 · THE PHASES — the ordered program

**Rewritten 2026-08-05**, replacing the five-column production bar;
**extended to the FULL ARC 2026-08-06** — every phase from the current pin to
the seven DONE statements and the terminus, one ordered program. The
extension's own law (the no-completeness-claims rule, twice-corrected): this
is the TRACED set — every peer `RESIDUE.md` names, every §5.R band, every
§5.O layer, every §7 seam and SYNTAX defect, placed in dependency order with
its design banked — and completeness's one proof is the build marching
green, phase by phase, never this document asserting itself exhaustive. The
columns had become a checklist of symptoms; these phases are ordered by
*foundational depth*, because the governing correction is Morgan's:
**performance — and every other superiority — falls out for free when the
design is right.** §5.O
already said it (performance IS the Carried-Truth Law; a scan is a
re-derivation wearing a stopwatch), but the old §11 kept a "performance floor"
column as though speed were a work item. It is not. The test:

> **If a change's justification is a number and not a law, it is the wrong
> change.** `wasm-opt -O2` measured a 4% regression and was correctly refused;
> the 140× came from deleting re-derivations. Every time.

So total monomorphization is not perf work — it is the erasure boundary lying.
The arena is not perf work — it is ownership having a real reclaim.
Name-is-handle is not perf work — it is a name being an edge. Speed is the
side effect in all three, and treating it as the goal is how a wrong change
gets justified.

**THE DEFINITION OF DONE — one statement per §0 property, each a phase's
terminal gate:** (1) *proof beats review* — the crown sound under polymorphism,
Verify on a decidable fragment with honest V_Pending, SMT a certificate-checked
handler swap, every armed class refusing. (2) *the negative is provable* —
`!Flow` on the integrity dual-lattice, PC-labels, robust declassification.
(3) *intent is lossless* — the Why engine total, provenance projected at every
surface, the fmt summit canonical. (4) *computation is durable* —
persist-as-memcpy generalized to cross-machine cursor migration, the session a
value. (5) *systems explain themselves* — `mentl audit` live, docs-as-projection,
the ??-fan with the teaching tie-break as the daily loop. (6) *the oracle at its
limits* — the multithreaded multi-cursor multi-shot fused oracle as the default
judge. (7) *`!Outside` closed* — the native backend, diverse double compilation,
and the correctness oracle absorbed into the wheel's own Verify.

**THE RISK TRIPWIRES, each with its fallback:** (1) the frozen-read instantiate
holds without judgment regressions — tripwire: census classes shifting instead
of falling. (2) the lattice join's confluence survives every future workload —
tripwire: any six-battery split; FRAGX stays armed as the standing collision
census. (3) **THE BOARD'S ORACLES ARE BLIND TO WHAT THE WHEEL NEVER DOES** —
confirmed hard on 2026-08-05: a 27-fixture SYNTAX battery found eight surface
drifts, every one invisible to census, fixpoint, and micros, because the wheel
never writes a lambda list-pattern, never declares a named effect row, never
pipes bare into `len`. The board was green in the same minute the crown was
admitting a higher-order `!E` leak. Fallback and standing counter-measure:
gates that exercise what the wheel does not (Phase 0.4), and every measured
silent-wrong banked as a RED refuse-contract the day it is found. (4) **A GATE
THAT STOPS BEING REPORTED STOPS BEING RUN** — the crown went unmentioned for
eleven consecutive ledger entries while the leak rode the whole arc; nothing
written was false, the gate had merely gone quiet. Closed mechanically by Phase
0.1: a gate not run is a visible blank, and a red one refuses the pin.

---

### Phase 0 · The medium can see itself and its board — ✅ COMPLETE 2026-08-06

Every item is an oracle, and oracles came first because a fix without one is
a hypothesis. All four landed: **0.1** the march captures the whole board
(`board_verdicts()` at pin time; `NOT RUN` is a visible blank; a red stamps
`‹BOARD RED›` and doc-truth refuses). **0.2** doc-truth checks the verb
namespace against `mentl help` (five true findings on its first run).
**0.3** the structural census (`mentl query <file> "census <shape>"` —
`anonymous` + the verb glyphs, count + located sites over the judged weave;
the frontier leg pins each shape counting its own site; its one blind shape
is Phase 2.0's opening measurement, `Hβ.eq.pipekind-match-eq-divergence`).
**0.4** the SYNTAX conformance battery (`tests/syntax/`, one fixture per
declared form, green-or-named). The full mechanics: `LEDGER.md`.

### Phase 1 · The row crosses the function boundary — ✅ WHOLE 2026-08-06

Three faces, three landings, one day (pins 806c7df4 → e606a650 →
04e20d2482fc): the completion prune's SIGNATURE KEEP-SET closed the crown's
higher-order leak (`run(f) = f()` publishes its param's row var in row and
scheme coherently; the keep adds no quantification, so the prune's blowup
bound stands); the instance-erasure root closed at effect registration
(declared params ride as EANode value dims, the gate pins authored scalars,
subsumption's present legs read `eff_admits` — the instance law's positive
dual); and the handler-residual seam closed at the install read (the
residual as the cell-as-an-edge, each CALLED config arg's row joined —
`fn f(xs) with !WASI = each(...)` refuses, the vocabulary face every user
touches). Harvest: 19 falsely-passing wheel sites trued; the quantification
floor became exhaustive Ty arms with TCont's world protected. Terminal gate
met: crown 8/8, frontier 332/0, census 0, fixpoint at every pin. Records:
`Hβ.infer.hof-param-row-never-reaches-enclosing` and the two residual peers
in `RESIDUE.md`; the LEDGER's THE SIGNATURE KEEPS ITS ROW. Rung 3's
dissolution of the publish tower remains the deeper form (Phase 5.2).

### Phase 2 · Every judgment reads the graph, never a proxy

Rides Phase 0.3. Three instances of one law: *parsing is necessarily shape;
every judgment must be type-keyed; nothing downstream of the parser may
re-read syntactic form to decide what the graph already answers.*

- **2.0 · The one `==` is coherent with match** — ✅ LANDED 2026-08-07, and
  the banked probe's one run REFUTED the phase head's own framing: there
  was no divergence. The raw-word census showed the `<~` pair as `a=3 b=3`,
  the eq TRUE; the census's zero came from `span_of_handle` CHASING to the
  union-find root, where a `<~` node lands on the continuation-boundary
  cell's bare `Inferred` — span zero, site skipped as synthetic. The landed
  law: a weave walk reads a node's OWN raw facts (`span_of_node_raw` —
  graph_reason_at, no chase), because chasing conflates identity with the
  type-class representative. All six shapes count their own sites; the
  frontier roster gained `<~`; six kills banked
  (`Hβ.eq.pipekind-match-eq-divergence`, RESOLVED — the sixth kill is the
  divergence hypothesis itself). What SURVIVES for downstream phases: the
  eq is measured coherent (rung 3, `fold_sig`, the IFC lattice proceed),
  the pointer-eq floor's Intent-Boundary fix stands, the reverted guard
  experiment's record stands (load-bearing eq semantics change only under
  march arbitration), and one sibling residue is named — `refs_of_name`
  shares the chased-span read and is green by accident-invariant.
- **2.1 · `Hβ.egraph.extraction-is-the-emit-cursor`** — ✅ LANDED 2026-08-07,
  half by discovering it already true: the stamp check against the artifact
  showed the engine BORN in the prescribed form (canon edges in the graph,
  extraction = the chase, congruence by live re-read, the fan/e-graph range
  composition with its forced order — the deleted side-ledger's epitaph is
  in the file header), so "delete the pass" had no referent. The live half
  was synth's stored rank: `cost` left EnrichedCandidate, thirteen
  enumerator constants left their sites, and rank is `rank_of` — a
  projection of the live candidate at sort entry (proximity via the env's
  decl reason + the refs walk; a ctor call ranks by the same one arm; a
  nameless candidate carries the bare base) — killing both measured faces
  (measurement-vs-invented-constant ordering; the extraction-swap stale
  ride). The rule-growth contract is banked at
  `Hβ.egraph.extraction-cost-composes-repr`: a future non-shrinking rule's
  "cheaper" composes repr/rows/use-counts as a projection, never a
  term-shape fn — gated where band G's rules grow (5.5).
- **2.2 · The shape-keyed judgment tier** — ✅ LANDED 2026-08-07 (pin
  e1ef0bd41417, 334 lines lighter). The law: a *partial* match on
  `ast_kind_of` outside the parser convicts; a *total* structural fold does
  not, because exhaustiveness makes a missed case a compile refusal. The
  tier's census found one live member: `check_branch_is_stage`, judging `><`
  branches by spelling against its own organ's semantics (the value boundary
  evaluates every branch as a value; `<|`'s stage requirement is the
  application unification and never needed a special case). Deleted whole
  with the `EBranchNotStage` class; the quartet gate
  (`tests/frontier/mn-pcompose-value-branches.mn`, seen RED at four
  diagnostics) asserts one verdict for four spellings; SYNTAX §«`><` branch
  typing» rewritten to the value-branch law. The formatter's five chain arms
  were confirmed history (fixed 2026-07-25), and `ast_kind_of`'s sixteen
  remaining consumers all live in the formatter, whose *output* is shape —
  the one legitimate shape-reader outside the parser.
- **2.3 · The anonymity tier** — ✅ LANDED 2026-08-07 (pin eb827fae186d;
  stamped one iteration, built the next — `Hβ.audit.anonymity-tier` is the
  design's home and carries the build-time correction). The audit convicts
  the eta-wrapper (body ≡ a named call over its own params —
  MachineApplicable, pass the name) and the effectful lambda (the judged
  TFun row read through resolve_row, which sees effects the `~>` foot
  already absorbed from the fn row), and stays silent on the pure-local
  vocabulary — the stamp's quantified-row-param class collapsed into the
  row class at build time, because a pure lambda on a quantified param IS
  `map((x) => x + 1, xs)`. Escape stays DEP-named on
  `Hβ.infer.use-profile`. Measured: 555 anonymous fns on the weave census,
  ~136 eta-wrappers by text shape; the ratchet that watches those numbers
  is 2.5's. Gate: tests/frontier/mn-anonymity-tier.mn, three faces, seen
  RED first.
- **2.4 · Recover `Hβ.infer.diverge-shared-memory-row`** — ✅ RECOVERED
  2026-08-07 into `RESIDUE.md`, restated from the 2026-05-05 archaeology
  (b139622b, peer G.1) into today's substrate: one PFanout, schedule read
  live at the `~>` edge; under `~> Thread` the ownership aspect IS the row
  fact — FanShare's cross-core borrow charges `+ SharedMemory`,
  FanDistribute proves `+ !SharedMemory`. The proof verdict inherits the
  crown (Phase 6) and lands with band E's verification tier (Phase 9.2);
  the G.2 sibling survives as `mentl where`'s schedule badge facet (3.2),
  G.3 dissolved at STEP 4's PFanout collapse.
- **2.5 · The census grows its judgment shapes** — shapes ✅ LANDED
  2026-08-07 (pin 62542a59bf94): CsEta / CsEffectfulLambda /
  CsIterationCostume in `CensusShape`, the detector families and the one
  total child projection moved oracle→query (the census is the detectors'
  home; the audit reads through the import), census_matches carrying the
  handle so judgment shapes read the graph at the site; fixture + roster
  pin each shape counting its own line, seen RED first. The RATCHET ✅
  LANDED 2026-08-07 (same day, the second half): verify runs the two
  census queries per gate pass and refuses a rise against
  `eta_max: 29` / `effectful_lambda_max: 394` in
  `tools/verify-baseline.txt` (the tier's CONVICTIONS on the wheel link —
  423 of 555 anonymous; raw CsAnonymous is not ratcheted, its pure-local
  majority being vocabulary the tier declares silent). Both arms seen RED
  at under-set ceilings; an empty census answer refuses loudly rather
  than reading as zero. Phase 2 is WHOLE. The whole-link/per-file cut and
  the decl-site file-coordinates facet
  (`Hβ.query.decl-site-file-coordinates`) land together when 3.5's
  overlay gives solo queries their real link sets.

### Phase 3 · The surface IS SYNTAX

*(The phase's felt walk ran 2026-08-07 at pin 62542a59bf94 — five probes
through the installed shim; every 3.3 drift confirmed live, the N-ary fold
measured at the destructure site, one 3.4 claim confirmed in the right
direction: `-> !` checks clean, the lathe-lag note is the stale half. No
new DEP found; the map below is accurate at that pin.)*

- **3.1 · The N-ary law** — ✅ LANDED 2026-08-07 (pin 05fd2307ff43,
  built against `Hβ.parser.pcompose-nary`). *An operator whose result is
  a PRODUCT has semantic arity and must parse N-ary; a COMPOSITION or
  SET operator may fold, because folding is meaning-preserving there.*
  `><` now parses through the dedicated FanoutExpr carrier — the binop
  loop accretes a chain into one node whose branches are a LIST, so
  `(a) >< (b) >< (c)` meets a three-way destructure and runs
  (mn-fanout-nary, seen RED as a garbage exit on the prior pin). Infer
  walks N value boundaries into TTuple(N); lower enumerates N thunks
  into the arity-carrying record (STEP 4 meant zero emit change); fmt
  renders the N-ary canon. The m3 trap was the census instrument:
  nested full enumerations hide from the exhaustiveness checker, and
  the ExprPlaceholder tell found all five walkers in one measurement
  (the LEDGER entry carries the mechanics). `<|` keeps input ×
  branch-tuple — different operand structure by nature, one PFanout
  node at lower.
- **3.2 · `mentl where`** — ✅ LANDED 2026-08-07 (pin 0d3a196299d1, built
  against `Hβ.cli.where-verb`). The derived-badge projection is live on
  the query spine: `gain : Float @ f64 (inferred)`, `tick : Tick op —
  resume Int ->1 answer`, `>< [Thread]` / `>< [Seq]` — each a pure read
  of a fact the graph proves, the schedule badge's static enclosing-tee
  walk exact by the never-crosses-a-call-boundary law. SYNTAX's lag list
  shrank by its first name; the frontier grew the four-badge leg; two
  dig lessons banked in the LEDGER (index walks over env-stored lists,
  the typed accessor over the raw field read). The cure for what the
  two-verb reframe cost — the fact returned to the site as OUTPUT.
- **3.3 · The remaining measured drifts.** The lambda parameter path ✅
  LANDED 2026-08-07 (pin 8031eaf123ec — the cover-grammar RestExpr;
  `([h, ...t]) =>` checks clean, the parse-half leg gates it, and the
  unmasked rest-binding runtime gap is banked as
  `Hβ.lower.list-rest-binding-runtime` with its fix direction). Named
  effect rows ✅ LANDED 2026-08-07 (pin 6768ffac9dfa, built against
  `Hβ.types.named-effect-rows`): `type Both = A + B` through the
  with-clause's own grammar, expansion at the signed fold building each
  alias's row whole (the fixture's `Both - B` alias-of-alias grouping
  case runs 3), cycles and the negation shorthand refusing loudly, the
  +EnvRead cascade through the parser's fn-type rows widening eleven
  declared clauses. The `xs |> len` false diagnostic ✅ LANDED 2026-08-07
  (pin 7d8e91e499a1, the loop's first TRANSITION — seq_face_ty binds
  every seq-op MENTION to its face, closing the last raw-scheme leak;
  pipes, HOF args, and stored seq-ops type honestly; the wheel's own
  mentions judging differently under the face is exactly why the emit
  crossed one generation). 3.3 IS WHOLE — the remaining names were
  always 3.6's (`<~`) and 3.5's (the fmt scope register).
- **3.4 · SYNTAX's own defects** — ✅ TRUED 2026-08-07 (docs-only, each
  claim probed before edit). The canon's two fanout-foot-pipe examples now
  parenthesize with the precedence stated (`(1) >< (2) |> inc` probed to
  run as `(1, inc(2))` — exit 4, the pipe entering the last branch); the
  `-> !` lathe-lag note deleted (zero diagnostics at the felt walk); the
  format-liftable section carries the honest state (StatementSemicolon
  silent as designed, RedundantBraces and RedundantPerform surfacing as
  warnings until the fmt canonical projection retires them — measured,
  never asserted).
- **3.5 · The per-module half of the manifest** — first half ✅ LANDED
  2026-08-07, second half STAMPED (`Hβ.driver.per-module-env-overlay` in
  `RESIDUE.md` carries both). The sweep re-measured 53 violations across
  13 modules (the 29/18 figure had aged); two one-line imports killed 17
  (verify→graph+io, format→parser), and `solo_violations_max: 36` is the
  banked ceiling the frontier's sweep leg enforces. THE SWEEP REACHED
  ZERO 2026-08-07 (pin c46691d75a57, four iterations: 53 measured → 17
  killed by two import lines → the handler seam closed at src/env.mn +
  src/intern.mn → the verb grammar relocated to src/cli.mn) —
  `solo_violations_max: 0` is the floor and the contract, every module
  resolving every name through its own declared imports, enforced per
  landing. The zero gates the drift-catalog retirement (its own step).
  The OVERLAY proper (per-module env views: tagged entries, closure
  bitmasks, O(1) lookup filters — real link sets without re-judging,
  scoped diagnostics healing the fmt register, the per-file census cut,
  file-true query spans) is the stamped second half; the ceiling reaches
  0 when the seams close, and the per-module check then gates the
  drift-catalog retirement.
- **3.6 · `<~` becomes whole** — STAMPED 2026-08-07 with ONE FORK FOR
  MORGAN (`Hβ.dataflow.feedback-becomes-whole` in `RESIDUE.md` carries
  four measured faces: fb types Pure, lowpass_iir's authored Sample
  vanishes, E_FeedbackNoContext has zero construction sites, Delay(0)
  types like Delay(1) — plus the traced design: the PFeedback arm
  resolves the context via the enclosing-tee walk, charges the effect,
  refuses the zero delay). THE FORK: how an effect joins the Iterate
  class — SYNTAX promises no-allowlist but declares no membership
  surface; the structural read refuted at trace (name-keyed drift in
  costume), the declared marker (B) priced as one surface addition. The
  build blocks on the choice. `Hβ.dsp.state-element-install-once` rides
  the arena (4.3); `Hβ.dataflow.clock-calculus-sample-rate` rides Phase
  8's DSP verify tier.

### Phase 4 · Ownership has a real lifetime

**The order here is mandatory, not preference.**

- **4.1 · `Hβ.own.use-after-move`** — ✅ LANDED 2026-08-07 (pin 8ba768c810c4,
  before the arena exactly as ordered). The gap was one leg's ORDER: the
  affine ledger's consume arm checked `borrow_depth` before the used-set, so
  every borrow surface read moved owns silently. `set_contains(used, name)`
  now reads first — consuming second use stays armed `E_OwnershipViolation`;
  borrow-read of a moved name is `T_UseAfterMove`, born at wheel-ZERO and
  ratcheted there (`use_after_move_max: 0`). Gate seen RED:
  `tests/frontier/mn-use-after-move.mn` via `run_narration`. The ARMING
  (diag_refuses at held zero, post-falsification) is the banked residual in
  `RESIDUE.md`.
- **4.2 · `Hβ.infer.grade-is-join-and-mode`** — ✅ LANDED 2026-08-07 (pin
  6cd6281a971f, built against the stamp). count_uses' additive sum deleted
  whole into `usage_of` — the mode-paired `(consume, read)` Usage walk (⊔
  across alternatives; mode from the callee product via `param_borrows`,
  the classification's one home in types.mn that the arg bracket's inline
  test also deleted into; lattice ops home with their ADT). The refused
  first march was the instrument: the consume default on a not-yet-graded
  forward callee made decl order load-bearing (set_contains graded Own,
  every caller moved its set); the read-safe default closed it. BOTH
  ownership narration classes now at wheel-ZERO; the walk's trial/final
  order-dependence measured at +188 moved schemes (movers 474 → 662,
  in-baseline justification; rung 3 dissolves the class and the
  order-dependence with it). Gate: tests/frontier/mn-usage-grade.mn, three
  asserts seen RED.
- **4.3 · The per-decl arena** (`Hβ.perf.per-decl-arena`, gated on
  `Hβ.infer.region-on-tee-alloc-absorb`). It is a hub, and more rides on it than
  was ever written down: the String=`[Byte]` value-ontology dissolution names it
  THE keystone dep; `persist = memcpy`'s image/scratch split; the 4GB ceiling
  that killed a frontier leg and has shadowed the whole constructors arc; the
  allocation payoff of `instantiate-shares-never-clones`; and total
  monomorphization, which needs the headroom its duplication costs. STAMPED
  2026-08-07 and then CORRECTED BY ITS OWN BUILD (`RESIDUE.md` carries the
  full record): steps 0 (cost instrumentation), 1 (the ImageAlloc
  vocabulary), and 2a (the extent-delta census + family 1, the spine's
  band-open bracket) are LANDED — and before family 2, the build refuted the
  design's core: site-classification is UNSOUND for the value graph, because
  published values (Ty/GNode/schemes) are allocated during inference and
  published by pointer-write, so no bracket at the publish site classifies
  them and a per-decl reset would zero live column pointees. The sound form
  is COLUMNS FIRST — the 5.2/5.5 column arc makes the image set = pages +
  flat buffers by construction — so 4.3 PAUSES at 2a and 2b's fork/reset
  DEP-GATES on that arc (the DEP-gate is the next thing to build, not a
  stop: the arc is §11's own next phase). 4.3 and 9.1 still converge on one
  boundary; the fleet's 2026-07-17 "output-invariant" refutation stands.
- **4.4 · Ownership's frontier faces.** The quiet gate ✅ LANDED 2026-08-07
  (verify's quiet-gate ratchet: 83 authored own / 817 authored ref in src/,
  param-position text count seen RED at ceiling 1, monotone DOWN — each
  marker the honest grade retires lowers it; the census-shape count is the
  named refinement). `Hβ.ownership.fractional-uniqueness-ref-borrow`
  (Granule OOPSLA 2024 — fractional grades where the inference needs them)
  stays BANKED until a real consumer needs a fraction: the original text of
  the Hylo bar as a BANKED
  CEILING: the corpus count of authored own/ref markers enters
  verify-baseline and only falls; a rising count IS §4⑤'s inference
  failing, measured instead of felt.

### Phase 5 · The deep forms the arena un-gates

- **5.1 · TOTAL monomorphization.** The current form is flow-directed in exactly
  the right way — the demand analysis reads instantiations off the live
  union-find rather than solving a second constraint system, which is
  Carried-Truth applied to [Lutze–Schuster–Brachthäuser, OOPSLA 2025] and an
  improvement on it. But it is SELECTIVE: the worthiness gate specializes only
  where the i32 floor is *wrong*, leaving plumbing uniform. That is a
  perf-motivated hybrid, and perf is not the axis. A uniform representation is
  the one place where the proof deliberately does NOT become the dispatch, and
  every measured silent-wrong lives at that seam — `sort` returning input order
  because `<=` compared addresses, the unannotated float accumulator summing to
  ~0, `describe(2.5)` printing a pointer. STAMPED whole 2026-08-07
  (`Hβ.emit.total-monomorphization`, RESIDUE): the artifact read reframes the
  target — the machinery is already total-by-REPR (the all-word vector IS the
  floor class, correct at the wasm altitude), so the hybrid is exactly ONE
  filter, and the plan was three legs — and the
  same day MEASURED them: 5.1c is KILLED TWICE (the mangle space is finite by
  construction — a wide component is a scalar repr, containers are words —
  and polymorphic recursion cannot reach the emit at all: the signature'd
  probe refuses E_OccursCheck, a measured 5.3 baseline); 5.1a was BUILT AND
  REFUTED BY THE MARCH — the worthiness web deleted whole, m2 compiled, and
  m3 trapped with call stack exhausted in zip_with. THE GATE IS LOAD-BEARING
  CORRECTNESS, not a perf hybrid: the worthy set was leaf-compute by
  construction, so the twin emission for self-recursive closure-carrying
  HOFs was never exercised and miscompiles. Reverted whole. The real blocker
  was the new peer `Hβ.emit.plumbing-twin-selfcall` (CLOSED — no twin ever
  miscompiled; the trap was the ambient stack cliff, fixed at zip_with's
  tail form) and then `Hβ.emit.twin-state-width` (CLOSED — the twin-edge
  conversions: args word-faced, results deref'd, inits boxed; the hstate
  slot ABI is floor-owned words because the shared arm fns read it).
  **5.1a LANDED 2026-08-07** (pin 6fb09a99fb1e — TRANSITION, census 0,
  emit +17% as banked, RSS inside the raised ceiling, the f64-state
  guard green through the total twin set): the worthiness gate is
  DELETED, every candidate twins, and the uniform seam where every
  measured silent-wrong lived is gone. The dead worthiness family
  prunes as its own sweep; type-total still arrives as the Repr ADT
  grows (5.1b — no separate landing).
- **5.2 · `Hβ.infer.schemes-are-edges` rung 3**, the row half, per the settled
  laws in `RESIDUE.md`. THE ROW HALF LANDED 2026-08-07 (pin a13918ee5784 —
  the prereg publish is generalize's own floor, the group drain re-parks
  cross-group gates, two honest +WASI widenings; movers 678 → 453 and
  false T_OverDeclared teachings dead; the parallel final SERIALIZED as
  its precondition — judge_window 1, the K=8 fan's value-boundary law
  dissolved by live cells, the parallel form returning at 9.2 with atomic
  join writes). The movers arc then CLOSED its classes by measurement:
  the grade class (250) is the condemned cadence's own artifact (two
  builds refuted one-sided patching — the divergence relocates; it dies
  with the pass), the type-sort class is benign-by-checking (the pair
  accidentally implements propose-and-check polymorphic recursion; the
  final's clean total re-judgment is the decidable check), and the 26 row
  residuals exposed a REAL under-publish in the shipping pass — the named
  peer `Hβ.infer.forward-hof-row-underpublish` (crown-adjacent: a
  pure-published allocator under a declared `!Alloc` is a false absence
  proof; the ten-iteration dossier and the root-trace instrument live in
  RESIDUE). D8's gate re-derived: every mover class driven to zero or
  proven benign; the peer owns the remainder. With 5.5's column arc this
  also UN-GATES the arena's 2b (4.3's correction): published facts in
  columns make the image set = pages + flat buffers by construction,
  which is what a per-decl reset needs to be sound.
- **5.3 · The decidable fragment plus the proposed-signature teach.** Type
  inference for polymorphic recursion is undecidable (Henglein 1993,
  semi-unification) and that is a theorem, not a design choice — **but Mentl
  currently conflates it with the ROW side, where arXiv 2510.20532 reports
  inference decidable, sound and complete. The row half of the signature price
  may be unnecessary.** Henglein also gave a decidable *fragment* (single
  recursive call, non-nested); bimorphic recursion is decidable too. Haskell and
  OCaml take the crude route — annotate or refuse, no fragment. Infer the
  fragment and beat both. And the framing is the actually-anti-Mentl part: a
  "price" is a tax, where §1's own law says the question beats the guess. The
  medium already knows enough to *propose* the signature from the call sites it
  judged. Deepest of all, iteration-is-topology shrinks the region to near-zero,
  because derived folds are generated and their signatures are known by
  construction. Do not fight the theorem; make it apply to almost nothing.
  THE ARC LANDED 2026-08-07, three steps in one day
  (Hβ.infer.sigd-polymorphic-recursion carries all three): (1) pin
  d8142b3b — the signature'd form ACCEPTS (Haskell/OCaml parity; the
  emit divergence the gate opened closed with the per-base demand cap +
  the spec self-reference floor). (2) pin 7f4bf082 — the TEACH: the
  refusal carries T_PolyRecursionSignature naming the fn from the
  refused cell's own mint reason. (3) pin 94fd07add038 — THE FRAGMENT
  INFERS: unsig'd poly recursion judged by three-round Mycroft
  iteration on the checkpoint substrate (plain-under-capture → general
  assumption → recheck under the result scheme;
  graph_commit_checkpoint born as speculation's accept half) — depth
  unannotated runs 3, BEYOND Haskell/OCaml's annotate-or-refuse; the
  K-exhausted floor refuses honestly with the narration. Remaining
  here: the row side (arXiv 2510.20532), the alpha-stability detection
  + the multi-call fragment boundary, the concrete-signature
  derivation in the teach, iteration-is-topology's shrink.
- **5.4 · The value ontology dissolves, in its PROVEN sequence** (band D —
  the 13-agent-refuted design, arena-gated, order inverted from every naive
  form: representation FIRST, type-merge LAST). (0) `fold_sig`
  distinguishability SETTLED first (the byte leaf's nominal identity vs
  repr-reading fold_sig — the recorded structural decision); RI8 as
  zero-reader vocabulary; the repr-width-polymorphic flat leaf PROVEN on
  WIDE elements ([Float]/[i64]) where no header collision exists. (1) The
  emit consolidation DEFENSIVELY — the ~10 TString-vs-TList outer forks
  collapse into one `match repr_of(elem)` dispatch KEEPING the nominal arm
  H6 names. (2) The runtime reconciliation as its own perf-measured
  TRANSITION — `Hβ.value.seq-element-stride-carrier` (the true keystone: a
  generic body compiles once with a TVar element, so packed traversal
  requires a runtime stride carrier read at access — a fat sequence header
  — or whole-program monomorphization, which 5.1 supplies); the view/slice
  unification; the `[len][bytes]` literal; the concat-persistence decision.
  (3) ONLY THEN the type merge, when the runtime agrees — the self-hosting
  oracle is BLIND to this class (m3==m4 stays byte-identical while user
  code corrupts), so the WIDE-element gates and the stride crucibles are
  the oracle, banked RED-first. With it: `Hβ.infer.seq-addr-downcast` (the
  capability-gated down-cast), `Hβ.infer.seq-op-signature-driven` retiring
  is_seq_op, and the show/compare/hash leaves generalize into the ONE
  `fold(ty, leaf)` — the four generators become four leaves of one walk
  (`Hβ.fold.show-leaf` / `.compare-hash-leaf`), ~1,200 lines gone.
- **5.5 · The subsystem table's remaining 40% — one repeated move, run to
  its end.** The mechanical test (does the per-handle fact live in a spine
  COLUMN?) applied four more times: LOWERING (`Hβ.lower.lowering-is-a-column`
  — LowExpr's 39 handle-first constructors and their walkers become columns
  + one emit walk, killing the lower-time-bake class the ledger declared
  dead three times, and making per-decl incremental EMISSION the same cone
  machinery that re-judges; sequenced after 5.2 exactly as its entry
  prescribes — swap the representation behind the projections); the ENV
  (dissolves with 5.2's schemes-are-edges; the two hand-rolled indexes
  re-key by handle onto the one smap primitive —
  `Hβ.runtime.indexed-map-primitive`); the REVERSE EDGE (a spine column,
  written at the one writer, replacing three subsystems' re-derivations —
  LANDED 2026-08-07, the refs + decls columns, the peer closed);
  the verify/tighten BANKS (per-SITE durable facts — span-keyed
  obligations and tightenables — that become spine columns WITH their
  per-handle readers: the 11.2 dashboard's "V_Pending at this position"
  and 5.6's per-position audit read; sequenced there, not before — a
  column nobody reads per-handle is machinery. The AFFINE ledger is
  struck from this list by measurement, 2026-08-07: its state is
  transient bracketed judgment memory — used-set, borrow depth, branch
  frames, per-fn save/restore — that dies at scope exit; handler state
  IS its correct form, and the durable half it produces, the resolved
  ownership grade, already lands on the fn's TFun at 4.2's one writer).
  Band G rides along — SEQUENCED WITH THIS ARC BY MEASUREMENT
  (2026-08-08): `Hβ.egraph.per-expr-effect-row` is DEP-gated by its own
  site comment (is_pure reduces to effs_at only when infer grows a
  per-expr row binding — a spine column, this arc's own move), and
  `.typed-rulecyclic`'s RED case is unreachable-by-construction until
  the rule set grows (graph_canon_set's strictly-cheaper invariant
  makes the chain monotone; the typed refusal lands WITH the first
  grown rule, where a cycle becomes constructible). `.rule-as-query`,
  `.const-fold-minted-node-full-edges`, saturation deepened; and
  `Hβ.egraph.install-algebra` — the `~>` edge enters the e-graph (elision
  when the extent proves it, the row licensing both rewrite-legality and
  candidate-legality).
- **5.6 · `mentl audit` goes LIVE — the §0 keystone.** With judgments
  reading the graph (2), the surface true (3), ownership real (4), and the
  facts in columns (5.5), the audit is a READ: the Carried-Truth projection
  (`Hβ.audit.carried-truth-projection`) flags a re-derivation/snapshot/
  fabrication BEFORE a line lands — the census shapes, the iteration tier,
  the drift catalog, and the working-discipline hooks absorb into it, and
  the human stops being `mentl audit` by hand. THE ABSORPTION RUNS BOTH
  MOTIONS (opened 2026-08-08, the cadence established at one marched
  landing per mode): INTO the medium — three drift modes are census
  shapes with per-fn audit tiers (mode 10 wildcard-zero, mode 13
  failure-mask, mode 16 print-in-report — the last the first
  CONTEXT-SENSITIVE shape, a fuel-bounded subtree walk every future
  context mode reuses; the medium's detector out-measured the bash grep
  on its first run, 3 wheel sites vs 1) — and OUT of the scaffold: five
  bash rows deleted (modes 30 + 36's fence/keyword/fn-lambda), each
  shape probed COMPILER-REFUSED first (E_NotAKeyword, E_LambdaFence,
  E_RedundantFnOnLambda) — a bash row policing a refused shape is a
  weaker second copy of an armed diagnostic. The three absorbed shapes
  are RATCHETED (2026-08-08, the enforcement half): verify's drift-shape
  tier counts them on the wheel link per gate pass — wildcard-zero held
  at its 9 documented sentinels, failure-mask and print-in-report at
  ZERO — each arm seen RED at an under-set ceiling, and their bash rows
  retired in the same commit (the mode-33 precedent: the grep dies, the
  projection + ratchet is the check). Mode 10's typed fabrications
  (Forall/TVar/"Pure"/"") landed as the FOURTH shape
  (CsWildcardFabricates, pin 8f11d81b61d4 — the census roster at
  thirteen, the audit tier a quad), ratcheted at its measured 21 (seen
  RED at 20) with the four typed rows retired — mode 10 is WHOLE in the
  medium. Mode 15 (underscore-retain) followed as the FIFTH shape (pin
  54bf749eab9f — roster fourteen, tier a quint), BORN AT ZERO on the
  wheel link, its row retired. The remaining bash rows are naming/prose
  modes (the raw channel's own domain) plus the structural stragglers
  (mode 8's flag-as-int compares, mode 1/2/7's shape rows), absorbed as
  their shapes prove out. Its unsayability face
  matures through Phase 8's diagnostics; its arrival is when a wrong move
  in the wheel's own source is a REFUSAL, not a review finding.

---

### Phase 6 · The crown completes — `!E` sound at every altitude

The spine root finishes. Order inside the phase is the dependency order.

- **6.1 · R1: `EffName`-is-a-handle** — ✅ LANDED 2026-07-24 (pin
  91e35f1e, commit f695480d "identity is a contract"), found already
  whole at the 2026-08-08 phase walk: ENamed/EParameterized carry the
  intern handle, eff_name_handle is the Pure i32 comparison key, the six
  by-name str_eq leaves became word compares, and the landing's own
  record closes the residual — "the crown's positive-path residual
  closes by construction: byte-equal-but-pointer-distinct names are
  untypeable, and a missed mint is a loud type error."
  `Hβ.effects.positive-row-pointer-eq` dissolved there.
- **6.2 · Instance-precise negation** — ✅ MECHANISM WHOLE at the same
  walk (`eff_forbids`' instance arm refuses same-instance and
  not-provably-distinct, admits provably distinct; `eff_admits` the
  positive dual from Phase 1); THE GATE LANDED 2026-08-08: four
  instance crucibles in tests/crown/ (leak-instance-same,
  leak-instance-bare, sound-instance-distinct,
  sound-instance-bare-admits), crown 12/0. The fifth stamped fixture
  (the EANode conservative arm) is UNCONSTRUCTIBLE from the surface:
  the with-clause parser refuses non-literal effect args
  (E_EffArgNotLiteral, live at parse) — a measured tension with the
  W23-era claim of that class's deletion; the EANode-in-with-clause
  surface is `Hβ.syntax.effarg-node-in-with-clause`, named here, and
  the conservative arm's crucible lands with it.
- **6.3 · The modal world-index** — `Hβ.effects.modal-world-index` +
  `Hβ.infer.modal-capability-at-tee`: rows + capabilities + negation sound
  SIMULTANEOUSLY as a graph fact. The route is the graph, not the calculus:
  a row var becomes a lexical capability handle at the `~>` edge (no new
  surface form — SYNTAX's modal-readiness note), the modality inferred and
  cursor-projected, with the POPL-2026 rows≡capabilities encoding as the
  external check on the design and the NEGATION half carried by the
  flow-edge substrate the crucibles already police. The burden stays on
  the build: the crown battery grows a crucible per modal rule, RED-first.
  THE FELT WALK RAN 2026-08-08 (six probes; one same-day narration
  correction per the retraction law), and its measurements REFRAME the
  phase — today's medium already holds the conjunction on every walked
  shape: (1) the ESCAPE (a closure performing E, escaping its `~>`
  install, called outside — the shape capability calculi forbid) is
  ADMITTED, dispatched by tier — the static singleton tier direct-calls
  the one handler; under MULTIPLE handlers the dynamic innermost
  install resolves (mn-escape-innermost pins 20, refuting the walk's
  first "birth-capture" decode); with NO handler reaching the root the
  executable REFUSES (E_EffectUnhandled, armed — "nothing executes
  unproven" in the diagnostic's own words). (2) The NEGATION stays
  sound across the escape (leak-escape-negation: an outer `!E` refuses
  the escaped performance — the closure's row kept E riding the
  value). (3) MASKING satisfies negation (`with !E = (work) ~> h`
  accepts — the install's subtraction at evaluation). (4) POLYMORPHIC
  THREADING absorbs through the HOF (`run_it(() => op()) ~> h` under
  `!E` accepts). Crown crucibles pin all of it. The REMAINDER: the
  TIME half (a persisted k under a changed handler set — rides 9.1
  with 6.4's value gates), the per-modal-rule crucible sweep against
  the POPL-2026 encoding (OPENED 2026-08-08, nine rules pinned at
  crown 29/0 — accepts: mask composition with innermost dispatch
  measured at runtime, the latent/performed distinction (E riding a
  RETURNED closure's value row while the constructor's own row stays
  pure under !E), double-HOF threading, the mixed row's licensed
  half (F + !E performing only F), the absolute modality (a Pure
  closure born beside an absorbed perform transports out of its
  birth world unchanged — the []-boxed dual of the escape leak),
  the subtract half at the INSTANCE altitude (an instance-unpinned
  handler is SYNTAX's own "explicit handler bridge" — its install
  clears a pinned instance's row, satisfying an instance-precise
  negation; a handler pinned to one instance is unconstructible
  today, so the over-absorption crucible lands with that surface);
  refusals: install-extent
  exactness (an op AFTER the install closed is unabsorbed), the
  mixed row's negation half (the F license never launders E), and
  the tee's ADD half under negation (an arm-performed F meets an
  outer !F — row(expr ~> h) carries + row(h), so absorbing E never
  launders the arm's own F; the sound dual declares F + !E and the
  pair differs only in the declared row, its own control); the
  sweep continues rule-by-rule), and the
  capability-at-tee PROJECTION — ✅ LANDED 2026-08-08 (pin
  2dcd736eb4e6): `mentl where` renders every install as
  `~> h absorbs E at <span>`, the effect set from the handler's own
  arms — the modality as a derived badge, the felt face real.
- **6.4 · TIME's world enforced** — the `TCont` world stops being inert.
  THE CAPTURE IS LANDED, verified at the 2026-08-08 phase walk:
  `Hβ.infer.tcont-world-capture-at-reify` is real —
  inf_current_world() (the current frame's LIVE row var, infer.mn:187)
  rides every PendingContinuationBoundary and
  finalize_continuation_boundaries threads it into the TCont's world
  field; and the declared-but-unwired `E_ResumeWorldMismatchWorld`
  ctor no longer exists (zero construction sites) — the runtime
  refusal is persist's rehydrate REFUSING via Fail, band B's own
  record. REMAINING here: the value gate's TYPED form (the Fail
  refusal graduating to a located diagnostic when the persist surface
  matures), `Hβ.continuations.world-widening-resume` (the typed
  superset-resume), `Hβ.persist.branch-world-tag` — all riding band
  B's persist runtime, sequenced with Phase 9.1 where that substrate
  ships.
- **6.5 · The gated verdicts unlock.** Everything band A held: ownership-
  as-effect VERIFIED, `!Thread`/`!Alloc` transitivity
  (`Hβ.parallel.thread-alloc-transitive-proof` — the `!Thread` HALF
  VERIFIED 2026-08-08 by crucible: the transitive spawn on the REAL
  lib/threading vocabulary refuses under a declared `!Thread`
  (tests/frontier/mn-thread-negation.mn, the frontier leg — the crown's
  stdin harness cannot link lib, so the real-vocabulary crucible lives
  there), the thread-free region accepts, and the REAL-TIME CLAIM
  measured: a bare `><` inside `with !Thread` accepts because the verb
  is pure topology — SYNTAX's provably-race-free sentence now has its
  gate; the `!Alloc` half rides the arena's honest-row attribution),
  race-freedom-by-ownership
  (`.race-freedom-ownership-proof`), and `Hβ.syntax.perform-dissolution`
  closing the surface's last ceremony — ✅ EXECUTED. Terminal gate: the
  crown battery whole (leaks reject, sounds accept, instances precise,
  worlds enforced) — DONE statement (2)'s first half.

### Phase 7 · `!Flow` — the crown applied to data flow

*(The phase's felt walk ran 2026-08-08 through the shim + fresh m2. The
projection layer is real end-to-end — `mentl query <f> "flow NAME"` →
QFlowOf → query_flow_label → predicate_flow_label — and the walk's one
find landed: the TFun arm read the ROW alone, so a `-> Vault` source
(`Vault = String where classified(self)`) answered Public while the
value's own scheme answered Secret; the return-label join closes it
(tests/frontier/mn-flow-refined-source.mn, seen RED against the boot at
exactly that split). Two named truths from the walk: the classifier's
vocabulary is a predicate-NAME heuristic (str_contains
secret/classified/sensitive in predicate_flow_label) — a seed the
`.flowlabel-inference-in-hm` chain replaces with labels as graph facts,
never the shipped form; and FlowLabel's constructors (`Secret`,
`Public`) occupy the user namespace, so a program's own `type Secret`
collides with the label vocabulary — the namespacing question rides the
inference landing.)*

The C chain in its banked order, DEP-rooted on Phase 6:
`Hβ.ifc.dcc-noninterference-gate` → `.flowlabel-inference-in-hm` (the
label lattice joins riding the same union-find; 2.0's eq coherence is why
label compares are trustworthy) → `.pc-label-implicit-flow` →
`.integrity-dual-lattice` (the agentic regime's forcing function — the
integrity spec that makes the mechanism honest) → `.declassify-robust` →
`.flow-world-on-tcont` (labels survive TIME) → `.agentic-fides-target`.
The string-splice IFC check is the landed seed; the honest disclaimer
stands (the lattice proves where OUTPUT may go, never what a model does
inside its window). Terminal gate: `!Flow(Untrusted -> Sink)` discharged
like `!Alloc`, both regimes first-class — DONE statement (2) whole.

### Phase 8 · Verification whole — proof beats review, measured

- **8.1 · `Hβ.types.predicate-is-expr`** — PExpr dissolves; predicates are
  ordinary expressions, and the comparison-chain degradation SYNTAX
  documents becomes the loud inference rejection.
- **8.2 · The decidable fragment complete.** The interval engine's banked
  redirect executes: the self-call IH lands on 5.2's dissolution (the
  peel/publish tower gone, class-based reads deterministic); the six
  standing `0 <= self` pendings discharge via authored refined annotations,
  march-measured each; `Hβ.refine.buffer-invariant`,
  `Hβ.infer.predicate-from-bool-expression`,
  `Hβ.verify.higher-order-refinement`, and the DSP tier
  (`Hβ.dsp.hz-ceiling-ambient-sample-rate`,
  `Hβ.dataflow.clock-calculus-sample-rate`) fill the fragment out.
- **8.3 · The SMT handler swap** — `Hβ.verify.smt-handler-swap`: Z3/CVC5
  behind `~> verify_smt`, certificate-CHECKED (the checker inside, the
  solver outside), discharging the undecidable residue by residual theory;
  if an external solver persists at DONE it is the NAMED external-SMT
  `!Outside`, priced honestly. `Hβ.verify.ledger-soundness` (no silent
  assume-true, the Dafny cautionary), `.proof-incrementality-cached-cursor`
  (obligations re-discharge only in the changed cone),
  `.reason-edge-pcc-certificate` (a discharged proof carries a walkable
  certificate — proof-carrying code as a Reason projection).
- **8.4 · Diagnostics' final form.** `Hβ.diag.catalog-as-projection`
  (report takes DiagKind; SYNTAX's three tables become projections of
  types.mn — the hand-kept second home dies),
  `.minimal-inconsistent-core`, `.declared-row-contradiction` at the decl
  site, `Hβ.emit.trap-as-exception-postmortem` (a BUG-trap unwinds with
  the graph state as payload), `Hβ.infer.marked-lambda-totality-invariant`
  — and UNIVERSAL executable refusal: the remaining name-dependent census
  classes become armed, so every diagnostic class refuses the executable.
  The audit's unsayability face (5.6) completes here.
- **8.5 · Band K — the proposer's receipts.**
  `Hβ.proposer.constraint-not-token-worked-example` (the Lahiri worked
  example answering the spec-oracle problem) and
  `.synth-handler-error-fed-back` (a refuted candidate returns as a
  lossless CONSTRAINT, not a lossy token). Terminal gate: DONE statement
  (1) — the crown sound, Verify decidable-with-honest-debt, SMT
  certificate-checked, every armed class refusing.

### Phase 9 · TIME and SPACE ship — computation durable, cursors parallel

- **9.1 · `persist = memcpy` becomes a shipping claim.**
  `Hβ.continuations.persist-equals-memcpy-handler` over the image-map fold
  (`Hβ.emit.image-map-fold` — the layout as ONE fold, overlap
  unconstructible; the multiple-memories proposal as the image/scratch
  boundary when the substrate carries it), `Hβ.persist.cross-machine-resume`
  (the session a value that moves), `Hβ.persist.module-image-cache` (band
  O — cross-run compile skip as image persist, the deleted .kai layer's
  lesson honored), `Hβ.driver.per-module-env-overlay`'s image face, and
  the multishot polish: `Hβ.lower.either-install-negotiation`,
  `.multishot-uzero-abort`, `Hβ.infer.tail-recursion-resume-cardinality`,
  `Hβ.ml.autodiff-as-multishot` as the demonstration workload. Felt faces
  land WITH it: `Hβ.felt.time-travel-debug-forked-cursor` and
  `.hole-is-dormant-continuation` (Hazel fill-and-resume = the record).
- **9.2 · The parallel cursors.** §5.O layer 4:
  `Hβ.driver.level-set-par-walk`'s multi-core half (`>< ~> Thread` at decl
  granularity on the compile spine) with
  `Hβ.native.deterministic-handle-partition`'s (arena_id, offset) law so
  m3 == m4 SURVIVES parallelism — re-pinned as the sharpest TRANSITION;
  `Hβ.lower.fanout-simd-lane-cashout` (RV128 real),
  `.fanout-gpu-backend-handler` named-or-built per hardware,
  `Hβ.cursor.work-stealing-via-gradient` (idle cores ask the cursor; the
  argmax IS the queue), `.speculative-compile`,
  `Hβ.lower.schedule-specialized-callee` (skeptically scoped as banked),
  `Hβ.f1.handler-substrates`. Safety verdicts ride Phase 6
  (`Hβ.native.effect-state-parallel-safety`'s row face).
- **9.3 · §5.O layers 1–2 finish.** Name-is-handle at LEX (the intern
  table born where scan_ident mints), env O(1) by handle
  (`Hβ.perf.env-o1-index` — largely dissolved by 5.2; whatever survives
  re-keys), reachability as an EDGE (`Hβ.lower.reach-edge-on-node`,
  `.reach-membership-o1`), `Hβ.infer.instantiate-shares-never-clones`
  gated on its alloc count. Every remaining scanner is a place the graph
  already knew — deleted, not tuned. Terminal gate: DONE statement (4),
  and the oracle's fusion substrate (N forked cursors × N threads × one
  image) REAL — statement (6)'s machinery.

### Phase 10 · `!Outside` closes — the execution layer joins the medium

- **10.1 · The native backend** — `docs/NATIVE.md` S0–S18, WASM-peer-
  verified through S12: `Hβ.native.frame-rep-from-cardinality-trail`
  (KEYSTONE 1 — frames in the image, the trail the reclaimer, continuation
  = memcpy stays TRUE natively), `.deterministic-handle-partition`
  (KEYSTONE 2, shared with 9.2), `.repr-regclass`, `Hβ.infer.use-profile`,
  `.reg-residency-egraph-remat` (allocation = residency, eviction =
  rematerialization at extraction cost), `.fp-simd-determinism` (SSE-only/
  no-FMA/RNE pinned — THE fixpoint-killer named before it kills),
  `.foreign-handler` (the one seam for the un-Mentl world),
  `.wasm64-backend-handler`, `Hβ.emit.memory-gc-handler` named. NATIVE
  FIRST-LIGHT: native_m3 == native_m4; wasmtime and WABT retire.
- **10.2 · Trusting-trust closes.** `Hβ.closure.diverse-double-compilation`
  (a second disposable seed converging to identical m3 — DEP native, per
  Wheeler), and `Hβ.closure.correctness-oracle-internal`: the micro
  battery ABSORBS into the wheel's own Verify, so first-light's
  correctness half loses its last external oracle.
  `Hβ.synth.proposer-gauntlet` closes reflexivity over proposers.
- **10.3 · The scaffolds absorb; the docs project.** march → `mentl march`,
  verify → `mentl verify`, state.sh → state-as-projection, the drift
  hooks → the live audit, the 0.2 lag list drains (`where` lands in 3.2,
  `why`/`diagnostics`/`verify`/`at` here), the shim dissolves into real
  `mentl run`/`asm`, wt-env.sh dies with it. `LEDGER.md` and `RESIDUE.md`
  begin dissolving into projections (`Hβ.query.generation-operand` —
  `mentl why --at <sha>`; the frontier ranking IS the residue index).
  Terminal gate: DONE statement (7) — every lever inside, and the two
  named residual Outsides (external SMT if it persists; the intent space,
  permanently) stated as exactly what they are.

### Phase 11 · POLISHED — the felt surface whole, the loop closed, DONE measured

The co-equal aspect (§4⑦) consolidated, not begun — most of its substrate
landed in 5–10; this phase is the finish that makes it FELT.

- **11.1 · The fused fan.** The `??`-fan and the e-graph compose in the
  FORCED order (prove-then-extract): a survivor is an equality class,
  extraction picks under the effect-aware rewrites, the repr gradient pins
  widths — a proposal is proven AND extraction-optimal. The gradient
  ranker (Reason chains + proximity + in-scope vocabulary) seats; the
  teaching TIE-BREAK asks the minimal-entropy question when meaning-space
  ties; `!E`-gated speculation live-runs only what the crown proves inert.
- **11.2 · `mentl edit` polished.** The keystroke→parse→format→render loop
  continuous (`Hβ.felt.mentl-edit-runtime`), reactivity typed and
  demand-driven, the verification dashboard (live V_Pending / transitive
  `!E` / Why chains), collab as Grove-CRDT over the TYPED graph,
  legibility derived. Every reader-facing page leads with the person at
  the keyboard; the docs themselves pass the source standard.
- **11.3 · DONE, measured.** The seven statements run as gates, each
  already owned by a phase above — (1) Phase 8, (2) Phases 6–7, (3)
  Phases 2–3 + 10.3's Why-total, (4) Phase 9, (5) Phases 5.6 + 8.4 +
  11.2, (6) Phase 9's fused oracle as the default judge, (7) Phase 10 —
  and the TERMINUS is measured against its three legs: next-move
  supremacy, the question beats the guess, the loop is felt. Teachability
  is leg 3's named face: the surface IS the course. The board that day is
  the same board as tonight — verify, march, crown, frontier, census,
  doc-truth — every gate green through a pin the medium blessed itself,
  and the honest audit in §7 EMPTY, because a seam held open on purpose
  is the one thing DONE has none of.

**NOT A PHASE — the docs record what is true as each phase lands.** Batching
doc-truth at the end is exactly what produced the eleven-entry crown gap. §7's
honest audit, `LEDGER.md`, and `RESIDUE.md` move with the artifact or they are
the next drift.

**Excluded by hardware only:** MI300X execution, hosted CI, wasmFX,
shared-everything-threads. Every dispatched agent runs Opus 5 or Fable 5 —
whichever is most effective for that job — passed explicitly; every landing
re-derived on main; the board is the gate.

**THE FELT-PATH-FIRST LAW (paid for 2026-07-28): every phase OPENS by walking
its felt path** — the exact surface an outsider or the daily loop touches,
through the installed shim, before any build starts. A DEP found by walking is
cheap; a DEP found by an outsider is a category loss.

**THE TERMINUS is §1's closed loop:** human and Mentl only, no LLM
advantageous at any scope — every landing measured against the three legs
(next-move supremacy · the question beats the guess · the loop is felt). Leg 3
carries TEACHABILITY as a named face: the surface IS the course, evolved until
picking up Mentl teaches programming itself, so the model is unemployed at the
learning scope too. And every reader-facing page leads with the person at the
keyboard; verification is the mechanism and the receipts, never the identity.
