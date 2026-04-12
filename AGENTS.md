# Agent Handoff: Arc 2 — WASM Self-Hosting Bootstrap

**Last Updated: 2026-04-12**

## Current State

The Lux compiler is bootstrapping to WebAssembly. The pipeline:

```
Rust VM compiles → lux3.wasm (Lux compiler as WASM, built by Rust)
lux3.wasm compiles → lux4.wasm (Lux compiler as WASM, built by itself — NO RUST)
```

**What works:**
- `lux3.wasm` — built successfully by the Rust VM in ~9 minutes, 428 MB peak. 132K lines of WAT, 2.6 MB.
- `lux3.wasm` lexes, parses, and type-checks its own source natively in wasmtime.
- The `LIndex` structural desync bug is FIXED (see below).
- The `split` O(N) rewrite is APPLIED (see below).
- The `strip_imports` O(N²) join is ELIMINATED (see below).

**Current blocker (lux4.wasm):**
- Previous attempt: `lux3.wat` running in wasmtime crashed after ~20 min / 2.2 GB
- Backtrace: `alloc → str_slice → split_find → split (×16) → unreachable`
- All three fixes are applied but NOT yet tested in a rebuild
- Next step: rebuild `lux3.wasm` with ALL fixes, then retry `lux4.wasm`

## Build Commands

```bash
# Step 1: Build lux3.wasm using Rust VM (~9 min, ~500 MB)
cat examples/wasm_bootstrap.lux | ./target/release/lux examples/wasm_bootstrap.lux > lux3.wasm

# Step 2: Extract clean WAT (strip Rust VM preamble)
sed -n '/^(module/,$p' lux3.wasm > lux3.wat

# Step 3: Self-host — lux3 compiles itself (THE OUROBOROS)
cat examples/wasm_bootstrap.lux | ~/.wasmtime/bin/wasmtime run --dir . -W max-wasm-stack=33554432 lux3.wat > lux4.wasm

# Step 4: Verify lux4 = lux3 (structural equivalence)
sed -n '/^(module/,$p' lux4.wasm > lux4.wat
diff <(wc -l lux3.wat) <(wc -l lux4.wat)
```

## Critical Bugs Fixed This Session

### Bug 1: LIndex Structural Desync (FIXED ✅)

**Root cause:** The `LIndex` node in LowIR was defined with 3 fields but constructed with 4 (an `is_tuple` boolean). The walker (`lowir_walk.lux`) stripped the 4th field during tree traversal. The WASM emitter then read garbage memory as the `is_tuple` flag, causing ALL array indexing to be compiled as flat pointer arithmetic instead of calling `$list_index`. This corrupted tree-structured character lists (concat nodes), causing 11 GB memory blowups.

**Files changed:**
- `std/compiler/lower_ir.lux` — `LIndex(Ty, LowExpr, LowExpr)` → `LIndex(Ty, LowExpr, LowExpr, Bool)`
- `std/compiler/lowir_walk.lux` — propagate `is_tuple` through walker
- `std/compiler/lower_print.lux` — update pattern match
- `std/compiler/lower.lux` — fix missing `true` flag at line 729

### Bug 2: O(N²) Split (FIXED ✅)

**Root cause:** `split_find` allocated a new string at every character position via `str_slice(s, i, i+seplen)` for comparison. Each recursive `split` call also copied the entire remaining string. For a 5000-line file: ~375 MB of dead copies per `split("\n")` call, in a bump allocator that never frees.

**Fix:** Two changes in `std/runtime/memory.lux`:
1. `split_match_at` — in-place byte comparison via `load_i8`, zero allocations during scan
2. `split_from` — pass offset into original string, never copy the tail

### Bug 3: O(N²) strip_imports (ELIMINATED ✅)

**Root cause:** `strip_imports` did `split("\n") |> filter |> join("\n")`. Even with the O(N) split fix, `join` uses accumulator-based `str_concat` which copies the entire growing string at each step. For a 5000-line file: 375 MB dead string copies per join. Called on every imported module.

**Fix:** Removed `strip_imports` entirely from `compile_wasm` and `resolve_and_check_at` in `pipeline.lux`. The parser already creates `ImportStmt` AST nodes, and the checker (`_ => ()`), lowerer (`_ => LConst(TUnit, LUnit)`), and emitter all ignore them. The split-filter-join was redundant work.

## Debugging Methodology: WAT-Level Surgery

**KEY INSIGHT:** When debugging WASM runtime crashes, DON'T recompile through the full 9-minute Rust pipeline. Instead, edit the generated `.wat` file directly.

### The Process

1. **Generate the WAT once:**
   ```bash
   cat examples/wasm_bootstrap.lux | ./target/release/lux examples/wasm_bootstrap.lux > lux3.wasm
   sed -n '/^(module/,$p' lux3.wasm > lux3.wat
   ```

2. **Inject diagnostics directly into the WAT:**
   ```wat
   ;; Example: add print before alloc trap
   (func $alloc (param $size i32) (result i32)
     ;; DIAGNOSTIC: print allocation size
     (call $print_i32 (local.get $size))
     ;; ... rest of alloc ...
   )
   ```

3. **Run the modified WAT immediately:**
   ```bash
   cat input.lux | wasmtime run --dir . -W max-wasm-stack=33554432 lux3.wat
   ```

4. **Iterate in seconds, not minutes.** Each WAT edit + wasmtime run takes ~30 seconds (WAT parse + JIT). Compare to 9 minutes for a full Rust recompile.

### Common Crash Patterns

| Backtrace Pattern | Likely Cause |
|---|---|
| `alloc → str_concat` with `a=1` | LIndex flat-access reading tag byte as pointer |
| `alloc → str_slice → split` | O(N²) split copying, bump allocator exhausted |
| `alloc` with huge size | Garbage pointer read as string length |
| `list_index` returning 1000 | Unknown list tag — flat array treated as tree |

## Architecture Notes

### String Representation
Strings are ALWAYS flat: `[len_i32][bytes...]`. `str_concat` copies both halves into a new buffer. No tree structure for strings.

### List Representation
Lists CAN be trees. `list_concat` creates a tree node `[tag=3][left_ptr][right_ptr]`. `list_index` traverses the tree. The `chars_tree` function builds character lists as binary trees for strings > 256 chars.

**CRITICAL:** Any code that indexes into a list MUST use `$list_index`, not flat pointer arithmetic (`base + 4 + idx*4`). The `is_tuple` flag on `LIndex` controls this in the emitter.

### Bump Allocator
- `$alloc` is a monotonic bump allocator — it NEVER frees
- Traps on allocations exceeding 16 MB (configurable in `wasm_runtime.lux`)
- WASM linear memory grows on demand up to wasmtime's limit
- Every allocation is permanent — O(N²) algorithms are fatal
- ANY function that accumulates strings via `++` in a loop is a potential memory bomb

### The Structural Question (Memory Edition)
Before writing any string-processing function, ask: "Am I creating temporary strings that I immediately discard?" In the Rust VM, the GC cleans them up. In WASM, they live forever. The answer is always: scan in-place, allocate once.

## File Map (What Matters)

| File | Role |
|---|---|
| `examples/wasm_bootstrap.lux` | THE entry point — `compile_wasm(read_stdin())` |
| `std/compiler/pipeline.lux` | Full pipeline: lex → parse → check → lower → emit |
| `std/backend/wasm_emit.lux` | LowIR → WAT translator (streaming via `print()`, not accumulating) |
| `std/compiler/lower_ir.lux` | LowIR ADT definitions (`LIndex` type definition) |
| `std/compiler/lowir_walk.lux` | Tree walker (where `is_tuple` was being dropped) |
| `std/runtime/memory.lux` | ALL runtime primitives: alloc, strings, lists, split |
| `std/backend/wasm_runtime.lux` | Just `emit_alloc` — the one hand-written WAT function |
| `std/prelude.lux` | `join` lives here — still O(N²), avoid in hot paths |
