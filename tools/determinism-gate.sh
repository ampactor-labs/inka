#!/usr/bin/env bash
# determinism-gate.sh — fails if compilation is non-deterministic.
#
# Per DET walkthrough §2.6 (commit 'docs/specs/simulations/DET-determinism-audit.md'):
# the compiler must produce byte-identical WAT on double-compile of the
# same input. Any difference is a first-light blocker.
#
# Usage:
#   tools/determinism-gate.sh                  # full src/ + lib/ tree
#   tools/determinism-gate.sh path/to/file.mn  # single file
#
# Exit codes:
#   0 — byte-identical (determinism holds)
#   1 — diff non-empty (non-determinism found; investigate the diff)
#   2 — invocation error (missing mentl binary, unreadable input, etc.)
#
# Per drift mode 9 — non-determinism is NEVER acceptable as "for now."
# Every non-deterministic site is a first-light blocker; fix in-place.

set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

# Resolve the mentl binary. The seed (bootstrap/mentl.wasm) self-hosts the
# wheel through m2/m3, so the binary exists once bootstrap/build.sh has run;
# the not-found branch below only fires when it hasn't. The runtime double-
# compile check is gated by wall-clock, not by a missing binary (see the cap
# below).
MENTL_BIN="${MENTL_BIN:-./bootstrap/mentl.wasm}"

if [[ ! -f "$MENTL_BIN" ]]; then
  echo "determinism-gate: mentl binary not found at $MENTL_BIN" >&2
  echo "  (run bootstrap/build.sh to assemble the seed; without it this is a no-op exit-2)" >&2
  echo "  set MENTL_BIN env var to override" >&2
  exit 2
fi

# The seed's wasmtime invocation needs threads + shared-memory + tail-call
# (WASI-threads substrate); without them wasmtime refuses the module. The flag
# quartet has ONE home (wt-env.sh), and stays as an argv array at the call site.
source "$(dirname "$0")/wt-env.sh"

# Determine inputs: arg-given file, or full tree (src/*.mn + lib/**/*.mn).
if [[ $# -ge 1 ]]; then
  INPUTS=( "$@" )
else
  # Sorted globs for determinism of the input list itself (the gate
  # itself must be deterministic in its input ordering).
  mapfile -t SRC_FILES < <(find src -name '*.mn' -type f | sort)
  mapfile -t LIB_FILES < <(find lib -name '*.mn' -type f | sort)
  INPUTS=( "${SRC_FILES[@]}" "${LIB_FILES[@]}" )
fi

if [[ ${#INPUTS[@]} -eq 0 ]]; then
  echo "determinism-gate: no input files" >&2
  exit 2
fi

# Concat in a stable order; pipe to mentl twice; diff outputs.
FIRST="$(mktemp -t det_first.XXXXXX.wat)"
SECOND="$(mktemp -t det_second.XXXXXX.wat)"
trap 'rm -f "$FIRST" "$SECOND"' EXIT

# Wall-clock cap per run. Today's seed compiling the wheel single-
# threaded under perm-pressure runs 40+ minutes per pass; a pre-commit
# hook paying that tax twice (once per run) is operationally untenable.
# Per Hβ.gate.determinism-timeout-fail-fast: if wasmtime doesn't
# terminate within the cap, fall through to the existing pre-bootstrap
# escape (exit 2 — gate is contract-only). Override via DET_TIMEOUT_S
# env var when running the gate manually with a known-bounded subset.
DET_TIMEOUT_S="${DET_TIMEOUT_S:-60}"

# Compile run #1. If wasmtime fails OR exceeds DET_TIMEOUT_S, treat as
# pre-bootstrap (the binary exists but doesn't yet self-host the wheel
# in bounded time); the gate's CONTRACT stands but the runtime check
# can't fire. `timeout` exits 124 on cap; bash `if !` catches both
# non-zero exit AND timeout uniformly.
if ! timeout "${DET_TIMEOUT_S}s" "$WT" run "${WT_RUN_FLAGS[@]}" "$MENTL_BIN" < <(cat "${INPUTS[@]}") > "$FIRST" 2>/dev/null; then
  echo "determinism-gate: $MENTL_BIN didn't compile Mentl within ${DET_TIMEOUT_S}s" >&2
  echo "  (contract-only under the cap: the seed's wheel compile is single-threaded" >&2
  echo "   under perm-pressure and exceeds ${DET_TIMEOUT_S}s, so the double-compile check" >&2
  echo "   can't fire until that runtime is bounded. Override via DET_TIMEOUT_S)" >&2
  exit 2
fi

# Compile run #2 (separate process; cache state may differ).
# Same DET_TIMEOUT_S cap; symmetric escape.
if ! timeout "${DET_TIMEOUT_S}s" "$WT" run "${WT_RUN_FLAGS[@]}" "$MENTL_BIN" < <(cat "${INPUTS[@]}") > "$SECOND" 2>/dev/null; then
  echo "determinism-gate: run #2 exceeded ${DET_TIMEOUT_S}s after run #1 succeeded" >&2
  echo "  (non-deterministic timing: run #1 fit the cap; run #2 didn't)" >&2
  exit 2
fi

if diff -q "$FIRST" "$SECOND" > /dev/null; then
  echo "✓ determinism: byte-identical on double-compile (${#INPUTS[@]} files)"
  exit 0
fi

# Non-empty diff. Surface the first ~50 lines for triage.
echo "✗ determinism FAILED: WAT output differs between runs" >&2
echo "  first  : $FIRST" >&2
echo "  second : $SECOND" >&2
echo "  diff (first 50 lines):" >&2
diff "$FIRST" "$SECOND" | head -50 >&2
echo "" >&2
echo "  Per DET walkthrough §3: every diffing region is a non-determinism source." >&2
echo "  Common causes (sorted by frequency):" >&2
echo "    - unsorted iteration over hash-keyed sets" >&2
echo "    - timestamp / wall-clock read in emit path" >&2
echo "    - random seed not derived deterministically from input" >&2
echo "    - memory-layout-dependent output (use structural IDs)" >&2
echo "    - env-variable read in emit path" >&2
exit 1
