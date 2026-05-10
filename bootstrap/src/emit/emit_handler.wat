  ;; ═══ emit_handler.wat — Hβ.emit handler family (Tier 6, chunk #7) ═══
  ;; The chunk where `~>` and `<~` become physical at WAT.
  ;;
  ;; Per Hβ-emit-substrate.md §2.5: 7 arms land here — LLet (tag 304) +
  ;; LDeclareFn (tag 313) + LHandleWith (tag 329) + LFeedback (tag 330) +
  ;; LPerform (tag 331) + LHandle (tag 332) + LEvPerform (tag 333).
  ;;
  ;; The two LFn-bearing arms — LMakeClosure (tag 311) + LMakeContinuation
  ;; (tag 312) — require LowFn record substrate (tag 350 + 5 accessors)
  ;; that the seed has not yet materialized. Per Anchor 7 cascade
  ;; discipline, those arms land in named peer Hβ.emit.handler-fnref-
  ;; substrate which depends on Hβ.lower.lowfn-substrate (the LowFn
  ;; record substrate addition to bootstrap/src/lower/lexpr.wat plus
  ;; walk_compound + walk_stmt updates to construct LowFn properly).
  ;; Drift 9 closure via explicit naming, NOT silent absorption.
  ;;
  ;; Implements: Hβ-emit-substrate.md §2.5 (7 of 9 arms — handler family
  ;;             excluding LMakeClosure / LMakeContinuation per dependency
  ;;             on LowFn substrate) + §3 (H1.4 single-handler-per-op
  ;;             naming via $emit_op_symbol composition for LPerform) +
  ;;             §5.1 (eight interrogations) + §7.1 (chunk #7) + §11.3
  ;;             dep order (chunk #7 follows emit_call.wat).
  ;; Exports:    $emit_llet, $emit_ldeclarefn, $emit_lhandlewith,
  ;;             $emit_lhandle, $emit_lfeedback, $emit_lperform,
  ;;             $emit_levperform.
  ;; Uses:       lower/lexpr.wat accessors —
  ;;               $lexpr_llet_name + $lexpr_llet_value
  ;;               $lexpr_lhandlewith_body + $lexpr_lhandlewith_handler
  ;;               $lexpr_lhandle_body + $lexpr_lhandle_arms
  ;;               $lexpr_lfeedback_body + $lexpr_lfeedback_spec
  ;;               $lexpr_lperform_op_name + $lexpr_lperform_args
  ;;               $lexpr_levperform_op_name + $lexpr_levperform_slot_idx
  ;;               + $lexpr_levperform_args
  ;;               $lexpr_handle (universal — for LFeedback's site handle)
  ;;             emit/state.wat —
  ;;               $emit_body_captures_count (H1 evidence-slot offset
  ;;               base resolution at LEvPerform)
  ;;             emit_infra.wat —
  ;;               $emit_byte + $emit_int + $emit_str + $emit_i32_const
  ;;             emit_const.wat —
  ;;               $emit_lexpr (partial dispatcher; this chunk RETROFITS
  ;;               its arm table for tags 304/313/329/330/331/332/333
  ;;               per Hβ.emit.lexpr-dispatch-extension)
  ;;               $ec_emit_local_set_dollar (LLet's local.set $<name>)
  ;;             emit_local.wat —
  ;;               $el_emit_local_get_state (LEvPerform's __state load)
  ;;               $el_emit_i32_load_offset (LEvPerform's evidence-slot
  ;;               offset load)
  ;;             emit_call.wat —
  ;;               $ec6_emit_args (sequential arg emission)
  ;;               $ec6_emit_call_indirect_ftN (LEvPerform's polymorphic
  ;;               dispatch through the callee's evidence-slot fn-ptr)
  ;;
  ;; What this chunk IS (per Hβ-emit-substrate.md §2.5):
  ;;
  ;;   1. $emit_llet(r) — LLet tag 304 (handle, name, value).
  ;;      Per src/backends/wasm.mn:1147-1152: emit val + (local.set
  ;;      $<name>). Lock #6 of Hβ.lower walk_call: ResumeExpr lowers to
  ;;      LReturn (not LLet); LLet is parser-LetStmt's lowering form.
  ;;
  ;;   2. $emit_ldeclarefn(r) — LDeclareFn tag 313 (lowfn).
  ;;      Per src/backends/wasm.mn:1601-1608 + H1.4: at expression
  ;;      position this arm emits "(i32.const 0) ;; LDeclareFn marker".
  ;;      The actual `(func $op_<name> ...)` body emission happens at
  ;;      module-emit time via emit_fns_expr deep walk (chunk #9
  ;;      main.wat orchestrator). LDeclareFn at expression position is
  ;;      a no-op marker that the LBlock placeholder Lock makes valid.
  ;;
  ;;   3. $emit_lhandlewith(r) — LHandleWith tag 329 (handle, body, handler).
  ;;      Per src/backends/wasm.mn:1486-1489: emit body + comment
  ;;      "~> handler attached (tail-resumptive inlined)". The handler-
  ;;      attach is INERT at the seed because tail-resumptive (the ~85%
  ;;      case per SUBSTRATE.md §III "Three Tiers") inlines the handler
  ;;      arm body at the perform site through evidence passing — no
  ;;      runtime handler-stack push.
  ;;
  ;;   4. $emit_lhandle(r) — LHandle tag 332 (handle, body, arms).
  ;;      Per src/backends/wasm.mn:1549-1552: emit body + comment.
  ;;      Same inert-substrate as LHandleWith; arms are emitted
  ;;      separately at module-emit time as `(func $op_<name> ...)`.
  ;;
  ;;   5. $emit_lfeedback(r) — LFeedback tag 330 (handle, body, spec).
  ;;      Per src/backends/wasm.mn:1491-1534 + LF walkthrough §1.5
  ;;      state-machine lowering. THE `<~` SUBSTRATE made physical:
  ;;      load-prior → emit body → tee-current → store-current →
  ;;      reload-current. The handle `h` (from $lexpr_handle) names
  ;;      the per-site state global $s<h> + the per-site locals
  ;;      $__fb_prev_<h> + $__fb_<h>.
  ;;
  ;;      Per SUBSTRATE.md §II "Feedback IS Mentl's Genuine Novelty":
  ;;      `<~` is sugar for a stateful handler capturing output and
  ;;      re-injecting it. State-global substrate reuses LStateGet/
  ;;      LStateSet's `$s<slot>` convention; module-init declares each
  ;;      $s<n> as `(global $s<n> (mut i32) (i32.const 0))`.
  ;;
  ;;   6. $emit_lperform(r) — LPerform tag 331 (handle, op_name, args).
  ;;      Per src/backends/wasm.mn:1536-1547: emit args + (call $op_
  ;;      <op_name>) per H1.4 single-handler-per-op naming. The
  ;;      monomorphic direct-call form — row inference's >95% claim
  ;;      cashes out HERE (per SUBSTRATE.md §I third truth "OneShot.
  ;;      Direct return_call $op_<name>").
  ;;
  ;;   7. $emit_levperform(r) — LEvPerform tag 333 (handle, op_name,
  ;;      slot_idx, args). Per src/backends/wasm.mn:1554-1587 + H1
  ;;      evidence reification: load fn_idx from __state at offset
  ;;      8 + 4*body_capture_count + 4*slot_idx, push __state + args,
  ;;      call_indirect via $ft<argc+1>. The polymorphic call site
  ;;      where evidence passing makes the handler dispatch a single
  ;;      i32 read from the closure record's evidence-slot field.
  ;;      DRIFT 1 REFUSAL — fn_idx is a FIELD on the closure record,
  ;;      NOT a vtable lookup.
  ;;
  ;; Eight interrogations (per Hβ-emit-substrate.md §5.1 second pass):
  ;;
  ;;   1. Graph?       Each arm reads its LowExpr's record fields via
  ;;                   $lexpr_l*_* accessors. LFeedback reads the source
  ;;                   handle via $lexpr_handle (universal) for state-
  ;;                   global naming. LEvPerform reads $emit_body_
  ;;                   captures_count from emit-time graph-equivalent
  ;;                   state. Per Anchor 1: ask the graph; never re-
  ;;                   derive shape.
  ;;   2. Handler?     At wheel: each arm is one branch of emit_expr
  ;;                   match. At seed: direct fn dispatch via $emit_
  ;;                   lexpr's tag table. @resume=OneShot at the wheel.
  ;;                   LEvPerform's runtime call_indirect IS the
  ;;                   handler dispatch substrate per SUBSTRATE.md §I.
  ;;   3. Verb?        LFeedback IS the `<~` verb made physical —
  ;;                   SUBSTRATE.md §II "Feedback IS Mentl's Genuine
  ;;                   Novelty". LHandleWith / LHandle ARE the `~>`
  ;;                   verb made physical (inert seed; tail-resumptive
  ;;                   inline). LPerform / LEvPerform are NOT verbs —
  ;;                   they're effect operations (kernel primitive #2).
  ;;   4. Row?         WasmOut at wheel; row-silent at seed. LEvPerform
  ;;                   is the polymorphic-row dispatch site.
  ;;   5. Ownership?   LowExpr `r` is `ref` (read-only structural
  ;;                   traversal). $out_base buffer OWNed program-wide.
  ;;   6. Refinement?  N/A for these arms.
  ;;   7. Gradient?    LEvPerform IS the H1 evidence reification
  ;;                   gradient cash-out — when row inference fails to
  ;;                   ground a handler chain at compile time, the call
  ;;                   site routes through this arm; otherwise LPerform
  ;;                   (direct $op_<name> call) is emitted by lower.
  ;;                   The annotation that unlocks the LPerform path is
  ;;                   row purification (any `with E1 + E2` declaration
  ;;                   that grounds the handler stack).
  ;;   8. Reason?      Read-only — caller's $lookup_ty preserves Reason
  ;;                   chain.
  ;;
  ;; Forbidden patterns audited (per Hβ-emit-substrate.md §6 + project
  ;; drift modes):
  ;;
  ;;   - Drift 1 (Rust vtable):     LEvPerform IS THE LOAD-BEARING ARM.
  ;;                                fn_idx is a FIELD on __state at
  ;;                                offset (8 + 4*nc + 4*slot); call_
  ;;                                indirect reads that field via the
  ;;                                $ft<N+1> type. NO $op_table; NO
  ;;                                vtable; word "vtable" appears
  ;;                                nowhere.
  ;;   - Drift 5 (C calling conv):  LEvPerform's __state IS the unified
  ;;                                closure record (no separate
  ;;                                __closure / __ev split).
  ;;   - Drift 8 (string-keyed):    LPerform's op_name is emitted AS
  ;;                                a string identifier "op_<name>" —
  ;;                                that's the WAT identifier itself
  ;;                                (the H1.4 single-handler-per-op
  ;;                                naming convention — appropriate use,
  ;;                                NOT flag-as-string drift). The
  ;;                                dispatch is via WAT's $-name
  ;;                                resolution, not runtime $str_eq.
  ;;   - Drift 9 (deferred-by-      LMakeClosure (tag 311) +
  ;;                  omission):    LMakeContinuation (tag 312) require
  ;;                                LowFn record substrate which the
  ;;                                seed has not yet materialized. Drift
  ;;                                9 closure via NAMED peer follow-up
  ;;                                Hβ.emit.handler-fnref-substrate that
  ;;                                lands AFTER Hβ.lower.lowfn-substrate
  ;;                                materializes the LowFn record (tag
  ;;                                350 + 5 accessors per src/lower.mn
  ;;                                LFn ADT). The 7 arms in this chunk
  ;;                                are FULLY bodied; no stubs.
  ;;   - Foreign fluency:           Vocabulary stays Mentl — "perform",
  ;;                                "handle", "feedback", "evidence
  ;;                                slot", "tail-resumptive". NEVER
  ;;                                "callback" / "method-table" /
  ;;                                "exception-handler".
  ;;
  ;; Named follow-ups (per Drift 9 + Hβ-emit-substrate.md §10):
  ;;   - Hβ.emit.lexpr-dispatch-extension: chunk #7 retrofits $emit_lexpr
  ;;                                       (this chunk).
  ;;   - Hβ.lower.lowfn-substrate:         add LowFn record (tag 350) +
  ;;                                       5 accessors to lower/lexpr.wat;
  ;;                                       update walk_compound + walk_stmt
  ;;                                       to construct LowFn properly per
  ;;                                       src/lower.mn LFn ADT.
  ;;   - Hβ.emit.handler-fnref-substrate:  $emit_lmakeclosure (tag 311) +
  ;;                                       $emit_lmakecontinuation (tag
  ;;                                       312) emit arms; depends on
  ;;                                       Hβ.lower.lowfn-substrate
  ;;                                       landing first.

  ;; ─── Chunk-private byte-emission helpers ──────────────────────────

  (func $ec7_emit_call_op_dollar (param $op_name i32)
    ;; emits: (call $op_<op_name>)
    ;; Per H1.4 single-handler-per-op naming — the WAT identifier
    ;; "$op_<name>" IS the symbol the LPerform's effect op resolves to.
    (call $emit_byte (i32.const 40)) (call $emit_byte (i32.const 99))
    (call $emit_byte (i32.const 97)) (call $emit_byte (i32.const 108))
    (call $emit_byte (i32.const 108)) (call $emit_byte (i32.const 32))
    (call $emit_byte (i32.const 36)) (call $emit_byte (i32.const 111))
    (call $emit_byte (i32.const 112)) (call $emit_byte (i32.const 95))
    (call $emit_str (local.get $op_name))
    (call $emit_byte (i32.const 41)))

  (func $ec7_emit_global_get_s_h (param $h i32)
    ;; emits: (global.get $s<h>)
    (call $emit_byte (i32.const 40)) (call $emit_byte (i32.const 103))
    (call $emit_byte (i32.const 108)) (call $emit_byte (i32.const 111))
    (call $emit_byte (i32.const 98)) (call $emit_byte (i32.const 97))
    (call $emit_byte (i32.const 108)) (call $emit_byte (i32.const 46))
    (call $emit_byte (i32.const 103)) (call $emit_byte (i32.const 101))
    (call $emit_byte (i32.const 116)) (call $emit_byte (i32.const 32))
    (call $emit_byte (i32.const 36)) (call $emit_byte (i32.const 115))
    (call $emit_int  (local.get $h))
    (call $emit_byte (i32.const 41)))

  (func $ec7_emit_global_set_s_h (param $h i32)
    ;; emits: (global.set $s<h>)
    (call $emit_byte (i32.const 40)) (call $emit_byte (i32.const 103))
    (call $emit_byte (i32.const 108)) (call $emit_byte (i32.const 111))
    (call $emit_byte (i32.const 98)) (call $emit_byte (i32.const 97))
    (call $emit_byte (i32.const 108)) (call $emit_byte (i32.const 46))
    (call $emit_byte (i32.const 115)) (call $emit_byte (i32.const 101))
    (call $emit_byte (i32.const 116)) (call $emit_byte (i32.const 32))
    (call $emit_byte (i32.const 36)) (call $emit_byte (i32.const 115))
    (call $emit_int  (local.get $h))
    (call $emit_byte (i32.const 41)))

  (func $ec7_emit_local_set_fb_prev_h (param $h i32)
    ;; emits: (local.set $__fb_prev_<h>)
    (call $emit_byte (i32.const 40)) (call $emit_byte (i32.const 108))
    (call $emit_byte (i32.const 111)) (call $emit_byte (i32.const 99))
    (call $emit_byte (i32.const 97)) (call $emit_byte (i32.const 108))
    (call $emit_byte (i32.const 46)) (call $emit_byte (i32.const 115))
    (call $emit_byte (i32.const 101)) (call $emit_byte (i32.const 116))
    (call $emit_byte (i32.const 32)) (call $emit_byte (i32.const 36))
    (call $emit_byte (i32.const 95)) (call $emit_byte (i32.const 95))
    (call $emit_byte (i32.const 102)) (call $emit_byte (i32.const 98))
    (call $emit_byte (i32.const 95)) (call $emit_byte (i32.const 112))
    (call $emit_byte (i32.const 114)) (call $emit_byte (i32.const 101))
    (call $emit_byte (i32.const 118)) (call $emit_byte (i32.const 95))
    (call $emit_int  (local.get $h))
    (call $emit_byte (i32.const 41)))

  (func $ec7_emit_local_tee_fb_h (param $h i32)
    ;; emits: (local.tee $__fb_<h>)
    (call $emit_byte (i32.const 40)) (call $emit_byte (i32.const 108))
    (call $emit_byte (i32.const 111)) (call $emit_byte (i32.const 99))
    (call $emit_byte (i32.const 97)) (call $emit_byte (i32.const 108))
    (call $emit_byte (i32.const 46)) (call $emit_byte (i32.const 116))
    (call $emit_byte (i32.const 101)) (call $emit_byte (i32.const 101))
    (call $emit_byte (i32.const 32)) (call $emit_byte (i32.const 36))
    (call $emit_byte (i32.const 95)) (call $emit_byte (i32.const 95))
    (call $emit_byte (i32.const 102)) (call $emit_byte (i32.const 98))
    (call $emit_byte (i32.const 95))
    (call $emit_int  (local.get $h))
    (call $emit_byte (i32.const 41)))

  (func $ec7_emit_local_get_fb_h (param $h i32)
    ;; emits: (local.get $__fb_<h>)
    (call $emit_byte (i32.const 40)) (call $emit_byte (i32.const 108))
    (call $emit_byte (i32.const 111)) (call $emit_byte (i32.const 99))
    (call $emit_byte (i32.const 97)) (call $emit_byte (i32.const 108))
    (call $emit_byte (i32.const 46)) (call $emit_byte (i32.const 103))
    (call $emit_byte (i32.const 101)) (call $emit_byte (i32.const 116))
    (call $emit_byte (i32.const 32)) (call $emit_byte (i32.const 36))
    (call $emit_byte (i32.const 95)) (call $emit_byte (i32.const 95))
    (call $emit_byte (i32.const 102)) (call $emit_byte (i32.const 98))
    (call $emit_byte (i32.const 95))
    (call $emit_int  (local.get $h))
    (call $emit_byte (i32.const 41)))

  ;; ─── ec8: helpers for LMakeClosure / LMakeContinuation ─────────────
  ;; These helpers materialize because Phase D lands here — the two
  ;; LFn-bearing arms (tags 311-312) now have a truthful LowFn substrate
  ;; to read from (Hβ.lower.lowfn-substrate, Phase C). Drift-1-safe:
  ;; fn_ptr is an i32 field in the closure record at offset 0, emitted
  ;; as (global.get $<name>_idx). NO vtable; NO op_table.

  (func $ec8_emit_global_get_name_idx (param $name i32)
    ;; emits: (global.get $<name>_idx)
    ;; The i32 table-index slot for the closure's target fn.
    (call $emit_byte (i32.const 40)) (call $emit_byte (i32.const 103))
    (call $emit_byte (i32.const 108)) (call $emit_byte (i32.const 111))
    (call $emit_byte (i32.const 98))  (call $emit_byte (i32.const 97))
    (call $emit_byte (i32.const 108)) (call $emit_byte (i32.const 46))
    (call $emit_byte (i32.const 103)) (call $emit_byte (i32.const 101))
    (call $emit_byte (i32.const 116)) (call $emit_byte (i32.const 32))
    (call $emit_byte (i32.const 36))
    (call $emit_str (local.get $name))
    (call $emit_byte (i32.const 95))  (call $emit_byte (i32.const 105))
    (call $emit_byte (i32.const 100)) (call $emit_byte (i32.const 120))
    (call $emit_byte (i32.const 41)))

  (func $ec8_emit_local_get_state_tmp
    ;; emits: (local.get $state_tmp)
    ;; Reuses emit_call.wat's data segment at 2244 (length-prefix "state_tmp").
    (call $ec_emit_local_get_dollar (i32.const 2244)))

  (func $ec8_emit_cap_stores (param $caps i32) (param $base_off i32)
    ;; Emit one (local.get $state_tmp) + <elem> + (i32.store offset=N)
    ;; triple per element, at consecutive offsets from base_off.
    ;; Each elem is a LowExpr — emitted via $emit_lexpr.
    (local $n i32) (local $i i32)
    (local.set $n (call $len (local.get $caps)))
    (local.set $i (i32.const 0))
    (block $done (loop $loop
      (br_if $done (i32.ge_u (local.get $i) (local.get $n)))
      (call $ec8_emit_local_get_state_tmp)
      (call $emit_lexpr (call $list_index (local.get $caps) (local.get $i)))
      (call $ec_emit_i32_store_offset
        (i32.add (local.get $base_off)
                 (i32.mul (local.get $i) (i32.const 4))))
      (local.set $i (i32.add (local.get $i) (i32.const 1)))
      (br $loop))))

  ;; ─── $emit_llet — LLet tag 304 emit arm per §2.5 ───────────────────
  ;; Per src/backends/wasm.mn:1147-1152: sub-emit value + "(local.set
  ;; $<name>)". Lock #6 separation: ResumeExpr→LReturn (not LLet);
  ;; parser-LetStmt→LLet.
  (func $emit_llet (param $r i32)
    (call $emit_lexpr (call $lexpr_llet_value (local.get $r)))
    (call $ec_emit_local_set_dollar (call $lexpr_llet_name (local.get $r))))

  ;; ─── $emit_ldeclarefn — LDeclareFn tag 313 emit arm per §2.5 ───────
  ;; Per src/backends/wasm.mn:1601-1608 + H1.4: at expression-position
  ;; this arm is a TRUE NO-OP. The actual `(func $op_<name> ...)` body
  ;; emission happens at module-emit time via emit_fns_expr deep walk
  ;; (chunk #9 main.wat). LDeclareFn lands inside LBlock per Hβ.lower
  ;; walk_stmt's HandlerDeclStmt arm.
  ;;
  ;; Per Hβ.emit.ldeclarefn-true-noop (2026-05-09): the prior placeholder
  ;; emitted (i32.const 0) — but $lexpr_consumes_no_stack returns 1 for
  ;; tag 313, telling $ec5_emit_body NOT to drop residue. Net: 1 i32
  ;; leaked onto stack per LDeclareFn in LBlock. Surfaced after the
  ;; record-field-variant cascade closure (commit 49f0165) when LDeclareFn
  ;; entries no longer hid behind UNRESOLVED → unreachable polymorphism.
  ;; The placeholder convention is from a pre-drop-residue era; modern
  ;; $ec5_emit_body correctly skips drop ONLY for tags that produce no
  ;; residue. LDeclareFn IS no-residue at expression position; emit
  ;; nothing.
  (func $emit_ldeclarefn (param $r i32))

  ;; ─── $emit_lhandlewith — LHandleWith tag 329 emit arm per §2.5 ─────
  ;; Per src/backends/wasm.mn:1486-1489: sub-emit body. The handler-
  ;; attach is INERT at the seed because tail-resumptive (~85% per
  ;; SUBSTRATE.md §III) inlines the handler arm body at the perform
  ;; site through evidence passing — no runtime handler-stack push.
  ;; The handler list is emitted separately at module-emit time as
  ;; `(func $op_<name> ...)` declarations.
  (func $emit_lhandlewith (param $r i32)
    (local $h i32) (local $hstate_name i32)
    ;; Per protocol_handler_is_state_is_closure_is_evidence.md: allocate
    ;; the handler's state record at install — ONE record carrying state
    ;; slots + ev_slots + (post-H7) continuation. Bind to local minted in
    ;; $lower_pipe (walk_handle.wat) as "__hstate_<handle>". Perform sites
    ;; within body thread this local as the arm-call's __state via LPerform's
    ;; state_local field (set by $lower_perform/lower_call's EffectOp arm
    ;; from $lower_resolve_handler_state_for_op). Size: 64 bytes (16 slots
    ;; — 1 tag + 1 capture_count + 14 state fields); kernel-uniform
    ;; placeholder per protocol_kernel_uniform_placeholder_substrate.md;
    ;; named follow-up Hβ.emit.handler-state-record-size-from-decl reads
    ;; the handler-decl's state-field count. Zero-init via $alloc (memory
    ;; cleared per WASM linear memory init); entries=[] sentinel-correct
    ;; for env_handler / lower_scope / etc.
    (local.set $h (call $lexpr_handle (local.get $r)))
    (local.set $hstate_name
      (call $str_concat (i32.const 5408) (call $int_to_str (local.get $h))))
    ;; Use the canonical $emit_alloc (5-piece bump pattern via the
    ;; EmitMemory swap surface — same path as LMakeRecord/LMakeVariant).
    (call $emit_alloc (i32.const 64) (local.get $hstate_name))
    ;; Per-handler GLOBAL state-ptr write (cross-fn projection of the
    ;; install-time state record). Read handler_name from LHandleWith's
    ;; new slot 3 (threaded by lower_pipe from extract_handler_name).
    ;; Skipped if handler_name == 0 (anonymous handle-expr).
    (call $emit_hstate_global_set (call $lexpr_lhandlewith_handler_name (local.get $r))
                                   (local.get $hstate_name))
    (call $emit_lexpr (call $lexpr_lhandlewith_body (local.get $r))))

  ;; Emit `(global.get $<handler_name>_state_g)`.
  (func $emit_handler_state_global_get (param $handler_name i32)
    (local $global_name i32)
    (local.set $global_name
      (call $str_concat (local.get $handler_name) (i32.const 5424)))
    (call $emit_byte (i32.const 40))
    (call $emit_byte (i32.const 103)) (call $emit_byte (i32.const 108))
    (call $emit_byte (i32.const 111)) (call $emit_byte (i32.const 98))
    (call $emit_byte (i32.const 97))  (call $emit_byte (i32.const 108))
    (call $emit_byte (i32.const 46))  (call $emit_byte (i32.const 103))
    (call $emit_byte (i32.const 101)) (call $emit_byte (i32.const 116))
    (call $emit_byte (i32.const 32))  (call $emit_byte (i32.const 36))
    (call $emit_str (local.get $global_name))
    (call $emit_byte (i32.const 41)))

  ;; Emit `(local.get $<hstate_local>)(global.set $<handler>_state_g)`.
  ;; Per protocol_handler_is_state_is_closure_is_evidence.md — the
  ;; global IS the cross-fn projection of the install-time state record;
  ;; perform sites resolved via env-scan read this global as __state for
  ;; the arm-call. For Tier 3 multishot the global becomes a stack-of-
  ;; records (post-L1 per Hβ.lower.handler-state-multi-instance).
  (func $emit_hstate_global_set (param $handler_name i32) (param $hstate_local i32)
    (local $global_name i32)
    (if (i32.eqz (local.get $handler_name)) (then (return)))
    (local.set $global_name
      (call $str_concat (local.get $handler_name) (i32.const 5424)))   ;; "_state_g"
    (call $ec_emit_local_get_dollar (local.get $hstate_local))
    ;; emits: (global.set $<global_name>)
    (call $emit_byte (i32.const 40))
    (call $emit_byte (i32.const 103)) (call $emit_byte (i32.const 108))
    (call $emit_byte (i32.const 111)) (call $emit_byte (i32.const 98))
    (call $emit_byte (i32.const 97))  (call $emit_byte (i32.const 108))
    (call $emit_byte (i32.const 46))  (call $emit_byte (i32.const 115))
    (call $emit_byte (i32.const 101)) (call $emit_byte (i32.const 116))
    (call $emit_byte (i32.const 32))  (call $emit_byte (i32.const 36))
    (call $emit_str (local.get $global_name))
    (call $emit_byte (i32.const 41)))

  ;; ─── $emit_lhandle — LHandle tag 332 emit arm per §2.5 ─────────────
  ;; Per src/backends/wasm.mn:1549-1552: sub-emit body. Same inert-
  ;; substrate as LHandleWith; arms are emitted separately at module-
  ;; emit time.
  (func $emit_lhandle (param $r i32)
    (call $emit_lexpr (call $lexpr_lhandle_body (local.get $r))))

  ;; ─── $emit_lfeedback — LFeedback tag 330 emit arm per §2.5 ─────────
  ;; Per src/backends/wasm.mn:1491-1534 + LF walkthrough §1.5 — THE
  ;; `<~` SUBSTRATE made physical at WAT. State-machine lowering:
  ;;
  ;;   (global.get $s<h>)              ;; load prior iteration's output
  ;;   (local.set $__fb_prev_<h>)      ;; bind to per-site local
  ;;   <body>                          ;; emit body (may reference $__fb_prev_<h>)
  ;;   (local.tee $__fb_<h>)           ;; current-iteration output
  ;;   (global.set $s<h>)              ;; store back to state global
  ;;   (local.get $__fb_<h>)           ;; reload as the construct's value
  ;;
  ;; The handle `h` (from $lexpr_handle) names the per-site state
  ;; global $s<h> + the per-site locals $__fb_prev_<h> + $__fb_<h>.
  ;; State globals declared at module init by emit_state_globals
  ;; (chunk #9 main.wat).
  ;;
  ;; Per SUBSTRATE.md §II "Feedback IS Mentl's Genuine Novelty":
  ;; `<~` is sugar for a stateful handler capturing output and re-
  ;; injecting it. Under `Sample(44100)` it's a sample delay (DSP);
  ;; under `Tick` it's logical-step iteration; under `Clock(wall_ms=10)`
  ;; it's a control-loop delay. One operator; topology-only semantics;
  ;; ambient handler decides interpretation.
  (func $emit_lfeedback (param $r i32)
    (local $h i32)
    (local.set $h (call $lexpr_handle (local.get $r)))
    (call $ec7_emit_global_get_s_h (local.get $h))
    (call $ec7_emit_local_set_fb_prev_h (local.get $h))
    (call $emit_lexpr (call $lexpr_lfeedback_body (local.get $r)))
    (call $ec7_emit_local_tee_fb_h (local.get $h))
    (call $ec7_emit_global_set_s_h (local.get $h))
    (call $ec7_emit_local_get_fb_h (local.get $h)))

  ;; ─── $emit_lperform — LPerform tag 331 emit arm per §2.5 ───────────
  ;; Per src/backends/wasm.mn:1568-1579 + H1.4 single-handler-per-op:
  ;;   (local.get $__state)              ;; __state IS first param of $op_<name>
  ;;   <args>                             ;; user-visible args follow
  ;;   (call $op_<op_name>)
  ;; The monomorphic direct-call form — row inference's >95% claim
  ;; cashes out HERE per SUBSTRATE.md §I third truth "OneShot. Direct
  ;; return_call $op_<name>". The polymorphic minority routes through
  ;; LEvPerform (chunk #6) which threads ev_slot evidence instead.
  ;;
  ;; Per `Hβ.first-light.emit-lperform-state-arg` — handler-arm fns
  ;; declared by $lower_handler_arms_as_decls take __state as their
  ;; first param ($lowfn_make signature: name/arity/param_names/body/row;
  ;; emit_functions_walk prepends __state as the universal first param
  ;; per emit_handler.wat:$emit_ldeclarefn convention). Caller must push
  ;; __state to match. Pre-substrate the seed emitted only args, so
  ;; wat2wasm rejected `(call $op_<name>)` with "expected [i32] but got
  ;; []" for any program with a perform site. Symmetric to LEvPerform's
  ;; first $el_emit_local_get_state per §I third-truth + Koka JFP 2022.
  (func $emit_lperform (param $r i32)
    (local $op_name i32) (local $state_local i32)
    (local.set $op_name (call $lexpr_lperform_op_name (local.get $r)))
    (local.set $state_local (call $lexpr_lperform_state_local (local.get $r)))
    ;; Per Hβ.emit.wasi-effect-op-direct-emit (2026-05-07): if target
    ;; starts with "wasi_", emit `(call $<name>)` direct — bypassing
    ;; the `op_` discriminator prefix used for handler-arm dispatch.
    ;; WASI ops are foreign-fn imports, not handler arms. Drift
    ;; refused: 1 (structural prefix-check); 8 (no mode flag).
    (if (call $starts_with_wasi (local.get $op_name))
      (then
        ;; Per Hβ.emit.wasi-path-open-i64-args: WASI path_open's
        ;; rights_base + rights_inheriting (positions 5,6) are i64 per
        ;; WASI snapshot_preview1; wheel-source passes i32 literals;
        ;; emit widens via (i64.extend_i32_u). Other WASI ops are
        ;; i32-uniform (verified per WASI spec scan; only path_open
        ;; carries i64 in the ops the wheel uses).
        (if (call $str_eq (local.get $op_name) (i32.const 5160))   ;; "wasi_path_open"
          (then
            (call $ec6_emit_args_path_open (call $lexpr_lperform_args (local.get $r)))
            (call $ec7_emit_call_dollar (local.get $op_name))
            (return)))
        (call $ec6_emit_args (call $lexpr_lperform_args (local.get $r)))
        (call $ec7_emit_call_dollar (local.get $op_name))
        (return)))
    ;; Per Hβ.emit.memory-effect-op-direct-emit (2026-05-07): if
    ;; target starts with "memory_", emit RAW WASM instruction —
    ;; (i32.load offset=0) / (i32.store offset=0) / (i32.load8_u
    ;; offset=0) / (i32.store8 offset=0). The graph encodes
    ;; "this is a Memory op"; emit projects to native WASM, not
    ;; an indirect call.
    (if (call $starts_with_memory (local.get $op_name))
      (then
        (call $ec6_emit_args (call $lexpr_lperform_args (local.get $r)))
        (call $emit_memory_op_wasm (local.get $op_name))
        (return)))
    ;; Per protocol_handler_is_state_is_closure_is_evidence.md: state_local
    ;; carries the handler-NAME str_ptr; emit produces `(global.get
    ;; $<handler>_state_g)` for the arm-call's __state — the cross-fn
    ;; projection of the install-time state record. state_local == 0
    ;; means no handler resolved (env-scan fallthrough); fall back to
    ;; caller's __state for productive-under-error.
    (if (i32.ne (local.get $state_local) (i32.const 0))
      (then
        (call $emit_handler_state_global_get (local.get $state_local)))
      (else
        (call $el_emit_local_get_state)))
    (call $ec6_emit_args (call $lexpr_lperform_args (local.get $r)))
    (call $ec7_emit_call_op_dollar (local.get $op_name)))

  ;; ─── WASI path_open i64-args data + helper ──────────────────────
  ;; Per WASI snapshot_preview1: path_open's rights_base (arg 5) and
  ;; rights_inheriting (arg 6) are i64. Wheel-source passes Mentl-Int
  ;; literals (i32 in the seed's uniform-i32 representation). Emit
  ;; widens via (i64.extend_i32_u) at those two positions.
  ;;
  ;; Comparison string "wasi_path_open" (length 14) at offset 5160.
  ;; [5160, 5178) — past walk_expr.wat's 5128 (28 bytes ending at 5160).
  (data (i32.const 5160) "\0e\00\00\00wasi_path_open")

  ;; $emit_i64_extend_i32_u — emit "(i64.extend_i32_u)" (18 bytes).
  ;; Drift 1 refused: direct byte-emit (no vtable / op-table). Drift 6
  ;; refused: i64-extension is the precise WASM op for i32→i64 widen,
  ;; not a generic "convert"-flag dispatch.
  (func $emit_i64_extend_i32_u
    ;; '(' 'i' '6' '4' '.' 'e' 'x' 't' 'e' 'n' 'd' '_' 'i' '3' '2' '_' 'u' ')'
    (call $emit_byte (i32.const 40))  (call $emit_byte (i32.const 105))
    (call $emit_byte (i32.const 54))  (call $emit_byte (i32.const 52))
    (call $emit_byte (i32.const 46))  (call $emit_byte (i32.const 101))
    (call $emit_byte (i32.const 120)) (call $emit_byte (i32.const 116))
    (call $emit_byte (i32.const 101)) (call $emit_byte (i32.const 110))
    (call $emit_byte (i32.const 100)) (call $emit_byte (i32.const 95))
    (call $emit_byte (i32.const 105)) (call $emit_byte (i32.const 51))
    (call $emit_byte (i32.const 50))  (call $emit_byte (i32.const 95))
    (call $emit_byte (i32.const 117)) (call $emit_byte (i32.const 41)))

  ;; $ec6_emit_args_path_open — args emitter with i64 widening at
  ;; positions 5,6. Mirrors $ec6_emit_args's loop shape (Anchor 4
  ;; wheel parity); only delta is the position-conditional extend.
  (func $ec6_emit_args_path_open (param $args i32)
    (local $i i32) (local $n i32)
    (local.set $n (call $len (local.get $args)))
    (local.set $i (i32.const 0))
    (block $done
      (loop $iter
        (br_if $done (i32.ge_u (local.get $i) (local.get $n)))
        (call $emit_lexpr
          (call $list_index (local.get $args) (local.get $i)))
        (if (i32.or (i32.eq (local.get $i) (i32.const 5))
                    (i32.eq (local.get $i) (i32.const 6)))
          (then (call $emit_i64_extend_i32_u)))
        (local.set $i (i32.add (local.get $i) (i32.const 1)))
        (br $iter))))

  ;; $starts_with_memory — checks `memory_` prefix (7 bytes).
  (func $starts_with_memory (param $s i32) (result i32)
    (local $slen i32)
    (local.set $slen (call $str_len (local.get $s)))
    (if (i32.lt_u (local.get $slen) (i32.const 7))
      (then (return (i32.const 0))))
    (if (i32.ne (call $byte_at (local.get $s) (i32.const 0)) (i32.const 109))   ;; 'm'
      (then (return (i32.const 0))))
    (if (i32.ne (call $byte_at (local.get $s) (i32.const 1)) (i32.const 101))   ;; 'e'
      (then (return (i32.const 0))))
    (if (i32.ne (call $byte_at (local.get $s) (i32.const 2)) (i32.const 109))   ;; 'm'
      (then (return (i32.const 0))))
    (if (i32.ne (call $byte_at (local.get $s) (i32.const 3)) (i32.const 111))   ;; 'o'
      (then (return (i32.const 0))))
    (if (i32.ne (call $byte_at (local.get $s) (i32.const 4)) (i32.const 114))   ;; 'r'
      (then (return (i32.const 0))))
    (if (i32.ne (call $byte_at (local.get $s) (i32.const 5)) (i32.const 121))   ;; 'y'
      (then (return (i32.const 0))))
    (if (i32.ne (call $byte_at (local.get $s) (i32.const 6)) (i32.const 95))    ;; '_'
      (then (return (i32.const 0))))
    (i32.const 1))

  ;; $emit_memory_op_wasm — given op_name "memory_<op>", emit the
  ;; corresponding raw WASM instruction. Args already on stack from
  ;; $ec6_emit_args. Drift refused: 1 (no vtable; sequential byte-
  ;; comparison); 6 (uniform struct-size dispatch on op suffix).
  (func $emit_memory_op_wasm (param $op_name i32)
    (local $slen i32) (local $b7 i32) (local $b8 i32)
    (local.set $slen (call $str_len (local.get $op_name)))
    ;; "memory_" is 7 bytes; suffix starts at byte 7.
    ;; load_i32 → 15 total ; load_i8 → 14 ; store_i32 → 16 ; store_i8 → 15
    ;; alloc → 12 (memory_alloc) ; mem_copy → 15 (memory_mem_copy)
    ;; Discriminate via byte 7 + total length.
    (local.set $b7 (call $byte_at (local.get $op_name) (i32.const 7)))
    (if (i32.eq (local.get $b7) (i32.const 108))   ;; 'l' — load_*
      (then
        (if (i32.eq (local.get $slen) (i32.const 15))   ;; memory_load_i32
          (then
            (call $emit_str_lit_i32_load_offset_0)
            (return)))
        (if (i32.eq (local.get $slen) (i32.const 14))   ;; memory_load_i8
          (then
            (call $emit_str_lit_i32_load8_u_offset_0)
            (return)))))
    (if (i32.eq (local.get $b7) (i32.const 115))   ;; 's' — store_*
      (then
        (if (i32.eq (local.get $slen) (i32.const 16))   ;; memory_store_i32
          (then
            (call $emit_str_lit_i32_store_offset_0)
            (return)))
        (if (i32.eq (local.get $slen) (i32.const 15))   ;; memory_store_i8 (slen=15) OR memory_mem_copy (slen=15)
          (then
            (call $emit_str_lit_i32_store8_offset_0)
            (return)))))
    ;; alloc / mem_copy via byte 7 = 'a' / 'm'.
    (if (i32.eq (local.get $b7) (i32.const 97))    ;; 'a' — alloc
      (then
        (call $emit_alloc_wasm_inline)
        (return)))
    (if (i32.eq (local.get $b7) (i32.const 109))   ;; 'm' — mem_copy
      (then
        (call $emit_str_lit_memory_copy)
        (return))))

  ;; alloc inline — args: [size] on stack. Emits:
  ;;   (local.tee $alloc_size_temp)        ;; save size for store
  ;;   (drop)
  ;;   (global.get $heap_ptr)              ;; old ptr (return value)
  ;;   (global.get $heap_ptr)
  ;;   (local.get $alloc_size_temp)
  ;;   (i32.add)
  ;;   (global.set $heap_ptr)
  ;; Result: old ptr on stack, heap_ptr advanced by size.
  ;;
  ;; Uses $alloc_size local (declared in $emit_standard_locals). Stack
  ;; in: [size]. Stack out: [old_heap_ptr].
  (func $emit_alloc_wasm_inline
    ;; (local.set $alloc_size)
    (call $emit_byte (i32.const 40)) (call $emit_byte (i32.const 108))   ;; '(' 'l'
    (call $emit_byte (i32.const 111)) (call $emit_byte (i32.const 99))   ;; 'o' 'c'
    (call $emit_byte (i32.const 97)) (call $emit_byte (i32.const 108))   ;; 'a' 'l'
    (call $emit_byte (i32.const 46)) (call $emit_byte (i32.const 115))   ;; '.' 's'
    (call $emit_byte (i32.const 101)) (call $emit_byte (i32.const 116))  ;; 'e' 't'
    (call $emit_byte (i32.const 32))                                     ;; ' '
    (call $emit_byte (i32.const 36))                                     ;; '$'
    (call $emit_cstr (i32.const 1860) (i32.const 10))                   ;; "alloc_size" payload (past 4-byte length prefix at 1856)
    (call $emit_byte (i32.const 41))                                     ;; ')'
    ;; (global.get $heap_ptr) — return value (old ptr)
    (call $ec_emit_global_get_heap_ptr)
    ;; (global.get $heap_ptr)
    (call $ec_emit_global_get_heap_ptr)
    ;; (local.get $alloc_size)
    (call $emit_byte (i32.const 40)) (call $emit_byte (i32.const 108))
    (call $emit_byte (i32.const 111)) (call $emit_byte (i32.const 99))
    (call $emit_byte (i32.const 97)) (call $emit_byte (i32.const 108))
    (call $emit_byte (i32.const 46)) (call $emit_byte (i32.const 103))   ;; '.' 'g'
    (call $emit_byte (i32.const 101)) (call $emit_byte (i32.const 116))  ;; 'e' 't'
    (call $emit_byte (i32.const 32))
    (call $emit_byte (i32.const 36))
    (call $emit_cstr (i32.const 1860) (i32.const 10))   ;; past length prefix
    (call $emit_byte (i32.const 41))
    ;; (i32.add)(global.set $heap_ptr)
    (call $ec_emit_i32_add)
    (call $ec_emit_global_set_heap_ptr))

  (func $emit_str_lit_memory_copy
    (call $emit_byte (i32.const 40))                                     ;; '('
    (call $emit_byte (i32.const 109)) (call $emit_byte (i32.const 101))  ;; 'm' 'e'
    (call $emit_byte (i32.const 109)) (call $emit_byte (i32.const 111))  ;; 'm' 'o'
    (call $emit_byte (i32.const 114)) (call $emit_byte (i32.const 121))  ;; 'r' 'y'
    (call $emit_byte (i32.const 46)) (call $emit_byte (i32.const 99))    ;; '.' 'c'
    (call $emit_byte (i32.const 111)) (call $emit_byte (i32.const 112))  ;; 'o' 'p'
    (call $emit_byte (i32.const 121))                                    ;; 'y'
    (call $emit_byte (i32.const 41))
    ;; mem_copy returns () — push unit-sentinel for downstream local.set.
    (call $emit_i32_const (i32.const 0)))

  ;; Raw WAT instruction emitters — each emits one canonical instr.
  (func $emit_str_lit_i32_load_offset_0
    (call $emit_byte (i32.const 40))                    ;; '('
    (call $emit_byte (i32.const 105)) (call $emit_byte (i32.const 51))    ;; 'i' '3'
    (call $emit_byte (i32.const 50)) (call $emit_byte (i32.const 46))    ;; '2' '.'
    (call $emit_byte (i32.const 108)) (call $emit_byte (i32.const 111))   ;; 'l' 'o'
    (call $emit_byte (i32.const 97)) (call $emit_byte (i32.const 100))    ;; 'a' 'd'
    (call $emit_byte (i32.const 41)))                    ;; ')'

  (func $emit_str_lit_i32_load8_u_offset_0
    (call $emit_byte (i32.const 40))
    (call $emit_byte (i32.const 105)) (call $emit_byte (i32.const 51))
    (call $emit_byte (i32.const 50)) (call $emit_byte (i32.const 46))
    (call $emit_byte (i32.const 108)) (call $emit_byte (i32.const 111))
    (call $emit_byte (i32.const 97)) (call $emit_byte (i32.const 100))
    (call $emit_byte (i32.const 56)) (call $emit_byte (i32.const 95))     ;; '8' '_'
    (call $emit_byte (i32.const 117))                                     ;; 'u'
    (call $emit_byte (i32.const 41)))

  ;; Stores follow up with (i32.const 0) — Mentl's store ops return ()
  ;; semantically but WASM i32.store returns nothing. The unit-sentinel
  ;; gives downstream local.set / let-bind a value to consume.
  (func $emit_str_lit_i32_store_offset_0
    (call $emit_byte (i32.const 40))
    (call $emit_byte (i32.const 105)) (call $emit_byte (i32.const 51))
    (call $emit_byte (i32.const 50)) (call $emit_byte (i32.const 46))
    (call $emit_byte (i32.const 115)) (call $emit_byte (i32.const 116))   ;; 's' 't'
    (call $emit_byte (i32.const 111)) (call $emit_byte (i32.const 114))   ;; 'o' 'r'
    (call $emit_byte (i32.const 101))                                     ;; 'e'
    (call $emit_byte (i32.const 41))
    (call $emit_i32_const (i32.const 0)))

  (func $emit_str_lit_i32_store8_offset_0
    (call $emit_byte (i32.const 40))
    (call $emit_byte (i32.const 105)) (call $emit_byte (i32.const 51))
    (call $emit_byte (i32.const 50)) (call $emit_byte (i32.const 46))
    (call $emit_byte (i32.const 115)) (call $emit_byte (i32.const 116))
    (call $emit_byte (i32.const 111)) (call $emit_byte (i32.const 114))
    (call $emit_byte (i32.const 101)) (call $emit_byte (i32.const 56))    ;; 'e' '8'
    (call $emit_byte (i32.const 41))
    (call $emit_i32_const (i32.const 0)))

  ;; $starts_with_wasi — exact-match against the WASI import set produced
  ;; by lower's $wasi_op_target_name. Per Hβ.first-light.tier2-perform-or-
  ;; env-scan: handler names like `wasi_filesystem` collide with the
  ;; loose "starts with wasi_" check; the discriminated arm name
  ;; "wasi_filesystem_fs_exists" is NOT a WASI import. The substrate
  ;; truth: lower's wasi_op_target_name produces a CLOSED set of 9
  ;; targets (offsets 5160 wasi_path_open, 5176 wasi_fd_write, etc.);
  ;; emit recognizes membership in that closed set, NOT prefix.
  ;; Drift refused: 1 (no vtable; direct str_eq dispatch); 8 (no mode
  ;; flag); 9 (lands the closure here, not deferred — the wheel uses
  ;; handlers whose names start with wasi_ legitimately).
  ;; WASI import-name strings — placed past wasi_path_open at 5160
  ;; (occupies 5160..5177; next aligned offset 5184).
  (data (i32.const 5184) "\0d\00\00\00wasi_fd_write")
  (data (i32.const 5208) "\0c\00\00\00wasi_fd_read")
  (data (i32.const 5232) "\0d\00\00\00wasi_fd_close")
  (data (i32.const 5256) "\15\00\00\00wasi_path_unlink_file")
  (data (i32.const 5288) "\10\00\00\00wasi_path_rename")
  (data (i32.const 5312) "\0e\00\00\00wasi_proc_exit")
  (data (i32.const 5336) "\1a\00\00\00wasi_path_create_directory")
  (data (i32.const 5376) "\16\00\00\00wasi_path_filestat_get")
  (func $starts_with_wasi (param $s i32) (result i32)
    (if (call $str_eq (local.get $s) (i32.const 5160)) (then (return (i32.const 1))))   ;; wasi_path_open
    (if (call $str_eq (local.get $s) (i32.const 5184)) (then (return (i32.const 1))))   ;; wasi_fd_write
    (if (call $str_eq (local.get $s) (i32.const 5208)) (then (return (i32.const 1))))   ;; wasi_fd_read
    (if (call $str_eq (local.get $s) (i32.const 5232)) (then (return (i32.const 1))))   ;; wasi_fd_close
    (if (call $str_eq (local.get $s) (i32.const 5256)) (then (return (i32.const 1))))   ;; wasi_path_unlink_file
    (if (call $str_eq (local.get $s) (i32.const 5288)) (then (return (i32.const 1))))   ;; wasi_path_rename
    (if (call $str_eq (local.get $s) (i32.const 5312)) (then (return (i32.const 1))))   ;; wasi_proc_exit
    (if (call $str_eq (local.get $s) (i32.const 5336)) (then (return (i32.const 1))))   ;; wasi_path_create_directory
    (if (call $str_eq (local.get $s) (i32.const 5376)) (then (return (i32.const 1))))   ;; wasi_path_filestat_get
    (i32.const 0))

  ;; $ec7_emit_call_dollar — emits `(call $<name>)` direct, NO `op_` prefix.
  (func $ec7_emit_call_dollar (param $name i32)
    (call $emit_byte (i32.const 40)) (call $emit_byte (i32.const 99))
    (call $emit_byte (i32.const 97)) (call $emit_byte (i32.const 108))
    (call $emit_byte (i32.const 108)) (call $emit_byte (i32.const 32))
    (call $emit_byte (i32.const 36))
    (call $emit_str (local.get $name))
    (call $emit_byte (i32.const 41)))

  ;; ─── $emit_levperform — LEvPerform tag 333 emit arm per §2.5 ───────
  ;; Per src/backends/wasm.mn:1554-1587 + H1 evidence reification:
  ;;   (local.get $__state)          ;; implicit __state arg for callee
  ;;   <args>                        ;; user args
  ;;   (local.get $__state)          ;; load state again for fn_idx read
  ;;   (i32.load offset=N)           ;; N = 8 + 4*body_capture_count + 4*slot
  ;;   (call_indirect (type $ft<argc+1>))
  ;;
  ;; THE LOAD-BEARING DRIFT 1 REFUSAL ARM. The fn_idx for the handler
  ;; arm sits at runtime in a FIELD on the closure record at offset
  ;; (8 + 4*body_capture_count + 4*slot) — evidence passing per Koka
  ;; JFP 2022, NOT vtable indirection.
  ;;
  ;; body_capture_count is read from emit-time state via
  ;; $emit_body_captures_count (set per-fn at fn-emit boundary by
  ;; $emit_set_body_context per chunk #1 emit/state.wat). Per
  ;; SUBSTRATE.md §I third truth "polymorphic minority" — evidence-
  ;; dispatched perform when row inference cannot ground the handler
  ;; stack at compile time.
  (func $emit_levperform (param $r i32)
    (local $args i32) (local $offset i32)
    (local.set $args (call $lexpr_levperform_args (local.get $r)))
    (local.set $offset
      (i32.add (i32.const 8)
        (i32.add
          (i32.mul (i32.const 4) (call $emit_body_captures_count))
          (i32.mul (i32.const 4) (call $lexpr_levperform_slot_idx (local.get $r))))))
    (call $el_emit_local_get_state)
    (call $ec6_emit_args (local.get $args))
    (call $el_emit_local_get_state)
    (call $el_emit_i32_load_offset (local.get $offset))
    (call $ec6_emit_call_indirect_ftN (call $len (local.get $args))))

  ;; ─── $emit_lmakeclosure — LMakeClosure tag 311 emit arm ─────────────
  ;; Hβ.emit.handler-fnref-substrate — Phase D closed here.
  ;; Per src/backends/wasm.mn:1207-1244 + H1 evidence reification.
  ;;
  ;; LMakeClosure(_h, LFn(fn_name,...), captures, ev_slots):
  ;;   closure record — __state IS this record:
  ;;     offset 0:           fn_ptr (i32) — $<fn_name>_idx table entry
  ;;     offset 4:           capture_count (i32) — nc, the evidence fence
  ;;     offset 8+4*i:       capture_i
  ;;     offset 8+4*nc+4*j:  ev_slot_j (handler arm fn table index)
  ;;
  ;; Handler IS state. Evidence slots ARE fields. One record, one story.
  ;; Drift 1 refusal: fn_ptr is an i32 field — NOT a vtable entry.
  (func $emit_lmakeclosure (param $r i32)
    (local $fn_r i32) (local $fn_name i32)
    (local $caps i32) (local $evs i32)
    (local $nc i32)   (local $ne i32)
    (local.set $fn_r    (call $lexpr_lmakeclosure_fn   (local.get $r)))
    (local.set $fn_name (call $lowfn_emit_name (local.get $fn_r)))
    (local.set $caps    (call $lexpr_lmakeclosure_caps (local.get $r)))
    (local.set $evs     (call $lexpr_lmakeclosure_evs  (local.get $r)))
    (local.set $nc (call $len (local.get $caps)))
    (local.set $ne (call $len (local.get $evs)))
    ;; Alloc 8 + 4*(nc+ne) bytes → $state_tmp.
    (call $emit_alloc
      (i32.add (i32.const 8)
               (i32.mul (i32.const 4) (i32.add (local.get $nc) (local.get $ne))))
      (i32.const 2244))
    ;; Store fn_ptr at offset 0.
    (call $ec8_emit_local_get_state_tmp)
    (call $ec8_emit_global_get_name_idx (local.get $fn_name))
    (call $ec_emit_i32_store_offset (i32.const 0))
    ;; Store capture_count at offset 4 — the evidence fence.
    (call $ec8_emit_local_get_state_tmp)
    (call $emit_i32_const (local.get $nc))
    (call $ec_emit_i32_store_offset (i32.const 4))
    ;; Store captures at offsets 8, 12, 16, ...
    (call $ec8_emit_cap_stores (local.get $caps) (i32.const 8))
    ;; Store ev_slots at offsets 8+4*nc, 8+4*nc+4, ...
    (call $ec8_emit_cap_stores (local.get $evs)
      (i32.add (i32.const 8) (i32.mul (local.get $nc) (i32.const 4))))
    ;; Result: closure pointer on stack.
    (call $ec8_emit_local_get_state_tmp))

  ;; ─── $emit_lmakecontinuation — LMakeContinuation tag 312 emit arm ───
  ;; Per src/backends/wasm.mn:1247-1308 + H7 §4.2 multi-shot layout.
  ;;
  ;; LMakeContinuation(_h, LFn(resume_name,...), caps, evs, state_idx, ret_slot):
  ;;   continuation record — THE MENTL ORACLE SUBSTRATE at WAT:
  ;;     offset 0:             fn_ptr — resume_fn table index
  ;;     offset 4:             state_index — perform-site discriminator
  ;;     offset 8:             capture_count — nc, evidence fence
  ;;     offset 12+4*i:        capture_i
  ;;     offset 12+4*nc+4*j:   ev_slot_j
  ;;     offset 12+4*(nc+ne):  ret_slot — landing slot for resumed value
  ;;
  ;; Multi-shot: same record resumed multiple times. Mentl's exploration
  ;; forks here. Evidence-safe: ev_slots are fields, read at call_indirect.
  (func $emit_lmakecontinuation (param $r i32)
    (local $fn_r i32) (local $fn_name i32)
    (local $caps i32) (local $evs i32)
    (local $nc i32)   (local $ne i32)
    (local $state_idx i32) (local $ret_slot i32)
    (local.set $fn_r      (call $lexpr_lmakecontinuation_fn        (local.get $r)))
    (local.set $fn_name   (call $lowfn_emit_name (local.get $fn_r)))
    (local.set $caps      (call $lexpr_lmakecontinuation_caps      (local.get $r)))
    (local.set $evs       (call $lexpr_lmakecontinuation_evs       (local.get $r)))
    (local.set $state_idx (call $lexpr_lmakecontinuation_state_idx (local.get $r)))
    (local.set $ret_slot  (call $lexpr_lmakecontinuation_ret_slot  (local.get $r)))
    (local.set $nc (call $len (local.get $caps)))
    (local.set $ne (call $len (local.get $evs)))
    ;; Alloc 16 + 4*(nc+ne) bytes (12 header + ret_slot = 16 base).
    (call $emit_alloc
      (i32.add (i32.const 16)
               (i32.mul (i32.const 4) (i32.add (local.get $nc) (local.get $ne))))
      (i32.const 2244))
    ;; Store fn_ptr at offset 0.
    (call $ec8_emit_local_get_state_tmp)
    (call $ec8_emit_global_get_name_idx (local.get $fn_name))
    (call $ec_emit_i32_store_offset (i32.const 0))
    ;; Store state_index at offset 4 (perform-site discriminator per H7 §4.2).
    (call $ec8_emit_local_get_state_tmp)
    (call $emit_i32_const (local.get $state_idx))
    (call $ec_emit_i32_store_offset (i32.const 4))
    ;; Store capture_count at offset 8.
    (call $ec8_emit_local_get_state_tmp)
    (call $emit_i32_const (local.get $nc))
    (call $ec_emit_i32_store_offset (i32.const 8))
    ;; Store captures at offsets 12, 16, 20, ...
    (call $ec8_emit_cap_stores (local.get $caps) (i32.const 12))
    ;; Store ev_slots at offsets 12+4*nc, ...
    (call $ec8_emit_cap_stores (local.get $evs)
      (i32.add (i32.const 12) (i32.mul (local.get $nc) (i32.const 4))))
    ;; Store ret_slot at offset 12+4*(nc+ne).
    (call $ec8_emit_local_get_state_tmp)
    (call $emit_i32_const (local.get $ret_slot))
    (call $ec_emit_i32_store_offset
      (i32.add (i32.const 12)
               (i32.mul (i32.const 4) (i32.add (local.get $nc) (local.get $ne)))))
    ;; Result: continuation pointer on stack.
    (call $ec8_emit_local_get_state_tmp))
