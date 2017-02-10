;hello-os
;TAB=4

CYLS	EQU		10	
		ORG		0x7c00			;ָ�������װ�ص�ַ
		
;һ����δ����Ǳ�׼FAT12��ʽ����ר�õĴ���

		JMP		entry
		DB		0x90
		DB		"helloipl"		;�����������ƿ�����������ַ�����8�ֽڣ�
		DW		512				;ÿ�������Ĵ�С��512�ֽ�
		DB		1				;�صĴ�С��1������
		DW		1				;FAT����ʼλ�ã�һ��ӵ�һ��������ʼ
		DB 		2				;FAT�ĸ���
		DW		224				;��Ŀ¼�Ĵ�С��224��
		DW		2880			;�ô��̵Ĵ�С��2880����
		DB		0xf0			;���̵�����
		DW		9				;FAT�ĳ��ȣ�9������
		DW		18				;1���ŵ���18������
		DW		2				;��ͷ��
		DD		0				;��ʹ�÷���
		DD		2880			;��дһ�δ��̴�С
		DB		0,0,0x29		;���岻��
		DD		0xffffffff		;�����룿
		DB		"HARIBOTEOS "	;���̵����ƣ�11�ֽ�
		DB		"FAT12   "		;���̸�ʽ���ƣ�8�ֽ�
		RESB	18				;�ճ�18�ֽ�

;���������
entry:
		MOV		AX,0			;��ʼ���Ĵ���
		MOV		SS,AX
		MOV		SP,0x7C00
		MOV		DS,AX
		
		;�Ķ�����
		MOV		AX,0x0820
		MOV		ES,AX
		MOV		CH,0			;����0
		MOV		DH,0			;��ͷ0
		MOV		CL,2			;����2
readloop:
		MOV		SI,0			;��¼ʧ�ܴ����ļĴ���
retry:
		MOV		AH,0x02			;����
		MOV		AL,1			;1������
		MOV		BX,0
		MOV		DL,0x00			;A������
		INT		0x13			;���ô���BIOS
		JNC		next
		ADD		SI,1
		CMP		SI,5
		JAE		error
		MOV		AH,0x00
		MOV		DL,0x00			
		INT		0x13			;54-56�����еĹ����Ǹ�λ����״̬
		JMP		retry
next:
		MOV		AX,ES			
		ADD		AX,0x0020
		MOV		ES,AX			;��Ϊû��ADD ES,0X020ָ����Խ���AX�����ڴ��ַ����0x200��һ�������Ĵ�С��
		ADD		CL,1
		CMP		CL,18
		JBE		readloop
		MOV		CL,1
		ADD		DH,1
		CMP		DH,2
		JB		readloop
		MOV		DH,0
		ADD		CH,1
		CMP		CH,CYLS
		JB		readloop
	;������10�������ִ��fun.sys	
		MOV		[0x0ff0],CH
		JMP		0xc200
fin:
		HLT
		JMP		fin
error:
		MOV		SI,msg
putloop:
		MOV		AL,[SI]
		ADD		SI,1
		CMP		AL,0	
		JE		fin
		MOV		AH,0x0e			;��ʾһ���ַ�
		MOV		BX,15			;ָ���ַ���ɫ
		INT		0x10			;�����Կ�BIOS
		JMP		putloop

msg:
		DB		0x0a,0x0a		;����*2
		DB  	"load,error"
		DB		0x0a
		DB		0
		
		RESB	0x7dfe-$			;$��ʾ�������ڵ��ֽ�������д0x00��ֱ��0x001fe
		DB		0x55,0xaa		;��һ��������Ҳ����������������������ֽ�Ϊ0x55,0xaa�����������Ϊ��������Ŀ�ͷ���������򣬲���ʼִ���������