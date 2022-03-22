	.section	__TEXT,__text,regular,pure_instructions
	.build_version ios, 15, 0	sdk_version 15, 0
	.globl	__Z14callIntByValuev            ; -- Begin function _Z14callIntByValuev
	.p2align	2
__Z14callIntByValuev:                   ; @_Z14callIntByValuev
	.cfi_startproc
; %bb.0:
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	mov	w0, #123
	bl	__Z10intByValuei
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	b	__Z11doSomethingv
	.cfi_endproc
                                        ; -- End function
	.globl	__Z16callIntByPointerv          ; -- Begin function _Z16callIntByPointerv
	.p2align	2
__Z16callIntByPointerv:                 ; @_Z16callIntByPointerv
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32                     ; =32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16                    ; =16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	mov	w8, #123
	stur	w8, [x29, #-4]
	sub	x0, x29, #4                     ; =4
	bl	__Z12intByPointerPKi
	bl	__Z11doSomethingv
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #32                     ; =32
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	__Z18callIntByReferencev        ; -- Begin function _Z18callIntByReferencev
	.p2align	2
__Z18callIntByReferencev:               ; @_Z18callIntByReferencev
	.cfi_startproc
; %bb.0:
	sub	sp, sp, #32                     ; =32
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16                    ; =16
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	mov	w8, #123
	stur	w8, [x29, #-4]
	sub	x0, x29, #4                     ; =4
	bl	__Z14intByReferenceRKi
	bl	__Z11doSomethingv
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	add	sp, sp, #32                     ; =32
	ret
	.cfi_endproc
                                        ; -- End function
.subsections_via_symbols
