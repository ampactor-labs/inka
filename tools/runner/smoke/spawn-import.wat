;; spawn smoke, wasi-threads convention: the shared memory is IMPORTED, so
;; every instance (main + spawned) reads one memory. Six threads each add 7
;; to the counter at address 16; main waits for 42 and exits with the value.
;; Expected exit: 42. A failed spawn exits 99; a sharing failure exits with
;; whatever the bounded wait last observed (0 when nothing arrives).
(module
  (import "env" "memory" (memory 1 1 shared))
  (import "wasi" "thread-spawn" (func $spawn (param i32) (result i32)))
  (import "wasi_snapshot_preview1" "proc_exit" (func $proc_exit (param i32)))
  ;; WASI p1 host fns locate guest memory through the "memory" export, so the
  ;; imported memory is re-exported (the WASI command ABI).
  (export "memory" (memory 0))

  (func (export "wasi_thread_start") (param $tid i32) (param $arg i32)
    (drop (i32.atomic.rmw.add (local.get $arg) (i32.const 7))))

  (func (export "_start")
    (local $i i32)
    (local.set $i (i32.const 0))
    (block $spawned
      (loop $l
        (br_if $spawned (i32.ge_s (local.get $i) (i32.const 6)))
        (if (i32.lt_s (call $spawn (i32.const 16)) (i32.const 0))
          (then (call $proc_exit (i32.const 99))))
        (local.set $i (i32.add (local.get $i) (i32.const 1)))
        (br $l)))
    (local.set $i (i32.const 0))
    (block $ready
      (loop $w
        (br_if $ready (i32.eq (i32.atomic.load (i32.const 16)) (i32.const 42)))
        (local.set $i (i32.add (local.get $i) (i32.const 1)))
        (br_if $ready (i32.gt_s (local.get $i) (i32.const 200000000)))
        (br $w)))
    (call $proc_exit (i32.atomic.load (i32.const 16))))
)
