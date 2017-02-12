#include<stdio.h>
#include "bootpack.h"

void HariMain(void){
	
	BOOTINFO *binfo;	
	binfo=(BOOTINFO *)ADR_BOOTINFO;
	char s[40],mcursor[256];
	int mx,my;
	
	init_gdtidt();
	init_palette();
	init_screen8(binfo->vram,binfo->scrnx,binfo->scrny);
	mx=(binfo->scrnx)/2;		//蓝色部分的中心位置
	my=(binfo->scrny-28)/2;
	init_mouse_cursor8(mcursor,COL8_008484);	//将箭头游标数组填上白色，黑色边框，背景色
	putblock8_8(binfo->vram,binfo->scrnx,16,16,mx,my,mcursor,16);
	
	//putfont8_asc(binfo->vram,binfo->scrnx,8,8,COL8_FFFFFF,"ABC 123");
	//putfont8_asc(binfo->vram,binfo->scrnx,30,30,COL8_000000,"suchfun");
	//putfont8_asc(binfo->vram,binfo->scrnx,31,31,COL8_FFFFFF,"suchfun");
	
	sprintf(s,"(%d,%d)",mx,my);
	putfonts8_asc(binfo->vram,binfo->scrnx,0,0,COL8_FFFFFF,s);
	
	for(;;)	io_hlt();
}











