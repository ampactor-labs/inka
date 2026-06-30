# Mentl — Post-First-Light Roadmap (gathered 2026-06-28)

> Every unsurpassable-tier / frontier item, NAMED in positive form and sequenced, so first-light's focus never erases it. Gathered from the SOTA fleet, the three docs, the codebase named-peers, and an adversarial completeness critic. Reference detail; PLAN.md §5 holds the tight read-path list.


**Synthesis notes:** SYNTHESIS METHOD: all four sweeps were merged in-context (the three docs + the research-doc content were already loaded; no file reads needed). Deduped by name+theme across ~140 raw items → ~95 unique. Key dedups: fleet's modal-world-index ≡ docs' modal-world-synthesis; sound-neg-under-poly ≡ neg-under-polymorphism-sound; persist-equals-memcpy-handler ≡ lower.fanout-durable-persist-handler; diag.minimal-inconsistent-core ≡ why.minimal-cause-set; felt.hole-is-dormant-continuation ≡ synth.hole-as-dormant-continuation; closure.diverse-double-compilation ≡ outside.diverse-double-compilation; closure.correctness-oracle-internal ≡ outside.internalized-correctness-oracle; the three cache cross-file items folded to one; the cursor-transport wires folded to one suite.

CRITIC ADJUDICATION: of the critic's 17 items, 8 had exact equivalents already named by the fleet/docs/code sweeps (diverse-double-compilation, correctness-oracle, synth-proposer-gauntlet≈reflexive-over-proposers, ifc-noninterference, why.minimal-cause-set, collab-shared-cursor, reactive-reprojection, hole-as-dormant-continuation) and were merged as aliases rather than counted as newly-named. 9 are genuinely surfaced-nowhere and are listed in newly_named — the heaviest concentration is the FELT surface (mentl-edit-runtime, lsp-transport, verification-dashboard, query-projection-surface, time-travel-debug) and the §0 KEYSTONE (carried-truth-projection / mentl audit). This is the real blind spot: the fleet+docs+code sweeps are dense on the kernel arms (effects/continuations/IFC/value-layer) but THIN on L6 — exactly the layer §5/§4⑦ warn is wrongly treated as Stage-3 garnish. The roadmap's felt theme is therefore the most critic-dependent and the most at risk of erasure.

SEQUENCING SPINE: one dependency root governs the whole post-first-light arc — Hβ.effects.sound-neg-under-poly. Ownership-as-effect, !Thread/!Alloc transitivity, and IFC non-interference ALL inherit the EfNeg-under-instantiation unsoundness, so none can be VERIFIED (only built) until the crown closes. The TCont world-index is the second spine (TIME): the persist handler, cross-machine resume, flow-world-on-tcont, and the fold's function-leaf all hang off it. STEP 0–5 + W31 are landed, so the value layer and IFC scaffold are the most shovel-ready (fold leaves are explicitly the lowest-risk, LESS-code follow-ups).

LANDED-vs-NAMED is tracked per item so first-light does not re-litigate done work: STEP 0 (46e4801), STEP 1 (2cf717b), STEP 2 (d138274), STEP 3 (7b72790), STEP 4 (600bc88), STEP 5 (27edc30), W31/W31b (41411fd, 097a50d). The seed-lag gates resolve AT first-light by seed dissolution and are captured only so the live gates aren't mistaken for regressions.

HONESTY FLAGS preserved verbatim from the sweeps (these are the items most likely to harbor an unsound claim and must be GATED, never asserted): (1) Verify→SMT may rely on external Z3/CVC5 = a residual !Outside one layer down — name it if it persists; (2) the modal box/ambient-context mapping is the single most differentiating claim — verify it holds before asserting modal-readiness; (3) !Thread/!Alloc transitivity and the <|/>< race-freedom proof must survive a higher-order branch closure escaping (where à-la-Mode needed the Capsule); (4) first-light's correctness half is itself an external !Outside until internalized. Each is in the roadmap as a GATE, honoring Law 7 (verify the floor, never defer the form).

PLAN.md §5 INTEGRATION: plan5_block is structured as a §5.UNSURPASSABLE addendum with 15 lettered theme-bands (A–O), each gate-first-then-dependents, every item carrying its peer name + file:line anchor where one exists. It is the durable record the task demands — complete enough that no item is forgotten, tight enough to live in the read-path.


## Effects & the modal synthesis (arm 4 — THE CROWN)

_Make transitive Boolean !E sound under polymorphism and unify rows with capabilities via the modal modality — realized THROUGH the unified-evidence substrate (inferred + cursor-projected, never authored), never as a replacement for the graph route. The crown frontier; gates ownership-as-effect, !Thread race-freedom, and IFC non-interference (EfNeg IS their proof, so they inherit its unsoundness)._

- **Hβ.effects.sound-neg-under-poly** — Make !E SOUND under polymorphism. unify_row punts EfOpen~EfNeg (effects.mn:378) and free_in_row/subst_row cross EfNeg unguarded, so an open row var can re-admit the effect !E forbade — why Koka omits negation. Build the soundness GATE; never let a session rationalize the flow-edge form as 'already modal' (refuted 4/4, 2026-06-21).
  - depends on: first-light closes the POSITIVE higher-order leak (flow-edge completion, ev-slot seam) enough to self-host; negation-under-poly is the long game on top.
  - SOTA: Koka (Leijen) omits negation by design; Tang & Lindley 'Modal Effect Types' POPL 2025 (arXiv 2407.11816)
- **Hβ.effects.modal-world-index** — Realize the modal synthesis (rows+capabilities+Boolean negation sound simultaneously under polymorphism AND first-class/multi-shot continuations) as a GRAPH FACT. Absolute modality ↔ the ~> handler stack read live; box modality ↔ effect-polymorphism via the unified evidence record. Alias: Hβ.effects.modal-world-synthesis. NOW: add the POPL 2026 citation at src/effects.mn:12.
  - depends on: Hβ.effects.sound-neg-under-poly; first-light; the TCont world keystone.
  - SOTA: Tang & Lindley 'Rows and Capabilities as Modal Effects' POPL 2026 (arXiv 2507.10301)
- **Hβ.infer.modal-capability-at-tee** — The modal typing RULE (no new surface form): a row variable becomes a lexical capability handle at the EXISTING ~> install edge — rows give !E, ~> gives the lexical capability, modal is their unification re-admitting first-class escape under proof. The inferred-and-cursor-projected install-edge rule, named nowhere else.
  - depends on: first-light; Hβ.types.tcont-world-binding-keystone (landed); effects flow-edge soundness for !E-under-poly.
  - SOTA: Tang & Lindley POPL 2025/2026
- **Hβ.syntax.perform-dissolution** — Retire the lexed-but-stripped TPerform token entirely once the formatter-lift (E_RedundantPerform) is universal — ops are bare calls (EffectOpScheme + Closed[eff] row prove op-ness).
  - depends on: first-light; bare-call op resolution (live).


## Continuations & TIME (arm 2, §4④, §5.U keystone)

_The binding keystone — TCont carries the effect-WORLD, lifting !E to the TIME axis so a persisted/cross-context resume under a changed handler-set is a compile-time error, not a 3am corruption. Durable execution falls out of the unified heap record (persist = memcpy, zero serializer). STEP 3 producer + STEP 5 arity LANDED; the world ENFORCEMENT and persist catcher are the post-first-light remainder._

- **Hβ.types.tcont-world-binding-keystone** — TCont(Ty, ResumeDiscipline, EffRow) carrying the effect-WORLD. STEP 5 landed the 3-arg arity (27edc30); the world is INERT on the single-world OneShot path (gate resume-world=42). The cross-world enforcement is the remainder.
  - depends on: STEP 5 (landed); STEP 3's persist resume-catcher for the cross-world boundary.
  - SOTA: Modal Effect Types POPL 2025; Effekt ICFP-2025 (multiple resumptions + local state)
- **Hβ.types.resume-world-mismatch-value-gate** — The runnable value gate proving E_ResumeWorldMismatch fires: a TCont(_,_,world) resumed under a non-unifying effect-world is rejected. Coupled: the record LAYOUT is part of the world, so a repr-gradient widening (STEP 1) is caught by the type, not a corrupted memcpy. The single strongest genuine novelty — ABSENT across Koka/Effekt/modal/OCaml5/WasmFX/Temporal/Restate/DBOS/Racket.
  - depends on: STEP 3's persist resume-catcher; Hβ.types.tcont-world-binding-keystone (landed); STEP 1 repr gradient.
  - SOTA: NO system does this; Pettyjohn ICFP 2005 = the silent-obsolescence failure it beats
- **Hβ.infer.tcont-world-capture-at-reify** — At continuation-reification, CAPTURE the live effect-world onto the TCont (infer.mn:2714 'attach to TCont') so the carried world is the actual handler-set in force at the freeze point.
  - depends on: Hβ.types.resume-world-mismatch-value-gate; STEP 3 persist resume-catcher; first-light.
  - SOTA: Temporal GetVersion/patched (manual runtime) = the dynamic version Mentl makes a compile-time type
- **Hβ.continuations.world-widening-resume** — Make Temporal's legitimate compatible-evolution expressible as a typed world-WIDENING: resume under a SUPERSET handler-set typechecks. The usability gate on the soundness mechanism.
  - depends on: Hβ.types.resume-world-mismatch-value-gate.
  - SOTA: Temporal GetVersion/patched
- **Hβ.continuations.persist-equals-memcpy-handler** — Durable execution as a ~> Persist handler swap: handler=state=closure=evidence=continuation=branch-thunk is ONE contiguous bump-image record, so persist=memcpy, ZERO serializer — a THIRD durability model (neither log-replay nor promise-set). STEP 3 minted the dormant producer (7b72790); the persist CATCHER is the post-first-light piece. Alias: Hβ.lower.fanout-durable-persist-handler.
  - depends on: STEP 3 producer (landed); Hβ.types.resume-world-mismatch-value-gate; first-light.
  - SOTA: Temporal/Restate/DBOS hand-write serializers; DBOS 1–2ms checkpoint = the latency bar; Resonate = the promise-set model this is a third alternative to
- **Hβ.persist.cross-machine-resume** — Distributed durable execution: a continuation memcpy'd and resumed on a DIFFERENT node, with the world-mismatch check across a network/recompile boundary. NEWLY NAMED (critic) — local persist peers exist, cross-machine does not.
  - depends on: first-light; persist=memcpy; Hβ.types.resume-world-mismatch-value-gate across a node boundary.
  - SOTA: Temporal/Restate/DBOS/Golem; PLAN §0 point 4 (cross-machine workflows)
- **Hβ.persist.branch-world-tag** — Per-branch effect-WORLD tag on a persisted continuation (lib/runtime/persist.mn:119) so a branch resumed under a changed handler-set is caught — the per-branch peer of the TCont world keystone.
  - depends on: first-light; the TCont keystone; persist resume-catcher.
  - SOTA: Modal Effect Types POPL 2025
- **Hβ.continuations.wasmfx-lowering-tier** — Decide whether the MultiShot tier emits to WasmFX cont.new/suspend/resume for in-process speed while keeping the heap-record form for persist/fork (WasmFX stacks are NOT memcpy-serializable). Verify the typed row + cardinality against WasmFX's tag/resume model, not a bespoke one.
  - depends on: first-light; the continuation-reification codegen keystone (the open keystone PLAN §2 names).
  - SOTA: WasmFX OOPSLA2 2023; Wasmtime stack-switching WAW 2025
- **Hβ.continuations.typed-resume-atm-expressiveness** — Verify TCont's Ty captures the answer-type (resume:R->S) and body-structure cardinality inference never under-approximates a genuinely multishot arm into OneShot (a silent Law-7 miscompile).
  - depends on: first-light; the OneShot/MultiShot producer split (STEP 3).
  - SOTA: Danvy-Filinski ATM 1990; SRFI 248 shift0/reset0 (2025); Sekiyama-Unno (2023)
- **Hβ.continuations.unified-record-serialization-gate** — Guard 'persist=memcpy' with a serialization gate: sound ONLY if ownership proves the record unaliased AND representation gives every field a real width (a persisted f64 floored to i32 corrupts). Verify a forked/persisted continuation round-trips byte-identical — the cross-arm (5∩7∩2) obligation.
  - depends on: STEP 1 repr; STEP 3 producer; Hβ.types.resume-world-mismatch-value-gate; first-light.
  - SOTA: Pettyjohn ICFP 2005; Effekt ICFP 2025 copy-on-resume
- **Hβ.infer.tail-recursion-resume-cardinality** — Detect MultiShot cardinality from tail-recursion in CallExpr (infer.mn:3061) — today only the structural NLoopExpr ancestor is detected; closes the gradient-undecided case.
  - depends on: first-light; resume-cardinality inference (landed).
  - SOTA: Effekt ICFP-2025
- **Hβ.lower.either-install-negotiation** — The Either resume-cardinality case where callers pin distinct kinds at different install sites — install-site negotiation of OneShot vs MultiShot at the EffectOpScheme.
  - depends on: first-light; resume-cardinality inference.
- **Hβ.felt.time-travel-debug-forked-cursor** — Step-back/replay debugging as a FORKED cursor over the trail-checkpointed graph: rewind a persisted continuation, re-run from any checkpoint, inspect the graph at an earlier epoch. NEWLY NAMED (critic).
  - depends on: first-light; multi-shot trail-checkpoint/rollback (built); persist; continuation reification codegen.
  - SOTA: rr record-replay; Temporal replay; Racket continuation debuggers
- **Hβ.ml.autodiff-as-multishot** — Autodiff's hand-rolled TapeEntry (lib/ml/autodiff.mn:36) dissolves into MultiShot: a Compute handler captures each forward op's continuation; backward = resuming in reverse; a checkpoint = one memcpy (persistable). The generative leap behind the producer.
  - depends on: first-light; STEP 3 continuation producer; ~> Persist.
  - SOTA: JAX/PyTorch (host-language explicit tape, no persist)


## IFC — information flow control (arm 4/6, §4⑥)

_Absorb information-flow control into the same Boolean algebra: the row carries FLOW, not only capability presence, so 'Secret may not flow to Log' is proven the way !Alloc is — EfNeg IS the non-interference proof. W31/W31b scaffold (FlowLabel lattice, PFlowLe in Predicate, QFlowOf) LANDED in code; no positive-form peer named its completion. PLAN §0 calls proving-the-negative the future's deepest need._

- **Hβ.verify.ifc-noninterference** — Umbrella completion of the W31 IFC scaffold into the full non-interference proof in the SAME Boolean row, with declassification handler and transitive flow. Code anchor: Hβ.types.ifc-flow-constraint (types.mn:1029) — infer's MakeStringExpr arm emits ifc_check when a Secret/Tainted splice flows into Public, discharged by verify_smt.
  - depends on: first-light; EfNeg soundness (Hβ.effects.sound-neg-under-poly); Hβ.types.predicate-is-expr; verify_smt.
  - SOTA: Jif, FlowCaml, LIO, FIDES; SecRef* non-interference
- **Hβ.ifc.dcc-noninterference-gate** — Verify the FlowLabel lattice + PFlowLe satisfies DCC's protection-monad non-interference soundness — DCC is the correctness ORACLE; PFlowLe must be proven equivalent, not asserted.
  - depends on: first-light; Hβ.effects.sound-neg-under-poly (EfNeg inherits the unsoundness).
  - SOTA: DCC — Abadi, Banerjee, Heintze, Riecke POPL 1999
- **Hβ.ifc.flowlabel-inference-in-hm** — Fold FlowCaml-style flow-label constraint-solving into the SAME HM/union-find walk as effects (FlowLabel is a graph node like the row var) so labels are never authored except at declassify points. Apply the Hylo-quiet bar (Public default; Secret/Tainted inferred).
  - depends on: first-light; the unified HM walk; Hβ.ifc.dcc-noninterference-gate.
  - SOTA: FlowCaml — Pottier & Simonet POPL 2002 / TOPLAS 2003
- **Hβ.ifc.pc-label-implicit-flow** — Close the implicit-flow gap with a program-counter label through if/match so 'if secret { logA } else { logB }' is caught — the scaffold only taints explicit splice flows; FIDES punts exactly this.
  - depends on: first-light; Hβ.ifc.flowlabel-inference-in-hm.
  - SOTA: FIDES (Microsoft 2025); DCC; 'Nonmalleable Progress Leakage' arXiv 2505.12210
- **Hβ.ifc.integrity-dual-lattice** — Add the integrity dual (Untrusted⊑Trusted — prompt-injection IS an integrity violation) as a confidentiality⊗integrity PRODUCT lattice in the SAME EfNeg machinery. The agentic-security dual; design alongside confidentiality.
  - depends on: first-light; Hβ.ifc.dcc-noninterference-gate; the EfNeg machinery.
  - SOTA: Biba integrity; FIDES product lattice (Microsoft 2025)
- **Hβ.ifc.declassify-robust** — Align declassification (Tainted→Public via SMT non-invertibility handler swap) with Sabelfeld-Sands dimensions (what/who/where/when) and ROBUST declassification — an attacker controlling Public inputs cannot widen the release.
  - depends on: first-light; the verify_smt handler swap.
  - SOTA: Sabelfeld & Sands 'Dimensions and Principles'; robust-declassification literature
- **Hβ.ifc.flow-world-on-tcont** — Lift the FLOW-world onto TCont so a Secret in a persisted/memcpy'd continuation resumed under a new handler-set is E_ResumeWorldMismatch on the flow lattice — confidentiality across durable execution, the move NO competitor has (effects ∩ continuations ∩ IFC).
  - depends on: Hβ.types.resume-world-mismatch-value-gate; Hβ.ifc.flowlabel-inference-in-hm.
  - SOTA: No system carries a flow label across a persisted continuation
- **Hβ.ifc.agentic-fides-target** — Adopt FIDES's threat model (prompt injection as a flow violation, consequential-action gating) as a compile-time verification target the ~> handler stack discharges — static/inferred/in-the-row IFC, the 'proven not policed' answer to §0's machine-code reframe.
  - depends on: first-light; the full IFC arm (DCC gate, pc-label, integrity dual).
  - SOTA: FIDES (Microsoft 2025); 'Verifiably Safe Tool Use for LLM Agents' arXiv 2601.08012


## The value layer — representation gradient & structural fold (arms 1/7, §5.U)

_Four projections of one cursor on one heap record. STEP 0/1/2 LANDED (repr_of, the representation gradient with boxed-f64 deleted, the eq leaf total over five node-kinds). The post-first-light remainder generalizes the eq generator into fold(ty,leaf) for show/pack/compare/hash, widens variant payloads, and verifies Arrow-layout interop — LESS code, retiring three hand-copies._

- **Hβ.fold.show-leaf** — Generalize the SHOW leaf into fold(ty,leaf), retiring the lower_to_string aggregate fall-through. Code anchor Hβ.fold.show-leaf-as-lowered-lfn (lower.mn:455): synthesize as LOWERED CODE (an LFn of str_concat/int_to_str + recursive descent) so it flows through the closure-call convention — raw WAT would silently miscompile (Law 7). BOUNDARY: types.mn's show_type/show_reason/show_effrow are the DOMAIN renderer (mentl voice), NEVER retired.
  - depends on: STEP 2 eq leaf (landed); STEP 0/1 repr word-leaf; closure-call emit convention.
  - SOTA: Generic/derivable Show (no Show trait-bound — the proof becomes the dispatch)
- **Hβ.fold.pack-unpack-leaf** — Generalize pack/unpack into fold(ty,leaf), retiring the cache walk that PINS the IKAI tag-byte wire format. The function-leaf serializes a continuation by memcpy. EffArg pack/unpack already TOTAL over 3 tags (additive).
  - depends on: STEP 1 f64 width (EAFloat round-trip); STEP 5 TCont world (function-leaf).
  - SOTA: Durable-execution serializers (Temporal oplog) — escaped by the memcpy function-leaf
- **Hβ.fold.pack-leaf-effarg-float** — Byte-faithful f64 round-trip for the cache's EAFloat tag in the pack/unpack fold-leaf — rides STEP 1's f64 width so a persisted float never loses precision; additive (existing .kai bytes unchanged).
  - depends on: STEP 1 f64 representation gradient (landed).
  - SOTA: IEEE-754 round-trip fidelity
- **Hβ.fold.compare-hash-leaf** — Generalize compare/hash into fold(ty,leaf), retiring the hand-copied generated leaf (word-leaf reads the gradient: f64.eq for an f64 field). Makes the eq/hash-divergence footgun structurally unsayable.
  - depends on: STEP 2 eq leaf (landed); STEP 0/1 repr word-leaf.
  - SOTA: Derivable Ord/Hash; eq/hash coherence
- **Hβ.eq.fold-seed-value-gate** — The seed-runnable value gate exercising the NEW deep fold path (structural-eq over every ADT to the bottom); round-trip where the seed can run it, structural otherwise. Law-7: each fold leaf earns its gate.
  - depends on: STEP 2 eq leaf (landed); the fold-leaf families.
- **Hβ.repr.arrow-layout-interop** — Realize repr_of → RI32|RI64|RF64|RF32|RV128 to MATCH Arrow/Polars primitive widths so a Mentl sequence IS an Arrow buffer — 'one sequence type, many element types' testable by zero-copy interop. STEP 1 landed the gradient (2cf717b).
  - depends on: first-light; STEP 1 representation gradient (landed).
  - SOTA: Apache Arrow (McKinney 2016) / Polars / DuckDB
- **Hβ.emit.variant-payload-repr-width** — Migrate ADT variant payloads from i32-width to the width-summed product layout (unboxed f64 payload) — the coordinated store + eq-read + match-bind migration threading each field's repr through the pattern-walk (emit_load_chain carries no per-step width today; store-only = Law-7 miscompile). wasm.mn:4672.
  - depends on: first-light; STEP 1 representation gradient (records, landed).
  - SOTA: OCaml boxed-float disease (the peer this makes unsayable)
- **Hβ.emit.plit-handle-repr** — Thread the pattern-literal (LPLit) operand handle (wasm.mn:5296) so a pinned-f32 literal compares at f32 width in match exactly as in expression position — a coherence-completeness peer, not a present miscompile.
  - depends on: first-light; STEP 1 representation gradient.
- **Hβ.value.ontology-derivation-complete** — The value-ontology derivation completed to the bottom — five node-kinds, everything else a view; the residual primitive-special-case audited to a view (largely landed via STEP 1/2; a post-first-light audit toward fewer axioms, identical reach).
  - depends on: STEP 1 representation gradient (landed); first-light.
  - SOTA: Arrow/Polars/DuckDB
- **Hβ.runtime.zero-copy-string-view** — Represent TStringPart payload as (offset,length) into source (lexer.mn:316) rather than slice-allocating each chunk — O(1) per chunk over the [-1][buf][start][len] view substrate, eliminating O(N) heap pressure.
  - depends on: first-light; the view substrate (PLAN §6).
  - SOTA: Rust &str slices / Arrow string views
- **Hμ.lib.float-family-home** — Relocate the float_* arithmetic family from strings.mn to math.mn, flipping the import direction (strings.mn's float_to_str internals grew it there).
  - depends on: first-light; the f64 representation gradient (STEP 1, landed).


## Parallelism & accelerators (arm 3, §4④)

_<| and >< are two surfaces of ONE PFanout topology read through ownership; STEP 4 collapsed them and DELETED the hardwired Thread injection (600bc88). Concurrent execution is a ~> Schedule handler choice (Seq|Thread|Simd|Gpu, an ADT). SPACE (threads), distribute (mesh), and TIME (durable resume) are ONE substrate distinguished only by the catching handler. !Thread/!Alloc transitivity is the most differentiating claim and the one most likely to harbor an unsound row leak — verify ONLY after the higher-order leak closes._

- **Hβ.lower.fanout-simd-lane-cashout** — ~> Simd cashes a [f32;4] branch tuple to a v128 lane (repr_of→RV128) — vectorization is a WIDTH cash-out of the same fanout the threads use, not a separate vectorizer. Verify STEP 1's repr composes with STEP 4's PFanout.
  - depends on: first-light; STEP 1 repr v128 (landed); STEP 4 PFanout collapse (landed).
  - SOTA: Halide/TVM vectorize schedules; no system unifies SIMD-as-repr with threading-as-fanout
- **Hβ.lower.fanout-gpu-backend-handler** — ~> Gpu Schedule handler ships a PFanout branch thunk to a device — the backend IS the handler, the verb stays pure topology; tile/lane width rides the SAME repr gradient. Code anchor Hβ.lower.fanout-gpu-host-import (lower.mn:1475): bind a host gpu-dispatch import carrying thunks as the kernel grid (a transport binding, not a Mentl gap).
  - depends on: first-light; STEP 4 PFanout collapse (landed); STEP 1 repr gradient; native/GPU infra.
  - SOTA: Triton/TileLang/CUDA-Tile-IR; JAX Pallas; Halide algorithm/schedule separation
- **Hβ.lower.fanout-durable-persist-handler** — Verify the distributed ~> Schedule, the ~> persist crash-survival handler, and thread/distribute handlers are genuinely ONE substrate (the SAME install edge) — SPACE, distributed, and TIME distinguished only by the catching handler. lower.mn:1480; persist.mn:119. Folds into Hβ.continuations.persist-equals-memcpy-handler.
  - depends on: first-light; STEP 3 persist (landed); STEP 5 TCont world.
  - SOTA: JAX shard_map; the cloud durable-execution + GPU fields reinventing each other's serializers
- **Hβ.parallel.thread-alloc-transitive-proof** — Verify !Thread/!Alloc for real-time regions is transitive through the call graph AND through ~> (the §4③ leak risk). The most differentiating claim (Rayon/Faust/JAX cannot STATE it) — treat with the same suspicion as !E-under-poly.
  - depends on: Hβ.effects.sound-neg-under-poly (closes the positive leak); first-light.
  - SOTA: Rayon/Faust/Lustre cannot state this; !E at the concurrency layer (PLAN §0's most underrated arm)
- **Hβ.parallel.race-freedom-ownership-proof** — Verify <|'s read-only borrow ⇒ race-free and >< shares nothing ⇒ race-free, discharged through use-count inference (NOT a separate mode-axis). Adversarially check the borrow survives a higher-order branch closure escaping (where à-la-Mode needed the Capsule). Verify inf_add_row(Thread) is truly gone (STEP 4).
  - depends on: first-light; STEP 4 collapse + Thread-injection deletion (landed); Hβ.ownership soundness.
  - SOTA: OxCaml 'Data Race Freedom à la Mode' POPL 2025 (Iris/Rocq Capsule); Cilk/Cilksan (dynamic) vs Mentl static
- **Hβ.infer.fanout-ownership-from-use-count** — Derive the <| share vs >< own reading from branch-input use-count (the 0/1/2+ inference) and project the glyph at fmt: own through <| → E_OwnershipViolation; a shared input under >< → fmt-canonicalizes to <|. infer.mn:1228 — net-new ownership-checks-coherence pass, NOT folded into the PFanout collapse.
  - depends on: first-light; STEP 4 PFanout collapse (landed).
  - SOTA: Rust ownership (no effect row); Hylo MVS
- **Hβ.runtime.wasi-thread-spawn-seed** — Bootstrap-side substrate importing wasi_thread_spawn + per-thread bump-arena partition + thread-record allocation. Stages landed; Stage 3 is emit-side recognition bridging wasi_thread_spawn_intrinsic to the $wasi_thread_spawn import. threading.mn:296.
  - depends on: first-light; the wasi_threads handler (present).
  - SOTA: Rayon/Faust (cannot state !Thread)
- **Hβ.driver.level-set-par-walk** — Kahn-style topological levels in driver (driver.mn:247): same-level modules parallel_map, cross-level sequential — the compiler itself as parallel cursors on the shared graph. Felt-tier projection: Hμ.driver.topological-layer-par-map.
  - depends on: first-light; Hβ.runtime.wasi-thread-spawn-seed.
- **Hβ.cursor.speculative-compile** — Multi-shot dispatched spatially: Synth's MultiShot proposer captures the cursor at 'what type for this hole?'; per-candidate compile runs on different cores; results bubble back as gradient suggestions with Reason chains. The oracle fusing TIME (fork) and SPACE (threads). threading.mn:198; mentl.mn:232.
  - depends on: first-light; multi-shot continuation producer; wasi-threads.
- **Hβ.cursor.work-stealing-via-gradient** — When N cores ask 'what next?', the cursor's gradient returns argmax — the gradient IS the priority queue, no scheduler module. threading.mn:195; cursor.mn:627.
  - depends on: first-light; speculative-compile; the gradient projection.


## Verification & proof (arm 6/8, §5 unsurpassable)

_Verify→SMT as a handler swap (same source, deeper proof engine), the V_Pending ledger made SOUND (never a silent assume-true), higher-order/modular refinement, proof incrementality via the cached cursor, and the Reason chain as a re-checkable proof-carrying certificate. predicate-is-Expr dissolves the parallel PExpr ADT so Verify reads the live Expr._

- **Hβ.verify.smt-handler-swap** — The Verify→SMT swap (Arc F.1): keep the DEFAULT in decidable QF-UFLIA+arrays/datatypes, target Z3 AND CVC5, reserve undecidable reasoning for an explicit deeper handler. V_Pending→SMT discharge STABLE; a timeout = tracked debt + a Why explanation, never a hard fail. Code anchor Hβ.verify.verify-smt-discharge (feedback.mn:200, types.mn:1031). HONEST FRONTIER: does this rely on external Z3/CVC5, an !Outside one layer down?
  - depends on: first-light; the verify_ledger default handler (present); Hβ.types.predicate-is-expr.
  - SOTA: Liquid Haskell / Flux / Dafny (Z3); CVC5; SMT-brittleness as the field's open wound
- **Hβ.types.predicate-is-expr** — Dissolve node_to_pexpr (Expr→PExpr, a parallel ADT re-deriving the predicate the graph holds as an Expr). A refinement predicate becomes a refined Expr; Verify reads the Expr directly. A Carried-Truth violation at the representation layer, deleted; enables the SMT handler to read the live Expr.
  - depends on: first-light (not the blocker).
  - SOTA: Liquid Haskell / Flux {v:T|p} side-DSL — Mentl puts the predicate in the one graph
- **Hβ.verify.ledger-soundness** — Discharge V_Pending soundness: an undischarged obligation must become EITHER a sound runtime check at the static/dynamic boundary OR principled tracked DEBT — NEVER a silent assume-true (Dafny {:axiom}/F* admit are the cautionary holes).
  - depends on: first-light.
  - SOTA: Wise et al. 'Sound Gradual Verification / Gradual C0' OOPSLA 2020→TOPLAS 2025; Lehmann-Tanter POPL 2017
- **Hβ.verify.higher-order-refinement** — Modular/higher-order refinement: predicate-is-Expr composes through <|/></~> and abstracts over a function's contract passed higher-order (a refined Expr surviving a handler and a fanout without re-deriving its predicate) — the modal-effect frontier at the refinement layer.
  - depends on: first-light; Hβ.types.predicate-is-expr.
  - SOTA: Generic Refinement Types — Lehmann/Kurashige/Jhala POPL 2025
- **Hβ.verify.proof-incrementality-cached-cursor** — Proof incrementality via the cached/epoch-versioned cursor: re-project only a delta'd Verify obligation. Cache-invalidation SOUNDNESS proven: a changed node invalidates EXACTLY the obligations whose witness depended on it (trail-backed, no stale-proof leak).
  - depends on: first-light; the IC/cached-cursor.
  - SOTA: the field re-verifies whole functions; DBSP incremental view maintenance as the correctness criterion
- **Hβ.verify.reason-edge-pcc-certificate** — Make the Reason chain on a discharged Verify obligation an independently re-checkable proof-carrying-code certificate (a live graph edge): the kernel re-verifies a claimed witness, so an AI-proposed proof survives checkpoint→infer→Verify→rollback. §1's !Outside at the proof layer.
  - depends on: first-light; the Synth handler architecture.
  - SOTA: Necula PCC (1997); 'Proof-Carrying Neuro-Symbolic Code' arXiv 2504.12031; AutoVerus/Goedel-Prover
- **Hβ.dsp.hz-ceiling-ambient-sample-rate** — Dependent refinement on the ambient Sample(rate) effect for the Hz Nyquist ceiling (feedback.mn:64, hard-coded 22050 today; the dependent form ceiling=rate/2 is significant substrate work).
  - depends on: first-light; parameterized-effect refinement; verify_smt.
- **Hβ.refine.buffer-invariant** — Refinement invariant over the runtime buffer substrate (capacity/length bounds proven rather than runtime-checked). buffer.mn:130.
  - depends on: first-light; refinement discharge.
- **Hβ.parser.refinement-typed-binop-param** — Refinement-typed parameter fn op_to_binop(k)->BinOp where is_binop_token(k) (parser.mn:238) — exercises primitive #6 and eliminates the Option return (the proof narrows the input so every token is a binop).
  - depends on: first-light; refinement narrowing on parameters; verify discharge.
- **Hβ.infer.predicate-from-bool-expression** — Full case enumeration converting boolean expressions (BinOpExpr ==,<,>,&&,||; CallExpr predicates) into Predicate ADT instances (infer.mn:3423 returns the PBoolNode stub today).
  - depends on: first-light; refinement narrowing.
- **Hβ.voice.path-project-sandbox-refinement** — Path gains a where clause (no .., resolved, within project root) when the project-sandbox handler lands (voice.mn:222) — a refinement-ready alias today without predicate.
  - depends on: first-light; project-sandbox handler; verify_smt.
  - SOTA: capability-security (ocap)


## Graph & e-graph (arm 1, effect-aware equality saturation)

_The e-graph (AST itself IS the e-graph; congruence dissolves into chase-to-canonical) is LIVE in lower. The highest-leverage incompleteness: per-expr effect-row binding so is_pure reduces to effs_at alone, generalizing effect-gating to EVERY future rewrite — effect-gated equality saturation is an intersection no e-graph engine has. Plus a typed cyclic-rule error, rules-as-queries when count scales, and a sharing/effect/repr-aware extraction cost order._

- **Hβ.egraph.per-expr-effect-row** — Close per-expr effect-row binding in infer (egraph.mn:70) so is_pure reduces to effs_at ALONE (today it conjoins a body-form check because rows bind per-frame). Generalizes effect-gating to every future rewrite (reorder, CSE-across-effectful-boundaries, dead-handler-elimination). The single highest-leverage graph incompleteness.
  - depends on: first-light; per-expr effect-row binding in infer.
  - SOTA: egg POPL 2021 / egglog PLDI 2023 (syntactic + hand-drawn 'pure' allowlist); colored e-graphs/EMT
- **Hβ.lower.egraph-saturation-deepen** — Deepen the already-live e-graph arm: richer effect-aware rewrite rules / extraction cost models (a sixth structural operation is another leaf, a better canonicalization a deeper arm).
  - depends on: first-light; the e-graph live (landed).
  - SOTA: egg / egglog / Adapton
- **Hβ.egraph.typed-rulecyclic** — Make the depth-1000 saturation cap unreachable-by-construction: a malformed rule set drawing a cycle is a typed E_RuleSetCyclic via the Why chain, NOT a silent fallback. Confirm graph_canon_set's 'from points at strictly-cheaper to' is a well-founded order witness.
  - depends on: first-light; the e-graph engine.
  - SOTA: egglog 'Better Together' PLDI 2023 (semilattice merge for monotone convergence)
- **Hβ.egraph.rule-as-query** — When rules grow beyond ~6, make rewrite rules QUERIES over the graph (query.mn already exists) so e-matching IS a project — keeping 'no second mechanism' as rule count scales.
  - depends on: first-light; src/query.mn.
  - SOTA: Relational e-matching — Zhang/Wang/Willsey/Tatlock POPL 2022 (worst-case-optimal join)
- **Hβ.egraph.extraction-cost-composes-repr** — Confirm graph_canon_set's cheapness metric is the TRUE cost order (sharing-aware AND effect-aware AND composing with the §5.U representation gradient — a v128-lane'd or memcpy-serializable form may be 'cheaper'), else Mentl reintroduces the NP-hard extraction gap it claims to dissolve.
  - depends on: first-light; STEP 1 representation gradient.
  - SOTA: 'Fast and Optimal Extraction for Sparse Equality Graphs' OOPSLA 2024; e-boost; Tensat ILP
- **Hβ.egraph.const-fold-minted-node-full-edges** — The const-folding fold_int rule MINTS a node (the single exception to 'no node creation') — verify every minted literal gets the FULL edge set (type-bound, Reason, effect row) and is registered in the weave, or it is NFree at lower. A Carried-Truth audit on the one node-minting rule.
  - depends on: first-light; the e-graph engine.
  - SOTA: Carried-Truth hazard (Mentl-internal soundness)


## Ownership (arm 5, §4⑤)

_Ownership is interrogation #5, never an eighth subsystem. Discharge ref-borrow soundness against Granule's fractional uniqueness, and verify the Hylo-quiet bar empirically — a rising count of authored own/ref markers IS inference failing. Ownership-as-effect inherits the EfNeg-under-instantiation unsoundness, so it gates on the effects crown._

- **Hβ.ownership.fractional-uniqueness-ref-borrow** — Discharge ref-borrow soundness against Granule's Fractional Uniqueness (uniqueness-AND-borrowing as ONE fractional algebra). Mentl's 'ref is just a !Mutate row constraint' must discharge the same theorems; if the Boolean row can't express fractional/recombining borrows, surface that as a named gap. Adversarially check the borrow survives a higher-order branch closure escaping.
  - depends on: first-light; Hβ.effects.sound-neg-under-poly (ownership-as-effect inherits the unsoundness).
  - SOTA: Granule 'Functional Ownership through Fractional Uniqueness' ICFP 2024; OxCaml Capsule POPL 2025
- **Hβ.ownership.quiet-empirical-gate** — A corpus test counting authored own/ref markers in real .mn programs — a rising count IS inference failing the §4⑤ measured invariant. Adopt Mojo's ASAP/last-use dataflow as the use-count read for 'own performs Consume'. Resist any SECOND structure (lifetime ledger, region annotation).
  - depends on: first-light; the use-graph the cursor already holds.
  - SOTA: Hylo/Val mutable value semantics (IWACO 2023); Mojo ASAP destructors


## Dataflow & DSP (arm 3/6)

_The synchronous-language lessons: a <~ feedback loop is well-formed only if it crosses a unit delay (an instantaneous algebraic loop is a COMPILE ERROR), distinct sample-rates can't silently interoperate (clock calculus), and the <~ recurrence lowers to a register-read + inlined body (no per-tick alloc) so a !Alloc real-time region compiles to a Faust/Lustre-grade static loop. Faust's whole-diagram fusion is recovered via the effect-aware e-graph._

- **Hβ.dataflow.causality-compile-error** — Enforce: a <~ loop must cross a unit delay; an instantaneous algebraic loop is a COMPILE ERROR, not a runtime hang. Verify the causality check is real and transitive (matches Faust's z⁻¹) and the recurrence lowers to a register read + inlined body. Code anchor Hβ.emit.feedback-prior-source-binding (wasm.mn:2344) names the $__fb_prev_<h> prior local.
  - depends on: first-light; STEP 1 repr gradient (unboxed f64 for the no-alloc loop).
  - SOTA: Lustre/Esterel/SCADE clock calculus + causality (Caspi/Halbwachs); Zélus HSCC 2013
- **Hβ.dataflow.clock-calculus-sample-rate** — Clock-SAFETY at the type level: Sample(44100) and Sample(48000) cannot silently interoperate — multi-rate connection without an explicit resampling bridge is a type error (SYNTAX.md's 'explicit handler bridge' must enforce it).
  - depends on: first-light; the parameterized-effect machinery.
  - SOTA: Rhine type-level clocks (Bärenz & Perez, Haskell Symposium 2018); Lustre clock calculus
- **Hβ.dataflow.point-free-fusion-via-egraph** — Recover Faust's whole-diagram global fusion (the payoff of the point-free form Mentl gave up for named values) via the effect-aware e-graph: constant-folding through |> chains, delay-line sharing across <~.
  - depends on: first-light; Hβ.egraph.per-expr-effect-row (effect-aware fusion).
  - SOTA: Faust block-diagram global optimization; categorical signal-flow (Bonchi/Sobociński/Zanasi POPL 2015)


## Self-hosting & !Outside hardening (L7, §1)

_The fixed point m_n==m_{n+1} proves self-reproduction but NOT trusting-trust-freedom and NOT semantic correctness — both are residual !Outsides. Diverse double-compilation closes the provenance attack; internalizing the correctness oracle (the external micro battery → the wheel's own Verify proofs) closes the semantic one; the reflexive closure over proposers makes a stronger external intelligence strengthen, never surpass, the medium._

- **Hβ.closure.diverse-double-compilation** — Compile the wheel with an INDEPENDENT compiler/backend and verify byte-identical output — closes Thompson's trusting-trust (a self-propagating backdoor reproduces itself too). The disposable-seed design already permits a second seed. Alias: Hβ.outside.diverse-double-compilation.
  - depends on: first-light (m3==m4 must land first); an independent backend (Hβ.backend.native-codegen-handler as the diverse compiler).
  - SOTA: Thompson 'Reflections on Trusting Trust' (1984); Wheeler Diverse Double-Compilation (2005/2009)
- **Hβ.closure.correctness-oracle-internal** — Internalize the correctness oracle: first-light's correctness half (micros + repro) is an EXTERNAL battery — a hidden !Outside like CakeML's HOL4. The ultimate form makes correctness a Verify projection of the wheel's own source (the §7 registry discharged). HONEST SUB-FRONTIER: does Verify→SMT rely on external Z3/CVC5, an !Outside one layer down? Alias: Hβ.outside.internalized-correctness-oracle.
  - depends on: first-light; Hβ.verify.smt-handler-swap (and its external-SMT honesty); Hβ.audit.carried-truth-projection.
  - SOTA: CakeML verified self-hosting (Kumar/Myreen/Owens/Tan) — proof in HOL4 (the !Outside to BEAT)
- **Hβ.closure.reflexive-over-proposers** — The reflexive closure held over its own proposers: any external intelligence (enumerative, SMT, model, prover) plugs in as a Synth handler whose candidates MUST survive checkpoint→infer→Verify→rollback; a stronger proposer strengthens the medium and can NEVER surpass it. Code-level pipeline: Hβ.synth.proposer-gauntlet — the proposer-survives-the-gauntlet loop the substrate (trail/rollback) already supports.
  - depends on: first-light; multi-shot trail-checkpoint/rollback (built); Hβ.verify.smt-handler-swap; Hβ.infer.synth.
  - SOTA: Oracular Programming arXiv 2502.05310 (the nearest convergence, as a library not a closed kernel); AlphaProof


## AI-proposer / Synth (arm 2, §0/§1)

_The verification-substrate-for-the-machine-code-age made real: the unit of conversation is the CONSTRAINT (lossless, monotone, compounding), not the token. A refinement type + effect row + Reason edge is a spec that needs no separate faithfulness judge because it is a graph fact verified in the same kernel — directly answering the spec-validation oracle problem the field is stuck on._

- **Hβ.proposer.constraint-not-token-worked-example** — Demonstrate constraint-not-token with a WORKED example: a refinement type + effect row + Reason edge is a spec verified in the same kernel, no separate judge — answering the spec-validation oracle problem ('no oracle but the user'; LLM-judge misses ~26% of unfaithful specs). The strongest empirical claim for the §0 reframe; DEMONSTRATE, don't assert.
  - depends on: first-light; refinement + effect-row + Reason machinery.
  - SOTA: Intent Formalization (Lahiri et al., Microsoft, arXiv 2603.17150, 2026)
- **Hβ.proposer.synth-handler-error-fed-back** — The canonical Synth-handler shape: rollback carries the Located Reason chain back to the Synth handler as the proposal-refinement signal — the CONSTRAINT (lossless), not a token (lossy), is fed back. The field converges on 'verifier's error → proposer's next-turn context'; Mentl's loop is lossless where theirs is lossy.
  - depends on: first-light; the checkpoint→infer→Verify→rollback substrate.
  - SOTA: AlphaProof Nexus (DeepMind 2026); Baldur (First et al. 2023); Lean Copilot


## The why-engine & mentl audit (arm 8/1, §0)

_The §0 keystone: the medium making the wrong move UNSAYABLE. mentl audit projects a Carried-Truth violation before a line is written (docs:Claude :: language:developer :: human:mentl audit collapse into one). The Why engine computes the MINIMAL inconsistent core by PROOF, structurally surpassing statistical blame. Diagnostics become a projection of types.mn, not a hand-maintained registry._

- **Hβ.audit.carried-truth-projection** — mentl audit made REAL: project a Carried-Truth violation (the §7 registry trap — a fact computed/copied/snapshotted/re-derived where it could be read live) BEFORE a line is written, making the wrong move UNSAYABLE. Today YOU are mentl audit by hand; drift-audit.sh (a bash hook) dissolves at L1. NEWLY NAMED (critic) — the §0 keystone, the reason to get the medium real.
  - depends on: first-light; the graph fabric queryable (AST-in-graph, landed); Reason edges live.
  - SOTA: egg/egglog congruence (re-derivation detection structurally); Rust clippy as the lower-bar precedent
- **Hβ.diag.minimal-inconsistent-core** — Make blame PROVEN not learned: compute the minimal inconsistent core + the actual information-flow path as a graph walk (every constraint edge carries its justification), surpassing Learning-to-Blame's statistical prediction. Verify the Reason chain pins the causal SOURCE node, not the unification-collision point (adversarially test GADT/local-equality blame, higher-rank boundaries, a distant higher-order effect-row inconsistency — §4③'s leak). Alias: Hβ.why.minimal-cause-set.
  - depends on: first-light; the Reason-per-edge provenance.
  - SOTA: 'Learning to Blame' (Seidel et al. OOPSLA 2017); 'Getting into the Flow' arXiv 2402.12637; Type Inference Logics OOPSLA 2024
- **Hβ.infer.marked-lambda-totality-invariant** — State and verify the marked-lambda-calculus TOTALITY guarantee ('no meaningless graph states'): every source program maps to a total well-typed graph where every ill-typed node is a marked hole. Verify NErrorHole/_-hole recovery achieves totality end-to-end.
  - depends on: first-light; productive-under-error inference.
  - SOTA: Marked Lambda Calculus — Zhao/Omar et al. POPL 2024 (Distinguished, Agda-mechanized); Hazel
- **Hβ.diag.catalog-as-projection** — Relocate diagnostic IDENTITY fully onto the DiagKind ADT — report takes a DiagKind (not strings); the three SYNTAX.md tables become a READ of types.mn. Keep Applicability four-valued (convergent with Rust's enum). A Quick Fix is literally draw-an-edge then re-project (the IC <~ accumulate(graph) loop). Audit infer.mn for any SECOND provenance structure beside the Reason-edge.
  - depends on: first-light; the DiagKind ADT in types.mn; the Reason-edge fabric (live).
  - SOTA: Rust Diagnostic + Applicability enum + cargo fix (a parallel registry — the Carried-Truth violation Mentl forbids)
- **Hβ.query.graph-projection-surface** — The graph made QUERYABLE as a first-class projection for human + tooling oversight: mentl where/query over the typed-effect-Reason graph. QFlowOf + the query-grammar ADT landed in code (W29/W31); no peer named the query SURFACE's completion. NEWLY NAMED (critic) — substrate for the dashboard and mentl audit.
  - depends on: first-light; the graph fabric (landed); Reason edges.
  - SOTA: salsa query-keys; egglog Datalog-over-egraph; CodeQL graph queries


## The felt surface / mentl edit (L6, §4⑦, §0 point 5)

_Legibility is a SURVIVAL requirement for oversight of autonomous AI-authored systems, not Stage-3 garnish. Reactivity = incremental compilation = editor-reprojection are ONE engine (the cached cursor's <~). The felt surface falls out as PROJECTIONS derived from the eight cursor-aspects — zero hand-authoring. mentl edit is the canonical IDE; LSP/browser/nvim are peer transports through the same format_default handler._

- **Hβ.felt.mentl-edit-runtime** — The canonical IDE as a RUNNING app: keystroke → tokenize → parse-to-graph → format_default → render, continuously, so the developer never sees unformatted code. The browser-playground emit exists; the editing-LOOP runtime composing parse/format/IC/render into one live surface does not. NEWLY NAMED (critic) — the founding payoff.
  - depends on: first-light; the browser-playground emit; Hβ.felt.reactive-reprojection; the Format handler.
  - SOTA: Hazel live-functional-programming; MPS projectional editor
- **Hβ.felt.reactivity-typed-demand-driven** — Verify reactivity = incremental compile = editor-reprojection are ONE engine (the cached cursor re-projecting on graph-delta), demand-driven and glitch-free — then SURPASS signals by TYPING the dependency edges (signals' untracked $effect escapes become typed effect rows). Audit that no separate 'reactivity subsystem' exists. Alias: Hβ.felt.reactive-reprojection.
  - depends on: first-light; the IC/cached-cursor; the e-graph.
  - SOTA: SolidJS / Svelte 5 Runes / TC39 Signals; Adapton PLDI 2014; 'Incremental Live Programming' arXiv 2603.19560
- **Hβ.felt.lsp-transport-projection** — The LSP server for external editors as a ~> format_default-PEER transport: format-on-save, hover-as-mentl-where, code-action-as-Quick-Fix-edge, all projecting the one typed-effect-Reason graph. lsp.mn exists as a FILE but carries no completion peer. NEWLY NAMED (critic).
  - depends on: first-light; the Format handler; Hβ.diag.catalog-as-projection; IC cached cursor.
  - SOTA: LSP; rust-analyzer salsa-incremental; the felt-field's per-surface untyped-graph regret
- **Hβ.felt.collab-grove-cmrdt-semantic** — Model mentl edit collaboration as commuting edge insert/delete on the labeled typed graph (a CmRDT) with unique handle-ids — multi-cursor merge structurally FREE (Grove's result) — then EXTEND past Grove by reconciling the typed/effect/PROOF consequences of concurrent edits (Grove stops at syntax). The SPACE axis at the human boundary. Aliases: Hβ.felt.collab-shared-cursor, Hμ.collab.shared-graph-handler.
  - depends on: first-light; the typed-effect-Reason graph; the cached/shared cursor; the shared-memory substrate.
  - SOTA: Grove — Omar et al. POPL 2025 (CmRDT over labeled multigraph)
- **Hβ.felt.legibility-derived-not-molded** — mentl where/why as Glamorous Toolkit-level explorability with ZERO hand-authoring: DERIVE each contextual projection from the eight cursor-aspects of the typed Reason graph (GT molds tools by hand), plus a why-chain GT cannot offer (its image is untyped). Project a system's truth + Reason chain at ANY cursor, including self-modifying/autonomous handlers — the oversight survival requirement.
  - depends on: first-light; the eight-aspect cursor projection over the typed Reason graph.
  - SOTA: Glamorous Toolkit / Moldable Development (Gîrba, feenk)
- **Hβ.felt.verification-dashboard** — The L6 verification dashboard projecting the medium's LIVE proof state for oversight: the V_Pending ledger, discharged refinement obligations, the effect-row guarantees (!Alloc/!Network proven transitively), the Why chain — at any point. NEWLY NAMED (critic) — §0 point 5, a survival requirement.
  - depends on: first-light; Hβ.verify.smt-handler-swap (V_Pending ledger); Hβ.diag.minimal-inconsistent-core; Hβ.query.graph-projection-surface.
  - SOTA: Dafny/F* proof-obligation IDE panels; Liquid Haskell counterexample surfacing
- **Hβ.felt.hole-is-dormant-continuation** — A ?? hole is a DORMANT multi-shot continuation awaiting its filling, so a holed program RUNS — across effects, handlers, and persisted continuations (past Hazel's pure-setting limit); a Synth proposal resumes it. Confirm _/?? holes carry type + effect row + ownership + Reason. Alias: Hβ.synth.hole-as-dormant-continuation. A genuine novel-leap.
  - depends on: first-light; the multi-shot continuation record (STEP 3); the gradient at ??.
  - SOTA: Hazel 'Live Functional Programming with Typed Holes' ICFP 2019 (fill-and-resume)
- **Hμ.cursor.transport.suite** — The cursor transport adapters projecting the one kernel to many surfaces: patch-to-file (main.mn:232, full filesystem rewrite vs today's patch_echo), browser-wasm (main.mn:237), web-dom-wire (cursor_transport.mn:210), nvim-rpc-wire (cursor_transport.mn:211), plus the host-boundary wires process-exec (Hβ.cli.process-exec-wire, main.mn:335), repl line-read (Hβ.repl.line-read-wire, main.mn:548) — peers of the format_default projection.
  - depends on: first-light; the cursor session loop (present); the LSP transport.
  - SOTA: LSP; the DX vision's three transports (CLI/web/editor)


## Backends — the handler IS the backend (projected cursor, §5 stage 3)

_infer/lower/emit/native/GPU is the projected cursor — each aspect → a target token. Native (and GPU) codegen as handler swaps retire the external runtime/assembler (wasmtime, WABT) dependency; the arc to native is !Outside. The memory strategy (bump/arena/GC) and the substrate width (wasm32/wasm64) are equally handler/gradient swaps over the same allocation sites and the same handles._

- **Hβ.backend.native-codegen-handler** — Native (and GPU) code backends as handler swaps — retire wasmtime/WABT; each backend aspect projects a target token. The arc to native is !Outside (§5 stage 3), the deepest move within the medium. Also the diverse compiler for double-compilation.
  - depends on: first-light (self-hosting on WASM substrate first); the lower→target projection.
  - SOTA: LLVM/Cranelift native codegen; the handler-as-backend converges the projected-cursor table
- **Hβ.native.wasm64-backend-handler** — wasm64 / i64-NaN-box sibling backend as a handler swap — the representation gradient at the substrate-WIDTH altitude (handles widen to 64-bit; i64 NaN-boxing for the float gradient's deeper cash-out). NEWLY NAMED (critic) — named in MEMORY but not as a read-path peer.
  - depends on: first-light; Hβ.backend.native-codegen-handler; repr gradient (STEP 1, RI64 arm).
  - SOTA: wasm64/memory64 proposal; OCaml boxed-float disease (the anti-pattern the gradient avoids)
- **Hβ.emit.memory-gc-handler** — A full garbage collector with header tags as a memory-strategy handler swap (peer of emit_memory_bump/emit_memory_arena, wasm.mn:94) — DESIGN 7.3 'the handler IS the backend' extended to memory strategy without disturbing closure layout or any allocation site. Pairs with Hβ.emit.cas-alloc-init-in-start (wasm.mn:160, the shared-memory CAS bump allocator _start preamble) and Hβ.emit.static-data-segment-literal-list-fold (wasm.mn:5330, fold a pure-literal list under !Alloc into a static segment).
  - depends on: first-light; the emit_alloc handler-swap substrate (landed); !Alloc row inference.


## Self-hosting infrastructure: seed catch-up, cross-file cache, driver, doc/test (out-of-read-path durable record)

_The non-read-path remainder that first-light's focus must not erase: the seed-lag gates (resolve AT first-light by seed dissolution), the cross-file cache trio (resolved-row packing — single-file first-light never round-trips it), per-module env overlay, and the doc/test handler substrates. Captured as positive-form peers so the live gates and host boundaries are not forgotten._

- **Hβ.seed.float-gradient** — Seed-lag gate: mn-float-arith needs the wheel's f64 emit (exit 3); the seed still floors LFloat to i32 (exit 0). The .mn leads, the seed catches up; resolves AT first-light (seed dissolution). Captured so it is not forgotten as a live gate.
  - depends on: Resolves BY first-light (the wheel's f64 emit is the one that compiles it).
- **Hβ.seed.multishot-producer** — Seed-lag gate: mn-multishot needs the LMakeContinuation producer in the compiler that compiles it (exit 30); the seed lowers OneShot (exit 10). STEP 3 producer landed in the wheel; the seed lags. Resolves AT first-light.
  - depends on: Resolves BY first-light (seed dissolution); STEP 3 producer (landed).
  - SOTA: Effekt ICFP-2025 (multiple resumptions + local state)
- **Hβ.cache.cross-file-resolved-row** — Cross-compile caching must pack the RESOLVED effect row, not the graph-relative handle (cache.mn:201); handler config/state/arms reconstructed from source on unpack (cache.mn:210); parameter defaults reconstructed from source (cache.mn:790). First-light is single-file and never round-trips these. Unifies Hβ.cache.handler-residual-row + handler-decl-from-source + param-default-from-source.
  - depends on: first-light (single-file) closed; cross-file/multi-module compilation path active.
- **Hβ.driver.per-module-env-overlay** — Per-module env overlay the driver populates (IC.3 chase; infer.mn:757, main.mn:503) — the env layering that user-defined-entry-handler-resolution and cross-module lookup read live. Pairs with Hβ.cli.user-defined-entry-handler-resolution (main.mn:503: mentl --with <handler> installs an arbitrary entry handler via env_lookup, the SAME mechanism every built-in verb uses).
  - depends on: first-light; multi-module compilation.
- **Hβ.f1.handler-substrates** — The F.1 projection handlers: doc_handler + lib/doc/ chunks (main.mn:298, today routed through mentl_default+diagnostics), the Test effect handler chain (main.mn:422, assert/assert_eq/assert_near via assert_reporter + verify_assert lifting), and per-thread test output buffering (lib/test.mn:46) so concurrent tests have a sequential surface.
  - depends on: first-light; Verify effect; parallel_map/wasi-threads.
  - SOTA: cargo test (parallel harness)


## Newly named by the completeness critic (no prior source named these)

- Hβ.audit.carried-truth-projection — mentl audit made real: project a Carried-Truth violation BEFORE a line is written, making the wrong move unsayable (the §0 keystone; no source named it)
- Hβ.infer.modal-capability-at-tee — the modal typing rule itself: a row variable becomes a lexical capability handle at the existing ~> install edge (distinct from the world-index; no source named the install-edge rule)
- Hβ.felt.lsp-transport-projection — the LSP server completion as a format_default-peer transport (lsp.mn exists in code with no completion peer)
- Hβ.felt.mentl-edit-runtime — the canonical IDE as a running keystroke→parse→format→render loop (the browser-playground emit exists, the editing-loop runtime does not)
- Hβ.felt.verification-dashboard — the L6 dashboard projecting live proof state (V_Pending, transitive !E guarantees, Why chain) for oversight
- Hβ.query.graph-projection-surface — mentl where/query as a first-class queryable projection over the typed-effect-Reason graph (QFlowOf landed in code; the surface completion is named nowhere)
- Hβ.felt.time-travel-debug-forked-cursor — step-back/replay debugging as a forked cursor over the trail-checkpointed graph (implied by TIME-axis multi-shot, named nowhere)
- Hβ.persist.cross-machine-resume — distributed durable execution: a continuation memcpy'd and resumed on a different node with a cross-boundary world-mismatch check (local persist peers exist; cross-machine does not)
- Hβ.native.wasm64-backend-handler — wasm64/i64-NaN-box sibling backend as the substrate-width handler swap (named in MEMORY, not as a read-path peer)