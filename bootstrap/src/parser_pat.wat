  ;; ═══ Pattern Parsing ═══════════════════════════════════════════════
  ;; Hand-transcribed from src/parser.mn lines 1196-1294.
  ;;
  ;; Pattern ADT (from src/types.mn):
  ;;   PVar(name)          → [tag=130][name_ptr]
  ;;   PWild               → sentinel 131
  ;;   PLit(lit_val)       → [tag=132][lit_val]
  ;;   PCon(ctor, sub)     → [tag=133][ctor_name][sub_pats_list]
  ;;   PTuple(sub)         → [tag=134][sub_pats_list]
  ;;   PList(sub, rest)    → [tag=135][sub_pats_list][rest_option]
  ;;   PRecord(fields)     → [tag=136][fields_list]
  ;;
  ;; LitVal ADT:
  ;;   LVInt(n)            → [tag=180][n]
  ;;   LVFloat(f)          → [tag=181][f]
  ;;   LVString(s)         → [tag=182][s]
  ;;   LVBool(b)           → [tag=183][0|1]
  ;;
  ;; Returns (pat, new_pos) as 2-tuple.
  ;;
  ;; Dispatch per src/parser.mn parse_pat:
  ;;   TIdent("_")         → PWild
  ;;   TIdent(v) caps      → PCon(v, sub_pats) if followed by (
  ;;                        → PCon(v, [])       if not
  ;;   TIdent(v) lower     → PVar(v)
  ;;   TInt(n)             → PLit(LVInt(n))
  ;;   TString(s)          → PLit(LVString(s))
  ;;   TTrue               → PLit(LVBool(true))
  ;;   TFalse              → PLit(LVBool(false))
  ;;   TLParen             → PTuple(sub_pats)
  ;;   TLBracket           → PList(sub_pats, rest_option)
  ;;   TLBrace             → PRecord(fields)
  ;;   _                   → PWild (error recovery)

  ;; LitVal constructors
  (func $mk_LVInt (param $n i32) (result i32)
    (local $p i32) (local.set $p (call $alloc (i32.const 8)))
    (i32.store (local.get $p) (i32.const 180))
    (i32.store offset=4 (local.get $p) (local.get $n))
    (local.get $p))

  (func $mk_LVFloat (param $s i32) (result i32)
    (local $p i32) (local.set $p (call $alloc (i32.const 8)))
    (i32.store (local.get $p) (i32.const 181))
    (i32.store offset=4 (local.get $p) (local.get $s))
    (local.get $p))

  (func $mk_LVString (param $s i32) (result i32)
    (local $p i32) (local.set $p (call $alloc (i32.const 8)))
    (i32.store (local.get $p) (i32.const 182))
    (i32.store offset=4 (local.get $p) (local.get $s))
    (local.get $p))

  (func $mk_LVBool (param $b i32) (result i32)
    (local $p i32) (local.set $p (call $alloc (i32.const 8)))
    (i32.store (local.get $p) (i32.const 183))
    (i32.store offset=4 (local.get $p) (local.get $b))
    (local.get $p))

  ;; Pattern constructors
  (func $mk_PVar (param $name i32) (result i32)
    (local $p i32) (local.set $p (call $alloc (i32.const 8)))
    (i32.store (local.get $p) (i32.const 130))
    (i32.store offset=4 (local.get $p) (local.get $name))
    (local.get $p))

  (func $mk_PLit (param $lit i32) (result i32)
    (local $p i32) (local.set $p (call $alloc (i32.const 8)))
    (i32.store (local.get $p) (i32.const 132))
    (i32.store offset=4 (local.get $p) (local.get $lit))
    (local.get $p))

  (func $mk_PCon (param $name i32) (param $subs i32) (result i32)
    (local $p i32) (local.set $p (call $alloc (i32.const 12)))
    (i32.store (local.get $p) (i32.const 133))
    (i32.store offset=4 (local.get $p) (local.get $name))
    (i32.store offset=8 (local.get $p) (local.get $subs))
    (local.get $p))

  (func $mk_PTuple (param $subs i32) (result i32)
    (local $p i32) (local.set $p (call $alloc (i32.const 8)))
    (i32.store (local.get $p) (i32.const 134))
    (i32.store offset=4 (local.get $p) (local.get $subs))
    (local.get $p))

  (func $mk_PList (param $subs i32) (param $rest i32) (result i32)
    (local $p i32) (local.set $p (call $alloc (i32.const 12)))
    (i32.store (local.get $p) (i32.const 135))
    (i32.store offset=4 (local.get $p) (local.get $subs))
    (i32.store offset=8 (local.get $p) (local.get $rest))
    (local.get $p))

  ;; PAlt (137) — pattern alternation `pat_1 | pat_2 | ...` per
  ;; SYNTAX.md §"Pattern alternation — rule". Branches list at offset 4.
  (func $mk_PAlt (param $branches i32) (result i32)
    (local $p i32) (local.set $p (call $alloc (i32.const 8)))
    (i32.store (local.get $p) (i32.const 137))
    (i32.store offset=4 (local.get $p) (local.get $branches))
    (local.get $p))

  (func $mk_PRecord (param $fields i32) (result i32)
    (local $p i32) (local.set $p (call $alloc (i32.const 8)))
    (i32.store (local.get $p) (i32.const 136))
    (i32.store offset=4 (local.get $p) (local.get $fields))
    (local.get $p))

  ;; ─── str_lt: lexicographic less-than (wheel strings.mn:110) ───────
  (func $str_lt (param $a i32) (param $b i32) (result i32)
    (local $la i32) (local $lb i32) (local $i i32)
    (local $ca i32) (local $cb i32)
    (local.set $la (call $str_len (local.get $a)))
    (local.set $lb (call $str_len (local.get $b)))
    (local.set $i (i32.const 0))
    (loop $each
      (if (i32.and (i32.ge_u (local.get $i) (local.get $la))
                   (i32.ge_u (local.get $i) (local.get $lb)))
        (then (return (i32.const 0))))
      (if (i32.ge_u (local.get $i) (local.get $la))
        (then (return (i32.const 1))))
      (if (i32.ge_u (local.get $i) (local.get $lb))
        (then (return (i32.const 0))))
      (local.set $ca (call $byte_at (local.get $a) (local.get $i)))
      (local.set $cb (call $byte_at (local.get $b) (local.get $i)))
      (if (i32.lt_u (local.get $ca) (local.get $cb))
        (then (return (i32.const 1))))
      (if (i32.gt_u (local.get $ca) (local.get $cb))
        (then (return (i32.const 0))))
      (local.set $i (i32.add (local.get $i) (i32.const 1)))
      (br $each))
    (i32.const 0))

  ;; ─── sort_field_pairs: alphabetical by pair-record field 0 ────────
  ;; In-place insertion sort via $list_set; N = field count (records
  ;; are small). Serves record literals AND record patterns — the
  ;; post-H2 invariant (fields sorted at parse, wheel src/parser.mn
  ;; sort_record_fields:1615 + sort_pat_fields:2106) made physical
  ;; in the seed.
  (func $sort_field_pairs (param $fields i32) (result i32)
    (local $n i32) (local $i i32) (local $j i32)
    (local $cur i32) (local $prev i32)
    (local.set $n (call $len (local.get $fields)))
    (local.set $i (i32.const 1))
    (block $outer_done
      (loop $outer
        (br_if $outer_done (i32.ge_u (local.get $i) (local.get $n)))
        (local.set $cur (call $list_index (local.get $fields) (local.get $i)))
        (local.set $j (local.get $i))
        (block $inner_done
          (loop $inner
            (br_if $inner_done (i32.eqz (local.get $j)))
            (local.set $prev (call $list_index (local.get $fields)
                               (i32.sub (local.get $j) (i32.const 1))))
            (br_if $inner_done
              (call $str_lt (call $record_get (local.get $prev) (i32.const 0))
                            (call $record_get (local.get $cur) (i32.const 0))))
            (drop (call $list_set (local.get $fields) (local.get $j) (local.get $prev)))
            (local.set $j (i32.sub (local.get $j) (i32.const 1)))
            (br $inner)))
        (drop (call $list_set (local.get $fields) (local.get $j) (local.get $cur)))
        (local.set $i (i32.add (local.get $i) (i32.const 1)))
        (br $outer)))
    (local.get $fields))

  ;; Option.Some(value) for PList rest names. None is nullary tag 0.
  (func $mk_pat_Some (param $value i32) (result i32)
    (local $p i32) (local.set $p (call $alloc (i32.const 8)))
    (i32.store (local.get $p) (i32.const 1))
    (i32.store offset=4 (local.get $p) (local.get $value))
    (local.get $p))

  ;; first_char_code: get first byte of a string (0 if empty)
  ;; Used to distinguish Capitalized (constructor) vs lowercase (variable)
  (func $first_char_code (param $s i32) (result i32)
    (if (result i32) (i32.eqz (call $str_len (local.get $s)))
      (then (i32.const 0))
      (else (call $byte_at (local.get $s) (i32.const 0)))))

  ;; is_uppercase: 65 <= c <= 90
  (func $is_uppercase (param $c i32) (result i32)
    (i32.and (i32.ge_u (local.get $c) (i32.const 65))
             (i32.le_u (local.get $c) (i32.const 90))))

  ;; ─── parse_pat ────────────────────────────────────────────────────
  ;; Returns (pat, new_pos) as 2-tuple

  (func $parse_pat (param $tokens i32) (param $pos i32) (result i32)
    (local $k i32) (local $tup i32) (local $name i32) (local $fc i32)
    (local $subs_r i32) (local $subs i32) (local $p i32)
    (local.set $k (call $kind_at (local.get $tokens) (local.get $pos)))

    ;; ── Sentinel kinds ──
    (if (call $is_sentinel (local.get $k))
      (then
        ;; TTrue (23) → PLit(LVBool(true))
        (if (i32.eq (local.get $k) (i32.const 23))
          (then
            (local.set $tup (call $make_list (i32.const 2)))
            (drop (call $list_set (local.get $tup) (i32.const 0)
              (call $mk_PLit (call $mk_LVBool (i32.const 1)))))
            (drop (call $list_set (local.get $tup) (i32.const 1)
              (i32.add (local.get $pos) (i32.const 1))))
            (return (local.get $tup))))

        ;; TFalse (24) → PLit(LVBool(false))
        (if (i32.eq (local.get $k) (i32.const 24))
          (then
            (local.set $tup (call $make_list (i32.const 2)))
            (drop (call $list_set (local.get $tup) (i32.const 0)
              (call $mk_PLit (call $mk_LVBool (i32.const 0)))))
            (drop (call $list_set (local.get $tup) (i32.const 1)
              (i32.add (local.get $pos) (i32.const 1))))
            (return (local.get $tup))))

        ;; TLParen (45) → PTuple(sub_pats)
        (if (i32.eq (local.get $k) (i32.const 45))
          (then
            (local.set $subs_r (call $parse_pat_args
              (local.get $tokens)
              (call $skip_ws_p (local.get $tokens) (i32.add (local.get $pos) (i32.const 1)))))
            (local.set $tup (call $make_list (i32.const 2)))
            (drop (call $list_set (local.get $tup) (i32.const 0)
              (call $mk_PTuple (call $list_index (local.get $subs_r) (i32.const 0)))))
            (drop (call $list_set (local.get $tup) (i32.const 1)
              (call $list_index (local.get $subs_r) (i32.const 1))))
            (return (local.get $tup))))

        ;; TLBracket (49) → PList(sub_pats, rest_option)
        (if (i32.eq (local.get $k) (i32.const 49))
          (then
            (local.set $subs_r (call $parse_pat_list_args
              (local.get $tokens)
              (call $skip_ws_p (local.get $tokens) (i32.add (local.get $pos) (i32.const 1)))))
            (local.set $tup (call $make_list (i32.const 2)))
            (drop (call $list_set (local.get $tup) (i32.const 0)
              (call $mk_PList
                (call $list_index (local.get $subs_r) (i32.const 0))
                (call $list_index (local.get $subs_r) (i32.const 1)))))
            (drop (call $list_set (local.get $tup) (i32.const 1)
              (call $list_index (local.get $subs_r) (i32.const 2))))
            (return (local.get $tup))))

        ;; TLBrace (47) → PRecord(fields) — `{name, age}` / `{name: pat}`
        ;; per src/parser.mn:2073-2076. Fields sorted by name at parse
        ;; (the post-H2 invariant); lower resolves byte offsets by name
        ;; via $resolve_field_offset either way.
        (if (i32.eq (local.get $k) (i32.const 47))
          (then
            (local.set $subs_r (call $parse_pat_record_fields
              (local.get $tokens)
              (call $skip_ws_p (local.get $tokens) (i32.add (local.get $pos) (i32.const 1)))))
            (local.set $tup (call $make_list (i32.const 2)))
            (drop (call $list_set (local.get $tup) (i32.const 0)
              (call $mk_PRecord
                (call $sort_field_pairs
                  (call $list_index (local.get $subs_r) (i32.const 0))))))
            (drop (call $list_set (local.get $tup) (i32.const 1)
              (call $list_index (local.get $subs_r) (i32.const 1))))
            (return (local.get $tup))))

        ;; THandle (sentinel kind 7) — `handle` is a keyword in expression
        ;; position (introduces handle-expr per parser_expr.wat:254 with
        ;; TLBrace lookahead) but a CONTEXTUAL keyword in pattern position.
        ;; Per SYNTAX.md:69 (`fn chase_node(ref nodes, handle, depth) ...`)
        ;; `handle` is a canonical parameter name. Per protocol_parse_is_
        ;; eager_graph_projection.md chain-link 5: reserving `handle` as
        ;; hard keyword IS eager-form-commitment (drift 9 in lexer-state
        ;; clothes). In pattern position there's NO ambiguity with
        ;; `handle <expr>` (no expr after the pat). Treat THandle as
        ;; PVar("handle"); reuse the lexer's length-prefixed "handle"
        ;; data segment at offset 310.
        (if (i32.eq (local.get $k) (i32.const 7))
          (then
            (local.set $tup (call $make_list (i32.const 2)))
            (drop (call $list_set (local.get $tup) (i32.const 0)
              (call $mk_PVar (i32.const 310))))
            (drop (call $list_set (local.get $tup) (i32.const 1)
              (i32.add (local.get $pos) (i32.const 1))))
            (return (local.get $tup))))

        ;; Default sentinel → PWild (skip token)
        (local.set $tup (call $make_list (i32.const 2)))
        (drop (call $list_set (local.get $tup) (i32.const 0) (i32.const 131)))
        (drop (call $list_set (local.get $tup) (i32.const 1)
          (i32.add (local.get $pos) (i32.const 1))))
        (return (local.get $tup))))

    ;; ── Fielded kinds ──
    ;; TIdent (tag=25)
    (if (i32.eq (call $tag_of (local.get $k)) (i32.const 25))
      (then
        (local.set $name (i32.load offset=4 (local.get $k)))
        ;; Check for "_" → PWild
        (if (i32.and
              (i32.eq (call $str_len (local.get $name)) (i32.const 1))
              (i32.eq (call $byte_at (local.get $name) (i32.const 0)) (i32.const 95)))
          (then
            (local.set $tup (call $make_list (i32.const 2)))
            (drop (call $list_set (local.get $tup) (i32.const 0) (i32.const 131)))
            (drop (call $list_set (local.get $tup) (i32.const 1)
              (i32.add (local.get $pos) (i32.const 1))))
            (return (local.get $tup))))
        ;; Check capitalized → constructor pattern
        (local.set $fc (call $first_char_code (local.get $name)))
        (if (call $is_uppercase (local.get $fc))
          (then
            (local.set $p (i32.add (local.get $pos) (i32.const 1)))
            ;; Check for ( → PCon with sub-patterns
            (if (call $at (local.get $tokens) (local.get $p) (i32.const 45))
              (then
                (local.set $subs_r (call $parse_pat_args
                  (local.get $tokens)
                  (call $skip_ws_p (local.get $tokens) (i32.add (local.get $p) (i32.const 1)))))
                (local.set $tup (call $make_list (i32.const 2)))
                (drop (call $list_set (local.get $tup) (i32.const 0)
                  (call $mk_PCon (local.get $name)
                    (call $list_index (local.get $subs_r) (i32.const 0)))))
                (drop (call $list_set (local.get $tup) (i32.const 1)
                  (call $list_index (local.get $subs_r) (i32.const 1))))
                (return (local.get $tup)))
              (else
                ;; Nullary constructor: PCon(name, [])
                (local.set $tup (call $make_list (i32.const 2)))
                (drop (call $list_set (local.get $tup) (i32.const 0)
                  (call $mk_PCon (local.get $name) (call $make_list (i32.const 0)))))
                (drop (call $list_set (local.get $tup) (i32.const 1) (local.get $p)))
                (return (local.get $tup)))))
          (else
            ;; Lowercase → PVar(name)
            (local.set $tup (call $make_list (i32.const 2)))
            (drop (call $list_set (local.get $tup) (i32.const 0)
              (call $mk_PVar (local.get $name))))
            (drop (call $list_set (local.get $tup) (i32.const 1)
              (i32.add (local.get $pos) (i32.const 1))))
            (return (local.get $tup))))))

    ;; TInt (tag=26) → PLit(LVInt(n))
    (if (i32.eq (call $tag_of (local.get $k)) (i32.const 26))
      (then
        (local.set $tup (call $make_list (i32.const 2)))
        (drop (call $list_set (local.get $tup) (i32.const 0)
          (call $mk_PLit (call $mk_LVInt (i32.load offset=4 (local.get $k))))))
        (drop (call $list_set (local.get $tup) (i32.const 1)
          (i32.add (local.get $pos) (i32.const 1))))
        (return (local.get $tup))))

    ;; TFloat (tag=27) → PLit(LVFloat(s)) — payload is raw decimal text.
    (if (i32.eq (call $tag_of (local.get $k)) (i32.const 27))
      (then
        (local.set $tup (call $make_list (i32.const 2)))
        (drop (call $list_set (local.get $tup) (i32.const 0)
          (call $mk_PLit (call $mk_LVFloat (i32.load offset=4 (local.get $k))))))
        (drop (call $list_set (local.get $tup) (i32.const 1)
          (i32.add (local.get $pos) (i32.const 1))))
        (return (local.get $tup))))

    ;; TString (tag=28) → PLit(LVString(s))
    (if (i32.eq (call $tag_of (local.get $k)) (i32.const 28))
      (then
        (local.set $tup (call $make_list (i32.const 2)))
        (drop (call $list_set (local.get $tup) (i32.const 0)
          (call $mk_PLit (call $mk_LVString (i32.load offset=4 (local.get $k))))))
        (drop (call $list_set (local.get $tup) (i32.const 1)
          (i32.add (local.get $pos) (i32.const 1))))
        (return (local.get $tup))))

    ;; Fallback → PWild
    (local.set $tup (call $make_list (i32.const 2)))
    (drop (call $list_set (local.get $tup) (i32.const 0) (i32.const 131)))
    (drop (call $list_set (local.get $tup) (i32.const 1)
      (i32.add (local.get $pos) (i32.const 1))))
    (local.get $tup))

  ;; ─── parse_pat_record_fields: `{name, age}` / `{name: pat, ...}` ──
  ;; Returns (fields, new_pos) as 2-tuple. Field punning is the
  ;; default — `{name}` ≡ `{name: PVar("name")}` per src/parser.mn
  ;; :2081-2104. Fields are pair-records (tag 0, arity 2) matching
  ;; $parse_record_lit's shape so $sort_field_pairs serves both.
  ;; NAME position admits keywords via $ident_or_keyword_at_p; null
  ;; per protocol_parser_fabrication_substrate.md → terminate loop.
  (func $parse_pat_record_fields (param $tokens i32) (param $pos i32) (result i32)
    (local $p i32) (local $buf i32) (local $count i32)
    (local $name i32) (local $sub i32) (local $sub_r i32)
    (local $p2 i32) (local $field i32) (local $tup i32)
    (local.set $p (call $skip_ws_p (local.get $tokens) (local.get $pos)))
    (local.set $buf (call $make_list (i32.const 4)))
    (local.set $count (i32.const 0))
    (block $done
      (loop $each
        (if (call $at (local.get $tokens) (local.get $p) (i32.const 48))  ;; TRBrace
          (then
            (local.set $p (i32.add (local.get $p) (i32.const 1)))
            (br $done)))
        (local.set $name (call $ident_or_keyword_at_p (local.get $tokens) (local.get $p)))
        (if (i32.eqz (local.get $name))
          (then (br $done)))
        (local.set $p2 (call $skip_ws_p (local.get $tokens)
                            (i32.add (local.get $p) (i32.const 1))))
        (if (call $at (local.get $tokens) (local.get $p2) (i32.const 53))  ;; TColon
          (then
            (local.set $sub_r (call $parse_pat (local.get $tokens)
              (call $skip_ws_p (local.get $tokens) (i32.add (local.get $p2) (i32.const 1)))))
            (local.set $sub (call $list_index (local.get $sub_r) (i32.const 0)))
            (local.set $p (call $skip_ws_p (local.get $tokens)
              (call $list_index (local.get $sub_r) (i32.const 1)))))
          (else
            (local.set $sub (call $mk_PVar (local.get $name)))
            (local.set $p (local.get $p2))))
        (local.set $field (call $make_record (i32.const 0) (i32.const 2)))
        (call $record_set (local.get $field) (i32.const 0) (local.get $name))
        (call $record_set (local.get $field) (i32.const 1) (local.get $sub))
        (local.set $buf (call $list_extend_to (local.get $buf)
                          (i32.add (local.get $count) (i32.const 1))))
        (drop (call $list_set (local.get $buf) (local.get $count) (local.get $field)))
        (local.set $count (i32.add (local.get $count) (i32.const 1)))
        (if (call $at (local.get $tokens) (local.get $p) (i32.const 51))  ;; TComma
          (then (local.set $p (call $skip_ws_p (local.get $tokens)
                                (i32.add (local.get $p) (i32.const 1))))))
        (br $each)))
    (local.set $tup (call $make_list (i32.const 2)))
    (drop (call $list_set (local.get $tup) (i32.const 0)
      (call $slice (local.get $buf) (i32.const 0) (local.get $count))))
    (drop (call $list_set (local.get $tup) (i32.const 1) (local.get $p)))
    (local.get $tup))

  ;; ─── parse_pat_args: comma-separated patterns until RParen ────────
  ;; Returns (pat_list, new_pos) as 2-tuple.
  ;; Mirrors src/parser.mn parse_pat_args (lines 1266-1278).

  (func $parse_pat_args (param $tokens i32) (param $pos i32) (result i32)
    (local $p i32) (local $buf i32) (local $count i32)
    (local $result i32) (local $pat i32) (local $p2 i32) (local $p3 i32)
    (local $tup i32)
    (local.set $p (call $skip_ws_p (local.get $tokens) (local.get $pos)))
    ;; Empty: )
    (if (call $at (local.get $tokens) (local.get $p) (i32.const 46)) ;; TRParen
      (then
        (local.set $tup (call $make_list (i32.const 2)))
        (drop (call $list_set (local.get $tup) (i32.const 0)
          (call $make_list (i32.const 0))))
        (drop (call $list_set (local.get $tup) (i32.const 1)
          (i32.add (local.get $p) (i32.const 1))))
        (return (local.get $tup))))
    (local.set $buf (call $make_list (i32.const 4)))
    (local.set $count (i32.const 0))
    (block $done
      (loop $args
        (local.set $result (call $parse_pat (local.get $tokens) (local.get $p)))
        (local.set $pat (call $list_index (local.get $result) (i32.const 0)))
        (local.set $p2 (call $list_index (local.get $result) (i32.const 1)))
        (local.set $buf (call $list_extend_to (local.get $buf)
          (i32.add (local.get $count) (i32.const 1))))
        (drop (call $list_set (local.get $buf) (local.get $count) (local.get $pat)))
        (local.set $count (i32.add (local.get $count) (i32.const 1)))
        (local.set $p3 (call $skip_ws_p (local.get $tokens) (local.get $p2)))
        (if (call $at (local.get $tokens) (local.get $p3) (i32.const 51)) ;; TComma
          (then
            (local.set $p (call $skip_ws_p (local.get $tokens)
              (i32.add (local.get $p3) (i32.const 1))))
            (br $args))
          (else
            (local.set $p (call $expect (local.get $tokens) (local.get $p3) (i32.const 46)))
            (br $done)))))
    (local.set $tup (call $make_list (i32.const 2)))
    (drop (call $list_set (local.get $tup) (i32.const 0)
      (call $slice (local.get $buf) (i32.const 0) (local.get $count))))
    (drop (call $list_set (local.get $tup) (i32.const 1) (local.get $p)))
    (local.get $tup))

  ;; ─── parse_pat_list_args: patterns until RBracket ─────────────────
  ;; Returns [prefix_pats, rest_option, next_pos]. `...rest` is three
  ;; TDot tokens followed by an ident; `..._` records anonymous rest.

  (func $parse_pat_list_args (param $tokens i32) (param $pos i32) (result i32)
    (local $p i32) (local $buf i32) (local $count i32)
    (local $result i32) (local $pat i32) (local $p2 i32) (local $p3 i32)
    (local $tup i32) (local $rest_name i32) (local $name_pos i32)
    (local $rest_opt i32)
    (local.set $p (call $skip_ws_p (local.get $tokens) (local.get $pos)))
    (if (call $at (local.get $tokens) (local.get $p) (i32.const 50)) ;; TRBracket
      (then
        (local.set $tup (call $make_list (i32.const 3)))
        (drop (call $list_set (local.get $tup) (i32.const 0)
          (call $make_list (i32.const 0))))
        (drop (call $list_set (local.get $tup) (i32.const 1)
          (i32.const 0))) ;; None
        (drop (call $list_set (local.get $tup) (i32.const 2)
          (i32.add (local.get $p) (i32.const 1))))
        (return (local.get $tup))))
    ;; `...rest` / `..._`
    (if (i32.and
          (i32.and
            (call $at (local.get $tokens) (local.get $p) (i32.const 52))       ;; TDot
            (call $at (local.get $tokens) (i32.add (local.get $p) (i32.const 1)) (i32.const 52)))
          (call $at (local.get $tokens) (i32.add (local.get $p) (i32.const 2)) (i32.const 52)))
      (then
        (local.set $name_pos
          (call $skip_ws_p (local.get $tokens) (i32.add (local.get $p) (i32.const 3))))
        (local.set $rest_name (call $ident_at_p (local.get $tokens) (local.get $name_pos)))
        (local.set $p3 (call $skip_ws_p (local.get $tokens)
          (i32.add (local.get $name_pos) (i32.const 1))))
        (local.set $tup (call $make_list (i32.const 3)))
        (drop (call $list_set (local.get $tup) (i32.const 0)
          (call $make_list (i32.const 0))))
        (drop (call $list_set (local.get $tup) (i32.const 1)
          (call $mk_pat_Some (local.get $rest_name))))
        (drop (call $list_set (local.get $tup) (i32.const 2)
          (call $expect (local.get $tokens) (local.get $p3) (i32.const 50))))
        (return (local.get $tup))))
    (local.set $buf (call $make_list (i32.const 4)))
    (local.set $count (i32.const 0))
    (local.set $rest_opt (i32.const 0))
    (block $done
      (loop $args
        (if (i32.and
              (i32.and
                (call $at (local.get $tokens) (local.get $p) (i32.const 52))
                (call $at (local.get $tokens) (i32.add (local.get $p) (i32.const 1)) (i32.const 52)))
              (call $at (local.get $tokens) (i32.add (local.get $p) (i32.const 2)) (i32.const 52)))
          (then
            (local.set $name_pos
              (call $skip_ws_p (local.get $tokens) (i32.add (local.get $p) (i32.const 3))))
            (local.set $rest_name (call $ident_at_p (local.get $tokens) (local.get $name_pos)))
            (local.set $rest_opt (call $mk_pat_Some (local.get $rest_name)))
            (local.set $p3 (call $skip_ws_p (local.get $tokens)
              (i32.add (local.get $name_pos) (i32.const 1))))
            (local.set $p (call $expect (local.get $tokens) (local.get $p3) (i32.const 50)))
            (br $done)))
        (local.set $result (call $parse_pat (local.get $tokens) (local.get $p)))
        (local.set $pat (call $list_index (local.get $result) (i32.const 0)))
        (local.set $p2 (call $list_index (local.get $result) (i32.const 1)))
        (local.set $buf (call $list_extend_to (local.get $buf)
          (i32.add (local.get $count) (i32.const 1))))
        (drop (call $list_set (local.get $buf) (local.get $count) (local.get $pat)))
        (local.set $count (i32.add (local.get $count) (i32.const 1)))
        (local.set $p3 (call $skip_ws_p (local.get $tokens) (local.get $p2)))
        (if (call $at (local.get $tokens) (local.get $p3) (i32.const 51)) ;; TComma
          (then
            (local.set $p (call $skip_ws_p (local.get $tokens)
              (i32.add (local.get $p3) (i32.const 1))))
            (br $args))
          (else
            (local.set $p (call $expect (local.get $tokens) (local.get $p3) (i32.const 50)))
            (br $done)))))
    (local.set $tup (call $make_list (i32.const 3)))
    (drop (call $list_set (local.get $tup) (i32.const 0)
      (call $slice (local.get $buf) (i32.const 0) (local.get $count))))
    (drop (call $list_set (local.get $tup) (i32.const 1) (local.get $rest_opt)))
    (drop (call $list_set (local.get $tup) (i32.const 2) (local.get $p)))
    (local.get $tup))

  ;; ─── parse_match_arms: pat => expr, ... until RBrace ──────────────
  ;; Each arm is a 2-tuple (pat, body_expr).
  ;; Mirrors src/parser.mn parse_match_arms (lines 1106-1117).

  ;; ─── $parse_pat_alt — pattern alternation at the arm grammar ───────
  ;; One pat, then a TPipe(64) loop collecting branches; single-branch
  ;; stays the bare pat (no degenerate PAlt — walkthrough §7). skip_ws
  ;; before the peek: multi-line alternation puts `|` after TNewline.
  ;; Returns (pat, new_pos) 2-tuple like $parse_pat.
  (func $parse_pat_alt (param $tokens i32) (param $pos i32) (result i32)
    (local $first_r i32) (local $first i32) (local $p i32)
    (local $buf i32) (local $count i32) (local $next_r i32)
    (local $pw i32) (local $tup i32)
    (local.set $first_r (call $parse_pat (local.get $tokens) (local.get $pos)))
    (local.set $first (call $list_index (local.get $first_r) (i32.const 0)))
    (local.set $p     (call $list_index (local.get $first_r) (i32.const 1)))
    (if (i32.eqz (call $at (local.get $tokens)
                   (call $skip_ws_p (local.get $tokens) (local.get $p))
                   (i32.const 64)))                          ;; TPipe
      (then (return (local.get $first_r))))
    (local.set $buf (call $make_list (i32.const 4)))
    (drop (call $list_set (local.get $buf) (i32.const 0) (local.get $first)))
    (local.set $count (i32.const 1))
    (block $done
      (loop $branches
        (local.set $pw (call $skip_ws_p (local.get $tokens) (local.get $p)))
        (br_if $done (i32.eqz (call $at (local.get $tokens) (local.get $pw)
                                (i32.const 64))))            ;; TPipe
        (local.set $next_r (call $parse_pat (local.get $tokens)
          (call $skip_ws_p (local.get $tokens)
            (i32.add (local.get $pw) (i32.const 1)))))
        (local.set $buf (call $list_extend_to (local.get $buf)
          (i32.add (local.get $count) (i32.const 1))))
        (drop (call $list_set (local.get $buf) (local.get $count)
          (call $list_index (local.get $next_r) (i32.const 0))))
        (local.set $count (i32.add (local.get $count) (i32.const 1)))
        (local.set $p (call $list_index (local.get $next_r) (i32.const 1)))
        (br $branches)))
    (local.set $tup (call $make_list (i32.const 2)))
    (drop (call $list_set (local.get $tup) (i32.const 0)
      (call $mk_PAlt
        (call $slice (local.get $buf) (i32.const 0) (local.get $count)))))
    (drop (call $list_set (local.get $tup) (i32.const 1) (local.get $p)))
    (local.get $tup))

  (func $parse_match_arms_full (param $tokens i32) (param $pos i32) (result i32)
    (local $p i32) (local $buf i32) (local $count i32)
    (local $pat_r i32) (local $pat i32) (local $p2 i32) (local $p3 i32)
    (local $body_r i32) (local $body i32) (local $p4 i32) (local $p5 i32)
    (local $arm i32) (local $tup i32) (local $k i32)
    (local.set $buf (call $make_list (i32.const 4)))
    (local.set $count (i32.const 0))
    (local.set $p (call $skip_ws_p (local.get $tokens) (local.get $pos)))
    (block $done
      (loop $arms
        ;; Check for } or EOF
        (if (i32.or
              (call $at (local.get $tokens) (local.get $p) (i32.const 48))  ;; TRBrace
              (call $at (local.get $tokens) (local.get $p) (i32.const 69))) ;; TEof
          (then
            (local.set $p (i32.add (local.get $p) (i32.const 1)))
            (br $done)))
        ;; Doc-comment block before an arm — drop-and-continue, same
        ;; convention as parse_stmt_p + parse_handler_arm.
        (block $doc_done
          (loop $doc_skip
            (br_if $doc_done (i32.eqz
              (call $is_doc_comment_at (local.get $tokens) (local.get $p))))
            (local.set $p (call $skip_ws_p (local.get $tokens)
              (i32.add (local.get $p) (i32.const 1))))
            (br $doc_skip)))
        ;; Parse pattern (with `|` alternation at the arm grammar per
        ;; SYNTAX.md §1605 — TPipe in match arm body).
        (local.set $pat_r (call $parse_pat_alt (local.get $tokens) (local.get $p)))
        (local.set $pat (call $list_index (local.get $pat_r) (i32.const 0)))
        (local.set $p2 (call $list_index (local.get $pat_r) (i32.const 1)))
        ;; Expect =>
        (local.set $p3 (call $expect (local.get $tokens)
          (call $skip_ws_p (local.get $tokens) (local.get $p2))
          (i32.const 35)))  ;; TFatArrow
        ;; Parse body expression
        (local.set $body_r (call $parse_expr (local.get $tokens)
          (call $skip_ws_p (local.get $tokens) (local.get $p3))))
        (local.set $body (call $list_index (local.get $body_r) (i32.const 0)))
        (local.set $p4 (call $list_index (local.get $body_r) (i32.const 1)))
        ;; Build arm as 2-tuple (pat, body)
        (local.set $arm (call $make_list (i32.const 2)))
        (drop (call $list_set (local.get $arm) (i32.const 0) (local.get $pat)))
        (drop (call $list_set (local.get $arm) (i32.const 1) (local.get $body)))
        ;; Append to buffer
        (local.set $buf (call $list_extend_to (local.get $buf)
          (i32.add (local.get $count) (i32.const 1))))
        (drop (call $list_set (local.get $buf) (local.get $count) (local.get $arm)))
        (local.set $count (i32.add (local.get $count) (i32.const 1)))
        ;; Skip optional comma + whitespace
        (local.set $p5 (call $skip_ws_p (local.get $tokens) (local.get $p4)))
        (if (call $at (local.get $tokens) (local.get $p5) (i32.const 51)) ;; TComma
          (then (local.set $p5 (i32.add (local.get $p5) (i32.const 1)))))
        (local.set $p (call $skip_ws_p (local.get $tokens) (local.get $p5)))
        (br $arms)))
    ;; Return (arms_list, pos)
    (local.set $tup (call $make_list (i32.const 2)))
    (drop (call $list_set (local.get $tup) (i32.const 0)
      (call $slice (local.get $buf) (i32.const 0) (local.get $count))))
    (drop (call $list_set (local.get $tup) (i32.const 1) (local.get $p)))
    (local.get $tup))
