# Pattern Alternation Bindings — Substrate Walkthrough

> *Walkthrough #4 of the SYNTAX-ULTIMATE audit per `protocol_realization_loop.md`. Resolves the strict no-bindings-in-alternation rule; locks the substrate-honest relaxation: allow bindings when all branches bind the same names with unifiable types.*

## §0 — Why this walkthrough exists

`SYNTAX.md` §"Pattern alternation — rule" currently says:

> `pat_1 | pat_2 | ... | pat_n => body`: body executes if ANY branch matches. **No variable bindings may appear inside alternatives** (each branch must match identically at the value level — `Some(x) | Other(x)` is rejected because `x`'s binding source is ambiguous). Pure literals / tag-only patterns are common; use an as-pattern (§PAs) outside the alternation if you need a binding.

The strict rule rejects ergonomically-correct patterns. `Some(x: Int) | Right(x: Int) => f(x)` has UNAMBIGUOUS bindings — `x: Int` regardless of which branch matched. The current spec rejects it, forcing the user into one of:

```
// Currently required:
match value {
  Some(x) => f(x),
  Right(x) => f(x),    // duplicated body
  ...
}

// Or as-pattern workaround (loses the alternation's grouping):
match value {
  v @ Some(_) => f(unwrap(v)),
  v @ Right(_) => f(unwrap_right(v)),
}
```

Both fight the user. The substrate-honest form: **allow bindings inside `|` when all branches bind the same names with unifiable types.** The "ambiguity" the strict rule cites doesn't exist when the binding's identity and type are unambiguous.

## §1 — Empirical state

Three observations:

1. **The rule was inherited from HM convention.** Many languages with HM-based alternation (OCaml, Rust early versions) have the same restriction. Some languages (Rust's modern `|` patterns, Scala's `|` patterns) have relaxed it.

2. **The wheel uses pattern alternation rarely.** Most `match` arms have a single pattern per arm. The alternation rule is mostly latent. But ergonomic friction surfaces in domain code (DSP, ML, AI proposers) where shared payload types across variants are common.

3. **The kernel can already check name-identity and type-unification across branches.** Infer's `infer_pat` walks each branch; it has access to the binding sets and types. The check is mechanical.

## §2 — The eight interrogations on pattern alternation bindings

### 1. Graph?

A `pat_1 | pat_2 | ... | pat_n` arm produces a single `PAlt(branches)` AST node. Each branch is itself a pattern with its own bindings. The arm's body executes with those bindings in scope.

When all branches bind the SAME set of names, the body's scope is uniform — the bindings exist regardless of which branch matched. Type-check the bindings across branches via unification.

When branches bind DIFFERENT sets of names, the body's scope is non-uniform — some bindings exist for some matches but not others. This is genuinely ambiguous; reject.

### 2. Handler?

Pattern matcher (in `infer.mn`'s `infer_pat` and `lower.mn`'s pattern lowering). The matcher dispatches by tag at runtime; bindings are stored in arm-scope locals.

### 3. Verb?

`|>` at match dispatch. Sequential type-check of branches.

### 4. Row?

Same as match scrutinee. Pattern alternation doesn't affect rows.

### 5. Ownership?

Each match arm owns its bindings. Pattern alternation produces ONE arm with bindings shared across branches; the bindings flow as `own` or `ref` per the value's origin.

### 6. Refinement?

When branches refine the binding's type differently:

```
type ValidIdx = Int where self >= 0 && self < limit
match maybe_idx {
  Some(i: ValidIdx) | LegacyIdx(i: ValidIdx) => use(i),
  ...
}
```

Both branches bind `i: ValidIdx`. The refinement composes — the body sees `i` with the union of refinements from each branch (which is the same predicate here, so trivially ValidIdx).

When refinements differ across branches:

```
match value {
  Some(x: PositiveInt) | Right(x: NonZeroInt) => use(x),
  ...
}
```

The body sees `x: PositiveInt | NonZeroInt` — the disjunction of refinements. Verify must discharge whichever predicate holds at runtime; in practice the body accepts the WEAKER common predicate (in this case `NonZeroInt` since PositiveInt ⊂ NonZeroInt, weaker). The substrate-honest answer: the body's `x` has type with predicate = disjunction of branches' predicates.

### 7. Gradient?

When types match exactly, no ambiguity → allow. When types unify (one is a refinement of the other), allow with disjunction. When types are unrelated, reject. When binding sets differ, reject.

The gradient at the alternation site narrates: "this binding `x` exists in all branches as type T (the unification)" — the type IS the truth derived from branch unification.

### 8. Reason?

Each branch's binding has a Located reason. The arm-scope binding has `Inferred("alternation common type")` referencing all branches' reasons. The Why Engine walks back through the alternation node to surface every branch's contribution.

## §3 — The ULTIMATE form

### Acceptance rule

`pat_1 | pat_2 | ... | pat_n => body` is accepted iff:

1. **Same binding names.** Every branch binds the EXACT same set of variable names. Wildcard `_` and literal patterns count as "no binding"; PVar(name) and PRecord({name, ...}) count as "binds name."

2. **Unifiable types per binding.** For each binding name `x`, the types across branches must unify. The body sees `x` with the unified (least common) type.

3. **Compatible refinements.** When refinements differ across branches, the body sees `x` with the DISJUNCTION of branches' predicates. Verify discharges per-arm at runtime; the body accepts the weakest common predicate.

### Rejection cases

```
// REJECTED — different binding sets
match v { Some(x) | Other(y) => use(x) }  
//   ^ E_PatternAlternationBindingMismatch: branch 0 binds 'x', branch 1 binds 'y'

// REJECTED — same name, incompatible types
match v { Some(x: Int) | Right(x: String) => use(x) }
//   ^ E_PatternAlternationBindingMismatch: 'x' has type Int in branch 0, String in branch 1

// ACCEPTED — same names, unifiable types
match v { Some(x: Int) | Right(x: Int) => f(x) }

// ACCEPTED — same name, refinement-unifiable
match v { Some(x: PosInt) | Other(x: NonZeroInt) => f(x) }
//   binding type = TInt with predicate = (self > 0) || (self != 0)
```

### Wildcards mix freely

```
// ACCEPTED — wildcard binds nothing
match v { Some(_) | None => default }

// REJECTED — mixed binding/wildcard
match v { Some(x) | None => x }
//   ^ E_PatternAlternationBindingMismatch: 'x' bound in branch 0, NOT bound in branch 1
```

### Nested patterns

```
// ACCEPTED — nested binding at same depth, same name, same type
match v { Some(Some(x)) | Right(Right(x)) => f(x) }

// REJECTED — same name at DIFFERENT depths
match v { Some(x) | Right(Right(x)) => f(x) }
//   ^ E_PatternAlternationBindingMismatch: 'x' is a direct binding in branch 0, nested in branch 1
//     (binding-path differs across branches)
```

The path-equivalence is part of name-identity check. Future relaxation may permit different paths if the projection composes; out of scope for this walkthrough.

## §4 — Substrate cascade

### 4.1 — `src/parser.mn`: pattern alternation parsing

Confirm `parse_pat_alt` already produces `PAlt(branches)`. The parser doesn't gate bindings inside alternation — that's an INFER-time concern.

### 4.2 — `src/infer.mn`: `infer_pat` for `PAlt`

Add binding-set + type-unification check:

```
fn infer_pat(pat, scrutinee_ty, ...) = match pat {
  PAlt(branches) => {
    // Infer each branch independently
    let branch_infers = lower_pats_with_infer(branches, scrutinee_ty)
    // Each branch_infer is (binding_set, refinement_per_binding)
    
    // Check all branches bind the SAME name set
    let names_0 = binding_names(list_head(branch_infers))
    let mismatch = find_first_branch_with_different_names(branch_infers, names_0)
    match mismatch {
      Some(i) => emit_diag(E_PatternAlternationBindingMismatch(i, names_0, branch_i_names)),
      None    => ()
    }
    
    // For each binding name, unify types across branches
    for name in names_0 {
      let types_per_branch = collect_types(branch_infers, name)
      let unified = unify_all(types_per_branch)
      bind_in_arm_scope(name, unified)
    }
    
    // Refinements compose as disjunction (Verify-discharged at runtime)
    for name in names_0 {
      let preds_per_branch = collect_preds(branch_infers, name)
      let disjunction = disjoin_predicates(preds_per_branch)
      attach_refinement(name, disjunction)
    }
  },
  // ...other arms
}
```

### 4.3 — `src/lower.mn`: pattern lowering for `PAlt`

Lower `PAlt(branches)` to a chain of pattern dispatches. Each branch's match condition is its own check; if any branch matches, bind the names from THAT branch's binding paths and execute the body.

The runtime: dispatch on the value's tag/shape; if the tag matches branch_i's shape, extract bindings via branch_i's paths and jump to body.

```
LMatchAlt(handle, scrutinee, branches, body) where each branch carries its (predicate, binding_paths).
```

The substrate is similar to existing PCon dispatch but with one body shared across multiple branch shapes.

### 4.4 — Refinement composition

When branches refine differently, the body sees `x` with the disjunction. `Verify` at the use site (or downstream) discharges the predicate per-arm. The implementation: extend `TRefined` to carry a list of predicates with their branch contexts; verify discharges by matching the actual taken-branch.

For first-light, the simpler form: refinements that DON'T match exactly trigger `E_PatternAlternationRefinementUnsupported` — surface the friction, defer composition until L1 closes. (Drift mode 9 refused: this IS positive-form deferral with a structural reason — the disjunction substrate is non-trivial and composes with multiple Verify-discharge sites.)

## §5 — `SYNTAX.md` revision

§"Pattern alternation — rule" currently:

> `pat_1 | pat_2 | ... | pat_n => body`: body executes if ANY branch matches. **No variable bindings may appear inside alternatives** (each branch must match identically at the value level — `Some(x) | Other(x)` is rejected because `x`'s binding source is ambiguous). Pure literals / tag-only patterns are common; use an as-pattern (§PAs) outside the alternation if you need a binding.

ULTIMATE form:

> `pat_1 | pat_2 | ... | pat_n => body`: body executes if ANY branch matches. Variable bindings ARE allowed inside alternatives WHEN:
>
> 1. **All branches bind the same set of names.** Wildcards and literals don't count as bindings.
> 2. **For each binding name, the types across branches unify.** The body sees the unified type.
> 3. **Compatible refinements.** When refinements differ, the body sees the disjunction; Verify discharges per-arm.
>
> Examples:
>
> ```
> match opt {
>   Some(x: Int) | Right(x: Int) => use(x),    // ACCEPTED — same name, same type
>   ...
> }
>
> match v {
>   Some(_) | None => default,                 // ACCEPTED — no bindings
>   ...
> }
>
> match v {
>   Some(x) | Other(y) => ...                  // REJECTED — different binding names
>   //   ^ E_PatternAlternationBindingMismatch
> }
> ```
>
> When the same name appears with different types: `E_PatternAlternationBindingMismatch` with the type conflict surfaced. When some branches bind and others don't: same diagnostic with the absent-branch named.

## §6 — Diagnostic catalog updates

Add:

| `E_PatternAlternationBindingMismatch` | branches in `\|` alternation bind different names or types | adjust patterns to bind same names with unifiable types; OR split into separate arms |

Optional:

| `E_PatternAlternationRefinementUnsupported` | branches refine the same name with non-disjunctive predicates (until L2 lands) | use unrefined types in alternation; refine downstream after pattern match |

## §7 — Edge cases

**No bindings in any branch.** `None | Empty | Done => default` — wildcards and nullary variants. Always allowed.

**Single-branch alternation.** `Some(x) => f(x)` — vacuously valid (one-element alternation = no alternation). The parser may not even produce `PAlt` in this case (just `PCon`). No special handling.

**Deep nesting.** `Some(Some(Inner(x))) | Right(Right(Inner(x))) => f(x)` — deep paths must align across branches. Same path-equivalence check.

**Type variables.** `Some(x: A) | Right(x: A) => f(x)` where `A` is a generic param. The unification works at the type-variable level; both `x` references are the same `A`. Allowed.

**Effect rows.** Patterns don't carry effects; alternation is a pattern-level construct. No effect interaction.

**Bindings in nested alternation.** `(Some(x) | None) => x` — alternation in a non-final position. Reject the OUTER alternation if the inner has the binding-set mismatch. Inner alternation has `x` in one branch, none in the other — REJECTED at the inner level. Nested behavior: each `PAlt` checks independently.

**As-patterns + alternation.** `v @ (Some(x) | Right(x)) => f(v, x)` — the `v` binding is from the as-pattern (always-binds the matched value); the inner `x` follows alternation rules. Both bindings available in the body.

## §8 — Named peer follow-ups

- **`Hβ.syntax.pat-alt-binding-relax`** — implement §4.2 (infer's binding-set + type-unification check).
- **`Hβ.syntax.pat-alt-lower-substrate`** — implement §4.3 (lower's dispatch chain for PAlt with bindings).
- **`Hβ.syntax.pat-alt-refinement-disjunction`** — implement §4.4 (refinement composition; or surface E_PatternAlternationRefinementUnsupported until L2).
- **`Hβ.syntax.pat-alt-doc-revise`** — implement §5 (SYNTAX.md alternation rule revision).
- **`Hβ.syntax.pat-alt-diagnostic-binding-mismatch`** — implement §6 (E_PatternAlternationBindingMismatch).

## §9 — Verification

```
// Same names, same types — ACCEPTED:
match maybe_int {
  Some(x: Int) | Right(x: Int) => use(x),
  None => 0,
}
// expected: type-checks; body sees x: Int

// Different names — REJECTED:
match v {
  Some(x) | Other(y) => use(x),
  ...
}
// expected: E_PatternAlternationBindingMismatch

// Mixed binding/wildcard — REJECTED:
match v {
  Some(x) | None => x,
  ...
}
// expected: E_PatternAlternationBindingMismatch

// Nested same-depth — ACCEPTED:
match v {
  Some(Inner(x)) | Right(Inner(x)) => f(x),
  ...
}

// Wildcard alternation — ACCEPTED:
match v {
  Click(_) | Key(_) | Scroll(_) => "input",
  ...
}
```

## §10 — Cross-references

- `SYNTAX.md` §"Pattern alternation — rule" — current strict rule; revised per §5.
- `src/types.mn` — `Pat` ADT; `PAlt(branches)` variant.
- `src/parser.mn` — `parse_pat_alt` site.
- `src/infer.mn` — `infer_pat` site for PAlt; §4.2 implementation.
- `src/lower.mn` — pattern lowering; §4.3 implementation.
- `protocol_canonical_projection_pattern.md` — type-unification IS the projection at PAlt's home.
- `protocol_no_silent_fallback.md` — drift refusal: surface E_PatternAlternationBindingMismatch instead of silent rejection.

## §11 — Walkthrough closure

Pattern alternation accepts bindings when types unify uniformly across branches. The strict no-bindings rule was an over-cautious restriction inherited from older HM languages; modern relaxation is substrate-honest because the kernel CAN check name-identity and type-unification at infer-time. The relaxation eliminates duplicated arm bodies and aligns with how users expect `|` to read: "either pattern, same body, same bindings."

When this walkthrough's named follow-ups all land:
- `Some(x) | Right(x) => f(x)` becomes first-class for any unifiable type
- The alternation rule becomes a productive pattern, not a punitive restriction
- Refinement composition (disjunction-Verify) follows post-L1 with structural reason

This is the residue. The pattern was always substrate-honest; the rule just had to stop blocking it.
