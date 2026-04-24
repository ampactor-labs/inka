# Inka — Language Support for VS Code

> *The visual identity of the ultimate intent → machine instruction medium.*

Syntax highlighting and color theme for the [Inka](https://github.com/ampactor-labs/inka) programming language (`.nx` files).

## Features

- **Full syntax highlighting** for all 69 token types defined in SYNTAX.md
- **Inka Obsidian** — a dark color theme designed for resonance with Inka's eight-primitive kernel
- **Colorblind-safe** — Wong/Okabe-Ito palette, WCAG AA compliant, with bold/italic secondary cues
- **Ligature-aware** — designed to work beautifully with JetBrains Mono

## The Color Language

Every color maps to a kernel primitive. The visual identity IS a handler projection of the architecture:

| Color | Hex | Kernel Primitive | What It Highlights |
|---|---|---|---|
| **Deep Blue** | `#0072B2` | Graph + Env (P1) | Keywords — the sovereign structure |
| **Sky Blue** | `#56B4E9` | Five Verbs (P3) | `\|>` `<\|` `><` `~>` `<~` — the topology |
| **Orange-Gold** | `#E69F00` | HM Inference (P8) | Types, constructors, operators — golden contracts |
| **Bluish Green** | `#009E73` | Handlers (P2) | Function & handler names — living computation |
| **Golden Wheat** | `#F0C674` | Annotation Gradient (P7) | Strings — organic content |
| **Vermillion** | `#D55E00` | Refinement Types (P6) | Numbers, booleans, `!` negation, `self` — assertions |
| **Reddish Purple** | `#CC79A7` | Ownership (P5) + Effects (P4) | `own`, `ref`, `Pure`, `@resume`, effect names — capabilities |
| **Warm White** | `#E8DCC8` | Why Engine (P8) | Variables, parameters — the reasons flow through |

Eight primitives. Eight color roles. Eight tentacles.

## Recommended Font Setup

For the full experience, use [JetBrains Mono](https://www.jetbrains.com/lp/mono/) with ligatures enabled:

```json
{
  "editor.fontFamily": "'JetBrains Mono', 'Fira Code', monospace",
  "editor.fontLigatures": true,
  "editor.fontSize": 14,
  "editor.lineHeight": 1.6
}
```

This gives you beautiful ligatures for Inka's pipe verbs: `|>` → ▷, `->` → →, `=>` → ⇒, `~>` → ⤳

## Installation

### From source (development)

1. Clone the Inka repository
2. Open `tools/editor/vscode-inka/` in VS Code
3. Press `F5` to launch the Extension Development Host
4. Open any `.nx` file — the theme activates automatically

### Manual install

```bash
cd tools/editor/vscode-inka
npx vsce package --no-dependencies
code --install-extension inka-0.1.0.vsix
```

## Syntax Coverage

The grammar covers every syntactic construct from SYNTAX.md:

- **Functions**: `fn name<T>(params) -> Ret with Effects = body`
- **Lambdas**: `(x) => x + 1`, `(params) => { stmts; expr }`
- **Five pipe verbs**: `|>`, `<|`, `><`, `~>`, `<~` with distinct scoping
- **Records**: `{name: val}`, field punning, spread `{...r, f: v}`, row polymorphism
- **ADTs**: `type Option<A> = Some(A) | None`
- **Effects**: `effect IO { read() -> String @resume=OneShot }`
- **Handlers**: `handler name(cfg) with state = init { arms }`
- **Patterns**: PVar, PWild, PLit, PCon, PTuple, PList, PRecord, PAlt, PAs
- **Strings**: `"interpolating {expr}"`, `'literal'`, `"""triple"""`, `'''triple'''`
- **Numbers**: `42`, `0xFF_AA`, `0b1010`, `0o77`, `3.14`, `1_000_000`
- **Refinements**: `type Sample = Float where -1.0 <= self <= 1.0`
- **Doc comments**: `///` (brighter, substrate-visible) vs `//` (dim, human-only)

## Accessibility

- Built on the **Wong/Okabe-Ito** palette — proven discriminable across deuteranopia, protanopia, and tritanopia
- **Luminance tiers** ensure categories are distinguishable even in grayscale
- **Font style as secondary cue**: keywords **bold**, comments *italic*, annotations *italic*, effect negation **bold**
- All text colors ≥ **4.5:1 contrast ratio** against `#0D0B0E` background (WCAG AA)

## License

Dual-licensed under MIT or Apache-2.0, matching the Inka project.
