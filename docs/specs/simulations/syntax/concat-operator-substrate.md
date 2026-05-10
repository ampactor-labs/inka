# `++` Concatenation Operator — Substrate Walkthrough

> *Walkthrough #1 of the SYNTAX-ULTIMATE audit per `protocol_realization_loop.md`. Locks the ULTIMATE form for `++` against the eight interrogations; resolves the rough edge identified in 2026-05-10 SYNTAX read.*

## §0 — Why this walkthrough exists

`SYNTAX.md` (line 1124, operator precedence table) declares `++` as "string + list concat" with right-associativity at precedence 9. The single overloaded operator is meant to dispatch by operand type — `TList → list_concat`, `TString → str_concat`. The spec does not yet describe the dispatch mechanism explicitly, and the empirical state of the substrate (this session, 2026-05-10) shows the dispatch surfaces as a substrate gap: `lo_stmts ++ [lo_final]` in `src/lower.mn:482` was being compiled by the seed as `(call $str_concat)` because the seed-time `lookup_ty` did not return `TList` for the operand handle, falling through to `str_concat` and producing list-corrupt output at m2 runtime.

The substrate decision must be locked: how does `++` project? At which stage? With what diagnostics? The answer must hold against the eight interrogations and the canonical-projection-pattern + emit-is-graph-projection + no-silent-fallback chain.

## §1 — Empirical state at the time of writing

Three observations from the wheel-self-compile cascade (this session):

1. **Wheel emit (`src/backends/wasm.mn:1746-1753`)** unconditionally dispatches `BConcat → str_concat` regardless of operand type. This is the root substrate gap at the emit layer — it pretends `++` is monomorphic when it isn't.

2. **Seed emit (`bootstrap/src/emit/emit_call.wat:309-322`)** has type-aware dispatch: reads `lookup_ty(left_h)`, checks `ty_tag` for `TList` (105), emits `list_concat` if so, else falls through to `str_concat`. The substrate is in place — but it relies on `lookup_ty` returning `TList` for the operand handle, which does not always happen at seed-time when infer is partial.

3. **Wheel-source uses `++` ~83 times** across `src/lower.mn` (37), `src/infer.mn` (31), `src/parser.mn` (13), `src/backends/wasm.mn` (1), `lib/runtime/strings.mn` (1), `lib/runtime/json.mn` (2), `lib/runtime/threading.mn` (1). All but ~3-4 are list-concat (the wheel rarely concatenates strings — `str_concat` is invoked directly when needed; `++` is the wheel's cons/snoc/concat workhorse).

The session's pragmatic fix substituted `++` with explicit `list_concat(L, R)` at 8 load-bearing sites in `src/lower.mn`, unsticking the trivial test `fn main() = { 1 + 2 }`. That fix is a holding pattern — the substrate-honest form lives below.

## §2 — The eight interrogations on `++`

### 1. Graph?

The `++` expression has a result handle with a `Ty` bound by infer. The infer pass at `src/infer.mn` resolves the operand types and unifies them; the result type unifies to whichever operand type the inputs share (`TList(A)` if both are `List<A>`, `TString` if both are strings). The graph carries the answer — `lookup_ty(handle)` returns the result type.

### 2. Handler?

`++` is not a handler — it's a binary operator. The PROJECTION (which runtime function fires) is read by lower at lower-time via `lookup_ty`. Lower IS the projection that reads the graph and routes to the substrate-correct call. `OneShot` resume discipline (synchronous direct call).

### 3. Verb?

The operator is consumed by `|>` (sequential) at the lower-stage. Lower walks the AST; at each `BinOpExpr(BConcat, l, r)`, lower projects forward — read the type, choose the runtime fn, produce `LCall`.

### 4. Row?

Both `list_concat` and `str_concat` declare `with Memory + Alloc` (per `lib/runtime/lists.mn:161` and `lib/runtime/strings.mn:72`). Identical row. The `++` operator's row inferred is `Memory + Alloc`, regardless of which dispatch fires. No row distinction needed.

### 5. Ownership?

Different ownership semantics:

- **`list_concat(a, b)`** allocates a tag-3 lazy concat node (`[count][tag=3][left=a][right=b]`); both `a` and `b` are stored by reference. Operands are NOT moved or copied — the snoc-tree shares storage. `list_concat` is `O(1)` in time and allocation. Operands flow as `ref` semantically.
- **`str_concat(a, b)`** allocates a fresh string of length `a.len + b.len`, copies bytes from both. Operands are read-only; the result is a new owned string. `str_concat` is `O(n+m)`. Operands flow as `ref`; result is `own`.

The ownership story differs in WHAT the result represents (shared-snoc vs fresh-copy), but the operand discipline is uniform: both inputs are borrowed.

### 6. Refinement?

`result.len = a.len + b.len` for both. The refinement is uniform across dispatch — the `len` predicate composes additively. `Verify` discharges this trivially when both operands have known length refinements.

### 7. Gradient?

This is the interrogation that drives the substrate decision. **When the type is known at compile time, the dispatch must be a direct `LCall` with no runtime type test.** Per `protocol_emit_is_graph_projection.md`: emit reads the graph; if the graph says `TList`, emit emits `list_concat`. Per `protocol_canonical_projection_pattern.md`: the projection happens at the canonical projection site (lower, where type-aware specialization belongs); emit reads the residue.

The gradient narrative for the `++` operator:
- **Type-known at lower-time** → direct `LCall(list_concat)` or `LCall(str_concat)`. No runtime dispatch. No `BConcat` ever reaches emit.
- **Type unresolved** → infer-time gap. Surfaces as `E_ConcatTypeUnresolved` Located reason via Hazel's productive-under-error sentinel; lower produces `LCall(handle, LUnresolved("concat"), [l, r])` and emit translates to `(unreachable)` with a comment.
- **Operand types differ** → `E_ConcatTypeMismatch` at infer-time (unification failure). The user's source has typed inconsistency; the diagnostic surfaces with both operand types in the Located reason.

### 8. Reason?

Each `++` site leaves a `Located(span, ConcatProjection(operand_ty))` Reason edge in the graph. The Why Engine walks back from the runtime fn name (`list_concat` or `str_concat`) through the Reason chain to the `++` site's source span and the inferred operand type.

## §3 — The ULTIMATE form

`++` is **type-polymorphic, resolved at lower-time via the operand handle's graph type**, projected to a direct runtime call:

```
BinOpExpr(BConcat, left, right) at handle h
  →  let l_ty = perform lookup_ty(handle_of(left))
     let r_ty = perform lookup_ty(handle_of(right))
     match (l_ty, r_ty) {
       (TList(_), TList(_))    => LCall(h, LGlobal(h, "list_concat"), [lower(left), lower(right)]),
       (TString, TString)      => LCall(h, LGlobal(h, "str_concat"),  [lower(left), lower(right)]),
       (_, _)                  => LUnresolvedConcat(h, lower(left), lower(right))   // surfaces as Located reason at emit
     }
```

`emit_binop`'s `BConcat` arm **disappears entirely** in the ULTIMATE form. Lower commits to one of `list_concat` / `str_concat` / `LUnresolvedConcat`; emit only sees `LCall` or `LUnresolved`.

The kernel uniformity per `DESIGN.md §0.5` holds: every `++` becomes a function call (graph-projection of a binary op into a Call node). The `BConcat` BinOp variant remains in the `BinOp` ADT as an INTERMEDIATE form during parse → infer; lower erases it.

### Why this is the residue, not a derivation

Per `protocol_cursor_is_the_substrate.md`: every subsystem is the cursor in a different mode. The cursor at `++` reads:
- the graph type (handler #1 — Graph)
- the dispatched runtime fn (handler #2 — Handler/Resume)
- direct LCall projection (handler #3 — Verb / sequential)
- Memory + Alloc row (handler #4 — Row)
- ref / ref / own result (handler #5 — Ownership)
- length-additive refinement (handler #6 — Refinement)
- compile-time-resolved dispatch (handler #7 — Gradient)
- Located reason chain (handler #8 — Reason)

All eight clear. Lower writes the residue.

## §4 — Substrate cascade

### 4.1 — `src/lower.mn`: `lower_expr_body` BinOpExpr arm specialization

Current (line 416-417):

```
BinOpExpr(op, left, right) =>
  LBinOp(handle, op, lower_expr(left), lower_expr(right)),
```

ULTIMATE form:

```
BinOpExpr(op, left, right) => {
  let lo_left = lower_expr(left)
  let lo_right = lower_expr(right)
  match op {
    BConcat => {
      let N(_, _, lh) = left
      let l_ty = perform lookup_ty(lh)
      match l_ty {
        TList(_)  => LCall(handle, LGlobal(handle, "list_concat"), [lo_left, lo_right]),
        TString   => LCall(handle, LGlobal(handle, "str_concat"),  [lo_left, lo_right]),
        _         => LUnresolved(handle, "concat:type-unresolved")
      }
    },
    _ => LBinOp(handle, op, lo_left, lo_right)
  }
}
```

- Reads operand type via `lookup_ty(lh)` — the canonical projection.
- `BinOpExpr(BConcat, ...)` becomes `LCall` (or `LUnresolved` for type-pending).
- Other binops (`BAdd`, `BSub`, `BEq`, ...) keep their `LBinOp` projection.

### 4.2 — `src/backends/wasm.mn`: `emit_binop` BConcat arm removal

Current (line 1746-1753):

```
BConcat => {
  perform wat_emit("    (local.set $callee_closure)\n")
  perform wat_emit("    (local.set $state_tmp)\n")
  perform wat_emit("    (local.get $__state)\n")
  perform wat_emit("    (local.get $state_tmp)\n")
  perform wat_emit("    (local.get $callee_closure)\n")
  perform wat_emit("    (call $str_concat)\n")
}
```

ULTIMATE form: **delete this arm**. After lower's specialization, no `LBinOp(BConcat, ...)` reaches emit_binop. If one does (substrate gap), emit_binop's match becomes inexhaustive — surfaces as `E_BConcatLeakedToEmit` at emit-time, indicating lower didn't specialize.

The match becomes:

```
fn emit_binop(op) = match op {
  BAdd    => perform wat_emit("    (i32.add)\n"),
  BSub    => perform wat_emit("    (i32.sub)\n"),
  // ... all 13 arithmetic / comparison / boolean arms ...
  // BConcat arm REMOVED — lower projects to LCall before reaching emit
}
```

### 4.3 — Seed cascade: `bootstrap/src/lower/walk_*.wat`

The seed's BConcat dispatch currently lives at emit-time (`bootstrap/src/emit/emit_call.wat:309-322`). For consistency with the wheel, **move the dispatch to seed's lower stage** in `bootstrap/src/lower/walk_compound.wat` (the BinOp lowering site). Mirror the wheel:

- Lower's BConcat handling reads `$lookup_ty(left_h)` from `bootstrap/src/lower/lookup.wat`
- If TList (tag 105) → `LCall` to `$list_concat`
- If TString (tag 102) → `LCall` to `$str_concat`
- Else → `LUnresolved` or productive-under-error sentinel

After the move, `bootstrap/src/emit/emit_call.wat:309-322` (the BConcat dispatch in `$emit_lbinop`) becomes a fallback that should never fire — keep as a safety net per `protocol_no_silent_fallback.md` discipline (named, surfaced, not silent).

### 4.4 — `LUnresolved` sentinel

Per task #107 `Hβ.lower.lunresolved-sentinel` (already landed): `LUnresolved` is the substrate-honest unresolved-name LowExpr. Extending it to cover unresolved-concat-type is the same discipline — name the failure, don't fabricate a fallback.

`emit`'s `LUnresolved` arm emits `(unreachable)` with a Located comment carrying the reason. The reason for type-unresolved-concat: `concat:type-unresolved`. The Why Engine walks back via the comment + span.

## §5 — `SYNTAX.md` revision

§Operator precedence (line 1124) currently:

| 9    | `++`                                     | right           | string + list concat           |

ULTIMATE form (preserves entry, expands semantics in a new section):

| 9    | `++`                                     | right           | concat — type-polymorphic; see §"Concatenation operator" |

Insert a new section between §"Operator precedence" and §"Layout enforcement":

> ### Concatenation operator
>
> `++` is **type-polymorphic over `TList<A>` and `TString`**, dispatched at lower-time by reading the operand's inferred type from the graph (`lookup_ty`).
>
> | Operand type           | Lower projection                                       | Runtime fn       |
> |------------------------|--------------------------------------------------------|------------------|
> | `TList<A>` ++ `TList<A>` | `LCall(handle, LGlobal("list_concat"), [l, r])`        | `list_concat`    |
> | `TString` ++ `TString`   | `LCall(handle, LGlobal("str_concat"),  [l, r])`        | `str_concat`     |
> | mixed (`TList` ++ `TString`) | `E_ConcatTypeMismatch` at infer-time             | (none)           |
> | unresolved (TVar / NFree)  | `E_ConcatTypeUnresolved` at lower-time           | (none)           |
>
> The dispatch is compile-time-only; no runtime type test. When the type is known, the operator IS a direct call. When the type is not known, the diagnostic surfaces with the operand handle's source span — the user must constrain the type (annotation, refinement, or use-site disambiguation).
>
> **Drift refusal:** `++` does NOT silently default to `str_concat` when type is unresolved. Per `protocol_no_silent_fallback.md`, the substrate names the failure rather than fabricating a fallback. The `LUnresolved` sentinel emits `(unreachable)` with a Located reason chain back to the `++` site.

## §6 — Diagnostic catalog additions

§"Diagnostic catalog" gains two new codes:

| `E_ConcatTypeMismatch`   | `++` operands have different unifiable types | adjust types so both are `TList<A>` or both `TString`; insert explicit conversion |
| `E_ConcatTypeUnresolved` | `++` operand type unresolved at lower-time   | annotate the operand or its source binding to constrain the type; check infer pass for unifies-failure-to-trace |

## §7 — Wheel cascade — sites affected

After the substrate lands, the 83 `++` usages across the wheel become uniform — every `++` projects to one of two LCall forms. No source rewrites required: the operator's surface form stays `++`; only the lower-stage projection changes. The session's pragmatic substitution (8 sites in `src/lower.mn` rewritten to explicit `list_concat`) can be **reverted** — `++` is restored, lower projects correctly.

Specifically:
- 79 list-concat sites work uniformly (lower → `LCall(list_concat)`)
- 3-4 string-concat sites work uniformly (lower → `LCall(str_concat)`)
- 0 mixed sites — wheel-source has none
- 0 unresolved sites — wheel-source's infer is complete enough

The wheel's source becomes substrate-honest at the operator level. Future modules (DSP, ML, tutorial) inherit the discipline.

## §8 — Edge cases

**Empty operand:** `[] ++ rest` and `rest ++ []`. `list_concat`'s implementation at `lib/runtime/lists.mn:161` already short-circuits — returns `b` if `len_a == 0`, returns `a` if `len_b == 0`, no allocation. The lower projection is uniform; the runtime handles the empty case. No special syntax case.

**Single-element operands:** `[x] ++ rest` and `rest ++ [x]`. These compose via `list_concat` into tag-3 concat nodes. The runtime's `list_index` traverses tag-3 by left/right dispatch — `O(log N)` for balanced concat trees, degrades to `O(N)` for left-heavy / right-heavy chains. Acceptable for compile-time data; for runtime hot paths use `list_extend_to` + `list_set` (buffer-counter discipline per `CLAUDE.md`).

**Triple-string interpolation `++`:** `"hello, " ++ name ++ "!"`. Three operands, two `++` ops, right-associative (precedence 9 right-assoc per the table). Each `++` projects independently. The string interpolation `{name}` substrate (per §"Strings") is a separate path; `++` on already-rendered strings goes through the standard `str_concat` projection.

**Refinement preservation:** if `a: List<A> where len(self) > 0` and `b: List<A>`, then `a ++ b: List<A> where len(self) > 0`. Refinement composition propagates additively through `++`. Verify discharges this at construction sites.

**Effect row:** both `list_concat` and `str_concat` carry `with Memory + Alloc`. The `++` site's row inherits this via the `LCall` projection — no special handling. `Pure` violations at the `++` site surface as `E_PurityViolated` per the standard discipline.

## §9 — Named peer follow-ups (positive form per drift mode 9)

These cascade after the walkthrough lands. Each is a positive-form handle, not a deferral:

- **`Hβ.syntax.concat-lower-specialization`** — implement §4.1 (wheel src/lower.mn) + §4.2 (delete emit_binop's BConcat arm).
- **`Hβ.syntax.concat-seed-cascade`** — implement §4.3 (move seed dispatch from emit-time to lower-time).
- **`Hβ.syntax.concat-diagnostic-emit`** — implement §6 (E_ConcatTypeMismatch at infer; E_ConcatTypeUnresolved at lower; Located reason via `LUnresolved`).
- **`Hβ.syntax.concat-doc-revise`** — implement §5 (SYNTAX.md "Concatenation operator" section + precedence-table comment update).
- **`Hβ.syntax.concat-revert-pragmatic-sites`** — revert this session's 8 substitutions in `src/lower.mn` after the substrate lands (restore `++`).

## §10 — Verification

After the cascade, the empirical tests:

```
echo 'fn main() = { 1 + 2 }' | wasmtime run /tmp/m2.wasm
# expected: $main body = (i32.const 1) (i32.const 2) (i32.add)
# no emit_const wildcard

printf 'fn main() = {\n  let x = 1\n  x + 2\n}\n' | wasmtime run /tmp/m2.wasm
# expected: $main body has both LLet (x=1, set $x) AND LBinOp (get $x, const 2, add)
# no emit_const wildcard

# Wheel self-compile fixpoint:
cat src/*.mn lib/**/*.mn | wasmtime run bootstrap/mentl.wasm > /tmp/m2.wat
wat2wasm --enable-tail-call /tmp/m2.wat -o /tmp/m2.wasm
cat src/*.mn lib/**/*.mn | wasmtime run /tmp/m2.wasm > /tmp/m3.wat
diff /tmp/m2.wat /tmp/m3.wat
# expected: empty (L1 fixpoint closed for the ++ axis)
```

## §11 — Cross-references

- `SYNTAX.md` §"Operator precedence" (line 1124) — current `++` declaration; revised per §5.
- `src/lower.mn:416-417` — `lower_expr_body`'s `BinOpExpr` arm; site of §4.1 specialization.
- `src/backends/wasm.mn:1729-1754` — `emit_binop`'s match; site of §4.2 BConcat-arm removal.
- `bootstrap/src/emit/emit_call.wat:280-360` — seed's `$emit_lbinop` BConcat dispatch; either kept as safety net or moved per §4.3.
- `bootstrap/src/lower/walk_compound.wat` — seed's BinOp lowering; site of §4.3 dispatch insertion.
- `lib/runtime/lists.mn:161` — `list_concat` implementation; verifies operand semantics.
- `lib/runtime/strings.mn:72` — `str_concat` implementation; verifies operand semantics.
- `protocol_canonical_projection_pattern.md` — single source of truth at the record's home; lower IS the home for type-aware projection.
- `protocol_emit_is_graph_projection.md` — emit reads the graph; when the graph says TList, emit emits list_concat.
- `protocol_no_silent_fallback.md` — drift refusal: `LUnresolved` sentinel over fabricated default.
- `protocol_cursor_is_the_substrate.md` — every subsystem is the cursor in a different mode; lower's BConcat specialization IS cursor projecting at the `++` site.

## §12 — Walkthrough closure

`++` is type-polymorphic at the syntax surface, deterministic at the substrate layer. The lower stage projects each occurrence to a direct `LCall` based on the operand's graph type; emit reads the residue. No runtime dispatch, no silent fallback, no operator overloading at the emit layer. The eight interrogations clear; the residue is the lower-time match arm above.

When this walkthrough's named follow-ups all land:
- The `++` rough edge dissolves entirely.
- `SYNTAX.md` §"Concatenation operator" is the canonical authority.
- The substrate gap from this session (`(call $str_concat)` for list-typed `++`) cannot recur — lower commits at compile time, the runtime never sees `BConcat`.

This is the residue. The line was waiting to be typed.
