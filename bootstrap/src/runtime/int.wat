  ;; ═══ int.wat — integer ↔ string conversion (Tier 1) ═══════════════
  ;; Implements: Hβ §1.6 integer/string conversion + memory-region
  ;;             string construction.
  ;; Exports:    $str_of_byte, $str_from_mem, $int_to_str, $parse_int
  ;; Uses:       $alloc (alloc.wat), $str_alloc (str.wat),
  ;;             $str_len (str.wat), $byte_at (str.wat),
  ;;             $str_of_byte (self — used by $int_to_str)
  ;; Test:       runtime_test/int.wat
  ;;
  ;; Bridges between byte / memory-region representations and the
  ;; flat string layout (see str.wat). Callers in lexer.wat use these
  ;; to materialize keyword strings + numeric literal text from the
  ;; lexer's input cursor + scratch buffer; emit_*.wat uses them to
  ;; render i32 constants into output WAT text.
  ;;
  ;; $int_to_str writes digits right-to-left into a 12-byte scratch
  ;; buffer; $parse_int reads decimal text + optional leading '-'.

  ;; ─── Integer/String Conversion ────────────────────────────────────

  ;; Create a 1-byte string from a byte value
  (func $str_of_byte (param $b i32) (result i32)
    (local $ptr i32)
    (local.set $ptr (call $str_alloc (i32.const 1)))
    (i32.store8 (i32.add (local.get $ptr) (i32.const 4)) (local.get $b))
    (local.get $ptr))

  ;; Create a string from a data segment region
  (func $str_from_mem (param $addr i32) (param $len i32) (result i32)
    (local $ptr i32)
    (local.set $ptr (call $str_alloc (local.get $len)))
    (memory.copy
      (i32.add (local.get $ptr) (i32.const 4))
      (local.get $addr)
      (local.get $len))
    (local.get $ptr))

  ;; int_to_str: decimal representation of i32
  (func $int_to_str (param $n i32) (result i32)
    (local $buf i32) (local $pos i32) (local $neg i32)
    (local $digit i32) (local $len i32) (local $out i32)
    (if (i32.eqz (local.get $n))
      (then (return (call $str_of_byte (i32.const 48)))))  ;; "0"
    (local.set $neg (i32.const 0))
    (if (i32.lt_s (local.get $n) (i32.const 0))
      (then
        (local.set $neg (i32.const 1))
        (local.set $n (i32.sub (i32.const 0) (local.get $n)))))
    ;; Write digits right-to-left into a scratch buffer
    (local.set $buf (call $alloc (i32.const 12)))
    (local.set $pos (i32.const 11))
    (block $done
      (loop $digits
        (br_if $done (i32.eqz (local.get $n)))
        (local.set $digit (i32.rem_u (local.get $n) (i32.const 10)))
        (local.set $pos (i32.sub (local.get $pos) (i32.const 1)))
        (i32.store8
          (i32.add (local.get $buf) (local.get $pos))
          (i32.add (local.get $digit) (i32.const 48)))
        (local.set $n (i32.div_u (local.get $n) (i32.const 10)))
        (br $digits)))
    ;; Add minus sign if negative
    (if (local.get $neg)
      (then
        (local.set $pos (i32.sub (local.get $pos) (i32.const 1)))
        (i32.store8 (i32.add (local.get $buf) (local.get $pos)) (i32.const 45))))
    ;; Copy to string
    (local.set $len (i32.sub (i32.const 11) (local.get $pos)))
    (local.set $out (call $str_alloc (local.get $len)))
    (memory.copy
      (i32.add (local.get $out) (i32.const 4))
      (i32.add (local.get $buf) (local.get $pos))
      (local.get $len))
    (local.get $out))

  ;; parse_int: decimal string → i32
  (func $parse_int (param $s i32) (result i32)
    (local $slen i32) (local $i i32) (local $acc i32)
    (local $neg i32) (local $ch i32)
    (local.set $slen (call $str_len (local.get $s)))
    (if (i32.eqz (local.get $slen)) (then (return (i32.const 0))))
    (local.set $i (i32.const 0))
    (local.set $neg (i32.const 0))
    ;; Check leading minus
    (if (i32.eq (call $byte_at (local.get $s) (i32.const 0)) (i32.const 45))
      (then
        (local.set $neg (i32.const 1))
        (local.set $i (i32.const 1))))
    (local.set $acc (i32.const 0))
    (block $done
      (loop $parse
        (br_if $done (i32.ge_u (local.get $i) (local.get $slen)))
        (local.set $ch (call $byte_at (local.get $s) (local.get $i)))
        (br_if $done (i32.lt_u (local.get $ch) (i32.const 48)))
        (br_if $done (i32.gt_u (local.get $ch) (i32.const 57)))
        (local.set $acc
          (i32.add
            (i32.mul (local.get $acc) (i32.const 10))
            (i32.sub (local.get $ch) (i32.const 48))))
        (local.set $i (i32.add (local.get $i) (i32.const 1)))
        (br $parse)))
    (if (result i32) (local.get $neg)
      (then (i32.sub (i32.const 0) (local.get $acc)))
      (else (local.get $acc))))
