# Mentl

Machines now write most new code, and nobody can read it all. Trust has to
come from somewhere other than review. Mentl is a programming language whose
compiler *proves* what your program does — and what it cannot do — and teaches
you, in words, as you write. Any intelligence may propose; nothing executes
unproven; intent is never lost; capability is always bounded.

If you have never written code: the transcripts below are conversations, and
you can read them. If you write compilers for a living: the kernel is one
graph, two operations, and a self-hosted fixed point, and the receipts are one
command. This page is the door for both of you; the school is inside.

## Watch it speak

Leave a hole where a value should go, and the medium proposes a proven fill.
Here `??` must be a `Positive` number, and asking at the hole's address
projects what the medium knows:

```
type Positive = Int where self > 0

fn choose(n: Positive) = n * 2

fn main() = choose(??)
```
```
$ mentl hole.mn:5:20
Query: ??) : Positive
Propose: 1
Why: declaration-order param, at hole.mn:5
```

Claim something false, and the medium refuses to build the program — and says
why, at the exact line:

```
type Sample = Float where -1.0 <= self && self <= 1.0

fn main() = {
  let bad: Sample = 1.5
  42
}
```
```
$ mentl run refuse.mn
verify: E_RefinementRejected error: refinement predicate proven false at compile time
mentl: refusing to emit — 1 claim(s) the medium could not discharge
$ echo $?
1
```

No warning you can ignore, no runtime crash later: a false claim produces no
executable at all. That is the whole thesis in one exit code. The deepest form
of it is negation — `!E` proves the *absence* of a capability, transitively:
that a function cannot reach the network, cannot allocate, cannot touch a
secret, no matter what it calls. Proving what software *won't* do is the
guarantee autonomous systems actually need, and it is Mentl's native verb.

## Try it

```sh
git clone <this-repo> mentl && cd mentl
bash tools/install.sh                 # writes ~/.local/bin/mentl → the live pinned boot
mentl new hello                       # scaffolds hello.mn (one file; the imports are the manifest)
mentl run hello                       # compile, prove, execute
mentl                                 # project the current directory — where you are, what's next
```

`mentl` needs [`wasmtime`](https://wasmtime.dev) on the path. No package
manager, no manifest, no version pin: the pinned boot *is* the release, and
every re-pin is instantly the global command.

## The school

The full course lives in `lib/tutorial/` — ten lessons, each a runnable
program whose comments are the teaching (Mentl keeps comments as part of the
program's graph, so the medium can read your intent back to you). They are
written to be read first and run second; no prior programming is assumed.

```
$ mentl run lib/tutorial/00-hello.mn
Hello, kernel. The medium is reading you back.
Hello, oracle. The medium is reading you back.
Hello, octopus. The medium is reading you back.
```

Walk them in order: `00-hello` (meet the medium) · `01-graph` (everything is
one graph) · `02-handlers` (effects are answered, not feared) · `03-verbs`
(the five pipe shapes) · `04-row` (declaring and denying capabilities) ·
`05-ownership` (who holds a value) · `06-refinement` (types that carry
bounds) · `07-gradient` (the medium proposes) · `08-reasons` (ask *why*) ·
`09-all` (everything at once). At any line of any lesson,
`mentl <file>:<line>` projects what the medium knows there.

## The surface

```
mentl run <path>        compile, prove, execute (a hole or refuted claim REFUSES)
mentl check <path>      diagnostics only, no emit
mentl compile <path>    emit WAT to stdout
mentl edit [path]       the cursor session — eight aspects + proven proposals
mentl <file>:<line>     project a position: type, effects, ownership, why
mentl audit <path>      the capability set + severance unlocks
mentl fmt <path>        canonical layout (the shape on the page is the graph)
mentl new <name>        write <name>.mn here
mentl help              the full projection
```

A target is a module name or a file path, from any directory. A bare `mentl`
reads where you are and offers each source's next keystroke.

## The kernel, for the skeptical

One graph; two operations (draw an edge, project a read). Every subsystem is
the same read in a different mode: the compiler, the IDE, the prover, the
proposal engine. Effects are rows with Boolean negation (`with IO + !Alloc`);
handlers are the one dynamic mechanism, and handler = state = closure =
continuation is one heap record, which is why a paused computation can be
persisted by copying bytes. Ownership and refinement are inferred, not
annotated; annotations are inputs that unlock capability, never ceremony.

It self-hosts. The compiler compiles itself to a byte-identical fixed point;
that binary, `boot/mentl.wasm`, is Mentl, and every landing must reproduce it:

```sh
bash tools/state.sh     # git → verify → the self-hosting fixpoint → frontier → proof-exactness → crown
```

The board is the release gate. Today it holds: the fixpoint byte-identical;
zero errors from the medium on its own source; `!E` soundness gated by five
crucibles; refusal classes armed one at a time as each reaches zero on the
wheel itself; real host-thread parallelism over one shared image, gated by
fixtures that answer the same number sequential and spawned.

## The three documents

Mentl's whole read-path is three self-contained files; everything else under
`docs/` is archaeology.

- `CLAUDE.md` is the method: how the medium is built and how to think in it.
- `PLAN.md` is the substance: what Mentl is, the kernel, the resolved
  decisions, the current state, the campaign order.
- `docs/SYNTAX.md` is the surface: the authoritative language form.

## What is honestly unfinished

The verifier is sound and incomplete by choice: what it cannot decide accrues
as visible pending debt, never assumed true. The named frontier — the modal
effect crown, information-flow control, durable execution as a handler swap, a
native backend — is sequenced in `PLAN.md §5`, in positive form, never hidden.
A claim you cannot re-derive from the board is a claim this project does not
make.

## License

Not yet chosen. Public-repo and license readiness is a tracked item on the
production bar (`PLAN.md §11`, column 5).
