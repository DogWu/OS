;naskfunc
;TAB=4

[FORMAT "WCOFF"]			;�û��д�ĺ���֮��Ҫ��.c�ļ����ӣ�����Ҫ������Ŀ���ļ�
[BITS 32]					;����32λģʽ�Ļ�е����

[FILE "naskfunc.nas"]
		
		GLOBAL _io_hlt
		
[SECTION .text]
	
_io_hlt:
		HLT
		RET