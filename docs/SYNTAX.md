# SYNTAX.md — Canonical syntax specification

> *The form that best translates intent into computation.*

This document is **the authoritative syntactic spec for Mentl**. It binds the parser; the parser implements exactly this. It is written under dream-code discipline: every decision below is the IDEAL form, not a description of the current parser. Where the current parser deviates, the parser is wrong; SYNTAX.md is the wheel, the parser is the lathe being adjusted to it.

DESIGN.md articulates the medium's vision. The 12 specs in `docs/specs/` describe per-module behavior. SUBSTRATE.md crystallizes load-bearing structural truths (kernel, verbs, algebra, handlers, gradient, refinement, theorems). **SYNTAX.md is the layer between vision and implementation: the surface form by which intent reaches the substrate.**

---

## Syntax ↔ the eight-primitive kernel

Every form below exists to make one primitive of the kernel (DESIGN.md §0.5) reachable as text. No form exists without a kernel correspondence. This is not decoration — it is a load-bearing constraint: a syntactic feature with no kernel primitive behind it has no semantic home, and every such feature in peer languages has been regretted. The kernel has eight primitives; Mentl has eight tentacles; the surface forms below have eight corresponding surfacing groups.

| # | Kernel primitive                                    | Tentacle   | Surface form                                                    |
|---|-----------------------------------------------------|------------|-----------------------------------------------------------------|
| 1 | Graph + Env                                    | Query      | AST nodes implicit; `import` brings module envs together         |
| 2 | Handlers with typed resume discipline               | Propose    | `effect`, `handler`, `handle`/`~>`, `resume`. Ops are invoked as BARE CALLS — effect-ness lives in the op's row (`Closed[eff]` at decl), never in a call-site keyword (`perform` is format-liftable ceremony; see §«Invoking effect operations»). Resume cardinality is INFERRED from arm body structure (count of resume sites under control-flow ancestry); never authored as annotation. |
| 3 | Five verbs                                          | Topology   | `\|>`  `<\|`  `><`  `~>`  `<~` with canonical layout             |
| 4 | Full Boolean effect algebra (`+ - & ! Pure`)        | Unlock     | `with E1 + !E2 + Pure` in fn sigs, handler sigs, types — declared row is a CONSTRAINT verified against the row inferred from the body's op-call sites, never a contract |
| 5 | Ownership as an effect                              | Trace      | `own` / `ref` parameter markers; inferred from usage count by default (0/1/2+ → Inferred/Own/Ref) |
| 6 | Refinement types                                    | Verify     | `type Name = Base where predicate`; per-program-point narrowing inferred from `if`/`match`/`assert` sites |
| 7 | Continuous gradient                                 | Teach      | The gradient is continuous, derived (gates_unlocked × proximity); annotations are INPUTS that unlock gradient ascent at a position. The gradient itself is never authored — it emerges from the cursor reading the kernel's truth at P. |
| 8 | HM inference with Reasons                           | Why        | No turbofish; generic params declared, inferred at call; wildcard `_` holes admit productive-under-error continuation |

**Rule:** before adding a syntactic form, ask: which kernel primitive does it surface (and therefore which tentacle speaks for it)? If none, the form doesn't belong. If multiple, they were missing a shared form — consolidate.

Each section below labels which primitive(s) its forms surface.

---

## Governing principles

Five rules every syntactic decision below honors:

1. **Layout IS contract.** The shape of the code on the page IS the computation graph. The parser enforces layout — code with the wrong layout is a parse error, not a stylistic preference.

2. **No redundant form.** If two syntactic forms produce the same graph, one is rejected. The medium refuses ceremony the substrate doesn't require.

3. **No syntactic ambiguity.** Every token sequence parses to exactly one AST under the rules below. Ambiguity in a language is debt the user pays; Mentl pays its own debt at design time.

4. **Every construct has graph correspondence.** No syntax exists without a substrate operation it produces. If a form has no graph meaning, it doesn't exist.

5. **Diagnostics carry coordinates and Quick Fixes.** Every rejection produces a Located reason chain and (where mechanically apparent) a MachineApplicable patch. Errors are teaching surfaces, not punishment.

---

## Function declarations

### Canonical form — single-line expression body

```
fn name(p1, p2) -> RetTy with E1 + E2 = expr
```

When the body fits on one line after `=`, no braces are required.

```
fn double(x) = x * 2
fn add(a, b) with Pure = a + b
fn parse(path: ValidPath) = path |> read_file |> decode
```

### Canonical form — multi-line body requires braces

**Rule:** if the body spans more than one line (statements, multi-line expressions like `if`/`match`, etc.), braces are required. They anchor the function boundary visually and enable editor code-folding at every function.

```
fn chase_node(ref nodes, handle, depth) with !Mutate = {
  if depth > 100 {
    GNode(NErrorHole(Inferred("depth exceeded")), Fresh(handle))
  } else {
    let GNode(kind, reason) = graph_node_at(nodes, handle)
    match kind {
      NBound(ty) => ...,
      _          => GNode(kind, reason),
    }
  }
}

fn process(input: [Float]) -> Result with !Alloc = {
  let validated = input |> validate
  let normalized = validated |> normalize
  normalized |> fft |> extract
}
```

The braces enclose a `BlockExpr(stmts, final_expr)` when `let`/intermediate statements are present, or a single multi-line expression otherwise.

### The Intent Boundary Rule for Parameters

Mentl uses Hindley-Milner type inference. **You do not need to annotate base types** like `Int`, `String`, or structural records on parameters. 

**Rule:** Parameter type annotations are strictly reserved for **Intent Boundaries**. Use them to explicitly declare:
1. **Refinement Types** (e.g., `pos: ValidOffset`, `span: ValidSpan`) which encode predicates that `Verify` must discharge.
2. **Ownership Markers** (e.g., `ast: own Node`, `env: ref Env`) which enforce linearity and aliasing.

Do not write `fn name(a: Int)` when the graph can infer it. Do write `fn name(pos: ValidOffset)` to erect a graph-backed semantic contract.

### Canonical form — block body

When the function needs intermediate `let` bindings or multiple statements before its final expression:

```
fn process(input: [Float]) -> Result with !Alloc = {
  let validated = input |> validate
  let normalized = validated |> normalize
  normalized |> fft |> extract
}
```

Braces ARE required when there are statements. The braces enclose a `BlockExpr(stmts, final_expr)`.

### Rejected form — braces around single-line expression

```
// REJECTED:
fn parse(path: Path) -> Config = { path |> read_file |> decode }
```

Diagnostic: **`E_RedundantBraces`** at the opening `{`.
> "this body fits on one line; remove the braces. Use braces only for multi-line bodies."

Quick Fix: remove the `{` and `}`.

### Rejected form — missing braces on multi-line body

```
// REJECTED:
fn chase_node(...) =
  if depth > 100 {
    ...
  } else {
    let node = graph_node_at(...)
    ...
  }
```

Diagnostic: **`E_MissingBracesMultiLine`** at the `=`.
> "multi-line function bodies require braces to anchor the function boundary. Wrap the body in `{ ... }`."

Quick Fix: add `{` after `=` and `}` at the end.

### Generic type parameters

```
fn map(f: a -> b, xs: [a]) -> [b] =
  ...
```

**The case rule IS the declaration**: lowercase identifiers in type
position can only be type parameters (nominal types are capitalized),
so there is no declaration list to write or keep in sync. Inferred at
call sites. **No turbofish. No angle brackets — anywhere.** Call:
```
map(double, [1, 2, 3])   // correct — A=Int, B=Int inferred
```

```
// REJECTED:
map<Int, Int>(double, [1, 2, 3])
```
Diagnostic: **`E_ExplicitTypeParams`**: "type parameters are inferred at call sites; remove the explicit annotation." The same diagnostic covers angle-bracket parameter lists in ANY declaration position (`type Box<A>`, `fn f<T>`, `effect E<S>`) — the list is retired; the case rule carries the meaning.

### With-clauses for effects

```
fn fetch(url: String) with IO + Network =
  ...
```

Multiple effects join with `+`. Negation: `!E`. Parameterized: `E(arg)`. Combinations:
```
fn audio_stage(samples) with Sample(44100) + !Alloc + IO =
  ...
```

`Pure` is the identity element of `+`. Writing `with Pure` is allowed (and an explicit purity declaration); `with Pure + IO` simplifies to `with IO`.

### Return type omission

```
fn id(x: A) = x   // return type inferred
```

The `-> RetTy` clause is optional; absent = inferred. Most user code does NOT annotate return types. Mentl's gradient may suggest annotating when capabilities depend on the return type being explicit.

### Default parameter values

Trailing parameters may have default values. Call sites may omit them or override via labeled args.

```
fn compress(x: Sample, ratio: Float = 4.0, threshold: Float = -12.0) -> Sample = ...

compress(sample)                                    // ratio and threshold defaulted
compress(sample, 8.0)                               // ratio overridden; threshold defaulted
compress(sample, threshold = -6.0)                  // label to skip over ratio
compress(sample, ratio = 2.0, threshold = -18.0)   // fully labeled
```

Defaults are evaluated per-call-site (not at declaration time); they may reference earlier parameters but not later ones.

### Labeled call arguments

Any call may use `name = value` for trailing positional arguments. Positional-before-labeled order:

```
fn spawn_task(priority: Int, ref config: Config, timeout_ms: Int = 1000) -> Handle = ...

spawn_task(5, config)                                            // positional only
spawn_task(5, config, timeout_ms = 5000)                        // positional + labeled override
spawn_task(priority = 5, config = current, timeout_ms = 5000)   // all labeled
```

Labeled args improve readability at call sites with many parameters and allow skipping defaults. Parser resolves labels against the declared parameter names; unknown label = `E_UnknownArgLabel`.

### Nested function declarations

`fn` declarations may appear inside another function's body. Nested fns are local to the enclosing body's scope.

```
fn check_exhaustive(patterns) = {
  fn covers_all(pats, variants) = {
    // inner helper; visible only inside check_exhaustive
    all_match(variants, (v) => any_match(pats, (p) => matches(v, p)))
  }
  covers_all(patterns, known_variants())
}
```

Nested `fn name(params) = body` is syntactic sugar for `let name = (params) => body`. Same semantics; nested form reads more naturally when the inner fn is genuinely function-shaped (vs. a lambda passed as an argument).

Mutual recursion: nested fns may reference each other — the compiler hoists them into a local letrec scope.

---

## Anonymous functions (lambdas)

### Canonical form

```
(params) => body
```

One syntax for all anonymous functions. `(` opens the parameter list; `)` closes it; `=>` separates params from body; body is one expression OR one brace-block. `fn` keyword is reserved for named declarations only — it does NOT appear in lambda syntax.

### Examples

**Zero arguments:**
```
() => 42
() => { let x = compute(); x + 1 }
```

**Single argument:**
```
(x) => x + 1
(_) => 42              // argument ignored (PWild pattern)
```

**Multiple arguments:**
```
(a, b) => a * b
(a, _) => a            // second ignored
(_, _) => 0            // all ignored
```

**Destructuring patterns in param position:**
```
({name, age}) => greet(name)              // record destructure
((a, b)) => a + b                          // tuple destructure (outer = param list; inner = tuple pattern)
([h, ...t]) => process(h, t)               // list destructure
```

**Block body:**
```
(input) => {
  let cleaned = input |> clean
  cleaned |> transform
}
```

### Rule — braces only for multi-line / statement bodies

- **Single-line, single expression body:** no braces. `(x) => x + 1`.
- **Multi-line OR containing `let` statements:** braces required. `(x) => { let y = ...; y + 1 }`.

This matches the brace discipline for named fn bodies (see §"Function declarations").

### Inline higher-order use

```
map((x) => x + 1, xs)
fold(xs, 0, (acc, x) => acc + x)
filter((x) => x > 0, xs)
zip_with((a, b) => a * b, xs, ys)
```

### Returned closures

```
fn compose(f, g) = (x) => g(f(x))
fn id(x) with Pure = x
```

### Match arms share the lambda syntax

Match arms are `pattern => body`. **Match arms ARE pattern-dispatched lambdas** — same separator, same body discipline. The syntactic unity reflects semantic unity.

### Rejected forms

```
// REJECTED — pipe-fence form (superseded by `()` unification):
|x| x + 1
|acc, x| acc + x
```

Diagnostic: **`E_LambdaFence`** with Quick Fix rewriting `|params| body` → `(params) => body`.

```
// REJECTED — `fn` keyword on anonymous lambda:
fn (x) => x + 1
```

Diagnostic: **`E_RedundantFnOnLambda`** — `fn` is reserved for named declarations. Remove `fn` for anonymous forms.

```
// REJECTED — zero-arg via `||`:
|| expr
```

Diagnostic: **`E_LambdaAsOrOr`** — `||` is logical OR (TOrOr). Use `() => expr` for zero-arg lambdas. Quick Fix: replace `||` with `() =>`.

---

## Pipe verbs — the five-verb topology

Mentl has FIVE pipe verbs. Each draws a specific shape on the page; the layout IS the topology.

### `|>` — converge

Sequential data flow. Right-applied to left.

```
input
  |> stage_a
  |> stage_b
  |> output
```

**Layout:** `|>` sits at the LEFT EDGE. Each stage on its own indented line.

Single line acceptable for short chains:
```
x |> double |> square
```

**Type rule:** if `left: A` and `right: A -> B with E`, then `left |> right: B with E`. The chain's row unions all stage rows.

### `<|` — diverge (fanout)

One input, multiple branches, output is a tuple of branch outputs. **Input is BORROWED into each branch** — a value cannot escape the branch tuple.

```
input
  <| (
    branch_a,
    branch_b,
    branch_c,
  )
```

Or equivalently with stage chains in branches:
```
input
  <| (
    (x) => x |> stage_a1 |> stage_a2,
    (x) => x |> stage_b1,
    extract_c,
  )
```

**Layout:** `<|` sits at the LEFT EDGE before the branch tuple. The branch tuple's `(` opens on the same line as `<|`; branches are on indented lines; the closing `)` returns to the indent of the opening branch.

**Type rule:** if `input: T` and branches are `(T -> A, T -> B, T -> C)`, the result is `(A, B, C)`. Row is union of all branch rows + upstream row.

**Ownership:** input is shared (borrowed). `own` values cannot flow through `<|` — `E_OwnershipViolation`.

### `><` — parallel compose (structural N-ary)

**Two or more INDEPENDENT pipelines run in parallel.** Each branch has its own input. Outputs are tupled.

**`><` is a structural N-ary construct accepting two layouts**, distinguished by branch shape:

**Form A — vertical (canonical for multi-line branches):**
```
(pipeline_a)
    ><
(pipeline_b)
```

Three or more branches stack:
```
(pipeline_a)
    ><
(pipeline_b)
    ><
(pipeline_c)
```

**Form B — inline (canonical for atomic branches):**
```
(branch_a) >< (branch_b)
(audio_l |> compress) >< (audio_r |> compress)
(extract_x) >< (extract_y) >< (extract_z)
```

**Layout is the formatter's projection — never semantics.** The
precedence table alone draws the tree: `><` binds looser than `|>`,
so `a |> f >< b |> g` IS `(a |> f) >< (b |> g)` with or without
parens. The formatter writes the parens and chooses the form; the
parser enforces nothing about whitespace or parenthesization.

**Render rule (formatter canon):**
- Each branch rendered parenthesized — `(...)` — for visual branch boundaries.
- All branches single-line + total fits target width → Form B (inline).
- Any branch multi-line OR total exceeds width → Form A (vertical): each branch on its own line; `><` ALONE on its own line at INDENTED CENTER (4-space indent).
- Mixed shapes normalize to vertical at save.

The construct reads top-to-bottom (Form A) or left-to-right (Form B). After `><` the chain returns to LEFT EDGE for whatever consumes the tupled result:
```
(audio_left  |> compress |> limit)
    ><
(audio_right |> compress |> limit)
|> stereo_mix
```

### `><` branch typing

Branch validity is a TYPE fact, not a layout fact. A `><` branch
must be stage-typed (a pipeline / function of the composed input);
a value tuple where stages belong surfaces at infer time with a
Reason chain back to the `><` site (peer handle
`Hβ.infer.pcompose-branch-stage-type`). The parser never inspects
branch shape — parse-time form classification is the
eager-form-commitment drift (`protocol_parse_is_eager_graph_projection.md`).

### `~>` — tee (handler-attach)

`expr ~> h` ≡ `handle expr with h`. The handler intercepts effects expr performs.

**The one law:** `~>` has ONE precedence — **1, the loosest binary
operator** (see §Precedence). The handler at the foot of a chain
governs everything to its left in the expression; parenthesize
`(stage ~> h)` to narrow the scope to one stage. There is no second
rule: no layout sensitivity, no inline/block semantic split.
**Whitespace is never semantically load-bearing in Mentl.**

```
source
  |> lex
  |> parse
  |> infer
  ~> env_handler          // governs (source |> lex |> parse |> infer)
  ~> graph_handler        // wraps env_handler(...)
  ~> diagnostics_handler  // outermost — sandbox boundary
```

Narrow scope is parens, visible at the site:
```
raw_string
  |> (parse_json ~> catch_parse_error(default = "{}"))
  |> save_to_db
```

Block vs inline on the page is the FORMATTER's choice, projected
from tree shape: a chain body earns the block layout (`~>` on its
own line at left-edge indent); a single-stage body renders inline.
Same node, same scope, either way.

**Type rule:** `row(expr ~> h) = row(expr) - handled(h) + row(h)`. The handler subtracts what it absorbs; anything its arms perform is added.

### `<~` — feedback (cycle closure)

Closes a cycle back into the pipeline; the value computed flows back as input on the next iteration.

```
signal <~ delay(3)        // 3-sample feedback delay
state  <~ accumulate(0)   // running accumulator
filter <~ filter_spec(N, coeffs)
```

**Layout:** `<~` may appear INLINE (one line) or at INDENTED CENTER for clarity:
```
signal
    <~ delay(3)
```

**Type rule:** `<~` requires an iterative context (`Sample`, `Tick`, `Clock` handler installed somewhere in the enclosing handler stack). RHS must be a `FeedbackSpec` value (constructed via `delay(N)`, `accumulate(init)`, `filter_spec(N, coeffs)`, etc.). Without iterative context: `E_FeedbackNoContext` at the `<~` site.

---

## Records

Mentl records are **structural**: a record TYPE is `{name: T1, age: T2}` — no nominal declaration ceremony required. Two records with the same fields and types unify. Row polymorphism is supported.

### Canonical literal form

```
{name: "Morgan", age: 30}
```

Fields separated by commas. Each field is `name: value`. Trailing comma allowed (recommended for multi-line):
```
{
  name: "Morgan",
  age: 30,
  email: "morgan@example.com",
}
```

**Field punning** — when the value's expression IS a variable of the same name as the field:
```
let name = "Morgan"
let age = 30
{name, age}              // sugar for {name: name, age: age}
```

Mixed punning:
```
{name, age, email: derive_email(name)}
```

**Sorting at parse time.** Fields are sorted alphabetically by name when the AST is constructed. Source order is irrelevant; the canonical AST has fields in alphabetical order. This makes record-equality and field-offset computation deterministic.

### Canonical type form

```
{name: String, age: Int}
```

Inline structural. Used in fn parameter types, return types, let-bindings. No declaration ceremony.

### Row polymorphism

Open record type — accepts any record with AT LEAST these fields:
```
fn greet(u: {name: String, ...}) -> String =
  "Hello, " ++ u.name
```

`...` is anonymous rest; `...R` binds the rest to a row variable `R` for further use:
```
fn extend(base: {name: String, ...R}, age: Int) -> {name: String, age: Int, ...R} =
  ...
```

### Nominal record types

When a brand is wanted (distinct identity, not just shape):
```
type Person = {name: String, age: Int}
type Customer = {name: String, age: Int}    // DIFFERENT type from Person despite same shape
```

Nominal records are constructed using their type name:
```
let p = Person{name: "Morgan", age: 30}
let c = Customer{name: "Morgan", age: 30}
// p and c have different types; cannot be unified
```

### Pattern syntax for records

```
let {name, age} = morgan       // both fields bound to locals
let {name, ...rest} = morgan   // bind name; rest is a record of remaining fields
let {name: n, age: a} = morgan // bind to renamed locals
```

### Field access

```
morgan.name
nested.outer.inner
```

Field access lowers to `LFieldLoad` with offset resolved at compile time from the record's type. O(1) load.

### Record update — spread into new record

```
let older = {...user, age: user.age + 1}
let tagged = {...event, timestamp: now(), processed: true}
```

`{...existing, field: new_value, ...}` creates a NEW record by copying `existing`'s fields and overwriting/adding the listed fields. Non-destructive; original record unchanged (ownership preserved). Field lists must be type-compatible with the source shape.

---

## Indexing

Subscript access for lists, tuples, and integer-keyed records.

```
argv[1]                      // list index
nodes[idx]                   // list index
(a, b, c)[0]                 // tuple element access (compile-time bounds check)
matrix[i][j]                 // chained indexing
```

`xs[i]` lowers to the appropriate runtime call based on the receiver's inferred type:
- `[a]` → `list_index(xs, i)`.
- Tuple → compile-time position extraction.
- Map / record-by-int-key → `record_get(xs, i)`.

Bounds-checking is runtime for lists (traps on out-of-range); compile-time for tuples (H6 exhaustiveness).

Refinements over the index tighten bounds:
```
fn safe_get(xs: [a], i: ValidIndex(xs)) -> a = xs[i]
```

When `i` is refined to a proven-valid index, the compiler elides the bounds check.

---

## Algebraic data types

### Type declaration

```
type Option
  = Some(a)
  | None

type Tree
  = Leaf
  | Branch(Tree(a), a, Tree(a))
```

Each variant is a constructor with zero or more fields. Type
parameters are the lowercase identifiers in field positions — the
case rule IS the declaration (uppercase = nominal type, lowercase =
parameter). Every constructor of a type quantifies the type's full
parameter set (`None : Option(a)` too). Types APPLY with parens,
the one application syntax at every level: values `f(x)`, effects
`Sample(44100)`, types `Option(Int)` / `Tree(a)`.

### Constructor calls (value construction)

```
let some_value = Some(42)
let nothing = None
let tree = Branch(Leaf, 1, Branch(Leaf, 2, Leaf))
```

Same syntax as function calls. Inference disambiguates by looking up the name in env: if it's a `ConstructorScheme`, it lowers to `LMakeVariant` with the constructor's tag_id; if a `FnScheme`, to `LCall`.

### Pattern matching

```
match opt {
  Some(v) => v,
  None    => 0,
}
```

Arms separated by commas. Trailing comma allowed.

### Exhaustiveness

The match must cover every variant of the scrutinee's type, OR include a wildcard arm `_ => default`. Missing variants without wildcard:

Diagnostic: **`E_PatternInexhaustive`** at the `match` keyword:
> "match on Option does not cover variant: None. Add `None => ...` arm or `_ => ...` wildcard."

Quick Fix: insert stubs for missing variants.

### Type aliases

Three forms of `type` declaration, distinguished by RHS shape:

**Transparent alias** — `type X = Y` (no `where`, RHS is a type expression, not a record literal).

```
type Port = Int
type Frequency = Float
type Bytes = [Int]
```

Creates `TAlias("X", Y)`. The alias and underlying type unify transparently — `Port` and `Int` are interchangeable for type-checking. The name is preserved in Reason chains and in Mentl's voice.

**Refined alias** — `type X = Y where pred`.

```
type ValidPort = Int where self >= 1024 && self <= 65535
type Sample = Float where -1.0 <= self <= 1.0
```

Creates `TRefined(TAlias("X", Y), pred)`. The alias names the type; the refinement narrows it via predicate. Verify discharges the predicate at construction sites.

**Nominal record** — `type X = {f1: T1, f2: T2, ...}`.

```
type Person = {name: String, age: Int}
type Customer = {name: String, age: Int}    // distinct from Person despite same shape
```

Creates `TName("X", [], TRecord([...]))`. The record's name brands its identity — `Person` and `Customer` do NOT unify even with identical fields.

**For nominal distinction over a primitive** — wrap in a single-field record:

```
type Port = {value: Int}
type Customer = {value: String}
```

No `newtype` keyword required; the record name carries the brand. Field access via `.value`. See `docs/specs/simulations/syntax/type-alias-substrate.md` for the substrate analysis.

### Refinement types

```
type Sample = Float where -1.0 <= self <= 1.0
type NonEmpty = [a] where len(self) > 0
type Even = Int where self % 2 == 0
```

`self` refers to the value being refined. The refinement is a `Predicate` discharged by the `Verify` effect at construction sites and elsewhere as needed.

---

## Effect declarations

### Unparameterized effect

```
effect IO {
  print(msg: String)               // unit return; `-> ()` omitted
  read() -> String
}

effect State {
  get() -> s
  set(v: s)                        // unit return; `-> ()` omitted
}
```

Each operation declares its parameter types and return type (if non-unit). **Resume cardinality is INFERRED at handler-decl time from each arm body** — never declared on the effect op. The infer pass counts resume call sites under control-flow ancestry; the inferred cardinality attaches to the op's `TCont` continuation type and drives lower's tier selection (Tier 1 direct call vs Tier 3 heap continuation). See `protocol_cursor_is_the_substrate.md` for the discipline.

### Invoking effect operations

An effect op is invoked as a **bare call** — the same surface as any
function call:

```
fn expect_true(value) = {
  check(value, "expected true")     // canonical — check is the Test effect's op
}
```

The env binding proves op-ness (`EffectOpScheme`); the op's `TFun` row
carries `Closed[eff]` definitionally from its declaration. The enclosing
fn's `with` clause is verified against the row inferred from these call
sites. The reader who needs suspension points reads the row in the
signature or the cursor's projection — the medium narrates what a
keyword would only whisper.

```
// FORMAT-LIFTED:
perform check(value, "expected true")
```

Diagnostic: **`E_RedundantPerform`** (MachineApplicable) — the formatter
strips the keyword silently; both forms produce the same graph, and per
governing principle 2 the bare call is the one that survives. `resume`
keeps its keyword: it is context-bound to handler arms, typed by the
typed-resume law (`resume : R -> S`), and names the continuation — a
value the call site cannot otherwise reach. See
`docs/specs/simulations/syntax/perform-dissolution-substrate.md`.

### Unit return omission

If an effect op returns unit `()`, the `-> ()` clause may be omitted:

```
effect Console { print(msg: String) }       // returns ()
effect Console { print(msg: String) -> () } // equivalent, explicit
```

Both forms are accepted; absence is the idiomatic short form. Non-unit returns MUST be declared explicitly: `read() -> String`. This mirrors the fn-declaration rule where `-> RetTy` is optional on inferred fns but REQUIRED when declared.

### Calling resume with unit

For ops returning `()`, the handler arm calls `resume()` (no inner unit literal required):

```
handler stdout_console {
  print(msg) => {
    fd_write(msg)
    resume()                // canonical — not resume(())
  }
}
```

Per §"Parameters ARE tuples," a zero-arg call unifies with a unit parameter type. `resume()` and `resume(())` are grammatically equivalent; `resume()` is canonical by §"No redundant form."

### Parameterized effect (first-class)

```
effect Sample(rate: Int) {
  tick() -> ()
  current_sample() -> Float
}

effect Budget(limit: Int) {
  spend(amount: Int) -> Bool
}
```

The effect name itself carries arguments. **Row algebra treats `Sample(44100)` and `Sample(48000)` as distinct effects.** Equality requires name AND argument value match (scalar literal equality for Int / Bool / String args; structural equality for compound types).

### Installation in `with` clauses

```
fn audio_loop() with Sample(44100) + IO + !Alloc =
  ...
```

The argument is evaluated at install time and frozen. Two functions declared with `Sample(44100)` and `Sample(48000)` cannot interoperate without an explicit handler bridge.

### Resume discipline — inferred, not annotated

Resume cardinality is **inferred from each handler arm body** at handler-decl time; the developer never types `@resume=`. The infer pass walks the arm body collecting resume call sites; classifies via control-flow ancestry + branch-disjointness:

- **`OneShot`** (inferred when zero or one resume site, not under loop ancestor; or multiple sites all in branch-disjoint paths) — continuation lives on the stack; no heap capture; performance is direct-call equivalent. Compile error never fires here because the inference produces the correct kind from the body's structure.
- **`MultiShot`** (inferred when one or more resume sites under loop/recursion ancestry, or two sites both reachable from one path) — continuation captured to the heap as a closure. Enables backtracking, non-determinism, generators.
- **`Either`** (inferred when callers pin distinct kinds at different install sites; gradient-undecided at the EffectOpScheme) — handler arms may use either; loses some optimization headroom.

The cardinality is **load-bearing on type+lower** — it's why Mentl can express real-time DSP and constraint-search backtracking under one effect algebra. But the **annotation form is drift** (per `protocol_cursor_is_the_substrate.md`): authoring `@resume=` would declare what the body already proves. The body IS the contract; the cursor projects the cardinality. See `src/infer.mn`'s `infer_resume_cardinality` for the substrate.

### Negation in `with` clauses

```
fn pure_op(x: Int) -> Int with !Alloc + !IO =
  ...
```

`!E` proves ABSENCE of effect E. Stronger than not-mentioning E because it propagates transitively through the call graph: any callee that performs E causes the whole declaration to fail with `E_EffectMismatch`.

When used alone (e.g., `with !Mutate`), it creates a **capability stance** representing "anything except this effect" (universe-minus). This is how Mentl expresses region-freezes and borrows (`ref`) mathematically without a separate borrow-checker.

`Pure` is shorthand for "the body's row must be EfPure (literally empty)":
```
fn pure_op(x) with Pure = x + 1
```

---

## Handler declarations

### Canonical form

```
handler name(cfg_p1: T1, cfg_p2: T2) with state_a = init_a, state_b = init_b {
  op_arm_1(args) => body,
  op_arm_2(args) => body,
}
```

Three parts:
1. **Config parameters** in `(...)` — closure-captured at install site.
2. **State** after `with` — internal state evolving across arms.
3. **Op arms** in `{...}` — one arm per effect operation handled.

### Examples

```
// No config, no state — pure handler
handler log_to_stderr {
  log(msg) => {
    write_stderr(msg)
    resume()
  },
}

// Config (URL captured at install) + no state
handler websocket_sink(url: String) {
  emit(ev) => {
    ws_send(url, encode(ev))
    resume()
  },
}

// State (counter that evolves)
handler counter with n = 0 {
  inc() => resume() with n = n + 1,
  get() => resume(n),
}

// Both config + state
handler bounded_log(prefix: String) with count = 0, max = 100 {
  log(msg) => {
    if count >= max { resume() }
    else {
      write_stderr(prefix ++ ": " ++ msg)
      resume() with count = count + 1
    }
  },
}
```

### State updates via `with` on resume

When an arm wants to evolve state, it uses a `with` clause on `resume`:

```
inc() => resume() with n = n + 1
```

The `with` clause lists state updates by field name. Unlisted state stays unchanged.

### Installation

Two equivalent forms:

```
// Block form
handle {
  body_expr
} with handler_name(cfg_args)

// Pipe form
body_expr ~> handler_name(cfg_args)
```

Pipe form is preferred for chains; block form for embedded sub-scopes.

### Negation guards on handlers

```
handler affine_ledger with !Consume {
  consume(name, span) => ...,
}
```

`with !Consume` on the handler itself means: the arms cannot recurse through `consume`. Boolean effect algebra gates this at compile time.

---

## Capability declarations

A **capability** is a named effect row — the substrate's row algebra (`+` `-` `&` `!` `Pure`) named for developer intent. `capability File = read + write` introduces `File` as a row alias; any signature can write `with File + Network` and the row composes structurally.

Surfaces kernel primitive **#4** (full Boolean effect algebra). Per SUBSTRATE.md §IV: effect rows ARE first-class kernel values; a capability declaration is the surface that names a frequently-used row.

### Canonical form

```
capability File = read + write
capability Network = http + dns
capability ApiClient = File + Network
```

Each declaration:
- `capability` keyword (lexer: TCapability per token enumeration §«TCapability»)
- name (an upper-case identifier; conventional but not yet enforced)
- `=`
- effect-row expression: one or more effect-op names or capability names, combined with `+` `-` `&` `!`

The row expression follows the same algebra as `with E1 + E2` clauses (§«With-clauses»). After declaration, the capability name IS a row value at every site that takes a row.

### Use

```
fn fetch(url: String) with ApiClient = {
  let body = http("GET", url)
  write(local_cache_path(url), body)
}
```

The capability `ApiClient` unpacks to its underlying row at sig-check; the body's `http` and `write` op calls discharge against that row.

### Negation form

```
capability ReadOnly = File - write
```

`-` removes an effect from a capability. The resulting row admits `read` but rejects `write` at the structural-gate.

### Diagnostic

A capability that resolves to the empty row (`Pure`) — e.g., all effects subtracted out — is `W_CapabilityEmpty` (the row IS `Pure`; the capability adds no constraint above and beyond `with Pure`; suggest dropping the declaration).

A capability whose body references an undeclared effect name surfaces `E_MissingVariable` at the row position with span at the unresolved name.

### Kernel correspondence

A `CapabilityDeclStmt(name, effs)` AST node lowers to an env binding `name ↦ Row(effs)`. There is no runtime cost — capability use is fully resolved at compile-time via row composition. Per the row-alias ultimate-form discipline (peer `Hβ.types.capability-as-row-alias`), `capability` is structurally equivalent to `type name = RowOf<effs>`; the keyword surfaces developer intent ("this row IS a named capability") rather than introducing a new substrate primitive.

---

## Pipeline + handler installation in code

### Block handle

```
let result = handle {
  computation()
} with state_handler with s = 0 {
  ...
}
```

### Inline pipe handle

```
let result = computation() ~> state_handler
```

For handlers with config:
```
let log = handle { work() } with bounded_log("INFO")
```

### Multi-handler chain (capability stack)

```
source
  |> stages
  ~> mentl_default
  ~> affine_ledger
  ~> verify_ledger
  ~> diagnostics_handler   // outermost = least trusted = sandbox boundary
```

Reading top-to-bottom = inner-to-outer trust hierarchy.

---

## Pattern syntax

Patterns appear in `let`, `match`, function parameters, and lambda parameters.

### Variants

| Pattern             | Form                              | Binds              |
|---------------------|-----------------------------------|--------------------|
| `PVar`              | `name`                            | binds `name`       |
| `PWild`             | `_`                               | binds nothing      |
| `PLit`              | `42`, `"hello"`, `true`, `()`     | matches literal    |
| `PCon`              | `Some(v)`, `Branch(l, x, r)`      | binds inner pats   |
| `PTuple`            | `(a, b, c)`                       | positional binds   |
| `PList(prefix, rest)` | `[a, b, c]`, `[head, ...rest]`, `[_, ..._]` | positional prefix + optional rest |
| `PRecord`           | `{name, age}`, `{name: n, ...r}`  | field punning + rest |
| `PAlt`              | `pat_1 \| pat_2 \| ...`            | matches if any branch matches; no variable bindings inside alternatives |
| `PAs`               | `name @ pat`                      | binds `name` to whole value AND destructures via `pat` |

### Examples

```
match value {
  Some(0)            => "zero",
  Some(n)            => "got " ++ int_to_str(n),
  None               => "nothing",
}

match list {
  []                 => "empty",
  [single]           => "one element: " ++ show(single),
  [head, ...rest]    => "head + " ++ int_to_str(len(rest)),
  [_, ..._]          => "non-empty",
}

match user {
  {name: "Morgan", ...} => "found Morgan",
  {name: n}             => "user " ++ n,
}

// Pattern alternation — multiple patterns, one arm body
match event {
  Click(_) | Key(_) | Scroll(_) => "user input",
  Resize | Paint                => "render event",
  _                              => "other",
}

// As-patterns — bind whole value AND destructure
match event {
  e @ Click({x, y}) => process_click_with_coords(e, x, y),
  e @ Key(k)        => log_and_dispatch(e, k),
  _                 => ignore(),
}

let (x, y) = point
let {name, age} = user
let [first, second, ...rest] = items
```

List rest uses the same `...rest` surface as record rest. `rest` is
optional in the AST; no rest means exact-length match, while `..._`
accepts any remaining tail without binding it. `|` remains pattern
alternation / type-variant separation and is never list-cons syntax.

### Exhaustiveness

Match arms must cover all variants OR include a wildcard. Missing-variant errors include the missing variants by name (per H3's exhaustiveness machinery).

### Pattern alternation — rule

`pat_1 | pat_2 | ... | pat_n => body`: body executes if ANY branch matches. Variable bindings ARE allowed inside alternatives WHEN:

1. **All branches bind the same set of names.** Wildcards and literals don't count as bindings.
2. **For each binding name, the types across branches unify.** The body sees the unified type.
3. **Compatible refinements.** When refinements differ across branches, the body sees the disjunction; Verify discharges per-arm.

```
match opt {
  Some(x: Int) | Right(x: Int) => use(x),    // ACCEPTED — same name, same type
  None | Empty => default,                    // ACCEPTED — no bindings
  ...
}

match v {
  Some(x) | Other(y) => use(x)                // REJECTED — different binding names
  //   ^ E_PatternAlternationBindingMismatch
}
```

When branches bind different names: `E_PatternAlternationBindingMismatch` with the conflict surfaced. When the same name has incompatible types: same diagnostic with the type conflict surfaced. See `docs/specs/simulations/syntax/pattern-alternation-substrate.md` for the substrate analysis.

### As-patterns — rule

`name @ pat => body`: binds `name` to the entire matched value; `pat` destructures it further. `name` and any bindings inside `pat` are all available in the arm body. Common for "need the whole value AND some pieces" cases — event forwarding, logging, pass-through.

`@` is TAt (reserved for handler annotations more generally; no current load-bearing user-facing `@`-form on effect ops — `@resume=` was erased per the inference-from-body discipline). Context disambiguates if other `@`-forms are introduced in future kernel additions.

---

## Imports

### Canonical form

```
import path/to/module
```

The path is a slash-separated module name. The `ModuleResolver` handler maps it to a file in `std/` or the project's source tree.

### Selective import

```
import path/to/module {name_a, name_b, name_c}
```

Only the listed names are brought into scope.

### No rename / alias

There is no `import X as Y`. Full paths in source are clearer than aliases. If a name conflict arises, use the full qualified name at the call site:

```
import dsp/spectral
import lin/spectral

// At usage:
dsp.spectral.fft(samples)
lin.spectral.fft(matrix)
```

**One-separator law:** `/` appears ONLY in import position (transport-honest — the module path maps to the file transport). Everywhere in expressions, `.` is the one access operator — fields and qualified names alike. There is no third separator; `::` is not a token.

---

## Comments

### Line comments

```
// This is a line comment
let x = 1   // trailing comment
```

### Doc comments

`///` is the developer's one voice into the substrate. The lexer emits `TDocComment(text)` (per Token enumeration §`TDocComment`). The parser attaches each `TDocComment` to the immediately-following declaration via the `Documented(content, stmt)` AST wrapper (per DS walkthrough §3.1 + §3.2). Inference threads the docstring into the env entry as a `DocstringReason(content, span)` Reason edge (per DS §3.1 candidate C). Mentl's voice handler surfaces the docstring **verbatim alongside her canonical projection** (per MV §2.7 + F.1 §3.1, §5).

```
/// Single-pole IIR low-pass with cutoff frequency parameterized by
/// the sample rate. Real-time-safe.
///
/// Use in audio callbacks where allocation would cause dropouts.
/// References to `Sample` and `<~` are resolved by render handlers.
///
/// Primitive: #5 (Trace) — exemplifies ownership-as-effect with `!Alloc`.
fn lowpass_filter(samples: [Sample]) -> [Sample] with !Alloc =
  ...
```

#### What `///` IS

- **Pure prose.** Multi-line allowed; contiguous `///` lines concatenate to one String (per DS §5 AT-DS3). Blank `///` line becomes paragraph break.
- **Attaches to the immediately-following declaration.** Top-level `fn` / `type` / `effect` / `handler` / `let` accept `///`. Module-level `///` (no preceding declaration in the file) attaches to the synthetic `Module` handle for that file (per F.1 §3.2). One `///` block per declaration.
- **Surfaces verbatim.** Mentl has no semantic parse of `///`. She reads the String, renders it alongside her canonical voice (per MV §2.7 + F.1 §5). Render handlers (per F.1 §3.6) interpret presentation per target — HTML may render backticks as `<code>`, terminal as ANSI, markdown as fenced. The substrate stores raw String per DS §8; render handlers decide the rest.
- **Lede + body structure.** First sentence is the lede — the one sentence Mentl shows in `RTerse` register. Subsequent paragraphs add nuance, invariants, the `Why:` behind non-obvious choices. Mentl shows the full body in `RExplain`.
- **Cross-references via backticks.** Reference other identifiers, types, effects, handlers, capabilities in `` `backticks` ``. Render handlers resolve to links per target. The author writes the reference; the handler resolves.
- **Code blocks compile via the same pipeline.** A `///` block containing Mentl source IS just Mentl source; the compile pipeline verifies it. If it doesn't compile, the project's compile fails at the `doc_attach` site. There are no doc-tests as a separate category (INSIGHTS §"Examples, Not Tests" L398).

#### What `///` is NOT

- **Not a markup language.** No `=== headers ===` or `// ───── name ─────` decorations inside `///`; the declaration's name IS the heading. Render handlers add their own presentation chrome.
- **Not JSDoc / JavaDoc / Sphinx tags.** No `@param`, `@returns`, `@throws`, `@since`, `@deprecated`, `:func:`, `:type:`. The effect row + refinement substrate already carries parameter, return, and capability information; tags would duplicate. Lifecycle vocabulary (`@deprecated`, `@since`, "previously", "no longer", "legacy") is forbidden by the positive-form discipline (CLAUDE.md global). Doc shows what IS, not what was.
- **Not gated by the docstring's content.** Mentl is unsilenceable; `///` adds, never gates, never silences. A declaration with no `///` still surfaces Mentl's substrate-derived tentacles per silence_predicate (MV §2.7.5).
- **Not the only voice.** Mentl's substrate voice (per-tentacle, silence-gated, derived from the graph) is the second voice. Two speakers per declaration; no editorial third (F.1 §5).
- **Not module-level via `///` floating with no following declaration outside a file's prelude.** A module-level `///` block must precede the synthetic Module handle's position (the start of the file, before the first import or declaration). Behavior of `///` blocks elsewhere with no following declaration is owned by the DS substrate (current DS substrate per §3.1 candidate A: the parser tracks the most-recent `TDocComment` as pending; if no following declaration accepts it, the docstring is dropped silently. A future diagnostic may surface the orphan as `P_OrphanDocstring` if the pattern proves error-prone in practice).

#### Relationship to `//`

`//` is human-only scaffolding. The lexer silently consumes `//` comments — no token emitted, no graph presence, no Mentl presence. Use `//` for implementation notes inside function bodies (where the note describes a step in the algorithm, not the function itself) or for short file-skim section markers when no `///` would fit.

The choice between `//` and `///` is the choice between **"this is human-only context"** and **"this is part of the substrate the medium reads."** When in doubt — does Mentl need to know? `///`. Does only the human reader need to know? `//`.

### No block comments

Mentl does not have `/* ... */` block comments. Composability of the substrate means there's no need to disable large code regions; if code is unwanted, delete it. Version control preserves history.

---

## Strings

Mentl has **two string forms** distinguished by quote character:

- **`"..."`** — double-quoted; **supports interpolation** via `{expr}`.
- **`'...'`** — single-quoted; **literal**, no interpolation.

Each form has a multi-line variant (triple-quoted):

- **`"""..."""`** — multi-line + interpolating.
- **`'''...'''`** — multi-line + literal.

### Double-quoted (interpolating)

```
"hello"
"with newline\n"
"escaped quote: \""
"result is {a + b}"
"hello, {name}!"
```

**Interpolation:** `{expr}` is replaced with the expression's value at runtime. The expression's type must implement `Show` (or be a String already). For a literal `{` or `}` inside an interpolating string, double the brace: `{{` → literal `{`, `}}` → literal `}`.

**Escape codes:** `\n`, `\r`, `\t`, `\\`, `\"`, `\0`, `\xHH` (hex byte).

### Single-quoted (literal)

```
'raw text — {name} stays literal'
'use {{brace}} syntax {verbatim}'
'regex: ^[a-z]+\s*$'
```

No interpolation. Braces are literal characters — no doubling needed. Useful for format strings, regex, shell commands, documentation snippets about Mentl itself.

**Escape codes:** `\\`, `\'`, `\0`, `\xHH`. NO `\n` expansion — newlines must be literal (use triple-quoted form for multi-line literal content).

### Multi-line

```
let interpolating_block = """
  Hello, {name}.
  Your age is {age}.
"""

let literal_block = '''
  This is a literal multi-line block.
  Braces like {this} are NOT interpolated.
'''
```

Triple-quoted strings span multiple lines. Leading whitespace common to all lines is stripped (indentation-aware).

`"""..."""` inherits interpolation semantics from `"..."`.
`'''...'''` inherits literal semantics from `'...'`.

---

## Operator precedence

One canonical table. Higher number = tighter binding. **These are
the literal integers** returned by `op_prec` in BOTH parsers
(src/parser.mn and bootstrap/src/parser_infra.wat $op_prec) — one
table, three projections, zero translation. Structural forms (call
`f(args)`, field access `.`, indexing, unary `-`/`!`) bind tighter
than every binary operator; `=` in let and `=>` in lambda sit at
statement level — neither participates in the binop ladder.

| Prec | Operators                                | Associativity   | Notes                          |
|------|------------------------------------------|-----------------|--------------------------------|
| 10   | `*`, `/`, `%`                            | left            |                                |
| 9    | `+`, `-` (binary)                        | left            |                                |
| 8    | `++`                                     | left            | concat — type-polymorphic; associativity immaterial under concat-tree representation; see §"Concatenation operator" |
| 7    | `<`, `>`, `<=`, `>=`                     | left            | comparison                     |
| 6    | `==`, `!=`                               | left            | looser than comparison: `a < b == c < d` reads as `(a<b) == (c<d)` |
| 5    | `&&`                                     | left            |                                |
| 4    | `\|\|`                                   | left            |                                |
| 3    | `\|>`                                    | left            | sequential pipe — looser than all value operators: `a == b \|> f` pipes the comparison |
| 2    | `<\|`, `><`, `<~`                        | left            | convergent verbs — they draw shape around chains |
| 1    | `~>`                                     | left (loosest)  | handler-attach floor — governs the whole chain to its left |

`~>` deliberately has the LOWEST precedence so the handler at the
foot of a chain captures everything to its left as its body — the
one law of `~>` (§tee). Nonsense same-tier chains (`a < b < c`)
are not a parser concern: inference rejects them with a typed
Reason chain (`TBool` vs operand type), which localizes better
than any associativity rule could.

### Concatenation operator

`++` is **type-polymorphic over `TList(a)` and `TString`**, dispatched at lower-time by reading the operand's inferred type from the graph (`lookup_ty`).

| Operand types               | Lower projection                                       | Runtime fn       |
|-----------------------------|--------------------------------------------------------|------------------|
| `TList(a)` ++ `TList(a)`    | `LCall(handle, LGlobal("list_concat"), [l, r])`        | `list_concat`    |
| `TString` ++ `TString`      | `LCall(handle, LGlobal("str_concat"),  [l, r])`        | `str_concat`     |
| mixed (`TList` ++ `TString`)| `E_ConcatTypeMismatch` at infer-time                   | (none)           |
| unresolved (TVar / NFree)   | `E_ConcatTypeUnresolved` at lower-time                 | (none)           |

The dispatch is compile-time-only; no runtime type test. When the type is known, the operator IS a direct call. When the type is not known, the diagnostic surfaces with the operand handle's source span — the user must constrain the type.

**Drift refusal:** `++` does NOT silently default to `str_concat` when type is unresolved. Per `protocol_no_silent_fallback.md`, the substrate names the failure rather than fabricating a fallback. The `LUnresolved` sentinel emits `(unreachable)` with a Located reason chain back to the `++` site.

See `docs/specs/simulations/syntax/concat-operator-substrate.md` for the substrate analysis.

### Equality operator

`==`/`!=` are **structural**, type-dispatched at emit by the operand's
inferred type (`lookup_ty`) — the same compile-time dispatch as `++`.
There is no rule for the developer to remember: the graph knows the
type; the substrate carries the comparison.

| Operand type                | Emit projection                       | Semantics              |
|-----------------------------|---------------------------------------|------------------------|
| scalar (`Int`, `Bool`, byte, nullary ADT tag) | `i32.eq` / `i32.ne` | value equality IS structural |
| `String`                    | `call $str_eq` (`!=` wraps `i32.eqz`) | content equality       |
| `List(a)` / payload ADT     | `(unreachable)` + named peer          | deep structural eq is peer `Hβ.eq.structural-deep` (element-type-directed derived projection per the `to_string` dispatch precedent) |

**Drift refusal:** `==` on a heap type never emits pointer comparison —
pointer-eq lying as structural equality is the silent fallback
`protocol_no_silent_fallback.md` forbids. `str_eq` remains the
substrate fn `==` lowers to; it is no longer developer-facing law.

---

## Canonical layout (formatter canon)

Layout is never semantics. The precedence table alone draws the
tree; the formatter projects the canonical shape at save. Nothing
below is parser-enforced — it is what `mentl fmt` writes.

### Sequential verbs at LEFT EDGE

`|>` and `~>` sit at the left edge of the code's enclosing indent. Each stage on its own indented line:

```
input
  |> stage_a
  |> stage_b
  ~> handler
```

### Convergent verbs at INDENTED CENTER

`<|`, `><`, `<~` sit at indented center (typically 4-space indent from the enclosing left-edge):

```
(branch_a)
    ><
(branch_b)
```

```
input
  <| (
    branch_a,
    branch_b,
  )
```

### Return to LEFT EDGE for continuing chain

After a convergent construct, the chain returns to the left edge:

```
(audio |> compress)
    ><
(ctrl  |> scale)
|> mix          // returns to left edge
~> sink
```

### Indentation discipline

**The medium handles formatting; the developer types meaning.**

Mentl's canonical layout: 2-space indent for left-edge verbs (`|>`, `~>`, `<|`); 4-space indent for indented-center convergent verbs (`><`, `<~`). The shape on the page IS the computation graph (per §36 governing principle 1).

**Parse rule** (relative ordering, not absolute counts):
- Left-edge verbs MUST be indented MORE than their input.
- Convergent verbs (`><`, `<~`) MUST be indented at least as much as left-edge verbs of the same chain.
- Each stage of a `|>` / `~>` chain at the SAME indent as its peers within the chain.
- Within a `<|` branch tuple, branches at the SAME indent as each other.

Tabs are accepted at parse time and converted to spaces by the formatter. Absolute column counts are NOT enforced at parse — what matters is structural ordering. This applies the chain-link-5 discipline (`protocol_parse_is_eager_graph_projection.md`) at the layout layer: indent is a render decision, not a parse contract.

**Render rule** (canonical):
- The formatter renders code in canonical 2-space / 4-space form on save.
- The `Format` effect at `src/format.mn` declares `format_program` / `format_at_handle` / `format_chain` ops; `format_default` is the canonical handler.
- `mentl edit` (built-in) auto-formats continuously — keystroke triggers parse → format → render. The developer never sees badly-indented code because the medium normalizes before display.
- The LSP transport (external editors via VS Code / vim / Emacs) provides format-on-save through the same `format_default` handler, different transport.
- Tabs in the on-disk file are converted to spaces at the next save; the renderer's indent-width preference is per-developer (editor setting), but the file on disk is canonical for L1 byte-identity and version-control determinism.

**Composition**: the formatter is a `~>` handler in the cursor stack:

```
keystroke
  |> tokenize
  |> parse_to_graph
  ~> format_default
  ~> render_to_transport
    <~ accumulate(graph)
```

Per `protocol_oracle_is_ic.md`: format is idempotent (`format(format(x)) == format(x)`), so the IC fixpoint converges in one iteration. The format problem dissolves into the cursor projection.

---

## Generic type parameters

### Declaration

```
fn map(f: a -> b, xs: [a]) -> [b] = ...
type Pair = {first: a, second: b}
effect State { get() -> s; set(v: s) -> () }
```

No declaration list. Lowercase identifiers in type position ARE the
parameters (the case rule carries the meaning); they scope to the
declaration that mentions them, and every mention of the same name
within one declaration is the same parameter. Angle brackets are
retired everywhere — `E_ExplicitTypeParams` fires on any `<...>`
parameter list or argument list (MachineApplicable: strip it).

### Inferred at call sites

```
let doubled = map(double, [1, 2, 3])   // A=Int, B=Int — inferred from arg types
```

No turbofish (`map<Int, Int>(...)`) is allowed. Inference must succeed; if it can't, it's a type error indicating the user needs to provide more context (typically by annotating an intermediate let-binding).

### Higher-rank parameters

For polymorphism that crosses scopes (rare; usually inferred):
```
fn run_with<E>(f: fn() -> () with E) = ...
```

---

## Refinement types

```
type Sample = Float where -1.0 <= self <= 1.0
type NonEmpty = [a] where len(self) > 0
type ValidPort = Int where self >= 1024 && self <= 65535
```

`self` refers to the value being refined. The refinement is a `Predicate`; the `Verify` effect discharges the obligation at construction sites.

Construction:
```
let s: Sample = 0.5    // verify discharges -1.0 <= 0.5 <= 1.0 statically
let p: ValidPort = 8080 // statically discharged
```

Refinement violations:
```
let bad: Sample = 1.5   // E_RefinementRejected: 1.5 violates -1.0 <= self <= 1.0
```

---

## Top-level program structure

A `.mn` file is a sequence of top-level statements. Each is one of:

- `import path/to/module` — module imports
- `type Name<P> = ...` — type declarations
- `effect Name { ... }` — effect declarations
- `handler name(...) with ... { ... }` — handler declarations
- `fn name(...) = ...` — function declarations
- `let name = ...` — top-level value bindings (constants)

A `.mn` file with no `main` function is a LIBRARY module — its declarations are imported by other modules. Compilation produces a WAT module whose `_start` is a clean exit.

A `.mn` file with `fn main()` is an EXECUTABLE — `_start` invokes `main`.

---

## Token enumeration

The lexer emits a stream of `Token` values. The parser consumes them via exhaustive match. Both the wrapper shape and the variant enumeration are canonical here; Ω.4's parser refactor implements them exactly.

### Token wrapper — substrate-native pattern

```
type Token = Tok(TokenKind, Span)
```

This mirrors the `N(NodeBody, Span, Int)` wrapper for AST nodes: a structured-value with positional metadata. Every token carries its source span for parser diagnostics and downstream Located reasons.

Accessors:
```
fn token_kind(t) = let Tok(k, _) = t; k
fn token_span(t) = let Tok(_, s) = t; s
```

### TokenKind variants — exhaustive

```
type TokenKind
  // ─── Keywords ─────────────────────────────────────────────────────
  = TFn | TLet | TIf | TElse | TMatch | TType
  | TEffect | THandle | THandler | TWith
  | TResume | TPerform
  | TImport | TWhere
  | TOwn | TRef | TPure
  | TTrue | TFalse
  | TCapability                      // capability KEYWORD — see §«Capability declarations»
  // Note: `loop`, `break`, `continue`, `return`, `for`, `in` are NOT
  // reserved keywords — Mentl has no imperative control flow constructs.
  // Iteration is via `|>` + `<~` + `Iterate` effect handlers.
  // Early-exit is via `Abort` effect + `catch_abort` handler.
  // The gradient teaches the substrate at the friction-point: when a user
  // types `for x in xs`, `E_NotAKeyword` surfaces a Quick Fix to the
  // verb form `xs |> for_each((x) => ...)`. See
  // `docs/specs/simulations/syntax/iteration-substrate.md` for the
  // canonical iteration patterns and gradient teaching.

  // ─── Identifiers and literals (carry payload) ─────────────────────
  // Constructors share ONE namespace (env entries). The literal-token
  // trio is named TIntLit/TFloatLit/TStringLit because Ty's canonical
  // nullary TInt/TFloat/TString (spec 02) already claim the bare names —
  // two declarations claiming one constructor name shadow silently and
  // mis-unify (the 2026-06-09 "expected Ty, found TokenKind" ×95 class).
  | TIdent(String)
  | TIntLit(Int)
  | TFloatLit(Float)
  | TStringLit(String)
  | TDocComment(String)             // /// — emitted ONLY when triple-slash
                                    //   detected; attaches to next decl

  // ─── Two-character operators ──────────────────────────────────────
  | TEqEq | TBangEq | TLtEq | TGtEq          // comparison
  | TArrow | TFatArrow                       // -> and =>
  | TPlusPlus                                // ++ concat
  | TPipeGt | TLtPipe | TGtLt | TTildeGt | TLtTilde   // five verbs
  | TAndAnd | TOrOr                          // logical
  // `::` is NOT a token. Module paths use `/` at import position;
  // `.` is the one access operator in expressions. A token with no
  // kernel correspondence is speculative inventory.

  // ─── Single-character operators and punctuation ───────────────────
  | TLParen | TRParen | TLBrace | TRBrace | TLBracket | TRBracket
  | TComma | TDot | TColon | TSemicolon
  | TPlus | TMinus | TStar | TSlash | TPercent
  | TEq | TLt | TGt | TBang
  | TPipe | TTilde | TAt | THole

  // ─── Layout / structural ──────────────────────────────────────────
  | TNewline                        // semantic per DESIGN Ch 2 / `~>` form
  | TEof                            // end of input — always last
```

### Variant catalog (canonical lexical form, payload, expected parse contexts)

| Variant         | Lexical form     | Payload   | Where parser expects it                       |
|-----------------|------------------|-----------|------------------------------------------------|
| **Keywords (24)** |                |           |                                                |
| `TFn`           | `fn`             | —         | start of function declaration / lambda         |
| `TLet`          | `let`            | —         | start of let-binding                           |
| `TIf`           | `if`             | —         | start of if-expression                         |
| `TElse`         | `else`           | —         | between if branches                            |
| `TMatch`        | `match`          | —         | start of match-expression                      |
| `TType`         | `type`           | —         | start of type declaration                      |
| `TEffect`       | `effect`         | —         | start of effect declaration                    |
| `THandle`       | `handle`         | —         | start of handle-expression                     |
| `THandler`      | `handler`        | —         | start of handler declaration                   |
| `TWith`         | `with`           | —         | effect clauses, handler state, handle-with     |
| `TResume`       | `resume`         | —         | inside handler arm body                        |
| `TPerform`      | `perform`        | —         | format-liftable ceremony — ops are invoked as bare calls (§«Invoking effect operations»); lexed so the formatter can strip it (`E_RedundantPerform`); dissolves with peer `Hβ.syntax.perform-dissolution` |
| *(removed)*     | —                | —         | `for`, `in`, `loop`, `break`, `continue`, `return` were previously reserved but are NOT Mentl keywords. Iteration uses pipe verbs + Iterate effect; early-exit uses Abort effect. |
| `TImport`       | `import`         | —         | top-level import statement                     |
| `TWhere`        | `where`          | —         | refinement type clause                         |
| `TOwn`          | `own`            | —         | parameter ownership marker                     |
| `TRef`          | `ref`            | —         | parameter borrow marker                        |
| `TPure`         | `Pure`           | —         | `with Pure` declaration                        |
| `TTrue`         | `true`           | —         | Bool literal                                   |
| `TFalse`        | `false`          | —         | Bool literal                                   |
| `TCapability`   | `capability`     | —         | capability declaration (§«Capability declarations») |
| **Identifiers and literals (5)** |  |           |                                                |
| `TIdent(s)`     | `[A-Za-z_][...]` | name      | variable refs, fn names, type names, etc.      |
| `TIntLit(n)`    | `[0-9][0-9_]*`, `0x[0-9A-Fa-f_]+`, `0b[01_]+`, `0o[0-7_]+` | i32 value | integer literal (decimal / hex / binary / octal; underscores allowed for readability) |
| `TFloatLit(f)`  | `[0-9][0-9_]*\.[0-9][0-9_]*` | f64 value | floating-point literal (underscore separators allowed) |
| `TStringLit(s)` | `"..."` or `"""..."""` | string content (escape-resolved, interp markers preserved) | string literal |
| `TDocComment(s)`| `/// ...`        | comment text (one line, leading `///` stripped) | attaches to next declaration |
| **Two-character operators (14)** |  |           |                                                |
| `TEqEq`         | `==`             | —         | equality comparison                            |
| `TBangEq`       | `!=`             | —         | inequality comparison                          |
| `TLtEq`         | `<=`             | —         | less-than-or-equal                             |
| `TGtEq`         | `>=`             | —         | greater-than-or-equal                          |
| `TArrow`        | `->`             | —         | function return type, fn-type form             |
| `TFatArrow`     | `=>`             | —         | match arm separator, lambda body separator     |
| `TPlusPlus`     | `++`             | —         | string/list concat                             |
| `TPipeGt`       | `\|>`            | —         | sequential pipe                                |
| `TLtPipe`       | `<\|`            | —         | divergent pipe (fanout)                        |
| `TGtLt`         | `><`             | —         | parallel compose (structural N-ary)            |
| `TTildeGt`      | `~>`             | —         | handler-attach (block / inline by newline)     |
| `TLtTilde`      | `<~`             | —         | feedback                                       |
| `TAndAnd`       | `&&`             | —         | logical and                                    |
| `TOrOr`         | `\|\|`           | —         | logical or                                     |
| **Single-character operators and punctuation (23)** |  |           |                              |
| `TLParen`       | `(`              | —         | grouping, params, tuples, calls                |
| `TRParen`       | `)`              | —         | close grouping                                 |
| `TLBrace`       | `{`              | —         | blocks, records, handler arms, type variants   |
| `TRBrace`       | `}`              | —         | close LBrace                                   |
| `TLBracket`     | `[`              | —         | list literals, list patterns                   |
| `TRBracket`     | `]`              | —         | close LBracket                                 |
| `TComma`        | `,`              | —         | separator in tuples, params, fields, lists     |
| `TDot`          | `.`              | —         | field access                                   |
| `TColon`        | `:`              | —         | type annotation, record field binding          |
| `TSemicolon`    | `;`              | —         | canonical-never — newlines separate statements; lexed so the formatter can lift it to newline layout (`E_StatementSemicolon`) |
| `TPlus`         | `+`              | —         | addition; effect union                         |
| `TMinus`        | `-`              | —         | subtraction; unary negate                      |
| `TStar`         | `*`              | —         | multiplication                                 |
| `TSlash`        | `/`              | —         | division; module-path separator                |
| `TPercent`      | `%`              | —         | modulo                                         |
| `TEq`           | `=`              | —         | binding (let / fn / type)                      |
| `TLt`           | `<`              | —         | less-than; generic-param open                  |
| `TGt`           | `>`              | —         | greater-than; generic-param close              |
| `TBang`         | `!`              | —         | logical not; effect negation                   |
| `TPipe`         | `\|`             | —         | type variant separator; lambda param fence (`\|x\| expr`) |
| `TTilde`        | `~`              | —         | reserved                                       |
| `TAt`           | `@`              | —         | as-patterns: `name @ pat` binds the whole value AND destructures (§«As-patterns»); `@resume=` erased per inference-from-body |
| `THole`         | `??`             | —         | hole — the gradient's syntactic absence marker; Mentl's Synth proposes candidates filling the position. The Mentl Mono ligature renders `??` as the octagonal-socket glyph (8 sides ↔ 8 kernel primitives). Single `?` is no longer a token. |
| **Layout / structural (2)** |     |           |                                                |
| `TNewline`      | `\n`             | —         | semantic per DESIGN Ch 2 (block-form `~>`)     |
| `TEof`          | (end of input)   | —         | always last token; parser uses to terminate    |

**Total: 68 variants.** (`TColonColon` deleted 2026-06-10 — `::` was lexed and parsed nowhere; a token with no kernel correspondence is speculative inventory. Module paths use `/` at import position only; `.` is the one access operator in expressions. See `perform-dissolution-substrate.md` §6.)

### Lexer obligations

- **Every emitted Token MUST be one of the 69 enumerated variants.** Adding a new token kind requires updating SYNTAX.md first, then the lexer, then the parser's match (which fails to compile until the new variant is handled — H6's discipline applied at the lexical layer).
- **Whitespace (other than `\n`) is silently consumed.** The lexer skips spaces and tabs without emitting a token. Only newlines are semantic.
- **Line comments `// ...` are silently consumed.** No token emitted.
- **Doc comments `/// ...` emit `TDocComment(text)`** with the leading `///` stripped. The parser attaches each `TDocComment` to the next declaration it sees.
- **Block comments do not exist.** Per the Comments section of this spec.

### Parser obligations

- **Match on `Token` must be exhaustive.** No wildcard arms over `TokenKind` without explicit per-variant enumeration. H6's discipline: `_ => …` on a load-bearing ADT is rejected by code review and substrate convention.
- **Span propagation.** Every parsed AST node is constructed with the joined span of its constituent tokens. Use `span_join(token_span(first), token_span(last))`.
- **Generic-type angle brackets disambiguated by context.** `<` and `>` are TLt/TGt at expression position; in type position (after `:`, `->`, in fn-decl angle params), they open/close generic parameter lists. This is parser-internal context tracking, not a separate token kind.
- **Pipe-vs-or disambiguation.** `|` is TPipe (variant separator in `type` body + pattern alternation in match arm body); `||` is TOrOr (logical or). No `|x|` lambda fence — lambdas use `(params) => body`.

### `if` without `else` — unit-returning conditional

An `if cond { body }` without `else` is legal when `body`'s type is unit `()`. The compiler inserts an implicit `else { () }`. Used for side-effect conditionals:

```
if should_log { perform log("message") }     // unit body — OK
if x > 0 { x * 2 }                            // non-unit body — E_IfMissingElse
```

Diagnostic on non-unit if-without-else: **`E_IfMissingElse`** with Quick Fix suggesting either adding an `else` branch or restructuring. Lowers the "forgot the else accidentally" class of bug to a compile error.

---

## Diagnostic catalog (syntax-level errors introduced by SYNTAX.md)

Mentl's diagnostics are TEACHING surfaces, not punishment. The catalog is classified into three categories per substrate role:

- **Format-liftable** — the formatter (`format_default` handler) auto-corrects on save / auto-format keystroke. The user does not see the diagnostic; the medium silently applies the rewrite.
- **Hard error** — substrate violation; the user must restructure. The medium cannot auto-recover.
- **Gradient narration** — not an error; a teaching surface in Mentl's voice. The user may accept or dismiss.

Every diagnostic carries:

- **Located reason chain** — source span + `ReasonKind`
- **Applicability tag** — `MachineApplicable` / `MaybeIncorrect` / `HasPlaceholders` / `Unspecified`
- **Quick Fix Patch** — where mechanically derivable

The applicability tag determines automation: `MachineApplicable` patches are auto-applied; `MaybeIncorrect` surfaces with user confirmation; `HasPlaceholders` requires user fill-in; `Unspecified` is text-only.

### Format-liftable (formatter handles silently)

| Code                  | Trigger                                       | Formatter action                                |
|-----------------------|-----------------------------------------------|--------------------------------------------------|
| `E_RedundantBraces`   | braces around single-expression body          | strip the braces; user sees no diagnostic       |
| `E_ExplicitTypeParams`| turbofish `f<T>(...)` at call site            | strip the type params; user sees no diagnostic  |
| `E_IndentMismatch`    | wrong indent count                            | normalize indent; user sees no diagnostic       |
| `E_RedundantPerform`  | `perform` before an op call                   | strip the keyword; ops are invoked as bare calls (§«Invoking effect operations») |
| `E_StatementSemicolon`| `;` between statements                        | lift to newline layout; canonical text never contains `;` |

### Hard errors (substrate violations)

| Code                  | Trigger                                       | Applicability        | Quick Fix                                      |
|-----------------------|-----------------------------------------------|----------------------|-------------------------------------------------|
| `E_PatternInexhaustive` | match missing variants, no wildcard         | `HasPlaceholders`    | insert stubs for missing variants              |
| `E_RefinementRejected`| value violates refinement predicate           | `Unspecified`        | adjust value or widen refinement               |
| `E_EffectMismatch`    | declared row doesn't subsume body row         | `MaybeIncorrect`     | widen declaration OR install absorbing handler |
| `E_PurityViolated`    | `with Pure` body performs non-empty effects   | `MaybeIncorrect`     | remove `with Pure` or absorb the effect        |
| `E_FeedbackNoContext` | `<~` used without iterative context           | `MaybeIncorrect`     | install `Sample`/`Tick`/`Clock` handler        |
| `E_OwnershipViolation`| `own` consumed twice / escapes ref scope      | `Unspecified`        | restructure to single-consume or use `ref`     |
| `E_HandlerUninstallable` | handler arms need effects context disallows | `MaybeIncorrect`   | widen ambient row or restructure handler       |
| `E_MissingVariable`   | name not in scope                             | `MaybeIncorrect`     | check spelling; check imports                  |
| `E_TypeMismatch`      | unification failed                            | `Unspecified`        | adjust types; widen / narrow                   |
| `E_OccursCheck`       | infinite type                                 | `Unspecified`        | restructure to break cycle                     |
| `E_OrphanHandlerAttach` | `~>` with no preceding chain                | `Unspecified`        | delete `~>` or supply body                     |
| `E_BranchNotStage`    | `><` branch is a value, not a stage (infer-time; peer `Hβ.infer.pcompose-branch-stage-type`) | `MaybeIncorrect` | rewrite branch as a pipeline |
| `E_NotAKeyword`       | user typed `for`/`while`/`loop`/`break`/`continue`/`return` | `MaybeIncorrect` | rewrite as verb form per substrate             |
| `E_PatternAlternationBindingMismatch` | branches in `\|` bind different names or types | `MaybeIncorrect` | adjust patterns to bind same names with unifiable types |
| `E_ResumeOutsideArm`  | `resume` outside a handler-arm body           | `Unspecified`        | move the resume into an arm; the continuation only exists there |
| `E_ConcatTypeMismatch` | `++` operands have unifiable but distinct types (e.g. `TList` ++ `TString`) | `MaybeIncorrect` | unify operand types via conversion |
| `E_ConcatTypeUnresolved` | `++` operand type not bound at lower-time | `MaybeIncorrect`    | annotate operand to constrain type             |

### Gradient narration (teaching surfaces)

| Code                  | Trigger                                       | Applicability        | Action                                          |
|-----------------------|-----------------------------------------------|----------------------|-------------------------------------------------|
| `T_OverDeclared`      | declared row wider than body uses             | `MachineApplicable`  | tighten the signature to unlock capabilities    |
| `T_Gradient`          | an annotation INPUT would narrow the cursor's projection | `MachineApplicable` | accept the suggestion to narrow             |
| `W_Suggestion`        | probable Quick Fix available                  | `MaybeIncorrect`     | (Mentl-proposed)                                |
| `W_RedundantWhere`    | `type X = Y where true` — vacuous predicate   | `MachineApplicable`  | drop the `where true`; alias is transparent     |
| `W_CapabilityEmpty`   | `capability X = ...` row resolves to `Pure`   | `MaybeIncorrect`     | drop the declaration; the row IS Pure already   |
| `P_ExpectedToken`     | parser expected one token kind, found another | `MaybeIncorrect`     | (parser-emitted; pre-substrate-classification)  |
| `P_UnexpectedToken`   | token kind not valid at this position         | `MaybeIncorrect`     | restructure per the surrounding form            |
| `P_UnclosedConstruct` | EOF inside a construct (block, match arms, etc.) before its closer | `MaybeIncorrect` | close the construct OR remove its opening token |

See `docs/specs/simulations/syntax/diagnostic-catalog-substrate.md` for the substrate analysis.

---

## Cross-references

- DESIGN.md Ch 2 — the five verbs, with worked examples
- DESIGN.md Ch 4 — the substrate (graph + handler)
- SUBSTRATE.md §II — Visual Programming in Plain Text; Five Verbs Are a Complete Topological Basis
- spec 03 — Typed AST (NodeBody, Expr, Stmt, Pat)
- spec 10 — Pipes (PipeKind, layout enforcement)
- spec 11 — Clock (iterative context for `<~`)
- protocol_pattern_completion_check.md — output-boundary discipline

---

## What this document is NOT

- NOT a tutorial. See `examples/` for tutorials.
- NOT a reference for stdlib functions. See `std/` source + generated docs.
- NOT a description of the current parser. The parser implements this; where they disagree, the parser is wrong.
- NOT an aspirational wishlist. Every form here is required to land in the parser by Phase Ω.4.

---

## Authority

This document supersedes any syntactic decisions implicit in DESIGN.md, SUBSTRATE.md, the 12 specs, or current parser behavior. Where another document conflicts with SYNTAX.md, SYNTAX.md is correct and the other document gets a corrective revision.

Mentl's discipline applies to syntax: every form below was decided by asking the eight interrogations — one per kernel primitive (DESIGN.md §0.5), one per Mentl tentacle. Graph (what AST does it produce?), handler + inferred resume cardinality (what installed handler reads it, what cardinality does the arm body prove?), verb (which topology?), row (what `+ - & !` constraint does the body's perform sites prove?), ownership (what `own`/`ref` does the use-count infer?), refinement (what predicate does the path narrow?), gradient (what annotation INPUT or body-structure unlocks the cursor's projection here?), Reason (what edge does it leave for the Why Engine?). Forms that failed any of the eight were rejected. **Annotations declare INPUTS to the cursor; never the emergent property itself** (per `protocol_cursor_is_the_substrate.md`).

When questions arise about syntax not yet covered here: open a γ-style walkthrough in `docs/specs/simulations/syntax/<topic>.md`, resolve the design question, then update this document.
