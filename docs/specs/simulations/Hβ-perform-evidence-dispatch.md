# Hβ.first-light.perform-evidence-not-default-handler

> **Handle:** `Hβ.first-light.perform-evidence-not-default-handler`
> **Cursor:** Phase H first-light-L1, Blocker 1 (mentl2 traps with
> `indirect call type mismatch` on its own machinery, even on
> `fn main(x)=x`; pass3 collapses to 0 funcs).
> **Layer:** lower (perform dispatch) + emit (evidence load) + seed mirror.
> **Authored:** 2026-06-07. Riffle-back against `Hβ-lower-substrate.md`
> §evidence (H1.6 `derive_ev_slots`), `protocol_handler_is_state_is_closure_is_evidence.md`
> (2026-05-09), `protocol_no_silent_fallback.md`, and the chain crystallization
> `protocol_reflexive_interiority.md` (2026-06-07).

---

## 0. The thesis in one line

`perform op` is an **interior read of the handler stack at the perform
site** — never an exterior static guess at "the handler for this op."
The seed and the wheel both carry a fallback that makes the guess; that
fallback is the drift, and deleting it is the fix.

This handle is the smallest concrete instance of
`protocol_reflexive_interiority.md`: the call site / perform site is an
*exterior observer* of a fact that is *interior* to the running graph
(which handler is installed). When lower resolves the perform statically
against a global default-per-op map, it is an exterior guess; the trap is
the receipt.

---

## 1. Empirical finding (the trace that decides this)

mentl2 = the seed's compile of the 29k-line wheel (`bootstrap/build.sh`
→ `bootstrap/mentl.wasm`; `cat src/*.mn lib/**/*.mn | wasmtime run`). It
is a *valid* WASM module (`wat2wasm` clean, 1998 funcs, 65,636 lines) but
traps at runtime on `fn main(x)=x` — a program with **no user call** — so
the fault is in the wheel's own machinery as emitted by the seed.

Backtrace (innermost first):

```
0: op_map_collector_yield   ← TRAP at call_indirect (type $ft2)
1: iterate_from
2: for_each
… → _start
```

`for_each(f, xs) = { iterate(xs) } ~> each_handler(f)` (lib/prelude.mn:165).
A yield raised inside `for_each` is being handled by **`map_collector`'s**
arm, not `each_handler`'s. The shared `iterate_from` (lib/prelude.mn:32,
`with Iterate`) raises `perform yield`, and the seed lowered that perform
to a **static direct call** to `op_map_collector_yield` with the global
`$map_collector_state_g` as state. The emitted `iterate_from` body:

```wat
(global.get $map_collector_state_g)              ;; map_collector's state
… (call_indirect …)(call $op_map_collector_yield)(drop)   ;; static arm call
```

Because `iterate_from` is shared across `map` / `filter` / `for_each` /
`fold` / `any` / …, binding its yield to `map_collector` breaks every
non-`map` use: the caller installed a *different* handler, but the perform
still calls `op_map_collector_yield` against an uninitialized global,
reads `f` from `map_collector`'s state offset, gets a garbage funcref, and
`call_indirect (type $ft2)` mismatches. mentl2 traps; pass3 = 0.

**The "indirect call type mismatch" is a symptom of wrong-handler
dispatch, not a call-arity bug.**

---

## 2. The exact site

### Seed — `bootstrap/src/lower/walk_call.wat`

`$lower_resolve_handler_for_op(op_name)`:

1. Resolve `op_name` → its effect via `env_lookup` → `EffectOpScheme`
   (tag 133) → `schemekind_effectop_name`. ✓ (graph-correct)
2. Walk the lower-stage handler-stack (`$lower_handler_stack_ptr`,
   `$lower_handler_count_g`) innermost-first, matching a handler whose
   scheme body is `TName("Handler", [TName(ename)])`; on match return
   `"<hname>_<op_name>"`. ✓ (lexically scoped — correct)
3. **Fallback (the drift):**

```wat
;; Hβ.first-light.tier2-perform-or-env-scan — fall back to the
;; default-handler-per-op map.
(local.set $hname (call $lower_lookup_default_handler_for_op (local.get $op_name)))
(if (i32.ne (local.get $hname) (i32.const 0))
  (then
    … build "<hname>_<op_name>" …
    (return (local.get $target))))
(i32.const 0))
```

For top-level `iterate_from` the handler-stack is empty, the loop finds
nothing, and the fallback returns `map_collector` (yield's registered
default), producing a Tier-1 static bind instead of `LEvPerform`.

`$lower_perform` (walk_call.wat:749-767) then:

```wat
(local.set $resolved (call $lower_resolve_handler_for_op (local.get $op_name)))
(if (i32.ne (local.get $resolved) (i32.const 0))
  (then  ;; Tier 1 — static arm call. ← TAKEN for iterate_from (WRONG)
    (call $lexpr_make_lperform_with_state … (local.get $resolved) …
          (call $lower_lookup_default_handler_for_op …)))
  (else  ;; Tier 2 — evidence-passing.  ← SHOULD BE TAKEN
    (call $lexpr_make_levperform … (local.get $op_name)
          (call $lower_compute_ev_slot_for_op …) …)))
```

### Wheel — `src/lower.mn` `lower_perform_dispatch`

The identical drift, in Mentl:

```
fn lower_perform_dispatch(handle, op_name, lo_args) = {
  if effect_in_current_fn_row(op_name) {
    LEvPerform(handle, op_name, effect_slot_in_row(op_name), lo_args)   // correct
  } else {
    match perform inf_handler_provider(op_name) {
      Some(handler_name) =>
        LPerform(handle, handler_name |> str_concat("_") |> str_concat(op_name), lo_args), // DRIFT
      None => LPerform(handle, op_name, lo_args)
    }
  }
}
```

`effect_in_current_fn_row("yield")` is *correct* in the wheel (maps op→effect
via `lookup_parent_effect`, checks the declared row) and returns true for
`iterate_from` (`with Iterate`). The wheel's branch-(B) `inf_handler_provider`
fallback is the analog of the seed's default-per-op map and is the same
drift — it must not produce a static bind for a handler-dispatched op.

---

## 3. The eight interrogations (on the handle)

1. **Graph?** The handler stack at the perform site already encodes *which
   handler is installed*; the `EffectOpScheme`/`EffectDeclKind` edge already
   encodes op→effect and the evidence slot index. Nothing about "the default
   handler for yield" belongs in a side map — the graph holds the truth.
2. **Handler?** The perform IS a handler dispatch. For a handler-dispatched
   op with no lexical handler in scope, the handler arrives as *evidence*
   from the caller (`@resume=` discipline of the arm is preserved through
   the continuation; tail-resumptive `yield` arms resume OneShot).
3. **Verb?** `~>` install at the caller (`map`/`for_each` bodies) threads
   evidence through the `|>`/call chain into `iterate_from`. No new topology.
4. **Row?** `iterate_from … with Iterate` — the open row over `Iterate` IS
   the contract that the callee receives evidence for Iterate's ops
   (`920c57f` "row IS the contract"). The slot index is read from the row +
   `EffectDeclKind`, not assigned by a registry.
5. **Ownership?** The evidence record is `ref`-read at the perform site
   (the arm fn + state are borrowed from `__state`); no move. The handler's
   state record is owned by the `~>` installer.
6. **Refinement?** Post-fix invariant: every `perform` of a non-builtin,
   handler-dispatched op with empty lexical handler-stack lowers to
   `LEvPerform` — `resolved == 0 ⟺ LEvPerform`. No static bind survives
   for a shared polymorphic iterator.
7. **Gradient?** The open-vs-ground row already gates Tier-2-vs-Tier-1
   (`monomorphic_at`). The gradient need is: ground row → direct `LCall`;
   open row → evidence. Deleting the fallback lets the existing row
   annotation do the gating instead of a hand-rolled default map.
8. **Reason?** The `LEvPerform` carries the perform-site handle; the Reason
   chain reads "yield dispatched via evidence slot N of the Iterate row,
   installed by <caller's ~> handler>" — recoverable, unlike the static
   bind which erased the installer.

---

## 4. The fix shape — AUDITED SCOPE (lands whole; seed + wheel in lockstep)

> **Riffle-back correction (2026-06-07, post caller-audit).** The first
> draft assumed "delete one fallback block." The caller audit
> (`grep lower_lookup_default_handler_for_op`) revealed the
> default-handler-per-op map does **double duty** across **six sites**.
> It is defined in `state.wat` (so is the resolver), not `walk_call.wat`.
> Beyond the dispatch fallback, the map is how *both* perform-lowering
> paths obtain the state-record key (`$<handler>_state_g`) for a Tier-1
> perform. Deleting it naively breaks Tier-1 state resolution at three
> sites. The substrate-honest fix is a **canonical projection**, not a
> deletion-in-isolation.

**The redundancy that names the fix.** `$lower_resolve_handler_for_op`
already knows the matched handler name `hname` from its lexical stack
walk — but discards it (returns the concatenated `"<hname>_<op>"` target),
after which each caller re-derives state by a second lookup into the
global default map. One fact (the lexically-installed handler), read
twice by two mechanisms — drift 7 plus the exterior guess. Collapse to
one read.

### Seed edits

1. **`bootstrap/src/lower/state.wat` — `$lower_resolve_handler_for_op`:**
   on lexical stack-match return `hname` (not the concatenated arm-target);
   **delete the default-handler-per-op fallback block**; end with
   `(i32.const 0)` after the loop. No-match → 0.
2. **`bootstrap/src/lower/walk_call.wat` — both perform-lowering paths**
   (CallExpr-effect-op arm ~543; `$lower_perform` PerformExpr arm ~749):
   on `hname != 0`, build the arm symbol `"<hname>_<op>"` AND the state key
   `$<hname>_state_g` from that one `hname` (one projection feeds both);
   on 0, emit `LEvPerform`. Remove the separate
   `$lower_lookup_default_handler_for_op` state calls at both sites.
3. **Delete** `$lower_register_default_handler_for_op` +
   `$lower_lookup_default_handler_for_op` + the `$lower_default_op_handler_map_*`
   globals (`state.wat:461/491`), and the registration call at
   **`bootstrap/src/infer/walk_stmt.wat:1219`**. No residue comment, per
   `protocol_delete_dont_explain_absence.md`.

### Wheel edit

4. **`src/lower.mn` — `lower_perform_dispatch`:** seed (lexical
   handler-stack walk) and wheel (`effect_in_current_fn_row` row-check) use
   *divergent* dispatch mechanisms; the lockstep commit reconciles them on
   one contract — **handler-dispatched op with no lexical/row handler →
   `LEvPerform`; never a static bind to a global default.** The `else`
   branch's `inf_handler_provider → LPerform(handler_name …)` is the wheel's
   analog of the seed fallback — restructure to `LEvPerform`. Keep
   `None => LPerform(op_name)` only for builtin direct-emit ops (WASI/memory),
   which the seed already short-circuits *before* the resolver via
   `$wasi_op_target_name`/`$memory_op_target_name`; mirror that ordering.

### Why WASI/memory stay LPerform

A builtin op has exactly one objectively-ultimate lowering (a WASM
instruction / import); a user effect op is *dispatched*. The fallback
conflated the two; keeping the WASI/memory short-circuit ahead of the
resolver preserves the line.

### Evidence chain (the empirical fork)

The caller side already emits `LSuspend` with `ev_slots` for open-row
callees (`src/lower.mn` `lower_call` → `derive_ev_slots`); the perform side
has `LEvPerform` + `$lower_compute_ev_slot_for_op`; emit has the
`LEvPerform` load path. **If** any of (slot computation, emit-side load
from `__state`, caller-side evidence store) is incomplete, the trap will
*move* (empty/garbage slot) rather than vanish — surfacing a §7 peer
handle. The post-fix `first-light.sh` run distinguishes "fallback was the
only gap" from "fallback masked an incomplete chain."

---

## 4.5 The real gate — the unified-record-layout resolution (empirical escalation 2026-06-07)

Executing §4's core change (fallback → `LEvPerform`) and running the
empirical loop walked the cursor to the true L1 gate. The dispatch fix
worked at the lowering layer — `iterate_from`'s `perform yield` now emits
`(local.get $__state)(i32.load offset=8)(call_indirect $ft2)` (evidence
read) instead of a static `op_map_collector_yield` call. But the trap
**moved** rather than vanished, exposing that **"one record, four roles"
(`protocol_handler_is_state_is_closure_is_evidence.md`) is declared in
comments but not coherently realized.** Two compounding faults:

**(a) The record isn't threaded through the handler's dynamic extent.**
`map`'s body builds the handler state record, writes it to the global
`$map_collector_state_g`, and calls `iterate(xs)` passing `iterate`'s
*bare 8-byte static closure* as `__state`. `iterate → iterate_from`
inherit that bare closure; `iterate_from`'s `LEvPerform` reads `__state[8]`
— past the end of an 8-byte record → garbage funcref → trap.

**(b) Four un-coordinated offset conventions on the one record:**

| Reader | Offset for the same datum | Source |
|---|---|---|
| install-write (`map` body) | `f@8, buf@12, count@16` | LHandleWith emit |
| arm-state-read (`op_map_collector_yield`) | `f@8, buf@12, count@16` | arm body — *agrees with install* |
| state-mutation-store (`resume() with buf=…`) | `buf@8` | `LStateSlotStore` — **disagrees** (state-field-only numbering) |
| evidence-read (`iterate_from` `LEvPerform`) | arm-idx`@8` (= `8 + 4·body_cc + 4·slot`, body_cc=0) | `LEvPerform` emit — **collides with `f@8`** |

`LEvPerform` computes its offset from the *lowering body's static capture
count* (`current_body_captures`), but the record it reads at runtime is the
installed *handler's* record, whose state slots occupy `8…`. Static
body-captures cannot locate evidence that sits after a *handler's* state
slots it knows nothing about. Same exterior-guess pathology as the deleted
fallback, one layer down.

### The dream-coded ultimate form (the resolution)

ONE record, ONE offset convention, threaded **by reference** through the
handler's dynamic extent:

```
handler state record:
  offset 0:                 fn_ptr        (handler identity; result-arm or unused for state)
  offset 4:                 nstate        (FENCE — count of param+state slots)
  offset 8 + 4·i:           state slot i  (handler params, then `with` fields, source order)
  offset 8 + 4·nstate + 4·j: ev slot j    (NOT used for self; see threading)
```

Three coordinated reads, all `8 + 4·i` for state (install-write,
arm-state-read, **and** state-mutation-store — fixing fault (b)'s row 3):

1. **Install (`LHandleWith`)** builds this record AND threads it into the
   evidence slot of every call in its body to a callee whose row is open
   over the handled effect (`iterate`). The `$<hname>_state_g` global
   retires.
2. **Evidence is the handler-record pointer, by reference.** `LSuspend`'s
   ev slot stores the *handler state record pointer*, not a bare arm-idx.
   `iterate_from`'s `__state` evidence slot therefore holds `map_collector`'s
   record.
3. **`LEvPerform`** loads the handler record from its evidence slot, then
   calls the op's arm with **that record** as the arm's `__state` (so the
   arm reads `f/buf/count` from the record it was built against), with the
   arm fn-idx found via the handler record. The evidence-slot offset is
   read as a projection of the record's own fence (`__state[4]`) at the
   perform site — **interior read, not static body-captures** (reflexive
   interiority: the offset is a projection of the record, not a guess).

This is `handler_is_state_is_closure_is_evidence` actually realized: the
handler record IS state (slots `8+4i`), IS closure (`fn_ptr@0`), IS evidence
(passed by reference through callees' ev slots), IS continuation-base (H7
`LMakeContinuation` extends the same shape). The arm always runs against the
record it was installed with, no matter how deep the call chain that raised
the op.

### Scope (coordinated; seed + wheel; lands whole)

- `LHandleWith` emit (seed `emit_handler.wat` + wheel `wasm.mn:1700`): build
  record with fence + state slots; thread record into body-call ev slots;
  drop the `_state_g` global.
- `LSuspend` emit (wheel `wasm.mn:1610` + seed): ev slot = handler-record
  pointer.
- `LEvPerform` emit (wheel `wasm.mn:1824` + seed `emit_handler.wat`): load
  handler record from ev slot; fence-relative arm-idx; call arm with the
  handler record.
- `LStateSlotStore` (wheel `wasm.mn:1864` + seed): unify on `8 + 4·i`
  (params+state numbering), matching install + arm-read.
- lower (`lower_call` / `derive_ev_slots`, seed + wheel): emit `LSuspend`
  with the handler-record evidence for calls to effect-open callees.

This is THE first-light gate; the §4 fallback deletion is its step 1
(kept as WIP, not committed alone — drift 9 otherwise). Resolving the one
layout is the highest-leverage move in the project.

## 5. Empirical verification (Anchor 7 — before claiming closure)

1. **Micro, pre-fix (captured):** `fn main(x)=x` → mentl2 traps at
   `op_map_collector_yield`. ✓ (this trace)
2. **Micro, post-fix:** rebuild seed; `fn main(x)=x` through mentl2 must
   no longer trap; pass3 funcs > 0.
3. **Targeted:** a wheel-shaped program exercising `for_each` and `fold`
   (distinct handlers over shared `iterate_from`) compiled by mentl2 must
   dispatch each to its OWN arm — inspect emitted `iterate_from`: the
   `perform yield` must be `call_indirect` through an evidence slot in
   `__state`, NOT `(call $op_map_collector_yield)`.
4. **L1 probe:** `bash bootstrap/first-light.sh` — pass2 must still emit
   (regression guard); pass3 funcs must rise from 0 (mentl2 now runs as a
   compiler). The `E_UnresolvedType`/`NFree` count (Blocker 2, separate
   handle) is orthogonal and may remain.

Verification is by `mentl-build` + `mentl-first-light` (empirical), not by
asserting from source.

---

## 6. Forbidden patterns (per drift mode)

- **Drift 1 (vtable):** N/A in spirit, but note — the fix is NOT "build a
  dispatch table for handlers." Evidence-passing loads one fn-ptr from a
  graph-derived slot; "vtable" never appears in the correct description.
- **Drift 8 (string-keyed-when-structured):** the default-handler-per-op
  *map* IS this drift (op-name string → handler-name string, a global
  registry). Deleting it removes the drift; do not replace it with another
  lookup table.
- **Drift 9 (deferred-by-omission):** if the evidence chain has a gap,
  name it as a peer handle (below) with the structural reason — do not land
  "fallback deleted, evidence wiring later."
- **No silent fallback** (`protocol_no_silent_fallback.md`): the fallback
  produced a plausible-but-wrong static bind. The honest form is
  `LEvPerform`; if evidence is genuinely absent, that is a typed error
  (open row not discharged), not a default guess.
- **Bug class — `_ => <fabricated>`:** the default-handler map is the
  function-level version of fabricating a value over a load-bearing ADT
  (the handler stack). Enumerate honestly: lexical handler, or evidence.

---

## 7. Named peer follow-ups (positive form)

- **Hβ.lower.evperform-slot-from-effectdeclkind** — if `$lower_compute_ev_slot_for_op`
  or `effect_slot_in_row` mis-orders multi-op effects, the evidence slot is
  wrong; pin slot ordering to `EffectDeclKind` source order (must match
  `derive_ev_slots`). Open this only if §5.3 shows a slot mismatch.
- **Hβ.emit.evperform-load-from-state** — if emit's `LEvPerform` path does
  not load `(arm_fn_ptr, state)` from the correct `__state` evidence offset,
  the dispatch reaches a garbage slot. Open only if §5.2 trap moves rather
  than vanishes.
- **Hβ.lower.suspend-evidence-store-at-install** — if the `~>` installer
  (`map`/`for_each` body) does not store its handler's arm+state into the
  evidence slot the callee reads, the slot is empty. Open only if §5.3 shows
  empty evidence.

These three are the evidence chain's three links; §5 distinguishes "fallback
was the only gap" (all three already wired) from "fallback masked an
incomplete chain" (one or more links open). The walkthrough refuses to
predict which without the post-fix empirical — that is the Anchor 7
discipline, not deferral.

---

## 8. Landing discipline

Whole handle: seed fallback deletion + wheel branch-(B) restructure land
in **one commit** (seed and wheel must agree on the perform-dispatch
contract, else L1 parity breaks). The three peer follow-ups in §7 are
genuine peers — each lands only if the post-fix empirical surfaces its
gap, each with its own micro-walkthrough paragraph. This is not
"substrate now, wiring later": the wiring (LSuspend/LEvPerform/emit-load)
is *already in the tree*; this handle removes the short-circuit that
bypassed it and verifies the chain end-to-end.

---

## 9. Why this is the objectively-ultimate form

`for_each` / `map` / `fold` are not eight separate mechanisms — they are
eight handlers on the one `Iterate` effect (lib/prelude.mn:16 "One effect.
Every collection operation is a handler on it."). The objectively-ultimate
substrate is `Iterate` + handler-evidence-dispatch; the named surface
functions are projections of it. A shared `iterate_from` raising `perform
yield` to *whichever handler the caller installed* is the entire point of
the effect system — it is what makes the surface functions cheap
projections rather than duplicated loops. The default-handler fallback
defeated exactly this: it collapsed the dynamic dispatch into a static
bind, which works for the *first* handler and silently breaks the rest.
Removing it is what earns `for_each` the right to exist as a projection
of `Iterate` rather than a bolted-on special case — fixpoint-stable under
self-application (it will survive first-light because the medium
regenerates it from the substrate, not from a registry entry).
