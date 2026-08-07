#!/usr/bin/env python3
# The movers flavor histogram — the branch-picking probe, graduated
# (CLAUDE.md ⟳(3): a probe that answered becomes an instrument, never
# memory). Reads the movers channel's stderr (a compile captured with
# movers_diff's cap lifted) and classifies every A/B fingerprint pair:
# row flips (present-set / tail), ownership-grade flips (r/o markers),
# type flips (structure once rows and grades normalize) — plus the
# direction cuts (add-only vs rem-only front; r->o vs o->r). First
# firing 2026-08-07 on the 678 set: row 440 (421 add-only), grade 267
# (287 r->o), type 74 — the monotone front that picked the row-half
# swap. DIES WITH ITS CHANNEL: the movers report retires at rung 3
# (D8) when the second pass deletes; this script reads that report and
# retires the same day.
#
# Usage: python3 tools/movers-hist.py <stderr-file>
import re
import sys

txt = open(sys.argv[1]).read()
blocks = re.findall(r'^convergence: flip (\S+)\n  A: (.*)\n  B: (.*)\n', txt, re.M)

ROW = re.compile(r'!([0-9+()_&*]*)-(%\d+|\.|)')


def parse(s):
    rows = []

    def repl(m):
        pres = frozenset(x for x in m.group(1).split('+') if x)
        rows.append((pres, m.group(2)))
        return '!R'

    return rows, ROW.sub(repl, s)


def strip_grades(s):
    return re.sub(r':(o|r)(?=[a-zA-Z(\[%])', ':', s)


cats, add_names, rem_names, tail_flips, grade_dirs = {}, {}, {}, {}, {}
rowdir = {'add-only': 0, 'rem-only': 0, 'mixed': 0}
for name, a, b in blocks:
    ra, sa = parse(a)
    rb, sb = parse(b)
    ga, gb = strip_grades(sa), strip_grades(sb)
    row_flip = ra != rb
    grade_flip = (sa != sb) and (ga == gb)
    type_flip = ga != gb
    key = '+'.join(k for k, f in [('row', row_flip), ('grade', grade_flip),
                                  ('type', type_flip)] if f) or 'none'
    cats[key] = cats.get(key, 0) + 1
    if row_flip and len(ra) == len(rb):
        added, removed = set(), set()
        for (pa, ta), (pb, tb) in zip(ra, rb):
            added |= (pb - pa)
            removed |= (pa - pb)
            if ta != tb:
                tail_flips[(ta or '?', tb or '?')] = tail_flips.get((ta or '?', tb or '?'), 0) + 1
        for n in added:
            add_names[n] = add_names.get(n, 0) + 1
        for n in removed:
            rem_names[n] = rem_names.get(n, 0) + 1
        if added and not removed:
            rowdir['add-only'] += 1
        elif removed and not added:
            rowdir['rem-only'] += 1
        elif added or removed:
            rowdir['mixed'] += 1
    if grade_flip or (sa != sb and not type_flip):
        for ma, mb in zip(re.findall(r':(o|r)', sa), re.findall(r':(o|r)', sb)):
            if ma != mb:
                grade_dirs[f'{ma}->{mb}'] = grade_dirs.get(f'{ma}->{mb}', 0) + 1

print("blocks:", len(blocks))
print("categories:", dict(sorted(cats.items(), key=lambda kv: -kv[1])))
print("row direction (final vs trial):", rowdir)
print("names ADDED by final:", dict(sorted(add_names.items(), key=lambda kv: -kv[1])[:10]))
print("names REMOVED by final:", dict(sorted(rem_names.items(), key=lambda kv: -kv[1])[:10]))
print("tail flips (A->B):", dict(sorted(tail_flips.items(), key=lambda kv: -kv[1])[:8]))
print("grade flip directions:", grade_dirs)
