# Mentl

Any intelligence may propose; nothing executes unproven; intent is never lost;
capability is always bounded.

Mentl is a verification substrate for the age of machine-generated code. When no
human authored a program, "looks right" is worthless, so Mentl replaces review
with proof: one graph, two operations (draw an edge, project), and a compiler
that is a handler on its own graph. It self-hosts. The compiler compiles itself
to a byte-identical fixed point; that binary, `boot/mentl.wasm`, *is* Mentl, so
the medium is its own first user and its own proof of correctness.

Its most underrated arm is the negative. `!E` proves the *absence* of an effect:
that a function will not allocate, will not reach the network, will not leak a
secret, transitively, through the whole call graph. That is the guarantee
autonomous software actually needs, and nothing else on the shelf states it.

## Quickstart

```sh
git clone <this-repo> mentl && cd mentl
bash tools/install.sh                 # writes ~/.local/bin/mentl → the live pinned boot
mentl new hello                       # scaffolds hello.mn (one file; the imports are the manifest)
mentl run hello                       # compile, prove, execute
mentl                                 # project the current directory — where you are, what's next
```

`mentl` needs [`wasmtime`](https://wasmtime.dev) on the path. No package
manager, no manifest, no version pin: the pinned boot *is* the release, and
`tools/install.sh` writes a pointer to it, so every re-pin is instantly the
global command.

## The surface

```
mentl run <path>        compile, prove, execute (a hole or refuted claim REFUSES)
mentl check <path>      diagnostics only, no emit
mentl compile <path>    emit WAT to stdout
mentl edit [path]       the cursor session — eight aspects + proven proposals
mentl query <path> <q>  why / type / effects / ownership, walked to your words
mentl audit <path>      the capability set + severance unlocks
mentl new <name>        write <name>.mn here
mentl help              the full projection
```

A target is a module name or a file path, from any directory. A bare `mentl`
reads where you are and offers each source's next keystroke.

## What is real

The board is the release gate — run it:

```sh
bash tools/state.sh     # git → verify → the self-hosting fixpoint → frontier → proof-exactness → crown
```

Self-hosting holds: `m2 == m3`, byte-identical. The medium reports zero errors
on its own source. `!E` soundness is gated by five crucibles. Strings and
`[Float]` are one packed-sequence substrate, where a sequence carries its
element stride in its own tag word. Refinement types discharge a decidable
arithmetic fragment; the rest accrues honest, visible proof debt rather than
assuming it away. The frontier is named in positive form in `PLAN.md §5`, never
hidden: the modal effect crown, information-flow control, durable execution, a
native backend.

## The three documents

Mentl's whole read-path is three self-contained files. Read them in this order;
everything else under `docs/` is archaeology.

- `CLAUDE.md` is the method: how the medium is built and how to think in it.
- `PLAN.md` is the substance: what Mentl is, the kernel, the resolved decisions,
  the current state.
- `docs/SYNTAX.md` is the surface: the authoritative language form.

## License

Not yet chosen. Public-repo and license readiness is a tracked item on the
production bar (`PLAN.md §11`, column 5).
