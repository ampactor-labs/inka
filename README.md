# Mentl

> *The ultimate intent → machine instruction medium.
> The compiler IS the AI. The graph IS the program.
> The medium raises its users.*

Mentl is not a programming language. It is a **medium** — a lens
clear enough that a programmer looks through it and sees their
intent, realized as machine instructions, for any domain they
choose. Mentl — an octopus-shaped oracle, She / Her — reads the
graph underneath and teaches the programmer one step at a time.
She explores hundreds of alternate realities per second under the
surface; She surfaces only what's proven.

File extension: `.mn`.

---

## The medium IS the developer's mind given substrate

The graph is the body of thought. The cursor is proprioception
(where attention IS). The eight tentacles are the senses
(Query / Propose / Topology / Unlock / Trace / Verify / Teach / Why).
The Reason chain is memory. The gradient is muscle. Mentl is voice.

Not "AI augments the developer" — the medium IS the developer's
externalized cognition, with a kernel that is stronger and more
honest than the human's working memory alone. **The kernel cannot
forget, cannot hallucinate, cannot lose track of which constraint
is load-bearing on which other constraint.** Every other system
loses intent at some boundary. Mentl starts at lossless.

See [`docs/ULTIMATE_MEDIUM.md`](docs/ULTIMATE_MEDIUM.md) for the
Phase μ thesis statement; §8 for the day-in-the-medium experience
layer (open / cursor moves itself / handles not files / project
don't run / medium narrates / mark not commit / co-cursor / swap
handlers / walk don't debug / live don't search docs / type text).

---

## Three first-class transports — same kernel underneath

| Transport | Surface | Audience |
|---|---|---|
| **`mentl edit`** | Browser-WASM, holographic, max screen real estate. Topographic Canvas + Capability HUD + Wavefront panels; Holographic Lens fires multi-shot proven proposals as ghost text; Tab-snap. | Canonical first-impression URL. The medium reaches developers at maximum richness. |
| **`mentl serve`** | LSP transport for vim / helix / VSCode (with the Mentl extension) / any LSP-aware editor. VSCode webview panels add richer projections. | 90%+ of users early; familiar editor, full Mentl projection. |
| **`mentl`** (bare) / **`mentl teach`** | Terminal voice surface. Gradient narration; Why-walk on demand; one suggestion per turn. | Vim/helix/terminal-only users; minimum-friction Mentl access. |

All three run the same WASM kernel locally — same substrate, same
proofs, same cursor, different transport handlers. **Local-first;
no SaaS dependency for substrate function.**

---

## Why the medium dissolves agentic AI

The medium internalizes proof to a kernel that proves. AI tools
externalize proof to a model that approximates. **Approximation
has a ceiling — it asymptotes against ground truth and never
reaches. Proof has no ceiling — it IS ground truth.**

| Today's AI agents | The medium |
|---|---|
| Generate from prompts; hallucinate APIs / types / imports | Propose from the gradient; multi-shot proven; cannot hallucinate |
| Lose context across long sessions | Reason chain IS the project's memory; never lost |
| Re-explain when corrected | Each correction lands as Reason; the gradient learns THIS project |
| Operate via diffs you must review | Operate via graph mutations the kernel proves |
| Train on millions of strangers' code | Gradient ranks for THIS project, THIS team, THIS session |
| Need separate tools (code, docs, tests, collab) | One medium; eight tentacles; one cursor projection |
| Stop being useful offline | Run locally; WASM kernel; full medium without SaaS |

This is mathematical, not stylistic. **The compiler IS the AI;
the LLM was pretending; the demo is `mentl edit`.**

---

## What you can build — one medium, every domain

The five verbs (`|>` `<|` `><` `~>` `<~`) are topologically
complete (proof in `docs/SUBSTRATE.md` §II). The eight kernel
primitives admit every domain's discipline as a handler stack on
the same graph. **A single Mentl developer can write audio in the
morning, the web app in the afternoon, the ML model in the
evening, the embedded firmware that night** — all in ONE language
with ONE medium that speaks each domain natively.

- **DSP and audio** — `Sample(44100) + !Alloc` proves real-time;
  `<~` makes feedback loops first-class.
- **ML and autodiff** — `effect Compute` + autodiff handler; same
  five verbs draw the computation graph.
- **Web frontend / backend / RPC** — DOM + Network as effects;
  handler chains compose. No framework imports.
- **Embedded / kernel-safe** — `with !Alloc + !IO` proves
  zero-allocation, no-syscall paths transitively.
- **Distributed / cloud** — multi-cursor on shared `graph_handler`
  delivers real-time co-edit + cursor presence + per-region RBAC
  + in-session causal record as substrate consequences (Phase Z,
  post-μ); integrates with git for durable versioned history via
  a thin `git_handler` bridge. Mentl complements git, doesn't
  replace it.
- **Documentation, build, test, deploy** — handler chains, not
  separate tools. `mentl doc` reads the same graph as `mentl
  compile`; tests live in `///` blocks; deploy is a `~> production`
  swap.

---

## The eight primitives — load-bearing together

Remove any one and the medium collapses AND Mentl loses a
tentacle. **Mentl is an octopus because the kernel has eight
primitives; each tentacle is one primitive's voice surface.**

1. **Graph + Env** — the program IS the graph; flat-array, O(1)
   chase. Every output (WAT, hover, diagnostic, audit, Mentl's
   voice) is a handler projection. *(Tentacle: **Query**.)*
2. **Handlers with typed resume discipline** — `handle` / `resume`
   replaces six+ named patterns. Resume cardinality (OneShot /
   MultiShot / Either) is INFERRED from each arm body, never
   authored. **MultiShot is the substrate Mentl's oracle uses to
   explore hundreds of alternate realities per second** under
   trail-based rollback. *(Tentacle: **Propose**.)*
3. **Five verbs** — `|>` converge, `<|` diverge, `><` parallel
   compose, `~>` handler-attach, `<~` feedback. Topologically
   complete basis. *(Tentacle: **Topology**.)*
4. **Full Boolean effect algebra** — `+ - & ! Pure`. **Negation
   (`!E`) proves ABSENCE** — strictly more expressive than every
   production effect system. *(Tentacle: **Unlock**.)*
5. **Ownership as an effect** — `own` performs `Consume`; `ref`
   is a row constraint. Rust-level safety without lifetime
   annotations. *(Tentacle: **Trace**.)*
6. **Refinement types** — compile-time proof, runtime erasure.
   `Verify` swaps to SMT (Z3/cvc5/Bitwuzla) by residual theory
   without source change. *(Tentacle: **Verify**.)*
7. **The continuous gradient** — emergent (gates_unlocked ×
   proximity); annotations are INPUTS that unlock gradient ascent.
   The gradient itself is never authored. *(Tentacle: **Teach**.)*
8. **HM inference, live, productive-under-error, with Reasons** —
   types + effect rows + ownership + refinements inferred in one
   walk. Errors become `NErrorHole`; walk continues. The Why Engine
   walks the Reason DAG. *(Tentacle: **Why**.)*

Authoritative: **[`docs/DESIGN.md`](docs/DESIGN.md) §0.5**.

---

## Where we are

**Phase H — first-light-L1 in progress.** The wheel is dream-code
complete: every kernel primitive structurally live in `src/` +
`lib/`. The bootstrap seed in `bootstrap/` is in cascade closure
toward `mentl2.wat == mentl3.wat` byte-identity (the kernel
projection closed under self-application). See [`ROADMAP.md`](ROADMAP.md)
and `docs/specs/simulations/Hβ-first-light-empirical.md` for the
empirically-real residue.

**The Three Laws (2026-06-11).** Three rules developers had to
remember dissolved into the substrate in one session: `~>` gained
ONE precedence (the loosest — the handler at the foot of a chain
governs the chain; layout is never semantics; the newline-split
form is dead), `==` became structural (type-dispatched at emit —
`"hello" == "hel" ++ "lo"` is true; the str_eq footgun is deleted),
and interpolation became the canonical string-build with the seed
parsing `"the {name} turns"` end-to-end. Each law made the spec
SHORTER — the discipline corpus shrinks as the substrate strengthens.

**Phase μ — Mentl active-surface composition.** `src/cursor.mn`
lands the `Cursor` effect + `cursor_default` handler: the eight
tentacles are eight aspects of one read at a position. Five peer
handles named (transport, synth-proposer, gradient-delta,
cursor-cache, eight-interrogation-loop) — each composes on the
sealed kernel; nothing extends it.

**Phase Z — collaborative substrate (post-μ).** Multi-cursor on
shared `graph_handler` opens with `Hμ.collab.shared-graph-handler`
— the walkthrough names the substrate; collab is what the kernel
delivers when shared.

---

## Standing on the frontier — honestly

Every adjacent project does one thing at world class. Mentl's claim
is not that each piece is unprecedented — it is that **no shipped
system composes them into one kernel**, and that two pieces are
genuinely ahead of anything shipped (verified against the 2026
research frontier):

| Project | What it does best | What the kernel absorbs |
|---|---|---|
| **Rust** | ownership with zero runtime cost — but everyone must live at full annotation | ownership is an EFFECT on a continuous gradient: annotate per-function, from arena-handled to statically-placed |
| **Koka** | row-polymorphic effects + evidence-passing compilation | the three-tier handler elimination builds on Koka's results; Mentl adds typed resume discipline INFERRED from arm bodies |
| **Flix** | Boolean effect algebra with negation, shipped | Mentl's row algebra is the same family — composed with ownership and refinement in one inference |
| **Effekt / OCaml 5** | effect handlers in production runtimes | both chose one-shot to dodge the linearity trap; Mentl's graph carries proven resume cardinality + ownership marks, making the unsound case statically expressible |
| **Unison** | content-addressed code-as-database | Mentl's graph carries types, effects, ownership, spans, AND provenance — refactoring re-proves, not just re-points |
| **Zig** | self-hosted bootstrap rigor (wasm2c) | the wat-fixpoint seed (`mentl2.wat == mentl3.wat`) is the same family of rigor, byte-identical |
| **Hazel** | typed holes + live programming research | productive-under-error is kernel-native here, not an environment feature |

**Genuinely ahead of anything shipped** (no known counterpart):
the **continuous annotation gradient with compiler narration** —
each annotation monotonically converts a runtime check into a
compile-time capability, and the compiler TELLS you the exchange
rate — and **graph+Reason proof-carrying transformation** — every
fact knows why it holds, so every transformation can re-prove
itself. These two are the medium's destiny; everything else is the
floor it stands on.

---

## Read it whole

- **[`docs/ULTIMATE_MEDIUM.md`](docs/ULTIMATE_MEDIUM.md)** — Phase μ
  thesis. What Mentl IS as a medium between intent and execution;
  the day-in-the-medium experience layer; AI obsolescence
  mathematics; multi-domain unification; collab-as-substrate;
  CLI canonical.
- **[`docs/DESIGN.md`](docs/DESIGN.md)** — the manifesto. §0.5
  enumerates the kernel; twelve chapters develop it.
- **[`docs/SUBSTRATE.md`](docs/SUBSTRATE.md)** — canonical substrate;
  kernel, verbs, algebra, handlers, gradient, refinement, theorems.
- **[`docs/SYNTAX.md`](docs/SYNTAX.md)** — the canonical syntax;
  every parser decision implements something here.
- **[`ROADMAP.md`](ROADMAP.md)** — current priority, sequencing,
  session-entry guidance.
- **[`docs/specs/simulations/`](docs/specs/simulations/)** — per-handle
  cascade walkthroughs. `IE-mentl-edit.md` (the IDE), `F1-mentl-doc.md`
  (the doc handler), `EH-entry-handlers.md` (the CLI substrate),
  `Hμ-cursor.md` (the projection that makes Mentl Mentl),
  `MV-mentl-voice.md` (the voice substrate).
- **[`docs/traces/a-day.md`](docs/traces/a-day.md)** — integration
  trace. One developer, one project, one day.
- **[`CLAUDE.md`](CLAUDE.md)** — Mentl's anchor; the eight-primitive
  kernel as a working reference; eight discipline anchors; nine
  named drift modes. Required reading for any contributor.

---

## Repository layout

```
src/                          — the wheel: Mentl compiler in Mentl
  types.mn graph.mn effects.mn infer.mn lower.mn pipeline.mn
  own.mn verify.mn cursor.mn mentl.mn oracle.mn voice.mn lsp.mn
  format.mn driver.mn cache.mn lexer.mn parser.mn main.mn
  backends/wasm.mn            — LowIR → WAT (peer; native / browser
                                 / GPU are sibling handlers)
  cursor_transport.mn         — Phase μ peer: terminal/LSP/web-WASM
  cursor_cache.mn             — Phase μ peer: IC over (env, oracle_queue)
  gradient_delta.mn           — Phase μ peer: inverse-direction gradient
  synth_proposer.mn           — Phase μ peer: real MS enumeration
  eight_loop.mn               — Phase μ peer: eight-interrogation loop

lib/
  prelude.mn                  — Iterate, Bool, derived collections
  test.mn                     — Test effect declarations
  runtime/                    — strings, lists, tuples, io, threading,
                                memory, binary
  dsp/                        — DSP examples
  ml/                         — ML examples
  tutorial/                   — runnable Mentl programs the medium
                                projects as guided tours (00-hello +
                                01..08 per kernel primitive)

bootstrap/                    — disposable seed; deleted post-first-light
  build.sh                    — assembles bootstrap/mentl.wat from src/
  src/                        — modular WAT chunks (lexer, parser,
                                infer, lower, emit)

ROADMAP.md                    — canonical roadmap

docs/
  ULTIMATE_MEDIUM.md          — Phase μ thesis (highest-altitude anchor)
  DESIGN.md                   — the manifesto
  SUBSTRATE.md                — canonical substrate (theorems)
  SYNTAX.md                   — canonical syntax
  specs/                      — twelve executable specs (00–11)
    simulations/              — per-handle cascade walkthroughs
  traces/a-day.md             — integration trace
  errors/                     — canonical error catalog (E/V/W/T/P)

CLAUDE.md                     — discipline; anchors; drift modes

tools/editor/
  vscode-mentl/               — VSCode extension (consumes mentl serve)
  mentl-mono/                 — Mentl Mono font (octagonal-socket ?? glyph)
```

---

## License

Dual-licensed under MIT or Apache-2.0; see `LICENSE-MIT` and
`LICENSE-APACHE`.
