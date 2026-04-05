# Agent Handoff: Arc 2 WASM Phase 3 (Checker in WASM)

**To the ONA Cloud Agent:**

Welcome to the Lux codebase. The local developer's machine hung during the massive AST closure iteration of the pure Lux compiler when attempting Phase 3 locally. We are shifting tactics to avoid freezing the local client.

We are entering **Arc 2 Phase 3**, which means compiling our 5,000+ line self-hosted inference engine (`check.lux` + deps) completely natively into a WebAssembly binary. We've removed `with_prelude` from the `compile_wasm` pipeline so the Rust execution does NOT attempt to interpret the whole source text locally as a concatenated string (which proved to be $O(N^2)$ inside the `push()` loop due to reference counting without Mut tail-call optimization).

## Your Mission

1. **Build the current state:**
   ```bash
   cargo build --release
   ```

2. **Execute the Phase 3 Compilation:**
   ```bash
   ./target/release/lux wasm examples/crucible_checker_wasm.lux
   ```
   *Note: Ensure this resolves all imports correctly. The local Rust engine will lex, parse, typecheck, and use the pure Lux emitter (`backend/wasm_emit.lux`) to build `output.wasm` containing the native type-checker.*

3. **Verify the generated WASM artifact:**
   You must run the resulting `output.wasm` and ensure it doesn't crash:
   ```bash
   wasmtime output.wasm
   ```
   Since it tests a primitive AST (`let x = 42`), the output should look like:
   `✓ Typechecker executed successfully over simple AST.`

4. **Iterate If Required:**
   If the `wasm_emit.lux` backend crashes when emitting `check.lux` due to unsupported struct/AST nodes, you're empowered as an Agent to drop in and fix it! Fix the node support, compile the WASM until it completes, and then push.

You are trusted to utilize Lux and enforce the new architecture!
