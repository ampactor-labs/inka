#!/usr/bin/env bash
# Exact effect-namespace gate. The runtime micro proves dispatch isolation;
# the declaration census prevents the flat wheel input from silently restoring
# either duplicate name before import-edge collision diagnostics are complete.
set -uo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

fail=0

expect_count() {
  local label="$1" expected="$2" pattern="$3"
  local count
  count=$(rg -n --glob '*.mn' "$pattern" src lib 2>/dev/null | wc -l)
  if [[ "$count" -eq "$expected" ]]; then
    printf 'PASS %s (%s)\n' "$label" "$count"
  else
    printf 'FAIL %s: got %s, expected %s\n' "$label" "$count" "$expected"
    rg -n --glob '*.mn' "$pattern" src lib 2>/dev/null || true
    fail=1
  fi
}

expect_count 'Abort declarations' 1 '^effect Abort\b'
expect_count 'Fail declarations' 1 '^effect Fail\b'
expect_count 'Alloc declarations' 1 '^effect Alloc\b'
expect_count 'fail_exit handlers' 1 '^handler fail_exit\b'
expect_count 'abort_exit handlers' 0 '^handler abort_exit\b'
expect_count 'DSP alloc_buffer residue' 0 '\balloc_buffer\b'

M="${GATE_WASM:-${MENTL_BOOT:-boot/mentl.wasm}}"
RTLIBS=(
  lib/runtime/memory.mn
  lib/runtime/strings.mn
  lib/runtime/lists.mn
  lib/prelude.mn
)
out=$(MENTL_BOOT="$M" tools/run-micro.sh \
  tests/micros/mn-effect-identity.mn 81 "${RTLIBS[@]}" 2>&1)
if [[ "$out" == PASS* ]]; then
  printf '%s\n' "$out"
else
  printf '%s\n' "$out"
  fail=1
fi

exit "$fail"
