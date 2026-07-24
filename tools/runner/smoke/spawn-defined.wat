;; spawn smoke, Mentl's current emit shape: the shared memory is DEFINED in
;; the module and exported (emit_memory_decl), not imported. Re-instantiating
;; the module for a spawned thread therefore mints a FRESH memory per
;; instance — the children's adds land in their own memories, never the
;; parent's. Same program as spawn-import.wat otherwise. Measured meaning:
;; exit 0 = spawn ran but nothing shared (the emit-shape gap, banked for S3);
;; exit 42 would mean instances shared a defined memory (they do not).
(module
  (import "wasi" "thread-spawn" (func $spawn (param i32) (result i32)))
  (import "wasi_snapshot_preview1" "proc_exit" (func $proc_exit (param i32)))
  (memory (export "memory") 1 1 shared)

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
