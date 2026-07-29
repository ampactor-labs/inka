# mentl edit — the web IDE (band M's first artifact)

The page runs THE FIXPOINT COMPILER ITSELF in your browser: mentl-ide.wasm
is a pinned wheel with one derived change — the initial memory shrunk from
4GB to 512MB (IDE programs are small; the 4GB line exists for wheel-scale
self-compiles). Derivation, reproducible from a boot of its era:

    wasm2wat --enable-threads --enable-tail-call boot/mentl.wasm -o mentl-ide.wat
    sed -i 's/(memory (;0;) 65536 65536 shared)/(memory (;0;) 8192 65536 shared)/' mentl-ide.wat
    wat2wasm --debug-names --enable-threads --enable-tail-call mentl-ide.wat -o ide/mentl-ide.wasm

THE PIN IS DELIBERATELY PRE-SPAWN. The live boot became a SPAWNING module
(the real-spawn landing: it imports shared `env.memory` and
`wasi.thread-spawn`, and the converged judgment spawns a host thread per
stmt), so a stub shim cannot run it — a refused spawn is a loud trap by
design. Refreshing this wasm to the live pin gates on the browser
Worker-spawn shim (the runner pattern at the browser host —
`Hβ.ops.wasmtime-runner-migration`'s named residue). Until then the page
runs the last self-contained-memory wheel, and the shim twin's
CursorView leg reads RED when the repo's live lib sources drift past
what this era's wheel judges — the skew is the honest signal, never
papered over.

Run it:

    mentl space                 # then open http://localhost:7378/ide/

THE SERVER IS THE WHEEL. `mentl space` is the compiler's own verb — an
HTTP/1.1 file server in src/main.mn (the space arms), speaking WASI
preview1 sockets (lib/runtime/net.mn: sock_accept + poll_oneoff over a
listener the install shim preopens with -S tcplisten; connections are
plain fds). The serve.mn/serve.sh scaffold this absorbed is git
archaeology. By hand, from the repo root:

    wasmtime run <flags> --dir . -S tcplisten=127.0.0.1:7378 boot/mentl.wasm space

The isolation headers exist for one reason: the compiler's memory is
SHARED (the threading substrate), and browsers require cross-origin
isolation (COOP/COEP) for shared WebAssembly memory. Every response the
Mentl server writes carries the pair; the page also fetches
lib/runtime/*.mn + lib/prelude.mn from the repo to link the runtime the
way tools/run-micro.sh does.

The page is `mentl edit` (`docs/MENTL_EDIT.md`) in its first real form,
built to the brand in `docs/DESIGN_SYSTEM.md`. One cursor is the one reader:
move the caret and every surface re-projects around it — panels are cursor
modes, not features. Five surfaces:

- **The Canvas** — a SYNTAX-faithful editor. Each glyph is its kernel role's
  Okabe–Ito hue: the five verbs in sky (Topology), types gold, keywords blue,
  `own`/`ref`/`resume` magenta, literals and `!E` vermillion, the `??` socket
  glowing vermillion. The caret is the position every other surface reads.
- **The Aspect ring** — the eight facets at the cursor (graph, handler, verb,
  row, own, refine, gradient, why). It reads the compiler's OWN eight-aspect
  CursorView: on cursor settle the page runs the wheel's cursor-address
  transport (`mentl main.mn:L:C` → src/main.mn `at_run` → `cursor_at_handle`,
  the same read `mentl edit` projects) over a virtual filesystem (the user
  source as main.mn + the vocabulary closure), and the returned facets (the
  inferred type, the effect row, ownership, refinement obligations, the Teach
  step, the Reason chain) flip their provenance badge to `real`. Where the
  projection is silent or a program the closure can't resolve, the facet keeps
  the page's own read: `surface` (its parse), `declared` (a `with` row read
  verbatim), or `socket` (a named-future gate — never a value it can't earn).
  The badge is `real` ONLY for a fact the compiler graph actually returned.
- **The Lens** — the real `stderr` diagnostics, gradient-ranked to one teaching
  step in Mentl's voice, click-to-jump, with genuine text-fixes for the
  canonicalizations the parser reports (`E_RedundantBraces`,
  `E_RedundantPerform`) and for `T_OverDeclared` (the tightening — the
  message carries the proven row, the same patch `mentl tighten` authors).
- **The Proposal strip** — the cursor line's standing MachineApplicable
  patch as a ghost preview under the editor (was → now), accepted with
  Tab (no proposal: Tab indents — the copilot convention). An
  over-declared row proposes its tightening; a `??` whose Propose facet
  returned ONE proven survivor proposes the fill (a tie never proposes —
  the medium teaches the missing constraint instead of guessing). One
  pure rewrite (`patchLine`) serves the click affordance, the preview,
  and the accept.
- **The Ledger** — the effect rows from the `with` clauses, and the proof
  surface: what a `!E` region is proven *incapable* of. Declared today; the
  transitive hop-by-hop proof is honestly gated on band A.
- **The Wavefront** — the Why strip, plus the realities and trail scrubbers
  drawn as dormant, honest gates (band B's multi-shot producer), never a
  canned branch.

Plus the Teach knob (density scales with what's proven), the emitted-WAT
projection with fn/line/time stats, and eight demos. Everything is either
real compiler output (the WAT, the diagnostics) or a labeled surface read of
the source — no surface ever dresses a guess as the compiler's graph truth.

The aspect ring reads the live graph today, but the read is a full compile per
cursor settle (debounced, one WASM instantiation); the IC cursor's
millisecond re-projection is the ultimate form (`Hβ.felt.reactivity-typed-demand-driven`,
the session `<~` loop). The address transport also resolves a program only when
the vocabulary closure covers its imports; a program reaching for runtime
modules the page does not mount stays on the surface read (honest, never faked)
until the closure widens.

What deliberately does not exist yet, each an honest socket that names its
gate: RUNNING the compiled program in the page (`Hβ.felt.ide-run-in-page` —
needs an in-browser assembler; download the .wat and `wat2wasm out.wat -o
out.wasm --enable-threads --enable-tail-call && wasmtime run
-W all-proposals=y out.wasm`); fill-and-resume and reality-scrubbing (band
B's multi-shot producer); the transitive `!E` proof (band A's crown).

The serving loop is an evidence-threading tail call — constant stack for
the server's whole life, the first-light era's own tail form carrying its
own IDE.

The shim's Node twin (`node ide/test-shim.mjs`) is the harness — the same
import surface the page provides, runnable headlessly. If the page ever
misbehaves, the twin discriminates shim-vs-DOM in one command.
