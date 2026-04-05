# Agent Handoff: The Great Deletion (Self-Hosting Bootstrap)

**To the ONA Cloud Agent:**

Welcome to the Lux codebase. The local developer's machine hung during a heavy bootstrap compilation step, so they spun up this cloud workspace for you to finish the job.

We are in the middle of "The Great Deletion" — transitioning the entire Lux compiler strictly to its self-hosted pure Lux implementation and deleting the Rust prototype compiler entirely.

## What is Staged
The latest commit on this branch sets up the native Lux routing architecture:
1. `src/vm/dumper.rs` and `dump_to_rust` builtin were added to serialize a Lux `Chunk` into a static Rust evaluation function (`src/bootstrap.rs`).
2. `std/compiler/pipeline.lux` now possesses an integrated `main()` method which handles command-routing (like `"check"`, `"run"`, `"bootstrap"`).
3. `src/main.rs` contains a temporary `["bootstrap"]` command execution arm that invokes the old Rust compiler ONE LAST TIME to evaluate the `pipeline.lux`'s bootstrap logic.

## Your Mission

1. **Build the current state:**
   ```bash
   cargo build --release
   ```

2. **Execute the one-time bootstrap:**
   ```bash
   ./target/release/lux bootstrap
   ```
   *Note: This will execute the `dump_to_rust` builtin inside Lux, parsing the entire `std/compiler/pipeline.lux` AST and serializing the compiled `FnProto` directly into `src/bootstrap.rs`. Because of the size of the AST, this step froze the local developer's thin client. A Large/xLarge ONA VM should handle it fine.*

3. **Verify the generated artifact:** Ensure `src/bootstrap.rs` has been successfully created and contains the `get_pipeline()` function.

4. **The Great Deletion:**
   - Delete the entire `src/compiler/` folder.
   - Delete `src/lexer.rs` and `src/parser.rs`.
   - Radically rewrite `src/main.rs`. Strip out all the custom file argument routing. Replace it with the native hook:

   ```rust
   use vm::vm::Vm;
   mod bootstrap;
   
   fn main() {
       let mut vm = Vm::new();
       let pipeline = bootstrap::get_pipeline();
       if let Err(e) = vm.run(pipeline) {
           eprintln!("fatal: {}", e);
           std::process::exit(1);
       }
   }
   ```
   **Reminder**: `pipeline.lux` now calls `cli_args()` directly via the VM to process the arguments.

5. **Test and Push!**
   - Run `cargo build --release` again (it should compile blazing fast).
   - Test it by executing `./target/release/lux run examples/ml_xor.lux`.
   - Commit the deletion and cleanly push back to the repository.

You are trusted to utilize Lux and enforce the new system!
