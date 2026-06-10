# perform-dissolution-substrate — effect ops are called, not performed

> Walkthrough resolving the syntax design question: is `perform op(args)`
> the ultimate form for invoking an effect operation, or is the bare call
> `op(args)` the residue? Opened per SYNTAX.md §Authority ("open a γ-style
> walkthrough, resolve the design question, then update this document").
> Decision: **bare call is canonical; `perform` is format-liftable
> ceremony that dissolves.**

## §1 The question

Every effect-op invocation in Mentl today admits two surface forms:

```
perform check(cond, msg)     // keyword form
check(cond, msg)             // bare call
```

Both produce a call whose callee's type is the op's `TFun` carrying
`Closed[eff]` in its row. Governing principle 2 (SYNTAX.md): *if two
syntactic forms produce the same graph, one is rejected.* The wheel
itself carries both — `src/infer.mn` has 236 `perform` sites while
`lib/test.mn` invokes `check(...)` / `get_results()` bare at every
site. The spec must pick one.

## §2 The eight interrogations

1. **Graph?** The env binding for `op` IS an `EffectOpScheme` whose
   `TFun` row is `Closed[eff]` — definitional since the effect-row
   gate (commit `b84caf1`; `protocol_effect_op_binding_definitional`).
   The graph proves op-ness at declaration. A keyword at the call site
   re-types what the graph proves — interrogation 1 of the three
   constant questions fails for `perform`.
2. **Handler?** Dispatch is the installed handler's; the call site
   names the op, the row routes it. No call-site marker participates
   in dispatch.
3. **Verb?** Invocation is `|>`-shaped data flow into the op; the
   suspension topology (`~>` attachment) lives at the INSTALL site,
   not the call site.
4. **Row?** Effect-ness lives in the ROW. The enclosing fn's `with`
   clause is verified against the row inferred from the body's
   op-call sites — inference walks callee types, not keywords.
5. **Ownership?** Unchanged; args flow per the op's declared params.
6. **Refinement?** Unchanged; op param refinements discharge at the
   call regardless of surface form.
7. **Gradient?** The cursor projects "this call suspends; resume
   cardinality N" from the op's scheme — richer than a binary keyword
   ever was. The keyword is a degenerate, hand-maintained rendering of
   what the Lens fires automatically.
8. **Reason?** The call leaves `VarLookup(op) → Declared(op)` chains
   identical in both forms.

Zero of the eight need the keyword. The keyword exists because the
algebraic-effects literature dialect (Eff's `perform`) was fluent —
foreign-fluency drift at the syntax layer, the same shape as drift 3
(effect-name-set as flat strings): naming the mechanism instead of
letting the algebra carry it.

## §3 Empirical state — the substrate already voted

- Both compiler layers resolve bare op calls END-TO-END today: the
  2026-06-10 te10 micro (`check(true, "ok")` bare inside `fn t1()`,
  handled by a form-2 handle-expr) compiles with 0 diagnostics through
  the seed; env lookup finds the `EffectOpScheme`, the call's row
  carries `Closed[Test]`, the handler intercepts.
- `lib/test.mn`, the framework users imitate first, is 100% bare-call.
- Koka and Frank — the two effect-row languages with the most design
  iteration — both settled on bare op calls.

## §4 Decision

**Bare call `op(args)` is the canonical and only form.** `perform` is
classified **format-liftable**: the formatter strips it silently
(`E_RedundantPerform`, MachineApplicable — the `E_RedundantBraces`
precedent). The reader who needs to see suspension points reads the
row in the signature or the cursor's projection; the medium narrates
what the keyword used to whisper.

`resume` is NOT touched by this decision: it is context-bound (only
meaningful inside an arm), typed by the typed-resume law
(`resume : R -> S`), and names a value the call site cannot otherwise
reach — the continuation. It earns its keyword; `perform` never did.

## §5 Migration shape (peer handle, structural reason)

The spec decision lands now. The code migration is the peer handle
**`Hβ.syntax.perform-dissolution`**: strip `perform` across the wheel
(mechanical; formatter-liftable), then retire `PerformExpr` from the
wheel AST (bare calls already lower through the same row machinery)
and the seed's tag-94 walk. Structural reason this commit cannot carry
it whole: the L1 fixpoint requires seed/wheel parity on every form;
the wheel-wide strip plus dual-layer AST retirement is an atomic,
orthogonal substrate move that must not interleave with the
in-flight Hβ.infer diagnostic-tail grind. Until it lands, the parser
accepts both forms and the formatter owns the strip — the spec names
the canonical; the lathe is being adjusted to it.

## §6 Riders resolved in the same audit (principle-2 enforcement)

- **`TColonColon` deleted.** `::` is lexed today and parsed nowhere
  ("path separator, future"). A token with no kernel correspondence is
  speculative inventory; absence is the statement. Module paths use
  `/` at import position (transport-honest); `.` is the one access
  operator everywhere in expressions. If a namespace form is ever
  earned, it re-enters through this walkthrough process.
- **`TSemicolon` is canonical-never.** Newlines separate statements;
  `;` is a second form for the same graph. It stays lexed so the
  formatter can lift it (`E_StatementSemicolon`, MachineApplicable:
  expand to newline layout); canonical text never contains it.
- **`@` catalog row corrected.** As-patterns (`name @ pat`) ARE the
  user-facing `@` form; the token table claimed none existed.
- **SYNTAX.md's own `<|` example used the rejected `fn (x) =>` lambda
  form.** Corrected to `(x) => ...`. The spec holds itself to its own
  rejections.
- **`E_ResumeOutsideArm` added to the catalog** — surfaced by the
  typed-resume law landing (`dcf6aa6`): `resume` outside a handler-arm
  context is a hard error, not a silent unit.
