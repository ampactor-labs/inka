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
| 4 | probe only (no commit) | **ROOT FOUND:** lower_expr's exhaustive match hits `else→unreachable` = a GARBAGE node reaching it inside `map(lower_one_arm_decl, arms)` under `~> arm_state_ctx`. The map's effecting lambda (lower_one_arm_decl → lower_expr performs lookup_ty/env_lookup) trips the §4③ nested-handler evidence gap — the SAME root the registry filter hit, now in arm-body lowering. eprint-instrument INVIABLE (adding one perform shifts the ev-row → seed exit-127; the layer is too fragile to probe with effects — confirms the evidence layer IS the root). | iter 5: STATIC objdump probe (not eprint) of op_map_collector_yield → lower_one_arm_decl evidence threading — which ev-slot for lookup_ty/env_lookup is mis-read. Ultimate fix = the hoeffect evidence-capture completion (deep §4③ keystone): a stateful collector whose lambda performs an outer-handled effect must thread that effect's evidence from the install site through the collector's arm. |

## Standing notes
- **PLAN.md §7 is stale** (still names the ev-slot seam as THE blocker) — refresh
  at a consolidation point to: registry dissolved (live HandlerKind); cursor =
  the hoeffect/nested-evidence root surfacing at `lower_handler_arms_as_decls`'
  `map(lower_one_arm_decl)`.
- **The hoeffect root recurs**: every `map`/`filter` (stateful collector) whose
  lambda performs an outer-handled effect trips it. The pre-register pass + the
  former registry worked around it with direct recursive walks; the ultimate fix
  is the evidence threading, not more direct-walk workarounds (Anchor 8).
- **Census baseline** bumped 190→201 (`tools/verify-baseline.txt`) for the
  type-param substrate; census is a shadow — never bump to force a commit.
