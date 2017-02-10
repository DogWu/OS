;naskfunc
;TAB=4


[FORMAT "WCOFF"]			;用汇编写的函数之后要与.c文件链接，所以要制作成目标文件
[INSTRSET "i486p"]
[BITS 32]					;制作32位模式的机械语言

[FILE "naskfunc.nas"]
		
		GLOBAL _io_hlt,_write_mem8
		GLOBAL	_io_cli,_io_out8,_io_load_eflags,_io_store_eflags
		
[SECTION .text]
	
_io_hlt:					;void io_hlt(void)
		HLT
		RET
		
_write_mem8:				;向ESP+4所指定的地址写一个字节的数据（8位）
							;void write_mem8(int addr,int data)
		MOV		ECX,[ESP+4]	;存放的地址，将其读入ECX
		MOV		AL,[ESP+8]	;存放的数据，将其读入AL
		MOV		[ECX],AL
		RET
		
_io_cli:					;void io_cli(void)
		CLI
		RET
		
_io_out8:					;void io_out8(int port,int data)
		MOV		EDX,[ESP+4]
		MOV		AL,[ESP+8]
		OUT		DX,AL
		RET
		
_io_load_eflags:			;void io_load_eflags(void)
		PUSHFD				;PUSH	EFLAGS
		POP		EAX
		RET
		
_io_store_eflags:			;void io_store_eflags(int eflags)
		MOV		EAX,[ESP+4]
		PUSH	EAX
		POPFD				;POP EFLAGS
		RET
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		