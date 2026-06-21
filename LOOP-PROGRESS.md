# LOOP-PROGRESS — first-light drive (autonomous /loop)

> Durable per-iteration log. Updated EVERY loop iteration regardless of how the
> loop fires (ScheduleWakeup auto-fire or manual `/loop` re-paste). The current
> cursor + the prompt's ITERATION LOG mirror the latest entry here.
>
> **Goal:** first-light = the FIXED POINT `diff(m3.wat, m4.wat)` EMPTY AND
> correctness (7/7 micros + repro). Oracle = the artifact (`bash tools/state.sh`),
> never the census. Method: audit before symptom; probe the artifact; ultimate
> form in the WHEEL, seed minimal-correct.

| iter | changed | measured | next |
|---|---|---|---|
| 1 | fix 2: subst_ty/instantiate chase-to-root (both layers) | trap marched canonicalize→filter (progress) | fix 1 |
| 2 | fix 1: register_effect_ops full var set (WHEEL) | seed mirror paused (was over-engineering the disposable seed) | seed minimal-correct |
| 3 | **DISSOLVED handler_state_inits_registry** → live HandlerKind read (commit `7448ad4`) | filter-in-arm trap CLEARED; trap marched to `lower_one_arm_decl→lower_expr`; micros 7/7, seed compiles wheel, drift clean, census 204→201 | probe the lower_expr unreachable |
| 4 | probe only (no commit) | hypothesised the §4③ nested-handler evidence gap (lower_expr garbage node inside map(lower_one_arm_decl)). eprint-instrument INVIABLE (adding one perform shifts the ev-row → seed exit-127). | iter 5: STATIC objdump probe. |
| 5 | probe only (no commit) — **iter-4 hypothesis DISPROVEN** | **REAL ROOT = field-offset mis-resolution (NOT evidence).** objdump of m2 `lower_one_arm_decl`: arm's fields resolve to `args@0, body@8, op_name@20` (idx 0,2,5) — arm's type is mis-unified with a ≥6-field record. Correct `{args,body,op_name}` (sorted) = `0,4,8`. So `lower_expr(arm.body)` reads offset 8 (a phantom-shifted slot, NOT body) → non-node → `else→unreachable`. `resolve_field_offset` (lower.mn:1278) computes `4*idx` over arm's *resolved* sorted field list; the type is wrong, not the formula. This is field-offset-under-polymorphism — the ORIGINAL session's diagnosed root. | iter 6: find WHERE arm's type picks up the 3 phantom fields (idx 1,3,4 between args/body and body/op_name). Probe arm's resolved type at lower_one_arm_decl (the field names) — static or via lookup_ty on arm's handle, NOT eprint. Likely the map-lambda's `arm` param type generalizes/mis-unifies. Fix the inference so arm = exactly {args,body,op_name} → body@4. Connects to the type-param-effects offset-flow (carry the concrete type through the generalized helper). |

## Standing notes
- **PLAN.md §7 is stale** (still names the ev-slot seam as THE blocker) — refresh
  at a consolidation point to: registry dissolved (live HandlerKind); cursor =
  the hoeffect/nested-evidence root surfacing at `lower_handler_arms_as_decls`'
  `map(lower_one_arm_decl)`.
- **The current trap is FIELD-OFFSET, not evidence** (iter 5 corrected iter 4):
  `arm.body` mis-resolves to offset 8 in `lower_one_arm_decl` because arm's type
  is mis-unified (6+ fields, body at idx 2 not 1). The probe disproving the
  evidence hypothesis IS the discipline working — never crown a hypothesis before
  the artifact confirms it.
- **Hypotheses are claims until the artifact confirms.** eprint is inviable here
  (perturbs the ev-row); use objdump on `.build/state_m2.wasm` (the committed-
  wheel m2). The trap marches deeper per fix = progress.
- **Census baseline** bumped 190→201 (`tools/verify-baseline.txt`) for the
  type-param substrate; census is a shadow — never bump to force a commit.
