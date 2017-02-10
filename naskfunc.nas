;naskfunc
;TAB=4

[FORMAT "WCOFF"]			;用汇编写的函数之后要与.c文件链接，所以要制作成目标文件
[BITS 32]					;制作32位模式的机械语言

[FILE "naskfunc.nas"]
		
		GLOBAL _io_hlt
		
[SECTION .text]
	
_io_hlt:
		HLT
		RET