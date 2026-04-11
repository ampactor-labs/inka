# Handoff — WASM Self-Compilation: wasm_check runs in WASM, stage-2 blocked on "expected Eq" parser errors

## TL;DR (2026-04-11)

**The WASM-compiled checker now works in WASM.** `cat examples/wasm_check.lux | bs.cwasm` → valid WAT → `21` (env length for `let x = 42`). Commit `a9e1cd6` made this possible by replacing seven `to_string(stmt/reason) + starts_with("FnStmt(")` checks with proper `match` on ADT variants. `memory.lux`'s `to_string` (used in WASM) is a stub that returns the raw pointer for any val ≥ 1024 — it cannot render variants. Every `prescan_fns_at`, `needs_instantiation`, `is_builtin_reason`, etc. was silently classifying every Stmt as non-FnStmt inside the WASM bootstrap. Match extracts variants directly — the answer was in the structure all along.

**Current verified state** (bs9 = `/tmp/bs9.cwasm`, built from HEAD 2026-04-11):
- 3a–3f all pass: wasm_step1=42, wasm_step2=42, wasm_step3=hello world, wasm_counter=count=3, wasm_mini_checker needs `to_string` wrap (fold-in-handler works; bare `println` on polymorphic Int is a separate dispatch issue), wasm_check=21 ✅
- Self-compile stage 2 is BLOCKED. Feeding any file that transitively imports `compiler/pipeline` triggers three parse errors: `Parse error [1261:19]: expected expression got Eq`, `[1267:31]`, `[1290:36]`. Pipeline then recurses into Levenshtein (`find_similar_name` → `build_chars` → stack overflow) because the parse errors produce missing-variable errors the checker tries to help with.
- Parsing the same files in isolation works: `cat codegen.lux | bs9.cwasm` → 43842 lines valid WAT. `lex` and `parse_program` on codegen's content both succeed (11181 tokens, 163 AST items). So the parse errors only fire from *inside* pipeline's `resolve_and_check_at`.
- Key unsolved question: what file's line 1261 is actually failing? None of the large files (parser.lux 1285, codegen.lux 1426, lower.lux 1226) have `=` at col 19 on line 1261. The WASM lexer's line/col counter may be drifting. Line 1226 of lower.lux is < 1261 but error line 1261 exists in parser and codegen — likely codegen since 1267 and 1290 also appear.

**What NOT to revert:** `a9e1cd6` (match-based structural fixes), `cb6e39a` (join_loop workaround — still in place), `592279d` (val_concat fallback), `d2e7ea7` (walker fix), `fedb430` (shadow-capture).

**What I tried and reverted** (failed — instructive):
1. Let-generalization via `starts_with(s, "fn ")` in `needs_instantiation`: works via Rust VM (`fold([1,2,3], 0, add) = 12`, `join(["a","b","c"], "-") = "a-b-c"`) but breaks `is_handler_global` when the bootstrap is rebuilt — the WASM emitter started emitting handler state as LOCALS instead of GLOBALS, producing 9 `UNRESOLVED: __hs_acc_N` references. Handler state lifted to globals only works when `is_handler_global(name)` detects them; with polymorphism the lowerer passes `name : TVar` to `to_string`, which falls through to `int_to_str`, corrupting the pointer before the `string_slice` check. This is downstream: the `to_string(name)` dispatch in `lower.lux:151-156` defaults polymorphic args to `int_to_str` — you need either full type propagation or a runtime `to_string` that can handle both ints and strings.
2. Routing polymorphic to_string to the runtime's `to_string` function: breaks `to_string(int)` for compile-time int literals like data segment offsets (runtime `to_string` returns val unchanged for val ≥ 1024, but the emitter expected a string). Runtime to_string's `val ≥ 1024` heuristic is broken for int literals that happen to be large.

**The REAL fix for fold polymorphism**: let-generalization AND a type-aware `to_string` lowering. Both are needed. The `to_string` in `memory.lux` needs to be a real variant-renderer (walk the ADT, emit tag + fields) — not the current `if val >= 1024 { val }` stub. Before that, the compile-time dispatch needs to handle all primitive types (String, Int, Float, Bool) and fall through to... something that actually works for composite values. Deferred until someone wants to sink a couple hours into it.

**The goal:** Lux is the ultimate programming language. The teaching gradient is so good it makes coding-AI obsolete. Self-containment (no Rust) is **priority #1** — not because deleting Rust is the destination, but because building anything on top of Rust-VM-only behavior is wasted effort. Every fix to the WASM bootstrap is verifying a load-bearing claim of the thesis. (See `docs/INSIGHTS.md` and `docs/DESIGN.md`.)

**Where to start the next session:**
1. Find which file triggers `Parse error [1261:19]: expected expression got Eq`. Add one line to `resolve_and_check_at` in `pipeline.lux:428`: `let _ = println(";;DBG parse: " ++ path)` immediately before `let mod_ast = ...`. Rebuild bootstrap once (~5 min). Run `cat /tmp/use_pipeline_strip.lux | bs.cwasm > /tmp/out 2>&1` — the last `;;DBG parse:` line before the errors tells you exactly which file. Revert after.
2. Once identified, compare how the Rust-VM parser handles that file (`lux check <file>`) vs the WASM bootstrap. The line/col numbers (1261:19, 1267:31, 1290:36) may be drifting due to a bug in how `lex_from` tracks position across long input or across recursive file loads — add another print at the top of `lex_from` showing `pos, line, col` and see where they diverge from the file's actual layout.
3. Fix the file or the lexer. Rebuild. Re-run `cat examples/wasm_bootstrap.lux | bs.cwasm` for stage 2.

**Read first:** `docs/INSIGHTS.md` "Pure Transforms for Structure" and "Self-Compilation: The Cage and the Light", then the rest of this file.

## Why "delete Rust" is priority #1 even though it's not the goal

Morgan's logic, condensed: when we eventually have to make Lux self-contained, many implementations will need to change. So anything we build NOW on Rust-VM assumptions is potentially throwaway. Get the foundation right first, then build on solid ground. Also: the playground requires WASM bootstrap (browsers run WASM, not the Rust VM). So this isn't even abstract — there's a concrete demo vehicle that can't ship without it.

## How we got here (the chain that worked)

The Rust VM has lenient memory semantics — its own allocator, its own runtime polymorphism, its own closure model. The self-hosted compiler was written assuming all of those, and was never stress-tested against WASM's strict semantics. Every WASM bootstrap crash was a *latent bug* the Rust VM had been papering over for as long as that code existed.

Eight commits between `57cbe8e` (the consolidation refactor that made the bootstrap able to even reach the runtime) and `16885cf` (the actual fix that made it work). In order:

1. **`d2e7ea7` walk_ir into LMakeClosure fn_def** — the IR walker was blind to closure bodies, so `subst_state_to_cells` couldn't reach handler state variables hidden inside handler arm closures. The checker's substitution `s` got emitted as a null pointer, and the WASM-compiled checker read source-code bytes ("fn f") as type pointers. *Fixed: pure structural transform — walk into the body too.*

2. **`d2e7ea7` substitute the handler record before storing** — `install_stateful_evidence` was running `subst_state_to_cells` on `LIndex(record, i)`, a runtime extraction expression with zero state variable names in it. Always a no-op. Now substitute the *whole* `lowered_handler` so closures inside get their `s → __hs_s_42` renames.

3. **`d2e7ea7` `__call_ptr` double-emit** — the `57cbe8e` consolidation introduced a single `__call_ptr` temp for indirect calls. Nested closure calls (`lex_from(skip_comment(pos+2), ...)`) clobber it. *Fixed: emit the func expression twice — computed func exprs in this position are pure capture reads.*

4. **`d2e7ea7` `is_state_var` effect** — `collect_free` walks the AST without knowing which names are handler state variables. So state vars (`s`, `n`, `acc`) got falsely captured by handler arm closures, then the closure read them by value at creation time, missing all the mutations. *Fixed: add `is_state_var(name) → Bool` to `LowerCtx`. `lower_handle` installs a handler that knows the current `state_names`. `filter_real_captures` fires the effect to drop state vars from capture lists. Same mechanism as `is_ctor` and `is_global`.*

5. **`d2e7ea7` ResumeExpr stash** — `lower_expr` for `ResumeExpr(value, updates)` was dropping the updates entirely. The Rust VM doesn't care because resume is a VM opcode that handles updates separately, but the WASM closure body needs them to be actual writes. Now stash the value, apply updates, return stash. Order is critical: the value reads OLD state, then updates fire.

6. **`d2e7ea7` `collect_free` AST coverage** — added `TupleExpr`, `ListExpr`, `MatchExpr`, `ResumeExpr`, `HandleExpr`. Without these the capture detector fell through `_ => []` and missed any free variables hidden inside resume bodies, match arms, or tuple/list expressions. `MatchExpr` extracts pattern-bound names so they don't become false-positive captures. `HandleExpr` adds state binding names to bound so they don't propagate as outer-function captures.

7. **`24dfdc5` LRegion unsound for TUnit** — `is_region_safe_ty` had `TUnit => true`. The lowerer wrapped any handle block with a Unit-typed body in `LRegion`, which resets `heap_ptr` after the body. But effect operations declare `-> ()` (Unit) while handlers can resume with arbitrary heap values (List, Tuple, Variant). `map(f, xs)` is the archetype: body is `iterate(xs); result()`, declared Unit, but resumes with `acc` (a List). LRegion freed the returned List the moment `map` returned. *Fixed: TUnit removed from region-safe set.*

8. **`24dfdc5` aggressive alloc + sanity trap** — `emit_alloc` was growing memory by exactly the pages needed (causes fragmentation/grow thrash) and silently dropped `memory.grow`'s return value (so failures became delayed memory faults). Now grows by the larger of (need, current size) — doubling strategy — and traps explicitly on grow failure.

9. **`ab2ed0d` larger vstack + bigger initial memory** — `__vsp` is a per-program "variant stack" the WASM emitter uses to save intermediate pointers during nested expression construction. It was 1024 slots (4 KB). Deeply nested expressions in the self-hosted compiler push more than 1024, overflowing into the heap and silently corrupting whatever was there. Bumped to 256 K slots (1 MB).

10. **`16885cf` THE root cause: `infer.lux` Concat type** — the checker had `if op == "Concat" { TString }`. Unconditionally. Every `a ++ b` was inferred as a String regardless of operand types. The Rust VM's `OpCode::Concat` dispatches on runtime types, so it always worked. But the self-hosted WASM lowerer trusts inferred types to pick `str_concat` vs `list_concat`. Polymorphic functions like `string_union(a, b)` got `a : String` even though `a` was a list, and the WASM-compiled code called `str_concat` on list data, byte-copying instead of i32-copying, corrupting every pointer. *Fixed: defer like arithmetic — unify operands, resolve, commit only when one side is concretely TString or TList; if both are TVars, return the unified tvar.*

## The methodology that finally worked

I spent **hours** chasing crash addresses, increasing memory limits, adding sanity checks, guessing at root causes. Each "fix" revealed another layer. The breakthrough came in ~30 minutes when I **stopped guessing and built instrumentation**.

**Instrumentation that broke open the wall** (commit `16885cf` discovery path):
1. Added a `;;EGD idx=N nlen=L` debug print at the start of every iteration in `emit_global_decls`. **First run**: showed every name in `top_globals` had the same corrupted length (7820 bytes — turned out to be `fd_write`'s nwritten count from the previous print, read as a "name length" because the name pointer was actually `__closure + 8` from a falsely-captured pattern variable).
2. Added `CONCAT lt=... rt=... left_ast=...` print to `lower.lux`'s BinOp Concat handler. **First run**: showed `CONCAT lt=TString rt=TList(TUnit) left_ast=S(VarRef("a"), 4, 16)`. Line 4 col 16 of the test file was the `a` in `union`. Inferred as TString. Pointed straight to `infer.lux`.

**The lesson — and Morgan's directive going forward:** when you don't know what's wrong, BUILD A TOOL THAT TELLS YOU. Instrumentation is cheap. Guessing is expensive. The pattern that worked was always *one debug print revealing the root cause in one run*. Stop pattern-matching from symptoms.

**Concretely going forward:** before chasing any new WASM bug, write the smallest possible debug print that distinguishes the hypothesis. Run it once. Then fix.

## Verification commands

```bash
# All four crucibles (Rust VM produces WASM)
lux wasm examples/wasm_hello.lux > /tmp/t.wat 2>/dev/null && wasmtime run --dir . /tmp/t.wat   # Hello, World!
lux wasm examples/wasm_ultimate.lux > /tmp/t.wat 2>/dev/null && wasmtime run --dir . /tmp/t.wat # fib(10) = 55
lux wasm examples/wasm_counter.lux > /tmp/t.wat 2>/dev/null && wasmtime run --dir . /tmp/t.wat  # count = 3
lux wasm examples/wasm_check.lux > /tmp/t.wat 2>/dev/null && wasmtime run --dir . -W max-wasm-stack=33554432 /tmp/t.wat # 21

# Build the bootstrap (~5 min)
lux wasm examples/wasm_bootstrap.lux > /tmp/bs.wat 2>/dev/null
wasmtime compile /tmp/bs.wat -o /tmp/bs.cwasm

# Run the bootstrap on a Lux program — THIS IS THE WIN
echo 'let x = 42' | wasmtime run --allow-precompiled --dir . -W max-wasm-stack=16777216 /tmp/bs.cwasm > /tmp/out.wat
wc -l /tmp/out.wat       # ~6685 lines
grep -c UNRESOLVED /tmp/out.wat  # 0
wasmtime compile /tmp/out.wat -o /tmp/out.cwasm  # validates clean
```

## What's still broken

### 1. Multi-line input fails to lex/parse correctly in the WASM bootstrap

The symptom: `printf 'let a = 1\nlet b = 2' | bs_final.cwasm` → `Parse error [1:20]: expected Eq got Eof`. The parser reports line 1 col 20 — meaning the lexer never incremented the line counter past the newline. Single-line input (semi-separated or no separator at all) works fine. A direct `lux wasm examples/wasm_lex_probe.lux` built from the same `lex` function handles the same multi-line input correctly (10 tokens), so it's not a lexer source bug — it's another "Rust VM papers over X" thing that only fires when `lex` runs inside the full compiler binary.

**Confirmed NOT the problem** (already checked via probes):
- `read_stdin()` reads newlines correctly (verified: len=12, last_byte=10 for `line1\nline2\n`)
- `is_whitespace(ch)` correctly returns false for newline (verified via probe: `not_ws`)
- `ch == "\n"` correctly returns true for a newline char (verified: `EQ`)
- `chars()` + `byte_at()` correctly read all bytes including newlines
- `split("\n", s)` works (returns 2 elements for two-line input)

So the primitives are fine. The bug is somewhere in how `lex_from` or `prog_loop` behaves at scale in the bootstrap. Possibilities:
- Tail-call recursion depth issue that diverges silently
- String literal `"\n"` in `lex_from` body being compiled to the wrong data offset when many strings are interned
- Closure capture of `cs`/`src_len` in the nested `lex_from` becoming stale

**Methodology:** write a probe that calls `lex` on multi-line input inline (no imports), compile via bootstrap, inspect token count. If lex returns < 10 tokens, find where it stopped.

### 2. Inner `let x` shadowing top-level `let x` (follow-up from fedb430)

Commit `fedb430` fixed the param-shadow case: when an inner function references a name that's a parameter of an enclosing function AND also a top-level global, the capture detector now keeps the reference as a real capture (via `env_lookup`'s `Declared("param")` reason). That alone is what was making `fold(map(dbl, [1,2,3]), 0, add)` return 6 instead of 12 — iterate's `go_0` was reading global `$xs` (the user's `let xs = [1,2,3]`) instead of iterate's parameter (which at runtime pointed at the mapped `ys`).

Not yet handled: the parallel case where an **inner let** shadows a top-level `let`:
```lux
let x = 1
fn f() = { let x = 2; fn g() = x; g() }  // returns 1, should return 2
```
Both bindings are `Inferred("let")` in env so the current fix can't distinguish them. Options:
- give inner lets a different reason (e.g. `Inferred("local-let")`) in `extend_env_from_stmt`
- track env extension positions so we can tell top-level from inner
- do a count-based shadow check filtered to names that are actually in `top_globals` (the broad count-based check crashed the `check` crucible last time, but restricting it to top_globals-only names may work)

Uncommon in idiomatic code but worth fixing for correctness.

### 3. Bootstrap-compiles-itself not yet verified

The big claim: feed `wasm_bootstrap.lux` to `bs_final.cwasm` and get a new bootstrap WAT. Blocked by #1 and #2. Each fix unblocks more of the self-compile path, and the methodology is reliable now — `lux lower` + `tools/probe.sh` + write small probes.

```bash
cat examples/wasm_bootstrap.lux | wasmtime run --allow-precompiled --dir . -W max-wasm-stack=33554432 /tmp/bs_final.cwasm > /tmp/stage2.wat
```

This will reveal more latent bugs. Use the instrumentation methodology — don't guess.

### 3. Then: tear down `src/`

Once stage2 works and produces identical output to stage1, the self-hosted compiler is fully self-contained. The Rust VM is no longer needed for the actual compilation work. What remains:

- Audit `src/` for what's still required (probably: just the bootstrap loader that runs `bs.cwasm` from `lux` CLI)
- Replace `lux` with a thin shell wrapper / Rust shim that calls `wasmtime run bootstrap.cwasm` with stdin/stdout plumbing
- Delete the Rust lexer, parser, compiler, VM, etc.
- Ship `bootstrap.cwasm` in the repo as a binary asset

## What the playground needs (the downstream prize)

When `rm -rf src/` is done, the playground becomes possible:

- A browser textarea for Lux source
- A WASI shim for the browser (small JS that maps `fd_write`/`fd_read`/`path_open` to in-browser filesystem)
- `bootstrap.cwasm` runs in the browser via wasmtime-web or wasmer-js or just direct WebAssembly instantiation
- User types Lux → bootstrap.cwasm compiles to WAT → another WASM compile → run → output pane
- Bonus: **the teaching gradient runs alongside** — every annotation suggestion, every inferred type, every effect propagation visible in real time

This is the demo that proves the thesis: a compiler that teaches you in your browser.

## Where to start the next session

**Immediate task: find the multi-line lex/parse bug in the bootstrap runtime.**

The workflow that works now:
1. `tools/probe.sh lower <file>` — see the LowIR for any file. 1-second feedback loop.
2. Write a tiny probe .lux with the thing you're investigating, run `lux lower` on it.
3. Inject sentinel values (`_ => LString("HIT_X")`) as debug. Rust VM runs instantly.
4. Only rebuild the bootstrap AFTER you know what the fix is. Don't fish with rebuilds.

**Concrete plan for the multi-line bug:**
1. Write a probe that imports compiler/lexer and calls `lex("let a = 1\nlet b = 2")` inline, prints the token count + first few tokens. Run via `lux wasm` → works. Run the same probe via bootstrap → fails? If so, the bug is inside `lex`'s WASM execution.
2. If (1) works via bootstrap but compile_wasm fails, the bug is in compile_wasm's source preprocessing (maybe `strip_imports` or `resolve_and_check_modules`).
3. Sentinel-hunt: add print statements inside `lex_from` to show what `pos`, `line`, `col` reach. Rebuild once. Run once. The answer should be obvious.

**Then:** fix `join`/`fold` indirect-call type mismatch.
**Then:** run the stage-2 self-compile test.
**Then:** `rm -rf src/` planning and the playground.

## Key files (latest hot zones)

- `std/compiler/infer.lux` — `infer_binop` (the line we just fixed). Also `lookup`, `bind`, `subst_apply`, `subst_bind`, `unify` handler arms. Type inference is where most "Rust VM papers over it" bugs live.
- `std/compiler/lower.lux` — `lower_handle`, `lower_expr` ResumeExpr, `is_region_safe_ty`, `lower_program_typed`, BinOp Concat dispatch
- `std/compiler/lower_closure.lux` — `collect_free` (AST walker), `filter_real_captures` (uses `is_state_var`)
- `std/compiler/lower_ir.lux` — `LowerCtx` effect (with `is_state_var`)
- `std/compiler/lowir_walk.lux` — `walk_ir` (now recurses into `LMakeClosure` fn_def)
- `std/backend/wasm_emit.lux` — `emit_module` (memory layout, vstack base), `emit_call_expr` (double-emit fix), `emit_global_decls`
- `std/backend/wasm_runtime.lux` — `emit_alloc` (doubling + grow trap)
- `std/runtime/memory.lux` — `str_concat`, `list_concat`, `val_concat`, `print_string`, `print_int`, `println` dispatch

## Recent commits (most relevant first)

- `fedb430` **fix(lower): inner fns capture shadowed enclosing params** — when a top-level `let xs` collided with a fn parameter named `xs`, inner fns read the top-level global instead of capturing the parameter. `fold(map(dbl, [1,2,3]), 0, add)` went from 6 (wrong) to 12 (right). Also enhances `lower_print.lux` to show closure captures as `|[name1, name2]|` after the fn signature — so the bug pattern "empty captures on a nested fn that references outer scope" is visible at a glance.
- `c2bfc6f` fix(lower): insert_field_sorted_at dropped trailing fields — record literals with fields in the wrong source order silently lost entries, collapsing multi-arm handlers into single-arm ones. Unblocks iterate/fold/map from type-mismatch traps.
- `066e028` docs: handoff diagnosis of the fresh_id symptom (superseded by c2bfc6f)
- `213d295` docs: handoff reflects strings-working state
- `01a3cd4` fix(lower): preserve literal pattern values — WASM bootstrap prints strings
- `902b87d` docs: handoff for post-compaction context
- `16885cf` fix(infer): defer Concat type until a side resolves — WASM bootstrap runs!
- `ab2ed0d` wip(wasm): larger vstack, bigger initial memory, sanity checks
- `24dfdc5` fix(wasm): LRegion unsound for TUnit, aggressive alloc, sanity trap
- `d2e7ea7` fix(lower): state vars in closures — walk_ir into fn_def, effect-filtered captures
- `57cbe8e` refactor(wasm): consolidate backend — single source of truth

All commits are real fixes. None should be reverted.

## Tooling to use before rebuilding anything

- `tools/probe.sh lower <file>` — shows LowIR with function bodies, match arms, pattern literals. 1-second feedback.
- `tools/probe.sh fn <file> <name>` — extract a single function's WAT.
- `tools/probe.sh diff <file>` — diff Rust-VM vs bootstrap-compiled WAT (requires `/tmp/bs.cwasm`).
- `lux check <compiler-file.lux>` — type-checks the compiler itself. Works today. Ignore the benign "unknown variable 'TUnit'" warnings (cross-module scope noise).
- Sentinel injection: edit a lowerer function to return `LString("HIT_X")` for the case you want to diagnose, run via Rust VM, see what path was taken. Revert after.

## Critical warnings for the next session

1. **Build the tool first.** Don't guess. Don't pattern-match from crash addresses. Add a debug print or instrument the function before forming a hypothesis. You'll save hours.

2. **Bootstrap rebuilds take ~5 min on a T490.** Background them and work on something else. `lux wasm examples/wasm_bootstrap.lux > /tmp/bs.wat 2>/dev/null &`

3. **Don't delete `bs.cwasm` files in `/tmp` between tests** — wasmtime caches AOT compilation; reusing a `.cwasm` is much faster than re-`compile`ing the WAT.

4. **`grep -c UNRESOLVED /tmp/whatever.wat`** is your tripwire. UNRESOLVED at compile time is a hundred times cheaper to debug than a memory fault at runtime.

5. **The WASM bootstrap reflects EVERY divergence between Rust-VM behavior and WASM semantics**, not just the bug you're chasing. When you fix one, expect the next layer down to surface. That's progress, not regression. Each fix is peeling away another assumption the Rust VM was hiding.

6. **The Rust VM is still the source of truth for "does this Lux program work."** When in doubt about whether something is a checker bug or a WASM bug, run the same code via `lux <file.lux>` (Rust VM). If it works there but not in the WASM bootstrap, the bug is in WASM lowering or runtime divergence. If it fails in both, the bug is in the Lux source itself.

## The thesis

(Written here so a fresh context picks it up:)

Lux is the connective tissue of every project Morgan touches. It's a thesis language: the foundations — algebraic effects, refinement types, ownership inference, row polymorphism — close the gap between what a programmer means and what they have to write. The teaching gradient (the compiler showing you what each annotation unlocks) is so powerful it makes coding-AI obsolete, because the compiler *knows* your program in a way no AI can guess at. Self-containment is necessary because the playground is a key demo, and because building infrastructure on Rust-VM-only assumptions is throwaway work.

The proof of the thesis is every example that runs, every handler that composes, every `!Alloc` that propagates, every `with Pure` that the gradient suggests. Right now, the proof is also: a compiler written in Lux, compiled to WASM, that compiles Lux programs in a sandbox. The cage is unlocked.

Don't lose this.
