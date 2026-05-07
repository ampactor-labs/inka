# CLI — Canonical Vocabulary

*The single reference for what the developer types at the shell to
reach Mentl. Subsumes scattered references in F.1 / IE / EH /
plan §99 / traces/a-day / current main.mn. Sharpens drift 38
(mascot-as-command-prefix per `tools/drift-patterns.tsv`) by
distinguishing project-action verbs from tentacle-name verbs.*

**Handle:** CLI (cross-cutting reference; not a cascade handle).
**Status:** 2026-05-07 · seeded.
**Authority:** `EH-entry-handlers.md` (substrate — `mentl --with <name>`
universal form, alias resolution, entry-handler convention),
`F1-mentl-doc.md` (`mentl doc` semantics), `IE-mentl-edit.md`
(`mentl edit` semantics), `ROADMAP.md` Non-Negotiable #6 (canonical
verb form), `protocol_developer_experience_vision.md` §"CLI canonical"
(drift 38 sharpening), `docs/ULTIMATE_MEDIUM.md` §8.7 (CLI canonical).
**Walkthrough peers:** `EH-entry-handlers.md` (the substrate this
references), `IE-mentl-edit.md` + `F1-mentl-doc.md` + `MV-mentl-voice.md`
(the surface walkthroughs).

---

## §0 Framing — what this canonicalizes

Three things the corpus had scattered before this doc:

1. **The universal CLI pattern.** Per `EH-entry-handlers.md` §1.2:
   `mentl --with <handler>` is universal; subcommands are aliases
   that resolve through env lookup. Entry-handlers are normal
   `handler` declarations at top level in `src/main.mn` (or any
   imported module). No config files. No manifests. No YAML / TOML
   / JSON. Adding a new subcommand = adding a new entry-handler
   (+ optional alias in `parse_cli_args`).

2. **The complete canonical verb catalog.** EH gave 9 verbs;
   F.1 added `mentl doc`; IE added `mentl edit`; plan §99 added
   `mentl run / test / chaos`. **No single document had the union**
   until now. The canonical catalog appears in §2 below.

3. **Drift 38 — when `mentl <verb>` is canonical vs drift.**
   Earlier guidance was ambiguous ("`mentl <verb>` is canonical"
   per ROADMAP non-neg #6 conflicted with "drift 38 fires on
   `mentl <verb>`" in `tools/drift-patterns.tsv`). Resolution in §3:
   project-action verbs are canonical; tentacle-named verbs that
   shadow at-cursor projections are drift.

This doc is a **reference**, not a substrate spec. EH owns the
substrate. CLI-canonical-vocabulary.md owns the catalog + the drift
line.

---

## §1 The universal pattern

Per `EH-entry-handlers.md` §1.2:

```
mentl                                  # bare; defaults to --with teach_run
mentl <subcommand> [args...]           # alias for --with <subcommand>_run [args]
mentl --with <handler_name> [args]     # explicit; resolves <handler_name> via env_lookup
mentl --with <handler>(<arg>=<val>...) # explicit with constructor-style arguments
```

**Resolution rule for `--with <name>`** (per EH §1.2):

1. Parse `<name>` into `symbol_name` + optional `argument_list`
   (e.g., `chaos_run(seed=42)` → `chaos_run` + `[seed=42]`).
2. Resolve `symbol_name` against the current project's module graph
   (same as any identifier resolution: project-local first, then
   `lib/`, then imports).
3. If resolved symbol is NOT a handler, error: `E_EntryHandlerNotAHandler`.
4. If argument count / types don't match handler's signature, error:
   `E_EntryHandlerArgsMismatch`.
5. Install the handler via `~>` wrapping `main()`; invoke.
6. If `<name>` doesn't resolve: `E_EntryHandlerNotFound` with
   Mentl's Propose tentacle suggesting candidate entry-handlers
   from the module graph.

**Why this dissolves separate config files** (per
`protocol_developer_experience_vision.md` §"What you can build"):

- `Cargo.toml` / `package.json` build profiles → multiple `*_run`
  handlers in `main.mn`
- `jest.config.js` / `pytest.ini` test runners → `test_run` handler
  with `~> assert_reporter` + `~> verify_assert`
- `docker-compose.yml` / `Procfile` deploy targets → `production_run`
  / `staging_run` / `chaos_run` handlers
- `.github/workflows/*.yml` CI variants → user-defined entry-handlers
  invoked via `mentl --with`

Every variation becomes a named handler in normal Mentl code. No
manifest layer. No YAML. **The CLI dissolves into handlers.**

---

## §2 The canonical verb catalog

Subcommand aliases resolve to entry-handlers per EH alias table.
**Bold rows** are the most-used surfaces; non-bold rows are
canonical but less frequent.

### §2.1 Interactive surfaces (medium opens)

| Bare invocation | Resolves to | Surface | Authority |
|---|---|---|---|
| `mentl` (bare) | `--with teach_run` | Terminal voice surface; gradient narration; one suggestion per turn | EH §1.2 |
| **`mentl edit [path] [--port=N]`** | `--with edit_run` | **Browser-WASM canonical IDE** (Topographic Canvas + Capability HUD + Wavefront + Holographic Lens) | IE §0 |
| `mentl serve` | `--with lsp_run` | LSP transport on stdio (vim / helix / VSCode + Mentl extension) | IE §0 + MV |
| `mentl repl` | `--with repl_run` | Line REPL over current env | EH §1.2 |

### §2.2 Batch projections (single gradient-pop, exit)

| Bare invocation | Resolves to | What runs | Authority |
|---|---|---|---|
| **`mentl run <target>`** | `--with compile_run + wasmtime` | Compile to WAT + execute | EH §1.2 |
| **`mentl compile <target>`** | `--with compile_run <target>` | Emit WAT to stdout | EH §1.2 |
| **`mentl check <target>`** | `--with check_run <target>` | Diagnostics; no emit | EH §1.2 |
| **`mentl test [target]`** | `--with test_run [target]` | Test handler chain (`assert_reporter` + `verify_assert`) | EH §1.3 |
| `mentl audit <target>` | `--with audit_run <target>` | Capability set + severance suggestions | EH §1.2 |
| `mentl query <target> <q>` | `--with query_run <target> <q>` | Structured ad-hoc query | EH §1.2 + a-day |
| `mentl chaos(seed=N) <target>` | `--with chaos_run(seed=N)` | Chaos engineering test handler chain | plan §99 |
| `mentl deterministic <target>` | `--with deterministic_run <target>` | Deterministic build (sorted allocation; for first-light L1 byte-identity) | EH §1.2 |

### §2.3 Documentation surface

| Bare invocation | Resolves to | What runs | Authority |
|---|---|---|---|
| **`mentl doc [target] [--target=md\|html\|llms\|terminal] [--serve]`** | `--with doc_run` | Documentation projection (handler chain on the same compile pipeline; renders verbatim `///` author voice + Mentl's substrate-derived voice) | F.1 §0 + §3 |
| `mentl doc --crucibles` | `--with doc_run + crucibles filter` | Crucibles index; per-crucible disintermediation + compile-status badge | F.1 §6.3 |

### §2.4 Project lifecycle

| Bare invocation | Resolves to | What runs | Authority |
|---|---|---|---|
| `mentl new <name>` | `--with new_project(name=<name>)` | Scaffold from `lib/tutorial/00-hello.mn`; create `.mentl/` cache dir | EH §1.2 |

### §2.5 Universal escape hatch

| Bare invocation | Resolves to | When |
|---|---|---|
| `mentl --with <handler_name> [args] [target]` | direct handler resolution | Any user-defined entry-handler in `main.mn` or imported modules |

---

## §3 Drift 38 — sharpened

**Drift 38: mascot-as-command-prefix** (per `tools/drift-patterns.tsv`).
The drift fires when a CLI verb shadows a tentacle name AND the
verb's intended semantics OVERLAPS the at-cursor projection of that
tentacle. The drift does NOT fire on project-action verbs that
happen to be Mentl-prefixed (the binary IS named Mentl; subcommand
prefix is structural).

### §3.1 Project-action verbs — canonical (not drift 38)

These are PROJECT-ACTION verbs. They name actions Mentl performs
on a project as a whole (compile / check / test / deploy / etc.).
They happen to be subcommands of the `mentl` binary; the prefix is
structural like `git commit` or `cargo build`, not mascot-as-namespace.

```
mentl edit / doc / run / compile / check / test / audit / serve /
new / repl / chaos / deterministic
```

### §3.2 Tentacle-name verbs — borderline (case-by-case)

The eight tentacles are: **Query / Propose / Topology / Unlock /
Trace / Verify / Teach / Why** (per CLAUDE.md anchor + DESIGN §0.5
+ Hμ.cursor `CursorView`).

Two tentacle names appear in the canonical catalog:
- `mentl teach` → `teach_run` (terminal voice surface; the
  project-action of "narrate the gradient at-cursor")
- `mentl query` → `query_run` (structured ad-hoc query;
  project-action of "ask Mentl about this position structurally")

These are **canonical** because they name PROJECT-ACTIONS the
developer performs from the shell on a target file. The verb is
the action; the tentacle is the at-cursor projection. They share a
name because the action invokes the tentacle.

The other six tentacle names (**Propose / Topology / Unlock /
Trace / Verify / Why**) do NOT have canonical CLI verbs because
those projections fire AT-CURSOR INSIDE the medium (per `Hμ.cursor`
+ `cursor_default`), not as separate actions a developer types
from the shell. Wrapping them as CLI verbs would shadow the
in-medium projection — drift 38.

### §3.3 What drift 38 fires on (forbidden CLI verbs)

The six tentacle-named CLI verbs that lack canonical project-action
peers — Trace, Why, Propose, Unlock, Verify, Topology — would shadow
their at-cursor projections if used as `mentl <tentacle>` commands.
The drift catalog (`tools/drift-patterns.tsv` mode 38) enumerates
the literal regex pattern.

| Forbidden verb | Why drift | What to use instead |
|---|---|---|
| `<binary> trace` | Trace tentacle fires AT-CURSOR for ownership diagnostics | (no CLI verb — fires at-cursor; project-level `mentl audit` reveals) |
| `<binary> why` | Why tentacle walks the Reason DAG AT-CURSOR | (no CLI verb — hover in `mentl edit` / LSP `textDocument/hover`; project-level `mentl query <module> "why <thing>"`) |
| `<binary> propose` | Propose tentacle fires the Holographic Lens AT-CURSOR | (no CLI verb — Lens fires inside `mentl edit`, the Web IDE) |
| `<binary> unlock` | Unlock tentacle surfaces capability gates AT-CURSOR | (no CLI verb — fires at-cursor; project-level revealed by `mentl audit`) |
| `<binary> verify` | Verify tentacle surfaces V_Pending refinement obligations AT-CURSOR | `mentl check <target>` IS canonical — check is a project-action invoking the Verify tentacle across the project, distinct from per-position at-cursor projection |
| `<binary> topology` | Topology tentacle suggests pipe restructurings AT-CURSOR | (no CLI verb — fires at-cursor) |

(Table uses `<binary>` placeholder where the literal `mentl
<tentacle>` would itself trigger drift 38; the pattern enumeration
lives in `tools/drift-patterns.tsv` mode 38 regex.)

### §3.4 The line drift 38 draws

| At-cursor (inside the medium) | CLI verb (project-action) |
|---|---|
| Query tentacle: rendering what the graph knows at this position | `mentl query <target> "<question>"` — structured ad-hoc query |
| Propose tentacle: Holographic Lens fires multi-shot proven candidates as ghost text | (no CLI verb — Lens fires inside `mentl edit`, the Web IDE) |
| Topology tentacle: suggesting `\|>` chain over nested calls at cursor | (no CLI verb — fires at-cursor) |
| Unlock tentacle: "adding `!Alloc` would unlock CRealTime" at cursor | (no CLI verb — fires at-cursor; revealed by `mentl audit` projection at the project level) |
| Trace tentacle: ownership diagnostics + proven fix at cursor | (no CLI verb — fires at-cursor; revealed by `mentl audit` at project level) |
| Verify tentacle: pending V_Pending refinement obligations at cursor | `mentl check <target>` — project-wide diagnostic projection |
| Teach tentacle: ONE highest-leverage next-step at cursor | `mentl teach <target>` — terminal voice surface (peer to in-medium) |
| Why tentacle: walking the Reason DAG from a clicked element | (no CLI verb — Why-walk happens inside `mentl edit` / via LSP hover) |

**Reading the table:** the at-cursor projection is the rich,
context-aware surface; the CLI verb (where one exists) is the
project-level batch projection invoking the same substrate.
**`mentl audit` and `mentl check` are aggregations**, not the
tentacles themselves. **`mentl teach` and `mentl query` are
terminal-mode peer transports** for the same projections that
fire inside the medium.

---

## §4 The eight interrogations applied

Per CLAUDE.md / DESIGN.md §0.5 / Mentl's anchor.

| # | Interrogation | Answer for the CLI |
|---|---|---|
| 1 | **Graph?** | The CLI parses `argv` into an `EntryHandlerInvocation` ADT (per EH §1.4) and resolves the named handler through env_lookup. The CLI itself is a graph projection: argv → handler symbol → handler chain wrap → main() invocation. |
| 2 | **Handler?** | Each canonical verb resolves to an entry-handler (`compile_run`, `edit_run`, etc.). The handler IS the verb's semantic. Adding a new verb = adding a new handler. |
| 3 | **Verb?** | Inside each entry-handler, the body is a `~>` chain composing the handler stack for that mode. The five verbs draw the topology; the CLI doesn't add new verbs. |
| 4 | **Row?** | Each entry-handler declares its effect row: `compile_run with IO + Filesystem + Alloc`; `test_run with IO + Filesystem + Alloc + Test`; etc. Row subsumption proves install compatibility with `main()`. |
| 5 | **Ownership?** | Entry-handlers can carry `own` state (test counters, chaos seeds). `argv` is `own` parsed once; mode is `own`; dispatch consumes. |
| 6 | **Refinement?** | `DocPort = Int where 1024 <= self <= 65535` for `--port` arg; `ProjectPath = String where valid_project_path(self)` for `<target>` arg. Refinements propagate; `verify_ledger` discharges. |
| 7 | **Gradient?** | `mentl --with <unknown>` triggers `E_EntryHandlerNotFound` with Propose tentacle surfacing candidate entry-handlers ranked by gradient (closest match by name + argument shape). |
| 8 | **Reason?** | Every CLI invocation leaves `Reason::DispatchedFromArgv(argv, mode)` in the graph. Why Engine walks back from any production-time question to "why did this code run under this handler stack?" — answer: the CLI invocation + alias resolution. |

All eight clear. Residue: the canonical verb catalog (§2) + the
drift 38 line (§3). Each named below.

---

## §5 Forbidden patterns per CLI surface

### §5.1 main.mn argv parsing

- **Drift 8 (string-keyed-when-structured / int-coded-when-ADT):** `--with <name>` parses into structured `EntryHandlerInvocation` ADT; never `mode == 0/1/2` int dispatch.
- **Drift 5 (C calling convention):** no `int argc, char **argv` style raw thread; arguments parse into `EntryHandlerInvocation` first.
- **Drift 1 (Rust vtable):** no dispatch table mapping subcommand strings to fn pointers. Use ADT match in `parse_cli_args`; let the resolver invoke handlers via `--with`.
- **Drift 9 (deferred-by-omission):** all 12 canonical verbs (per §2) wired in one `parse_cli_args` rewrite; no "register edit, doc, etc. later."

### §5.2 Help text / `print_help`

- **Drift 38 (mascot-as-tentacle-prefix):** never print the six tentacle-name verbs (Trace, Why, Propose, Unlock, Verify, Topology) as `mentl <tentacle>` commands in help text — those are at-cursor projections per §3.3 above.
- **AI/agent/completion vocabulary** (per `protocol_developer_experience_vision.md` §"AI obsolescence"): help text uses "the medium proposes" / "Mentl narrates" / "Holographic Lens projects" — never "AI suggests" / "agent completes" / "model generates".
- **Hedging vocabulary**: never "may want to" / "might consider" / "perhaps". The medium either has substrate to surface a suggestion (silence_predicate fails) or it doesn't (silence_predicate passes; nothing surfaces).

### §5.3 Error messages

- **`E_EntryHandlerNotFound`** must surface candidate entry-handlers via Propose tentacle (per EH §1.2). Never just "command not found" — the Propose tentacle reads the module graph and ranks candidates.
- **`E_EntryHandlerArgsMismatch`** must show declared signature + supplied arity (per EH error catalog).
- **`E_CliParseError`** is the honest default for unparseable argv; never fabricate an `Invocation(...)` with placeholder fields.

### §5.4 Adding a new CLI verb

To add `mentl deploy <target>`:
1. Declare `handler deploy_run with <required-row> { ... }` at top level in `src/main.mn`.
2. Add alias to `parse_cli_args`: `["deploy", target] => Invocation("deploy_run", [], Some(target))`.
3. (Optional) document in this catalog (§2) + SYNTAX.md alias table.
4. Drift-audit clean.

That's the full surface. **No config file. No registry. No manifest.**

---

## §6 What this doc DOES NOT cover

- **CLI substrate implementation** — see `EH-entry-handlers.md` §1.4 for the `src/main.mn` rewrite (argv parsing, `EntryHandlerInvocation` ADT, `install_entry_handler` resolver).
- **Per-verb semantics** — see the per-walkthrough specs:
  - `IE-mentl-edit.md` for `mentl edit` (browser-WASM IDE)
  - `F1-mentl-doc.md` for `mentl doc` (documentation projection)
  - `MV-mentl-voice.md` for `mentl teach` (terminal voice surface)
  - EH §1.3 for `mentl test` (Test effect + handlers)
- **Web IDE / browser transport** — `IE-mentl-edit.md` + `IDE-playground-vision.md`.
- **LSP transport** — `MV-LSP-adapter.md`.
- **Project template scaffolding** — `mentl new` references `lib/tutorial/00-hello.mn`; the scaffold logic is per-project handler composition.
- **Argument parser internals** — handled in EH; this doc references the contract.

---

## §7 Cross-references (the doc loop)

This doc is referenced from:

- `CLAUDE.md` red-flag table (drift 38 row); JIT triggers (CLI work)
- `docs/ULTIMATE_MEDIUM.md` §8.7 (CLI canonical table)
- `ROADMAP.md` Non-Negotiable #6 (`mentl <verb>` canonical clarification)
- `README.md` (three first-class transports)
- `protocol_developer_experience_vision.md` §"CLI canonical" (the vision throughline)

This doc references:

- `docs/specs/simulations/EH-entry-handlers.md` (substrate)
- `docs/specs/simulations/IE-mentl-edit.md` (mentl edit)
- `docs/specs/simulations/F1-mentl-doc.md` (mentl doc)
- `docs/specs/simulations/MV-mentl-voice.md` (mentl teach)
- `docs/specs/simulations/MV-LSP-adapter.md` (mentl serve)
- `tools/drift-patterns.tsv` (drift 38 entry)

---

## §8 Closing

The CLI is a thin shell over entry-handlers. **Twelve canonical
project-action verbs**; **one universal `--with <handler>` form**;
**six tentacle names that do NOT become CLI verbs because their
projections fire AT-CURSOR**. Drift 38 fires precisely on the
six. Project-action verb mascot prefix is structural, not drift —
the binary is named Mentl, like `git` is named git and `cargo` is
named cargo.

When the CLI redesign lands in `src/main.mn` (task #76), this doc
is the canonical vocabulary it implements. Adding a verb = adding
a handler in `main.mn` + (optionally) an alias in `parse_cli_args`
+ documenting here. **No other code changes.**
