#!/usr/bin/env bash
# benchmarks/absence/run.sh — the ABSENCE benchmark's runner.
#
# Each task is a self-contained Mentl program whose FIRST LINE states its
# own contract (the fixture-states-its-own-contract convention):
#
#   // expect: PROVE               — the absence claims discharge; the
#                                    program compiles with zero E_ errors
#   // expect: REFUSE <diagnostic> — the gate must refuse, naming the class
#
# The oracle is the compiler itself: verdicts are read from the diagnostic
# stream of a solo compile (no stdlib — the signal is never masked by
# library noise). A REFUSE scores full credit only when the named class
# appears; the teaching axis (does the refusal carry a source span?) is
# reported per task. Any tool that can express these properties is invited
# to run the same suite; the task set is deliberately small and readable.
#
# Compiler-under-test: $GATE_WASM, or $MENTL_BOOT, or the repo's keyed
# boot->m2 artifact.
set -u
cd "$(dirname "$0")/../.." || exit 2
source tools/wt-env.sh

if [ -n "${GATE_WASM:-}" ]; then
  M="$GATE_WASM"
elif [ -n "${MENTL_BOOT:-}" ]; then
  M="$MENTL_BOOT"
else
  C=$(wt_m2_ensure) || { echo "absence: m2 generation trapped"; exit 2; }
  M="$C/m2.wasm"
fi

pass=0; fail=0
for f in benchmarks/absence/tasks/*.mn; do
  name=$(basename "$f" .mn)
  expect=$(head -1 "$f" | sed 's_^// expect: __')
  err=$("$WT" run "${WT_RUN_FLAGS[@]}" "$M" < "$f" 2>&1 >/dev/null)
  errs=$(printf '%s' "$err" | grep -cE 'E_[A-Za-z]+ error')
  case "$expect" in
    PROVE)
      if [ "$errs" -eq 0 ]; then
        echo "✓ $name (PROVE — zero errors)"; pass=$((pass+1))
      else
        echo "✗ $name (want PROVE, got $errs: $(printf '%s' "$err" | grep -E 'E_' | head -1))"
        fail=$((fail+1))
      fi ;;
    REFUSE\ *)
      klass=${expect#REFUSE }
      hits=$(printf '%s' "$err" | grep -c "$klass")
      spans=$(printf '%s' "$err" | grep "$klass" | grep -cE 'at [0-9]+:[0-9]+')
      if [ "$hits" -ge 1 ]; then
        echo "✓ $name (REFUSE $klass ×$hits, teaching-spans $spans)"; pass=$((pass+1))
      else
        echo "✗ $name (want REFUSE $klass, got: $(printf '%s' "$err" | grep -E 'E_' | head -1))"
        fail=$((fail+1))
      fi ;;
    *)
      echo "✗ $name (unreadable expect line: $expect)"; fail=$((fail+1)) ;;
  esac
done
echo "── absence: $pass pass / $fail fail ──"
[ "$fail" -eq 0 ]
