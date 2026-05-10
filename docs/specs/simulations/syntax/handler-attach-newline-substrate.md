# `~>` Handler-Attach Newline Disambiguation — Substrate Walkthrough

> *Walkthrough #6 of the SYNTAX-ULTIMATE audit per `protocol_realization_loop.md`. CONFIRMING walkthrough — locks the rationale for `~>`'s newline-disambiguation rule (Form A vs Form B). No spec change; the substrate-honest analysis affirms current SYNTAX.md.*

## §0 — Why this walkthrough exists

`SYNTAX.md` §"`~>` — tee (handler-attach)" states:

> A `Newline` token directly before `~>` means Form A. No newline means Form B. **This is the only place in Mentl where whitespace is semantically load-bearing.** It is load-bearing because the visual layout IS the computation graph.

The 2026-05-10 SYNTAX read flagged this as a possible "rough edge" — the only place in Mentl where whitespace is load-bearing is a foot-gun candidate. Walkthroughs #1 (`++`) and #2 (`><`) successfully relaxed similar friction. Should `~>` follow?

This walkthrough resolves the question. The answer is **NO** — the newline rule IS substrate-honest for `~>` precisely because no alternative disambiguation exists for it (unlike `><`, which has parens-as-branch-boundaries, or `++`, which has type-aware dispatch). The layout-IS-contract principle cuts hardest where the layout IS the only signal.

The walkthrough confirms current SYNTAX.md authoritatively and locks the rationale.

## §1 — Empirical state

Three observations:

1. **`~>` has no syntactic delimiter for its scope.** Unlike `><` where parens around each branch convey "this is one branch," `~>` chains have no parens around the body or handler. `body |> stage ~> handler` is a flat sequence of tokens.

2. **Form A (block) and Form B (inline) produce different graphs.** Block-form wraps the entire prior chain in the handler; inline-form wraps only the immediately-preceding stage. The graph identity differs; the AST nodes differ; the row-algebra differs (block-form's handler covers more effects than inline-form's).

3. **The relaxation pattern from `><` doesn't apply.** `><`'s parens IS the alternative disambiguation that allowed inline-form to be substrate-honest. `~>` has no equivalent — without the newline, the parser cannot decide which prior chain segment the handler wraps.

## §2 — The eight interrogations on `~>`'s scope

### 1. Graph?

`~>` produces a handler-attach node where the BODY is the wrapped expression. The SCOPE of the body is the substrate decision: does it wrap the prior chain (Form A) or just the immediately-preceding stage (Form B)?

The graph node identity differs:
- **Form A:** `LHandleWith(handle, prior_full_chain, handler_state_record)` — body covers many stages
- **Form B:** `LHandleWith(handle, prior_one_stage, handler_state_record)` — body covers one stage

The two are structurally distinct AST nodes. The user's authored intent must distinguish them.

### 2. Handler?

`~>` installs a handler-state-record at the attach site (per task #129 — handler-state-record-via-graph-projection, completed). The state record's scope IS the body it wraps. The scope must be unambiguous at parse-time.

### 3. Verb?

`~>` IS the verb. Its layout IS its topology decision — block vs inline.

### 4. Row?

Form A's handler covers the whole prior chain's row. Form B's handler covers only the preceding stage's row. The row algebra differs:

```
// Form A: handler subtracts from chain row
source |> lex |> parse |> infer
  ~> diagnostics_handler        // row = (lex's + parse's + infer's row) - diagnostics

// Form B: handler subtracts from stage row only
source
  |> lex
  |> parse ~> diagnostics_per_parse_stage   // diagnostics covers parse only
  |> infer                                   // infer's row independent
```

The row algebra makes the scope decision LOAD-BEARING, not cosmetic. A user who confuses Form A with Form B produces a row that doesn't match their intent.

### 5. Ownership?

The handler's state record is owned at the scope's lifetime. Form A's record lives across the whole chain; Form B's record lives one stage. Ownership semantics differ.

### 6. Refinement?

Scope predicates differ. A handler that asserts "all stages within this scope have property P" must know which stages it covers. Form A vs Form B determines the assertion's reach.

### 7. Gradient?

This is the interrogation that locks the analysis. The gradient at a `~>` site narrates: "the handler `H` wraps the body `B`." The SCOPE of `B` IS the user's authored intent. Without an unambiguous parser signal, the gradient cannot narrate accurately.

The newline-before-`~>` IS the unambiguous signal. The layout-IS-contract principle says: the page-shape is the computation graph. For `~>`, the newline IS the page-shape that distinguishes scopes.

The alternatives:

- **Two distinct tokens** (`~>` for inline, `~~>` for block): doubles the operator vocabulary for one verb. Fragments learning. Rejected.
- **Always-block** (`~>` always wraps prior chain): forces parens on inline use (`body |> (stage ~> handler) |> next`). Verbose for short scopes. Rejected.
- **Always-inline** (`~>` always wraps just preceding stage): forces parens on block use (`(body |> chain) ~> handler`). Verbose for long scopes. The strict-vertical layout would have to accept the parens. Rejected.
- **Newline-disambiguation (current):** zero-token-cost; layout IS the topology; parens still available as explicit override. Accepted.

### 8. Reason?

Each `~>` site leaves Reason chain edges per scope. Form A's reasons reach all stages within the chain; Form B's reasons reach one stage. The Reason chain reflects the user's authored scope.

## §3 — The ULTIMATE form

`~>` accepts two forms, distinguished by newline-before:

### Form A — block-scope (newline before `~>`)

The handler wraps the WHOLE prior chain.

```
source
  |> lex
  |> parse
  |> infer
  ~> env_handler            // wraps (lex |> parse |> infer)
  ~> graph_handler          // wraps env_handler(...)
  ~> diagnostics_handler    // outermost — sandbox boundary
```

Each `~>` is on its own line at the LEFT EDGE; the newline-before makes the scope unambiguous.

### Form B — inline (no newline before `~>`)

The handler scopes to the IMMEDIATELY-PRECEDING stage only.

```
raw_string
  |> parse_json ~> catch_parse_error(default = "{}")
  |> validate ~> log_warnings
  |> save_to_db
```

Each `~>` is on the same line as its preceding `|>` stage; no newline gap.

### Parens override

Both forms can be made explicit via parenthesization:

```
// Explicit block-scope:
(source |> lex |> parse |> infer) ~> env_handler

// Explicit inline-scope:
source |> lex |> parse |> (infer ~> per_infer_handler) |> emit
```

When parens are present, the newline-rule is overridden — parens explicitly delimit the scope. The substrate-honest discipline: when the layout is unambiguous (parens), use it; when not, the newline rule applies.

### Why this is the residue

For `~>`, the newline IS the topology decision because:
- No alternative disambiguator exists (unlike `><`'s parens-per-branch).
- The scope decision is LOAD-BEARING (different graph node, different row).
- The page-shape rule: layout IS contract. Newline = block; same-line = inline.
- Parens override is always available for explicit cases.

The "rough edge" framing was wrong. The newline rule is the page-shape rule applied at maximum strictness, where strictness is justified because the layout IS the only signal.

## §4 — Substrate cascade (no spec change required)

### 4.1 — Confirm parser implementation

The parser's `~>` handling already disambiguates by newline. Audit:
- `parse_pipe_chain` checks for `TNewline` token before `TTildeGt`.
- If present, `~>` has block precedence (lowest, captures whole prior chain).
- If absent, `~>` has inline precedence (alongside `<|`, `><`, `<~`).
- See `SYNTAX.md` §"Operator precedence" levels 3 (block) and 4 (inline).

### 4.2 — Confirm formatter behavior

The `format_default` handler (per `src/format.mn`) renders `~>` per the user's authored intent:
- Block-form: newline before `~>`; left-edge alignment.
- Inline-form: same-line; one space each side of `~>`.

The formatter does NOT auto-convert between forms — the user's authored scope IS the truth. The formatter only normalizes whitespace within each form.

### 4.3 — Gradient teaching

When a user types `body |> stage1 |> stage2 ~> handler` (no newline) intending block-scope, the gradient narrates: "this `~>` is INLINE — it scopes to `stage2` only. For block-scope, add a newline before `~>`."

When a user types the block-form intending inline, the gradient narrates: "this `~>` is BLOCK — it wraps the full chain. For inline, remove the newline."

The teaching surfaces at the friction-point. The user's intent is verified against the layout; mismatch surfaces a Quick Fix.

### 4.4 — `mentl edit` integration

In `mentl edit`, the cursor at `~>` highlights its scope: Form A renders the wrapped chain in a subtle highlight; Form B renders just the preceding stage. The visual feedback teaches the rule.

## §5 — `SYNTAX.md` revision (CONFIRMING — no change required)

The current spec text at §"`~>` — tee (handler-attach)" is correct and substrate-honest. **No revision required.** This walkthrough's conclusion: lock the rationale.

The "**This is the only place in Mentl where whitespace is semantically load-bearing.**" sentence stays — and is reframed not as an apology but as a feature: the load-bearing whitespace IS the substrate's voice when no other signal is available.

Optional: append a paragraph linking to this walkthrough:

> See `docs/specs/simulations/syntax/handler-attach-newline-substrate.md` for the substrate analysis. The newline-disambiguation is substrate-honest because no alternative disambiguator exists for `~>`'s scope (unlike `><` which has parens-per-branch). Form A and Form B produce structurally distinct AST nodes with different rows; the layout IS the only unambiguous signal. Parens override is available for explicit cases.

## §6 — Diagnostic catalog (no change)

No new diagnostics. The existing `E_LayoutViolation` catches malformed `~>` placements (e.g., `~>` at end of line with body on next line, or arbitrary indent disagreement).

## §7 — Edge cases

**Multiple `~>` on the same chain.** Form A allows stacking:

```
source
  |> stages
  ~> handler_a           // wraps stages
  ~> handler_b           // wraps handler_a's wrapped chain
```

Each `~>` on its own line; each scope nests outward. Innermost is `handler_a`; outermost is `handler_b`. Trust hierarchy reads top-to-bottom.

Form B can also stack:

```
body |> stage_a ~> handler_a |> stage_b ~> handler_b
```

Each handler scopes to its preceding stage only. Independent scopes; no nesting.

**Mixed Form A and Form B.** Allowed:

```
body
  |> stage_a ~> per_stage_a_handler   // inline: scopes stage_a only
  |> stage_b
  ~> overall_handler                   // block: scopes the chain so far
```

The newline rule applies per-`~>` independently. Mixed forms are substrate-honest when the user's intent differs per attach point.

**Parens with newline.** `(body |> chain) ~> handler` on one line — explicit block via parens; newline rule moot. `(body |> chain)\n~> handler` — also explicit block; redundantly newline-disambiguated. Both accepted.

**`~>` at line start with no preceding content.** `~> handler\n body` — orphan `~>`. Surfaced as `E_OrphanHandlerAttach` with Quick Fix to delete or restructure.

## §8 — Named peer follow-ups

- **`Hβ.syntax.tilde-gt-parser-confirm`** — audit `parse_pipe_chain`'s newline-disambiguation handling.
- **`Hβ.syntax.tilde-gt-format-confirm`** — confirm `format_default` preserves user's authored scope (Form A vs Form B).
- **`Hβ.syntax.tilde-gt-gradient-narrate`** — implement §4.3 (gradient narrates scope at `~>` cursor positions).
- **`Hβ.syntax.tilde-gt-doc-append`** — implement §5 (optional paragraph linking to this walkthrough).
- **`Hβ.syntax.tilde-gt-mentl-edit-highlight`** — implement §4.4 (`mentl edit` visual scope highlight).

## §9 — Verification

```
// Form A — block-scope:
let x = source |> lex |> parse
        ~> env_handler
        ~> diagnostics_handler
// expected: parses to LHandleWith(diag, LHandleWith(env, LHandleWith(parse_chain, ...)))
//   where parse_chain = source |> lex |> parse

// Form B — inline-scope:
let y = source |> parse ~> log_per_parse |> infer
// expected: parses to (parse ~> log_per_parse)|> infer
//   inline scope: log_per_parse wraps parse only

// Parens override block:
let z = (source |> lex |> parse) ~> env_handler |> emit
// expected: env_handler wraps (lex |> parse); emit is downstream

// Mixed forms:
let w = body
          |> stage ~> per_stage
          ~> outer_block
// expected: (body |> (stage ~> per_stage)) ~> outer_block
```

## §10 — Cross-references

- `SYNTAX.md` §"`~>` — tee (handler-attach)" — current rule; CONFIRMED per §5.
- `SYNTAX.md` §"Operator precedence" — `~>` levels 3 (block) and 4 (inline).
- `src/parser.mn` — `parse_pipe_chain` site for newline-disambiguation.
- `src/format.mn` — `format_default` formatter; preserves authored form.
- `protocol_canonical_projection_pattern.md` — layout IS the projection at `~>`'s home.
- `protocol_emit_is_graph_projection.md` — emit reads the wrapped scope from the AST faithfully.
- Walkthrough #2 (parallel-compose-layout-substrate.md) — relaxation worked there because parens-per-branch provided alternative disambiguation; this walkthrough explains why the same relaxation does NOT apply to `~>`.

## §11 — Walkthrough closure

`~>`'s newline-disambiguation IS the substrate, not a foot-gun. The page-shape contract is most important where the layout IS the only signal — for `~>`, that's the case. Parens override is always available; default behavior is layout-based.

The walkthrough CONFIRMS current SYNTAX.md without revision. The acknowledged "only place in Mentl where whitespace is semantically load-bearing" is reframed: not an apology, but the substrate speaking when no other signal is available.

When this walkthrough's named follow-ups all land:
- The parser's newline-handling is audited and confirmed
- The formatter preserves authored scope (no auto-conversion)
- The gradient teaches scope at the friction-point
- `mentl edit` highlights scope visually
- The discipline holds; the rationale is locked

This is the residue. The rule was always substrate-honest; this walkthrough names why.
