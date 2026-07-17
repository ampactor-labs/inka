#!/usr/bin/env bash
# comment-ratchet.sh — the census, one layer up: the medium's verdict on its
# own PROSE.
#
# A `//` comment IS graph content (SYNTAX.md §Comments): a CommentReason edge
# the Why engine walks and Mentl's voice surfaces. So a comment citing a symbol
# that exists nowhere is not a doc nit — it is a FALSE EDGE IN THE GRAPH, the
# Carried-Truth Law violated at the prose layer. tools/comment-audit.sh has
# found these all along, exits 1 on a hit, and its own header ends "wire into
# pre-commit to gate, or run by hand." Nobody wired it. It had never been run
# when this ratchet was written; the first run found 554.
#
# So it ratchets exactly like the census (tools/verify.sh §3), because it is the
# same law and the same fix: the number may never rise, and it falls to 0. When
# it reaches 0 this file is DELETED and comment-audit gates directly — and both
# ratchets dissolve together into `mentl audit`, which is the projection they are
# larval forms of (PLAN §6's scaffold tier).
#
# Why a ratchet and not a hard gate today: 554 phantoms are real and cost a
# reader real time, but refusing every commit until all 554 die stops the medium
# from being worked on. The ratchet is the monotone path — a rise is a NEW lie
# and blocks; a fall is banked immediately.
#
# Usage: tools/comment-ratchet.sh
# Exit:  0 held or fell, 1 rose.
set -uo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"
BASELINE="tools/verify-baseline.txt"

n=$(bash tools/comment-audit.sh 2>/dev/null | grep -c '^PHANTOM' || true)
max=$(grep -E '^phantom_comments_max:' "$BASELINE" | head -1 | cut -d: -f2 | tr -d ' ')

echo "· phantoms: $n symbols cited in comments that exist nowhere in code"
if [ -z "$max" ]; then
  echo "  (no phantom_comments_max in $BASELINE — reporting only)"
  exit 0
fi
if [ "$n" -gt "$max" ]; then
  echo "✗ PHANTOM RATCHET: rose $max -> $n. A comment citing a symbol that does not"
  echo "  exist is a false CommentReason edge — the Why engine will walk a reader"
  echo "  into it. Fix the comment (or the missing symbol), or raise"
  echo "  phantom_comments_max in $BASELINE with the reason."
  echo "  Offenders: bash tools/comment-audit.sh"
  exit 1
fi
if [ "$n" -lt "$max" ]; then
  echo "  ↓ phantoms FELL $max -> $n — lower phantom_comments_max in $BASELINE to hold it."
fi
exit 0
