#!/usr/bin/env bash
# run-micro.sh — the canonical micro harness. Measurement cannot lie:
# every exit code is captured directly (never through a pipe), every
# stage's failure is named. Pre-L1 shape of `mentl test`.
#
# Usage: tools/run-micro.sh <micro.mn> [expected_exit] [lib...]
#   tools/run-micro.sh tests/micros/mn-ev4.mn 57
#   tools/run-micro.sh tests/micros/mn-eq.mn 73 lib/runtime/memory.mn lib/runtime/strings.mn lib/runtime/lists.mn
set -u
MICRO="$1"; EXPECT="${2:-}"
shift 2 2>/dev/null || shift 1
LIBS=("$@")
SEED="bootstrap/mentl.wasm"
WT=(wasmtime run -W threads=y -W shared-memory=y -W tail-call=y -S threads=y)
# Honor TMPDIR (state.sh points it at a luks build dir); never hardwire the
# RAM-backed tmpfs — wasmtime's shared-memory partition exhausts its quota.
base="${TMPDIR:-/tmp}/$(basename "$MICRO" .mn)"

cat "${LIBS[@]}" "$MICRO" 2>/dev/null | "${WT[@]}" "$SEED" > "$base.wat" 2> "$base.err"
compile_exit=$?
diags=$(grep -c '^[EW]_' "$base.err" || true)
if [ $compile_exit -ne 0 ]; then
  echo "FAIL(compile) $MICRO: seed exit=$compile_exit diags=$diags"
  tail -4 "$base.err"; exit 1
fi
if ! wat2wasm --debug-names --enable-threads --enable-tail-call "$base.wat" -o "$base.wasm" 2> "$base.w2e"; then
  echo "FAIL(wat) $MICRO: $(head -1 "$base.w2e")"; exit 1
fi
"${WT[@]}" "$base.wasm" > "$base.out" 2> "$base.run-err"
run_exit=$?
if [ -n "$EXPECT" ] && [ "$run_exit" -ne "$EXPECT" ]; then
  echo "FAIL(run) $MICRO: exit=$run_exit expected=$EXPECT diags=$diags"
  tail -4 "$base.run-err"; exit 1
fi
echo "PASS $MICRO: exit=$run_exit${EXPECT:+ (expected $EXPECT)} diags=$diags"
