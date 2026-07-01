#!/usr/bin/env bash
# faithful.sh — DIFFERENTIAL seed↔mentl2 probe. The proto-form of
# `mentl verify`: does the SELF-HOSTED compiler (mentl2 = seed-compiled
# wheel) agree with the SEED on this input? A divergence — or a mentl2
# trap where the seed is fine — IS a faithfulness gap = an L1 blocker,
# surfaced on a TINY input instead of bisecting 14k lines of wheel by eye
# (the `[T]` parser gap was found exactly this way, by hand; this makes it
# one command). Dissolves at first-light: when mentl2 == mentl3 the answer
# is trivially "faithful," and this scaffold folds into `mentl verify`.
#
# Usage:
#   tools/faithful.sh tests/micros/mn-refine.mn   # probe one construct
#   echo 'type X = [Int]' | tools/faithful.sh     # probe stdin
#   tools/faithful.sh --bisect                     # ddmin the full wheel
#                                                  # to the minimal failing slice
#   tools/faithful.sh --wheel                      # probe the whole wheel
#
# mentl2 is CACHED in $MENTL_BUILD/.build and rebuilt only when a wheel
# source is newer — so repeated probes are fast (no 2 GiB recompile per run).
set -u
cd "$(dirname "$0")/.." || exit 1
B="${MENTL_BUILD:-$PWD/.build}"; mkdir -p "$B"; export TMPDIR="$B"
source "$(dirname "$0")/wt-env.sh"   # wt_run, wt_asm, wt_wheel — the one home

wheel_cat() { wt_wheel src lib; }

ensure_mentl2() {
  # Rebuild only if a wheel source out-dates the cached binary (or it's absent).
  if [ -f "$B/mentl2.wasm" ] && [ -z "$(find src lib bootstrap/src \( -name '*.mn' -o -name '*.wat' \) -newer "$B/mentl2.wasm" 2>/dev/null | head -1)" ]; then
    return 0
  fi
  echo "▸ (re)building mentl2 — wheel changed…" >&2
  bash bootstrap/build.sh >/dev/null 2>&1 || { echo "✗ seed build failed" >&2; exit 1; }
  wheel_cat > "$B/wheel.mn"
  wt_run bootstrap/mentl.wasm < "$B/wheel.mn" > "$B/m2.wat" 2>/dev/null
  wt_asm "$B/m2.wat" "$B/mentl2.wasm" 2>/dev/null \
    || { echo "✗ mentl2 failed to assemble (the seed mis-compiled the wheel)" >&2; exit 1; }
}

# probe FILE [--wheel] — run both compilers, classify.  Returns 0 = faithful.
# A mentl2 TRAP where the seed is fine is ALWAYS a gap. Output divergence is a
# gap ONLY for the wheel (where first-light demands byte-identity); for an
# arbitrary construct the seed is a bootstrap approximation and emit-formatting
# legitimately differs — so divergence there is informational, not a failure.
probe() {
  local in="$1" mode="${2:-construct}"
  wt_run bootstrap/mentl.wasm < "$in" > "$B/seed.out" 2>"$B/seed.err"; local se=$?
  wt_run "$B/mentl2.wasm"      < "$in" > "$B/m2.out"   2>"$B/m2.err";   local me=$?
  local sd md; sd=$(grep -cE '^[EPW]_' "$B/seed.err" 2>/dev/null); md=$(grep -cE '^[EPW]_' "$B/m2.err" 2>/dev/null)
  printf '  seed   exit=%-3s diag=%-4s wat=%s\n' "$se" "$sd" "$(wc -l < "$B/seed.out")"
  printf '  mentl2 exit=%-3s diag=%-4s wat=%s\n' "$me" "$md" "$(wc -l < "$B/m2.out")"
  if [ "$se" -eq 0 ] && [ "$me" -ne 0 ]; then
    echo "  ✗ FAITHFULNESS GAP — seed OK, mentl2 FAILS:"
    grep -iE 'trap|memory fault|unreachable|^P_|^E_' "$B/m2.err" | head -4 | sed 's/^/      /'
    return 1
  elif [ "$se" -ne 0 ]; then
    echo "  · seed itself errors on this input — not a faithfulness question"; return 0
  elif diff -q "$B/seed.out" "$B/m2.out" >/dev/null 2>&1; then
    echo "  ✓ FAITHFUL (byte-identical output)"; return 0
  elif [ "$mode" = "wheel" ]; then
    echo "  ✗ FIRST-LIGHT GAP — wheel output diverges ($(diff "$B/seed.out" "$B/m2.out" | grep -c '^[<>]') lines):"
    diff "$B/seed.out" "$B/m2.out" | grep '^[<>]' | head -4 | sed 's/^/      /'
    return 1
  else
    echo "  ✓ both compile; output differs (expected — seed is a pre-L1 approximation, not byte-canonical for constructs)"
    return 0
  fi
}

ensure_mentl2

case "${1:-}" in
  --wheel)  wheel_cat > "$B/probe_in.mn"; echo "▸ probe: full wheel";        probe "$B/probe_in.mn" wheel ;;
  --bisect)
    # ddmin by FILE: drop wheel files one at a time, keep the set that still
    # fails on mentl2 — converges to the minimal failing file-set. (Line-level
    # ddmin is the next rung; file-level already localizes the gap fast.)
    wheel_cat > "$B/probe_in.mn"
    if probe "$B/probe_in.mn" >/dev/null 2>&1; then echo "wheel is faithful — nothing to bisect"; exit 0; fi
    files=$(find src -name '*.mn' | sort; find lib -name '*.mn' -not -path '*/tutorial/*' | sort)
    keep=$files
    for f in $files; do
      cand=$(printf '%s\n' $keep | grep -v "^$f$")
      printf '%s\n' $cand | xargs cat > "$B/probe_in.mn" 2>/dev/null
      wt_run "$B/mentl2.wasm" < "$B/probe_in.mn" >/dev/null 2>"$B/m2.err"
      if [ $? -ne 0 ]; then keep=$cand; echo "  drop $f — still fails (minimizing)"; fi
    done
    echo "▸ minimal failing file-set:"; printf '%s\n' $keep | sed 's/^/    /'
    ;;
  ""|--help) sed -n '2,18p' "$0" | sed 's/^# \?//' ;;
  *)        echo "▸ probe: $1"; probe "$1" ;;
esac
