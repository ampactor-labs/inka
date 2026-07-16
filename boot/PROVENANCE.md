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

- source: the felt route lives — mentl edit reaches its projection window
  (2026-07-16, second pin of the day). The frontier gate's edit-session
  contract goes GREEN: `mentl edit` renders the first full eight-aspect
  CursorView in project history and exits 0. Five roots, each artifact-pinned
  by the probe loop (binary-patched ev_perform_entry speaking its missing key;
  a gated eprint census in the resolver): (1) edit_run's chain never installed
  cursor_default or env_handler — the Cursor perform met the strict ev-scan
  miss (OOB at 2^32). (2) `effect Cursor` was SHADOWED by `type Cursor` in the
  one env namespace (and `effect Patch` by `type Patch`; Sample still pairs by
  DSP doctrine — the named namespace decision): the effects rename to the
  repo's own capability convention, CursorRead / PatchWrite (Graph/GraphRead,
  Env/EnvRead — the values keep their nouns). (3) lookup_effect_op_names
  fabricated `[eff_name]` on a non-effect entry — the surrender-fallback that
  converted the shadowing into a "" ename and a silent keyed fall-through;
  it now answers []. (4) pre_register_fn_sig DISCARDED the authored `-> RetTy`
  (the parse_let-annotation twin at the return position): a forward callsite
  instantiated a quantified fresh return its later real inference never
  reached, so unused-at-use results floored to word width —
  caret_proximity_weight's f64 met an i32 definition, the indirect call type
  mismatch the felt loop was the first to EXECUTE (Hβ.m2.callsite-result-width,
  named 2026-07-07, closed at the pre-scheme root; the weight family carries
  its authored -> Float). (5) the session's TransportState pointer flowed out
  as main's exit code — the chain is a statement now; a completed session
  exits 0. m2/m3 generation delta: 6 lines. Gates at the bless: 8/8 rungs +
  70/70 micros through m2 AND m3; frontier 24 pass / 19 red (the reds are the
  synth candidate filter, patch application, and proof-debt discharge — R4/R5,
  plus the inherited 0:0 diagnostic debt); march TRANSITION, m3 == m4.
- source: inference-owned executable boundaries + the pattern-constraint law
  (2026-07-16). Four landings in one arc: (1) Fail/Abort split to distinct
  effect identities, one substrate Alloc (mn-effect-identity=81 + the
  declaration census gate). (2) TCont gains the R/S split and the graph gains
  a trail-backed executable-boundary weave — per fanout site one ordered
  BoundaryEdge(result, thunk, carrier, tickets) per branch; per application
  site a ContinuationEdge whose world is the live InferCtx frame row captured
  at inference (resume_world_of, the name-keyed env read, deleted). EVERY
  application result stages a boundary (calls, pipe stages, fanout applies);
  finalize binds the op's live discipline at op sites and the segment
  discipline (MultiShot) at crossing sites — the narrower op-only staging
  reached a WRONG fixpoint (m3 == m4 held while k2-frame/k2-pipe/
  option-protocol/backtrack-full trapped 134 through m3; the through-m3
  battery, not the diff, caught it). The scheduler boundary transports one
  word (the one-field carrier product; the join projects field 0 at the exact
  repr), so f64 branch values cross Seq/Thread/Persist unboxed — the
  scheduled-Float frontier contract runs exit 60. A violated boundary is the
  typed LInvariantFailure terminal (a censusable comment-marked unreachable).
  (3) A pattern CONSTRAINS its scrutinee (constrain_scrutinee: bind the shape
  onto a fresh node, unify) — all five shape-bearing arms had clobbered the
  scrutinee's proven type via graph_bind-overwrite, so destructured binders
  floored to word widths unless a use grounded them (mn-fanout-destructure-
  float=60 pins the split-truth miscompile). On the wheel this resolves
  ~4,400 diagnostics (37,684 → 33,286 through the fixed inference) and
  surfaced HandlerKind's bare-List payload erasure (the 581a92f class),
  typed at the declaration — the ++-operand floor that briefly broke m4
  dissolves at the root. (4) persist.mn is lib-honest: typed PersistHandle
  ops, substrate-direct fs writes, cross-world rehydrate REFUSES via Fail.
  The frontier gate (tools/frontier-gate.sh) carries the scheduled matrix
  (Int/Float/tuple/closure/effect/persist-float all green through this
  wheel) and the red-by-design ?? authoring + proof-exactness contracts.
  Gates at the bless: 8/8 rungs + 69/69 micros (70 with the new destructure
  micro through this boot) through m2 AND through m3; march TRANSITION,
  m3 == m4 self-confirmed.
- source: carry `<|` branch application identity from inference through emit
  (2026-07-14). Inference now applies every shared branch, including the
  accepted single-branch form. Branch handles retain their `TFun` proof; only
  the fanout node binds the result tuple to the exact minted output handles.
  Lower projects those edges through the ordinary call path,
  so named and inline effectful stages share one `LCall`/`LSuspend` decision;
  the collector uses each output handle for its call signature and tuple
  field. The WASM tuple-pattern readers now use `repr_of_resolved`, matching
  construction's width fold, and `LFnRef` records write the true zero-capture
  fence that `LSuspend` clones. Two micros pin the failures that Int concealed:
  ambiguous-handler evidence across named/inline N-way and singleton branches,
  and f64 call/store/bind widths plus the singleton fanout form. `m3 == m4`, pinned-boot 68/68
  micros, fresh-m3 68/68 micros. The scheduled non-word branch frontier remains
  explicit: Thread/Persist need a graph handle for the synthetic `() -> result`
  thunk type before generic dispatch can be representation-correct.
- source: Cluster A — the smap indexed-map consolidation (2026-07-14). Four
  of the six §5.O str_hash name-scanners (esc/base/summary/reach; env is the
  partial holdout, region is already handle-keyed) each hand-rolled the same
  str_hash bucket map. Collapsed into ONE primitive lib/runtime/imap.mn
  (smap_new/build/add/get/bucket_scan) — the Hβ.runtime.indexed-map-primitive.
  Each migration byte-identical (the plumbing changes, not the emit; reverse
  insertion keeps first-match): m2 == m3 FIXED POINT, crown 5/5, 66/66 micros,
  ~500 fewer emitted lines. base keeps its position-extracting build, reach its
  tree-walk builders, both calling smap; summary/reach unwrap smap's Option to
  their UZero/[] miss. The forward-ref (src uses the lib primitive) works as
  prelude does. env (a liveness scan smap cannot carry) + the EffName-is-a-handle
  by-name-family deletion remain the banked, exact-edit remainder. boot re-pinned.
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
- boot/mentl.wasm  sha256 9c8b23ba94045886f93b8a331e0b9c872b256818a48b83443fec462d5359f3bc
- its .wat (m3 == m4 asserted) sha256 912ba7d87721aa6468602d1337966d327342ecd241637d512ef38bebec99e173
- generated by: `bash tools/march.sh` (the ratchet loop; prior pin
  7bd9e3e7… — the executable-boundary + pattern-constraint wheel — from
  289b2886… — the exact-fanout-edge wheel — from
  f711573d… — the fanout application-edge wheel before RHS stage preservation — from
  2dc47d2f… — the Cluster A smap wheel — from
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
