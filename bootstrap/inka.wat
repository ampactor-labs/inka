;; inka.wat - The Reference Seed Compiler (Tier 1 Runtime)
;; 
;; HEAP_BASE invariant: 4096 (0x1000)
;; Nullary sentinel values: [0, 4096)
;; Allocated records: >= 4096
;; Memory is bump-allocated starting at 1_048_576 (1 MiB)

(module
  ;; ─── WASI Imports ────────────────────────────────────────────────────────
  (import "wasi_snapshot_preview1" "fd_read" 
    (func $wasi_fd_read (param i32 i32 i32 i32) (result i32)))
  (import "wasi_snapshot_preview1" "fd_write" 
    (func $wasi_fd_write (param i32 i32 i32 i32) (result i32)))
  (import "wasi_snapshot_preview1" "fd_close" 
    (func $wasi_fd_close (param i32) (result i32)))
  (import "wasi_snapshot_preview1" "path_open" 
    (func $wasi_path_open (param i32 i32 i32 i32 i32 i64 i64 i32 i32) (result i32)))
  (import "wasi_snapshot_preview1" "proc_exit" 
    (func $wasi_proc_exit (param i32)))
  
  ;; ─── Memory & Globals ────────────────────────────────────────────────────
  (memory (export "memory") 1)
  
  (global $heap_base i32 (i32.const 4096))
  (global $heap_ptr (mut i32) (i32.const 1048576))
  
  ;; ─── Allocator ───────────────────────────────────────────────────────────
  ;; $alloc(size) -> pointer
  ;; Advances $heap_ptr by size, rounded up to 8-byte boundary.
  (func $alloc (param $size i32) (result i32)
    (local $old i32)
    (local.set $old (global.get $heap_ptr))
    
    (global.set $heap_ptr 
      (i32.and 
        (i32.add 
          (i32.add (global.get $heap_ptr) (local.get $size))
          (i32.const 7)
        )
        (i32.const 0xFFFFFFF8)  ;; 8-byte alignment mask
      )
    )
    
    (local.get $old)
  )

  ;; ─── String Primitives ───────────────────────────────────────────────────
  ;; Layout: [length: i32] [bytes...]
  
  (func $str_alloc (param $len i32) (result i32)
    (local $ptr i32)
    (local.set $ptr (call $alloc (i32.add (local.get $len) (i32.const 4))))
    (i32.store (local.get $ptr) (local.get $len))
    (local.get $ptr)
  )

  (func $str_len (param $ptr i32) (result i32)
    (i32.load (local.get $ptr))
  )

  (func $str_concat (param $a i32) (param $b i32) (result i32)
    (local $len_a i32)
    (local $len_b i32)
    (local $total_len i32)
    (local $out i32)
    
    (local.set $len_a (call $str_len (local.get $a)))
    (local.set $len_b (call $str_len (local.get $b)))
    (local.set $total_len (i32.add (local.get $len_a) (local.get $len_b)))
    
    (local.set $out (call $str_alloc (local.get $total_len)))
    
    ;; Copy a
    (memory.copy 
      (i32.add (local.get $out) (i32.const 4))
      (i32.add (local.get $a) (i32.const 4))
      (local.get $len_a))
      
    ;; Copy b
    (memory.copy 
      (i32.add (local.get $out) (i32.add (local.get $len_a) (i32.const 4)))
      (i32.add (local.get $b) (i32.const 4))
      (local.get $len_b))
      
    (local.get $out)
  )

  (func $str_eq (param $a i32) (param $b i32) (result i32)
    (local $len_a i32)
    (local $len_b i32)
    (local $i i32)
    
    (local.set $len_a (call $str_len (local.get $a)))
    (local.set $len_b (call $str_len (local.get $b)))
    
    (if (i32.ne (local.get $len_a) (local.get $len_b))
      (then (return (i32.const 0)))
    )
    
    (local.set $i (i32.const 0))
    (loop $cmp
      (if (i32.ge_u (local.get $i) (local.get $len_a))
        (then (return (i32.const 1)))
      )
      
      (if (i32.ne 
            (i32.load8_u (i32.add (local.get $a) (i32.add (i32.const 4) (local.get $i))))
            (i32.load8_u (i32.add (local.get $b) (i32.add (i32.const 4) (local.get $i))))
          )
        (then (return (i32.const 0)))
      )
      
      (local.set $i (i32.add (local.get $i) (i32.const 1)))
      (br $cmp)
    )
    
    (i32.const 1)
  )

  ;; ─── List Primitives ─────────────────────────────────────────────────────
  ;; Tagged Layout:
  ;; offset 0: tag (0=flat, 1=snoc, etc.)
  ;; offset 4: variant-specific payload (for flat: length, for snoc: left_ptr)
  ;; offset 8+: (for flat: elements, for snoc: right_ptr)

  (func $list_alloc_flat (param $len i32) (result i32)
    (local $ptr i32)
    ;; size = 8 + len * 4 (tag + length + elements)
    (local.set $ptr (call $alloc (i32.add (i32.const 8) (i32.mul (local.get $len) (i32.const 4)))))
    ;; Tag = 0 (flat)
    (i32.store (local.get $ptr) (i32.const 0))
    ;; Length = len
    (i32.store offset=4 (local.get $ptr) (local.get $len))
    (local.get $ptr)
  )

  (func $list_len (param $ptr i32) (result i32)
    ;; Assumes flat list for now.
    (i32.load offset=4 (local.get $ptr))
  )

  (func $list_index (param $ptr i32) (param $index i32) (result i32)
    (i32.load 
      (i32.add 
        (i32.add (local.get $ptr) (i32.const 8)) 
        (i32.mul (local.get $index) (i32.const 4))))
  )

  (func $list_set (param $ptr i32) (param $index i32) (param $val i32) (result i32)
    (i32.store 
      (i32.add 
        (i32.add (local.get $ptr) (i32.const 8)) 
        (i32.mul (local.get $index) (i32.const 4)))
      (local.get $val))
    (local.get $ptr)
  )

  ;; ─── Record / Tuple Primitives ───────────────────────────────────────────
  ;; Layout: [tag/type: i32] [arity: i32] [fields...]
  (func $make_record_sorted (param $tag i32) (param $arity i32) (result i32)
    (local $ptr i32)
    (local.set $ptr (call $alloc (i32.add (i32.const 8) (i32.mul (local.get $arity) (i32.const 4)))))
    (i32.store (local.get $ptr) (local.get $tag))
    (i32.store offset=4 (local.get $ptr) (local.get $arity))
    (local.get $ptr)
  )

  (func $record_get_field (param $ptr i32) (param $index i32) (result i32)
    (i32.load 
      (i32.add 
        (i32.add (local.get $ptr) (i32.const 8)) 
        (i32.mul (local.get $index) (i32.const 4))))
  )

  (func $record_set_field (param $ptr i32) (param $index i32) (param $val i32)
    (i32.store 
      (i32.add 
        (i32.add (local.get $ptr) (i32.const 8)) 
        (i32.mul (local.get $index) (i32.const 4)))
      (local.get $val))
  )

  ;; ─── Handler Dispatch / Closure Primitives ───────────────────────────────
  ;; Layout: [tag: i32] [fn_index: i32] [slots...]
  ;; Slots are used for both captures and evidence.
  
  (func $make_closure (param $tag i32) (param $fn_idx i32) (param $num_slots i32) (result i32)
    (local $ptr i32)
    ;; size = 8 + num_slots * 4
    (local.set $ptr (call $alloc (i32.add (i32.const 8) (i32.mul (local.get $num_slots) (i32.const 4)))))
    (i32.store (local.get $ptr) (local.get $tag))
    (i32.store offset=4 (local.get $ptr) (local.get $fn_idx))
    (local.get $ptr)
  )

  (func $closure_get_slot (param $ptr i32) (param $index i32) (result i32)
    (i32.load 
      (i32.add 
        (i32.add (local.get $ptr) (i32.const 8)) 
        (i32.mul (local.get $index) (i32.const 4))))
  )

  (func $closure_set_slot (param $ptr i32) (param $index i32) (param $val i32)
    (i32.store 
      (i32.add 
        (i32.add (local.get $ptr) (i32.const 8)) 
        (i32.mul (local.get $index) (i32.const 4)))
      (local.get $val))
  )

  ;; At a polymorphic perform site, the compiler emits:
  ;; (call_indirect (type $sig) <args> (call $closure_get_slot (local.get $closure) (i32.const <slot>)))

  ;; ─── Main Entry Point ────────────────────────────────────────────────────
  (func $main (export "_start")
    (call $wasi_proc_exit (i32.const 0))
  )
)
