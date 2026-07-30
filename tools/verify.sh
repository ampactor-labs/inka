#!/usr/bin/env bash
# tools/verify.sh — the Mentl gate (proto-`mentl check`).
#
# Boot-era gate: the micro battery compiles-and-runs green through the pinned
# fixpoint wheel (boot/mentl.wasm), plus the census RATCHET — the medium's own
# verdict on its own source, which may never get worse (§3 below carries the
# re-founding). Green is STAMPED on wt_state_key, so re-runs on an unchanged
# tree (above all the pre-commit hook) answer instantly; FORCE_VERIFY=1 re-runs.
#
# Usage: tools/verify.sh
# Exit:  0 thesis holds, 1 thesis violated, 2 invocation error.
set -uo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

BASELINE="tools/verify-baseline.txt"
source "$ROOT/tools/wt-env.sh"   # WT, WT_RUN_FLAGS, W2W — the one home
# The runtime trio IS the vocabulary every real .mn program reaches for, so
# a micro compiled WITHOUT it is the abnormal case, not the default. Link it for
# every micro: a micro that calls str_concat/str_eq (strings) or ev_lookup (the
# keyed-evidence dispatch scan, runtime/memory.mn) gets its def; one that uses
# neither pays nothing (reachability-from-main drops the unused). A micro failing
# only because the vocabulary was withheld is the harness lying, not a regression.
RTLIBS=(lib/runtime/memory.mn lib/runtime/strings.mn lib/runtime/lists.mn lib/prelude.mn)

say() { printf '%s\n' "$*"; }
fail=0

[[ -f "$BASELINE" ]] || { say "verify: baseline missing: $BASELINE"; exit 2; }
[[ -x "$WT" ]] || { say "verify: wasmtime not found at $WT (set WASMTIME_BIN)"; exit 2; }

# ── the GREEN STAMP — verify is idempotent on an unchanged tree ─────────────
# The verdict is a pure function of the gate-relevant state (wt_state_key:
# wheel sources + boot + micros + the gate scripts). A green run stamps that
# key; a re-run — above all the pre-commit hook, seconds after a green — answers
# from the stamp instead of re-paying the ~15-minute gate it just watched pass
# (the IC principle: the oracle is incremental computation plus one cached
# value). FORCE_VERIFY=1 re-runs regardless. The flock serializes concurrent
# gates — the second waits, re-checks the stamp, and usually exits instantly.
GATE_DIR=".build/gate"; GATE_STAMP="$GATE_DIR/verify.green"
STATE_KEY=$(wt_state_key)
if [[ "${FORCE_VERIFY:-0}" != 1 && "$(cat "$GATE_STAMP" 2>/dev/null)" == "$STATE_KEY" ]]; then
  say "verify: cached green — gate state unchanged since the last full run"
  say "        (stamp $GATE_STAMP; FORCE_VERIFY=1 re-runs the battery)"
  exit 0
fi
mkdir -p "$GATE_DIR"; exec 8>"$GATE_DIR/lock"; flock 8
if [[ "${FORCE_VERIFY:-0}" != 1 && "$(cat "$GATE_STAMP" 2>/dev/null)" == "$STATE_KEY" ]]; then
  say "verify: cached green (a concurrent gate finished while this one waited)"
  exit 0
fi

# 1. The compiler exists: the pinned fixpoint wheel (boot/ — first light
#    2026-07-10; boot/PROVENANCE.md). The hand-WAT seed is DELETED (7401c4b);
#    the cold-ladder recipe lives at tag first-light (band J archaeology).
BOOT="boot/mentl.wasm"
[[ -f "$BOOT" ]] || { say "verify: compiler missing: $BOOT"; exit 2; }
export MENTL_BOOT="$BOOT"
say "✓ compiler: $BOOT"

# 2. Micro battery — each micro DECLARES its own expected exit as its first
#    comment (`// expect: N`): the expectation lives ON the artifact it gates
#    (a comment is graph content, SYNTAX §Comments — the medium reads its own
#    gate), never in a side-table. A micro without the header is skipped
#    loudly (a gate that cannot fail is no gate).
for mf in tests/micros/mn-*.mn; do
  m=$(basename "$mf" .mn); m=${m#mn-}
  # A refuse contract (`// expect: refuse E_Class`) is the MEDIUM's to
  # judge — `mentl test tests/micros` asserts it in-process (the Expect
  # ADT); this bash loop keeps only the run-value executions, and its
  # responsibility SHRINKS as contracts absorb (the dissolution ratchet).
  if sed -n '1p' "$mf" | grep -q '^// expect: refuse '; then
    say "· micro $m: refuse contract — judged by mentl test"
    continue
  fi
  want=$(sed -n '1s|^// expect: \([0-9]\+\)$|\1|p' "$mf")
  if [[ -z "$want" ]]; then say "✗ micro $m: no '// expect: N' header"; fail=1; continue; fi
  out=$(tools/run-micro.sh "$mf" "$want" "${RTLIBS[@]}" 2>/dev/null | tail -1)
  if [[ "$out" == PASS* ]]; then say "✓ micro $m=$want"; else say "✗ micro $m: ${out:-no output}"; fail=1; fi
done

# 2b. The contract battery — the medium enforcing every fixture's own
#     contract (run AND refuse grammars) in one process. A FAILC / FAILR /
#     NOEXPECT line is a broken contract; the run-values above stay the
#     exec-side check until the exec seam itself absorbs.
if command -v mentl >/dev/null 2>&1; then
  bat=$(cd "$ROOT" && mentl test tests/micros 2>/dev/null | grep -cE '^(FAILC|FAILR|NOEXPECT) ' || true)
  if [[ "$bat" -eq 0 ]]; then
    say "✓ contract battery: every fixture's own contract holds (mentl test)"
  else
    say "✗ contract battery: $bat broken contract(s) — run: mentl test tests/micros"
    fail=1
  fi
else
  say "· contract battery skipped (no installed mentl — tools/install.sh)"
fi

# 3. The census — the medium's own verdict on its own source, RATCHETED.
#
#    Its meaning INVERTED at first light and the prose did not follow for six
#    days. The old justification (baseline, 2026-06-22): "a SHADOW, reported
#    not enforced ... the disposable seed's weaker inference lags, so a rising
#    count is the seed catching up to the wheel, expected progress" — and
#    "census_max no longer exists; it is read by nothing". THE SEED WAS DELETED
#    (7401c4b, 2026-07-10). boot IS the wheel. So m2.err is not a seed's shadow
#    of the wheel; it is the WHEEL's diagnostics about the WHEEL's OWN SOURCE —
#    every line a claim the medium makes about itself and does not believe.
#    Filed under the expired justification, that number hid a real dead-code bug
#    for six days: format.mn matched `NPipeExpr`, a constructor declared nowhere
#    (the real one is `PipeExpr`, types.mn:917), so format_chain's five arms
#    never matched and every chain fell to the `_` catch-all. The compiler said
#    so, exactly, with a span, six times.
#
#    So the census RATCHETS: errors may never RISE. This is the transport toward
#    the refusal law (PLAN §11), not its replacement — the endpoint is `mentl
#    check` on the wheel exiting 0, at which point emit can refuse on any error
#    and this counter DISSOLVES (§6's scaffold tier: it exists to be deleted).
#    Warnings are reported, not ratcheted: they are the format-lift backlog, and
#    the formatter erases them by construction.
#    Reads the ONE keyed boot(wheel) artifact (wt_m2_ensure — shared with
#    march/march-gate, .build/m2cache).
if C=$(wt_m2_ensure); then
  errors=$(grep -cE '(^|: )E_[A-Za-z_]+ error: ' "$C/m2.err")    # the wheel prefixes stages ('infer: E_…')
  warns=$(grep -cE '(^|: )(E_|W_|P_)[A-Za-z_]+ Warning: ' "$C/m2.err")
  max=$(grep -E '^census_errors_max:' "$BASELINE" | head -1 | cut -d: -f2 | tr -d ' ')
  say "· census: $errors errors / $warns warnings — the medium's own verdict on its own source"
  if [[ -n "$max" && "$errors" -gt "$max" ]]; then
    say "✗ census RATCHET: errors rose $max -> $errors. Every one is a claim the medium"
    say "  makes about its own source and does not believe. Fix them, or — if the rise is"
    say "  real and understood — raise census_errors_max in $BASELINE with the reason."
    fail=1
  elif [[ -n "$max" && "$errors" -lt "$max" ]]; then
    say "  ↓ census FELL $max -> $errors — lower census_errors_max in $BASELINE to hold it."
  fi
  # The comment-reference ratchet — the SAME stderr, one layer up: every
  # backticked identifier in a comment is a REFERENCE the medium resolves at
  # the infer tail (W_CommentRefUnresolved, SYNTAX §Comments). This absorbed
  # tools/comment-audit.sh + comment-ratchet.sh whole: the medium is the
  # classifier now, and the count rides the census compile — zero extra passes.
  crefs=$(grep -cE 'W_CommentRefUnresolved' "$C/m2.err")
  cmax=$(grep -E '^comment_refs_max:' "$BASELINE" | head -1 | cut -d: -f2 | tr -d ' ')
  say "· comment-refs: $crefs unresolved — the medium's verdict on its own prose"
  if [[ -n "$cmax" && "$crefs" -gt "$cmax" ]]; then
    say "✗ comment-ref RATCHET: unresolved references rose $cmax -> $crefs. A backticked"
    say "  name is a claim; fix the reference or write prose without backticks."
    fail=1
  elif [[ -n "$cmax" && "$crefs" -lt "$cmax" ]]; then
    say "  ↓ comment-refs FELL $cmax -> $crefs — lower comment_refs_max in $BASELINE to hold it."
  fi
  # The manifest gate — the wheel's own DAG judgment, zero-tolerance. The
  # blob census is structurally BLIND to a missing import edge (every name
  # resolves in the concatenation), and the class sat silent five days
  # until a felt walk found canon.mn imported by NOBODY — ty_string
  # starving every check/at/field invocation while the march stayed green.
  # One ~2.5s judgment of the entry's import closure holds it at zero:
  # a name whose defining module is in nobody's closure surfaces here as
  # E_MissingVariable. Per-module import PRECISION (a name used by M,
  # defined in a module M never imports but another module's closure
  # carries) needs env-entry module attribution — the named deeper
  # instrument.
  mmiss=$(wt_run --dir . "$C/m2.wasm" check src/main.mn 2>&1 >/dev/null | grep -cE 'E_MissingVariable' || true)
  say "· manifest: $mmiss missing name(s) on the wheel's own DAG judgment"
  if [[ "$mmiss" -gt 0 ]]; then
    say "✗ MANIFEST: a name resolves in the blob but not the import DAG — a module"
    say "  is missing an import edge (the canon.mn class). Probe: mentl check src/main.mn"
    fail=1
  fi
else
  say "✗ compiler TRAPPED compiling the wheel (tail $WT_M2CACHE/m2.err):"; tail -3 "$WT_M2CACHE/m2.err"; fail=1
fi

# 5. Doc-truth — the docs' claims that CAN be checked against the artifact
#    ARE (pin shas, ledger pins, named commands). Prose drifts; this is the
#    mechanical floor under it (tools/doc-truth.sh; dissolves into
#    docs-as-projection + mentl audit).
if ! bash tools/doc-truth.sh >/dev/null 2>&1; then
  say "✗ doc-truth: a doc claims what the artifact refutes —"
  bash tools/doc-truth.sh 2>&1 | sed 's/^/  /'
  fail=1
else
  say "· doc-truth: pin shas, ledger pins, and named commands verify against the artifact"
fi

if [[ "$fail" -ne 0 ]]; then
  say ""
  say "verify: the gate failed — a micro regressed, the wheel did not compile, or the"
  say "census ratchet caught the medium making more claims about itself that it does"
  say "not believe. Fix it (carry the handle, read live; rewrite in residue form)."
  exit 1
fi
say "verify: thesis invariants hold."
# Stamp the green — keyed on the state captured at ENTRY, so an edit made
# while the battery ran invalidates (the next run sees a different key).
printf '%s' "$STATE_KEY" > "$GATE_STAMP"
say "· stamped $GATE_STAMP (re-runs on this exact state answer instantly)"
exit 0
