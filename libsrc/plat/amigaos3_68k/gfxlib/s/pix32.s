
; Storm C Compiler
; EXNG:libsrc/plat/amigaos3_68k/gfxlib/pix32.cpp
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
	XREF	swap32__Mem__r8Pvr9Pvr0Ui
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

	SECTION "copy32BETo15BE__Pix32__PvPvPUjssss:0",CODE


;void Pix32::copy32BETo15BE(PXARG)
	XDEF	copy32BETo15BE__Pix32__PvPvPUjssss
copy32BETo15BE__Pix32__PvPvPUjssss
L130	EQU	-$8
	link	a5,#L130
	movem.l	d2-d7/a2,-(a7)
	movem.l	$8(a5),a0/a1
	move.w	$16(a5),d4
	move.w	$1A(a5),d5
	move.w	$18(a5),d7
L123
;	h++;
	addq.w	#1,d4
; dSpan -= w;
	move.w	d7,d0
	sub.w	$14(a5),d0
	move.w	d0,d7
; sSpan -= w;
	sub.w	$14(a5),d5
;	while(--h)
	bra.b	L128
L124
;		rsint32 x = w+1;
	move.w	$14(a5),d3
	ext.l	d3
	addq.l	#1,d3
;		while(--x)
	bra.b	L126
L125
;			ruint32 pix				= *((uint32*)src)++;
	move.l	(a1)+,d1
;			*((uint16*)dst)++	= _32TO15(pix);
	move.l	d1,d0
	moveq	#$9,d2
	lsr.l	d2,d0
	and.l	#$7C00,d0
	move.l	d1,d2
	moveq	#6,d6
	lsr.l	d6,d2
	and.l	#$3E0,d2
	or.l	d2,d0
	moveq	#3,d2
	lsr.l	d2,d1
	and.l	#$1F,d1
	or.l	d1,d0
	move.w	d0,(a0)+
L126
	subq.l	#1,d3
	tst.l	d3
	bne.b	L125
L127
;		((uint16*)dst)+=dSpan;
	move.w	d7,d0
	ext.l	d0
	moveq	#1,d1
	asl.l	d1,d0
	add.l	d0,a0
;		((uint32*)src)+=sSpan;
	move.w	d5,d0
	ext.l	d0
	moveq	#2,d1
	asl.l	d1,d0
	add.l	d0,a1
L128
	subq.w	#1,d4
	tst.w	d4
	bne.b	L124
L129
	movem.l	(a7)+,d2-d7/a2
	unlk	a5
	rts

	SECTION "copy32LETo15LE__Pix32__PvPvPUjssss:0",CODE


;void Pix32::copy32LETo15LE(PXARG)
	XDEF	copy32LETo15LE__Pix32__PvPvPUjssss
copy32LETo15LE__Pix32__PvPvPUjssss
L138	EQU	-$8
	link	a5,#L138
	movem.l	d2-d7/a2,-(a7)
	movem.l	$8(a5),a0/a1
	move.w	$16(a5),d4
	move.w	$1A(a5),d5
	move.w	$18(a5),d7
L131
;	h++;
	addq.w	#1,d4
; dSpan -= w;
	move.w	d7,d0
	sub.w	$14(a5),d0
	move.w	d0,d7
; sSpan -= w;
	sub.w	$14(a5),d5
;	while(--h)
	bra	L136
L132
;		rsint32 x = w+1;
	move.w	$14(a5),d3
	ext.l	d3
	addq.l	#1,d3
;		while(--x)
	bra.b	L134
L133
;			ruint32	pix				= *((uint32*)src)++;
	move.l	(a1)+,d0
;			pix								= _SWP32(pix);
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
	or.l	d1,d0
;			pix								= _32TO15(pix);
	move.l	d0,d1
	moveq	#$9,d2
	lsr.l	d2,d1
	and.l	#$7C00,d1
	move.l	d0,d2
	moveq	#6,d6
	lsr.l	d6,d2
	and.l	#$3E0,d2
	or.l	d2,d1
	moveq	#3,d2
	lsr.l	d2,d0
	and.l	#$1F,d0
	or.l	d1,d0
;			*((uint16*)dst)++	= _SWP16(pix);
	move.l	d0,d1
	moveq	#$8,d2
	asl.l	d2,d1
	moveq	#$8,d2
	lsr.l	d2,d0
	or.l	d0,d1
	move.w	d1,d0
	move.w	d0,(a0)+
L134
	subq.l	#1,d3
	tst.l	d3
	bne.b	L133
L135
;		((uint16*)dst)+=dSpan;
	move.w	d7,d0
	ext.l	d0
	moveq	#1,d1
	asl.l	d1,d0
	add.l	d0,a0
;		((uint32*)src)+=sSpan;
	move.w	d5,d0
	ext.l	d0
	moveq	#2,d1
	asl.l	d1,d0
	add.l	d0,a1
L136
	subq.w	#1,d4
	tst.w	d4
	bne	L132
L137
	movem.l	(a7)+,d2-d7/a2
	unlk	a5
	rts

	SECTION "copy32BETo15LE__Pix32__PvPvPUjssss:0",CODE


;void Pix32::copy32BETo15LE(PXARG)
	XDEF	copy32BETo15LE__Pix32__PvPvPUjssss
copy32BETo15LE__Pix32__PvPvPUjssss
L146	EQU	-$8
	link	a5,#L146
	movem.l	d2-d7/a2,-(a7)
	movem.l	$8(a5),a0/a1
	move.w	$16(a5),d4
	move.w	$1A(a5),d5
	move.w	$18(a5),d7
L139
;	h++;
	addq.w	#1,d4
; dSpan -= w;
	move.w	d7,d0
	sub.w	$14(a5),d0
	move.w	d0,d7
; sSpan -= w;
	sub.w	$14(a5),d5
;	while(--h)
	bra.b	L144
L140
;		rsint32 x = w+1;
	move.w	$14(a5),d3
	ext.l	d3
	addq.l	#1,d3
;		while(--x)
	bra.b	L142
L141
;			ruint32 pix				= *((uint32*)src)++;
	move.l	(a1)+,d0
;			pix								= _32TO15(pix);
	move.l	d0,d1
	moveq	#$9,d2
	lsr.l	d2,d1
	and.l	#$7C00,d1
	move.l	d0,d2
	moveq	#6,d6
	lsr.l	d6,d2
	and.l	#$3E0,d2
	or.l	d2,d1
	moveq	#3,d2
	lsr.l	d2,d0
	and.l	#$1F,d0
	or.l	d1,d0
;			*((uint16*)dst)++	= _SWP16(pix);
	move.l	d0,d1
	moveq	#$8,d2
	asl.l	d2,d1
	moveq	#$8,d2
	lsr.l	d2,d0
	or.l	d0,d1
	move.w	d1,d0
	move.w	d0,(a0)+
L142
	subq.l	#1,d3
	tst.l	d3
	bne.b	L141
L143
;		((uint16*)dst)+=dSpan;
	move.w	d7,d0
	ext.l	d0
	moveq	#1,d1
	asl.l	d1,d0
	add.l	d0,a0
;		((uint32*)src)+=sSpan;
	move.w	d5,d0
	ext.l	d0
	moveq	#2,d1
	asl.l	d1,d0
	add.l	d0,a1
L144
	subq.w	#1,d4
	tst.w	d4
	bne.b	L140
L145
	movem.l	(a7)+,d2-d7/a2
	unlk	a5
	rts

	SECTION "copy32LETo15BE__Pix32__PvPvPUjssss:0",CODE


;void Pix32::copy32LETo15BE(PXARG)
	XDEF	copy32LETo15BE__Pix32__PvPvPUjssss
copy32LETo15BE__Pix32__PvPvPUjssss
L154	EQU	-$8
	link	a5,#L154
	movem.l	d2-d7/a2,-(a7)
	movem.l	$8(a5),a0/a1
	move.w	$16(a5),d4
	move.w	$1A(a5),d5
	move.w	$18(a5),d7
L147
;	h++;
	addq.w	#1,d4
; dSpan -= w;
	move.w	d7,d0
	sub.w	$14(a5),d0
	move.w	d0,d7
; sSpan -= w;
	sub.w	$14(a5),d5
;	while(--h)
	bra.b	L152
L148
;		rsint32 x = w+1;
	move.w	$14(a5),d3
	ext.l	d3
	addq.l	#1,d3
;		while(--x)
	bra.b	L150
L149
;			ruint32 pix				= *((uint32*)src)++;
	move.l	(a1)+,d0
;			pix								= _SWP32(pix);
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
	or.l	d1,d0
;			*((uint16*)dst)++	= _32TO15(pix);
	move.l	d0,d1
	moveq	#$9,d2
	lsr.l	d2,d1
	and.l	#$7C00,d1
	move.l	d0,d2
	moveq	#6,d6
	lsr.l	d6,d2
	and.l	#$3E0,d2
	or.l	d2,d1
	moveq	#3,d2
	lsr.l	d2,d0
	and.l	#$1F,d0
	or.l	d0,d1
	move.w	d1,d0
	move.w	d0,(a0)+
L150
	subq.l	#1,d3
	tst.l	d3
	bne.b	L149
L151
;		((uint16*)dst)+=dSpan;
	move.w	d7,d0
	ext.l	d0
	moveq	#1,d1
	asl.l	d1,d0
	add.l	d0,a0
;		((uint32*)src)+=sSpan;
	move.w	d5,d0
	ext.l	d0
	moveq	#2,d1
	asl.l	d1,d0
	add.l	d0,a1
L152
	subq.w	#1,d4
	tst.w	d4
	bne	L148
L153
	movem.l	(a7)+,d2-d7/a2
	unlk	a5
	rts

	SECTION "rotate32BETo15BE__Pix32__PvPvPUjssss:0",CODE


;void Pix32::rotate32BETo15BE(PXARG)
	XDEF	rotate32BETo15BE__Pix32__PvPvPUjssss
rotate32BETo15BE__Pix32__PvPvPUjssss
L162	EQU	-$8
	link	a5,#L162
	movem.l	d2-d7/a2,-(a7)
	movem.l	$8(a5),a0/a1
	move.w	$16(a5),d4
	move.w	$1A(a5),d5
	move.w	$18(a5),d7
L155
;	h++;
	addq.w	#1,d4
; dSpan -= w;
	move.w	d7,d0
	sub.w	$14(a5),d0
	move.w	d0,d7
; sSpan -= w;
	sub.w	$14(a5),d5
;	while(--h)
	bra.b	L160
L156
;		rsint32 x = w+1;
	move.w	$14(a5),d3
	ext.l	d3
	addq.l	#1,d3
;		while(--x)
	bra.b	L158
L157
;			ruint32 pix				= *((uint32*)src)++;
	move.l	(a1)+,d0
;			pix								= _ROT32(pix);
	move.l	d0,d1
	and.l	#$FF0000,d1
	moveq	#$10,d2
	lsr.l	d2,d1
	move.l	d0,d2
	and.l	#-$FF0100,d2
	or.l	d2,d1
	and.l	#$FF,d0
	moveq	#$10,d2
	asl.l	d2,d0
	or.l	d1,d0
;			*((uint16*)dst)++	= _32TO15(pix);
	move.l	d0,d1
	moveq	#$9,d2
	lsr.l	d2,d1
	and.l	#$7C00,d1
	move.l	d0,d2
	moveq	#6,d6
	lsr.l	d6,d2
	and.l	#$3E0,d2
	or.l	d2,d1
	moveq	#3,d2
	lsr.l	d2,d0
	and.l	#$1F,d0
	or.l	d0,d1
	move.w	d1,d0
	move.w	d0,(a0)+
L158
	subq.l	#1,d3
	tst.l	d3
	bne.b	L157
L159
;		((uint16*)dst)+=dSpan;
	move.w	d7,d0
	ext.l	d0
	moveq	#1,d1
	asl.l	d1,d0
	add.l	d0,a0
;		((uint32*)src)+=sSpan;
	move.w	d5,d0
	ext.l	d0
	moveq	#2,d1
	asl.l	d1,d0
	add.l	d0,a1
L160
	subq.w	#1,d4
	tst.w	d4
	bne.b	L156
L161
	movem.l	(a7)+,d2-d7/a2
	unlk	a5
	rts

	SECTION "rotate32LETo15LE__Pix32__PvPvPUjssss:0",CODE


;void Pix32::rotate32LETo15LE(PXARG)
	XDEF	rotate32LETo15LE__Pix32__PvPvPUjssss
rotate32LETo15LE__Pix32__PvPvPUjssss
L170	EQU	-$8
	link	a5,#L170
	movem.l	d2-d7/a2,-(a7)
	movem.l	$8(a5),a0/a1
	move.w	$16(a5),d4
	move.w	$1A(a5),d5
	move.w	$18(a5),d7
L163
;	h++;
	addq.w	#1,d4
; dSpan -= w;
	move.w	d7,d0
	sub.w	$14(a5),d0
	move.w	d0,d7
; sSpan -= w;
	sub.w	$14(a5),d5
;	while(--h)
	bra	L168
L164
;		rsint32 x = w+1;
	move.w	$14(a5),d3
	ext.l	d3
	addq.l	#1,d3
;		while(--x)
	bra	L166
L165
;			ruint32 pix				= *((uint32*)src)++;
	move.l	(a1)+,d0
;			pix								= _SWP32(pix);
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
	or.l	d1,d0
;			pix								= _ROT32(pix);
	move.l	d0,d1
	and.l	#$FF0000,d1
	moveq	#$10,d2
	lsr.l	d2,d1
	move.l	d0,d2
	and.l	#-$FF0100,d2
	or.l	d2,d1
	and.l	#$FF,d0
	moveq	#$10,d2
	asl.l	d2,d0
	or.l	d1,d0
;			pix								= _32TO15(pix);
	move.l	d0,d1
	moveq	#$9,d2
	lsr.l	d2,d1
	and.l	#$7C00,d1
	move.l	d0,d2
	moveq	#6,d6
	lsr.l	d6,d2
	and.l	#$3E0,d2
	or.l	d2,d1
	moveq	#3,d2
	lsr.l	d2,d0
	and.l	#$1F,d0
	or.l	d1,d0
;			*((uint16*)dst)++	= _SWP16(pix);
	move.l	d0,d1
	moveq	#$8,d2
	asl.l	d2,d1
	moveq	#$8,d2
	lsr.l	d2,d0
	or.l	d0,d1
	move.w	d1,d0
	move.w	d0,(a0)+
L166
	subq.l	#1,d3
	tst.l	d3
	bne	L165
L167
;		((uint16*)dst)+=dSpan;
	move.w	d7,d0
	ext.l	d0
	moveq	#1,d1
	asl.l	d1,d0
	add.l	d0,a0
;		((uint32*)src)+=sSpan;
	move.w	d5,d0
	ext.l	d0
	moveq	#2,d1
	asl.l	d1,d0
	add.l	d0,a1
L168
	subq.w	#1,d4
	tst.w	d4
	bne	L164
L169
	movem.l	(a7)+,d2-d7/a2
	unlk	a5
	rts

	SECTION "rotate32BETo15LE__Pix32__PvPvPUjssss:0",CODE


;void Pix32::rotate32BETo15LE(PXARG)
	XDEF	rotate32BETo15LE__Pix32__PvPvPUjssss
rotate32BETo15LE__Pix32__PvPvPUjssss
L178	EQU	-$8
	link	a5,#L178
	movem.l	d2-d7/a2,-(a7)
	movem.l	$8(a5),a0/a1
	move.w	$16(a5),d4
	move.w	$1A(a5),d5
	move.w	$18(a5),d7
L171
;	h++;
	addq.w	#1,d4
; dSpan -= w;
	move.w	d7,d0
	sub.w	$14(a5),d0
	move.w	d0,d7
; sSpan -= w;
	sub.w	$14(a5),d5
;	while(--h)
	bra	L176
L172
;		rsint32 x = w+1;
	move.w	$14(a5),d3
	ext.l	d3
	addq.l	#1,d3
;		while(--x)
	bra.b	L174
L173
;			ruint32 pix				= *((uint32*)src)++;
	move.l	(a1)+,d0
;			pix								= _ROT32(pix);
	move.l	d0,d1
	and.l	#$FF0000,d1
	moveq	#$10,d2
	lsr.l	d2,d1
	move.l	d0,d2
	and.l	#-$FF0100,d2
	or.l	d2,d1
	and.l	#$FF,d0
	moveq	#$10,d2
	asl.l	d2,d0
	or.l	d1,d0
;			pix								= _32TO15(pix);
	move.l	d0,d1
	moveq	#$9,d2
	lsr.l	d2,d1
	and.l	#$7C00,d1
	move.l	d0,d2
	moveq	#6,d6
	lsr.l	d6,d2
	and.l	#$3E0,d2
	or.l	d2,d1
	moveq	#3,d2
	lsr.l	d2,d0
	and.l	#$1F,d0
	or.l	d1,d0
;			*((uint16*)dst)++	= _SWP16(pix);
	move.l	d0,d1
	moveq	#$8,d2
	asl.l	d2,d1
	moveq	#$8,d2
	lsr.l	d2,d0
	or.l	d0,d1
	move.w	d1,d0
	move.w	d0,(a0)+
L174
	subq.l	#1,d3
	tst.l	d3
	bne.b	L173
L175
;		((uint16*)dst)+=dSpan;
	move.w	d7,d0
	ext.l	d0
	moveq	#1,d1
	asl.l	d1,d0
	add.l	d0,a0
;		((uint32*)src)+=sSpan;
	move.w	d5,d0
	ext.l	d0
	moveq	#2,d1
	asl.l	d1,d0
	add.l	d0,a1
L176
	subq.w	#1,d4
	tst.w	d4
	bne	L172
L177
	movem.l	(a7)+,d2-d7/a2
	unlk	a5
	rts

	SECTION "rotate32LETo15BE__Pix32__PvPvPUjssss:0",CODE


;void Pix32::rotate32LETo15BE(PXARG)
	XDEF	rotate32LETo15BE__Pix32__PvPvPUjssss
rotate32LETo15BE__Pix32__PvPvPUjssss
L186	EQU	-$8
	link	a5,#L186
	movem.l	d2-d7/a2,-(a7)
	movem.l	$8(a5),a0/a1
	move.w	$16(a5),d4
	move.w	$1A(a5),d5
	move.w	$18(a5),d7
L179
;	h++;
	addq.w	#1,d4
; dSpan -= w;
	move.w	d7,d0
	sub.w	$14(a5),d0
	move.w	d0,d7
; sSpan -= w;
	sub.w	$14(a5),d5
;	while(--h)
	bra	L184
L180
;		rsint32 x = w+1;
	move.w	$14(a5),d3
	ext.l	d3
	addq.l	#1,d3
;		while(--x)
	bra.b	L182
L181
;			ruint32 pix				= *((uint32*)src)++;
	move.l	(a1)+,d0
;			pix								= _SWP32(pix);
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
	or.l	d1,d0
;			pix								= _ROT32(pix);
	move.l	d0,d1
	and.l	#$FF0000,d1
	moveq	#$10,d2
	lsr.l	d2,d1
	move.l	d0,d2
	and.l	#-$FF0100,d2
	or.l	d2,d1
	and.l	#$FF,d0
	moveq	#$10,d2
	asl.l	d2,d0
	or.l	d1,d0
;			*((uint16*)dst)++	= _32TO15(pix);
	move.l	d0,d1
	moveq	#$9,d2
	lsr.l	d2,d1
	and.l	#$7C00,d1
	move.l	d0,d2
	moveq	#6,d6
	lsr.l	d6,d2
	and.l	#$3E0,d2
	or.l	d2,d1
	moveq	#3,d2
	lsr.l	d2,d0
	and.l	#$1F,d0
	or.l	d0,d1
	move.w	d1,d0
	move.w	d0,(a0)+
L182
	subq.l	#1,d3
	tst.l	d3
	bne	L181
L183
;		((uint16*)dst)+=dSpan;
	move.w	d7,d0
	ext.l	d0
	moveq	#1,d1
	asl.l	d1,d0
	add.l	d0,a0
;		((uint32*)src)+=sSpan;
	move.w	d5,d0
	ext.l	d0
	moveq	#2,d1
	asl.l	d1,d0
	add.l	d0,a1
L184
	subq.w	#1,d4
	tst.w	d4
	bne	L180
L185
	movem.l	(a7)+,d2-d7/a2
	unlk	a5
	rts

	SECTION "copy32BETo16BE__Pix32__PvPvPUjssss:0",CODE


;void Pix32::copy32BETo16BE(PXARG)
	XDEF	copy32BETo16BE__Pix32__PvPvPUjssss
copy32BETo16BE__Pix32__PvPvPUjssss
L194	EQU	-$8
	link	a5,#L194
	movem.l	d2-d7/a2,-(a7)
	movem.l	$8(a5),a0/a1
	move.w	$16(a5),d4
	move.w	$1A(a5),d5
	move.w	$18(a5),d7
L187
;	h++;
	addq.w	#1,d4
; dSpan -= w;
	move.w	d7,d0
	sub.w	$14(a5),d0
	move.w	d0,d7
; sSpan -= w;
	sub.w	$14(a5),d5
;	while(--h)
	bra.b	L192
L188
;		rsint32 x = w+1;
	move.w	$14(a5),d3
	ext.l	d3
	addq.l	#1,d3
;		while(--x)
	bra.b	L190
L189
;			ruint32 pix				= *((uint32*)src)++;
	move.l	(a1)+,d1
;			*((uint16*)dst)++	= _32TO16(pix);
	move.l	d1,d0
	moveq	#$8,d2
	lsr.l	d2,d0
	and.l	#$F800,d0
	move.l	d1,d2
	moveq	#5,d6
	lsr.l	d6,d2
	and.l	#$7E0,d2
	or.l	d2,d0
	moveq	#3,d2
	lsr.l	d2,d1
	and.l	#$1F,d1
	or.l	d1,d0
	move.w	d0,(a0)+
L190
	subq.l	#1,d3
	tst.l	d3
	bne.b	L189
L191
;		((uint16*)dst)+=dSpan;
	move.w	d7,d0
	ext.l	d0
	moveq	#1,d1
	asl.l	d1,d0
	add.l	d0,a0
;		((uint32*)src)+=sSpan;
	move.w	d5,d0
	ext.l	d0
	moveq	#2,d1
	asl.l	d1,d0
	add.l	d0,a1
L192
	subq.w	#1,d4
	tst.w	d4
	bne.b	L188
L193
	movem.l	(a7)+,d2-d7/a2
	unlk	a5
	rts

	SECTION "copy32LETo16LE__Pix32__PvPvPUjssss:0",CODE


;void Pix32::copy32LETo16LE(PXARG)
	XDEF	copy32LETo16LE__Pix32__PvPvPUjssss
copy32LETo16LE__Pix32__PvPvPUjssss
L202	EQU	-$8
	link	a5,#L202
	movem.l	d2-d7/a2,-(a7)
	movem.l	$8(a5),a0/a1
	move.w	$16(a5),d4
	move.w	$1A(a5),d5
	move.w	$18(a5),d7
L195
;	h++;
	addq.w	#1,d4
; dSpan -= w;
	move.w	d7,d0
	sub.w	$14(a5),d0
	move.w	d0,d7
; sSpan -= w;
	sub.w	$14(a5),d5
;	while(--h)
	bra	L200
L196
;		rsint32 x = w+1;
	move.w	$14(a5),d3
	ext.l	d3
	addq.l	#1,d3
;		while(--x)
	bra.b	L198
L197
;			ruint32 pix				= *((uint32*)src)++;
	move.l	(a1)+,d0
;			pix								= _SWP32(pix);
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
	or.l	d1,d0
;			pix								= _32TO16(pix);
	move.l	d0,d1
	moveq	#$8,d2
	lsr.l	d2,d1
	and.l	#$F800,d1
	move.l	d0,d2
	moveq	#5,d6
	lsr.l	d6,d2
	and.l	#$7E0,d2
	or.l	d2,d1
	moveq	#3,d2
	lsr.l	d2,d0
	and.l	#$1F,d0
	or.l	d1,d0
;			*((uint16*)dst)++	= _SWP16(pix);
	move.l	d0,d1
	moveq	#$8,d2
	asl.l	d2,d1
	moveq	#$8,d2
	lsr.l	d2,d0
	or.l	d0,d1
	move.w	d1,d0
	move.w	d0,(a0)+
L198
	subq.l	#1,d3
	tst.l	d3
	bne.b	L197
L199
;		((uint16*)dst)+=dSpan;
	move.w	d7,d0
	ext.l	d0
	moveq	#1,d1
	asl.l	d1,d0
	add.l	d0,a0
;		((uint32*)src)+=sSpan;
	move.w	d5,d0
	ext.l	d0
	moveq	#2,d1
	asl.l	d1,d0
	add.l	d0,a1
L200
	subq.w	#1,d4
	tst.w	d4
	bne	L196
L201
	movem.l	(a7)+,d2-d7/a2
	unlk	a5
	rts

	SECTION "copy32BETo16LE__Pix32__PvPvPUjssss:0",CODE


;void Pix32::copy32BETo16LE(PXARG)
	XDEF	copy32BETo16LE__Pix32__PvPvPUjssss
copy32BETo16LE__Pix32__PvPvPUjssss
L210	EQU	-$8
	link	a5,#L210
	movem.l	d2-d7/a2,-(a7)
	movem.l	$8(a5),a0/a1
	move.w	$16(a5),d4
	move.w	$1A(a5),d5
	move.w	$18(a5),d7
L203
;	h++;
	addq.w	#1,d4
; dSpan -= w;
	move.w	d7,d0
	sub.w	$14(a5),d0
	move.w	d0,d7
; sSpan -= w;
	sub.w	$14(a5),d5
;	while(--h)
	bra.b	L208
L204
;		rsint32 x = w+1;
	move.w	$14(a5),d3
	ext.l	d3
	addq.l	#1,d3
;		while(--x)
	bra.b	L206
L205
;			ruint32 pix				= *((uint32*)src)++;
	move.l	(a1)+,d0
;			pix								= _32TO16(pix);
	move.l	d0,d1
	moveq	#$8,d2
	lsr.l	d2,d1
	and.l	#$F800,d1
	move.l	d0,d2
	moveq	#5,d6
	lsr.l	d6,d2
	and.l	#$7E0,d2
	or.l	d2,d1
	moveq	#3,d2
	lsr.l	d2,d0
	and.l	#$1F,d0
	or.l	d1,d0
;			*((uint16*)dst)++	= _SWP16(pix);
	move.l	d0,d1
	moveq	#$8,d2
	asl.l	d2,d1
	moveq	#$8,d2
	lsr.l	d2,d0
	or.l	d0,d1
	move.w	d1,d0
	move.w	d0,(a0)+
L206
	subq.l	#1,d3
	tst.l	d3
	bne.b	L205
L207
;		((uint16*)dst)+=dSpan;
	move.w	d7,d0
	ext.l	d0
	moveq	#1,d1
	asl.l	d1,d0
	add.l	d0,a0
;		((uint32*)src)+=sSpan;
	move.w	d5,d0
	ext.l	d0
	moveq	#2,d1
	asl.l	d1,d0
	add.l	d0,a1
L208
	subq.w	#1,d4
	tst.w	d4
	bne.b	L204
L209
	movem.l	(a7)+,d2-d7/a2
	unlk	a5
	rts

	SECTION "copy32LETo16BE__Pix32__PvPvPUjssss:0",CODE


;void Pix32::copy32LETo16BE(PXARG)
	XDEF	copy32LETo16BE__Pix32__PvPvPUjssss
copy32LETo16BE__Pix32__PvPvPUjssss
L218	EQU	-$8
	link	a5,#L218
	movem.l	d2-d7/a2,-(a7)
	movem.l	$8(a5),a0/a1
	move.w	$16(a5),d4
	move.w	$1A(a5),d5
	move.w	$18(a5),d7
L211
;	h++;
	addq.w	#1,d4
; dSpan -= w;
	move.w	d7,d0
	sub.w	$14(a5),d0
	move.w	d0,d7
; sSpan -= w;
	sub.w	$14(a5),d5
;	while(--h)
	bra.b	L216
L212
;		rsint32 x = w+1;
	move.w	$14(a5),d3
	ext.l	d3
	addq.l	#1,d3
;		while(--x)
	bra.b	L214
L213
;			ruint32 pix				= *((uint32*)src)++;
	move.l	(a1)+,d0
;			pix								= _SWP32(pix);
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
	or.l	d1,d0
;			*((uint16*)dst)++	= _32TO16(pix);
	move.l	d0,d1
	moveq	#$8,d2
	lsr.l	d2,d1
	and.l	#$F800,d1
	move.l	d0,d2
	moveq	#5,d6
	lsr.l	d6,d2
	and.l	#$7E0,d2
	or.l	d2,d1
	moveq	#3,d2
	lsr.l	d2,d0
	and.l	#$1F,d0
	or.l	d0,d1
	move.w	d1,d0
	move.w	d0,(a0)+
L214
	subq.l	#1,d3
	tst.l	d3
	bne.b	L213
L215
;		((uint16*)dst)+=dSpan;
	move.w	d7,d0
	ext.l	d0
	moveq	#1,d1
	asl.l	d1,d0
	add.l	d0,a0
;		((uint32*)src)+=sSpan;
	move.w	d5,d0
	ext.l	d0
	moveq	#2,d1
	asl.l	d1,d0
	add.l	d0,a1
L216
	subq.w	#1,d4
	tst.w	d4
	bne	L212
L217
	movem.l	(a7)+,d2-d7/a2
	unlk	a5
	rts

	SECTION "rotate32BETo16BE__Pix32__PvPvPUjssss:0",CODE


;void Pix32::rotate32BETo16BE(PXARG)
	XDEF	rotate32BETo16BE__Pix32__PvPvPUjssss
rotate32BETo16BE__Pix32__PvPvPUjssss
L226	EQU	-$8
	link	a5,#L226
	movem.l	d2-d7/a2,-(a7)
	movem.l	$8(a5),a0/a1
	move.w	$16(a5),d4
	move.w	$1A(a5),d5
	move.w	$18(a5),d7
L219
;	h++;
	addq.w	#1,d4
; dSpan -= w;
	move.w	d7,d0
	sub.w	$14(a5),d0
	move.w	d0,d7
; sSpan -= w;
	sub.w	$14(a5),d5
;	while(--h)
	bra.b	L224
L220
;		rsint32 x = w+1;
	move.w	$14(a5),d3
	ext.l	d3
	addq.l	#1,d3
;		while(--x)
	bra.b	L222
L221
;			ruint32 pix				= *((uint32*)src)++;
	move.l	(a1)+,d0
;			pix								= _ROT32(pix);
	move.l	d0,d1
	and.l	#$FF0000,d1
	moveq	#$10,d2
	lsr.l	d2,d1
	move.l	d0,d2
	and.l	#-$FF0100,d2
	or.l	d2,d1
	and.l	#$FF,d0
	moveq	#$10,d2
	asl.l	d2,d0
	or.l	d1,d0
;			*((uint16*)dst)++	= _32TO16(pix);
	move.l	d0,d1
	moveq	#$8,d2
	lsr.l	d2,d1
	and.l	#$F800,d1
	move.l	d0,d2
	moveq	#5,d6
	lsr.l	d6,d2
	and.l	#$7E0,d2
	or.l	d2,d1
	moveq	#3,d2
	lsr.l	d2,d0
	and.l	#$1F,d0
	or.l	d0,d1
	move.w	d1,d0
	move.w	d0,(a0)+
L222
	subq.l	#1,d3
	tst.l	d3
	bne.b	L221
L223
;		((uint16*)dst)+=dSpan;
	move.w	d7,d0
	ext.l	d0
	moveq	#1,d1
	asl.l	d1,d0
	add.l	d0,a0
;		((uint32*)src)+=sSpan;
	move.w	d5,d0
	ext.l	d0
	moveq	#2,d1
	asl.l	d1,d0
	add.l	d0,a1
L224
	subq.w	#1,d4
	tst.w	d4
	bne.b	L220
L225
	movem.l	(a7)+,d2-d7/a2
	unlk	a5
	rts

	SECTION "rotate32LETo16LE__Pix32__PvPvPUjssss:0",CODE


;void Pix32::rotate32LETo16LE(PXARG)
	XDEF	rotate32LETo16LE__Pix32__PvPvPUjssss
rotate32LETo16LE__Pix32__PvPvPUjssss
L234	EQU	-$8
	link	a5,#L234
	movem.l	d2-d7/a2,-(a7)
	movem.l	$8(a5),a0/a1
	move.w	$16(a5),d4
	move.w	$1A(a5),d5
	move.w	$18(a5),d7
L227
;	h++;
	addq.w	#1,d4
; dSpan -= w;
	move.w	d7,d0
	sub.w	$14(a5),d0
	move.w	d0,d7
; sSpan -= w;
	sub.w	$14(a5),d5
;	while(--h)
	bra	L232
L228
;		rsint32 x = w+1;
	move.w	$14(a5),d3
	ext.l	d3
	addq.l	#1,d3
;		while(--x)
	bra	L230
L229
;			ruint32 pix				= *((uint32*)src)++;
	move.l	(a1)+,d0
;			pix								= _SWP32(pix);
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
	or.l	d1,d0
;			pix								= _ROT32(pix);
	move.l	d0,d1
	and.l	#$FF0000,d1
	moveq	#$10,d2
	lsr.l	d2,d1
	move.l	d0,d2
	and.l	#-$FF0100,d2
	or.l	d2,d1
	and.l	#$FF,d0
	moveq	#$10,d2
	asl.l	d2,d0
	or.l	d1,d0
;			pix								= _32TO16(pix);
	move.l	d0,d1
	moveq	#$8,d2
	lsr.l	d2,d1
	and.l	#$F800,d1
	move.l	d0,d2
	moveq	#5,d6
	lsr.l	d6,d2
	and.l	#$7E0,d2
	or.l	d2,d1
	moveq	#3,d2
	lsr.l	d2,d0
	and.l	#$1F,d0
	or.l	d1,d0
;			*((uint16*)dst)++	= _SWP16(pix);
	move.l	d0,d1
	moveq	#$8,d2
	asl.l	d2,d1
	moveq	#$8,d2
	lsr.l	d2,d0
	or.l	d0,d1
	move.w	d1,d0
	move.w	d0,(a0)+
L230
	subq.l	#1,d3
	tst.l	d3
	bne	L229
L231
;		((uint16*)dst)+=dSpan;
	move.w	d7,d0
	ext.l	d0
	moveq	#1,d1
	asl.l	d1,d0
	add.l	d0,a0
;		((uint32*)src)+=sSpan;
	move.w	d5,d0
	ext.l	d0
	moveq	#2,d1
	asl.l	d1,d0
	add.l	d0,a1
L232
	subq.w	#1,d4
	tst.w	d4
	bne	L228
L233
	movem.l	(a7)+,d2-d7/a2
	unlk	a5
	rts

	SECTION "rotate32BETo16LE__Pix32__PvPvPUjssss:0",CODE


;void Pix32::rotate32BETo16LE(PXARG)
	XDEF	rotate32BETo16LE__Pix32__PvPvPUjssss
rotate32BETo16LE__Pix32__PvPvPUjssss
L242	EQU	-$8
	link	a5,#L242
	movem.l	d2-d7/a2,-(a7)
	movem.l	$8(a5),a0/a1
	move.w	$16(a5),d4
	move.w	$1A(a5),d5
	move.w	$18(a5),d7
L235
;	h++;
	addq.w	#1,d4
; dSpan -= w;
	move.w	d7,d0
	sub.w	$14(a5),d0
	move.w	d0,d7
; sSpan -= w;
	sub.w	$14(a5),d5
;	while(--h)
	bra	L240
L236
;		rsint32 x = w+1;
	move.w	$14(a5),d3
	ext.l	d3
	addq.l	#1,d3
;		while(--x)
	bra.b	L238
L237
;			ruint32 pix				= *((uint32*)src)++;
	move.l	(a1)+,d0
;			pix								= _ROT32(pix);
	move.l	d0,d1
	and.l	#$FF0000,d1
	moveq	#$10,d2
	lsr.l	d2,d1
	move.l	d0,d2
	and.l	#-$FF0100,d2
	or.l	d2,d1
	and.l	#$FF,d0
	moveq	#$10,d2
	asl.l	d2,d0
	or.l	d1,d0
;			pix								= _32TO16(pix);
	move.l	d0,d1
	moveq	#$8,d2
	lsr.l	d2,d1
	and.l	#$F800,d1
	move.l	d0,d2
	moveq	#5,d6
	lsr.l	d6,d2
	and.l	#$7E0,d2
	or.l	d2,d1
	moveq	#3,d2
	lsr.l	d2,d0
	and.l	#$1F,d0
	or.l	d1,d0
;			*((uint16*)dst)++	= _SWP16(pix);
	move.l	d0,d1
	moveq	#$8,d2
	asl.l	d2,d1
	moveq	#$8,d2
	lsr.l	d2,d0
	or.l	d0,d1
	move.w	d1,d0
	move.w	d0,(a0)+
L238
	subq.l	#1,d3
	tst.l	d3
	bne.b	L237
L239
;		((uint16*)dst)+=dSpan;
	move.w	d7,d0
	ext.l	d0
	moveq	#1,d1
	asl.l	d1,d0
	add.l	d0,a0
;		((uint32*)src)+=sSpan;
	move.w	d5,d0
	ext.l	d0
	moveq	#2,d1
	asl.l	d1,d0
	add.l	d0,a1
L240
	subq.w	#1,d4
	tst.w	d4
	bne	L236
L241
	movem.l	(a7)+,d2-d7/a2
	unlk	a5
	rts

	SECTION "rotate32LETo16BE__Pix32__PvPvPUjssss:0",CODE


;void Pix32::rotate32LETo16BE(PXARG)
	XDEF	rotate32LETo16BE__Pix32__PvPvPUjssss
rotate32LETo16BE__Pix32__PvPvPUjssss
L250	EQU	-$8
	link	a5,#L250
	movem.l	d2-d7/a2,-(a7)
	movem.l	$8(a5),a0/a1
	move.w	$16(a5),d4
	move.w	$1A(a5),d5
	move.w	$18(a5),d7
L243
;	h++;
	addq.w	#1,d4
; dSpan -= w;
	move.w	d7,d0
	sub.w	$14(a5),d0
	move.w	d0,d7
; sSpan -= w;
	sub.w	$14(a5),d5
;	while(--h)
	bra	L248
L244
;		rsint32 x = w+1;
	move.w	$14(a5),d3
	ext.l	d3
	addq.l	#1,d3
;		while(--x)
	bra.b	L246
L245
;			ruint32 pix				= *((uint32*)src)++;
	move.l	(a1)+,d0
;			pix								= _SWP32(pix);
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
	or.l	d1,d0
;			pix								= _ROT32(pix);
	move.l	d0,d1
	and.l	#$FF0000,d1
	moveq	#$10,d2
	lsr.l	d2,d1
	move.l	d0,d2
	and.l	#-$FF0100,d2
	or.l	d2,d1
	and.l	#$FF,d0
	moveq	#$10,d2
	asl.l	d2,d0
	or.l	d1,d0
;			*((uint16*)dst)++	= _32TO16(pix);
	move.l	d0,d1
	moveq	#$8,d2
	lsr.l	d2,d1
	and.l	#$F800,d1
	move.l	d0,d2
	moveq	#5,d6
	lsr.l	d6,d2
	and.l	#$7E0,d2
	or.l	d2,d1
	moveq	#3,d2
	lsr.l	d2,d0
	and.l	#$1F,d0
	or.l	d0,d1
	move.w	d1,d0
	move.w	d0,(a0)+
L246
	subq.l	#1,d3
	tst.l	d3
	bne	L245
L247
;		((uint16*)dst)+=dSpan;
	move.w	d7,d0
	ext.l	d0
	moveq	#1,d1
	asl.l	d1,d0
	add.l	d0,a0
;		((uint32*)src)+=sSpan;
	move.w	d5,d0
	ext.l	d0
	moveq	#2,d1
	asl.l	d1,d0
	add.l	d0,a1
L248
	subq.w	#1,d4
	tst.w	d4
	bne	L244
L249
	movem.l	(a7)+,d2-d7/a2
	unlk	a5
	rts

	SECTION "copy32BETo24XGY__Pix32__PvPvPUjssss:0",CODE


;void Pix32::copy32BETo24XGY(PXARG)
	XDEF	copy32BETo24XGY__Pix32__PvPvPUjssss
copy32BETo24XGY__Pix32__PvPvPUjssss
	movem.l	d2-d7/a2,-(a7)
	movem.l	$20(a7),a0/a1
	move.w	$2E(a7),d3
	move.w	$30(a7),d4
	move.w	$32(a7),d5
	move.w	$2C(a7),d7
L251
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
	bra.b	L256
L252
;		rsint32 x = w+1;
	move.w	d7,d2
	ext.l	d2
	addq.l	#1,d2
;		while(--x)
	bra.b	L254
L253
;			ruint32 pix				= *((uint32*)src)++;
	move.l	(a1)+,d0
;			*((uint8*)dst)++	= _GET32X(pix);
	move.l	d0,d1
	and.l	#$FF0000,d1
	moveq	#$10,d6
	lsr.l	d6,d1
	move.b	d1,(a0)+
;			*((uint8*)dst)++	= _GET32G(pix);
	move.l	d0,d1
	and.l	#$FF00,d1
	moveq	#$8,d6
	lsr.l	d6,d1
	move.b	d1,(a0)+
;			*((uint8*)dst)++	= _GET32Y(pix);
	and.l	#$FF,d0
	move.b	d0,(a0)+
L254
	subq.l	#1,d2
	tst.l	d2
	bne.b	L253
L255
;		((uint8*)dst)+=dSpan;
	move.w	d4,d0
	ext.l	d0
	add.l	d0,a0
;		((uint32*)src)+=sSpan;
	move.w	d5,d0
	ext.l	d0
	moveq	#2,d1
	asl.l	d1,d0
	add.l	d0,a1
L256
	subq.w	#1,d3
	tst.w	d3
	bne.b	L252
L257
	movem.l	(a7)+,d2-d7/a2
	rts

	SECTION "copy32LETo24XGY__Pix32__PvPvPUjssss:0",CODE


;void Pix32::copy32LETo24XGY(PXARG)
	XDEF	copy32LETo24XGY__Pix32__PvPvPUjssss
copy32LETo24XGY__Pix32__PvPvPUjssss
	movem.l	d2-d7/a2,-(a7)
	movem.l	$20(a7),a0/a1
	move.w	$2E(a7),d3
	move.w	$30(a7),d4
	move.w	$32(a7),d5
	move.w	$2C(a7),d7
L258
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
	bra.b	L263
L259
;		rsint32 x = w+1;
	move.w	d7,d2
	ext.l	d2
	addq.l	#1,d2
;		while(--x)
	bra.b	L261
L260
;			ruint32 pix				= *((uint32*)src)++;
	move.l	(a1)+,d0
;			*((uint8*)dst)++	= _GET32Y(pix);
	move.l	d0,d1
	and.l	#$FF,d1
	move.b	d1,(a0)+
;			*((uint8*)dst)++	= _GET32G(pix);
	move.l	d0,d1
	and.l	#$FF00,d1
	moveq	#$8,d6
	lsr.l	d6,d1
	move.b	d1,(a0)+
;			*((uint8*)dst)++	= _GET32X(pix);
	and.l	#$FF0000,d0
	moveq	#$10,d1
	lsr.l	d1,d0
	move.b	d0,(a0)+
L261
	subq.l	#1,d2
	tst.l	d2
	bne.b	L260
L262
;		((uint8*)dst)+=dSpan;
	move.w	d4,d0
	ext.l	d0
	add.l	d0,a0
;		((uint32*)src)+=sSpan;
	move.w	d5,d0
	ext.l	d0
	moveq	#2,d1
	asl.l	d1,d0
	add.l	d0,a1
L263
	subq.w	#1,d3
	tst.w	d3
	bne.b	L259
L264
	movem.l	(a7)+,d2-d7/a2
	rts

	SECTION "rotate32BETo24XGY__Pix32__PvPvPUjssss:0",CODE


;void Pix32::rotate32BETo24XGY(PXARG)
	XDEF	rotate32BETo24XGY__Pix32__PvPvPUjssss
rotate32BETo24XGY__Pix32__PvPvPUjssss
	movem.l	d2-d7/a2,-(a7)
	movem.l	$20(a7),a0/a1
	move.w	$2E(a7),d3
	move.w	$30(a7),d4
	move.w	$32(a7),d5
	move.w	$2C(a7),d7
L265
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
	bra.b	L270
L266
;		rsint32 x = w+1;
	move.w	d7,d2
	ext.l	d2
	addq.l	#1,d2
;		while(--x)
	bra.b	L268
L267
;			ruint32 pix				= *((uint32*)src)++;
	move.l	(a1)+,d0
;			*((uint8*)dst)++	= _GET32Y(pix);
	move.l	d0,d1
	and.l	#$FF,d1
	move.b	d1,(a0)+
;			*((uint8*)dst)++	= _GET32G(pix);
	move.l	d0,d1
	and.l	#$FF00,d1
	moveq	#$8,d6
	lsr.l	d6,d1
	move.b	d1,(a0)+
;			*((uint8*)dst)++	= _GET32X(pix);
	and.l	#$FF0000,d0
	moveq	#$10,d1
	lsr.l	d1,d0
	move.b	d0,(a0)+
L268
	subq.l	#1,d2
	tst.l	d2
	bne.b	L267
L269
;		((uint8*)dst)+=dSpan;
	move.w	d4,d0
	ext.l	d0
	add.l	d0,a0
;		((uint32*)src)+=sSpan;
	move.w	d5,d0
	ext.l	d0
	moveq	#2,d1
	asl.l	d1,d0
	add.l	d0,a1
L270
	subq.w	#1,d3
	tst.w	d3
	bne.b	L266
L271
	movem.l	(a7)+,d2-d7/a2
	rts

	SECTION "rotate32LETo24XGY__Pix32__PvPvPUjssss:0",CODE


;void Pix32::rotate32LETo24XGY(PXARG)
	XDEF	rotate32LETo24XGY__Pix32__PvPvPUjssss
rotate32LETo24XGY__Pix32__PvPvPUjssss
	movem.l	d2-d7/a2,-(a7)
	movem.l	$20(a7),a0/a1
	move.w	$2E(a7),d3
	move.w	$30(a7),d4
	move.w	$32(a7),d5
	move.w	$2C(a7),d7
L272
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
	bra.b	L277
L273
;		rsint32 x = w+1;
	move.w	d7,d2
	ext.l	d2
	addq.l	#1,d2
;		while(--x)
	bra.b	L275
L274
;			ruint32 pix				= *((uint32*)src)++;
	move.l	(a1)+,d0
;			*((uint8*)dst)++	= _GET32X(pix);
	move.l	d0,d1
	and.l	#$FF0000,d1
	moveq	#$10,d6
	lsr.l	d6,d1
	move.b	d1,(a0)+
;			*((uint8*)dst)++	= _GET32G(pix);
	move.l	d0,d1
	and.l	#$FF00,d1
	moveq	#$8,d6
	lsr.l	d6,d1
	move.b	d1,(a0)+
;			*((uint8*)dst)++	= _GET32Y(pix);
	and.l	#$FF,d0
	move.b	d0,(a0)+
L275
	subq.l	#1,d2
	tst.l	d2
	bne.b	L274
L276
;		((uint8*)dst)+=dSpan;
	move.w	d4,d0
	ext.l	d0
	add.l	d0,a0
;		((uint32*)src)+=sSpan;
	move.w	d5,d0
	ext.l	d0
	moveq	#2,d1
	asl.l	d1,d0
	add.l	d0,a1
L277
	subq.w	#1,d3
	tst.w	d3
	bne.b	L273
L278
	movem.l	(a7)+,d2-d7/a2
	rts

	SECTION "copy32XETo32XE__Pix32__PvPvPUjssss:0",CODE


;void Pix32::copy32XETo32XE(PXARG)
	XDEF	copy32XETo32XE__Pix32__PvPvPUjssss
copy32XETo32XE__Pix32__PvPvPUjssss
	movem.l	d2-d5/a2/a3,-(a7)
	move.w	$2A(a7),d2
	move.w	$28(a7),d3
	move.w	$2C(a7),d4
	move.w	$2E(a7),d5
	move.l	$20(a7),a2
	move.l	$1C(a7),a3
L279
;	if (dst==src)
	move.l	a3,a0
	cmp.l	a2,a0
	bne.b	L281
L280
;		return;
	movem.l	(a7)+,d2-d5/a2/a3
	rts
L281
;	else if (dSpan == sSpan && dSpan == w)
	cmp.w	d5,d4
	bne.b	L284
L282
	cmp.w	d3,d4
	bne.b	L284
L283
;		Mem::copy(dst, src, (w*h)<<2);
	move.w	d3,d0
	muls	d2,d0
	moveq	#2,d1
	asl.l	d1,d0
	move.l	a3,a0
	move.l	a2,a1
	jsr	copy__Mem__r8Pvr9Pvr0Ui
	bra.b	L287
L284
;		w<<=2;
	moveq	#2,d0
	asl.w	d0,d3
; h++;
	addq.w	#1,d2
;		while (--h)
	bra.b	L286
L285
;			Mem::copy(dst, src, w);
	move.w	d3,d0
	ext.l	d0
	move.l	a3,a0
	move.l	a2,a1
	jsr	copy__Mem__r8Pvr9Pvr0Ui
;			((uint32*)dst)+=dSpan;
	move.w	d4,d0
	ext.l	d0
	moveq	#2,d1
	asl.l	d1,d0
	add.l	a3,d0
	move.l	d0,a3
;			((uint32*)src)+=sSpan;
	move.w	d5,d0
	ext.l	d0
	moveq	#2,d1
	asl.l	d1,d0
	add.l	d0,a2
L286
	subq.w	#1,d2
	tst.w	d2
	bne.b	L285
L287
	movem.l	(a7)+,d2-d5/a2/a3
	rts

	SECTION "copy32XETo32YE__Pix32__PvPvPUjssss:0",CODE


;void Pix32::copy32XETo32YE(PXARG)
	XDEF	copy32XETo32YE__Pix32__PvPvPUjssss
copy32XETo32YE__Pix32__PvPvPUjssss
	movem.l	d2-d5/a2/a3,-(a7)
	movem.l	$1C(a7),a2/a3
	move.w	$2A(a7),d2
	move.w	$28(a7),d3
	move.w	$2C(a7),d4
	move.w	$2E(a7),d5
L288
;	if (dSpan == sSpan && dSpan == w)
	cmp.w	d5,d4
	bne.b	L291
L289
	cmp.w	d3,d4
	bne.b	L291
L290
;		Mem::swap32(dst, src, w*h);
	move.w	d3,d0
	muls	d2,d0
	move.l	a2,a0
	move.l	a3,a1
	jsr	swap32__Mem__r8Pvr9Pvr0Ui
	bra.b	L294
L291
;		h++;
	addq.w	#1,d2
;		while(--h)
	bra.b	L293
L292
;			Mem::swap32(dst, src, w);
	move.w	d3,d0
	ext.l	d0
	move.l	a2,a0
	move.l	a3,a1
	jsr	swap32__Mem__r8Pvr9Pvr0Ui
;			((uint32*)dst)+=dSpan;
	move.w	d4,d0
	ext.l	d0
	moveq	#2,d1
	asl.l	d1,d0
	add.l	d0,a2
;			((uint32*)src)+=sSpan;
	move.w	d5,d0
	ext.l	d0
	moveq	#2,d1
	asl.l	d1,d0
	add.l	a3,d0
	move.l	d0,a3
L293
	subq.w	#1,d2
	tst.w	d2
	bne.b	L292
L294
	movem.l	(a7)+,d2-d5/a2/a3
	rts

	SECTION "rotate32BETo32BE__Pix32__PvPvPUjssss:0",CODE


;void Pix32::rotate32BETo32BE(PXARG)
	XDEF	rotate32BETo32BE__Pix32__PvPvPUjssss
rotate32BETo32BE__Pix32__PvPvPUjssss
L302	EQU	-$8
	link	a5,#L302
	movem.l	d2-d7/a2,-(a7)
	movem.l	$8(a5),a0/a1
	move.w	$16(a5),d4
	move.w	$1A(a5),d5
	move.w	$18(a5),d7
L295
;	h++;
	addq.w	#1,d4
; dSpan -= w;
	move.w	d7,d0
	sub.w	$14(a5),d0
	move.w	d0,d7
; sSpan -= w;
	sub.w	$14(a5),d5
;	while(--h)
	bra.b	L300
L296
;		rsint32 x = w+1;
	move.w	$14(a5),d2
	ext.l	d2
	addq.l	#1,d2
;		while(--x)
	bra.b	L298
L297
;			ruint32 pix				= *((uint32*)src)++;
	move.l	(a1)+,d1
;			*((uint32*)dst)++ = _ROT32(pix);
	move.l	d1,d0
	and.l	#$FF0000,d0
	moveq	#$10,d3
	lsr.l	d3,d0
	move.l	d1,d3
	and.l	#-$FF0100,d3
	or.l	d3,d0
	and.l	#$FF,d1
	moveq	#$10,d3
	asl.l	d3,d1
	or.l	d1,d0
	move.l	d0,(a0)+
L298
	subq.l	#1,d2
	tst.l	d2
	bne.b	L297
L299
;		((uint32*)dst)+=dSpan;
	move.w	d7,d0
	ext.l	d0
	moveq	#2,d1
	asl.l	d1,d0
	add.l	d0,a0
;		((uint32*)src)+=sSpan;
	move.w	d5,d0
	ext.l	d0
	moveq	#2,d1
	asl.l	d1,d0
	add.l	d0,a1
L300
	subq.w	#1,d4
	tst.w	d4
	bne.b	L296
L301
	movem.l	(a7)+,d2-d7/a2
	unlk	a5
	rts

	SECTION "rotate32LETo32LE__Pix32__PvPvPUjssss:0",CODE


;void Pix32::rotate32LETo32LE(PXARG)
	XDEF	rotate32LETo32LE__Pix32__PvPvPUjssss
rotate32LETo32LE__Pix32__PvPvPUjssss
L310	EQU	-$8
	link	a5,#L310
	movem.l	d2-d7/a2,-(a7)
	movem.l	$8(a5),a0/a1
	move.w	$16(a5),d4
	move.w	$1A(a5),d5
	move.w	$18(a5),d7
L303
;	h++;
	addq.w	#1,d4
; dSpan -= w;
	move.w	d7,d0
	sub.w	$14(a5),d0
	move.w	d0,d7
; sSpan -= w;
	sub.w	$14(a5),d5
;	while(--h)
	bra	L308
L304
;		rsint32 x = w+1;
	move.w	$14(a5),d3
	ext.l	d3
	addq.l	#1,d3
;		while(--x)
	bra.b	L306
L305
;			ruint32 pix = *((uint32*)src)++;
	move.l	(a1)+,d0
;			pix								= _SWP32(pix);
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
	or.l	d1,d0
;			pix								= _ROT32(pix);
	move.l	d0,d1
	and.l	#$FF0000,d1
	moveq	#$10,d2
	lsr.l	d2,d1
	move.l	d0,d2
	and.l	#-$FF0100,d2
	or.l	d2,d1
	and.l	#$FF,d0
	moveq	#$10,d2
	asl.l	d2,d0
	or.l	d1,d0
;			*((uint32*)dst)++	=	_SWP32(pix);
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
L306
	subq.l	#1,d3
	tst.l	d3
	bne	L305
L307
;		((uint32*)dst)+=dSpan;
	move.w	d7,d0
	ext.l	d0
	moveq	#2,d1
	asl.l	d1,d0
	add.l	d0,a0
;		((uint32*)src)+=sSpan;
	move.w	d5,d0
	ext.l	d0
	moveq	#2,d1
	asl.l	d1,d0
	add.l	d0,a1
L308
	subq.w	#1,d4
	tst.w	d4
	bne	L304
L309
	movem.l	(a7)+,d2-d7/a2
	unlk	a5
	rts

	SECTION "rotate32BETo32LE__Pix32__PvPvPUjssss:0",CODE


;void Pix32::rotate32BETo32LE(PXARG)
	XDEF	rotate32BETo32LE__Pix32__PvPvPUjssss
rotate32BETo32LE__Pix32__PvPvPUjssss
L318	EQU	-$8
	link	a5,#L318
	movem.l	d2-d7/a2,-(a7)
	movem.l	$8(a5),a0/a1
	move.w	$16(a5),d4
	move.w	$1A(a5),d5
	move.w	$18(a5),d7
L311
;	h++;
	addq.w	#1,d4
; dSpan -= w;
	move.w	d7,d0
	sub.w	$14(a5),d0
	move.w	d0,d7
; sSpan -= w;
	sub.w	$14(a5),d5
;	while(--h)
	bra.b	L316
L312
;		rsint32 x = w+1;
	move.w	$14(a5),d3
	ext.l	d3
	addq.l	#1,d3
;		while(--x)
	bra.b	L314
L313
;			ruint32 pix				= *((uint32*)src)++;
	move.l	(a1)+,d0
;			pix								= _ROT32(pix);
	move.l	d0,d1
	and.l	#$FF0000,d1
	moveq	#$10,d2
	lsr.l	d2,d1
	move.l	d0,d2
	and.l	#-$FF0100,d2
	or.l	d2,d1
	and.l	#$FF,d0
	moveq	#$10,d2
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
L314
	subq.l	#1,d3
	tst.l	d3
	bne.b	L313
L315
;		((uint32*)dst)+=dSpan;
	move.w	d7,d0
	ext.l	d0
	moveq	#2,d1
	asl.l	d1,d0
	add.l	d0,a0
;		((uint32*)src)+=sSpan;
	move.w	d5,d0
	ext.l	d0
	moveq	#2,d1
	asl.l	d1,d0
	add.l	d0,a1
L316
	subq.w	#1,d4
	tst.w	d4
	bne.b	L312
L317
	movem.l	(a7)+,d2-d7/a2
	unlk	a5
	rts

	SECTION "rotate32LETo32BE__Pix32__PvPvPUjssss:0",CODE


;void Pix32::rotate32LETo32BE(PXARG)
	XDEF	rotate32LETo32BE__Pix32__PvPvPUjssss
rotate32LETo32BE__Pix32__PvPvPUjssss
L326	EQU	-$8
	link	a5,#L326
	movem.l	d2-d7/a2,-(a7)
	movem.l	$8(a5),a0/a1
	move.w	$16(a5),d4
	move.w	$1A(a5),d5
	move.w	$18(a5),d7
L319
;	h++;
	addq.w	#1,d4
; dSpan -= w;
	move.w	d7,d0
	sub.w	$14(a5),d0
	move.w	d0,d7
; sSpan -= w;
	sub.w	$14(a5),d5
;	while(--h)
	bra.b	L324
L320
;		rsint32 x = w+1;
	move.w	$14(a5),d3
	ext.l	d3
	addq.l	#1,d3
;		while(--x)
	bra.b	L322
L321
;			ruint32 pix				= *((uint32*)src)++;
	move.l	(a1)+,d0
;			pix								= _SWP32(pix);
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
	or.l	d1,d0
;			*((uint32*)dst)++	= _ROT32(pix);
	move.l	d0,d1
	and.l	#$FF0000,d1
	moveq	#$10,d2
	lsr.l	d2,d1
	move.l	d0,d2
	and.l	#-$FF0100,d2
	or.l	d2,d1
	and.l	#$FF,d0
	moveq	#$10,d2
	asl.l	d2,d0
	or.l	d0,d1
	move.l	d1,(a0)+
L322
	subq.l	#1,d3
	tst.l	d3
	bne.b	L321
L323
;		((uint32*)dst)+=dSpan;
	move.w	d7,d0
	ext.l	d0
	moveq	#2,d1
	asl.l	d1,d0
	add.l	d0,a0
;		((uint32*)src)+=sSpan;
	move.w	d5,d0
	ext.l	d0
	moveq	#2,d1
	asl.l	d1,d0
	add.l	d0,a1
L324
	subq.w	#1,d4
	tst.w	d4
	bne.b	L320
L325
	movem.l	(a7)+,d2-d7/a2
	unlk	a5
	rts

	END
