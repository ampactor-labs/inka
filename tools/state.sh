#!/usr/bin/env bash
# state.sh — a DISSOLVING SCAFFOLD. The ultimate form of this is `mentl where`:
# the cursor's argmax projection over the project's own development graph
# (Phase ν, reflexive) — "you are here, this is proven, this is the residue,
# the gradient's next move is X, because <Reason chain>". State is not computed
# by a script; it IS the graph, and understanding is the cursor reading it.
#
# Until L1 closes the medium can't run, so the only projector that exists is the
# SEED — itself the graph projected to WAT. So the most-Mentl move available now
# is to ASK THAT ONE ARTIFACT about itself (Anchor 1: ask the graph; Prime
# Directive: build the tool that tells you), carrying ZERO logic of its own —
# every line below runs an artifact and shows its projection; nothing here
# re-derives or interprets. The instant `mentl where` exists, delete this.
#
# Run it FIRST, at any point of development, before any theory or any edit.
# Measurement cannot lie: every number is produced live this run. If a doc
# disagrees, the doc is stale — trust this.
#
# Usage:  bash tools/state.sh            # full ground truth
#         bash tools/state.sh --quick    # skip the two-pass (census + micros only)

set -u
cd "$(dirname "$0")/.." || exit 1
WT="$HOME/.wasmtime/bin/wasmtime"
WTRUN="$WT run -W threads=y -W shared-memory=y -W tail-call=y -S threads=y"
QUICK="${1:-}"
hr() { printf '─%.0s' {1..72}; echo; }

echo
hr; echo "  MENTL GROUND TRUTH — $(date -u '+%Y-%m-%d %H:%M:%SZ')"; hr

echo "▸ TREE"
git log --oneline -3 | sed 's/^/    /'
sc=$(git status --short); echo "    uncommitted: $([ -z "$sc" ] && echo none || echo "$(echo "$sc" | wc -l) file(s)")"
[ -n "$sc" ] && echo "$sc" | sed 's/^/      /'

echo "▸ SEED"
if bash bootstrap/build.sh >/tmp/state_build.log 2>&1; then
  echo "    build: OK ($(grep -oE 'mentl.wasm \([0-9]+ bytes\)' /tmp/state_build.log | tail -1))"
else
  echo "    build: ✗ FAILED — see /tmp/state_build.log"; tail -3 /tmp/state_build.log | sed 's/^/      /'; exit 1
fi

echo "▸ WHEEL CENSUS  (seed compiles the wheel source; baseline target = 165 exact)"
{ find src -name '*.mn' | sort | xargs cat; \
  find lib -name '*.mn' -not -path '*/tutorial/*' | sort | xargs cat; } > /tmp/state_wheel.mn
if $WTRUN bootstrap/mentl.wasm < /tmp/state_wheel.mn > /tmp/state_m2.wat 2>/tmp/state_m2.err; then
  total=$(grep -cE '^[EPW]_[A-Za-z]+' /tmp/state_m2.err)
  echo "    seed compiles wheel: OK   m2.wat = $(wc -l < /tmp/state_m2.wat) lines   diagnostics = $total"
  grep -oE '^[EPW]_[A-Za-z]+' /tmp/state_m2.err | sort | uniq -c | sort -rn | head -6 | sed 's/^/      /'
else
  echo "    seed compiles wheel: ✗ TRAP — see /tmp/state_m2.err"; tail -3 /tmp/state_m2.err | sed 's/^/      /'
fi

echo "▸ MICRO BATTERY  (gates the seed; each exit code captured directly)"
for spec in "ev2 57" "ev4 57" "ev8 57" "ev5 21" "ev16 18" "eq 73" "interp 59"; do
  set -- $spec; m=$1; want=$2; f="tests/micros/mn-$m.mn"
  [ -f "$f" ] || { printf "      %-7s (no file)\n" "$m"; continue; }
  out=$(tools/run-micro.sh "$f" 2>/dev/null | tail -1)
  printf "      %-7s want=%-3s  %s\n" "$m" "$want" "$out"
done

if [ "$QUICK" = "--quick" ]; then hr; echo "  (--quick: two-pass skipped)"; hr; echo; exit 0; fi

echo "▸ PASS-2  (does the seed-compiled wheel compile the wheel? → first-light at empty diff)"
if wat2wasm /tmp/state_m2.wat -o /tmp/state_m2.wasm --debug-names --enable-threads --enable-tail-call 2>/tmp/state_w2w.err; then
  echo "    m2.wat assembles: OK"
  if timeout 300 $WTRUN /tmp/state_m2.wasm < /tmp/state_wheel.mn > /tmp/state_m3.wat 2>/tmp/state_m3.err; then
    if diff -q /tmp/state_m2.wat /tmp/state_m3.wat >/dev/null 2>&1; then
      echo "    *** mentl2 == mentl3 — FIRST LIGHT (L1 closed) ***"
    else
      echo "    m2 compiled the wheel → m3.wat = $(wc -l < /tmp/state_m3.wat) lines; diff vs m2 = $(diff /tmp/state_m2.wat /tmp/state_m3.wat | wc -l) lines"
    fi
  else
    echo "    mentl2 TRAPPED compiling the wheel (exit) — pass-2 blocked. first failures:"
    grep -E 'P_|E_' /tmp/state_m3.err | head -2 | sed 's/^/      /'
    echo "      P_UnexpectedToken count: $(grep -c 'P_UnexpectedToken' /tmp/state_m3.err)"
  fi
else
  echo "    m2.wat assembles: ✗ $(wc -l < /tmp/state_w2w.err) wat2wasm error(s)"; head -2 /tmp/state_w2w.err | sed 's/^/      /'
fi

hr
echo "  THE CURSOR is the first un-checked item in ~/.claude/plans/composed-questing-feather.md §6."
echo "  Trust THIS output over any prose. Observe before theorizing. Trace to bedrock before acting."
hr; echo
