# mentl-edit (Tier 0)

A faithful host-language demonstration of Mentl's eight-aspect cursor
projection. The medium becoming touchable while the self-hosting
bootstrap closes.

## Run

```
python3 tools/editor/mentl-edit-tier0/mentl-edit.py
```

ENTER advances the cursor along the gradient. `?? <handle>` pins the
cursor at a chosen position. `q` quits.

## What it is

`mentl-edit.py` is a single-file Python harness that satisfies the
substrate contracts `src/cursor.mn` declares — eight aspects of the
graph projected at one position, each lens computed from the same
node, consolidated into one CursorView record, rendered through a
terminal transport.

Every function in the file mirrors a wheel primitive:

| Tier 0 (Python)            | Wheel (canonical)                         |
|----------------------------|-------------------------------------------|
| `cursor_at`                | `src/cursor.mn:100-120`                   |
| `cursor_argmax`            | `src/cursor.mn:227-275`                   |
| `cursor_loop`              | `src/cursor_transport.mn:292-318`         |
| `caret_proximity_weight`   | `src/cursor.mn:288-316`                   |
| The eight aspect handlers  | `src/cursor.mn` `<\|` fan-out at line 106 |

The literal proximity weights (1.0 / 0.85 / 0.7 / 0.4 / 0.2) are the
same literal weights `cursor.mn:312-316` defines. The Reason ADT is
the same `Reason`. The Cursor record is the same `Cursor`. This is
the medium expressed in a host substrate that already runs.

## Why Tier 0

The wheel is dream-code-complete; the bootstrap is closing on L1
fixpoint (m2.wat == m3.wat). Until the wheel runs natively under the
seed, the eight-aspect projection lives only as design. Tier 0 makes
it touchable now — so the developer can feel the gradient, see the
proposals, walk the Reason chain.

When `bootstrap/mentl.wasm` runs `cursor.mn` natively, this file
dissolves: the canonical implementation IS `cursor.mn`. The Python
harness is scaffolding that recognizes its own dissolution.

## Sample program

The file embeds a small graph for:

```mentl
fn add(a, b) with Pure = a + b
fn double(x) = add(x, x)
fn main() = double(21) ??
```

The cursor opens at the gradient's argmax — typically `add`'s body
(a free tyvar that would be Pure-annotated to unlock compile-time
guarantees). ENTER advances; you watch the gradient narrow position
by position toward fully-annotated.

To use Mentl on your own program, hand-build a graph in
`hand_built_graph()`. The Tier 0 boundary is the input format —
not the projection.

## What it doesn't include (yet)

- Real `<-` edits to source files (the loop reads actions, not
  patches; AccAccept is currently a no-op stub)
- Multi-cursor mode (`parallel_map` over span list)
- IC fixpoint (the `<~` feedback closure is the canonical loop;
  Tier 0's loop is the reduced form without convergence detection)
- Actual `.mn` file parsing (graphs are hand-built today)

These are not Tier 0's responsibility — they belong to the canonical
wheel + browser-WASM transport (`Hμ.cursor.transport.browser-wasm`).
Tier 0 exists to make the eight aspects felt; the canonical surface
inherits the experience when L1 closes.
