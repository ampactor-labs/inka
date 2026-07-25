# Mentl

Machines now write most new code, and nobody can read it all. Trust has to
come from somewhere other than review. Mentl is a programming language whose
compiler *proves* what your program does — and what it can never do — and
teaches you, in words, as you write. Any intelligence may propose; nothing
executes unproven; intent is never lost; capability is always bounded.

If you have never written code: everything below is written to be read, and
the transcripts are conversations. If you write compilers for a living: the
kernel is one graph, two operations, and a self-hosted fixed point, and the
receipts are one command. This page is the door. The school is inside.

## The shape of it

There are exactly five verbs of flow in this medium, and they are the
complete vocabulary; every program you will ever read is these five shapes
combined. `|>` is "and then." `<|` fans one value out to several readers.
`><` runs independent things side by side — read the page: they are literally
side by side, because the shape on the page is the shape of the work, and the
formatter keeps that true. `~>` installs an answerer over everything to its
left. And `<~` is the one to slow down for.

Sound has memory. An echo is now plus a little of before; there is no echo
without a before. Most languages make you build memory out of scaffolding.
Here, memory is a shape you draw — a loop in the graph:

```
fn echo(mix, x) with Clock(48_000) =
  ((prev) => x + mix * prev) <~ delay(24_000)
```

`<~` means "feeds back." The right side is a memory element: it hands back
what you gave it 24,000 ticks ago, and at 48,000 ticks a second that is half
a second — the slap of a stone room. The left side is what to do each tick:
`prev` is the echo's own past arriving back; the new sample is now plus a
share of before. The whole physics of an echo, in one line you can read
aloud. And a promise rides inside it: `prev` is not a box secretly allocated
each tick. The medium inlines the loop into a register, which is why this
same echo can sit inside a function that has sworn never to allocate, and
the oath will hold.

## The second hand

A function's effect row has two hands. The first says what it needs. The
second says what it can never do, and this is the hand that holds the true
name.

Picture the third night of a tour. Two thousand people. Fifty seconds into
the set, the voice stutters — one dropped buffer, a click like a snapped
string — because somewhere down the call tree one line allocated memory at
the wrong moment. Every audio programmer alive holds that dread at bay the
same way: discipline, review, a wiki page that says *never allocate on the
audio thread*. A promise. Here is the same intention, said in this medium:

```
fn voice(x) with Clock(48_000) + !Alloc =
  x
    |> gain(-3.0)
    |> lowpass(0.2)
    |> echo(0.35)
```

`!Alloc`. Read it: *cannot allocate*. Not "does not," not "was tested and
didn't," not "the team agreed not to." Cannot — proven, transitively: the
gain, the filter, the echo and its half-second memory, everything they call,
to the bottom. If one line anywhere beneath this signature allocates, the
program does not build, and the refusal arrives with the chain of reasons
walked back to the guilty line. The dread does not get quieter. It gets
impossible.

This is `!E`, effect negation, and you should know plainly: everything else
in this medium has cousins scattered across other languages. The proven
negative — transitive, compile-time — does not. And it is the guarantee the
machine-writing age actually needs:

```
fn admit(pedal, x) with !Network + !FileSystem =
  play_through(pedal, x)
```

A guest effect — a pedal someone else built, plugged into your voice. You
did not read its code. You cannot; there is too much of it, and tomorrow
there will be more, and no one you trust wrote it. You do not need to. The
row is the door policy: inside this signature the guest cannot reach the
network and cannot touch a file, and if anything inside it tries, there is
no built program to run. It can be brilliant. It can be a thousand times
cleverer than you. It cannot phone home. Let the machine write. Let anything
write.

## Watch it speak

The proofs above are the medium's spine; here it is talking, today, through
the pinned compiler in this repository. Leave a hole where a value should
go, and it proposes a proven fill:

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

Claim something false, and it refuses to build the program — at the exact
line, in words:

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
executable at all. That is the whole thesis in one exit code.

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
(the five shapes) · `04-row` (declaring and denying capabilities) ·
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
