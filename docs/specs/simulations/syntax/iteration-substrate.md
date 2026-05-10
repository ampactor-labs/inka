# Iteration Without `for` — Substrate Walkthrough

> *Walkthrough #5 of the SYNTAX-ULTIMATE audit per `protocol_realization_loop.md`. Confirms the no-`for`-keyword discipline against ergonomic objection; documents the substrate-honest forms (verbs + handlers + stdlib) that subsume every iteration pattern. Locks the rationale: the discipline IS the experience.*

## §0 — Why this walkthrough exists

`SYNTAX.md` §"Token enumeration" line 1317-1320 states:

> Note: `loop`, `break`, `continue`, `return`, `for`, `in` are NOT reserved keywords — Mentl has no imperative control flow constructs. Iteration is via `|>` + `<~` + `Iterate` effect handlers. Early-exit is via `Abort` effect + `catch_abort` handler.

This is one of Mentl's most radical syntactic decisions. EVERY mainstream language has `for`/`while`/`break`/`continue`. Removing them is bold. The question this walkthrough answers: is the absence substrate-honest or ergonomically hostile?

The answer must hold against the eight interrogations. If the substrate (verbs + handlers + stdlib) genuinely subsumes every iteration pattern AND the gradient teaches the substrate at the friction-point, the absence IS the residue. If the substrate has gaps OR teaching is impossible, the absence becomes a punishment.

This walkthrough confirms: the substrate is complete; the gradient teaches; the discipline holds.

## §1 — Empirical state

Three observations:

1. **The wheel uses zero imperative loops.** All iteration is through `|>` + recursion + handlers. The wheel COMPILES this way; the discipline is empirically tractable for compiler-class code.

2. **The proposed friction surface is shorter than expected.** Domain users (DSP, ML, AI) are FP-comfortable; `[1,2,3] |> map(double)` reads natively. The "I need a `for` loop" objection comes mostly from imperative-language transferees, who are NOT Mentl's target audience.

3. **The substrate is operationally complete.** `for_each`, `map`, `filter`, `fold`, `range`, `indexed`, `take`, `until`, `<~`, `Iterate` handler — every iteration pattern is expressible. No gap forces the user into awkward forms.

## §2 — The eight interrogations on iteration

### 1. Graph?

Iteration is a recursion-or-handler pattern in the graph. `|> map(f)` is `LCall(map, [list, f])`. `<~ accumulate(0)` is `LFeedback(handle, body, FeedbackSpec(...))`. `Iterate` handler installs `LHandleWith(handle, body, iterate_handler_record)`. Each form has an explicit graph node — iteration is FIRST-CLASS, not implicit syntax sugar.

### 2. Handler?

`Iterate` effect (`yield(value)`, `halt`, `skip`) is the canonical iteration handler. `for_each` is a handler instance over `Iterate`. `take`, `filter`, `map` are handlers that interpose. Each iteration handler has resume cardinality inferred from arm body (typically OneShot for sequential map; MultiShot for backtracking/fanout).

### 3. Verb?

All five verbs participate:
- **`|>`** sequential: `xs |> map(f) |> filter(g) |> for_each(side_effect)`
- **`<|`** divergent: `xs <| (extract_a, extract_b, extract_c)` — one input, multiple extractions
- **`><`** parallel: `(xs |> map_a) >< (ys |> map_b)` — independent iterations in parallel
- **`~>`** handler attach: `body ~> Iterate handler` — interpose iteration semantics
- **`<~`** feedback: `signal <~ delay(N)` — iterative state in DSP / control flow

The five verbs SUBSUME every iteration pattern. The user types verbs + stdlib calls; no `for` keyword needed.

### 4. Row?

Each iteration form carries the union of body row + handler row. `xs |> for_each((x) => perform log(x))` has `IO + Memory + Alloc`. `xs |> map(double)` is `Memory + Alloc` (allocates new list). The row is uniform with the rest of Mentl — iteration introduces no new row category.

### 5. Ownership?

Per-iteration: the body's parameter is `ref` by default (borrowed from the collection). For collection construction (map, filter), the result is `own`. For side-effect iteration (for_each), no result. Ownership is type-driven, not iteration-construct-driven.

### 6. Refinement?

Iteration counts compose: `range(0, n) |> for_each(f)` runs `n` times. `take(k, infinite_stream)` runs `k` times. Refinements on bounds (e.g., `range(0, n: NonNegative)`) propagate through. `<~ accumulate(initial)` runs forever (or until the surrounding context ends).

### 7. Gradient?

The gradient at an iteration site narrates: "you are mapping `f` over `xs`; the result is a fresh list with the same length as `xs`; allocation is `Memory + Alloc`." The narration uses the verb-and-handler vocabulary directly; `for` would obscure the substrate.

When a user (especially a transferee) types `for x in xs` or `loop`, the gradient surfaces a Quick Fix:
- `for x in xs { body }` → `xs |> for_each((x) => body)`
- `loop { body }` → `body ~> iterate_forever_handler` + suggest `Abort` for break
- `break` in a body → suggest `perform abort()` with `~> catch_abort`

The teaching IS the gradient — the user learns the substrate by typing the friction shape and accepting the suggestion.

### 8. Reason?

Each iteration site leaves `Located(span, IterateProjection(handler_kind))` with a Reason chain back to the verb and handler. The Why Engine walks back through the iteration's structure to surface the user's authored intent.

## §3 — The ULTIMATE form

Mentl has NO iteration keywords. The five verbs + stdlib functions + Iterate handler express every iteration pattern. SYNTAX.md confirms this and the gradient teaches it.

### Canonical iteration patterns

| Pattern                       | Substrate form                                       |
|-------------------------------|------------------------------------------------------|
| Sequential map                | `xs \|> map(f)`                                      |
| Filter                        | `xs \|> filter(pred)`                                |
| Fold / reduce                 | `xs \|> fold(initial, f)`                            |
| For-each (side effects)       | `xs \|> for_each(f)`                                 |
| Range iteration               | `range(start, end) \|> for_each(f)`                  |
| Indexed iteration             | `xs \|> indexed \|> for_each(((i, x)) => ...)`       |
| Take N                        | `xs \|> take(n)`                                     |
| Drop N                        | `xs \|> drop(n)`                                     |
| Until predicate               | `xs \|> take_while(pred)`                            |
| Early-exit                    | `xs \|> for_each(f) ~> catch_abort` (perform abort)  |
| Infinite iteration            | `state <~ iterate_forever(step)`                     |
| Stateful iteration            | `state <~ accumulate(initial, step)`                 |
| Parallel iteration            | `(xs \|> map_a) >< (ys \|> map_b)`                   |
| Generator-style yield         | `body ~> collect_via_iterate` (uses Iterate effect)  |
| Custom iteration semantics    | `body ~> custom_iterate_handler` (per-domain)        |

Each pattern is one or two verbs + a stdlib function. No keyword required.

### What's NOT supported (and why)

- **`for x in xs { body }` as a keyword form.** Rejected per the discipline. The gradient suggests the verb form.
- **`while (cond) { body }`.** Rejected; use `<~ iterate_while(cond, step)` or recursion.
- **`break` / `continue` as keywords.** Rejected; use `Abort` effect + `catch_abort` handler.
- **`return` as keyword for early-fn-exit.** Rejected; functions return their final expression. For early exit, restructure with `match` or use Abort.

### The teaching layer

When a user types a keyword shape, the gradient surfaces a Quick Fix:

```
fn process(xs) = {
  for x in xs { perform log(x) }     // E_NotAKeyword: 'for' is not a Mentl keyword.
                                      //   Quick Fix: rewrite as xs |> for_each((x) => perform log(x))
}
```

The friction is converted to learning. The user who types `for` learns the verb form within one keystroke + Quick Fix accept.

The teaching is not punishment — it's the gradient ascending. After 3-5 such Quick Fixes, the user types verbs natively. The discipline becomes habit.

## §4 — Substrate cascade

### 4.1 — `lib/prelude.mn` and `lib/runtime/`: stdlib completeness

Audit the canonical iteration functions are exported and documented:

- **`for_each(list, fn)`** — sequential map for side-effects (no result list)
- **`map(list, fn)`** — sequential map producing new list
- **`filter(list, pred)`** — produces filtered list
- **`fold(list, initial, fn)`** — left-fold
- **`fold_right(list, initial, fn)`** — right-fold
- **`take(list, n)`** / **`drop(list, n)`** / **`take_while(list, pred)`**
- **`range(start, end)`** / **`range_step(start, end, step)`**
- **`indexed(list)`** — pairs each element with its index
- **`zip(xs, ys)`** / **`zip_with(xs, ys, f)`**
- **`flat_map(list, fn)`** — bind / monadic flatMap
- **`partition(list, pred)`** — (matches, non_matches)

Confirm each has `///` docstrings; Mentl's voice surfaces them when the user hovers/queries.

### 4.2 — `Iterate` effect declaration

Confirm `Iterate` effect is declared with substrate-honest operations:

```
effect Iterate<A> {
  yield(value: A)         // produce a value at the iteration cursor
  halt()                  // terminate iteration immediately
}
```

`for_each` is the canonical handler:

```
handler for_each_handler<A>(consumer: A -> () with E) {
  yield(v) => { consumer(v); resume(()) }
  halt()    => ()           // discard continuation; iteration ends
}
```

Generator-style:

```
fn collect(body) with !Memory + !Alloc = {
  let buf = make_list(8)
  let count = 0
  (buf, count) <~ accumulate(...)
  ~> handler {
    yield(v) => {
      let new_buf = list_extend_to(buf, count + 1)
      let new_buf' = list_set(new_buf, count, v)
      resume(()) with buf = new_buf', count = count + 1
    }
    halt() => ()
  }
  body()
  slice(buf, 0, count)
}
```

The `Iterate` substrate covers ALL iteration patterns. Custom handlers (per-domain iteration with backtracking, multi-shot, parallelism) compose on top.

### 4.3 — Gradient teaching: keyword suggestion handler

When parser encounters `for`, `while`, `loop`, `break`, `continue`, `return`, the diagnostic surfaces Quick Fix:

```
match keyword {
  "for"      => suggest_rewrite(span, "for x in xs { body }",
                                       "xs |> for_each((x) => body)"),
  "while"    => suggest_rewrite(span, "while cond { body }",
                                       "state <~ iterate_while((s) => cond_check(s), (s) => step(s))"),
  "loop"     => suggest_rewrite(span, "loop { body }",
                                       "body ~> iterate_forever_handler"),
  "break"    => suggest_rewrite(span, "break",
                                       "perform abort() (use ~> catch_abort handler in caller)"),
  "continue" => suggest_rewrite(span, "continue",
                                       "filter the prior iteration: xs |> filter((x) => !skip(x)) |> for_each(f)"),
  "return"   => suggest_rewrite(span, "return value",
                                       "restructure with match/if; or use Abort effect for early exit"),
}
```

Each Quick Fix is `MachineApplicable` for the simple cases and `MaybeIncorrect` (with placeholders) for the complex ones.

### 4.4 — `mentl edit` and LSP integration

The Quick Fixes surface in `mentl edit` (built-in) and via LSP for VS Code / vim / Emacs. The gradient's narration appears as hover text + quickfix-on-keyword. The user who types `for` sees the Mentl alternative within the same keystroke.

## §5 — `SYNTAX.md` revision

§"Token enumeration" already documents the absence at line 1317-1320. Strengthen the rationale and link to this walkthrough:

> Note: `loop`, `break`, `continue`, `return`, `for`, `in` are NOT reserved keywords — Mentl has no imperative control flow constructs. Iteration is via `|>` + `<~` + `Iterate` effect handlers. Early-exit is via `Abort` effect + `catch_abort` handler.
>
> See `docs/specs/simulations/syntax/iteration-substrate.md` for the canonical iteration patterns and gradient teaching. The gradient surfaces Quick Fixes when a keyword shape is typed; users learn the substrate forms by accepting the suggestion. The teaching IS the discipline.

§"Diagnostic catalog" gains:

| `E_NotAKeyword` | user typed `for`/`while`/`loop`/`break`/`continue`/`return` | Quick Fix to substrate-honest verb + handler form |

## §6 — Edge cases

**Recursion-as-iteration.** Direct recursion is allowed (and idiomatic for FP-comfortable users):

```
fn count_down(n) = {
  if n <= 0 { () }
  else {
    perform log(n)
    count_down(n - 1)
  }
}
```

This composes with the verb forms. Tail-call optimization (per `Hβ.lower.tail-call-mark-pass`, task #124, completed) eliminates stack growth.

**Async iteration.** When iteration crosses await-points (e.g., async streams), the `Iterate` handler combines with `Sample`/`Tick`/`Clock` for time semantics. `<~` participates as feedback. Out of scope for this walkthrough — covered by `spec 11 — Clock`.

**Generator coroutines.** Mentl's MultiShot continuation IS the generator substrate. `yield(v)` in an `Iterate` handler arm returns control to the iteration consumer; resume() returns to the producer. This is more powerful than Python's `yield` because the resume is first-class.

**Map-reduce parallelism.** `xs |> par_map(f) |> fold(0, +)` — `par_map` is the parallel-aware variant; the substrate uses `><` internally. Per task #89 (par_map FULLY-as-early), this is the canonical N-arity parallel.

**Heterogeneous iteration.** `(xs, ys, zs) |> zip_with_3(f)` — three lists in lockstep. Stdlib provides `zip_with_2`, `zip_with_3`, `zip_with_n`. Or: `(xs |> map(...) ) >< (ys |> map(...) ) >< (zs |> map(...) )` for parallel.

**Accumulator without `<~`.** `xs |> fold(0, (acc, x) => acc + x)` IS the accumulator pattern. `<~` is for FEEDBACK (state evolves over time, e.g., DSP); `fold` is for COLLECTION-CONSUMING (collapse a list to a value). Different topology, different verb.

## §7 — Named peer follow-ups

- **`Hβ.syntax.iter-stdlib-completeness`** — audit `lib/prelude.mn` + `lib/runtime/` for the canonical iteration function list per §4.1; add any missing.
- **`Hβ.syntax.iter-effect-canonical`** — confirm `Iterate` effect declaration per §4.2 in `src/effects.mn` (or wherever); `for_each_handler` canonical instance.
- **`Hβ.syntax.iter-keyword-quickfix`** — implement §4.3 (parser Quick Fix on `for`/`while`/`loop`/etc.).
- **`Hβ.syntax.iter-doc-revise`** — implement §5 (SYNTAX.md token enumeration note + diagnostic catalog).
- **`Hβ.syntax.iter-mentl-edit-integration`** — implement §4.4 (mentl edit Quick Fix surfaces).

## §8 — Verification

```
// for_each side effect:
[1, 2, 3] |> for_each((x) => perform log(x))
// expected: type-checks; logs three values

// map produces new list:
let doubled = [1, 2, 3] |> map((x) => x * 2)
// expected: doubled = [2, 4, 6]

// fold accumulates:
let sum = [1, 2, 3] |> fold(0, (acc, x) => acc + x)
// expected: sum = 6

// take limits iteration:
let first_three = (range(0, 1000)) |> take(3)
// expected: first_three = [0, 1, 2]

// keyword Quick Fix:
for x in xs { body }
// expected: E_NotAKeyword with Quick Fix:
//   xs |> for_each((x) => body)

// early-exit via Abort:
xs |> for_each((x) => if x < 0 { perform abort() } else { use(x) })
  ~> catch_abort
// expected: stops at first negative; remaining values not processed
```

## §9 — Cross-references

- `SYNTAX.md` §"Token enumeration" (line 1317-1320) — current absence note.
- `SYNTAX.md` §"Diagnostic catalog" — revised per §5.
- `lib/prelude.mn` / `lib/runtime/` — iteration stdlib site.
- `src/effects.mn` — `Iterate` effect declaration site.
- `src/parser.mn` — Quick Fix on keyword shapes; §4.3 site.
- `protocol_developer_experience_vision.md` — the gradient teaches the substrate; iteration discipline IS the experience.
- `protocol_canonical_projection_pattern.md` — `for_each`, `map`, etc. are the canonical fns; the user calls them, no keyword.

## §10 — Walkthrough closure

Mentl has no `for`/`while`/`loop`/`break`/`continue`/`return` keywords because the five verbs + Iterate handler + stdlib subsume every iteration pattern. The discipline IS the experience: the user types verbs, the gradient narrates, the Quick Fix teaches. After 3-5 keystrokes, the verb forms are habit.

The friction is real for transferees from imperative languages. The teaching is sufficient: the gradient surfaces the substrate at the friction-point; the substrate IS the residue. After accepting Quick Fixes, the user learns to type verbs natively.

When this walkthrough's named follow-ups all land:
- The stdlib is complete and discoverable
- The keyword Quick Fixes catch every transferee's first attempt
- The discipline holds without being punitive
- Mentl's voice teaches at the gradient's friction-point

This is the residue. The keywords were never substrate; their absence is the discipline; the gradient teaches the absence into habit.
