#!/usr/bin/env python3
# oracle.py — the cross-validation reference for the signal crucible.
#
# An INDEPENDENT implementation of lib/dsp/signal.mn's comodulogram, computed
# over the SAME on-disk recording the Mentl pipeline reads. Two independent
# implementations agreeing on real data is the representation-stress oracle the
# m3==m4 fixpoint is structurally blind to (a byte-identical wheel can still
# corrupt user [Float] data; only a second implementation over the same bytes
# catches it).
#
#   python3 tests/frontier/signal-crucible/oracle.py generate recording.txt
#   python3 tests/frontier/signal-crucible/oracle.py oracle   recording.txt
#
# The signal and the sin/cos ports live in gen.py (one home); the sqrt/atan2/exp
# ports and the analysis live here. Every transcendental is a faithful port of
# lib/runtime/math.mn's Taylor series (NOT libm), so the two implementations
# agree to f64 epsilon and the discrete verdicts are exact.
#
# THE ALGORITHM (matches lib/dsp/signal.mn's pac_comodulogram):
#   1. BANDPASS the signal to the analysis band [2, 70] Hz — a cascade of two
#      single-pole highpass + two single-pole lowpass sections (the `<~`
#      recurrence in Mentl) — which strips DC drift and out-of-band junk before
#      the phase-sensitive analysis.
#   2. COMODULOGRAM (cfc.mn's raw Canolty mean-vector-length over windowed-DFT
#      columns): for each hop-spaced Hann frame, the low-freq DFT bin's (re, im)
#      is a QUADRATURE PAIR whose atan2 is the phase; the high-freq bin's
#      magnitude is the amplitude envelope. MVL couples a low-phase column with a
#      high-amplitude column over the frames; the grid is the comodulogram.
#
# VERDICTS (cross-checked against the .mn's exit-42 encoding):
#   EXPECTED_FLAT            the argmax cell (li*4 + hi) = 2 for (low=4, high=50)
#   EXPECTED_STRONG_COUPLING 1 iff floor(peak/median) >= 20 (peak far above the
#                            noise-floor cell) — the discrete peak-vs-median fact
#   EXPECTED_RATIO_FLOOR     floor(peak/median), reported for the human record

import sys
import gen
from gen import msin, mcos, SR, N, TWO_PI, PI

WIN = 128
HOP = 32
BAND_LO = 2.0
BAND_HI = 70.0
LOW = [4, 6, 8, 10]
HIGH = [30, 40, 50, 60]
LN2 = 0.6931471805599453


def ffloor(f):
    t = float(int(f))
    return t - 1.0 if f < t else t


def fpow2(k):
    # lib/runtime/math.mn float_pow2.
    if k == 0:
        return 1.0
    if k > 0:
        return 2.0 * fpow2(k - 1)
    return 1.0 / fpow2(0 - k)


def mexp(x):
    # lib/runtime/math.mn exp: range-reduce x = k*ln2 + r, then 2^k * series(r).
    k = int(ffloor(x / LN2))
    r = x - float(k) * LN2
    term = 1.0
    acc = 1.0
    n = 1
    while n <= 13:
        term = (term * r) / float(n)
        acc += term
        n += 1
    return fpow2(k) * acc


def msqrt(x):
    if x <= 0.0:
        return 0.0
    m = x
    k = 0
    while m >= 4.0:
        m = m / 4.0
        k += 1
    while m < 1.0:
        m = m * 4.0
        k -= 1
    y = 1.0 + m / 4.0
    for _ in range(8):
        y = (y + m / y) / 2.0
    return fpow2(k) * y


def matan(x):
    if x < 0.0:
        return 0.0 - matan(0.0 - x)
    if x > 1.0:
        return PI / 2.0 - matan(1.0 / x)
    r = x / (1.0 + msqrt(1.0 + x * x))
    r2 = r * r
    term = r
    acc = r
    n = 1
    while n <= 12:
        term = 0.0 - term * r2
        odd = float(2 * n + 1)
        acc += term / odd
        n += 1
    return 2.0 * acc


def matan2(y, x):
    if x > 0.0:
        return matan(y / x)
    if x < 0.0:
        return matan(y / x) + PI if y >= 0.0 else matan(y / x) - PI
    if y > 0.0:
        return PI / 2.0
    if y < 0.0:
        return 0.0 - PI / 2.0
    return 0.0


def band_coeff(fc):
    return 1.0 - mexp(0.0 - TWO_PI * fc / float(SR))


def bandpass(xs, lo_hz, hi_hz):
    # cascade of 2 highpass(lo_hz) + 2 lowpass(hi_hz) single-pole sections; each
    # section's state resets per pass (the `<~` per-site state in Mentl).
    ah = band_coeff(lo_hz)
    al = band_coeff(hi_hz)
    lo1 = lo2 = lp1 = lp2 = 0.0
    out = []
    for x in xs:
        lo1 = ah * x + (1.0 - ah) * lo1
        hp1 = x - lo1
        lo2 = ah * hp1 + (1.0 - ah) * lo2
        hp2 = hp1 - lo2
        lp1 = al * hp2 + (1.0 - al) * lp1
        lp2 = al * lp1 + (1.0 - al) * lp2
        out.append(lp2)
    return out


def hann(n):
    return [0.5 - 0.5 * mcos(TWO_PI * float(j) / float(n - 1)) for j in range(n)]


HANN = hann(WIN)


def dft_bin(xs, start, freq):
    re = 0.0
    im = 0.0
    for j in range(WIN):
        ang = TWO_PI * float(freq) * float(j) / float(SR)
        wx = xs[start + j] * HANN[j]
        re += wx * mcos(ang)
        im -= wx * msin(ang)
    return re / WIN, im / WIN


def column(xs, freq, want_phase):
    nf = (len(xs) - WIN) // HOP + 1
    out = []
    for k in range(nf):
        re, im = dft_bin(xs, k * HOP, freq)
        out.append(matan2(im, re) if want_phase else msqrt(re * re + im * im))
    return out


def mvl(phases, amps):
    sc = 0.0
    ss = 0.0
    for k in range(len(phases)):
        sc += amps[k] * mcos(phases[k])
        ss += amps[k] * msin(phases[k])
    return msqrt(sc * sc + ss * ss) / float(len(phases))


def comodulogram(xs):
    band = bandpass(xs, BAND_LO, BAND_HI)
    low_cols = [column(band, f, True) for f in LOW]
    high_cols = [column(band, f, False) for f in HIGH]
    return [[mvl(low_cols[li], high_cols[hi]) for hi in range(len(HIGH))] for li in range(len(LOW))]


def sorted16(vals):
    v = list(vals)
    out = []
    while v:
        mi = 0
        for i in range(1, len(v)):
            if v[i] < v[mi]:
                mi = i
        out.append(v.pop(mi))
    return out


def read_recording(path):
    with open(path) as fh:
        return [float(line) for line in fh if line.strip()]


def run_oracle(path):
    xs = read_recording(path)
    m = comodulogram(xs)
    flat = [m[li][hi] for li in range(len(LOW)) for hi in range(len(HIGH))]
    amax = max(range(len(flat)), key=lambda k: flat[k])
    li, hi = amax // len(HIGH), amax % len(HIGH)
    peak = flat[amax]
    median = sorted16(flat)[len(flat) // 2]   # upper median: 9th smallest of 16
    ratio_floor = int(peak / median) if median > 0.0 else 999
    strong = 1 if ratio_floor >= 20 else 0
    print(f"argmax flat={amax} cell=(low={LOW[li]}Hz, high={HIGH[hi]}Hz) "
          f"peak={peak:.6f} median={median:.6f} ratio_floor={ratio_floor}")
    print(f"EXPECTED_FLAT={amax}")
    print(f"EXPECTED_STRONG_COUPLING={strong}")
    print(f"EXPECTED_RATIO_FLOOR={ratio_floor}")


def main():
    cmd = sys.argv[1] if len(sys.argv) > 1 else "oracle"
    path = sys.argv[2] if len(sys.argv) > 2 else "recording.txt"
    if cmd == "generate":
        count = gen.write_recording(path)
        print(f"wrote {count} samples to {path}")
    else:
        run_oracle(path)


if __name__ == "__main__":
    main()
