# Mentl, positioned — the claims and their commands

This document states what Mentl claims against the 2026 field, and gives
the command that checks each claim on this repository. Nothing here asks
to be believed: run the command. The release protocol at the end makes
that the norm rather than a courtesy.

The category claim in one sentence: **Mentl is a verification substrate —
a medium where any intelligence may propose code and nothing executes
unproven — at the language level, where the industry's agent fences are
all at runtime and its intent specs are all behavioral.**

## Wedge 1 — the spec that cannot be ignored

The industry spent 2025–26 converging on "the spec is the artifact."
GitHub's spec-kit (124k stars, 30+ agent integrations) captures intent in
markdown and asks a model to follow it; its own documentation concedes
the gap: *"no automated validation that generated code matches
specifications"* — enforcement is behavioral. MoonBit bolts a verifier
beside its own copilot, after generation, on a conventional language.
Both channels share the same shape: intent → tokens → plausible text →
human audit, lossy at every arrow, with a person squinting at the end as
the error-correction layer.

In Mentl the same intent is a constraint the compiler discharges or
refuses. An effect row is a spec. A negation (`!E`) is a spec about what
can *never* happen. A refinement is a spec with arithmetic. None of them
can be ignored, because the executable gate sits between reachability and
emission: a program whose claims don't discharge produces zero output
bytes and a teaching diagnostic at the claim's own span.

Check it:

```sh
bash benchmarks/absence/run.sh     # 13 absence tasks judged by the compiler itself:
                                   # eight severance shapes REFUSE with a teaching span,
                                   # five controls PROVE — under- and over-refusal both scored
mentl mcp                          # the same gate served to agents over MCP stdio —
                                   # one tool (propose); refusals teach, and the only
                                   # path to an artifact on disk is through the proof
```

The absence benchmark exists because the podium was empty: vericoding
benchmarks standardize on proving what code *does*; none measures proving
what it can *never do*, which is the property autonomous software actually
hinges on. The nearest prior in print is Flix's effect exclusion
(ICFP'23; Boolean qualifiers OOPSLA'25) — name-keyed `!E` under
polymorphism, which we cite rather than claim. Mentl's seat is the
conjunction nobody holds: absence under handler-install *identity*, under
modality, under *time* (a persisted continuation's world), and per
*instance* — each measured unoccupied as of 2026-07.

## Wedge 2 — cell-grain deterministic parallel inference

TypeScript 7 shipped deterministic parallel checking at *file*
granularity. rustc's parallel front end is still fighting
diagnostics-differ-between-serial-and-parallel, with determinism proposed
as opt-in. Mentl's type inference runs its judgment as spawned branch
cursors over one shared image at *cell* granularity — individual type and
row cells are join-semilattice LVars, so concurrent teaching writes
commute — and the gate is byte-equality of the emitted artifact: the K=8
parallel judge produces the same bytes as the sequential judge, proven by
sha, not asserted by test.

The theory citation is LVars/CALM (Kuper–Newton; Hellerstein): monotone
joins commute, so schedule order cannot change the fixpoint. The
engineering claim past published SOTA is the *byte* gate itself — nobody
gates parallel compilation on byte-identical artifacts across thread
counts.

Check it:

```sh
bash tools/march.sh                # the wheel compiles itself to a byte-identical
                                   # fixed point (m2 == m3) — through the K=8 judge
bash tools/frontier-gate.sh        # 285 contracts including the fan legs that assert
                                   # identical shas across spawned-vs-sequential runs
```

## The four-arm hole

Mentl's `??` is a typed hole whose candidates are pruned by effect rows
(with negation), ownership, and refinements, over a *live image* that
fills and resumes. Each arm exists somewhere in prior work — RbSyn
(effects), RusSOL (ownership), Synquid (refinements), Hazel (live holes)
— and no published system combines them in one hole. The survivors are
proven before they surface; a tie is never guessed, it teaches: the fan
surfaces the one constraint that collapses it.

Check it:

```sh
mentl lib/tutorial/07-gradient.mn:0   # the whole absence field, ranked
mentl <file>:<line>:<col>             # at any authored ??: the proven fan,
                                      # each survivor with its Reason; ties teach
```

## Verify-by-replay — the release protocol

There is no signing ceremony to trust. The pinned compiler
(`boot/mentl.wasm`) carries a provenance chain (`boot/PROVENANCE.md`)
whose every entry was self-confirmed at pin time, and the claim is
*replayable*: re-run the march and the wheel reproduces itself
byte-for-byte from source. A hand-typed sha cannot enter history —
`tools/doc-truth.sh` runs inside every verify and pre-commit, checking
the recorded pin against `sha256(boot/mentl.wasm)` mechanically. This is
stronger than a signature: a signature says who built it; the replay says
*what it is*, to the byte, on your machine.

```sh
sha256sum boot/mentl.wasm          # the pin
head -40 boot/PROVENANCE.md        # the chain's newest entry, sha included
bash tools/doc-truth.sh            # the docs' checkable claims vs the artifact
bash tools/march.sh                # the replay: source → itself, byte-identical
```

## The honest boundary

Credibility with skeptics comes from stating what is *not* claimed.

- **Spec-faithfulness sits above the crown.** A proof is relative to a
  spec; proof-passing-but-intent-wrong code is a failure a proof
  *launders*, not one it removes. The human owns intent — that is the one
  genuine Outside, and the reason the tie-break asks instead of guessing.
- **Verify is sound and incomplete by choice.** Undecidable residue
  accrues as visible `V_Pending` debt (139 obligations on the wheel's own
  self-compile today), never silent assumption. The compile *says so*.
- **Classes arm one at a time.** A diagnostic class refuses executables
  only once the wheel's own census of that class is zero — dogfooding as
  a mechanical license, held monotone by a ratchet. Unarmed classes
  surface and the compile proceeds; the verdict says which happened.
- **The correctness oracle is still external.** The micro battery and the
  fixpoint prove reproduction and behavior; absorbing them into the
  wheel's own Verify (and diverse double-compilation for trusting-trust)
  is named, sequenced work, not a claim.

## The channel, stated once

A copilot's channel: intent → tokens → plausible text → human audit.
Mentl's channel: intent → constraint (typed, monotone, compounding) →
search pruned by proof at every step → survivors ranked by local intent →
ties teach → the accepted move proven. There is no unverified middle,
because every intermediate is a graph fact. What a generative assistant
retains is the underdetermined tail, and the medium converts that tail
into a sequence of proven next-moves. An LLM behind the gate is not
forbidden; it is unemployed.
