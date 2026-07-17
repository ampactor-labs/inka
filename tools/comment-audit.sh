#!/usr/bin/env bash
# comment-audit.sh — proto-`mentl audit` for stale CommentReason edges.
#
# A `//` comment is graph content (SYNTAX.md): a CommentReason edge the Why
# engine walks; a STALE comment is a FALSE edge. This catches the one class
# that is MECHANICALLY decidable + highest-harm: the PHANTOM SYMBOL — a
# snake_case code identifier cited in a comment that appears NOWHERE in code
# (deleted / renamed / never-defined). A real symbol lives in code; a phantom
# lives only in prose, and a developer hunts it forever.
#
# THIS IS A FIRST LINE, NOT THE LINE. It cannot judge SEMANTIC staleness (a
# false-mechanism claim whose symbols all still resolve). That needs the LLM
# sweep — and the realized form is `mentl fmt` + `mentl audit`, which need
# first-light (the formatter/audit are projections of the live graph).
#
# Usage:  tools/comment-audit.sh [file.mn ...]   (default: all src + lib .mn)
# Exit:   0 clean, 1 phantom(s) — wire into pre-commit to gate, or run by hand.
set -u
cd "$(git -C "$(dirname "$0")" rev-parse --show-toplevel 2>/dev/null || pwd)"
if [ $# -gt 0 ]; then TARGETS="$*"; else TARGETS="$(find src lib -name '*.mn')"; fi

# CODE SURFACE: BOTH layers, comments stripped — where real symbols live. A
# symbol present here is resolved; one absent (yet cited) is a phantom edge.
SURFACE="$(mktemp)"
{ find src lib -name '*.mn'    -exec sed 's://.*::' {} + ;
  } > "$SURFACE"

# kernel vocabulary that reads snake_case but is NOT a code symbol (tune freely)
ALLOW='^(self|first_light|machine_code|use_count)$'

found=0
for f in $TARGETS; do
  [ -f "$f" ] || continue
  # TOMBSTONE EXEMPTION: a comment block that opens with DELETED / REMOVED /
  # RETIRED is a deliberate history note — the symbols it names are SUPPOSED to be
  # gone, so citing them is correct, not a phantom edge. Without this, deleting
  # code and honestly recording what was deleted RAISES the phantom count, which
  # would push authors to erase the tombstone — the opposite of comment truth.
  # A tombstone's authority extends to the contiguous `//` block it heads.
  in_tombstone=0
  while IFS=: read -r ln rest; do
    printf '%s' "$rest" | grep -qE '^[[:space:]]*//' || in_tombstone=0   # blank/code line ends the block
    printf '%s' "$rest" | grep -qE '\b(DELETED|REMOVED|RETIRED|DISSOLVED)\b' && in_tombstone=1
    [ "$in_tombstone" -eq 1 ] && continue
    # drop file paths + file.ext tokens so seed/doc filenames aren't mistaken
    clean=$(printf '%s' "$rest" | sed -E 's@[A-Za-z0-9_.-]*/[A-Za-z0-9_./-]+@ @g; s@[A-Za-z0-9_]+\.[a-z]{2,4}\b@ @g')
    for sym in $(printf '%s\n' "$clean" | grep -oE '[a-z][a-z0-9]*(_[a-z0-9]+)+' | sort -u); do
      printf '%s' "$sym" | grep -qE "$ALLOW" && continue
      grep -qwF "$sym" "$SURFACE" || { printf 'PHANTOM  %s:%-4s  %s — cited in a comment, defined nowhere in code\n' "$f" "$ln" "$sym"; found=1; }
    done
  done < <(grep -nE '^[[:space:]]*//' "$f")
done
rm -f "$SURFACE"
[ "$found" -eq 0 ] && echo "comment-audit: clean — no phantom-symbol CommentReason edges."
exit "$found"
