; hello.asm							
section .data						;数据段申明
	msg db "Hello ,elonkou!",0xA	;输出的字符串
	mmm db "This is in linux!",0xA
	len equ $ - msg					;字符串长度
	lll equ $ - mmm					;字符串长度
section .text						;代码段申明
global _start						;制定入口函数
_start:								;在屏幕上下显示一个字符串
	mov edx,len						;参数三:显示的长度
	mov ecx,msg						;参数二:显示的字符串
	mov ebx,1						;参数一:文件描述符(stdout)
	mov eax,4						;系统调用号(sys_write)
	int 0x80						;调用内核功能
									;显示第二个字符串
	mov edx,lll						;参数三:显示的长度
	mov ecx,mmm						;参数二:显示的字符串
	mov ebx,1						;参数一:文件描述符(stdout)
	;mov eax,4						;系统调用号(sys_write)
	int 0x80						;调用内核功能
									;退出程序
	mov ebx,0						;参数一:退出代码
	mov eax,1						;系统调用号(sys_exit)
	int 0x80						;调用内核功能
