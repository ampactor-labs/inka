# Frontier gates

These tests state executable contracts that are not green yet. Run them with:

```sh
bash tools/frontier-gate.sh --compiler boot
bash tools/frontier-gate.sh --compiler fresh
```

`boot` uses the pinned fixpoint compiler. `fresh` uses the compiler emitted from
the current wheel via `wt_m2_ensure`; at a fixed point it is the same compiler as
the march's next generation.

The gate exits nonzero until every contract holds. It stays separate from
`tools/verify.sh` while red; once green, its cases become ordinary regressions.

The scheduled fanout matrix pins representation at the scheduler boundary. The
constrained-hole crucibles pin one complete authoring cycle: filter candidates,
retain survivor and rejection Reasons, apply the patch to a scratch copy,
discharge all proof debt, compile, assemble, and execute the patched program.
The capability fixture requires `!Network` to reject direct, transitive, and
higher-order effect paths while retaining `pure_seven()`.
