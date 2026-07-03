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
