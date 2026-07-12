# The general multi-shot — k2/k3 design (the rulings)

Synthesized 2026-07-11 from an 8-scout adversarial pass (6 mechanics readers +
a project-edges sweep + a first-principles challenger told to refute the
frame), inline. k1 is the base (commit 1746a87: LYield, the reified k with the
closure-identical head, the install driver, resume = k-call; fixpoint held).
Every ruling below names its decisive artifact fact. Two refuters attack this
document before a byte lands.

## The thesis

The general multi-shot is the k1 mechanism closed under three things: frames
(a yield crosses intermediate calls by composing their remainders onto k),
payloads (op args ride the unwind; arm state commits across resumes), and
naming (the classifier sees resumes through calls and recursion, and k reaches
them as evidence). No new semantics anywhere — the same yield, the same
record, the same driver; k2/k3 remove the floors k1 refused loudly. The
challenger's frame-level verdict stands: yield-bubbling IS the correct
WASM-substrate projection of the one semantics; its strongest amendment
(k-as-evidence) is adopted; its composer amendment (the next-frame chain) is
refuted below on immutability grounds while its conceptual point survives —
the composed records ARE NATIVE.md keystone-1's captured segment as image
records, realized at the record layer.

## Ruling 1 — the composer: one generic self-re-composing `$__k_compose`

Two scouts disagreed. The chain form (a `next` slot in the k tail + a
`$cont_apply` walker) loses on three artifact facts: its re-yield splice
mutates a record post-mint (breaks immutability-by-construction — the ONLY
write anywhere in the k design is at mint); it introduces a second calling
convention beside W7 (every consumer must know chain-vs-single); and the
deep-handler re-wrap cannot express itself locally. The composer form wins:

    $__k_compose(__state, v):
      r = inner(v)                      ;; W7 call via captures[0]
      if $yield_flag:                   ;; inner suspended deeper
        $yield_k := mint [composer_idx, 2, [$yield_k, captures[1]], sentinel, tail]
        return dummy                    ;; flag + op UNTOUCHED — propagate
      return frame_k(r)                 ;; W7 tail call via captures[1]

The flag-check between the two calls IS the k2 bubble, expressed once, closed
under arbitrary re-yield depth (the chain rebuilds itself lazily, one fresh
record per crossed suspension — never a mutation). `return frame_k(r)` emits
as return_call_indirect: the walk is constant-stack, matching the chain's one
genuine advantage. Sibling `$__k_extend(frame_k)`: reads $yield_k, mints the
compose record, sets $yield_k — the one operation every bubble site performs.

Emission: the runtime-contract tier (fixed fns, not per-sig synthesis), gated
on the existing yield_seen projection. THE ONE NEW PLUMBING SEAM: the composer
is called INDIRECT via fn_ptr@0, so unlike every synthesized helper it must
enter the funcref table + get $__k_compose_idx — add to all_fn_names when
yield_seen > 0. Width: the composer ft is pinned word-uniform (i32,i32)→i32;
a non-i32-result frame k is a LOUD floor (`Hβ.emit.compose-width-floor`, the
callsite-result-width family) — never a silent truncation.

## Ruling 2 — the k channel: the arm param stays Tier-1; keyed evidence is the general tier

The acid facts decide it: a called-fn resume has NO channel today
(E_ResumeOutsideArm at infer.mn:734, then RECOVERED to a plain LReturn —
yield_inhabitants' two sites are 2 live diagnostics on every wheel compile,
and its resume IS "early-return v": a silent reinterpretation that runs only
because the chain is tail-resumptive by accident). backtrack's resume sits two
closure boundaries deep (a lambda inside a nested fn inside the arm). The __k
param cannot cross those; a k slot in the install record breaks N-way
reentrancy (nested installs of one handler clobber one slot).

The ruling — the challenger's amendment, adopted: **resume is a perform
against the nearest enclosing arm, and k is its EVIDENCE.** One op-agnostic
key `"__resume"` (delimited-continuation semantics: the nearest prompt). The
MultiShot arm is the one WRITER: at its interior effectful call sites the
sst_ clone appends [key="__resume"][ev=__k]; lambdas capture it like any
evidence; a resume in any context resolves it through the SAME keyed scan
every perform uses, then W7-calls it. The dispatch gradient at the resume
site mirrors the perform's exactly: lexical tier = the arm's __k param (zero
scans, the k1 fast path, KEPT); evidence tier = the "__resume" entry (the
general path). The proof becomes the dispatch, at the resume site.

This makes handler = state = closure = evidence = CONTINUATION literal (the k
record IS an evidence value with zero representation change) and is the first
consumer of the modal capability-at-tee rule (§4③): a resume capability,
lexically granted by the arm, threaded as evidence. Law-7 gating: the arm is
the only writer and no wheel arm is MultiShot pre-cut → zero entries → bytes
identical. The row-side mark (contains-resume fns gain the capability so
derive_ev_slots threads the entry through intermediate calls) lands AT THE
CUT, in the same commit as the classifier completion — pre-cut it would
change yield_inhabitants' row and thus wheel bytes.

## Ruling 3 — args: the 4th global `$yield_args` → a heap args record, arity > 0 only

The lifetimes differ and that settles it: k is durable (immutable, called N
times, the persist=memcpy object, composed onto); args are transient
(consumed once by the matching driver dispatch inside the same unwind).
Args-in-the-k-tail displaces world_tag from its documented record_end-4
position (the one Persist reader) and persists dead words; a unified packet
allocs per yield on the argless hot path (the bump-image churn class, PLAN §7
face-7). The 4th global is strictly additive: argless yields byte-identical,
the flag check stays one global.get, the driver (which reads the handler decl
live — multishot_ops_of — and therefore knows each op's arity) reads args at
fixed offsets and pushes (record, k, arg0..argN-1); the arm signature already
composes (params = ["__k"] ++ arm.args since k1). LYield gains the args list:
ONE lockstep edit across all ~16 destructure sites (the TCont precedent —
never a walker wildcard swallowing the new operand).

## Ruling 4 — state: sequential commit against the one install record

Confirmed as banked, now with the exact form: the arm's __state IS the install
record (the driver pushes it; LStateSlotStore writes through it — zero new
emit). The commit prefix of lower_resume_snapshot (val snapshot + update lets
+ stores) factors into one builder shared by both disciplines; only the tail
differs (LReturn vs the k-call block). Two laws carried: commit BEFORE k(v)
(the resumed remainder re-enters against committed state), and k(v) takes the
SNAPSHOTTED val local, never a re-lower after the stores (the ev8d 58-not-57
snapshot race). Per-branch isolation is the AUTHOR's trail bracket (backtrack
already writes checkpoint/rollback in source) — the mechanism never imposes
it; the ~> Schedule/trail peer stays named.

## Ruling 5 — the k2 call-boundary check

The insertion point: immediately after the non-tail LSuspend call_indirect —
park the result in a WIDTH-HONEST local (read the callee result repr the way
call_ft_name already does; bare-i32 sst_ style would truncate f64 fast paths),
check the flag: set → `$__k_extend(frame_k)` + re-yield the FRAME's
width-honest dummy, PRESERVING $yield_op (the compose swaps only $yield_k —
the "" op-clobber pattern in the k1 trap is retired with it); clear → reload
the parked result. The shape is lower_resume_callk's block generalized —
built at LOWER so LSuspend's 6-field arity never changes (the tail-field
19-site precedent). TAIL calls need nothing: a tail frame's remainder is the
identity — composition skips by construction, return_call transfers to the
caller's caller whose own check (or driver, or backstop) sees the flag. The
invariant: EVERY non-tail can-yield call site carries the check, else a frame
computes on the dummy.

The gate predicate, all existing reads: can_yield(fh) = any ename in
evidence_effects_of(fh) has any op with op_resume_discipline == MultiShot —
the call-side twin of multishot_ops_of; the two deciders sit adjacent. A
MultiShot effect fully handled INSIDE the callee subtracts out via
escaping_row (its own driver mines it) — the gate goes quiet. Pre-cut the
predicate is false wheel-wide (no op grades MultiShot) → byte-identity.

The frame split generalizes k1's verbatim: k1_remainder is already
hole-generic (hole = the node whose handle == ph); a k2 spine call is the
same split with ph = the call node. The one structural difference: a k2 spine
call usually returns NORMALLY, so the remainder has dual residency — inline
on the fast path, reified only on the yield path (the check block holds both).

Inside a REIFIED remainder (a k fn), performs prefer the EVIDENCE tier over
the singleton tier for effects present in the k's own ev region — the k
carries that evidence precisely because $<hname>_state_g may have been
restored by the unwind (the edges scout's install-boundary hazard). The
residual (a singleton-only dispatch inside a resumed segment whose install
unwound) is a named loud floor for the refuters to arbitrate:
`Hβ.lower.kfn-singleton-after-unwind`.

## Ruling 6 — the classifier completion (the cut)

The pass: per-fn summaries g(f) = resume_grade with call-substitution
(CallExpr whose callee has a summary contributes g(callee), not UZero), run as
a monotone fixpoint over the 3-point Usage lattice — recursion saturates to
UMany by round 2, no cycle detection (the compute_escaping_rows shape, lifted
to infer). Hand-verified by the scout on both wheel targets: yield_inhabitants
→ UMany (round 2), backtrack's try_each → UMany (round 2). It runs at
infer_program between pre_register_decls and infer_stmt_list — purely
syntactic, and it builds its own name→body map from the stmts list directly
(NO FnScheme change, zero env blast radius; draw_op_edges reads the summaries).
Scope: FnScheme callees only — a perform's op is another op's business.
Over-approximation direction is sound: errors go UMany → correct-but-heavier,
never OneShot-for-multi.

THE CUT IS ONE COMMIT and it is the TRANSITION: the fixpoint pass + the
resume-capability row mark + both acid handlers flip + march arbitrates
m2 != m3 with m3 == m4 + battery THROUGH m3 + boot re-pin from m3 + the IDE
re-pack. Either-negotiation ruling for the cut: accept UNIFORM op-level disc
(pick_first ships in the k form — semantically correct, one resume through k;
its UZero abort arm needs the uzero semantics regardless);
`Hβ.lower.either-install-negotiation` gets its code anchor
(multishot_ops_of + lower_one_arm_decl keying on the joined scheme) and stays
the named restore-the-light-form follow-up.

UZero-abort co-lands at the cut (band N's `Hβ.lower.multishot-uzero-abort`,
backtrack feature [6]): an arm that never resumes its op must deliver its
value as the INSTALL's value abandoning the continuation — under the driver
this is exactly "don't call k, return" (the driver parks the arm return and
loops; flag clear → it IS the install value) — the k model gets this right by
construction where the tail-resumptive convention couldn't; the crucible
proves it.

## The sequence (amended by the transition refuter, 2026-07-11)

- **M1 — mechanism (fixpoint HELD, gated commits):** the composer pair
  (table-resident; and name the FT SEAM — the composer's
  `call_indirect (type $ft_...)` needs the 2-arg ft interned, which a
  yielding module with only UZero arms may lack: intern it alongside the
  table entry when yield_seen > 0, or the miss is a loud assembly error) ·
  the k2 check + dual-residency split — at ALL THREE LSuspend mint sites
  (lower_call_default:720, the pipe completion :1899, the pipe splice
  :1884) · LYield args arity (ONE lockstep edit — 18 sites censused: decl,
  4 mints, 13 walkers) + $yield_args + the driver args push + LIFT
  ms_op_of_call's `len(args) == 0` gate (lower.mn:2867 — unlifted, every
  args-bearing perform still floors) · the state-commit tail — and the
  shared snapshot-prefix refactor is THE ONE M1 ITEM the m2==m3 ratchet
  cannot arbitrate (both generations run the same changed compiler): gate
  it with a CROSS-COMMIT m2.wat diff (the pre-commit m2cache artifact vs
  the rebuilt one — byte-empty on the OneShot path) · the resume-evidence
  lowering (dormant — no writer pre-cut) · evidence-first-in-k-fns.
- **M2 — the crucible ladder (fixpoint HELD).** Pre-cut-classifiable shapes
  (arms written with two sequential resumes wrapping the feature): mn-choice-args
  (args-bearing MultiShot → collect over a list) · mn-nested-choose (driver
  re-entry: the product of two choices) · mn-resume-in-lambda (backtrack's
  closure shape minus abort — resume_grade already walks lambda bodies) ·
  mn-arm-state-multishot (two resumes committing s across) · mn-uzero-abort
  (the abandon path) · mn-k2-frame (a non-tail intermediate CALL composing) ·
  mn-k2-pipe (a `|>` CHAIN crossing a yield — the pipe completion/splice
  LSuspend mints are distinct sites and the wheel's dominant idiom; the
  ladder had no pipe shape).
- **M3 — THE CUT (one commit, the named transition):** ruling 6 whole, PLUS
  the two crucibles only the cut can classify: mn-resume-in-called-fn
  (yield_inhabitants' shape) and **mn-backtrack-full** — the COMPLETE acid
  shape (resume in a lambda passed as a config-fn arg + an arm-internal
  `~> catch_abort` install + recursion + trail bracket). This one is
  load-bearing: backtrack is DEAD CODE in the wheel (zero choose
  performs/installs anywhere), so the wheel fixpoint + battery prove
  NOTHING about it post-cut — and its shape sits exactly on the two
  PLAN-named open floors (`Hβ.lower.arm-internal-perform-scope`,
  `Hβ.lower.config-fn-evidence-in-arm`). The cut is not done until
  mn-backtrack-full is green; "flipped but unproven" is the drift.

## The semantics refuter's amendments (2026-07-11 — four holes, each ruled)

The refuter hand-traced backtrack and enumerate_inhabitants against the
rulings and measured through a fresh HEAD m2 (mn-multishot=30 reconfirmed;
the `$__k`-across-closure floor verified as a loud assembly refusal). Rulings
1 and 3 stand whole (composer N-calls immutability confirmed; nesting order
correct). The holes and the corrected rulings:

**A1 — the can_yield gate goes PROVE-ABSENCE.** The per-effect-name row read
is structurally blind at param-closure boundaries: `try_fn()` inside
try_with_abort_catch has a free row var at its one lowering →
effects_of_row = [] → gate false forever → the inner yield's dummy reaches
twac's match. No row read can see a yield arriving through a k-call hidden
behind a param closure. The corrected gate is the project's own stance
applied to itself: **check UNLESS the row PROVES absence** — a closed row
with no MultiShot-classified op skips; a free/open row checks. Pre-cut no
MultiShot op exists, so the gate is false everywhere (Law 7 held); post-cut
every unproven call site carries the one-global.get check. Proving the
negative, at the gate.

**A2 — evidence-first-in-k-fns is DELETED (it inverted the discrimination).**
The correct resolution for ESCAPING effects is the RESUME-time dynamic
context: backtrack's abort must hit the catch_abort installed at the resume
site (try_each's fresh install), and the escaping row is exactly the set
whose resolution must be dynamic — while effects handled INSIDE the segment
subtract out and never reach the k's ev region. The rule covered precisely
the wrong set. `Hβ.lower.kfn-singleton-after-unwind` is ARBITRATED DYNAMIC:
singleton/live-stack resolution stands inside resumed segments; the k's ev
region remains what k1 made it (the remainder's own Tier-2 evidence).

**A3 — the capability marks CLOSURES too, and lives in the EVIDENCE layer,
never the row.** The "__resume" entry had no writer on the
arm→nested-fn→lambda chain (a let-bound closure is W7-called, not
sst_-cloned; its evidence comes from LMakeClosure capture driven by its row
— and nothing marked it). And a row-borne capability would violate
yield_inhabitants' closed declared row (`with Synth + ... + !Mutate`) at
subsumption — E_EffectMismatch at the cut. The corrected ruling: the
classifier pass's output is a CAPABILITY MARK — top-level fns whose summary
has a reachable resume, AND closures whose bodies contain a resume or call a
marked name — read by derive_ev_slots alongside the row (the evidence layer
extended; the type row untouched; the modal-sort form is the named
refinement). The same pass records WHICH ops' arms reach each marked fn:
single op → the resume types against it (R = the op's result, S = the arm's
result); multiple → the loud `E_ResumeAmbiguousOp`.

**A4 — the install-crossing remainder = RE-INSTALL-IN-K, stateless only.**
k1_remainder cannot put a hole inside an LHandleWith (the bracket/driver are
emit-level), and the unwind already ran the unconditional state_g restore.
The corrected mechanism: the split at an install-body call site constructs a
frame_k whose body is a FRESH LHandleWith re-establishing the install around
the hole — correct for STATELESS intermediate handlers (catch_abort — the
delimited-capture semantics: handlers between the perform and the prompt are
part of the segment and re-establish on resume); a STATEFUL intermediate
install would reset mid-flight state → the loud floor
`Hβ.lower.stateful-install-crossing-yield`.

**Ruling 4 corrections (state):** the mechanics stand (sequential commit;
the second resume sees the first's committed state) but for the right
reason — arm state reads are LIVE loads through the install record on every
reference (never install-time copies; now documented). And "per-branch
isolation is the author's trail bracket" is STRUCK: LStateSlotStore is a raw
store outside the graph trail — graph_rollback cannot revert handler state.
backtrack is unaffected (zero state fields; its `with` is a row), and the
isolation peer is named: `Hβ.lower.branch-isolated-handler-state`.

**The world ruling is corrected (was unsound):** a composed k's world is the
JOIN of every composed frame's row — a head-only tag ADMITS resumes the gate
must refuse, and FNV tags cannot union. The sound representation (the row
carried in the k tail, joined at compose, the tag re-interned) rides the
Persist/value-gate band; the gate never ships reading head-only tags.

**The Option protocol (twac's Some/None):** a PRE-EXISTING untyped seam —
the backtrack shape adds +14 E_UnresolvedType today, zero type errors, and
try_with_abort_catch's author-level None-means-aborted protocol is what
makes backtrack work under today's abort convention (abort's UZero arm
returns None to the perform site; the shape is built around it). The cut
inherits, ratcheted by the crucible; the deep fix is a handler RETURN
CLAUSE — the named SYNTAX peer `Hβ.syntax.handler-return-clause`. Band N's
uzero-abandon peer stays for the general case; mn-uzero-through-frames
measures the blast radius before any UZero-flip is sequenced.

**The ladder gains the refuter's six:** mn-resume-across-install (THE acid
distillation — a MultiShot resume k-call inside a `~>` install body inside
the arm, inner re-yield crossing the boundary) · mn-dynamic-abort-in-k (the
A2 arbitration gate) · mn-uzero-through-frames · mn-called-fn-resume-typed
(the closed-declared-row + R→S gate) · mn-option-protocol (ratchets the +14)
· mn-composed-world-gate (band B, with the value gate).

## Named afters (positive form, sequenced)

`~> Persist` on k records (world_tag per captured SEGMENT — the head's, not
per frame) · the SPACE fork (k records through `~> Schedule`) · the
E_ResumeWorldMismatch value gate reading world_tag at resume ·
autodiff-as-multishot · IDE fill-and-resume via the producer-carrying re-pin ·
per-install Either negotiation · f64 composer variants
(`Hβ.emit.compose-width-floor`) · `Hβ.lower.kfn-singleton-after-unwind` ·
the persist-layer truncation the edges sweep flagged (verify at build).

## M2 amendment (2026-07-12 — the nested-choose refutation pass, landed form)

Two refuters (semantics + mechanics) attacked the M2 nested-choose
mechanism before a byte landed. Three corrections to THIS document's own
text, each with its decisive fact:

**The "driver re-entry" sketch in the M2 ladder line is WRONG — struck.**
"mn-nested-choose (driver re-entry: the product of two choices)" as
sketched — the arm returns dummy flag-up and the DRIVER dispatches
arm(k2) — ABANDONS the outer arm (its remaining resumes and its
combination never run): pick()+pick()*10 under twice computes 32 where
the deep-handler answer (independently derived: install = the prompt;
deep k(v) = handle(E[v])) is 66. The correct mechanism is the OWNED-OP
RE-DISPATCH AT THE RESUME BOUNDARY: the resume's post-call flag check,
on an op THIS handler owns, re-enters the handler's own dispatch and
uses the dispatched arm's return as the resume's value — the deep
equation handle(E[perform]) = arm(k = λv. handle(E[v])) verbatim. Landed
as $op___redrive_<hname>: the install driver's loop factored to ONE
dispatch home, called by the install bracket AND every MultiShot arm's
resume flag-arm; a FOREIGN op exits with $yield_flag INTACT (the flag
global is the second return channel — no mode flag): the bracket
bubbles, the resume floors loudly.

**Ruling 5 gains the resume carve-out.** "EVERY non-tail can-yield call
carries the check" does NOT sweep the resume k-call in: composing the
frame remainder there would splice ARM code into the delimited segment
(the arm runs at the prompt's edge, above the captured segment). The
resume boundary's own protocol is the redrive (owned) + the loud floor
(foreign — arm-remainder composition has no sound form).

**Ruling 1's "existing capture recipe" claim was FALSE for nesting — the
hole-SET reifier replaces it.** collect_free_vars walks the AST, where a
hole position is still the perform call (its only free name is the op,
RGlobal-fenced), so an outer hole's name never enters a nested k's free
set; and a shared "__resume_in" param SHADOWED every ancestor hole
(LLocal emits by name) — the naive build silently computes the DIAGONAL
substitution, and every AFFINE body is blind to it (correct and diagonal
totals agree at any depth — the refuter's theorem; gates must be
MULTIPLICATIVE). Landed: per-site hole names (__resume_in_<ph>), a
substitution ENVIRONMENT through k_remainder ([(ph, read)] — hole reads
resolved INSIDE the entered frame, enclosing hole names seeded into the
free set explicitly), recursive reification, and the DEADENER (every
spine perform beyond the substituted yield is dead in that residency — a
MultiShot perform always yields — and lowers as a dummy word, never an
inline floor: the depth-3 gate's lesson). The landed gates:
mn-nested-choose = pick()*pick() = 9 (the diagonal computes 10),
mn-nested-depth3 = 27 (the two-outer-hole environment),
mn-nested-state = 51 (interleaved arm invocations against the one
install record — live loads, commit-before-k).
