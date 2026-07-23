#!/usr/bin/env python3
# oracle.py — the cross-validation reference for the dsp-crucible.
#
# A real DSP chain: synthesize a signal (two sinusoids + a deterministic
# pseudo-noise tone), run it through a single-pole IIR lowpass, and read three
# discrete verdict facts off the result — the argmax bin of an 8-bin DFT
# magnitude over the filtered output, a zero-crossing count of the filtered
# output, and a clipped-sample count of the raw signal. The .mn computes the
# SAME facts with the SAME formulas and must agree.
#
#   python3 tests/frontier/dsp-crucible/oracle.py
#
# The signal uses sines, and Mentl's sin is a Taylor series (lib/runtime/
# math.mn), NOT libm's — so this oracle PORTS that exact series (msin/mcos
# below) rather than calling math.sin. With the identical transcendental the
# two implementations agree to f64 epsilon, so even the boundary-sensitive
# zero-crossing and clip counts match exactly. The argmax is robust regardless
# (the low component dominates the filtered spectrum by ~50x).
#
# Formulas identical to dsp-demo.mn:
#   t        = n / N
#   sig[n]   = 0.7*sin(2pi*8*t) + 1.0*sin(2pi*64*t) + 0.05*sin(2pi*101*t)
#   filt[n]  = a*sig[n] + (1-a)*filt[n-1] ,  a = 0.15 ,  filt[-1] = 0
#   argmax   = argmax over bins [4,8,12,16,24,32,48,64] of |DFT(filt)|
#   zeros    = # of consecutive filt samples with opposite sign
#   clips    = # of raw sig samples with |sig| > 1.0
#
# The high tone (64 cyc) is LOUDER than the low (8 cyc) in the raw signal, so
# the DFT argmax of the RAW signal would be the high bin. The lowpass attenuates
# the high ~5x and passes the low, moving the argmax to the low bin (index 1) —
# so the argmax fact is LOAD-BEARING on the filter working (a near-passthrough
# a=0.9 leaves the high loudest and the argmax on the high bin).

N = 256
A = 0.15
BINS = [4, 8, 12, 16, 24, 32, 48, 64]
CLIP = 1.0

TWO_PI = 6.283185307179586
PI = 3.141592653589793


def ffloor(f):
    # matches math.mn float_floor: truncate toward zero, then step down if below.
    t = float(int(f))
    return t - 1.0 if f < t else t


def msin(x):
    # matches math.mn sin: range-reduce to [-pi, pi), then 8-term alternating series.
    r0 = x - TWO_PI * ffloor(x / TWO_PI)
    r = r0 - TWO_PI if r0 >= PI else r0
    r2 = r * r
    term = r
    acc = r
    n = 1
    while n <= 8:
        d = float(2 * n * (2 * n + 1))
        term = 0.0 - (term * r2) / d
        acc += term
        n += 1
    return acc


def mcos(x):
    return msin(x + PI / 2.0)


def signal():
    out = []
    for n in range(N):
        t = float(n) / float(N)
        lo = 0.7 * msin(TWO_PI * 8.0 * t)
        hi = 1.0 * msin(TWO_PI * 64.0 * t)
        noise = 0.05 * msin(TWO_PI * 101.0 * t)
        out.append(lo + hi + noise)
    return out


def lowpass(sig):
    out = []
    prev = 0.0
    for x in sig:
        y = A * x + (1.0 - A) * prev
        out.append(y)
        prev = y
    return out


def dft_mag(filt, freq):
    re = 0.0
    im = 0.0
    for n in range(N):
        ang = TWO_PI * float(freq) * float(n) / float(N)
        re += filt[n] * mcos(ang)
        im += filt[n] * msin(ang)
    return (re * re + im * im) ** 0.5


def argmax_bin(filt):
    best_k = 0
    best_v = -1.0
    for k, f in enumerate(BINS):
        v = dft_mag(filt, f)
        if v > best_v:
            best_v = v
            best_k = k
    return best_k


def zero_crossings(filt):
    c = 0
    for n in range(1, N):
        if (filt[n - 1] < 0.0) != (filt[n] < 0.0):
            c += 1
    return c


def clip_count(sig):
    c = 0
    for x in sig:
        ax = 0.0 - x if x < 0.0 else x
        if ax > CLIP:
            c += 1
    return c


def main():
    sig = signal()
    filt = lowpass(sig)
    ab = argmax_bin(filt)
    zc = zero_crossings(filt)
    cc = clip_count(sig)
    # The composition the .mn uses: 40*(argmax bin correct) + 1*(zeros correct)
    # + 1*(clips correct). This reference DEFINES the correct facts, so all three
    # hold and the code is 42. A wrong fact in the .mn drops it below 42.
    exit_code = 42
    print(f"argmax_bin={ab} (freq={BINS[ab]}) zero_crossings={zc} clip_count={cc}")
    print(f"EXPECTED_ARGMAX_BIN={ab}")
    print(f"EXPECTED_ZERO_CROSSINGS={zc}")
    print(f"EXPECTED_CLIP_COUNT={cc}")
    print(f"EXPECTED_EXIT={exit_code}")


main()
