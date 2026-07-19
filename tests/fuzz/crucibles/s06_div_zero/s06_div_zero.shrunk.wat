(module
  (type (;0;) (func (param i32) (result i32)))
  (type (;1;) (func (param i32 i32) (result i32)))
  (type (;2;) (func (param i32)))
  (type (;3;) (func))
  (import "wasi_snapshot_preview1" "proc_exit" (func (;0;) (type 2)))
  (func (;1;) (type 1) (param i32 i32) (result i32)
    (local i32 i32 i32 i32 i32 i32 i32)
    i32.const 1
    local.get 1
    i32.div_s)
  (func (;2;) (type 0) (param i32) (result i32)
    (local i32 i32 i32 i32 i32 i32 i32 i32)
    i32.const 1
    i32.const 0
    local.get 8
    return_call_indirect (type 1))
  (func (;3;) (type 3)
    i32.const 0
    call 2
    call 0)
  (table (;0;) 2 funcref)
  (export "" (func 3))
  (elem (;0;) (i32.const 0) func 1 2))
