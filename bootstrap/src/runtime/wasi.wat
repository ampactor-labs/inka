  ;; ═══ wasi.wat — WASI preview1 I/O wrappers (Tier 1) ═══════════════
  ;; Implements: Hβ §1.15 — WASI preview1 stdout/stderr/stdin helpers
  ;;             over the imported wasi_snapshot_preview1 functions
  ;;             (Layer 0 shell declares the imports).
  ;; Exports:    $print_string, $eprint_string, $read_all_stdin
  ;; Uses:       $alloc (alloc.wat), $str_alloc (str.wat),
  ;;             $str_len (str.wat), $str_concat (str.wat),
  ;;             $wasi_fd_read, $wasi_fd_write (Layer 0 imports)
  ;; Test:       runtime_test/wasi.wat
  ;;
  ;; WASI preview1 surface (per CLAUDE.md WASM-as-substrate + plan §21):
  ;;   fd_write, fd_read, fd_close, path_open, proc_exit
  ;; Filesystem extensions (path_create_directory / fd_readdir /
  ;; path_filestat_get / path_unlink_file / path_rename) live in
  ;; wasi_fs.wat per the FX walkthrough composition arc.
  ;;
  ;; iov scratch is allocated inline (one $alloc per call). Per
  ;; lib/runtime/io.nx VFINAL: scratch convention; bump allocator
  ;; recovers all on next session reset (none — bump is monotonic, but
  ;; iov use is small).

  ;; ─── WASI I/O Wrappers ────────────────────────────────────────────

  ;; Print a string (len-prefixed) to stdout (fd 1)
  (func $print_string (param $s i32)
    (local $iovs i32) (local $nwritten i32)
    (local.set $iovs (call $alloc (i32.const 8)))
    (i32.store (local.get $iovs)
      (i32.add (local.get $s) (i32.const 4)))  ;; iov_base = past length prefix
    (i32.store offset=4 (local.get $iovs)
      (call $str_len (local.get $s)))           ;; iov_len
    (local.set $nwritten (call $alloc (i32.const 4)))
    (drop (call $wasi_fd_write
      (i32.const 1) (local.get $iovs) (i32.const 1) (local.get $nwritten))))

  ;; Print to stderr (fd 2)
  (func $eprint_string (param $s i32)
    (local $iovs i32) (local $nwritten i32)
    (local.set $iovs (call $alloc (i32.const 8)))
    (i32.store (local.get $iovs)
      (i32.add (local.get $s) (i32.const 4)))
    (i32.store offset=4 (local.get $iovs)
      (call $str_len (local.get $s)))
    (local.set $nwritten (call $alloc (i32.const 4)))
    (drop (call $wasi_fd_write
      (i32.const 2) (local.get $iovs) (i32.const 1) (local.get $nwritten))))

  ;; Read all of stdin into a single string. Loops until EOF.
  (func $read_all_stdin (result i32)
    (local $chunk_buf i32)   ;; raw read buffer
    (local $iovs i32)
    (local $nread_ptr i32)
    (local $nread i32)
    (local $result i32)      ;; accumulated string
    (local $chunk_str i32)
    ;; Pre-allocate read infrastructure
    (local.set $chunk_buf (call $alloc (i32.const 65536)))
    (local.set $iovs (call $alloc (i32.const 8)))
    (local.set $nread_ptr (call $alloc (i32.const 4)))
    ;; Start with empty string
    (local.set $result (call $str_alloc (i32.const 0)))
    (block $eof
      (loop $read_loop
        ;; Set up iovec: buf ptr, buf len
        (i32.store (local.get $iovs) (local.get $chunk_buf))
        (i32.store offset=4 (local.get $iovs) (i32.const 65536))
        ;; Read
        (drop (call $wasi_fd_read
          (i32.const 0) (local.get $iovs) (i32.const 1) (local.get $nread_ptr)))
        (local.set $nread (i32.load (local.get $nread_ptr)))
        ;; EOF when nread == 0
        (br_if $eof (i32.eqz (local.get $nread)))
        ;; Wrap chunk bytes in a string
        (local.set $chunk_str (call $str_alloc (local.get $nread)))
        (memory.copy
          (i32.add (local.get $chunk_str) (i32.const 4))
          (local.get $chunk_buf)
          (local.get $nread))
        ;; Concat to result
        (local.set $result (call $str_concat (local.get $result) (local.get $chunk_str)))
        (br $read_loop)))
    (local.get $result))
