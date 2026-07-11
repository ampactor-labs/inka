#!/usr/bin/env bash
# ide/serve.sh — mentl serves mentl. Compiles ide/serve.mn with the pinned
# fixpoint compiler when stale, then runs it on the preopened listener.
# A bash scaffold in the seed tradition: dissolves at the `mentl serve` verb.
set -euo pipefail
cd "$(dirname "$0")/.."
source tools/wt-env.sh
PORT="${1:-7378}"

LINK=(lib/runtime/memory.mn lib/runtime/strings.mn lib/runtime/lists.mn
      lib/prelude.mn lib/runtime/io.mn lib/runtime/net.mn ide/serve.mn)
if [ ! -f ide/serve.wasm ] || [ -n "$(find "${LINK[@]}" boot/mentl.wasm -newer ide/serve.wasm 2>/dev/null)" ]; then
  echo "· compiling ide/serve.mn with boot/mentl.wasm"
  cat "${LINK[@]}" | "$WT" run "${WT_RUN_FLAGS[@]}" boot/mentl.wasm > /tmp/mentl-serve.wat 2>/dev/null
  "${W2W[@]}" /tmp/mentl-serve.wat -o ide/serve.wasm
fi
exec "$WT" run "${WT_RUN_FLAGS[@]}" --dir . -S "tcplisten=127.0.0.1:${PORT}" ide/serve.wasm
