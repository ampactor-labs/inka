#!/usr/bin/env python3
# oracle.py — the cross-validation reference for the adaptive-crucible.
#
# A 2-tap LMS adaptive filter run as noise cancellation / system identification:
# an unknown channel with response h = [2, 1] shapes a reference noise source
# into the primary; the adaptive filter learns h online WHILE filtering,
# subtracting its estimate so the residual (the error signal) collapses. The
# 2-tap FIR reads the current reference and its one-sample delay — the "delayed
# copy of the input" the LMS update correlates against.
#
#   python3 tests/frontier/adaptive-crucible/oracle.py
# prints the converged taps, the residual-power drop, and the exit code the .mn
# must produce (42 iff the taps round to [2, 1] and the residual power drops by
# at least 1e6).
#
# The reference is an integer LCG mapped to [-1, 1) — deterministic, well
# excited, and CARRYING NO TRANSCENDENTAL, so Mentl and this oracle agree to f64
# epsilon and both the rounded taps and the power-drop threshold are robust.
# Formulas identical to adaptive-demo.mn:
#   s_{i+1} = (75*s_i + 74) % 65537 ,  s_0 = 1
#   ref_i   = s_{i+1}/32768 - 1
#   d_i     = 2*ref_i + 1*ref_{i-1}        (ref_{-1} = 0)   the unknown channel
#   y_i     = w0*ref_i + w1*ref_{i-1}      the adaptive estimate
#   e_i     = d_i - y_i                    the residual (cleaned output)
#   w0 += mu*e_i*ref_i ; w1 += mu*e_i*ref_{i-1}
# init power = mean e^2 over the first K samples (w still zero, so e = d);
# final power = mean e^2 over the last K samples.

N = 2000
K = 100
MU = 0.2
H0, H1 = 2.0, 1.0


def gen_ref():
    refs = []
    s = 1
    for _ in range(N):
        s = (75 * s + 74) % 65537
        refs.append(s / 32768.0 - 1.0)
    return refs


def ref_at(refs, i):
    return 0.0 if i < 0 else refs[i]


def run(refs):
    w0, w1 = 0.0, 0.0
    init_pow = 0.0
    final_pow = 0.0
    for i in range(N):
        x0 = ref_at(refs, i)
        x1 = ref_at(refs, i - 1)
        d = H0 * x0 + H1 * x1
        y = w0 * x0 + w1 * x1
        e = d - y
        if i < K:
            init_pow += e * e
        if i >= N - K:
            final_pow += e * e
        w0 += MU * e * x0
        w1 += MU * e * x1
    return w0, w1, init_pow, final_pow


def main():
    refs = gen_ref()
    w0, w1, init_pow, final_pow = run(refs)
    rw0 = int(w0 + 0.5)
    rw1 = int(w1 + 0.5)
    drop = final_pow * 1.0e6 < init_pow
    # bounded teaching codes (< 126, WASI's exit ceiling): 10 tap0, 11 tap1, 12 drop
    if rw0 != 2:
        exit_code = 10
    elif rw1 != 1:
        exit_code = 11
    elif drop:
        exit_code = 42
    else:
        exit_code = 12
    print(f"w0={w0:.9f} w1={w1:.9f} round=({rw0},{rw1})")
    print(f"init_pow={init_pow:.6e} final_pow={final_pow:.6e} drop_1e6={drop}")
    print(f"EXPECTED_ROUND_W0={rw0}")
    print(f"EXPECTED_ROUND_W1={rw1}")
    print(f"EXPECTED_EXIT={exit_code}")


main()
