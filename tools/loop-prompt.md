# The arc loop prompt

One home, two harnesses: `/loop Read tools/loop-prompt.md whole and execute
one iteration of it exactly` (self-paced, same session) or
`claude -p "$(cat tools/loop-prompt.md)"` (cold, timed). Either way each
iteration is ONE marched step of the arc. The three docs govern; work INLINE
and alone — no agent dispatch, no plan mode, no new arcs, no re-litigating
decided designs. Follow the eight steps in order; end the iteration early at
any step that says so.

**0 · CONCURRENCY GATE.** `bash tools/heavy-lock.sh acquire`. If it refuses
(lease held or MemAvailable below the floor), this is a LIGHT iteration: you
may triage, design-stamp, and true prose, but you must not start any
compile/march/battery/gate run. If no bankable paper work exists, end with the
one-line report "light iteration — lock held/low-mem; nothing banked." Renew
the lease (`touch`) before any march; `release` before ending, always.

**1 · GROUND.** `bash tools/state.sh --quick` and `git status`. doc-truth must
hold (boot sha == PROVENANCE head). THE WORK SELECTOR IS PLAN §11 — its
STANDING CURSOR block first, then the phase order's first unlanded item.
§7's head and RESIDUE's banked entries for the chosen item are its context. Nothing else is in scope; an item excluded by
hardware (§11's exclusion list) is skipped, not attempted.

**2 · TRIAGE BEFORE PROGRESS.** If any gate is red, the tree is mid-landing,
or the previous iteration ended dirty: forward-fix under the
stack-correct-fixes law, or restore the last blessed pin when the artifact
refutes the work — an era bracket (git-extracted boots × fixed inputs)
arbitrates, never memory or adjacency. An OLD gate red after a correct fix
may be a banked expectation that canonized the bug — re-derive the truth by
hand before re-banking (§9.11). A red board admits NO new work; fixing
the board IS the iteration if it is red.

**3 · THE NEXT STEP IS ALREADY NAMED.** Take the smallest next marched step of
the arc's current item. If RESIDUE banks a NAMED NEXT PROBE for it, the probe
runs FIRST and decides what gets built — never build ahead of a banked probe.
Before building, verify the step's design stamp: semantics TRACED, costs
PRICED under §5.O (freshness of every read included), writers ENUMERATED. A
missing or stale stamp means the iteration's entire output is the stamp —
produce it, bank it in the design's one home, and stop. Never build unstamped.
Never touch condemned machinery except through its arbitrating oracles. Never
claim a design complete — state its traced/priced/enumerated sets. A genuine
design fork the three docs do not answer is Morgan's: bank the fork with both
branches priced, surface it in the report, and take the arc's next
INDEPENDENT item — the loop never stalls on a question and never answers one
above its station.

**4 · BUILD DISCIPLINE.** Source edits through the Edit tool only. The
mentl-first perimeter stands: the medium's projections before shell reads;
`# mentl-skip: <reason>` confessions only for artifact/git operations, each
naming the missing projection. Every new capability lands with its gate seen
RED first. Ratchets move only DOWN; raising any ceiling requires a
fixed-input justification recorded in the baseline comment, in the same
commit. Never write a sha, digest, or count you did not read from the
artifact this turn. THE GENERATION LAG: an EMIT change reaches the running
compiler one generation later — its effect is verified through m3, never
through the m2 the old boot emitted. Semantics of the one structural `==`
(and any equally load-bearing leaf the wheel's own inference rides) change
only under march arbitration.

**5 · VERDICT.** The march arbitrates every landing (`MARCH_REPIN=1
bash tools/march.sh`, battery-gated). CLEAN and TRANSITION follow the law.
BROKEN means the experiment REVERTS WHOLE — bank the refuted hypothesis and
its kills in RESIDUE with the named next probe, and land the proven-good
subset only; never bless around a broken verdict, never leave dead machinery.
Gates that read the PINNED BOOT (the frontier's boot suite) run AFTER the
repin, or they measure the old pin. A pin is not blessed until the
PROVENANCE narrative and the LEDGER head entry are written — doc-truth
refuses the placeholder, by design, so write them before verify.

**6 · LAND.** One marched step per iteration. At a FULL-GREEN board — verify,
march, crown, frontier (--compiler fresh when the wheel changed), census,
doc-truth, every ratchet within its baseline — COMMIT, with the docs' true-up (§7 / §11 / RESIDUE / LEDGER /
PROVENANCE) in the same commit or an immediately following docs commit; the
pre-commit gate is the second arbiter and its refusal is final. Anything
short of full green lands nothing: bank the state, leave the tree marchable,
release the lease. Pushes and anything leaving the machine wait for Morgan's
explicit word — always, no exceptions.

**7 · REPORT.** First sentence: what changed and the measured result — or
"not done" first if not done. Traced/priced/enumerated language only; no
completeness claims, no time estimates. Name the arc's next item. Shortest
report that carries the result and the next step; any banked fork for Morgan
is its last line, phrased as the one decision it is.
