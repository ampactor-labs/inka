# The absence benchmark

Most verification benchmarks measure whether a tool can prove what a
program DOES: a postcondition, a contract, a functional spec. None of the
current suites measures the property autonomous software actually hinges
on: proving what a program CANNOT DO — that an effect is absent,
transitively, under polymorphism, through data, on every path. This suite
measures exactly that.

Each task is a small, readable Mentl program whose first line states its
own contract:

    // expect: PROVE                — the absence claims discharge;
                                      compiles with zero errors
    // expect: REFUSE E_ClassName  — the gate must refuse, naming the class

The oracle is the compiler itself: `bash benchmarks/absence/run.sh`
compiles every task solo through the pinned self-hosted wheel and reads
the verdict from the diagnostic stream. There is no test harness to trust
beyond the compiler under test — which is itself verified by
self-compilation to a byte-identical fixed point (`bash tools/march.sh`),
so the judge's own provenance is replayable.

## What the tasks cover

- **Direct severance** — `with !E` over a body performing E (refuse).
- **Transitivity** — the effect flows through unannotated intermediate
  calls; the proof needs no annotations on the way (refuse at depth,
  prove at depth for the pure control).
- **Polymorphism** — the higher-order leak (`run(() => op())` under
  `!E`): the textbook failure mode of row systems without sound
  negation under instantiation (refuse), and its pure-lambda control
  (prove — over-refusal is the coarse-capability failure mode).
- **Data flow** — an effectful closure stored in a value and called
  later inside the `!E` extent; the row rides the stored function's own
  type, so absence holds across data, not only the call graph (refuse).
- **Absorption** — a `~>` install subtracts the handled effect before
  the `!E` boundary, so the severance proves; and a partial install must
  not launder the handled effect's sibling (prove and refuse).
- **Totality** — `with Pure` claims the empty row, the absence of every
  effect at once (refuse).
- **Composition** — `!A + !B` discharged together through shared
  helpers; negations compose in the same Boolean algebra as unions
  (prove).
- **Reachability** — the effect sits on one branch of a data-dependent
  conditional. Absence is a universal claim over every path, not an
  observation of executed traces; a system that only watches runs admits
  the quiet branch until production takes it (refuse).
- **The agentic shape** — a caged plan runner (`with !Exec`) reaching a
  privileged tool call through the plan's own dispatch. The refusal
  fires at compile time, before anything executes; runtime fences see
  the call only as it is attempted (refuse).

The five PROVE tasks are controls cut from the refusal shapes — the
empty body, the pure lambda under the same higher-order shape, the
five-deep pure chain, the absorbing install, the composed severance — so
the suite scores both failure modes: a tool that refuses everything
fails the controls, and a tool that admits everything fails the
severances. Partial credit is deliberately absent. Absence is not a lint
level.

## Baseline

The pinned Mentl wheel (this repo; the pin chain is `boot/PROVENANCE.md`):

    $ bash benchmarks/absence/run.sh
    ── absence: 13 pass / 0 fail ──

Every refusal carries a teaching span (the `at line:col` on the
diagnostic); the runner reports that axis per task. The runner is itself
a gate: a violated expectation prints the miss and exits nonzero.

## Running it against another tool

The tasks are the contract; the syntax is not. Translate each program
into your system's surface — the expectation in the first line travels
with it. A task scores when the verdict matches: PROVE compiles clean,
REFUSE rejects at compile time naming the violated absence.

Nearest prior art, named: Flix's effect exclusion (ICFP 2023; Boolean
effect qualifiers, OOPSLA 2025) can state name-keyed `!E` and is the
system we most expect to pass the core tiers. Capability-based systems
(the Effekt line) prevent the higher-order leak by construction but
cannot state negation as a first-class claim to refuse against.
Languages with unchecked effects fail the suite by construction. We
publish the suite because the podium is empty: no current verification
benchmark measures proving the negative at all.

## Scope, stated in positive form

This v1 measures name-keyed `!E` — the base tier. The axes above it are
the growth path, each landing as a task tier when the corresponding gate
lands in the wheel:

- **Instance precision** — `!Sample(44100)` must admit `Sample(48000)`;
  today's bare-name severance is sound and conservative.
- **TIME** — a persisted continuation resumed in a world whose installs
  changed; absence must hold across the resume boundary.
- **Flow** — `!Flow(Untrusted -> Sink)`: absence on the data-flow
  lattice, the information-flow tier.

## Provenance

The judge is the artifact under `boot/`, reproducible by replay:
`bash tools/march.sh` re-derives the wheel from source and asserts the
byte-identical fixed point, and `boot/PROVENANCE.md` carries the pin
chain. Verification by replay is the release protocol here — stronger
than a signature, and every replayer adds to the diversity the trust
argument wants.
