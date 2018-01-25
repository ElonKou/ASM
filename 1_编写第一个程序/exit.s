# 退出并且想linux内核返回一个状态码的简单程序

# 输入: 无
# 输出:返回状态码,在运行中可以通过输入echo$?来读取状态码
# 变量:
#       %eax:保存系统调用号
#       %ebx:保存返回状态
.section .data
.section .text
.globl _start
_start:

movl    $1, %eax        # 这是用于退出程序的linux内核命令号(系统调用)
movl    $0, %ebx        # 这是我们将返回给操作系统的状态码

int     $0x80           # 这将唤醒内核,以运行退出命令
