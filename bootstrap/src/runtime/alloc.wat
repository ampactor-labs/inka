  ;; ═══ alloc.wat — bump allocator (Tier 0) ═══════════════════════════
  ;; Implements: Hβ §1.1 — HEAP_BASE invariant + 8-byte-aligned bump.
  ;; Exports:    $alloc
  ;; Uses:       $heap_ptr (global, Layer 0 shell)
  ;; Test:       runtime_test/alloc.wat (per-chunk fitness)
  ;;
  ;; HEAP_BASE = 4096 (sentinel region [0, 4096)); $heap_ptr starts at
  ;; 1 MiB (1048576). 8-byte-aligned monotonic bump; never frees.
  ;;
  ;; Per CLAUDE.md memory model + γ crystallization #8 (the heap has one
  ;; story): closures (closure.wat), continuations (cont.wat — H7),
  ;; ADT variants (record.wat), records, tuples, strings (str.wat),
  ;; lists (list.wat) ALL allocate through this surface. Arena handlers
  ;; (B.5 AM-arena-multishot — replay_safe / fork_deny / fork_copy) are
  ;; peer swaps that intercept this allocation at handler-install time
  ;; post-L1; the seed's bump_allocator is the default that arena
  ;; handlers narrow.

  ;; ─── Bump Allocator ───────────────────────────────────────────────
  (func $alloc (param $size i32) (result i32)
    (local $old i32)
    (local.set $old (global.get $heap_ptr))
    (global.set $heap_ptr
      (i32.and
        (i32.add
          (i32.add (global.get $heap_ptr) (local.get $size))
          (i32.const 7))
        (i32.const -8)))  ;; 8-byte alignment
    (local.get $old))
