;naskfunc
;TAB=4


[FORMAT "WCOFF"]			;�û��д�ĺ���֮��Ҫ��.c�ļ����ӣ�����Ҫ������Ŀ���ļ�
[INSTRSET "i486p"]
[BITS 32]					;����32λģʽ�Ļ�е����

[FILE "naskfunc.nas"]
		
		GLOBAL _io_hlt,_write_mem8
		
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