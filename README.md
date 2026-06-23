# Mentl

A programming language where the compiler proves what your code will and won't do, instead of leaving you to check it by hand.

Mentl has an effect system that can prove a function *never* allocates memory or touches the network, ownership that gives you Rust-style memory safety without writing lifetimes, and refinement types that catch out-of-range values before the program runs. The compiler is written in Mentl itself.

The bet behind it is simple. As more code gets written by machines, "it looks right" stops being good enough, because no human authored it to vouch for it. What you need then is to *prove* what a program does and doesn't do. Mentl is built so that proof is the normal way you work, not a separate verification pass you bolt on at the end.

File extension: `.mn`.

## The idea

Most languages let you describe what a function does. Mentl also lets you state what it won't do, and then it checks you.

```
fn mix(left, right) with !Alloc =
  (left + right) * 0.5
```

`with !Alloc` is a claim the compiler verifies: `mix` allocates no memory, and neither does anything it calls. If someone later edits a helper so that it allocates, this function stops compiling. Proving the *absence* of a behavior, transitively through the whole call tree, is something most production type systems can't express, and it's exactly what real-time audio, embedded code, and security-sensitive code need most.

The same signature carries everything else a function touches:

```
fn fetch(url) with Network + !Alloc =
  ...
```

You read that line and you know two things for certain: it talks to the network, and it never allocates. You don't read the body. You don't trust a comment.

## What you write

Programs are built from five operators, each drawing one shape of data flow:

- `|>` runs stages in sequence: `audio |> normalize |> compress |> limit`
- `<|` sends one value into several branches and collects the results
- `><` runs independent pipelines side by side
- `~>` attaches a handler that interprets the effects to its left
- `<~` feeds a value back as the next input, which makes feedback loops first-class

Whether a `><` actually runs on threads, on SIMD lanes, or on a GPU is decided by which handler you install over it, not by the operator. You write the shape of the computation once and choose how it runs separately.

## What the compiler tracks

Mentl's mascot is an octopus because the compiler reasons about eight things at once, in a single pass over one shared graph:

1. **The graph.** Your program is a graph of nodes and typed edges. Every output (the compiled WebAssembly, an error message, a hover tooltip) is a read of that one graph, never a separate artifact that can fall out of sync.
2. **Handlers.** One mechanism, `handle` and `resume`, covers what other languages split across exceptions, generators, async, and dependency injection. The compiler infers whether a handler resumes once or many times by reading the code, so you never write it down.
3. **The five operators** above.
4. **Effects, with negation.** A full Boolean algebra over what a function may do, including `!E` to prove it doesn't do something.
5. **Ownership.** `own` and `ref` give memory safety, inferred from how you use a value, so most code carries no annotations at all.
6. **Refinement types.** `type Port = Int where self >= 1024` is checked at compile time and erased at runtime.
7. **A gradient.** As you add annotations, the compiler turns runtime checks into compile-time guarantees, and it tells you what each annotation buys you.
8. **Inference with reasons.** Types, effects, ownership, and refinements are all worked out in one walk, and every conclusion records why it holds, so any error can be explained by walking back to its cause.

Take any one of these away and the rest stop composing. They were designed to work as a set.

## One language, many domains

Domains differ in their handlers, not in their core, so one Mentl developer can move between fields without changing tools:

- **Audio and DSP.** `with Sample(44100) + !Alloc` proves a signal path is safe to run in a real-time callback, and `<~` makes feedback filters first-class.
- **Machine learning.** An autodiff handler draws the computation graph out of the same five operators.
- **Web and services.** The DOM and the network are effects; handler chains compose where you would otherwise import a framework.
- **Embedded and kernel code.** `with !Alloc + !IO` proves a path makes no allocations and no syscalls, all the way down the call tree.

## Where it stands

This is an in-progress compiler, built in the open. The language design is largely settled and written down (see the docs below). The compiler is written in Mentl and bootstraps from a small hand-written WebAssembly seed: the seed compiles the compiler once, and the milestone in progress, called first-light, is the point where the compiler compiles itself and reproduces its own output byte for byte. That fixed point is the smallest possible proof that the language can build itself.

Landed recently: an effect system with working negation, ownership inferred from use, a unified value model where a string is just a sequence of bytes, multi-shot continuations, and an e-graph optimizer that only rewrites code it can prove is free of side effects. What remains is tracked honestly in the docs rather than hidden.

## What's genuinely new, and what isn't

Most of the pieces exist somewhere already. Koka has row-polymorphic effects. Flix ships effect negation. Rust has zero-cost ownership. Refinement types and e-graphs are well-studied. The claim here is not that any single piece is unprecedented. It is that no shipped system puts them in one kernel that infers them together, and that two things in Mentl don't yet have a counterpart anywhere:

- A continuous annotation gradient with narration. Each annotation you add converts a runtime check into a compile-time guarantee, and the compiler tells you the exchange rate as you go.
- Proof-carrying transformation. Every fact in the graph records why it holds, so every optimization and refactor can re-prove itself instead of hoping it stayed correct.

## Learn more

- [`docs/SYNTAX.md`](docs/SYNTAX.md) is the language surface: every form, with the reasoning behind it.
- [`PLAN.md`](PLAN.md) is the design: what Mentl is, the eight-primitive kernel, and the decisions behind each part.
- [`lib/tutorial/`](lib/tutorial/) holds short runnable programs, one per primitive. Start at `00-hello.mn`.
- [`CLAUDE.md`](CLAUDE.md) is the working discipline for anyone, human or AI, contributing to the compiler.

## Repository layout

```
src/         the compiler, written in Mentl: parser, inference, lowering,
             the WebAssembly backend, and the editor/cursor surfaces
lib/         the standard library, DSP and ML examples, and the tutorials
bootstrap/   the disposable seed that compiles the compiler the first time
docs/        SYNTAX.md and supporting material
tools/       build and verification scripts, a VSCode extension, and the
             Mentl Mono font
```

## License

Dual-licensed under MIT or Apache 2.0. See `LICENSE-MIT` and `LICENSE-APACHE`.
