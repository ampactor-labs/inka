# DSP Framework Pain Points

Pain points discovered during Phase 8A-DSP implementation that motivate future phases.
Each section describes what the language currently lacks, what we do instead, and what
phase addresses the gap.

## 1. Effect Subtraction (`E - F`) — Can't Express Capability Removal

**What we want:**

```lux
fn sandbox<E>(body: () -> T with E) -> T with E - Network - Alloc {
  handle { body() } {
    network_request(_) => resume(Err("network blocked")),
    alloc(_) => resume(Err("allocation blocked")),
  }
}
```

The type signature should express that this handler *removes* capabilities from the
caller's effect set. A sandboxed plugin that started with `E` should exit the handler
with `E - Network - Alloc` — the compiler should verify that Network and Alloc are
genuinely handled and cannot escape.

**What we do instead:**

Nested handlers that intercept and discard operations. The signature lies: the outer
function appears to accept and propagate `E` unchanged. Callers cannot reason about
capability removal from types alone — they must read the implementation.

**Motivates:** Phase B (effect subtraction in the algebra)

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

## 4. No Trig Builtins — Missing `sin`, `cos`, `atan`, `tanh`

**What we want:**

```lux
fn soft_clip(x: Float) -> Float with Pure = (2.0 / pi) * atan(x)

// Precise biquad filter coefficients
fn lowpass_coeffs(freq: Float, sample_rate: Float) -> (Float, Float, Float) with Pure {
  let omega = 2.0 * pi * freq / sample_rate
  let cos_w = cos(omega)
  let sin_w = sin(omega)
  // ... standard biquad formula
}
```

**What we do instead:**

Rational approximations: `x / (1.0 + abs(x))` instead of `atan`-based soft clipping.
These are cheaper but less accurate and harder to reason about. More critically, precise
filter coefficient calculation (biquad, Butterworth, Chebyshev) requires `sin`/`cos`
and simply cannot be implemented without them. The DSP framework is limited to
first-order filters and approximations until trig is available.

**Motivates:** Expanding math builtins (prerequisite for Phase 8B DSP work)
