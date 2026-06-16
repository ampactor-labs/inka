# Polymorphism as Flow Edges
## The inference graph as its own substitution — dissolving generalize / instantiate / subst

> **Status:** design draft (dream code; verified by simulation + walkthrough + the
> higher-order-effect micro ladder, not by compilation). Opened 2026-06-15 when the
> L1 higher-order-effect trap bisected to a *class*: a polymorphic relationship the
> graph should carry as a live edge, re-derived instead as copied free variables
> that lose their link. **Hardened 2026-06-16** by four refuted attempts to patch the
> relationship in place (§1.5) — each carried-truth-*correct* yet each regressing 200+
> unrelated sites or no-op'ing. That experiment is the proof that this is a
> **representation replacement behind a seam (§8 Step 0)**, not an algorithm patch.
> This doc designs the ultimate form of that relationship and every subsystem it touches.

---

## §0 · The one-paragraph thesis

Mentl's kernel primitive is **Graph + Env, HM live with Reasons**. Today,
polymorphism is *not* that primitive — it's a classical Hindley–Milner *algorithm*
(generalize a scheme's free variables → instantiate a fresh copy per use → substitute)
layered **on top of** the graph. That algorithm is an imperative subsystem with
parallel bookkeeping — the free-var list, the quantifier set, the substitution map,
the handler residual accumulator — that shadows the graph and drifts out of sync
with it. Every drift is one bug: a polymorphic relationship the graph should carry
as a **live edge**, re-derived instead as copied variables that lose their link.
The ultimate form deletes the algorithm. A polymorphic relationship is a **flow
edge** in the graph (`this row/type flows from that one`), read live by the cursor
(= union-find `find`), with its Reason on the edge. `generalize`, `instantiate`,
`subst_ty`/`subst_row`, `free_in_ty`/`free_in_row`, the `r_handle` residual
accumulator, the dual `derive_ev_slots`/`compute_ev_index` re-derivation, and the
silent slot-0 fallback **all dissolve** into "draw the edge, read it live." Type-
polymorphism and effect-polymorphism become the *same* edge; refinement-flow and
ownership-flow ride the same structure; the Why Engine reads provenance off the
edges for free.

This is "HM live with Reasons" taken **literally** — the kernel primitive used
directly, instead of an HM algorithm reconstructed above it.

---

## §1 · Diagnosis — what the current machinery is, and the one bug it generates

### 1.1 The current pieces (all in `src/infer.mn` + `src/types.mn` + `src/effects.mn`)

| Piece | What it does | What it really is |
|---|---|---|
| `Scheme = Forall(quantified_handles, body_ty)` | a polymorphic binding | a **snapshot** of which graph nodes were free at generalize time |
| `generalize(handle)` | `Forall(free_in_ty(chase_deep(ty)), ty)` | re-collects the free vars into a parallel list |
| `free_in_ty` / `free_in_row` | walk the term, collect free handles | re-derives "what is polymorphic" from the term shape |
| `instantiate(scheme)` | `build_inst_mapping(qs)` mints fresh handles + `subst_ty` | **copies** the polytype per use so uses don't collide |
| `subst_ty` / `subst_row` | rewrite a term with a fresh-var mapping | a hand-rolled substitution — the graph *is* a substitution, ignored here |
| `HandlerKind(ename, r_handle)` | a handler's residual row | an **accumulator var** filled at decl time, before any install binds its config |
| `derive_ev_slots(callee)` (lower) | caller's evidence for the callee's row | re-derives the slot = sorted position in the row |
| `lower_compute_ev_index_for_effect` (lower) | callee's own slot for an effect | re-derives the *same* sorted position, independently |
| silent `clamp_index → 0` | when the effect isn't in the row | a **guess** masking an incomplete row |

Five of these are the same red flag: a fact the mint already proved (which nodes
are polymorphic, what the residual is, which slot an effect occupies) is **re-derived
or copied** downstream instead of **read live from the graph** ([[protocol_carried_truth_law]]).

### 1.2 The canonical instance — the higher-order-effect trap (empirically grounded 2026-06-16)

`use_each(xs) = map(lambda, xs)` under `~> env2_handler`. The clean truth table
(`tests/micros/mn-higher-order-effect*`, full prelude assembled in bash — see §1.5 on
the *tooling* that lied about this earlier):

| variant | handler state init | exit | `use_each_Env2` leak |
|---|---|---|---|
| `-two-op`, `-builtin-no-wrapper` (no wrapper) | — / `make_list` | **42 ✓** | 0 |
| `-wrapper`, `-multi-state`, `-builtin-state`, canonical (wrapper) | pure / `make_list` | **134** | 2 |

- **The wrapper is the discriminator, 1:1 with the leak** — and `make_list`/Memory is a
  red herring (`-builtin-no-wrapper` passes *with* `make_list`). The wrapper is real
  prelude code: `use_each(xs) = map(λ, xs)`; `map` *is* the wrapper.
- **The root is broader than the handler residual.** A *handler-free* repro reproduces
  the leak: `fn forward(g,v)=g(v); fn use_each(v)=forward(λ,v)` leaks `use_each_Env2`
  with no `~>`, no residual, no `make_list` — and still runs 42 (slot-0 coincidence,
  no shift). So it is not the `r_handle` accumulator specifically; it is **call-site
  effect-polymorphism itself**: the lambda's `{Env2}` does not flow through `forward`'s
  effect var into `use_each`'s row.
- **`use_each`'s row is *provably empty*** (instrumented the lower leak-site to dump the
  searched row names: **zero** names). The effect did not arrive *diminished* — it never
  arrived. `instantiate` mints `forward`'s shared effect var, `unify(λ, g)` binds it in
  the *param* position, and the *result-row* occurrence is left free; `project`'s
  row-fixpoint reads `NRowFree`, so `use_each`'s row is an empty open var.
- **The leak alone is survivable; the trap needs a slot shift.** With one effect, slot 0
  is coincidentally right (`-wrapper`/`-multi-state` leak yet pass). `-builtin-state`
  *traps* only because `make_list` adds a slot, moving Env2 off the lucky 0. So the
  silent `clamp_index → 0` fallback is what lets the leak masquerade as success.

So the bug is not the `make_list`, not the residual scope, not the wrapper alone — it
is that **call-site effect-polymorphism is structurally lossy (the shared row var is
copied, not flowed) and a guess masks it.** The graph should carry `caller.row ⊒
callee.row @φ` as a *live edge*; it carries disconnected copied vars instead.

### 1.5 The unpatchability theorem — why this is a representation replacement (empirical)

Four attempts to make this *one site* carried-truth-honest, each individually correct
under union-find reasoning, each gated against the wheel census (baseline **189**):

| Attempt | What it did | Result |
|---|---|---|
| find-before-bind at top of `unify_types` | chase both sides before dispatch | census **189 → 482**, leak unchanged |
| resolved-arg-types in `build_inferred_params` | resolve arg types before building `expected` | census **189 → 384**, leak unchanged |
| union-find chase in the `unify_types` TVar arm | mirror the handle-level `$unify` root-chase before `graph_bind` | census **189 → 465** *and* a **no-op** on the leak (the path is never taken for this bug) |
| (probe) instrument the TVar/TFun param path | observe which unify path the lambda takes | **zero** markers — the path I kept editing **never executes** |

**The lesson, paid for in census points:** the materialized HM's *correctness* depends,
non-locally and invisibly, on the exact copy/raw-bind behavior at hundreds of call
sites. You cannot make it carried-truth-honest one line at a time — every local "fix"
that reads the graph live where one site needs it **breaks 200–280 sites that silently
relied on the copy.** The coupling *is* the disease. Therefore the path is **not** to
patch `generalize`/`instantiate`/`subst`/`unify`; it is to **replace the polymorphism
representation behind a stable read-interface** (§8 Step 0) so the swap is local and
gated. This experiment is the empirical floor under the whole design: the dream code is
not an aesthetic preference, it is the only non-regressing route.

---

## §2 · The reframe — the graph already *is* the substitution

A type/effect inference graph already has nodes (`NFree`, `NBound(ty)`, `NRowFree`,
`NRowBound(row)`) and one edge kind: **equality** (`NBound` = "this node *is* that
type," the destructive union-find binding). The ultimate form adds two edge kinds
and one read:

### 2.1 Three edge kinds

1. **EqEdge** (existing) — `a ≡ b`. Undirected, destructive. Two nodes become one
   (union-find union). This is `unify`'s only tool today.
2. **FlowEdge** (new) — `a ⊒ b`. **Directed, non-destructive.** "`a`'s row/type
   *receives from* `b`'s." Drawing it does **not** bind `b`. It records that whatever
   `b` ends up being flows into `a`. This is polymorphism: a fn's row receives from
   its params' rows; a call's result receives from the callee.
3. **BlockEdge** (new) — `a ∖ E`. "`a`'s row has effect `E` *removed*." This is
   `~>` handling: the installing fn's row is its body's row **minus** the handled
   effect.

### 2.2 The one read — `project(N)`

Everything downstream (lowering's ev-layout, the row-subsumption check, the cursor's
Topology projection, the Why Engine) calls **one** function:

```
project_row(N) =
    own_effects(N)                                  // effects N performs directly
  ∪ flatten(map(project_row, flow_sources(N)))      // live-read every FlowEdge source
  ∖ blocks(N)                                       // every BlockEdge
  // cycle-honest: depth-bounded, memo per (N, frame) — the same discipline as chase_deep
```

`project_ty(N)` is the type analogue (FlowEdges for type positions are mostly
node-sharing, which the graph already does via handles — see §6.2). **`project` is
the cursor.** It is the only place "what effects does N have / what is N's type" is
answered, and it answers by *walking live edges*, never by reading a snapshotted
list. An effect cannot be "missed": if it is reachable along a FlowEdge, `project`
finds it; if it is not, it genuinely is not there (a loud, true answer — §3.6).

### 2.3 Instance frames — let-polymorphism without copying (the hard part)

The only reason classical HM *copies* (instantiate) is to keep two uses of a
polymorphic binding independent: `let id = λx.x in (id 1, id true)` must not force
`a := Int` to collide with `a := Bool`. The edge model keeps the binding **shared
(one node)** and makes each use a **frame**:

- A **generalization point** (a `let`/`fn` boundary) marks a node's free sub-nodes
  as **frame-open**: their binding is resolved *per reading frame*, not globally.
- A **use-site** opens an **InstanceFrame** `φ` (a fresh handle — the only thing
  minted, far cheaper than copying the whole type) and adds frame-local EqEdges as
  it unifies: `id`'s `a @φ₁ ≡ Int`, `a @φ₂ ≡ Bool`. The shared `a` node is never
  destructively bound.
- `project(N, φ)` resolves frame-open sub-nodes through `φ`'s edges; outside any
  frame they read as the principal (most-general) form.

This is the graphic-types / constraint-based reading of HM (Rémy–Yakobowski graphic
types; HM(X) constraint solving; Koka's scoped row labels for the effect side). It
is a real, studied, *more-elegant* basis — and it is exactly what "the graph is the
substitution" means: a substitution is a set of frame-scoped EqEdges, not a copied
term. **§6 + §10 carry the soundness/principal-types/decidability checkpoints to
verify by simulation before any of this lands.**

---

## §3 · The dissolutions — what deletes

| Deleted | Replaced by |
|---|---|
| `Scheme = Forall(qs, ty)` | the node itself + its FlowEdges; a "generalization point" flag marks frame-open sub-nodes. No quantifier list. |
| `generalize(handle)` | mark the binding a generalization point (O(1)); the polymorphic vars **are** the frame-open flow-sources, read live — never collected into a parallel list, so they can never be *miscollected* (the separate-vars bug cannot form). |
| `instantiate` / `build_inst_mapping` | open an InstanceFrame `φ` (mint one handle); add frame EqEdges during unify. No whole-type copy, no fresh-var-per-quantifier sweep. |
| `subst_ty` / `subst_row` | nothing — `project(N, φ)` reads the graph in-frame; the graph **is** the substitution. |
| `free_in_ty` / `free_in_row` | nothing — there is no free-var list to maintain. |
| `HandlerKind`'s `r_handle` accumulator | a FlowEdge `handler.row ⊒ config.row` drawn at the decl; read live at the install **after** the config is bound (so the var is never frozen pre-binding). |
| `derive_ev_slots` vs `compute_ev_index` (two derivations) | one `project_row(fn)` → one ordered ev-layout, **carried on the fn node**, read by caller and callee both. No "agree by shared sorted order" contract. |
| silent `clamp_index → 0` | impossible: a forwarded effect not in `project_row(fn)` is a hard `E_RowConservationLeak` (it already prints as a leak; now it is fatal, never a guess). |

Net: `src/infer.mn` loses its largest imperative subsystem; the kernel primitive
does the work.

---

## §4 · The operations, restated as edge-drawing

Each inference action becomes "draw the right edge"; reading is always `project`.

- **`let x = e` / `fn f(params) = body` (generalization point).** Mark `f`'s node a
  generalization point. Draw `FlowEdge: f.row ⊒ p.row` for each param `p` whose row
  is itself open (higher-order params), and `f.row ⊒ body.row`. No `generalize` call.

- **Use-site `f(args)` (instance + flow).** Open `φ`. Unify each arg against the
  corresponding param **in `φ`** (frame EqEdges, not global binding). Draw
  `FlowEdge: caller.row ⊒ f.row @φ`. `project_row(caller)` now transitively reaches
  every effect `f` performs *in this call's instantiation* — including, for
  `map(lambda)`, the lambda's `{Env2}`, because `lambda.row` flows to `f.row @φ`
  flows to `caller.row`. **The higher-order-effect bug cannot exist:** there is one
  edge, not two copied vars.

- **`perform op(args)` / bare op call.** Resolve the handler by walking the
  **handler-install stack** (graph edges up from this cursor position) to the nearest
  installer of `op`'s effect — that edge *is* the evidence (§7). Draw
  `FlowEdge: caller.row ⊒ {op's effect}` unless the installer is in *this* fn (then
  it is handled locally — a BlockEdge covers it).

- **`expr ~> h` (handler attach).** `project_row(result) = project_row(expr.body)`
  with `BlockEdge: ∖ handled(h)` **and** `FlowEdge: ⊒ h.residual`, where `h.residual`
  is itself a FlowEdge to `h`'s config params (§ register_handler). So
  `row(expr ~> h) = (row(expr) − E) ⊕ R` is two edges, read live — *not* an
  `absorb_row` over a snapshotted `r_handle`.

- **`register_handler(h)`** — infer the arms once (their rows are graph nodes). Draw
  `FlowEdge: h.row ⊒ arm_i.row` for each arm; an arm that calls config `f` already
  has `FlowEdge: arm.row ⊒ f.row` from the call rule. So `h.residual` = read
  `project_row(h)` live at each install. **No `r_handle` accumulator, no decl-time
  freeze, no scope-ordering hazard with state inits** (state inits' builtin effects
  are *their own* nodes, not folded into the residual flow).

- **`unify(a, b)`.** EqEdge as today (union-find). For rows, the open-tail trick is
  replaced by **FlowEdge subsumption**: `a ⊒ b` when a context must provide at least
  `b`'s effects. Equality of rows is mutual subsumption. Direction is explicit, so
  "caller provides extra effects" is first-class, not an open-var side effect.

---

## §5 · Everything it touches — each a peer upgrade to its own ultimate form

The user's law: *whatever the ultimate form interacts with is probably also due an
upgrade.* It is — and they are the same upgrade (read the graph live), so they
compose rather than fight.

1. **`src/types.mn` — `Scheme` / `SchemeKind`.** `Forall(qs, ty)` → a node +
   generalization-point flag. `HandlerKind(ename, r_handle)` → `HandlerKind(ename)`
   plus a FlowEdge (the residual is graph structure, not a kind payload). `TFun`'s
   `eff` field stays, but its open-tail var becomes a FlowEdge target. **Upgrade:** the
   type ADT stops carrying inference *bookkeeping*; it carries only *shape*.

2. **`src/effects.mn` — the Boolean row algebra (`+ − & ! Pure`).** `absorb_row`,
   `union_row`, `diff_row`, `normalize_row` become **edge constructors**: `⊕` = draw
   FlowEdge, `−` = draw BlockEdge, `&`/`!`/negation = read-time predicates over
   `project_row`. The algebra stops *materializing* rows and starts *describing
   flow*. **Upgrade:** `!Alloc`-style negation becomes "no Alloc reachable along any
   FlowEdge" — a graph reachability fact the Why Engine can *prove a path's absence*
   for.

3. **`src/lower.mn` + `backends/wasm.mn` — the ev-layout.** `derive_ev_slots`,
   `lower_compute_ev_index_for_effect`, `lower_ev_index_in_frame` collapse into one:
   the fn's ev-layout = the ordered `project_row(fn)`, **assigned once and carried on
   the fn node**, read by caller (to build the callee's evidence) and callee (to read
   its own slot) — the *same* fact, so no coercion table, no sorted-order contract.
   The earlier "carried ev-layout / handle-keyed evidence" big move (this session) is
   **this** — they were the same realization seen from the lowering end. **Upgrade:**
   the silent fallback dies; an incomplete flow-closure is a compile error, never a
   slot-0 guess.

4. **`src/graph.mn` — node + edge representation.** Add FlowEdge / BlockEdge / frame
   edges to the flat-array graph (a per-node adjacency slice; handles stay dense,
   O(1) chase preserved). `chase_handle` generalizes to `project` (chase along the
   typed edge set). **Upgrade:** the graph becomes a true typed multigraph — the
   substrate the cursor was always meant to read.

5. **`Reason` / the Why Engine.** Every FlowEdge/BlockEdge carries its **Reason** (the
   `~>`, the call, the param that drew it). "Why does `use_each` perform `Env2`?" is
   answered by walking the flow path: *lambda performs it → flows through `map`'s
   `f` → flows to `use_each`*. **Upgrade:** provenance is structural, not reconstructed;
   the Why Engine answers polymorphism questions natively.

6. **Refinement types (`src/verify.mn`).** A refinement on an argument **flows** to
   constrain the result (`fn abs(x) -> {v: v >= 0}` flows `x`'s refinement to `v`).
   Same FlowEdge structure, predicate-valued. **Upgrade:** refinement inference rides
   the polymorphism substrate instead of a separate pass.

7. **Ownership-as-effect (`src/own.mn`).** `Consume`/`!Alloc`/`!Mutate` are effects;
   ownership *flows* (a consumed value's linearity flows through the calls that move
   it). Same FlowEdge. **Upgrade:** the borrow check becomes a flow-reachability query
   (region inference, Stage 6, falls out — no separate borrow checker).

8. **The cursor / gradient (`src/cursor.mn`, `src/gradient_delta.mn`).** FlowEdges are
   exactly what the **Topology** and **Trace** tentacles project; the gradient can
   narrate "this effect flows from here" at the cursor. **Upgrade:** effect-poly
   becomes *visible and teachable*, not hidden in instantiate's copies.

9. **The query driver / cache (`src/mentl.mn`, `src/cache.mn`).** `instantiate`'s
   handler-swap (inference mints fresh; query renders display ids) generalizes: the
   InstanceFrame is the unit the query handler reads, so display/IDE projection of a
   polymorphic type is "read the node in a display frame" — one mechanism for
   inference and projection. **Upgrade:** the IDE shows the *shared* polytype with its
   uses as edges, not N disconnected copies.

10. **Decidability / occurs-check / cycles.** EqEdge keeps the occurs-check; FlowEdge
    cycles (mutual recursion, `f` flows to `g` flows to `f`) are read with the same
    depth-bound + memo `project` already needs (cycle-honest). **Upgrade:** one cycle
    discipline for the whole graph, not per-pass.

11. **The seed mirror (`bootstrap/src/infer/*` + `lower/*`).** Every wheel change
    mirrors; the seed's `scheme.wat` (generalize/instantiate/subst) shrinks the same
    way. Byte-parity gate as always.

---

## §6 · Let-polymorphism without copying — the part that must be proven, not asserted

This is the load-bearing risk. The design must preserve **principal types** and
**decidable, sound inference**. The honest claims and their checkpoints:

### 6.1 Independence of uses
Frame EqEdges (`a @φ₁`, `a @φ₂`) must not leak across frames. Checkpoint: a use that
binds `a @φ₁ ≡ Int` must leave `a` principal for `φ₂`. Simulate `let id = λx.x in (id 1, id true)` and the higher-order ladder; `project` in each frame must give the
per-use answer.

### 6.2 Type-poly vs effect-poly
For **types**, "flow" is mostly node-sharing the graph already does (the two `a`s in
`a→a` are one handle); the win there is deleting the copy-and-subst wrapper, not a new
edge. For **rows**, flow is genuine subsumption (⊒) — the new structure. Keep these
distinct in the design so the type side stays the proven HM core and only the row
side gains the subsumption edge. (Mirrors Koka: row-polymorphism is the novel part;
value polymorphism is standard HM.)

### 6.3 Value restriction / generalization soundness
Generalization points must respect the value restriction (don't generalize through a
mutable/effectful binding unsoundly). The graph already carries effect rows, so the
generalization-point flag is *conditioned on* `project_row(binding) = Pure` — a graph
read, cleaner than the syntactic value restriction. Checkpoint: simulate an effectful
`let` that must **not** generalize.

### 6.4 Termination
`project` with depth-bound + per-`(N, frame)` memo terminates on cyclic graphs.
Checkpoint: mutual-recursion + recursive effect rows (`iterate_from` calling itself).

---

## §7 · The dispatch gradient falls out

With the install stack as graph edges, "which handler provides this op's evidence at
this cursor position" is a **graph walk**, and the runtime realization is a gradient
(this session's [[protocol_dispatch_gradient]]):

- **Statically reachable** (the FlowEdge resolves to a handler installed *in this fn*,
  lexically) → emit a **direct call** to the arm. No evidence threading. (~85% —
  tail-resumptive static handlers.)
- **Crosses a fn boundary** (the resolving install is in a caller) → emit a
  **handle-keyed evidence pass**: the carried ev-layout slot, read from the *same*
  `project_row` both sides use.

The "two tiers" (`LPerform` lexical / `LEvPerform` evidence) stop being two
hand-maintained code paths that must agree — they are two readings of one flow graph
at two gradient positions.

**The floor itself is a backend handler choice (Anchor 5), not a kernel law.** The
kernel carries the *resolved-handler identity* as graph truth — a FlowEdge from the
perform to its installer — **decoupled from the type-row**, so a type-row imperfection
can never again corrupt dispatch (the L1 trap's whole shape). How that identity is
realized for the dynamic residue is the backend's call: the **evidence-vector** the
seed already emits (kept for L1, so the seed is *not* rewritten), or a **dynamic-scope
stack** (a post-L1 backend option, maximally wrapper-transparent). Both are handlers on
the same graph fact; `lib/runtime/*` owns the floor; the kernel and wheel stay
floor-agnostic. This is the master plan's chosen paradigm — *flow-closure-driven
evidence interface, decoupled from the type-row* — which closes L1 **and** dissolves the
class **and** leaves the runtime floor swappable, never over-committing the kernel to
one dispatch mechanism.

---

## §8 · Incremental path — how to get here without a big-bang rewrite

Each step is gated by the higher-order-effect ladder (**leak → 0 across `-two-op`,
`-wrapper`, `-multi-state`, `-builtin-state`, `-builtin-no-wrapper`; `-builtin-state`
→ 42**) + the micro battery (byte-identical) + the census, both layers, wheel-first.

- **Step 0 — THE SEAM (the move every prior attempt skipped; §1.5 is why it is
  mandatory).** Introduce **one** projection that every consumer of "what is N's
  type / what effects does N have" routes through:

  ```
  effects_of(fn_or_node)   // the ONLY way to ask for a row, anywhere
  type_of(handle)          // the ONLY way to ask for a type, anywhere
  ```

  Today these *wrap the existing materialized HM verbatim* — `effects_of` = the
  current `lookup_row_for(scheme_body.row)`, `type_of` = the current `chase_deep`.
  **No behavior change; the census stays 189 exactly** (that census-unchanged is the
  gate that proves the seam is faithful). Route **every** caller through it: the call-
  site row read in `infer_call`, `generalize`'s free-var scan, lower's
  `derive_ev_slots` and `lower_compute_ev_index_for_effect`. This is pure plumbing —
  and it is the whole reason Steps 1–4 can land *without* the 200-site regression that
  killed every in-place patch (§1.5). **The representation lives behind the seam; the
  algorithm above it never gets patched, it gets *bypassed*.** This is the discipline
  the four refuted attempts bought: never edit the coupled algorithm; move the
  representation behind a read-interface and swap it there.

- **Step 1 — KEYSTONE: `effects_of(fn)` reads the flow-closure (closes L1).** Behind
  the seam, change `effects_of(fn)` from "read the snapshotted row" to `project_row` —
  walk the fn's own performs, follow its call/param FlowEdges live, subtract its
  BlockEdges. `use_each`'s flow-closure transitively reaches the lambda's `{Env2}` *by
  construction* (`lambda.row → forward.row @φ → use_each.row`), so the leak → 0 with no
  copied var to drop. `derive_ev_slots` and `compute_ev_index` already route through
  `effects_of` (Step 0), so they collapse to one reading automatically — the dual
  derivation is gone the moment the seam exists. Make the slot-0 fallback fatal
  (`E_RowConservationLeak`): a forwarded effect outside `effects_of(fn)` is now
  structurally impossible, never a guess. **This is where the wrapper dissolves and
  pass-2 stops trapping.**

- **Step 2 — carried ev-layout.** Assign the ordered ev-layout once on the fn node from
  `effects_of(fn)`; caller and callee read the carried layout, not a re-sorted row.
  Delete the sorted-order coercion contract.
- **Step 3 — flow edges replace `free_in`/`subst` for rows.** `generalize`/
  `instantiate`/`subst_row`/`free_in_row` for the *row* sort become draw-edge /
  open-frame / read-live behind the seam. Type sort stays HM-classic for now (§6.2).
- **Step 4 — instance frames replace copying.** Generalize Step 3 to no-copy frames
  for the type sort too; delete `build_inst_mapping`'s whole-type copy. (Gated hard;
  §6 checkpoints first.)
- **Step 5 — fold refinement/ownership/cursor + the runtime-floor handler onto the
  same edges** (post-L1, §5.6–§5.8 + §7's backend-selectable floor).

L1 closes at **Step 1** (which is only safe because **Step 0** exists). Steps 2–5 are
the dissolution proper, each shrinking `infer.mn`/`effects.mn`/`lower.mn` + the seed
while the seam holds the interface and the gate stays green.

---

## §9 · The eight interrogations, on the design itself

1. **Graph?** The polymorphic relationship IS a graph edge; nothing re-derived.
2. **Handler?** Evidence resolution is a handler-install-stack walk; `project` is the
   read. Resume cardinality unaffected.
3. **Verb?** Flow is the `<~`/`|>` of inference — effects flow along edges; the design
   is itself a `<~` (the graph feeds its own reading).
4. **Row?** This *is* the row algebra, made structural (⊕/−/& as edges/predicates).
5. **Ownership?** Ownership flows on the same edges (§5.7) — one linearity substrate.
6. **Refinement?** Refinements flow on the same edges (§5.6).
7. **Gradient?** Dispatch + static-vs-evidence is the gradient over the flow graph (§7).
8. **Reason?** Every edge carries its Reason; the Why Engine reads provenance natively.

All eight clear — the residue is the edge structure + `project`. The design *is* the
kernel primitive; it adds no new primitive (Anchor: composition, not invention).

---

## §10 · Risk register — verify by simulation before committing

| Risk | Checkpoint (simulate / walkthrough) |
|---|---|
| Frame leakage (uses contaminate each other) | `let id` two-uses + the higher-order ladder under `project(N, φ)` |
| Principal types lost | derive principal type of `map`/`compose`/`fold` via edges; compare to the HM scheme |
| Value-restriction soundness | effectful `let` must not generalize (§6.3) |
| Termination on cycles | mutual recursion + recursive effect rows (`iterate_from`) |
| Byte-parity drift during Steps 1–4 | micro battery byte-identical at every commit; census non-regress |
| Row subsumption direction errors | `caller ⊒ callee` audited at every call/perform/`~>` site |
| Seed/wheel divergence | mirror each step same-commit; `mentl2.wat == mentl3.wat` unaffected until intended |

Nothing here lands until its checkpoint passes by simulation — dream code, verified
by coherence + the ladder + census, never by "it compiled." The ultimate form is
proven the way Mentl proves everything: by reading the graph.

---

## Appendix · Why this is the floor (no deeper turtle on this axis)

Could *this* be a symptom of something deeper? The recursion bottoms out here: the
kernel primitive is **Graph + HM-live-with-Reasons**, and flow-edges-read-live is that
primitive applied **directly**, with no algorithm layered above it and no data
duplicated beside it. Generalize/instantiate/subst were the layer; deleting them
leaves the primitive. There is no representation more carried-truth-honest than "the
relationship is an edge in the graph that already exists, read live, carrying its own
reason." That is the floor — the same floor `mentl audit`, `unify`, and the cursor
all stand on.
