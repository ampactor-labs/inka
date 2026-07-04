#!/usr/bin/env bash
# bootstrap-survey.sh — per-file failure-shape categorization.
#
# RETIRED-ERA framing: this per-module VALIDATES survey predates the current
# bootstrap reality, where the seed compiles the WHOLE wheel to m2 in one pass
# and the live gate is the rung battery (tools/march-gate.sh), not a per-file
# standalone-compile triage. The mechanism still works as an ad-hoc per-file
# probe; the workflow it once drove (BT.A.0/A.1/A.2, link.py) is archaeology,
# and link.py never landed.
#
# Runs the seed compiler (bootstrap/mentl.wasm) against each src/*.mn
# + lib/**/*.mn file. Categorizes each file's failure shape:
#
#   VALIDATES        — output passes wat2wasm + wasm-validate cleanly;
#                       module compiles standalone
#   PARSE-INCOMPLETE — output references undefined locals from import-
#                       identifier handling
#   WAT-MALFORMED    — wat2wasm rejects on syntactic grounds beyond imports
#   CROSS-MODULE-REF — wat2wasm accepts; wasm-validate rejects on missing
#                       function/symbol references to sibling modules
#   STDIN-EMPTY-OUT  — seed produced no output (stdin issue or seed crash)
#   SEED-CRASH       — wasmtime exited non-zero (seed itself trapped)
#
# Output: TSV summary on stdout — file<TAB>line_count<TAB>category<TAB>note
#
# The output is a per-file seed probe, read category by category; the live
# gate over the whole wheel is the m2 rung battery (tools/march-gate.sh).

set -uo pipefail
cd "$(dirname "$0")/.."
source "$(dirname "$0")/wt-env.sh"   # wt_run, wt_asm, wt_validate — the one home

SEED="bootstrap/mentl.wasm"
if [[ ! -f "$SEED" ]]; then
  echo "ERROR: seed compiler not found at $SEED" >&2
  echo "  run: bash bootstrap/build.sh" >&2
  exit 2
fi

TMPDIR="$(mktemp -d -t bootstrap-survey.XXXXXX)"
trap "rm -rf $TMPDIR" EXIT

categorize_file() {
  local nx_file="$1"
  local out_wat="$TMPDIR/$(basename "$nx_file" .mn).wat"
  local out_wasm="$TMPDIR/$(basename "$nx_file" .mn).wasm"
  local stderr_log="$TMPDIR/$(basename "$nx_file" .mn).stderr"

  # Run seed; capture stdout to .wat + stderr separately
  if ! cat "$nx_file" | wt_run "$SEED" > "$out_wat" 2> "$stderr_log"; then
    echo "SEED-CRASH:exited non-zero ($(head -1 "$stderr_log" | head -c 80))"
    return
  fi

  if [[ ! -s "$out_wat" ]]; then
    echo "STDIN-EMPTY-OUT:no output produced"
    return
  fi

  local line_count
  line_count="$(wc -l < "$out_wat")"

  # Try to assemble; categorize per failure shape
  local wat2wasm_log="$TMPDIR/$(basename "$nx_file" .mn).wat2wasm.log"
  if wt_asm "$out_wat" "$out_wasm" \
       2> "$wat2wasm_log"; then
    # wat2wasm succeeded; try wasm-validate
    local validate_log="$TMPDIR/$(basename "$nx_file" .mn).validate.log"
    if wt_validate "$out_wasm" 2> "$validate_log"; then
      echo "VALIDATES:$line_count lines"
    else
      local first_err
      first_err="$(head -1 "$validate_log" | head -c 100)"
      echo "CROSS-MODULE-REF:$line_count lines; $first_err"
    fi
  else
    # wat2wasm failed; categorize the error
    local first_err
    first_err="$(head -1 "$wat2wasm_log" | head -c 100)"
    if grep -qE 'undefined local variable|undefined variable' "$wat2wasm_log"; then
      echo "PARSE-INCOMPLETE:$line_count lines; $first_err"
    else
      echo "WAT-MALFORMED:$line_count lines; $first_err"
    fi
  fi
}

# Find all .mn files in src/ + lib/ (sorted for determinism)
nx_files=()
while IFS= read -r f; do
  nx_files+=("$f")
done < <(find src lib -name '*.mn' -type f 2>/dev/null | sort)

if [[ ${#nx_files[@]} -eq 0 ]]; then
  echo "ERROR: no .mn files found under src/ or lib/" >&2
  exit 2
fi

# Header
printf 'file\tlines\tcategory\tnote\n'

# Categorize each
declare -A category_counts
for nx_file in "${nx_files[@]}"; do
  result="$(categorize_file "$nx_file")"
  category="${result%%:*}"
  note="${result#*:}"

  # Source line count (the input)
  src_lines="$(wc -l < "$nx_file")"

  printf '%s\t%s\t%s\t%s\n' "$nx_file" "$src_lines" "$category" "$note"

  category_counts[$category]=$((${category_counts[$category]:-0} + 1))
done

# Summary on stderr (so stdout stays TSV-clean)
{
  echo ""
  echo "═══ Summary ══════════════════════════════════════════════════"
  for category in VALIDATES PARSE-INCOMPLETE WAT-MALFORMED CROSS-MODULE-REF STDIN-EMPTY-OUT SEED-CRASH; do
    count="${category_counts[$category]:-0}"
    if [[ $count -gt 0 ]]; then
      printf '%-20s %d files\n' "$category" "$count"
    fi
  done
  echo ""
  echo "Each non-VALIDATES category is a per-file seed probe; the live gate"
  echo "over the whole wheel is the m2 rung battery (tools/march-gate.sh),"
  echo "not this standalone-compile survey."
} >&2
