
; Storm C Compiler
; EXNG:libsrc/plat/amigaos3_68k/gfxlib/pix24.cpp
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
	XREF	blitCopy__Surface__P07SurfacessP07Surfacessss
	XREF	destroy__Surface__T
	XREF	init__Surface__T
	XREF	getHardwareFormat__Native2D__E
	XREF	findIndex__DisplayPropertiesProvider__ssEs
	XREF	getMode__DisplayPropertiesProvider__Ui
	XREF	destroy__ImageBuffer__T
	XREF	runApplication__AppBase__T
	XREF	copy__Mem__r8Pvr9Pvr0Ui
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

	SECTION "copy24XGYTo15BE__Pix24__PvPvPUjssss:0",CODE


;void Pix24::copy24XGYTo15BE(PXARG)
	XDEF	copy24XGYTo15BE__Pix24__PvPvPUjssss
copy24XGYTo15BE__Pix24__PvPvPUjssss
	movem.l	d2-d7/a2,-(a7)
	move.w	$2E(a7),d3
	move.w	$32(a7),d4
	move.w	$30(a7),d5
	move.w	$2C(a7),d7
	move.l	$24(a7),a0
	move.l	$20(a7),a1
L75
;	h++;
	addq.w	#1,d3
; dSpan -= w;
	sub.w	d7,d5
; sSpan -= w;
	sub.w	d7,d4
; sSpan *= 3;
	move.w	d4,d0
	muls	#3,d0
	move.w	d0,d4
;	while(--h)
	bra.b	L80
L76
;		rsint32 x = w+1;
	move.w	d7,d2
	ext.l	d2
	addq.l	#1,d2
;		while(--x)
	bra.b	L78
L77
;			ruint16 pix				=	_XTO15(*((uint8*)src)++);
	moveq	#0,d0
	move.b	(a0)+,d0
	and.l	#$F8,d0
	moveq	#7,d1
	asl.l	d1,d0
	move.w	d0,d1
;			pix							 |=	_GTO15(*((uint8*)src)++);
	moveq	#0,d0
	move.b	(a0)+,d0
	and.l	#$F8,d0
	moveq	#3,d6
	asl.l	d6,d0
	or.w	d0,d1
;			*((uint16*)dst)++	= pix | _YTO15(*((uint8*)src)++);
	moveq	#0,d0
	move.w	d1,d0
	moveq	#0,d1
	move.b	(a0)+,d1
	moveq	#3,d6
	asr.l	d6,d1
	or.l	d1,d0
	move.w	d0,(a1)+
L78
	subq.l	#1,d2
	tst.l	d2
	bne.b	L77
L79
;		((uint16*)dst)+=dSpan;
	move.w	d5,d0
	ext.l	d0
	moveq	#1,d1
	asl.l	d1,d0
	add.l	d0,a1
;		((uint8*)src)+=sSpan;
	move.w	d4,d0
	ext.l	d0
	add.l	d0,a0
L80
	subq.w	#1,d3
	tst.w	d3
	bne.b	L76
L81
	movem.l	(a7)+,d2-d7/a2
	rts

	SECTION "copy24XGYTo15LE__Pix24__PvPvPUjssss:0",CODE


;void Pix24::copy24XGYTo15LE(PXARG)
	XDEF	copy24XGYTo15LE__Pix24__PvPvPUjssss
copy24XGYTo15LE__Pix24__PvPvPUjssss
	movem.l	d2-d7/a2,-(a7)
	move.w	$2E(a7),d3
	move.w	$32(a7),d4
	move.w	$30(a7),d5
	move.w	$2C(a7),d7
	move.l	$24(a7),a0
	move.l	$20(a7),a1
L82
;	h++;
	addq.w	#1,d3
; dSpan -= w;
	sub.w	d7,d5
; sSpan -= w;
	sub.w	d7,d4
; sSpan *= 3;
	move.w	d4,d0
	muls	#3,d0
	move.w	d0,d4
;	while(--h)
	bra.b	L87
L83
;		rsint32 x = w+1;
	move.w	d7,d2
	ext.l	d2
	addq.l	#1,d2
;		while(--x)
	bra.b	L85
L84
;			ruint16 pix				= _XTO15(*((uint8*)src)++);
	moveq	#0,d0
	move.b	(a0)+,d0
	and.l	#$F8,d0
	moveq	#7,d1
	asl.l	d1,d0
;			pix							 |= _GTO15(*((uint8*)src)++);
	moveq	#0,d1
	move.b	(a0)+,d1
	and.l	#$F8,d1
	moveq	#3,d6
	asl.l	d6,d1
	or.w	d1,d0
;			pix							 |= _YTO15(*((uint8*)src)++);
	moveq	#0,d1
	move.b	(a0)+,d1
	moveq	#3,d6
	asr.l	d6,d1
	or.w	d1,d0
;			*((uint16*)dst)++	=	_SWP16(pix);
	moveq	#0,d1
	move.w	d0,d1
	moveq	#$8,d6
	asl.l	d6,d1
	and.l	#$FFFF,d0
	moveq	#$8,d6
	asr.l	d6,d0
	or.l	d0,d1
	move.w	d1,d0
	move.w	d0,(a1)+
L85
	subq.l	#1,d2
	tst.l	d2
	bne.b	L84
L86
;		((uint16*)dst)+=dSpan;
	move.w	d5,d0
	ext.l	d0
	moveq	#1,d1
	asl.l	d1,d0
	add.l	d0,a1
;		((uint8*)src)+=sSpan;
	move.w	d4,d0
	ext.l	d0
	add.l	d0,a0
L87
	subq.w	#1,d3
	tst.w	d3
	bne.b	L83
L88
	movem.l	(a7)+,d2-d7/a2
	rts

	SECTION "rotate24XGYTo15BE__Pix24__PvPvPUjssss:0",CODE


;void Pix24::rotate24XGYTo15BE(PXARG)
	XDEF	rotate24XGYTo15BE__Pix24__PvPvPUjssss
rotate24XGYTo15BE__Pix24__PvPvPUjssss
	movem.l	d2-d7/a2,-(a7)
	move.w	$2E(a7),d3
	move.w	$32(a7),d4
	move.w	$30(a7),d5
	move.w	$2C(a7),d7
	move.l	$24(a7),a0
	move.l	$20(a7),a1
L89
;	h++;
	addq.w	#1,d3
; dSpan -= w;
	sub.w	d7,d5
; sSpan -= w;
	sub.w	d7,d4
; sSpan *= 3;
	move.w	d4,d0
	muls	#3,d0
	move.w	d0,d4
;	while(--h)
	bra.b	L94
L90
;		rsint32 x = w+1;
	move.w	d7,d2
	ext.l	d2
	addq.l	#1,d2
;		while(--x)
	bra.b	L92
L91
;			ruint16 pix				= _YTO15(*((uint8*)src)++);
	moveq	#0,d0
	move.b	(a0)+,d0
	moveq	#3,d1
	asr.l	d1,d0
	move.w	d0,d1
;			pix							 |= _GTO15(*((uint8*)src)++);
	moveq	#0,d0
	move.b	(a0)+,d0
	and.l	#$F8,d0
	moveq	#3,d6
	asl.l	d6,d0
	or.w	d0,d1
;			*((uint16*)dst)++ =	pix | _XTO15(*((uint8*)src)++);
	and.l	#$FFFF,d1
	moveq	#0,d0
	move.b	(a0)+,d0
	and.l	#$F8,d0
	moveq	#7,d6
	asl.l	d6,d0
	or.l	d0,d1
	move.w	d1,d0
	move.w	d0,(a1)+
L92
	subq.l	#1,d2
	tst.l	d2
	bne.b	L91
L93
;		((uint16*)dst)+=dSpan;
	move.w	d5,d0
	ext.l	d0
	moveq	#1,d1
	asl.l	d1,d0
	add.l	d0,a1
;		((uint8*)src)+=sSpan;
	move.w	d4,d0
	ext.l	d0
	add.l	d0,a0
L94
	subq.w	#1,d3
	tst.w	d3
	bne.b	L90
L95
	movem.l	(a7)+,d2-d7/a2
	rts

	SECTION "rotate24XGYTo15LE__Pix24__PvPvPUjssss:0",CODE


;void Pix24::rotate24XGYTo15LE(PXARG)
	XDEF	rotate24XGYTo15LE__Pix24__PvPvPUjssss
rotate24XGYTo15LE__Pix24__PvPvPUjssss
	movem.l	d2-d7/a2,-(a7)
	move.w	$2E(a7),d3
	move.w	$32(a7),d4
	move.w	$30(a7),d5
	move.w	$2C(a7),d7
	move.l	$24(a7),a0
	move.l	$20(a7),a1
L96
;	h++;
	addq.w	#1,d3
; dSpan -= w;
	sub.w	d7,d5
; sSpan -= w;
	sub.w	d7,d4
; sSpan *= 3;
	move.w	d4,d0
	muls	#3,d0
	move.w	d0,d4
;	while(--h)
	bra.b	L101
L97
;		rsint32 x = w+1;
	move.w	d7,d2
	ext.l	d2
	addq.l	#1,d2
;		while(--x)
	bra.b	L99
L98
;			ruint16 pix				= _YTO15(*((uint8*)src)++);
	moveq	#0,d0
	move.b	(a0)+,d0
	moveq	#3,d1
	asr.l	d1,d0
;			pix							 |= _GTO15(*((uint8*)src)++);
	moveq	#0,d1
	move.b	(a0)+,d1
	and.l	#$F8,d1
	moveq	#3,d6
	asl.l	d6,d1
	or.w	d1,d0
;			pix							 |= _XTO15(*((uint8*)src)++);
	moveq	#0,d1
	move.b	(a0)+,d1
	and.l	#$F8,d1
	moveq	#7,d6
	asl.l	d6,d1
	or.w	d1,d0
;			*((uint16*)dst)++	=	_SWP16(pix);
	moveq	#0,d1
	move.w	d0,d1
	moveq	#$8,d6
	asl.l	d6,d1
	and.l	#$FFFF,d0
	moveq	#$8,d6
	asr.l	d6,d0
	or.l	d0,d1
	move.w	d1,d0
	move.w	d0,(a1)+
L99
	subq.l	#1,d2
	tst.l	d2
	bne.b	L98
L100
;		((uint16*)dst)+=dSpan;
	move.w	d5,d0
	ext.l	d0
	moveq	#1,d1
	asl.l	d1,d0
	add.l	d0,a1
;		((uint8*)src)+=sSpan;
	move.w	d4,d0
	ext.l	d0
	add.l	d0,a0
L101
	subq.w	#1,d3
	tst.w	d3
	bne.b	L97
L102
	movem.l	(a7)+,d2-d7/a2
	rts

	SECTION "copy24XGYTo16BE__Pix24__PvPvPUjssss:0",CODE


;void Pix24::copy24XGYTo16BE(PXARG)
	XDEF	copy24XGYTo16BE__Pix24__PvPvPUjssss
copy24XGYTo16BE__Pix24__PvPvPUjssss
	movem.l	d2-d7/a2,-(a7)
	move.w	$2E(a7),d3
	move.w	$32(a7),d4
	move.w	$30(a7),d5
	move.w	$2C(a7),d7
	move.l	$24(a7),a0
	move.l	$20(a7),a1
L103
;	h++;
	addq.w	#1,d3
; dSpan -= w;
	sub.w	d7,d5
; sSpan -= w;
	sub.w	d7,d4
; sSpan *= 3;
	move.w	d4,d0
	muls	#3,d0
	move.w	d0,d4
;	while(--h)
	bra.b	L108
L104
;		rsint32 x = w+1;
	move.w	d7,d2
	ext.l	d2
	addq.l	#1,d2
;		while(--x)
	bra.b	L106
L105
;			ruint16 pix				=	_XTO16(*((uint8*)src)++);
	moveq	#0,d0
	move.b	(a0)+,d0
	and.l	#$F8,d0
	moveq	#$8,d1
	asl.l	d1,d0
	move.w	d0,d1
;			pix							 |=	_GTO16(*((uint8*)src)++);
	moveq	#0,d0
	move.b	(a0)+,d0
	and.l	#$FC,d0
	moveq	#3,d6
	asl.l	d6,d0
	or.w	d0,d1
;			*((uint16*)dst)++	= pix | _YTO16(*((uint8*)src)++);
	moveq	#0,d0
	move.w	d1,d0
	moveq	#0,d1
	move.b	(a0)+,d1
	moveq	#3,d6
	asr.l	d6,d1
	or.l	d1,d0
	move.w	d0,(a1)+
L106
	subq.l	#1,d2
	tst.l	d2
	bne.b	L105
L107
;		((uint16*)dst)+=dSpan;
	move.w	d5,d0
	ext.l	d0
	moveq	#1,d1
	asl.l	d1,d0
	add.l	d0,a1
;		((uint8*)src)+=sSpan;
	move.w	d4,d0
	ext.l	d0
	add.l	d0,a0
L108
	subq.w	#1,d3
	tst.w	d3
	bne.b	L104
L109
	movem.l	(a7)+,d2-d7/a2
	rts

	SECTION "copy24XGYTo16LE__Pix24__PvPvPUjssss:0",CODE


;void Pix24::copy24XGYTo16LE(PXARG)
	XDEF	copy24XGYTo16LE__Pix24__PvPvPUjssss
copy24XGYTo16LE__Pix24__PvPvPUjssss
	movem.l	d2-d7/a2,-(a7)
	move.w	$2E(a7),d3
	move.w	$32(a7),d4
	move.w	$30(a7),d5
	move.w	$2C(a7),d7
	move.l	$24(a7),a0
	move.l	$20(a7),a1
L110
;	h++;
	addq.w	#1,d3
; dSpan -= w;
	sub.w	d7,d5
; sSpan -= w;
	sub.w	d7,d4
; sSpan *= 3;
	move.w	d4,d0
	muls	#3,d0
	move.w	d0,d4
;	while(--h)
	bra.b	L115
L111
;		rsint32 x = w+1;
	move.w	d7,d2
	ext.l	d2
	addq.l	#1,d2
;		while(--x)
	bra.b	L113
L112
;			ruint16 pix				= _XTO15(*((uint8*)src)++);
	moveq	#0,d0
	move.b	(a0)+,d0
	and.l	#$F8,d0
	moveq	#7,d1
	asl.l	d1,d0
;			pix							 |= _GTO15(*((uint8*)src)++);
	moveq	#0,d1
	move.b	(a0)+,d1
	and.l	#$F8,d1
	moveq	#3,d6
	asl.l	d6,d1
	or.w	d1,d0
;			pix							 |= _YTO15(*((uint8*)src)++);
	moveq	#0,d1
	move.b	(a0)+,d1
	moveq	#3,d6
	asr.l	d6,d1
	or.w	d1,d0
;			*((uint16*)dst)++	=	_SWP16(pix);
	moveq	#0,d1
	move.w	d0,d1
	moveq	#$8,d6
	asl.l	d6,d1
	and.l	#$FFFF,d0
	moveq	#$8,d6
	asr.l	d6,d0
	or.l	d0,d1
	move.w	d1,d0
	move.w	d0,(a1)+
L113
	subq.l	#1,d2
	tst.l	d2
	bne.b	L112
L114
;		((uint16*)dst)+=dSpan;
	move.w	d5,d0
	ext.l	d0
	moveq	#1,d1
	asl.l	d1,d0
	add.l	d0,a1
;		((uint8*)src)+=sSpan;
	move.w	d4,d0
	ext.l	d0
	add.l	d0,a0
L115
	subq.w	#1,d3
	tst.w	d3
	bne.b	L111
L116
	movem.l	(a7)+,d2-d7/a2
	rts

	SECTION "rotate24XGYTo16BE__Pix24__PvPvPUjssss:0",CODE


;void Pix24::rotate24XGYTo16BE(PXARG)
	XDEF	rotate24XGYTo16BE__Pix24__PvPvPUjssss
rotate24XGYTo16BE__Pix24__PvPvPUjssss
	movem.l	d2-d7/a2,-(a7)
	move.w	$2E(a7),d3
	move.w	$32(a7),d4
	move.w	$30(a7),d5
	move.w	$2C(a7),d7
	move.l	$24(a7),a0
	move.l	$20(a7),a1
L117
;	h++;
	addq.w	#1,d3
; dSpan -= w;
	sub.w	d7,d5
; sSpan -= w;
	sub.w	d7,d4
; sSpan *= 3;
	move.w	d4,d0
	muls	#3,d0
	move.w	d0,d4
;	while(--h)
	bra.b	L122
L118
;		rsint32 x = w+1;
	move.w	d7,d2
	ext.l	d2
	addq.l	#1,d2
;		while(--x)
	bra.b	L120
L119
;			ruint16 pix				=	_YTO16(*((uint8*)src)++);
	moveq	#0,d0
	move.b	(a0)+,d0
	moveq	#3,d1
	asr.l	d1,d0
	move.w	d0,d1
;			pix							 |=	_GTO16(*((uint8*)src)++);
	moveq	#0,d0
	move.b	(a0)+,d0
	and.l	#$FC,d0
	moveq	#3,d6
	asl.l	d6,d0
	or.w	d0,d1
;			*((uint16*)dst)++	= pix | _XTO16(*((uint8*)src)++);
	and.l	#$FFFF,d1
	moveq	#0,d0
	move.b	(a0)+,d0
	and.l	#$F8,d0
	moveq	#$8,d6
	asl.l	d6,d0
	or.l	d0,d1
	move.w	d1,d0
	move.w	d0,(a1)+
L120
	subq.l	#1,d2
	tst.l	d2
	bne.b	L119
L121
;		((uint16*)dst)+=dSpan;
	move.w	d5,d0
	ext.l	d0
	moveq	#1,d1
	asl.l	d1,d0
	add.l	d0,a1
;		((uint8*)src)+=sSpan;
	move.w	d4,d0
	ext.l	d0
	add.l	d0,a0
L122
	subq.w	#1,d3
	tst.w	d3
	bne.b	L118
L123
	movem.l	(a7)+,d2-d7/a2
	rts

	SECTION "rotate24XGYTo16LE__Pix24__PvPvPUjssss:0",CODE


;void Pix24::rotate24XGYTo16LE(PXARG)
	XDEF	rotate24XGYTo16LE__Pix24__PvPvPUjssss
rotate24XGYTo16LE__Pix24__PvPvPUjssss
	movem.l	d2-d7/a2,-(a7)
	move.w	$2E(a7),d3
	move.w	$32(a7),d4
	move.w	$30(a7),d5
	move.w	$2C(a7),d7
	move.l	$24(a7),a0
	move.l	$20(a7),a1
L124
;	h++;
	addq.w	#1,d3
; dSpan -= w;
	sub.w	d7,d5
; sSpan -= w;
	sub.w	d7,d4
; sSpan *= 3;
	move.w	d4,d0
	muls	#3,d0
	move.w	d0,d4
;	while(--h)
	bra.b	L129
L125
;		rsint32 x = w+1;
	move.w	d7,d2
	ext.l	d2
	addq.l	#1,d2
;		while(--x)
	bra.b	L127
L126
;			ruint16 pix				= _YTO15(*((uint8*)src)++);
	moveq	#0,d0
	move.b	(a0)+,d0
	moveq	#3,d1
	asr.l	d1,d0
;			pix							 |= _GTO15(*((uint8*)src)++);
	moveq	#0,d1
	move.b	(a0)+,d1
	and.l	#$F8,d1
	moveq	#3,d6
	asl.l	d6,d1
	or.w	d1,d0
;			pix							 |= _XTO15(*((uint8*)src)++);
	moveq	#0,d1
	move.b	(a0)+,d1
	and.l	#$F8,d1
	moveq	#7,d6
	asl.l	d6,d1
	or.w	d1,d0
;			*((uint16*)dst)++	=	_SWP16(pix);
	moveq	#0,d1
	move.w	d0,d1
	moveq	#$8,d6
	asl.l	d6,d1
	and.l	#$FFFF,d0
	moveq	#$8,d6
	asr.l	d6,d0
	or.l	d0,d1
	move.w	d1,d0
	move.w	d0,(a1)+
L127
	subq.l	#1,d2
	tst.l	d2
	bne.b	L126
L128
;		((uint16*)dst)+=dSpan;
	move.w	d5,d0
	ext.l	d0
	moveq	#1,d1
	asl.l	d1,d0
	add.l	d0,a1
;		((uint8*)src)+=sSpan;
	move.w	d4,d0
	ext.l	d0
	add.l	d0,a0
L129
	subq.w	#1,d3
	tst.w	d3
	bne.b	L125
L130
	movem.l	(a7)+,d2-d7/a2
	rts

	SECTION "copy24To24__Pix24__PvPvPUjssss:0",CODE


;void Pix24::copy24To24(PXARG)
	XDEF	copy24To24__Pix24__PvPvPUjssss
copy24To24__Pix24__PvPvPUjssss
	movem.l	d2-d5/a2/a3,-(a7)
	move.w	$2A(a7),d2
	move.w	$28(a7),d3
	move.w	$2C(a7),d4
	move.w	$2E(a7),d5
	move.l	$20(a7),a2
	move.l	$1C(a7),a3
L131
;	if (dst==src)
	move.l	a3,a0
	cmp.l	a2,a0
	bne.b	L133
L132
;		return;
	movem.l	(a7)+,d2-d5/a2/a3
	rts
L133
;	else if (dSpan == sSpan && dSpan == w)
	cmp.w	d5,d4
	bne.b	L136
L134
	cmp.w	d3,d4
	bne.b	L136
L135
;		Mem::copy(dst, src, w*h*3);
	move.w	d3,d0
	muls	d2,d0
	muls.l	#3,d0
	move.l	a3,a0
	move.l	a2,a1
	jsr	copy__Mem__r8Pvr9Pvr0Ui
	bra.b	L139
L136
;		dSpan *= 3;
	move.w	d4,d0
	muls	#3,d0
	move.w	d0,d4
; sSpan *= 3;
	move.w	d5,d0
	muls	#3,d0
	move.w	d0,d5
;	w *= 3;
	move.w	d3,d0
	muls	#3,d0
	move.w	d0,d3
;		h++;
	addq.w	#1,d2
;		while (--h)
	bra.b	L138
L137
;			Mem::copy(dst, src, w);
	move.w	d3,d0
	ext.l	d0
	move.l	a3,a0
	move.l	a2,a1
	jsr	copy__Mem__r8Pvr9Pvr0Ui
;			((uint8*)dst)+=dSpan;
	move.w	d4,d0
	ext.l	d0
	add.l	a3,d0
	move.l	d0,a3
;			((uint8*)src)+=sSpan;
	move.w	d5,d0
	ext.l	d0
	add.l	d0,a2
L138
	subq.w	#1,d2
	tst.w	d2
	bne.b	L137
L139
	movem.l	(a7)+,d2-d5/a2/a3
	rts

	SECTION "rotate24To24__Pix24__PvPvPUjssss:0",CODE


;void Pix24::rotate24To24(PXARG)
	XDEF	rotate24To24__Pix24__PvPvPUjssss
rotate24To24__Pix24__PvPvPUjssss
	movem.l	d2-d6/a2,-(a7)
	movem.l	$1C(a7),a0/a1
	move.w	$2A(a7),d2
	move.w	$2E(a7),d3
	move.w	$2C(a7),d4
	move.w	$28(a7),d5
L140
;	dSpan -= w;
	sub.w	d5,d4
; sSpan -= w;
	sub.w	d5,d3
;	dSpan *= 3;
	move.w	d4,d0
	muls	#3,d0
	move.w	d0,d4
; sSpan *= 3;
	move.w	d3,d0
	muls	#3,d0
	move.w	d0,d3
;	h++;
	addq.w	#1,d2
;	while(--h)
	bra.b	L145
L141
;		rsint32 x = w+1;
	move.w	d5,d0
	ext.l	d0
	addq.l	#1,d0
;		while (--x)
	bra.b	L143
L142
;			*((uint8*)dst)++ = ((uint8*)src)[2];
	move.b	2(a1),(a0)+
;			*((uint8*)dst)++ = ((uint8*)src)[1];
	move.b	1(a1),(a0)+
;			*((uint8*)dst)++ = ((uint8*)src)[0];
	move.b	(a1),(a0)+
;			((uint8*)src) += 3;
	addq.w	#3,a1
L143
	subq.l	#1,d0
	tst.l	d0
	bne.b	L142
L144
;		((uint8*)dst)+=dSpan;
	move.w	d4,d0
	ext.l	d0
	add.l	d0,a0
;		((uint8*)src)+=sSpan;
	move.w	d3,d0
	ext.l	d0
	add.l	d0,a1
L145
	subq.w	#1,d2
	tst.w	d2
	bne.b	L141
L146
	movem.l	(a7)+,d2-d6/a2
	rts

	SECTION "copy24XGYTo32BE__Pix24__PvPvPUjssss:0",CODE


;void Pix24::copy24XGYTo32BE(PXARG)
	XDEF	copy24XGYTo32BE__Pix24__PvPvPUjssss
copy24XGYTo32BE__Pix24__PvPvPUjssss
	movem.l	d2-d7/a2,-(a7)
	move.w	$2E(a7),d3
	move.w	$32(a7),d4
	move.w	$30(a7),d5
	move.w	$2C(a7),d7
	move.l	$24(a7),a0
	move.l	$20(a7),a1
L147
;	h++;
	addq.w	#1,d3
; dSpan -= w;
	sub.w	d7,d5
; sSpan -= w;
	sub.w	d7,d4
; sSpan *= 3;
	move.w	d4,d0
	muls	#3,d0
	move.w	d0,d4
;	while(--h)
	bra.b	L152
L148
;		rsint32 x = w+1;
	move.w	d7,d2
	ext.l	d2
	addq.l	#1,d2
;		while(--x)
	bra.b	L150
L149
;			ruint32 pix				=	(*((uint8*)src)++)<<16;
	moveq	#0,d0
	move.b	(a0)+,d0
	moveq	#$10,d1
	asl.l	d1,d0
;			pix							 |=	(*((uint8*)src)++)<<8;
	moveq	#0,d1
	move.b	(a0)+,d1
	moveq	#$8,d6
	asl.l	d6,d1
	or.l	d1,d0
;			*((uint32*)dst)++	= pix | (*((uint8*)src)++);
	moveq	#0,d1
	move.b	(a0)+,d1
	or.l	d1,d0
	move.l	d0,(a1)+
L150
	subq.l	#1,d2
	tst.l	d2
	bne.b	L149
L151
;		((uint32*)dst)+=dSpan;
	move.w	d5,d0
	ext.l	d0
	moveq	#2,d1
	asl.l	d1,d0
	add.l	d0,a1
;		((uint8*)src)+=sSpan;
	move.w	d4,d0
	ext.l	d0
	add.l	d0,a0
L152
	subq.w	#1,d3
	tst.w	d3
	bne.b	L148
L153
	movem.l	(a7)+,d2-d7/a2
	rts

	SECTION "copy24XGYTo32LE__Pix24__PvPvPUjssss:0",CODE


;void Pix24::copy24XGYTo32LE(PXARG)
	XDEF	copy24XGYTo32LE__Pix24__PvPvPUjssss
copy24XGYTo32LE__Pix24__PvPvPUjssss
	movem.l	d2-d7/a2,-(a7)
	move.w	$2E(a7),d3
	move.w	$32(a7),d4
	move.w	$30(a7),d5
	move.w	$2C(a7),d7
	move.l	$24(a7),a0
	move.l	$20(a7),a1
L154
;	h++;
	addq.w	#1,d3
; dSpan -= w;
	sub.w	d7,d5
; sSpan -= w;
	sub.w	d7,d4
; sSpan *= 3;
	move.w	d4,d0
	muls	#3,d0
	move.w	d0,d4
;	while(--h)
	bra.b	L159
L155
;		rsint32 x = w+1;
	move.w	d7,d2
	ext.l	d2
	addq.l	#1,d2
;		while(--x)
	bra.b	L157
L156
;			ruint32 pix				= (*((uint8*)src)++)<<8;
	moveq	#0,d0
	move.b	(a0)+,d0
	moveq	#$8,d1
	asl.l	d1,d0
;			pix							 |= (*((uint8*)src)++)<<16;
	moveq	#0,d1
	move.b	(a0)+,d1
	moveq	#$10,d6
	asl.l	d6,d1
	or.l	d1,d0
;			*((uint32*)dst)++	= pix | (*((uint8*)src)++)<<24;
	moveq	#0,d1
	move.b	(a0)+,d1
	moveq	#$18,d6
	asl.l	d6,d1
	or.l	d1,d0
	move.l	d0,(a1)+
L157
	subq.l	#1,d2
	tst.l	d2
	bne.b	L156
L158
;		((uint32*)dst)+=dSpan;
	move.w	d5,d0
	ext.l	d0
	moveq	#2,d1
	asl.l	d1,d0
	add.l	d0,a1
;		((uint8*)src)+=sSpan;
	move.w	d4,d0
	ext.l	d0
	add.l	d0,a0
L159
	subq.w	#1,d3
	tst.w	d3
	bne.b	L155
L160
	movem.l	(a7)+,d2-d7/a2
	rts

	SECTION "rotate24XGYTo32BE__Pix24__PvPvPUjssss:0",CODE


;void Pix24::rotate24XGYTo32BE(PXARG)
	XDEF	rotate24XGYTo32BE__Pix24__PvPvPUjssss
rotate24XGYTo32BE__Pix24__PvPvPUjssss
	movem.l	d2-d7/a2,-(a7)
	move.w	$2E(a7),d3
	move.w	$32(a7),d4
	move.w	$30(a7),d5
	move.w	$2C(a7),d7
	move.l	$24(a7),a0
	move.l	$20(a7),a1
L161
;	h++;
	addq.w	#1,d3
; dSpan -= w;
	sub.w	d7,d5
; sSpan -= w;
	sub.w	d7,d4
; sSpan *= 3;
	move.w	d4,d0
	muls	#3,d0
	move.w	d0,d4
;	while(--h)
	bra.b	L166
L162
;		rsint32 x = w+1;
	move.w	d7,d2
	ext.l	d2
	addq.l	#1,d2
;		while(--x)
	bra.b	L164
L163
;			ruint32 pix				= *((uint8*)src)++;
	moveq	#0,d0
	move.b	(a0)+,d0
;			pix							 |= (*((uint8*)src)++)<<8;
	moveq	#0,d1
	move.b	(a0)+,d1
	moveq	#$8,d6
	asl.l	d6,d1
	or.l	d1,d0
;			*((uint32*)dst)++	= pix | (*((uint8*)src)++)<<16;
	moveq	#0,d1
	move.b	(a0)+,d1
	moveq	#$10,d6
	asl.l	d6,d1
	or.l	d1,d0
	move.l	d0,(a1)+
L164
	subq.l	#1,d2
	tst.l	d2
	bne.b	L163
L165
;		((uint32*)dst)+=dSpan;
	move.w	d5,d0
	ext.l	d0
	moveq	#2,d1
	asl.l	d1,d0
	add.l	d0,a1
;		((uint8*)src)+=sSpan;
	move.w	d4,d0
	ext.l	d0
	add.l	d0,a0
L166
	subq.w	#1,d3
	tst.w	d3
	bne.b	L162
L167
	movem.l	(a7)+,d2-d7/a2
	rts

	SECTION "rotate24XGYTo32LE__Pix24__PvPvPUjssss:0",CODE


;void Pix24::rotate24XGYTo32LE(PXARG)
	XDEF	rotate24XGYTo32LE__Pix24__PvPvPUjssss
rotate24XGYTo32LE__Pix24__PvPvPUjssss
	movem.l	d2-d7/a2,-(a7)
	move.w	$2E(a7),d3
	move.w	$32(a7),d4
	move.w	$30(a7),d5
	move.w	$2C(a7),d7
	move.l	$24(a7),a0
	move.l	$20(a7),a1
L168
;	h++;
	addq.w	#1,d3
; dSpan -= w;
	sub.w	d7,d5
; sSpan -= w;
	sub.w	d7,d4
; sSpan *= 3;
	move.w	d4,d0
	muls	#3,d0
	move.w	d0,d4
;	while(--h)
	bra.b	L173
L169
;		rsint32 x = w+1;
	move.w	d7,d2
	ext.l	d2
	addq.l	#1,d2
;		while(--x)
	bra.b	L171
L170
;			ruint32 pix				= (*((uint8*)src)++)<<24;
	moveq	#0,d0
	move.b	(a0)+,d0
	moveq	#$18,d1
	asl.l	d1,d0
;			pix							 |= (*((uint8*)src)++)<<16;
	moveq	#0,d1
	move.b	(a0)+,d1
	moveq	#$10,d6
	asl.l	d6,d1
	or.l	d1,d0
;			*((uint32*)dst)++	= pix | (*((uint8*)src)++)<<8;
	moveq	#0,d1
	move.b	(a0)+,d1
	moveq	#$8,d6
	asl.l	d6,d1
	or.l	d1,d0
	move.l	d0,(a1)+
L171
	subq.l	#1,d2
	tst.l	d2
	bne.b	L170
L172
;		((uint32*)dst)+=dSpan;
	move.w	d5,d0
	ext.l	d0
	moveq	#2,d1
	asl.l	d1,d0
	add.l	d0,a1
;		((uint8*)src)+=sSpan;
	move.w	d4,d0
	ext.l	d0
	add.l	d0,a0
L173
	subq.w	#1,d3
	tst.w	d3
	bne.b	L169
L174
	movem.l	(a7)+,d2-d7/a2
	rts

	END
