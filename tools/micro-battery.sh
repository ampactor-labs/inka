#!/usr/bin/env bash
# micro-battery.sh — THE micro battery loop, one home.
#
# verify.sh (pinned boot) and march-gate.sh --micros (the candidate m2)
# both walked tests/micros/mn-*.mn with their own hand-rolled loops —
# two implementations of one judgment, drifting apart in grammar coverage
# (march-gate's reader knew the refuse contract, verify's skipped it).
# The loop lives here now; the harness stays run-micro.sh; the compiler
# under test is this script's first argument.
#
# Usage: tools/micro-battery.sh <compiler.wasm> [label]
set -u
COMPILER="$1"; LABEL="${2:-micros}"
source "$(dirname "$0")/wt-env.sh"

pass=0; fail=0; dtot=0; dfix=""
for mf in tests/micros/mn-*.mn; do
  m=$(basename "$mf" .mn); m=${m#mn-}
  # The fixture's first line is the ONE expectation home. Full grammar:
  # `// expect: N` runs to exit N; `// expect: refuse E_Class` passes iff
  # the compile refuses with that class named. run-micro.sh owns both.
  want=$(sed -n '1s|^// expect: \([0-9]\+\)$|\1|p' "$mf")
  refuse=$(sed -n '1s|^// expect: refuse \([A-Za-z_]\+\)$|\1|p' "$mf")
  if [ -z "$want" ] && [ -z "$refuse" ]; then
    echo "✗ micro $m: no '// expect: N' or '// expect: refuse E_*' header"
    fail=$((fail+1)); continue
  fi
  if [ -n "$want" ]; then exp="$want"; else exp="refuse:$refuse"; fi
  out=$(MENTL_BOOT="$COMPILER" tools/run-micro.sh "$mf" "$exp" "${MENTL_RT_LIBS[@]}" 2>/dev/null | grep -E '^(PASS|FAIL|REFUSE)' | tail -1)
  case "$out" in
    PASS*) echo "✓ micro $m: ${out#PASS }"; pass=$((pass+1)) ;;
    *)     echo "✗ micro $m: ${out:-no verdict}"; fail=$((fail+1)) ;;
  esac
  d=$(printf '%s' "$out" | sed -nE 's/.*diags=([0-9]+).*/\1/p')
  [ -n "$d" ] && { dtot=$((dtot + d)); [ "$d" -gt 0 ] && dfix="$dfix $m"; }
done
# The per-micro count is printed on every line and summed here, because a
# number nobody totals is a number nobody reads. It was structurally zero
# until 2026-09-03 (run-micro's anchor could not match a phase-prefixed
# diagnostic), so these errors are not new — they are newly VISIBLE, and the
# summary names which fixtures carry them rather than leaving a bare total.
echo "── $LABEL: $pass pass / $fail fail · $dtot error(s) reported across${dfix:- none} ──"
[ "$fail" -eq 0 ]
