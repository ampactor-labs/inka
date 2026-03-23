# DSP Framework Pain Points

Pain points discovered during DSP framework implementation that motivate future work.
Each section describes a gap, the current workaround, and the planned resolution.

## 1. Effect Subtraction (`E - F`) — Syntax Implemented, Generic Form Deferred

**RESOLVED (Phase 8B):** Effect subtraction syntax `E - F` is now available in type annotations.

```lux
// For concrete effects, subtraction desugars to negation:
fn safe(x: Float) -> Float with DSP - Network - Alloc { ... }
// = fn safe(x: Float) -> Float with DSP, !Network, !Alloc { ... }
```

Reads naturally as "remove Network and Alloc from DSP."

**Still deferred:** Generic subtraction requires effect row variables in the surface syntax.

```lux
fn sandbox<E>(body: () -> T with E) -> T with E - Network - Alloc {
  // Requires: fn params with effect row variables
  // Planned for Phase 9 or 10 (after ownership clarifies row semantics)
}
```

Until row variables are exposed, generic sandbox patterns require explicit effect listing
at each call site. The concrete syntax is available now and enables readable capability
removal in DSP frameworks and security-critical code.

**Examples:** `examples/dsp_sandbox.lux`, `examples/effect_algebra.lux` demonstrate
both negation (`!E`) and subtraction (`E - F`) for comparison.

**Motivates:** Phase 9+ (row variable polymorphism for generic capability removal)

---

## 2. Effect Intersection (`E & F`) — Can't Express Capability Negotiation

**What we want:**

```lux
fn compose<E, F>(a: Plugin with E, b: Plugin with F) -> Plugin with E & F {
  // result only has capabilities both plugins share
}
```

Use case: hardware declares supported capabilities, a plugin declares needed ones,
and the actual runtime capability set is the intersection — the subset both sides agree
on. This pattern appears naturally in plugin systems, capability-based security, and
audio graph construction where you need to know what a composed pipeline can actually do.

**What we do instead:**

Manual capability checking at composition time: inspect effect sets at runtime, fail
if a required effect is absent, or silently drop unsupported operations. Neither option
is type-safe. The compiler cannot verify that composition is valid without the
intersection operator.

**Motivates:** Phase C (effect intersection in the algebra)

---

## 3. No Handler Parameters — Named Handlers Can't Take Constructor Arguments

**What we want:**

```lux
handler lowpass(alpha: Float) with state = 0.0 {
  process(x) => {
    let y = alpha * x + (1.0 - alpha) * state
    resume(y) with state = y
  }
}

// Instantiate with different cutoff frequencies
handle { signal } with lowpass(0.1)
handle { signal } with lowpass(0.3)
```

Named handlers should support constructor parameters so they can be instantiated with
different configurations while remaining composable and inheritable.

**What we do instead:**

Functions that wrap inline `handle` blocks, or named handlers with hardcoded values.
The function approach works but loses composability: you cannot inherit from a
function-wrapped handler, and the `handler` keyword's composition machinery
(`: base`, inline overrides) becomes unavailable.

**Motivates:** A future handler enhancement phase (post-8B)

---

## 4. ~~No Trig Builtins~~ — **Resolved**

Math builtins now include `sin`, `cos`, `tanh`, `atan2`, `sqrt`, `pow`,
`log`, `exp`, and `pi`. Precise biquad filter coefficient calculation and
`atan`-based soft clipping are now possible.
