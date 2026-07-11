# mentl edit — the web IDE (band M's first artifact)

The page runs THE FIXPOINT COMPILER ITSELF in your browser: mentl-ide.wasm
is the first-light wheel (boot/PROVENANCE.md) with one derived change — the
initial memory shrunk from 4GB to 512MB (IDE programs are small; the 4GB
line exists for wheel-scale self-compiles). Derivation, reproducible:

    sed 's/(memory (export "memory") 65536 65536 shared)/(memory (export "memory") 8192 65536 shared)/' \
        .build/march/m3.wat > mentl-ide.wat
    wat2wasm mentl-ide.wat -o ide/mentl-ide.wasm --enable-threads --enable-tail-call

Run it:

    bash ide/serve.sh           # then open http://localhost:7378/ide/

THE SERVER IS MENTL. ide/serve.mn is an HTTP/1.1 file server written in
Mentl, compiled by the fixpoint compiler, speaking WASI preview1 sockets
(lib/runtime/net.mn: sock_accept + poll_oneoff over a listener wasmtime
preopens with -S tcplisten; connections are plain fds). serve.sh only
compiles-if-stale and hands wasmtime the invocation — a scaffold that
dissolves at the `mentl serve` verb.

The isolation headers exist for one reason: the compiler's memory is
SHARED (the threading substrate), and browsers require cross-origin
isolation (COOP/COEP) for shared WebAssembly memory. Every response the
Mentl server writes carries the pair; the page also fetches
lib/runtime/*.mn + lib/prelude.mn from the repo to link the runtime the
way tools/run-micro.sh does.

What works today: the live loop (keystroke → compile → project, debounced),
diagnostics parsed into a clickable panel (click → jump to the source
line), the emitted WAT with fn/line/time stats, six demo programs, and the
`.mn` highlighter (the five verbs and the `??` hole get the accent they
deserve). What deliberately does not: RUNNING the compiled program in the
page — that needs an assembler in the browser, a named follow-up
(`Hβ.felt.ide-run-in-page`); until then, download the .wat and
`wat2wasm out.wat -o out.wasm --enable-threads --enable-tail-call &&
wasmtime run -W all-proposals=y out.wasm`.

The serving loop is an evidence-threading tail call — constant stack for
the server's whole life, the first-light era's own tail form carrying its
own IDE.

The shim's Node twin (`node ide/test-shim.mjs`) is the harness — the same
import surface the page provides, runnable headlessly. If the page ever
misbehaves, the twin discriminates shim-vs-DOM in one command.
