#!/usr/bin/env python3
# oracle.py — the numpy cross-validation oracle for the CFC real-recording gate.
#
# Two jobs, one algorithm (a faithful port of lib/dsp/cfc.mn):
#   generate  -> write recording.txt (one float per line) with a KNOWN coupling
#   oracle    -> read recording.txt, compute the comodulogram the SAME way the
#                Mentl pipeline does, print the argmax flat cell + peak/mean.
#
# The gate runs Mentl over the SAME file and asserts Mentl's argmax == this
# oracle's argmax. Two independent implementations agreeing on the same on-disk
# data is the representation-stress oracle the m3==m4 fixpoint structurally
# cannot be (a corrupt [Float] would make Mentl's argmax diverge from numpy's).
import sys, math
import numpy as np

SR   = 512
N    = 4096
WIN  = 128
HOP  = 32
LOW  = [4, 6, 8, 10]
HIGH = [30, 40, 50, 60]
# Built-in coupling: 8 Hz phase drives 50 Hz amplitude (distinct from the
# inline demo's 6->40: same well-resolved low (6 Hz), a DIFFERENT high (60 Hz),
# so the file-transport pipeline is proven to generalize, not memorize.)
COUPLE_LOW, COUPLE_HIGH = 6, 60

def gen_signal():
    t = np.arange(N) / SR
    env = 1.0 + 0.8 * np.cos(2*math.pi*COUPLE_LOW*t)
    carrier = np.sin(2*math.pi*COUPLE_HIGH*t)
    noise = 0.10 * np.sin(2*math.pi*13*t)   # off-grid distractor
    return env*carrier + noise

def hann(n):
    j = np.arange(n)
    return 0.5 - 0.5*np.cos(2*math.pi*j/(n-1))

def dft_bin(xs, start, n, freq, sr):
    j = np.arange(n)
    w = hann(n)
    ang = 2*math.pi*freq*j/sr
    wx = xs[start:start+n]*w
    re = np.sum(wx*np.cos(ang)) / n
    im = -np.sum(wx*np.sin(ang)) / n
    return re, im

def column(xs, freq, num_frames, want_phase):
    out = np.zeros(num_frames)
    for f in range(num_frames):
        re, im = dft_bin(xs, f*HOP, WIN, freq, SR)
        out[f] = math.atan2(im, re) if want_phase else math.hypot(re, im)
    return out

def mvl(phases, amps):
    sc = np.sum(amps*np.cos(phases))
    ss = np.sum(amps*np.sin(phases))
    return math.hypot(sc, ss) / len(phases)

def comodulogram(xs):
    num_frames = (len(xs)-WIN)//HOP + 1
    low_cols  = [column(xs, f, num_frames, True)  for f in LOW]
    high_cols = [column(xs, f, num_frames, False) for f in HIGH]
    m = np.zeros((len(LOW), len(HIGH)))
    for li in range(len(LOW)):
        for hi in range(len(HIGH)):
            m[li, hi] = mvl(low_cols[li], high_cols[hi])
    return m

def main():
    cmd = sys.argv[1] if len(sys.argv) > 1 else "oracle"
    path = sys.argv[2] if len(sys.argv) > 2 else "recording.txt"
    if cmd == "generate":
        xs = gen_signal()
        with open(path, "w") as fh:
            for v in xs:
                fh.write(f"{v:.6f}\n")
        print(f"wrote {len(xs)} samples to {path}")
        return
    # oracle: read the file back (parse the SAME text Mentl parses)
    with open(path) as fh:
        xs = np.array([float(line) for line in fh if line.strip()])
    m = comodulogram(xs)
    flat = int(np.argmax(m))
    li, hi = flat // len(HIGH), flat % len(HIGH)
    peak = m.flat[flat]
    mean = float(np.mean(m))
    print(f"argmax flat={flat} cell=(low={LOW[li]}Hz, high={HIGH[hi]}Hz) "
          f"peak={peak:.6f} mean={mean:.6f} peak/mean={peak/mean:.2f}")
    print(f"EXPECTED_FLAT={flat}")

main()
