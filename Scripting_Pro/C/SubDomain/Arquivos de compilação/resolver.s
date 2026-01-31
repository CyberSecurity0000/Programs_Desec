	.file	"resolver.c"
	.text
	.section	.rodata
	.align 8
.LC0:
	.string	"Usage: %s <wordlist> <dominio>\n"
.LC1:
	.string	"r"
.LC2:
	.string	"Erro ao abrir arquivo: %s\n"
.LC3:
	.string	"\n"
.LC4:
	.string	"%s.%s"
.LC5:
	.string	"[OK] %s -> %s\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB6:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$832, %rsp
	movl	%edi, -820(%rbp)
	movq	%rsi, -832(%rbp)
	cmpl	$3, -820(%rbp)
	je	.L2
	movq	-832(%rbp), %rax
	movq	(%rax), %rax
	leaq	.LC0(%rip), %rdx
	movq	%rax, %rsi
	movq	%rdx, %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$1, %eax
	jmp	.L8
.L2:
	movq	-832(%rbp), %rax
	movq	8(%rax), %rax
	movq	%rax, -8(%rbp)
	movq	-832(%rbp), %rax
	movq	16(%rax), %rax
	movq	%rax, -16(%rbp)
	leaq	.LC1(%rip), %rdx
	movq	-8(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	fopen@PLT
	movq	%rax, -24(%rbp)
	cmpq	$0, -24(%rbp)
	jne	.L5
	movq	-8(%rbp), %rax
	leaq	.LC2(%rip), %rdx
	movq	%rax, %rsi
	movq	%rdx, %rdi
	movl	$0, %eax
	call	printf@PLT
	movl	$1, %eax
	jmp	.L8
.L7:
	leaq	.LC3(%rip), %rdx
	leaq	-304(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcspn@PLT
	movb	$0, -304(%rbp,%rax)
	movq	-16(%rbp), %rcx
	leaq	-304(%rbp), %rdx
	leaq	.LC4(%rip), %rsi
	leaq	-816(%rbp), %rax
	movq	%rcx, %r8
	movq	%rdx, %rcx
	movq	%rsi, %rdx
	movl	$512, %esi
	movq	%rax, %rdi
	movl	$0, %eax
	call	snprintf@PLT
	leaq	-816(%rbp), %rax
	movq	%rax, %rdi
	call	gethostbyname@PLT
	movq	%rax, -32(%rbp)
	cmpq	$0, -32(%rbp)
	jne	.L6
	jmp	.L5
.L6:
	movq	-32(%rbp), %rax
	movq	24(%rax), %rax
	movq	(%rax), %rax
	movl	(%rax), %eax
	movl	%eax, %edi
	call	inet_ntoa@PLT
	movq	%rax, -40(%rbp)
	movq	-40(%rbp), %rdx
	leaq	-816(%rbp), %rax
	leaq	.LC5(%rip), %rcx
	movq	%rax, %rsi
	movq	%rcx, %rdi
	movl	$0, %eax
	call	printf@PLT
.L5:
	movq	-24(%rbp), %rdx
	leaq	-304(%rbp), %rax
	movl	$256, %esi
	movq	%rax, %rdi
	call	fgets@PLT
	testq	%rax, %rax
	jne	.L7
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	fclose@PLT
	movl	$0, %eax
.L8:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	main, .-main
	.ident	"GCC: (Debian 15.2.0-12) 15.2.0"
	.section	.note.GNU-stack,"",@progbits
