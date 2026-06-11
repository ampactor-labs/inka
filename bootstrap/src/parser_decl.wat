  ;; ═══ Type Declaration Parser (Complete) ═════════════════════════════
  ;; Hand-transcribed from src/parser.mn lines 525-586.
  ;;
  ;; type Name = Variant1 | Variant2(Type1, Type2) | ...
  ;; Each variant: (name, field_types_list)

  (func $parse_type_stmt (param $tokens i32) (param $pos i32) (param $span i32) (result i32)
    (local $name i32) (local $p i32) (local $variants_r i32) (local $tup i32)
    (local $fields_r i32) (local $ty_record i32) (local $variant i32)
    (local $variants i32) (local $field_tys i32)
    (local.set $name (call $ident_at_p (local.get $tokens) (local.get $pos)))
    ;; Null return per protocol_parser_fabrication_substrate.md means
    ;; "no TIdent at this position." Substrate-honest recovery:
    ;; produce NErrorStmt sentinel + advance pos by 1; outer parse_stmts
    ;; loop continues, lower/emit kind-dispatch skips the entry.
    (if (i32.eqz (local.get $name))
      (then
        (local.set $tup (call $make_list (i32.const 2)))
        (drop (call $list_set (local.get $tup) (i32.const 0)
          (call $nstmt (call $mk_NErrorStmt (i32.const 1)) (local.get $span))))
        (drop (call $list_set (local.get $tup) (i32.const 1)
          (i32.add (local.get $pos) (i32.const 1))))
        (return (local.get $tup))))
    (local.set $p (call $skip_ws_p (local.get $tokens) (i32.add (local.get $pos) (i32.const 1))))
    ;; No type-parameter list: the case rule IS the declaration —
    ;; lowercase identifiers in field positions quantify implicitly
    ;; (angle-bracket generics retired; E_ExplicitTypeParams).
    ;; Skip =
    (if (call $at (local.get $tokens) (local.get $p) (i32.const 60)) ;; TEq
      (then (local.set $p (call $skip_ws_p (local.get $tokens) (i32.add (local.get $p) (i32.const 1))))))
    ;; Nominal record: type Name = {field: Ty, ...}
    (if (call $at (local.get $tokens) (local.get $p) (i32.const 47)) ;; TLBrace
      (then
        (local.set $fields_r (call $parse_record_type_fields
          (local.get $tokens)
          (call $skip_ws_p (local.get $tokens) (i32.add (local.get $p) (i32.const 1)))))
        (local.set $ty_record
          (call $mk_TyRecord (call $list_index (local.get $fields_r) (i32.const 0))))
        (local.set $field_tys (call $make_list (i32.const 1)))
        (drop (call $list_set (local.get $field_tys) (i32.const 0) (local.get $ty_record)))
        (local.set $variant (call $make_list (i32.const 2)))
        (drop (call $list_set (local.get $variant) (i32.const 0) (local.get $name)))
        (drop (call $list_set (local.get $variant) (i32.const 1) (local.get $field_tys)))
        (local.set $variants (call $make_list (i32.const 1)))
        (drop (call $list_set (local.get $variants) (i32.const 0) (local.get $variant)))
        (local.set $tup (call $make_list (i32.const 2)))
        (drop (call $list_set (local.get $tup) (i32.const 0)
          (call $nstmt
            (call $mk_TypeDefStmt (local.get $name)
              (local.get $variants))
            (local.get $span))))
        (drop (call $list_set (local.get $tup) (i32.const 1)
          (call $list_index (local.get $fields_r) (i32.const 1))))
        (return (local.get $tup))))
    ;; Parse variants
    (local.set $variants_r (call $parse_variants (local.get $tokens) (local.get $p)))
    ;; Skip optional `where <predicate>` per SYNTAX.md §1216-1233.
    ;; Per Hβ.first-light.refine-predicate-parser (named follow-up):
    ;; the predicate ADT + verify-emit substrate is the substrate-
    ;; honest landing. Until that handle lands, the seed pragmatically
    ;; consumes the where-clause tokens so they don't bleed into the
    ;; next-statement parser (where they'd surface as
    ;; E_MissingVariable: self). The refinement predicate is dropped
    ;; at the parser layer; downstream compilation proceeds.
    ;;
    ;; Eight interrogations per edit site:
    ;;  1. Graph?   Refinement predicate is metadata at graph layer
    ;;              — the type alias is what's bound (without the
    ;;              where clause).
    ;;  2. Handler? @resume=OneShot direct parse.
    ;;  3. Verb?    N/A.
    ;;  4. Row?     Pure parse.
    ;;  5. Ownership? Tokens borrowed.
    ;;  6. Refinement? PRAGMATICALLY DEFERRED to the named follow-up.
    ;;              Substrate-honest tag: this is drift-9-safe because
    ;;              the named handle Hβ.first-light.refine-predicate-
    ;;              parser will replace this skip with full predicate
    ;;              parsing + Verify-emit obligation per src/infer.mn
    ;;              wheel canonical (RefineStmt arm at line 261-266).
    ;;  7. Gradient? Skipping the predicate doesn't unlock capability
    ;;              today; the named follow-up wires Verify so adding
    ;;              `where p` becomes a gradient annotation.
    ;;  8. Reason?  Predicate-source span available at the where token's
    ;;              position; named follow-up threads it as DeclaredAt.
    (local.set $p (call $list_index (local.get $variants_r) (i32.const 1)))
    (local.set $p (call $skip_ws_p (local.get $tokens) (local.get $p)))
    ;; Hβ.parser.refinement-type-no-variant-reregister — when TWhere is
    ;; present, the form is `type X = Y where pred` (refinement alias),
    ;; NOT `type X = A | B | C` (sum type). $parse_variants greedily
    ;; consumed `Y` as a variant; but Y is already a constructor of its
    ;; own type. Re-registering Y as a variant of X would overwrite Y's
    ;; tag_id in env, breaking all sites that construct Y. Refinement
    ;; alias = TypeDefStmt with EMPTY variants (X registers as a type
    ;; name but adds no new constructors). The predicate itself is
    ;; metadata that the Verify substrate consumes (named follow-up
    ;; Hβ.first-light.refine-predicate-parser).
    (if (call $at (local.get $tokens) (local.get $p) (i32.const 19)) ;; TWhere
      (then
        (local.set $p (call $skip_predicate_to_stmt_end
                            (local.get $tokens)
                            (i32.add (local.get $p) (i32.const 1))))
        ;; Refinement form — discard the greedily-parsed variants list.
        (local.set $variants_r (call $make_list (i32.const 2)))
        (drop (call $list_set (local.get $variants_r) (i32.const 0)
          (call $make_list (i32.const 0))))
        (drop (call $list_set (local.get $variants_r) (i32.const 1) (local.get $p)))))
    (local.set $tup (call $make_list (i32.const 2)))
    (drop (call $list_set (local.get $tup) (i32.const 0)
      (call $nstmt
        (call $mk_TypeDefStmt (local.get $name)
          (call $list_index (local.get $variants_r) (i32.const 0)))
        (local.get $span))))
    (drop (call $list_set (local.get $tup) (i32.const 1) (local.get $p)))
    (local.get $tup))

  ;; Skip tokens until the next statement boundary — newline, EOF, or
  ;; a top-level declaration keyword (TFn, TLet, TType, TEffect,
  ;; THandler, TImport). Used by the where-clause parser
  ;; until the named follow-up Hβ.first-light.refine-predicate-parser
  ;; lands the full predicate ADT.
  (func $skip_predicate_to_stmt_end (param $tokens i32) (param $pos i32) (result i32)
    (local $k i32)
    (block $done (loop $scan
      (local.set $k (call $kind_at (local.get $tokens) (local.get $pos)))
      (br_if $done (i32.eq (local.get $k) (i32.const 68)))   ;; TNewline
      (br_if $done (i32.eq (local.get $k) (i32.const 69)))   ;; TEof
      (br_if $done (i32.eq (local.get $k) (i32.const 0)))    ;; TFn
      (br_if $done (i32.eq (local.get $k) (i32.const 1)))    ;; TLet
      (br_if $done (i32.eq (local.get $k) (i32.const 5)))    ;; TType
      (br_if $done (i32.eq (local.get $k) (i32.const 6)))    ;; TEffect
      (br_if $done (i32.eq (local.get $k) (i32.const 8)))    ;; THandler
      (br_if $done (i32.eq (local.get $k) (i32.const 18)))   ;; TImport
      (local.set $pos (i32.add (local.get $pos) (i32.const 1)))
      (br $scan)))
    (local.get $pos))

  ;; parse_record_type_fields: field-name/type pairs until RBrace.
  ;; Returns (fields_list, new_pos). Each field is a 2-tuple (name, Ty).
  (func $parse_record_type_fields (param $tokens i32) (param $pos i32) (result i32)
    (local $p i32) (local $buf i32) (local $count i32)
    (local $name i32) (local $p2 i32) (local $ty_r i32)
    (local $ty i32) (local $p3 i32) (local $field i32) (local $tup i32)
    (local.set $p (call $skip_ws_p (local.get $tokens) (local.get $pos)))
    (if (call $at (local.get $tokens) (local.get $p) (i32.const 48)) ;; TRBrace
      (then
        (local.set $tup (call $make_list (i32.const 2)))
        (drop (call $list_set (local.get $tup) (i32.const 0) (call $make_list (i32.const 0))))
        (drop (call $list_set (local.get $tup) (i32.const 1) (i32.add (local.get $p) (i32.const 1))))
        (return (local.get $tup))))
    (local.set $buf (call $make_list (i32.const 4)))
    (local.set $count (i32.const 0))
    (block $done
      (loop $fields
        ;; Field name — NAME position admits keywords (`handle: Int`),
        ;; same projection as postfix `.field` + record literals. Null
        ;; per protocol_parser_fabrication_substrate.md → terminate.
        (local.set $name (call $ident_or_keyword_at_p (local.get $tokens) (local.get $p)))
        (if (i32.eqz (local.get $name))
          (then (br $done)))
        (local.set $p2 (call $expect
          (local.get $tokens)
          (call $skip_ws_p (local.get $tokens) (i32.add (local.get $p) (i32.const 1)))
          (i32.const 53))) ;; TColon
        (local.set $ty_r (call $parse_type_ty
          (local.get $tokens)
          (call $skip_ws_p (local.get $tokens) (local.get $p2))))
        (local.set $ty (call $list_index (local.get $ty_r) (i32.const 0)))
        (local.set $p3 (call $skip_ws_p (local.get $tokens)
          (call $list_index (local.get $ty_r) (i32.const 1))))
        (local.set $field (call $make_list (i32.const 2)))
        (drop (call $list_set (local.get $field) (i32.const 0) (local.get $name)))
        (drop (call $list_set (local.get $field) (i32.const 1) (local.get $ty)))
        (local.set $buf (call $list_extend_to (local.get $buf)
          (i32.add (local.get $count) (i32.const 1))))
        (drop (call $list_set (local.get $buf) (local.get $count) (local.get $field)))
        (local.set $count (i32.add (local.get $count) (i32.const 1)))
        (if (call $at (local.get $tokens) (local.get $p3) (i32.const 51)) ;; TComma
          (then
            (local.set $p (call $skip_ws_p
              (local.get $tokens) (i32.add (local.get $p3) (i32.const 1))))
            (if (call $at (local.get $tokens) (local.get $p) (i32.const 48))
              (then
                (local.set $p (i32.add (local.get $p) (i32.const 1)))
                (br $done)))
            (br $fields))
          (else
            (local.set $p (call $expect (local.get $tokens) (local.get $p3) (i32.const 48)))
            (br $done)))))
    (local.set $tup (call $make_list (i32.const 2)))
    (drop (call $list_set (local.get $tup) (i32.const 0)
      (call $slice (local.get $buf) (i32.const 0) (local.get $count))))
    (drop (call $list_set (local.get $tup) (i32.const 1) (local.get $p)))
    (local.get $tup))

  ;; parse_variants: V1 | V2(T1, T2) | ...
  ;; Returns (variants_list, new_pos). Each variant is a 2-tuple (name, field_types).

  (func $parse_variants (param $tokens i32) (param $pos i32) (result i32)
    (local $p i32) (local $vname i32) (local $p2 i32) (local $p2ws i32)
    (local $fields_r i32) (local $fields i32) (local $p3 i32)
    (local $rec_fields i32) (local $ty_record i32)
    (local $variant i32) (local $p4 i32) (local $rest_r i32)
    (local $buf i32) (local $count i32) (local $tup i32)
    (local.set $buf (call $make_list (i32.const 4)))
    (local.set $count (i32.const 0))
    (local.set $p (call $skip_ws_p (local.get $tokens) (local.get $pos)))
    (block $done
      (loop $vars
        ;; Get variant name (must be identifier)
        (if (i32.or
              (call $at (local.get $tokens) (local.get $p) (i32.const 69))  ;; TEof
              (call $at (local.get $tokens) (local.get $p) (i32.const 68))) ;; TNewline
          (then (br $done)))
        ;; Check it's actually an ident — null return per
        ;; protocol_parser_fabrication_substrate.md means "no TIdent
        ;; at this position." Skip the variant; the loop terminates.
        ;; Substrate-honest recovery (no fabrication needed at this site).
        (local.set $vname (call $ident_at_p (local.get $tokens) (local.get $p)))
        (if (i32.eqz (local.get $vname))
          (then (br $done)))
        (local.set $p2 (i32.add (local.get $p) (i32.const 1)))
        (local.set $p2ws (call $skip_ws_p (local.get $tokens) (local.get $p2)))
        ;; Per Hβ.parser.record-field-variant-substrate (2026-05-09):
        ;; check for { record-fields } before ( paren-fields. Wheel-source
        ;; uses BOTH forms (paren-fields in src/types.mn ADTs without
        ;; field names; record-fields in lib/ml/autodiff.mn TapeEntry +
        ;; src/types.mn record-shaped variants). Mirror $parse_type_stmt's
        ;; nominal-record pattern at lines 28-52: parse record fields via
        ;; $parse_record_type_fields, wrap in mk_TyRecord, store as a
        ;; 1-element field_tys list (uniform with the variant_tys shape
        ;; downstream lower expects).
        (if (call $at (local.get $tokens) (local.get $p2ws) (i32.const 47)) ;; TLBrace
          (then
            (local.set $fields_r (call $parse_record_type_fields
              (local.get $tokens)
              (call $skip_ws_p (local.get $tokens) (i32.add (local.get $p2ws) (i32.const 1)))))
            (local.set $rec_fields (call $list_index (local.get $fields_r) (i32.const 0)))
            (local.set $ty_record (call $mk_TyRecord (local.get $rec_fields)))
            (local.set $fields (call $make_list (i32.const 1)))
            (drop (call $list_set (local.get $fields) (i32.const 0) (local.get $ty_record)))
            (local.set $p3 (call $list_index (local.get $fields_r) (i32.const 1))))
          (else
            (if (call $at (local.get $tokens) (local.get $p2) (i32.const 45)) ;; TLParen
              (then
                (local.set $fields_r (call $parse_variant_fields (local.get $tokens)
                  (call $skip_ws_p (local.get $tokens) (i32.add (local.get $p2) (i32.const 1)))))
                (local.set $fields (call $list_index (local.get $fields_r) (i32.const 0)))
                (local.set $p3 (call $list_index (local.get $fields_r) (i32.const 1))))
              (else
                (local.set $fields (call $make_list (i32.const 0)))
                (local.set $p3 (local.get $p2))))))
        ;; Build variant tuple (name, fields)
        (local.set $variant (call $make_list (i32.const 2)))
        (drop (call $list_set (local.get $variant) (i32.const 0) (local.get $vname)))
        (drop (call $list_set (local.get $variant) (i32.const 1) (local.get $fields)))
        ;; Append
        (local.set $buf (call $list_extend_to (local.get $buf)
          (i32.add (local.get $count) (i32.const 1))))
        (drop (call $list_set (local.get $buf) (local.get $count) (local.get $variant)))
        (local.set $count (i32.add (local.get $count) (i32.const 1)))
        ;; Check for | separator. /// doc-comments between variants
        ;; attach to the FOLLOWING variant (DS-docstring-edge); the
        ;; variant list continues through them on both sides of `|`.
        (local.set $p4 (call $skip_ws_p (local.get $tokens) (local.get $p3)))
        (block $doc_done
          (loop $doc_skip
            (br_if $doc_done (i32.eqz
              (call $is_doc_comment_at (local.get $tokens) (local.get $p4))))
            (local.set $p4 (call $skip_ws_p (local.get $tokens)
              (i32.add (local.get $p4) (i32.const 1))))
            (br $doc_skip)))
        (if (call $at (local.get $tokens) (local.get $p4) (i32.const 64)) ;; TPipe
          (then
            (local.set $p (call $skip_ws_p (local.get $tokens) (i32.add (local.get $p4) (i32.const 1))))
            (block $doc_done2
              (loop $doc_skip2
                (br_if $doc_done2 (i32.eqz
                  (call $is_doc_comment_at (local.get $tokens) (local.get $p))))
                (local.set $p (call $skip_ws_p (local.get $tokens)
                  (i32.add (local.get $p) (i32.const 1))))
                (br $doc_skip2)))
            (br $vars))
          (else
            (local.set $p (local.get $p4))
            (br $done)))))
    (local.set $tup (call $make_list (i32.const 2)))
    (drop (call $list_set (local.get $tup) (i32.const 0)
      (call $slice (local.get $buf) (i32.const 0) (local.get $count))))
    (drop (call $list_set (local.get $tup) (i32.const 1) (local.get $p)))
    (local.get $tup))

  ;; parse_variant_fields: comma-sep type expressions until RParen
  (func $parse_variant_fields (param $tokens i32) (param $pos i32) (result i32)
    (local $p i32) (local $buf i32) (local $count i32)
    (local $ty_r i32) (local $ty i32) (local $p2 i32) (local $p3 i32) (local $tup i32)
    (local.set $p (call $skip_ws_p (local.get $tokens) (local.get $pos)))
    (if (call $at (local.get $tokens) (local.get $p) (i32.const 46)) ;; TRParen
      (then
        (local.set $tup (call $make_list (i32.const 2)))
        (drop (call $list_set (local.get $tup) (i32.const 0) (call $make_list (i32.const 0))))
        (drop (call $list_set (local.get $tup) (i32.const 1) (i32.add (local.get $p) (i32.const 1))))
        (return (local.get $tup))))
    (local.set $buf (call $make_list (i32.const 4)))
    (local.set $count (i32.const 0))
    (block $done
      (loop $fields
        (local.set $ty_r (call $parse_type_ty (local.get $tokens) (local.get $p)))
        (local.set $ty (call $list_index (local.get $ty_r) (i32.const 0)))
        (local.set $p2 (call $list_index (local.get $ty_r) (i32.const 1)))
        (local.set $buf (call $list_extend_to (local.get $buf)
          (i32.add (local.get $count) (i32.const 1))))
        (drop (call $list_set (local.get $buf) (local.get $count) (local.get $ty)))
        (local.set $count (i32.add (local.get $count) (i32.const 1)))
        (local.set $p3 (call $skip_ws_p (local.get $tokens) (local.get $p2)))
        (if (call $at (local.get $tokens) (local.get $p3) (i32.const 51)) ;; TComma
          (then
            (local.set $p (call $skip_ws_p (local.get $tokens) (i32.add (local.get $p3) (i32.const 1))))
            (br $fields))
          (else
            (local.set $p (call $expect (local.get $tokens) (local.get $p3) (i32.const 46)))
            (br $done)))))
    (local.set $tup (call $make_list (i32.const 2)))
    (drop (call $list_set (local.get $tup) (i32.const 0)
      (call $slice (local.get $buf) (i32.const 0) (local.get $count))))
    (drop (call $list_set (local.get $tup) (i32.const 1) (local.get $p)))
    (local.get $tup))

  ;; ═══ Effect Declaration Parser (Complete) ══════════════════════════
  ;; effect Name { op(Type) -> RetType, ... }

  (func $parse_effect_stmt (param $tokens i32) (param $pos i32) (param $span i32) (result i32)
    (local $name i32) (local $p i32) (local $ops_r i32) (local $tup i32)
    (local.set $name (call $ident_at_p (local.get $tokens) (local.get $pos)))
    ;; Null return per protocol_parser_fabrication_substrate.md means
    ;; "no TIdent at this position." Substrate-honest recovery:
    ;; produce NErrorStmt sentinel + advance pos by 1.
    (if (i32.eqz (local.get $name))
      (then
        (local.set $tup (call $make_list (i32.const 2)))
        (drop (call $list_set (local.get $tup) (i32.const 0)
          (call $nstmt (call $mk_NErrorStmt (i32.const 1)) (local.get $span))))
        (drop (call $list_set (local.get $tup) (i32.const 1)
          (i32.add (local.get $pos) (i32.const 1))))
        (return (local.get $tup))))
    (local.set $p (call $skip_ws_p (local.get $tokens) (i32.add (local.get $pos) (i32.const 1))))
    (local.set $p (call $expect (local.get $tokens) (local.get $p) (i32.const 47))) ;; TLBrace
    (local.set $ops_r (call $parse_effect_ops (local.get $tokens)
      (call $skip_ws_p (local.get $tokens) (local.get $p))))
    (local.set $tup (call $make_list (i32.const 2)))
    (drop (call $list_set (local.get $tup) (i32.const 0)
      (call $nstmt
        (call $mk_EffectDeclStmt (local.get $name)
          (call $list_index (local.get $ops_r) (i32.const 0)))
        (local.get $span))))
    (drop (call $list_set (local.get $tup) (i32.const 1)
      (call $list_index (local.get $ops_r) (i32.const 1))))
    (local.get $tup))

  ;; parse_effect_ops: op(params) -> ret, ... until }
  ;; Each op is a 3-tuple (name, param_types, ret_type).

  (func $parse_effect_ops (param $tokens i32) (param $pos i32) (result i32)
    (local $p i32) (local $buf i32) (local $count i32) (local $op_name i32)
    (local $p2 i32) (local $params_r i32) (local $params i32) (local $p3 i32)
    (local $ret_r i32) (local $ret_ty i32) (local $p4 i32) (local $op i32)
    (local $tup i32)
    (local.set $buf (call $make_list (i32.const 4)))
    (local.set $count (i32.const 0))
    (local.set $p (call $skip_ws_p (local.get $tokens) (local.get $pos)))
    (block $done
      (loop $ops
        ;; Check } or EOF
        (if (i32.or
              (call $at (local.get $tokens) (local.get $p) (i32.const 48))  ;; TRBrace
              (call $at (local.get $tokens) (local.get $p) (i32.const 69))) ;; TEof
          (then
            (local.set $p (i32.add (local.get $p) (i32.const 1)))
            (br $done)))
        ;; Op name — null return per protocol_parser_fabrication_substrate.md
        ;; means "no TIdent at this position." Advance past the bad
        ;; token + skip separators, continue loop. Substrate-honest
        ;; recovery (no fabrication needed).
        (local.set $op_name (call $ident_at_p (local.get $tokens) (local.get $p)))
        (if (i32.eqz (local.get $op_name))
          (then
            (local.set $p (i32.add (local.get $p) (i32.const 1)))
            (local.set $p (call $skip_sep (local.get $tokens) (local.get $p)))
            (br $ops)))
        ;; Parse (param types)
        (local.set $p2 (call $expect (local.get $tokens)
          (call $skip_ws_p (local.get $tokens) (i32.add (local.get $p) (i32.const 1)))
          (i32.const 45))) ;; TLParen
        (local.set $params_r (call $parse_op_param_types (local.get $tokens)
          (call $skip_ws_p (local.get $tokens) (local.get $p2))))
        (local.set $params (call $list_index (local.get $params_r) (i32.const 0)))
        (local.set $p3 (call $skip_ws_p (local.get $tokens)
          (call $list_index (local.get $params_r) (i32.const 1))))
        ;; Optional -> return type
        (if (call $at (local.get $tokens) (local.get $p3) (i32.const 34)) ;; TArrow
          (then
            (local.set $ret_r (call $parse_type_ty (local.get $tokens)
              (call $skip_ws_p (local.get $tokens) (i32.add (local.get $p3) (i32.const 1)))))
            (local.set $ret_ty (call $list_index (local.get $ret_r) (i32.const 0)))
            (local.set $p4 (call $list_index (local.get $ret_r) (i32.const 1))))
          (else
            (local.set $ret_ty (i32.const 204)) ;; TyUnit
            (local.set $p4 (local.get $p3))))
        ;; Build op 3-tuple (name, params, ret)
        (local.set $op (call $make_list (i32.const 3)))
        (drop (call $list_set (local.get $op) (i32.const 0) (local.get $op_name)))
        (drop (call $list_set (local.get $op) (i32.const 1) (local.get $params)))
        (drop (call $list_set (local.get $op) (i32.const 2) (local.get $ret_ty)))
        ;; Append
        (local.set $buf (call $list_extend_to (local.get $buf)
          (i32.add (local.get $count) (i32.const 1))))
        (drop (call $list_set (local.get $buf) (local.get $count) (local.get $op)))
        (local.set $count (i32.add (local.get $count) (i32.const 1)))
        ;; Per protocol_cursor_is_the_substrate.md (2026-05-07) Phase B:
        ;; resume cardinality is INFERRED from each handler arm body,
        ;; not declared on the effect op. The @resume= annotation has
        ;; been erased from all wheel sources; effect-op declarations
        ;; end at the return type. No skip-annotation step — only
        ;; whitespace + separator before the next op. Drift refused: 8
        ;; (no string-keyed-mode flag for resume kind; the body IS the
        ;; contract) and a stale-annotation @resume= now produces a
        ;; deliberate parse error rather than being silently skipped.
        (local.set $p4 (call $skip_ws_p (local.get $tokens) (local.get $p4)))
        ;; Skip separators
        (local.set $p (call $skip_sep (local.get $tokens) (local.get $p4)))
        (br $ops)))
    (local.set $tup (call $make_list (i32.const 2)))
    (drop (call $list_set (local.get $tup) (i32.const 0)
      (call $slice (local.get $buf) (i32.const 0) (local.get $count))))
    (drop (call $list_set (local.get $tup) (i32.const 1) (local.get $p)))
    (local.get $tup))

  ;; parse_op_param_types: comma-sep types until RParen
  (func $parse_op_param_types (param $tokens i32) (param $pos i32) (result i32)
    (local $p i32) (local $buf i32) (local $count i32)
    (local $ty_r i32) (local $ty i32) (local $p2 i32) (local $p3 i32) (local $tup i32)
    (local.set $p (call $skip_ws_p (local.get $tokens) (local.get $pos)))
    (if (call $at (local.get $tokens) (local.get $p) (i32.const 46)) ;; TRParen
      (then
        (local.set $tup (call $make_list (i32.const 2)))
        (drop (call $list_set (local.get $tup) (i32.const 0) (call $make_list (i32.const 0))))
        (drop (call $list_set (local.get $tup) (i32.const 1) (i32.add (local.get $p) (i32.const 1))))
        (return (local.get $tup))))
    (local.set $buf (call $make_list (i32.const 4)))
    (local.set $count (i32.const 0))
    (block $done
      (loop $types
        ;; Optional `name : ` prefix per SYNTAX.md: effect-op params take
        ;; `name: Type` form (`load_i32(addr: Int) -> Int`). The seed
        ;; scans past TIdent + TColon when both present so $parse_type_ty
        ;; lands on the type position; otherwise the bare-type form
        ;; `load_i32(Int) -> Int` still parses unchanged. TIdent is a
        ;; FIELDED kind — detection reads $at (kind_tag_at projection);
        ;; the prior raw kind_at compare was dead for every named param,
        ;; so `check(condition: Bool, msg: String)` registered ONE
        ;; garbage param TyName("condition") and arm-arg binding read
        ;; past the params list.
        (if (i32.and
              (call $at (local.get $tokens) (local.get $p)
                    (i32.const 25))   ;; TIdent
              (call $at (local.get $tokens)
                    (i32.add (local.get $p) (i32.const 1))
                    (i32.const 53)))  ;; TColon
          (then
            (local.set $p (call $skip_ws_p (local.get $tokens)
              (i32.add (local.get $p) (i32.const 2))))))
        (local.set $ty_r (call $parse_type_ty (local.get $tokens) (local.get $p)))
        (local.set $ty (call $list_index (local.get $ty_r) (i32.const 0)))
        (local.set $p2 (call $list_index (local.get $ty_r) (i32.const 1)))
        (local.set $buf (call $list_extend_to (local.get $buf)
          (i32.add (local.get $count) (i32.const 1))))
        (drop (call $list_set (local.get $buf) (local.get $count) (local.get $ty)))
        (local.set $count (i32.add (local.get $count) (i32.const 1)))
        (local.set $p3 (call $skip_ws_p (local.get $tokens) (local.get $p2)))
        (if (call $at (local.get $tokens) (local.get $p3) (i32.const 51)) ;; TComma
          (then
            (local.set $p (call $skip_ws_p (local.get $tokens) (i32.add (local.get $p3) (i32.const 1))))
            (br $types))
          (else
            (local.set $p (call $expect (local.get $tokens) (local.get $p3) (i32.const 46)))
            (br $done)))))
    (local.set $tup (call $make_list (i32.const 2)))
    (drop (call $list_set (local.get $tup) (i32.const 0)
      (call $slice (local.get $buf) (i32.const 0) (local.get $count))))
    (drop (call $list_set (local.get $tup) (i32.const 1) (local.get $p)))
    (local.get $tup))
