# Diagnostic Catalog — Substrate Walkthrough

> *Walkthrough #7 of the SYNTAX-ULTIMATE audit per `protocol_realization_loop.md`. Audits every `E_*`/`T_*`/`W_*` against the canonical projection pattern; classifies into format-liftable, hard-error, gradient-narration, and consolidation categories. Adds the diagnostics introduced by walkthroughs #1-#6. Locks the discipline: every diagnostic IS teaching, not punishment.*

## §0 — Why this walkthrough exists

`SYNTAX.md` §"Diagnostic catalog" lists 16 syntax-level errors. Each carries Located reason chain + applicability tag + Patch (where mechanical). The catalog has accumulated organically; some diagnostics duplicate, some could be auto-fixed by the formatter, some genuinely surface substrate violations.

This walkthrough applies the eight interrogations to the catalog AS A WHOLE, classifying each diagnostic per its substrate role:

- **Format-liftable** — the formatter auto-corrects; the diagnostic shouldn't surface as a user-facing error.
- **Hard error** — substrate violation; user must restructure.
- **Gradient narration** — not an error; a teaching surface in Mentl's voice.
- **Consolidation** — diagnostics that overlap and should merge OR split.

Plus: the diagnostics introduced by walkthroughs #1-#6 are integrated into the catalog with consistent applicability tags and Quick Fix discipline.

## §1 — Empirical state

The current `SYNTAX.md` catalog (16 entries) treats every diagnostic as a uniform error. Categories aren't distinguished. A `E_RedundantBraces` (which the formatter could silently strip) reads with the same severity as `E_TypeMismatch` (genuine semantic violation). The user can't tell which require attention vs which the medium can auto-handle.

The substrate question: should `E_RedundantBraces` be an error at all? Per `format_default`'s canonical-render discipline, the formatter normalizes layout on save. The user's text would be auto-corrected before compile-time check sees it. The error should not surface — only the `mentl edit` formatter should silently fix.

Generalizing: every diagnostic that the formatter CAN auto-correct should be lifted to the formatter. The compile-time catalog reduces to genuine semantic violations.

## §2 — The eight interrogations on the catalog

### 1. Graph?

Each diagnostic represents a graph projection failure: the user's source produces a graph node that doesn't satisfy a substrate constraint. The constraint type determines the diagnostic's category.

### 2. Handler?

`diagnostics_handler` (per `src/pipeline.mn`) collects diagnostics produced during compilation. The handler stack determines which diagnostics surface to the user vs which the formatter absorbs.

### 3. Verb?

`|>` sequential: diagnostics flow through the pipeline (parser → infer → lower → emit) and accumulate. `~>` handler-attach: diagnostics_handler at the outermost layer renders them to user.

### 4. Row?

Diagnostics carry `with Memory + Alloc + IO` (memory for the reason chain, alloc for the structured reasons, IO for the rendered output).

### 5. Ownership?

Diagnostics own their Located reasons. The handler stack moves them through; rendering produces strings that user-output IO consumes.

### 6. Refinement?

Each diagnostic carries an applicability tag refining its trustworthiness:
- **`MachineApplicable`** — the Quick Fix is fully mechanical; the medium can apply it without user confirmation.
- **`MaybeIncorrect`** — the Quick Fix is plausible but may be wrong in some contexts; surface to user for review.
- **`HasPlaceholders`** — the Quick Fix has gaps the user must fill (e.g., missing variant arms).
- **`Unspecified`** — no automatic fix; the user must restructure.

The applicability tag IS the substrate refinement.

### 7. Gradient?

Diagnostics participate in the gradient. A `T_*` (gradient narration) IS the gradient surfacing a teachable refinement. A `E_*` (hard error) IS the gradient hitting a non-projectable cursor state. A `W_*` (warning / suggestion) IS the gradient narrating an improvement opportunity.

### 8. Reason?

Every diagnostic has a `Located(span, ReasonKind(detail))` chain. The Why Engine walks back through the chain to surface every contributing factor — not just the final error, but the chain of decisions that led to it.

## §3 — The ULTIMATE form: classification

### §3.1 — Format-liftable (formatter handles silently)

These diagnostics should NOT surface as compile-time errors. The `format_default` handler auto-corrects on save / auto-format keystroke; the medium silently applies the fix. The compile-time catalog has them as RECORDS for the formatter's algorithm, but they don't reach the user.

| Code                  | Trigger                                       | Formatter action                                  |
|-----------------------|-----------------------------------------------|----------------------------------------------------|
| `E_RedundantBraces`   | braces around single-expression body          | strip the braces; user sees no diagnostic         |
| `E_ExplicitTypeParams`| turbofish `f<T>(...)` at call site            | strip the type params; user sees no diagnostic    |
| `E_LayoutViolation` (indent-only sub-cases) | wrong indent count        | normalize indent; user sees no diagnostic         |

The ASCII pattern: format-liftable diagnostics carry `MachineApplicable` applicability AND have a deterministic single-target rewrite. The formatter applies the rewrite; the compile-time pipeline never sees the original.

### §3.2 — Hard errors (substrate violations)

These diagnostics surface to the user because the substrate cannot auto-fix them — the user's intent isn't recoverable.

| Code                  | Trigger                                       | Applicability                | Quick Fix             |
|-----------------------|-----------------------------------------------|------------------------------|------------------------|
| `E_PatternInexhaustive` | match missing variants, no wildcard         | `HasPlaceholders`            | insert stubs for missing variants |
| `E_RefinementRejected`| value violates refinement predicate           | `Unspecified`                | adjust value or widen refinement |
| `E_EffectMismatch`    | declared row doesn't subsume body row         | `MaybeIncorrect`             | widen declaration OR absorb the effect via handler |
| `E_PurityViolated`    | `with Pure` body performs non-empty effects   | `MaybeIncorrect`             | remove `with Pure` or absorb the effect |
| `E_FeedbackNoContext` | `<~` used without iterative context           | `MaybeIncorrect`             | install `Sample`/`Tick`/`Clock` handler |
| `E_OwnershipViolation`| `own` consumed twice / escapes ref scope      | `Unspecified`                | restructure to single-consume or use `ref` |
| `E_HandlerUninstallable` | handler arms need effects context disallows | `MaybeIncorrect`           | widen ambient row or restructure handler |
| `E_MissingVariable`   | name not in scope                             | `MaybeIncorrect`             | check spelling; check imports |
| `E_TypeMismatch`      | unification failed                            | `Unspecified`                | adjust types; widen / narrow |
| `E_OccursCheck`       | infinite type                                 | `Unspecified`                | restructure to break cycle |
| `E_OrphanHandlerAttach` | `~>` with no preceding chain                | `Unspecified`                | delete `~>` or supply body |
| `E_NotAKeyword` (from walkthrough #5) | user typed `for`/`while`/`loop`/etc. | `MaybeIncorrect`     | rewrite as verb form per substrate |
| `E_PatternAlternationBindingMismatch` (from #4) | branches in `\|` bind different names/types | `MaybeIncorrect` | adjust patterns to bind same names with unifiable types |
| `E_MixedShapeBranches` (from #2) | `><` mixes inline + multi-line branches | `MachineApplicable`     | reformat to vertical (Form A) |
| `E_ParallelComposeArity` | `><` with single branch                    | `Unspecified`                | restructure to single pipeline (no `><` needed) |
| `E_ConcatTypeMismatch` (from #1) | `++` operands have unifiable but distinct types | `MaybeIncorrect` | unify operand types via conversion |
| `E_ConcatTypeUnresolved` (from #1) | `++` operand type not bound at lower-time | `MaybeIncorrect` | annotate operand to constrain type |

### §3.3 — Gradient narration (teaching surfaces, not errors)

These don't break the build. They surface in Mentl's voice as gradient narrations — the substrate offering improvements.

| Code                  | Trigger                                       | Applicability      | Action                          |
|-----------------------|-----------------------------------------------|--------------------|----------------------------------|
| `T_OverDeclared`      | declared row wider than body uses             | `MachineApplicable`| Mentl narrates: "your `with` clause declares effects the body doesn't perform; tighten to unlock capabilities" |
| `T_Gradient`          | an annotation INPUT would narrow the cursor's projection | `MachineApplicable` | Mentl narrates: "annotating this binding with `T` would narrow the projection by X" |
| `W_Suggestion`        | probable Quick Fix available                  | `MaybeIncorrect`   | Mentl surfaces the suggestion in `mentl edit` and via LSP |
| `W_RedundantWhere`    | `type X = Y where true` — vacuous predicate   | `MachineApplicable`| Mentl suggests: "drop the `where true`; alias is transparent" |

### §3.4 — Consolidation

`E_LayoutViolation` is overloaded — it covers indent errors, mis-wrapped operators, orphan tokens. Split into specific codes:

- `E_IndentMismatch` (was: indent sub-cases of `E_LayoutViolation`) — formatter-liftable
- `E_OrphanHandlerAttach` (was: orphan `~>` sub-case of `E_LayoutViolation`) — hard error
- `E_BranchNotParenthesized` (was: `><` branch missing parens) — `MachineApplicable` Quick Fix
- `E_OperatorIsolation` (was: `><` not on its own line in Form A) — `MachineApplicable` Quick Fix

Each gets its own catalog entry per the audit.

`E_HandlerUninstallable` and `E_EffectMismatch` overlap when a handler tries to install but the row doesn't fit. Keep both — they surface DIFFERENT cursor positions:
- `E_EffectMismatch` at the fn boundary (declared row vs body row)
- `E_HandlerUninstallable` at the `~>` site (handler's row requirements vs ambient row)

The user sees a different diagnostic depending on where the mismatch is structurally surfaced.

## §4 — Substrate cascade

### 4.1 — `format_default` handler: format-liftable diagnostics

Confirm the formatter applies these auto-corrections silently:

- `E_RedundantBraces` → strip the braces during format.
- `E_ExplicitTypeParams` → strip turbofish `<T>` from call sites.
- `E_IndentMismatch` → normalize indent to canonical (2-space at left edge / 4-space at indented center).

The formatter's pre-compile pass produces the canonical form. The compile-time pipeline never sees the original. Diagnostic counters track formatter-applied corrections (telemetry); the user sees no error.

### 4.2 — `diagnostics_handler` rendering

The diagnostics handler renders per category:

- **Hard error:** rendered with file:line:column + Reason chain + Quick Fix (if applicable). User must address.
- **Gradient narration:** rendered in Mentl's voice as a side-channel suggestion. Doesn't block build. User can dismiss or apply.
- **Format-liftable:** absorbed by formatter; not rendered (just logged for telemetry).

The handler reads the diagnostic's category metadata (added per §3) and routes accordingly.

### 4.3 — Applicability tag enforcement

Every diagnostic MUST carry an applicability tag. Audit `src/diagnostics.mn` (or wherever Diagnostic is constructed) to ensure each Diagnostic has:
- `MachineApplicable` — used for auto-applies and one-click fixes
- `MaybeIncorrect` — surfaces with user confirmation
- `HasPlaceholders` — surfaces with gaps for user to fill
- `Unspecified` — surfaces as text only, no fix

Diagnostics without a tag are surface-as-text-only by default; this is the substrate-honest fallback. New diagnostics MUST set the tag at construction.

### 4.4 — Quick Fix construction

Per the canonical projection pattern: each Quick Fix is a Patch — a structured edit operation derived from the diagnostic's substrate context. Quick Fixes for hard errors:

- Code edit (insert / delete / replace at span)
- Multi-edit (e.g., E_PatternInexhaustive inserts multiple stubs)
- Refactor (e.g., E_NotAKeyword rewrites the user's keyword form to verb form)

Quick Fixes for gradient narrations are SUGGESTIONS — surface the change but don't auto-apply.

## §5 — `SYNTAX.md` revision

§"Diagnostic catalog" currently has 16 entries in a single table. Replace with three tables (one per category — format-liftable, hard error, gradient narration) plus the consolidation notes.

Insert per §3.1, §3.2, §3.3 above. Each table has the same columns (Code / Trigger / Applicability / Quick Fix or Action).

Append the new diagnostics from walkthroughs #1-#6 to the appropriate categories.

Add a paragraph at the top of the section:

> Mentl's diagnostics are TEACHING surfaces, not punishment. Format-liftable diagnostics are auto-corrected by the formatter and do not surface to the user. Hard errors require the user to restructure (substrate violations the medium cannot auto-recover). Gradient narrations are suggestions in Mentl's voice — improvements the medium proposes; the user may accept or dismiss.
>
> Every diagnostic carries:
>
> - **Located reason chain** — source span + ReasonKind
> - **Applicability tag** — `MachineApplicable` / `MaybeIncorrect` / `HasPlaceholders` / `Unspecified`
> - **Quick Fix Patch** — where mechanically derivable
>
> The applicability tag determines automation: `MachineApplicable` patches are auto-applied; `MaybeIncorrect` surfaces with user confirmation; `HasPlaceholders` requires user fill-in; `Unspecified` is text-only.

## §6 — Edge cases

**Diagnostic during format.** When the formatter encounters a non-format-liftable diagnostic (e.g., `E_PatternInexhaustive`), it skips the format step for that region and surfaces the diagnostic. Format and compile-time-check are sequential per the format → compile pipeline.

**Cascading errors.** When one error spawns more (e.g., `E_MissingVariable` cascades to `E_TypeMismatch` for callers), the diagnostics handler deduplicates by Located reason chain. Only the root surfaces by default; `mentl edit` provides "show all related" expansion.

**Suppression.** No `// noqa` style suppression. Per CLAUDE.md ⊛ + protocol_no_silent_fallback: surface every diagnostic; the user addresses or accepts the gradient narration explicitly. Suppression is an anti-pattern that hides substrate state.

**Diagnostics in `///` doc blocks.** `///` content compiles via the same pipeline (per `SYNTAX.md` §"Comments / What `///` IS"). A doc-comment example with type errors fails the project compile at the `doc_attach` site. The diagnostic carries the doc-block span.

**Cross-module diagnostics.** When importing a module fails (`E_ImportNotFound`), the importing module's compilation reports the diagnostic with the import statement's span and a Reason chain back to the resolution attempt.

## §7 — Named peer follow-ups

- **`Hβ.syntax.diag-format-liftable-confirm`** — implement §4.1 (formatter auto-corrects format-liftable diagnostics silently).
- **`Hβ.syntax.diag-handler-render-by-category`** — implement §4.2 (diagnostics_handler routes by category).
- **`Hβ.syntax.diag-applicability-audit`** — implement §4.3 (every Diagnostic carries an applicability tag).
- **`Hβ.syntax.diag-quickfix-patch-construction`** — implement §4.4 (Quick Fixes as structured Patches).
- **`Hβ.syntax.diag-doc-revise`** — implement §5 (SYNTAX.md three-table catalog + intro paragraph).
- **`Hβ.syntax.diag-layout-violation-split`** — split `E_LayoutViolation` into `E_IndentMismatch` / `E_OrphanHandlerAttach` / `E_BranchNotParenthesized` / `E_OperatorIsolation`.
- **`Hβ.syntax.diag-walkthrough-1-6-integrate`** — integrate diagnostics from walkthroughs #1-#6 into SYNTAX.md catalog.

## §8 — Verification

```
// Format-liftable: no diagnostic surfaces
fn double(x) = { x * 2 }
// after formatter: fn double(x) = x * 2     // braces stripped silently

// Hard error: surfaces with Quick Fix
fn parse(input) = {
  match input {
    Some(_) => 0
    // No None arm
  }
}
// expected: E_PatternInexhaustive
//   Quick Fix (HasPlaceholders): insert `None => /* fill in */`

// Gradient narration: surfaces in voice, doesn't block
fn double(x) with IO = x * 2    
// expected: T_OverDeclared (MachineApplicable)
//   Mentl: "the body doesn't perform IO; tightening to `with Pure` would unlock pure-call capabilities"

// Walkthrough-#1 diagnostic:
fn process(xs, s) = xs ++ s    // xs is List, s is String
// expected: E_ConcatTypeMismatch (MaybeIncorrect)
//   Quick Fix: convert s to a list, OR convert xs to a string

// Walkthrough-#5 diagnostic:
for x in xs { perform log(x) }
// expected: E_NotAKeyword (MaybeIncorrect)
//   Quick Fix: xs |> for_each((x) => perform log(x))
```

## §9 — Cross-references

- `SYNTAX.md` §"Diagnostic catalog" — current 16-entry catalog; revised per §5.
- `src/diagnostics.mn` (or wherever) — Diagnostic ADT; applicability tag enforcement.
- `src/format.mn` — `format_default` handler; format-liftable auto-correction.
- `src/pipeline.mn` — `diagnostics_handler` site.
- `src/voice.mn` — gradient narration rendering.
- All walkthroughs #1-#6 — diagnostics introduced are integrated here.
- `protocol_canonical_projection_pattern.md` — diagnostics IS a projection of the substrate violation; render by category.
- `protocol_no_silent_fallback.md` — every diagnostic surfaces; no suppression syntax.
- `protocol_developer_experience_vision.md` — diagnostics are teaching surfaces, not punishment.

## §10 — Walkthrough closure

The diagnostic catalog is classified into three categories: format-liftable (auto-corrected silently), hard errors (substrate violations requiring user restructure), and gradient narrations (teaching suggestions in Mentl's voice). Each diagnostic carries an applicability tag determining automation. The catalog absorbs the new diagnostics from walkthroughs #1-#6.

The substrate-honest discipline: diagnostics ARE teaching surfaces. The medium auto-fixes what it can; surfaces what it can't; narrates what would improve. The user sees only what requires their attention. The friction is minimal; the learning is constant.

When this walkthrough's named follow-ups all land:
- Format-liftable diagnostics are formatter-only; the user never sees `E_RedundantBraces` again
- Hard errors carry actionable Quick Fixes per applicability
- Gradient narrations populate Mentl's voice as suggestions
- The catalog reads as a structured spec, not a flat list

This is the residue. Diagnostics were always teaching; the catalog now reflects that truth.
