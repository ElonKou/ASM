!
!	boot.s	--	boostsect.s的框架,用代码0x07低缓msgl的1字符
!	然后在屏幕第一行进行显示
!
.global begtext,begdata,begbss,endtext,enddata,endbss	!全局标识符,提供给ld86链接使用
.text					!正文段
begtext:
.data					!数据段
begdata:
.bss					!未初始化的数据段
begbss:
.text					!正文段
BOOTSEG = 0x7c0			!BIOS加载bootsect代码的原始段地址

entry start				!告知链接程序,程序从start开始执行
start:
	jmpi	go,BOOTSEG	!段间跳转.BOOTSEG指出跳转的段地址,go指出偏移地址
go:	mov		ax,cs		!段寄存器cs值-->ax,用于初始化数据段寄存器ds和es
	mov 	ds,ax
	mov 	es,ax
	
	mov		[msg1+17],ah	!0x07-->替换字符串中的第17位的点标点符号,鸣喇叭
	mov		cx,#20			!总共显示20个字符,包括回车换行
	mov   	dx,#0x1004		!字符串将显示在17行,5列
	mov 	bx,#0x000c		!显示属性(red)
	mov 	bp,#msg1		!指向要显示的字符串
	mov 	ax,#0x1301		!写字符串并且移动光标到串尾处
	int 	0x10			!BIOS中断调用0x10,功能0x130,子功能x01
loop0:jmp loop0				!死循环
msg1:	.ascii 	"Loading system ..."	!调用BIOS显示信息,共20个ASCII字符
		.byte	13,10
.org 510					!表示以后从地址510(0x1fe)开始存放
		.word 0xAA55		!有效引导扇区标志,供BIOS加载扇区使用
.text
endtext:
.data
enddata:
.bss
endbss:

