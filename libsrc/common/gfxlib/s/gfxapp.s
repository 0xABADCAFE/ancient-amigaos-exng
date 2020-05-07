
; Storm C Compiler
; exng:libsrc/common/gfxlib/gfxapp.cpp
	mc68030
	mc68881
	XREF	inputQueued__InteractiveDisplay__T
	XREF	handleEvent__InteractiveDisplay__T
	XREF	waitEvent__InteractiveDisplay__T
	XREF	discardQueue__InteractiveDisplay__T
	XREF	applyFilter__InteractiveDisplay__T
	XREF	_0dt__NativeInput__T
	XREF	_0ct__NativeInput__T
	XREF	inputQueued__InputDispatcher__T
	XREF	handleEvent__InputDispatcher__T
	XREF	waitEvent__InputDispatcher__T
	XREF	applyFilter__InputDispatcher__T
	XREF	discardQueue__InputDispatcher__T
	XREF	setIFilter__IFilter__TUj
	XREF	toggleIFilter__IFilter__TUj
	XREF	disableIFilter__IFilter__TUj
	XREF	enableIFilter__IFilter__TUj
	XREF	_0dt___LLBase__T
	XREF	_0ct___LLBase__T
	XREF	contains___LLBase__TPv
	XREF	repLast___LLBase__TPvPv
	XREF	repFirst___LLBase__TPvPv
	XREF	remLast___LLBase__TPv
	XREF	remFirst___LLBase__TPv
	XREF	remCurr___LLBase__T
	XREF	remFirst___LLBase__T
	XREF	remLast___LLBase__T
	XREF	insCurr___LLBase__TPv
	XREF	insFirst___LLBase__TPv
	XREF	insLast___LLBase__TPv
	XREF	rep___LLBase__r0jr1jr8Pvr9Pv
	XREF	cnt___LLBase__r0jr1jr8Pv
	XREF	rem___LLBase__r0jr1jr8Pv
	XREF	rem___LLBase__r0jr1j
	XREF	findBkwd___LLBase__TjPv
	XREF	findFwrd___LLBase__TjPv
	XREF	getValue__Key64__TPCc
	XREF	getValue__Key32__TPCc
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
	XREF	_0ct__DisplayNative__T
	XREF	setDisplayTitle__DisplayNative__TPCcs
	XREF	waitForRefresh__DisplayNative__T
	XREF	blitCopy__Surface__P07SurfacessP07Surfacessss
	XREF	destroy__Surface__T
	XREF	init__Surface__T
	XREF	getHardwareFormat__Native2D__E
	XREF	findIndex__DisplayPropertiesProvider__ssEs
	XREF	getMode__DisplayPropertiesProvider__Ui
	XREF	destroy__ImageBuffer__T
	XREF	runApplication__AppBase__T
	XREF	_system
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
	XREF	_linkCache___LLBase
	XREF	_linkCacheSize___LLBase
	XREF	_linkCacheDelta___LLBase
	XREF	_linkCount___LLBase
	XREF	_nextFree___LLBase
	XREF	_openCount__NativeInput
	XREF	_nonPrintMap__NativeInput

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

	SECTION "open__InteractiveWindow__TssEPCc:0",CODE


;sint32 InteractiveWindow::open(S_WHD, const char* title)
	XDEF	open__InteractiveWindow__TssEPCc
open__InteractiveWindow__TssEPCc
	movem.l	d2/a2,-(a7)
	movem.l	$14(a7),d2/a0
	move.w	$10(a7),d0
	move.w	$12(a7),d1
	move.l	$C(a7),a2
L62
;	sint32 r = NativeWindow::open(w, h, d, title);
	move.l	a0,-(a7)
	move.l	d2,-(a7)
	move.w	d1,-(a7)
	move.w	d0,-(a7)
	move.l	a2,a0
	cmp.w	#0,a0
	beq.b	L64
L63
	add.w	#$26,a0
L64
	move.l	a0,-(a7)
	jsr	open__NativeWindow__TssEPCc
	add.w	#$10,a7
	move.l	d0,d2
;	if (r==OK)
	bne.b	L66
L65
;		applyFilter();
	move.l	$1C(a2),a0
	move.l	a2,d0
	add.l	$6C(a0),d0
	move.l	d0,-(a7)
	move.l	$68(a0),a0
	jsr	(a0)
	addq.w	#4,a7
L66
;	return r;
	move.l	d2,d0
	movem.l	(a7)+,d2/a2
	rts

	SECTION "open__InteractiveWindow__TP17DisplayPropertiesPCc:0",CODE


;sint32 InteractiveWindow::open(D_PRP* p, const char* title)
	XDEF	open__InteractiveWindow__TP17DisplayPropertiesPCc
open__InteractiveWindow__TP17DisplayPropertiesPCc
	movem.l	d2/a2,-(a7)
	movem.l	$10(a7),a0/a1
	move.l	$C(a7),a2
L67
;	sint32 r = NativeWindow::open(p, title);
	move.l	a1,-(a7)
	move.l	a0,-(a7)
	move.l	a2,a0
	cmp.w	#0,a0
	beq.b	L69
L68
	add.w	#$26,a0
L69
	move.l	a0,-(a7)
	jsr	open__NativeWindow__TP17DisplayPropertiesPCc
	add.w	#$C,a7
	move.l	d0,d2
;	if (r==OK)
	bne.b	L71
L70
;		applyFilter();
	move.l	$1C(a2),a0
	move.l	a2,d0
	add.l	$6C(a0),d0
	move.l	d0,-(a7)
	move.l	$68(a0),a0
	jsr	(a0)
	addq.w	#4,a7
L71
;	return r;
	move.l	d2,d0
	movem.l	(a7)+,d2/a2
	rts

	SECTION "reopen__InteractiveWindow__T:0",CODE


;sint32 InteractiveWindow::reopen()
	XDEF	reopen__InteractiveWindow__T
reopen__InteractiveWindow__T
	movem.l	d2/a2,-(a7)
	move.l	$C(a7),a2
L72
;	sint32 r = NativeWindow::reopen();
	move.l	a2,a0
	cmp.w	#0,a0
	beq.b	L74
L73
	add.w	#$26,a0
L74
	move.l	a0,-(a7)
	jsr	reopen__NativeWindow__T
	addq.w	#4,a7
	move.l	d0,d2
;	if (r==OK)
	bne.b	L76
L75
;		applyFilter();
	move.l	$1C(a2),a0
	move.l	a2,d0
	add.l	$6C(a0),d0
	move.l	d0,-(a7)
	move.l	$68(a0),a0
	jsr	(a0)
	addq.w	#4,a7
L76
;	return r;
	move.l	d2,d0
	movem.l	(a7)+,d2/a2
	rts

	SECTION "close__InteractiveWindow__T:0",CODE


;void InteractiveWindow::close()
	XDEF	close__InteractiveWindow__T
close__InteractiveWindow__T
	movem.l	a2/a3,-(a7)
	move.l	$C(a7),a3
L77
;	discardQueue();
	move.l	a3,a0
	move.l	$1C(a0),a1
	move.l	a0,d0
	add.l	$64(a1),d0
	move.l	d0,-(a7)
	move.l	$60(a1),a1
	jsr	(a1)
	addq.w	#4,a7
;	setDispatchFilter(0);
	moveq	#0,d0
	move.l	a3,a2
	cmp.w	#0,a2
	beq.b	L79
L78
	addq.w	#4,a2
L79
	move.l	d0,-(a7)
	move.l	a2,-(a7)
	jsr	setIFilter__IFilter__TUj
	addq.w	#$8,a7
	move.l	$18(a2),a0
	move.l	a2,d0
	add.l	$2C(a0),d0
	move.l	d0,-(a7)
	move.l	$28(a0),a0
	jsr	(a0)
	addq.w	#4,a7
;	NativeWindow::close();
	move.l	a3,a0
	cmp.w	#0,a0
	beq.b	L81
L80
	moveq	#$26,d0
	add.l	a3,d0
	move.l	d0,a3
L81
	move.l	a3,-(a7)
	jsr	close__NativeWindow__T
	addq.w	#4,a7
	movem.l	(a7)+,a2/a3
	rts

	SECTION "open__InteractiveScreen__TssEPCc:0",CODE


;sint32 InteractiveScreen::open(S_WHD, const char* title)
	XDEF	open__InteractiveScreen__TssEPCc
open__InteractiveScreen__TssEPCc
	movem.l	d2/a2,-(a7)
	movem.l	$14(a7),d2/a0
	move.w	$10(a7),d0
	move.w	$12(a7),d1
	move.l	$C(a7),a2
L82
;	sint32 r = NativeScreen::open(w, h, d, title);
	move.l	a0,-(a7)
	move.l	d2,-(a7)
	move.w	d1,-(a7)
	move.w	d0,-(a7)
	move.l	a2,a0
	cmp.w	#0,a0
	beq.b	L84
L83
	add.w	#$26,a0
L84
	move.l	a0,-(a7)
	jsr	open__NativeScreen__TssEPCc
	add.w	#$10,a7
	move.l	d0,d2
;	if (r==OK)
	bne.b	L86
L85
;		applyFilter();
	move.l	$1C(a2),a0
	move.l	a2,d0
	add.l	$6C(a0),d0
	move.l	d0,-(a7)
	move.l	$68(a0),a0
	jsr	(a0)
	addq.w	#4,a7
L86
;	return r;
	move.l	d2,d0
	movem.l	(a7)+,d2/a2
	rts

	SECTION "open__InteractiveScreen__TP17DisplayPropertiesPCc:0",CODE


;sint32 InteractiveScreen::open(D_PRP* p, const char* title)
	XDEF	open__InteractiveScreen__TP17DisplayPropertiesPCc
open__InteractiveScreen__TP17DisplayPropertiesPCc
	movem.l	d2/a2,-(a7)
	movem.l	$10(a7),a0/a1
	move.l	$C(a7),a2
L87
;	sint32 r = NativeScreen::open(p, title);
	move.l	a1,-(a7)
	move.l	a0,-(a7)
	move.l	a2,a0
	cmp.w	#0,a0
	beq.b	L89
L88
	add.w	#$26,a0
L89
	move.l	a0,-(a7)
	jsr	open__NativeScreen__TP17DisplayPropertiesPCc
	add.w	#$C,a7
	move.l	d0,d2
;	if (r==OK)
	bne.b	L91
L90
;		applyFilter();
	move.l	$1C(a2),a0
	move.l	a2,d0
	add.l	$6C(a0),d0
	move.l	d0,-(a7)
	move.l	$68(a0),a0
	jsr	(a0)
	addq.w	#4,a7
L91
;	return r;
	move.l	d2,d0
	movem.l	(a7)+,d2/a2
	rts

	SECTION "reopen__InteractiveScreen__T:0",CODE


;sint32 InteractiveScreen::reopen()
	XDEF	reopen__InteractiveScreen__T
reopen__InteractiveScreen__T
	movem.l	d2/a2,-(a7)
	move.l	$C(a7),a2
L92
;	sint32 r = NativeScreen::reopen();
	move.l	a2,a0
	cmp.w	#0,a0
	beq.b	L94
L93
	add.w	#$26,a0
L94
	move.l	a0,-(a7)
	jsr	reopen__NativeScreen__T
	addq.w	#4,a7
	move.l	d0,d2
;	if (r==OK)
	bne.b	L96
L95
;		applyFilter();
	move.l	$1C(a2),a0
	move.l	a2,d0
	add.l	$6C(a0),d0
	move.l	d0,-(a7)
	move.l	$68(a0),a0
	jsr	(a0)
	addq.w	#4,a7
L96
;	return r;
	move.l	d2,d0
	movem.l	(a7)+,d2/a2
	rts

	SECTION "close__InteractiveScreen__T:0",CODE


;void InteractiveScreen::close()
	XDEF	close__InteractiveScreen__T
close__InteractiveScreen__T
	movem.l	a2/a3,-(a7)
	move.l	$C(a7),a3
L97
;	discardQueue();
	move.l	a3,a0
	move.l	$1C(a0),a1
	move.l	a0,d0
	add.l	$64(a1),d0
	move.l	d0,-(a7)
	move.l	$60(a1),a1
	jsr	(a1)
	addq.w	#4,a7
;	setDispatchFilter(0);
	moveq	#0,d0
	move.l	a3,a2
	cmp.w	#0,a2
	beq.b	L99
L98
	addq.w	#4,a2
L99
	move.l	d0,-(a7)
	move.l	a2,-(a7)
	jsr	setIFilter__IFilter__TUj
	addq.w	#$8,a7
	move.l	$18(a2),a0
	move.l	a2,d0
	add.l	$2C(a0),d0
	move.l	d0,-(a7)
	move.l	$28(a0),a0
	jsr	(a0)
	addq.w	#4,a7
;	NativeScreen::close();
	move.l	a3,a0
	cmp.w	#0,a0
	beq.b	L101
L100
	moveq	#$26,d0
	add.l	a3,d0
	move.l	d0,a3
L101
	move.l	a3,-(a7)
	jsr	close__NativeScreen__T
	addq.w	#4,a7
	movem.l	(a7)+,a2/a3
	rts

	SECTION "open__InteractiveScreenBuffered__TssEPCc:0",CODE


;sint32 InteractiveScreenBuffered::open(S_WHD, const char* title)
	XDEF	open__InteractiveScreenBuffered__TssEPCc
open__InteractiveScreenBuffered__TssEPCc
	movem.l	d2/a2,-(a7)
	movem.l	$14(a7),d2/a0
	move.w	$10(a7),d0
	move.w	$12(a7),d1
	move.l	$C(a7),a2
L102
;	sint32 r = InteractiveScreenBuffered::open(w, h, d, title);
	move.l	a0,-(a7)
	move.l	d2,-(a7)
	move.w	d1,-(a7)
	move.w	d0,-(a7)
	move.l	a2,-(a7)
	jsr	open__InteractiveScreenBuffered__TssEPCc
	add.w	#$10,a7
	move.l	d0,d2
;	if (r==OK)
	bne.b	L104
L103
;		applyFilter();
	move.l	$1C(a2),a0
	move.l	a2,d0
	add.l	$6C(a0),d0
	move.l	d0,-(a7)
	move.l	$68(a0),a0
	jsr	(a0)
	addq.w	#4,a7
L104
;	return r;
	move.l	d2,d0
	movem.l	(a7)+,d2/a2
	rts

	SECTION "open__InteractiveScreenBuffered__TP17DisplayPropertiesPCc:0",CODE


;sint32 InteractiveScreenBuffered::open(D_PRP* p, const char* title)
	XDEF	open__InteractiveScreenBuffered__TP17DisplayPropertiesPCc
open__InteractiveScreenBuffered__TP17DisplayPropertiesPCc
	movem.l	d2/a2,-(a7)
	movem.l	$10(a7),a0/a1
	move.l	$C(a7),a2
L105
;	sint32 r = NativeScreenDB::open(p, title);
	move.l	a1,-(a7)
	move.l	a0,-(a7)
	move.l	a2,a0
	cmp.w	#0,a0
	beq.b	L107
L106
	add.w	#$26,a0
L107
	move.l	a0,-(a7)
	jsr	open__NativeScreenDB__TP17DisplayPropertiesPCc
	add.w	#$C,a7
	move.l	d0,d2
;	if (r==OK)
	bne.b	L109
L108
;		applyFilter();
	move.l	$1C(a2),a0
	move.l	a2,d0
	add.l	$6C(a0),d0
	move.l	d0,-(a7)
	move.l	$68(a0),a0
	jsr	(a0)
	addq.w	#4,a7
L109
;	return r;
	move.l	d2,d0
	movem.l	(a7)+,d2/a2
	rts

	SECTION "reopen__InteractiveScreenBuffered__T:0",CODE


;sint32 InteractiveScreenBuffered::reopen()
	XDEF	reopen__InteractiveScreenBuffered__T
reopen__InteractiveScreenBuffered__T
	movem.l	d2/a2,-(a7)
	move.l	$C(a7),a2
L110
;	sint32 r = NativeScreenDB::reopen();
	move.l	a2,a0
	cmp.w	#0,a0
	beq.b	L112
L111
	add.w	#$26,a0
L112
	move.l	a0,-(a7)
	jsr	reopen__NativeScreenDB__T
	addq.w	#4,a7
	move.l	d0,d2
;	if (r==OK)
	bne.b	L114
L113
;		applyFilter();
	move.l	$1C(a2),a0
	move.l	a2,d0
	add.l	$6C(a0),d0
	move.l	d0,-(a7)
	move.l	$68(a0),a0
	jsr	(a0)
	addq.w	#4,a7
L114
;	return r;
	move.l	d2,d0
	movem.l	(a7)+,d2/a2
	rts

	SECTION "close__InteractiveScreenBuffered__T:0",CODE


;void InteractiveScreenBuffered::close()
	XDEF	close__InteractiveScreenBuffered__T
close__InteractiveScreenBuffered__T
	movem.l	a2/a3,-(a7)
	move.l	$C(a7),a3
L115
;	discardQueue();
	move.l	a3,a0
	move.l	$1C(a0),a1
	move.l	a0,d0
	add.l	$64(a1),d0
	move.l	d0,-(a7)
	move.l	$60(a1),a1
	jsr	(a1)
	addq.w	#4,a7
;	setDispatchFilter(0);
	moveq	#0,d0
	move.l	a3,a2
	cmp.w	#0,a2
	beq.b	L117
L116
	addq.w	#4,a2
L117
	move.l	d0,-(a7)
	move.l	a2,-(a7)
	jsr	setIFilter__IFilter__TUj
	addq.w	#$8,a7
	move.l	$18(a2),a0
	move.l	a2,d0
	add.l	$2C(a0),d0
	move.l	d0,-(a7)
	move.l	$28(a0),a0
	jsr	(a0)
	addq.w	#4,a7
;	NativeScreenDB::close();
	move.l	a3,a0
	cmp.w	#0,a0
	beq.b	L119
L118
	moveq	#$26,d0
	add.l	a3,d0
	move.l	d0,a3
L119
	move.l	a3,-(a7)
	jsr	close__NativeScreenDB__T
	addq.w	#4,a7
	movem.l	(a7)+,a2/a3
	rts

	END
