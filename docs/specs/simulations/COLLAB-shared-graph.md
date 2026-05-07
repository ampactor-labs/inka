# COLLAB — Shared Graph Substrate (Phase Z opener)

*Multi-cursor on shared `graph_handler`. Collaboration is not a feature
— it is what the substrate delivers when shared. Git, code review,
pair programming, blame, time-travel debugging, refactoring across
teams, RBAC fall out as kernel-derived projections, not as separate
modules.*

**Handle:** Hμ.collab (Phase Z opener, post-μ).
**Status:** 2026-05-07 · seeded.
**Authority:** `docs/SUBSTRATE.md` §X.1 "Collab-as-substrate" theorem
(the substrate proof); `docs/ULTIMATE_MEDIUM.md` §8.6 "Collaboration
is what `graph_handler` swap delivers" (the experience layer);
`protocol_developer_experience_vision.md` §"Collab-as-substrate"
(the vision throughline); `ROADMAP.md` Phase Z section.
**Walkthrough peers:** `Hμ-cursor.md` (cursor is a graph node — the
presence substrate); `IE-mentl-edit.md` §0.f "text-files-canonical"
(transport agnosticism); `protocol_oracle_is_ic.md` (Pure-over-broader-input
enables replay).

---

## §0 Framing — what dissolves

Every collaboration tool the industry has built exists because peer
languages lack a shared graph as the source of truth. Each one is
a workaround for "the codebase is text in files, and text-merging
is hard, and identity is by line number." Given Mentl's substrate —
graph + Reason chain + cursor + handlers — every tool collapses:

| Industry tool / category | Why it exists in peer languages | What it reduces to in Mentl |
|---|---|---|
| Git (DVCS) | Text-merging is hard; identity is by line | Reason chain walk; branches are forks; merges replay |
| GitHub / GitLab MR review | Comments must attach to text spans | Reviewer's cursor + `Reason::ReviewComment` |
| Live Share / Replit collab | Real-time co-edit needs CRDT-over-text | Two cursors, one graph_handler, atomic mutations |
| Git blame | Who wrote this line? | `Reason::AttributedTo(user, cursor_pos, time)` |
| rr / Pernosco | Replay requires recording every syscall | Walk Reason chain to any point; replay handlers |
| codemod tools (jscodeshift, etc.) | AST-walk across many files | Mutate one site; Reason chains link to dependents |
| GitHub roles / branch protection | RBAC over text ownership | Effect row `+Mutate(region)` per user |
| Linear / Jira ↔ code linking | Issues are external; references go stale | Issues are graph nodes; `Reason::ResolvesIssue` |
| Slack-thread-on-PR convo | Discussion happens in a separate tool | Reason chain entries IS the discussion |
| Tuple / Pop / etc. cursor presence | Cursors must broadcast over wire | Each cursor IS a graph node; presence is automatic projection |

**The thesis (per `docs/SUBSTRATE.md` §X.1).** When two transports
`~>` over the same shared `graph_handler`, every collaboration tool
the industry has built falls out as a derived consequence. **Multi-user
collaboration is not a feature to add; it is what the substrate
delivers when shared.** The kernel was always going to do this; it
took until Phase μ (Hμ.cursor + the projection chain) to see it.

This walkthrough names the substrate. Phase Z opens here.

---

## §1 Hard constraints

Per the substrate-first discipline + the developer-experience vision:

1. **No new kernel primitives.** Composition only. The eight kernel
   primitives are sealed (per `protocol_kernel_closure.md`); collab
   composes on graph + handlers + ownership + effect row + Reasons.

2. **The graph IS the source of truth, including across users.** No
   parallel mirror, no separate sync layer. When two transports are
   attached to one shared `graph_handler`, the graph IS what both
   users edit; the Reason chain IS the history.

3. **Reason chains are append-only by construction.** No mutation,
   no rewrite. CRDT semantics fall out: two users mutating
   concurrently produce two `Reason` children of one parent — no
   conflict resolution needed at the graph level; conflicts surface
   as kernel-arbitrated refinement / ownership / row violations.

4. **Cursors are graph nodes.** Each user's cursor is a handle in
   the shared graph (per Hμ.cursor `Cursor(Handle, Reason, Float)`).
   Other users' cursors render as automatic projection — no separate
   "presence service."

5. **Permissions are an effect row, not a separate auth system.**
   `+Mutate(region)` per user grants mutation capability; `-Read(region)`
   denies read; the kernel proves enforcement at handler install via
   row subsumption. **RBAC is a proof, not a runtime check.**

6. **Local-first persistence.** Each transport (terminal / VSCode /
   browser / mobile) has its own local graph_handler with full state.
   Sharing is `graph_handler` swap to a CRDT-replicated variant. Going
   offline is `graph_handler` swap back to local. Reconnection is
   replay of accumulated Reasons.

7. **Pure-over-broader-input enables replay.** Any handler-projection
   (compile, check, lower, emit) replays deterministically from any
   Reason-chain prefix (per `protocol_oracle_is_ic.md` + DESIGN §4
   "Inference Is the Light" + DESIGN §11 self-hosting fixed point).
   Time-travel debugging IS this replay.

8. **No CRDT machinery beyond Reason-chain append.** Reason chains are
   already append-only (kernel #8 HM live with Reasons); no Yjs / Y-CRDT
   / Automerge / Loro library needed. The kernel's Reason discipline
   IS the CRDT.

---

## §2 The eight interrogations

Per CLAUDE.md / DESIGN.md §0.5 / Mentl's anchor.

| # | Interrogation | Answer for COLLAB |
|---|---|---|
| 1 | **Graph?** | Each user's cursor IS a graph node (`Cursor(Handle, Reason, Float)` per Hμ.cursor). Shared `graph_handler` is the canonical store; mutations land as graph nodes with `Reason::AuthoredBy(user, time)` edges. |
| 2 | **Handler?** | `shared_graph_handler` is the substrate handler. Inferred resume cardinality: OneShot for `graph_chase` / `graph_bind` reads/writes; MultiShot for `graph_subscribe(region)` — multiple subscribers receive one notification fanout. |
| 3 | **Verb?** | `~>` for transport attachment (each user's transport composes on shared_graph_handler); `<~` feedback loop closes the bus-compressor topology at the multi-user boundary (per ULTIMATE_MEDIUM §3.4). |
| 4 | **Row?** | `shared_graph_handler` declares `+SharedGraph + GraphRead + GraphWrite + !DirectAlloc`. Per-user permission rows compose: `user_alice_row = +Mutate(region_a) + Read(*) - Mutate(region_b)`. Row subsumption proves install compatibility. |
| 5 | **Ownership?** | Reason chain entries are `own` (transferred from author into the chain; chain owns them after). Cursor handles are `ref` (other users borrow but never consume). Mutations are `own` per author; the graph absorbs. |
| 6 | **Refinement?** | `Reason where appendOnly(self.parent_chain) && signed_by(self.author)` (when federated). Mutation: `GraphMutation where deps_resolved && rows_compatible`. Verify discharges at apply time; conflicts are V_Pending or E_RefinementRejected. |
| 7 | **Gradient?** | The gradient ranks per-cursor (kernel #7); user A's mutation lands → user B's gradient re-ranks against A's mutation; B sees relevant changes ranked, not a notification dump. Each cursor's argmax is independent. |
| 8 | **Reason?** | `Reason::AttributedTo(user, cursor_pos, time)` on every mutation. `Reason::ReviewComment(handle, msg, reviewer)` for review. `Reason::ResolvesIssue(issue_handle, by_handle)` for issue↔code linking. The Why Engine walks back to (user, intent, gradient_score). |

All eight clear. **Zero new primitives invented.** Composition only.

---

## §3 Substrate proposal — six peer handles

### §3.1 `Hμ.collab.shared-graph-handler` — the opening primitive

The substrate move that delivers everything else.

```mn
effect SharedGraph {
  graph_subscribe(region: GraphRegion) -> Subscription
  graph_publish(mutation: GraphMutation) -> ()
  graph_resolve_conflict(local: GraphMutation, remote: GraphMutation) -> Resolution
}

handler shared_graph_handler with peers = [], pending_mutations = [] {
  graph_subscribe(region) => {
    let sub = Subscription({ region: region, ... })
    resume(sub) with peers = push(peers, sub)
  },
  graph_publish(mutation) => {
    // append to local Reason chain
    // broadcast to peers via transport handler
    // peers' graph_handler receives + applies + verifies
    let result = apply_to_local_graph(mutation)
    broadcast_to_peers(peers, mutation)
    resume(result)
  },
  graph_resolve_conflict(local, remote) => {
    // Reason CRDT: both lands as children of common parent
    // Verify ledger checks resulting rows + refinements
    // surface as kernel diagnostic if violated
    resume(merge_via_reason_chain(local, remote))
  }
}
```

**Pre-existing substrate composed:** `graph.mn` (graph mutations);
`infer.mn` (Verify-on-write); `effects.mn` (row subsumption);
`oracle.mn` (Reason chain). **Zero new ADTs at the kernel level.**

### §3.2 `Hμ.collab.reason-crdt-replay` — branches as Reason-chain forks

Reason chains are already append-only. CRDT semantics fall out:

```mn
fn fork_reason_chain(chain: ReasonChain, branch_name: String) -> ReasonChain
  with !Mutate =
  // create branch as child of current head
  ReasonChain({
    parent: chain,
    head: chain.head,
    branch_label: branch_name
  })

fn merge_reason_chains(a: ReasonChain, b: ReasonChain) with Verify = {
  // walk both chains from common ancestor
  let ancestor = find_common_ancestor(a, b)
  let a_branch = walk_from(a, ancestor)
  let b_branch = walk_from(b, ancestor)
  // apply b's mutations against a's state; verify each
  // conflicts surface as Verify diagnostics, NOT diff hunks
  apply_branch_to(b_branch, a)
}
```

**Industry tool replaced: git** (and any DVCS). Branches are forks of
the chain. Merges replay one chain's Reasons against another's state.
Conflicts are kernel-arbitrated refinement / ownership / row
violations — visible in the Verify ledger, not in `<<<<<<<`-diff
markers.

### §3.3 `Hμ.collab.cursor-presence` — cursors as graph nodes

Per Hμ.cursor: `Cursor(Handle, Reason, Float)` is a substrate value
in `src/cursor.mn`. In the shared-graph-handler context, each user's
cursor IS a handle in the shared graph. Other users' cursors render
naturally because they're in the graph:

```mn
fn render_other_cursors(my_cursor: Cursor, all_cursors: List<Cursor>)
  -> List<RenderedCursor> with !Mutate =
  all_cursors
    |> filter((c) => not (c == my_cursor))
    |> map((c) => RenderedCursor({
         user:     c.author,
         position: c.handle,
         gradient_argmax_score: c.score
       }))
```

**Industry tool replaced: presence services** (Tuple, Pop, Live Share
presence APIs). Presence is automatic graph projection.

### §3.4 `Hμ.collab.permission-row` — RBAC as effect row

```mn
type GraphRegion = GraphRegion(List<Handle>)  // sorted-set of handles

effect Permission {
  read_region(region: GraphRegion) -> ()       // requires +Read(region)
  mutate_region(region: GraphRegion, mut: GraphMutation) -> ()
                                                 // requires +Mutate(region)
}

handler permission_alice with row = "+Read(*) +Mutate(region_a) -Mutate(region_b)" {
  read_region(region) => {
    if region_subsumes(self.row.read, region) { resume(()) }
    else { perform report(E_PermissionDenied, span, "alice cannot read region") }
  },
  mutate_region(region, mut) => {
    if region_subsumes(self.row.mutate, region) {
      perform graph_publish(mut)
      resume(())
    } else { perform report(E_PermissionDenied, span, "...") }
  }
}
```

Row subsumption at handler install proves the user's permissions
match the operations they perform. **Industry tool replaced: GitHub
team permissions, branch protection, code-owner rules.** RBAC is by
proof, not by runtime audit.

### §3.5 `Hμ.collab.transport-bridge` — WebSocket / WebRTC / shared-FS

Composes on `Hμ.cursor.transport` (Phase μ peer). Each transport
serializes graph mutations as Pack/Unpack records and replays them
on the receiving side:

```mn
handler websocket_collab_transport(url: String) with Network {
  graph_publish(mutation) => {
    let bytes = perform pack_graph_mutation(mutation)
    perform ws_send(url, bytes)
    resume(())
  },
  graph_subscribe(region) => {
    let sub_msg = perform pack_subscribe(region)
    perform ws_send(url, sub_msg)
    let stream = perform ws_recv_stream(url)
    resume(Subscription({ stream: stream, region: region }))
  }
}

handler webrtc_collab_transport(peer_id: String) with Network { ... }
handler shared_fs_collab_transport(path: String) with Filesystem { ... }
```

**The wire format IS Pack/Unpack on graph mutations** — same substrate
as `.mentl/cache/*.kai` files (per `Hβ-bootstrap-no-seed.md` +
`protocol_kernel_closure.md`). No protobuf, no JSON-RPC schema
maintenance, no API versioning — the wire format follows the graph
schema by construction.

### §3.6 `Hμ.collab.federated-replication` — distributed graph_handlers

Pure-over-broader-input means any node can replay from any Reason-chain
prefix (per `protocol_oracle_is_ic.md`). Federation:

```mn
handler federated_graph_handler(my_node_id: NodeId, peers: List<NodeId>) {
  graph_publish(mutation) => {
    let signed = perform sign_reason(mutation, my_node_id)
    broadcast_to_peers(peers, signed)
    let local = apply_to_local_graph(mutation)
    resume(local)
  },
  graph_recv(signed_mutation) => {
    if perform verify_signature(signed_mutation) {
      let local = apply_to_local_graph(signed_mutation.mutation)
      resume(local)
    } else { perform report(E_UntrustedReason, span, "...") }
  }
}
```

Trust = signed Reason chain entries. **Industry replaced: federated
git protocols (push/pull over SSH), distributed source control.**
Federation is a graph_handler variant.

---

## §4 The handler stack

```
edit_session(user_id)
    ~> shared_graph_handler         ← outermost: the shared substrate
    ~> permission_<user_id>         ← per-user RBAC
    ~> websocket_collab_transport   ← real-time wire format
    ~> cursor_default               ← Hμ.cursor projection (each user)
    ~> mentl_default                ← Mentl voice + tentacles
    ~> verify_ledger                ← refinement obligations + conflicts
    ~> diagnostics_handler          ← outermost-with-no-escape
```

Reading top-to-bottom = inner-to-outer trust. The shared_graph_handler
is innermost (highest capability, most trusted); diagnostics is
outermost (no outward escape, sandbox boundary).

---

## §5 Forbidden patterns (drift modes)

### §5.1 `shared_graph_handler` substrate

- **Drift 9 (deferred-by-omission):** the six sub-handles land in
  ordered commits but as one cohesive substrate; no "land
  shared-graph-handler now, conflict-resolution later" splits without
  named follow-ups in positive form.
- **Drift 7 (parallel-arrays-not-record):** subscription state is
  one record (`Subscription({region, peers, ...})`), not parallel
  `(region, peers)` lists.
- **Drift 1 (Rust vtable):** no dispatch table mapping subscription
  types to handler instances; effect ops only.
- **Drift 4 (Haskell monad transformer):** `~>` chain composes;
  shared_graph_handler is NOT a monad transformer over local
  graph_handler.

### §5.2 Reason CRDT

- **No third-party CRDT library.** No Yjs, no Y-CRDT, no Automerge,
  no Loro. The kernel's Reason chain IS the CRDT (append-only by
  construction; merges by replay; conflicts by Verify).
- **Drift mode "feature-shaped collab":** "we need a real-time
  collaboration feature" → drift 1 + drift 9 in feature clothes.
  Convert to "two transports → one shared graph_handler. Done."
- **Drift 8 (string-keyed):** branch labels are `String` (user-
  facing), but identity is the parent-chain pointer; never identify
  a branch by name alone.

### §5.3 Permission row

- **Drift 8 (string-keyed-when-structured):** permission specs are
  ADT (`+Read(GraphRegion) - Mutate(GraphRegion) ...`), never
  `permissions = "alice:read,write"` strings.
- **Drift 6 (primitive-type-special-case):** `Permission` is not a
  separate concept — it IS a typed effect row over (user × region).
- **Foreign-framework drift:** not GitHub teams API; not LDAP roles;
  not OAuth scopes; not casbin policy syntax. The row algebra IS
  the auth system.

### §5.4 Transport bridge

- **Drift 38 (mascot-as-namespace):** `mentl_collab_transport` is
  drift; `websocket_collab_transport` / `webrtc_collab_transport` /
  `shared_fs_collab_transport` name what they ARE, not who they're
  prefixed by.
- **Drift "API versioning"** (foreign framework drift): no
  `protocol_version: 1` field on mutations; the wire format follows
  graph schema; schema migration IS a Reason-chain entry (the same
  substrate that handles refactoring across teams).

### §5.5 Federated replication

- **Drift "trust as runtime check":** `verify_signature` proves trust
  cryptographically; row `+Read(remote_region)` proves authorization;
  both are at handler install / mutation apply, not "checked at
  runtime per request."
- **AI/agent vocabulary** (per `protocol_developer_experience_vision.md`):
  not "AI mediates conflicts" / "agent reviews changes" — Mentl's
  Synth handler-chain proposes proven candidate resolutions; the
  developer (or the merging human) accepts.

### §5.6 Generalized fluency-taint check

Pattern came from git internals / GitHub API / Slack threads on PRs?
Restructure until it composes from the eight kernel primitives alone.
**The shape Mentl draws is not "git but with refinement types added
on" — it's the substrate-cited form that those systems can't produce.**

---

## §6 Sub-handle decomposition (the six peers)

Per Anchor 7 cascade discipline. Each sub-handle lands in its own
commit; this walkthrough specifies the full substrate. Ordering by
dependency:

| Order | Handle | Composes on | Lines (estimate) |
|---|---|---|---|
| 1 | **Hμ.collab.shared-graph-handler** | Phase μ + graph.mn | ~250 |
| 2 | **Hμ.collab.transport-bridge** | shared-graph-handler + Hμ.cursor.transport | ~200 (per transport variant; 3 variants) |
| 3 | **Hμ.collab.cursor-presence** | shared-graph-handler + Hμ.cursor | ~150 |
| 4 | **Hμ.collab.permission-row** | shared-graph-handler + effect row | ~200 |
| 5 | **Hμ.collab.reason-crdt-replay** | shared-graph-handler + Reason chain | ~300 |
| 6 | **Hμ.collab.federated-replication** | reason-crdt-replay + Pure-over-broader-input | ~300 |

**Total: ~1400-1600 lines `.mn` across 6+ commits.** Comparable to
the IE arc; commensurate with Phase Z opening the medium to the
ecosystem.

---

## §7 Acceptance tests

**AT-COLLAB.1 — Two transports, one graph.** Two `mentl edit` sessions
attach to the same project URL. User A types in `module_a.mn`; user
B sees the mutation propagate within transport latency. Both cursors
visible to both users.

**AT-COLLAB.2 — Reason chain CRDT.** Two users edit the same handle
concurrently. Both mutations land as children of the common parent
Reason. Refinement check fires; if compatible, both apply; if
incompatible, surface as Verify diagnostic with both candidates +
mutual context.

**AT-COLLAB.3 — Branch as fork.** User A invokes `mentl --with
fork_chain(name="experiment")`. The chain forks at the current head;
A's subsequent mutations land on the new branch. User B remains on
main.

**AT-COLLAB.4 — Merge as replay.** User A merges experiment back to
main. The merge handler walks A's branch from the divergence point
and applies each Reason against main; refinement violations surface
as `V_Pending` obligations. Auto-discharge for non-conflicting
mutations; surface conflicts for human resolution.

**AT-COLLAB.5 — Permission denied is type error.** User Bob's
handler installs with `permission_bob` row that lacks
`+Mutate(secret_region)`. Bob attempts `graph_bind` in the secret
region. Compile fails with `E_PermissionDenied` at handler install.
**No runtime check; type-level proof.**

**AT-COLLAB.6 — Cursor presence.** User A's cursor moves; user B's
medium projects the new position within transport latency. Hover on
A's cursor shows `Reason::AttributedTo(alice, ...)`.

**AT-COLLAB.7 — Time-travel via Reason chain.** User A asks Mentl
"show me the state at 2pm yesterday." `cursor_at_time(timestamp)`
walks the Reason chain to find the head at that timestamp; replays
handlers up to that point; renders the projection. **No special
debugger; the Why Engine IS the debugger.**

**AT-COLLAB.8 — Federated replication.** Three nodes (Alice, Bob,
Carol) each run `federated_graph_handler` with each other in `peers`.
Alice mutates → broadcast to Bob + Carol → both apply → Bob mutates
→ broadcast → Alice + Carol apply. Reason chain in all three nodes
converges (CRDT correctness).

**AT-COLLAB.9 — Capability-stack-as-security.** Install
`~> read_only_collab` outside `shared_graph_handler` and inside
the user's transport. Attempting any `graph_publish` fails at
handler install — by row subsumption, not by runtime policy. **The
sandbox is by type.**

**AT-COLLAB.10 — Offline-then-resume.** User A goes offline (transport
disconnects). A continues editing via local graph_handler. A reconnects;
transport replays accumulated Reasons to peers; peers apply +
verify. **Local-first by default; sync is opt-in handler swap.**

---

## §8 What COLLAB replaces (disintermediation map)

| External system | What it does | What COLLAB does instead |
|---|---|---|
| **Git** (Linus 2005) | DVCS with branches + merges + blame; text-based identity | Reason chain IS the DVCS; branches are forks; merges are replay; blame is `Reason::AttributedTo` walk; identity is graph handle |
| **GitHub / GitLab** | Centralized hosting + PR review + branch protection | Federated graph_handlers; PR review is reviewer cursor + `Reason::ReviewComment`; branch protection is permission row |
| **Live Share / Replit collab / VS Code Live Share** | Real-time co-edit | Two transports → one shared graph_handler |
| **Tuple / Pop / Around** | Cursor presence + voice | Each cursor IS a graph node; presence is automatic projection (voice is orthogonal — handler over Audio effect if wanted) |
| **rr / Pernosco / Time Travel Debugger** | Replay execution | Reason chain replay; Pure-over-broader-input enables it; `cursor_at_time(t)` |
| **codemod tools (jscodeshift, fastmod)** | AST refactor across files | Mutate one site; Reason chains link to dependents; downstream cursors re-rank automatically |
| **Linear / Jira / GitHub Issues** | External issue tracker; references go stale | Issues are graph nodes; `Reason::ResolvesIssue(issue_handle, by_handle)` links them; references can't go stale (refactor updates them) |
| **GitHub team permissions / branch protection rules** | Coarse RBAC over text | Effect row `+Mutate(region) - Read(other_region)` per user; row subsumption proves enforcement |
| **OAuth scopes / LDAP roles / casbin policies** | External auth + policy | Same as above — permission row IS the policy |
| **Slack threads on PRs / Discord on commits** | Discussion attached to changes | Reason chain entries IS the discussion (`Reason::DiscussionThread(handle, [...messages])`) |

**The disintermediation claim:** Phase Z, when shipped, replaces the
collaboration / version-control / review / RBAC / time-travel /
discussion stack with substrate. Not a "Mentl-flavored alternative"
to git; **a kernel-derived projection that obviates the category.**

---

## §9 Sequencing — substrate file order

Per Anchor 7. Lands in this order; each its own commit; drift-audit
clean.

1. `src/types.mn` — add `GraphRegion`, `GraphMutation`, `Subscription`,
   `Resolution`, `NodeId`, `SignedReason` ADTs (~30 lines)
2. `lib/runtime/collab_pack.mn` — Pack/Unpack for graph mutations
   over wire (extends existing Pack substrate; ~80 lines)
3. `lib/collab/shared_graph_handler.mn` — Hμ.collab.shared-graph-handler
   (~250 lines)
4. `lib/collab/cursor_presence.mn` — Hμ.collab.cursor-presence (~150)
5. `lib/collab/permission_row.mn` — Hμ.collab.permission-row (~200)
6. `lib/collab/reason_crdt_replay.mn` — Hμ.collab.reason-crdt-replay
   (~300)
7. `lib/collab/transport_websocket.mn` — Hμ.collab.transport-bridge
   variant 1 (~200)
8. `lib/collab/transport_webrtc.mn` — variant 2 (~200)
9. `lib/collab/transport_shared_fs.mn` — variant 3 (~200)
10. `lib/collab/federated_replication.mn` — Hμ.collab.federated-replication
    (~300)
11. `src/main.mn` — entry-handler aliases (`collab_run` for shared
    edit sessions); per CLI canonical vocabulary (~30)
12. `docs/errors/E_PermissionDenied.md`, `E_UntrustedReason.md`,
    `E_ReasonChainConflict.md` (~50 each)

**Total: ~1900-2200 lines `.mn` + ~150 lines docs across ~12 commits.**

---

## §10 What COLLAB does NOT cover

- **Voice / video chat** — orthogonal; handlers over Audio + Video
  effects compose alongside. Not COLLAB substrate.
- **Build artifact distribution** — handled via `Hβ-bootstrap-no-seed.md`'s
  hash-addressed `.kai` cache. Federation extends naturally; not
  COLLAB-specific.
- **External integrations** (Slack/Discord/email notifications) —
  handlers over Network effect compose; the Reason chain naturally
  webhookable.
- **End-to-end encryption beyond signing** — federated_replication
  covers signature-based trust. Stronger E2EE (zero-knowledge proofs
  over graph mutations) is post-COLLAB peer work.
- **Mobile clients** — COLLAB substrate is transport-agnostic; mobile
  is a `Hμ.collab.transport-bridge` variant (`mobile_collab_transport`
  over WebRTC or HTTP-poll). Out of COLLAB scope; trivial to add.
- **Cross-language collab** — Mentl-only for v1. Polyglot collab
  (Mentl + non-Mentl participants) requires bridge handlers; out of
  scope.

---

## §11 What closes when COLLAB lands

After all six sub-handles + the seven supporting files:

1. **Mentl reaches the ecosystem.** Solo + team + open-source +
   remote work all run on one substrate. The medium reaches developers
   wherever they are; collaboration is what shows up when they're
   together.

2. **Git becomes a compatibility transport.** Reason chains are the
   version control; git stays as a wire format for non-Mentl tools
   to consume. The Mentl-native team works in pure Reason chains.

3. **Code review dissolves into projection.** A reviewer's cursor
   reads the author's mutations; the Why Engine surfaces causal
   context; comments are Reason chain entries. **GitHub PR review
   becomes structurally uncompetitive.**

4. **Pair programming and async collab share substrate.** No
   distinction between "we're paired now" and "we're working
   async" — both are cursors over the shared graph. Latency differs;
   substrate doesn't.

5. **Time-travel debugging is one click.** Walk the Reason chain
   to any timestamp; replay handlers up to that point. **No
   special tool installation; the Why Engine IS the debugger.**

6. **Refactoring across teams becomes safe-by-construction.**
   Mutate one site; Reason chains link to dependents; downstream
   cursors re-rank; affected developers see the new gradient
   argmax. **No codemod scripts; no "did this break X?" reviews.**

7. **RBAC is provable.** Permission rows compose; row subsumption
   proves enforcement at handler install. **No more
   "did the policy actually grant the right thing?" audits.**

8. **The collaborative-substrate theorem is operationally
   demonstrable** (per `docs/SUBSTRATE.md` §X.1). Two transports
   on one shared graph_handler delivers what the industry builds
   as features. **Phase Z is the medium reaching the ecosystem.**

---

## §12 Connection to the kernel

Per CLAUDE.md / DESIGN.md §0.5 — COLLAB composes from the eight
primitives; **nothing extends the kernel** (per kernel-closure
protocol).

| Primitive | How COLLAB uses it |
|---|---|
| **#1 Graph + Env** | The shared graph_handler IS the canonical store. Each user's cursor IS a graph node. Mutations land as graph writes. |
| **#2 Handlers + typed resume discipline** | shared_graph_handler is the substrate handler. graph_subscribe uses MultiShot resume (one notification fans out to N subscribers). |
| **#3 Five verbs** | `~>` chains compose transport + permission + shared_graph + cursor + diagnostics. `<~` closes the bus-compressor topology at the multi-user boundary. |
| **#4 Boolean effect algebra** | Permission row IS the Boolean algebra over (user × region). `+Mutate(region) - Mutate(other)` proves enforcement. |
| **#5 Ownership as effect** | Reason chain entries are `own` (transferred to chain). Cursor handles are `ref` (other users borrow but never consume). |
| **#6 Refinement types** | `Reason where appendOnly && signed_by(author)` enforces CRDT semantics. `GraphMutation where deps_resolved && rows_compatible` enforces apply correctness. |
| **#7 Continuous gradient** | Each cursor's gradient ranks per-user (proximity bias differs); user A's mutation re-ranks user B's gradient automatically. |
| **#8 HM inference + Reasons** | Reason chain IS the substrate of collab — all causality / attribution / time-travel walks Reason DAG. The Why Engine IS the collab tool. |

**Mentl's tentacle mapping.** The Why tentacle is COLLAB's primary
voice surface — every collaboration question ("why did this change?
who did it? what depended on it? what does this rename break?")
walks the Reason chain. Trace tentacle for ownership across users.
Verify tentacle for conflict diagnostics. Teach tentacle suggests
next moves per cursor. **All eight tentacles fire in COLLAB scenes;
none extend the kernel.**

---

## §13 Cross-references

- `docs/SUBSTRATE.md` §X.1 — Collab-as-substrate theorem (proof)
- `docs/ULTIMATE_MEDIUM.md` §8.6 — Collaboration is what
  `graph_handler` swap delivers (experience layer)
- `protocol_developer_experience_vision.md` §"Collab-as-substrate"
  (vision throughline)
- `ROADMAP.md` Phase Z section (sequencing + named peer handles)
- `docs/specs/simulations/Hμ-cursor.md` (cursor as graph node — the
  presence substrate)
- `docs/specs/simulations/IE-mentl-edit.md` (transport agnosticism;
  text-files-canonical)
- `docs/specs/simulations/EH-entry-handlers.md` (CLI alias for
  `mentl --with collab_run`)
- `docs/specs/simulations/CLI-canonical-vocabulary.md` (CLI verb
  catalog)
- `protocol_oracle_is_ic.md` (Pure-over-broader-input enables replay)
- `protocol_kernel_closure.md` (composition not invention)

---

*Mentl solves Mentl. Multi-cursor on shared graph delivers what the
industry builds as features. The kernel was always going to do this;
Phase Z is when the medium reaches the ecosystem.*
