  ;; ═══ walk_expr.wat — expression inference walk (Tier 7) ═════════════
  ;; Implements: Hβ-infer-substrate.md §3 + §4.1 + §4.3 + §5 + §6.3 +
  ;;             §7.2 + §8.1 walk_expr.wat row + §8.4 ~900-line estimate +
  ;;             §9 worked example + §11 acceptance + §13.3 dep order #8 +
  ;;             docs/specs/04-inference.md §What the walk produces +
  ;;             docs/specs/03-typed-ast.md (canonical AST shape) +
  ;;             canonical wheel src/infer.mn:490-765 (infer_expr arms) +
  ;;             :782-810 (infer_var_ref / check_consume_at_use) +
  ;;             :820-846 (infer_call + row chase) +
  ;;             :898-974 (infer_pipe / per-PipeKind arms) +
  ;;             :985-1030 (infer_compose / infer_diverge) +
  ;;             :1543-1583 (infer_binop / infer_unaryop) +
  ;;             :1701-1733 (infer_match_arms + iter) +
  ;;             :1795-1805 (infer_handler_arms).
  ;;
  ;; Realizes the walk projection of primitive #8 (HM inference live +
  ;; productive-under-error + with Reasons — DESIGN.md §0.5) at the seed
  ;; substrate. Every Expr variant tagged 80-101 by the parser
  ;; (parser_infra.wat:14-19) gets one arm; each arm ends with exactly
  ;; ONE $graph_bind on the AST handle (modulo branch arms that bind
  ;; sub-handles too; the per-handle invariant is "one bind per AST
  ;; handle" per src/infer.mn:493-498 line shape). Per Hazel productive-
  ;; under-error: env_lookup miss, handler-uninstallable, pattern-
  ;; inexhaustive, feedback-no-context all emit-and-bind-NErrorHole-and-
  ;; continue rather than aborting. The chunk drives one walk; it never
  ;; checks vs. infers (no bidirectional split per §7.2 foreign-fluency).
  ;;
  ;; Exports:    $infer_walk_expr,
  ;;             $infer_walk_expr_lit_int, $infer_walk_expr_lit_float,
  ;;             $infer_walk_expr_lit_string, $infer_walk_expr_lit_bool,
  ;;             $infer_walk_expr_lit_unit,
  ;;             $infer_walk_expr_var_ref,
  ;;             $infer_walk_expr_binop, $infer_walk_expr_unaryop,
  ;;             $infer_walk_expr_call,
  ;;             $infer_walk_expr_lambda,
  ;;             $infer_walk_expr_if,
  ;;             $infer_walk_expr_block,
  ;;             $infer_walk_expr_match, $infer_walk_expr_match_arms,
  ;;             $infer_walk_expr_make_list, $infer_walk_expr_make_tuple,
  ;;             $infer_walk_expr_make_record, $infer_walk_expr_named_record,
  ;;             $infer_walk_expr_field,
  ;;             $infer_walk_expr_perform,
  ;;             $infer_walk_expr_handle, $infer_walk_expr_resume,
  ;;             $infer_walk_expr_pipe,
  ;;             $infer_walk_expr_pipe_forward,
  ;;             $infer_walk_expr_pipe_compose,
  ;;             $infer_walk_expr_pipe_diverge,
  ;;             $infer_walk_expr_pipe_tee,
  ;;             $infer_walk_expr_pipe_feedback
  ;; Uses:       $alloc (alloc.wat),
  ;;             $str_eq / $str_concat / $str_alloc (str.wat),
  ;;             $int_to_str (int.wat),
  ;;             $make_list / $list_index / $list_set / $list_extend_to /
  ;;               $len / $slice (list.wat),
  ;;             $make_record / $record_get / $record_set / $tag_of (record.wat),
  ;;             $eprint_string (wasi.wat),
  ;;             $graph_init / $graph_fresh_ty / $graph_fresh_row /
  ;;               $graph_chase / $graph_node_at / $graph_bind /
  ;;               $graph_bind_kind / $gnode_kind / $node_kind_tag /
  ;;               $node_kind_payload / $node_kind_make_nerrorhole (graph.wat),
  ;;             $env_init / $env_lookup / $env_extend /
  ;;               $env_scope_enter / $env_scope_exit /
  ;;               $env_binding_scheme / $env_binding_reason /
  ;;               $env_binding_kind (env.wat),
  ;;             $infer_init / $infer_span_index_append (state.wat),
  ;;             $reason_make_located / $reason_make_inferred /
  ;;               $reason_make_opconstraint / $reason_make_varlookup /
  ;;               $reason_make_inferredcallreturn /
  ;;               $reason_make_inferredpiperesult /
  ;;               $reason_make_ifbranch / $reason_make_matchbranch /
  ;;               $reason_make_listelement (reason.wat),
  ;;             $ty_make_tint / $ty_make_tfloat / $ty_make_tstring /
  ;;               $ty_make_tunit / $ty_make_tvar / $ty_make_tlist /
  ;;               $ty_make_ttuple / $ty_make_tfun / $ty_make_tname /
  ;;               $ty_make_trecord / $ty_make_trecordopen /
  ;;               $ty_tag / $ty_tvar_handle (ty.wat),
  ;;             $tparam_make / $ownership_make_inferred /
  ;;               $field_pair_make (tparam.wat),
  ;;             $instantiate / $scheme_make_forall (scheme.wat),
  ;;             $infer_emit_missing_var /
  ;;               $infer_emit_feedback_no_context /
  ;;               $infer_emit_pattern_inexhaustive /
  ;;               $infer_emit_not_a_record_type (emit_diag.wat),
  ;;             $unify (unify.wat),
  ;;             $infer_consume_use / $infer_branch_enter /
  ;;               $infer_branch_divider / $infer_branch_exit (own.wat),
  ;;             $infer_stmt_list (walk_stmt.wat — peer Tier 7).
  ;; Test:       bootstrap/test/infer/walk_expr_lit_int.wat,
  ;;             bootstrap/test/infer/walk_expr_var_ref_miss.wat,
  ;;             bootstrap/test/infer/walk_expr_binop_arith.wat,
  ;;             bootstrap/test/infer/walk_expr_call_through_unify.wat
  ;;
  ;; ═══ EIGHT INTERROGATIONS (per Hβ-infer-substrate.md §6.3 applied to
  ;;                            walk_expr.wat per-arm walk) ═══════════════
  ;;
  ;; 1. Graph?      Every arm ends in exactly ONE $graph_bind on the AST
  ;;                handle (one bind per AST handle, per src/infer.mn
  ;;                invariant). Branch arms (BinOp BKBool, IfExpr) ALSO
  ;;                bind sub-handles for taught-typing — but each handle
  ;;                gets bound at most once per the per-handle invariant.
  ;; 2. Handler?    Direct seed call. Wheel's $inf_enter_fn / $inf_exit_fn /
  ;;                $inf_add_row / $inf_push_handler / $inf_pop_handler
  ;;                (src/infer.mn:36-153) are seed-stubbed as no-ops with
  ;;                named peer follow-up Hβ.infer.row-normalize +
  ;;                Hβ.infer.handler-stack. The walk arms are SHAPED so the
  ;;                wheel's @resume=OneShot resume-discipline maps 1-1 onto
  ;;                the seed's direct return.
  ;; 3. Verb?       PipeExpr arm dispatches on PipeKind tag (160-164 per
  ;;                parser_infra.wat:27): PForward / PDiverge / PCompose /
  ;;                PTee / PFeedback. Each verb arm's
  ;;                topology builds the typed AST per src/infer.mn
  ;;                infer_pipe / infer_compose / infer_diverge.
  ;; 4. Row?        TFun construction at CallExpr / LambdaExpr uses
  ;;                $ty_make_tfun(params, return_ty, row_h) where row_h
  ;;                comes from $graph_fresh_row. Arms that "add to the
  ;;                current accumulating row" call seed-stub
  ;;                $walk_expr_inf_add_row (no-op pass-through; row.wat
  ;;                sibling lands the composition per Hβ.infer.row-normalize).
  ;; 5. Ownership?  Every VarRef arm calls $infer_consume_use(handle, name,
  ;;                span, located_reason) (own.wat). The affine ledger
  ;;                decides whether to fire the diagnostic; the walk does
  ;;                not gate. Branch verbs (PCompose, PDiverge with
  ;;                MakeTupleExpr right) wrap their sub-walks in
  ;;                $infer_branch_enter / $infer_branch_divider /
  ;;                $infer_branch_exit so parallel consumes collide.
  ;; 6. Refinement? TRefined predicates arrive via parser AST type-
  ;;                annotations and pass through unify; predicates compose
  ;;                via verify.wat's ledger when the handle's chained
  ;;                Reason carries a refinement. NO walk arm constructs
  ;;                TRefined directly (parser's job).
  ;; 7. Gradient?   Each $graph_bind is one gradient step (NFree → NBound).
  ;;                Productive-under-error arms (env_lookup miss; handler-
  ;;                uninstallable; pattern-inexhaustive; feedback-no-
  ;;                context) emit-then-bind-NErrorHole-then-return — never
  ;;                abort. emit_diag.wat helpers do the bind via
  ;;                $graph_bind_kind + $node_kind_make_nerrorhole.
  ;; 8. Reason?     Every $graph_bind wraps its Reason via
  ;;                $reason_make_located(span, inner). Arm-specific inner
  ;;                Reasons via $reason_make_inferred (literal arms),
  ;;                $reason_make_opconstraint (BinOp / UnaryOp),
  ;;                $reason_make_varlookup (VarRef),
  ;;                $reason_make_inferredcallreturn (CallExpr),
  ;;                $reason_make_inferredpiperesult (PipeExpr),
  ;;                $reason_make_ifbranch (IfExpr),
  ;;                $reason_make_matchbranch (MatchExpr arms).
  ;;
  ;; ═══ FORBIDDEN PATTERNS AUDIT (per Hβ-infer-substrate.md §7.2 +
  ;;                                applied to walk_expr.wat) ═══════════
  ;;
  ;; - Drift 1 (Rust vtable):           NO closure-array indexed by tag.
  ;;                                    Arms dispatch via direct
  ;;                                    (if (i32.eq tag …)) chain in
  ;;                                    $infer_walk_expr. The chain IS the
  ;;                                    substrate's variant enumeration,
  ;;                                    NOT a table.
  ;; - Drift 2 (Scheme env frame):      env.wat owns all scope state; this
  ;;                                    chunk threads NO sidecar context.
  ;; - Drift 3 (Python dict):           Reason-ctx strings live in
  ;;                                    data-segment offsets passed as
  ;;                                    string ptrs to $reason_make_inferred;
  ;;                                    NOT $str_eq enum dispatch.
  ;; - Drift 4 (Haskell monad transformer): NO $walk_expr_M_bind /
  ;;                                    $walk_expr_M_return. Arms call
  ;;                                    $infer_walk_expr recursively on
  ;;                                    subnodes; return i32 (the bound
  ;;                                    handle for caller convenience).
  ;; - Drift 5 (C calling convention):  Signature is (param $node i32)
  ;;                                    (result i32) — single i32 in (the
  ;;                                    wrapped N record), single i32 out
  ;;                                    (the AST handle the caller already
  ;;                                    knows but returning IT mirrors
  ;;                                    src/infer.mn's `let N(_, _, h) =
  ;;                                    node` pattern). NO bundled context-
  ;;                                    struct + state ptr.
  ;; - Drift 6 (primitive special-case): TInt / TFloat / TString / TUnit
  ;;                                    flow through the SAME $graph_bind +
  ;;                                    $reason_make_located + $reason_make_
  ;;                                    inferred shape; no fast-path.
  ;; - Drift 7 (parallel-arrays):       Arg-handle collection uses the
  ;;                                    buffer-counter substrate (one flat
  ;;                                    list of handles); NEVER parallel
  ;;                                    (ty_ptrs[], reason_ptrs[]) arrays.
  ;; - Drift 8 (mode flag / string-keyed): BinOp arm dispatches on BinOp
  ;;                                    tag (140-153 per parser_infra.wat:
  ;;                                    26+329-343); NEVER on string.
  ;;                                    PipeKind dispatches on tag (160-164);
  ;;                                    NEVER on `kind == "|>"`.
  ;; - Drift 9 (deferred-by-omission):  Every Expr tag (80-101) gets an
  ;;                                    arm. BlockExpr forward-declares
  ;;                                    $infer_stmt_list (walk_stmt.wat —
  ;;                                    peer Tier 7 chunk per §13.3 #9, NOT
  ;;                                    silent deferral). LambdaExpr,
  ;;                                    HandleExpr's row + handler-stack
  ;;                                    ops compose on inert seed-stubs
  ;;                                    named at chunk-end as Hβ.infer.row-
  ;;                                    normalize / .handler-stack. Inert
  ;;                                    stubs are NOT TODOs; they are
  ;;                                    explicit named-no-ops with peer
  ;;                                    follow-up handles.
  ;;
  ;; - Foreign fluency — type-check vs. infer split: NO $check_expr peer;
  ;;                                    ONE $infer_walk_expr. NO bidirectional
  ;;                                    dispatch. Per §7.2 + spec 04 §Three
  ;;                                    operations.
  ;; - Foreign fluency — Algorithm W return tuple: arms return i32 (the
  ;;                                    AST handle); they do NOT return
  ;;                                    (subst, type) pairs. Subst IS the
  ;;                                    graph; the handle's NBound payload
  ;;                                    is the type. Per §7.1.
  ;; - Foreign fluency — exception machinery: NO "throw" / "panic" /
  ;;                                    "raise" / "exception" / "catch"
  ;;                                    vocabulary. NErrorHole IS the
  ;;                                    productive-under-error substrate.
  ;;
  ;; ═══ TAG REGION ═══════════════════════════════════════════════════
  ;;
  ;; This chunk introduces NO new tags. It dispatches on:
  ;;   parser_infra.wat:14-19  Expr variants  80-101 (LitInt..PipeExpr)
  ;;   parser_infra.wat:20     NodeBody       110 (NExpr)
  ;;   parser_infra.wat:26     BinOp          140-153 (BAdd..BConcat)
  ;;   parser_infra.wat:27     PipeKind       160-164 (PForward..PFeedback)
  ;;   ty.wat:248              Ty             100-113 (TInt..TAlias)
  ;;   reason.wat              Reason         220-242
  ;;   own.wat                 USED_SITE_ENTRY 213, BRANCH_FRAME 214
  ;;
  ;; ═══ NAMED FOLLOW-UPS (per Drift 9 + Hβ-infer §12) ═══════════════════
  ;;
  ;; - Hβ.infer.row-normalize: $walk_expr_inf_add_row /
  ;;   $walk_expr_inf_enter_fn / $walk_expr_inf_exit_fn are inert seed-
  ;;   stubs. Wheel's inf_* arms (src/infer.mn:36-153) compose row
  ;;   composition on row.wat substrate that lands in the row.wat sibling
  ;;   chunk. Until then PForward / CallExpr / PerformExpr's "row flows
  ;;   into caller" line in src/infer.mn:843+869+919 is a no-op at the
  ;;   seed.
  ;; - Hβ.infer.handler-stack: $walk_expr_inf_push_handler /
  ;;   $walk_expr_inf_pop_handler (src/infer.mn:127-138) similarly inert.
  ;;   HandleExpr / PTee arms still bind correctly (the
  ;;   body's type IS the result type) without handler-stack tracking; W4
  ;;   monomorphic-dispatch read happens later.
  ;; - Hβ.infer.region-tracker: H4 tag_alloc_join calls
  ;;   (src/infer.mn:524-587) inert. Region tracking lands when Hβ.lower's
  ;;   Alloc surface matures.
  ;; - Hβ.infer.docstring-reason: Documented Stmt arm omitted (parser
  ;;   doesn't emit Documented today; landing pre-DS.3).
  ;; - Hβ.infer.walk_pat: LANDED (Phase B.5 commit). $infer_walk_pat
  ;;   dispatches PVar/PWild/PLit/PCon/PTuple/PList per spec 03;
  ;;   called from MatchExpr arm + LetStmt arm. PCon threads
  ;;   constructor field types to sub-patterns via TFun param extraction.
  ;; - Hβ.infer.match-exhaustive: exhaustiveness check
  ;;   (src/infer.mn:1709-1718) omitted at the seed; MatchExpr arm
  ;;   delegates to $infer_emit_pattern_inexhaustive on demand only.
  ;; - Hβ.infer.named-record-validate: check_nominal_record_fields
  ;;   (src/infer.mn:1397-1450) omitted; uses already-landed
  ;;   $infer_emit_record_field_extra / _missing helpers.
  ;; - Hβ.infer.iterative-context: <~ arm pessimistically emits
  ;;   feedback-no-context always; lands when Clock/Tick/Sample handler-
  ;;   stack-walk substrate matures.
  ;; - Hβ.infer.qualified-name: FieldExpr's dotted-name fallback
  ;;   (src/infer.mn:710-722) deferred; seed treats every FieldExpr as
  ;;   record field access.
  ;; - walk_stmt.wat (peer Tier 7 chunk per §13.3 #9): LANDED. Provides
  ;;   $infer_stmt_list; BlockExpr arm now calls it directly (Hβ.infer
  ;;   §13.3 #9 closure complete).

  ;; ─── Data segment — Reason-inner string fragments ────────────────────
  ;;
  ;; Offsets ≥ 3392 to sit above own.wat's last segment (3352 + 26 = 3378
  ;; high-water; 14-byte safety gap). Below HEAP_BASE = 4096 per
  ;; CLAUDE.md memory model. Length-prefix uses the actual byte count of
  ;; the payload per §11.5 emit_diag.wat lessons.

  (data (i32.const 3392) "\0b\00\00\00int literal")          ;; 11 bytes
  (data (i32.const 3416) "\0d\00\00\00float literal")        ;; 13 bytes
  (data (i32.const 3440) "\0e\00\00\00string literal")       ;; 14 bytes
  (data (i32.const 3464) "\0c\00\00\00bool literal")         ;; 12 bytes
  (data (i32.const 3480) "\04\00\00\00unit")                 ;;  4 bytes
  (data (i32.const 3504) "\04\00\00\00Bool")                 ;;  4 bytes
  (data (i32.const 3520) "\07\00\00\00var ref")              ;;  7 bytes
  (data (i32.const 3552) "\04\00\00\00left")                 ;;  4 bytes
  (data (i32.const 3568) "\05\00\00\00right")                ;;  5 bytes
  (data (i32.const 3584) "\06\00\00\00result")               ;;  6 bytes
  (data (i32.const 3600) "\07\00\00\00operand")              ;;  7 bytes
  (data (i32.const 3616) "\0a\00\00\00comparison")           ;; 10 bytes
  (data (i32.const 3632) "\06\00\00\00concat")               ;;  6 bytes
  (data (i32.const 3648) "\06\00\00\00<call>")               ;;  6 bytes
  (data (i32.const 3672) "\06\00\00\00return")               ;;  6 bytes
  (data (i32.const 3696) "\07\00\00\00effects")              ;;  7 bytes
  (data (i32.const 3720) "\08\00\00\00expected")             ;;  8 bytes
  (data (i32.const 3744) "\0b\00\00\00unification")          ;; 11 bytes
  (data (i32.const 6640) "\03\00\00\00len")                  ;;  3 bytes — sequence-projection cname compares
  (data (i32.const 6648) "\09\00\00\00list_head")            ;;  9 bytes
  (data (i32.const 6664) "\09\00\00\00list_tail")            ;;  9 bytes
  (data (i32.const 6680) "\08\00\00\00list_set")             ;;  8 bytes
  (data (i32.const 6696) "\0b\00\00\00list_concat")          ;; 11 bytes
  (data (i32.const 6712) "\09\00\00\00make_list")            ;;  9 bytes
  (data (i32.const 6728) "\05\00\00\00slice")                ;;  5 bytes
  (data (i32.const 6740) "\04\00\00\00push")                 ;;  4 bytes
  (data (i32.const 6752) "\03\00\00\00map")                  ;;  3 bytes — functor projections
  (data (i32.const 6768) "\06\00\00\00filter")               ;;  6 bytes
  (data (i32.const 6784) "\07\00\00\00flatten")              ;;  7 bytes
  (data (i32.const 6800) "\04\00\00\00fold")                 ;;  4 bytes
  (data (i32.const 6816) "\08\00\00\00for_each")             ;;  8 bytes
  (data (i32.const 6832) "\04\00\00\00take")                 ;;  4 bytes
  (data (i32.const 6848) "\04\00\00\00drop")                 ;;  4 bytes
  (data (i32.const 6864) "\03\00\00\00any")                  ;;  3 bytes
  (data (i32.const 6880) "\03\00\00\00all")                  ;;  3 bytes
  (data (i32.const 6896) "\04\00\00\00find")                 ;;  4 bytes
  (data (i32.const 6912) "\05\00\00\00count")                ;;  5 bytes
  (data (i32.const 6928) "\06\00\00\00Option")               ;;  6 bytes
  ;; "list_index" reuses the parser desugar target at 4288.
  (data (i32.const 3768) "\0c\00\00\00if condition")         ;; 12 bytes
  (data (i32.const 3792) "\0b\00\00\00if branches")          ;; 11 bytes
  (data (i32.const 3816) "\09\00\00\00if result")            ;;  9 bytes
  (data (i32.const 3840) "\0c\00\00\00block result")         ;; 12 bytes
  (data (i32.const 3864) "\08\00\00\00arm body")             ;;  8 bytes
  (data (i32.const 3888) "\0d\00\00\00record result")        ;; 13 bytes
  (data (i32.const 3912) "\0c\00\00\00tuple result")         ;; 12 bytes
  (data (i32.const 3936) "\0b\00\00\00list result")          ;; 11 bytes
  (data (i32.const 3960) "\0a\00\00\00empty list")           ;; 10 bytes
  (data (i32.const 3984) "\06\00\00\00lambda")               ;;  6 bytes
  (data (i32.const 4008) "\06\00\00\00<expr>")               ;;  6 bytes
  (data (i32.const 6400) "\1d\00\00\00parser missing ident at <tok>")  ;; 28 bytes

  ;; ─── Private helpers ─────────────────────────────────────────────────

  ;; $walk_expr_node_handle(N) — extract handle (offset 12) from the N
  ;; record (parser_infra.wat:32-39 layout: [tag=0][body][span][handle]).
  (func $walk_expr_node_handle (param $n i32) (result i32)
    (i32.load offset=12 (local.get $n)))

  ;; $walk_expr_node_span(N) — extract span (offset 8) from the N record.
  (func $walk_expr_node_span (param $n i32) (result i32)
    (i32.load offset=8 (local.get $n)))

  ;; $walk_expr_node_body(N) — extract body (offset 4) from the N record.
  (func $walk_expr_node_body (param $n i32) (result i32)
    (i32.load offset=4 (local.get $n)))

  ;; $walk_expr_expr_tag(expr) — get the Expr variant tag (80-101). Uses
  ;; $tag_of so LitUnit (sentinel 84 < HEAP_BASE) routes correctly per
  ;; record.wat:49 precedent. Heap-tag Expr variants load tag at offset 0
  ;; via the same $tag_of dispatch.
  (func $walk_expr_expr_tag (param $expr i32) (result i32)
    (call $tag_of (local.get $expr)))

  ;; $walk_expr_make_inferred_located(span, ctx) — wraps
  ;; Located(span, Inferred(ctx)). Common pattern across literal arms.
  (func $walk_expr_make_inferred_located (param $span i32) (param $ctx i32)
                                          (result i32)
    (call $reason_make_located
      (local.get $span)
      (call $reason_make_inferred (local.get $ctx))))

  ;; $walk_expr_unify_handles(h_a, h_b, span, reason) — thin readability
  ;; wrapper over $unify. Some arms call this; some call $unify directly.
  (func $walk_expr_unify_handles (param $h_a i32) (param $h_b i32)
                                  (param $span i32) (param $reason i32)
    (call $unify (local.get $h_a) (local.get $h_b)
                  (local.get $span) (local.get $reason)))

  ;; $walk_expr_collect_arg_handles(args) — buffer-counter substrate per
  ;; CLAUDE.md bug class. Walks each arg N node via $infer_walk_expr (which
  ;; mutates the graph) and collects each child's handle into a fresh flat
  ;; list. Returns the list (callers index it for $tparam_make + $unify).
  (func $walk_expr_collect_arg_handles (param $args i32) (result i32)
    (local $n i32) (local $i i32) (local $buf i32)
    (local $arg_node i32) (local $arg_h i32)
    (local.set $n (call $len (local.get $args)))
    (local.set $buf (call $make_list (i32.const 0)))
    (local.set $buf (call $list_extend_to (local.get $buf) (local.get $n)))
    (local.set $i (i32.const 0))
    (block $done
      (loop $each
        (br_if $done (i32.ge_u (local.get $i) (local.get $n)))
        (local.set $arg_node (call $list_index (local.get $args) (local.get $i)))
        (local.set $arg_h (call $infer_walk_expr (local.get $arg_node)))
        (drop (call $list_set (local.get $buf) (local.get $i) (local.get $arg_h)))
        (local.set $i (i32.add (local.get $i) (i32.const 1)))
        (br $each)))
    (local.get $buf))

  ;; $walk_expr_build_inferred_params(arg_handles) — for each handle h,
  ;; build TParam(name=anon, ty=TVar(h), authored=Inferred,
  ;; resolved=Inferred). Mirrors src/infer.mn:828 build_inferred_params.
  ;; The anon name is the empty string; renders correctly through
  ;; emit_diag.wat's $render_ty walker (which already handles empty
  ;; TParam names).
  (func $walk_expr_build_inferred_params (param $arg_handles i32) (result i32)
    (local $n i32) (local $i i32) (local $buf i32)
    (local $h i32) (local $tparam i32) (local $anon i32)
    (local.set $anon (call $str_alloc (i32.const 0)))   ;; empty string
    (local.set $n (call $len (local.get $arg_handles)))
    (local.set $buf (call $make_list (i32.const 0)))
    (local.set $buf (call $list_extend_to (local.get $buf) (local.get $n)))
    (local.set $i (i32.const 0))
    (block $done
      (loop $each
        (br_if $done (i32.ge_u (local.get $i) (local.get $n)))
        (local.set $h (call $list_index (local.get $arg_handles) (local.get $i)))
        (local.set $tparam (call $tparam_make
          (local.get $anon)
          (call $ty_make_tvar (local.get $h))
          (call $ownership_make_inferred)
          (call $ownership_make_inferred)))
        (drop (call $list_set (local.get $buf) (local.get $i) (local.get $tparam)))
        (local.set $i (i32.add (local.get $i) (i32.const 1)))
        (br $each)))
    (local.get $buf))

  ;; ─── Hβ.infer.perform-effect-row-propagation (row-normalize landed) ──
  ;; The wheel's InferCtx (src/infer.mn:36-50, :62-118): each FnStmt/Lambda
  ;; pushes a frame {accumulated_row, fn_span, row_handle}; every perform/call
  ;; adds its effect row to the frame's accumulation; on exit the accumulation
  ;; binds to the row handle (NRowFree → NRowBound[union]). The seed realizes
  ;; this on the dormant $infer_fn_stack (state.wat) — the slot the system
  ;; reserved (audit-dormant-first) — storing frame records rather than bare
  ;; handles. Frame record tag 213: [0]=accumulated_row [1]=fn_span [2]=row_handle.
  ;; THIS is the activation input for perform-evidence-dispatch: once a fn that
  ;; performs E carries row {E}, $lookup_row_for resolves it and derive_ev_slots
  ;; threads the handler record (Hβ-perform-evidence-dispatch.md §4.9).

  ;; $walk_expr_inf_add_row — union the performed-op / called-callee row into
  ;; the current frame. `row` is an EffRow VALUE (wheel inf_add_row(EffRow)
  ;; signature parity — callers chase handles to bound rows before calling);
  ;; $lookup_row_for resolves EfOpen wrappers through the graph. No active
  ;; frame (module top-level) → no-op (wheel stack.len==0 arm).
  (func $walk_expr_inf_add_row (param $row i32)
    (local $frame i32) (local $resolved i32)
    (if (i32.eqz (call $infer_fn_stack_len)) (then (return)))
    (local.set $resolved (call $lookup_row_for (local.get $row)))
    ;; Only Pure/Closed/Open rows are nameable by the seed's row algebra;
    ;; row_union → row_names traps on Neg/Sub/Inter (effect masking/sub/inter,
    ;; the named peer Hβ.infer.row-normalize-full). Skip those — they carry no
    ;; handler-dispatched effect for evidence threading; the union stays sound.
    (if (i32.eqz (i32.or (call $row_is_pure   (local.get $resolved))
                  (i32.or (call $row_is_closed (local.get $resolved))
                          (call $row_is_open   (local.get $resolved)))))
      (then (return)))
    (local.set $frame (call $infer_fn_stack_top))
    (call $record_set (local.get $frame) (i32.const 0)
      (call $row_union
        (call $record_get (local.get $frame) (i32.const 0))
        (local.get $resolved))))

  ;; $walk_expr_inf_enter_fn — push a fresh {Pure, span, row_handle} frame.
  (func $walk_expr_inf_enter_fn (param $row_h i32) (param $span i32)
    (local $frame i32)
    (local.set $frame (call $make_record (i32.const 213) (i32.const 3)))
    (call $record_set (local.get $frame) (i32.const 0) (call $row_make_pure))
    (call $record_set (local.get $frame) (i32.const 1) (local.get $span))
    (call $record_set (local.get $frame) (i32.const 2) (local.get $row_h))
    (call $infer_fn_stack_push (local.get $frame)))

  ;; $walk_expr_inf_exit_fn — bind the fn's row handle to the accumulated row
  ;; (NRowFree → NRowBound[union]) so downstream $lookup_row_for resolves it,
  ;; then pop. No active frame → no-op.
  (func $walk_expr_inf_exit_fn
    (local $frame i32)
    (if (i32.eqz (call $infer_fn_stack_len)) (then (return)))
    (local.set $frame (call $infer_fn_stack_top))
    (call $graph_bind_row
      (call $record_get (local.get $frame) (i32.const 2))
      (call $record_get (local.get $frame) (i32.const 0))
      (call $reason_make_located
        (call $record_get (local.get $frame) (i32.const 1))
        (call $reason_make_inferred (i32.const 3984))))   ;; fn effect row
    (call $infer_fn_stack_pop))

  ;; $walk_expr_inf_push_handler — Hβ.infer.handler-stack stub. Wheel's
  ;; inf_push_handler tags the handler-stack frame with handled-effect
  ;; identity (src/infer.mn:127-132); seed no-op.
  (func $walk_expr_inf_push_handler (param $tag i32)
    (drop (local.get $tag)))

  ;; $walk_expr_inf_pop_handler — Hβ.infer.handler-stack stub.
  (func $walk_expr_inf_pop_handler
    (nop))

  ;; $walk_expr_callee_name(func_node) — extracts callee name for Reason
  ;; chains: if func is VarRef, return its name string ptr; if FieldExpr,
  ;; return field name; else return data-segment "<expr>". Mirrors
  ;; src/infer.mn:812-818.
  (func $walk_expr_callee_name (param $func_node i32) (result i32)
    (local $body i32) (local $expr i32) (local $tag i32)
    (local.set $body (call $walk_expr_node_body (local.get $func_node)))
    ;; If body isn't NExpr (110), fall through to "<expr>".
    (if (i32.ne (i32.load (local.get $body)) (i32.const 110))
      (then (return (i32.const 4008))))
    (local.set $expr (i32.load offset=4 (local.get $body)))
    (local.set $tag (call $walk_expr_expr_tag (local.get $expr)))
    ;; VarRef (85): name at offset 4
    (if (i32.eq (local.get $tag) (i32.const 85))
      (then (return (i32.load offset=4 (local.get $expr)))))
    ;; FieldExpr (100): field at offset 8 ([tag=100][rec][field])
    (if (i32.eq (local.get $tag) (i32.const 100))
      (then (return (i32.load offset=8 (local.get $expr)))))
    ;; CallExpr (88): a config handler `~> h(args)` ([tag=88][callee][args]).
    ;; The handler's name IS the callee; recurse so HandlerKind resolves and
    ;; its residual row applies — without this, every config handler
    ;; (map_collector(f), fold_handler(f,init)) loses its arm effects.
    (if (i32.eq (local.get $tag) (i32.const 88))
      (then (return (call $walk_expr_callee_name (i32.load offset=4 (local.get $expr))))))
    (i32.const 4008))   ;; "<expr>"

  ;; $walk_expr_collect_handled_effects(arms) — placeholder per
  ;; Hβ.infer.handler-stack named follow-up. Returns empty list.
  (func $walk_expr_collect_handled_effects (param $arms i32) (result i32)
    (drop (local.get $arms))
    (call $make_list (i32.const 0)))

  ;; $walk_expr_handle_arm_iter(arms, body_h, span) — iterate handler
  ;; arms; for each: scope_enter, walk arm.body, unify arm_body_h ↔
  ;; body_h, scope_exit. Mirrors src/infer.mn:1795-1805. The seed treats
  ;; each arm as an opaque record whose .body field lives at offset 4
  ;; (parser-emitted shape; lands as a peer record in walk_stmt.wat with
  ;; HANDLER_ARM tag — for now opaque-deref by offset).
  ;; Inline-arm walk under the typed-resume law. Arm record per Lock #8
  ;; alphabetical is {args=0, body=1, op_name=2} (records are
  ;; [tag][arity][fields...] — field INDEX via record_get, never byte
  ;; offsets). S for inline `handle { body } with { arms }` IS the
  ;; handle-expr's body type: args bind to the op's declared params;
  ;; resume reads (R, S) from the arm context; the body's own value
  ;; unifies with S.
  (func $walk_expr_handle_arm_iter (param $arms i32) (param $body_h i32)
                                    (param $span i32)
    (local $n i32) (local $i i32)
    (local $arm i32) (local $arm_body i32) (local $abh i32)
    (local $op_name i32) (local $args i32) (local $binding i32)
    (local $op_ty i32) (local $ret_ty i32)
    (local $saved_ret i32) (local $saved_res i32)
    (local $declared_reason i32)
    (local.set $n (call $len (local.get $arms)))
    (local.set $i (i32.const 0))
    (block $done
      (loop $each
        (br_if $done (i32.ge_u (local.get $i) (local.get $n)))
        (local.set $arm (call $list_index (local.get $arms) (local.get $i)))
        (call $env_scope_enter)
        (local.set $args     (call $record_get (local.get $arm) (i32.const 0)))
        (local.set $arm_body (call $record_get (local.get $arm) (i32.const 1)))
        (local.set $op_name  (call $record_get (local.get $arm) (i32.const 2)))
        ;; Op lookup → R + arg binds against declared params. A missed
        ;; or shapeless op leaves R as a fresh var (productive-under-
        ;; error; the op's own diagnostic already fired at decl/use).
        (local.set $ret_ty (call $ty_make_tvar (call $graph_fresh_ty
          (call $reason_make_located (local.get $span)
            (call $reason_make_inferred (i32.const 3864))))))   ;; "arm body"
        (local.set $binding (call $env_lookup (local.get $op_name)))
        (if (i32.ne (local.get $binding) (i32.const 0))
          (then
            (local.set $op_ty (call $instantiate
              (call $env_binding_scheme (local.get $binding))))
            (if (i32.eq (call $ty_tag (local.get $op_ty)) (i32.const 107))
              (then
                (local.set $ret_ty (call $ty_tfun_return (local.get $op_ty)))
                (local.set $declared_reason (call $reason_make_located
                  (local.get $span)
                  (call $reason_make_declared (local.get $op_name))))
                (call $infer_handler_arm_bind_args
                  (local.get $args)
                  (call $ty_tfun_params (local.get $op_ty))
                  (local.get $declared_reason) (local.get $span)))
              (else
                (local.set $ret_ty (local.get $op_ty))))))
        ;; Walk body under the arm context (save/restore for nesting).
        (local.set $saved_ret (global.get $infer_arm_ret_ty_g))
        (local.set $saved_res (global.get $infer_arm_result_h_g))
        (global.set $infer_arm_ret_ty_g   (local.get $ret_ty))
        (global.set $infer_arm_result_h_g (local.get $body_h))
        (local.set $abh (call $infer_walk_expr (local.get $arm_body)))
        (global.set $infer_arm_ret_ty_g   (local.get $saved_ret))
        (global.set $infer_arm_result_h_g (local.get $saved_res))
        (call $unify (local.get $abh) (local.get $body_h)
                      (local.get $span)
                      (call $reason_make_inferred (i32.const 3864)))   ;; "arm body"
        (call $env_scope_exit)
        (local.set $i (i32.add (local.get $i) (i32.const 1)))
        (br $each))))

  ;; ─── Per-Expr-variant arms ───────────────────────────────────────────

  ;; LitInt arm — src/infer.mn:493
  (func $infer_walk_expr_lit_int
        (export "infer_walk_expr_lit_int")
        (param $expr i32) (param $handle i32) (param $span i32)
        (result i32)
    (drop (local.get $expr))
    (call $graph_bind
      (local.get $handle)
      (call $ty_make_tint)
      (call $reason_make_located (local.get $span)
        (call $reason_make_inferred (i32.const 3392))))   ;; "int literal"
    (local.get $handle))

  ;; LitFloat arm — src/infer.mn:494
  (func $infer_walk_expr_lit_float
        (export "infer_walk_expr_lit_float")
        (param $expr i32) (param $handle i32) (param $span i32)
        (result i32)
    (drop (local.get $expr))
    (call $graph_bind
      (local.get $handle)
      (call $ty_make_tfloat)
      (call $reason_make_located (local.get $span)
        (call $reason_make_inferred (i32.const 3416))))   ;; "float literal"
    (local.get $handle))

  ;; LitString arm — src/infer.mn:495
  (func $infer_walk_expr_lit_string
        (export "infer_walk_expr_lit_string")
        (param $expr i32) (param $handle i32) (param $span i32)
        (result i32)
    (drop (local.get $expr))
    (call $graph_bind
      (local.get $handle)
      (call $ty_make_tstring)
      (call $reason_make_located (local.get $span)
        (call $reason_make_inferred (i32.const 3440))))   ;; "string literal"
    (local.get $handle))

  ;; LitBool arm — src/infer.mn:496. Bool is TName("Bool", []).
  (func $infer_walk_expr_lit_bool
        (export "infer_walk_expr_lit_bool")
        (param $expr i32) (param $handle i32) (param $span i32)
        (result i32)
    (drop (local.get $expr))
    (call $graph_bind
      (local.get $handle)
      (call $ty_make_tname (i32.const 3504) (call $make_list (i32.const 0)))
      (call $reason_make_located (local.get $span)
        (call $reason_make_inferred (i32.const 3464))))   ;; "bool literal"
    (local.get $handle))

  ;; LitUnit arm — src/infer.mn:497. expr is the sentinel 84; do not deref.
  (func $infer_walk_expr_lit_unit
        (export "infer_walk_expr_lit_unit")
        (param $expr i32) (param $handle i32) (param $span i32)
        (result i32)
    (drop (local.get $expr))
    (call $graph_bind
      (local.get $handle)
      (call $ty_make_tunit)
      (call $reason_make_located (local.get $span)
        (call $reason_make_inferred (i32.const 3480))))   ;; "unit"
    (local.get $handle))

  ;; VarRef arm — src/infer.mn:499 + 787-810. Productive-under-error on
  ;; env miss: emit_missing_var binds NErrorHole + caller continues.
  (func $infer_walk_expr_var_ref
        (export "infer_walk_expr_var_ref")
        (param $expr i32) (param $handle i32) (param $span i32)
        (result i32)
    (local $name i32) (local $binding i32)
    (local $scheme i32) (local $reason i32) (local $ty i32)
    ;; VarRef layout: [tag=85][name_ptr] — name at offset 4
    (local.set $name (i32.load offset=4 (local.get $expr)))
    (local.set $binding (call $env_lookup_value (local.get $name)))
    (if (i32.eqz (local.get $binding))
      (then
        ;; Hazel productive-under-error: emit + bind NErrorHole + return.
        (call $infer_emit_missing_var
          (local.get $handle) (local.get $name)
          (call $reason_make_located (local.get $span)
            (call $reason_make_inferred (i32.const 3520))))   ;; "var ref"
        (return (local.get $handle))))
    ;; Hit: instantiate scheme + bind.
    (local.set $scheme (call $env_binding_scheme (local.get $binding)))
    (local.set $reason (call $env_binding_reason (local.get $binding)))
    (local.set $ty     (call $instantiate (local.get $scheme)))
    (call $graph_bind
      (local.get $handle)
      (local.get $ty)
      (call $reason_make_located (local.get $span)
        (call $reason_make_varlookup (local.get $name) (local.get $reason))))
    ;; Ownership is row-gated, not globally tracked. Consume fires ONLY
    ;; for params declared `own X`. Default = ref = !Consume. Wire-up
    ;; through env_binding ownership marker is the SchemeKind extension
    ;; (Hβ.infer.ownership-row-gate). Until then: no false positives.
    (local.get $handle))

  ;; BinOpExpr arm — src/infer.mn:501-507 + 1543-1572. Dispatches on
  ;; BinOp tag via numeric range (140-153 grouped into BKArith / BKCmp /
  ;; BKBool / BKConcat per src/types.mn binop_kind table).
  (func $infer_walk_expr_binop
        (export "infer_walk_expr_binop")
        (param $expr i32) (param $handle i32) (param $span i32)
        (result i32)
    (local $op i32) (local $left i32) (local $right i32)
    (local $lh i32) (local $rh i32) (local $op_str i32)
    ;; Layout: [tag=86][op][left][right]
    (local.set $op    (i32.load offset=4  (local.get $expr)))
    (local.set $left  (i32.load offset=8  (local.get $expr)))
    (local.set $right (i32.load offset=12 (local.get $expr)))
    ;; Walk children
    (local.set $lh (call $infer_walk_expr (local.get $left)))
    (local.set $rh (call $infer_walk_expr (local.get $right)))
    (local.set $op_str (call $int_to_str (local.get $op)))
    ;; BKArith: BAdd/BSub/BMul/BDiv/BMod (140-144)
    (if (i32.le_u (local.get $op) (i32.const 144))
      (then
        (call $unify (local.get $lh) (local.get $rh) (local.get $span)
          (call $reason_make_opconstraint
            (local.get $op_str)
            (call $reason_make_inferred (i32.const 3552))    ;; "left"
            (call $reason_make_inferred (i32.const 3568))))  ;; "right"
        (call $graph_bind (local.get $handle)
          (call $ty_make_tvar (local.get $lh))
          (call $reason_make_located (local.get $span)
            (call $reason_make_opconstraint
              (local.get $op_str)
              (call $reason_make_inferred (i32.const 3584))   ;; "result"
              (call $reason_make_inferred (i32.const 3600))))) ;; "operand"
        (return (local.get $handle))))
    ;; BKCmp: BEq/BNe/BLt/BGt/BLe/BGe (145-150)
    (if (i32.le_u (local.get $op) (i32.const 150))
      (then
        (call $unify (local.get $lh) (local.get $rh) (local.get $span)
          (call $reason_make_opconstraint
            (local.get $op_str)
            (call $reason_make_inferred (i32.const 3552))
            (call $reason_make_inferred (i32.const 3568))))
        (call $graph_bind (local.get $handle)
          (call $ty_make_tname (i32.const 3504) (call $make_list (i32.const 0)))
          (call $reason_make_located (local.get $span)
            (call $reason_make_opconstraint
              (local.get $op_str)
              (call $reason_make_inferred (i32.const 3616))   ;; "comparison"
              (call $reason_make_inferred (i32.const 3504))))) ;; "Bool"
        (return (local.get $handle))))
    ;; BKBool: BAnd/BOr (151-152) — bind both sides + result to Bool
    (if (i32.le_u (local.get $op) (i32.const 152))
      (then
        (call $graph_bind (local.get $lh)
          (call $ty_make_tname (i32.const 3504) (call $make_list (i32.const 0)))
          (call $reason_make_located (local.get $span)
            (call $reason_make_opconstraint
              (local.get $op_str)
              (call $reason_make_inferred (i32.const 3552))
              (call $reason_make_inferred (i32.const 3504)))))
        (call $graph_bind (local.get $rh)
          (call $ty_make_tname (i32.const 3504) (call $make_list (i32.const 0)))
          (call $reason_make_located (local.get $span)
            (call $reason_make_opconstraint
              (local.get $op_str)
              (call $reason_make_inferred (i32.const 3568))
              (call $reason_make_inferred (i32.const 3504)))))
        (call $graph_bind (local.get $handle)
          (call $ty_make_tname (i32.const 3504) (call $make_list (i32.const 0)))
          (call $reason_make_located (local.get $span)
            (call $reason_make_opconstraint
              (local.get $op_str)
              (call $reason_make_inferred (i32.const 3584))
              (call $reason_make_inferred (i32.const 3504)))))
        (return (local.get $handle))))
    ;; BKConcat: BConcat (153)
    (call $unify (local.get $lh) (local.get $rh) (local.get $span)
      (call $reason_make_opconstraint
        (local.get $op_str)
        (call $reason_make_inferred (i32.const 3552))
        (call $reason_make_inferred (i32.const 3568))))
    (call $graph_bind (local.get $handle)
      (call $ty_make_tvar (local.get $lh))
      (call $reason_make_located (local.get $span)
        (call $reason_make_opconstraint
          (local.get $op_str)
          (call $reason_make_inferred (i32.const 3632))    ;; "concat"
          (call $reason_make_inferred (i32.const 3600)))))  ;; "operand"
    (local.get $handle))

  ;; UnaryOpExpr arm — src/infer.mn:509-513 + 1574-1583. Op is stored as
  ;; an opaque ptr (string today; may move to ADT later — peer follow-up
  ;; if so). Default arm: bind handle ↔ TVar(inner_h). The wheel's "Neg"/
  ;; "Not" string comparisons require a $str_eq surface that the seed
  ;; can't yet drive on a literal "Neg"/"Not" string-pointer (no data-
  ;; segment for them); seed treats every UnaryOp as "default" (TVar
  ;; transparent). Per Hβ.infer.unaryop-class peer follow-up.
  (func $infer_walk_expr_unaryop
        (export "infer_walk_expr_unaryop")
        (param $expr i32) (param $handle i32) (param $span i32)
        (result i32)
    (local $op i32) (local $inner i32) (local $ih i32)
    ;; Layout: [tag=87][op][inner]
    (local.set $op    (i32.load offset=4 (local.get $expr)))
    (local.set $inner (i32.load offset=8 (local.get $expr)))
    (drop (local.get $op))
    (local.set $ih (call $infer_walk_expr (local.get $inner)))
    (call $graph_bind (local.get $handle)
      (call $ty_make_tvar (local.get $ih))
      (call $reason_make_located (local.get $span)
        (call $reason_make_inferred (i32.const 3600))))   ;; "operand"
    (local.get $handle))

  ;; CallExpr arm — src/infer.mn:515-527 + 820-846.
  (func $infer_walk_expr_call
        (export "infer_walk_expr_call")
        (param $expr i32) (param $handle i32) (param $span i32)
        (result i32)
    (local $func i32) (local $args i32) (local $fh i32)
    (local $arg_handles i32) (local $params i32)
    (local $ret_h i32) (local $row_h i32)
    (local $expected i32) (local $expected_h i32)
    (local $cname i32) (local $row_nk i32) (local $elem_h i32) (local $list_ty_h i32)
    ;; Layout: [tag=88][callee][args]
    (local.set $func (i32.load offset=4 (local.get $expr)))
    (local.set $args (i32.load offset=8 (local.get $expr)))
    ;; Walk callee + collect arg handles via recursion.
    (local.set $fh (call $infer_walk_expr (local.get $func)))
    (local.set $arg_handles (call $walk_expr_collect_arg_handles (local.get $args)))
    (local.set $cname (call $walk_expr_callee_name (local.get $func)))
    ;; The sequence node-kind's projections (len / list_index / list_head /
    ;; list_tail / list_set / list_concat / make_list / slice / push) — typed by
    ;; the ELEMENT, the cursor reading or building a sequence, NOT by their
    ;; load_i32/alloc substrate bodies (whose inferred type erases [a] to Int —
    ;; the §4① value-ontology poison that made the whole compiler's list
    ;; handling Int). Mirrors src/infer.mn infer_seq_op.
    (if (call $is_seq_op (local.get $cname))
      (then (return (call $infer_seq_op (local.get $cname)
        (local.get $arg_handles) (local.get $handle) (local.get $span)))))
    ;; Mint fresh return handle + row handle
    (local.set $ret_h (call $graph_fresh_ty
      (call $reason_make_inferredcallreturn (local.get $cname)
        (call $reason_make_inferred (i32.const 3672)))))   ;; "return"
    (local.set $row_h (call $graph_fresh_row
      (call $reason_make_inferredcallreturn (local.get $cname)
        (call $reason_make_inferred (i32.const 3696)))))   ;; "effects"
    ;; Build expected TFun
    (local.set $params (call $walk_expr_build_inferred_params (local.get $arg_handles)))
    (local.set $expected (call $ty_make_tfun
      (local.get $params)
      (call $ty_make_tvar (local.get $ret_h))
      (call $row_make_open (call $make_list (i32.const 0)) (local.get $row_h))))
    (local.set $expected_h (call $graph_fresh_ty
      (call $reason_make_inferredcallreturn (local.get $cname)
        (call $reason_make_inferred (i32.const 3720)))))   ;; "expected"
    (call $graph_bind
      (local.get $expected_h) (local.get $expected)
      (call $reason_make_located (local.get $span)
        (call $reason_make_inferredcallreturn (local.get $cname)
          (call $reason_make_inferred (i32.const 3720)))))
    ;; Unify the function-side handle with the expected TFun shape
    (call $unify (local.get $fh) (local.get $expected_h) (local.get $span)
      (call $reason_make_inferredcallreturn (local.get $cname)
        (call $reason_make_inferred (i32.const 3744))))    ;; "unification"
    ;; Bind result to TVar(ret_h)
    (call $graph_bind (local.get $handle)
      (call $ty_make_tvar (local.get $ret_h))
      (call $reason_make_located (local.get $span)
        (call $reason_make_inferredcallreturn (local.get $cname)
          (call $reason_make_inferred (i32.const 3584)))))  ;; "result"
    ;; Row composition: src/infer.mn:926-931 — chase row_h; NRowBound(row)
    ;; flows the callee's row into the caller's frame NOW; the edge feeds
    ;; $infer_row_fixpoint so late-bound callees (defined later /
    ;; mutually recursive) flow in post-walk.
    (call $infer_row_edge_append (local.get $row_h))
    (local.set $row_nk (call $gnode_kind (call $graph_chase (local.get $row_h))))
    (if (i32.eq (call $node_kind_tag (local.get $row_nk)) (i32.const 62))   ;; NRowBound
      (then (call $walk_expr_inf_add_row
        (call $node_kind_payload (local.get $row_nk)))))
    ;; NRowFree (63): the callee is effect-POLYMORPHIC — its row is still a
    ;; free var (a fn PARAM `f` whose effect isn't yet known: map(f,xs),
    ;; a handler arm calling its config `f`). Add the row VARIABLE so the
    ;; caller becomes polymorphic in it too; generalize quantifies it and
    ;; the call site instantiates it. Mirror of src/infer.mn:961 — without
    ;; this, every higher-order fn loses its argument's effects.
    (if (i32.eq (call $node_kind_tag (local.get $row_nk)) (i32.const 63))   ;; NRowFree
      (then (call $walk_expr_inf_add_row
        (call $row_make_open (call $make_list (i32.const 0)) (local.get $row_h)))))
    (local.get $handle))

  ;; ─── The sequence node-kind's projections (mirror src/infer.mn) ──────────
  ;; A sequence is ONE kernel node-kind (§4①); these type by the ELEMENT, the
  ;; cursor reading/building it, NOT by the load_i32/alloc substrate body whose
  ;; inferred type erases [a] to Int. lower still emits the lib calls; only the
  ;; TYPE moves here, to the node-kind that owns it.

  ;; seq_force — unify the i-th argument with `ty` (a no-op past the end). UNIFY
  ;; (not graph_bind) so a param VarRef receiver propagates.
  (func $seq_force (param $ah i32) (param $i i32) (param $ty i32) (param $span i32)
    (local $th i32)
    (if (i32.gt_u (call $len (local.get $ah)) (local.get $i))
      (then
        (local.set $th (call $graph_fresh_ty (call $reason_make_inferred (i32.const 3672))))
        (call $graph_bind (local.get $th) (local.get $ty)
          (call $reason_make_located (local.get $span)
            (call $reason_make_inferred (i32.const 3672))))
        (call $unify (call $list_index (local.get $ah) (local.get $i))
          (local.get $th) (local.get $span)
          (call $reason_make_inferred (i32.const 3672))))))

  ;; seq_force_fn — force the i-th arg to (param_tys) -> ret with an open effect
  ;; row (the transform's own effects flow separately). The functor projections
  ;; use it to relate f : a -> b so the result element IS the transform's range,
  ;; read live — never re-derived from map's buffer body.
  (func $seq_force_fn (param $ah i32) (param $i i32) (param $param_tys i32)
        (param $ret i32) (param $span i32)
    (local $n i32) (local $j i32) (local $params i32) (local $tf i32) (local $th i32)
    (if (i32.le_u (call $len (local.get $ah)) (local.get $i)) (then (return)))
    (local.set $n (call $len (local.get $param_tys)))
    (local.set $params (call $list_extend_to (call $make_list (local.get $n)) (local.get $n)))
    (local.set $j (i32.const 0))
    (block $d (loop $e
      (br_if $d (i32.ge_u (local.get $j) (local.get $n)))
      (drop (call $list_set (local.get $params) (local.get $j)
        (call $tparam_make (call $str_alloc (i32.const 0))
          (call $list_index (local.get $param_tys) (local.get $j))
          (call $ownership_make_inferred) (call $ownership_make_inferred))))
      (local.set $j (i32.add (local.get $j) (i32.const 1)))
      (br $e)))
    (local.set $tf (call $ty_make_tfun (local.get $params) (local.get $ret)
      (call $row_make_open (call $make_list (i32.const 0))
        (call $graph_fresh_row (call $reason_make_inferred (i32.const 3672))))))
    (local.set $th (call $graph_fresh_ty (call $reason_make_inferred (i32.const 3672))))
    (call $graph_bind (local.get $th) (local.get $tf)
      (call $reason_make_located (local.get $span) (call $reason_make_inferred (i32.const 3672))))
    (call $unify (call $list_index (local.get $ah) (local.get $i)) (local.get $th)
      (local.get $span) (call $reason_make_inferred (i32.const 3672))))

  ;; tylist1 / tylist2 — small Ty lists for seq_force_fn's param-type argument.
  (func $tylist1 (param $t i32) (result i32)
    (local $l i32)
    (local.set $l (call $list_extend_to (call $make_list (i32.const 1)) (i32.const 1)))
    (drop (call $list_set (local.get $l) (i32.const 0) (local.get $t)))
    (local.get $l))
  (func $tylist2 (param $t1 i32) (param $t2 i32) (result i32)
    (local $l i32)
    (local.set $l (call $list_extend_to (call $make_list (i32.const 2)) (i32.const 2)))
    (drop (call $list_set (local.get $l) (i32.const 0) (local.get $t1)))
    (drop (call $list_set (local.get $l) (i32.const 1) (local.get $t2)))
    (local.get $l))

  (func $is_seq_op (param $cname i32) (result i32)
    (if (call $str_eq (local.get $cname) (i32.const 6640)) (then (return (i32.const 1)))) ;; len
    (if (call $str_eq (local.get $cname) (i32.const 4288)) (then (return (i32.const 1)))) ;; list_index
    (if (call $str_eq (local.get $cname) (i32.const 6648)) (then (return (i32.const 1)))) ;; list_head
    (if (call $str_eq (local.get $cname) (i32.const 6664)) (then (return (i32.const 1)))) ;; list_tail
    (if (call $str_eq (local.get $cname) (i32.const 6680)) (then (return (i32.const 1)))) ;; list_set
    (if (call $str_eq (local.get $cname) (i32.const 6696)) (then (return (i32.const 1)))) ;; list_concat
    (if (call $str_eq (local.get $cname) (i32.const 6712)) (then (return (i32.const 1)))) ;; make_list
    (if (call $str_eq (local.get $cname) (i32.const 6728)) (then (return (i32.const 1)))) ;; slice
    (if (call $str_eq (local.get $cname) (i32.const 6740)) (then (return (i32.const 1)))) ;; push
    (if (call $str_eq (local.get $cname) (i32.const 6752)) (then (return (i32.const 1)))) ;; map
    (if (call $str_eq (local.get $cname) (i32.const 6768)) (then (return (i32.const 1)))) ;; filter
    (if (call $str_eq (local.get $cname) (i32.const 6784)) (then (return (i32.const 1)))) ;; flatten
    (if (call $str_eq (local.get $cname) (i32.const 6800)) (then (return (i32.const 1)))) ;; fold
    (if (call $str_eq (local.get $cname) (i32.const 6816)) (then (return (i32.const 1)))) ;; for_each
    (if (call $str_eq (local.get $cname) (i32.const 6832)) (then (return (i32.const 1)))) ;; take
    (if (call $str_eq (local.get $cname) (i32.const 6848)) (then (return (i32.const 1)))) ;; drop
    (if (call $str_eq (local.get $cname) (i32.const 6864)) (then (return (i32.const 1)))) ;; any
    (if (call $str_eq (local.get $cname) (i32.const 6880)) (then (return (i32.const 1)))) ;; all
    (if (call $str_eq (local.get $cname) (i32.const 6896)) (then (return (i32.const 1)))) ;; find
    (if (call $str_eq (local.get $cname) (i32.const 6912)) (then (return (i32.const 1)))) ;; count
    (i32.const 0))

  (func $infer_seq_op (param $cname i32) (param $ah i32) (param $handle i32)
        (param $span i32) (result i32)
    (local $elem i32) (local $res i32) (local $elem_b i32)
    (local.set $elem (call $ty_make_tvar
      (call $graph_fresh_ty (call $reason_make_inferred (i32.const 3672)))))
    ;; ─── Functor projections — the cursor in transform/fold/filter mode ───
    ;; Typed by element + transform's range, read live; NOT from the buffer body.
    (if (call $str_eq (local.get $cname) (i32.const 6752))           ;; map(f,xs):(a->b,[a])->[b]
      (then
        (local.set $elem_b (call $ty_make_tvar (call $graph_fresh_ty (call $reason_make_inferred (i32.const 3672)))))
        (call $seq_force (local.get $ah) (i32.const 1) (call $ty_make_tlist (local.get $elem)) (local.get $span))
        (call $seq_force_fn (local.get $ah) (i32.const 0) (call $tylist1 (local.get $elem)) (local.get $elem_b) (local.get $span))
        (call $graph_bind (local.get $handle) (call $ty_make_tlist (local.get $elem_b))
          (call $reason_make_located (local.get $span) (call $reason_make_inferred (i32.const 3672))))
        (return (local.get $handle))))
    (if (call $str_eq (local.get $cname) (i32.const 6768))           ;; filter(p,xs):(a->Bool,[a])->[a]
      (then
        (call $seq_force (local.get $ah) (i32.const 1) (call $ty_make_tlist (local.get $elem)) (local.get $span))
        (call $seq_force_fn (local.get $ah) (i32.const 0) (call $tylist1 (local.get $elem))
          (call $ty_make_tname (i32.const 3504) (call $make_list (i32.const 0))) (local.get $span))
        (call $graph_bind (local.get $handle) (call $ty_make_tlist (local.get $elem))
          (call $reason_make_located (local.get $span) (call $reason_make_inferred (i32.const 3672))))
        (return (local.get $handle))))
    (if (call $str_eq (local.get $cname) (i32.const 6784))           ;; flatten([[a]]):[a]
      (then
        (call $seq_force (local.get $ah) (i32.const 0)
          (call $ty_make_tlist (call $ty_make_tlist (local.get $elem))) (local.get $span))
        (call $graph_bind (local.get $handle) (call $ty_make_tlist (local.get $elem))
          (call $reason_make_located (local.get $span) (call $reason_make_inferred (i32.const 3672))))
        (return (local.get $handle))))
    (if (call $str_eq (local.get $cname) (i32.const 6800))           ;; fold(xs,init,f):([a],b,(b,a)->b)->b
      (then
        (local.set $elem_b (call $ty_make_tvar (call $graph_fresh_ty (call $reason_make_inferred (i32.const 3672)))))
        (call $seq_force (local.get $ah) (i32.const 0) (call $ty_make_tlist (local.get $elem)) (local.get $span))
        (call $seq_force (local.get $ah) (i32.const 1) (local.get $elem_b) (local.get $span))
        (call $seq_force_fn (local.get $ah) (i32.const 2) (call $tylist2 (local.get $elem_b) (local.get $elem)) (local.get $elem_b) (local.get $span))
        (call $graph_bind (local.get $handle) (local.get $elem_b)
          (call $reason_make_located (local.get $span) (call $reason_make_inferred (i32.const 3672))))
        (return (local.get $handle))))
    (if (call $str_eq (local.get $cname) (i32.const 6816))           ;; for_each(f,xs):(a->(),[a])->()
      (then
        (call $seq_force (local.get $ah) (i32.const 1) (call $ty_make_tlist (local.get $elem)) (local.get $span))
        (call $seq_force_fn (local.get $ah) (i32.const 0) (call $tylist1 (local.get $elem)) (call $ty_make_tunit) (local.get $span))
        (call $graph_bind (local.get $handle) (call $ty_make_tunit)
          (call $reason_make_located (local.get $span) (call $reason_make_inferred (i32.const 3672))))
        (return (local.get $handle))))
    (if (call $str_eq (local.get $cname) (i32.const 6832))           ;; take(xs,n):([a],Int)->[a]
      (then
        (call $seq_force (local.get $ah) (i32.const 0) (call $ty_make_tlist (local.get $elem)) (local.get $span))
        (call $seq_force (local.get $ah) (i32.const 1) (call $ty_make_tint) (local.get $span))
        (call $graph_bind (local.get $handle) (call $ty_make_tlist (local.get $elem))
          (call $reason_make_located (local.get $span) (call $reason_make_inferred (i32.const 3672))))
        (return (local.get $handle))))
    (if (call $str_eq (local.get $cname) (i32.const 6848))           ;; drop(n,xs):(Int,[a])->[a]
      (then
        (call $seq_force (local.get $ah) (i32.const 0) (call $ty_make_tint) (local.get $span))
        (call $seq_force (local.get $ah) (i32.const 1) (call $ty_make_tlist (local.get $elem)) (local.get $span))
        (call $graph_bind (local.get $handle) (call $ty_make_tlist (local.get $elem))
          (call $reason_make_located (local.get $span) (call $reason_make_inferred (i32.const 3672))))
        (return (local.get $handle))))
    (if (i32.or (i32.or (call $str_eq (local.get $cname) (i32.const 6864))   ;; any
                        (call $str_eq (local.get $cname) (i32.const 6880)))  ;; all
                (call $str_eq (local.get $cname) (i32.const 6912)))          ;; count
      (then
        (call $seq_force (local.get $ah) (i32.const 1) (call $ty_make_tlist (local.get $elem)) (local.get $span))
        (call $seq_force_fn (local.get $ah) (i32.const 0) (call $tylist1 (local.get $elem))
          (call $ty_make_tname (i32.const 3504) (call $make_list (i32.const 0))) (local.get $span))
        (call $graph_bind (local.get $handle)
          (if (result i32) (call $str_eq (local.get $cname) (i32.const 6912))
            (then (call $ty_make_tint))
            (else (call $ty_make_tname (i32.const 3504) (call $make_list (i32.const 0)))))
          (call $reason_make_located (local.get $span) (call $reason_make_inferred (i32.const 3672))))
        (return (local.get $handle))))
    (if (call $str_eq (local.get $cname) (i32.const 6896))           ;; find(p,xs):(a->Bool,[a])->Option(a)
      (then
        (call $seq_force (local.get $ah) (i32.const 1) (call $ty_make_tlist (local.get $elem)) (local.get $span))
        (call $seq_force_fn (local.get $ah) (i32.const 0) (call $tylist1 (local.get $elem))
          (call $ty_make_tname (i32.const 3504) (call $make_list (i32.const 0))) (local.get $span))
        (call $graph_bind (local.get $handle)
          (call $ty_make_tname (i32.const 6928) (call $tylist1 (local.get $elem)))
          (call $reason_make_located (local.get $span) (call $reason_make_inferred (i32.const 3672))))
        (return (local.get $handle))))
    ;; arg0 is a sequence for every op except make_list (arg0 = count Int).
    (if (call $str_eq (local.get $cname) (i32.const 6712))            ;; make_list
      (then (call $seq_force (local.get $ah) (i32.const 0) (call $ty_make_tint) (local.get $span)))
      (else (call $seq_force (local.get $ah) (i32.const 0)
        (call $ty_make_tlist (local.get $elem)) (local.get $span))))
    ;; extra operand forces
    (if (call $str_eq (local.get $cname) (i32.const 4288))            ;; list_index(_, Int)
      (then (call $seq_force (local.get $ah) (i32.const 1) (call $ty_make_tint) (local.get $span))))
    (if (call $str_eq (local.get $cname) (i32.const 6680))            ;; list_set(_, Int, elem)
      (then (call $seq_force (local.get $ah) (i32.const 1) (call $ty_make_tint) (local.get $span))
            (call $seq_force (local.get $ah) (i32.const 2) (local.get $elem) (local.get $span))))
    (if (call $str_eq (local.get $cname) (i32.const 6696))            ;; list_concat(_, [elem])
      (then (call $seq_force (local.get $ah) (i32.const 1)
        (call $ty_make_tlist (local.get $elem)) (local.get $span))))
    (if (call $str_eq (local.get $cname) (i32.const 6728))            ;; slice(_, Int, Int)
      (then (call $seq_force (local.get $ah) (i32.const 1) (call $ty_make_tint) (local.get $span))
            (call $seq_force (local.get $ah) (i32.const 2) (call $ty_make_tint) (local.get $span))))
    (if (call $str_eq (local.get $cname) (i32.const 6740))            ;; push(_, elem)
      (then (call $seq_force (local.get $ah) (i32.const 1) (local.get $elem) (local.get $span))))
    ;; result: head/index → elem; len → Int; everything else → [elem]
    (local.set $res
      (if (result i32)
        (i32.or (call $str_eq (local.get $cname) (i32.const 6648))    ;; list_head
                (call $str_eq (local.get $cname) (i32.const 4288)))   ;; list_index
        (then (local.get $elem))
        (else
          (if (result i32) (call $str_eq (local.get $cname) (i32.const 6640))  ;; len
            (then (call $ty_make_tint))
            (else (call $ty_make_tlist (local.get $elem)))))))
    (call $graph_bind (local.get $handle) (local.get $res)
      (call $reason_make_located (local.get $span)
        (call $reason_make_inferred (i32.const 3672))))
    (local.get $handle))

  ;; LambdaExpr arm — src/infer.mn:724-740. Builds TFun([], TVar(body_h),
  ;; row=fresh) at the seed; param-list typing/env-extend lives in the
  ;; wheel's mint_params path which depends on parser-emitted Param record
  ;; structure (Hβ.infer.lambda-params named follow-up). Per Drift 9
  ;; closure: arm binds the lambda handle even with empty params; future
  ;; commit fills the params.
  (func $infer_walk_expr_lambda
        (export "infer_walk_expr_lambda")
        (param $expr i32) (param $handle i32) (param $span i32)
        (result i32)
    (local $body_node i32) (local $bh i32)
    (local $row_h i32) (local $params_parser i32)
    (local $tparam_list i32) (local $param_handles i32)
    (local $n_params i32) (local $i i32) (local $param i32)
    (local $param_name i32) (local $param_h i32)
    ;; Layout: [tag=89][params][body]
    (local.set $params_parser (i32.load offset=4 (local.get $expr)))
    (local.set $body_node (i32.load offset=8 (local.get $expr)))
    (call $env_scope_enter)

    (local.set $n_params (call $len (local.get $params_parser)))
    (local.set $param_handles (call $make_list (i32.const 0)))
    (local.set $param_handles (call $list_extend_to (local.get $param_handles) (local.get $n_params)))
    (local.set $i (i32.const 0))
    (block $params_done
      (loop $each_param
        (br_if $params_done (i32.ge_u (local.get $i) (local.get $n_params)))
        (local.set $param (call $list_index (local.get $params_parser) (local.get $i)))
        (local.set $param_name (i32.load offset=4 (local.get $param)))
        (local.set $param_h (call $graph_fresh_ty
          (call $reason_make_located (local.get $span)
            (call $reason_make_inferred (i32.const 4056)))))   ;; "param"
        (drop (call $list_set (local.get $param_handles) (local.get $i) (local.get $param_h)))
        (call $env_extend
          (local.get $param_name)
          (call $scheme_make_forall
            (call $make_list (i32.const 0))
            (call $ty_make_tvar (local.get $param_h)))
          (call $reason_make_located
            (local.get $span)
            (call $reason_make_declared (local.get $param_name)))
          (call $schemekind_make_fn))
        (local.set $i (i32.add (local.get $i) (i32.const 1)))
        (br $each_param)))

    (local.set $tparam_list (call $walk_expr_build_inferred_params (local.get $param_handles)))

    (local.set $row_h (call $graph_fresh_row
      (call $reason_make_inferred (i32.const 3984))))   ;; "lambda"
    (call $walk_expr_inf_enter_fn (local.get $row_h) (local.get $span))
    (local.set $bh (call $infer_walk_expr (local.get $body_node)))
    (call $walk_expr_inf_exit_fn)
    ;; CREATE-CAPTURES-EVIDENCE FLOW EDGE. A closure created here CAPTURES the
    ;; enclosing fn's evidence for the effects it performs (it reads that frame
    ;; at call time), so the enclosing fn's row RECEIVES this closure's row —
    ;; read live (open([], row_h) resolves to the lambda's accumulated effects).
    ;; This is the dual of the call edge ($infer_row_edge_append) that already
    ;; flows a callee's row into the frame; closure-creation flowed nothing —
    ;; that asymmetry lost the escaping closure's effects (use_each_Env2). The
    ;; graph already proved the lambda's row; flow it, never re-derive.
    (call $walk_expr_inf_add_row
      (call $row_make_open (call $make_list (i32.const 0)) (local.get $row_h)))

    (call $graph_bind (local.get $handle)
      (call $ty_make_tfun
        (local.get $tparam_list)
        (call $ty_make_tvar (local.get $bh))
        (call $row_make_open (call $make_list (i32.const 0)) (local.get $row_h)))
      (call $reason_make_located (local.get $span)
        (call $reason_make_inferred (i32.const 3984))))   ;; "lambda"
    (call $env_scope_exit)
    (local.get $handle))

  ;; IfExpr arm — src/infer.mn:529-539. cond ↔ Bool; then/else unified;
  ;; result = TVar(then_h).
  (func $infer_walk_expr_if
        (export "infer_walk_expr_if")
        (param $expr i32) (param $handle i32) (param $span i32)
        (result i32)
    (local $cond i32) (local $then_e i32) (local $else_e i32)
    (local $ch i32) (local $th i32) (local $eh i32)
    ;; Layout: [tag=90][cond][then][else]
    (local.set $cond   (i32.load offset=4  (local.get $expr)))
    (local.set $then_e (i32.load offset=8  (local.get $expr)))
    (local.set $else_e (i32.load offset=12 (local.get $expr)))
    (local.set $ch (call $infer_walk_expr (local.get $cond)))
    (local.set $th (call $infer_walk_expr (local.get $then_e)))
    (local.set $eh (call $infer_walk_expr (local.get $else_e)))
    ;; cond ↔ Bool
    (call $graph_bind (local.get $ch)
      (call $ty_make_tname (i32.const 3504) (call $make_list (i32.const 0)))
      (call $reason_make_located (local.get $span)
        (call $reason_make_inferred (i32.const 3768))))   ;; "if condition"
    ;; then/else unified
    (call $unify (local.get $th) (local.get $eh) (local.get $span)
      (call $reason_make_ifbranch
        (call $reason_make_inferred (i32.const 3792))))   ;; "if branches"
    ;; result type
    (call $graph_bind (local.get $handle)
      (call $ty_make_tvar (local.get $th))
      (call $reason_make_located (local.get $span)
        (call $reason_make_ifbranch
          (call $reason_make_inferred (i32.const 3816))))) ;; "if result"
    (local.get $handle))

  ;; BlockExpr arm — src/infer.mn:541-548. stmts walked via forward-
  ;; declared $infer_stmt_list; final_expr walked normally; block type =
  ;; TVar(final_expr_h).
  ;;
  ;; Forward-decl: $infer_stmt_list lands in walk_stmt.wat per Hβ.infer
  ;; §13.3 #9 (peer Tier 7 chunk; NOT silent deferral). Until walk_stmt
  ;; lands the seed binds the block as TVar(final_h) without having
  ;; processed the stmts — degenerate but type-sound for blocks whose
  ;; stmts don't shadow names used in final_expr (which is the common
  ;; case). The peer chunk's call site is parameterized by the stmts list
  ;; from offset 4.
  (func $infer_walk_expr_block
        (export "infer_walk_expr_block")
        (param $expr i32) (param $handle i32) (param $span i32)
        (result i32)
    (local $stmts i32) (local $final_e i32) (local $fh i32)
    ;; Layout: [tag=91][stmts][final_expr]
    (local.set $stmts   (i32.load offset=4 (local.get $expr)))
    (local.set $final_e (i32.load offset=8 (local.get $expr)))
    (call $env_scope_enter)
    ;; walk_stmt.wat peer chunk now landed (Hβ.infer §13.3 #9 closed):
    ;; walk the block's stmts so their let-extends populate env before
    ;; final_expr's VarRefs read.
    (call $infer_stmt_list (local.get $stmts))
    (local.set $fh (call $infer_walk_expr (local.get $final_e)))
    (call $graph_bind (local.get $handle)
      (call $ty_make_tvar (local.get $fh))
      (call $reason_make_located (local.get $span)
        (call $reason_make_inferred (i32.const 3840))))   ;; "block result"
    (call $env_scope_exit)
    (local.get $handle))

  ;; ─── $infer_walk_pat — Phase B.5 ultimate-form pattern walk ─────────
  ;;
  ;; Recursive constructor-aware pattern walker. Dispatches on Pat tag
  ;; (130-136 per parser_pat.wat). Called from MatchExpr arms + LetStmt.
  ;;
  ;; Eight interrogations:
  ;;   1. Graph:      PCon unifies ctor result type with scrut_h.
  ;;   2. Handler:    Direct seed call, recursive.
  ;;   3. Verb:       N/A — structural.
  ;;   4. Row:        Opaque per Hβ.infer.row-normalize.
  ;;   5. Ownership:  Patterns INTRODUCE names (env_extend). No Consume.
  ;;   6. Refinement: PCon carries tag_id via ConstructorScheme.
  ;;   7. Gradient:   PVar is Forall([], TVar(h)) — monomorphic pin.
  ;;   8. Reason:     PVar: Located(span, LetBinding(name, Inferred("pattern"))).
  ;;
  ;; Drift-6 closure: Bool match through PLit(LVBool), not PCon.
  ;; Same dispatch path as any other literal pattern.
  ;;
  ;; Exports: $infer_walk_pat (called from walk_stmt.wat LetStmt arm).
  (func $infer_walk_pat
        (export "infer_walk_pat")
        (param $pat i32) (param $scrut_h i32) (param $span i32)
    (local $tag i32) (local $name i32) (local $reason i32)
    (local $ctor_name i32) (local $sub_pats i32)
    (local $binding i32) (local $scheme i32)
    (local $ctor_ty i32) (local $ctor_tag i32)
    (local $params i32) (local $result_ty i32) (local $result_h i32)
    (local $n_params i32) (local $n_subs i32) (local $min_n i32)
    (local $i i32) (local $sub_pat i32) (local $sub_h i32)
    (local $tparam i32) (local $tp_ty i32)
    (local $lit_val i32) (local $lit_tag i32)
    (local $elems i32) (local $n_elems i32) (local $elem_h i32)
    (local $rest_opt i32) (local $rest_name i32)
    ;; PWild sentinel (131) — no binding, no unification.
    (if (i32.eq (local.get $pat) (i32.const 131))
      (then (return)))
    ;; Below HEAP_BASE and not PWild → unknown sentinel; no-op.
    (if (i32.lt_u (local.get $pat) (global.get $heap_base))
      (then (return)))
    (local.set $tag (call $tag_of (local.get $pat)))
    ;; ── PVar (130) ──────────────────────────────────────────────
    (if (i32.eq (local.get $tag) (i32.const 130))
      (then
        (local.set $name (i32.load offset=4 (local.get $pat)))
        (local.set $reason (call $reason_make_located
          (local.get $span)
          (call $reason_make_letbinding (local.get $name)
            (call $reason_make_inferred (i32.const 4032)))))  ;; "pattern"
        (call $env_extend
          (local.get $name)
          (call $scheme_make_forall
            (call $make_list (i32.const 0))
            (call $ty_make_tvar (local.get $scrut_h)))
          (local.get $reason)
          (call $schemekind_make_fn))
        (return)))
    ;; ── PLit (132) ──────────────────────────────────────────────
    (if (i32.eq (local.get $tag) (i32.const 132))
      (then
        (local.set $lit_val (i32.load offset=4 (local.get $pat)))
        (local.set $lit_tag (call $tag_of (local.get $lit_val)))
        (local.set $reason (call $reason_make_located
          (local.get $span)
          (call $reason_make_inferred (i32.const 4032))))  ;; "pattern"
        (if (i32.eq (local.get $lit_tag) (i32.const 180))  ;; LVInt
          (then
            (call $graph_bind (local.get $scrut_h)
              (call $ty_make_tint) (local.get $reason))
            (return)))
        (if (i32.eq (local.get $lit_tag) (i32.const 181))  ;; LVFloat
          (then
            (call $graph_bind (local.get $scrut_h)
              (call $ty_make_tfloat) (local.get $reason))
            (return)))
        (if (i32.eq (local.get $lit_tag) (i32.const 182))  ;; LVString
          (then
            (call $graph_bind (local.get $scrut_h)
              (call $ty_make_tstring) (local.get $reason))
            (return)))
        (if (i32.eq (local.get $lit_tag) (i32.const 183))  ;; LVBool
          (then
            (call $graph_bind (local.get $scrut_h)
              (call $ty_make_tname (i32.const 3504)
                (call $make_list (i32.const 0)))
              (local.get $reason))
            (return)))
        (return)))
    ;; ── PCon (133) — constructor-aware pattern ──────────────────
    (if (i32.eq (local.get $tag) (i32.const 133))
      (then
        (local.set $ctor_name (i32.load offset=4 (local.get $pat)))
        (local.set $sub_pats (i32.load offset=8 (local.get $pat)))
        (local.set $binding (call $env_lookup_ctor (local.get $ctor_name)))
        (if (i32.eqz (local.get $binding))
          (then
            ;; Constructor not in env — walk sub_pats with fresh handles
            ;; (productive-under-error: inner PVar bindings still land).
            (local.set $n_subs (call $len (local.get $sub_pats)))
            (local.set $i (i32.const 0))
            (block $miss_done
              (loop $miss_each
                (br_if $miss_done
                  (i32.ge_u (local.get $i) (local.get $n_subs)))
                (local.set $sub_h (call $graph_fresh_ty
                  (call $reason_make_inferred (i32.const 4032))))
                (call $infer_walk_pat
                  (call $list_index (local.get $sub_pats) (local.get $i))
                  (local.get $sub_h) (local.get $span))
                (local.set $i (i32.add (local.get $i) (i32.const 1)))
                (br $miss_each)))
            (return)))
        ;; Found — instantiate constructor's scheme.
        (local.set $scheme
          (call $env_binding_scheme (local.get $binding)))
        (local.set $ctor_ty (call $instantiate (local.get $scheme)))
        (local.set $ctor_tag (call $ty_tag (local.get $ctor_ty)))
        (local.set $reason (call $reason_make_located
          (local.get $span)
          (call $reason_make_declared (local.get $ctor_name))))
        ;; N-ary constructor: TFun(params, result_ty, row)
        (if (i32.eq (local.get $ctor_tag) (i32.const 107))
          (then
            ;; Unify result type with scrutinee.
            (local.set $result_ty
              (call $ty_tfun_return (local.get $ctor_ty)))
            (local.set $result_h
              (call $graph_fresh_ty (local.get $reason)))
            (call $graph_bind (local.get $result_h)
              (local.get $result_ty) (local.get $reason))
            (call $unify (local.get $result_h) (local.get $scrut_h)
              (local.get $span) (local.get $reason))
            ;; Walk sub-patterns with constructor field types.
            (local.set $params
              (call $ty_tfun_params (local.get $ctor_ty)))
            (local.set $n_params (call $len (local.get $params)))
            (local.set $n_subs (call $len (local.get $sub_pats)))
            (local.set $min_n (local.get $n_params))
            (if (i32.lt_u (local.get $n_subs) (local.get $min_n))
              (then (local.set $min_n (local.get $n_subs))))
            (local.set $i (i32.const 0))
            (block $con_done
              (loop $con_each
                (br_if $con_done
                  (i32.ge_u (local.get $i) (local.get $min_n)))
                (local.set $tparam
                  (call $list_index (local.get $params) (local.get $i)))
                (local.set $tp_ty
                  (call $tparam_ty (local.get $tparam)))
                (local.set $sub_h
                  (call $graph_fresh_ty (local.get $reason)))
                (call $graph_bind (local.get $sub_h)
                  (local.get $tp_ty) (local.get $reason))
                (call $infer_walk_pat
                  (call $list_index
                    (local.get $sub_pats) (local.get $i))
                  (local.get $sub_h) (local.get $span))
                (local.set $i
                  (i32.add (local.get $i) (i32.const 1)))
                (br $con_each)))
            (return)))
        ;; Nullary constructor: unify ctor_ty with scrutinee.
        (local.set $result_h
          (call $graph_fresh_ty (local.get $reason)))
        (call $graph_bind (local.get $result_h)
          (local.get $ctor_ty) (local.get $reason))
        (call $unify (local.get $result_h) (local.get $scrut_h)
          (local.get $span) (local.get $reason))
        (return)))
    ;; ── PTuple (134) ────────────────────────────────────────────
    (if (i32.eq (local.get $tag) (i32.const 134))
      (then
        (local.set $elems (i32.load offset=4 (local.get $pat)))
        (local.set $n_elems (call $len (local.get $elems)))
        (local.set $params (call $make_list (i32.const 0)))
        (local.set $params
          (call $list_extend_to (local.get $params) (local.get $n_elems)))
        (local.set $i (i32.const 0))
        (block $tup_done
          (loop $tup_each
            (br_if $tup_done
              (i32.ge_u (local.get $i) (local.get $n_elems)))
            (local.set $elem_h (call $graph_fresh_ty
              (call $reason_make_inferred (i32.const 4032))))
            (call $infer_walk_pat
              (call $list_index (local.get $elems) (local.get $i))
              (local.get $elem_h) (local.get $span))
            (drop (call $list_set (local.get $params) (local.get $i)
              (call $ty_make_tvar (local.get $elem_h))))
            (local.set $i (i32.add (local.get $i) (i32.const 1)))
            (br $tup_each)))
        (local.set $result_h (call $graph_fresh_ty
          (call $reason_make_inferred (i32.const 4032))))
        (call $graph_bind (local.get $result_h)
          (call $ty_make_ttuple (local.get $params))
          (call $reason_make_located (local.get $span)
            (call $reason_make_inferred (i32.const 4032))))
        (call $unify (local.get $result_h) (local.get $scrut_h)
          (local.get $span)
          (call $reason_make_located (local.get $span)
            (call $reason_make_inferred (i32.const 4032))))
        (return)))
    ;; ── PList (135) ─────────────────────────────────────────────
    (if (i32.eq (local.get $tag) (i32.const 135))
      (then
        (local.set $elems (i32.load offset=4 (local.get $pat)))
        (local.set $rest_opt (i32.load offset=8 (local.get $pat)))
        (local.set $n_elems (call $len (local.get $elems)))
        (local.set $elem_h (call $graph_fresh_ty
          (call $reason_make_inferred (i32.const 4032))))
        (local.set $i (i32.const 0))
        (block $list_done
          (loop $list_each
            (br_if $list_done
              (i32.ge_u (local.get $i) (local.get $n_elems)))
            (call $infer_walk_pat
              (call $list_index (local.get $elems) (local.get $i))
              (local.get $elem_h) (local.get $span))
            (local.set $i (i32.add (local.get $i) (i32.const 1)))
            (br $list_each)))
        (local.set $result_h (call $graph_fresh_ty
          (call $reason_make_inferred (i32.const 4032))))
        (call $graph_bind (local.get $result_h)
          (call $ty_make_tlist
            (call $ty_make_tvar (local.get $elem_h)))
          (call $reason_make_located (local.get $span)
            (call $reason_make_inferred (i32.const 4032))))
        (if (i32.and
              (i32.ge_u (local.get $rest_opt) (global.get $heap_base))
              (i32.eq (call $tag_of (local.get $rest_opt)) (i32.const 1)))
          (then
            (local.set $rest_name (i32.load offset=4 (local.get $rest_opt)))
            (if (i32.or
                  (i32.ne (call $str_len (local.get $rest_name)) (i32.const 1))
                  (i32.ne (call $byte_at (local.get $rest_name) (i32.const 0)) (i32.const 95)))
              (then
                (local.set $reason (call $reason_make_located
                  (local.get $span)
                  (call $reason_make_letbinding (local.get $rest_name)
                    (call $reason_make_inferred (i32.const 4032)))))
                (call $env_extend
                  (local.get $rest_name)
                  (call $scheme_make_forall
                    (call $make_list (i32.const 0))
                    (call $ty_make_tlist
                      (call $ty_make_tvar (local.get $elem_h))))
                  (local.get $reason)
                  (call $schemekind_make_fn))))))
        (call $unify (local.get $result_h) (local.get $scrut_h)
          (local.get $span)
          (call $reason_make_located (local.get $span)
            (call $reason_make_inferred (i32.const 4032))))
        (return)))
    ;; ── PAlt (137) — pattern alternation ────────────────────────
    ;; Every branch constrains the SAME scrutinee handle — branch
    ;; pattern types unify through it by construction. The binding
    ;; law (same names, unifiable types across branches → else
    ;; E_PatternAlternationBindingMismatch) is the WHEEL's infer
    ;; (enforce_alt_binding_law, src/infer.mn); the seed walks
    ;; branches so law-abiding wheel source compiles whole. The
    ;; wheel's own alternation arms are binder-free; the disposable
    ;; seed does not duplicate the wheel's diagnostic surface.
    (if (i32.eq (local.get $tag) (i32.const 137))
      (then
        (local.set $elems (i32.load offset=4 (local.get $pat)))
        (local.set $n_elems (call $len (local.get $elems)))
        (local.set $i (i32.const 0))
        (block $alt_done
          (loop $alt_each
            (br_if $alt_done
              (i32.ge_u (local.get $i) (local.get $n_elems)))
            (call $infer_walk_pat
              (call $list_index (local.get $elems) (local.get $i))
              (local.get $scrut_h) (local.get $span))
            (local.set $i (i32.add (local.get $i) (i32.const 1)))
            (br $alt_each)))
        (return)))
    ;; ── PRecord (136) — record pattern (src/infer.mn:1803-1815) ─
    ;; Scrutinee accepts any record with AT LEAST these fields: bind
    ;; to TRecordOpen(field_specs, fresh row). Each sub-pattern walks
    ;; against its field's fresh handle; punned fields are PVar and
    ;; bind into env through the recursion.
    (if (i32.eq (local.get $tag) (i32.const 136))
      (then
        (local.set $elems (i32.load offset=4 (local.get $pat)))
        (local.set $n_elems (call $len (local.get $elems)))
        (local.set $reason (call $reason_make_located
          (local.get $span)
          (call $reason_make_inferred (i32.const 4032))))  ;; "pattern"
        (local.set $params (call $make_list (local.get $n_elems)))
        (local.set $i (i32.const 0))
        (block $rec_done
          (loop $rec_each
            (br_if $rec_done (i32.ge_u (local.get $i) (local.get $n_elems)))
            (local.set $sub_pat (call $list_index (local.get $elems) (local.get $i)))
            (local.set $name (call $record_get (local.get $sub_pat) (i32.const 0)))
            (local.set $sub_h (call $graph_fresh_ty (local.get $reason)))
            (drop (call $list_set (local.get $params) (local.get $i)
              (call $field_pair_make (local.get $name)
                (call $ty_make_tvar (local.get $sub_h)))))
            (call $infer_walk_pat
              (call $record_get (local.get $sub_pat) (i32.const 1))
              (local.get $sub_h) (local.get $span))
            (local.set $i (i32.add (local.get $i) (i32.const 1)))
            (br $rec_each)))
        (call $graph_bind (local.get $scrut_h)
          (call $ty_make_trecordopen (local.get $params)
            (call $graph_fresh_row (local.get $reason)))
          (local.get $reason))
        (return)))
    )

  ;; MatchExpr arm — src/infer.mn:550-553 + 1701-1733. Walks scrutinee +
  ;; each arm-body; pattern walk via $infer_walk_pat (B.5 landed);
  ;; exhaustiveness check (Hβ.infer.match-exhaustive) is a named follow-up.
  (func $infer_walk_expr_match
        (export "infer_walk_expr_match")
        (param $expr i32) (param $handle i32) (param $span i32)
        (result i32)
    (local $scrut i32) (local $arms i32) (local $sh i32)
    ;; Layout: [tag=92][scrut][arms]
    (local.set $scrut (i32.load offset=4 (local.get $expr)))
    (local.set $arms  (i32.load offset=8 (local.get $expr)))
    (local.set $sh (call $infer_walk_expr (local.get $scrut)))
    (call $infer_walk_expr_match_arms
      (local.get $arms) (local.get $handle) (local.get $sh)
      (local.get $span))
    (local.get $handle))

  ;; MatchExpr arms iterator — for each arm: scope_enter, walk pattern
  ;; via $infer_walk_pat (B.5), walk arm-body, unify body_h ↔ result_h,
  ;; scope_exit. Mirrors src/infer.mn:1721-1731.
  ;; Arms are 2-tuple lists (pat, body) per parser_pat.wat:357-360.
  (func $infer_walk_expr_match_arms
        (export "infer_walk_expr_match_arms")
        (param $arms i32) (param $result_h i32) (param $scrut_h i32)
        (param $span i32)
    (local $n i32) (local $i i32)
    (local $arm i32) (local $pat i32) (local $body i32)
    (local $bh i32) (local $first i32)
    (local.set $n (call $len (local.get $arms)))
    (local.set $i (i32.const 0))
    (local.set $first (i32.const 1))
    (block $done
      (loop $each
        (br_if $done (i32.ge_u (local.get $i) (local.get $n)))
        (local.set $arm (call $list_index (local.get $arms) (local.get $i)))
        (call $env_scope_enter)
        ;; Walk pattern — binds PVar names into this arm's scope.
        (local.set $pat
          (call $list_index (local.get $arm) (i32.const 0)))
        (call $infer_walk_pat
          (local.get $pat) (local.get $scrut_h) (local.get $span))
        ;; Walk body.
        (local.set $body
          (call $list_index (local.get $arm) (i32.const 1)))
        (local.set $bh (call $infer_walk_expr (local.get $body)))
        ;; First arm: bind result_h ↔ TVar(first_arm_h). Subsequent: unify.
        (if (local.get $first)
          (then
            (call $graph_bind (local.get $result_h)
              (call $ty_make_tvar (local.get $bh))
              (call $reason_make_located (local.get $span)
                (call $reason_make_matchbranch
                  (call $reason_make_inferred (i32.const 3864))   ;; "arm body"
                  (call $reason_make_inferred (i32.const 3584))))) ;; "result"
            (local.set $first (i32.const 0)))
          (else
            (call $unify (local.get $bh) (local.get $result_h)
              (local.get $span)
              (call $reason_make_matchbranch
                (call $reason_make_inferred (i32.const 3864))
                (call $reason_make_inferred (i32.const 3584))))))
        (call $env_scope_exit)
        (local.set $i (i32.add (local.get $i) (i32.const 1)))
        (br $each))))

  ;; HandleExpr arm — src/infer.mn:623-695. Body walked + arms walked +
  ;; arm-bodies unified to body_h. Row absorption, region tracking, and
  ;; handler-uninstallable check are seed-stubs per Hβ.infer.row-normalize
  ;; / .handler-stack / .region-tracker named follow-ups.
  (func $infer_walk_expr_handle
        (export "infer_walk_expr_handle")
        (param $expr i32) (param $handle i32) (param $span i32)
        (result i32)
    (local $body_node i32) (local $arms i32) (local $bh i32)
    (local $body_row_h i32) (local $arm_row_h i32)
    (local $state_pairs i32)
    ;; Layout: [tag=93][body][arms][state][install] per parser_handler.wat
    ;; HandleExpr build. State fields are (name, init) pairs from the
    ;; `with FIELD = INIT` form-2 clause; install (offset 16) is the
    ;; form-3 handler-value expression.
    (local.set $body_node (i32.load offset=4 (local.get $expr)))
    (local.set $arms      (i32.load offset=8 (local.get $expr)))
    ;; State inits walk at the INSTALL site — their types are proven
    ;; here (`with counts = (0, 0)` IS (Int, Int)); arm bodies read the
    ;; names through the scope opened below.
    (local.set $state_pairs (call $infer_handler_state_init_pairs
      (i32.load offset=12 (local.get $expr))))
    ;; handler-stack push (seed-stub)
    (call $walk_expr_inf_push_handler
      (call $walk_expr_collect_handled_effects (local.get $arms)))
    ;; Body inference under its own row scope (seed-stub)
    (local.set $body_row_h (call $graph_fresh_row
      (call $reason_make_inferred (i32.const 3696))))   ;; "effects"
    (call $walk_expr_inf_enter_fn (local.get $body_row_h) (local.get $span))
    (local.set $bh (call $infer_walk_expr (local.get $body_node)))
    (call $walk_expr_inf_exit_fn)
    ;; Arms inference — state names in scope for every arm body.
    (local.set $arm_row_h (call $graph_fresh_row
      (call $reason_make_inferred (i32.const 3696))))
    (call $walk_expr_inf_enter_fn (local.get $arm_row_h) (local.get $span))
    (call $env_scope_enter)
    (call $infer_bind_state_pairs (local.get $state_pairs)
      (call $reason_make_located (local.get $span)
        (call $reason_make_inferred (i32.const 3584)))   ;; "result"
      (local.get $span))
    (call $walk_expr_handle_arm_iter
      (local.get $arms) (local.get $bh) (local.get $span))
    (call $env_scope_exit)
    (call $walk_expr_inf_exit_fn)
    ;; handler-stack pop
    (call $walk_expr_inf_pop_handler)
    ;; Handle expression's TYPE = body's type
    (call $graph_bind (local.get $handle)
      (call $ty_make_tvar (local.get $bh))
      (call $reason_make_located (local.get $span)
        (call $reason_make_inferred (i32.const 3584))))   ;; "result"
    (local.get $handle))

  ;; PerformExpr arm — src/infer.mn:618-621 + 852-876. env_lookup the op;
  ;; on miss emit_missing_var; on hit instantiate scheme + walk args +
  ;; bind handle to scheme's return type.
  (func $infer_walk_expr_perform
        (export "infer_walk_expr_perform")
        (param $expr i32) (param $handle i32) (param $span i32)
        (result i32)
    (local $op_name i32) (local $args i32) (local $arg_handles i32)
    (local $binding i32) (local $scheme i32) (local $reason i32)
    (local $op_ty i32) (local $tag i32)
    ;; Layout: [tag=94][op_name][args]
    (local.set $op_name (i32.load offset=4 (local.get $expr)))
    (local.set $args    (i32.load offset=8 (local.get $expr)))
    (local.set $arg_handles (call $walk_expr_collect_arg_handles (local.get $args)))
    (drop (local.get $arg_handles))
    (local.set $binding (call $env_lookup (local.get $op_name)))
    (if (i32.eqz (local.get $binding))
      (then
        (call $infer_emit_missing_var
          (local.get $handle) (local.get $op_name)
          (call $reason_make_located (local.get $span)
            (call $reason_make_inferred (i32.const 3520))))   ;; "var ref"
        (return (local.get $handle))))
    (local.set $scheme (call $env_binding_scheme (local.get $binding)))
    (local.set $reason (call $env_binding_reason (local.get $binding)))
    (local.set $op_ty  (call $instantiate (local.get $scheme)))
    (local.set $tag (call $ty_tag (local.get $op_ty)))
    ;; If TFun (107), bind to its return type. Else bind to op_ty directly.
    (if (i32.eq (local.get $tag) (i32.const 107))
      (then
        (call $graph_bind (local.get $handle)
          (call $record_get (local.get $op_ty) (i32.const 1))   ;; ty_tfun_return
          (call $reason_make_located (local.get $span)
            (call $reason_make_varlookup (local.get $op_name) (local.get $reason))))
        ;; Row composition (seed-stub): row at offset 2 of TFun.
        (call $walk_expr_inf_add_row
          (call $record_get (local.get $op_ty) (i32.const 2))))
      (else
        (call $graph_bind (local.get $handle)
          (local.get $op_ty)
          (call $reason_make_located (local.get $span)
            (call $reason_make_varlookup (local.get $op_name) (local.get $reason))))))
    (local.get $handle))

  ;; ResumeExpr arm — typed-resume law (SUBSTRATE.md primitive #2,
  ;; mirror of wheel src/infer.mn ResumeExpr): inside `op(args) => body`
  ;; for `op : (P...) -> R` under handle-result S, `resume : R -> S`.
  ;; The value flows to the perform site (v unifies with R); the
  ;; expression's own value is the continuation's completion (S).
  ;; No arm context (resume outside an arm): bind TUnit — productive-
  ;; under-error; the wheel carries E_ResumeOutsideArm.
  (func $infer_walk_expr_resume
        (export "infer_walk_expr_resume")
        (param $expr i32) (param $handle i32) (param $span i32)
        (result i32)
    (local $val i32) (local $vh i32) (local $r_h i32)
    (local $ups i32) (local $nu i32) (local $ui i32) (local $upd i32)
    (local $uname i32) (local $uinit i32) (local $uvh i32)
    (local $sbind i32) (local $sscheme i32) (local $sreason i32) (local $fh i32)
    ;; Layout: [tag=95][val][state_updates] — state_updates NOW unified (below)
    (local.set $val (i32.load offset=4 (local.get $expr)))
    (local.set $vh (call $infer_walk_expr (local.get $val)))
    (if (i32.eqz (global.get $infer_arm_result_h_g))
      (then
        (call $graph_bind (local.get $handle)
          (call $ty_make_tunit)
          (call $reason_make_located (local.get $span)
            (call $reason_make_inferred (i32.const 3480))))   ;; "unit"
        (return (local.get $handle))))
    ;; v ↔ R
    (local.set $r_h (call $graph_fresh_ty
      (call $reason_make_located (local.get $span)
        (call $reason_make_inferred (i32.const 4336)))))   ;; "handler arm body"
    (call $graph_bind (local.get $r_h)
      (global.get $infer_arm_ret_ty_g)
      (call $reason_make_located (local.get $span)
        (call $reason_make_inferred (i32.const 4336))))
    (call $unify (local.get $vh) (local.get $r_h) (local.get $span)
      (call $reason_make_located (local.get $span)
        (call $reason_make_inferred (i32.const 4336))))
    ;; resume expr : S
    (call $graph_bind (local.get $handle)
      (call $ty_make_tvar (global.get $infer_arm_result_h_g))
      (call $reason_make_located (local.get $span)
        (call $reason_make_inferred (i32.const 4336))))
    ;; State updates (offset 8): each (name@0, init@1) 2-tuple EVOLVES the
    ;; handler state, so the update's type MUST unify with the state field's
    ;; type (bound in arm scope as Forall([], TVar(init_handle)) by
    ;; $infer_bind_state_pairs). The prior "second field unused" DROPPED them:
    ;; an empty-list-init field stayed List(?free), and a later state.field read
    ;; on the free element was the lower_scope ls_push_scope trap
    ;; (resolve_field_offset -> -1 -> unreachable). Mirror of the wheel
    ;; src/infer.mn ResumeExpr fix; carry the update's type into the field.
    (local.set $ups (i32.load offset=8 (local.get $expr)))
    (local.set $nu (call $len (local.get $ups)))
    (local.set $ui (i32.const 0))
    (block $ups_done
      (loop $ups_each
        (br_if $ups_done (i32.ge_u (local.get $ui) (local.get $nu)))
        (local.set $upd (call $list_index (local.get $ups) (local.get $ui)))
        (local.set $uname (call $list_index (local.get $upd) (i32.const 0)))
        (local.set $uinit (call $list_index (local.get $upd) (i32.const 1)))
        (local.set $uvh (call $infer_walk_expr (local.get $uinit)))
        (local.set $sbind (call $env_lookup_value (local.get $uname)))
        (if (i32.ne (local.get $sbind) (i32.const 0))
          (then
            (local.set $sscheme (call $env_binding_scheme (local.get $sbind)))
            (local.set $sreason (call $env_binding_reason (local.get $sbind)))
            (local.set $fh (call $graph_fresh_ty
              (call $reason_make_located (local.get $span)
                (call $reason_make_varlookup (local.get $uname) (local.get $sreason)))))
            (call $graph_bind (local.get $fh)
              (call $instantiate (local.get $sscheme))
              (call $reason_make_located (local.get $span)
                (call $reason_make_varlookup (local.get $uname) (local.get $sreason))))
            (call $unify (local.get $uvh) (local.get $fh) (local.get $span)
              (call $reason_make_located (local.get $span)
                (call $reason_make_inferred (i32.const 4336))))))
        (local.set $ui (i32.add (local.get $ui) (i32.const 1)))
        (br $ups_each)))
    (local.get $handle))

  ;; MakeListExpr arm — src/infer.mn:556-569. Empty: TList(TVar(fresh)).
  ;; Non-empty: unify all elements to first; bind to TList(TVar(first_h)).
  (func $infer_walk_expr_make_list
        (export "infer_walk_expr_make_list")
        (param $expr i32) (param $handle i32) (param $span i32)
        (result i32)
    (local $elems i32) (local $n i32) (local $i i32)
    (local $first i32) (local $fh i32)
    (local $elem i32) (local $eh i32) (local $elem_h i32)
    ;; Layout: [tag=96][elems]
    (local.set $elems (i32.load offset=4 (local.get $expr)))
    (local.set $n (call $len (local.get $elems)))
    (if (i32.eqz (local.get $n))
      (then
        (local.set $elem_h (call $graph_fresh_ty
          (call $reason_make_inferred (i32.const 3960))))   ;; "empty list"
        (call $graph_bind (local.get $handle)
          (call $ty_make_tlist (call $ty_make_tvar (local.get $elem_h)))
          (call $reason_make_located (local.get $span)
            (call $reason_make_inferred (i32.const 3960))))   ;; "empty list"
        (return (local.get $handle))))
    ;; Non-empty: walk first
    (local.set $first (call $list_index (local.get $elems) (i32.const 0)))
    (local.set $fh (call $infer_walk_expr (local.get $first)))
    ;; Walk + unify rest
    (local.set $i (i32.const 1))
    (block $done
      (loop $each
        (br_if $done (i32.ge_u (local.get $i) (local.get $n)))
        (local.set $elem (call $list_index (local.get $elems) (local.get $i)))
        (local.set $eh (call $infer_walk_expr (local.get $elem)))
        (call $unify (local.get $eh) (local.get $fh) (local.get $span)
          (call $reason_make_listelement
            (call $reason_make_inferred (i32.const 3936))))   ;; "list result"
        (local.set $i (i32.add (local.get $i) (i32.const 1)))
        (br $each)))
    (call $graph_bind (local.get $handle)
      (call $ty_make_tlist (call $ty_make_tvar (local.get $fh)))
      (call $reason_make_located (local.get $span)
        (call $reason_make_inferred (i32.const 3936))))   ;; "list result"
    (local.get $handle))

  ;; MakeStringExpr arm — src/infer.mn:668-679 + unify_string_fragments.
  ;; Every fragment (literal AND splice) binds to TString; the node
  ;; binds TString. Post-L1 peer Hβ.infer.show-typeclass relaxes splices
  ;; to Show obligations discharged via verify_ledger.
  (func $infer_walk_expr_make_string
        (export "infer_walk_expr_make_string")
        (param $expr i32) (param $handle i32) (param $span i32)
        (result i32)
    (local $frags i32) (local $n i32) (local $i i32)
    (local $frag i32) (local $fh i32)
    ;; Layout: [tag=103][fragments]
    (local.set $frags (i32.load offset=4 (local.get $expr)))
    (local.set $n (call $len (local.get $frags)))
    (local.set $i (i32.const 0))
    (block $done
      (loop $each
        (br_if $done (i32.ge_u (local.get $i) (local.get $n)))
        (local.set $frag (call $list_index (local.get $frags) (local.get $i)))
        (local.set $fh (call $infer_walk_expr (local.get $frag)))
        (call $graph_bind (local.get $fh)
          (call $ty_make_tstring)
          (call $reason_make_located (local.get $span)
            (call $reason_make_inferred (i32.const 3440))))   ;; "string literal"
        (local.set $i (i32.add (local.get $i) (i32.const 1)))
        (br $each)))
    (call $graph_bind (local.get $handle)
      (call $ty_make_tstring)
      (call $reason_make_located (local.get $span)
        (call $reason_make_inferred (i32.const 3440))))   ;; "string literal"
    (local.get $handle))

  ;; MakeTupleExpr arm — src/infer.mn:571-575.
  (func $infer_walk_expr_make_tuple
        (export "infer_walk_expr_make_tuple")
        (param $expr i32) (param $handle i32) (param $span i32)
        (result i32)
    (local $elems i32) (local $n i32) (local $i i32)
    (local $tvar_list i32) (local $elem i32) (local $eh i32)
    ;; Layout: [tag=97][elems]
    (local.set $elems (i32.load offset=4 (local.get $expr)))
    (local.set $n (call $len (local.get $elems)))
    (local.set $tvar_list (call $make_list (i32.const 0)))
    (local.set $tvar_list (call $list_extend_to (local.get $tvar_list) (local.get $n)))
    (local.set $i (i32.const 0))
    (block $done
      (loop $each
        (br_if $done (i32.ge_u (local.get $i) (local.get $n)))
        (local.set $elem (call $list_index (local.get $elems) (local.get $i)))
        (local.set $eh (call $infer_walk_expr (local.get $elem)))
        (drop (call $list_set (local.get $tvar_list) (local.get $i)
                              (call $ty_make_tvar (local.get $eh))))
        (local.set $i (i32.add (local.get $i) (i32.const 1)))
        (br $each)))
    (call $graph_bind (local.get $handle)
      (call $ty_make_ttuple (local.get $tvar_list))
      (call $reason_make_located (local.get $span)
        (call $reason_make_inferred (i32.const 3912))))   ;; "tuple result"
    (local.get $handle))

  ;; MakeRecordExpr arm — src/infer.mn:577-587. Builds a list of
  ;; (name, TVar(value_h)) field-pair records and binds to TRecord.
  ;; Parser pre-sorts fields per src/parser.mn.
  (func $infer_walk_expr_make_record
        (export "infer_walk_expr_make_record")
        (param $expr i32) (param $handle i32) (param $span i32)
        (result i32)
    (local $fields i32) (local $n i32) (local $i i32)
    (local $field_pair_list i32) (local $entry i32)
    (local $name i32) (local $val_node i32) (local $vh i32)
    (local $fp i32)
    ;; Layout: [tag=98][fields]; each fields entry is a (name, val_node)
    ;; pair record in tparam.wat's field-pair shape (FIELD_PAIR=203) —
    ;; parser emits ([name_str, value_node]) per src/parser.mn.
    (local.set $fields (i32.load offset=4 (local.get $expr)))
    (local.set $n (call $len (local.get $fields)))
    (local.set $field_pair_list (call $make_list (i32.const 0)))
    (local.set $field_pair_list
      (call $list_extend_to (local.get $field_pair_list) (local.get $n)))
    (local.set $i (i32.const 0))
    (block $done
      (loop $each
        (br_if $done (i32.ge_u (local.get $i) (local.get $n)))
        (local.set $entry (call $list_index (local.get $fields) (local.get $i)))
        (local.set $name     (call $record_get (local.get $entry) (i32.const 0)))
        (local.set $val_node (call $record_get (local.get $entry) (i32.const 1)))
        (local.set $vh (call $infer_walk_expr (local.get $val_node)))
        (local.set $fp (call $field_pair_make
          (local.get $name)
          (call $ty_make_tvar (local.get $vh))))
        (drop (call $list_set (local.get $field_pair_list)
                              (local.get $i) (local.get $fp)))
        (local.set $i (i32.add (local.get $i) (i32.const 1)))
        (br $each)))
    (call $graph_bind (local.get $handle)
      (call $ty_make_trecord (local.get $field_pair_list))
      (call $reason_make_located (local.get $span)
        (call $reason_make_inferred (i32.const 3888))))   ;; "record result"
    (local.get $handle))

  ;; NamedRecordExpr arm — src/infer.mn:589-616. env_lookup the type name;
  ;; on miss emit_missing_var; on hit non-RecordSchemeKind emit_not_a_
  ;; record_type; on hit record-shape, walk fields + bind handle to
  ;; TName(type_name, []). Field validation against declared (extra/
  ;; missing) is named follow-up Hβ.infer.named-record-validate.
  (func $infer_walk_expr_named_record
        (export "infer_walk_expr_named_record")
        (param $expr i32) (param $handle i32) (param $span i32)
        (result i32)
    (local $type_name i32) (local $fields i32)
    (local $n i32) (local $i i32) (local $entry i32) (local $val_node i32)
    (local $binding i32)
    ;; Layout: [tag=99][type_name][fields]
    (local.set $type_name (i32.load offset=4 (local.get $expr)))
    (local.set $fields    (i32.load offset=8 (local.get $expr)))
    (local.set $binding (call $env_lookup_value (local.get $type_name)))
    (if (i32.eqz (local.get $binding))
      (then
        (call $infer_emit_missing_var
          (local.get $handle) (local.get $type_name)
          (call $reason_make_located (local.get $span)
            (call $reason_make_inferred (i32.const 3888))))   ;; "record result"
        (return (local.get $handle))))
    ;; Walk every field value (regardless of kind validation).
    (local.set $n (call $len (local.get $fields)))
    (local.set $i (i32.const 0))
    (block $done
      (loop $each
        (br_if $done (i32.ge_u (local.get $i) (local.get $n)))
        (local.set $entry (call $list_index (local.get $fields) (local.get $i)))
        (local.set $val_node (call $record_get (local.get $entry) (i32.const 1)))
        (drop (call $infer_walk_expr (local.get $val_node)))
        (local.set $i (i32.add (local.get $i) (i32.const 1)))
        (br $each)))
    ;; Per Hβ.infer.named-record-validate: seed binds without exhaustive
    ;; check. Field-extra / field-missing diagnostics land in the named
    ;; follow-up via emit_diag.wat's already-landed helpers.
    (call $graph_bind (local.get $handle)
      (call $ty_make_tname (local.get $type_name) (call $make_list (i32.const 0)))
      (call $reason_make_located (local.get $span)
        (call $reason_make_inferred (i32.const 3888))))   ;; "record result"
    (local.get $handle))

  ;; FieldExpr arm — src/infer.mn:703-722 + 771-781. Treats every
  ;; FieldExpr as record-field access. Dotted-name fallback (src/infer.mn
  ;; :710-722) is named follow-up Hβ.infer.qualified-name.
  (func $infer_walk_expr_field
        (export "infer_walk_expr_field")
        (param $expr i32) (param $handle i32) (param $span i32)
        (result i32)
    (local $rec i32) (local $field i32) (local $rh i32)
    (local $field_h i32) (local $row_h i32)
    (local $expected i32) (local $expected_h i32)
    (local $field_pair_list i32) (local $fp i32)
    ;; Layout: [tag=100][rec][field]
    (local.set $rec   (i32.load offset=4 (local.get $expr)))
    (local.set $field (i32.load offset=8 (local.get $expr)))
    (local.set $rh (call $infer_walk_expr (local.get $rec)))
    (local.set $field_h (call $graph_fresh_ty
      (call $reason_make_inferred (i32.const 3888))))   ;; "record result"
    (local.set $row_h (call $graph_fresh_row
      (call $reason_make_inferred (i32.const 3696))))   ;; "effects"
    ;; Build TRecordOpen([(field, TVar(field_h))], row_h)
    (local.set $fp (call $field_pair_make
      (local.get $field) (call $ty_make_tvar (local.get $field_h))))
    (local.set $field_pair_list (call $make_list (i32.const 0)))
    (local.set $field_pair_list
      (call $list_extend_to (local.get $field_pair_list) (i32.const 1)))
    (drop (call $list_set (local.get $field_pair_list)
                          (i32.const 0) (local.get $fp)))
    (local.set $expected
      (call $ty_make_trecordopen (local.get $field_pair_list) (local.get $row_h)))
    (local.set $expected_h (call $graph_fresh_ty
      (call $reason_make_inferred (i32.const 3720))))   ;; "expected"
    (call $graph_bind (local.get $expected_h) (local.get $expected)
      (call $reason_make_located (local.get $span)
        (call $reason_make_inferred (i32.const 3720))))
    (call $unify (local.get $rh) (local.get $expected_h) (local.get $span)
      (call $reason_make_inferred (i32.const 3744)))   ;; "unification"
    (call $graph_bind (local.get $handle)
      (call $ty_make_tvar (local.get $field_h))
      (call $reason_make_located (local.get $span)
        (call $reason_make_inferred (i32.const 3888))))   ;; "record result"
    (local.get $handle))

  ;; ─── IndexExpr arm — xs[i] kernel sequence-index projection ───────────
  ;; Mirror of the wheel src/infer.mn:646-662. Layout: [tag=104][recv][index].
  ;; FORCE the receiver to a list (unify with TList(TVar(elem_h)) — preserves a
  ;; concrete receiver's element) and bind the result to that ELEMENT. The
  ;; Carried-Truth Law: the graph proves the sequence's element type via
  ;; TList(a); the projection reads it, never re-deriving Int from list_index's
  ;; load_i32 body. Lower emits the list_index call (the substrate).
  (func $infer_walk_expr_index
        (export "infer_walk_expr_index")
        (param $expr i32) (param $handle i32) (param $span i32)
        (result i32)
    (local $rec i32) (local $idx i32) (local $rh i32)
    (local $elem_h i32) (local $list_ty_h i32)
    (local.set $rec (i32.load offset=4 (local.get $expr)))
    (local.set $idx (i32.load offset=8 (local.get $expr)))
    (local.set $rh (call $infer_walk_expr (local.get $rec)))
    (drop (call $infer_walk_expr (local.get $idx)))
    (local.set $elem_h (call $graph_fresh_ty
      (call $reason_make_inferred (i32.const 3888))))   ;; "record result" — element
    (local.set $list_ty_h (call $graph_fresh_ty
      (call $reason_make_inferred (i32.const 3888))))
    (call $graph_bind (local.get $list_ty_h)
      (call $ty_make_tlist (call $ty_make_tvar (local.get $elem_h)))
      (call $reason_make_located (local.get $span)
        (call $reason_make_inferred (i32.const 3888))))
    (call $unify (local.get $rh) (local.get $list_ty_h) (local.get $span)
      (call $reason_make_inferred (i32.const 3888)))
    (call $graph_bind (local.get $handle)
      (call $ty_make_tvar (local.get $elem_h))
      (call $reason_make_located (local.get $span)
        (call $reason_make_inferred (i32.const 3888))))
    (local.get $handle))

  ;; ─── PipeExpr — five-verb dispatch ────────────────────────────────────
  ;; src/infer.mn:742-755 + 898-974. Dispatches on PipeKind tag (160-164).
  ;; Per spec 10 + Hβ-infer §4.3 production pattern 4.

  (func $infer_walk_expr_pipe
        (export "infer_walk_expr_pipe")
        (param $expr i32) (param $handle i32) (param $span i32)
        (result i32)
    (local $kind i32) (local $left i32) (local $right i32)
    ;; Layout: [tag=101][kind][left][right]
    (local.set $kind  (i32.load offset=4  (local.get $expr)))
    (local.set $left  (i32.load offset=8  (local.get $expr)))
    (local.set $right (i32.load offset=12 (local.get $expr)))
    ;; PForward (160)
    (if (i32.eq (local.get $kind) (i32.const 160))
      (then (return (call $infer_walk_expr_pipe_forward
                          (local.get $left) (local.get $right)
                          (local.get $handle) (local.get $span)))))
    ;; PDiverge (161)
    (if (i32.eq (local.get $kind) (i32.const 161))
      (then (return (call $infer_walk_expr_pipe_diverge
                          (local.get $left) (local.get $right)
                          (local.get $handle) (local.get $span)))))
    ;; PCompose (162)
    (if (i32.eq (local.get $kind) (i32.const 162))
      (then (return (call $infer_walk_expr_pipe_compose
                          (local.get $left) (local.get $right)
                          (local.get $handle) (local.get $span)))))
    ;; PTee (163) — one precedence, one kind per src/infer.mn PTee arm
    (if (i32.eq (local.get $kind) (i32.const 163))
      (then (return (call $infer_walk_expr_pipe_tee
                          (local.get $left) (local.get $right)
                          (local.get $handle) (local.get $span)))))
    ;; PFeedback (164)
    (if (i32.eq (local.get $kind) (i32.const 164))
      (then (return (call $infer_walk_expr_pipe_feedback
                          (local.get $left) (local.get $right)
                          (local.get $handle) (local.get $span)))))
    ;; Unknown PipeKind — H6 wildcard discipline: trap.
    (unreachable))

  ;; PForward (|>) — src/infer.mn:907-925.
  (func $infer_walk_expr_pipe_forward
        (export "infer_walk_expr_pipe_forward")
        (param $left i32) (param $right i32)
        (param $handle i32) (param $span i32)
        (result i32)
    (local $lh i32) (local $rh i32)
    (local $ret_h i32) (local $row_h i32)
    (local $param i32) (local $param_list i32)
    (local $expected i32) (local $expected_h i32)
    (local $pipe_str i32) (local $row_nk i32)
    (local.set $lh (call $infer_walk_expr (local.get $left)))
    (local.set $rh (call $infer_walk_expr (local.get $right)))
    (local.set $pipe_str (call $int_to_str (i32.const 160)))
    (local.set $ret_h (call $graph_fresh_ty
      (call $reason_make_inferredpiperesult (local.get $pipe_str)
        (call $reason_make_inferred (i32.const 3672)))))   ;; "return"
    (local.set $row_h (call $graph_fresh_row
      (call $reason_make_inferredpiperesult (local.get $pipe_str)
        (call $reason_make_inferred (i32.const 3696)))))   ;; "effects"
    ;; Build [TParam("_", TVar(lh), Inferred, Inferred)]
    (local.set $param (call $tparam_make
      (call $str_alloc (i32.const 0))
      (call $ty_make_tvar (local.get $lh))
      (call $ownership_make_inferred)
      (call $ownership_make_inferred)))
    (local.set $param_list (call $make_list (i32.const 0)))
    (local.set $param_list (call $list_extend_to (local.get $param_list) (i32.const 1)))
    (drop (call $list_set (local.get $param_list) (i32.const 0) (local.get $param)))
    (local.set $expected (call $ty_make_tfun
      (local.get $param_list)
      (call $ty_make_tvar (local.get $ret_h))
      (call $row_make_open (call $make_list (i32.const 0)) (local.get $row_h))))
    (local.set $expected_h (call $graph_fresh_ty
      (call $reason_make_inferredpiperesult (local.get $pipe_str)
        (call $reason_make_inferred (i32.const 3720)))))   ;; "expected"
    (call $graph_bind (local.get $expected_h) (local.get $expected)
      (call $reason_make_located (local.get $span)
        (call $reason_make_inferredpiperesult (local.get $pipe_str)
          (call $reason_make_inferred (i32.const 3720)))))
    (call $unify (local.get $rh) (local.get $expected_h) (local.get $span)
      (call $reason_make_inferredpiperesult (local.get $pipe_str)
        (call $reason_make_inferred (i32.const 3744))))   ;; "unification"
    (call $graph_bind (local.get $handle)
      (call $ty_make_tvar (local.get $ret_h))
      (call $reason_make_located (local.get $span)
        (call $reason_make_inferredpiperesult (local.get $pipe_str)
          (call $reason_make_inferred (i32.const 3584)))))  ;; "result"
    ;; Row composition: src/infer.mn pipe arm — chase row_h; NRowBound(row)
    ;; flows the stage's row into the caller's frame NOW; the edge feeds
    ;; $infer_row_fixpoint for late-bound stages.
    (call $infer_row_edge_append (local.get $row_h))
    (local.set $row_nk (call $gnode_kind (call $graph_chase (local.get $row_h))))
    (if (i32.eq (call $node_kind_tag (local.get $row_nk)) (i32.const 62))   ;; NRowBound
      (then (call $walk_expr_inf_add_row
        (call $node_kind_payload (local.get $row_nk)))))
    (local.get $handle))

  ;; PCompose (><) — src/infer.mn:985-995. branch_enter; walk left;
  ;; branch_divider; walk right; branch_exit. Bind handle to
  ;; TTuple([TVar(lh), TVar(rh)]).
  (func $infer_walk_expr_pipe_compose
        (export "infer_walk_expr_pipe_compose")
        (param $left i32) (param $right i32)
        (param $handle i32) (param $span i32)
        (result i32)
    (local $lh i32) (local $rh i32)
    (local $tuple_elems i32)
    (call $infer_branch_enter)
    (local.set $lh (call $infer_walk_expr (local.get $left)))
    (call $infer_branch_divider)
    (local.set $rh (call $infer_walk_expr (local.get $right)))
    (call $infer_branch_exit (local.get $span)
      (call $reason_make_inferred (i32.const 3912)))   ;; "tuple result"
    ;; TTuple([TVar(lh), TVar(rh)])
    (local.set $tuple_elems (call $make_list (i32.const 0)))
    (local.set $tuple_elems (call $list_extend_to (local.get $tuple_elems) (i32.const 2)))
    (drop (call $list_set (local.get $tuple_elems) (i32.const 0)
                          (call $ty_make_tvar (local.get $lh))))
    (drop (call $list_set (local.get $tuple_elems) (i32.const 1)
                          (call $ty_make_tvar (local.get $rh))))
    (call $graph_bind (local.get $handle)
      (call $ty_make_ttuple (local.get $tuple_elems))
      (call $reason_make_located (local.get $span)
        (call $reason_make_inferred (i32.const 3912))))   ;; "tuple result"
    (local.get $handle))

  ;; PDiverge (<|) — src/infer.mn:997-1022. Walk left; if right is
  ;; MakeTupleExpr, branch_enter + walk each branch + branch_divider +
  ;; branch_exit + bind right to TTuple of branch_h. Bind handle to
  ;; TVar(rh).
  (func $infer_walk_expr_pipe_diverge
        (export "infer_walk_expr_pipe_diverge")
        (param $left i32) (param $right i32)
        (param $handle i32) (param $span i32)
        (result i32)
    (local $lh i32) (local $rh i32)
    (local $rbody i32) (local $rexpr i32) (local $rtag i32)
    (local $branches i32) (local $n i32) (local $i i32)
    (local $branch i32) (local $branch_h i32)
    (local $tuple_elems i32)
    (drop (call $infer_walk_expr (local.get $left)))
    (local.set $lh (call $walk_expr_node_handle (local.get $left)))
    (drop (local.get $lh))
    ;; Check if right's body is NExpr containing MakeTupleExpr (97).
    (local.set $rbody (call $walk_expr_node_body (local.get $right)))
    (if (i32.eq (i32.load (local.get $rbody)) (i32.const 110))
      (then
        (local.set $rexpr (i32.load offset=4 (local.get $rbody)))
        (local.set $rtag (call $walk_expr_expr_tag (local.get $rexpr)))
        (if (i32.eq (local.get $rtag) (i32.const 97))
          (then
            (local.set $branches (i32.load offset=4 (local.get $rexpr)))
            (local.set $n (call $len (local.get $branches)))
            (if (i32.eqz (local.get $n))
              (then
                ;; Degenerate: <| () — empty branch tuple. Walk right normally.
                (drop (call $infer_walk_expr (local.get $right))))
              (else
                (call $infer_branch_enter)
                (local.set $i (i32.const 0))
                (local.set $tuple_elems (call $make_list (i32.const 0)))
                (local.set $tuple_elems
                  (call $list_extend_to (local.get $tuple_elems) (local.get $n)))
                (block $done
                  (loop $each
                    (br_if $done (i32.ge_u (local.get $i) (local.get $n)))
                    (local.set $branch (call $list_index (local.get $branches) (local.get $i)))
                    (local.set $branch_h (call $infer_walk_expr (local.get $branch)))
                    (drop (call $list_set (local.get $tuple_elems)
                                          (local.get $i)
                                          (call $ty_make_tvar (local.get $branch_h))))
                    ;; branch_divider between branches (not after last).
                    (if (i32.lt_u
                          (i32.add (local.get $i) (i32.const 1))
                          (local.get $n))
                      (then (call $infer_branch_divider)))
                    (local.set $i (i32.add (local.get $i) (i32.const 1)))
                    (br $each)))
                (call $infer_branch_exit (local.get $span)
                  (call $reason_make_inferred (i32.const 3912)))   ;; "tuple result"
                ;; Bind right's handle to TTuple(...).
                (call $graph_bind
                  (call $walk_expr_node_handle (local.get $right))
                  (call $ty_make_ttuple (local.get $tuple_elems))
                  (call $reason_make_located (local.get $span)
                    (call $reason_make_inferred (i32.const 3912)))))))
          (else
            ;; Single-branch form: walk right normally.
            (drop (call $infer_walk_expr (local.get $right))))))
      (else
        (drop (call $infer_walk_expr (local.get $right)))))
    (local.set $rh (call $walk_expr_node_handle (local.get $right)))
    (call $graph_bind (local.get $handle)
      (call $ty_make_tvar (local.get $rh))
      (call $reason_make_located (local.get $span)
        (call $reason_make_inferred (i32.const 3912))))   ;; "tuple result"
    (local.get $handle))

  ;; $read_bound_row — the row bound at a row handle (graph_chase → NRowBound
  ;; payload), else Pure. Mirrors src/infer.mn read_bound_row.
  (func $read_bound_row (param $handle i32) (result i32)
    (local $nk i32)
    (local.set $nk (call $gnode_kind (call $graph_chase (local.get $handle))))
    (if (i32.eq (call $node_kind_tag (local.get $nk)) (i32.const 62))   ;; NRowBound
      (then (return (call $node_kind_payload (local.get $nk)))))
    (call $row_make_pure))

  ;; ─── Install-time payload flow (parametric effects) ──────────────────
  ;; At `expr ~> h`, the body performs E(a) (in its row) and the handler value
  ;; is Handler<E(P)>; unify a = P so the handler's arm param (elem : P) becomes
  ;; the performed value type. This is what makes `field` in
  ;; `map((field)=>field.name, xs)` resolve to xs's element. The dispatch
  ;; gradient applied to DATA. Mirrors src/infer.mn unify_install_payload /
  ;; handler_payload_ty / row_effect_payload / names_effect_payload.

  ;; $handler_payload_ty(ty) — P from a Handler<E(P)> handler value type, or 0.
  (func $handler_payload_ty (param $ty i32) (result i32)
    (local $args i32) (local $inner i32) (local $inner_args i32)
    (if (i32.ne (call $ty_tag (local.get $ty)) (i32.const 108))   ;; not TName
      (then (return (i32.const 0))))
    (if (i32.eqz (call $str_eq (call $ty_tname_name (local.get $ty))
                               (call $handler_decl_handler_name_ptr)))
      (then (return (i32.const 0))))
    (local.set $args (call $ty_tname_args (local.get $ty)))
    (if (i32.ne (call $len (local.get $args)) (i32.const 1))
      (then (return (i32.const 0))))
    (local.set $inner (call $list_index (local.get $args) (i32.const 0)))
    (if (i32.ne (call $ty_tag (local.get $inner)) (i32.const 108))   ;; inner TName(E, [P])
      (then (return (i32.const 0))))
    (local.set $inner_args (call $ty_tname_args (local.get $inner)))
    (if (i32.ne (call $len (local.get $inner_args)) (i32.const 1))
      (then (return (i32.const 0))))
    (call $list_index (local.get $inner_args) (i32.const 0)))

  ;; $names_effect_payload(names, ename) — the payload Ty of the row's E(a)
  ;; entry (the performed payload), or 0 if E is absent or bare.
  (func $names_effect_payload (param $names i32) (param $ename i32) (result i32)
    (local $n i32) (local $i i32) (local $elem i32)
    (local.set $n (call $len (local.get $names)))
    (local.set $i (i32.const 0))
    (block $done
      (loop $iter
        (br_if $done (i32.ge_u (local.get $i) (local.get $n)))
        (local.set $elem (call $list_index (local.get $names) (local.get $i)))
        (if (call $eff_pname_is (local.get $elem))
          (then
            (if (call $str_eq (call $record_get (local.get $elem) (i32.const 0))
                              (local.get $ename))
              (then (return (call $eff_pname_payload (local.get $elem)))))))
        (local.set $i (i32.add (local.get $i) (i32.const 1)))
        (br $iter)))
    (i32.const 0))

  ;; $row_effect_payload(row, ename) — the performed payload `a` from a row's
  ;; E(a) entry, or 0 (Closed/Open scanned; Pure/others none).
  (func $row_effect_payload (param $row i32) (param $ename i32) (result i32)
    (local $tag i32)
    (local.set $tag (call $row_tag (local.get $row)))
    (if (i32.or (i32.eq (local.get $tag) (i32.const 151))
                (i32.eq (local.get $tag) (i32.const 152)))
      (then (return (call $names_effect_payload
        (call $row_names (local.get $row)) (local.get $ename)))))
    (i32.const 0))

  ;; $unify_install_payload — flow the op payload performer→handler at the
  ;; install: body performs E(a), handler value is Handler<E(P)>; unify a = P.
  ;; A no-op (None-tolerant) when either side lacks the payload — a handler
  ;; whose body never performs the parameterized effect must NOT be forced.
  (func $unify_install_payload (param $body_row i32) (param $handled i32)
                               (param $rh i32) (param $span i32)
    (local $pty i32) (local $aty i32) (local $h1 i32) (local $h2 i32)
    (local.set $pty (call $handler_payload_ty (call $lookup_ty (local.get $rh))))
    (if (i32.eqz (local.get $pty)) (then (return)))
    (local.set $aty (call $row_effect_payload (local.get $body_row) (local.get $handled)))
    (if (i32.eqz (local.get $aty)) (then (return)))
    (local.set $h1 (call $graph_fresh_ty
      (call $reason_make_inferred (i32.const 4080))))   ;; "effects"
    (call $graph_bind (local.get $h1) (local.get $pty)
      (call $reason_make_inferred (i32.const 4080)))
    (local.set $h2 (call $graph_fresh_ty
      (call $reason_make_inferred (i32.const 4080))))
    (call $graph_bind (local.get $h2) (local.get $aty)
      (call $reason_make_inferred (i32.const 4080)))
    (call $unify (local.get $h1) (local.get $h2) (local.get $span)
      (call $reason_make_inferred (i32.const 4080))))

  ;; PTee (~>) — handler-effect typing: row(expr ~> h) = (row(expr) − E) ⊕ R.
  ;; Body in a NESTED row scope (so its effects don't leak — subtraction needs
  ;; it); install the handler value (binds config args → R picks up their
  ;; effect); add (body_row − E) ⊕ R read from the RHS handler's HandlerKind.
  ;; Mirrors src/infer.mn infer_pipe_tee. Result type = TVar(lh).
  (func $infer_walk_expr_pipe_tee
        (export "infer_walk_expr_pipe_tee")
        (param $left i32) (param $right i32)
        (param $handle i32) (param $span i32)
        (result i32)
    (local $lh i32) (local $cname i32) (local $body_row_h i32) (local $body_row i32)
    (local $binding i32) (local $kind i32) (local $ename i32) (local $resid i32)
    (local $names i32) (local $result_row i32)
    (local.set $body_row_h (call $graph_fresh_row
      (call $reason_make_inferred (i32.const 3584))))   ;; "result"
    (call $walk_expr_inf_enter_fn (local.get $body_row_h) (local.get $span))
    (local.set $lh (call $infer_walk_expr (local.get $left)))
    (call $walk_expr_inf_exit_fn)
    (local.set $cname (call $walk_expr_callee_name (local.get $right)))
    (call $walk_expr_inf_push_handler (local.get $cname))
    (drop (call $infer_walk_expr (local.get $right)))
    (local.set $body_row (call $read_bound_row (local.get $body_row_h)))
    (local.set $result_row (local.get $body_row))   ;; default: pass-through
    (local.set $binding (call $env_lookup_value (local.get $cname)))
    (if (i32.ne (local.get $binding) (i32.const 0))
      (then
        (local.set $kind (call $env_binding_kind (local.get $binding)))
        (if (i32.eq (call $schemekind_tag (local.get $kind)) (i32.const 137))   ;; HandlerKind
          (then
            (local.set $ename (call $schemekind_handler_ename (local.get $kind)))
            (local.set $resid (call $read_bound_row
              (call $schemekind_handler_residual (local.get $kind))))
            ;; THE INSTALL CONNECTION: flow the op payload performer→handler.
            ;; body performs E(a); handler value is Handler<E(P)>; unify a = P.
            (call $unify_install_payload
              (local.get $body_row) (local.get $ename)
              (call $walk_expr_node_handle (local.get $right)) (local.get $span))
            (local.set $names (call $make_list (i32.const 1)))
            (drop (call $list_set (local.get $names) (i32.const 0) (local.get $ename)))
            ;; Flow-edge: row_union keeps the FIRST open arg's rowvar. The residual
            ;; carries the handler's polymorphic escaping tail (its config effects);
            ;; (body − handled)'s rowvar carries the now-HANDLED body effects. Put
            ;; resid FIRST so the poly tail survives and the handled-effect rowvar
            ;; is dropped — else the fn's row reads live as the handled effect and
            ;; loses its argument's effect (the higher-order-effect trap).
            (local.set $result_row
              (call $row_union
                (local.get $resid)
                (call $row_diff (local.get $body_row) (call $row_make_closed (local.get $names)))))))))
    (call $walk_expr_inf_add_row (local.get $result_row))
    (call $graph_bind (local.get $handle)
      (call $ty_make_tvar (local.get $lh))
      (call $reason_make_located (local.get $span)
        (call $reason_make_inferredpiperesult
          (call $int_to_str (i32.const 163))
          (call $reason_make_inferred (i32.const 3584)))))   ;; "result"
    (call $walk_expr_inf_pop_handler)
    (local.get $handle))

  ;; PFeedback (<~) — src/infer.mn:959-973. Pessimistic seed: emit
  ;; feedback-no-context unconditionally + bind handle ↔ TVar(lh) per
  ;; Hazel productive-under-error. Hβ.infer.iterative-context lands the
  ;; handler-stack-walk that detects Clock/Tick/Sample.
  (func $infer_walk_expr_pipe_feedback
        (export "infer_walk_expr_pipe_feedback")
        (param $left i32) (param $right i32)
        (param $handle i32) (param $span i32)
        (result i32)
    (local $lh i32) (local $rh i32)
    (local.set $lh (call $infer_walk_expr (local.get $left)))
    (local.set $rh (call $infer_walk_expr (local.get $right)))
    (drop (local.get $rh))
    ;; Productive-under-error: emit + bind NErrorHole via emit_diag helper.
    (call $infer_emit_feedback_no_context
      (local.get $handle)
      (call $reason_make_located (local.get $span)
        (call $reason_make_inferredpiperesult
          (call $int_to_str (i32.const 164))
          (call $reason_make_inferred (i32.const 3520)))))   ;; "var ref"
    ;; emit_diag binds NErrorHole; we don't bind again (one-bind invariant).
    (drop (local.get $lh))
    (local.get $handle))

  ;; ─── Entry-point dispatch ────────────────────────────────────────────
  ;;
  ;; $infer_walk_expr(node) -> handle. Per src/infer.mn:490-765. Reads N's
  ;; body to get the NExpr tag (110), reads NExpr's inner Expr tag (80-101),
  ;; dispatches to the per-variant arm.

  (func $infer_walk_expr (export "infer_walk_expr")
        (param $node i32) (result i32)
    (local $body i32) (local $expr i32) (local $tag i32)
    (local $handle i32) (local $span i32)
    (call $infer_init)
    (call $env_init)
    (call $graph_init)
    (local.set $body   (call $walk_expr_node_body   (local.get $node)))
    (local.set $span   (call $walk_expr_node_span   (local.get $node)))
    (local.set $handle (call $walk_expr_node_handle (local.get $node)))
    ;; Span-index append for query-layer consumers post-walk.
    (call $infer_span_index_append (local.get $span) (local.get $handle))
    ;; Body MUST be NExpr (tag 110). Non-NExpr at expression position is
    ;; parser-bug surface; trap to surface (consistent with H6 wildcard
    ;; discipline + Anchor 0 dream-code stance).
    (if (i32.ne (i32.load (local.get $body)) (i32.const 110))
      (then (unreachable)))
    (local.set $expr (i32.load offset=4 (local.get $body)))
    (local.set $tag (call $walk_expr_expr_tag (local.get $expr)))
    ;; Dispatch on Expr tag (80-101) per parser_infra.wat:14-19.
    (if (i32.eq (local.get $tag) (i32.const 80))
      (then (return (call $infer_walk_expr_lit_int
              (local.get $expr) (local.get $handle) (local.get $span)))))
    (if (i32.eq (local.get $tag) (i32.const 81))
      (then (return (call $infer_walk_expr_lit_float
              (local.get $expr) (local.get $handle) (local.get $span)))))
    (if (i32.eq (local.get $tag) (i32.const 82))
      (then (return (call $infer_walk_expr_lit_string
              (local.get $expr) (local.get $handle) (local.get $span)))))
    (if (i32.eq (local.get $tag) (i32.const 83))
      (then (return (call $infer_walk_expr_lit_bool
              (local.get $expr) (local.get $handle) (local.get $span)))))
    (if (i32.eq (local.get $tag) (i32.const 84))
      (then (return (call $infer_walk_expr_lit_unit
              (local.get $expr) (local.get $handle) (local.get $span)))))
    (if (i32.eq (local.get $tag) (i32.const 85))
      (then (return (call $infer_walk_expr_var_ref
              (local.get $expr) (local.get $handle) (local.get $span)))))
    (if (i32.eq (local.get $tag) (i32.const 86))
      (then (return (call $infer_walk_expr_binop
              (local.get $expr) (local.get $handle) (local.get $span)))))
    (if (i32.eq (local.get $tag) (i32.const 87))
      (then (return (call $infer_walk_expr_unaryop
              (local.get $expr) (local.get $handle) (local.get $span)))))
    (if (i32.eq (local.get $tag) (i32.const 88))
      (then (return (call $infer_walk_expr_call
              (local.get $expr) (local.get $handle) (local.get $span)))))
    (if (i32.eq (local.get $tag) (i32.const 89))
      (then (return (call $infer_walk_expr_lambda
              (local.get $expr) (local.get $handle) (local.get $span)))))
    (if (i32.eq (local.get $tag) (i32.const 90))
      (then (return (call $infer_walk_expr_if
              (local.get $expr) (local.get $handle) (local.get $span)))))
    (if (i32.eq (local.get $tag) (i32.const 91))
      (then (return (call $infer_walk_expr_block
              (local.get $expr) (local.get $handle) (local.get $span)))))
    (if (i32.eq (local.get $tag) (i32.const 92))
      (then (return (call $infer_walk_expr_match
              (local.get $expr) (local.get $handle) (local.get $span)))))
    (if (i32.eq (local.get $tag) (i32.const 93))
      (then (return (call $infer_walk_expr_handle
              (local.get $expr) (local.get $handle) (local.get $span)))))
    (if (i32.eq (local.get $tag) (i32.const 94))
      (then (return (call $infer_walk_expr_perform
              (local.get $expr) (local.get $handle) (local.get $span)))))
    (if (i32.eq (local.get $tag) (i32.const 95))
      (then (return (call $infer_walk_expr_resume
              (local.get $expr) (local.get $handle) (local.get $span)))))
    (if (i32.eq (local.get $tag) (i32.const 96))
      (then (return (call $infer_walk_expr_make_list
              (local.get $expr) (local.get $handle) (local.get $span)))))
    (if (i32.eq (local.get $tag) (i32.const 97))
      (then (return (call $infer_walk_expr_make_tuple
              (local.get $expr) (local.get $handle) (local.get $span)))))
    (if (i32.eq (local.get $tag) (i32.const 98))
      (then (return (call $infer_walk_expr_make_record
              (local.get $expr) (local.get $handle) (local.get $span)))))
    (if (i32.eq (local.get $tag) (i32.const 99))
      (then (return (call $infer_walk_expr_named_record
              (local.get $expr) (local.get $handle) (local.get $span)))))
    (if (i32.eq (local.get $tag) (i32.const 100))
      (then (return (call $infer_walk_expr_field
              (local.get $expr) (local.get $handle) (local.get $span)))))
    (if (i32.eq (local.get $tag) (i32.const 101))
      (then (return (call $infer_walk_expr_pipe
              (local.get $expr) (local.get $handle) (local.get $span)))))
    ;; MakeStringExpr (103) — string interpolation per #138.
    (if (i32.eq (local.get $tag) (i32.const 103))
      (then (return (call $infer_walk_expr_make_string
              (local.get $expr) (local.get $handle) (local.get $span)))))
    ;; IndexExpr (104) — xs[i] kernel sequence-index projection.
    (if (i32.eq (local.get $tag) (i32.const 104))
      (then (return (call $infer_walk_expr_index
              (local.get $expr) (local.get $handle) (local.get $span)))))
    ;; NErrorExpr (102): productive-under-error sentinel from parser.
    ;; Per protocol_parser_fabrication_substrate.md + DESIGN.md §4
    ;; (NErrorHole peer at graph layer): bind the handle to NErrorHole
    ;; so $lookup_ty / $chase_deep see the sentinel; the walk continues;
    ;; well-typed sibling code still infers cleanly. The parser already
    ;; surfaced the diagnostic at the missing-ident span.
    (if (i32.eq (local.get $tag) (i32.const 102))
      (then
        (call $graph_bind_kind
          (local.get $handle)
          (call $node_kind_make_nerrorhole
            (call $reason_make_inferred (i32.const 6400)))   ;; "parser missing ident at <tok>"
          (call $reason_make_located (local.get $span)
            (call $reason_make_inferred (i32.const 6400))))
        (return (local.get $handle))))
    ;; Unknown tag — H6 wildcard discipline: trap so future Expr variants
    ;; force this dispatch table to be extended (drift mode 9 prevention).
    (unreachable))
