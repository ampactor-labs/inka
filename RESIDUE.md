# Mentl — RESIDUE.md · the named-peer catalog

> **REFERENCE, NOT READ-PATH.** The contract stays three documents —
> `CLAUDE.md` (method), `PLAN.md` (substance), `docs/SYNTAX.md` (surface). This
> is the full catalog of named positive-form peers: every gap the project knows
> it has, each with exactly one home.
>
> **Why it left `PLAN.md` (2026-08-05).** 1,474 lines of catalog against ~180
> lines of actual program. The law it serves — *a hidden gap is drift; a named
> positive-form peer is the ultimate form* — is satisfied by the gap being
> WRITTEN DOWN in one place, not by it being in the read path. `PLAN.md §11`
> names the peers each phase touches; this file holds the rest.
>
> **The law is unchanged.** A gap that lives only in a comment is not named
> (measured 2026-07-31: ten `lower.mn` peers existed only in comments and were
> invisible to the roadmap, to `mentl teach`, and to the frontier ranking). A
> gap that lives only in a session's memory is not named either. It lands here,
> or it does not exist.
>
> **Entries are dated observations, not standing truth.** Several below record
> measurements later refuted — deliberately, per the counted-kills law. Where an
> entry and the artifact disagree, the artifact wins. Verify before citing.
>
> **Its own destiny.** These are the absences the frontier should rank and the
> gradient should surface — `mentl frontier` already ranks holes, pending
> proofs, and tightenings from the live graph. A peer catalog kept by hand is
> the same prose shadow the ledger is, one namespace over.

---

`Hβ.infer.hof-param-row-never-reaches-enclosing` — RESOLVED (2026-08-06): the
crown's higher-order leak, closed by the completion prune's SIGNATURE KEEP-SET
(the third keep category, `effects.mn row_keep_completion`). The prune's "no
constraint can arrive" reading is false for a free judgment-era row root the
decl's signature reaches — it escapes through instantiate at every call site,
and generalize's signature collection quantifies exactly it — so the
two-category form dropped `run(f) = f()`'s param row edge (root 29 vs ceiling
26 by binary-patch wat probe) and published `run : Pure` while the row var
rode the scheme disconnected. The fix: `signature_free_roots(param_handles ++
[ret_handle])` at each fn-shaped `inf_exit_fn` site (named decl + lambda;
scope exits pass `[]`), computed THROUGH the live cells at exit —
`free_in_ty(chase_deep(TVar(cell)))`, deep-chased — and threaded to the
prune, whose free arm keeps any root the set contains.

MEASURED, one run deciding both banked hypotheses: the keep census showed
`[SIGROOTS run]` containing the exact severed root and `[PRUNE keep-sig]`
firing on it (29/25 unannotated, 69/66 annotated — both judged passes);
crown flipped 4/1 → 5/5 (leak-higher-order rejects, both sound controls
accept); the wheel self-compile census stayed 0 under the honest rows. The
keep adds NO quantification (its roots are already the signature
collection's), so the qvars(f) = Σ refs × qvars(callee) blowup bound the
prune exists for is untouched.

WHY THE 2026-08-05 ATTEMPT WAS INERT — hypothesis (a), the collection: it
never contained the root, because the live root is reachable only THROUGH
the cells the body bound, and the entry unify's union direction does not
track mint age (c04's annotated row var, minted at pre-registration, still
chases to a judgment-era root — the measurement that killed the
classify-by-mint-position hypothesis). Hypothesis (b) — a downstream
re-drop — was eliminated by the same run: set contains the root ∧ the row
publishes. Graduated crucibles: `tests/crown/leak-hof-named-arg.mn` (the
named-argument face) and `leak-hof-annotated.mn` (the annotated face);
`c03_no_neg` stays a research fixture (its refusal class is
`E_EffectUnhandled`, outside the crown gate's `E_EffectMismatch` grep).

CITATION HYGIENE — corrected in place, and the correction matters: this peer
was opened on a small-model SUMMARY of arXiv 2510.20532 whose "§5" claimed the
mechanism is *propagate the parameter's effect variable upward into the
enclosing row*. **The paper says something materially different.** Balik,
Jędras and Polesiuk (*Deciding not to Decide: Sound and Complete Effect
Inference in the Presence of Higher-Rank Polymorphism*, 23 Oct 2025, read
directly, pages 1–9) DELAY the decision: effect *guards* postpone whether a
locally-bound variable appears in a given effect, and constraints leaving a
quantifier's scope are transformed into formulae of propositional logic to be
solved later — hence the title. Their setting is rank-N polymorphism with
*subeffecting constraints* carried in algebraic type schemes (`∀Δ.[Ω] τ`),
which Mentl's schemes do not have; their effects are set-like with a join
monoid, which Mentl's row triple does match. So the paper is a real and close
neighbour, not a drop-in: adopting it means adopting constraint-carrying
schemes, which is a design decision for `Hβ.infer.schemes-are-edges` to weigh,
not a patch. The carry-don't-drop INSTINCT it supports is sound; any specific
rule attributed to it must be read out of the paper first.

### Named-residue index (entry-born peers not yet in a §5.R band — one home each)

`Hβ.eq.pipekind-match-eq-divergence` — THE CENSUS'S ONE BLIND SHAPE,
measured 2026-08-06 and banked with five kills: `mentl query <file>
"census <~"` answers 0 on files full of `<~` while the other four verbs
and the anonymity shape count correctly. The instrumented walk printed
`[CW] <~ vs <~` — BOTH sides of the comparison render PFeedback through
show_pipe_kind's match — while `pk == k` answers FALSE, an eq/match
divergence on the same pair, surviving even the structural
`$eq_nPipeKind` once the Intent-Boundary annotations routed `==` off the
pointer floor. KILLED IN ORDER: (1) the lexer's `<~` arm sound (60,126 →
TLtTilde); (2) op_prec(TLtTilde)=2 sound; (3) op_to_pipe_kind →
PFeedback sound, the binop builder minting PipeExpr uniformly; (4) the
pointer-eq floor — real (census_matches compiled to raw i32.eq until the
`shape: CensusShape, body: NodeBody` annotations; the documented
pointer-eq-on-names class, on an ADT) — fixed, verdict unchanged; (5)
the mixed sentinel/boxed-nullary hypothesis — a sentinel-vs-record-tag
arm added to emit_eq_leaf_sum's guard was REVERTED after the march ruled
BROKEN (m3 ≠ m4, m4 refusing with 18 undischarged claims — the one
structural `==` serves the wheel's own row membership and dedup, so a
guard change moves inference wheel-wide; and the census still answered 0
through m3, refuting the hypothesis independently). THE NAMED NEXT
PROBE: binary-patch `$eq_nPipeKind`'s entry in the emitted m2 to print
the raw (a, b) words for the `<~` pair — the two values that render
identically and compare unequal, read as integers, decide the
representation question in one run. Instruments preserved at
.build/research/crown-2026-08-05/ (the verbs-all fixture, the [CW]
census transcripts). The facet ships with this one shape's blind spot
named; the frontier leg pins the four sound verbs + anonymity.

`Hβ.query.decl-site-file-coordinates` — a query's Reason span answers in
the linked blob's coordinates and names no file, so "where is NAME
declared, as file:line I can open" has no projection: `query src/infer.mn
"type edges_keep_completion"` answered span 704:4 while the fn lived in
src/effects.mn, and the 2026-08-06 session fell back to confessed greps
twice for exactly this. The span substrate carries the truth; the facet
is the missing rendering (per-module offsets exist the moment
`Hβ.driver.per-module-env-overlay` gives solo queries their real link
set). Named per the ⟳ law: the hand tool is a confession, and this is
its peer.

`Hβ.effects.directional-fn-row-edge` — RESOLVED at its measured scope
(2026-07-30, pin cd43c23c — the §7 entry THE QUIET FN FITS UNDER THE
CAP carries the record: the positional pre-meet at
infer_call_saturated, row_cap_form as the cap/flow boundary the
297-site census taught, the admit leg registered at frontier 324).
The remaining tail is nested variance (a fn-arg's own fn-params flip
direction again) — out of scope by the original sequencing, the
symmetric meet standing there.

`Hβ.verify.interval-fragment` — ENGINE HALF LANDED (2026-07-30, pin
a71ebbcb — the §7 entry THE INTERVAL FRAGMENT AND THE FLOW LICENCE
carries the record: the two-face lower-bound read in verify.mn, the
value_flows_class licence closing the measured arith-class launder,
the mn-verify-interval fixture + frontier leg, arm row unchanged).
THE CALLEE LEG LANDED same day (pin 5e34f710 — an authored return
rides the pre-registered TFun as a Ty VALUE, so a call's bound reads
the callee's annotation verbatim, uncontaminatable by class merging;
the wrap/base fixture faces prove it; TRANSITION m3 == m4). THE
SELF-CALL IH IS BLOCKED BY THE PEEL, measured (2026-07-30 probe
census, disposable build): at decide time the rec-callee's chased
TFun ret is the PEELED TInt or a TVar (8 tint + 4 tvar across the
fixture's callee/operand reads; the 5 callee reads all reach the
TFun arm) — the value-ret survives the pre-registration but the
class the rec-call actually resolves carries the peeled base, and
the peel reaches PARAM classes too (a comparison's ground unify
re-peels `i: Nat` to TInt), so any class-based IH read fights
nondeterministic representative choice. Two prior discriminator
specs REFUTED in the same dig: class-vs-DECL identity (a top-level
rec-call instantiates a copy — never the decl's class) and the
peel-window reorder (the rebind-first form re-opens the flow-echo
launder). The arc REDIRECTS: the IH lands either on the peel's own
fix (the most-refined representative surviving comparison unifies
and the publish fold — the rebind law completed at every unify, not
just the decl pin) or on Hβ.infer.schemes-are-edges (whose deletion
of the publish/peel/rebind tower dissolves the question). Until
then seek-shaped recursion pends honestly — visible debt, the
system's contract. THE OTHER HALF stays live: the wheel's six
standing `0 <= self` pendings (cursor:297 score_one_position's
handle param · cursor:546 scan_for_span's return · lexer:229's
lex_from arg · main:1272/1437's ph flows · voice:1097's
resolve_cursor_target) discharge via authored refined annotations
whose echo/interval/callee legs the engine honors — one-line
annotations, march-measured each; the recursion-shaped ones
(scan_for_span) wait on the IH. TagId's 0..255 and the float
intervals stay the SMT tier's.

`Hβ.lower.lowering-is-a-column` — LowIR is the second graph (2026-07-30,
the Fable novelty audit's first proposal; report at
.build/research/novelty-fable-2026-07-30.md). LowExpr (lower.mn:240) is
39 constructors, EVERY ONE handle-first, re-materializing structure that
handle already addresses — a third thing beside the graph's two
operations, with its own writer, while lower.mn's own header and PLAN
§6's file map both call lowering "the projected read". The receiving
mechanism EXISTS: spine_page (graph.mn:107) holds seven per-handle
columns and `boundaries` is ALREADY a lowering fact written into the
graph. The design is "more columns, no tree": lowering writes per-handle
columns (yield boundaries, captures, direct-call resolution, twin encs,
state-slot homes), emit walks program plus columns, and the LowExpr/LowFn
trees and their ten walkers delete together. WHAT IT KILLS: the
lower-time-bake class, which the ledger declared dead THREE separate
times (LShow/LHash, field offsets, LPTuple) and which regenerates
because a tree invites baking — with no tree there is nothing to bake
into. It also makes per-decl incremental EMISSION fall out of the same
cone machinery that re-judges, and makes band N's native_m3==m4 a
statement about graph columns (this and the deterministic-handle
partition are one invariant said twice). COST, honestly: the largest
refactor on the board after schemes-are-edges (lower.mn 6,194 lines,
wasm.mn 7,591), and genuinely synthesized shapes — twins, wide wrappers,
k-records, redrive drivers — either mint graph nodes (precedent:
desugar, NModule, synth candidates all mint) or stay emit-era records.
Sequenced after schemes-are-edges by the same method: swap the
representation behind the projections, never patch the walkers.

`Hβ.eval.evaluating-cursor` — the subsystem table's missing row
(2026-07-30, the Fable novelty audit's second proposal). §2's table maps
every subsystem to a cursor-read mode and has NO evaluating mode, while
the artifact carries four hand-rolled evaluator fragments (verify.mn's
node_const_at and the compare/decide family, egraph.mn's const_int /
fold_int, the float parse oracle) plus the 332-line predicate-unfold
that was built and reverted. One `~> Evaluate` handler over the five
node-kinds is the medium's own answer, and it doubles as arc 7's missing
INTERNAL reference semantics (the correctness oracle is external today —
§0's own standing !Outside). Overlaps the banked unfold as its larval
form, stated plainly by the auditor.

`Hβ.own.linear-tier-and-persist-value-barrier` — RESOLVED at both halves
(2026-07-30; the Fable novelty audit's third proposal, built first
exactly as it argued — row-neutral to the judgment spine, and it was).
Half (a) the relevant tier: pin b77f345b (§7 AFFINE GAINS EXACTLY-ONCE —
consume_declare / consume_exit_fn's T_OwnUnconsumed narration), its
eight wheel findings swept to ZERO the next landing. Half (b) the
persist VALUE barrier: pin 16da60bd (§7 THE OWN CANNOT CROSS THE WIRE —
consume_declared + replay_barrier_gate at the argument edge whose
declared row severs the external triple; T_OwnAcrossReplay at the
capture site; the declared-not-open semantics the probe forced). The
named RESIDUAL, one face: a continuation reified by the MULTI-SHOT
producer and persisted through the word-rooted `persist(k, path)` op
never crosses this argument edge — an open own frozen inside a reified
k's frame rides band B's TCont value gate
(`Hβ.types.resume-world-mismatch-value-gate`), where the world's
capability check and this owns check are the same read at the same
boundary.

`Hβ.egraph.install-algebra` — the `~>` edge enters the e-graph
(2026-07-30, the Fable novelty audit's fourth proposal). The e-graph
rewrites VALUES and nothing rewrites INSTALLS, while every install pays
an unconditional world push/save/restore (wasm.mn:2463-2472, whose R1
comment calls it "the invariant, not an optimization"). Three
row-licensed moves as canon rewrites: ELISION (an install whose extent
provably performs none of its ops is inert), HOIST, and FUSION. The row
is the licence in each case — the same effect-awareness that already
gates the dropping rewrites, one altitude up. Sequence after the modal
world-index: install identity is what the modal crown is about, and
rewriting installs before that lands would optimize against a semantics
still moving.

`Hβ.query.generation-operand` — every projection takes a WHEN
(2026-07-30, the Fable novelty audit's fifth proposal, and its most
thesis-shaped). `mentl why` and `mentl at` answer about NOW; nothing
projects a past generation, so the medium cannot answer a question about
its own history and GIT REMAINS THE OUTSIDE TIME ORACLE — an !Outside
the docs never named, found by the auditor hitting it: no verb could
project the source of the very commit it was told to ground on. The
substrate exists on all three axes: checkpoints fork the graph,
ty_fingerprint compares generations, the warm image persists them, and
movers_diff (infer.mn:1335) is the larval two-generation renderer,
stderr-only. A why/at that takes a generation operand diffs two worlds
through the machinery already landed — the TIME axis of §2's own cursor,
pointed at the medium's own past.

`Hβ.types.authorship-is-a-reason` — the one authorship fact is a
substring probe (2026-07-30, the Fable novelty audit's sixth, ranked
last by its own author for arc-7 adjacency). Reason (types.mn:811-846)
has no authorship constructor, so the medium's only record of "a human
chose this" is `reason_is_pinned` testing whether a rendered string
CONTAINS "user pinned" (cursor.mn:471) — prose parsed as data, the
Carried-Truth law at the provenance layer. One wrapper ctor applied at
the three authorship boundaries (accept, tighten, MCP propose) makes
human intent a graph fact the Why chain walks, which is what §0's
lossless-intent property actually requires.

`Hβ.egraph.canon-edge-carries-reason` — the one unreasoned write in the
kernel (2026-07-30, the Opus novelty audit's third proposal; the report
is .build/research/novelty-opus-2026-07-30.md). Every graph write
carries a Reason except `graph_canon_set(Int, Int)` (types.mn:1672):
`rewrite_to` (egraph.mn:115) draws an equivalence with no justification
at all, and `mint_fold` (:243) gives the minted NODE a Reason while the
EQUALITY that legitimizes it gets none. Give the edge its Reason and the
relation gains a distinction it cannot express today — PROVEN (a rule
fired) versus ASSUMED (a path condition holds in this scope) — which is
what turns scoped assumption from a discipline into a structure the
executable gate can refuse (an assumed edge reachable from main outside
its drawing scope). Shape: the `canon: [Int]` spine column becomes a
pair cell carrying (target, Reason) — the comments column's own
precedent, no eighth column — plus a `graph_canon_reason_at` projection
(one op per fact, the graph_comment_span_at precedent). It also makes
band F's `Hβ.verify.reason-edge-pcc-certificate` constructible: an
emission whose optimizations have no derivation cannot be certified.
Small and mechanical; its value is as the belt under
`Hβ.verify.congruence-is-the-egraph` below.

`Hβ.verify.congruence-is-the-egraph` — the second decision procedure
already in the tree (2026-07-30, the Opus novelty audit's first
proposal). Mentl runs TWO engines over the same relation and orders them
so they can never meet: egraph.mn maintains a value-equality union-find
with congruence closure and constant folding, while verify.mn keeps a
PRIVATE constant folder (`node_const_at`, verify.mn:111 — its own
comment admits the duplication) and a hand-written interval interpreter
(`node_lo_tr`, :158), and decides every obligation during inference,
before the first canon edge exists (`compile_remainder`'s
saturate_pass runs after, pipeline.mn:447). No path in verify.mn
reaches `egraph_extract`; `graph_canon_at` has exactly two readers, both
inside egraph.mn. THE PROPOSAL: Verify's discharge becomes a READ of the
canon weave, and a path condition becomes a set of ASSUMED canon edges
drawn inside a graph checkpoint and rolled back at the join — the
`??` fan's own machinery (fork, saturate a range, roll back) pointed at
a different relation. What it buys: path-sensitive proof with no new
engine (`if x == 0` makes `x ≡ 0` readable, so `x * 2` folds and a
proven index elides its check —
`Hβ.infer.narrowing-write-requires-discharge` gains a real discharge
source), the second folder deletes, the interval fragment's
contamination law gains an UNCONTAMINATED relation to read instead of a
workaround to maintain, and a genuine piece of the SMT residual moves
from Outside to inside (congruence closure over ground terms IS the EUF
core). DEP: `Hβ.types.predicate-is-expr` (a predicate must be an
ordinary expression node before it can be saturated) and the canon-edge
Reason above (an assumed edge that survives its scope is a miscompile,
not a missed optimization). Re-measure wall time in its own entry — per-
branch scoped saturation multiplies passes, and the crc/classifier
history is explicit that such a landing must.

`Hβ.types.traversal-is-a-handler` — one descent over `Ty`, consumers as
arms (2026-07-30, the Opus novelty audit's second proposal). Nineteen
functions traverse the Ty ADT re-deriving the same descent and differing
only at the leaves (format.mn:913 · graph.mn:772 · synth_proposer.mn:208
· mentl.mn:543 · types.mn:130/251/272/2518/2974 · lower.mn:3131 ·
infer.mn:1626/4849/6052/6090/6184/6305/6455/6550 · verify.mn:247), and
two of those pairs are one algebra twice (the check-then-build twins
from the A.3 allocation landing). THE MENTL-NATIVE TWIST that makes this
more than a visitor pattern: the four walk SHAPES are exactly the four
RESUME CARDINALITIES — zero-resume/Abandon is `occurs_in` stopping at
the first hit; one-resume-accumulating is free_in_ty / fold_sig / ty_lo
/ extract_row / query_flow_label / repr_of; one-resume-rebuilding is
subst_ty_build / chase_deep_build / fold_strip / ty_handle_of;
multi-resume is `enumerate_typed` enumerating a type's inhabitants. The
discipline the medium already INFERS from arm bodies classifies the
traversal it is used in — the kernel explaining a compiler-internal
pattern rather than a pattern imported to explain the kernel. The tax
being paid: TReprPin (the newest constructor) appears at 26 sites across
9 files; TAlias at 49. BOUNDARIES, stated: binary walks do not fit
(`same_ground` and unify descend two types in lockstep — a zip, not a
fold, and they stay); the hot instantiate-path walks must be measured
into the tail-resumptive tier before landing, not after; and the two
render walks stay distinct registers per §5.U's voice/format boundary —
one descent, never one leaf.

`Hβ.query.refs-reads-edges-not-occurrences` — two measured holes in the
refs facet (2026-07-30, found by the Opus novelty audit while working,
offered as findings rather than proposals; one root — `refs of` walks
VarRef OCCURRENCES instead of reading the edges the graph already drew,
Anchor 1 at the query layer). (1) DAG-SCOPED: `refs of graph_canon_at`
answers 0 from graph.mn and 2 from egraph.mn — the more foundational the
name, the emptier and more CONFIDENT the wrong answer, because a base
module's DAG contains only its dependencies, which by definition cannot
reference it. (2) PATTERN-BLIND: `refs of TReprPin` returns 7, all
construction sites; the 26 match arms that destructure it are invisible
because a pattern binds through PCon, not VarRef — and for an ADT
constructor the arms are the MORE important half, they are the
exhaustiveness surface. Both are why an ADT-walk census still needs a
grep confession. Smaller sibling: `mentl query "type NAME"` on an ADT
answers "declared as NAME" without projecting its variants, and nothing
projects the module import graph though the driver holds it as NModule
nodes with ranges.

`Hβ.query.param-render-reversed` — RESOLVED (2026-07-30, the
comment-voice audit's opening conviction; the §7 entry THE VOICE
CANNOT MISORDER carries the arc). The root was query.mn's private
deep-chase family — chase_params_deep / chase_list_deep /
chase_fields_deep / find_unresolved all walked last/drop_last and
PREPENDED, rebuilding every list REVERSED (params, tuple elems, type
args, record fields, the unresolved set): the show_list disease alive
in a query-side copy, measured at cost first (two swapped calls in one
hour from TRUSTING the projection — collect_free_vars, string_in_list —
each convicted by the census in one march). The walks are the map /
filter|>map vocabulary forms now — order-preserving BY CONSTRUCTION,
iteration-is-topology's own tier — and the frontier pins declaration
order (`type of pair` answers alpha-first). The family remains one of
the nineteen Ty descents; its one home arrives with
`Hβ.types.traversal-is-a-handler`.

`Hβ.voice.comment-mass-absorbs-into-projections` — the wheel is 38%
prose, and almost none of it is the endpoint (Morgan's charge,
2026-07-30: comments belong to the developer — the scratchpad, the
fun-place — because the medium's voice speaks everything load-bearing).
Measured: ~17,762 comment-carrying lines of 47,101 in src/**, nearly
all MECHANISM prose — constraints, measured whys, layout laws — written
by the builder because the voice cannot yet carry them: each line is
larval `mentl why` / `mentl audit` content, the ⟳ confession at the
prose layer (SYNTAX §«What a comment TRENDS TO» now states the surface
law; CLAUDE.md ⟳ the method half). THE ABSORPTION ARC, per family:
measured-why comments → Reason edges a `why` hop renders (the largest
class — "measured 2026-07-XX, N sites" prose is a graph fact with a
date); law/invariant comments → refinements, rows, and armed
diagnostics (a stated invariant the medium could refuse on is a
diagnostic not yet born); pointer comments (`the X precedent`, peer
names) → the residue index read live; layout-rationale comments →
deleted by fmt-canonical (the renderer IS the rationale). The census
instrument is `Hβ.query.comment-prose-search`'s verb reading the weave
— classify by whether the deletion test loses unprojectable content;
the RATCHET: comment mass falls as verbs land, never by suppression
(the drift-marker eradication's exact shape one layer up). The residue
at the limit is authored intent — the one genuine Outside, carried
losslessly, never required.

`Hβ.synth.rank-is-a-projection-not-a-field` — the ranker's two
vocabularies (found 2026-07-30 completing the fork/merge landing). The
`cost: Float` field on EnrichedCandidate is genuinely READ — rank_insert
compares it (synth_proposer.mn:327) — but it is WRITTEN two different
ways: a LIVE gradient read for vocabulary calls (`candidate_rank(name,
decl_reason, hole_span)`, :296 — decl proximity plus use-edge proximity,
the §5 local-intent ranker) and a HARDCODED literal for every shape
enumerator (0.5 ctor :430, 0.6 lambda :438, 0.3 int :454, 0.3 float
:464, 0.2 string :471). So the sort compares a measurement against
invented constants, and a vocabulary call that genuinely ranks 0.25
loses to a literal's made-up 0.3 — the ordering is arbitrary across
origins, in the exact place §5 says the gradient reads local intent.
Extraction sharpened it: when a survivor's node is swapped for a cheaper
e-class member, the stored cost rides along stale. BOTH FACES DISSOLVE
IN ONE MOVE, and it is a DELETION: rank is a PROJECTION of the
candidate computed at sort time (the name read from the node, the reason
and hole span already in hand), never a stored field — after which
`cost` leaves the record, the literals leave the enumerators, and a
swapped node cannot carry a stale number because there is no number to
carry. The shape enumerators then need a real rank source rather than a
constant, which is the design half: structural distance to the hole's
type, or the same proximity read keyed on the ctor/type name.

`Hβ.synth.fan-extraction-needs-a-feeder` — the composition's dormancy,
named with its own artifact (2026-07-30, banked RED at
tests/frontier/mn-fan-extraction-fires.mn, unregistered). The fork/merge
path is live, ordered, and non-destructive, and it CANNOT MOVE ANYTHING
yet for a structural reason: every e-graph rule matches a BinOpExpr
shape (egraph.mn:123-224) while every fan enumerator mints an ATOM
(synth_proposer.mn:684-693 and kin) — the two sets do not intersect, so
extraction always chases a handle to itself and the false-tie collapse
never has two survivors in one class. This is dormant BY CONSTRUCTION,
not broken, and it is stated here rather than implied so no future
reader mistakes a passing gate for a proven mechanism. The FEEDER is
either half: a candidate space that mints composite expressions, or a
rule set that rewrites the shapes the fan already mints (band G's
`Hβ.lower.egraph-saturation-deepen`). The banked fixture is what "fed"
means, and it runs green the day one lands.

`Hβ.effects.negative-stance-under-mixed-gate` — the declared-row gate's
tail asymmetry (measured 2026-07-30, the check-verb landing). A fn
declaring a MIXED row (positives + `!E`) whose body row widened to the
negative stance is REFUSED by its own declaration: row_subsumes' closed
gate arm answers `EtAll => false` by its own written law ("an
unknown-beyond-mask body may perform outside it"), while the mixed
declaration resolves EtClosed — so `with Cast + !Mutate` over a body
proving `Cast(GNode) + !Mutate` mismatches. Measured at
graph.mn's occurs_in_live and inherited by every module weaving it
(egraph). TWO THEORIES DEAD to probes, banked so the fix is not
re-chased: bare-vs-instance is NOT the trigger (a minimal `with Cast`
over `addr(x)` checks clean — eff_name_handle shares the handle
between ENamed and EParameterized, so by-name membership already
admits an instance under a bare declaration), and neither is
negation-beside-positives (`with Cast + !Mutate` on the same minimal
body checks clean). MUTUAL RECURSION is the discriminator (probe four, the minimal RED
banked at tests/frontier/mn-mutual-negation-gate.mn — unregistered,
eight lines, failing on check AND compile AND the concatenated blob
alike): a NON-recursive `!Mutate` callee passes; make the callee a
mutually-recursive pair and the caller's own declaration is refused.
THE ROOT, traced to a named fn: `row_without_self` (effects.mn) takes
the least solution of a recursive row equation — "a tail landing on
the fn's OWN row handle cuts to the closed head" — and that cut is
SELF-only. Under mutual recursion the tail lands on a CO-MEMBER's
handle, so `R_ping = names ∪ R_pong, R_pong = names ∪ R_ping` never
cuts, the row never closes, and the widened tail flows into every
caller until a closed gate refuses it. THE PRESCRIBED FIX ABOVE IS
REFUTED — WIDENING THE CUT IS THE WRONG DIRECTION (2026-07-31, the
source dig; this paragraph is kept as the era's record because a
reader could otherwise BUILD it). The entry proposed taking the
least-solution cut "one scope up" so a tail landing on any SCC member
cuts to closed. The minimized reproduction
(tests/frontier/mn-cycle-charge-freeze.mn) shows the cut IS THE
DEFECT, not its scope: the cycle member whose accumulated tail happens
to keep a live CO-MEMBER edge never cuts and stays CORRECT, while the
member that cuts freezes its row at an instant when its co-members
are unjudged and loses their effects permanently. A group-wide cut
freezes MORE rows, not fewer. TWO ROOT CORRECTIONS also land on this
entry: the effects audit re-diagnosed the refusal itself as the
`EtClosed`-gate × `EtAll`-BODY arm with the `EtAll` manufactured by
the NEGATION PUBLISH (`inter_row` yields EtAll when the body row is
already EtAll), killing the instance-compare and EtAll×EtAll theories
by probe; and `row_without_self` now compares CHASED ROOTS (the
2026-07-31 charge landing), so the self-only-ness this entry names is
already gone. The unconditional-close publish was then MEASURED WRONG
in the guard era (census 70 and m3 ≠ m4 — the withdrawn bb8b93a2
entry's second reverted guess), and the guard half-step itself
reverted (the HALF-STEP REVERTS entry), so the class stands OPEN at
the restored pin exactly as first measured; the DISSOLUTION is the
row half — charges as edges with completion drains, no cut at all.

THE TWELVE-AUDITOR FLEET'S REMAINING PEERS (2026-07-31, banked at their
one home; full reports + the cross-fleet synthesis in
.build/research/audit-*-2026-07-31.md and fleet-synthesis-2026-07-31.md,
each finding artifact-grounded with its own calibration section):

`Hβ.verify.echo-stop-reads-per-leaf` — THE FLOW-FACE LAUNDER, probed
live: a refined return over a JOIN self-discharges through the class
alias, so `fn bad(v: Nat, c) -> Nat = if c { v } else { 0 - 5 }`
compiles with ZERO verify lines and returns -5 through `0 <= self`.
`value_flows_class` tests only the TOP node's shape while
body↔ret↔annotation unified before the constraint read, so the
annotation proves itself. The frontier's "exactly two pendings" holds
by REPRESENTATIVE LUCK (a seek variant whose then-branch is a refined
param discharges silently). FIX: the echo-stop becomes a per-LEAF
coverage verdict over the join spine `node_lo_tr` already walks —
VarRef → its own binding obligation, Call → the callee channel,
literal → GROUND-DECIDE (so the launder UPGRADES to
E_RefinementRejected at the branch), computation → raise. Deletes the
duplicated licence pair (verify.mn:314 ≡ infer.mn:6832). RED banked:
tests/frontier/mn-refine-join-launder.mn.

`Hβ.own.use-after-move` — borrow-after-consume is SILENT (probed:
`grab(buf)` then `len(buf)`, zero diagnostics), correct today only by
the never-free heap — an accident-invariant that becomes a real
use-after-free the moment §5.O layer 3's arena makes Consume reclaim.
One `set_contains(used, name)` read in the ledger's borrow arms closes
it (T_UseAfterMove, census arming law). LAND BEFORE THE ARENA.

`Hβ.infer.grade-is-join-and-mode` — the ownership grade is JOIN-BLIND
(if-branches summed additively, so once-per-alternative counts 2 → Ref
where the affine truth is ⊔-join → Own) and MODE-BLIND (a condition
read counted as a consume), producing a MEASURED FALSE
T_OwnUnconsumed at a clean caller — a false-positive channel inside an
arming-track class poisons its own licence. The fix is a DELETION:
`count_uses` dies into `resume_grade`'s existing ⊗/⊔ Usage fold (which
already gets the same question right for continuations) plus a mode
dimension read from `is_read_shape` / the callee's param product.
Baseline for band H's quiet gate: 84 authored `own` + 763 authored
`ref` in src/ — mostly compensation for this.

`Hβ.parser.unclosed-construct-reports` — an unclosed `effect` or
`handler` brace SILENTLY DELETES THE PROGRAM: both arm loops treat
TEof exactly like a closing brace and their stray-token recovery skips
forward, so `main` is consumed as an effect op, `= 0` is skipped token
by token, and the medium reports SUCCESS on a file with no program in
it (zero diagnostics, exit 0, an empty audit). Data-dependent silence —
the more idiomatic the following code, the more completely it
vanishes. `unclosed_eof` already exists with ONE call site; these loops
never took it. RED banked: tests/frontier/mn-unclosed-effect-brace.mn.

`Hβ.prelude.stage-law-and-reachability` — the shipped vocabulary
violates its own Stage Law at ten public signatures (join · reduce ·
scanl · nth · unwrap_or · starts_with · ends_with · contains ·
index_of · replace), so `"a,b,c" |> split(",")` SILENTLY returns one
part (the pipe fills `sep` with the datum) and `scanl` reverses
`fold`'s argument order — a learner who internalized one writes the
other wrong every time. `tuple_set`'s own documented pipe idiom is a
WILD WRITE at address `a*4`. Beside it: `join`/`unwords`/`unlines`
TRAP in raw WASM (`join_loop`'s unannotated params reach the `++`
no-guess floor — and SYNTAX lists that diagnostic as DISSOLVED, a
doc-truth contradiction to settle at the emit floor). Fixes: flip the
ten signatures, pin `join_loop`'s Intent Boundary, arm the concat
floor as a compile refusal, and add a STAGE-SHAPE audit tier so the
class self-polices (the verb-shape tier's sibling).

`Hβ.runtime.slice-collapse` — `slice_raw` has no collapse branch, so
`rest()`-recursion builds N nested slice nodes and index reads walk the
chain: `zip_with` / `intersperse` / `scanl` / `merge` are quadratic,
`sort` is O(N² log N), and every ML vector primitive inherits it. Four
lines at the one writer (tag-4 parent + summed offsets) make the class
unconstructible; `iterate_from` already pays this bill once by
flattening at its entrance, and taking that workaround a fifth time is
the census law's stop signal. Separable from band D's String work.

`Hβ.lib.vocabulary-gaps` — what a newcomer reaches for and cannot find,
each with its kernel home: `sort_by` (the compare leaf over a key
projection, §5.U); a user-facing `Map`/`Set` (the §4① ordered-keyed-set
unification — `imap` is a compiler-internal primitive that shadows
rather than replaces and fixes 4096 buckets, so word-count is not
writable); `effect Random` with clock.mn's four-tier handler pattern
(host / seeded / record / replay) — which no other stdlib can offer,
because `!Random` PROVES determinism transitively and property testing
becomes a handler swap with exact replay, and today its absence blocks
ML weight init (zeros/ones cannot break symmetry) and lib/test.mn's own
named property tier; a prelude `Fail`/`catch_fail` pair so "errors are
effects" has somewhere to point; and an integer `abs`.

`Hβ.syntax.open-row-tail` — the biggest ceremony in the language: the
kernel's row tail is tri-state (EtClosed / EtVar / EtAll) and the
surface can spell only two. Declaring the one INTERESTING effect on a
body that also touches a list forces `with Memory + Alloc + Tally` or a
standing error-worded report on a CORRECT program. Proposal: `with
Tally + ..` — the record-rest glyph at the row, one absence-marker
family — semantically `row_subsumes`' existing directional gate with an
EtVar tail, zero new algebra, and `mentl tighten` still offers the
closed form as the capability-unlocking move.

`Hβ.run.refuses-on-error` — `mentl check` exits 1 on a file `mentl run`
executes at exit 0: error-worded diagnostics with wrong output, and a
raw wasm trap from the simplest pipe misuse. One bit restores the
contract — the RUN verb reads the diagnostic ledger's error count
before executing (the compile artifact keeps the arming ratchet's
licence), or the word "error" is reserved for classes that refuse. A
student who watches an "error" run learns errors are advisory.

`Hβ.emit.world-walk-memo` — the per-perform world walk is
BODY-INVARIANT: 896 `$world_find` + 1,446 `$ev_perform_node` runtime
walks, and 1,268 of the 1,446 resolve ONE key (the emitter re-resolving
its own output sink per emitted fragment — `$emit_binop` walks the same
key NINETEEN times in a body with zero world writes). A per-body
per-key memo local, invalidated at exactly four emit-visible node
kinds, sound on the call-balanced world the brackets already enforce.
NOT the retired `$state_g` cache. Perf share unmeasured per §5.O's law;
the deletion is sound regardless.

`Hβ.emit.yield-reachability-closure` — the k2 yield wrap is a 240:1
over-approximation: 3,336 wrapped call boundaries and 3,355 flag reads
against 14 real `$__k_extend` compositions (~17k WAT lines of
scaffolding). The algorithm is a `closure_fix`-shaped transitive
yield-reachability over the call graph — exact for the 23.5k
direct-call sites, with the row check surviving only on HOF values.
Composes with band N's frame-rep-from-cardinality.

`Hβ.lower.double-walk-and-dead-fields` — two mechanical deletions the
lower audit proved: the gate and the emit run `walk_lemit` TWICE over
the identical post-reach tree under identical seven-collector brackets
(one bracket hoist, one walk, two drains — the handler IS the state and
the drain IS the read); and `LFn`'s arity and effect-row fields have
ZERO readers at all 24 destructure sites (the `resume_kinds` pattern
verbatim — and `executable_boundary_row` exists solely to compute the
dead row, its refusal half worth keeping under an honest name).
Law-7-inert by construction.

`Hβ.infer.handler-residual-outside-the-scheme` — RESOLVED (2026-08-06,
the same session as the prune fix, five probe-kills deep): the residual
now READS THE INSTALL. The attributed mechanism held — HandlerKind's
raw r_handle bypasses generalize/instantiate — but the dig found THREE
stacked losses, each measured before believed: (1) HandlerKind stored
the PARSE-placeholder config TParams at all three registration writes,
so any install-time read chased dead cells (the census showed cell 4 —
a parse-era handle); it now stores the MINTED tparams the arms bind.
(2) The handler-arm scope's exit ran the completion prune with an empty
keep-set, dropping the arms' config-fn edges — the arm scope's
SIGNATURE is the config cells + the handle-result, so its exit now
passes signature_free_roots(tparam_cells ++ [s_h]) exactly as a named
decl does. (3) A residual that is exactly one config-var edge finalizes
as an ALIAS of that free cell (the flat store's canonical form), and
read_bound_row answers pure on a free root — the measured root-FREE
loss; the residual is now read as the CELL AS AN EDGE
(resolve_row(mk_ef_open([], resid_h))), the same shape a scheme's row
rides. The install completes it: residual_with_config_args joins each
CALLED config arg's row (root-membership in the residual's edge set is
the graph's own record of which config fns the arms call; labeled or
arity-short installs fall back verbatim, the resolve_call_args-shared
pairing named as the refinement). MEASURED: leak-handler-residual
refuses (the crown's leak- contract, seen RED first); the c05 each
fixture (`fn f(xs) with !WASI = each(...)` — the vocabulary face)
refuses; the wheel's own census surfaced 19 falsely-passing sites (18
declaration widens + main's root stack gaining ~> verify_ledger ~>
diagnostics_handler), converging to census 0 with TRANSITION m3 == m4
in two rounds. `Hβ.effects.config-fn-row-in-residual` resolves with it
(one seam, the absorb side — union at the install IS "read the config
row where it already lives"). Rung 3's dissolution of the tower stands
as the deeper form; this closes the soundness hole on the standing
representation.

`Hβ.effects.config-fn-row-in-residual` — RESOLVED (2026-08-06) with its
sibling above: the tee's `extra` is residual_with_config_args — the
residual joined with each called config arg's row, read live off the
install's own arg nodes. One seam, closed at the one absorb site.

`Hβ.lower.*` and kin — TEN PEERS THAT LIVED ONLY IN COMMENTS, banked at
their one home 2026-07-31 (the lower audit's finding 12: each was
declared in a `lower.mn`/`wasm.mn` comment as a positive-form named gap
and appeared ZERO times in this file, so none was visible to the
roadmap, to `mentl teach`, or to the frontier ranking — a gap that
lives only in a comment is a residue-index entry that has not found its
home): `Hβ.infer.order-free-live-row` (lower.mn:1221 — the escaping-row
flow closure's own written dissolution; SUBSUMED by
`Hβ.infer.schemes-are-edges`, whose second uncounted dividend is the
~365-line second effect-analysis engine in lower) ·
`Hβ.lower.diverging-callee-analysis` (lower.mn:1722 — `expr_diverges`
is an AST walk re-deriving a TYPE fact; landing SYNTAX's `-> !` TBang
arm makes it `ty_is_bottom(lookup_ty(h))` and the inter-procedural case
falls out free, so the peer DISSOLVES rather than builds) ·
`Hβ.row.builtin-effect-kind` (lower.mn:1121 — a name-literal ladder
where the env holds the declarations; the severance-vocabulary landing
is the precedent, and the marker's seed-byte-parity argument is STALE:
the seed was deleted 2026-07-10, the constraint is m3 == m4) ·
`Hβ.lower.multishot-anonymous-install` (lower.mn:106) ·
`Hβ.lower.k2-nontrivial-prefix-arg` (lower.mn:4003) ·
`Hβ.lower.fanout-gpu-host-import` (lower.mn:2486) ·
`Hβ.lower.continuation-callboundary-bubble` and
`Hβ.lower.multishot-reyield-composition` and
`Hβ.lower.multishot-arm-state-commit` (lower.mn:272-273, the k-spine's
three named floors). The tenth,
`Hβ.lower.value-fn-availability-edge` (lower.mn:1292), is RESOLVED —
its own comment says "now LIVE" — and is recorded here only so the
stale prose is struck; that distinction between an open gap and a
resolved one is exactly what an index carries and a comment cannot.

`Hβ.graph.reverse-edge-and-bound-projection` — oracle.mn's two
surviving iteration convictions, named at their true form (2026-07-30).
`count_dependents` walks ALL handles asking "does this body reference
pos?" — a REVERSE-EDGE query answered by scanning forward edges, O(graph)
per position and quadratic across the candidate set; `collect_bound_positions`
walks all handles collecting the NBound ones — a graph projection written
as a range scan. Neither wants a materialized range (that is worse than
the loop at graph scale): the self-form is the graph answering directly —
the reverse edge read through the same use-edge channel `refs_of_name`
already collects, and bound-cell enumeration as a projection over minted
cells. Iteration-is-topology's tier-2/tier-4 case (a cycle or a read,
never an index), and the payoff is complexity, not idiom.

`Hβ.audit.capability-carries-its-evidence` — the severance teaching's
remainder (named 2026-07-30 with the vocabulary's graph read). The
vocabulary is live now; the capability MAP still names three effects,
and it cannot simply grow because a Capability is a nullary tag whose
render bakes its evidence: CSandbox renders "proven no network access",
so mapping WASI or Filesystem to it would misspeak the proof. The
self-form is the capability carrying WHICH severance discharged it —
`CSandbox(ename)` or a (capability, evidence) pair read from the row —
after which the map extends by construction over every declared effect
(a real-time consumer wants !Mutate and !Thread named; a sandboxed one
wants !WASI and !Filesystem). Cheap once the evidence rides; the
render is the whole design question.

`Hβ.wheel.iteration-is-topology` — the recursion eradication (named
2026-07-30, Morgan's interrogation; the ledger entry ITERATION IS
TOPOLOGY carries the law and the census). The wheel's 390
index-threaded self-calls (the audit's iteration-shape tier is the
standing census instrument) migrate per family toward the medium's own
iteration stack — derived folds / each / iterate for structural walks,
<~ for genuine cycles, driver-resumption for search — each family
march-arbitrated, the tier's count the ratchet. Sequenced WITH
`Hβ.infer.schemes-are-edges` (below): every name-cycle drained is
tower the deletion no longer needs; the wheel's own SCCs (unify, the
parser) are structural folds over Ty/Token written as mutual
recursion, and their migration is the deletion's steepest lever. The
named residual: recursion that survives is sig-priced (the
signature-price law generalized — the price of name-keyed recursion,
period).

`Hβ.dsp.state-element-install-once` — the `<~` RHS's construction is a
lower-time constant (named 2026-08-01, the constructor-charge landing's
DSP decision). A feedback site's state-element spec (`delay(1)`,
`accumulate(init)`, `filter_spec(...)`) constructs ONCE per site at the
register's establishment, never per tick — but the constructor-row
charge reads the RHS ctor call as a per-call construction, so the six
feedback.mn filters carry Memory + Alloc where their emission earns
!Alloc. The reclaim: the judgment reads the install-once fact (the
recognized state-element position exempts the spec's construction from
the per-call charge, or emission hoists and the charge follows the
sugar-charge law's own criterion — charge what the lowering performs).
When it lands, the real-time `!Alloc` rows return to lowpass_iir and
kin with the row proof the file's comments once claimed. stereo_chain
stays honestly charged regardless (its result tuple is a real per-call
construction).

`Hβ.infer.schemes-are-edges` — THE MENTL WAY for the judgment (named
2026-07-30, Morgan's question "is there a better way — a more Mentl
way?" answered at the root): the entire convergence tower — trial /
rounds / cone / fingerprints / the bound / the freeze law / the
declared-row pins / the attractor dances — is ONE compensation for
published schemes being SNAPSHOTS read by name while everything else
in the medium is an EDGE read live. The rounds manually iterate what
the union-find propagates transitively for free; the freeze exists
because live cells raced under the fan; the races were SOLVED for
rows by making the write a commutative JOIN (the lattice landing,
order-free at K=8). The form: publishes as live graph cells whose
teaching is a join, polymorphism as instantiation FLOW-EDGES read
through the union-find (the banked polymorphism-as-flow-edges design
— generalize/instantiate/subst dissolve; the unpatchability theorem's
own prescription: swap the representation behind the projections).
Convergence stops being iterated and becomes what the graph
structurally IS; the tower deletes. Tonight's symptom catalog is the
requirements list, measured: the parity-selected attractors, the
prereg-vs-final entry races, the open-tail subtraction carriers, the
type-half flip surviving a fully-pinned row, the marginal
schedule-variance at the 11/12 boundary. A full-context session's
arc — the biggest single deletion on the board.
THE SOURCE HAS ITS ARTIFACT (2026-07-31, minimized from 930 wheel
movers to fifteen lines — tests/frontier/mn-cycle-charge-freeze.mn,
the §7 entry THE SOLO IS A CYCLE carries the arc): a cycle member's
row is PUBLISHED AS A VALUE at its own decl exit, before its
co-members are judged, so their effects never reach it — and the
member whose accumulated tail accidentally keeps a live CO-MEMBER
edge is the one that stays correct, which makes the cut, not the
openness, the defect. Rung 3's acceptance tests are therefore three
banked REDs (this one, mn-scc-false-negation, mn-two-tail-accumulation)
plus the wheel's mover count reaching zero — and the count is now
printed on every ScopeAll compile, so the ratchet has its number.
RUNG 3 IS NOW A MEASURED BUILD, NOT A SKETCH (2026-07-31 — attempted
first, measured, and reverted to green with the spec it produced;
Morgan's cut: the expensive one first is what makes the cheap ones
cheap or unnecessary). THREE FORMS WERE BUILT AND MARCHED:
(a) THE FULL REPRESENTATION SWAP — `EffTail = EtClosed | EtOpen([Int])
| EtAll`, the tail as a SET OF EDGES so `tail_join` becomes set union
(no first-var drop), with `ef_make` canonicalizing and `EtOpen([]) ⇒
EtClosed`. Surface MEASURED: 52 sites across seven files (infer 20,
effects 16, graph 6, types 5, lower 2, gradient_delta 2, main 1), and
H6 names every one — the census answers `constructor: EtVar` at each
missed site, so the sweep is compiler-driven. Not landed: several
sites are unify BINDING decisions that need their own judgment, and a
half-swept tree does not compile.
(b) DELETING THE CUT OUTRIGHT, with a cycle guard added to
`resolve_row` (carry the cells being resolved; skip a revisit — R ∪ R
= R, so the least solution is the fold's own idempotence). MEASURED:
it terminates and self-reproduces (TRANSITION m3 == m4) and it is
WORSE — 40 E_EffectMismatch, movers 930 → 1476, the wheel +47k lines.
THE READING, and it is the finding: the cut was doing TWO jobs, and
only one of them is the defect. Closing the SELF cycle is right and
necessary (callers and the declared-row gate read a value there, and a
self-referential loop is not one); cutting a CO-MEMBER's edge is the
defect.
(c) THE SEPARATION — `row_without_self` becomes the same resolution
guard SEEDED with the fn's own cell: the self-edge reads closed by
idempotence, every co-member edge stays LIVE. One line replaces the
old handle-compare. MEASURED: the source fixture goes 2 movers → 1 and
`self_first` — the member that LOST its co-member's effect — is FIXED,
which is the defect this whole arc named. The wheel then shows 40
E_EffectMismatch, and those are HONEST: with co-member effects finally
arriving, forty of the wheel's own declarations are under-declared.
THE (c)-PLUS-WIDEN-LOOP PRESCRIPTION IS REFUTED BY THE BATTERY
(2026-07-31, the HALF-STEP REVERTS ledger entry — this paragraph's
first form prescribed exactly it and is superseded in place): form
(c) SHIPPED the findtag/mapelem/mapfield exit-134 class (live
published tails with no completion drain sever the element-instance
payload joins — the fold behind a live tail never fires, a HOF
lambda's param never learns its record), and the forty mismatches
were un-drained reads, not under-declarations — the widen loop would
have canonized artifact rows into forty signatures. (c) reverted
whole; the honest landing is (a) + (c) + the completion drains
TOGETHER — the row half (D3 + D4) as one arc, judged by the
six-fixture acceptance battery (the three graduated micros +
mn-cycle-charge-freeze + mn-mutual-negation-gate +
mn-two-tail-accumulation).

THE RESOLVED DESIGN (2026-07-31; the banner claim "every choice
forced, nothing left to evolve" was REFUTED IN PART the SAME DAY by
the two-refuter fleet — guarantee-refute-fable / guarantee-refute-opus
under .build/research, convergent independently — and is corrected
here in place, the alive-law on the design's own author. THE
CONVERGED DECOMPOSITION: the ROW HALF — D3's edge-set tails + D4's
group-completion gates — is FORCED (both refuters fixture-traced it
green independently; its two named gaps are SETTLED 2026-08-01 by
THE SETTLED LAWS block below). The
SCHEME-OBJECT HALF — D1/D2/D6 — is a CHOSEN architecture with live
alternatives, one of them the landed frozen-read form: D5's one-way
law is unqualified over the TYPE sort (no type join exists —
graph_bind replaces; in-group cell sharing is the landed measured
truth), D6 dies on the fan's enumeration (proposing UNREFERENCED
names needs a decl-listing store in ANY implementation; the
forwarding-edge mechanism fails both horns), D2's bands exclude the
prepass region where the parameter cells actually mint, and D7's
K-wide byte-equality rests on a plan sized by the pass D8 deletes —
the SIZING CIRCULARITY (fixed bands measured dead at C1b). D8 IS a
ratchet (deletion list verified self-contained; graceful degradation
proven). THE HONEST PATH: land the row half, measure
movers — the acceptance (movers 0, the final pass DELETED, one-pass
judge) may be reachable WITHOUT the scheme-object half, and that
measurement, not prose, decides whether D1/D2/D6 proceed. ALL THREE
DECISIONS ARE TAKEN (Morgan delegated the remaining two to the
co-designer seat, 2026-08-01; the forty's diagnosis was answered by
the 2026-07-31 probe — the half-step's own artifact, un-drained
live-tail reads meeting closed gates, dissolved by the revert, no
widen loop):

(1) THE PROOF IS THE INTERFACE — the publish/gate split resolves as
GATE-ONLY, whole: a published row is the body's PROVEN row; a
declaration is a GATE checked at the group's completion plus a
REFINEMENT contributing only its ABSENT set — load-bearing exactly
on an open tail (bind_open_to_neg's mechanism, now the ONLY thing
authored text writes into a row); a declaration can never widen,
close, or EtAll a published row. A closed proven row already entails
every absence (the strongest !E statement IS the closed positive
row), so nothing is lost and the transitive absence proof rides
entailment instead of annotation propagation. This inverts the
received tradition — every mainstream language publishes the
author's PROMISE as the interface and checks the body against it;
Mentl publishes the PROOF and demotes the promise to a gate — and it
is the Carried-Truth Law at the signature boundary (a declaration
republished as the interface is a copy of intent standing in for a
provable fact). T_OverDeclared, tighten, and the gradient already
point here; now it is the semantics. enforce_row_gate's declared-row
bind DELETES with this (the EtAll-fabrication hazard dies
structurally — no path from a declaration into a stored tail);
mn-mutual-negation-gate is the acceptance fixture, landing WITH the
row half (gate-at-completion needs D4). Scope note: this is the ROW
law; type annotations keep their Intent-Boundary semantics (the
let-annotation landing already made `: T` a constraint, consistent).

(2) THE SCHEME-OBJECT RULE, pre-committed with a NO-GO default:
after the row half lands, movers → 0 or a non-row residue ⇒ D1/D2/D6
as written are DEAD (refuted on their own terms — no type join
exists, the fan's enumeration needs a decl-listing store, the sizing
circularity), their surviving ideas folding into smaller named peers
(env dissolution stays §5.O layer-2 via name-is-handle; the band-bit
died with the circularity). A materially nonzero TYPE-sort residue ⇒
a FRESH design pass answering the type-half join question first
(frozen-read extended, or polymorphism-as-flow-edges) — never the
refuted architecture on momentum. Ambiguity defaults to no-go; the
tower dies either way.

THE SETTLED LAWS (2026-08-01 — the row half's two named gaps closed
by ruling (1); the swap is unblocked. THE PRICING RULE, added the
same day after its violation was measured, extended the day after
its second violation was: no representation clause is ever stamped
FORCED or SETTLED until its READ and its WRITE are each priced under
§5.O AND its WRITERS are ENUMERATED — the census law at design
altitude. Two paid instances: semantic fixture-tracing alone stamped
D3 forced with an unpriced fold and the wheel billed it at 4GB; then
"the union is blocked on the scheme-object half" stood as the stamp
while the actual blocker was ONE unenumerated writer
(infer_call_saturated's symmetric row unify), found by a single grep
run AFTER the stamp instead of inside it. The corollary retires a
CLAIM CATEGORY: "exhaustive / complete / every choice forced" is a
verifier's verdict, and a verdict without its run is fabrication
(⟲'s own law applied to the design's author) — a design statement
carries the form "traced over X, priced over Y, enumerated over Z"
and completeness has exactly one proof, the build marching green):
— THE ABSENT-MASK LAW (gap 1): the absent field is the ONE home for
every negation-shaped fact, with THREE writers — the `~>` install's
handled-set subtraction, the declared `!E`, and the diff/inter
algebra — ALL writing by union (a join-semilattice dual to
presents), ALL read at resolution (p ∪ edges' content ∖ a). A mask
never parks: D4's completion drains resolve every edge at the
group's completion event, so a mask meets its tail's content THERE —
not never (the half-step's measured failure), not at a publish
freeze (the original defect).
— THE ETALL LAW (gap 2): EtAll is a DEMAND-side form only — authored
row constraints (a param's `() -> a with !WASI` anything-but shape,
the persist barrier) and the gate's transient universe-minus — NEVER
a supply-side inference result: no publish, no bind, no join may
store EtAll into an inferred row (supply is closed or open-edges,
nothing else). Demand meets supply at row_subsumes' directional gate
(the directional-fn-row-edge landing's own machinery). A stored
supply-side EtAll is a census item at zero.
— THE FLAT-CELL LAW (D3's READ half — added 2026-08-01 after the A2
attempt measured its absence as the hub-cell wall, and Morgan's
rebuke named the failure: the design had stamped D3 FORCED without
ever running §5.O over its read, while the corpus ALREADY held the
answer — the 2026-07-22 canonical-on-write arc, specified and
uncited). A row CELL never stores depth: every write —
graph_bind_row's bind and the teaching join alike — stores the FULLY
FOLDED (p, a, residual-edges), so fold depth is 1 by invariant at the
write. Flatness decays as neighboring cells bind later; the
union-find already answers that: COMPRESS-ON-READ —
resolve_row_compress generalized to edge sets rebinds through-bound
edges to their folded terminals (the branch-arm skip preserved for
determinism), making row reads amortized O(1) exactly as the type
sort's chase. The visiting-set guard (R ∪ R = R, the half-step's one
sound piece) scopes PER READ for in-flight cycles and can no longer
freeze absent content because D4's completion events BOUND the
breadth: a hub cell's edge set grows only while its sources are
un-completed, and completion folds them away — the measured
thousands-element set was never a legitimate steady state, it was
the missing-completion symptom read as memory. The belt: a read
meeting depth > 1 is a census item (the write that skipped
canonicalization names itself). With this law, A2's return is
forced-choice end to end: restore A1-exact from the banked diff (the
census-34 park dies unexamined — its machinery is rewritten under
this law), then ONE arc = flat-cell writes + set compression + the
union + the judged binds + the publish law + the drains, judged by
the six fixtures plus the depth census.

The D-text below IS the PROPOSAL,
under refutation, kept whole for its mechanism detail. The invariants
the proposal claimed as forcing:
one-graph-two-operations (the thesis) · determinism-as-fixpoint via
the planned mint (C1b's deterministic per-decl bands) ·
name-is-handle · the one sorted-handle-set representation (§4①'s
ordered-keyed-set unification) · join-only shared writes (the lattice
law: order-freedom ⇔ monotone commutative idempotent joins, proven at
K=8 for rows) · the measured one-way race (K=8: a caller folding a
decl's live cell mid-flight) · Tarjan groups as parse truth ·
undecidability of inferred polymorphic recursion (the signature price
is math). The unforced remainder is byte layout alone — record
offsets private to their accessors, march-absorbed TRANSITIONs,
load-bearing nowhere; layout is not semantics.)

D1 THERE IS NO SCHEME OBJECT. A decl's identity is its pre-registered
type cell; "the scheme" is a PROJECTION of that subgraph. generalize
writes nothing. instantiate at a site mints fresh cells for exactly
the decl's parameter cells and draws one CORRESPONDENCE EDGE per
pair. Substitution IS the union-find chase; both subst builds die.

D2 PARAMETERS ARE A BAND BIT, DECIDED AT ONE EVENT. The planned mint
already assigns every decl a deterministic handle band. At the decl's
COMPLETION EVENT one sweep over its band writes the parameter bit —
free-at-completion — into a spine column. Thereafter param?(cell) is
an O(1) column read; ownership of an out-of-band free cell is band
arithmetic (it is the earlier owner's parameter; using it is an
instantiation edge). A stored qvar list is a snapshot; a liveness
re-walk is a re-derivation; the band+bit is the unique O(1) form the
fixpoint's own allocator provides. Forced.

D3 ROW TAILS ARE EDGE SETS; ALL SETS ARE THE ONE SORTED HANDLE-SET.
EfRow(present, absent, tails): present/absent sorted handle-sets
(names are handles), tails a SET of edges to row cells — N edges per
cell, tail_join is set union, the first-var drop unconstructible.
Recursion needs no cut: R ∪ R = R; the resolver's visiting-set IS the
least-fixpoint read (the landed guard, now the only law). Not a
bitset — effect space is open and sparse, and a bitset is a global
registry, a side table reborn. Joins commute and idempote → fan-safe
at any K. Forced.

D4 COMPLETION IS THE GROUP'S. The Tarjan group (a solo self-cycle is
a group of one — landed) completes as ONE event: parameter bits,
declared-row gates, and the group's diagnostics fire there. The
deferred-gate machinery deletes with the timing problem it patched.
Polymorphic recursion keeps the signature price — undecidable to
infer, never revisited. Forced.

D5 TEACHING FLOWS DECL→SITE ONLY. A late resolution of a decl cell
propagates along correspondence edges as a JOIN into each site cell;
a site constraint binds the site's OWN cell, never through the edge —
one-way is a law of shared memory paid for at K=8, not taste.
Propagation is not a phase; it is what an edge is. A mover is thereby
impossible by construction — there is no second judgment left to
disagree — which is the difference between driving divergence to zero
and deleting its habitat.

D6 THE ENV DISSOLVES. A name resolves ONCE at the scope walk to its
decl's cell (the VarLookup edge, already minted, becomes THE edge);
after that nothing in the judgment is name-keyed. The flat buffer,
the bucket index, and the per-generation dedup die with the snapshot
they served. Generation shadowing (the resident session) becomes one
forwarding edge on the decl cell — the canon primitive, no second
store. Name-keyed reads survive only at human boundaries (query,
REPL, diagnostics render) as projections.

D7 CLOSURE OVER EVERY PLANNED SYSTEM — why nothing replaces this.
K-wide judgment: every write is an own-band fresh bind or a shared
join — order-free by algebra, byte-equal by the planned mint; schemes
join rows in the one proven write class. Incremental/resident: an
edit's cone propagates along live edges; superseded generations die
by forwarding edge; the arena's job stays reclaim alone. Persist =
memcpy: judgment state is image cells, columns, and edges — zero host
maps. The modal crown, Verify, and audit read live rows off cells.
Every planned system consumes this form; none sits beside it.

D8 THE DELETION LIST — the acceptance IS this list reaching zero: the
final pass · movers_count/movers_line/movers_diff/round_prints/
prints_equal · the deferred row gates · scheme snapshots (stored
Forall at decls; ctor/op records become decl cells) · instantiate-as-
clone and both subst builds · the env buffer/bucket/dedup ·
row_without_self's residual form · the trial/final split (ONE
planned, reporting, bracketed walk) · the fingerprint channel. The
SCC walk DEMOTES to scheduling. Done = movers 0 AND the final pass
GONE AND the judge ONE pass (verification happens ONCE: per-compile
correctness structural, whole-program verification at the march per
landing) AND the landing NET-NEGATIVE in judgment machinery — a
net-positive diff is the tower's signature and STOPS the arc. Until
done, the tower takes NO improvements — no cone bolt-ons, no cadence
tuning, no hygiene on condemned machinery; only the arbitrating
oracles (the march's cost line, the ratchets, the movers count) touch
it (Anchor 2's condemned-forms clause).

D9 BUILD ORDER — each rung marched, direction ratchets live from the
first (movers monotone down · peak-RSS ratchet · battery-gated repin
· the net-negative tripwire): (0) EXECUTED 2026-07-31 (the ledger's
HALF-STEP REVERTS entry): the era bracket convicted the guard pair
itself — not the carve-out — as the three-micro root (element-instance
crossing, this design's own family: live published tails with no
completion drain sever the payload joins), both reverted, boot
restored to 69d6c0b0, and the widen loop REFUTED (the forty were
un-drained reads, not under-declarations). (1) Rows terminal. LANDED
SO FAR: A1 the representation swap (EtVar(v) → EtOpen([v]), marched
CLEAN 2026-08-01, the two paid laws beside it — row walks are
MECHANISM, and A2-without-the-flat-cell-law hits the hub wall) and
the PUBLISH LAW + FLAT-CELL WRITE HALF (pin 1efe083a — gate-only
publishes, flatten at both graph write ops, mn-mutual-negation-gate
GREEN). THE WRITER CENSUS then ran as the extended pricing rule's
opening measurement (2026-08-01 — 28 top-level unify sites in
infer.mn classified; "one site" was a one-grep count and the census
convicted it same-day): CLASS A, per-caller teach-back into a shared
cell (the hub): the CALL edge (infer_call_saturated:3996 — expected
carries mk_ef_open([], row_h) into the symmetric unify, and the
Open~Open arm binds only_a = the CALLEE's private edges toward the
caller's set), the PIPE edge (infer_pipe PForward:4363 — identical
shape, and its charge reads row_h so it needs both halves), the ARG
edge's var-tailed path (a bound-TFun arg meeting a non-cap param row
inside the component unify — fn_arg_directional_positions masks only
row_cap_form today, so a named fn passed to map's f teaches its own
shared cell one edge per call site), plus the low-volume cousin: the
PARTIAL path (unify_args_positionally:3746 — fresh top slots but the
components reach the callee's param structure; extend the fresh-slot
form when a probe convicts it). CLASS B, bounded symmetric merges —
the union's legitimate domain (value positions: list elements 8374,
record fields 5342, if branches 2949, match/handler arms 5917/6038,
tuple/index/spread/field 3027/3104/3333/5461, binops 5478/5486/5511,
scrutinee~pattern 5601, seq operand 3478, instance args 4274/6073) —
writers bounded by construction sites, never caller count. CLASS C,
decl-side self-writes, the legitimate direction (body~ret 2473,
resume/state 3148/3174, the frame's inf_add accumulation, the gate's
absent-join, diff_row's mask mint). Type-component symmetry stays
DELIBERATE everywhere (no type join exists; the mono view's teach
channel is its design) — the disease is row positions only.
**THE ARC LANDED 2026-08-01 (pin 13631390 — the §7 entry THE EDGES
CARRY AND THE FRONTIER STAYS SMALL): B1 + B3 + the charge-as-edge
whole, PLUS two organs the build's three 4GB refutations forced —
the QUANTIFICATION FLOOR (generalize quantifies signature frees
only; top-row-only frees are shared live links instantiation never
freshens) and the COMPLETION PRUNE (a judgment-minted still-free
edge drops as pure at the finalize; prereg cells stay as the cycle
channel — the mint ceiling on infer_ctx, re-armed per branch).
Movers 930 → 415; mn-two-tail-accumulation AND
mn-cycle-charge-freeze green. OPEN: B2 (below), B4's drains, B6's
cut deletion — the cut stands sound-conservative with its fixture
already green.** The designed ladder, kept as the record:
B1 THE
ONE-WAY CALL+PIPE EDGE — on the bound path expected's row IS crow
(the callee's own row, read before building expected), so the row
arm meets crow ~ crow and no-ops by the was==wbs identity — ZERO new
unify machinery, the mask is the identity; row_h mints only on the
free path (fh free := expected wholesale — the forward/param channel
UNSEVERED: the banked open question answers itself, the mask never
applies where there is no row to read); the call's charge is already
crow-direct, the pipe's charge rewires to read the stage's TFun row
with the share-guard kept on its free path. **B1 IS NOT A STANDALONE
RUNG — MEASURED AND CORRECTED IN PLACE (2026-08-01; the §7 entry THE
FRESH ROW CELL WAS A LIVE EDGE carries the build and the probe).**
The form above was built exactly as written and marched TRANSITION
m3 == m4 at census 0, and the two-boot fixed-input probe convicted it
on EFFECTS: `filter_list` / `map_list` / `race` and nine kin proved
**Pure** where they had proved `Memory + Alloc` (85 → 99 movers on an
identical blob — behavior, not workload). The teach-back this rung
deletes was ALSO the channel keeping the caller's charge LIVE: the
bound `row_h` resolved later through the graph, where
`callee_own_row`'s resolve folds a possibly-unjudged callee's row to a
bare VALUE the caller banks forever (Carried-Truth inverted at the
charge — a snapshot where an edge belonged). So B1's third move is
forced and it is the charge: `inf_add_row_unified` takes a bare
`EfRow([], [], EtOpen([callee_root]))` chaining into the callee's own
live cell — scheme_own_row's form, generalized past the co-member
gate — at BOTH edges. That charge needs the UNION beneath it (a
second callee's edge drops at tail_join's first-var), so **B1 + B3 +
the charge-as-edge land as ONE arc**, with B2 free to ride either
side and B4's drains closing the cycles behind them. The sub-rung's
"movers monotone down" acceptance holds for the ARC, not for B1
alone. PRICED, corrected: the per-call work does fall (one chase for
a row-unify walk), and the pricing rule's own third payment is that
"priced" must cover the read's FRESHNESS as well as its cost — this
stamp traced the semantics and the cost and never asked when the row
it reads is true. B2 THE ARG
EDGE GOES TOTAL-DIRECTIONAL — cap-form params keep landed
subsumption; a bound-TFun arg meeting a param row resolving to
EfRow([], [], EtOpen(vs)) with vs all free masks the position and
binds ONE-WAY: bind_edges_to(vs, arow) — the instantiated
(caller-private) param cells learn the arg's row, the arg's shared
cell never written, the 297-site flow preserved as a READ; mixed
shapes (presents + var tail) keep symmetric with a named census
counter (unmeasured; expected zero in the wheel). B3 THE UNION FLIPS
— tail_join's Open×Open → EtOpen(tail_set_union(vs, ws)), sound
because B1+B2 bound every shared cell's writers to its own decl's
accumulation plus Class B merges; mn-two-tail-accumulation GREENS
here. B4 THE COMPLETION DRAINS (D4) — trial_judge_group, after
group_judge_members, folds every member's row (resolve — the
visiting-set guard closes self/co-member loops by R ∪ R = R — then
finalize through the landed flatten) and fires the group's deferred
gates THERE (the drain moves from the pass tail to the group's own
completion event; the pass-tail drain demotes to an assert-empty);
the absent-join stays at decl exit (a write), gates fire at
completion (a read of folded rows). B5 THE MONO VIEW SHARES ROWS —
row_handles_only DELETES: the cycle discipline's row-quantification
exception existed ONLY because application-site symmetric row
unifies contaminated shared cells (the measured five mismatches),
and B1+B2 delete that channel; crow then IS the live cell for
in-group callees, so callee_own_row's group-gated re-aim,
scheme_own_row, the group_member/set_group_members ops, and the
group_names state ALL DELETE as dead code — net-negative, the
design's signature (a Class B merge teaching live group cells is a
genuine constraint — a list of co-members demands equal rows —
deliberate, marched). B6 THE CUT DELETES — row_without_self +
edges_without_self go: frame exit publishes the raw accumulated row,
the completion fold closes every cycle; mn-cycle-charge-freeze
GREENS. Then the movers measurement fires the pre-committed
scheme-object rule. (2) Decl cells + correspondence edges;
the final pass demoted to a pure ASSERT whose override count must
read zero. (3) The completion-bit column; generalize deletes. (4) THE
DELETION: one-pass judge, D8 swept, measured against the 563MB-class
anchor (§5.O's cost law). (5) Resident, incremental, and the fan
inherit the form; measure, never re-plumb. Banked gates, RED or
green today: ping/pong answer Pure (scratchpad pingpong.mn), solo
stays Pure, mn-mutual-negation-gate compiles, mn-cycle-charge-freeze
and mn-two-tail-accumulation go green, the mover narration deletes
with its channel, census 0, frontier whole, the march. Swap behind
the projections — the read surfaces keep their signatures.

`Hβ.infer.round-oscillation-movers` — ROOT FOUND 2026-07-31, and the
peer's own framing is superseded in place: this was never an
"oscillation" and the rounds' deletion did not end it. The movers are
the trial/final divergence, they number 930 on the wheel (the count
instrument landed with the finding — the sixteen-slot display had
hidden the magnitude for a week), and their SOURCE is a fifteen-line
reproduction: A CYCLE MEMBER'S ROW IS PUBLISHED AS A VALUE AT ITS OWN
DECL EXIT, before its co-members are judged, so their effects never
reach it (tests/frontier/mn-cycle-charge-freeze.mn; the §7 entry THE
SOLO IS A CYCLE carries the mechanism and the asymmetry that proves
it). The blocker text below stands as the era's record and its
OPERATIONAL WARNING still holds — row-perturbing engine work in
verify/infer gambles the attractor — but the reason is now named
rather than mysterious, and the cure is rung 3, not a better cadence.
The remaining sub-findings below (the SCC-internal crawl, the marginal
run-variance) are consequences of the same publish-as-value root.
(the era's record follows)
(2026-07-30, third victim): the Pure predicate-fn UNFOLD was built
whole (332-line patch banked in the session scratchpad — the binder
env absorbing the self special-case into node_const_env, the bool/
match evaluator over litval, the body lookup through the env's
Located reason + the span log, the Pure-row gate, the one-level
PBoolNode hook) and its row widens flipped main's row to carry a
phantom Intern no spine component performs — the same
parts-don't-sum signature as the 2026-07-29 relocations and the
2-cycle-cut probe. Row-perturbing engine work in verify/infer now
GAMBLES the attractor every time; the oscillation root outranks every
queued increment until fixed. The dig's standing instruments: the
movers/flip channels, the Pure-pin row-printing bisection, the scc2
trace. (2026-07-29; DUG 2026-07-30 — the
pin-78b1736b landing carries the arc): the "oscillation" was a MONOTONE
resolution front, and three of its four roots are CLOSED (the
fingerprint's set-order fabrication; the backward-only layer walk; the
source-order trial). The REMAINDER, measured by the graduated flip
instrument (movers_diff + probe_tail_why, now the bound-hit's standing
diagnosis channel): the unify/parser SCC chain — within a
mutual-recursion cycle, member B reads co-member A's PREVIOUS-round
final across the cycle's stale link, so an SCC's closure crawls its
internal diameter one round per link; the bound still cuts at ONE
mover (parse_effect_list_from, 2026-07-30), and the daily-verb tax
(~59s field read) is round-count × the per-round FIXED costs (full
re-parse + classify_fixpoint + round_prints — cone-independent). THE
FIX (re-specified twice on 2026-07-30, each by a measured kill — the
pin-5db9b4c3 and no-pin ledger entries carry both): the Tarjan SCC
substrate is LANDED (scc_groups; the trial walks groups
callee-first); classic GHC mono-binding-groups are REFUTED (29 wheel
convictions — the wheel's cycles use polymorphic intra-group
instantiation); and bare per-SCC re-derivation iteration is REFUTED
(rollback-as-fresh-nodes works — simple pairs converge in two probes
— but generic/concrete-tension families ALTERNATE with period 2
forever: re-derivation-from-scratch is not monotone, exactly Salsa's
cycle-recovery contract). THE THIRD COUNTED KILL (2026-07-30,
Morgan's vet — "re-judge? re-infer? re-derive?" — the build reverted
uncommitted): the iteration WITH the generality join was built whole
(ty_join — concrete-over-free pointwise widening preserving cur's
linkage, rows through row_join; closed freezes
Forall(free_in_ty(chase_deep(t)), t) inert across rollback; the join
operating on instantiate(prev) vs instantiate(cur) so no
cross-generation handle ever mixes; all-fn groups only) and the
artifact refuted it on its own terms: TRANSITION m3 == m4 at 355,307
lines with census 0 — a self-stable attractor — but the ONE bound-hit
mover (parse_effect_list_from) SURVIVED untouched (its flip lives in
the rounds' own re-derivation, outside the trial's groups) while the
attractor moved 107,432 emission lines with nothing arbitrating the
move as better. Cost without cure — and the deeper conviction is the
DIRECTION: probes that re-judge, freezes that snapshot, joins over
re-derivations are the tower growing, the exact compensation
machinery `Hβ.infer.schemes-are-edges` already names as the thing to
DELETE. Carried-Truth at architecture scale: the fix for
schemes-read-stale is never a better re-derivation cadence — it is
schemes as live join-written cells the union-find propagates through.
THE ARC REDIRECTS THERE, terminally: this peer's remaining content is
absorbed into `Hβ.infer.schemes-are-edges` (the tower deletion), and
no further tower machinery lands. FIRST RUNG EXECUTED (2026-07-30,
pin 574bc20d — the §7 entry THE ROUNDS ARE DELETED): the rounds, the
bound, the cone, and the mask are GONE; the judgment is trial → final
(the verification framing superseded 2026-07-31 — the final OVERRIDES
on divergence and DELETES at rung 3; the §7 rounds entry carries the
ruling), the bound-hit class dissolved with its substrate, and the
movers instrument graduated to the trial-vs-final divergence report. THE MOVERS' DIG RAN THE SAME DAY and its five
kills are the peer's sharpest evidence yet, each one probe: (1) the
mechanism, confirmed at 8 lines — a recursion edge resolving through
a QUANTIFIED scheme freshens the row var (the frozen-read law), so
row_without_self's tail-lands-on-own-handle premise breaks: `solo`
(self-loop) flips trial-open/final-closed (the trial's
pre-registration vs the final's mono self-registration), and `ping`
publishes `with r…@e…` in BOTH passes — a mutual pair's rows NEVER
close (the mutual-negation-gate root, now measured by the medium's
own query). (2) The join-identity trap: binding a bound terminal to
pure hits the teaching JOIN, and joining pure is the identity —
3,131 measured no-op "closes." (3) The per-member finalize froze
group rows MID-LEARNING — 19 refusals naming the exact dropped
names. (4) Group-exit scoping healed 19 → 2, but the survivors are
the tell: the banked phantom-Intern-at-root attractor class
resurfaced, and a THIRD mover family appeared (the collectors/ml) —
any row-resolution perturbation re-selects the attractor, the
tower's signature. (5) THE RULING, the vet's law applied to the
digger: a third cut site is compensation regrowing the tower —
REVERTED whole; in the edges representation the problem DISSOLVES
(a join-cell taught by its own recursion joins idempotently, R ∪ R
= R — the least solution IS the lattice fixpoint, no cut, no
publish-freshening, no severance). The movers stay the standing
narration (trial correct-but-open, final closed, emission
self-stable); the 8-line probes (solo/pingpong) and the three mover
families are schemes-are-edges' acceptance tests, banked in the
session scratchpad's mover-probe.mn / pingpong.mn shapes.

`Hβ.emit.arm-closure-captures-record` RESOLVED: LANDED (2026-07-24, pin
bb4b870e — the ledger head carries the arc). The capture form won over
the $world_find read exactly as this entry ruled, and for a soundness
reason the ruling had not yet named: a commit targets its own install's
record — a LEXICAL fact — while a chain walk under a rebound redrive
world could resolve a same-named NESTED install's record instead. The
__hrec ladder (LLet alias / seeded capture / trailing param) carries
the record everywhere; the global, the bracket triple, and the
singleton_hnames walk family are deleted; the OneShot-in-thunk cousin
(20-not-25, silently wrong on the prior pin) died in the same landing.

`Hβ.cli.infer-context-bracket` RESOLVED: LANDED (2026-07-23, pin 2644dab5 —
the R5 entry in the ledger; the arc: refuted by the mint-time evidence
snapshot, then admissible the same night when the world-as-value R2 made
performs resolve at the call site; infer_context is the one home, all 14
chains route through it). The history below is the refutation record that
priced the world arc: the analysis-core ORDER LAW is written at its one
home (pipeline.mn's spine block) — ledgers innermost, lookup_ty before
env before graph before mutate_sink, diagnostics outer to graph (its arms
report: the occurs-check fires from graph_bind) — and doc_run's missing
env_handler landed, completing the core on every inference-reaching chain.
The CONSOLIDATION itself was built (a bracket fn taking the body as a
thunk, all 14 chains rewritten) and REFUTED by the artifact before commit:
a closure's evidence snapshot predates the bracket's installs, so every
EVIDENCE-dispatched core op faults its ev-scan into the sentinel — compile
trapped at executable_gate's verify_debt() (Verify is multi-handler:
verify_ledger + verify_smt), the at verb trapped on its ambiguous cursor
ops, while check/doc/teach/query/repl passed on singleton-tier ops (the
state global is dynamic). The split is exactly singleton-vs-evidence; the
wheel shrank 1,568 lines and compiled census-0, so the refutation is
semantic, not syntactic. THE CONVERGED DESIGN (same night, Morgan's
charge to read the pieces together — WORLD-AS-VALUE): the world is a
first-class graph value, a handle to the top of the install chain in the
image ([handler_record, parent] nodes, one $world_g global, O(1) cons per
install, trail-covered restore), with THREE PRINCIPLED TRANSPORTS all
already typed by the kernel: CALLS FLOW the world (the evv the §6
evidence-passing claim always named — the per-frame captured_evs snapshot
was a mint-time CACHE of a dynamic fact, Carried-Truth violated at the
kernel layer); ARMS REBIND to the install node's parent (the deep-handler
law — the M3 fence's PURPOSE, kept, its lexical approximation retired);
RESUMES REBIND to the world frozen on the k record (world_tag@28 upgrades
from bit-tag to handle; the declared-unwired E_ResumeWorldMismatchWorld
gate wires as a side effect — band B's value gate). The earlier "needs a
replay discriminator, open research" hedge is SUPERSEDED — the rebinding
rules ARE the discriminator. The infer half already exists
(inf_current_world onto every ContinuationEdge, TCont's 4th arg). The
dispatch gradient survives whole: tail-resumptive direct calls and the
singleton tier stay as proof-becomes-dispatch cash-outs over the ONE
semantics (the singleton state global becomes the cache of a unique world
entry; the uninstalled-guard's state_g==0 read becomes chain-miss →
refuse). This dissolves BOTH band-N evidence bugs, and its consumers are
the whole §2 fan: the bracket (this peer's original form, re-run as the
proving consumer), per-candidate virtualizing worlds in synth's fork pair
(the third leg beside graph checkpoint + heap region), work-stealing
frontier entries carrying their world as one memcpy-portable word, and
the depth-economics design (no depth parameter: gradient=priority,
handler=budget, multi-shot=memory — every frontier entry a dormant
continuation resumable across cursors/sessions ONLY if its world is a
value). MEASURED RED GATES, minted 2026-07-23 (scratchpad fixtures, to
graduate as frontier legs with the arc): thunk-world (a thunk minted
outside an install, called under one, evidence-dispatched op) traps 134
today, 42 under worlds; arm-config-ev (band N's true shape — a
config-param thunk performed under an arm-internal install) answers 2
today (silent wrong value: re-enters the outer handler), 40 under worlds;
the plain-block shadow control already answers 40 (no-regression
control). BUILD RUNGS, each marched: R1 world-chain substrate
(install/uninstall push-pop + $world_g, additive) → R2 the perform swap
WHOLE (evidence tier reads the chain; captured_evs op-dispatch dies; the
__resume k-threading channel survives — it is an argument, not evidence)
→ R3 arms-under-parent-world → R4 reify/resume world word + the band-B
gate live → R5 the 14-chain bracket consolidation re-run → R6 the fork
pair's world leg in synth/oracle. R2/R3 carry the whole-battery blast
radius; the multishot-era gates (52→66) and the march arbitrate.

`Hβ.infer.nested-alternative-branch-bracketing` (2026-07-24, born of the
fork-spine fix's own build — the medium refusing its builder twice): the
branch/scope ownership fix (1e06cdaa) brackets if/match arms as
BAlternative, but an if-with-consumes NESTED INSIDE a match arm breaks
the enclosing arm union — consumes in LATER sibling arms then collide
cross-arm (E_OwnershipViolation "consumed twice" false positives).
Measured twice on revert_trail_into: the if-in-argument-position shape
AND the let-bound-if shape both refused, while the IDENTICAL cross-arm
consume pattern in single-call arms (revert_trail, one fn over) passes —
so the trigger is the nested alternative, not the arm consumes. The
§4⑤ Hylo-quiet bar names this inference failing (a provably-safe shape
demanded restructuring); the fix is the branch bracket nesting as a
STACK (enter/exit balanced per alternative level), and the
undo_set_within hoist is the passing form until it lands.

`Hβ.ops.wasmtime-runner-migration` (2026-07-23 recon; the wheel-side
spawn glue LANDED 2026-07-24 — the §7 ledger head carries the arc):
steps (1)-(4) are EXECUTED. (1) the 36.0.0 LTS re-pin + wt-env.sh
flag-spelling probe (2026-07-23); (2)+(3) tools/runner — wasmtime crate
47.0.2, wt_run-argv-compatible — S1 byte-identity + battery through
both legs, S2 spawn smoke (tools/runner/smoke/spawn-import.wat,
IMPORTED shared memory re-exported for the p1 ABI) 42 through runner
AND CLI; (4) the banked RED (mn-real-spawn, 134 unaligned-atomic in
the join on both engines) is RESOLVED by the task-record landing (pin
8891428f): the four glue links died into the task record +
proof-driven memory ownership — a spawning module imports the shared
image and allocates through the shared cell; a thread-free module
(boot included) defines its memory and ships NO thread-spawn import,
so the must-satisfy-thread-spawn instantiation constraint is dissolved
everywhere it was inert. The three real-spawn frontier legs (int /
float-carrier / identity) run 60 through BOTH engines. REMAINING
scope, host-path only: (5) swap wt-env.sh/install.sh (+ hosted CI when
it returns, §11 col 5) to the runner, drop `-S threads=y`; (6) retire
the LTS pin. shared-everything-threads is the named eventual target,
unimplemented in any host — name it, do not build toward it. The
BROWSER LEG LANDED 2026-07-29 (the §7 ledger head carries the arc):
ide/wheel-worker.js is the runner pattern at the browser host — a
pre-armed worker pool consuming a SharedArrayBuffer task ring, the
stub-spawn shim retired to the gate's RED control
(tools/ide-gate.sh).

`Hβ.query.comment-prose-search` (2026-07-24, the ⟳ self-build law's
first named confession): the vocabulary sweep ran on grep while
comments are already graph content — the medium's form is a query
projection over the comment weave (find-by-word across attached prose,
spans out, the same channel the Lede facet reads). Small, and it makes
every future prose sweep a verb instead of a hand tool.

`Hβ.runtime.cross-compile-durable-state` CLOSED (2026-07-23, the
adversarial forensic-prober's independent dig — a fresh mind refuting
the accumulated corpus first, then proving the root behaviorally): the
cross-compile trap was the EFFECT-CENSUS COLLECTOR RUNNING AS A
NULL-STATE SINGLETON IN EMIT'S WALK EXTENT. project_emit_state
installed six visitor collectors but not effect_census_collector, so
the shared walk's visit_effect_install routed through the singleton
tier with __state = 0 — its installs accumulator lived at ABSOLUTE
ADDRESS 12 (the null page), below every region mark, never reset,
holding a pointer INTO the region; the reset zeroed/rewound the region
and the next compile's census walked the stale pointer as a list
(named backtrace: list_index_unchecked → string_in_list_loop →
op_effect_census_collector_visit_effect_install → walk_install_groups
→ walk_lemit → project_emit_state). Installing the collector: the full
region-bracketed battery runs 112/112 with byte-identical emitted wat.
The thirteen-kill probe corpus (2026-07-22, the same peer's prior
text) is SUPERSEDED as diagnosis — its pre-virginity infer-side
symptom was this same null-singleton class read through address reuse
under the rewind-only reset, and its "values no placement wrote, in
virgin memory" was exactly right: the writer was outside every
placement channel, storing through the null page. What the corpus
PAID FOR survives as law (CLAUDE.md ⟲, the forensic laws): one-binary
gates, protocol-honoring probes, retraction-on-refutation, counted
kills, and the virginity contract itself ($heap_reset_impl zeroes
[mark, bump) — the allocator accident made a contract; 192MB battery
peak). The CLASS is closed structurally, both altitudes: the wiring
(every walk_lemit bracket installs every visitor family the walk
fires) and the SingletonUninstalled guard in singleton_perform_block —
a singleton op call finding state_g = 0 REFUSES loudly at the site
(the tier's evidence IS the global; null evidence is missing evidence,
the direct-call twin of LUnresolvedEvidence), so the silent null-page
read is unsayable. The regioned battery ships (main.mn battery_loop
mark/resets per micro — the arena's first real workload, §5.O).

The manifest arc's residue (2026-07-18, the arc itself CLOSED — §7 ledger):
`Hβ.infer.order-independent-verdicts` (the census is ORDER-CONDITIONAL: a
runtime fn declared before its prelude consumer meets the TIGHT inferred
scheme where the canonical order met the loose pre-registered one — three
real latent mismatches at prelude sum/chunk/trim under a leaves-first
weave; the canonical sort sidesteps, the class remains; repro: swap
lists/strings before prelude on stdin. The COMPLETE form was BUILT TWICE and
unwired twice by the SAME measured wall (2026-07-23 in the
instance-crossing landing; RE-BUILT AND RE-MEASURED 2026-07-25, phase
B-ii step 0 — the ledger entry carries the arc): a TWO-PASS WALK — a
diag_quiet trial finalizes every scheme; the final pass re-judges fresh
nodes against those finals (fn pre-registration SKIPPED — infer_fn's
unbound-handle arm self-registers monomorphic recursion; the
duplicate-fn refusal decoupled into its own seen-set walk) — closes the
class whole: its verdicts on the wheel converged 50 → 0 and the fifty
findings LANDED as the 2026-07-25 harvest (abs, infer_unaryop, the
formatter's chain arms, autodiff's matrix, the field-carrier split, the
str-raw satellites, ~35 row widens). The wall is CURRENT, not stale:
the judge-0 wheel's m3-leg self-compile exhausts the 4GB bump extent at
emit_wide_wrappers (alloc's wraparound guard; ~28s, 1.1GB RSS). THE
TWO-PASS RE-WIRE IS SUPERSEDED (2026-07-31, the resolved design —
Anchor 2's condemned clause): order-independence is not a second pass,
it is live join-cells with decl→site propagation; this class CLOSES at
rung 3 and no pass cadence returns under any DEP. The 2026-07-25 build
recipe stands only as the era's record.
THE CALLEE-FIRST BLOB (2026-07-23, the field landing) kills the class's
src→lib face whole: the canonical wheel input is lib-before-src, so
every cross-layer reference is BACKWARD; the bare-scheme census fell
492 → 256, and the residual 256 are intra-src forward references — this
peer's remaining scope. In-file, callee-first source order kills
instances one at a time — prelude's iterate_from precedes iterate for
exactly this reason) ·
`Hβ.patch.set-target-state-clobber` RETRACTED (2026-07-18, same day):
probed on the pinned artifact with both a len read and a full iterate,
before and after the perform — seven of seven survive; the original
"lost tail" measurement came from a probe-perturbed build (the
wheel-eprint Heisenberg class: the PROBE-R eprints inside
entry_start_caret changed the very emit under test). A label is a
hypothesis until the artifact confirms it — this one died by the law
that minted it; the hoisted read stays as ordinary hygiene ·
`Hβ.driver.per-module-env-overlay` gains its measured consequence: the
per-module check walk inferred prelude without its layer's vocabulary
(len/list_index missing on a clean program) — check rides the weave until
the overlay lands.

The 2026-07-18 census-tail peers: boundary-weave-generic-thunk-row and
rowbound-ty-residual-tagged both LANDED same day (the census-zero arc —
§7 ledger). `Hβ.emit.option-niche-repr` remains open at its EMIT half:
slot_present landed the READ (a table-typed `a -> Bool` presence test
over the 0-or-handle word), but Option CONSTRUCTION still boxes and
match-on-Option still tag-compares — the lower/emit arm that makes both
read the niche (0=None, handle=Some, zero boxing) is the landing.

The 2026-07-18 harvest + panel born peers (each artifact-verified before naming):
`Hβ.infer.type-decl-name-registry` (a second `type X` silently MERGES —
disjoint ctor sets share tag ids; measured: cross-tag match returns the wrong
arm, zero diagnostics; the decl refusal needs the type-name registry — a
SchemeKind representation change, its own landing; repro banked) ·
`Hβ.lower.trecordopen-wrong-field` (VERIFIED LIVE silent-wrong-VALUE: an open
receiver `u: {name: Int, ...}` reads the wrong slot — offsets computed over
the partial field set while the record sorts over the full set; the panel:
instrument whether self-compile hits the arm, then concrete-receiver
resolution, never a blind -1 refusal) ·
`Hβ.runtime.list-index-bounds-check` (SYNTAX §Indexing promises a runtime
trap; lists.mn tag-0 raw-loads with NO bounds compare — every OOB index is a
silent wrong read; the fix restores the promised trap, and list_index_proven
becomes the genuinely-unchecked variant the R5 discharge selects) ·
`Hβ.infer.narrowing-write-requires-discharge` (R5 re-scoped by the panel: the
elision machinery is DEAD CODE — narrowing_pred_handle descends PAnd's left
conjunct to PTrue, handle 0, never fires; delete the dead machinery, then the
real form: record only when the path predicate discharges BOTH 0<=i AND
i<len(receiver)) · `Hβ.mentl.verify-after-apply-boundness-only` (the teach
loop's proof check reads node-boundness, never re-runs row subsumption;
narrow_row binds without re-inferring — an `!Alloc` proposal on an allocating
fn reads back 'proven'; fix = re-run subsumption under a FRESH diagnostics
handler, graph_rollback does not cover diagnostic state) ·
`Hβ.infer.ctor-record-construction-unify` (single-variant record-wrapping
`Ctor({...})` construction unifies against the ctor's arrow type instead of
its result — ~5 voice sites of E_TypeMismatch) ·
`Hβ.infer.expect-same-chases-bound-var` (LANDED 2026-07-20, pin a0dd9849 — the
ledger head has the full arc). expect_same was the LONE unify arm that bound a
var without chasing, so a scalar clobbered a ctor-argument reference's
NBound(TVar(binder)) live binding and the parameter never learned the field
type (Float → i32 floor → indirect-call trap); the one-line fix chases like
every other arm. It unmasked the runtime handle-word pun, which the §4①
string-layer typing closed whole: byte_len/byte_at/str_slice/str_concat/
view_base/the float builders are seq-ops, str_of_buf is the ONE construction
boundary (a raw buffer word IS a String), handle_recorded dedups Int handles
by i32.eq. Census 0, m3 == m4, board whole. Repro registered:
tests/frontier/mn-ctor-float-param.mn. The next rung the fix exposed —
`Hβ.lsp.hover-response-emission`: serve now clears the json float blocker and
reaches the LSP layer but does not yet write a hover result
(Hβ.lsp.transport-runs-frontend)) ·
`Hβ.lsp.transport-runs-frontend` (ensure_doc_open reads bytes, never
lex/parse/infers — hover reads an unpopulated graph; v1 = the pipeline splice)
· `Hβ.format.render-totality-before-fmt` (SHARPENED 2026-07-23 — the exact
census + the oracle design, ready to open): format.mn is 577 lines of
DORMANT machinery (zero callers; the Format effect + format_program/
format_at_handle/format_chain real). The three surrender-fallbacks measure
as 18 missing arms: render_expr_tokens 17/25 (missing BlockExpr,
LambdaExpr, MakeRecordExpr, MakeStringExpr — the interpolation re-render —
MatchExpr, NamedRecordExpr, RecordUpdateExpr, ResumeExpr),
render_stmt_tokens 4/9 (missing LetStmt, TypeDefStmt, EffectDeclStmt,
HandlerDeclStmt, RefineStmt), render_pat_tokens 3/8 (missing PLit, PTuple,
PList, PRecord, PAlt) — the easy spine renders, everything structural
surrenders. THE BUILD: (1) the 18 arms + precedence-aware parenthesization
(render must be parse's inverse under the ONE precedence table) + the
COMMENT WEAVE projection (decl/interior/trailing comments are graph
content now — the formatter is the weave's biggest consumer; dropping
prose is destroying source); (2) the fmt verb as whole-file projection
(read → frontend → render → write, the tighten driver's surgery
generalized from one clause to the file); (3) THE ORACLE — the formatter
judged by the self-hosting machinery itself: idempotence
(format∘format == format, byte-equal), then format the ENTIRE WHEEL and
the formatted wheel must compile census-0, hold comment-refs 0, pass
battery + frontier, and reach its own m3'==m4' fixpoint — the formatted
source then BECOMES canonical in the same landing. (4) The payoff ratchet:
the 760 E_RedundantBraces (MachineApplicable, format-liftable) die as a
side effect of canonical projection, with E_RedundantPerform and
E_StatementSemicolon riding free — the medium's next batch-authored sweep
after tighten. RED-first fixtures per missing arm class (today a match or
lambda formats to `<expr>` — the gate) · `Hβ.multishot.handler-return-clause` (M5 — named twice in
git history: docs/research/multishot-general-design.md as the next ladder step, absent
here until now) · `Hβ.lower.branch-isolated-handler-state` (the multishot
doc's own correction, missing from every band) ·
`Hβ.infer.usage-grade-unifies-cardinality-ownership` — NOTE: this peer's
name was REUSED on 2026-07-17 for the branch/scope ownership fix; the
ORIGINAL residue (unify classify_usage and resume_grade onto one count_uses)
is still open and lives under this line ·
`Hβ.emit.compose-width-floor` (implemented in lower.mn, tracked nowhere until
now) · `Hβ.cursor.gradient-queue-activate-or-delete` RESOLVED: DELETED
(2026-07-23, pin 56f01996 — the 107-line larval block died whole; band
E's work-stealing-via-gradient keeps the design) · `Hβ.graph.fork-dead-code` (graph_fork + the overlays
module-to-handle index: built, zero callers, taxing the hot alloc path — an
activation slot or a deletion) · `Hβ.emit.float-evidence-ft` (an f64-argument
candidate/closure call dispatched through an all-i32 $ft — `indirect call
type mismatch` at enumerate_float_literals the first time a float-position
enumeration ever ran; the $ft repr-vector walk's evidence-call gap, the
fleet's float-HOF class with its first concrete anchor) ·
`Hβ.why.flow-naming-at-call` (the README Why's `flows into echo(mix, x)`
line — a call-arg's reason carries VarLookup but no callee/param naming;
FnParam-at-call woven into the arg reason at infer) ·
`Hβ.why.refinement-provenance` (the README Why's `output bounded by Sample
via soft_clip` line — the refined alias's provenance chain at the return
position).

`Hβ.synth.vocabulary-arg-holes` · `Hβ.synth.vocabulary-reach-index` ·
`Hβ.cursor.enclosing-decl-edge` (band M kin) ·
`Hβ.cursor.session-weave-epoch-scope` (DISSOLVED by the peer audit — the
session `<~` loop deletes the re-parse that created it; §11) ·
`Hβ.infer.alias-preserving-unify` (LANDED 2026-07-17 — not a unify-peel bug:
a forward-referenced refined alias bound a bare TName; `pre_register_alias`
registers the edges before any fn signature, §7 ledger) ·
`Hβ.own.region-return-transfer` (LANDED at the check; the caller-side
re-tag under region polymorphism is the arena increment) ·
`Hβ.lower.partial-via-lambda-recipe` (the peer-audit merge of
partial-effectful-callee + partial-local-callee: the mint routes through
the LambdaExpr machinery) / `.partial-prefix-arity` (lower.mn floors,
typed) ·
`Hβ.lower.k2-remainder-fncall` · `Hβ.lower.abandon-with-resume-arm` ·
`Hβ.lower.stateful-install-crossing-yield` (band B kin) ·
`Hβ.cli.audit-row-var-render` (cosmetic) ·
`Hβ.emit.int-splice-empty` · `Hβ.emit.f64-closure-capture-box` ·
`Hβ.m2.callsite-result-width` (the loud width family) ·
`Hβ.felt.ide-run-in-page` (in-browser assembler).
