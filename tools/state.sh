#!/usr/bin/env bash
# tools/state.sh — ground in reality: repo state, then the two real gates.
# Boot-era form: this file only SEQUENCES — every check lives in exactly one
# home (verify.sh: micros + census, stamped green; march.sh: the fixpoint
# ratchet, transition-native). --quick runs verify only (the stamp makes an
# unchanged tree instant).
set -u
cd "$(dirname "$0")/.." || exit 2

echo "▸ GIT"
git log --oneline -3 | sed 's/^/    /'
sc=$(git status --short); echo "    uncommitted: $([ -z "$sc" ] && echo none || echo "$(echo "$sc" | wc -l) file(s)")"
[ -n "$sc" ] && echo "$sc" | sed 's/^/      /'

echo "▸ VERIFY (micros + census — stamped)"
bash tools/verify.sh || exit 1

if [ "${1:-}" != "--quick" ]; then
  echo "▸ MARCH (the fixpoint ratchet)"
  bash tools/march.sh
fi
