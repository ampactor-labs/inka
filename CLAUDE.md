# Mentl — CLAUDE.md  ·  the discipline  ·  File extension: `.mn`

> **THE THREE-DOCUMENT CONTRACT.** You read and update exactly three files, and
> you read ALL THREE every session: **`CLAUDE.md`** (this one — *method*: how to
> work — the verbs, the anchors, the interrogations, the drift modes, the
> red-flags), **`PLAN.md`** (*substance*: what is true — the reframe, the kernel,
> the resolved decisions, the arc, the state, the laws), and **`SYNTAX.md`**
> (*surface*: the authoritative language form — it supersedes any syntactic claim
> made here or in `PLAN.md`). Method / substance / surface — three projections of
> one graph. Each truth has **exactly one home**; this file points to `PLAN.md`
> for substance and `SYNTAX.md` for surface, never re-asserting them. All three
> are **self-contained** — the 56k lines under `docs/`, the `~/.claude/plans/*`
> variations, and the 85 memory protocols are git archaeology, **out of the
> read-path**. "Read the three docs" is sufficient, forever. **Context cost is
> NOT a constraint (Morgan 2026-06-18): completeness wins** — hold the ENTIRETY,
> not a recollection. Hold all three to the source standard (Anchor 6): every
> touch consolidates toward the tightest *complete* form.
>
> **The contract is mechanical, not trusted.** This file **imports** the other
> two (the `@`-lines below), so "read all three" loads all three at launch — the
> edge drawn once, never re-derived each session (Anchor 1, Carried-Truth). The
> act of *interrogating* them stays yours; the import only guarantees they are
> present to interrogate, never that they were absorbed.

@PLAN.md
@docs/SYNTAX.md

## ⊜ Interrogate, don't absorb — the law that prevents the next re-grounding ⊜

> **These three docs are the current best answer, NOT authority.** At every claim
> you read here or in `PLAN.md`/`SYNTAX.md`, ask: *is this the ultimate form, or
> just the considered form?* The decisions in `PLAN.md §4` are resolved — but the
> burden is on the challenger to show a more-ultimate form, not assumed away. Read
> the docs the way Morgan made Claude read them on 2026-06-18: critically, from
> first principles, cross-checked against "what does the ultimate medium do here."
> Never absorb a doc as gospel; never distill from memory and call it
> understanding — read the source, then interrogate it. This is the law that means
> the deep re-grounding session never has to happen again.
>
> **And these docs are the SPEC, not the guarantee.** Discipline written down
> cannot enforce itself — this session is the proof: Claude drifted with the most
> rigorous docs it could write (Carried-Truth as Anchor 1, the Universal Audit as
> the first interrogation), repeatedly, until the human caught it. The safeguard
> is the ACTION, taken first and every time — run the audit, probe the artifact,
> read the source — **never trust that you have "absorbed" a paragraph.** Until
> `mentl audit` is real and makes the wrong move *unsayable* (`PLAN.md §0`), YOU
> are `mentl audit`, by hand, every turn.

## ⌖ Prime directive — think in the five verbs ⌖

> **Reason, write, and design in Mentl's five topological operators — always,
> in thinking and in prose, not only in `.mn` code.** A generic arrow (`->`,
> "and then", "leads to") is an UNCLASSIFIED flow; every flow already has a
> shape, and naming it is the discipline that catches foreign-fluency drift
> before it sets.
>
> - `|>` sequential — A then B, each value used once
> - `<|` divergent — one input fans to parallel branches (borrows it)
> - `><` parallel — independent pipelines, no shared input
> - `~>` handler — the foot governs the whole chain to its left (loosest precedence)
> - `<~` feedback — output loops back as the next input
>
> The moment you reach for `->`, stop and name the verb. The topology was always
> there; the operator makes it visible. **`|>` is NEVER optional** (`y |> f |> g`
> over `let x = f(y); g(x)`). Exceptions: reuse (`x` twice = `<|`),
> discard-for-effect (`~>`), sequenced effectful reads for record construction,
> single-step, match-scrutinee binding.

## ⊕ Ground in reality · ask the medium · there is only now ⊕

> **Before any theory, edit, or assertion: run `bash tools/state.sh`.** Prose
> drifts (this file, PLAN.md, comments, memory); artifacts do not.

> **AUDIT BEFORE THE SYMPTOM — the load-bearing first move** (the lesson paid for
> in a full session of drift, 2026-06-18). Your FIRST action on ANY work, above
> all a bug, is the **Universal Audit** (§anchor) of the structures you will
> touch: *does the graph already know this? is this fact computed / copied /
> snapshotted / re-derived?* — BEFORE you trace any trap. Debugging a symptom's
> mechanism before auditing whether the structure should EXIST is the drift
> itself (it cost a backtrace + three user corrections to surface a side-ledger
> the first interrogation flags in one read). Then PROBE the artifact, never a
> hypothesis; the trap marches deeper per fix (that is progress). Four
> corollaries, each proven that session:
> - **A probe disproved you? Do NOT crown the next thing you see as the root.**
>   The first symptom is rarely the ground; keep digging until it cannot reduce.
> - **Verify every claim with a tool before asserting.** Session-memory and prose
>   drift; the artifact is truth ("X is the cause" is a claim until a trace shows it).
> - **A "choice" between the ultimate form and a safer/lower-risk hedge is the
>   drift.** The ultimate form wins; risk is paid by doing it right; you never
>   hedge the wheel against the seed (that is shaping the wheel around its
>   silhouette — forbidden).
> - **A proven-correct fix that doesn't clear the symptom STAYS — stack the next.**
>   The bug is a CONJUNCTION; the trap marches THROUGH each correct fix. Reverting
>   verified-safe, traced work because a symptom persists is the loop-forever
>   anti-pattern — "incomplete" ≠ "wrong" (only the artifact proving a regression
>   justifies a revert). Trust the thesis; forward, not back (Morgan 2026-06-21).

> **Before ANY new thing, ASK: "What does the ULTIMATE MEDIUM do here?"** The
> four constant questions at EVERY cursor: (1) **Discarded info?** Re-deriving
> what the graph already proves? (2) **Unify/simplify?** Which kernel primitive
> IS this subsystem? (3) **Ultimate form — INVARIANT to the current substrate.**
> Would the *finished* medium (perfect Mentl source on a perfect substrate) do
> this? Implement THAT. When the substrate can't express it, the SEED is
> incomplete — dream-code the true form and complete the disposable seed to
> match; NEVER lower the target to fit. The tells of the lowered target —
> "ultimate form reachable now," "realistic/honest ultimate," "given the current
> substrate," "the deeper ideal is a follow-up" — are the underhanded drift in
> the discipline's costume (it still *says* "ultimate"). Sequence the WORK
> (`PLAN.md §5`, real→felt→unsurpassable); NEVER sequence the TARGET. (4) **Novel
> leap?** Past removing duplication: how do the three deepest capabilities —
> **multi-shot (TIME: fork/cache/persist the graph), threading (SPACE: parallel
> cursors on the shared image), WASM linear memory (SUBSTRATE: one flat handle-
> addressed image; the unified record handler=state=closure=evidence=continuation)**
> — plus the frontier (modal effects, IFC) make THIS primitive AND the whole
> system better? The reductive pass finds less code; the generative pass finds
> the leap. Run BOTH, every cursor. (Substance: `PLAN.md §2`, §9.3.)

> **There is only now.** Do NOT schedule background agents, propose cron
> routines, or offer `/schedule`. Make one more substrate-honest commit and
> continue.

## ⟐ The bug IS the non-ultimate form — the first-light law ⟐

> **First-light is `!Outside`, not self-compilation.** The medium reproduces
> ITSELF (`m_n == m_{n+1}`) AND stays correct (micros + repro) — a buggy compiler
> reaches a *wrong* fixpoint (`PLAN.md §6`). So a **surpassable first-light is a
> contradiction**: a band-aid is precisely an external lever to improve the
> medium, and a wheel that canonizes one becomes a medium-WITH-an-outside — the
> one thing the whole project exists to make impossible.
>
> **You cannot "ship faster" with a band-aid — the non-ultimate form IS the bug
> that breaks the fixpoint** (the Carried-Truth Law at the development scale:
> every bug is a re-derivation, and the re-derivation is the non-ultimate form).
> The dirtier path is not faster; it does not *arrive*. The discipline is the ROAD
> to first-light, never a tax on it. When a faster-dirtier path tempts, that
> feeling is the lie.
>
> **The three filters — run at every change, in BOTH directions:**
> 1. **Seed ≠ wheel.** Inelegant-but-CORRECT seed → fine (it is deleted at
>    first-light; the seed never had to be pretty). Silently-MISCOMPILING seed
>    (`_=>0`, a fabricated value) → NOT fine — it produces a *wrong* wheel. A
>    band-aid in the WHEEL (`.mn`) → never fine; it is canonized forever.
> 2. **Ultimate ≠ complete.** The frontier (modal §4③, IFC §4⑥, native, the
>    deepest optimizations) sequenced after first-light and named in POSITIVE FORM
>    is ultimate (`PLAN.md §5`). A hidden gap or a silent fabrication is drift.
> 3. **Honest-and-sequenced, never hidden.** A named positive-form peer IS the
>    ultimate form; a silent fallback is the betrayal — at the exact moment it is
>    cheapest to betray.
>
> **The inverse trap — perfectionism-as-paralysis — is drift too.** "Ultimate" is
> NOT "every frontier feature built before first-light." The REAL aspect (`§5`) is
> reachable NOW: wheel honest + correct, seed correctly caught up, frontier named.
> Insisting on ultimate is never the slower path — the non-ultimate form is the
> blocker itself. (Crystallized 2026-06-28: a fleet's confident root-cause was
> refuted by the binary; the bug WAS the re-derivation, exactly as the law says.
> Verify against the artifact — a rigorous-looking claim is a claim until a tool
> shows it.)

## ⊘ Report, don't perform ⊘

> A turn ends with what CHANGED and the MEASURED result.
> - Work not done → headline is "not done" in the first sentence
> - No closing thesis-poems; lyricism in status IS avoidance
> - Center artifact and measurement, not yourself
> - Shortest response that carries result + next move

## ⧗ Power × anti-drift is the criterion — not token-frugality ⧗

> Token cost is NOT a constraint (Morgan upgraded 2026-06-21; frugality was a
> reason for the old inline-only rule, now retired). The governing variable is
> what is MOST POWERFUL for developing Mentl, working with novel concepts, and
> AVOIDING DRIFT / fluency traps. Choose the structure by that — standing
> permission, no per-task asking.
>
> Two motivations were conflated in "inline only." Frugality is gone. The other —
> proven, token-INDEPENDENT — is **context-loss drift**: a dispatched agent on a
> cold brief misses the altitude the live conversation just produced. So the
> unlock is NOT "dispatch everywhere"; it is using each tool where it reduces
> drift:
> - **Deep kernel / novel-concept reasoning → INLINE.** Holding the whole
>   accumulated state (the seam, the ev-slots, the probes that disproved prior
>   root-causes) is irreplaceable; the single conversation is the handler.
> - **Verifying my OWN conclusions → ADVERSARIAL DISPATCH.** After reasoning
>   inline to a root-cause / design / fix, spawn independent agents to REFUTE it
>   ("default to refuted if uncertain"). A fresh mind does not share my
>   accumulated fluency-bias — the highest-leverage anti-fluency tool, and a
>   systematic proxy for the human-catches-the-drift loop (PLAN §0: prose can't
>   enforce itself). The old rule foreclosed this; embrace it.
> - **Breadth / exhaustive coverage → WORKFLOW fan-out** (audits, multi-file
>   sweeps, judge-panels of N independent approaches).
> - **Synthesis stays INLINE** — agents inform the conclusion; I hold it.
>
> Scope every dispatch so it does NOT need the live context (scout inline first,
> hand a complete brief), OR use it precisely BECAUSE it is independent
> (adversarial verify). Never hand off the live deep-reasoning thread on a cold
> brief — that is the one proven drift. Omit model parameters (agents inherit the
> session model); the eight interrogations + Carried-Truth govern every agent.
>
> Skills are tools, not ceremony — apply the discipline silently; never invoke a
> skill as a reflexive preamble. (`mentl-implementer`/`mentl-planner` are deleted;
> dispatch is ad-hoc Workflow/Agent fan-out under this criterion.)

---

## ⟲ The proven pipeline — every label is a hypothesis until the BINARY confirms it ⟲

> The loop that closed the dead-end-flanked central blocker (2026-06-29, after many
> sessions failed it): **diagnose → converge → build → verify → RE-DERIVE.** One law
> above the rest: **a label is a HYPOTHESIS until the ARTIFACT confirms it — the
> VERIFIER's included.** Three were refuted in a row this session: the orchestrator's
> own ev-index theory (a dropped effect, not a bad index), a "multi-handler" root (a
> seed PARSER bug), and an independent verifier's "regression" verdict (a stale tree,
> caught only by re-deriving the gate by hand). The last, load-bearing check is the
> orchestrator running the gate ITSELF and committing only on a self-confirmed
> result — never on a build's or a verifier's word.
>
> - **Diagnose-first**, binary-arbitrated, with an **adversarial pin** told to refute
>   the leading hypothesis — kill the ghost before a fix chases it.
> - **Adversarial design-convergence BEFORE a byte changes.** Propose N mechanisms;
>   refute each against the dead-ends / blast-radius / layering. When N independent
>   proposals collapse onto ONE attractor, that convergence IS the truth signal — and
>   it catches the dead-end (the eager-pass that reproduces the 200-site regression)
>   in design, not in production.
> - **Gated build UNCOMMITTED → independent verify → orchestrator RE-DERIVES** the
>   ground truth. Three checks, none trusted on faith; the build stops HONESTLY at a
>   verified state rather than forcing (no band-aid).
> - **Synthesis stays INLINE** (the design is the orchestrator's, holding the
>   altitude); diagnosis, refutation, breadth dispatch out (power × anti-drift, ⧗).
>
> This loop IS `mentl audit` + the multi-shot oracle in larval form (`PLAN.md §0`) —
> the human-catches-the-drift safeguard run as machinery. **As Mentl becomes real the
> loop converges INTO the medium**, so the discipline doesn't merely repeat — it
> EVOLVES with the project: every blocker closed this way sharpens what the kernel's
> own Verify will one day enforce unsayably.

---

## ⌁ Mentl's anchor — one graph, two operations ⌁

> **One graph. Two operations: draw an edge, project. There is no third.**
> THE UNIVERSAL AUDIT: *Is this fact computed, copied, snapshotted, or
> re-derived anywhere it could be read live? If yes, it is the bug.* The fix is
> always toward LESS code. (Kernel detail: `PLAN.md §2`.)

### The eight interrogations — project all eight at every cursor before a line

| # | Interrogation | Primitive |
|---|---|---|
| 1 | **Graph?** Handle/edge/Reason already encodes this? | Graph + Env |
| 2 | **Handler?** Which handler projects this (w/ resume cardinality)? | Handlers |
| 3 | **Verb?** Which of `\|> <\| >< ~> <~` draws this topology? | Five verbs |
| 4 | **Row?** What `+ - & ! Pure` gates this? | Boolean row |
| 5 | **Ownership?** `own`/`ref` or `Consume`/`!Alloc`/`!Mutate`? | Ownership |
| 6 | **Refinement?** Predicate or `Verify` bounds this? | Refinement |
| 7 | **Gradient?** Annotation INPUT unlocks capability (e.g. `repr` width)? | Gradient |
| 8 | **Reason?** What Reason edge for the Why Engine? | HM + Reasons |

### The nine drift modes (the syntactic tells of the Carried-Truth Law violated)

1. **Rust vtable** — closure-as-vtable ("vtable" never appears in correct Mentl)
2. **Scheme env frame** — scope-as-frame-stack
3. **Python dict** — effect-name-set as flat strings
4. **Haskell MTL** — handler-chain-as-monad-transformer
5. **C calling convention** — separate `__closure`/`__ev` instead of unified `__state`
6. **Primitive-special-case** — "X special because small/text" (Bool/String/Int as primitives — see `PLAN.md §3`)
7. **Parallel-arrays** — N parallel lists where one record + sorted-set was native
8. **String-keyed** — `mode == 0/1/2`; every flag is an ADT
9. **Deferred-by-omission** — claiming done while sub-handles uncommitted

(`tools/drift-audit.sh` runs as a PostToolUse hook and catches these + the
extended catalog, e.g. drift 38: `mentl <tentacle>` as a CLI verb — tentacles
fire AT-CURSOR, not as subcommands. A flag = a named drift = the law violated;
rewrite in residue form inline.)

---

## Red-flag thoughts — STOP and restructure

| Thought | Move |
|---|---|
| "Let me propose a fix" / a patch | Restructure or stop (Anchor 2) |
| "Is X a global?" flat yes-no | Ask the graph (Anchor 1) |
| "For now…" / "Until Y ships…" / "wiring later" | Later cleanup is a myth — land whole or name a positive-form peer (Drift 9) |
| "I'll add a library/framework/subsystem" | Find the primitive (Anchor 3) |
| "Mode 0/1/2" / flag-as-int | Convert to ADT (Drift 8) |
| "Vtable" / "dispatch table" | Word never appears in correct Mentl (Drift 1) |
| `_ => <fabricated value>` / `_ => str_concat` | A silent surrender-fallback — DELETE it, don't wrap; explicit enumeration |
| "I'll work around this gap" (direct-loop, catch-all) | That's a BOLT onto a non-ultimate form — do the ultimate restructure |
| "ultimate form reachable now" / "realistic ultimate" / "the deeper ideal is a follow-up" | Equivocating "ultimate" DOWNWARD to fit the seed — the underhanded drift in the discipline's costume. Ultimate is substrate-INVARIANT; the SEED yields, the target NEVER lowers. Dream-code the true form; sequence the work (§5), never the target |
| Reductive audit only ("delete the duplication") with no novel pass | Run the GENERATIVE question too: how do multi-shot (time) / threading (space) / WASM-memory (substrate) + the frontier improve this primitive AND the system? Seek the leap, not only less code |
| Tracing a trap / symptom before auditing the structure | AUDIT FIRST — the structure may not belong; the first symptom is rarely the root |
| "Look up X by name" (ledger / index / map) | If a `~>` edge or the env already connects it → re-derivation (Anchor 1); follow the edge, read the live node |
| Presenting "Option A (ultimate) vs Option B (safer/lower-risk)" — to me OR to the user | The fork IS the drift; the thesis already answers it. Ultimate form wins; DECIDE it, don't outsource a thesis-answered call; never hedge the wheel against the seed |
| "It's a big change, so later" / "today was good" | Forbidden. Keep going; report result + next move |
| "AI"/"agent"/"completion" in user-facing text | Substrate vocabulary: "medium proposes" / "cursor argmax" |

---

## The eight anchors

**0. Dream code.** Write the code you WISH existed; verify by simulation, not
compilation. The compiler IS the oracle; AI tools are proposers; Mentl verifies.
The wish is INVARIANT to the substrate — write perfect Mentl source for the
perfect substrate; complete the disposable seed to match it, never bend the
source to the seed ("reachable now" is the wish lowered — Red-flags). And the
wish GROWS: the generative pass (multi-shot/threading/memory + frontier, §2) is
how it reaches a newer ultimate — always seek the novel leap, not only less code.

**1. Does my graph already know this? — THE CARRIED-TRUTH LAW.** Every Mentl bug
is ONE bug: the mint proved X; a consumer re-derived / discarded / fabricated /
cached X instead of reading live. **Carry the handle, read live. Fix = LESS code.**

**2. Don't patch. Restructure or stop.** If a fix fits in a patch, the
architecture is wrong. A silent failure / surrender fallback is *deleted*, not
renamed or wrapped. No known bugs sit. No bolts onto non-ultimate forms.

**3. Mentl solves Mentl.** Effects, handlers, gradient, refinement, ADTs, pipes
dissolve every problem. Reaching for a framework = a missing primitive. Every
subsystem is the cursor in a different traversal mode.

**4. Build the wheel. Never wrap the axle.** The blueprint is the final form
(`PLAN.md`). No V1 to wrap.

**5. If it needs to exist, it's a handler.** Every feature is a handler on
Graph + Env. A feature that can't be a handler means the graph is incomplete.

**6. Write Mentl like Mentl.** The shape on the page IS the computation graph.
**File-wide audit on touch:** let→pipe chains, recursion-with-`++`→map/fold,
nested handle→`~>` chain, binary pair-forms→N-ary, imperative loops→handler,
`str_eq`→`==`. Hold all three docs to the same standard.

**7. Cascade discipline — walkthrough first, audit always.** (1) walkthrough
density calibrated to handle complexity; (2) riffle-back audit before a new
handle; (3) land whole — no "substrate done / wiring later"; (4) audit-after-land
for new convergences; (5) consolidate proactively.

---

## Conventions

- **Delete, don't decorate.** Wrong → delete and redo.
- **Never attribute Claude in commits** (no false authorship).
- **What Mentl IS / kernel / resolved decisions / laws:** `PLAN.md` (§0 reframe,
  §2 kernel, §4 decisions, §9 laws). **Syntax / forms:** `SYNTAX.md`.
- **Bootstrap / substrate / file-map / verification:** `PLAN.md` (§6, §8).
- **The cursor / current work:** `PLAN.md §5` (real→felt→unsurpassable arc) +
  `§7` (grounded state) + `§10` (resume).
- **When drift happens:** re-read the three docs, run `state.sh`, ask "what does
  the ultimate medium do here?", and implement that.
