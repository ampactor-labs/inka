# COLLAB — Shared Graph Substrate (Phase Z opener)

*Multi-cursor on shared `graph_handler`. The medium reaches teams.
Real-time co-edit + causal understanding + per-region RBAC fall out
of two transports `~>` over one shared graph. **Mentl does NOT
replace git** — git handles durable versioned history fine; Mentl
adds the causal-and-presence layer on top via a `git_handler` bridge.*

**Handle:** Hμ.collab (Phase Z opener, post-μ).
**Status:** 2026-05-07 · seeded.
**Authority:** `docs/SUBSTRATE.md` §X.1 "Collab-as-substrate" theorem
(scope clarified post-2026-05-07: real-time + causal layer is
substrate-derived; durable history is git's domain);
`docs/ULTIMATE_MEDIUM.md` §8.6 "Collaboration is what `graph_handler`
swap delivers"; `protocol_developer_experience_vision.md`
§"Collab-as-substrate"; `ROADMAP.md` Phase Z section.
**Walkthrough peers:** `Hμ-cursor.md` (cursor as graph node — the
presence substrate); `IE-mentl-edit.md` §0.f "text-files-canonical"
(transport agnosticism; the on-disk file is canonical and IS what
git versions).

---

## §0 Framing — what dissolves, what doesn't

### What COLLAB dissolves

Real-time collaboration tools that exist because peer languages have
no shared graph + no causal layer:

| Industry tool | Why it exists | What COLLAB does instead |
|---|---|---|
| Live Share / Replit collab / VS Code Live Share | Real-time co-edit needs CRDT-over-text + presence service | Two transports `~>` one shared `graph_handler`; presence is automatic graph projection |
| Tuple / Pop / Around — cursor presence | Cursors must broadcast over wire | Each cursor IS a graph node (per Hμ.cursor); other users see them by reading the graph |
| Per-region RBAC (GitHub team rules, branch protection on paths) | Coarse policy attached to filesystem paths | Effect row `+Mutate(region) - Read(other_region)` per user; row subsumption proves enforcement at handler install |
| In-editor pair-programming voice/chat overlays | Discussion needs a separate channel | Reason chain entries IS the in-session discussion (`Reason::DiscussionThread(handle, [...messages])`); persists for the session |

**The thesis (per `docs/SUBSTRATE.md` §X.1, scoped).** When two
transports `~>` over the same shared `graph_handler`, **real-time
co-edit + causal understanding + per-region RBAC + cursor presence
emerge as substrate consequences**. None of those need a separate
module; all four are kernel-derived projections.

### What COLLAB does NOT dissolve

**Git.** Mentl does not replace git. Git is mature, ubiquitous, and
good at what it does — durable versioned history, branches, merges,
distributed sync, blame, signed commits, ecosystem integration with
non-Mentl tools. Building a Mentl-native version-control substrate
would duplicate that with no compelling differentiator and would
require persistent Reason-chain logs (heavy substrate) for a
property git already provides.

**Mentl integrates with git via `git_handler` (per §3.5 below).** The
on-disk file is canonical (per IE-mentl-edit.md §0.f); git versions
the on-disk files; Reason DAG synthesizes commit messages on save;
loading a project re-reads the files and the cache. Causal
understanding lives in Mentl (Reason chain WITHIN a session);
durable history lives in git (commits across sessions). **Two layers,
two questions, both useful.**

| Question | Answered by |
|---|---|
| "Why does this binding have its current type?" | Reason chain at the cursor (Mentl, within session) |
| "What changed since last review?" | git diff or `mentl --with review_run` over git revs |
| "Who wrote this line?" | git blame |
| "Why was this change made?" | git commit message (synthesized from Reason DAG by `git_handler` on save) |
| "What's the live state across teammates right now?" | shared `graph_handler` + transport (real-time, in-session) |
| "What other handles depend on this one?" | Reason chain reverse-walk (Mentl) |
| "Can user X mutate this region?" | permission_row subsumption (Mentl, compile-time proof) |

This split is the substrate-honest position. Earlier framings of the
COLLAB walkthrough overreached on the git-dissolution claim; this
revision walks them back.

---

## §1 Hard constraints

1. **No new kernel primitives.** Composition only. Eight kernel
   primitives sealed (per `protocol_kernel_closure.md`).

2. **The graph IS the source of truth WITHIN a session.** Two
   transports attached to one shared `graph_handler` see the same
   graph. Across sessions, files-on-disk are canonical (per IE
   §0.f); git versions the files.

3. **Reason chains are append-only WITHIN a session** (kernel #8).
   Cross-session Reason persistence is *not* a substrate goal — only
   the current binding's Reason persists in `.kai` cache; mutation
   history is in-session only.

4. **Cursors are graph nodes.** Each user's cursor is a handle in
   the shared graph (per Hμ.cursor). Other users' cursors render as
   automatic projection — no separate presence service.

5. **Permissions are an effect row, not a separate auth system.**
   `+Mutate(region)` per user; row subsumption proves enforcement
   at handler install. **RBAC is a proof, not a runtime check.**

6. **Local-first persistence.** Each transport has its own local
   `graph_handler` with full state. Sharing is `graph_handler` swap
   to a CRDT-replicated variant (in-memory). Going offline is
   `graph_handler` swap back to local. Reconnection re-syncs from
   any peer's current graph state.

7. **No persistent mutation log.** Mentl does NOT maintain an
   append-only log of every graph mutation across sessions. Within
   a session: yes (the trail enables rollback). Across sessions:
   files + git. The Reason chain is causal-current-state, not
   historical-record.

8. **No third-party CRDT library.** Concurrent-mutation arbitration
   uses Verify-on-write — refinement / ownership / row violations
   surface as kernel diagnostics. Last-mutation-wins for compatible
   writes; conflicts surface as `V_Pending` for human resolution.
   No Yjs / Automerge / Loro needed; the kernel arbitrates.

---

## §2 The eight interrogations

| # | Interrogation | Answer for COLLAB |
|---|---|---|
| 1 | **Graph?** | Each user's cursor IS a graph node. Shared `graph_handler` is the canonical store within a session. Mutations land as graph writes with `Reason::AuthoredBy(user, time)`. Cross-session: files-on-disk + IC cache. |
| 2 | **Handler?** | `shared_graph_handler` is the substrate handler. Inferred resume cardinality: OneShot for `graph_chase` / `graph_bind`; MultiShot for `graph_subscribe(region)` (one notification fans out to N subscribers). |
| 3 | **Verb?** | `~>` for transport attachment; `<~` for the bus-compressor topology at the multi-user boundary (each keystroke shapes the next argmax for all users). |
| 4 | **Row?** | `+SharedGraph + GraphRead + GraphWrite + !DirectAlloc`. Permission rows compose: `user_alice_row = +Mutate(region_a) + Read(*) - Mutate(region_b)`. Row subsumption proves install compatibility. |
| 5 | **Ownership?** | Reason chain entries are `own` (transferred to chain within session). Cursor handles are `ref` (other users borrow but never consume). Mutations are `own` per author. |
| 6 | **Refinement?** | `GraphMutation where deps_resolved && rows_compatible`. Verify discharges at apply time; conflicts are V_Pending or E_RefinementRejected. |
| 7 | **Gradient?** | Each cursor's gradient ranks per-user (different proximity bias). User A's mutation lands → user B's gradient re-ranks against A's mutation. |
| 8 | **Reason?** | `Reason::AuthoredBy(user, cursor_pos, time)` on every mutation. `Reason::ReviewComment(handle, msg, reviewer)` for review (in-session). The Why Engine walks back to (user, intent, gradient_score) within the session. |

All eight clear. **Zero new primitives invented.** Composition only.

---

## §3 Substrate proposal — five peer handles

### §3.1 `Hμ.collab.shared-graph-handler` — the opening primitive

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
    let result = apply_to_local_graph(mutation)
    broadcast_to_peers(peers, mutation)
    resume(result)
  },
  graph_resolve_conflict(local, remote) => {
    // Verify-on-write: if both compatible, both apply (last-mutation-wins
    // is fine because Verify already ran). If incompatible, surface as
    // V_Pending; UI prompts the user to choose.
    resume(verify_arbitrated_merge(local, remote))
  }
}
```

**Pre-existing substrate composed:** `graph.mn` (graph mutations);
`infer.mn` (Verify-on-write); `effects.mn` (row subsumption).
**Zero new ADTs at the kernel level.**

### §3.2 `Hμ.collab.cursor-presence` — cursors as graph nodes

Per Hμ.cursor: `Cursor(Handle, Reason, Float)` is a substrate value.
Each user's cursor is a handle in the shared graph; other users'
cursors render naturally:

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
presence). Presence is automatic graph projection. **In-session
only** — no persistent record of past cursor positions.

### §3.3 `Hμ.collab.permission-row` — RBAC as effect row

```mn
type GraphRegion = GraphRegion(List<Handle>)

effect Permission {
  read_region(region: GraphRegion) -> ()
  mutate_region(region: GraphRegion, mut: GraphMutation) -> ()
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
match the operations they perform. **Industry tool replaced: per-path
branch protection rules in Git hosting.** RBAC is by proof, not by
runtime audit. **In-session enforcement** — git's repo-level access
control still gates push/pull to the repo as a whole.

### §3.4 `Hμ.collab.transport-bridge` — WebSocket / WebRTC / shared-FS

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
as `.mentl/cache/*.kai` files. No protobuf, no JSON-RPC schema
maintenance — the wire format follows the graph schema by
construction.

### §3.5 `Hμ.collab.git-bridge` — integrate with git, don't replace it

The on-disk `.mn` files are canonical (per IE §0.f). Git versions
those files. Mentl reads them at session start, writes them at save,
and synthesizes commit messages from the Reason DAG when the user
commits via the existing git workflow. **Mentl does not replace
git; Mentl makes git smarter.**

```mn
effect Git {
  git_synthesize_commit_message(diff: GitDiff, reason_dag: ReasonDAG) -> String
  git_load_commit_reasons(commit_hash: String) -> List<Reason>
  git_blame_with_reason(file: Path, line: Int) -> (CommitInfo, Reason)
}

handler git_handler {
  // On save: emit Reason DAG → commit message that captures intent
  git_synthesize_commit_message(diff, reason_dag) => {
    let intent_summary = perform walk_reason_dag_for_intent(reason_dag, diff)
    resume(format_commit_message(intent_summary))
  },

  // On load: read prior commit messages back as Reasons attached
  // to the loaded handles. The Reason chain in the new session
  // starts from whatever git tracked.
  git_load_commit_reasons(commit_hash) => {
    let msg = perform git_show_commit_message(commit_hash)
    resume(parse_message_into_reasons(msg))
  },

  // mentl blame extends git blame: the git layer says WHO and WHEN;
  // the Reason layer (loaded from the commit message) says WHY.
  git_blame_with_reason(file, line) => {
    let (commit, line_info) = perform git_blame(file, line)
    let reasons = perform git_load_commit_reasons(commit.hash)
    let line_reason = find_reason_for_line(reasons, line)
    resume((commit, line_reason))
  }
}
```

**What this delivers:**

- **Commit messages stop being aspirational prose.** They synthesize
  from the Reason DAG of changes. "Why this change?" walks back to
  the gradient argmax that proposed it + the developer's `??`
  override decision. The author still edits the message; the
  starting point is the substrate's own causal record.
- **`mentl blame` extends `git blame`.** Git tells you who and when;
  Mentl reads the commit message back as Reasons attached to the
  handles, so you also get why.
- **`mentl --with review_run`** projects diffs as cursor walks over
  the changed handles; reviewers see Mentl's voice over what changed
  alongside their own annotations.
- **Cross-session causal continuity is best-effort, not perfect.**
  In-session Reason chains are full-fidelity; cross-session Reasons
  re-derive from commit messages + current code state. That's enough
  for the value proposition.

**Industry tool composed-with (not replaced): git.** Git keeps doing
durable history, branches, merges, distributed sync, blame,
signing, ecosystem compatibility. Mentl adds the causal layer on
top.

---

## §4 The handler stack

```
edit_session(user_id)
    ~> shared_graph_handler         ← shared substrate (in-session)
    ~> permission_<user_id>         ← per-user RBAC (in-session)
    ~> websocket_collab_transport   ← real-time wire format
    ~> git_handler                  ← bridge to durable history
    ~> cursor_default               ← Hμ.cursor projection
    ~> mentl_default                ← Mentl voice + tentacles
    ~> verify_ledger                ← refinement obligations + conflicts
    ~> wasi_filesystem              ← read .mn / write .mn / read .kai
    ~> diagnostics_handler          ← outermost-with-no-escape
```

Reading top-to-bottom = inner-to-outer trust. The shared_graph_handler
is innermost (highest capability, most trusted); diagnostics is
outermost (no outward escape, sandbox boundary). **`git_handler` and
`wasi_filesystem` are two separate transports for two separate
purposes**: git for durable history; filesystem for the on-disk
canonical files (which git happens to version).

---

## §5 Forbidden patterns (drift modes)

### §5.1 `shared_graph_handler` substrate

- **Drift 9 (deferred-by-omission):** five sub-handles land in
  ordered commits but as one cohesive substrate; named follow-ups
  in positive form for any deferral.
- **Drift 7 (parallel-arrays-not-record):** subscription state is
  one record (`Subscription({region, peers, ...})`).
- **Drift 1 (Rust vtable):** no dispatch table mapping subscription
  types to handler instances; effect ops only.

### §5.2 Cross-session persistence

- **DO NOT build a persistent Reason-chain log.** That was the
  scope-creep that turned this walkthrough into a git-replacement
  proposal. Mentl uses git for durable history; the substrate stops
  at session boundaries (modulo .kai cache for env state).
- **DO NOT emit `branch` / `merge` / `fork` ops on the SharedGraph
  effect.** Branching and merging happen at the git layer (the user
  runs `git checkout -b` and `git merge` like any other git project).
  Mentl's `git_handler` reacts to git's branch state when reading
  files but does NOT model branches in the substrate.
- **DO NOT add cryptographic signing of Reason chain entries.** Git
  signs commits; that's enough. Per-Reason signing would be substrate
  bloat with no compelling differentiator.

### §5.3 Permission row

- **Drift 8 (string-keyed-when-structured):** permission specs are
  ADT (`+Read(GraphRegion) - Mutate(GraphRegion)`), never
  `permissions = "alice:read,write"` strings.
- **Drift 6 (primitive-type-special-case):** `Permission` is not a
  separate concept — it IS a typed effect row over (user × region).
- **Foreign-framework drift:** not GitHub teams API; not LDAP roles;
  not OAuth scopes; not casbin. The row algebra IS the auth system.
- **Repo-level access control stays git's job.** Mentl's permission
  row gates per-region within a shared session; git still controls
  who can push to the repo at all.

### §5.4 Transport bridge

- **Drift 38 (mascot-as-namespace):** `mentl_collab_transport` is
  drift; `websocket_collab_transport` / `webrtc_collab_transport` /
  `shared_fs_collab_transport` name what they ARE.
- **Drift "API versioning":** no `protocol_version: 1` field on
  mutations; the wire format follows graph schema.

### §5.5 Git bridge

- **DO NOT reimplement git in Mentl.** The bridge composes on top
  of system git via `git_handler` performs that shell out to `git`
  CLI commands (or libgit2 bindings). The bridge is a thin layer.
- **DO NOT make Mentl require git.** Solo work / quick prototypes
  / non-git workflows function fine without `git_handler` installed
  — same as today. `git_handler` is opt-in capability.
- **AI/agent vocabulary** (per developer-experience vision): not
  "AI synthesizes commit message" — "Mentl synthesizes commit
  message from the Reason DAG" / "the Reason DAG is the substrate
  for the commit message."

### §5.6 Generalized fluency-taint check

Pattern came from Live Share architecture / Yjs CRDT semantics /
GitHub branch-protection design? Restructure until it composes from
the eight kernel primitives + git. **The shape Mentl draws is not
"Live Share but with refinement types" — it's the substrate-cited
form that Live Share can't produce because Live Share doesn't have
a substrate to cite.**

---

## §6 Sub-handle decomposition

Five peer handles. Each its own commit; this walkthrough specifies
the full substrate. Ordering by dependency:

| Order | Handle | Composes on | Lines (estimate) |
|---|---|---|---|
| 1 | **Hμ.collab.shared-graph-handler** | Phase μ + graph.mn | ~250 |
| 2 | **Hμ.collab.transport-bridge** | shared-graph-handler + Hμ.cursor.transport | ~150 (per variant; 3 variants WebSocket/WebRTC/shared-FS) |
| 3 | **Hμ.collab.cursor-presence** | shared-graph-handler + Hμ.cursor | ~120 |
| 4 | **Hμ.collab.permission-row** | shared-graph-handler + effect row | ~180 |
| 5 | **Hμ.collab.git-bridge** | shared-graph-handler + WASI shell-out | ~250 |

**Total: ~1250-1400 lines `.mn` across 5+ commits.** Smaller than
the previous git-replacement scope by design.

---

## §7 Acceptance tests

**AT-COLLAB.1 — Two transports, one graph (real-time co-edit).**
Two `mentl edit` sessions attach to the same project URL. User A
types in `module_a.mn`; user B sees the mutation propagate within
transport latency. Both cursors visible to both users.

**AT-COLLAB.2 — Verify-arbitrated concurrent mutation.** Two users
mutate the same handle concurrently. Verify-on-write checks both;
if compatible, both apply; if incompatible (refinement / ownership /
row violation), surface as V_Pending diagnostic with both candidates.

**AT-COLLAB.3 — Cursor presence.** User A's cursor moves; user B's
medium projects the new position within transport latency. Hover
on A's cursor shows `Reason::AuthoredBy(alice, ...)` (in-session).

**AT-COLLAB.4 — Permission denied is type error.** User Bob's
handler installs with `permission_bob` row that lacks
`+Mutate(secret_region)`. Bob attempts `graph_bind` in the secret
region. Compile fails with `E_PermissionDenied` at handler install.
**No runtime check; type-level proof.**

**AT-COLLAB.5 — Git commit message synthesizes from Reason DAG.**
User A makes 3 changes within a session, hits `git commit`. The
`git_handler` walks the Reason DAG, synthesizes a structured commit
message (intent summary; affected handles; capability changes; key
Reasons). The author edits the message starting from the substrate's
own causal record.

**AT-COLLAB.6 — `mentl blame` extends `git blame`.** User reads a
file, asks "why is line 42 the way it is?". `mentl --with blame_run
file.mn:42` runs git blame to find the commit, then loads the
commit message back as a Reason. Output: who (git) + when (git) +
why (Mentl-derived from commit message).

**AT-COLLAB.7 — Offline-then-resume.** User A goes offline (collab
transport disconnects). A continues editing via local graph_handler.
A reconnects; transport replays accumulated in-session mutations to
peers; peers apply + verify. **Local-first; sync is opt-in handler
swap.**

**AT-COLLAB.8 — Capability-stack-as-security.** Install
`~> read_only_collab` outside `shared_graph_handler` and inside
the user's transport. Attempting `graph_publish` fails at handler
install — by row subsumption, not by runtime policy.

**AT-COLLAB.9 — Mentl works without `git_handler` installed.** Solo
project, no git in the chain, just `wasi_filesystem`. Same Mentl;
same kernel; no commit-message synthesis or `mentl blame`. The
git_handler is opt-in capability, not a requirement.

---

## §8 Disintermediation map (scoped, post-revision)

What COLLAB genuinely replaces — the in-session real-time category.

| External system | What it does | What COLLAB does instead |
|---|---|---|
| Live Share / Replit collab / VS Code Live Share | Real-time co-edit | Two transports → one shared graph_handler |
| Tuple / Pop / Around | Cursor presence + voice (voice is orthogonal) | Each cursor IS a graph node; presence is automatic projection |
| Per-path branch protection rules | Coarse RBAC over paths | Effect row `+Mutate(region) - Read(other_region)` per user; row subsumption proves enforcement |
| In-editor pair chat overlays | Discussion attached to changes (in-session) | Reason chain entries within session (`Reason::DiscussionThread(handle, [...messages])`) |

**What COLLAB explicitly does NOT replace** (composes-with via `git_handler`):

| External system | Stays as | Why |
|---|---|---|
| **Git** | First-class transport for durable history | Git is mature, ubiquitous, ecosystem-compatible. Building a Mentl-native VCS would duplicate it with no compelling differentiator. |
| **GitHub / GitLab MR review** | Where reviewers comment | The on-disk `.mn` files are canonical; git diffs them; review tools view diffs. Mentl extends review with `mentl --with review_run` for cursor walks over diffs, but the review platform stays. |
| **rr / Pernosco / time-travel debuggers** | External tools | Cross-session replay would need persistent Reason logs (out-of-scope). Within-session step-back is via the trail. |
| **Linear / Jira issue trackers** | External; cross-link via commit messages | Issues live in their tools; commit messages reference them; `git_handler` reads the references. |
| **codemod scripts (jscodeshift, fastmod)** | External tools | Cross-repository refactor is git's domain. Within a Mentl project, the graph already knows dependents (Reason chain reverse-walk handles it natively). |

The disintermediation claim is now scoped: **COLLAB makes real-time
co-edit + per-region RBAC + cursor presence + in-session causal
discussion structurally uncompetitive against the tools that
currently provide them**. Git stays. Issue trackers stay.
Cross-session time-travel debugging stays external.

---

## §9 Sequencing — substrate file order

1. `src/types.mn` — add `GraphRegion`, `GraphMutation`, `Subscription`,
   `Resolution`, `CommitInfo` ADTs (~25 lines)
2. `lib/runtime/collab_pack.mn` — Pack/Unpack for graph mutations
   over wire (~80 lines)
3. `lib/collab/shared_graph_handler.mn` — Hμ.collab.shared-graph-handler
   (~250)
4. `lib/collab/cursor_presence.mn` — Hμ.collab.cursor-presence (~120)
5. `lib/collab/permission_row.mn` — Hμ.collab.permission-row (~180)
6. `lib/collab/transport_websocket.mn` — variant 1 (~150)
7. `lib/collab/transport_webrtc.mn` — variant 2 (~150)
8. `lib/collab/transport_shared_fs.mn` — variant 3 (~150)
9. `lib/collab/git_bridge.mn` — Hμ.collab.git-bridge (~250)
10. `src/main.mn` — entry-handler aliases (`collab_run`) (~20)
11. `docs/errors/E_PermissionDenied.md`, `E_ReasonChainConflict.md`
    (~50 each)

**Total: ~1500-1700 lines `.mn` + ~100 lines docs across ~11 commits.**

---

## §10 What COLLAB does NOT cover

- **Persistent mutation history across sessions.** In-session only.
  Use git for durable history.
- **Branch / merge / fork at the substrate level.** Use git.
- **Cross-session time-travel debugging.** Use rr / Pernosco / git
  bisect. Within-session rollback via the trail substrate.
- **Cryptographic signing of Reason chain entries.** Use signed git
  commits.
- **Cross-repository refactor.** Use git + codemod tools.
- **Voice / video chat.** Orthogonal; handlers over Audio + Video
  effects compose alongside.
- **Mobile clients.** COLLAB substrate is transport-agnostic; mobile
  is a `transport-bridge` variant.
- **Cross-language collab** (Mentl + non-Mentl participants). Out of
  v1 scope.

---

## §11 What closes when COLLAB lands

After all five sub-handles + the supporting files:

1. **Real-time co-edit works substrate-natively.** Two transports
   on one shared graph_handler. No external collab service required
   for in-session work.

2. **Per-region RBAC is provable.** Effect row composes; row
   subsumption proves enforcement at handler install. **No more
   "did the policy actually grant the right thing?" audits.**

3. **Cursor presence is automatic.** No separate presence service.

4. **Commit messages stop being aspirational prose.** They
   synthesize from the Reason DAG. The author edits a starting
   point that captures the substrate's own causal record.

5. **`mentl blame` extends `git blame` with WHY.** Git tells you
   who and when; the Reason loaded from commit message tells you
   why.

6. **The collaborative-substrate theorem is operationally
   demonstrable** (per `docs/SUBSTRATE.md` §X.1, scoped). Two
   transports on one graph_handler delivers what's substrate-true
   (real-time + causal + RBAC + presence) without overreaching
   into git's domain.

---

## §12 Connection to the kernel

| Primitive | How COLLAB uses it |
|---|---|
| **#1 Graph + Env** | Shared graph_handler IS the canonical store within session. Each user's cursor IS a graph node. Cross-session: files-on-disk + IC cache. |
| **#2 Handlers + typed resume** | shared_graph_handler is the substrate handler. graph_subscribe uses MultiShot. |
| **#3 Five verbs** | `~>` composes transport + permission + shared_graph + git + cursor + diagnostics. |
| **#4 Boolean effect algebra** | Permission row IS the algebra over (user × region). |
| **#5 Ownership as effect** | Reason chain entries are `own` (in-session). Cursor handles are `ref`. |
| **#6 Refinement types** | `GraphMutation where deps_resolved && rows_compatible` for verify-on-write. |
| **#7 Continuous gradient** | Each cursor's gradient ranks per-user. |
| **#8 HM inference + Reasons** | Reason chain IS the in-session causal record. Cross-session causality re-derives from git commit messages via git_handler. |

**Mentl's tentacle mapping.** The Why tentacle is COLLAB's primary
voice surface within session — every collaboration question walks
the Reason chain. Trace tentacle for ownership across users. Verify
tentacle for conflict diagnostics. Teach tentacle suggests next
moves per cursor. **All eight tentacles fire in COLLAB scenes; none
extend the kernel.**

---

## §13 Cross-references

- `docs/SUBSTRATE.md` §X.1 — Collab-as-substrate theorem (scoped to
  in-session + causal + RBAC + presence)
- `docs/ULTIMATE_MEDIUM.md` §8.6 — Collaboration is what
  `graph_handler` swap delivers (scoped)
- `protocol_developer_experience_vision.md` §"Collab-as-substrate"
  (scoped)
- `ROADMAP.md` Phase Z section
- `docs/specs/simulations/Hμ-cursor.md` (cursor as graph node)
- `docs/specs/simulations/IE-mentl-edit.md` (transport agnosticism;
  text-files-canonical — git versions the files)
- `docs/specs/simulations/EH-entry-handlers.md` (`mentl --with collab_run`
  alias)
- `docs/specs/simulations/CLI-canonical-vocabulary.md` (CLI verb
  catalog)

---

*Mentl integrates with git. Git does durable versioned history.
Mentl adds the causal-and-presence layer on top via a thin
`git_handler` bridge. The substrate scope stops at session
boundaries; the kernel doesn't try to replace what git already does
well.*
