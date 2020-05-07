
; Storm C Compiler
; EXNG:libsrc/plat/amigaos3_68k/gfxlib/display.cpp
	mc68030
	mc68881
	XREF	_strcpy
	XREF	_strncpy
	XREF	getDrawSurface__Display__T
	XREF	setTitle__Display__TPCc
	XREF	refresh__Display__Tssss
	XREF	refresh__Display__T
	XREF	waitSync__Display__T
	XREF	close__Display__T
	XREF	reopen__Display__T
	XREF	open__Display__TP17DisplayPropertiesPCc
	XREF	open__Display__TssEPCc
	XREF	createSurface__SurfaceProvider__P06BitMapss
	XREF	assignNewSurface__SurfaceProvider__P06BitMap
	XREF	blitCopy__Surface__P07SurfacessP07Surfacessss
	XREF	destroy__Surface__T
	XREF	init__Surface__T
	XREF	getHardwareFormat__Native2D__E
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

	SECTION "_modeID__DisplayNative:1",DATA

	XDEF	_modeID__DisplayNative
_modeID__DisplayNative
	dc.l	0

	SECTION "_0ct__DisplayNative__T:0",CODE


;DisplayNative::DisplayNative() 
	XDEF	_0ct__DisplayNative__T
_0ct__DisplayNative__T
	move.l	4(a7),a0
L85
	clr.l	(a0)
	clr.l	4(a0)
	move.w	#-1,$8(a0)
	move.w	#-1,$A(a0)
	clr.l	$C(a0)
;	strcpy(name, "Untitled Window");
	move.l	#L84,-(a7)
	pea	$10(a0)
	jsr	_strcpy
	addq.w	#$8,a7
	rts

L84
	dc.b	'Untitled Window',0

	SECTION "waitForRefresh__DisplayNative__T:0",CODE


;void DisplayNative::waitForRefresh()
	XDEF	waitForRefresh__DisplayNative__T
waitForRefresh__DisplayNative__T
	move.l	a6,-(a7)
	move.l	$8(a7),a1
L86
;	if (scr)
	tst.l	(a1)
	beq.b	L88
L87
;		WaitBOVP(&(scr->ViewPort));
	move.l	(a1),a0
	move.l	_GfxBase,a6
	lea	$2C(a0),a0
	jsr	-$192(a6)
L88
	move.l	(a7)+,a6
	rts

	SECTION "openFullScreen__DisplayNative__TUj:0",CODE


;sint32 DisplayNative::openFullScreen(uint32 ID)
	XDEF	openFullScreen__DisplayNative__TUj
openFullScreen__DisplayNative__TUj
	movem.l	a2/a6,-(a7)
	move.l	$10(a7),d0
	move.l	$C(a7),a2
L91
;	if (scr)
	move.l	a2,a1
	tst.l	(a1)
	beq.b	L93
L92
;		return ERR_RSC_LOCKED;
	move.l	#-$3050004,d0
	movem.l	(a7)+,a2/a6
	rts
L93
;	if (!(scr = OpenScreenTags(0,
	clr.l	-(a7)
	pea	$10(a2)
	move.l	#$80000028,-(a7)
	pea	1.w
	move.l	#$80000040,-(a7)
	clr.l	-(a7)
	move.l	#$8000003E,-(a7)
	clr.l	-(a7)
	move.l	#$80000036,-(a7)
	move.l	d0,-(a7)
	move.l	#$80000032,-(a7)
	pea	$8.w
	move.l	#$80000025,-(a7)
	move.l	_IntuitionBase,a6
	sub.l	a0,a0
	move.l	a7,a1
	jsr	-$264(a6)
	add.w	#$34,a7
	move.l	a2,a1
	move.l	d0,(a1)
	bne.b	L95
L94
;Native::openFullS
	pea	2.w
	move.l	#L89,-(a7)
	jsr	printDebug__SystemLib__PCci
	addq.w	#$8,a7
;		goto 
	bra	L98
L95
;	if (depth > scrD)
	clr.l	-(a7)
	move.l	#$11B00,-(a7)
	move.l	#$8000006B,-(a7)
	clr.l	-(a7)
	move.l	#$8000006E,-(a7)
	clr.l	-(a7)
	move.l	#$80000065,-(a7)
	clr.l	-(a7)
	move.l	#$80000064,-(a7)
	move.l	a2,a0
	move.w	$A(a0),d0
	ext.l	d0
	move.l	d0,-(a7)
	move.l	#$80000067,-(a7)
	move.l	a2,a0
	move.w	$8(a0),d0
	ext.l	d0
	move.l	d0,-(a7)
	move.l	#$80000066,-(a7)
	move.l	a2,a1
	move.l	(a1),-(a7)
	move.l	#$80000070,-(a7)
	move.l	_IntuitionBase,a6
	sub.l	a0,a0
	move.l	a7,a1
	jsr	-$25E(a6)
	add.w	#$3C,a7
	move.l	a2,a1
	move.l	d0,4(a1)
	bne.b	L97
L96
;Native::openFullS
	pea	2.w
	move.l	#L90,-(a7)
	jsr	printDebug__SystemLib__PCci
	addq.w	#$8,a7
;		goto 
	bra.b	L98
L97
;	return OK;
	moveq	#0,d0
	movem.l	(a7)+,a2/a6
	rts
L98
;	closeFullScreen();
	move.l	a2,-(a7)
	jsr	closeFullScreen__DisplayNative__T
	addq.w	#4,a7
;	return ERR_RSC_UNAVAILABLE;
	move.l	#-$3050005,d0
	movem.l	(a7)+,a2/a6
	rts

L89
	dc.b	'DisplayNative::openFullScreen() : failed to create screen',0
L90
	dc.b	'DisplayNative::openFullScreen() : failed to create window',0

	SECTION "closeFullScreen__DisplayNative__T:0",CODE


;void DisplayNative::closeFullScreen()
	XDEF	closeFullScreen__DisplayNative__T
closeFullScreen__DisplayNative__T
	movem.l	a2/a6,-(a7)
	move.l	$C(a7),a2
L99
;	if (scr)
	move.l	a2,a1
	tst.l	(a1)
	beq.b	L103
L100
;		if (win)
	move.l	a2,a1
	tst.l	4(a1)
	beq.b	L102
L101
;			CloseWindow(win);
	move.l	a2,a1
	move.l	_IntuitionBase,a6
	move.l	4(a1),a0
	jsr	-$48(a6)
;			win = 0;
	move.l	a2,a1
	clr.l	4(a1)
L102
;		CloseScreen(scr);
	move.l	a2,a1
	move.l	_IntuitionBase,a6
	move.l	(a1),a0
	jsr	-$42(a6)
;		scr = 0;
	move.l	a2,a1
	clr.l	(a1)
L103
	movem.l	(a7)+,a2/a6
	rts

	SECTION "setDisplayTitle__DisplayNative__TPCcs:0",CODE


;void DisplayNative::setDisplayTitle(const char* title, bool scrTitle)
	XDEF	setDisplayTitle__DisplayNative__TPCcs
setDisplayTitle__DisplayNative__TPCcs
	movem.l	d2/a2/a3/a6,-(a7)
	move.w	$1C(a7),d2
	move.l	$18(a7),a0
	move.l	$14(a7),a3
L104
;	if (title)
	cmp.w	#0,a0
	beq.b	L106
L105
;		strncpy(name, title, 63);
	pea	$3F.w
	move.l	a0,-(a7)
	pea	$10(a3)
	jsr	_strncpy
	add.w	#$C,a7
L106
;	if (scrTitle && scr!=0)
	tst.w	d2
	beq.b	L109
L107
	move.l	a3,a1
	move.l	(a1),a0
	cmp.w	#0,a0
	beq.b	L109
L108
;		SetWindowTitles(win, (uint8*)(-1), (uint8*)name);
	move.l	a3,a1
	move.l	4(a1),a0
	move.l	_IntuitionBase,a6
	move.w	#-1,a1
	lea	$10(a3),a2
	jsr	-$114(a6)
	bra.b	L111
L109
;	else if (win!=0)
	move.l	a3,a1
	move.l	4(a1),a0
	cmp.w	#0,a0
	beq.b	L111
L110
;		SetWindowTitles(win, (uint8*)name, (uint8*)(-1));
	move.l	a3,a2
	move.l	4(a2),a0
	move.l	_IntuitionBase,a6
	lea	$10(a3),a1
	move.w	#-1,a2
	jsr	-$114(a6)
L111
	movem.l	(a7)+,d2/a2/a3/a6
	rts

	SECTION "_0ct__NativeWindow__T:0",CODE


;NativeWindow::NativeWindow() 
	XDEF	_0ct__NativeWindow__T
_0ct__NativeWindow__T
	move.l	a2,-(a7)
	move.l	$8(a7),a2
L112
	move.l	a2,-(a7)
	jsr	_0ct__DisplayNative__T
	addq.w	#4,a7
	clr.l	$50(a2)
	clr.l	$54(a2)
	clr.w	$58(a2)
	clr.w	$5A(a2)
	move.l	(a7)+,a2
	rts

	SECTION "_0dt__NativeWindow__T:0",CODE


;NativeWindow::~NativeWindow()
	XDEF	_0dt__NativeWindow__T
_0dt__NativeWindow__T
	move.l	4(a7),a0
L113
;	closeWindow();
	move.l	a0,-(a7)
	jsr	closeWindow__NativeWindow__T
	addq.w	#4,a7
	rts

	SECTION "openWindow__NativeWindow__Tss:0",CODE


;sint32 NativeWindow::openWindow(bool cX, bool cY)
	XDEF	openWindow__NativeWindow__Tss
openWindow__NativeWindow__Tss
	movem.l	d2-d5/a2/a3/a6,-(a7)
	move.w	$26(a7),d4
	move.w	$24(a7),d5
	move.l	$20(a7),a3
L122
;	if (!(scr =  LockPubScreen(0)))
	move.l	_IntuitionBase,a6
	sub.l	a0,a0
	jsr	-$1FE(a6)
	move.l	a3,a1
	move.l	d0,(a1)
	bne.b	L124
L123
;NativeWindow::ope
	pea	2.w
	move.l	#L114,-(a7)
	jsr	printDebug__SystemLib__PCci
	addq.w	#$8,a7
;		return ERR_RSC_UNAVAILABLE;
	move.l	#-$3050005,d0
	movem.l	(a7)+,d2-d5/a2/a3/a6
	rts
L124
;	if (GetCyberMapAttr(scr->RastPort.BitMap, CYBRMATTR_ISCYBERGFX)==f
	move.l	a3,a1
	move.l	(a1),a0
	move.l	_CyberGfxBase,a6
	move.l	#$80000008,d0
	move.l	$58(a0),a0
	jsr	-$60(a6)
	tst.l	d0
	bne.b	L126
L125
;		UnlockPubScreen(0, scr);
	move.l	a3,a0
	move.l	(a0),a1
	move.l	_IntuitionBase,a6
	sub.l	a0,a0
	jsr	-$204(a6)
;NativeWindow::ope
	pea	2.w
	move.l	#L115,-(a7)
	jsr	printDebug__SystemLib__PCci
	addq.w	#$8,a7
;		scr = 0;
	move.l	a3,a1
	clr.l	(a1)
;		return ERR_RSC_INVALID;
	move.l	#-$3050008,d0
	movem.l	(a7)+,d2-d5/a2/a3/a6
	rts
L126
;	sint32 scrW = GetCyberMapAttr(scr->RastPort.BitMap, CYBRMATTR_WIDT
	move.l	a3,a1
	move.l	(a1),a0
	move.l	_CyberGfxBase,a6
	move.l	#$80000005,d0
	move.l	$58(a0),a0
	jsr	-$60(a6)
	move.l	d0,d3
;	if (width > scrW)
	move.l	a3,a0
	move.w	$8(a0),d0
	ext.l	d0
	cmp.l	d3,d0
	ble.b	L128
L127
;		UnlockPubScreen(0, scr);
	move.l	a3,a0
	move.l	(a0),a1
	move.l	_IntuitionBase,a6
	sub.l	a0,a0
	jsr	-$204(a6)
;"NativeWindow::op
	pea	2.w
	move.l	#L116,-(a7)
	jsr	printDebug__SystemLib__PCci
	addq.w	#$8,a7
;		return ERR_VALUE_RANGE;
	move.l	#-$3010005,d0
	movem.l	(a7)+,d2-d5/a2/a3/a6
	rts
L128
;	sint32 scrH = GetCyberMapAttr(scr->RastPort.BitMap, CYBRMATTR_HEIG
	move.l	a3,a1
	move.l	(a1),a0
	move.l	_CyberGfxBase,a6
	move.l	#$80000006,d0
	move.l	$58(a0),a0
	jsr	-$60(a6)
	move.l	d0,d2
;	if (height > scrH)
	move.l	a3,a0
	move.w	$A(a0),d0
	ext.l	d0
	cmp.l	d2,d0
	ble.b	L130
L129
;		UnlockPubScreen(0, scr);
	move.l	a3,a0
	move.l	(a0),a1
	move.l	_IntuitionBase,a6
	sub.l	a0,a0
	jsr	-$204(a6)
;NativeWindow::ope
	pea	2.w
	move.l	#L117,-(a7)
	jsr	printDebug__SystemLib__PCci
	addq.w	#$8,a7
;		return ERR_VALUE_RANGE;
	move.l	#-$3010005,d0
	movem.l	(a7)+,d2-d5/a2/a3/a6
	rts
L130
;	sint32 scrD = GetCyberMapAttr(scr->RastPort.BitMap, CYBRMATTR_DEPT
	move.l	a3,a1
	move.l	(a1),a0
	move.l	_CyberGfxBase,a6
	move.l	#$80000007,d0
	move.l	$58(a0),a0
	jsr	-$60(a6)
;	if (depth > scrD)
	move.l	a3,a0
	move.l	$C(a0),d1
	cmp.l	d0,d1
	ble.b	L132
L131
;		UnlockPubScreen(0, scr);
	move.l	a3,a0
	move.l	(a0),a1
	move.l	_IntuitionBase,a6
	sub.l	a0,a0
	jsr	-$204(a6)
;"NativeWindow::op
	pea	2.w
	move.l	#L118,-(a7)
	jsr	printDebug__SystemLib__PCci
	addq.w	#$8,a7
;		return ERR_VALUE_RANGE;
	move.l	#-$3010005,d0
	movem.l	(a7)+,d2-d5/a2/a3/a6
	rts
L132
;		// Since coords can be nega
	tst.w	d5
	beq.b	L134
L133
;		left = (scrW - width)>>1;
	move.l	a3,a0
	move.w	$8(a0),d0
	ext.l	d0
	sub.l	d0,d3
	moveq	#1,d0
	asr.l	d0,d3
	move.l	a3,a0
	move.w	d3,$5A(a0)
	bra.b	L141
L134
;		left = Clamp::integer(left, 0, scrW-width);
	move.l	a3,a0
	move.w	$8(a0),d0
	ext.l	d0
	sub.l	d0,d3
	moveq	#0,d1
	move.l	a3,a0
	move.w	$5A(a0),d0
	ext.l	d0
	cmp.l	d1,d0
	bge.b	L136
L135
	move.l	d1,d0
	bra.b	L140
L136
	cmp.l	d3,d0
	ble.b	L138
L137
	move.l	d3,d0
L138
L139
L140
	move.l	a3,a0
	move.w	d0,$5A(a0)
L141
;	if (cY)
	tst.w	d4
	beq.b	L143
L142
;		top = (scrH - height)>>1;
	move.l	a3,a0
	move.w	$A(a0),d0
	ext.l	d0
	sub.l	d0,d2
	moveq	#1,d0
	asr.l	d0,d2
	move.l	a3,a0
	move.w	d2,$58(a0)
	bra.b	L150
L143
;		top = Clamp::integer(top, 0, scrH-height);
	move.l	a3,a0
	move.w	$A(a0),d0
	ext.l	d0
	sub.l	d0,d2
	moveq	#0,d1
	move.l	a3,a0
	move.w	$58(a0),d0
	ext.l	d0
	cmp.l	d1,d0
	bge.b	L145
L144
	move.l	d1,d0
	bra.b	L149
L145
	cmp.l	d2,d0
	ble.b	L147
L146
	move.l	d2,d0
L147
L148
L149
	move.l	a3,a0
	move.w	d0,$58(a0)
L150
;	if (!(rast = new RastPort))
	pea	$64.w
	jsr	op__new__Ui
	addq.w	#4,a7
	move.l	a3,a1
	move.l	d0,$50(a1)
	bne.b	L152
L151
;		UnlockPubScreen(0, scr);
	move.l	a3,a0
	move.l	(a0),a1
	move.l	_IntuitionBase,a6
	sub.l	a0,a0
	jsr	-$204(a6)
;iveWindow::openWi
	pea	2.w
	move.l	#L119,-(a7)
	jsr	printDebug__SystemLib__PCci
	addq.w	#$8,a7
;		return ERR_RSC_UNAVAILABLE;
	move.l	#-$3050005,d0
	movem.l	(a7)+,d2-d5/a2/a3/a6
	rts
L152
;		InitRastPort(rast);
	move.l	a3,a0
	move.l	_GfxBase,a6
	move.l	$50(a0),a1
	jsr	-$C6(a6)
;	win = OpenWindowTags(0,
	clr.l	-(a7)
	move.l	#$11202,-(a7)
	move.l	#$8000006B,-(a7)
	pea	1.w
	move.l	#$80000083,-(a7)
	pea	$10(a3)
	move.l	#$8000006E,-(a7)
	move.l	a3,a0
	move.w	$58(a0),d0
	ext.l	d0
	move.l	d0,-(a7)
	move.l	#$80000065,-(a7)
	move.l	a3,a0
	move.w	$5A(a0),d0
	ext.l	d0
	move.l	d0,-(a7)
	move.l	#$80000064,-(a7)
	move.l	a3,a0
	move.w	$A(a0),d0
	ext.l	d0
	move.l	d0,-(a7)
	move.l	#$80000077,-(a7)
	move.l	a3,a0
	move.w	$8(a0),d0
	ext.l	d0
	move.l	d0,-(a7)
	move.l	#$80000076,-(a7)
	move.l	a3,a1
	move.l	(a1),-(a7)
	move.l	#$80000079,-(a7)
	move.l	_IntuitionBase,a6
	sub.l	a0,a0
	move.l	a7,a1
	jsr	-$25E(a6)
	add.w	#$44,a7
	move.l	a3,a1
	move.l	d0,4(a1)
; 	UnlockPubScreen(0, scr);
	move.l	a3,a0
	move.l	(a0),a1
	move.l	_IntuitionBase,a6
	sub.l	a0,a0
	jsr	-$204(a6)
;	if (!win)
	move.l	a3,a1
	tst.l	4(a1)
	bne.b	L154
L153
;tiveWindow::openW
	pea	2.w
	move.l	#L120,-(a7)
	jsr	printDebug__SystemLib__PCci
	addq.w	#$8,a7
;		return ERR_RSC_UNAVAILABLE;
	move.l	#-$3050005,d0
	movem.l	(a7)+,d2-d5/a2/a3/a6
	rts
L154
;	if (!(drawSurface = createSurface(win->RPort->BitMap, width, heigh
	move.l	a3,a0
	move.w	$A(a0),-(a7)
	move.l	a3,a0
	move.w	$8(a0),-(a7)
	move.l	a3,a1
	move.l	4(a1),a0
	move.l	$32(a0),a0
	move.l	4(a0),-(a7)
	jsr	createSurface__SurfaceProvider__P06BitMapss
	addq.w	#$8,a7
	move.l	a3,a1
	move.l	d0,$54(a1)
	bne.b	L156
L155
;ndow::openWindow()
	pea	2.w
	move.l	#L121,-(a7)
	jsr	printDebug__SystemLib__PCci
	addq.w	#$8,a7
;		closeWindow();
	move.l	a3,-(a7)
	jsr	closeWindow__NativeWindow__T
	addq.w	#4,a7
;		return ERR_RSC;
	move.l	#-$3050000,d0
	movem.l	(a7)+,d2-d5/a2/a3/a6
	rts
L156
;	setWinUser(drawSurface, win);
	move.l	a3,a0
	move.l	4(a0),a1
	move.l	a3,a2
	move.l	$54(a2),a0
	move.l	a1,$A(a0)
;	rast->BitMap = getSurfaceRep(drawSurface);
	move.l	a3,a1
	move.l	$54(a1),a0
	move.l	$E(a0),a1
	move.l	a3,a2
	move.l	$50(a2),a0
	move.l	a1,4(a0)
;	return OK;
	moveq	#0,d0
	movem.l	(a7)+,d2-d5/a2/a3/a6
	rts

L120
	dc.b	'NativeWindow::openWindow() : OpenWindowTags() failed',0
L118
	dc.b	'NativeWindow::openWindow() : depth exceeds screen',0
L121
	dc.b	'NativeWindow::openWindow() : failed to create draw Surface',0
L117
	dc.b	'NativeWindow::openWindow() : height exceeds screen',0
L115
	dc.b	'NativeWindow::openWindow() : screen bitmap not cgx',0
L119
	dc.b	'NativeWindow::openWindow() : unable allocate RastPort',0
L114
	dc.b	'NativeWindow::openWindow() : unable to lock screen',0
L116
	dc.b	'NativeWindow::openWindow() : width exceeds screen',0

	SECTION "closeWindow__NativeWindow__T:0",CODE


;void NativeWindow::closeWindow()
	XDEF	closeWindow__NativeWindow__T
closeWindow__NativeWindow__T
	movem.l	a2/a6,-(a7)
	move.l	$C(a7),a2
L157
;	if (win)
	move.l	a2,a1
	tst.l	4(a1)
	beq	L159
L158
;		top = getWinY();
	move.l	4(a2),a0
	move.w	6(a0),d0
	move.l	a2,a0
	move.w	d0,$58(a0)
;		left = getWinX();
	move.l	4(a2),a0
	move.w	4(a0),d0
	move.l	a2,a0
	move.w	d0,$5A(a0)
;		width = getViewW();
	move.l	a2,a0
	move.l	4(a0),a1
	move.w	$8(a1),d0
	ext.l	d0
	move.l	4(a0),a1
	move.b	$36(a1),d1
	ext.w	d1
	ext.l	d1
	sub.l	d1,d0
	move.l	4(a0),a0
	move.b	$38(a0),d1
	ext.w	d1
	ext.l	d1
	sub.l	d1,d0
	move.l	a2,a0
	move.w	d0,$8(a0)
;	height = getViewH();
	move.l	a2,a0
	move.l	4(a0),a1
	move.w	$A(a1),d0
	ext.l	d0
	move.l	4(a0),a1
	move.b	$37(a1),d1
	ext.w	d1
	ext.l	d1
	sub.l	d1,d0
	move.l	4(a0),a0
	move.b	$39(a0),d1
	ext.w	d1
	ext.l	d1
	sub.l	d1,d0
	move.l	a2,a0
	move.w	d0,$A(a0)
;		CloseWindow(win);
	move.l	a2,a1
	move.l	_IntuitionBase,a6
	move.l	4(a1),a0
	jsr	-$48(a6)
L159
;	if (rast)
	move.l	a2,a1
	tst.l	$50(a1)
	beq.b	L162
L160
;		delete rast;
	move.l	a2,a1
	move.l	$50(a1),a0
	cmp.w	#0,a0
	beq.b	L162
L161
	pea	$64.w
	move.l	a0,-(a7)
	jsr	op__delete__PvUi
	addq.w	#$8,a7
L162
;	if (drawSurface)
	move.l	a2,a1
	tst.l	$54(a1)
	beq.b	L165
L163
;		delete drawSurface;
	move.l	a2,a0
	move.l	$54(a0),a6
	cmp.w	#0,a6
	beq.b	L165
L164
	move.l	a6,-(a7)
	jsr	destroy__Surface__T
	addq.w	#4,a7
	pea	$2A.w
	move.l	a6,-(a7)
	jsr	op__delete__PvUi
	addq.w	#$8,a7
L165
;	scr = 0;
	move.l	a2,a1
	clr.l	(a1)
;	win = 0;
	move.l	a2,a1
	clr.l	4(a1)
;	rast = 0;
	move.l	a2,a1
	clr.l	$50(a1)
;	drawSurface = 0;
	move.l	a2,a1
	clr.l	$54(a1)
	movem.l	(a7)+,a2/a6
	rts

	SECTION "reopen__NativeWindow__T:0",CODE


;sint32 NativeWindow::reopen()
	XDEF	reopen__NativeWindow__T
reopen__NativeWindow__T
	move.l	4(a7),a0
L167
;	if (width == -1 || height == -1)
	move.w	$8(a0),d0
	cmp.w	#-1,d0
	beq.b	L169
L168
	move.w	$A(a0),d0
	cmp.w	#-1,d0
	bne.b	L170
L169
;X_ERROR("NativeWi
	pea	2.w
	move.l	#L166,-(a7)
	jsr	printDebug__SystemLib__PCci
	addq.w	#$8,a7
;		return ERR_RSC_UNAVAILABLE;
	move.l	#-$3050005,d0
	rts
L170
;	return openWindow(false, false);
	clr.w	-(a7)
	clr.w	-(a7)
	move.l	a0,-(a7)
	jsr	openWindow__NativeWindow__Tss
	addq.w	#$8,a7
	rts

L166
	dc.b	'NativeWindow::reopen() : parameters unset',0

	SECTION "close__NativeWindow__T:0",CODE


;void NativeWindow::close()
	XDEF	close__NativeWindow__T
close__NativeWindow__T
	move.l	4(a7),a0
L171
;	closeWindow();
	move.l	a0,-(a7)
	jsr	closeWindow__NativeWindow__T
	addq.w	#4,a7
	rts

	SECTION "refresh__NativeWindow__T:0",CODE


;void NativeWindow::refresh()
	XDEF	refresh__NativeWindow__T
refresh__NativeWindow__T
	movem.l	d2-d6/a6,-(a7)
	move.l	$1C(a7),a0
L172
;	if (win)
	tst.l	4(a0)
	beq.b	L174
L173
;		ClipBlit(rast, 0, 0, win->RPort, win->BorderLeft, win->BorderTop
	move.w	$A(a0),d5
	ext.l	d5
	move.w	$8(a0),d4
	ext.l	d4
	move.l	4(a0),a1
	move.b	$37(a1),d3
	extb.l	d3
	move.l	4(a0),a1
	move.b	$36(a1),d2
	extb.l	d2
	move.l	4(a0),a1
	move.l	_GfxBase,a6
	moveq	#0,d0
	moveq	#0,d1
	move.l	#$C0,d6
	move.l	$50(a0),a0
	move.l	$32(a1),a1
	jsr	-$228(a6)
L174
	movem.l	(a7)+,d2-d6/a6
	rts

	SECTION "refresh__NativeWindow__Tssss:0",CODE


;void NativeWindow::refresh(S_XYWH)
	XDEF	refresh__NativeWindow__Tssss
refresh__NativeWindow__Tssss
	movem.l	d2-d6/a6,-(a7)
	move.w	$20(a7),d0
	move.w	$22(a7),d1
	move.w	$24(a7),d4
	move.w	$26(a7),d5
	move.l	$1C(a7),a0
L175
;	if (win)
	tst.l	4(a0)
	beq	L190
L176
;		if (x > width || y > height || (x+w) < 0 || (y+h) < 0)
	cmp.w	$8(a0),d0
	bgt.b	L180
L177
	cmp.w	$A(a0),d1
	bgt.b	L180
L178
	move.w	d0,d2
	ext.l	d2
	move.w	d4,d3
	ext.l	d3
	add.l	d3,d2
	bmi.b	L180
L179
	move.w	d1,d2
	ext.l	d2
	move.w	d5,d3
	ext.l	d3
	add.l	d3,d2
	bpl.b	L181
L180
;			return;
	movem.l	(a7)+,d2-d6/a6
	rts
L181
;		if (x<0)					
	tst.w	d0
	bpl.b	L183
L182
;	w += x;
	add.w	d0,d4
;	x = 0;
	moveq	#0,d0
L183
;		if ((x+w)>width)	
	move.w	d0,d2
	ext.l	d2
	move.w	d4,d3
	ext.l	d3
	add.l	d3,d2
	move.w	$8(a0),d3
	ext.l	d3
	cmp.l	d3,d2
	ble.b	L185
L184
;	w = width - x;
	move.w	$8(a0),d4
	ext.l	d4
	move.w	d0,d2
	ext.l	d2
	sub.l	d2,d4
L185
;		if (y<0)					
	tst.w	d1
	bpl.b	L187
L186
;	h += y;
	add.w	d1,d5
;	y = 0;
	moveq	#0,d1
L187
;		if ((y+h)>height)	
	move.w	d1,d2
	ext.l	d2
	move.w	d5,d3
	ext.l	d3
	add.l	d3,d2
	move.w	$A(a0),d3
	ext.l	d3
	cmp.l	d3,d2
	ble.b	L189
L188
;	h = height - y;
	move.w	$A(a0),d5
	ext.l	d5
	move.w	d1,d2
	ext.l	d2
	sub.l	d2,d5
L189
;		ClipBlit(rast, x, y, win->RPort, win->BorderLeft+x, win->BorderT
	ext.l	d5
	ext.l	d4
	move.l	4(a0),a1
	move.b	$37(a1),d3
	extb.l	d3
	move.w	d1,d2
	ext.l	d2
	add.l	d2,d3
	move.l	4(a0),a1
	move.b	$36(a1),d2
	extb.l	d2
	move.w	d0,d6
	ext.l	d6
	add.l	d6,d2
	move.l	4(a0),a1
	ext.l	d1
	ext.l	d0
	move.l	_GfxBase,a6
	move.l	#$C0,d6
	move.l	$50(a0),a0
	move.l	$32(a1),a1
	jsr	-$228(a6)
L190
	movem.l	(a7)+,d2-d6/a6
	rts

	SECTION "open__NativeWindow__TssEPCc:0",CODE


;sint32 NativeWindow::open(S_WHD, const char* title)
	XDEF	open__NativeWindow__TssEPCc
open__NativeWindow__TssEPCc
	movem.l	d2/d3/a2,-(a7)
	movem.l	$18(a7),d3/a0
	move.w	$16(a7),d0
	move.w	$14(a7),d1
	move.l	$10(a7),a2
L192
;	if (w<Display::MIN_WIDTH || w>Display::MAX_WIDTH ||
	move.w	d1,d2
	ext.l	d2
	cmp.l	#$50,d2
	blt.b	L196
L193
	move.w	d1,d2
	ext.l	d2
	cmp.l	#$640,d2
	bgt.b	L196
L194
	move.w	d0,d2
	ext.l	d2
	cmp.l	#$3C,d2
	blt.b	L196
L195
	move.w	d0,d2
	ext.l	d2
	cmp.l	#$4B0,d2
	ble.b	L197
L196
;						"const char* ti
	pea	2.w
	move.l	#L191,-(a7)
	jsr	printDebug__SystemLib__PCci
	addq.w	#$8,a7
;		return ERR_VALUE_ILLEGAL;
	move.l	#-$3010001,d0
	movem.l	(a7)+,d2/d3/a2
	rts
L197
;	width = w;
	move.w	d1,$8(a2)
;	height = h;
	move.w	d0,$A(a2)
;	depth = d;
	move.l	d3,$C(a2)
;	if (title)
	cmp.w	#0,a0
	beq.b	L199
L198
;		strncpy(name, title, 63);
	pea	$3F.w
	move.l	a0,-(a7)
	pea	$10(a2)
	jsr	_strncpy
	add.w	#$C,a7
L199
;	return openWindow(true, true);
	move.w	#1,-(a7)
	move.w	#1,-(a7)
	move.l	a2,-(a7)
	jsr	openWindow__NativeWindow__Tss
	addq.w	#$8,a7
	movem.l	(a7)+,d2/d3/a2
	rts

L191
	dc.b	'NativeWindow::open(sint16 w, sint16 h, Pixel::Depth, '
	dc.b	'const char* title) : illegal dimensions',0

	SECTION "open__NativeWindow__TP17DisplayPropertiesPCc:0",CODE


;sint32 NativeWindow::open(D_PRP* p, const char* title)
	XDEF	open__NativeWindow__TP17DisplayPropertiesPCc
open__NativeWindow__TP17DisplayPropertiesPCc
L201
;					"method unavailable");
	pea	2.w
	move.l	#L200,-(a7)
	jsr	printDebug__SystemLib__PCci
	addq.w	#$8,a7
;	return ERR_RSC_UNAVAILABLE;
	move.l	#-$3050005,d0
	rts

L200
	dc.b	'NativeWindow::open(DisplayProperties*, const char* title) : '
	dc.b	'method unavailable',0

	SECTION "_0ct__NativeScreen__T:0",CODE


;NativeScreen::NativeScreen() 
	XDEF	_0ct__NativeScreen__T
_0ct__NativeScreen__T
	move.l	a2,-(a7)
	move.l	$8(a7),a2
L202
	move.l	a2,-(a7)
	jsr	_0ct__DisplayNative__T
	addq.w	#4,a7
	clr.l	$50(a2)
	clr.l	$54(a2)
	move.l	(a7)+,a2
	rts

	SECTION "_0dt__NativeScreen__T:0",CODE


;NativeScreen::~NativeScreen()
	XDEF	_0dt__NativeScreen__T
_0dt__NativeScreen__T
	move.l	4(a7),a0
L203
;	closeScreen();
	move.l	a0,-(a7)
	jsr	closeScreen__NativeScreen__T
	addq.w	#4,a7
	rts

	SECTION "openScreen__NativeScreen__T:0",CODE


;sint32 NativeScreen::openScreen()
	XDEF	openScreen__NativeScreen__T
openScreen__NativeScreen__T
	move.l	a2,-(a7)
	move.l	$8(a7),a2
L205
;	if (scr)
	tst.l	(a2)
	beq.b	L207
L206
;		return ERR_RSC_LOCKED;
	move.l	#-$3050004,d0
	move.l	(a7)+,a2
	rts
L207
;	if (openFullScreen(displayID)==OK)
	move.l	$50(a2),-(a7)
	move.l	a2,-(a7)
	jsr	openFullScreen__DisplayNative__TUj
	addq.w	#$8,a7
	tst.l	d0
	bne.b	L211
L208
;		if (!(drawSurface = assignNewSurface(win->RPort->BitMap)))
	move.l	4(a2),a0
	move.l	$32(a0),a0
	move.l	4(a0),-(a7)
	jsr	assignNewSurface__SurfaceProvider__P06BitMap
	addq.w	#4,a7
	move.l	d0,$54(a2)
	bne.b	L210
L209
;reen::openScreen()
	pea	2.w
	move.l	#L204,-(a7)
	jsr	printDebug__SystemLib__PCci
	addq.w	#$8,a7
;			closeScreen();
	move.l	a2,-(a7)
	jsr	closeScreen__NativeScreen__T
	addq.w	#4,a7
;			return ERR_RSC_UNAVAILABLE;
	move.l	#-$3050005,d0
	move.l	(a7)+,a2
	rts
L210
;		setWinUser(drawSurface, win);
	move.l	$54(a2),a0
	move.l	4(a2),$A(a0)
;		return OK;
	moveq	#0,d0
	move.l	(a7)+,a2
	rts
L211
;	return ERR_RSC_UNAVAILABLE;
	move.l	#-$3050005,d0
	move.l	(a7)+,a2
	rts

L204
	dc.b	'NativeScreen::openScreen() : failed to create draw Surface',0

	SECTION "closeScreen__NativeScreen__T:0",CODE


;void NativeScreen::closeScreen()
	XDEF	closeScreen__NativeScreen__T
closeScreen__NativeScreen__T
	movem.l	a2/a3,-(a7)
	move.l	$C(a7),a3
L212
;	if (drawSurface)
	move.l	a3,a1
	tst.l	$54(a1)
	beq.b	L216
L213
;		delete drawSurface;
	move.l	a3,a0
	move.l	$54(a0),a2
	cmp.w	#0,a2
	beq.b	L215
L214
	move.l	a2,-(a7)
	jsr	destroy__Surface__T
	addq.w	#4,a7
	pea	$2A.w
	move.l	a2,-(a7)
	jsr	op__delete__PvUi
	addq.w	#$8,a7
L215
;		drawSurface = 0;
	move.l	a3,a1
	clr.l	$54(a1)
L216
;	closeFullScreen();
	move.l	a3,-(a7)
	jsr	closeFullScreen__DisplayNative__T
	addq.w	#4,a7
	movem.l	(a7)+,a2/a3
	rts

	SECTION "open__NativeScreen__TssEPCc:0",CODE


;sint32 NativeScreen::open(S_WHD, const char* title)
	XDEF	open__NativeScreen__TssEPCc
open__NativeScreen__TssEPCc
	movem.l	d2-d4/a2,-(a7)
	movem.l	$1C(a7),d4/a0
	move.w	$1A(a7),d0
	move.w	$18(a7),d1
	move.l	$14(a7),a2
L218
;	if (w<Display::MIN_WIDTH || w>Display::MAX_WIDTH ||
	move.w	d1,d2
	ext.l	d2
	cmp.l	#$50,d2
	blt.b	L222
L219
	move.w	d1,d2
	ext.l	d2
	cmp.l	#$640,d2
	bgt.b	L222
L220
	move.w	d0,d2
	ext.l	d2
	cmp.l	#$3C,d2
	blt.b	L222
L221
	move.w	d0,d2
	ext.l	d2
	cmp.l	#$4B0,d2
	ble.b	L223
L222
;						"const char* ti
	pea	2.w
	move.l	#L217,-(a7)
	jsr	printDebug__SystemLib__PCci
	addq.w	#$8,a7
;		return ERR_VALUE_ILLEGAL;
	move.l	#-$3010001,d0
	movem.l	(a7)+,d2-d4/a2
	rts
L223
;	return open(Display::findMode(w, h, d, false), title);
	move.l	a0,-(a7)
	move.l	d4,d2
	move.w	d0,d4
	move.w	d1,d0
	clr.w	-(a7)
	move.l	d2,-(a7)
	move.w	d4,-(a7)
	move.w	d0,-(a7)
	jsr	findIndex__DisplayPropertiesProvider__ssEs
	add.w	#$A,a7
	move.l	d0,-(a7)
	jsr	getMode__DisplayPropertiesProvider__Ui
	addq.w	#4,a7
	move.l	d0,-(a7)
	move.l	a2,-(a7)
	jsr	open__NativeScreen__TP17DisplayPropertiesPCc
	add.w	#$C,a7
	movem.l	(a7)+,d2-d4/a2
	rts

L217
	dc.b	'NativeScreen::open(sint16 w, sint16 h, Pixel::Depth, '
	dc.b	'const char* title) : illegal dimensions',0

	SECTION "open__NativeScreen__TP17DisplayPropertiesPCc:0",CODE


;sint32 NativeScreen::open(D_PRP* p, const char* title)
	XDEF	open__NativeScreen__TP17DisplayPropertiesPCc
open__NativeScreen__TP17DisplayPropertiesPCc
	movem.l	a2/a3/a6,-(a7)
	movem.l	$14(a7),a0/a6
	move.l	$10(a7),a2
L226
;	if (!p)
	cmp.w	#0,a0
	bne.b	L228
L227
;						"const char* title) :
	pea	2.w
	move.l	#L224,-(a7)
	jsr	printDebug__SystemLib__PCci
	addq.w	#$8,a7
;		return ERR_PTR_ZERO;
	move.l	#-$3020002,d0
	movem.l	(a7)+,a2/a3/a6
	rts
L228
;	if (!(displayID = getDisplayID(p)) )
	move.l	a0,a1
	cmp.w	#0,a1
	beq.b	L233
L229
	move.l	4(a1),d0
	tst.l	_modeID__DisplayNative
	beq.b	L231
L230
	move.l	_modeID__DisplayNative,a3
	move.l	0(a3,d0.l*4),d0
	bra.b	L232
L231
	moveq	#0,d0
L232
	bra.b	L234
L233
	moveq	#0,d0
L234
	move.l	d0,$50(a2)
	bne.b	L236
L235
;						"const char* t
	pea	2.w
	move.l	#L225,-(a7)
	jsr	printDebug__SystemLib__PCci
	addq.w	#$8,a7
;		return ERR_RSC_UNAVAILABLE;
	move.l	#-$3050005,d0
	movem.l	(a7)+,a2/a3/a6
	rts
L236
;	width		= p->getW();
	move.w	(a0),d0
	ext.l	d0
	move.w	d0,$8(a2)
;	height	= p->getH();
	move.w	2(a0),d0
	ext.l	d0
	move.w	d0,$A(a2)
;	depth		= p->getDepth();
	move.l	$18(a0),$C(a2)
;	if (title)
	cmp.w	#0,a6
	beq.b	L238
L237
;		strncpy(name, title, 63);
	pea	$3F.w
	move.l	a6,-(a7)
	pea	$10(a2)
	jsr	_strncpy
	add.w	#$C,a7
L238
;	return openScreen();
	move.l	a2,-(a7)
	jsr	openScreen__NativeScreen__T
	addq.w	#4,a7
	movem.l	(a7)+,a2/a3/a6
	rts

L225
	dc.b	'NativeScreen::open(DisplayProperties *p, '
	dc.b	'const char* title) : Display unavailable',0
L224
	dc.b	'NativeScreen::open(DisplayProperties *p, '
	dc.b	'const char* title) : null pointer',0

	SECTION "reopen__NativeScreen__T:0",CODE


;sint32 NativeScreen::reopen()
	XDEF	reopen__NativeScreen__T
reopen__NativeScreen__T
	move.l	4(a7),a0
L240
;	if (width == -1 || height == -1)
	move.w	$8(a0),d0
	cmp.w	#-1,d0
	beq.b	L242
L241
	move.w	$A(a0),d0
	cmp.w	#-1,d0
	bne.b	L243
L242
;X_ERROR("NativeSc
	pea	2.w
	move.l	#L239,-(a7)
	jsr	printDebug__SystemLib__PCci
	addq.w	#$8,a7
;		return ERR_RSC_UNAVAILABLE;
	move.l	#-$3050005,d0
	rts
L243
;	return openScreen();
	move.l	a0,-(a7)
	jsr	openScreen__NativeScreen__T
	addq.w	#4,a7
	rts

L239
	dc.b	'NativeScreen::reopen() : parameters unset',0

	SECTION "close__NativeScreen__T:0",CODE


;void NativeScreen::close()
	XDEF	close__NativeScreen__T
close__NativeScreen__T
	move.l	4(a7),a0
L244
;	closeScreen();
	move.l	a0,-(a7)
	jsr	closeScreen__NativeScreen__T
	addq.w	#4,a7
	rts

	SECTION "_0ct__NativeScreenDB__T:0",CODE


;NativeScreenDB::NativeScreenDB() 
	XDEF	_0ct__NativeScreenDB__T
_0ct__NativeScreenDB__T
	move.l	a2,-(a7)
	move.l	$8(a7),a2
L245
	move.l	a2,-(a7)
	jsr	_0ct__DisplayNative__T
	addq.w	#4,a7
	clr.l	$58(a2)
	clr.w	$5E(a2)
	clr.l	$60(a2)
;	buffer[0] = 0;
	clr.l	$50(a2)
;	buffer[1] = 0;
	lea	$50(a2),a0
	clr.l	4(a0)
	move.l	(a7)+,a2
	rts

	SECTION "_0dt__NativeScreenDB__T:0",CODE


;NativeScreenDB::~NativeScreenDB()
	XDEF	_0dt__NativeScreenDB__T
_0dt__NativeScreenDB__T
	move.l	4(a7),a0
L246
;	closeScreen();
	move.l	a0,-(a7)
	jsr	closeScreen__NativeScreenDB__T
	addq.w	#4,a7
	rts

	SECTION "openScreen__NativeScreenDB__T:0",CODE


;sint32 NativeScreenDB::openScreen()
	XDEF	openScreen__NativeScreenDB__T
openScreen__NativeScreenDB__T
	movem.l	a2/a6,-(a7)
	move.l	$C(a7),a2
L250
;	if (scr)
	move.l	a2,a1
	tst.l	(a1)
	beq.b	L252
L251
;		return ERR_RSC_LOCKED;
	move.l	#-$3050004,d0
	movem.l	(a7)+,a2/a6
	rts
L252
;	if (openFullScreen(displayID)==OK)
	move.l	a2,a0
	move.l	$58(a0),-(a7)
	move.l	a2,-(a7)
	jsr	openFullScreen__DisplayNative__TUj
	addq.w	#$8,a7
	tst.l	d0
	bne	L260
L253
;		if (!(buffer[0] = AllocScreenBuffer(scr, 0, SB_SCREEN_BITMAP)))
	move.l	a2,a1
	move.l	(a1),a0
	move.l	_IntuitionBase,a6
	moveq	#1,d0
	sub.l	a1,a1
	jsr	-$300(a6)
	move.l	d0,$50(a2)
	bne.b	L255
L254
;DB::openScreen() 
	pea	2.w
	move.l	#L247,-(a7)
	jsr	printDebug__SystemLib__PCci
	addq.w	#$8,a7
;			goto 
	bra	L260
L255
;		if (!(buffer[1] = AllocScreenBuffer(scr, 0, 0)))
	move.l	a2,a1
	move.l	(a1),a0
	move.l	_IntuitionBase,a6
	moveq	#0,d0
	sub.l	a1,a1
	jsr	-$300(a6)
	lea	$50(a2),a0
	move.l	d0,4(a0)
	bne.b	L257
L256
;::openScreen() : 
	pea	2.w
	move.l	#L248,-(a7)
	jsr	printDebug__SystemLib__PCci
	addq.w	#$8,a7
;			goto 
	bra.b	L260
L257
;		if (!(drawSurface = createSurface(buffer[1]->sb_BitMap, width, h
	move.l	a2,a0
	move.w	$A(a0),-(a7)
	move.l	a2,a0
	move.w	$8(a0),-(a7)
	lea	$50(a2),a0
	move.l	4(a0),a0
	move.l	(a0),-(a7)
	jsr	createSurface__SurfaceProvider__P06BitMapss
	addq.w	#$8,a7
	move.l	a2,a1
	move.l	d0,$60(a1)
	bne.b	L259
L258
;enDB::openScreen()
	pea	2.w
	move.l	#L249,-(a7)
	jsr	printDebug__SystemLib__PCci
	addq.w	#$8,a7
;			goto 
	bra.b	L260
L259
;		drawBuffer = 1;
	move.l	a2,a0
	move.w	#1,$5C(a0)
;		setWinUser(drawSurface, win);
	move.l	a2,a0
	move.l	4(a0),a1
	move.l	$60(a2),a0
	move.l	a1,$A(a0)
;		return OK;
	moveq	#0,d0
	movem.l	(a7)+,a2/a6
	rts
L260
;	closeScreen();
	move.l	a2,-(a7)
	jsr	closeScreen__NativeScreenDB__T
	addq.w	#4,a7
;	return ERR_RSC_UNAVAILABLE;
	move.l	#-$3050005,d0
	movem.l	(a7)+,a2/a6
	rts

L249
	dc.b	'NativeScreenDB::openScreen() : failed to create draw Surface',0
L247
	dc.b	'NativeScreenDB::openScreen() : failed to create primary buffer',0
L248
	dc.b	'NativeScreenDB::openScreen() : failed to create secondary buffer'
	dc.b	0

	SECTION "closeScreen__NativeScreenDB__T:0",CODE


;void NativeScreenDB::closeScreen()
	XDEF	closeScreen__NativeScreenDB__T
closeScreen__NativeScreenDB__T
	movem.l	a2/a3/a6,-(a7)
	move.l	$10(a7),a3
L261
;	if (drawSurface)
	move.l	a3,a1
	tst.l	$60(a1)
	beq.b	L265
L262
;		delete drawSurface;
	move.l	a3,a0
	move.l	$60(a0),a6
	cmp.w	#0,a6
	beq.b	L264
L263
	move.l	a6,-(a7)
	jsr	destroy__Surface__T
	addq.w	#4,a7
	pea	$2A.w
	move.l	a6,-(a7)
	jsr	op__delete__PvUi
	addq.w	#$8,a7
L264
;		drawSurface = 0;
	move.l	a3,a1
	clr.l	$60(a1)
L265
;	if (buffer[0])
	tst.l	$50(a3)
	beq.b	L269
L266
;		buffer[0]->sb_DBufInfo->dbi_SafeMessage.mn_ReplyPort = 0;
	move.l	$50(a3),a0
	move.l	4(a0),a0
	clr.l	$16(a0)
;		while (!ChangeScreenBuffer(scr, buffer[0]))
L267
	move.l	a3,a2
	move.l	_IntuitionBase,a6
	move.l	(a2),a0
	move.l	$50(a3),a1
	jsr	-$30C(a6)
	tst.l	d0
	beq.b	L267
L268
;		FreeScreenBuffer(scr, buffer[0]);
	move.l	a3,a2
	move.l	_IntuitionBase,a6
	move.l	(a2),a0
	move.l	$50(a3),a1
	jsr	-$306(a6)
;		buffer[0] = 0;
	clr.l	$50(a3)
L269
;	if (buffer[1])
	lea	$50(a3),a0
	tst.l	4(a0)
	beq.b	L271
L270
;		FreeScreenBuffer(scr, buffer[1]);
	lea	$50(a3),a0
	move.l	4(a0),a1
	move.l	a3,a2
	move.l	_IntuitionBase,a6
	move.l	(a2),a0
	jsr	-$306(a6)
;		buffer[1] = 0;
	lea	$50(a3),a0
	clr.l	4(a0)
L271
;	closeFullScreen();
	move.l	a3,-(a7)
	jsr	closeFullScreen__DisplayNative__T
	addq.w	#4,a7
	movem.l	(a7)+,a2/a3/a6
	rts

	SECTION "refresh__NativeScreenDB__T:0",CODE


;void NativeScreenDB::refresh()
	XDEF	refresh__NativeScreenDB__T
refresh__NativeScreenDB__T
	movem.l	d2-d7/a2/a3/a6,-(a7)
	move.l	$28(a7),a3
L272
;	if (scr)
	move.l	a3,a1
	tst.l	(a1)
	beq	L277
L273
;		buffer[drawBuffer]->sb_DBufInfo->dbi_SafeMessage.mn_ReplyPort = 
	move.l	a3,a1
	moveq	#0,d0
	move.w	$5C(a1),d0
	lea	$50(a3),a0
	move.l	0(a0,d0.l*4),a0
	move.l	4(a0),a0
	clr.l	$16(a0)
;		while (!ChangeScreenBuffer(scr, buffer[drawBuffer]) )
L274
	move.l	a3,a1
	moveq	#0,d0
	move.w	$5C(a1),d0
	lea	$50(a3),a0
	move.l	0(a0,d0.l*4),a1
	move.l	a3,a2
	move.l	_IntuitionBase,a6
	move.l	(a2),a0
	jsr	-$30C(a6)
	tst.l	d0
	beq.b	L274
L275
;		drawBuffer ^= 1;
	move.l	a3,a0
	move.w	$5C(a0),d0
	eor.w	#1,d0
	move.l	a3,a0
	move.w	d0,$5C(a0)
;		assignSurfaceQuick(drawSurface, buffer[drawBuffer]->sb_BitMap);
	move.l	a3,a1
	moveq	#0,d0
	move.w	$5C(a1),d0
	lea	$50(a3),a0
	move.l	0(a0,d0.l*4),a0
	move.l	(a0),a1
	move.l	a3,a2
	move.l	$60(a2),a0
	move.l	a1,$E(a0)
;		if (cloneBuffer)
	move.l	a3,a0
	tst.w	$5E(a0)
	beq.b	L277
L276
;			BltBitMap(buffer[1-drawBuffer]->sb_BitMap, 0, 0,
	move.l	a3,a0
	move.w	$A(a0),d5
	ext.l	d5
	move.l	a3,a0
	move.w	$8(a0),d4
	ext.l	d4
	move.l	a3,a1
	moveq	#0,d0
	move.w	$5C(a1),d0
	lea	$50(a3),a0
	move.l	0(a0,d0.l*4),a0
	move.l	(a0),a1
	move.l	a3,a2
	moveq	#0,d0
	move.w	$5C(a2),d0
	moveq	#1,d1
	sub.l	d0,d1
	lea	$50(a3),a0
	move.l	d1,d0
	move.l	0(a0,d0.l*4),a0
	move.l	_GfxBase,a6
	moveq	#0,d0
	moveq	#0,d1
	moveq	#0,d2
	moveq	#0,d3
	move.l	#$C0,d6
	move.l	#$FF,d7
	move.l	(a0),a0
	sub.l	a2,a2
	jsr	-$1E(a6)
L277
	movem.l	(a7)+,d2-d7/a2/a3/a6
	rts

	SECTION "open__NativeScreenDB__TssEPCc:0",CODE


;sint32 NativeScreenDB::open(S_WHD, const char* title)
	XDEF	open__NativeScreenDB__TssEPCc
open__NativeScreenDB__TssEPCc
	movem.l	d2-d4/a2,-(a7)
	movem.l	$1C(a7),d4/a0
	move.w	$1A(a7),d0
	move.w	$18(a7),d1
	move.l	$14(a7),a2
L279
;	if (w<Display::MIN_WIDTH || w>Display::MAX_WIDTH ||
	move.w	d1,d2
	ext.l	d2
	cmp.l	#$50,d2
	blt.b	L283
L280
	move.w	d1,d2
	ext.l	d2
	cmp.l	#$640,d2
	bgt.b	L283
L281
	move.w	d0,d2
	ext.l	d2
	cmp.l	#$3C,d2
	blt.b	L283
L282
	move.w	d0,d2
	ext.l	d2
	cmp.l	#$4B0,d2
	ble.b	L284
L283
;						"const char* ti
	pea	2.w
	move.l	#L278,-(a7)
	jsr	printDebug__SystemLib__PCci
	addq.w	#$8,a7
;		return ERR_VALUE_ILLEGAL;
	move.l	#-$3010001,d0
	movem.l	(a7)+,d2-d4/a2
	rts
L284
;	return open(Display::findMode(w, h, d, false), title);
	move.l	a0,-(a7)
	move.l	d4,d2
	move.w	d0,d4
	move.w	d1,d0
	clr.w	-(a7)
	move.l	d2,-(a7)
	move.w	d4,-(a7)
	move.w	d0,-(a7)
	jsr	findIndex__DisplayPropertiesProvider__ssEs
	add.w	#$A,a7
	move.l	d0,-(a7)
	jsr	getMode__DisplayPropertiesProvider__Ui
	addq.w	#4,a7
	move.l	d0,-(a7)
	move.l	a2,-(a7)
	jsr	open__NativeScreenDB__TP17DisplayPropertiesPCc
	add.w	#$C,a7
	movem.l	(a7)+,d2-d4/a2
	rts

L278
	dc.b	'NativeScreenDB::open(sint16 w, sint16 h, Pixel::Depth, '
	dc.b	'const char* title) : illegal dimensions',0

	SECTION "open__NativeScreenDB__TP17DisplayPropertiesPCc:0",CODE


;sint32 NativeScreenDB::open(D_PRP* p, const char* title)
	XDEF	open__NativeScreenDB__TP17DisplayPropertiesPCc
open__NativeScreenDB__TP17DisplayPropertiesPCc
	movem.l	a2/a3/a6,-(a7)
	movem.l	$14(a7),a0/a6
	move.l	$10(a7),a2
L287
;	if (!p)
	cmp.w	#0,a0
	bne.b	L289
L288
;						"const char* title) :
	pea	2.w
	move.l	#L285,-(a7)
	jsr	printDebug__SystemLib__PCci
	addq.w	#$8,a7
;		return ERR_PTR_ZERO;
	move.l	#-$3020002,d0
	movem.l	(a7)+,a2/a3/a6
	rts
L289
;	if (!(displayID = getDisplayID(p)) )
	move.l	a0,a1
	cmp.w	#0,a1
	beq.b	L294
L290
	move.l	4(a1),d0
	tst.l	_modeID__DisplayNative
	beq.b	L292
L291
	move.l	_modeID__DisplayNative,a3
	move.l	0(a3,d0.l*4),d0
	bra.b	L293
L292
	moveq	#0,d0
L293
	bra.b	L295
L294
	moveq	#0,d0
L295
	move.l	d0,$58(a2)
	bne.b	L297
L296
;						"const char* t
	pea	2.w
	move.l	#L286,-(a7)
	jsr	printDebug__SystemLib__PCci
	addq.w	#$8,a7
;		return ERR_RSC_UNAVAILABLE;
	move.l	#-$3050005,d0
	movem.l	(a7)+,a2/a3/a6
	rts
L297
;	width		= p->getW();
	move.w	(a0),d0
	ext.l	d0
	move.w	d0,$8(a2)
;	height	= p->getH();
	move.w	2(a0),d0
	ext.l	d0
	move.w	d0,$A(a2)
;	depth		= p->getDepth();
	move.l	$18(a0),$C(a2)
;	if (title)
	cmp.w	#0,a6
	beq.b	L299
L298
;		strncpy(name, title, 63);
	pea	$3F.w
	move.l	a6,-(a7)
	pea	$10(a2)
	jsr	_strncpy
	add.w	#$C,a7
L299
;	return openScreen();
	move.l	a2,-(a7)
	jsr	openScreen__NativeScreenDB__T
	addq.w	#4,a7
	movem.l	(a7)+,a2/a3/a6
	rts

L286
	dc.b	'NativeScreenDB::open(DisplayProperties *p, '
	dc.b	'const char* title) : Display unavailable',0
L285
	dc.b	'NativeScreenDB::open(DisplayProperties *p, '
	dc.b	'const char* title) : null pointer',0

	SECTION "reopen__NativeScreenDB__T:0",CODE


;sint32 NativeScreenDB::reopen()
	XDEF	reopen__NativeScreenDB__T
reopen__NativeScreenDB__T
	move.l	4(a7),a0
L301
;	if (width == -1 || height == -1)
	move.w	$8(a0),d0
	cmp.w	#-1,d0
	beq.b	L303
L302
	move.w	$A(a0),d0
	cmp.w	#-1,d0
	bne.b	L304
L303
;ERROR("NativeScre
	pea	2.w
	move.l	#L300,-(a7)
	jsr	printDebug__SystemLib__PCci
	addq.w	#$8,a7
;		return ERR_RSC_UNAVAILABLE;
	move.l	#-$3050005,d0
	rts
L304
;	return openScreen();
	move.l	a0,-(a7)
	jsr	openScreen__NativeScreenDB__T
	addq.w	#4,a7
	rts

L300
	dc.b	'NativeScreenDB::reopen() : parameters unset',0

	SECTION "close__NativeScreenDB__T:0",CODE


;void NativeScreenDB::close()
	XDEF	close__NativeScreenDB__T
close__NativeScreenDB__T
	move.l	4(a7),a0
L305
;	closeScreen();
	move.l	a0,-(a7)
	jsr	closeScreen__NativeScreenDB__T
	addq.w	#4,a7
	rts

	END
