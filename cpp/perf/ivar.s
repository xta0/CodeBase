	.section	__TEXT,__text,regular,pure_instructions
	.build_version ios, 15, 0	sdk_version 15, 0
	.globl	__Z12accessMemberP10SomeStruct  ; -- Begin function _Z12accessMemberP10SomeStruct
	.p2align	2
__Z12accessMemberP10SomeStruct:         ; @_Z12accessMemberP10SomeStruct
	.cfi_startproc
; %bb.0:
	ldp	w8, w9, [x0, #8]
	add	w0, w9, w8
	ret
	.cfi_endproc
                                        ; -- End function
	.globl	__Z11accessArrayPi              ; -- Begin function _Z11accessArrayPi
	.p2align	2
__Z11accessArrayPi:                     ; @_Z11accessArrayPi
	.cfi_startproc
; %bb.0:
	ldp	w8, w9, [x0, #8]
	add	w0, w9, w8
	ret
	.cfi_endproc
                                        ; -- End function
.subsections_via_symbols
