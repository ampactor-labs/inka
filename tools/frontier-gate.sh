#!/usr/bin/env bash
# Focused contracts for the executable-boundary and constrained-hole frontier.
# These are real assertions, not xfails: the command exits nonzero while any
# contract is red. Keep separate from verify.sh until the whole board is green.
set -uo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT" || exit 2
source "$ROOT/tools/wt-env.sh"

usage() {
  cat <<'EOF'
usage: tools/frontier-gate.sh [--compiler boot|fresh|both|PATH]

  boot   pinned boot/mentl.wasm (default)
  fresh  current wheel-emitted compiler from wt_m2_ensure
  both   run boot, then fresh
  PATH   run one explicit compiler artifact
EOF
}

selection=boot
while [ "$#" -gt 0 ]; do
  case "$1" in
    --compiler)
      [ "$#" -ge 2 ] || { usage >&2; exit 2; }
      selection="$2"
      shift 2
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "frontier: unknown argument: $1" >&2
      usage >&2
      exit 2
      ;;
  esac
done

compilers=()
labels=()
add_compiler() {
  labels+=("$1")
  compilers+=("$2")
}

case "$selection" in
  boot)
    add_compiler boot "$ROOT/boot/mentl.wasm"
    ;;
  fresh)
    cache=$(wt_m2_ensure) || { echo "frontier: fresh compiler generation trapped" >&2; exit 2; }
    add_compiler fresh "$ROOT/$cache/m2.wasm"
    ;;
  both)
    add_compiler boot "$ROOT/boot/mentl.wasm"
    cache=$(wt_m2_ensure) || { echo "frontier: fresh compiler generation trapped" >&2; exit 2; }
    add_compiler fresh "$ROOT/$cache/m2.wasm"
    ;;
  *)
    [ -f "$selection" ] || { echo "frontier: compiler not found: $selection" >&2; exit 2; }
    case "$selection" in
      /*) compiler_path="$selection" ;;
      *)  compiler_path="$ROOT/$selection" ;;
    esac
    add_compiler explicit "$compiler_path"
    ;;
esac

RTLIBS=(
  "$ROOT/lib/runtime/memory.mn"
  "$ROOT/lib/runtime/strings.mn"
  "$ROOT/lib/runtime/lists.mn"
  "$ROOT/lib/runtime/threading.mn"
  "$ROOT/lib/prelude.mn"
)

# The persist fixture additionally needs the WASI fs layer and the Persist
# handler itself; its runs preopen /tmp for the checkpoint files.
PERSIST_RTLIBS=(
  "${RTLIBS[@]}"
  "$ROOT/lib/runtime/io.mn"
  "$ROOT/lib/runtime/persist.mn"
)

total_pass=0
total_fail=0
RUNTIME_SHADOW=""
BOOT_RUNTIME_SHADOW=""
# 2026-07-17: repinned after Stage 1b removed check_ref_escape. The runtime libs
# shed their "escapes its scope (returned)" false alarms (a syntactic check with
# no hazard model, 356 across the wheel), so the inherited-debt multiset SHRANK —
# a removal, which the rule above explicitly permits. Verified by reading the new
# shadow: the same E_TypeMismatch/E_RedundantBraces set minus the ownership false
# positives, never a NEW entry.
#
# 2026-07-18: repinned for the bounds-trap landing — lists.mn gained the checked
# list_index entry + list_index_unchecked (SYNTAX §Indexing made real), and
# strings.mn/cache_map.mn spell their guarded reads as control flow (sound
# under both the old eager `&&` and the short-circuit lowering). The shadow's
# byte change is those three files; the diagnostic multiset did not grow.
EXPECTED_RUNTIME_SHADOW_SHA256="d55cc4af23d0305e9f1c7c9cce2d0e658ef411179ec1b61affe91d4304ddfd70"

pass() {
  echo "  PASS $*"
  total_pass=$((total_pass + 1))
}

fail() {
  echo "  RED  $*"
  total_fail=$((total_fail + 1))
}

# Normalize only compiler errors and unresolved proof obligations. Runtime
# sources currently carry a known diagnostic shadow; comparing this multiset
# keeps that debt explicit while refusing every diagnostic introduced by a
# frontier fixture. Messages and graph epochs are deliberately omitted, but
# source spans and duplicate counts remain part of the fingerprint.
normalize_errors() {
  awk '
    /E_[A-Za-z0-9_]+ error:|V_?Pending[A-Za-z0-9_]*/ {
      code = ""
      span = ""
      if (match($0, /E_[A-Za-z0-9_]+/)) {
        code = substr($0, RSTART, RLENGTH)
      } else if (match($0, /V_?Pending[A-Za-z0-9_]*/)) {
        code = substr($0, RSTART, RLENGTH)
      }
      if (match($0, / at [0-9]+:[0-9]+-[0-9]+:[0-9]+/)) {
        span = substr($0, RSTART, RLENGTH)
      }
      if (code != "") print code span
    }
  ' "$1" | LC_ALL=C sort
}

capture_runtime_shadow() {
  local compiler="$1" dir="$2"
  local wat="$dir/runtime-shadow.wat" err="$dir/runtime-shadow.err"

  { cat "${RTLIBS[@]}"; printf '\nfn main() = 0\n'; } \
    | wt_run "$compiler" > "$wat" 2> "$err"
  local rc=$?
  if [ "$rc" -ne 0 ]; then
    fail "runtime shadow compile (exit=$rc; see $err)"
    return 1
  fi

  RUNTIME_SHADOW="$dir/runtime-shadow.normalized"
  normalize_errors "$err" > "$RUNTIME_SHADOW"
  pass "runtime shadow captured ($(wc -l < "$RUNTIME_SHADOW") inherited errors)"
}

run_program() {
  local compiler="$1" label="$2" source="$3" expected="$4" link_runtime="$5"
  local dir="$6" wat="$dir/$label.wat" wasm="$dir/$label.wasm"
  local cerr="$dir/$label.compile.err" aerr="$dir/$label.assemble.err"
  local rout="$dir/$label.run.out" rerr="$dir/$label.run.err"
  local rc diags errors shadow="" normalized unexpected run_flags=()

  case "$link_runtime" in
    yes)
      cat "${RTLIBS[@]}" "$source" | wt_run "$compiler" > "$wat" 2> "$cerr" ;;
    persist)
      cat "${PERSIST_RTLIBS[@]}" "$source" | wt_run "$compiler" > "$wat" 2> "$cerr"
      run_flags=(--dir /tmp) ;;
    *)
      wt_run "$compiler" < "$source" > "$wat" 2> "$cerr" ;;
  esac
  rc=$?
  diags=$(grep -cE '(^|: )[EWVTP]_' "$cerr" 2>/dev/null || true)
  normalized="$dir/$label.normalized"
  unexpected="$dir/$label.unexpected"
  normalize_errors "$cerr" > "$normalized"
  if [ "$link_runtime" = yes ]; then
    comm -23 "$normalized" "$RUNTIME_SHADOW" > "$unexpected"
    shadow="; inherited-shadow=$(wc -l < "$RUNTIME_SHADOW")"
  elif [ "$link_runtime" = persist ]; then
    comm -23 "$normalized" "$PERSIST_SHADOW" > "$unexpected"
    shadow="; inherited-shadow=$(wc -l < "$PERSIST_SHADOW")"
  else
    cp "$normalized" "$unexpected"
  fi
  errors=$(wc -l < "$unexpected")
  if [ "$rc" -eq 0 ] && [ "$errors" -eq 0 ]; then
    pass "$label compile (diagnostics=$diags$shadow)"
  elif [ "$rc" -eq 0 ]; then
    fail "$label compile (new-errors-or-debt=$errors diagnostics=$diags; see $unexpected)"
  else
    fail "$label compile (exit=$rc diagnostics=$diags; see $cerr)"
    return
  fi

  if wt_asm "$wat" "$wasm" 2> "$aerr"; then
    pass "$label assemble"
  else
    fail "$label assemble ($(head -1 "$aerr"))"
    return
  fi

  wt_run "${run_flags[@]}" "$wasm" > "$rout" 2> "$rerr"
  rc=$?
  if [ "$rc" -eq "$expected" ]; then
    pass "$label run (exit=$rc)"
  else
    fail "$label run (exit=$rc expected=$expected; see $rerr)"
  fi
}

# An ARMED class's contract: the diagnostic fires AND the executable refuses —
# nonzero exit, ZERO WAT bytes (the refusal law, PLAN §11 col 2). run_diagnostic
# asserts the productive form (exit 0, diagnostics on stderr); an armed class's
# fixture moves HERE in the same commit that arms it.
run_refusal() {
  local compiler="$1" label="$2" source="$3" expected_code="$4" dir="$5"
  local wat="$dir/$label.wat" err="$dir/$label.compile.err"
  local rc count size

  wt_run "$compiler" < "$source" > "$wat" 2> "$err"
  rc=$?
  count=$(grep -c "$expected_code error:" "$err" 2>/dev/null || true)
  size=$(wc -c < "$wat" 2>/dev/null || echo 0)
  if [ "$rc" -ne 0 ] && [ "$count" -gt 0 ] && [ "$size" -eq 0 ]; then
    pass "$label refusal ($expected_code=$count exit=$rc wat=0B)"
  else
    fail "$label refusal (exit=$rc $expected_code=$count wat=${size}B; see $err)"
  fi
}

run_diagnostic() {
  local compiler="$1" label="$2" source="$3" expected_code="$4" dir="$5"
  local wat="$dir/$label.wat" err="$dir/$label.compile.err"
  local rc count other

  wt_run "$compiler" < "$source" > "$wat" 2> "$err"
  rc=$?
  count=$(grep -c "$expected_code error:" "$err" 2>/dev/null || true)
  other=$(grep -E 'E_[A-Za-z0-9_]+ error:' "$err" 2>/dev/null \
    | grep -vc "$expected_code error:" || true)
  if [ "$rc" -eq 0 ] && [ "$count" -gt 0 ] && [ "$other" -eq 0 ]; then
    pass "$label diagnostic ($expected_code=$count)"
  else
    fail "$label diagnostic (exit=$rc $expected_code=$count other-errors=$other; see $err)"
  fi
}

# Same differential accounting for the persist lib set: pin boot's shadow,
# per-compiler shadows may only shrink it.
capture_persist_shadow() {
  local compiler="$1" dir="$2"
  local wat="$dir/persist-shadow.wat" err="$dir/persist-shadow.err"

  { cat "${PERSIST_RTLIBS[@]}"; printf '\nfn main() = 0\n'; } \
    | wt_run "$compiler" > "$wat" 2> "$err"
  local rc=$?
  if [ "$rc" -ne 0 ]; then
    fail "persist shadow compile (exit=$rc; see $err)"
    return 1
  fi

  PERSIST_SHADOW="$dir/persist-shadow.normalized"
  normalize_errors "$err" > "$PERSIST_SHADOW"
  pass "persist shadow captured ($(wc -l < "$PERSIST_SHADOW") inherited errors)"
}

compile_fixture() {
  local compiler="$1" label="$2" source="$3" dir="$4"
  local wat="$dir/$label.input.wat" err="$dir/$label.input.err"
  local normalized="$dir/$label.input.normalized" rc errors

  wt_run "$compiler" < "$source" > "$wat" 2> "$err"
  rc=$?
  normalize_errors "$err" > "$normalized"
  errors=$(wc -l < "$normalized")
  if [ "$rc" -eq 0 ] && [ "$errors" -eq 0 ]; then
    pass "$label input check (no errors or proof debt)"
  else
    fail "$label input check (exit=$rc errors-or-debt=$errors; see $err)"
  fi
}

# A hole-bearing fixture's input form is PRODUCTIVE, never executable
# (SYNTAX §«Partial application»): the compile verb must REFUSE it honestly —
# E_UnresolvedHole, nonzero exit, ZERO WAT bytes. The edit workflow then
# fills the hole and the patched source compiles clean.
compile_hole_fixture() {
  local compiler="$1" label="$2" source="$3" dir="$4"
  local wat="$dir/$label.input.wat" err="$dir/$label.input.err" rc

  wt_run "$compiler" < "$source" > "$wat" 2> "$err"
  rc=$?
  if [ "$rc" -ne 0 ] && [ ! -s "$wat" ] && grep -q 'E_UnresolvedHole' "$err"; then
    pass "$label input refuses honestly (E_UnresolvedHole, nonzero, no WAT)"
  else
    fail "$label input did not refuse (exit=$rc wat=$(wc -c < "$wat")B; see $err)"
  fi
}

edit_fixture() {
  local compiler="$1" dir="$2" stem="$3" fixture="$4"
  EDIT_SCRATCH="$dir/$stem.mn"
  EDIT_TARGET="../${dir#$ROOT/}/$stem"
  EDIT_OUT="$dir/$stem.edit.out"
  EDIT_ERR="$dir/$stem.edit.err"

  cp "$fixture" "$EDIT_SCRATCH"

  # `edit` is a continuing session. Ten seconds is enough for its first
  # projection and one accepted action; timeout is not itself a failure if the
  # projection and patch both landed. The invocation reads all Wasmtime flags
  # from wt-env.sh, the same source as wt_run.
  printf 'y\n' | timeout 10 "$WT" run "${WT_RUN_FLAGS[@]}" --dir "$ROOT" \
    "$compiler" edit "$EDIT_TARGET" > "$EDIT_OUT" 2> "$EDIT_ERR"
  EDIT_RC=$?
}

assert_edit_window() {
  local label="$1"
  if [ "$EDIT_RC" -eq 0 ] || [ "$EDIT_RC" -eq 124 ]; then
    pass "$label edit session reached projection window (exit=$EDIT_RC)"
  else
    fail "$label edit session trapped (exit=$EDIT_RC; see $EDIT_ERR)"
  fi
}

check_and_execute() {
  local compiler="$1" dir="$2" label="$3" expected="$4" patched="$5"
  local check_out="$dir/$label.check.out" check_err="$dir/$label.check.err"
  local normalized="$dir/$label.check.normalized" rc

  wt_run --dir "$ROOT" "$compiler" check "$EDIT_TARGET" > "$check_out" 2> "$check_err"
  rc=$?
  normalize_errors "$check_err" > "$normalized"
  if [ "$patched" -eq 1 ] && [ "$rc" -eq 0 ] && [ ! -s "$normalized" ]; then
    pass "$label patched check (zero reported proof debt)"
  else
    fail "$label patched check (patch missing, exit=$rc, or proof debt remains; see $check_err)"
  fi

  run_program "$compiler" "$label-post-edit" "$EDIT_SCRATCH" "$expected" no "$dir"
}

run_positive_workflow() {
  local compiler="$1" dir="$2" patched=0
  local fixture="$ROOT/tests/frontier/mn-constrained-hole-workflow.mn"

  compile_hole_fixture "$compiler" positive-hole "$fixture" "$dir"
  edit_fixture "$compiler" "$dir" positive-hole "$fixture"
  assert_edit_window positive-hole

  if grep -Fq '1 candidate(s)' "$EDIT_OUT"; then
    pass "positive-hole candidate filter (exactly one survivor)"
  else
    fail "positive-hole candidate filter (missing exact one-survivor projection)"
  fi

  if grep -Fq 'synth_proposer: integer literal seed' "$EDIT_OUT"; then
    pass "positive-hole survivor Reason surfaced"
  else
    fail "positive-hole survivor Reason not surfaced"
  fi

  if ! grep -Fq '??' "$EDIT_SCRATCH" && \
      grep -Eq 'with Pure = 1([[:space:]]|$)' "$EDIT_SCRATCH"; then
    pass "positive-hole patch applied (?? replaced by 1)"
    patched=1
  else
    fail "positive-hole patch not applied to scratch source"
  fi

  check_and_execute "$compiler" "$dir" positive-hole 1 "$patched"
}

has_rejection_reason() {
  local name="$1"
  grep -Eiq \
    "(${name}.*(Network|forbidden|effect|row|reject)|(Network|forbidden|effect|row|reject).*${name})" \
    "$EDIT_OUT" "$EDIT_ERR"
}

run_capability_workflow() {
  local compiler="$1" dir="$2" patched=0 rejected
  local fixture="$ROOT/tests/frontier/mn-capability-hole-workflow.mn"

  compile_hole_fixture "$compiler" capability-hole "$fixture" "$dir"
  edit_fixture "$compiler" "$dir" capability-hole "$fixture"
  assert_edit_window capability-hole

  if grep -Fq '1 candidate(s)' "$EDIT_OUT" && grep -Fq 'pure_seven' "$EDIT_OUT"; then
    pass "capability-hole filter retained only pure_seven()"
  else
    fail "capability-hole filter did not expose the sole pure survivor"
  fi

  for rejected in direct_network transitive_network higher_order_network; do
    if has_rejection_reason "$rejected"; then
      pass "capability-hole retained $rejected rejection Reason"
    else
      fail "capability-hole lost $rejected rejection Reason"
    fi
  done

  if ! grep -Fq '??' "$EDIT_SCRATCH" && \
      grep -Eq 'with !Network = pure_seven\(\)([[:space:]]|$)' "$EDIT_SCRATCH"; then
    pass "capability-hole exact patch applied (pure_seven())"
    patched=1
  else
    fail "capability-hole exact pure_seven() patch not applied"
  fi

  check_and_execute "$compiler" "$dir" capability-hole 7 "$patched"
}

# Two proven survivors is the teaching TIE-BREAK (PLAN §5): the medium
# surfaces both with their admission Reasons and refuses to guess — the
# authored ?? survives the accepted edit action untouched.
run_capability_tie_workflow() {
  local compiler="$1" dir="$2"
  local fixture="$ROOT/tests/frontier/mn-capability-tie.mn"

  compile_hole_fixture "$compiler" capability-tie "$fixture" "$dir"
  edit_fixture "$compiler" "$dir" capability-tie "$fixture"
  assert_edit_window capability-tie

  if grep -Fq '2 candidate(s)' "$EDIT_OUT" && \
      grep -Fq 'pure_seven' "$EDIT_OUT" && grep -Fq 'calm_seven' "$EDIT_OUT"; then
    pass "capability-tie projection surfaced both proven survivors"
  else
    fail "capability-tie projection missing the two-survivor tie"
  fi

  if grep -Eq 'with !Network = \?\?([[:space:]]|$)' "$EDIT_SCRATCH"; then
    pass "capability-tie refused to guess (authored ?? survives the accept)"
  else
    fail "capability-tie guessed between proven survivors (?? was replaced)"
  fi
}

# Pin the inherited runtime debt to the checked boot compiler and current
# runtime sources. A changed hash is an explicit baseline change, never an
# automatically blessed shadow. Other compiler artifacts may remove entries
# from this multiset, but may not introduce a new one.
baseline_dir="$ROOT/.build/frontier-gate/runtime-baseline"
rm -rf "$baseline_dir"
mkdir -p "$baseline_dir"
capture_runtime_shadow "$ROOT/boot/mentl.wasm" "$baseline_dir" || exit 1
BOOT_RUNTIME_SHADOW="$RUNTIME_SHADOW"
runtime_shadow_sha=$(sha256sum "$BOOT_RUNTIME_SHADOW" | awk '{print $1}')
if [ "$runtime_shadow_sha" = "$EXPECTED_RUNTIME_SHADOW_SHA256" ]; then
  pass "runtime shadow fingerprint pinned ($runtime_shadow_sha)"
else
  fail "runtime shadow fingerprint changed ($runtime_shadow_sha; expected $EXPECTED_RUNTIME_SHADOW_SHA256)"
  exit 1
fi

for i in "${!compilers[@]}"; do
  label="${labels[$i]}"
  compiler="${compilers[$i]}"
  [ -f "$compiler" ] || { echo "frontier: compiler not found: $compiler" >&2; exit 2; }
  dir="$ROOT/.build/frontier-gate/$label"
  rm -rf "$dir"
  mkdir -p "$dir"

  echo "frontier: compiler=$label artifact=$compiler"
  capture_runtime_shadow "$compiler" "$dir" || continue
  shadow_regressions="$dir/runtime-shadow.regressions"
  comm -23 "$RUNTIME_SHADOW" "$BOOT_RUNTIME_SHADOW" > "$shadow_regressions"
  if [ -s "$shadow_regressions" ]; then
    fail "$label runtime shadow introduced new errors (see $shadow_regressions)"
    continue
  else
    pass "$label runtime shadow is a subset of the pinned baseline"
  fi
  capture_persist_shadow "$compiler" "$dir" || continue
  run_program "$compiler" scheduled-int \
    "$ROOT/tests/frontier/mn-scheduled-fanout-int.mn" 60 yes "$dir"
  run_program "$compiler" scheduled-float \
    "$ROOT/tests/frontier/mn-scheduled-fanout-float.mn" 60 yes "$dir"
  run_program "$compiler" scheduled-tuple \
    "$ROOT/tests/frontier/mn-scheduled-fanout-tuple.mn" 90 yes "$dir"
  run_program "$compiler" scheduled-closure \
    "$ROOT/tests/frontier/mn-scheduled-fanout-closure.mn" 34 yes "$dir"
  run_program "$compiler" scheduled-effect \
    "$ROOT/tests/frontier/mn-scheduled-fanout-effect.mn" 25 yes "$dir"
  run_program "$compiler" scheduled-persist-float \
    "$ROOT/tests/frontier/mn-scheduled-fanout-persist-float.mn" 60 persist "$dir"
  run_program "$compiler" refined-alias-nonatomic \
    "$ROOT/tests/frontier/mn-refined-alias-nonatomic.mn" 3 yes "$dir"
  run_program "$compiler" refined-alias-forward-ref \
    "$ROOT/tests/frontier/mn-refined-alias-forward-ref.mn" 42 no "$dir"
  run_program "$compiler" own-alternative-branches \
    "$ROOT/tests/frontier/mn-own-alternative-branches.mn" 33 no "$dir"
  run_program "$compiler" own-call-arg-borrow \
    "$ROOT/tests/frontier/mn-own-call-arg-borrow.mn" 42 no "$dir"
  run_program "$compiler" own-forward-ref-seq \
    "$ROOT/tests/frontier/mn-own-forward-ref-seq.mn" 0 no "$dir"
  # E_OwnershipViolation armed 2026-07-18 — the double-move fixture moved from
  # run_diagnostic (productive exit 0) to the armed-class refusal contract.
  run_refusal "$compiler" own-call-arg-move \
    "$ROOT/tests/frontier/mn-own-call-arg-move.mn" E_OwnershipViolation "$dir"
  run_refusal "$compiler" refuse-refinement \
    "$ROOT/tests/frontier/mn-refuse-refinement.mn" E_RefinementRejected "$dir"
  run_refusal "$compiler" refuse-state-shadows-op \
    "$ROOT/tests/frontier/mn-refuse-state-shadows-op.mn" E_HandlerStateShadowsOp "$dir"
  run_refusal "$compiler" refuse-dup-fn \
    "$ROOT/tests/frontier/mn-refuse-dup-fn.mn" E_DuplicateFnName "$dir"
  run_program "$compiler" handler-forward-ref \
    "$ROOT/tests/frontier/mn-handler-forward-ref.mn" 42 no "$dir"
  run_positive_workflow "$compiler" "$dir"
  run_capability_workflow "$compiler" "$dir"
  run_capability_tie_workflow "$compiler" "$dir"
done

echo "frontier: $total_pass pass / $total_fail red"
[ "$total_fail" -eq 0 ]
