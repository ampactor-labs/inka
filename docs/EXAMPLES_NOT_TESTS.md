# Examples, Not Tests

*Lux doesn't have tests. It doesn't have debug scripts. It doesn't have
specs or doc-tests. It has `.lux` files. A file that runs is a proof.
A file that crashes is a question. There is no third thing.*

---

## One Act

Other languages split development into categories:

- **Testing** — write code that checks code
- **Debugging** — write code that finds broken code
- **Documentation** — write prose that explains code
- **Specification** — write descriptions that precede code

In Lux these are the same act: **write a `.lux` file that exercises the
mechanism.** The categories dissolve because `handle` is the universal
joint:

```lux
handle { computation } with state = initial {
  operation(args) => resume(result) with state = updated
}
```

- **Setup** — handler-local state (`with state = initial`)
- **Mock** — the handler body (decides what every operation means)
- **Assert** — the return value (if it's wrong, you see it)
- **Teardown** — `resume` (the handler controls what happens next)

A test framework would be a second mechanism for something the language
already does. In Lux, that's wrong by construction.

---

## The Debugging Gradient

A bug is an example that crashes. Debugging is making the example smaller.

```
wasm_check.lux (crashes)
  → lex_test.lux (crashes — just the lexer)
    → lex_pattern.lux (crashes — simulated lexer)
      → mutual2.lux (crashes — 4 inner functions)
```

Each step is a smaller `.lux` file. The minimal file that crashes IS the
diagnosis. When it runs, the bug is fixed. No debugger. No breakpoints.
No step-through. Just: write what should work, run it, make it smaller
until the answer is visible.

The compiler helps at every step — type errors narrow the search, effect
violations point to the mechanism, the Why Engine explains the inference.
The debugging tool IS the compiler. The debug script IS an example.

---

## The Unification

| Other languages | Lux |
|----------------|-----|
| Test suite | `examples/` |
| Test runner | `for f in examples/*.lux; do lux "$f"; done` |
| Mock library | Handler swap |
| Debugger | Smaller example |
| Doc-test | Example that teaches |
| Spec | Example that precedes |
| CI check | Same examples, different machine |

No special naming. No categories. No boundaries. A `.lux` file is a
`.lux` file. The folder is `examples/`. The command is `lux examples/`.
The act is: write what should work, run it, see the light.

---

## Records, Not Packages

A handler is a record: `{ op: |args| resume(...), ... }`. A module
exports functions. Functions are values. A "package" is a record you
import by path.

```lux
import compiler/ty
import dsp/filters
```

The effect signature IS the API contract. `!IO` is a proof, not a
promise. `!Network` means provably no network access — enforced by the
type system, not a sandbox, not a policy file. A module with
`with Compute, Log` literally cannot perform IO. The compiler proves it.

What a package manager solves, Lux solves with what it already has:
- **Discovery** — the effect signature tells you what a module does
- **Trust** — `!IO` is a proof, not a promise
- **Versioning** — types match → it works; types don't → compile error
- **Resolution** — `import` is a path; paths compose; no solver needed

Distribution is `git clone`. Not a language feature.
