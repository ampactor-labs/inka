#!/bin/bash
wat2wasm bootstrap/inka.wat -o bootstrap/inka.wasm
wasm-validate bootstrap/inka.wasm
cat src/*.nx lib/**/*.nx | wasmtime run bootstrap/inka.wasm > inka2.wat
diff bootstrap/inka.wat inka2.wat
