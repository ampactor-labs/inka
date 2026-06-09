  ;; ═══ lookup.wat — Hβ.lower live-graph type read (Tier 5) ═══════════
  ;; Implements: Hβ-lower-substrate.md §1.1 — `$lookup_ty(handle)` live
  ;;             graph read via $graph_chase + $node_kind_tag dispatch;
  ;;             §3.1 — $resume_discipline_of (TCont.discipline accessor);
  ;;             §3.2 — $row_is_ground + $monomorphic_at; §11 audit
  ;;             ownership lock — $ty_make_terror_hole lookup-private
  ;;             nullary sentinel at tag 114 (NOT a 15th canonical Ty
  ;;             variant; lookup-time-only sentinel for NErrorHole-NodeKind
  ;;             chase results).
  ;; Exports:    $lookup_ty,
  ;;             $ty_make_terror_hole,
  ;;             $row_is_ground,
  ;;             $monomorphic_at,
  ;;             $resume_discipline_of
  ;; Uses:       $graph_chase / $gnode_kind / $node_kind_tag /
  ;;               $node_kind_payload (graph.wat),
  ;;             $row_is_pure / $row_is_closed (row.wat),
  ;;             $ty_tag / $ty_tfun_row / $ty_tcont_discipline (infer/ty.wat),
  ;;             $lower_emit_unresolved_type (lower/emit_diag.wat — chunk #4
  ;;               retrofit landed alongside this commit per
  ;;               Hβ.lower.unresolved-emit-retrofit closure),
  ;;             $wasi_proc_exit (Layer 0 import — spec 05 invariant 2 trap)
  ;; Test:       bootstrap/test/lower/lookup_ty_nbound.wat,
  ;;             bootstrap/test/lower/lookup_ty_nerrorhole.wat,
  ;;             bootstrap/test/lower/monomorphic_at_pure.wat,
  ;;             bootstrap/test/lower/monomorphic_at_open.wat
  ;;
  ;; What this chunk IS (per Hβ-lower-substrate.md §1.1):
  ;;   The seed's bridge between Hβ.infer's typed-AST output (graph
  ;;   populated handle-by-handle with NBound/NErrorHole NodeKinds at
  ;;   FnStmt exit) and Hβ.lower's walk arms. $lookup_ty IS the live
  ;;   graph read — NEVER caches, NEVER threads subst. Per spec 05
  ;;   §What does not exist: "Per-module subst threading — the graph
  ;;   is handler-scoped." The graph IS the canonical truth.
  ;;
  ;;   Five NodeKind dispatch arms (graph.wat:55-59 tag region):
  ;;     60 NBound       — return $node_kind_payload (the bound Ty ptr).
  ;;                       The >99% case; well-typed handles.
  ;;     64 NErrorHole   — return $ty_make_terror_hole (lookup-private
  ;;                       nullary sentinel; tag 114). Hazel productive-
  ;;                       under-error — emit dispatches tag 114 to
  ;;                       (unreachable); build continues.
  ;;     61 NFree        — a free TYPE variable at a value position is
  ;;                       LEGAL POLYMORPHISM, not an error. Return the
  ;;                       TVar itself (the honest representation); the
  ;;                       value flows as uniform i32 (SUBSTRATE.md §IX).
  ;;                       Resolves spec 05 invariant 2's last
  ;;                       monomorphization-era binary toward the gradient
  ;;                       (ULTIMATE_MEDIUM.md §9.3 "the grain of sand"):
  ;;                       type is a capability on the gradient, not a
  ;;                       precondition for existence. Genuinely
  ;;                       type-load-bearing consumers (classify_handler's
  ;;                       TCont guard) surface any gap at their own site.
  ;;     62 NRowBound    — should never reach $lookup_ty (rows queried
  ;;     63 NRowFree       via $lookup_row_for / $row_for_handle peer —
  ;;                       named follow-up Hβ.lower.lookup-row below).
  ;;                       (unreachable).
  ;;
  ;; Tag 114 — lookup-private TError-hole nullary sentinel (per
  ;;   Hβ-lower-substrate.md §11 audit lock 2026-04-27, design refined
  ;;   inline 2026-04-27 to match the nullary discipline of ty.wat:100-
  ;;   103 (TInt/TFloat/TString/TUnit) and ty.wat:127-129 (ResumeDiscipline
  ;;   OneShot/MultiShot/Either)):
  ;;     NOT a 15th Ty variant — staying lookup-private preserves ty.wat's
  ;;     14-variant ADT discipline. NErrorHole lives at the GNode layer
  ;;     (graph.wat:55-59), not the Ty layer; this sentinel is the bridge
  ;;     into Hβ.lower's ERROR_HOLE → (unreachable) emit path. ty.wat's
  ;;     tag region 114-119 is reserved for future Ty variants
  ;;     (ty.wat:106); we borrow tag 114 for this lookup-private sentinel
  ;;     without expanding the canonical Ty count.
  ;;
  ;;     Returned directly as `(i32.const 114)` — sentinel < HEAP_BASE
  ;;     (4096) per CLAUDE.md memory model. $tag_of(114) returns 114
  ;;     by the heap-base threshold rule (record.wat:49-52). NO heap
  ;;     allocation; no per-call alloc cost; no cache follow-up needed
  ;;     (the originally-named Hβ.lower.terror-hole-cache follow-up
  ;;     dissolves — a sentinel cannot benefit from caching).
  ;;
  ;;     Downstream emit_diag.wat (chunk #4) dispatches tag 114 in
  ;;     $render_ty: prints "<error-hole>" for diagnostic display,
  ;;     emits (unreachable) when lowering reaches a tag-114 expr type.
  ;;
  ;; Eight interrogations (per Hβ-lower-substrate.md §5.1 at LookupTy
  ;; primitives, projected onto lookup.wat specifically):
  ;;   1. Graph?       This chunk IS the live graph read. Every Hβ.lower
  ;;                   chunk that needs a Ty reads through $lookup_ty.
  ;;   2. Handler?     At the wheel: LookupTy effect, default handler
  ;;                   $lookup_ty_graph declares `with GraphRead`
  ;;                   @resume=OneShot. At the seed: direct $lookup_ty
  ;;                   function. $resume_discipline_of surfaces
  ;;                   TCont.discipline for chunk #5 $classify_handler.
  ;;   3. Verb?        N/A at substrate level.
  ;;   4. Row?         $row_is_ground IS the monomorphism gate per
  ;;                   spec 04 §Monomorphism + spec 05 §Handler elimination.
  ;;                   row.wat:123-129 owns predicates; lookup composes.
  ;;   5. Ownership?   Lookup is read-only on graph. $ty_make_terror_hole
  ;;                   returns a sentinel value; no allocation, no
  ;;                   ownership transfer.
  ;;   6. Refinement?  TRefined transparent — $lookup_ty returns it
  ;;                   verbatim; refinement obligations recorded at
  ;;                   infer time per verify.wat ledger.
  ;;   7. Gradient?    $monomorphic_at IS the gradient measurement.
  ;;                   Each call site proving ground is one row-inference
  ;;                   win cashed in for direct WASM `call` over
  ;;                   call_indirect. Per spec 05: >95% in self-hosted
  ;;                   Mentl.
  ;;   8. Reason?      Read-only. The GNode at the chased handle carries
  ;;                   the Reason via $gnode_reason; lookup.wat does not
  ;;                   surface it (downstream emit_diag.wat reads when
  ;;                   building diagnostics).
  ;;
  ;; Forbidden patterns audited (per Hβ-lower-substrate.md §6.1 +
  ;; project-wide drift modes):
  ;;   - Drift 1 (Rust vtable):              $lookup_ty is $graph_chase
  ;;                                         + $node_kind_tag + 5 if-arms.
  ;;                                         NO dispatch table. NO data
  ;;                                         segment named $lookup_table.
  ;;                                         The word "vtable" appears
  ;;                                         nowhere in this chunk.
  ;;   - Drift 4 (Haskell monad transformer): No LookupM. Single i32 arg
  ;;                                         + single i32 return. Direct.
  ;;   - Drift 5 (C calling convention):     One i32 param; one i32 return.
  ;;                                         No threaded state.
  ;;   - Drift 6 (primitive-special-case):   TError-hole sentinel matches
  ;;                                         the universal nullary
  ;;                                         discipline (TInt/TFloat/
  ;;                                         TString/TUnit + OneShot/
  ;;                                         MultiShot/Either); no
  ;;                                         "ERROR_HOLE is special
  ;;                                         because it's an error" carveout.
  ;;   - Drift 8 (string-keyed):             Tag-int dispatch only. NO
  ;;                                         `if str_eq(kind, "NBound")`.
  ;;                                         NO ERROR_HOLE name string —
  ;;                                         tag 114 IS the sentinel;
  ;;                                         no decorative name field
  ;;                                         (which would have been
  ;;                                         string-keyed-when-structured
  ;;                                         leak — the name was never
  ;;                                         actually read).
  ;;   - Drift 9 (deferred-by-omission):     Every NodeKind tag has its
  ;;                                         arm or explicit (unreachable).
  ;;                                         $ty_make_terror_hole bodied
  ;;                                         THIS commit per §11 ownership
  ;;                                         lock. $lookup_row_for named
  ;;                                         as peer follow-up
  ;;                                         Hβ.lower.lookup-row, NOT
  ;;                                         half-built here.
  ;;   - Foreign fluency:                    No "type guard" / "ADT
  ;;                                         discriminator" / "lookup
  ;;                                         monad" vocabulary. Names
  ;;                                         match Hβ-lower-substrate.md
  ;;                                         §1.1 + §3.2 verbatim.
  ;;
  ;; Tag region claim:
  ;;   114   TERROR_HOLE_TAG       — lookup-private TError-hole nullary
  ;;                                  sentinel. Borrows one slot from
  ;;                                  ty.wat's 114-119 reserved-future-Ty
  ;;                                  region per §11 audit lock. NOT a
  ;;                                  15th canonical Ty.
  ;;
  ;; Named follow-ups (per Drift 9 + Hβ-lower-substrate.md §11):
  ;;   - Hβ.lower.lookup-row:    $lookup_row_for(handle) -> i32 — peer
  ;;                             to $lookup_ty for row-bearing handles
  ;;                             (NRowBound/NRowFree). First caller is
  ;;                             walk_handle.wat (chunk #8) at the
  ;;                             handler-row-arity check; lands then so
  ;;                             substrate-now-wiring-later (drift 9) is
  ;;                             avoided.

  ;; ─── $ty_make_terror_hole — lookup-private nullary sentinel ──────
  ;; Per Hβ-lower-substrate.md §11 audit lock 2026-04-27 + nullary-
  ;; discipline refinement 2026-04-27. Tag 114 (lookup-private; borrows
  ;; one slot of ty.wat's 114-119 reserved region without expanding the
  ;; canonical 14-variant Ty ADT). Returned directly as the tag value
  ;; (sentinel < HEAP_BASE = 4096); $tag_of(114) returns 114 by the
  ;; heap-base threshold rule (record.wat:49-52). Matches the universal
  ;; nullary-substrate discipline of TInt/TFloat/TString/TUnit
  ;; (ty.wat:100-103) and OneShot/MultiShot/Either (ty.wat:127-129).
  (func $ty_make_terror_hole (export "ty_make_terror_hole") (result i32)
    (i32.const 114))

  ;; ─── $lookup_ty — live graph read (the seed's LookupTy primitive) ─
  ;; Per Hβ-lower-substrate.md §1.1 + spec 05 §The LookupTy effect default
  ;; handler `lookup_ty_graph`. Reads via $graph_chase; returns the
  ;; resolved Ty pointer for NBound; sentinel for NErrorHole; halts build
  ;; for NFree (compiler-internal bug per spec 05 invariant 2).
  ;;
  ;; Tag dispatch order matches §1.1 frequency: NBound (>99%), NErrorHole
  ;; (Hazel productive-under-error), NFree (compiler-internal bug).
  ;; Branch prediction follows; readers see the gradient.
  (func $lookup_ty (export "lookup_ty") (param $handle i32) (result i32)
    (local $g i32) (local $nk i32) (local $tag i32)
    (local.set $g (call $graph_chase (local.get $handle)))
    (local.set $nk (call $gnode_kind (local.get $g)))
    (local.set $tag (call $node_kind_tag (local.get $nk)))
    ;; NBound — return the bound Ty pointer.
    (if (i32.eq (local.get $tag) (i32.const 60))
      (then (return (call $node_kind_payload (local.get $nk)))))
    ;; NErrorHole — return $ty_make_terror_hole sentinel (tag 114).
    (if (i32.eq (local.get $tag) (i32.const 64))
      (then (return (call $ty_make_terror_hole))))
    ;; NFree — a free type variable at a value position is LEGAL
    ;; POLYMORPHISM, not a compiler-internal error. Under uniform-i32
    ;; (SUBSTRATE.md §IX "the heap has one story"; ULTIMATE_MEDIUM.md
    ;; §9.3 "the grain of sand") representation is invariant under type:
    ;; type is a CAPABILITY on the continuous gradient, not a
    ;; precondition for a value to exist. The value flows as uniform i32
    ;; whether or not its type is concrete. So $lookup_ty returns the
    ;; type variable ITSELF (TVar) — the honest representation of "a value
    ;; whose type is open here" — and does NOT diagnose. The consumers
    ;; that genuinely need a concrete type surface the gap at their own
    ;; load-bearing site (e.g. $classify_handler's TCont guard); the four
    ;; value-position consumers (monomorphic_at, derive_ev_slots,
    ;; emit_lconst, emit_call `++`) already flow a non-concrete type as
    ;; uniform i32. This resolves spec 05 invariant 2's last
    ;; monomorphization-era binary toward the gradient: not-knowing a type
    ;; is not failure. NErrorHole (a GENUINE inference error, already
    ;; diagnosed upstream and bound by emit) stays the error path above.
    (if (i32.eq (local.get $tag) (i32.const 61))                       ;; NFREE
      (then (return (call $ty_make_tvar (local.get $handle)))))
    ;; Any other tag surfacing here (NRowBound/NRowFree — a row queried as
    ;; a type, i.e. a real category confusion, not a gradient position) is
    ;; the genuine compiler-internal bug $lower_emit_unresolved_type names.
    (call $lower_emit_unresolved_type (local.get $handle))
    (call $ty_make_terror_hole))

  ;; ─── $row_is_ground — monomorphism gate ──────────────────────────
  ;; Per Hβ-lower-substrate.md §3.2 lines 369-372. A row is ground iff
  ;; it's Pure or Closed (no row variable). EfOpen has a rowvar →
  ;; polymorphic dispatch site → evidence-thunk per H1.
  ;;
  ;; row.wat:123-129 owns the per-tag predicates; lookup.wat composes.
  ;; Two-arm if-then-return (NOT i32.or — match walkthrough literal-
  ;; token shape per Anchor 6 "the shape on the page IS the computation
  ;; graph").
  (func $row_is_ground (export "row_is_ground") (param $row i32) (result i32)
    (if (call $row_is_pure (local.get $row)) (then (return (i32.const 1))))
    (if (call $row_is_closed (local.get $row)) (then (return (i32.const 1))))
    (i32.const 0))

  ;; ─── $monomorphic_at — call-site monomorphism check ──────────────
  ;; Per Hβ-lower-substrate.md §3.2 lines 356-366. Reads the type at
  ;; node_handle via $lookup_ty; if not TFun (tag 107), the call site is
  ;; trivially monomorphic (e.g., literal binds, var refs to monomorphic
  ;; bindings) — return 1. If TFun, extract the row via $ty_tfun_row
  ;; (ty.wat:323-324) and delegate to $row_is_ground.
  ;;
  ;; Per spec 05 + H1 evidence reification: >95% of self-hosted Mentl call
  ;; sites prove monomorphic. The 5% polymorphic minority routes through
  ;; evidence (chunk #7 walk_call.wat $emit_evidence_thunk).
  (func $monomorphic_at (export "monomorphic_at") (param $node_handle i32) (result i32)
    (local $ty i32) (local $row i32)
    (local.set $ty (call $lookup_ty (local.get $node_handle)))
    ;; Non-TFun → trivially monomorphic.
    (if (i32.ne (call $ty_tag (local.get $ty)) (i32.const 107))
      (then (return (i32.const 1))))
    ;; TFun — extract row + delegate.
    (local.set $row (call $ty_tfun_row (local.get $ty)))
    (call $row_is_ground (local.get $row)))

  ;; ─── $lookup_row_for — live graph read for an EffRow value (peer to $lookup_ty) ─
  ;; Per Stage 1A ADT discipline + Hβ-perform-evidence-dispatch.md §4.8. A row
  ;; slot holds an EffRow VALUE by type law (src/types.mn: a bare handle cannot
  ;; occupy a row slot — an open row is EfOpen(names, v) with the var WRAPPED).
  ;; Dispatch on the row tag:
  ;;   EfPure 150 / EfClosed 151 — already resolved; self.
  ;;   EfNeg 153 / EfSub 154 / EfInter 155 — intermediate forms; pass through
  ;;     (reduction is the named peer Hβ.infer.row-normalize-full).
  ;;   EfOpen 152 — chase the wrapped var v: NRowBound → recurse on the bound
  ;;     row (chains hop through records; cycles unrepresentable per
  ;;     $unify_row's same-var guard), unioning any carried names;
  ;;     NRowFree → the row is HONESTLY still open — return the EfOpen itself
  ;;     (never Pure: "unresolved" and "no effects" are different truths).
  ;;   Anything else — category error: a non-row reached a row read.
  ;; THE fix that lets derive_ev_slots see effect rows even when value types
  ;; carry free TVars (NFre) — row resolution is independent of monotype
  ;; resolution, and total at any graph size (no magnitude tests).
  (func $lookup_row_for (export "lookup_row_for") (param $row i32) (result i32)
    (local $tag i32) (local $nk i32) (local $ntag i32)
    (local $names i32) (local $resolved i32)
    (local.set $tag (call $tag_of (local.get $row)))
    ;; EfPure sentinel / EfClosed / Neg / Sub / Inter — already a row value.
    (if (i32.eq (local.get $tag) (i32.const 150)) (then (return (local.get $row))))
    (if (i32.eq (local.get $tag) (i32.const 151)) (then (return (local.get $row))))
    (if (i32.eq (local.get $tag) (i32.const 153)) (then (return (local.get $row))))
    (if (i32.eq (local.get $tag) (i32.const 154)) (then (return (local.get $row))))
    (if (i32.eq (local.get $tag) (i32.const 155)) (then (return (local.get $row))))
    ;; EfOpen(names, v) — chase v through the graph.
    (if (i32.eq (local.get $tag) (i32.const 152))
      (then
        (local.set $nk (call $gnode_kind (call $graph_chase
          (call $row_handle (local.get $row)))))
        (local.set $ntag (call $node_kind_tag (local.get $nk)))
        (if (i32.eq (local.get $ntag) (i32.const 62))   ;; NRowBound
          (then
            (local.set $resolved (call $lookup_row_for
              (call $node_kind_payload (local.get $nk))))
            (local.set $names (call $row_names (local.get $row)))
            (if (i32.eqz (call $len (local.get $names)))
              (then (return (local.get $resolved))))
            (return (call $row_union
              (call $row_make_closed (local.get $names))
              (local.get $resolved)))))
        (if (i32.eq (local.get $ntag) (i32.const 63))   ;; NRowFree — still open
          (then (return (local.get $row))))
        ;; Row var bound to a non-row node kind — graph corruption.
        (unreachable)))
    ;; Non-row value in a row read — category error (the ADT discipline
    ;; makes bare handles in row slots unrepresentable; surface, don't guess).
    (unreachable))

  ;; ─── $resume_discipline_of — TCont.discipline accessor ───────────
  ;; Per Hβ-lower-substrate.md §3.1 lines 317-323. Surfaces the
  ;; ResumeDiscipline sentinel (250 OneShot / 251 MultiShot / 252 Either)
  ;; from a TCont(_, discipline) for chunk #5 $classify_handler dispatch.
  ;;
  ;; PRE-CONDITION: caller passes a Ty whose tag is 112 (TCont). On
  ;; non-TCont input, traps via (unreachable) — calling $resume_discipline_of
  ;; on non-TCont is a compiler-internal bug. Mirrors $classify_handler's
  ;; same-precondition guard at §3.1 line 321.
  ;;
  ;; ty.wat:410-411 owns $ty_tcont_discipline; lookup.wat composes.
  (func $resume_discipline_of (export "resume_discipline_of") (param $ty i32) (result i32)
    (if (i32.ne (call $ty_tag (local.get $ty)) (i32.const 112))
      (then (unreachable)))
    (call $ty_tcont_discipline (local.get $ty)))
