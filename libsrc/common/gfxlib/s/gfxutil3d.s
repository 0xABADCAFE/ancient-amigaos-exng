
; Storm C Compiler
; exng:libsrc/common/gfxlib/gfxutil3d.cpp
	mc68030
	mc68881
	XREF	writeBytes__StreamOut__TPvUi
	XREF	close__StreamOut__T
	XREF	open__StreamOut__TPCcssUi
	XREF	rawReadBytes__StreamOut__TPvUij
	XREF	readText__StreamIn__TPcjcj
	XREF	readBytes__StreamIn__TPvUi
	XREF	close__StreamIn__T
	XREF	open__StreamIn__TPCcsUi
	XREF	rawWriteBytes__StreamIn__TPvUij
	XREF	destroy__AsyncStreamBuffer__T
	XREF	sendPacket__AsyncStreamBuffer__TPv
	XREF	waitPacket__AsyncStreamBuffer__T
	XREF	_0dt__Texture__T
	XREF	create__Texture__TssEP07Palette
	XREF	_0dt__Rasterizer__T
	XREF	obtain__Rasterizer__P07Surface
	XREF	_W3D_DrawElements
	XREF	_W3D_DrawArray
	XREF	_W3D_BindTexture
	XREF	_W3D_ColorPointer
	XREF	_W3D_TexCoordPointer
	XREF	_W3D_VertexPointer
	XREF	destroy__Mesh__T
	XREF	create__Mesh__TUsUs
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
	XREF	_sscanf
	XREF	_system
	XREF	op__delete__PvUi
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
	XREF	_Warp3DBase
	XREF	_state__Native3D
	XREF	_query__Native3D
	XREF	_alphaTest__Native3D
	XREF	_zBuffTest__Native3D
	XREF	_logicOp__Native3D
	XREF	_fogMode__Native3D
	XREF	_blendMode__Native3D
	XREF	_frontFace__Native3D
	XREF	_texel__Native3D
	XREF	_texEnv__Native3D
	XREF	_texFill__Native3D
	XREF	_texFilter__Native3D
	XREF	_coordType__Native3D
	XREF	_colourType__Native3D
	XREF	_texCoordType__Native3D
	XREF	_openCnt__Rasterizer
	XREF	_drawPointsXYZ_F32__Rasterizer
	XREF	_drawPointsXYZ_F64__Rasterizer
	XREF	_drawLinesXYZ_F32__Rasterizer
	XREF	_drawLinesXYZ_F64__Rasterizer
	XREF	_drawLineStripXYZ_F32__Rasterizer
	XREF	_drawLineStripXYZ_F64__Rasterizer
	XREF	_useArrayEmul__Rasterizer
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

	SECTION "loadPPM__TextureLoader__P07TexturePCcE:0",CODE


;sint32 TextureLoader::loadPPM(Texture* tex, const char* ppm, G3D::Te
	XDEF	loadPPM__TextureLoader__P07TexturePCcE
loadPPM__TextureLoader__P07TexturePCcE
L282	EQU	-$100
	link	a5,#L282
	movem.l	d2-d4/a2/a6,-(a7)
	move.l	$10(a5),d4
	move.l	$C(a5),a1
	move.l	$8(a5),a6
L85
;	if (!tex || !ppm)
	cmp.w	#0,a6
	beq.b	L87
L86
	cmp.w	#0,a1
	bne.b	L88
L87
;		return ERR_PTR_ZERO;
	move.l	#-$3020002,d0
	movem.l	(a7)+,d2-d4/a2/a6
	unlk	a5
	rts
L88
;	if (tex->getData())
	tst.l	$C(a6)
	beq.b	L90
L89
;		return ERR_RSC_LOCKED;
	move.l	#-$3050004,d0
	movem.l	(a7)+,d2-d4/a2/a6
	unlk	a5
	rts
L90
;	switch (fmt)
	move.l	d4,d0
	cmp.l	#2,d0
	beq.b	L91
	bgt.b	L283
	cmp.l	#0,d0
	beq.b	L91
	cmp.l	#1,d0
	beq.b	L91
	bra.b	L92
L283
	cmp.l	#3,d0
	beq.b	L91
	cmp.l	#7,d0
	beq.b	L91
	bra.b	L92
;		
L91
;		case G3D::TXL_GA88:	return ERR_RSC_TYPE;
	move.l	#-$3050003,d0
	movem.l	(a7)+,d2-d4/a2/a6
	unlk	a5
	rts
L92
;		default: 
;	StreamIn ppmFile;
	lea	-$96(a5),a0
	clr.l	$18(a0)
	clr.l	$1C(a0)
	clr.l	$C(a0)
;	sint32 result = ppmFile.open(ppm, false);
	pea	$800.w
	clr.w	-(a7)
	move.l	a1,-(a7)
	pea	-$96(a5)
	jsr	open__StreamIn__TPCcsUi
	add.w	#$E,a7
	move.l	d0,d3
;	if (result!=OK)
	beq.b	L94
L93
	lea	-$96(a5),a6
	move.l	a6,-(a7)
	jsr	close__StreamIn__T
	addq.w	#4,a7
	pea	(a6)
	jsr	destroy__AsyncStreamBuffer__T
	addq.w	#4,a7
	move.l	d3,d0
	movem.l	(a7)+,d2-d4/a2/a6
	unlk	a5
	rts
L94
;	result = ppmFile.readText(header, 63, '\n', 4);
	pea	4.w
	move.b	#$A,-(a7)
	pea	$3F.w
	pea	-$DA(a5)
	pea	-$96(a5)
	jsr	readText__StreamIn__TPcjcj
	add.w	#$12,a7
	move.l	d0,d3
;	if (result <0)
	bpl.b	L96
L95
	lea	-$96(a5),a6
	move.l	a6,-(a7)
	jsr	close__StreamIn__T
	addq.w	#4,a7
	pea	(a6)
	jsr	destroy__AsyncStreamBuffer__T
	addq.w	#4,a7
	move.l	d3,d0
	movem.l	(a7)+,d2-d4/a2/a6
	unlk	a5
	rts
L96
;	if (sscanf(header, "P6\n%d\n%d\n255\n", &width, &height)!=2)
	pea	-$E2(a5)
	pea	-$DE(a5)
	move.l	#L84,-(a7)
	pea	-$DA(a5)
	jsr	_sscanf
	add.w	#$10,a7
	cmp.l	#2,d0
	beq.b	L98
L97
	lea	-$96(a5),a6
	move.l	a6,-(a7)
	jsr	close__StreamIn__T
	addq.w	#4,a7
	pea	(a6)
	jsr	destroy__AsyncStreamBuffer__T
	addq.w	#4,a7
	move.l	#-$3040004,d0
	movem.l	(a7)+,d2-d4/a2/a6
	unlk	a5
	rts
L98
;	if (width < G3D::MIN_TEX_WIDTH		|| width > G3D::MAX_TEX_WIDTH ||
	move.l	-$DE(a5),d0
	cmp.l	#2,d0
	blt.b	L102
L99
	move.l	-$DE(a5),d0
	cmp.l	#$200,d0
	bgt.b	L102
L100
	move.l	-$E2(a5),d0
	cmp.l	#2,d0
	blt.b	L102
L101
	move.l	-$E2(a5),d0
	cmp.l	#$200,d0
	ble.b	L103
L102
	lea	-$96(a5),a6
	move.l	a6,-(a7)
	jsr	close__StreamIn__T
	addq.w	#4,a7
	pea	(a6)
	jsr	destroy__AsyncStreamBuffer__T
	addq.w	#4,a7
	move.l	#-$3010000,d0
	movem.l	(a7)+,d2-d4/a2/a6
	unlk	a5
	rts
L103
;	result = tex->create(width, height, fmt);
	clr.l	-(a7)
	move.l	d4,-(a7)
	move.w	-$E0(a5),-(a7)
	move.w	-$DC(a5),-(a7)
	move.l	a6,-(a7)
	jsr	create__Texture__TssEP07Palette
	add.w	#$10,a7
	move.l	d0,d3
;	if (result!=OK)
	beq.b	L105
L104
	lea	-$96(a5),a6
	move.l	a6,-(a7)
	jsr	close__StreamIn__T
	addq.w	#4,a7
	pea	(a6)
	jsr	destroy__AsyncStreamBuffer__T
	addq.w	#4,a7
	move.l	d3,d0
	movem.l	(a7)+,d2-d4/a2/a6
	unlk	a5
	rts
L105
;	size_t numTexels = width*height;
	move.l	-$DE(a5),d2
	muls.l	-$E2(a5),d2
;	switch (fmt)
	subq.l	#4,d4
	cmp.l	#6,d4
	bhi	L281
	move.l	L284(pc,d4.l*4),a0
	jmp	(a0)
L284
	dc.l	L106
	dc.l	L140
	dc.l	L174
	dc.l	L281
	dc.l	L208
	dc.l	L213
	dc.l	L247
;		
L106
;			uint16* data = (uint16*)tex->getData();
	move.l	$C(a6),a2
;			numTexels++;
	addq.l	#1,d2
;			while (--numTexels && !ppmFile.end())
	bra	L135
L107
;				ruint16 txl = ((uint8)ppmFile.getChar()&0xF8)<<8;
	lea	-$96(a5),a6
	tst.l	$24(a6)
	bne	L115
L108
	move.l	a6,-(a7)
	jsr	waitPacket__AsyncStreamBuffer__T
	addq.w	#4,a7
	move.l	d0,d3
	cmp.l	#0,d3
	bgt.b	L112
L109
	tst.l	d3
	bne.b	L111
L110
	or.l	#2,$18(a6)
	move.l	_DOSBase,a6
	moveq	#0,d1
	jsr	-$1CE(a6)
	moveq	#-1,d0
	bra.b	L116
L111
	and.l	#-$9,$18(a6)
	move.l	#-$3040004,d0
	bra.b	L116
L112
	moveq	#1,d0
	sub.l	$8E(a6),d0
	lea	$C(a6),a0
	move.l	0(a0,d0.l*4),-(a7)
	move.l	a6,-(a7)
	jsr	sendPacket__AsyncStreamBuffer__TPv
	addq.w	#$8,a7
	move.l	$92(a6),d0
	cmp.l	d3,d0
	bls.b	L114
L113
	move.l	d3,$92(a6)
L114
	lea	$C(a6),a0
	move.l	$8E(a6),d0
	move.l	0(a0,d0.l*4),a0
	move.l	$92(a6),d0
	lea	0(a0,d0.l),a0
	move.l	a0,$14(a6)
	eor.l	#1,$8E(a6)
	sub.l	$92(a6),d3
	move.l	d3,$24(a6)
	clr.l	$92(a6)
L115
	subq.l	#1,$24(a6)
	move.l	$14(a6),a1
	lea	1(a1),a0
	move.l	a0,$14(a6)
	move.b	(a1),d0
	extb.l	d0
L116
	and.l	#$FF,d0
	and.l	#$F8,d0
	moveq	#$8,d1
	asl.l	d1,d0
	move.w	d0,d4
;				txl |= ((uint8)ppmFile.getChar()&0xFC)<<3;
	lea	-$96(a5),a6
	tst.l	$24(a6)
	bne	L124
L117
	move.l	a6,-(a7)
	jsr	waitPacket__AsyncStreamBuffer__T
	addq.w	#4,a7
	move.l	d0,d3
	cmp.l	#0,d3
	bgt.b	L121
L118
	tst.l	d3
	bne.b	L120
L119
	or.l	#2,$18(a6)
	move.l	_DOSBase,a6
	moveq	#0,d1
	jsr	-$1CE(a6)
	moveq	#-1,d0
	bra	L125
L120
	and.l	#-$9,$18(a6)
	move.l	#-$3040004,d0
	bra.b	L125
L121
	moveq	#1,d0
	sub.l	$8E(a6),d0
	lea	$C(a6),a0
	move.l	0(a0,d0.l*4),-(a7)
	move.l	a6,-(a7)
	jsr	sendPacket__AsyncStreamBuffer__TPv
	addq.w	#$8,a7
	move.l	$92(a6),d0
	cmp.l	d3,d0
	bls.b	L123
L122
	move.l	d3,$92(a6)
L123
	lea	$C(a6),a0
	move.l	$8E(a6),d0
	move.l	0(a0,d0.l*4),a0
	move.l	$92(a6),d0
	lea	0(a0,d0.l),a0
	move.l	a0,$14(a6)
	eor.l	#1,$8E(a6)
	sub.l	$92(a6),d3
	move.l	d3,$24(a6)
	clr.l	$92(a6)
L124
	subq.l	#1,$24(a6)
	move.l	$14(a6),a1
	lea	1(a1),a0
	move.l	a0,$14(a6)
	move.b	(a1),d0
	extb.l	d0
L125
	and.l	#$FF,d0
	and.l	#$FC,d0
	moveq	#3,d1
	asl.l	d1,d0
	or.w	d0,d4
;				txl |= ((uint8)ppmFile.getChar())>>3;
	lea	-$96(a5),a6
	tst.l	$24(a6)
	bne	L133
L126
	move.l	a6,-(a7)
	jsr	waitPacket__AsyncStreamBuffer__T
	addq.w	#4,a7
	move.l	d0,d3
	cmp.l	#0,d3
	bgt.b	L130
L127
	tst.l	d3
	bne.b	L129
L128
	or.l	#2,$18(a6)
	move.l	_DOSBase,a6
	moveq	#0,d1
	jsr	-$1CE(a6)
	moveq	#-1,d0
	bra	L134
L129
	and.l	#-$9,$18(a6)
	move.l	#-$3040004,d0
	bra.b	L134
L130
	moveq	#1,d0
	sub.l	$8E(a6),d0
	lea	$C(a6),a0
	move.l	0(a0,d0.l*4),-(a7)
	move.l	a6,-(a7)
	jsr	sendPacket__AsyncStreamBuffer__TPv
	addq.w	#$8,a7
	move.l	$92(a6),d0
	cmp.l	d3,d0
	bls.b	L132
L131
	move.l	d3,$92(a6)
L132
	lea	$C(a6),a0
	move.l	$8E(a6),d0
	move.l	0(a0,d0.l*4),a0
	move.l	$92(a6),d0
	lea	0(a0,d0.l),a0
	move.l	a0,$14(a6)
	eor.l	#1,$8E(a6)
	sub.l	$92(a6),d3
	move.l	d3,$24(a6)
	clr.l	$92(a6)
L133
	subq.l	#1,$24(a6)
	move.l	$14(a6),a1
	lea	1(a1),a0
	move.l	a0,$14(a6)
	move.b	(a1),d0
	extb.l	d0
L134
	and.l	#$FF,d0
	moveq	#3,d1
	asr.l	d1,d0
	or.w	d0,d4
;				*data++ = txl;
	move.w	d4,(a2)+
L135
	subq.l	#1,d2
	tst.l	d2
	beq.b	L137
L136
	move.l	-$7E(a5),d0
	and.l	#2,d0
	tst.w	d0
	beq	L107
L137
;			if (numTexels!=0)
	tst.l	d2
	beq.b	L139
L138
	lea	-$96(a5),a6
	move.l	a6,-(a7)
	jsr	close__StreamIn__T
	addq.w	#4,a7
	pea	(a6)
	jsr	destroy__AsyncStreamBuffer__T
	addq.w	#4,a7
	move.l	#-$2040004,d0
	movem.l	(a7)+,d2-d4/a2/a6
	unlk	a5
	rts
L139
	lea	-$96(a5),a6
	move.l	a6,-(a7)
	jsr	close__StreamIn__T
	addq.w	#4,a7
	pea	(a6)
	jsr	destroy__AsyncStreamBuffer__T
	addq.w	#4,a7
	moveq	#0,d0
	movem.l	(a7)+,d2-d4/a2/a6
	unlk	a5
	rts
L140
;			uint16* data = (uint16*)tex->getData();
	move.l	$C(a6),a2
;			numTexels++;
	addq.l	#1,d2
;			while (--numTexels && !ppmFile.end())
	bra	L169
L141
;				ruint16 txl = 0x8000 | ((uint8)ppmFile.getChar()&0xF8)<<7;
	lea	-$96(a5),a6
	tst.l	$24(a6)
	bne	L149
L142
	move.l	a6,-(a7)
	jsr	waitPacket__AsyncStreamBuffer__T
	addq.w	#4,a7
	move.l	d0,d3
	cmp.l	#0,d3
	bgt.b	L146
L143
	tst.l	d3
	bne.b	L145
L144
	or.l	#2,$18(a6)
	move.l	_DOSBase,a6
	moveq	#0,d1
	jsr	-$1CE(a6)
	moveq	#-1,d0
	bra	L150
L145
	and.l	#-$9,$18(a6)
	move.l	#-$3040004,d0
	bra.b	L150
L146
	moveq	#1,d0
	sub.l	$8E(a6),d0
	lea	$C(a6),a0
	move.l	0(a0,d0.l*4),-(a7)
	move.l	a6,-(a7)
	jsr	sendPacket__AsyncStreamBuffer__TPv
	addq.w	#$8,a7
	move.l	$92(a6),d0
	cmp.l	d3,d0
	bls.b	L148
L147
	move.l	d3,$92(a6)
L148
	lea	$C(a6),a0
	move.l	$8E(a6),d0
	move.l	0(a0,d0.l*4),a0
	move.l	$92(a6),d0
	lea	0(a0,d0.l),a0
	move.l	a0,$14(a6)
	eor.l	#1,$8E(a6)
	sub.l	$92(a6),d3
	move.l	d3,$24(a6)
	clr.l	$92(a6)
L149
	subq.l	#1,$24(a6)
	move.l	$14(a6),a1
	lea	1(a1),a0
	move.l	a0,$14(a6)
	move.b	(a1),d0
	extb.l	d0
L150
	and.l	#$FF,d0
	and.l	#$F8,d0
	moveq	#7,d1
	asl.l	d1,d0
	or.l	#$8000,d0
	move.w	d0,d4
;				txl |= ((uint8)ppmFile.getChar()&0xF8)<<2;
	lea	-$96(a5),a6
	tst.l	$24(a6)
	bne	L158
L151
	move.l	a6,-(a7)
	jsr	waitPacket__AsyncStreamBuffer__T
	addq.w	#4,a7
	move.l	d0,d3
	cmp.l	#0,d3
	bgt.b	L155
L152
	tst.l	d3
	bne.b	L154
L153
	or.l	#2,$18(a6)
	move.l	_DOSBase,a6
	moveq	#0,d1
	jsr	-$1CE(a6)
	moveq	#-1,d0
	bra	L159
L154
	and.l	#-$9,$18(a6)
	move.l	#-$3040004,d0
	bra.b	L159
L155
	moveq	#1,d0
	sub.l	$8E(a6),d0
	lea	$C(a6),a0
	move.l	0(a0,d0.l*4),-(a7)
	move.l	a6,-(a7)
	jsr	sendPacket__AsyncStreamBuffer__TPv
	addq.w	#$8,a7
	move.l	$92(a6),d0
	cmp.l	d3,d0
	bls.b	L157
L156
	move.l	d3,$92(a6)
L157
	lea	$C(a6),a0
	move.l	$8E(a6),d0
	move.l	0(a0,d0.l*4),a0
	move.l	$92(a6),d0
	lea	0(a0,d0.l),a0
	move.l	a0,$14(a6)
	eor.l	#1,$8E(a6)
	sub.l	$92(a6),d3
	move.l	d3,$24(a6)
	clr.l	$92(a6)
L158
	subq.l	#1,$24(a6)
	move.l	$14(a6),a1
	lea	1(a1),a0
	move.l	a0,$14(a6)
	move.b	(a1),d0
	extb.l	d0
L159
	and.l	#$FF,d0
	and.l	#$F8,d0
	moveq	#2,d1
	asl.l	d1,d0
	or.w	d0,d4
;				txl |= ((uint8)ppmFile.getChar())>>3;
	lea	-$96(a5),a6
	tst.l	$24(a6)
	bne	L167
L160
	move.l	a6,-(a7)
	jsr	waitPacket__AsyncStreamBuffer__T
	addq.w	#4,a7
	move.l	d0,d3
	cmp.l	#0,d3
	bgt.b	L164
L161
	tst.l	d3
	bne.b	L163
L162
	or.l	#2,$18(a6)
	move.l	_DOSBase,a6
	moveq	#0,d1
	jsr	-$1CE(a6)
	moveq	#-1,d0
	bra	L168
L163
	and.l	#-$9,$18(a6)
	move.l	#-$3040004,d0
	bra.b	L168
L164
	moveq	#1,d0
	sub.l	$8E(a6),d0
	lea	$C(a6),a0
	move.l	0(a0,d0.l*4),-(a7)
	move.l	a6,-(a7)
	jsr	sendPacket__AsyncStreamBuffer__TPv
	addq.w	#$8,a7
	move.l	$92(a6),d0
	cmp.l	d3,d0
	bls.b	L166
L165
	move.l	d3,$92(a6)
L166
	lea	$C(a6),a0
	move.l	$8E(a6),d0
	move.l	0(a0,d0.l*4),a0
	move.l	$92(a6),d0
	lea	0(a0,d0.l),a0
	move.l	a0,$14(a6)
	eor.l	#1,$8E(a6)
	sub.l	$92(a6),d3
	move.l	d3,$24(a6)
	clr.l	$92(a6)
L167
	subq.l	#1,$24(a6)
	move.l	$14(a6),a1
	lea	1(a1),a0
	move.l	a0,$14(a6)
	move.b	(a1),d0
	extb.l	d0
L168
	and.l	#$FF,d0
	moveq	#3,d1
	asr.l	d1,d0
	or.w	d0,d4
;				*data++ = txl;
	move.w	d4,(a2)+
L169
	subq.l	#1,d2
	tst.l	d2
	beq.b	L171
L170
	move.l	-$7E(a5),d0
	and.l	#2,d0
	tst.w	d0
	beq	L141
L171
;			if (numTexels!=0)
	tst.l	d2
	beq.b	L173
L172
	lea	-$96(a5),a6
	move.l	a6,-(a7)
	jsr	close__StreamIn__T
	addq.w	#4,a7
	pea	(a6)
	jsr	destroy__AsyncStreamBuffer__T
	addq.w	#4,a7
	move.l	#-$2040004,d0
	movem.l	(a7)+,d2-d4/a2/a6
	unlk	a5
	rts
L173
	lea	-$96(a5),a6
	move.l	a6,-(a7)
	jsr	close__StreamIn__T
	addq.w	#4,a7
	pea	(a6)
	jsr	destroy__AsyncStreamBuffer__T
	addq.w	#4,a7
	moveq	#0,d0
	movem.l	(a7)+,d2-d4/a2/a6
	unlk	a5
	rts
L174
;			uint16* data = (uint16*)tex->getData();
	move.l	$C(a6),a2
;			numTexels++;
	addq.l	#1,d2
;			while (--numTexels && !ppmFile.end())
	bra	L203
L175
;				ruint16 txl = 0xF000 | ((uint8)ppmFile.getChar()&0xF0)<<4;
	lea	-$96(a5),a6
	tst.l	$24(a6)
	bne	L183
L176
	move.l	a6,-(a7)
	jsr	waitPacket__AsyncStreamBuffer__T
	addq.w	#4,a7
	move.l	d0,d3
	cmp.l	#0,d3
	bgt.b	L180
L177
	tst.l	d3
	bne.b	L179
L178
	or.l	#2,$18(a6)
	move.l	_DOSBase,a6
	moveq	#0,d1
	jsr	-$1CE(a6)
	moveq	#-1,d0
	bra	L184
L179
	and.l	#-$9,$18(a6)
	move.l	#-$3040004,d0
	bra.b	L184
L180
	moveq	#1,d0
	sub.l	$8E(a6),d0
	lea	$C(a6),a0
	move.l	0(a0,d0.l*4),-(a7)
	move.l	a6,-(a7)
	jsr	sendPacket__AsyncStreamBuffer__TPv
	addq.w	#$8,a7
	move.l	$92(a6),d0
	cmp.l	d3,d0
	bls.b	L182
L181
	move.l	d3,$92(a6)
L182
	lea	$C(a6),a0
	move.l	$8E(a6),d0
	move.l	0(a0,d0.l*4),a0
	move.l	$92(a6),d0
	lea	0(a0,d0.l),a0
	move.l	a0,$14(a6)
	eor.l	#1,$8E(a6)
	sub.l	$92(a6),d3
	move.l	d3,$24(a6)
	clr.l	$92(a6)
L183
	subq.l	#1,$24(a6)
	move.l	$14(a6),a1
	lea	1(a1),a0
	move.l	a0,$14(a6)
	move.b	(a1),d0
	extb.l	d0
L184
	and.l	#$FF,d0
	and.l	#$F0,d0
	moveq	#4,d1
	asl.l	d1,d0
	or.l	#$F000,d0
	move.w	d0,d4
;				txl |= ((uint8)ppmFile.getChar()&0xF0);
	lea	-$96(a5),a6
	tst.l	$24(a6)
	bne	L192
L185
	move.l	a6,-(a7)
	jsr	waitPacket__AsyncStreamBuffer__T
	addq.w	#4,a7
	move.l	d0,d3
	cmp.l	#0,d3
	bgt.b	L189
L186
	tst.l	d3
	bne.b	L188
L187
	or.l	#2,$18(a6)
	move.l	_DOSBase,a6
	moveq	#0,d1
	jsr	-$1CE(a6)
	moveq	#-1,d0
	bra	L193
L188
	and.l	#-$9,$18(a6)
	move.l	#-$3040004,d0
	bra	L193
L189
	moveq	#1,d0
	sub.l	$8E(a6),d0
	lea	$C(a6),a0
	move.l	0(a0,d0.l*4),-(a7)
	move.l	a6,-(a7)
	jsr	sendPacket__AsyncStreamBuffer__TPv
	addq.w	#$8,a7
	move.l	$92(a6),d0
	cmp.l	d3,d0
	bls.b	L191
L190
	move.l	d3,$92(a6)
L191
	lea	$C(a6),a0
	move.l	$8E(a6),d0
	move.l	0(a0,d0.l*4),a0
	move.l	$92(a6),d0
	lea	0(a0,d0.l),a0
	move.l	a0,$14(a6)
	eor.l	#1,$8E(a6)
	sub.l	$92(a6),d3
	move.l	d3,$24(a6)
	clr.l	$92(a6)
L192
	subq.l	#1,$24(a6)
	move.l	$14(a6),a1
	lea	1(a1),a0
	move.l	a0,$14(a6)
	move.b	(a1),d0
	extb.l	d0
L193
	and.l	#$FF,d0
	and.l	#$F0,d0
	or.w	d0,d4
;				txl |= ((uint8)ppmFile.getChar())>>4;
	lea	-$96(a5),a6
	tst.l	$24(a6)
	bne	L201
L194
	move.l	a6,-(a7)
	jsr	waitPacket__AsyncStreamBuffer__T
	addq.w	#4,a7
	move.l	d0,d3
	cmp.l	#0,d3
	bgt.b	L198
L195
	tst.l	d3
	bne.b	L197
L196
	or.l	#2,$18(a6)
	move.l	_DOSBase,a6
	moveq	#0,d1
	jsr	-$1CE(a6)
	moveq	#-1,d0
	bra	L202
L197
	and.l	#-$9,$18(a6)
	move.l	#-$3040004,d0
	bra	L202
L198
	moveq	#1,d0
	sub.l	$8E(a6),d0
	lea	$C(a6),a0
	move.l	0(a0,d0.l*4),-(a7)
	move.l	a6,-(a7)
	jsr	sendPacket__AsyncStreamBuffer__TPv
	addq.w	#$8,a7
	move.l	$92(a6),d0
	cmp.l	d3,d0
	bls.b	L200
L199
	move.l	d3,$92(a6)
L200
	lea	$C(a6),a0
	move.l	$8E(a6),d0
	move.l	0(a0,d0.l*4),a0
	move.l	$92(a6),d0
	lea	0(a0,d0.l),a0
	move.l	a0,$14(a6)
	eor.l	#1,$8E(a6)
	sub.l	$92(a6),d3
	move.l	d3,$24(a6)
	clr.l	$92(a6)
L201
	subq.l	#1,$24(a6)
	move.l	$14(a6),a1
	lea	1(a1),a0
	move.l	a0,$14(a6)
	move.b	(a1),d0
	extb.l	d0
L202
	and.l	#$FF,d0
	moveq	#4,d1
	asr.l	d1,d0
	or.w	d0,d4
;				*data++ = txl;
	move.w	d4,(a2)+
L203
	subq.l	#1,d2
	tst.l	d2
	beq.b	L205
L204
	move.l	-$7E(a5),d0
	and.l	#2,d0
	tst.w	d0
	beq	L175
L205
;			if (numTexels!=0)
	tst.l	d2
	beq.b	L207
L206
	lea	-$96(a5),a6
	move.l	a6,-(a7)
	jsr	close__StreamIn__T
	addq.w	#4,a7
	pea	(a6)
	jsr	destroy__AsyncStreamBuffer__T
	addq.w	#4,a7
	move.l	#-$2040004,d0
	movem.l	(a7)+,d2-d4/a2/a6
	unlk	a5
	rts
L207
	lea	-$96(a5),a6
	move.l	a6,-(a7)
	jsr	close__StreamIn__T
	addq.w	#4,a7
	pea	(a6)
	jsr	destroy__AsyncStreamBuffer__T
	addq.w	#4,a7
	moveq	#0,d0
	movem.l	(a7)+,d2-d4/a2/a6
	unlk	a5
	rts
L208
;			numTexels*=3;
	mulu.l	#3,d2
;			result = ppmFile.read8(tex->getData(), numTexels);
	move.l	d2,-(a7)
	move.l	$C(a6),-(a7)
	pea	-$96(a5)
	jsr	readBytes__StreamIn__TPvUi
	add.w	#$C,a7
	move.l	d0,d3
;			if (result<0)
	bpl.b	L210
L209
	lea	-$96(a5),a6
	move.l	a6,-(a7)
	jsr	close__StreamIn__T
	addq.w	#4,a7
	pea	(a6)
	jsr	destroy__AsyncStreamBuffer__T
	addq.w	#4,a7
	move.l	d3,d0
	movem.l	(a7)+,d2-d4/a2/a6
	unlk	a5
	rts
L210
;			if (result==numTexels)
	cmp.l	d2,d3
	bne.b	L212
L211
	lea	-$96(a5),a6
	move.l	a6,-(a7)
	jsr	close__StreamIn__T
	addq.w	#4,a7
	pea	(a6)
	jsr	destroy__AsyncStreamBuffer__T
	addq.w	#4,a7
	moveq	#0,d0
	movem.l	(a7)+,d2-d4/a2/a6
	unlk	a5
	rts
L212
	lea	-$96(a5),a6
	move.l	a6,-(a7)
	jsr	close__StreamIn__T
	addq.w	#4,a7
	pea	(a6)
	jsr	destroy__AsyncStreamBuffer__T
	addq.w	#4,a7
	move.l	#-$2040004,d0
	movem.l	(a7)+,d2-d4/a2/a6
	unlk	a5
	rts
L213
;			uint32* data = (uint32*)tex->getData();
	move.l	$C(a6),a2
;			numTexels++;
	addq.l	#1,d2
;			while (--numTexels && !ppmFile.end())
	bra	L242
L214
;				ruint32 txl = 0xFF000000 | ((uint8)ppmFile.getChar())<<16;
	lea	-$96(a5),a6
	tst.l	$24(a6)
	bne	L222
L215
	move.l	a6,-(a7)
	jsr	waitPacket__AsyncStreamBuffer__T
	addq.w	#4,a7
	move.l	d0,d3
	cmp.l	#0,d3
	bgt.b	L219
L216
	tst.l	d3
	bne.b	L218
L217
	or.l	#2,$18(a6)
	move.l	_DOSBase,a6
	moveq	#0,d1
	jsr	-$1CE(a6)
	moveq	#-1,d0
	bra	L223
L218
	and.l	#-$9,$18(a6)
	move.l	#-$3040004,d0
	bra	L223
L219
	moveq	#1,d0
	sub.l	$8E(a6),d0
	lea	$C(a6),a0
	move.l	0(a0,d0.l*4),-(a7)
	move.l	a6,-(a7)
	jsr	sendPacket__AsyncStreamBuffer__TPv
	addq.w	#$8,a7
	move.l	$92(a6),d0
	cmp.l	d3,d0
	bls.b	L221
L220
	move.l	d3,$92(a6)
L221
	lea	$C(a6),a0
	move.l	$8E(a6),d0
	move.l	0(a0,d0.l*4),a0
	move.l	$92(a6),d0
	lea	0(a0,d0.l),a0
	move.l	a0,$14(a6)
	eor.l	#1,$8E(a6)
	sub.l	$92(a6),d3
	move.l	d3,$24(a6)
	clr.l	$92(a6)
L222
	subq.l	#1,$24(a6)
	move.l	$14(a6),a1
	lea	1(a1),a0
	move.l	a0,$14(a6)
	move.b	(a1),d0
	extb.l	d0
L223
	and.l	#$FF,d0
	moveq	#$10,d1
	asl.l	d1,d0
	move.l	d0,d4
	or.l	#-$1000000,d4
;				txl |= ((uint8)ppmFile.getChar())<<8;
	lea	-$96(a5),a6
	tst.l	$24(a6)
	bne	L231
L224
	move.l	a6,-(a7)
	jsr	waitPacket__AsyncStreamBuffer__T
	addq.w	#4,a7
	move.l	d0,d3
	cmp.l	#0,d3
	bgt.b	L228
L225
	tst.l	d3
	bne.b	L227
L226
	or.l	#2,$18(a6)
	move.l	_DOSBase,a6
	moveq	#0,d1
	jsr	-$1CE(a6)
	moveq	#-1,d0
	bra	L232
L227
	and.l	#-$9,$18(a6)
	move.l	#-$3040004,d0
	bra	L232
L228
	moveq	#1,d0
	sub.l	$8E(a6),d0
	lea	$C(a6),a0
	move.l	0(a0,d0.l*4),-(a7)
	move.l	a6,-(a7)
	jsr	sendPacket__AsyncStreamBuffer__TPv
	addq.w	#$8,a7
	move.l	$92(a6),d0
	cmp.l	d3,d0
	bls.b	L230
L229
	move.l	d3,$92(a6)
L230
	lea	$C(a6),a0
	move.l	$8E(a6),d0
	move.l	0(a0,d0.l*4),a0
	move.l	$92(a6),d0
	lea	0(a0,d0.l),a0
	move.l	a0,$14(a6)
	eor.l	#1,$8E(a6)
	sub.l	$92(a6),d3
	move.l	d3,$24(a6)
	clr.l	$92(a6)
L231
	subq.l	#1,$24(a6)
	move.l	$14(a6),a1
	lea	1(a1),a0
	move.l	a0,$14(a6)
	move.b	(a1),d0
	extb.l	d0
L232
	and.l	#$FF,d0
	moveq	#$8,d1
	asl.l	d1,d0
	or.l	d0,d4
;				txl |= ((uint8)ppmFile.getChar());
	lea	-$96(a5),a6
	tst.l	$24(a6)
	bne	L240
L233
	move.l	a6,-(a7)
	jsr	waitPacket__AsyncStreamBuffer__T
	addq.w	#4,a7
	move.l	d0,d3
	cmp.l	#0,d3
	bgt.b	L237
L234
	tst.l	d3
	bne.b	L236
L235
	or.l	#2,$18(a6)
	move.l	_DOSBase,a6
	moveq	#0,d1
	jsr	-$1CE(a6)
	moveq	#-1,d0
	bra	L241
L236
	and.l	#-$9,$18(a6)
	move.l	#-$3040004,d0
	bra	L241
L237
	moveq	#1,d0
	sub.l	$8E(a6),d0
	lea	$C(a6),a0
	move.l	0(a0,d0.l*4),-(a7)
	move.l	a6,-(a7)
	jsr	sendPacket__AsyncStreamBuffer__TPv
	addq.w	#$8,a7
	move.l	$92(a6),d0
	cmp.l	d3,d0
	bls.b	L239
L238
	move.l	d3,$92(a6)
L239
	lea	$C(a6),a0
	move.l	$8E(a6),d0
	move.l	0(a0,d0.l*4),a0
	move.l	$92(a6),d0
	lea	0(a0,d0.l),a0
	move.l	a0,$14(a6)
	eor.l	#1,$8E(a6)
	sub.l	$92(a6),d3
	move.l	d3,$24(a6)
	clr.l	$92(a6)
L240
	subq.l	#1,$24(a6)
	move.l	$14(a6),a1
	lea	1(a1),a0
	move.l	a0,$14(a6)
	move.b	(a1),d0
	extb.l	d0
L241
	and.l	#$FF,d0
	or.l	d0,d4
;				*data++ = txl;
	move.l	d4,(a2)+
L242
	subq.l	#1,d2
	tst.l	d2
	beq.b	L244
L243
	move.l	-$7E(a5),d0
	and.l	#2,d0
	tst.w	d0
	beq	L214
L244
;			if (numTexels!=0)
	tst.l	d2
	beq.b	L246
L245
	lea	-$96(a5),a6
	move.l	a6,-(a7)
	jsr	close__StreamIn__T
	addq.w	#4,a7
	pea	(a6)
	jsr	destroy__AsyncStreamBuffer__T
	addq.w	#4,a7
	move.l	#-$2040004,d0
	movem.l	(a7)+,d2-d4/a2/a6
	unlk	a5
	rts
L246
	lea	-$96(a5),a6
	move.l	a6,-(a7)
	jsr	close__StreamIn__T
	addq.w	#4,a7
	pea	(a6)
	jsr	destroy__AsyncStreamBuffer__T
	addq.w	#4,a7
	moveq	#0,d0
	movem.l	(a7)+,d2-d4/a2/a6
	unlk	a5
	rts
L247
;			uint32* data = (uint32*)tex->getData();
	move.l	$C(a6),a2
;			numTexels++;
	addq.l	#1,d2
;			while (--numTexels && !ppmFile.end())
	bra	L276
L248
;				ruint32 txl = 0x000000FF | ((uint8)ppmFile.getChar())<<24;
	lea	-$96(a5),a6
	tst.l	$24(a6)
	bne	L256
L249
	move.l	a6,-(a7)
	jsr	waitPacket__AsyncStreamBuffer__T
	addq.w	#4,a7
	move.l	d0,d3
	cmp.l	#0,d3
	bgt.b	L253
L250
	tst.l	d3
	bne.b	L252
L251
	or.l	#2,$18(a6)
	move.l	_DOSBase,a6
	moveq	#0,d1
	jsr	-$1CE(a6)
	moveq	#-1,d0
	bra	L257
L252
	and.l	#-$9,$18(a6)
	move.l	#-$3040004,d0
	bra	L257
L253
	moveq	#1,d0
	sub.l	$8E(a6),d0
	lea	$C(a6),a0
	move.l	0(a0,d0.l*4),-(a7)
	move.l	a6,-(a7)
	jsr	sendPacket__AsyncStreamBuffer__TPv
	addq.w	#$8,a7
	move.l	$92(a6),d0
	cmp.l	d3,d0
	bls.b	L255
L254
	move.l	d3,$92(a6)
L255
	lea	$C(a6),a0
	move.l	$8E(a6),d0
	move.l	0(a0,d0.l*4),a0
	move.l	$92(a6),d0
	lea	0(a0,d0.l),a0
	move.l	a0,$14(a6)
	eor.l	#1,$8E(a6)
	sub.l	$92(a6),d3
	move.l	d3,$24(a6)
	clr.l	$92(a6)
L256
	subq.l	#1,$24(a6)
	move.l	$14(a6),a1
	lea	1(a1),a0
	move.l	a0,$14(a6)
	move.b	(a1),d0
	extb.l	d0
L257
	and.l	#$FF,d0
	moveq	#$18,d1
	asl.l	d1,d0
	move.l	d0,d4
	or.l	#$FF,d4
;				txl |= ((uint8)ppmFile.getChar())<<16;
	lea	-$96(a5),a6
	tst.l	$24(a6)
	bne	L265
L258
	move.l	a6,-(a7)
	jsr	waitPacket__AsyncStreamBuffer__T
	addq.w	#4,a7
	move.l	d0,d3
	cmp.l	#0,d3
	bgt.b	L262
L259
	tst.l	d3
	bne.b	L261
L260
	or.l	#2,$18(a6)
	move.l	_DOSBase,a6
	moveq	#0,d1
	jsr	-$1CE(a6)
	moveq	#-1,d0
	bra	L266
L261
	and.l	#-$9,$18(a6)
	move.l	#-$3040004,d0
	bra	L266
L262
	moveq	#1,d0
	sub.l	$8E(a6),d0
	lea	$C(a6),a0
	move.l	0(a0,d0.l*4),-(a7)
	move.l	a6,-(a7)
	jsr	sendPacket__AsyncStreamBuffer__TPv
	addq.w	#$8,a7
	move.l	$92(a6),d0
	cmp.l	d3,d0
	bls.b	L264
L263
	move.l	d3,$92(a6)
L264
	lea	$C(a6),a0
	move.l	$8E(a6),d0
	move.l	0(a0,d0.l*4),a0
	move.l	$92(a6),d0
	lea	0(a0,d0.l),a0
	move.l	a0,$14(a6)
	eor.l	#1,$8E(a6)
	sub.l	$92(a6),d3
	move.l	d3,$24(a6)
	clr.l	$92(a6)
L265
	subq.l	#1,$24(a6)
	move.l	$14(a6),a1
	lea	1(a1),a0
	move.l	a0,$14(a6)
	move.b	(a1),d0
	extb.l	d0
L266
	and.l	#$FF,d0
	moveq	#$10,d1
	asl.l	d1,d0
	or.l	d0,d4
;				txl |= ((uint8)ppmFile.getChar())<<8;
	lea	-$96(a5),a6
	tst.l	$24(a6)
	bne	L274
L267
	move.l	a6,-(a7)
	jsr	waitPacket__AsyncStreamBuffer__T
	addq.w	#4,a7
	move.l	d0,d3
	cmp.l	#0,d3
	bgt.b	L271
L268
	tst.l	d3
	bne.b	L270
L269
	or.l	#2,$18(a6)
	move.l	_DOSBase,a6
	moveq	#0,d1
	jsr	-$1CE(a6)
	moveq	#-1,d0
	bra	L275
L270
	and.l	#-$9,$18(a6)
	move.l	#-$3040004,d0
	bra	L275
L271
	moveq	#1,d0
	sub.l	$8E(a6),d0
	lea	$C(a6),a0
	move.l	0(a0,d0.l*4),-(a7)
	move.l	a6,-(a7)
	jsr	sendPacket__AsyncStreamBuffer__TPv
	addq.w	#$8,a7
	move.l	$92(a6),d0
	cmp.l	d3,d0
	bls.b	L273
L272
	move.l	d3,$92(a6)
L273
	lea	$C(a6),a0
	move.l	$8E(a6),d0
	move.l	0(a0,d0.l*4),a0
	move.l	$92(a6),d0
	lea	0(a0,d0.l),a0
	move.l	a0,$14(a6)
	eor.l	#1,$8E(a6)
	sub.l	$92(a6),d3
	move.l	d3,$24(a6)
	clr.l	$92(a6)
L274
	subq.l	#1,$24(a6)
	move.l	$14(a6),a1
	lea	1(a1),a0
	move.l	a0,$14(a6)
	move.b	(a1),d0
	extb.l	d0
L275
	and.l	#$FF,d0
	moveq	#$8,d1
	asl.l	d1,d0
	or.l	d0,d4
;				*data++ = txl;
	move.l	d4,(a2)+
L276
	subq.l	#1,d2
	tst.l	d2
	beq.b	L278
L277
	move.l	-$7E(a5),d0
	and.l	#2,d0
	tst.w	d0
	beq	L248
L278
;			if (numTexels!=0)
	tst.l	d2
	beq.b	L280
L279
	lea	-$96(a5),a6
	move.l	a6,-(a7)
	jsr	close__StreamIn__T
	addq.w	#4,a7
	pea	(a6)
	jsr	destroy__AsyncStreamBuffer__T
	addq.w	#4,a7
	move.l	#-$2040004,d0
	movem.l	(a7)+,d2-d4/a2/a6
	unlk	a5
	rts
L280
	lea	-$96(a5),a6
	move.l	a6,-(a7)
	jsr	close__StreamIn__T
	addq.w	#4,a7
	pea	(a6)
	jsr	destroy__AsyncStreamBuffer__T
	addq.w	#4,a7
	moveq	#0,d0
	movem.l	(a7)+,d2-d4/a2/a6
	unlk	a5
	rts
L281
	lea	-$96(a5),a6
	move.l	a6,-(a7)
	jsr	close__StreamIn__T
	addq.w	#4,a7
	pea	(a6)
	jsr	destroy__AsyncStreamBuffer__T
	addq.w	#4,a7
	move.l	#-$3010000,d0
	movem.l	(a7)+,d2-d4/a2/a6
	unlk	a5
	rts

L84
	dc.b	'P6',$A,'%d',$A,'%d',$A,'255',$A,0

	SECTION "loadPPMPGM__TextureLoader__P07TexturePCcPCcE:0",CODE


;sint32 TextureLoader::loadPPMPGM(Texture* tex, const char* ppm, cons
	XDEF	loadPPMPGM__TextureLoader__P07TexturePCcPCcE
loadPPMPGM__TextureLoader__P07TexturePCcPCcE
L285
;	return OK;
	moveq	#0,d0
	rts

	END
