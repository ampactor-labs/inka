// THE ONE PROBE (Arc 1, the finish-line campaign): does a SHARED memory64
// memory work past 4GiB on wasmtime 47? Decides whether the fan's "4GiB × N
// branches" ceiling dissolves in-process. The fx2-wasm64 recon banked the
// recipe and the two false-failure modes this probe pre-empts: (a) shared
// memories are immovable, so growth past the DEFAULT 4GiB reservation fails
// by design — memory_reservation must be raised first; (b) memory64 is
// Tier 1 but Config-default OFF — enabled explicitly. Success ladder:
//   1. construct a shared i64 memory (4GiB min / 16GiB max)
//   2. guest grows it past 4GiB (memory.grow returns old size, not -1)
//   3. guest stores/loads at the 5GiB address
//   4. a SECOND instance on ANOTHER THREAD reads the 5GiB store
// Failure decode: grow -1 at step 2 = reservation not applied; a
// SharedMemory::new error at step 1 contradicts the #9569 in-tree record —
// quote it verbatim as a wasmtime bug report.
use std::sync::Arc;
use wasmtime::{Config, Engine, Linker, MemoryTypeBuilder, Module, SharedMemory, Store};

fn main() {
    let mut config = Config::new();
    config.wasm_memory64(true);
    config.wasm_threads(true);
    config.shared_memory(true); // its own knob in wasmtime 47, beside wasm_threads
    config.memory_reservation(0x4_0000_0000); // 16 GiB — above the target max
    let engine = Engine::new(&config).expect("engine config rejected");

    let ty = MemoryTypeBuilder::new()
        .min(65_536) // 4 GiB in 64KiB pages
        .max(Some(262_144)) // 16 GiB
        .memory64(true)
        .shared(true)
        .build()
        .expect("step1 FAIL: shared+memory64 MemoryType refused");
    let image = SharedMemory::new(&engine, ty)
        .expect("step1 FAIL: SharedMemory::new refused (contradicts #9569)");
    println!("step1 OK: shared memory64 constructed (min 4GiB, max 16GiB)");

    let wat = r#"(module
      (import "env" "memory" (memory i64 65536 262144 shared))
      (func (export "probe") (result i64)
        (drop (memory.grow (i64.const 65536)))
        (i64.store (i64.const 0x140000000) (i64.const 42))
        (i64.load (i64.const 0x140000000))))"#;
    // A failed grow leaves the bound at 4GiB, so the 5GiB store traps — the
    // trap IS the step-2 verdict; 42 means grow succeeded, address live.
    let module = Module::new(&engine, wat).expect("guest wat rejected");
    let mut store = Store::new(&engine, ());
    let mut linker: Linker<()> = Linker::new(&engine);
    linker
        .define(&mut store, "env", "memory", image.clone())
        .expect("memory import define failed");
    let inst = linker
        .instantiate(&mut store, &module)
        .expect("step2 FAIL: instantiation refused");
    let probe = inst
        .get_typed_func::<(), i64>(&mut store, "probe")
        .expect("probe export missing");
    let v = probe
        .call(&mut store, ())
        .expect("step2/3 FAIL: trap growing past 4GiB or storing at 5GiB");
    println!("step2+3 OK: grow past 4GiB + store/load at 5GiB => {v}");

    let reader_wat = r#"(module
      (import "env" "memory" (memory i64 65536 262144 shared))
      (func (export "read") (result i64)
        (i64.load (i64.const 0x140000000))))"#;
    let reader = Module::new(&engine, reader_wat).expect("reader wat rejected");
    let engine2 = engine.clone();
    let image2 = image.clone();
    let seen = Arc::new(std::sync::atomic::AtomicI64::new(0));
    let seen2 = seen.clone();
    std::thread::spawn(move || {
        let mut s2 = Store::new(&engine2, ());
        let mut l2: Linker<()> = Linker::new(&engine2);
        l2.define(&mut s2, "env", "memory", image2)
            .expect("thread define failed");
        let i2 = l2
            .instantiate(&mut s2, &reader)
            .expect("step4 FAIL: second-instance instantiation refused");
        let read = i2
            .get_typed_func::<(), i64>(&mut s2, "read")
            .expect("read export missing");
        let got = read.call(&mut s2, ()).expect("step4 FAIL: cross-thread read trapped");
        seen2.store(got, std::sync::atomic::Ordering::SeqCst);
    })
    .join()
    .expect("probe thread panicked");
    let got = seen.load(std::sync::atomic::Ordering::SeqCst);
    println!("step4 OK: second instance on another thread read 5GiB => {got}");
    if v == 42 && got == 42 {
        println!("PROBE VERDICT: shared memory64 past 4GiB WORKS on this wasmtime — 4GiB x N dissolves in-process");
    } else {
        println!("PROBE VERDICT: values off (probe={v}, cross-thread={got}) — decode before banking");
    }
}
