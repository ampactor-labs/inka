#!/usr/bin/env bash
# tools/verify.sh — the Mentl gate (proto-`mentl check`).
#
# The ULTIMATE .mn source leads; the disposable seed's weaker inference lags
# and catches up ("write the ultimate form, then make it work"). So the gate
# checks the two things that are real under that paradigm:
#   1. the seed builds (it must exist to bootstrap), and
#   2. the micro battery is green — the wheel actually COMPILES AND RUNS
#      correct code. That, plus the drift-audit (the Carried-Truth Law, run by
#      the pre-commit hook), IS the verification: the thing works AND coheres.
# The wheel census (the seed's diagnostic count) is a SHADOW (Morgan): the seed
# lagging the ultimate wheel shows up here as a rising count, which is EXPECTED
# progress — never a reason to refuse the wheel. It is reported, never enforced;
# the old census-ratchet-toward-first-light gate is RETIRED.
#
# Usage: tools/verify.sh
# Exit:  0 thesis holds, 1 thesis violated, 2 invocation error.
set -uo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

BASELINE="tools/verify-baseline.txt"
source "$ROOT/tools/wt-env.sh"   # WT, WT_RUN_FLAGS, W2W — the one home
# The runtime trio IS the standard library — every real .mn program links it, so
# a micro compiled WITHOUT it is the abnormal case, not the default. Link it for
# every micro: a micro that calls str_concat/str_eq (strings) or ev_lookup (the
# keyed-evidence dispatch scan, runtime/memory.mn) gets its def; one that uses
# neither pays nothing (reachability-from-main drops the unused). A micro failing
# only because the stdlib was withheld is the harness lying, not a regression.
RTLIBS=(lib/runtime/memory.mn lib/runtime/strings.mn lib/runtime/lists.mn lib/prelude.mn)

say() { printf '%s\n' "$*"; }
fail=0

[[ -f "$BASELINE" ]] || { say "verify: baseline missing: $BASELINE"; exit 2; }
[[ -x "$WT" ]] || { say "verify: wasmtime not found at $WT (set WASMTIME_BIN)"; exit 2; }

# ── the GREEN STAMP — verify is idempotent on an unchanged tree ─────────────
# The verdict is a pure function of the gate-relevant state (wt_state_key:
# wheel sources + boot + micros + the gate scripts). A green run stamps that
# key; a re-run — above all the pre-commit hook, seconds after a green — answers
# from the stamp instead of re-paying the ~15-minute gate it just watched pass
# (the IC principle: the oracle is incremental computation plus one cached
# value). FORCE_VERIFY=1 re-runs regardless; --from-seed never stamps or reads
# (a different compiler, a different verdict). The flock serializes concurrent
# gates — the second waits, re-checks the stamp, and usually exits instantly.
GATE_DIR=".build/gate"; GATE_STAMP="$GATE_DIR/verify.green"
STATE_KEY=""
if [[ "${1:-}" != "--from-seed" ]]; then
  STATE_KEY=$(wt_state_key)
  if [[ "${FORCE_VERIFY:-0}" != 1 && "$(cat "$GATE_STAMP" 2>/dev/null)" == "$STATE_KEY" ]]; then
    say "verify: cached green — gate state unchanged since the last full run"
    say "        (stamp $GATE_STAMP; FORCE_VERIFY=1 re-runs the battery)"
    exit 0
  fi
  mkdir -p "$GATE_DIR"; exec 8>"$GATE_DIR/lock"; flock 8
  if [[ "${FORCE_VERIFY:-0}" != 1 && "$(cat "$GATE_STAMP" 2>/dev/null)" == "$STATE_KEY" ]]; then
    say "verify: cached green (a concurrent gate finished while this one waited)"
    exit 0
  fi
fi

# 1. The compiler exists. Default: the pinned fixpoint wheel (boot/ —
#    first light 2026-07-10; boot/PROVENANCE.md). --from-seed builds and
#    uses the hand-WAT seed instead (cold-bootstrap archaeology, band J).
BOOT="boot/mentl.wasm"
if [[ "${1:-}" == "--from-seed" ]]; then
  if ! bash bootstrap/build.sh >/tmp/verify_build.log 2>&1; then
    say "✗ seed build FAILED (tail /tmp/verify_build.log):"; tail -3 /tmp/verify_build.log; exit 1
  fi
  say "✓ seed builds"
  BOOT="bootstrap/mentl.wasm"
fi
[[ -f "$BOOT" ]] || { say "verify: compiler missing: $BOOT"; exit 2; }
export MENTL_BOOT="$BOOT"
say "✓ compiler: $BOOT"

# 2. Micro battery — each line `micro:NAME=EXPECTED_EXIT` in the baseline.
while IFS= read -r line; do
  name=${line#micro:}; m=${name%%=*}; want=${name#*=}
  out=$(tools/run-micro.sh "tests/micros/mn-${m}.mn" "$want" "${RTLIBS[@]}" 2>/dev/null | tail -1)
  if [[ "$out" == PASS* ]]; then say "✓ micro $m=$want"; else say "✗ micro $m: ${out:-no output}"; fail=1; fi
done < <(grep -E '^micro:' "$BASELINE")

# 3. Wheel census — a SHADOW, reported not enforced. The ultimate .mn leads;
#    the seed's weaker inference lags, so a rising count is the seed catching
#    up to the wheel, never a reason to refuse it. The seed TRAPPING (no m2 at
#    all) still fails — that is the wheel not compiling, a real signal, not a
#    shadow. Default path reads the ONE keyed boot(wheel) artifact
#    (wt_m2_ensure — shared with march/march-gate, .build/m2cache);
#    --from-seed compiles through the seed directly (a different compiler,
#    never cached against boot's key).
if [[ "$BOOT" == "boot/mentl.wasm" ]]; then
  if C=$(wt_m2_ensure); then
    census=$(grep -cE '(^|: )(E_|W_)' "$C/m2.err")   # the wheel prefixes stages ('infer: E_…')
    say "· census $census (the compiler's own diagnostic count on the wheel; artifact $C, shared with march/march-gate)"
  else
    say "✗ compiler TRAPPED compiling the wheel (tail $WT_M2CACHE/m2.err):"; tail -3 "$WT_M2CACHE/m2.err"; fail=1
  fi
else
  { find src -name '*.mn' | sort | xargs cat; \
    find lib -name '*.mn' -not -path '*/tutorial/*' | sort | xargs cat; } > /tmp/verify_wheel.mn
  if wt_run "$BOOT" < /tmp/verify_wheel.mn \
        > /tmp/verify_m2.wat 2>/tmp/verify_m2.err; then
    census=$(grep -cE '(^|: )(E_|W_)' /tmp/verify_m2.err)
    say "· census $census (the compiler's own diagnostic count on the wheel; informational)"
  else
    say "✗ compiler TRAPPED compiling the wheel (tail /tmp/verify_m2.err):"; tail -3 /tmp/verify_m2.err; fail=1
  fi
fi

if [[ "$fail" -ne 0 ]]; then
  say ""
  say "verify: the gate failed — the wheel does not compile-and-run (a micro"
  say "regressed, or the seed trapped). That is the thing not working, not the"
  say "seed's shadow. Fix it (carry the handle, read live; rewrite in residue form)."
  exit 1
fi
say "verify: thesis invariants hold."
# Stamp the green — keyed on the state captured at ENTRY, so an edit made
# while the battery ran invalidates (the next run sees a different key).
if [[ -n "$STATE_KEY" ]]; then
  printf '%s' "$STATE_KEY" > "$GATE_STAMP"
  say "· stamped $GATE_STAMP (re-runs on this exact state answer instantly)"
fi
exit 0
