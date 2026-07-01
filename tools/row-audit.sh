#!/usr/bin/env bash
# row-audit.sh — the row-conservation audit. Proto-`mentl audit --rows`.
#
# The effect row is a ledger: `perform` raises a name, the shape-verbs
# (|> <| ><) union it, `~>` is the only discharge. A name that is forwarded
# or performed yet never accumulated into its fn's row is a LEAK — masked
# today by lower_compute_ev_index_for_effect's silent slot-0 clamp, made
# audible by its proto-W_RowLeak emission (`<fn>_<effect>` per line on stderr,
# uncounted by the diagnostic census).
#
# This is the L1 effect-polymorphism metric: every higher-order call / handler
# arm that loses its argument's effect is one leak. Drive it to 0 and pass-2
# unblocks. A quiet wheel == complete rows.
#
# Usage: tools/row-audit.sh            # audit the whole wheel
#        tools/row-audit.sh <file.mn>  # audit one source (+ the libs)
set -u
SEED="bootstrap/mentl.wasm"
source "$(dirname "$0")/wt-env.sh"   # wt_run — the one home
SRC="${1:-}"
if [ -n "$SRC" ]; then
  { find lib -name '*.mn' -not -path '*/tutorial/*' | sort | xargs cat; cat "$SRC"; } > /tmp/row-audit.mn
else
  { find src -name '*.mn' | sort | xargs cat; \
    find lib -name '*.mn' -not -path '*/tutorial/*' | sort | xargs cat; } > /tmp/row-audit.mn
fi
wt_run "$SEED" < /tmp/row-audit.mn > /dev/null 2>/tmp/row-audit.err

# A leak line is `<fn>_<Effect>` (fn lowercase_underscored, Effect Capitalized),
# alone on the line. Builtin effects (WASI/Memory/Alloc) carry no ev-slot — a
# forwarded builtin slot is never read, so exclude them (not a real leak).
grep -oE '^[a-z_0-9]+_[A-Z][A-Za-z0-9]*$' /tmp/row-audit.err \
  | grep -vE '_(WASI|Memory|Alloc)$' | sort -u > /tmp/row-audit.leaks
N=$(wc -l < /tmp/row-audit.leaks)
echo "row-conservation leaks (distinct fn,effect pairs): $N"
echo "── by effect (the names losing their home) ──"
sed -E 's/.*_([A-Z][A-Za-z0-9]*)$/\1/' /tmp/row-audit.leaks | sort | uniq -c | sort -rn | head -20
echo "── sample leaking fns (full list: /tmp/row-audit.leaks) ──"
head -15 /tmp/row-audit.leaks
