#!/usr/bin/env bash
# exit 0 iff the candidate (s06_div_zero.wasm) still traps: integer divide by zero
WT="/home/suds/.wasmtime/bin/wasmtime"
out=$("$WT" run -W threads=y -W shared-memory=y -W tail-call=y -S threads=y "$1" 2>&1)
printf '%s' "$out" | grep -qF 'integer divide by zero'
