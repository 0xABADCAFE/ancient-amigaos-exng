
; Storm C Compiler
; EXNG:libsrc/plat/amigaos3_68k/gfxlib/gfxutil.cpp
	mc68030
	mc68881
	XREF	_GetDTAttrs
	XREF	_DisposeDTObject
	XREF	_NewDTObject
	XREF	_DoMethod
	XREF	writeBytes__StreamOut__TPvUi
	XREF	close__StreamOut__T
	XREF	open__StreamOut__TPCcssUi
	XREF	rawReadBytes__StreamOut__TPvUij
	XREF	readBytes__StreamIn__TPvUi
	XREF	close__StreamIn__T
	XREF	open__StreamIn__TPCcsUi
	XREF	rawWriteBytes__StreamIn__TPvUij
	XREF	destroy__AsyncStreamBuffer__T
	XREF	sendPacket__AsyncStreamBuffer__TPv
	XREF	waitPacket__AsyncStreamBuffer__T
	XREF	getDrawSurface__Display__T
	XREF	setTitle__Display__TPCc
	XREF	refresh__Display__Tssss
	XREF	refresh__Display__T
	XREF	waitSync__Display__T
	XREF	close__Display__T
	XREF	reopen__Display__T
	XREF	open__Display__TP17DisplayPropertiesPCc
	XREF	open__Display__TssEPCc
	XREF	_0dt__NativeScreenDB__T
	XREF	_0ct__NativeScreenDB__T
	XREF	refresh__NativeScreenDB__T
	XREF	close__NativeScreenDB__T
	XREF	reopen__NativeScreenDB__T
	XREF	open__NativeScreenDB__TP17DisplayPropertiesPCc
	XREF	open__NativeScreenDB__TssEPCc
	XREF	_0dt__NativeScreen__T
	XREF	_0ct__NativeScreen__T
	XREF	close__NativeScreen__T
	XREF	reopen__NativeScreen__T
	XREF	open__NativeScreen__TP17DisplayPropertiesPCc
	XREF	open__NativeScreen__TssEPCc
	XREF	_0dt__NativeWindow__T
	XREF	_0ct__NativeWindow__T
	XREF	refresh__NativeWindow__Tssss
	XREF	refresh__NativeWindow__T
	XREF	close__NativeWindow__T
	XREF	open__NativeWindow__TP17DisplayPropertiesPCc
	XREF	open__NativeWindow__TssEPCc
	XREF	reopen__NativeWindow__T
	XREF	setDisplayTitle__DisplayNative__TPCcs
	XREF	waitForRefresh__DisplayNative__T
	XREF	blitCopy__Surface__P07SurfacessP07Surfacessss
	XREF	destroy__Surface__T
	XREF	init__Surface__T
	XREF	getHardwareFormat__Native2D__E
	XREF	findIndex__DisplayPropertiesProvider__ssEs
	XREF	getMode__DisplayPropertiesProvider__Ui
	XREF	destroy__ImageBuffer__T
	XREF	create__ImageBuffer__TssEP07Palettess
	XREF	runApplication__AppBase__T
	XREF	_system
	XREF	op__delete__PvUi
	XREF	op__new__Ui
	XREF	_std__in
	XREF	_std__out
	XREF	_std__err
	XREF	_SysBase
	XREF	_IntuitionBase
	XREF	_debug__SystemLib
	XREF	_allocated__Mem
	XREF	_volatileBuff__Mem
	XREF	_totalSize__Mem
	XREF	_nextFree__Mem
	XREF	_count__Mem
	XREF	_maxAllocs__Mem
	XREF	_propTab__PixelDescriptor
	XREF	_modesAvail__DisplayPropertiesProvider
	XREF	_numModes__DisplayPropertiesProvider
	XREF	_GfxBase
	XREF	_CyberGfxBase
	XREF	_pixelType__Native2D
	XREF	_convTab__Native2D
	XREF	_modeID__DisplayNative
	XREF	_DOSBase

	SECTION "getVolatile__Mem_:0",CODE

	rts

	SECTION "_redBalance__Colour:1",DATA

_redBalance__Colour
	dc.w	$4D

	SECTION "_greenBalance__Colour:1",DATA

_greenBalance__Colour
	dc.w	$96

	SECTION "_blueBalance__Colour:1",DATA

_blueBalance__Colour
	dc.w	$1C

	SECTION "loadImage__ImageLoader__PCcs:0",CODE


;ImageBuffer* ImageLoader::loadImage(const char* fileName,
	XDEF	loadImage__ImageLoader__PCcs
loadImage__ImageLoader__PCcs
L61	EQU	-$2A
	link	a5,#L61
	movem.l	d2-d4/a2/a3,-(a7)
	move.w	$C(a5),d2
	move.l	$8(a5),a3
L37
;	if (!fileName)
	cmp.w	#0,a3
	bne.b	L39
L38
;		return 0;
	moveq	#0,d0
	movem.l	(a7)+,d2-d4/a2/a3
	unlk	a5
	rts
L39
;	ImageBuffer* img = new ImageBuffer;
	pea	$1A.w
	jsr	op__new__Ui
	move.l	d0,a2
	addq.w	#4,a7
	cmp.w	#0,a2
	beq.b	L41
L40
	move.l	a2,a0
	clr.w	(a0)
	clr.w	2(a0)
	clr.l	4(a0)
	clr.l	$8(a0)
	clr.l	$C(a0)
	clr.l	$10(a0)
	clr.l	$14(a0)
	clr.w	$18(a0)
L41
;	if (!img)
	cmp.w	#0,a2
	bne.b	L43
L42
;		return 0;
	moveq	#0,d0
	movem.l	(a7)+,d2-d4/a2/a3
	unlk	a5
	rts
L43
;	Object* src = NewDTObject((char*)fileName, DTA_GroupID, GID_PICTUR
	clr.l	-(a7)
	pea	1.w
	move.l	#$800010FB,-(a7)
	clr.l	-(a7)
	move.l	#$800010D3,-(a7)
	move.l	#$70696374,-(a7)
	move.l	#$8000101F,-(a7)
	move.l	a3,-(a7)
	jsr	_NewDTObject
	add.w	#$20,a7
	move.l	d0,a3
;	if (src)
	cmp.w	#0,a3
	beq	L58
L44
;		DoMethod(src, DTM_PROCLAYOUT, NULL, 1);
	pea	1.w
	clr.l	-(a7)
	pea	$602.w
	move.l	a3,-(a7)
	jsr	_DoMethod
	add.w	#$10,a7
;		GetDTAttrs(src,
	clr.l	-(a7)
	pea	-$10(a5)
	move.l	#$800010CC,-(a7)
	pea	-$C(a5)
	move.l	#$800010D1,-(a7)
	pea	-$14(a5)
	move.l	#$800010C9,-(a7)
	move.l	a3,-(a7)
	jsr	_GetDTAttrs
	add.w	#$20,a7
;		bool					usePal = false;
	moveq	#0,d0
;		if (srcHead->bmh_Depth<=8)
	move.l	-$14(a5),a0
	move.b	$8(a0),d1
	cmp.b	#$8,d1
	bhi.b	L46
L45
;			dstFmt	= Pixel::INDEX8;
	moveq	#0,d2
;			cpyFmt	= PBPAFMT_LUT8;
	moveq	#3,d4
;			usePal	= true;
	moveq	#1,d0
;			dstBytesPerRow = srcHead->bmh_Width;
	move.l	-$14(a5),a0
	moveq	#0,d3
	move.w	(a0),d3
	bra.b	L50
L46
;		else if (srcHead->bmh_Depth<=24 && align==false)
	move.l	-$14(a5),a0
	move.b	$8(a0),d1
	cmp.b	#$18,d1
	bhi.b	L49
L47
	tst.w	d2
	bne.b	L49
L48
;			dstFmt	= Pixel::RGB24P;
	moveq	#$9,d2
;			cpyFmt	= PBPAFMT_RGB;
	moveq	#0,d4
;			dstBytesPerRow = srcHead->bmh_Width*3;
	move.l	-$14(a5),a0
	move.w	(a0),d3
	mulu	#3,d3
	bra.b	L50
L49
;			dstFmt	= Pixel::ARGB32B;
	moveq	#$B,d2
;			cpyFmt	= PBPAFMT_ARGB;
	moveq	#2,d4
;			dstBytesPerRow = srcHead->bmh_Width*4;
	move.l	-$14(a5),a0
	moveq	#0,d3
	move.w	(a0),d3
	moveq	#2,d1
	asl.l	d1,d3
L50
;		if (img->create(srcHead->bmh_Width, srcHead->bmh_Height,
	move.w	-$A(a5),-(a7)
	move.w	d0,-(a7)
	clr.l	-(a7)
	move.l	d2,-(a7)
	move.l	-$14(a5),a0
	move.w	2(a0),-(a7)
	move.l	-$14(a5),a0
	move.w	(a0),-(a7)
	move.l	a2,-(a7)
	jsr	create__ImageBuffer__TssEP07Palettess
	add.w	#$14,a7
	tst.l	d0
	bne	L57
L51
;			DoMethod(src, PDTM_READPIXELARRAY, img->getData(), cpyFmt,
	move.l	-$14(a5),a0
	moveq	#0,d0
	move.w	2(a0),d0
	move.l	d0,-(a7)
	move.l	-$14(a5),a0
	moveq	#0,d0
	move.w	(a0),d0
	move.l	d0,-(a7)
	clr.l	-(a7)
	clr.l	-(a7)
	move.l	d3,-(a7)
	move.l	d4,-(a7)
	move.l	$8(a2),-(a7)
	pea	$661.w
	move.l	a3,-(a7)
	jsr	_DoMethod
	add.w	#$24,a7
;			if (dstFmt == Pixel::INDEX8 && clrRegs!=0)
	tst.l	d2
	bne	L57
L52
	move.l	-$10(a5),a0
	cmp.w	#0,a0
	beq	L57
L53
;				Palette* clr = img->getPalette();
	move.l	$C(a2),a0
;				if (clr)
	cmp.w	#0,a0
	beq.b	L57
L54
;					for (sint32 i=0;
	moveq	#0,d0
	bra.b	L56
L55
;						(*clr)[i].red()=(*(clrRegs++)>>24);
	move.l	-$10(a5),a1
	moveq	#4,d1
	add.l	d1,-$10(a5)
	move.l	(a1),d1
	moveq	#$18,d2
	lsr.l	d2,d1
	move.b	d1,d2
	move.l	d0,d1
	and.l	#$FF,d1
	lea	0(a0,d1.l*4),a1
	move.b	d2,1(a1)
;						(*clr)[i].green()=(*(clrRegs++)>>24);
	move.l	-$10(a5),a1
	moveq	#4,d1
	add.l	d1,-$10(a5)
	move.l	(a1),d1
	moveq	#$18,d2
	lsr.l	d2,d1
	move.b	d1,d2
	move.l	d0,d1
	and.l	#$FF,d1
	lea	0(a0,d1.l*4),a1
	move.b	d2,2(a1)
;						(*clr)[i].blue()=(*(clrRegs++)>>24);
	move.l	-$10(a5),a1
	moveq	#4,d1
	add.l	d1,-$10(a5)
	move.l	(a1),d1
	moveq	#$18,d2
	lsr.l	d2,d1
	move.b	d1,d2
	move.l	d0,d1
	and.l	#$FF,d1
	lea	0(a0,d1.l*4),a1
	move.b	d2,3(a1)
	addq.l	#1,d0
L56
	cmp.l	-$C(a5),d0
	blo.b	L55
L57
;		DisposeDTObject(src);
	move.l	a3,-(a7)
	jsr	_DisposeDTObject
	addq.w	#4,a7
;		return img;
	move.l	a2,d0
	movem.l	(a7)+,d2-d4/a2/a3
	unlk	a5
	rts
L58
;	delete img;
	cmp.w	#0,a2
	beq.b	L60
L59
	move.l	a2,-(a7)
	jsr	destroy__ImageBuffer__T
	addq.w	#4,a7
	pea	$1A.w
	move.l	a2,-(a7)
	jsr	op__delete__PvUi
	addq.w	#$8,a7
L60
;	return 0;
	moveq	#0,d0
	movem.l	(a7)+,d2-d4/a2/a3
	unlk	a5
	rts

	END
