# hello.s
.data
	msg:.string "Hello,elonkou!\n"
	mm :.string "Length:__\n"
	data_item:.long 0
	len = . - msg
	ll  = . - mm
.text
.global _start
_start:
	movl $len,%edx		# length
	movl $msg,%ecx		# string
	movl $1,%ebx		# stdout
	movl $4,%eax		# sys_write
	int  $0x80

	movl $ll,%edx
	movl mm,%ecx
	int $0x80

	movl $ll,%ebx
	movl $1,%eax
	int  $0x80
