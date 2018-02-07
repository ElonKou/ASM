.section .data
.section .text
.globl _start
_start:
	pushq 	$1
	popq	%rax
	movq	%rax,	%rbx
	int $0x80
