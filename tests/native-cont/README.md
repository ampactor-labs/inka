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

## The emit target (the remaining build)

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
