
; Storm C Compiler
; EXNG:libsrc/plat/amigaos3_68k/gfxlib/surface.cpp
	mc68030
	mc68881
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
	XREF	getHardwareFormat__Native2D__E
	XREF	convertPixels__Native2D__PvPvEEssssP07Palette
	XREF	findIndex__DisplayPropertiesProvider__ssEs
	XREF	getMode__DisplayPropertiesProvider__Ui
	XREF	destroy__ImageBuffer__T
	XREF	runApplication__AppBase__T
	XREF	printDebug__SystemLib__PCci
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

	SECTION "blitCopy__Surface__P07SurfacessP07Surfacessss:0",CODE


;sint32 Surface::blitCopy(Surface* dst, S_CRD1, Surface* src, S_CRD2,
	XDEF	blitCopy__Surface__P07SurfacessP07Surfacessss
blitCopy__Surface__P07SurfacessP07Surfacessss
	movem.l	d2-d7/a2/a6,-(a7)
	move.w	$30(a7),d0
	move.w	$32(a7),d1
	move.w	$28(a7),d2
	move.w	$2A(a7),d3
	move.w	$34(a7),d4
	move.w	$36(a7),d5
	move.l	$24(a7),a0
	move.l	$2C(a7),a2
L66
;	if ((!dst) || (!src) || (!dst->bitMap) || (!dst->bitMap))
	cmp.w	#0,a0
	beq.b	L70
L67
	cmp.w	#0,a2
	beq.b	L70
L68
	tst.l	$E(a0)
	beq.b	L70
L69
	tst.l	$E(a0)
	bne.b	L71
L70
;		return ERR_PTR_ZERO;
	move.l	#-$3020002,d0
	movem.l	(a7)+,d2-d7/a2/a6
	rts
L71
;	if (src->pixFormat != dst->pixFormat)
	move.l	$26(a2),d6
	cmp.l	$26(a0),d6
	beq.b	L73
L72
;		return ERR_RSC_TYPE;
	move.l	#-$3050003,d0
	movem.l	(a7)+,d2-d7/a2/a6
	rts
L73
;	if (x2<0 || y2<0 || w<1 || h<1)
	tst.w	d0
	bmi.b	L77
L74
	tst.w	d1
	bmi.b	L77
L75
	cmp.w	#1,d4
	blt.b	L77
L76
	cmp.w	#1,d5
	bge.b	L78
L77
;		return ERR_VALUE_MIN;
	move.l	#-$3010004,d0
	movem.l	(a7)+,d2-d7/a2/a6
	rts
L78
;	if (x2+w > src->width || y2+h > src->height)
	move.w	d0,d6
	ext.l	d6
	move.l	d6,d7
	move.w	d4,d6
	ext.l	d6
	add.l	d6,d7
	move.w	(a2),d6
	ext.l	d6
	cmp.l	d6,d7
	bgt.b	L80
L79
	move.w	d1,d6
	ext.l	d6
	move.l	d6,d7
	move.w	d5,d6
	ext.l	d6
	add.l	d6,d7
	move.w	2(a2),d6
	ext.l	d6
	cmp.l	d6,d7
	ble.b	L81
L80
;		return ERR_VALUE_MAX;
	move.l	#-$3010002,d0
	movem.l	(a7)+,d2-d7/a2/a6
	rts
L81
;	if (x1>=dst->width || y1>=dst->height || (x1+w)<1 || (y1+h)<1)
	cmp.w	(a0),d2
	bge.b	L85
L82
	cmp.w	2(a0),d3
	bge.b	L85
L83
	move.w	d2,d6
	ext.l	d6
	move.l	d6,d7
	move.w	d4,d6
	ext.l	d6
	add.l	d6,d7
	move.l	d7,d6
	cmp.l	#1,d6
	blt.b	L85
L84
	move.w	d3,d6
	ext.l	d6
	move.l	d6,d7
	move.w	d5,d6
	ext.l	d6
	add.l	d6,d7
	move.l	d7,d6
	cmp.l	#1,d6
	bge.b	L86
L85
;		return OK;
	moveq	#0,d0
	movem.l	(a7)+,d2-d7/a2/a6
	rts
L86
;	if (x1<0)								
	tst.w	d2
	bpl.b	L88
L87
; w += x1;
	add.w	d2,d4
; x2 -= x1;
	sub.w	d2,d0
; x1 = 0;
	moveq	#0,d2
L88
;	if (x1+w > dst->width)	
	move.w	d2,d6
	ext.l	d6
	move.l	d6,d7
	move.w	d4,d6
	ext.l	d6
	add.l	d6,d7
	move.w	(a0),d6
	ext.l	d6
	cmp.l	d6,d7
	ble.b	L90
L89
; w = dst->width - x1;
	move.w	(a0),d4
	ext.l	d4
	move.w	d2,d6
	ext.l	d6
	sub.l	d6,d4
L90
;	if (y1<0)								
	tst.w	d3
	bpl.b	L92
L91
; h += y1;
	add.w	d3,d5
; y2 -= y1;
	sub.w	d3,d1
; y1 = 0;
	moveq	#0,d3
L92
;	if (y1+h > dst->height)	
	move.w	d3,d6
	ext.l	d6
	move.l	d6,d7
	move.w	d5,d6
	ext.l	d6
	add.l	d6,d7
	move.w	2(a0),d6
	ext.l	d6
	cmp.l	d6,d7
	ble.b	L94
L93
; h = dst->height - y1;
	move.w	2(a0),d5
	ext.l	d5
	move.w	d3,d6
	ext.l	d6
	sub.l	d6,d5
L94
;	BltBitMap(src->bitMap, x2, y2, dst->bitMap, x1, y1, w, h, 0xC0, 0x
	ext.l	d5
	ext.l	d4
	ext.l	d3
	ext.l	d2
	move.l	$E(a0),a1
	ext.l	d1
	ext.l	d0
	move.l	$E(a2),a0
	move.l	_GfxBase,a6
	move.l	#$C0,d6
	move.l	#$FF,d7
	sub.l	a2,a2
	jsr	-$1E(a6)
;	return OK;
	moveq	#0,d0
	movem.l	(a7)+,d2-d7/a2/a6
	rts

	SECTION "putImageBuffer__Surface__TP11ImageBufferssssss:0",CODE


;sint32 Surface::putImageBuffer(ImageBuffer* img, S_CRD1, S_CRD2, S_W
	XDEF	putImageBuffer__Surface__TP11ImageBufferssssss
putImageBuffer__Surface__TP11ImageBufferssssss
L127	EQU	-$28
	link	a5,#L127
	movem.l	d2-d7/a2/a3/a6,-(a7)
	movem.l	$8(a5),a2/a3
	move.w	$12(a5),d0
	move.w	$10(a5),d1
	move.w	$1A(a5),d2
	move.w	$18(a5),d3
	move.w	$14(a5),d4
	move.w	$16(a5),d7
L95
;	if (!bitMap || !img || (!img->getData()))
	tst.l	$E(a2)
	beq.b	L99
L96
	cmp.w	#0,a3
	beq.b	L99
L97
	tst.l	$8(a3)
	bne.b	L100
L98
L99
;		return ERR_PTR_ZERO;
	move.l	#-$3020002,d0
	movem.l	(a7)+,d2-d7/a2/a3/a6
	unlk	a5
	rts
L100
;	if (x2<0 || y2<0 || w<1 || h<1)
	tst.w	d4
	bmi.b	L104
L101
	tst.w	d7
	bmi.b	L104
L102
	cmp.w	#1,d3
	blt.b	L104
L103
	cmp.w	#1,d2
	bge.b	L105
L104
;		return ERR_VALUE_MIN;
	move.l	#-$3010004,d0
	movem.l	(a7)+,d2-d7/a2/a3/a6
	unlk	a5
	rts
L105
;	if (x2+w > img->getW() || y2+h > img->getH())
	move.w	d4,d5
	ext.l	d5
	move.w	d3,d6
	ext.l	d6
	add.l	d6,d5
	move.w	(a3),d6
	ext.l	d6
	cmp.l	d6,d5
	bgt.b	L107
L106
	move.w	d7,d5
	ext.l	d5
	move.w	d2,d6
	ext.l	d6
	add.l	d6,d5
	move.w	2(a3),d6
	ext.l	d6
	cmp.l	d6,d5
	ble.b	L108
L107
;		return ERR_VALUE_MAX;
	move.l	#-$3010002,d0
	movem.l	(a7)+,d2-d7/a2/a3/a6
	unlk	a5
	rts
L108
;	if (x1>=width || y1>=height || (x1+w)<1 || (y1+h)<1)
	cmp.w	(a2),d1
	bge.b	L112
L109
	cmp.w	2(a2),d0
	bge.b	L112
L110
	move.w	d1,d5
	ext.l	d5
	move.w	d3,d6
	ext.l	d6
	add.l	d6,d5
	cmp.l	#1,d5
	blt.b	L112
L111
	move.w	d0,d5
	ext.l	d5
	move.w	d2,d6
	ext.l	d6
	add.l	d6,d5
	cmp.l	#1,d5
	bge.b	L113
L112
;		return OK;
	moveq	#0,d0
	movem.l	(a7)+,d2-d7/a2/a3/a6
	unlk	a5
	rts
L113
;	if (x1<0)						
	tst.w	d1
	bpl.b	L115
L114
; w	+= x1;
	add.w	d1,d3
; x2 -= x1;
	sub.w	d1,d4
; x1 = 0;
	moveq	#0,d1
L115
;	if (x1+w > width)		
	move.w	d1,d5
	ext.l	d5
	move.w	d3,d6
	ext.l	d6
	add.l	d6,d5
	move.w	(a2),d6
	ext.l	d6
	cmp.l	d6,d5
	ble.b	L117
L116
; w = width - x1;
	move.w	(a2),d3
	ext.l	d3
	move.w	d1,d5
	ext.l	d5
	sub.l	d5,d3
L117
;	if (y1<0)						
	tst.w	d0
	bpl.b	L119
L118
; h += y1;
	add.w	d0,d2
; y2 -= y1;
	move.w	d7,d5
	sub.w	d0,d5
	move.w	d5,d7
; y1 = 0;
	moveq	#0,d0
L119
;	if (y1+h > height)	
	move.w	d0,d5
	ext.l	d5
	move.w	d2,d6
	ext.l	d6
	add.l	d6,d5
	move.w	2(a2),d6
	ext.l	d6
	cmp.l	d6,d5
	ble.b	L121
L120
; h = height - y1;
	move.w	2(a2),d2
	ext.l	d2
	move.w	d0,d5
	ext.l	d5
	sub.l	d5,d2
L121
;	P_F			srcFormat = img->getFormat();
	move.l	$14(a3),-4(a5)
;	sint32	srcWidth	= img->getW();
	move.w	(a3),d5
	ext.l	d5
	move.l	d5,d6
;	void*		srcData		= img->getData();
	move.l	$8(a3),a6
;	size_t dofs = (x1+(y1*hwWidth))*(PixelDescriptor::get(pixFormat)->
	move.w	d1,d5
	ext.l	d5
	muls	$1E(a2),d0
	add.l	d0,d5
	move.l	$26(a2),d0
	muls.l	#$C,d0
	move.l	#_propTab__PixelDescriptor,a1
	move.b	0(a1,d0.l),d0
	and.l	#$FF,d0
	mulu.l	d0,d5
;	size_t sofs = (x2+(y2*srcWidth))*(PixelDescriptor::get(srcFormat)-
	ext.l	d4
	move.w	d7,d0
	ext.l	d0
	muls.l	d6,d0
	add.l	d0,d4
	move.l	-4(a5),d0
	muls.l	#$C,d0
	move.l	#_propTab__PixelDescriptor,a1
	move.b	0(a1,d0.l),d0
	and.l	#$FF,d0
	muls.l	d0,d4
;	if (lockAddr)
	tst.l	$16(a2)
	beq.b	L123
L122
;		void* dst	= ((uint8*)gfxAddr)+dofs;
	move.l	d5,d0
	add.l	$12(a2),d0
	move.l	d0,-$18(a5)
;		void* src = ((uint8*)srcData)+sofs;
;		convertPixels(dst, src, pixFormat, srcFormat, w, h, hwWidth, src
	move.l	$C(a3),-(a7)
	move.w	d6,-(a7)
	move.w	$1E(a2),-(a7)
	move.w	d2,-(a7)
	move.w	d3,-(a7)
	move.l	-4(a5),-(a7)
	move.l	$26(a2),-(a7)
	pea	0(a6,d4.l)
	move.l	-$18(a5),-(a7)
	jsr	convertPixels__Native2D__PvPvEEssssP07Palette
	add.w	#$1C,a7
	bra.b	L126
L123
;		if (dst = lockData())
	move.l	a2,-(a7)
	jsr	lockData__Surface__T
	addq.w	#4,a7
	move.l	d0,a0
	cmp.w	#0,a0
	beq.b	L125
L124
;			((uint8*)dst) += dofs;
; void* src = ((uint8*)srcData)+sofs;
	move.l	d4,d0
	add.l	a6,d0
	move.l	d0,a6
;			convertPixels(dst, src, pixFormat, srcFormat, w, h, hwWidth, s
	move.l	$C(a3),-(a7)
	move.w	d6,-(a7)
	move.w	$1E(a2),-(a7)
	move.w	d2,-(a7)
	move.w	d3,-(a7)
	move.l	-4(a5),-(a7)
	move.l	$26(a2),-(a7)
	move.l	a6,-(a7)
	pea	0(a0,d5.l)
	jsr	convertPixels__Native2D__PvPvEEssssP07Palette
	add.w	#$1C,a7
;			unlockData();
	move.l	a2,-(a7)
	jsr	unlockData__Surface__T
	addq.w	#4,a7
	bra.b	L126
L125
;			return ERR_RSC_UNAVAILABLE;
	move.l	#-$3050005,d0
	movem.l	(a7)+,d2-d7/a2/a3/a6
	unlk	a5
	rts
L126
;	return OK;
	moveq	#0,d0
	movem.l	(a7)+,d2-d7/a2/a3/a6
	unlk	a5
	rts

	SECTION "init__Surface__T:0",CODE


;void Surface::init()
	XDEF	init__Surface__T
init__Surface__T
	move.l	4(a7),a0
L128
;	width				= 0;
	clr.w	(a0)
;	height			= 0;
	clr.w	2(a0)
;	winUser			= 0;
	clr.l	$A(a0)
;	bitMap			= 0;
	clr.l	$E(a0)
;	gfxAddr			= 0;
	clr.l	$12(a0)
;	lockAddr		= 0;
	clr.l	$16(a0)
;	properties	= 0;
	clr.l	$1A(a0)
;	hwWidth			= 0;
	clr.w	$1E(a0)
;	hwHeight		= 0;
	clr.w	$20(a0)
;	modulus			= 0;
	clr.w	$22(a0)
;	depth				= 0;
	clr.w	$24(a0)
;	pixFormat		= Pixel::OTHERFMT;
	move.l	#$F,$26(a0)
	rts

	SECTION "queryBitMap__Surface__T:0",CODE


;void Surface::queryBitMap()
	XDEF	queryBitMap__Surface__T
queryBitMap__Surface__T
	movem.l	d2/a2/a6,-(a7)
	move.l	$10(a7),a2
L129
;	hwWidth		= GetCyberMapAttr(bitMap, CYBRMATTR_WIDTH);
	move.l	a2,a1
	move.l	_CyberGfxBase,a6
	move.l	#$80000005,d0
	move.l	$E(a1),a0
	jsr	-$60(a6)
	move.l	a2,a0
	move.w	d0,$1E(a0)
;	hwHeight	= GetCyberMapAttr(bitMap, CYBRMATTR_HEIGHT);
	move.l	a2,a1
	move.l	_CyberGfxBase,a6
	move.l	#$80000006,d0
	move.l	$E(a1),a0
	jsr	-$60(a6)
	move.l	a2,a0
	move.w	d0,$20(a0)
;	depth			= GetCyberMapAttr(bitMap, CYBRMATTR_DEPTH);
	move.l	a2,a1
	move.l	_CyberGfxBase,a6
	move.l	#$80000007,d0
	move.l	$E(a1),a0
	jsr	-$60(a6)
	move.l	a2,a0
	move.w	d0,$24(a0)
;	modulus		= (GetCyberMapAttr(bitMap, CYBRMATTR_XMOD) /
	move.l	a2,a1
	move.l	_CyberGfxBase,a6
	move.l	#$80000001,d0
	move.l	$E(a1),a0
	jsr	-$60(a6)
	move.l	d0,d2
	move.l	a2,a1
	move.l	_CyberGfxBase,a6
	move.l	#$80000002,d0
	move.l	$E(a1),a0
	jsr	-$60(a6)
	divul.l	d0,d2
	move.l	a2,a0
	move.w	(a0),d0
	ext.l	d0
	sub.l	d0,d2
	move.l	a2,a0
	move.w	d2,$22(a0)
;	if (GetCyberMapAttr(bitMap, CYBRMATTR_ISLINEARMEM))
	move.l	a2,a1
	move.l	_CyberGfxBase,a6
	move.l	#$80000009,d0
	move.l	$E(a1),a0
	jsr	-$60(a6)
	tst.l	d0
	beq.b	L131
L130
;		properties |= LINEARMEM;
	move.l	a2,a0
	move.l	$1A(a0),d0
	or.l	#4,d0
	move.l	a2,a0
	move.l	d0,$1A(a0)
	bra.b	L132
L131
;		properties &= ~LINEARMEM;
	move.l	a2,a0
	move.l	$1A(a0),d0
	and.l	#-5,d0
	move.l	a2,a0
	move.l	d0,$1A(a0)
L132
;	pixFormat	= (P_F)GetCyberMapAttr(bitMap, CYBRMATTR_PIXFMT);
	move.l	a2,a1
	move.l	_CyberGfxBase,a6
	move.l	#$80000004,d0
	move.l	$E(a1),a0
	jsr	-$60(a6)
	move.l	a2,a0
	move.l	d0,$26(a0)
	movem.l	(a7)+,d2/a2/a6
	rts

	SECTION "lockData__Surface__T:0",CODE


;void* Surface::lockData()
	XDEF	lockData__Surface__T
lockData__Surface__T
L138	EQU	-$10
	link	a5,#L138
	movem.l	a2/a3/a6,-(a7)
	move.l	$8(a5),a3
L133
;	if (bitMap)
	move.l	a3,a1
	tst.l	$E(a1)
	beq.b	L137
L134
;		if (lockAddr)
	move.l	a3,a1
	tst.l	$16(a1)
	beq.b	L136
L135
;			return gfxAddr;
	move.l	a3,a0
	move.l	$12(a0),d0
	movem.l	(a7)+,a2/a3/a6
	unlk	a5
	rts
L136
;		TagItem t[2] = {
	lea	-$10(a5),a0
	move.l	#$84001007,(a0)+
	lea	$12(a3),a1
	move.l	a1,(a0)+
	clr.l	(a0)+
	clr.l	(a0)
;		lockAddr = LockBitMapTagList(bitMap, t);
	move.l	a3,a2
	move.l	_CyberGfxBase,a6
	move.l	$E(a2),a0
	lea	-$10(a5),a1
	jsr	-$A8(a6)
	move.l	a3,a1
	move.l	d0,$16(a1)
;		return gfxAddr;
	move.l	a3,a0
	move.l	$12(a0),d0
	movem.l	(a7)+,a2/a3/a6
	unlk	a5
	rts
L137
;		return 0;
	moveq	#0,d0
	movem.l	(a7)+,a2/a3/a6
	unlk	a5
	rts

	SECTION "unlockData__Surface__T:0",CODE


;void Surface::unlockData()
	XDEF	unlockData__Surface__T
unlockData__Surface__T
	movem.l	a2/a6,-(a7)
	move.l	$C(a7),a2
L139
;	if (bitMap && lockAddr)
	move.l	a2,a1
	tst.l	$E(a1)
	beq.b	L142
L140
	move.l	a2,a1
	tst.l	$16(a1)
	beq.b	L142
L141
;		UnLockBitMap(lockAddr);
	move.l	a2,a1
	move.l	_CyberGfxBase,a6
	move.l	$16(a1),a0
	jsr	-$AE(a6)
;		lockAddr = 0;
	move.l	a2,a1
	clr.l	$16(a1)
L142
	movem.l	(a7)+,a2/a6
	rts

	SECTION "create__Surface__ssP07Surface:0",CODE


;Surface* Surface::create(S_WH, Surface* clone)
	XDEF	create__Surface__ssP07Surface
create__Surface__ssP07Surface
	movem.l	d2/d3/a2/a3,-(a7)
	move.w	$14(a7),d2
	move.w	$16(a7),d3
	move.l	$18(a7),a3
L143
;	if (!clone || !clone->bitMap)
	cmp.w	#0,a3
	beq.b	L145
L144
	move.l	a3,a1
	tst.l	$E(a1)
	bne.b	L146
L145
;		return 0;
	moveq	#0,d0
	movem.l	(a7)+,d2/d3/a2/a3
	rts
L146
;	Surface* newSurf = new Surface;
	pea	$2A.w
	jsr	op__new__Ui
	move.l	d0,a2
	addq.w	#4,a7
	cmp.w	#0,a2
	beq.b	L148
L147
	move.l	a2,a0
	lea	$2A(a0),a1
	move.l	a1,4(a0)
	move.b	#1,$8(a0)
	clr.w	(a0)
	clr.w	2(a0)
	move.l	a0,-(a7)
	jsr	init__Surface__T
	addq.w	#4,a7
L148
;	if (newSurf && newSurf->create(w, h, clone->bitMap)==OK)
	cmp.w	#0,a2
	beq.b	L151
L149
	move.l	a3,a1
	move.l	$E(a1),-(a7)
	move.w	d3,-(a7)
	move.w	d2,-(a7)
	move.l	a2,-(a7)
	jsr	create__Surface__TssP06BitMap
	add.w	#$C,a7
	tst.l	d0
	bne.b	L151
L150
;		return newSurf;
	move.l	a2,d0
	movem.l	(a7)+,d2/d3/a2/a3
	rts
L151
;	delete newSurf;
	cmp.w	#0,a2
	beq.b	L153
L152
	move.l	a2,-(a7)
	jsr	destroy__Surface__T
	addq.w	#4,a7
	pea	$2A.w
	move.l	a2,-(a7)
	jsr	op__delete__PvUi
	addq.w	#$8,a7
L153
;	return 0;
	moveq	#0,d0
	movem.l	(a7)+,d2/d3/a2/a3
	rts

	SECTION "create__Surface__TssP06BitMap:0",CODE


;sint32 Surface::create(sint16 w, sint16 h, BitMap* clone)
	XDEF	create__Surface__TssP06BitMap
create__Surface__TssP06BitMap
	movem.l	d2-d5/a2/a3/a6,-(a7)
	move.w	$26(a7),d4
	move.w	$24(a7),d5
	move.l	$20(a7),a2
	move.l	$28(a7),a3
L156
;	if (bitMap)
	move.l	a2,a1
	tst.l	$E(a1)
	beq.b	L158
L157
;		return ERR_RSC_LOCKED;
	move.l	#-$3050004,d0
	movem.l	(a7)+,d2-d5/a2/a3/a6
	rts
L158
;	if (w <=0 || h <= 0)
	cmp.w	#0,d5
	ble.b	L160
L159
	cmp.w	#0,d4
	bgt.b	L161
L160
;		return ERR_VALUE;
	move.l	#-$3010000,d0
	movem.l	(a7)+,d2-d5/a2/a3/a6
	rts
L161
;	if (!clone)
	cmp.w	#0,a3
	bne.b	L163
L162
;		return ERR_PTR_ZERO;
	move.l	#-$3020002,d0
	movem.l	(a7)+,d2-d5/a2/a3/a6
	rts
L163
;	if (!GetCyberMapAttr(clone, CYBRMATTR_ISCYBERGFX))
	move.l	_CyberGfxBase,a6
	move.l	#$80000008,d0
	move.l	a3,a0
	jsr	-$60(a6)
	tst.l	d0
	bne.b	L165
L164
;		return ERR_RSC_INVALID;
	move.l	#-$3050008,d0
	movem.l	(a7)+,d2-d5/a2/a3/a6
	rts
L165
;	uint32 bmf = BMF_MINPLANES | BMF_DISPLAYABLE;
	moveq	#$12,d3
;	if (GetCyberMapAttr(clone, CYBRMATTR_DEPTH)<=8)
	move.l	_CyberGfxBase,a6
	move.l	#$80000007,d0
	move.l	a3,a0
	jsr	-$60(a6)
	cmp.l	#$8,d0
	bhi.b	L167
L166
;		bitMap = AllocBitMap(w, h, 8, bmf, clone);
	move.w	d4,d1
	ext.l	d1
	move.w	d5,d0
	ext.l	d0
	move.l	_GfxBase,a6
	moveq	#$8,d2
	move.l	a3,a0
	jsr	-$396(a6)
	move.l	a2,a1
	move.l	d0,$E(a1)
	bra.b	L168
L167
;		bitMap = AllocBitMap(w, h, BIZZARE_PLANES_FIX, bmf, clone);
	move.w	d4,d1
	ext.l	d1
	move.w	d5,d0
	ext.l	d0
	move.l	_GfxBase,a6
	moveq	#$9,d2
	move.l	a3,a0
	jsr	-$396(a6)
	move.l	a2,a1
	move.l	d0,$E(a1)
L168
;	if (!bitMap)
	move.l	a2,a1
	tst.l	$E(a1)
	bne.b	L170
L169
;face::create(S_WH
	pea	2.w
	move.l	#L154,-(a7)
	jsr	printDebug__SystemLib__PCci
	addq.w	#$8,a7
;		return ERR_NO_FREE_STORE;
	move.l	#-$3030001,d0
	movem.l	(a7)+,d2-d5/a2/a3/a6
	rts
L170
;	else if (!GetCyberMapAttr(bitMap, CYBRMATTR_ISCYBERGFX))
	move.l	a2,a1
	move.l	_CyberGfxBase,a6
	move.l	#$80000008,d0
	move.l	$E(a1),a0
	jsr	-$60(a6)
	tst.l	d0
	bne.b	L172
L171
;"Surface::create(
	pea	2.w
	move.l	#L155,-(a7)
	jsr	printDebug__SystemLib__PCci
	addq.w	#$8,a7
;		FreeBitMap(bitMap);
	move.l	a2,a1
	move.l	_GfxBase,a6
	move.l	$E(a1),a0
	jsr	-$39C(a6)
;		init();
	move.l	a2,-(a7)
	jsr	init__Surface__T
	addq.w	#4,a7
;		return ERR_RSC_INVALID;
	move.l	#-$3050008,d0
	movem.l	(a7)+,d2-d5/a2/a3/a6
	rts
L172
;	width		= w;
	move.l	a2,a0
	move.w	d5,(a0)
;	height	= h;
	move.l	a2,a0
	move.w	d4,2(a0)
;	queryBitMap();
	move.l	a2,-(a7)
	jsr	queryBitMap__Surface__T
	addq.w	#4,a7
;	properties |= OWNBITMAP;
	move.l	a2,a0
	move.l	$1A(a0),d0
	or.l	#1,d0
	move.l	a2,a0
	move.l	d0,$1A(a0)
;	return OK;
	moveq	#0,d0
	movem.l	(a7)+,d2-d5/a2/a3/a6
	rts

L154
	dc.b	'Surface::create(S_WH, BitMap*) : AllocBitmap() failed',0
L155
	dc.b	'Surface::create(S_WH, BitMap*) : not a CGX bitmap',0

	SECTION "destroy__Surface__T:0",CODE


;void Surface::destroy()
	XDEF	destroy__Surface__T
destroy__Surface__T
	movem.l	a2/a6,-(a7)
	move.l	$C(a7),a2
L173
;	if (bitMap)
	move.l	a2,a1
	tst.l	$E(a1)
	beq.b	L178
L174
;		if (lockAddr)
	move.l	a2,a1
	tst.l	$16(a1)
	beq.b	L176
L175
;			UnLockBitMap(lockAddr);
	move.l	a2,a1
	move.l	_CyberGfxBase,a6
	move.l	$16(a1),a0
	jsr	-$AE(a6)
L176
;		if (properties & OWNBITMAP)
	move.l	a2,a0
	move.l	$1A(a0),d0
	and.l	#1,d0
	beq.b	L178
L177
;			FreeBitMap(bitMap);
	move.l	a2,a1
	move.l	_GfxBase,a6
	move.l	$E(a1),a0
	jsr	-$39C(a6)
L178
;	init();
	move.l	a2,-(a7)
	jsr	init__Surface__T
	addq.w	#4,a7
	movem.l	(a7)+,a2/a6
	rts

	SECTION "clear__Surface__TR06Colour:0",CODE


;void Surface::clear(Colour& c)
	XDEF	clear__Surface__TR06Colour
clear__Surface__TR06Colour
L182	EQU	-$78
	link	a5,#L182
	movem.l	d2-d4/a2/a3/a6,-(a7)
	movem.l	$8(a5),a2/a3
L179
;	if (winUser)
	move.l	a2,a1
	tst.l	$A(a1)
	beq	L181
L180
;		InitRastPort(&rPort);
	move.l	_GfxBase,a6
	lea	-$64(a5),a1
	jsr	-$C6(a6)
;		rPort.BitMap = bitMap;
	move.l	a2,a1
	move.l	$E(a1),-$60(a5)
;		ViewPort*	view = &(winUser->WScreen->ViewPort);
	move.l	a2,a1
	move.l	$A(a1),a0
	moveq	#$2C,d0
	add.l	$2E(a0),d0
	move.l	d0,-$68(a5)
;		uint32 pen = ObtainBestPen(view->ColorMap, c.red()<<24, c.green()
	move.l	#-1,-(a7)
	move.l	#$84000000,-(a7)
	moveq	#0,d3
	move.b	3(a3),d3
	moveq	#$18,d0
	asl.l	d0,d3
	moveq	#0,d2
	move.b	2(a3),d2
	moveq	#$18,d0
	asl.l	d0,d2
	moveq	#0,d1
	move.b	1(a3),d1
	moveq	#$18,d0
	asl.l	d0,d1
	move.l	-$68(a5),a1
	move.l	4(a1),a0
	move.l	_GfxBase,a6
	move.l	a7,a1
	jsr	-$348(a6)
	addq.w	#$8,a7
	move.l	d0,d4
;		SetAPen(&rPort, pen);
	move.l	_GfxBase,a6
	move.l	d4,d0
	lea	-$64(a5),a1
	jsr	-$156(a6)
;		RectFill(&rPort, 0, 0, width-1, height-1);
	move.l	a2,a0
	move.w	2(a0),d3
	ext.l	d3
	subq.l	#1,d3
	move.l	a2,a0
	move.w	(a0),d2
	ext.l	d2
	subq.l	#1,d2
	move.l	_GfxBase,a6
	moveq	#0,d0
	moveq	#0,d1
	lea	-$64(a5),a1
	jsr	-$132(a6)
;		ReleasePen(view->ColorMap, pen);
	move.l	-$68(a5),a1
	move.l	_GfxBase,a6
	move.l	d4,d0
	move.l	4(a1),a0
	jsr	-$3B4(a6)
L181
	movem.l	(a7)+,d2-d4/a2/a3/a6
	unlk	a5
	rts

	SECTION "assignSurface__SurfaceProvider__P07SurfaceP06BitMap:0",CODE


;bool SurfaceProvider::assignSurface(Surface* srf, BitMap* bmp)
	XDEF	assignSurface__SurfaceProvider__P07SurfaceP06BitMap
assignSurface__SurfaceProvider__P07SurfaceP06BitMap
	movem.l	a2/a3/a6,-(a7)
	movem.l	$10(a7),a2/a3
L183
;	if ((!srf) || (!bmp) || (srf->bitMap) ||
	cmp.w	#0,a2
	beq.b	L187
L184
	cmp.w	#0,a3
	beq.b	L187
L185
	move.l	a2,a1
	tst.l	$E(a1)
	bne.b	L187
L186
	move.l	_CyberGfxBase,a6
	move.l	#$80000008,d0
	move.l	a3,a0
	jsr	-$60(a6)
	tst.l	d0
	bne.b	L188
L187
;		return false;
	moveq	#0,d0
	movem.l	(a7)+,a2/a3/a6
	rts
L188
;	srf->bitMap = bmp;
	move.l	a2,a1
	move.l	a3,$E(a1)
;	srf->width				= GetCyberMapAttr(bmp, CYBRMATTR_WIDTH);
	move.l	_CyberGfxBase,a6
	move.l	#$80000005,d0
	move.l	a3,a0
	jsr	-$60(a6)
	move.l	a2,a0
	move.w	d0,(a0)
;	srf->height				= GetCyberMapAttr(bmp, CYBRMATTR_HEIGHT);
	move.l	_CyberGfxBase,a6
	move.l	#$80000006,d0
	move.l	a3,a0
	jsr	-$60(a6)
	move.l	a2,a0
	move.w	d0,2(a0)
;	srf->queryBitMap();
	move.l	a2,-(a7)
	jsr	queryBitMap__Surface__T
	addq.w	#4,a7
;	srf->properties		&= ~Surface::OWNBITMAP;
	move.l	a2,a0
	move.l	$1A(a0),d0
	and.l	#-2,d0
	move.l	a2,a0
	move.l	d0,$1A(a0)
;	srf->properties		|= Surface::EXTBITMAP;
	move.l	a2,a0
	move.l	$1A(a0),d0
	or.l	#2,d0
	move.l	a2,a0
	move.l	d0,$1A(a0)
;	return true;
	moveq	#1,d0
	movem.l	(a7)+,a2/a3/a6
	rts

	SECTION "assignNewSurface__SurfaceProvider__P06BitMap:0",CODE


;Surface* SurfaceProvider::assignNewSurface(BitMap* bmp)
	XDEF	assignNewSurface__SurfaceProvider__P06BitMap
assignNewSurface__SurfaceProvider__P06BitMap
	movem.l	a2/a6,-(a7)
	move.l	$C(a7),a2
L189
;	if ((!bmp) || (!GetCyberMapAttr(bmp, CYBRMATTR_ISCYBERGFX)))
	cmp.w	#0,a2
	beq.b	L191
L190
	move.l	_CyberGfxBase,a6
	move.l	#$80000008,d0
	move.l	a2,a0
	jsr	-$60(a6)
	tst.l	d0
	bne.b	L192
L191
;		return 0;
	moveq	#0,d0
	movem.l	(a7)+,a2/a6
	rts
L192
;	Surface* t = new Surface;
	pea	$2A.w
	jsr	op__new__Ui
	move.l	d0,a6
	addq.w	#4,a7
	cmp.w	#0,a6
	beq.b	L194
L193
	move.l	a6,a0
	lea	$2A(a0),a1
	move.l	a1,4(a0)
	move.b	#1,$8(a0)
	clr.w	(a0)
	clr.w	2(a0)
	move.l	a0,-(a7)
	jsr	init__Surface__T
	addq.w	#4,a7
L194
;	if (t)
	cmp.w	#0,a6
	beq.b	L196
L195
;		assignSurface(t, bmp);
	move.l	a2,-(a7)
	move.l	a6,-(a7)
	jsr	assignSurface__SurfaceProvider__P07SurfaceP06BitMap
	addq.w	#$8,a7
L196
;	return t;
	move.l	a6,d0
	movem.l	(a7)+,a2/a6
	rts

	SECTION "createSurface__SurfaceProvider__P06BitMapss:0",CODE


;Surface* SurfaceProvider::createSurface(BitMap* bmp, S_WH)
	XDEF	createSurface__SurfaceProvider__P06BitMapss
createSurface__SurfaceProvider__P06BitMapss
	movem.l	d2/d3/a2/a6,-(a7)
	move.w	$18(a7),d2
	move.w	$1A(a7),d3
	move.l	$14(a7),a2
L197
;	if ((!bmp) || (!GetCyberMapAttr(bmp, CYBRMATTR_ISCYBERGFX)))
	cmp.w	#0,a2
	beq.b	L199
L198
	move.l	_CyberGfxBase,a6
	move.l	#$80000008,d0
	move.l	a2,a0
	jsr	-$60(a6)
	tst.l	d0
	bne.b	L200
L199
;		return 0;
	moveq	#0,d0
	movem.l	(a7)+,d2/d3/a2/a6
	rts
L200
;	Surface* t = new Surface;
	pea	$2A.w
	jsr	op__new__Ui
	move.l	d0,a6
	addq.w	#4,a7
	cmp.w	#0,a6
	beq.b	L202
L201
	move.l	a6,a0
	lea	$2A(a0),a1
	move.l	a1,4(a0)
	move.b	#1,$8(a0)
	clr.w	(a0)
	clr.w	2(a0)
	move.l	a0,-(a7)
	jsr	init__Surface__T
	addq.w	#4,a7
L202
;	if (t)
	cmp.w	#0,a6
	beq.b	L207
L203
;		if (t->create(w, h, bmp)==OK)
	move.l	a2,-(a7)
	move.w	d3,-(a7)
	move.w	d2,-(a7)
	move.l	a6,-(a7)
	jsr	create__Surface__TssP06BitMap
	add.w	#$C,a7
	tst.l	d0
	bne.b	L205
L204
;			return t;
	move.l	a6,d0
	movem.l	(a7)+,d2/d3/a2/a6
	rts
L205
;			delete t;
	cmp.w	#0,a6
	beq.b	L207
L206
	move.l	a6,-(a7)
	jsr	destroy__Surface__T
	addq.w	#4,a7
	pea	$2A.w
	move.l	a6,-(a7)
	jsr	op__delete__PvUi
	addq.w	#$8,a7
L207
;	return 0;
	moveq	#0,d0
	movem.l	(a7)+,d2/d3/a2/a6
	rts

	END
