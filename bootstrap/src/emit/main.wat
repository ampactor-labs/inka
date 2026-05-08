  ;; ═══ main.wat — Hβ.emit pipeline-stage boundary (Tier 9) ═══════════════
  ;; Hβ.emit cascade chunk #8 of 8 per Hβ-emit-substrate.md §7.1
  ;; (post-restructure: emit_dispatcher.wat absorbed into emit_const.wat
  ;; per the walk_call.wat precedent — $emit_lexpr is introduced in the
  ;; FIRST chunk that needs sub-LowExpr recursion and retrofitted by
  ;; subsequent chunks via Edit). CASCADE CLOSURE.
  ;;
  ;; Implements: Hβ-emit-substrate.md §4 (module orchestration —
  ;;             $emit_lowir_program walks the LowExpr list and emits
  ;;             via $emit_lexpr) + §7.1 (chunk #9 main.wat) +
  ;;             §10.3 the CLEAN handoff (lower→emit; LowExpr list
  ;;             produced by $mentl_lower is read-only here; WAT-text
  ;;             output IS the new artifact) + §11.3 dep order (chunk
  ;;             #9 closes the cascade) + Hβ-bootstrap.md §1.15 (entry-
  ;;             handler convention — $inka_<verb> naming) + §2.1 Layer 6
  ;;             (Emitter).
  ;;
  ;; Realizes the pipeline-stage projection of primitive #3 (the five
  ;; verbs — DESIGN.md §0.5) at the seed's emission layer, symmetric to
  ;; $mentl_infer's primitive #8 projection at inference + $mentl_lower's
  ;; primitive #3 projection at lowering. Closes the Hβ.emit cascade.
  ;; Names the boundary where pipeline-wire ($sys_main retrofit, named
  ;; peer follow-up) will chain after $mentl_lower.
  ;;
  ;; Exports:    $mentl_emit (pipeline-stage entry — delegates to
  ;;               $emit_lowir_program; takes the LowExpr list from
  ;;               $mentl_lower; emits WAT to $out_base buffer via
  ;;               $emit_byte side-effect),
  ;;             $emit_lowir_program (algorithmic-core orchestrator —
  ;;               walks the LowExpr list and emits each via $emit_lexpr)
  ;; Uses:       $emit_lexpr (emit_const.wat — partial dispatcher
  ;;               complete via cumulative retrofits from chunks #3-#7
  ;;               for 30 LowExpr tags; tags 311 LMakeClosure + 312
  ;;               LMakeContinuation trap (unreachable) per named peer
  ;;               follow-up Hβ.emit.handler-fnref-substrate)
  ;;             $len + $list_index (runtime/list.wat)
  ;; Test:       bootstrap/test/emit/main_mentl_emit_smoke.wat
  ;;
  ;; ═══ LOCKS (wheel-canonical override walkthrough §4 prose) ════════════
  ;;
  ;; Lock #1: $emit_lowir_program iterates the LowExpr list and calls
  ;;          $emit_lexpr on each. Mirrors Hβ.lower's $lower_stmt_list
  ;;          buffer-counter iteration shape (Ω.3 substrate). Side-effect
  ;;          on $out_base/$out_pos via $emit_byte deep in $emit_lexpr's
  ;;          arm bodies; the orchestrator itself is loop-only.
  ;;
  ;; Lock #2: $mentl_emit is the pipeline-stage boundary; $emit_lowir_program
  ;;          is the algorithmic core. Two symbols, one delegation each.
  ;;          Mirrors Hβ.infer's $mentl_infer / $infer_program + Hβ.lower's
  ;;          $mentl_lower / $lower_program two-symbol pattern per
  ;;          Hβ-bootstrap §1.15. THIRD instance — the abstraction is
  ;;          earned per Anchor 7 cascade discipline.
  ;;
  ;; Lock #3: Result type — $mentl_emit returns no value; emission is
  ;;          side-effect on $out_base/$out_pos. Differs from
  ;;          $mentl_lower (returns LowExpr list ptr) and $mentl_infer
  ;;          (no result; graph is the artifact). Hβ.emit's artifact
  ;;          IS the WAT byte buffer.
  ;;
  ;; Lock #4: $sys_main retrofit is the SEPARATE peer-handle commit
  ;;          Hβ.infer.pipeline-wire (named in Hβ.lower's main.wat:58-65 +
  ;;          ROADMAP.md §Near-Term Execution Order). NOT touched here.
  ;;          Three-stage cascade-closure-then-peer-handle-retrofit
  ;;          pattern continues per Anchor 7.4.
  ;;
  ;; Lock #5: NO new tags. Pure delegation per Lock #1.
  ;;          Tag regions owned upstream:
  ;;          300-349 LowExpr (lower/lexpr.wat); 360-379 emit-private
  ;;          records (emit/state.wat).
  ;;
  ;; ═══ EIGHT INTERROGATIONS (per Hβ-emit-substrate.md §5 applied to the
  ;;                           pipeline-stage boundary) ══════════════════
  ;;
  ;; 1. Graph?      $mentl_emit reads through the LowExpr list. Each
  ;;                $emit_lexpr call walks the LowExpr's record; arms
  ;;                that need types call $lookup_ty (per §2.1 LConst /
  ;;                §2.4 LSuspend etc.). main.wat itself is graph-silent;
  ;;                the live graph reads happen INSIDE $emit_lexpr's
  ;;                arms.
  ;; 2. Handler?    @resume=OneShot. Wheel's `handle … with wat_emit`
  ;;                (src/backends/wasm.mn — Emit effect) is OneShot;
  ;;                seed maps onto direct $emit_byte side-effect. When
  ;;                the wheel composes Emit-handler-swap (text-output
  ;;                vs binary-output vs LSP-rendering), $mentl_emit stays
  ;;                inert — handlers compose ON the substrate.
  ;; 3. Verb?       `|>` — this chunk draws the THIRD pipeline-stage
  ;;                step in the planned chain
  ;;                  parsed_stmts |> $mentl_infer |> $mentl_lower |> $mentl_emit
  ;;                The $inka_<verb> convention names each `|>` stage.
  ;; 4. Row?        EmitMemory + WasmOut at the wheel; row-silent at the
  ;;                seed. Side-effect on $out_base/$out_pos via the
  ;;                emit_infra primitives is the EmitMemory swap surface
  ;;                made physical (§3.5 — bump today, arena/gc tomorrow
  ;;                via $emit_alloc / $emit_alloc_dyn body swap).
  ;; 5. Ownership?  $mentl_emit takes lowexprs by shared pointer (`ref`);
  ;;                no consumption — the LowExpr list remains available
  ;;                for downstream readers. $out_base buffer OWNed
  ;;                program-wide per emit_infra.wat globals; emission is
  ;;                side-effect, not transfer.
  ;; 6. Refinement? None at this chunk. TRefined obligations carried
  ;;                through $lookup_ty are transparent at emit; main.wat
  ;;                is transit.
  ;; 7. Gradient?   The post-$mentl_emit WAT byte buffer IS the gradient
  ;;                cashed out — every annotation in the source program
  ;;                ($with`-clauses, `own`/`ref`, refinements, type
  ;;                annotations) has been ground through inference,
  ;;                lowering, and emission into machine-instruction
  ;;                bytes. main.wat closes the surface; the cash-out
  ;;                already happened at chunks #6 (gradient cash-out
  ;;                site for monomorphic-vs-polymorphic) + #7 (handler
  ;;                family + LFeedback `<~` substrate).
  ;; 8. Reason?     main.wat adds no Reason edges. Reasons accumulate
  ;;                upstream in the graph populated by $mentl_infer; emit
  ;;                preserves them by reading-only via $lookup_ty inside
  ;;                $emit_lexpr's arms. Per SUBSTRATE.md §VIII "the
  ;;                graph IS the program": Reasons stay graph-side; the
  ;;                Why Engine walks back through $gnode_reason on the
  ;;                source handle, NOT through emitted WAT.
  ;;
  ;; ═══ FORBIDDEN PATTERNS (drift modes 1-9) ════════════════════════════
  ;;
  ;; Drift 1 (Rust vtable):       NO $mentl_emit_closure / $emit_dispatch_
  ;;                              table / data segment $pipeline_stage_
  ;;                              table. Two direct functions; ONE call
  ;;                              each. The dispatch IS $emit_lexpr's
  ;;                              tag-int comparison chain (chunk #3) —
  ;;                              evidence passing, NOT vtable.
  ;; Drift 2 (Scheme env frame):  NO $frame / $emit_frame parameter;
  ;;                              state.wat (chunk #1) owns emit-state;
  ;;                              main.wat reads nothing.
  ;; Drift 3 (Python dict):       NO string-keyed pipeline-stage dispatch;
  ;;                              stages are direct $inka_<verb> symbols.
  ;; Drift 4 (Haskell monad):     NO EmitM / PipelineM monad shape;
  ;;                              direct call sequence.
  ;; Drift 5 (C calling conv):    ONE i32 parameter — lowexprs. No
  ;;                              (lowexprs, ctx, errors_out) struct;
  ;;                              no out-parameter.
  ;; Drift 6 (primitive special): The emission stage is not "special";
  ;;                              every $inka_<verb> stage has the same
  ;;                              one-delegating-function shape per
  ;;                              Lock #2.
  ;; Drift 7 (parallel arrays):   NO (stage_names[], stage_fns[])
  ;;                              registry; the chain IS the call
  ;;                              sequence (lands in pipeline-wire peer
  ;;                              per Lock #4).
  ;; Drift 8 (mode flag):         NO mode: i32 parameter; one $mentl_emit;
  ;;                              pipeline-wire selects this projection
  ;;                              directly via $mentl_emit.
  ;; Drift 9 (deferred-by-omis):  $sys_main retrofit is named peer handle
  ;;                              Hβ.infer.pipeline-wire (Lock #4); the
  ;;                              two LFn-bearing emit arms (LMakeClosure
  ;;                              + LMakeContinuation) are named peer
  ;;                              Hβ.emit.handler-fnref-substrate (per
  ;;                              chunk #7 closure). NEITHER a silent TODO.
  ;;
  ;; Foreign-fluency forbidden:   "compiler driver" / "code generator
  ;;                              entry" / "backend main" / "main entry"
  ;;                              → Mentl-native phrases are "pipeline-
  ;;                              stage boundary" + "kernel primitive #3
  ;;                              verb projection" + "§10.3 clean
  ;;                              handoff" + "$emit_lowir_program
  ;;                              orchestrator". "code generator" /
  ;;                              "backend" → "emit handler-projection
  ;;                              per SUBSTRATE.md §III 'The Handler IS
  ;;                              the Backend'".
  ;;
  ;; ═══ TAG REGION ══════════════════════════════════════════════════════
  ;;
  ;; This chunk introduces NO new tags. Pure delegation per Lock #5.
  ;;
  ;; ═══ NAMED FOLLOW-UPS (per Drift 9 closure + Hβ-emit-substrate.md §10) ══
  ;;
  ;; - Hβ.infer.pipeline-wire: $sys_main retrofit (build.sh Layer 0
  ;;   shell inline) to chain $mentl_emit between $mentl_lower and the
  ;;   final $proc_exit. UNGATED post-this-chunk per Hβ-emit
  ;;   substrate.md §10.3 + Hβ-lower §10.3 + Hβ-infer §10.3 (three-
  ;;   stage cascade closure). $sys_main becomes:
  ;;     stdin |> read_all_stdin |> lex |> parse_program
  ;;       |> $mentl_infer |> $mentl_lower |> $mentl_emit |> proc_exit
  ;;   Lands as the IMMEDIATE next commit per Lock #4.
  ;;
  ;; - Hβ.lower.lowfn-substrate: add LowFn record (tag 350 + 5
  ;;   accessors) to bootstrap/src/lower/lexpr.wat per src/lower.mn
  ;;   LFn ADT; update walk_compound + walk_stmt to construct LowFn
  ;;   properly. Prerequisite for handler-fnref-substrate.
  ;;
  ;; - Hβ.emit.handler-fnref-substrate: $emit_lmakeclosure (tag 311) +
  ;;   $emit_lmakecontinuation (tag 312) emit arms; depends on
  ;;   Hβ.lower.lowfn-substrate landing first.
  ;;
  ;; - Hβ.emit.lmatch-pattern-compile: nonempty-arms HB threshold-aware
  ;;   mixed-variant dispatch for $emit_lmatch (chunk #5); depends on
  ;;   LowPat substrate per Hβ.lower.lvalue-lowfn-lpat-substrate.
  ;;
  ;; - Hβ.emit.memory-arena-handler / -gc-handler: alternative
  ;;   EmitMemory swap-surface bodies; replace $emit_alloc and
  ;;   $emit_alloc_dyn body when arena/gc substrate matures (W5 +
  ;;   post-first-light substrate).
  ;;
  ;; - Hβ.emit.module-wrap: emit-time module-level wrappers — `(module
  ;;   ...)` header, memory imports, fn-table emission via state.wat's
  ;;   $emit_funcref_*, string-data emission via state.wat's
  ;;   $emit_string_*, state-global emission for $s<h> per LFeedback
  ;;   site handles. Lands as the module-wrap projection selected by
  ;;   pipeline-wire.

  ;; ─── Phase F+H data segments (module-wrap + fn-body emission) ─────
  ;; Phase F segments: 1584-1596 (funcref, _start)
  (data (i32.const 1584) "funcref")
  (data (i32.const 1591) "_start")
  ;; Phase H fn-body emission segments: RELOCATED to 4096+ to avoid
  ;; the contested 1597-1855 range (emit_diag at 1840 / emit_call at 1856).
  ;; 4096: "__state" (7) → 4103
  ;; 4104: "_idx i32 (i32.const " (20) → 4124
  ;; 4124: " (param $" (9) → 4133
  ;; 4133: " (result i32)" (13) → 4146
  ;; 4146: " (local $" (9) → 4155
  ;; 4155: " i32)" (5) → 4160
  ;; 4160: "(table $fns " (12) → 4172
  ;; 4172: " funcref)\n" (10) → 4182
  ;; 4182: "(elem $fns (i32.const 0)" (24) → 4206
  ;; 4206: ")\n" (2) → 4208
  ;; 4208: "(type $ft" (9) → 4217
  ;; 4217: " (func" (6) → 4223
  ;; 4224: " i32 " (5) → 4229
  ;; 4232: "callee_closure" (14) → 4246
  ;; 4248: "scrut_tmp" (9) → 4257
  ;; 4260: "loop_i" (6) → 4266
  ;; 4268: "main" (4) → 4272
  ;; Next free: 4272
  (data (i32.const 4096) "__state")
  (data (i32.const 4104) "_idx i32 (i32.const ")
  (data (i32.const 4124) " (param $")
  (data (i32.const 4133) " (result i32)")
  (data (i32.const 4146) " (local $")
  (data (i32.const 4155) " i32)")
  (data (i32.const 4160) "(table $fns ")
  (data (i32.const 4172) " funcref)\n")
  (data (i32.const 4182) "(elem $fns (i32.const 0)")
  (data (i32.const 4206) ")\n")
  (data (i32.const 4208) "(type $ft")
  (data (i32.const 4217) " (func")
  (data (i32.const 4224) " i32 ")
  (data (i32.const 4232) "callee_closure")
  (data (i32.const 4248) "scrut_tmp")
  (data (i32.const 4260) "loop_i")
  (data (i32.const 4268) "main")

  ;; ─── $emit_lowir_program — algorithmic-core orchestrator ─────────────
  ;;
  ;; Per Hβ-emit-substrate.md §4 + the Ω.3 buffer-counter iteration
  ;; substrate (CLAUDE.md memory model — never `acc ++ [x]`). Walks the
  ;; LowExpr list ($lower_program's output) and emits each via
  ;; $emit_lexpr. Side-effect on $out_base/$out_pos via $emit_byte
  ;; deep inside $emit_lexpr's arm bodies; main.wat itself is loop-only.
  ;;
  ;; Drift 1 refusal: direct list-walk via $list_index; NO $emit_dispatch_
  ;; table / NO closure-record-of-fn-pointers. The dispatch IS
  ;; $emit_lexpr's tag-int comparison chain.

  (func $emit_lowir_program (export "emit_lowir_program")
        (param $lowexprs i32)
    (local $i i32) (local $n i32)
    (local.set $n (call $len (local.get $lowexprs)))
    (local.set $i (i32.const 0))
    (block $done
      (loop $iter
        (br_if $done (i32.ge_u (local.get $i) (local.get $n)))
        (call $emit_lexpr
          (call $list_index (local.get $lowexprs) (local.get $i)))
        (local.set $i (i32.add (local.get $i) (i32.const 1)))
        (br $iter))))

  ;; ═══ The Cursor Projection Pattern ═══════════════════════════════
  ;; Per protocol_cursor_is_the_substrate.md (2026-05-07): every emit-
  ;; side collect-and-project function follows ONE shape:
  ;;
  ;;   1. WALK the LowExpr tree (mirror $cwo_walk's tag-int dispatch)
  ;;   2. PREDICATE-FILTER each visited node (matches the aspect)
  ;;   3. PROJECT the matched node (push to Buffer, or emit directly)
  ;;
  ;; The seed has four instances at this writing:
  ;;
  ;;   $collect_fn_names           — Handler aspect (LMakeClosure /
  ;;                                  LMakeContinuation / LDeclareFn)
  ;;                                  → fn-name set for funcref table.
  ;;   $collect_top_level_fn_names — Handler aspect at module-root
  ;;                                  (LLet-wrapped LMakeClosure) →
  ;;                                  static closure record set.
  ;;   $collect_used_wasi_ops      — Row aspect (LPerform with wasi_*
  ;;                                  target) → import declarations.
  ;;   $emit_toplevel_locals       — Refinement aspect (LetStmt+PVar)
  ;;                                  → local declarations (projects
  ;;                                  directly via $emit_byte rather
  ;;                                  than collecting first).
  ;;
  ;; Future emit-extensions (type tables, refinement bound elision,
  ;; row-aware parallel emit, ownership register allocation) all
  ;; follow this shape. The extension point is the predicate, not
  ;; the projector. "Imperative subsystem" never appears in correct
  ;; Mentl substrate (named drift extension; see CLAUDE.md red-flag
  ;; thoughts table).
  ;; ──────────────────────────────────────────────────────────────────

  ;; ─── WASI import emission — cursor-projected ─────────────────────
  ;; Per the Cursor Projection Pattern above: emit walks the lowered
  ;; program collecting LPerform op_names that target "wasi_<op>"
  ;; symbols; projects ONE import per used op. Adding a new WASI op
  ;; = ZERO emit code change beyond extending $wasi_signature_for.
  ;; The cursor's Row aspect at the program root drives import
  ;; projection. emit IS a graph projection, not an imperative
  ;; subsystem.
  ;;
  ;; Drift refused: 1 (no vtable; structural tag-int dispatch in
  ;; cwo_walk); 7 (no parallel arrays — used set is one Buffer<String>);
  ;; 8 (op_name string compare, no mode flag); 9 (collect+sig+emit
  ;; land whole as one cohesive projection cascade).
  ;;
  ;; Length-prefixed signature strings keyed by op-name suffix.
  ;; Reused across all (effect-name, op-name) pairs that share a
  ;; WASI-preview1 signature (e.g. fd_write/fd_read share 4-i32-args).
  (data (i32.const 4800) "\0c\00\00\00 (param i32)")                                              ;; len 12 — proc_exit
  (data (i32.const 4816) "\19\00\00\00 (param i32) (result i32)")                                  ;; len 25 — fd_close
  (data (i32.const 4848) "\21\00\00\00 (param i32 i32 i32) (result i32)")                          ;; len 33 — path_create_directory, path_unlink_file
  (data (i32.const 4896) "\25\00\00\00 (param i32 i32 i32 i32) (result i32)")                      ;; len 37 — fd_write, fd_read
  (data (i32.const 4944) "\29\00\00\00 (param i32 i32 i32 i32 i32) (result i32)")                  ;; len 41 — path_filestat_get
  (data (i32.const 4992) "\2d\00\00\00 (param i32 i32 i32 i32 i32 i32) (result i32)")              ;; len 45 — path_rename (occupies 4992..5040 inclusive — 4 prefix + 45 content)
  (data (i32.const 5048) "\39\00\00\00 (param i32 i32 i32 i32 i32 i64 i64 i32 i32) (result i32)")  ;; len 57 — path_open. Was 5040 → overlapped path_rename's last byte (`)` → `9`); moved to 5048 for 8-byte alignment.

  ;; Length-prefixed "wasi_proc_exit" for runtime-injected used set.
  ;; The seed's _start epilogue calls $wasi_proc_exit unconditionally;
  ;; the cursor walks user code only, so emit-runtime-emitted ops must
  ;; be injected before the walk. Until _start itself is graph-
  ;; projected (Hβ.first-light.start-section-graph-projected — peer
  ;; follow-up), each runtime-emitted WASI op gets one seed-side line
  ;; here. User ops remain fully cursor-projected from $cwo_walk.
  (data (i32.const 5120) "\0e\00\00\00wasi_proc_exit")  ;; len 14 (was 5104 → overlapped path_open at 5048+61)

  ;; $wasi_signature_for — given target_name "wasi_<op>", returns a
  ;; length-prefixed signature string ptr (or 0 if unknown). Suffix-
  ;; key dispatch reuses walk_call.wat's existing length-prefixed
  ;; comparison strings at 4416/4432/4448/4464/4480/4608/4640/4672/4704.
  (func $wasi_signature_for (param $target i32) (result i32)
    (local $suffix i32)
    (local.set $suffix
      (call $str_slice (local.get $target) (i32.const 5)
                       (call $str_len (local.get $target))))
    (if (call $str_eq (local.get $suffix) (i32.const 4416))   ;; fd_write
      (then (return (i32.const 4896))))
    (if (call $str_eq (local.get $suffix) (i32.const 4432))   ;; fd_read
      (then (return (i32.const 4896))))
    (if (call $str_eq (local.get $suffix) (i32.const 4448))   ;; proc_exit
      (then (return (i32.const 4800))))
    (if (call $str_eq (local.get $suffix) (i32.const 4464))   ;; path_open
      (then (return (i32.const 5048))))
    (if (call $str_eq (local.get $suffix) (i32.const 4480))   ;; fd_close
      (then (return (i32.const 4816))))
    (if (call $str_eq (local.get $suffix) (i32.const 4608))   ;; path_create_directory
      (then (return (i32.const 4848))))
    (if (call $str_eq (local.get $suffix) (i32.const 4640))   ;; path_filestat_get
      (then (return (i32.const 4944))))
    (if (call $str_eq (local.get $suffix) (i32.const 4672))   ;; path_unlink_file
      (then (return (i32.const 4848))))
    (if (call $str_eq (local.get $suffix) (i32.const 4704))   ;; path_rename
      (then (return (i32.const 4992))))
    (i32.const 0))

  ;; $emit_one_wasi_import — emit one WASI import declaration:
  ;;   (import "wasi_snapshot_preview1" "<op>" (func $wasi_<op> <sig>))
  ;; Field name = target with "wasi_" prefix stripped (5 bytes).
  ;; Internal name = full target. Signature via $wasi_signature_for.
  ;; Silent return if signature unknown (lower would not have routed
  ;; an unknown op to wasi_<op>; this is defense-in-depth).
  (func $emit_one_wasi_import (param $target i32)
    (local $sig i32) (local $tlen i32)
    (local.set $sig (call $wasi_signature_for (local.get $target)))
    (if (i32.eqz (local.get $sig)) (then (return)))
    (local.set $tlen (call $str_len (local.get $target)))
    (call $emit_indent)
    (call $emit_cstr (i32.const 854) (i32.const 8))    ;; "(import "
    (call $emit_byte (i32.const 34))                   ;; '"'
    (call $emit_cstr (i32.const 1121) (i32.const 22))  ;; "wasi_snapshot_preview1"
    (call $emit_byte (i32.const 34))
    (call $emit_space)
    (call $emit_byte (i32.const 34))
    ;; Field name = target+9 (skip 4-byte length prefix + 5-byte "wasi_")
    (call $emit_cstr
      (i32.add (local.get $target) (i32.const 9))
      (i32.sub (local.get $tlen) (i32.const 5)))
    (call $emit_byte (i32.const 34))
    (call $emit_space)
    (call $emit_cstr (i32.const 924) (i32.const 5))    ;; "(func"
    (call $emit_space)
    (call $emit_byte (i32.const 36))                   ;; '$'
    ;; Internal name = full "wasi_<op>" payload.
    (call $emit_cstr
      (i32.add (local.get $target) (i32.const 4))
      (local.get $tlen))
    ;; Signature payload.
    (call $emit_cstr
      (i32.add (local.get $sig) (i32.const 4))
      (call $str_len (local.get $sig)))
    (call $emit_close)
    (call $emit_close)
    (call $emit_nl))

  ;; $emit_wasi_imports_inka — cursor-projected entry. Walks lowered
  ;; program for used wasi_* op-names; emits one import per. Insertion
  ;; order is graph-traversal-deterministic; both L1 iterations
  ;; produce identical import section.
  (func $emit_wasi_imports_inka (param $lowexprs i32)
    (local $used i32) (local $i i32) (local $n i32) (local $op i32)
    (local.set $used (call $collect_used_wasi_ops (local.get $lowexprs)))
    (local.set $n (call $len (local.get $used)))
    (local.set $i (i32.const 0))
    (block $done
      (loop $iter
        (br_if $done (i32.ge_u (local.get $i) (local.get $n)))
        (local.set $op (call $list_index (local.get $used) (local.get $i)))
        (call $emit_one_wasi_import (local.get $op))
        (local.set $i (i32.add (local.get $i) (i32.const 1)))
        (br $iter))))

  ;; $collect_used_wasi_ops — walk LowExpr collecting LPerform.op_name
  ;; where it starts with "wasi_". Mirrors $collect_fn_names structure
  ;; (Hβ.runtime.buffer-substrate); freezes Buffer<String> to clean
  ;; List<String> on return. Dedup via $buf_push_unique.
  (func $collect_used_wasi_ops (param $lowexprs i32) (result i32)
    (local $buf i32)
    (local.set $buf (call $buf_make (i32.const 8)))
    ;; The cursor walk over user code (graph-projected).
    (local.set $buf (call $cwo_walk_list (local.get $buf) (local.get $lowexprs)))
    ;; The substrate boundary: ops the seed's emit fabricates outside
    ;; the graph (currently $emit_start_section_static's hard-coded
    ;; proc_exit call). Each runtime-emitted op gets one line below.
    ;; As $emit_start_section_static migrates into a graph projection
    ;; (Hβ.first-light.start-section-graph-projected — peer follow-up),
    ;; the runtime-injection set shrinks to empty; the cursor walk
    ;; alone projects the import set.
    (local.set $buf (call $inject_runtime_emitted_wasi_ops (local.get $buf)))
    (call $buf_freeze (local.get $buf)))

  ;; $inject_runtime_emitted_wasi_ops — explicit residue. Each line is
  ;; one WASI op the seed's emit emits outside the graph; the function
  ;; shrinks to empty as substrate migrates entries into the graph.
  ;; Today: just proc_exit (called by _start's hand-rolled epilogue).
  (func $inject_runtime_emitted_wasi_ops (param $buf i32) (result i32)
    (call $buf_push_unique (local.get $buf) (i32.const 5120))   ;; wasi_proc_exit
    (local.get $buf))

  ;; $cwo_walk_list — iterate top-level lowexprs; threads Buffer<String>.
  (func $cwo_walk_list (param $buf i32) (param $lowexprs i32) (result i32)
    (local $i i32) (local $n i32)
    (if (i32.lt_u (local.get $lowexprs) (global.get $heap_base))
      (then (return (local.get $buf))))
    (local.set $n (call $len (local.get $lowexprs)))
    (local.set $i (i32.const 0))
    (block $done
      (loop $iter
        (br_if $done (i32.ge_u (local.get $i) (local.get $n)))
        (local.set $buf
          (call $cwo_walk (local.get $buf)
            (call $list_index (local.get $lowexprs) (local.get $i))))
        (local.set $i (i32.add (local.get $i) (i32.const 1)))
        (br $iter)))
    (local.get $buf))

  ;; $cwo_walk — recurse into one LowExpr; push wasi_* op_names into
  ;; the Buffer at any depth. Mirrors $cfn_walk's recursion shape so
  ;; every emitted fn body's perform sites get visited.
  (func $cwo_walk (param $buf i32) (param $expr i32) (result i32)
    (local $tag i32) (local $op_name i32) (local $fn_r i32) (local $body i32)
    (if (i32.lt_u (local.get $expr) (global.get $heap_base))
      (then (return (local.get $buf))))
    (local.set $tag (call $tag_of (local.get $expr)))
    ;; LPerform (331) — push op_name if it starts with "wasi_".
    (if (i32.eq (local.get $tag) (i32.const 331))
      (then
        (local.set $op_name (call $lexpr_lperform_op_name (local.get $expr)))
        (if (call $starts_with_wasi (local.get $op_name))
          (then (call $buf_push_unique (local.get $buf) (local.get $op_name))))
        (return (call $cwo_walk_list (local.get $buf)
                  (call $lexpr_lperform_args (local.get $expr))))))
    ;; LMakeClosure (311) — recurse into fn body.
    (if (i32.eq (local.get $tag) (i32.const 311))
      (then
        (local.set $fn_r (call $lexpr_lmakeclosure_fn (local.get $expr)))
        (local.set $body (call $lowfn_body (local.get $fn_r)))
        (return (call $cwo_walk_list (local.get $buf) (local.get $body)))))
    ;; LMakeContinuation (312) — same shape.
    (if (i32.eq (local.get $tag) (i32.const 312))
      (then
        (local.set $fn_r (call $lexpr_lmakecontinuation_fn (local.get $expr)))
        (local.set $body (call $lowfn_body (local.get $fn_r)))
        (return (call $cwo_walk_list (local.get $buf) (local.get $body)))))
    ;; LDeclareFn (313) — handler-arm fn body.
    (if (i32.eq (local.get $tag) (i32.const 313))
      (then
        (local.set $fn_r (call $lexpr_ldeclarefn_fn (local.get $expr)))
        (local.set $body (call $lowfn_body (local.get $fn_r)))
        (return (call $cwo_walk_list (local.get $buf) (local.get $body)))))
    ;; LLet (304) — recurse into value.
    (if (i32.eq (local.get $tag) (i32.const 304))
      (then
        (return (call $cwo_walk (local.get $buf)
                  (call $lexpr_llet_value (local.get $expr))))))
    ;; LBlock (315).
    (if (i32.eq (local.get $tag) (i32.const 315))
      (then
        (return (call $cwo_walk_list (local.get $buf)
                  (call $lexpr_lblock_stmts (local.get $expr))))))
    ;; LIf (314).
    (if (i32.eq (local.get $tag) (i32.const 314))
      (then
        (local.set $buf (call $cwo_walk (local.get $buf)
                          (call $lexpr_lif_cond (local.get $expr))))
        (local.set $buf (call $cwo_walk_list (local.get $buf)
                          (call $lexpr_lif_then (local.get $expr))))
        (return (call $cwo_walk_list (local.get $buf)
                  (call $lexpr_lif_else (local.get $expr))))))
    ;; LCall (308).
    (if (i32.eq (local.get $tag) (i32.const 308))
      (then
        (local.set $buf (call $cwo_walk (local.get $buf)
                          (call $lexpr_lcall_fn (local.get $expr))))
        (return (call $cwo_walk_list (local.get $buf)
                  (call $lexpr_lcall_args (local.get $expr))))))
    ;; LTailCall (309).
    (if (i32.eq (local.get $tag) (i32.const 309))
      (then
        (local.set $buf (call $cwo_walk (local.get $buf)
                          (call $lexpr_ltailcall_fn (local.get $expr))))
        (return (call $cwo_walk_list (local.get $buf)
                  (call $lexpr_ltailcall_args (local.get $expr))))))
    ;; LBinOp (306).
    (if (i32.eq (local.get $tag) (i32.const 306))
      (then
        (local.set $buf (call $cwo_walk (local.get $buf)
                          (call $lexpr_lbinop_l (local.get $expr))))
        (return (call $cwo_walk (local.get $buf)
                  (call $lexpr_lbinop_r (local.get $expr))))))
    ;; LMakeVariant (319).
    (if (i32.eq (local.get $tag) (i32.const 319))
      (then
        (return (call $cwo_walk_list (local.get $buf)
                  (call $lexpr_lmakevariant_args (local.get $expr))))))
    ;; LMakeList (316).
    (if (i32.eq (local.get $tag) (i32.const 316))
      (then
        (return (call $cwo_walk_list (local.get $buf)
                  (call $lexpr_lmakelist_elems (local.get $expr))))))
    ;; LMakeTuple (317).
    (if (i32.eq (local.get $tag) (i32.const 317))
      (then
        (return (call $cwo_walk_list (local.get $buf)
                  (call $lexpr_lmaketuple_elems (local.get $expr))))))
    ;; LReturn (310).
    (if (i32.eq (local.get $tag) (i32.const 310))
      (then
        (return (call $cwo_walk (local.get $buf)
                  (call $lexpr_lreturn_x (local.get $expr))))))
    ;; LHandle (332) — handler body.
    (if (i32.eq (local.get $tag) (i32.const 332))
      (then
        (return (call $cwo_walk (local.get $buf)
                  (call $lexpr_lhandle_body (local.get $expr))))))
    ;; LHandleWith (329) — handle body + handler expression.
    (if (i32.eq (local.get $tag) (i32.const 329))
      (then
        (local.set $buf (call $cwo_walk (local.get $buf)
                          (call $lexpr_lhandlewith_body (local.get $expr))))
        (return (call $cwo_walk (local.get $buf)
                  (call $lexpr_lhandlewith_handler (local.get $expr))))))
    (local.get $buf))

  ;; $buf_push_unique — push if no existing buffer entry str_eq's str.
  ;; O(N×L); fine because the WASI op-name set has < 20 distinct
  ;; values across the wheel + this loop runs once per emit pass.
  (func $buf_push_unique (param $buf i32) (param $str i32)
    (local $count i32) (local $i i32) (local $existing i32)
    (local.set $count (call $buf_count (local.get $buf)))
    (local.set $i (i32.const 0))
    (block $done
      (loop $iter
        (br_if $done (i32.ge_u (local.get $i) (local.get $count)))
        (local.set $existing
          (call $list_index (call $buf_data (local.get $buf)) (local.get $i)))
        (if (call $str_eq (local.get $existing) (local.get $str))
          (then (return)))
        (local.set $i (i32.add (local.get $i) (i32.const 1)))
        (br $iter)))
    (call $buf_push (local.get $buf) (local.get $str)))

  ;; $emit_funcref_section deleted — its (table) + (elem) emission is
  ;; subsumed by $emit_fn_table_and_globals iterating the funcref ledger.

  ;; ─── Data Section Emission ────────────────────────────────────────
  (func $emit_string_section
    (local $i i32) (local $n i32) (local $entry i32)
    (local $str i32) (local $offset i32)
    (local.set $n (call $emit_string_table_count))
    (local.set $i (i32.const 0))
    (block $done (loop $iter
      (br_if $done (i32.ge_u (local.get $i) (local.get $n)))
      (local.set $entry (call $emit_string_table_at (local.get $i)))
      (local.set $str (call $record_get (local.get $entry) (i32.const 0)))
      (local.set $offset (call $record_get (local.get $entry) (i32.const 1)))
      (call $emit_indent)
      (call $emit_cstr (i32.const 912) (i32.const 6)) ;; "(data "
      (call $emit_cstr (i32.const 560) (i32.const 11)) ;; "(i32.const "
      (call $emit_int (local.get $offset))
      (call $emit_close)
      (call $emit_space)
      (call $emit_byte (i32.const 34)) ;; '"'
      ;; Per Hβ.first-light.string-data-segment-escape (2026-05-07) +
      ;; Hβ.first-light.string-data-segment-len-prefix (2026-05-07):
      ;; the graph carries Mentl's `[len:i32][bytes...]` string layout.
      ;; Emit projects ENTIRE string (length-prefix + bytes), not just
      ;; bytes — runtime `load_i32(s)` must read the length prefix.
      ;; Pre-substrate the prefix was dropped → load_i32 read the
      ;; first 4 bytes of payload as length → fd_write got nonsense
      ;; lengths and returned errno 48 (__WASI_ERRNO_NOTCAPABLE / GC).
      ;; Both protocol violations healed at the read-site.
      (call $emit_str_data_escaped
        (local.get $str)
        (i32.add (call $str_len (local.get $str)) (i32.const 4)))
      (call $emit_byte (i32.const 34)) ;; '"'
      (call $emit_close)
      (call $emit_nl)
      (local.set $i (i32.add (local.get $i) (i32.const 1)))
      (br $iter))))

  ;; ─── _start Section Emission ──────────────────────────────────────
  ;; Per src/backends/wasm.mn emit_start: emits `(func $_start (export
  ;; "_start") ...)`. If "main" appears in the funcref table, calls it
  ;; and drops the result before proc_exit. Export annotation MUST be
  ;; inside the (func ...) form per WAT spec.
  (func $emit_start_section
    (local $main_str i32)
    (local.set $main_str (call $str_alloc (i32.const 4)))
    (i32.store8 (i32.add (local.get $main_str) (i32.const 4)) (i32.const 109)) ;; 'm'
    (i32.store8 (i32.add (local.get $main_str) (i32.const 5)) (i32.const 97))  ;; 'a'
    (i32.store8 (i32.add (local.get $main_str) (i32.const 6)) (i32.const 105)) ;; 'i'
    (i32.store8 (i32.add (local.get $main_str) (i32.const 7)) (i32.const 110)) ;; 'n'
    ;; (func $_start (export "_start")
    (call $emit_indent)
    (call $emit_cstr (i32.const 584) (i32.const 6)) ;; "(func "
    (call $emit_byte (i32.const 36))                 ;; '$'
    (call $emit_cstr (i32.const 1591) (i32.const 6)) ;; "_start"
    (call $emit_cstr (i32.const 1500) (i32.const 19)) ;; " (export \"_start\")"
    (call $emit_nl)
    (call $indent_inc)
    ;; Body: if "main" is registered, call it and drop
    (if (i32.ge_s (call $emit_funcref_lookup (local.get $main_str)) (i32.const 0))
      (then
        (call $emit_indent)
        (call $emit_cstr (i32.const 572) (i32.const 6)) ;; "(call "
        (call $emit_byte (i32.const 36))
        (call $emit_cstr (i32.add (local.get $main_str) (i32.const 4)) (i32.const 4)) ;; "main"
        (call $emit_space)
        (call $emit_cstr (i32.const 560) (i32.const 11)) ;; "(i32.const "
        (call $emit_byte (i32.const 48))                  ;; '0'
        (call $emit_close)
        (call $emit_close)
        (call $emit_nl)
        (call $emit_indent)
        (call $emit_cstr (i32.const 578) (i32.const 6)) ;; "(drop "
        (call $emit_close)
        (call $emit_nl)))
    ;; (call $wasi_proc_exit (i32.const 0))
    (call $emit_indent)
    (call $emit_cstr (i32.const 572) (i32.const 6)) ;; "(call "
    (call $emit_byte (i32.const 36))
    (call $emit_cstr (i32.const 1221) (i32.const 9)) ;; "proc_exit"
    (call $emit_space)
    (call $emit_cstr (i32.const 560) (i32.const 11)) ;; "(i32.const "
    (call $emit_byte (i32.const 48))                  ;; '0'
    (call $emit_close)
    (call $emit_close)
    (call $emit_nl)
    ;; Close func
    (call $indent_dec)
    (call $emit_indent)
    (call $emit_close)
    (call $emit_nl))

  ;; ─── Phase H: Function body emission ─────────────────────────────────
  ;; Per src/backends/wasm.mn:848-963 emit_functions + emit_fn_body.
  ;; Deep-walks the LowExpr list to find LMakeClosure nodes and emits
  ;; each as a (func $name ...) WAT definition. Also collects fn names
  ;; for the funcref table + index globals.

  ;; $collect_fn_names + $cfn_walk + $cfn_walk_list — DELETED
  ;; post-consolidation. The funcref ledger ($emit_funcref_table_ptr)
  ;; is populated by $emit_fn_body via $emit_funcref_register_first as
  ;; the actual emit walk runs; $emit_fn_table_and_globals then
  ;; iterates that ledger. One walk, one ledger. Drift 7 closure.

  ;; ─── Function Type Section ────────────────────────────────────────
  ;; Every call_indirect references $ftN, where N includes the implicit
  ;; __state parameter. The LowExpr graph determines the required ceiling.
  (func $emit_type_section (param $lowexprs i32)
    (local $observed i32) (local $max i32)
    (local.set $observed (call $max_arity_in (local.get $lowexprs) (i32.const 0)))
    (local.set $max (local.get $observed))
    (if (i32.lt_s (local.get $max) (i32.const 1))
      (then (local.set $max (i32.const 1))))
    (call $emit_type_decls (i32.const 0) (local.get $max)))

  (func $max_arity_in (param $exprs i32) (param $acc i32) (result i32)
    (local $i i32) (local $n i32) (local $best i32) (local $candidate i32)
    (local.set $best (local.get $acc))
    (local.set $n (call $len (local.get $exprs)))
    (local.set $i (i32.const 0))
    (block $done
      (loop $iter
        (br_if $done (i32.ge_u (local.get $i) (local.get $n)))
        (local.set $candidate
          (call $max_arity_expr (call $list_index (local.get $exprs) (local.get $i))))
        (local.set $best (call $max_i32 (local.get $best) (local.get $candidate)))
        (local.set $i (i32.add (local.get $i) (i32.const 1)))
        (br $iter)))
    (local.get $best))

  (func $max_arity_expr (param $expr i32) (result i32)
    (local $tag i32) (local $inner i32) (local $fn_r i32)
    (local $a i32) (local $b i32)
    (local.set $tag (call $tag_of (local.get $expr)))
    ;; LCall / LTailCall / LSuspend: user args + implicit __state.
    (if (i32.eq (local.get $tag) (i32.const 308))
      (then
        (local.set $a (i32.add (call $len (call $lexpr_lcall_args (local.get $expr))) (i32.const 1)))
        (local.set $b (call $max_arity_expr (call $lexpr_lcall_fn (local.get $expr))))
        (local.set $b (call $max_i32 (local.get $b)
          (call $max_arity_in (call $lexpr_lcall_args (local.get $expr)) (i32.const 0))))
        (return (call $max_i32 (local.get $a) (local.get $b)))))
    (if (i32.eq (local.get $tag) (i32.const 309))
      (then
        (local.set $a (i32.add (call $len (call $lexpr_ltailcall_args (local.get $expr))) (i32.const 1)))
        (local.set $b (call $max_arity_expr (call $lexpr_ltailcall_fn (local.get $expr))))
        (local.set $b (call $max_i32 (local.get $b)
          (call $max_arity_in (call $lexpr_ltailcall_args (local.get $expr)) (i32.const 0))))
        (return (call $max_i32 (local.get $a) (local.get $b)))))
    (if (i32.eq (local.get $tag) (i32.const 325))
      (then
        (local.set $a (i32.add (call $len (call $lexpr_lsuspend_args (local.get $expr))) (i32.const 1)))
        (local.set $b (call $max_arity_expr (call $lexpr_lsuspend_fn (local.get $expr))))
        (local.set $b (call $max_i32 (local.get $b)
          (call $max_arity_in (call $lexpr_lsuspend_args (local.get $expr)) (i32.const 0))))
        (local.set $b (call $max_i32 (local.get $b)
          (call $max_arity_in (call $lexpr_lsuspend_evs (local.get $expr)) (i32.const 0))))
        (return (call $max_i32 (local.get $a) (local.get $b)))))
    ;; Direct perform arity is exactly its argument count.
    (if (i32.eq (local.get $tag) (i32.const 331))
      (then
        (return
          (call $max_i32
            (call $len (call $lexpr_lperform_args (local.get $expr)))
            (call $max_arity_in (call $lexpr_lperform_args (local.get $expr)) (i32.const 0))))))
    (if (i32.eq (local.get $tag) (i32.const 333))
      (then
        (return
          (call $max_i32
            (i32.add (call $len (call $lexpr_levperform_args (local.get $expr))) (i32.const 1))
            (call $max_arity_in (call $lexpr_levperform_args (local.get $expr)) (i32.const 0))))))
    ;; LLet recurses into its value.
    (if (i32.eq (local.get $tag) (i32.const 304))
      (then (return (call $max_arity_expr (call $lexpr_llet_value (local.get $expr))))))
    ;; LMakeClosure contributes its own W7 arity and body call sites.
    (if (i32.eq (local.get $tag) (i32.const 311))
      (then
        (local.set $fn_r (call $lexpr_lmakeclosure_fn (local.get $expr)))
        (return
          (call $max_i32
            (i32.add (call $lowfn_arity (local.get $fn_r)) (i32.const 1))
            (call $max_arity_in (call $lowfn_body (local.get $fn_r)) (i32.const 0))))))
    (if (i32.eq (local.get $tag) (i32.const 312))
      (then
        (local.set $fn_r (call $lexpr_lmakecontinuation_fn (local.get $expr)))
        (return
          (call $max_i32
            (i32.add (call $lowfn_arity (local.get $fn_r)) (i32.const 1))
            (call $max_arity_in (call $lowfn_body (local.get $fn_r)) (i32.const 0))))))
    ;; LDeclareFn (313) — handler-arm fn contributes its arity + body.
    ;; Per Lock #1 same shape as LMakeClosure (311). The +1 accounts for
    ;; the implicit __state parameter every fn in the W7 calling
    ;; convention carries (per emit_fn_body line 906-909).
    (if (i32.eq (local.get $tag) (i32.const 313))
      (then
        (local.set $fn_r (call $lexpr_ldeclarefn_fn (local.get $expr)))
        (return
          (call $max_i32
            (i32.add (call $lowfn_arity (local.get $fn_r)) (i32.const 1))
            (call $max_arity_in (call $lowfn_body (local.get $fn_r)) (i32.const 0))))))
    ;; LHandle (332) — recurse into body for arity contributions.
    (if (i32.eq (local.get $tag) (i32.const 332))
      (then (return (call $max_arity_expr (call $lexpr_lhandle_body (local.get $expr))))))
    ;; LHandleWith (329) — max(body, handler).
    (if (i32.eq (local.get $tag) (i32.const 329))
      (then
        (return
          (call $max_i32
            (call $max_arity_expr (call $lexpr_lhandlewith_body (local.get $expr)))
            (call $max_arity_expr (call $lexpr_lhandlewith_handler (local.get $expr)))))))
    ;; Common containers used by current lower output.
    (if (i32.eq (local.get $tag) (i32.const 306))
      (then
        (return
          (call $max_i32
            (call $max_arity_expr (call $lexpr_lbinop_l (local.get $expr)))
            (call $max_arity_expr (call $lexpr_lbinop_r (local.get $expr)))))))
    (if (i32.eq (local.get $tag) (i32.const 307))
      (then (return (call $max_arity_expr (call $lexpr_lunaryop_x (local.get $expr))))))
    (if (i32.eq (local.get $tag) (i32.const 310))
      (then (return (call $max_arity_expr (call $lexpr_lreturn_x (local.get $expr))))))
    (if (i32.eq (local.get $tag) (i32.const 315))
      (then (return (call $max_arity_in (call $lexpr_lblock_stmts (local.get $expr)) (i32.const 0)))))
    (if (i32.eq (local.get $tag) (i32.const 316))
      (then (return (call $max_arity_in (call $lexpr_lmakelist_elems (local.get $expr)) (i32.const 0)))))
    (if (i32.eq (local.get $tag) (i32.const 317))
      (then (return (call $max_arity_in (call $lexpr_lmaketuple_elems (local.get $expr)) (i32.const 0)))))
    (if (i32.eq (local.get $tag) (i32.const 318))
      (then (return (call $max_arity_in (call $lexpr_lmakerecord_fields (local.get $expr)) (i32.const 0)))))
    (if (i32.eq (local.get $tag) (i32.const 319))
      (then (return (call $max_arity_in (call $lexpr_lmakevariant_args (local.get $expr)) (i32.const 0)))))
    (if (i32.eq (local.get $tag) (i32.const 334))
      (then (return (call $max_arity_expr (call $lexpr_lfieldload_record (local.get $expr))))))
    (i32.const 0))

  (func $max_i32 (param $a i32) (param $b i32) (result i32)
    (if (result i32) (i32.gt_s (local.get $a) (local.get $b))
      (then (local.get $a))
      (else (local.get $b))))

  (func $emit_type_decls (param $i i32) (param $max i32)
    (block $done
      (loop $iter
        (br_if $done (i32.gt_s (local.get $i) (local.get $max)))
        (call $emit_indent)
        (call $emit_cstr (i32.const 4208) (i32.const 9)) ;; "(type $ft"
        (call $emit_int (local.get $i))
        (call $emit_cstr (i32.const 4217) (i32.const 6)) ;; " (func"
        (call $emit_param_types (local.get $i))
        (call $emit_cstr (i32.const 4133) (i32.const 13)) ;; " (result i32)"
        (call $emit_close)
        (call $emit_close)
        (call $emit_nl)
        (local.set $i (i32.add (local.get $i) (i32.const 1)))
        (br $iter))))

  (func $emit_param_types (param $n i32)
    (block $done
      (loop $iter
        (br_if $done (i32.eqz (local.get $n)))
        (call $emit_cstr (i32.const 1244) (i32.const 12)) ;; " (param i32)"
        (local.set $n (i32.sub (local.get $n) (i32.const 1)))
        (br $iter))))

  ;; $emit_fn_table_and_globals — emit (table $fns N funcref) + (elem ...)
  ;; + (global $name_idx i32 (i32.const N)) per fn. Iterates the funcref
  ;; ledger ($emit_funcref_count + _at) which $emit_fn_body populates as
  ;; it runs; must be called AFTER $emit_functions in $mentl_emit.
  (func $emit_fn_table_and_globals
    (local $n i32) (local $i i32)
    (local.set $n (call $emit_funcref_count))
    (if (i32.eqz (local.get $n)) (then (return)))
    ;; (table $fns N funcref)
    (call $emit_indent)
    (call $emit_cstr (i32.const 4160) (i32.const 12)) ;; "(table $fns "
    (call $emit_int (local.get $n))
    (call $emit_cstr (i32.const 4172) (i32.const 10)) ;; " funcref)\n"
    ;; (elem $fns (i32.const 0) $name1 $name2 ...)
    (call $emit_indent)
    (call $emit_cstr (i32.const 4182) (i32.const 24)) ;; "(elem $fns (i32.const 0)"
    (local.set $i (i32.const 0))
    (block $done
      (loop $iter
        (br_if $done (i32.ge_u (local.get $i) (local.get $n)))
        (call $emit_byte (i32.const 32))  ;; ' '
        (call $emit_byte (i32.const 36))  ;; '$'
        (call $emit_str (call $emit_funcref_at (local.get $i)))
        (local.set $i (i32.add (local.get $i) (i32.const 1)))
        (br $iter)))
    (call $emit_cstr (i32.const 4206) (i32.const 2)) ;; ")\n"
    ;; (global $name_idx i32 (i32.const N)) per fn
    (local.set $i (i32.const 0))
    (block $done2
      (loop $iter2
        (br_if $done2 (i32.ge_u (local.get $i) (local.get $n)))
        (call $emit_indent)
        (call $emit_cstr (i32.const 862) (i32.const 8))  ;; "(global "
        (call $emit_byte (i32.const 36))                  ;; '$'
        (call $emit_str (call $emit_funcref_at (local.get $i)))
        (call $emit_cstr (i32.const 4104) (i32.const 20)) ;; "_idx i32 (i32.const "
        (call $emit_int (local.get $i))
        (call $emit_close)  ;; close (i32.const N)
        (call $emit_close)  ;; close (global ...)
        (call $emit_nl)
        (local.set $i (i32.add (local.get $i) (i32.const 1)))
        (br $iter2))))

  ;; $emit_static_top_closures — module-level closure records for every
  ;; fn in the funcref ledger. Each record is [fn_idx:i32,
  ;; capture_count=0:i32] at address 256 + slot*8, with a global $name
  ;; pointing at the record. The funcref ledger IS the canonical
  ;; projection (per protocol_canonical_projection_pattern.md): the
  ;; index in the ledger IS the fn_idx; the name IS the global label.
  ;; Top-level fns get referenced via (global.get $name); inline
  ;; closures get runtime-allocated via emit_lmakeclosure with
  ;; per-call captures (the static record at $name is unused for
  ;; those). 8 bytes per inline lambda is negligible noise; one
  ;; ledger, one walk closes drift 7 + drift 9 from the prior parallel
  ;; $top_fn_names ledger.
  (func $emit_static_top_closures
    (local $i i32) (local $n i32) (local $name i32)
    (local $addr i32)
    (local.set $n (call $emit_funcref_count))
    (local.set $i (i32.const 0))
    (block $done
      (loop $iter
        (br_if $done (i32.ge_u (local.get $i) (local.get $n)))
        (local.set $name (call $emit_funcref_at (local.get $i)))
        (local.set $addr (i32.add (i32.const 256) (i32.mul (local.get $i) (i32.const 8))))
        (call $emit_indent)
        (call $emit_cstr (i32.const 912) (i32.const 6))  ;; "(data "
        (call $emit_i32_const (local.get $addr))
        (call $emit_space)
        (call $emit_byte (i32.const 34))
        (call $emit_le4_escape (local.get $i))
        (call $emit_le4_escape (i32.const 0))
        (call $emit_byte (i32.const 34))
        (call $emit_close)
        (call $emit_nl)
        (call $emit_indent)
        (call $emit_cstr (i32.const 862) (i32.const 8))  ;; "(global "
        (call $emit_byte (i32.const 36))
        (call $emit_str (local.get $name))
        (call $emit_cstr (i32.const 4224) (i32.const 5)) ;; " i32 "
        (call $emit_i32_const (local.get $addr))
        (call $emit_close)
        (call $emit_nl)
        (local.set $i (i32.add (local.get $i) (i32.const 1)))
        (br $iter))))

  (func $emit_le4_escape (param $n i32)
    (call $emit_byte_escape (i32.and (local.get $n) (i32.const 255)))
    (call $emit_byte_escape (i32.and (i32.shr_u (local.get $n) (i32.const 8)) (i32.const 255)))
    (call $emit_byte_escape (i32.and (i32.shr_u (local.get $n) (i32.const 16)) (i32.const 255)))
    (call $emit_byte_escape (i32.and (i32.shr_u (local.get $n) (i32.const 24)) (i32.const 255))))

  (func $emit_byte_escape (param $b i32)
    (call $emit_byte (i32.const 92)) ;; '\'
    (call $emit_hex_digit (i32.shr_u (local.get $b) (i32.const 4)))
    (call $emit_hex_digit (i32.and (local.get $b) (i32.const 15))))

  ;; ─── $emit_str_data_escaped — WAT-context-correct byte projection ──
  ;; Per Hβ.first-light.string-data-segment-escape (2026-05-07).
  ;; Walks `[ptr, ptr+n)`; projects each byte for WAT data-segment
  ;; string syntax. Printable ASCII (0x20..0x7e, except `"` and `\`)
  ;; flows raw. `"` (0x22) and `\` (0x5c) are special in WAT's string
  ;; literal syntax — emitted as `\<hex>`. Control chars (< 0x20),
  ;; DEL (0x7f), and high bytes (>= 0x80) emitted as `\<hex>`.
  ;;
  ;; Drift refused: 1 (no vtable; direct byte-class dispatch); 6
  ;; (no special-case for ASCII vs Unicode — uniform high/low byte
  ;; check); 8 (sentinel-int dispatch on byte value, structural).
  (func $emit_str_data_escaped (param $ptr i32) (param $n i32)
    (local $i i32) (local $b i32)
    (local.set $i (i32.const 0))
    (block $done
      (loop $iter
        (br_if $done (i32.ge_u (local.get $i) (local.get $n)))
        (local.set $b (i32.load8_u (i32.add (local.get $ptr) (local.get $i))))
        ;; `"` (34) → \22 ; `\` (92) → \5c
        (if (i32.or
              (i32.eq (local.get $b) (i32.const 34))
              (i32.eq (local.get $b) (i32.const 92)))
          (then (call $emit_byte_escape (local.get $b)))
          (else
            ;; Control chars (< 0x20) and high bytes (>= 0x7f) → hex-escape.
            (if (i32.or
                  (i32.lt_u (local.get $b) (i32.const 32))
                  (i32.ge_u (local.get $b) (i32.const 127)))
              (then (call $emit_byte_escape (local.get $b)))
              (else (call $emit_byte (local.get $b))))))
        (local.set $i (i32.add (local.get $i) (i32.const 1)))
        (br $iter))))

  (func $emit_hex_digit (param $d i32)
    (if (i32.lt_u (local.get $d) (i32.const 10))
      (then
        (call $emit_byte (i32.add (i32.const 48) (local.get $d)))
        (return)))
    (call $emit_byte (i32.add (i32.const 87) (local.get $d))))

  (func $emit_local_decl_cstr (param $offset i32) (param $n i32)
    (call $emit_cstr (i32.const 4146) (i32.const 9)) ;; " (local $"
    (call $emit_cstr (local.get $offset) (local.get $n))
    (call $emit_cstr (i32.const 4155) (i32.const 5))) ;; " i32)"

  (func $emit_local_decl_str (param $name i32)
    (call $emit_cstr (i32.const 4146) (i32.const 9)) ;; " (local $"
    (call $emit_str (local.get $name))
    (call $emit_cstr (i32.const 4155) (i32.const 5))) ;; " i32)"

  (func $emit_standard_locals
    (call $emit_local_decl_str (i32.const 2244))      ;; state_tmp
    (call $emit_local_decl_str (i32.const 1568))      ;; variant_tmp
    (call $emit_local_decl_str (i32.const 1552))      ;; record_tmp
    (call $emit_local_decl_str (i32.const 1536))      ;; tuple_tmp
    (call $emit_local_decl_cstr (i32.const 4248) (i32.const 9))  ;; scrut_tmp
    (call $emit_local_decl_cstr (i32.const 4232) (i32.const 14)) ;; callee_closure
    (call $emit_local_decl_str (i32.const 1856))      ;; alloc_size
    (call $emit_local_decl_cstr (i32.const 4260) (i32.const 6))) ;; loop_i

  ;; $emit_fn_body — emit a single (func $name (param $__state i32) ...)
  ;; Per wasm.mn:930-962 emit_fn_body. W7 calling convention.
  (func $emit_fn_body (param $fn_r i32)
    (local $name i32) (local $params i32) (local $body i32)
    (local $arity i32) (local $i i32)
    (local.set $name (call $lowfn_emit_name (local.get $fn_r)))
    ;; Idempotent emission per LFn name — closure-capture dedup via
    ;; the existing funcref ledger. $emit_funcref_register dedups
    ;; internally (lookup-or-append); a name's PRESENCE in the ledger
    ;; is the "already emitted" signal here. Per protocol_canonical_
    ;; projection_pattern.md: one ledger, two consumers (this call
    ;; site + $emit_funcref_section).
    (if (i32.ge_s (call $emit_funcref_lookup (local.get $name)) (i32.const 0))
      (then (return)))
    (drop (call $emit_funcref_register (local.get $name)))
    (local.set $arity  (call $lowfn_arity  (local.get $fn_r)))
    (local.set $params (call $lowfn_params (local.get $fn_r)))
    (local.set $body   (call $lowfn_body   (local.get $fn_r)))
    ;; (func $name
    (call $emit_indent)
    (call $emit_cstr (i32.const 924) (i32.const 5)) ;; "(func"
    (call $emit_byte (i32.const 32))                ;; ' '
    (call $emit_byte (i32.const 36))                ;; '$'
    (call $emit_str (local.get $name))
    ;; (param $__state i32)
    (call $emit_cstr (i32.const 4124) (i32.const 9)) ;; " (param $"
    (call $emit_cstr (i32.const 4096) (i32.const 7)) ;; "__state"
    (call $emit_cstr (i32.const 4155) (i32.const 5)) ;; " i32)"
    ;; Emit user params
    (local.set $i (i32.const 0))
    (block $pdone
      (loop $piter
        (br_if $pdone (i32.ge_u (local.get $i) (local.get $arity)))
        (call $emit_cstr (i32.const 4124) (i32.const 9)) ;; " (param $"
        (call $emit_str (call $list_index (local.get $params) (local.get $i)))
        (call $emit_cstr (i32.const 4155) (i32.const 5)) ;; " i32)"
        (local.set $i (i32.add (local.get $i) (i32.const 1)))
        (br $piter)))
    ;; (result i32)
    (call $emit_cstr (i32.const 4133) (i32.const 13)) ;; " (result i32)"
    ;; Standard locals per W7 + emit arms that lower into scratch slots.
    (call $emit_standard_locals)
    ;; Per-fn ledger reset — $emit_standard_locals' fixed scratch names
    ;; are emitted unconditionally above; the ledger tracks only
    ;; LowPat-bound names that emit_let_locals + emit_pat_locals project.
    ;; Per Hβ.first-light.match-arm-binding-name-uniqueness Lock #3 —
    ;; this is the first wiring of $emit_fn_reset (state.wat exports it
    ;; but no caller existed pre-this-commit).
    (call $emit_fn_reset)
    ;; Pre-declare LLet locals from body
    (call $emit_let_locals (local.get $body))
    ;; Per Hβ.first-light.alloc-handle-locals (2026-05-07): pre-declare
    ;; per-handle locals for nested LMakeVariant/Record/Tuple. The
    ;; graph encodes uniqueness via $lexpr_handle; each construction
    ;; gets its own `$variant_<H>` / `$record_<H>` / `$tuple_<H>`
    ;; local. Without this, nested ctors trample the shared `*_tmp`
    ;; locals (Branch(Leaf, 5, Branch(Leaf, 7, Leaf)) returned 7
    ;; instead of 12 because outer's variant_tmp got reassigned to
    ;; inner's allocation). ULTIMATE FIX, no band-aid — emit reads
    ;; the graph instead of fabricating shared state.
    (call $emit_alloc_handle_locals (local.get $body))
    (call $emit_nl)
    ;; Emit body expressions
    (call $indent_inc)
    (call $emit_lowir_program (local.get $body))
    (call $indent_dec)
    (call $emit_indent)
    (call $emit_close)
    (call $emit_nl))

  ;; $emit_let_locals — walk body LowExpr list, emit (local $name i32)
  ;; for each LLet (including nested ones inside LBlock containers
  ;; per Hβ.first-light.letstmt-destructure-let-locals: PCon
  ;; destructure produces LBlock containing LLet sequences). Stops
  ;; at LMakeClosure / LMakeContinuation boundaries — those are
  ;; SEPARATE function bodies; their locals belong to their own
  ;; emit_fn_body call.
  ;;
  ;; Eight interrogations on this descent site:
  ;;  1. Graph?      LLet's name is the local label; LBlock's stmts
  ;;                 list is the structure to recurse into.
  ;;  2. Handler?    Direct emit; @resume=OneShot.
  ;;  3. Verb?       N/A — structural walk.
  ;;  4. Row?        EmitMemory effect performed (writes to output).
  ;;  5. Ownership?  exprs borrowed throughout.
  ;;  6. Refinement? LLet's handle ≥ 0.
  ;;  7. Gradient?   N/A — orthogonal to gradient.
  ;;  8. Reason?     N/A at emit-time.
  ;;
  ;; Drift modes refused:
  ;;  - Drift 1 (vtable): direct tag-int dispatch; no table.
  ;;  - Drift 6 (special): same descent for outer block AND nested
  ;;                       LBlock; no special-case for first-level.
  ;;  - Drift 9 (deferred): all emit-relevant containers walked.
  (func $emit_let_locals (param $exprs i32)
    (local $i i32) (local $n i32) (local $expr i32) (local $tag i32)
    (local.set $n (call $len (local.get $exprs)))
    (local.set $i (i32.const 0))
    (block $done
      (loop $iter
        (br_if $done (i32.ge_u (local.get $i) (local.get $n)))
        (local.set $expr (call $list_index (local.get $exprs) (local.get $i)))
        (local.set $tag (call $tag_of (local.get $expr)))
        ;; LLet (304) — declare local IFF not already declared for current
        ;; fn (Hβ.first-light.match-arm-binding-name-uniqueness Lock #1
        ;; + §A.5b LLet-cross-block coverage); recurse into value either
        ;; way (since the value may itself contain nested LLets via PCon
        ;; destructure or block expressions).
        (if (i32.eq (local.get $tag) (i32.const 304))
          (then
            (if (call $emit_fn_local_check (call $lexpr_llet_name (local.get $expr)))
              (then
                (call $emit_cstr (i32.const 4146) (i32.const 9)) ;; " (local $"
                (call $emit_str (call $lexpr_llet_name (local.get $expr)))
                (call $emit_cstr (i32.const 4155) (i32.const 5)))) ;; " i32)"
            ;; Recurse into the value (may contain nested LBlocks via
            ;; PCon destructure or other compound expressions).
            (call $emit_let_locals_walk
                  (call $lexpr_llet_value (local.get $expr)))))
        ;; LBlock (315) — recurse into stmts list to find nested LLets.
        (if (i32.eq (local.get $tag) (i32.const 315))
          (then
            (call $emit_let_locals (call $lexpr_lblock_stmts (local.get $expr)))))
        ;; LIf (314) — recurse into branches.
        (if (i32.eq (local.get $tag) (i32.const 314))
          (then
            (call $emit_let_locals (call $lexpr_lif_then (local.get $expr)))
            (call $emit_let_locals (call $lexpr_lif_else (local.get $expr)))))
        ;; LMatch (321) — recurse into scrutinee + each arm. Per
        ;; Hβ.first-light.match-arm-pat-binding-local-decl Lock #1:
        ;; arms' patterns introduce LPVar bindings (potentially nested);
        ;; arms' bodies may contain LLet bindings.
        (if (i32.eq (local.get $tag) (i32.const 321))
          (then
            (call $emit_let_locals_walk
              (call $lexpr_lmatch_scrut (local.get $expr)))
            (call $emit_match_arm_locals
              (call $lexpr_lmatch_arms (local.get $expr)))))
        ;; LMakeClosure (311) / LMakeContinuation (312) / LDeclareFn (313)
        ;; — fn boundary. Their bodies belong to their own fn body's
        ;; emit_let_locals invocation (chained from $emit_fn_body line 932).
        ;; LHandle (332) / LHandleWith (329) bodies remain in the parent
        ;; fn's local-decl scope — they are control structures, not fn
        ;; boundaries. Per Lock #1 + emit_handler.wat:357-361 (lhandle
        ;; sub-emits body inline). Future named follow-up if a wheel
        ;; example surfaces local-decls inside an LHandle body that
        ;; aren't picked up by the current LBlock/LIf/LMatch recursion.
        ;; All other tags: no LowExpr children with LLet to declare.
        (local.set $i (i32.add (local.get $i) (i32.const 1)))
        (br $iter))))

  ;; Single-expr walker companion to $emit_let_locals (which takes a
  ;; list). Used when recursing into LLet's value (a single expr).
  (func $emit_let_locals_walk (param $expr i32)
    (local $tag i32)
    (if (i32.lt_u (local.get $expr) (global.get $heap_base))
      (then (return)))
    (local.set $tag (call $tag_of (local.get $expr)))
    (if (i32.eq (local.get $tag) (i32.const 315))
      (then
        (call $emit_let_locals (call $lexpr_lblock_stmts (local.get $expr)))
        (return)))
    (if (i32.eq (local.get $tag) (i32.const 314))
      (then
        (call $emit_let_locals (call $lexpr_lif_then (local.get $expr)))
        (call $emit_let_locals (call $lexpr_lif_else (local.get $expr)))
        (return)))
    (if (i32.eq (local.get $tag) (i32.const 321))
      (then
        (call $emit_let_locals_walk (call $lexpr_lmatch_scrut (local.get $expr)))
        (call $emit_match_arm_locals (call $lexpr_lmatch_arms (local.get $expr)))
        (return)))
    (return))

  ;; ─── $emit_alloc_handle_locals — per-handle local decls ──────────
  ;; Per Hβ.first-light.alloc-handle-locals (2026-05-07). Walks a list
  ;; of LowExprs (typically a fn body); for every LMakeVariant (319),
  ;; LMakeRecord (318), or LMakeTuple (317) encountered at any depth,
  ;; emits a `(local $<prefix>_<handle> i32)` decl. Then recurses into
  ;; sub-LowExpr containers (LLet value, LBlock stmts, LIf branches,
  ;; LMatch arms, plus the alloc-ctors' own field/elem lists).
  ;; Drift refused: 1 (no vtable, direct tag dispatch); 7 (one walk
  ;; over the graph, not parallel scratch tables); 8 (positional
  ;; tag-int dispatch, no mode flag); 9 (every relevant container
  ;; recursed into).
  (func $emit_alloc_handle_locals (param $exprs i32)
    (local $i i32) (local $n i32) (local $expr i32)
    (local.set $n (call $len (local.get $exprs)))
    (local.set $i (i32.const 0))
    (block $done
      (loop $iter
        (br_if $done (i32.ge_u (local.get $i) (local.get $n)))
        (local.set $expr (call $list_index (local.get $exprs) (local.get $i)))
        (call $emit_alloc_handle_locals_walk (local.get $expr))
        (local.set $i (i32.add (local.get $i) (i32.const 1)))
        (br $iter))))

  ;; Single-expr walker companion. Recursive descent over LowExpr
  ;; tree; emits per-handle locals for alloc-ctors; recurses into all
  ;; containers. Stops at fn boundaries (LMakeClosure/Continuation/
  ;; LDeclareFn) — those are separate fn bodies with their own preamble.
  (func $emit_alloc_handle_locals_walk (param $expr i32)
    (local $tag i32) (local $handle i32) (local $name i32)
    (if (i32.lt_u (local.get $expr) (global.get $heap_base))
      (then (return)))
    (local.set $tag (call $tag_of (local.get $expr)))
    ;; LMakeVariant (319) — emit `(local $variant_<H> i32)` + recurse into args.
    (if (i32.eq (local.get $tag) (i32.const 319))
      (then
        (local.set $handle (call $lexpr_handle (local.get $expr)))
        ;; Skip nullary ctors — they take the sentinel path, no alloc.
        (if (call $len (call $lexpr_lmakevariant_args (local.get $expr)))
          (then
            (local.set $name
              (call $str_concat (i32.const 1600)            ;; "variant_"
                                (call $int_to_str (local.get $handle))))
            (call $emit_local_decl_str (local.get $name))
            (call $emit_alloc_handle_locals
              (call $lexpr_lmakevariant_args (local.get $expr)))))
        (return)))
    ;; LMakeRecord (318) — emit `(local $record_<H> i32)` + recurse.
    (if (i32.eq (local.get $tag) (i32.const 318))
      (then
        (local.set $handle (call $lexpr_handle (local.get $expr)))
        (local.set $name
          (call $str_concat (i32.const 1616)               ;; "record_"
                            (call $int_to_str (local.get $handle))))
        (call $emit_local_decl_str (local.get $name))
        (call $emit_alloc_handle_locals
          (call $lexpr_lmakerecord_fields (local.get $expr)))
        (return)))
    ;; LMakeTuple (317) — emit `(local $tuple_<H> i32)` + recurse.
    (if (i32.eq (local.get $tag) (i32.const 317))
      (then
        (local.set $handle (call $lexpr_handle (local.get $expr)))
        (local.set $name
          (call $str_concat (i32.const 1632)               ;; "tuple_"
                            (call $int_to_str (local.get $handle))))
        (call $emit_local_decl_str (local.get $name))
        (call $emit_alloc_handle_locals
          (call $lexpr_lmaketuple_elems (local.get $expr)))
        (return)))
    ;; Container recursion — same structural shape as $emit_let_locals.
    (if (i32.eq (local.get $tag) (i32.const 304))         ;; LLet
      (then
        (call $emit_alloc_handle_locals_walk
          (call $lexpr_llet_value (local.get $expr)))
        (return)))
    (if (i32.eq (local.get $tag) (i32.const 315))         ;; LBlock
      (then
        (call $emit_alloc_handle_locals
          (call $lexpr_lblock_stmts (local.get $expr)))
        (return)))
    (if (i32.eq (local.get $tag) (i32.const 314))         ;; LIf
      (then
        (call $emit_alloc_handle_locals
          (call $lexpr_lif_then (local.get $expr)))
        (call $emit_alloc_handle_locals
          (call $lexpr_lif_else (local.get $expr)))
        (return)))
    (if (i32.eq (local.get $tag) (i32.const 321))         ;; LMatch
      (then
        (call $emit_alloc_handle_locals_walk
          (call $lexpr_lmatch_scrut (local.get $expr)))
        (call $emit_alloc_handle_locals_match_arms
          (call $lexpr_lmatch_arms (local.get $expr)))
        (return)))
    (if (i32.eq (local.get $tag) (i32.const 308))         ;; LCall
      (then
        (call $emit_alloc_handle_locals_walk
          (call $lexpr_lcall_fn (local.get $expr)))
        (call $emit_alloc_handle_locals
          (call $lexpr_lcall_args (local.get $expr)))
        (return)))
    (if (i32.eq (local.get $tag) (i32.const 309))         ;; LTailCall
      (then
        (call $emit_alloc_handle_locals_walk
          (call $lexpr_ltailcall_fn (local.get $expr)))
        (call $emit_alloc_handle_locals
          (call $lexpr_ltailcall_args (local.get $expr)))
        (return)))
    (if (i32.eq (local.get $tag) (i32.const 306))         ;; LBinOp
      (then
        (call $emit_alloc_handle_locals_walk
          (call $lexpr_lbinop_l (local.get $expr)))
        (call $emit_alloc_handle_locals_walk
          (call $lexpr_lbinop_r (local.get $expr)))
        (return)))
    (if (i32.eq (local.get $tag) (i32.const 307))         ;; LUnaryOp
      (then
        (call $emit_alloc_handle_locals_walk
          (call $lexpr_lunaryop_x (local.get $expr)))
        (return)))
    (if (i32.eq (local.get $tag) (i32.const 303))         ;; LStore
      (then
        (call $emit_alloc_handle_locals_walk
          (call $lexpr_lstore_value (local.get $expr)))
        (return)))
    (if (i32.eq (local.get $tag) (i32.const 310))         ;; LReturn
      (then
        (call $emit_alloc_handle_locals_walk
          (call $lexpr_lreturn_x (local.get $expr)))
        (return)))
    (if (i32.eq (local.get $tag) (i32.const 320))         ;; LIndex
      (then
        (call $emit_alloc_handle_locals_walk
          (call $lexpr_lindex_base (local.get $expr)))
        (call $emit_alloc_handle_locals_walk
          (call $lexpr_lindex_idx (local.get $expr)))
        (return)))
    (if (i32.eq (local.get $tag) (i32.const 331))         ;; LPerform
      (then
        (call $emit_alloc_handle_locals
          (call $lexpr_lperform_args (local.get $expr)))
        (return)))
    (if (i32.eq (local.get $tag) (i32.const 316))         ;; LMakeList
      (then
        (call $emit_alloc_handle_locals
          (call $lexpr_lmakelist_elems (local.get $expr)))
        (return)))
    ;; LMakeClosure (311) / LMakeContinuation (312) — caps + evs are
    ;; OUTER-fn expressions captured into the closure; descend. Inner
    ;; fn (lexpr_lmakeclosure_fn) is a boundary; do NOT descend.
    (if (i32.eq (local.get $tag) (i32.const 311))
      (then
        (call $emit_alloc_handle_locals
          (call $lexpr_lmakeclosure_caps (local.get $expr)))
        (call $emit_alloc_handle_locals
          (call $lexpr_lmakeclosure_evs (local.get $expr)))
        (return)))
    (if (i32.eq (local.get $tag) (i32.const 312))
      (then
        (call $emit_alloc_handle_locals
          (call $lexpr_lmakecontinuation_caps (local.get $expr)))
        (call $emit_alloc_handle_locals
          (call $lexpr_lmakecontinuation_evs (local.get $expr)))
        (return)))
    (if (i32.eq (local.get $tag) (i32.const 325))         ;; LSuspend
      (then
        (call $emit_alloc_handle_locals
          (call $lexpr_lsuspend_args (local.get $expr)))
        (call $emit_alloc_handle_locals
          (call $lexpr_lsuspend_evs (local.get $expr)))
        (return)))
    (if (i32.eq (local.get $tag) (i32.const 327))         ;; LStateSet
      (then
        (call $emit_alloc_handle_locals_walk
          (call $lexpr_lstateset_value (local.get $expr)))
        (return)))
    (if (i32.eq (local.get $tag) (i32.const 328))         ;; LRegion
      (then
        (call $emit_alloc_handle_locals_walk
          (call $lexpr_lregion_body (local.get $expr)))
        (return)))
    (if (i32.eq (local.get $tag) (i32.const 329))         ;; LHandleWith
      (then
        (call $emit_alloc_handle_locals_walk
          (call $lexpr_lhandlewith_body (local.get $expr)))
        (call $emit_alloc_handle_locals_walk
          (call $lexpr_lhandlewith_handler (local.get $expr)))
        (return)))
    (if (i32.eq (local.get $tag) (i32.const 330))         ;; LFeedback
      (then
        ;; Emit per-handle feedback temps. Per emit_handler.wat:240,256,
        ;; 270 — LFeedback emits (local.set $__fb_prev_<h>) + (local.tee
        ;; $__fb_<h>). Both need preamble declarations in the containing
        ;; fn. Per protocol_canonical_projection_pattern.md: same shape
        ;; as $tuple_<H> / $variant_<H> / $record_<H>; same projection.
        (local.set $handle (call $lexpr_handle (local.get $expr)))
        (local.set $name
          (call $str_concat (i32.const 1648)               ;; "__fb_"
                            (call $int_to_str (local.get $handle))))
        (call $emit_local_decl_str (local.get $name))
        (local.set $name
          (call $str_concat (i32.const 1664)               ;; "__fb_prev_"
                            (call $int_to_str (local.get $handle))))
        (call $emit_local_decl_str (local.get $name))
        (call $emit_alloc_handle_locals_walk
          (call $lexpr_lfeedback_body (local.get $expr)))
        (call $emit_alloc_handle_locals_walk
          (call $lexpr_lfeedback_spec (local.get $expr)))
        (return)))
    (if (i32.eq (local.get $tag) (i32.const 332))         ;; LHandle
      (then
        (call $emit_alloc_handle_locals_walk
          (call $lexpr_lhandle_body (local.get $expr)))
        (call $emit_alloc_handle_locals_match_arms
          (call $lexpr_lhandle_arms (local.get $expr)))
        (return)))
    (if (i32.eq (local.get $tag) (i32.const 333))         ;; LEvPerform
      (then
        (call $emit_alloc_handle_locals
          (call $lexpr_levperform_args (local.get $expr)))
        (return)))
    (if (i32.eq (local.get $tag) (i32.const 334))         ;; LFieldLoad
      (then
        (call $emit_alloc_handle_locals_walk
          (call $lexpr_lfieldload_record (local.get $expr)))
        (return)))
    (return))

  ;; Match-arm walker — iterate arms, recurse into each arm body.
  (func $emit_alloc_handle_locals_match_arms (param $arms i32)
    (local $i i32) (local $n i32) (local $arm i32)
    (local.set $n (call $len (local.get $arms)))
    (local.set $i (i32.const 0))
    (block $done
      (loop $iter
        (br_if $done (i32.ge_u (local.get $i) (local.get $n)))
        (local.set $arm (call $list_index (local.get $arms) (local.get $i)))
        (call $emit_alloc_handle_locals_walk
          (call $lowpat_lparm_body (local.get $arm)))
        (local.set $i (i32.add (local.get $i) (i32.const 1)))
        (br $iter))))

  ;; ─── $emit_match_arm_locals — iterate match arms; emit pat + body ──
  ;; locals per arm. Per Hβ.first-light.match-arm-pat-binding-local-decl
  ;; Lock #2: arm's pat walked via $emit_pat_locals; arm's body recursed
  ;; via $emit_let_locals_walk.
  ;;
  ;; Lock #3: NO de-duplication across arms — WAT uniqueness obligation
  ;; enforced at lower-time (substrate gap if collisions surface).
  (func $emit_match_arm_locals (param $arms i32)
    (local $i i32) (local $n i32) (local $arm i32)
    (local.set $n (call $len (local.get $arms)))
    (local.set $i (i32.const 0))
    (block $done
      (loop $iter
        (br_if $done (i32.ge_u (local.get $i) (local.get $n)))
        (local.set $arm (call $list_index (local.get $arms) (local.get $i)))
        (call $emit_pat_locals (call $lowpat_lparm_pat (local.get $arm)))
        (call $emit_let_locals_walk (call $lowpat_lparm_body (local.get $arm)))
        (local.set $i (i32.add (local.get $i) (i32.const 1)))
        (br $iter))))

  ;; ─── $emit_pat_locals — walk LowPat tree, emit (local $<name> i32) ──
  ;; for every LPVar binding (direct LPVar OR sub-pattern of LPCon /
  ;; LPTuple / LPRecord / LPList / LPAs). Per Hβ.first-light.match-arm-
  ;; pat-binding-local-decl Lock #2: bindings come from LPVar at any
  ;; pattern depth; the local-decl ledger derives from LowPat structure,
  ;; not from a parallel name-list (Drift 7 refusal).
  ;;
  ;; Eight interrogations:
  ;;  1. Graph?      LPVar's name field at record offset 1; tag dispatch
  ;;                 via $tag_of; sub-pattern lists via accessors.
  ;;  2. Handler?    Direct emit; @resume=OneShot.
  ;;  3. Verb?       N/A — structural walk.
  ;;  4. Row?        EmitMemory effect (writes to $out_base via $emit_str).
  ;;  5. Ownership?  Pat record `ref`-borrowed.
  ;;  6. Refinement? LPVar.name non-zero string-ptr per arity-2 contract.
  ;;  7. Gradient?   Local-decl synthesis derived from LowPat substrate.
  ;;  8. Reason?     LPVar handle preserves chain; this walk does not write.
  ;;
  ;; Drift modes refused:
  ;;  - Drift 1 (vtable): direct tag-int dispatch; no $pat_locals_table.
  ;;  - Drift 6 (special): every binding-introducing LowPat goes through
  ;;                       same recurse; LPCon, LPTuple, LPRecord, LPList,
  ;;                       LPAs treated uniformly.
  ;;  - Drift 7 (parallel arrays): no body_local_names accumulator.
  ;;  - Drift 8 (string-keyed): tag-int comparisons.
  ;;  - Drift 9 (deferred): all binding-introducing LowPat variants walked.
  (func $emit_pat_locals (param $pat i32)
    (local $tag i32) (local $sub_pats i32) (local $i i32) (local $n i32)
    (local $rest i32) (local $fields i32) (local $field i32)
    (if (i32.lt_u (local.get $pat) (global.get $heap_base))
      (then (return)))
    (local.set $tag (call $tag_of (local.get $pat)))
    ;; LPVar (360) — emit (local $<name> i32) IFF not already declared
    ;; for current fn (Hβ.first-light.match-arm-binding-name-uniqueness
    ;; Lock #1). Source-name fidelity preserved (Lock #5).
    (if (i32.eq (local.get $tag) (i32.const 360))
      (then
        (if (call $emit_fn_local_check (call $lowpat_lpvar_name (local.get $pat)))
          (then
            (call $emit_cstr (i32.const 4146) (i32.const 9)) ;; " (local $"
            (call $emit_str (call $lowpat_lpvar_name (local.get $pat)))
            (call $emit_cstr (i32.const 4155) (i32.const 5)))) ;; " i32)"
        (return)))
    ;; LPCon (363) — recurse into sub-pats list.
    (if (i32.eq (local.get $tag) (i32.const 363))
      (then
        (local.set $sub_pats (call $lowpat_lpcon_args (local.get $pat)))
        (local.set $n (call $len (local.get $sub_pats)))
        (local.set $i (i32.const 0))
        (block $done_con
          (loop $iter_con
            (br_if $done_con (i32.ge_u (local.get $i) (local.get $n)))
            (call $emit_pat_locals
              (call $list_index (local.get $sub_pats) (local.get $i)))
            (local.set $i (i32.add (local.get $i) (i32.const 1)))
            (br $iter_con)))
        (return)))
    ;; LPTuple (364) — recurse into elems.
    (if (i32.eq (local.get $tag) (i32.const 364))
      (then
        (local.set $sub_pats (call $lowpat_lptuple_elems (local.get $pat)))
        (local.set $n (call $len (local.get $sub_pats)))
        (local.set $i (i32.const 0))
        (block $done_tup
          (loop $iter_tup
            (br_if $done_tup (i32.ge_u (local.get $i) (local.get $n)))
            (call $emit_pat_locals
              (call $list_index (local.get $sub_pats) (local.get $i)))
            (local.set $i (i32.add (local.get $i) (i32.const 1)))
            (br $iter_tup)))
        (return)))
    ;; LPRecord (366) — fields is list of (name, pat) records.
    (if (i32.eq (local.get $tag) (i32.const 366))
      (then
        (local.set $fields (call $lowpat_lprecord_fields (local.get $pat)))
        (local.set $n (call $len (local.get $fields)))
        (local.set $i (i32.const 0))
        (block $done_rec
          (loop $iter_rec
            (br_if $done_rec (i32.ge_u (local.get $i) (local.get $n)))
            (local.set $field
              (call $list_index (local.get $fields) (local.get $i)))
            (call $emit_pat_locals
              (call $record_get (local.get $field) (i32.const 1)))
            (local.set $i (i32.add (local.get $i) (i32.const 1)))
            (br $iter_rec)))
        (local.set $rest (call $lowpat_lprecord_rest (local.get $pat)))
        (if (i32.ne (local.get $rest) (i32.const 0))
          (then
            (if (call $emit_fn_local_check (local.get $rest))
              (then
                (call $emit_cstr (i32.const 4146) (i32.const 9))
                (call $emit_str (local.get $rest))
                (call $emit_cstr (i32.const 4155) (i32.const 5))))))
        (return)))
    ;; LPList (365) — recurse into elems; rest_var is bound-name string.
    (if (i32.eq (local.get $tag) (i32.const 365))
      (then
        (local.set $sub_pats (call $lowpat_lplist_elems (local.get $pat)))
        (local.set $n (call $len (local.get $sub_pats)))
        (local.set $i (i32.const 0))
        (block $done_lst
          (loop $iter_lst
            (br_if $done_lst (i32.ge_u (local.get $i) (local.get $n)))
            (call $emit_pat_locals
              (call $list_index (local.get $sub_pats) (local.get $i)))
            (local.set $i (i32.add (local.get $i) (i32.const 1)))
            (br $iter_lst)))
        (local.set $rest (call $lowpat_lplist_rest (local.get $pat)))
        (if (i32.ne (local.get $rest) (i32.const 0))
          (then
            (if (call $emit_fn_local_check (local.get $rest))
              (then
                (call $emit_cstr (i32.const 4146) (i32.const 9))
                (call $emit_str (local.get $rest))
                (call $emit_cstr (i32.const 4155) (i32.const 5))))))
        (return)))
    ;; LPAs (368) — emit (local $<name> i32) IFF not already declared,
    ;; THEN recurse inner pat (which re-checks its own bindings via
    ;; $emit_fn_local_check on each LPVar/LPCon/etc. it encounters).
    (if (i32.eq (local.get $tag) (i32.const 368))
      (then
        (if (call $emit_fn_local_check (call $lowpat_lpas_name (local.get $pat)))
          (then
            (call $emit_cstr (i32.const 4146) (i32.const 9))
            (call $emit_str (call $lowpat_lpas_name (local.get $pat)))
            (call $emit_cstr (i32.const 4155) (i32.const 5))))
        (call $emit_pat_locals (call $lowpat_lpas_pat (local.get $pat)))
        (return)))
    ;; LPWild (361) / LPLit (362) / LPAlt (367) — bind nothing.
    (return))

  ;; $emit_functions — walk LowExpr list, emit (func ...) for each
  ;; LMakeClosure, including NESTED ones inside fn bodies (lambdas).
  ;; Per Hβ.first-light.lambda-body-fn-emit (2026-05-02): when a lambda
  ;; appears inside a fn body (e.g., `fn main() = (x) => x`), the
  ;; LMakeClosure is buried inside the outer fn's body LowExpr tree,
  ;; not at the top level. The emitter must recurse to find it.
  ;;
  ;; Eight interrogations per recursion site:
  ;;  1. Graph?      LMakeClosure carries LowFn (lowfn record); fn body
  ;;                 IS a LowExpr list whose nodes are graph projections.
  ;;  2. Handler?    Direct emit; @resume=OneShot.
  ;;  3. Verb?       N/A — structural recursion.
  ;;  4. Row?        EmitMemory effect in emit; pure structural walk
  ;;                 over ADT in this helper.
  ;;  5. Ownership?  Borrowed throughout.
  ;;  6. Refinement? LowExpr tag must be in [300, 334].
  ;;  7. Gradient?   Each fn emitted is one more candidate in the
  ;;                 funcref table; closure records reference them.
  ;;  8. Reason?     Each LMakeClosure carries its source handle.
  ;;
  ;; Drift modes refused:
  ;;  - Drift 1 (vtable): fn_index is a FIELD read at call_indirect; no
  ;;                       table-of-functions dispatch logic here.
  ;;  - Drift 6 (special): nullary AND N-ary lambdas use the same
  ;;                       emit_fn_body path; no Bool-special-case.
  ;;  - Drift 9 (deferred): all common LowExpr containers walked
  ;;                       (LLet/LBlock/LIf/LMatch/LCall/LTailCall/
  ;;                       LSuspend/LBinOp/LMakeList/LMakeTuple/
  ;;                       LMakeRecord/LMakeVariant). Less-common
  ;;                       containers fall through (no recursion);
  ;;                       drift-9-safe because uninitialized-
  ;;                       containers never produce LMakeClosure
  ;;                       children today (substrate bounded by
  ;;                       lower's actual output).

  (func $emit_functions (param $lowexprs i32)
    (local $i i32) (local $n i32) (local $expr i32) (local $tag i32)
    ;; Productive-under-error guard: the recursive walk descends into
    ;; LowExpr accessor results (lexpr_lcall_args, lexpr_lblock_stmts,
    ;; etc.). When upstream lower's productive-under-error path emits
    ;; a sentinel where a List was expected — typically when infer
    ;; left an LError-shaped LowExpr in a containment field — those
    ;; accessors return a non-list pointer. $list_index would trap on
    ;; unknown tag. Skip the walk on malformed input; the diagnostic
    ;; chain already surfaced the upstream cause as
    ;; E_UnresolvedType / E_TypeMismatch. Named peer:
    ;; `Hβ.first-light.emit-functions-malformed-list-source` —
    ;; identifies which accessor / lower path produces the non-list.
    (if (i32.lt_u (local.get $lowexprs) (global.get $heap_base))
      (then (return)))
    (local.set $tag (call $list_tag (local.get $lowexprs)))
    (if (i32.and
          (i32.ne (local.get $tag) (i32.const 0))
          (i32.and
            (i32.ne (local.get $tag) (i32.const 1))
            (i32.and
              (i32.ne (local.get $tag) (i32.const 3))
              (i32.ne (local.get $tag) (i32.const 4)))))
      (then (return)))
    (local.set $n (call $len (local.get $lowexprs)))
    (local.set $i (i32.const 0))
    (block $done
      (loop $iter
        (br_if $done (i32.ge_u (local.get $i) (local.get $n)))
        (local.set $expr (call $list_index (local.get $lowexprs) (local.get $i)))
        (call $emit_functions_walk (local.get $expr))
        (local.set $i (i32.add (local.get $i) (i32.const 1)))
        (br $iter))))

  ;; Recursive walker: for each LowExpr, emit any LMakeClosure
  ;; encountered (and recurse into its body) AND descend into common
  ;; sub-expression containers.
  (func $emit_functions_walk (param $expr i32)
    (local $tag i32) (local $inner i32) (local $fn_r i32) (local $body i32)
    (if (i32.lt_u (local.get $expr) (global.get $heap_base))
      (then (return)))
    (local.set $tag (call $tag_of (local.get $expr)))
    ;; LMakeClosure (311) — emit fn body + recurse into its body
    (if (i32.eq (local.get $tag) (i32.const 311))
      (then
        (local.set $fn_r (call $lexpr_lmakeclosure_fn (local.get $expr)))
        (call $emit_fn_body (local.get $fn_r))
        (local.set $body (call $lowfn_body (local.get $fn_r)))
        (call $emit_functions (local.get $body))
        (return)))
    ;; LMakeContinuation (312) — same shape
    (if (i32.eq (local.get $tag) (i32.const 312))
      (then
        (local.set $fn_r (call $lexpr_lmakecontinuation_fn (local.get $expr)))
        (call $emit_fn_body (local.get $fn_r))
        (local.set $body (call $lowfn_body (local.get $fn_r)))
        (call $emit_functions (local.get $body))
        (return)))
    ;; LDeclareFn (313) — handler-arm fn becomes a module-level (func).
    ;; Per Lock #1 + H1.4 single-handler-per-op naming: the LowFn's name
    ;; is "op_<op_name>" (set at walk_handle.wat:283). $emit_fn_body
    ;; emits `(func $op_<op_name> ...)`; recursive descent into body
    ;; finds nested closures (lambda-inside-arm).
    (if (i32.eq (local.get $tag) (i32.const 313))
      (then
        (local.set $fn_r (call $lexpr_ldeclarefn_fn (local.get $expr)))
        (call $emit_fn_body (local.get $fn_r))
        (local.set $body (call $lowfn_body (local.get $fn_r)))
        (call $emit_functions (local.get $body))
        (return)))
    ;; LLet (304) — recurse into value
    (if (i32.eq (local.get $tag) (i32.const 304))
      (then
        (call $emit_functions_walk (call $lexpr_llet_value (local.get $expr)))
        (return)))
    ;; LBlock (315) — recurse into stmts list
    (if (i32.eq (local.get $tag) (i32.const 315))
      (then
        (call $emit_functions (call $lexpr_lblock_stmts (local.get $expr)))
        (return)))
    ;; LIf (314) — recurse into cond/then/else
    (if (i32.eq (local.get $tag) (i32.const 314))
      (then
        (call $emit_functions_walk (call $lexpr_lif_cond (local.get $expr)))
        (call $emit_functions (call $lexpr_lif_then (local.get $expr)))
        (call $emit_functions (call $lexpr_lif_else (local.get $expr)))
        (return)))
    ;; LCall (308) — recurse into fn + args
    (if (i32.eq (local.get $tag) (i32.const 308))
      (then
        (call $emit_functions_walk (call $lexpr_lcall_fn (local.get $expr)))
        (call $emit_functions (call $lexpr_lcall_args (local.get $expr)))
        (return)))
    ;; LTailCall (309) — same shape as LCall
    (if (i32.eq (local.get $tag) (i32.const 309))
      (then
        (call $emit_functions_walk (call $lexpr_ltailcall_fn (local.get $expr)))
        (call $emit_functions (call $lexpr_ltailcall_args (local.get $expr)))
        (return)))
    ;; LBinOp (306) — recurse into lhs/rhs
    (if (i32.eq (local.get $tag) (i32.const 306))
      (then
        (call $emit_functions_walk (call $lexpr_lbinop_l (local.get $expr)))
        (call $emit_functions_walk (call $lexpr_lbinop_r (local.get $expr)))
        (return)))
    ;; LMakeVariant (319) — recurse into args
    (if (i32.eq (local.get $tag) (i32.const 319))
      (then
        (call $emit_functions (call $lexpr_lmakevariant_args (local.get $expr)))
        (return)))
    ;; LMakeList (316) — recurse into elems
    (if (i32.eq (local.get $tag) (i32.const 316))
      (then
        (call $emit_functions (call $lexpr_lmakelist_elems (local.get $expr)))
        (return)))
    ;; LMakeTuple (317) — recurse into elems
    (if (i32.eq (local.get $tag) (i32.const 317))
      (then
        (call $emit_functions (call $lexpr_lmaketuple_elems (local.get $expr)))
        (return)))
    ;; LReturn (310) — recurse into value
    (if (i32.eq (local.get $tag) (i32.const 310))
      (then
        (call $emit_functions_walk (call $lexpr_lreturn_x (local.get $expr)))
        (return)))
    ;; LHandle (332) — recurse into body to discover nested fns.
    (if (i32.eq (local.get $tag) (i32.const 332))
      (then
        (call $emit_functions_walk (call $lexpr_lhandle_body (local.get $expr)))
        (return)))
    ;; LHandleWith (329) — recurse into body + handler.
    (if (i32.eq (local.get $tag) (i32.const 329))
      (then
        (call $emit_functions_walk (call $lexpr_lhandlewith_body (local.get $expr)))
        (call $emit_functions_walk (call $lexpr_lhandlewith_handler (local.get $expr)))
        (return)))
    ;; LMatch (321) — match-arm bodies routinely contain LMakeClosure
    ;; (e.g., `match x { _ => () => y }`). Walk scrut + each arm body.
    (if (i32.eq (local.get $tag) (i32.const 321))
      (then
        (call $emit_functions_walk (call $lexpr_lmatch_scrut (local.get $expr)))
        (call $emit_functions_match_arms (call $lexpr_lmatch_arms (local.get $expr)))
        (return)))
    ;; LMakeRecord (318) — recurse into fields.
    (if (i32.eq (local.get $tag) (i32.const 318))
      (then
        (call $emit_functions (call $lexpr_lmakerecord_fields (local.get $expr)))
        (return)))
    ;; LSuspend (325) — fn IS a closure; recurse to find its inner LFn.
    (if (i32.eq (local.get $tag) (i32.const 325))
      (then
        (call $emit_functions_walk (call $lexpr_lsuspend_fn (local.get $expr)))
        (call $emit_functions (call $lexpr_lsuspend_args (local.get $expr)))
        (return)))
    ;; LFeedback (330) — body + spec; spec may embed an LFn.
    (if (i32.eq (local.get $tag) (i32.const 330))
      (then
        (call $emit_functions_walk (call $lexpr_lfeedback_body (local.get $expr)))
        (call $emit_functions_walk (call $lexpr_lfeedback_spec (local.get $expr)))
        (return)))
    ;; LRegion (328) — recurse into body.
    (if (i32.eq (local.get $tag) (i32.const 328))
      (then
        (call $emit_functions_walk (call $lexpr_lregion_body (local.get $expr)))
        (return)))
    ;; LIndex (320) — recurse into base + idx.
    (if (i32.eq (local.get $tag) (i32.const 320))
      (then
        (call $emit_functions_walk (call $lexpr_lindex_base (local.get $expr)))
        (call $emit_functions_walk (call $lexpr_lindex_idx (local.get $expr)))
        (return)))
    ;; LStore (303) / LStateSet (327) — recurse into value.
    (if (i32.eq (local.get $tag) (i32.const 303))
      (then
        (call $emit_functions_walk (call $lexpr_lstore_value (local.get $expr)))
        (return)))
    (if (i32.eq (local.get $tag) (i32.const 327))
      (then
        (call $emit_functions_walk (call $lexpr_lstateset_value (local.get $expr)))
        (return)))
    ;; LUnaryOp (307) — recurse into x.
    (if (i32.eq (local.get $tag) (i32.const 307))
      (then
        (call $emit_functions_walk (call $lexpr_lunaryop_x (local.get $expr)))
        (return)))
    ;; LPerform (331) / LEvPerform (333) — recurse into args.
    (if (i32.eq (local.get $tag) (i32.const 331))
      (then
        (call $emit_functions (call $lexpr_lperform_args (local.get $expr)))
        (return)))
    (if (i32.eq (local.get $tag) (i32.const 333))
      (then
        (call $emit_functions (call $lexpr_levperform_args (local.get $expr)))
        (return)))
    ;; LFieldLoad (334) — recurse into record sub-expr.
    (if (i32.eq (local.get $tag) (i32.const 334))
      (then
        (call $emit_functions_walk (call $lexpr_lfieldload_record (local.get $expr)))
        (return)))
    ;; All other tags: leaves with no LowExpr children to walk.
    (return))

  ;; Match-arm walker for $emit_functions — same shape as
  ;; $emit_alloc_handle_locals_match_arms but with the fn-emit leaf.
  (func $emit_functions_match_arms (param $arms i32)
    (local $i i32) (local $n i32) (local $arm i32)
    (local.set $n (call $len (local.get $arms)))
    (local.set $i (i32.const 0))
    (block $done
      (loop $iter
        (br_if $done (i32.ge_u (local.get $i) (local.get $n)))
        (local.set $arm (call $list_index (local.get $arms) (local.get $i)))
        (call $emit_functions_walk (call $lowpat_lparm_body (local.get $arm)))
        (local.set $i (i32.add (local.get $i) (i32.const 1)))
        (br $iter))))

  ;; ─── $mentl_emit — the pipeline-stage entry ───────────────────────────
  ;;
  ;; Per Hβ-emit-substrate.md §10.3 + Hβ-bootstrap §1.15 entry-handler
  ;; convention. Symmetric to $mentl_infer (infer/main.wat) + $mentl_lower
  ;; (lower/main.wat). Lock #2: pipeline-stage boundary distinct from
  ;; $emit_lowir_program algorithmic core. Lock #3: no result —
  ;; emission is side-effect on $out_base/$out_pos; the WAT byte buffer
  ;; IS the artifact pipeline-wire's `$proc_exit` flushes via
  ;; $emit_flush.
  ;;
  ;; Phase H: now emits function definitions per wasm.mn:165-185.
  ;; Order: header → imports → memory → globals → table → fn_idx_globals
  ;;        → functions → top-level body in _start → string data → close.

  (func $mentl_emit (export "mentl_emit")
        (param $lowexprs i32)
    (call $emit_cstr (i32.const 831) (i32.const 7))  ;; "(module"
    (call $emit_nl)
    (call $indent_inc)

    ;; ── Function types for call_indirect ──
    (call $emit_type_section (local.get $lowexprs))

    ;; ── WASI imports (cursor-projected from used-(effect, op) set) ──
    (call $emit_wasi_imports_inka (local.get $lowexprs))

    ;; ── Memory & Globals ──
    (call $emit_indent)
    (call $emit_cstr (i32.const 838) (i32.const 8))  ;; "(memory "
    (call $emit_cstr (i32.const 846) (i32.const 8))  ;; "(export "
    (call $emit_byte (i32.const 34))
    (call $emit_cstr (i32.const 1096) (i32.const 6)) ;; memory
    (call $emit_byte (i32.const 34))
    (call $emit_close)
    (call $emit_space)
    (call $emit_int (i32.const 512))
    (call $emit_close)
    (call $emit_nl)

    (call $emit_indent)
    (call $emit_cstr (i32.const 862) (i32.const 8))  ;; "(global "
    (call $emit_byte (i32.const 36))
    (call $emit_cstr (i32.const 1102) (i32.const 8)) ;; heap_ptr
    (call $emit_cstr (i32.const 1110) (i32.const 11)) ;; " (mut i32) "
    (call $emit_i32_const (i32.const 1048576))
    (call $emit_close)
    (call $emit_nl)

    ;; ── Function definitions FIRST: populates funcref via emit_fn_body ──
    (call $emit_functions (local.get $lowexprs))

    ;; ── Funcref table + index globals (reads funcref ledger) ──
    (call $emit_fn_table_and_globals)

    ;; ── Static closure records (iterates funcref ledger directly) ──
    (call $emit_static_top_closures)

    ;; ── String data segments ──
    (call $emit_string_section)

    ;; ── _start ──
    (call $emit_start_section_static (local.get $lowexprs))

    (call $indent_dec)
    (call $emit_close)
    (call $emit_nl))

  ;; $emit_start_section_with_body — emit _start that runs top-level stmts.
  ;; Unlike the old $emit_start_section (empty _start), this one emits the
  ;; lowered program body inside _start, then calls proc_exit.
  (func $emit_start_section_with_body (param $lowexprs i32)
    (call $emit_indent)
    (call $emit_cstr (i32.const 924) (i32.const 5)) ;; "(func"
    (call $emit_space)
    (call $emit_byte (i32.const 36))                ;; '$'
    (call $emit_cstr (i32.const 1591) (i32.const 6)) ;; "_start"
    ;; (export "_start")
    (call $emit_space)
    (call $emit_cstr (i32.const 846) (i32.const 8)) ;; "(export "
    (call $emit_byte (i32.const 34))
    (call $emit_cstr (i32.const 1591) (i32.const 6)) ;; "_start"
    (call $emit_byte (i32.const 34))
    (call $emit_close)
    ;; Standard locals for top-level code
    (call $emit_cstr (i32.const 4146) (i32.const 9)) ;; " (local $"
    (call $emit_str (i32.const 2244)) ;; "state_tmp" (length-prefixed)
    (call $emit_cstr (i32.const 4155) (i32.const 5)) ;; " i32)"
    ;; Pre-declare LLet locals
    (call $emit_let_locals (local.get $lowexprs))
    (call $emit_nl)
    (call $indent_inc)
    ;; Emit top-level body
    (call $emit_lowir_program (local.get $lowexprs))
    ;; (call $wasi_proc_exit (i32.const 0))
    (call $emit_indent)
    (call $emit_cstr (i32.const 572) (i32.const 6)) ;; "(call "
    (call $emit_byte (i32.const 36))
    (call $emit_cstr (i32.const 1230) (i32.const 14)) ;; "wasi_proc_exit"
    (call $emit_space)
    (call $emit_i32_const (i32.const 0))
    (call $emit_close)
    (call $emit_nl)
    (call $indent_dec)
    (call $emit_indent)
    (call $emit_close)
    (call $emit_nl))

  ;; $emit_start_section_static — executable entry projection.
  ;; Top-level closures live in static records. Zero-arg main is invoked
  ;; through the same closure-record call_indirect path as every other
  ;; function. Parameterized main and library modules clean-exit.
  (func $emit_start_section_static (param $lowexprs i32)
    (local $main_arity i32)
    (local.set $main_arity (call $find_top_fn_arity (local.get $lowexprs) (i32.const 4268) (i32.const 4)))
    (call $emit_indent)
    (call $emit_cstr (i32.const 924) (i32.const 5)) ;; "(func"
    (call $emit_space)
    (call $emit_byte (i32.const 36))                ;; '$'
    (call $emit_cstr (i32.const 1591) (i32.const 6)) ;; "_start"
    (call $emit_space)
    (call $emit_cstr (i32.const 846) (i32.const 8)) ;; "(export "
    (call $emit_byte (i32.const 34))
    (call $emit_cstr (i32.const 1591) (i32.const 6)) ;; "_start"
    (call $emit_byte (i32.const 34))
    (call $emit_close)
    (call $emit_nl)
    (call $indent_inc)
    (if (i32.eqz (local.get $main_arity))
      (then
        ;; Per Hβ.first-light.main-return-as-exit-code (2026-05-06):
        ;; thread main's i32 return into proc_exit so the medium's
        ;; output is visible end-to-end (`echo prog | mentl ... |
        ;; wat2wasm | wasmtime; echo $?`). Emit:
        ;;   (global.get $main)
        ;;   (global.get $main)(i32.load offset=0)
        ;;   (call_indirect (type $ft1))   ;; main's i32 on stack
        ;;   (call $wasi_proc_exit)        ;; consumes stack value
        ;; Lib-mode (no main) keeps `proc_exit (i32.const 0)` below.
        (call $emit_indent)
        (call $el_emit_global_get_dollar (call $str_from_mem (i32.const 4268) (i32.const 4)))
        (call $emit_nl)
        (call $emit_indent)
        (call $el_emit_global_get_dollar (call $str_from_mem (i32.const 4268) (i32.const 4)))
        (call $ec6_emit_i32_load_offset_0)
        (call $emit_nl)
        (call $emit_indent)
        (call $ec6_emit_call_indirect_ftN (i32.const 0))
        (call $emit_nl)
        ;; (call $wasi_proc_exit) — stack-consuming form
        (call $emit_indent)
        (call $emit_cstr (i32.const 572) (i32.const 6)) ;; "(call "
        (call $emit_byte (i32.const 36))
        (call $emit_cstr (i32.const 1230) (i32.const 14)) ;; "wasi_proc_exit"
        (call $emit_close)
        (call $emit_nl))
      (else
        ;; Library / parameterized main — clean-exit with 0.
        (call $emit_indent)
        (call $emit_cstr (i32.const 572) (i32.const 6)) ;; "(call "
        (call $emit_byte (i32.const 36))
        (call $emit_cstr (i32.const 1230) (i32.const 14)) ;; "wasi_proc_exit"
        (call $emit_space)
        (call $emit_i32_const (i32.const 0))
        (call $emit_close)
        (call $emit_nl)))
    (call $indent_dec)
    (call $emit_indent)
    (call $emit_close)
    (call $emit_nl))

  (func $find_top_fn_arity (param $lowexprs i32) (param $name_ptr i32) (param $name_len i32) (result i32)
    (local $i i32) (local $n i32) (local $expr i32) (local $inner i32)
    (local $candidate i32)
    (local.set $n (call $len (local.get $lowexprs)))
    (local.set $i (i32.const 0))
    (block $done
      (loop $iter
        (br_if $done (i32.ge_u (local.get $i) (local.get $n)))
        (local.set $expr (call $list_index (local.get $lowexprs) (local.get $i)))
        (if (i32.eq (call $tag_of (local.get $expr)) (i32.const 304))
          (then
            (local.set $candidate (call $lexpr_llet_name (local.get $expr)))
            (if (call $str_eq
                  (local.get $candidate)
                  (call $str_from_mem (local.get $name_ptr) (local.get $name_len)))
              (then
                (local.set $inner (call $lexpr_llet_value (local.get $expr)))
                (if (i32.eq (call $tag_of (local.get $inner)) (i32.const 311))
                  (then
                    (return
                      (call $lowfn_arity
                        (call $lexpr_lmakeclosure_fn (local.get $inner))))))
                (if (i32.eq (call $tag_of (local.get $inner)) (i32.const 312))
                  (then
                    (return
                      (call $lowfn_arity
                        (call $lexpr_lmakecontinuation_fn (local.get $inner))))))))))
        (local.set $i (i32.add (local.get $i) (i32.const 1)))
        (br $iter)))
    (i32.const -1))
