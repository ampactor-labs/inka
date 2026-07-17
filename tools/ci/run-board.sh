#!/usr/bin/env bash
# tools/ci/run-board.sh — the CI form of THE BOARD (plan: the MI300X host,
# docs/ops/mi300x.md once recon lands). Pull, run every gate, append the
# perf ledger — fixed hardware makes the numbers comparable per commit.
# Usable as a GH Actions self-hosted runner step or invoked by hand per
# session when the box cannot hold a daemon.
set -uo pipefail
cd "$(dirname "$0")/../.." || exit 2

git pull --ff-only 2>/dev/null || true
sha=$(git rev-parse --short=8 HEAD)

start=$(date +%s)
board_out=$(bash tools/state.sh 2>&1); board_rc=$?
elapsed=$(( $(date +%s) - start ))

ledger="tools/ci/perf-ledger.tsv"
[ -f "$ledger" ] || printf 'date\tcommit\tboard\tseconds\n' > "$ledger"
printf '%s\t%s\t%s\t%s\n' "$(date -u +%Y-%m-%dT%H:%M)" "$sha" \
  "$([ "$board_rc" -eq 0 ] && echo whole || echo red)" "$elapsed" >> "$ledger"

echo "$board_out" | tail -12
echo "ci: board=$([ "$board_rc" -eq 0 ] && echo WHOLE || echo RED) in ${elapsed}s @ $sha (ledger: $ledger)"
exit "$board_rc"
