  ;; ─── Main Lex Loop ─────────────────────────────────────────────────
  ;; $lex is the entry wrapper; $lex_from is the re-entrant loop —
  ;; mirror of wheel src/lexer.mn lex_from(source, n, pos, line, col,
  ;; buf, count, term_byte, depth). term_byte=125 terminates on the
  ;; first `}` at depth 0 (string-splice lexing); depth tracks brace
  ;; nesting. Returns a 4-tuple (pos, col, buf, count).

  (func $lex (param $source i32) (result i32)
    (local $n i32) (local $cap i32) (local $buf i32)
    (local $r4 i32) (local $tup i32)
    (local.set $n (call $byte_len (local.get $source)))
    (local.set $cap (if (result i32) (i32.lt_u (local.get $n) (i32.const 16))
      (then (i32.const 16)) (else (local.get $n))))
    (local.set $buf (call $make_list (local.get $cap)))
    (local.set $r4 (call $lex_from (local.get $source) (local.get $n)
      (i32.const 0) (i32.const 1) (i32.const 1)
      (local.get $buf) (i32.const 0) (i32.const 0) (i32.const 0)))
    ;; Legacy (buf, count) 2-tuple for existing consumers.
    (local.set $tup (call $make_list (i32.const 2)))
    (drop (call $list_set (local.get $tup) (i32.const 0)
      (call $list_index (local.get $r4) (i32.const 2))))
    (drop (call $list_set (local.get $tup) (i32.const 1)
      (call $list_index (local.get $r4) (i32.const 3))))
    (local.get $tup))

  (func $lex_from (param $source i32) (param $n i32) (param $pos i32)
                  (param $line i32) (param $col i32)
                  (param $buf i32) (param $count i32)
                  (param $term_byte i32) (param $depth i32) (result i32)
    (local $b i32) (local $b2 i32)
    (local $new_pos i32) (local $word i32) (local $kind i32)
    (local $kw_result i32) (local $tok i32) (local $tup i32)
    (local $op_result i32) (local $str_val i32)
    (local $after i32) (local $end_col i32)
    (local $r4 i32)

    (block $exit
      (loop $main_loop
        ;; Check EOF
        (if (i32.ge_u (local.get $pos) (local.get $n))
          (then
            ;; Push TEof token
            (local.set $tok (call $mk_tok (i32.const 69)
              (local.get $line) (local.get $col) (local.get $line) (local.get $col)))
            (local.set $tup (call $push_tok (local.get $buf) (local.get $count) (local.get $tok)))
            (local.set $buf (call $list_index (local.get $tup) (i32.const 0)))
            (local.set $count (call $list_index (local.get $tup) (i32.const 1)))
            (br $exit)))

        (local.set $b (call $byte_at (local.get $source) (local.get $pos)))

        ;; Whitespace (space, tab, CR) — skip
        (if (call $is_whitespace (local.get $b))
          (then
            (local.set $pos (i32.add (local.get $pos) (i32.const 1)))
            (local.set $col (i32.add (local.get $col) (i32.const 1)))
            (br $main_loop)))

        ;; Newline
        (if (i32.eq (local.get $b) (i32.const 10))
          (then
            (local.set $tok (call $mk_tok (i32.const 68)
              (local.get $line) (local.get $col)
              (i32.add (local.get $line) (i32.const 1)) (i32.const 1)))
            (local.set $tup (call $push_tok (local.get $buf) (local.get $count) (local.get $tok)))
            (local.set $buf (call $list_index (local.get $tup) (i32.const 0)))
            (local.set $count (call $list_index (local.get $tup) (i32.const 1)))
            (local.set $pos (i32.add (local.get $pos) (i32.const 1)))
            (local.set $line (i32.add (local.get $line) (i32.const 1)))
            (local.set $col (i32.const 1))
            (br $main_loop)))

        ;; Comment: // or ///
        (if (i32.and
              (i32.eq (local.get $b) (i32.const 47))
              (i32.and
                (i32.lt_u (i32.add (local.get $pos) (i32.const 1)) (local.get $n))
                (i32.eq (call $byte_at (local.get $source)
                  (i32.add (local.get $pos) (i32.const 1))) (i32.const 47))))
          (then
            ;; Check for /// doc comment
            (if (i32.and
                  (i32.lt_u (i32.add (local.get $pos) (i32.const 2)) (local.get $n))
                  (i32.eq (call $byte_at (local.get $source)
                    (i32.add (local.get $pos) (i32.const 2))) (i32.const 47)))
              (then
                ;; Doc comment — capture text until EOL
                (local.set $after (call $scan_to_eol (local.get $source) (local.get $n)
                  (i32.add (local.get $pos) (i32.const 3))))
                (local.set $str_val (call $str_slice (local.get $source)
                  (i32.add (local.get $pos) (i32.const 3)) (local.get $after)))
                (local.set $end_col (i32.add (local.get $col)
                  (i32.sub (local.get $after) (local.get $pos))))
                (local.set $tok (call $mk_tok
                  (call $mk_TDocComment (local.get $str_val))
                  (local.get $line) (local.get $col) (local.get $line) (local.get $end_col)))
                (local.set $tup (call $push_tok (local.get $buf) (local.get $count) (local.get $tok)))
                (local.set $buf (call $list_index (local.get $tup) (i32.const 0)))
                (local.set $count (call $list_index (local.get $tup) (i32.const 1)))
                (local.set $pos (local.get $after))
                (local.set $col (local.get $end_col)))
              (else
                ;; Regular comment — skip to EOL
                (local.set $pos (call $scan_to_eol (local.get $source) (local.get $n)
                  (i32.add (local.get $pos) (i32.const 2))))))
            (br $main_loop)))

        ;; String literal (byte 34 = ")
        ;; Interpolating-or-brace-doubled strings route through
        ;; $scan_dq_string (TStringPart/TStringSplice mirror of wheel
        ;; scan_string); pure-plain strings keep the proven TString
        ;; path below — zero churn for the corpus's plain strings.
        (if (i32.and (i32.eq (local.get $b) (i32.const 34))
                     (call $dq_needs_interp (local.get $source) (local.get $n)
                       (i32.add (local.get $pos) (i32.const 1))))
          (then
            (local.set $r4 (call $scan_dq_string (local.get $source) (local.get $n)
              (i32.add (local.get $pos) (i32.const 1))
              (local.get $line) (i32.add (local.get $col) (i32.const 1))
              (local.get $buf) (local.get $count)))
            (local.set $pos   (call $list_index (local.get $r4) (i32.const 0)))
            (local.set $col   (call $list_index (local.get $r4) (i32.const 1)))
            (local.set $buf   (call $list_index (local.get $r4) (i32.const 2)))
            (local.set $count (call $list_index (local.get $r4) (i32.const 3)))
            (br $main_loop)))
        (if (i32.eq (local.get $b) (i32.const 34))
          (then
            (local.set $new_pos (call $scan_string_end (local.get $source) (local.get $n)
              (i32.add (local.get $pos) (i32.const 1))))
            ;; Extract string content (between quotes), decoding escapes.
            ;; Per Hβ.first-light.lexer-string-escape-substrate (2026-05-07):
            ;; SYNTAX.md §1077 specifies escape codes \n \r \t \\ \" \0;
            ;; lexer projects source bytes → resolved bytes for the graph.
            ;; Without this, "Hello\n" stored bytes [..., 0x5c, 0x6e]
            ;; instead of [..., 0x0a]; emit's data-segment bytes wrong.
            (local.set $str_val (call $str_unescape (local.get $source)
              (i32.add (local.get $pos) (i32.const 1))
              (i32.sub (local.get $new_pos) (i32.const 1))))
            (local.set $end_col (i32.add (local.get $col)
              (i32.sub (local.get $new_pos) (local.get $pos))))
            (local.set $tok (call $mk_tok
              (call $mk_TString (local.get $str_val))
              (local.get $line) (local.get $col) (local.get $line) (local.get $end_col)))
            (local.set $tup (call $push_tok (local.get $buf) (local.get $count) (local.get $tok)))
            (local.set $buf (call $list_index (local.get $tup) (i32.const 0)))
            (local.set $count (call $list_index (local.get $tup) (i32.const 1)))
            (local.set $pos (local.get $new_pos))
            (local.set $col (local.get $end_col))
            (br $main_loop)))

        ;; Number
        (if (call $is_digit (local.get $b))
          (then
            (local.set $new_pos (call $scan_number (local.get $source) (local.get $n)
              (local.get $pos)))
            (local.set $str_val (call $str_slice (local.get $source)
              (local.get $pos) (local.get $new_pos)))
            (local.set $end_col (i32.add (local.get $col)
              (i32.sub (local.get $new_pos) (local.get $pos))))
            ;; Per H.3.b: if the slice contains `.`, `e`, or `E`, it's a
            ;; float literal; emit TFloat carrying the raw text. Else TInt.
            (if (call $contains_float_marker (local.get $str_val))
              (then
                (local.set $tok (call $mk_tok
                  (call $mk_TFloat (local.get $str_val))
                  (local.get $line) (local.get $col) (local.get $line) (local.get $end_col))))
              (else
                (local.set $tok (call $mk_tok
                  (call $mk_TInt (call $parse_int (local.get $str_val)))
                  (local.get $line) (local.get $col) (local.get $line) (local.get $end_col)))))
            (local.set $tup (call $push_tok (local.get $buf) (local.get $count) (local.get $tok)))
            (local.set $buf (call $list_index (local.get $tup) (i32.const 0)))
            (local.set $count (call $list_index (local.get $tup) (i32.const 1)))
            (local.set $pos (local.get $new_pos))
            (local.set $col (local.get $end_col))
            (br $main_loop)))

        ;; Identifier or keyword
        (if (call $is_alpha (local.get $b))
          (then
            (local.set $new_pos (call $scan_ident (local.get $source) (local.get $n)
              (local.get $pos)))
            (local.set $word (call $str_slice (local.get $source)
              (local.get $pos) (local.get $new_pos)))
            (local.set $end_col (i32.add (local.get $col)
              (i32.sub (local.get $new_pos) (local.get $pos))))
            ;; Check keyword
            (local.set $kw_result (call $keyword_kind (local.get $word)))
            (if (i32.eq (local.get $kw_result) (i32.const 70))
              (then
                ;; Not a keyword — TIdent
                (local.set $kind (call $mk_TIdent (local.get $word))))
              (else
                ;; Keyword — extract sentinel from Some
                (local.set $kind (i32.load offset=4 (local.get $kw_result)))))
            (local.set $tok (call $mk_tok (local.get $kind)
              (local.get $line) (local.get $col) (local.get $line) (local.get $end_col)))
            (local.set $tup (call $push_tok (local.get $buf) (local.get $count) (local.get $tok)))
            (local.set $buf (call $list_index (local.get $tup) (i32.const 0)))
            (local.set $count (call $list_index (local.get $tup) (i32.const 1)))
            (local.set $pos (local.get $new_pos))
            (local.set $col (local.get $end_col))
            (br $main_loop)))

        ;; Two-char operators
        (local.set $b2 (if (result i32)
          (i32.lt_u (i32.add (local.get $pos) (i32.const 1)) (local.get $n))
          (then (call $byte_at (local.get $source)
            (i32.add (local.get $pos) (i32.const 1))))
          (else (i32.const 0))))
        (local.set $op_result (call $two_char_kind (local.get $b) (local.get $b2)))
        (if (i32.ne (local.get $op_result) (i32.const 70))
          (then
            (local.set $kind (i32.load offset=4 (local.get $op_result)))
            (local.set $tok (call $mk_tok (local.get $kind)
              (local.get $line) (local.get $col)
              (local.get $line) (i32.add (local.get $col) (i32.const 2))))
            (local.set $tup (call $push_tok (local.get $buf) (local.get $count) (local.get $tok)))
            (local.set $buf (call $list_index (local.get $tup) (i32.const 0)))
            (local.set $count (call $list_index (local.get $tup) (i32.const 1)))
            (local.set $pos (i32.add (local.get $pos) (i32.const 2)))
            (local.set $col (i32.add (local.get $col) (i32.const 2)))
            (br $main_loop)))

        ;; Splice termination + brace depth (mirror wheel lexer.mn:224-239):
        ;; `}` at depth 0 under term_byte=125 emits TRBrace and returns —
        ;; the splice's expression tokens end here; $scan_dq_string resumes.
        (if (i32.and (i32.eq (local.get $b) (i32.const 125))
                     (i32.and (i32.eq (local.get $term_byte) (i32.const 125))
                              (i32.eqz (local.get $depth))))
          (then
            (local.set $tok (call $mk_tok (i32.const 48)
              (local.get $line) (local.get $col)
              (local.get $line) (i32.add (local.get $col) (i32.const 1))))
            (local.set $tup (call $push_tok (local.get $buf) (local.get $count) (local.get $tok)))
            (local.set $buf (call $list_index (local.get $tup) (i32.const 0)))
            (local.set $count (call $list_index (local.get $tup) (i32.const 1)))
            (local.set $pos (i32.add (local.get $pos) (i32.const 1)))
            (local.set $col (i32.add (local.get $col) (i32.const 1)))
            (br $exit)))
        (if (i32.eq (local.get $b) (i32.const 123))
          (then (local.set $depth (i32.add (local.get $depth) (i32.const 1)))))
        (if (i32.and (i32.eq (local.get $b) (i32.const 125))
                     (i32.gt_u (local.get $depth) (i32.const 0)))
          (then (local.set $depth (i32.sub (local.get $depth) (i32.const 1)))))

        ;; Single-char operators
        (local.set $op_result (call $single_char_kind (local.get $b)))
        (if (i32.ne (local.get $op_result) (i32.const 70))
          (then
            (local.set $kind (i32.load offset=4 (local.get $op_result)))
            (local.set $tok (call $mk_tok (local.get $kind)
              (local.get $line) (local.get $col)
              (local.get $line) (i32.add (local.get $col) (i32.const 1))))
            (local.set $tup (call $push_tok (local.get $buf) (local.get $count) (local.get $tok)))
            (local.set $buf (call $list_index (local.get $tup) (i32.const 0)))
            (local.set $count (call $list_index (local.get $tup) (i32.const 1)))
            (local.set $pos (i32.add (local.get $pos) (i32.const 1)))
            (local.set $col (i32.add (local.get $col) (i32.const 1)))
            (br $main_loop)))

        ;; Unknown byte — skip
        (local.set $pos (i32.add (local.get $pos) (i32.const 1)))
        (local.set $col (i32.add (local.get $col) (i32.const 1)))
        (br $main_loop)))

    ;; Return (pos, col, buf, count) as 4-tuple — wheel lex_from order.
    (local.set $tup (call $make_list (i32.const 4)))
    (drop (call $list_set (local.get $tup) (i32.const 0) (local.get $pos)))
    (drop (call $list_set (local.get $tup) (i32.const 1) (local.get $col)))
    (drop (call $list_set (local.get $tup) (i32.const 2) (local.get $buf)))
    (drop (call $list_set (local.get $tup) (i32.const 3) (local.get $count)))
    (local.get $tup))

  ;; ─── $dq_needs_interp — prescan: does this "..." string interpolate? ──
  ;; True when the string body contains `{{`/`}}` (brace doubling) or a
  ;; splice-open (`{` followed by an expression-start byte). Backslash
  ;; escapes skip two bytes. pos enters AFTER the opening quote.
  (func $dq_needs_interp (param $source i32) (param $n i32) (param $pos i32) (result i32)
    (local $b i32)
    (block $done
      (loop $scan
        (br_if $done (i32.ge_u (local.get $pos) (local.get $n)))
        (local.set $b (call $byte_at (local.get $source) (local.get $pos)))
        (if (i32.eq (local.get $b) (i32.const 34))
          (then (return (i32.const 0))))
        (if (i32.eq (local.get $b) (i32.const 92))
          (then
            (local.set $pos (i32.add (local.get $pos) (i32.const 2)))
            (br $scan)))
        (if (i32.eq (local.get $b) (i32.const 123))
          (then
            (if (i32.lt_u (i32.add (local.get $pos) (i32.const 1)) (local.get $n))
              (then
                (if (i32.eq (call $byte_at (local.get $source)
                      (i32.add (local.get $pos) (i32.const 1))) (i32.const 123))
                  (then (return (i32.const 1))))
                (if (call $is_splice_start_byte (call $byte_at (local.get $source)
                      (i32.add (local.get $pos) (i32.const 1))))
                  (then (return (i32.const 1))))))))
        (if (i32.and (i32.eq (local.get $b) (i32.const 125))
                     (i32.lt_u (i32.add (local.get $pos) (i32.const 1)) (local.get $n)))
          (then
            (if (i32.eq (call $byte_at (local.get $source)
                  (i32.add (local.get $pos) (i32.const 1))) (i32.const 125))
              (then (return (i32.const 1))))))
        (local.set $pos (i32.add (local.get $pos) (i32.const 1)))
        (br $scan)))
    (i32.const 0))

  ;; ─── $is_splice_start_byte — mirror wheel lexer.mn:279-295 EXACTLY ───
  ;; a-z A-Z _ 0-9 ( [ ! can begin a splice expression; anything else
  ;; (including `"` `}` whitespace) means the `{` is a literal brace.
  ;; Guard parity with the wheel is a fixpoint requirement — divergence
  ;; here tokenizes the same source differently across m2/m3.
  (func $is_splice_start_byte (param $b i32) (result i32)
    (if (i32.and (i32.ge_u (local.get $b) (i32.const 97))
                 (i32.le_u (local.get $b) (i32.const 122)))
      (then (return (i32.const 1))))
    (if (i32.and (i32.ge_u (local.get $b) (i32.const 65))
                 (i32.le_u (local.get $b) (i32.const 90)))
      (then (return (i32.const 1))))
    (if (i32.eq (local.get $b) (i32.const 95))
      (then (return (i32.const 1))))
    (if (i32.and (i32.ge_u (local.get $b) (i32.const 48))
                 (i32.le_u (local.get $b) (i32.const 57)))
      (then (return (i32.const 1))))
    (if (i32.eq (local.get $b) (i32.const 40))
      (then (return (i32.const 1))))
    (if (i32.eq (local.get $b) (i32.const 91))
      (then (return (i32.const 1))))
    (if (i32.eq (local.get $b) (i32.const 33))
      (then (return (i32.const 1))))
    (i32.const 0))

  ;; ─── $scan_dq_string — interpolating-string scanner ──────────────────
  ;; Mirror of wheel scan_string/scan_string_chunk/scan_string_after_splice
  ;; (lexer.mn:297-369). Emits TStringPart per literal chunk; on a splice
  ;; emits TStringPart + TStringSplice then re-enters $lex_from with
  ;; term_byte=125 (which emits the terminating TRBrace); resumes chunk
  ;; scanning at the returned position. `{{`/`}}` flush the chunk
  ;; including the first brace and skip the second (parser coalesces).
  ;; pos enters AFTER the opening quote. Returns (pos, col, buf, count).
  (func $scan_dq_string (param $source i32) (param $n i32) (param $pos i32)
                        (param $line i32) (param $col i32)
                        (param $buf i32) (param $count i32) (result i32)
    (local $b i32) (local $chunk_start i32) (local $part i32)
    (local $tok i32) (local $tup i32) (local $r4 i32)
    (local.set $chunk_start (local.get $pos))
    (block $closed
      (loop $scan
        ;; EOF — flush final chunk (malformed-input edge; mirror wheel).
        (br_if $closed (i32.ge_u (local.get $pos) (local.get $n)))
        (local.set $b (call $byte_at (local.get $source) (local.get $pos)))
        ;; closing "
        (if (i32.eq (local.get $b) (i32.const 34))
          (then
            (local.set $pos (i32.add (local.get $pos) (i32.const 1)))
            (local.set $col (i32.add (local.get $col) (i32.const 1)))
            (local.set $part (call $str_unescape (local.get $source)
              (local.get $chunk_start) (i32.sub (local.get $pos) (i32.const 1))))
            (local.set $tok (call $mk_tok (call $mk_TStringPart (local.get $part))
              (local.get $line) (local.get $col) (local.get $line) (local.get $col)))
            (local.set $tup (call $push_tok (local.get $buf) (local.get $count) (local.get $tok)))
            (local.set $buf (call $list_index (local.get $tup) (i32.const 0)))
            (local.set $count (call $list_index (local.get $tup) (i32.const 1)))
            (br $closed)))
        ;; {{ or }} — flush chunk including the FIRST brace; skip the second.
        (if (i32.and
              (i32.or (i32.eq (local.get $b) (i32.const 123))
                      (i32.eq (local.get $b) (i32.const 125)))
              (i32.and
                (i32.lt_u (i32.add (local.get $pos) (i32.const 1)) (local.get $n))
                (i32.eq (call $byte_at (local.get $source)
                  (i32.add (local.get $pos) (i32.const 1))) (local.get $b))))
          (then
            (local.set $part (call $str_unescape (local.get $source)
              (local.get $chunk_start) (i32.add (local.get $pos) (i32.const 1))))
            (local.set $tok (call $mk_tok (call $mk_TStringPart (local.get $part))
              (local.get $line) (local.get $col) (local.get $line) (i32.add (local.get $col) (i32.const 1))))
            (local.set $tup (call $push_tok (local.get $buf) (local.get $count) (local.get $tok)))
            (local.set $buf (call $list_index (local.get $tup) (i32.const 0)))
            (local.set $count (call $list_index (local.get $tup) (i32.const 1)))
            (local.set $pos (i32.add (local.get $pos) (i32.const 2)))
            (local.set $col (i32.add (local.get $col) (i32.const 2)))
            (local.set $chunk_start (local.get $pos))
            (br $scan)))
        ;; { + splice-start — flush chunk, emit TStringSplice, lex the
        ;; splice expression via $lex_from(term=125), resume after it.
        (if (i32.and (i32.eq (local.get $b) (i32.const 123))
              (i32.and
                (i32.lt_u (i32.add (local.get $pos) (i32.const 1)) (local.get $n))
                (call $is_splice_start_byte (call $byte_at (local.get $source)
                  (i32.add (local.get $pos) (i32.const 1))))))
          (then
            (local.set $part (call $str_unescape (local.get $source)
              (local.get $chunk_start) (local.get $pos)))
            (local.set $tok (call $mk_tok (call $mk_TStringPart (local.get $part))
              (local.get $line) (local.get $col) (local.get $line) (local.get $col)))
            (local.set $tup (call $push_tok (local.get $buf) (local.get $count) (local.get $tok)))
            (local.set $buf (call $list_index (local.get $tup) (i32.const 0)))
            (local.set $count (call $list_index (local.get $tup) (i32.const 1)))
            (local.set $tok (call $mk_tok (i32.const 73)
              (local.get $line) (local.get $col) (local.get $line) (i32.add (local.get $col) (i32.const 1))))
            (local.set $tup (call $push_tok (local.get $buf) (local.get $count) (local.get $tok)))
            (local.set $buf (call $list_index (local.get $tup) (i32.const 0)))
            (local.set $count (call $list_index (local.get $tup) (i32.const 1)))
            (local.set $r4 (call $lex_from (local.get $source) (local.get $n)
              (i32.add (local.get $pos) (i32.const 1))
              (local.get $line) (i32.add (local.get $col) (i32.const 1))
              (local.get $buf) (local.get $count)
              (i32.const 125) (i32.const 0)))
            (local.set $pos   (call $list_index (local.get $r4) (i32.const 0)))
            (local.set $col   (call $list_index (local.get $r4) (i32.const 1)))
            (local.set $buf   (call $list_index (local.get $r4) (i32.const 2)))
            (local.set $count (call $list_index (local.get $r4) (i32.const 3)))
            (local.set $chunk_start (local.get $pos))
            (br $scan)))
        ;; backslash escape — two source bytes, resolved at chunk flush.
        (if (i32.eq (local.get $b) (i32.const 92))
          (then
            (local.set $pos (i32.add (local.get $pos) (i32.const 2)))
            (local.set $col (i32.add (local.get $col) (i32.const 2)))
            (br $scan)))
        ;; plain byte — advance.
        (local.set $pos (i32.add (local.get $pos) (i32.const 1)))
        (local.set $col (i32.add (local.get $col) (i32.const 1)))
        (br $scan)))
    ;; Return (pos, col, buf, count).
    (local.set $tup (call $make_list (i32.const 4)))
    (drop (call $list_set (local.get $tup) (i32.const 0) (local.get $pos)))
    (drop (call $list_set (local.get $tup) (i32.const 1) (local.get $col)))
    (drop (call $list_set (local.get $tup) (i32.const 2) (local.get $buf)))
    (drop (call $list_set (local.get $tup) (i32.const 3) (local.get $count)))
    (local.get $tup))

  ;; ─── Token Kind to String (for debug output) ──────────────────────
  (func $tokenkind_name (param $kind i32) (result i32)
    (local $tag i32)
    ;; Sentinel check
    (if (result i32) (call $is_sentinel (local.get $kind))
      (then
        ;; The kind value IS the tag for nullary variants
        (local.set $tag (local.get $kind))
        ;; Keyword table (kinds 0-24) — canonical static-string offsets
        ;; per lexer_data.wat. Used by $ident_or_keyword_at_p
        ;; (parser_infra.wat) for field-access on keyword-named fields
        ;; (e.g., `s.handle`, `m.match`); single source of truth for
        ;; kind→text in the seed. Drift 7 refusal (parallel-arrays):
        ;; the keyword table lives ONLY here, not duplicated across
        ;; parser, infer, emit.
        (if (i32.eq (local.get $tag) (i32.const 0))  (then (return (i32.const 256))))   ;; "fn"
        (if (i32.eq (local.get $tag) (i32.const 1))  (then (return (i32.const 262))))   ;; "let"
        (if (i32.eq (local.get $tag) (i32.const 2))  (then (return (i32.const 269))))   ;; "if"
        (if (i32.eq (local.get $tag) (i32.const 3))  (then (return (i32.const 275))))   ;; "else"
        (if (i32.eq (local.get $tag) (i32.const 4))  (then (return (i32.const 283))))   ;; "match"
        (if (i32.eq (local.get $tag) (i32.const 5))  (then (return (i32.const 292))))   ;; "type"
        (if (i32.eq (local.get $tag) (i32.const 6))  (then (return (i32.const 300))))   ;; "effect"
        (if (i32.eq (local.get $tag) (i32.const 7))  (then (return (i32.const 310))))   ;; "handle"
        (if (i32.eq (local.get $tag) (i32.const 8))  (then (return (i32.const 320))))   ;; "handler"
        (if (i32.eq (local.get $tag) (i32.const 9))  (then (return (i32.const 331))))   ;; "with"
        (if (i32.eq (local.get $tag) (i32.const 10)) (then (return (i32.const 339))))   ;; "resume"
        (if (i32.eq (local.get $tag) (i32.const 11)) (then (return (i32.const 349))))   ;; "perform"
        (if (i32.eq (local.get $tag) (i32.const 12)) (then (return (i32.const 360))))   ;; "for"
        (if (i32.eq (local.get $tag) (i32.const 13)) (then (return (i32.const 367))))   ;; "in"
        (if (i32.eq (local.get $tag) (i32.const 14)) (then (return (i32.const 373))))   ;; "loop"
        (if (i32.eq (local.get $tag) (i32.const 15)) (then (return (i32.const 381))))   ;; "break"
        (if (i32.eq (local.get $tag) (i32.const 16)) (then (return (i32.const 390))))   ;; "continue"
        (if (i32.eq (local.get $tag) (i32.const 17)) (then (return (i32.const 402))))   ;; "return"
        (if (i32.eq (local.get $tag) (i32.const 18)) (then (return (i32.const 412))))   ;; "import"
        (if (i32.eq (local.get $tag) (i32.const 19)) (then (return (i32.const 422))))   ;; "where"
        (if (i32.eq (local.get $tag) (i32.const 20)) (then (return (i32.const 431))))   ;; "own"
        (if (i32.eq (local.get $tag) (i32.const 21)) (then (return (i32.const 438))))   ;; "ref"
        (if (i32.eq (local.get $tag) (i32.const 22)) (then (return (i32.const 459))))   ;; "Pure"
        (if (i32.eq (local.get $tag) (i32.const 23)) (then (return (i32.const 467))))   ;; "true"
        (if (i32.eq (local.get $tag) (i32.const 24)) (then (return (i32.const 475))))   ;; "false"
        (if (i32.eq (local.get $tag) (i32.const 68)) (then (return (i32.const 272)))) ;; TNewline→"NL"
        (if (i32.eq (local.get $tag) (i32.const 69)) (then (return (i32.const 272)))) ;; TEof→"EOF"
        (call $int_to_str (local.get $tag)))
      (else
        ;; Fielded variant — extract tag from offset 0
        (local.set $tag (i32.load (local.get $kind)))
        (if (i32.eq (local.get $tag) (i32.const 25))
          (then (return (i32.load offset=4 (local.get $kind)))))  ;; TIdent → payload string
        (if (i32.eq (local.get $tag) (i32.const 26))
          (then (return (call $int_to_str (i32.load offset=4 (local.get $kind))))))  ;; TInt → str
        (if (i32.eq (local.get $tag) (i32.const 28))
          (then (return (i32.load offset=4 (local.get $kind)))))  ;; TString → payload
        (if (i32.eq (local.get $tag) (i32.const 29))
          (then (return (i32.load offset=4 (local.get $kind)))))  ;; TDocComment → payload
        (call $int_to_str (local.get $tag)))))
