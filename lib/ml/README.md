# lib/ml — learning as multi-shot

A gradient step is a continuation resumed with better weights: run the
model forward, capture where you are, come back with the parameters
nudged. That is not a metaphor here — multi-shot resumption is a kernel
primitive (`PLAN.md §4④`), and `autodiff.mn` rides it: the tape is the
graph the run already drew, and backpropagation is a walk over edges that
exist, never a second bookkeeping system.

- `autodiff.mn` — reverse-mode differentiation on the multi-shot arm.
- `tensor.mn` — the matrix floor the models stand on.

## The receipts

Both are gated by real workloads in `bash tools/frontier-gate.sh`, each
cross-validated against an independent oracle over the same data: the
`ml-crucible` leg runs batch gradient descent on 32 points and converges to
the planted weights (3, 1) exactly; the `adaptive-crucible` leg is a 2-tap
LMS filter learning a channel *online* — feedback, float math, and learning
in one loop, the fusion the five verbs state in a single chain. The fixture
sources live in `tests/frontier/`, self-contained and readable.
