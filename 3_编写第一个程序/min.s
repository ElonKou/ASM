# min.s

.section .data
data_item:
	.long 3,23,54,98,2,0
	.section .text
	.global _start
_start:
	movl $0,%edi
	movl data_item(,%edi,4), %eax
	movl %eax,%ebx

start_loop:
	incl %edi
	movl data_item(,%edi,4),%eax
	cmpl $0,%eax
	je loop_exit
	cmpl %eax,%ebx
	jle  start_loop

	movl %eax,%ebx
	jmp  start_loop

loop_exit:
	movl $1,%eax
	int $0x80
