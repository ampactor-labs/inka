  (func $ec6_emit_f64_add
    (call $emit_byte (i32.const 40)) (call $emit_byte (i32.const 102)) (call $emit_byte (i32.const 54)) (call $emit_byte (i32.const 52)) (call $emit_byte (i32.const 46)) (call $emit_byte (i32.const 97)) (call $emit_byte (i32.const 100)) (call $emit_byte (i32.const 100)) (call $emit_byte (i32.const 41)))
  (func $ec6_emit_f64_sub
    (call $emit_byte (i32.const 40)) (call $emit_byte (i32.const 102)) (call $emit_byte (i32.const 54)) (call $emit_byte (i32.const 52)) (call $emit_byte (i32.const 46)) (call $emit_byte (i32.const 115)) (call $emit_byte (i32.const 117)) (call $emit_byte (i32.const 98)) (call $emit_byte (i32.const 41)))
  (func $ec6_emit_f64_mul
    (call $emit_byte (i32.const 40)) (call $emit_byte (i32.const 102)) (call $emit_byte (i32.const 54)) (call $emit_byte (i32.const 52)) (call $emit_byte (i32.const 46)) (call $emit_byte (i32.const 109)) (call $emit_byte (i32.const 117)) (call $emit_byte (i32.const 108)) (call $emit_byte (i32.const 41)))
  (func $ec6_emit_f64_div
    (call $emit_byte (i32.const 40)) (call $emit_byte (i32.const 102)) (call $emit_byte (i32.const 54)) (call $emit_byte (i32.const 52)) (call $emit_byte (i32.const 46)) (call $emit_byte (i32.const 100)) (call $emit_byte (i32.const 105)) (call $emit_byte (i32.const 118)) (call $emit_byte (i32.const 41)))
  (func $ec6_emit_f64_eq
    (call $emit_byte (i32.const 40)) (call $emit_byte (i32.const 102)) (call $emit_byte (i32.const 54)) (call $emit_byte (i32.const 52)) (call $emit_byte (i32.const 46)) (call $emit_byte (i32.const 101)) (call $emit_byte (i32.const 113)) (call $emit_byte (i32.const 41)))
  (func $ec6_emit_f64_ne
    (call $emit_byte (i32.const 40)) (call $emit_byte (i32.const 102)) (call $emit_byte (i32.const 54)) (call $emit_byte (i32.const 52)) (call $emit_byte (i32.const 46)) (call $emit_byte (i32.const 110)) (call $emit_byte (i32.const 101)) (call $emit_byte (i32.const 41)))
  (func $ec6_emit_f64_lt
    (call $emit_byte (i32.const 40)) (call $emit_byte (i32.const 102)) (call $emit_byte (i32.const 54)) (call $emit_byte (i32.const 52)) (call $emit_byte (i32.const 46)) (call $emit_byte (i32.const 108)) (call $emit_byte (i32.const 116)) (call $emit_byte (i32.const 41)))
  (func $ec6_emit_f64_gt
    (call $emit_byte (i32.const 40)) (call $emit_byte (i32.const 102)) (call $emit_byte (i32.const 54)) (call $emit_byte (i32.const 52)) (call $emit_byte (i32.const 46)) (call $emit_byte (i32.const 103)) (call $emit_byte (i32.const 116)) (call $emit_byte (i32.const 41)))
  (func $ec6_emit_f64_le
    (call $emit_byte (i32.const 40)) (call $emit_byte (i32.const 102)) (call $emit_byte (i32.const 54)) (call $emit_byte (i32.const 52)) (call $emit_byte (i32.const 46)) (call $emit_byte (i32.const 108)) (call $emit_byte (i32.const 101)) (call $emit_byte (i32.const 41)))
  (func $ec6_emit_f64_ge
    (call $emit_byte (i32.const 40)) (call $emit_byte (i32.const 102)) (call $emit_byte (i32.const 54)) (call $emit_byte (i32.const 52)) (call $emit_byte (i32.const 46)) (call $emit_byte (i32.const 103)) (call $emit_byte (i32.const 101)) (call $emit_byte (i32.const 41)))
  (func $ec6_emit_f64_neg
    (call $emit_byte (i32.const 40)) (call $emit_byte (i32.const 102)) (call $emit_byte (i32.const 54)) (call $emit_byte (i32.const 52)) (call $emit_byte (i32.const 46)) (call $emit_byte (i32.const 110)) (call $emit_byte (i32.const 101)) (call $emit_byte (i32.const 103)) (call $emit_byte (i32.const 41)))
  ;; int<->float coercion — the gradient's convert arm (a REAL machine
  ;; convert, never a bit-reinterpreting identity). lower recognizes
  ;; float_of_int/float_to_int → LConvert; emit_lconvert reads the kind.
  (func $ec6_emit_f64_convert_i32_s
    ;; emits: (f64.convert_i32_s)
    (call $emit_byte (i32.const 40)) (call $emit_byte (i32.const 102)) (call $emit_byte (i32.const 54)) (call $emit_byte (i32.const 52)) (call $emit_byte (i32.const 46)) (call $emit_byte (i32.const 99)) (call $emit_byte (i32.const 111)) (call $emit_byte (i32.const 110)) (call $emit_byte (i32.const 118)) (call $emit_byte (i32.const 101)) (call $emit_byte (i32.const 114)) (call $emit_byte (i32.const 116)) (call $emit_byte (i32.const 95)) (call $emit_byte (i32.const 105)) (call $emit_byte (i32.const 51)) (call $emit_byte (i32.const 50)) (call $emit_byte (i32.const 95)) (call $emit_byte (i32.const 115)) (call $emit_byte (i32.const 41)))
  (func $ec6_emit_i32_trunc_f64_s
    ;; emits: (i32.trunc_f64_s)
    (call $emit_byte (i32.const 40)) (call $emit_byte (i32.const 105)) (call $emit_byte (i32.const 51)) (call $emit_byte (i32.const 50)) (call $emit_byte (i32.const 46)) (call $emit_byte (i32.const 116)) (call $emit_byte (i32.const 114)) (call $emit_byte (i32.const 117)) (call $emit_byte (i32.const 110)) (call $emit_byte (i32.const 99)) (call $emit_byte (i32.const 95)) (call $emit_byte (i32.const 102)) (call $emit_byte (i32.const 54)) (call $emit_byte (i32.const 52)) (call $emit_byte (i32.const 95)) (call $emit_byte (i32.const 115)) (call $emit_byte (i32.const 41)))
  ;; ─── f64 heap membrane: the seed-boxed f64 cell (§5.U seed) ─────────
  ;; A native unboxed f64 cannot ride a uniform i32 heap slot (record field,
  ;; tuple/list element, variant payload). At the crossing the seed BOXES:
  ;; bump-alloc an 8-byte cell, (f64.store) the value, store the cell POINTER
  ;; (a word) in the slot — layout stays uniform i32, handle-uniformity
  ;; untouched. At every f64-typed LOAD it UNBOXES: i32.load the pointer,
  ;; then (f64.load) the cell. Box/unbox appear ONLY at the heap membrane;
  ;; a boxed float re-entering the stack world is a plain f64 again. 4-aligned
  ;; addresses are legal for f64 access in wasm (alignment is a hint, never a
  ;; trap), so the bump base's 4-alignment needs no 8-byte rounding. Seed-only,
  ;; inelegant-but-CORRECT — the wheel's own emit width-folds the real layout
  ;; and this dissolves at first-light (peer Hβ.emit.f64-heap-slot-field).
  (func $ec6_emit_f64_store
    ;; emits: (f64.store)
    (call $emit_byte (i32.const 40)) (call $emit_byte (i32.const 102)) (call $emit_byte (i32.const 54)) (call $emit_byte (i32.const 52)) (call $emit_byte (i32.const 46)) (call $emit_byte (i32.const 115)) (call $emit_byte (i32.const 116)) (call $emit_byte (i32.const 111)) (call $emit_byte (i32.const 114)) (call $emit_byte (i32.const 101)) (call $emit_byte (i32.const 41)))
  (func $ec6_emit_f64_load
    ;; emits: (f64.load)
    (call $emit_byte (i32.const 40)) (call $emit_byte (i32.const 102)) (call $emit_byte (i32.const 54)) (call $emit_byte (i32.const 52)) (call $emit_byte (i32.const 46)) (call $emit_byte (i32.const 108)) (call $emit_byte (i32.const 111)) (call $emit_byte (i32.const 97)) (call $emit_byte (i32.const 100)) (call $emit_byte (i32.const 41)))
