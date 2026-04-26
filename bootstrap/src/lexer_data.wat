  ;; ═══ lexer_data.wat — keyword + output data segments (Layer 2) ════
  ;; Implements: lexer keyword string constants at fixed memory
  ;;             addresses [256, 512) + output format strings at
  ;;             [512, 4096). Read by lexer.wat's identifier-vs-
  ;;             keyword classifier + by the entry point's stdout
  ;;             reporting helpers.
  ;; Exports:    (data segments — addressed via $str_from_mem in int.wat)
  ;; Uses:       (memory.data only — no function dependencies)
  ;; Test:       runtime_test/lexer_data.wat (asserts string content
  ;;             at known addresses)
  ;;
  ;; Each entry: 4-byte little-endian length prefix + raw bytes.
  ;; Addresses chosen to fit within the [256, 4096) data region (the
  ;; HEAP_BASE-bounded sentinel space below the heap floor at 1 MiB).
  ;; Per CLAUDE.md memory model: HEAP_BASE = 4096; sentinel region
  ;; [0, 4096) holds (a) nullary ADT variant tags + (b) data-segment
  ;; constants like these.
  ;;
  ;; Wave 2.A factoring: these segments lived inline in inka.wat's
  ;; Layer 0+1 shell because the build.sh "extract shell" pattern
  ;; treated everything before ";; ─── TokenKind Sentinel IDs" as
  ;; shell. They are SEMANTICALLY lexer data — moved here as the
  ;; lexer's first chunk so build.sh assembles them before lexer.wat.

  ;; ─── Keyword strings for the lexer — [256, 512) ───────────────────
  ;; "fn" at 256
  (data (i32.const 256) "\02\00\00\00fn")
  ;; "let" at 264
  (data (i32.const 264) "\03\00\00\00let")
  ;; "if" at 272
  (data (i32.const 272) "\02\00\00\00if")
  ;; "else" at 280
  (data (i32.const 280) "\04\00\00\00else")
  ;; "match" at 288
  (data (i32.const 288) "\05\00\00\00match")
  ;; "type" at 296
  (data (i32.const 296) "\04\00\00\00type")
  ;; "effect" at 304
  (data (i32.const 304) "\06\00\00\00effect")
  ;; "handle" at 312
  (data (i32.const 312) "\06\00\00\00handle")
  ;; "handler" at 320
  (data (i32.const 320) "\07\00\00\00handler")
  ;; "with" at 332
  (data (i32.const 332) "\04\00\00\00with")
  ;; "resume" at 340
  (data (i32.const 340) "\06\00\00\00resume")
  ;; "perform" at 348
  (data (i32.const 348) "\07\00\00\00perform")
  ;; "for" at 360
  (data (i32.const 360) "\03\00\00\00for")
  ;; "in" at 368
  (data (i32.const 368) "\02\00\00\00in")
  ;; "loop" at 376
  (data (i32.const 376) "\04\00\00\00loop")
  ;; "break" at 384
  (data (i32.const 384) "\05\00\00\00break")
  ;; "continue" at 392
  (data (i32.const 392) "\08\00\00\00continue")
  ;; "return" at 404
  (data (i32.const 404) "\06\00\00\00return")
  ;; "import" at 412
  (data (i32.const 412) "\06\00\00\00import")
  ;; "where" at 420
  (data (i32.const 420) "\05\00\00\00where")
  ;; "own" at 428
  (data (i32.const 428) "\03\00\00\00own")
  ;; "ref" at 436
  (data (i32.const 436) "\03\00\00\00ref")
  ;; "capability" at 444
  (data (i32.const 444) "\0a\00\00\00capability")
  ;; "Pure" at 456
  (data (i32.const 456) "\04\00\00\00Pure")
  ;; "true" at 464
  (data (i32.const 464) "\04\00\00\00true")
  ;; "false" at 472
  (data (i32.const 472) "\05\00\00\00false")

  ;; ─── Output format strings — [512, 4096) ──────────────────────────
  ;; " tokens, " at 512 (9 bytes)
  (data (i32.const 512) " tokens, ")
  ;; " stmts" at 528 (6 bytes)
  (data (i32.const 528) " stmts")
