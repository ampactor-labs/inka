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
source "$(dirname "$0")/wt-env.sh"   # WT, WT_RUN_FLAGS, W2W — the one home
WTRUN="$WT run ${WT_RUN_FLAGS[*]}"
QUICK="${1:-}"
# Intermediates + wasmtime's temp belong on disk, NOT the RAM-backed tmpfs
# (/tmp is a ~6G quota; the wheel WAT + wasmtime's ~2G shared-memory partition
# exhaust it per multi-pass run). A luks-backed build dir dissolves the
# recurring EDQUOT — regenerable artifacts on the 99G disk, never the quota.
B="${MENTL_BUILD:-$PWD/.build}"; mkdir -p "$B"; export TMPDIR="$B"
hr() { printf '─%.0s' {1..72}; echo; }

echo
hr; echo "  MENTL GROUND TRUTH — $(date -u '+%Y-%m-%d %H:%M:%SZ')"; hr

echo "▸ TREE"
git log --oneline -3 | sed 's/^/    /'
sc=$(git status --short); echo "    uncommitted: $([ -z "$sc" ] && echo none || echo "$(echo "$sc" | wc -l) file(s)")"
[ -n "$sc" ] && echo "$sc" | sed 's/^/      /'

echo "▸ SEED"
if bash bootstrap/build.sh >$B/state_build.log 2>&1; then
  echo "    build: OK ($(grep -oE 'mentl.wasm \([0-9]+ bytes\)' $B/state_build.log | tail -1))"
else
  echo "    build: ✗ FAILED — see $B/state_build.log"; tail -3 $B/state_build.log | sed 's/^/      /'; exit 1
fi

echo "▸ WHEEL CENSUS  (seed compiles the wheel source; fewer diagnostics is better — the PASS-2 trap below is the real gate, not this count)"
{ find src -name '*.mn' | sort | xargs cat; \
  find lib -name '*.mn' -not -path '*/tutorial/*' | sort | xargs cat; } > $B/state_wheel.mn
if $WTRUN bootstrap/mentl.wasm < $B/state_wheel.mn > $B/state_m2.wat 2>$B/state_m2.err; then
  total=$(grep -cE '^[EPW]_[A-Za-z]+' $B/state_m2.err)
  echo "    seed compiles wheel: OK   m2.wat = $(wc -l < $B/state_m2.wat) lines   diagnostics = $total"
  grep -oE '^[EPW]_[A-Za-z]+' $B/state_m2.err | sort | uniq -c | sort -rn | head -6 | sed 's/^/      /'
else
  echo "    seed compiles wheel: ✗ TRAP — see $B/state_m2.err"; tail -3 $B/state_m2.err | sed 's/^/      /'
fi

echo "▸ MICRO BATTERY  (gates the seed; each exit code captured directly)"
# Runtime-dependent micros need the trio. Two real deps the lower emits CALLS to
# but whose bodies live in the lib (not the seed): string micros (eq/interp) call
# str_concat/str_eq; handler-dispatch micros (ev*) call ev_lookup — the keyed-
# evidence scan (runtime/memory.mn), the identity-key dispatch the keying lowers
# to. A call without its def is an assembly-time lie, not a regression. Pass the
# libs (marker `rt`) so the tool tells the truth.
RTLIBS="lib/runtime/memory.mn lib/runtime/strings.mn lib/runtime/lists.mn"
for spec in "ev2 57 rt" "ev4 57 rt" "ev8 57 rt" "ev5 21 rt" "ev16 18 rt" "eq 73 rt" "interp 59 rt"; do
  set -- $spec; m=$1; want=$2; needrt="${3:-}"; f="tests/micros/mn-$m.mn"
  [ -f "$f" ] || { printf "      %-7s (no file)\n" "$m"; continue; }
  if [ "$needrt" = "rt" ]; then
    out=$(tools/run-micro.sh "$f" "$want" $RTLIBS 2>/dev/null | tail -1)
  else
    out=$(tools/run-micro.sh "$f" "$want" 2>/dev/null | tail -1)
  fi
  printf "      %-7s want=%-3s  %s\n" "$m" "$want" "$out"
done

if [ "$QUICK" = "--quick" ]; then hr; echo "  (--quick: two-pass skipped)"; hr; echo; exit 0; fi

echo "▸ PASS-2  (the FIXED POINT: m3 == m4, the medium reproduced BY ITSELF — NOT m2==m3)"
echo "    m2 is the wheel compiled by the DISPOSABLE seed; its bytes are the seed's, not the wheel's."
echo "    First-light = diff(m3,m4) empty AND correctness (the micros above green). m2 may differ from m3."
if "${W2W[@]}" $B/state_m2.wat -o $B/state_m2.wasm 2>$B/state_w2w.err; then
  echo "    m2.wat assembles: OK"
  # CAP: a sane m3/m4 is a few MB; cap at 500MB so a wat-emission RUNAWAY
  # (the emit corruption dumps 150GB) is FLAGGED, not written to disk. The
  # wasmtime exit is read via PIPESTATUS (head closing the pipe = SIGPIPE only
  # happens when the cap is hit, which the size check catches first).
  CAP=524288000
  timeout 300 $WTRUN $B/state_m2.wasm < $B/state_wheel.mn 2>$B/state_m3.err | head -c $CAP > $B/state_m3.wat
  m2rc=${PIPESTATUS[0]}; m3sz=$(wc -c < $B/state_m3.wat)
  if [ "$m3sz" -ge "$CAP" ]; then
    echo "    *** m2 EMIT RUNAWAY — m3 hit the $((CAP/1048576))MB cap (wat-emission corruption; NOT a clean compile). ***"
  elif [ "$m2rc" -eq 0 ]; then
    echo "    m2 → m3.wat = $(wc -l < $B/state_m3.wat) lines  (m2==m3 is NOT the check; m2's bytes are disposable)"
    if "${W2W[@]}" $B/state_m3.wat -o $B/state_m3.wasm 2>$B/state_w3w.err; then
      echo "    m3.wat assembles: OK"
      timeout 300 $WTRUN $B/state_m3.wasm < $B/state_wheel.mn 2>$B/state_m4.err | head -c $CAP > $B/state_m4.wat
      m3rc=${PIPESTATUS[0]}; m4sz=$(wc -c < $B/state_m4.wat)
      if [ "$m4sz" -ge "$CAP" ]; then
        echo "    *** m3 EMIT RUNAWAY — m4 hit the cap. ***"
      elif [ "$m3rc" -eq 0 ]; then
        if diff -q $B/state_m3.wat $B/state_m4.wat >/dev/null 2>&1; then
          echo "    *** m3 == m4 — FIXED POINT REACHED. FIRST LIGHT at correctness (micros above MUST be green). ***"
        else
          echo "    m3 → m4.wat = $(wc -l < $B/state_m4.wat) lines; diff(m3,m4) = $(diff $B/state_m3.wat $B/state_m4.wat | wc -l) lines  (not yet fixpoint — the change is still propagating)"
        fi
      else
        echo "    m3 TRAPPED compiling the wheel — fixpoint blocked (m2 produced a buggy m3; m2 is not yet a CORRECT compiler)."
        echo "    ─ WASM TRAP + backtrace (innermost first — THIS is the cursor):"
        grep -E '<unknown>!|wasm trap:|memory fault|error while executing' $B/state_m4.err | tail -20 | sed 's/^/      /'
      fi
    else
      echo "    m3.wat assembles: ✗ $(wc -l < $B/state_w3w.err) wat2wasm error(s)"; head -2 $B/state_w3w.err | sed 's/^/      /'
    fi
  else
    echo "    mentl2 TRAPPED compiling the wheel (exit) — pass-2 blocked (the seed did not spark a correct m2)."
    echo "    ─ WASM TRAP + backtrace (innermost first — THIS is the cursor):"
    grep -E '<unknown>!|wasm trap:|memory fault|error while executing' $B/state_m3.err | tail -20 | sed 's/^/      /'
    echo "    ─ diagnostics emitted before the trap: $(grep -cE '^[EPW]_|^parser:' $B/state_m3.err)  (P_UnexpectedToken: $(grep -c 'P_UnexpectedToken' $B/state_m3.err))"
  fi
else
  echo "    m2.wat assembles: ✗ $(wc -l < $B/state_w2w.err) wat2wasm error(s)"; head -2 $B/state_w2w.err | sed 's/^/      /'
fi

hr
echo "  THE CURSOR is the first un-checked item in ~/.claude/plans/composed-questing-feather.md §6."
echo "  Trust THIS output over any prose. Observe before theorizing. Trace to bedrock before acting."
hr; echo
