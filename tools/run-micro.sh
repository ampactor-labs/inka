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
# The compiler under test: the pinned fixpoint wheel (boot/PROVENANCE.md).
# MENTL_BOOT=<path> points the battery at any compiler (e.g. a fresh m3).
BOOT="${MENTL_BOOT:-boot/mentl.wasm}"
source "$(dirname "$0")/wt-env.sh"   # wt_run, wt_asm — the one home
# Honor TMPDIR (state.sh points it at a luks build dir); never hardwire the
# RAM-backed tmpfs — wasmtime's shared-memory partition exhausts its quota.
base="${TMPDIR:-/tmp}/$(basename "$MICRO" .mn)"

# THE EXIT CHANNEL HAS A CEILING, and a fixture may not encode a value above
# it. Measured 2026-08-18 against the pinned boot: a `main` returning 124 or
# 125 exits with that number, and 126, 127, 128, 200, 255 and 256 ALL exit 1.
# So an expectation above 125 can only be a SIGNAL (the shell's 128+signum —
# every such fixture in the battery is 134, a wasm trap through SIGABRT), and
# 126 and 127 are neither a reachable value nor a signal. Refusing them here
# is the difference between an author reading "the program computed 1" and
# an author reading why their number could never arrive.
case "${EXPECT:-}" in
  126|127)
    echo "REFUSE $MICRO: expect $EXPECT is neither a reachable value (the exit"
    echo "  channel caps at 125) nor a signal (128+signum). Pick a value <= 125."
    exit 1 ;;
esac

cat "${LIBS[@]}" "$MICRO" 2>/dev/null | wt_run "$BOOT" > "$base.wat" 2> "$base.err"
compile_exit=$?
diags=$(grep -c '^[EW]_' "$base.err" || true)
if [ $compile_exit -ne 0 ]; then
  echo "FAIL(compile) $MICRO: compiler exit=$compile_exit diags=$diags"
  tail -4 "$base.err"; exit 1
fi
if ! wt_asm "$base.wat" "$base.wasm" 2> "$base.w2e"; then
  echo "FAIL(wat) $MICRO: $(head -1 "$base.w2e")"; exit 1
fi
wt_run "$base.wasm" > "$base.out" 2> "$base.run-err"
run_exit=$?
if [ -n "$EXPECT" ] && [ "$run_exit" -ne "$EXPECT" ]; then
  echo "FAIL(run) $MICRO: exit=$run_exit expected=$EXPECT diags=$diags"
  # The 1 is the ceiling, not the computation. Say so, or the next reader
  # "fixes" the expectation to 1 and banks a gate that asserts nothing.
  if [ "$run_exit" -eq 1 ] && [ "$EXPECT" -gt 125 ]; then
    echo "  the exit channel caps at 125: any value above it arrives as 1, so this"
    echo "  1 is the channel and not the program. Expect <= 125, or 134 for a trap."
  fi
  tail -4 "$base.run-err"; exit 1
fi
echo "PASS $MICRO: exit=$run_exit${EXPECT:+ (expected $EXPECT)} diags=$diags"
