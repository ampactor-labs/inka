  ;; ═══ emit_control.wat — Hβ.emit control family (Tier 6, chunk #5) ═══
  ;; Implements: Hβ-emit-substrate.md §2.3 (control family — LIf tag 314 +
  ;;             LBlock tag 315 + LMatch tag 321 + LReturn tag 310 +
  ;;             LRegion tag 328) + §5.1 (eight interrogations) + §7.1
  ;;             (chunk #5 emit_control.wat) + §11.3 dep order (chunk #5
  ;;             follows emit_local.wat which retrofitted $emit_lexpr
  ;;             with §2.2 arms).
  ;; Exports:    $emit_lif, $emit_lblock, $emit_lmatch, $emit_lreturn,
  ;;             $emit_lregion.
  ;; Uses:       $lexpr_lif_cond + $lexpr_lif_then + $lexpr_lif_else +
  ;;             $lexpr_lblock_stmts + $lexpr_lmatch_scrut +
  ;;             $lexpr_lmatch_arms + $lexpr_lreturn_x +
  ;;             $lexpr_lregion_body (lower/lexpr.wat),
  ;;             $emit_byte + $emit_str (emit_infra.wat),
  ;;             $emit_lexpr (emit_const.wat — partial dispatcher;
  ;;             this chunk RETROFITS its arm table for tags 310/314/315/
  ;;             321/328 per Hβ.emit.lexpr-dispatch-extension),
  ;;             $ec_emit_unreachable (emit_const.wat — reused for empty-
  ;;             arms LMatch + the LowPat-substrate-pending NAMED
  ;;             follow-up trap),
  ;;             $len + $list_index (runtime/list.wat).
  ;;
  ;; What this chunk IS (per Hβ-emit-substrate.md §2.3 + wheel canonical
  ;; src/backends/wasm.mn:1220-1223 + 1310-1319 + 1379-1394 + 1514+):
  ;;
  ;;   1. $emit_lreturn(r) — LReturn tag 310 (handle, x). Emits the inner
  ;;      LowExpr's value via $emit_lexpr, then "(return)" — the WASM
  ;;      control-flow primitive that hands the value back to the
  ;;      suspended `perform` site. NOT an imperative-`return` arm: Mentl
  ;;      has no `return` keyword (SYNTAX.md line 1335). LReturn is the
  ;;      lowered form of `resume(value)` inside a OneShot handler arm
  ;;      per Hβ.lower walk_call.wat Lock #6 (`ResumeExpr → LReturn`).
  ;;
  ;;   2. $emit_lif(r) — LIf tag 314 (handle, cond, then_branch, else_branch).
  ;;      Emits cond via $emit_lexpr, then "(if (result i32) (then ...)
  ;;      (else ...))" wrapping the two branches. Branches are stmt lists;
  ;;      each emitted via $ec5_emit_body sequential walk.
  ;;
  ;;   3. $emit_lblock(r) — LBlock tag 315 (handle, stmts). Sequential
  ;;      emit of the stmts list per wheel `LBlock(_h, stmts) =>
  ;;      emit_body(stmts)`. Each stmt's value pushed/popped on the
  ;;      WASM operand stack; the LAST stmt's value is the block's value.
  ;;
  ;;   4. $emit_lmatch(r) — LMatch tag 321 (handle, scrut, arms). Emits
  ;;      scrutinee via $emit_lexpr, then "(local.set $scrut_tmp)"
  ;;      capturing the value, then dispatches over arms. Empty arms
  ;;      emit "(unreachable)" — the exhaustiveness-violation runtime
  ;;      trap complementing the inference-time E_PatternInexhaustive
  ;;      check. Nonempty arms with LowPat substrate populated:
  ;;      threshold-aware HB mixed-variant dispatch per SUBSTRATE.md §IX
  ;;      "the heap has one story" — `(scrut < HEAP_BASE)` discriminates
  ;;      sentinel nullary variants from heap-record fielded variants
  ;;      without ambiguity. Lands per NAMED follow-up
  ;;      Hβ.emit.lmatch-pattern-compile when LowPat substrate becomes
  ;;      structured (per Hβ.lower.lvalue-lowfn-lpat-substrate).
  ;;
  ;;   5. $emit_lregion(r) — LRegion tag 328 (handle, body). Inert seed:
  ;;      emits the body's stmts via $ec5_emit_body without region-enter/
  ;;      exit emission. Region scoping populates this arm when the W5
  ;;      arena handler-swap lands per NAMED follow-up
  ;;      Hβ.emit.memory-arena-handler.
  ;;
  ;; Eight interrogations (per Hβ-emit-substrate.md §5.1 second pass):
  ;;
  ;;   1. Graph?       Each arm reads its LowExpr's record fields via
  ;;                   $lexpr_l*_* accessors. LIf / LBlock / LMatch /
  ;;                   LReturn / LRegion all recurse into sub-LowExprs
  ;;                   via $emit_lexpr — the dispatcher introduced in
  ;;                   chunk #3 + retrofitted by chunks #4 + this chunk.
  ;;                   Per Anchor 1: ask the graph; never re-derive.
  ;;   2. Handler?     At wheel: each arm is one branch of emit_expr
  ;;                   match per src/backends/wasm.mn. At seed: direct
  ;;                   fn dispatch via $emit_lexpr's tag table.
  ;;                   @resume=OneShot at the wheel (single-pass
  ;;                   emission per LowExpr tree).
  ;;   3. Verb?        |> — each arm's body is forward flow:
  ;;                   read fields → recurse-emit sub-expr → emit
  ;;                   instruction tokens. No verb-topology in the arms
  ;;                   themselves; the verbs (`<~` LFeedback,
  ;;                   `~>` LHandleWith, etc.) emerge in chunk #7
  ;;                   emit_handler.wat.
  ;;   4. Row?         WasmOut at wheel; row-silent at seed. Side-effect
  ;;                   on $out_base/$out_pos via $emit_byte. No
  ;;                   EmitMemory effect — control arms are read-only
  ;;                   on the heap; allocation lives in chunk #3
  ;;                   (LMake* arms).
  ;;   5. Ownership?   LowExpr `r` is `ref` (read-only structural
  ;;                   traversal). $out_base buffer OWNed program-wide.
  ;;                   No transfer.
  ;;   6. Refinement?  N/A — control arms have no refinement obligations.
  ;;                   LMatch's exhaustiveness is the inference-time
  ;;                   E_PatternInexhaustive obligation; emit-time
  ;;                   `(unreachable)` is the runtime complement.
  ;;   7. Gradient?    LMatch's HB threshold-aware mixed-variant dispatch
  ;;                   IS the gradient cash-out for ADT compile — Bool
  ;;                   is not special, every nullary variant compiles to
  ;;                   sentinel + threshold-discriminate at match. Lands
  ;;                   when LowPat substrate populates per
  ;;                   Hβ.emit.lmatch-pattern-compile follow-up.
  ;;   8. Reason?      Read-only — caller's $lookup_ty preserves Reason
  ;;                   chain on LowExpr's source handle. Control arms
  ;;                   do not write Reasons.
  ;;
  ;; Forbidden patterns audited (per Hβ-emit-substrate.md §6 + project
  ;; drift modes):
  ;;
  ;;   - Drift 1 (Rust vtable):      LMatch dispatch via tag-int
  ;;                                 comparison chain (post-LowPat-
  ;;                                 substrate); NO $emit_arm_table data
  ;;                                 segment, NO closure-record-of-fn-
  ;;                                 pointers. Word "vtable" appears
  ;;                                 nowhere.
  ;;   - Drift 5 (C calling conv):   Each arm takes ONE LowExpr ref
  ;;                                 param.
  ;;   - Drift 6 (Bool special):     LMatch (when LowPat substrate
  ;;                                 populates) uses HB threshold-aware
  ;;                                 mixed-variant dispatch — every
  ;;                                 nullary ADT variant gets the SAME
  ;;                                 sentinel discipline as Bool. NO
  ;;                                 Bool-narrow branch.
  ;;   - Drift 8 (string-keyed):     Tag dispatch in $emit_lexpr via
  ;;                                 integer constants (310/314/315/321/
  ;;                                 328); NEVER `str_eq($render_lowexpr,
  ;;                                 "LMatch")`.
  ;;   - Drift 9 (deferred-by-      LMatch's nonempty-arms path is a
  ;;                  omission):    NAMED follow-up
  ;;                                 Hβ.emit.lmatch-pattern-compile —
  ;;                                 lands when Hβ.lower.lvalue-lowfn-
  ;;                                 lpat-substrate populates LowPat.
  ;;                                 The empty-arms path is fully bodied
  ;;                                 here. Drift 9 closure via explicit
  ;;                                 naming.
  ;;   - Foreign fluency:           Vocabulary stays Mentl — "block",
  ;;                                "match", "return" (in the resume-
  ;;                                substrate sense per Lock #6),
  ;;                                "region", "scrutinee". Note: per
  ;;                                SYNTAX.md line 1335 + SUBSTRATE.md §II
  ;;                                Mentl has NO imperative loop / break /
  ;;                                continue / switch / for / in
  ;;                                constructs. Iteration is `<~`
  ;;                                feedback over Iterate effect;
  ;;                                early-exit is Abort effect via
  ;;                                catch_abort handler. The control
  ;;                                family is FIVE arms — those tags do
  ;;                                not exist in the LowExpr ADT.
  ;;
  ;; Named follow-ups (per Drift 9 + Hβ-emit-substrate.md §10):
  ;;   - Hβ.emit.lexpr-dispatch-extension: chunks #6-#7 retrofit
  ;;                                       $emit_lexpr's arm table.
  ;;   - Hβ.emit.lmatch-pattern-compile:   nonempty-arms HB threshold-
  ;;                                       aware mixed-variant dispatch;
  ;;                                       lands when
  ;;                                       Hβ.lower.lvalue-lowfn-lpat-
  ;;                                       substrate populates LowPat
  ;;                                       structurally.
  ;;   - Hβ.emit.memory-arena-handler:     LRegion enter/exit emission
  ;;                                       when W5 arena handler-swap
  ;;                                       lands.

  ;; ─── Chunk-private byte-emission projections ──────────────────────
  ;; Inline-byte design per emit_const.wat + emit_local.wat precedent —
  ;; the [0, 4096) data region is densely packed; inline $emit_byte
  ;; sequences are substrate-honest at the seed layer.

  (func $ec5_emit_return
    ;; emits: (return)
    (call $emit_byte (i32.const 40)) (call $emit_byte (i32.const 114))
    (call $emit_byte (i32.const 101)) (call $emit_byte (i32.const 116))
    (call $emit_byte (i32.const 117)) (call $emit_byte (i32.const 114))
    (call $emit_byte (i32.const 110)) (call $emit_byte (i32.const 41)))

  (func $ec5_emit_if_open_with_result_i32
    ;; emits: (if (result i32)
    (call $emit_byte (i32.const 40)) (call $emit_byte (i32.const 105))
    (call $emit_byte (i32.const 102)) (call $emit_byte (i32.const 32))
    (call $emit_byte (i32.const 40)) (call $emit_byte (i32.const 114))
    (call $emit_byte (i32.const 101)) (call $emit_byte (i32.const 115))
    (call $emit_byte (i32.const 117)) (call $emit_byte (i32.const 108))
    (call $emit_byte (i32.const 116)) (call $emit_byte (i32.const 32))
    (call $emit_byte (i32.const 105)) (call $emit_byte (i32.const 51))
    (call $emit_byte (i32.const 50)) (call $emit_byte (i32.const 41)))

  (func $ec5_emit_if_open_with_result (param $is_f64 i32)
    ;; emits: (if (result <token>) — the branch value's produced width, so
    ;; a float-valued if declares (result f64) and its branches match.
    (call $emit_byte (i32.const 40)) (call $emit_byte (i32.const 105))
    (call $emit_byte (i32.const 102)) (call $emit_byte (i32.const 32))
    (call $emit_byte (i32.const 40)) (call $emit_byte (i32.const 114))
    (call $emit_byte (i32.const 101)) (call $emit_byte (i32.const 115))
    (call $emit_byte (i32.const 117)) (call $emit_byte (i32.const 108))
    (call $emit_byte (i32.const 116)) (call $emit_byte (i32.const 32))
    (call $emit_ty_token (local.get $is_f64))
    (call $emit_byte (i32.const 41)))

  (func $ec5_emit_then_open
    ;; emits: (then
    (call $emit_byte (i32.const 40)) (call $emit_byte (i32.const 116))
    (call $emit_byte (i32.const 104)) (call $emit_byte (i32.const 101))
    (call $emit_byte (i32.const 110)))

  (func $ec5_emit_else_open
    ;; emits: (else
    (call $emit_byte (i32.const 40)) (call $emit_byte (i32.const 101))
    (call $emit_byte (i32.const 108)) (call $emit_byte (i32.const 115))
    (call $emit_byte (i32.const 101)))

  (func $ec5_emit_local_set_scrut_tmp
    ;; emits: (local.set $scrut_tmp)
    (call $emit_byte (i32.const 40)) (call $emit_byte (i32.const 108))
    (call $emit_byte (i32.const 111)) (call $emit_byte (i32.const 99))
    (call $emit_byte (i32.const 97)) (call $emit_byte (i32.const 108))
    (call $emit_byte (i32.const 46)) (call $emit_byte (i32.const 115))
    (call $emit_byte (i32.const 101)) (call $emit_byte (i32.const 116))
    (call $emit_byte (i32.const 32)) (call $emit_byte (i32.const 36))
    (call $emit_byte (i32.const 115)) (call $emit_byte (i32.const 99))
    (call $emit_byte (i32.const 114)) (call $emit_byte (i32.const 117))
    (call $emit_byte (i32.const 116)) (call $emit_byte (i32.const 95))
    (call $emit_byte (i32.const 116)) (call $emit_byte (i32.const 109))
    (call $emit_byte (i32.const 112)) (call $emit_byte (i32.const 41)))

  ;; ─── $ec5_emit_body — sequential emit of a stmt list ──────────────
  ;; Per wheel src/backends/wasm.mn:1319 `LBlock(_h, stmts) => emit_body(
  ;; stmts)` + LIf branch emission + LRegion body emission. Each stmt's
  ;; value pushed/popped on the WASM operand stack; the LAST stmt's
  ;; value is the surrounding construct's value.
  ;;
  ;; Per Hβ.emit.unit-stmt-drop (2026-05-07): non-final stmts that
  ;; push a stack value need an explicit `(drop)` after, else
  ;; wat2wasm rejects the fn body with "type mismatch at end of
  ;; function: expected [i32] but got [i32, i32, ...]". The producer
  ;; tags are everything EXCEPT LLet (304 — emits local.set, no
  ;; residue) and LDeclareFn (313 — emits a fn declaration, no
  ;; residue). The cursor projects a Drop aspect at non-final
  ;; positions for stack-producing tags. Drift refused: 1 (tag-int
  ;; dispatch, no vtable); 8 (tag IS the ADT); 9 (every producer
  ;; tag handled uniformly via the consumes-no-stack predicate).
  ;;
  ;; Drift 7 refusal: stmts is ONE list ptr field (record-shaped), not
  ;; parallel slot-arrays. Drift 9 refusal: empty list emits nothing
  ;; (the surrounding construct provides its own absence handling —
  ;; LBlock empty is a value-less block; LIf empty branches violate
  ;; type discipline at inference, not emit).
  (func $ec5_emit_body (param $stmts i32)
    (local $i i32) (local $n i32) (local $stmt i32)
    (local.set $n (call $len (local.get $stmts)))
    (local.set $i (i32.const 0))
    (block $done
      (loop $iter
        (br_if $done (i32.ge_u (local.get $i) (local.get $n)))
        (local.set $stmt (call $list_index (local.get $stmts) (local.get $i)))
        (call $emit_lexpr (local.get $stmt))
        ;; Drop residue for non-final stmts whose tag pushes a value.
        (if (i32.lt_u (i32.add (local.get $i) (i32.const 1)) (local.get $n))
          (then
            (if (i32.eqz (call $lexpr_consumes_no_stack (local.get $stmt)))
              (then (call $ec5_emit_drop_open_close)))))
        (local.set $i (i32.add (local.get $i) (i32.const 1)))
        (br $iter))))

  ;; $lexpr_consumes_no_stack — predicate reading the graph at $r.
  ;; Returns 1 iff the LowExpr's emit form leaves nothing on stack.
  ;; LLet (304) emits local.set; LDeclareFn (313) emits a fn decl —
  ;; both consume their value. LBlock (315) consumes-no-stack iff
  ;; its LAST stmt does (recursive graph read; empty block trivially
  ;; consumes-no-stack). Per protocol_emit_is_graph_projection.md.
  (func $lexpr_consumes_no_stack (param $r i32) (result i32)
    (local $tag i32) (local $stmts i32) (local $n i32)
    (local.set $tag (call $tag_of (local.get $r)))
    (if (i32.eq (local.get $tag) (i32.const 304))
      (then (return (i32.const 1))))
    (if (i32.eq (local.get $tag) (i32.const 313))
      (then (return (i32.const 1))))
    (if (i32.eq (local.get $tag) (i32.const 315))
      (then
        (local.set $stmts (call $lexpr_lblock_stmts (local.get $r)))
        (local.set $n (call $len (local.get $stmts)))
        (if (i32.eqz (local.get $n)) (then (return (i32.const 1))))
        (return (call $lexpr_consumes_no_stack
                  (call $list_index (local.get $stmts)
                        (i32.sub (local.get $n) (i32.const 1)))))))
    (i32.const 0))

  ;; $ec5_emit_drop_open_close — emits `(drop)` to consume one stack
  ;; slot. Bytes 40 'd' 'r' 'o' 'p' 41.
  (func $ec5_emit_drop_open_close
    (call $emit_byte (i32.const 40))
    (call $emit_byte (i32.const 100))
    (call $emit_byte (i32.const 114))
    (call $emit_byte (i32.const 111))
    (call $emit_byte (i32.const 112))
    (call $emit_byte (i32.const 41)))

  ;; The current fn's declared result width, set by $emit_fn_body before its
  ;; body emits. $emit_lreturn reads it to coerce a returned value whose width
  ;; disagrees with the signature — a handler arm returns an f64 __resume_val
  ;; but the arm is (result i32); a float fn returns an i32 branch.
  (global $emit_cur_result_f64 (mut i32) (i32.const 0))

  ;; ─── $emit_lreturn — LReturn tag 310 emit arm per §2.3 ─────────────
  ;; Per src/backends/wasm.mn:1220-1223. LReturn carries the resumed
  ;; value of an OneShot `resume(value)` per Hβ.lower walk_call.wat
  ;; Lock #6. WAT-level `(return)` hands the value back to the
  ;; suspended `perform` call site.
  (func $emit_lreturn (param $r i32)
    (local $vf i32)
    (local.set $vf (call $emit_expr_is_f64 (call $lexpr_lreturn_x (local.get $r))))
    (call $emit_lexpr (call $lexpr_lreturn_x (local.get $r)))
    ;; Coerce to the fn's declared result when the returned value disagrees.
    ;; __resume_val / branch values are declared-width locals/literals, so
    ;; is_f64 is reliable here. f64→i32 truncates (the seed's i32-result arm
    ;; convention meeting an f64 resume-value — peer Hβ.seed.resume-value-
    ;; repr, the ultimate form threads f64 through the arm result); i32→f64
    ;; is the exact int-in-float-position convert. Same-width returns coerce
    ;; nothing (byte-identical). Dissolves at first-light.
    (if (i32.and (local.get $vf) (i32.eqz (global.get $emit_cur_result_f64)))
      (then (call $ec6_emit_i32_trunc_f64_s)))
    (if (i32.and (i32.eqz (local.get $vf)) (global.get $emit_cur_result_f64))
      (then (call $ec6_emit_f64_convert_i32_s)))
    (call $ec5_emit_return))

  ;; ─── $emit_lif — LIf tag 314 emit arm per §2.3 ─────────────────────
  ;; Per src/backends/wasm.mn:1310-1317. Emits:
  ;;   <cond>
  ;;   (if (result i32)
  ;;     (then <then_body>)
  ;;     (else <else_body>))
  ;; Both branches are stmt lists; $ec5_emit_body iterates each.
  ;; $emit_branch_tail_is_f64 — a branch's produced width = its tail stmt's
  ;; is_f64 (empty branch → i32 floor). The read $emit_lif uses to decide the
  ;; if's result token and which arm to coerce.
  (func $emit_branch_tail_is_f64 (param $stmts i32) (result i32)
    (local $n i32)
    (local.set $n (call $len (local.get $stmts)))
    (if (i32.eqz (local.get $n)) (then (return (i32.const 0))))
    (call $emit_expr_is_f64
      (call $list_index (local.get $stmts) (i32.sub (local.get $n) (i32.const 1)))))

  (func $emit_lif (param $r i32)
    (local $tf i32) (local $ef i32)
    (call $emit_lexpr (call $lexpr_lif_cond (local.get $r)))
    ;; Each arm's produced width. The if is (result f64) if EITHER is f64;
    ;; the i32 arm is then coerced up (f64.convert_i32_s) so both arms and the
    ;; declared result agree — matching $emit_expr_is_f64's LIf arm (the OR).
    ;; Same-typed arms (the rung-critical float chain, every int if) coerce
    ;; nothing — behavior byte-identical. A then-i32/else-f64 if (float_at's
    ;; TFloatLit payload arm) becomes consistent instead of the two mismatches.
    (local.set $tf (call $emit_branch_tail_is_f64 (call $lexpr_lif_then (local.get $r))))
    (local.set $ef (call $emit_branch_tail_is_f64 (call $lexpr_lif_else (local.get $r))))
    (call $ec5_emit_if_open_with_result (i32.or (local.get $tf) (local.get $ef)))
    (call $ec5_emit_then_open)
    (call $ec5_emit_body (call $lexpr_lif_then (local.get $r)))
    (if (i32.and (local.get $ef) (i32.eqz (local.get $tf)))
      (then (call $ec6_emit_f64_convert_i32_s)))
    (call $emit_close)
    (call $ec5_emit_else_open)
    (call $ec5_emit_body (call $lexpr_lif_else (local.get $r)))
    (if (i32.and (local.get $tf) (i32.eqz (local.get $ef)))
      (then (call $ec6_emit_f64_convert_i32_s)))
    (call $emit_close)
    (call $emit_close))

  ;; ─── $emit_lblock — LBlock tag 315 emit arm per §2.3 ───────────────
  ;; Per src/backends/wasm.mn:1319 `LBlock(_h, stmts) => emit_body(stmts)`.
  ;; Sequential emit of stmts list — each stmt's value pushed/popped on
  ;; the WASM operand stack; the LAST stmt's value is the block's value.
  (func $emit_lblock (param $r i32)
    (call $ec5_emit_body (call $lexpr_lblock_stmts (local.get $r))))

  ;; ─── $emit_lmatch — LMatch tag 321 emit arm per §2.3 ───────────────
  ;; Per src/backends/wasm.mn emit_match_arms (pattern algebra).
  ;;
  ;; A pattern is the Boolean algebra of value space — the row algebra's
  ;; mirror: nesting is short-circuit AND, alternation is short-circuit
  ;; OR, tags/literals are atomic predicates, wildcards/vars are true.
  ;; A match is an ordered OR-ELSE fold over arms; each arm emits
  ;;   (pred) (if (result i32) (then binds body) (else rest)).
  ;; Every constructor's predicate carries its OWN representation guard:
  ;; nullary ctors compare the sentinel directly (HB — Bool is NOT
  ;; special); fielded ctors guard (scrut >= 4096) before loading the
  ;; tag, so sentinel values short-circuit to 0 instead of reading low
  ;; memory. The per-ctor guard makes mixed matches, cross-shape
  ;; alternation, and nested sentinel/fielded sub-patterns compose from
  ;; ONE predicate projection + ONE binds projection — no arm-set shape
  ;; classification, no threshold fork, no filtered cascades, no
  ;; dropped pattern forms. Guard elision when the scrutinee's type
  ;; proves every ctor fielded is a gradient cash-out (graph-driven).
  (func $emit_lmatch (param $r i32)
    (call $emit_lexpr (call $lexpr_lmatch_scrut (local.get $r)))
    (call $ec5_emit_local_set_scrut_tmp)
    ;; A match is a fold of arms; all arm bodies share one type, so if ANY
    ;; body's tail is f64 the whole match is f64 (an i32 arm is coerced up).
    ;; The arm-dispatch ifs then declare (result f64) and agree — a match
    ;; returning a float (float_at's TFloatLit arm, else 0.0) is consistent
    ;; instead of the hardcoded-i32 vs f64-else mismatch.
    (call $ec5_emit_match_arms_from
      (call $lexpr_lmatch_arms (local.get $r)) (i32.const 0)
      (call $ec5_match_arms_any_f64 (call $lexpr_lmatch_arms (local.get $r)))))

  ;; $ec5_match_arms_any_f64 — 1 iff any arm body's tail is f64 (the match's
  ;; produced width; all arms share one type by inference).
  (func $ec5_match_arms_any_f64 (param $arms i32) (result i32)
    (local $i i32) (local $n i32)
    (local.set $n (call $len (local.get $arms)))
    (local.set $i (i32.const 0))
    (block $d (loop $it
      (br_if $d (i32.ge_u (local.get $i) (local.get $n)))
      (if (call $emit_expr_is_f64
            (call $lowpat_lparm_body (call $list_index (local.get $arms) (local.get $i))))
        (then (return (i32.const 1))))
      (local.set $i (i32.add (local.get $i) (i32.const 1)))
      (br $it)))
    (i32.const 0))

  ;; ─── $ec5_emit_match_arms_from — ordered OR-ELSE fold over arms ─────
  ;; Per src/backends/wasm.mn emit_match_arms (pattern algebra). Each
  ;; arm: predicate → (if (result i32) (then binds body) (else rest)).
  ;; Always-matching arms (wild/var/irrefutable structure) are terminal.
  (func $ec5_emit_match_arms_from (param $arms i32) (param $idx i32) (param $result_f64 i32)
    (local $arm i32) (local $pat i32) (local $body i32)
    ;; Base case: no more arms → unreachable (exhaustiveness trap).
    (if (i32.ge_u (local.get $idx) (call $len (local.get $arms)))
      (then (call $ec_emit_unreachable) (return)))
    (local.set $arm (call $list_index (local.get $arms) (local.get $idx)))
    (local.set $pat (call $lowpat_lparm_pat (local.get $arm)))
    (local.set $body (call $lowpat_lparm_body (local.get $arm)))
    (if (call $ec5_pat_always_matches (local.get $pat))
      (then
        (call $ec5_emit_pat_binds_at (local.get $pat)
          (call $make_list (i32.const 0)) (i32.const 0))
        (call $emit_lexpr (local.get $body))
        ;; Coerce this terminal arm up to the match's width if it emits i32.
        (if (i32.and (local.get $result_f64)
                     (i32.eqz (call $emit_expr_is_f64 (local.get $body))))
          (then (call $ec6_emit_f64_convert_i32_s)))
        (return)))
    (call $ec5_emit_pat_predicate_at (local.get $pat)
      (call $make_list (i32.const 0)) (i32.const 0))
    (call $ec5_emit_if_open_with_result (local.get $result_f64))
    (call $ec5_emit_then_open)
    (call $ec5_emit_pat_binds_at (local.get $pat)
      (call $make_list (i32.const 0)) (i32.const 0))
    (call $emit_lexpr (local.get $body))
    (if (i32.and (local.get $result_f64)
                 (i32.eqz (call $emit_expr_is_f64 (local.get $body))))
      (then (call $ec6_emit_f64_convert_i32_s)))
    (call $emit_close)   ;; close then
    (call $ec5_emit_else_open)
    (call $ec5_emit_match_arms_from
      (local.get $arms) (i32.add (local.get $idx) (i32.const 1)) (local.get $result_f64))
    (call $emit_close)   ;; close else
    (call $emit_close))  ;; close if

  ;; ─── $ec5_pat_always_matches — irrefutable-pattern predicate ────────
  ;; LPWild/LPVar always match; tuples/records match iff every sub does;
  ;; alternation matches if ANY branch does; tags/literals/lists refute.
  (func $ec5_pat_always_matches (param $pat i32) (result i32)
    (local $tag i32)
    (if (i32.eq (local.get $pat) (i32.const 131))     ;; parse-PWild sentinel
      (then (return (i32.const 1))))
    (if (i32.lt_u (local.get $pat) (global.get $heap_base))
      (then (return (i32.const 0))))
    (local.set $tag (call $tag_of (local.get $pat)))
    (if (i32.eq (local.get $tag) (i32.const 360)) (then (return (i32.const 1))))  ;; LPVar
    (if (i32.eq (local.get $tag) (i32.const 361)) (then (return (i32.const 1))))  ;; LPWild
    (if (i32.eq (local.get $tag) (i32.const 364))                                  ;; LPTuple
      (then (return (call $ec5_pats_always_match
                      (call $lowpat_lptuple_elems (local.get $pat))))))
    (if (i32.eq (local.get $tag) (i32.const 366))                                  ;; LPRecord
      (then (return (call $ec5_record_pats_always_match
                      (call $lowpat_lprecord_fields (local.get $pat))))))
    (if (i32.eq (local.get $tag) (i32.const 367))                                  ;; LPAlt
      (then (return (call $ec5_alt_any_always_matches
                      (call $lowpat_lpalt_branches (local.get $pat))))))
    (i32.const 0))

  (func $ec5_pats_always_match (param $subs i32) (result i32)
    (local $i i32) (local $n i32)
    (local.set $n (call $len (local.get $subs)))
    (local.set $i (i32.const 0))
    (block $done
      (loop $iter
        (br_if $done (i32.ge_u (local.get $i) (local.get $n)))
        (if (i32.eqz (call $ec5_pat_always_matches
                       (call $list_index (local.get $subs) (local.get $i))))
          (then (return (i32.const 0))))
        (local.set $i (i32.add (local.get $i) (i32.const 1)))
        (br $iter)))
    (i32.const 1))

  (func $ec5_record_pats_always_match (param $fbs i32) (result i32)
    (local $i i32) (local $n i32)
    (local.set $n (call $len (local.get $fbs)))
    (local.set $i (i32.const 0))
    (block $done
      (loop $iter
        (br_if $done (i32.ge_u (local.get $i) (local.get $n)))
        (if (i32.eqz (call $ec5_pat_always_matches
                       (call $record_get
                         (call $list_index (local.get $fbs) (local.get $i))
                         (i32.const 2))))
          (then (return (i32.const 0))))
        (local.set $i (i32.add (local.get $i) (i32.const 1)))
        (br $iter)))
    (i32.const 1))

  (func $ec5_alt_any_always_matches (param $branches i32) (result i32)
    (local $i i32) (local $n i32)
    (local.set $n (call $len (local.get $branches)))
    (local.set $i (i32.const 0))
    (block $done
      (loop $iter
        (br_if $done (i32.ge_u (local.get $i) (local.get $n)))
        (if (call $ec5_pat_always_matches
              (call $list_index (local.get $branches) (local.get $i)))
          (then (return (i32.const 1))))
        (local.set $i (i32.add (local.get $i) (i32.const 1)))
        (br $iter)))
    (i32.const 0))

  ;; ─── $ec5_emit_scrut_at — the value at an offset path ───────────────
  (func $ec5_emit_scrut_at (param $path i32) (param $path_len i32)
    (call $ec5_emit_local_get_scrut_tmp)
    (call $ec5_emit_load_chain (local.get $path) (local.get $path_len)))

  ;; ─── $ec5_emit_pat_predicate_at — ONE i32 on the emitted stack ──────
  ;; The Boolean algebra of value space: AND via short-circuit
  ;; (if (result i32) (then inner) (else (i32.const 0))) nesting, OR via
  ;; (if (result i32) (then (i32.const 1)) (else next)) chaining. Each
  ;; fielded LPCon guards (scrut >= heap_base) before its tag load.
  (func $ec5_emit_pat_predicate_at
        (param $pat i32) (param $path i32) (param $path_len i32)
    (local $tag i32) (local $subs i32) (local $rest i32) (local $lv i32)
    (if (i32.eq (local.get $pat) (i32.const 131))
      (then (call $emit_i32_const (i32.const 1)) (return)))
    (if (i32.lt_u (local.get $pat) (global.get $heap_base))
      (then (unreachable)))
    (local.set $tag (call $tag_of (local.get $pat)))
    ;; LPVar (360) / LPWild (361) — true.
    (if (i32.or (i32.eq (local.get $tag) (i32.const 360))
                (i32.eq (local.get $tag) (i32.const 361)))
      (then (call $emit_i32_const (i32.const 1)) (return)))
    ;; LPLit (362) — value equality, STRUCTURAL for strings. lowpat_lplit_value
    ;; now yields the LowValue record [tag@0][scalar@4]. A STRING pattern
    ;; (LVString=182) is `scrutinee == "lit"`, so it emits str_eq over the
    ;; [Byte] views with the __state insert (mirror of emit_call's `==` path),
    ;; NEVER the i32.eq pointer-compare that made string patterns a layout
    ;; lottery. Int/Float/Bool keep the scalar@4 + i32.eq floor byte-identical.
    (if (i32.eq (local.get $tag) (i32.const 362))
      (then
        (local.set $lv (call $lowpat_lplit_value (local.get $pat)))
        (call $ec5_emit_scrut_at (local.get $path) (local.get $path_len))
        (if (i32.eq (i32.load (local.get $lv)) (i32.const 182))   ;; LVString
          (then
            ;; The const via $emit_string_intern → (i32.const <data_offset>),
            ;; the SAME static-data path the `==` string operand + every wheel
            ;; string literal use (emit_const.wat:203). NOT $emit_string_lit —
            ;; that stub emits a runtime (call $str_alloc), undefined in the
            ;; compiled output (the m2 assemble failure this fix first hit).
            (call $emit_i32_const
              (call $emit_string_intern (i32.load offset=4 (local.get $lv))))
            (call $ec6_emit_local_set_callee_closure)   ;; pop const → scratch
            (call $ec6_emit_local_set_state_tmp)        ;; pop scrut → scratch
            (call $el_emit_local_get_state)             ;; push __state
            (call $ec6_emit_local_get_state_tmp)        ;; push scrut
            (call $ec6_emit_local_get_callee_closure)   ;; push const
            (call $ec6_emit_call_str_eq))
          (else
            (call $emit_i32_const (i32.load offset=4 (local.get $lv)))
            (call $ec5_emit_i32_eq)))
        (return)))
    ;; LPCon (363) — nullary: sentinel compare; fielded: guard+tag+subs.
    (if (i32.eq (local.get $tag) (i32.const 363))
      (then
        (local.set $subs (call $lowpat_lpcon_args (local.get $pat)))
        (if (i32.eqz (call $len (local.get $subs)))
          (then
            (call $ec5_emit_scrut_at (local.get $path) (local.get $path_len))
            (call $emit_i32_const (call $lowpat_lpcon_tag_id (local.get $pat)))
            (call $ec5_emit_i32_eq)
            (return)))
        (call $ec5_emit_scrut_at (local.get $path) (local.get $path_len))
        (call $emit_i32_const (i32.const 4096))
        (call $ec5_emit_i32_ge_u)
        (call $ec5_emit_if_result_i32_then)
        (call $ec5_emit_scrut_at (local.get $path) (local.get $path_len))
        (call $el_emit_i32_load_offset (i32.const 0))
        (call $emit_i32_const (call $lowpat_lpcon_tag_id (local.get $pat)))
        (call $ec5_emit_i32_eq)
        (call $ec5_emit_pat_subs_predicate
          (local.get $subs) (i32.const 0)
          (local.get $path) (local.get $path_len) (i32.const 4))
        (call $ec5_emit_else_const_0_close)
        (return)))
    ;; LPTuple (364) — untagged; AND of refutable elements at 0,4,...
    (if (i32.eq (local.get $tag) (i32.const 364))
      (then
        (call $emit_i32_const (i32.const 1))
        (call $ec5_emit_pat_subs_predicate
          (call $lowpat_lptuple_elems (local.get $pat)) (i32.const 0)
          (local.get $path) (local.get $path_len) (i32.const 0))
        (return)))
    ;; LPList (365) — flat list facts: len@0, elems@8+4i. Prefix-len
    ;; check (eq without rest; ge_u with), then element AND-chain.
    (if (i32.eq (local.get $tag) (i32.const 365))
      (then
        (local.set $subs (call $lowpat_lplist_elems (local.get $pat)))
        (call $ec5_emit_scrut_at (local.get $path) (local.get $path_len))
        (call $el_emit_i32_load_offset (i32.const 0))
        (call $emit_i32_const (call $len (local.get $subs)))
        (if (i32.eqz (call $lowpat_lplist_rest (local.get $pat)))
          (then (call $ec5_emit_i32_eq))
          (else (call $ec5_emit_i32_ge_u)))
        (call $ec5_emit_pat_subs_predicate
          (local.get $subs) (i32.const 0)
          (local.get $path) (local.get $path_len) (i32.const 8))
        (return)))
    ;; LPRecord (366) — AND of refutable fields at baked offsets.
    (if (i32.eq (local.get $tag) (i32.const 366))
      (then
        (call $emit_i32_const (i32.const 1))
        (call $ec5_emit_pat_record_subs_predicate
          (call $lowpat_lprecord_fields (local.get $pat))
          (local.get $path) (local.get $path_len))
        (return)))
    ;; LPAlt (367) — OR over branches at the SAME position.
    (if (i32.eq (local.get $tag) (i32.const 367))
      (then
        (call $ec5_emit_pat_alt_predicate
          (call $lowpat_lpalt_branches (local.get $pat)) (i32.const 0)
          (local.get $path) (local.get $path_len))
        (return)))
    ;; LPAs (368) — unproducible until the parse arm lands.
    (unreachable))

  ;; AND-composition over sibling sub-patterns at base + 4*i. A bool is
  ;; on the emitted stack when called; each refutable sub wraps it in
  ;; (if (result i32) (then <sub-pred> <rest>) (else (i32.const 0))).
  (func $ec5_emit_pat_subs_predicate
        (param $subs i32) (param $i i32)
        (param $path i32) (param $path_len i32) (param $base i32)
    (local $n i32) (local $p i32)
    (local.set $n (call $len (local.get $subs)))
    (if (i32.ge_u (local.get $i) (local.get $n))
      (then (return)))
    (local.set $p (call $list_index (local.get $subs) (local.get $i)))
    (if (call $ec5_pat_always_matches (local.get $p))
      (then
        (call $ec5_emit_pat_subs_predicate
          (local.get $subs) (i32.add (local.get $i) (i32.const 1))
          (local.get $path) (local.get $path_len) (local.get $base))
        (return)))
    (call $ec5_emit_if_result_i32_then)
    (call $ec5_emit_pat_predicate_at
      (local.get $p)
      (call $ec5_path_extend (local.get $path) (local.get $path_len)
        (i32.add (local.get $base) (i32.mul (i32.const 4) (local.get $i))))
      (i32.add (local.get $path_len) (i32.const 1)))
    (call $ec5_emit_pat_subs_predicate
      (local.get $subs) (i32.add (local.get $i) (i32.const 1))
      (local.get $path) (local.get $path_len) (local.get $base))
    (call $ec5_emit_else_const_0_close))

  ;; Record fields carry pre-resolved byte offsets (lower baked them).
  (func $ec5_emit_pat_record_subs_predicate
        (param $fbs i32) (param $path i32) (param $path_len i32)
    (call $ec5_emit_pat_record_subs_predicate_from
      (local.get $fbs) (i32.const 0) (local.get $path) (local.get $path_len)))

  (func $ec5_emit_pat_record_subs_predicate_from
        (param $fbs i32) (param $i i32)
        (param $path i32) (param $path_len i32)
    (local $n i32) (local $fb i32) (local $sub i32)
    (local.set $n (call $len (local.get $fbs)))
    (if (i32.ge_u (local.get $i) (local.get $n))
      (then (return)))
    (local.set $fb (call $list_index (local.get $fbs) (local.get $i)))
    (local.set $sub (call $record_get (local.get $fb) (i32.const 2)))
    (if (call $ec5_pat_always_matches (local.get $sub))
      (then
        (call $ec5_emit_pat_record_subs_predicate_from
          (local.get $fbs) (i32.add (local.get $i) (i32.const 1))
          (local.get $path) (local.get $path_len))
        (return)))
    (call $ec5_emit_if_result_i32_then)
    (call $ec5_emit_pat_predicate_at
      (local.get $sub)
      (call $ec5_path_extend (local.get $path) (local.get $path_len)
        (call $record_get (local.get $fb) (i32.const 1)))
      (i32.add (local.get $path_len) (i32.const 1)))
    (call $ec5_emit_pat_record_subs_predicate_from
      (local.get $fbs) (i32.add (local.get $i) (i32.const 1))
      (local.get $path) (local.get $path_len))
    (call $ec5_emit_else_const_0_close))

  ;; OR-composition over alternation branches, short-circuit: the first
  ;; matching branch yields 1 without evaluating the rest.
  (func $ec5_emit_pat_alt_predicate
        (param $branches i32) (param $i i32)
        (param $path i32) (param $path_len i32)
    (local $n i32)
    (local.set $n (call $len (local.get $branches)))
    (if (i32.ge_u (local.get $i) (local.get $n))
      (then (call $emit_i32_const (i32.const 0)) (return)))
    (call $ec5_emit_pat_predicate_at
      (call $list_index (local.get $branches) (local.get $i))
      (local.get $path) (local.get $path_len))
    (if (i32.eq (i32.add (local.get $i) (i32.const 1)) (local.get $n))
      (then (return)))
    (call $ec5_emit_if_result_i32_then)
    (call $emit_i32_const (i32.const 1))
    (call $emit_close)   ;; close then
    (call $ec5_emit_else_open)
    (call $ec5_emit_pat_alt_predicate
      (local.get $branches) (i32.add (local.get $i) (i32.const 1))
      (local.get $path) (local.get $path_len))
    (call $emit_close)   ;; close else
    (call $emit_close))  ;; close if

  ;; ─── $ec5_emit_pat_binds_at — binds projection ──────────────────────
  ;; The pattern's second role: every binder gets (local.get $scrut_tmp)
  ;; <load chain> (local.set $name). Descends every pattern form.
  (func $ec5_emit_pat_binds_at
        (param $pat i32) (param $path i32) (param $path_len i32)
    (local $tag i32) (local $subs i32) (local $rest i32)
    (if (i32.eq (local.get $pat) (i32.const 131))
      (then (return)))
    (if (i32.lt_u (local.get $pat) (global.get $heap_base))
      (then (return)))
    (local.set $tag (call $tag_of (local.get $pat)))
    ;; LPVar (360) — the binder.
    (if (i32.eq (local.get $tag) (i32.const 360))
      (then
        (call $ec5_emit_scrut_at (local.get $path) (local.get $path_len))
        ;; An f64 binder (e.g. TFloatLit(f)) reads a boxed-cell POINTER from
        ;; the payload slot (§5.U seed); UNBOX to the native f64 and mark the
        ;; local f64 so its decl (the dump) and every (local.get) use read the
        ;; same width — the consistency keystone at the pattern-bind site.
        ;; f64 iff the scrutinee handle proves it (a top-level binder of an f64
        ;; value) OR the stamped payload repr does (a ctor sub-binder — its
        ;; pattern node had no handle, so lower stamped the ConstructorScheme's
        ;; TFloat payload width onto the LPVar). One width, two partial oracles.
        (if (i32.or (call $emit_repr_is_f64 (call $lowpat_handle (local.get $pat)))
                    (call $lowpat_lpvar_repr (local.get $pat)))
          (then
            (call $ec6_emit_f64_load)
            (drop (call $emit_fn_local_check_f64
                    (call $lowpat_lpvar_name (local.get $pat)) (i32.const 1)))))
        (call $ec_emit_local_set_dollar
          (call $lowpat_lpvar_name (local.get $pat)))
        (return)))
    ;; LPWild (361) / LPLit (362) — nothing to bind.
    (if (i32.or (i32.eq (local.get $tag) (i32.const 361))
                (i32.eq (local.get $tag) (i32.const 362)))
      (then (return)))
    ;; LPCon (363) — fields at 4 + 4*i.
    (if (i32.eq (local.get $tag) (i32.const 363))
      (then
        (call $ec5_emit_pat_subs_binds
          (call $lowpat_lpcon_args (local.get $pat)) (i32.const 0)
          (local.get $path) (local.get $path_len) (i32.const 4))
        (return)))
    ;; LPTuple (364) — elements at 0, 4, ...
    (if (i32.eq (local.get $tag) (i32.const 364))
      (then
        (call $ec5_emit_pat_subs_binds
          (call $lowpat_lptuple_elems (local.get $pat)) (i32.const 0)
          (local.get $path) (local.get $path_len) (i32.const 0))
        (return)))
    ;; LPList (365) — elements at 8 + 4*i; rest = slice(xs, n, len(xs)).
    (if (i32.eq (local.get $tag) (i32.const 365))
      (then
        (local.set $subs (call $lowpat_lplist_elems (local.get $pat)))
        (call $ec5_emit_pat_subs_binds
          (local.get $subs) (i32.const 0)
          (local.get $path) (local.get $path_len) (i32.const 8))
        (local.set $rest (call $lowpat_lplist_rest (local.get $pat)))
        ;; Bind the rest ONLY when named: "_" is presence-without-binding
        ;; (the wheel's bind_pat_rest law: `if name == "_" { () }`).
        (if (i32.and
              (i32.ne (local.get $rest) (i32.const 0))
              (i32.eqz (i32.and
                (i32.eq (call $str_len (local.get $rest)) (i32.const 1))
                (i32.eq (call $byte_at (local.get $rest) (i32.const 0)) (i32.const 95)))))
          (then
            ;; $slice is the W7 runtime fn (state-first; builtin-only
            ;; row → const-0 state is honest, never read).
            (call $emit_i32_const (i32.const 0))
            (call $ec5_emit_scrut_at (local.get $path) (local.get $path_len))
            (call $emit_i32_const (call $len (local.get $subs)))
            (call $ec5_emit_scrut_at (local.get $path) (local.get $path_len))
            (call $el_emit_i32_load_offset (i32.const 0))
            (call $ec5_emit_call_slice)
            (call $ec_emit_local_set_dollar (local.get $rest))))
        (return)))
    ;; LPRecord (366) — baked offsets.
    (if (i32.eq (local.get $tag) (i32.const 366))
      (then
        (call $ec5_emit_pat_record_binds
          (call $lowpat_lprecord_fields (local.get $pat)) (i32.const 0)
          (local.get $path) (local.get $path_len))
        (return)))
    ;; LPAlt (367) — branches bind the same names (infer's law) along
    ;; their OWN paths: re-dispatch on the branch that matched. The
    ;; binder-free case (common tag-union alternation) emits nothing.
    (if (i32.eq (local.get $tag) (i32.const 367))
      (then
        (local.set $subs (call $lowpat_lpalt_branches (local.get $pat)))
        (if (call $ec5_alt_has_binders (local.get $subs))
          (then
            (call $ec5_emit_pat_alt_binds_dispatch
              (local.get $subs) (i32.const 0)
              (local.get $path) (local.get $path_len))))
        (return)))
    ;; LPAs (368) — unproducible until the parse arm lands.
    (unreachable))

  (func $ec5_emit_pat_subs_binds
        (param $subs i32) (param $i i32)
        (param $path i32) (param $path_len i32) (param $base i32)
    (local $n i32)
    (local.set $n (call $len (local.get $subs)))
    (block $done
      (loop $iter
        (br_if $done (i32.ge_u (local.get $i) (local.get $n)))
        (call $ec5_emit_pat_binds_at
          (call $list_index (local.get $subs) (local.get $i))
          (call $ec5_path_extend (local.get $path) (local.get $path_len)
            (i32.add (local.get $base) (i32.mul (i32.const 4) (local.get $i))))
          (i32.add (local.get $path_len) (i32.const 1)))
        (local.set $i (i32.add (local.get $i) (i32.const 1)))
        (br $iter))))

  (func $ec5_emit_pat_record_binds
        (param $fbs i32) (param $i i32)
        (param $path i32) (param $path_len i32)
    (local $n i32) (local $fb i32)
    (local.set $n (call $len (local.get $fbs)))
    (block $done
      (loop $iter
        (br_if $done (i32.ge_u (local.get $i) (local.get $n)))
        (local.set $fb (call $list_index (local.get $fbs) (local.get $i)))
        (call $ec5_emit_pat_binds_at
          (call $record_get (local.get $fb) (i32.const 2))
          (call $ec5_path_extend (local.get $path) (local.get $path_len)
            (call $record_get (local.get $fb) (i32.const 1)))
          (i32.add (local.get $path_len) (i32.const 1)))
        (local.set $i (i32.add (local.get $i) (i32.const 1)))
        (br $iter))))

  ;; ─── Alternation binder presence (drives the binds re-dispatch) ─────
  (func $ec5_alt_has_binders (param $branches i32) (result i32)
    (local $i i32) (local $n i32)
    (local.set $n (call $len (local.get $branches)))
    (local.set $i (i32.const 0))
    (block $done
      (loop $iter
        (br_if $done (i32.ge_u (local.get $i) (local.get $n)))
        (if (call $ec5_pat_has_binders
              (call $list_index (local.get $branches) (local.get $i)))
          (then (return (i32.const 1))))
        (local.set $i (i32.add (local.get $i) (i32.const 1)))
        (br $iter)))
    (i32.const 0))

  (func $ec5_pat_has_binders (param $pat i32) (result i32)
    (local $tag i32)
    (if (i32.eq (local.get $pat) (i32.const 131))
      (then (return (i32.const 0))))
    (if (i32.lt_u (local.get $pat) (global.get $heap_base))
      (then (return (i32.const 0))))
    (local.set $tag (call $tag_of (local.get $pat)))
    (if (i32.eq (local.get $tag) (i32.const 360)) (then (return (i32.const 1))))
    (if (i32.eq (local.get $tag) (i32.const 363))
      (then (return (call $ec5_pats_have_binders
                      (call $lowpat_lpcon_args (local.get $pat))))))
    (if (i32.eq (local.get $tag) (i32.const 364))
      (then (return (call $ec5_pats_have_binders
                      (call $lowpat_lptuple_elems (local.get $pat))))))
    (if (i32.eq (local.get $tag) (i32.const 365))
      (then
        (if (call $ec5_pats_have_binders
              (call $lowpat_lplist_elems (local.get $pat)))
          (then (return (i32.const 1))))
        (return (i32.ne (call $lowpat_lplist_rest (local.get $pat))
                        (i32.const 0)))))
    (if (i32.eq (local.get $tag) (i32.const 366))
      (then (return (call $ec5_record_pats_have_binders
                      (call $lowpat_lprecord_fields (local.get $pat))))))
    (if (i32.eq (local.get $tag) (i32.const 367))
      (then (return (call $ec5_alt_has_binders
                      (call $lowpat_lpalt_branches (local.get $pat))))))
    (i32.const 0))

  (func $ec5_pats_have_binders (param $subs i32) (result i32)
    (local $i i32) (local $n i32)
    (local.set $n (call $len (local.get $subs)))
    (local.set $i (i32.const 0))
    (block $done
      (loop $iter
        (br_if $done (i32.ge_u (local.get $i) (local.get $n)))
        (if (call $ec5_pat_has_binders
              (call $list_index (local.get $subs) (local.get $i)))
          (then (return (i32.const 1))))
        (local.set $i (i32.add (local.get $i) (i32.const 1)))
        (br $iter)))
    (i32.const 0))

  (func $ec5_record_pats_have_binders (param $fbs i32) (result i32)
    (local $i i32) (local $n i32)
    (local.set $n (call $len (local.get $fbs)))
    (local.set $i (i32.const 0))
    (block $done
      (loop $iter
        (br_if $done (i32.ge_u (local.get $i) (local.get $n)))
        (if (call $ec5_pat_has_binders
              (call $record_get
                (call $list_index (local.get $fbs) (local.get $i))
                (i32.const 2)))
          (then (return (i32.const 1))))
        (local.set $i (i32.add (local.get $i) (i32.const 1)))
        (br $iter)))
    (i32.const 0))

  ;; Re-dispatch per branch for binds: (pred_b) (if (then binds_b)
  ;; (else next)). Void if — binds produce no value. The last branch
  ;; binds without a test (matched by elimination; the arm's predicate
  ;; already held).
  (func $ec5_emit_pat_alt_binds_dispatch
        (param $branches i32) (param $i i32)
        (param $path i32) (param $path_len i32)
    (local $n i32) (local $b i32)
    (local.set $n (call $len (local.get $branches)))
    (if (i32.ge_u (local.get $i) (local.get $n))
      (then (return)))
    (local.set $b (call $list_index (local.get $branches) (local.get $i)))
    (if (i32.eq (i32.add (local.get $i) (i32.const 1)) (local.get $n))
      (then
        (call $ec5_emit_pat_binds_at
          (local.get $b) (local.get $path) (local.get $path_len))
        (return)))
    (call $ec5_emit_pat_predicate_at
      (local.get $b) (local.get $path) (local.get $path_len))
    (call $ec5_emit_if_open)
    (call $ec5_emit_then_open)
    (call $ec5_emit_pat_binds_at
      (local.get $b) (local.get $path) (local.get $path_len))
    (call $emit_close)   ;; close then
    (call $ec5_emit_else_open)
    (call $ec5_emit_pat_alt_binds_dispatch
      (local.get $branches) (i32.add (local.get $i) (i32.const 1))
      (local.get $path) (local.get $path_len))
    (call $emit_close)   ;; close else
    (call $emit_close))  ;; close if

  ;; $ec5_emit_load_chain — emit (i32.load offset=Nk) for each offset in
  ;; the path. Caller has already emitted (local.get $scrut_tmp); this
  ;; chains the field-traversal loads to reach the deepest parent.
  (func $ec5_emit_load_chain (param $path i32) (param $path_len i32)
    (local $i i32)
    (local.set $i (i32.const 0))
    (block $done
      (loop $iter
        (br_if $done (i32.ge_u (local.get $i) (local.get $path_len)))
        (call $el_emit_i32_load_offset
          (call $list_index (local.get $path) (local.get $i)))
        (local.set $i (i32.add (local.get $i) (i32.const 1)))
        (br $iter))))

  ;; $ec5_path_extend — append offset to path, returning new path list.
  ;; Pure: caller passes path + path_len; this allocates extended copy.
  ;; Per Ω.3 buffer-counter substrate (no recursion-with-++ fluency).
  (func $ec5_path_extend (param $path i32) (param $path_len i32)
                          (param $offset i32) (result i32)
    (local $new_path i32) (local $new_len i32) (local $i i32)
    (local.set $new_len (i32.add (local.get $path_len) (i32.const 1)))
    (local.set $new_path (call $list_extend_to
      (call $make_list (local.get $new_len))
      (local.get $new_len)))
    (local.set $i (i32.const 0))
    (block $done
      (loop $iter
        (br_if $done (i32.ge_u (local.get $i) (local.get $path_len)))
        (drop (call $list_set (local.get $new_path) (local.get $i)
                (call $list_index (local.get $path) (local.get $i))))
        (local.set $i (i32.add (local.get $i) (i32.const 1)))
        (br $iter)))
    (drop (call $list_set (local.get $new_path) (local.get $path_len)
                          (local.get $offset)))
    (local.get $new_path))

  ;; $ec5_emit_i32_ge_u — emits: (i32.ge_u)
  (func $ec5_emit_i32_ge_u
    (call $emit_byte (i32.const 40)) (call $emit_byte (i32.const 105))
    (call $emit_byte (i32.const 51)) (call $emit_byte (i32.const 50))
    (call $emit_byte (i32.const 46)) (call $emit_byte (i32.const 103))
    (call $emit_byte (i32.const 101)) (call $emit_byte (i32.const 95))
    (call $emit_byte (i32.const 117)) (call $emit_byte (i32.const 41)))

  ;; $ec5_emit_call_slice — emits: (call $slice)
  (func $ec5_emit_call_slice
    (call $emit_byte (i32.const 40)) (call $emit_byte (i32.const 99))
    (call $emit_byte (i32.const 97)) (call $emit_byte (i32.const 108))
    (call $emit_byte (i32.const 108)) (call $emit_byte (i32.const 32))
    (call $emit_byte (i32.const 36)) (call $emit_byte (i32.const 115))
    (call $emit_byte (i32.const 108)) (call $emit_byte (i32.const 105))
    (call $emit_byte (i32.const 99)) (call $emit_byte (i32.const 101))
    (call $emit_byte (i32.const 41)))

  ;; $ec5_emit_if_open — emits: (if   (void form for binds dispatch)
  (func $ec5_emit_if_open
    (call $emit_byte (i32.const 40)) (call $emit_byte (i32.const 105))
    (call $emit_byte (i32.const 102)))

  ;; $ec5_emit_if_result_i32_then — emits: (if (result i32)(then
  ;; Short-circuit predicate open: consumes prior bool on stack.
  (func $ec5_emit_if_result_i32_then
    (call $ec5_emit_if_open_with_result_i32)
    (call $ec5_emit_then_open))

  ;; $ec5_emit_else_const_0_close — emits: )(else(i32.const 0)))
  ;; Closes short-circuit predicate. If outer was false, pushes 0
  ;; instead of evaluating inner predicate.
  (func $ec5_emit_else_const_0_close
    (call $emit_byte (i32.const 41))   ;; ')' close then-block
    (call $emit_byte (i32.const 40))   ;; '('
    (call $emit_byte (i32.const 101))  ;; 'e'
    (call $emit_byte (i32.const 108))  ;; 'l'
    (call $emit_byte (i32.const 115))  ;; 's'
    (call $emit_byte (i32.const 101))  ;; 'e'
    (call $emit_byte (i32.const 40))   ;; '('
    (call $emit_byte (i32.const 105))  ;; 'i'
    (call $emit_byte (i32.const 51))   ;; '3'
    (call $emit_byte (i32.const 50))   ;; '2'
    (call $emit_byte (i32.const 46))   ;; '.'
    (call $emit_byte (i32.const 99))   ;; 'c'
    (call $emit_byte (i32.const 111))  ;; 'o'
    (call $emit_byte (i32.const 110))  ;; 'n'
    (call $emit_byte (i32.const 115))  ;; 's'
    (call $emit_byte (i32.const 116))  ;; 't'
    (call $emit_byte (i32.const 32))   ;; ' '
    (call $emit_byte (i32.const 48))   ;; '0'
    (call $emit_byte (i32.const 41))   ;; ')' close i32.const
    (call $emit_byte (i32.const 41))   ;; ')' close else
    (call $emit_byte (i32.const 41)))  ;; ')' close if

  ;; $ec5_emit_i32_and — emit (i32.and).
  (func $ec5_emit_i32_and
    (call $emit_byte (i32.const 40)) (call $emit_byte (i32.const 105))
    (call $emit_byte (i32.const 51)) (call $emit_byte (i32.const 50))
    (call $emit_byte (i32.const 46)) (call $emit_byte (i32.const 97))
    (call $emit_byte (i32.const 110)) (call $emit_byte (i32.const 100))
    (call $emit_byte (i32.const 41)))

  ;; ─── Byte-emission projections for match dispatch ───────────────────

  (func $ec5_emit_local_get_scrut_tmp
    ;; emits: (local.get $scrut_tmp)
    (call $emit_byte (i32.const 40)) (call $emit_byte (i32.const 108))
    (call $emit_byte (i32.const 111)) (call $emit_byte (i32.const 99))
    (call $emit_byte (i32.const 97)) (call $emit_byte (i32.const 108))
    (call $emit_byte (i32.const 46)) (call $emit_byte (i32.const 103))
    (call $emit_byte (i32.const 101)) (call $emit_byte (i32.const 116))
    (call $emit_byte (i32.const 32)) (call $emit_byte (i32.const 36))
    (call $emit_byte (i32.const 115)) (call $emit_byte (i32.const 99))
    (call $emit_byte (i32.const 114)) (call $emit_byte (i32.const 117))
    (call $emit_byte (i32.const 116)) (call $emit_byte (i32.const 95))
    (call $emit_byte (i32.const 116)) (call $emit_byte (i32.const 109))
    (call $emit_byte (i32.const 112)) (call $emit_byte (i32.const 41)))

  (func $ec5_emit_i32_eq
    ;; emits: (i32.eq)
    (call $emit_byte (i32.const 40)) (call $emit_byte (i32.const 105))
    (call $emit_byte (i32.const 51)) (call $emit_byte (i32.const 50))
    (call $emit_byte (i32.const 46)) (call $emit_byte (i32.const 101))
    (call $emit_byte (i32.const 113)) (call $emit_byte (i32.const 41)))

  (func $ec5_emit_i32_lt_u
    ;; emits: (i32.lt_u)
    (call $emit_byte (i32.const 40)) (call $emit_byte (i32.const 105))
    (call $emit_byte (i32.const 51)) (call $emit_byte (i32.const 50))
    (call $emit_byte (i32.const 46)) (call $emit_byte (i32.const 108))
    (call $emit_byte (i32.const 116)) (call $emit_byte (i32.const 95))
    (call $emit_byte (i32.const 117)) (call $emit_byte (i32.const 41)))

  ;; ─── $emit_lregion — LRegion tag 328 emit arm per §2.3 ─────────────
  ;; Per src/backends/wasm.mn:1514+. Inert seed: emits the body's stmts
  ;; via $ec5_emit_body without region-enter/exit emission. The W5
  ;; arena handler-swap populates region-enter/exit emission per NAMED
  ;; follow-up Hβ.emit.memory-arena-handler — at that point this arm
  ;; surrounds the body emission with arena_ptr snapshot/restore WAT.
  (func $emit_lregion (param $r i32)
    (call $ec5_emit_body (call $lexpr_lregion_body (local.get $r))))
