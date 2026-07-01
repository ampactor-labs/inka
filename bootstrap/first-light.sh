#!/bin/bash
# first-light.sh -- WABT-backed seed compiler proof harness.
#
# Current gate: the hand-WAT seed assembles and validates, then projects
# tiny Mentl programs into WAT that also assemble, validate, inspect, and run.

set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"
source tools/wt-env.sh   # WT, WT_RUN_FLAGS, W2W, wt_validate — the one home

WAT="bootstrap/mentl.wat"
WASM="bootstrap/mentl.wasm"
TMP_ROOT="${TMPDIR:-/tmp}"
WORKDIR="$(mktemp -d "$TMP_ROOT/mentl-first-light.XXXXXX")"
trap 'rm -rf "$WORKDIR"' EXIT

require_tool() {
  if ! command -v "$1" >/dev/null 2>&1; then
    echo "missing required tool: $1" >&2
    exit 1
  fi
}

assert_contains() {
  local file="$1"
  local needle="$2"
  local label="$3"

  if grep -Fq -- "$needle" "$file"; then
    echo "       ok: $label"
    return
  fi

  echo "       missing: $label" >&2
  echo "       expected substring: $needle" >&2
  echo "       in: $file" >&2
  echo "------- tail($file) -------" >&2
  tail -40 "$file" >&2 || true
  echo "---------------------------" >&2
  exit 1
}

compile_sample() {
  local name="$1"
  local source="$2"
  local out_wat="$WORKDIR/$name.wat"
  local out_wasm="$WORKDIR/$name.wasm"
  local sections="$WORKDIR/$name.sections"
  local disasm="$WORKDIR/$name.disasm"

  printf "%s" "$source" | wt_run "$WASM" > "$out_wat"
  wt_asm "$out_wat" "$out_wasm"
  wt_validate "$out_wasm"
  wasm-objdump -x "$out_wasm" > "$sections"
  wasm-objdump -d "$out_wasm" > "$disasm"
  # Compiled program's exit code IS its `main()` return value (proc_exit).
  # Don't let set -e mistake a non-zero exit for a compile failure.
  wt_run "$out_wasm" >/dev/null || true

  printf "%s|%s|%s|%s\n" "$out_wat" "$out_wasm" "$sections" "$disasm"
}

echo "=== Mentl Bootstrap: first-light WABT gate ==="

echo "[0/7] Checking toolchain..."
require_tool wat2wasm
require_tool wasm-validate
require_tool wasm-objdump
require_tool wasmtime
echo "       ok: WABT + wasmtime available"

echo "[1/7] Assembling seed WAT with wat2wasm..."
wt_asm "$WAT" "$WASM"
echo "       ok: built $WASM ($(wc -c < "$WASM") bytes)"

echo "[2/7] Validating seed WASM..."
wt_validate "$WASM"
echo "       ok: wasm-validate accepted seed"

echo "[3/7] Inspecting seed sections with wasm-objdump..."
SEED_SECTIONS="$WORKDIR/seed.sections"
wasm-objdump -x "$WASM" > "$SEED_SECTIONS"
assert_contains "$SEED_SECTIONS" '<mentl_emit>' "seed exports/keeps mentl_emit"
assert_contains "$SEED_SECTIONS" '-> "_start"' "seed exports _start"
assert_contains "$SEED_SECTIONS" '<emit_start_section_static>' "static start projection present"

echo "[4/7] Projecting executable zero-arg main..."
IFS='|' read -r ZERO_WAT ZERO_WASM ZERO_SECTIONS ZERO_DISASM \
  < <(compile_sample "zero" $'fn main() = 42\n')
assert_contains "$ZERO_WAT" '(global.get $main)' "generated _start loads static main closure"
assert_contains "$ZERO_WAT" '(call_indirect (type $ft1))' "generated _start invokes zero-arg main through W7"
assert_contains "$ZERO_DISASM" 'call_indirect 0 <fns> (type 1 <ft1>)' "compiled _start keeps typed closure invocation"

echo "[5/7] Projecting one-arg main module..."
IFS='|' read -r ONE_WAT ONE_WASM ONE_SECTIONS ONE_DISASM \
  < <(compile_sample "one" $'fn main(x) = x\n')
assert_contains "$ONE_WAT" '(type $ft2 (func (param i32) (param i32) (result i32)))' "generated type ladder reaches arity 1 user fn"
assert_contains "$ONE_WAT" '(global $main i32 (i32.const 256))' "main has a static closure global"
assert_contains "$ONE_SECTIONS" 'Table[1]:' "generated module has function table"
assert_contains "$ONE_SECTIONS" '<main>' "generated module names main"

echo "[6/7] Projecting two-function call program..."
IFS='|' read -r TWO_WAT TWO_WASM TWO_SECTIONS TWO_DISASM \
  < <(compile_sample "two" $'fn id(x) = x\nfn main(y) = id(y)\n')
assert_contains "$TWO_WAT" '(global.get $id)' "top-level function reference lowers to global closure"
assert_contains "$TWO_WAT" '(call_indirect (type $ft2))' "call lowers through typed call_indirect"
assert_contains "$TWO_SECTIONS" 'table[0] type=funcref initial=2 <fns>' "function table contains both functions"
assert_contains "$TWO_SECTIONS" 'Data[2]:' "static closure records are materialized"
assert_contains "$TWO_DISASM" 'global.get 3 <id>' "compiled body loads id closure global"
assert_contains "$TWO_DISASM" 'call_indirect 0 <fns> (type 2 <ft2>)' "compiled body keeps typed indirect call"

echo "[7/8] Summary..."
echo "       seed: $(wc -l < "$WAT") WAT lines, $(wc -c < "$WASM") WASM bytes"
echo "       zero: $(wc -l < "$ZERO_WAT") generated WAT lines"
echo "       one:  $(wc -l < "$ONE_WAT") generated WAT lines"
echo "       two:  $(wc -l < "$TWO_WAT") generated WAT lines"

echo "[8/8] L1 fixpoint probe..."
# Per H.4 Hβ.first-light.fixpoint-harness (PLAN-to-first-light.md §3 + §6):
# the seed compiles the wheel — and if the seed-produced compiler is
# byte-identical when re-applied to the wheel, L1 has closed. Until
# that holds, the probe surfaces the empirical state (wheel-fn count,
# NFre count, fixpoint diff size) so closures register as visible
# progress per the plan's §4 ritual closure check.
L1_INPUT="$WORKDIR/l1-input.mn"
L1_OUT_2="$WORKDIR/l1-pass2.wat"
L1_OUT_3="$WORKDIR/l1-pass3.wat"
L1_ERR_2="$WORKDIR/l1-pass2.err"
L1_ERR_3="$WORKDIR/l1-pass3.err"
L1_WASM_2="$WORKDIR/l1-pass2.wasm"
L1_STATUS=0
L1_STATUS_MSG="not yet probed"

# Concatenate the wheel in canonical order (src then lib, same as
# CLAUDE.md operational essentials). Exclude lib/tutorial/ — tutorials
# are demo programs (each has its own `fn main`), compiled by
# `mentl run lib/tutorial/X.mn` as separate executables, NOT part of
# the self-compile wheel substrate.
{ find src -name '*.mn' -type f | sort | xargs cat
  find lib -name '*.mn' -type f -not -path '*/tutorial/*' | sort | xargs cat
} > "$L1_INPUT"

# Pass 2: seed → wheel → mentl2.wat
wt_run "$WASM" < "$L1_INPUT" > "$L1_OUT_2" 2> "$L1_ERR_2" || true
PASS2_FNS=$(grep -c "^  (func " "$L1_OUT_2" || true)
PASS2_LINES=$(wc -l < "$L1_OUT_2")
PASS2_NFRE=$(tr -d '\0' < "$L1_ERR_2" | grep -c "E_UnresolvedType" || true)

echo "       pass2: $PASS2_FNS funcs, $PASS2_LINES lines, $PASS2_NFRE NFre diagnostics"

# If pass-2 output is a stub (only scaffolding $heap_base + $_start
# from the seed prelude), the wheel hasn't sufficiently emerged for
# pass-3 to be meaningful — surface state and exit success on the
# WABT-gate checks alone. Closure of L1 registers when this branch
# falls through to the fixpoint diff.
if [ "$PASS2_FNS" -le "2" ]; then
  echo "       L1 not yet ready — pass-2 emits only seed scaffolding (need more wheel-fn surface)"
  echo "       NFre diagnostics: $PASS2_NFRE (target 0); fn count: $PASS2_FNS (target ≥ dozens)"
  echo "       This is the cursor — Phase H handles narrow toward L1 closure per PLAN-to-first-light.md §5."
  L1_STATUS_MSG="not ready — pass-2 emits only seed scaffolding"
else
  # Pass 2 produced real wheel output. Compile it and run pass 3.
  if ! wt_asm "$L1_OUT_2" "$L1_WASM_2" 2>/dev/null; then
    echo "       pass-2 WAT failed wat2wasm — wheel substrate produced invalid WASM"
    L1_STATUS=1
    L1_STATUS_MSG="not closed — pass-2 WAT failed wat2wasm"
  elif ! wt_validate "$L1_WASM_2"; then
    echo "       pass-2 WASM failed wasm-validate — runtime correctness gap"
    L1_STATUS=1
    L1_STATUS_MSG="not closed — pass-2 WASM failed validation"
  else
    # Pass 3: pass-2.wasm → wheel → mentl3.wat. Keep stderr: when pass-3
    # collapses to 0 funcs, parser diagnostics are the active evidence.
    wt_run "$L1_WASM_2" < "$L1_INPUT" > "$L1_OUT_3" 2> "$L1_ERR_3" || true
    PASS3_FNS=$(grep -c "^  (func " "$L1_OUT_3" || true)
    PASS3_LINES=$(wc -l < "$L1_OUT_3")
    PASS3_PARSE_ERRORS=$(tr -d '\0' < "$L1_ERR_3" | grep -c "P_" || true)
    echo "       pass3: $PASS3_FNS funcs, $PASS3_LINES lines, $PASS3_PARSE_ERRORS parser diagnostics"

    if [ "$PASS3_PARSE_ERRORS" -gt "0" ]; then
      echo "       pass3 stderr tail:"
      tr -d '\0' < "$L1_ERR_3" | tail -12 | sed 's/^/         /'
    fi

    if diff -q "$L1_OUT_2" "$L1_OUT_3" >/dev/null; then
      echo "       L1 FIXPOINT CLOSED — pass-2 ≡ pass-3 byte-identical."
      echo "       The medium has folded into its seed. Tier 3 begins."
      L1_STATUS_MSG="closed — pass-2 and pass-3 byte-identical"
    else
      DIFF_LINES=$(diff "$L1_OUT_2" "$L1_OUT_3" | wc -l)
      echo "       L1 fixpoint NOT closed — diff size: $DIFF_LINES lines."
      echo "       Pass-3 differs from pass-2; investigate parser/runtime correctness,"
      echo "       emit determinism, or inference-order divergence per PLAN-to-first-light.md §6.2."
      L1_STATUS=1
      L1_STATUS_MSG="not closed — pass-2/pass-3 differ"
    fi
  fi
fi

echo ""
echo "=== WABT gate: PASS; L1: $L1_STATUS_MSG ==="
exit "$L1_STATUS"
