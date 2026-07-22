#!/usr/bin/env python3
# oracle.py — the python cross-validation oracle for the text (String=[byte]) gate.
#
# Reads corpus.txt and prints DISCRETE facts over the bytes, each mirroring the
# EXACT operation the Mentl program performs (byte count, per-letter counts, the
# most-frequent lowercase letter by a 256-slot histogram argmax). String=[byte]
# is the second big representation (after native [Float]); this stresses byte_len,
# byte_at, structural ==, and an Int histogram end to end on real text. A corrupt
# byte read would move a count or the argmax letter.
import sys
from collections import Counter

def facts(data):  # data is bytes
    nbytes = len(data)
    count_e = data.count(ord('e'))
    count_t = data.count(ord('t'))
    # most frequent lowercase letter (a-z), ties broken by lowest byte value —
    # the same order the Mentl argmax loop takes (first max wins on a forward scan)
    hist = [0]*256
    for b in data:
        hist[b] += 1
    best_b, best_c = 0, -1
    for b in range(ord('a'), ord('z')+1):
        if hist[b] > best_c:
            best_c, best_b = hist[b], b
    return nbytes, count_e, count_t, best_b, best_c

def main():
    path = sys.argv[2] if len(sys.argv) > 2 else "corpus.txt"
    data = open(path, "rb").read()
    nbytes, ce, ct, bb, bc = facts(data)
    print(f"bytes={nbytes} count_e={ce} count_t={ct} "
          f"top_letter='{chr(bb)}'({bb}) top_count={bc}")
    print(f"EXPECTED_BYTES={nbytes}")
    print(f"EXPECTED_COUNT_E={ce}")
    print(f"EXPECTED_COUNT_T={ct}")
    print(f"EXPECTED_TOP_LETTER={bb}")

main()
