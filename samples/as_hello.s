#hello.s
.data				#数据段申明
	msg:.string "Hello,world!\n"	#输出的字符串
	len = . - msg					#字符串
.text				#代码段申明
.global _start		#指定函数入口

_start:				#在屏幕显示一个字符串
	movl $len,%edx	#参数三,字符串长度
	movl $msg,%ecx	#参数二,显示的长度
	movl $1,%ebx	#参数一,文件描述符(stdout)
	movl $4,%eax	#系统调用号(sys_write)
	int $0x80		#调用内核功能
		
					#退出程序
	movl $0,%ebx	#参数一:退出代码
	movl $1,%eax	#系统调用号(sys_exit)
	int $0x80		#调用内核功能
