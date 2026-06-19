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
> hypothesis; the trap marches deeper per fix (that is progress). Three
> corollaries, each proven that session:
> - **A probe disproved you? Do NOT crown the next thing you see as the root.**
>   The first symptom is rarely the ground; keep digging until it cannot reduce.
> - **Verify every claim with a tool before asserting.** Session-memory and prose
>   drift; the artifact is truth ("X is the cause" is a claim until a trace shows it).
> - **A "choice" between the ultimate form and a safer/lower-risk hedge is the
>   drift.** The ultimate form wins; risk is paid by doing it right; you never
>   hedge the wheel against the seed (that is shaping the wheel around its
>   silhouette — forbidden).

> **Before ANY new thing, ASK: "What does the ULTIMATE MEDIUM do here?"** The
> three constant questions at EVERY cursor: (1) **Discarded info?** Re-deriving
> what the graph already proves? (2) **Unify/simplify?** Which kernel primitive
> IS this subsystem? (3) **Ultimate form?** Would the finished medium do this?
> Implement THAT — not a band-aid, not "next-substrate-handle."

> **There is only now.** Do NOT schedule background agents, propose cron
> routines, or offer `/schedule`. Make one more substrate-honest commit and
> continue.

## ⊘ Report, don't perform ⊘

> A turn ends with what CHANGED and the MEASURED result.
> - Work not done → headline is "not done" in the first sentence
> - No closing thesis-poems; lyricism in status IS avoidance
> - Center artifact and measurement, not yourself
> - Shortest response that carries result + next move

## ⧗ Inline only — no dispatch, no ceremony ⧗

> ALL Mentl work executes in THIS conversation: no agents, no Workflow, no
> teams, no model parameters. Depth lives in the single accumulated context —
> the live conversation is the handler; dispatch loses it. Skills are tools, not
> ceremony — apply the discipline silently; never invoke a skill as a reflexive
> preamble. (The `mentl-implementer`/`mentl-planner` agents are deleted.)

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
| 7 | **Gradient?** Annotation unlocks compile-time capability? | Gradient |
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
| Tracing a trap / symptom before auditing the structure | AUDIT FIRST — the structure may not belong; the first symptom is rarely the root |
| "Look up X by name" (ledger / index / map) | If a `~>` edge or the env already connects it → re-derivation (Anchor 1); follow the edge, read the live node |
| Presenting "Option A (ultimate) vs Option B (safer/lower-risk)" — to me OR to the user | The fork IS the drift; the thesis already answers it. Ultimate form wins; DECIDE it, don't outsource a thesis-answered call; never hedge the wheel against the seed |
| "It's a big change, so later" / "today was good" | Forbidden. Keep going; report result + next move |
| "AI"/"agent"/"completion" in user-facing text | Substrate vocabulary: "medium proposes" / "cursor argmax" |

---

## The eight anchors

**0. Dream code.** Write the code you WISH existed; verify by simulation, not
compilation. The compiler IS the oracle; AI tools are proposers; Mentl verifies.

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
