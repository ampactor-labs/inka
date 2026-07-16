#!/usr/bin/env bash
# Red contracts for executable refusal and context-sensitive hole classification.
# This stays separate from frontier-gate.sh until the proof transaction lands.
set -uo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT" || exit 2
source "$ROOT/tools/wt-env.sh"

selection="${1:-boot}"
case "$selection" in
  boot)
    compiler="$ROOT/boot/mentl.wasm"
    label=boot
    ;;
  fresh)
    cache=$(wt_m2_ensure) || exit 2
    compiler="$ROOT/$cache/m2.wasm"
    label=fresh
    ;;
  *)
    case "$selection" in
      /*) compiler="$selection" ;;
      *) compiler="$ROOT/$selection" ;;
    esac
    label=explicit
    ;;
esac

[ -f "$compiler" ] || {
  echo "proof-exactness: compiler not found: $compiler" >&2
  exit 2
}

dir="$ROOT/.build/proof-exactness-gate/$label"
rm -rf "$dir"
mkdir -p "$dir"

passes=0
reds=0

pass() {
  echo "  PASS $*"
  passes=$((passes + 1))
}

red() {
  echo "  RED  $*"
  reds=$((reds + 1))
}

expect_refusal() {
  local stem="$1" fixture="$2" diagnostic="$3"
  local wat="$dir/$stem.wat" err="$dir/$stem.err" rc

  wt_run "$compiler" < "$fixture" > "$wat" 2> "$err"
  rc=$?

  if [ "$rc" -ne 0 ]; then
    pass "$stem returned nonzero"
  else
    red "$stem returned zero"
  fi

  if [ ! -s "$wat" ]; then
    pass "$stem emitted no WAT bytes"
  else
    red "$stem emitted $(wc -c < "$wat") WAT bytes"
  fi

  if grep -Eq "$diagnostic" "$err"; then
    pass "$stem preserved $diagnostic"
  else
    red "$stem lost $diagnostic (see $err)"
  fi
}

expect_executable() {
  local stem="$1" fixture="$2" expected="$3"
  local wat="$dir/$stem.wat" wasm="$dir/$stem.wasm"
  local cerr="$dir/$stem.compile.err" aerr="$dir/$stem.assemble.err"
  local rout="$dir/$stem.run.out" rerr="$dir/$stem.run.err" rc

  wt_run "$compiler" < "$fixture" > "$wat" 2> "$cerr"
  rc=$?
  if [ "$rc" -eq 0 ] && ! grep -Eq '(^|: )(E_|V_?Pending)' "$cerr"; then
    pass "$stem compiled without errors or proof debt"
  else
    red "$stem compile failed or reported debt (exit=$rc; see $cerr)"
    return
  fi

  if wt_asm "$wat" "$wasm" 2> "$aerr"; then
    pass "$stem assembled"
  else
    red "$stem assembly failed (see $aerr)"
    return
  fi

  wt_run "$wasm" > "$rout" 2> "$rerr"
  rc=$?
  if [ "$rc" -eq "$expected" ]; then
    pass "$stem ran (exit=$rc)"
  else
    red "$stem ran with exit=$rc, expected=$expected (see $rerr)"
  fi
}

echo "proof-exactness: compiler=$label artifact=$compiler"
expect_refusal \
  unresolved-hole \
  "$ROOT/tests/frontier/mn-hole-executable-refusal.mn" \
  'E_UnresolvedHole'
expect_refusal \
  proof-debt \
  "$ROOT/tests/frontier/mn-proof-debt-executable-refusal.mn" \
  'V_?Pending'
expect_executable \
  partial-hole \
  "$ROOT/tests/frontier/mn-partial-hole-executable.mn" \
  42

echo "proof-exactness: $passes pass / $reds red"
[ "$reds" -eq 0 ]
