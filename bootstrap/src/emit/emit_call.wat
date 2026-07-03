  ;; ═══ emit_call.wat — Hβ.emit call family (Tier 6, chunk #6) ═════════
  ;; THE GRADIENT CASH-OUT SITE per Hβ-emit-substrate.md §2.4 — row
  ;; inference's >95% monomorphic claim cashes out at WAT here. SUBSTRATE.md
  ;; §I "The Duty of Inference is Reification" three resume disciplines
  ;; map to three emit paths on one substrate (OneShot direct return_call,
  ;; MultiShot heap-captured, polymorphic minority call_indirect through
  ;; closure record's fn-ptr field). NO vtable at any layer; closure
  ;; record IS the unified __state per W7 calling convention.
  ;;
  ;; Implements: §2.4 (call family — LBinOp tag 306 + LUnaryOp tag 307 +
  ;;             LCall tag 308 + LTailCall tag 309 + LIndex tag 320 +
  ;;             LSuspend tag 325) + §3.5 (EmitMemory swap surface —
  ;;             LSuspend's transient closure allocation routes through
  ;;             dynamic-size bump-pattern emission per named follow-up
  ;;             Hβ.emit.memory-alloc-dyn) + §5.1 (eight interrogations)
  ;;             + §7.1 (chunk #6) + §11.3 dep order (chunk #6 follows
  ;;             emit_control.wat).
  ;; Exports:    $emit_lcall, $emit_ltailcall, $emit_lbinop, $emit_lunaryop,
  ;;             $emit_lsuspend, $emit_lindex.
  ;; Uses:       $lexpr_lcall_fn / $lexpr_lcall_args + $lexpr_ltailcall_fn /
  ;;             $lexpr_ltailcall_args + $lexpr_lbinop_op / _l / _r +
  ;;             $lexpr_lunaryop_op / _x + $lexpr_lsuspend_op_h / _fn /
  ;;             _args / _evs + $lexpr_lindex_base / _idx / _is_str
  ;;             (lower/lexpr.wat),
  ;;             $emit_byte + $emit_int (emit_infra.wat),
  ;;             $emit_lexpr (emit_const.wat — partial dispatcher;
  ;;             this chunk RETROFITS its arm table for tags 306/307/308/
  ;;             309/320/325 per Hβ.emit.lexpr-dispatch-extension),
  ;;             $emit_alloc_dyn (emit_const.wat — LSuspend's transient
  ;;             closure routes through dynamic-size bump-pattern at
  ;;             the EmitMemory swap surface),
  ;;             $len + $list_index (runtime/list.wat).
  ;;
  ;; Eight interrogations (per Hβ-emit-substrate.md §5.1 second pass):
  ;;
  ;;   1. Graph?       Each arm reads its LowExpr's record fields via
  ;;                   $lexpr_l*_* accessors. LCall / LTailCall / LBinOp /
  ;;                   LUnaryOp / LSuspend / LIndex all recurse into
  ;;                   sub-LowExprs via $emit_lexpr. Per Anchor 1: ask
  ;;                   the graph; never re-derive shape.
  ;;   2. Handler?     At wheel: each arm is one branch of emit_expr
  ;;                   match. At seed: direct fn dispatch via $emit_lexpr's
  ;;                   tag table. @resume=OneShot at the wheel — emission
  ;;                   is single-pass per LowExpr tree.
  ;;   3. Verb?        |> — each arm's body is forward flow:
  ;;                   read fields → recurse-emit sub-exprs → emit
  ;;                   instruction tokens. The verbs (`<~` LFeedback,
  ;;                   `~>` LHandleWith) live in chunk #7.
  ;;   4. Row?         WasmOut at wheel; row-silent at seed. LSuspend
  ;;                   inlines bump-pattern emission for the transient
  ;;                   closure record — the EmitMemory effect at the
  ;;                   wheel; mirrored as a fixed body at the seed per
  ;;                   §3.5.1 substrate-level handler reference.
  ;;   5. Ownership?   LowExpr `r` is `ref` (read-only structural
  ;;                   traversal). $out_base buffer OWNed program-wide.
  ;;                   The transient closure LSuspend allocates is OWNed
  ;;                   by the call frame (the call_indirect consumes it
  ;;                   then the frame returns).
  ;;   6. Refinement?  N/A — call arms have no refinement obligations.
  ;;                   Refinement-aware arity discrimination (LCall vs
  ;;                   LSuspend) happens at lower time per
  ;;                   Hβ.lower.walk_call.wat monomorphic-vs-polymorphic
  ;;                   gate ($monomorphic_at).
  ;;   7. Gradient?    THIS IS THE GRADIENT CASH-OUT. LCall (monomorphic
  ;;                   ground row at inference) emits W7 closure-call
  ;;                   convention with call_indirect through closure's
  ;;                   fn-ptr field — H1 evidence reification, NOT
  ;;                   vtable indirection (per SUBSTRATE.md §I third
  ;;                   truth). LSuspend (polymorphic minority — the
  ;;                   <5% non-ground row at inference) emits transient
  ;;                   closure copy + ev_slot fill + call_indirect. The
  ;;                   row-inference annotation is what unlocks the
  ;;                   compile-time-known monomorphic path; without it,
  ;;                   every call would trade through the polymorphic
  ;;                   substrate.
  ;;   8. Reason?      Read-only — caller's $lookup_ty preserves Reason
  ;;                   chain. Call arms do not write Reasons.
  ;;
  ;; Forbidden patterns audited (per Hβ-emit-substrate.md §6 + project
  ;; drift modes):
  ;;
  ;;   - Drift 1 (Rust vtable):     LSUSPEND IS THE LOAD-BEARING ARM
  ;;                                FOR DRIFT 1 REFUSAL. The fn_index
  ;;                                is a FIELD on the closure record
  ;;                                (offset 0); call_indirect reads
  ;;                                that field via $ft<N+1> type. NO
  ;;                                $op_table data segment. NO
  ;;                                _lookup_handler_for_op fn. The
  ;;                                word "vtable" appears nowhere in
  ;;                                this chunk. Per SUBSTRATE.md §I:
  ;;                                "no table exists as a separate
  ;;                                structure at any layer."
  ;;   - Drift 5 (C calling conv):  W7 unifies __state with closure
  ;;                                record — single (state_ptr, args...,
  ;;                                fn_idx) call shape; NO separate
  ;;                                __closure/__ev split.
  ;;   - Drift 6 (Bool special):    N/A this chunk; nullary-variant
  ;;                                handling is in chunk #3 LMakeVariant.
  ;;   - Drift 7 (parallel arrays): args/evs lists are record-shaped
  ;;                                (single list ptr field); never
  ;;                                parallel name-arrays + value-arrays.
  ;;   - Drift 8 (string-keyed):    LBinOp dispatches on integer tag
  ;;                                (140-153 BinOp ADT region per
  ;;                                src/types.mn). LUnaryOp dispatches
  ;;                                on integer tag (160-179 UnaryOp
  ;;                                ADT region: UNeg=160, UNot=161 per
  ;;                                src/types.mn UnaryOp ADT). NO
  ;;                                string-keyed dispatch; structural
  ;;                                ADT discipline at every arm.
  ;;   - Drift 9 (deferred-by-      Every arm bodied. LSuspend's
  ;;                  omission):    transient closure allocation routes
  ;;                                through $emit_alloc_dyn (the
  ;;                                EmitMemory swap surface's dynamic-
  ;;                                size variant per emit_const.wat —
  ;;                                Anchor 5: every memory strategy is
  ;;                                a handler). The capture-copy loop
  ;;                                emits a fixed-shape (block + loop +
  ;;                                br_if) WAT sequence per LSuspend
  ;;                                site; this is the runtime loop that
  ;;                                copies nc captures from callee to
  ;;                                state_tmp.
  ;;   - Foreign fluency:           Vocabulary stays Mentl — "call",
  ;;                                "tail-call", "binop", "suspend",
  ;;                                "indirect", "transient evidence
  ;;                                record", "fn-ptr field". NEVER
  ;;                                "v-table" / "method-resolution-
  ;;                                table" / "dispatch-table".
  ;;
  ;; Named follow-ups (per Drift 9 + Hβ-emit-substrate.md §10):
  ;;   - Hβ.emit.lexpr-dispatch-extension: chunk #7 retrofits $emit_lexpr.

  ;; ─── Chunk-private byte-emission helpers ──────────────────────────

  (func $ec6_emit_local_set_state_tmp
    ;; emits: (local.set $state_tmp)
    (call $emit_byte (i32.const 40)) (call $emit_byte (i32.const 108))
    (call $emit_byte (i32.const 111)) (call $emit_byte (i32.const 99))
    (call $emit_byte (i32.const 97)) (call $emit_byte (i32.const 108))
    (call $emit_byte (i32.const 46)) (call $emit_byte (i32.const 115))
    (call $emit_byte (i32.const 101)) (call $emit_byte (i32.const 116))
    (call $emit_byte (i32.const 32)) (call $emit_byte (i32.const 36))
    (call $emit_byte (i32.const 115)) (call $emit_byte (i32.const 116))
    (call $emit_byte (i32.const 97)) (call $emit_byte (i32.const 116))
    (call $emit_byte (i32.const 101)) (call $emit_byte (i32.const 95))
    (call $emit_byte (i32.const 116)) (call $emit_byte (i32.const 109))
    (call $emit_byte (i32.const 112)) (call $emit_byte (i32.const 41)))

  (func $ec6_emit_local_get_state_tmp
    ;; emits: (local.get $state_tmp)
    (call $emit_byte (i32.const 40)) (call $emit_byte (i32.const 108))
    (call $emit_byte (i32.const 111)) (call $emit_byte (i32.const 99))
    (call $emit_byte (i32.const 97)) (call $emit_byte (i32.const 108))
    (call $emit_byte (i32.const 46)) (call $emit_byte (i32.const 103))
    (call $emit_byte (i32.const 101)) (call $emit_byte (i32.const 116))
    (call $emit_byte (i32.const 32)) (call $emit_byte (i32.const 36))
    (call $emit_byte (i32.const 115)) (call $emit_byte (i32.const 116))
    (call $emit_byte (i32.const 97)) (call $emit_byte (i32.const 116))
    (call $emit_byte (i32.const 101)) (call $emit_byte (i32.const 95))
    (call $emit_byte (i32.const 116)) (call $emit_byte (i32.const 109))
    (call $emit_byte (i32.const 112)) (call $emit_byte (i32.const 41)))

  (func $ec6_emit_i32_load_offset_0
    ;; emits: (i32.load offset=0)
    (call $emit_byte (i32.const 40)) (call $emit_byte (i32.const 105))
    (call $emit_byte (i32.const 51)) (call $emit_byte (i32.const 50))
    (call $emit_byte (i32.const 46)) (call $emit_byte (i32.const 108))
    (call $emit_byte (i32.const 111)) (call $emit_byte (i32.const 97))
    (call $emit_byte (i32.const 100)) (call $emit_byte (i32.const 32))
    (call $emit_byte (i32.const 111)) (call $emit_byte (i32.const 102))
    (call $emit_byte (i32.const 102)) (call $emit_byte (i32.const 115))
    (call $emit_byte (i32.const 101)) (call $emit_byte (i32.const 116))
    (call $emit_byte (i32.const 61)) (call $emit_byte (i32.const 48))
    (call $emit_byte (i32.const 41)))

  (func $ec6_emit_call_indirect_ftN (param $arity i32)
    ;; emits: (call_indirect (type $ft<arity+1>))
    ;; Per W7 closure-call convention: arity counts user args + implicit __state.
    (call $emit_byte (i32.const 40)) (call $emit_byte (i32.const 99))
    (call $emit_byte (i32.const 97)) (call $emit_byte (i32.const 108))
    (call $emit_byte (i32.const 108)) (call $emit_byte (i32.const 95))
    (call $emit_byte (i32.const 105)) (call $emit_byte (i32.const 110))
    (call $emit_byte (i32.const 100)) (call $emit_byte (i32.const 105))
    (call $emit_byte (i32.const 114)) (call $emit_byte (i32.const 101))
    (call $emit_byte (i32.const 99)) (call $emit_byte (i32.const 116))
    (call $emit_byte (i32.const 32)) (call $emit_byte (i32.const 40))
    (call $emit_byte (i32.const 116)) (call $emit_byte (i32.const 121))
    (call $emit_byte (i32.const 112)) (call $emit_byte (i32.const 101))
    (call $emit_byte (i32.const 32)) (call $emit_byte (i32.const 36))
    (call $emit_byte (i32.const 102)) (call $emit_byte (i32.const 116))
    (call $emit_int  (i32.add (local.get $arity) (i32.const 1)))
    (call $emit_byte (i32.const 41)) (call $emit_byte (i32.const 41)))

  (func $ec6_emit_return_call_indirect_ftN (param $arity i32)
    ;; emits: (return_call_indirect (type $ft<arity+1>))
    (call $emit_byte (i32.const 40)) (call $emit_byte (i32.const 114))
    (call $emit_byte (i32.const 101)) (call $emit_byte (i32.const 116))
    (call $emit_byte (i32.const 117)) (call $emit_byte (i32.const 114))
    (call $emit_byte (i32.const 110)) (call $emit_byte (i32.const 95))
    (call $emit_byte (i32.const 99)) (call $emit_byte (i32.const 97))
    (call $emit_byte (i32.const 108)) (call $emit_byte (i32.const 108))
    (call $emit_byte (i32.const 95)) (call $emit_byte (i32.const 105))
    (call $emit_byte (i32.const 110)) (call $emit_byte (i32.const 100))
    (call $emit_byte (i32.const 105)) (call $emit_byte (i32.const 114))
    (call $emit_byte (i32.const 101)) (call $emit_byte (i32.const 99))
    (call $emit_byte (i32.const 116)) (call $emit_byte (i32.const 32))
    (call $emit_byte (i32.const 40)) (call $emit_byte (i32.const 116))
    (call $emit_byte (i32.const 121)) (call $emit_byte (i32.const 112))
    (call $emit_byte (i32.const 101)) (call $emit_byte (i32.const 32))
    (call $emit_byte (i32.const 36)) (call $emit_byte (i32.const 102))
    (call $emit_byte (i32.const 116))
    (call $emit_int  (i32.add (local.get $arity) (i32.const 1)))
    (call $emit_byte (i32.const 41)) (call $emit_byte (i32.const 41)))

  ;; ─── $ec6_emit_call_indirect_typed — the call ABI, typed by the args ─
  ;; The call_indirect type MUST match the callee's real signature. When
  ;; every arg + the result is i32 (the >99% case) this IS the arity-keyed
  ;; $ftN — byte-identical to the pre-f64 emit (Law 7). When any arg or the
  ;; result is f64, the arity key is insufficient (a float in slot k needs
  ;; f64 in the type), so emit the signature INLINE:
  ;;   (call_indirect (param i32) (param <repr>)* (result <repr>))
  ;; the implicit __state (always i32) + one param per arg at its proven
  ;; repr + the result repr. The callee (emit_fn_body) types its params
  ;; and result from the SAME graph, so the two agree by construction —
  ;; the wheel's repr-vector ft (wasm.mn:979-1013) realized inline (no ft
  ;; naming/dedup table needed; the type IS read from the args).
  ;; $ec6_args_any_f64 — 1 iff any user arg emits f64. The fixed-i32 ev
  ;; dispatch ($ftN) carries only word args; this is the gate that floors a
  ;; native-f64 arg it cannot type (emit_levperform).
  (func $ec6_args_any_f64 (param $args i32) (result i32)
    (local $i i32) (local $n i32)
    (local.set $n (call $len (local.get $args)))
    (local.set $i (i32.const 0))
    (block $d (loop $it
      (br_if $d (i32.ge_u (local.get $i) (local.get $n)))
      (if (call $emit_expr_is_f64 (call $list_index (local.get $args) (local.get $i)))
        (then (return (i32.const 1))))
      (local.set $i (i32.add (local.get $i) (i32.const 1)))
      (br $it)))
    (i32.const 0))

  (func $ec6_emit_call_indirect_typed (param $args i32) (param $result_is_f64 i32) (param $is_tail i32)
    (local $n i32) (local $i i32) (local $any_f64 i32)
    (local.set $n (call $len (local.get $args)))
    (local.set $any_f64 (local.get $result_is_f64))
    (local.set $i (i32.const 0))
    (block $d (loop $it
      (br_if $d (i32.ge_u (local.get $i) (local.get $n)))
      (if (call $emit_expr_is_f64 (call $list_index (local.get $args) (local.get $i)))
        (then (local.set $any_f64 (i32.const 1))))
      (local.set $i (i32.add (local.get $i) (i32.const 1)))
      (br $it)))
    (if (i32.eqz (local.get $any_f64))
      (then
        (if (local.get $is_tail)
          (then (call $ec6_emit_return_call_indirect_ftN (local.get $n)))
          (else (call $ec6_emit_call_indirect_ftN (local.get $n))))
        (return)))
    (if (local.get $is_tail)
      (then (call $ec6_emit_return_call_indirect_open))
      (else (call $ec6_emit_call_indirect_open)))
    ;; (param i32) — the implicit __state
    (call $ec6_emit_param_open)
    (call $emit_byte (i32.const 105)) (call $emit_byte (i32.const 51)) (call $emit_byte (i32.const 50))
    (call $emit_byte (i32.const 41))
    ;; (param <repr>) per user arg, in push order
    (local.set $i (i32.const 0))
    (block $d2 (loop $it2
      (br_if $d2 (i32.ge_u (local.get $i) (local.get $n)))
      (call $ec6_emit_param_open)
      (call $emit_ty_token
        (call $emit_expr_is_f64 (call $list_index (local.get $args) (local.get $i))))
      (call $emit_byte (i32.const 41))
      (local.set $i (i32.add (local.get $i) (i32.const 1)))
      (br $it2)))
    ;; (result <repr>)
    (call $ec6_emit_result_open)
    (call $emit_ty_token (local.get $result_is_f64))
    (call $emit_byte (i32.const 41))
    ;; close the call_indirect
    (call $emit_byte (i32.const 41)))

  (func $ec6_emit_call_indirect_open
    ;; emits: "(call_indirect "
    (call $emit_byte (i32.const 40)) (call $emit_byte (i32.const 99))
    (call $emit_byte (i32.const 97)) (call $emit_byte (i32.const 108))
    (call $emit_byte (i32.const 108)) (call $emit_byte (i32.const 95))
    (call $emit_byte (i32.const 105)) (call $emit_byte (i32.const 110))
    (call $emit_byte (i32.const 100)) (call $emit_byte (i32.const 105))
    (call $emit_byte (i32.const 114)) (call $emit_byte (i32.const 101))
    (call $emit_byte (i32.const 99)) (call $emit_byte (i32.const 116))
    (call $emit_byte (i32.const 32)))

  (func $ec6_emit_return_call_indirect_open
    ;; emits: "(return_call_indirect "
    (call $emit_byte (i32.const 40)) (call $emit_byte (i32.const 114))
    (call $emit_byte (i32.const 101)) (call $emit_byte (i32.const 116))
    (call $emit_byte (i32.const 117)) (call $emit_byte (i32.const 114))
    (call $emit_byte (i32.const 110)) (call $emit_byte (i32.const 95))
    (call $emit_byte (i32.const 99)) (call $emit_byte (i32.const 97))
    (call $emit_byte (i32.const 108)) (call $emit_byte (i32.const 108))
    (call $emit_byte (i32.const 95)) (call $emit_byte (i32.const 105))
    (call $emit_byte (i32.const 110)) (call $emit_byte (i32.const 100))
    (call $emit_byte (i32.const 105)) (call $emit_byte (i32.const 114))
    (call $emit_byte (i32.const 101)) (call $emit_byte (i32.const 99))
    (call $emit_byte (i32.const 116)) (call $emit_byte (i32.const 32)))

  (func $ec6_emit_param_open
    ;; emits: "(param "
    (call $emit_byte (i32.const 40)) (call $emit_byte (i32.const 112))
    (call $emit_byte (i32.const 97)) (call $emit_byte (i32.const 114))
    (call $emit_byte (i32.const 97)) (call $emit_byte (i32.const 109))
    (call $emit_byte (i32.const 32)))

  (func $ec6_emit_result_open
    ;; emits: "(result "
    (call $emit_byte (i32.const 40)) (call $emit_byte (i32.const 114))
    (call $emit_byte (i32.const 101)) (call $emit_byte (i32.const 115))
    (call $emit_byte (i32.const 117)) (call $emit_byte (i32.const 108))
    (call $emit_byte (i32.const 116)) (call $emit_byte (i32.const 32)))

  ;; ─── $ec6_emit_args — emit each LowExpr in args list via $emit_lexpr ─
  (func $ec6_emit_args (param $args i32)
    (local $i i32) (local $n i32)
    (local.set $n (call $len (local.get $args)))
    (local.set $i (i32.const 0))
    (block $done
      (loop $iter
        (br_if $done (i32.ge_u (local.get $i) (local.get $n)))
        (call $emit_lexpr
          (call $list_index (local.get $args) (local.get $i)))
        (local.set $i (i32.add (local.get $i) (i32.const 1)))
        (br $iter))))

  ;; ─── $emit_lcall — LCall tag 308 emit arm per §2.4 ─────────────────
  ;; Per src/backends/wasm.mn:1174-1189 W7 closure-call convention:
  ;;   1. emit closure (fn LowExpr) → ptr on stack
  ;;   2. (local.set $state_tmp) — save closure ptr
  ;;   3. (local.get $state_tmp) — push as implicit __state arg
  ;;   4. emit args via $emit_lexpr (each arg pushed)
  ;;   5. (local.get $state_tmp) (i32.load offset=0) — load fn_ptr
  ;;   6. (call_indirect (type $ft<N+1>)) — N+1 includes __state
  ;;
  ;; The fn_ptr is a FIELD on the closure record at offset 0. Per
  ;; SUBSTRATE.md §I third truth: evidence passing per Koka JFP 2022,
  ;; NOT vtable indirection. The closure record IS the unified
  ;; __state per W7.
  ;; Per Hβ.emit.lcall-per-handle-state-scratch (2026-05-09): use
  ;; per-handle "$call_<H>" local instead of shared $state_tmp. Nested
  ;; calls (e.g. `is_alnum(byte_at(s, p))`) clobbered $state_tmp during
  ;; inner-arg emission, producing call_indirect ftN type-mismatch
  ;; traps. Per-handle scratch isolates each call's closure-pointer per
  ;; protocol_emit_is_graph_projection.md "graph encodes per-call-site
  ;; uniqueness; emit projects through it." Local declared by alloc-
  ;; handle-locals walk's LCall arm (main.wat).
  (func $emit_lcall (param $r i32)
    (local $args i32) (local $local_name i32)
    (local.set $args (call $lexpr_lcall_args (local.get $r)))
    (local.set $local_name
      (call $str_concat (i32.const 1680)                  ;; "call_"
                        (call $int_to_str (call $lexpr_handle (local.get $r)))))
    (call $emit_lexpr (call $lexpr_lcall_fn (local.get $r)))
    (call $ec_emit_local_set_dollar (local.get $local_name))
    (call $ec_emit_local_get_dollar (local.get $local_name))
    (call $ec6_emit_args (local.get $args))
    (call $ec_emit_local_get_dollar (local.get $local_name))
    (call $ec6_emit_i32_load_offset_0)
    (call $ec6_emit_call_indirect_typed
      (local.get $args) (call $emit_expr_is_f64 (local.get $r)) (i32.const 0)))

  ;; ─── $emit_ltailcall — LTailCall tag 309 emit arm per §2.4 ─────────
  ;; Per src/backends/wasm.mn:1191-1200. Same shape as LCall but with
  ;; return_call_indirect — H7 multi-shot's tail-resumptive optimization
  ;; (~85% per SUBSTRATE.md §III "Tail-resumptive").
  (func $emit_ltailcall (param $r i32)
    (local $args i32) (local $local_name i32)
    (local.set $args (call $lexpr_ltailcall_args (local.get $r)))
    (local.set $local_name
      (call $str_concat (i32.const 1680)                  ;; "call_"
                        (call $int_to_str (call $lexpr_handle (local.get $r)))))
    (call $emit_lexpr (call $lexpr_ltailcall_fn (local.get $r)))
    (call $ec_emit_local_set_dollar (local.get $local_name))
    (call $ec_emit_local_get_dollar (local.get $local_name))
    (call $ec6_emit_args (local.get $args))
    (call $ec_emit_local_get_dollar (local.get $local_name))
    (call $ec6_emit_i32_load_offset_0)
    ;; A tail call's result IS the enclosing fn's result — WASM requires the
    ;; return_call_indirect's result type to equal it (else "return signatures
    ;; inconsistent"). Read the enclosing result live ($emit_cur_result_f64,
    ;; published at the fn's (result …) decl), never the callee's predicted
    ;; result — the two diverge whenever the seed types the tail target's
    ;; result differently from the fn it returns from (estimate_flux's f64
    ;; body tail-calling an i32-predicted callee).
    (call $ec6_emit_call_indirect_typed
      (local.get $args) (global.get $emit_cur_result_f64) (i32.const 1)))

  ;; ─── $emit_lbinop — LBinOp tag 306 emit arm per §2.4 ───────────────
  ;; Per src/backends/wasm.mn:1163-1167 + emit_binop at 1646-1661.
  ;; Tags 140-153 (parser_infra.wat:329-342) map 1:1 to WAT i32 ops
  ;; for BAdd-BOr (140-152). BConcat (153) dispatches per operand Ty:
  ;;   - TString (102)  → $str_concat
  ;;   - TList   (105)  → $list_alloc_concat (lazy concat tag-3 node)
  ;;   - other          → $str_concat (fall-through; preserves current
  ;;                                    behavior pre H.3.c when type
  ;;                                    inference doesn't resolve to a
  ;;                                    distinguishing Ty).
  ;;
  ;; Per H.3.c: the wheel uses `++` for both strings AND lists. Using
  ;; the operand handle's looked-up Ty as the dispatch key is the
  ;; substrate-honest move (drift 8 refusal — type-tag dispatch, not
  ;; mode-flag); the LowExpr's `_l` operand carries its source handle
  ;; via $lexpr_handle, and $lookup_ty (emit/lookup.wat) resolves the
  ;; current chase-deep Ty from the inference graph.
  (func $emit_lbinop (param $r i32)
    (local $op i32) (local $left_lexpr i32)
    (local $left_h i32) (local $left_ty i32) (local $left_ty_tag i32)
    (local $right_h i32) (local $right_ty_tag i32)
    (local.set $left_lexpr (call $lexpr_lbinop_l (local.get $r)))
    (call $emit_lexpr (local.get $left_lexpr))
    (call $emit_lexpr (call $lexpr_lbinop_r (local.get $r)))
    (local.set $op (call $lexpr_lbinop_op (local.get $r)))

    ;; f64 arithmetic/comparison — the representation gradient's float arm.
    ;; The op IS a native f64 instruction iff the operands are f64: 140-143
    ;; → f64.add/sub/mul/div, 145-150 → f64.eq/ne/lt/gt/le/ge (comparison
    ;; yields i32 — Bool stays a word). Both operands are already emitted
    ;; (native f64 on the stack). $emit_expr_is_f64 predicts each operand's
    ;; EMITTED type (the same structural read the operand's own emission
    ;; used), so op and operands agree. Read from EITHER side — a resolved
    ;; literal vs an unresolved-float binding, the BConcat precedent below.
    (if (i32.or
          (call $emit_expr_is_f64 (local.get $left_lexpr))
          (call $emit_expr_is_f64 (call $lexpr_lbinop_r (local.get $r))))
      (then
        ;; The f64 arm fires when EITHER operand is f64. If they DISAGREE
        ;; (one f64, one i32) the seed's no-instantiation inference left a
        ;; mixed-width binop it can't emit consistently — a float accumulator
        ;; meeting an int index (exp_series `term * r`), a heap-f64 the
        ;; predictor floored to i32. Floor the op LOUD: (unreachable) is
        ;; stack-polymorphic, so the already-emitted operands stay valid and
        ;; the minimal expression traps if reached. The rung-critical float
        ;; chain (float_to_str/float_floor_log10) pairs an f64 var with an f64
        ;; literal — operands AGREE — so it never floors here. Censused to
        ;; stderr; gates arbitrate (a live floored op fails a rung, never a
        ;; silent wrong value). Peer Hβ.seed.f64-binop-mixed-width. Dissolves
        ;; at first-light when the wheel's own inference types both operands.
        (if (i32.ne
              (call $emit_expr_is_f64 (local.get $left_lexpr))
              (call $emit_expr_is_f64 (call $lexpr_lbinop_r (local.get $r))))
          (then
            (call $eprint_string (call $int_to_str (local.get $op)))
            (call $eprint_string (i32.const 8048))          ;; "\n"
            (call $ec_emit_unreachable)
            (call $emit_byte (i32.const 10))                ;; "\n"
            (return)))
        (call $ec6_emit_f64_binop_op (local.get $op))
        (return)))

    ;; BConcat (153): operand-Ty dispatch — the proof becomes the dispatch,
    ;; read from EITHER operand. The graph often proves the RIGHT operand
    ;; (a constructed list literal `xs ++ [x]`) where the LEFT is a floored
    ;; pattern/param binding (h=0 or a junk TName from lookup_ty(0)).
    ;; Reading only the left DISCARDED that proof: `frame.local_order ++
    ;; [name]` emitted str_concat-on-lists — the 6-byte overlapping allocs
    ;; whose bleed-through bytes read as the !list_index "span" trap
    ;; (2026-07-02, the four red march-gate rungs, one root).
    ;; Per Hβ.emit.runtime-helper-state-push: str_concat / list_concat
    ;; are W7-compiled fns expecting (state, a, b). Stack here has
    ;; [a, b]; insert state UNDER via save-reload through $state_tmp +
    ;; $callee_closure (both pre-declared in fn preamble).
    (if (i32.eq (local.get $op) (i32.const 153))
      (then
        (call $ec6_emit_local_set_callee_closure)    ;; pop right → scratch
        (call $ec6_emit_local_set_state_tmp)         ;; pop left → scratch
        (call $el_emit_local_get_state)              ;; push state
        (call $ec6_emit_local_get_state_tmp)         ;; push left
        (call $ec6_emit_local_get_callee_closure)    ;; push right
        (local.set $left_ty_tag (i32.const 0))
        (local.set $left_h (call $lexpr_handle (local.get $left_lexpr)))
        (if (i32.ne (local.get $left_h) (i32.const 0))
          (then (local.set $left_ty_tag
                  (call $ty_tag (call $lookup_ty (local.get $left_h))))))
        (local.set $right_ty_tag (i32.const 0))
        (local.set $right_h (call $lexpr_handle (call $lexpr_lbinop_r (local.get $r))))
        (if (i32.ne (local.get $right_h) (i32.const 0))
          (then (local.set $right_ty_tag
                  (call $ty_tag (call $lookup_ty (local.get $right_h))))))
        ;; A proven TList (105) on either side decides list_concat.
        (if (i32.or (i32.eq (local.get $left_ty_tag) (i32.const 105))
                    (i32.eq (local.get $right_ty_tag) (i32.const 105)))
          (then (call $ec6_emit_call_list_alloc_concat) (return)))
        ;; A proven TString (102) on either side decides str_concat.
        (if (i32.or (i32.eq (local.get $left_ty_tag) (i32.const 102))
                    (i32.eq (local.get $right_ty_tag) (i32.const 102)))
          (then (call $ec6_emit_call_str_concat) (return)))
        ;; NEITHER side proves — the LOUD residue, never a silent guess.
        ;; Census 2026-07-02 (whole-wheel): 17 such sites, every one
        ;; measured string-true (int_to_str / float_format_* / join_loop /
        ;; replace / assemble_render — TVar/TInt-junk operand types the
        ;; seed's no-instantiation inference cannot resolve). str_concat
        ;; is the measured-correct default for that class; the eprint
        ;; keeps each site visible in every build log, so a NEW unproven
        ;; list-concat can never hide behind this arm again. Dissolves
        ;; with the seed at first-light.
        (call $eprint_string (i32.const 8000))    ;; "W_ConcatUnproven h="
        (call $eprint_string (call $int_to_str (local.get $left_h)))
        (call $eprint_string (i32.const 8048))    ;; "\n"
        (call $ec6_emit_call_str_concat)
        (return)))
    ;; BEq (145) / BNe (146): == IS structural — operand-Ty dispatch
    ;; per the BConcat precedent above. TString (102) → $str_eq
    ;; (W7-compiled (state, a, b); same save-reload state insert);
    ;; BNe wraps (i32.eqz). Scalars and all other tags fall to the
    ;; flat i32.eq/i32.ne table. Deep types (TList/ADT) diag at
    ;; wheel-lower time (E_StructuralEqUnsupported — peer
    ;; Hβ.eq.structural-deep); never silent pointer-eq-as-structural.
    (if (i32.or (i32.eq (local.get $op) (i32.const 145))
                (i32.eq (local.get $op) (i32.const 146)))
      (then
        (local.set $left_h (call $lexpr_handle (local.get $left_lexpr)))
        ;; Handle-less LowExpr (no graph address) → flat scalar compare;
        ;; only graph-addressed operands consult $lookup_ty.
        (if (i32.eqz (local.get $left_h))
          (then
            (call $ec6_emit_binop_op (local.get $op))
            (return)))
        (local.set $left_ty (call $lookup_ty (local.get $left_h)))
        (local.set $left_ty_tag (call $ty_tag (local.get $left_ty)))
        ;; CONSULT BOTH operands — `==` is symmetric. env_find's `k == name`
        ;; carries the String on `name` (the param annotation), not the
        ;; polymorphic destructure-local `k`. If the left didn't resolve to a
        ;; sequence (TString/TList), adopt the RIGHT operand's type. str_eq if
        ;; EITHER side is TString; a free TVar on both falls to flat i32.eq
        ;; (never silent pointer-eq for a KNOWN sequence — no-silent-fallback).
        (if (i32.and (i32.ne (local.get $left_ty_tag) (i32.const 102))
                     (i32.ne (local.get $left_ty_tag) (i32.const 105)))
          (then
            (local.set $left_h (call $lexpr_handle (call $lexpr_lbinop_r (local.get $r))))
            (if (i32.ne (local.get $left_h) (i32.const 0))
              (then (local.set $left_ty_tag
                      (call $ty_tag (call $lookup_ty (local.get $left_h))))))))
        (if (i32.eq (local.get $left_ty_tag) (i32.const 102))   ;; TString
          (then
            (call $ec6_emit_local_set_callee_closure)    ;; pop right → scratch
            (call $ec6_emit_local_set_state_tmp)         ;; pop left → scratch
            (call $el_emit_local_get_state)              ;; push state
            (call $ec6_emit_local_get_state_tmp)         ;; push left
            (call $ec6_emit_local_get_callee_closure)    ;; push right
            (call $ec6_emit_call_str_eq)
            (if (i32.eq (local.get $op) (i32.const 146))
              (then (call $ec6_emit_i32_eqz)))
            (return)))
        ;; TList (105): (unreachable) per LUnresolved no-silent-fallback —
        ;; pointer-eq lying as structural is the named wrong; deep eq
        ;; is peer Hβ.eq.structural-deep. Scalars + TName fall through.
        (if (i32.eq (local.get $left_ty_tag) (i32.const 105))   ;; TList
          (then
            (call $emit_byte (i32.const 40))   ;; '('
            (call $emit_byte (i32.const 117))  ;; 'u'
            (call $emit_byte (i32.const 110))  ;; 'n'
            (call $emit_byte (i32.const 114))  ;; 'r'
            (call $emit_byte (i32.const 101))  ;; 'e'
            (call $emit_byte (i32.const 97))   ;; 'a'
            (call $emit_byte (i32.const 99))   ;; 'c'
            (call $emit_byte (i32.const 104))  ;; 'h'
            (call $emit_byte (i32.const 97))   ;; 'a'
            (call $emit_byte (i32.const 98))   ;; 'b'
            (call $emit_byte (i32.const 108))  ;; 'l'
            (call $emit_byte (i32.const 101))  ;; 'e'
            (call $emit_byte (i32.const 41))   ;; ')'
            (return)))))
    (call $ec6_emit_binop_op (local.get $op)))

  ;; ─── $ec6_emit_binop_op — dispatch on integer tag 140-153 ──────────
  ;; Drift 1 refusal: direct (i32.eq tag N) chain; no $binop_table
  ;; data segment, no closure-record dispatch. Drift 8 refusal: tags
  ;; are integer constants (the wheel's BAdd→i32.add etc. mapping).
  (func $ec6_emit_binop_op (param $op i32)
    (if (i32.eq (local.get $op) (i32.const 140))
      (then (call $ec6_emit_i32_add)        (return)))
    (if (i32.eq (local.get $op) (i32.const 141))
      (then (call $ec6_emit_i32_sub)        (return)))
    (if (i32.eq (local.get $op) (i32.const 142))
      (then (call $ec6_emit_i32_mul)        (return)))
    (if (i32.eq (local.get $op) (i32.const 143))
      (then (call $ec6_emit_i32_div_s)      (return)))
    (if (i32.eq (local.get $op) (i32.const 144))
      (then (call $ec6_emit_i32_rem_s)      (return)))
    (if (i32.eq (local.get $op) (i32.const 145))
      (then (call $ec6_emit_i32_eq)         (return)))
    (if (i32.eq (local.get $op) (i32.const 146))
      (then (call $ec6_emit_i32_ne)         (return)))
    (if (i32.eq (local.get $op) (i32.const 147))
      (then (call $ec6_emit_i32_lt_s)       (return)))
    (if (i32.eq (local.get $op) (i32.const 148))
      (then (call $ec6_emit_i32_gt_s)       (return)))
    (if (i32.eq (local.get $op) (i32.const 149))
      (then (call $ec6_emit_i32_le_s)       (return)))
    (if (i32.eq (local.get $op) (i32.const 150))
      (then (call $ec6_emit_i32_ge_s)       (return)))
    (if (i32.eq (local.get $op) (i32.const 151))
      (then (call $ec6_emit_i32_and)        (return)))
    (if (i32.eq (local.get $op) (i32.const 152))
      (then (call $ec6_emit_i32_or)         (return)))
    (if (i32.eq (local.get $op) (i32.const 153))
      (then (call $ec6_emit_call_str_concat) (return)))
    (unreachable))

  ;; ─── $ec6_emit_f64_binop_op — f64 arm of the BinOp ADT dispatch ────
  ;; Parallel to $ec6_emit_binop_op: the same integer-tag chain, the f64
  ;; instructions. 140-143 arithmetic (f64 result), 145-150 comparison
  ;; (i32/Bool result). 144 (BRem) has no f64 instruction — the wheel's
  ;; float path never takes `%` on a float, so it is a LOUD floor, never a
  ;; silent i32.rem_s fabrication (no-silent-fallback). 151/152 (BAnd/BOr)
  ;; and 153 (BConcat) are not float ops — handled by the caller before
  ;; this dispatch (a bitwise/concat op never has a TFloat operand).
  (func $ec6_emit_f64_binop_op (param $op i32)
    (if (i32.eq (local.get $op) (i32.const 140))
      (then (call $ec6_emit_f64_add) (return)))
    (if (i32.eq (local.get $op) (i32.const 141))
      (then (call $ec6_emit_f64_sub) (return)))
    (if (i32.eq (local.get $op) (i32.const 142))
      (then (call $ec6_emit_f64_mul) (return)))
    (if (i32.eq (local.get $op) (i32.const 143))
      (then (call $ec6_emit_f64_div) (return)))
    (if (i32.eq (local.get $op) (i32.const 145))
      (then (call $ec6_emit_f64_eq) (return)))
    (if (i32.eq (local.get $op) (i32.const 146))
      (then (call $ec6_emit_f64_ne) (return)))
    (if (i32.eq (local.get $op) (i32.const 147))
      (then (call $ec6_emit_f64_lt) (return)))
    (if (i32.eq (local.get $op) (i32.const 148))
      (then (call $ec6_emit_f64_gt) (return)))
    (if (i32.eq (local.get $op) (i32.const 149))
      (then (call $ec6_emit_f64_le) (return)))
    (if (i32.eq (local.get $op) (i32.const 150))
      (then (call $ec6_emit_f64_ge) (return)))
    ;; 144 BRem or any non-f64 op reaching here: loud floor.
    ;; emits: (unreachable) ;; F64-REM
    (call $emit_byte (i32.const 40)) (call $emit_byte (i32.const 117))
    (call $emit_byte (i32.const 110)) (call $emit_byte (i32.const 114))
    (call $emit_byte (i32.const 101)) (call $emit_byte (i32.const 97))
    (call $emit_byte (i32.const 99)) (call $emit_byte (i32.const 104))
    (call $emit_byte (i32.const 97)) (call $emit_byte (i32.const 98))
    (call $emit_byte (i32.const 108)) (call $emit_byte (i32.const 101))
    (call $emit_byte (i32.const 41))
    (call $emit_byte (i32.const 32)) (call $emit_byte (i32.const 59))
    (call $emit_byte (i32.const 59)) (call $emit_byte (i32.const 32))
    (call $emit_byte (i32.const 70)) (call $emit_byte (i32.const 54))
    (call $emit_byte (i32.const 52)) (call $emit_byte (i32.const 45))
    (call $emit_byte (i32.const 82)) (call $emit_byte (i32.const 69))
    (call $emit_byte (i32.const 77)))

  ;; ─── BinOp WAT-instruction emitters — inline byte sequences ────────

  (func $ec6_emit_i32_add
    ;; emits: (i32.add)
    (call $emit_byte (i32.const 40)) (call $emit_byte (i32.const 105))
    (call $emit_byte (i32.const 51)) (call $emit_byte (i32.const 50))
    (call $emit_byte (i32.const 46)) (call $emit_byte (i32.const 97))
    (call $emit_byte (i32.const 100)) (call $emit_byte (i32.const 100))
    (call $emit_byte (i32.const 41)))

  (func $ec6_emit_i32_sub
    ;; emits: (i32.sub)
    (call $emit_byte (i32.const 40)) (call $emit_byte (i32.const 105))
    (call $emit_byte (i32.const 51)) (call $emit_byte (i32.const 50))
    (call $emit_byte (i32.const 46)) (call $emit_byte (i32.const 115))
    (call $emit_byte (i32.const 117)) (call $emit_byte (i32.const 98))
    (call $emit_byte (i32.const 41)))

  (func $ec6_emit_i32_mul
    ;; emits: (i32.mul)
    (call $emit_byte (i32.const 40)) (call $emit_byte (i32.const 105))
    (call $emit_byte (i32.const 51)) (call $emit_byte (i32.const 50))
    (call $emit_byte (i32.const 46)) (call $emit_byte (i32.const 109))
    (call $emit_byte (i32.const 117)) (call $emit_byte (i32.const 108))
    (call $emit_byte (i32.const 41)))

  (func $ec6_emit_i32_div_s
    ;; emits: (i32.div_s)
    (call $emit_byte (i32.const 40)) (call $emit_byte (i32.const 105))
    (call $emit_byte (i32.const 51)) (call $emit_byte (i32.const 50))
    (call $emit_byte (i32.const 46)) (call $emit_byte (i32.const 100))
    (call $emit_byte (i32.const 105)) (call $emit_byte (i32.const 118))
    (call $emit_byte (i32.const 95)) (call $emit_byte (i32.const 115))
    (call $emit_byte (i32.const 41)))

  (func $ec6_emit_i32_rem_s
    ;; emits: (i32.rem_s)
    (call $emit_byte (i32.const 40)) (call $emit_byte (i32.const 105))
    (call $emit_byte (i32.const 51)) (call $emit_byte (i32.const 50))
    (call $emit_byte (i32.const 46)) (call $emit_byte (i32.const 114))
    (call $emit_byte (i32.const 101)) (call $emit_byte (i32.const 109))
    (call $emit_byte (i32.const 95)) (call $emit_byte (i32.const 115))
    (call $emit_byte (i32.const 41)))

  (func $ec6_emit_i32_eq
    ;; emits: (i32.eq)
    (call $emit_byte (i32.const 40)) (call $emit_byte (i32.const 105))
    (call $emit_byte (i32.const 51)) (call $emit_byte (i32.const 50))
    (call $emit_byte (i32.const 46)) (call $emit_byte (i32.const 101))
    (call $emit_byte (i32.const 113)) (call $emit_byte (i32.const 41)))

  (func $ec6_emit_i32_ne
    ;; emits: (i32.ne)
    (call $emit_byte (i32.const 40)) (call $emit_byte (i32.const 105))
    (call $emit_byte (i32.const 51)) (call $emit_byte (i32.const 50))
    (call $emit_byte (i32.const 46)) (call $emit_byte (i32.const 110))
    (call $emit_byte (i32.const 101)) (call $emit_byte (i32.const 41)))

  (func $ec6_emit_i32_lt_s
    ;; emits: (i32.lt_s)
    (call $emit_byte (i32.const 40)) (call $emit_byte (i32.const 105))
    (call $emit_byte (i32.const 51)) (call $emit_byte (i32.const 50))
    (call $emit_byte (i32.const 46)) (call $emit_byte (i32.const 108))
    (call $emit_byte (i32.const 116)) (call $emit_byte (i32.const 95))
    (call $emit_byte (i32.const 115)) (call $emit_byte (i32.const 41)))

  (func $ec6_emit_i32_gt_s
    ;; emits: (i32.gt_s)
    (call $emit_byte (i32.const 40)) (call $emit_byte (i32.const 105))
    (call $emit_byte (i32.const 51)) (call $emit_byte (i32.const 50))
    (call $emit_byte (i32.const 46)) (call $emit_byte (i32.const 103))
    (call $emit_byte (i32.const 116)) (call $emit_byte (i32.const 95))
    (call $emit_byte (i32.const 115)) (call $emit_byte (i32.const 41)))

  (func $ec6_emit_i32_le_s
    ;; emits: (i32.le_s)
    (call $emit_byte (i32.const 40)) (call $emit_byte (i32.const 105))
    (call $emit_byte (i32.const 51)) (call $emit_byte (i32.const 50))
    (call $emit_byte (i32.const 46)) (call $emit_byte (i32.const 108))
    (call $emit_byte (i32.const 101)) (call $emit_byte (i32.const 95))
    (call $emit_byte (i32.const 115)) (call $emit_byte (i32.const 41)))

  (func $ec6_emit_i32_ge_s
    ;; emits: (i32.ge_s)
    (call $emit_byte (i32.const 40)) (call $emit_byte (i32.const 105))
    (call $emit_byte (i32.const 51)) (call $emit_byte (i32.const 50))
    (call $emit_byte (i32.const 46)) (call $emit_byte (i32.const 103))
    (call $emit_byte (i32.const 101)) (call $emit_byte (i32.const 95))
    (call $emit_byte (i32.const 115)) (call $emit_byte (i32.const 41)))

  (func $ec6_emit_i32_and
    ;; emits: (i32.and)
    (call $emit_byte (i32.const 40)) (call $emit_byte (i32.const 105))
    (call $emit_byte (i32.const 51)) (call $emit_byte (i32.const 50))
    (call $emit_byte (i32.const 46)) (call $emit_byte (i32.const 97))
    (call $emit_byte (i32.const 110)) (call $emit_byte (i32.const 100))
    (call $emit_byte (i32.const 41)))

  (func $ec6_emit_i32_or
    ;; emits: (i32.or)
    (call $emit_byte (i32.const 40)) (call $emit_byte (i32.const 105))
    (call $emit_byte (i32.const 51)) (call $emit_byte (i32.const 50))
    (call $emit_byte (i32.const 46)) (call $emit_byte (i32.const 111))
    (call $emit_byte (i32.const 114)) (call $emit_byte (i32.const 41)))

  (func $ec6_emit_call_str_concat
    ;; emits: (call $str_concat)
    (call $emit_byte (i32.const 40)) (call $emit_byte (i32.const 99))
    (call $emit_byte (i32.const 97)) (call $emit_byte (i32.const 108))
    (call $emit_byte (i32.const 108)) (call $emit_byte (i32.const 32))
    (call $emit_byte (i32.const 36)) (call $emit_byte (i32.const 115))
    (call $emit_byte (i32.const 116)) (call $emit_byte (i32.const 114))
    (call $emit_byte (i32.const 95)) (call $emit_byte (i32.const 99))
    (call $emit_byte (i32.const 111)) (call $emit_byte (i32.const 110))
    (call $emit_byte (i32.const 99)) (call $emit_byte (i32.const 97))
    (call $emit_byte (i32.const 116)) (call $emit_byte (i32.const 41)))

  (func $ec6_emit_call_str_eq
    ;; emits: (call $str_eq)
    (call $emit_byte (i32.const 40)) (call $emit_byte (i32.const 99))
    (call $emit_byte (i32.const 97)) (call $emit_byte (i32.const 108))
    (call $emit_byte (i32.const 108)) (call $emit_byte (i32.const 32))
    (call $emit_byte (i32.const 36)) (call $emit_byte (i32.const 115))
    (call $emit_byte (i32.const 116)) (call $emit_byte (i32.const 114))
    (call $emit_byte (i32.const 95)) (call $emit_byte (i32.const 101))
    (call $emit_byte (i32.const 113)) (call $emit_byte (i32.const 41)))

  ;; Per H.3.c emit-list-runtime-call: BConcat over TList operands
  ;; emits a call to wheel-defined $list_concat (lib/runtime/lists.mn:
  ;; 129) — allocates a tag=3 lazy concat node with both operand
  ;; pointers. Length is sum of left.len + right.len, computed lazily
  ;; on access via $list_index / $list_to_flat (wheel runtime).
  ;;
  ;; Per Hβ.first-light.runtime-builtin-emit-substrate (2026-05-07) +
  ;; protocol_emit_is_graph_projection.md: emit names the wheel-Mentl
  ;; fn, NOT the seed's hand-WAT internal `$list_alloc_concat`. The
  ;; substrate-honest path is the wheel's source-of-truth (Anchor 4:
  ;; build the wheel; never wrap the axle). Compiled wheel-output IS
  ;; self-contained because $list_concat is defined in lib/runtime/
  ;; lists.mn alongside $list_pop, $range, etc.
  (func $ec6_emit_call_list_alloc_concat
    ;; emits: (call $list_concat)
    (call $emit_byte (i32.const 40))  (call $emit_byte (i32.const 99))   ;; '(' 'c'
    (call $emit_byte (i32.const 97))  (call $emit_byte (i32.const 108))  ;; 'a' 'l'
    (call $emit_byte (i32.const 108)) (call $emit_byte (i32.const 32))   ;; 'l' ' '
    (call $emit_byte (i32.const 36))  (call $emit_byte (i32.const 108))  ;; '$' 'l'
    (call $emit_byte (i32.const 105)) (call $emit_byte (i32.const 115))  ;; 'i' 's'
    (call $emit_byte (i32.const 116)) (call $emit_byte (i32.const 95))   ;; 't' '_'
    (call $emit_byte (i32.const 99))  (call $emit_byte (i32.const 111))  ;; 'c' 'o'
    (call $emit_byte (i32.const 110)) (call $emit_byte (i32.const 99))   ;; 'n' 'c'
    (call $emit_byte (i32.const 97))  (call $emit_byte (i32.const 116))  ;; 'a' 't'
    (call $emit_byte (i32.const 41)))                                    ;; ')'

  ;; ─── $emit_lunaryop — LUnaryOp tag 307 emit arm per §2.4 ───────────
  ;; Per src/backends/wasm.mn:1163-1166 + emit_unaryop at 1663-1666.
  ;; Dispatches on UnaryOp ADT i32 sentinel (UNeg=160, UNot=161 per
  ;; src/types.mn UnaryOp ADT in 160-179 reserved region — mirror of
  ;; BinOp 140-153). Drift 8 refusal: integer-tag ADT, not string-keyed.
  ;; Hβ.first-light.unary-neg-stack-order — UNeg emits 0 - x, NOT x - 0.
  ;; emit_lexpr leaves x on top; for `0 - x` the kernel-correct sequence
  ;; is: pop x to $state_tmp, push 0, push x from $state_tmp, sub.
  ;; BConcat at line 309+ uses the same scratch-local pattern; fully
  ;; reuses fn-preamble locals (no new state).
  (func $emit_lunaryop (param $r i32)
    (local $op i32) (local $x i32) (local $x_h i32) (local $x_ty i32) (local $x_ty_tag i32)
    (local.set $x (call $lexpr_lunaryop_x (local.get $r)))
    (call $emit_lexpr (local.get $x))
    (local.set $op (call $lexpr_lunaryop_op (local.get $r)))
    
    ;; f64 negation — the operand is already emitted (native f64 on the
    ;; stack); UNeg is the single native f64.neg instruction (no 0-x
    ;; scratch dance the i32 arm needs, and the recurrence's `0.0 - f`
    ;; would parse as a binop anyway). Read the operand's proven type.
    (if (call $emit_expr_is_f64 (local.get $x))
      (then
        (if (i32.eq (local.get $op) (i32.const 160))   ;; UNeg
          (then (call $ec6_emit_f64_neg) (return)))))

    (if (i32.eq (local.get $op) (i32.const 160))   ;; UNeg
      (then (call $ec6_emit_neg) (return)))
    (if (i32.eq (local.get $op) (i32.const 161))   ;; UNot
      (then (call $ec6_emit_i32_eqz) (return)))
    (unreachable))

  (func $ec6_emit_neg
    ;; emits: (local.set $state_tmp) (i32.const 0) (local.get $state_tmp) (i32.sub)
    ;; Computes 0 - x = -x. Operand x sits on top after emit_lexpr;
    ;; sink it into $state_tmp (preamble-declared in every fn), push
    ;; the constant 0 below, restore x above, then i32.sub.
    (call $ec6_emit_local_set_state_tmp)
    ;; "(i32.const 0)\n"
    (call $emit_byte (i32.const 40))  (call $emit_byte (i32.const 105))
    (call $emit_byte (i32.const 51))  (call $emit_byte (i32.const 50))
    (call $emit_byte (i32.const 46))  (call $emit_byte (i32.const 99))
    (call $emit_byte (i32.const 111)) (call $emit_byte (i32.const 110))
    (call $emit_byte (i32.const 115)) (call $emit_byte (i32.const 116))
    (call $emit_byte (i32.const 32))  (call $emit_byte (i32.const 48))
    (call $emit_byte (i32.const 41))  (call $emit_byte (i32.const 10))
    (call $ec6_emit_local_get_state_tmp)
    (call $ec6_emit_i32_sub))

  (func $ec6_emit_i32_eqz
    ;; emits: (i32.eqz)
    (call $emit_byte (i32.const 40)) (call $emit_byte (i32.const 105))
    (call $emit_byte (i32.const 51)) (call $emit_byte (i32.const 50))
    (call $emit_byte (i32.const 46)) (call $emit_byte (i32.const 101))
    (call $emit_byte (i32.const 113)) (call $emit_byte (i32.const 122))
    (call $emit_byte (i32.const 41)))

  ;; ─── $emit_lindex — LIndex tag 320 emit arm per §2.4 ───────────────
  ;; Per Hβ-emit-substrate.md §2.4 — "$list_index / $str_index_byte"
  ;; substrate-correct dispatch on is_str flag. Wheel canonical at
  ;; 1372-1377 emits raw arithmetic (base + idx*4 + i32.load) which
  ;; assumes flat-tag list layout — that's WHEEL DRIFT (would break
  ;; on snoc-tree lists per CLAUDE.md bug class). Seed substrate-honest
  ;; path: always dispatch through $list_index (which tag-walks per
  ;; runtime/list.wat) for non-string, $byte_at for string (per
  ;; runtime/str.wat:29). Emits:
  ;;   <base> <idx> (call $list_index)        ;; or (call $byte_at)
  ;; Per Hβ.emit.runtime-helper-state-push: list_index / byte_at are
  ;; W7-compiled (state, base, idx). Save-reload pattern same as BConcat.
  (func $emit_lindex (param $r i32)
    (call $emit_lexpr (call $lexpr_lindex_base (local.get $r)))
    (call $emit_lexpr (call $lexpr_lindex_idx (local.get $r)))
    (call $ec6_emit_local_set_callee_closure)    ;; pop idx → scratch
    (call $ec6_emit_local_set_state_tmp)         ;; pop base → scratch
    (call $el_emit_local_get_state)              ;; push state
    (call $ec6_emit_local_get_state_tmp)         ;; push base
    (call $ec6_emit_local_get_callee_closure)    ;; push idx
    (if (call $lexpr_lindex_is_str (local.get $r))
      (then (call $ec6_emit_call_byte_at) (return)))   ;; a string byte is i32, never boxed
    (call $ec6_emit_call_list_index)
    ;; An f64 list element's word slot holds a boxed-cell POINTER (§5.U seed);
    ;; UNBOX it. Past the is_str return this is a list; LIndex falls through to
    ;; emit_repr_is_f64(lexpr_handle) = the element type, so the produced f64
    ;; matches what every consumer already expects.
    (if (call $emit_expr_is_f64 (local.get $r))
      (then (call $ec6_emit_f64_load))))

  (func $ec6_emit_call_list_index
    ;; emits: (call $list_index)
    (call $emit_byte (i32.const 40)) (call $emit_byte (i32.const 99))
    (call $emit_byte (i32.const 97)) (call $emit_byte (i32.const 108))
    (call $emit_byte (i32.const 108)) (call $emit_byte (i32.const 32))
    (call $emit_byte (i32.const 36)) (call $emit_byte (i32.const 108))
    (call $emit_byte (i32.const 105)) (call $emit_byte (i32.const 115))
    (call $emit_byte (i32.const 116)) (call $emit_byte (i32.const 95))
    (call $emit_byte (i32.const 105)) (call $emit_byte (i32.const 110))
    (call $emit_byte (i32.const 100)) (call $emit_byte (i32.const 101))
    (call $emit_byte (i32.const 120)) (call $emit_byte (i32.const 41)))

  (func $ec6_emit_call_byte_at
    ;; emits: (call $byte_at)
    (call $emit_byte (i32.const 40)) (call $emit_byte (i32.const 99))
    (call $emit_byte (i32.const 97)) (call $emit_byte (i32.const 108))
    (call $emit_byte (i32.const 108)) (call $emit_byte (i32.const 32))
    (call $emit_byte (i32.const 36)) (call $emit_byte (i32.const 98))
    (call $emit_byte (i32.const 121)) (call $emit_byte (i32.const 116))
    (call $emit_byte (i32.const 101)) (call $emit_byte (i32.const 95))
    (call $emit_byte (i32.const 97)) (call $emit_byte (i32.const 116))
    (call $emit_byte (i32.const 41)))

  ;; ─── $emit_lsuspend — LSuspend tag 325 emit arm per §2.4 ───────────
  ;; THE DRIFT 1 LOAD-BEARING ARM. H1.6 polymorphic call with transient
  ;; evidence record. Per src/backends/wasm.mn:1396-1465 + SUBSTRATE.md
  ;; §I third truth "polymorphic minority":
  ;;
  ;; 1. Save callee closure pointer.
  ;; 2. Compute alloc_size = 8 + 4*nc + 4*ne (header 8 + nc captures
  ;;    + ne ev_slots).
  ;; 3. Inline bump-alloc (named follow-up Hβ.emit.memory-alloc-dyn
  ;;    will route through dynamic-size $emit_alloc variant).
  ;; 4. Copy header (fn_ptr + capture_count) from callee_closure to
  ;;    state_tmp.
  ;; 5. Runtime loop copies each capture (callee[8+4*i] → state_tmp[8+4*i]).
  ;; 6. Emit ev_slot stores (each ev_slot expr stored at offset
  ;;    8 + 4*nc + 4*j; nc is dynamic so stores compute offsets at
  ;;    runtime via state_tmp + 8 + 4*nc + 4*j arithmetic).
  ;; 7. Dispatch: (state_tmp, args..., fn_ptr) → call_indirect.
  ;;
  ;; THE FN_PTR IS A FIELD ON THE CLOSURE RECORD (offset 0). NO vtable.
  ;; NO $op_table. The transient closure record IS the unified __state.
  ;;
  ;; This arm is the longest emit body in chunk #6 — the polymorphic
  ;; minority's substrate cost is paid here, exactly once per LSuspend
  ;; site. The >95% monomorphic claim cashes out by these sites being
  ;; the <5% case row inference cannot ground at compile time.
  ;; ─── Length-prefixed local-name strings for $emit_alloc_dyn ──────
  ;; Per Hβ.emit.const-make-arms's $emit_alloc convention: target arg
  ;; is a length-prefixed str_ptr that $emit_str reads at emission.
  ;; Free zones verified by data-offset audit:
  ;;   1856-1869: "alloc_size" (4 hdr + 10 body = 14 bytes;
  ;;              [1856, 1872) gap pre-1872 "expected" wasm.mn string)
  ;;   2244-2257: "state_tmp"  (4 hdr +  9 body = 13 bytes;
  ;;              [2241, 2263) gap post-2216 "handler uninstallable"
  ;;              pre-2264 "over-declared")
  (data (i32.const 1856) "\0a\00\00\00alloc_size")
  ;; ── BConcat loud-residue strings (emit_lbinop unproven-operand arm).
  ;;    [8000, 8060) claimed; free region continues at 8064. ──
  (data (i32.const 8000) "\13\00\00\00W_ConcatUnproven h=")
  (data (i32.const 8048) "\01\00\00\00\0a")
  (data (i32.const 2244) "\09\00\00\00state_tmp")
  ;;   6480-6487: "sst_" per-handle LSuspend state prefix (4 hdr + 4
  ;;              body = 8 bytes; 6000+ relocation band, post-6456 ":")
  (data (i32.const 6480) "\04\00\00\00sst_")

  (func $emit_lsuspend (param $r i32) (param $tail i32)
    (local $args i32) (local $evs i32) (local $ne i32) (local $sname i32)
    (local.set $args (call $lexpr_lsuspend_args (local.get $r)))
    (local.set $evs  (call $lexpr_lsuspend_evs  (local.get $r)))
    (local.set $ne   (call $len (local.get $evs)))
    ;; Per-handle state local "sst_<h>" (1fa5f97 per-handle discipline,
    ;; extended to LSuspend): nested suspends emit inside the ARGS, and
    ;; at runtime the inner suspend clobbers any SHARED scratch before
    ;; the outer dispatch's fn_idx read — stage N then call_indirects
    ;; through stage N-1's record (the ft-mismatch class). The handle
    ;; names the record; declare-at-emission declares the local at the
    ;; alloc's store projection.
    (local.set $sname (call $str_concat (i32.const 6480)
      (call $int_to_str (call $lexpr_handle (local.get $r)))))
    ;; Save callee closure to $callee_closure.
    (call $emit_lexpr (call $lexpr_lsuspend_fn (local.get $r)))
    (call $ec6_emit_local_set_callee_closure)
    ;; Compute alloc_size = 8 + (8*ne + 4) + (callee.capture_count * 4) into
    ;; $alloc_size local: header + the keyed ev region (2 words/entry + a key=0
    ;; sentinel = 2*ne+1 words) + the copied captures (runtime nc). Each operand
    ;; pushed in order; final i32.add folds, local.set $alloc_size stores it.
    (call $ec6_emit_i32_const_lit (i32.const 8))
    (call $ec6_emit_i32_const_lit
      (i32.add (i32.mul (local.get $ne) (i32.const 8)) (i32.const 4)))
    (call $ec6_emit_i32_add)
    (call $ec6_emit_local_get_callee_closure)
    (call $ec6_emit_i32_load_offset_4)
    (call $ec6_emit_i32_const_lit (i32.const 4))
    (call $ec6_emit_i32_mul)
    (call $ec6_emit_i32_add)
    (call $ec6_emit_local_set_alloc_size)
    ;; EmitMemory swap surface: dynamic-size bump-alloc into $state_tmp,
    ;; reading $alloc_size at runtime. Future arena/gc handlers swap
    ;; this body without touching the LSuspend arm.
    (call $emit_alloc_dyn (i32.const 1856) (local.get $sname))   ;; "alloc_size" → bind to "sst_<h>"
    ;; Copy header: sst[0] = callee[0]; sst[4] = callee[4].
    (call $ec_emit_local_get_dollar (local.get $sname))
    (call $ec6_emit_local_get_callee_closure)
    (call $ec6_emit_i32_load_offset_0)
    (call $ec6_emit_i32_store_offset_0)
    (call $ec_emit_local_get_dollar (local.get $sname))
    (call $ec6_emit_local_get_callee_closure)
    (call $ec6_emit_i32_load_offset_4)
    (call $ec6_emit_i32_store_offset_4)
    ;; Runtime loop: copy nc captures from callee to sst_<h>.
    (call $ec6_emit_capture_copy_loop (local.get $sname))
    ;; Store each ev_slot at runtime-computed offset 8 + 4*nc + 4*j.
    (call $ec6_emit_ev_slot_stores (local.get $evs) (local.get $sname))
    ;; Dispatch: (sst_<h>, args..., fn_ptr) → call_indirect $ft<N+1>.
    (call $ec_emit_local_get_dollar (local.get $sname))
    (call $ec6_emit_args (local.get $args))
    (call $ec_emit_local_get_dollar (local.get $sname))
    (call $ec6_emit_i32_load_offset_0)
    ;; The evidence-capturing closure dispatch is the fixed-i32 $ftN — a
    ;; native f64 arg (a Float into an effectful fn: enumerate_float_literals'
    ;; `float_literal_candidate(0.0)`) cannot ride it without typing the
    ;; callee's param f64 AND its dispatch index (peer Hβ.seed.typed-ev-
    ;; dispatch). Floor LOUD — (unreachable) is stack-polymorphic, the
    ;; emitted sst/args/fn_ptr stay valid, the dispatch traps if reached
    ;; (never a silent wrong call). Dissolves at first-light.
    (if (call $ec6_args_any_f64 (local.get $args))
      (then (call $ec_emit_unreachable))
      (else
        (if (i32.ne (local.get $tail) (i32.const 0))
          (then (call $ec6_emit_return_call_indirect_ftN
            (call $len (local.get $args))))
          (else (call $ec6_emit_call_indirect_ftN
            (call $len (local.get $args))))))))

  ;; ─── LSuspend support helpers ──────────────────────────────────────

  (func $ec6_emit_local_set_callee_closure
    ;; emits: (local.set $callee_closure)
    (call $emit_byte (i32.const 40)) (call $emit_byte (i32.const 108))
    (call $emit_byte (i32.const 111)) (call $emit_byte (i32.const 99))
    (call $emit_byte (i32.const 97)) (call $emit_byte (i32.const 108))
    (call $emit_byte (i32.const 46)) (call $emit_byte (i32.const 115))
    (call $emit_byte (i32.const 101)) (call $emit_byte (i32.const 116))
    (call $emit_byte (i32.const 32)) (call $emit_byte (i32.const 36))
    (call $emit_byte (i32.const 99)) (call $emit_byte (i32.const 97))
    (call $emit_byte (i32.const 108)) (call $emit_byte (i32.const 108))
    (call $emit_byte (i32.const 101)) (call $emit_byte (i32.const 101))
    (call $emit_byte (i32.const 95)) (call $emit_byte (i32.const 99))
    (call $emit_byte (i32.const 108)) (call $emit_byte (i32.const 111))
    (call $emit_byte (i32.const 115)) (call $emit_byte (i32.const 117))
    (call $emit_byte (i32.const 114)) (call $emit_byte (i32.const 101))
    (call $emit_byte (i32.const 41)))

  (func $ec6_emit_local_get_callee_closure
    ;; emits: (local.get $callee_closure)
    (call $emit_byte (i32.const 40)) (call $emit_byte (i32.const 108))
    (call $emit_byte (i32.const 111)) (call $emit_byte (i32.const 99))
    (call $emit_byte (i32.const 97)) (call $emit_byte (i32.const 108))
    (call $emit_byte (i32.const 46)) (call $emit_byte (i32.const 103))
    (call $emit_byte (i32.const 101)) (call $emit_byte (i32.const 116))
    (call $emit_byte (i32.const 32)) (call $emit_byte (i32.const 36))
    (call $emit_byte (i32.const 99)) (call $emit_byte (i32.const 97))
    (call $emit_byte (i32.const 108)) (call $emit_byte (i32.const 108))
    (call $emit_byte (i32.const 101)) (call $emit_byte (i32.const 101))
    (call $emit_byte (i32.const 95)) (call $emit_byte (i32.const 99))
    (call $emit_byte (i32.const 108)) (call $emit_byte (i32.const 111))
    (call $emit_byte (i32.const 115)) (call $emit_byte (i32.const 117))
    (call $emit_byte (i32.const 114)) (call $emit_byte (i32.const 101))
    (call $emit_byte (i32.const 41)))

  (func $ec6_emit_local_set_alloc_size
    ;; emits: (local.set $alloc_size)
    (call $emit_byte (i32.const 40)) (call $emit_byte (i32.const 108))
    (call $emit_byte (i32.const 111)) (call $emit_byte (i32.const 99))
    (call $emit_byte (i32.const 97)) (call $emit_byte (i32.const 108))
    (call $emit_byte (i32.const 46)) (call $emit_byte (i32.const 115))
    (call $emit_byte (i32.const 101)) (call $emit_byte (i32.const 116))
    (call $emit_byte (i32.const 32)) (call $emit_byte (i32.const 36))
    (call $emit_byte (i32.const 97)) (call $emit_byte (i32.const 108))
    (call $emit_byte (i32.const 108)) (call $emit_byte (i32.const 111))
    (call $emit_byte (i32.const 99)) (call $emit_byte (i32.const 95))
    (call $emit_byte (i32.const 115)) (call $emit_byte (i32.const 105))
    (call $emit_byte (i32.const 122)) (call $emit_byte (i32.const 101))
    (call $emit_byte (i32.const 41)))

  (func $ec6_emit_local_get_alloc_size
    ;; emits: (local.get $alloc_size)
    (call $emit_byte (i32.const 40)) (call $emit_byte (i32.const 108))
    (call $emit_byte (i32.const 111)) (call $emit_byte (i32.const 99))
    (call $emit_byte (i32.const 97)) (call $emit_byte (i32.const 108))
    (call $emit_byte (i32.const 46)) (call $emit_byte (i32.const 103))
    (call $emit_byte (i32.const 101)) (call $emit_byte (i32.const 116))
    (call $emit_byte (i32.const 32)) (call $emit_byte (i32.const 36))
    (call $emit_byte (i32.const 97)) (call $emit_byte (i32.const 108))
    (call $emit_byte (i32.const 108)) (call $emit_byte (i32.const 111))
    (call $emit_byte (i32.const 99)) (call $emit_byte (i32.const 95))
    (call $emit_byte (i32.const 115)) (call $emit_byte (i32.const 105))
    (call $emit_byte (i32.const 122)) (call $emit_byte (i32.const 101))
    (call $emit_byte (i32.const 41)))

  (func $ec6_emit_i32_const_lit (param $n i32)
    ;; emits: (i32.const N)
    (call $emit_byte (i32.const 40)) (call $emit_byte (i32.const 105))
    (call $emit_byte (i32.const 51)) (call $emit_byte (i32.const 50))
    (call $emit_byte (i32.const 46)) (call $emit_byte (i32.const 99))
    (call $emit_byte (i32.const 111)) (call $emit_byte (i32.const 110))
    (call $emit_byte (i32.const 115)) (call $emit_byte (i32.const 116))
    (call $emit_byte (i32.const 32))
    (call $emit_int  (local.get $n))
    (call $emit_byte (i32.const 41)))

  (func $ec6_emit_i32_load_offset_4
    ;; emits: (i32.load offset=4)
    (call $emit_byte (i32.const 40)) (call $emit_byte (i32.const 105))
    (call $emit_byte (i32.const 51)) (call $emit_byte (i32.const 50))
    (call $emit_byte (i32.const 46)) (call $emit_byte (i32.const 108))
    (call $emit_byte (i32.const 111)) (call $emit_byte (i32.const 97))
    (call $emit_byte (i32.const 100)) (call $emit_byte (i32.const 32))
    (call $emit_byte (i32.const 111)) (call $emit_byte (i32.const 102))
    (call $emit_byte (i32.const 102)) (call $emit_byte (i32.const 115))
    (call $emit_byte (i32.const 101)) (call $emit_byte (i32.const 116))
    (call $emit_byte (i32.const 61)) (call $emit_byte (i32.const 52))
    (call $emit_byte (i32.const 41)))

  (func $ec6_emit_i32_store_offset_0
    ;; emits: (i32.store offset=0)
    (call $emit_byte (i32.const 40)) (call $emit_byte (i32.const 105))
    (call $emit_byte (i32.const 51)) (call $emit_byte (i32.const 50))
    (call $emit_byte (i32.const 46)) (call $emit_byte (i32.const 115))
    (call $emit_byte (i32.const 116)) (call $emit_byte (i32.const 111))
    (call $emit_byte (i32.const 114)) (call $emit_byte (i32.const 101))
    (call $emit_byte (i32.const 32)) (call $emit_byte (i32.const 111))
    (call $emit_byte (i32.const 102)) (call $emit_byte (i32.const 102))
    (call $emit_byte (i32.const 115)) (call $emit_byte (i32.const 101))
    (call $emit_byte (i32.const 116)) (call $emit_byte (i32.const 61))
    (call $emit_byte (i32.const 48)) (call $emit_byte (i32.const 41)))

  (func $ec6_emit_i32_store_offset_4
    ;; emits: (i32.store offset=4)
    (call $emit_byte (i32.const 40)) (call $emit_byte (i32.const 105))
    (call $emit_byte (i32.const 51)) (call $emit_byte (i32.const 50))
    (call $emit_byte (i32.const 46)) (call $emit_byte (i32.const 115))
    (call $emit_byte (i32.const 116)) (call $emit_byte (i32.const 111))
    (call $emit_byte (i32.const 114)) (call $emit_byte (i32.const 101))
    (call $emit_byte (i32.const 32)) (call $emit_byte (i32.const 111))
    (call $emit_byte (i32.const 102)) (call $emit_byte (i32.const 102))
    (call $emit_byte (i32.const 115)) (call $emit_byte (i32.const 101))
    (call $emit_byte (i32.const 116)) (call $emit_byte (i32.const 61))
    (call $emit_byte (i32.const 52)) (call $emit_byte (i32.const 41)))

  ;; ─── $ec6_emit_capture_copy_loop — runtime nc-driven copy loop ─────
  ;; Mirror of wheel src/backends/wasm.mn:1434-1454. Emits a (block) +
  ;; (loop) with (br_if) terminator that copies callee[8+4*i] →
  ;; state_tmp[8+4*i] for i in [0, nc). nc loaded dynamically from
  ;; $callee_closure offset 4.
  ;;
  ;; The emitted loop is one fixed shape per LSuspend site — does NOT
  ;; vary by callee. Inlining vs runtime trade-off: inlining grows
  ;; emit-time WAT linearly per LSuspend; runtime loop keeps emit-size
  ;; constant. Runtime loop chosen per wheel parity.
  (func $ec6_emit_capture_copy_loop (param $sname i32)
    ;; (i32.const 0) (local.set $loop_i)
    (call $ec6_emit_i32_const_lit (i32.const 0))
    (call $ec6_emit_local_set_loop_i)
    ;; (block $copy_done
    (call $ec6_emit_block_copy_done_open)
    ;; (loop $copy_loop
    (call $ec6_emit_loop_copy_loop_open)
    ;; (local.get $loop_i)
    (call $ec6_emit_local_get_loop_i)
    ;; (local.get $callee_closure) (i32.load offset=4)
    (call $ec6_emit_local_get_callee_closure)
    (call $ec6_emit_i32_load_offset_4)
    ;; (i32.ge_u) (br_if $copy_done)
    (call $ec6_emit_i32_ge_u)
    (call $ec6_emit_br_if_copy_done)
    ;; dst = <sname> + 8 + 4*loop_i
    (call $ec_emit_local_get_dollar (local.get $sname))
    (call $ec6_emit_local_get_loop_i)
    (call $ec6_emit_i32_const_lit (i32.const 4))
    (call $ec6_emit_i32_mul)
    (call $ec6_emit_i32_add)
    (call $ec6_emit_i32_const_lit (i32.const 8))
    (call $ec6_emit_i32_add)
    ;; src = callee_closure + 8 + 4*loop_i, loaded
    (call $ec6_emit_local_get_callee_closure)
    (call $ec6_emit_local_get_loop_i)
    (call $ec6_emit_i32_const_lit (i32.const 4))
    (call $ec6_emit_i32_mul)
    (call $ec6_emit_i32_add)
    (call $ec6_emit_i32_const_lit (i32.const 8))
    (call $ec6_emit_i32_add)
    (call $ec6_emit_i32_load)
    ;; (i32.store)
    (call $ec6_emit_i32_store)
    ;; loop_i++
    (call $ec6_emit_local_get_loop_i)
    (call $ec6_emit_i32_const_lit (i32.const 1))
    (call $ec6_emit_i32_add)
    (call $ec6_emit_local_set_loop_i)
    ;; (br $copy_loop)
    (call $ec6_emit_br_copy_loop)
    ;; close loop + block
    (call $emit_byte (i32.const 41))     ;; close loop
    (call $emit_byte (i32.const 41)))    ;; close block

  (func $ec6_emit_local_set_loop_i
    ;; emits: (local.set $loop_i)
    (call $emit_byte (i32.const 40)) (call $emit_byte (i32.const 108))
    (call $emit_byte (i32.const 111)) (call $emit_byte (i32.const 99))
    (call $emit_byte (i32.const 97)) (call $emit_byte (i32.const 108))
    (call $emit_byte (i32.const 46)) (call $emit_byte (i32.const 115))
    (call $emit_byte (i32.const 101)) (call $emit_byte (i32.const 116))
    (call $emit_byte (i32.const 32)) (call $emit_byte (i32.const 36))
    (call $emit_byte (i32.const 108)) (call $emit_byte (i32.const 111))
    (call $emit_byte (i32.const 111)) (call $emit_byte (i32.const 112))
    (call $emit_byte (i32.const 95)) (call $emit_byte (i32.const 105))
    (call $emit_byte (i32.const 41)))

  (func $ec6_emit_local_get_loop_i
    ;; emits: (local.get $loop_i)
    (call $emit_byte (i32.const 40)) (call $emit_byte (i32.const 108))
    (call $emit_byte (i32.const 111)) (call $emit_byte (i32.const 99))
    (call $emit_byte (i32.const 97)) (call $emit_byte (i32.const 108))
    (call $emit_byte (i32.const 46)) (call $emit_byte (i32.const 103))
    (call $emit_byte (i32.const 101)) (call $emit_byte (i32.const 116))
    (call $emit_byte (i32.const 32)) (call $emit_byte (i32.const 36))
    (call $emit_byte (i32.const 108)) (call $emit_byte (i32.const 111))
    (call $emit_byte (i32.const 111)) (call $emit_byte (i32.const 112))
    (call $emit_byte (i32.const 95)) (call $emit_byte (i32.const 105))
    (call $emit_byte (i32.const 41)))

  (func $ec6_emit_block_copy_done_open
    ;; emits: (block $copy_done
    (call $emit_byte (i32.const 40)) (call $emit_byte (i32.const 98))
    (call $emit_byte (i32.const 108)) (call $emit_byte (i32.const 111))
    (call $emit_byte (i32.const 99)) (call $emit_byte (i32.const 107))
    (call $emit_byte (i32.const 32)) (call $emit_byte (i32.const 36))
    (call $emit_byte (i32.const 99)) (call $emit_byte (i32.const 111))
    (call $emit_byte (i32.const 112)) (call $emit_byte (i32.const 121))
    (call $emit_byte (i32.const 95)) (call $emit_byte (i32.const 100))
    (call $emit_byte (i32.const 111)) (call $emit_byte (i32.const 110))
    (call $emit_byte (i32.const 101)))

  (func $ec6_emit_loop_copy_loop_open
    ;; emits: (loop $copy_loop
    (call $emit_byte (i32.const 40)) (call $emit_byte (i32.const 108))
    (call $emit_byte (i32.const 111)) (call $emit_byte (i32.const 111))
    (call $emit_byte (i32.const 112)) (call $emit_byte (i32.const 32))
    (call $emit_byte (i32.const 36)) (call $emit_byte (i32.const 99))
    (call $emit_byte (i32.const 111)) (call $emit_byte (i32.const 112))
    (call $emit_byte (i32.const 121)) (call $emit_byte (i32.const 95))
    (call $emit_byte (i32.const 108)) (call $emit_byte (i32.const 111))
    (call $emit_byte (i32.const 111)) (call $emit_byte (i32.const 112)))

  (func $ec6_emit_i32_ge_u
    ;; emits: (i32.ge_u)
    (call $emit_byte (i32.const 40)) (call $emit_byte (i32.const 105))
    (call $emit_byte (i32.const 51)) (call $emit_byte (i32.const 50))
    (call $emit_byte (i32.const 46)) (call $emit_byte (i32.const 103))
    (call $emit_byte (i32.const 101)) (call $emit_byte (i32.const 95))
    (call $emit_byte (i32.const 117)) (call $emit_byte (i32.const 41)))

  (func $ec6_emit_br_if_copy_done
    ;; emits: (br_if $copy_done)
    (call $emit_byte (i32.const 40)) (call $emit_byte (i32.const 98))
    (call $emit_byte (i32.const 114)) (call $emit_byte (i32.const 95))
    (call $emit_byte (i32.const 105)) (call $emit_byte (i32.const 102))
    (call $emit_byte (i32.const 32)) (call $emit_byte (i32.const 36))
    (call $emit_byte (i32.const 99)) (call $emit_byte (i32.const 111))
    (call $emit_byte (i32.const 112)) (call $emit_byte (i32.const 121))
    (call $emit_byte (i32.const 95)) (call $emit_byte (i32.const 100))
    (call $emit_byte (i32.const 111)) (call $emit_byte (i32.const 110))
    (call $emit_byte (i32.const 101)) (call $emit_byte (i32.const 41)))

  (func $ec6_emit_br_copy_loop
    ;; emits: (br $copy_loop)
    (call $emit_byte (i32.const 40)) (call $emit_byte (i32.const 98))
    (call $emit_byte (i32.const 114)) (call $emit_byte (i32.const 32))
    (call $emit_byte (i32.const 36)) (call $emit_byte (i32.const 99))
    (call $emit_byte (i32.const 111)) (call $emit_byte (i32.const 112))
    (call $emit_byte (i32.const 121)) (call $emit_byte (i32.const 95))
    (call $emit_byte (i32.const 108)) (call $emit_byte (i32.const 111))
    (call $emit_byte (i32.const 111)) (call $emit_byte (i32.const 112))
    (call $emit_byte (i32.const 41)))

  (func $ec6_emit_i32_load
    ;; emits: (i32.load)
    (call $emit_byte (i32.const 40)) (call $emit_byte (i32.const 105))
    (call $emit_byte (i32.const 51)) (call $emit_byte (i32.const 50))
    (call $emit_byte (i32.const 46)) (call $emit_byte (i32.const 108))
    (call $emit_byte (i32.const 111)) (call $emit_byte (i32.const 97))
    (call $emit_byte (i32.const 100)) (call $emit_byte (i32.const 41)))

  (func $ec6_emit_i32_store
    ;; emits: (i32.store)
    (call $emit_byte (i32.const 40)) (call $emit_byte (i32.const 105))
    (call $emit_byte (i32.const 51)) (call $emit_byte (i32.const 50))
    (call $emit_byte (i32.const 46)) (call $emit_byte (i32.const 115))
    (call $emit_byte (i32.const 116)) (call $emit_byte (i32.const 111))
    (call $emit_byte (i32.const 114)) (call $emit_byte (i32.const 101))
    (call $emit_byte (i32.const 41)))

  ;; ─── $ec6_emit_dynamic_ev_addr — runtime addr sname + 8 + 4*nc + extra ──
  ;; nc is runtime-known (callee_closure[4]); `extra` is the static byte offset
  ;; into the keyed ev region. Leaves the address on the stack for an (i32.store).
  ;; Mirror of wheel emit_dynamic_ev_addr.
  (func $ec6_emit_dynamic_ev_addr (param $sname i32) (param $extra i32)
    (call $ec_emit_local_get_dollar (local.get $sname))
    (call $ec6_emit_i32_const_lit (i32.const 8))
    (call $ec6_emit_i32_add)
    (call $ec6_emit_local_get_callee_closure)
    (call $ec6_emit_i32_load_offset_4)
    (call $ec6_emit_i32_const_lit (i32.const 4))
    (call $ec6_emit_i32_mul)
    (call $ec6_emit_i32_add)
    (call $ec6_emit_i32_const_lit (local.get $extra))
    (call $ec6_emit_i32_add))

  ;; ─── $ec6_emit_ev_slot_stores — keyed [key][ev] PAIRS + sentinel (runtime nc) ──
  ;; Mirror of wheel emit_ev_slots_dynamic. Per LEvEntry j: key (the interned
  ;; ename offset) @ sname+8+4*nc+8*j, ev @ +4; then a key=0 sentinel @ +8*n. nc
  ;; is runtime (callee_closure[4]). The callee's LEvPerform $ev_lookup key-scans
  ;; it identically — one entry shape; the fence agrees by construction. Entries
  ;; are LEvEntry (tag 341) by construction; a non-LEvEntry is a loud trap.
  (func $ec6_emit_ev_slot_stores (param $evs i32) (param $sname i32)
    (local $j i32) (local $n i32) (local $entry i32)
    (local.set $n (call $len (local.get $evs)))
    (local.set $j (i32.const 0))
    (block $done
      (loop $iter
        (br_if $done (i32.ge_u (local.get $j) (local.get $n)))
        (local.set $entry (call $list_index (local.get $evs) (local.get $j)))
        (if (i32.ne (call $tag_of (local.get $entry)) (i32.const 341))
          (then (call $ec_emit_unreachable))
          (else
            ;; key @ sname + 8 + 4*nc + 8*j
            (call $ec6_emit_dynamic_ev_addr (local.get $sname)
              (i32.mul (i32.const 8) (local.get $j)))
            (call $ec6_emit_i32_const_lit
              (call $emit_string_intern (call $lexpr_leventry_key (local.get $entry))))
            (call $ec6_emit_i32_store)
            ;; ev @ + 4
            (call $ec6_emit_dynamic_ev_addr (local.get $sname)
              (i32.add (i32.mul (i32.const 8) (local.get $j)) (i32.const 4)))
            (call $emit_lexpr (call $lexpr_leventry_ev (local.get $entry)))
            (call $ec6_emit_i32_store)))
        (local.set $j (i32.add (local.get $j) (i32.const 1)))
        (br $iter)))
    ;; SENTINEL key=0 @ sname + 8 + 4*nc + 8*n
    (call $ec6_emit_dynamic_ev_addr (local.get $sname)
      (i32.mul (i32.const 8) (local.get $n)))
    (call $ec6_emit_i32_const_lit (i32.const 0))
    (call $ec6_emit_i32_store))
