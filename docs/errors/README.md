# Error catalog

Canonical explanations for every error/warning/teach code the
compiler emits. Mentl's `teach_error` op (spec 09) resolves each
reserved code to its file here.

**Convention.** One file per code, named `<CODE>.md`. Structure:

```markdown
# CODE — Kind

**Kind:** Error | Warning | Teach
**Emitted by:** <module / phase>
**Applicability:** MachineApplicable | MaybeIncorrect

## Summary
One-line human-readable.

## Why it matters
What this tells you about the program.

## Canonical fix
The idiomatic correction. If MachineApplicable, the patch is exact.

## Example
Minimal code triggering it + the fix.
```

**Reserved codes** (spec 06):

| Code | Kind | Emitted by |
|---|---|---|
| [E001](E001.md) | MissingVariable | inference |
| [E002](E002.md) | TypeMismatch | inference |
| [E003](E003.md) | PatternInexhaustive | inference |
| [E004](E004.md) | OwnershipError | `own.ka`, inference |
| [E010](E010.md) | OccursCheck | SubstGraph bind |
| [E100](E100.md) | UnresolvedType | lower |
| [E200](E200.md) | RefinementRejected | Arc F.1 `verify_smt` |
| [V001](V001.md) | VerificationPending | `verify_ledger` |
| [W017](W017.md) | Suggestion | Mentl suggest tentacle |
| [T001](T001.md) | Teach | Mentl teach tentacle |
| [T002](T002.md) | ContinuationEscapesArena | Arc F.4 |
| [P001](P001.md) | ParseError | lexer + parser |

New codes land here BEFORE their first call site. Every `perform
report(...)` names a code whose file exists.
