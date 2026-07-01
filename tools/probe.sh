#!/usr/bin/env bash
# tools/probe.sh — the ONE ad-hoc investigation front-end (WABT + seed).
#
# march.sh runs the full seed→m2→m3 gate. probe.sh answers the SURGICAL
# questions that gate raises — "what did the seed emit for function F?", "what
# offset did local L's field read resolve to?", "does input ordering X change
# the emit?" — with the canonical toolchain flags baked in (wt-env.sh), so the
# hand-rolled `wasm-objdump | sed` / `wasmtime run -W …` invocations (and their
# flag-split footguns) have exactly one correct form.
#
#   bash tools/probe.sh m2 [src|lib …]      build m2 from an input ordering
#                                           (default: src lib — the canonical
#                                           build order). Writes $OUT/m2.{wat,wasm}.
#   bash tools/probe.sh func <fn>           WABT disasm of ONE function in the
#                                           last-built m2.wasm.
#   bash tools/probe.sh offsets <fn> <loc>  field-load offsets of local <loc>
#                                           inside <fn> (record-layout probe).
#   bash tools/probe.sh grep <regex>        every emitted-WAT line matching regex.
#
# Artifacts land in $OUT (default .build/probe, luks-backed — never /tmp).
set -u
cd "$(dirname "$0")/.." || exit 2
source "$(dirname "$0")/wt-env.sh"
OUT="${PROBE_OUT:-$(pwd)/.build/probe}"; mkdir -p "$OUT"
export TMPDIR="$OUT"

m2() {
  local parts=("${@:-}"); [ "${#parts[@]}" -eq 0 -o -z "${parts[0]}" ] && parts=(src lib)
  wt_wheel "${parts[@]}" > "$OUT/wheel.mn" || exit 2
  echo "wheel: $(wc -l < "$OUT/wheel.mn") lines  (order: ${parts[*]})"
  wt_run bootstrap/mentl.wasm < "$OUT/wheel.mn" > "$OUT/m2.wat" 2> "$OUT/m2.err"
  local rc=$?
  echo "m2: exit=$rc, $(wc -l < "$OUT/m2.wat") lines"
  [ "$rc" = 0 ] || { echo "✗ seed trapped:"; tail -3 "$OUT/m2.err"; exit 1; }
  wt_asm "$OUT/m2.wat" "$OUT/m2.wasm" 2> "$OUT/m2w.err" \
    && echo "✓ m2.wasm ($(stat -c%s "$OUT/m2.wasm") bytes)" \
    || { echo "✗ wat2wasm:"; head -5 "$OUT/m2w.err"; exit 1; }
}

case "${1:-}" in
  m2)      shift; m2 "$@" ;;
  func)    wt_func "$OUT/m2.wasm" "$2" ;;
  offsets) wt_offsets "$OUT/m2.wat" "$2" "$3" ;;
  grep)    grep -n "$2" "$OUT/m2.wat" ;;
  *) sed -n '2,/^set -u/p' "$0" | sed 's/^# \?//;/^set -u/d'; exit 2 ;;
esac
