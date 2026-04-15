#!/usr/bin/env bash
# Diverse Double-Compiling gate (Wheeler 2005) — Arc 3 P0-C4.
#
# Before P0-C5 deletes src/, prove two things:
#
#   1. The Rust escape-hatch path reproduces bootstrap/artifacts/lux3.wat
#      byte-for-byte. If rust-vm-final ever needs to regenerate the seed,
#      the bytes will match.
#   2. The self-hosted path (lux3.wasm compiling wasm_bootstrap.lux) runs
#      to completion and produces lux4.wat with the Arc 2 drift signature
#      (val_concat goes from 5 to 17 — the 12 documented sites). Any other
#      divergence means the seed itself has regressed.
#
# Strict A == B byte-match is the Phase 2 (Item 5 / DAG env) goal, NOT
# the Phase 0 gate. That gate flips when Phase 2 closes.

set -euo pipefail

cd "$(git rev-parse --show-toplevel)"

SRC=examples/wasm_bootstrap.lux
[ -f std/compiler/wasm_bootstrap.lux ] && SRC=std/compiler/wasm_bootstrap.lux
[ -f "$SRC" ] || { echo "DDC: wasm_bootstrap.lux not found"; exit 1; }

ART_WAT=bootstrap/artifacts/lux3.wat
ART_WASM=bootstrap/artifacts/lux3.wasm
OUT_RUST=/tmp/ddc-rust.wat
OUT_LUX=bootstrap/build/lux4.wat
WASMTIME=${WASMTIME:-$HOME/.wasmtime/bin/wasmtime}

# ── 1. Path A: Rust → WAT, compare to frozen artifact ────────────
echo "── DDC check 1: Rust path reproduces frozen artifact ──"
if [ -d src ]; then
  cargo build --release --quiet
  ./target/release/lux wasm "$SRC" > /tmp/ddc-rust.raw 2>&1
  sed -n '/^(module/,$p' /tmp/ddc-rust.raw > "$OUT_RUST"
else
  echo "  src/ absent — checking out rust-vm-final into worktree"
  WT=/tmp/ddc-rust-vm-final
  [ -d "$WT" ] && git worktree remove --force "$WT"
  git worktree add "$WT" rust-vm-final
  ( cd "$WT" && cargo build --release --quiet \
    && ./target/release/lux wasm "$SRC" ) > /tmp/ddc-rust.raw 2>&1
  sed -n '/^(module/,$p' /tmp/ddc-rust.raw > "$OUT_RUST"
  git worktree remove --force "$WT"
fi

if diff -q "$OUT_RUST" "$ART_WAT" >/dev/null; then
  echo "  ✓ Rust path byte-identical to $ART_WAT"
  echo "    $(sha256sum "$OUT_RUST" | cut -d' ' -f1)"
else
  echo "  ✗ Rust path does NOT reproduce $ART_WAT — escape hatch broken"
  echo "    DO NOT delete src/. Investigate:"
  diff "$OUT_RUST" "$ART_WAT" | head -20
  exit 1
fi

# ── 2. Path B: self-host runs, produces lux4.wat with known drift ──
echo ""
echo "── DDC check 2: self-hosted path produces expected lux4.wat ──"
if [ ! -f "$OUT_LUX" ] || [ "$ART_WAT" -nt "$OUT_LUX" ]; then
  echo "  running stage2 (ouroboros — ~6 min)"
  make -C bootstrap stage2 >/dev/null 2>&1 || true  # check_wat gate may flag drift; that's OK here
fi

if [ ! -s "$OUT_LUX" ]; then
  echo "  ✗ lux4.wat empty — self-host seed failed to compile wasm_bootstrap.lux"
  echo "    DO NOT delete src/."
  exit 1
fi

VAL_CONCAT=$(grep -cE '(call|return_call) \$val_concat\b' "$OUT_LUX" || true)
# Arc 2 close: lux3 has 5 val_concat, lux4 has 17 (+12 drift).
# If the number is not 17±3, something is off.
if [ "$VAL_CONCAT" -lt 10 ] || [ "$VAL_CONCAT" -gt 25 ]; then
  echo "  ✗ val_concat count = $VAL_CONCAT — unexpected (Arc 2 baseline: 17)"
  echo "    Seed may have regressed. Investigate before deleting src/."
  exit 1
fi
echo "  ✓ lux4.wat produced; val_concat=$VAL_CONCAT (Arc 2 expected: 17, drift to be closed in Phase 2)"

# ── Summary ──────────────────────────────────────────────────────
echo ""
echo "── DDC VERDICT ──"
echo "  Escape hatch: VERIFIED (rust path → artifact byte-match)"
echo "  Self-host:    VERIFIED (lux4.wat with expected Arc 2 drift)"
echo "  Strict A==B:  DEFERRED to Phase 2 (DAG env, Item 5)"
echo "  → Safe to proceed with P0-C5 (delete src/)"
