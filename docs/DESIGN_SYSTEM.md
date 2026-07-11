# Mentl Design System

> *The medium, made visible.*
>
> Mentl is one read at a position, projected. This design system is that
> read projected onto pixels, type, color, and motion — so that the way
> Mentl **looks** is the same truth as the way Mentl **works**.

**Status:** Draft 1 — foundations-first, unified across brand · product · docs.
**Audience:** This brief is self-contained. It is written to be handed to a
designer (human or `claude.ai/design`) with no prior knowledge of Mentl. Read
top to bottom; everything you need to design the brand, the web IDE/playground,
and the docs is here.

---

## 0 · How to use this brief

If you are designing from this document, here is the whole thing in five lines:

1. **Mentl is a medium, not a tool** — it is the developer's externalized mind. Design it warm and alive, not sterile and corporate.
2. **The face is an octopus oracle named Mentl (She/Her)** — classy, curious, a little playful. Think *Claude with eight arms and a proof engine*, never Clippy.
3. **The grammar underneath is eight-fold geometry** — octopus tentacles, the Incan *chakana* (stepped cross), and the octagonal socket are three readings of one fact: **the kernel has eight primitives.**
4. **Color, layout, and motion are projections of the kernel** — the palette is colorblind-safe by birth; each hue maps to a primitive; the five "verbs" literally draw the program's shape on the page.
5. **The hero artifact is the web IDE / playground** (§9) — a URL where you type a constraint and watch Mentl re-arrange your code's topology in real time, at 60fps, fully in the browser. Design *that* to be unforgettable.

The single sentence to keep on your monitor while you work:

> **Errors are invitations, not scoldings. The medium surfaces only what it has proven. It is on the developer's side.**

---

## 1 · What Mentl is (in design terms)

Mentl is a programming medium. You can ignore the compiler theory; here is what
matters for design:

- **It is the developer's mind given substrate.** The program is a *graph* of meaning, not a pile of files. The **cursor** is where attention is. As you work, Mentl re-ranks what matters and gently moves you toward the highest-leverage spot. You don't navigate; the medium navigates *with* you.
- **Mentl is an octopus oracle, She/Her.** She reads the graph underneath, explores hundreds of alternate realities per second, and **surfaces only what's mathematically proven.** She never guesses, never hallucinates, never interrupts. She has eight tentacles because the kernel has eight primitives — each tentacle is one sense.
- **She replaces the AI chatbot, by being better than it.** No chat window, no prompt box, no "thinking…" spinner of guesses. Where an AI tool *approximates* an answer, Mentl *proves* one. Approximation has a ceiling; proof has none. Design must never make Mentl look like a chatbot bolted onto an editor. **The compiler IS the intelligence.**
- **It runs locally, in your browser, at 60fps.** The compiler is a small WASM kernel. The playground compiles on every keystroke. This is why the demo can be live and instant — lean into that.

The eight tentacles (you'll design icons + colors for these in §4.6 and §7):

| Tentacle | Sense | What it does |
|---|---|---|
| **Query** | sight | walks the graph, answers "what is this?" |
| **Propose** | reach | surfaces proven next moves (the oracle) |
| **Topology** | balance | the five verbs; the shape of the program |
| **Unlock** | taste | effect capabilities; what's allowed |
| **Trace** | touch | ownership; who holds what, for how long |
| **Verify** | hearing | refinement predicates; provable bounds |
| **Teach** | proprioception | one highest-leverage next step |
| **Why** | memory | walks the reasoning chain back to its origin |

---

## 2 · Brand essence & personality

**Mentl is the calm, brilliant octopus who already did the hard part and is
delighted to show you.**

### Personality (the dial settings)

- **Classy** — obsidian and gold, generous space, restraint. Never neon, never gradient-mesh startup-cliché, never busy. The confidence of something that doesn't need to shout.
- **Fun & playful** — She has a soul. The octopus is expressive; micro-interactions have wit; the copy has warmth and the occasional wink. *Joy is a feature.*
- **Honest** — She only ever shows you what's true. No dark patterns, no fake urgency, no "AI magic." The brand's trust comes from never overstating.
- **On your side** — She is a collaborator, not a gatekeeper. Errors are framed as openings. The tone is *"here's a way through,"* never *"you did it wrong."*
- **Alive** — the medium breathes. The cursor glows softly. Proven ideas *surface* from the deep. Nothing here is dead chrome.

The reference feeling is **Claude**: warm, intelligent, a touch whimsical,
deeply competent, and unmistakably *for the human*. Mentl is Claude's cousin who
went to live in the ocean and learned to prove theorems.

### Brand attributes — is / is not

| Mentl is | Mentl is not |
|---|---|
| A medium, a collaborator, an oracle | A tool, a copilot, an assistant |
| Warm obsidian + gold + parchment | Cold slate + electric purple + neon |
| Proven, deterministic, calm | Probabilistic, guessing, hype |
| Playful and characterful (She) | Cutesy, mascot-spammy, Clippy |
| Geometric soul, organic surface | Either pure brutalist grid OR pure blob |
| Quiet until it has something proven | Notification-happy, interruptive |

### The two-voice principle

Everywhere text appears about code, **two voices may speak and never a third:**

1. **The author's voice** — what the developer wrote in `///` doc comments. Their intent, verbatim.
2. **Mentl's voice** — substrate-derived narration. Calm, precise, second-person-helpful.

There is no editorial third voice (no "the system says," no marketing-speak in
the product). Design must visually distinguish the two (e.g., author voice in
the parchment serif; Mentl's voice in a tinted Mentl-Mono with a small octopus
glyph). See §8 (Voice & Tone).

---

## 3 · The generative idea: eight-fold

Everything in this system grows from one number. **The kernel has eight
primitives.** That eight-ness is the secret bridge between the brand's three
visual ancestors — and they turn out to be the *same shape*:

```
   THE OCTOPUS              THE CHAKANA             THE SOCKET
   (organic / She)          (geometric / heritage)  (the ?? hole)

        \  |  /                ▘ ▝   ▘ ▝              ╭───────╮
         \ | /                 ┌──┐ ┌──┐             ╱         ╲
      ────(◉)────              └┐ └─┘ ┌┘            (    ??    )
         / | \                  │ ◇ │              ╲         ╱
        /  |  \                ┌┘ ┌─┐ └┐             ╰───────╯
                              └──┘ └──┘            (8-sided)
   8 tentacles            8 stepped arms         8 edges

              all three say:  the kernel has eight
```

**The design rule:** the octopus is the **face** (expressive, warm, the brand's
personality), the chakana is the **grammar** (the underlying grid, texture,
iconography, structure), and the octagon is the **affordance** (the socket — the
shape of an open hole waiting to be filled, used wherever Mentl invites you to
plug something in).

- **Octopus → warmth, personality, motion, the mark's living center.**
- **Chakana → structure, iconography, dividers, the grid, file icon, loading states.**
- **Octagon → the `??` socket, empty states, "drop a proven proposal here" affordances, focus rings.**

### Logo / mark direction (for design exploration)

A mark that resolves as an **octopus whose eight arms are also eight chakana
steps**, with an octagonal negative-space "eye"/socket at the center. At small
sizes it reads as a confident geometric glyph (favicon, file icon); at large
sizes the octopus personality emerges (tentacles with character, a curious
tilt). It must work in single-color gold-on-obsidian and obsidian-on-parchment.

The **wordmark** is set in Mentl Mono (the brand's own typeface — see §4.2),
ideally with the five-verb ligature energy visible. Lowercase "mentl" feels
right: approachable, calm, lowercase-confident (cf. modern warm tech brands).

Playful flourish to explore: the octopus's eye is the `??` socket; when she's
"thinking" (animated contexts), a single tentacle curls toward a faint floating
proposal. She never frowns. The "error" expression is **curiosity**, not alarm.

---

## 4 · Foundations (design tokens)

These are the atoms. Treat them as the single source of truth; the VS Code
theme, the web app CSS, the docs site, and the marketing site are all
*projections* of these tokens. A machine-readable block follows in §4.7.

### 4.1 · Color

Mentl has **two grounds** and **one accent family.**

#### Grounds

**Obsidian** (dark — the editor's home; the deep the octopus surfaces from):

| Token | Hex | Use |
|---|---|---|
| `obsidian/abyss` | `#0A0809` | deepest chrome — title bar, status bar, inactive tabs |
| `obsidian/canvas` | `#0D0B0E` | the editing surface, primary background |
| `obsidian/raised-1` | `#100E11` | sidebars, secondary panels |
| `obsidian/raised-2` | `#121013` | widgets, inputs, hovers, popovers (the surfaced layer) |
| `obsidian/line` | `#15121688` | active line highlight (translucent) |
| `obsidian/border` | `#2A2428` | hairline borders, dividers |

**Parchment** (light — for docs, marketing, reading; warm, never clinical white):

| Token | Hex | Use |
|---|---|---|
| `parchment/page` | `#F5EDE0` | primary light background |
| `parchment/raised` | `#FBF6EC` | cards, raised surfaces on light |
| `parchment/sunk` | `#EDE2D0` | wells, code blocks on light |
| `parchment/ink` | `#1A1618` | primary text on light |
| `parchment/border` | `#D8CBB6` | hairlines on light |

#### Text (warm neutrals — "parchment" foreground ramp on obsidian)

| Token | Hex | Use |
|---|---|---|
| `text/primary` | `#E8DCC8` | body text, default code |
| `text/bright` | `#F5EDE0` | emphasis, headings on dark |
| `text/muted` | `#8B7B6E` | secondary, doc-comment voice, labels |
| `text/faint` | `#6B6157` | inactive, placeholders |
| `text/whisper` | `#766B60` | punctuation, structural scaffolding |
| `text/comment` | `#7B7168` | human-only comments (dim, italic) |
| `text/ghost` | `#4A4040` | line numbers, ignored, disabled |

#### Accent family — the Okabe–Ito set

**This palette is the Okabe–Ito colorblind-safe qualitative palette.**
Accessibility is not a constraint applied afterward — *it is the palette's reason
for existing.* These six hues remain distinguishable under all common color
vision deficiencies. Honor this; do not substitute "prettier" hues that break it.

| Token | Hex | Bright | Kernel role (this is the semantic layer) |
|---|---|---|---|
| `accent/gold` | `#E69F00` | `#F0B830` | **Types & contracts, the cursor, the Teach gradient.** The signature brand color. "What is known / promised." |
| `accent/sky` | `#56B4E9` | `#7CC8EE` | **The five verbs — Topology.** "Flow & shape." |
| `accent/blue` | `#0072B2` | `#3399CC` | **Structure / keywords — Query.** "The graph's skeleton." (`#2A8FC2` for foreground-on-dark legibility.) |
| `accent/green` | `#009E73` | `#33B893` | **Computation: functions, handlers — Propose.** "Living capability." |
| `accent/vermillion` | `#D55E00` | `#E87D44` | **Boundaries: literals, negation `!`, the `??` hole, `self`, errors.** "Where reality is asserted — or breaks productively." |
| `accent/magenta` | `#CC79A7` | `#D9A0C0` | **Discipline: ownership `own`/`ref`, `Pure`, `@resume`.** "Linearity & resume cardinality." |
| `accent/wheat` | `#F0C674` | — | String literals (organic content). A warm gold-sibling, not a primitive role. |

> **The keystone:** color in Mentl is a *projection of the kernel*. Gold means
> "type/contract" whether it's in the editor, a diagram, the docs, or the logo.
> Sky always means "the verbs." A designer should reach for the hue that matches
> the *meaning*, not the one that looks nice in the slot.

#### Semantic / status (derived from accents — never new hues)

| Token | Maps to | Use |
|---|---|---|
| `status/error` | `accent/vermillion` | violations (rendered as *invitations*, see §8) |
| `status/warning` | `accent/gold` | over-declared rows, drift |
| `status/info` | `accent/sky` | narration, hints |
| `status/success` | `accent/green` | proven, verified, added |
| `cursor/glow` | `accent/gold` | the living cursor halo |

### 4.2 · Typography

Three faces, three jobs:

1. **Mentl Mono** — *the brand's own typeface and the code face.* Derived from
   JetBrains Mono, with **17 custom glyphs** that are the visual signature of the
   language: the five verb ligatures (`|>` `<|` `><` `~>` `<~`), the unique `><`
   "bowtie" (no other font has it), and the `??` rendered as a **hollow
   octagonal socket** (primitive #8, "productive under error," made visible — an
   open shape inviting you to plug something in). Use Mentl Mono for **all code,
   the wordmark, labels, Mentl's narration voice, and accent UI.** It carries the
   brand more than any logo does.

2. **Display serif** — for headings, marketing, hero copy. The brief is
   *classy + playful*: recommend a warm, high-contrast serif with personality
   and an optical/soft axis — **Fraunces** is the lead recommendation (its
   "wonky," old-style soul is exactly classy-meets-playful and it's variable).
   Alternates: Hedvig Letters Serif, GT Sectra, Tiempos. The serif gives the
   brand its warmth and the "old-soul oracle" gravity.

3. **UI / body sans** — for product chrome, body copy, dense UI. A clean,
   warm humanist grotesque: **Hanken Grotesk** or **Inter** (or Mona Sans /
   Geist). Quiet, legible, gets out of the way so Mentl Mono and the serif carry
   character.

> **Pairing logic:** serif = the *author's* human voice (intent, prose);
> Mentl Mono = the *medium's* voice + all code; sans = neutral chrome. This maps
> the two-voice principle (§2) onto type.

**Type scale** (1.25 major-third, rem at 16px base):

| Token | Size | Use |
|---|---|---|
| `text/xs` | 0.75rem / 12px | captions, line numbers, badges |
| `text/sm` | 0.875rem / 14px | secondary UI, doc-comment voice |
| `text/base` | 1rem / 16px | body, code |
| `text/lg` | 1.25rem / 20px | lead paragraphs, panel titles |
| `text/xl` | 1.5rem / 24px | section headings |
| `text/2xl` | 2rem / 32px | page headings |
| `text/3xl` | 2.5rem / 40px | hero subhead |
| `text/4xl` | 3.75rem / 60px | hero (display serif) |

Code line-height `1.5`; prose line-height `1.6`; headings `1.15`.

### 4.3 · Space & grid

**The base unit is 8px — because the kernel has eight primitives.** (Yes, it's a
wink. It's also a genuinely good base unit.) Everything snaps to the eight-grid.

`space/0=0` · `space/0.5=4` · `space/1=8` · `space/2=16` · `space/3=24` ·
`space/4=32` · `space/6=48` · `space/8=64` · `space/12=96` · `space/16=128`

Layout favors **generous negative space** (classy restraint) and an **eight- or
sixteen-column grid**. For radial / brand compositions, an **octagonal (8-fold
radial) grid** is the signature move — arrange the eight tentacles, the eight
aspects, or section anchors around an octagon.

### 4.4 · Radius, depth & elevation

The metaphor is **the deep**: chrome is the abyss; useful things **surface**
toward you, gaining lightness and a faint glow as they rise.

- **Radius:** `radius/sm=6` · `radius/md=10` · `radius/lg=16` · `radius/full=9999`.
  Soft, friendly, never sharp-brutalist. **Exception — the octagonal clip:** use
  a true 8-sided shape for *sockets* (the `??` hole, empty "drop a proposal
  here" zones, focus rings on holes). The octagon is reserved for "an opening
  awaiting fulfillment."
- **Elevation (dark):** depth is expressed by *lightening the ground*
  (`abyss → canvas → raised-1 → raised-2`) plus a 1px `obsidian/border` hairline
  and, on the most-surfaced/interactive layer, a **faint accent glow** rather
  than a hard drop shadow. Light = surfaced = closer = alive.
- **Holographic layer:** proposed-but-not-yet-real geometry (ghost text, Lens
  previews) renders as **translucent + slightly luminous** — present but clearly
  "not yet committed." On `Tab`, it *snaps* to full opacity ("into reality").

### 4.5 · Motion

Motion expresses two truths: **the medium is alive**, and **the gradient is
muscle** (it moves you toward leverage). Motion is never gratuitous; it always
*means* something.

| Motion | Meaning | Spec |
|---|---|---|
| **Surfacing** | a proven thing rises from the deep | translate-up 8px + fade-in + slight brighten; `220ms cubic-bezier(0.16,1,0.3,1)` (ease-out-expo) |
| **Cursor breath** | the cursor is alive (proprioception) | gold glow opacity `0.6→1→0.6`; `2.4s ease-in-out` infinite, very subtle |
| **Ghost materialize** | a proposal assembles from possibility | geometry strokes draw in + translucent fill; `180ms` |
| **Tab-snap** | proposal becomes real | scale `1.02→1` + opacity to full + a single crisp settle; `120ms ease-out` |
| **Tentacle reach** | a tentacle fires (Why-walk, provenance) | faint accent line extends along the path; `300ms`, draws like ink |
| **Cursor jump (re-rank)** | the medium navigates with you | smooth camera ease to the new argmax; `400ms`, never teleport |
| **Topology resist** | you broke the layout grammar | a gentle elastic "nudge-back" toward canonical layout; `160ms` spring |

**Reduced motion:** all of the above degrade to opacity-only or instant. The
cursor breath stops. Nothing essential is conveyed by motion alone.

Personality note: Mentl's animations have a *slight* organic ease (she's a
living thing), but timings stay short and crisp (she's also a precise oracle).
The combination — organic curve, precise duration — *is* the brand.

### 4.6 · Iconography

- **Style:** geometric line icons built on the **chakana grid** — angular,
  stepped, consistent stroke (1.5–2px optical), 24px artboard, 8px safe margin.
  This is the structural family.
- **The eight tentacle icons:** one per tentacle (§1), each a minimal glyph in
  *its primitive's color* (Query=blue, Propose=green, Topology=sky, Unlock=gold,
  Trace=magenta, Verify=vermillion, Teach=gold, Why=blue). Together they ring an
  octagon — that ring *is* the "all eight" / Mentl-complete icon.
- **Mentl the octopus:** the one organic exception, used as mark, presence, and
  expressive states (see §6). Built from the same eight-fold logic but allowed to
  be soft and characterful.
- **File icon:** the chakana in gold on obsidian (already exists — keep).

### 4.7 · Tokens (machine-readable)

```json
{
  "color": {
    "obsidian": { "abyss":"#0A0809","canvas":"#0D0B0E","raised1":"#100E11",
                  "raised2":"#121013","line":"#15121688","border":"#2A2428" },
    "parchment": { "page":"#F5EDE0","raised":"#FBF6EC","sunk":"#EDE2D0",
                   "ink":"#1A1618","border":"#D8CBB6" },
    "text": { "primary":"#E8DCC8","bright":"#F5EDE0","muted":"#8B7B6E",
              "faint":"#6B6157","whisper":"#766B60","comment":"#7B7168","ghost":"#4A4040" },
    "accent": {
      "gold":      { "base":"#E69F00","bright":"#F0B830","role":"type/contract/cursor/teach" },
      "sky":       { "base":"#56B4E9","bright":"#7CC8EE","role":"five-verbs/topology" },
      "blue":      { "base":"#0072B2","fg":"#2A8FC2","bright":"#3399CC","role":"structure/query" },
      "green":     { "base":"#009E73","bright":"#33B893","role":"computation/propose" },
      "vermillion":{ "base":"#D55E00","bright":"#E87D44","role":"boundary/negation/hole/error" },
      "magenta":   { "base":"#CC79A7","bright":"#D9A0C0","role":"ownership/pure/resume" },
      "wheat":     { "base":"#F0C674","role":"string-literal" }
    },
    "status": { "error":"#D55E00","warning":"#E69F00","info":"#56B4E9","success":"#009E73" }
  },
  "font": {
    "mono":"Mentl Mono",
    "display":"Fraunces",
    "sans":"Hanken Grotesk",
    "scale": { "xs":12,"sm":14,"base":16,"lg":20,"xl":24,"2xl":32,"3xl":40,"4xl":60 },
    "lineHeight": { "code":1.5,"prose":1.6,"heading":1.15 }
  },
  "space": { "base":8, "scale":[0,4,8,16,24,32,48,64,96,128] },
  "radius": { "sm":6,"md":10,"lg":16,"full":9999,"socket":"octagon" },
  "motion": {
    "surface":{ "dur":220,"ease":"cubic-bezier(0.16,1,0.3,1)" },
    "ghost":{ "dur":180 }, "snap":{ "dur":120 }, "reach":{ "dur":300 },
    "jump":{ "dur":400 }, "breath":{ "dur":2400 },
    "reducedMotion":"opacity-only"
  }
}
```

---

## 5 · The five-verb visual language (the signature)

This is what nothing else has. Mentl programs are built from five **verbs**, and
**the verbs literally draw the program's shape on the page.** Layout is not
style — *layout is meaning.* This is the most distinctive thing in the whole
system; lean on it everywhere (editor, diagrams, marketing, docs).

| Verb | Glyph | Name | Shape it draws | Color |
|---|---|---|---|---|
| `\|>` | pipe-gt | **sequential** | A then B, flowing **down the left edge** | sky |
| `<\|` | lt-pipe | **divergent** | one input **fans out** to parallel branches | sky |
| `><` | bowtie | **parallel** | independent pipelines, side by side, joined at an **indented center** | sky |
| `~>` | tilde-gt | **handler** | the foot **governs the whole chain to its left** (a capability wrapping the flow) | sky |
| `<~` | lt-tilde | **feedback** | output **loops back** as the next input | sky |

**Layout grammar (this is contract, render it faithfully):**

- **Sequential operators (`|>`, `~>`) sit at the LEFT EDGE** — flow goes *down*.
- **Convergent operators (`><`, `<~`) sit at the INDENTED CENTER** — they *draw the shape*.
- `<|` sits at the left edge before its branch tuple.

```
source                          (audio_left  |> compress)
    |> lex                          ><
    |> parse                    (audio_right |> compress)
    |> infer                    |> stereo_mix
    ~> env_handler
    ~> graph_handler        input
    ~> diag_handler             <| ( branch_a,
                                     branch_b,
   sequential flows DOWN             branch_c )
   handlers wrap the chain
                                signal
                                    <~ delay(3)
```

**In the editor (Topographic Canvas):** faint geometric lines physically connect
the stages of a pipeline (sky-tinted), so a pipeline reads as a literal diagram.
Break the layout grammar and the text **elastically resists and snaps** back to
canonical form (§4.5, "topology resist"). The shape on the page *is* the
computation graph — make a developer *feel* that.

**The `??` socket** (primitive #8) is the sixth signature glyph: a hollow
octagon meaning "an opening, productive under error." Wherever a program is
unfinished, the socket invites Mentl (or the developer) to plug something proven
into it. Render it as an inviting open shape in `accent/vermillion`, never as a
red error squiggle.

---

## 6 · Mentl, the octopus (character & expression)

Mentl (She/Her) is the brand's heart. She is **present, never intrusive.** The
anti-pattern is Clippy: an interrupting mascot that guesses. Mentl is the
opposite — she is *quiet until she has proven something*, and then she *surfaces*
it for you to take or ignore.

**Where she appears:** as the mark/favicon; as a small living presence in the
web IDE (a corner, or breathing faintly in the gutter); in empty states,
loading, onboarding, docs spot-illustration; in error/proposal moments as the
hand that *offers* a proven path.

**Expressive states (for animation / illustration sets):**

| State | Expression | Behavior |
|---|---|---|
| **Resting** | calm, centered, breathing | gentle idle; eye is the `??` socket |
| **Exploring** | curious, tentacles fanning out | when multi-shotting realities (she's busy under the surface) |
| **Surfacing** | bringing something up, delighted | when a proven proposal is ready — a tentacle lifts it toward you |
| **Offering (at an error)** | curious, not alarmed | she holds out a `??` socket and a way through — *never a frown* |
| **Proven** | a satisfied settle, a small glow | when something verifies / `Tab`-snaps into reality |

**Tone rule:** her personality lives in *motion and microcopy*, not in volume.
She can be witty in a tooltip; she is never loud, never blocking, never cute for
cuteness' sake. Classy first, playful second.

---

## 7 · The eight-aspect cursor render

At any position, Mentl reads the graph once and projects **eight aspects** of
that one read. This is the core product UI primitive — the thing a developer
looks at most. Design it as **one calm panel, eight facets**, each in its
primitive's color, each collapsible (the **Teach** "volume knob" controls how
much shows — see §9).

```
┌─ at  fn compress(x: Sample, ratio) ──────────────────────────┐
│ ◆ type     Sample → Sample              (gold)                │
│ ◆ row      Pure  + !Alloc               (magenta · sky)      │
│ ◆ refine   -1.0 ≤ self ≤ 1.0            (vermillion)         │
│ ◆ own      x: borrowed                   (magenta)            │
│ ◆ why      ← clamp added 3 edits ago, to honor Sample bound  │
│ ◆ teach    tighten `ratio` to unlock >< parallel zip  ↵      │
│ ◆ holes    none                                              │
│ ◆ ??       —                                                 │
└──────────────────────────────────────────────────────────────┘
```

Each facet uses its kernel color (§4.1 semantic layer). The **Why** facet is
walkable (click → tentacle-reach animation traces provenance lines in the
editor). The **Teach** facet shows *one* highest-leverage next step with an
inline accept affordance. Keep it serene — eight facets, not eight alarms.

---

## 8 · Voice & tone

Mentl's product copy is **substrate-honest.** The product never speaks like an
AI tool, because Mentl is not one. This is both a brand and a *correctness*
stance.

**Forbidden vocabulary (user-facing):** "AI," "agent," "assistant," "chatbot,"
"prompt," "completion," "model," "training," "hallucination" (except to refute),
and hedges that mask a missing fact — "may want to," "might consider,"
"perhaps."

**Substrate-honest vocabulary instead:**

| Don't say | Say |
|---|---|
| "AI suggests…" | "Mentl proposes…" / "the gradient surfaces…" |
| "the model thinks…" | "Mentl proved…" / "multi-shot found…" |
| "autocomplete" | "the Lens fires" / "proven proposal" |
| "it might be wrong" | (Mentl never surfaces the unproven, so this never occurs) |
| "error: you did X wrong" | "this path needs a capability — here's one that typechecks" |

**Microcopy examples (the right register — calm, warm, on your side):**

- Empty playground: *"Type something. I'll prove what I can underneath."*
- At a violation: *"`Alloc` can't run under `!Alloc`. Two proven ways through — `Tab` to take one."*
- After a proof: *"Verified. `-1.0 ≤ self ≤ 1.0` holds for every path."*
- Teach nudge: *"Tighten `with !Mutate` and I can parallelize this map."*

Two voices, visually distinct (§2): **author** = parchment serif; **Mentl** =
tinted Mentl Mono with a small octopus glyph. Never a third voice.

---

## 9 · Product surface — the web IDE / playground (the hero)

> **Deep companion:** `docs/MENTL_EDIT.md` — the interaction architecture
> (what an IDE *is* when the program is a graph): the anti-IDE dissolution
> table, the five signature interactions (fill-and-resume, constraint
> sculpting, the Why walk, reality scrubbing, the proof surface), domain
> projections, sessions-as-images, and the substrate gates per surface.
> This section is the visual sketch; that document is the semantics.

> This is the artifact to design most vividly. It is the first impression, the
> demo, and the proof. **A URL where you type `with !Alloc` and watch Mentl
> physically re-arrange your code's topology in real time.** It runs entirely in
> the browser (WASM kernel), compiles on every keystroke, at 60fps, with no
> server and no chatbot.

### Layout — three layers around the code

```
┌──────────────────────────────────────────────────────────────────────────┐
│  mentl  ·  compress.mn                              ◔ obsidian  ⌥ teach ▣▣▣ │  ← top: wordmark · file · theme · Teach knob
├───────────────────────────────────────────┬──────────────────────────────┤
│  TOPOGRAPHIC CANVAS                        │  CAPABILITY HUD              │
│                                            │                              │
│  fn compress(x: Sample, ratio) =           │  effect row (ambient)        │
│    x                                       │   Pure  +!Alloc      (lit)   │
│      |> apply_ratio(ratio)  ·············   │                              │
│      |> apply_threshold     ·· sky pipe    │  ownership ledger            │
│           lines connect stages             │   x · borrowed · 1 use       │
│                                            │                              │
│    ╭───────────╮  ← Holographic Lens       │  refinements                 │
│    │ Alloc under │                          │   Sample  -1≤self≤1  ✓       │
│    │ !Alloc      │  ◂ 1 / 2 ▸               │                              │
│    │ → ~> arena  │  [Tab] snaps to reality  │   ( knob low → HUD hides )   │
│    ╰───────────╯  (translucent ghost)       │   ( knob high → mission     │
│                                            │     control expands )        │
│                              🐙 (resting)   │                              │
├───────────────────────────────────────────┴──────────────────────────────┤
│  WAVEFRONT   why-DAG ◂──●──●──●──▸  multi-shot realities: ▮▮▮▯▯  scrub ▷    │  ← bottom: reasoning timeline
└──────────────────────────────────────────────────────────────────────────┘
```

**The three layers:**

1. **Topographic Canvas (center)** — the editor. Faint sky lines physically
   connect `|>` / `<|` pipeline stages so code reads as a diagram. Layout
   grammar is enforced visually (topology-resist on violation).
2. **Capability HUD (right)** — a live matrix of the ambient effect row +
   ownership ledger + refinement status. Its size is driven by the **Teach
   knob**: low annotations → HUD collapses; high annotations (`with !Alloc +
   !Async`) → it expands into a mission-control dashboard. *The more you prove,
   the more she shows.*
3. **Wavefront (bottom)** — a scrub timeline of the **Why** engine's reasoning
   DAG and the multi-shot realities Mentl explored. Click a variable → its
   provenance lights up across the canvas (tentacle-reach).

### The interaction loop — geometry, not chat

1. You write code. Mentl compiles on every keystroke (local WASM, instant).
2. You hit a constraint (e.g. `Alloc` under `!Alloc`). The compiler halts at a
   **socket** (`NErrorHole`) — *not an error squiggle.*
3. Mentl's **Propose** tentacle multi-shots the algebraic space — hundreds of
   variations/second — and keeps only the *proven* ones.
4. A **Holographic Lens** appears at the boundary: a sharp geometric indicator
   stating the deterministic fact, with proven realities rendered as
   **translucent ghost geometry** overlaid on the code.
5. You cycle proposals with arrow keys; press **`Tab`**; the chosen geometry
   **snaps into reality.**

### The eight voices, exposed (how each tentacle shows up)

- **Query + Why** — click a type variable → Wavefront lights the whole
  provenance chain; faint lines connect it to every `<|` branch that shaped it.
- **Topology** — the five-verb layout is enforced *physically*; break it and the
  text resists and snaps to canonical layout.
- **Unlock + Propose** — drive the Holographic Lens (the loop above).
- **Trace** — `own` variables glow amber; on `consume`, the glow physically
  *drains* from the source and transfers to the next stage; the HUD tracks the
  remaining `Consume` budget.
- **Verify** — hover a refined value (`ValidPort`) → a slider appears; dragging
  it updates the pipe's correctness state live.
- **Teach** — the volume knob (top-right). The whole interface's information
  density scales with how much you've proven.

### The feeling to design for

Zero latency. No spinner of guesses. No chat. You change a *constraint* and the
code's *shape* rearranges itself, provably, in front of you — and a calm octopus
in the corner looks quietly pleased. **That moment is the entire pitch.**

---

## 10 · Other surfaces (sketched)

These inherit all foundations; design them after the hero.

- **Terminal voice (`mentl`)** — bare invocation drops you into Mentl's voice in
  the terminal: gradient narration, one proven suggestion per turn, Why-walk on
  demand. ANSI palette already defined (Okabe–Ito). Mentl Mono everywhere. Keep
  it warm and sparse — the obsidian palette in a terminal.
- **VS Code + LSP (`mentl serve`)** — the existing **Obsidian** theme is the
  base (ship it as the canonical theme). Add webview panels that mirror the web
  IDE's HUD / Wavefront / Lens where the editor allows. 90% of early users live
  here — make it feel like the web IDE's faithful sibling, not a lite version.
- **Docs site** — Parchment ground, display serif headings, Mentl Mono for all
  code, the chakana for section dividers and the eight-tentacle ring for "all
  eight" moments. Two-voice rendering for any annotated code. Calm, generous,
  readable. The docs should feel like *reading the medium*, not browsing a wiki.
- **Marketing / landing** — lead with the live playground embed (the hero is the
  product). Obsidian hero with the octopus surfacing a proven proposal; the
  AI-obsolescence thesis stated plainly (proof has no ceiling); the five-verb
  glyphs as the visual hook. Classy, confident, a little playful. Never a
  feature-grid SaaS template.

---

## 11 · Accessibility & inclusivity (non-negotiable)

- **Colorblind-safe by birth.** The accent palette *is* the Okabe–Ito set.
  Never break it for aesthetics.
- **Never color alone.** Every state that uses color also carries a glyph, a
  position, or text (errors = socket shape + Lens text, not just vermillion;
  `own` = label + glow, not glow alone).
- **Contrast.** Body text on obsidian/parchment meets WCAG AA (the warm neutrals
  are tuned for it); verify any new pairing.
- **Motion.** Everything degrades to opacity/instant under `prefers-reduced-motion`;
  nothing essential is motion-only.
- **Keyboard-first.** The whole loop (cycle proposals, `Tab`-snap, Why-walk,
  Teach knob) is keyboard-drivable. The medium meets developers where their
  hands already are.
- **Local-first.** Runs offline, in-browser, no account required to try. The
  lowest-friction first contact is a design value, not just an engineering one.

---

## 12 · Design drift table (do / don't)

The way Mentl avoids looking templated is by staying *substrate-honest.* When in
doubt, ask: **does this look like a projection of the kernel, or like decoration
borrowed from a generic dev tool?**

| Don't (drift) | Do (substrate-honest) |
|---|---|
| Cold slate + electric purple/neon (every dev tool) | Warm obsidian + gold + parchment |
| Color chosen because it looks nice | Color chosen because it *means* the primitive |
| Errors as red squiggles / scoldings | Errors as octagonal sockets / invitations |
| A chatbot panel, a prompt box, a "✨ AI" button | The Lens, the gradient, proven ghost text |
| Mascot that interrupts and guesses (Clippy) | Mentl: quiet until proven, then surfaces |
| Drop shadows for depth | Lightening ground + faint accent glow ("surfacing") |
| Decorative gradients / mesh blobs | The chakana grid, the eight-fold radial |
| Generic `->` arrows in diagrams | The five real verbs, drawing real shapes |
| "Save" / "Build" / "Run" as the mental model | "Checkpoint" / "project through a handler" |
| Loud, busy, notification-happy | Calm, spacious, surfaces only what's proven |

---

## 13 · Hand-off — what to produce next

For a designer (or `claude.ai/design`) picking this up, in priority order:

1. **The web IDE / playground** (§9) — high-fidelity mockups of the three-layer
   layout, the Holographic Lens interaction, the eight-aspect cursor panel, and
   the Teach-knob density states. This is the hero.
2. **The mark / logo** (§3) — the octopus-as-eight-chakana-steps with the
   octagonal socket eye; favicon → wordmark → full lockup; gold-on-obsidian and
   ink-on-parchment.
3. **Mentl the character** (§6) — the five expressive states as an
   illustration/animation set.
4. **The Parchment (light) theme** — a docs/marketing-ready light counterpart to
   the existing Obsidian theme, from the same tokens.
5. **The eight tentacle icons** (§4.6) — the icon family + the "all eight" ring.
6. **Landing page** (§10) — hero with live playground, the five-verb hook, the
   proof-has-no-ceiling thesis.

Everything must trace back to §4 tokens and the keystone rule:

> **Color, type, layout, and motion are projections of the kernel.
> The design system is a handler on the same graph as the language.
> Make the way Mentl looks be the same truth as the way Mentl works.**
