---
description: how to extend the self-hosted compiler (std/compiler/)
---
// turbo-all

## Self-Hosted Compiler Architecture

```
std/compiler/lexer.lux    → Token ADTs (Ident, Number, String, Symbol, etc.)
std/compiler/parser.lux   → AST ADTs (Expr, Stmt) via recursive descent
std/compiler/checker.lux  → HM type inference + Why Engine (Ty, Reason, Subst, unification)
std/compiler/codegen.lux  → Bytecode emission (opcode-compatible with Rust VM)
```

## Bootstrap Status: ACHIEVED

The self-hosted pipeline compiles and executes Lux code:
```
source → lexer.lux → parser.lux → codegen.lux → bytecode → load_chunk → execute
Result: println(2 + 3) → 5
```

## Current Capabilities

### Lexer (lexer.lux)
- Identifiers, integers, floats, strings
- Operators (+, -, *, /, ==, !=, <, >, <=, >=, ++, |>)
- Keywords (let, fn, if, else, match, true, false, import, effect, handle, type)
- Symbols (parens, braces, brackets, comma, =, =>, |, ::, ..)

### Parser (parser.lux)
- Expressions: literals, variables, binary ops, unary ops, if/else, match, lists, tuples, blocks, pipes, lambda, call, index, string interpolation
- Statements: let bindings (including destructuring), fn declarations, expression statements, imports, type declarations
- Patterns: PWild, PVar, PLit, PCon (constructor with fields — uppercase convention)
- Types: LetStmt, LetDestructure, FnStmt, ExprStmt, ImportStmt + all Expr variants as ADTs

### Checker (checker.lux)
- HM type inference with unification and occurs check
- Types: TInt, TFloat, TString, TBool, TUnit, TFun, TList, TTuple, TVar, TName
- Why Engine: 14 Reason variants (Literal, VarLookup, Declared, OpConstraint, Unified, FnReturn, FnParam, Applied, CondBranch, ListElement, PipeFlow, Inferred, Because, Fresh)
- Every inference carries a Reason explaining WHY
- `check_and_explain(source, name, depth)` for any-depth explanation
- Environment: association list with lookup
- Substitution: composition and application

### Codegen (codegen.lux)
- Bytecode emission for: literals, vars (local/global), binops, unary, if/else, blocks, let, let destructuring, fn (with closures + upvalue capture), call, pipe, list, tuple, match (with field binding via persistent scrutinee local), variant construction
- Scope tracking (locals with depth, declare/resolve)
- Jump patching (forward jumps for if/else, match arms, short-circuit and/or)
- Match compilation: persistent scrutinee local (_ms), LoadLocal(scr_slot) per arm, bind_pattern_fields for PCon variant field extraction
- Context threading: 8-element tuple (code, constants, names, locals, depth, slot, upvalues, enclosing)
- Full disassembler (4 helper functions)

## Development Pattern

1. **Test with a .lux file first**: Write your test in `examples/` using `import compiler/<module>`
2. **Run with --no-check**: `cargo run --quiet -- --no-check examples/<test>.lux`
3. **Full pipeline test**: `cargo run -- --no-check examples/bootstrap_pipeline_test.lux`
4. **Golden tests**: `cargo test --test examples` — verify no regressions
5. **Thread state through context**: All compiler passes use the `(code, constants, names, locals, depth, slot, upvalues, enclosing)` tuple threading pattern
6. **Use ADTs for everything**: Token, Expr, Stmt, Ty, Reason — all ADT types declared in each module

## Key Opcode Numbers (must match src/vm/opcode.rs)
```
LoadConst=0, LoadInt=1, LoadBool=2, LoadUnit=3
LoadLocal=10, StoreLocal=11, LoadUpval=12
LoadGlobal=20, StoreGlobal=21
Add=30, Sub=31, Mul=32, Div=33, Mod=34, Neg=35, Not=36
Eq=40, Neq=41, Lt=42, LtEq=43, Gt=44, GtEq=45
Concat=50
Jump=60, JumpIfFalse=61, JumpIfTrue=62, Pop=63, Dup=64
MakeClosure=70, Call=71, Return=72, TailCall=73
MakeList=80, MakeTuple=81, ListIndex=82, MakeVariant=84
MatchVariant=93, MatchWildcard=97, BindLocal=98
StringInterp=130
```

## Masterpiece Check

Before modifying any compiler module, ask:
> Is this what the ultimate programming language's self-hosted compiler would look like?
> Read `docs/INSIGHTS.md` if unsure about the philosophical direction.
