# `><` Parallel Compose Layout — Substrate Walkthrough

> *Walkthrough #2 of the SYNTAX-ULTIMATE audit per `protocol_realization_loop.md`. Resolves the strict-vertical layout rule on `><` against the substrate-honest layout-IS-contract principle. Locks the ULTIMATE form: parser accepts inline + vertical; formatter normalizes per branch length; diagnostic narrows to the genuinely confusing case.*

## §0 — Why this walkthrough exists

`SYNTAX.md` currently rejects `(a) >< (b)` on a single line:

> ```
> // REJECTED — same line, no indent center:
> (left) >< (right)
> ```
> Diagnostic: **`E_LayoutViolation`**: "`><` must sit alone on its own line at indented center, between parenthesized branches on adjacent lines."

The strictness is justified in §"Pipe verbs" and §"Layout enforcement" by the governing principle "Layout IS contract — the shape on the page IS the computation graph." For `><` the canonical layout is:

```
(branch_a)
    ><
(branch_b)
```

The vertical stack visually conveys "two parallel branches." The substrate question: is this the ONLY substrate-honest layout, or one of several that all preserve the contract?

This walkthrough resolves the question. The answer: the layout-IS-contract rule is satisfied by ANY arrangement where the parallel topology is visually unambiguous. Strict-vertical IS substrate-honest, but so is `(a) >< (b)` when each branch is a parenthesized atomic expression — the parens themselves carry the branch-boundary contract.

## §1 — Empirical state at the time of writing

Three observations:

1. **The strict rule disallows compact forms** that are unambiguous and idiomatic. Audio examples especially: `(audio_l |> compress) >< (audio_r |> compress)` is shorter than the vertical form and reads correctly because the parens block sequential interpretation. The strict rule converts these to 5-line vertical blocks where 1 line was sufficient.

2. **The diagnostic threshold is uniform.** The current rule fires `E_LayoutViolation` regardless of branch length — a one-token branch produces the same rejection as a multi-line pipeline. Discrimination by branch shape is missing.

3. **The formatter (`format_default` handler) is the canonical render authority** per `SYNTAX.md` §"Layout enforcement / Render rule." The formatter can normalize layout at save-time. The PARSER's job is to accept; the formatter's job is to canonicalize. The current implementation conflates the two: parser rejects what formatter would otherwise normalize.

## §2 — The eight interrogations on `><` layout

### 1. Graph?

`><` produces a parallel-compose node: N independent branches, each with its own input handle, producing N output handles tupled into the result. Graph identity is independent of source-line layout — `(a) >< (b)` and the vertical form produce the SAME graph.

### 2. Handler?

`spawn` and `join` (parallelism handlers, per `lib/runtime/threading.mn`) interpret `><`. The handler reads the branch list from the AST and dispatches to threading runtime. Layout doesn't affect handler behavior.

### 3. Verb?

`><` IS the verb (parallel compose, structural N-ary). The verb's identity is the operator token + parenthesized branches; layout is a render concern, not an identity concern.

### 4. Row?

Result row = union of branch rows. Independent of layout.

### 5. Ownership?

Each branch owns its input. The result is a tuple of branch outputs. Layout-independent.

### 6. Refinement?

Branch-by-branch refinement composition; the result tuple's predicate is the conjunction. Layout-independent.

### 7. Gradient?

This is where the relaxation justification lives. The gradient at a `><` site narrates: "you are at a parallel-compose site; here are N branches; each is a pipeline." The narration's effectiveness depends on visual clarity. **Vertical layout is maximally clear when branches are themselves multi-line.** **Inline layout is maximally clear when branches are atomic.** A one-size-fits-all rule under-serves both cases.

The substrate-honest discipline: the GRADIENT chooses the layout per context. The formatter implements the gradient's choice. The parser accepts both forms and lets the formatter normalize.

### 8. Reason?

Each `><` site leaves a `Located(span, ParallelCompose(N))` Reason edge with one sub-Reason per branch. The Reason chain is independent of layout — span-data records the actual source positions, regardless of how they were arranged.

All eight interrogations clear the relaxation. The current strict rule is over-eager; it commits to vertical even when inline is substrate-honest.

## §3 — The ULTIMATE form

`><` accepts **two forms**, distinguished by branch shape:

### Form A — vertical (multi-line branches)

When any branch spans multiple lines, the construct is vertical:

```
(branch_a |> stage_1
        |> stage_2)
    ><
(branch_b |> stage_1
        |> stage_2)
```

The `><` sits alone on its own line at indented center. This is the canonical form for complex branches; the visual stack matches the multi-line topology.

### Form B — inline (atomic branches)

When all branches are parenthesized expressions that fit on one line each, the construct may be inline:

```
(branch_a) >< (branch_b)
(audio_l |> compress) >< (audio_r |> compress)
(extract_x) >< (extract_y) >< (extract_z)
```

Each branch is `(...)`-wrapped. `><` sits between branches on the same line. Whitespace around `><` is preserved (one space each side, formatter-canonical).

### Form mixing

When branches mix shape (one inline, one multi-line), the construct is vertical (Form A). Mixed-form inline is rejected — the visual asymmetry produces ambiguity:

```
// REJECTED — mixed form, different visual weights for branches:
(branch_a) >< (branch_b
              |> stage_1
              |> stage_2)
```

Diagnostic: **`E_MixedShapeBranches`** with Quick Fix wrapping the multi-line branch's first line in parens above and dispatching the entire construct to vertical layout.

### The dispatch rule

The parser's job:
- Accept either form.
- Reject mixed-form (one inline branch + one multi-line branch).
- Reject genuinely-confusing layouts (e.g., `(a) ><` on one line, `(b)` on the next — `><` shares a line with one branch but not the other).

The formatter's job:
- Normalize per branch length on save.
- If any branch is multi-line OR exceeds the target line width, render as Form A (vertical).
- If all branches are atomic and the total fits the target line width, render as Form B (inline).
- The user's local indent-width preference (editor setting) tunes the threshold; the formatter is the authority.

## §4 — Substrate cascade

### 4.1 — `src/parser.mn`: relax the `><` layout-check

The parser's parsing of `><` currently enforces strict vertical via layout assertions. The ULTIMATE form:

- Accept Form B inline: after parsing the LHS branch (parenthesized expr), if the next non-whitespace token is `TGtLt`, accept it on the same line.
- Accept Form A vertical: after parsing the LHS branch, if `TNewline` precedes `TGtLt`, also accept (current behavior).
- Reject mixed-form: track each branch's `is_multiline` flag during parse; if branches differ and the `><` is inline, surface `E_MixedShapeBranches`.

Substrate site: wherever `parse_pipe` / `parse_><` lives. The change is structural — the parser's `>< ` arm becomes context-sensitive on the upcoming branch's shape.

### 4.2 — `src/format.mn`: per-branch-length normalization

The formatter (`format_default` handler) gains a `format_><` arm that:
- Computes each branch's rendered length under current indent.
- If all branches are single-line AND the total + 4 chars (for ` >< ` separator) fits target line width: render Form B inline.
- Otherwise: render Form A vertical with `><` at indent_unit + 2 (centered between branches at left edge).
- Mixed-shape branches surface `format_><_normalize`: the formatter expands all branches to their canonical multi-line form (Form A).

The formatter is idempotent: `format(format(x)) == format(x)`. After two passes, the layout stabilizes.

### 4.3 — `bootstrap/src/parser_*.wat`: seed-side mirror

The seed's parser mirrors the wheel's. The relaxation lands in the seed's parallel-compose recognition path — accept inline and vertical, reject mixed. The seed has limited formatter substrate (formatter is wheel-only at first-light); seed only needs the parser relaxation.

## §5 — `SYNTAX.md` revision

§"`><` — parallel compose (structural N-ary)" currently states:

> **`><` is NOT a binary operator.** It is a structural N-ary construct with REQUIRED layout:
> ```
> (pipeline_a)
>     ><
> (pipeline_b)
> ```

ULTIMATE form (preserves the structural-N-ary claim, refines layout to two forms):

> **`><` is a structural N-ary construct accepting two layouts:**
>
> **Form A — vertical (canonical for multi-line branches):**
> ```
> (pipeline_a)
>     ><
> (pipeline_b)
> ```
>
> **Form B — inline (canonical for atomic branches):**
> ```
> (branch_a) >< (branch_b)
> (audio_l |> compress) >< (audio_r |> compress)
> ```
>
> **Layout requirements (parser-enforced):**
> - Each branch MUST be parenthesized — `(...)`.
> - Form A: each branch on its own line (or own indented multi-line block); `><` ALONE on its own line at indented center.
> - Form B: all branches single-line; `><` between branches with one space on each side.
> - Mixed-form rejected: `E_MixedShapeBranches` with Quick Fix to vertical.
>
> **Render rule:** the formatter normalizes per branch length:
> - All branches single-line + total fits target width → Form B.
> - Any branch multi-line OR total exceeds width → Form A.
>
> The construct as a whole reads top-to-bottom (Form A) or left-to-right (Form B); after `><` the chain returns to LEFT EDGE for whatever consumes the tupled result.

Insert immediately above the rejected forms catalog. The "Rejected `><` forms" section is updated to remove the inline-rejection entry and add the mixed-shape entry.

## §6 — Diagnostic catalog updates

Replace `E_LayoutViolation` (the inline-rejection trigger) with the narrower:

| `E_MixedShapeBranches`   | `><` branches mix inline + multi-line shapes      | wrap all branches in canonical Form A; formatter does this on save |

The general `E_LayoutViolation` remains for genuinely ill-formed constructs:
- `(a) ><` on one line, `(b)` on the next (orphan `><`)
- `><` not at indented center in Form A
- branches not parenthesized

The strict-vertical rule's enforcement softens to context-aware.

## §7 — Edge cases

**Three-or-more inline branches.** `(a) >< (b) >< (c)` is acceptable when all branches are atomic and the total fits target width. For four+ branches at any length, the formatter prefers Form A (the visual width quickly exceeds readability).

**Parenthesized single-token branches.** `(x) >< (y)` where `x` and `y` are single identifiers. Acceptable Form B. Compact and clear.

**Branches with internal commas.** `(f(a, b)) >< (g(c, d))`. Parens delineate the branches; commas inside are call-arg separators. No ambiguity.

**Branches with embedded `><`.** Nested parallel-compose. `((a) >< (b)) >< (c)` is valid — the outer `><` has two branches: a parenthesized inner `><` expression and an atomic `(c)`. The parser handles nesting via recursive descent; layout is independent at each nesting level.

**Empty branches.** `() >< (b)` — `()` is unit. Type-checks as parallel-compose between unit and `b`'s type. Allowed but unusual; the gradient may suggest restructuring (the unit branch contributes nothing).

**Single-branch `><`.** Disallowed in any form — `><` requires N ≥ 2 branches per the structural-N-ary contract. `(a) ><` (only one branch) surfaces `E_ParallelComposeArity` at parse-time.

**Form B with very long branches.** `(branch_a_with_lots_of_stages) >< (branch_b_with_lots_of_stages)` exceeding line width. The PARSER accepts (well-formed); the FORMATTER normalizes to Form A on save. The user's source is a transitional state; the canonical form is what gets committed.

**Trailing `><`.** `(a) ><\n(b)` — `><` ends a line. Ambiguous: is this Form A (with `><` at the end of the branch_a line as a continuation marker) or malformed? Resolution: rejected. `><` MUST be at indented center on its own line OR between branches inline. End-of-line `><` is `E_LayoutViolation` with a Quick Fix moving `><` to its own line.

## §8 — Named peer follow-ups (positive form per drift mode 9)

- **`Hβ.syntax.parallel-inline-parser`** — implement §4.1 (parser accepts Form A and Form B; rejects mixed-shape).
- **`Hβ.syntax.parallel-format-normalize`** — implement §4.2 (formatter chooses per branch length; idempotent normalization).
- **`Hβ.syntax.parallel-seed-mirror`** — implement §4.3 (seed parser relaxation).
- **`Hβ.syntax.parallel-doc-revise`** — implement §5 (SYNTAX.md two-form documentation).
- **`Hβ.syntax.parallel-diagnostic-narrow`** — implement §6 (replace `E_LayoutViolation` for inline `><` with `E_MixedShapeBranches`).

## §9 — Verification

After the cascade:

```
// Should parse cleanly:
echo '(audio_l) >< (audio_r) |> stereo_mix' | parser_test
# expected: parses to PipeExpr(PCompose, [audio_l, audio_r]) |> stereo_mix
# no E_LayoutViolation

// Should still parse cleanly (Form A):
cat <<'EOF' | parser_test
(audio_l)
    ><
(audio_r)
|> stereo_mix
EOF
# expected: same AST as inline form

// Should reject mixed:
cat <<'EOF' | parser_test
(branch_a) >< (branch_b
              |> stage_1
              |> stage_2)
EOF
# expected: E_MixedShapeBranches with Quick Fix to vertical
```

Formatter verification:

```
// Input: long branches inline (transitional)
let x = (long_branch_with_many_stages_a |> ...) >< (long_branch_with_many_stages_b |> ...)
// After format: Form A vertical (line width exceeded)

// Input: short branches vertical (over-formatted)
let x = (a)
    ><
        (b)
// After format: Form B inline ((a) >< (b)) since both atomic and fit
```

## §10 — Cross-references

- `SYNTAX.md` §"`><` — parallel compose (structural N-ary)" — current strict rule; revised per §5.
- `SYNTAX.md` §"Layout enforcement" — render rule; the formatter normalizes per branch length.
- `src/parser.mn` — `parse_><` site (the parallel-compose recognition); §4.1 site.
- `src/format.mn` — `format_default` handler; §4.2 site for `format_><` arm.
- `bootstrap/src/parser_*.wat` — seed parser; §4.3 site for parallel-compose recognition.
- `lib/runtime/threading.mn` — spawn/join handlers that read the parallel-compose AST.
- `protocol_canonical_projection_pattern.md` — render IS a projection of the AST; formatter is the canonical projector.
- `protocol_parse_is_eager_graph_projection.md` — parser accepts; later stages narrow. Layout-strict-rejection at parse-time is eager-form-commitment when the formatter could canonicalize.
- `protocol_oracle_is_ic.md` — formatter is idempotent; IC fixpoint converges in one iteration.

## §11 — Walkthrough closure

`><` is structural N-ary; layout is render-level not identity-level. The parser accepts both inline and vertical forms; the formatter normalizes per branch length. The strict-rejection of inline was an eager commitment — the page-shape contract is honored by ANY layout where parallel topology is visually unambiguous, and `(a) >< (b)` with parens-as-branch-boundaries is unambiguous when branches are atomic.

When this walkthrough's named follow-ups all land:
- The `><` rough edge dissolves entirely.
- Compact pipelines like `(audio_l |> compress) >< (audio_r |> compress)` become first-class.
- Multi-line branches still get the canonical vertical layout via formatter normalization.
- The `E_LayoutViolation` diagnostic narrows to the genuinely confusing case (mixed-shape, orphan `><`).

This is the residue. The compact form was waiting to be permitted.
