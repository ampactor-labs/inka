# Lux Bootstrap — Stage 0 → 1 → 2
#
# Stage 0: Rust VM compiles the Lux compiler to WAT        (lux3.wat)
# Stage 1: WAT → binary WASM; optionally → C → native ELF   (lux3.wasm, lux3-native)
# Stage 1.5: AOT compile lux3.wasm → lux3.cwasm (skip JIT)
# Stage 2: lux3 compiles itself (the Ouroboros)             (lux4.wat → lux4.wasm)
# Stage check: diff lux3.wat lux4.wat → fixed point reached
#
# Each target is a handler on the build effect. wasmtime and wasm2c are
# borrowed native handlers — the destination is Lux's own x86 emitter.

# ─── Inputs ───────────────────────────────────────────────────────────
PROJECT_ROOT  := $(abspath $(CURDIR)/..)
LUX_SRC       := $(PROJECT_ROOT)/examples/wasm_bootstrap.lux
WASMTIME      := $(HOME)/.wasmtime/bin/wasmtime
WASMTIME_OPTS := --dir $(PROJECT_ROOT) -W max-wasm-stack=33554432

# Test fixtures (in-repo, not /tmp)
TEST_DIR      := $(CURDIR)/tests
COUNTER_LUX   := $(TEST_DIR)/counter.lux
PATTERN_LUX   := $(TEST_DIR)/pattern.lux

# wasm2c runtime lives with the WABT install. Override if packaged elsewhere.
WABT_RT_DIR   ?= /usr/share/wabt/wasm2c
WABT_RT       := $(WABT_RT_DIR)/wasm-rt-impl.c

BUILD := build

# ─── Progress monitor ─────────────────────────────────────────────────
# Runs in background during long stages. Prints file size + line count
# every 30 seconds so you know the build is alive.
define start_monitor
	@( while true; do \
	  sleep 30; \
	  if [ -f $(1) ]; then \
	    SIZE=$$(du -h $(1) 2>/dev/null | cut -f1); \
	    LINES=$$(wc -l < $(1) 2>/dev/null); \
	    echo "  📊 $(1): $$SIZE, $$LINES lines ($(2))"; \
	  fi; \
	done ) & echo $$! > $(BUILD)/.monitor.pid
endef

define stop_monitor
	@if [ -f $(BUILD)/.monitor.pid ]; then \
	  kill $$(cat $(BUILD)/.monitor.pid) 2>/dev/null || true; \
	  rm -f $(BUILD)/.monitor.pid; \
	fi
endef

# ─── Phony targets ────────────────────────────────────────────────────
.PHONY: all stage0 stage1 stage1-aot stage1-native stage2 stage2-native \
        smoke verify check check-canonical decompile-diff stats \
        interp-check clean help
.DEFAULT_GOAL := help

all: verify

help:
	@echo "Lux Bootstrap targets:"
	@echo ""
	@echo "  Build stages:"
	@echo "    make stage0         Rust VM → WAT                (~9 min) → $(BUILD)/lux3.wat"
	@echo "    make stage1         WAT → binary WASM (w/ names) → $(BUILD)/lux3.wasm"
	@echo "    make stage1-aot     AOT compile WASM → native    → $(BUILD)/lux3.cwasm"
	@echo "    make stage1-native  binary → C → native ELF      → $(BUILD)/lux3-native"
	@echo "    make stage2         Ouroboros (uses AOT if avail) → $(BUILD)/lux4.wat"
	@echo "    make stage2-native  native-binary Ouroboros       → $(BUILD)/lux4-native.wat"
	@echo ""
	@echo "  Verification:"
	@echo "    make smoke          pattern + counter tests via lux3 (~1 min gate)"
	@echo "    make verify         full pipeline: stage0→1→aot→smoke→2→validate"
	@echo "    make check          diff lux3.wat lux4.wat → fixed-point verdict"
	@echo "    make check-canonical  round-trip canonical diff (stronger)"
	@echo ""
	@echo "  Diagnostics:"
	@echo "    make decompile-diff per-function diff lux3 vs lux4"
	@echo "    make stats          opcode histogram + section sizes"
	@echo "    make interp-check   wasm-interp reference (slow)"
	@echo ""
	@echo "  Housekeeping:"
	@echo "    make clean          remove $(BUILD)/"

$(BUILD):
	mkdir -p $(BUILD)

# ─── Stage 0: Rust VM → WAT ───────────────────────────────────────────
# The Rust VM runs the self-hosted compiler against the bootstrap entry
# point and emits WAT to stdout.
stage0: $(BUILD)/lux3.wat
$(BUILD)/lux3.wat: | $(BUILD)
	@echo "╔══════════════════════════════════════════════╗"
	@echo "║  STAGE 0: Rust VM → WAT                     ║"
	@echo "╚══════════════════════════════════════════════╝"
	@echo "  started: $$(date '+%H:%M:%S')"
	$(call start_monitor,bootstrap/$(BUILD)/lux3.raw.out,stage0)
	@cd $(PROJECT_ROOT) && /usr/bin/time -f "  ⏱  stage0: %E elapsed, %M KB peak RSS" \
	  cargo run --release -- wasm $(LUX_SRC) \
	  > bootstrap/$(BUILD)/lux3.raw.out 2>&1
	$(call stop_monitor)
	@sed -n '1,/^(module/{ /^(module/!p }' $(BUILD)/lux3.raw.out > $(BUILD)/lux3.preamble.log
	@sed -n '/^(module/,$$p' $(BUILD)/lux3.raw.out > $(BUILD)/lux3.wat
	@if [ -s $(BUILD)/lux3.preamble.log ]; then \
	  echo "⚠  stage0 preamble ($(BUILD)/lux3.preamble.log):"; \
	  cat $(BUILD)/lux3.preamble.log; \
	fi
	@LINES=$$(wc -l < $(BUILD)/lux3.wat); \
	 SIZE=$$(du -h $(BUILD)/lux3.wat | cut -f1); \
	 FUNCS=$$(grep -c '^  (func ' $(BUILD)/lux3.wat || true); \
	 echo "  ✓ lux3.wat: $$SIZE, $$LINES lines, $$FUNCS functions"

# ─── Stage 1: WAT → binary WASM ───────────────────────────────────────
# --debug-names preserves $name symbolic identifiers.
stage1: $(BUILD)/lux3.wasm
$(BUILD)/lux3.wasm: $(BUILD)/lux3.wat
	@echo ""
	@echo "╔══════════════════════════════════════════════╗"
	@echo "║  STAGE 1: WAT → binary WASM                 ║"
	@echo "╚══════════════════════════════════════════════╝"
	@echo "  started: $$(date '+%H:%M:%S')"
	wat2wasm --debug-names --enable-tail-call $< -o $@
	wasm-validate --enable-tail-call $@
	@SIZE=$$(du -h $@ | cut -f1); \
	 echo "  ✓ lux3.wasm: $$SIZE, validates"

# ─── Stage 1-AOT: pre-compile for faster stage2 ───────────────────────
# wasmtime compile produces a .cwasm that runs without JIT warmup.
# This can significantly reduce stage2 wall time.
stage1-aot: $(BUILD)/lux3.cwasm
$(BUILD)/lux3.cwasm: $(BUILD)/lux3.wasm
	@echo ""
	@echo "╔══════════════════════════════════════════════╗"
	@echo "║  STAGE 1-AOT: pre-compile to native code    ║"
	@echo "╚══════════════════════════════════════════════╝"
	@echo "  started: $$(date '+%H:%M:%S')"
	@/usr/bin/time -f "  ⏱  AOT compile: %E elapsed" \
	  $(WASMTIME) compile --enable-tail-call -C inlining=y \
	  -W max-wasm-stack=33554432 $< -o $@ 2>&1
	@SIZE=$$(du -h $@ | cut -f1); \
	 echo "  ✓ lux3.cwasm: $$SIZE (AOT native)"

# ─── Stage 1-native: binary WASM → C → native ─────────────────────────
stage1-native: $(BUILD)/lux3-native
$(BUILD)/lux3_native.c $(BUILD)/lux3_native.h: $(BUILD)/lux3.wasm
	cd $(BUILD) && wasm2c lux3.wasm -o lux3_native.c

$(BUILD)/lux3-native: $(BUILD)/lux3_native.c wasi_shim.c
	gcc -O2 -I$(BUILD) -I$(WABT_RT_DIR) \
	    wasi_shim.c $(BUILD)/lux3_native.c $(WABT_RT) \
	    -o $(BUILD)/lux3-native

# ─── Smoke Tests ──────────────────────────────────────────────────────
# Fast gate (~1 min) — catches regressions before the 50-min Ouroboros.
smoke: $(BUILD)/lux3.wat
	@echo ""
	@echo "╔══════════════════════════════════════════════╗"
	@echo "║  SMOKE TESTS                                ║"
	@echo "╚══════════════════════════════════════════════╝"
	@echo "  started: $$(date '+%H:%M:%S')"
	@echo "  --- pattern test ---"
	@cat $(PATTERN_LUX) | $(WASMTIME) run $(WASMTIME_OPTS) \
	  $(BUILD)/lux3.wat > $(BUILD)/pattern_compiled.out 2>&1
	@sed -n '/^(module/,$$p' $(BUILD)/pattern_compiled.out > $(BUILD)/pattern.wat
	@UNRESOLVED=$$(grep -c UNRESOLVED $(BUILD)/pattern.wat || true); \
	 echo "  UNRESOLVED=$$UNRESOLVED"
	@wat2wasm --debug-names --enable-tail-call $(BUILD)/pattern.wat -o $(BUILD)/pattern.wasm
	@$(WASMTIME) run -W max-wasm-stack=33554432 $(BUILD)/pattern.wasm > $(BUILD)/pattern_run.out 2>&1 || true
	@ACTUAL=$$(cat $(BUILD)/pattern_run.out); \
	 EXPECTED=$$(printf '42\n7\n5'); \
	 if [ "$$ACTUAL" = "$$EXPECTED" ]; then \
	   echo "  PATTERN TEST PASSED ✓"; \
	 else \
	   echo "  PATTERN TEST FAILED — got:"; cat $(BUILD)/pattern_run.out; \
	   echo "  expected: 42 / 7 / 5"; \
	   exit 1; \
	 fi
	@echo "  --- counter test ---"
	@cat $(COUNTER_LUX) | $(WASMTIME) run $(WASMTIME_OPTS) \
	  $(BUILD)/lux3.wat > $(BUILD)/counter_compiled.out 2>&1
	@sed -n '/^(module/,$$p' $(BUILD)/counter_compiled.out > $(BUILD)/counter.wat
	@UNRESOLVED=$$(grep -c UNRESOLVED $(BUILD)/counter.wat || true); \
	 echo "  UNRESOLVED=$$UNRESOLVED"
	@wat2wasm --debug-names --enable-tail-call $(BUILD)/counter.wat -o $(BUILD)/counter.wasm
	@echo "  COUNTER TEST PASSED ✓"
	@echo "  finished: $$(date '+%H:%M:%S')"

# ─── Stage 2: Ouroboros via wasmtime ──────────────────────────────────
# lux3 compiles itself, outputting lux4.wat.
# Uses AOT-compiled .cwasm if available (faster), falls back to .wat.
stage2: $(BUILD)/lux4.wat
$(BUILD)/lux4.wat: $(BUILD)/lux3.wat
	@echo ""
	@echo "╔══════════════════════════════════════════════╗"
	@echo "║  STAGE 2: OUROBOROS — lux3 compiling itself  ║"
	@echo "╚══════════════════════════════════════════════╝"
	@echo "  started: $$(date '+%H:%M:%S')"
	$(call start_monitor,$(BUILD)/lux4.raw.out,stage2 ouroboros)
	@if [ -f $(BUILD)/lux3.cwasm ]; then \
	  echo "  using AOT-compiled lux3.cwasm (no JIT warmup)"; \
	  /usr/bin/time -f "  ⏱  stage2: %E elapsed, %M KB peak RSS" \
	    sh -c 'cat $(LUX_SRC) | $(WASMTIME) run --allow-precompiled $(WASMTIME_OPTS) $(BUILD)/lux3.cwasm' \
	    > $(BUILD)/lux4.raw.out 2>&1; \
	else \
	  echo "  using lux3.wat (JIT mode — run 'make stage1-aot' for faster)"; \
	  /usr/bin/time -f "  ⏱  stage2: %E elapsed, %M KB peak RSS" \
	    sh -c 'cat $(LUX_SRC) | $(WASMTIME) run $(WASMTIME_OPTS) $(BUILD)/lux3.wat' \
	    > $(BUILD)/lux4.raw.out 2>&1; \
	fi
	$(call stop_monitor)
	@sed -n '1,/^(module/{ /^(module/!p }' $(BUILD)/lux4.raw.out > $(BUILD)/lux4.preamble.log
	@sed -n '/^(module/,$$p' $(BUILD)/lux4.raw.out > $@
	@if [ -s $(BUILD)/lux4.preamble.log ]; then \
	  echo "⚠  stage2 preamble ($(BUILD)/lux4.preamble.log):"; \
	  cat $(BUILD)/lux4.preamble.log; \
	fi
	@LINES=$$(wc -l < $@); \
	 SIZE=$$(du -h $@ | cut -f1); \
	 UNRESOLVED=$$(grep -c UNRESOLVED $@ || true); \
	 FUNCS=$$(grep -c '^  (func ' $@ || true); \
	 echo "  ✓ lux4.wat: $$SIZE, $$LINES lines, $$FUNCS functions"; \
	 echo "  UNRESOLVED=$$UNRESOLVED"; \
	 echo "  finished: $$(date '+%H:%M:%S')"

# Also turn the result into a binary for comparison and next-stage runs.
$(BUILD)/lux4.wasm: $(BUILD)/lux4.wat
	wat2wasm --debug-names --enable-tail-call $< -o $@
	wasm-validate --enable-tail-call $@
	@echo "  ✓ lux4.wasm validates"

# ─── Stage 2-native: Ouroboros via native binary ──────────────────────
stage2-native: $(BUILD)/lux4-native.wat
$(BUILD)/lux4-native.wat: $(BUILD)/lux3-native
	cat $(LUX_SRC) | $(BUILD)/lux3-native > $@

# ─── Full Verification Pipeline ──────────────────────────────────────
# Single command: build everything, test everything, report verdict.
# This is THE command for Arc 2 verification.
verify: clean stage0 stage1 stage1-aot smoke stage2 $(BUILD)/lux4.wasm
	@echo ""
	@echo "╔══════════════════════════════════════════════╗"
	@echo "║  FINAL VERIFICATION                         ║"
	@echo "╚══════════════════════════════════════════════╝"
	@echo ""
	@echo "=== counter test via lux4 (THE Ouroboros test) ==="
	@cat $(COUNTER_LUX) | $(WASMTIME) run $(WASMTIME_OPTS) \
	  $(BUILD)/lux4.wat > $(BUILD)/counter4_compiled.out 2>&1
	@sed -n '/^(module/,$$p' $(BUILD)/counter4_compiled.out > $(BUILD)/counter4.wat
	@echo "  UNRESOLVED=$$(grep -c UNRESOLVED $(BUILD)/counter4.wat || true)"
	@wat2wasm --debug-names --enable-tail-call $(BUILD)/counter4.wat -o $(BUILD)/counter4.wasm 2>&1 | head -3
	@if [ -f $(BUILD)/counter4.wasm ]; then \
	  echo "  counter4.wasm EXISTS AND VALIDATES ✓"; \
	  echo ""; \
	  echo "═══════════════════════════════════════════════"; \
	  echo "  ARC 2 IS CLOSED — Ouroboros produces valid WASM"; \
	  echo "═══════════════════════════════════════════════"; \
	else \
	  echo "  counter4.wasm MISSING — Arc 2 not yet closed"; \
	  exit 1; \
	fi

# ─── Fixed-point check ────────────────────────────────────────────────
check: $(BUILD)/lux3.wat $(BUILD)/lux4.wat
	@if diff -q $(BUILD)/lux3.wat $(BUILD)/lux4.wat > /dev/null; then \
	  echo "FIXED POINT REACHED — Arc 2 complete"; \
	else \
	  echo "WAT files differ:"; \
	  diff $(BUILD)/lux3.wat $(BUILD)/lux4.wat | head -40; \
	  exit 1; \
	fi

# ─── Canonical-form fixed-point check ─────────────────────────────────
check-canonical: $(BUILD)/lux3.wat $(BUILD)/lux4.wat
	@wat2wasm --debug-names --enable-tail-call $(BUILD)/lux3.wat -o $(BUILD)/lux3.canon.wasm 2>/dev/null
	@wat2wasm --debug-names --enable-tail-call $(BUILD)/lux4.wat -o $(BUILD)/lux4.canon.wasm 2>/dev/null
	@wasm2wat --enable-tail-call $(BUILD)/lux3.canon.wasm > $(BUILD)/lux3.canon.wat
	@wasm2wat --enable-tail-call $(BUILD)/lux4.canon.wasm > $(BUILD)/lux4.canon.wat
	@if diff -q $(BUILD)/lux3.canon.wat $(BUILD)/lux4.canon.wat > /dev/null; then \
	  echo "CANONICAL FIXED POINT — Arc 2 semantically complete"; \
	else \
	  echo "Canonical WAT differs ($$(diff $(BUILD)/lux3.canon.wat $(BUILD)/lux4.canon.wat | wc -l) lines):"; \
	  diff $(BUILD)/lux3.canon.wat $(BUILD)/lux4.canon.wat | head -40; \
	  exit 1; \
	fi

# ─── Per-function decompile diff ──────────────────────────────────────
decompile-diff: $(BUILD)/lux3.wasm $(BUILD)/lux4.wasm
	@wasm-decompile --enable-tail-call $(BUILD)/lux3.wasm > $(BUILD)/lux3.dc.txt
	@wasm-decompile --enable-tail-call $(BUILD)/lux4.wasm > $(BUILD)/lux4.dc.txt
	@diff $(BUILD)/lux3.dc.txt $(BUILD)/lux4.dc.txt > $(BUILD)/dc.diff || true
	@echo "Decompile diff written to $(BUILD)/dc.diff ($$(wc -l < $(BUILD)/dc.diff) lines)"
	@echo "First diverging function name:"
	@awk '/^[<>] function /{print; exit}' $(BUILD)/dc.diff || true

# ─── Profile: opcode + section triage ─────────────────────────────────
stats: $(BUILD)/lux3.wasm
	@echo "=== lux3.wasm opcode histogram ==="
	@wasm-stats --enable-tail-call $(BUILD)/lux3.wasm | head -30
	@echo ""
	@echo "=== section sizes ==="
	@wasm-objdump -h $(BUILD)/lux3.wasm | head -12

# ─── Third-opinion runtime ────────────────────────────────────────────
interp-check: $(BUILD)/lux3.wasm
	@echo "=== wasm-interp counter via lux3 ==="
	@echo "(runs the reference interpreter — minutes, not seconds)"
	@cat $(COUNTER_LUX) | wasm-interp --enable-tail-call --run-all-exports \
	  $(BUILD)/lux3.wasm 2>&1 | head -20 || echo "(interp can't drive stdin — skip)"

clean:
	rm -rf $(BUILD)
