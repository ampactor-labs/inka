  ;; ═══ walk_stmt.wat — Hβ.lower Stmt arms + $lower_stmt dispatch (Tier 8) ═══
  ;; Hβ.lower cascade chunk #10 of 11 per Hβ-lower-substrate.md §12.3 dep order.
  ;;
  ;; What this chunk IS (per Hβ-lower-substrate.md §4.3 + src/lower.mn:556-636):
  ;;   The seed's statement-level lowering layer. Where module-level functions
  ;;   emerge as LMakeClosure-wrapped LLets (Lock #1) and handler declarations
  ;;   cascade their arms through chunk #8's $lower_handler_arms_as_decls
  ;;   (Lock #7 — third caller earns the abstraction per Anchor 7). Bridge
  ;;   from Hβ.infer's typed AST stmt-list to chunk #11's $lower_program
  ;;   orchestrator.
  ;;
  ;;     120 LetStmt          → LLet(h, name, lo_value)            Lock #5/#6
  ;;     121 FnStmt           → LLet(h, name, LMakeClosure(...))   Lock #1/#2/#3/#4
  ;;     122 TypeDefStmt      → LConst(h, 0)                       Lock #9
  ;;     123 EffectDeclStmt   → LConst(h, 0)                       Lock #9
  ;;     124 HandlerDeclStmt  → LBlock(h, arm_decls ++ [LConst(...)])  Lock #7
  ;;     125 ExprStmt         → $lower_expr(inner)                 Lock #8
  ;;     126 ImportStmt       → LConst(h, 0)                       Lock #9
  ;;     127 RefineStmt       → LConst(h, 0)                       Lock #9
  ;;     128 Documented       → $lower_stmt(inner_node)            Lock #10
  ;;
  ;; Implements: Hβ-lower-substrate.md §4.3 + §6.3 + §11 + §12.3 #10;
  ;;             src/lower.mn:564-571 lower_stmt dispatch (NodeBody arms);
  ;;             src/lower.mn:573-633 lower_stmt_body (9 Stmt arms);
  ;;             src/lower.mn:556-558 lower_stmt_list (buffer-counter form
  ;;             per Lock #11 — diverges from wheel toward Ω.3).
  ;; Exports:    $lower_stmt,
  ;;             $lower_stmt_list,
  ;;             $lower_walk_stmt_let,
  ;;             $lower_walk_stmt_fn,
  ;;             $lower_walk_stmt_typedef,
  ;;             $lower_walk_stmt_effect_decl,
  ;;             $lower_walk_stmt_handler_decl,
  ;;             $lower_walk_stmt_expr,
  ;;             $lower_walk_stmt_import,
  ;;             $lower_walk_stmt_refine,
  ;;             $lower_walk_stmt_documented
  ;; Uses:       $walk_expr_node_handle (infer/walk_expr.wat:306-307 — cross-layer),
  ;;             $tag_of (runtime/record.wat),
  ;;             $lexpr_make_llet / lblock / lconst / lmakeclosure
  ;;               (lower/lexpr.wat),
  ;;             $lower_expr (lower/walk_call.wat — partial dispatcher
  ;;               complete after chunks #6/#7/#8/#9/#9.5 retrofits;
  ;;               this chunk does NOT retrofit further),
  ;;             $lower_handler_arms_as_decls (lower/walk_handle.wat —
  ;;               third caller per Lock #7),
  ;;             $ls_bind_local (lower/state.wat),
  ;;             $make_list / $list_index / $list_set / $list_extend_to /
  ;;               $len (runtime/list.wat — Ω.3 buffer-counter per Lock #11)
  ;; Test:       bootstrap/test/lower/walk_stmt_let.wat,
  ;;             bootstrap/test/lower/walk_stmt_fn.wat,
  ;;             bootstrap/test/lower/walk_stmt_expr.wat,
  ;;             bootstrap/test/lower/walk_stmt_handler_decl.wat,
  ;;             bootstrap/test/lower/walk_stmt_program.wat
  ;;
  ;; ═══ LOCKS (wheel-canonical override walkthrough §4.3 prose) ════════
  ;;
  ;; Lock #1: FnStmt → LLet(handle, name, LMakeClosure(...)) NOT bare LDeclareFn.
  ;;          Per src/lower.mn:612 wheel canonical. Walkthrough §4.3 prose
  ;;          ("most arms produce a top-level LDeclareFn") aspirational; the
  ;;          wheel emits LLet wrapping LMakeClosure. LDeclareFn (tag 313)
  ;;          is reserved for handler-arm-only module-level form per chunk #8.
  ;;
  ;; Lock #2: FnStmt now constructs a real LowFn record (name, arity,
  ;;          params, body, row) and still leaves captures/evidence empty.
  ;;          The remaining peer handle is closure-capture/frame discipline,
  ;;          not fn-record absence.
  ;;
  ;; Lock #3: FnStmt's $ls_bind_local(name, handle) fires BEFORE body lower.
  ;;          Per src/lower.mn:593. Recursive references resolve via locals
  ;;          ledger at chunk #6's $lower_var_ref.
  ;;
  ;; Lock #4: FnStmt's $ls_reset_function NOT called.
  ;;          Wheel uses ls_enter_frame/ls_exit_frame (frame-stack discipline);
  ;;          $ls_reset_function would wipe Lock #3's bind + enclosing-fn
  ;;          ledger. Frame discipline named follow-up
  ;;          Hβ.lower.fn-stmt-frame-discipline.
  ;;
  ;; Lock #5: LetStmt's pat treated as PVar-only at the seed.
  ;;          Per src/lower.mn:574-587. Pat tag 130 (PVar) → bind + LLet;
  ;;          others → pass-through lo. Named follow-up
  ;;          Hβ.lower.letstmt-destructure for PCon/PTuple/PList/PRecord.
  ;;
  ;; Lock #6: LetStmt's expr_h read via $walk_expr_node_handle on the val node.
  ;;          Per src/lower.mn:582 — offset 12 of val N-wrapper.
  ;;
  ;; Lock #7: HandlerDeclStmt → LBlock(h, arm_decls ++ [LConst(h, 0)]).
  ;;          Per src/lower.mn:617-625 wheel. Calls chunk #8 helper
  ;;          $lower_handler_arms_as_decls — currently returns empty list
  ;;          per chunk #8 Lock #7 (LFn ADT pending); seed emits
  ;;          LBlock(h, [LConst(h, 0)]).
  ;;
  ;; Lock #8: ExprStmt → $lower_expr(inner) direct passthrough.
  ;;          Per src/lower.mn:632. No LStore wrapper.
  ;;
  ;; Lock #9: TypeDef/EffectDecl/Import/Refine → $lexpr_make_lconst(handle, 0).
  ;;          Per src/lower.mn:615-628. Wheel emits LConst(handle, LInt(0));
  ;;          seed passes 0 directly per chunk #6 Lock #4 LowValue opaque
  ;;          pass-through (named follow-up Hβ.lower.lvalue-lowfn-lpat-
  ;;          substrate covers structured LowValue when ADT lands).
  ;;
  ;; Lock #10: Documented arm reads inner_node via offset 8.
  ;;           Layout assumption [tag=128][docstring][inner_node]. Drift-9-safe:
  ;;           parser doesn't emit Documented today. Named follow-up
  ;;           Hβ.lower.documented-arm-substrate.
  ;;
  ;; Lock #11: $lower_stmt_list buffer-counter (Ω.3) NOT tail-recursive cons.
  ;;           Wheel src/lower.mn:556-558 uses [head] ++ tail (O(N²) drift the
  ;;           wheel itself flags). Seed prefers Ω.3 — chunk #6/#7/#8/#9
  ;;           discipline.
  ;;
  ;; Lock #12: $lower_stmt dispatcher mirrors infer/walk_stmt.wat:623-671.
  ;;           Read N-wrapper → body offset 4 → if NExpr (110) delegate to
  ;;           $lower_expr; NPat (112)/NHole (113) → LConst(h, 0); NStmt (111)
  ;;           → 9-arm dispatch over Stmt tags 120-128.
  ;;
  ;; ═══ EIGHT INTERROGATIONS (per Hβ-lower-substrate.md §5.3) ══════════
  ;;
  ;; 1. Graph?       LetStmt + FnStmt arms read $walk_expr_node_handle
  ;;                 (offset 12) on AST inputs; bound name's ty_handle
  ;;                 stored in state.wat ledger references graph handles.
  ;;                 ExprStmt threads through $lower_expr (chunk #7
  ;;                 dispatcher). Read-only on graph.
  ;;
  ;; 2. Handler?     Wheel: with GraphRead + EnvRead + LookupTy + LowerCtx
  ;;                 + Diagnostic chain @resume=OneShot. Seed: 11 direct
  ;;                 functions. FnStmt does NOT install a new handler row
  ;;                 here — emit-time concern. HandlerDeclStmt invokes
  ;;                 chunk #8's $lower_handler_arms_as_decls (third caller).
  ;;
  ;; 3. Verb?        Silent at stmt-list level (stmts sequential by
  ;;                 definition; verbs draw inside Expr). FnStmt's body
  ;;                 recursion via $lower_expr re-enters the verb-projection
  ;;                 layer (chunk #8).
  ;;
  ;; 4. Row?         FnStmt's row stays opaque at lower-time (wheel hardcodes
  ;;                 EfPure on LFn — Lock #2 elides LFn entirely). Rows
  ;;                 resolved live via $lookup_ty at downstream call-sites
  ;;                 (chunk #7 $monomorphic_at).
  ;;
  ;; 5. Ownership?   LetStmt's $ls_bind_local writes to state.wat's locals
  ;;                 ledger (OWN by current fn). FnStmt's params + captures
  ;;                 discipline deferred per Lock #2/#4. ExprStmt's lowered
  ;;                 LowExpr OWN by bump.
  ;;
  ;; 6. Refinement?  RefineStmt → inert LConst sentinel per Lock #9
  ;;                 (refinement obligations land in verify ledger at
  ;;                 infer-time). Lower transparent.
  ;;
  ;; 7. Gradient?    FnStmt's LMakeClosure IS the closure substrate that
  ;;                 monomorphic-call gradient (chunk #7 $monomorphic_at)
  ;;                 reads back through. LetStmt's $ls_bind_local makes the
  ;;                 binding so subsequent VarRef chunks read it as RLocal
  ;;                 (gradient: monomorphic-bound) instead of falling to
  ;;                 LGlobal.
  ;;
  ;; 8. Reason?      LetStmt + FnStmt + ExprStmt carry source handle into
  ;;                 LowExpr field 0; Reason chain lives on GNode at that
  ;;                 handle. The four inert Stmts emit LConst(h, 0) so the
  ;;                 handle bridge survives to emit's dead-code elimination.
  ;;
  ;; ═══ FORBIDDEN PATTERNS AUDIT ═══════════════════════════════════════
  ;;
  ;; - Drift 1 (Rust vtable):      Stmt dispatch is 9-arm if-chain — direct
  ;;                                sentinel comparison; no $stmt_arm_table
  ;;                                data segment. Word "vtable" appears
  ;;                                NOWHERE except in this audit.
  ;;
  ;; - Drift 2 (Scheme env frame): state.wat's flat list per Lock #4. NO
  ;;                                frame stack push/pop here.
  ;;
  ;; - Drift 3 (Python dict):      Stmt tags integer constants 120-128.
  ;;                                NO string-keyed dispatch.
  ;;
  ;; - Drift 4 (monad transformer): No LowerStmtM. Each $lower_walk_stmt_*
  ;;                                is direct (param i32) (param i32) (result i32).
  ;;
  ;; - Drift 5 (C calling conv):   FnStmt closure synthesis — LMakeClosure
  ;;                                carries one fn_ptr field + caps + evs;
  ;;                                NOT separate __closure + __ev + __ret_slot.
  ;;
  ;; - Drift 6 (primitive special-case): LetStmt is one of nine arms — NOT
  ;;                                fast-path. Every Stmt tag dispatches
  ;;                                through same $tag_of + (if eq) chain.
  ;;
  ;; - Drift 7 (parallel-arrays):  state.wat's LOCAL_ENTRY 3-field record
  ;;                                reused. LMakeClosure.caps + .evs are H1-
  ;;                                canonical TWO conceptually-distinct lists.
  ;;
  ;; - Drift 8 (string-keyed):     Stmt arm dispatch via integer tag (120-128);
  ;;                                NEVER kind == "let" / kind == "fn".
  ;;
  ;; - Drift 9 (deferred-by-omission): ALL 9 Stmt arms FULLY BODIED. Inert
  ;;                                four (TypeDef/EffectDecl/Import/Refine)
  ;;                                emit LConst sentinel explicitly. Lock #2/
  ;;                                #4/#5/#7/#10 deferrals bodied with
  ;;                                reasoning + named follow-ups.
  ;;
  ;; - Foreign fluency — module-level fn declaration: NEVER "global function" /
  ;;                                "top-level function". Vocabulary stays
  ;;                                Mentl — LDeclareFn (handler-arm form) /
  ;;                                LMakeClosure (closure form).
  ;;
  ;; - Foreign fluency — let-rec / Y combinator: Recursive `fn fact` resolves
  ;;                                via $ls_bind_local(name, handle) BEFORE
  ;;                                body lower (Lock #3). The wheel's two-pass
  ;;                                pre-bind IS the Mentl substrate.
  ;;
  ;; ═══ Named follow-ups (Drift 9 closure) ═════════════════════════════
  ;;
  ;;   - Hβ.lower.fn-stmt-closure-substrate:
  ;;             collect_free_vars + resolve_captures_outer + ls_enter_frame/
  ;;             ls_exit_frame + LFn ADT all converge as one peer landing
  ;;             with Hβ.lower.lambda-capture-substrate (chunk #9).
  ;;
  ;;   - Hβ.lower.fn-stmt-frame-discipline:
  ;;             Per Lock #4 — $ls_enter_frame / $ls_exit_frame substrate
  ;;             at state.wat (matching wheel src/lower.mn:599-604).
  ;;
  ;;   - Hβ.lower.letstmt-destructure:
  ;;             Per Lock #5 — when parser surfaces stable PCon/PTuple/PList/
  ;;             PRecord at LetStmt position.
  ;;
  ;;   - Hβ.lower.handler-arm-decls-substrate:
  ;;             (extends from chunk #8) chunk #8's helper grows real
  ;;             LDeclareFn list when LFn ADT lands; this chunk's
  ;;             HandlerDeclStmt arm picks up the populated list automatically.
  ;;
  ;;   - Hβ.lower.documented-arm-substrate:
  ;;             Per Lock #10 — when parser surfaces $mk_DocumentedStmt with
  ;;             stable layout.
  ;;
  ;;   - Hβ.lower.toplevel-pre-register:
  ;;             (cross-cascade with Hβ.infer.toplevel-pre-register) — chunk
  ;;             #11 main.wat's $lower_program may grow collect_top_level_names
  ;;             per src/lower.mn:1106-1110 if forward-reference resolution
  ;;             at the seed needs it.

  ;; ─── $lower_walk_stmt_let — LetStmt arm (parser tag 120) ────────────
  ;; Per src/lower.mn:574-587 + Lock #5/#6.
  ;; AST per parser_infra.wat:163-168: [tag=120][pat][val] offsets 0/4/8.
  (func $lower_walk_stmt_let (export "lower_walk_stmt_let")
        (param $stmt i32) (param $handle i32) (result i32)
    (local $pat i32) (local $val i32) (local $lo i32)
    (local $pat_tag i32) (local $name i32) (local $expr_h i32)
    (local.set $pat (i32.load offset=4 (local.get $stmt)))
    (local.set $val (i32.load offset=8 (local.get $stmt)))
    ;; Lock #6: read val-node's handle BEFORE recursing.
    (local.set $expr_h (call $walk_expr_node_handle (local.get $val)))
    ;; Lower the value via $lower_expr.
    (local.set $lo (call $lower_expr (local.get $val)))
    ;; Lock #5: PVar (tag 130) only at the seed.
    (local.set $pat_tag (call $tag_of (local.get $pat)))
    (if (i32.eq (local.get $pat_tag) (i32.const 130))
      (then
        (local.set $name (i32.load offset=4 (local.get $pat)))
        (drop (call $ls_bind_local (local.get $name) (local.get $expr_h)))
        (return (call $lexpr_make_llet
                  (local.get $handle)
                  (local.get $name)
                  (local.get $lo)))))
    ;; Lock #5: only PVar (130) binds at the seed. Destructure patterns
    ;; (PCon/PTuple/PList/PRecord) never reach here — the parser's $desugar_block
    ;; turns `let pat = v; rest` into `match v { pat => rest }` at the node's
    ;; birth, so LetStmt is PVar-only by construction and binding + field-loads at
    ;; all depths come from the ONE match projection (lower_match → its arm
    ;; binders). PWild/PLit fall through — eval for effect.
    ;; (protocol_one_graph_two_operations.)
    (local.get $lo))

  ;; ─── $lower_walk_stmt_fn — FnStmt arm (parser tag 121) ──────────────
  ;; Per src/lower.mn:590-613 + Lock #1/#2/#3/#4.
  ;; AST per parser_infra.wat:171-179:
  ;;   [tag=121][name][params][ret][effs][body] offsets 0/4/8/12/16/20.
  (func $lower_walk_stmt_fn (export "lower_walk_stmt_fn")
        (param $stmt i32) (param $handle i32) (result i32)
    (local $name i32) (local $params i32) (local $body_node i32)
    (local $param_names i32) (local $param_handles i32)
    (local $cp i32) (local $lo_body i32) (local $body_list i32)
    (local $fn_ir i32) (local $caps i32) (local $evs i32) (local $closure i32)
    (local $outer i32) (local $fn_name i32) (local $prev_fn_name i32)
    (local $caps_snapshot i32) (local $caps_post i32) (local $caps_count i32)
    (local $prev_frame i32) (local $i i32)
    (local $cap_entry i32) (local $cap_name i32) (local $cap_lexpr i32)
    (local.set $name      (i32.load offset=4  (local.get $stmt)))
    (local.set $params    (i32.load offset=8  (local.get $stmt)))
    (local.set $body_node (i32.load offset=20 (local.get $stmt)))
    ;; Per Hβ.first-light.malformed-fnstmt-sentinel (2026-05-07,
    ;; chain-link-5 protocol_parse_is_eager_graph_projection.md applied
    ;; at the lower layer per protocol_parser_fabrication_substrate.md):
    ;; when the upstream parser (via $ident_at_p fabricating empty-string
    ;; on non-TIdent) produces an FnStmt with empty name, the construct
    ;; was malformed at parse — there's nothing valid to lower. ULTIMATE
    ;; MEDIUM at this site: emit LConst(handle, 0) sentinel-LExpr;
    ;; downstream emit reads sentinel and produces no funcref-table
    ;; entry, no $name_idx global, no static-closure record. Drift
    ;; refused: 9 (no propagating malformed AST through to emit's
    ;; bloat output); fabrication (we don't fabricate a name to keep
    ;; the FnStmt; we surface it as the sentinel it is).
    ;;
    ;; Eight interrogations on the sentinel emission:
    ;;  1. Graph?      LConst(handle, 0) attaches to the same graph
    ;;                 handle the malformed FnStmt was at; downstream
    ;;                 walks the graph through this LConst.
    ;;  2. Handler?    @resume=OneShot; sentinel emit is one-shot.
    ;;  3. Verb?       N/A — structural.
    ;;  4. Row?        Pure (no effects).
    ;;  5. Ownership?  Sentinel owns nothing.
    ;;  6. Refinement? FnStmt's name should refine to NonEmptyString;
    ;;                 violation lands here. The proper fix is upstream
    ;;                 ($ident_at_p contract change); this is the
    ;;                 productive-under-error projection until then.
    ;;  7. Gradient?   Sentinel is the lowest-information lowering;
    ;;                 the gradient narrows toward authoring a proper
    ;;                 fn name at the source position.
    ;;  8. Reason?     Reason chain attaches via the parser-side
    ;;                 sentinel-stmt (named peer when productive-under-
    ;;                 error parser substrate lands).
    ;;
    ;; Empirical: src/lower.mn seed-compile produced 14232 empty-named
    ;; static closures via this exact propagation path; this guard
    ;; closes the bloat at the lower→emit boundary while the upstream
    ;; parser substrate fix proceeds.
    (if (i32.eqz (i32.load (local.get $name)))   ;; len(name) == 0 → empty
      (then (return (call $lexpr_make_lconst (local.get $handle) (i32.const 0)))))
    ;; Bind only inside an existing function frame. At module scope the
    ;; name was pre-registered by $lower_program and resolves as LGlobal.
    (if (call $ls_in_function)
      (then
        (drop (call $ls_bind_local (local.get $name) (local.get $handle)))))
    (local.set $param_names   (call $lower_param_names   (local.get $params)))
    (local.set $param_handles (call $param_handles_of (local.get $handle) (local.get $params)))
    ;; Per Hβ.first-light.nested-fn-name-discriminator (2026-05-06):
    ;; query outer fn name BEFORE setting our own. Empty outer (0)
    ;; means top-level: keep bare name. Otherwise mint outer ++ "_" ++
    ;; name. Symmetric with $op_<handler>_<op>; uses semantic prefixes
    ;; (not handle-ints). Drift refused: 1 (no vtable, direct concat);
    ;; 8 (composed name string, not mode-int).
    ;;
    ;; Per Hβ.first-light.nested-fn-name-discriminator-bloat-fix
    ;; (2026-05-07): outer fn name is meaningful ONLY inside a function
    ;; frame ($ls_in_function). At module-top-level, every FnStmt is
    ;; inherently bare-named regardless of any stale fn-name global. The
    ;; pre-fix bug surfaced when the seed compiled the wheel: the wheel's
    ;; src/infer.mn has many top-level fns; the global wasn't being
    ;; reset between them; subsequent fns inherited "infer_program_"
    ;; prefix (213k bloat in the funcref table). The structural guard
    ;; below makes the discriminator robust to any path that leaks a
    ;; non-zero fn-name across top-level fns.
    (local.set $outer
      (if (result i32) (call $ls_in_function)
        (then (call $ls_outer_fn_name))
        (else (i32.const 0))))
    (if (i32.eqz (local.get $outer))
      (then (local.set $fn_name (local.get $name)))
      (else
        (local.set $fn_name (call $str_concat (local.get $outer) (i32.const 4400)))   ;; outer + "_"
        (local.set $fn_name (call $str_concat (local.get $fn_name) (local.get $name)))))
    (local.set $prev_fn_name (call $ls_set_fn_name (local.get $fn_name)))
    ;; Per Hβ.first-light.nested-fn-capture-substrate (2026-05-06):
    ;; mirror $lower_lambda's capture-materialization (lines 873-937)
    ;; — snapshot ledger, enter frame for proper frame_start isolation,
    ;; lower body (captures append via $ls_lookup_or_capture during
    ;; var resolution), materialize caps as LLocal sentinels, restore
    ;; ledger. Without this, nested fn bodies referencing outer params
    ;; emit `(local.get $xs)` for an undeclared local. The wheel's
    ;; FnStmt arm does the same dance (collect_free_vars +
    ;; resolve_captures_outer + ls_enter_frame). Drift refused: 9
    ;; (mirrors existing lambda substrate, not deferred).
    (local.set $caps_snapshot (call $lower_captures_len))
    (local.set $cp            (call $ls_push_scope))
    (local.set $prev_frame    (call $ls_enter_frame))
    (call $ls_enter_function)
    (call $bind_names_as_locals (local.get $param_names) (local.get $param_handles))
    ;; Per Hβ.first-light.fnstmt-fresh-captures-len: each fn body owns its
    ;; captures-len ledger 0-based, mirrors $lower_handler_arm_body_capturing
    ;; (walk_handle.wat:449-455). Without the reset, a leaked captures-len_g
    ;; from a malformed-parse sibling stmt produces body LUpval(global_idx)
    ;; offsets that disagree with the closure-record's local-offset storage —
    ;; e.g. parse_int_go's `n` resolves to LUpval(1) → __state[12], but the
    ;; closure stored capture[1] = digit. Body→record disagreement = `indirect
    ;; call type mismatch` trap when the resolved fn-ptr is read from the
    ;; wrong slot. Reset puts both views in 0-based agreement.
    (global.set $lower_captures_len_g (i32.const 0))
    (local.set $lo_body (call $lower_expr (local.get $body_node)))
    ;; Hβ.lower.tail-call-mark-pass — fn body IS in tail position.
    ;; Without this, lex_from / scan_decimal recursive calls compile as
    ;; regular call_indirect and exhaust the WASM stack on long inputs.
    (local.set $lo_body (call $lower_mark_tail (local.get $lo_body)))
    (call $ls_exit_function)
    (call $ls_exit_frame (local.get $prev_frame))
    (call $ls_pop_scope (local.get $cp))
    (drop (call $ls_set_fn_name (local.get $prev_fn_name)))
    ;; Materialize caps_exprs from new captures.
    ;; Captures-len-g was reset to 0 at body entry, so $caps_post IS the
    ;; cap count for THIS body (0-based). Iterate [0, caps_post) reading
    ;; from $lower_captures_ptr — entries were stored at those local
    ;; indices during the body walk via $ls_lookup_or_capture. Note the
    ;; caller's parent-scope captures (if any) live at indices ≥ caps_post
    ;; in the global ptr buffer, but were OVERWRITTEN by this body's
    ;; captures; the parent's logical view ($caps_snapshot..) is restored
    ;; below via captures_len_g = caps_snapshot, but its physical entries
    ;; in the buffer are clobbered. Single-level nesting (top-level fn
    ;; with nested-fn body) is the dominant case and is correct under
    ;; this discipline; multi-level nesting is the named follow-up
    ;; Hβ.first-light.fnstmt-nested-captures-isolation (frame-stack
    ;; ports the wheel's per-frame captures records, replacing the flat
    ;; global ptr).
    (local.set $caps_post (call $lower_captures_len))
    (local.set $caps_count (local.get $caps_post))
    (local.set $caps (call $make_list (i32.const 0)))
    (local.set $caps (call $list_extend_to (local.get $caps) (local.get $caps_count)))
    (local.set $i (i32.const 0))
    (block $caps_done
      (loop $caps_iter
        (br_if $caps_done (i32.ge_u (local.get $i) (local.get $caps_post)))
        (local.set $cap_entry
          (call $list_index (call $lower_captures_ptr_get) (local.get $i)))
        (local.set $cap_name (call $record_get (local.get $cap_entry) (i32.const 0)))
        (local.set $cap_lexpr
          (call $lower_cap_materialize (local.get $cap_name)))
        (drop (call $list_set (local.get $caps) (local.get $i) (local.get $cap_lexpr)))
        (local.set $i (i32.add (local.get $i) (i32.const 1)))
        (br $caps_iter)))
    (call $ls_truncate_captures (local.get $caps_snapshot))
    (global.set $lower_captures_len_g (local.get $caps_snapshot))
    (local.set $body_list (call $make_list (i32.const 0)))
    (local.set $body_list (call $list_extend_to (local.get $body_list) (i32.const 1)))
    (drop (call $list_set (local.get $body_list) (i32.const 0) (local.get $lo_body)))
    (local.set $fn_ir (call $lowfn_make
                        (local.get $fn_name)
                        (call $len (local.get $params))
                        (local.get $param_names)
                        (local.get $body_list)
                        (call $row_make_pure)
                        (call $len (local.get $caps))))
    ;; A closure IS state IS evidence: capture the evidence for the effects
    ;; this closure's body performs (the let-bound mirror of the inline-lambda
    ;; path at walk_compound.wat + src/lower.mn LambdaExpr).
    (local.set $evs  (call $derive_closure_evs (local.get $handle)))
    (local.set $closure (call $lexpr_make_lmakeclosure
                          (local.get $handle)
                          (local.get $fn_ir)
                          (local.get $caps)
                          (local.get $evs)))
    ;; Lock #1: wrap in LLet(handle, name, closure).
    (call $lexpr_make_llet
      (local.get $handle)
      (local.get $name)
      (local.get $closure)))

  ;; ─── $lower_walk_stmt_typedef — TypeDefStmt arm (tag 122) ──────────
  ;; Per Lock #9. LConst(handle, 0) sentinel.
  (func $lower_walk_stmt_typedef (export "lower_walk_stmt_typedef")
        (param $stmt i32) (param $handle i32) (result i32)
    (drop (local.get $stmt))
    (call $lexpr_make_lconst (local.get $handle) (i32.const 0)))

  ;; ─── $lower_walk_stmt_effect_decl — EffectDeclStmt arm (tag 123) ───
  ;; Per Lock #9.
  (func $lower_walk_stmt_effect_decl (export "lower_walk_stmt_effect_decl")
        (param $stmt i32) (param $handle i32) (result i32)
    (drop (local.get $stmt))
    (call $lexpr_make_lconst (local.get $handle) (i32.const 0)))

  ;; ─── $lower_state_field_inits — lower each init expr in source order ─
  ;; Each state_fields entry is a {name, init} record (offset 0 = name,
  ;; offset 4 = init AST node). Returns a flat list of LowExprs ready
  ;; for emit_state_init_writes (mirror of wheel-side lower_state_field_inits).
  ;; Buffer-counter discipline (Ω.3); no acc-concat in loop.
  ;; `with field = init` is evaluated in the scope of the handler's config
  ;; params. Lower the inits in a frame where the config names are captures
  ;; (reusing $pre_allocate_config_captures, the same canonical-order setup
  ;; arm bodies use) so a config reference becomes LUpval(config_slot); emit
  ;; reads it from the SAME record's config region (written first). Handler
  ;; IS state IS closure IS evidence — a state slot initialized from a config
  ;; arg is one record reading itself. Without config in scope, `acc = init`
  ;; resolves `init` to a non-existent global → LUnresolved → (unreachable)
  ;; at install (fold_handler, take_collector). Mirror of src/lower.mn
  ;; lower_state_field_inits + $lower_handler_arm_body_capturing.
  (func $lower_state_field_inits (export "lower_state_field_inits")
        (param $config i32) (param $state_fields i32) (result i32)
    (local $n i32) (local $i i32) (local $buf i32)
    (local $field i32) (local $init_node i32) (local $lo i32)
    (local $cp i32) (local $prev_frame i32) (local $prev_captures_len i32)
    (local.set $n   (call $len (local.get $state_fields)))
    (local.set $buf (call $make_list (i32.const 0)))
    (local.set $buf (call $list_extend_to (local.get $buf) (local.get $n)))
    (local.set $cp (call $ls_push_scope))
    (local.set $prev_frame (call $ls_enter_frame))
    (local.set $prev_captures_len (global.get $lower_captures_len_g))
    (global.set $lower_captures_len_g (i32.const 0))
    (call $pre_allocate_config_captures (local.get $config))
    (local.set $i   (i32.const 0))
    (block $done
      (loop $each
        (br_if $done (i32.ge_u (local.get $i) (local.get $n)))
        (local.set $field     (call $list_index (local.get $state_fields) (local.get $i)))
        (local.set $init_node (call $record_get (local.get $field) (i32.const 1)))
        (local.set $lo        (call $lower_expr (local.get $init_node)))
        (drop (call $list_set (local.get $buf) (local.get $i) (local.get $lo)))
        (local.set $i (i32.add (local.get $i) (i32.const 1)))
        (br $each)))
    (global.set $lower_captures_len_g (local.get $prev_captures_len))
    (call $ls_exit_frame (local.get $prev_frame))
    (call $ls_pop_scope (local.get $cp))
    (local.get $buf))

  ;; ─── $lower_pre_register_handler_decls — order-free handler ledgers ──
  ;; (Hβ.infer.pre-register-all-decls, lower half.) Handler decls register
  ;; their (state_inits, arm_names) ledgers BEFORE any stmt lowers, so an
  ;; install site in an earlier-sorted module resolves a handler declared
  ;; in a later one (main.mn `~> diagnostics_handler` with the decl in
  ;; pipeline.mn). Declaration order cannot matter — the graph already
  ;; knows. $handler_state_inits_register dedups by name; the walk-time
  ;; registration below becomes a no-op for pre-registered names.
  (func $lower_pre_register_handler_decls (export "lower_pre_register_handler_decls")
        (param $stmts i32)
    (local $n i32) (local $i i32) (local $node i32)
    (local.set $n (call $len (local.get $stmts)))
    (local.set $i (i32.const 0))
    (block $done
      (loop $each
        (br_if $done (i32.ge_u (local.get $i) (local.get $n)))
        (local.set $node (call $list_index (local.get $stmts) (local.get $i)))
        (call $lower_pre_register_handler_node (local.get $node))
        (local.set $i (i32.add (local.get $i) (i32.const 1)))
        (br $each))))

  (func $lower_pre_register_handler_node (param $node i32)
    (local $body i32) (local $stmt i32) (local $tag i32)
    (local $arms i32) (local $hname i32) (local $i i32) (local $n i32)
    (local $arm i32) (local $opn i32) (local $bind i32) (local $kind i32)
    (local.set $body (i32.load offset=4 (local.get $node)))
    (if (i32.ne (i32.load (local.get $body)) (i32.const 111)) (then (return)))
    (local.set $stmt (i32.load offset=4 (local.get $body)))
    (local.set $tag (i32.load (local.get $stmt)))
    ;; Documented(doc, inner) — unwrap to the declaration it documents.
    (if (i32.eq (local.get $tag) (i32.const 128))
      (then
        (call $lower_pre_register_handler_node (i32.load offset=8 (local.get $stmt)))
        (return)))
    (if (i32.ne (local.get $tag) (i32.const 124)) (then (return)))
    (local.set $hname (i32.load offset=4  (local.get $stmt)))
    (local.set $arms  (i32.load offset=12 (local.get $stmt)))
    (call $handler_state_inits_register
      (local.get $hname)
      ;; config@20, state_fields@16 (mk_handler_decl_full layout)
      (call $lower_state_field_inits
        (i32.load offset=20 (local.get $stmt))
        (i32.load offset=16 (local.get $stmt)))
      (call $build_handler_arm_names (local.get $hname) (local.get $arms)))
    ;; DRAW op→handler ONTO THE OP: each arm's op carries this handler as its
    ;; unique default. The REAL arms live HERE (offset 12 at lower; infer's are
    ;; empty); a second distinct implementer marks the op ambiguous (→ thread).
    ;; Dispatch then READS this O(1) — no env scan, no side-ledger. "I already
    ;; have this": the op's EffectOpScheme binding IS the dispatch fact.
    (local.set $n (call $len (local.get $arms)))
    (local.set $i (i32.const 0))
    (block $done
      (loop $l
        (br_if $done (i32.ge_u (local.get $i) (local.get $n)))
        (local.set $arm (call $list_index (local.get $arms) (local.get $i)))
        (local.set $opn (call $record_get (local.get $arm) (i32.const 2)))
        (local.set $bind (call $env_lookup (local.get $opn)))
        (if (local.get $bind)
          (then
            (local.set $kind (call $env_binding_kind (local.get $bind)))
            (if (i32.and (i32.ge_u (local.get $kind) (global.get $heap_base))
                         (i32.eq (call $tag_of (local.get $kind)) (i32.const 133)))
              (then (call $schemekind_effectop_set_handler
                          (local.get $kind) (local.get $hname))))))
        (local.set $i (i32.add (local.get $i) (i32.const 1)))
        (br $l))))

  ;; ─── $lower_walk_stmt_handler_decl — HandlerDeclStmt arm (tag 124) ──
  ;; Per src/lower.mn:617-625 + Lock #7.
  ;; Layout assumption: [tag=124][handler_name][effect_name][arms_list]
  ;;   offsets 0/4/8/12 (parser_decl.wat doesn't expose $mk_HandlerDeclStmt
  ;;   per file read; verified via src/lower.mn wheel canonical).
  (func $lower_walk_stmt_handler_decl (export "lower_walk_stmt_handler_decl")
        (param $stmt i32) (param $handle i32) (result i32)
    (local $arms i32) (local $arm_decls i32) (local $sentinel i32)
    (local $stmts i32) (local $i i32) (local $n i32)
    (local $handler_name i32) (local $state_fields i32) (local $state_inits i32)
    (local.set $arms         (i32.load offset=12 (local.get $stmt)))
    (local.set $handler_name (i32.load offset=4  (local.get $stmt)))
    (local.set $state_fields (i32.load offset=16 (local.get $stmt)))
    ;; Hβ.seed.handler-state-init-writes-mirror — lower each state-field
    ;; init expression and register the list keyed by handler_name. PTee
    ;; install sites query via $handler_state_inits_lookup and embed
    ;; the inits into LHandleWith for emit-time stores at offset 8+i*4
    ;; per protocol_handler_is_state_is_closure_is_evidence.md.
    (local.set $state_inits (call $lower_state_field_inits
      (i32.load offset=20 (local.get $stmt))   ;; config@20
      (local.get $state_fields)))
    ;; Hβ-perform-evidence-dispatch.md §4.7: build the op-slot-indexed arm
    ;; fn-name list from the handler's actual arms and register it alongside
    ;; the state-inits (one ledger entry, 3 fields). $emit_lhandlewith reads
    ;; it via the install site to write the record's arm region.
    (call $handler_state_inits_register (local.get $handler_name) (local.get $state_inits)
      (call $build_handler_arm_names (local.get $handler_name) (local.get $arms)))
    ;; Lock #7: invoke chunk #8's helper (third caller — abstraction earned).
    ;; Per Hβ.first-light.handler-arm-fn-name-discriminator: pass the
    ;; handler_name as the discriminator so each top-level handler's
    ;; arm fns get unique WASM symbols ($op_<handler>_<op>).
    ;; Per Hβ.first-light.handler-config-state-substrate (2026-05-06):
    ;; offsets 20 (config-params) + 16 (state-fields) thread into arm
    ;; scope so arm-body identifier lookup resolves names like `f`
    ;; (handler map_h(f)) and `remaining` (handler take_h with
    ;; remaining = n).
    (local.set $arm_decls (call $lower_handler_arms_as_decls
                            (local.get $arms)
                            (local.get $handler_name)
                            (i32.load offset=20 (local.get $stmt))
                            (local.get $state_fields)))
    (local.set $sentinel  (call $lexpr_make_lconst (local.get $handle) (i32.const 0)))
    ;; Build stmts = arm_decls ++ [sentinel]. Buffer-counter (Ω.3).
    (local.set $n     (call $len (local.get $arm_decls)))
    (local.set $stmts (call $make_list (i32.const 0)))
    (local.set $stmts (call $list_extend_to (local.get $stmts)
                        (i32.add (local.get $n) (i32.const 1))))
    (local.set $i (i32.const 0))
    (block $done
      (loop $copy
        (br_if $done (i32.ge_u (local.get $i) (local.get $n)))
        (drop (call $list_set (local.get $stmts) (local.get $i)
                (call $list_index (local.get $arm_decls) (local.get $i))))
        (local.set $i (i32.add (local.get $i) (i32.const 1)))
        (br $copy)))
    (drop (call $list_set (local.get $stmts) (local.get $n) (local.get $sentinel)))
    (call $lexpr_make_lblock (local.get $handle) (local.get $stmts)))

  ;; ─── $lower_walk_stmt_expr — ExprStmt arm (tag 125) ─────────────────
  ;; Per src/lower.mn:632 + Lock #8. Direct passthrough.
  ;; AST per parser_infra.wat:182-186: [tag=125][node] offsets 0/4.
  (func $lower_walk_stmt_expr (export "lower_walk_stmt_expr")
        (param $stmt i32) (param $handle i32) (result i32)
    (local $inner i32)
    (drop (local.get $handle))
    (local.set $inner (i32.load offset=4 (local.get $stmt)))
    (call $lower_expr (local.get $inner)))

  ;; ─── $lower_walk_stmt_import — ImportStmt arm (tag 126) ────────────
  ;; Per Lock #9.
  (func $lower_walk_stmt_import (export "lower_walk_stmt_import")
        (param $stmt i32) (param $handle i32) (result i32)
    (drop (local.get $stmt))
    (call $lexpr_make_lconst (local.get $handle) (i32.const 0)))

  ;; ─── $lower_walk_stmt_refine — RefineStmt arm (tag 127) ────────────
  ;; Per Lock #9.
  (func $lower_walk_stmt_refine (export "lower_walk_stmt_refine")
        (param $stmt i32) (param $handle i32) (result i32)
    (drop (local.get $stmt))
    (call $lexpr_make_lconst (local.get $handle) (i32.const 0)))

  ;; ─── $lower_walk_stmt_documented — Documented arm (tag 128) ─────────
  ;; Per src/lower.mn:630 + Lock #10. Recurses on inner_node (offset 8).
  (func $lower_walk_stmt_documented (export "lower_walk_stmt_documented")
        (param $stmt i32) (param $handle i32) (result i32)
    (local $inner_node i32)
    (drop (local.get $handle))
    (local.set $inner_node (i32.load offset=8 (local.get $stmt)))
    (call $lower_stmt (local.get $inner_node)))

  ;; ─── $lower_stmt — public dispatcher (per Lock #12) ─────────────────
  ;; Per src/lower.mn:564-571 + infer/walk_stmt.wat:623-671 sibling.
  (func $lower_stmt (export "lower_stmt") (param $node i32) (result i32)
    (local $body i32) (local $body_tag i32)
    (local $stmt i32) (local $stmt_tag i32)
    (local $handle i32)
    (local.set $body   (i32.load offset=4  (local.get $node)))
    (local.set $handle (i32.load offset=12 (local.get $node)))
    (local.set $body_tag (i32.load offset=0 (local.get $body)))
    ;; NExpr (110) — delegate to $lower_expr.
    (if (i32.eq (local.get $body_tag) (i32.const 110))
      (then (return (call $lower_expr (local.get $node)))))
    ;; NPat (112) / NHole (113) — degenerate LConst sentinel.
    (if (i32.eq (local.get $body_tag) (i32.const 112))
      (then (return (call $lexpr_make_lconst (local.get $handle) (i32.const 0)))))
    (if (i32.eq (local.get $body_tag) (i32.const 113))
      (then (return (call $lexpr_make_lconst (local.get $handle) (i32.const 0)))))
    ;; NStmt (111) — read inner Stmt + dispatch on Stmt tag.
    (if (i32.ne (local.get $body_tag) (i32.const 111))
      (then (unreachable)))
    (local.set $stmt (i32.load offset=4 (local.get $body)))
    (local.set $stmt_tag (call $tag_of (local.get $stmt)))
    (if (i32.eq (local.get $stmt_tag) (i32.const 120))
      (then (return (call $lower_walk_stmt_let
              (local.get $stmt) (local.get $handle)))))
    (if (i32.eq (local.get $stmt_tag) (i32.const 121))
      (then (return (call $lower_walk_stmt_fn
              (local.get $stmt) (local.get $handle)))))
    (if (i32.eq (local.get $stmt_tag) (i32.const 122))
      (then (return (call $lower_walk_stmt_typedef
              (local.get $stmt) (local.get $handle)))))
    (if (i32.eq (local.get $stmt_tag) (i32.const 123))
      (then (return (call $lower_walk_stmt_effect_decl
              (local.get $stmt) (local.get $handle)))))
    (if (i32.eq (local.get $stmt_tag) (i32.const 124))
      (then (return (call $lower_walk_stmt_handler_decl
              (local.get $stmt) (local.get $handle)))))
    (if (i32.eq (local.get $stmt_tag) (i32.const 125))
      (then (return (call $lower_walk_stmt_expr
              (local.get $stmt) (local.get $handle)))))
    (if (i32.eq (local.get $stmt_tag) (i32.const 126))
      (then (return (call $lower_walk_stmt_import
              (local.get $stmt) (local.get $handle)))))
    (if (i32.eq (local.get $stmt_tag) (i32.const 127))
      (then (return (call $lower_walk_stmt_refine
              (local.get $stmt) (local.get $handle)))))
    (if (i32.eq (local.get $stmt_tag) (i32.const 128))
      (then (return (call $lower_walk_stmt_documented
              (local.get $stmt) (local.get $handle)))))
    ;; NErrorStmt (129): productive-under-error sentinel from parser.
    ;; Per protocol_parser_fabrication_substrate.md + DESIGN.md §4
    ;; (NErrorHole peer at graph layer): skip emit; the stmt-list walk
    ;; continues; well-typed sibling code still lowers cleanly.
    ;; LConst sentinel matches NPat/NHole degenerate pattern above.
    (if (i32.eq (local.get $stmt_tag) (i32.const 129))
      (then (return (call $lexpr_make_lconst (local.get $handle) (i32.const 0)))))
    ;; H6 wildcard: unknown Stmt tag.
    (unreachable))

  ;; ─── $lower_stmt_list — buffer-counter iteration (Lock #11) ─────────
  ;; Per src/lower.mn:556-558 wheel SHAPE; seed Ω.3 buffer-counter.
  (func $lower_stmt_list (export "lower_stmt_list")
        (param $stmts i32) (result i32)
    (local $n i32) (local $i i32) (local $buf i32)
    (local $stmt_node i32) (local $lowered i32)
    (local.set $n   (call $len (local.get $stmts)))
    (local.set $buf (call $make_list (i32.const 0)))
    (local.set $buf (call $list_extend_to (local.get $buf) (local.get $n)))
    (local.set $i   (i32.const 0))
    (block $done
      (loop $each
        (br_if $done (i32.ge_u (local.get $i) (local.get $n)))
        (local.set $stmt_node (call $list_index (local.get $stmts) (local.get $i)))
        (local.set $lowered   (call $lower_stmt (local.get $stmt_node)))
        (drop (call $list_set (local.get $buf) (local.get $i) (local.get $lowered)))
        (local.set $i (i32.add (local.get $i) (i32.const 1)))
        (br $each)))
    (local.get $buf))
