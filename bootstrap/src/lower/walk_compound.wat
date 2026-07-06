

  ;; ═══ walk_compound.wat — Hβ.lower compound-Expr arms (Tier 7) ═══════
  ;; Hβ.lower cascade chunk #9 of 11 per Hβ-lower-substrate.md §12.3 dep order.
  ;;
  ;; What this chunk IS (per Hβ-lower-substrate.md §4.2 lines 369-461 +
  ;;                     src/lower.mn:344-461 lower_expr_body compound arms):
  ;;   Ten compound-Expr arms — the recursion sites where the kernel's
  ;;   primitive #1 graph carries source TypeHandles through into LowExpr
  ;;   records (LMakeList/LMakeTuple/LMakeRecord/LMakeVariant/LIf/LBlock/
  ;;   LMatch/LFieldLoad/LUnaryOp/LMakeClosure):
  ;;
  ;;     87  UnaryOpExpr     → LUnaryOp     (tag 307)
  ;;     89  LambdaExpr      → LMakeClosure (tag 311)  Lock #1 caps+evs empty seed
  ;;     90  IfExpr          → LIf          (tag 314)  Lock #10 single-elem branches
  ;;     91  BlockExpr       → LBlock       (tag 315)  Lock #2 final-only seed
  ;;     92  MatchExpr       → LMatch       (tag 321)  Lock #3 arms empty seed
  ;;     96  MakeListExpr    → LMakeList    (tag 316)
  ;;     97  MakeTupleExpr   → LMakeTuple   (tag 317)
  ;;     98  MakeRecordExpr  → LMakeRecord  (tag 318)  Lock #6 value-only fields
  ;;     99  NamedRecordExpr → LMakeRecord  (tag 318)  Lock #5 H2.3 collapse
  ;;     100 FieldExpr       → LFieldLoad   (tag 334)  Lock #4 offset 0 seed
  ;;
  ;;   Plus retrofits walk_call.wat:295-324 dispatcher with the above
  ;;   ten tag arms (per chunk #8 Lock #10 two-file precedent).
  ;;
  ;; Implements: Hβ-lower-substrate.md §4.2 + §6.3 + §11 + §12.3 #9;
  ;;             src/lower.mn:344-345 UnaryOpExpr arm;
  ;;             src/lower.mn:369-372 IfExpr arm (Lock #10);
  ;;             src/lower.mn:374-380 BlockExpr arm (Lock #2);
  ;;             src/lower.mn:382-383 MatchExpr arm (Lock #3);
  ;;             src/lower.mn:385-389 MakeList/MakeTuple arms;
  ;;             src/lower.mn:391-399 MakeRecord/NamedRecord arms (Lock #5+#6);
  ;;             src/lower.mn:401-428 LambdaExpr arm (Lock #1+#11);
  ;;             src/lower.mn:450-461 FieldExpr arm (Lock #4);
  ;;             src/lower.mn:1063-1068 lower_record_field_values.
  ;; Exports:    $lower_binop,
  ;;             $lower_unary_op,
  ;;             $lower_lambda,
  ;;             $lower_if,
  ;;             $lower_block,
  ;;             $lower_match,
  ;;             $lower_make_list,
  ;;             $lower_make_tuple,
  ;;             $lower_make_record,
  ;;             $lower_named_record,
  ;;             $lower_field
  ;; Uses:       $walk_expr_node_handle (infer/walk_expr.wat:306-307),
  ;;             $lexpr_make_lunaryop / lmakeclosure / lif / lblock /
  ;;               lmatch / lmakelist / lmaketuple / lmakerecord /
  ;;               lmakevariant / lfieldload (lower/lexpr.wat),
  ;;             $lower_expr (lower/walk_call.wat — retrofitted at this
  ;;               commit to add tag-87/89/90/91/92/96/97/98/99/100 arms),
  ;;             $make_list / $list_index / $list_set / $list_extend_to /
  ;;               $len (runtime/list.wat — buffer-counter Ω.3),
  ;;             $record_get (runtime/record.wat — for MakeRecord field-pair
  ;;               value extraction per Lock #6)
  ;; Test:       bootstrap/test/lower/walk_compound_if.wat,
  ;;             bootstrap/test/lower/walk_compound_make_list.wat,
  ;;             bootstrap/test/lower/walk_compound_make_tuple.wat,
  ;;             bootstrap/test/lower/walk_compound_field.wat,
  ;;             bootstrap/test/lower/walk_compound_lambda.wat
  ;;
  ;; ═══ LOCKS (wheel-canonical override walkthrough §4.2 prose) ════════
  ;;
  ;; Lock #1: LambdaExpr seed defaults — caps=empty, evs=empty, fn=0.
  ;;          Wheel src/lower.mn:411-417 calls collect_free_vars +
  ;;          resolve_captures_outer + ls_enter_frame/ls_exit_frame —
  ;;          NONE of which exist at the seed (state.wat exposes only
  ;;          ls_bind_local/ls_lookup_local/ls_lookup_or_capture/
  ;;          ls_reset_function). LFn ADT not yet seed-substrate
  ;;          (lexpr.wat:160 lvalue-lowfn-lpat-substrate follow-up).
  ;;          Seed emits LMakeClosure(h, 0, empty_list, empty_list).
  ;;          Body recursively lowered via $lower_expr — result DROPPED
  ;;          per Lock #11 (graph reads still fire). Named follow-up
  ;;          Hβ.lower.lambda-capture-substrate covers full wheel parity
  ;;          when collect_free_vars + resolve_captures_outer +
  ;;          ls_enter_frame/ls_exit_frame + LFn ADT all converge.
  ;;
  ;; Lock #2: BlockExpr seed lowers final_expr ONLY; stmts list empty.
  ;;          Wheel src/lower.mn:374-380 lowers stmts via lower_stmt_list +
  ;;          appends final via [lo_final]. $lower_stmt lands at chunk #10;
  ;;          BlockExpr's stmts (parser_compound.wat:130-137 wraps each as
  ;;          nstmt(mk_ExprStmt(...))) require chunk-#10 dispatcher. Seed
  ;;          emits LBlock(h, [lo_final]) — single-element stmts list.
  ;;          Named follow-up Hβ.lower.blockexpr-stmts-substrate covers
  ;;          full wheel parity when chunk #10 lands $lower_stmt.
  ;;          Substrate-honest deferral per Lock #2 — bodied with reasoning,
  ;;          NOT silent stub.
  ;;
  ;; Lock #3: MatchExpr seed lowers scrut ONLY; arms list empty. Wheel
  ;;          src/lower.mn:382-383 calls lower_match_arms which calls
  ;;          bind_pat_locals + lower_pat + ls_push_scope/ls_pop_scope —
  ;;          NONE of which exist at the seed. LowPat ADT opaque per
  ;;          lexpr.wat:570 lvalue-lowfn-lpat-substrate follow-up. Seed
  ;;          emits LMatch(h, lo_scrut, empty_list). Named follow-up
  ;;          Hβ.lower.match-arm-pattern-substrate covers full wheel
  ;;          parity.
  ;;
  ;; Lock #4: FieldExpr offset is sentinel 0 at seed. Wheel
  ;;          src/lower.mn:457-460 + 525-552 calls resolve_field_offset
  ;;          which walks TRecord fields via lookup_ty + structural
  ;;          accessor. ty.wat exposes $ty_tag + $ty_tfun_row +
  ;;          $ty_tcont_discipline (per lookup.wat) but NOT
  ;;          $ty_trecord_fields list-walker at the lower layer. Seed
  ;;          emits LFieldLoad(h, lo_rec, 0) — matches wheel's
  ;;          src/lower.mn:543 `_ => 0` fallback (which fires when
  ;;          lookup returns non-record type). Named follow-up
  ;;          Hβ.lower.field-offset-resolution covers full
  ;;          field-byte-offset arithmetic when ty.wat exposes
  ;;          structural record-fields walker.
  ;;
  ;; Lock #5: NamedRecordExpr (tag 99) collapses to MakeRecord per H2.3.
  ;;          Wheel src/lower.mn:394-399: nominal records lower
  ;;          identically to bare record literals — type identity is
  ;;          type-system-only; runtime sees raw fields. type_name
  ;;          preserved in AST for diagnostics ONLY (drift-8 audit:
  ;;          threaded-not-compared). $lower_make_record + $lower_named_record
  ;;          both call $lower_make_record_body — chunk-private factor;
  ;;          third caller earns the abstraction per Anchor 7 (currently
  ;;          two callers; ready for Hβ.lower.makerecord-promotion).
  ;;
  ;; Lock #6: MakeRecordExpr fields list lowered via per-field value
  ;;          extraction (record_get offset 4 of pair-record), NOT
  ;;          $lower_expr_list. Per wheel src/lower.mn:391-392 +
  ;;          1063-1068 lower_record_field_values. Each fields-list
  ;;          element is a `(name, value)` pair-record with alphabetical
  ;;          Ω.5 layout (name=offset 0, value=offset 4). Drift 7
  ;;          closure: ONE lowered-value list (sort-order = layout-order).
  ;;
  ;; Lock #7: AST navigation per chunk #6/#7/#8 precedent — every arm
  ;;          reads $h = $walk_expr_node_handle($node); then $body =
  ;;          i32.load offset=4 $node; then variant-struct = i32.load
  ;;          offset=4 $body; then variant-specific offsets. NO local
  ;;          re-derivation of $node_handle.
  ;;
  ;; Lock #8: $lower_expr dispatcher retrofit at walk_call.wat:295-324.
  ;;          This commit retrofits TEN tag arms (87/89/90/91/92/96/97/
  ;;          98/99/100). Per chunk #8 Lock #10 two-file precedent. The
  ;;          terminal (unreachable) trap STAYS — guards future Expr-region
  ;;          growth.
  ;;
  ;; Lock #9: AST layouts for tags lacking parser_*.wat constructors.
  ;;          Five of the ten tags lack $mk_*: 87 (UnaryOp), 89 (Lambda),
  ;;          98 (MakeRecord), 99 (NamedRecord), 100 (FieldExpr).
  ;;          Confirmed exist: 90 (mk_IfExpr parser_infra.wat:119),
  ;;          91 (mk_BlockExpr parser_infra.wat:128), 92 (mk_MatchExpr
  ;;          parser_infra.wat:136), 96 (mk_MakeListExpr parser_compound
  ;;          .wat:77), 97 (mk_MakeTupleExpr parser_compound.wat:70).
  ;;          Harnesses for the missing five use direct $alloc + i32.store
  ;;          per chunk #8 walk_handle_simple.wat:31-34 precedent. Layouts:
  ;;            87 [tag=87][op_name_str][inner_node]  offsets 0/4/8
  ;;            89 [tag=89][params_list][body_node]   offsets 0/4/8
  ;;            98 [tag=98][fields_list]              offsets 0/4
  ;;            99 [tag=99][type_name_str][fields]    offsets 0/4/8
  ;;            100 [tag=100][rec_node][field_str]    offsets 0/4/8
  ;;          Drift-9-safe: an unconstructible AST tag will simply never
  ;;          reach this arm; if/when parser produces these tags, body is
  ;;          correct per wheel canonical. Named follow-up
  ;;          Hβ.lower.compound-mk-constructors covers parser-side
  ;;          constructor landing.
  ;;
  ;; Lock #10: IfExpr branches are SINGLE-ELEMENT lists — [lo_then],
  ;;           [lo_else]. Per wheel src/lower.mn:369-372 canonical.
  ;;           lexpr.wat:455-467 LIf field 2/3 are List per src/lower.mn:121
  ;;           LIf(Int, LowExpr, List, List) — current parser_compound.wat:
  ;;           163-188 already handles `if cond { block }` by recursing into
  ;;           parse_block (producing a BlockExpr); IfExpr's then_e/else_e
  ;;           is a single BlockExpr node, NOT a stmts list.
  ;;
  ;; Lock #11: $lower_lambda recursively lowers body via $lower_expr,
  ;;           DROPS the result. The graph reads + $lookup_ty side
  ;;           effects fire; the LowExpr is unused (LFn ADT not landed).
  ;;           Drop is explicit (not silent omission) — surfaces in
  ;;           Hβ.lower.lambda-capture-substrate when LFn lands.
  ;;
  ;; ═══ EIGHT INTERROGATIONS (per Hβ-lower-substrate.md §5.3) ══════════
  ;;
  ;; 1. Graph?       Each arm reads $walk_expr_node_handle($node) (offset
  ;;                 12 of N-wrapper). Each LowExpr's field 0 IS the source
  ;;                 TypeHandle for $lookup_ty live read. Read-only on graph.
  ;;
  ;; 2. Handler?     Wheel: 4-effect chain (LookupTy + LowerCtx + EnvRead
  ;;                 + Diagnostic) @resume=OneShot. Seed: 10 direct
  ;;                 functions + 1 chunk-private helper $lower_record_field_values.
  ;;                 $classify_handler NOT INVOKED here.
  ;;
  ;; 3. Verb?        Mostly silent. LambdaExpr is the substrate that the
  ;;                 ~> verb's HandleExpr/PipeExpr arms compose on — but
  ;;                 verb-projection itself is walk_handle.wat's domain.
  ;;
  ;; 4. Row?         Silent at this chunk. LambdaExpr's row-classification
  ;;                 is set during inference; lower reads via $lookup_ty
  ;;                 when downstream call-sites query monomorphism (chunk #7).
  ;;
  ;; 5. Ownership?   Each $lexpr_make_l* output is `own` of bump.
  ;;                 Sub-LowExprs `ref`. Lists via Ω.3 buffer-counter.
  ;;
  ;; 6. Refinement?  Transparent. TRefined dispatches via $lookup_ty;
  ;;                 verify ledger holds obligations.
  ;;
  ;; 7. Gradient?    LMakeRecord/LMakeVariant/LMakeTuple/LMakeList all
  ;;                 use the SAME $make_record(tag, arity) construction
  ;;                 path — drift-6 closure. Lambda's eventual full
  ;;                 LMakeClosure IS the closure-capture cash-out
  ;;                 (deferred per Lock #1). FieldExpr's resolved offset
  ;;                 IS the W6 record-offset cash-out (deferred per Lock #4).
  ;;
  ;; 8. Reason?      Read-only. Every LowExpr's field 0 carries the handle
  ;;                 whose GNode preserves Reason chain.
  ;;
  ;; ═══ FORBIDDEN PATTERNS AUDIT ════════════════════════════════════════
  ;;
  ;; - Drift 1 (Rust vtable):        No $compound_dispatch_table. The
  ;;                                  retrofitted dispatcher at walk_call.wat:
  ;;                                  295-324 is a 12-arm (if (i32.eq tag N) ...)
  ;;                                  chain — direct sentinel comparison; no
  ;;                                  table indirection. Word "vtable" appears
  ;;                                  NOWHERE except in this audit.
  ;;
  ;; - Drift 2 (Scheme env frame):   The seed's state.wat is one flat list;
  ;;                                  this chunk does NOT push/pop frame
  ;;                                  stacks. Lambda's frame-discipline
  ;;                                  deferred per Lock #1.
  ;;
  ;; - Drift 4 (monad transformer):  No LowerM. Each $lower_<arm> is
  ;;                                  (param i32) (result i32). Direct.
  ;;
  ;; - Drift 5 (C calling conv):     Single $node param + single i32
  ;;                                  return per arm. NO __closure/__ev
  ;;                                  split. LMakeClosure arity-4 fields
  ;;                                  ALL set at construction.
  ;;
  ;; - Drift 6 (primitive-special):  LMakeList/LMakeTuple/LMakeRecord/
  ;;                                  LMakeVariant ALL use $make_record(tag,
  ;;                                  arity) — same discipline as every
  ;;                                  other LowExpr. NO "tuples special
  ;;                                  because pair." LitBool's nullary-ADT
  ;;                                  precedent (chunk #6 Lock #3) carries
  ;;                                  through.
  ;;
  ;; - Drift 7 (parallel-arrays):    LMakeRecord.fields is ONE list of
  ;;                                  values (Lock #6 sort-order = layout-
  ;;                                  order). LMakeVariant.args is ONE list.
  ;;                                  LMatch.arms is ONE list (Lock #3
  ;;                                  empty-seed). LMakeClosure's caps +
  ;;                                  evs are TWO conceptually-distinct
  ;;                                  lists per H1 reification (caps =
  ;;                                  closure values, evs = evidence slots)
  ;;                                  — wheel-canonical, NOT parallel-arrays.
  ;;
  ;; - Drift 8 (string-keyed):       Tag-int dispatch only. UnaryOp's
  ;;                                  op_name THREADED not COMPARED.
  ;;                                  NamedRecordExpr's type_name similarly
  ;;                                  threaded-then-discarded per H2.3
  ;;                                  (Lock #5).
  ;;
  ;; - Drift 9 (deferred-by-omission): All TEN arms FULLY BODIED this commit.
  ;;                                  Lock #1/#2/#3/#4 deferrals bodied
  ;;                                  with reasoning + named follow-ups —
  ;;                                  NOT silent stubs.
  ;;
  ;; - Foreign fluency JS async/await: NEVER "promise" / "async" / "future"
  ;;                                  / "await". Vocabulary stays Mentl.
  ;;
  ;; - Foreign fluency Scheme call/cc: NEVER "captured stack" /
  ;;                                  "undelimited."
  ;;
  ;; - Foreign fluency LLVM/GHC IR / OCaml closure conversion: NEVER "SSA"
  ;;                                  / "phi" / "closure conversion pass" /
  ;;                                  "Lambda lifting." Closure construction
  ;;                                  IS LMakeClosure per spec 05.
  ;;
  ;; ═══ Named follow-ups (Drift 9 closure) ═══════════════════════════════
  ;;
  ;;   - Hβ.lower.lambda-capture-substrate:
  ;;             Wheel src/lower.mn:411-417 collect_free_vars +
  ;;             resolve_captures_outer + ls_enter_frame + ls_exit_frame
  ;;             + LFn ADT all converge as one peer landing. Replaces
  ;;             Lock #1+#11 stubs with full closure-capture cash-out.
  ;;
  ;;   - Hβ.lower.blockexpr-stmts-substrate:
  ;;             Per Lock #2. When chunk #10 walk_stmt.wat lands
  ;;             $lower_stmt + adds tag-91 BlockExpr stmt-list lowering,
  ;;             this arm grows the stmts-then-final shape.
  ;;
  ;;   - Hβ.lower.match-arm-pattern-substrate:
  ;;             Per Lock #3. LowPat ADT (lexpr.wat:570 follow-up) +
  ;;             ls_push_scope/ls_pop_scope at state.wat + bind_pat_locals
  ;;             + lower_pat all converge.
  ;;
  ;;   - Hβ.lower.field-offset-resolution:
  ;;             Per Lock #4. ty.wat structural record-fields walker
  ;;             ($ty_trecord_fields + $ty_trecord_open_fields) lands;
  ;;             $resolve_field_offset becomes a real walk per
  ;;             src/lower.mn:525-552.
  ;;
  ;;   - Hβ.lower.compound-mk-constructors:
  ;;             Per Lock #9. parser_compound.wat (or parser_infra.wat)
  ;;             grows mk_UnaryOpExpr / mk_LambdaExpr / mk_MakeRecordExpr /
  ;;             mk_NamedRecordExpr / mk_FieldExpr — five constructors.
  ;;             Harnesses migrate from direct-alloc to structured.
  ;;
  ;;   - Hβ.lower.makerecord-promotion:
  ;;             Per Lock #5. When third caller emerges (e.g., a future
  ;;             record-pattern lowering site), $lower_make_record_body
  ;;             promotes from chunk-private factor to peer file.
  ;;
  ;;   - Hβ.lower.lower-expr-dispatch-extension:
  ;;             (extending from chunk #7 + #8) walk_call.wat:295-324
  ;;             retrofit completes with this commit's TEN tag arms.
  ;;             Future Expr-region growth lands additional arms.

  ;; ─── $lower_record_field_values — chunk-private (Lock #6) ──────────
  ;; Per src/lower.mn:1063-1068 lower_record_field_values. Each fields-list
  ;; element is a `(name, value)` pair-record with alphabetical Ω.5 layout
  ;; (name=offset 0, value=offset 4); extract value + recursively $lower_expr.
  ;; Buffer-counter (Ω.3). Sort-order = layout-order; ONE lowered list.
  (func $lower_record_field_values (param $fields i32) (result i32)
    (local $n i32) (local $i i32) (local $buf i32)
    (local $field_pair i32) (local $value_node i32) (local $lo_value i32)
    (local.set $n   (call $len (local.get $fields)))
    (local.set $buf (call $make_list (i32.const 0)))
    (local.set $buf (call $list_extend_to (local.get $buf) (local.get $n)))
    (local.set $i   (i32.const 0))
    (block $done
      (loop $each
        (br_if $done (i32.ge_u (local.get $i) (local.get $n)))
        (local.set $field_pair (call $list_index (local.get $fields) (local.get $i)))
        ;; Lock #6: pair-record offset 4 = value (alphabetical name<value).
        (local.set $value_node (call $record_get (local.get $field_pair) (i32.const 1)))
        (local.set $lo_value   (call $lower_expr (local.get $value_node)))
        (drop (call $list_set (local.get $buf) (local.get $i) (local.get $lo_value)))
        (local.set $i (i32.add (local.get $i) (i32.const 1)))
        (br $each)))
    (local.get $buf))

  ;; ─── $lower_expr_list_compound — chunk-private buffer-counter helper ─
  ;; Per src/lower.mn:1055-1057 lower_expr_list. Same shape as walk_call's
  ;; $lower_args; chunk-private until third caller emerges.
  (func $lower_expr_list_compound (param $nodes i32) (result i32)
    (local $n i32) (local $i i32) (local $buf i32)
    (local $node i32) (local $lo i32)
    (local.set $n   (call $len (local.get $nodes)))
    (local.set $buf (call $make_list (i32.const 0)))
    (local.set $buf (call $list_extend_to (local.get $buf) (local.get $n)))
    (local.set $i   (i32.const 0))
    (block $done
      (loop $each
        (br_if $done (i32.ge_u (local.get $i) (local.get $n)))
        (local.set $node (call $list_index (local.get $nodes) (local.get $i)))
        (local.set $lo   (call $lower_expr (local.get $node)))
        (drop (call $list_set (local.get $buf) (local.get $i) (local.get $lo)))
        (local.set $i (i32.add (local.get $i) (i32.const 1)))
        (br $each)))
    (local.get $buf))

  ;; ─── Parameter + pattern helpers ───────────────────────────────────

  (func $lower_param_names (param $params i32) (result i32)
    (local $n i32) (local $i i32) (local $buf i32) (local $param i32)
    (local.set $n   (call $len (local.get $params)))
    (local.set $buf (call $make_list (i32.const 0)))
    (local.set $buf (call $list_extend_to (local.get $buf) (local.get $n)))
    (local.set $i   (i32.const 0))
    (block $done
      (loop $each
        (br_if $done (i32.ge_u (local.get $i) (local.get $n)))
        (local.set $param (call $list_index (local.get $params) (local.get $i)))
        (drop (call $list_set (local.get $buf) (local.get $i)
                (i32.load offset=4 (local.get $param))))
        (local.set $i (i32.add (local.get $i) (i32.const 1)))
        (br $each)))
    (local.get $buf))

  (func $lower_param_handles (param $params i32) (result i32)
    (local $n i32) (local $i i32) (local $buf i32)
    (local $param i32) (local $ty i32) (local $h i32)
    (local.set $n   (call $len (local.get $params)))
    (local.set $buf (call $make_list (i32.const 0)))
    (local.set $buf (call $list_extend_to (local.get $buf) (local.get $n)))
    (local.set $i   (i32.const 0))
    (block $done
      (loop $each
        (br_if $done (i32.ge_u (local.get $i) (local.get $n)))
        (local.set $param (call $list_index (local.get $params) (local.get $i)))
        (local.set $ty    (i32.load offset=8 (local.get $param)))
        (local.set $h     (i32.const 0))
        (if (i32.eq (call $ty_tag (local.get $ty)) (i32.const 104))
          (then
            (local.set $h (call $ty_tvar_handle (local.get $ty)))))
        (drop (call $list_set (local.get $buf) (local.get $i) (local.get $h)))
        (local.set $i (i32.add (local.get $i) (i32.const 1)))
        (br $each)))
    (local.get $buf))

  ;; $param_handles_of — a param's graph HANDLE, read from the fn's
  ;; INFERRED TFun, never from the parsed TParam.ty. The parsed ty caches
  ;; the resolved type and drops the handle for any concrete-typed param
  ;; (the 0-sentinel $lower_param_handles returns), so the lowered local
  ;; goes type-blind and `word == "fn"` emits pointer i32.eq instead of
  ;; $str_eq — keyword_kind's literal table never matches and every
  ;; keyword lexes as TIdent. lookup_ty is a shallow top-chase
  ;; (lookup.wat:191): for an NBound fn handle it returns the stored TFun
  ;; with each TParam(name, TVar(h)) intact ($chase_deep keeps TFun params
  ;; opaque — ty.wat:160), so $map_tparam_handles recovers h. The local
  ;; then live-chases its type via $lookup_ty, so every type-dispatched op
  ;; (==, ++, to_string) sees the type the graph proved. Wheel mirror:
  ;; src/lower.mn param_handles_of. Falls back to $lower_param_handles
  ;; only when the fn handle isn't yet a matching-arity TFun.
  (func $param_handles_of (param $fn_handle i32) (param $params i32) (result i32)
    (local $fty i32) (local $tparams i32)
    (local.set $fty (call $lookup_ty (local.get $fn_handle)))
    (if (i32.eq (call $ty_tag (local.get $fty)) (i32.const 107))   ;; TFun
      (then
        (local.set $tparams (call $ty_tfun_params (local.get $fty)))
        (if (i32.eq (call $len (local.get $tparams)) (call $len (local.get $params)))
          (then (return (call $map_tparam_handles (local.get $tparams)))))))
    (call $lower_param_handles (local.get $params)))

  ;; $map_tparam_handles — buffer-counter map of tparam_handle over the
  ;; TFun's TParam list. tparam_handle: TVar(h) → h, else 0.
  (func $map_tparam_handles (param $tparams i32) (result i32)
    (local $n i32) (local $i i32) (local $buf i32)
    (local $tp i32) (local $ty i32) (local $h i32)
    (local.set $n   (call $len (local.get $tparams)))
    (local.set $buf (call $make_list (i32.const 0)))
    (local.set $buf (call $list_extend_to (local.get $buf) (local.get $n)))
    (local.set $i   (i32.const 0))
    (block $done
      (loop $each
        (br_if $done (i32.ge_u (local.get $i) (local.get $n)))
        (local.set $tp (call $list_index (local.get $tparams) (local.get $i)))
        (local.set $ty (call $tparam_ty (local.get $tp)))
        (local.set $h  (i32.const 0))
        (if (i32.eq (call $ty_tag (local.get $ty)) (i32.const 104))   ;; TVar
          (then (local.set $h (call $ty_tvar_handle (local.get $ty)))))
        (drop (call $list_set (local.get $buf) (local.get $i) (local.get $h)))
        (local.set $i (i32.add (local.get $i) (i32.const 1)))
        (br $each)))
    (local.get $buf))

  (func $bind_names_as_locals (param $names i32) (param $handles i32)
    (local $n i32) (local $i i32)
    (local.set $n (call $len (local.get $names)))
    (local.set $i (i32.const 0))
    (block $done
      (loop $each
        (br_if $done (i32.ge_u (local.get $i) (local.get $n)))
        (drop (call $ls_bind_local
                (call $list_index (local.get $names) (local.get $i))
                (call $list_index (local.get $handles) (local.get $i))))
        (local.set $i (i32.add (local.get $i) (i32.const 1)))
        (br $each))))

  (func $bind_pat_locals_fields (param $fields i32)
    (local $n i32) (local $i i32) (local $entry i32)
    (local.set $n (call $len (local.get $fields)))
    (local.set $i (i32.const 0))
    (block $done
      (loop $each
        (br_if $done (i32.ge_u (local.get $i) (local.get $n)))
        (local.set $entry (call $list_index (local.get $fields) (local.get $i)))
        ;; PRecord field sub-pattern types floor (Hβ.lower.bind-handle-typed-subpattern)
        (call $bind_pat_locals (call $record_get (local.get $entry) (i32.const 1)) (i32.const 0))
        (local.set $i (i32.add (local.get $i) (i32.const 1)))
        (br $each))))

  ;; $ty_handle_of — TVar(h) -> h, else 0 (robust to null/non-heap). The local
  ;; carries a handle whose $lookup_ty resolves its element type, so ==/++/
  ;; to_string dispatch structurally (str_eq for String). Mirrors fn-param
  ;; $map_tparam_handles' tparam_handle.
  (func $ty_handle_of (param $ty i32) (result i32)
    (if (i32.lt_u (local.get $ty) (global.get $heap_base))
      (then (return (i32.const 0))))
    (if (i32.eq (call $ty_tag (local.get $ty)) (i32.const 104))   ;; TVar
      (then (return (call $ty_tvar_handle (local.get $ty)))))
    (i32.const 0))

  ;; $ty_strip_to_tuple — chase a TVar Ty to its bound type (mirror the wheel's
  ;; tuple_pat_strip). env_find's `list_head(entries)` types to a TVar bound to
  ;; the entry TTuple; $lookup_ty resolves one NBound level but the bound Ty can
  ;; itself be a TVar — chase until non-TVar (cycle-guarded at 32).
  (func $ty_strip_to_tuple (param $ty i32) (result i32)
    (local $guard i32)
    (local.set $guard (i32.const 0))
    (block $done
      (loop $chase
        (br_if $done (i32.ge_u (local.get $guard) (i32.const 32)))
        (br_if $done (i32.lt_u (local.get $ty) (global.get $heap_base)))
        (br_if $done (i32.ne (call $ty_tag (local.get $ty)) (i32.const 104)))   ;; not TVar
        (local.set $ty (call $lookup_ty (call $ty_tvar_handle (local.get $ty))))
        (local.set $guard (i32.add (local.get $guard) (i32.const 1)))
        (br $chase)))
    (local.get $ty))

  ;; $bind_pat_locals_zip — each PTuple sub-pattern lands with its element TYPE
  ;; (read live from the TTuple element list); elements past the list floor to 0.
  (func $bind_pat_locals_zip (param $subs i32) (param $elems i32)
    (local $n i32) (local $i i32) (local $elem_ty i32)
    (local.set $n (call $len (local.get $subs)))
    (local.set $i (i32.const 0))
    (block $done
      (loop $each
        (br_if $done (i32.ge_u (local.get $i) (local.get $n)))
        (local.set $elem_ty (i32.const 0))
        (if (i32.lt_u (local.get $i) (call $len (local.get $elems)))
          (then (local.set $elem_ty (call $list_index (local.get $elems) (local.get $i)))))
        (call $bind_pat_locals (call $list_index (local.get $subs) (local.get $i)) (local.get $elem_ty))
        (local.set $i (i32.add (local.get $i) (i32.const 1)))
        (br $each))))

  ;; $bind_pat_locals_floor — PCon-payload / PList-element sub-pattern types are
  ;; the named peer Hβ.lower.bind-handle-typed-subpattern (additive); they floor
  ;; to type 0 = i32.eq, byte-identical to the prior sentinel.
  (func $bind_pat_locals_floor (param $pats i32)
    (local $n i32) (local $i i32)
    (local.set $n (call $len (local.get $pats)))
    (local.set $i (i32.const 0))
    (block $done
      (loop $each
        (br_if $done (i32.ge_u (local.get $i) (local.get $n)))
        (call $bind_pat_locals (call $list_index (local.get $pats) (local.get $i)) (i32.const 0))
        (local.set $i (i32.add (local.get $i) (i32.const 1)))
        (br $each))))

  ;; $bind_pat_locals_ctor — bind a PCon's sub-patterns for the arm body's scope,
  ;; marking each direct TFloat PVar sub-binder f64 (LOCAL_ENTRY field 3) so
  ;; $lower_local_ref mangles its uses to the `.f64` local — the SAME channel the
  ;; ctor-payload read uses everywhere ($ctor_payload_params). Non-float subs
  ;; floor to type 0, byte-identical to the prior $bind_pat_locals_floor; nested
  ;; subs recurse (their own PCon level marks their direct binders).
  (func $bind_pat_locals_ctor (param $name i32) (param $subs i32)
    (local $binding i32) (local $params i32) (local $n i32) (local $np i32)
    (local $i i32) (local $sub i32) (local $pty i32) (local $sub_h i32)
    (local.set $params (i32.const 0))
    (local.set $binding (call $env_lookup_ctor (local.get $name)))
    (if (i32.ne (local.get $binding) (i32.const 0))
      (then
        (local.set $params
          (call $ctor_payload_params (call $env_binding_scheme (local.get $binding))))))
    (local.set $n  (call $len (local.get $subs)))
    (local.set $np (call $len (local.get $params)))
    (local.set $i (i32.const 0))
    (block $done
      (loop $each
        (br_if $done (i32.ge_u (local.get $i) (local.get $n)))
        (local.set $sub (call $list_index (local.get $subs) (local.get $i)))
        (local.set $pty (i32.const 0))
        (if (i32.lt_u (local.get $i) (local.get $np))
          (then (local.set $pty
                  (call $pty_canon_seq
                    (call $tparam_ty (call $list_index (local.get $params) (local.get $i)))))))
        (if (i32.eq (call $tag_of (local.get $sub)) (i32.const 130))             ;; PVar
          (then
            ;; Mint a live proof for the DECLARED payload type: the binder's
            ;; LLocal carries this handle (lower_var_ref Lock #1), so the emit
            ;; dispatches reach it via lookup_ty — BConcat's list/str pick and
            ;; BEq's str_eq stop falling to the h=0 W_ConcatUnproven default.
            ;; (union_row's `na ++ nb` emitted str_concat-on-lists: a 2-byte
            ;; string whose fresh-zero bytes read back as a flat list holding
            ;; element 0 — the m2 effect-row corruption, 2026-07-04.)
            (local.set $sub_h (i32.const 0))
            (if (i32.ne (local.get $pty) (i32.const 0))
              (then
                (local.set $sub_h (call $graph_fresh_ty (i32.const 0)))
                (call $graph_bind (local.get $sub_h) (local.get $pty) (i32.const 0))))
            (if (i32.eq (call $ty_tag (local.get $pty)) (i32.const 101))         ;; TFloat
              (then
                (drop (call $ls_bind_local_f64 (i32.load offset=4 (local.get $sub))
                        (local.get $sub_h) (i32.const 1))))
              (else
                (drop (call $ls_bind_local (i32.load offset=4 (local.get $sub))
                        (local.get $sub_h))))))
          (else
            (call $bind_pat_locals (local.get $sub) (local.get $pty))))
        (local.set $i (i32.add (local.get $i) (i32.const 1)))
        (br $each))))

  ;; $pty_canon_seq — canonicalize NAMED sequence types from ctor decls to
  ;; their structural tags: the wheel spells `EfClosed(List)` / `ENamed(String)`
  ;; by NAME, so the scheme carries TName (108) where the emit dispatches prove
  ;; by tag (TList 105 / TString 102). One name-read at the bind; the dispatches
  ;; stay tag-keyed. Everything else passes through untouched.
  (func $pty_canon_seq (param $pty i32) (result i32)
    (local $nm i32)
    (if (i32.lt_u (local.get $pty) (global.get $heap_base))
      (then (return (local.get $pty))))
    (if (i32.ne (call $ty_tag (local.get $pty)) (i32.const 108))    ;; TName only
      (then (return (local.get $pty))))
    (if (i32.ne (call $len (call $record_get (local.get $pty) (i32.const 1)))
                (i32.const 0))
      (then (return (local.get $pty))))                             ;; args must be []
    (local.set $nm (call $record_get (local.get $pty) (i32.const 0)))
    ;; "List"
    (if (i32.and (i32.eq (call $str_len (local.get $nm)) (i32.const 4))
          (i32.and (i32.eq (call $byte_at (local.get $nm) (i32.const 0)) (i32.const 76))
            (i32.and (i32.eq (call $byte_at (local.get $nm) (i32.const 1)) (i32.const 105))
              (i32.and (i32.eq (call $byte_at (local.get $nm) (i32.const 2)) (i32.const 115))
                       (i32.eq (call $byte_at (local.get $nm) (i32.const 3)) (i32.const 116))))))
      (then (return (call $ty_make_tlist (i32.const 0)))))
    ;; "String"
    (if (i32.and (i32.eq (call $str_len (local.get $nm)) (i32.const 6))
          (i32.and (i32.eq (call $byte_at (local.get $nm) (i32.const 0)) (i32.const 83))
            (i32.and (i32.eq (call $byte_at (local.get $nm) (i32.const 1)) (i32.const 116))
              (i32.and (i32.eq (call $byte_at (local.get $nm) (i32.const 2)) (i32.const 114))
                (i32.and (i32.eq (call $byte_at (local.get $nm) (i32.const 3)) (i32.const 105))
                  (i32.and (i32.eq (call $byte_at (local.get $nm) (i32.const 4)) (i32.const 110))
                           (i32.eq (call $byte_at (local.get $nm) (i32.const 5)) (i32.const 103))))))))
      (then (return (i32.const 102))))                              ;; TString sentinel
    (local.get $pty))

  (func $bind_pat_locals (param $pat i32) (param $ty i32)
    (local $tag i32) (local $rest_opt i32) (local $rest_var i32) (local $strip i32)
    (if (i32.eq (local.get $pat) (i32.const 131))
      (then (return)))
    (if (i32.lt_u (local.get $pat) (global.get $heap_base))
      (then (unreachable)))
    (local.set $tag (call $tag_of (local.get $pat)))
    ;; PVar (130) — carry the element type handle (the env_find str_eq fix).
    (if (i32.eq (local.get $tag) (i32.const 130))
      (then
        (drop (call $ls_bind_local (i32.load offset=4 (local.get $pat))
                                   (call $ty_handle_of (local.get $ty))))
        (return)))
    (if (i32.eq (local.get $tag) (i32.const 133))
      (then
        (call $bind_pat_locals_ctor
          (i32.load offset=4 (local.get $pat))
          (i32.load offset=8 (local.get $pat)))
        (return)))
    ;; PTuple (134) — recurse each sub with its element TYPE from the (chased) TTuple.
    (if (i32.eq (local.get $tag) (i32.const 134))
      (then
        (local.set $strip (call $ty_strip_to_tuple (local.get $ty)))
        (if (i32.and (i32.ge_u (local.get $strip) (global.get $heap_base))
                     (i32.eq (call $ty_tag (local.get $strip)) (i32.const 106)))   ;; TTuple
          (then (call $bind_pat_locals_zip (i32.load offset=4 (local.get $pat))
                                           (call $ty_ttuple_elems (local.get $strip))))
          (else (call $bind_pat_locals_floor (i32.load offset=4 (local.get $pat)))))
        (return)))
    (if (i32.eq (local.get $tag) (i32.const 135))
      (then
        (call $bind_pat_locals_floor (i32.load offset=4 (local.get $pat)))
        ;; ALSO bind the `...rest` tail (offset 8 = Option<String>). The pattern
        ;; PROVED this binding; binding the element subs but not the tail left
        ;; every `rest` use UNRESOLVED (insert_descending, enforce_alt_binding_law).
        ;; Mirror $lower_pat's rest-var extraction exactly, incl. the `_` skip.
        (local.set $rest_opt (i32.load offset=8 (local.get $pat)))
        (if (i32.and
              (i32.ge_u (local.get $rest_opt) (global.get $heap_base))
              (i32.eq (call $tag_of (local.get $rest_opt)) (i32.const 1)))   ;; Some
          (then
            (local.set $rest_var (i32.load offset=4 (local.get $rest_opt)))
            (if (i32.eqz (i32.and
                  (i32.eq (call $str_len (local.get $rest_var)) (i32.const 1))
                  (i32.eq (call $byte_at (local.get $rest_var) (i32.const 0)) (i32.const 95))))
              (then (drop (call $ls_bind_local (local.get $rest_var) (i32.const 0)))))))
        (return)))
    (if (i32.eq (local.get $tag) (i32.const 136))
      (then
        (call $bind_pat_locals_fields (i32.load offset=4 (local.get $pat)))
        (return)))
    ;; PAlt (137): branches bind the same names (the wheel-infer law) —
    ;; register branch 0's set once; per-branch would double-bind.
    (if (i32.eq (local.get $tag) (i32.const 137))
      (then
        (if (i32.gt_u (call $len (i32.load offset=4 (local.get $pat)))
                      (i32.const 0))
          (then
            (call $bind_pat_locals
              (call $list_index (i32.load offset=4 (local.get $pat))
                (i32.const 0))
              (i32.const 0))))
        (return))))

  (func $lower_pat_record_fields (param $fields i32) (param $field_idx i32) (param $scrut_h i32) (result i32)
    (local $n i32) (local $i i32) (local $buf i32)
    (local $entry i32) (local $name i32) (local $sub_pat i32)
    (local $lo_pat i32) (local $triple i32)
    (local $offset i32)
    (local.set $n   (call $len (local.get $fields)))
    (local.set $buf (call $make_list (i32.const 0)))
    (local.set $buf (call $list_extend_to (local.get $buf) (local.get $n)))
    (local.set $i   (i32.const 0))
    (block $done
      (loop $each
        (br_if $done (i32.ge_u (local.get $i) (local.get $n)))
        (local.set $entry   (call $list_index (local.get $fields) (local.get $i)))
        (local.set $name    (call $record_get (local.get $entry) (i32.const 0)))
        (local.set $sub_pat (call $record_get (local.get $entry) (i32.const 1)))
        (local.set $lo_pat  (call $lower_pat (local.get $sub_pat) (local.get $scrut_h)))
        (local.set $triple  (call $make_record (i32.const 0) (i32.const 3)))
        (call $record_set (local.get $triple) (i32.const 0) (local.get $name))
        
        ;; Use the graph to resolve the canonical byte offset for this field!
        (local.set $offset (call $resolve_field_offset (local.get $scrut_h) (local.get $name)))
        (call $record_set (local.get $triple) (i32.const 1) (local.get $offset))
        
        (call $record_set (local.get $triple) (i32.const 2) (local.get $lo_pat))
        (drop (call $list_set (local.get $buf) (local.get $i) (local.get $triple)))
        (local.set $i (i32.add (local.get $i) (i32.const 1)))
        (br $each)))
    (local.get $buf))

  (func $lower_pats (param $pats i32) (param $scrut_h i32) (result i32)
    (local $n i32) (local $i i32) (local $buf i32)
    (local $pat i32) (local $lo_pat i32)
    (local.set $n   (call $len (local.get $pats)))
    (local.set $buf (call $make_list (i32.const 0)))
    (local.set $buf (call $list_extend_to (local.get $buf) (local.get $n)))
    (local.set $i   (i32.const 0))
    (block $done
      (loop $each
        (br_if $done (i32.ge_u (local.get $i) (local.get $n)))
        (local.set $pat    (call $list_index (local.get $pats) (local.get $i)))
        (local.set $lo_pat (call $lower_pat (local.get $pat) (local.get $scrut_h)))
        (drop (call $list_set (local.get $buf) (local.get $i) (local.get $lo_pat)))
        (local.set $i (i32.add (local.get $i) (i32.const 1)))
        (br $each)))
    (local.get $buf))

  ;; $f64_local_mangle — the deterministic `.f64` suffix for an f64 pattern
  ;; binder's WASM local name. Applied IDENTICALLY at the bind
  ;; ($stamp_lpcon_sub_reprs) and every use ($lower_local_ref), so decl and uses
  ;; agree; the `.` cannot appear in a source identifier, so the mangled name
  ;; never collides with a real binder — only with another f64 binder of the same
  ;; name (which shares its width, so one local is correct).
  (data (i32.const 8064) "\04\00\00\00.f64")
  (func $f64_local_mangle (param $name i32) (result i32)
    (call $str_concat (local.get $name) (i32.const 8064)))

  ;; $ctor_payload_params — the ConstructorScheme's payload type list (the
  ;; TFun body's params); 0 for a nullary ctor (a TName body has no payloads).
  ;; Reuses the walk_const.wat:363 / $resolve_field_offset:1128 channel exactly:
  ;; scheme_body → (TFun ? its params : none).
  (func $ctor_payload_params (param $scheme i32) (result i32)
    (local $body i32)
    (local.set $body (call $scheme_body (local.get $scheme)))
    (if (i32.eq (call $ty_tag (local.get $body)) (i32.const 107))   ;; TFun
      (then (return (call $ty_tfun_params (local.get $body)))))
    (i32.const 0))

  ;; $stamp_lpcon_sub_reprs — positional walk of the ctor's payload types over
  ;; the lowered sub-patterns. Each bare-binder (LPVar) sub whose payload type
  ;; is TFloat (101) gets its repr stamped f64 — the pattern node had no handle
  ;; to carry it. Multi-payload ctors fall out of the positional walk; nested
  ;; ctor/tuple sub-patterns are NOT stamped here (they are not LPVar) — they
  ;; recurse through $lower_pat and stamp their OWN direct binders.
  (func $stamp_lpcon_sub_reprs (param $subs i32) (param $params i32)
    (local $n i32) (local $np i32) (local $i i32) (local $sub i32) (local $pty i32)
    (if (i32.eqz (local.get $params)) (then (return)))
    (local.set $n  (call $len (local.get $subs)))
    (local.set $np (call $len (local.get $params)))
    (local.set $i (i32.const 0))
    (block $done
      (loop $each
        (br_if $done (i32.ge_u (local.get $i) (local.get $n)))
        (br_if $done (i32.ge_u (local.get $i) (local.get $np)))
        (local.set $sub (call $list_index (local.get $subs) (local.get $i)))
        (if (i32.eq (call $tag_of (local.get $sub)) (i32.const 360))   ;; LPVar
          (then
            (local.set $pty
              (call $tparam_ty (call $list_index (local.get $params) (local.get $i))))
            (if (i32.eq (call $ty_tag (local.get $pty)) (i32.const 101))   ;; TFloat
              (then
                (call $lowpat_lpvar_set_repr (local.get $sub) (i32.const 1))
                ;; Mangle the bind name to match $lower_local_ref's mangled uses
                ;; (both `.f64`), so this f64 binder never shares a WASM local
                ;; with a same-named i32 binder in a sibling arm.
                (call $lowpat_lpvar_set_name (local.get $sub)
                  (call $f64_local_mangle (call $lowpat_lpvar_name (local.get $sub))))))))
        (local.set $i (i32.add (local.get $i) (i32.const 1)))
        (br $each))))

  (func $lower_pat (param $pat i32) (param $scrut_h i32) (result i32)
    (local $tag i32) (local $lit i32) (local $lit_tag i32)
    (local $name i32) (local $subs i32) (local $rest_opt i32) (local $rest_var i32)
    (local $binding i32) (local $kind i32) (local $ctor_tag_id i32)
    (local $payload_params i32) (local $lowered_subs i32)
    (if (i32.eq (local.get $pat) (i32.const 131))
      (then (return (call $lowpat_make_lpwild (local.get $scrut_h)))))
    (if (i32.lt_u (local.get $pat) (global.get $heap_base))
      (then (unreachable)))
    (local.set $tag (call $tag_of (local.get $pat)))
    (if (i32.eq (local.get $tag) (i32.const 130))
      (then
        ;; repr 0 here (the i32 floor / handle-read default); the PCon arm
        ;; below stamps f64 onto a TFloat payload sub-binder from the ctor scheme.
        (return (call $lowpat_make_lpvar
                  (local.get $scrut_h)
                  (i32.load offset=4 (local.get $pat))
                  (i32.const 0)))))
    (if (i32.eq (local.get $tag) (i32.const 132))
      (then
        (local.set $lit     (i32.load offset=4 (local.get $pat)))
        (local.set $lit_tag (call $tag_of (local.get $lit)))
        (if (i32.eq (local.get $lit_tag) (i32.const 183))
          (then
            (return (call $lowpat_make_lpcon
                      (local.get $scrut_h)
                      (i32.load offset=4 (local.get $lit))
                      (call $make_list (i32.const 0))))))
        ;; Per Hβ.lower.lpat-extract-lit-scalar (2026-05-09): LPLit's
        ;; value field stores the OPAQUE-i32 scalar (LowValue convention
        ;; per Lock #4) — mirroring $lower_lit_int's $walk_const_payload_i32
        ;; pattern. Pre-fix the LV-NODE pointer leaked into the value
        ;; field; emit's `(i32.const $lowpat_lplit_value)` then compared
        ;; the scrutinee against a heap pointer (e.g. 23889432) instead
        ;; of the actual scalar (e.g. 0). list_index's `match tag { 0
        ;; => ... }` failed all arms → unreachable trap.
        ;;
        ;; LV tags 180/181/182 (LVInt/LVFloat/LVString) all store the
        ;; scalar at offset 4 (parser_pat.wat $mk_LVInt etc.). Extract
        ;; uniformly. LVBool (183) handled above as LPCon. LVFloat /
        ;; LVString store str_ptr — opaque-i32 today; named follow-up
        ;; Hβ.lower.lpat-typed-equality routes through (call $str_eq)
        ;; for string patterns at the emit layer.
        (if (i32.or
              (i32.or (i32.eq (local.get $lit_tag) (i32.const 180))  ;; LVInt
                      (i32.eq (local.get $lit_tag) (i32.const 181))) ;; LVFloat
              (i32.eq (local.get $lit_tag) (i32.const 182)))         ;; LVString
          (then
            (return (call $lowpat_make_lplit
                      (local.get $scrut_h)
                      (i32.load offset=4 (local.get $lit))))))
        (return (call $lowpat_make_lplit (local.get $scrut_h) (i32.const 0)))))
    (if (i32.eq (local.get $tag) (i32.const 133))
      (then
        (local.set $name (i32.load offset=4 (local.get $pat)))
        (local.set $subs (i32.load offset=8 (local.get $pat)))
        (local.set $ctor_tag_id (i32.const -1))
        (local.set $payload_params (i32.const 0))
        (local.set $binding (call $env_lookup_ctor (local.get $name)))
        (if (i32.ne (local.get $binding) (i32.const 0))
          (then
            (local.set $kind (call $env_binding_kind (local.get $binding)))
            (if (i32.eq (call $schemekind_tag (local.get $kind)) (i32.const 132))
              (then
                (local.set $ctor_tag_id
                  (call $schemekind_ctor_tag_id (local.get $kind)))
                ;; The payload types ride the ConstructorScheme — the SAME channel
                ;; the nominal-record read and variant-payload offsets use
                ;; ($resolve_field_offset:1128, walk_const.wat:363). An N-ary ctor
                ;; body is TFun(107); its params ARE the payload types. Read them
                ;; live so a TFloat payload's f64 width stamps onto its sub-binder
                ;; below (Carried-Truth: one channel, never a second resolver).
                (local.set $payload_params
                  (call $ctor_payload_params
                    (call $env_binding_scheme (local.get $binding))))))))
        (local.set $lowered_subs (call $lower_pats (local.get $subs) (local.get $scrut_h)))
        (call $stamp_lpcon_sub_reprs (local.get $lowered_subs) (local.get $payload_params))
        (return (call $lowpat_make_lpcon
                  (local.get $scrut_h)
                  (local.get $ctor_tag_id)
                  (local.get $lowered_subs)))))
    (if (i32.eq (local.get $tag) (i32.const 134))
      (then
        (return (call $lowpat_make_lptuple
                  (local.get $scrut_h)
                  (call $lower_pats
                    (i32.load offset=4 (local.get $pat))
                    (local.get $scrut_h))))))
    (if (i32.eq (local.get $tag) (i32.const 135))
      (then
        (local.set $rest_var (i32.const 0))
        (local.set $rest_opt (i32.load offset=8 (local.get $pat)))
        (if (i32.and
              (i32.ge_u (local.get $rest_opt) (global.get $heap_base))
              (i32.eq (call $tag_of (local.get $rest_opt)) (i32.const 1)))
          (then
            ;; `..._` keeps its "_" string: rest_var carries BOTH facts —
            ;; presence (predicate: ge_u, never exact-eq) and bind name.
            ;; Zeroing "_" here conflated "don't bind" with "no rest": the
            ;; predicate then demanded EXACT length and every longer list
            ;; failed all arms (the walk_locals_pat inner floor, faces
            ;; 12-14). The bind side skips "_" instead (emit_control).
            (local.set $rest_var (i32.load offset=4 (local.get $rest_opt)))))
        (return (call $lowpat_make_lplist
                  (local.get $scrut_h)
                  (call $lower_pats
                    (i32.load offset=4 (local.get $pat))
                    (local.get $scrut_h))
                  (local.get $rest_var)))))
    (if (i32.eq (local.get $tag) (i32.const 136))
      (then
        (return (call $lowpat_make_lprecord
                  (local.get $scrut_h)
                  (call $lower_pat_record_fields
                    (i32.load offset=4 (local.get $pat))
                    (i32.const 0)
                    (local.get $scrut_h))
                  (i32.const 0)))))
    ;; PAlt (137) → LPAlt: lower each branch against the same scrutinee.
    (if (i32.eq (local.get $tag) (i32.const 137))
      (then
        (return (call $lowpat_make_lpalt
                  (local.get $scrut_h)
                  (call $lower_pats
                    (i32.load offset=4 (local.get $pat))
                    (local.get $scrut_h))))))
    (unreachable))

  (func $lower_match_arms (param $arms i32) (param $scrut_h i32) (result i32)
    (local $n i32) (local $i i32) (local $buf i32)
    (local $arm i32) (local $pat i32) (local $body_node i32)
    (local $cp i32) (local $lo_body i32) (local $lo_pat i32)
    (local $lparm i32)
    (local.set $n   (call $len (local.get $arms)))
    (local.set $buf (call $make_list (i32.const 0)))
    (local.set $buf (call $list_extend_to (local.get $buf) (local.get $n)))
    (local.set $i   (i32.const 0))
    (block $done
      (loop $each
        (br_if $done (i32.ge_u (local.get $i) (local.get $n)))
        (local.set $arm      (call $list_index (local.get $arms) (local.get $i)))
        (local.set $pat      (call $list_index (local.get $arm) (i32.const 0)))
        (local.set $body_node(call $list_index (local.get $arm) (i32.const 1)))
        (local.set $cp       (call $ls_push_scope))
        (call $bind_pat_locals (local.get $pat) (call $lookup_ty (local.get $scrut_h)))
        (local.set $lo_body  (call $lower_expr (local.get $body_node)))
        (call $ls_pop_scope (local.get $cp))
        (local.set $lo_pat   (call $lower_pat (local.get $pat) (local.get $scrut_h)))
        (local.set $lparm    (call $lowpat_make_lparm (local.get $lo_pat) (local.get $lo_body)))
        (drop (call $list_set (local.get $buf) (local.get $i) (local.get $lparm)))
        (local.set $i (i32.add (local.get $i) (i32.const 1)))
        (br $each)))
    (local.get $buf))

  ;; ─── $lower_binop — BinOpExpr arm (parser tag 86) ──────────────────
  ;; Per src/lower.mn:341-342: BinOpExpr(op, left, right) =>
  ;;   LBinOp(handle, op, lower_expr(left), lower_expr(right)).
  ;; AST per parser_infra.wat:101-107:
  ;;   [tag=86][op][left_node][right_node] offsets 0/4/8/12.
  ;; The op is a BinOp i32 sentinel (BAdd=140..BConcat=153 per
  ;; parser_infra.wat:26 — same nullary-sentinel discipline as
  ;; ResumeDiscipline 250-252; $tag_of(op) returns 140-153 by heap-base
  ;; threshold). Lock-closure for Hβ.lower.binop-arm named follow-up
  ;; surfaced at chunk #9 landing — the wheel src/lower.mn places this
  ;; arm in lower_expr_body alongside UnaryOp; the seed honors the
  ;; pairing here at walk_compound (the §7.1 walkthrough's "walk_const
  ;; owns BinOp" was prose drift; wheel canonical pairs binop+unaryop
  ;; structurally as the two arithmetic-like compound arms).
  (func $lower_binop (export "lower_binop") (param $node i32) (result i32)
    (local $h i32) (local $body i32) (local $binop_struct i32)
    (local $op i32) (local $left_node i32) (local $right_node i32)
    (local $lo_l i32) (local $lo_r i32)
    (local.set $h            (call $walk_expr_node_handle (local.get $node)))
    (local.set $body         (i32.load offset=4 (local.get $node)))
    (local.set $binop_struct (i32.load offset=4 (local.get $body)))
    (local.set $op           (i32.load offset=4 (local.get $binop_struct)))
    (local.set $left_node    (i32.load offset=8 (local.get $binop_struct)))
    (local.set $right_node   (i32.load offset=12 (local.get $binop_struct)))
    (local.set $lo_l         (call $lower_expr (local.get $left_node)))
    (local.set $lo_r         (call $lower_expr (local.get $right_node)))
    (call $lexpr_make_lbinop
      (local.get $h)
      (local.get $op)
      (local.get $lo_l)
      (local.get $lo_r)))

  ;; ─── $lower_unary_op — UnaryOpExpr arm (parser tag 87) ──────────────
  ;; Per src/lower.mn:344-345: UnaryOpExpr(op, inner) =>
  ;;   LUnaryOp(handle, op, lower_expr(inner)).
  ;; AST per Lock #9: [tag=87][op][inner_node] offsets 0/4/8 — op is
  ;; UnaryOp ADT i32 sentinel (UNeg=160 / UNot=161) per src/types.mn
  ;; UnaryOp ADT in 160-179 region. Drift 8 refusal: integer-tag
  ;; sentinel, NOT string-keyed.
  (func $lower_unary_op (export "lower_unary_op") (param $node i32) (result i32)
    (local $h i32) (local $body i32) (local $unary_struct i32)
    (local $op i32) (local $inner_node i32) (local $lo_inner i32)
    (local.set $h            (call $walk_expr_node_handle (local.get $node)))
    (local.set $body         (i32.load offset=4 (local.get $node)))
    (local.set $unary_struct (i32.load offset=4 (local.get $body)))
    (local.set $op           (i32.load offset=4 (local.get $unary_struct)))
    (local.set $inner_node   (i32.load offset=8 (local.get $unary_struct)))
    (local.set $lo_inner     (call $lower_expr (local.get $inner_node)))
    (call $lexpr_make_lunaryop
      (local.get $h)
      (local.get $op)
      (local.get $lo_inner)))

  ;; ─── $lower_if — IfExpr arm (parser tag 90) ──────────────────────────
  ;; Per src/lower.mn:369-372 + Lock #10: each branch is single-element
  ;; list [lo_branch]. AST per parser_infra.wat:119-125:
  ;;   [tag=90][cond_node][then_node][else_node] offsets 0/4/8/12.
  (func $lower_if (export "lower_if") (param $node i32) (result i32)
    (local $h i32) (local $body i32) (local $if_struct i32)
    (local $cond_node i32) (local $then_node i32) (local $else_node i32)
    (local $lo_cond i32) (local $lo_then i32) (local $lo_else i32)
    (local $then_branch i32) (local $else_branch i32)
    (local.set $h          (call $walk_expr_node_handle (local.get $node)))
    (local.set $body       (i32.load offset=4 (local.get $node)))
    (local.set $if_struct  (i32.load offset=4 (local.get $body)))
    (local.set $cond_node  (i32.load offset=4  (local.get $if_struct)))
    (local.set $then_node  (i32.load offset=8  (local.get $if_struct)))
    (local.set $else_node  (i32.load offset=12 (local.get $if_struct)))
    (local.set $lo_cond    (call $lower_expr (local.get $cond_node)))
    (local.set $lo_then    (call $lower_expr (local.get $then_node)))
    (local.set $lo_else    (call $lower_expr (local.get $else_node)))
    ;; Lock #10: single-element branches. Buffer-counter (Ω.3).
    (local.set $then_branch (call $make_list (i32.const 0)))
    (local.set $then_branch (call $list_extend_to (local.get $then_branch) (i32.const 1)))
    (drop (call $list_set (local.get $then_branch) (i32.const 0) (local.get $lo_then)))
    (local.set $else_branch (call $make_list (i32.const 0)))
    (local.set $else_branch (call $list_extend_to (local.get $else_branch) (i32.const 1)))
    (drop (call $list_set (local.get $else_branch) (i32.const 0) (local.get $lo_else)))
    (call $lexpr_make_lif
      (local.get $h)
      (local.get $lo_cond)
      (local.get $then_branch)
      (local.get $else_branch)))

  ;; ─── $lower_block — BlockExpr arm (parser tag 91) ────────────────────
  ;; Per src/lower.mn:374-380 + Lock #2 (seed lowers final_expr only).
  ;; AST per parser_infra.wat:128-133:
  ;;   [tag=91][stmts_list][final_expr_node] offsets 0/4/8.
  ;; A destructure-let is a `match` by the time it reaches here — the parser's
  ;; $desugar_block splits the block at the node's birth, so LetStmt is PVar-only
  ;; and lowering simply walks stmts + final. (protocol_one_graph_two_operations.)
  (func $lower_block (export "lower_block") (param $node i32) (result i32)
    (local $h i32) (local $body i32) (local $block_struct i32)
    (local $stmt_nodes i32) (local $final_node i32)
    (local $cp i32) (local $lo_stmts i32) (local $lo_final i32)
    (local $stmts i32) (local $n i32) (local $i i32)
    (local.set $h            (call $walk_expr_node_handle (local.get $node)))
    (local.set $body         (i32.load offset=4 (local.get $node)))
    (local.set $block_struct (i32.load offset=4 (local.get $body)))
    (local.set $stmt_nodes   (i32.load offset=4 (local.get $block_struct)))
    (local.set $final_node   (i32.load offset=8 (local.get $block_struct)))
    (local.set $cp           (call $ls_push_scope))
    (local.set $lo_stmts     (call $lower_stmt_list (local.get $stmt_nodes)))
    (local.set $lo_final     (call $lower_expr (local.get $final_node)))
    (call $ls_pop_scope (local.get $cp))
    (local.set $n     (call $len (local.get $lo_stmts)))
    (local.set $stmts (call $make_list (i32.const 0)))
    (local.set $stmts (call $list_extend_to (local.get $stmts)
                        (i32.add (local.get $n) (i32.const 1))))
    (local.set $i (i32.const 0))
    (block $copy_done
      (loop $copy
        (br_if $copy_done (i32.ge_u (local.get $i) (local.get $n)))
        (drop (call $list_set (local.get $stmts) (local.get $i)
                (call $list_index (local.get $lo_stmts) (local.get $i))))
        (local.set $i (i32.add (local.get $i) (i32.const 1)))
        (br $copy)))
    (drop (call $list_set (local.get $stmts) (local.get $n) (local.get $lo_final)))
    (call $lexpr_make_lblock
      (local.get $h)
      (local.get $stmts)))

  ;; ─── $lower_match — MatchExpr arm (parser tag 92) ────────────────────
  ;; Per src/lower.mn:382-383 + Lock #3 (seed arms list empty pending
  ;; pattern substrate). AST per parser_infra.wat:136-141:
  ;;   [tag=92][scrut_node][arms_list] offsets 0/4/8.
  (func $lower_match (export "lower_match") (param $node i32) (result i32)
    (local $h i32) (local $body i32) (local $match_struct i32)
    (local $scrut_node i32) (local $arms_list i32)
    (local $scrut_h i32) (local $lo_scrut i32) (local $arms i32)
    (local.set $h            (call $walk_expr_node_handle (local.get $node)))
    (local.set $body         (i32.load offset=4 (local.get $node)))
    (local.set $match_struct (i32.load offset=4 (local.get $body)))
    (local.set $scrut_node   (i32.load offset=4 (local.get $match_struct)))
    (local.set $arms_list    (i32.load offset=8 (local.get $match_struct)))
    (local.set $scrut_h      (call $walk_expr_node_handle (local.get $scrut_node)))
    (local.set $lo_scrut     (call $lower_expr (local.get $scrut_node)))
    (local.set $arms         (call $lower_match_arms (local.get $arms_list) (local.get $scrut_h)))
    (call $lexpr_make_lmatch
      (local.get $h)
      (local.get $lo_scrut)
      (local.get $arms)))

  ;; ─── $lower_make_list — MakeListExpr arm (parser tag 96) ─────────────
  ;; Per src/lower.mn:385-386: MakeListExpr(elems) =>
  ;;   LMakeList(handle, lower_expr_list(elems)).
  ;; AST per parser_compound.wat:77-81: [tag=96][elems_list] offsets 0/4.
  (func $lower_make_list (export "lower_make_list") (param $node i32) (result i32)
    (local $h i32) (local $body i32) (local $list_struct i32)
    (local $elems i32) (local $lo_elems i32)
    (local.set $h           (call $walk_expr_node_handle (local.get $node)))
    (local.set $body        (i32.load offset=4 (local.get $node)))
    (local.set $list_struct (i32.load offset=4 (local.get $body)))
    (local.set $elems       (i32.load offset=4 (local.get $list_struct)))
    (local.set $lo_elems    (call $lower_expr_list_compound (local.get $elems)))
    (call $lexpr_make_lmakelist
      (local.get $h)
      (local.get $lo_elems)))

  ;; ─── $lower_make_string — MakeStringExpr arm (parser tag 103) ────────
  ;; Per src/lower.mn lower_string_interpolation (:1788-1799): empty →
  ;; LConst(h, ""); singleton → that fragment unchanged; else LEFT-FOLD
  ;; of LCall(h, LGlobal(h, "str_concat"), [acc, frag]) — every fold
  ;; node reuses the MakeStringExpr node's handle, exactly as the wheel
  ;; does (fixpoint parity: $call_<H> scratch names must match m3).
  (data (i32.const 6560) "\0a\00\00\00str_concat")
  (func $lower_make_string (export "lower_make_string") (param $node i32) (result i32)
    (local $h i32) (local $body i32) (local $frag_struct i32)
    (local $frags i32) (local $lo_frags i32)
    (local $n i32) (local $i i32) (local $acc i32) (local $args i32)
    (local.set $h           (call $walk_expr_node_handle (local.get $node)))
    (local.set $body        (i32.load offset=4 (local.get $node)))
    (local.set $frag_struct (i32.load offset=4 (local.get $body)))
    (local.set $frags       (i32.load offset=4 (local.get $frag_struct)))
    ;; Empty literal fragments (LitString "" — the alternation edges)
    ;; elide before lowering; mirrors the wheel's is_empty_lconst_string
    ;; filter in lower_string_interpolation (identical elision set —
    ;; fixpoint parity; canonical form IS the efficient form).
    (local.set $lo_frags (call $make_list (i32.const 0)))
    (local.set $n (call $len (local.get $frags)))
    (local.set $i (i32.const 0))
    (local.set $acc (i32.const 0))   ;; reused as kept-count
    (block $filtered
      (loop $keep
        (br_if $filtered (i32.ge_u (local.get $i) (local.get $n)))
        (local.set $args (call $list_index (local.get $frags) (local.get $i)))   ;; frag node
        (local.set $body (i32.load offset=4 (local.get $args)))                  ;; node body
        (if (i32.eqz (i32.and
              (i32.eq (i32.load (local.get $body)) (i32.const 82))               ;; LitString
              (i32.eqz (call $byte_len (i32.load offset=4 (local.get $body))))))
          (then
            (local.set $lo_frags (call $list_extend_to (local.get $lo_frags)
              (i32.add (local.get $acc) (i32.const 1))))
            (drop (call $list_set (local.get $lo_frags) (local.get $acc)
              (call $lower_expr (local.get $args))))
            (local.set $acc (i32.add (local.get $acc) (i32.const 1)))))
        (local.set $i (i32.add (local.get $i) (i32.const 1)))
        (br $keep)))
    (local.set $lo_frags (call $slice (local.get $lo_frags) (i32.const 0) (local.get $acc)))
    (local.set $n (call $len (local.get $lo_frags)))
    (if (i32.eqz (local.get $n))
      (then (return (call $lexpr_make_lconst (local.get $h)
                          (call $str_alloc (i32.const 0))))))
    (local.set $acc (call $list_index (local.get $lo_frags) (i32.const 0)))
    (local.set $i (i32.const 1))
    (block $done
      (loop $fold
        (br_if $done (i32.ge_u (local.get $i) (local.get $n)))
        (local.set $args (call $make_list (i32.const 0)))
        (local.set $args (call $list_extend_to (local.get $args) (i32.const 2)))
        (drop (call $list_set (local.get $args) (i32.const 0) (local.get $acc)))
        (drop (call $list_set (local.get $args) (i32.const 1)
          (call $list_index (local.get $lo_frags) (local.get $i))))
        (local.set $acc (call $lexpr_make_lcall (local.get $h)
          (call $lexpr_make_lglobal (local.get $h) (i32.const 6560))   ;; "str_concat"
          (local.get $args)))
        (local.set $i (i32.add (local.get $i) (i32.const 1)))
        (br $fold)))
    (local.get $acc))

  ;; ─── $lower_make_tuple — MakeTupleExpr arm (parser tag 97) ───────────
  ;; Per src/lower.mn:388-389: MakeTupleExpr(elems) =>
  ;;   LMakeTuple(handle, lower_expr_list(elems)).
  ;; AST per parser_compound.wat:70-74: [tag=97][elems_list] offsets 0/4.
  (func $lower_make_tuple (export "lower_make_tuple") (param $node i32) (result i32)
    (local $h i32) (local $body i32) (local $tup_struct i32)
    (local $elems i32) (local $lo_elems i32)
    (local.set $h          (call $walk_expr_node_handle (local.get $node)))
    (local.set $body       (i32.load offset=4 (local.get $node)))
    (local.set $tup_struct (i32.load offset=4 (local.get $body)))
    (local.set $elems      (i32.load offset=4 (local.get $tup_struct)))
    (local.set $lo_elems   (call $lower_expr_list_compound (local.get $elems)))
    (call $lexpr_make_lmaketuple
      (local.get $h)
      (local.get $lo_elems)))

  ;; ─── $lower_make_record — MakeRecordExpr arm (parser tag 98) ─────────
  ;; Per src/lower.mn:391-392 + Lock #6: MakeRecordExpr(fields) =>
  ;;   LMakeRecord(handle, lower_record_field_values(fields)).
  ;; AST per Lock #9: [tag=98][fields_list] offsets 0/4. Each fields-list
  ;; element is pair-record (name=0, value=4) per Lock #6.
  (func $lower_make_record (export "lower_make_record") (param $node i32) (result i32)
    (local $h i32) (local $body i32) (local $rec_struct i32)
    (local $fields i32) (local $lo_fields i32)
    (local.set $h          (call $walk_expr_node_handle (local.get $node)))
    (local.set $body       (i32.load offset=4 (local.get $node)))
    (local.set $rec_struct (i32.load offset=4 (local.get $body)))
    (local.set $fields     (i32.load offset=4 (local.get $rec_struct)))
    (local.set $lo_fields  (call $lower_record_field_values (local.get $fields)))
    (call $lexpr_make_lmakerecord
      (local.get $h)
      (local.get $lo_fields)))

  ;; ─── $lower_named_record — NamedRecordExpr arm (parser tag 99) ───────
  ;; Per src/lower.mn:394-399 + Lock #5 (H2.3 collapse — type_name discarded
  ;; at lower-time; runtime sees raw fields). AST per Lock #9:
  ;;   [tag=99][type_name_str][fields_list] offsets 0/4/8.
  (func $lower_named_record (export "lower_named_record") (param $node i32) (result i32)
    (local $h i32) (local $body i32) (local $named_struct i32)
    (local $fields i32) (local $lo_fields i32)
    (local.set $h            (call $walk_expr_node_handle (local.get $node)))
    (local.set $body         (i32.load offset=4 (local.get $node)))
    (local.set $named_struct (i32.load offset=4 (local.get $body)))
    ;; type_name at offset 4 — Lock #5 H2.3 discards (drift-8 closure:
    ;; threaded-not-compared). fields_list at offset 8.
    (local.set $fields       (i32.load offset=8 (local.get $named_struct)))
    (local.set $lo_fields    (call $lower_record_field_values (local.get $fields)))
    (call $lexpr_make_lmakerecord
      (local.get $h)
      (local.get $lo_fields)))

  ;; ─── $lower_field — FieldExpr arm (parser tag 100) ───────────────────
  ;; Per src/lower.mn:450-461. AST per Lock #9:
  ;;   [tag=100][rec_node][field_name_str] offsets 0/4/8.
  ;; ULTIMATE FORM: resolve field byte offset from graph type via
  ;; $resolve_field_offset. Closes Lock #4 (Hβ.lower.field-offset-resolution).
  ;; Per protocol_handler_is_state_is_closure_is_evidence.md: sorted-by-name
  ;; field layout at 4*i. The graph carries what it should carry.
  (func $lower_field (export "lower_field") (param $node i32) (result i32)
    (local $h i32) (local $body i32) (local $field_struct i32)
    (local $rec_node i32) (local $field_name i32)
    (local $lo_rec i32) (local $rec_h i32) (local $offset i32)
    (local.set $h            (call $walk_expr_node_handle (local.get $node)))
    (local.set $body         (i32.load offset=4 (local.get $node)))
    (local.set $field_struct (i32.load offset=4 (local.get $body)))
    (local.set $rec_node     (i32.load offset=4 (local.get $field_struct)))
    (local.set $field_name   (i32.load offset=8 (local.get $field_struct)))
    (local.set $rec_h        (call $walk_expr_node_handle (local.get $rec_node)))
    (local.set $lo_rec       (call $lower_expr (local.get $rec_node)))
    (local.set $offset       (call $resolve_field_offset
                               (local.get $rec_h)
                               (local.get $field_name)))
    (call $lexpr_make_lfieldload
      (local.get $h)
      (local.get $lo_rec)
      (local.get $offset)))

  ;; $resolve_field_offset — per src/lower.mn:1052-1071.
  ;; lookup_ty(rec_handle) → TRecord/TRecordOpen → walk fields list.
  ;; TName → chase env to RecordSchemeKind. TVar → recurse on inner handle.
  ;; Fallback 0.
  ;; The graph carries what it should carry — field offset IS graph-resident.
  ;; $resolve_field_offset_from_ty — given a Ty, find the field offset.
  ;; Chases TVar chains, dispatches on TRecord/TRecordOpen/TName.
  (func $resolve_field_offset_from_ty
        (param $ty i32) (param $field_name i32) (result i32)
    (local $tag i32) (local $fields i32)
    (local $binding i32) (local $kind i32)
    (local $ctor_body i32) (local $ctor_params i32) (local $ctor_pty i32)
    (local.set $tag (call $ty_tag (local.get $ty)))
    ;; TVar (104) — chase to inner handle, then resolve from that handle.
    (if (i32.eq (local.get $tag) (i32.const 104))
      (then
        (return_call $resolve_field_offset
          (call $ty_tvar_handle (local.get $ty))
          (local.get $field_name))))
    ;; TRecord (109) — FULL field list → correct offset.
    (if (i32.eq (local.get $tag) (i32.const 109))
      (then
        (local.set $fields (call $ty_trecord_fields (local.get $ty)))
        (return (call $field_byte_offset
                  (local.get $fields) (local.get $field_name)
                  (i32.const 0) (call $len (local.get $fields))))))
    ;; TRecordOpen (110) — PARTIAL field list + rowvar. Chase the rowvar
    ;; to get the residual fields (TRecord from unification). Merge the
    ;; two field lists (both alphabetically sorted) to reconstruct the
    ;; FULL record shape. The graph carries what it should carry.
    (if (i32.eq (local.get $tag) (i32.const 110))
      (then
        (return (call $resolve_from_record_open
                  (local.get $ty) (local.get $field_name)))))
    ;; TName (108) — chase env. Two homes for the record shape:
    ;;   RecordSchemeKind (134) — the direct registration, when present.
    ;;   ConstructorScheme (132) — the nominal-record encoding: `type X =
    ;;   {…}` parses as the single-variant ctor `X : TRecord(fields) ->
    ;;   TName(X)`, so the ctor's scheme ALREADY carries the field list.
    ;;   Read the fact where it lives (Carried-Truth) — never mint a
    ;;   second registration that would shadow-fight the ctor binding.
    (if (i32.eq (local.get $tag) (i32.const 108))
      (then
        (local.set $binding (call $env_lookup_value (call $ty_tname_name (local.get $ty))))
        (if (i32.ne (local.get $binding) (i32.const 0))
          (then
            (local.set $kind (call $env_binding_kind (local.get $binding)))
            ;; RecordSchemeKind tag = 134 per env.wat:80.
            (if (i32.eq (call $schemekind_tag (local.get $kind)) (i32.const 134))
              (then
                (local.set $fields (call $schemekind_record_fields (local.get $kind)))
                (return (call $field_byte_offset
                          (local.get $fields) (local.get $field_name)
                          (i32.const 0) (call $len (local.get $fields))))))
            ;; ConstructorScheme (132): scheme body TFun(107) with ONE
            ;; param whose ty is TRecord(109) — the nominal record.
            (if (i32.eq (call $schemekind_tag (local.get $kind)) (i32.const 132))
              (then
                (local.set $ctor_body
                  (call $scheme_body (call $env_binding_scheme (local.get $binding))))
                (if (i32.eq (call $ty_tag (local.get $ctor_body)) (i32.const 107))
                  (then
                    (local.set $ctor_params (call $ty_tfun_params (local.get $ctor_body)))
                    (if (i32.eq (call $len (local.get $ctor_params)) (i32.const 1))
                      (then
                        (local.set $ctor_pty
                          (call $tparam_ty (call $list_index (local.get $ctor_params) (i32.const 0))))
                        (if (i32.eq (call $ty_tag (local.get $ctor_pty)) (i32.const 109))
                          (then
                            (local.set $fields (call $ty_trecord_fields (local.get $ctor_pty)))
                            (return (call $field_byte_offset
                                      (local.get $fields) (local.get $field_name)
                                      (i32.const 0) (call $len (local.get $fields))))))))))))))))
    ;; NO silent fallback: a field whose receiver type is non-record / unresolved
    ;; returns -1, and $emit_lfieldload (offset < 0) emits a LOUD (unreachable) —
    ;; never a silent offset-0 read of the node's word 0 (a graph pointer) that
    ;; wat_emit then dumps (the emit corruption). Mirrors src/lower.mn.
    (i32.const -1))

  ;; $resolve_field_offset — directly chase the graph to find the REAL
  ;; Ty, bypassing $lookup_ty which converts NFree to terror_hole.
  ;; After unification, a handle that was NFree might now be
  ;; NBound(TVar(other_h)) → chase through that TVar to find TRecord.
  ;; ═══ Field accumulator ═══════════════════════════════════════════
  ;; ULTIMATE SUBSTRATE: the graph carries partial TRecordOpen types,
  ;; but row composition is incomplete at the seed. To reconstruct
  ;; the FULL sorted field list, the inference side records every
  ;; field access per record handle. At lower time, the accumulated
  ;; fields give the complete alphabetical layout.
  ;;
  ;; Storage: parallel flat arrays (handles[] + field_lists[]).
  ;; $fa_record_field(handle, field_name) — inference calls this.
  ;; $fa_lookup_fields(handle) — lower calls this, gets sorted field list.
  (global $fa_handles_ptr (mut i32) (i32.const 0))
  (global $fa_fields_ptr  (mut i32) (i32.const 0))
  (global $fa_len         (mut i32) (i32.const 0))
  (global $fa_initialized (mut i32) (i32.const 0))

  (func $fa_init
    (if (global.get $fa_initialized) (then (return)))
    (global.set $fa_handles_ptr (call $make_list (i32.const 64)))
    (global.set $fa_fields_ptr  (call $make_list (i32.const 64)))
    (global.set $fa_len         (i32.const 0))
    (global.set $fa_initialized (i32.const 1)))

  ;; $fa_find_slot — find the index for a given handle. Returns -1 if not found.
  (func $fa_find_slot (param $handle i32) (result i32)
    (local $i i32) (local $n i32)
    (call $fa_init)
    (local.set $n (global.get $fa_len))
    (local.set $i (i32.const 0))
    (block $done
      (loop $scan
        (br_if $done (i32.ge_u (local.get $i) (local.get $n)))
        (if (i32.eq (call $list_index (global.get $fa_handles_ptr) (local.get $i))
                    (local.get $handle))
          (then (return (local.get $i))))
        (local.set $i (i32.add (local.get $i) (i32.const 1)))
        (br $scan)))
    (i32.const -1))

  ;; $fa_record_field — called by FieldExpr inference. Records that
  ;; `handle` has field `field_name`. Inserts into sorted field list.
  (func $fa_record_field (export "fa_record_field")
        (param $handle i32) (param $field_name i32)
    (local $slot i32) (local $fields i32) (local $n i32)
    (local $i i32) (local $existing i32) (local $cmp i32)
    (local $new_fields i32) (local $j i32)
    (call $fa_init)
    (local.set $slot (call $fa_find_slot (local.get $handle)))
    (if (i32.eq (local.get $slot) (i32.const -1))
      (then
        ;; New handle — create entry.
        (local.set $slot (global.get $fa_len))
        (global.set $fa_handles_ptr
          (call $list_set
            (call $list_extend_to (global.get $fa_handles_ptr)
              (i32.add (local.get $slot) (i32.const 1)))
            (local.get $slot) (local.get $handle)))
        (global.set $fa_fields_ptr
          (call $list_set
            (call $list_extend_to (global.get $fa_fields_ptr)
              (i32.add (local.get $slot) (i32.const 1)))
            (local.get $slot) (call $make_list (i32.const 4))))
        (global.set $fa_len (i32.add (global.get $fa_len) (i32.const 1)))))
    ;; Get current fields list.
    (local.set $fields (call $list_index (global.get $fa_fields_ptr) (local.get $slot)))
    (local.set $n (call $len (local.get $fields)))
    ;; Find sorted insertion point; skip if already present.
    (local.set $i (i32.const 0))
    (block $insert_done
      (loop $find_pos
        (br_if $insert_done (i32.ge_u (local.get $i) (local.get $n)))
        (local.set $existing
          (call $list_index (local.get $fields) (local.get $i)))
        (local.set $cmp (call $str_compare (local.get $field_name) (local.get $existing)))
        ;; Already present — done.
        (if (i32.eqz (local.get $cmp)) (then (return)))
        ;; field_name < existing — insert here.
        (if (i32.eq (local.get $cmp) (i32.const -1))
          (then (br $insert_done)))
        (local.set $i (i32.add (local.get $i) (i32.const 1)))
        (br $find_pos)))
    ;; Insert at position $i: shift elements right, then set.
    (local.set $new_fields
      (call $list_extend_to (local.get $fields)
        (i32.add (local.get $n) (i32.const 1))))
    ;; Shift from end down to $i.
    (local.set $j (local.get $n))
    (block $shift_done
      (loop $shift
        (br_if $shift_done (i32.le_u (local.get $j) (local.get $i)))
        (drop (call $list_set (local.get $new_fields) (local.get $j)
          (call $list_index (local.get $new_fields)
            (i32.sub (local.get $j) (i32.const 1)))))
        (local.set $j (i32.sub (local.get $j) (i32.const 1)))
        (br $shift)))
    ;; Place field_name at position $i.
    (drop (call $list_set (local.get $new_fields) (local.get $i)
      (local.get $field_name)))
    ;; Update the stored fields list (list_set may have reallocated).
    (drop (call $list_set (global.get $fa_fields_ptr) (local.get $slot)
      (local.get $new_fields))))

  ;; $fa_lookup_fields — returns the accumulated sorted field name list
  ;; for a handle. Returns 0 if handle not found.
  (func $fa_lookup_fields (export "fa_lookup_fields")
        (param $handle i32) (result i32)
    (local $slot i32)
    (call $fa_init)
    (local.set $slot (call $fa_find_slot (local.get $handle)))
    (if (i32.eq (local.get $slot) (i32.const -1))
      (then (return (i32.const 0))))
    (call $list_index (global.get $fa_fields_ptr) (local.get $slot)))

  ;; $fa_field_byte_offset — given a sorted field name list (strings,
  ;; not field_pairs), find the target and return 4*i.
  (func $fa_field_byte_offset
        (param $names i32) (param $target i32)
        (param $i i32) (param $n i32) (result i32)
    (if (i32.ge_u (local.get $i) (local.get $n))
      (then (return (i32.const -1))))   ;; NO silent 0 — an absent field is an unprovable offset
    (if (call $str_eq (call $list_index (local.get $names) (local.get $i))
                      (local.get $target))
      (then (return (i32.mul (local.get $i) (i32.const 4)))))
    (return_call $fa_field_byte_offset
      (local.get $names) (local.get $target)
      (i32.add (local.get $i) (i32.const 1)) (local.get $n)))

  ;; $resolve_field_offset — ULTIMATE FORM. The graph carries the full
  ;; truth. $graph_bind_row composes row residuals instead of overwriting,
  ;; so TRecordOpen's rowvar accumulates ALL residual fields. Chase the
  ;; graph, dispatch on Ty tag, resolve offset.
  (func $resolve_field_offset (param $rec_handle i32) (param $field_name i32) (result i32)
    (local $g i32) (local $nk i32) (local $tag i32) (local $ty i32)
    (local.set $g (call $graph_chase (local.get $rec_handle)))
    (local.set $nk (call $gnode_kind (local.get $g)))
    (local.set $tag (call $node_kind_tag (local.get $nk)))
    ;; NBound (60) — has a Ty payload, resolve from it.
    (if (i32.eq (local.get $tag) (i32.const 60))
      (then
        (local.set $ty (call $node_kind_payload (local.get $nk)))
        (return (call $resolve_field_offset_from_ty
                  (local.get $ty) (local.get $field_name)))))
    (if (i32.eq (local.get $tag) (i32.const 62))
      (then
        (local.set $ty (call $node_kind_payload (local.get $nk)))
        (return (call $resolve_field_offset_from_ty
                  (local.get $ty) (local.get $field_name)))))
    ;; NFree (61) — truly unresolved. NErrorHole (64) — error. NO silent
    ;; fallback: return -1 so $emit_lfieldload (offset < 0) emits a LOUD
    ;; (unreachable) instead of a silent offset-0 read of the node's word 0 (a
    ;; graph pointer) that wat_emit then dumps as the heap (the emit corruption).
    ;; The loud trap NAMES the unresolved receiver. Mirrors src/lower.mn.
    (i32.const -1))

  ;; $fa_collect_fields — scan ALL accumulator entries. For each entry,
  ;; chase its recorded handle (graph is complete at lower time) to
  ;; the canonical terminal. If it matches $target_canonical, merge
  ;; that entry's fields into the result. Returns a sorted field name
  ;; list with all fields from all matching entries, or 0 if none found.
  (func $fa_collect_fields (param $target_canonical i32) (result i32)
    (local $i i32) (local $n i32) (local $entry_h i32) (local $entry_canonical i32)
    (local $entry_fields i32) (local $result i32)
    (local $j i32) (local $fn i32) (local $fn_n i32)
    (call $fa_init)
    (local.set $n (global.get $fa_len))
    (local.set $result (i32.const 0))
    (local.set $i (i32.const 0))
    (block $done
      (loop $scan
        (br_if $done (i32.ge_u (local.get $i) (local.get $n)))
        (local.set $entry_h
          (call $list_index (global.get $fa_handles_ptr) (local.get $i)))
        (local.set $entry_canonical
          (call $graph_chase_handle (local.get $entry_h)))
        (if (i32.eq (local.get $entry_canonical) (local.get $target_canonical))
          (then
            ;; This entry's handle resolves to the same variable.
            ;; Merge its fields into result.
            (local.set $entry_fields
              (call $list_index (global.get $fa_fields_ptr) (local.get $i)))
            (if (i32.eqz (local.get $result))
              (then
                ;; First match — clone the fields list.
                (local.set $result (call $fa_clone_fields (local.get $entry_fields))))
              (else
                ;; Subsequent match — merge into result.
                (local.set $fn_n (call $len (local.get $entry_fields)))
                (local.set $j (i32.const 0))
                (block $merge_done
                  (loop $merge
                    (br_if $merge_done (i32.ge_u (local.get $j) (local.get $fn_n)))
                    (local.set $fn
                      (call $list_index (local.get $entry_fields) (local.get $j)))
                    (local.set $result
                      (call $fa_insert_sorted (local.get $result) (local.get $fn)))
                    (local.set $j (i32.add (local.get $j) (i32.const 1)))
                    (br $merge)))))))
        (local.set $i (i32.add (local.get $i) (i32.const 1)))
        (br $scan)))
    (local.get $result))

  ;; $fa_clone_fields — shallow clone a field name list.
  (func $fa_clone_fields (param $src i32) (result i32)
    (local $n i32) (local $out i32) (local $i i32)
    (local.set $n (call $len (local.get $src)))
    (local.set $out (call $make_list (local.get $n)))
    (local.set $out (call $list_extend_to (local.get $out) (local.get $n)))
    (local.set $i (i32.const 0))
    (block $done
      (loop $copy
        (br_if $done (i32.ge_u (local.get $i) (local.get $n)))
        (drop (call $list_set (local.get $out) (local.get $i)
          (call $list_index (local.get $src) (local.get $i))))
        (local.set $i (i32.add (local.get $i) (i32.const 1)))
        (br $copy)))
    (local.get $out))

  ;; $fa_insert_sorted — insert a field name into a sorted list,
  ;; skipping if already present. Returns the (possibly reallocated) list.
  (func $fa_insert_sorted (param $list i32) (param $name i32) (result i32)
    (local $n i32) (local $i i32) (local $existing i32) (local $cmp i32)
    (local $new_list i32) (local $j i32)
    (local.set $n (call $len (local.get $list)))
    (local.set $i (i32.const 0))
    (block $found_pos
      (loop $scan
        (br_if $found_pos (i32.ge_u (local.get $i) (local.get $n)))
        (local.set $existing (call $list_index (local.get $list) (local.get $i)))
        (local.set $cmp (call $str_compare (local.get $name) (local.get $existing)))
        (if (i32.eqz (local.get $cmp)) (then (return (local.get $list))))
        (if (i32.eq (local.get $cmp) (i32.const -1))
          (then (br $found_pos)))
        (local.set $i (i32.add (local.get $i) (i32.const 1)))
        (br $scan)))
    ;; Insert at position $i.
    (local.set $new_list
      (call $list_extend_to (local.get $list)
        (i32.add (local.get $n) (i32.const 1))))
    (local.set $j (local.get $n))
    (block $shift_done
      (loop $shift
        (br_if $shift_done (i32.le_u (local.get $j) (local.get $i)))
        (drop (call $list_set (local.get $new_list) (local.get $j)
          (call $list_index (local.get $new_list)
            (i32.sub (local.get $j) (i32.const 1)))))
        (local.set $j (i32.sub (local.get $j) (i32.const 1)))
        (br $shift)))
    (drop (call $list_set (local.get $new_list) (local.get $i) (local.get $name)))
    (local.get $new_list))

  ;; $field_byte_offset — per src/lower.mn:1074-1081.
  ;; Linear scan of sorted fields list. Each entry is (name, ty) pair;
  ;; name at list_index(fields, i) then record_get offset 0.
  ;; Returns 4*i when str_eq(name, target). Tail-recursive.
  (func $field_byte_offset
        (param $fields i32) (param $target i32)
        (param $i i32) (param $n i32) (result i32)
    (local $entry i32) (local $name i32)
    ;; field-not-found → -1 (the loud floor; LFieldLoad emit guards <0 ->
    ;; (unreachable)). field_byte_offset itself is CORRECT (probe-confirmed:
    ;; it reads real field_pair names and finds the target at 4*i for
    ;; multi-field records — the old "collapses to 0" comment was stale).
    (if (i32.ge_u (local.get $i) (local.get $n))
      (then (return (i32.const -1))))
    (local.set $entry (call $list_index (local.get $fields) (local.get $i)))
    (local.set $name (call $field_pair_name (local.get $entry)))
    (if (call $str_eq (local.get $name) (local.get $target))
      (then (return (i32.mul (local.get $i) (i32.const 4)))))
    (return_call $field_byte_offset
      (local.get $fields) (local.get $target)
      (i32.add (local.get $i) (i32.const 1)) (local.get $n)))

  ;; $resolve_from_record_open — chase TRecordOpen's rowvar to get the
  ;; full field list. The rowvar, after unification with a TRecord,
  ;; holds NRowBound(TRecord(residual_fields)). Merge the partial
  ;; fields with the residual to reconstruct the FULL sorted field list.
  ;; The graph carries what it should carry.
  (func $resolve_from_record_open
        (param $trecordopen i32) (param $field_name i32) (result i32)
    (local $partial i32) (local $rowvar_h i32)
    (local $g i32) (local $nk i32) (local $nk_tag i32)
    (local $row_ty i32) (local $row_tag i32)
    (local $residual i32) (local $merged i32)
    ;; Get partial fields and rowvar handle.
    (local.set $partial (call $ty_trecordopen_fields (local.get $trecordopen)))
    (local.set $rowvar_h (call $ty_trecordopen_rowvar (local.get $trecordopen)))
    ;; CARRIED-TRUTH: read the union-find ROOT's node. graph_chase is the Tier-3
    ;; base that stops short of transitive TVar/row aliases; graph_chase_handle
    ;; follows the full chain to the canonical, where the install bound the
    ;; residual. Read by identity (root), never the incomplete direct chase.
    (local.set $g (call $graph_node_at (call $graph_chase_handle (local.get $rowvar_h))))
    (local.set $nk (call $gnode_kind (local.get $g)))
    (local.set $nk_tag (call $node_kind_tag (local.get $nk)))
    ;; NRowBound (62) — payload is the residual Ty (TRecord).
    (if (i32.eq (local.get $nk_tag) (i32.const 62))
      (then
        (local.set $row_ty (call $node_kind_payload (local.get $nk)))
        (local.set $row_tag (call $ty_tag (local.get $row_ty)))
        ;; If residual is TRecord (109), merge fields.
        (if (i32.eq (local.get $row_tag) (i32.const 109))
          (then
            (local.set $residual (call $ty_trecord_fields (local.get $row_ty)))
            (local.set $merged (call $merge_sorted_fields
                                 (local.get $partial) (local.get $residual)))
            (return (call $field_byte_offset
                      (local.get $merged) (local.get $field_name)
                      (i32.const 0) (call $len (local.get $merged))))))))
    ;; NRowFree (63) — row not yet resolved → the FULL field list is unknown,
    ;; so NO offset is provable (a residual field could sort before this one).
    ;; Return -1 (loud (unreachable) at emit), never a silent 0 that reads word 0
    ;; (a graph pointer). Mirrors src/lower.mn's no-silent-fallback discipline.
    (i32.const -1))

  ;; $merge_sorted_fields — merge two alphabetically-sorted field-pair
  ;; lists into one. Both inputs are List of field_pair records (tag 203)
  ;; with name at record_get(entry, 0). Standard sorted merge.
  (func $merge_sorted_fields
        (param $a i32) (param $b i32) (result i32)
    (local $na i32) (local $nb i32) (local $total i32)
    (local $ia i32) (local $ib i32) (local $out_i i32)
    (local $out i32)
    (local $ea i32) (local $eb i32)
    (local $name_a i32) (local $name_b i32)
    (local.set $na (call $len (local.get $a)))
    (local.set $nb (call $len (local.get $b)))
    (local.set $total (i32.add (local.get $na) (local.get $nb)))
    (local.set $out (call $make_list (local.get $total)))
    (local.set $out (call $list_extend_to (local.get $out) (local.get $total)))
    (local.set $ia (i32.const 0))
    (local.set $ib (i32.const 0))
    (local.set $out_i (i32.const 0))
    (block $done
      (loop $merge
        (br_if $done (i32.ge_u (local.get $out_i) (local.get $total)))
        ;; If a exhausted, take from b.
        (if (i32.ge_u (local.get $ia) (local.get $na))
          (then
            (drop (call $list_set (local.get $out) (local.get $out_i)
              (call $list_index (local.get $b) (local.get $ib))))
            (local.set $ib (i32.add (local.get $ib) (i32.const 1)))
            (local.set $out_i (i32.add (local.get $out_i) (i32.const 1)))
            (br $merge)))
        ;; If b exhausted, take from a.
        (if (i32.ge_u (local.get $ib) (local.get $nb))
          (then
            (drop (call $list_set (local.get $out) (local.get $out_i)
              (call $list_index (local.get $a) (local.get $ia))))
            (local.set $ia (i32.add (local.get $ia) (i32.const 1)))
            (local.set $out_i (i32.add (local.get $out_i) (i32.const 1)))
            (br $merge)))
        ;; Both have elements — compare names.
        (local.set $ea (call $list_index (local.get $a) (local.get $ia)))
        (local.set $eb (call $list_index (local.get $b) (local.get $ib)))
        (local.set $name_a (call $field_pair_name (local.get $ea)))
        (local.set $name_b (call $field_pair_name (local.get $eb)))
        (if (i32.eq (call $str_compare (local.get $name_a) (local.get $name_b))
                    (i32.const -1))
          (then
            (drop (call $list_set (local.get $out) (local.get $out_i) (local.get $ea)))
            (local.set $ia (i32.add (local.get $ia) (i32.const 1))))
          (else
            (drop (call $list_set (local.get $out) (local.get $out_i) (local.get $eb)))
            (local.set $ib (i32.add (local.get $ib) (i32.const 1)))))
        (local.set $out_i (i32.add (local.get $out_i) (i32.const 1)))
        (br $merge)))
    (local.get $out))

  ;; ─── $lower_lambda — LambdaExpr arm (parser tag 89) ──────────────────
  ;; Per src/lower.mn:402-428 + H.2.e lambda-capture-substrate.
  ;;
  ;; Pipeline (mirrors wheel canonical):
  ;;   1. Snapshot captures-ledger length BEFORE body walk.
  ;;   2. Push scope; bind param names as locals.
  ;;   3. Walk body via $lower_expr. During the walk, $lower_var_ref on
  ;;      free names (not in lambda's locals, but reachable via env)
  ;;      calls $ls_lookup_or_capture which APPENDS CAPTURE_ENTRY
  ;;      records to $lower_captures_ptr at indices ≥ snapshot.
  ;;   4. Pop scope.
  ;;   5. Materialize the lambda's caps list: for each new capture
  ;;      entry (snapshot ≤ i < post_walk_len), construct LLocal(0,
  ;;      capture_name). Sentinel handle 0 per Hβ.lower.upval-slot-
  ;;      resolution follow-up.
  ;;   6. Restore captures_len to snapshot — the lambda OWNS its caps;
  ;;      the outer fn's captures-ledger stays clean (frame-stack
  ;;      discipline approximation per Hβ.lower.fn-stmt-frame-discipline).
  ;;   7. LMakeClosure(handle, fn_ir, caps_exprs, []).
  ;;
  ;; Eight interrogations:
  ;;   1. Graph?      No graph_bind; lower-time only.
  ;;   2. Handler?    Direct seed call — wheel ls_enter_frame/exit_frame
  ;;                  approximated via length snapshot/restore. Full
  ;;                  frame-stack ADT is named follow-up.
  ;;   3. Verb?       N/A — structural.
  ;;   4. Row?        Lambda's row is row_pure at this Tier (Hβ.infer.
  ;;                  row-normalize gates the actual row composition).
  ;;   5. Ownership?  Captures are `ref` reads of outer locals. Each
  ;;                  capture is one LLocal LowExpr referencing the
  ;;                  outer name; emit-time materializes the closure
  ;;                  record carrying the captured values.
  ;;   6. Refinement? N/A.
  ;;   7. Gradient?   Captures CONNECT lambda's body-graph reads to the
  ;;                  outer-scope's local definitions. Without H.2.e,
  ;;                  closures over their environments wouldn't work.
  ;;   8. Reason?     Each LLocal carries the capture_name; the source
  ;;                  Reason chain on the captured handle persists in
  ;;                  the outer fn's graph entries.
  ;;
  ;; Drift modes refused:
  ;;   - Drift 1 (vtable):   no dispatch table — direct iteration.
  ;;   - Drift 7 (parallel-arrays): caps_exprs is one flat list, not
  ;;                                 parallel (names[], slots[]).
  ;;   - Drift 9 (deferred): captures materialized; LUpval-vs-LLocal
  ;;                          fine-distinction (nested-lambda case)
  ;;                          gates on a frame-stack ADT — named
  ;;                          follow-up Hβ.lower.lambda-nested-frame.
  ;;
  ;; ─── $lower_cap_materialize — closure-cap LowExpr triage ──────────
  ;; When the lambda's body has captured a name from outer scope, the
  ;; OUTER fn (where the LMakeClosure is being assembled) needs a
  ;; LowExpr that READS that name's value and stores it into the
  ;; closure record. The naive form `LLocal(0, name)` was wrong:
  ;; outer-fn references to a global would emit (local.get $X) for X
  ;; that's actually a top-level closure-record-ptr global — wat2wasm
  ;; reject as undefined local.
  ;;
  ;; Triage per protocol_canonical_projection_pattern.md, mirrors
  ;; $lower_var_ref's discrimination:
  ;;   1. Is name a top-level global? → LGlobal(0, name); outer fn
  ;;      emits (global.get $name) reading the closure-record-ptr.
  ;;   2. Is name a local in OUTER fn's frame? → LLocal(0, name);
  ;;      outer fn emits (local.get $name) reading its own local.
  ;;   3. Otherwise — name is in some FURTHER-outer scope → recurse
  ;;      via $ls_lookup_or_capture which appends a CAPTURE_ENTRY for
  ;;      the OUTER fn's captures, then emit LUpval(cap_idx) so outer
  ;;      reads from its own __state record. (Nested-lambda case.)
  ;;   4. Fallback → LGlobal (productive-under-error: emit_diag fires
  ;;      if genuinely missing, but emission proceeds).
  ;;
  ;; Closes Drift 9 named follow-up Hβ.lower.lambda-nested-frame from
  ;; $lower_lambda's prior comment block.
  (func $lower_cap_materialize (param $name i32) (result i32)
    (local $local_slot i32) (local $cap_idx i32)
    (if (call $ls_is_global (local.get $name))
      (then (return (call $lexpr_make_lglobal (i32.const 0) (local.get $name)))))
    (local.set $local_slot (call $ls_lookup_local (local.get $name)))
    (if (i32.ge_s (local.get $local_slot) (i32.const 0))
      (then (return (call $lexpr_make_llocal (i32.const 0) (local.get $name)))))
    (local.set $cap_idx (call $ls_lookup_or_capture (local.get $name)))
    (if (i32.ge_s (local.get $cap_idx) (i32.const 0))
      (then (return (call $lexpr_make_lupval (i32.const 0) (local.get $cap_idx)))))
    ;; Per protocol_no_silent_fallback.md: name truly unresolved at
    ;; outer-fn level (not global, not local, not capture-able). Emit
    ;; LUnresolved sentinel; emit translates to (unreachable). Was
    ;; previously a silent LGlobal fallback — same drift as $lower_var_ref
    ;; step 3's prior fallback. Closes the symmetric drift.
    (call $lexpr_make_lunresolved (i32.const 0) (local.get $name)))

  ;; AST per Lock #9: [tag=89][params_list][body_node] offsets 0/4/8.
  (func $lower_lambda (export "lower_lambda") (param $node i32) (result i32)
    (local $h i32) (local $body i32) (local $lambda_struct i32)
    (local $params i32) (local $body_node i32)
    (local $param_names i32) (local $param_handles i32)
    (local $cp i32) (local $lo_body i32) (local $body_list i32)
    (local $fn_ir i32) (local $caps i32) (local $evs i32)
    (local $caps_snapshot i32) (local $caps_post i32)
    (local $i i32) (local $cap_entry i32) (local $cap_name i32)
    (local $cap_lexpr i32) (local $caps_count i32)
    (local $prev_frame i32) (local $prev_lh i32)
    (local $lam_row i32) (local $prev_lh_row i32)
    (local $prev_cap_base i32) (local $cap_names i32)
    (local.set $h             (call $walk_expr_node_handle (local.get $node)))
    (local.set $body          (i32.load offset=4 (local.get $node)))
    (local.set $lambda_struct (i32.load offset=4 (local.get $body)))
    (local.set $params        (i32.load offset=4 (local.get $lambda_struct)))
    (local.set $body_node     (i32.load offset=8 (local.get $lambda_struct)))
    (local.set $param_names   (call $lower_param_names (local.get $params)))
    (local.set $param_handles (call $param_handles_of (local.get $h) (local.get $params)))
    ;; H.2.e step 1: snapshot captures-ledger AND push frame so lookups
    ;; in body see ONLY lambda-local names.
    (local.set $caps_snapshot (call $lower_captures_len))
    (local.set $prev_cap_base (call $ls_cap_frame_enter))
    (local.set $cp            (call $ls_push_scope))
    (local.set $prev_frame    (call $ls_enter_frame))
    ;; Mark THIS lambda's frame as the active lambda (its own handle $h), the
    ;; $ls_set_fn_name save/set/restore idiom. The in-body ev READ
    ;; ($lower_compute_ev_index_for_effect / $lower_ev_slot_raw) indexes the
    ;; lambda's OWN row — effects_of(lookup_ty($h)) — the SAME projection
    ;; $derive_ev_slots PLACED against (read==place by construction).
    ;; Compute THIS lambda's flow-closure ONCE — body+handle both in scope here —
    ;; and carry it as frame state beside the handle. The body's seam READs
    ;; ($lower_ev_slot_raw / $lower_compute_ev_index_for_effect) and the PLACE below
    ;; both consume this one value, so place==read by construction (no cache to
    ;; desync). Mirror of the wheel's lambda_escaping_row read live at both seams.
    (local.set $lam_row       (call $lambda_flow_closure (local.get $h) (local.get $body_node)))
    (local.set $prev_lh       (global.get $lower_current_lambda_h_g))
    (local.set $prev_lh_row   (global.get $lower_current_lambda_row_g))
    (global.set $lower_current_lambda_h_g (local.get $h))
    (global.set $lower_current_lambda_row_g (local.get $lam_row))
    (call $bind_names_as_locals (local.get $param_names) (local.get $param_handles))
    (local.set $lo_body       (call $lower_expr (local.get $body_node)))
    ;; Hβ.lower.tail-call-mark-pass — lambda body is in tail position.
    (local.set $lo_body       (call $lower_mark_tail (local.get $lo_body)))
    (global.set $lower_current_lambda_h_g (local.get $prev_lh))
    (global.set $lower_current_lambda_row_g (local.get $prev_lh_row))
    (call $ls_exit_frame (local.get $prev_frame))
    (call $ls_pop_scope (local.get $cp))
    ;; H.2.e steps 5+6, in the ORDER the nested-frame discipline demands:
    ;; copy this frame's capture NAMES, truncate the segment, restore the
    ;; enclosing frame's base, and ONLY THEN materialize — so a pass-through
    ;; capture (a name the outer frame itself must capture) appended by
    ;; $lower_cap_materialize lands in the OUTER frame's live segment and
    ;; SURVIVES (the nested-lambda destruction that fed find_mapping an
    ;; interned effect-name string as its mapping list).
    (local.set $caps_post (call $lower_captures_len))
    (local.set $caps_count (i32.sub (local.get $caps_post) (local.get $caps_snapshot)))
    (local.set $cap_names (call $make_list (local.get $caps_count)))
    (local.set $i (local.get $caps_snapshot))
    (block $copy_done
      (loop $copy_iter
        (br_if $copy_done (i32.ge_u (local.get $i) (local.get $caps_post)))
        (local.set $cap_entry
          (call $list_index (call $lower_captures_ptr_get) (local.get $i)))
        (drop (call $list_set (local.get $cap_names)
                              (i32.sub (local.get $i) (local.get $caps_snapshot))
                              (call $record_get (local.get $cap_entry) (i32.const 0))))
        (local.set $i (i32.add (local.get $i) (i32.const 1)))
        (br $copy_iter)))
    (call $ls_truncate_captures (local.get $caps_snapshot))
    (call $ls_cap_frame_exit (local.get $prev_cap_base))
    (local.set $caps (call $make_list (local.get $caps_count)))
    (local.set $i (i32.const 0))
    (block $caps_done
      (loop $caps_iter
        (br_if $caps_done (i32.ge_u (local.get $i) (local.get $caps_count)))
        ;; Triage via $lower_cap_materialize: LGlobal / LLocal / LUpval
        ;; per the OUTER fn's view of the captured name.
        (local.set $cap_lexpr
          (call $lower_cap_materialize
            (call $list_index (local.get $cap_names) (local.get $i))))
        (drop (call $list_set (local.get $caps) (local.get $i) (local.get $cap_lexpr)))
        (local.set $i (i32.add (local.get $i) (i32.const 1)))
        (br $caps_iter)))
    (local.set $body_list (call $make_list (i32.const 0)))
    (local.set $body_list (call $list_extend_to (local.get $body_list) (i32.const 1)))
    (drop (call $list_set (local.get $body_list) (i32.const 0) (local.get $lo_body)))
    (local.set $fn_ir (call $lowfn_make
                        (call $int_to_str (local.get $h))
                        (call $len (local.get $params))
                        (local.get $param_names)
                        (local.get $body_list)
                        (call $row_make_pure)
                        (call $len (local.get $caps))
                        (local.get $param_handles)))
    ;; A closure IS state IS evidence: PLACE the evidence against the SAME
    ;; flow-closure row the body READ (carried in $lam_row) — not the frozen
    ;; effects_of(lookup_ty) leaf, which dropped forward-ref effects and under-sized
    ;; the frame (the body forwarded a callee's full escaping row past the fence).
    ;; resolve_evs_for_names is the mirror of map(resolve_ev_for_ename, row); this
    ;; is the lambda peer of $derive_ev_slots' $escaping_row place. Mirror of
    ;; src/lower.mn LambdaExpr (derive_ev_slots None → lambda_escaping_row).
    (local.set $evs  (call $resolve_evs_for_names (local.get $lam_row)))
    (call $lexpr_make_lmakeclosure
      (local.get $h)
      (local.get $fn_ir)
      (local.get $caps)
      (local.get $evs)))
