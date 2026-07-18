# ARCHAEOLOGY — Codex's PLAN.md rewrite proposal (2026-07-17, NOT ADOPTED)

> **This is not the plan. It is a wholesale-rewrite PROPOSAL** Codex produced on
> 2026-07-17, reviewed and NOT adopted as `PLAN.md` — it deleted the earned
> §0 north star (Mentl as humanity's verification substrate for the machine-code
> age) and the kernel's own defining language (`one graph, two operations`,
> `!Outside`, the eight arms, the Carried-Truth *Law*), and it presents an
> evolved architecture (ProjectImage / ControlEdge / evidence-DAG /
> capability-registry / commit-transaction) as settled fact rather than a
> proposal. The three-doc contract's `PLAN.md` was restored.
>
> **What WAS salvaged into the real `PLAN.md` §7** (the honest de-hyping this
> proposal got right): the "claims currently false" corrections and the
> capability real/partial/absent audit. **What survives HERE to interrogate on
> its own merits, later:** the ProjectImage + transaction/speculation model (a
> Salsa-like immutable-revision incrementality — genuinely cleaner than the
> scattered trail-checkpoint prose) and the direct/proxy gate idea (does a gate
> test the real path or a proxy — the destiny-audit's concern). Read it as a
> design source, never as canon; the three docs (`CLAUDE.md`, `PLAN.md`,
> `docs/SYNTAX.md`) remain the only read-path.

---

# Mentl — Finish Plan

> This is the operational roadmap, not the syntax authority and not a historical
> transcript. The syntax authority is docs/SYNTAX.md. A statement here describes
> a target or a verified artifact state; it does not make a feature real.

## §0 · Evidence contract and how to use this plan

Mentl is finished when one coherent semantic medium can prove, execute, explain,
edit, suspend, fork, schedule, persist, and resume the same computation without
any layer inventing facts that another layer already knew.

This file exists to get there. It replaces the former mixture of manifesto,
archaeology, landing diary, and flat peer list with:

1. an evidence contract;
2. a verified current board;
3. the final architecture and its invariants;
4. a dependency graph;
5. bounded work packets with direct acceptance gates;
6. a release definition that makes superiority a measured result, not a claim.

History belongs in git and boot/PROVENANCE.md. Completed work remains summarized
here only when it changes the dependency graph or the current baseline.

### §0.1 · Authority and evidence

Use two authority orders; never confuse descriptive truth with normative design.

For what Mentl does now:

1. emitted WAT/WASM, runtime behavior, and direct adversarial gates;
2. conforming .mn bodies and the compiler paths that actually consume them;
3. current artifact hashes and reproducible measurements;
4. PLAN.md, CLAUDE.md, skills, comments, transcripts, and handoffs only as
   hypotheses to verify.

For what authored Mentl means and should become:

1. docs/SYNTAX.md for accepted surface semantics;
2. the resolved semantic principles in §2 and §4;
3. first-principles soundness, compositionality, implementability, and measured
   developer consequences;
4. current implementation only as evidence of feasibility or debt, never as a
   veto over a cleaner semantic model.

Do not use a // comment as evidence that a mechanism exists. Do not use an ADT,
effect declaration, lowering arm, or proxy micro as evidence that the user can
reach the feature. Follow the whole path from legal .mn source through parse,
infer, lower, emit, host integration, execution, and refusal behavior.

Comments are nevertheless authored intent and therefore graph input under
docs/SYNTAX.md's one-comment-form rule. Preserve them as Authored evidence with
source identity; classify each referenced symbol as live, proposed, or stale.
They never become Derived/SolverProved evidence merely by naming a mechanism.

Verification is deliberately sound and incomplete: proved facts unlock their
exact consequences, refuted facts diagnose, and undecidable obligations remain
visible V_Pending. Pending is never assumed true, yet compiles by default where
docs/SYNTAX.md permits and cannot unlock a proof-dependent path.

### §0.2 · Capability states

Every headline capability has four independent states:

| State | Meaning |
|---|---|
| Specified | docs/SYNTAX.md or an accepted semantic contract defines it. |
| Implemented | A production path executes the intended semantics. |
| Directly tested | A test enters that production path and has a negative control that fails when the mechanism is removed. |
| Production-qualified | Soundness, failure behavior, portability, performance, security, and operational limits meet their declared budgets. |

Use these labels in work packets:

- LIVE: implemented and directly tested for the stated scope.
- PARTIAL: a real vertical slice exists, but the stated semantics are incomplete.
- SCAFFOLD: vocabulary or lowering machinery exists without a legal or direct end-to-end path.
- ABSENT: no implementation exists.
- BLOCKED: a named dependency must land first.

These packet labels describe implementation maturity, not the four independent
capability columns above. They do not by themselves grant readiness: always
read the packet's named dependencies and the single NEXT marker. BLOCKED means
that no meaningful independent slice of the packet may begin; it must also
state its underlying implementation evidence in Current evidence/Qualifier and
name the dependency that must land first.

Never promote a claim because a similarly shaped proxy test is green.

### §0.3 · The landing rule

A packet lands only when all of the following are true:

1. The old artifact is seen red on a focused fixture or invariant probe.
2. The semantic defect is explained at its writer, not patched at a downstream
   symptom.
3. The implementation preserves carried truth through graph, effects,
   ownership, refinement, regions, continuations, lower, and emit.
4. The positive fixture and adversarial negative controls are green.
5. Unsupported cases refuse before emit: nonzero status, precise diagnostic and
   evidence, zero output bytes.
6. Existing gates remain green and no error class is merely hidden.
7. Compiler-affecting work reaches a clean m2 == m3 fixed point.
8. Generated boot artifacts are updated only when emitted bytes actually change.
9. This board and the capability registry are updated without adding a landing
   diary.

### §0.4 · Agent execution loop

An agent resuming this plan shall:

1. Read CLAUDE.md, docs/SYNTAX.md, this file, and the live code named by the
   highest-priority unblocked packet.
2. Run bash tools/state.sh before trusting the current snapshot.
3. Check git status and preserve unrelated work.
4. Re-measure the packet's stated failure. Counts and root diagnoses can drift.
5. Add the red-first focused gate.
6. Implement the smallest complete vertical slice that restores the invariant.
7. Run focused gates, bash tools/verify.sh, and the fixed-point/frontier gates
   appropriate to the change.
8. Re-run bash tools/state.sh and update this file only with new verified truth.
9. Leave the next packet named and unambiguous.

Do not chase the easiest census decrement if a larger silent-wrong defect is
ahead of it. Do not make a bad representation more elaborate when the graph is
missing the real node, edge, identity, lifetime, or proof.

## §1 · Thesis and end state

### §1.1 · The product thesis

Mentl is a versioned computational medium whose source, compiler, runtime,
debugger, teaching system, and developer surfaces are projections of one typed
graph.

The distinctive result is the integration:

- The five operators describe the spatial topology.
- Algebraic effects and handler installation describe policy and capability.
- Quantitative ownership describes use, movement, borrowing, isolation, and
  continuation multiplicity.
- Refinements and evidence describe what is proven and what remains an
  obligation.
- Multi-shot continuations describe alternative time.
- Regions describe lifetime, forkable state, reclamation, and image roots.
- The cursor selects one stable graph address.
- Query, Propose, Topology, Effects, Ownership, Verify, Teach, and Why are eight
  facets of one read at that address.
- CLI, editor, LSP, browser, and automation are transports for the same
  protocol, never independent semantic implementations.

No individual ingredient is enough. Mentl earns its design goal only when their
composition is simpler to use and stronger to trust than using separate
compilers, effect systems, workflow engines, debuggers, language servers, and AI
assistants.

### §1.2 · Non-negotiable properties

1. Sound executable boundary. Productive analysis may continue around holes and
   errors; an executable never exists around a reachable hard error or
   unresolved value hole.
2. Exact identities. Symbols, effect instances, handler activations, regions,
   continuations, tasks, resources, and evidence use typed graph identities,
   not unscoped strings, incidental positions, display hashes, or raw integer
   conventions. Declaration-qualified field names legitimately key parameter
   products, and content hashes legitimately identify immutable revisions and
   artifacts; neither substitutes for binding or activation identity.
3. Carried truth. A fact has one writer and every later phase reads that fact.
4. No silent fallback. Unsupported control, schedule, representation, proof,
   persistence, or device paths refuse.
5. Determinism by semantics. Eligible schedules may differ in wall-clock timing
   and in a separately identified schedule receipt, never in value, structural
   result order, semantic facts, diagnostics, or the declared effect trace.
   A schedule receipt proves why the different execution was observationally
   eligible; it is not part of the program's semantic digest.
6. Progressive disclosure. Sequential, pure programs require no concurrency,
   lifetime, or handler ceremony. Advanced behavior appears when the program
   actually asks for it.
7. Local-first and least-authority. Source and capabilities do not leave the
   local process unless an explicit effect and handler authorize the projection.
8. Explainability is structural. Every diagnostic, proposal, refusal, schedule
   choice, proof, suspension, and replay decision has typed evidence back to
   source.
9. Performance contracts are honest. Identity lookup may be O(1); incremental
   work is O(changed dependency cone); image creation is O(reachable image);
   reclamation may be O(1) after a proof. “Everything is O(1)” is not a design.
10. Self-hosting is a test, not a proof. Fixed point, diverse double compilation,
    translation validation, fuzzing, and direct semantic tests establish
    different truths.

### §1.3 · The simplicity budget

Mentl shall not add a second surface when an existing primitive can carry the
meaning:

- no async, spawn, checkpoint, or GPU keywords;
- no separate exception hierarchy beside effects;
- no special debugger program beside continuations and evidence;
- no IDE-only type engine;
- no hand-authored resume-cardinality annotation;
- no textual effect-name allowlists;
- no untyped persistence API as the public boundary;
- no scheduler baked into <| or ><;
- no AI candidate trusted without the local verifier.

This is a constraint on architecture, not a demand that every implementation
function literally use an operator-shaped spelling.

## Current verified board — 2026-07-17

This snapshot was established from HEAD c70439a4 with a clean tree before this
plan rewrite.

### Board

| Check | Verified result |
|---|---|
| Full state | bash tools/state.sh exits 0 |
| Self-host | m2 == m3 byte-identical |
| Micros | 71 green |
| Frontier | 56 pass, 0 red |
| Proof exactness | 9 pass, 0 red |
| Crown | 5 pass, 0 red |
| Effect identity gate | green for its current limited scope |
| Wheel diagnostics | 582 errors, 718 warnings |
| Phantom comment symbols | 287 |

Current error census:

| Class | Count |
|---|---:|
| E_OccursCheck | 115 |
| E_MissingVariable | 115 |
| E_TypeMismatch | 109 |
| E_EffectMismatch | 95 |
| E_PurityViolated | 66 |
| E_IfMissingElse | 32 |
| E_PatternInexhaustive | 25 |
| E_FeedbackNoContext | 11 |
| E_UnresolvedType | 4 |
| E_OwnershipViolation | 4 |
| E_ConstructorArity | 4 |
| E_ResumeOutsideArm | 2 |

### What the recent work actually established

The following roots are landed and shall not be reopened without a red
counterexample:

- Refined aliases used before declaration now register before function
  signatures.
- Bare parameterized declarations no longer erase the principal Option/List
  argument in the repaired surface.
- Affine consumption is scoped per function.
- If and match branches are alternatives; parallel fanout branches remain
  collision-checked.
- If conditions, match scrutinees, and field receivers borrow instead of move.
- The ownership census fell from 152 current-class errors to 4 while a real
  double move remains rejected.

The next ownership residue is the callee-parameter boundary: passing an owned
local to a borrowing parameter must not consume it; passing to an owned
parameter must.

### Capability registry

| Capability | Specified | Implemented | Directly tested | Production-qualified | Current truth |
|---|---|---|---|---|---|
| Self-hosting fixed point | yes | yes | partial | no | PARTIAL qualification; fixed point is measured, direct-removal mutation and DDC/CI/release proof remain |
| Graph-based HM inference | yes | yes | partial | no | PARTIAL; 582 wheel errors remain |
| Structured Reason values | yes | yes | partial | no | PARTIAL tree; not append-only evidence |
| Five operator parser/AST | yes | yes | partial | no | PARTIAL semantics |
| Effect handlers | yes | yes | partial | no | PARTIAL exact identity/open-row behavior |
| Negative effects | yes | partial | partial | no | name-based gaps remain |
| One-shot resumptions | yes | yes | partial | no | PARTIAL for covered shapes; A0 must prove the direct path and removal control |
| In-process multi-shot | yes | yes | partial | no | PARTIAL for restricted continuation contexts; not a general-control claim |
| General delimited control | yes | partial | negative trap known | no | PARTIAL spine-specific reifier |
| Region escape ledger | yes | yes | partial | no | PARTIAL compile-time root tagging |
| Runtime arena reclamation | target | no | no | no | ABSENT |
| Relocatable continuation image | target | no | no | no | ABSENT |
| Durable execution/restart | target | prototype only | no | no | ABSENT as a durable claim |
| Sequential fanout | yes | yes | partial | no | PARTIAL for current branch shapes; direct-removal classification remains A0 work |
| Thread schedule | yes | scaffold | no | no | SCAFFOLD; sentinels and host-memory gap |
| SIMD schedule | yes | emitter pieces | proxy only | no | SCAFFOLD and surface-unreachable |
| GPU schedule | target | no | no | no | ABSENT; current arm is sequential |
| Feedback | yes | one-cell slice | one slice | no | PARTIAL; RHS spec largely ignored |
| Cursor eight-facet view | yes | yes | partial | no | PARTIAL; full scans/heuristic address |
| Typed-hole synthesis | yes | narrow slice | partial | no | PARTIAL; verifier/candidate rendering incomplete and directness must be re-audited |
| Teaching tie-break | target | no | no | no | ABSENT; ties collapse |
| Why engine | yes | Reason renderer | partial | no | PARTIAL; no evidence DAG/minimal cause |
| Incremental compiler | target | no | proxy only | no | ABSENT as production path |
| Fill-and-resume | target | no | no | no | ABSENT |
| Time scrub/forked realities | target | no | no | no | ABSENT |
| Formatter | yes | partial island | no production gate | no | PARTIAL and disconnected |
| LSP | yes | skeleton | no conformance gate | no | PARTIAL and unsynchronized |
| Browser medium | yes | compiler plus JS mirror | no parity gate | no | PARTIAL; semantics split |

### Claims that are currently false

Do not reintroduce these as present-tense statements:

- Region analysis is not runtime arena allocation or O(1) drop.
- Determinism does not require never freeing memory.
- A bump-allocated continuation record is not a durable image.
- Persist is not memcpy until the reachable graph is closed, relocatable, and
  versioned, and resources have policies.
- A 32-bit effect-name tag is not an exact continuation world.
- Fixed point is not semantic correctness or a trusting-trust proof.
- Source-ordered joins do not make parallel effects deterministic.
- The Thread, SIMD, and GPU schedule paths—and the separate persistence
  handler—are not proven by proxy arithmetic or fanout fixtures.
- The current annotation gradient does not prove survivors.
- The current Reason walker is not a full Why engine.
- A global graph epoch plus full scans is not incremental compilation.
- Formatter, delta, IC, LSP, and browser islands are not one live medium.
- Universal executable refusal is not live: at this baseline only
  E_MissingModule is armed by diag_refuses.
- The wheel's self-host fixed point does not prove the ordinary project entry:
  the live mentl compile main probe currently fails because its import DAG omits
  vocabulary supplied by the concatenated wheel.
- infer_seq_op does not yet carry the callee's exact effect row: it hardcodes
  Memory and drops Alloc. The previously measured exact-attribution change
  exhausts the current four-gigabyte bump image at m3, so this semantic fix is
  dependency-blocked by a real allocator and bounded compiler memory, not
  waived.

## §2 · Semantic kernel and accepted target architecture

Everything in this section is an accepted target invariant unless the current
board explicitly marks it LIVE. It is a design contract for implementation and
gating, not evidence that the current artifact already has the structure.

The eight primitives named by docs/SYNTAX.md remain the minimal authored
kernel; the architecture below makes their shared identities and runtime
consequences explicit:

| Primitive | One semantic home | Human projection |
|---|---|---|
| Graph + Env | revisioned typed facts and binding edges | Query |
| Handlers + typed resume | activation, ControlEdge, exact world | Propose |
| Five verbs | topology graph | Topology |
| Boolean effect algebra | exact parameterized rows, positives/negatives/tails | Unlock/Effects |
| Ownership | multiplicity plus access/transfer and region facts | Trace/Ownership |
| Refinement | obligation, narrowing, proof/refutation evidence | Verify |
| Continuous guidance | admissible verified revision deltas and ambiguity | Teach/gradient |
| HM inference + reasons | principal facts and append-only derivations | Why |

These are eight views over one ProjectImage, not eight registries or passes that
may disagree.

Bottom-up layers preserve the older L0–L7 vocabulary used by the contract:

- L0 graph: revisioned nodes plus typed edges; inference/transactions are the
  controlled writers and every other subsystem projects a read.
- L1 value ontology: word, sequence, product, sum, and function; Bool, String,
  tuples, text views, numeric representations, closures, and resources are
  derived views with explicit evidence.
- L2 topology + cost: five verbs draw shape; rows, ownership, regions, and cost
  facts constrain legal traversal and schedule.
- L3 dynamics: handlers and typed ControlEdge resume are the one control
  mechanism; one-shot, multi-shot, task, and image forms are projections.
- L4 inference write: HM, effects, ownership, refinement, representation,
  lifetime, and evidence are one productive-under-error constraint process.
- L5 surface: docs/SYNTAX.md is the minimal authored reachability of the kernel;
  formatter is its total inverse projection.
- L6 felt medium: cursor, gradient, teaching, Why, editor, protocol, and runtime
  timeline project the same facts.
- L7 closure: fixed point plus correctness, reproducibility, diverse trust, and
  honest host capabilities progressively eliminate Outside.

### §2.1 · One logical ProjectImage

The semantic authority is an immutable committed ProjectImage with derived,
revision-scoped indexes:

    ProjectImage {
      revision: RevisionId
      syntax: SyntaxId graph
      symbols: DefId and SymbolId graph
      facts: FactId graph
      evidence: EvidenceId DAG
      dependencies: forward and reverse edges
      source_map: stable anchors
      executable_boundaries: ControlEdge graph
      diagnostics and obligations
      fingerprints and caches
    }

Dense integer handles, union-find cells, span indexes, overlays, trails, and
memo tables remain efficient implementation details. They are not stable
semantic identities and cannot independently author truth.

Every change follows one transaction:

    Patch(base revision, structural target, replacement, intent)
      -> parse the delta
      -> resolve affected identities
      -> invalidate the exact dependency cone
      -> infer + effects + ownership + verify + lower
      -> compare required invariants
      -> Commit(GraphDelta, Evidence receipts)
         or Reject(Refutation, unchanged parent hash)

Speculation uses a private child revision. It never bumps or mutates the visible
parent. Saving to disk is a separate atomic effect after commit.

### §2.2 · Evidence, not overwritten reasons

Keep Reason as a useful human projection, but make typed append-only evidence
the authority:

    EvidenceEdge {
      id: EvidenceId
      revision: RevisionId
      rule: RuleId
      conclusion: FactId
      premises: [EvidenceId]
      source: SourceAnchor?
      witness: Witness?
      trust: Authored | Derived | SolverProved | ExternalAttestation
    }

Every user-facing answer carries EvidenceId. Required projections:

- why: the supporting derivation;
- why not: the first refutation and its prerequisites;
- what if: the child-revision delta;
- minimal cause: the smallest sufficient unsatisfied premise set;
- why changed: evidence diff across revisions;
- obligations: facts still pending.

Human comments can contribute authored intent or explanation. They never count
as semantic proof.

### §2.3 · Exact semantic facts

The type/effect/control kernel must carry:

- principal value type and representation;
- exact parameter product and identity-keyed holes;
- Boolean effect row over exact parameterized effect instances;
- positive requirements, negative proofs, and named open tails;
- handler activation identity and state schema;
- quantitative use and ownership;
- region and outlives constraints;
- refinement obligation and proof evidence;
- continuation input, answer, multiplicity, world, and fork policy;
- executable topology and source Reason.

No lowering phase may reconstruct any of these from a name, arity, tuple
position, source string, or current stack convention.

### §2.4 · The universal ControlEdge

Extend the existing graph boundary into the common cut for holes, continuations,
fanout tasks, replay, and persistence:

    ControlEdge {
      resume_slot: identity-keyed hole
      input: exact type and representation
      answer: exact type and representation
      body: explicit control graph
      discipline: OneShot | MultiShot | Either | Abandon
      usage: zero | one | many
      fork_policy: derived capture policy
      world: WorldId
      region_root: RegionRootId
      task_scope: TaskScopeId
      replay_cursor: ReplayCursor
      reason: EvidenceId
    }

The same meaning has optimized projections:

- a pure spatial hole becomes an ordinary closure;
- a one-shot temporal hole remains a direct stack continuation where proved;
- a multi-shot hole becomes an immutable snapshot root;
- a fanout branch becomes a scoped task;
- persistence serializes the same closed root;
- the live evaluator presents it as a typed suspension.

Universal lowering first produces:

    Done(value)
    Yield(ControlPacket)

ControlPacket is task-local and representation-honest. The current one-shot
fast path, tail calls, inlining, and host-specific yield transport become proved
optimizations, never the semantics.

### §2.5 · Exact continuation worlds

World is a graph identity, not an EffRow alias or a lossy tag:

    World {
      requirements: exact parameterized effect row
      handlers: effect instance -> activation identity and state epoch
      regions: owned, shared, and frozen roots
      task_scope: structured-concurrency scope
      replay: log identity and cursor
      resources: portable or explicitly rebound capabilities
      code_schema: compiler, target, module, and type identities
    }

Resume requires a proved world morphism:

- captured operations resolve to the same activation or an explicit bridge;
- effect parameters and negative facts match;
- shadowing cannot silently redirect dispatch;
- linear resources transfer once;
- multi-shot captures are forkable;
- unrelated capabilities may be added only if they cannot change dispatch;
- external resources have rebind evidence.

### §2.6 · Usage, access mode, and fork policy

Quantitative use shall govern values and resumptions without conflating
multiplicity with access/transfer mode. The graph carries two related facts:

- multiplicity: zero, one, or many uses/captures;
- mode: read, borrow, move, store, return-transfer, task-transfer, or capture.

Own is derived from a consuming boundary, not from the accidental fact that a
name appears once. A single read remains a borrow; several reads may remain
shared; one move consumes. The continuation projection keeps use grade separate
from discipline:

- zero: no resume site; a non-bottom operation is still OneShot-at-most-once
  and discards the continuation, while a `-> !` operation is Abandon;
- one: OneShot, owned and move-only;
- many: MultiShot, forkable only when captures permit it;
- unresolved joins: Either until exact handler installation/specialization
  chooses a discipline or one uniform ControlPacket representation is proved.

Sequential composition, alternative branches, and parallel branches use
different algebraic operations. The graph records the resulting usage; caller
and callee both read it.

Multi-shot capture additionally derives one policy per capture:

- ShareImmutable
- CopyRegion
- PersistentCOW
- TrailRollback
- DeterministicMerge
- Rebind
- Deny

Mutable handler state defaults to branch-local snapshot. Shared mutation
requires SharedMemory plus a synchronization or deterministic merge law.

### §2.7 · Regions and allocation

Use structural RegionId(parent, generation), an outlives relation, and
transitive provenance over stores, fields, closures, handlers, continuations,
tasks, devices, globals, and images.

The preferred result rule is destination allocation: the caller supplies the
result region, so escaping result objects are born in their final owner while
callee scratch stays in a child region. Where this cannot be inferred, perform
an explicit proved promotion/relocation or reject.

The runtime allocator ABI needs:

- arena_enter
- arena_alloc
- arena_mark
- arena_reset
- arena_drop
- freeze/COW support
- growable, budgeted memory
- explicit OOM

A drop carries a proof receipt that every reachable root is absent,
parent-owned, promoted, or frozen. Debug generations and poisoning catch a bad
reset. Deterministic region assignment and output independent of ephemeral
addresses preserve fixed points while allowing reclamation.

### §2.8 · Typed durable images

Durability serializes a typed closed image, not an Int pointer and byte count.
The image contains:

- stable semantic resume point and code hash, never a table index;
- exact input/answer representations and schemas;
- exact world and handler activation/state schemas;
- reachable region roots and pointer/relocation map;
- image/compiler/target/schema versions;
- replay cursor and transactional effect journal;
- resource manifest with rebind, replay, compensate, or deny policy;
- integrity/authentication metadata;
- migration or precise refusal path.

Snapshot cost is O(reachable image) unless COW makes the logical checkpoint
O(1). Exactly-once is claimed only when a transactional handler proves it;
otherwise the execution contract states replay/at-least-once semantics.

### §2.9 · Pure topology, handled schedule

The five operators retain the SYNTAX meaning:

| Operator | Final semantic obligation |
|---|---|
| |> | Fill one identity-keyed stage hole; preserve causal order and downstream continuation. |
| <| | Borrow one immutable input into N branches; no mutation or escaping borrow. |
| >< | One N-ary fanout over disjoint owned inputs/regions; results keyed by branch identity. |
| ~> | Lexical prompt and exact handler activation; scope and row algebra remain visible through calls. |
| <~ | Typed causal cycle over logical time with state, delay, clock, capacity, and policy. |

Topology never chooses execution. A Schedule handler selects Seq, Thread, SIMD,
or GPU only after an eligibility proof over ownership, effects, representation,
world portability, cost, and host support. Persistence is a separate handler
that snapshots/journals an eligible computation under its already selected
schedule; it is not a fifth Strategy.

Schedule follows the authored fanout's lexical install site exactly as
docs/SYNTAX.md specifies. A Schedule handler around an ordinary call does not
silently reach into a fanout authored inside the callee. Caller-selectable
scheduling of such a callee requires an explicit schedule-specialized value or
other syntax/semantic decision added to docs/SYNTAX.md first; no compiler patch
may smuggle dynamic-scope scheduling across the call boundary. Nested handlers
at a fanout site shadow predictably.

An unsupported requested schedule refuses. It never silently uses Seq while
claiming Thread, SIMD, or GPU; an unsupported persistence policy likewise
refuses rather than pretending an in-process result array is durable.

### §2.10 · Deterministic structured concurrency

Every fanout creates a lexical TaskGroup:

- children cannot escape without an explicitly typed detach handler;
- scope exit joins or cancels every child;
- cancellation propagates and runs finalizers/region drops;
- TaskHandle is linear;
- results and failures are ordered by topology path;
- a race winner is selected by logical time and topology path, not wall clock;
- random streams derive from root seed and topology path;
- observable effects receive stable logical event keys.

Parallel effects must be branch-local, deterministically ordered,
associative/commutative with a proved merge, transactional/replayable, or
exclusive. Seq and Thread must have the same declared observations for eligible
programs. A program that explicitly observes scheduling or wall-clock timing is
not eligible for Seq/Thread equivalence unless that observation is virtualized
as logical time and proven schedule-independent.

The host path must use real shared memory and task records. Host-instance
isolation may optimize task-local control packets, but semantics cannot depend
on an ungated Wasmtime instantiation detail.

### §2.11 · Feedback and backpressure

Represent feedback as:

    FeedbackEdge {
      state_type
      initial_state
      logical_clock
      latency
      capacity
      policy
      owner_task
      evidence
    }

Rules:

- dynamic cycles require a delay token or explicit initial state;
- a zero-delay cycle refuses unless a solver proves a monotone finite fixed
  point;
- delay(N) owns an N-element ring;
- accumulate(init) owns typed state;
- filter_spec validates tap count, coefficients, and representation;
- threaded feedback is an actor owning its state;
- bounded-flow policy is explicit: block, conflate, latest, drop-oldest, or
  drop-newest;
- multi-shot forks logical time and feedback state.

### §2.12 · Cursor, gradient, teaching, and Why

Cursor is a stable address:

    CursorAddress(revision, SyntaxId or FactId, aspect, optional execution epoch)

Each facet has proof state:

    Known(value, EvidenceId)
    Declared(value, SourceAnchor)
    Pending([FactId])
    Refuted(EvidenceId)
    Unknown(EvidenceId)

The gradient is the set of admissible child-revision deltas, not an arbitrary
float. A candidate carries its structural patch, constraints, proof status,
capability delta, diagnostic delta, semantic delta, affected cone, cost, risk,
and evidence.

Compute Pareto dominance over explicit dimensions: blockers removed/added,
intent constraints satisfied, proved capability, proof debt, behavioral delta,
affected cone, edit cost, and risk. Attention/proximity may order presentation
only among semantically equivalent candidates; it cannot silently eliminate an
incomparable survivor.

Incomparable maxima remain visible. The result is:

    Unique(candidate)
    Ambiguous(candidates, minimal distinguishing question)
    None(refutations)

An answer becomes a scoped IntentConstraint and reruns proof search. The graph
answers every question it can; the user is asked only for intent.

### §2.13 · One medium protocol

All surfaces adapt:

- open_project / open_document
- apply_patch(base revision, patch)
- subscribe_deltas(revision)
- project_cursor(revision, anchor, aspects)
- query(revision, Question)
- propose(revision, target, intent)
- explain(revision, EvidenceId, mode)
- run(revision, policy)
- resume(SuspensionId, fill patch)

LSP is a lossy adapter to this protocol. Browser code renders protocol values
and does not tokenize, infer, rank, or author fixes. CLI retains explicit
scriptable commands while making a cursor address the common object passed
between them.

### §2.14 · Typed live execution and time

Keep three distinct cases:

- Standard executable: reachable bare value hole refuses.
- Parameter-product hole: a first-class partially applied value.
- Live evaluator under SuspendOnHole: returns a typed Suspension.

Suspension includes revision, stable hole identity, expected type, continuation,
discipline, exact world, ABI/dependency fingerprint, region roots, replay
cursor, and resource manifest.

A fill is first a normal patch transaction. Resume occurs only if all
compatibility proofs hold. Otherwise restart the smallest invalidated execution
frame and explain why.

Timeline history is a branch DAG of safe checkpoints and effect events.
Scrubbing restores a snapshot; trying a new value forks only from a proved
multi-shot, Forkable, Replayable point. Irreversible effects are explicit
barriers unless a compensation/transaction handler exists.

## §3 · Bottom-up construction and dependency graph

The construction is a dependency DAG, not nine independent phases:

    A0/B0/I0/I2/I4/I5  establish truth, semantics, adversaries, security,
                        and budgets from the beginning; H0a starts with B0
       -> A1/B1/B2/B4/B5/B7/B8/F0a
                        make the executable boundary, representation, and
                        structural five-operator Seq kernel sound
       -> E0..E2        give the compiler bounded, proved allocation runway;
                        I1 begins after B8 stabilizes layout descriptors
       -> B3/B6/A2/A3/F0b
                        finish exact rows/proofs, operator integration, and
                        zero-error refusal
          -> F1-base/F2 may begin feedback and schedule eligibility
       -> C0..C4        establish stable project identity, transactions,
                        evidence, dependencies, and one protocol
          -> G0..G5/H1/H4/H5/H7/H0b
                        qualify the R1 medium/project surfaces (H0b after G2)
       -> D0..D4        generalize continuations, worlds, replay, and time
          -> F3/F4/G6/H2/H3
                        build R2 concurrency, Fill, LSP, and browser projections
          -> E3 -> G7-inproc
                        prove reset placement before R2 timeline forks
       -> E4/E5 -> F7/G6-G7-durable
                        prove image/journal before cross-process time
       F5/F6            qualify SIMD/GPU independently after F2/B8/backend proof
       I3/I6/I7         qualify reproducibility, comparison, and optimization
                        at the release tier whose inputs are already stable

Parallel work is allowed only when it does not invent a downstream
representation before its identity and proof exist.

The primitive-special-case drift referenced against §3 is a dependency error:
L1's five-node value ontology (§2/§4①) must exist before String, Bool, numeric
width, resource, or closure projections. A duplicated primitive representation
poisons every later topology, ABI, formatter, equality, and persistence edge.

The current semantic blockers are A and B; R1 also requires E0–E2, the bounded
C/H production slices, and I4/I5 security/performance baselines. Real arenas
depend on lifetime proof.
Durable execution depends on real regions plus exact continuation worlds.
Threading depends on ownership, task-local control, allocator isolation, and
structured scope. Fill-and-resume and time scrub depend on transactions,
universal continuations, worlds, replay, and snapshots. The full IDE must not
stabilize a fake version of those semantics. I0, I2, I4, and I5 are
cross-cutting design constraints, not cleanup deferred to the end.

## §4 · Resolved decisions

These decisions are load-bearing. Reopen one only with a conforming
counterexample, a replacement invariant, and an update to docs/SYNTAX.md where
the authored contract changes.

① Values have one semantic ontology. A value carries exact type,
representation, ownership/use, region, effects, refinements, and evidence as
facets of one graph fact. String is the specified [Byte] sequence model; the
current split is implementation debt, not permission to invent a second string
universe.

② The five operator verbs are settled: |> fills a stage, <| shares one input,
>< distributes owned inputs, ~> installs a lexical handler, and <~ expresses a
typed causal cycle. Syntax, formatter, graph, control, ownership, schedule, and
Why must preserve those verbs without translating them into host-language
folklore.

③ Effects are exact parameterized Boolean rows with positive requirements,
transitive negative proofs, named open tails, and activation identity. A
continuation world is richer than an effect row and never a lossy name tag.

④ Multi-shot continuation is the common temporal primitive for search,
backtracking, live holes, time scrub, task forking, and durable suspension. It
does not by itself make captured state forkable or bytes durable; fork policy,
closed regions, replay policy, typed images, and world morphisms supply those
proofs.

⑤ Ownership is inferred and quiet for ordinary code. The compiler distinguishes
move, borrow, alternative use, parallel use, capture multiplicity, task
transfer, and region escape from graph position and callee facts. Annotation
ceremony is evidence that inference or explanation still needs work. This is an
accepted doctrine correction to docs/SYNTAX.md's current 0/1/2+ shortcut; B0
must amend the syntax authority before B5 changes compiler semantics.

⑥ Typed information flow is a kernel frontier, not an IDE lint. Capability and
flow labels travel through rows, handlers, worlds, images, FFI, proposals, and
declassification evidence.

⑦ The felt medium is co-equal with the compiler. Cursor, gradient, teaching,
Why, formatter, CLI, LSP, browser, and automation read one ProjectImage and one
protocol; none may maintain a second semantic engine.

⑧ Evidence is append-only authority. Reason remains a human projection, while
typed evidence records derivation, refutation, trust, revision, schedule,
runtime, and change provenance. No phase overwrites why a fact is known.

## §5 · Real → felt → unsurpassable work packets

Each packet has one outcome, one semantic invariant, named dependencies, and
direct gates. Status is the current verified state, not an estimate.

### §5.U · Value/control/image integration

The principal integration seam is one typed ControlEdge rooted in one
ProjectImage. Values, holes, resumptions, task branches, feedback epochs, and
durable suspensions are not separate runtime inventions: each is a projection
of identity-keyed inputs, answer representation, usage, world, region roots,
task scope, replay cursor, and evidence. Fast paths may erase fields only after
a proof and translation-validation receipt. Any packet that introduces a
parallel closure record, persistence record, IDE-only suspension, or string-key
identity beside this seam is architecturally wrong even if its local test is
green.

#### §5.U STEP 4 · Fanout substrate, not inherited schedule

The current fanout/control substrate is useful only as topology. Schedule is
read at the fanout's own lexical install site. Reusable callees do not inherit a
caller's schedule; `Hβ.lower.schedule-specialized-callee` remains a skeptical,
consumer-driven design question under §5.R band E, never an ambient runtime
capability smuggled through every call.

### §5.3 · Representation gradient convergence

The surface already specifies one value ontology. B2 and B8 make lower/emit
converge on it: String becomes the [Byte] sequence case; representations are
cash-outs of proved word/element/product/sum/function facts; sequence concat and
equality never dispatch on a duplicated surface type. The gradient chooses a
representation under explicit ABI, target, alignment, cost, and capability
constraints while preserving one semantic value.

### §5.O · Carried-truth performance architecture

Performance comes from retaining the edge that answers a query and assigning
temporary work a proved lifetime—not from declaring every operation O(1).

1. Identity layer: binding/effect/field/region/control identities use direct
   typed indexes; display strings and repeated scans never sit on hot semantic
   paths.
2. Dependency layer: forward/reverse edges, revision fingerprints, and indexes
   make work proportional to the changed cone; clean rebuild remains the oracle.
3. Lifetime layer: each declaration/task/speculation gets a destination-aware
   child arena; proved reset/drop bounds compiler and medium memory.
4. Parallel layer: after exact ownership/effects/regions, independent
   declarations and branches use TaskGroup/Thread on the real compile spine.
   Never partition dense handle space with guessed source-size strides.
5. Image layer: immutable/COW roots make multi-shot fork and snapshots share
   safely; physical copy cost remains O(reachable changed image), stated
   honestly.

Every layer gets a high-water, work/span, latency, and mutation gate. A cache or
index that can disagree with ProjectImage is a derived revision-scoped view and
must be invalidated by exact dependency edges.

### §5.R · Dependency-ordered remainder

Every active packet must maintain five fields: Current evidence, Depends on,
NEXT red, Gate, and Unblocks. Until those fields are fully embedded below, this
index is the mechanical routing authority:

| Packet(s) | Depends on | Unblocks | Required direct artifact |
|---|---|---|---|
| A0 | current board only | every capability claim | capability manifest plus mutation-red registry |
| B0 | A0 | all syntax-facing packets | generated SYNTAX conformance matrix |
| A1 | A0 | A2 and safe downstream work | universal unsupported-path refusal probes |
| B1/B2/B4/B5/B7/B8 | A0/B0 as applicable | A3, A2, C, D, F | focused positive plus adversarial negative fixtures |
| E0/E1/E2 | B5, I0 region rules, I5 budgets | B3, E3, compiler runway | bounded per-declaration arena and high-water receipt |
| B3 | E2, B4 | A3, A2, D1, F2 | exact callee-row/Alloc gate without m3 OOM |
| B6 logical slice | B3/B4 | A2 and minimal proof soundness | proof/IFC adversarial matrix with revision-local witnesses |
| A3 | owner packets above | A2 | generated census dashboard linking each class to one owner packet |
| A2 | A1, A3 | executable trust boundary | zero wheel errors plus universal SError refusal |
| C0/C1/C2 | sound B1–B5/B7/B8 kernel | B6 durable evidence, C3/C4, D, G | stable-ID, rollback, and evidence DAG mutation gates |
| C3/C4 | C0/C1/C2, H0a for rendered patches | G/H surfaces | clean-vs-incremental and protocol parity gates |
| D0 | B kernel, I0/I2 reference semantics | D1/D2/D3 | evaluation-context × representation matrix |
| D1/D2 | D0, B3/B4/B5 | D3/D4/E4/F3 | world-morphism and fork-policy gates |
| D3/D4 | C transactions/evidence, D1/D2 | E5, G6/G7 | replay oracle and clean-run equivalence |
| E3 | E0/E1/E2, I1 validation | G7 in-process and E4 | reset-placement mutation validation |
| E4/E5 | D1/D2/D4, E3, I4 | F7/G7 | relocatable image plus kill/restart journal gate |
| F0a | B0, B1/B2/B4/B5/B7/B8 | E/D | structural five-operator Seq semantics with AST/runtime gates |
| F0b | F0a, B3/B6 logical slice, H0a | D/F | exact row/evidence/formatter integration matrix |
| F1 base/F2 | F0b, B kernel | F3..F7 | feedback reference and eligibility matrices |
| F1 fork integration | F1 base, D2 | G7 | feedback epoch fork/isolation gate |
| F3/F4 | D2, E2, F0b/F2 | G7 and Thread claim | real overlap, cancellation, isolation, digest gates |
| F5/F6 | F2, B8, and backend-specific D/E proofs | qualification only | real SIMD/device evidence; otherwise refusal |
| F7 | F0b, F2, F3, E4/E5 | R3 durable fanout | structured kill/restart evidence; otherwise refusal |
| G0..G5 | C2/C3/C4, H0a | G6/G7, felt medium | production-handler mutation and parity gates |
| G6 in-process | C1–C4, D0–D3, E0–E2 | R2 fill-and-resume | no-rerun fill and clean-run equivalence |
| G7 in-process | D4, E3, F1 fork integration, F3/F4, G6 | R2 timeline exploration | safe-epoch fork and ordered proof receipts |
| G6/G7 durable extension | E4/E5 and in-process gates | R3 cross-process time | relocatable suspension and kill/restart timeline |
| H0a | B0/B8 and actual AST | F0b and syntax fixtures | exhaustive round-trip renderer |
| H0b | H0a, C1/C3/C4, G2 patch contract | unified felt medium | cross-skin canonical-source parity |
| H1/H4/H5/H7 | C4 and owning semantic packets | R1 production line | arbitrary-directory editor/CLI/project/library end-to-end |
| H2/H3 | C4, H0b, owning semantic packets | R2 multi-skin line | LSP/browser protocol conformance |
| H6 | honest tier capability manifest | release learning path | every tutorial runs on its declared tier |
| I0/I2/I4/I5 | begin with A0 and evolve with every packet | all soundness/qualification | models, adversaries, threat cases, measured budgets |
| I1/I3/I6/I7 | stable owning representations | release claims | translation validation, diverse build, comparator and optimization receipts |
| I8 | begins with R1 scope, expands by tier | every release verdict | flagship sources, negative controls, measurements, receipts |

Exactly one line may match `^NEXT —` in this document. If a dependency or live
measurement changes, update this table and the owning packet in the same patch.
A plan linter in A0 shall reject unknown packet IDs, cycles, invalid status
labels, multiple NEXT markers, missing direct gates, and broken §0–§11 or §5.U/
§5.R anchors.

#### §5.R band E · Parallelism and accelerators

Seq semantics and the five operator laws land before backend work. Thread is
the first production schedule and must prove real overlap, shared-memory
correctness, structured lifetime, and observational coherence. SIMD/GPU
schedules and the separate persistent-branch handler remain qualification
lanes: they refuse honestly until direct hardware or kill/restart gates exist.
Schedule-specialized callees are built
only if a real use case justifies a docs/SYNTAX.md change and compile-time
specialization preserves zero-cost Seq and exact negative-effect proofs.

### A — Truth and refusal

#### A0 — Test the tests

Status: PARTIAL

NEXT — direct/proxy capability registry:

- Current evidence: the board is green, but several registry rows have no
  removal mutation proving that the named production path caused the pass.
- Baseline command:
  `bash tools/run-micro.sh tests/micros/mn-multishot.mn 30
  lib/runtime/memory.mn lib/runtime/strings.mn lib/runtime/lists.mn
  lib/prelude.mn`; current expected result is exit 30 with zero diagnostics.
- Mutation-red command: in a disposable git worktree, change only
  `arm_disc_of` in src/infer.mn so UMany returns OneShot, build
  the changed wheel with `bash tools/march.sh`, point MENTL_BOOT at that
  worktree's fresh m2 compiler, and rerun the exact command. The direct gate must
  fail with the historical collapsed result 10 rather than 30. Revert/delete
  the worktree after recording the receipt; never mutate the user's tree.
- Live touchpoints: src/infer.mn (`arm_disc_of`), lower's
  MultiShot producer/call-k path, tools/run-micro.sh, tools/march-gate.sh,
  tools/frontier-gate.sh, and tools/state.sh.
- Focused acceptance: a generated manifest classifies the gate as direct,
  structural, differential, or proxy; disabling the live mechanism makes the
  direct gate fail; reverting the mutation restores green.
- After green: continue A0 across every capability-registry row, then take B0.

Outcome: A green board cannot ignore diagnostics, fail to propagate a gate
failure, or certify a proxy path.

Actions:

- Audit tools/run-micro.sh diagnostic parsing, including prefixed diagnostics.
- Audit march/frontier/proof/crown scripts so every failed assertion affects
  process status.
- Separate direct production gates, structural unit tests, differential
  compatibility checks, and proxy demonstrations in output.
- Add mutation checks: remove or break the intended mechanism and prove its gate
  turns red.
- Generate a machine-readable state manifest with artifact hashes, counts,
  direct capability gates, and command versions.
- Give every capability row a release tier, claimed input/domain boundary,
  refusal behavior outside it, owner packet/milestone, direct gate, negative
  control, security budget, and performance budget. R1/R2/R3 are generated
  predicates over this manifest, never movable prose subsets.
- Run the board in CI on a clean checkout.

Acceptance:

- Injected error lines are counted regardless of prefix.
- An intentionally failed march assertion exits nonzero.
- Every claim in the registry names a direct gate or remains untested.
- Proxy tests cannot promote a capability state.
- The state manifest is reproducible.

#### A1 — No silent unsupported path

Status: PARTIAL

Outcome: Every accepted program either has semantics or refuses before the first
output byte.

Actions:

- Replace continuation runtime floors with compile-time unsupported-control
  diagnostics until packet D0 implements them.
- Refuse GPU, durable restart, time scrub, unsupported representations, and
  unimplemented feedback modes.
- Replace fabricated values and wildcard invariant fallbacks with typed
  compiler-invariant failures.
- Require an EvidenceId/Reason and authored span for every refusal.

Acceptance:

- Each unsupported fixture exits nonzero with zero WAT/WASM bytes.
- No accepted source reaches an unreachable because an AST context was omitted.
- Removing a refusal guard turns its negative fixture red.

#### A2 — Zero-error wheel and universal executable refusal

Status: BLOCKED

Depends on: A1 and the owner packets summarized by A3.

Outcome: Productive check/edit surfaces retain errors and holes; compile/run
refuse on every reachable SError, not a manually armed subset.

Transition:

- Keep the current per-class ratchet only as bootstrap scaffolding.
- Eliminate each root without hiding or reclassifying it.
- Arm the class as soon as its wheel count reaches zero.
- At zero total hard errors, delete diag_refuses and define refusal directly
  from severity.
- Keep verification-pending distinct from hard failure. Per docs/SYNTAX.md,
  V_Pending surfaces and still compiles by default; it proves no optimization,
  capability unlock, unchecked access, or fork/persist eligibility. Optional
  strict or runtime-check policies may strengthen that default without
  rewriting V_Pending as success or hard failure.

Acceptance:

- Wheel hard-error census is zero.
- Every SError fixture refuses with nonzero status and zero bytes.
- Warnings do not refuse.
- Check remains productive around multiple independent errors.
- Dead unreachable holes do not over-refuse.

#### A3 — Current census campaign

Status: PARTIAL

Outcome: a generated dashboard maps every current diagnostic class and root to
the semantic packet that owns it. A3 does not duplicate B/E work or authorize a
symptom patch merely to lower a number.

Current owner map:

- four ownership errors → B5 call-boundary move/borrow truth;
- 115 missing variables dominated by handler forward references → B4 first;
- the 115 zero-span occurs checks immediately follow those 115 missing-variable
  sites at the current baseline, so treat them as a probable cascade, repair
  binding/handler identity, then recount before inventing a unification fix;
- 109 type mismatches → re-cluster and assign to B1/B2/B3/B7 rather than assume
  one cause;
- 95 effect mismatches and 66 purity violations → B3 exact declared-row truth,
  after E2 gives the compiler memory runway;
- missing else, inexhaustive pattern, constructor arity, unresolved type, and
  resume-outside-arm → B7/D0 as their direct fixtures prove.

For every root, the owning packet captures a minimal red fixture, counts
directions/sites/messages, fixes the writer, proves no new class appears,
lowers the ratchet, and arms refusal at zero. A3 only renders that state.

### B — Sound semantic kernel

#### B0 — SYNTAX conformance matrix

Status: PARTIAL

Outcome: Every normative syntax rule maps to parser, AST, inference, lowering,
formatter, positive fixture, negative fixture, and diagnostic.

Include at minimum:

- parameter products, defaults, labels, and identity holes;
- all five operators and precedence;
- records, row tails, updates, and patterns;
- ADTs, aliases, refinements, representation pins;
- parameterized effects, negatives, named rows, handlers, resume discipline;
- imports and collisions;
- indexing and bounds;
- strings as the declared sequence model;
- exhaustive formatter layout.
- the canonical bottom type `!`, beginning with `abort() -> !`; the current
  wheel recovers that form as unit and therefore does not conform.

Normative-delta ledger — update docs/SYNTAX.md before implementing these PLAN
decisions:

- replace the 0/1/2+ occurrence shortcut with multiplicity plus
  access/transfer-mode inference (§4⑤/B5);
- replace scalar gates×proximity gradient argmax with a Pareto survivor set and
  explicit ambiguity question (§2.12/G3/G4);
- complete the equality doctrine: word/sequence/product/sum are structurally
  decidable; unrestricted extensional function equality is not. Function
  equality refuses unless a future explicit identity/equality witness supplies
  a sound, user-visible law; pointer or incidental CodeId equality never fills
  the gap.
- resolve resume discipline wording: `-> !` is Abandon; a zero-resume arm for a
  non-bottom operation remains an at-most-once OneShot arm that discards the
  continuation. Update both conflicting SYNTAX passages and add D2 gates.
- replace SYNTAX's “persisted multi-shot is memcpy-serializable” shortcut with
  §2.8's typed closed-image contract. COW may make a logical checkpoint O(1),
  but portable serialization is O(reachable image) and requires relocation,
  schemas, world/resource policy, replay, integrity, and migration/refusal.
- narrow SYNTAX's broad compound effect indices to immutable, freeze-safe,
  portable values with a decidable equality witness. That witness must be an
  equivalence relation and any canonical hash must be congruent with equality;
  Float indices need a specified NaN/signed-zero canonicalization or refusal.
  Closures, mutable/cyclic aggregates, and external resources refuse absent a
  stronger explicit witness.

Until a ledger item is accepted into docs/SYNTAX.md with its conformance tests,
the current SYNTAX rule remains authoritative and no compiler change may cite
PLAN alone as permission.

Acceptance: the matrix is generated or mechanically checked; no specified form
is silently accepted with different semantics.

#### B1 — Operator domains

Status: PARTIAL

Risk: known silent-wrong operator acceptance.

Outcome: Arithmetic, comparison, concatenation, equality, and indexing are
constrained by domain classes derived from the graph.

Actions:

- Replace “unify both operands” with exact numeric/ordered/sequence/equality
  constraints.
- Carry representation selection through the constraint.
- Reject records/functions/handlers where no derivation exists.
- Ensure aliases and refinements preserve the underlying domain evidence.

Acceptance:

- Invalid arithmetic/comparison/concat refuses before emit.
- Int/Float/representation combinations follow one documented coercion rule.
- Equality is structural over word, sequence, product, and sum, and never heap
  pointer equality. B0 resolves docs/SYNTAX.md's contradictory “total over five
  node-kinds” claim and missing function row: unrestricted extensional function
  equality is undecidable, so it refuses absent an explicit sound witness.
- Each valid domain reaches width-correct WAT.

#### B2 — One sequence model and safe indexing

Status: PARTIAL

Risk: known silent-wrong sequence and indexing behavior.

Outcome: Sequence representation, String/Byte semantics, indexing, and proven
bounds match docs/SYNTAX.md.

Actions:

- Implement the specified String = [Byte] model and remove the current
  representation split; do not reopen the settled value ontology.
- Make list_index reject negative and upper-bound violations.
- Make list_index_proven reachable only with a proof witness tied to the exact
  list length/index fact.
- Add tuple compile-time bounds and dynamic sequence runtime bounds.
- Preserve O(1)/tree indexing complexity without memory-unsafety.

Acceptance:

- -1 and len both refuse/trap with the declared bounds diagnostic.
- Proven valid indexing elides the runtime check in inspected WAT.
- The bounded first slice always checks dynamically. After B6/C2, forged or
  stale proof identity cannot select the unchecked path.
- Strings and byte sequences share the specified operations and equality.

#### B3 — Exact Boolean effect rows

Status: PARTIAL

Outcome: Effect rows are exact sets of parameterized instances with sound open
tails, union/intersection/subtraction, and transitive negative proofs.

R1 milestone: exact ground/freeze-safe indices, closed and named/open rows for
the claimed core, higher-order callable requirements, and transitive negatives
are direct-gated; any symbolic/modal case not proved is conservatively refused.
Later modal synthesis increases expressiveness, never R1 soundness.

Actions:

- Represent each row member as an effect family plus a typed structural index
  value, kept distinct from the handler activation identity. Ground terms
  normalize statically; dynamic terms are evaluated and frozen at installation
  exactly as docs/SYNTAX.md specifies. Equal frozen values denote the same
  effect instance even across installations, while each handler activation
  still has its own generative identity. Symbolic/dependent equality is carried
  as a constraint or precise runtime guard, never guessed from a hash or display
  name.
- Distinguish Sample(44100) from Sample(48000).
- Preserve instance identity through membership, normalization, dedup,
  evidence, handler lookup, negation, and display.
- Make named/open row tails first-class constraints.
- Close the higher-order leak: a callable value carries the exact capability
  requirements of invocation.
- R1 may conservatively refuse a higher-order/open-tail case it cannot prove;
  later modal capability synthesis restores expressiveness without weakening
  transitive absence.
- Remove name-string IFC/security heuristics.
- Replace infer_seq_op's hardcoded Memory row with the callee's carried exact
  row, including Alloc, after E2 removes the measured m3 four-gigabyte bump
  ceiling. Do not erase Alloc merely to preserve bootstrap memory.
- Admit effect index types only when stable structural equality is decidable
  and the value is immutable, freeze-safe, and portable, or an explicit checked
  witness proves those properties. Stable hashing may accelerate lookup but is
  never identity. Closures, mutable aggregates, cyclic graphs, and external
  resources refuse as indices absent such a witness.
- Check each custom equality witness for reflexivity/symmetry/transitivity over
  its admissible domain where decidable, require canonicalization/hash
  congruence, and property-test counterexamples including NaN and signed zero.

Acceptance:

- Parameter mismatch, open-tail escape, and negative-effect transitive calls
  refuse.
- Alpha-equivalent normalized rows compare equal.
- Row algebra property tests cover Boolean identities and counterexamples.
- Handler dispatch and diagnostics cite the exact effect instance.
- Two installs with the same frozen index have equal effect membership but
  distinct handler activations; different values do not interoperate without an
  explicit bridge.
- A runtime equality guard may select a matching installed handler, but an
  unknown dynamic comparison cannot prove !E, Pure, unchecked access, Thread
  eligibility, forkability, or persistence. Negative/capability evidence stays
  statically checkable.

#### B4 — Handler identity, activation, and evidence

Status: PARTIAL

Outcome: Declaration order does not change semantics; installation creates an
exact activation whose evidence flows through calls and continuations.

Actions:

- Pre-register handler identities and schemes before bodies.
- Infer arms against that stable identity and finalize atomically.
- Bind operation evidence by effect instance plus activation, never name alone.
- Make install scope and shadowing visible through called functions.
- Eliminate ambiguous default-handler dispatch.

Acceptance:

- Handler used before declaration works.
- Two same-name activations remain distinct.
- Nested shadowing dispatches to the nearest exact activation.
- Callable/continuation facts retain the captured activation identity; D1 owns
  the later escape/resume world-compatibility verdict.

#### B5 — Quantitative ownership at call boundaries

Status: PARTIAL

Qualifier: four current errors remain.

Outcome: A value is consumed only at a move position proven by the callee
parameter, return transfer, store, capture, or explicit ownership topology.

Actions:

- Read parameter ownership from the callee scheme for every argument.
- Replace the current 0/1/>=2 name-count shortcut with related but distinct
  multiplicity and access/transfer-mode facts. A single occurrence is not
  evidence of a move.
- Track moves, borrows, field projections, alternative branches, parallel
  branches, closures, returns, and handler state.
- Make OneShot continuations move-only now; TaskHandle becomes move-only when
  F3 introduces its stable identity and structured scope.
- Derive <| borrow and >< distribution from use, then verify the authored glyph.

Acceptance:

- The four current call-argument false positives clear.
- Real double move, use-after-move, escaping borrow, and double resume refuse.
  F3/F4 own the later double-join and cross-thread mutable-alias integration
  gates.
- Alternative arms join usage; parallel arms collision-check.
- Caller and callee cannot disagree about ownership.

#### B6 — Refinements, proof evidence, and IFC

Status: PARTIAL

Outcome: Decidable predicates prove, false predicates reject, undecidable
predicates remain explicit obligations, and security labels are typed facts.

R1 milestone: built-in decidable predicates, checkable witnesses, honest
V_Pending, and proof-dependent bounds/capability gates are sound. R1 makes no
full-IFC claim; any declared flow feature must be typed/direct-gated or refuse.

Actions:

- Define polarity and construction/elimination rules for refinements.
- Make the default verifier sound and incomplete.
- Add solver handlers behind the same Verify effect with checkable certificates.
- Tie bounds-elision and capability unlocks to proof witnesses.
- Replace string-sensitive IFC with a typed information-flow lattice and
  declassification effects.
- Land the pre-C2 logical slice with revision-local checkable witnesses. After
  C2, migrate every surviving proof, obligation, flow, and declassification to
  durable EvidenceId without changing the logical verdict.

Acceptance:

- False proof never emits.
- Pending proof is never silently true.
- Solver proof is independently checked.
- Bounds/real-time/sandbox capabilities name their evidence.
- Secret flow to a public sink rejects unless a declared declassifier handles
  it.

#### B7 — Complete patterns, records, imports, and modules

Status: PARTIAL

Outcome: Every specified structural form is type-safe, exhaustive, identity
aware, and lowerable.

Acceptance:

- List/tuple/record/as/alternative patterns lower and match correctly.
- Exhaustiveness understands refinements conservatively.
- Open record rows preserve fields without name collision.
- Before C0, selective imports and duplicate names resolve correctly under a
  scoped binding oracle; after C0, the same gate upgrades to stable SymbolId.
- Missing/cyclic modules diagnose and refuse consistently.
- An arbitrary-directory project using the normal mentl compile main entry sees
  the same required prelude/runtime vocabulary as the wheel, or diagnoses a
  real missing import. Concatenation order is not a hidden module system.

#### B8 — Representation and ABI truth

Status: PARTIAL

Outcome: every graph type has one exact LowIR/Wasm/host representation, and no
lowering path guesses width, stride, tag, field offset, closure layout, or
continuation layout from a legacy convention.

Actions:

- Carry Repr through sequences, products, sums, closures, handlers,
  continuations, resources, SIMD lanes, FFI, and images.
- Repair sequence length/stride/load/store so Float and every supported word
  representation are not silently treated as i32.
- Specify variant tags and payload alignment, sorted record layout, closure
  environment shape, ControlEdge layout, and host import/export schemas.
- Generate layout descriptors consumed by lower, emit, translation validation,
  snapshots, debugger projection, and FFI.
- Refuse unsupported recursive, packed, device, or host representations before
  emit; never lower them through an i32 placeholder.

Acceptance:

- Generated representation matrix round-trips scalars, [Float], nested
  products/sums, closures, handlers, and resumptions through memory.
- WAT inspection and mutation tests prove exact widths, strides, alignments,
  tags, and offsets.
- Host ABI and image schemas consume the same generated descriptor.
- No representation-specific fallback can emit after its evidence is removed.

### C — Project identity, transactions, evidence, and incrementality

#### C0 — Stable syntax and symbol identity

Status: ABSENT

Outcome: Whitespace and unrelated edits preserve unaffected SyntaxId, DefId,
SymbolId, FactId, and cursor anchors.

Actions:

- Introduce an incremental green tree/rope.
- Derive stable syntax identity from structural reuse, not source offset.
- Resolve lexical bindings to SymbolId.
- Replace name-string references, exact-span first-match, pin strings, and
  handle-zero fallbacks.

Acceptance:

- Whitespace and sibling insertions preserve unaffected IDs.
- Shadowed equal names have disjoint references.
- Cross-module definition/reference/rename uses binding identity.
- Cursor survives formatting and nearby edits.

#### C1 — Complete graph transactions

Status: PARTIAL

Qualifier: current implementation covers the trail only.

Outcome: A rejected edit or candidate leaves every parent projection
byte/hash-identical.

Actions:

- Include syntax weave, program roots, env, comments, canon/narrowing edges,
  span/source indexes, overlays, boundaries, diagnostics, Verify debt, caches,
  and fresh allocators in child revisions.
- Move candidate minting inside the child.
- Support nested transactions and independent parallel children.
- Save only after commit using temp file, fsync, rename.

Acceptance:

- No epoch, node, span, overlay, diagnostic, or cache leak after rollback.
- Nested rollback restores the exact parent hash.
- Concurrent children cannot see each other.
- Invalid patch leaves disk unchanged.

#### C2 — Append-only evidence graph

Status: ABSENT

Qualifier: current Reason structures are not the append-only authority.

Outcome: Later unification cannot erase earlier provenance.

Acceptance:

- Every fact/diagnostic/proposal/refusal has EvidenceId.
- Every authored failure has a nonzero source anchor.
- Traversal is cycle-safe and deterministic.
- why, why-not, what-if, why-changed, and minimal-cause gates exist.
- Classify every current phantom comment symbol as an authored evidence target,
  a real live binding, or stale prose, then drive tools/comment-ratchet.sh to
  zero. A comment may add Authored evidence; it may never fabricate a
  CommentReason edge to a nonexistent semantic symbol.

#### C3 — Exact dependency graph and incremental engine

Status: ABSENT

Outcome: Work is proportional to the invalidated semantic cone and produces the
same result as a clean build.

Actions:

- Record dependencies for parse, binding, types, effects, ownership,
  refinement, control, lower, emit, docs, and execution.
- Maintain reverse edges and fact fingerprints.
- Memoize per revision.
- Add cancellation, coalescing, and stale-result suppression.
- Replace cursor/oracle full graph scans with indexes.

Acceptance:

- Leaf edit recomputes only the expected cone.
- Incremental diagnostics, facts, evidence, and emitted bytes equal clean build.
- Stale responses never publish after a newer revision.
- Warm latency and memory budgets are enforced.

#### C4 — One Query/Project protocol

Status: PARTIAL

Qualifier: the current common substrate is the Query effect only.

Outcome: All semantic readers use stable identities, proof states, and one
versioned protocol.

Acceptance:

- Same cursor/revision yields the same normalized response through every skin.
- No skin parses or infers Mentl independently.
- Every response states revision and evidence.

### D — Universal continuations and exact time

#### D0 — Universal typed control IR

Status: PARTIAL

Qualifier: current implementation covers a restricted AST spine.

Outcome: An effect can suspend in every evaluation context with exact type,
representation, continuation, and world.

Actions:

- Control-normalize effectful expressions before lower.
- Replace the hand-maintained AST-spine reifier.
- Carry real representations through ControlPacket.
- Preserve the OneShot direct path as an optimization.
- Eliminate runtime unreachable floors for accepted multi-shot programs.

Direct matrix:

- callee and every call argument;
- let initializer and non-final statement;
- unary/binary operand;
- if condition/arms;
- match scrutinee/arms;
- list/tuple/record/variant/interpolation element;
- pipe stage, nested handler, feedback body;
- lambda, nested function, recursion;
- nested re-yield depth at least 100;
- Int, f32, f64, i64, v128, record, variant, closure inputs and answers.

Acceptance: results and effect traces match a small reference control
interpreter.

#### D1 — Exact worlds and resume proof

Status: PARTIAL

Qualifier: a type field exists, but resume enforcement is missing.

Outcome: Every resume proves compatibility with the captured world.

Acceptance:

- Same activation resumes.
- Same handler name/new activation refuses.
- Parameterized effect mismatch refuses.
- Shadowing mismatch refuses unless bridged.
- Unrelated extra capability cannot perturb captured dispatch.
- Escaped functions and continuations retain the exact captured activation or
  refuse under the world morphism; B4 supplies the identity, D1 proves use.
- Runtime rehydration checks the same identity proof.

#### D2 — Multiplicity and fork policies

Status: ABSENT

Qualifier: current cardinality metadata is not a fork-policy implementation.

Outcome: OneShot, MultiShot, Either, and Abandon have complete ownership and
runtime rules.

Discipline algebra:

- arm analysis uses UZero/UOne/UMany. Sequential composition adds uses capped at
  UMany; alternative branches take maximum path grade; loops/recursion that can
  revisit a resume force UMany; parallel paths add because both may run;
- UZero or UOne on a non-bottom operation maps to OneShot-at-most-once; UMany
  maps to MultiShot; `-> !` plus UZero maps to Abandon, while any resume of a
  bottom result is a type error;
- joining identical installed disciplines preserves them. Joining distinct
  possible handlers yields Either, the unresolved top—not MultiShot by
  convenience. Either must specialize at installation or use an explicitly
  proved uniform ControlPacket representation before emit.

Acceptance:

- OneShot double resume/clone refuses.
- A `-> !` operation infers Abandon, exposes no resumable input, and cannot
  return to its call site.
- A non-bottom arm with zero resume sites is OneShot-at-most-once: it may discard
  the continuation and return the handler answer, but cannot be typed Abandon.
- Branch-dependent zero/one usage remains OneShot; any executable path with
  multiple resumes is MultiShot; distinct possible handler disciplines join to
  Either and must resolve before emit.
- Either is resolved before emit or uses an explicitly chosen uniform
  representation.
- MultiShot mutable/linear capture refuses without a fork policy.
- 1,000 immutable resumes have identical digests and bounded memory.
- Two stateful forks isolate then merge only under the declared law.

#### D3 — Holes and resumptions share Fill

Status: SCAFFOLD

Qualifier: useful separate hole and resumption mechanisms exist, but their
shared Fill integration and live fill-and-resume path do not.

Outcome: Partial application, pipe completion, live hole suspension, and
continuation resume are one identity-keyed fill edge with optimized
representations.

Acceptance:

- Pure top-level, local, closure, intrinsic, and effectful partials work.
- Standard unresolved value hole still refuses executable emit.
- Live evaluator returns typed Suspension.
- A prefix side-effect counter proves filling resumes rather than reruns.
- Resumed execution equals clean execution in value, effects, diagnostics, and
  evidence.

#### D4 — Replay and timeline semantics

Status: PARTIAL

Qualifier: only clock-oriented experiments are live.

Outcome: Forking and scrubbing are sound across declared replayable effects.

Actions:

- Add an event log keyed by execution, logical time, topology path, and local
  effect index.
- Record exact operation identity, arguments, result, and evidence.
- Derive Forkable, Replayable, Persistable, and Transferable.
- Add irreversible barriers and compensation/transaction policies.

Acceptance:

- Random/time/IO replay is stable under a recording handler.
- Unrecorded irreversible effect blocks scrub.
- Scrub backward and forward reproduces the full digest.
- OneShot checkpoint cannot fork.

#### D5 — Optional WasmFX target

Status: ABSENT

Outcome: When the host supports typed continuations, Mentl may lower ControlEdge
to WasmFX without changing semantics; the portable fallback remains valid.

Acceptance:

- Same program/control trace across fallback and WasmFX.
- Unsupported host feature selects the fallback explicitly.
- No Mentl surface depends on a particular Wasm proposal.

### E — Regions, allocator, snapshots, and durable images

#### E0 — Lifetime calculus

Status: PARTIAL

Qualifier: current implementation is a compile-time root-handle ledger.

Outcome: Every runtime reference has a proved outlives relation across returns,
stores, composites, closures, handlers, continuations, tasks, globals, devices,
and images.

Acceptance:

- Negative gates for each escape category.
- Composite/capture provenance is transitive.
- Semantic handles and runtime addresses remain distinct.
- Every error cites origin and escape edge.

#### E1 — Destination regions and promotion

Status: ABSENT

Outcome: Escaping results are born in the caller destination whenever possible;
scratch remains reclaimable.

Acceptance:

- Nested pointer result survives child drop.
- Non-escaping scratch is reclaimed.
- Ambiguous transfer promotes with a receipt or refuses.
- No root retagging without transitive object validity.

#### E2 — Real allocator ABI

Status: ABSENT

Qualifier: the current arena emitter calls the bump allocator.

Outcome: Region proof controls actual allocation and reclamation.

Acceptance:

- Repeated self-compile has bounded high-water memory.
- Poison-after-drop catches UAF in debug mode.
- Nested arenas, reset, drop, freeze, and OOM are direct-gated.
- Fixed point and output determinism survive address reuse.
- Compile time and memory are benchmarked before/after.

#### E3 — Reset placement proof

Status: ABSENT

Outcome: Every emitted reset/drop has a certificate and translation-validation
check.

Acceptance:

- Mutation/removal/misplacement of a reset is detected.
- No continuation/task/resource retains a dropped root.
- Debug generation mismatch is a precise failure.

#### E4 — Typed relocatable continuation image

Status: ABSENT

Outcome: A closed ControlEdge snapshot can move across addresses and processes
without raw pointers or table indices.

Acceptance:

- Nested reachable graph restores at a different base.
- Function identity resolves by semantic code ID.
- Exact schemas and world validate.
- Corrupt/truncated/tampered image refuses safely.
- Decoder fuzzing finds no memory-unsafe path.

#### E5 — Durable protocol and migration

Status: ABSENT

Qualifier: current persist.mn is a same-image experiment.

Outcome: Safe-point capture, crash-consistent commit, replay, resource rebind,
and verified migration/refusal.

Acceptance:

- Kill after checkpoint; a new process rehydrates and finishes.
- Crash during write yields old or new valid image, never partial.
- Code/schema/world/resource mismatch refuses.
- Verified migration succeeds and records evidence.
- Non-idempotent effect follows a declared transaction/compensation law.
- Two resumes isolate state and deterministically commit/merge.

### F — Complete topology and schedules

#### F0 — Five-operator semantic laws under Seq

Status: PARTIAL

Outcome: All five operators have complete graph, type, effect, ownership,
Reason, lower, formatter, and runtime semantics before parallelization.

Land in two dependency-safe milestones:

##### F0a — structural Seq laws

Status: PARTIAL

Current evidence: parser/AST/lower and Seq fanout slices exist, but A0 has not
classified all direct gates and `<~` remains a one-cell prototype.

Depends on: B0, B1/B2/B4/B5/B7/B8. Gate: the structural columns of §8.1 plus
AST/reference positive and negative fixtures for every verb. Unblocks: E/D
design may rely on topology/control shape, but not exact row claims.

Scope: graph shape, identity-keyed holes, ownership topology, lexical install
boundaries, causal feedback structure, and Seq control/runtime—without
pretending incomplete rows are exact.

##### F0b — exact semantic integration

Status: BLOCKED

Depends on: F0a, B3, the B6 logical slice, and H0a. Gate: every §8.1 column,
including exact effect/negative/proof evidence, diagnostics/Why, and canonical
parse-format-parse integration. Unblocks: D0 and F1/F2, which never consume the
partial F0a milestone as complete semantics.

Acceptance:

- |> fills exactly one hole and preserves effect order.
- <| proves immutable borrow/no escape.
- >< is one N-ary PFanout and proves disjoint ownership.
- ~> scope/effect subtraction/addition holds through called functions.
- <~ requires valid iterative context and causal state.
- Parser/formatter precedence and layout round-trip.

#### F1 — Feedback completion

Status: PARTIAL

Qualifier: current implementation is a one-cell global prototype.

Outcome: FeedbackSpec is consumed by inference and runtime with per-activation
state.

##### F1 base — causal feedback

Status: BLOCKED

Depends on: F0b. Current evidence: a one-cell global prototype exists, but it
cannot become the causal per-activation model until F0b supplies exact
operator-row/evidence integration. Gate:

- delay(3), typed accumulate, and N-tap filter match reference sequences.
- two installations do not share state.
- zero-delay dynamic cycle refuses.
- bounded policy and backpressure are observable and tested.

##### F1 fork integration — alternative time

Status: BLOCKED

Depends on: F1 base and D2. Gate: a multi-shot fork snapshots the feedback epoch,
isolates both branches, and merges/commits only under the derived fork policy.
Base causal feedback does not wait for general continuations.

#### F2 — Schedule capability and eligibility

Status: BLOCKED

Depends on: F0b and the sound B kernel. Current evidence: schedule vocabulary,
sentinels, and partial lowering exist, but no complete eligibility proof or real
Thread execution path exists.

Outcome: Schedule is a typed handler capability installed at the authored
fanout site, following docs/SYNTAX.md's lexical rule.

Acceptance:

- Direct legal .mn installs Seq and Thread at two fanout sites over the same
  branch logic and obtains equivalent semantic results.
- Nested schedule handlers at a fanout site shadow correctly.
- An outer handler around an ordinary call does not reach an internal callee
  fanout. If schedule-specialized callees are ever justified, they require a
  prior docs/SYNTAX.md decision and a direct specialization gate.
- Requested ineligible schedule refuses with the missing proof.
- Seq remains the invisible deterministic default.

#### F3 — Structured TaskGroup

Status: ABSENT

Outcome: Fanout lifetime, cancellation, failure, joins, and child arenas are
lexically scoped and typed.

Acceptance:

- No child or TaskHandle leaks scope.
- Cancellation drops every child and arena.
- Multiple failures aggregate by topology path.
- Detach requires an explicit handler and transferable world.

#### F4 — Real Thread schedule

Status: SCAFFOLD

Actions:

- Pass a real closure/task record; delete zero/sentinel intrinsics.
- Provide host-validated imported shared memory across worker instances.
- Use a worker pool and task-local control packets.
- Allocate in per-task arenas or safe atomic ranges.
- Enforce ownership and effect merge laws.
- Parallelize the compiler itself only at proved dependency levels: each
  declaration/task reads one immutable ProjectImage, writes a private child
  delta and arena, then commits facts/evidence in stable identity order. No
  guessed handle strides, shared bump cursor, or completion-order identity.

Acceptance:

- An atomic barrier proves at least two workers overlap; timing cannot satisfy
  the gate.
- WAT/host inspection proves the shared-memory and spawn path.
- MultiShot x Thread simultaneous nested-yield stress passes.
- Allocation contention produces no overlap/corruption.
- Random schedules/core counts yield identical semantic digests; schedule
  receipts may differ and are compared separately.
- Cancellation/failure leaves no live child or arena.

#### F5 — Honest SIMD schedule

Status: SCAFFOLD

Qualifier: emitter pieces are surface-unreachable.

Outcome: A legal handler selects SIMD only for homogeneous supported
representations.

Acceptance:

- Direct .mn source installs the schedule.
- WAT contains expected v128 operations.
- Generated Seq/SIMD values agree within declared numeric rules.
- Unsupported lanes/effects refuse; no scalar fallback under a SIMD claim.

#### F6 — Honest GPU schedule

Status: ABSENT

Outcome: A real device backend runs portable closed-world kernels.

Until then, GPU selection refuses.

Acceptance:

- Device kernel compilation and dispatch are observable.
- Eligibility proves device representation/effects/resources.
- Results compare with Seq over generated inputs.
- Device failure/resource limits produce typed diagnostics.

#### F7 — Persistent branch policy

Status: BLOCKED

Depends on: F0b, F2, F3, E4, and E5.

Outcome: A separate `~> persist(...)` handler makes eligible fanout branches
durable tasks backed by typed images and journals, without changing the
Seq/Thread/SIMD/GPU Schedule strategy.

Acceptance:

- Process dies with branches outstanding; new process joins them.
- Structural result order is stable.
- Duplicate delivery follows declared idempotency/transaction law.
- World/resource mismatch refuses.

### G — The medium: cursor, gradient, teaching, Why

#### G0 — Direct production-path gates

Status: PARTIAL

Outcome: Formatter, inverse gradient, IC, oracle, edit, LSP, and browser claims
enter their real production handler stacks.

Actions:

- Mark uncalled format_program, delta_pick, IC loops, and proxy fixtures as
  islands until routed.
- Give every claim a production entry command and removal mutation.

Acceptance: deleting the live handler makes the named gate red.

#### G1 — Stable cursor and proof-carrying facets

Status: PARTIAL

Outcome: Cursor uses stable identity/revision and never exact-span first-match,
string pinning, traversal-order ties, or handle-zero fallback.

Acceptance:

- Cursor survives formatting and adjacent edits.
- Every facet retains value, proof state, evidence, and revision.
- Verification debt retains span and Reason.

#### G2 — Release-equivalent candidate verification

Status: PARTIAL

Risk: current candidate verification is unsound.

Outcome: Candidate acceptance runs the same semantic checks required by release
inside a complete child transaction.

Actions:

- Replace verify_after_apply(NBound).
- Implement ownership suggestions and real handler patches.
- Re-infer the affected cone.
- Compare diagnostics, proof debt, worlds, lower, and behavior requirements.
- Preserve origin/cost/evidence.

Adversarial acceptance:

- forbidden row;
- ownership violation;
- pending/refuted proof;
- world mismatch;
- new error elsewhere;
- typechecks but changes behavior and therefore is not MachineApplicable;
- rollback leaves parent exact.

#### G3 — Semantic gradient and queue

Status: PARTIAL

Qualifier: the current queue is heuristic.

Outcome: Deterministic Pareto frontier over verified candidates and explicit
intent.

The same frontier is the speculative-work queue: idle workers evaluate
incomparable candidates or invalidated cones in isolated child revisions.
Work-stealing changes latency only; commit order and the visible survivor set
derive from identity/evidence, never worker completion order.

Acceptance:

- Defer excludes the same CandidateId for its scope.
- No no-op/repeated candidate remains queue head.
- Same revision/intent yields identical order under Seq/Thread.
- Silence means no admissible candidate, not a disconnected handler.

#### G4 — Teaching tie-break

Status: ABSENT

Outcome: Multiple survivors produce the smallest semantic question that divides
them.

Acceptance:

- Existing two-candidate hole asks a question.
- Source remains unchanged before answer.
- Each answer eliminates at least one candidate.
- Answer becomes a scoped IntentConstraint and produces a unique proved patch.
- No source/list order chooses silently.

#### G5 — Evidence-first Why

Status: PARTIAL

Qualifier: current behavior is a Reason renderer, not evidence-first Why.

Outcome: Why explains facts, failures, alternatives, changes, schedules, and
runtime events from the Evidence DAG.

Acceptance:

- Cycle-safe termination with explicit truncation/cycle nodes.
- Minimal cause is stable.
- why-not retains candidate rejection.
- why-changed compares revisions.
- CLI/LSP/browser show the same normalized evidence path.
- Authored comments are labeled Authored, not SolverProved.

#### G6 — Typed fill-and-resume

Status: BLOCKED

Depends on: C1–C4, D0–D3, and E0–E2 for the in-process slice. E4/E5 are required
only for the R3 relocatable/restart extension.

Outcome: A live hole produces a Suspension and resumes only the compatible
downstream computation.

Acceptance:

- Prefix effect is not rerun.
- Clean-run equivalence.
- Incompatible code/world/resource change minimally restarts or refuses with
  evidence.
- The R2 gate is explicitly in-process and makes no portable-image or crash
  recovery claim; the same Suspension gains those properties only through the
  E4/E5 extension.

#### G7 — Time scrub and parallel realities

Status: BLOCKED

Depends on: D4, E3, F1 fork integration, F3/F4, and G6 for in-process time;
E4/E5 only for the R3 cross-process extension.

Outcome: User can move to a safe execution epoch and fork an alternative value
with exact state/effect provenance.

Acceptance:

- OneShot fork refuses.
- MultiShot branch isolation holds.
- Replayed output/evidence digest is stable.
- Parallel exploration returns deterministic ordered proof receipts.
- A MultiShot ControlEdge may fork into a TaskGroup only after every capture has
  ShareImmutable/CopyRegion/PersistentCOW/TrailRollback/DeterministicMerge or a
  precise denial; real overlap cannot silently turn handler state into shared
  mutation.

### H — Developer experience and ecosystem

#### H0 — Exhaustive canonical formatter

Status: PARTIAL

Qualifier: current formatter is disconnected from the production path.

Outcome: Formatter is the sole source renderer and is total over the actual AST.

##### H0a — total syntax renderer

Status: PARTIAL

Depends on: B0/B8 and the actual AST. Gate: every constructor round-trips,
format is idempotent, and no fallback token exists. Unblocks: F0b and every
syntax-facing direct fixture.

##### H0b — revision/protocol integration

Status: BLOCKED

Depends on: H0a, C1/C3/C4, and G2's structural patch contract. Gate: formatter,
candidate patches, editor, LSP, browser, and CLI emit the identical canonical
source for one revision. Unblocks: the unified felt medium.

Acceptance:

- No <expr>, <stmt>, or <pat> fallbacks.
- Types, ownership, rows, handlers, refinements, patterns, and five operators
  survive.
- parse -> format -> parse semantic equality.
- format idempotence.
- Every AST constructor has a round trip.
- Candidate patches use this renderer.

#### H1 — Transactional terminal editor

Status: PARTIAL

Qualifier: current editor is disk-first rather than revision-first.

Outcome: Accept/reject/defer/override operate on revisions and structural
patches; invalid edits never alter disk.

Acceptance:

- stale revision conflict;
- atomic save;
- reject restores exact parent;
- defer/override have stable semantics;
- undo/redo are revision edges.

#### H2 — Complete LSP adapter

Status: PARTIAL

Qualifier: current LSP is a protocol skeleton.

Outcome: Standards-compliant document synchronization and real semantic
responses from the common protocol.

Acceptance:

- initialize;
- didOpen with unsaved text;
- incremental didChange/didClose;
- versions, cancellation, UTF-16 positions;
- diagnostics, hover, completion, code action with edit;
- definition/references/rename;
- JSON-RPC errors and string IDs;
- shutdown/exit;
- correct .mn VS Code extension.

#### H3 — Browser as thin local-first renderer

Status: PARTIAL

Risk: the browser currently contains a second JS semantic mirror.

Outcome: One long-lived local service/compiler receives deltas and returns
protocol objects.

Acceptance:

- no JS semantic tokenizer/inference/ranker/fix table;
- offline operation and no source egress;
- parity with CLI golden responses;
- cancellation/version ordering;
- bounded memory over long sessions.

#### H4 — CLI and service contract

Status: PARTIAL

Outcome: One addressable medium with explicit automation commands.

Required:

- mentl <path-or-address> opens or projects the natural next state;
- check, compile, run, test, fmt, and serve remain stable scriptable operations;
- Query, Propose, Teach, and Why remain aspects of one cursor projection in the
  common protocol. Any batch spelling is generated transport over that
  protocol, not a second tentacle-as-subcommand semantic catalog;
- every diagnostic prints an address usable by query/why/edit;
- JSON protocol has versioned schemas and deterministic output;
- exit status and stdout/stderr contracts are fixed and tested.

#### H5 — Modules, packages, builds, and foreign boundaries

Status: PARTIAL

Outcome: Reproducible projects, explicit dependencies/capabilities, and safe
interoperation without host-language drift.

Acceptance:

- A clean arbitrary directory can install the pinned tool, create or clone a
  project, check, compile, run, and test it without relying on the concatenated
  wheel or repository-relative paths.
- canonical project/package metadata generated from the import graph where
  possible;
- lockfile/content identities and offline build;
- capability declaration at FFI/resource boundary;
- generated typed bindings share B8 layout descriptors; callbacks, ownership,
  errors, async/control transfer, and resource lifetime never cross as raw
  untyped integers;
- incremental multi-module build;
- cache poisoning and path traversal tests;
- schema/version migration policy.

#### H6 — Documentation and learning path

Status: BLOCKED

Depends on: honest live capability rows for every documented walkthrough.

Outcome: A beginner can start sequentially and discover effects, ownership,
continuations, and topology only when needed; experts can inspect exact proofs.

Required artifacts:

- five-minute first program;
- five operators by real use case;
- effects/handlers and negative proofs;
- ownership without annotation noise;
- multi-shot search/debug example;
- structured parallel schedule;
- durable workflow only after E5/F7;
- cursor/Why/teaching tutorial using production surfaces;
- error catalog generated from diagnostic definitions and gates.

#### H7 — Standard library, tests, observability, and compatibility

Status: PARTIAL

Outcome: ordinary programs have a small coherent library and a release-grade
test/observe story without bypassing effects, topology, ownership, or evidence.

Required:

- specify and gate core sequence, product, sum, numeric, text-as-[Byte], file,
  process, time, random, networking, and collection APIs from conforming std/*.mn
  rather than comments or host conventions;
- make tests ordinary Mentl computations with typed fixtures, property
  generators, deterministic logical time/randomness, expected diagnostics, and
  effect handlers;
- project traces, task trees, region high-water/drop, effect events, replay
  cursor, and Why evidence through the common protocol with bounded overhead;
- version public packages, serialized schemas, protocol objects, and diagnostics
  with explicit compatibility/migration policy;
- keep optional adapters outside the minimal kernel and refuse missing host
  capabilities precisely.

Acceptance:

- the standard library compiles through the normal module graph with zero hidden
  prelude injection;
- tests run identically from CLI, service, and CI manifests;
- trace/Why correlation identifies the same EvidenceId without changing program
  semantics;
- compatibility fixtures cover one supported upgrade and one precise refusal.

### I — Formal trust, security, performance, and release

#### I0 — Core calculus and mechanized properties

Status: ABSENT

Model:

- parameter products with holes;
- five topology operators;
- Boolean parameterized effect rows;
- handlers and exact activation worlds;
- quantitative ownership;
- refinements/obligations;
- one/multi-shot control;
- regions and structured tasks.

Prove or mechanize:

- preservation/progress for executable programs;
- productivity and containment for incomplete programs;
- effect/negative-row soundness;
- ownership/no-use-after-move;
- continuation world safety;
- region safety;
- schedule coherence for eligible programs;
- snapshot/resume equivalence under replay policy;
- incremental result equivalence.

#### I1 — Translation validation and executable invariants

Status: ABSENT

Outcome: Each compilation emits a certificate/check that LowIR/WAT preserves
typed boundaries, representations, effect evidence, regions, and control edges.

Acceptance:

- mutation tests of field offsets, representations, handler evidence,
  continuation metadata, and reset placement fail validation.
- Wasm validation is necessary but not sufficient.

#### I2 — Property, fuzz, and differential testing

Status: ABSENT

Qualifier: scattered tests exist, but no systematic generated program does.

R1 milestone: generated parser/formatter, type/row, ownership, bounds,
representation/ABI, module, and reference-Seq differential suites cover exactly
the R1 capability manifest in clean CI. Image, LSP, Thread, SIMD, and GPU fuzz
matrices activate only with their later claimed tiers.

Required:

- parser/formatter round-trip generation;
- type/effect/row algebra properties;
- ownership/control/region small-step oracle;
- AST-context continuation matrix;
- malformed image/JSON/LSP/FFI fuzzers;
- schedule randomization;
- clean versus incremental differential builds;
- current compiler versus reference interpreter for the core calculus.

#### I3 — Diverse double compilation and reproducible release

Status: ABSENT

Outcome: Trust does not rest on one self-hosting binary.

R1 milestone: the supported Wasm release has pinned source/toolchain identities,
a clean-room reproducible build, signed checksums/provenance, and a diverse
bootstrap or independently implemented comparison sufficient to expose a
self-consistent wrong wheel. Later tiers extend the same receipt to new hosts
and backends.

Acceptance:

- reproducible source/archive/toolchain identities;
- independent compiler path or diverse bootstrap comparison;
- signed checksums/provenance;
- clean-room rebuild;
- fixed point across supported hosts;
- no dependence on ephemeral addresses or filesystem ordering.

#### I4 — Security and capability review

Status: ABSENT

R1 milestone: workspace-rooted symlink-safe file/process access, no automatic
execution or patch application from an untrusted project, local-only source by
default, least-authority host imports, dependency/cache/path validation, and
enforced compile/synth/run resource limits. IFC declassification, encrypted
images, replay, and remote resource rebind are later-tier additions and cannot
be claimed in R1.

Required:

- workspace-rooted, symlink-aware filesystem access;
- local-first proposer policy and visible data projection;
- typed IFC and explicit declassification;
- authenticated/encrypted continuation images;
- least-authority, expiring resource capabilities;
- untrusted workspace cannot auto-run code/patches;
- cancellation and resource budgets for synth, Why, compile, replay, and tasks;
- fuzzed decoders and host boundaries.

#### I5 — Performance budgets

Status: ABSENT

Qualifier: measurements exist, but no enforced budget suite does.

R1 milestone: fixed representative hardware enforces cold/warm arbitrary-project
build, formatter/edit response, peak/high-water compiler memory, arena reclaim,
ordinary CPU runtime, and the CPU CFC workload. R2 adds incremental
cursor/proposal, MultiShot, feedback, and Thread work/span; R3 adds
image/replay/SIMD/GPU budgets.

Measure:

- cold and warm build;
- edit-to-diagnostic and edit-to-cursor;
- dirty-cone size;
- peak/high-water memory;
- arena reclaim and continuation fork cost;
- one-shot/multi-shot handler overhead;
- Why/minimal-cause latency;
- Seq/Thread scaling and work/span;
- SIMD/GPU transfer break-even;
- checkpoint/image size, restore time, and journal overhead.

Initial interactive targets:

- syntax feedback within one animation frame on a representative project;
- warm cursor projection near 50 ms;
- warm diagnostics/proposals near 200 ms and cancelable;
- no full-project scan at keystroke cadence;
- bounded memory over long sessions.

Budgets must be revised from measurements, never protected by weakening
semantics.

#### I6 — External comparison bar

Status: ABSENT

Qualifier: no superiority claim is earned before this comparison program lands.

Mentl may call an axis superior only after a reproducible benchmark or semantic
case study against the relevant frontier:

- Koka/Effekt/WasmFX: handler expressiveness, one-shot overhead, multi-shot
  semantics, and region/state interaction;
- Hazel: meaningful incomplete states, typed holes, incremental typing,
  contextual documentation, and live evaluation;
- Rust/Swift: memory/data-race safety, diagnostics, progressive concurrency,
  cancellation, and structured tasks;
- Temporal/Restate/DBOS-class systems: crash recovery, replay, effect
  idempotency, observability, and upgrades;
- Faust and array/device systems: feedback/DSP causality, allocation freedom,
  SIMD/device performance;
- Lean/Dafny/refinement systems: proof trust, counterexamples, and explanation.

The comparison must state hardware, tool versions, programs, correctness oracle,
latency/memory, and failure cases. The strongest result may be Mentl’s
integration across axes; do not disguise a weaker individual subsystem.

Primary comparator starting points (verify current versions when executing I6):

- Koka language book: https://koka-lang.github.io/koka/doc/book.html
- Effekt regions: https://effekt-lang.org/tour/regions
- WasmFX typed-continuation explainer: https://wasmfx.dev/specs/explainer/
- Hazel live functional programming: https://hazel.org/
- Hazel incremental typed-hole work:
  https://hazel.org/papers/incremental-wits25.pdf
- Swift approachable-concurrency vision:
  https://github.com/swiftlang/swift-evolution/blob/main/visions/approachable-concurrency.md
- Restate journal/durable-execution concepts:
  https://docs.restate.dev/foundations/key-concepts

#### I7 — Proof-preserving optimization

Status: SCAFFOLD

Current truth: the code named “egraph” is a directed canonical
weave/peephole island and is not production equality saturation. Do not claim an
e-graph optimizer until equality classes, saturation, extraction, and direct
production gates exist.

Outcome: optimization consumes typed equivalences and emits a translation
receipt preserving values, effects and their order, ownership, worlds, regions,
control multiplicity, traps, and evidence.

Actions and gates:

- define a small trusted rewrite kernel with side conditions over exact graph
  facts; distinguish canonicalization, local rewrite, equality saturation, and
  backend lowering in metrics and claims;
- use equality saturation only where a bounded e-class budget and terminating
  extraction policy beat the simpler canonical weave;
- include work/span, allocation, device transfer, image size, and interactive
  invalidation in the cost model without changing semantics;
- differential and translation-validation tests compare optimized,
  unoptimized, reference-interpreted, and clean/incremental results;
- mutation of a rewrite premise, effect order, width, region, or continuation
  multiplicity makes the validation gate fail.

#### I8 — Flagship vertical slices

Status: ABSENT

Outcome: Mentl's integration is proved on whole developer journeys, not only
micros or self-source.

Required oracles:

1. Arbitrary-directory product loop: install, create/clone, edit a hole, receive
   a proved proposal and Why, apply transactionally, check, compile, test, run,
   and reproduce the artifact from CLI/service/editor skins.
2. CPU CFC signal pipeline: first pass a planted synthetic modulation oracle
   with negative controls, then process a real recording end to end under
   measured memory and performance budgets. Scientific success criteria must be
   preregistered; a plausible plot is not a pass.
3. Multi-shot search/debug: fork alternatives with mutable handler state,
   inspect why-not evidence, fill one suspension without rerunning the proved
   prefix, and compare with a clean run.
4. Structured Thread fanout: real overlapping workers, nested continuations,
   cancellation/failure, child arenas, and Seq-equivalent semantic digest.
5. Ultimate durable workflow: after E5/F7, kill the process, upgrade or migrate
   the code/schema under policy, rebind resources, and resume with an auditable
   journal. This does not block R1 unless explicitly promoted.

Each slice publishes source, inputs, expected results, negative controls,
hardware/tool identities, timings, peak memory, evidence receipts, and the
exact production commands.

## §6 · Bootstrap reality

The deleted seed is archaeology. The live compiler is the pinned
boot/mentl.wasm described by boot/PROVENANCE.md; src/**/*.mn plus the live
library/runtime sources are the wheel. Use tools/wt-env.sh for WABT/wasmtime
features and tools/march.sh for transitions—never reconstruct flags by hand.

The current board reports a byte-identical m2 == m3 fixed point. That proves the
pinned wheel reproduces its current output under the current march; it does not
prove semantic correctness, module-entry correctness, portability, or freedom
from trusting-trust. Micros, adversarial fixtures, ordinary-project probes,
translation validation, and diverse compilation prove separate properties.

Current substrate constraints that sequence the work:

- compilation still relies on a monotonic bump image with no runtime region
  reset/drop; self-compilation approaches the four-gigabyte Wasm32 ceiling;
- emitting the exact Alloc contribution in infer_seq_op has already been
  measured to push m3 over that ceiling, so E0–E2 precede B3's final row fix;
- the ordinary mentl compile main module path currently omits vocabulary the
  concatenated wheel supplies, so self-host and arbitrary-project entry are
  distinct gates;
- current strings/sequences, list strides, variants, records, closures,
  evidence, handlers, and continuations contain legacy layout conventions; B2
  and B8—not a comment—establish their final ABI;
- compile-time region/escape facts are real for their covered path, while arena
  allocation, O(1) reclamation, relocatable images, and durable restart are not;
- restricted heap continuation records are real, while general delimited
  contexts, exact world enforcement, Thread interaction, and restart are not.

### §6.1 · Current sequence representation debt

The present flat/view/list encodings are bootstrap representations, not a second
surface ontology. String is [Byte]; `++` and structural equality are one
sequence derivation; B2/B8 make element representation choose width, stride,
alignment, load/store, and packed-byte specialization. Until then, current
layout behavior is measured artifact truth and unsupported cases refuse—it is
never promoted into syntax.

Wheel map to re-anchor before changes:

- graph.mn/types.mn/effects.mn/infer.mn: facts, types, rows, evidence inputs;
- own.mn and region-related handlers: use/access/lifetime analysis;
- lower.mn and backends/wasm.mn: control, representation, scheduling, emission;
- parser.mn/formatter.mn/module and driver paths: authored surface and project
  entry;
- mentl.mn/cursor*.mn/query.mn/voice.mn/lsp.mn/serve.mn/ide: felt projections;
- boot/, tools/, tests/frontier, tests/crown, and proof gates: artifacts and
  current oracles.

The exact resume procedure is §10. Any semantic compiler change must be seen
red, marched through the correct generation, checked for the fixed point that
the live script actually asserts, and re-pinned only when emitted bytes change.

## §7 · Current state, routing, and immediate critical path

The dated board near the top of this file is the sole prose snapshot. Git and
boot/PROVENANCE.md are the landing ledger; A0's manifest becomes the generated
live board. Do not copy volatile counts into packet prose beyond a focused
baseline.

Current cursor: A0's `NEXT — direct/proxy capability registry` subpacket. Do not
start a compiler semantic change until that removal-mutation loop can tell a
direct gate from a proxy.

After A0's first slice, follow this topological order; parallelize only items on
the same rung whose writers and artifacts do not overlap:

1. Continue A0 persistently; land B0's conformance matrix, bottom-type fix, and
   normative-delta decisions; start I0's minimal calculus/reference semantics,
   I2 generators, I4 threat model, and I5 baseline budgets.
2. A1 makes every unsupported accepted path refuse; H0a begins the total
   formatter because B0/F0/C3/G2 require its renderer and round-trip gates.
3. B1, B2, B4, B5, B7, and B8 close silent operator, sequence, handler,
   ownership, structural/module, and representation defects. F0a lands the
   structural Seq laws for all five operators before E/D reason about their
   control.
4. E0, E1, and E2 land transitive lifetime truth, destination allocation, and
   bounded per-declaration arenas; enforce peak-memory/OOM budgets immediately.
5. B3 carries exact effect rows including Alloc; B6 lands revision-local logical
   proof/IFC soundness; H0a completes before F0b's exact
   row/evidence/formatter integration;
   A3 regenerates the census owner map; A2 reaches zero hard wheel errors and
   universal SError refusal. F1-base/F2 may now begin feedback and schedule
   eligibility without waiting for durable images.
6. C0, C1, and the minimal C2 evidence authority land stable identities,
   complete transactions, and append-only evidence; then finish B6's durable
   EvidenceId integration and drive phantom comment symbols to zero.
7. C3/C4 finish clean-vs-incremental equivalence and one Project protocol.
   G0–G5 and H1/H4/H5/H7 then qualify the R1 cursor/Why/editor/CLI/project/
   library surfaces; H0b finishes after G2. Begin I1 translation validation
   once B8's LowIR/ABI descriptors stabilize. The R1 milestones of I2–I5 must
   also be green before release.
8. D0, D1, D2, D3, and D4 land universal control, exact worlds, fork policy,
   shared Fill, replay, and timeline semantics against the I0/I2 oracle. As soon
   as D2 is green, F1 fork integration and F3/F4 may land feedback-fork policy,
   TaskGroup, and real Thread on E2 arenas; they do not wait for E3–E5. G6 may
   land once C1–C4, D0–D3, and E0–E2 are green.
9. E3 proves reset placement with I1. G7-in-process then joins D4, E3, F1 fork
   integration, F3/F4, and G6 into safe-epoch R2 time scrub. H2 and H3 project
   the same C/D/F/G facts through LSP and browser parity. H6 publishes only
   tutorials whose manifest tier is already qualified.
10. E4/E5 build relocatable typed images and crash-safe journals on D4 replay—
    not before it; only then may F7 and the durable G6/G7 extensions claim
    cross-process time. F5/F6 independently qualify after F2/B8 and their
    backend proofs.
11. I3 extends reproducible/diverse trust to later hosts/backends; I6/I7 qualify
    comparison claims and optimization. I8 runs continuously as integrated
    release evidence, not one final demo.

When a measurement invalidates an edge, update §5.R and this generated path in
the same patch. F5/F6/F7, cross-machine durability, native backends, WasmFX, and
MI300X are not allowed to block R1 unless §11 explicitly promotes them.

## §8 · Verification surface

### §8.1 · Five operators

| Operator | Type/effect gate | Ownership gate | Control gate | Runtime gate | Explain/format gate |
|---|---|---|---|---|---|
| |> | exact one-hole stage | move/borrow from callee parameter | suspend in any downstream stage | effect order/reference result | stable topology/evidence/round trip |
| <| | N branch result and row union | immutable borrow, no escape | forkable branch continuations | Seq then Thread equivalence | authored glyph and branch Whys |
| >< | one N-ary boundary | disjoint owned inputs/regions | task-scoped branch continuations | deterministic results/failures | branch identity and schedule Why |
| ~> | exact row subtraction/addition | activation state ownership | captured world/lexical prompt | shadowing/call-through behavior | precedence/scope/activation Why |
| <~ | typed FeedbackSpec/Iterate context | state owner/fork policy | epoch snapshot/resume | delay/filter/backpressure sequence | causal-cycle rendering and Why |

### §8.2 · Continuation matrix

The R2 in-process “general multi-shot” claim requires:

- every evaluation context;
- every supported representation;
- nested handlers and called functions;
- same-name/different-activation worlds;
- parameterized effect worlds;
- mutable, immutable, linear, and external captures;
- double resume/abandon;
- nested/forked state;
- Thread interaction;
- region freeze/drop;
- in-process fill-and-resume and clean-run equivalence.

The R3 durable extension additionally requires a relocatable typed image,
replay/effect journal policy, resource rebind/migrate/deny, corrupted-image
refusal, and kill/restart in a new process. Failure of the R3 extension does not
erase an independently proved R2 in-process control claim.

### §8.3 · Schedule matrix

| Schedule | Selection must be legal .mn | Direct execution evidence | Equivalence | Failure law | Resource/lifetime law |
|---|---|---|---|---|---|
| Seq | default | production fanout | reference | structural aggregation | child scope |
| Thread | handler | >=2-worker barrier | semantic digest | deterministic aggregation/cancel | shared memory + child arenas |
| SIMD | handler | v128 WAT | numeric oracle | refuse unsupported | lane repr/alignment |
| GPU | handler | real device kernel | Seq oracle | device diagnostic | transfer/resource manifest |

### §8.4 · Durability matrix

| Policy | Legal .mn install | Direct evidence | Replay law | Failure law | Image/resource law |
|---|---|---|---|---|---|
| persist(...) | separate `~>` handler around eligible computation | kill/restart in a new process | journal/effect digest | crash-safe old-or-new commit | typed relocatable image plus rebind/migrate/deny |

The persistence handler may wrap Seq or Thread work; it never changes Strategy
or makes an ineligible computation portable.

### §8.5 · Medium parity matrix

For one golden project/revision/cursor, CLI, editor, LSP, and browser must agree
on:

- stable address;
- type and representation;
- exact effect row;
- ownership and region facts;
- proof obligations;
- diagnostics and applicability;
- proposals, refutations, and tie question;
- topology and schedule;
- Why evidence hash;
- suspension/timeline identity when running.

## §9 · Hard-won laws

1. Carried Truth: a fact is written once at its semantic origin; every consumer
   reads the edge. Re-derivation is a defect even when it currently agrees.
2. Artifact Before Story: labels, comments, plans, green proxies, and memories
   are hypotheses until the production artifact and a negative control agree.
3. Refuse the Lie: unsupported behavior stops before emit; a convenient scalar,
   Seq fallback, raw pointer, empty row, or zero handle is not progress.
4. Identity Before Layout: field names may key declared products and hashes may
   key immutable content, but binding, activation, world, task, region, and
   evidence identities never come from position or unscoped text.
5. Productive Under Error, Exact At Emit: check/edit may retain independent
   errors and V_Pending obligations; executable boundaries retain no reachable
   hard error or unresolved value hole. V_Pending still compiles by default as
   docs/SYNTAX.md requires, while unlocking no proof-dependent optimization,
   capability, unchecked operation, fork, schedule, or persistence path.
6. Fixed Point Has Peers: self-reproduction, semantic tests, ordinary-project
   entry, translation validation, DDC, fuzzing, and reproducibility are
   different proof obligations.
7. Space and Time Share Proofs: Thread, MultiShot, regions, snapshots, and
   persistence all ask whether captured state may be shared, copied, rolled
   back, merged, rebound, or denied. One fork-policy calculus answers them.
8. Topology Is Not Schedule: the five verbs state computation shape; handlers
   select policy only at legal lexical sites after eligibility proof.
9. The Medium Has One Read: compiler, cursor, Why, gradient, CLI, LSP, browser,
   debugger, and automation project one revisioned graph and evidence authority.
10. Performance Is Semantic: preserve exact facts early, allocate in proved
    lifetimes, invalidate exact cones, and measure. Never weaken meaning to make
    a benchmark green.

### §9.3 · Reductive and generative design

For every primitive, run both passes. Reductive: remove duplicated node-kinds,
registries, strings, flags, surfaces, and re-derived facts until one semantic
home remains. Generative: ask what multi-shot time, Thread space, Wasm linear
memory, exact effects, regions, evidence, IFC, and the cursor make newly
possible when composed. Novelty is accepted only with a simpler invariant, a
legal surface, an implementable representation, adversarial gates, and measured
developer value.

## §10 · How to resume

1. Read CLAUDE.md, docs/SYNTAX.md, §0, the current board, §5.R, §7, and the
   owning packet in full. Treat comments, skill files, and prior transcripts as
   search hints only.
2. Run `git status --short` and `bash tools/state.sh`; record HEAD, artifacts,
   census, direct gates, peak memory, and any changed failure before theorizing.
3. Confirm there is exactly one `NEXT —` marker. If its dependency is false,
   repair the DAG and NEXT marker first; do not choose an easier packet.
4. Trace legal .mn through parse → graph/infer → effects/ownership/verify →
   lower → emit → host → observed behavior/refusal. Locate the first writer of
   the wrong fact.
5. See the old artifact red with a focused production-path fixture or a safe
   mutation-removal control. State the expected error/status/bytes/value.
6. Implement the smallest complete invariant-restoring slice. A syntax-facing
   semantic change updates docs/SYNTAX.md, B0's matrix, formatter, positive and
   negative examples, and diagnostics atomically.
7. Run the focused gate, adversarial peers, `bash tools/verify.sh`, the live
   fixed-point/frontier/proof/crown/effect gates, and `bash tools/state.sh` in
   proportion to the change. Use tools/wt-env.sh for Wasm tooling.
8. Inspect the emitted artifact when the bug crosses representation, control,
   memory, or host boundaries. Re-pin boot only when bytes change and record
   provenance.
9. Update capability state only if its direct removal control is green; update
   §5.R/§7 and move `NEXT —` to the highest-priority newly unblocked subpacket.
10. Leave the tree with unrelated user work preserved, no scratch artifacts,
    and a concise receipt of commands, results, remaining risk, and next red.

## §11 · Production bar and ultimate qualification

Mentl has release tiers so “usable production compiler” is not held hostage by
unrelated hardware while “ultimate medium” is not quietly reduced to a CLI that
compiles one demo.

### R1 — Production CPU compiler and early-adopter medium

R1 is blocked by:

- A0's generated R1 capability manifest has no unowned or proxy-only row: every
  claimed form/domain names its direct gate, mutation/negative control,
  out-of-scope refusal, security boundary, and measured budget;
- an arbitrary-directory user can install the pinned tool, create/clone a
  project, and check/compile/test/run a Wasm artifact through the normal module
  graph with stable exit/stdout/stderr contracts and no repository-relative or
  concatenated-wheel dependency;
- docs/SYNTAX.md has a mechanically checked conformance matrix for every claimed
  form; the wheel has zero hard errors; every reachable SError and unsupported
  path refuses nonzero with zero artifact bytes; V_Pending retains its specified
  productive default without unlocking proof-dependent paths;
- B1/B2/B4/B5/B7/B8, the sound conservative R1 slices of B3/B6, and F0
  provide sound CPU/Seq semantics, exact supported effect rows and negative
  proofs, checkable refinements, exact layouts, safe bounds, modules, handler
  identity, quiet ownership, and all five operator laws for the supported set;
  unsupported control/schedule/device/image forms refuse;
- E0–E2 bound compiler memory with real per-declaration arenas and explicit OOM;
  fixed point, direct adversarial gates, ordinary-project gates, reproducible
  manifests, security baseline, and enforced build/memory budgets are green;
- the R1 milestones of I2/I3/I4/I5 run in clean CI: generated/reference
  differential and fuzz gates, diverse/reproducible compilation, signed
  checksums/provenance, threat controls, and fixed-hardware budgets all pass;
- public release metadata names supported hosts, semantic/version compatibility,
  license and third-party notices/SBOM, vulnerability reporting, and the exact
  reproducible source/toolchain receipt;
- formatter, CLI/service, minimal transactional edit/cursor/Why, standard
  library, and test workflow are production-routed rather than proxy islands;
- the CPU CFC slice passes preregistered planted-modulation positives and
  negatives, then processes a real recording end to end with published
  correctness, performance, and peak-memory receipts.

R1 explicitly does not require GPU, MI300X, a native backend, WasmFX,
cross-process/cross-machine durability, full time scrub, modal-effect closure,
or full IFC expressiveness beyond the sound conservative row/refusal core.
Those paths must refuse honestly and remain named work; their
absence cannot be marketed as present.

### R2 — Differentiated live concurrent medium

R2 requires one ProjectImage and protocol, stable cursor identities, clean-vs-
incremental equivalence, append-only evidence, release-equivalent proposals,
teaching ambiguity questions, full Why projections, general D0 control contexts,
exact worlds/fork policy, typed fill-and-resume, causal feedback, structured
TaskGroup, a real Thread schedule with overlap, cancellation, child arenas and
Seq-equivalent semantic digests, and E3-proved reset placement for in-process
time scrub over safe epochs.
CLI, editor, LSP, and browser pass the same golden protocol matrix; no skin owns
semantics.

### R3 — Durable qualification

R3 qualifies E4/E5, cross-process replay, typed relocatable images, crash-safe
journals, resource rebind/migration, persistent branch tasks, and durable time
scrub. SIMD and GPU are independent heterogeneous qualification badges, not R3
prerequisites; each requires legal .mn selection, real vector/device execution,
Seq or numeric oracle equivalence, resource/lifetime proof, and refusal tests.
WasmFX/native backends likewise remain optional projections proved by the same
control semantics, never alternate language meanings.

### Ultimate finish condition

Beyond R1–R3, Mentl earns the full SOTA-surpassing goal only when the following
claims are direct, adversarially tested, production-qualified, and measured:

### §11.1 · Semantic integrity

- docs/SYNTAX.md has a complete conformance matrix.
- The wheel has zero hard errors.
- Every reachable hard error refuses every executable artifact.
- No known silent fallback exists.
- Effect instances, negatives, ownership, refinements, worlds, regions, and
  representations are exact.
- Core preservation/progress and schedule/snapshot properties have a
  mechanized or independently checked story.

### §11.2 · Computation

- All five operators have direct semantic gates.
- General continuations cover every expression context and representation.
- OneShot is fast and linear; MultiShot is safe under explicit capture policy.
- Seq/Thread are structured and observationally coherent.
- SIMD/GPU schedules and persistent execution are claimed only when their
  separate direct gates are real.
- Feedback has causality, state isolation, clocks, and backpressure.
- Arenas reclaim safely; images relocate and recover after process death.

### §11.3 · Medium

- One transactional ProjectImage powers every surface.
- Incremental results equal clean rebuilds.
- Cursor addresses are stable.
- Every facet and action carries evidence.
- Gradient candidates pass release-equivalent verification.
- Ambiguity asks one useful question.
- Why, why-not, what-if, minimal-cause, and why-changed work.
- Fill-and-resume and time scrub preserve exact world/effect semantics.

### §11.4 · Developer experience

- Formatter is total and idempotent.
- CLI contracts are stable and scriptable.
- LSP passes synchronization/conformance gates.
- Browser is a thin local-first client.
- Packages/builds are reproducible and safe.
- A newcomer can remain sequential and annotation-light.
- An expert can inspect every proof, schedule, resource, and runtime branch.

### §11.5 · Trust and performance

- CI runs direct, adversarial, property, fuzz, differential, fixed-point, and
  diverse-build gates.
- Security boundaries and persistence decoders are reviewed and fuzzed.
- Interactive, compile, memory, continuation, schedule, and restore budgets are
  enforced.
- Every superiority statement names a reproducible comparator and result.

At that point Mentl is not “finished forever.” It is coherent enough that
further solvers, schedulers, devices, proposers, transports, and libraries can
arrive as handlers and graph projections without reopening the semantic core.
