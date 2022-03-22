	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 11, 0	sdk_version 11, 3
	.globl	__Z14callIntByValuev            ## -- Begin function _Z14callIntByValuev
__Z14callIntByValuev:                   ## @_Z14callIntByValuev
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	movl	$123, %edi
	callq	__Z10intByValuei
	popq	%rbp
	jmp	__Z11doSomethingv               ## TAILCALL
	.cfi_endproc
                                        ## -- End function
	.globl	__Z16callIntByPointerv          ## -- Begin function _Z16callIntByPointerv
__Z16callIntByPointerv:                 ## @_Z16callIntByPointerv
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	leaq	-4(%rbp), %rdi
	movl	$123, (%rdi)
	callq	__Z12intByPointerPKi
	callq	__Z11doSomethingv
	addq	$16, %rsp
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
	.globl	__Z18callIntByReferencev        ## -- Begin function _Z18callIntByReferencev
__Z18callIntByReferencev:               ## @_Z18callIntByReferencev
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	subq	$16, %rsp
	leaq	-4(%rbp), %rdi
	movl	$123, (%rdi)
	callq	__Z14intByReferenceRKi
	callq	__Z11doSomethingv
	addq	$16, %rsp
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
.subsections_via_symbols
