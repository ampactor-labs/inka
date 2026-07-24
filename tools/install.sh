#!/usr/bin/env bash
# tools/install.sh — the `mentl` command, anywhere, always current.
#
# Writes ~/.local/bin/mentl: a POINTER to this repo's live pinned boot
# (boot/mentl.wasm — the fixpoint compiler, provenance in
# boot/PROVENANCE.md). Never a copy, never a version: the pin IS the
# release, so every `tools/march.sh` re-pin is instantly the global CLI
# with zero sync. The shim preopens the caller's cwd (so `mentl check foo`
# works beside foo.mn in any directory) and maps the repo to the
# well-known guest path /mentl-home (so user projects' vocabulary imports —
# and their transitive substrate imports — resolve with zero
# configuration: an address, not an env var; the resolver's home chain,
# src/driver.mn driver_module_path).
#
# Override the bin dir with MENTL_BIN_DIR. Re-running is idempotent.
set -euo pipefail

MENTL_HOME="$(cd "$(dirname "$0")/.." && pwd)"
BIN_DIR="${MENTL_BIN_DIR:-$HOME/.local/bin}"
mkdir -p "$BIN_DIR"

cat > "$BIN_DIR/mentl" <<SHIM
#!/usr/bin/env bash
# mentl — a pointer to the live pinned boot (written by tools/install.sh;
# provenance: \$MENTL_HOME/boot/PROVENANCE.md). Re-pinning the boot updates
# this command with zero action — the shim never copies.
MENTL_HOME="$MENTL_HOME"
source "\$MENTL_HOME/tools/wt-env.sh"
mentl_wasm() {
  "\$WT" run "\${WT_RUN_FLAGS[@]}" \\
    --dir "\$PWD" --dir /tmp --dir "\$MENTL_HOME::/mentl-home" \\
    "\$MENTL_HOME/boot/mentl.wasm" "\$@"
}
if [ "\${1:-}" = "run" ] && [ -n "\${2:-}" ]; then
  # run = compile -> assemble -> execute. The execute half is the process
  # boundary the wasm cannot cross (WASI has no exec — the wheel's run
  # verb names this exact seam); the shim owns it. The compile half keeps
  # the executable gate's refusal law: a hole or a broken program exits
  # nonzero with zero WAT, and the shim stops there.
  src="\$2"; shift 2
  tmp="\$(mktemp -d)"
  out_wat="\$tmp/out.wat"; out_wasm="\$tmp/out.wasm"
  mentl_wasm compile "\$src" > "\$out_wat"; rc=\$?
  if [ "\$rc" -ne 0 ] || [ ! -s "\$out_wat" ]; then rm -rf "\$tmp"; exit "\$rc"; fi
  "\${W2W[@]}" "\$out_wat" -o "\$out_wasm" || { rm -rf "\$tmp"; exit 1; }
  "\$WT" run "\${WT_RUN_FLAGS[@]}" --dir "\$PWD" --dir /tmp "\$out_wasm" "\$@"
  rc=\$?
  rm -rf "\$tmp"
  exit "\$rc"
fi
if [ "\${1:-}" = "space" ]; then
  # space = the ide, served by the wheel. A listener is a HOST resource
  # (WASI p1 has no bind/listen — the wheel's find_listener only reads the
  # preopen table), so the shim owns this seam exactly as it owns run's
  # exec seam. The repo maps at guest "." so the verb serves ide/ from any
  # directory. Port override: MENTL_SPACE_PORT.
  exec "\$WT" run "\${WT_RUN_FLAGS[@]}" \\
    --dir "\$MENTL_HOME::." --dir /tmp \\
    -S "tcplisten=127.0.0.1:\${MENTL_SPACE_PORT:-7378}" \\
    "\$MENTL_HOME/boot/mentl.wasm" space
fi
exec_rc=0
mentl_wasm "\$@" || exec_rc=\$?
exit "\$exec_rc"
SHIM
chmod +x "$BIN_DIR/mentl"

echo "installed: $BIN_DIR/mentl -> $MENTL_HOME/boot/mentl.wasm (live pointer)"
case ":$PATH:" in
  *":$BIN_DIR:"*) ;;
  *) echo "note: $BIN_DIR is not on your PATH — add it to use mentl from anywhere" ;;
esac
