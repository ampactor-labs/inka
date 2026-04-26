  ;; ═══ record.wat — record/tuple + ADT match helpers (Tier 1) ═══════
  ;; Implements: Hβ §1.8 (tuple) + §1.9 (record) + §1.5 (ADT match
  ;;             discriminator via heap-base threshold).
  ;; Exports:    $make_record, $record_get, $record_set,
  ;;             $tag_of, $is_sentinel
  ;; Uses:       $alloc (alloc.wat), $heap_base (Layer 0 shell)
  ;; Test:       runtime_test/record.wat
  ;;
  ;; Layout per H2-record-construction.md + H2.3-nominal-records.md +
  ;; H3-adt-instantiation.md:
  ;;   [tag:i32][arity:i32][field_0:i32]...[field_N:i32]
  ;;
  ;; The heap-base discriminator (HEAP_BASE = 4096) lets nullary-
  ;; sentinel ADT variants live in the [0, 4096) region and fielded
  ;; variants live at >= 4096; $tag_of dispatches on this threshold.
  ;; Per HB-bool-transition.md + γ crystallization #8.
  ;;
  ;; H6 wildcard discipline: every load-bearing ADT match is
  ;; exhaustive; no `_ => fabricated_default` arms.

  ;; ─── Record/Tuple Primitives ──────────────────────────────────────
  ;; Layout: [tag:i32][arity:i32][fields...]

  (func $make_record (param $tag i32) (param $arity i32) (result i32)
    (local $ptr i32)
    (local.set $ptr (call $alloc
      (i32.add (i32.const 8) (i32.mul (local.get $arity) (i32.const 4)))))
    (i32.store (local.get $ptr) (local.get $tag))
    (i32.store offset=4 (local.get $ptr) (local.get $arity))
    (local.get $ptr))

  (func $record_get (param $ptr i32) (param $idx i32) (result i32)
    (i32.load
      (i32.add
        (i32.add (local.get $ptr) (i32.const 8))
        (i32.mul (local.get $idx) (i32.const 4)))))

  (func $record_set (param $ptr i32) (param $idx i32) (param $val i32)
    (i32.store
      (i32.add
        (i32.add (local.get $ptr) (i32.const 8))
        (i32.mul (local.get $idx) (i32.const 4)))
      (local.get $val)))

  ;; ─── ADT Match Helpers ────────────────────────────────────────────

  ;; tag_of: if ptr < HEAP_BASE, it IS the tag (sentinel).
  ;; Otherwise load tag from offset 0.
  (func $tag_of (param $ptr i32) (result i32)
    (if (result i32) (i32.lt_u (local.get $ptr) (global.get $heap_base))
      (then (local.get $ptr))
      (else (i32.load (local.get $ptr)))))

  (func $is_sentinel (param $ptr i32) (result i32)
    (i32.lt_u (local.get $ptr) (global.get $heap_base)))
