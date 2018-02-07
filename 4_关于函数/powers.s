.section .data
.section .text

#.code32

.globl _start
_start:
nop
	pushq	$5					# 压入第二个参数
	pushq	$2					# 压入第一个参数
	call	power				# 调用函数
	addq	$16,	%rsp		# 栈指针后移动
	pushq	%rax				# 保存第一个答案

	pushq	$2					# 压入第二个参数
	pushq	$6					# 压入第一个参数
	call 	power				# 调用函数
	addq	$16,	%rsp		# 后移指针

	popq	%rbx				# 存储之前得到的计算结果
	addq 	%rax,	%rbx		# 相加存储到rbx中

	movq	$1,		%rax		# 退出结果
	int 	$0x80


# 目的: 本函数用于计算一个数的幂
#	输入:
#		第一个参数:	底数
# 		第二个参数:	指数
#	输出:
#		返回结果保存最后计算的结果
#	变量:
#		%rbx:	保存底数
#		%rax:	保存指数
#			-4(%rbp):	保存当前结果
#			%rax:		咱叔暂时存储

.type power,@function			
power:
	pushq	%rbp					# 保留旧基址指针
	movq	%rsp,	%rbp			# 将栈指针保留在基址指针中
	subq	$8,		%rsp			# 留出一个字的宽度用来存储本地变量
	movq	16(%rbp),	%rbx		# 将第一个参数存储在rax
	movq	24(%rbp),	%rcx		# 第二个变量存储在rcx中
	movq	%rbx,		-8(%rbp)	# 存储当前结果

power_loop_start:
	cmpq 	$1,			%rcx		# 如果是一次方,得到结果
	je		end_power				
	movq	-8(%rbp),	%rax		# 将当前的结果移到rax
	imulq	%rbx,		%rax		# 将当前的结果与底数相乘
	movq	%rax,		-8(%rbp)	# 保存当前的结果

	decq	%rcx					# 指数递减
	jmp	power_loop_start			# 为递减后的指数进行幂计算
	
end_power:
	movq 	-8(%rbp),	%rax		# 返回值移到rax
	movq	%rbp,		%rsp		# 恢复栈指针
	popq	%rbp					# 恢复基址指针
	ret

