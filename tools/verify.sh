#!/usr/bin/env bash
# tools/verify.sh — the FAIL-CLOSED Mentl-thesis gate (proto-`mentl check`).
#
# Externalized in bash the verifier ledger (src/verify.mn) that the kernel
# INTERNALIZES at L1. Until then, this is the strongest enforcement bash can
# give: it does not nudge, it REFUSES. Exit 0 ONLY if the empirically-checkable
# thesis invariants ALL hold:
#   1. the seed builds,
#   2. the micro battery is green (each exit code matches its expectation),
#   3. the wheel census does NOT regress past the recorded baseline.
# Any violation => exit 1, and the pre-commit hook blocks the commit — so a
# thesis-violating state is impossible to land. The baseline (census_max +
# micro expectations) lives in tools/verify-baseline.txt; moving it requires a
# VISIBLE edit there — silent regression cannot happen by construction. The
# census ratchets toward 0 (first-light); never up without a deliberate edit.
#
# Usage: tools/verify.sh
# Exit:  0 thesis holds, 1 thesis violated, 2 invocation error.
set -uo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

BASELINE="tools/verify-baseline.txt"
WT="${WASMTIME_BIN:-$HOME/.wasmtime/bin/wasmtime}"
WTFLAGS=(run -W threads=y -W shared-memory=y -W tail-call=y -S threads=y)

say() { printf '%s\n' "$*"; }
fail=0

[[ -f "$BASELINE" ]] || { say "verify: baseline missing: $BASELINE"; exit 2; }
[[ -x "$WT" ]] || { say "verify: wasmtime not found at $WT (set WASMTIME_BIN)"; exit 2; }
census_max=$(grep -oE '^census_max=[0-9]+' "$BASELINE" | grep -oE '[0-9]+$' | head -1)
[[ -n "$census_max" ]] || { say "verify: census_max missing from $BASELINE"; exit 2; }

# 1. Seed builds.
if ! bash bootstrap/build.sh >/tmp/verify_build.log 2>&1; then
  say "✗ seed build FAILED (tail /tmp/verify_build.log):"; tail -3 /tmp/verify_build.log; exit 1
fi
say "✓ seed builds"

# 2. Micro battery — each line `micro:NAME=EXPECTED_EXIT` in the baseline.
while IFS= read -r line; do
  name=${line#micro:}; m=${name%%=*}; want=${name#*=}
  out=$(tools/run-micro.sh "tests/micros/mn-${m}.mn" "$want" 2>/dev/null | tail -1)
  if [[ "$out" == PASS* ]]; then say "✓ micro $m=$want"; else say "✗ micro $m: ${out:-no output}"; fail=1; fi
done < <(grep -E '^micro:' "$BASELINE")

# 3. Wheel census non-regression (the ratchet toward first-light).
{ find src -name '*.mn' | sort | xargs cat; \
  find lib -name '*.mn' -not -path '*/tutorial/*' | sort | xargs cat; } > /tmp/verify_wheel.mn
if "$WT" "${WTFLAGS[@]}" bootstrap/mentl.wasm < /tmp/verify_wheel.mn \
      > /tmp/verify_m2.wat 2>/tmp/verify_m2.err; then
  census=$(grep -cE '^(E_|W_)' /tmp/verify_m2.err)
  if [[ "$census" -le "$census_max" ]]; then
    say "✓ census $census ≤ baseline $census_max"
  else
    say "✗ census REGRESSED: $census > baseline $census_max"; fail=1
  fi
else
  say "✗ seed TRAPPED compiling the wheel (tail /tmp/verify_m2.err):"; tail -3 /tmp/verify_m2.err; fail=1
fi

if [[ "$fail" -ne 0 ]]; then
  say ""
  say "verify: THE MENTL-THESIS GATE FAILED — this state cannot be committed."
  say "Fix it (carry the handle, read live; rewrite in residue form), or — if this"
  say "is deliberate, explained progress — edit tools/verify-baseline.txt."
  exit 1
fi
say "verify: thesis invariants hold."
exit 0
