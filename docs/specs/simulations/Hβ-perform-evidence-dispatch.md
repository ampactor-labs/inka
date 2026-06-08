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
(committed `d1714f5`). Resolving the one layout is the highest-leverage
move in the project.

### 4.6 The build entry point + de-risk (2026-06-07)

The coordinated build's first piece is the **`monomorphic_at` / `row_is_ground`
semantics**, and tracing it de-risked the whole arc:

- `$row_is_ground` (`bootstrap/src/lower/lookup.wat`) returns "ground"
  (→ monomorphic → `LCall`, no evidence) when the row is **pure OR closed**.
  `iterate_from`'s `with Iterate` is a *closed* row `{Iterate}`, so it is
  wrongly treated as monomorphic. **"Closed" (no row variable) was conflated
  with "needs no handler evidence"** — a remnant of the retired static-
  dispatch design. The fix: a call needs evidence iff its row contains a
  *handler-dispatched* op (i.e. non-pure, minus builtin direct-emit ops
  WASI/memory) — closed or open is irrelevant. This is the entry that makes
  `LSuspend` fire for the `iterate` chain so the rest of the set engages.
- **Blocker 1 is NOT gated on Blocker 2.** For `row_is_ground` to run,
  `monomorphic_at` already observed `ty_tag == 107` (`TFun`) at the
  `iterate_from` call — the call's type *resolved*. The evidence build does
  not wait on the `NFree` type-resolution gap. Independent arcs.

Build order, lands-together, seed then wheel: (1) `monomorphic_at` row-
evidence semantics; (2) `derive_ev_slots` returns the handler-record
evidence (install-scope: installed arm fn-idx; polymorphic-scope: forward
own ev-slot); (3) `LSuspend` threads it; (4) `LEvPerform` loads it +
fence-relative offset + arm runs against the handler record; (5)
`LStateSlotStore` offset unified to `8 + 4·i`. Per the project's own
`protocol_mrcr_jit_recall.md` (compact before a new handle; deep windows
blind the midsection), this coordinated multi-file WAT build is best opened
in a fresh window with this walkthrough + `protocol_reflexive_interiority.md`
as the durable design anchor.

### 4.7 The precise layout, empirically grounded (2026-06-07, build session)

Rebuilding the seed with `d1714f5` (fallback deleted) and running mentl2 on
`fn main(x)=x` moved the trap — exactly the §4 empirical fork — from the
`for_each`/`iterate_from` chain to the **parser's first graph perform**:

```
0: fresh_ph          ← TRAP at call_indirect (indirect call type mismatch)
1: parse_one_param
2: parse_fn_params
… → compile_stdin → _start
```

`fresh_ph` (src/parser.mn:19) is `perform graph_fresh_ty(Placeholder(span))`.
`graph_handler` is installed at the pipeline top; the perform fires deep in
the parser. **The entire parser is open over `Graph`** — so the canonical
case is not iterate-specific: it is *every* deep perform of an effect
handled far up the call stack. The fix is the one general evidence chain;
graph ops simply run first.

**What is already correct (do not rebuild):**

- The **arm fn body + its state layout.** `op_<hname>_<op>` reads config +
  `with`-fields as captures at `__state[8 + 4·slot]`, pre-allocated in
  (config ++ state) source order (`walk_handle.wat` `pre_allocate_*_captures`).
  This is *exactly* the handler record's `8 + 4·i` layout. The arm only needs
  to receive the **handler's** record as `__state`.
- **`emit_lsuspend`** (`emit_call.wat:633`) already copies the callee
  closure header + captures into a transient record and writes the `evs`
  list into the ev region at `8 + 4·nc + 4·j`, then dispatches with that
  record as `__state`. It needs `derive_ev_slots` to *produce* the evs.

**The unified record layout (precise):**

```
handler state record  (built by emit_lhandlewith):
  offset 0:                   fn_ptr        (handler identity; 0 / unused for state dispatch)
  offset 4:                   nstate        (FENCE — count of state slots = len(state_inits))
  offset 8 + 4·i:             state slot i  (config params, then `with` fields, source order)
  offset 8 + 4·nstate + 4·k:  arm_fn_idx k  (per handled effect's EffectDeclKind op order)
```

The arm region is REQUIRED: the arm body's capture reads pin state to
`8 + 4·i`, so arm fn-idxs cannot live in the header — they sit after the
state fence. Per-op closures (one closure per arm) were rejected: they would
fork the handler's *mutable* state (`buf`/`count`) across ops, breaking
`resume() with buf = …`. ONE shared record, arm fns indexed off the fence.

**Evidence is per-EFFECT, carrying the record pointer (not per-op arm-idx):**
a fn open over effect `E` receives one ev-slot holding `E`'s handler-record
pointer. `derive_ev_slots(callee)` walks the callee's open-row effects; per
handler-dispatched effect:
- **lexical handler in lower-stack** → emit the handler record ptr
  (`(global.get $<hname>_state_g)`, or install-local — Tier-1 install scope);
- **else (E is in the *current* fn's own open row)** → forward the current
  fn's ev-slot for `E` (`(local.get $__state)(i32.load offset=8+4·body_cc+4·ev_index)`).

`LEvPerform(op)` then: load record ptr from own ev-slot at
`8 + 4·body_cc + 4·ev_index`; read `nstate = record[4]`; arm_fn =
`record[8 + 4·nstate + 4·op_slot]` (`op_slot` from `compute_ev_slot_for_op`,
the EffectDeclKind position); `call_indirect (arm_fn)` with **the record** as
`__state` + args. The arm-offset read is fence-relative — an interior read
of the record, not a static body-captures guess (reflexive interiority).

**Scope decision (single-open-effect; multi-effect is a named peer).** Every
fn in the iterate chain AND the parser/graph chain is open over exactly ONE
handler-dispatched effect, so `ev_index = 0`. Fns simultaneously open over
≥2 distinct handler-dispatched effects need an `ev_index`-per-effect map
threaded from row order into both `derive_ev_slots` and `LEvPerform` — a
structurally-orthogonal mechanism (the row→ev-index assignment), named
**`Hβ.lower.multi-effect-ev-index-map`**. Single-effect closes the L1 gate;
multi-effect is its positive-form peer with the structural reason articulated
(per the pre-action question's orthogonality clause, not drift 9).

Tier-1 (perform lexically inside the handler's scope) keeps its static arm
bind but takes its state from `$lower_resolve_handler_state_for_op` (reads
the handler stack's state-local), NOT the deleted default-per-op map.

### 4.8 DECISIVE empirical finding — activation is gated on effect-row inference (Blocker 2)

The full evidence chain is implemented (lexpr `LEvSlotRef`; `derive_ev_slots`
as the canonical gate; arm-region + `nstate` fence in `emit_lhandlewith`;
record-deref + fence-relative arm in `emit_levperform`; by-ename handler-state
resolver; op-slot-indexed arm-name ledger; `|>` forward routed through the
gate). The seed assembles and **mentl2 (seed's wheel-compile) is a valid
924 KB module** — the machinery is correct WAT.

But running mentl2 on `fn main(x)=x` still traps — now `out of bounds table
access` at `fresh_ph`'s `perform graph_fresh_ty` (the trap MOVED from "indirect
call type mismatch", the §4 empirical fork). The decisive measurements:

- **0** `LSuspend` transient-record builds anywhere in the 66 K-line m2.wat
  (`grep -c 'local.set $alloc_size'` = 0). **No call threads evidence.**
- The seed reports **~5015 type-inference diagnostics** compiling the wheel
  (`E_Mismatch`, `(), found {...}`, `Ty, found TokenKind`, …).

These two facts are one fact. `derive_ev_slots` reads `lookup_ty(callee) →
TFun.row` to decide evidence. With the wheel's effect rows unresolved
(~5015 errors; the seed's HM/effect inference is incomplete on full wheel
source), `lookup_ty` returns non-`TFun`/error types, so `derive_ev_slots`
returns `[]` for every callee → every call is `LCall` → the deep graph perform
reads an unthreaded ev-slot → OOB. The perform side is correct (`LEvPerform`,
op-name-driven, type-free); the **caller side cannot know a callee performs an
effect without effect-row inference.** There is no type-free shortcut: knowing
"`fresh_ph` transitively performs `Graph`" IS effect inference.

**This falsifies §4.6's "Blocker 1 is NOT gated on Blocker 2" claim.** That
held for one specific call's resolved type, not the chain. The honest,
general statement: **perform-evidence-dispatch is the correct and complete
ultimate form, and its *activation* is gated on effect-row inference
(Blocker 2).** Once the seed's inference resolves the wheel's rows,
`derive_ev_slots` sees the effects, `LSuspend` threads the records, and the
chain closes — for BOTH the singleton (graph) and multi-handler (iterate)
cases uniformly. No default-handler global is reintroduced: the singleton
case worked before only because the deleted op→handler map guessed a global,
which the multi-handler case structurally cannot use ([[protocol_no_silent_fallback]]).
The OOB trap is the *honest* "evidence not yet available" state — the complete
machinery waiting on its one input.

**Named gate (the activation dependency, positive form):**
**`Hβ.first-light.effect-row-inference-on-wheel`** — make the seed's
inference resolve the wheel's effect rows (drive the ~5015 diagnostics toward
0). It is structurally orthogonal to dispatch (HM + effect-row solving, a
different subsystem), so it is a peer gate, not drift-9 deferral. L1 closure
is `effect-row-inference-on-wheel` ∧ `perform-evidence-dispatch` (this, done).

### 4.9 Root sharpened: function rows are NRowFree — `perform` effects aren't propagated

A minimal effect program (`effect E { ping(x)->Int }`, `fn deep(x)=perform
ping(x)`, `fn mid(x)=deep(x)`, `handler h{...}`, `fn main(y)={mid(y)}~>h`)
compiles with **NFre=0** (value types fully resolved!) yet STILL threads no
evidence (0 `LSuspend`). Probing `derive_ev_slots` revealed the precise root:

1. A `TFun`'s row field is a **row-var handle** (e.g. 29/32), not a resolved
   `EffRow` — it must be chased through the graph like a type handle. Fixed by
   **`$lookup_row_for`** (`lookup.wat`; mirrors `$lookup_ty`, lands the
   `Hβ.lower.lookup-row` follow-up), now used by `derive_ev_slots`.
2. But the chase resolves to **Pure**: handle 29/32 → `NRowFree` (an *unbound*
   row variable). `deep` performs `ping` yet its inferred function row is a
   free variable — **the seed's inference never adds `perform op`'s effect to
   the enclosing function's row** (nor propagates a callee's row to its
   caller).

So the real gate is sharper than "~5015 type errors / NFre": value-type
resolution (NFre) is **not** the blocker (the minimal case has none). The
blocker is **effect-row inference proper** — `perform`/call effect propagation
and row-variable binding. Once a fn that performs `E` carries row `{E}` (or an
open row over `E`), `lookup_row_for` resolves it, `derive_ev_slots` sees the
effect, and the (already-correct) evidence machinery threads it.

**Refined gate:** `Hβ.infer.perform-effect-row-propagation` — at a `perform
op`, unify the enclosing fn's row to include `op`'s effect; at a call, unify
the caller's row with the callee's. This is the precise, minimal-reproducible
root (the `deep`/`mid` micro-test is its regression fixture), and the true
activation input for perform-evidence-dispatch. (`lookup_row_for` + the
row-chase in `derive_ev_slots` are committed and correct; they are dormant
only because rows are unbound upstream.)

**Exact source localization (the fix is 2–3 stubs + a row-scope stack):**

- `bootstrap/src/infer/walk_expr.wat:393` `$walk_expr_inf_add_row` is a
  **no-op** (`(drop (local.get $row))`). The perform arm (`:1266`) and call
  arms (`:742`, `:1580`) already CALL it with the op/callee row — the row is
  just discarded.
- `:399` `$walk_expr_inf_enter_fn` is likewise a no-op (should push a fresh
  accumulating row scope per fn).
- Missing: the exit/bind step — on FnStmt exit, `graph_bind` the fn's row
  handle (`ty_tfun_row(fn_ty)`, minted NRowFree at `walk_stmt.wat:580`) to the
  accumulated row, so it becomes `NRowBound[union]` that `lookup_row_for`
  resolves.

Wheel canonical: `src/infer.mn:36-50` (`inf_enter_fn` row-scope push) + `:843`
(`inf_add_row` composes callee row into the caller's accumulating row). The
implementation: an infer-state row-scope STACK; `enter_fn` pushes the fn's row
handle; `add_row` `row_union`s each performed/called effect into the top; an
`exit_fn` binds the handle to the accumulation. `row_union` already exists
(`runtime/row.wat:354`).

### 4.10 CLOSED (2026-06-08, commit `b84caf1`) — and the value-type gate isolated

The effect-row gate is **closed**. Five coordinated fixes realized the wheel's
`InferCtx` (src/infer.mn:36-118) in the seed:

1. **The fundamental binding** (`walk_stmt.wat $infer_register_effect_ops`): an
   op's row IS `row_make_closed([eff_name])` — bound to its effect in its type,
   definitionally, at declaration. Was a fresh unbound row var (severed op from
   effect → effect inference dead). THE root. (`[[protocol_effect_op_binding_definitional]]`)
2. **Row-scope frame stack** (`walk_expr.wat`): the dormant `$infer_fn_stack`
   realized as `{accumulated_row, span, row_handle}` frames; `inf_add_row`
   unions (guarded Pure/Closed/Open — Neg/Sub/Inter is the named peer
   `Hβ.infer.row-normalize-full`); `inf_exit_fn` binds `row_handle` →
   `NRowBound[union]`.
3. **FnStmt wiring** (`walk_stmt.wat`): body walk wrapped with `inf_enter_fn`/
   `inf_exit_fn`; bind before `generalize`.
4. **Row unification** (`unify.wat $unify_row` + `$is_unbound_row_handle`): a
   callee's concrete row flows into the caller's fresh row var; the TFun arm
   no longer preserves the row verbatim.
5. **`$lookup_row_for`** (`lookup.wat`): rows are graph handles, chased like types.

**Verified end-to-end:** `min_eff` and `fp.mn` micro-tests (`effect E`; a fn
performs `E`; a caller calls it; a handler installs) — **NFre=0, 2 `LSuspend`
each, compile AND RUN CLEAN**. The 29k-line wheel threads **38 `LSuspend`**
(was 0). The row binds even when value types carry free TVars — row resolution
is independent of monotype resolution.

**The remaining L1 gate is now cleanly isolated and orthogonal:**
**`Hβ.infer.value-type-nfre-on-wheel`** — ~3901 `E_UnresolvedType` (free *type*
vars, not row vars) from the wheel's RICH types (refinements like `ValidSpan`,
ADTs, generics `<A,B>`), NOT from basic fn/effect/typed-param/block/let
patterns (those resolve — proven by `fp.mn`). `derive_ev_slots` bails at its
`ty_tag != TFun` check when a callee's type is NFre, so the parser/graph chain
(`fresh_ph` over `GraphWrite`) doesn't thread *until value types resolve*. The
evidence machinery is correct and waiting on this one input; closing it is HM
completeness on rich types — a different subsystem from row inference.

L1 closure = `value-type-nfre-on-wheel` ∧ `perform-effect-row-propagation`
(this, CLOSED) ∧ `perform-evidence-dispatch` (CLOSED). Two of three gates shut.

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

---

## 10. Corrected empirical state (2026-06-08) — two adjacent gates closed; the real trap isolated

Two corrections this session, both from *measuring the actual emitter*
instead of trusting a diagnostic's name:

**(a) The "value-type NFre" gate was mostly a misnamed diagnostic.** The
3854 `E_UnresolvedType: lower-time NFree` messages were NOT free type
variables. 3770 came from `$lower_expr`'s unknown-tag catch-all
(walk_call.wat), which *reused the NFree message string*, firing on
**nullary-sentinel Expr variants** (`LitUnit=84` and kin): `$lower_expr`
read the tag via a raw `(i32.load offset=0)` on the variant, dereferencing
a sentinel in `[0,4096)` → tag 0 → catch-all → `LConst(0)` corruption. Fix:
read via `$tag_of` exactly as infer's `$walk_expr_expr_tag` does
(commit `45d7439`, `Hβ.lower.expr-tag-sentinel`). Result: wheel
`E_UnresolvedType` 3854 → ~80.

The genuine type-NFre minority (`$lookup_ty`'s NFree arm) was resolved
toward the gradient in the same commit (`Hβ.lower.nfre-gradient`): a free
type variable at a value position is **legal polymorphism**, returned as
`TVar` and flowed as uniform i32 — not an `E_UnresolvedType`. spec 05
invariant 2 revised; see `ULTIMATE_MEDIUM.md` §9.3.

**(b) The wheel input must be `find src -name '*.mn'`, not `cat src/*.mn`.**
`src/*.mn` silently omits `src/backends/wasm.mn` (a subdirectory), so
`emit_module` showed up `UNRESOLVED` and mentl2 trapped in `compile_stdin`'s
handler chain — an **artifact of the malformed input**, not a real gap.
The canonical assembly is `bootstrap/first-light.sh:140-142`.

**The real first-light trap, precisely isolated.** With the correct wheel
(29,121 lines, backends included) + the two fixes, mentl2 now validates
(4.6 MB WAT) and *executes its full handler-chain install and parser
entry* — `_start → dispatch_invocation → compile_stdin → parse_program →
parse_stmt_list → parse_fn → parse_fn_params → parse_one_param → fresh_ph`
— before trapping at **`fresh_ph`'s first `perform graph_fresh_ty`** with
`undefined element: out of bounds table access`. The emitted dispatch is
the fence-relative arm-fn-idx read:

```
fn_idx = load[ (__state[8] + 8) + __state[8][4]*4 ]   ;; call_indirect (type $ft2)
```

`__state[8]` is the ev-slot meant to hold the live GraphWrite handler
record (forwarded into `fresh_ph` as evidence). At runtime it is **not a
valid handler record** → the fence-relative load yields a garbage fn-idx →
out-of-bounds `call_indirect`. This is the genuine perform-evidence-dispatch
gate (the same one named in the §0 cursor, now reached rather than masked).

**Next handle — `Hβ.first-light.fresh-ph-ev-slot-threading`.** The fault is
one of: (i) `parse_one_param`/`fresh_ph`'s caller does not forward the
GraphWrite handler record into `fresh_ph`'s `__state[8]` ev-slot
(`derive_ev_slots` `LEvSlotRef(0)` forward vs install-local mismatch);
(ii) the fence-relative index base (`+8`, `[4]*4`) disagrees with the
`one-record-four-roles` layout `protocol_handler_is_state_is_closure_is_evidence.md`
actually emits; or (iii) the handler record's arm-region is alloc'd but its
fn-idx slots are never initialized (the `protocol_call_indirect_paradox`
state-init-writes-missing class). The micro-fixture `/tmp/t_freshph.mn`
(refinement-param effect op + `~> h`) compiles AND runs clean — so the
single-handler install path is correct; the gate is specific to the
deep parser call-chain forwarding evidence through many frames. Resolve
with a fresh window (highest-stakes runtime-layout subsystem; MRCR
discipline favors cached-prefix + the evidence walkthrough loaded).
