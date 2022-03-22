	.section	__TEXT,__text,regular,pure_instructions
	.build_version ios, 15, 0	sdk_version 15, 0
	.globl	__Z19callStructByPointeri9BigStruct ; -- Begin function _Z19callStructByPointeri9BigStruct
	.p2align	2
__Z19callStructByPointeri9BigStruct:    ; @_Z19callStructByPointeri9BigStruct
	.cfi_startproc
; %bb.0:
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	mov	x0, x1
	bl	__Z15structByPointerPK9BigStruct
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	b	__Z11doSomethingv
	.cfi_endproc
                                        ; -- End function
	.globl	__Z17callStructByValue9BigStruct ; -- Begin function _Z17callStructByValue9BigStruct
	.p2align	2
__Z17callStructByValue9BigStruct:       ; @_Z17callStructByValue9BigStruct
	.cfi_startproc
; %bb.0:
	stp	x28, x27, [sp, #-32]!           ; 16-byte Folded Spill
	stp	x29, x30, [sp, #16]             ; 16-byte Folded Spill
	add	x29, sp, #16                    ; =16
	sub	sp, sp, #512                    ; =512
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	.cfi_offset w27, -24
	.cfi_offset w28, -32
	mov	x1, x0
	mov	x0, sp
	mov	w2, #512
	bl	_memcpy
	mov	x0, sp
	bl	__Z13structByValue9BigStruct
	bl	__Z11doSomethingv
	add	sp, sp, #512                    ; =512
	ldp	x29, x30, [sp, #16]             ; 16-byte Folded Reload
	ldp	x28, x27, [sp], #32             ; 16-byte Folded Reload
	ret
	.cfi_endproc
                                        ; -- End function
.subsections_via_symbols
