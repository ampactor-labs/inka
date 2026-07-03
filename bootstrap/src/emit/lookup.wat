  ;; ═══ lookup.wat — Hβ.emit type-driven dispatch primitives (Tier 5) ═══
  ;; Implements: Hβ-emit-substrate.md §2.1 (LConst dispatch on Ty —
  ;;             TInt/TBool/TUnit/TError-hole arms reading $lookup_ty) +
  ;;             §2.4 (LCall reads TFun arity for $ftN signature; LSuspend
  ;;             same shape) + §3 (H1.4 single-handler-per-op naming —
  ;;             $emit_op_symbol concatenates "op_<name>") + §5.1 row
  ;;             (Type-driven dispatch IS the gradient cash-out site —
  ;;             this chunk provides the per-Ty primitives chunks #3-#7
  ;;             call before emitting WAT) + §11.3 dep order (this
  ;;             chunk follows #1 state.wat).
  ;; Exports:    $emit_wat_type_for, $emit_arity_of_tfun,
  ;;             $emit_is_terror_hole, $emit_op_symbol.
  ;; Uses:       $ty_tag + $ty_tfun_params (infer/ty.wat),
  ;;             $len (runtime/list.wat), $str_concat (runtime/str.wat).
  ;;
  ;; What this chunk IS (per Hβ-emit-substrate.md §2.1 + §2.4 + §3 +
  ;; wheel canonical src/backends/wasm.mn:773-789 emit_type_decls +
  ;; lines 444-475 collect_fn_names + per-Ty-tag dispatch shape per
  ;; emit_diag.wat:540-655 render_ty):
  ;;
  ;;   1. $emit_wat_type_for(ty) — UNIFORM i32 representation per
  ;;      DESIGN.md §0.5 "the heap has one story" + γ §IX. Closures,
  ;;      ADT variants, nominal records, strings, lists, tuples,
  ;;      refined types — ALL emit as i32 (pointers OR sentinels).
  ;;      The 14 Ty tags collapse to ONE WAT type at the seed layer.
  ;;      Future TFloat substrate gets per-tag-arm via the named
  ;;      follow-up Hβ.emit.float-substrate; not V1.
  ;;
  ;;   2. $emit_arity_of_tfun(ty) — read TFun's params list length via
  ;;      $ty_tfun_params + $len. Returns -1 if not TFun (caller
  ;;      treats as polymorphic / call_indirect $ftN unknown — the
  ;;      LSuspend H1.6 polymorphic-minority path). Used by chunk #6
  ;;      emit_call.wat to pick $ftN signature for direct call vs
  ;;      LSuspend's call_indirect.
  ;;
  ;;   3. $emit_is_terror_hole(ty) — i32.eq($ty_tag, 114) — the
  ;;      sentinel ty.wat reserves for unresolved/error types per
  ;;      Hβ-lower-substrate.md §1.1 + lower/lookup.wat:177-180. Used
  ;;      by every emit arm to short-circuit emission to (unreachable)
  ;;      preserving Hazel productive-under-error: the LowExpr lowered
  ;;      fine but its type is unresolved — emit a trap so downstream
  ;;      tools can flag, instead of silently emitting wrong WAT.
  ;;
  ;;   4. $emit_op_symbol(op_name) — concatenate "op_" + name per H1.4
  ;;      single-handler-per-op naming (Hβ-emit §3 + wheel
  ;;      src/backends/wasm.mn:583-619 emit_fn_table). Each handler arm
  ;;      becomes (func $op_<op_name> ...) at module level; this
  ;;      symbol IS the WAT identifier. Caller passes it to
  ;;      $emit_funcref_register (state.wat) for the funcref-table.
  ;;
  ;; Eight interrogations (per Hβ-emit-substrate.md §5.1 second pass):
  ;;
  ;;   1. Graph?       $emit_arity_of_tfun + $emit_is_terror_hole read
  ;;                   the Ty record/sentinel directly via $ty_tag —
  ;;                   the live-graph result of $lookup_ty (lower/
  ;;                   lookup.wat) the caller already chased. Per
  ;;                   Anchor 1 "ask the graph": these helpers ARE
  ;;                   that ask, projected onto Ty's record shape.
  ;;                   $emit_op_symbol does not touch graph; pure
  ;;                   string concatenation.
  ;;   2. Handler?     At wheel: $emit_wat_type_for is one arm of
  ;;                   render_ty-like dispatch; the wheel's
  ;;                   emit_type_decls (src/backends/wasm.mn:773-789)
  ;;                   composes via WasmOut effect (perform wat_emit).
  ;;                   At seed: direct fns; dispatch on $ty_tag.
  ;;                   @resume=OneShot at the wheel (read-only lookup).
  ;;   3. Verb?        N/A — type-driven dispatch is verb-silent; the
  ;;                   verb topology emerges in chunks #6 (emit_call)
  ;;                   + #7 (emit_handler) where these helpers are
  ;;                   composed into per-verb WAT-shape decisions.
  ;;   4. Row?         TFun's row is RETURNED via $ty_tfun_row but
  ;;                   THIS chunk doesn't read it — chunk #6
  ;;                   emit_call.wat reads it for the monomorphic-vs-
  ;;                   polymorphic gate. lookup.wat is row-traversal-
  ;;                   silent.
  ;;   5. Ownership?   $emit_op_symbol allocates new string via
  ;;                   $str_concat (bump heap); caller OWNs the result.
  ;;                   $emit_wat_type_for returns static data-segment
  ;;                   string ptr (no allocation). Other helpers
  ;;                   return raw i32 (no ownership transfer).
  ;;   6. Refinement?  TRefined transparent — chunk #6's monomorphic
  ;;                   gate would unwrap if needed. lookup currently
  ;;                   treats TRefined opaque (returns "i32" which is
  ;;                   correct for both base and refined, and -1 for
  ;;                   $emit_arity_of_tfun unless explicitly TFun).
  ;;   7. Gradient?    THIS IS THE TYPE-DRIVEN DISPATCH SUBSTRATE.
  ;;                   $emit_arity_of_tfun's TFun→arity gate IS the
  ;;                   gradient site: TFun → direct-call $ftN
  ;;                   (compile-time-known arity); non-TFun → -1 →
  ;;                   call_indirect (runtime-resolved). Per row
  ;;                   inference's >95% monomorphic claim — the
  ;;                   gradient cashes out at chunk #6 emit_call.wat
  ;;                   reading these helpers.
  ;;   8. Reason?      Read-only — caller's $lookup_ty preserves
  ;;                   Reason chain on the handle. lookup.wat does
  ;;                   not write Reasons; downstream Mentl-Why
  ;;                   (Arc F.6) walks back via $gnode_reason on the
  ;;                   handle the LowExpr carries.
  ;;
  ;; Forbidden patterns audited (per Hβ-emit-substrate.md §6 + project
  ;; drift modes):
  ;;
  ;;   - Drift 1 (Rust vtable):     $emit_arity_of_tfun is direct ty-
  ;;                                tag dispatch (i32.eq + return); NO
  ;;                                $arity_table data segment / NO
  ;;                                _lookup_arity_handler function.
  ;;                                Word "vtable" appears nowhere.
  ;;   - Drift 5 (C calling conv):  No threaded __closure or __ev
  ;;                                params; helpers take Ty/handle/
  ;;                                str_ptr directly.
  ;;   - Drift 8 (string-keyed):    Tag dispatch via i32.eq on integer
  ;;                                tag constants (107 = TFun, 114 =
  ;;                                TError-hole). NEVER `str_eq(name,
  ;;                                "TFun")` ADT-as-string fluency.
  ;;   - Drift 9 (deferred-by-     Every export bodied; no stubs.
  ;;                  omission):    Max-arity-precise-walk is the
  ;;                                NAMED follow-up Hβ.emit.max-arity-
  ;;                                precise-walk (lands with chunk #9
  ;;                                main.wat or as separate helper) —
  ;;                                NAMED, not silently omitted from
  ;;                                this chunk.
  ;;   - Foreign fluency:           Vocabulary stays Mentl — "type",
  ;;                                "arity", "symbol", "tag dispatch".
  ;;                                NEVER "type-of" / "lookup-table" /
  ;;                                "name-mangle."
  ;;
  ;; Named follow-ups (per Drift 9 + Hβ-emit-substrate.md §10):
  ;;   - Hβ.emit.float-substrate: $emit_wat_type_for grows per-tag arm
  ;;                              for TFloat (101) → "f64" string ptr;
  ;;                              gates DSP / ML / numerical crucibles.
  ;;   - Hβ.emit.max-arity-precise-walk: max_arity_in(stmts) + 35-arm
  ;;                              max_arity_expr per wheel src/backends/
  ;;                              wasm.mn:730-769; lands with chunk #9
  ;;                              main.wat or separate helper.
  ;;
  ;; Static data — WAT type tokens (offsets 488-503; emit-private
  ;; region within [481, 512) free zone after lexer_data.wat keywords;
  ;; HEAP_BASE=4096 keeps these <HEAP_BASE; pointers stay disambiguable
  ;; from sentinels [0, HEAP_BASE)):
  ;;   488 — "i32" (3 bytes; the uniform WAT type for the seed)
  ;;   496 — "op_" (3 bytes; H1.4 prefix per wheel emit_fn_table)

  (data (i32.const 488) "\03\00\00\00i32")
  (data (i32.const 496) "\03\00\00\00op_")

  ;; ─── $emit_wat_type_for — UNIFORM i32 for any Ty (seed default) ───
  ;; Per DESIGN.md §0.5 "the heap has one story" + γ §IX. The 14 Ty
  ;; tags (100-113) all return "i32" string ptr (offset 488). Future
  ;; TFloat substrate gets per-tag-arm via Hβ.emit.float-substrate
  ;; follow-up; not V1.
  (func $emit_wat_type_for (param $ty i32) (result i32)
    (i32.const 488))

  ;; ─── $emit_arity_of_tfun — TFun's params list length, or -1 ──────
  ;; Per Hβ-emit-substrate.md §2.4 + wheel src/backends/wasm.mn:773-789.
  ;; Used by chunk #6 emit_call.wat to pick $ftN signature for LCall
  ;; (monomorphic) vs LSuspend's call_indirect (polymorphic).
  (func $emit_arity_of_tfun (param $ty i32) (result i32)
    (if (i32.ne (call $ty_tag (local.get $ty)) (i32.const 107))
      (then (return (i32.const -1))))
    (call $len (call $ty_tfun_params (local.get $ty))))

  ;; ─── $emit_is_terror_hole — sentinel for unresolved type ──────────
  ;; Per Hβ-lower-substrate.md §1.1 + lower/lookup.wat:177-180. Used
  ;; by every emit arm to short-circuit emission to (unreachable) per
  ;; Hazel productive-under-error.
  (func $emit_is_terror_hole (param $ty i32) (result i32)
    (i32.eq (call $ty_tag (local.get $ty)) (i32.const 114)))

  ;; ─── $emit_op_symbol — "op_" + name per H1.4 single-handler-per-op ─
  ;; Per Hβ-emit-substrate.md §3 + wheel src/backends/wasm.mn:583-619.
  ;; Caller passes result to $emit_funcref_register (state.wat) for the
  ;; funcref-table.
  (func $emit_op_symbol (param $op_name i32) (result i32)
    (call $str_concat (i32.const 496) (local.get $op_name)))

  ;; ─── $emit_repr_is_f64 — THE ONE HOME for "is this handle's value f64" ─
  ;; Hβ.emit.float-substrate (closed 2026-07-02). Mirror of the wheel's
  ;; repr_of(lookup_ty(h)) == RF64 decision (src/backends/wasm.mn:2698,
  ;; types.mn:93 TFloat => RF64). The seed carries no representation
  ;; gradient beyond the i32-floor and this f64 arm — a TFloat value lives
  ;; native unboxed f64 for its STACK life (literals/params/locals/results/
  ;; arithmetic/comparisons); handles/pointers stay the uniform i32 word.
  ;; Every f64-vs-i32 emit decision (param/result/local decl, binop op,
  ;; call_indirect signature) reads THIS — Carried-Truth: one decider, N
  ;; readers. Handle 0 (unread / no graph address) → i32 floor.
  (func $emit_repr_is_f64 (export "emit_repr_is_f64") (param $h i32) (result i32)
    (if (i32.eqz (local.get $h)) (then (return (i32.const 0))))
    (i32.eq (call $ty_tag (call $lookup_ty (local.get $h))) (i32.const 101)))

  ;; ─── $emit_ty_token — emit "f64" or "i32" (3 raw bytes) from a bool ─
  ;; No data segment — the two tokens are three bytes each, emitted inline.
  (func $emit_ty_token (export "emit_ty_token") (param $is_f64 i32)
    (if (local.get $is_f64)
      (then
        (call $emit_byte (i32.const 102))   ;; 'f'
        (call $emit_byte (i32.const 54))    ;; '6'
        (call $emit_byte (i32.const 52)))    ;; '4'
      (else
        (call $emit_byte (i32.const 105))   ;; 'i'
        (call $emit_byte (i32.const 51))    ;; '3'
        (call $emit_byte (i32.const 50)))))  ;; '2'

  (func $emit_ty_token_for_handle (export "emit_ty_token_for_handle") (param $h i32)
    (call $emit_ty_token (call $emit_repr_is_f64 (local.get $h))))

  ;; ─── $emit_expr_is_f64 — the WAT type EMISSION PRODUCES for a LowExpr ─
  ;; THE consistency keystone. The seed's inference resolves a value's type
  ;; at some handles and not others, so a raw $lookup_ty on a use-handle
  ;; disagrees with the decl. This function instead predicts the type
  ;; emission ACTUALLY produces, structurally — so decl and every use agree
  ;; by construction. It bottoms out at the RELIABLE leaves: a float literal
  ;; (LConst binds its own TFloat), an IntToFloat convert (structurally f64),
  ;; a local's declared type (the ledger, itself set by this function on the
  ;; RHS). Arithmetic carries operand width; comparison/logical/concat are
  ;; i32 (Bool/pointer). LCall/LField/LUpval fall to $lookup_ty (the callee-
  ;; result residue — named peer Hβ.seed.fn-result-repr-registry).
  (func $emit_expr_is_f64 (export "emit_expr_is_f64") (param $e i32) (result i32)
    (local $tag i32) (local $op i32) (local $stmts i32) (local $n i32)
    (if (i32.lt_u (local.get $e) (global.get $heap_base)) (then (return (i32.const 0))))
    (local.set $tag (call $tag_of (local.get $e)))
    ;; LLocal (301) → the local/param's declared width (ledger by name).
    (if (i32.eq (local.get $tag) (i32.const 301))
      (then (return (call $emit_fn_local_is_f64 (call $lexpr_llocal_name (local.get $e))))))
    ;; LConvert (339) → IntToFloat (kind 0) produces f64; FloatToInt i32.
    (if (i32.eq (local.get $tag) (i32.const 339))
      (then (return (i32.eqz (call $lexpr_lconvert_kind (local.get $e))))))
    ;; LConst (300) → the literal's own bound type (reliable leaf).
    (if (i32.eq (local.get $tag) (i32.const 300))
      (then (return (call $emit_repr_is_f64 (call $lexpr_handle (local.get $e))))))
    ;; LBinOp (306) → arithmetic (140-144) carries operand width; every
    ;; other op (comparison 145-150, logical 151-152, concat 153) is i32.
    (if (i32.eq (local.get $tag) (i32.const 306))
      (then
        (local.set $op (call $lexpr_lbinop_op (local.get $e)))
        (if (i32.and (i32.ge_s (local.get $op) (i32.const 140))
                     (i32.le_s (local.get $op) (i32.const 144)))
          (then (return (i32.or
                          (call $emit_expr_is_f64 (call $lexpr_lbinop_l (local.get $e)))
                          (call $emit_expr_is_f64 (call $lexpr_lbinop_r (local.get $e)))))))
        (return (i32.const 0))))
    ;; LUnaryOp (307) → f64 iff its operand is (UNeg on a float).
    (if (i32.eq (local.get $tag) (i32.const 307))
      (then (return (call $emit_expr_is_f64 (call $lexpr_lunaryop_x (local.get $e))))))
    ;; LReturn (310) → the returned value.
    (if (i32.eq (local.get $tag) (i32.const 310))
      (then (return (call $emit_expr_is_f64 (call $lexpr_lreturn_x (local.get $e))))))
    ;; LStore (303) → the stored value's width.
    (if (i32.eq (local.get $tag) (i32.const 303))
      (then (return (call $emit_expr_is_f64 (call $lexpr_lstore_value (local.get $e))))))
    ;; LBlock (315) → the block's final statement.
    (if (i32.eq (local.get $tag) (i32.const 315))
      (then
        (local.set $stmts (call $lexpr_lblock_stmts (local.get $e)))
        (local.set $n (call $len (local.get $stmts)))
        (if (i32.eqz (local.get $n)) (then (return (i32.const 0))))
        (return (call $emit_expr_is_f64
          (call $list_index (local.get $stmts) (i32.sub (local.get $n) (i32.const 1)))))))
    ;; LIf (314) → f64 iff EITHER branch's tail is f64. emit_lif declares
    ;; (result f64) and coerces the i32 branch up when the branches disagree,
    ;; so the produced width IS this OR. Reading only the then-branch (the
    ;; prior form) mispredicted a then-i32/else-f64 if (float_at's TFloatLit
    ;; arm: then = the payload word, else = 0.0) as i32 — the two-branch
    ;; mismatch. Carried-Truth: the prediction reads what emission produces.
    (if (i32.eq (local.get $tag) (i32.const 314))
      (then
        (local.set $stmts (call $lexpr_lif_then (local.get $e)))
        (local.set $n (call $len (local.get $stmts)))
        (if (local.get $n)
          (then
            (if (call $emit_expr_is_f64
                  (call $list_index (local.get $stmts) (i32.sub (local.get $n) (i32.const 1))))
              (then (return (i32.const 1))))))
        (local.set $stmts (call $lexpr_lif_else (local.get $e)))
        (local.set $n (call $len (local.get $stmts)))
        (if (i32.eqz (local.get $n)) (then (return (i32.const 0))))
        (return (call $emit_expr_is_f64
          (call $list_index (local.get $stmts) (i32.sub (local.get $n) (i32.const 1)))))))
    ;; LMatch (321) → the SAME width $emit_lmatch emits: f64 iff ANY arm tail
    ;; is f64 ($ec5_match_arms_any_f64, which coerces an i32 arm up). Without
    ;; this the read fell to the graph handle (a float scrutinee's Ty), which
    ;; the seed types f64 while the arms floor to i32 — the number_from_
    ;; substring implicit-return mismatch. The prediction reads what emission
    ;; produces (the LIf case's law, one node-kind over).
    (if (i32.eq (local.get $tag) (i32.const 321))
      (then (return (call $ec5_match_arms_any_f64 (call $lexpr_lmatch_arms (local.get $e))))))
    ;; State (326) and closure-capture (305) loads stay in the uniform i32
    ;; word world: state slots are never boxed, and an f64 closure capture
    ;; still FLOORS (LUpval handle resolution is a named follow-up —
    ;; Hβ.emit.f64-closure-capture-box), so their PRODUCED stack type is i32.
    ;; LFieldLoad (334) now UNBOXES an f64 field (i32.load pointer → f64.load
    ;; cell, §5.U seed), so it falls through to the handle read below — its
    ;; produced type IS emit_repr_is_f64(the field type).
    (if (i32.or (i32.eq (local.get $tag) (i32.const 326))
                (i32.eq (local.get $tag) (i32.const 305)))
      (then (return (i32.const 0))))
    ;; LCall/LTailCall → the callee's declared result width (the registry,
    ;; populated by the pre-pass). Falls to the seed's proven type when the
    ;; callee is unregistered (indirect callee, builtin).
    (if (i32.or (i32.eq (local.get $tag) (i32.const 308))
                (i32.eq (local.get $tag) (i32.const 309)))
      (then (return (call $emit_call_result_is_f64 (local.get $e)))))
    (call $emit_repr_is_f64 (call $lexpr_handle (local.get $e))))

  ;; $emit_call_result_is_f64 — a call's produced width is the CALLEE's
  ;; declared result. The callee is an LGlobal(name) in the fn field; the
  ;; fn-result registry ($emit_fn_result_is_f64, filled by the pre-pass)
  ;; holds each fn's body-tail width. Unregistered (an indirect/local
  ;; callee, or a runtime builtin) → the seed's proven type on the call
  ;; handle. This is the cross-fn half of the consistency keystone.
  (func $emit_call_result_is_f64 (param $e i32) (result i32)
    (local $fn i32) (local $name i32) (local $idx i32)
    (local.set $fn
      (if (result i32) (i32.eq (call $tag_of (local.get $e)) (i32.const 308))
        (then (call $lexpr_lcall_fn (local.get $e)))
        (else (call $lexpr_ltailcall_fn (local.get $e)))))
    ;; LGlobal (302) callee → its name; look up the registry.
    (if (i32.eq (call $tag_of (local.get $fn)) (i32.const 302))
      (then
        (local.set $name (call $lexpr_lglobal_name (local.get $fn)))
        (local.set $idx (call $emit_fn_result_lookup (local.get $name)))
        (if (i32.ge_s (local.get $idx) (i32.const 0))
          (then (return (call $emit_fn_result_bit (local.get $idx)))))
        ;; Unregistered direct callee — a handler arm, which the fixpoint
        ;; walks past (it registers only top-level fns). Its EMITTED result
        ;; is i32 (the arm-result convention meeting an f64 resume-value the
        ;; seed floors), which the graph type (f64 Sample) diverges from.
        ;; Read the EMISSION, not the graph: a caller `(x) => arm(x)` is then
        ;; (result i32) — consistent with the i32 arm — instead of the graph's
        ;; f64 view. Every f64-returning direct callee is top-level (registered
        ;; above); closures fall to the handle read below. Peer
        ;; Hβ.seed.arm-result-registry (the ultimate form registers the arms).
        (return (i32.const 0))))
    (call $emit_repr_is_f64 (call $lexpr_handle (local.get $e))))
