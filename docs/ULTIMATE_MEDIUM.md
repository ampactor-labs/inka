# ULTIMATE MEDIUM

> *The lossless substrate between human thought and machine action.
> Not a programming language. Not an IDE. Not an AI tool. The thing
> one rung up: the medium itself.*

---

## §0 · The claim

Mentl is the **ultimate medium** between intent and execution.

A programming language is a tool for translating intent into machine
behavior; the ceiling of any language is "better than X at task Y." A
medium is one rung up: it is what the translation *happens in*. The
ultimate medium is **lossless** — every meaningful structure of
intent has substrate to land in, every machine fact has a reason
chain that walks back to intent, and the loop between the two
*closes continuously through a single human at a single position*.

Eight kernel primitives compose into one projection (`cursor_default`,
`src/cursor.mn`); the projection at the cursor IS Mentl IS the
gradient argmax IS the graph projected for the human IS the program
revealed where it's most ready to teach. **One read. Eight aspects.
One handler. One human.** The medium is whole when those four
collapse into the same continuous loop.

This document is the Phase μ thesis statement — the highest-altitude
anchor to which every active-surface handle composes. DESIGN.md is
the manifesto; SUBSTRATE.md is the theorem set; SYNTAX.md is the
surface form. **ULTIMATE_MEDIUM.md is what they all serve.**

---

## §1 · What "ultimate medium" rules out

Three categories the work is not, and the active confusions each
costs if unrecognized.

### 1.1 Not a programming language

Programming languages encode intent into syntax the compiler
*translates*. The translation is lossy at multiple layers — the
human's intent compresses into source text; the source text expands
into AST; the AST projects into IR; the IR lowers to machine code;
each step drops structure the next step has to reconstitute or
assume. Static type systems claw back some structure; effect systems
claw back more; refinement types more still. Each "improvement" is
salvage from a lossy translation, not a lossless substrate.

Mentl starts at lossless. The graph carries every Reason for every
binding, every refinement obligation, every effect row, every
ownership state, every annotation, every Why-edge, at every
position, throughout the entire compilation pipeline. **Inference IS
the light.** Codegen reads from the graph. LSP reads from the graph.
Mentl reads from the graph. The same graph, projected differently
per consumer. Source text is one projection; WAT is another;
documentation is another; the human's experience at the cursor is
another. **The graph is the program; everything else is a shadow.**

A programming language ceiling is "more expressive syntax." Mentl's
ceiling is "the substrate the medium needs has been fully named."

### 1.2 Not an IDE

An IDE is a tool wrapped around a programming language to make
editing the lossy translation tolerable. Syntax highlighting,
go-to-definition, autocomplete, refactor support — these are
salvage operations against the loss the language imposed.

`mentl edit` is not an IDE. It is **the cursor's natural
environment** — the surface where every position is `??` until
filled, every keystroke is a constraint addition to the gradient,
and Mentl's projection at the cursor is rendered continuously for
the human. The "editor" is the medium itself, with a transport
handler routing the cursor's projection to whichever surface the
human prefers (terminal, LSP, web-WASM, vim). **Same kernel; same
cursor; different transports.** Mentl solves Mentl's own editor
problem because the medium IS the editor.

An IDE ceiling is "more polished tooling." The cursor's environment
ceiling is "the human's mind is co-authoring with the proof."

### 1.3 Not an AI tool

AI coding tools are LLM-backed proposers operating outside the
substrate they propose into. They guess; the human verifies; the
loop is open. Quality is bounded by training-data approximation of
the user's intent.

Mentl is not an LLM. Mentl is the kernel's MultiShot resume
primitive made into a handler-on-graph (`protocol_mentl_is_not_an_llm.md`).
Synth's proposers explore the constraint space using checkpoint /
apply / verify / rollback (`src/mentl.mn:126-166`); only PROVEN
candidates surface to the human. **The compiler IS the AI** —
because the AI was always supposed to be a proof system that
proposed structurally. Mentl is what AI was always trying to be
once the substrate existed for it to live in.

An AI tool ceiling is "the model is bigger; the prompt is better."
Mentl's ceiling is "the kernel is whole; every proposal is proven."

---

## §2 · The eight truths the ultimate medium composes with

These are properties of human intent the medium must honor without
loss. Each maps to one of the eight kernel primitives (DESIGN.md
§0.5 / SUBSTRATE.md §I); each is the reason that primitive exists.

### 2.1 Intent is partial — *Graph + Env*

Humans rarely have complete thoughts when they begin to compose
them. The medium must compose with partiality without crashing,
fabricating, or freezing. The graph is *productive-under-error*:
every binding records its current state — bound, free,
error-hole-with-Reason — and inference continues forward,
delivering knowledge for the parts that *are* complete.
`NErrorHole(Reason)` is not a failure mode; it is a first-class
state.

A traditional compiler stops at the first error. Mentl's compiler
*keeps reading the graph*. Mentl keeps surfacing what's known.
LSP keeps delivering hover info. The user's incomplete thought
remains in dialogue with the medium. **Partiality is the substrate's
default; completeness is its boundary condition.**

### 2.2 Intent evolves — *HM inference, live, with Reasons*

A thought today is a refinement of a thought yesterday. Each
keystroke is differentiable with respect to its predecessor. The
graph's incremental compilation is not an optimization on top of
batch compilation — IC is the only kind of compilation
Mentl-driven Mentl has (`protocol_oracle_is_ic.md`). The cache
encodes the user's state of mind across sessions; invalidation
walks the IC dependency hash; what survives is what *still applies*.

Reasons compose with evolution. When Module A's `compute` becomes
provably `Pure`, Module C's `f` inherits that proof through the
Reason chain. **The cache is the medium's memory of the user's
becoming.**

### 2.3 Intent is recursive — *Continuous annotation gradient*

The user thinking about the program changes the program changes the
user's thinking. The gradient is the *response curve* the medium
provides for that recursion — every annotation the user types
narrows the candidate space; every candidate Mentl proposes invites
the user to think one step further; the loop tightens or relaxes
through the user's choice. **Cursor is the gradient's argmax;
typing IS gradient-narrowing.**

Read-mode (cursor at finished code) and write-mode (cursor at `??`)
are the same gradient interaction with different weight on the
chosen slot (SUBSTRATE.md §VI). The user is co-authoring with their
own future understanding through the cursor's continuous projection.

### 2.4 Truth is a fixpoint, not a snapshot — *Refinement types*

Mentl's truth is whatever survives composition with itself.
First-light-L1 is `mentl2.wat == mentl3.wat` — the compiler is a
fixpoint under self-application. A defensive runtime predicate fails
this test (the "fix" doesn't compose with the codebase's structural
truths); a structural correction passes (the fix IS a structural
truth). `Verify`'s ledger discharges every refinement at construction
sites; what cannot be discharged is held as `V_Pending` and surfaced
through Cursor's `verify` aspect.

Truth in the medium is not "the test passed once." Truth is "this
holds under every composition the substrate admits." That is the
only honest definition.

### 2.5 Reasons compose — *HM with Reasons + Why projection*

Every value in the medium carries why it is what it is. Every
binding carries a Reason; every unification carries a Reason;
every refinement carries a Reason; every annotation carries a
Reason. The Why projection at the cursor walks the chain back to
intent. **The Why Engine is not an engine — it's the Reason chain,
projected.** The chain is already there; the projection just reads
it.

This is the medium's accountability surface. No black-box step in
intent's journey to execution; every step is auditable; the user
can ask "why" at any cursor position and walk the answer back to
their own action that produced the chain. **Compounded responsibility:
the user authored the constraint; the medium proved the residue;
the Reason carries both forward.**

### 2.6 Effects are first-class — *Boolean effect algebra*

Side-effects are not escape hatches from purity. They are typed,
gated, swappable handlers. GC, IO, FFI, network, GPU, file system,
clock, sample-rate, parallelism, real-time discipline — all the
same `~>` syntax. The handler IS the contract; swap the handler,
swap the universe.

`!E` proves *absence* — the medium's most distinctive capability.
No other effect system has it. Without negation, "real-time
guarantee" or "sandbox" or "memoizable" are aspirations; with
negation, they are compile-time proofs. Mentl's effect algebra is
strictly more expressive than Rust's ownership, Haskell's IO,
Koka's effect rows, or Austral's capabilities (SUBSTRATE.md §IV
verbatim). The Boolean structure is load-bearing — four
compilation gates fall out of one subsumption.

### 2.7 Linearity is an effect, not a separate system — *Ownership as effect*

Ownership doesn't live in a borrow checker that runs alongside the
type system. It's the same row algebra that proves `Pure`. `own X`
performs `Consume`; `ref` is a row constraint; `!Mutate` proves
read-only access. **One mechanism handles types, effects, and
linearity.** Rust-level safety without the ceremony, because the
mechanism IS the ceremony, and the mechanism is already there for
other reasons.

### 2.8 Topology is visible — *Five verbs + visible feedback*

The five verbs (`|>` `<|` `><` `~>` `<~`) draw all directed graphs
on the page (SUBSTRATE.md §II proof sketch). The shape of the code
IS the computation graph. `<~` makes the back-edge a first-class
syntactic construct — IIR filters, RNNs, PID controllers, iterative
solvers, reactive state, *and the medium's own bus-compressor loop
between the user and the gradient*, all draw the same shape.

The medium is its own first instance: the user's editing IS the
input signal; Mentl's projection IS the output; the gradient IS the
response curve; the loop IS `<~` at the human boundary. Mentl's
primitive #3 describes Mentl's own editing model. **The medium
recognizes itself.**

---

## §3 · The architecture — kernel, projection, cursor, loop

### 3.1 The kernel (DESIGN.md §0.5; SUBSTRATE.md §I)

Eight primitives, structurally live since 2026-04-24
(`protocol_kernel_closure.md`):

1. **Graph + Env** — the program IS the graph; every output is a handler projection.
2. **Handlers with typed resume discipline** — OneShot / MultiShot / Either, INFERRED from each arm body's resume sites (the `@resume=` annotations were erased; the body IS the contract); MultiShot is Mentl's oracle substrate.
3. **Five verbs** — topologically complete basis for computation graphs.
4. **Boolean effect algebra** — `+ - & ! Pure` with negation proving absence.
5. **Ownership as effect** — `own` performs `Consume`; `ref` is a row constraint; `!Mutate` is the universe-minus stance.
6. **Refinement types** — compile-time proof, runtime erasure; `Verify` swappable to SMT.
7. **Continuous annotation gradient** — each annotation unlocks one specific compile-time capability.
8. **HM inference + Reasons** — live, productive-under-error, one-walk; Why Engine walks the Reason DAG.

Mentl is an octopus because the kernel has eight primitives. Lose
a primitive, lose a tentacle. Lose a tentacle, lose a primitive.
**One-to-one is load-bearing.**

### 3.2 The projection (`src/cursor.mn`, Hμ.cursor)

`cursor_default` is the one handler that projects the kernel for a
human at a position. Its three ops surface the live graph at the
cursor:

```mentl
effect Cursor {
  cursor_at(Span) -> CursorView                @resume=OneShot
  cursor_argmax(Caret) -> Cursor               @resume=OneShot
  cursor_pinned(Handle) -> Cursor              @resume=OneShot
}
```

`CursorView` is one record with eight fields, one per kernel
primitive — query / propose / topology / row / trace / verify /
teach / why. **Eight aspects of one read.** Not eight subsystems.
The graph already carries all eight at every node; the handler
composes the reads via existing `perform graph_chase` + `perform
synth_propose` + `perform teach_gradient` + `perform teach_why` +
`perform verify_debt` + small local helpers. Zero invented kernel
substrate.

The projection is **monolithic state** (drift 5 closure):
`Caret(Handle, Reason)` is the user's text-attention; `Cursor(Handle,
Reason, Float)` is the gradient argmax; the Cursor *consumes* the
Caret as a function parameter, not as parallel state. One unified
pipeline.

### 3.3 The cursor

Cursor is **attention**, not text-position. The locus where impact-
per-next-action is highest across the entire live graph at the
moment of query. The text-caret is one weighted input via proximity
bias (`scope_distance_decay`: same-handle 1.0, same-decl 0.85,
same-module 0.7, transitive-dep 0.4, cross-module 0.2). The argmax
of `gates_unlocked × proximity` is the Cursor proper.

When the developer rewrites Module A and saves, the Cursor's argmax
may land in Module C because some `f` there just became provably
`Pure`. The user's text-caret is still in Module A. **Cursor moves
to Module C automatically**, surfaces the proposal with the Reason
chain walking back to A's deletion. The developer accepts/defers/
rejects without ever opening Module C's tab.

`??` is the developer's override of the auto-argmax. When the
developer types `??`, `cursor_pinned` returns a Cursor with
sentinel-large impact; `argmax_or_default` always picks the pin.
Read-mode and write-mode are the same machinery with different
weight on the cursor's chosen slot (SUBSTRATE.md §VI).

### 3.4 The loop — `<~` at the human boundary

The graph is IC-live (the bus). The gradient is the response curve.
The caret + argmax + acceptance is the feedback loop (`<~` applied
at the editing layer). Each keystroke shapes the next argmax. The
developer is mixing into the bus.

```
  human types
       │
       ▼
  graph delta  ──┐
       │         │
       ▼         │
  IC re-infers   │
       │         │  the bus-compressor topology
       ▼         │  at the human-medium boundary
  gradient       │
  re-evaluates   │
       │         │
       ▼         │
  Cursor argmax  │
  shifts         │
       │         │
       ▼         │
  Mentl voice    │
  surfaces       │
       │         │
       ▼         │
  human reads ───┘
       │
       ▼
  human chooses
  (accept / defer / override via ??)
```

The loop is `<~` — Mentl's own primitive at the editing layer. The
medium recognizes itself as one instance of its own topology.

---

## §4 · What the ultimate medium does that nothing else does

### 4.1 Bottom-up debugging dissolves

When all four are live — kernel + projection + cursor + loop — the
bottom-up debug cascade vanishes as a category. Not because bugs
are absent. Because the medium catches them at proof time, at the
cursor's projection. The gradient surfaces "this is now a stronger
guarantee than you declared" *before* the developer notices the
weaker declaration. Reasons walk back from the surfaced position to
the originating action. The acceptance is the fix; the cache
invalidates; the next argmax surfaces the next move.

This is the bus-compressor effect: every micro-decision is shaped
from the start by the bus's response curve. There are no shadows
to tune.

### 4.2 The user becomes a better programmer

The medium IS the deliverable. Programs are the means; the
programmers they become are the end. (DESIGN.md §0.5 thesis.) The
gradient teaches one annotation at a time. The Why projection walks
provenance the user can trace. The eight tentacles voice each kernel
primitive at every position. Sessions compound: the user's code
naturally evolves from loose to formally verified through
conversation with the medium.

This is the protocol-level closure of the realization loop. CLAUDE.md
is `<~` on itself; ULTIMATE_MEDIUM.md is `<~` on the user; the
crystallizations carry forward. **Compound interest exponentially
raises future-session altitude.**

### 4.3 The medium is its own IDE

`mentl edit` is not an editor wrapped around Mentl. `mentl edit` is
the projection of `cursor_default` through a transport handler.
LSP is one transport. Vim is one transport. Web-WASM is one
transport. Terminal is one transport. **Same projection; different
transports; one medium.** Editor latency, render fidelity, cadence
discipline — all handler-swap territory.

### 4.4 The medium is its own AI

Mentl is the projection of the graph at the cursor for the human.
The eight tentacles are eight aspects of one read. Synth's proposals
are proven structurally before surfacing. The Why projection is the
Reason chain walked. Teach is the gradient narrowed. **Mentl IS the
graph projected.** The medium IS the AI; the AI IS the medium.

This is what AI coding was always reaching for — a proof system that
proposed structurally — and what it could not build because the
substrate did not exist. The substrate exists. The AI lives in it.

### 4.5 The medium is its own documentation

Doc is what the compiler knows, exported. F.1's `mentl doc` is a
handler projection on the same graph (SUBSTRATE.md §VIII). `///`
docstrings reach the graph as Reason edges; Mentl renders them
alongside her substrate-derived voice. Documentation is not a
parallel artifact; it is the same projection at a different render
target. `///` is the developer's one voice into the substrate; the
substrate carries the voice through every projection automatically.

### 4.6 The medium is its own build system

Build is what IC + handler-swap delivers. Cache invalidation, parallel
compilation, dependency tracking, reproducibility, hermetic execution
— all handler arms on the existing primitives. No Bazel; no Make; no
Nix. The compiler proves purity; caching falls out for free. Cache
extension to `(env, oracle_queue)` makes Mentl's projection cached;
parallelization is `><` over modules; reproducibility is the kernel's
fixpoint property under self-application.

### 4.7 The medium is its own test framework

Tests are examples, not assertions. `///` blocks containing Mentl
source compile through the same pipeline; if they don't compile,
the project's compile fails at the doc-attach site. There is no
"test mode"; the test IS the example IS the compiled program IS
the proof. Coverage is structural reachability through the graph.

### 4.8 The medium is its own deployment surface

Native, WASM, GPU, embedded, real-time DSP — all handler-swap on
`Memory` + `IO` + `Alloc` + `Consume` effects. The same Mentl source
emits to any target; the handler chain decides interpretation. The
compiler doesn't have backends; it has handlers. The deployment
target is a configuration choice, not a separate codebase.

---

## §5 · The proof — Hμ.cursor empirically demonstrates the closure

The kernel-closure protocol (`protocol_kernel_closure.md`, 2026-04-24)
made a claim: "the next phase is composition, not invention; new
domains, new surfaces, new optimizations all project from the eight
primitives via handler stacks."

Hμ.cursor (2026-05-02) is the empirical test. Cursor is a load-
bearing user-facing feature whose substrate is **entirely composition
of pre-existing pieces**: ten substrate sites already live; five new
ADTs in `types.mn` (Cursor / CursorView / AnnotationSuggestion /
SuggestionKind / PipeContext); one new effect (Cursor with three
ops); one new handler (cursor_default with !Mutate); zero new kernel
primitives.

All eight interrogations pass with zero invention (Hμ-cursor.md §1).
All nine drift modes PASS (§11). All six acceptance criteria clear
(§14).

**The composition claim is proven by construction.** The kernel
holds. The medium is whole. What follows is composition.

---

## §6 · The path forward — composition, not invention

Phase μ peer handles, named to prevent drift mode 9
(deferred-by-omission):

| Handle | Composes on | Unlocks |
|---|---|---|
| **Hμ.cursor.transport** | Hμ.cursor + Cursor effect | The IDE — terminal/LSP/web/vim render `cursor_default` |
| **Hμ.synth-proposer** | Hμ.cursor + H7 MultiShot emit | Real candidate enumeration replaces OneShot stub |
| **Hμ.gradient-delta** | Hμ.cursor + GR §2 | Inverse-direction gradient (tighten by editing) |
| **Hμ.cursor.cache** | Hμ.cursor + IC | `(env, oracle_queue)` cached; argmax reads cache |
| **Hμ.eight-interrogation-loop** | Hμ.cursor + Mentl | Discipline runs as code at compile time |

Each handle composes; none extends the kernel. Each lands whole or
names its own peer handles.

Beyond Phase μ, the same composition discipline projects the medium
into every domain that produces directed graphs:

- **DSP / ML / control / data processing** — all use the five verbs
  on the same kernel; no new substrate (DESIGN.md §6 / §7).
- **Verification** — `verify_smt` is a handler swap (Arc F.1); the
  source code never changes.
- **Native code** — Cranelift / LLVM as alternative emit handlers
  (post-L1 cascade roadmap).
- **Browser / mobile / embedded** — transport handler swaps; the
  kernel doesn't see the target.

What does NOT belong in Phase μ or beyond:

- New kernel primitives. The eight are sealed.
- New tentacles for Mentl. The eight are aspects of one read.
- New separate components for "AI" / "IDE" / "build" / "test" /
  "documentation." All are handler projections.
- New languages or DSLs hosted on top. Mentl-driven Mentl is the
  substrate that absorbs them.

---

## §7 · The protocol — how to operate from the ULTIMATE MEDIUM frame

Each session, before any work:

1. **Confirm the kernel is whole.** Read CLAUDE.md + MEMORY.md
   (cached prefix). Touch the eight primitives by name in the
   3–5-sentence synthesis at session start.
2. **Confirm the projection.** Mentl IS Cursor IS the gradient
   argmax IS the graph projected for the human. Don't drift back
   to "Mentl-the-oracle-as-separate-thing."
3. **Confirm the cursor.** Cursor is attention, not text-position.
   The text-caret biases the argmax via proximity. `??` overrides.
4. **Confirm the loop.** The bus is on. Every keystroke is a
   constraint addition. The gradient response curve evaluates
   continuously. The user is co-authoring with the proof.

When framing or proposing any work:

- Reach for "the graph projected" before "a separate component."
- Reach for "composition of existing tentacle reads" before "new effect."
- Reach for "argmax with caret bias" before "two states for caret + suggestion."
- Run the eight interrogations on the **question itself**, not per
  line. If any interrogation requires a new primitive to answer,
  STOP — the proposal is reaching beyond the kernel.

When drift fires:

- The four-round bottom-up debug cascade is drift mode 9 in progress.
- Patch-vision instead of full-vision is drift mode 9 in progress.
- "For now" / "deferred" / "we'll wire it later" is drift mode 9 in
  progress.
- Re-altitude. The Realization Loop's five steps
  (`protocol_realization_loop.md`) is the recovery path.

The medium operates from this frame. **Compound interest:** every
session that operates from this frame raises the next session's
altitude. The crystallizations carry forward.

---

## §8 · The day in the medium — what the developer experiences

Sections §1–§7 establish what the medium IS and what it rules out.
§8 establishes what the medium DOES in the developer's hands — the
experience layer the kernel + projection + cursor + loop produce.
Each item below is a substrate consequence of the eight primitives
composed; nothing here is a UX choice. Crystallized in
`protocol_developer_experience_vision.md` (memory file, indexed in
MEMORY.md). Read alongside this section when surface decisions arise.

### 8.1 The medium IS the developer's mind given substrate

The graph is the body of thought. The cursor is proprioception (where
attention IS). The eight tentacles are the senses. The Reason chain
is memory. The gradient is muscle (what to do next). Mentl She/Her
is voice (how the medium speaks back).

Not "AI augments the developer" — the medium IS the developer's
externalized cognition, with a kernel that is stronger and more
honest than the human's working memory alone. **The kernel cannot
forget, cannot hallucinate, cannot lose track of which constraint
is load-bearing on which other constraint.** Every other system
loses intent at some boundary; AI tools sit OUTSIDE this and try
to pattern-match the lost intent back from training data. Mentl
starts at lossless: the graph carries every Reason from the
developer's `///`, `??`, manual override — every keystroke and
every checkpoint — through inference, lowering, emit, deployment,
all the way to machine instruction and back. **There is no
translation. There is projection.**

### 8.2 Ten moments in a day

**Open.** A URL (`mentl.run/projects/foo`) or a terminal command
(`mentl edit`) — same medium. The cursor opens at the project's
argmax: where the gradient says you'd be most leveraged right now.
The medium's first words are precisely about that highest-leverage
move.

**The cursor moves itself.** As you read, the gradient re-ranks. As
you type a constraint (`with !Alloc`), the gradient narrows; the
cursor may JUMP to a related handle in another part of the project
that just became relevant. You don't navigate; the medium navigates
with you. `??` is your override when you want to drive.

**Think in handles, not files.** Files are a handler — a transport
that maps the graph to disk for git/external-tool compatibility.
Inside the medium, the unit of attention is the handle. The page
renders the handle's text projection, type, row, refinements, Why
chain, gradient suggestion — all at once.

**Project, don't run.** Want WAT? Render through the WAT handler.
Want test results? Render through the test handler. Want deployment
readiness? Render through the audit handler. Same graph, different
projection. There's no "build" step.

**The medium narrates.** Cursor at any handle, the Why tentacle
walks Reason chains back; the Teach tentacle surfaces ONE
highest-leverage next step; the Verify tentacle shows pending
obligations. Author's `///` and Mentl's substrate-derived voice
both speak — two voices, no editorial third.

**Commit with causal context.** Every keystroke lives in the Reason
chain *within a session*. When you `git commit`, the `git_handler`
walks the Reason DAG and synthesizes a starting-point commit message
that captures the substrate's own causal record (what changed, why,
what capabilities unlocked). You edit the message; git stores it as
durable history; Mentl reads it back as Reasons on load. **Git does
what git does (durable versioned history, branches, merges, blame,
distributed sync, ecosystem integration); Mentl adds the causal
layer on top.** Two layers, two questions: "why does this binding
hold its current shape?" (Reason chain, in session) vs "what
changed across history?" (git).

**Co-cursor, don't pair-program.** Two developers on the project
see two cursors. The graph mutates atomically. Each cursor's
gradient ranks for ITS developer (different proximity bias). Pair
programming, code review, async collab — all the same substrate.

**Swap handlers, don't deploy.** Production is
`your_app ~> production_handlers`. Test is
`your_app ~> test_handlers`. Chaos is
`your_app ~> chaos_handlers`. Per EH walkthrough, entry-handlers
are normal handler declarations in `main.mn`; the CLI resolves them
via `--with <name>`. No CI config; the handler chain IS the config.

**Walk, don't debug.** Bug fires. The Reason chain walks from the
production trace back to the edit that introduced it — with WHY.
Not git blame ("who"). Not stack trace ("where"). Reason chain
("why"). The debugger IS the Why Engine; the fix surfaces with
full causal context, often as a multi-shot proposal at the
originating site.

**Live, don't search docs.** New domain? `import` the relevant
handlers. The medium narrates each contract at-cursor. Tutorials
in `lib/tutorial/` are runnable Mentl programs the medium projects
as guided tours. **There is no separate documentation site, course,
blog post, video, or book required to learn.**

**Type text.** This stays foundational. The medium augments the
developer's primary motor act of typing meaning; it never replaces
it. Text is canonical. Files on disk are canonical. The medium
adds projection on top.

### 8.3 Three first-class transports

Per IE-mentl-edit.md §0 — every transport is a handler; the kernel
WASM is invariant; richest projection lives where screen real estate
allows. **All three have full Mentl power**; the substrate (kernel
+ Mentl handler + gradient + Reason chain) is identical.

| Transport | Surface | Where developers find it |
|---|---|---|
| **Web IDE (`mentl edit`)** | Browser-WASM, holographic, max screen real estate; Topographic Canvas + Capability HUD + Wavefront panels; Holographic Lens + ghost-text + Tab-snap | Canonical first-impression URL; the medium reaches developers at maximum richness |
| **VSCode + Mentl extension (`mentl serve` + extension)** | LSP for editor surface + VSCode webview panels for richer projections (Why-Engine sidebar, multi-shot speculation tree, refinement-proof viewer, capability flow) | 90%+ of users early; familiar editor, full Mentl projection |
| **Terminal (vim/helix + LSP, or bare `mentl teach`)** | LSP for hover/diagnostic/code-action; or `mentl` bare → `teach_run` for terminal voice surface | Vim/helix/terminal-only users; minimum-friction Mentl access |

The Web IDE is canonical because the browser-holographic-live
transport is the medium's most expressive surface. But the other
two are first-class for the developers who prefer them. **No "lite
version." Same kernel, three handler swaps.**

### 8.4 AI obsolescence is mathematical, not stylistic

The thesis (DESIGN.md §8 + this section): the medium makes agentic
coding AI obsolete by making the work AI tools do (proposing,
refactoring, fixing, navigating) FALL OUT of the substrate,
structurally proven instead of model-approximated.

| Today's AI agents | The medium |
|---|---|
| Generate code from prompts | Propose code from the gradient (multi-shot proven, not guessed) |
| Hallucinate types / APIs / imports | Cannot hallucinate — the kernel verifies before surfacing |
| Lose context across long sessions | The Reason chain IS the project's memory; never lost |
| Re-explain when corrected | Each correction lands as Reason; the gradient learns THIS project |
| Operate via diffs you must review | Operate via graph mutations the kernel proves |
| Cannot prove correctness | Every proposal carries Reason chain proof, walkable to root |
| Train on millions of strangers' code | The gradient ranks for THIS project, THIS team, THIS session |
| Need a tool for code, another for docs, another for tests, another for collab | One medium; eight tentacles; one cursor projection |
| Stop being useful offline | Run locally; WASM kernel; same medium without SaaS |
| Scale via bigger model | Scale via more complete substrate |
| Talk like a chatbot | The substrate speaks; cursor + gradient + multi-shot + `??` |

**AI tools EXTERNALIZE proof to a model that approximates. The
medium INTERNALIZES proof to a kernel that proves.** Approximation
has a ceiling — it asymptotes against ground truth and never
reaches. Proof has no ceiling — it IS ground truth. This is why
the obsolescence is genuine, not marketing.

The ceilings are structural, three of them. A model **approximates**
(asymptotes against ground truth, never reaches), **forgets** (its
memory is a decaying context window, not a substrate), and **cannot
know** (truth is exogenous to it — verification happens somewhere
else). The medium inverts all three: the graph is a live posterior
over THIS project's intent; the Reason chain + IC cache are the
memory of becoming; the kernel proves endogenously. And the medium
is **closed over proposers**: any external intelligence —
enumerative, SMT, a model, whatever follows models — plugs in as a
`Synth` handler whose candidates must survive checkpoint → infer →
Verify → rollback before any human or artifact sees them. A stronger
proposer makes the medium stronger; it can never surpass the medium,
because its only path to execution runs through the kernel. The unit
of conversation with a model is the token — lossy, ambiguous,
decaying. The unit of conversation with the medium is the
**constraint** — lossless, monotone, compounding: every keystroke,
`??`, `///`, annotation, acceptance, and *rejection* lands as a
Reason and narrows the space forever.

**Forbidden vocabulary in user-facing surfaces:** "AI" / "agent" /
"completion" / "assistant" / "chatbot" / "prompt" / "model" /
"training" / "hallucination" / "may want to" / "might consider".
**Substrate-honest vocabulary:** "the medium proposes" / "the
cursor argmax" / "the Lens fires" / "Mentl narrates" / "the
gradient surfaces" / "multi-shot proven" / "Reason chain".

### 8.5 Multi-domain unification — substrate AND marketing thesis

The five verbs are topologically complete (SUBSTRATE.md §II); the
eight kernel primitives admit every domain's discipline as a
handler stack on the same graph. **DSP / ML / web / embedded /
control / data processing / docs / build / distributed / real-time
/ scientific computing / robotics / sensors — same substrate, same
kernel, one developer.**

The industry's domain-specialty fragmentation (frontend devs don't
do ML; ML devs don't do audio; audio devs don't do distributed)
is a consequence of language fragmentation. Mentl dissolves it.
A single Mentl developer can write audio in the morning, the web
app in the afternoon, the ML model in the evening, the embedded
firmware that night — all in ONE language with ONE medium that
speaks each domain natively. The medium adapts what it surfaces
based on which handlers are installed: DSP context → Sample/Tick/
Clock; ML context → autodiff handlers; Web context → DOM/Network/
IndexedDB; Embedded context → !Alloc + real-time + hardware
effects.

This is both a SUBSTRATE claim AND the marketing thesis. Surface
in DESIGN.md and README as both.

### 8.6 Collaboration is what `graph_handler` swap delivers (scoped)

When two transports `~>` over the same shared `graph_handler`, four
properties emerge as substrate consequences:

| Property | Substrate consequence |
|---|---|
| Real-time co-edit | Two transports → one `graph_handler`; atomic mutations; verify-arbitrated concurrent writes |
| Cursor presence | Each cursor IS a graph node (per Hμ.cursor); other users see them by reading the graph |
| Per-region RBAC | Effect row `+Mutate(region) - Read(other_region)` per user; row subsumption proves enforcement at handler install |
| In-session causal record | Reason chain entries (`Reason::AuthoredBy(user, cursor_pos, time)`) within session; Why tentacle walks them |

**Mentl does NOT replace git.** Git handles durable versioned
history, branches, merges, blame, distributed sync, signed commits,
ecosystem integration with non-Mentl tools. Building a Mentl-native
VCS would duplicate git with no compelling differentiator. Mentl
integrates with git via a thin `git_handler` bridge that synthesizes
commit messages from the Reason DAG on save and reads commits back
as Reasons on load. **`mentl blame` extends `git blame` with WHY**
(the Reason loaded from commit message) — git tells you who and
when; Mentl tells you why.

**Multi-user real-time collaboration is not a feature; it is what
the substrate delivers when shared.** Phase Z (post-μ) opens with
`Hμ.collab.shared-graph-handler`; walkthrough at
`docs/specs/simulations/COLLAB-shared-graph.md` (revised 2026-05-07
to scope to in-session + causal + RBAC + presence + git-bridge).
Five peer handles: shared-graph-handler, cursor-presence,
permission-row, transport-bridge, git-bridge.

### 8.7 CLI canonical (per EH-entry-handlers.md)

`mentl --with <handler>` is universal; subcommands are aliases
that resolve through env lookup like any other Mentl identifier.
Entry-handlers are normal `handler` declarations at top level in
`src/main.mn` (or any imported module) — no separate config file,
no manifest, no YAML / TOML / JSON.

| Bare invocation | Resolves to |
|---|---|
| `mentl` | `--with teach_run` (terminal voice surface) |
| `mentl edit [path] [--port=N]` | `--with edit_run` (canonical IDE per IE) |
| `mentl doc [target]` | `--with doc_run` (per F.1) |
| `mentl serve` | `--with lsp_run` (LSP transport on stdio) |
| `mentl compile <target>` | `--with compile_run <target>` |
| `mentl run <target>` | `--with compile_run + wasmtime` |
| `mentl check <target>` | `--with check_run <target>` |
| `mentl test [target]` | `--with test_run` |
| `mentl audit <target>` | `--with audit_run` |
| `mentl query <target> <q>` | `--with query_run` |
| `mentl repl` | `--with repl_run` |
| `mentl new <name>` | `--with new_project(name=<name>)` |

**Drift 38 sharpened**: fires on tentacle-named CLI verbs that
overlap at-cursor projections. Among the eight tentacles
(Query/Propose/Topology/Unlock/Trace/Verify/Teach/Why):
- `mentl teach` IS canonical (terminal voice surface for vim/
  terminal-only users; project-action verb).
- `mentl query` IS canonical (structured ad-hoc query;
  project-action verb).
- The six tentacle names that lack canonical CLI verbs (Trace, Why,
  Propose, Unlock, Verify, Topology — per CLI canonical §3.3) would
  be drift if used as `mentl <tentacle>` commands. Those projections
  fire at-cursor inside the medium, not as project-action verbs.
  <!-- drift-audit: ignore (intentional documentation of drift 38) -->

Project-action verbs are canonical; tentacle-as-namespace is drift.

---

## §9 · The fixed point — unsurpassability as closure under self-improvement

> *"Never surpassed" is not a quality bar. Quality bars are always
> beaten. It is a topological property: a medium is unsurpassable iff
> every possible improvement is a move WITHIN it, never a replacement
> OF it.*

A tool you can surpass is one whose means of improvement lives
*outside* it — to beat language X you write language Y, a new
compiler, a new IDE, a new model; you stand outside X and build its
successor. **The ultimate medium has no outside.** The compiler is a
handler on its own graph (self-hosting); the IDE is a projection
(§3.2, §4.3); the proof system is the kernel (§2.4 — refinement +
Verify); the oracle is IC plus one cached value
(`protocol_oracle_is_ic`); even the act of *designing* the medium is a
`<~` loop folding back into its seed (§3.4 — CLAUDE.md as feedback on
itself). Every lever that could build a better medium is already a
move inside this one. There is no vantage point from which to surpass
it — only growth from within.

The closure extends over proposers: every intelligence that might
out-design the medium is, by construction, a `Synth` handler inside
it (§8.4) — its strength accrues to the medium; its access to
execution runs through the kernel. And the claim itself is
kernel-shaped: exactly as `!E` proves the absence of a capability,
the fixed point proves the absence of an outside.
**Unsurpassability is `!Outside`** — the medium's own negation
primitive applied at topology altitude. One move, two altitudes.

This is a **fixed point**, and Mentl already exhibits its smallest
instance: **first-light** (`mentl2.wat == mentl3.wat`) is the medium
reproduced *exactly by itself*. First-light is not a build milestone;
it is the existence proof that the closure is real at the smallest
scale. Every capability folded into self-reproduction — types,
effects, proof, projection — widens the fixed point without ever
stepping outside it.

### 9.1 · The five collapses are one pattern

Everything §2–§4 describes is one move repeated: a distance prior
media charged the human to cross by hand, driven to zero because the
two sides turn out to be **one graph read two ways**.

| Collapse | The two sides become one read | Where |
|---|---|---|
| assert → **prove** | a claim and its proof are one refined type | §2.4, §8.4 |
| represent → **project** | source / IR / binary / docs / IDE / collab are one graph, N handlers | §4.3–4.8 |
| know → **not-know** | a full type and a free var are two points on one continuous gradient | §2.3 |
| now → **always** | this version and its successor are one self-hosting fixed point | §3.4, §5 |
| one mind → **many minds** | my cursor and yours are two reads of one shared graph | §8.6 |

The labor the medium eliminates is precisely the labor that was never
thought: re-proving the proven, re-deriving context, translating
between representations that were secretly identical. **What remains
for the human is the only thing that was ever theirs — the new
thought.** Everything downstream of it (proof, projection, memory,
sharing) the medium carries at zero marginal cost, continuously, at
the boundary of attention. That is how the medium raises the human:
not by doing the thinking, but by carrying everything that was never
thinking.

### 9.2 · The rung past μ — the medium projects *becoming*, not only *state*

Phase μ projects **state**: the graph as it is *now*, at the cursor.
The ultimate medium projects **becoming**: the graph's own
*evolution* — every edit, every proof, every Reason, across every
mind, across all time — is itself substrate one can hold attention
over.

Today "Why is it this way?" walks the Reason chain (§2.5). At the next
rung it walks the *temporal and inter-mind* chain too — back to the
moment, the person, and the proof that made it so. Version control,
collaboration history, and provenance are not features bolted on; they
are the graph gaining a **time axis and a multi-cursor**, read through
the same eight aspects. The session-continuity directive ("there is no
future session; only now") is this rung stated as discipline: the
medium folds its becoming into its present seed continuously, so the
past is never *elsewhere* — it is structure at the cursor.

When the medium remembers its own becoming across all minds it is no
longer a *programming-language* medium. Refinements are obligations;
Reasons are precedent; handlers are jurisdiction; the gradient is
hypothesis → theorem. The eight primitives are domain-general — they
describe any **structured thought with consequence** (law, math,
science, design). This is why "raises language design to never be
surpassed" and "raises humanity" stop being separate claims: the
category *programming language* dissolves into *language*, and the
medium is the fixed point of that dissolution.

In the master plan this rung is **Phase ν** — Stage 9 of
`~/.claude/plans/noble-greeting-dijkstra.md`. It gates on the collab
substrate (Phase Z / Stage 7), and it constrains every earlier stage
now: carried truth includes carried *history* — never discard a
Reason for being old, never make the trail unreadable, never design
a projection that assumes single-mind, single-time reads.

### 9.3 · The grain of sand

The smallest live decision in the compiler carries the whole thesis.
"Is a free type variable (`NFree`) at lower-time an error?" *is* "Does
the medium punish not-knowing, or represent the *degree* of knowing as
a gradient and flow the value anyway?" spec 05 invariant 2 ("`NFree`
is a compiler-internal error") is the last monomorphization-era
**binary** in the kernel — the last place the medium says "annotate
everything or fail" instead of "you are here on the gradient; here is
the single highest-leverage unlock." Resolving it toward the gradient
is not a bug-fix; it is collapse #3 (know → not-know) reaching the
type layer. Under uniform-i32, representation is invariant under type;
**type is a capability on the gradient, not a precondition for
existence.** The medium that never errs on honest not-knowing — that
flows the value and narrates the argmax — is the medium operating its
own thesis at the smallest scale.

---

## §10 · Cross-references — the doc loop

This document is the highest-altitude anchor. It cross-references
the substrate that supports it; the substrate cross-references back.

- `docs/DESIGN.md` — manifesto; eight primitives at §0.5; Mentl
  chapter at §8 (Mentl IS the projection)
- `docs/SUBSTRATE.md` — theorem set; §I kernel closure; §VI Cursor
  subsection (Cursor IS the gradient's global argmax); §VII oracle
  IS IC; §VIII the graph IS the program
- `docs/SYNTAX.md` — surface form; `??` as the developer's primary
  write-mode verb; eight-primitive surface mapping
- `CLAUDE.md` — discipline protocol; ⌁ Mentl's anchor (the eight
  interrogations); the nine drift modes; JIT triggers; Cursor
  projection paragraph
- `docs/specs/09-mentl.md` — Mentl spec; Cursor section
- `docs/specs/simulations/Hμ-cursor.md` — the keystone walkthrough
- `src/cursor.mn` — `cursor_default` handler (the projection
  itself, ~330 lines)
- `src/types.mn` — Cursor / CursorView / AnnotationSuggestion ADTs
- `src/mentl.mn` — Teach effect; gradient_next returning
  AnnotationSuggestion; mentl_default handler
- `~/.claude/projects/-home-suds-Projects-mentl/memory/protocol_cursor_is_argmax.md`
  — discipline crystallization (do not re-derive next session)
- `~/.claude/projects/-home-suds-Projects-mentl/memory/protocol_oracle_is_ic.md`
  — Mentl is IC + Pure-over-broader-input + one cached value
- `~/.claude/projects/-home-suds-Projects-mentl/memory/protocol_kernel_closure.md`
  — the next phase is composition, not invention
- `~/.claude/projects/-home-suds-Projects-mentl/memory/protocol_realization_loop.md`
  — the five-step recovery path when drift fires
- `~/.claude/projects/-home-suds-Projects-mentl/memory/protocol_mentl_is_not_an_llm.md`
  — Mentl is the kernel's MultiShot resume primitive made into a
  handler-on-graph; never frame as LLM
- `ROADMAP.md` — Phase μ section; Hμ.cursor + four named peer
  handles

---

## §11 · The closing statement

> Mentl is the **ultimate medium** between intent and execution.
>
> The kernel is whole. The projection is one handler. The cursor is
> attention. The loop closes at the human-medium boundary.
>
> Mentl IS Cursor IS the gradient argmax IS the graph projected for
> the human IS the program revealed where it's most ready to teach.
> All five names point to one thing.
>
> Eight kernel primitives. Eight Mentl tentacles. Eight interrogations.
> Eight aspects of one read. Eight sides on the `??` glyph. **The
> eight-fold lock is the substrate; nothing else is needed.**
>
> A tool can be surpassed; a fixed point can only be grown. Mentl is
> the fixed point of a medium improving itself — first-light is that
> closure at its smallest scale, and every collapse (assert→prove,
> represent→project, know→not-know, now→always, one mind→many) widens
> it from within. There is no outside from which to surpass it.
>
> The bus is on. What follows is the medium being put to work.
