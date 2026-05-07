# Mentl — Substrate

**What this is.** The canonical substrate of Mentl — load-bearing structural facts the medium is built from. Compiler-verifiable theorems, not vision.

**How to read it.** Cursor-adjacent. CLAUDE.md cites sections by name; load only what the cursor needs. Not always-loaded; not Session-Zero-bulk-read. (Insight #15 — MRCR cliff under Opus 4.7+.)

**What lives elsewhere.**
- Highest-altitude thesis: `docs/ULTIMATE_MEDIUM.md` (Phase μ anchor)
- Manifesto / vision: `docs/DESIGN.md`
- Discipline crystallizations: `/home/suds/.claude/projects/-home-suds-Projects-mentl/memory/protocol_*.md`
- Per-handle design walkthroughs: `docs/specs/simulations/`
- Per-module declarative contracts: `docs/specs/00–11-*.md`
- Live sequencing: `ROADMAP.md`

---

# § I · Foundations

### The Minimal Kernel — The Eight Primitives

*Load-bearing together. Removing any one collapses the thesis AND
costs Mentl a tentacle. See DESIGN.md §0.5 for the authoritative
enumeration; the list below is the shorthand every other insight
composes from.*

1. **Graph + Env** — the program IS the graph; every output is a handler projection. *(Mentl tentacle: **Query**.)*
2. **Handlers with typed resume discipline** — `handle`/`resume` replaces six+ named patterns; resume cardinality (OneShot / MultiShot / Either) is INFERRED from each arm body's resume sites under control-flow ancestry, never authored as annotation; the inferred cardinality attaches to the op's continuation type and drives lower's tier selection; MultiShot is the substrate Mentl's oracle uses to explore hundreds of alternate realities per second; `~>` chains ARE capability stacks. *(Tentacle: **Propose**.)*
3. **Five verbs** — `|>` `<|` `><` `~>` `<~` — topologically complete basis for computation graphs. *(Tentacle: **Topology**.)*
4. **Full Boolean effect algebra** — `+ - & ! Pure`; negation (`!E`) proves ABSENCE; four compilation gates fall out of one subsumption. *(Tentacle: **Unlock**.)*
5. **Ownership as an effect** — `own` performs `Consume`, `ref` is a row constraint; no lifetime annotations; Rust-level safety without the ceremony. *(Tentacle: **Trace**.)*
6. **Refinement types** — compile-time proof, runtime erasure; `Verify` effect swappable to SMT by residual theory. *(Tentacle: **Verify**.)*
7. **The continuous gradient** — the gradient is continuous, derived (gates_unlocked × proximity per `cursor.mn`); annotations are INPUTS that unlock gradient ascent at a position. The gradient itself is never authored — it emerges from the cursor reading the kernel's truth at P. Bottom and top converge; Mentl surfaces ONE next step per turn. *(Tentacle: **Teach**.)*
8. **HM inference, live, one-walk, productive-under-error, with Reasons** — the light every handler projection reads by; Why Engine walks the reason DAG. *(Tentacle: **Why**.)*

**Composition IS the medium.** Every insight below, every
framework-dissolution, every performance claim, every teaching
surface — a consequence of these eight composed. Mentl is not a
programming language; it is the **ultimate intent → machine
instruction medium** that also raises its users into better
programmers. The programs are the means; the programmers they
become are the end.

**Mentl is an octopus because the kernel has eight primitives.**
Lose a tentacle, lose a primitive; lose a primitive, lose a
tentacle. The mascot framing is architectural, not decorative.

#### The eight primitives ARE the eight interrogations ARE Mentl's eight tentacles

The same eight are also **the eight structural questions asked
before every line of Mentl**, one per primitive, AND **the eight
tentacles of Mentl's voice**. Graph? Handler? Verb? Row?
Ownership? Refinement? Gradient? Reason? Pass all eight, type the
residue. This is the full method — for writing, reading, teaching,
debugging, code review, and Mentl's internal voice grammar. See
CLAUDE.md or DESIGN.md §0.5 for the expanded forms. **One kernel;
eight primitives; eight interrogations; eight tentacles; one
method applied at every level.**

---


### The First Truth: Inference IS the Light

*Everything else in this document is a consequence of this.*

The type inference engine produces knowledge: what every binding is, what
every expression returns, what effects every function performs. That
knowledge IS the product. Not compilation. Not error checking. The
KNOWLEDGE ITSELF.

Every consumer of that knowledge is a handler:
- **Codegen** — the handler that turns type knowledge into machine code
- **LSP** — the handler that turns type knowledge into hover info
- **Teaching** — the handler that turns type knowledge into the gradient
- **Errors** — the handler that turns type knowledge into diagnostics
- **The user** — the handler that turns type knowledge into understanding

One inference. Many handlers. Same mechanism as everything else in Mentl.


### The Second Truth: Zero-Cost Linearity & Scoped Arenas

*Memory is not a hidden runtime system. It is physical, and it is governed by effect algebras.*

We do not use Garbage Collectors, nor do we use immutable "Snoc Trees" to fake immutability. The compiler emits raw, in-place, zero-allocation mutations in flat contiguous linear memory. 

- **The Alloc Effect:** Memory allocation is just an effect. By wrapping memory-heavy operations in a `temp_arena` handler, gigabytes of memory are instantly dropped in $O(1)$ time simply by letting the handler scope drop. No sweeping GC passes.
- **Escape Analysis via Region Inference:** To prevent the Use-After-Free bugs of C++ arenas, the compiler natively enforces lifetime bounds through hidden Region variables (`Tofte-Talpin`). If a returned pointer outlives its `Alloc` handler scope, the compiler forces a hard error. 


### The Third Truth: The Duty of Inference is Reification

*Abstract algebra must materialize into one concrete shape.*

`infer.mn` does not just "type-check" code. Its ultimate duty is to
physically synthesize evidence — the concrete closure records that
carry captures, handler state, and resume discipline **together, in
one record shape**. **There is no vtable. There is no separate
dictionary. There is no `*const ()` parameter smuggled alongside the
closure.** The heap has one story (γ crystallization #8): closure
records, ADT variants, nominal records, and closures-with-evidence
all allocate through the SAME `emit_alloc` swap surface — bump today,
arena tomorrow, GC eventually. Change the allocator; every dispatch
claim holds.

Three resume disciplines map to three emit paths on one substrate:

- **OneShot.** Direct `return_call $op_<name>`. The graph proves the
  handler chain ground at inference time. >95% of dispatch sites per
  H1 evidence reification. Zero indirection.
- **MultiShot.** Heap-captured closure struct (captures + evidence
  fields + return slot), allocated through `emit_alloc`. **This IS
  Mentl's oracle substrate**; multi-shot resumes explore hundreds of
  alternate realities per second through trail-based rollback on
  this primitive.
- **Polymorphic minority.** `call_indirect` reads a function-pointer
  FIELD on the closure record — one `i32` at the offset the inference
  pass placed. Evidence passing per Koka JFP 2022; **not vtable
  indirection.** No table exists as a separate structure at any
  layer — source, LIR, LowIR, WAT, or emitted binary.

Monomorphization speed, zero code bloat, one allocator swap for every
memory strategy past, present, and future.

---


### Self-Hosting IS the Proof

The self-hosted compiler is not vanity. It's the ultimate test:

> If Mentl can express its own compiler cleanly, it can express anything.

```
source → [lexer.mn] → [parser.mn] → [checker.mn] → [codegen.mn] → bytecode → execute
```

All four modules are written in Mentl. The compiler compiles itself. The
bootstrap loop is closed. Every subsequent improvement to Mentl is written
IN Mentl and compiled BY Mentl.

The Rust implementation becomes historical. Not deprecated — historical.
Like the OCaml implementation of Rust. A stepping stone that served its
purpose and was surpassed by the thing it helped create.

---


### Kernel Closure: All Eight Primitives Structurally Live

*2026-04-24. Crystallized at the close of B.9 LFeedback substrate
(commit `7f8ff5f`), which completes Primitive #3 (Five verbs).*

The eight kernel primitives — **(1)** Graph + Env / **(2)** handlers
with typed resume discipline / **(3)** five verbs `|> <| >< ~> <~` /
**(4)** full Boolean effect algebra / **(5)** ownership-as-effect /
**(6)** refinement types / **(7)** annotation gradient / **(8)** HM
inference + Reasons — are now ALL substrate-live. Not "designed and
walkthrough-closed" — substrate-live, with code in `src/` + `lib/`
implementing each.

Roll-call:

| Primitive | Substrate site | Status |
|---|---|---|
| #1 Graph + Env | `src/graph.mn`, `src/types.mn` | live since γ cascade |
| #2 Handlers + resume discipline | `src/lower.mn` LMakeContinuation; `lib/runtime/{search,combinators,arena_ms}.mn`; `src/backends/wasm.mn` H7 emit | live with multi-shot quartet (H7 + B.3 + B.4 + B.5) |
| #3 Five verbs | `<~` LFeedback emit completion | LIVE NOW (B.9) — last verb closes |
| #4 Boolean effect algebra | `src/effects.mn` row algebra | live since γ cascade |
| #5 Ownership-as-effect | `src/own.mn` Consume effect | live since γ cascade |
| #6 Refinement types | `src/verify.mn` verify_ledger handler | live; verify_smt handler-swap (Arc F.1) is post-first-light upgrade |
| #7 Annotation gradient | `src/mentl.mn` Teach effect ops | live in shape |
| #8 HM + Reasons | `src/infer.mn` one-walk HM with Reason chain | live since γ cascade |

**This is the closure moment for the kernel-as-substrate.** No
primitive is now "declared but unimplemented." Every primitive has
LIR support, has emit support, has at least one handler implementation,
and composes with the others.

**What this does NOT mean.** The kernel is structurally closed; it is
NOT yet *demonstrated end-to-end*. Crucibles are seeds (acceptance
criteria, not running tests). Domain libraries (`lib/dsp/`, `lib/ml/`)
remain pre-Ultimate-Mentl and need DM rewrite (B.10 + B.11). The
oracle's voice surfaces (LSP adapter, F.1 mentl doc) are pending. Most
critically: the bootstrap translator (items 26-31) hasn't been
written — first-light is reached only when `diff mentl2.wat mentl3.wat`
is empty, and that's bootstrap work the kernel-substrate enables but
doesn't accomplish.

**What this DOES mean.** The next moves can compose on a complete
kernel. B.10/B.11 can use parameterized Sample(rate), the multi-shot
quartet, `<~` feedback, all eight primitives — and the substrate
will respond correctly. MV.2.e Interact handler arms can install over
all eight tentacles knowing each tentacle has substrate to query.
Bootstrap can hand-WAT against a kernel whose every shape is final
(no more "we'll add primitive X later"). The kernel is the contract
the bootstrap writes against; that contract is now sealed.

**The eight interrogations gain weight.** Pre-closure, asking "what
handler already projects this?" sometimes had no answer because the
substrate wasn't there. Post-closure, every interrogation has a
concrete substrate site to point to. The interrogation discipline
shifts from "find what should be there" to "find what IS there" — a
strictly stronger discipline.

**The cascade discipline (Anchor 7) earned its weight.** Each handle
was walkthrough-first; each walkthrough resolved design before code
froze; each commit closed one handle in residue form. The cumulative
result is a kernel that no single design pass would have produced —
the substrate accumulated correctness through dozens of small,
audited, drift-clean landings. Closure is the cumulative artifact of
the discipline, not a separate event.

**The next phase is composition, not invention.** From here, work
COMPOSES on the kernel rather than EXTENDING it. New domains (DSP,
ML, web, parallel, real-time) project from the eight primitives via
handler stacks. New surfaces (LSP, doc, REPL, debugger) are handlers
on existing substrate. New optimizations (verify_smt, native backend,
SIMD/BLAS) are handler swaps that source code never sees. **The
medium is whole.** What follows is the medium being put to work.

---


---

# § II · Topology — The Five Verbs

### The Five Verbs — Topology Drawn on the Page

The pipe operators are not syntax sugar. They are the **five topological
shapes every computation graph needs**, made visible in one line of code.
Together they unify DSP, ML, compilers, control systems, and every other
directed graph the industry has been drawing on separate whiteboards.

| Verb | Topology | Shape | Reading |
|---|---|---|---|
| `\|>` | converge | ∧→ funnel right | "flow forward, merge at narrowing" |
| `<\|` | diverge | ∨→ fanout right | "flow forward, split at widening" |
| `><` | parallel compose | ✕ | "two pipelines interact side-by-side" |
| `~>` | tee / handler-attach | ⌐ | "observe; install handler" |
| `<~` | feedback | ⟲ | "close a cycle; prior output re-enters" |

```lux
// DSP signal chain with feedback (IIR filter)
input |> add(a) <~ delay(1) |> output

// ML computation graph with parallel branches and observation
data |> embed <| (attention_head_1, attention_head_2, attention_head_3)
     |> merge_heads ~> gradient_tracker |> output

// Compiler pipeline
source |> lex |> parse |> check |> compile

// Data pipeline with parallel fanout for enrichment
users |> filter(active) <| (profile_fetch, recent_orders) |> join |> take(10)

// Control loop with feedback
sensor |> pid_controller <~ delay(1) ~> telemetry |> actuator
```

Same syntax. Different effects. The shape of the code on the page IS the
shape of the computation graph. Most languages hide topology behind
call-stack structure; Mentl draws it.

**Why this matters.** The industry's artificial boundaries — DSP vs. ML
vs. compilers vs. control vs. data processing — dissolve. Libraries like
PyTorch and JUCE live in different worlds because their host languages
can't express the shared algebra. In Mentl, they're the same five verbs.
Swap a DSP stage for a learned component — types and effects still
compose. Close a feedback loop in a compiler pass — same `<~` as an IIR
filter. This solves an industry-scale problem through notation.

**Feedback (`<~`) is the one you haven't seen before.** Every other
language handles pipelines forward. Feedback loops — IIR filters, RNNs,
PID controllers, iterative solvers, reactive state — get hidden inside
handler declarations or state machines. Mentl makes the back-edge visible.
`y |> f <~ delay(1)` is *one line* that says: "y flows through f; f's
output, delayed, flows back into f." The topology is on the page.

**And — crucially — `<~` is not new machinery.** It's sugar for a
stateful handler capturing output and re-injecting it. `<~` doesn't
encode timing; the ambient handler decides. Under `Sample(44100)` it's
a sample delay (DSP). Under `Tick` it's a logical-step delay
(iteration). Under `Clock(wall_ms=10)` it's a control-loop delay. One
operator; topology-only semantics; handler decides interpretation. Mentl
solves Mentl.

---


### The Five Verbs Are a Complete Topological Basis

*2026-04-17. Crystallized from spec 10 + graph theory.*

The five pipe operators are not a design preference. They are a
**mathematically complete basis for computation graphs.** Any directed
graph you can draw on a whiteboard maps to one expression in these
operators.

| Graph operation | Verb | What it adds |
|---|---|---|
| Sequential edge (A → B) | `\|>` | Forward flow — every graph has these |
| Fanout (A → B, A → C) | `<\|` | Branching — one source, multiple sinks |
| Parallel join (A ⊔ B) | `><` | Independent subgraphs converging |
| Observation (A with side-channel) | `~>` | Annotation without modification |
| Back-edge (cycle closure) | `<~` | Extends DAGs to arbitrary directed graphs |

**Proof sketch.** The first four (`|>`, `<|`, `><`, `~>`) cover all
directed acyclic graphs (DAGs): any DAG decomposes into series (`|>`),
parallel (`><`), fanout (`<|`), and annotation (`~>`) compositions.
`<~` adds the single missing primitive — cycle closure — extending
coverage to all directed graphs with feedback.

**Why this matters for implementation.** When lowering pipe expressions
(spec 05), the emitter doesn't need ad-hoc cases. Every pipe topology
decomposes into these five primitives. Lowering is a fold over five
constructors, not a pattern-match against an open-ended set.

**Why this matters for the thesis.** The claim that "DSP, ML, compilers,
control systems, and data processing use the same notation" is not
marketing. It's a consequence of topological completeness. All five
domains produce directed graphs. Five operators draw all directed
graphs. Therefore five operators draw all five domains. QED.

---


### Visual Programming in Plain Text

*2026-04-17. Crystallized from the lexer's Newline token emission.*

The Mentl lexer emits `Newline` tokens. Spaces and tabs are silently
consumed. This means the parser is **layout-aware for pipe chains
only** — not for general indentation (Python's mistake), but for the
one place where visual layout is semantically load-bearing.

The consequence: **the shape of well-written Mentl code on the page IS
the shape of the computation graph.** Not metaphorically. The parser
reads the shape.

```lux
// What the developer sees:         What the compiler sees:
//
//  sensor                           sensor ────────────┐
//      |> pid_controller                               │
//      <~ delay(1)                  pid ←──── delay ←──┘  (cycle!)
//      ~> telemetry                      └──→ telemetry    (side-channel)
//      |> actuator                       └──→ actuator     (forward)
```

A `Newline` before `~>` tells the parser "this is Form A — wrap the
entire preceding chain." No `Newline` means Form B — wrap only the
immediately preceding stage. The visual indentation is cosmetic but
the newline is semantic.

#### Canonical Formatting Rules

The formatter (a handler on the graph) emits pipe chains in a
canonical layout where **the position of the operator IS the
topology:**

| Operator | Multi-line position | Topology drawn |
|---|---|---|
| `\|>` | Left-aligned, continuation line | Sequential — flow goes down |
| `~>` | Left-aligned, continuation line | Handler attachment — attaches downward |
| `><` | Indented center, between operands | Convergence — two branches pinch inward |
| `<\|` | Left-aligned, before tuple of branches | Fanout — one becomes many |
| `<~` | Indented center, after pipeline | Feedback — output loops back |

Sequential operators (`|>`, `~>`) sit at the left edge because flow
goes DOWN the page:

```lux
source
    |> frontend
    |> infer_program
    ~> graph_handler
    ~> diagnostics_handler
```

Convergence and feedback operators (`><`, `<~`) sit at the INDENTED
CENTER because they draw a different shape — a pinch point or loop:

```lux
(read_file(path) |> decode_utf8)
    ><
(read_file("errors.md") |> decode_utf8)

input |> transform
    <~ delay(1)
```

The indented `><` creates a visual pinch between two branches. The
indented `<~` creates a visual loop-back. The formatter enforces this
because the shape of the code IS the shape of the computation.

#### Inline `~>` vs Block-Scoped `~>` (Form B vs Form A)

Because `~>` has the **tightest precedence** of all pipe operators,
inline `~>` (no Newline) wraps only the immediately preceding
expression:

```lux
// Form B (inline) — each ~> wraps ONE stage
raw_string
    |> parse_json ~> catch_json_error(default = "{}")
    |> validate_schema ~> log_validation_warnings
    |> save_to_db
```

Parses as:
`raw_string |> (parse_json ~> catch_error) |> (validate ~> log_warn) |> save`

Each handler catches effects from ONE stage. The pipeline continues.
Per-stage error handling without try/catch.

Block-scoped `~>` (Newline before `~>`) wraps the **entire preceding
chain** — used when a handler should catch effects from all stages:

```lux
// Form A (block-scoped) — each ~> wraps the ENTIRE pipeline above
source
    |> frontend
    |> infer_program
    ~> env_handler           // catches EnvRead/Write from ALL above
    ~> graph_handler         // catches Graph* from ALL above
    ~> diagnostics_handler   // catches Diagnostic from ALL above
```

#### `<|` vs `><`: Ownership Is the Structural Difference

Both produce tuples. The distinction is input sharing:

```
<| (Diverge)
           ┌──► branch_a ──┐
[input] ───┤               ├─► (out_a, out_b)
           └──► branch_b ──┘
Input is SHARED (borrowed). Cannot consume own values. (`E_OwnershipViolation`)

>< (Parallel Compose)
[input_a] ──► process_a ──┐
                          ├─► (out_a, out_b)
[input_b] ──► process_b ──┘
Inputs are INDEPENDENT. Can safely consume own values.
```

`<|` implicitly **borrows** the input for all branches — Mentl has no
implicit copy. Pure values (Int, Bool, literals) are fine. `ref`
values are fine. `own` values are an affine violation: the compiler
catches it because `<|` is visible in the AST.

`><` has fully independent tracks. Each branch can consume its own
input. No crossover, no affine restriction.

#### Parameters ARE Tuples. `|>` Is a Wire. There Is No Splatting.

This is a settled truth. It is NOT a design question. Never re-open it.

A function `fn f(a, b, c)` has type `(A, B, C) -> D`. The parameter
list IS a tuple. Calling `f(x, y, z)` is applying the tuple `(x, y, z)`.

`|>` is transparent: it passes whatever is on the left to whatever is
on the right. It does not unwrap. It does not reassemble. It is a wire.

When `<|` or `><` produce a tuple `(A, B)` and you `|> merge`, the
inference engine unifies the tuple type against the function's parameter
types. This is not "auto-splatting" — it is structural unification.
The same mechanism that unifies `TInt` with `TInt`.

```lux
// <| produces (Low, Mid, High). mix_3 takes three arguments.
// Inference unifies (Low, Mid, High) with (Low, Mid, High) -> Out.
// This Just Works.
input <| (low_pass, band_pass, high_pass) |> mix_3

// If you want the tuple as a single value, say so:
input <| (low_pass, band_pass, high_pass) |> fn(bands) => log(bands)
// Inference unifies (Low, Mid, High) with ((Low, Mid, High)) -> Out.
// fn(bands) has ONE parameter of tuple type. This also Just Works.
```

The developer controls arity through their function signature.
No language rule needed. No special case. One mechanism.

---


### Feedback Is Mentl's Genuine Novelty

*2026-04-17. Crystallized from spec 10's `<~` design.*

Every other language hides feedback loops:

| Language | How feedback is expressed | Visible? |
|---|---|---|
| C/Python | `prev = current; current = f(prev)` | No — hidden in mutable assignment |
| Haskell | `fix (\self -> ...)` or `iterate` | No — hidden in recursion |
| Rust | `loop { state = f(state); }` | No — hidden in loop body |
| RxJS | `.pipe(scan(...))` | Partially — `scan` implies accumulation but topology is opaque |
| Mentl | `x \|> f <~ delay(1)` | **Yes — the back-edge IS the operator** |

`<~` makes the cycle a first-class syntactic construct. The compiler
sees it in the AST (`PipeExpr(PFeedback, left, right)`). This enables:

1. **Static verification.** The compiler checks that an iterative
   context handler (Iterate, Clock, Tick, Sample) is installed.
   Feedback without a clock is a type error, not a hang.
2. **Ownership checking.** `own` values through `<~` is an affine
   violation — the value is consumed each iteration. The compiler
   catches this because it can see the back-edge.
3. **Domain-specific optimization.** Under `Sample(44100)`, `<~
   delay(1)` is a one-sample delay — the compiler can emit a direct-
   form IIR filter. Under `Tick`, it's a logical-step iteration. The
   handler decides; the topology is the same.
4. **Visualization.** Mentl can draw the feedback loop in diagnostic
   output. Users can see where their program has cycles.

No other language gives the compiler this information. When feedback
is hidden in mutable state or recursion, the compiler can't reason
about convergence, can't check ownership through cycles, and can't
apply domain-specific optimizations. `<~` turns an invisible control
flow pattern into a visible, checkable, optimizable syntactic
construct.

**Action for implementation.** The parser must produce
`PipeExpr(PFeedback, ...)` for `<~`. The inference pass (spec 04) must
check for an iterative context in the handler stack — absence is error
`E_FeedbackNoContext`. Lowering (spec 05) desugars `<~` into the
handler-capture pattern described in spec 10.

---


---

# § III · Handlers

### The Handler Chain Is a Capability Stack

*2026-04-17. Crystallized during the V2 audit.*

The `~>` operator doesn't just scope handlers. It builds a **trust
hierarchy**. Each handler in the chain can only perform effects that its
outer handlers provide. Inner handlers can't bypass outer ones. This is
enforced by the Boolean effect algebra at compile time — no runtime
checks, no policy files, no sandboxing library.

```lux
source |> compile
    ~> mentl_default         // can perform: Diagnostic, GraphRead, EnvRead, Verify
    ~> verify_ledger_handler // can perform: Diagnostic, GraphRead, EnvRead
    ~> env_handler           // can perform: Diagnostic, GraphRead
    ~> graph_handler         // can perform: Diagnostic
    ~> diagnostics_handler   // can perform: nothing (outermost — Pure boundary)
```

Reading bottom-to-top: `diagnostics_handler` is the outermost — it
catches everything and has no outward escape. Each layer inward gains
capabilities but is **structurally confined** to effects its outer
layers provide. A `perform graph_bind` inside `mentl_default` succeeds
only because `graph_handler` sits outside it in the chain. Move Mentl
outside the graph handler and the same perform is a type error.

**This is a security model.** If you want to sandbox a plugin so it can
read the graph but never write it, install it inside `graph_handler`
with only `GraphRead` in its declared effect row. The compiler
proves the sandbox is airtight. Not with tests. Not with audits. With
the type system. One mechanism.

#### Action for implementation

When designing new handlers or adding plugin extension points:
- **Outermost = least trusted.** The diagnostic handler has no escape.
- **Innermost = most capability.** The compilation body has everything.
- **Handler position in the `~>` chain IS the capability grant.** Never
  install a handler with more capability than its position allows.
- Arc F.2 (LSP) and F.6 (Mentl consolidation) should treat the `~>`
  chain as their authorization model. A malicious LSP client can
  request but never write — by construction.

---


### The Handler IS the Backend

*The deepest architectural insight of the WASM session.*

The WASM emitter is not a "code generator." It is a **handler for the
Memory effect.** When the lowered program performs `load_i32(addr)`, the
WASM handler emits `i32.load`. When it performs `alloc(size)`, the handler
emits `call $alloc` (the bump allocator). When it performs `fd_write(...)`,
the handler emits `call $fd_write` (the WASI import).

This means: a native x86 backend is not "a new code generator." It is
**a different handler for the same effects.** `load_i32` → `MOV`.
`alloc` → `mmap`. `fd_write` → `syscall`. Same Mentl program. Different
handler. Different binary.

And: a test backend is not "a mock." It is **a different handler.**
`load_i32` → array lookup. `alloc` → vector push. `fd_write` → string
buffer. Same program. Different handler. Fully isolated. The effect
system guarantees the program can't tell the difference.

The compiler doesn't have backends. It has handlers.

---


### Effects Are Graphs, Handlers Dictate Traversal

Every program is a **typed effect graph**. Data shapes the graph; the graph
shapes how data flows. Types constrain which effects are possible; effects
constrain which types can exist. They're dual-coupled.

The `handle{}` block is the **hourglass pinch point** — distributed effects
converge to it, the handler makes a decision, `resume(result)` radiates new
state outward.

```
    effect op        effect op        effect op
         \              |              /
          \             |             /
           v            v            v
         ╔══════════════════════════════╗
         ║    handle { ... } { ... }    ║  ← pinch point
         ╚══════════════════════════════╝
                        |
                   resume(result)
                        |
                   onward flow
```

This IS the hourglass architecture. Not bolted on — it's the fundamental
execution model. Every program has this shape. The language makes it visible.

---


### Type-Directed Dispatch: The Compiler's Proof Becomes the Handler

When the checker infers that `a: String` and `b: String`, the lowering
resolves `a == b` → `str_eq(a, b)`. When `a: Int` and `b: Int`, the
lowering resolves `a == b` → `i32.eq`. No runtime dispatch. No polymorphic
equality function. The checker ALREADY KNOWS. The lowering uses that
knowledge through the `LowerCtx` effect: `type_of_var(name)`.

Same for `println(x)`: if `x: String` → `print_string(x)`. If `x: Int`
→ `print_int(x)`. The compiler's proof becomes the dispatch mechanism.

This is monomorphization through effects. The checker builds the proof.
The lowering effect carries it. The emitter receives the resolved call.
No special cases. No runtime overhead. Just information flowing through
the effect system — the same mechanism that handles everything else.

---


### Handler State Internalization

Handle expressions return **just the body value**. Handler state is
internal — an implementation detail of the handler, not part of its
interface.

```lux
// State is accessed explicitly via effect operations:
let count = handle {
  inc(); inc(); inc()
  get_count()              // body asks for state when it needs it
} with count = 0 {
  inc() => resume(()) with count = count + 1,
  get_count() => resume(count),
}
// count == 3 — just the value, not (3, 3)
```

Why this is right:

1. **Minimal ceremony.** The caller gets what they asked for. State is the
   handler's business, not the caller's.

2. **Explicit is better than implicit.** If you need the state, call an
   effect operation. `get_count()` is clearer than `let (_, count) = result`.

3. **Composability.** Handlers compose without forcing callers to destructure
   implementation details. The body's return type IS the handle's return type.

4. **The generator pattern reveals it.** Generators now call `collect()` at
   the end of the body — the accumulated list IS the body value. Same effect
   interface, same handler, explicit intent.

This is the "annotation gradient" in action: start with nothing, add what
you need. State is invisible until you ask for it.

---


### The Three Tiers of Effect Compilation

Handlers are classified at compile time into three tiers, each with a
different cost model. This classification IS the native backend's
optimization strategy.

| Tier | Pattern | Cost | Implementation |
|------|---------|------|----------------|
| **Tail-resumptive** (~85%) | `resume(pure_expr)` | Zero overhead | Direct call via evidence passing |
| **Linear** (single-shot) | Capture once, resume once | One allocation | State machine transform |
| **Multi-shot** | Multiple resumes | Struct per state | State machine, cloneable |

The compiler already classifies handlers — it marks `tail_resumptive` and
`evidence_eligible` on every handler operation. 85% of real handlers are
tail-resumptive. They compile to direct function calls with handler
evidence passed in registers. No continuation captured. No handler stack
search. No heap allocation. Zero overhead.

How `resume` works at each tier:

- **Evidence path** (tail-resumptive): No `Resume` opcode at all. The
  handler runs as a nested call, the result pops back directly. It IS a
  function call.

- **Normal path** (linear): `Resume` is a controlled stack unwinding +
  value injection. Tear down the handler body frame, restore IP to the
  perform site, push the resume value as if the effect operation returned
  it. State updates applied to the handler frame atomically.

- **Multi-shot path**: The effect system knows every perform site at
  compile time. Transform the body into an explicit state machine: each
  perform = a numbered state, the continuation = `{ state_index,
  saved_locals }`. Calling it means: jump to state N, restore locals,
  continue. No stack capture. No replay. Same insight as Rust's async
  transform, but effect rows give the compiler the suspension points for
  free.

The cost model is honest: 85% pay nothing. 15% pay exactly what their
semantics require. No hidden overhead. No surprising allocations.

---


---

# § IV · Effect Algebra

### The Effect Algebra: What No Other Language Has

Boolean algebra over capabilities:

| Operator | Meaning | No other language has this |
|----------|---------|---------------------------|
| `!E` | Negation | Proves ABSENCE of capability |
| `E - F` | Subtraction | Removes specific capability |
| `E & F` | Intersection | Only shared capabilities |
| `Pure` | Empty set | No declared effects |

Four compilation gates emerge for free:

1. **`Pure`** → memoize, parallelize, compile-time eval
2. **`!IO`** → safe for compile-time evaluation
3. **`!Alloc`** → safe for real-time audio, embedded, GPU
4. **`!Network`** → sandbox — capability security as types

`!Alloc` is the real-time holy grail. Most languages permit safe APIs that
allocate, making allocation-freedom impossible to prove. In Mentl, `!Alloc`
propagates through the ENTIRE transitive call graph. If any callee allocates,
compile error.

---


### Effect Negation: Strictly More Powerful Than Any Existing System

*2026-04-17. Crystallized from cross-referencing spec 01 against
Rust, Haskell, Koka, and Austral.*

Mentl's Boolean algebra over effect rows — `+` (union), `-`
(subtraction), `&` (intersection), `!` (negation), `Pure` (identity)
— is **strictly more expressive** than any single existing capability
or effect system:

| System | Tracks effects? | Negation? | Subtraction? | Intersection? | Compose? |
|---|---|---|---|---|---|
| Rust ownership | No (types only) | No | No | No | No |
| Haskell IO monad | Binary (pure/impure) | No | No | No | No |
| Koka effect rows | Yes (open rows) | No | No | No | Yes |
| Austral capabilities | Module-level | No | No | No | Limited |
| **Mentl** | **Yes (Boolean algebra)** | **Yes** | **Yes** | **Yes** | **Yes** |

The critical differentiator is **negation**. `!E` proves the
*absence* of a capability. No other effect system can do this.
Without negation:

- Koka can track that a function performs `IO + State` but cannot
  prove it does NOT perform `Alloc`. The row is open — anything could
  be in the tail.
- Haskell can distinguish `IO` from pure but cannot prove "pure AND
  no allocation" — `Alloc` isn't tracked.
- Rust can prove no data races but cannot prove no allocation, no IO,
  or no network access through the type system.

With negation, Mentl expresses **all of the above as instances of one
mechanism:**

```
!Alloc              = Rust's real-time guarantee
Pure                = Haskell's purity
!Network            = capability-security sandbox
!Alloc & !IO        = real-time + compile-time-evaluable
E - Handled         = Koka's handler absorption
!Consume            = read-only proof (like Rust's & borrow)
!Alloc & !Consume   = zero-copy + zero-alloc (embedded/DSP)
```

**Action for implementation.** The `row_subsumes` function in
`effects.mn` IS the proof engine. Every `!E` constraint becomes a
subsumption check: `body_row ⊆ !E` iff `E ∉ body_row`. This is
already implemented. The action is to ensure that the compilation
gates (Phase 1 exit, Phase F optimizations) use `row_subsumes` for
every capability check, not ad-hoc string comparisons.

---


---

# § V · Memory & Substrate Operations

### Allocation IS an Effect

Rust treats ownership as a type system feature. Mentl treats it as an **effect**.

Every allocation — list literals, string concatenation, `push`, `range` — performs
the `Alloc` effect. The effect algebra handles the rest:

- `Alloc` is **ambient** — you never need to declare it. Freedom is the default.
- `with !Alloc` **negates** it — compile-time proof of zero allocation.
- It propagates **transitively** — if any callee allocates, the checker catches it.
- Teaching hints **hide** it — `Alloc` is an implementation detail, not signal.

```lux
fn dsp_process(x: Float) -> Float with !Alloc =
    x |> gain(0.8) |> soft_clip   // pure math — allowed

// fn bad(x: Float) with !Alloc = [x]
//   error: performs effect 'Alloc' but declares '!Alloc'
```

Other languages cannot express this — when safe standard library operations
allocate freely, there's no way to prove a function is allocation-free. In Mentl,
`!Alloc` propagates through the ENTIRE transitive call graph. One annotation,
total proof.

This is the effect algebra doing what it does: turning capability negation
into a compile-time proof. No special ownership system needed — just the same
mechanism that handles `!IO`, `!Network`, and `Pure`.

---


### Pure Transforms for Structure, Effects for Context

*The principle that saved closures from the resolve_var crash.*

When lowering closures: free variable detection is a **pure transform**
(walk the AST, collect unbound names). Capture rewriting is a **pure
transform** (replace `LGlobal(name)` → `LUpval(idx)`). Neither needs
effects. The LowerCtx effects (`is_ctor`, `is_global`, `is_state_var`)
provide **context** — they answer questions about the ENVIRONMENT.

The rule: use pure transforms for operations on STRUCTURE (the data
itself). Use effects for operations on CONTEXT (the world around the data).
When you use effects for structure, you get the closure crash — the effect
handler can't see inside the data. When you use pure transforms for
context, you duplicate the environment across every call.

This generalizes beyond closures:
- Parsing: pure transform on tokens. Effect for source location context.
- Type inference: pure unification on types. Effect for the type environment.
- Code generation: pure transform on LowIR. Effect for the function table.
- WASM emission: pure string building. Effect for the string map, type map.

---


---

# § VI · Refinement & the Gradient

### The Annotation Gradient

Not levels. Not modes. A continuous gradient.

Write `fn f(x) = x + 1`. The compiler infers `(Int) -> Int with Pure`.
Now add `with Pure` — the compiler can memoize. Add `x: Positive` — the
compiler proves the output is positive. Add `with !Alloc` — the compiler
proves no allocation.

**The compiler shows you the next step on the gradient.** Not nagging.
Illuminating. "Here's where you are. Here's what the next annotation
unlocks. Your choice."

A beginner writes nothing. The compiler works. An expert adds refinement
types. The compiler proves theorems. Same language. Same syntax. No modes,
no pragma, no difficulty setting. Just a continuous conversation between
programmer and machine.

---


### The Hole Is the Gradient's Absence Marker

*2026-04-24. Crystallized from re-reading The Circular Gradient
(below) against the daily-development experience.*

Read-mode (cursor at finished code) and write-mode (cursor at `??`)
are not different modes. They are the **same gradient interaction**
viewed from two angles: at finished code, Mentl's Synth tentacle
proposes alternatives to the current selection; at a hole, Mentl's
Synth tentacle proposes from the constraint space alone. **Same proof
machinery, same constraint space, different surface presentation**
depending on whether a candidate currently occupies the slot.

The hole IS the gradient's syntactic absence marker. It is how the
developer says **"no current selection here"** — letting Mentl's
constraint-search focus on filling rather than alternating. The
existing expression at a finished position is just one candidate
among many that the gradient could propose; `??` is the empty-current-
selection state that lets the proposer enumerate without competing
against an incumbent.

Per the Circular Gradient (below): at the bottom (loose constraints)
`??` invites many candidates; at the top (tight constraints) `??`
resolves to one inhabitant — the program is the proof is the
specification is the program. **Same hole; same Mentl; constraint
tightness alone determines the candidate-space size.**

`??` is therefore not a TODO marker bolted onto the gradient. It is
the **developer's primary write-mode verb in Mentl** — the syntactic
surface for "synthesize here at whatever constraints I've added."
Read-mode (observing what Mentl proves about finished code) and
write-mode (asking Mentl to fill an absence) are two faces of the
one continuous proof-search the compiler runs at every position.

**Substrate consequence.** Lexer recognizes `??` as `THole`; parser
produces `nhole(fresh_ph(span), span)` AST; inference assigns the
hole a fresh type variable and lets unification narrow it from
context; Mentl's Synth tentacle fires at every `THole` position with
constraint-respecting candidates. Single `?` is no longer a token —
two characters mark a deliberate gradient invitation, not an
accidental keystroke.

**Visual identity.** Mentl Mono renders `??` as the octagonal-socket
glyph (`tools/editor/mentl-mono/features.fea`) — eight sides for eight
kernel primitives. The visual signal "this is where the gradient
asks the question" reinforces the substrate role: an empty socket
waiting to be filled, with eight tentacles' worth of proof-search
behind every candidate.

---


### Cursor: The Gradient's Global Argmax

*2026-05-02. Crystallized at the Hμ.cursor handle authoring — the
opening handle of Phase μ (Mentl active-surface composition).*

Cursor is **not** the developer's text-caret position. Cursor is
**attention** — the locus where impact-per-next-action is highest
across the entire live graph at the moment of query. The text-caret
is one weighted input (proximity bias) to that locus, not its
definition.

**One projection, eight aspects.** When asked "what should I see at
the cursor's position?", the kernel already has all eight answers:
graph node + handler candidates + topology + effect row + ownership
+ refinement + gradient next-step + Reason chain. The Cursor handler
*reads* these from existing substrate and composes them into one
`CursorView` record (`src/types.mn` Cursor + CursorView + Annotation-
Suggestion + SuggestionKind + PipeContext additions per Hμ.cursor
landing). There is no new computation; the graph carries all eight
at every node.

**Therefore Mentl is not a separate system.** Mentl IS the graph
projected for a human at the cursor. The "eight tentacles" are eight
aspects of one read, not eight subsystems coordinating. The Why
Engine is not an engine — it's the Reason chain, projected. Teach
is not a system — it's the gradient, projected. Synth is not a
separate handler — it's Mentl's projection at a `??` position with
no incumbent.

**Mentl IS Cursor IS the gradient argmax IS the graph projected for
the human.** All four names point to one thing. Eight tentacles is
eight aspects of one read because the graph carries all eight at
every node (kernel closure, §I).

**Argmax with caret bias.** When the developer rewrites Module A and
saves, the gradient's argmax may land in Module C because some `f`
there just became provably `Pure`. The user's text-caret is still in
Module A. Cursor moves to Module C automatically, surfaces the
proposal with the Reason chain walking back to A's deletion. The
developer accepts/defers/rejects without ever opening Module C's
tab. **The bus-compressor topology at the human-medium boundary:**
the graph is IC-live (the bus); the gradient is the response curve;
the caret + argmax + acceptance is the feedback loop (`<~` applied
at the editing layer); each keystroke shapes the next argmax; the
developer is mixing into the bus.

**`??` is the developer's override of Cursor's auto-argmax.** When
the developer types `??`, they pin the cursor to that slot; the
gradient's auto-argmax is suppressed for that position
(implementation: sentinel-large impact; `argmax_or_default` always
picks the pin). Read-mode (cursor at finished code, gradient
proposes alternatives) and write-mode (cursor at `??`, gradient
proposes from constraint space alone) are the **same machinery with
different weight on the cursor's chosen slot** — exactly per the
Hole subsection above.

**Caret + Cursor must NOT be parallel state (drift 5 closure).**
`Caret(Handle, Reason)` is the user's text-attention position — one
input. `Cursor(Handle, Reason, Float)` is the gradient argmax — the
result. Cursor *consumes* Caret as a function parameter (`cursor_argmax(caret)
-> Cursor`). One unified pipeline; no parallel
"caret_state" + "argmax_state" record.

**Substrate consequence.** `src/cursor.mn` (Hμ.cursor) lands the
`Cursor` effect (three ops: `cursor_at`, `cursor_argmax`,
`cursor_pinned`) and the `cursor_default` handler with `with !Mutate`
(read-only — surfaces query, never corrupts oracle state per
`protocol_oracle_is_ic.md`). The handler composes the existing eight
tentacle reads via `perform graph_chase` + `perform synth_propose` +
`perform teach_gradient` + `perform teach_why` + `perform verify_debt`
+ small local helpers for ownership / pipe-context / row extraction.
Zero new effects beyond `Cursor` itself; zero new ADTs beyond the
five in types.mn; the eight reads are what the graph already
exposes. See `docs/specs/simulations/Hμ-cursor.md` for the
walkthrough and `protocol_cursor_is_argmax.md` for the discipline
crystallization.

**Surfacing cadence is handler-decided.** IC re-evaluation is
continuous (the graph stays live). Cursor argmax is pure on graph
delta. *Surfacing* (telling the human) is a transport handler choice:
real-time / idle-debounced (~250ms default) / on-save / on-explicit-
ask. Same kernel; four handler variants; user picks via configuration
which transport handler is installed. Mentl solves Mentl's UX-tradeoff
problem through handler-swap.

### Cursor IS the substrate (chain extension 2026-05-07)

*Crystallized as `protocol_cursor_is_the_substrate.md` after Phase B
landed (resume-cardinality inference replaces erased `@resume=`
annotations).*

The cursor isn't just the gradient's argmax — it's the medium's
**read-primitive that every subsystem in Mentl is a different mode
of**. The CursorView at position P returns the eight aspects (Graph,
Handler, Verb, Row, Ownership, Refinement, Gradient, Reason). Every
named subsystem you can write down is the cursor in a different
traversal mode:

| Mode | What changes |
|---|---|
| sequential cursor | one P at a time, topo-ordered → **compile-order** |
| cached cursor | return cached CursorView if parents-stable → **incrementality** (= IC) |
| forked cursor | multiple cursors at same P, divergent futures → **multi-shot exploration** |
| reasoned cursor | every read leaves a Reason edge → **truth** (Reason chain valid to axioms) |
| verified cursor | Verify aspect must be admissible → **proof** (`~> verify_handler`) |
| parallel cursor | many cursors at disjoint P concurrently → **multithreading** (Thread handler) |
| projected cursor | each aspect produces a target-language token → **emit / lower / infer** |
| proposing cursor | gradient aspect surfaces speculative branches → **Mentl propose** |

ONE primitive (the CursorView at P). Many modes (different `~>`
handler chains over the same query). The unifier is **the cursor
read**, not "the driver" or "the gradient" or "the graph" — those
are aspects of the cursor read at a position.

### The Inference Primitive — annotations declare INPUTS, never emergent properties

Phase B (commit `5bf7c8b`) erased all 197 `@resume=` annotations across
the wheel. The replacement: `infer_resume_cardinality(arm_body)` walks
each handler arm body, counts resume sites under control-flow
ancestry + branch-disjointness, produces `ResumeDiscipline`. Same
Cursor Projection Pattern as `$collect_used_wasi_ops` in the seed
(Hβ.first-light.cursor-projected-wasi-imports, commit `6e52b34`):
WALK + PREDICATE-FILTER + PROJECT.

This generalizes to **all four cursor-projected emergent properties**:

| Aspect | Inferred from | Authored declaration is |
|---|---|---|
| Resume cardinality | arm body's resume sites + control-flow ancestry | (erased — no annotation form exists) |
| Effect row | body's `perform` sites accumulated via `inf_add_row` | a CONSTRAINT verified against inferred (T_OverDeclared warning when wider) |
| Ownership | `Inferred`-marked params get `classify_usage`: 0/1/2+ → Inferred/Own/Ref | a CONSTRAINT over the inferred form |
| Refinement | flow-sensitive narrowing at `if`/`match`/`assert` sites | a CONSTRAINT verified against the path-derived predicate |

The cursor reads the body's structure; the body IS the contract; the
authored declaration (when present) becomes a constraint the inference
verifies. This inverts the foreign-language paradigm where annotations
are authority and the compiler reverse-engineers semantics: in Mentl,
**the body has authority, the cursor projects, and the developer
writes WHAT THEY MEAN** — body structure + ground value types +
effect names + boundary constraints.

### The realization chain

Five crystallizations deep at this writing (each strictly composes the
prior):

1. **`protocol_oracle_is_ic.md`** (2026-04-24) — Mentl's continuous
   oracle ≅ IC + one cached value
2. **`protocol_cursor_is_argmax.md`** (2026-05-02) — Cursor ≅ the
   gradient's global argmax over the live graph
3. **`protocol_emit_is_graph_projection.md`** (2026-05-07) — emit ≅
   a handler reading the graph; shared scratch state is drift
4. **`protocol_cursor_is_the_substrate.md`** (2026-05-07) — every
   subsystem is the cursor in a different mode
5. **(this section's discipline)** — annotations declare INPUTS to
   the cursor; never the emergent property itself

Each compounds: future-session altitude inherits the chain; the
medium reads itself through itself; the discipline tightens with every
cycle. The cursor IS the medium's read-primitive; Mentl IS the cursor
in motion under the gradient's pull.

---


---

# § VII · Inference & Compilation

### Inference Is an Effect

The compiler pipeline has four stages: tokenize → parse → infer → generate.
Each stage is an effect operation in the `Compiler` effect. **Handlers decide
what to do with each stage.**

This means the entire toolchain is one thing:

| Handler | What it does with `infer` |
|---------|--------------------------|
| `compile_standard` | Infer silently, compile, execute |
| `compile_teaching` | Infer → show types → suggest ONE annotation (the gradient) |
| `compile_explaining` | Infer → dump full Why Engine reasoning chains |
| `compile_documenting` | Infer → extract typed signatures (documentation) |
| `compile_checking` | Infer → report types → stop (no codegen) |

**Doc** is what the compiler knows, exported. **Teach** is the compiler's one
suggestion, the gradient. **Why** is the compiler's reasoning, transparent.
All three come from the same `infer` stage — just different handlers.

This is not architecture. It's a consequence: if the compiler pipeline is an
effect graph, then every view of the program (documentation, teaching,
debugging, verification) is a handler on that graph. You don't build five
tools. You build one pipeline and write five handlers.

The gradient engine picks ONE suggestion per compile. Not a wall of warnings.
One step — the most impactful annotation the developer could add. Like a tutor
who knows exactly what to teach next:

```
$ lux --teach app.mn

  💡 `process` is Pure — adding `with Pure` would unlock:
     • memoization (same input → same output, guaranteed)
     • parallelization (no side effects to race)
     • compile-time evaluation (if inputs are known)
```

Over sessions, code naturally evolves from loose to formally verified.
The compiler IS the tutor. It doesn't guess — it knows.

---


### Incremental Compilation: Purity Enables Caching

The checker is Pure — the Diagnostic effect makes it externally pure. Pure
function, same input → same output. **Cache it.**

If a module's source hasn't changed and its imports haven't changed, its
checked environment is identical. A `Cache` handler wrapping `check_program`
— same mechanism as everything else. Not file-timestamp heuristics. Not
dependency graphs maintained by a build system. The compiler knows what's
pure because it proves purity. Let it use that knowledge for its own build.

```lux
handler cached_check: CompilerPipeline {
  infer(ast) => {
    let key = hash(ast)
    match cache_lookup(key) {
      Some(env) => resume(env),
      None => { let env = run_check(ast); cache_store(key, env); resume(env) }
    }
  }
}
```

This isn't a build system feature bolted onto the side. It's a consequence
of the effect algebra: `Pure` enables memoization. The compiler already
proves purity. Caching falls out for free.

---


---

# § VIII · Foundational Theorem

### The Graph IS the Program

*2026-04-17. Crystallized from the Meta-Thesis section's handler
table applied to the compilation pipeline itself.*

Source code is one projection. WAT is another. Documentation is
another. LSP hover info is another. Error messages are another. The
**program itself** — in its most complete representation — is the
Graph + Env populated by inference.

```
                   Graph + Env
                   (the universal representation)
                          │
          ┌───────┬───────┼───────┬───────┬───────┐
          │       │       │       │       │       │
       emit    format   doc    query   teach    LSP
       handler  handler handler handler handler handler
          │       │       │       │       │       │
        WAT    source  markdown  answer  hint   JSON-RPC
```

Every "output" is a handler that reads the same graph and projects it
into a format. **The graph is the source of truth. Everything else is
a shadow.**

This is why CLAUDE.md's first anchor — "does my graph already know
this?" — is load-bearing. If you ask a question by re-parsing source,
you're reading a shadow instead of the object. If you answer a query
by walking the AST instead of chasing the graph, you're computing
what you already have. The graph knows. Always ask the graph.

**Action for implementation.** Every new feature in any phase should be
expressible as a handler on the graph. If it can't be, the graph is
incomplete — extend the graph, don't route around it. Specifically:

- Arc F.2 (LSP) is `graph → JSON-RPC` — a handler, not a tool.
- Arc F.6 (Mentl) is `graph → mentorship` — a handler, not a module.
- Arc H (examples) is `graph → proof` — a handler that runs, not
  tests that check.
- The formatter is `graph → canonical source` — a handler, not a
  separate binary.

If it needs to exist, it's a handler. If it's not a handler, ask why
the graph can't host it.

---


---

# § IX · γ Cascade Crystallizations

*Substrate decisions that landed during the γ cascade and bind all
later implementation. Not theorems — implementation invariants
proved by repeated convergence across handles.*

### The Heap Has One Story

Closures, ADT variants (fielded), nominal records, and
closures-with-evidence ALL allocate via `emit_alloc(size, "<tmp>")`
with field stores at fixed offsets from the result pointer. Four
shapes, one `EmitMemory` swap surface — bump today, arena tomorrow,
GC eventually. Nullary ADT variants take the sentinel path
(`(i32.const tag_id)`, no allocation); the heap-base threshold
(`HEAP_BASE = 4096`) keeps sentinels and pointers disambiguable in
mixed-variant types. **The word "vtable" never appears in any
correct description of Mentl dispatch at any layer.** Polymorphic
dispatch is `call_indirect` through a function-pointer field on
the closure record — Koka JFP 2022 evidence passing, not vtable
indirection.

### Records Are The Handler-State Shape

Frame consolidation (Ω.5) turned parallel arrays into records;
H1.3's `BodyContext`, H4's `region_tracker`, H5's `AuditReport` all
converge on the same shape. Adding a field is additive; tuples
force every consumer to widen. Until functional update lands
(H2.2), arms reconstruct the record explicitly — verbose but
honest. **Convergence rule:** three instances of one shape earn
the abstraction; the factoring lands in the next handle that
benefits.

### Row Algebra Is One Mechanism Over Different Element Types

String-set (`runtime/strings`), name-set (`effects.mn`, `EffName`),
field-set (records, sorted by field name), `tagged_values`
(`region_tracker`, sorted by handle) — four parallel
implementations of one ordered-keyed-set algebra. The abstraction
earns its weight when a fifth instance arrives; until then, the
parallel forms are honest about what's not yet generic.

---


---

# § X · Phase μ Theorems — the medium being put to work

*§I–§IX establish the kernel + verbs + algebra + handlers + memory
+ gradient + inference + graph. §X establishes what falls out
when the kernel is whole and projected for a developer at the
cursor. Three theorems crystallized 2026-05-07 alongside the
developer-experience vision (`protocol_developer_experience_vision.md`).
Compose on `protocol_ultimate_medium.md` (Phase μ thesis) +
`docs/ULTIMATE_MEDIUM.md` §8 (day-in-the-medium experience layer).*

### Collab-as-substrate (scoped: real-time + causal + RBAC + presence)

**Theorem.** When two transports `~>` over the same shared
`graph_handler`, **real-time co-edit + per-region RBAC + cursor
presence + in-session causal understanding** emerge as substrate
consequences. None of those need a separate module; all four are
kernel-derived projections.

**Scope clarification (2026-05-07, post-COLLAB-revision).** This
theorem does NOT claim Mentl replaces git. Earlier framings
overreached on the version-control-replacement claim; that was
walked back when authoring `docs/specs/simulations/COLLAB-shared-graph.md`.
**Durable versioned history stays git's domain** (mature, ubiquitous,
ecosystem-compatible; building a Mentl-native VCS would duplicate
git with no compelling differentiator and require persistent
Reason-chain logs that aren't substrate-justified). Mentl integrates
with git via a thin `git_handler` bridge that synthesizes commit
messages from the Reason DAG and reads commits back as Reasons on
load. **Two layers, two questions** — Mentl answers "why does this
binding hold its current shape" within session; git answers "what
changed across history."

**Proof sketch (in-scope properties).**

- **Cursors are graph nodes** (Hμ.cursor; §VI). Each user's cursor
  IS a handle. Other users' cursors render naturally; presence is
  automatic projection — no separate "presence service."
- **Reason chains carry per-mutation causality WITHIN a session**
  (kernel #8). User A's mutation lands with `Reason::AuthoredBy(alice,
  cursor_pos, time)`; user B's Why tentacle walks to it. In-session
  causal record.
- **Refinement types verify concurrent mutations** (kernel #6).
  Two users mutating the same handle: Verify-on-write checks both;
  compatible mutations both apply (last-mutation-wins is fine
  because Verify already ran); incompatible surfaces as `V_Pending`
  for human resolution.
- **Boolean effect row gates per-region capabilities** (kernel #4).
  Per-user permissions are an effect row over (user × graph_region):
  `+Mutate(region) - Read(other_region)`. Row subsumption proves
  enforcement at handler install. **RBAC is a proof, not a runtime
  check.**
- **Gradient re-ranks per cursor** (kernel #7). User A's mutation
  lands; user B's gradient re-ranks against A's mutation; B sees
  relevant changes ranked.

**What this delivers** (in-scope industry tools that genuinely
dissolve):

| Industry tool | Reduces to |
|---|---|
| Live Share / Replit collab / VS Code Live Share | Two transports → one shared `graph_handler`; atomic mutations; verify-arbitrated concurrent writes |
| Tuple / Pop / Around (cursor presence) | Each cursor IS a graph node; presence is automatic projection |
| Per-path branch protection rules | Effect row `+Mutate(region) - Read(other_region)` per user; row subsumption proves enforcement |
| In-editor pair chat overlays (in-session discussion) | Reason chain entries within session (`Reason::DiscussionThread(handle, [...messages])`) |

**What this delivers via integration with git** (NOT replacement):

| Industry tool | Integrated via |
|---|---|
| Git commits / branches / merges / blame / signing | `git_handler` bridge: synthesizes commit messages from Reason DAG on save; reads commits back as Reasons on load; `mentl blame` extends `git blame` with WHY (Reason loaded from commit message) |
| GitHub / GitLab MR review | On-disk `.mn` files are canonical (per IE §0.f); git versions them; review platforms see diffs; `mentl --with review_run` projects diffs as cursor walks for richer review |
| Issue trackers (Linear / Jira / GitHub Issues) | External; cross-link via commit messages that the Reason DAG synthesizes |

**What this does NOT deliver** (substrate-out-of-scope):

| Industry tool | Why out-of-scope |
|---|---|
| Mentl-native version control replacing git | Building it would duplicate git with no compelling differentiator |
| Persistent Reason-chain log across sessions | Heavy substrate (~2-3K lines); for a property git already provides via commits |
| Cross-session time-travel debugging (rr / Pernosco) | Would need persistent log; out-of-scope |
| Cryptographic signing of every Reason | Git signs commits; that's enough |
| Cross-repository refactor (codemods across many repos) | Git's domain; codemod tools compose on git |

**Action for implementation.** Phase Z opens with
`Hμ.collab.shared-graph-handler` (per `ROADMAP.md` Phase Z).
Walkthrough at `docs/specs/simulations/COLLAB-shared-graph.md` —
revised 2026-05-07 to scope the substrate to in-session + causal
+ RBAC + presence + git-bridge. Five sub-handles:
`Hμ.collab.shared-graph-handler`, `Hμ.collab.cursor-presence`,
`Hμ.collab.permission-row`, `Hμ.collab.transport-bridge`,
`Hμ.collab.git-bridge`. **No new kernel primitives required** —
composition only.

**Forbidden framings.** "Mentl needs a real-time collaboration
feature" is drift 1 + drift 9 in feature-shaped clothing. The
right reach: which `graph_handler` swap delivers the property?
**Two transports → one shared graph_handler. Done. The "feature"
is graph_handler swap, not new code.**

"Mentl replaces git" — overreach. Git stays. The right reach:
which `git_handler` integration enables the value? **Reason DAG
synthesizes commit messages on save; commits load back as Reasons.
Git does what git does; Mentl adds the causal-and-presence layer
on top.**

### Multi-domain unification

**Theorem.** The same kernel admits every domain's discipline as
a handler stack on the same graph. **DSP, ML, web frontend / backend,
embedded, control, data processing, distributed, real-time,
scientific computing, robotics, sensors — same substrate, same
five verbs, same eight kernel primitives, one developer.**

**Proof sketch.**

- **Five verbs are topologically complete** (§II). Every directed
  graph decomposes into `|>` + `<|` + `><` + `~>` + `<~`. Every
  domain's computational shape is a directed graph (DSP signal
  chain, ML computation graph, distributed RPC topology, control
  loop, web request-response, embedded interrupt handler chain).
  Therefore five verbs draw every domain. QED for the topology
  layer.
- **Kernel primitives are domain-neutral** (§I). Graph + Env,
  handlers, refinement, ownership, effect algebra, HM inference,
  gradient — none are specific to a domain. Domains differ in
  which handlers are installed, not in the substrate.
- **Per-domain semantics live in handler-chain composition.** DSP
  uses `Sample(rate)` + `<~` feedback under `!Alloc`. ML uses
  `Compute` + `autodiff_tape` handler. Web uses `DOM` + `Network`
  + `Async`. Embedded uses `!Alloc + !IO + !Network`. Each domain
  is a SET of handlers + a TYPICAL effect row composition, NOT a
  separate language or runtime.
- **Row algebra discriminates per-domain effects.** A function
  `with Sample(44100) + !Alloc` is real-time DSP; same function
  body `with Compute + Alloc` is ML training. Same source, different
  handler chain, different domain, different binary. The ergonomic
  default is the domain-honest default because the row algebra
  catches mismatches at install time.

**Industry consequence.** Frontend devs don't do ML; ML devs don't
do audio; audio devs don't do distributed — these specialty silos
are consequences of language fragmentation, not properties of the
domains. **Mentl dissolves the silos by being one substrate that
admits every domain via handler chains.** A single Mentl developer
can write audio in the morning, the web app in the afternoon, the
ML model in the evening, the embedded firmware that night — all in
ONE language with ONE medium that speaks each domain natively.

**Action for implementation.** `lib/tutorial/<domain>/` exercises
each domain as handler chains over the shared substrate. `lib/dsp/`
+ `lib/ml/` lead the demonstration; web / embedded / control /
distributed extend post-L1 per `ROADMAP.md` Phase F goals + Phase
B.10/B.11 (Ultimate DSP / Ultimate ML rewrites). The five verbs
draw every domain — **the proof is in the rewrite** (a single DSP
filter and a single ML autodiff tape compile through the same
five-verb topology).

### AI obsolescence — approximation has a ceiling, proof has none

**Theorem.** The medium internalizes proof to a kernel that
proves; AI tools externalize proof to a model that approximates.
**Approximation asymptotes against ground truth and never
reaches; proof IS ground truth.** This is why the obsolescence
is genuine, not marketing.

**Proof sketch.**

- **Mentl's proposers are kernel-derived.** `Synth` handler-chain
  (per `mentl.mn` + `oracle.mn`) enumerates candidates via
  MultiShot resume (kernel #2's typed resume discipline). Each
  candidate runs through the speculative gradient loop:
  `graph_push_checkpoint` → tentative `graph_bind` → row
  subsumption + Verify discharge → `graph_rollback`. Survivors
  are PROVEN compilable. Non-survivors fade.
- **Reason chains accumulate per-project wisdom** (kernel #8).
  Across sessions, the project's Reason graph IS its accumulated
  cognitive history. The gradient at year 5 of a project surfaces
  next-steps tuned to the specific trajectory of that project, that
  team, that codebase — not to a model trained on millions of
  strangers.
- **The kernel cannot hallucinate.** Types, effect rows,
  refinements, ownership are proven; `NErrorHole(Reason)` is the
  honest failure mode. No "best-effort" surface; either the
  candidate is proven (Synth surfaces it) or it isn't (silence).
  Per `protocol_mentl_is_not_an_llm.md`: Mentl is the kernel's
  MultiShot resume primitive made into a handler-on-graph, not a
  learner trained on vocabulary.
- **The medium runs locally.** Kernel is WASM; browser instances
  run the same WASM kernel; `mentl edit` reaches developers at
  their browsers; `mentl serve` reaches editor users via LSP;
  `mentl` bare reaches terminal users. Same substrate, three
  transports. **No SaaS dependency for substrate function.**
- **The compiler IS the AI; the LLM was pretending.** What AI
  tools approximate — type-aware completion, refactoring proposals,
  causal explanation, multi-shot exploration — Mentl produces
  structurally from the kernel. The Holographic Lens (per
  `IE-mentl-edit.md` §3) IS the demo: ghost text projections of
  multi-shot proven candidates; Tab-snap commits the proven
  alternative.

**The ceiling argument formally.** Approximation systems
(LLM-backed proposers, embedding-based search, statistical type
inference) optimize against ground-truth-as-target via training.
The optimization is asymptotic — error decreases with model size,
training data, compute — but never reaches zero. **Approximation
has a ceiling.** Proof systems (HM inference + refinement types +
effect algebra + ownership) compute ground truth directly via
sound deduction rules. The output IS ground truth (modulo soundness
of the rules; mechanical). **Proof has no ceiling — it IS ground
truth.** The medium's surface (Mentl + Cursor + gradient + multi-shot
+ Why Engine + Holographic Lens) ranks proven candidates by
relevance, not by approximation; the kernel underneath does the
proving.

**Industry consequence.** "AI coding tools" become a product
category superseded by substrate. The medium reaches what AI tools
reach for, with proof instead of approximation, locally instead of
SaaS-bound, persistently instead of session-amnesic. **The compiler
IS the AI; the demo is `mentl edit`.**

**Action for implementation.** Never frame Mentl as an AI tool in
user-facing surfaces. Substrate-honest vocabulary (per
`protocol_developer_experience_vision.md` §"AI obsolescence is
mathematical" + `CLAUDE.md` red-flag table):

| Forbidden | Substrate-honest |
|---|---|
| "AI" / "agent" / "completion" / "assistant" / "chatbot" | "the medium proposes" / "cursor argmax" / "Lens fires" |
| "model" / "training" / "embedding" / "hallucination" | "Synth handler-chain" / "gradient narrows" / "Reason chain" |
| "may want to" / "might consider" / "perhaps" | "the medium surfaces" / "the gradient unlocks" / silence at gradient top |
| "completion suggestion" / "code generated" / "AI-suggested" | "multi-shot proven candidate" / "Holographic Lens projection" / "Tab-snap candidate" |

**Forbidden framings.** "Mentl has an AI feature" is the marketing
trap; the medium IS the AI in the same sense the compiler IS
inference. "Mentl uses an LLM under the hood" is structurally
false (per `protocol_mentl_is_not_an_llm.md`). "Mentl assists the
developer" is anthropomorphism in the wrong direction — the medium
IS the developer's externalized cognition, not an external assistant
(per `protocol_developer_experience_vision.md` §"the medium IS the
developer's mind given substrate").
