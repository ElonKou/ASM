.section .data
data_item:
.long 23,2,0,9
.section .text
.global _start
_start:
	movl $0,%edi
	movl data_item(,%edi,4),%ebx
	movl $1,%eax
	int $0x80
