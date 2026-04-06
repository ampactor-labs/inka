#!/bin/bash
# Run the checker-in-WASM compile without Claude Code competing for RAM.
# Close Claude Code first, then: bash art/run_wasm_check.sh
#
# Expected runtime: 30-60 min without memory pressure (vs 3h+ with Claude)
# Expected result: wasmtime prints "15"

set -e
echo "Starting compile at $(date)..."
echo "This will take 30-60 minutes. Go make tea."
echo ""

time ./target/release/lux wasm examples/wasm_check.lux > /tmp/check.wat 2>/tmp/check.err

echo ""
echo "Compile finished at $(date)"
echo "WAT size: $(wc -l < /tmp/check.wat) lines ($(wc -c < /tmp/check.wat) bytes)"
echo "Errors: $(cat /tmp/check.err)"
echo ""
echo "Running through wasmtime..."
echo "---"
~/.wasmtime/bin/wasmtime /tmp/check.wat
echo "---"
echo ""
echo "Expected: 15"
echo "If you see 15, the checker compiles and runs correctly in WASM."
echo "The light went through the prism and came out the other side."
