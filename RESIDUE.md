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

`Hβ.eq.pipekind-match-eq-divergence` — RESOLVED (2026-08-07, the arc
loop's first iteration): the banked probe ran and the divergence was a
MISATTRIBUTION — there never was one. The raw-word census at
`$eq_nPipeKind`'s entry showed the `<~` pair as `a=3 b=3`, identical
sentinels, the eq answering TRUE; the count was 0 because of the walk's
NEXT read: `span_of_handle` CHASES to the union-find root, and a `<~`
node's chase lands on the continuation-boundary cell (bound with a bare
`Inferred` at `finalize_continuation_boundaries`), so the span answered
zero and the census skipped every feedback site as a synthetic mint. THE
LAW THE ROOT TEACHES: a weave walk reads a node's OWN raw facts — body
AND reason — because chasing conflates a node's identity with its
type-class representative; `span_of_node_raw` (graph_reason_at, no
chase) is the census's read now, and all six shapes count their own
sites (the frontier leg's roster gained `<~`). SIX KILLS BANKED, the
sixth being the entry's own former hypothesis: (1) lexer sound; (2)
op_prec sound; (3) kind table + builder sound; (4) the pointer-eq floor
— real and fixed via the Intent-Boundary annotations, but not this
root; (5) the mixed sentinel/boxed-nullary guard — refuted (the probe's
four heap pointers were the fixture's PFanout records, tag 1, CORRECTLY
boxed payload variants and correctly unequal; the reverted
emit_eq_leaf_sum experiment's BROKEN verdict stands as the record that
load-bearing eq semantics change only under march arbitration); (6) the
eq/match divergence itself — the eq was true, the span read was the
thief. STANDING RESIDUE, one face: `refs_of_name` shares the
chased-span read (span_of_handle) and measures green only because
VarRef roots happen to retain Located reasons — an accident-invariant;
migrating refs to the raw read is the same one-line law applied at its
sibling, sequenced with the census's per-file cut.

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

`Hβ.synth.rank-is-a-projection-not-a-field` — RESOLVED (2026-08-07, the
arc loop's second iteration, exactly by its own prescription): `cost`
left the record, the thirteen enumerator constants left their
construction sites, and rank is `rank_of` — a PROJECTION of the LIVE
candidate computed once per candidate at sort entry (the pair-keyed
insertion build), reading the callee name from the node and the decl
reason from the env. A ctor call IS a CallExpr(VarRef), so the design
half's "proximity keyed on the ctor name" fell out as the same one arm;
a nameless candidate (lambda, literal) carries the bare base with no
invented differentiation. The extraction-swap site
(canonicalize-survivor) now rebuilds without a number to carry, so the
stale-ride face dies textually. Cost-neutral: the same refs walk the
stored form paid at enrichment, moved to the read point.

`Hβ.egraph.extraction-cost-composes-repr` — the RULE-GROWTH CONTRACT,
banked 2026-08-07 while truing Phase 2.1 to the artifact: today's
rewrite set shrinks by construction (identity/absorb/fold point at
existing subnodes), so NO cost model exists and none may be hand-grown.
When band G's saturation-deepen adds the first NON-shrinking rule
(strength reduction, fusion, reassociation), "cheaper" must be a
PROJECTION composed from what the graph already proves — repr_of's
widths, effs_at's rows, the use-profile's counts — never a term-shape
function; and the canon edge it justifies should carry the cost's
Reason (the sibling gap `Hβ.egraph.canon-edge-carries-reason`, named in
the extraction-swap comment). The contract gates rule growth in Phase
5.5; violating it re-creates the disease 2.1 measured out of synth.

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

`Hβ.emit.total-monomorphization` — STAMPED whole 2026-08-07 (§11 5.1;
built on the artifact read of the spec-twin machinery, wasm.mn's
demand analysis). WHAT EXISTS, traced: three passes over projections
the graph holds — CANDIDATES (every reference site whose key projects
wide, closed transitively under substitution via spec_candidates_fix),
WORTHINESS (twin only when the body performs arith/compare/eq on a
wide-bound pair var — the address-comparison witness; plumbing shells
like fold/map stay at the floor), twins seeded into spec_registry and
redirected at every reference-emitting arm. THE REFRAME the read
forces: the machinery is ALREADY total-by-REPR — a candidate keys on
its repr vector (spec_enc), and the all-word vector IS the floor
CLASS, correct at the wasm altitude because a word is a word; the
measured silent-wrongs (address-compare sort, the ~0 float
accumulator, describe printing a pointer) all live at the WIDE seam
the candidates already cover. What §11 calls the perf-hybrid is
exactly ONE filter: the worthiness gate. THE PLAN, three legs: (5.1a)
DELETE WORTHINESS — every wide-keyed candidate twins, plumbing
included (pass 2 dies; pass 1's transitive closure is the whole
analysis); measured by the twin count, the m2 line delta, and the
peak ratchet — the blowup is BOUNDED by the demand set the union-find
already enumerates, and extraction reclaims duplication when band G's
projection matures. (5.1b) type-total IS repr-total plus the Repr ADT
growing (RI8 at 5.4, regclasses at band N) — arriving arms widen the
key BY CONSTRUCTION; no separate landing exists. (5.1c) THE CYCLE
GUARD, a real missing safety: spec_candidates_fix dedups by mangled
name, so polymorphic recursion demanding a NEW vector of its own base
per round would grow the work list unboundedly — the compiler HANGS
on a user program the wheel never writes (the productive-under-error
law's own shape: a hang is an error path recovering by looping). The
guard: a per-base vector-count cap along one demand chain; at the
cap the candidate floors at the uniform word protocol with a
narration (the Henglein price surfaced as teaching, never a hang) —
RED-first via a polymorphic-recursion fixture that today must be
probed (it may hang the current emit; the probe runs under timeout
and its verdict decides whether 5.1c leads or follows 5.1a). PRICED
(§5.O): no new scans — pass 2's deletion REMOVES a walk; the twin
blowup is the one cost, measured not guessed, and the 1,830,000 KB
peak ceiling arbitrates (a justified bump names the arena's later
reclaim). MEASURED 2026-08-07, both legs run: (5.1c) KILLED TWICE —
the mangle space per base is finite by construction (a wide component
is a scalar repr, containers are words, so ≤5^K vectors per base and
the fix terminates with no guard), AND polymorphic recursion cannot
reach the emit at all: the probe (`depth(x: a, n) = ... depth([x],
n-1)`, authored signature) refuses E_OccursCheck — the checker uses
the mono assumption for self-calls even under a signature, so
SYNTAX's "polymorphic recursion prices a signature" is today
refuse-both-ways (a measured 5.3 baseline: below Haskell/OCaml's
crude route). (5.1a) BUILT AND REFUTED BY THE MARCH: the worthiness
web deleted whole (nine fns), m2 compiled, and m3 TRAPPED — call
stack exhausted in zip_with — the wheel's own compile diverging under
a plumbing twin. THE GATE IS LOAD-BEARING CORRECTNESS, not a perf
hybrid: the worthy set was leaf-compute fns by construction
(spec_registry's own comment), so the twin emission for
SELF-RECURSIVE CLOSURE-CARRYING HOFs was never exercised and
miscompiles (zip_with's twinned recursion never terminates). The
deletion REVERTED whole. NEW PEER, the real blocker:
`Hβ.emit.plumbing-twin-selfcall` — PROBED 2026-08-07, three kills
banked and the hypothesis SHARPENED: (1) the minimal plumbing twin is
CORRECT — a wide zip_with fixture through the probe m2 (worthiness
forced true, uncommitted) twins (nine zip_with$ references) and runs
exit 10; (2) a sensitive self-recursive closure-carrying HOF twin
(sum_with, float acc) runs correct through the CURRENT boot — the
live twin set is fine; (3) the compiler NEVER calls zip_with at
runtime (all ten link refs are lib/ml + prelude), yet the reproduced
trap (same probe tree, march) shows m2 executing 20+ zip_with frames
ALL AT ONE PC (0xcf6e) from a caller the truncated backtrace never
prints. A fn executing that provably has no caller is the
corrupted-dispatch shape: a call_indirect whose computed table index
lands on zip_with's slot (the bad-table-index class — "prints WAT
mid-inference means the parser ate an arm"'s runtime sibling),
pointing at a PINNED-BOOT miscompile of the probe SOURCE (the boot
emits m2; the probe source's demand-fn shapes may tickle a boot
emission bug — closure record layout, table-index global, or
evidence slot). SECOND PROBE SESSION (2026-08-07, five more kills — the forensic law:
count them): (4) the dispatch-corruption hypothesis DIED — 0xcf6e
disassembles to `call 68 <zip_with>`, the floor's DIRECT self-call
(no call_indirect anywhere in the loop); (5) "the compiler never
calls zip_with" DIED — it calls ZIP (enumerate = zip∘range; the
original refs query asked the wrong name); the depth-1 entry trap
named the FIRST caller as register_one_op → build_ctor_params →
enumerate — benign, ≤5 deep; (6) the boot-miscompile hypothesis
DIED — the clean-vs-probe emit-diff's 1,379 "differing" fns are all
lambda-NUMBER drift from the probe's own comment lines (zip's one
diff line is a lambda_idx global rename; emit-diff does not
normalize lambda-name references inside named fns — a tool
limitation now known); (7) the enumerate-blowup hypothesis DIED — an
entry trap on any enumerate list >10k never fired; (8) the
list_eq_f64 route DIED — all four binary `call 69 <zip>` sites live
in the generated list_eq_f64, and its depth-1 trap never fired. WHAT
SURVIVES: the runaway enters zip_with through the CLOSURE-VALUE path
(the `global.get $zip_with` record passed first-class into a HOF and
invoked by call_indirect — the one entry the direct-call census
cannot see), with either a huge legitimate list or a list whose
len/rest disagree (rest never shrinking what len reports small). The
coredump and backtrace both cap at 20 frames, so the caller is
invisible to frames. NAMED NEXT INSTRUMENT, fully specified: the
CALLER-ID + COREDUMP-MEMORY scheme — patch each call_indirect site
that can carry the zip_with record (or cheaper: patch zip_with's
entry to store its ARG-list handles and a per-call counter into
scratch words 0-2), run to exhaustion, then read the coredump's DATA
SEGMENT at those addresses (the coredump carries the whole memory
image; frames cap but memory does not) — the stored words name the
runaway's input list handles, and lookup of their headers in the
same image answers huge-vs-corrupt in one read. THIRD SESSION (2026-08-07, the globals-forensics round — wasmtime
coredumps carry GLOBALS, not memory; the probe values live in added
globals and read out of the dump): THE RUNAWAY IS PINNED TO NUMBERS.
zip_with dies 87,311 calls deep (deterministic across runs), on a
list whose len() answers 26 FOREVER: the deepest node decodes as a
slice [len=26][tag4][parent][start=1] (slice_raw's exact layout,
lists.mn:493-498), a fresh 16-byte-class node per level at ~1.8GB
(late compile). rest(xs) = slice(xs, 1, len(xs)) allocates but never
progresses. THE ARITHMETIC CONTRADICTION that names the next read: a
level storing len=26 with start=1 requires its parent's total ≥ 27
(new_len = cend − cstart with cend clamped to total), yet every
probed level shows 26 — so the PARENT pointer (w2, captured) does
not chain to the previous slice node (56 bytes back, not 16 — other
allocations interleave), and the parent's OWN header is the missing
read. SUSPECT ON THE BOARD: slice_raw's `let total =
load_i32(list)` — a representation-BLIND raw read of word 0 as "the
total" (the prober-must-honor-protocols law at the runtime's own
source); if any non-slice representation reaches it whose word 0 is
not a length, total is garbage and the chain follows. FOURTH SESSION (2026-08-07): the parent-chain capture ANSWERED the
contradiction — lens run 26 ← 27 ← 28 up the chain, so the recursion
PROGRESSES correctly one element per level; 87,311 deep with 26 left
means the chain's ORIGIN was ~87,337 long — a number in the range of
the compile's HANDLE count, sharpening the blind-total suspicion to
the chain ROOT: word 0 of the original (non-slice) node misread as a
length (slice_raw's `load_i32(list)` total, or a len() fallback arm)
mints an 87k-len slice over a small list, and every level below is
arithmetically consistent. f's closure index = 41 = floor zip's OWN
pairing lambda ⇒ entry through floor `zip`. Source-level >10k guards
at ALL FIVE direct zip sites (infer 4051/6038/6096/6279, lower 1538)
stayed SILENT through a reproduced trap — five more site kills — so
the entry is the SIXTH zip: enumerate's (prelude:268), whose earlier
binary guard was MISWIRED (passed __state in the arg slot; its
silence proves nothing). RESOLVED 2026-08-07 (pin dedfec69264a — the LEDGER's THE STACK HOLDS
FLAT carries the ten-kill chain): NO corruption existed anywhere. The
counter was global (87,311 = all calls, not depth), the death depth
was the AMBIENT stack budget (a few thousand frames under the emit's
own compile depth), and the entry list was ENUM len=4696 — the
twin-inflated fn-name table (clean ~3,590) crossing a cliff the
pinned build sat ~1,000 fns from on its own. zip_with is now the
buffer-counter tail form (zip_with_fill, range_fill's shape,
callee-first); mn-zip-deep pins 200,000 fresh-stack elements, seen
RED at exit 134. CONSEQUENCES: `Hβ.emit.plumbing-twin-selfcall` is
CLOSED (no twin ever miscompiled); 5.1a RE-SCOPES to a
ratchet-measured cost question (twin count, m2 bytes, peak RSS —
re-attemptable, no crash); two small residues named —
`Hβ.cli.test-single-file-judges` (`mentl test <file>` silently exits
0 without judging; the battery form is the directory) and the
non-tail prelude-builder CENSUS (the `[x] ++ self(rest)` shape
class — zip_with was the proven killer; the class enumeration is one
audit-tier query away). The worthiness gate STANDS until
this closes — named at spec_demands_of as the guard of an unfixed
blowup class (the demand-set explosion is real either way: the gated
twin set is tiny by construction, the total set is not, and the
emit's own prelude consumers are non-tail).

`Hβ.perf.per-decl-arena` — STAMPED whole 2026-08-07 (§11 4.3; the gate
peer `Hβ.infer.region-on-tee-alloc-absorb` folds in below). WHAT EXISTS,
traced: heap_mark/heap_reset with the virginity contract
(memory.mn:139-145), battle-tested at the BATCH boundary (per-micro
inside `mentl test` — the arena's first real workload); the paged spine
SIZED for per-decl banding by its own comment (graph.mn:91-93 — max
2,305 mints/decl measured, p99 331, 7× headroom); the region proof
(own.mn's region_tracker — every fn body a region, return = transfer);
4.1/4.2 landed as the ordered escape police (T_UseAfterMove + the honest
grade); emit_memory_arena DORMANT (wasm.mn:159-182 — the region
semantics belong to the $alloc body, the seam-gated
Hβ.emit.memory-strategy-body-swap); persist reading [0, heap-line) as
the image (memory.mn:74-99). THE DESIGN — the image/scratch split,
row-classified, no copy-out: two bump spaces in the one linear memory
(image low/monotonic via $ialloc; scratch high, mark/reset per decl;
Hβ.emit.image-map-fold draws the boundary as one fold). Classification
by STRUCTURE ROOT, carried by the writer's own row (an ImageAlloc
effect on the growth fns — the medium's vocabulary, never a runtime
tag). The IMAGE writers, traced set of SIX families: (1) spine
band-open pages (spine_ensure/list_extend_to), (2) the env flat buffer
+ index-bucket conses (src/env.mn growth paths), (3) the intern table
(src/intern.mn — largely parse-phase, pre-mark by construction), (4)
published schemes + their type trees at env_extend (SHRINKS to
near-zero at rung 3 — the families' one transitional member, deleted
by 5.2's own diff), (5) the WAT output buffers (wat_emit
accumulation), (6) the diagnostic bank + oracle-queue roots.
Everything else is scratch and dies at the decl reset. The decl
boundary is the driver's per-decl walk bracketing mark/reset in the
USER-FACING form — a `~>` region install absorbing Alloc — so the
absorb license IS the reset license (the gate peer's whole content;
Mentl solves Mentl). REJECTED BRANCH, priced: copy-out at the boundary
(the return-transfer materialized as a deep copy below the mark) — the
walker is the deleted .kai serializer's shape, and the split buys what
copy-out cannot: the image IS band B's persist set (persist = memcpy
of [0, image-line), scratch excluded by construction). 4.3 and 9.1
converging on ONE boundary is the design's truth signal. PRICED
(§5.O): zero new scans (static per-site classification; O(1) reset;
band-open unchanged); the working set collapses to one decl's live
set. COST INSTRUMENTATION IS BUILD STEP 0 — a doc-truth finding rides
this stamp: §5.O's "march measures wall+RSS / PROVENANCE carries the
cost line / verify-baseline ratchets peak" is STALE prose (none true
of today's march.sh); the instrumentation returns first and the win
lands as a diff of two measured reads, never a claim. MARCH CONTRACT:
TRANSITION by construction (the two-pointer layout shifts heap
addresses → interned offsets → WAT bytes; the 2026-07-17
"output-invariant" refutation governs; re-pin from m3). GATES,
RED-first: (a) the per-decl reset fires on the wheel compile (a
counter ≈ decl count); (b) a post-reset image-reachability audit leg —
the mis-classification tripwire, because virgin-zero reads are SILENT
and the audit is the loud face; (c) the peak-RSS diff recorded
in-baseline; (d) the per-micro batch boundary keeps its green. BUILD
ORDER, marched: (0) cost instrumentation + measured baseline — ✅
LANDED 2026-08-07 (gen under GNU time, the pin's cost line, the peak
ratchet seen RED at ceiling 1 then banked at 1,830,000 KB over three
~1,742,900 KB reads; the self-compile's honest footprint is ~1.70GB /
~8.4s, correcting the era-stale ~694MB); (1)
ImageAlloc vocabulary + $ialloc emit — ✅ LANDED 2026-08-07 (pin
b5730e6110ac: the effect + ialloc in memory.mn, one name in
is_substrate_mem_op grounding it at the root gate by derivation, the
emit arm riding $alloc with the step-3 fork named; micro
mn-image-alloc RED→42; the cost loop's first pin measured a ~4%
cross-invocation RSS spread, named in the pin).
STEP-2 CORRECTED 2026-08-07 (the build refuted the stamp's mechanism
before a line landed): "classify the growth fns onto ialloc" has NO
SEAM for constructor-built structures — spine_open_loop's pages, the
env buckets, the intern table all allocate through the emitted
constructors ($make_list, record mk → $alloc), not through a
wheel-source alloc() call, and row-only decoration is FALSE prose the
medium itself narrates against (a declared-but-unperformed ImageAlloc
is T_OverDeclared). The classification is therefore an EXTENT
BRACKET — exactly the gate peer's own form (a region install
absorbing Alloc): paired substrate ops `image_enter()`/`image_exit()`
on ImageAlloc (depth-counted, borrow_depth's shape and
heap_mark/heap_reset's pairing idiom), bracketing each family's
growth extent so the rows come out TRUE via real performs; the `~>`
tee spelling stays the peer's absorbing refinement once handler
installs can reach the substrate allocator. THE CORRECTED ORDER: (2a-i)
the pair's vocabulary — ✅ LANDED 2026-08-07 (pin e524668b29f3:
image_enter/image_exit declared, recognized, emitted as $image_depth
bumps with the global demand-gated on the pair's performs; zero wheel
performs keep the pin CLEAN; micro mn-image-region RED→42); (2a-ii)
the family brackets + the census — FAMILY (1), spine_ensure's growth
extent, ✅ LANDED 2026-08-07 (pin 2f5ef189a823, the priced TRANSITION
at 6 diff lines; the census rides the extent delta — outermost enter
marks, matching exit accumulates — two branches per bracket, never
per allocation; the row cascade measured at twelve driver-spine
widens, caught by verify's census ratchet after the march, which does
not gate census).
THE CORE REFUTATION (2026-08-07, before family 2 landed a line):
SITE-CLASSIFICATION IS UNSOUND FOR THE VALUE GRAPH. A spine cell is a
WORD pointing to a heap record (the substrate's own definition —
every value a handle-addressed record); the Ty/GNode/scheme values
those cells and the env's entries point at are allocated DURING
inference, interleaved with scratch, and published later by
POINTER-WRITE — so no extent bracket at the publish site classifies
their allocation, and a per-decl reset would zero live
image-reachable values under every column written that decl. Extent
brackets are sound exactly where the extent IS the publish (band-open
pages — family 1 stands; flat-buffer growth shares the property for
the BUFFER cells, not their pointees). The sound forms, priced: (i)
per-decl EVACUATION of live-out values (a generational nursery copy —
structure-copy, not wire-format, so the .kai objection weakens, but
the walker cost and shared-identity questions remain); (ii) COLUMNS
FIRST — rung 3 (schemes-are-edges, §11 5.2) plus the 5.5 column arc
move published facts INTO spine columns and flat buffers, making the
image set = pages + buffers BY CONSTRUCTION, extent-bracketed exactly
as family 1 already is, with no per-value classification anywhere;
(iii) no reset (the arena dies — refused, the hub's riders stand).
CHOSEN: (ii), the Mentl-native form — the graph IS the image.
RE-SEQUENCED: 4.3 PAUSES at 2a (family 1 + the census print next pin
measure the banded fraction honestly); 2b's fork/reset DEP-GATES on
the column arc (5.2 + 5.5); families 2-6's brackets land in the
column era where each family's storage is a page or flat buffer by
construction. §11 4.3's entry carries the same correction; the
reachability audit leg survives as 2b's tripwire unchanged; (3) the
dormant emit_memory_arena resolves at 2b — its real body or its
deletion, one strategy read from the module's own proof.

`Hβ.own.use-after-move` — BUILT (2026-08-07, pin 8ba768c810c4, before
the arena exactly as prescribed). The mechanism was one leg's ORDER:
the ledger's consume arm checked `borrow_depth > 0` before the
used-set, so every borrow surface (conditions, scrutinees, ref-param
args, every seq-op arg — len's resolved Ref param walks its arg
borrowed) read moved owns silently. Now `set_contains(used, name)`
reads first: consuming second use stays armed E_OwnershipViolation;
borrow-read of a moved name is T_UseAfterMove (narration; wheel census
ZERO at birth, use_after_move_max: 0 ratchet). Gate:
tests/frontier/mn-use-after-move.mn via run_narration, seen RED.
RESIDUAL — the ARMING: joins diag_refuses at held wheel-zero after an
E_OwnershipViolation-precedent falsification pass (the unresolved-
callee borrow default reports true reads-after-move beside the miss —
verify no false channel on resolved programs first).

`Hβ.infer.grade-is-join-and-mode` — BUILT 2026-08-07 (pin 4115ed285d39,
against the stamp; the LEDGER entry of the same name carries the arc).
The walk landed exactly as stamped — usage_of's (consume, read) pair, ⊔
across alternatives, mode from the callee product, lattice ops at
types.mn, count_uses family deleted whole (its NStmt(_) => 0 blanket had
never counted a statement-level use — a third measured blindness, closed
by the walk's explicit LetStmt/ExprStmt arms). TWO STAMP CORRECTIONS the
build measured: (1) the "order-dependence exists today, NAMED not
widened" pricing was wrong-in-degree — the walk's callee-product read
AMPLIFIED it (set_contains calls its textually-later helper; the
consume-default slot graded it Own; every caller moved; the wheel
refused on driver_collect_visit's `visited`). Closed structurally in
param_borrows' one home: a still-Unmarked resolved slot BORROWS (the
read-safe default — passing to an ungraded or unused product must not
burn the caller's own). (2) The blast landed in the MOVERS channel, not
T_UseAfterMove: +188 moved schemes (474 → 662, in-baseline
justification) — forward callees resolve between trial and final, so
grades move with them; rung 3's class-based reads dissolve the class
and this order-dependence together. T_UseAfterMove held 0 throughout;
T_OwnUnconsumed reached wheel-ZERO (collect_arm_tags' authored `own
init` dropped — fold's f is a param callee whose product the grade
cannot read; the seed's transfer is structural). RESIDUAL, banked: the
param-callee blind spot (calling through a fn param reads its args —
the grade cannot see the param's eventual consumption; surfaced only
as under-consume → Ref, the borrow-safe direction) and the
T_OwnUnconsumed arming licence now open at wheel-zero (same
falsification bar as use-after-move's). Band-H baseline rides: 84
authored `own` + 763 authored `ref` in src/ — now honest counts to
drive DOWN, no longer compensation.

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

`Hβ.dataflow.feedback-becomes-whole` — the design stamp for PLAN §11
Phase 3.6 (banked 2026-08-07; UNBUILT — this entry is what gets built,
and it carries ONE FORK FOR MORGAN, below). FOUR MEASURED FACES at pin
c46691d75a57: (1) `<~` contributes NO iterative effect — the census
fixture's fb types Pure, and lib/dsp's lowpass_iir (declared
`with Sample + Memory + Alloc`) publishes only Memory + Alloc, the
authored Sample vanishing because nothing in the body performs it;
(2) the FeedbackSpec constructors (prelude.mn:519 — delay/accumulate/
filter_spec) are PURE wrappers, so SYNTAX's "a state-element — a value
that performs the iterative effect" is design the artifact never
realized; (3) E_FeedbackNoContext exists in the DiagKind catalog with
ZERO construction sites — the context requirement is entirely
unenforced (the fixture's `x <~ inc(1)` draws only the FeedbackSpec
type mismatch); (4) the zero-delay causality refusal
(`Hβ.dataflow.causality-compile-error`, Faust's rule) is absent —
Delay(0) types like Delay(1). THE DESIGN, traced: infer's PFeedback
arm gains the verb's own typing rule — (a) resolve the ITERATIVE
CONTEXT: an Iterate-class effect present in the enclosing fn's
declared row or installed by an enclosing `~>` (the static
enclosing-tee walk the where verb's schedule badge already built —
reuse it); absent → E_FeedbackNoContext finally fires; (b) CHARGE the
context's effect into the body row (inf_add_row at the arm — the
recurrence performs the tick-advance each iteration, so fb stops
typing Pure and lowpass_iir's authored Sample matches its body);
(c) the CAUSALITY refusal: a literal Delay(0) RHS refuses at the arm
(the decidable case; a computed delay rides Phase 8's refinement
tier); (d) `Hβ.dsp.state-element-install-once` (the !Alloc reclaim)
rides the arena (Phase 4.3) — named, not this build. GATES: the fb
census-fixture site TRUED to a real spec (`x <~ delay(1)` under a
declared context; the census's `<~` pin moves with it), a DSP row
fixture asserting lowpass_iir publishes Sample, a Delay(0) refusal
fixture RED-first, and E_FeedbackNoContext's first firing gated.
THE FORK (Morgan's, both branches priced): HOW does an effect join
the Iterate class? SYNTAX says "Sample/Tick/Clock are *instances* of
that class, not a hardcoded name-allowlist" — but declares NO surface
for the membership. (A) STRUCTURAL: no honest structural signature
exists (any op shape can be coincidental); every candidate read is
name-keyed drift in costume — REFUTED at trace. (B) DECLARED: the
effect decl carries the class (`effect Sample(rate: Int) iterates
{ … }` or an equivalent marker) — one keyword-adjacent surface
addition, the class fact then an env read at the arm; honest,
teaches at the decl, and the SYNTAX section that promised
no-allowlist gets its mechanism. The build blocks on (B)-or-better;
until chosen, the arm cannot name its class membership without the
allowlist SYNTAX forbids.

`Hβ.driver.per-module-env-overlay` — the design stamp for PLAN §11
Phase 3.5 (banked 2026-08-07 with the first half LANDED: the solo
sweep measured 53 violations across 13 modules at pin 7d8e91e499a1,
two one-line imports killed 17 — verify→graph+runtime/io,
format→parser — and solo_violations_max: 36 is the banked ceiling the
frontier's sweep leg enforces). THE RESIDUAL 36 IS TWO ARCHITECTURAL
SEAMS, measured and directioned, not under-imports: (1) THE
INFER→PIPELINE HANDLER SEAM (~20 across nine closures) —
infer.mn:2310's install chain (`~> env_handler(bb, bc, bi) ~> … ~>
intern_view(ib, ie, ic)`) installs handlers DECLARED in pipeline.mn, a
layer the import DAG places ABOVE infer (pipeline imports infer; the
reverse edge would cycle); the fix relocates the handler DECLARATIONS
down to their substrate homes (the env buffer's and intern table's own
modules — which is also §5.5's env-column move meeting the manifest:
the declarations land where the state they manage lives, and infer
imports that); (2) THE MCP→MAIN VERB-GRAMMAR SEAM (16) — mcp.mn:558
parses sessions with parse_cli_args, declared in main.mn beside
VerbSpec/verb_specs ("one grammar two transports", mcp's own comment),
and main imports mcp so the reverse edge cycles; the fix relocates the
verb grammar to a home both transports import. THE OVERLAY PROPER (the
second half, unbuilt): per-module env views on the ONE graph — each
env entry tagged by its defining module at env_extend, each lookup
filtered by the ASKING module's import-closure membership (a
per-module closure bitmask makes the filter O(1)), so solo checks and
queries get their REAL link sets without re-judging; diagnostics scope
to the queried file (healing the fmt scope register's 416 foreign
lines), the census gains its per-file cut, and query spans gain
file-true coordinates (`Hβ.query.decl-site-file-coordinates` lands
here). PRICED: the tag is one word per env entry written at the one
writer; the closure bitmask is per-module, built once from the
manifest DAG; the lookup filter is one mask test. WRITERS when the
second half builds: env_extend (the tag), the driver (the closure
masks from the DAG it already walks), env_lookup (the filter,
context-threaded), the check/query/fmt verbs (the asking-module
context), and the sweep leg's ceiling falling to 0.

`Hβ.types.named-effect-rows` — BUILT 2026-08-07 against this stamp (pin
6768ffac9dfa; the fixture's alias-of-alias `Both - B` grouping case
runs 3 with zero diagnostics; the named residual: a row alias used in
TYPE position today resolves as the nominal shape scheme rather than
refusing — the type-position refusal lands with the diag catalog's
projection, Phase 8.4). The stamp as banked: MEASURED at the felt walk and re-grounded at pin 8031eaf1:
`type Both = A + B` refuses `P_UnexpectedToken: +` at the type-decl
RHS, `A & B` likewise, `A - B` mis-resolves to a nominal non-row — so
SYNTAX §«Named effect rows», the section that RETIRED the `capability`
keyword, has no working spelling. TRACED — the one-representation
law decides the design: the with-clause already parses to signed
triples `[(EffName, Bool, EConn)]` and `build_declared_row`
(effects.mn:167, the signed-clause fold) is their ONE home, so a row
alias STORES THE SAME TRIPLES and expansion happens where rows are
built. THE GROUPING TRAP, killed at trace time: splicing an alias's
triples inline into the outer clause breaks grouping — with X = B,
`X + (A - B)` is B + A while inline `X + A - B` folds to A — so
expansion is NOT triple-inlining; the fold, on meeting a name whose
env kind is the row alias, recursively builds THAT alias's row whole
and applies the outer connective to the RESULT (parenthesization by
construction). Needs: (1) parser — the type-decl RHS row grammar
(ident joined by + - & with ! negation prefixes), producing the decl
that stores the triples — the SAME shape the with-clause mints, one
representation; (2) env — a RowAliasKind([(EffName, Bool, EConn)])
SchemeKind registered at the type name (a row alias is an ENV fact;
it never enters Ty unification — used in TYPE position it is a
refusal, not a TName); (3) the declared-row build resolves each
name through env: leaf effect vs row alias (recursive build + a
cycle guard refusing self-referential aliases loudly); the row
ALGEBRA (union/diff/inter/subsume) never sees alias names —
expansion completes at build time; (4) `W_EmptyRow` (SYNTAX names
it: a named row resolving to Pure narrates); (5) gates — the felt
walk's namedrow probe graduates to a fixture (`type Both = A + B`
+ `with Both` running through handlers), plus a `-` case proving
the grouping law and a `&` case, RED-first. PRICED (§5.O): the
alias expansion is O(alias tree) per declared row, built once per
decl at the existing fold; zero new graph state beyond the env
kind. WRITERS when it builds: parser.mn (the RHS grammar +
decl registration path), types.mn (the SchemeKind variant),
effects.mn or its caller boundary (the env-reading expansion +
guard), the W narration, fixtures + a frontier leg.

`Hβ.lower.list-rest-binding-runtime` — the list-rest BINDING's runtime
gap, measured 2026-08-07 at pin 8031eaf1 while landing the lambda
list-pattern parse fix (Phase 3.3's first drift). Two faces, one
family: (1) the lambda path (`([h, ...t]) => h`) parses and checks
clean now but solo EMISSION dangles — the rest binding emits a
hand-baked `$make_list` call the graph has no edge for, so
reachability (edge-following from main) prunes the definition while
the call survives: `undefined function variable "$make_list"` at
assembly — the Carried-Truth class at the emit layer (a call the
graph cannot see); (2) the fn-param path (`fn take_first([h, ...t])
= h`) REFUSES solo with one undischarged claim before emission — a
different symptom, same never-exercised family. The wheel's own
list-rest matches run because the full link always carries make_list
and its claims discharge there — tripwire 3 verbatim (the board's
oracles are blind to what the wheel never does solo). THE GATE:
tests/frontier/mn-lambda-list-param.mn runs 7 the day this closes
(its header carries the expected value); the frontier's parse-half
leg holds the parse victory meanwhile. The fix direction the
measurement names: the rest binding's list construction must be a
GRAPH-VISIBLE call (a real CallExpr edge to make_list minted at
desugar, exactly as the record-rest residual builds through typed
edges — mn-record-pattern-rest runs 30 through the same gate shape),
never an emit-baked name.

`Hβ.cli.where-verb` — BUILT 2026-08-07 against this stamp (pin
0d3a196299d1; four badges live and gated; two dig lessons in the
LEDGER entry MENTL WHERE LANDS — index walks over env-stored lists,
the typed accessor over the raw field read; the fixture's own badge
corrected the fixture: a handler named threaded that covered Tick
read [Seq], because the projection reads the artifact, not the name).
The stamp as banked: `mentl where` is
the derived-badge projection SYNTAX names six times and the lag list
carries: output, never input — the medium narrating facts the graph
already proves. TRACED — three badges, each an existing read wired to
the surface: (1) REPR — a value name's representation width via the
env scheme → chase → `repr_of_resolved` (types.mn:172, GraphRead),
rendered `name : Float @ f64 (pinned|inferred)` — pinned iff a
TReprPin sits in the chased chain (a small discriminator walk to
write), inferred otherwise; (2) RESUME CARDINALITY — an op name's
`TCont(R, S, discipline, world)` read from its EffectOpScheme's TFun,
rendered `R ->1 S` (OneShot) / `R ->* S` (MultiShot) / `->? `
(Either) per SYNTAX §«Resume discipline»; the channel is the op
scheme — the build verifies where the discipline lands after
handler-decl inference and reads THAT, never a re-derivation; (3)
SCHEDULE — a `><` site's resolved strategy as a STATIC walk up the
site's enclosing `~>` chain in the weave matching Schedule-class
handlers, rendered `>< [Thread]` / `>< [Seq]` (none installed = the
invisible default). The static walk is EXACT, not approximate: the
schedule is read at the fanout's own install site and never crosses a
call boundary (the parallel_map dissolution's law,
`Hβ.prelude.parallel-map-dissolves-into-schedule`), so the enclosing
chain IS the whole truth — lower's ambient-stack read
(lower_fanout_schedule, lower.mn:1620) and the weave walk answer
identically by that law. SURFACE: `mentl where <file> <name>` riding
the query spine exactly as the census did — a QWhere Question
variant, the arm in query_default, the CLI verb mapping through the
query invocation; a `><`-site's badge addresses by name of the
enclosing fn (the fn's fanout sites listed with their schedules).
PRICED (§5.O): each badge O(1) per name (one env lookup + one chase);
the schedule walk O(enclosing-chain depth); a pure READ verb, no
writer. WRITERS enumerated when it builds: main.mn (VerbSpec + the
V* variant + dispatch), pipeline.mn (verb parse → QWhere), query.mn
(the Question variant, the arm, the three badge projections + the
TReprPin discriminator), docs/SYNTAX.md (the lag list SHRINKS —
`mentl where` leaves it, the list's own contract), tools/doc-truth.sh
(verifies the verb serves via `mentl help` — the lag-list check
inverts for this name), the frontier leg + fixture (three badges
asserted: a pinned repr, an op cardinality, a scheduled and an
unscheduled fanout). The gate seen RED first: the fixture's `where`
queries answer unknown-verb through the prior pin.

`Hβ.parser.pcompose-nary` — BUILT 2026-08-07 against this stamp (pin
05fd2307ff43; the mn-fanout-nary micro runs 9 where the prior pin
exited garbage; the m3 trap censused five hidden full-enumeration
walkers by the ExprPlaceholder tell — nested-pattern exhaustiveness
cannot convict across depth, a checker limitation the trap reported;
the anonymity ratchet then convicted the build's own three lambdas
and the stages were named). The stamp as banked: MEASURED at pin 62542a59bf94: `(inc(1)) >< (inc(2))
>< (inc(3))` folds left into `((Int, Int), Int)`, so `let (a, b, c) =`
refuses with "type list arity mismatch: 0 vs 1" + "(Int, Int) vs Int"
— the violation exactly as §11 3.1 states it. TRACED — three encodings,
two REFUTED: (A-min) parse the chain into FanShare's
branches-as-MakeTupleExpr convention — REFUTED by collision: a
tuple-VALUED branch (`(1, 2) >< (3, 4)`) is indistinguishable from the
chain encoding, a silent-wrong class; (C) judgment-side flatten of
left-nested spines with no parser change — REFUTED by the law's own
words ("must parse N-ary") and by parens-intent conflation (grouping
does not survive to the AST, so authored nesting and precedence
folding cannot be told apart); (B) first-branch-left + rest-in-tuple —
REFUTED: the branches are peers and the shape would lie. THE CHOSEN
FORM: `><` alone grows a dedicated N-ary carrier — `FanoutExpr([Node])`
(an Expr variant whose branches are a LIST) — while `<|` KEEPS
`PipeExpr(PFanout(FanShare), input, branches_tuple)`: the two verbs
have different operand structure BY NATURE (`<|` is input × branch-set,
binary; `><` is N peer branches, genuinely N-ary), and the kernel's
"one PFanout node carrying an arity" is already true at LOWER (the
STEP 4 collapse); the surface carriers differ, the lowered node is
one. PRICED (§5.O — each touch a mechanical arm, no new asymptotics):
parser.mn (the prec-2 chain collect builds FanoutExpr from a `><`
run), types.mn (the Expr variant; PipeKind/FanOwn untouched — the
census's CsVerb(PFanout(FanDistribute)) stays keyed on the fanout
kind), query.mn (expr_child_handles gains the arm; census_matches'
CsVerb arm matches FanoutExpr as a `><` site), infer.mn (infer_fanout's
FanDistribute arm walks the list — N value boundaries, TTuple(N)),
lower.mn (the fanout lowering enumerates the list into the
arity-carrying runtime record), format.mn (render_compose_chain reads
the list; the render shapes are unchanged — SYNTAX's vertical/inline
canon is already N-ary). WRITERS enumerated: those six plus the gates —
the nary probe graduates to a micro (expect 9), the census fixture's
`><` roster line keeps counting through the new carrier, and the
three-way destructure fixture is the RED gate. The felt walk that
banked this also re-confirmed 3.3's drifts live (lambda list-pattern
param refuses with six parser warnings; `type X = A + B` refuses
P_UnexpectedToken; `xs |> len` diagnoses a false E_TypeMismatch while
emitting 96,768 bytes of correct WAT) and refuted one 3.4 claim in the
right direction: `-> !` checks CLEAN — SYNTAX's lathe-lag note is
stale and dies at 3.4.

`Hβ.infer.diverge-shared-memory-row` — RECOVERED 2026-08-07 (PLAN §11
Phase 2.4; named 2026-05-05 in b139622b as peer G.1, gone from every
index by 2026-08-05 — drift-9 at the roadmap layer). The original form
spoke the Thread-effect-era substrate (a hardwired `+ Thread` on the
verbs); the RESTATED form speaks today's: the fanout is ONE PFanout
whose ownership aspect discriminates `<|` (FanShare — one input
ref-borrowed across N branches) from `><` (FanDistribute — N owned
inputs, nothing shared), and execution is a `~> Schedule` handler read
live at the install edge. Under `~> Thread`, that ownership aspect IS
a row fact the infer arm must charge: a FanShare fanout's borrow is
VISIBLE across cores — cross-core visibility of a shared referent
requires atomic ordering, so the fanout's row needs `+ SharedMemory`
(or each branch proving it never reads the borrow after spawn); a
FanDistribute fanout shares nothing, so the same arm can prove
`+ !SharedMemory` — parallelizable-no-sync, stated as a negative
capability. This is the substantive half of the two-parallel-verbs
reframe: the ownership discrimination becomes a thing the CROWN
PROVES (a `!SharedMemory` the row algebra discharges) rather than a
thing the docs assert. Sequencing: the charge site is the same infer
fanout arm Phase 2.2 just cleaned; the PROOF verdict inherits
`Hβ.effects.sound-neg-under-poly` (band A / Phase 6), so it lands
with band E's verification tier (Phase 9.2's safety verdicts) —
beside `Hβ.parallel.thread-alloc-transitive-proof` and
`.race-freedom-ownership-proof`, and prior to it `>< ~> Thread`'s
race-freedom claim rests on the ownership read alone. Two sibling
names from the same archaeology, recorded so the recovery is whole:
`Reason.branch-spawned-verb-tagged` (G.2 — spawn provenance
verb-tagged for the Why engine) survives in today's vocabulary as a
facet of `mentl where`'s schedule badge (PLAN §11 3.2); G.3's
thunk-abstraction trigger dissolved when STEP 4 collapsed the two
lower paths into one PFanout.

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

`Hβ.audit.anonymity-tier` — BUILT 2026-08-07 against this stamp (pin
eb827fae186d; the tier reads TWO classes — the build corrected the
stamp's class 3 in place: a pure lambda on a quantified row var is
exactly `map((x) => x + 1, xs)`, the vocabulary itself, so the
quantified-param landing is not an independent conviction and its
honest half — the published row — is the row class already; escape
stays the DEP below). The stamp as banked, correction folded in: MEASURED BASES, both true, name the base when
citing either: the weave census counts 555 anonymous fns on the wheel
link (`mentl query src/main.mn "census anonymous"`, read this day);
§11's 490-of-3,469 counted EMITTED fns (2026-08-05 harvest) — the two
differ because emitted fns dedup and prune. Text-shape approximation:
~136 of the 555 are ETA-WRAPPERS (108 unary `(x) => f(x)`, 17 binary,
11 nullary) — the one class with a MachineApplicable fix. TRACED — four
conviction classes, each a live graph read on the site's OWN raw facts
(the census's span_of_node_raw discipline; no chase for identity):
(1) ETA-WRAPPER — LambdaExpr body is CallExpr(VarRef(g), args) with
args ≡ the param list in order; convict, MachineApplicable (pass `g`).
(2) NON-PURE — the lambda's TFun row ≠ Pure (one chase + row read);
convict as a named-stage-in-hiding: teaching verdict, the name is
intent and stays the human's. (3) QUANTIFIED-ROW-PARAM LANDING — the
lambda lands on a callee param whose row var sits in the callee
scheme's quantified set (the Phase 1 sig-keep boundary read at the
application edge); convict — a published row boundary deserves a named
carrier. (4) ESCAPE — DEP `Hβ.infer.use-profile` (band N S2, the
escape-bit); NAMED, not built — until it lands the tier reads classes
1–3 only, and the tier's report says so. Silent on the pure-local
immediately-consumed lambda — the vocabulary the surface wants
(`map((x) => x + 1, xs)` never narrates). PRICED (§5.O): one weave
walk O(nodes) — census_walk's class, no new asymptotics; per lambda
class-1 is O(arity) on raw body shape, class-2 one amortized chase,
class-3 one edge read into the scheme; all reads live at audit time,
no snapshot, no writer — a pure READ tier. ENUMERATED writers when it
builds: the audit tier arm beside iteration-shape, the frontier leg +
fixture (one convicting eta, one convicting non-Pure, one silent
pure-local — seen RED first), and NOTHING else: the verify-baseline
ceiling and the CensusShape migration are §11 2.5's, not 2.3's.
BANKED NEXT PROBE: the built tier's first whole-link run reports the
class split (eta / non-Pure / quantified-param / multi-class) — that
split decides whether 2.5 banks per-class ceilings or one total.
Correction to §11 2.3's prose carried here: "four named soundness
peers live at that boundary" is not groundable as a counted four in
this catalog — the boundary's actual kin are Phase 1's sig-keep
publish, `Hβ.lower.multishot-anonymous-install`,
`Hβ.lower.partial-via-lambda-recipe`, and the fmt lambda render arm;
kin, not a counted four.

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
EDGE GOES TOTAL-DIRECTIONAL — ✅ LANDED 2026-08-07 (pin 2a09f3c22a4f,
TRANSITION at census 0; movers 691 → 686; the mixed-shape census
marker measured ZERO on both legs exactly as stamped; the armed
duplicate-name class caught the build shadowing effects.mn's real
bind_edges_to live). Cap-form params keep landed subsumption; the
pure-flow shape masks and binds one-way; the arg's shared cell is
never written; the 297-site flow survives as a read. B3 THE UNION FLIPS
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
