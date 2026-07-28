#!/usr/bin/env bash
# tools/doc-truth.sh — the mechanical census on the docs' load-bearing claims.
#
# Prose drifts; artifacts do not — so the claims that CAN be checked against
# the artifact ARE, at every verify, zero-tolerance (these are exactly true
# always, never a ratchet):
#
#   1. The PROVENANCE head sha equals sha256(boot/mentl.wasm). A pin claim
#      is a measurement read from the artifact, never typed from memory —
#      the fabrication law (CLAUDE.md ⊕), mechanized.
#   2. The §7 ledger's most recent `pin XXXXXXXX` is the boot sha's prefix —
#      a ledger entry cannot claim a pin the artifact does not carry.
#   3. Every `bash tools/<x>.sh` and `tools/<x>.py` the four reader-facing
#      docs name in PRESENT-TENSE position exists on disk — the verification
#      surface (PLAN §8) and the README's command blocks are the outsider's
#      path; a command that does not exist is a broken promise. The §7
#      landing ledger is HISTORY (a deletion record legitimately names the
#      file it deleted) and is excluded from the sweep.
#
# Scaffold tier (PLAN §6): dissolves into docs-as-projection + `mentl audit`
# (the state sections generated from the graph make checks 1-2 vacuous; the
# comment-refs machinery generalized to doc anchors absorbs check 3).
set -u
cd "$(dirname "$0")/.." || exit 2
fail=0

have=$(sha256sum boot/mentl.wasm | awk '{print $1}')
claimed=$(grep -m1 -oE 'sha256 [0-9a-f]{64}' boot/PROVENANCE.md | awk '{print $2}')
if [ "$have" != "$claimed" ]; then
  echo "doc-truth: PROVENANCE head sha is not the artifact's —"
  echo "  claimed $claimed"
  echo "  boot is $have"
  fail=1
fi

headpin=$(awk '/^### The landing ledger/{f=1} f && match($0, /pin [0-9a-f]{8}/){print substr($0, RSTART+4, 8); exit}' PLAN.md)
if [ -n "$headpin" ] && [ "${have:0:8}" != "$headpin" ]; then
  echo "doc-truth: the ledger's most recent pin ($headpin) is not the boot sha prefix (${have:0:8})"
  fail=1
fi

plan_present=$(awk '/^### The landing ledger/{skip=1} /^### Named-residue index/{skip=0} !skip' PLAN.md)
for f in $( { printf '%s' "$plan_present"; cat README.md CLAUDE.md docs/SYNTAX.md 2>/dev/null; } | grep -hoE '(bash )?tools/[a-z0-9_-]+\.(sh|py)' | sed 's/^bash //' | sort -u); do
  if [ ! -f "$f" ]; then
    echo "doc-truth: docs name $f but it does not exist"
    fail=1
  fi
done

if [ $fail -eq 0 ]; then
  echo "doc-truth: the docs' checkable claims verify against the artifact"
fi
exit $fail
