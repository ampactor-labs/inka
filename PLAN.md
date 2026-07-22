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
avoid, realized through the row representation. The adversarial soundness GATE
LANDED (2026-07-13, effects.mn `row_subsumes` EfNeg arm): the negation membership
matches BY NAME (`forbidden_names_disjoint` / `eff_name_str`) — `!E` proves the
ABSENCE of the effect NAMED E (SYNTAX §Negation), every instance — because the old
check compared names with pointer `i32.eq` and a byte-equal `ENamed("E")` from an
effect decl and from a `with !E` clause are distinct heap objects, so a forbidden
effect smuggled straight past the gate (direct, transitive `a→b→bad`, and
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
- **`instantiate` → `subst_ty` tree-clone** (infer.mn:2687) + **`find_mapping`'s
  per-leaf `filter`-alloc** (infer.mn:2840): a full type-tree clone per
  polymorphic reference, garbage per TVar leaf.
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
lex (the content-intern table is the one O(1)-amortized hash — and it ALREADY
exists for the data section, `string_offset_lookup`, today O(n)-scanned at
wasm.mn:199; fix IT to O(1) and its offsets ARE the universal name-handles). Then
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
   The str_hash indexes shipped as WAYPOINTS (summary/region/env/base/esc/reach —
   six hand-rolled copies) are ONE primitive, `Hβ.runtime.indexed-map-primitive`:
   a `Map(k,v)`/`Set(k)` over the sequence/product node-kinds, key-type-dispatched
   by the same proof-becomes-dispatch the emit already does — ~200 lines deleted
   once names are handles. Each a Carried-Truth deletion.
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
> `docs/research/post-first-light-roadmap.md`**, the SOTA map in
> `docs/research/sota-convergence.md`). Each is a positive-form named peer — a
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
> artifact-grounded; full record `docs/research/destiny-audit-2026-07-14.md`)
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

**B · Continuations & TIME (arm 2, §4④) — the binding keystone. LANDED: `Hβ.lower.continuation-reification-codegen` (the k1→M4 arc self-hosted through the fixpoint, §7); `Hβ.continuations.multishot-reexecution-driver` is SUPERSEDED (the 2026-07-11 pivot — re-execution restarts, the felt spec demands resume), `Hβ.lower.arm-internal-perform-scope` closed by the M3 lexical-evidence fence.** `Hβ.types.tcont-world-binding-keystone` (STEP 5 landed the 3-arg arity; the world is INERT on OneShot — ENFORCE it) · `Hβ.types.resume-world-mismatch-value-gate` (the runnable gate; layout-in-world coupling; DEP persist resume-catcher + STEP 1) · `Hβ.infer.tcont-world-capture-at-reify` (at the multi-shot producer's reify site) · `Hβ.continuations.world-widening-resume` (typed superset-resume) · `Hβ.continuations.persist-equals-memcpy-handler` (= `Hβ.lower.fanout-durable-persist-handler`; `~> Persist`, zero serializer; STEP 3 producer landed; the standardized multiple-memories proposal is this peer's substrate cash-out — a dedicated IMAGE memory snapshots whole while scratch lives apart, the memcpy boundary drawn by the module format itself) · `Hβ.persist.cross-machine-resume` *(new)* · `Hβ.persist.branch-world-tag` (persist.mn:119) · `Hβ.continuations.wasmfx-lowering-tier` *(substrate PROBED 2026-07-10: wasmtime 43 `-W stack-switching` + wasm-tools 1.252 assemble native typed-continuations — single suspend/resume runs (fx1→10) — but the cont is LINEAR: resuming one twice PANICS the engine (`ptr::eq(head, self)`). So native gives ONE-shot free (already fast-pathed by direct-call) and does NOT solve MULTI-shot; the multi-shot keystone is RE-EXECUTION — `cont.new(body)` fresh per resume, replaying prior performs, the trail/rollback substrate the driver — not native cloning. `perform`→`suspend`, `resume(v)`→fresh-cont resume; the emit path switches to wasm-tools for continuation modules (WABT can't assemble `cont`). This IS the producer-invocation keystone the cardinality fix unblocked — see §7)* · `Hβ.continuations.multishot-reexecution-driver` *(the re-execution driver — PROVEN END-TO-END 2026-07-11, crucibles in tests/native-cont/: native-cont `twice` → 3 (identity) and 13 (non-identity `pick()+5`, the continuation after the perform captured natively), and the same model in Mentl source → 30 through boot. A multi-shot handler is a DRIVER over re-runs: `resume(v)` = fresh `cont.new(body)` resumed to the `suspend`, then resumed with v; `suspend` unwinds the perform to the driver so the arm runs OUTSIDE the body's stack (no re-entrancy — the trap the pure-Mentl outer-install form hit). Correct for identity / non-identity / no-perform. **BUT native conts are BLOCKED under WASI `_start` (wasmtime 43, verified 2026-07-11): a single `cont.new`+`resume` under `_start` panics `ptr::eq(head, self)` — the command entry runs on wasmtime's own fiber and a user continuation violates its stack invariant; `--invoke` works, `_start` (every real program) does not, and no flag avoids it.** So native conts are the O(1) future (an `!Outside` dependency until wasmtime carries them under `_start`), NOT the shipping substrate. THE SHIPPING PATH is the PURE-MENTL re-execution driver — `resume(v)` re-runs the body thunk under a one-shot replay handler, all ordinary handlers, works under `_start`: the DIRECT form (arm logic as a driver fn, no outer install) is proven (reexec-model.mn → 30) and correct when the body performs the op unconditionally (mn-multishot). The general form (conditional / no-perform bodies) needs the ARM-INTERNAL-PERFORM GAP closed — the re-run's perform must resolve to the inner replay, not re-enter the outer handler (the pure-Mentl outer-install driver's 134 trap). THAT is the real keystone dig, `!Outside`-clean. Each rerun is a stateless fork → trivially parallel + durable, the SPACE=TIME fork §5.U scheduled by `~> Schedule`)* · `Hβ.lower.arm-internal-perform-scope` *(new — the gate under multi-shot: a handler installed INSIDE an arm body (`bt() ~> replay(v)`) must shadow the enclosing handler for performs in the re-run; today the re-run's perform re-enters the outer handler (evidence threads to the wrong install). Closing it makes the pure-Mentl re-execution driver fully correct AND fixes arm-internal effectful installs generally — core handler correctness, not just multi-shot)* · `Hβ.infer.tail-recursion-resume-cardinality` (infer.mn:3174) · `Hβ.lower.either-install-negotiation` · `Hβ.felt.time-travel-debug-forked-cursor` *(new)* · `Hβ.ml.autodiff-as-multishot` (autodiff.mn:36).

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
the pinned boot (chain: boot/PROVENANCE.md, newest pin = the census-6
diagnostic-address landing). **`mentl voice.mn:9` ANSWERS** (the
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
`docs/research/finish-plan-codex-2026-07-17.md`; its honest de-hyping salvaged
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
- **Thread / SIMD / GPU schedules + the persist handler** are scaffold / proxy,
  proven by fanout-arithmetic fixtures, not by real spawn / lane / device /
  disk (bands E/O).

Everything else on the board above is measured green; this list is the seam
between the wheel and its ultimate form, held open on purpose.

### The landing ledger (newest first; · pin = boot re-pinned)

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
  for correctness on these shapes). Board whole: census 0, frontier 150/0,
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
  never writes the shared world-writable /tmp (the symlink-planting surface
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
- 2026-07-14 · destiny audit (8-subsystem, artifact-grounded): machinery real / wiring absent; the R1–R6 path — docs/research/destiny-audit-2026-07-14.md
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

The manifest arc's residue (2026-07-18, the arc itself CLOSED — §7 ledger):
`Hβ.infer.order-independent-verdicts` (the census is ORDER-CONDITIONAL: a
runtime fn declared before its prelude consumer meets the TIGHT inferred
scheme where the canonical order met the loose pre-registered one — three
real latent mismatches at prelude sum/chunk/trim under a leaves-first
weave; the canonical sort sidesteps, the class remains; repro: swap
lists/strings before prelude on stdin) ·
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
· `Hβ.format.render-totality-before-fmt` (mentl fmt wiring is premature:
render_body_tokens carries `<expr>`/`<stmt>`/`<pat>` surrender-fallbacks and
format_chain is unreachable from format_program — totality first, then the
verb) · `Hβ.multishot.handler-return-clause` (M5 — named twice in
docs/research/multishot-general-design.md as the next ladder step, absent
here until now) · `Hβ.lower.branch-isolated-handler-state` (the multishot
doc's own correction, missing from every band) ·
`Hβ.infer.usage-grade-unifies-cardinality-ownership` — NOTE: this peer's
name was REUSED on 2026-07-17 for the branch/scope ownership fix; the
ORIGINAL residue (unify classify_usage and resume_grade onto one count_uses)
is still open and lives under this line ·
`Hβ.emit.compose-width-floor` (implemented in lower.mn, tracked nowhere until
now) · `Hβ.cursor.gradient-queue-activate-or-delete` (built, exposed, zero
callers) · `Hβ.graph.fork-dead-code` (graph_fork + the overlays
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
bash ide/serve.sh              # mentl edit in the browser (localhost:7378/ide/) — SERVED BY MENTL (ide/serve.mn)
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
    inline. PASS A MODEL on every dispatched agent — `sonnet` for read-only
    sweeps/measurement/designers, `opus` for builders/judges/adversarial
    verifiers, NEVER Fable (Morgan 2026-07-02; the copilot's depth is for
    synthesis, not breadth). This retires "omit model-params"; the discipline
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
    adding 43 lines; the flurry plan caught it).

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
full harvest `docs/research/production-bar-fleet-2026-07-17.md`; 115 designs,
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

- **CI, host-agnostic and REQUIRED**: every push → the full board
  (tools/ci/run-board.sh: state.sh + the perf ledger). Any always-on
  Linux with wasmtime serves; the MI300X is merely the nicest host for
  it once its arc begins.
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
