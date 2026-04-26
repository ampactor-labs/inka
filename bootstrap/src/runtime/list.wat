  ;; ═══ list.wat — tagged list primitives (Tier 1) ═══════════════════
  ;; Implements: Hβ §1.7 — tagged list layout [count:i32][tag:i32][...].
  ;; Exports:    $make_list, $len, $list_index, $list_set,
  ;;             $list_extend_to, $slice
  ;; Uses:       $alloc (alloc.wat)
  ;; Test:       runtime_test/list.wat
  ;;
  ;; Layout per CLAUDE.md representations:
  ;;   tag 0 = flat   [count:i32][tag:i32][elements i32 each]
  ;;   tag 1 = snoc   [count:i32][tag:i32][tail:ptr][head:i32]   (Tier 2 dispatch)
  ;;   tag 3 = concat [count:i32][tag:i32][left:ptr][right:ptr]  (Tier 2 dispatch)
  ;;   tag 4 = slice  [count:i32][tag:i32][base:ptr][start:i32]  (Tier 2 dispatch)
  ;;
  ;; Wave 2.A factoring: this chunk preserves the existing FLAT-only
  ;; $list_index dispatch (tag check is performed but only flat access
  ;; is used; tags 1/3/4 fall through). Wave 2.B extends to full tag
  ;; dispatch per Hβ §1.7. Both layers are needed for bootstrap to
  ;; compile any src/*.nx file that exercises non-flat list shapes
  ;; (lib/runtime/lists.nx's snoc/concat/slice arms).
  ;;
  ;; $list_extend_to is the buffer-counter substrate primitive (Ω.3)
  ;; — load-bearing across graph/trail/overlay arrays per spec 00.

  ;; ─── List Primitives ──────────────────────────────────────────────
  ;; Layout: [count:i32][tag:i32][payload...]

  ;; make_list: allocate flat tag=0 list with count slots
  (func $make_list (param $count i32) (result i32)
    (local $ptr i32)
    (local.set $ptr (call $alloc
      (i32.add (i32.const 8) (i32.mul (local.get $count) (i32.const 4)))))
    (i32.store (local.get $ptr) (local.get $count))
    (i32.store offset=4 (local.get $ptr) (i32.const 0))  ;; tag=0 flat
    (local.get $ptr))

  ;; len: read count field
  (func $len (param $list i32) (result i32)
    (i32.load (local.get $list)))

  ;; list_index: read element at index (flat tag=0 only for now)
  (func $list_index (param $list i32) (param $i i32) (result i32)
    (local $tag i32)
    (local.set $tag (i32.load offset=4 (local.get $list)))
    ;; tag 0: direct indexed access
    (i32.load
      (i32.add
        (i32.add (local.get $list) (i32.const 8))
        (i32.mul (local.get $i) (i32.const 4)))))

  ;; list_set: write val at index, return list ptr
  (func $list_set (param $list i32) (param $idx i32) (param $val i32) (result i32)
    (i32.store
      (i32.add
        (i32.add (local.get $list) (i32.const 8))
        (i32.mul (local.get $idx) (i32.const 4)))
      (local.get $val))
    (local.get $list))

  ;; list_extend_to: ensure capacity >= min_size
  (func $list_extend_to (param $list i32) (param $min_size i32) (result i32)
    (local $cur i32) (local $new_cap i32) (local $fresh i32) (local $i i32)
    (local.set $cur (call $len (local.get $list)))
    (if (result i32) (i32.ge_u (local.get $cur) (local.get $min_size))
      (then (local.get $list))
      (else
        ;; double or min_size, whichever is larger
        (local.set $new_cap (i32.mul (local.get $cur) (i32.const 2)))
        (if (i32.gt_u (local.get $min_size) (local.get $new_cap))
          (then (local.set $new_cap (local.get $min_size))))
        (local.set $fresh (call $make_list (local.get $new_cap)))
        ;; copy existing elements
        (local.set $i (i32.const 0))
        (block $done
          (loop $copy
            (br_if $done (i32.ge_u (local.get $i) (local.get $cur)))
            (drop (call $list_set (local.get $fresh) (local.get $i)
              (call $list_index (local.get $list) (local.get $i))))
            (local.set $i (i32.add (local.get $i) (i32.const 1)))
            (br $copy)))
        (local.get $fresh))))

  ;; slice: create a tag=4 view into list[start..end)
  (func $slice (param $list i32) (param $start i32) (param $end i32) (result i32)
    (local $total i32) (local $new_len i32) (local $result i32) (local $i i32)
    (local.set $total (call $len (local.get $list)))
    ;; clamp
    (if (i32.lt_s (local.get $start) (i32.const 0))
      (then (local.set $start (i32.const 0))))
    (if (i32.gt_s (local.get $start) (local.get $total))
      (then (local.set $start (local.get $total))))
    (if (i32.lt_s (local.get $end) (local.get $start))
      (then (local.set $end (local.get $start))))
    (if (i32.gt_s (local.get $end) (local.get $total))
      (then (local.set $end (local.get $total))))
    (local.set $new_len (i32.sub (local.get $end) (local.get $start)))
    (if (result i32) (i32.le_s (local.get $new_len) (i32.const 0))
      (then (call $make_list (i32.const 0)))
      (else
        ;; Flat copy: allocate new list and copy elements one by one
        (local.set $result (call $make_list (local.get $new_len)))
        (local.set $i (i32.const 0))
        (block $done (loop $cp
          (br_if $done (i32.ge_u (local.get $i) (local.get $new_len)))
          (drop (call $list_set (local.get $result) (local.get $i)
            (call $list_index (local.get $list)
              (i32.add (local.get $start) (local.get $i)))))
          (local.set $i (i32.add (local.get $i) (i32.const 1)))
          (br $cp)))
        (local.get $result))))
