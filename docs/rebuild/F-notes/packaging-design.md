# Inka Packaging: The Handler Is The Package

## 1. Thesis
A handler is a package. A project is a `~>` chain. Resolution is type checking. 
There is no package manager. There is only the compiler.

## 2. The Problem Every Package Manager Solves Badly
npm, Cargo, Pip. They all do the same thing: they build an ad-hoc, untyped mini-language (JSON, TOML) to describe a dependency graph. Then they build a separate constraint solver to resolve versions. Then they build a separate sandbox to isolate the build. 

They do this because the host languages cannot carry the information. Rust does not know what `reqwest` does natively; Cargo must be told. JavaScript does not know what `express` does natively; npm must be told.

In Inka, the language already knows everything.

| Manual Annotation (Other Languages) | What Inka Already Knows |
|-------------------------------------|------------------------|
| `dependencies = ["reqwest"]` | `with Network, IO` |
| Version ranges (`^1.2.0`) | Effect signature unifies with expected properties |
| Feature flags (`features=["ssl"]`)| Refinement types and effect subtyping |
| Peer dependencies | Handlers composing via `><` |

When a language is powerful enough, you don't build external tooling to manage it. You just write code.

## 3. The `~>` Chain IS the Manifest
A manifest is a description of the environment a program needs to run. 
In Inka, that's exactly what `~>` (HandlePipe/strategy) does.

```lux
fn main() =
  run_app() 
    ~> router_axum 
    ~> db_postgres 
    ~> alloc_arena
```
This is not configuration. This is executable type-checked code.
Each `~>` is a package. The manifest is already in the code. There is no second configuration language. If you want to change the database package, you change the code. 

## 4. Effect Signatures as API Contracts
We don't need semantic versioning constraints because we have something vastly superior: structural effect typing.

Versions are derived from signature changes. 
- **Breaking change:** The effect signature drifts (e.g., a function suddenly demands `with Filesystem` or changes its data shape).
- **Compatible change:** The effect signature unifies perfectly with the older version.

The type checker IS the version solver. If the program compiles, the versions are compatible. If it doesn't, they aren't. No more "dependency hell" caused by untyped string matching in a `Cargo.toml`.

## 5. Handlers as the Unit of Distribution
We do not publish "packages" or "bundles." We publish *handlers*.
Packages do not exist as a concept in Inka. The word "package" does not appear in the documentation. 

You import a handler, and you install it over your pipeline with `~>`. 

## 6. `std/pkg/` Architecture
The package manager must be written in Inka, as a handler, or the thesis is theater.
`Package` is just an effect. 

```lux
effect Package {
  fetch(id: Hash) -> Source
  resolve(row: EffRow) -> Hash
  audit() -> List<Violation>
}
```

Registry handlers are handlers of the `Package` effect, swappable like everything else. You can run `~> local_cache_pkg`, `~> github_pkg`, or `~> enterprise_registry_pkg`.

## 7. `inka audit` — The Killer MVP
Before we build registries and decentralized content delivery, we build `inka audit`.
`inka audit` walks the `~>` chain in `main()`, collects effect rows transitively, prints the capability set, and suggests negations.

```
$ inka audit main.jxj

Capabilities required:
  - Network (via router_axum)
  - Filesystem (via db_postgres)
  - Alloc (via alloc_arena)

Suggestions:
  - You can run this sandboxed with `with !Process, !FFI`.
```

Zero infrastructure required. It runs locally against your source. This is the feature no other package manager can offer: mathematically proven capability analysis before you even compile, let alone run.

## 8. Registry Model
We use a hybrid content-addressed model with named sugar. 
Hash = identity. 
Name = resolution through a registry handler. 

There is no lockfile. The hash IS the lock. Federation is achieved via handler stacking:
```lux
fetch_deps() ~> local_cache >< github_hub >< community_registry
```
Use `><` to chain registry handlers to create fallback resolution paths.

## 9. Worked Examples

**Unannotated Prototype:**
```lux
// Quick script, asks for inference
fn main() = run_app() ~> http_default
```
`inka audit` will trace `http_default` and report all the effects it utilizes (Network, Alloc, IO).

**Fully-Constrained Production:**
```lux
fn main() = 
  run_app() 
    with !Filesystem, !Process 
    ~> http_reqwest 
    ~> log_console 
    ~> alloc_system
```
`inka audit` proves that the program will never touch the filesystem or spawn processes. If `http_reqwest` sneaks in a `Filesystem` requirement in an update, compilation fails immediately.

## 10. Implementation Phases
- 🔲 **Phase 1:** Spec freeze.
- 🔲 **Phase 2:** `inka audit` prototype (using current compiler engine).
- 🔲 **Phase 3:** Content-addressed local cache (the `fetch` effect).
- 🔲 **Phase 4:** Name registry handler (the `resolve` effect).
- 🔲 **Phase 5:** `inka install` equivalent.
- 🔲 **Phase 6:** `inka publish` equivalent.

## 11. Open Questions
- **Cache Invalidation:** How do we handle handler state across hub fetches? Will it be cache invalidation by signature hash?
- **Circular Handler Graphs:** Are circular handler graphs (via different handlers at different scopes) legal? Does `inka audit` report cycles?
- **Federation Policy:** What is the exact trust model for hub fallbacks?
- **Build vs Runtime Selection:** Platform handlers are build-time; HTTP handlers are runtime. They use the same syntax, but how do we cleanly delineate their resolution mechanics without fracturing the mental model?
