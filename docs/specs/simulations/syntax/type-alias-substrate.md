# `type X = Y` Type Alias — Substrate Walkthrough

> *Walkthrough #3 of the SYNTAX-ULTIMATE audit per `protocol_realization_loop.md`. Surfaces the `TAlias` kernel primitive (already in `src/types.mn:48`) into SYNTAX.md authoritatively. Resolves transparent vs nominal vs refined alias semantics.*

## §0 — Why this walkthrough exists

`SYNTAX.md` documents two forms of `type` declaration:

- **Refinement type:** `type Sample = Float where -1.0 <= self <= 1.0` — `TRefined(TFloat, pred)`
- **Nominal record:** `type Person = {name: String, age: Int}` — `TName("Person", [], TRecord([...]))`

But `src/types.mn:48` declares a third kernel primitive that SYNTAX.md does not surface:

```
| TAlias(String, Ty)            // RN.1 — authored alias name (e.g. "Port") wrapping resolved type
```

The kernel HAS transparent aliases. The spec doesn't document them. This means:
- A user writing `type Port = Int` doesn't know if it's accepted (it should be) or what semantics apply.
- The Reason-chain narrative ("the value is a `Port`") loses authority — is `Port` the user's name or just `Int`?
- The gradient's voice can't speak the alias name without spec authority.

This walkthrough surfaces `TAlias` into SYNTAX.md, locks the semantics (transparent for unification, named for Reason), and clarifies how nominal distinction is achieved (via single-field records, NOT via aliases).

## §1 — Empirical state

Three observations:

1. **`TAlias` exists in the kernel** at `src/types.mn:48`. It has been there since RN.1 (rename-substrate, 2026 timeline). Inference must already handle it (the wheel compiles).

2. **SYNTAX.md examples implicitly assume `where` is required** for `type` declarations. `type Sample = Float` (no `where`) is not shown anywhere — neither accepted nor rejected. The user is left guessing.

3. **`unify_types(TAlias(_, t), other)` behavior is undocumented.** From the kernel's perspective, the question is: do `Port` and `Int` unify? If yes (transparent), `let p: Port = 8080` accepts. If no (opaque), the alias creates a distinct type. The spec doesn't answer.

## §2 — The eight interrogations on `type X = Y`

### 1. Graph?

`type Port = Int` binds the name `Port` in the env to `TAlias("Port", TInt)`. Subsequent references to `Port` resolve through the env to the TAlias. The graph treats `Port` and `Int` as related-via-alias; the underlying type is reachable through the alias's wrapped Ty.

### 2. Handler?

Inference handles type-name resolution. `unify_types(TAlias(name, inner), other)` recursively unifies `inner` with `other` — the alias is transparent for type-checking. The name is preserved in Reason chains.

### 3. Verb?

`|>` at infer-time — type resolution is sequential graph projection.

### 4. Row?

Not applicable to type-level constructs.

### 5. Ownership?

The alias preserves the underlying type's ownership. `type OwnedBuffer = own Buffer<Byte>` (if the syntax allowed) — but ownership markers are at the parameter level, not type level. Aliases do not introduce ownership distinctions.

### 6. Refinement?

`type Port = Int` (no `where`) is a transparent alias — no predicate. `type Port = Int where self >= 1024 && self <= 65535` adds a refinement: `TRefined(TAlias("Port", TInt), pred)`. The alias and the refinement compose — the alias names the type for Reason chains; the refinement narrows the type.

### 7. Gradient?

Aliases serve the gradient's voice. The Reason chain "this value is a `Port`" carries more meaning than "this value is an `Int`." The alias is the user's authored intent; the gradient surfaces it. The substrate-honest form preserves the alias name through type-checking even though the type unifies transparently.

### 8. Reason?

`TAlias(name, inner)` carries `name` as the user's authored intent. Located reasons mention `Port` rather than `Int` when the value's binding-site type was declared as `Port`. The Why Engine walks the alias edge to surface the user's naming.

## §3 — The ULTIMATE form

### Three semantic categories

```
// 1. TRANSPARENT alias — type X = Y (no where, not a record)
type Port = Int                              // TAlias("Port", TInt)
type Frequency = Float                       // TAlias("Frequency", TFloat)
type Bytes = List<Int>                       // TAlias("Bytes", TList(TInt))

// 2. REFINED type — type X = Y where pred
type ValidPort = Int where self >= 1024 && self <= 65535   // TRefined(TInt, pred)
                                                            // OR TRefined(TAlias("ValidPort", TInt), pred) — see §3.2
type Sample = Float where -1.0 <= self <= 1.0

// 3. NOMINAL record — type X = {field, ...}
type Person = {name: String, age: Int}       // TName("Person", [], TRecord([...]))
type Customer = {name: String, age: Int}     // DISTINCT from Person despite same shape
```

The three categories are syntactically distinguished:
- No `where`, not a record literal → TRANSPARENT alias.
- `where` clause → REFINED.
- Record literal at RHS → NOMINAL record.

### §3.1 — Transparent alias semantics

`type X = Y` (no `where`, not a record) creates `TAlias("X", Y)`:

- **Unification is transparent.** `unify_types(TAlias("X", T), Other) = unify_types(T, Other)`. The alias does NOT create a distinct type; `Port` and `Int` are unifiable.
- **The name is preserved for Reason chains.** When inference produces a Located reason, the alias name surfaces: `"the value here is a Port"` instead of `"the value here is an Int"`.
- **The gradient's voice prefers the alias name.** When Mentl narrates a value's type, she names it `Port` if the binding-site declared `Port`.
- **The Why Engine's Reason traversal preserves the alias.** `Why(value)` walks back through `TAlias("Port", TInt)` and surfaces `Port` to the user.

### §3.2 — Refined alias composition

`type ValidPort = Int where self >= 1024 && self <= 65535`:

This is a REFINED type, not just an alias. The substrate question: does the refinement compose with `TAlias`?

ULTIMATE form: yes, transparently. The kernel produces `TRefined(TAlias("ValidPort", TInt), pred)`. The alias is the type's name; the refinement is the predicate. Verify discharges the predicate on construction; the alias name is preserved in Reason chains.

The unification semantics: `unify_types(TRefined(TAlias("ValidPort", TInt), pred), Other)`:
- Refinement requires the underlying type to unify (TAlias→TInt → unify with Other's underlying)
- The predicate must hold for Other (compile-time discharge or runtime check)

### §3.3 — Nominal distinction via single-field records

For DISTINCT identity (where `Port` and `Int` should NOT unify), use a single-field record:

```
type Port = {value: Int}
type Customer = {value: String}
```

These are `TName("Port", [], TRecord([("value", TInt)]))` — nominal records with one field. They do NOT unify with their underlying type or with each other (despite same field). The brand IS the record's nominal name.

Construction:
```
let p = Port{value: 8080}
let c = Customer{value: "abc"}
// p and c have different types; cannot be unified
```

Field access: `p.value` returns the underlying `Int`. The wrapper is explicit but minimal.

This is the substrate-honest form for nominal types. **No new keyword required** — the existing nominal-record discipline covers the use case. Aliases stay transparent; nominal needs records.

### §3.4 — What is NOT in scope

- **Opaque types** (where the implementation is hidden from outside callers) — a module-system feature, post-L1.
- **Newtype derivation** (auto-deriving operators for nominal types) — post-L1; covered by `derive` mechanism (named follow-up).
- **Polymorphic aliases** (`type Pair<A, B> = (A, B)`) — should be supported via `TAlias("Pair", TTuple([TVar(0), TVar(1)]))` with type params; verified at infer-time.

## §4 — Substrate cascade

### 4.1 — `src/parser.mn`: type-decl parsing

The parser already parses `type X = Y` with optional `where`. Confirm:
- `type X = TyExpr` (no `where`, RHS not a record) → produce `TypeDeclStmt(name="X", body=TyExpr, predicate=None)`
- `type X = TyExpr where Pred` → produce `TypeDeclStmt(name="X", body=TyExpr, predicate=Some(Pred))`
- `type X = {f1: T1, f2: T2}` → produce `TypeDeclStmt(name="X", body=TRecord(fields), predicate=None, nominal=true)` (the `{...}` syntactic position triggers nominal flag)

The distinction is parser-level: a record-literal-at-RHS triggers nominal; everything else is alias-or-refined.

### 4.2 — `src/infer.mn`: type-decl env binding

Confirm `infer_type_decl_stmt` handles all three categories:

- TRANSPARENT alias: bind `name → TAlias(name, body)` in env.
- REFINED alias: bind `name → TRefined(TAlias(name, body), predicate)` in env.
- NOMINAL record: bind `name → TName(name, type_params, TRecord(fields))` in env. Maintain the nominal-distinct discipline (no automatic unification with structurally-equal records).

### 4.3 — `src/infer.mn`: `unify_types` for `TAlias`

Confirm:
- `unify_types(TAlias(_, t1), TAlias(_, t2))` → unify_types(t1, t2). Alias names don't constrain unification; underlying types do.
- `unify_types(TAlias(_, t), Other)` → unify_types(t, Other). Transparent.
- The alias name is preserved on the resulting type via the Reason chain (Located reason references the alias name at the binding site).

### 4.4 — Mentl voice / gradient narration

When Mentl narrates a value's type, she prefers the alias name. The `mentl_voice` handler at `src/voice.mn` reads the type at a cursor position; if it's `TAlias(name, _)`, she says `name`. If `TRefined(TAlias(name, _), pred)`, she says `name` and may surface the predicate.

## §5 — `SYNTAX.md` revision

§"Algebraic data types / Refinement types" currently has:

> ### Refinement types
>
> ```
> type Sample = Float where -1.0 <= self <= 1.0
> ```

Insert a new section ABOVE refinement types:

> ### Type aliases
>
> Three forms of `type` declaration, distinguished by RHS shape:
>
> **Transparent alias** — `type X = Y` (no `where`, RHS is a type expression, not a record literal).
>
> ```
> type Port = Int
> type Frequency = Float
> type Bytes = List<Int>
> ```
>
> Creates `TAlias("X", Y)`. The alias and underlying type unify transparently — `Port` and `Int` are interchangeable for type-checking. The name is preserved in Reason chains and in Mentl's voice.
>
> **Refined alias** — `type X = Y where pred`.
>
> ```
> type ValidPort = Int where self >= 1024 && self <= 65535
> type Sample = Float where -1.0 <= self <= 1.0
> ```
>
> Creates `TRefined(TAlias("X", Y), pred)`. The alias names the type; the refinement narrows it via predicate. Verify discharges the predicate at construction sites.
>
> **Nominal record** — `type X = {f1: T1, f2: T2, ...}`.
>
> ```
> type Person = {name: String, age: Int}
> type Customer = {name: String, age: Int}    // distinct from Person despite same shape
> ```
>
> Creates `TName("X", [], TRecord([...]))`. The record's name brands its identity — `Person` and `Customer` do NOT unify even with identical fields. Use this for nominal-distinct types.
>
> **For nominal distinction over a primitive** — wrap in a single-field record:
>
> ```
> type Port = {value: Int}
> type Customer = {value: String}
> ```
>
> No newtype keyword required; the record name carries the brand. Field access via `.value`.

## §6 — Diagnostic catalog updates

No new diagnostics required. Existing diagnostics (`E_TypeMismatch`, `E_RefinementRejected`) cover the alias cases:
- `let p: Port = "hello"` — `E_TypeMismatch`: Port unifies to Int via TAlias; "hello" is String.
- `let p: ValidPort = 100` — `E_RefinementRejected`: 100 violates `self >= 1024`.
- `let p: Person = Customer{...}` — `E_TypeMismatch`: nominal records distinct.

## §7 — Edge cases

**Polymorphic alias.** `type Pair<A, B> = (A, B)` creates `TAlias("Pair", TTuple([TVar(0), TVar(1)]))` with type-parameter list. Resolution: `Pair<Int, String>` substitutes type params; unifies with `(Int, String)`.

**Recursive alias.** `type RecList = (Int, RecList)` — recursive references. Should be allowed (compiler resolves via μ-equation discipline). If the recursion is degenerate (`type Y = Y`), surface `E_OccursCheck`.

**Alias of an alias.** `type X = Int; type Y = X` — `TAlias("Y", TAlias("X", TInt))`. Unification follows the chain: `Y` and `Int` unify transparently. Both names available in Reason chains; the gradient prefers the more specific one (`Y` at a binding declared as `Y`).

**Alias-via-where with no body change.** `type Port = Int where true` — TRefined with a vacuous predicate. Allowed; equivalent to transparent alias for type-checking; gradient may suggest dropping the `where true`.

**Alias of a function type.** `type Reducer = (Int, Int) -> Int` — `TAlias("Reducer", TFun([TInt, TInt], TInt, EfPure))`. Allowed; reads naturally for declaring callbacks.

**Nominal record vs nominal alias.** `type Port = {value: Int}` (nominal record) vs `type Port = Int` (transparent alias). The choice is the user's: distinct identity (record) or just a name (alias). Record requires `Port{value: 8080}` construction; alias just uses `8080: Port` (the literal IS the value).

## §8 — Named peer follow-ups

- **`Hβ.syntax.type-alias-doc-revise`** — implement §5 (SYNTAX.md "Type aliases" section).
- **`Hβ.syntax.type-alias-infer-confirm`** — confirm `infer_type_decl_stmt` handles all three categories (audit + verify; likely already correct).
- **`Hβ.syntax.type-alias-unify-transparent`** — confirm `unify_types(TAlias(_, t), other)` is transparent (audit infer.mn; likely already correct).
- **`Hβ.syntax.type-alias-voice-narration`** — confirm `mentl_voice` prefers alias name in narration (audit voice.mn).
- **`Hβ.syntax.type-alias-polymorphic`** — confirm `type Pair<A, B> = (A, B)` and other polymorphic aliases work end-to-end (test harness).

## §9 — Verification

```
// Transparent alias accepts:
type Port = Int
let p: Port = 8080
let i: Int = p              // implicit unification — OK

// Refined alias rejects out-of-range:
type ValidPort = Int where self >= 1024 && self <= 65535
let bad: ValidPort = 80     // E_RefinementRejected: 80 violates self >= 1024

// Nominal record distinct:
type Person = {name: String}
type Customer = {name: String}
let p: Person = Person{name: "Morgan"}
let c: Customer = p         // E_TypeMismatch: Person and Customer distinct

// Polymorphic alias:
type Pair<A, B> = (A, B)
let p: Pair<Int, String> = (42, "hello")
let q: (Int, String) = p    // implicit unification — OK
```

## §10 — Cross-references

- `src/types.mn:48` — `TAlias(String, Ty)` kernel primitive.
- `src/types.mn` — `TRefined(Ty, Predicate)` kernel primitive (line 46).
- `src/types.mn` — `TName(String, List, ...)` for nominal records.
- `src/parser.mn` — type-decl parsing.
- `src/infer.mn` — `unify_types`, `infer_type_decl_stmt`.
- `src/voice.mn` — `mentl_voice` narration.
- `SYNTAX.md` §"Algebraic data types / Refinement types" — current docs (revised per §5).

## §11 — Walkthrough closure

`type X = Y` is a TRANSPARENT alias surfacing the kernel's `TAlias` primitive. The name is preserved for Reason chains and Mentl's voice; unification is transparent. For nominal distinction, use single-field records. For refinement, use `where`. The three categories are syntactically distinguished by RHS shape; SYNTAX.md surfaces them authoritatively per §5.

This is the residue. The kernel had the primitive; the spec just needed to name it.
