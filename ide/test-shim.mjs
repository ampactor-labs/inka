// Node proof of the browser WASI shim: instantiate ide/mentl-ide.wasm with
// the same import surface index.html provides, compile a program from a
// string, capture WAT + diagnostics. Run: node ide/test-shim.mjs
import { readFile } from 'node:fs/promises';

const SOURCE = `fn double(x) = x * 2
fn main() = double(21)
`;

function makeWasi(sourceText) {
  const enc = new TextEncoder();
  const src = enc.encode(sourceText);
  let srcPos = 0;
  const out = [], err = [];
  let mem = null;
  const view = () => new DataView(mem.buffer);
  const bytes = () => new Uint8Array(mem.buffer);
  function gatherWrite(iovs, iovsLen, sink) {
    const v = view(); let total = 0;
    for (let i = 0; i < iovsLen; i++) {
      const ptr = v.getUint32(iovs + 8 * i, true);
      const len = v.getUint32(iovs + 8 * i + 4, true);
      sink.push(bytes().slice(ptr, ptr + len));
      total += len;
    }
    return total;
  }
  const imports = {
    wasi_snapshot_preview1: {
      proc_exit(code) { const e = new Error('exit'); e.exitCode = code; throw e; },
      fd_write(fd, iovs, iovsLen, nwrittenPtr) {
        const total = gatherWrite(iovs, iovsLen, fd === 2 ? err : out);
        view().setUint32(nwrittenPtr, total, true);
        return 0;
      },
      fd_read(fd, iovs, iovsLen, nreadPtr) {
        if (fd !== 0) return 8; // badf
        const v = view(); let total = 0;
        for (let i = 0; i < iovsLen && srcPos < src.length; i++) {
          const ptr = v.getUint32(iovs + 8 * i, true);
          const len = v.getUint32(iovs + 8 * i + 4, true);
          const n = Math.min(len, src.length - srcPos);
          bytes().set(src.subarray(srcPos, srcPos + n), ptr);
          srcPos += n; total += n;
        }
        v.setUint32(nreadPtr, total, true);
        return 0;
      },
      fd_close() { return 0; },
      args_sizes_get(argcPtr, bufSizePtr) {   // no argv in the browser → argc 0 → main([]) → compile-stdin
        const v = view(); v.setUint32(argcPtr, 0, true); v.setUint32(bufSizePtr, 0, true); return 0;
      },
      args_get() { return 0; },
      fd_prestat_get() { return 8; },        // badf — no preopens in the browser (fs_dir_fd finds none, honestly)
      path_open() { return 44; },            // noent — the IDE has no fs
      path_filestat_get() { return 44; },
      path_create_directory() { return 44; },
      path_unlink_file() { return 44; },
      path_rename() { return 44; },
    },
    wasi: { 'thread-spawn': () => -1 },      // Schedule default is Seq; never taken
  };
  return {
    imports,
    bind(instance) { mem = instance.exports.memory; },
    text: (chunks) => new TextDecoder().decode(chunks.length ? concat(chunks) : new Uint8Array()),
    out, err,
  };
}
function concat(chunks) {
  const n = chunks.reduce((a, c) => a + c.length, 0);
  const buf = new Uint8Array(n); let o = 0;
  for (const c of chunks) { buf.set(c, o); o += c.length; }
  return buf;
}

const modBytes = await readFile(new URL('./mentl-ide.wasm', import.meta.url));
const module = await WebAssembly.compile(modBytes);
const wasi = makeWasi(SOURCE);
const instance = await WebAssembly.instantiate(module, wasi.imports);
wasi.bind(instance);
let exitCode = 0;
try { instance.exports._start(); } catch (e) {
  if (e.exitCode === undefined) throw e;
  exitCode = e.exitCode;
}
const wat = wasi.text(wasi.out);
const diags = wasi.text(wasi.err);
console.log('exit:', exitCode);
console.log('wat lines:', wat.split('\n').length);
console.log('has module:', wat.includes('(module'));
console.log('has $double:', wat.includes('$double'));
console.log('diag bytes:', diags.length);
if (!wat.includes('(module') || !wat.includes('$double')) { process.exitCode = 1; }
