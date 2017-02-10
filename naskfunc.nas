;naskfunc
;TAB=4


[FORMAT "WCOFF"]			;�û��д�ĺ���֮��Ҫ��.c�ļ����ӣ�����Ҫ������Ŀ���ļ�
[INSTRSET "i486p"]
[BITS 32]					;����32λģʽ�Ļ�е����

[FILE "naskfunc.nas"]
		
		GLOBAL _io_hlt,_write_mem8
		GLOBAL	_io_cli,_io_out8,_io_load_eflags,_io_store_eflags
		
[SECTION .text]
	
_io_hlt:					;void io_hlt(void)
		HLT
		RET
		
_write_mem8:				;��ESP+4��ָ���ĵ�ַдһ���ֽڵ����ݣ�8λ��
							;void write_mem8(int addr,int data)
		MOV		ECX,[ESP+4]	;��ŵĵ�ַ���������ECX
		MOV		AL,[ESP+8]	;��ŵ����ݣ��������AL
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
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		