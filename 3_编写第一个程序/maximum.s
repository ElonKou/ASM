# 目的: 找到最大值
# 变量:
#       %edi:   当前检测的数据索引项
#       %ebx:   当前已经找到的最大数据项
#       %eax:   当前数据项
# 使用的内存位置:
# data_items:   包含的数据项
#          0:   表示数据结束

.section .data
data_items:             # 数据项
.long   39,67,34,222,45,75,54,34,44,33,22,11,66,255

.section .text
.globl _start
_start:
    movl    $0, %edi                    # 将0 移入索引寄存器
    movl    data_items(,%edi,4),%eax    # 加载数据的第一个字节
    movl    %eax,   %ebx                # 第一个字节就是最大值

start_loop:                             # 开始循环
    cmpl    $255,  %eax                 # 检测是否到达数据尾
    je      loop_exit                   # 到达则执行退出
    incl    %edi                        # 否则执行自增
    movl    data_items(,%edi,4),%eax    # 取出下一个数据
    cmpl    %eax,   %ebx                # 比较值的大小
    jle     start_loop                  # 若新项不大于原最大值
                                        # 则调到循环起始位置
    movl    %eax,   %ebx                # 否则移动最大值到ebx
    jmp start_loop                      # 实现跳转

loop_exit:                              # ebx中已经存放了返回值
    movl    $1, %eax                    # 调用系统调用进行返回
    int     $0x80





