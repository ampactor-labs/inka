# mentl edit — the interaction architecture

> *The cursor, felt.*
>
> Sibling to `DESIGN_SYSTEM.md` (brand, tokens, the visual language — read it
> first; this document assumes it). That brief answers *how Mentl looks*. This
> one answers the prior question: **what is an IDE when the program is a graph,
> text is one projection among many, and the compiler is the intelligence?**
> Design artifact of the felt aspect (PLAN §5.2, band M) — not read-path.

---

## 0 · The thesis

Every IDE ever built is an application wrapped around a text buffer: panels
*about* the code, a compiler *behind* the code, an assistant *beside* the code.
mentl edit inverts this once, cleanly: **the IDE is the program's own
self-projection, pointed at a human.** There is one graph. Inference is its one
writer. The cursor is its one reader. Everything on screen — the text, the
topology lines, the row matrix, the Why chain, the proposals — is the same
single read at a different altitude, and every one of them is *live* because
re-projection on graph delta is the same machinery as incremental compilation
(§4⑦: reactivity IS the cursor's `<~`).

The consequence that governs every design decision below: **panels are not
features. Panels are cursor modes.** Click anything in any projection and the
cursor moves; every other projection re-projects around it. One attention
point, N altitudes, zero synchronization code — the graph is the
synchronization.

And the closing move, the one that makes the design future-proof rather than
merely good: **mentl edit is itself a Mentl program** — the loop in SYNTAX.md's
own composition sketch:

```
keystroke
  |> tokenize
  |> parse_to_graph
  ~> format_default
  ~> render_to_transport
    <~ accumulate(graph)
```

The IDE has no outside, either. There is no plugin API because **the language
is the plugin API**: a theme is a `Render` handler, a keybinding is a handler
on the `Input` effect, a custom pane is a projection function, a "linter" is a
handler on `Verify`. Extending the IDE and writing Mentl are the same act,
which means every extension is *proven* under the same rows as everything else
— a plugin cannot exfiltrate (`!Network` is checkable) and cannot lie about
what it touches. VS Code's extension marketplace is a trust problem; mentl
edit's is a theorem.

---

## 1 · What dissolves — the anti-IDE

Ultimate form is mostly subtraction. Each fixture of IDE-land is a workaround
for a missing kernel fact; Mentl has the fact, so the fixture dissolves.

| IDE fixture | The missing fact it papered over | What replaces it |
|---|---|---|
| **Files & the file tree** | no unit of meaning smaller than a file | Modules are graph regions; the "tree" is one projection query among many (by module, by effect, by owner, by recency-of-Reason). Text files remain the durable *serialization*, not the mental model. |
| **Save** | the program only exists when flushed | The image persists continuously (the bump image + trail — persist is memcpy, §4④). "Unsaved changes" is not a state that exists. Checkpoint replaces save: a *named* moment, not a rescue. |
| **The Run button** | the program is dead until invoked | The program is *live while you write it* (§4 below — the hole is a dormant continuation). "Run" is installing a handler at `main`, one more `~>`. |
| **The error list** | diagnostics as a flat queue | The gradient's **one** highest-leverage next thing (Teach), plus sockets *in place*. A hundred-item Problems panel is attention-DDoS; the medium ranks, so the human never triages. |
| **Breakpoints & the debugger** | no first-class suspension | A hole **is** a breakpoint — a dormant continuation carrying its live value. Debugging is editing at a suspension point; time-travel is the forked cursor scrubbing the trail (band B). One mechanism, not a second product. |
| **Text search / go-to-definition** | the graph existed only in the compiler's head | Graph query: find by *edge*, not by string — "every consumer of this row," "every `own` crossing this boundary," "everything this Reason justified." Definition, references, and rename are one edge-walk. |
| **Diff review** | changes as line edits | Changes as *proof-obligation deltas*: review shows which rows widened, which refinements gained obligations, which `!E` claims a change would break — the diff of what is *promised*, above the diff of what is written. In the machine-code age this is the load-bearing surface: when no human authored it, "looks right" is worthless and the proofs are the review (PLAN §0). |
| **The AI chat panel** | generation without verification | The Lens: proposals are multi-shot candidates that *survived checkpoint → infer → Verify → rollback* before you ever see them. No prompt box, no transcript, no apology. The conversation's unit is the constraint, not the token (§1 of PLAN). |
| **Plugin marketplace** | the tool can't express its own extensions | Handlers (§0 above). |
| **Settings JSON** | configuration outside the medium | Config is handler *state* — inspectable, typed, `mentl why`-able like everything else. |

The rule behind the table: **if a surface exists because text-as-truth lost
information, delete the surface and read the graph.** (The Carried-Truth Law,
applied to UI.)

---

## 2 · The editing loop — free text, canonical form

Structure editors died because they imprisoned the hands; text editors lie
because the shape on the page drifts from the meaning. Mentl's parse layer
already resolves this tension, so the editor inherits the resolution instead
of re-fighting it:

- **Typing is free.** The buffer accepts anything; the parser is
  productive-under-error, so a half-typed arm never kills the rest of the
  graph. The graph is always *mostly live* — the eight aspects keep projecting
  for everything outside the in-flight edit.
- **Canon is projected, never demanded.** On idle, `format_default` re-renders
  the canonical layout (Governing Principle 1: layout is projection). Breaking
  the verb grammar triggers *topology resist* — the gentle elastic snap-back —
  because the shape on the page is the computation graph, and the page defends
  its own truthfulness.
- **Edits are graph transactions.** A keystroke parses to a graph delta;
  inference (the one writer) integrates it; the trail records it. Undo is
  trail-walk, which means undo *works across projections* — undoing a change
  made by dragging a topology edge and one made by typing are the same
  operation in the same history.
- **Format-liftable ceremony vanishes at parse** (`perform`, redundant braces,
  semicolons): the developer sees canon, always, and never a nag about it.

The keystroke→graph latency budget is the whole feel: the current artifact
already compiles small programs in ~half a second on every keystroke with a
*fresh instantiation per compile*; the IC cursor (cached read, epoch-keyed)
turns that into millisecond re-projection of only what the delta touched. The
target is not "fast feedback" — it is **the absence of a feedback moment**:
the projections are simply always current, the way a spreadsheet never has a
"compile" step.

---

## 3 · The surfaces — one cursor, five altitudes

All five are readings of the one cursor; none is a "window" with its own
state. The Teach knob (DESIGN_SYSTEM §9) is the single density control —
the interface's information volume scales with what is proven, never with
what is configured.

1. **The Canvas** — the text projection, center stage. Verb lines physically
   connect pipeline stages; `~>` handlers render as a soft enclosure of the
   chain they govern (a capability *visibly wraps* its scope); `own` values
   carry the amber trace that drains on consume. The Canvas is the projection
   you *write* into; it is not more true than the others, only more writable.

2. **The Aspect ring** — the eight facets at the cursor (DESIGN_SYSTEM §7).
   The one always-on instrument. Each facet is a *door*: click `why` and the
   Wavefront opens on that chain; click `row` and the Ledger scopes to this
   position; click `teach` and the Lens fires on the one next move.

3. **The Lens** — proposals as translucent ghost geometry at a socket, cycled
   with arrows, committed with `Tab`. The Lens is the *only* place the medium
   proposes; everywhere else it answers. (Propose is one tentacle, not the
   whole octopus.)

4. **The Wavefront** — TIME, made scrubbable. Three registers on one strip:
   the **Why-DAG** (provenance of the fact at the cursor — walk any value
   back to the edit, the inference step, or the install that caused it), the
   **trail** (program time when something ran — scrub execution back and
   forth through the forked cursor), and **realities** (the multi-shot
   branches currently alive at a hole — see §4). Past, cause, and possibility
   are one axis with three tick-marks, because in the kernel they are one
   mechanism (the resumable continuation, §4④).

5. **The Ledger** — the capability HUD grown into the **verification
   dashboard** (band M): the ambient row, the ownership budget, the
   refinement obligations with their `V_Pending` states, and — the surface
   the machine-code age actually needs — the **absence proofs**: every `!E`
   claim in scope with its transitive proof walkable ("this whole subtree
   cannot reach the network — here is why, hop by hop"). At editor scale the
   Ledger is a sidebar; pointed at a running system it *is* the product
   (§6).

Mentl herself lives in the seam — the resting presence in a corner, the
narration voice (one line, tinted Mentl Mono, octopus glyph), the microcopy
at sockets. Two voices, never a third.

---

## 4 · The five signature interactions

The ones nothing else can copy, because each is a kernel primitive surfacing —
not a feature bolted on.

### 4.1 · Fill-and-resume — the program runs *while you write it*

A `??` hole is a dormant multi-shot continuation (band M's
`.hole-is-dormant-continuation`; the Hazel lineage, realized on a substrate
where the continuation is a real heap record). So: run a program with holes.
Execution proceeds until the hole, **suspends**, and the IDE shows the live
value *arriving at your cursor* — the actual argument, in the actual run, with
its actual refinements. You write the body against real data, and when you
fill the hole the program **resumes from the suspension** — no restart, no
re-run, no mock. The edit-run loop collapses into a single gesture: the
program is always running; your cursor is just the place where it's currently
waiting for you.

### 4.2 · Constraint sculpting — edit the row, watch the shape move

The DESIGN_SYSTEM §9 hero, named as the primitive it is: annotations are
*inputs to the cursor*, so tightening a constraint re-projects everything
downstream of it. Type `with !Alloc` and the allocating path gains a socket
with proven ways through; delete a `~> Thread` and the fanout's badge falls
back to `Seq`; tighten a refinement and a bounds-check *visibly dissolves*
from the emitted code pane. The developer stops editing *implementations* and
starts editing *promises*, watching implementations rearrange to keep them.

### 4.3 · The Why walk — every fact has a receipt

Click any fact anywhere — a type in the Aspect ring, a row entry in the
Ledger, an error's claim, a proposal's precondition — and the provenance ink
draws: the chain of Reason edges from this fact back to the edit, install, or
axiom that minted it. No fact in the interface is ever *asserted*; every one
is *walkable*. This is PLAN §0's "systems explain themselves" as a gesture:
the medium never says *trust me*, it says *follow me*.

### 4.4 · Reality scrubbing — hold N futures at once

The multi-shot exploration made felt. At any hole or decision point, ask for
realities: Synth multi-shots the constraint space and the survivors (only the
proven survive the gauntlet) appear as **parallel branches on the Wavefront**
— each one a live, resumable image, not a text diff. Scrub between them and
the Canvas morphs; pin two side-by-side and the Ledger diffs their *promises*
(this branch stays `!Alloc`, that one buys speed with an arena); `Tab` commits
one and the others dissolve. Exploration stops being "try, undo, try" —
it becomes *holding the alternatives simultaneously*, the way the oracle
already does internally, one fork per cursor.

### 4.5 · The proof surface — review what it *won't* do

Select any boundary — a function, a module, a handler install — and ask for
its negative space: the transitive absence proofs (`!Network`, `!Alloc`,
`!Mutate`, the IFC non-flows once band C lands). The proof unrolls as an
enclosure on the Canvas: everything inside this line, proven incapable of
that. This is the review surface for code no human wrote, the oversight
surface for systems no human can hold, and the demo that lands the thesis in
ten seconds — because no other system on earth can draw that line and mean
it.

---

## 5 · Domains inline — DSP and ML as first-class projections

The projection architecture makes domain views cheap: a value whose *type*
carries domain meaning gets a domain *projection*, in place, live.

- **A `<~` feedback loop renders an oscilloscope** at the expression — the
  actual signal, because the program is running (§4.1). A `Sample`-rowed
  pipeline offers a spectrum view; a `Hz` refinement draws its bound on the
  scope. The DSP author never leaves the medium to "check in the DAW."
- **Refined parameters are scrubbable** — a value typed `Float where 0.0 <=
  self <= 1.0` renders as a slider *whose ends are the refinement*. Dragging
  it is a graph edit; every projection downstream updates live. The
  Bret-Victor dream, but the slider's bounds are *proven*, not decorated.
- **Autodiff-as-multishot** (band B) makes training loops scrubbable the same
  way: gradient flow is edge-flow on the same graph, the Wavefront scrubs
  epochs the way it scrubs execution, and a diverging loss is a fact with a
  Why chain like any other.

The rule: **domain tooling is not an extension category; it is the type
system reaching the screen.** A new domain arrives by declaring its types and
handlers, and the projections follow.

---

## 6 · Sessions, collaboration, and the console at scale

- **A session is an image.** Close the tab: the image persists (memcpy).
  Reopen: resume, cursor where you left it, realities still branched. A **bug
  report is the image itself** — not a repro recipe but the actual suspended
  moment, Reasons intact, resumable on the maintainer's machine (band B's
  cross-machine resume). "Works on my machine" dissolves — the machine state
  *ships*.
- **Collaboration is two cursors on one graph** (Grove-style CMRDTs over the
  *typed* graph, band M): merge conflicts happen at the level of meaning, not
  lines — two edits to independent subgraphs never conflict, however
  interleaved their text serialization would be. A collaborator's cursor is a
  second attention point whose Aspect ring you can peek; teaching is
  *sharing a Why walk*.
- **At scale, mentl edit is the oversight console** (PLAN §0 pt 5). The same
  surfaces, pointed at a running fleet: the Ledger's absence proofs as the
  security posture, live; the Wavefront's trail as the incident scrubber; a
  hole in production as a suspended incident waiting for a proven fill,
  deployed as a resume. The editor and the console are one artifact because
  editing and overseeing are one read at two altitudes.

---

## 7 · The road from today — each surface has a substrate gate

What exists (2026-07-10): the browser IDE runs the fixpoint compiler itself —
keystroke→compile→project, clickable diagnostics, emitted WAT + stats, served
by Mentl (`ide/serve.mn`). Honest and real, and altitude-zero.

The build order composes with the standing 2→1→3 sequence (scratch
dissolution → multi-shot → binary emit), because the felt surfaces are
projections of exactly those substrates:

| Surface | Substrate gate | Band |
|---|---|---|
| In-page run (programs execute in the IDE) | the wheel emits wasm **binary** directly — no external assembler | N (binary emit) + `Hβ.felt.ide-run-in-page` |
| Fill-and-resume, reality scrubbing, trail scrub | the multi-shot producer (reify + resume) | B |
| Session-as-image, bug-report-as-image | persist-equals-memcpy over the image-map fold | B + D (`Hβ.emit.image-map-fold`) |
| Millisecond re-projection (the IC feel) | the cached cursor / epoch-keyed reads | G / cursor |
| The Ledger's absence proofs | `sound-neg-under-poly` (the crown) | A |
| Verb lines, Aspect ring, Why walk, Lens | the graph + Reasons already carry it — **projection work, no new substrate** | M, buildable now |
| Collaboration | Grove CMRDT over the typed graph | M |
| The oversight console | all of the above, pointed at a fleet | the horizon |

The honest reading of that table: the *middle* of the experience (Aspect ring,
Why walk, verb lines, the Lens on today's Synth) is buildable against the
current graph — it is rendering work. The *magic* (fill-and-resume, realities,
image sessions) is gated on band B, which is why the multi-shot producer is
the highest-leverage dig in the whole project: it is simultaneously the
kernel's TIME axis and the IDE's soul.

---

## 8 · UX drift table — refusals

The DESIGN_SYSTEM §12 table governs looks; this one governs *interaction*
imports from IDE-land.

| Don't (imported fixture) | Do (kernel-honest) |
|---|---|
| A Problems panel with 200 entries | One Teach step + sockets in place; the medium ranks |
| Modal "are you sure" dialogs | The trail: everything is undoable, so nothing needs a gate |
| A run/debug mode split | One live program; holes are the suspension points |
| Config pages, settings JSON | Handler state, edited like any value, Why-walkable |
| A plugin API + extension review | Handlers under rows; capability is the review |
| An AI chat transcript | The Lens; constraints in, proofs out; no transcript to scroll |
| Spinners and progress bars | The medium is either current (IC) or shows *which region* is re-projecting on the Canvas itself |
| "Sync" indicators for collab | One graph; presence is a second cursor, not a sync state |
| Feature-count growth | Projection-count growth — every new surface must name the read it projects |

The keystone, restated for interaction: **every affordance is a read or a
draw-an-edge on the one graph. If a proposed feature is neither, it is
decoration, and it goes in the sea.**
