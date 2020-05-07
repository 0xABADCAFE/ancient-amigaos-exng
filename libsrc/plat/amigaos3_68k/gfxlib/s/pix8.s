
; Storm C Compiler
; exng:libsrc/plat/amigaos3_68k/gfxlib/pix8.cpp
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
	XREF	rotate32BETo32LE__Pix32__PvPvPUjssss
	XREF	rotate32BETo32BE__Pix32__PvPvPUjssss
	XREF	rotate32BETo16LE__Pix32__PvPvPUjssss
	XREF	rotate32BETo16BE__Pix32__PvPvPUjssss
	XREF	copy32BETo16LE__Pix32__PvPvPUjssss
	XREF	copy32BETo16BE__Pix32__PvPvPUjssss
	XREF	rotate32BETo15LE__Pix32__PvPvPUjssss
	XREF	rotate32BETo15BE__Pix32__PvPvPUjssss
	XREF	copy32BETo15LE__Pix32__PvPvPUjssss
	XREF	copy32BETo15BE__Pix32__PvPvPUjssss
	XREF	getHardwareFormat__Native2D__E
	XREF	findIndex__DisplayPropertiesProvider__ssEs
	XREF	getMode__DisplayPropertiesProvider__Ui
	XREF	destroy__ImageBuffer__T
	XREF	runApplication__AppBase__T
	XREF	swap32__Mem__r8Pvr9Pvr0Ui
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

	SECTION "convRGB15BE__Pix8__PvPvPUjssss:0",CODE


;void Pix8::convRGB15BE(PXARG)
	XDEF	convRGB15BE__Pix8__PvPvPUjssss
convRGB15BE__Pix8__PvPvPUjssss
L80	EQU	-$204
	link	a5,#L80
	movem.l	d2-d6/a2/a3,-(a7)
	move.w	$16(a5),d2
	move.w	$1A(a5),d3
	move.w	$18(a5),d4
	move.w	$14(a5),d5
	move.l	$10(a5),a0
	move.l	$8(a5),a2
	move.l	$C(a5),a3
L73
;	Pix32::copy32BETo15BE(pal, sPal, 0, 256, 1, 256, 256);
	move.w	#$100,-(a7)
	move.w	#$100,-(a7)
	move.w	#1,-(a7)
	move.w	#$100,-(a7)
	clr.l	-(a7)
	move.l	a0,-(a7)
	pea	-$200(a5)
	jsr	copy32BETo15BE__Pix32__PvPvPUjssss
	add.w	#$14,a7
;	h++;
	addq.w	#1,d2
; dSpan -= w;
	sub.w	d5,d4
; sSpan -= w;
	sub.w	d5,d3
;	while (--h)
	bra.b	L78
L74
;		rsint32 x = w+1;
	move.w	d5,d0
	ext.l	d0
	addq.l	#1,d0
;		while (--x)
	bra.b	L76
L75
;			*((uint16*)dst)++ = pal[*((uint8*)src)++];
	moveq	#0,d1
	move.b	(a3)+,d1
	lea	-$200(a5),a1
	move.w	0(a1,d1.l*2),(a2)+
L76
	subq.l	#1,d0
	tst.l	d0
	bne.b	L75
L77
;		((uint16*)dst)	+= dSpan;
	move.w	d4,d0
	ext.l	d0
	moveq	#1,d1
	asl.l	d1,d0
	add.l	d0,a2
;		((uint8*)src)		+= sSpan;
	move.w	d3,d0
	ext.l	d0
	add.l	a3,d0
	move.l	d0,a3
L78
	subq.w	#1,d2
	tst.w	d2
	bne.b	L74
L79
	movem.l	(a7)+,d2-d6/a2/a3
	unlk	a5
	rts

	SECTION "convBGR15BE__Pix8__PvPvPUjssss:0",CODE


;void Pix8::convBGR15BE(PXARG)
	XDEF	convBGR15BE__Pix8__PvPvPUjssss
convBGR15BE__Pix8__PvPvPUjssss
L88	EQU	-$204
	link	a5,#L88
	movem.l	d2-d6/a2/a3,-(a7)
	move.w	$16(a5),d2
	move.w	$1A(a5),d3
	move.w	$18(a5),d4
	move.w	$14(a5),d5
	move.l	$10(a5),a0
	move.l	$8(a5),a2
	move.l	$C(a5),a3
L81
;	Pix32::rotate32BETo15BE(pal, sPal, 0, 256, 1, 256, 256);
	move.w	#$100,-(a7)
	move.w	#$100,-(a7)
	move.w	#1,-(a7)
	move.w	#$100,-(a7)
	clr.l	-(a7)
	move.l	a0,-(a7)
	pea	-$200(a5)
	jsr	rotate32BETo15BE__Pix32__PvPvPUjssss
	add.w	#$14,a7
;	h++;
	addq.w	#1,d2
; dSpan -= w;
	sub.w	d5,d4
; sSpan -= w;
	sub.w	d5,d3
;	while (--h)
	bra.b	L86
L82
;		rsint32 x = w+1;
	move.w	d5,d0
	ext.l	d0
	addq.l	#1,d0
;		while (--x)
	bra.b	L84
L83
;			*((uint16*)dst)++ = pal[*((uint8*)src)++];
	moveq	#0,d1
	move.b	(a3)+,d1
	lea	-$200(a5),a1
	move.w	0(a1,d1.l*2),(a2)+
L84
	subq.l	#1,d0
	tst.l	d0
	bne.b	L83
L85
;		((uint16*)dst)	+= dSpan;
	move.w	d4,d0
	ext.l	d0
	moveq	#1,d1
	asl.l	d1,d0
	add.l	d0,a2
;		((uint8*)src)		+= sSpan;
	move.w	d3,d0
	ext.l	d0
	add.l	a3,d0
	move.l	d0,a3
L86
	subq.w	#1,d2
	tst.w	d2
	bne.b	L82
L87
	movem.l	(a7)+,d2-d6/a2/a3
	unlk	a5
	rts

	SECTION "convRGB15LE__Pix8__PvPvPUjssss:0",CODE


;void Pix8::convRGB15LE(PXARG)
	XDEF	convRGB15LE__Pix8__PvPvPUjssss
convRGB15LE__Pix8__PvPvPUjssss
L96	EQU	-$204
	link	a5,#L96
	movem.l	d2-d6/a2/a3,-(a7)
	move.w	$16(a5),d2
	move.w	$1A(a5),d3
	move.w	$18(a5),d4
	move.w	$14(a5),d5
	move.l	$10(a5),a0
	move.l	$8(a5),a2
	move.l	$C(a5),a3
L89
;	Pix32::copy32BETo15LE(pal, sPal, 0, 256, 1, 256, 256);
	move.w	#$100,-(a7)
	move.w	#$100,-(a7)
	move.w	#1,-(a7)
	move.w	#$100,-(a7)
	clr.l	-(a7)
	move.l	a0,-(a7)
	pea	-$200(a5)
	jsr	copy32BETo15LE__Pix32__PvPvPUjssss
	add.w	#$14,a7
;	h++;
	addq.w	#1,d2
; dSpan -= w;
	sub.w	d5,d4
; sSpan -= w;
	sub.w	d5,d3
;	while (--h)
	bra.b	L94
L90
;		rsint32 x = w+1;
	move.w	d5,d0
	ext.l	d0
	addq.l	#1,d0
;		while (--x)
	bra.b	L92
L91
;			*((uint16*)dst)++ = pal[*((uint8*)src)++];
	moveq	#0,d1
	move.b	(a3)+,d1
	lea	-$200(a5),a1
	move.w	0(a1,d1.l*2),(a2)+
L92
	subq.l	#1,d0
	tst.l	d0
	bne.b	L91
L93
;		((uint16*)dst)	+= dSpan;
	move.w	d4,d0
	ext.l	d0
	moveq	#1,d1
	asl.l	d1,d0
	add.l	d0,a2
;		((uint8*)src)		+= sSpan;
	move.w	d3,d0
	ext.l	d0
	add.l	a3,d0
	move.l	d0,a3
L94
	subq.w	#1,d2
	tst.w	d2
	bne.b	L90
L95
	movem.l	(a7)+,d2-d6/a2/a3
	unlk	a5
	rts

	SECTION "convBGR15LE__Pix8__PvPvPUjssss:0",CODE


;void Pix8::convBGR15LE(PXARG)
	XDEF	convBGR15LE__Pix8__PvPvPUjssss
convBGR15LE__Pix8__PvPvPUjssss
L104	EQU	-$204
	link	a5,#L104
	movem.l	d2-d6/a2/a3,-(a7)
	move.w	$16(a5),d2
	move.w	$1A(a5),d3
	move.w	$18(a5),d4
	move.w	$14(a5),d5
	move.l	$10(a5),a0
	move.l	$8(a5),a2
	move.l	$C(a5),a3
L97
;	Pix32::rotate32BETo15LE(pal, sPal, 0, 256, 1, 256, 256);
	move.w	#$100,-(a7)
	move.w	#$100,-(a7)
	move.w	#1,-(a7)
	move.w	#$100,-(a7)
	clr.l	-(a7)
	move.l	a0,-(a7)
	pea	-$200(a5)
	jsr	rotate32BETo15LE__Pix32__PvPvPUjssss
	add.w	#$14,a7
;	h++;
	addq.w	#1,d2
; dSpan -= w;
	sub.w	d5,d4
; sSpan -= w;
	sub.w	d5,d3
;	while (--h)
	bra.b	L102
L98
;		rsint32 x = w+1;
	move.w	d5,d0
	ext.l	d0
	addq.l	#1,d0
;		while (--x)
	bra.b	L100
L99
;			*((uint16*)dst)++ = pal[*((uint8*)src)++];
	moveq	#0,d1
	move.b	(a3)+,d1
	lea	-$200(a5),a1
	move.w	0(a1,d1.l*2),(a2)+
L100
	subq.l	#1,d0
	tst.l	d0
	bne.b	L99
L101
;		((uint16*)dst)	+= dSpan;
	move.w	d4,d0
	ext.l	d0
	moveq	#1,d1
	asl.l	d1,d0
	add.l	d0,a2
;		((uint8*)src)		+= sSpan;
	move.w	d3,d0
	ext.l	d0
	add.l	a3,d0
	move.l	d0,a3
L102
	subq.w	#1,d2
	tst.w	d2
	bne.b	L98
L103
	movem.l	(a7)+,d2-d6/a2/a3
	unlk	a5
	rts

	SECTION "convRGB16BE__Pix8__PvPvPUjssss:0",CODE


;void Pix8::convRGB16BE(PXARG)
	XDEF	convRGB16BE__Pix8__PvPvPUjssss
convRGB16BE__Pix8__PvPvPUjssss
L112	EQU	-$204
	link	a5,#L112
	movem.l	d2-d6/a2/a3,-(a7)
	move.w	$16(a5),d2
	move.w	$1A(a5),d3
	move.w	$18(a5),d4
	move.w	$14(a5),d5
	move.l	$10(a5),a0
	move.l	$8(a5),a2
	move.l	$C(a5),a3
L105
;	Pix32::copy32BETo16BE(pal, sPal, 0, 256, 1, 256, 256);
	move.w	#$100,-(a7)
	move.w	#$100,-(a7)
	move.w	#1,-(a7)
	move.w	#$100,-(a7)
	clr.l	-(a7)
	move.l	a0,-(a7)
	pea	-$200(a5)
	jsr	copy32BETo16BE__Pix32__PvPvPUjssss
	add.w	#$14,a7
;	h++;
	addq.w	#1,d2
; dSpan -= w;
	sub.w	d5,d4
; sSpan -= w;
	sub.w	d5,d3
;	while (--h)
	bra.b	L110
L106
;		rsint32 x = w+1;
	move.w	d5,d0
	ext.l	d0
	addq.l	#1,d0
;		while (--x)
	bra.b	L108
L107
;			*((uint16*)dst)++ = pal[*((uint8*)src)++];
	moveq	#0,d1
	move.b	(a3)+,d1
	lea	-$200(a5),a1
	move.w	0(a1,d1.l*2),(a2)+
L108
	subq.l	#1,d0
	tst.l	d0
	bne.b	L107
L109
;		((uint16*)dst)	+= dSpan;
	move.w	d4,d0
	ext.l	d0
	moveq	#1,d1
	asl.l	d1,d0
	add.l	d0,a2
;		((uint8*)src)		+= sSpan;
	move.w	d3,d0
	ext.l	d0
	add.l	a3,d0
	move.l	d0,a3
L110
	subq.w	#1,d2
	tst.w	d2
	bne.b	L106
L111
	movem.l	(a7)+,d2-d6/a2/a3
	unlk	a5
	rts

	SECTION "convBGR16BE__Pix8__PvPvPUjssss:0",CODE


;void Pix8::convBGR16BE(PXARG)
	XDEF	convBGR16BE__Pix8__PvPvPUjssss
convBGR16BE__Pix8__PvPvPUjssss
L120	EQU	-$204
	link	a5,#L120
	movem.l	d2-d6/a2/a3,-(a7)
	move.w	$16(a5),d2
	move.w	$1A(a5),d3
	move.w	$18(a5),d4
	move.w	$14(a5),d5
	move.l	$10(a5),a0
	move.l	$8(a5),a2
	move.l	$C(a5),a3
L113
;	Pix32::rotate32BETo16BE(pal, sPal, 0, 256, 1, 256, 256);
	move.w	#$100,-(a7)
	move.w	#$100,-(a7)
	move.w	#1,-(a7)
	move.w	#$100,-(a7)
	clr.l	-(a7)
	move.l	a0,-(a7)
	pea	-$200(a5)
	jsr	rotate32BETo16BE__Pix32__PvPvPUjssss
	add.w	#$14,a7
;	h++;
	addq.w	#1,d2
; dSpan -= w;
	sub.w	d5,d4
; sSpan -= w;
	sub.w	d5,d3
;	while (--h)
	bra.b	L118
L114
;		rsint32 x = w+1;
	move.w	d5,d0
	ext.l	d0
	addq.l	#1,d0
;		while (--x)
	bra.b	L116
L115
;			*((uint16*)dst)++ = pal[*((uint8*)src)++];
	moveq	#0,d1
	move.b	(a3)+,d1
	lea	-$200(a5),a1
	move.w	0(a1,d1.l*2),(a2)+
L116
	subq.l	#1,d0
	tst.l	d0
	bne.b	L115
L117
;		((uint16*)dst)	+= dSpan;
	move.w	d4,d0
	ext.l	d0
	moveq	#1,d1
	asl.l	d1,d0
	add.l	d0,a2
;		((uint8*)src)		+= sSpan;
	move.w	d3,d0
	ext.l	d0
	add.l	a3,d0
	move.l	d0,a3
L118
	subq.w	#1,d2
	tst.w	d2
	bne.b	L114
L119
	movem.l	(a7)+,d2-d6/a2/a3
	unlk	a5
	rts

	SECTION "convRGB16LE__Pix8__PvPvPUjssss:0",CODE


;void Pix8::convRGB16LE(PXARG)
	XDEF	convRGB16LE__Pix8__PvPvPUjssss
convRGB16LE__Pix8__PvPvPUjssss
L128	EQU	-$204
	link	a5,#L128
	movem.l	d2-d6/a2/a3,-(a7)
	move.w	$16(a5),d2
	move.w	$1A(a5),d3
	move.w	$18(a5),d4
	move.w	$14(a5),d5
	move.l	$10(a5),a0
	move.l	$8(a5),a2
	move.l	$C(a5),a3
L121
;	Pix32::copy32BETo16LE(pal, sPal, 0, 256, 1, 256, 256);
	move.w	#$100,-(a7)
	move.w	#$100,-(a7)
	move.w	#1,-(a7)
	move.w	#$100,-(a7)
	clr.l	-(a7)
	move.l	a0,-(a7)
	pea	-$200(a5)
	jsr	copy32BETo16LE__Pix32__PvPvPUjssss
	add.w	#$14,a7
;	h++;
	addq.w	#1,d2
; dSpan -= w;
	sub.w	d5,d4
; sSpan -= w;
	sub.w	d5,d3
;	while (--h)
	bra.b	L126
L122
;		rsint32 x = w+1;
	move.w	d5,d0
	ext.l	d0
	addq.l	#1,d0
;		while (--x)
	bra.b	L124
L123
;			*((uint16*)dst)++ = pal[*((uint8*)src)++];
	moveq	#0,d1
	move.b	(a3)+,d1
	lea	-$200(a5),a1
	move.w	0(a1,d1.l*2),(a2)+
L124
	subq.l	#1,d0
	tst.l	d0
	bne.b	L123
L125
;		((uint16*)dst)	+= dSpan;
	move.w	d4,d0
	ext.l	d0
	moveq	#1,d1
	asl.l	d1,d0
	add.l	d0,a2
;		((uint8*)src)		+= sSpan;
	move.w	d3,d0
	ext.l	d0
	add.l	a3,d0
	move.l	d0,a3
L126
	subq.w	#1,d2
	tst.w	d2
	bne.b	L122
L127
	movem.l	(a7)+,d2-d6/a2/a3
	unlk	a5
	rts

	SECTION "convBGR16LE__Pix8__PvPvPUjssss:0",CODE


;void Pix8::convBGR16LE(PXARG)
	XDEF	convBGR16LE__Pix8__PvPvPUjssss
convBGR16LE__Pix8__PvPvPUjssss
L136	EQU	-$204
	link	a5,#L136
	movem.l	d2-d6/a2/a3,-(a7)
	move.w	$16(a5),d2
	move.w	$1A(a5),d3
	move.w	$18(a5),d4
	move.w	$14(a5),d5
	move.l	$10(a5),a0
	move.l	$8(a5),a2
	move.l	$C(a5),a3
L129
;	Pix32::rotate32BETo16LE(pal, sPal, 0, 256, 1, 256, 256);
	move.w	#$100,-(a7)
	move.w	#$100,-(a7)
	move.w	#1,-(a7)
	move.w	#$100,-(a7)
	clr.l	-(a7)
	move.l	a0,-(a7)
	pea	-$200(a5)
	jsr	rotate32BETo16LE__Pix32__PvPvPUjssss
	add.w	#$14,a7
;	h++;
	addq.w	#1,d2
; dSpan -= w;
	sub.w	d5,d4
; sSpan -= w;
	sub.w	d5,d3
;	while (--h)
	bra.b	L134
L130
;		rsint32 x = w+1;
	move.w	d5,d0
	ext.l	d0
	addq.l	#1,d0
;		while (--x)
	bra.b	L132
L131
;			*((uint16*)dst)++ = pal[*((uint8*)src)++];
	moveq	#0,d1
	move.b	(a3)+,d1
	lea	-$200(a5),a1
	move.w	0(a1,d1.l*2),(a2)+
L132
	subq.l	#1,d0
	tst.l	d0
	bne.b	L131
L133
;		((uint16*)dst)	+= dSpan;
	move.w	d4,d0
	ext.l	d0
	moveq	#1,d1
	asl.l	d1,d0
	add.l	d0,a2
;		((uint8*)src)		+= sSpan;
	move.w	d3,d0
	ext.l	d0
	add.l	a3,d0
	move.l	d0,a3
L134
	subq.w	#1,d2
	tst.w	d2
	bne.b	L130
L135
	movem.l	(a7)+,d2-d6/a2/a3
	unlk	a5
	rts

	SECTION "convRGB24__Pix8__PvPvPUjssss:0",CODE


;void Pix8::convRGB24(PXARG)
	XDEF	convRGB24__Pix8__PvPvPUjssss
convRGB24__Pix8__PvPvPUjssss
	movem.l	d2-d6/a2/a3,-(a7)
	movem.l	$20(a7),a0-a2
	move.w	$2E(a7),d2
	move.w	$32(a7),d3
	move.w	$30(a7),d4
	move.w	$2C(a7),d5
L137
;	h++;
	addq.w	#1,d2
; dSpan -= w;
	sub.w	d5,d4
; sSpan -= w;
	sub.w	d5,d3
;	while (--h)
	bra.b	L142
L138
;		rsint32 x = w+1;
	move.w	d5,d0
	ext.l	d0
	addq.l	#1,d0
;		while (--x)
	bra.b	L140
L139
;			*((uint8*)dst)++ = sPal[*((uint8*)src)+1];
	moveq	#0,d1
	move.b	(a1),d1
	lea	4(a2),a3
	move.b	3(a3,d1.l*4),d1
	move.b	d1,(a0)+
;			*((uint8*)dst)++ = sPal[*((uint8*)src)+2];
	moveq	#0,d1
	move.b	(a1),d1
	lea	$8(a2),a3
	move.b	3(a3,d1.l*4),d1
	move.b	d1,(a0)+
;			*((uint8*)dst)++ = sPal[*((uint8*)src)+3];
	moveq	#0,d1
	move.b	(a1),d1
	lea	$C(a2),a3
	move.b	3(a3,d1.l*4),d1
	move.b	d1,(a0)+
;			((uint8*)src)++;
	addq.w	#1,a1
L140
	subq.l	#1,d0
	tst.l	d0
	bne.b	L139
L141
;		((uint32*)dst)	+= dSpan;
	move.w	d4,d0
	ext.l	d0
	moveq	#2,d1
	asl.l	d1,d0
	add.l	d0,a0
;		((uint8*)src)		+= sSpan;
	move.w	d3,d0
	ext.l	d0
	add.l	d0,a1
L142
	subq.w	#1,d2
	tst.w	d2
	bne.b	L138
L143
	movem.l	(a7)+,d2-d6/a2/a3
	rts

	SECTION "convBGR24__Pix8__PvPvPUjssss:0",CODE


;void Pix8::convBGR24(PXARG)
	XDEF	convBGR24__Pix8__PvPvPUjssss
convBGR24__Pix8__PvPvPUjssss
	movem.l	d2-d6/a2/a3,-(a7)
	movem.l	$20(a7),a0-a2
	move.w	$2E(a7),d2
	move.w	$32(a7),d3
	move.w	$30(a7),d4
	move.w	$2C(a7),d5
L144
;	h++;
	addq.w	#1,d2
; dSpan -= w;
	sub.w	d5,d4
; sSpan -= w;
	sub.w	d5,d3
;	while (--h)
	bra.b	L149
L145
;		rsint32 x = w+1;
	move.w	d5,d0
	ext.l	d0
	addq.l	#1,d0
;		while (--x)
	bra.b	L147
L146
;			*((uint8*)dst)++ = sPal[*((uint8*)src)+3];
	moveq	#0,d1
	move.b	(a1),d1
	lea	$C(a2),a3
	move.b	3(a3,d1.l*4),d1
	move.b	d1,(a0)+
;			*((uint8*)dst)++ = sPal[*((uint8*)src)+2];
	moveq	#0,d1
	move.b	(a1),d1
	lea	$8(a2),a3
	move.b	3(a3,d1.l*4),d1
	move.b	d1,(a0)+
;			*((uint8*)dst)++ = sPal[*((uint8*)src)+1];
	moveq	#0,d1
	move.b	(a1),d1
	lea	4(a2),a3
	move.b	3(a3,d1.l*4),d1
	move.b	d1,(a0)+
;			((uint8*)src)++;
	addq.w	#1,a1
L147
	subq.l	#1,d0
	tst.l	d0
	bne.b	L146
L148
;		((uint32*)dst)	+= dSpan;
	move.w	d4,d0
	ext.l	d0
	moveq	#2,d1
	asl.l	d1,d0
	add.l	d0,a0
;		((uint8*)src)		+= sSpan;
	move.w	d3,d0
	ext.l	d0
	add.l	d0,a1
L149
	subq.w	#1,d2
	tst.w	d2
	bne.b	L145
L150
	movem.l	(a7)+,d2-d6/a2/a3
	rts

	SECTION "convARGB32BE__Pix8__PvPvPUjssss:0",CODE


;void Pix8::convARGB32BE(PXARG)
	XDEF	convARGB32BE__Pix8__PvPvPUjssss
convARGB32BE__Pix8__PvPvPUjssss
	movem.l	d2-d6/a2/a3,-(a7)
	movem.l	$20(a7),a0/a1/a3
	move.w	$2E(a7),d2
	move.w	$32(a7),d3
	move.w	$30(a7),d4
	move.w	$2C(a7),d5
L151
;	h++;
	addq.w	#1,d2
; dSpan -= w;
	sub.w	d5,d4
; sSpan -= w;
	sub.w	d5,d3
;	while (--h)
	bra.b	L156
L152
;		rsint32 x = w+1;
	move.w	d5,d0
	ext.l	d0
	addq.l	#1,d0
;		while (--x)
	bra.b	L154
L153
;			*((uint32*)dst)++ = sPal[*((uint8*)src)++];
	moveq	#0,d1
	move.b	(a1)+,d1
	move.l	0(a3,d1.l*4),(a0)+
L154
	subq.l	#1,d0
	tst.l	d0
	bne.b	L153
L155
;		((uint32*)dst)	+= dSpan;
	move.w	d4,d0
	ext.l	d0
	moveq	#2,d1
	asl.l	d1,d0
	add.l	d0,a0
;		((uint8*)src)		+= sSpan;
	move.w	d3,d0
	ext.l	d0
	add.l	d0,a1
L156
	subq.w	#1,d2
	tst.w	d2
	bne.b	L152
L157
	movem.l	(a7)+,d2-d6/a2/a3
	rts

	SECTION "convABGR32BE__Pix8__PvPvPUjssss:0",CODE


;void Pix8::convABGR32BE(PXARG)
	XDEF	convABGR32BE__Pix8__PvPvPUjssss
convABGR32BE__Pix8__PvPvPUjssss
L165	EQU	-$404
	link	a5,#L165
	movem.l	d2-d6/a2/a3,-(a7)
	move.w	$16(a5),d2
	move.w	$1A(a5),d3
	move.w	$18(a5),d4
	move.w	$14(a5),d5
	move.l	$10(a5),a0
	move.l	$8(a5),a2
	move.l	$C(a5),a3
L158
;	Pix32::rotate32BETo32BE(pal, sPal, 0, 256, 1, 256, 256);
	move.w	#$100,-(a7)
	move.w	#$100,-(a7)
	move.w	#1,-(a7)
	move.w	#$100,-(a7)
	clr.l	-(a7)
	move.l	a0,-(a7)
	pea	-$400(a5)
	jsr	rotate32BETo32BE__Pix32__PvPvPUjssss
	add.w	#$14,a7
;	h++;
	addq.w	#1,d2
; dSpan -= w;
	sub.w	d5,d4
; sSpan -= w;
	sub.w	d5,d3
;	while (--h)
	bra.b	L163
L159
;		rsint32 x = w+1;
	move.w	d5,d0
	ext.l	d0
	addq.l	#1,d0
;		while (--x)
	bra.b	L161
L160
;			*((uint32*)dst)++ = pal[*((uint8*)src)++];
	moveq	#0,d1
	move.b	(a3)+,d1
	lea	-$400(a5),a1
	move.l	0(a1,d1.l*4),(a2)+
L161
	subq.l	#1,d0
	tst.l	d0
	bne.b	L160
L162
;		((uint32*)dst)	+= dSpan;
	move.w	d4,d0
	ext.l	d0
	moveq	#2,d1
	asl.l	d1,d0
	add.l	d0,a2
;		((uint8*)src)		+= sSpan;
	move.w	d3,d0
	ext.l	d0
	add.l	a3,d0
	move.l	d0,a3
L163
	subq.w	#1,d2
	tst.w	d2
	bne.b	L159
L164
	movem.l	(a7)+,d2-d6/a2/a3
	unlk	a5
	rts

	SECTION "convARGB32LE__Pix8__PvPvPUjssss:0",CODE


;void Pix8::convARGB32LE(PXARG)
	XDEF	convARGB32LE__Pix8__PvPvPUjssss
convARGB32LE__Pix8__PvPvPUjssss
L173	EQU	-$404
	link	a5,#L173
	movem.l	d2-d6/a2/a3,-(a7)
	move.w	$16(a5),d2
	move.w	$1A(a5),d3
	move.w	$18(a5),d4
	move.w	$14(a5),d5
	move.l	$10(a5),a1
	move.l	$8(a5),a2
	move.l	$C(a5),a3
L166
;	Mem::swap32(pal, sPal, 256);
	move.l	#$100,d0
	lea	-$400(a5),a0
	jsr	swap32__Mem__r8Pvr9Pvr0Ui
;	h++;
	addq.w	#1,d2
; dSpan -= w;
	sub.w	d5,d4
; sSpan -= w;
	sub.w	d5,d3
;	while (--h)
	bra.b	L171
L167
;		rsint32 x = w+1;
	move.w	d5,d0
	ext.l	d0
	addq.l	#1,d0
;		while (--x)
	bra.b	L169
L168
;			*((uint32*)dst)++ = pal[*((uint8*)src)++];
	moveq	#0,d1
	move.b	(a3)+,d1
	lea	-$400(a5),a1
	move.l	0(a1,d1.l*4),(a2)+
L169
	subq.l	#1,d0
	tst.l	d0
	bne.b	L168
L170
;		((uint32*)dst)	+= dSpan;
	move.w	d4,d0
	ext.l	d0
	moveq	#2,d1
	asl.l	d1,d0
	add.l	d0,a2
;		((uint8*)src)		+= sSpan;
	move.w	d3,d0
	ext.l	d0
	add.l	a3,d0
	move.l	d0,a3
L171
	subq.w	#1,d2
	tst.w	d2
	bne.b	L167
L172
	movem.l	(a7)+,d2-d6/a2/a3
	unlk	a5
	rts

	SECTION "convABGR32LE__Pix8__PvPvPUjssss:0",CODE


;void Pix8::convABGR32LE(PXARG)
	XDEF	convABGR32LE__Pix8__PvPvPUjssss
convABGR32LE__Pix8__PvPvPUjssss
L181	EQU	-$404
	link	a5,#L181
	movem.l	d2-d6/a2/a3,-(a7)
	move.w	$16(a5),d2
	move.w	$1A(a5),d3
	move.w	$18(a5),d4
	move.w	$14(a5),d5
	move.l	$10(a5),a0
	move.l	$8(a5),a2
	move.l	$C(a5),a3
L174
;	Pix32::rotate32BETo32LE(pal, sPal, 0, 256, 1, 256, 256);
	move.w	#$100,-(a7)
	move.w	#$100,-(a7)
	move.w	#1,-(a7)
	move.w	#$100,-(a7)
	clr.l	-(a7)
	move.l	a0,-(a7)
	pea	-$400(a5)
	jsr	rotate32BETo32LE__Pix32__PvPvPUjssss
	add.w	#$14,a7
;	h++;
	addq.w	#1,d2
; dSpan -= w;
	sub.w	d5,d4
; sSpan -= w;
	sub.w	d5,d3
;	while (--h)
	bra.b	L179
L175
;		rsint32 x = w+1;
	move.w	d5,d0
	ext.l	d0
	addq.l	#1,d0
;		while (--x)
	bra.b	L177
L176
;			*((uint32*)dst)++ = pal[*((uint8*)src)++];
	moveq	#0,d1
	move.b	(a3)+,d1
	lea	-$400(a5),a1
	move.l	0(a1,d1.l*4),(a2)+
L177
	subq.l	#1,d0
	tst.l	d0
	bne.b	L176
L178
;		((uint32*)dst)	+= dSpan;
	move.w	d4,d0
	ext.l	d0
	moveq	#2,d1
	asl.l	d1,d0
	add.l	d0,a2
;		((uint8*)src)		+= sSpan;
	move.w	d3,d0
	ext.l	d0
	add.l	a3,d0
	move.l	d0,a3
L179
	subq.w	#1,d2
	tst.w	d2
	bne.b	L175
L180
	movem.l	(a7)+,d2-d6/a2/a3
	unlk	a5
	rts

	END
