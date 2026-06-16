# Polymorphism as Flow Edges
## The inference graph as its own substitution — dissolving generalize / instantiate / subst

> **Status:** design draft (dream code; verified by simulation + walkthrough + the
> higher-order-effect micro ladder, not by compilation). Opened 2026-06-15 when the
> L1 higher-order-effect trap bisected to a *class*: a polymorphic relationship the
> graph should carry as a live edge, re-derived instead as copied free variables
> that lose their link. This doc designs the ultimate form of that relationship and
> every subsystem it touches.

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

### 1.2 The canonical instance — the higher-order-effect trap

`use_each(xs) = map(lambda, xs)` under `~> env2_handler`. Bisected to root
(`tests/micros/mn-higher-order-effect*`, [[protocol_hoeffect_bisection_2026_06_15]]):

- A config-param handler `map_collector(f)`'s arm calls `f`. The residual `r_handle`
  should make `map` effect-polymorphic: `map`'s row var **is** `f`'s effect var.
- But `generalize(map)` collects them as **separate** quantified vars (the residual
  accumulator and the param var never got union-find-linked). So at the call
  `map(lambda)`, `instantiate` freshens two unrelated vars; `unify(lambda, f)` binds
  one; the other (map's row) stays free. `use_each`'s row never receives `{Env2}`.
- **The leak is present in *every* wrapper case** (`-wrapper`, `-multi-state` both
  leak `use_each_Env2` and still "pass") — the silent slot-0 fallback masks it: with
  one effect to thread, slot 0 is coincidentally right. `-builtin-state` only *traps*
  because a `make_list` adds a slot, shifting Env2's true position off the lucky 0.

So the bug is not the `make_list`, not the residual scope, not the wrapper alone —
it is that **effect-polymorphism through a config-param handler is structurally
broken, and a guess masks it**. Both halves are the same root: the graph should
carry `map.row ⊇ f.row` as an edge; it carries two disconnected copied vars instead.

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

---

## §8 · Incremental path — how to get here without a big-bang rewrite

Each step is gated by the higher-order-effect ladder (**leak → 0 across `-two-op`,
`-wrapper`, `-multi-state`, `-builtin-state`, `-builtin-no-wrapper`; `-builtin-state`
→ 42**) + the micro battery (byte-identical) + the census, both layers, wheel-first.

- **Step 1 — residual as a live edge (closes L1).** Replace `HandlerKind`'s
  `r_handle` accumulator with: the install reads the handler's arm rows **live**
  (the arms are graph nodes) and draws `installing-fn.row ⊒ config.row`. The config
  var becomes the fn's row var *by construction* (one node) → `generalize` sees one
  var → `use_each` receives `{Env2}` → leak → 0 everywhere. **And** make the slot-0
  fallback fatal (`E_RowConservationLeak`), so luck can never mask again. This is the
  smallest move that is *in the edge model's direction*, not a bookkeeping patch.
- **Step 2 — carried ev-layout.** Assign the ev-layout once on the fn node from
  `project_row`; both `derive_ev_slots` and `compute_ev_index` read it. Delete the
  dual derivation + the sorted-order coercion contract.
- **Step 3 — flow edges replace `free_in`/`subst` for rows.** `generalize`/
  `instantiate`/`subst_row` for the *row* sort become draw-edge / open-frame / read-
  live. Type sort stays HM-classic for now (§6.2).
- **Step 4 — instance frames replace copying.** Generalize Step 3 to no-copy frames
  for the type sort too; delete `build_inst_mapping`'s whole-type copy. (Gated hard;
  §6 checkpoints first.)
- **Step 5 — fold refinement/ownership/cursor onto the same edges** (post-L1, the
  peer upgrades in §5.6–§5.8).

L1 closes at **Step 1**. Steps 2–5 are the dissolution proper, each shrinking
`infer.mn` and the seed while the gate stays green.

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
