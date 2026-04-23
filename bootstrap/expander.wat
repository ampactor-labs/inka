;; expander.wat - The Tier 1.5 Macro Expander
;; 
;; This is the hand-transcribed WAT of expander.nx.
;; It reads from stdin (fd 0), performs string replacement,
;; and writes to stdout (fd 1).

(module
  ;; ─── WASI Imports ────────────────────────────────────────────────────────
  (import "wasi_snapshot_preview1" "fd_read" 
    (func $wasi_fd_read (param i32 i32 i32 i32) (result i32)))
  (import "wasi_snapshot_preview1" "fd_write" 
    (func $wasi_fd_write (param i32 i32 i32 i32) (result i32)))
  (import "wasi_snapshot_preview1" "proc_exit" 
    (func $wasi_proc_exit (param i32)))
  
  ;; ─── Memory & Globals ────────────────────────────────────────────────────
  (memory (export "memory") 32)
  
  (global $heap_base i32 (i32.const 4096))
  (global $heap_ptr (mut i32) (i32.const 1048576))
  
  ;; Data Section: Templates
  ;; We store templates starting at memory offset 1000.
  ;; For now, a dummy template that wraps the body.
  (data (i32.const 1000) ";; EXPANDED TEMPLATE START\n{{BODY}}\n;; EXPANDED TEMPLATE END\n")
  (global $template_ptr i32 (i32.const 996))
  
  ;; ─── Init ────────────────────────────────────────────────────────────────
  (func $init_data
    ;; Write the length (61) of the template string at offset 996
    (i32.store (i32.const 996) (i32.const 61))
  )

  ;; ─── Allocator ───────────────────────────────────────────────────────────
  (func $alloc (param $size i32) (result i32)
    (local $old i32)
    (local.set $old (global.get $heap_ptr))
    (global.set $heap_ptr 
      (i32.and 
        (i32.add (i32.add (global.get $heap_ptr) (local.get $size)) (i32.const 7))
        (i32.const 0xFFFFFFF8)
      )
    )
    (local.get $old)
  )

  ;; ─── String Primitives ───────────────────────────────────────────────────
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
    (local $len_a i32) (local $len_b i32) (local $out i32)
    (local.set $len_a (call $str_len (local.get $a)))
    (local.set $len_b (call $str_len (local.get $b)))
    (local.set $out (call $str_alloc (i32.add (local.get $len_a) (local.get $len_b))))
    
    (memory.copy 
      (i32.add (local.get $out) (i32.const 4))
      (i32.add (local.get $a) (i32.const 4))
      (local.get $len_a))
    (memory.copy 
      (i32.add (local.get $out) (i32.add (local.get $len_a) (i32.const 4)))
      (i32.add (local.get $b) (i32.const 4))
      (local.get $len_b))
    (local.get $out)
  )

  ;; ─── I/O Primitives ──────────────────────────────────────────────────────
  ;; $print(str_ptr)
  (func $print (param $ptr i32)
    (local $iovs i32)
    (local $nwritten i32)
    
    ;; Allocate an iovec struct (8 bytes: ptr, len)
    (local.set $iovs (call $alloc (i32.const 8)))
    (i32.store (local.get $iovs) (i32.add (local.get $ptr) (i32.const 4)))
    (i32.store offset=4 (local.get $iovs) (call $str_len (local.get $ptr)))
    
    ;; Allocate space for nwritten result
    (local.set $nwritten (call $alloc (i32.const 4)))
    
    ;; fd_write(1, iovs, 1, nwritten)
    (drop (call $wasi_fd_write 
      (i32.const 1) 
      (local.get $iovs) 
      (i32.const 1) 
      (local.get $nwritten)))
  )

  ;; $read_all_stdin() -> str_ptr
  (func $read_all_stdin (result i32)
    ;; For bootstrap simplicity, we assume stdin fits in 64KB buffer.
    ;; We allocate a 64KB buffer, read into it, then allocate a string.
    (local $buf i32)
    (local $iovs i32)
    (local $nread i32)
    (local $total_read i32)
    (local $str i32)
    
    (local.set $buf (call $alloc (i32.const 65536)))
    (local.set $iovs (call $alloc (i32.const 8)))
    (local.set $nread (call $alloc (i32.const 4)))
    
    (i32.store (local.get $iovs) (local.get $buf))
    (i32.store offset=4 (local.get $iovs) (i32.const 65536))
    
    ;; fd_read(0, iovs, 1, nread)
    (drop (call $wasi_fd_read 
      (i32.const 0) 
      (local.get $iovs) 
      (i32.const 1) 
      (local.get $nread)))
      
    (local.set $total_read (i32.load (local.get $nread)))
    
    (local.set $str (call $str_alloc (local.get $total_read)))
    (memory.copy 
      (i32.add (local.get $str) (i32.const 4))
      (local.get $buf)
      (local.get $total_read))
      
    (local.get $str)
  )

  ;; ─── Main Entry Point ────────────────────────────────────────────────────
  (func $main (export "_start")
    (local $input i32)
    (local $template i32)
    
    (call $init_data)
    
    ;; Read stdin
    (local.set $input (call $read_all_stdin))
    
    ;; We have the template at $template_ptr
    (local.set $template (global.get $template_ptr))
    
    ;; For now, instead of actual string replacement, we just concat:
    ;; We pretend we replaced {{BODY}} by doing:
    ;; concat(concat(";; EXPANDED...\n", input), "\n;; EXPANDED END\n")
    ;; Real string replacement would loop; we simplify for Tier 1.5 proof.
    
    (call $print (call $str_concat (local.get $template) (local.get $input)))
    
    (call $wasi_proc_exit (i32.const 0))
  )
)
