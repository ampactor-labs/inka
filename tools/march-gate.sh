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
#   bash tools/march-gate.sh            # build seed + m2, run all rungs
#   bash tools/march-gate.sh --no-build # reuse .build/probe/m2.wasm
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

if [ "${1:-}" != "--no-build" ]; then
  echo "── seed ──"
  bash bootstrap/build.sh >/dev/null 2>&1 || { echo "✗ seed build FAILED"; exit 1; }
  echo "── m2 (seed compiles the wheel) ──"
  bash tools/probe.sh m2 | tail -2 || exit 1
fi
[ -f "$OUT/m2.wasm" ] || { echo "✗ no m2.wasm — run without --no-build"; exit 1; }

RT="lib/runtime/memory.mn lib/runtime/strings.mn lib/runtime/lists.mn"
pass=0; fail=0

# rung <name> <expected-exit> <<'EOF' ... source ... EOF
rung() {
  local name="$1" want="$2" src="$G/$1.mn"
  cat > "$src"
  "$WT" run "${WT_RUN_FLAGS[@]}" "$OUT/m2.wasm" < "$src" > "$G/$1.wat" 2> "$G/$1.err"
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
  "$WT" run "${WT_RUN_FLAGS[@]}" "$OUT/m2.wasm" < "$src" > "$G/$1.wat" 2> "$G/$1.err"
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
  echo "  for m in \$(sed 's/micro://;s/=.*//' tools/verify-baseline.txt); do ...run tests/micros/mn-\$m.mn through m2...; done"
  echo "  bash tools/march.sh   # the m2→m3 fixed-point march"
fi
exit $fail
