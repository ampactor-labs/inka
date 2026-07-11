#!/usr/bin/env bash
# tools/verify.sh — the Mentl gate (proto-`mentl check`).
#
# Boot-era gate: the micro battery compiles-and-runs green through the pinned
# fixpoint wheel (boot/mentl.wasm), plus the census (the compiler's own
# diagnostic count on the wheel — reported, never enforced). Green is STAMPED
# on wt_state_key, so re-runs on an unchanged tree (above all the pre-commit
# hook) answer instantly; FORCE_VERIFY=1 re-runs the battery.
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
# value). FORCE_VERIFY=1 re-runs regardless. The flock serializes concurrent
# gates — the second waits, re-checks the stamp, and usually exits instantly.
GATE_DIR=".build/gate"; GATE_STAMP="$GATE_DIR/verify.green"
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

# 1. The compiler exists: the pinned fixpoint wheel (boot/ — first light
#    2026-07-10; boot/PROVENANCE.md). The hand-WAT seed is DELETED (7401c4b);
#    the cold-ladder recipe lives at tag first-light (band J archaeology).
BOOT="boot/mentl.wasm"
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
#    shadow. Reads the ONE keyed boot(wheel) artifact (wt_m2_ensure —
#    shared with march/march-gate, .build/m2cache).
if C=$(wt_m2_ensure); then
  census=$(grep -cE '(^|: )(E_|W_)' "$C/m2.err")   # the wheel prefixes stages ('infer: E_…')
  say "· census $census (the compiler's own diagnostic count on the wheel; artifact $C, shared with march/march-gate)"
else
  say "✗ compiler TRAPPED compiling the wheel (tail $WT_M2CACHE/m2.err):"; tail -3 "$WT_M2CACHE/m2.err"; fail=1
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
printf '%s' "$STATE_KEY" > "$GATE_STAMP"
say "· stamped $GATE_STAMP (re-runs on this exact state answer instantly)"
exit 0
