;hello-os
;TAB=4

CYLS	EQU		10	
		ORG		0x7c00			;指明程序的装载地址
		
;一下这段代码是标准FAT12格式软盘专用的代码

		JMP		entry
		DB		0x90
		DB		"helloipl"		;启动区的名称可以是任意的字符串（8字节）
		DW		512				;每个扇区的大小，512字节
		DB		1				;簇的大小，1个扇区
		DW		1				;FAT的起始位置，一般从第一个扇区开始
		DB 		2				;FAT的个数
		DW		224				;根目录的大小，224项
		DW		2880			;该磁盘的大小，2880扇区
		DB		0xf0			;磁盘的种类
		DW		9				;FAT的长度，9个扇区
		DW		18				;1个磁道有18个扇区
		DW		2				;磁头数
		DD		0				;不使用分区
		DD		2880			;重写一次磁盘大小
		DB		0,0,0x29		;意义不明
		DD		0xffffffff		;卷标号码？
		DB		"HARIBOTEOS "	;磁盘的名称，11字节
		DB		"FAT12   "		;磁盘格式名称，8字节
		RESB	18				;空出18字节

;程序的主体
entry:
		MOV		AX,0			;初始化寄存器
		MOV		SS,AX
		MOV		SP,0x7C00
		MOV		DS,AX
		
		;阅读磁盘
		MOV		AX,0x0820
		MOV		ES,AX
		MOV		CH,0			;柱面0
		MOV		DH,0			;磁头0
		MOV		CL,2			;扇区2
readloop:
		MOV		SI,0			;记录失败次数的寄存器
retry:
		MOV		AH,0x02			;读盘
		MOV		AL,1			;1个扇区
		MOV		BX,0
		MOV		DL,0x00			;A驱动器
		INT		0x13			;调用磁盘BIOS
		JNC		next
		ADD		SI,1
		CMP		SI,5
		JAE		error
		MOV		AH,0x00
		MOV		DL,0x00			
		INT		0x13			;54-56这三行的功能是复位软盘状态
		JMP		retry
next:
		MOV		AX,ES			
		ADD		AX,0x0020
		MOV		ES,AX			;因为没有ADD ES,0X020指令，所以借助AX，将内存地址后移0x200（一个扇区的大小）
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
	;加载了10个柱面后，执行fun.sys	
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
		MOV		AH,0x0e			;显示一个字符
		MOV		BX,15			;指定字符颜色
		INT		0x10			;调用显卡BIOS
		JMP		putloop

msg:
		DB		0x0a,0x0a		;换行*2
		DB  	"load,error"
		DB		0x0a
		DB		0
		
		RESB	0x7dfe-$			;$表示现在所在的字节数，填写0x00，直到0x001fe
		DB		0x55,0xaa		;第一个扇区，也就是启动区，的最后两个字节为0x55,0xaa，计算机会认为这个扇区的开头是启动程序，并开始执行这个程序