	.section	__TEXT,__text,regular,pure_instructions
	.build_version macos, 11, 0	sdk_version 11, 3
	.globl	_main                           ## -- Begin function main
	.p2align	4, 0x90
_main:                                  ## @main
	.cfi_startproc
## %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	xorl	%eax, %eax
	movl	%eax, -24(%rbp)                 ## 4-byte Spill
	movl	$0, -4(%rbp)
	movl	$3, -8(%rbp)
	movl	-8(%rbp), %eax
	addl	$8, %eax
	movl	%eax, -12(%rbp)
	imull	$15, -8(%rbp), %eax
	movl	%eax, -16(%rbp)
	movl	-8(%rbp), %eax
	xorl	%edx, %edx
	movl	$71, %ecx
	divl	%ecx
	movl	%eax, %ecx
	movl	-24(%rbp), %eax                 ## 4-byte Reload
	movl	%ecx, -20(%rbp)
	popq	%rbp
	retq
	.cfi_endproc
                                        ## -- End function
.subsections_via_symbols
