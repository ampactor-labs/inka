  ;; ═══ walk_call.wat — Hβ.lower CallExpr/PerformExpr/ResumeExpr arms (Tier 7) ═══
  ;; Hβ.lower cascade chunk #7 of 11 per Hβ-lower-substrate.md §12.3 dep order.
  ;;
  ;; What this chunk IS (per Hβ-lower-substrate.md §3.2 + §4.2):
  ;;   The seed's gradient cash-out site. Each call site reads $monomorphic_at
  ;;   (lookup.wat) — Pure/Closed → direct LCall (zero indirection); Open →
  ;;   LSuspend with evidence-slot list per H1.6 substrate. Each PerformExpr
  ;;   reads ResumeDiscipline (deferred per Lock #2) and emits LPerform.
  ;;   ResumeExpr collapses to LReturn per the wheel's "structurally a
  ;;   return from the arm" discipline (src/lower.mn:445-448).
  ;;
  ;;   THIS IS WHERE THE ROW INFERENCE'S >95% MONOMORPHIC CLAIM
  ;;   BECOMES PHYSICAL. The LCall vs LSuspend tag IS the gradient bit;
  ;;   emit reads the tag at WAT-text time to choose `call` vs
  ;;   `call_indirect`.
  ;;
  ;; Implements: Hβ-lower-substrate.md §3.2 + §4.2 + §6.2 + §11 + §12.3 #7;
  ;;             src/lower.mn:242-249 lower_call_default (Lock #1 LSuspend);
  ;;             src/lower.mn:347-367 CallExpr arm (Lock #3 schemekind defer);
  ;;             src/lower.mn:442-443 PerformExpr arm (Lock #2 wheel parity);
  ;;             src/lower.mn:445-448 ResumeExpr → LReturn (Lock #6);
  ;;             src/lower.mn:258-292 derive_ev_slots family (Lock #7 empty
  ;;             seed default per named follow-up).
  ;; Exports:    $lower_call,
  ;;             $lower_call_default,
  ;;             $lower_perform,
  ;;             $lower_resume,
  ;;             $derive_ev_slots,
  ;;             $lower_args
  ;; Uses:       $walk_expr_node_handle (infer/walk_expr.wat:306 — cross-layer),
  ;;             $lookup_ty / $monomorphic_at (lower/lookup.wat),
  ;;             $lexpr_make_lcall / lsuspend / lperform / lreturn (lower/lexpr.wat),
  ;;             $lower_expr (lower/main.wat — chunk #11; forward-resolves at
  ;;               assembly time per WAT module-internal call discipline),
  ;;             $make_list / $list_index / $list_set / $list_extend_to /
  ;;               $len (runtime/list.wat)
  ;; Test:       bootstrap/test/lower/walk_call_monomorphic.wat,
  ;;             bootstrap/test/lower/walk_call_polymorphic.wat,
  ;;             bootstrap/test/lower/walk_perform_oneshot.wat
  ;;
  ;; ═══ LOCKS (wheel-canonical override walkthrough §4.2 prose) ════════
  ;;
  ;; Lock #1: Polymorphic call → LSuspend tag 325, NOT LMakeClosure.
  ;;          Per src/lower.mn:242-249. The walkthrough §4.2 line 461
  ;;          prescribes LMakeClosure; the wheel emits LSuspend with
  ;;          ev_slots list. Seed transcribes wheel.
  ;;
  ;; Lock #2: $lower_perform emits straight LPerform regardless of
  ;;          ResumeDiscipline (wheel parity per src/lower.mn:442-443).
  ;;          The wheel's PerformExpr arm at line 442 is two lines, no
  ;;          dispatch on op-type's discipline. MultiShot wiring named-
  ;;          follow-up Hβ.lower.perform-multishot-dispatch — lands
  ;;          alongside cont.wat seed-bridging + state.wat current_fn
  ;;          tracking + ms_alloc_state/ret_slot helpers.
  ;;
  ;; Lock #3: CallExpr-callee schemekind triage deferred. Per
  ;;          Hβ.lower.varref-schemekind-dispatch (named at chunk #6 —
  ;;          this is second caller; the third earns the abstraction).
  ;;          $lower_call routes ALWAYS to $lower_call_default for the
  ;;          seed; ConstructorScheme → LMakeVariant + EffectOpScheme →
  ;;          LPerform short-circuits land when the third caller earns
  ;;          per Anchor 7.
  ;;
  ;; Lock #4: $env_lookup_op_type does NOT exist; per Lock #2 the seed's
  ;;          perform path doesn't need op-type since the dispatch
  ;;          collapses to wheel-parity LPerform. Named-follow-up
  ;;          Hβ.lower.op-type-resolution covers when MultiShot lands.
  ;;
  ;; Lock #5: $lower_args is chunk-private (per src/lower.mn:1055-1057
  ;;          lower_expr_list). Helpers used by exactly one chunk live in
  ;;          that chunk; third caller earns the factor.
  ;;
  ;; Lock #6: ResumeExpr → LReturn (src/lower.mn:445-448 wheel canonical).
  ;;          "Structurally a return from the arm." No invocation of
  ;;          cont.wat heap-captured continuation at the lowering layer
  ;;          — that's emit's H7 dispatch concern.
  ;;
  ;; Lock #7: $derive_ev_slots returns empty list unconditionally for
  ;;          the seed. Reasoning: the wheel's str_concat("op_", name,
  ;;          "_idx") at src/lower.mn:288 requires data segments
  ;;          ([0, 4096) is densely packed; placing strings ≥ 4096 risks
  ;;          $tag_of misclassification). Chunk #5 conservative-Linear
  ;;          precedent applies — substrate-honest deferral with named
  ;;          follow-up Hβ.lower.derive-ev-slots-naming. LSuspend's evs
  ;;          field is structurally empty until the follow-up. Emit
  ;;          handles op-name lookup at WAT-text time (per the
  ;;          divergence — emit grows the prefix/suffix substrate
  ;;          alongside its existing data-segment region).
  ;;
  ;; ═══ EIGHT INTERROGATIONS (per Hβ-lower-substrate.md §5.3 projected
  ;;                            onto walk_call.wat) ═══════════════════════
  ;;
  ;; 1. Graph?       Each arm reads $walk_expr_node_handle(node) (offset 12).
  ;;                 $lower_call_default calls $lookup_ty on the callee
  ;;                 handle — which IS $graph_chase. Read-only on graph.
  ;;
  ;; 2. Handler?     Wheel: lower_call participates in
  ;;                 LookupTy + LowerCtx + EnvRead + Diagnostic chain
  ;;                 @resume=OneShot. Seed: 6 direct functions.
  ;;                 $classify_handler (chunk #5) NOT INVOKED HERE —
  ;;                 handler classification is walk_handle.wat's concern.
  ;;
  ;; 3. Verb?        CallExpr is desugared `|>` (per spec 10:
  ;;                 `left |> right` → `LCall(h, right, [left])`). Walk_call's
  ;;                 residue IS the call shape. PerformExpr's verb is
  ;;                 ~>'s runtime peer. PipeExpr direct lowering lands
  ;;                 at chunk #8 walk_handle.wat.
  ;;
  ;; 4. Row?         $monomorphic_at IS the gradient gate. THIS CHUNK
  ;;                 IS THE ROW'S COMPILE-TIME CASH-OUT SITE.
  ;;                 $derive_ev_slots reads the callee's TFun row variant
  ;;                 (Lock #7 conservative empty-list seed; full row.names
  ;;                 walk lands at named follow-up).
  ;;
  ;; 5. Ownership?   LSuspend/LCall/LPerform/LReturn records are `own`
  ;;                 of the bump allocator. Args list is `ref`. ev_slots
  ;;                 list is `own` (newly built — empty per Lock #7).
  ;;                 $lower_args allocates one fresh list per call via
  ;;                 $make_list + buffer-counter (Ω.3).
  ;;
  ;; 6. Refinement?  TRefined transparent. $lookup_ty dispatches it as
  ;;                 the underlying type. No explicit refinement check;
  ;;                 verify ledger holds it.
  ;;
  ;; 7. Gradient?    THIS CHUNK IS THE CASH-OUT SITE. The LCall vs
  ;;                 LSuspend choice IS the row inference's >95%
  ;;                 monomorphic claim made physical. Tag chosen
  ;;                 (308 vs 325) carries information emit reads to
  ;;                 choose direct `call` vs `call_indirect`. Each
  ;;                 $lower_call_default invocation cashes one row-
  ;;                 inference win.
  ;;
  ;; 8. Reason?      Read-only. The callee handle's GNode carries the
  ;;                 Reason chain. LSuspend's op_h field (set to fh)
  ;;                 preserves the bridge so emit can walk back via
  ;;                 $gnode_reason if it surfaces a polymorphic-call
  ;;                 diagnostic.
  ;;
  ;; ═══ FORBIDDEN PATTERNS AUDIT ════════════════════════════════════
  ;;
  ;; - Drift 1 (Rust vtable):        CRITICAL per walkthrough §6.2.
  ;;                                  Polymorphic LCall path emits
  ;;                                  LSuspend with fn_index as a FIELD
  ;;                                  on the closure record (lexpr.wat
  ;;                                  arity-5); emit's call_indirect
  ;;                                  reads the field at H1.4 site —
  ;;                                  NOT a $op_table data segment. The
  ;;                                  word "vtable" appears NOWHERE in
  ;;                                  this chunk except in this audit.
  ;;
  ;; - Drift 4 (monad transformer):   No LowerM. Each $lower_<x> is
  ;;                                  (param i32) (result i32). Direct.
  ;;
  ;; - Drift 5 (C calling convention): $lower_call_default takes 4 i32
  ;;                                  params, all structurally meaningful
  ;;                                  per src/lower.mn:242 wheel signature.
  ;;                                  NO __closure + __ev + __ret_slot
  ;;                                  split. NO H7 multi-param resume_fn
  ;;                                  signature here (resume_fn lives at
  ;;                                  runtime cont.wat per H7 §1.2).
  ;;
  ;; - Drift 6 (primitive-special-case): $monomorphic_at returns i32 0/1
  ;;                                  — same nullary discipline as
  ;;                                  Bool/TInt/ResumeDiscipline. NO
  ;;                                  carveout.
  ;;
  ;; - Drift 7 (parallel-arrays):     ev_slots is one list of LowExpr
  ;;                                  records (Lock #7: empty seed
  ;;                                  default). NOT parallel _names_ptr
  ;;                                  + _slots_ptr arrays.
  ;;
  ;; - Drift 8 (string-keyed):        Tag-int dispatch only. The op_name
  ;;                                  in LPerform IS a string (per
  ;;                                  lexpr.wat tag 331 wheel canonical)
  ;;                                  — but it's THREADED, not COMPARED.
  ;;                                  No `if str_eq(op_name, "choose")`
  ;;                                  dispatch decision.
  ;;
  ;; - Drift 9 (deferred-by-omission): All 6 exports FULLY BODIED this
  ;;                                  commit. ResumeDiscipline arms in
  ;;                                  $lower_perform collapse to wheel-
  ;;                                  parity LPerform per Lock #2 — not
  ;;                                  a stub. MultiShot enrichment is
  ;;                                  named peer follow-up. $derive_ev_slots
  ;;                                  empty-list seed default per Lock #7
  ;;                                  is bodied with explicit reasoning;
  ;;                                  full naming is named peer follow-up.
  ;;                                  $lower_resume bodied this commit
  ;;                                  even though parser-side
  ;;                                  $mk_ResumeExpr does not yet exist
  ;;                                  (drift-9-safe: an unconstructible
  ;;                                  AST tag will simply never reach
  ;;                                  this arm; if/when parser produces
  ;;                                  tag 95, body is correct per wheel
  ;;                                  canonical).
  ;;
  ;; - Foreign fluency JS async/await: NEVER "promise call" / "async call"
  ;;                                  / "future" / "await". Vocabulary is
  ;;                                  LPerform / LSuspend / "perform-op"
  ;;                                  per spec 05.
  ;;
  ;; - Foreign fluency Scheme call/cc: Continuations are DELIMITED
  ;;                                  (handler-install scope). NEVER
  ;;                                  "undelimited" / "call/cc" /
  ;;                                  "captured stack".
  ;;
  ;; - Foreign fluency LLVM/GHC IR:   NEVER "SSA value" / "phi node" /
  ;;                                  "calling convention enum" /
  ;;                                  "core IR". Vocabulary stays Mentl:
  ;;                                  LowExpr / LCall / LSuspend /
  ;;                                  LPerform / LReturn per spec 05.
  ;;
  ;; ═══ Named follow-ups (Drift 9 closure) ═════════════════════════════
  ;;
  ;;   - Hβ.lower.perform-multishot-dispatch:
  ;;                 wheel grows ResumeDiscipline-aware PerformExpr arm;
  ;;                 seed grows $current_fn_handle tracking +
  ;;                 $ms_alloc_state/$ms_alloc_ret_slot substrate +
  ;;                 cont.wat seed-bridge; emits
  ;;                 LBlock(LMakeContinuation, LPerform) pair.
  ;;
  ;;   - Hβ.lower.derive-ev-slots-naming:
  ;;                 Wheel str_concat("op_", op_name, "_idx") at
  ;;                 src/lower.mn:288 lands in this chunk + emit grows
  ;;                 prefix/suffix data-segment naming; LSuspend's evs
  ;;                 list becomes per-name LGlobal records.
  ;;
  ;;   - Hβ.lower.resume-harness:
  ;;                 Parser-side $mk_ResumeExpr ships; ResumeExpr
  ;;                 trace-harness can construct + verify $lower_resume.
  ;;
  ;;   - Hβ.lower.lower-call-default-signature-alignment:
  ;;                 Third caller (walk_compound or walk_handle) earns
  ;;                 the wheel's (handle, f_node, fh, lo_args) signature
  ;;                 with internal recursion. Until then, this chunk's
  ;;                 (handle, lo_f, fh, lo_args) form (caller pre-lowers)
  ;;                 stands.
  ;;
  ;;   - Hβ.lower.varref-schemekind-dispatch:
  ;;                 (extends from chunk #6) ConstructorScheme +
  ;;                 EffectOpScheme triage in $lower_call routes to
  ;;                 LMakeVariant / LPerform short-circuits before
  ;;                 falling through to $lower_call_default.
  ;;
  ;;   - Hβ.lower.op-type-resolution:
  ;;                 MultiShot dispatch needs op-type's ResumeDiscipline;
  ;;                 lands alongside perform-multishot-dispatch.
  ;;
  ;;   - Hβ.lower.resume-state-updates-threading:
  ;;                 Wheel grows state-machine threading at handler-
  ;;                 elimination; ResumeExpr's state_updates payload
  ;;                 becomes load-bearing.

  ;; ─── $lower_expr — partial dispatcher (forward-decl bridge) ──────
  ;; Per the cascade dep-order surfacing: $lower_expr is the
  ;; canonical top-level dispatcher per Hβ-lower-substrate.md §4.1
  ;; and lands at chunk #11 main.wat (the orchestrator). But walk_call,
  ;; walk_handle, walk_compound, walk_stmt all need recursive
  ;; sub-expression lowering BEFORE chunk #11 lands. The Hβ.infer
  ;; cascade resolved an analogous forward-decl (walk_expr:824 →
  ;; walk_stmt:$infer_stmt_list) by both chunks landing in the same
  ;; assembled mentl.wat — but here chunk #11 hasn't been written yet.
  ;;
  ;; Resolution: define $lower_expr HERE as a partial dispatcher over
  ;; the tags chunks #6 + #7 know about. Future walk chunks (#8-#10)
  ;; retrofit this dispatcher (adding their tag arms) per named follow-up
  ;; Hβ.lower.lower-expr-dispatch-extension. Chunk #11 main.wat owns
  ;; the orchestrator $lower_program but DOES NOT redefine $lower_expr
  ;; — by then this dispatcher is complete via cumulative retrofits.
  ;;
  ;; Drift-9-safe: every tag this dispatcher claims to know IS bodied;
  ;; unknown tags trap via (unreachable) — the trap surfaces when a
  ;; future walk chunk forgets to retrofit. Named follow-up makes the
  ;; expansion visible.
  ;;
  ;; Currently dispatches:
  ;;   80 LitInt    → $lower_lit_int       (chunk #6 walk_const)
  ;;   81 LitFloat  → $lower_lit_float
  ;;   82 LitString → $lower_lit_string
  ;;   83 LitBool   → $lower_lit_bool
  ;;   84 LitUnit   → $lower_lit_unit
  ;;   85 VarRef    → $lower_var_ref
  ;;   87 UnaryOp   → $lower_unary_op      (chunk #9 retrofit)
  ;;   88 CallExpr  → $lower_call          (this chunk #7)
  ;;   89 Lambda    → $lower_lambda        (chunk #9 retrofit)
  ;;   90 If        → $lower_if            (chunk #9 retrofit)
  ;;   91 Block     → $lower_block         (chunk #9 retrofit)
  ;;   92 Match     → $lower_match         (chunk #9 retrofit)
  ;;   93 HandleExpr → $lower_handle       (chunk #8 retrofit)
  ;;   94 Perform    → $lower_perform
  ;;   95 Resume     → $lower_resume
  ;;   96 MakeList   → $lower_make_list    (chunk #9 retrofit)
  ;;   97 MakeTuple  → $lower_make_tuple   (chunk #9 retrofit)
  ;;   98 MakeRecord → $lower_make_record  (chunk #9 retrofit)
  ;;   99 NamedRecord → $lower_named_record (chunk #9 retrofit)
  ;;   100 FieldExpr → $lower_field        (chunk #9 retrofit)
  ;;   101 PipeExpr  → $lower_pipe         (chunk #8 retrofit)
  ;;
  ;; Unknown (BinOpExpr 86 — chunk #6 BinOp arm pending; future Expr-region
  ;; growth) → (unreachable) trap. Named follow-up
  ;; Hβ.lower.lower-expr-dispatch-extension closes BinOp at the next
  ;; cycle.
  ;;
  ;; AST navigation: $node is the N-wrapper; tag dispatch reads
  ;; offset 4 → NExpr → offset 4 → variant Expr; tag is at offset 0
  ;; of the variant Expr.
  (func $lower_expr (export "lower_expr") (param $node i32) (result i32)
    (local $body i32) (local $expr i32) (local $tag i32)
    (local.set $body (i32.load offset=4 (local.get $node)))
    (local.set $expr (i32.load offset=4 (local.get $body)))
    ;; Read the Expr tag via $tag_of — NOT a raw (i32.load offset=0). A
    ;; nullary-sentinel variant (LitUnit=84, and any other nullary Expr
    ;; whose variant is the bare tag, not a heap record) lives in the
    ;; sentinel region [0, heap_base); dereferencing it reads address 84
    ;; → 0 → the unknown-tag catch-all → LConst(0) corruption. $tag_of
    ;; returns the value itself when it is a sentinel and loads [0] only
    ;; for heap records — exactly as infer's $walk_expr_expr_tag does
    ;; (walk_expr.wat:322). This is the SAME-reader discipline: lower
    ;; classifies the Expr the way infer classified it.
    (local.set $tag  (call $tag_of (local.get $expr)))
    (if (i32.eq (local.get $tag) (i32.const 80))
      (then (return (call $lower_lit_int    (local.get $node)))))
    (if (i32.eq (local.get $tag) (i32.const 81))
      (then (return (call $lower_lit_float  (local.get $node)))))
    (if (i32.eq (local.get $tag) (i32.const 82))
      (then (return (call $lower_lit_string (local.get $node)))))
    (if (i32.eq (local.get $tag) (i32.const 83))
      (then (return (call $lower_lit_bool   (local.get $node)))))
    (if (i32.eq (local.get $tag) (i32.const 84))
      (then (return (call $lower_lit_unit   (local.get $node)))))
    (if (i32.eq (local.get $tag) (i32.const 85))
      (then (return (call $lower_var_ref    (local.get $node)))))
    (if (i32.eq (local.get $tag) (i32.const 88))
      (then (return (call $lower_call       (local.get $node)))))
    (if (i32.eq (local.get $tag) (i32.const 94))
      (then (return (call $lower_perform    (local.get $node)))))
    (if (i32.eq (local.get $tag) (i32.const 95))
      (then (return (call $lower_resume     (local.get $node)))))
    (if (i32.eq (local.get $tag) (i32.const 93))
      (then (return (call $lower_handle     (local.get $node)))))
    (if (i32.eq (local.get $tag) (i32.const 101))
      (then (return (call $lower_pipe       (local.get $node)))))
    (if (i32.eq (local.get $tag) (i32.const 86))
      (then (return (call $lower_binop       (local.get $node)))))
    (if (i32.eq (local.get $tag) (i32.const 87))
      (then (return (call $lower_unary_op    (local.get $node)))))
    (if (i32.eq (local.get $tag) (i32.const 89))
      (then (return (call $lower_lambda      (local.get $node)))))
    (if (i32.eq (local.get $tag) (i32.const 90))
      (then (return (call $lower_if          (local.get $node)))))
    (if (i32.eq (local.get $tag) (i32.const 91))
      (then (return (call $lower_block       (local.get $node)))))
    (if (i32.eq (local.get $tag) (i32.const 92))
      (then (return (call $lower_match       (local.get $node)))))
    (if (i32.eq (local.get $tag) (i32.const 96))
      (then (return (call $lower_make_list   (local.get $node)))))
    (if (i32.eq (local.get $tag) (i32.const 103))
      (then (return (call $lower_make_string (local.get $node)))))
    (if (i32.eq (local.get $tag) (i32.const 97))
      (then (return (call $lower_make_tuple  (local.get $node)))))
    (if (i32.eq (local.get $tag) (i32.const 98))
      (then (return (call $lower_make_record (local.get $node)))))
    (if (i32.eq (local.get $tag) (i32.const 99))
      (then (return (call $lower_named_record (local.get $node)))))
    (if (i32.eq (local.get $tag) (i32.const 100))
      (then (return (call $lower_field       (local.get $node)))))
    (if (i32.eq (local.get $tag) (i32.const 104))   ;; IndexExpr — xs[i]
      (then (return (call $lower_index       (local.get $node)))))
    ;; NErrorExpr (102): productive-under-error sentinel from parser.
    ;; Per protocol_parser_fabrication_substrate.md + DESIGN.md §4
    ;; (NErrorHole peer at graph layer): parse-time diagnostic already
    ;; surfaced; emit LConst-0 (the WAT $unreachable equivalent for
    ;; sentinel propagation) so the surrounding expr composes cleanly.
    ;; No re-diagnose — the parser owned the report.
    (if (i32.eq (local.get $tag) (i32.const 102))
      (then (return (call $lexpr_make_lconst
                          (call $walk_expr_node_handle (local.get $node))
                          (i32.const 0)))))
    ;; Unknown tag — productive-under-error per Hazel discipline.
    ;; Emit diagnostic, return unit-sentinel LConst so callers can compose.
    (call $lower_emit_unresolved_type (call $walk_expr_node_handle (local.get $node)))
    (call $lexpr_make_lconst
      (call $walk_expr_node_handle (local.get $node))
      (i32.const 0)))

  ;; ─── $lower_index — IndexExpr (104) xs[i] → list_index call ─────────────
  ;; The TYPE (element a) was projected by infer onto this node's handle (the
  ;; kernel sequence-index projection). Lower emits the substrate access by
  ;; reconstructing Call(VarRef("list_index"), [recv, idx]) and lowering it —
  ;; the same call the old parse-time desugar produced, relocated here so infer
  ;; saw the element-typed IndexExpr first. The reconstructed node carries THIS
  ;; node's handle so the lowered call's result is the element, not a fresh var.
  (func $lower_index (param $node i32) (result i32)
    (local $body i32) (local $expr i32) (local $rec i32) (local $idx i32)
    (local $span i32) (local $args i32) (local $call_node i32)
    (local.set $body (i32.load offset=4 (local.get $node)))
    (local.set $expr (i32.load offset=4 (local.get $body)))
    (local.set $rec  (i32.load offset=4 (local.get $expr)))
    (local.set $idx  (i32.load offset=8 (local.get $expr)))
    (local.set $span (i32.load offset=8 (local.get $node)))
    (local.set $args (call $make_list (i32.const 2)))
    (drop (call $list_set (local.get $args) (i32.const 0) (local.get $rec)))
    (drop (call $list_set (local.get $args) (i32.const 1) (local.get $idx)))
    (local.set $call_node (call $nexpr
      (call $mk_CallExpr
        (call $nexpr (call $mk_VarRef (i32.const 4288)) (local.get $span))
        (local.get $args))
      (local.get $span)))
    (i32.store offset=12 (local.get $call_node)
      (i32.load offset=12 (local.get $node)))   ;; carry IndexExpr's handle (element)
    (call $lower_call (local.get $call_node)))

  ;; ─── $lower_args — chunk-private buffer-counter helper (Lock #5) ──
  ;; Per src/lower.mn:1055-1057 lower_expr_list. Buffer-counter substrate
  ;; (Ω.3 per CLAUDE.md memory model — avoids O(N²) `acc ++ [x]`).
  ;; Each arg is an N-wrapper; $lower_expr (chunk #11 main.wat —
  ;; forward-resolves at WAT module assembly time) returns the LowExpr.
  (func $lower_args (param $args i32) (result i32)
    (local $n i32) (local $i i32) (local $buf i32)
    (local $arg_node i32) (local $arg_lo i32)
    (local.set $n (call $len (local.get $args)))
    (local.set $buf (call $make_list (i32.const 0)))
    (local.set $buf (call $list_extend_to (local.get $buf) (local.get $n)))
    (local.set $i (i32.const 0))
    (block $done
      (loop $each
        (br_if $done (i32.ge_u (local.get $i) (local.get $n)))
        (local.set $arg_node (call $list_index (local.get $args) (local.get $i)))
        (local.set $arg_lo   (call $lower_expr  (local.get $arg_node)))
        (drop (call $list_set (local.get $buf) (local.get $i) (local.get $arg_lo)))
        (local.set $i (i32.add (local.get $i) (i32.const 1)))
        (br $each)))
    (local.get $buf))

  ;; ─── $derive_ev_slots — H1.6 evidence list (Hβ.first-light.perform-evidence) ──
  ;; Per Hβ-perform-evidence-dispatch.md §4.7. The handler-record evidence the
  ;; caller threads into the callee's record so the callee's deep performs
  ;; dispatch to the right handler. Single-open-effect L1 scope: produce
  ;; exactly ONE ev-slot (matches $emit_levperform's single-slot read).
  ;;   - callee not TFun / pure row → no evidence ([]) → caller emits LCall.
  ;;   - a lexical handler for some effect in the callee's row is on the
  ;;     lower handler-stack → evidence = LLocal("__hstate_<h>") (the install
  ;;     local holding that handler's record).
  ;;   - else (the effect is open in the current fn's own row, by the
  ;;     row-typing invariant) → forward the current fn's own ev-slot 0 via
  ;;     LEvSlotRef(0).
  ;; Multi-distinct-effect rows need an ev_index→effect map (named peer
  ;; Hβ.lower.multi-effect-ev-index-map). Builtin-only rows (WASI/Memory)
  ;; get a harmless unused forward slot — the perform short-circuits to
  ;; direct emit and never reads it; precise builtin-effect filtering is the
  ;; named optimization peer Hβ.lower.ev-slot-builtin-effect-filter.
  ;; Builtin effects — the raw substrate IS their handler (wasi import /
  ;; wasm instruction); no handler record exists to thread. One shared
  ;; projection feeds BOTH derive_ev_slots and the callee's own slot
  ;; indexing, so caller layout and callee reads stay one truth.
  ;; Closes Hβ.lower.ev-slot-builtin-effect-filter.
  (data (i32.const 6496) "\06\00\00\00Memory")
  (data (i32.const 6512) "\05\00\00\00Alloc")
  (data (i32.const 6528) "\04\00\00\00WASI")
  ;; $lower_resume snapshot scratch-name fragments (wheel parity:
  ;; lower_resume_snapshot mints "__resume_val_<h>" / "__resume_upd_<i>_<h>").
  (data (i32.const 6576) "\0d\00\00\00__resume_val_")
  (data (i32.const 6596) "\0d\00\00\00__resume_upd_")
  (data (i32.const 6616) "\01\00\00\00_")
  (func $row_dispatched_names (param $names i32) (result i32)
    (local $n i32) (local $i i32) (local $name i32)
    (local $buf i32) (local $count i32)
    (local.set $n (call $len (local.get $names)))
    (local.set $buf (call $make_list (local.get $n)))
    (local.set $count (i32.const 0))
    (local.set $i (i32.const 0))
    (block $done
      (loop $each
        (br_if $done (i32.ge_u (local.get $i) (local.get $n)))
        ;; Project the name-set ELEMENT to its bare NAME string ($eff_name_str:
        ;; a parameterized entry's payload rides on the row for inference but
        ;; dispatch indexes by name alone). Every downstream ev-slot consumer
        ;; reads this bare-string projection, so the dispatch layer is invariant
        ;; to the row carrying payload types.
        (local.set $name (call $eff_name_str
          (call $list_index (local.get $names) (local.get $i))))
        (if (i32.eqz (i32.or (i32.or
              (call $str_eq (local.get $name) (i32.const 6496))
              (call $str_eq (local.get $name) (i32.const 6512)))
              (call $str_eq (local.get $name) (i32.const 6528))))
          (then
            (drop (call $list_set (local.get $buf) (local.get $count) (local.get $name)))
            (local.set $count (i32.add (local.get $count) (i32.const 1)))))
        (local.set $i (i32.add (local.get $i) (i32.const 1)))
        (br $each)))
    (call $slice (local.get $buf) (i32.const 0) (local.get $count)))

  ;; ─── $lower_ev_index_in_frame — which of MY ev slots holds $ename ────
  ;; The one projection both perform-dispatch and derive_ev_slots index
  ;; with. Inside a handler arm body, the frame's evidence is the
  ;; record-captured set (first-encounter ledger order); everywhere
  ;; else it is the fn's row (canonical order). One index space per
  ;; frame shape — Hβ.emit.handler-record-ev-capture.
  (func $lower_ev_index_in_frame (param $ename i32) (result i32)
    (if (call $lower_arm_ev_active)
      (then (return (call $lower_arm_ev_index_for (local.get $ename)))))
    (call $lower_compute_ev_index_for_effect (local.get $ename)))

  ;; ─── $lower_ev_slot_raw — the effect's slot in THIS frame's row, or -1 ──
  ;; The UN-clamped read for the dispatch gradient: -1 means the frame does NOT
  ;; thread $ename (it is ambient / home-dispatched), so the gradient branches
  ;; to the singleton home rather than fabricating slot 0. Arm bodies append on
  ;; first-encounter (always >= 0); a fn-body searches its row and returns -1
  ;; when absent. NO eprint — a not-found here is the CORRECT home-dispatch path,
  ;; not the row-conservation leak.
  (func $lower_ev_slot_raw (param $ename i32) (result i32)
    (local $fn_name i32) (local $binding i32) (local $scheme i32)
    (local $names i32) (local $n i32) (local $j i32)
    (if (call $lower_arm_ev_active)
      (then (return (call $lower_arm_ev_index_for (local.get $ename)))))
    (if (i32.eqz (local.get $ename)) (then (return (i32.const -1))))
    (local.set $fn_name (call $ls_outer_fn_name))
    (if (i32.eqz (local.get $fn_name)) (then (return (i32.const -1))))
    (local.set $binding (call $env_lookup_value (local.get $fn_name)))
    (if (i32.eqz (local.get $binding)) (then (return (i32.const -1))))
    (local.set $scheme (call $env_binding_scheme (local.get $binding)))
    (if (i32.lt_u (local.get $scheme) (global.get $heap_base)) (then (return (i32.const -1))))
    (local.set $names (call $effects_of (call $scheme_body (local.get $scheme))))
    (local.set $n (call $len (local.get $names)))
    (local.set $j (i32.const 0))
    (block $found
      (loop $search
        (br_if $found (i32.ge_u (local.get $j) (local.get $n)))
        (if (call $str_eq (call $list_index (local.get $names) (local.get $j))
                          (local.get $ename))
          (then (return (local.get $j))))
        (local.set $j (i32.add (local.get $j) (i32.const 1)))
        (br $search)))
    (i32.const -1))

  ;; ─── $effects_of — THE SEAM (master plan §6 1★ Stage 0). The single
  ;; projection of a fn's dispatched effect-row names (canonical order, builtins
  ;; filtered). The CALLER building a callee's __state ($derive_ev_slots, via the
  ;; callee's type) and the CALLEE reading its own slot
  ;; ($lower_compute_ev_index_for_effect, via its own scheme) BOTH read through
  ;; THIS ONE truth, so their slots agree BY CONSTRUCTION — the dual re-derivation
  ;; collapses to one read. Today reads the inferred TFun row from the graph;
  ;; Stage 1 swaps THIS BODY to the live flow-closure and NEITHER consumer
  ;; changes (docs/specs/simulations/polymorphism-as-flow-edges.md §8 Step 0/1).
  ;; The TFun row field is a row-var HANDLE — chase it to the bound EffRow; row
  ;; resolution is independent of value-type (NFre) resolution. Closed/Open carry
  ;; nameable effects; Pure → none; Neg/Sub/Inter/unresolved → none (row_names
  ;; traps). Builtins (Memory/Alloc/WASI) carry NO ev slot ($row_dispatched_names
  ;; filters them) — the raw substrate IS their handler.
  (func $effects_of (export "effects_of") (param $fn_ty i32) (result i32)
    (local $row i32)
    (if (i32.lt_u (local.get $fn_ty) (global.get $heap_base))
      (then (return (call $make_list (i32.const 0)))))
    (if (i32.ne (call $ty_tag (local.get $fn_ty)) (i32.const 107))   ;; not TFun
      (then (return (call $make_list (i32.const 0)))))
    (local.set $row (call $lookup_row_for (call $ty_tfun_row (local.get $fn_ty))))
    (if (i32.eqz (i32.or (call $row_is_closed (local.get $row))
                         (call $row_is_open   (local.get $row))))
      (then (return (call $make_list (i32.const 0)))))
    (call $row_dispatched_names (call $row_names (local.get $row))))

  ;; ─── $resolve_evs_for_names — effect-names → evidence list (the shared read) ─
  ;; One ev per USER effect, in canonical (sorted-lex) order = the callee's
  ;; ev-slot order. Both the call-seam ($derive_ev_slots — names from the
  ;; callee's env scheme) and a closure's OWN evidence ($derive_closure_evs —
  ;; names from its handle's inferred row) resolve through HERE: one projection,
  ;; two effect-sources, never the call-site instantiation.
  (func $resolve_evs_for_names (param $names i32) (result i32)
    (local $n i32) (local $i i32)
    (local $ename i32) (local $state_local i32) (local $evs i32) (local $hname i32) (local $raw i32)
    (local.set $n (call $len (local.get $names)))
    (if (i32.eqz (local.get $n))
      (then (return (call $make_list (i32.const 0)))))
    ;; ONE ev per USER effect, in canonical (sorted-lex, builtins removed)
    ;; order = the
    ;; callee's ev-slot order (ec6_emit_ev_slot_stores writes evs[i] at the
    ;; callee record's slot i). Each effect resolves to its handler record:
    ;;   - lexically installed in THIS scope → LLocal(install_local);
    ;;   - else forward THIS fn's own ev-slot for that effect →
    ;;     LEvSlotRef(effect's index in THIS fn's row).
    ;; The shared sorted-lex order makes the caller→callee slot remapping
    ;; correct WITHOUT a coercion table (Koka evidence coercion, by
    ;; construction — Hβ.lower.multi-effect-ev-index-map). A builtin effect
    ;; (WASI/Memory) gets a forward slot that is never read (its perform
    ;; short-circuits to direct emit) — harmless, and keeps the user effects
    ;; beside it at their correct indices.
    (local.set $evs (call $list_extend_to (call $make_list (i32.const 0)) (local.get $n)))
    (local.set $i (i32.const 0))
    (block $done
      (loop $each
        (br_if $done (i32.ge_u (local.get $i) (local.get $n)))
        (local.set $ename (call $list_index (local.get $names) (local.get $i)))
        (local.set $state_local
          (call $lower_resolve_handler_state_for_ename (local.get $ename)))
        (if (i32.ne (local.get $state_local) (i32.const 0))
          (then
            (drop (call $list_set (local.get $evs) (local.get $i)
                    (call $lexpr_make_llocal (i32.const 0) (local.get $state_local)))))
          (else
            ;; THE DISPATCH GRADIENT (mirror of src/lower.mn resolve_ev_for_ename):
            ;;   step 2 — effect THREADED in this frame (present in its row) →
            ;;     forwarded slot. Checked FIRST so a genuinely-threaded effect
            ;;     (the ev2/ev4 evidence path) is never mistaken for a singleton.
            ;;   step 3 — effect the row does NOT carry → ambient install; a
            ;;     no-config global singleton reads its `$<h>_state_g` HOME.
            ;;   step 4 — neither → slot-0 floor, never a fabricated thread.
            (local.set $raw (call $lower_ev_slot_raw (local.get $ename)))
            (if (i32.ge_s (local.get $raw) (i32.const 0))
              (then
                (drop (call $list_set (local.get $evs) (local.get $i)
                        (call $lexpr_make_levslotref (i32.const 0) (local.get $raw)))))
              (else
                (local.set $hname (call $lower_lookup_default_handler_for_ename (local.get $ename)))
                (if (i32.ne (local.get $hname) (i32.const 0))
                  (then
                    (drop (call $list_set (local.get $evs) (local.get $i)
                            (call $lexpr_make_lglobal (i32.const 0)
                              (call $str_concat (local.get $hname) (i32.const 5424))))))
                  (else
                    (drop (call $list_set (local.get $evs) (local.get $i)
                            (call $lexpr_make_levslotref (i32.const 0) (i32.const 0))))))))))
        (local.set $i (i32.add (local.get $i) (i32.const 1)))
        (br $each)))
    (local.get $evs))

  ;; ─── $derive_ev_slots — evidence to THREAD to a named callee (the seam) ──────
  ;; Read the layout from the home INFERENCE wrote: the callee's env scheme by
  ;; name — the SAME read $lower_compute_ev_index_for_effect uses. One fact, two
  ;; readers; never the call-site instantiation. A non-global callee (closure /
  ;; value) carries its own evidence → nothing to thread.
  (func $derive_ev_slots (export "derive_ev_slots") (param $lo_f i32) (result i32)
    (local $name i32) (local $binding i32) (local $scheme i32)
    (if (i32.ne (call $tag_of (local.get $lo_f)) (i32.const 302))
      (then (return (call $make_list (i32.const 0)))))
    (local.set $name (call $lexpr_lglobal_name (local.get $lo_f)))
    (local.set $binding (call $env_lookup_value (local.get $name)))
    (if (i32.eqz (local.get $binding))
      (then (return (call $make_list (i32.const 0)))))
    (local.set $scheme (call $env_binding_scheme (local.get $binding)))
    (if (i32.lt_u (local.get $scheme) (global.get $heap_base))
      (then (return (call $make_list (i32.const 0)))))
    (call $resolve_evs_for_names
      (call $effects_of (call $scheme_body (local.get $scheme)))))

  ;; ─── $derive_closure_evs — a closure's OWN evidence (its handle's row) ───────
  ;; The effects THIS closure's body performs, from its inferred type at the
  ;; handle ($lookup_ty), resolved at the definition site. NOT a callee scheme:
  ;; a lambda / let-bound closure has no env name and CARRIES its evidence where
  ;; a call threads it. Mirror of src/lower.mn $derive_closure_evs.
  (func $derive_closure_evs (param $handle i32) (result i32)
    (call $resolve_evs_for_names
      (call $effects_of (call $lookup_ty (local.get $handle)))))

  ;; ─── $lower_call_default — monomorphic-vs-polymorphic gate ─────────
  ;; Per src/lower.mn:242-249 + Lock #1. The gradient cash-out.
  ;;
  ;; Seed signature divergence (per Lock #5):
  ;;   wheel: (handle, f_node, fh, lo_args) — does its own lower_expr(f)
  ;;   seed:  (handle, lo_f, fh, lo_args)   — caller pre-lowers callee
  ;;
  ;; Equivalent; lifts the recursion to the CallExpr arm to keep
  ;; chunk-internal cleanliness. Named follow-up
  ;; Hβ.lower.lower-call-default-signature-alignment surfaces wheel
  ;; alignment when the third caller earns it.
  ;;
  ;; Avoids Drift 1: LSuspend tag 325 carries fn_index as a FIELD on
  ;;   the closure record (lexpr.wat:625-657); emit's call_indirect
  ;;   site at H1.4 reads the field — NOT a vtable / op_table.
  (func $lower_call_default (export "lower_call_default")
        (param $handle i32) (param $lo_f i32) (param $fh i32) (param $lo_args i32)
        (result i32)
    (local $evs i32)
    ;; Per Hβ-perform-evidence-dispatch.md §4.7: $derive_ev_slots IS the gate
    ;; (canonical projection — one source of truth). A callee needs evidence
    ;; iff its row carries a handler-dispatched effect; if so the call must
    ;; LSuspend to thread the handler record into the callee's __state, else a
    ;; deep perform reads an unthreaded ev-slot and traps. Empty → LCall (the
    ;; monomorphic >95% case). Replaces the row_is_ground/$monomorphic_at
    ;; gate, which conflated "closed row" with "needs no evidence".
    (local.set $evs (call $derive_ev_slots (local.get $lo_f)))
    (if (i32.eqz (call $len (local.get $evs)))
      (then (return (call $lexpr_make_lcall
                      (local.get $handle)
                      (local.get $lo_f)
                      (local.get $lo_args)))))
    (call $lexpr_make_lsuspend
      (local.get $handle)
      (local.get $fh)
      (local.get $lo_f)
      (local.get $lo_args)
      (local.get $evs)))

  ;; ─── $lower_call — CallExpr arm (parser tag 88) ────────────────────
  ;; Per src/lower.mn:347-367 CallExpr arm + Lock #3 (schemekind triage
  ;; deferred to Hβ.lower.varref-schemekind-dispatch).
  ;;
  ;; AST navigation: $node is the N-wrapper. Per parser_infra.wat:32-39:
  ;;   offset 4  → NExpr-wrapper (tag 110)
  ;;     offset 4  → CallExpr (tag 88), per parser_infra.wat:111-116:
  ;;                   offset 4 → callee N-wrapper
  ;;                   offset 8 → args list
  ;;   offset 12 → handle
  ;; SchemeKind triage per Hβ.lower.varref-schemekind-dispatch (named
  ;; follow-up; closing it here): when the callee is a VarRef whose
  ;; env binding is a ConstructorScheme, route to LMakeVariant
  ;; (instead of LCall/LSuspend). Same shortcut for EffectOpScheme →
  ;; LPerform when the parser starts producing PerformExpr at call
  ;; sites without explicit `perform` keyword (today the seed parses
  ;; `perform op(...)` separately via parse_perform_expr → tag 94, so
  ;; the EffectOpScheme branch here is reachable only through
  ;; user-named direct-call style; harmless to leave unimplemented
  ;; in this commit and named as Hβ.lower.varref-effectop-dispatch).
  ;;
  ;; Eight interrogations on this dispatch site:
  ;;   1. Graph?      ConstructorScheme tag_id IS recorded in env at
  ;;                  TypeDef pre-register time (walk_stmt.wat:818-874).
  ;;   2. Handler?    @resume=OneShot (lookup is read-only).
  ;;   3. Verb?       N/A — structural dispatch.
  ;;   4. Row?        Pure read on env; no effects performed beyond
  ;;                  EnvRead implicit in env_lookup.
  ;;   5. Ownership?  $callee_node is borrowed; binding handle borrowed
  ;;                  from env.
  ;;   6. Refinement? ConstructorScheme(tag_id, total) carries the
  ;;                  invariant 0 ≤ tag_id < total.
  ;;   7. Gradient?   The cash-out: nullary ctors emit (i32.const tag_id)
  ;;                  sentinels; N-ary ctors heap-allocate via
  ;;                  emit_alloc — same EmitMemory swap surface as the
  ;;                  rest of the heap.
  ;;   8. Reason?     LMakeVariant carries the call's handle; Reason
  ;;                  flows from the env binding's stored Reason.
  ;;
  ;; Drift modes refused:
  ;; - Drift 1 (vtable):  Direct schemekind tag dispatch; no table.
  ;; - Drift 6 (special): Same dispatch path for nullary AND N-ary
  ;;                      ctors via $lexpr_make_lmakevariant; no Bool-
  ;;                      special-case (HB substrate already covers).
  ;; - Drift 8 (string):  Schemekind tag is i32 (132); not str_eq.
  ;; - Drift 9 (deferred): All branches bodied; closes
  ;;                      Hβ.lower.varref-schemekind-dispatch.

  (func $is_str_float_of_int (param $s i32) (result i32)
    (if (i32.ne (i32.load (local.get $s)) (i32.const 12)) (then (return (i32.const 0))))
    (if (i32.ne (i32.load8_u offset=4 (local.get $s)) (i32.const 102)) (then (return (i32.const 0)))) ;; f
    (if (i32.ne (i32.load8_u offset=5 (local.get $s)) (i32.const 108)) (then (return (i32.const 0)))) ;; l
    (if (i32.ne (i32.load8_u offset=6 (local.get $s)) (i32.const 111)) (then (return (i32.const 0)))) ;; o
    (if (i32.ne (i32.load8_u offset=7 (local.get $s)) (i32.const 97)) (then (return (i32.const 0))))  ;; a
    (if (i32.ne (i32.load8_u offset=8 (local.get $s)) (i32.const 116)) (then (return (i32.const 0)))) ;; t
    (if (i32.ne (i32.load8_u offset=9 (local.get $s)) (i32.const 95)) (then (return (i32.const 0))))  ;; _
    (if (i32.ne (i32.load8_u offset=10 (local.get $s)) (i32.const 111)) (then (return (i32.const 0)))) ;; o
    (if (i32.ne (i32.load8_u offset=11 (local.get $s)) (i32.const 102)) (then (return (i32.const 0)))) ;; f
    (if (i32.ne (i32.load8_u offset=12 (local.get $s)) (i32.const 95)) (then (return (i32.const 0))))  ;; _
    (if (i32.ne (i32.load8_u offset=13 (local.get $s)) (i32.const 105)) (then (return (i32.const 0)))) ;; i
    (if (i32.ne (i32.load8_u offset=14 (local.get $s)) (i32.const 110)) (then (return (i32.const 0)))) ;; n
    (if (i32.ne (i32.load8_u offset=15 (local.get $s)) (i32.const 116)) (then (return (i32.const 0)))) ;; t
    (return (i32.const 1)))

  (func $is_str_float_to_int (param $s i32) (result i32)
    (if (i32.ne (i32.load (local.get $s)) (i32.const 12)) (then (return (i32.const 0))))
    (if (i32.ne (i32.load8_u offset=4 (local.get $s)) (i32.const 102)) (then (return (i32.const 0)))) ;; f
    (if (i32.ne (i32.load8_u offset=5 (local.get $s)) (i32.const 108)) (then (return (i32.const 0)))) ;; l
    (if (i32.ne (i32.load8_u offset=6 (local.get $s)) (i32.const 111)) (then (return (i32.const 0)))) ;; o
    (if (i32.ne (i32.load8_u offset=7 (local.get $s)) (i32.const 97)) (then (return (i32.const 0))))  ;; a
    (if (i32.ne (i32.load8_u offset=8 (local.get $s)) (i32.const 116)) (then (return (i32.const 0)))) ;; t
    (if (i32.ne (i32.load8_u offset=9 (local.get $s)) (i32.const 95)) (then (return (i32.const 0))))  ;; _
    (if (i32.ne (i32.load8_u offset=10 (local.get $s)) (i32.const 116)) (then (return (i32.const 0)))) ;; t
    (if (i32.ne (i32.load8_u offset=11 (local.get $s)) (i32.const 111)) (then (return (i32.const 0)))) ;; o
    (if (i32.ne (i32.load8_u offset=12 (local.get $s)) (i32.const 95)) (then (return (i32.const 0))))  ;; _
    (if (i32.ne (i32.load8_u offset=13 (local.get $s)) (i32.const 105)) (then (return (i32.const 0)))) ;; i
    (if (i32.ne (i32.load8_u offset=14 (local.get $s)) (i32.const 110)) (then (return (i32.const 0)))) ;; n
    (if (i32.ne (i32.load8_u offset=15 (local.get $s)) (i32.const 116)) (then (return (i32.const 0)))) ;; t
    (return (i32.const 1)))

  (func $lower_call (export "lower_call") (param $node i32) (result i32)
    (local $h i32) (local $body i32) (local $call_struct i32)
    (local $callee_node i32) (local $args_list i32)
    (local $lo_f i32) (local $lo_args i32) (local $fh i32)
    (local $cb_body i32) (local $cb_expr i32) (local $name i32)
    (local $binding i32) (local $kind i32) (local $kind_tag i32)
    (local $tag_id i32)
    (local.set $h           (call $walk_expr_node_handle (local.get $node)))
    (local.set $body        (i32.load offset=4 (local.get $node)))
    (local.set $call_struct (i32.load offset=4 (local.get $body)))
    (local.set $callee_node (i32.load offset=4 (local.get $call_struct)))
    (local.set $args_list   (i32.load offset=8 (local.get $call_struct)))
    ;; Pre-dispatch: peek at callee_node — if it's a VarRef whose env
    ;; binding has ConstructorScheme, short-circuit to LMakeVariant.
    ;; AST navigation: callee_node is N(NodeBody, span, handle).
    ;;   offset 4 → NodeBody (NExpr wrapper, tag 110 — offset 4 → expr).
    (local.set $cb_body (i32.load offset=4 (local.get $callee_node)))
    (if (i32.eq (i32.load (local.get $cb_body)) (i32.const 110))
      (then
        (local.set $cb_expr (i32.load offset=4 (local.get $cb_body)))
        ;; If inner expr is VarRef (tag 85), look up the name in env.
        (if (i32.eq (i32.load (local.get $cb_expr)) (i32.const 85))
          (then
            (local.set $name (i32.load offset=4 (local.get $cb_expr)))
            
            ;; Intercept float_of_int / float_to_int per Hβ.seed.float-convert
            (if (call $is_str_float_of_int (local.get $name))
              (then
                (local.set $lo_args (call $lower_args (local.get $args_list)))
                (return (call $lexpr_make_lconvert
                          (local.get $h)
                          (i32.const 0) ;; IntToFloat
                          (call $list_index (local.get $lo_args) (i32.const 0))))))
            (if (call $is_str_float_to_int (local.get $name))
              (then
                (local.set $lo_args (call $lower_args (local.get $args_list)))
                (return (call $lexpr_make_lconvert
                          (local.get $h)
                          (i32.const 1) ;; FloatToInt
                          (call $list_index (local.get $lo_args) (i32.const 0))))))

            (local.set $binding (call $env_lookup_value (local.get $name)))
            (if (i32.ne (local.get $binding) (i32.const 0))
              (then
                (local.set $kind (call $env_binding_kind (local.get $binding)))
                (local.set $kind_tag (call $schemekind_tag (local.get $kind)))
                ;; ConstructorScheme tag is 132 per env.wat:161.
                (if (i32.eq (local.get $kind_tag) (i32.const 132))
                  (then
                    (local.set $tag_id (call $schemekind_ctor_tag_id (local.get $kind)))
                    (local.set $lo_args (call $lower_args (local.get $args_list)))
                    (return (call $lexpr_make_lmakevariant
                                  (local.get $h)
                                  (local.get $tag_id)
                                  (local.get $lo_args)))))
                ;; Per Hβ.first-light.implicit-perform-for-effect-op
                ;; (2026-05-06): EffectOpScheme tag is 133 per env.wat:175.
                ;; `yield(x)` inside `fn iterate(xs) with Iterate = ...`
                ;; parses as CallExpr; env_lookup resolves yield to
                ;; EffectOpScheme. Type-directed dispatch per SUBSTRATE.md
                ;; §"Type-Directed Dispatch": one CallExpr arm, three
                ;; cashes — ConstructorScheme→LMakeVariant, EffectOpScheme
                ;; →LPerform, FnScheme→LCall (default below). Mirrors the
                ;; wheel src/lower.mn:475-498 callee-dispatch shape.
                ;; Same handler-resolution as $lower_perform (commit 4cce41d):
                ;; resolve via $lower_resolve_handler_for_op for Tier 1
                ;; direct-call discrimination; undiscriminated fall-through
                ;; for productive-under-error.
                (if (i32.eq (local.get $kind_tag) (i32.const 133))
                  (then
                    (local.set $lo_args (call $lower_args (local.get $args_list)))
                    ;; Raw-target ops FIRST — the wasi import / wasm
                    ;; instruction IS the handler; there is no evidence
                    ;; to dispatch through (mirror of $lower_perform's
                    ;; check order). Bare op calls are canon post-
                    ;; perform-dissolution; without these checks they
                    ;; fell to Tier-2 evidence dispatch that nothing
                    ;; installs — m2's len() bare load_i32 dispatched a
                    ;; garbage call_indirect (the pass-2 trap + the
                    ;; all-NUL m3 output were both this).
                    (local.set $tag_id (call $wasi_op_target_name (local.get $name)))
                    (if (i32.ne (local.get $tag_id) (i32.const 0))
                      (then (return (call $lexpr_make_lperform
                        (local.get $h) (local.get $tag_id) (local.get $lo_args)))))
                    (local.set $tag_id (call $memory_op_target_name (local.get $name)))
                    (if (i32.ne (local.get $tag_id) (i32.const 0))
                      (then (return (call $lexpr_make_lperform
                        (local.get $h) (local.get $tag_id) (local.get $lo_args)))))
                    (local.set $tag_id (call $lower_resolve_handler_for_op (local.get $name)))
                    (if (i32.ne (local.get $tag_id) (i32.const 0))
                      (then
                        (return (call $lexpr_make_lperform_with_state
                                      (local.get $h)
                                      (local.get $tag_id)
                                      (local.get $lo_args)
                                      (call $lower_resolve_handler_state_for_op (local.get $name)))))
                      (else
                        ;; THE DISPATCH GRADIENT (unify with $lower_perform): the op
                        ;; CARRIES its unique default handler (drawn at pre-register).
                        ;; Read O(1) — a known singleton homes to its $<h>_state_g,
                        ;; never the threaded ev-slot. "I already have this." Only
                        ;; ambiguous / genuinely-unknown ops keep the evidence floor.
                        (local.set $tag_id (call $lower_lookup_default_handler_for_op (local.get $name)))
                        (if (i32.ne (local.get $tag_id) (i32.const 0))
                          (then (return (call $lower_direct_from_evidence
                                          (local.get $h) (local.get $name)
                                          (local.get $tag_id) (local.get $lo_args)))))
                        ;; Tier 2: evidence-passing per graph EffectDeclKind.
                        (return (call $lexpr_make_levperform
                                      (local.get $h)
                                      (local.get $name)
                                      (call $lower_compute_ev_index_for_effect
                                        (call $lower_effect_name_of_op (local.get $name)))
                                      (call $lower_compute_ev_slot_for_op (local.get $name))
                                      (local.get $lo_args)))))))))))))
    ;; Default closure-call form per Lock #3.
    (local.set $lo_f    (call $lower_expr (local.get $callee_node)))
    (local.set $lo_args (call $lower_args (local.get $args_list)))
    (local.set $fh      (call $walk_expr_node_handle (local.get $callee_node)))
    (call $lower_call_default
      (local.get $h)
      (local.get $lo_f)
      (local.get $fh)
      (local.get $lo_args)))

  ;; ─── $wasi_op_target_name — WASI effect-op → wasi_<op> target name ─
  ;; Per Hβ.emit.wasi-effect-op-direct-emit (2026-05-07). If `op_name`
  ;; (a length-prefixed Mentl string) matches a WASI-named op, returns
  ;; a freshly-allocated "wasi_<op_name>" string suitable for use as
  ;; LPerform's target_fn_name (emit produces `(call $wasi_<op>)`).
  ;; Returns 0 (sentinel) when op_name is not WASI-known — caller
  ;; falls through to handler-resolution.
  ;;
  ;; Currently recognized: fd_write, fd_read, proc_exit, path_open,
  ;; path_create_directory, path_filestat_get, path_unlink_file,
  ;; path_rename, fd_close. These are the WASI-preview1 ops the
  ;; wheel's lib/runtime/io.mn performs against. Future expansion
  ;; lands additional names here as WASI surface grows.
  ;;
  ;; Length-prefixed comparison strings live at lower-stage data
  ;; segment 4416+ (free per data-offset audit; past walk_handle.wat's
  ;; "_" at 4400+10).
  (data (i32.const 4416) "\08\00\00\00fd_write")
  (data (i32.const 4432) "\07\00\00\00fd_read")
  (data (i32.const 4448) "\09\00\00\00proc_exit")
  (data (i32.const 4464) "\09\00\00\00path_open")
  (data (i32.const 4480) "\08\00\00\00fd_close")
  (data (i32.const 4496) "\05\00\00\00wasi_")
  ;; Additional WASI ops per Hβ.first-light.wasi-paths-substrate
  ;; (2026-05-07). io.mn's filesystem ops use these. Length-prefixed
  ;; comparison strings continue at 4608+.
  (data (i32.const 4608) "\16\00\00\00path_create_directory")
  (data (i32.const 4640) "\12\00\00\00path_filestat_get")
  (data (i32.const 4672) "\10\00\00\00path_unlink_file")
  (data (i32.const 4704) "\0b\00\00\00path_rename")

  ;; Per Hβ.emit.memory-effect-op-direct-emit (2026-05-07): Memory-
  ;; effect ops emit RAW WASM instructions (i32.load / i32.store /
  ;; i32.load8_u / i32.store8) instead of function calls. The graph
  ;; carries the op name; emit projects to native WASM. Op-name strings
  ;; for str_eq dispatch + "memory_" prefix for emit-side recognition.
  (data (i32.const 4512) "\08\00\00\00load_i32")
  (data (i32.const 4528) "\07\00\00\00load_i8")
  (data (i32.const 4544) "\09\00\00\00store_i32")
  (data (i32.const 4560) "\08\00\00\00store_i8")
  (data (i32.const 4576) "\07\00\00\00memory_")
  ;; alloc + mem_copy land here. alloc(size) → bump-allocator inline;
  ;; mem_copy(dst, src, n) → (memory.copy) raw WASM op.
  (data (i32.const 4736) "\05\00\00\00alloc")
  (data (i32.const 4752) "\08\00\00\00mem_copy")

  (func $wasi_op_target_name (param $op_name i32) (result i32)
    (if (call $str_eq (local.get $op_name) (i32.const 4416))   ;; fd_write
      (then (return (call $str_concat (i32.const 4496) (local.get $op_name)))))
    (if (call $str_eq (local.get $op_name) (i32.const 4432))   ;; fd_read
      (then (return (call $str_concat (i32.const 4496) (local.get $op_name)))))
    (if (call $str_eq (local.get $op_name) (i32.const 4448))   ;; proc_exit
      (then (return (call $str_concat (i32.const 4496) (local.get $op_name)))))
    (if (call $str_eq (local.get $op_name) (i32.const 4464))   ;; path_open
      (then (return (call $str_concat (i32.const 4496) (local.get $op_name)))))
    (if (call $str_eq (local.get $op_name) (i32.const 4480))   ;; fd_close
      (then (return (call $str_concat (i32.const 4496) (local.get $op_name)))))
    (if (call $str_eq (local.get $op_name) (i32.const 4608))   ;; path_create_directory
      (then (return (call $str_concat (i32.const 4496) (local.get $op_name)))))
    (if (call $str_eq (local.get $op_name) (i32.const 4640))   ;; path_filestat_get
      (then (return (call $str_concat (i32.const 4496) (local.get $op_name)))))
    (if (call $str_eq (local.get $op_name) (i32.const 4672))   ;; path_unlink_file
      (then (return (call $str_concat (i32.const 4496) (local.get $op_name)))))
    (if (call $str_eq (local.get $op_name) (i32.const 4704))   ;; path_rename
      (then (return (call $str_concat (i32.const 4496) (local.get $op_name)))))
    (i32.const 0))

  ;; $memory_op_target_name — Memory effect-op → "memory_<op>" target
  ;; for emit-side raw-WASM dispatch. Returns 0 if not Memory-known.
  (func $memory_op_target_name (param $op_name i32) (result i32)
    (if (call $str_eq (local.get $op_name) (i32.const 4512))   ;; load_i32
      (then (return (call $str_concat (i32.const 4576) (local.get $op_name)))))
    (if (call $str_eq (local.get $op_name) (i32.const 4528))   ;; load_i8
      (then (return (call $str_concat (i32.const 4576) (local.get $op_name)))))
    (if (call $str_eq (local.get $op_name) (i32.const 4544))   ;; store_i32
      (then (return (call $str_concat (i32.const 4576) (local.get $op_name)))))
    (if (call $str_eq (local.get $op_name) (i32.const 4560))   ;; store_i8
      (then (return (call $str_concat (i32.const 4576) (local.get $op_name)))))
    (if (call $str_eq (local.get $op_name) (i32.const 4736))   ;; alloc
      (then (return (call $str_concat (i32.const 4576) (local.get $op_name)))))
    (if (call $str_eq (local.get $op_name) (i32.const 4752))   ;; mem_copy
      (then (return (call $str_concat (i32.const 4576) (local.get $op_name)))))
    (i32.const 0))

  ;; ─── $lower_compute_ev_slot_for_op — graph-empowered slot index ──────
  ;; Per wheel src/lower.mn compute_slot_index + effect_slot_in_row.
  ;; Reads the graph: op_name → EffectOpScheme(effect_name) →
  ;; EffectDeclKind(op_names) → find op_name's position.
  ;; Returns 0 as fallback (productive-under-error).
  (func $lower_compute_ev_slot_for_op (param $op_name i32) (result i32)
    (local $binding i32) (local $kind i32) (local $kind_tag i32)
    (local $effect_name i32) (local $decl_binding i32) (local $decl_kind i32)
    (local $op_names i32) (local $n i32) (local $j i32)
    ;; Step 1: op_name → EffectOpScheme(effect_name)
    (local.set $binding (call $env_lookup (local.get $op_name)))
    (if (i32.eqz (local.get $binding))
      (then (return (i32.const 0))))
    (local.set $kind (call $env_binding_kind (local.get $binding)))
    (if (i32.lt_u (local.get $kind) (global.get $heap_base))
      (then (return (i32.const 0))))
    (local.set $kind_tag (call $tag_of (local.get $kind)))
    (if (i32.ne (local.get $kind_tag) (i32.const 133))  ;; EffectOpScheme
      (then (return (i32.const 0))))
    (local.set $effect_name (call $schemekind_effectop_name (local.get $kind)))
    ;; Step 2: effect_name → EffectDeclKind(op_names)
    (local.set $decl_binding (call $env_lookup_effectdecl (local.get $effect_name)))
    (if (i32.eqz (local.get $decl_binding))
      (then (return (i32.const 0))))
    (local.set $decl_kind (call $env_binding_kind (local.get $decl_binding)))
    (if (i32.lt_u (local.get $decl_kind) (global.get $heap_base))
      (then (return (i32.const 0))))
    (if (i32.ne (call $tag_of (local.get $decl_kind)) (i32.const 136))  ;; EffectDeclKind
      (then (return (i32.const 0))))
    (local.set $op_names (call $schemekind_effectdecl_ops (local.get $decl_kind)))
    ;; Step 3: find op_name's index in op_names
    (local.set $n (call $len (local.get $op_names)))
    (local.set $j (i32.const 0))
    (block $found
      (loop $search
        (br_if $found (i32.ge_u (local.get $j) (local.get $n)))
        (if (call $str_eq (call $list_index (local.get $op_names) (local.get $j))
                          (local.get $op_name))
          (then (return (local.get $j))))
        (local.set $j (i32.add (local.get $j) (i32.const 1)))
        (br $search)))
    (i32.const 0))

  ;; ─── $lower_effect_name_of_op — op_name → its declaring effect's name ─
  ;; The graph already carries this: op_name binds to EffectOpScheme(effect).
  ;; Read it; never a side registry (drift 8 refused). Returns 0 if op_name
  ;; is not an effect op in scope (productive-under-error).
  (func $lower_effect_name_of_op (param $op_name i32) (result i32)
    (local $binding i32) (local $kind i32)
    (local.set $binding (call $env_lookup (local.get $op_name)))
    (if (i32.eqz (local.get $binding)) (then (return (i32.const 0))))
    (local.set $kind (call $env_binding_kind (local.get $binding)))
    (if (i32.lt_u (local.get $kind) (global.get $heap_base)) (then (return (i32.const 0))))
    (if (i32.ne (call $tag_of (local.get $kind)) (i32.const 133))   ;; EffectOpScheme
      (then (return (i32.const 0))))
    (call $schemekind_effectop_name (local.get $kind)))

  ;; ─── $lower_compute_ev_index_for_effect — ev-slot = effect's index in
  ;; the CURRENT fn's row ─────────────────────────────────────────────────
  ;; The Boolean effect ROW projected as the runtime evidence layout. The
  ;; current fn's row is read from its own scheme (env_lookup(fn_name) →
  ;; scheme_body → TFun row). row_names is sorted-lex canonical, so a caller
  ;; building a callee's __state (derive_ev_slots, iterating the CALLEE's
  ;; row) and the callee reading its own ev-slot agree by construction —
  ;; Koka-style evidence coercion falls out of the shared canonical order,
  ;; with no coercion table. Returns 0 as fallback (a single-effect fn is
  ;; correct at slot 0; productive-under-error otherwise).
  (func $lower_compute_ev_index_for_effect (param $effect_name i32) (result i32)
    (local $fn_name i32) (local $binding i32) (local $scheme i32)
    (local $names i32) (local $n i32) (local $j i32)
    (local $nl i32)
    (if (i32.eqz (local.get $effect_name)) (then (return (i32.const 0))))
    (local.set $fn_name (call $ls_outer_fn_name))
    (if (i32.eqz (local.get $fn_name)) (then (return (i32.const 0))))
    (local.set $binding (call $env_lookup_value (local.get $fn_name)))
    (if (i32.eqz (local.get $binding)) (then (return (i32.const 0))))
    (local.set $scheme (call $env_binding_scheme (local.get $binding)))
    (if (i32.lt_u (local.get $scheme) (global.get $heap_base)) (then (return (i32.const 0))))
    ;; THE SEAM: one $effects_of read — the SAME projection $derive_ev_slots uses,
    ;; from the SAME source (the fn's inferred TFun row), so this READ index ==
    ;; the PLACED index by construction (no re-derivation contract, no declared-
    ;; vs-inferred-row divergence). Stage 1 swaps $effects_of to the live
    ;; flow-closure and this consumer does not change.
    (local.set $names (call $effects_of (call $scheme_body (local.get $scheme))))
    (local.set $n (call $len (local.get $names)))
    (local.set $j (i32.const 0))
    (block $found
      (loop $search
        (br_if $found (i32.ge_u (local.get $j) (local.get $n)))
        (if (call $str_eq (call $list_index (local.get $names) (local.get $j))
                          (local.get $effect_name))
          (then (return (local.get $j))))
        (local.set $j (i32.add (local.get $j) (i32.const 1)))
        (br $search)))
    ;; ROW-CONSERVATION LEAK (proto-W_RowLeak): we hold this fn's row and
    ;; searched it, yet $effect_name is absent — something forwards/performs an
    ;; effect the row never accumulated. The silent slot-0 clamp masked it; make
    ;; it speak. `<fn>_<effect>` per line on stderr (uncounted by the census).
    (local.set $nl (call $str_alloc (i32.const 1)))
    (i32.store8 (i32.add (local.get $nl) (i32.const 4)) (i32.const 10))
    (call $eprint_string (local.get $fn_name))
    (call $eprint_string (i32.const 4400))
    (call $eprint_string (local.get $effect_name))
    (call $eprint_string (local.get $nl))
    (i32.const 0))

  ;; ─── $lower_perform — PerformExpr arm (parser tag 94) ──────────────
  ;; Per src/lower.mn:442-443 + Lock #2 (wheel-parity LPerform for ALL
  ;; ResumeDiscipline values; H7 MultiShot dispatch is named follow-up
  ;; Hβ.lower.perform-multishot-dispatch).
  ;;
  ;; AST navigation per parser_infra.wat:144-149 PerformExpr (tag 94):
  ;;   offset 4 → op_name string ptr
  ;;   offset 8 → args list
  (func $lower_perform (export "lower_perform") (param $node i32) (result i32)
    (local $h i32) (local $body i32) (local $perform_struct i32)
    (local $op_name i32) (local $args_list i32) (local $lo_args i32)
    (local $resolved i32) (local $wasi_target i32) (local $hname i32)
    (local.set $h              (call $walk_expr_node_handle (local.get $node)))
    (local.set $body           (i32.load offset=4 (local.get $node)))
    (local.set $perform_struct (i32.load offset=4 (local.get $body)))
    (local.set $op_name        (i32.load offset=4 (local.get $perform_struct)))
    (local.set $args_list      (i32.load offset=8 (local.get $perform_struct)))
    (local.set $lo_args        (call $lower_args (local.get $args_list)))
    ;; Per Hβ.emit.wasi-effect-op-direct-emit (2026-05-07): WASI-named
    ;; effect ops emit direct $wasi_<op> calls (matching the seed's
    ;; emit_wasi_imports import declarations). Without this
    ;; dispatch, WASI performs fall through to the polymorphic-perform
    ;; band-aid (LConst(0)), and `print_string`-like Mentl programs
    ;; produce no output. The graph KNOWS WASI ops (effect declared);
    ;; emit projects them to direct wasi-import calls.
    ;;
    ;; Drift refused: 1 (no vtable; direct str-eq dispatch); 8
    ;; (op_name string compare, no mode-flag).
    (local.set $wasi_target (call $wasi_op_target_name (local.get $op_name)))
    (if (i32.ne (local.get $wasi_target) (i32.const 0))
      (then
        (return (call $lexpr_make_lperform
          (local.get $h)
          (local.get $wasi_target)
          (local.get $lo_args)))))
    ;; Memory-effect ops → "memory_<op>" target; emit produces raw
    ;; WASM (i32.load / i32.store / i32.load8_u / i32.store8) instead
    ;; of function calls. Per Hβ.emit.memory-effect-op-direct-emit.
    (local.set $wasi_target (call $memory_op_target_name (local.get $op_name)))
    (if (i32.ne (local.get $wasi_target) (i32.const 0))
      (then
        (return (call $lexpr_make_lperform
          (local.get $h)
          (local.get $wasi_target)
          (local.get $lo_args)))))
    ;; Hβ.first-light.seed-lperform-discriminator-mirror — query
    ;; lower-stage handler-stack for the innermost handler that
    ;; handles op_name's effect. If found, the discriminated target
    ;; "<handler>_<op>" matches the module-level $op_<handler>_<op>
    ;; symbol minted by $lower_handler_arms_as_decls (commit 22a4bbc).
    ;; If not found (no handler in scope or op not an EffectOpScheme),
    ;; emit LEvPerform — evidence-passing dispatch per Koka JFP 2022.
    ;; The graph carries EffectDeclKind; we read it to compute the
    ;; evidence slot index. No separate registry. Graph empowerment.
    (local.set $resolved (call $lower_resolve_handler_for_op (local.get $op_name)))
    (if (result i32) (i32.ne (local.get $resolved) (i32.const 0))
      (then
        ;; Tier 1: monomorphic direct-call. Handler resolved at lower-time.
        (call $lexpr_make_lperform_with_state
          (local.get $h)
          (local.get $resolved)
          (local.get $lo_args)
          (call $lower_resolve_handler_state_for_op (local.get $op_name))))
      (else
        ;; Tier 2: polymorphic evidence-passing. The handler is provided
        ;; by the caller via evidence slots in __state. Compute slot_idx
        ;; from the graph's EffectDeclKind — the graph carries the
        ;; effect→ops mapping as first-class substrate.
        ;; THE DISPATCH GRADIENT cash-out (seed mirror of src/lower.mn
        ;; lower_perform_dispatch). The op has a statically-known handler
        ;; (op→handler map) — and the seed is one-shot, so a known handler is
        ;; sufficient to cash to a DIRECT call. This dissolves the evidence
        ;; call_indirect whose arm-offset arithmetic trapped at fresh_handle.
        ;; Only genuinely unknown-handler ops keep the evidence floor.
        (local.set $hname (call $lower_lookup_default_handler_for_op (local.get $op_name)))
        (if (result i32) (i32.ne (local.get $hname) (i32.const 0))
          (then
            (call $lower_direct_from_evidence
              (local.get $h) (local.get $op_name) (local.get $hname) (local.get $lo_args)))
          (else
            (call $lexpr_make_levperform
              (local.get $h)
              (local.get $op_name)
              (call $lower_ev_index_in_frame
                (call $lower_effect_name_of_op (local.get $op_name)))
              (call $lower_compute_ev_slot_for_op (local.get $op_name))
              (local.get $lo_args)))))))

  ;; Tier-1 GLOBAL (the L1 closer): call the statically-known arm directly,
  ;; reading its record from the static singleton's GLOBAL HOME
  ;; `$<hname>_state_g` — never the threaded ev-region. The handler is installed
  ;; once (graph_handler, lower_scope, env_handler …); its record lives at one
  ;; home; the arm mutates that record IN PLACE, so the global keeps pointing to
  ;; the live state. The `_state_g` global was WRITE-ONLY (set at install, never
  ;; read) — this is its reader. Carried-Truth: read the fact live at its home,
  ;; never re-thread / re-index. This dissolves evidence threading AND the
  ;; cross-frame ev-region coercion (caller-row ≠ callee-row mis-alignment) for
  ;; every static handler — the ~85% case. Build LBlock([LLet(rec,
  ;; LGlobal(<hname>_state_g)), LPerform(<h>_<op>, args, rec)]); emit prepends
  ;; "op_" to the target, matching Tier-1.
  (func $lower_direct_from_evidence
        (param $h i32) (param $op_name i32) (param $hname i32) (param $lo_args i32) (result i32)
    (local $rec_local i32) (local $target i32)
    (local $rec_read i32) (local $llet i32) (local $lperform i32) (local $stmts i32)
    ;; rec_local = "_" + int_to_str(h)   (unique per node; emit declares it)
    (local.set $rec_local
      (call $str_concat (i32.const 4400) (call $int_to_str (local.get $h))))
    ;; target = hname + "_" + op_name
    (local.set $target
      (call $str_concat
        (call $str_concat (local.get $hname) (i32.const 4400))
        (local.get $op_name)))
    ;; rec_read = LGlobal("<hname>_state_g") — the singleton record at its home.
    (local.set $rec_read
      (call $lexpr_make_lglobal (local.get $h)
        (call $str_concat (local.get $hname) (i32.const 5424))))
    (local.set $llet
      (call $lexpr_make_llet (local.get $h) (local.get $rec_local) (local.get $rec_read)))
    (local.set $lperform
      (call $lexpr_make_lperform_with_state (local.get $h) (local.get $target)
        (local.get $lo_args) (local.get $rec_local)))
    (local.set $stmts (call $make_list (i32.const 2)))
    (drop (call $list_set (local.get $stmts) (i32.const 0) (local.get $llet)))
    (drop (call $list_set (local.get $stmts) (i32.const 1) (local.get $lperform)))
    (call $lexpr_make_lblock (local.get $h) (local.get $stmts)))

  ;; ─── $lower_resume — ResumeExpr arm (parser tag 95) ────────────────
  ;; Mirror of the wheel's ResumeExpr arm + lower_resume_snapshot
  ;; (src/lower.mn). AST layout: [tag=95][val_ptr][state_updates_ptr].
  ;;
  ;; SNAPSHOT semantics: the resume value AND every update RHS read the
  ;; PRE-update state. All of them evaluate into scratch locals in
  ;; source order BEFORE any slot store commits; the saved value
  ;; returns. Without the snapshot, `resume(ctr + n) with ctr = ctr+1`
  ;; returned the NEW ctr + n (ev8d micro: 58-not-57) — the writeback
  ;; raced the value. Slot offsets resolved from the active arm's
  ;; state-fields (source-order canonical per
  ;; protocol_handler_is_state_is_closure_is_evidence.md); negative
  ;; offset (name not in fields) is productive-under-error; emit skips.
  ;; Empty state_updates → plain LReturn (Lock #6 behavior).
  ;;
  ;; Non-empty layout, stmts list of 2n+2 (identical to the wheel for
  ;; node-structure fixpoint parity):
  ;;   [0]      LLet("__resume_val_<h>", lo_val)
  ;;   [1+i]    LLet("__resume_upd_<i>_<h>", lower(upd_init_i))
  ;;   [1+n+i]  LStateSlotStore(off_i, LLocal("__resume_upd_<i>_<h>"))
  ;;   [2n+1]   LReturn(LLocal("__resume_val_<h>"))
  (func $lower_resume (export "lower_resume") (param $node i32) (result i32)
    (local $h i32) (local $body i32) (local $resume_struct i32)
    (local $val_node i32) (local $lo_val i32) (local $state_updates i32)
    (local $n i32) (local $i i32) (local $upd i32)
    (local $upd_name i32) (local $upd_init i32) (local $upd_lo i32)
    (local $offset i32)
    (local $fields i32) (local $stmts i32)
    (local $val_name i32) (local $scratch_name i32)
    (local.set $h              (call $walk_expr_node_handle (local.get $node)))
    (local.set $body           (i32.load offset=4 (local.get $node)))
    (local.set $resume_struct  (i32.load offset=4 (local.get $body)))
    (local.set $val_node       (i32.load offset=4 (local.get $resume_struct)))
    (local.set $state_updates  (i32.load offset=8 (local.get $resume_struct)))
    (local.set $lo_val         (call $lower_expr (local.get $val_node)))
    (local.set $n (call $len (local.get $state_updates)))
    (if (i32.eqz (local.get $n))
      (then
        (return (call $lexpr_make_lreturn
                  (local.get $h)
                  (local.get $lo_val)))))
    (local.set $fields (call $lower_get_active_state_fields))
    ;; "__resume_val_" ++ h
    (local.set $val_name (call $str_concat (i32.const 6576)
      (call $int_to_str (local.get $h))))
    (local.set $stmts (call $make_list (i32.const 0)))
    (local.set $stmts (call $list_extend_to (local.get $stmts)
      (i32.add (i32.shl (local.get $n) (i32.const 1)) (i32.const 2))))
    (drop (call $list_set (local.get $stmts) (i32.const 0)
      (call $lexpr_make_llet (local.get $h) (local.get $val_name)
        (local.get $lo_val))))
    (local.set $i (i32.const 0))
    (block $done
      (loop $each
        (br_if $done (i32.ge_u (local.get $i) (local.get $n)))
        (local.set $upd
          (call $list_index (local.get $state_updates) (local.get $i)))
        (local.set $upd_name
          (call $list_index (local.get $upd) (i32.const 0)))
        (local.set $upd_init
          (call $list_index (local.get $upd) (i32.const 1)))
        (local.set $upd_lo (call $lower_expr (local.get $upd_init)))
        (local.set $offset (call $lower_resolve_state_slot_offset
          (local.get $upd_name) (local.get $fields) (i32.const 0)))
        ;; "__resume_upd_" ++ i ++ "_" ++ h
        (local.set $scratch_name
          (call $str_concat
            (call $str_concat
              (call $str_concat (i32.const 6596)
                (call $int_to_str (local.get $i)))
              (i32.const 6616))
            (call $int_to_str (local.get $h))))
        (drop (call $list_set (local.get $stmts)
          (i32.add (local.get $i) (i32.const 1))
          (call $lexpr_make_llet (local.get $h) (local.get $scratch_name)
            (local.get $upd_lo))))
        (drop (call $list_set (local.get $stmts)
          (i32.add (i32.add (local.get $i) (i32.const 1)) (local.get $n))
          (call $lexpr_make_lstateslotstore
            (local.get $h) (local.get $offset)
            (call $lexpr_make_llocal (local.get $h) (local.get $scratch_name)))))
        (local.set $i (i32.add (local.get $i) (i32.const 1)))
        (br $each)))
    (drop (call $list_set (local.get $stmts)
      (i32.add (i32.shl (local.get $n) (i32.const 1)) (i32.const 1))
      (call $lexpr_make_lreturn (local.get $h)
        (call $lexpr_make_llocal (local.get $h) (local.get $val_name)))))
    (call $lexpr_make_lblock (local.get $h) (local.get $stmts)))

  ;; ─── $lower_mark_tail — Hβ.lower.tail-call-mark-pass ─────────────────
  ;; Walk a LowExpr in tail position; rewrite LCall(308) → LTailCall(309)
  ;; recursively through tail-preserving constructors. Tail position is
  ;; structural (graph-property): branches of LIf, last stmt of LBlock,
  ;; arm bodies of LMatch. Conservative on LRegion/LHandleWith/LFeedback —
  ;; their bodies are NOT tail (handler-cleanup / region-exit / feedback
  ;; continuation runs after, so a tail call would skip the surrounding
  ;; control-flow). Mutates lists in place via $list_set / $record_set
  ;; per buffer-counter (Ω.3) — caller's list pointer remains valid.
  ;;
  ;; Without this, every recursive call in lex_from / scan_decimal /
  ;; tree-walks compiles as call_indirect (regular), growing the WASM
  ;; stack frame-per-iteration; long inputs trap at "call stack
  ;; exhausted". The L1 fixpoint requires WASM tail-call extension
  ;; (return_call_indirect) at LTailCall emission sites — see
  ;; emit_call.wat:264-278 $emit_ltailcall.
  ;;
  ;; Eight interrogations cleared:
  ;;   Graph: tail-position is a structural property of the LowExpr tree.
  ;;   Handler: lower walks; pure derived information from position.
  ;;   Verb:  | > sequencing's rightmost stage IS tail.
  ;;   Row: no effect change.
  ;;   Ownership: same.
  ;;   Refinement: none.
  ;;   Gradient: tail-call IS a compile-time guarantee, recognized
  ;;             structurally.
  ;;   Reason: "tail-position because terminal expression of fn-body /
  ;;           branch-of-tail-LIf / arm-of-tail-LMatch / last-stmt-of-
  ;;           tail-LBlock."
  (func $lower_mark_tail (export "lower_mark_tail") (param $e i32) (result i32)
    (local $tag i32)
    (local $h i32) (local $fn i32) (local $args i32)
    (local $cond i32) (local $then_branch i32) (local $else_branch i32)
    (local $stmts i32) (local $stmts_len i32) (local $last_idx i32)
    (local $last i32) (local $marked i32)
    (local $arms i32) (local $arms_len i32) (local $i i32)
    (local $arm i32) (local $body i32)
    (if (i32.eqz (local.get $e))
      (then (return (local.get $e))))
    (local.set $tag (call $tag_of (local.get $e)))
    ;; LCall (308) → LTailCall (309).
    (if (i32.eq (local.get $tag) (i32.const 308))
      (then
        (local.set $h    (call $record_get (local.get $e) (i32.const 0)))
        (local.set $fn   (call $record_get (local.get $e) (i32.const 1)))
        (local.set $args (call $record_get (local.get $e) (i32.const 2)))
        (return (call $lexpr_make_ltailcall
                  (local.get $h) (local.get $fn) (local.get $args)))))
    ;; LSuspend (325) → LTailSuspend (338): evidence-threaded calls in
    ;; tail position return_call through the same record-build. Without
    ;; this, EVERY effect-rowed recursion (scan_to_eol's Memory row,
    ;; iterate_from's Iterate row) kept one frame per step and the
    ;; wheel-sized inputs exhausted the stack at pass-2.
    (if (i32.eq (local.get $tag) (i32.const 325))
      (then
        (return (call $lexpr_make_ltailsuspend
          (call $record_get (local.get $e) (i32.const 0))
          (call $record_get (local.get $e) (i32.const 1))
          (call $record_get (local.get $e) (i32.const 2))
          (call $record_get (local.get $e) (i32.const 3))
          (call $record_get (local.get $e) (i32.const 4))))))
    ;; LIf (314): mark both branches in tail. Branches are single-element
    ;; lists per $lower_if (walk_compound.wat:689-694 Lock #10).
    (if (i32.eq (local.get $tag) (i32.const 314))
      (then
        (local.set $then_branch (call $record_get (local.get $e) (i32.const 2)))
        (local.set $else_branch (call $record_get (local.get $e) (i32.const 3)))
        (if (i32.gt_s (call $len (local.get $then_branch)) (i32.const 0))
          (then
            (local.set $last     (call $list_index (local.get $then_branch) (i32.const 0)))
            (local.set $marked   (call $lower_mark_tail (local.get $last)))
            (drop (call $list_set (local.get $then_branch) (i32.const 0) (local.get $marked)))))
        (if (i32.gt_s (call $len (local.get $else_branch)) (i32.const 0))
          (then
            (local.set $last     (call $list_index (local.get $else_branch) (i32.const 0)))
            (local.set $marked   (call $lower_mark_tail (local.get $last)))
            (drop (call $list_set (local.get $else_branch) (i32.const 0) (local.get $marked)))))
        (return (local.get $e))))
    ;; LBlock (315): mark last stmt in tail. Per $lower_block
    ;; (walk_compound.wat:706-735) the final-expr lives at the last index.
    (if (i32.eq (local.get $tag) (i32.const 315))
      (then
        (local.set $stmts (call $record_get (local.get $e) (i32.const 1)))
        (local.set $stmts_len (call $len (local.get $stmts)))
        (if (i32.gt_s (local.get $stmts_len) (i32.const 0))
          (then
            (local.set $last_idx (i32.sub (local.get $stmts_len) (i32.const 1)))
            (local.set $last     (call $list_index (local.get $stmts) (local.get $last_idx)))
            (local.set $marked   (call $lower_mark_tail (local.get $last)))
            (drop (call $list_set (local.get $stmts) (local.get $last_idx) (local.get $marked)))))
        (return (local.get $e))))
    ;; LMatch (321): mark each arm body in tail. Arms are LPArm records
    ;; (lowpat.wat:235-247 tag 369, body at slot 1).
    (if (i32.eq (local.get $tag) (i32.const 321))
      (then
        (local.set $arms     (call $record_get (local.get $e) (i32.const 2)))
        (local.set $arms_len (call $len (local.get $arms)))
        (local.set $i (i32.const 0))
        (block $arms_done
          (loop $arms_iter
            (br_if $arms_done (i32.ge_s (local.get $i) (local.get $arms_len)))
            (local.set $arm   (call $list_index (local.get $arms) (local.get $i)))
            (local.set $body  (call $record_get (local.get $arm) (i32.const 1)))
            (local.set $marked (call $lower_mark_tail (local.get $body)))
            (call $record_set (local.get $arm) (i32.const 1) (local.get $marked))
            (local.set $i (i32.add (local.get $i) (i32.const 1)))
            (br $arms_iter)))
        (return (local.get $e))))
    ;; All other tags — identity. LRegion (328) / LHandleWith (329) /
    ;; LFeedback (330) deliberately not propagated (handler / region /
    ;; feedback cleanup runs after the body's last expression).
    (local.get $e))
