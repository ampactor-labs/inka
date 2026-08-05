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

# The march writes the pin's mechanical facts itself (sha/verdict/lines/
# census read from the artifact) and leaves the NARRATIVE as a literal
# placeholder — so "the pin is not blessed until the entry is written"
# stops being a printed reminder and becomes a refusal. An unwritten
# narrative fails here, at every verify.
# Anchored to the ENTRY form (`- source: ‹…`), never the bare phrase: the
# file's own recipe names the placeholder in prose, and an unanchored
# grep convicted it on this check's first run — the string-literal
# blindness class the drift audit already paid for, one layer up.
if grep -q '^- source: ‹NARRATIVE UNWRITTEN' boot/PROVENANCE.md; then
  echo "doc-truth: the head PROVENANCE entry's narrative is unwritten (the march's placeholder stands)"
  echo "  the pin is not blessed until it says what landed and why — replace the ‹…› line"
  fail=1
fi

# The same refusal at the BOARD. emit_provenance captures every gate the
# repo owns and marks a red one; a pin carrying that marker is not a pin,
# it is a working step. Paid for 2026-08-05: the crown went unreported for
# eleven consecutive ledger entries while a higher-order `!E` leak rode the
# arc — nothing written was false, the gate had merely stopped being
# mentioned, so only a captured board could have caught it.
if grep -q '^- ‹BOARD RED' boot/PROVENANCE.md; then
  echo "doc-truth: the head PROVENANCE entry records a RED gate at its own pin"
  echo "  fix the gate or restore the prior boot — a red board blesses nothing"
  fail=1
fi

# The ledger moved to LEDGER.md (2026-08-05) — 78% of PLAN was a prose copy
# of git. An EMPTY headpin used to pass silently here, so the move would have
# turned this into a gate that cannot fail; the absence is now a failure.
# An entry's pin sits on a CONTINUATION line, so the scan anchors at the first
# entry and reads onward — matching per-entry-line found an older inline pin
# and reported a false mismatch on this check's first run after the move.
headpin=$(awk '/^- 2026/{f=1} f && match($0, /pin [0-9a-f]{8}/){print substr($0, RSTART+4, 8); exit}' LEDGER.md)
if [ -z "$headpin" ]; then
  echo "doc-truth: no pin found in LEDGER.md's head entry — the chain cannot be checked, so it fails"
  fail=1
elif [ "${have:0:8}" != "$headpin" ]; then
  echo "doc-truth: the ledger's most recent pin ($headpin) is not the boot sha prefix (${have:0:8})"
  fail=1
fi

# LEDGER.md stays OUT of the named-command sweep: it is history, and a landing
# that records deleting a script is not a broken promise (the sweep's own first
# run correctly made that distinction). PLAN carries only live claims now, so
# the whole file is swept.
plan_present=$(cat PLAN.md)
# The third party's own instruction surfaces are reader-facing docs too:
# hook prose grounded a week of sessions on superseded law and a pre-commit
# gate no-opped against a deleted script behind its -x check (the practice
# scout's 2026-07-30 catch) — so the hooks and git-side gates join the
# named-command sweep. Law and state stay OUT of hooks (the one-home rule);
# this check keeps their command citations real.
for f in $( { printf '%s' "$plan_present"; cat README.md CLAUDE.md docs/SYNTAX.md .claude/hooks/*.sh .githooks/pre-commit 2>/dev/null; } | grep -hoE '(bash )?tools/[a-z0-9_-]+\.(sh|py)' | sed 's/^bash //' | sort -u); do
  if [ ! -f "$f" ]; then
    echo "doc-truth: docs name $f but it does not exist"
    fail=1
  fi
done

# The SAME sweep at the verb namespace. `tools/` commands were checked from
# the start; `mentl <verb>` never was — so the docs could promise a verb the
# CLI does not serve and nothing noticed. Measured 2026-08-05: `mentl where`
# is named six times across SYNTAX and PLAN (it is the badge that returns a
# `><`'s resolved schedule to the site) and does not exist; `mentl why` and
# `mentl verify` likewise. The verb list is READ FROM THE MEDIUM — `mentl
# help` is the one home, so no second list can drift from it (a hand-kept
# roster here would be the very disease this check exists to catch).
verbs=$(mentl help 2>/dev/null | grep -oE '^  mentl [a-z]+' | awk '{print $2}' | sort -u)
if [ -z "$verbs" ]; then
  echo "doc-truth: could not read the verb table from 'mentl help' — the check cannot fail, so it fails"
  fail=1
else
  # Two exclusions, both structural. `mentl voice.mn:9` is an ADDRESS, not a
  # verb — the address form is the CLI's endpoint (drift 38: tentacles fire
  # at-cursor, never as subcommands) — so a word followed by a path or address
  # character is excluded. And "the mentl voice" is a NOUN PHRASE; a doc naming
  # a command puts it in code formatting, so the match must open with a
  # backtick. Both were measured as false positives on this check's first run.
  # SYNTAX is the authority and the CLI is the lathe, so the docs MAY name a
  # verb before `mentl help` serves it — but the lag is a list in one home
  # (SYNTAX §"Verbs this document declares that the CLI has not yet grown"),
  # never an invisible promise. Any verb outside both the served set and that
  # list fails. The list shrinks as verbs land.
  declared=$(awk '/^## Verbs this document declares/{f=1;next} f&&/^## /{exit} f' docs/SYNTAX.md | grep -oP '^- \*\*`mentl \K[a-z]+')
  for v in $( { printf '%s' "$plan_present"; cat README.md CLAUDE.md docs/SYNTAX.md 2>/dev/null; } | grep -hoP '`mentl \K[a-z]+(?![a-z./:_-])' | sort -u); do
    printf '%s\n' "$verbs" | grep -qx "$v" && continue
    printf '%s\n' "$declared" | grep -qx "$v" && continue
    echo "doc-truth: docs name the verb 'mentl $v' but the CLI serves no such verb"
    fail=1
  done
fi

if [ $fail -eq 0 ]; then
  echo "doc-truth: the docs' checkable claims verify against the artifact"
fi
exit $fail
