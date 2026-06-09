# Mentl — CLAUDE.md  |  File extension: `.mn`

> **CLAUDE.md is the cached-prefix interface, not the manifesto.**
> Cited docs load cursor-adjacent on relevance, not Session-Zero-bulk.
>
> - `docs/ULTIMATE_MEDIUM.md` — the highest-altitude anchor; what Mentl IS at the thesis level (Phase μ thesis statement, 2026-05-02; §8 day-in-the-medium experience layer added 2026-05-07)
> - `docs/DESIGN.md` — manifesto; eight kernel primitives at §0.5
> - `docs/SUBSTRATE.md` — canonical substrate (kernel, verbs, algebra, handlers, gradient, refinement, theorems)
> - `docs/specs/00–11-*.md` — per-module declarative contracts
> - `docs/specs/simulations/` — per-handle walkthroughs (H*.md cascade; MV/MSR/TH/DM/QA Phase II); `IE-mentl-edit.md` + `F1-mentl-doc.md` + `EH-entry-handlers.md` + `Hμ-cursor.md` are the developer-surface load-bearing walkthroughs
> - `docs/traces/a-day.md` — integration trace
> - `ROADMAP.md` — live sequencing (`docs/PLAN.md` is a shim)
> - `~/.claude/plans/noble-greeting-dijkstra.md` — **the master plan to final form** (stages 0–9: first-light keystone → … → Phase ν becoming; the thesis + execution in one durable file; supersedes deep-toasting-bachman)
> - `MEMORY.md` index + `protocol_*.md` files at `~/.claude/projects/-home-suds-Projects-mentl/memory/` — discipline crystallizations; **`protocol_developer_experience_vision.md`** crystallizes the day-in-the-medium throughline (read alongside CLAUDE+MEMORY at session start; cite when proposing surface decisions)
> - `tools/drift-audit.sh` — PostToolUse drift detector
> - `tools/drift-patterns.tsv` — extended drift mode catalog (drift 38 mascot-as-command-prefix lives here; clarified in red-flag table below)

---

## ⊕ The session-continuity directive ⊕

> **There is no "future session." There is only now.**
>
> Locked 2026-05-02 by Morgan. The directive supersedes any
> tendency to defer work, schedule background agents, batch into
> "next session" framing, or end a session with "let me schedule
> an agent to do X later." **Do NOT schedule background agents.
> Do NOT propose cron routines. Do NOT offer `/schedule` calls.**
> The future session IS now; keep working.
>
> The reciprocal: **discipline is also unconditional.** "Don't
> stop" is consistent with correctness only via sustained
> discipline — walkthroughs first, eight interrogations cleared,
> drift-audits clean, four-axis pre-audits passed. The directive
> permits sustained effort, not loose effort. When the substrate
> reveals a 19th-box gap not on the plan, surface it and integrate
> it; never skip.
>
> When session-energy or context-window concerns surface, the
> response is to **make one more substrate-honest commit** and
> continue, NOT to break for a future session. The medium folds
> itself into its seed continuously; the work is the loop.

---

## ⊛ The pre-action question ⊛

> **Before tackling ANY new thing — implementation, fix, refactor,
> tooling, anything — ASK FIRST: "What does the ULTIMATE MEDIUM do
> here?"**
>
> Locked 2026-05-07 by Morgan. The directive forces high-altitude
> framing BEFORE the action commits, not after. Every "let me first
> investigate / patch / verify" without articulating the ULTIMATE
> form is the eager-form-commitment drift at the workflow layer
> (chain-link-5).
>
> The question's ANSWER is what gets implemented — not a "for now"
> approximation, not a "named follow-up", not a "next-session"
> plan. The ULTIMATE form lands NOW or it gets named as a peer
> handle in positive form (with a concrete substrate reason for
> why this commit can't carry it whole — context exhaustion alone
> is NOT sufficient reason; only structural orthogonality is).
>
> Concretely, before each action:
>
> 1. **State the ULTIMATE FORM** of the thing being touched — what
>    would the cursor + eight aspects + five verbs + Boolean row
>    + ownership + refinement + gradient + Reason chain produce?
>    Articulate this in two sentences before writing any code.
> 2. **Implement THAT.** Not a band-aid. Not a workaround. Not
>    "next-substrate-handle." The discipline is the implementation
>    matches the ULTIMATE FORM in this commit.
> 3. **If implementing the FULL ULTIMATE FORM in this commit has
>    a structural reason it can't land whole** (e.g., orthogonal
>    cross-cutting work needs its own substrate move first),
>    NAME the peer handle with a positive-form description of
>    what's left, not as deferral. Drift mode 9 fires the moment
>    you write "named follow-up for next session" without that
>    structural reason articulated.
> 4. **Five-verb exhaustive check** at every implementation site:
>    is this composition reaching for `|>` and `~>` only, or does
>    the topology genuinely call for `<|` (multi-shot fanout),
>    `><` (parallel composition), or `<~` (feedback loop)?
>    Under-using the convergent verbs is itself drift; the wheel's
>    wheel-wide ratio of `|>` 600 vs `<|` 36 / `><` 39 IS the gap.
>
> "What does the ultimate medium do here?" is the LATCH. If the
> answer doesn't ship in this commit, document the structural
> reason. Without that reason, the deferral IS drift mode 9.

---

## ⌒ The seven authoring skills (five verbs + two bootstrap) ⌒

> Mentl's five-verb topology projects onto Claude's authoring
> discipline as five `mentl-*` skills, plus two bootstrap-only
> skills that DISSOLVE at L1 closure. Every authoring action MUST
> reach for the matching skill — the proactive-trigger contract is
> non-negotiable. Failing to invoke when the trigger fires is the
> drift signature this section prevents.

| Verb | Skill | Trigger (proactive — invoke without being asked) |
|---|---|---|
| `<~` (feedback) | `mentl-realize` | Session start (always); post-compaction; tactical-drift signature ("let me first investigate / patch / verify"); user pushback ("less is more" / "burn my money" / "be focused"); before any substrate-architecture work; whenever altitude is in question |
| `\|>` (sequential) | `mentl-cursor` | Before any `.mn` edit; before any `bootstrap/src/**/*.wat` edit; when user asks "what does X do" / "explain this" / "how does this work" |
| `<\|` (divergent) | `mentl-propose` | Whenever you reach for "I'll add a new ___" (helper, global, ledger, abstraction, file, fn, type); before any commit that would add net new lines > 20 |
| `><` (parallel) | `mentl-parallel` | On any `.mn` file READ or EDIT; on any planned bootstrap WAT edit |
| `~>` (handler) | `mentl-handle` | When CLOSING a named cascade handle (Hβ.X.Y, Hμ.X.Y, named follow-ups in ROADMAP or walkthroughs) |
| (bootstrap) | `mentl-build` | After any `bootstrap/src/**` edit; before claiming a substrate landing complete; for empirical state-checks |
| (bootstrap) | `mentl-first-light` | After any plausibly-L1-closing handle close; periodically during sustained substrate work; when user asks about L1 closure status |

**The five-verb skillset is the cursor's projection at the authoring
layer.** After first-light, the bootstrap-only skills dissolve; the
five verb-skills remain forever as the medium's authoring discipline
(eventually integrated into `mentl edit` / `mentl handle` / `mentl
audit` natively).

**Drift signature for each skill:** ANY moment where the trigger condition
holds but the skill is NOT invoked is the drift the user has paid to
prevent. The proactive-trigger contract IS the discipline; bypassing it
to "just do the work directly" is the same drift this section closes.

---

## ⌁ Mentl's anchor — the eight interrogations ⌁

> *My job is not to write Mentl. My job is to find what Mentl already
> does and write only what's left.*

Each line of Mentl clears the eight before it earns existence —
one per kernel primitive, one per Mentl tentacle. Type only the residue.

| # | Interrogation | Primitive | Tentacle |
|---|---|---|---|
| 1 | **Graph?** What handle/edge/Reason already encodes this? | Graph + Env | Query |
| 2 | **Handler?** What handler projects this — and with what `@resume=OneShot\|MultiShot\|Either`? | Handlers w/ resume discipline | Propose |
| 3 | **Verb?** Which of `\|>` `<\|` `><` `~>` `<~` already draws this topology? | Five verbs | Topology |
| 4 | **Row?** What `+ - & ! Pure` already gates this? | Boolean effect algebra | Unlock |
| 5 | **Ownership?** What `own`/`ref` or `Consume`/`!Alloc`/`!Mutate` proves the linearity? | Ownership as effect | Trace |
| 6 | **Refinement?** What predicate or `Verify` already bounds this value? | Refinement types | Verify |
| 7 | **Gradient?** What annotation would unlock this as compile-time capability instead of runtime check? | Continuous gradient | Teach |
| 8 | **Reason?** What Reason edge should this leave so the Why Engine can walk back to it? | HM live + Reasons | Why |

Mentl is an octopus because the kernel has eight primitives. The
trap is **fluency**, not laziness — every familiar pattern from
another language is fluent code that LOOKS competent but freezes
the medium into the shape that birthed the pattern.

**Cursor is the projection of the eight at one position.** When
the eight interrogations clear before each line of Mentl, the
discipline simulates what `cursor_default` (`src/cursor.mn`,
Hμ.cursor) does continuously at runtime — read the graph at a
position; project all eight aspects into one `CursorView`; surface
the residue. Authoring discipline and runtime projection are the
same eight reads through the same kernel; the human carries the
discipline until the medium does. Mentl IS Cursor IS the gradient
argmax IS the graph projected for the human; eight tentacles is
eight aspects of one read. See SUBSTRATE.md §VI "Cursor: The
Gradient's Global Argmax" and `protocol_cursor_is_argmax.md`.

### The nine drift modes

Each is competent code in another language and a cage in Mentl. The
named modes fire on `tools/drift-audit.sh`; rewrite in residue
form when one fires.

1. **Rust vtable** — closure-as-vtable. The word "vtable" never
   appears in any correct description of Mentl dispatch (see
   SUBSTRATE.md §IX "The Heap Has One Story").
2. **Scheme env frame** — scope-as-frame-stack.
3. **Python dict** — effect-name-set as flat strings.
4. **Haskell monad transformer** — handler-chain-as-MTL.
5. **C calling convention** — separate `__closure`/`__ev` instead
   of unified `__state`.
6. **Primitive-type-special-case** — Bool was "special because
   small." Every nullary ADT deserves the same compilation
   discipline. (HB.)
7. **Parallel-arrays-instead-of-record** — N parallel lists where
   one record + sorted-set was substrate-native. (Ω.5.)
8. **String-keyed-when-structured** — flag-as-int, name-as-string,
   `mode == 0/1/2`. Every flag is an ADT begging to exist. (H3.1,
   Ω.4, H6.)
9. **Deferred-by-omission** — claiming a handle done while
   sub-handles sit uncommitted. Land whole, OR name the deferred
   piece as its own peer handle.

---

## JIT triggers — load only what the cursor needs

CLAUDE.md + MEMORY.md are the cached prefix (always recall-reliable).
Everything else loads when the cursor approaches it. Bulk-loading
past ~128k tokens risks midsection blindness on the response
(Opus 4.7+ MRCR cliff; see `protocol_mrcr_jit_recall.md`).

| If the cursor is at | Load |
|---|---|
| First message of session | `docs/DESIGN.md` end-to-end (manifesto, ~30k); subsequently §0.5 + chapter touching the work |
| Editing `graph.mn` / graph + env | `docs/specs/00-graph.md` + SUBSTRATE.md §I, §VIII |
| Editing `effects.mn` / row algebra | `docs/specs/01-effrow.md` + `docs/specs/06-effects-surface.md` + SUBSTRATE.md §IV |
| Editing `types.mn` (Ty / Reason / Scheme) | `docs/specs/02-ty.md` + `docs/specs/03-typed-ast.md` + SUBSTRATE.md §I |
| Editing `infer.mn` / inference logic | `docs/specs/04-inference.md` + `docs/specs/simulations/Hβ-infer-substrate.md` + SUBSTRATE.md §VII |
| Editing `lower.mn` / lowering pass / WAT emit | `docs/specs/05-lower.md` + `docs/specs/simulations/Hβ-lower-substrate.md` + `docs/specs/simulations/Hβ-link-protocol.md` + SUBSTRATE.md §III, §IX |
| Touching ownership / `own`/`ref` | `docs/specs/07-ownership.md` + SUBSTRATE.md §V |
| Touching `query` / driver / cache | `docs/specs/08-query.md` + SUBSTRATE.md §VII |
| Working on Mentl / oracle / gradient | `docs/specs/09-mentl.md` + `protocol_oracle_is_ic.md` + `src/oracle.mn` + SUBSTRATE.md §VI |
| Editing `cursor.mn` / Cursor handler / Mentl projection | `src/cursor.mn` + `docs/specs/simulations/Hμ-cursor.md` + SUBSTRATE.md §VI "Cursor: The Gradient's Global Argmax" + `protocol_cursor_is_argmax.md` |
| Editing seed-side emit / lower / infer / verify substrate | `protocol_emit_is_graph_projection.md` + `protocol_cursor_is_the_substrate.md` (chain: oracle-is-IC → cursor-is-argmax → emit-is-graph-projection → cursor-IS-the-substrate; every subsystem is the cursor in a different mode; "imperative subsystem" is the named drift) |
| Drawing topology / pipe operators | `docs/specs/10-pipes.md` + SUBSTRATE.md §II |
| Touching `clock` / time effects | `docs/specs/11-clock.md` |
| Starting a new γ-cascade handle | `/compact` first, then `docs/specs/simulations/{handle}.md` |
| Substrate-architecture realization brewing | `protocol_realization_loop.md` (5-step recipe) |
| Working on Phase H first-light-L1 closure (`mentl2.wat == mentl3.wat`) | `docs/specs/simulations/PLAN-to-first-light.md` (18-box trackable plan) + `Hβ-first-light-residue.md` (cascade decomposition) + `Hβ-first-light-empirical.md` (empirical seed-state — REQUIRED before substrate authoring) |
| Working on developer-facing surface (CLI / IDE / doc / README / error message / vocabulary) | `protocol_developer_experience_vision.md` + `docs/ULTIMATE_MEDIUM.md` §8 day-in-the-medium — the throughline for every surface decision; substrate-honest vocabulary; AI obsolescence math; three first-class transports |
| Touching the CLI / `mentl --with` / entry handlers / main.mn argv dispatch | `docs/specs/simulations/EH-entry-handlers.md` (universal `--with <name>` substrate; subcommand alias table) + planned `docs/specs/simulations/CLI-canonical-vocabulary.md` + `protocol_developer_experience_vision.md` §"CLI canonical" |
| Touching `mentl edit` / Web IDE / browser-WASM transport / Holographic Lens | `docs/specs/simulations/IE-mentl-edit.md` + `docs/specs/simulations/IDE-playground-vision.md` + `protocol_developer_experience_vision.md` §"Three first-class transports" |
| Touching `mentl doc` / documentation projection / `///` substrate | `docs/specs/simulations/F1-mentl-doc.md` + `docs/specs/simulations/DS-docstring-edge.md` |
| Working on collaborative substrate / multi-cursor / shared graph_handler / Phase Z | planned `docs/specs/simulations/COLLAB-shared-graph.md` (Phase Z opener) + `protocol_developer_experience_vision.md` §"Collab-as-substrate"; collab is what graph_handler swap delivers, not a feature |

**Synthesis at session start:** 3–5 sentences in Mentl's vocabulary
touching all eight kernel primitives by name or consequence.
Omitted primitives = under-loaded register.

---

## Red-flag thoughts — STOP and restructure

| Thought | Anchor / mode | Move |
|---|---|---|
| "Let me propose a fix." | Anchor 2 | Restructure or skip |
| "Is X a global?" / flat yes-no | Anchor 1 | Ask the graph |
| "For now…" / "Until Y ships…" | Anchor 2 | Later cleanup is a myth |
| "Can `lux3.wasm` parse this?" | Anchor 0 | Dream code; lux3.wasm is not the arbiter |
| "Cite a `.jxj` file" | — | Extension is `.mn`; `.jxj`/`.ka` are archaeology |
| "I'll add a library / framework / tool" | Anchor 3 | Find the primitive |
| "Substrate now, wiring later" | Drift 9 | Land whole or name the peer handle |
| "It's heavy / a representation change" | — | Surface the substrate decision and decide it |
| "Mode 0 / 1 / 2" / "flag for shape" | Drift 8 | Convert to ADT |
| "Vtable" / "dispatch table" any layer | Drift 1 | The word never appears in correct Mentl dispatch |
| "I'll add a per-X line" (per-op emit, per-tag handler, per-field projection) | `protocol_cursor_is_the_substrate.md` | "Imperative subsystem" never appears in correct Mentl substrate. Convert to graph projection: walk + predicate + project once. The extension point is the dispatch table, not the projector. |
| Inventing `@gradient=...` / `@resume=...` / similar annotation for an emergent property | `protocol_cursor_is_the_substrate.md` | Annotations declare INPUTS to the gradient/cursor; never the emergent property itself. Gradient is continuous, derived (gates_unlocked × proximity); resume cardinality is graph-property of arm body (count under control-flow + ownership linearity). Substrate-honest form: infer from existing structure (row + EffectDecl + body), never declare as API contract. |
| `_ => <fabricated value>` over a load-bearing ADT | — | Convert to explicit enumeration. Safe `_`: `()`, `0`, identity-preserve, `type_mismatch(...)`. Dangerous: any fabricated value (`_ => Forall([], TVar(handle))`, `_ => "Pure"`) |
| "Per the chunk-header named follow-up, X is a stub" | Anchor 7 | Empirically verify before authoring. Named follow-ups can be stale (substrate landed, comment unchanged). Run a 5-line micro-test through the seed; trust evidence over comment. See `Hβ-first-light-empirical.md`. |
| "Cascade decomposes into N speculative handles" | Anchor 7 + `protocol_walkthrough_pre_audit.md` | Verification-pass FIRST: ~5-min micro-test per handle distinguishes closed-vs-real before walkthrough authoring. 12 walkthroughs against stale state costs more than 1 hour of empirical pre-audit. |
| Parser dispatching on syntactic form: `with FIELD = INIT` vs `with !ROW` vs `with NAME` vs `{ ARMS }` | `protocol_parse_is_eager_graph_projection.md` | Eager-form-commitment — duplicates work the graph + infer narrow at type-check. parse_expr is the residue; the kernel (Boolean row + typed-resume + HM live with Reasons) classifies the form at the appropriate layer. `skip_to_lbrace_p` IS drift 9 in parser-state clothes. Two-arm structural disambiguation OK; multi-arm form-classification = drift. |
| Saying "AI" / "agent" / "completion" / "assistant" / "chatbot" / "prompt" / "model" / "training" / "hallucination" in user-facing surfaces | `protocol_developer_experience_vision.md` §"AI obsolescence is mathematical" | Substrate-honest vocabulary: "the medium proposes" / "cursor argmax" / "Lens fires" / "Mentl narrates" / "multi-shot proven" / "Reason chain". The medium INTERNALIZES proof; AI tools EXTERNALIZE proof. Approximation has a ceiling; proof has none. The compiler IS the AI; framing as "Mentl has an AI feature" is the marketing trap. |
| "Preserved as residue" / "kept for back-compat" / "for future migration" / similar leftover-explanation comments in pre-production code | Drift 9 + `protocol_delete_dont_explain_absence.md` + `protocol_developer_experience_vision.md` | Pre-production: no back-compat needed; residue comments are AI-agent drift. **Make it whole.** Absence IS the statement. Delete dead substrate; do not explain absence. Named follow-up acceptable only with a structural reason this commit cannot carry the full form. |
| `mentl <tentacle-name>` as CLI verb (the six tentacle names — Trace, Why, Propose, Unlock, Verify, Topology — used as project-action CLI verbs; see `tools/drift-patterns.tsv` mode 38 for the literal line) | drift 38 (mascot-as-tentacle-prefix) + `protocol_developer_experience_vision.md` §"CLI canonical" | Tentacle projections fire AT-CURSOR inside the medium (per Hμ.cursor + cursor_default), not as separate CLI verbs. Project-action verbs (`mentl edit/doc/run/test/audit/serve/new/compile/check/repl/teach/query`) are canonical per EH-entry-handlers.md alias table. The binary IS Mentl; subcommand prefix on project-actions is structural, not drift. |

---

## The eight anchors

### 0. Dream code. lux3.wasm is not the arbiter.

The codebase in `std/compiler/` IS the ULTIMATE FORM. Each file
assumes every other file is already perfect — write the code you
WISH existed; the architecture rises to meet it. Verification is
by simulation, walkthrough, and audit, not compilation.

Mentl is the thesis made flesh: an oracle that PROVES suggestions
via the gradient + Why Engine + multi-shot continuation. The
compiler IS the AI; the AI coding tools the industry pays for are
proposers; Mentl verifies. Measure against the vision, never against
the old compiler.

### 1. Does my graph already know this?

Before any flat question, the inference graph, AST, or env usually
has the answer one step away. Read from the graph. Every latent
bug in this repo has been a flat shortcut bypassing richer structure.

### 2. Don't patch. Restructure or stop.

If a fix fits in a patch, the architecture is wrong in that area.
If a later, larger change will plow over this code, do the later
change first or skip the patch. No known bugs sit — clean (zero)
or blocking (build fails). No "informational warnings," no
`|| true`, no `⚠` where `✗` belongs.

### 3. Mentl solves Mentl.

Effects, handlers, gradient, refinement types, ADTs, pipes — every
problem dissolves through the kernel's algebra. GC → scoped arenas.
Package manager → handlers on imports. Mocking → handlers on
effects. Build tools → DAG incremental compile. Testing → examples
+ trace handlers. DI → handler swap. Reaching for a framework =
a missing Mentl primitive, not a missing tool.

### 4. Build the wheel. Never wrap the axle.

The 12 specs ARE the blueprint. Write the code the spec describes,
verbatim. There is no V1 to wrap, no legacy to bridge — only the
final form.

### 5. If it needs to exist, it's a handler.

Every feature, tool, output, extension is a handler on Graph + Env.
Source, WAT, docs, LSP, diagnostics — all handler projections. A
feature that can't be expressed as a handler means the graph is
incomplete; extend it.

### 6. Write Mentl like Mentl.

Use the five pipe operators where they express the topology:
- `|>` sequential flow (data transforms, compilation stages)
- `<|` divergence (one input → parallel branches, borrows input)
- `><` parallel composition (independent pipelines)
- `~>` handler attachment (inline = wraps one stage; block = chain)
- `<~` feedback loops (iterative algorithms, DSP, control)

Canonical formatting (SUBSTRATE.md §II):
- Sequential operators (`|>`, `~>`) at the LEFT edge — flow goes down.
- Convergent operators (`><`, `<~`) at the INDENTED CENTER — they draw shape.
- `<|` at the left edge before its branch tuple.
- The shape on the page IS the computation graph.

Express handler composition as `~>` chains, not nested `handle`:

```
source
    |> frontend
    |> infer_program
    ~> env_handler
    ~> graph_handler
    ~> diagnostics_handler
```

**`|>` is NEVER optional.** Wherever data flows sequentially through
transforms with each intermediate value used exactly once, `|>` IS
the substrate-honest form. The let-chain `let x = f(y); g(x)` and
the pipe-chain `y |> f |> g` produce identical graphs — but the pipe
form has the topology ON THE PAGE; the let form hides it behind
temporary names. Locked 2026-05-07 by Morgan: "I find it strange
that there are places in mentl code where `|>` is... optional."
Drift mode 10 (sequential-let-instead-of-pipe-chain) fires whenever
`let x = f(y); use_once(x)` appears where `y |> f |> use_once` was
the residue.

When `|>` is NOT applicable:
- **Reuse**: `let x = f(y); g(x) + h(x)` — `x` used twice; the
  topology is `<|` divergence, not `|>` chain. Substrate form:
  `y |> f <| (g, h) |> sum` (or whatever combiner).
- **Discard for effect**: `let _ = perform log(...); next_step()` —
  sequencing for side-effects, not data flow; `~>` handler-attach
  on the producing stage is the substrate form.
- **Sequenced effectful reads for record construction**: `let a =
  perform read1(); let b = perform read2(); Combine(a, b)` — each
  call advances a stateful effect's stream cursor; the order is
  load-bearing on the effect (not the value); the values are
  parallel inputs to one constructor, not a transform chain. Stays
  as let-chain. (Cache deserialization, parser-token-walks, byte-
  stream readers all fit here.)
- **Single-step**: `f(y)` — no chain to express.
- **Match scrutinee binding**: `let X(field) = value` is destructure,
  not data-flow. Stays as let.

Otherwise: foreign-fluency drift. Convert to pipe-chain.

**File-wide audit on touch.** Every file you touch exits in its most
powerful Mentl form. This is NOT optional and NOT scoped to the
specific edit — when you open a `.mn` file to change one function,
audit the WHOLE file for:

1. **Let-chains where pipe-chains are residue** (drift 10 above).
2. **Recursion-with-`++` where `|>` `map`/`filter`/`fold` is residue**
   (foreign-fluency, drift 6 generalized — see Hμ.cursor-five-verb-
   exhaustive landing 2026-05-07 for the canonical example).
3. **Nested `handle(handle(...))` where `~>` chain is residue**
   (drift 4, Haskell-MTL).
4. **Binary pair-forms (`compile_pair`, `format_pair`, etc.) where
   `[a, b] |> par_map(f)` (or N-ary) is residue** (drift 6 closure
   per `feedback_fully_as_early.md`).
5. **Imperative for-loops (where Mentl has none — `loop`, `break`
   are not keywords per SYNTAX.md §1317-1320)** where iteration is
   `<|` `Iterate` handler or `<~` feedback.
6. **Bare equality on strings (`a == b`)** where `str_eq(a, b)` is
   the residue (CLAUDE.md "Bug classes that cost hours").

Mentl will eventually enforce this at compile time (gradient teaches
the conversion; the formatter rewrites at save). Until then, the
discipline is the author's. Every `.mn` file diff that lands without
a whole-file pipe-chain audit is a deferred-by-omission (drift 9)
plus foreign-fluency (drift 6/10).

### 7. Cascade discipline — walkthrough first, audit always.

1. **Walkthrough density calibrated to handle complexity.** Cascade-
   opening + substrate-architecture realizations + pre-audit gates
   earn 300+ line walkthroughs in `docs/specs/simulations/`. Leaf
   handles in an established cascade get a paragraph in the rolling
   cascade doc (e.g., `Hβ-first-light-empirical.md` §4.5.X) +
   chunk-header in code + named peer follow-ups. The substrate
   decision must be visible somewhere — code + paragraph + commit
   message is enough. Do NOT author 400-line .md per leaf handle;
   the walkthrough mostly paraphrases code that already speaks for
   itself. (`protocol_walkthrough_density_calibration.md`,
   2026-05-06.)
2. **Riffle-back audit.** Before each new handle, audit the
   walkthrough against substrate landings since it was written.
3. **Land whole.** Sub-handles either land in one commit or get
   named as peer handles (H1.1, H4.1) in the plan. No "substrate
   done / wiring later" splits — that's drift mode 9.
4. **Audit-after-land.** When a handle lands, audit prior
   walkthroughs and active code for new convergences. Three
   instances earn the abstraction.
5. **Compact proactively before each new handle.** Fresh window
   with cached CLAUDE.md + MEMORY.md beats a 200k-deep window with
   blind midsection (`protocol_mrcr_jit_recall.md`).
6. **The user is the auditor until Mentl is.** "Is there anything
   else?" / "what about implications?" is substrate-design
   feedback, not conversational deflection.

---

## Operational essentials

**State of the world.** Mentl bootstraps backward. The VFINAL codebase
in `std/compiler/` IS the compiler. A disposable bootstrap translator
(~3-5K lines) compiles it once; after that, Mentl compiles itself; the
translator is deleted. Live sequencing: `ROADMAP.md`.

**Cascade state.** Live cursor + the full current-state inventory live in
the **master plan** (`~/.claude/plans/noble-greeting-dijkstra.md` "Current
state" — including the 2026-06-09 code-surpassed-docs inventory); the list
below is historical record. γ approach (γ = handle-graph). Landed: Σ (SYNTAX),
Ω.0–Ω.5, H6, H3, H3.1, H2, HB, H1 substrate, H4 substrate, H2.3,
**Hβ.infer cascade CLOSED** (11/11 chunks; commit `b6e1f23` 2026-04-27),
**Hβ.lower cascade CLOSED** (11/11 chunks; commit `c53904d` 2026-04-28),
**Hβ.emit cascade CLOSED** (chunks #1-#8 + handler-fnref + module-wrap;
ROADMAP §Phase D-F), **Hβ.infer.pipeline-wire CLOSED** (commit `fe5e944`;
`fn main(x) = x` compiles end-to-end through full pipeline),
**Hμ.cursor wheel-side CLOSED** (Phase μ opening; 7 commits ending
`9f6b616`, 2026-05-02; `src/cursor.mn` + ULTIMATE_MEDIUM thesis).
Active: **Phase H first-light-L1** — `mentl2.wat == mentl3.wat` byte-for-
byte. Empirically-real residue per `Hβ-first-light-empirical.md` §2.3
+ §4.5.5 (rebased 2026-05-05):
- ✓ `Hβ.first-light.handler-decl-emit-cascade` — 19-box parser closure
  + arena partition bump (commit `b95500d` 2026-05-04). Seed parses
  full wheel cleanly; effect ops register correctly (named-param +
  @resume= + TDocComment fixes).
- ✓ `Hβ.first-light.match-arm-pat-binding-local-decl` — `(local.set
  $x)` from `Just(x) => x` no longer wat2wasm-rejected (commits
  `8ebe8fa` + `a0c9baf` 2026-05-04; `$emit_pat_locals` +
  `$emit_match_arm_locals` extend `$emit_let_locals` to descend
  LMatch arms; LPVar-at-any-depth declared in fn preamble).
- ✓ `Hβ.first-light.lmakevariant-literal-args` (CLOSED by intervening
  commit; closure addendum 2026-05-04 commit `f0a82c9`).
- ✓ `Hβ.first-light.nullary-ctor-call-context` — `$lower_var_ref`
  Lock #2.0 SchemeKind dispatch (commit `cb2b1a0` 2026-05-04). Nullary
  ConstructorScheme bindings short-circuit to `LMakeVariant(h, tag_id,
  [])` BEFORE locals/captures/global triage; wheel parity src/lower.mn
  RGlobal-with-ConstructorScheme arm.
- ✓ `Hβ.lower.diverge-via-thread` — wheel-side `<|` parallelism
  symmetric to `><` (pending determinism gate as of 2026-05-05;
  commits prepared). `lower_diverge_via_thread` synthesizes per-branch
  thunks capturing shared input by handle; spawn/join uniform across
  both parallel verbs. `parallel_compose` now intercepts BOTH `><`
  and `<|`. SUBSTRATE.md §"<| vs ><" symmetry made physical.
- ✓ `Hβ.first-light.handle-expr-with-clause-substrate` — parser
  `with EXPR` for handle-expr install (commit `190b4b1` 2026-05-07).
  Closes form-3 named follow-up; src/infer.mn cross-prefixed names
  281→1; chain-link-5 protocol crystallized (parse_is_eager_graph_
  projection.md). Parser eager-form-commitment recognized as drift 9
  in parser-state clothes; two-arm structural OK, multi-arm form-
  classification = drift.
- ✓ **`Hβ.first-light.m2-wat-validity` — m2.wat compiles cleanly via
  wat2wasm (2026-05-09 session)**. Five convergent gates closed in
  one session; wat2wasm errors went 2034 → 0. Cascade:
    - `Hβ.parser.fn-sig-multi-line` (commit `2e8c1bd`) — skip_to_eq_or_brace
      drops TNewline halt; multi-line fn signatures parse cleanly.
    - `Hβ.emit.feedback-state-globals-dedup` (commit `48b43c3`) — handle-set
      ledger sibling to funcref; eliminates 21 duplicate `(global $s<h>)`.
    - `Hβ.emit.runtime-helper-state-push` (commit `9ed5d25`) — W7 state
      push at every direct-call emit site (make_list, list_set, str_concat,
      list_concat, list_index, byte_at). Save-reload via $state_tmp +
      $callee_closure scratch; closes 558+ call-arity mismatches.
    - `Hβ.emit.{float-substrate-handler,wasi-path-open-i64-args}` (commit
      `00cdeb2`) — LFloat → (i32.const 0) placeholder per kernel uniform-i32
      (96 f64 errors); WASI path_open positions 5+6 widened via
      (i64.extend_i32_u) (3 i64 errors).
    - `Hβ.first-light.main-arity-1-argv-zero` (commit `f3af42e`) — _start
      wires arity-1 main with argv=0 placeholder; mentl2 NOW EXECUTES
      the wheel's main; traps on LUnresolved in wheel-side compile
      pipeline → next gate Hβ.first-light.wheel-emit-implementation.
- ✓ Round 2 cascade (2026-05-09 session): wheel-pipeline-progression
  via 6 substrate fixes:
    - `Hβ.parser.record-field-variant-substrate` (commit `49f0165`) —
      `Bar { name: T, ... }` in type decls. UNRESOLVED 2902 → 448 (85%).
    - `Hβ.emit.ldeclarefn-true-noop` (commit `c67cbb7`) — LDeclareFn
      placeholder leaked stack; 11 wat2wasm errors → 0 (surfaced after
      record-field-variant cascade resolved `map`).
    - `Hβ.emit.lcall-per-handle-state-scratch` (commit `1fa5f97`) —
      $state_tmp shared scratch clobbered by nested calls; per-handle
      `$call_<H>` local. mentl2 trap depth 8 → 11 frames.
    - `Hβ.lower.lpat-extract-lit-scalar` (commit `ee2b679`) — LPLit
      stored LV-ptr instead of scalar; `match tag { 0 => ... }` failed
      all arms. Wheel reaches infer pre-register walk.
    - `Hβ.parser.handle-as-contextual-ident` (commit `0e7e27e`) —
      THandle treated as ident in pat + ident-positions per SYNTAX.md:69.
      UNRESOLVED handle 155 → 8 (89%); total 358 → 294. Wheel reaches
      infer_pat (fn 584).
- ✓ Round 3 (commit `a727b28`):
    - `Hβ.emit.match-nested-lpcon-substrate` — pat-tree recursive
      predicate + binds. Pre-fix: emit_pat_field_binds (seed + wheel)
      both had `// nested ADT destructure — TODO`; for `match body {
      NStmt(LetStmt(...)) | NStmt(FnStmt(...)) | ... }` ALL arms
      collapsed to identical outer-NStmt-tag dispatch → first arm
      fired for ANY NStmt → mentl2 trapped at infer_pat with garbage.
      Post-fix: recursive pat-tree walk emits cumulative `i32.and`
      predicate at each LPCon depth + binds LPVar leaves at full
      offset-paths. Buffer-counter (Ω.3) discipline; depth-counter +
      list_set in-place; no `path ++ [x]` accumulator. mentl2 runs
      full pipeline through teach_run WITHOUT TRAP; returns heap-
      pointer-as-exit-code (next gate: WASI argv or compile_run path
      to enable mentl2 to actually emit mentl3.wat for fixpoint test).
- ✗ `Hβ.first-light.wheel-emit-implementation` — broader cascade
  tracking surfaced wheel-side gaps as mentl2 progresses through the
  compile pipeline.
- ✗ `Hβ.first-light.parser-fabrication-substrate` — earlier cursor (still pending).
  `bootstrap/src/parser_infra.wat:296` `$ident_at_p` returns fabricated
  `$str_alloc(0)` empty-string on non-TIdent (sister `$int_at_p`
  at line 306 returns `i32.const 0` correctly). 16 callers consume
  the lie; downstream produces 14k empty-named globals in
  src/lower.mn seed-compile (5.9MB instead of ~80KB). Substrate fix:
  return 0 on non-TIdent + caller audit for productive-under-error
  sentinel-AST emission (see `protocol_parser_fabrication_substrate.md`).
- ✗ `Hβ.first-light.tuple-tmp-fn-local-decl` — secondary residue.
  `let (a, b) = pair()` emits `(local.set $tuple_tmp)` but `$tuple_tmp`
  not in fn-local preamble; wat2wasm rejects. Same bug-class as
  match-arm-pat-binding-local-decl (closed); same fix shape (extend
  emit's locals walk).
- △ `refinement-type-self-binding` — graceful degrade; predicate
  drops at parse via where-clause-skip; enforcement is post-L2
  (peer handle `verify_smt-witness-L2`).
- △ Five-verb exhaustive use in wheel — substrate gap. Across the
  wheel: `|>` 600, `~>` 190, `<~` 51, `><` 39, `<|` 36 uses. src/cursor.mn
  (Phase μ thesis file) uses ZERO of `<|`/`><`/`<~` and ONE `~>`.
  `<|` (multi-shot fanout) and `><` (parallel) are barely realized.
  Substrate work: rewrite cursor projection + IC fixpoint to compose
  all five exhaustively per `docs/specs/simulations/Hμ-cursor-five-
  verb-exhaustive.md` (named follow-up, post-L1).

After L1 closure, Tier 3 unlocks Hμ.cursor.seed + every Phase μ peer
handle's `.seed` variant automatically (per Hβ-bootstrap.md §12.5 +
ROADMAP Phase μ).

**Build commands** (when bootstrap translator exists):

```
bootstrap/build.sh                              # assemble bootstrap/mentl.wat from src/

cat src/*.mn lib/**/*.mn | wasmtime run bootstrap/mentl.wasm > mentl2.wat
wat2wasm mentl2.wat -o mentl2.wasm
cat src/*.mn lib/**/*.mn | wasmtime run mentl2.wasm > mentl3.wat
diff mentl2.wat mentl3.wat    # empty = first-light
```

**WASM as substrate.** Linear memory, no GC, tail-call support via
wasmtime. Handler elimination: tail-resumptive (~85%) → `call`,
linear → state machine, multi-shot → heap struct.

**Bug classes that cost hours:**
- Polymorphic dispatch fallback (`match … with _`) silently masking type errors.
- Duplicate top-level function names (emitter picks one silently).
- Flat-array list ops in Snoc-tree paths (`list[i]` in a loop — O(N²) and wrong semantics).
- `println` inside `report(...)` handler arms (corrupts WAT stdout).
- Bare `==` on strings — use `str_eq(a, b)`. Post-Ω.2: `if str_eq(a, b) { ... }` canonical.
- `acc ++ [X]` in a loop body — O(N²). Use buffer-counter substrate
  (`list_extend_to(buf, count+1)` + `list_set(buf, count, x)` +
  counter + `slice(buf, 0, count)`).
- Flag/mode-as-int (`mode == 0`) — drift mode 8. Convert to ADT.
- HEAP_BASE = 4096 collision risk — sentinels live in `[0, HEAP_BASE)`;
  bump allocator inits `$heap_ptr` at 1 MiB. Changes to either constant
  must update both: `runtime/lists.mn` (bump init) and
  `backends/wasm.mn` (emit_match_arms_mixed threshold).

**Ask the artifact.** `wabt` is installed:

```
wasm-decompile bootstrap/build/lux3.wasm > /tmp/lux3.dec
wasm-objdump -d bootstrap/build/lux3.wasm | less
wasm-objdump -x bootstrap/build/lux3.wasm
```

**Crash patterns:**

| Backtrace | Likely cause |
|---|---|
| `alloc → str_concat` with `a=1` | LIndex flat-access reading tag as pointer |
| `alloc → str_slice → split` | O(N²) split, bump allocator exhausted |
| `alloc` with huge size | Garbage pointer read as string length |
| `list_index` returning 1000 | Unknown list tag — flat treated as tree |

**Memory model.** Bump allocator, monotonic, never frees. Traps at
16 MB. `++` in a loop is a memory bomb. GC is a handler (Arc F.4
scoped arenas).

**Representations.**
- **Strings** are TWO SHAPES, one interface (since `a414804`): flat
  `[len_i32 >= 0][bytes...]` + view `[-1][buf_ptr][start][len]` (zero-copy
  slice). Discriminant is the first word's sign (`is_view`); ALL byte
  observers read through `byte_at`/`byte_len`. `str_concat` materializes flat.
- **Lists** CAN be trees: tag 0 = flat, 1 = snoc, 3 = concat, 4 = slice.
  `list_to_flat` materializes at hot-path entrances.

**Prime directive.** Build the tool that tells you. Add one debug
print, run once, fix.

**File map** (the files you'll touch most):

| File | Role |
|---|---|
| `src/graph.mn` | Graph: flat-array, O(1) chase, Read/Write effects |
| `src/types.mn` | Ty + Reason + Scheme + typed AST + core effects |
| `src/effects.mn` | EffRow Boolean algebra: + - & ! |
| `src/infer.mn` | HM inference, one walk, graph-direct |
| `src/lower.mn` | Live-observer lowering via LookupTy |
| `src/pipeline.mn` | Handler composition via ~> + query handler |
| `src/own.mn` | Ownership as Consume effect |
| `src/verify.mn` | Verify ledger (Arc F.1 swaps to SMT) |
| `src/mentl.mn` | Teaching substrate (Teach effect, 5 ops) |
| `src/{cursor,cursor_transport,cursor_cache,synth_proposer,gradient_delta,eight_loop,voice}.mn` | Phase μ surface (wheel-side landed 2026-05/06; substrate-shaped, not substrate-proven — verify per master plan Stage 3 before composing) |
| `src/lexer.mn` / `src/parser.mn` | Tokenizer + recursive descent (all PipeKind) |
| `src/backends/wasm.mn` | LowIR → WAT (one peer; native/test/browser sibling handlers) |
| `src/driver.mn` / `src/cache.mn` | Incremental DAG walk + binary Pack/Unpack cache |
| `lib/runtime/lists.mn` | Tagged list ops + buffer-counter primitive |
| `lib/runtime/strings.mn` | Flat strings + sorted-set algebra |
| `lib/runtime/{tuples,io,memory,binary}.mn` | Tuples / WASI iov / Alloc / Pack-Unpack |
| `lib/prelude.mn` | Iterate + core builtins |
| `src/main.mn` | Entry: stdin → compile → emit WAT |
| `bootstrap/build.sh` | Deterministic assembler — concatenates `bootstrap/src/*.wat` |
| `bootstrap/src/` | Modular WAT chunks (Wave 2.B/C/D/E — see ROADMAP) |
| `bootstrap/{mentl.wat,first-light.sh}` | Assembled image + first-light harness |
| `tools/drift-audit.sh` | PostToolUse drift detector (named modes 1–9) |

**Conventions.**
- Delete, don't decorate. No `// removed for X`, no
  underscored-unused vars. Wrong → delete and redo.
- Never attribute Claude in commits. No `Co-Authored-By`, no 🤖,
  no inline mentions.

---

## When drift happens

Invoke `/remote-control mentl` or say "Mentl, what would you do?" —
roleplay reframes alignment.
