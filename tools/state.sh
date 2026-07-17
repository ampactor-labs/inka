#!/usr/bin/env bash
# tools/state.sh — THE BOARD: ground in reality, then every gate the repo
# owns, one scoreboard. This file only SEQUENCES — each check lives in
# exactly one home (verify.sh: micros + census, stamped; march.sh: the
# fixpoint ratchet; frontier-gate.sh: the scheduled/authoring contracts;
# proof-exactness-gate.sh: hole-refuses/debt-surfaces/suspension-runs;
# crown-gate.sh: !E soundness; effect-identity-gate.sh: Fail≠Abort).
# The board's shape mirrors its successor — the medium's own verify verb
# (PLAN §6: the bash scaffolds dissolve at L1); until then this command IS
# "is everything true?". --quick runs verify only (the stamp makes an
# unchanged tree instant).
set -u
cd "$(dirname "$0")/.." || exit 2

reds=0

# Run one gate: green → its last line; red → its RED lines + last line.
gate() {
  local label="$1"; shift
  echo "▸ $label"
  local out rc
  out=$("$@" 2>&1); rc=$?
  if [ "$rc" -eq 0 ]; then
    echo "$out" | tail -1 | sed 's/^/    /'
  else
    echo "$out" | grep -E "RED|✗" | head -8 | sed 's/^/    /'
    echo "$out" | tail -1 | sed 's/^/    /'
    reds=$((reds + 1))
  fi
}

echo "▸ GIT"
git log --oneline -3 | sed 's/^/    /'
sc=$(git status --short); echo "    uncommitted: $([ -z "$sc" ] && echo none || echo "$(echo "$sc" | wc -l) file(s)")"
[ -n "$sc" ] && echo "$sc" | sed 's/^/      /'

echo "▸ VERIFY (micros + census — stamped)"
bash tools/verify.sh || exit 1

if [ "${1:-}" != "--quick" ]; then
  gate "MARCH (the fixpoint ratchet)"                                    bash tools/march.sh
  gate "FRONTIER (scheduled matrix + the ?? authoring workflows)"        bash tools/frontier-gate.sh
  gate "PROOF-EXACTNESS (hole refuses · debt surfaces · suspension runs)" bash tools/proof-exactness-gate.sh
  gate "CROWN (!E soundness crucibles)"                                  bash tools/crown-gate.sh
  gate "EFFECT IDENTITY (Fail ≠ Abort)"                                  bash tools/effect-identity-gate.sh
  gate "PHANTOMS (the medium's verdict on its own prose)"                bash tools/comment-ratchet.sh

  if [ "$reds" -eq 0 ]; then
    echo "▸ THE BOARD IS WHOLE — every gate green."
  else
    echo "▸ BOARD: $reds gate(s) red."
    exit 1
  fi
fi
