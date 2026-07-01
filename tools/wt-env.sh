# tools/wt-env.sh — THE ONE HOME for the wasm toolchain invocation.
#
# Carried-Truth at the tooling layer: the wasmtime run-flags and the wat2wasm
# assemble-flags are a FACT with exactly one home. Every script sources this;
# nobody hand-types `-W threads=y …` again (the flag-split footgun that cost a
# session). The instant `mentl run` / `mentl asm` exist as real subcommands,
# this file dissolves — like every bootstrap scaffold.
#
#   Usage (source, never execute):   source "$(dirname "$0")/wt-env.sh"
#   Then:  wt_run <wasm> [args…]              # run with the canonical flags
#          wt_asm <in.wat> <out.wasm>         # assemble with the canonical flags
#          wt_func <wasm> <fn-name>           # WABT disasm of ONE function
#          wt_offsets <wat> <fn> <local>      # field-load offsets for a local
#          wt_wheel <src|lib> [src|lib] > f   # canonical wheel input (find-order)
#
# The four constants — WT, WT_RUN_FLAGS, W2W, WT_WABT — are the single source of
# truth. Override the binary via WASMTIME_BIN. Nothing here re-derives; every
# helper is a projection of the four constants.

# The threads/shared-memory/tail-call quartet is load-bearing: the seed uses
# wasi-threads shared memory (bootstrap wasi_thread_spawn substrate) and
# return_call_indirect (opcode 0x13). Drop any one flag → the module refuses to
# instantiate. This quartet is the invariant, proven across the whole toolchain.
WT="${WASMTIME_BIN:-$HOME/.wasmtime/bin/wasmtime}"
WT_RUN_FLAGS=(-W threads=y -W shared-memory=y -W tail-call=y -S threads=y)
W2W=(wat2wasm --debug-names --enable-threads --enable-tail-call)

# wt_run <wasm> [args…] — run a wasm module under the canonical flags. Stdin/
# stdout/stderr pass through untouched, so callers pipe the wheel in and capture
# the WAT out exactly as before.
wt_run() { "$WT" run "${WT_RUN_FLAGS[@]}" "$@"; }

# wt_asm <in.wat> <out.wasm> — assemble WAT→WASM under the canonical flags.
# Returns wat2wasm's own exit code; caller redirects stderr as it likes.
wt_asm() { "${W2W[@]}" "$1" -o "$2"; }

# ── WABT probes (the trap-pin workhorses; PLAN §8 — never grep the minified
#    emit). All read a *.wasm assembled by wt_asm, so the name section is live
#    (locals render as <__state>, <handle>, <tag>). ─────────────────────────

# wt_func <wasm> <fn-name> — disassemble exactly one function by its name-section
# name. The canonical replacement for hand-rolled `wasm-objdump -d | sed -n`.
wt_func() {
  wasm-objdump -d "$1" 2>/dev/null \
    | awk -v fn="<$2>:" '
        index($0, fn) { p = 1 }
        p { print }
        p && /^[0-9a-f]+ func\[/ && !index($0, fn) && NR > start { }
        p && /^[0-9a-f]+ func\[[0-9]+\] </ { if (seen++) exit } '
}

# wt_offsets <wat> <fn> <local> — the field-load offsets a given local is read
# at inside one function (the record-layout probe). Reads the readable WAT, not
# the binary, so field names/offsets are inline. Answers "what offset did
# `arm.body` resolve to?" without a global grep that matches every `arm`.
wt_offsets() {
  sed -n "/func \$$2 /,/^  (func \$/p" "$1" \
    | grep -oE "\\\$$3\)\(i32.load offset=[0-9]+" | sort | uniq -c
}

# wt_wheel <part…> — emit the canonical wheel input to stdout. Each part is
# `src` or `lib`; order is the argument order (so `wt_wheel src lib` is the
# canonical build order, `wt_wheel lib src` tests dependency-first). Uses `find`,
# NEVER `cat src/*.mn` (PLAN §6 — cat omits backends/). Excludes lib/tutorial.
wt_wheel() {
  local part
  for part in "$@"; do
    case "$part" in
      src) find src -name '*.mn' | sort | xargs cat ;;
      lib) find lib -name '*.mn' -not -path '*/tutorial/*' | sort | xargs cat ;;
      *) echo "wt-env: wt_wheel: unknown part '$part' (want src|lib)" >&2; return 2 ;;
    esac
  done
}
