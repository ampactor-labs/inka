# boot/mentl.wasm — the pinned fixpoint compiler

This binary IS Mentl: the wheel compiled by itself to the byte-identical
fixed point (first light, 2026-07-10, commit 87c0152, tag `first-light`).
It replaces the hand-WAT seed as the bootstrap: the default build loop is

    boot/mentl.wasm  compiles  src/**+lib/**  →  m2   (wheel-emitted)
    m2               compiles  src/**+lib/**  →  m3
    assert m2 == m3                                    (the fixpoint ratchet)

Because boot is itself wheel-emitted, m2 == m3 IS the fixed point — the
seed-era rule "NOT m2 == m3" (PLAN §6) compared a SEED-emitted m2 against a
wheel-emitted m3 and retired with the seed.

Provenance, self-confirmed at pin time:

- source: Cluster A L0 — the O(1) string interner substrate (2026-07-14).
  string_offset_lookup was a linear str_eq scan over the emit string table
  (the 6th and last §5.O name-scanner); replaced by a str_hash bucket index
  (string_index_new/add/get/bucket_scan/build_string_index[_from]) mirroring
  the proven esc/env/region waypoint shape. Byte-identical by construction
  (reverse-insertion + prepend puts the smallest original index at the bucket
  front, so string_index_get returns the SAME offset the linear first-match
  did): m2 == m3 FIXED POINT, crown 5/5, 66/66 micros. The substrate the
  Cluster A migrations (the smap indexed-map primitive + EffName-is-a-handle)
  stand on. boot re-pinned to carry it.
- source: VALUE-PROOF (R2) — refinements discharge against the live value
  (2026-07-14). Refinements checked NOTHING before: `let bad: Sample = 1.5`
  compiled (SYNTAX's own E_RefinementRejected example was false against the
  binary). Two roots, both fixed: (1) parse_let DISCARDED the `: T`
  annotation (`let (_, p_ty) = ...`), so a let never reached any refinement
  check; it now CAPTURES it (LetStmt gains a 3rd node arg, the NTypeAnn,
  mirroring FnStmt's ret_ann; ~19 LetStmt sites moved in lockstep). (2) even
  when reached, the predicate's `self` (a VarRef node; PCompare operands are
  node HANDLES) resolved via node_const to None — subst_self(pred, value)
  now swaps the self-operand for the value node at infer_pat where the value
  handle lives, and verify discharges. `let bad: Sample = 1.5` REJECTS
  (`1.5 <= 1.0` proven false); `let ok: Sample = 0.5` compiles; a
  non-constant value stays honest V_Pending. The absent-annotation sentinel
  REUSES the value node (no fresh mint) so it is byte-identical — m2 == m3,
  NOT a renumbering transition. crown 5/5, 66/66 micros, census 146. Built
  by an 8-agent design workflow (which also confirmed EffName-is-a-handle
  drops NO census — the residual is open-tail + genuine subset failures,
  ZERO same-name-different-scalar pairs — so EffName is a by-name-family
  deletion + perf lever, not a census lever). Crucibles tests/micros/
  mn-refine-reject.mn + mn-refine-let.mn (stderr-gated). boot re-pinned.
- source: heal the crown dedup/membership inconsistency (2026-07-14) — the
  8-agent design-convergence for EffName-is-a-handle surfaced that cc487f8
  fixed the membership leaf (name_set_contains_loop, :887) by name but LEFT
  the DEDUP twin (name_set_prefix_contains_loop, :760, name_set_dedup_into)
  at pointer-eq — so two byte-equal ENamed from distinct sites still failed
  to dedup there. Flip :760 to the same by-name compare; the two paths now
  agree. Census unchanged (146 — the residual isn't dedup-caused), crown
  5/5, 66/66 micros; a TRANSITION (dedup order shifts the compile) m2 != m3,
  m3 == m4, boot re-pinned. (The design-convergence itself is BANKED: all
  four mechanisms + the scout converge on EffName-identity-as-a-word,
  byte-identical-first because EffName is emit-erased — but the honest
  verdict was is_best_next_lever=FALSE: its payoff is deferred to transition
  increments that compound the crown transition, and value-proof R2 — bind
  self to the live construction node — wins per-effort next.)
- source: the crown positive-gate root (2026-07-14) — an 8-agent adversarial
  workflow (audit → refute) overturned the destiny audit's "R1 / names-are-
  handles clears 594→~0": measured, the 598 false effect-mismatches on the
  self-compile were ~80% an UNRESOLVED-ROW-VAR class dying at `row_subsumes`'
  `EfClosed-gate vs EfOpen-body → _ => false` arm, and the shared root is
  pointer-eq at the membership leaf (`name_set_contains_loop`, effects.mn):
  `list_index(set, i) == name` floors to i32.eq because the untyped list
  erases the element to a word, so two byte-equal `ENamed("Memory")` from
  distinct sites never merged — breaking set-dedup (422/598 rows carried
  duplicate names) so the open tail never closed. Fix: the leaf matches BY
  NAME (`str_eq(eff_name_str(...), eff_name_str(name))`, as the negation gate
  already did); `row_subsumes` resolves both inputs (a BOUND tail surfaces so
  a hidden forbidden effect is still checked) and mirrors the EfOpen-gate arm
  for an open body against a closed gate (the free tail is empty after
  inference; the call-site rebind closes it to the declared row). And
  `string_in_list` — own.mn's ref-escape check over a String list — was
  un-conflated from `name_set_contains` (it aliased the EffName membership;
  by-name deref trapped on a bare String). MEASURED: census 598 → 146 (76%);
  crown 5/5, 66/66 micros, all CLI verbs work. Emit changed (452 fns now pass
  their own declared row → tighter evidence threading, 469685 → 453508 lines):
  m2 != m3, m3 == m4 self-confirmed; boot re-pinned from m3. Residue: the ~146
  (85 mismatch + 61 purity) is the interning-ultimate + the parameterized
  by-name conflation (Hβ.effects.parameterized-negation-instance) + the purity
  path; the audit row-var render is a separate un-resolved-scheme-row residual.
- source: unify the analysis verbs (2026-07-14) — `audit` and `teach` were
  byte-identical but for the projection: the same load → per-fn walk →
  render → print skeleton under the same 13-handler check chain. Collapsed
  to `map_fn_stmts(ast, project)` (the ONE fn-decl cursor walk,
  `collect_fn_rows`/`collect_gradients` deleted) and `analyze_fns(entry,
  project, render)` (the chain + skeleton, one home); `audit`/`teach` are
  now one-line projections of it. −223 emitted lines, runtime logic only →
  m2 == m3 byte-identical (468930 lines); boot re-pinned to carry the
  unified verbs; 8/8 rungs + 66/66 micros + 5/5 crown; `boot audit/teach/
  query` self-checked. Prior: the analysis-verb connect (2026-07-14) —
  `audit`/`query`/`teach` LOAD, CHECK, and RENDER. They took a module NAME but ran `name |>
  frontend`, parsing "tutorial/foo" as source; they now route through
  `driver_check_entry` (the same load `compile`/`check` use — deps DAG
  resolved, entry typed) under the full check handler chain (`affine_ledger`
  + `region_tracker` + `arm_state_ctx`, the set the deps' inference needs),
  and pipe the render to `print_string` (the machinery rendered a string
  nothing emitted). Latent bugs the connect EXPOSED, all in never-run code:
  `classify_query_verb`'s `w` wasn't proven `String` so `w == "why"` was
  pointer-eq and every query fell to QUnknown (the §9 name-eq class);
  `parse_query_string` matched `split`'s slice-VIEW against the flat
  list-pattern contract (flatten once, §7 face 13); and `render_audit` read
  record fields inside a `map` lambda where the element type doesn't flow, so
  every `report.fn_name` floored "field offset unprovable" — the report is a
  TUPLE now (positional destructure is provable with no type flow, as teach's
  `[(name, result)]` already is; the wheel lowers no nominal record PATTERN
  to prove a record there). NO emit-logic change → m2 == m3 byte-identical
  (469153 lines) in one generation; boot re-pinned to carry the working
  verbs; 8/8 rungs + 66/66 micros + 5/5 crown; `boot audit/query/teach`
  self-checked end-to-end before the bless.
- boot/mentl.wasm  sha256 a63b9b58cd0e151621292e55eb3d1398034900c532d8fed4a0b3290b6f30f792
- its .wat (m2 == m3 asserted) sha256 643a43024f1a9aa5b000a6ed3757246031e95ba972483f4791d08b61269d56ef
- generated by: `bash tools/march.sh` (the ratchet loop; prior pin
  06847e5c… — the value-proof wheel — from
  358faa34… — the crown dedup-consistency wheel — from
  8a5d8ff7… — the crown positive-gate wheel — from
  45ee71af… — the analysis-verb unify wheel — from
  c4bdba19… — the analysis-verb connect wheel — from
  bea3692b… — the argv/CLI-dispatch wheel — from
  349a3302… — the O(1) reachability index wheel — from
  67e44c9c… — the M4 ABANDON-discipline wheel — from THE CUT ac204467…,
  the M1.1 world-tag pin 70d184a0…, the image-layout pin d24af35a…, the
  first-light boot b3314001…, commit 87c0152, tag `first-light`)

The hand-WAT seed (`bootstrap/`) was DELETED (7401c4b "Fly, my pretty <3",
2026-07-10, the day after first light); `--from-seed` is gone with it. The
cold-bootstrap recipe — and the diverse-second-seed ingredient for
trusting-trust (PLAN band J, `Hβ.closure.diverse-double-compilation`) — lives
at tag `first-light`, git archaeology out of the run path (PLAN §6).
