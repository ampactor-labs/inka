// Node twin of the browser runner: drives ide/wheel-worker.js — the SAME
// execution host the page uses — headlessly. Discriminates shim-vs-DOM in
// one command, and proves the Worker-spawn shim runs the live SPAWNING boot
// (shared-image import + wasi.thread-spawn, a host thread per judged stmt).
//   node ide/test-shim.mjs
//
// Leg 0 — RED CONTROL: the old stub (thread-spawn -> -1) against this wasm
//   must FAIL LOUDLY (the wheel refuses a failed spawn) — the gate that can
//   fail, and the measured reason the pre-worker page pinned an older wheel.
// Leg 1 — COMPILE-STDIN: argc 0, source on stdin -> WAT on stdout, with the
//   judgment's per-stmt tasks running as REAL worker threads (tasks > 0).
// Leg 2 — ADDRESS MODE: a virtual filesystem + argv so the compiler's own
//   cursor-address transport (`mentl main.mn:L:C` -> src/main.mn at_run ->
//   cursor_at_handle) projects the eight-aspect CursorView the ring reads.
// Leg 3 — THE SOCKET: a ?? hole projects its proven survivor (Propose).
import { readFile } from 'node:fs/promises';
import { Worker } from 'node:worker_threads';
import { fileURLToPath } from 'node:url';

const HERE = new URL('.', import.meta.url);
const REPO = new URL('../', HERE);
const te = new TextEncoder();
const WORKER = fileURLToPath(new URL('wheel-worker.js', HERE));
const WASM = process.env.MENTL_IDE_WASM || fileURLToPath(new URL('mentl-ide.wasm', HERE));
const MODULE = await WebAssembly.compile(await readFile(WASM));

function runWheel(req, timeoutMs = 120000) {
  return new Promise((res) => {
    const w = new Worker(WORKER);
    const t = setTimeout(() => { w.terminate(); res({ exit: 1, out: '', err: '', trapped: 'timeout', tasks: 0 }); }, timeoutMs);
    w.on('message', (m) => { if (m.k === 'result') { clearTimeout(t); w.terminate(); res(m); } });
    w.on('error', (e) => { clearTimeout(t); w.terminate(); res({ exit: 1, out: '', err: String(e), trapped: String(e), tasks: 0 }); });
    w.postMessage(Object.assign({ role: 'run', module: MODULE }, req));
  });
}

const PROG = 'fn double(x) = x * 2\nfn main() = double(21)\n';
let bad = 0;

// ── Leg 0: the stub spawn REFUSES this wasm (seen-RED control) ──────────────
{
  const r = await runWheel({ argv: [], stdin: te.encode(PROG), stubSpawn: true }, 30000);
  const succeeded = !r.trapped && r.exit === 0 && r.out.includes('(module');
  console.log(`[0] stub-spawn control: exit ${r.exit} · trapped ${r.trapped ? JSON.stringify(String(r.trapped).slice(0, 60)) : 'no'} -> ${succeeded ? 'FAIL (a stub shim ran the spawning wheel?!)' : 'PASS (refused loudly)'}`);
  if (succeeded) bad++;
}
// ── Leg 1: compile-stdin through REAL spawned tasks ─────────────────────────
{
  const r = await runWheel({ argv: [], stdin: te.encode(PROG) });
  const ok = !r.trapped && r.out.includes('(module') && r.out.includes('$double') && r.tasks > 0;
  console.log(`[1] compile-stdin: exit ${r.exit} · has (module ${r.out.includes('(module')} · has $double ${r.out.includes('$double')} · tasks ${r.tasks} -> ${ok ? 'PASS' : 'FAIL'}`);
  if (!ok) { bad++; console.log('    err: ' + r.err.trim().split('\n').slice(0, 6).join('\n    ') + (r.trapped ? '\n    trap: ' + r.trapped : '')); }
}
// ── Leg 2: address mode projects the REAL CursorView (the ring wire) ────────
const libs = ['lib/runtime/memory.mn', 'lib/runtime/strings.mn', 'lib/runtime/lists.mn', 'lib/runtime/threading.mn', 'lib/runtime/io.mn', 'lib/prelude.mn', 'src/types.mn'];
const VFS = {};
for (const p of libs) VFS[p] = new Uint8Array(await readFile(new URL(p, REPO)));
{
  const vfs = Object.assign({}, VFS);
  vfs['main.mn'] = te.encode('fn main() with Memory + Alloc =\n  [1, 2, 3, 4, 5]\n    |> map((x) => x * x)\n    |> filter((x) => x > 3)\n    |> fold(0, (acc, x) => acc + x)\n');
  const r = await runWheel({ argv: ['mentl', 'main.mn:3:8'], vfs });
  const q = (r.out.split('\n').find((l) => l.startsWith('Query:')) || '');
  const ok = r.exit === 0 && !r.trapped && q.includes(' : ') && r.out.includes('Effects:');
  console.log(`[2] address CursorView: exit ${r.exit} · tasks ${r.tasks} -> ${ok ? 'PASS' : 'FAIL'}`);
  console.log('    ' + r.out.trim().split('\n').join('\n    '));
  if (!ok) { bad++; console.log('    err: ' + r.err.trim().split('\n').slice(0, 6).join('\n    ')); }
}
// ── Leg 3: the socket — a ?? hole projects a proven survivor (Propose) ──────
{
  const hole = 'type Positive = Int where 0 < self\n\nfn choose() -> Positive with Pure = ??\n\nfn main() = choose()\n';
  const r = await runWheel({ argv: ['mentl', 'hole.mn:3:37'], vfs: { 'hole.mn': te.encode(hole) } });
  const ok = r.exit === 0 && !r.trapped && r.out.includes('Query: ?? :') && /Propose: \S/.test(r.out);
  console.log(`[3] address Propose socket: exit ${r.exit} · tasks ${r.tasks} -> ${ok ? 'PASS' : 'FAIL'}`);
  console.log('    ' + r.out.trim().split('\n').join('\n    '));
  if (!ok) { bad++; console.log('    err: ' + r.err.trim().split('\n').slice(0, 6).join('\n    ')); }
}
console.log(bad ? `\n${bad} FAILED` : '\nall surfaces green — the spawning wheel runs on the worker shim');
process.exit(bad ? 1 : 0);
