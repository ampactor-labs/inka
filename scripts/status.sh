#!/bin/bash
# Lux Status Report — auto-generated from tests
# Run this to verify STATE OF THE WORLD matches reality.

set -e

echo "═══════════════════════════════════════════════"
echo "  Lux Status Report — $(date '+%Y-%m-%d %H:%M')"
echo "═══════════════════════════════════════════════"
echo ""

# Rust compiler tests
echo "## Rust Compiler (golden tests)"
result=$(cargo test --test examples 2>&1 | tail -1)
echo "  $result"
echo ""

# Bootstrap pipeline
echo "## Self-Hosted Bootstrap Pipeline"
output=$(cargo run --quiet -- --no-check examples/bootstrap_pipeline_test.lux 2>&1)
if echo "$output" | grep -q "LUX COMPILING LUX"; then
  echo "  ✅ Bootstrap pipeline: WORKING"
  echo "$output" | grep "output:" | head -1 | sed 's/^/  /'
else
  echo "  ❌ Bootstrap pipeline: FAILING"
  echo "$output" | tail -3 | sed 's/^/  /'
fi
echo ""

# Examples
echo "## Examples"
pass=0
fail=0
for f in examples/*.lux; do
  base=$(basename "$f" .lux)
  expected="${f%.lux}.expected"
  if [ -f "$expected" ]; then
    actual=$(cargo run --quiet -- --quiet "$f" 2>/dev/null || true)
    expected_content=$(cat "$expected")
    if [ "$actual" = "$expected_content" ]; then
      pass=$((pass + 1))
    else
      fail=$((fail + 1))
      echo "  ❌ $base"
    fi
  fi
done
echo "  ✅ $pass passed, ❌ $fail failed"
echo ""

echo "═══════════════════════════════════════════════"
echo "  Update CLAUDE.md 'STATE OF THE WORLD' if changed"
echo "═══════════════════════════════════════════════"
