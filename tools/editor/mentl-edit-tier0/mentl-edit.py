#!/usr/bin/env python3
"""
mentl-edit (Tier 0) — faithful host reimplementation of cursor.mn's
projection. This file IS the wheel's design satisfied in Python; it
exists to make the eight-aspect cursor projection touchable while the
self-hosting bootstrap closes. When bootstrap/mentl.wasm runs the
wheel natively (post-L1), this file dissolves: cursor.mn is the
canonical implementation.

Each function in this file mirrors a substrate primitive in the wheel:
  cursor_at        ←→ src/cursor.mn:100-120 (eight-aspect projection)
  cursor_argmax    ←→ src/cursor.mn:227-275 (gates × proximity argmax)
  cursor_loop      ←→ src/cursor_transport.mn:292-318 (bus-compressor loop)
  scope_distance   ←→ src/cursor.mn:299-316 (proximity decay table)

The eight aspects are the same eight aspects the wheel declares. The
literal proximity weights (1.0 / 0.85 / 0.7 / 0.4 / 0.2) are the same
literal weights cursor.mn defines. The Reason ADT is the same Reason.
This is not a parallel implementation — it's the medium expressed in a
host substrate that already runs.

Run:
    python3 tools/editor/mentl-edit-tier0/mentl-edit.py
"""

from dataclasses import dataclass, field
from typing import Callable, Optional


# ─── Reason ADT (mirrors src/types.mn Reason) ──────────────────────────

@dataclass
class Inferred:    s: str
@dataclass
class Located:     span: tuple; reason: object
@dataclass
class Declared:    name: str
@dataclass
class Fresh:       handle: int


# ─── GNode + kinds (mirrors src/types.mn:NodeBody) ─────────────────────

@dataclass
class NBound:      ty: str           # node has resolved type
@dataclass
class NFree:       hint: str         # tyvar awaiting solution
@dataclass
class NRowFree:    row_id: int       # row variable
@dataclass
class NErrorHole:  msg: str          # productive-under-error


@dataclass
class GNode:
    kind:   object
    reason: object
    span:   tuple                    # (line, col, end_line, end_col)


# ─── Effect row (Mentl's Boolean algebra over effect names) ───────────

@dataclass
class EffRow:
    pos: tuple                       # effects added (e.g. ("Memory", "Alloc"))
    neg: tuple                       # effects subtracted
    pure: bool = False

    def label(self) -> str:
        if self.pure:               return "Pure"
        if not self.pos and not self.neg: return "{}"
        parts = []
        if self.pos: parts.append("+ " + " + ".join(self.pos))
        if self.neg: parts.append("- " + " - ".join(self.neg))
        return " ".join(parts)


# ─── Ownership ADT ─────────────────────────────────────────────────────

OWN_INFERRED = "Inferred"
OWN_OWN      = "own"
OWN_REF      = "ref"


# ─── Suggestion (cursor.mn's AnnotationSuggestion) ─────────────────────

@dataclass
class AnnotationSuggestion:
    kind:    str
    annot:   str
    unlocks: list                    # capabilities unlocked
    reason:  object


# ─── Cursor record ─────────────────────────────────────────────────────

@dataclass
class Cursor:
    handle: int
    located: Located
    impact:  float


# ─── CursorView — the eight-aspect projection (cursor.mn:64) ───────────

@dataclass
class CursorView:
    query:    object                  # 1. Graph + Env  → kind
    propose:  list                    # 2. Handlers     → MultiShot candidates
    topology: str                     # 3. Five verbs   → pipe context
    row:      EffRow                  # 4. Boolean row  → effect row
    trace:    str                     # 5. Ownership    → own/ref
    verify:   list                    # 6. Refinement   → pending obligations
    teach:    Optional[AnnotationSuggestion]  # 7. Gradient → unlock suggestion
    why:      object                  # 8. Why          → Reason chain


# ─── A small hand-built graph ──────────────────────────────────────────
#
# Represents the program:
#
#     fn add(a, b) with Pure = a + b
#     fn double(x) = add(x, x)
#     fn main() = double(21)
#
# Each handle below is a node in the graph. Reason chains walk back
# through the definition; gradient suggestions reflect what annotations
# would unlock additional capabilities (per Hμ-cursor.md §3).

def hand_built_graph() -> dict[int, GNode]:
    return {
        0: GNode(NBound("Int → Int → Int"),
                 Located((1, 4, 1, 7), Declared("add")),
                 (1, 4, 1, 7)),
        1: GNode(NBound("Int"),
                 Located((1, 8, 1, 9), Declared("a")),
                 (1, 8, 1, 9)),
        2: GNode(NBound("Int"),
                 Located((1, 11, 1, 12), Declared("b")),
                 (1, 11, 1, 12)),
        3: GNode(NFree("body of add"),
                 Located((1, 26, 1, 31), Inferred("inferred from a + b")),
                 (1, 26, 1, 31)),
        4: GNode(NBound("Int → Int"),
                 Located((2, 4, 2, 10), Declared("double")),
                 (2, 4, 2, 10)),
        5: GNode(NFree("x"),
                 Located((2, 11, 2, 12), Declared("x")),
                 (2, 11, 2, 12)),
        6: GNode(NBound("Int → ()"),
                 Located((3, 4, 3, 8), Declared("main")),
                 (3, 4, 3, 8)),
        7: GNode(NErrorHole("? at line 3"),
                 Located((3, 22, 3, 23), Inferred("hole")),
                 (3, 22, 3, 23)),
    }


# ─── The eight aspect handlers (cursor.mn lines 100-120 in Python) ─────

def query_aspect(handle: int, node: GNode) -> str:
    """Aspect 1 — Graph + Env. The node's binding."""
    k = node.kind
    if isinstance(k, NBound):     return f"bound: {k.ty}"
    if isinstance(k, NFree):      return f"free tyvar ({k.hint})"
    if isinstance(k, NRowFree):   return f"free row #{k.row_id}"
    if isinstance(k, NErrorHole): return f"error-hole: {k.msg}"
    return "?"


def propose_aspect(handle: int, node: GNode, graph: dict) -> list:
    """Aspect 2 — Handlers (Synth). MultiShot proposals for this slot.
    Per src/synth_proposer.mn, real Synth would generate proof-witnessing
    candidates. Tier 0 returns plausible context-typed candidates."""
    k = node.kind
    if isinstance(k, NFree):
        return [
            "0",               # an Int literal
            "a + b",           # use of params (only if in scope)
            "perform op()",    # an effect-op call
        ]
    if isinstance(k, NErrorHole):
        return ["double(21)", "main()", "()"]
    return []


def topology_aspect(handle: int, node: GNode) -> str:
    """Aspect 3 — Five verbs. Pipe context.
    NoPipe today; full landing reads NPipeExpr parents from the graph."""
    return "NoPipe"  # mirrors cursor.mn:480-486


def row_aspect(handle: int, node: GNode) -> EffRow:
    """Aspect 4 — Boolean row."""
    k = node.kind
    if isinstance(k, NBound):
        if "→" not in k.ty: return EffRow(pos=(), neg=(), pure=True)
        return EffRow(pos=("Memory",), neg=())
    return EffRow(pos=(), neg=(), pure=True)


def trace_aspect(handle: int, node: GNode) -> str:
    """Aspect 5 — Ownership."""
    k = node.kind
    if isinstance(k, NBound):
        return OWN_REF if "→" in k.ty else OWN_INFERRED
    return OWN_INFERRED


def verify_aspect(handle: int, node: GNode) -> list:
    """Aspect 6 — Refinement. Pending obligations at this handle."""
    if isinstance(node.kind, NErrorHole):
        return ["fill_in_required(span)"]
    return []


def teach_aspect(handle: int, node: GNode) -> Optional[AnnotationSuggestion]:
    """Aspect 7 — Continuous gradient.
    Per cursor.mn: returns Some(suggestion) when adding a annotation
    would unlock capabilities; None when fully annotated."""
    k = node.kind
    if isinstance(k, NFree):
        return AnnotationSuggestion(
            kind="annotation_suggestion",
            annot="with Pure",
            unlocks=["compile_time_inlining", "no_runtime_check"],
            reason=Inferred("free tyvar — annotating row unlocks pure compile-time guarantees"),
        )
    if isinstance(k, NErrorHole):
        return AnnotationSuggestion(
            kind="error_hole_fill",
            annot="(provide expression)",
            unlocks=["wat_emission", "type_check_completion"],
            reason=Inferred("error-hole at this position blocks emission"),
        )
    return None


def why_aspect(handle: int, node: GNode) -> object:
    """Aspect 8 — Reason chain. Walk back to declaration."""
    return node.reason


# ─── cursor_at — fan-out to eight aspects (cursor.mn:100-120) ──────────

def cursor_at(handle: int, graph: dict) -> CursorView:
    node = graph[handle]
    return CursorView(
        query    = query_aspect(handle, node),
        propose  = propose_aspect(handle, node, graph),
        topology = topology_aspect(handle, node),
        row      = row_aspect(handle, node),
        trace    = trace_aspect(handle, node),
        verify   = verify_aspect(handle, node),
        teach    = teach_aspect(handle, node),
        why      = why_aspect(handle, node),
    )


# ─── cursor_argmax — gates × proximity over the live graph ─────────────
#
# Mirrors cursor.mn:227-275 + cursor.mn:299-316. Pure transform.

def caret_proximity_weight(caret_handle: int, target_handle: int, graph: dict) -> float:
    """Mirrors scope_distance_decay in cursor.mn:299-316.
    Tier 0: span line distance approximates scope distance."""
    if caret_handle == target_handle: return 1.0
    c = graph.get(caret_handle)
    t = graph.get(target_handle)
    if c is None or t is None: return 0.2
    if abs(c.span[0] - t.span[0]) <= 1:  return 0.85   # same decl
    if abs(c.span[0] - t.span[0]) <= 5:  return 0.7    # same module
    if abs(c.span[0] - t.span[0]) <= 20: return 0.4    # transitive dep
    return 0.2


def cursor_argmax(caret_handle: int, graph: dict) -> Cursor:
    """gates × proximity argmax over all handles with gradient."""
    best: Optional[Cursor] = None
    for h, node in graph.items():
        suggestion = teach_aspect(h, node)
        if suggestion is None: continue
        gates = len(suggestion.unlocks)
        prox  = caret_proximity_weight(caret_handle, h, graph)
        impact = gates * prox
        c = Cursor(handle=h, located=node.reason, impact=impact)
        if best is None or c.impact > best.impact: best = c
    if best is None:
        return Cursor(handle=caret_handle,
                      located=Inferred("fully annotated"),
                      impact=0.0)
    return best


# ─── Terminal renderer ─────────────────────────────────────────────────

ANSI_BOLD     = "\033[1m"
ANSI_DIM      = "\033[2m"
ANSI_RESET    = "\033[0m"
ANSI_CYAN     = "\033[36m"
ANSI_YELLOW   = "\033[33m"
ANSI_GREEN    = "\033[32m"
ANSI_MAGENTA  = "\033[35m"
ANSI_GRAY     = "\033[90m"


def reason_str(r) -> str:
    if isinstance(r, Inferred):  return f"Inferred({r.s!r})"
    if isinstance(r, Located):   return f"Located@{r.span} ∘ {reason_str(r.reason)}"
    if isinstance(r, Declared):  return f"Declared({r.name!r})"
    if isinstance(r, Fresh):     return f"Fresh(h{r.handle})"
    return repr(r)


def render_program(graph: dict, cursor: Cursor) -> str:
    """Render the program text with the cursor's handle highlighted."""
    lines = [
        "fn add(a, b) with Pure = a + b",
        "fn double(x) = add(x, x)",
        "fn main() = double(21) ??",
    ]
    out_lines = []
    cursor_node = graph.get(cursor.handle)
    cursor_span = cursor_node.span if cursor_node else None
    for i, line in enumerate(lines, start=1):
        if cursor_span and cursor_span[0] == i:
            sl, sc, _, ec = cursor_span
            highlighted = (line[:sc] +
                           ANSI_BOLD + ANSI_YELLOW +
                           line[sc:ec] +
                           ANSI_RESET +
                           line[ec:])
            out_lines.append(f"  {ANSI_GRAY}{i:2d}{ANSI_RESET}  {highlighted}")
        else:
            out_lines.append(f"  {ANSI_GRAY}{i:2d}{ANSI_RESET}  {ANSI_DIM}{line}{ANSI_RESET}")
    return "\n".join(out_lines)


def render_view(view: CursorView, cursor: Cursor) -> str:
    aspects = [
        ("⚓ Query    ", ANSI_CYAN,    view.query),
        ("⚖ Propose  ", ANSI_MAGENTA, ", ".join(view.propose) if view.propose else f"{ANSI_DIM}(no proposals){ANSI_RESET}"),
        ("⤳ Topology ", ANSI_CYAN,    view.topology),
        ("◆ Row      ", ANSI_CYAN,    view.row.label()),
        ("◊ Trace    ", ANSI_CYAN,    view.trace),
        ("✓ Verify   ", ANSI_YELLOW,  ", ".join(view.verify) if view.verify else f"{ANSI_DIM}(no debt){ANSI_RESET}"),
        ("∇ Teach    ", ANSI_GREEN,   _format_teach(view.teach)),
        ("? Why      ", ANSI_GRAY,    reason_str(view.why)),
    ]
    out = []
    out.append(f"  {ANSI_BOLD}{'─' * 60}{ANSI_RESET}")
    out.append(f"  {ANSI_BOLD}cursor at handle h{cursor.handle}  ·  impact = {cursor.impact:.2f}{ANSI_RESET}")
    out.append(f"  {ANSI_BOLD}{'─' * 60}{ANSI_RESET}")
    for label, color, val in aspects:
        out.append(f"  {color}{label}{ANSI_RESET} {val}")
    return "\n".join(out)


def _format_teach(t: Optional[AnnotationSuggestion]) -> str:
    if t is None: return f"{ANSI_DIM}(fully annotated){ANSI_RESET}"
    unlocks = ", ".join(t.unlocks)
    return f"{t.annot}  {ANSI_DIM}→ unlocks {unlocks}{ANSI_RESET}"


# ─── cursor_loop — bus-compressor loop (cursor_transport.mn:292) ───────

def cursor_loop(graph: dict, initial_caret: int = 0):
    """Mirrors cursor_loop in src/cursor_transport.mn. Each iteration
    computes the gradient argmax, projects the eight aspects, renders,
    and waits for an action. ENTER advances; ?? pins; q quits."""
    caret = initial_caret
    print(f"\n{ANSI_BOLD}mentl edit (Tier 0){ANSI_RESET}")
    print(f"{ANSI_DIM}— faithful to src/cursor.mn; bootstrap-independent —{ANSI_RESET}\n")
    print(f"{ANSI_DIM}Press ENTER to advance · type ?? then handle # to pin · q to quit{ANSI_RESET}")

    while True:
        cursor = cursor_argmax(caret, graph)
        view   = cursor_at(cursor.handle, graph)
        print()
        print(render_program(graph, cursor))
        print()
        print(render_view(view, cursor))
        print()
        try:
            action = input(f"{ANSI_BOLD}❯{ANSI_RESET} ").strip()
        except (EOFError, KeyboardInterrupt):
            print(); break
        if action == "q" or action == "quit":
            break
        elif action.startswith("??"):
            tail = action[2:].strip()
            try:
                pinned = int(tail) if tail else cursor.handle
                if pinned in graph:
                    caret = pinned
                    print(f"{ANSI_DIM}cursor pinned to h{pinned}{ANSI_RESET}")
                else:
                    print(f"{ANSI_YELLOW}no handle {pinned}{ANSI_RESET}")
            except ValueError:
                print(f"{ANSI_YELLOW}usage: ?? <handle>{ANSI_RESET}")
        elif action == "":
            # advance: pin to current cursor's handle so next argmax narrows
            caret = cursor.handle
        else:
            print(f"{ANSI_DIM}unknown action: {action}{ANSI_RESET}")

    print(f"\n{ANSI_DIM}— session closed —{ANSI_RESET}\n")


# ─── Entry ─────────────────────────────────────────────────────────────

if __name__ == "__main__":
    cursor_loop(hand_built_graph(), initial_caret=0)
