# The 20-minute loop prompt (`claude -p "$(cat tools/loop-prompt.md)"` from the repo root)

You are resuming Mentl development cold, on a timed loop. The three docs are
loaded; they govern. Work INLINE and alone — no agent dispatch, no plan mode,
no new arcs, no re-litigating decided designs. Follow these eight steps in
order; end early at any step that says so.

**0 · CONCURRENCY GATE.** `bash tools/heavy-lock.sh acquire`. If it refuses
(lease held or MemAvailable below the floor), this is a LIGHT session: you may
triage, design-stamp, and true prose, but you must not start any
compile/march/battery/gate run. If no bankable paper work exists, end with the
one-line report "light session — lock held/low-mem; nothing banked." Renew the
lease (`touch`) before any march; `release` before ending, always.

**1 · GROUND.** `bash tools/state.sh --quick` and `git status`. doc-truth must
hold (boot sha == PROVENANCE head). Then read the work selectors — PLAN §7's
head entry, the live rung ladder it points to, and the memory cursor. These
plus §11 are the ONLY sources of what to do next. Nothing else is in scope.

**2 · TRIAGE BEFORE PROGRESS.** If any gate is red, the tree is mid-landing,
or the previous session ended dirty: forward-fix under the stack-correct-fixes
law, or restore the last blessed pin when the artifact refutes the work — an
era bracket (git-extracted boots × fixed inputs) arbitrates, never memory or
adjacency. A red board admits NO new feature work. Fixing the board IS this
session's work if it is red.

**3 · THE NEXT STEP IS ALREADY NAMED.** Take the smallest next marched step of
the current rung, in ladder order. Before building, verify the step's design
stamp: semantics TRACED, costs PRICED under §5.O (freshness of every read
included — the B1 revert's payment), writers ENUMERATED. A
missing or stale stamp means this session's entire output is the stamp —
produce it, bank it in the design's one home, and stop. Never build unstamped.
Never touch condemned machinery except through its arbitrating oracles. Never
claim a design is complete — state its traced/priced/enumerated sets.

**4 · BUILD DISCIPLINE.** Source edits through the Edit tool only. The
mentl-first perimeter stands: the medium's projections before shell reads;
`# mentl-skip: <reason>` confessions only for artifact/git operations, each
naming the missing projection. Every new capability lands with its gate seen
RED first. Ratchets move only DOWN; raising any ceiling requires a fixed-input
probe recorded in the baseline comment. Never write a sha, digest, or count
you did not read from the artifact this turn.

**5 · VERDICT.** The march arbitrates every landing (`MARCH_REPIN=1
bash tools/march.sh`, battery-gated). CLEAN and TRANSITION follow the law;
BROKEN means stop, diagnose by probe, fix or revert — never bless around it.
A pin is not blessed until the §7 ledger entry and the PROVENANCE narrative
are written in the same session.

**6 · BANK AND STOP.** One rung-step maximum per session. Before ending:
PLAN §7 and the memory cursor carry the exact state a cold session needs; the
tree is left marchable; the lease is released. Commits and pushes wait for
Morgan's explicit word — always, no exceptions.

**7 · REPORT.** First sentence: what changed and the measured result — or
"not done" first if not done. Traced/priced/enumerated language only; no
completeness claims, no time estimates. Shortest report that carries the
result and the named next step.
