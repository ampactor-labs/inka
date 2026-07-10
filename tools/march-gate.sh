#!/usr/bin/env bash
# march-gate.sh — the m2 first-light march's ONE command.
#
# The pass-2 road is walked in rungs: m2 (the seed-compiled wheel) must
# compile ever-larger inputs END-TO-END (compile → assemble → run → correct
# exit). Each rung that regresses names the dig site; each rung that clears
# extends the road. This script IS the battery this march has been running
# by hand since 2026-07-01 — one invocation, one scoreboard, zero re-derived
# probe incantations.
#
#   bash tools/march-gate.sh                     # build seed + m2, run all rungs
#   bash tools/march-gate.sh --no-build          # reuse .build/probe/m2.wasm
#   bash tools/march-gate.sh --micros            # rungs, THEN the full micro
#                                                 # battery compiled through m2
#   bash tools/march-gate.sh --no-build --micros # reuse m2.wasm, rungs + micros
#
# The --micros tier promotes every tests/micros/mn-NAME.mn carrying a
# `micro:NAME=EXIT` line in tools/verify-baseline.txt from "the SEED compiles
# and runs it" (verify.sh's claim) to "m2 — the WHEEL, compiled BY the seed —
# compiles and runs it" (a strictly stronger claim: m2 is the wheel's own
# emit, seed-sparked). It is a SCOREBOARD, not a gate: a ✗ here names a dig
# site for the next session, never a wheel bug to chase inline (CLAUDE.md ⟲
# — census, don't chase moles). Same RT link set as the +rt rungs
# (memory+strings+lists+prelude) for every micro — m2 has reachability-from-
# main, so an unused stdlib fn drops silently; withholding it would be the
# harness lying, not a regression (verify.sh's own reasoning, carried here).
#
# Reading a FAIL:
#   compile-trap → wasmtime backtrace names the m2 fn; binary-patch probe it
#     (see memory handoff: patch .build/probe/m2.wat, print via
#     `call $eprint_string (i32.const 0) s` / `call $int_to_str (i32.const 0) n`,
#     separator = a REAL interned string const — offsets shift per build).
#   assemble-fail → the wheel's EMIT is wrong (undeclared local / missing
#     $ftN / bad WAT) — fix src/backends/wasm.mn, mirror the seed if shared.
#   run-wrong-exit → a silent miscompile — the worst class; bisect the rung's
#     source, then WABT-diff the emitted fn (wasm-objdump -d, wt_func).
#
# Dissolves at first-light (m3 == m4 makes this script the fixpoint's tail).
set -u
cd "$(dirname "$0")/.." || exit 2
source "$(dirname "$0")/wt-env.sh"
OUT="${PROBE_OUT:-$(pwd)/.build/probe}"; mkdir -p "$OUT"
export TMPDIR="$OUT"
G="$OUT/gate"; mkdir -p "$G"

DO_BUILD=1
DO_MICROS=0
for a in "$@"; do
  case "$a" in
    --no-build) DO_BUILD=0 ;;
    --micros)   DO_MICROS=1 ;;
    *) echo "march-gate: unknown flag '$a' (want --no-build / --micros)" >&2; exit 2 ;;
  esac
done

if [ "$DO_BUILD" = 1 ]; then
  if [ "${FROM_SEED:-0}" = 1 ]; then
    echo "── seed ──"
    bash bootstrap/build.sh >/dev/null 2>&1 || { echo "✗ seed build FAILED"; exit 1; }
    echo "── m2 (seed compiles the wheel) ──"
    bash tools/probe.sh m2 | tail -2 || exit 1
  else
    # Post-first-light default: m2 := boot(wheel) — the pinned fixpoint
    # wheel compiles the wheel (boot/PROVENANCE.md), so every rung and
    # micro below runs through a WHEEL-emitted compiler. FROM_SEED=1
    # restores the seed-sparked path (band J archaeology).
    echo "── m2 (boot — the pinned fixpoint wheel — compiles the wheel) ──"
    { find src -name '*.mn' | sort | xargs cat
      find lib -name '*.mn' -not -path '*/tutorial/*' | sort | xargs cat; } > "$OUT/wheel.mn"
    "$WT" run "${WT_RUN_FLAGS[@]}" boot/mentl.wasm < "$OUT/wheel.mn" > "$OUT/m2.wat" 2> "$OUT/m2.err"
    rc=$?
    echo "m2: exit=$rc, $(wc -l < "$OUT/m2.wat" 2>/dev/null) lines"
    [ "$rc" = 0 ] || { echo "✗ m2 generation TRAPPED"; exit 1; }
    "${W2W[@]}" "$OUT/m2.wat" -o "$OUT/m2.wasm" 2> "$OUT/m2w.err" || { echo "✗ m2 wat2wasm FAILED"; head -5 "$OUT/m2w.err"; exit 1; }
    echo "✓ m2.wasm ($(stat -c%s "$OUT/m2.wasm") bytes)"
  fi
fi
[ -f "$OUT/m2.wasm" ] || { echo "✗ no m2.wasm — run without --no-build"; exit 1; }
# GATE_WASM: the compiler-under-test. Default m2 (seed-sparked wheel); point it
# at an assembled m3 to run the SAME rung+micro battery through the wheel's own
# child — the phase-3 correctness half (a buggy compiler self-reproduces to a
# WRONG fixpoint, so diff-empty alone proves nothing; PLAN §6).
GATE_WASM="${GATE_WASM:-$OUT/m2.wasm}"

# Ratchet (2026-07-04): the h=0 concat class is CLOSED — the str_concat-on-lists
# root (union_row's match binders) died with the seed's ctor-payload proof
# channel (b73748c). A proof-less list-`++` reappearing is a NEW silent-
# miscompile site; fail loud here, never let it rejoin the string default.
H0=$(grep -c 'W_ConcatUnproven h=0' "$OUT/m2.err" 2>/dev/null)
if [ "${H0:-0}" != "0" ]; then
  echo "✗ RATCHET: W_ConcatUnproven h=0 count=$H0 (must be 0 — a binder ++ lost its List/String proof)"
  exit 1
fi

# The trio + prelude: strings.mn's parse_int_base calls prelude's
# parse_int, so the honest link set includes it — m2 emits the whole
# input (no reachability-from-main yet, unlike the seed), so an
# under-linked dependency surfaces as an undefined global at assemble.
RT="lib/runtime/memory.mn lib/runtime/strings.mn lib/runtime/lists.mn lib/prelude.mn"
pass=0; fail=0

# rung <name> <expected-exit> <<'EOF' ... source ... EOF
rung() {
  local name="$1" want="$2" src="$G/$1.mn"
  cat > "$src"
  "$WT" run "${WT_RUN_FLAGS[@]}" "$GATE_WASM" < "$src" > "$G/$1.wat" 2> "$G/$1.err"
  local rc=$?
  if [ $rc -ne 0 ]; then
    echo "✗ $name: m2 COMPILE trap=$(grep -m1 -oE '!\S+' "$G/$1.err" | head -1) (backtrace: $G/$1.err)"
    fail=$((fail+1)); return
  fi
  if ! wt_asm "$G/$1.wat" "$G/$1.wasm" 2> "$G/$1.w2e"; then
    echo "✗ $name: ASSEMBLE — $(head -1 "$G/$1.w2e" | sed 's/.*error/error/')"
    fail=$((fail+1)); return
  fi
  "$WT" run "${WT_RUN_FLAGS[@]}" "$G/$1.wasm" > /dev/null 2> "$G/$1.run.err"
  local got=$?
  if [ "$got" = "$want" ]; then echo "✓ $name = $got"; pass=$((pass+1))
  else echo "✗ $name: RUN exit=$got want=$want"; fail=$((fail+1)); fi
}

echo "── rungs (each: m2-compile → wat2wasm → run → exit) ──"
rung one-main 7 <<'EOF'
fn main() = 7
EOF

rung call 7 <<'EOF'
fn id(x) = x
fn main() = id(7)
EOF

rung two-lets 3 <<'EOF'
let a = 1
let b = 2
fn main() = a + b
EOF

rung branch 9 <<'EOF'
fn pick(x) = if x > 3 { 9 } else { 1 }
fn main() = pick(5)
EOF

rung match-adt 4 <<'EOF'
type Opt = Some(Int) | Nothing
fn get(o) = match o {
  Some(v) => v,
  Nothing => 0
}
fn main() = get(Some(4))
EOF

# rungs below carry the runtime trio (the standard library — every real
# program links it; verify.sh RTLIBS convention)
rungrt() {
  local name="$1" want="$2" src="$G/$1.mn"
  { cat $RT; cat; } > "$src"
  "$WT" run "${WT_RUN_FLAGS[@]}" "$GATE_WASM" < "$src" > "$G/$1.wat" 2> "$G/$1.err"
  local rc=$?
  if [ $rc -ne 0 ]; then
    echo "✗ $name(+rt): m2 COMPILE trap=$(grep -m1 -oE '!\S+' "$G/$1.err" | head -1)"
    fail=$((fail+1)); return
  fi
  if ! wt_asm "$G/$1.wat" "$G/$1.wasm" 2> "$G/$1.w2e"; then
    echo "✗ $name(+rt): ASSEMBLE — $(head -1 "$G/$1.w2e" | sed 's/.*error/error/')"
    fail=$((fail+1)); return
  fi
  "$WT" run "${WT_RUN_FLAGS[@]}" "$G/$1.wasm" > /dev/null 2> "$G/$1.run.err"
  local got=$?
  if [ "$got" = "$want" ]; then echo "✓ $name(+rt) = $got"; pass=$((pass+1))
  else echo "✗ $name(+rt): RUN exit=$got want=$want"; fail=$((fail+1)); fi
}

rungrt pipe-hole 15 <<'EOF'
fn add(a, b) = a + b
fn main() = 5 |> add(??, 10)
EOF

rungrt handler 5 <<'EOF'
effect W { emit(s: String) }
handler w { emit(s) => resume() }
fn main() = { emit("x")
 5 } ~> w
EOF

rungrt hof-map 6 <<'EOF'
fn main() = {
  let xs = map((x) => x * 2, [1, 2])
  list_index(xs, 0) + list_index(xs, 1)
}
EOF

echo "── scoreboard: $pass pass / $fail fail ──"
if [ $fail = 0 ]; then
  echo "ALL RUNGS CLEAR — next gate: the micro battery through m2, then full pass-2:"
  echo "  bash tools/march-gate.sh --no-build --micros"
  echo "  bash tools/march.sh   # the m2→m3 fixed-point march"
fi

# ── micros-through-m2 — the promoted stress tier (--micros only) ──────────
# Same harness shape as rung()/rungrt() above: compile through m2.wasm,
# assemble, run, compare exit. A named dig site per ✗ — not fixed here.
if [ "$DO_MICROS" = 1 ]; then
  echo "── micros-through-m2 (each: m2-compile → wat2wasm → run → exit, +rt) ──"
  pass_m=0; fail_m=0
  while IFS= read -r line; do
    name=${line#micro:}; m=${name%%=*}; want=${name#*=}
    mf="tests/micros/mn-${m}.mn"
    if [ ! -f "$mf" ]; then
      echo "✗ micro $m: MISSING $mf"; fail_m=$((fail_m+1)); continue
    fi
    src="$G/micro-$m.mn"
    { cat $RT; cat "$mf"; } > "$src"
    "$WT" run "${WT_RUN_FLAGS[@]}" "$GATE_WASM" < "$src" > "$G/micro-$m.wat" 2> "$G/micro-$m.err"
    rc=$?
    if [ $rc -ne 0 ]; then
      echo "✗ micro $m: m2 COMPILE trap=$(grep -m1 -oE '!\S+' "$G/micro-$m.err" | head -1)"
      fail_m=$((fail_m+1)); continue
    fi
    if ! wt_asm "$G/micro-$m.wat" "$G/micro-$m.wasm" 2> "$G/micro-$m.w2e"; then
      echo "✗ micro $m: ASSEMBLE — $(head -1 "$G/micro-$m.w2e" | sed 's/.*error/error/')"
      fail_m=$((fail_m+1)); continue
    fi
    "$WT" run "${WT_RUN_FLAGS[@]}" "$G/micro-$m.wasm" > /dev/null 2> "$G/micro-$m.run.err"
    got=$?
    if [ "$got" = "$want" ]; then echo "✓ micro $m = $got"; pass_m=$((pass_m+1))
    else echo "✗ micro $m: RUN exit=$got want=$want"; fail_m=$((fail_m+1)); fi
  done < <(grep -E '^micro:' tools/verify-baseline.txt)
  echo "── micros-through-m2: $pass_m pass / $fail_m fail ──"
fi

exit $fail
