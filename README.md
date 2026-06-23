# Mentl

A programming language where the compiler proves what your code does, instead of trusting that it looks right. The compiler is written in Mentl itself.

Most languages let you describe what a function does. Mentl proves what a function will never do, explores many provably-correct ways to finish the code you are writing, and speaks audio, machine learning, the web, and embedded firmware through one small set of operators. The sections below show the mechanism behind each of those, because none of them are believable on assertion alone.

File extension: `.mn`.

## Proving the negative

The hardest thing to know about a program is what it will not do. Mentl proves it. Write `!Alloc` on a function and the compiler proves that function allocates no memory. Write `!Network` and it proves nothing inside reaches the network. Write `!Show` on a field and it proves that secret never reaches a log. The proof holds transitively: if anything down the call tree breaks the promise, the code does not compile.

```
fn mix(left, right) with !Alloc =
  (left + right) * 0.5
```

Almost no production type system can express the *absence* of a behavior. It turns out to be the guarantee that matters most for code no human wrote, because when a machine generates the code, "it looks right" is worth nothing. The only thing left worth trusting is what the compiler can prove the code will not do.

## The compiler explores instead of guessing

Leave a hole where you are stuck. Mentl does not reach for a model that predicts likely text. It forks the program graph, runs candidate completions down parallel branches, type-checks and proves each one, throws away the branches that fail, and shows you what survived. This is the search a constraint solver does, run on your actual program with your actual constraints.

The gap between that and an AI assistant is the gap between approximation and proof. A model matches patterns and has a ceiling it approaches but never passes, because it is guessing, not checking. Mentl checks. When a stronger model arrives, it plugs in as one more source of candidates, and those candidates still have to clear the same proof before they reach you. Mentl is not a competitor to AI code generation. It is the layer that makes any generator's output safe to use.

## One language for audio, machine learning, the web, and the firmware underneath

Most stacks make you switch languages when you switch domains: Python for the model, C for the signal processing, JavaScript for the interface. In Mentl the domains differ only in which handlers you install. The operators that pipe audio through a filter are the same ones that draw a neural network's computation graph. An autodiff handler makes that graph differentiable. A `Sample(44100)` handler makes it real-time audio. Because they compose, you can run a learned model inside an audio pipeline and prove the whole path never allocates on the audio thread.

There is a deeper reason these fit in one language. Automatic differentiation and the exploration above are the same primitive: the backward pass of autodiff is a saved computation re-run with new inputs, which is exactly what a multi-shot continuation is. You can train a model in the morning and write the real-time effect that runs it that night, in one language that speaks both.

## The compiler teaches you instead of only rejecting you

Every annotation you add trades a runtime check for a compile-time guarantee, and the compiler tells you the exchange rate as you type. Mark a function `!Alloc` and it proves no allocation, then shows you what that unlocks: the function can now run in a real-time path. It works like a gradient you climb, not a wall you hit. And because every conclusion it reaches records why it holds, the compiler can always walk you back to the cause of an error instead of just pointing at a line.

## What you write

Five operators, each drawing one shape of data flow:

- `|>` runs stages in sequence: `audio |> normalize |> compress |> limit`
- `<|` sends one value into several branches and collects the results
- `><` runs independent pipelines side by side
- `~>` attaches a handler that interprets the effects to its left
- `<~` feeds a value back as the next input, which makes feedback loops first-class

Whether a `><` runs on threads, on SIMD lanes, or on a GPU is decided by the handler you install over it, not by the operator. You write the shape of the computation once and choose how it runs separately.

## What the compiler tracks

The mascot is an octopus because the compiler reasons about eight things at once, in one pass over one shared graph:

1. **The graph.** The program is a graph of nodes and typed edges. Every output, from the compiled WebAssembly to a hover tooltip, is a read of that one graph, never a separate copy that can drift out of sync.
2. **Handlers.** One mechanism, `handle` and `resume`, does the work that other languages split across exceptions, generators, async, and dependency injection. Whether a handler resumes once or many times is inferred from the code.
3. **The five operators** above.
4. **Effects, with negation.** A full Boolean algebra over what a function may do, including `!E` to prove it does not.
5. **Ownership.** `own` and `ref` give memory safety, inferred from how you use a value, so most code needs no annotations.
6. **Refinement types.** `type Port = Int where self >= 1024` is checked when you compile and erased when you run.
7. **A gradient.** The trade between runtime checks and compile-time guarantees, narrated as you go.
8. **Inference with reasons.** Types, effects, ownership, and refinements are worked out in one walk, and every step records why it holds.

Remove any one and the rest stop composing. They were designed as a set.

## Where it stands

This is a compiler in progress, built in the open. The language design is largely settled and written down. The compiler is written in Mentl and starts from a small hand-written WebAssembly seed that compiles it once; the milestone in progress, first-light, is the point where the compiler compiles itself and reproduces its own output byte for byte. That fixed point is the smallest possible proof that the language can build itself.

Already working: the effect system with negation, ownership inferred from use, a unified value model where a string is just a sequence of bytes, multi-shot continuations, an e-graph optimizer that only rewrites code it can prove has no side effects, and a representation system that gives a value its native machine width from its type. What is left is tracked in the docs rather than hidden.

## Where it sits in the field

Most of the pieces exist somewhere. Koka has row-polymorphic effects. Flix ships effect negation. Rust has zero-cost ownership. Refinement types and e-graphs are well studied. The claim is not that any one piece is unprecedented. It is that no shipped language puts them in a single kernel that infers them together, and that two things here have no counterpart yet: a continuous annotation gradient that narrates the trade it is making as you make it, and a graph where every fact carries its own proof, so every optimization and refactor can re-prove itself instead of hoping it stayed correct.

## Learn more

- [`docs/SYNTAX.md`](docs/SYNTAX.md) is the language surface: every form, with the reasoning behind it.
- [`PLAN.md`](PLAN.md) is the design: what Mentl is, the eight-primitive kernel, and the decisions behind each part.
- [`lib/tutorial/`](lib/tutorial/) holds short runnable programs, one per primitive. Start at `00-hello.mn`.
- [`CLAUDE.md`](CLAUDE.md) is the working discipline for anyone contributing to the compiler.

## Repository layout

```
src/         the compiler, written in Mentl: parser, inference, lowering,
             the WebAssembly backend, and the editor surfaces
lib/         the standard library, DSP and ML examples, and the tutorials
bootstrap/   the disposable seed that compiles the compiler the first time
docs/        SYNTAX.md and supporting material
tools/       build and verification scripts, a VSCode extension, and the
             Mentl Mono font
```

## License

Dual-licensed under MIT or Apache 2.0. See `LICENSE-MIT` and `LICENSE-APACHE`.
