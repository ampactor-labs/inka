  ;; ═══ state.wat — inference per-walk scratchpads (Tier 4) ═══════════
  ;; Implements: Hβ-infer-substrate.md §1 — module-level globals for
  ;;             the inference walk (ref-escape tracker, fn-stack,
  ;;             span/intent indices) + $infer_init idempotent.
  ;; Exports:    $infer_init,
  ;;             $infer_ref_escape_push, $infer_ref_escape_len,
  ;;             $infer_ref_escape_clear_state,
  ;;             $infer_fn_stack_push, $infer_fn_stack_pop,
  ;;             $infer_fn_stack_top, $infer_fn_stack_len,
  ;;             $infer_span_index_append, $infer_intent_index_append,
  ;;             $infer_reset_walk
  ;; Uses:       $alloc (alloc.wat),
  ;;             $make_list / $list_set / $list_index / $list_extend_to /
  ;;             $len (list.wat),
  ;;             $make_record / $record_get / $record_set (record.wat)
  ;; Test:       runtime_test/infer_state.wat (pending — first acceptance is
  ;;             $infer_*-grep + wasm-validate per Hβ-infer-substrate.md §11)
  ;;
  ;; What these scratchpads ARE (per Hβ-infer-substrate.md §1):
  ;;   The inference walk maintains FOUR per-walk scratchpads beyond
  ;;   what graph.wat (the constraint store) and env.wat (the scope
  ;;   stack) hold. They are scoped to the walk; downstream passes
  ;;   (lower / emit / query) read graph.wat instead. Materialized
  ;;   into graph entries at appropriate boundaries.
  ;;
  ;;   1. ref-escape tracker  — list of (name_str_ptr, span_ptr).
  ;;      VarRefs annotated `ref` push here at lookup; FnStmt exit
  ;;      walks against return position per spec 07 escape analysis.
  ;;   2. fn-stack            — list of i32 (FnStmt handles).
  ;;      Stack-shaped for nested fns; $generalize at FnStmt exit
  ;;      reads top to know which env entries are part of THIS fn's
  ;;      body. Pure i32 entries — no record wrap.
  ;;   3. span index          — list of (span_ptr, handle).
  ;;      Per src/graph.mn graph_index_span; query layer reads after
  ;;      inference for cursor-position lookups.
  ;;   4. intent index        — list of (handle, declared_effects).
  ;;      Per src/graph.mn graph_index_intent; query reads for
  ;;      "what handlers would this fn need?" surfaces.
  ;;
  ;; Eight interrogations at this chunk's edit sites (per §6.1):
  ;;   1. Graph?       fn_stack holds graph handles allocated by
  ;;                   $graph_fresh_ty/_row at FnStmt; span/intent
  ;;                   indices pair handles with source positions.
  ;;   2. Handler?     The seed's inference is direct functions; the
  ;;                   wheel compiles handler-shape from src/infer.mn.
  ;;                   These globals are the seed's interim — they do
  ;;                   NOT survive into the wheel's compiled form.
  ;;   3. Verb?        N/A at substrate level.
  ;;   4. Row?         ref_escape interacts with the Consume row entry
  ;;                   per spec 04 §Ownership; intent_index records
  ;;                   declared effects per FnStmt.
  ;;   5. Ownership?   Scratchpads OWN by inference walk; cleared at
  ;;                   $infer_reset_walk; entries `ref` to source spans
  ;;                   + handles allocated upstream.
  ;;   6. Refinement?  N/A — refinement obligations land in verify.wat's
  ;;                   ledger, not here.
  ;;   7. Gradient?    fn_stack depth is one gradient signal (nesting
  ;;                   level for diagnostics); ref_escape length signals
  ;;                   how many borrows are still live at any point.
  ;;   8. Reason?      span/intent indices are query-layer surfaces
  ;;                   that walk reasons later (the entries themselves
  ;;                   carry no Reason — they index TO Reason chains
  ;;                   stored in graph.wat's NBound nodes).
  ;;
  ;; Forbidden patterns audited (per §7):
  ;;   - Drift 1 (vtable):                  no dispatch table; helpers are direct fns.
  ;;   - Drift 7 (parallel-arrays-vs-record): (name, span) and (span, handle)
  ;;                                        and (handle, effs) all use $make_record(2)
  ;;                                        — NOT parallel `_names_ptr` + `_spans_ptr` arrays.
  ;;   - Drift 8 (string-keyed):            record tags are integer constants
  ;;                                        (210/211/212) per the walkthrough's
  ;;                                        reserved 200-219 region for infer-private records.
  ;;   - Drift 9 (deferred-by-omission):    every helper named here has its body;
  ;;                                        no `;; TODO:` placeholders.

  ;; ─── Per-walk scratchpads (module-level globals) ─────────────────
  (global $infer_initialized        (mut i32) (i32.const 0))

  ;; Ref-escape tracker. Flat list of (name_str_ptr, span_ptr) records
  ;; tagged REF_ESCAPE_ENTRY_TAG=210. Length tracked separately per
  ;; the buffer-counter substrate (Ω.3); buffer grows via
  ;; $list_extend_to as length crosses capacity.
  (global $infer_ref_escape_ptr     (mut i32) (i32.const 0))
  (global $infer_ref_escape_len_g   (mut i32) (i32.const 0))

  ;; FnStmt/Lambda row-accumulation stack (Hβ.infer.perform-effect-row-
  ;; propagation). Each entry is a frame record (tag 213):
  ;;   [0]=accumulated_row (EffRow)  [1]=fn_span  [2]=row_handle (NRowFree)
  ;; pushed by $walk_expr_inf_enter_fn, mutated by $walk_expr_inf_add_row,
  ;; bound + popped by $walk_expr_inf_exit_fn. Length = top-of-stack + 1.
  ;; (Was a dormant pure-i32 handle stack; realized as the row-scope per
  ;; protocol_audit_dormant_first — the slot the system reserved.)
  (global $infer_fn_stack_ptr       (mut i32) (i32.const 0))
  (global $infer_fn_stack_len_g     (mut i32) (i32.const 0))

  ;; Row-edge ledger (Hβ.infer.row-fixpoint-late-callees). Flat pairs
  ;; (fn_row_var, callsite_row_var): every call site links its row var
  ;; into the enclosing fn's row var. The frame's immediate union only
  ;; sees callee rows ALREADY bound at walk time; later-defined and
  ;; mutually-recursive callees contribute nothing — rows under-close
  ;; across deep chains and evidence never threads. $infer_row_fixpoint
  ;; (post-walk) unions late-bound callee rows into fn rows until
  ;; stable — monotone over finite name sets, so convergent.
  (global $infer_row_edges_ptr      (mut i32) (i32.const 0))
  (global $infer_row_edges_len_g    (mut i32) (i32.const 0))

  ;; Typed-resume arm context (SUBSTRATE.md primitive #2): inside
  ;; `op(args) => body` for `op : (P...) -> R` under a handler whose
  ;; handle-result is S, `resume : R -> S`. $infer_walk_expr_resume
  ;; reads these; arm walks set + save/restore around each body
  ;; (handler decls nest inside arm bodies). 0 = no arm context —
  ;; the seed binds resume to TUnit there (the wheel carries the
  ;; E_ResumeOutsideArm diagnostic; the disposable seed stays
  ;; productive-under-error). Mirror of wheel infer_ctx arm_stack.
  (global $infer_arm_ret_ty_g       (mut i32) (i32.const 0))
  (global $infer_arm_result_h_g     (mut i32) (i32.const 0))

  ;; Span index. Flat list of (span_ptr, handle) records tagged
  ;; SPAN_INDEX_ENTRY_TAG=211.
  (global $infer_span_index_ptr     (mut i32) (i32.const 0))
  (global $infer_span_index_len_g   (mut i32) (i32.const 0))

  ;; Intent index. Flat list of (handle, eff_row_ptr) records tagged
  ;; INTENT_INDEX_ENTRY_TAG=212.
  (global $infer_intent_index_ptr   (mut i32) (i32.const 0))
  (global $infer_intent_index_len_g (mut i32) (i32.const 0))

  ;; ─── Idempotent initializer ──────────────────────────────────────
  ;; Allocates initial buffers for all four scratchpads. Public-entry
  ;; chunks ($infer_expr / $infer_stmt / $generalize) call this so the
  ;; seed can drive inference from any entry point. Initial capacity
  ;; 8 per buffer — $list_extend_to grows on demand.
  (func $infer_init
    (if (i32.eqz (global.get $infer_initialized))
      (then
        (global.set $infer_ref_escape_ptr   (call $make_list (i32.const 8)))
        (global.set $infer_ref_escape_len_g (i32.const 0))
        (global.set $infer_fn_stack_ptr     (call $make_list (i32.const 8)))
        (global.set $infer_fn_stack_len_g   (i32.const 0))
        (global.set $infer_row_edges_ptr    (call $make_list (i32.const 8)))
        (global.set $infer_row_edges_len_g  (i32.const 0))
        (global.set $infer_span_index_ptr   (call $make_list (i32.const 8)))
        (global.set $infer_span_index_len_g (i32.const 0))
        (global.set $infer_intent_index_ptr (call $make_list (i32.const 8)))
        (global.set $infer_intent_index_len_g (i32.const 0))
        (global.set $infer_initialized      (i32.const 1)))))

  ;; ─── Ref-escape tracker helpers ──────────────────────────────────

  ;; Append (name_str, span) record to the ref-escape tracker.
  (func $infer_ref_escape_push (param $name i32) (param $span i32)
    (local $entry i32) (local $new_len i32)
    (call $infer_init)
    (local.set $entry (call $make_record (i32.const 210) (i32.const 2)))
    (call $record_set (local.get $entry) (i32.const 0) (local.get $name))
    (call $record_set (local.get $entry) (i32.const 1) (local.get $span))
    (local.set $new_len (i32.add (global.get $infer_ref_escape_len_g) (i32.const 1)))
    (global.set $infer_ref_escape_ptr
      (call $list_extend_to (global.get $infer_ref_escape_ptr) (local.get $new_len)))
    (drop (call $list_set (global.get $infer_ref_escape_ptr)
                          (global.get $infer_ref_escape_len_g)
                          (local.get $entry)))
    (global.set $infer_ref_escape_len_g (local.get $new_len)))

  ;; Current length of the ref-escape tracker.
  (func $infer_ref_escape_len (result i32)
    (call $infer_init)
    (global.get $infer_ref_escape_len_g))

  ;; ─── FnStmt-handle stack helpers ─────────────────────────────────

  ;; Push a FnStmt handle onto the inference stack.
  (func $infer_fn_stack_push (param $fn_handle i32)
    (local $new_len i32)
    (call $infer_init)
    (local.set $new_len (i32.add (global.get $infer_fn_stack_len_g) (i32.const 1)))
    (global.set $infer_fn_stack_ptr
      (call $list_extend_to (global.get $infer_fn_stack_ptr) (local.get $new_len)))
    (drop (call $list_set (global.get $infer_fn_stack_ptr)
                          (global.get $infer_fn_stack_len_g)
                          (local.get $fn_handle)))
    (global.set $infer_fn_stack_len_g (local.get $new_len)))

  ;; Pop the topmost FnStmt handle. Decrements length; the buffer slot
  ;; remains (bump allocator never frees) but is logically dead.
  ;; Trap on underflow — Hβ.infer's discipline is push-then-pop balanced
  ;; per FnStmt entry/exit; underflow signals a walk bug to surface.
  (func $infer_fn_stack_pop
    (call $infer_init)
    (if (i32.eqz (global.get $infer_fn_stack_len_g))
      (then (unreachable)))
    (global.set $infer_fn_stack_len_g
      (i32.sub (global.get $infer_fn_stack_len_g) (i32.const 1))))

  ;; Read the topmost FnStmt handle (without popping). Trap on empty.
  (func $infer_fn_stack_top (result i32)
    (call $infer_init)
    (if (i32.eqz (global.get $infer_fn_stack_len_g))
      (then (unreachable)))
    (call $list_index (global.get $infer_fn_stack_ptr)
                      (i32.sub (global.get $infer_fn_stack_len_g) (i32.const 1))))

  ;; Current depth of the FnStmt stack.
  (func $infer_fn_stack_len (result i32)
    (call $infer_init)
    (global.get $infer_fn_stack_len_g))

  ;; ─── Row-edge ledger + fixpoint (Hβ.infer.row-fixpoint-late-callees) ─

  ;; Append the (enclosing-fn-row-var, callsite-row-var) edge. No active
  ;; frame (module top-level) → no edge (top-level rows have no fn var).
  (func $infer_row_edge_append (param $callsite_row_h i32)
    (local $frame i32) (local $n i32)
    (call $infer_init)
    (if (i32.eqz (global.get $infer_fn_stack_len_g)) (then (return)))
    (local.set $frame (call $infer_fn_stack_top))
    (local.set $n (global.get $infer_row_edges_len_g))
    (global.set $infer_row_edges_ptr
      (call $list_extend_to (global.get $infer_row_edges_ptr)
                            (i32.add (local.get $n) (i32.const 2))))
    (drop (call $list_set (global.get $infer_row_edges_ptr) (local.get $n)
                          (call $record_get (local.get $frame) (i32.const 2))))
    (drop (call $list_set (global.get $infer_row_edges_ptr)
                          (i32.add (local.get $n) (i32.const 1))
                          (local.get $callsite_row_h)))
    (global.set $infer_row_edges_len_g (i32.add (local.get $n) (i32.const 2))))

  ;; Resolved row VALUE of a row var: NRowBound → lookup through;
  ;; NRowFree → 0 (nothing to contribute yet).
  (func $infer_row_var_resolved (param $h i32) (result i32)
    (local $nk i32)
    (local.set $nk (call $gnode_kind (call $graph_chase (local.get $h))))
    (if (i32.eq (call $node_kind_tag (local.get $nk)) (i32.const 62))
      (then (return (call $lookup_row_for
        (call $node_kind_payload (local.get $nk))))))
    (i32.const 0))

  ;; Post-walk monotone fixpoint: union each call edge's late-bound
  ;; callee row into the enclosing fn's row until no name set grows.
  ;; Union over finite name sets is monotone → convergent; 64-pass
  ;; ceiling is a structural-bug trap, far above any real depth.
  (func $infer_row_fixpoint
    (local $changed i32) (local $iter i32) (local $i i32)
    (local $fh i32) (local $ch i32) (local $cur i32) (local $cal i32)
    (local $new i32)
    (call $infer_init)
    (block $stable
      (loop $pass
        (local.set $changed (i32.const 0))
        (local.set $i (i32.const 0))
        (block $edges_done
          (loop $each
            (br_if $edges_done
              (i32.ge_u (local.get $i) (global.get $infer_row_edges_len_g)))
            (local.set $fh (call $list_index
              (global.get $infer_row_edges_ptr) (local.get $i)))
            (local.set $ch (call $list_index
              (global.get $infer_row_edges_ptr)
              (i32.add (local.get $i) (i32.const 1))))
            (local.set $i (i32.add (local.get $i) (i32.const 2)))
            (local.set $cal (call $infer_row_var_resolved (local.get $ch)))
            (if (i32.eqz (local.get $cal)) (then (br $each)))
            (if (i32.eqz (i32.or (call $row_is_closed (local.get $cal))
                                 (call $row_is_open   (local.get $cal))))
              (then (br $each)))
            (if (i32.eqz (call $len (call $row_names (local.get $cal))))
              (then (br $each)))
            (local.set $cur (call $infer_row_var_resolved (local.get $fh)))
            (if (i32.eqz (local.get $cur)) (then (br $each)))
            (if (i32.eqz (i32.or (call $row_is_pure (local.get $cur))
                          (i32.or (call $row_is_closed (local.get $cur))
                                  (call $row_is_open  (local.get $cur)))))
              (then (br $each)))
            (local.set $new (call $row_union (local.get $cur) (local.get $cal)))
            (if (i32.gt_u (call $len (call $row_names (local.get $new)))
                          (call $len (call $row_names (local.get $cur))))
              (then
                (call $graph_bind_row (local.get $fh) (local.get $new)
                  (call $reason_make_inferred (i32.const 3984)))   ;; fn effect row
                (local.set $changed (i32.const 1))))
            (br $each)))
        (call $eprint_string (call $int_to_str (i32.add (i32.const 760000000) (local.get $changed))))
        (local.set $iter (i32.add (local.get $iter) (i32.const 1)))
        (br_if $stable (i32.eqz (local.get $changed)))
        (if (i32.ge_u (local.get $iter) (i32.const 64)) (then (unreachable)))
        (br $pass))))

  ;; ─── Span index helpers ──────────────────────────────────────────

  ;; Append (span_ptr, handle) record to the span index.
  (func $infer_span_index_append (param $span i32) (param $handle i32)
    (local $entry i32) (local $new_len i32)
    (call $infer_init)
    (local.set $entry (call $make_record (i32.const 211) (i32.const 2)))
    (call $record_set (local.get $entry) (i32.const 0) (local.get $span))
    (call $record_set (local.get $entry) (i32.const 1) (local.get $handle))
    (local.set $new_len (i32.add (global.get $infer_span_index_len_g) (i32.const 1)))
    (global.set $infer_span_index_ptr
      (call $list_extend_to (global.get $infer_span_index_ptr) (local.get $new_len)))
    (drop (call $list_set (global.get $infer_span_index_ptr)
                          (global.get $infer_span_index_len_g)
                          (local.get $entry)))
    (global.set $infer_span_index_len_g (local.get $new_len)))

  ;; ─── Intent index helpers ────────────────────────────────────────

  ;; Append (handle, eff_row_ptr) record to the intent index.
  (func $infer_intent_index_append (param $handle i32) (param $effs i32)
    (local $entry i32) (local $new_len i32)
    (call $infer_init)
    (local.set $entry (call $make_record (i32.const 212) (i32.const 2)))
    (call $record_set (local.get $entry) (i32.const 0) (local.get $handle))
    (call $record_set (local.get $entry) (i32.const 1) (local.get $effs))
    (local.set $new_len (i32.add (global.get $infer_intent_index_len_g) (i32.const 1)))
    (global.set $infer_intent_index_ptr
      (call $list_extend_to (global.get $infer_intent_index_ptr) (local.get $new_len)))
    (drop (call $list_set (global.get $infer_intent_index_ptr)
                          (global.get $infer_intent_index_len_g)
                          (local.get $entry)))
    (global.set $infer_intent_index_len_g (local.get $new_len)))

  ;; ─── Defensive walk reset ────────────────────────────────────────
  ;; Clear all scratchpads. Called between top-level FnStmt walks if
  ;; needed; defensive against stale entries leaking across walks.
  ;; Length-only reset — buffers themselves stay (bump allocator never
  ;; frees); next push reuses the existing flat storage.
  (func $infer_reset_walk
    (call $infer_init)
    (global.set $infer_ref_escape_len_g   (i32.const 0))
    (global.set $infer_fn_stack_len_g     (i32.const 0))
    (global.set $infer_span_index_len_g   (i32.const 0))
    (global.set $infer_intent_index_len_g (i32.const 0)))

  ;; ─── Per-FnStmt-exit ref-escape reset ────────────────────────────
  ;; Finer-grained than $infer_reset_walk — clears only the ref-escape
  ;; tracker (not fn-stack / span-index / intent-index). Called by
  ;; own.wat's $infer_ref_escape_clear at FnStmt exit per src/own.mn:371-376
  ;; check_ref_escape lifecycle. Length-only reset (buffers stay).
  (func $infer_ref_escape_clear_state
    (call $infer_init)
    (global.set $infer_ref_escape_len_g (i32.const 0)))
