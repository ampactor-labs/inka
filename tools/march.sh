#!/usr/bin/env bash
# ═══ Mentl first-light march — the binary-arbiter gate in ONE command ════════
# seed → m2 → m3 (→ m4), with structured trap / probe / nstate reporting, so a
# diagnostic cycle is a single invocation instead of a hand-typed pipeline.
# Bootstrap-layer tool — dissolves at first-light (the wheel becomes its own
# oracle). Pairs with tools/verify.sh (micros + drift-audit, the Law-7 guard).
#
#   bash tools/march.sh             # build seed → m2 → m3, report the trap gate
#   bash tools/march.sh --no-build  # reuse bootstrap/mentl.wasm (skip the ~3min build)
#   bash tools/march.sh --fixpoint  # also m3 → m4 + diff (the m3==m4 first-light gate)
#   PROBE=35866 bash tools/march.sh # surface the per-handle seed eprint probe line
#
# Artifacts land in .build/march (luks-backed, per PLAN §8), NEVER /tmp — /tmp is
# RAM-backed tmpfs here, and a 50MB objdump + 12MB m2.wat × repeated runs OOMs the
# box (it did, 2026-06-30). .build is on disk; override with MARCH_OUT=<dir>.
set -u
cd "$(dirname "$0")/.." || exit 2
source "$(dirname "$0")/wt-env.sh"   # WT, WT_RUN_FLAGS, W2W — the one home
OUT="${MARCH_OUT:-$(pwd)/.build/march}"; mkdir -p "$OUT"
WHEEL="$OUT/wheel.mn"
BUILD=1; FIXPOINT=0
for a in "$@"; do case "$a" in
  --no-build) BUILD=0 ;;
  --fixpoint) FIXPOINT=1 ;;
  *) echo "march: unknown arg '$a'" >&2; exit 2 ;;
esac; done

# trap signatures: a wasmtime runtime trap OR a name-section frame of the known
# trap site. Empty match = the gate is GREEN.
trap_lines() { grep -nE 'out of bounds|wasm trap|undefined element|unreachable|op_each_handler_yield' "$1" 2>/dev/null; }
# timeout execs a real binary (not the wt_run function), so it uses the same
# constants wt_run projects from — WT + WT_RUN_FLAGS, the one home (wt-env.sh).
# 9000s: pass-2 measured ~2h-class on the seed-idiom m2 (2026-07-05 —
# ~300 wheel-lines/min, ~19MB/min; the profile is Hβ.m2.compile-alloc-profile,
# instantiate tree-clones the prime suspect). The old 480s cap predates the
# union_row-divergence fix, when every long run meant the infinite loop.
gen() { timeout 9000 "$WT" run "${WT_RUN_FLAGS[@]}" "$1" < "$WHEEL" > "$2" 2> "$3"; }  # gen <wasm> <out.wat> <out.err>

# WABT disassembly, cached on the wasm's mtime (objdump on 1.7MB is slow; the
# 500k-line dump is reused across runs until m2.wasm is rebuilt). PLAN §8: pin the
# trap with the binary toolkit, NEVER grep the minified emit.
disasm() {  # disasm <in.wasm> → echoes the cached .dis path
  local w="$1" d="${1%.wasm}.dis"
  [ -f "$d" ] && [ "$d" -nt "$w" ] || wasm-objdump -d "$w" > "$d" 2>/dev/null
  echo "$d"
}
pin_trap() {  # pin_trap <wasm> <err> — auto-disassemble the trap site from the backtrace
  local w="$1" e="$2" fn dis
  fn=$(grep -oE '<unknown>!\S+' "$e" 2>/dev/null | head -1 | sed 's/.*!//')
  [ -z "$fn" ] && fn=$(grep -oE 'op_[a-z_]+' "$e" 2>/dev/null | head -1)
  [ -z "$fn" ] && { echo "  (no named trap frame to pin)"; return; }
  dis=$(disasm "$w")
  echo "  ── WABT trap pin: <$fn> around its call_indirect ──"
  awk -v fn="<$fn>:" '
    index($0,fn){p=1}
    p{n++; print "    " $0}
    p && /call_indirect/{c++}
    p && c>=1 && n>4{exit}
    p && n>34{exit}' "$dis" | grep -E 'load|store|local|global|call|func\[' | head -18
}

# ── wheel input: `find`, NOT `cat src/*.mn` (PLAN §6 — cat omits backends/) ──
{ find src -name '*.mn' | sort | xargs cat
  find lib -name '*.mn' -not -path '*/tutorial/*' | sort | xargs cat; } > "$WHEEL"
echo "wheel: $(wc -l < "$WHEEL") lines"

if [ "$BUILD" = 1 ]; then
  if bash bootstrap/build.sh > "$OUT/seedbuild.log" 2>&1; then
    echo "✓ seed build ($(grep -oE 'mentl.wasm \([0-9]+ bytes\)' "$OUT/seedbuild.log" | tail -1))"
  else echo "✗ seed build FAILED:"; tail -15 "$OUT/seedbuild.log"; exit 1; fi
fi

# ── m2: seed compiles the wheel (the load-bearing emit — m2 is seed-output) ──
gen bootstrap/mentl.wasm "$OUT/m2.wat" "$OUT/m2.err"; m2rc=$?
echo "m2: exit=$m2rc, $(wc -l < "$OUT/m2.wat" 2>/dev/null) lines"
if [ "$m2rc" != 0 ]; then echo "✗ m2 generation TRAPPED:"; trap_lines "$OUT/m2.err" | head -6; exit 1; fi
if ! "${W2W[@]}" "$OUT/m2.wat" -o "$OUT/m2.wasm" 2> "$OUT/m2w.err"; then
  echo "✗ m2 wat2wasm FAILED:"; head -8 "$OUT/m2w.err"; exit 1; fi
echo "✓ m2 assembles ($(stat -c%s "$OUT/m2.wasm") bytes)"

# seed eprint probes land in m2.err during m2 generation (bare-integer lines)
PROBE_OUT=$(grep -xE '[0-9]+' "$OUT/m2.err" 2>/dev/null | head)
[ -n "$PROBE_OUT" ] && echo "  probe lines: $(echo "$PROBE_OUT" | tr '\n' ' ')"
if [ -n "${PROBE:-}" ]; then
  # closure record = [fn_ptr@0][nc@4][caps..][evs..], alloc = 8 + 4*(nc+ne).
  SZ=$(grep -oE "\(i32.const ([0-9]+)\)\(i32.add\)\(global.set \\\$heap_ptr\)\(local.get \\\$state_tmp\)\(global.get \\\$${PROBE}_idx\)" "$OUT/m2.wat" | grep -oE 'const [0-9]+' | grep -oE '[0-9]+' | head -1)
  NC=$(grep -oE "${PROBE}_idx\)\(i32.store offset=0\)\(local.get \\\$state_tmp\)\(i32.const [0-9]+\)" "$OUT/m2.wat" | grep -oE 'const [0-9]+' | grep -oE '[0-9]+' | head -1)
  if [ -n "$SZ" ]; then echo "  ${PROBE} closure: ${SZ}B frame, nc=${NC} caps, ne=$(( (SZ-8)/4 - ${NC:-0} )) evs"
  else echo "  ${PROBE} closure: <not found in m2.wat>"; fi
fi

# ── m3: m2 compiles the wheel — THE GATE (the trapping lambda executes here) ──
gen "$OUT/m2.wasm" "$OUT/m3.wat" "$OUT/m3.err"; m3rc=$?
echo "m3: exit=$m3rc, $(wc -l < "$OUT/m3.wat" 2>/dev/null) lines"
TRAP=$(trap_lines "$OUT/m3.err")
if [ -n "$TRAP" ]; then
  echo "✗ GATE: m3 TRAPPED —"; echo "$TRAP" | head -4
  pin_trap "$OUT/m2.wasm" "$OUT/m3.err"
else
  echo "✓ GATE: m3 clean (no trap)"
fi

# ── m3 == m4 fixed point (first-light's correctness-paired half) ──
if [ "$FIXPOINT" = 1 ] && [ "$m3rc" = 0 ]; then
  if "${W2W[@]}" "$OUT/m3.wat" -o "$OUT/m3.wasm" 2>/dev/null; then
    gen "$OUT/m3.wasm" "$OUT/m4.wat" "$OUT/m4.err"; m4rc=$?
    if [ "$m4rc" = 0 ] && diff -q "$OUT/m3.wat" "$OUT/m4.wat" >/dev/null 2>&1; then
      echo "✓✓ FIRST LIGHT: m3 == m4 (fixed point)"
    else
      echo "· m3 ≠ m4 ($(diff "$OUT/m3.wat" "$OUT/m4.wat" 2>/dev/null | grep -c '^[<>]') diff lines; m4 exit=$m4rc)"
    fi
  fi
fi
[ -z "$TRAP" ] && [ "$m3rc" = 0 ]
