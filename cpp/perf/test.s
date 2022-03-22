	.section	__TEXT,__text,regular,pure_instructions
	.build_version ios, 15, 2	sdk_version 15, 2
	.globl	__Z8useIndexRKNSt3__16vectorIiNS_9allocatorIiEEEE ; -- Begin function _Z8useIndexRKNSt3__16vectorIiNS_9allocatorIiEEEE
	.p2align	2
__Z8useIndexRKNSt3__16vectorIiNS_9allocatorIiEEEE: ; @_Z8useIndexRKNSt3__16vectorIiNS_9allocatorIiEEEE
	.cfi_startproc
; %bb.0:
	ldr	x8, [x0]
	ldr	w0, [x8, #4]
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	__Z5useAtRKNSt3__16vectorIiNS_9allocatorIiEEEE ; -- Begin function _Z5useAtRKNSt3__16vectorIiNS_9allocatorIiEEEE
	.p2align	2
__Z5useAtRKNSt3__16vectorIiNS_9allocatorIiEEEE: ; @_Z5useAtRKNSt3__16vectorIiNS_9allocatorIiEEEE
	.cfi_startproc
; %bb.0:
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	mov	w1, #1
	bl	__ZNKSt3__16vectorIiNS_9allocatorIiEEE2atEm
	ldr	w0, [x0]
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	__ZNKSt3__16vectorIiNS_9allocatorIiEEE2atEm ; -- Begin function _ZNKSt3__16vectorIiNS_9allocatorIiEEE2atEm
	.weak_def_can_be_hidden	__ZNKSt3__16vectorIiNS_9allocatorIiEEE2atEm
	.p2align	2
__ZNKSt3__16vectorIiNS_9allocatorIiEEE2atEm: ; @_ZNKSt3__16vectorIiNS_9allocatorIiEEE2atEm
	.cfi_startproc
; %bb.0:
	stp	x29, x30, [sp, #-16]!           ; 16-byte Folded Spill
	mov	x29, sp
	.cfi_def_cfa w29, 16
	.cfi_offset w30, -8
	.cfi_offset w29, -16
	ldp	x8, x9, [x0]
	sub	x9, x9, x8
	cmp	x1, x9, asr #2
	b.hs	LBB2_2
; %bb.1:
	add	x0, x8, x1, lsl #2
	ldp	x29, x30, [sp], #16             ; 16-byte Folded Reload
	ret
LBB2_2:
	bl	__ZNKSt3__120__vector_base_commonILb1EE20__throw_out_of_rangeEv
	.cfi_endproc
                                        ; -- End function
	.section	__DATA,__objc_imageinfo,regular,no_dead_strip
L_OBJC_IMAGE_INFO:
	.long	0
	.long	64

.subsections_via_symbols
