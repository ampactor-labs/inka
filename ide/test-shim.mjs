// Node twin of the browser shim: the same two invocation surfaces index.html
// provides, runnable headlessly. Discriminates shim-vs-DOM in one command.
//   node ide/test-shim.mjs
//
// Surface 1 — COMPILE-STDIN: argc 0, source on stdin -> WAT + diagnostics.
// Surface 2 — ADDRESS MODE: a virtual filesystem + argv so the compiler's own
//   cursor-address transport (`mentl main.mn:L:C` -> src/main.mn at_run ->
//   cursor_at_handle) runs, projecting the REAL eight-aspect CursorView that
//   the Aspect ring reads. This is the headless proof of the ring wire.
import { readFile } from 'node:fs/promises';

const HERE = new URL('.', import.meta.url);
const REPO = new URL('../', HERE);
const te = new TextEncoder(), td = new TextDecoder();
const cat = cs => { const n = cs.reduce((a, c) => a + c.length, 0); const b = new Uint8Array(n); let o = 0; for (const c of cs) { b.set(c, o); o += c.length; } return b; };
const modBytes = await readFile(new URL('mentl-ide.wasm', HERE));
const MODULE = await WebAssembly.compile(modBytes);

// ── Surface 1: compile-stdin ────────────────────────────────────────────────
function makeWasi(sourceText) {
  const src = te.encode(sourceText); let srcPos = 0, mem = null;
  const out = [], err = [];
  const dv = () => new DataView(mem.buffer), u8 = () => new Uint8Array(mem.buffer);
  const imports = { wasi_snapshot_preview1: {
    proc_exit(c) { const e = new Error('exit'); e.exitCode = c; throw e; },
    fd_write(fd, io, n, o) { const v = dv(); let t = 0; for (let i = 0; i < n; i++) { const p = v.getUint32(io + 8 * i, true), l = v.getUint32(io + 8 * i + 4, true); (fd === 2 ? err : out).push(u8().slice(p, p + l)); t += l; } v.setUint32(o, t, true); return 0; },
    fd_read(fd, io, n, o) { if (fd !== 0) return 8; const v = dv(); let t = 0; for (let i = 0; i < n && srcPos < src.length; i++) { const p = v.getUint32(io + 8 * i, true), l = v.getUint32(io + 8 * i + 4, true); const k = Math.min(l, src.length - srcPos); u8().set(src.subarray(srcPos, srcPos + k), p); srcPos += k; t += k; } v.setUint32(o, t, true); return 0; },
    fd_close: () => 0, args_sizes_get(a, b) { dv().setUint32(a, 0, true); dv().setUint32(b, 0, true); return 0; }, args_get: () => 0,
    fd_prestat_get: () => 8, fd_prestat_dir_name: () => 8, fd_fdstat_get: () => 8, fd_readdir: () => 8,
    path_open: () => 44, path_filestat_get: () => 44, path_create_directory: () => 44, path_unlink_file: () => 44, path_rename: () => 44,
  }, wasi: { 'thread-spawn': () => -1 } };
  return { imports, bind(i) { mem = i.exports.memory; }, out, err };
}

// ── Surface 2: address mode over a virtual filesystem ───────────────────────
function makeWasiFs(vfs, argvStr) {
  let mem = null; const out = [], err = [];
  const dv = () => new DataView(mem.buffer), u8 = () => new Uint8Array(mem.buffer);
  const fds = new Map(); let nextFd = 8;
  const argv = ['mentl', argvStr].map(s => te.encode(s + '\0'));
  const argvTotal = argv.reduce((a, b) => a + b.length, 0);
  const readStr = (p, l) => td.decode(u8().slice(p, p + l));
  const norm = p => p.replace(/^\.\//, '').replace(/^\//, '');
  const stat = (ptr, ft, sz) => { const v = dv(); for (let i = 0; i < 64; i += 8) v.setBigUint64(ptr + i, 0n, true); v.setUint8(ptr + 16, ft); v.setBigUint64(ptr + 24, 1n, true); v.setBigUint64(ptr + 32, BigInt(sz), true); };
  const P = {
    proc_exit(c) { const e = new Error('exit'); e.exitCode = c; throw e; },
    args_sizes_get(a, b) { dv().setUint32(a, argv.length, true); dv().setUint32(b, argvTotal, true); return 0; },
    args_get(ap, bp) { let p = bp; argv.forEach((a, i) => { dv().setUint32(ap + 4 * i, p, true); u8().set(a, p); p += a.length; }); return 0; },
    fd_write(fd, io, n, o) { const v = dv(); let t = 0; for (let i = 0; i < n; i++) { const p = v.getUint32(io + 8 * i, true), l = v.getUint32(io + 8 * i + 4, true); (fd === 2 ? err : out).push(u8().slice(p, p + l)); t += l; } v.setUint32(o, t, true); return 0; },
    fd_read(fd, io, n, o) { const v = dv(); if (fd === 0) { v.setUint32(o, 0, true); return 0; } const h = fds.get(fd); if (!h) return 8; const d = vfs[h.name]; let t = 0; for (let i = 0; i < n && h.pos < d.length; i++) { const p = v.getUint32(io + 8 * i, true), l = v.getUint32(io + 8 * i + 4, true); const k = Math.min(l, d.length - h.pos); u8().set(d.subarray(h.pos, h.pos + k), p); h.pos += k; t += k; } v.setUint32(o, t, true); return 0; },
    fd_close(fd) { fds.delete(fd); return 0; },
    fd_seek(fd, off, w, o) { const h = fds.get(fd); if (!h) return 8; h.pos = w === 0 ? Number(off) : w === 1 ? h.pos + Number(off) : vfs[h.name].length + Number(off); dv().setBigUint64(o, BigInt(h.pos), true); return 0; },
    fd_prestat_get(fd, p) { if (fd === 3) { dv().setUint8(p, 0); dv().setUint32(p + 4, 1, true); return 0; } return 8; },
    fd_prestat_dir_name(fd, p) { if (fd === 3) { u8()[p] = 46; return 0; } return 8; },
    path_open(b, df, pp, pl, of, rb, ri, ff, o) { const nm = norm(readStr(pp, pl)); if (nm === '' || nm === '.') { const fd = nextFd++; fds.set(fd, { name: '.', pos: 0, dir: 1 }); dv().setUint32(o, fd, true); return 0; } if (!(nm in vfs)) return 44; const fd = nextFd++; fds.set(fd, { name: nm, pos: 0 }); dv().setUint32(o, fd, true); return 0; },
    path_filestat_get(fd, fl, pp, pl, s) { const nm = norm(readStr(pp, pl)); if (!(nm in vfs)) return 44; stat(s, 4, vfs[nm].length); return 0; },
    fd_filestat_get(fd, s) { const h = fds.get(fd); if (!h) return 8; stat(s, h.dir ? 3 : 4, h.dir ? 0 : vfs[h.name].length); return 0; },
    fd_fdstat_get(fd, p) { if (fd === 3) { dv().setUint8(p, 3); return 0; } const h = fds.get(fd); if (h) { dv().setUint8(p, h.dir ? 3 : 4); return 0; } return 8; },
    fd_readdir() { return 0; }, clock_time_get(id, pr, o) { dv().setBigUint64(o, 0n, true); return 0; }, random_get(p, l) { u8().fill(0, p, p + l); return 0; },
    environ_sizes_get(a, b) { dv().setUint32(a, 0, true); dv().setUint32(b, 0, true); return 0; }, environ_get() { return 0; }, poll_oneoff() { return 0; }, sched_yield() { return 0; },
    path_create_directory() { return 44; }, path_unlink_file() { return 44; }, path_rename() { return 44; },
  };
  const proxy = new Proxy(P, { get(t, k) { return k in t ? t[k] : () => 8; } });
  return { imports: { wasi_snapshot_preview1: proxy, wasi: { 'thread-spawn': () => -1 } }, bind(i) { mem = i.exports.memory; }, out, err };
}

function run(shim) {
  return WebAssembly.instantiate(MODULE, shim.imports).then(inst => {
    shim.bind(inst); let exit = 0;
    try { inst.exports._start(); } catch (e) { if (e.exitCode === undefined) throw e; exit = e.exitCode; }
    return { exit, out: td.decode(cat(shim.out)), err: td.decode(cat(shim.err)) };
  });
}

let bad = 0;
// ── Test 1: compile-stdin still works ───────────────────────────────────────
{
  const r = await run(makeWasi('fn double(x) = x * 2\nfn main() = double(21)\n'));
  const ok = r.out.includes('(module') && r.out.includes('$double');
  console.log(`[1] compile-stdin: exit ${r.exit} · has (module ${r.out.includes('(module')} · has $double ${r.out.includes('$double')} -> ${ok ? 'PASS' : 'FAIL'}`);
  if (!ok) bad++;
}
// ── Test 2: address mode projects the REAL CursorView (the ring wire) ────────
{
  const libs = ['lib/runtime/memory.mn', 'lib/runtime/strings.mn', 'lib/runtime/lists.mn', 'lib/runtime/threading.mn', 'lib/prelude.mn', 'src/types.mn'];
  const vfs = {};
  for (const p of libs) vfs[p] = new Uint8Array(await readFile(new URL(p, REPO)));
  vfs['main.mn'] = te.encode('fn main() with Memory + Alloc =\n  [1, 2, 3, 4, 5]\n    |> map((x) => x * x)\n    |> filter((x) => x > 3)\n    |> fold(0, (acc, x) => acc + x)\n');
  const r = await run(makeWasiFs(vfs, 'main.mn:3:8'));
  const q = (r.out.split('\n').find(l => l.startsWith('Query:')) || '');
  const ok = r.exit === 0 && q.includes(' : ') && r.out.includes('Effects:');
  console.log(`[2] address CursorView: exit ${r.exit} -> ${ok ? 'PASS' : 'FAIL'}`);
  console.log('    ' + r.out.trim().split('\n').join('\n    '));
  if (!ok) bad++;
}
console.log(bad ? `\n${bad} FAILED` : '\nboth surfaces green');
process.exitCode = bad ? 1 : 0;
