#!/usr/bin/env python3
# oracle.py — the numpy cross-validation oracle for the float-statistics gate.
#
#   generate -> write data.txt (one float per line), a deterministic sensor-like
#               sample with a distinct minimum, maximum, and mean.
#   oracle   -> read data.txt and print three DISCRETE facts both implementations
#               must agree on EXACTLY (no transcendental, so no ULP tolerance):
#                 argmin index, argmax index, count of samples above the mean.
#
# The gate runs Mentl over the SAME file and asserts Mentl's three facts equal
# these. Native [Float] reductions (fold-sum for the mean, comparison-reduction
# for argmin/argmax, a mean-threshold count) exercised end to end on real
# on-disk data — the representation-stress the m3==m4 fixpoint cannot be.
import sys
import numpy as np

N = 400

def gen():
    rng = np.random.default_rng(20260722)
    # sensor-like: a baseline with noise, one deep dip and one sharp spike
    xs = 50.0 + 8.0*rng.standard_normal(N)
    xs[137] = xs.min() - 12.0   # a distinct global minimum at a known index
    xs[298] = xs.max() + 15.0   # a distinct global maximum at a known index
    return xs

def facts(xs):
    mean = float(np.mean(xs))
    return int(np.argmin(xs)), int(np.argmax(xs)), int(np.sum(xs > mean)), mean

def main():
    cmd = sys.argv[1] if len(sys.argv) > 1 else "oracle"
    path = sys.argv[2] if len(sys.argv) > 2 else "data.txt"
    if cmd == "generate":
        xs = gen()
        with open(path, "w") as fh:
            for v in xs:
                fh.write(f"{v:.6f}\n")
        print(f"wrote {len(xs)} samples to {path}")
        return
    with open(path) as fh:
        xs = np.array([float(l) for l in fh if l.strip()])
    amin, amax, above, mean = facts(xs)
    print(f"n={len(xs)} argmin={amin} argmax={amax} above_mean={above} mean={mean:.4f}")
    print(f"EXPECTED_ARGMIN={amin}")
    print(f"EXPECTED_ARGMAX={amax}")
    print(f"EXPECTED_ABOVE={above}")

main()
