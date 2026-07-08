#!/usr/bin/env python3
# emit-diff — the self-hosting divergence pinner (PLAN §5 stage-3 scaffolding).
#
# The whole self-hosting bug class is "m2 works, m2's emit of the wheel (m3)
# diverges." This answers, mechanically, WHICH function m2 emitted differently
# than the seed did — by a handle-anchored, provenance-normalized per-function
# diff over two .wat files. Named wheel fns ($flatten, $fold) match by name;
# lambdas ($lambda_<N>, numbers differ per handle-numbering) match by their
# normalized body. Numbers that are pure provenance (lambda/call/sst/local
# suffixes, data-section string offsets) are normalized away so only STRUCTURAL
# divergence — list_concat vs unreachable — survives.
#
#   python3 tools/emit-diff.py A.wat B.wat            # summary
#   python3 tools/emit-diff.py A.wat B.wat --trap     # only B-side bodies with unreachable that A lacks
#   python3 tools/emit-diff.py A.wat B.wat NAME       # full normalized diff of one named fn
#
# This is a larval `mentl verify`: the graph projecting its own divergence.
import re, sys, collections, difflib

def parse_funcs(text):
    """Return [(name, body)] for every top-level (func $name ...), paren-balanced."""
    out = []
    for m in re.finditer(r'\(func \$([^\s\)]+)', text):
        start = m.start()
        name = m.group(1)
        depth = 0
        j = start
        while j < len(text):
            c = text[j]
            if c == '(':
                depth += 1
            elif c == ')':
                depth -= 1
                if depth == 0:
                    break
            j += 1
        out.append((name, text[start:j + 1]))
    return out

# Provenance = a handle number: a $sym_<digits> suffix, or a raw data offset.
SUFFIX = re.compile(r'\$([A-Za-z_][A-Za-z0-9_]*?)_\d+\b')

def normalize(body):
    b = SUFFIX.sub(r'$\1_N', body)          # $lambda_67587 -> $lambda_N, $call_13 -> $call_N
    b = re.sub(r'\s+', ' ', b).strip()      # whitespace-insensitive
    return b

def is_lambda(name):
    # a synthesized function: trailing _<digits> (lambda_N, diverge_N, ...); a
    # real wheel fn ($flatten, $collect_fn_bases) has no trailing handle number.
    return re.search(r'_\d+$', name) is not None

def load(path):
    return parse_funcs(open(path).read())

def main():
    a_path, b_path = sys.argv[1], sys.argv[2]
    flag = sys.argv[3] if len(sys.argv) > 3 else None
    A = load(a_path)
    B = load(b_path)
    An = {n: b for n, b in A}
    Bn = {n: b for n, b in B}

    # Full diff of one named fn.
    if flag and not flag.startswith('--'):
        na = normalize(An.get(flag, '')).split(' ')
        nb = normalize(Bn.get(flag, '')).split(' ')
        sys.stdout.writelines(difflib.unified_diff(
            [w + '\n' for w in na], [w + '\n' for w in nb],
            fromfile=f'A:{flag}', tofile=f'B:{flag}', lineterm='\n'))
        return

    # Named wheel fns: match by name, report structural divergence.
    named_div = []
    for name in sorted(set(An) & set(Bn)):
        if is_lambda(name):
            continue
        if normalize(An[name]) != normalize(Bn[name]):
            named_div.append(name)
    a_only = sorted(n for n in An if not is_lambda(n) and n not in Bn)
    b_only = sorted(n for n in Bn if not is_lambda(n) and n not in An)

    # Lambdas: match by normalized body (names carry no stable identity).
    def lam_bodies(funcs):
        c = collections.Counter()
        for n, b in funcs:
            if is_lambda(n):
                c[normalize(b)] += 1
        return c
    la, lb = lam_bodies(A), lam_bodies(B)
    only_a = la - lb   # bodies A emits that B does not (fewer)
    only_b = lb - la

    if flag == '--trap':
        # B-side bodies with `unreachable` that A does not emit — the divergent floors.
        for body, cnt in only_b.most_common():
            if 'unreachable' in body:
                print(f'--- B-unique (x{cnt}), has unreachable ---')
                print(body[:600])
                print()
        return

    print(f'A = {a_path}  ({len(A)} funcs)')
    print(f'B = {b_path}  ({len(B)} funcs)')
    print()
    print(f'=== named wheel fns differing (structural, {len(named_div)}) ===')
    for n in named_div:
        print(f'  {n}')
    if a_only:
        print(f'=== named fns only in A ({len(a_only)}) ===')
        print('  ' + ', '.join(a_only))
    if b_only:
        print(f'=== named fns only in B ({len(b_only)}) ===')
        print('  ' + ', '.join(b_only))
    print()
    a_traps = sum(c for b, c in only_a.items() if 'unreachable' in b)
    b_traps = sum(c for b, c in only_b.items() if 'unreachable' in b)
    print(f'=== lambda-body divergence ===')
    print(f'  A-unique bodies: {sum(only_a.values())} ({a_traps} with unreachable)')
    print(f'  B-unique bodies: {sum(only_b.values())} ({b_traps} with unreachable)')
    print(f'  (run with --trap to see B-side unreachable bodies A lacks — the divergent floors)')

if __name__ == '__main__':
    main()
