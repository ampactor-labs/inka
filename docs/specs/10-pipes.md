# 10 — Pipes: the five verbs that draw topology

**Purpose.** The user-facing algebra of computation flow. Five
operators — `|>`, `<|`, `><`, `~>`, `<~` — together draw every
topological shape a computation graph can have: convergence,
divergence, parallel composition, side-channel observation, and
feedback. Effects + handlers + the Boolean row algebra make the
*semantics* universal; the five verbs make the *shapes* visible.

**Kernel primitive implemented:** #3 — The five verbs as a
topologically complete basis (DESIGN.md §0.5). Together with #2
(handlers with typed resume discipline — `~>` is handler-attach)
and #4 (Boolean effect algebra — pipe rules compose rows). `<~`
is the genuinely novel one; no other production language makes
feedback edges visible, typed, and optimizable at the syntactic
level. Mentl tentacle served: **Topology**.

**Research anchors.** DSP signal-flow graphs (Widrow, Oppenheim);
TensorFlow / PyTorch computation graphs; Koka pipe `x.f.g`; control-
theoretic block diagrams (feedback edges, informing `<~`); reactive
streams (RxJS, Akka).

---

## The five verbs

| Verb | Topology | Shape | Reading |
|---|---|---|---|
| `\|>` | converge | funnel right (∧→) | "flow forward, merge at narrowing" |
| `<\|` | diverge | fanout right (∨→) | "flow forward, split at widening" |
| `><` | parallel compose | cross (✕) | "two pipelines interact side-by-side" |
| `~>` | tee / handler-attach | side-channel (⌐) | "observe; install handler" |
| `<~` | feedback | loop-back (⟲) | "close a cycle; prior output re-enters" |

Every computation DAG you can draw on a whiteboard maps to one
expression in these verbs. Feedback loops close with `<~`; everything
acyclic uses the other four.

---

## Grammar (extends spec 03 `PipeKind`)

```lux
// ~> has ONE precedence (1, the loosest binary operator — the
// canonical table, SYNTAX.md §Precedence): the handler at the foot
// of a chain governs everything to its left. Layout is never
// semantics; block vs inline is the formatter's projection.
type PipeKind
  = PForward       // |>
  | PDiverge       // <|
  | PCompose       // ><
  | PTee           // ~>  handler-attach (one kind, one precedence)
  | PFeedback      // <~
```

Five variants; the Three Laws (2026-06-11) collapsed the former
PTeeBlock/PTeeInline layout split into one PTee — the precedence
table alone draws the tree.

---

## `|>` — converge

```
input |> stage1 |> stage2 |> output
(a, b, c) |> merge_fn   // merge_fn: fn(A, B, C) -> D
```

Data flows left-to-right; downstream takes upstream's output.
`|>` is a transparent wire — it passes whatever is on the left to
whatever is on the right. It does not unwrap tuples or repack values.

When `<|` or `><` produce a tuple `(A, B, C)` and the next `|>`
delivers it to `merge_fn: fn(A, B, C) -> D`, the inference engine
structurally unifies the tuple type against the function's parameter
list. Parameters ARE tuples. This is not "auto-splatting" — it is
the same structural unification that unifies `TInt` with `TInt`.
If `merge_fn` is defined as `fn(triple)` (one parameter), it receives
the tuple as a single value. The developer controls arity through
their function signature. No language rule needed.

- **Row:** `row(x |> f |> g) = row(x) + row(f) + row(g)`.
- **Ownership:** `own` consumed-and-moved per stage.

## `<|` — diverge

```
input |> preprocess <| (branch_a, branch_b, branch_c) |> merge
```

One upstream → parallel copies to each branch; subsequent `|>`
converges via tuple.

- **Concurrency:** deterministic-sequential by default; a `Parallel`
  handler (future F arc) switches to concurrent evaluation. Source
  unchanged.
- **Row:** union of all branch rows + upstream row.
- **Ownership:** `own` CANNOT pass through `<|` (affine violation;
  emits `E_OwnershipViolation`). `ref` borrows per branch. Pure values fan out by copy.

## `><` — parallel compose

```
(source_a |> refine_a) >< (source_b |> refine_b) |> merge
```

Two pipelines run as peers, outputs tupled. ✕ shape.

- **Uses:** stereo DSP (L >< R); independent ML sub-networks;
  parse-header >< parse-body.
- **Row:** union. `row(p >< q) = row(p) + row(q)`.
- **Ownership:** independent branch contexts; no crossover.

---

## `~>` — tee / handler-attach (side-channel observation)

```
input |> process1 |> process2 ~> logger |> output
```

`~>` attaches a handler to everything to its left in the
expression — the one law. Narrow scope is parens, visible at the
site: `(stage ~> h)`.

### One form

```
input
    |> p1 |> p2 |> p3
    ~> h1       // h1 governs (input |> p1 |> p2 |> p3)
    ~> h2       // h2 wraps h1(...)
    ~> h3       // h3 wraps h2(...)

input |> (p1 ~> h1) |> (p2 ~> h2)   // per-stage scope: parens
```

**Parser rule.** `~>` is precedence 1, the loosest binary operator,
left-associative. No layout sensitivity exists anywhere in the
grammar.

**Semantics.** `expr ~> h` ≡ `handle expr with h`. If `h` is a
function value, it's applied to `expr`'s result. The handler-is-a-
function unification means `~>` serves observation and effect-
handling without syntactic distinction.

- **Row:** `row(expr ~> h) = row(expr) - handled(h) + row(h)` (spec 01).
- **Ownership:** `~>` does not force consumption; handler arms decide.

---

## `<~` — feedback (close a cycle)

```
input |> add(a) <~ delay(1, init=0) |> output
```

`<~` places a FEEDBACK EDGE from the right side's output back into
the left side's input. In the example: `add(a)`'s output is
delayed by 1 (initial value 0) and fed back as `add`'s second
argument on the next iteration.

### Desugaring

`<~` is sugar for a stateful handler capturing output and re-injecting
it on the next iteration. RHS is a *feedback specifier*. The feedback
edge closes to the stage immediately left of `<~`; group with parens
to close further back.

```lux
// surface:   y = x |> f <~ delay(1, init=0)
// desugars:  handler h with state = 0 {
//              pull() => resume(state),
//              push(v) => resume(()) with state = v
//            }
//            handle iterate(x, |cx| { let fb = perform pull()
//                                     let out = f(cx, fb)
//                                     perform push(out); out }) with h
```

### Feedback specifiers (standard library)

- `state(init=v)` — no delay; feedback is the previous output.
- `delay(n, init=v)` — n-tick delay; feedback is output from n
  iterations ago.
- `filter(f, init=s)` — feedback passed through a filter function.

Library functions returning handler records; `<~` installs them.

### Iterative context — required

`<~` requires a stream context: an `Iterate` handler (spec 06) or a
`Clock` / `Sample` / `Tick` handler (spec 11). Absence is a type
error (`E_FeedbackNoContext`, reserved).

- **Row:** `row(x |> f <~ spec) = row(x) + row(f) + row(spec) + Iterate-or-Clock`.
- **Ownership:** `own` can't feed back (consumed each iteration).
  `ref` if stable across iterations. Pure values: the common case.

### Handler-dependent timing (spec 11)

`<~ delay(1)` means one UNIT of delay; the unit is the handler's
choice:
- Under `Sample(44100)` → one sample delay (classic IIR).
- Under `Tick` → one logical step (iterative algorithms).
- Under `Clock(wall_ms=10)` → 10 ms (control loops).

One operator; topology-only semantics; handler decides timing. Mentl
solves Mentl.

---

## Precedence and layout

One canonical table (SYNTAX.md §Precedence), loosest-to-tightest
among the verbs:
1. `~>` (handler-attach; the floor — governs everything to its left)
2. `<|` `><` `<~` (the convergent/divergent verbs)
3. `|>` (converge; tightest verb, looser than all value operators)

Parentheses override. A continuation line starting with a pipe
operator attaches to the previous expression's result — that is
token continuation, never semantics. **Layout is never semantics**
(the Three Laws, 2026-06-11): the parser has one table; the
formatter owns the shape on the page.

---

## Error propagation

`Fail<E>` is an effect. Its propagation through pipes is governed by
the effect algebra (spec 01), not pipe-specific rules:

- `|>`: Fail propagates forward; downstream stages don't run. Handler
  installed via `~>` or outer `handle` absorbs.
- `<|`: Fail in one branch surfaces at the `|>` convergence site.
  The converging stage receives a tuple with Fail variants OR the
  pipeline short-circuits — handler decides.
- `><`: Independent; each side can fail separately. Outer handler
  composes.
- `~>`: Handler arm failure propagates outward (handler is installed
  inside a larger scope).
- `<~`: Failure in the feedback edge terminates iteration (same as
  any Iterate handler's termination condition).

---

## Consumed by

- `03-typed-ast.md` — `PipeKind` extended with `PFeedback`.
- `04-inference.md` — pipe expressions infer effect rows per above.
- `05-lower.md` — pipes lower to function calls (`|>`, `<|`, `><`) or
  handler installs (`~>`, `<~`).
- `06-effects-surface.md` — `Iterate`, `Clock`, `Sample` inventory
  interacts with `<~` iterative-context check.
- `09-mentl.md` — Mentl's teach tentacle renders pipe topologies
  visually; `teach_gradient` surfaces "add a `~>` logger here" as an
  unlock suggestion.
- `11-clock.md` — time-indexed `<~` interpretation.

---

## Rejected alternatives

- **Symmetric `<~` as mere reverse-tee.** Decoration without new
  power. Feedback semantics earn the operator's keep.
- **Per-verb custom precedence.** Over-engineered. Five verbs, one
  precedence table, one layout rule — enough.
- **Feedback as a named effect only (no operator).** Hides the
  topology inside handler declarations; user can't SEE the cycle.
  The whole point of the five-verb algebra is topology-on-the-page.
- **Separate feedback operator per timing (`<~1`, `<~s`, `<~t`).**
  Timing is the handler's concern, not the operator's. One `<~`;
  handler decides.
- **`><` as function composition (`f ∘ g`).** That's just `g |> f`
  with different reading direction. `><` is reserved for the `✕`
  topology — two parallel pipelines, not sequential composition.
- **Layout-sensitive parsing, for any verb.** An operator whose
  meaning changes with a newline is invisible action-at-distance;
  the Three Laws (2026-06-11) deleted the last instance (the old
  `~>` Form A/B split). One precedence table draws every tree;
  the formatter projects the layout.
