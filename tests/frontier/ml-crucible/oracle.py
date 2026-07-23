#!/usr/bin/env python3
# oracle.py — the cross-validation reference for the ml-crucible.
#
# Batch gradient descent for a 2-parameter linear regression y = w*x + b on 32
# inline-generated points with known ground truth (w=3, b=1) plus small
# deterministic residuals. The .mn runs the SAME descent with the SAME
# constants and must reach the SAME rounded coefficients. The data is
# integer-derived (no transcendental), so Mentl and this oracle agree to f64
# epsilon and the ROUNDED verdict is robust.
#
#   python3 tests/frontier/ml-crucible/oracle.py
# prints the converged (w, b), their rounding, and the final exit code the
# .mn must produce (42 iff round(w)==3 and round(b)==1).
#
# The formulas are IDENTICAL to ml-demo.mn:
#   x_i    = i - 15.5                       (centered → decoupled, well-conditioned)
#   resid  = ((i % 5) - 2) * 0.05           (deterministic, small, ~mean-zero)
#   y_i    = 3*x_i + 1 + resid
#   loss   = (1/N) Σ (w*x_i + b - y_i)^2
#   grads  = (2/N) Σ e_i*x_i , (2/N) Σ e_i
#   step   = w -= lr*gw ; b -= lr*gb        (lr = 0.008, iters = 3000, init 0)

N = 32
LR = 0.008
ITERS = 3000


def gen():
    xs = [float(i) - 15.5 for i in range(N)]
    ys = [3.0 * xs[i] + 1.0 + float((i % 5) - 2) * 0.05 for i in range(N)]
    return xs, ys


def descend(xs, ys):
    w, b = 0.0, 0.0
    for _ in range(ITERS):
        sw = 0.0
        se = 0.0
        for i in range(N):
            e = w * xs[i] + b - ys[i]
            sw += e * xs[i]
            se += e
        gw = 2.0 * sw / N
        gb = 2.0 * se / N
        w -= LR * gw
        b -= LR * gb
    return w, b


def main():
    xs, ys = gen()
    w, b = descend(xs, ys)
    rw = int(w + 0.5)
    rb = int(b + 0.5)
    # bounded teaching codes (< 126, WASI's exit ceiling): 10 slope, 11 intercept
    exit_code = 42 if (rw == 3 and rb == 1) else (10 if rw != 3 else 11)
    print(f"w={w:.9f} b={b:.9f} round_w={rw} round_b={rb}")
    print(f"EXPECTED_ROUND_W={rw}")
    print(f"EXPECTED_ROUND_B={rb}")
    print(f"EXPECTED_EXIT={exit_code}")


main()
