# Mentl — The Ultimate Medium, Projected

> *The medium IS one read at P. This document is that read, projected over the whole.*

This is the visual companion to `docs/ULTIMATE_MEDIUM.md` and `docs/SUBSTRATE.md`. Every box below is a substrate truth; every edge a chase. The diagram IS the medium's own self-representation — the cursor projecting the cursor.

---

## I. The kernel ↔ tentacles ↔ surfaces ring

The eight-primitive kernel surfaces through eight tentacles via canonical syntactic forms. ONE primitive, ONE tentacle, ONE surface group. No drift; no parallel representation.

```mermaid
graph LR
    subgraph Kernel ["EIGHT-PRIMITIVE KERNEL (DESIGN.md §0.5)"]
        K1[#1 Graph + Env]
        K2[#2 Handlers w/ typed-resume]
        K3[#3 Five verbs]
        K4[#4 Boolean effect algebra]
        K5[#5 Ownership-as-effect]
        K6[#6 Refinement types]
        K7[#7 Continuous gradient]
        K8[#8 HM + Reasons]
    end

    subgraph Tentacles ["EIGHT TENTACLES (projections at the cursor)"]
        T1[Query: walk the graph]
        T2[Propose: oracle multishot]
        T3[Topology: pipe shapes]
        T4[Unlock: row gates]
        T5[Trace: ownership + region]
        T6[Verify: predicate discharge]
        T7[Teach: gradient narration]
        T8[Why: Reason chain]
    end

    subgraph Surfaces ["SURFACE FORMS (SYNTAX.md sections)"]
        S1["import / module env"]
        S2["effect / handler / handle / ~> / perform / resume"]
        S3["|>  <|  ><  ~>  <~"]
        S4["with E1 + !E2 + Pure"]
        S5["own / ref + !Alloc / Consume"]
        S6["type X = Y where pred"]
        S7["T_Gradient / W_Suggestion / annotations"]
        S8["No turbofish; ?? hole; Reason in every diagnostic"]
    end

    K1 --> T1 --> S1
    K2 --> T2 --> S2
    K3 --> T3 --> S3
    K4 --> T4 --> S4
    K5 --> T5 --> S5
    K6 --> T6 --> S6
    K7 --> T7 --> S7
    K8 --> T8 --> S8
```

**Reading:** every surface form on the right is one syntactic form away from the corresponding kernel primitive on the left. No tentacle exists without its kernel ground; no surface form exists without its tentacle. The 1↔1↔1 binding IS the discipline.

---

## II. The cursor's read at one position P

The cursor IS the global argmax — gradient × proximity × stability. At any position P (developer caret OR queued attention), `cursor_default(P)` performs ONE `graph_chase` and projects all eight aspects from that single read. The eight tentacles are not separate computations; they are aspects of one read.

```mermaid
graph TB
    P((Position P))
    P --> Chase[graph_chase H]
    Chase --> GNode["GNode at H<br/>Reason inline<br/>Ty bound<br/>EffRow chained"]

    GNode --> A1[Type aspect: NBound's Ty]
    GNode --> A2[Effect-row aspect: chase TFun's row]
    GNode --> A3[Refinement aspect: TRefined inside Ty]
    GNode --> A4[Ownership aspect: TParam own/ref/Inferred]
    GNode --> A5[Reason aspect: GNode.reason chain]
    GNode --> A6[Gradient aspect: gates_unlocked × proximity]
    GNode --> A7[Pattern-completeness: NErrorHole hints]
    GNode --> A8[?? capture: developer's narrow override]

    A1 --> CursorView[CursorView record]
    A2 --> CursorView
    A3 --> CursorView
    A4 --> CursorView
    A5 --> CursorView
    A6 --> CursorView
    A7 --> CursorView
    A8 --> CursorView

    CursorView --> Render["terminal_transport renders 8 aspects<br/>OR<br/>oracle proposes next move<br/>OR<br/>Why-Engine walks reason chain<br/>OR<br/>format projects canonical layout"]
```

**Reading:** the cursor IS one chase. The eight aspects are projections of the same GNode. `mentl edit` renders them; `mentl propose` enumerates next-position candidates; `mentl query --why H` walks the chain; `mentl format` rewrites to canonical form. ONE substrate, FOUR observers.

---

## III. The compile pipeline as cursor-mode traversals

Each subsystem (lex, parse, infer, lower, emit, verify, oracle) IS the cursor traversing the graph in a specific mode. NOT separate compilers chained sequentially — ONE cursor reading the graph at different layers.

```mermaid
graph LR
    Source["source bytes<br/>(read_stdin or file)"]
    Source --> Lex["LEX cursor mode<br/>scan + emit token-node<br/>read: source bytes<br/>write: token list"]
    Lex --> Parse["PARSE cursor mode<br/>tokens → AST nodes<br/>read: token kinds<br/>write: GNode handles"]
    Parse --> Infer["INFER cursor mode<br/>HM live + Reasons<br/>read: AST node body<br/>write: NBound + Reason"]
    Infer --> Lower["LOWER cursor mode<br/>typed-AST → LowExpr<br/>read: lookup_ty(handle)<br/>write: LowExpr tree"]
    Lower --> Emit["EMIT cursor mode<br/>LowExpr → WAT<br/>read: graph node + LowExpr<br/>write: WAT bytes"]
    Emit --> Wasm[("mentl2.wasm<br/>(or any compiled module)")]

    Verify[VERIFY cursor mode] -.predicate discharge.-> Infer
    Oracle["ORACLE cursor mode<br/>multishot proof-search"] -.candidate enumeration.-> Infer

    Why["WHY-ENGINE cursor mode<br/>walks Reason chain"] -.reads.-> Infer
    Format["FORMAT cursor mode<br/>canonical layout"] -.reads.-> Parse
    Audit["AUDIT cursor mode<br/>capability surface"] -.reads.-> Infer
    Edit["EDIT cursor mode<br/>8-aspect render"] -.reads.-> Infer
```

**Reading:** lex/parse/infer/lower/emit are NOT pipeline stages — they are cursor modes. Each reads the graph at its own layer and writes back to the graph. Verify, Oracle, Why-Engine, Format, Audit, Edit are SIBLING modes — they read the same graph (post-infer) for different surfaces. The wheel IS the graph; every observer reads via `graph_chase`.

---

## IV. The five-verb topology

The five verbs DRAW SHAPES on the page; the shape IS the computation graph. Layout is contract.

```mermaid
graph LR
    subgraph Sequential ["|> Sequential (left edge)"]
        SQ1[a] --> SQ2[b] --> SQ3[c]
    end

    subgraph Divergent ["<| Divergent (multi-shot fanout)"]
        DV0[input] --> DV1[branch 1]
        DV0 --> DV2[branch 2]
        DV0 --> DV3[branch N]
    end

    subgraph Parallel [">< Parallel compose (independent pipelines)"]
        PA1["(a |> b)"]
        PA2["(c |> d)"]
        PA1 ---|><| PA2
    end

    subgraph Handler ["~> Handler attach (inline OR block)"]
        HA1[body] --> HA2["~> handler<br/>state slots install"]
    end

    subgraph Feedback ["<~ Feedback loop (iterative context)"]
        FB1[output] -.feeds back.-> FB2[input]
    end
```

**Reading:** `|>` ALWAYS at left edge; `<|` at left edge with branch tuple; `><` at INDENTED center between parenthesized pipelines (Form A vertical / Form B inline); `~>` at left edge (block form) or inline-attached; `<~` at INDENTED center.

Per SUBSTRATE.md §II layout convention: sequential operators at left edge — flow goes DOWN; convergent operators at indented center — they DRAW SHAPE.

---

## V. The Boolean effect algebra at the type level

Every signature carries an effect row. The row IS a kernel value (per kernel primitive #4). Row composition is structural — `+ - & ! Pure` are operators on rows.

```mermaid
graph TB
    R0["Pure (empty row)"]
    R0 --> R1["+E (add effect)"]
    R0 --> R2["!E (negate; absent)"]
    R1 --> R3["E1 + E2 (union)"]
    R3 --> R4["E1 & E2 (intersection)"]
    R3 --> R5["E1 - E2 (difference)"]
    R3 --> R6["E1 + !E3 (union with absence proof)"]

    R6 --> Verify1[infer: row composes against body's perform sites]
    Verify1 --> Check1{declared subsumes inferred?}
    Check1 -->|yes| OK[OK; T_OverDeclared if wider]
    Check1 -->|no| Fail[E_EffectMismatch]
```

**Reading:** the row at a signature site is a CONSTRAINT against which the body's `perform` sites are verified. Wider declared row → T_OverDeclared gradient suggestion (narrow to unlock capability). Body performs IO when `!IO` declared → E_PurityViolated.

Capabilities (per the just-landed Capability declarations) ARE rows — `capability File = read + write` is a row alias.

---

## VI. Refinement, ownership, gradient — composing at one type

A single value's type can carry refinement + ownership + Reason simultaneously. The kernel composes them; the cursor projects them at one position.

```mermaid
graph LR
    Value[a value's handle H]
    Value --> Ty["Ty at H<br/>(e.g., Int)"]
    Value --> Pred["Refinement at H<br/>(e.g., where 0 <= self <= 255)"]
    Value --> Own["Ownership at H<br/>(own / ref / Inferred)"]
    Value --> Row["Effect row of producing fn<br/>(e.g., +Memory + +Alloc)"]
    Value --> R["Reason chain at H<br/>(why this binding exists)"]
    Value --> G["Gradient at H<br/>(annotations that would unlock more)"]

    Pred --> Discharge["verify_ledger:<br/>constant → predicate_decide<br/>variable → verify_smt"]
    Own --> Use["check_use: 0/1/2+ uses<br/>own / ref / E_OwnershipViolation"]
    Row --> Sub["row_subsumes at call site"]
    R --> WE["Why-Engine walks back to source-bytes origin"]
    G --> Teach["mentl edit shows annotation INPUT to narrow"]
```

**Reading:** the eight aspects co-exist on one value. The cursor's read projects ALL eight. The medium NEVER asks "what type?" without also knowing refinement, ownership, row, Reason, gradient. That's the kernel-closure claim.

---

## VII. Mentl utilizes Mentl — the reflexive surface

Mentl IS reflexive — it reads itself, proposes on itself, formats itself, parallelizes on itself. The medium runs on its own substrate. Post-L1 closure (mentl2 == mentl3), every surface verb operates on the wheel's own source.

```mermaid
graph TB
    Wheel["WHEEL SOURCE<br/>src/*.mn + lib/runtime/*.mn"]

    Wheel --> Compile["mentl compile<br/>(self-compile via <| / ><<br/>parallel per-module)"]
    Wheel --> Edit["mentl edit src/parser.mn<br/>(cursor renders 8 aspects)"]
    Wheel --> Doc["mentl doc src/parser.mn<br/>(API docs from cursor projection)"]
    Wheel --> Audit["mentl audit src/parser.mn<br/>(capability surface report)"]
    Wheel --> Propose["mentl propose <hole>@src/...<br/>(oracle proposes ≥2 candidates)"]
    Wheel --> Format["mentl format<br/>(round-trip byte-identical)"]
    Wheel --> Test["mentl test lib/tutorial/<br/>(USP integration tests)"]
    Wheel --> Bootstrap["bootstrap/build.sh<br/>invokes mentl2.wasm"]

    Compile --> ParallelCores["empirically uses ≥N cores"]
    Edit --> EightAspects["8 aspects rendered<br/>?? gradient narrow"]
    Doc --> CursorProjection["docstrings + sigs + rows<br/>+ refinements + Reason chains"]
    Propose --> MultishotProof["≥2 type-proven candidates<br/>each with Reason chain"]
    Bootstrap --> Dissolves["hand-WAT seed archaeology"]
```

**Reading:** Mentl utilizes Mentl means each `mentl <verb>` invocation operates on the wheel itself coherently. The medium IS reflexive only when this composes. Post-L1, the cascade unlocks naturally — each surface verb reads the SAME graph the compile pipeline produces.

---

## VIII. The reflexive cascade — Mentl reads Mentl reads Mentl

```mermaid
graph TB
    L1["L1 CLOSURE<br/>(mentl2 == mentl3 byte-identical)"]
    L1 --> Tier3Trans["Tier 3 transcription<br/>(each Phase μ peer's .seed.wat self-compiles)"]
    Tier3Trans --> Multithread["T1.7 multithreading<br/>wheel uses <| / ><"]
    Multithread --> Oracle["T1.1 oracle multishot<br/>parallelized via <|"]
    Oracle --> Cursor["T1.5 cursor projects 8 aspects<br/>during live editing"]
    Cursor --> Reflexive["T1.8 reflexive surface<br/>every USP claim demonstrated<br/>BY the wheel ITSELF"]

    Reflexive --> Surpass[("MENTL IS THE END-ALL-BE-ALL<br/>by empirical demonstration"]

    style Surpass fill:#1a1
```

**Reading:** the cascade is a feedback loop on itself. Each level proves the next. L1 closure proves the kernel compiles itself. Tier-3 transcription proves each module self-compiles. Multithreading proves the wheel's compile uses its own parallelism. Oracle proves the multishot substrate. Cursor proves the eight-aspect projection. Reflexive surface proves it all on real wheel code. Every reduction in compile time IS the wheel's own parallelism substrate proving itself on its own source.

NO other language has this property. Rust's parallel compile isn't written in Rust's effect system; Haskell's `par`/`pseq` isn't compiled by `par`/`pseq` itself. Mentl utilizes Mentl IS the end-of-end-all-be-all.

---

## Cross-references

- `docs/ULTIMATE_MEDIUM.md` — thesis statement and §8 day-in-the-medium
- `docs/SUBSTRATE.md` §I-IX — kernel + verbs + algebra + handlers + gradient + refinement + theorems
- `docs/DESIGN.md` §0.5 — the eight primitives
- `docs/SYNTAX.md` — surface forms per primitive
- `docs/specs/simulations/Hμ-cursor.md` — cursor projection substrate
- `protocol_ultimate_medium.md` — protocol crystallization
- `protocol_cursor_is_argmax.md` — cursor IS attention not text-caret
- `protocol_cursor_is_the_substrate.md` — every subsystem is the cursor in a different mode
