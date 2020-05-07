
; Storm C Compiler
; EXNG:libsrc/plat/amigaos3_68k/gfxlib/pix16.cpp
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
	XREF	swap16__Mem__r8Pvr9Pvr0Ui
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

	SECTION "copy16BETo15BE__Pix16__PvPvPUjssss:0",CODE


;void Pix16::copy16BETo15BE(PXARG)
	XDEF	copy16BETo15BE__Pix16__PvPvPUjssss
copy16BETo15BE__Pix16__PvPvPUjssss
	movem.l	d2-d7/a2,-(a7)
	movem.l	$20(a7),a0/a1
	move.w	$2E(a7),d3
	move.w	$32(a7),d4
	move.w	$30(a7),d5
	move.w	$2C(a7),d7
L123
;	h++;
	addq.w	#1,d3
; dSpan -= w;
	sub.w	d7,d5
; sSpan -= w;
	sub.w	d7,d4
;	while(--h)
	bra.b	L128
L124
;		rsint32 x = w+1;
	move.w	d7,d2
	ext.l	d2
	addq.l	#1,d2
;		while(--x)
	bra.b	L126
L125
;			ruint16 pix				= *((uint16*)src)++;
	move.w	(a1)+,d1
;			*((uint16*)dst)++	= _16TO15(pix);
	moveq	#0,d0
	move.w	d1,d0
	moveq	#1,d6
	asr.l	d6,d0
	and.l	#$7FE0,d0
	and.l	#$FFFF,d1
	and.l	#$1F,d1
	or.l	d1,d0
	move.w	d0,(a0)+
L126
	subq.l	#1,d2
	tst.l	d2
	bne.b	L125
L127
;		((uint16*)dst)+=dSpan;
	move.w	d5,d0
	ext.l	d0
	moveq	#1,d1
	asl.l	d1,d0
	add.l	d0,a0
;		((uint16*)src)+=sSpan;
	move.w	d4,d0
	ext.l	d0
	moveq	#1,d1
	asl.l	d1,d0
	add.l	d0,a1
L128
	subq.w	#1,d3
	tst.w	d3
	bne.b	L124
L129
	movem.l	(a7)+,d2-d7/a2
	rts

	SECTION "copy16LETo15LE__Pix16__PvPvPUjssss:0",CODE


;void Pix16::copy16LETo15LE(PXARG)
	XDEF	copy16LETo15LE__Pix16__PvPvPUjssss
copy16LETo15LE__Pix16__PvPvPUjssss
	movem.l	d2-d7/a2,-(a7)
	movem.l	$20(a7),a0/a1
	move.w	$2E(a7),d3
	move.w	$32(a7),d4
	move.w	$30(a7),d5
	move.w	$2C(a7),d7
L130
;	h++;
	addq.w	#1,d3
; dSpan -= w;
	sub.w	d7,d5
; sSpan -= w;
	sub.w	d7,d4
;	while(--h)
	bra.b	L135
L131
;		rsint32 x = w+1;
	move.w	d7,d2
	ext.l	d2
	addq.l	#1,d2
;		while(--x)
	bra.b	L133
L132
;			ruint16 pix				= *((uint16*)src)++;
	move.w	(a1)+,d0
;			pix								= _SWP16(pix);
	moveq	#0,d1
	move.w	d0,d1
	moveq	#$8,d6
	asl.l	d6,d1
	and.l	#$FFFF,d0
	moveq	#$8,d6
	asr.l	d6,d0
	or.l	d0,d1
	move.w	d1,d0
;			pix								= _16TO15(pix);
	moveq	#0,d1
	move.w	d0,d1
	moveq	#1,d6
	asr.l	d6,d1
	and.l	#$7FE0,d1
	and.l	#$FFFF,d0
	and.l	#$1F,d0
	or.l	d0,d1
	move.w	d1,d0
;			*((uint16*)dst)++	= _SWP16(pix);
	moveq	#0,d1
	move.w	d0,d1
	moveq	#$8,d6
	asl.l	d6,d1
	and.l	#$FFFF,d0
	moveq	#$8,d6
	asr.l	d6,d0
	or.l	d0,d1
	move.w	d1,d0
	move.w	d0,(a0)+
L133
	subq.l	#1,d2
	tst.l	d2
	bne.b	L132
L134
;		((uint16*)dst)+=dSpan;
	move.w	d5,d0
	ext.l	d0
	moveq	#1,d1
	asl.l	d1,d0
	add.l	d0,a0
;		((uint16*)src)+=sSpan;
	move.w	d4,d0
	ext.l	d0
	moveq	#1,d1
	asl.l	d1,d0
	add.l	d0,a1
L135
	subq.w	#1,d3
	tst.w	d3
	bne.b	L131
L136
	movem.l	(a7)+,d2-d7/a2
	rts

	SECTION "copy16BETo15LE__Pix16__PvPvPUjssss:0",CODE


;void Pix16::copy16BETo15LE(PXARG)
	XDEF	copy16BETo15LE__Pix16__PvPvPUjssss
copy16BETo15LE__Pix16__PvPvPUjssss
	movem.l	d2-d7/a2,-(a7)
	movem.l	$20(a7),a0/a1
	move.w	$2E(a7),d3
	move.w	$32(a7),d4
	move.w	$30(a7),d5
	move.w	$2C(a7),d7
L137
;	h++;
	addq.w	#1,d3
; dSpan -= w;
	sub.w	d7,d5
; sSpan -= w;
	sub.w	d7,d4
;	while(--h)
	bra.b	L142
L138
;		rsint32 x = w+1;
	move.w	d7,d2
	ext.l	d2
	addq.l	#1,d2
;		while(--x)
	bra.b	L140
L139
;			ruint16 pix				= *((uint16*)src)++;
	move.w	(a1)+,d1
;			pix								= _16TO15(pix);
	moveq	#0,d0
	move.w	d1,d0
	moveq	#1,d6
	asr.l	d6,d0
	and.l	#$7FE0,d0
	and.l	#$FFFF,d1
	and.l	#$1F,d1
	or.l	d1,d0
	move.w	d0,d1
;			*((uint16*)dst)++	= _SWP16(pix);
	moveq	#0,d0
	move.w	d1,d0
	moveq	#$8,d6
	asl.l	d6,d0
	and.l	#$FFFF,d1
	moveq	#$8,d6
	asr.l	d6,d1
	or.l	d1,d0
	move.w	d0,(a0)+
L140
	subq.l	#1,d2
	tst.l	d2
	bne.b	L139
L141
;		((uint16*)dst)+=dSpan;
	move.w	d5,d0
	ext.l	d0
	moveq	#1,d1
	asl.l	d1,d0
	add.l	d0,a0
;		((uint16*)src)+=sSpan;
	move.w	d4,d0
	ext.l	d0
	moveq	#1,d1
	asl.l	d1,d0
	add.l	d0,a1
L142
	subq.w	#1,d3
	tst.w	d3
	bne.b	L138
L143
	movem.l	(a7)+,d2-d7/a2
	rts

	SECTION "copy16LETo15BE__Pix16__PvPvPUjssss:0",CODE


;void Pix16::copy16LETo15BE(PXARG)
	XDEF	copy16LETo15BE__Pix16__PvPvPUjssss
copy16LETo15BE__Pix16__PvPvPUjssss
	movem.l	d2-d7/a2,-(a7)
	movem.l	$20(a7),a0/a1
	move.w	$2E(a7),d3
	move.w	$32(a7),d4
	move.w	$30(a7),d5
	move.w	$2C(a7),d7
L144
;	h++;
	addq.w	#1,d3
; dSpan -= w;
	sub.w	d7,d5
; sSpan -= w;
	sub.w	d7,d4
;	while(--h)
	bra.b	L149
L145
;		rsint32 x = w+1;
	move.w	d7,d2
	ext.l	d2
	addq.l	#1,d2
;		while(--x)
	bra.b	L147
L146
;			ruint16 pix				= *((uint16*)src)++;
	move.w	(a1)+,d1
;			pix								= _SWP16(pix);
	moveq	#0,d0
	move.w	d1,d0
	moveq	#$8,d6
	asl.l	d6,d0
	and.l	#$FFFF,d1
	moveq	#$8,d6
	asr.l	d6,d1
	or.l	d1,d0
	move.w	d0,d1
;			*((uint16*)dst)++	= _16TO15(pix);
	moveq	#0,d0
	move.w	d1,d0
	moveq	#1,d6
	asr.l	d6,d0
	and.l	#$7FE0,d0
	and.l	#$FFFF,d1
	and.l	#$1F,d1
	or.l	d1,d0
	move.w	d0,(a0)+
L147
	subq.l	#1,d2
	tst.l	d2
	bne.b	L146
L148
;		((uint16*)dst)+=dSpan;
	move.w	d5,d0
	ext.l	d0
	moveq	#1,d1
	asl.l	d1,d0
	add.l	d0,a0
;		((uint16*)src)+=sSpan;
	move.w	d4,d0
	ext.l	d0
	moveq	#1,d1
	asl.l	d1,d0
	add.l	d0,a1
L149
	subq.w	#1,d3
	tst.w	d3
	bne.b	L145
L150
	movem.l	(a7)+,d2-d7/a2
	rts

	SECTION "rotate16BETo15BE__Pix16__PvPvPUjssss:0",CODE


;void Pix16::rotate16BETo15BE(PXARG)
	XDEF	rotate16BETo15BE__Pix16__PvPvPUjssss
rotate16BETo15BE__Pix16__PvPvPUjssss
L158	EQU	-4
	link	a5,#L158
	movem.l	d2-d7/a2,-(a7)
	movem.l	$8(a5),a0/a1
	move.w	$16(a5),d4
	move.w	$1A(a5),d5
	move.w	$18(a5),d7
L151
;	h++;
	addq.w	#1,d4
; dSpan -= w;
	move.w	d7,d0
	sub.w	$14(a5),d0
	move.w	d0,d7
; sSpan -= w;
	sub.w	$14(a5),d5
;	while(--h)
	bra.b	L156
L152
;		rsint32 x = w+1;
	move.w	$14(a5),d3
	ext.l	d3
	addq.l	#1,d3
;		while(--x)
	bra.b	L154
L153
;			ruint16 pix				= *((uint16*)src)++;
	move.w	(a1)+,d1
;			pix								= _ROT16(pix);
	moveq	#0,d0
	move.w	d1,d0
	moveq	#$B,d2
	asr.l	d2,d0
	moveq	#0,d2
	move.w	d1,d2
	moveq	#$B,d6
	asl.l	d6,d2
	or.l	d2,d0
	and.l	#$FFFF,d1
	and.l	#$7E0,d1
	or.l	d1,d0
	move.w	d0,d1
;			*((uint16*)dst)++	= _16TO15(pix);
	moveq	#0,d0
	move.w	d1,d0
	moveq	#1,d2
	asr.l	d2,d0
	and.l	#$7FE0,d0
	and.l	#$FFFF,d1
	and.l	#$1F,d1
	or.l	d1,d0
	move.w	d0,(a0)+
L154
	subq.l	#1,d3
	tst.l	d3
	bne.b	L153
L155
;		((uint16*)dst)+=dSpan;
	move.w	d7,d0
	ext.l	d0
	moveq	#1,d1
	asl.l	d1,d0
	add.l	d0,a0
;		((uint16*)src)+=sSpan;
	move.w	d5,d0
	ext.l	d0
	moveq	#1,d1
	asl.l	d1,d0
	add.l	d0,a1
L156
	subq.w	#1,d4
	tst.w	d4
	bne.b	L152
L157
	movem.l	(a7)+,d2-d7/a2
	unlk	a5
	rts

	SECTION "rotate16LETo15LE__Pix16__PvPvPUjssss:0",CODE


;void Pix16::rotate16LETo15LE(PXARG)
	XDEF	rotate16LETo15LE__Pix16__PvPvPUjssss
rotate16LETo15LE__Pix16__PvPvPUjssss
L166	EQU	-4
	link	a5,#L166
	movem.l	d2-d7/a2,-(a7)
	movem.l	$8(a5),a0/a1
	move.w	$16(a5),d4
	move.w	$1A(a5),d5
	move.w	$18(a5),d7
L159
;	h++;
	addq.w	#1,d4
; dSpan -= w;
	move.w	d7,d0
	sub.w	$14(a5),d0
	move.w	d0,d7
; sSpan -= w;
	sub.w	$14(a5),d5
;	while(--h)
	bra	L164
L160
;		rsint32 x = w+1;
	move.w	$14(a5),d3
	ext.l	d3
	addq.l	#1,d3
;		while(--x)
	bra.b	L162
L161
;			ruint16 pix				= *((uint16*)src)++;
	move.w	(a1)+,d0
;			pix								= _SWP16(pix);
	moveq	#0,d1
	move.w	d0,d1
	moveq	#$8,d2
	asl.l	d2,d1
	and.l	#$FFFF,d0
	moveq	#$8,d2
	asr.l	d2,d0
	or.l	d0,d1
	move.w	d1,d0
;			pix								= _ROT16(pix);
	moveq	#0,d1
	move.w	d0,d1
	moveq	#$B,d2
	asr.l	d2,d1
	moveq	#0,d2
	move.w	d0,d2
	moveq	#$B,d6
	asl.l	d6,d2
	or.l	d2,d1
	and.l	#$FFFF,d0
	and.l	#$7E0,d0
	or.l	d0,d1
	move.w	d1,d0
;			pix								= _16TO15(pix);
	moveq	#0,d1
	move.w	d0,d1
	moveq	#1,d2
	asr.l	d2,d1
	and.l	#$7FE0,d1
	and.l	#$FFFF,d0
	and.l	#$1F,d0
	or.l	d0,d1
	move.w	d1,d0
;			*((uint16*)dst)++	= _SWP16(pix);
	moveq	#0,d1
	move.w	d0,d1
	moveq	#$8,d2
	asl.l	d2,d1
	and.l	#$FFFF,d0
	moveq	#$8,d2
	asr.l	d2,d0
	or.l	d0,d1
	move.w	d1,d0
	move.w	d0,(a0)+
L162
	subq.l	#1,d3
	tst.l	d3
	bne.b	L161
L163
;		((uint16*)dst)+=dSpan;
	move.w	d7,d0
	ext.l	d0
	moveq	#1,d1
	asl.l	d1,d0
	add.l	d0,a0
;		((uint16*)src)+=sSpan;
	move.w	d5,d0
	ext.l	d0
	moveq	#1,d1
	asl.l	d1,d0
	add.l	d0,a1
L164
	subq.w	#1,d4
	tst.w	d4
	bne	L160
L165
	movem.l	(a7)+,d2-d7/a2
	unlk	a5
	rts

	SECTION "rotate16BETo15LE__Pix16__PvPvPUjssss:0",CODE


;void Pix16::rotate16BETo15LE(PXARG)
	XDEF	rotate16BETo15LE__Pix16__PvPvPUjssss
rotate16BETo15LE__Pix16__PvPvPUjssss
L174	EQU	-4
	link	a5,#L174
	movem.l	d2-d7/a2,-(a7)
	movem.l	$8(a5),a0/a1
	move.w	$16(a5),d4
	move.w	$1A(a5),d5
	move.w	$18(a5),d7
L167
;	h++;
	addq.w	#1,d4
; dSpan -= w;
	move.w	d7,d0
	sub.w	$14(a5),d0
	move.w	d0,d7
; sSpan -= w;
	sub.w	$14(a5),d5
;	while(--h)
	bra	L172
L168
;		rsint32 x = w+1;
	move.w	$14(a5),d3
	ext.l	d3
	addq.l	#1,d3
;		while(--x)
	bra.b	L170
L169
;			ruint16 pix				= *((uint16*)src)++;
	move.w	(a1)+,d0
;			pix								= _ROT16(pix);
	moveq	#0,d1
	move.w	d0,d1
	moveq	#$B,d2
	asr.l	d2,d1
	moveq	#0,d2
	move.w	d0,d2
	moveq	#$B,d6
	asl.l	d6,d2
	or.l	d2,d1
	and.l	#$FFFF,d0
	and.l	#$7E0,d0
	or.l	d0,d1
	move.w	d1,d0
;			pix								= _16TO15(pix);
	moveq	#0,d1
	move.w	d0,d1
	moveq	#1,d2
	asr.l	d2,d1
	and.l	#$7FE0,d1
	and.l	#$FFFF,d0
	and.l	#$1F,d0
	or.l	d0,d1
	move.w	d1,d0
;			*((uint16*)dst)++	= _SWP16(pix);
	moveq	#0,d1
	move.w	d0,d1
	moveq	#$8,d2
	asl.l	d2,d1
	and.l	#$FFFF,d0
	moveq	#$8,d2
	asr.l	d2,d0
	or.l	d0,d1
	move.w	d1,d0
	move.w	d0,(a0)+
L170
	subq.l	#1,d3
	tst.l	d3
	bne.b	L169
L171
;		((uint16*)dst)+=dSpan;
	move.w	d7,d0
	ext.l	d0
	moveq	#1,d1
	asl.l	d1,d0
	add.l	d0,a0
;		((uint16*)src)+=sSpan;
	move.w	d5,d0
	ext.l	d0
	moveq	#1,d1
	asl.l	d1,d0
	add.l	d0,a1
L172
	subq.w	#1,d4
	tst.w	d4
	bne	L168
L173
	movem.l	(a7)+,d2-d7/a2
	unlk	a5
	rts

	SECTION "rotate16LETo15BE__Pix16__PvPvPUjssss:0",CODE


;void Pix16::rotate16LETo15BE(PXARG)
	XDEF	rotate16LETo15BE__Pix16__PvPvPUjssss
rotate16LETo15BE__Pix16__PvPvPUjssss
L182	EQU	-4
	link	a5,#L182
	movem.l	d2-d7/a2,-(a7)
	movem.l	$8(a5),a0/a1
	move.w	$16(a5),d4
	move.w	$1A(a5),d5
	move.w	$18(a5),d7
L175
;	h++;
	addq.w	#1,d4
; dSpan -= w;
	move.w	d7,d0
	sub.w	$14(a5),d0
	move.w	d0,d7
; sSpan -= w;
	sub.w	$14(a5),d5
;	while(--h)
	bra	L180
L176
;		rsint32 x = w+1;
	move.w	$14(a5),d3
	ext.l	d3
	addq.l	#1,d3
;		while(--x)
	bra.b	L178
L177
;			ruint16 pix				= *((uint16*)src)++;
	move.w	(a1)+,d0
;			pix								= _SWP16(pix);
	moveq	#0,d1
	move.w	d0,d1
	moveq	#$8,d2
	asl.l	d2,d1
	and.l	#$FFFF,d0
	moveq	#$8,d2
	asr.l	d2,d0
	or.l	d0,d1
	move.w	d1,d0
;			pix								= _ROT16(pix);
	moveq	#0,d1
	move.w	d0,d1
	moveq	#$B,d2
	asr.l	d2,d1
	moveq	#0,d2
	move.w	d0,d2
	moveq	#$B,d6
	asl.l	d6,d2
	or.l	d2,d1
	and.l	#$FFFF,d0
	and.l	#$7E0,d0
	or.l	d0,d1
	move.w	d1,d0
;			*((uint16*)dst)++	= _16TO15(pix);
	moveq	#0,d1
	move.w	d0,d1
	moveq	#1,d2
	asr.l	d2,d1
	and.l	#$7FE0,d1
	and.l	#$FFFF,d0
	and.l	#$1F,d0
	or.l	d0,d1
	move.w	d1,d0
	move.w	d0,(a0)+
L178
	subq.l	#1,d3
	tst.l	d3
	bne.b	L177
L179
;		((uint16*)dst)+=dSpan;
	move.w	d7,d0
	ext.l	d0
	moveq	#1,d1
	asl.l	d1,d0
	add.l	d0,a0
;		((uint16*)src)+=sSpan;
	move.w	d5,d0
	ext.l	d0
	moveq	#1,d1
	asl.l	d1,d0
	add.l	d0,a1
L180
	subq.w	#1,d4
	tst.w	d4
	bne	L176
L181
	movem.l	(a7)+,d2-d7/a2
	unlk	a5
	rts

	SECTION "copy16XETo16XE__Pix16__PvPvPUjssss:0",CODE


;void Pix16::copy16XETo16XE(PXARG)
	XDEF	copy16XETo16XE__Pix16__PvPvPUjssss
copy16XETo16XE__Pix16__PvPvPUjssss
	movem.l	d2-d5/a2/a3,-(a7)
	move.w	$2A(a7),d2
	move.w	$28(a7),d3
	move.w	$2C(a7),d4
	move.w	$2E(a7),d5
	move.l	$20(a7),a2
	move.l	$1C(a7),a3
L183
;	if (dst==src)
	move.l	a3,a0
	cmp.l	a2,a0
	bne.b	L185
L184
;		return;
	movem.l	(a7)+,d2-d5/a2/a3
	rts
L185
;	else if (dSpan == sSpan && dSpan == w)
	cmp.w	d5,d4
	bne.b	L188
L186
	cmp.w	d3,d4
	bne.b	L188
L187
;		Mem::copy(dst, src, (w*h)<<1);
	move.w	d3,d0
	muls	d2,d0
	moveq	#1,d1
	asl.l	d1,d0
	move.l	a3,a0
	move.l	a2,a1
	jsr	copy__Mem__r8Pvr9Pvr0Ui
	bra.b	L191
L188
;		w<<=1;
	moveq	#1,d0
	asl.w	d0,d3
; h++;
	addq.w	#1,d2
;		while(--h)
	bra.b	L190
L189
;			Mem::copy(dst, src, w);
	move.w	d3,d0
	ext.l	d0
	move.l	a3,a0
	move.l	a2,a1
	jsr	copy__Mem__r8Pvr9Pvr0Ui
;			((uint16*)dst)+=dSpan;
	move.w	d4,d0
	ext.l	d0
	moveq	#1,d1
	asl.l	d1,d0
	add.l	a3,d0
	move.l	d0,a3
;			((uint16*)src)+=sSpan;
	move.w	d5,d0
	ext.l	d0
	moveq	#1,d1
	asl.l	d1,d0
	add.l	d0,a2
L190
	subq.w	#1,d2
	tst.w	d2
	bne.b	L189
L191
	movem.l	(a7)+,d2-d5/a2/a3
	rts

	SECTION "copy16XETo16YE__Pix16__PvPvPUjssss:0",CODE


;void Pix16::copy16XETo16YE(PXARG)
	XDEF	copy16XETo16YE__Pix16__PvPvPUjssss
copy16XETo16YE__Pix16__PvPvPUjssss
	movem.l	d2-d5/a2/a3,-(a7)
	movem.l	$1C(a7),a2/a3
	move.w	$2A(a7),d2
	move.w	$28(a7),d3
	move.w	$2C(a7),d4
	move.w	$2E(a7),d5
L192
;	if (dSpan == sSpan && dSpan == w)
	cmp.w	d5,d4
	bne.b	L195
L193
	cmp.w	d3,d4
	bne.b	L195
L194
;		Mem::swap16(dst, src, w*h);
	move.w	d3,d0
	muls	d2,d0
	move.l	a2,a0
	move.l	a3,a1
	jsr	swap16__Mem__r8Pvr9Pvr0Ui
	bra.b	L198
L195
;		h++;
	addq.w	#1,d2
;		while(--h)
	bra.b	L197
L196
;			Mem::swap16(dst, src, w);
	move.w	d3,d0
	ext.l	d0
	move.l	a2,a0
	move.l	a3,a1
	jsr	swap16__Mem__r8Pvr9Pvr0Ui
;			((uint16*)dst)+=dSpan;
	move.w	d4,d0
	ext.l	d0
	moveq	#1,d1
	asl.l	d1,d0
	add.l	d0,a2
;			((uint16*)src)+=sSpan;
	move.w	d5,d0
	ext.l	d0
	moveq	#1,d1
	asl.l	d1,d0
	add.l	a3,d0
	move.l	d0,a3
L197
	subq.w	#1,d2
	tst.w	d2
	bne.b	L196
L198
	movem.l	(a7)+,d2-d5/a2/a3
	rts

	SECTION "rotate16BETo16BE__Pix16__PvPvPUjssss:0",CODE


;void Pix16::rotate16BETo16BE(PXARG)
	XDEF	rotate16BETo16BE__Pix16__PvPvPUjssss
rotate16BETo16BE__Pix16__PvPvPUjssss
L206	EQU	-4
	link	a5,#L206
	movem.l	d2-d7/a2,-(a7)
	movem.l	$8(a5),a0/a1
	move.w	$16(a5),d4
	move.w	$1A(a5),d5
	move.w	$18(a5),d7
L199
;	h++;
	addq.w	#1,d4
; dSpan -= w;
	move.w	d7,d0
	sub.w	$14(a5),d0
	move.w	d0,d7
; sSpan -= w;
	sub.w	$14(a5),d5
;	while(--h)
	bra.b	L204
L200
;		rsint32 x = w+1;
	move.w	$14(a5),d3
	ext.l	d3
	addq.l	#1,d3
;		while(--x)
	bra.b	L202
L201
;			ruint16 pix				= *((uint16*)src)++;
	move.w	(a1)+,d2
;			*((uint16*)dst)++	= _ROT16(pix);
	moveq	#0,d0
	move.w	d2,d0
	moveq	#$B,d1
	asr.l	d1,d0
	moveq	#0,d1
	move.w	d2,d1
	moveq	#$B,d6
	asl.l	d6,d1
	or.l	d1,d0
	moveq	#0,d1
	move.w	d2,d1
	and.l	#$7E0,d1
	or.l	d1,d0
	move.w	d0,(a0)+
L202
	subq.l	#1,d3
	tst.l	d3
	bne.b	L201
L203
;		((uint16*)dst)+=dSpan;
	move.w	d7,d0
	ext.l	d0
	moveq	#1,d1
	asl.l	d1,d0
	add.l	d0,a0
;		((uint16*)src)+=sSpan;
	move.w	d5,d0
	ext.l	d0
	moveq	#1,d1
	asl.l	d1,d0
	add.l	d0,a1
L204
	subq.w	#1,d4
	tst.w	d4
	bne.b	L200
L205
	movem.l	(a7)+,d2-d7/a2
	unlk	a5
	rts

	SECTION "rotate16LETo16LE__Pix16__PvPvPUjssss:0",CODE


;void Pix16::rotate16LETo16LE(PXARG)
	XDEF	rotate16LETo16LE__Pix16__PvPvPUjssss
rotate16LETo16LE__Pix16__PvPvPUjssss
L214	EQU	-4
	link	a5,#L214
	movem.l	d2-d7/a2,-(a7)
	movem.l	$8(a5),a0/a1
	move.w	$16(a5),d4
	move.w	$1A(a5),d5
	move.w	$18(a5),d7
L207
;	h++;
	addq.w	#1,d4
; dSpan -= w;
	move.w	d7,d0
	sub.w	$14(a5),d0
	move.w	d0,d7
; sSpan -= w;
	sub.w	$14(a5),d5
;	while(--h)
	bra.b	L212
L208
;		rsint32 x = w+1;
	move.w	$14(a5),d3
	ext.l	d3
	addq.l	#1,d3
;		while(--x)
	bra.b	L210
L209
;			ruint16 pix				= *((uint16*)src)++;
	move.w	(a1)+,d0
;			pix								= _SWP16(pix);
	moveq	#0,d1
	move.w	d0,d1
	moveq	#$8,d2
	asl.l	d2,d1
	and.l	#$FFFF,d0
	moveq	#$8,d2
	asr.l	d2,d0
	or.l	d0,d1
	move.w	d1,d0
;			pix								= _ROT16(pix);
	moveq	#0,d1
	move.w	d0,d1
	moveq	#$B,d2
	asr.l	d2,d1
	moveq	#0,d2
	move.w	d0,d2
	moveq	#$B,d6
	asl.l	d6,d2
	or.l	d2,d1
	and.l	#$FFFF,d0
	and.l	#$7E0,d0
	or.l	d0,d1
	move.w	d1,d0
;			*((uint16*)dst)++ = _SWP16(pix);
	moveq	#0,d1
	move.w	d0,d1
	moveq	#$8,d2
	asl.l	d2,d1
	and.l	#$FFFF,d0
	moveq	#$8,d2
	asr.l	d2,d0
	or.l	d0,d1
	move.w	d1,d0
	move.w	d0,(a0)+
L210
	subq.l	#1,d3
	tst.l	d3
	bne.b	L209
L211
;		((uint16*)dst)+=dSpan;
	move.w	d7,d0
	ext.l	d0
	moveq	#1,d1
	asl.l	d1,d0
	add.l	d0,a0
;		((uint16*)src)+=sSpan;
	move.w	d5,d0
	ext.l	d0
	moveq	#1,d1
	asl.l	d1,d0
	add.l	d0,a1
L212
	subq.w	#1,d4
	tst.w	d4
	bne	L208
L213
	movem.l	(a7)+,d2-d7/a2
	unlk	a5
	rts

	SECTION "rotate16BETo16LE__Pix16__PvPvPUjssss:0",CODE


;void Pix16::rotate16BETo16LE(PXARG)
	XDEF	rotate16BETo16LE__Pix16__PvPvPUjssss
rotate16BETo16LE__Pix16__PvPvPUjssss
L222	EQU	-4
	link	a5,#L222
	movem.l	d2-d7/a2,-(a7)
	movem.l	$8(a5),a0/a1
	move.w	$16(a5),d4
	move.w	$1A(a5),d5
	move.w	$18(a5),d7
L215
;	h++;
	addq.w	#1,d4
; dSpan -= w;
	move.w	d7,d0
	sub.w	$14(a5),d0
	move.w	d0,d7
; sSpan -= w;
	sub.w	$14(a5),d5
;	while(--h)
	bra.b	L220
L216
;		rsint32 x = w+1;
	move.w	$14(a5),d3
	ext.l	d3
	addq.l	#1,d3
;		while(--x)
	bra.b	L218
L217
;			ruint16 pix				= *((uint16*)src)++;
	move.w	(a1)+,d1
;			pix								= _ROT16(pix);
	moveq	#0,d0
	move.w	d1,d0
	moveq	#$B,d2
	asr.l	d2,d0
	moveq	#0,d2
	move.w	d1,d2
	moveq	#$B,d6
	asl.l	d6,d2
	or.l	d2,d0
	and.l	#$FFFF,d1
	and.l	#$7E0,d1
	or.l	d1,d0
	move.w	d0,d1
;			*((uint16*)dst)++	= _SWP16(pix);
	moveq	#0,d0
	move.w	d1,d0
	moveq	#$8,d2
	asl.l	d2,d0
	and.l	#$FFFF,d1
	moveq	#$8,d2
	asr.l	d2,d1
	or.l	d1,d0
	move.w	d0,(a0)+
L218
	subq.l	#1,d3
	tst.l	d3
	bne.b	L217
L219
;		((uint16*)dst)+=dSpan;
	move.w	d7,d0
	ext.l	d0
	moveq	#1,d1
	asl.l	d1,d0
	add.l	d0,a0
;		((uint16*)src)+=sSpan;
	move.w	d5,d0
	ext.l	d0
	moveq	#1,d1
	asl.l	d1,d0
	add.l	d0,a1
L220
	subq.w	#1,d4
	tst.w	d4
	bne.b	L216
L221
	movem.l	(a7)+,d2-d7/a2
	unlk	a5
	rts

	SECTION "rotate16LETo16BE__Pix16__PvPvPUjssss:0",CODE


;void Pix16::rotate16LETo16BE(PXARG)
	XDEF	rotate16LETo16BE__Pix16__PvPvPUjssss
rotate16LETo16BE__Pix16__PvPvPUjssss
L230	EQU	-4
	link	a5,#L230
	movem.l	d2-d7/a2,-(a7)
	movem.l	$8(a5),a0/a1
	move.w	$16(a5),d4
	move.w	$1A(a5),d5
	move.w	$18(a5),d7
L223
;	h++;
	addq.w	#1,d4
; dSpan -= w;
	move.w	d7,d0
	sub.w	$14(a5),d0
	move.w	d0,d7
; sSpan -= w;
	sub.w	$14(a5),d5
;	while(--h)
	bra.b	L228
L224
;		rsint32 x = w+1;
	move.w	$14(a5),d3
	ext.l	d3
	addq.l	#1,d3
;		while(--x)
	bra.b	L226
L225
;			ruint16 pix				= *((uint16*)src)++;
	move.w	(a1)+,d1
;			pix								= _SWP16(pix);
	moveq	#0,d0
	move.w	d1,d0
	moveq	#$8,d2
	asl.l	d2,d0
	and.l	#$FFFF,d1
	moveq	#$8,d2
	asr.l	d2,d1
	or.l	d1,d0
	move.w	d0,d1
;			*((uint16*)dst)++	= _ROT16(pix);
	moveq	#0,d0
	move.w	d1,d0
	moveq	#$B,d2
	asr.l	d2,d0
	moveq	#0,d2
	move.w	d1,d2
	moveq	#$B,d6
	asl.l	d6,d2
	or.l	d2,d0
	and.l	#$FFFF,d1
	and.l	#$7E0,d1
	or.l	d1,d0
	move.w	d0,(a0)+
L226
	subq.l	#1,d3
	tst.l	d3
	bne.b	L225
L227
;		((uint16*)dst)+=dSpan;
	move.w	d7,d0
	ext.l	d0
	moveq	#1,d1
	asl.l	d1,d0
	add.l	d0,a0
;		((uint16*)src)+=sSpan;
	move.w	d5,d0
	ext.l	d0
	moveq	#1,d1
	asl.l	d1,d0
	add.l	d0,a1
L228
	subq.w	#1,d4
	tst.w	d4
	bne.b	L224
L229
	movem.l	(a7)+,d2-d7/a2
	unlk	a5
	rts

	SECTION "copy16BETo24XGY__Pix16__PvPvPUjssss:0",CODE


;void Pix16::copy16BETo24XGY(PXARG)
	XDEF	copy16BETo24XGY__Pix16__PvPvPUjssss
copy16BETo24XGY__Pix16__PvPvPUjssss
	movem.l	d2-d7/a2,-(a7)
	movem.l	$20(a7),a0/a1
	move.w	$2E(a7),d3
	move.w	$30(a7),d4
	move.w	$32(a7),d5
	move.w	$2C(a7),d7
L231
;	h++;
	addq.w	#1,d3
; dSpan -= w;
	sub.w	d7,d4
; dSpan *= 3;
	move.w	d4,d0
	muls	#3,d0
	move.w	d0,d4
; sSpan -= w;
	sub.w	d7,d5
;	while(--h)
	bra.b	L236
L232
;		rsint32 x = w+1;
	move.w	d7,d2
	ext.l	d2
	addq.l	#1,d2
;		while(--x)
	bra.b	L234
L233
;			ruint16 pix				= *((uint16*)src)++;
	move.w	(a1)+,d1
;			*((uint8*)dst)++	= _GET16X(pix);
	moveq	#0,d0
	move.w	d1,d0
	and.l	#$F800,d0
	moveq	#$8,d6
	asr.l	d6,d0
	move.b	d0,(a0)+
;			*((uint8*)dst)++	= _GET16G(pix);
	moveq	#0,d0
	move.w	d1,d0
	and.l	#$7E0,d0
	moveq	#3,d6
	asr.l	d6,d0
	move.b	d0,(a0)+
;			*((uint8*)dst)++	= _GET16Y(pix);
	moveq	#0,d0
	move.w	d1,d0
	and.l	#$1F,d0
	moveq	#3,d1
	asl.l	d1,d0
	move.b	d0,(a0)+
L234
	subq.l	#1,d2
	tst.l	d2
	bne.b	L233
L235
;		((uint8*)dst)+=dSpan;
	move.w	d4,d0
	ext.l	d0
	add.l	d0,a0
;		((uint16*)src)+=sSpan;
	move.w	d5,d0
	ext.l	d0
	moveq	#1,d1
	asl.l	d1,d0
	add.l	d0,a1
L236
	subq.w	#1,d3
	tst.w	d3
	bne.b	L232
L237
	movem.l	(a7)+,d2-d7/a2
	rts

	SECTION "copy16LETo24XGY__Pix16__PvPvPUjssss:0",CODE


;void Pix16::copy16LETo24XGY(PXARG)
	XDEF	copy16LETo24XGY__Pix16__PvPvPUjssss
copy16LETo24XGY__Pix16__PvPvPUjssss
	movem.l	d2-d7/a2,-(a7)
	movem.l	$20(a7),a0/a1
	move.w	$2E(a7),d3
	move.w	$30(a7),d4
	move.w	$32(a7),d5
	move.w	$2C(a7),d7
L238
;	h++;
	addq.w	#1,d3
; dSpan -= w;
	sub.w	d7,d4
; dSpan *= 3;
	move.w	d4,d0
	muls	#3,d0
	move.w	d0,d4
; sSpan -= w;
	sub.w	d7,d5
;	while(--h)
	bra.b	L243
L239
;		rsint32 x = w+1;
	move.w	d7,d2
	ext.l	d2
	addq.l	#1,d2
;		while(--x)
	bra.b	L241
L240
;			ruint16 pix				= *((uint16*)src)++;
	move.w	(a1)+,d0
;			pix								= _SWP16(pix);
	moveq	#0,d1
	move.w	d0,d1
	moveq	#$8,d6
	asl.l	d6,d1
	and.l	#$FFFF,d0
	moveq	#$8,d6
	asr.l	d6,d0
	or.l	d0,d1
	move.w	d1,d0
;			*((uint8*)dst)++	= _GET16X(pix);
	moveq	#0,d1
	move.w	d0,d1
	and.l	#$F800,d1
	moveq	#$8,d6
	asr.l	d6,d1
	move.b	d1,(a0)+
;			*((uint8*)dst)++	= _GET16G(pix);
	moveq	#0,d1
	move.w	d0,d1
	and.l	#$7E0,d1
	moveq	#3,d6
	asr.l	d6,d1
	move.b	d1,(a0)+
;			*((uint8*)dst)++	= _GET16Y(pix);
	and.l	#$FFFF,d0
	and.l	#$1F,d0
	moveq	#3,d1
	asl.l	d1,d0
	move.b	d0,(a0)+
L241
	subq.l	#1,d2
	tst.l	d2
	bne.b	L240
L242
;		((uint8*)dst)+=dSpan;
	move.w	d4,d0
	ext.l	d0
	add.l	d0,a0
;		((uint16*)src)+=sSpan;
	move.w	d5,d0
	ext.l	d0
	moveq	#1,d1
	asl.l	d1,d0
	add.l	d0,a1
L243
	subq.w	#1,d3
	tst.w	d3
	bne.b	L239
L244
	movem.l	(a7)+,d2-d7/a2
	rts

	SECTION "rotate16BETo24XGY__Pix16__PvPvPUjssss:0",CODE


;void Pix16::rotate16BETo24XGY(PXARG)
	XDEF	rotate16BETo24XGY__Pix16__PvPvPUjssss
rotate16BETo24XGY__Pix16__PvPvPUjssss
	movem.l	d2-d7/a2,-(a7)
	movem.l	$20(a7),a0/a1
	move.w	$2E(a7),d3
	move.w	$30(a7),d4
	move.w	$32(a7),d5
	move.w	$2C(a7),d7
L245
;	h++;
	addq.w	#1,d3
; dSpan -= w;
	sub.w	d7,d4
; dSpan *= 3;
	move.w	d4,d0
	muls	#3,d0
	move.w	d0,d4
; sSpan -= w;
	sub.w	d7,d5
;	while(--h)
	bra.b	L250
L246
;		rsint32 x = w+1;
	move.w	d7,d2
	ext.l	d2
	addq.l	#1,d2
;		while(--x)
	bra.b	L248
L247
;			ruint16 pix				= *((uint16*)src)++;
	move.w	(a1)+,d1
;			*((uint8*)dst)++	= _GET16Y(pix);
	moveq	#0,d0
	move.w	d1,d0
	and.l	#$1F,d0
	moveq	#3,d6
	asl.l	d6,d0
	move.b	d0,(a0)+
;			*((uint8*)dst)++	= _GET16G(pix);
	moveq	#0,d0
	move.w	d1,d0
	and.l	#$7E0,d0
	moveq	#3,d6
	asr.l	d6,d0
	move.b	d0,(a0)+
;			*((uint8*)dst)++	= _GET16X(pix);
	moveq	#0,d0
	move.w	d1,d0
	and.l	#$F800,d0
	moveq	#$8,d1
	asr.l	d1,d0
	move.b	d0,(a0)+
L248
	subq.l	#1,d2
	tst.l	d2
	bne.b	L247
L249
;		((uint8*)dst)+=dSpan;
	move.w	d4,d0
	ext.l	d0
	add.l	d0,a0
;		((uint16*)src)+=sSpan;
	move.w	d5,d0
	ext.l	d0
	moveq	#1,d1
	asl.l	d1,d0
	add.l	d0,a1
L250
	subq.w	#1,d3
	tst.w	d3
	bne.b	L246
L251
	movem.l	(a7)+,d2-d7/a2
	rts

	SECTION "rotate16LETo24XGY__Pix16__PvPvPUjssss:0",CODE


;void Pix16::rotate16LETo24XGY(PXARG)
	XDEF	rotate16LETo24XGY__Pix16__PvPvPUjssss
rotate16LETo24XGY__Pix16__PvPvPUjssss
	movem.l	d2-d7/a2,-(a7)
	movem.l	$20(a7),a0/a1
	move.w	$2E(a7),d3
	move.w	$30(a7),d4
	move.w	$32(a7),d5
	move.w	$2C(a7),d7
L252
;	h++;
	addq.w	#1,d3
; dSpan -= w;
	sub.w	d7,d4
; dSpan *= 3;
	move.w	d4,d0
	muls	#3,d0
	move.w	d0,d4
; sSpan -= w;
	sub.w	d7,d5
;	while(--h)
	bra.b	L257
L253
;		rsint32 x = w+1;
	move.w	d7,d2
	ext.l	d2
	addq.l	#1,d2
;		while(--x)
	bra.b	L255
L254
;			ruint16 pix				= *((uint16*)src)++;
	move.w	(a1)+,d0
;			pix								= _SWP16(pix);
	moveq	#0,d1
	move.w	d0,d1
	moveq	#$8,d6
	asl.l	d6,d1
	and.l	#$FFFF,d0
	moveq	#$8,d6
	asr.l	d6,d0
	or.l	d0,d1
	move.w	d1,d0
;			*((uint8*)dst)++	= _GET16Y(pix);
	moveq	#0,d1
	move.w	d0,d1
	and.l	#$1F,d1
	moveq	#3,d6
	asl.l	d6,d1
	move.b	d1,(a0)+
;			*((uint8*)dst)++	= _GET16G(pix);
	moveq	#0,d1
	move.w	d0,d1
	and.l	#$7E0,d1
	moveq	#3,d6
	asr.l	d6,d1
	move.b	d1,(a0)+
;			*((uint8*)dst)++	= _GET16X(pix);
	and.l	#$FFFF,d0
	and.l	#$F800,d0
	moveq	#$8,d1
	asr.l	d1,d0
	move.b	d0,(a0)+
L255
	subq.l	#1,d2
	tst.l	d2
	bne.b	L254
L256
;		((uint8*)dst)+=dSpan;
	move.w	d4,d0
	ext.l	d0
	add.l	d0,a0
;		((uint16*)src)+=sSpan;
	move.w	d5,d0
	ext.l	d0
	moveq	#1,d1
	asl.l	d1,d0
	add.l	d0,a1
L257
	subq.w	#1,d3
	tst.w	d3
	bne.b	L253
L258
	movem.l	(a7)+,d2-d7/a2
	rts

	SECTION "copy16BETo32BE__Pix16__PvPvPUjssss:0",CODE


;void Pix16::copy16BETo32BE(PXARG)
	XDEF	copy16BETo32BE__Pix16__PvPvPUjssss
copy16BETo32BE__Pix16__PvPvPUjssss
L266	EQU	-$8
	link	a5,#L266
	movem.l	d2-d7/a2,-(a7)
	movem.l	$8(a5),a0/a1
	move.w	$16(a5),d4
	move.w	$1A(a5),d5
	move.w	$18(a5),d7
L259
;	h++;
	addq.w	#1,d4
; dSpan -= w;
	move.w	d7,d0
	sub.w	$14(a5),d0
	move.w	d0,d7
; sSpan -= w;
	sub.w	$14(a5),d5
;	while(--h)
	bra.b	L264
L260
;		rsint32 x = w+1;
	move.w	$14(a5),d3
	ext.l	d3
	addq.l	#1,d3
;		while(--x)
	bra.b	L262
L261
;			ruint32 pix				= *((uint16*)src)++;
	moveq	#0,d1
	move.w	(a1)+,d1
;			*((uint32*)dst)++	= _16TO32(pix);
	move.l	d1,d0
	and.l	#$F800,d0
	moveq	#$8,d2
	asl.l	d2,d0
	move.l	d1,d2
	and.l	#$7E0,d2
	moveq	#5,d6
	asl.l	d6,d2
	or.l	d2,d0
	and.l	#$1F,d1
	moveq	#3,d2
	asl.l	d2,d1
	or.l	d1,d0
	move.l	d0,(a0)+
L262
	subq.l	#1,d3
	tst.l	d3
	bne.b	L261
L263
;		((uint32*)dst)+=dSpan;
	move.w	d7,d0
	ext.l	d0
	moveq	#2,d1
	asl.l	d1,d0
	add.l	d0,a0
;		((uint16*)src)+=sSpan;
	move.w	d5,d0
	ext.l	d0
	moveq	#1,d1
	asl.l	d1,d0
	add.l	d0,a1
L264
	subq.w	#1,d4
	tst.w	d4
	bne.b	L260
L265
	movem.l	(a7)+,d2-d7/a2
	unlk	a5
	rts

	SECTION "copy16LETo32LE__Pix16__PvPvPUjssss:0",CODE


;void Pix16::copy16LETo32LE(PXARG)
	XDEF	copy16LETo32LE__Pix16__PvPvPUjssss
copy16LETo32LE__Pix16__PvPvPUjssss
L274	EQU	-$8
	link	a5,#L274
	movem.l	d2-d7/a2,-(a7)
	movem.l	$8(a5),a0/a1
	move.w	$16(a5),d4
	move.w	$1A(a5),d5
	move.w	$18(a5),d7
L267
;	h++;
	addq.w	#1,d4
; dSpan -= w;
	move.w	d7,d0
	sub.w	$14(a5),d0
	move.w	d0,d7
; sSpan -= w;
	sub.w	$14(a5),d5
;	while(--h)
	bra	L272
L268
;		rsint32 x = w+1;
	move.w	$14(a5),d3
	ext.l	d3
	addq.l	#1,d3
;		while(--x)
	bra.b	L270
L269
;			ruint32 pix				= *((uint16*)src)++;
	moveq	#0,d0
	move.w	(a1)+,d0
;			pix								= _SWP16(pix);
	move.l	d0,d1
	moveq	#$8,d2
	asl.l	d2,d1
	moveq	#$8,d2
	lsr.l	d2,d0
	or.l	d1,d0
;			pix								= _16TO32(pix);
	move.l	d0,d1
	and.l	#$F800,d1
	moveq	#$8,d2
	asl.l	d2,d1
	move.l	d0,d2
	and.l	#$7E0,d2
	moveq	#5,d6
	asl.l	d6,d2
	or.l	d2,d1
	and.l	#$1F,d0
	moveq	#3,d2
	asl.l	d2,d0
	or.l	d1,d0
;			*((uint32*)dst)++	= _SWP32(pix);
	move.l	d0,d1
	moveq	#$18,d2
	asl.l	d2,d1
	move.l	d0,d2
	moveq	#$8,d6
	asl.l	d6,d2
	and.l	#$FF0000,d2
	or.l	d2,d1
	move.l	d0,d2
	moveq	#$8,d6
	lsr.l	d6,d2
	and.l	#$FF00,d2
	or.l	d2,d1
	moveq	#$18,d2
	lsr.l	d2,d0
	or.l	d0,d1
	move.l	d1,(a0)+
L270
	subq.l	#1,d3
	tst.l	d3
	bne.b	L269
L271
;		((uint32*)dst)+=dSpan;
	move.w	d7,d0
	ext.l	d0
	moveq	#2,d1
	asl.l	d1,d0
	add.l	d0,a0
;		((uint16*)src)+=sSpan;
	move.w	d5,d0
	ext.l	d0
	moveq	#1,d1
	asl.l	d1,d0
	add.l	d0,a1
L272
	subq.w	#1,d4
	tst.w	d4
	bne	L268
L273
	movem.l	(a7)+,d2-d7/a2
	unlk	a5
	rts

	SECTION "copy16BETo32LE__Pix16__PvPvPUjssss:0",CODE


;void Pix16::copy16BETo32LE(PXARG)
	XDEF	copy16BETo32LE__Pix16__PvPvPUjssss
copy16BETo32LE__Pix16__PvPvPUjssss
L282	EQU	-$8
	link	a5,#L282
	movem.l	d2-d7/a2,-(a7)
	movem.l	$8(a5),a0/a1
	move.w	$16(a5),d4
	move.w	$1A(a5),d5
	move.w	$18(a5),d7
L275
;	h++;
	addq.w	#1,d4
; dSpan -= w;
	move.w	d7,d0
	sub.w	$14(a5),d0
	move.w	d0,d7
; sSpan -= w;
	sub.w	$14(a5),d5
;	while(--h)
	bra.b	L280
L276
;		rsint32 x = w+1;
	move.w	$14(a5),d3
	ext.l	d3
	addq.l	#1,d3
;		while(--x)
	bra.b	L278
L277
;			ruint32 pix				= *((uint16*)src)++;
	moveq	#0,d0
	move.w	(a1)+,d0
;			pix								= _16TO32(pix);
	move.l	d0,d1
	and.l	#$F800,d1
	moveq	#$8,d2
	asl.l	d2,d1
	move.l	d0,d2
	and.l	#$7E0,d2
	moveq	#5,d6
	asl.l	d6,d2
	or.l	d2,d1
	and.l	#$1F,d0
	moveq	#3,d2
	asl.l	d2,d0
	or.l	d1,d0
;			*((uint32*)dst)++	= _SWP32(pix);
	move.l	d0,d1
	moveq	#$18,d2
	asl.l	d2,d1
	move.l	d0,d2
	moveq	#$8,d6
	asl.l	d6,d2
	and.l	#$FF0000,d2
	or.l	d2,d1
	move.l	d0,d2
	moveq	#$8,d6
	lsr.l	d6,d2
	and.l	#$FF00,d2
	or.l	d2,d1
	moveq	#$18,d2
	lsr.l	d2,d0
	or.l	d0,d1
	move.l	d1,(a0)+
L278
	subq.l	#1,d3
	tst.l	d3
	bne.b	L277
L279
;		((uint32*)dst)+=dSpan;
	move.w	d7,d0
	ext.l	d0
	moveq	#2,d1
	asl.l	d1,d0
	add.l	d0,a0
;		((uint16*)src)+=sSpan;
	move.w	d5,d0
	ext.l	d0
	moveq	#1,d1
	asl.l	d1,d0
	add.l	d0,a1
L280
	subq.w	#1,d4
	tst.w	d4
	bne	L276
L281
	movem.l	(a7)+,d2-d7/a2
	unlk	a5
	rts

	SECTION "copy16LETo32BE__Pix16__PvPvPUjssss:0",CODE


;void Pix16::copy16LETo32BE(PXARG)
	XDEF	copy16LETo32BE__Pix16__PvPvPUjssss
copy16LETo32BE__Pix16__PvPvPUjssss
L290	EQU	-$8
	link	a5,#L290
	movem.l	d2-d7/a2,-(a7)
	movem.l	$8(a5),a0/a1
	move.w	$16(a5),d4
	move.w	$1A(a5),d5
	move.w	$18(a5),d7
L283
;	h++;
	addq.w	#1,d4
; dSpan -= w;
	move.w	d7,d0
	sub.w	$14(a5),d0
	move.w	d0,d7
; sSpan -= w;
	sub.w	$14(a5),d5
;	while(--h)
	bra.b	L288
L284
;		rsint32 x = w+1;
	move.w	$14(a5),d3
	ext.l	d3
	addq.l	#1,d3
;		while(--x)
	bra.b	L286
L285
;			ruint32 pix				= *((uint16*)src)++;
	moveq	#0,d0
	move.w	(a1)+,d0
;			pix								= _SWP16(pix);
	move.l	d0,d1
	moveq	#$8,d2
	asl.l	d2,d1
	moveq	#$8,d2
	lsr.l	d2,d0
	or.l	d1,d0
;			*((uint32*)dst)++	= _16TO32(pix);
	move.l	d0,d1
	and.l	#$F800,d1
	moveq	#$8,d2
	asl.l	d2,d1
	move.l	d0,d2
	and.l	#$7E0,d2
	moveq	#5,d6
	asl.l	d6,d2
	or.l	d2,d1
	and.l	#$1F,d0
	moveq	#3,d2
	asl.l	d2,d0
	or.l	d0,d1
	move.l	d1,(a0)+
L286
	subq.l	#1,d3
	tst.l	d3
	bne.b	L285
L287
;		((uint32*)dst)+=dSpan;
	move.w	d7,d0
	ext.l	d0
	moveq	#2,d1
	asl.l	d1,d0
	add.l	d0,a0
;		((uint16*)src)+=sSpan;
	move.w	d5,d0
	ext.l	d0
	moveq	#1,d1
	asl.l	d1,d0
	add.l	d0,a1
L288
	subq.w	#1,d4
	tst.w	d4
	bne.b	L284
L289
	movem.l	(a7)+,d2-d7/a2
	unlk	a5
	rts

	SECTION "rotate16BETo32BE__Pix16__PvPvPUjssss:0",CODE


;void Pix16::rotate16BETo32BE(PXARG)
	XDEF	rotate16BETo32BE__Pix16__PvPvPUjssss
rotate16BETo32BE__Pix16__PvPvPUjssss
L298	EQU	-$8
	link	a5,#L298
	movem.l	d2-d7/a2,-(a7)
	movem.l	$8(a5),a0/a1
	move.w	$16(a5),d4
	move.w	$1A(a5),d5
	move.w	$18(a5),d7
L291
;	h++;
	addq.w	#1,d4
; dSpan -= w;
	move.w	d7,d0
	sub.w	$14(a5),d0
	move.w	d0,d7
; sSpan -= w;
	sub.w	$14(a5),d5
;	while(--h)
	bra.b	L296
L292
;		rsint32 x = w+1;
	move.w	$14(a5),d3
	ext.l	d3
	addq.l	#1,d3
;		while(--x)
	bra.b	L294
L293
;			ruint32 pix				= *((uint16*)src)++;
	moveq	#0,d0
	move.w	(a1)+,d0
;			pix								= _ROT16(pix);
	move.l	d0,d1
	moveq	#$B,d2
	lsr.l	d2,d1
	move.l	d0,d2
	moveq	#$B,d6
	asl.l	d6,d2
	or.l	d2,d1
	and.l	#$7E0,d0
	or.l	d1,d0
;			*((uint32*)dst)++ =	_16TO32(pix);
	move.l	d0,d1
	and.l	#$F800,d1
	moveq	#$8,d2
	asl.l	d2,d1
	move.l	d0,d2
	and.l	#$7E0,d2
	moveq	#5,d6
	asl.l	d6,d2
	or.l	d2,d1
	and.l	#$1F,d0
	moveq	#3,d2
	asl.l	d2,d0
	or.l	d0,d1
	move.l	d1,(a0)+
L294
	subq.l	#1,d3
	tst.l	d3
	bne.b	L293
L295
;		((uint32*)dst)+=dSpan;
	move.w	d7,d0
	ext.l	d0
	moveq	#2,d1
	asl.l	d1,d0
	add.l	d0,a0
;		((uint16*)src)+=sSpan;
	move.w	d5,d0
	ext.l	d0
	moveq	#1,d1
	asl.l	d1,d0
	add.l	d0,a1
L296
	subq.w	#1,d4
	tst.w	d4
	bne.b	L292
L297
	movem.l	(a7)+,d2-d7/a2
	unlk	a5
	rts

	SECTION "rotate16LETo32LE__Pix16__PvPvPUjssss:0",CODE


;void Pix16::rotate16LETo32LE(PXARG)
	XDEF	rotate16LETo32LE__Pix16__PvPvPUjssss
rotate16LETo32LE__Pix16__PvPvPUjssss
L306	EQU	-$8
	link	a5,#L306
	movem.l	d2-d7/a2,-(a7)
	movem.l	$8(a5),a0/a1
	move.w	$16(a5),d4
	move.w	$1A(a5),d5
	move.w	$18(a5),d7
L299
;	h++;
	addq.w	#1,d4
; dSpan -= w;
	move.w	d7,d0
	sub.w	$14(a5),d0
	move.w	d0,d7
; sSpan -= w;
	sub.w	$14(a5),d5
;	while(--h)
	bra	L304
L300
;		rsint32 x = w+1;
	move.w	$14(a5),d3
	ext.l	d3
	addq.l	#1,d3
;		while(--x)
	bra.b	L302
L301
;			ruint32 pix				= *((uint16*)src)++;
	moveq	#0,d0
	move.w	(a1)+,d0
;			pix								= _SWP16(pix);
	move.l	d0,d1
	moveq	#$8,d2
	asl.l	d2,d1
	moveq	#$8,d2
	lsr.l	d2,d0
	or.l	d1,d0
;			pix								= _ROT16(pix);
	move.l	d0,d1
	moveq	#$B,d2
	lsr.l	d2,d1
	move.l	d0,d2
	moveq	#$B,d6
	asl.l	d6,d2
	or.l	d2,d1
	and.l	#$7E0,d0
	or.l	d1,d0
;			pix								= _16TO32(pix);
	move.l	d0,d1
	and.l	#$F800,d1
	moveq	#$8,d2
	asl.l	d2,d1
	move.l	d0,d2
	and.l	#$7E0,d2
	moveq	#5,d6
	asl.l	d6,d2
	or.l	d2,d1
	and.l	#$1F,d0
	moveq	#3,d2
	asl.l	d2,d0
	or.l	d1,d0
;			*((uint32*)dst)++	= _SWP32(pix);
	move.l	d0,d1
	moveq	#$18,d2
	asl.l	d2,d1
	move.l	d0,d2
	moveq	#$8,d6
	asl.l	d6,d2
	and.l	#$FF0000,d2
	or.l	d2,d1
	move.l	d0,d2
	moveq	#$8,d6
	lsr.l	d6,d2
	and.l	#$FF00,d2
	or.l	d2,d1
	moveq	#$18,d2
	lsr.l	d2,d0
	or.l	d0,d1
	move.l	d1,(a0)+
L302
	subq.l	#1,d3
	tst.l	d3
	bne	L301
L303
;		((uint32*)dst)+=dSpan;
	move.w	d7,d0
	ext.l	d0
	moveq	#2,d1
	asl.l	d1,d0
	add.l	d0,a0
;		((uint16*)src)+=sSpan;
	move.w	d5,d0
	ext.l	d0
	moveq	#1,d1
	asl.l	d1,d0
	add.l	d0,a1
L304
	subq.w	#1,d4
	tst.w	d4
	bne	L300
L305
	movem.l	(a7)+,d2-d7/a2
	unlk	a5
	rts

	SECTION "rotate16BETo32LE__Pix16__PvPvPUjssss:0",CODE


;void Pix16::rotate16BETo32LE(PXARG)
	XDEF	rotate16BETo32LE__Pix16__PvPvPUjssss
rotate16BETo32LE__Pix16__PvPvPUjssss
L314	EQU	-$8
	link	a5,#L314
	movem.l	d2-d7/a2,-(a7)
	movem.l	$8(a5),a0/a1
	move.w	$16(a5),d4
	move.w	$1A(a5),d5
	move.w	$18(a5),d7
L307
;	h++;
	addq.w	#1,d4
; dSpan -= w;
	move.w	d7,d0
	sub.w	$14(a5),d0
	move.w	d0,d7
; sSpan -= w;
	sub.w	$14(a5),d5
;	while(--h)
	bra	L312
L308
;		rsint32 x = w+1;
	move.w	$14(a5),d3
	ext.l	d3
	addq.l	#1,d3
;		while(--x)
	bra.b	L310
L309
;			ruint32 pix				= *((uint16*)src)++;
	moveq	#0,d0
	move.w	(a1)+,d0
;			pix								= _ROT16(pix);
	move.l	d0,d1
	moveq	#$B,d2
	lsr.l	d2,d1
	move.l	d0,d2
	moveq	#$B,d6
	asl.l	d6,d2
	or.l	d2,d1
	and.l	#$7E0,d0
	or.l	d1,d0
;			pix								= _16TO32(pix);
	move.l	d0,d1
	and.l	#$F800,d1
	moveq	#$8,d2
	asl.l	d2,d1
	move.l	d0,d2
	and.l	#$7E0,d2
	moveq	#5,d6
	asl.l	d6,d2
	or.l	d2,d1
	and.l	#$1F,d0
	moveq	#3,d2
	asl.l	d2,d0
	or.l	d1,d0
;			*((uint32*)dst)++ = _SWP32(pix);
	move.l	d0,d1
	moveq	#$18,d2
	asl.l	d2,d1
	move.l	d0,d2
	moveq	#$8,d6
	asl.l	d6,d2
	and.l	#$FF0000,d2
	or.l	d2,d1
	move.l	d0,d2
	moveq	#$8,d6
	lsr.l	d6,d2
	and.l	#$FF00,d2
	or.l	d2,d1
	moveq	#$18,d2
	lsr.l	d2,d0
	or.l	d0,d1
	move.l	d1,(a0)+
L310
	subq.l	#1,d3
	tst.l	d3
	bne.b	L309
L311
;		((uint32*)dst)+=dSpan;
	move.w	d7,d0
	ext.l	d0
	moveq	#2,d1
	asl.l	d1,d0
	add.l	d0,a0
;		((uint16*)src)+=sSpan;
	move.w	d5,d0
	ext.l	d0
	moveq	#1,d1
	asl.l	d1,d0
	add.l	d0,a1
L312
	subq.w	#1,d4
	tst.w	d4
	bne	L308
L313
	movem.l	(a7)+,d2-d7/a2
	unlk	a5
	rts

	SECTION "rotate16LETo32BE__Pix16__PvPvPUjssss:0",CODE


;void Pix16::rotate16LETo32BE(PXARG)
	XDEF	rotate16LETo32BE__Pix16__PvPvPUjssss
rotate16LETo32BE__Pix16__PvPvPUjssss
L322	EQU	-$8
	link	a5,#L322
	movem.l	d2-d7/a2,-(a7)
	movem.l	$8(a5),a0/a1
	move.w	$16(a5),d4
	move.w	$1A(a5),d5
	move.w	$18(a5),d7
L315
;	h++;
	addq.w	#1,d4
; dSpan -= w;
	move.w	d7,d0
	sub.w	$14(a5),d0
	move.w	d0,d7
; sSpan -= w;
	sub.w	$14(a5),d5
;	while(--h)
	bra.b	L320
L316
;		rsint32 x = w+1;
	move.w	$14(a5),d3
	ext.l	d3
	addq.l	#1,d3
;		while(--x)
	bra.b	L318
L317
;			ruint32 pix				= *((uint16*)src)++;
	moveq	#0,d0
	move.w	(a1)+,d0
;			pix								= _SWP16(pix);
	move.l	d0,d1
	moveq	#$8,d2
	asl.l	d2,d1
	moveq	#$8,d2
	lsr.l	d2,d0
	or.l	d1,d0
;			pix								= _ROT16(pix);
	move.l	d0,d1
	moveq	#$B,d2
	lsr.l	d2,d1
	move.l	d0,d2
	moveq	#$B,d6
	asl.l	d6,d2
	or.l	d2,d1
	and.l	#$7E0,d0
	or.l	d1,d0
;			*((uint32*)dst)++	= _16TO32(pix);
	move.l	d0,d1
	and.l	#$F800,d1
	moveq	#$8,d2
	asl.l	d2,d1
	move.l	d0,d2
	and.l	#$7E0,d2
	moveq	#5,d6
	asl.l	d6,d2
	or.l	d2,d1
	and.l	#$1F,d0
	moveq	#3,d2
	asl.l	d2,d0
	or.l	d0,d1
	move.l	d1,(a0)+
L318
	subq.l	#1,d3
	tst.l	d3
	bne.b	L317
L319
;		((uint32*)dst)+=dSpan;
	move.w	d7,d0
	ext.l	d0
	moveq	#2,d1
	asl.l	d1,d0
	add.l	d0,a0
;		((uint16*)src)+=sSpan;
	move.w	d5,d0
	ext.l	d0
	moveq	#1,d1
	asl.l	d1,d0
	add.l	d0,a1
L320
	subq.w	#1,d4
	tst.w	d4
	bne.b	L316
L321
	movem.l	(a7)+,d2-d7/a2
	unlk	a5
	rts

	END
