# Native-continuation multi-shot — the proven substrate

These crucibles prove, end to end, how Mentl lowers a **multi-shot** handler
(`Hβ.continuations.wasmfx-lowering-tier`). The cardinality inference already
decides *that* a continuation forks (resume grade → MultiShot, landed in
`infer.mn`); these prove *how* the fork runs.

## What's proven

- `twice-identity.wat` — `resume(1) + resume(2)` over `body() = pick()` → **3**.
- `twice-nonidentity.wat` — over `body() = pick() + 5` → **13** (the `+5`
  continuation after the perform runs correctly — real delimited capture, not
  a "return the input" stub).
- `reexec-model.mn` — the same shape expressed in Mentl source (a driver that
  re-runs the body thunk under a one-shot replay handler per resume), runs to
  **30** through boot. Proves the model needs no exotic feature — a multi-shot
  handler is a driver over re-runs.

Run: `wasm-tools parse X.wat -o X.wasm && wasmtime run -W stack-switching=y -W function-references=y -W exceptions=y --invoke run X.wasm`

## The mechanism

WASM native typed continuations are **linear** (one-shot): resuming a `cont`
twice panics the engine (verified). Multi-shot is therefore **re-execution** —
each `resume(v)` is a *fresh* `cont.new(body)`:

```
rerun(v):
  cont.new(body); resume it (on $pick → $caught)   ;; run body to the perform
  $caught: (ref $rct) k on the stack               ;; the delimited continuation
  resume k with v                                  ;; body finishes with pick()=v → k(v)
```

`suspend $pick` unwinds the perform to the driver level, so the arm runs
*outside* the body's stack — no re-entrancy (the trap the pure-Mentl
outer-install driver hit). No-perform bodies return normally from the first
`resume`. Non-identity continuations are captured natively.

## ⚠ Native conts are BLOCKED under WASI `_start` (wasmtime 43, verified 2026-07-11)

A continuation runs correctly only when the module is entered via
`wasmtime --invoke <fn>` (that is how the crucibles above pass). Entered via the
WASI command entry `_start` — which every real Mentl program uses — even a
*single* `cont.new`+`resume` panics wasmtime internally:

```
assertion failed: core::ptr::eq(head, self)   (traphandlers.rs)
```

(the SAME assertion double-resume trips). wasmtime's command execution runs the
module on its own fiber, and a user continuation created inside it violates the
continuation-stack invariant. No `-W`/`-O`/`-C` flag avoids it. So native typed
continuations are **not viable for `_start` programs on wasmtime 43** — the
`--invoke` proofs are real, but the substrate can't carry them to a running
`mentl` binary without an upstream wasmtime fix (which would be an `!Outside`
dependency).

**Consequence (superseded 2026-07-11 by the reified k — PLAN §7 THE PIVOT):**
the shipping multi-shot is **continuation-reification codegen (k1)**, landed in
the wheel: a MultiShot perform YIELDS — the performing frame's
remainder-after-the-perform reifies as the continuation record (the unified
heap record, closure-identical head), the install's driver binds k to the arm,
and `resume(v)` CALLS the record N times. No stack capture, no engine feature,
works under `_start`, resumes AT the perform (never re-runs the prefix — the
re-execution model below survives as the degenerate stateless-replay fork the
oracle uses, and reexec-model.mn stays its crucible). Gates through m2:
mn-multishot → 30, twice-handler-nonidentity → 36 (the delimited `+3` per
fork), twice-capture → 40 (k captures through the record). A driverless yield
traps LOUD at the `_start` backstop; a mid-remainder re-yield traps at the
k-call boundary (the k2 composition floor). Native conts return as the O(1)
control swap if/when wasmtime carries them under `_start`.

## The emit target (native-cont form — kept for when the substrate is ready)

Lower a multi-shot handler `{ body } ~> h` to this driver:

1. Each effect op of a multi-shot effect → a `(tag $op (result R))`; `perform`
   → `suspend $op`. (OneShot ops stay the evidence-passing direct-call tier —
   this tier fires only when the cardinality is MultiShot.)
2. The handler arm lowers as the driver: each `resume(v)` → the `rerun` pattern
   above (`cont.new(body-thunk)` + resume-to-suspend + resume-with-v).
3. The install captures `body` as the thunk `cont.new` re-creates per fork.
4. Assembler: native `cont` types need **wasm-tools** (WABT can't assemble them,
   even `--enable-all`); the wheel itself has no multi-shot handler, so its
   modules stay `wat2wasm` — only multi-shot programs route through wasm-tools.
5. Run flags: `-W stack-switching -W function-references -W exceptions`.

## The unification (why this is the fork primitive)

Each `rerun` is an independent fork of the frozen computation. Sequential today
(`Seq`); a `~> Schedule` handler picks `Thread`/`Async`/`Simd` — the same
`PFanout` schedule `<|`/`><` read (STEP 4). Re-execution forks are stateless
(no captured stack), so they are trivially parallel and trivially durable —
SPACE and TIME are one arm (`PLAN §5.U`). Cardinality decides the fork;
ownership decides whether forks parallelize.
