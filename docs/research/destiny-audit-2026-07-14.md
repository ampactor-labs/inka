# The destiny audit — machinery real, performance absent (2026-07-14)

An 8-subsystem adversarial audit (a 9-agent ultracode workflow, each agent
artifact-grounded against the wheel + the three docs; the orchestrator
re-derived the flagship claims) of how far Mentl is from its destiny (PLAN §0:
proof beats review, `!E` proves the negative, intent lossless, computation
durable, systems explain themselves, `!Outside`, the developer is the telos).

## The one thesis every auditor found independently

**Machinery real, performance absent.** Mentl built its capabilities correctly
as handlers-on-the-graph — and then left the ops unperformed and the handlers
uninstalled. Synth, the Why engine, persist, Verify, IFC, the modal world,
the LSP/IDE transports, the `repr` gradient — every one is a real engine with
no live loop calling it. The five destiny pillars score ~35–40% against the
artifact, not because the substrate is missing but because it is not WIRED.
The single truest line: `synth_proposer.mn:570` asserts "the loop is closed";
the artifact says it is open. This is a far better place to be than the inverse
(build almost everything, perform almost none), and a far worse place than the
docs claim.

The shape of the remaining work (beyond the perf loop): **wiring-dominated**
(perform the ops already built — the largest and cheapest bucket),
**deletion-heavy** (less-code IS the fix, over and over), with a **focused
proving spine** (the one genuinely new engine) and **one deferred big build**
(native / the execution-layer `!Outside`).

## The critical path — dependency-ordered (beyond perf)

- **R1 — `EffName` is a handle → the positive effect gate becomes sound.** THE
  non-negotiable and the convergent root (the effects, value, and continuations
  auditors each route their biggest fix through it). Intern effect names at
  parse so `effects.mn`'s `list_index(set,i) == name` is `i32.eq`-on-identity,
  not a pointer compare of two byte-equal heap `ENamed("E")`. Confirmed against
  the artifact: 533 `E_EffectMismatch` + 61 `E_PurityViolated` on the wheel's
  own self-compile, incl. `WasmOut vs WasmOut`. One move: (a) 594 tolerated
  diagnostics → ~0 (the flagship "prove the negative" stops crying wolf on
  identity), (b) `world_tag` becomes an exact handle-set (durable-resume gate),
  (c) fold dedup a handle-set, (d) modal row-compares exact, (e) DELETES the
  by-name family (`eff_name_str`/`forbidden_names_disjoint`, effects.mn:351-374)
  and the negation gate's `str_eq` special-case. §5.O layer-1 extended from
  perf to CORRECTNESS — and the perf loop will NEVER reach it (the membership
  site isn't hot; it's a correctness site masked by productive-under-error).
  `Hβ.effects.positive-row-pointer-eq` / `Hβ.perf.name-is-handle`. Unblocks IFC
  (band C inherits crown soundness), modal, the durable-resume world gate.

- **R2 — bind `self`/ctor-args to the LIVE construction node in Verify.**
  Today `unify` passes the predicate with `self` pointing at the type-decl-site
  VarRef (infer.mn:1601/1605/1647), so `node_const(self)` → None → every one of
  the 105 refined sites defers forever and `let bad: Sample = 1.5` compiles
  (SYNTAX.md's own `E_RefinementRejected` example is false against the artifact).
  Carry the edge to the value being refined. The root of the entire VALUE-proof
  pillar; independent of R1; prerequisite for R3/R5. `Hβ.types.predicate-is-expr`.

- **R3 — a decidable arithmetic fragment (interval + linear-arith, Liquid/Flux).**
  The tier between literal-folding (`predicate_decide`, verify.mn:85, today a
  constant folder that discharges nothing with a value) and the unwired external
  SMT. DEPENDS on R2. The one genuinely NEW engine on the proof side; it is what
  makes the §5 `??`-filter proposer non-vaporous. `Hβ.verify.smt-handler-swap`.

- **R4 — wire the live felt loop (mostly WIRING of built machinery).** Highest
  destiny-per-line. (a) transports infer — `ensure_doc_open`/`did_change` run
  `driver_check` so `consult(QTypeAt)`/`propose` read a populated graph (the LSP
  and IDE never run inference today; the IDE reconstructs the eight aspects from
  a JS surface-parse); (b) route `QWhy` through `why_expand`/`why_from_handle`
  and add a `mentl why` verb (the live chase exists, no reachable path calls it);
  (c) gate synth on `NHole`, surface AND APPLY proven candidates, replace
  `teach_synthesize`'s `list_index(candidates,0)` with the teaching tie-break.
  `Hβ.felt.mentl-edit-runtime` / `.lsp-transport-projection` / `.intent-ranker-gradient-plus-teaching`.

- **R5 — gate the narrowing elision on an ACTUAL discharge (landmine removal).**
  DEPENDS R2+R3. Today `graph_narrow_set` writes "proven" on the mere presence
  of an enclosing `if` (infer.mn:3892) and lower selects `list_index_proven` on
  it — a latent OOB saved only by the accident that the alias still bounds-checks.
  `narrow_set` must write the edge only when Verify discharges
  `path_pred ⟹ 0≤i<len`. Must land before anyone "optimizes" the alias.

- **R6 — extract the `~> Backend` emit seam + reconcile the doc lies.**
  `emit_module` (wasm.mn:257) is a hardwired call while wasm.mn:1's own comment
  claims "the handler IS the backend / swap, not rewrite." Extract it (Law-7
  no-op for WASM) so native.mn is a peer on the identical driver. Bundle the
  cheap doc-truth fixes (below).

Sequenced behind, each gated: IFC's integrity dual-lattice + PC-labels (after
R1); durable-resume of a REAL k + the world-gate-at-the-resume-edge (after R4);
native S1–S18 + diverse-double-compilation (after R6); the `mentl audit`
Carried-Truth keystone (after the graph is clean enough to read); the O(log N)
interval span-index for the L6 keystroke path (after §5.O layer-1 generalizes).

## The biggest hidden gap

**The effect gate** — headlined "THE CROWN LANDED" while the positive path
rejects a row subsuming itself 533× on the compiler's own source. Runners-up
name the same PATTERN: synth is the biggest DISHONESTY (`synth_proposer.mn:570`
"the loop is closed" while every proven candidate is discarded); `repr` is the
biggest SILENT MISCOMPILE (SYNTAX.md documents four `repr` forms as landed with
emit prose, but `p: f32` doesn't parse — `grep -c repr src/parser.mn` = 0 — so
it binds a type variable → RI32 → the value silently becomes a word, in the
subsystem whose whole point is making that unsayable).

## The biggest over-build

**The four parallel fold generators (eq / compare / hash / show) → one
`fold(ty, leaf)`.** ~1654 → ~450 lines (~25% of wasm.mn). §5.U names the
ultimate form; the payoff beyond line count is that eq-vs-compare-vs-hash-vs-show
STRUCTURAL DIVERGENCE becomes unsayable (today you can fix a nested offset in
`emit_one_eq_helper`, forget `emit_one_compare_helper`, and they disagree). The
most EGREGIOUS (smaller, worse in kind): the kernel's overlay machinery — six
`graph_handler` state fields + three parallel arrays (self-admitted drift-7) +
`overlay_register_at` ON the hot `graph_fresh_ty`/`graph_fresh_row` alloc path —
with `graph_fork` (its only would-be producer) inert. Pure dead weight taxing
every kernel allocation for a consumer that doesn't exist.

## Doc-truth fixes (the honesty debt — §0 forbids hidden gaps)

- `!E`-CROWN "landed" — corrected in §7 (negation sound, positive pointer-eq).
- `PROVENANCE.md`'s `--from-seed`/"seed stays" claim — false; the seed was
  DELETED (7401c4b). §6 says so; PROVENANCE contradicts it.
- PLAN §0 scopes the remaining Outsides to TWO (external-SMT + correctness
  oracle) — omitting wasmtime + WABT (the runtime + assembler), the single
  largest, most concrete Outside on every run path. §6 names it ("dissolve at
  L1"); §0's canonical enumeration understates it.
- "ONLY inference writes" (graph.mn:6, PLAN §2/§3) — the parser writes the
  program/comment/span weaves and the e-graph mints const-fold nodes; FOUR
  writers, not one. Restate the one-writer rule to its true scope (the mutable
  nodes cell) or collapse the co-indexed arrays toward one node record.
- SYNTAX.md — `repr` forms + `E_RefinementRejected` documented as landed but
  false against the artifact (R2/repr are the builds that make them true).
- `persist.mn` — "durable execution falls OUT of the memory model" backed by
  `fn persist_branch_run(x)=x`; the reify→memcpy→resume path is never exercised.
