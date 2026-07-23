#!/usr/bin/env python3
# gen.py — the synthetic phase-amplitude-coupled recording for the signal
# crucible (lib/dsp/signal.mn's STFT + bandpass + comodulogram pipeline).
#
# Writes one float per line to recording.txt (the transport the Mentl pipeline
# reads through WASI). The 50 Hz carrier's AMPLITUDE is modulated at 4 Hz — a
# phase-amplitude coupling built in by construction:
#
#   x(t) = (1 + 0.8*cos(2*pi*4*t)) * sin(2*pi*50*t)   # 50 Hz amp coupled to 4 Hz
#        + 0.1*sin(2*pi*13*t)                          # off-grid distractor
#
# The (low=4, high=50) pair is DISTINCT from cfc-demo (6->40) and cfc-rec
# (6->60), so the filter-based pipeline is proven to find a coupling it was never
# tuned to, not to memorize one grid cell. A correct comodulogram argmaxes the
# (4, 50) cell = flat index LOW.index(4)*4 + HIGH.index(50) = 0*4 + 2 = 2, with
# the peak far above the median cell (the noise floor).
#
# gen.py OWNS the signal and the exact math.mn transcendental ports (msin/mcos);
# oracle.py imports them, so the planted signal and the cross-validator share one
# home. The ports match lib/runtime/math.mn's Taylor series so the recording is
# what Mentl's own math would produce, and Mentl's later reading agrees to f64
# epsilon (the argmax and the ratio-floor threshold clear their margins by a wide
# gap regardless).

import sys

SR = 512
N = 4096
COUPLE_LOW = 4       # phase frequency (Hz)
COUPLE_HIGH = 50     # amplitude-carrier frequency (Hz)

TWO_PI = 6.283185307179586
PI = 3.141592653589793


def ffloor(f):
    # lib/runtime/math.mn float_floor: truncate toward zero, step down if below.
    t = float(int(f))
    return t - 1.0 if f < t else t


def msin(x):
    # lib/runtime/math.mn sin: range-reduce to [-pi, pi), 8-term alternating series.
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
        t = float(n) / float(SR)
        env = 1.0 + 0.8 * mcos(TWO_PI * COUPLE_LOW * t)
        carrier = msin(TWO_PI * COUPLE_HIGH * t)
        noise = 0.1 * msin(TWO_PI * 13.0 * t)
        out.append(env * carrier + noise)
    return out


def write_recording(path):
    xs = signal()
    with open(path, "w") as fh:
        for v in xs:
            fh.write(f"{v:.6f}\n")
    return len(xs)


def main():
    path = sys.argv[1] if len(sys.argv) > 1 else "recording.txt"
    count = write_recording(path)
    print(f"wrote {count} samples to {path}")


if __name__ == "__main__":
    main()
