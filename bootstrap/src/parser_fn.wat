  ;; ═══ Function Statement Parser (Complete) ═══════════════════════════
  ;; Hand-transcribed from src/parser.mn lines 367-441.
  ;;
  ;; fn name(params) [-> retty] [with effects] = body
  ;;
  ;; TParam(name, ty, own_marker, own_marker) → [tag=190][name][ty][own][own]
  ;; Ownership: Inferred=170, Own=171, Ref=172
  ;; Type sentinels: TyInt=200, TyFloat=201, TyString=202, TyBool=203,
  ;;                 TyUnit=204, TyName=205(fielded), TyVar=206(fielded)

  ;; TParam constructor
  (func $mk_TParam (param $name i32) (param $ty i32) (param $own i32) (result i32)
    (local $p i32) (local.set $p (call $alloc (i32.const 20)))
    (i32.store (local.get $p) (i32.const 190))
    (i32.store offset=4 (local.get $p) (local.get $name))
    (i32.store offset=8 (local.get $p) (local.get $ty))
    (i32.store offset=12 (local.get $p) (local.get $own))
    (i32.store offset=16 (local.get $p) (local.get $own))
    (local.get $p))

  ;; TyName(name) → [tag=205][name]
  (func $mk_TyName (param $name i32) (result i32)
    (local $p i32) (local.set $p (call $alloc (i32.const 8)))
    (i32.store (local.get $p) (i32.const 205))
    (i32.store offset=4 (local.get $p) (local.get $name))
    (local.get $p))

  ;; TyVar(handle) → [tag=206][handle]
  (func $mk_TyVar (param $h i32) (result i32)
    (local $p i32) (local.set $p (call $alloc (i32.const 8)))
    (i32.store (local.get $p) (i32.const 206))
    (i32.store offset=4 (local.get $p) (local.get $h))
    (local.get $p))

  ;; TyRecord(fields) → [tag=207][fields]
  ;; Fields are a list of 2-tuples (name, parser-Ty).
  (func $mk_TyRecord (param $fields i32) (result i32)
    (local $p i32) (local.set $p (call $alloc (i32.const 8)))
    (i32.store (local.get $p) (i32.const 207))
    (i32.store offset=4 (local.get $p) (local.get $fields))
    (local.get $p))

  ;; TyTuple(elems) → [tag=208][elems]; elems is a list of parser-Tys.
  (func $mk_TyTuple (param $elems i32) (result i32)
    (local $p i32) (local.set $p (call $alloc (i32.const 8)))
    (i32.store (local.get $p) (i32.const 208))
    (i32.store offset=4 (local.get $p) (local.get $elems))
    (local.get $p))

  ;; TyList(elem) → [tag=209][elem]
  (func $mk_TyList (param $elem i32) (result i32)
    (local $p i32) (local.set $p (call $alloc (i32.const 8)))
    (i32.store (local.get $p) (i32.const 209))
    (i32.store offset=4 (local.get $p) (local.get $elem))
    (local.get $p))

  ;; TyFun(params_ty, ret_ty) → [tag=210][params][ret]. params is the
  ;; LHS parser-Ty as written (TyTuple for `(A, B) -> C`, single ty for
  ;; `A -> B`); the converter unpacks. The annotation's structure IS
  ;; user-proven info — discarding it (the prior "return rhs" form)
  ;; bound `f: (Int) -> Int` to Int and made every call of f a false
  ;; type mismatch.
  (func $mk_TyFun (param $params i32) (param $ret i32) (result i32)
    (local $p i32) (local.set $p (call $alloc (i32.const 12)))
    (i32.store (local.get $p) (i32.const 210))
    (i32.store offset=4 (local.get $p) (local.get $params))
    (i32.store offset=8 (local.get $p) (local.get $ret))
    (local.get $p))

  ;; ─── parse_type_ty: type expression parser ────────────────────────
  ;; Int → 200, Float → 201, String → 202, Bool → TyName("Bool"),
  ;; Unit → 204, other ident → TyName(v), () → TyUnit
  ;; Returns (ty, new_pos) as 2-tuple.

  ;; Data segments for type name comparison (safe region 536+)
  ;; "Int" at 536, "Float" at 544, "String" at 552, "Bool" at 564, "Unit" at 572
  ;; These need length prefixes for str_eq comparison.

  ;; $skip_ty_args_p — advance past `<TypeArg, ...>` block. Per
  ;; Hβ.parser.type-app-skip (2026-05-09): wheel-source uses generic
  ;; type application (`List<Float>`, `List<List<Float>>`, etc.); the
  ;; seed's $parse_type_ty doesn't yet structure TyApp. Pre-fix the
  ;; parser left `<...>` after TyName, breaking surrounding parse
  ;; contexts (record-field, fn-param) and cascading into 6500+
  ;; LUnresolved names. Substrate-honest pre-L1: skip the block, treat
  ;; ident as opaque type at infer; named follow-up Hβ.parser.type-app-
  ;; structured (post-L1) emits TyApp(TyName, args) for proper
  ;; substitution in HM unification.
  ;;
  ;; Token codes: TLt=61, TGt=62. Tracks nesting depth for nested
  ;; `<List<Float>>` cases. Halts at TEof, TLBrace, TRBrace, TComma,
  ;; TRParen — natural termination boundaries.
  (func $skip_ty_args_p (param $tokens i32) (param $pos i32) (result i32)
    (local $depth i32) (local $k i32)
    (local.set $k (call $kind_at (local.get $tokens) (local.get $pos)))
    (if (i32.ne (local.get $k) (i32.const 61))   ;; not TLt
      (then (return (local.get $pos))))
    (local.set $depth (i32.const 1))
    (local.set $pos (i32.add (local.get $pos) (i32.const 1)))
    (block $done
      (loop $scan
        (local.set $k (call $kind_at (local.get $tokens) (local.get $pos)))
        (br_if $done (i32.eq (local.get $k) (i32.const 69)))   ;; TEof
        (if (i32.eq (local.get $k) (i32.const 61))             ;; TLt
          (then (local.set $depth (i32.add (local.get $depth) (i32.const 1)))))
        (if (i32.eq (local.get $k) (i32.const 62))             ;; TGt
          (then
            (local.set $depth (i32.sub (local.get $depth) (i32.const 1)))
            (if (i32.eqz (local.get $depth))
              (then
                (local.set $pos (i32.add (local.get $pos) (i32.const 1)))
                (br $done)))))
        (local.set $pos (i32.add (local.get $pos) (i32.const 1)))
        (br $scan)))
    (local.get $pos))

  ;; Per Hβ.parser.arrow-type-substrate (2026-05-10): after the base
  ;; type is parsed, check for TArrow. If present, this is a fn-type
  ;; like `() -> A` (effect-op signature, SYNTAX.md §678-720; nested
  ;; fn-types in type annotations, §1244 `fn() -> () with E`). The seed
  ;; doesn't structure fn-types — wheel-side HM inference projects
  ;; them via TFun substrate — but the parser must consume the `-> R`
  ;; tokens so subsequent parser-state lands at the next field/comma/
  ;; close. Without this, fn-type tokens leaked into following stmt
  ;; parses (which previously cascaded through the captures-len leak;
  ;; closed by Hβ.first-light.fnstmt-fresh-captures-len, but the parser
  ;; gap remains and is closed here for SYNTAX-honest token consumption).
  ;; Recursive: `T1 -> T2 -> T3` consumes all arrows.
  (func $parse_type_ty (param $tokens i32) (param $pos i32) (result i32)
    (local $tup i32) (local $base_pos i32) (local $arrow_pos i32) (local $rhs_r i32)
    (local $out i32)
    (local.set $tup (call $parse_type_ty_atom (local.get $tokens) (local.get $pos)))
    (local.set $base_pos (call $list_index (local.get $tup) (i32.const 1)))
    (local.set $arrow_pos (call $skip_ws_p (local.get $tokens) (local.get $base_pos)))
    (if (call $at (local.get $tokens) (local.get $arrow_pos) (i32.const 34))   ;; TArrow
      (then
        (local.set $rhs_r (call $parse_type_ty (local.get $tokens)
          (call $skip_ws_p (local.get $tokens) (i32.add (local.get $arrow_pos) (i32.const 1)))))
        ;; Fn-type annotation: TyFun(base, ret) keeps the structure the
        ;; user wrote; the converter unpacks params from base.
        (local.set $out (call $make_list (i32.const 2)))
        (drop (call $list_set (local.get $out) (i32.const 0)
          (call $mk_TyFun
            (call $list_index (local.get $tup) (i32.const 0))
            (call $list_index (local.get $rhs_r) (i32.const 0)))))
        (drop (call $list_set (local.get $out) (i32.const 1)
          (call $list_index (local.get $rhs_r) (i32.const 1))))
        (return (local.get $out))))
    (local.get $tup))

  ;; Atom: TIdent (with optional <TypeArgs>) or `(...)` paren-form.
  (func $parse_type_ty_atom (param $tokens i32) (param $pos i32) (result i32)
    (local $k i32) (local $name i32) (local $tup i32) (local $p i32) (local $next i32)
    (local.set $k (call $kind_at (local.get $tokens) (local.get $pos)))
    ;; TIdent → check for known type names
    (if (i32.and
          (i32.eqz (call $is_sentinel (local.get $k)))
          (i32.eq (call $tag_of (local.get $k)) (i32.const 25)))
      (then
        (local.set $name (i32.load offset=4 (local.get $k)))
        (local.set $tup (call $make_list (i32.const 2)))
        ;; Compute next-pos including any optional `<TypeArgs>` block.
        (local.set $next
          (call $skip_ty_args_p (local.get $tokens)
            (i32.add (local.get $pos) (i32.const 1))))
        ;; Check known names via first char + length
        (if (i32.and (i32.eq (call $str_len (local.get $name)) (i32.const 3))
                     (i32.eq (call $byte_at (local.get $name) (i32.const 0)) (i32.const 73))) ;; 'I'
          (then ;; "Int"
            (drop (call $list_set (local.get $tup) (i32.const 0) (i32.const 200)))
            (drop (call $list_set (local.get $tup) (i32.const 1) (local.get $next)))
            (return (local.get $tup))))
        (if (i32.and (i32.eq (call $str_len (local.get $name)) (i32.const 5))
                     (i32.eq (call $byte_at (local.get $name) (i32.const 0)) (i32.const 70))) ;; 'F'
          (then ;; "Float"
            (drop (call $list_set (local.get $tup) (i32.const 0) (i32.const 201)))
            (drop (call $list_set (local.get $tup) (i32.const 1) (local.get $next)))
            (return (local.get $tup))))
        (if (i32.and (i32.eq (call $str_len (local.get $name)) (i32.const 6))
                     (i32.eq (call $byte_at (local.get $name) (i32.const 0)) (i32.const 83))) ;; 'S'
          (then ;; "String"
            (drop (call $list_set (local.get $tup) (i32.const 0) (i32.const 202)))
            (drop (call $list_set (local.get $tup) (i32.const 1) (local.get $next)))
            (return (local.get $tup))))
        (if (i32.and (i32.eq (call $str_len (local.get $name)) (i32.const 4))
                     (i32.eq (call $byte_at (local.get $name) (i32.const 0)) (i32.const 85))) ;; 'U'
          (then ;; "Unit"
            (drop (call $list_set (local.get $tup) (i32.const 0) (i32.const 204)))
            (drop (call $list_set (local.get $tup) (i32.const 1) (local.get $next)))
            (return (local.get $tup))))
        ;; Default: TyName(name)
        (drop (call $list_set (local.get $tup) (i32.const 0) (call $mk_TyName (local.get $name))))
        (drop (call $list_set (local.get $tup) (i32.const 1) (local.get $next)))
        (return (local.get $tup))))
    ;; TLParen → `()` TyUnit | `(T)` grouping | `(T1, T2, ...)` TyTuple.
    (if (i32.and (call $is_sentinel (local.get $k)) (i32.eq (local.get $k) (i32.const 45)))
      (then
        (local.set $p (call $skip_ws_p (local.get $tokens) (i32.add (local.get $pos) (i32.const 1))))
        (if (call $at (local.get $tokens) (local.get $p) (i32.const 46)) ;; TRParen
          (then
            (local.set $tup (call $make_list (i32.const 2)))
            (drop (call $list_set (local.get $tup) (i32.const 0) (i32.const 204)))
            (drop (call $list_set (local.get $tup) (i32.const 1) (i32.add (local.get $p) (i32.const 1))))
            (return (local.get $tup))))
        (return (call $parse_type_ty_paren_tail (local.get $tokens) (local.get $p)))))
    ;; TLBracket → `[T]` TyList.
    (if (i32.and (call $is_sentinel (local.get $k)) (i32.eq (local.get $k) (i32.const 49)))
      (then
        (local.set $tup (call $parse_type_ty (local.get $tokens)
          (call $skip_ws_p (local.get $tokens) (i32.add (local.get $pos) (i32.const 1)))))
        (local.set $p (call $expect (local.get $tokens)
          (call $skip_ws_p (local.get $tokens)
            (call $list_index (local.get $tup) (i32.const 1)))
          (i32.const 50)))   ;; TRBracket
        (drop (call $list_set (local.get $tup) (i32.const 0)
          (call $mk_TyList (call $list_index (local.get $tup) (i32.const 0)))))
        (drop (call $list_set (local.get $tup) (i32.const 1) (local.get $p)))
        (return (local.get $tup))))
    ;; TLBrace → `{name: Ty, ...}` structural record TYPE. One arm makes
    ;; record types live at EVERY type position — variant payloads
    ;; (`Ctor({...})`), fn annotations, op params. Pre-fix the fallback
    ;; fabricated TyInfer and the brace innards leaked to statement
    ;; position as expressions (type names then missed env as variables).
    (if (i32.and (call $is_sentinel (local.get $k)) (i32.eq (local.get $k) (i32.const 47)))
      (then
        (local.set $tup (call $parse_record_type_fields (local.get $tokens)
          (call $skip_ws_p (local.get $tokens) (i32.add (local.get $pos) (i32.const 1)))))
        (drop (call $list_set (local.get $tup) (i32.const 0)
          (call $mk_TyRecord (call $list_index (local.get $tup) (i32.const 0)))))
        (return (local.get $tup))))
    ;; Unknown type form: TyInfer (199) — "the graph will prove it".
    ;; The prior form returned TyUnit, a CONCRETE LIE that unification
    ;; then enforced against every use of the annotated binding.
    (local.set $tup (call $make_list (i32.const 2)))
    (drop (call $list_set (local.get $tup) (i32.const 0) (i32.const 199)))
    (drop (call $list_set (local.get $tup) (i32.const 1) (i32.add (local.get $pos) (i32.const 1))))
    (local.get $tup))

  ;; Paren tail after `(` with at least one inner type: parse the
  ;; comma-list; one element is grouping, two-plus is TyTuple.
  (func $parse_type_ty_paren_tail (param $tokens i32) (param $pos i32) (result i32)
    (local $p i32) (local $buf i32) (local $count i32)
    (local $elem_r i32) (local $tup i32)
    (local.set $buf (call $make_list (i32.const 4)))
    (local.set $count (i32.const 0))
    (local.set $p (local.get $pos))
    (block $done
      (loop $elems
        (local.set $elem_r (call $parse_type_ty (local.get $tokens) (local.get $p)))
        (local.set $buf (call $list_extend_to (local.get $buf)
          (i32.add (local.get $count) (i32.const 1))))
        (drop (call $list_set (local.get $buf) (local.get $count)
          (call $list_index (local.get $elem_r) (i32.const 0))))
        (local.set $count (i32.add (local.get $count) (i32.const 1)))
        (local.set $p (call $skip_ws_p (local.get $tokens)
          (call $list_index (local.get $elem_r) (i32.const 1))))
        (if (call $at (local.get $tokens) (local.get $p) (i32.const 51))   ;; TComma
          (then
            (local.set $p (call $skip_ws_p (local.get $tokens)
              (i32.add (local.get $p) (i32.const 1))))
            (br $elems))
          (else
            (local.set $p (call $expect (local.get $tokens) (local.get $p)
              (i32.const 46)))   ;; TRParen
            (br $done)))))
    (local.set $tup (call $make_list (i32.const 2)))
    (if (i32.eq (local.get $count) (i32.const 1))
      (then
        ;; `(T)` — grouping, not a 1-tuple.
        (drop (call $list_set (local.get $tup) (i32.const 0)
          (call $list_index (local.get $buf) (i32.const 0)))))
      (else
        (drop (call $list_set (local.get $tup) (i32.const 0)
          (call $mk_TyTuple
            (call $slice (local.get $buf) (i32.const 0) (local.get $count)))))))
    (drop (call $list_set (local.get $tup) (i32.const 1) (local.get $p)))
    (local.get $tup))

  ;; ─── parse_one_param ──────────────────────────────────────────────
  ;; [own|ref] name [: Type]
  ;; Returns (TParam, new_pos) as 2-tuple.

  (func $parse_one_param (param $tokens i32) (param $pos i32) (result i32)
    (local $own i32) (local $p i32) (local $name i32) (local $p2 i32)
    (local $ty_r i32) (local $ty i32) (local $tup i32) (local $k i32)
    ;; Check ownership marker
    (local.set $k (call $kind_at (local.get $tokens) (local.get $pos)))
    (local.set $own (i32.const 170)) ;; Unmarked
    (local.set $p (local.get $pos))
    (if (i32.eq (local.get $k) (i32.const 20)) ;; TOwn
      (then
        (local.set $own (i32.const 171))
        (local.set $p (call $skip_ws_p (local.get $tokens) (i32.add (local.get $pos) (i32.const 1))))))
    (if (i32.eq (local.get $k) (i32.const 21)) ;; TRef
      (then
        (local.set $own (i32.const 172))
        (local.set $p (call $skip_ws_p (local.get $tokens) (i32.add (local.get $pos) (i32.const 1))))))
    ;; Get param name. Null return per protocol_parser_fabrication_substrate.md
    ;; means "no TIdent at this position." Substrate-honest recovery:
    ;; return null tuple; caller loop detects + terminates ($done).
    (local.set $name (call $ident_at_p (local.get $tokens) (local.get $p)))
    (if (i32.eqz (local.get $name))
      (then (return (i32.const 0))))
    (local.set $p2 (call $skip_ws_p (local.get $tokens) (i32.add (local.get $p) (i32.const 1))))
    ;; Check for : Type annotation
    (if (call $at (local.get $tokens) (local.get $p2) (i32.const 53)) ;; TColon
      (then
        (local.set $ty_r (call $parse_type_ty (local.get $tokens)
          (call $skip_ws_p (local.get $tokens) (i32.add (local.get $p2) (i32.const 1)))))
        (local.set $ty (call $list_index (local.get $ty_r) (i32.const 0)))
        (local.set $p2 (call $list_index (local.get $ty_r) (i32.const 1))))
      (else
        ;; No annotation → TyVar(fresh)
        (local.set $ty (call $mk_TyVar (call $fresh_handle)))))
    (local.set $tup (call $make_list (i32.const 2)))
    (drop (call $list_set (local.get $tup) (i32.const 0)
      (call $mk_TParam (local.get $name) (local.get $ty) (local.get $own))))
    (drop (call $list_set (local.get $tup) (i32.const 1) (local.get $p2)))
    (local.get $tup))

  ;; ─── parse_fn_params: comma-sep params until RParen ───────────────

  (func $parse_fn_params (param $tokens i32) (param $pos i32) (result i32)
    (local $p i32) (local $buf i32) (local $count i32)
    (local $param_r i32) (local $param i32) (local $p2 i32) (local $p3 i32)
    (local $tup i32)
    (local.set $p (call $skip_ws_p (local.get $tokens) (local.get $pos)))
    ;; Empty params
    (if (call $at (local.get $tokens) (local.get $p) (i32.const 46)) ;; TRParen
      (then
        (local.set $tup (call $make_list (i32.const 2)))
        (drop (call $list_set (local.get $tup) (i32.const 0) (call $make_list (i32.const 0))))
        (drop (call $list_set (local.get $tup) (i32.const 1) (i32.add (local.get $p) (i32.const 1))))
        (return (local.get $tup))))
    (local.set $buf (call $make_list (i32.const 4)))
    (local.set $count (i32.const 0))
    (block $done
      (loop $params
        (local.set $param_r (call $parse_one_param (local.get $tokens) (local.get $p)))
        ;; Null tuple per protocol_parser_fabrication_substrate.md
        ;; means $parse_one_param hit null name. Terminate loop;
        ;; outer $expect TRParen surfaces the diagnostic.
        (if (i32.eqz (local.get $param_r))
          (then (br $done)))
        (local.set $param (call $list_index (local.get $param_r) (i32.const 0)))
        (local.set $p2 (call $list_index (local.get $param_r) (i32.const 1)))
        (local.set $buf (call $list_extend_to (local.get $buf)
          (i32.add (local.get $count) (i32.const 1))))
        (drop (call $list_set (local.get $buf) (local.get $count) (local.get $param)))
        (local.set $count (i32.add (local.get $count) (i32.const 1)))
        (local.set $p3 (call $skip_ws_p (local.get $tokens) (local.get $p2)))
        (if (call $at (local.get $tokens) (local.get $p3) (i32.const 51)) ;; TComma
          (then
            (local.set $p (call $skip_ws_p (local.get $tokens) (i32.add (local.get $p3) (i32.const 1))))
            (br $params))
          (else
            (local.set $p (call $expect (local.get $tokens) (local.get $p3) (i32.const 46)))
            (br $done)))))
    ;; Build flat result list (avoid lazy slice view)
    (local.set $param_r (call $make_list (local.get $count)))
    (local.set $p3 (i32.const 0))
    (block $cp_done (loop $cp
      (br_if $cp_done (i32.ge_u (local.get $p3) (local.get $count)))
      (drop (call $list_set (local.get $param_r) (local.get $p3)
        (call $list_index (local.get $buf) (local.get $p3))))
      (local.set $p3 (i32.add (local.get $p3) (i32.const 1)))
      (br $cp)))
    (local.set $tup (call $make_list (i32.const 2)))
    (drop (call $list_set (local.get $tup) (i32.const 0) (local.get $param_r)))
    (drop (call $list_set (local.get $tup) (i32.const 1) (local.get $p)))
    (local.get $tup))

  ;; ─── parse_fn_stmt (COMPLETE) ─────────────────────────────────────
  ;; fn name(params) [-> retty] [with effects] = body

  (func $parse_fn_stmt (param $tokens i32) (param $pos i32) (param $span i32) (result i32)
    (local $name i32) (local $p i32) (local $params_r i32) (local $params i32)
    (local $p2 i32) (local $ret i32) (local $p3 i32)
    (local $p4 i32) (local $body_r i32) (local $tup i32)
    ;; Get function name
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
    ;; Optional `<TypeParams>` per SYNTAX.md §1219 (`fn map<A, B>(...)`).
    (local.set $p (call $skip_ws_p (local.get $tokens) (i32.add (local.get $pos) (i32.const 1))))
    (local.set $p (call $skip_type_params_p (local.get $tokens) (local.get $p)))
    (local.set $p (call $skip_ws_p (local.get $tokens) (local.get $p)))
    ;; Parse (params)
    (local.set $p (call $expect (local.get $tokens) (local.get $p) (i32.const 45))) ;; TLParen
    (local.set $params_r (call $parse_fn_params (local.get $tokens) (local.get $p)))
    (local.set $params (call $list_index (local.get $params_r) (i32.const 0)))
    (local.set $p2 (call $skip_ws_p (local.get $tokens)
      (call $list_index (local.get $params_r) (i32.const 1))))
    ;; Optional -> return type
    (local.set $ret (call $nexpr (i32.const 84) (local.get $span))) ;; default LitUnit
    (if (call $at (local.get $tokens) (local.get $p2) (i32.const 34)) ;; TArrow
      (then
        (local.set $p3 (call $skip_ws_p (local.get $tokens) (i32.add (local.get $p2) (i32.const 1))))
        ;; We just skip the return type annotation for now (type is in the TParam)
        (local.set $p2 (call $skip_to_eq_or_brace (local.get $tokens) (local.get $p3)))))
    ;; Skip optional 'with effects'
    (if (call $at (local.get $tokens) (local.get $p2) (i32.const 9)) ;; TWith
      (then
        (local.set $p2 (call $skip_to_eq_or_brace (local.get $tokens)
          (i32.add (local.get $p2) (i32.const 1))))))
    ;; Skip = if present
    (if (call $at (local.get $tokens) (local.get $p2) (i32.const 60)) ;; TEq
      (then (local.set $p2 (i32.add (local.get $p2) (i32.const 1)))))
    ;; Parse body
    (local.set $p3 (call $skip_ws_p (local.get $tokens) (local.get $p2)))
    ;; Per Hβ.parser.fn-body-pipe-continuation (chain link 5 / drift-9 close):
    ;; route through parse_expr ALWAYS — including the `{` case. parse_expr
    ;; recognizes `{` via parse_primary and dispatches to parse_block, then
    ;; binop_loop picks up trailing pipe operators. The wheel canonical form
    ;;   fn compile_stdin() = {
    ;;     read_stdin() |> frontend |> ... |> emit_module
    ;;   }
    ;;     ~> wat_stdout
    ;;     ~> wasi_filesystem
    ;;     ...
    ;; only parses correctly when `{ ... } ~> handler ~> ...` is one
    ;; PipeExpr chain — parse_block alone returns the BlockExpr and
    ;; loses every trailing `~>` (perform sites then fall through to
    ;; LConst(0) at lower-time because lower_handler_stack stays empty).
    ;; TLet retains the dedicated parse_implicit_body path because
    ;; multi-line indented let-bodies don't go through parse_expr's
    ;; primary dispatch (let-stmt is statement-position, not
    ;; expression-position).
    (if (i32.eq (call $kind_at (local.get $tokens) (local.get $p3))
                (i32.const 1))   ;; TLet
      (then (local.set $body_r (call $parse_implicit_body
        (local.get $tokens) (local.get $p3) (local.get $span))))
      (else (local.set $body_r (call $parse_expr (local.get $tokens) (local.get $p3)))))
    ;; Build FnStmt
    (local.set $tup (call $make_list (i32.const 2)))
    (drop (call $list_set (local.get $tup) (i32.const 0)
      (call $nstmt
        (call $mk_FnStmt (local.get $name) (local.get $params)
          (local.get $ret) (call $make_list (i32.const 0))
          (call $list_index (local.get $body_r) (i32.const 0)))
        (local.get $span))))
    (drop (call $list_set (local.get $tup) (i32.const 1)
      (call $list_index (local.get $body_r) (i32.const 1))))
    (local.get $tup))

  ;; Helper: skip to = or { (for skipping return type and effect annotations).
  ;;
  ;; Per Hβ.parser.fn-sig-multi-line (chain link 5 / drift 9 close):
  ;; fn signatures span lines naturally — `-> Type\n    with Effects =`
  ;; is canonical SYNTAX.md form. Newlines inside the signature are
  ;; whitespace-equivalent; they do NOT terminate. Halting at TNewline
  ;; was an eager-form-commitment that made the parser surface inner
  ;; let-stmts (`let alpha = compute_alpha(...)` from the fn body) as
  ;; TOP-LEVEL stmts when the multi-line `with` clause + body bled past
  ;; the failed signature parse — name then leaked into
  ;; $ls_register_globals → spurious LGlobal($alpha) at the dependent
  ;; handler-arm capture site (process_lowpass's process arm).
  ;; Substrate-honest: signature ends at TEq, TLBrace, or TEof; period.
  (func $skip_to_eq_or_brace (param $tokens i32) (param $pos i32) (result i32)
    (local $k i32)
    (block $done (loop $scan
      (local.set $k (call $kind_at (local.get $tokens) (local.get $pos)))
      (br_if $done (i32.eq (local.get $k) (i32.const 60)))  ;; TEq
      (br_if $done (i32.eq (local.get $k) (i32.const 47)))  ;; TLBrace
      (br_if $done (i32.eq (local.get $k) (i32.const 69)))  ;; TEof
      (local.set $pos (i32.add (local.get $pos) (i32.const 1)))
      (br $scan)))
    (local.get $pos))
