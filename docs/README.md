# Inka Documentation

*One pipeline. Many handlers. Each doc below is a view on the same
substrate, rendered for a different audience.*

---

## Reading order

If you've never seen Inka before:

1. [`../README.md`](../README.md) — the 2-minute "what is this" pitch.
2. [`DESIGN.md`](DESIGN.md) — the full manifesto. What Inka IS. Long,
   but every section is self-contained.
3. [`INSIGHTS.md`](INSIGHTS.md) — consequences of getting the
   foundations right. Deep truths. Read after DESIGN.

If you want to contribute or pick up the codebase:

1. [`PLAN.md`](PLAN.md) — **THE plan.** Current phases, status, the
   rebuild. Singular and authoritative.
2. [`ARCS.md`](ARCS.md) — narrated development history.
3. [`../AGENTS.md`](../AGENTS.md) — agent handoff (build commands,
   known state). May trail reality; cross-check with PLAN.md.
4. [`../bootstrap/README.md`](../bootstrap/README.md) — stage 0 → 1 → 2
   build recipe.

If you're implementing a phase:

1. [`rebuild/00–11-*.md`](rebuild/) — the 12 executable specs (ADTs,
   effects, invariants). Each ≤ 300 lines by discipline.
2. [`errors/`](errors/) — canonical error-code catalog. Every code the
   compiler emits has a file here.
3. [`rebuild/F-notes/`](rebuild/F-notes/) — research scaffolding for
   Arc F arcs (scoped memory, ML, DSP, packaging, multi-shot
   continuations, incremental compilation). Not authoritative; notes
   to consume when the F arc begins.

If you want external validation of the design:

1. [`SYNTHESIS_CROSSWALK.md`](SYNTHESIS_CROSSWALK.md) — historical
   context. Eight-pillar external manifesto mapped to Inka.

---

## Layout

```
docs/
├── README.md                 this file — index
├── DESIGN.md                 manifesto — what Inka IS and WILL BE
├── INSIGHTS.md               deep truths — consequences of the foundations
├── PLAN.md                   THE plan — rebuild, phases, status
├── ARCS.md                   canonical development history
├── SYNTHESIS_CROSSWALK.md    historical: external manifesto → Inka mapping
├── rebuild/                  the 12 executable specs
│   ├── 00-substgraph.md      live inference graph
│   ├── 01-effrow.md          Boolean algebra over effect rows
│   ├── 02-ty.md              type ADT + refinements + ownership markers
│   ├── 03-typed-ast.md       AST nodes with spans + type handles
│   ├── 04-inference.md       HM + let-gen, one walk
│   ├── 05-lower.md           LowIR from live graph observation
│   ├── 06-effects-surface.md effect signatures + error codes
│   ├── 07-ownership.md       Consume as effect + ref escape check
│   ├── 08-query.md           `lux query` forensic substrate
│   ├── 09-mentl.md           Mentl — the teaching substrate
│   ├── 10-pipes.md           the five verbs (|>, <|, ><, ~>, <~)
│   ├── 11-clock.md           Clock / Tick / Sample / Deadline family
│   └── F-notes/              research notes for Arc F arcs
├── errors/                   canonical error catalog
│   ├── README.md             catalog index + conventions
│   ├── E001.md … P001.md     one file per reserved code
│   └── …
```

---

## Authority map

If docs disagree, this is the order of authority:

1. `rebuild/00–09-*.md` — executable ADTs/effects. These define shape.
2. `PLAN.md` — THE plan. Current phase, current work.
3. `DESIGN.md` — the manifesto. What Inka IS.
4. `INSIGHTS.md` — consequences. Read after DESIGN.
5. `ARCS.md` — history. Never cited as "what we do now."
6. `SYNTHESIS_CROSSWALK.md` — historical context.
7. `AGENTS.md` — handoff. Treat as stale by default; verify.

A claim in `rebuild/` overrides `DESIGN.md`; a claim in `DESIGN.md`
overrides `INSIGHTS.md`; a claim in any of those overrides
`SYNTHESIS_CROSSWALK.md` or `ARCS.md` or `AGENTS.md`.

---

## Documentation discipline

These rules keep docs useful after the writing-context is forgotten.

**1. One source of truth per concept.** If "what Inka is" lives in
`DESIGN.md`, don't restate it in `PLAN.md` — link. Every doc declares
its scope in its opening line.

**2. Delete, don't decorate.** A superseded doc gets deleted. No
"archive/" folders. No "deprecated — see X" placeholders. Git is the
history; the current tree is the current shape. This is the same rule
that governs the codebase.

**3. No patches.** A doc drifting from reality isn't a candidate for a
"note: out of date" banner — it's a candidate for rewriting or
deleting. Same discipline as code (`CLAUDE.md` anchor 2).

**4. Structure first.** New docs answer the first anchor: does the
answer already live in an existing doc's structure? If yes, link
there. A new doc is justified only when the answer lives nowhere yet.

**5. Absolute dates.** `2026-04-16`, never "today" or "last week."
Docs outlive the conversations that produced them.

**6. No TODO lists in docs.** Tasks live in git/issues/conversations.
Docs describe what IS; tasks describe what SHOULD BE. Don't mix.

**7. No changelog files.** Git is the changelog. `ARCS.md` is the
narrated summary. Never `CHANGELOG.md`.

**8. Every doc starts with *what it is*.** The first non-title line
answers "why would I read this?" One italicized sentence. Everything
else is earned attention.

---

## Status glyphs (convention)

| Glyph | Meaning |
|---|---|
| ✅ | Shipped — tested, in the default pipeline |
| 🔄 | In progress — active work |
| ⏳ | Pending — next up |
| 🔲 | Planned — agreed direction, not started |
| ⬜ | Open — surfaced but not decided |
| ❌ | Rejected — kept for the record |
