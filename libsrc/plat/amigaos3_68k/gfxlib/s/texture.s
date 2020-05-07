
; Storm C Compiler
; exng:libsrc/plat/amigaos3_68k/gfxlib/texture.cpp
	mc68030
	mc68881
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
	XREF	free__Mem__Pv
	XREF	alloc__Mem__UisE
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

	SECTION "_0ct__Texture__T:0",CODE


;Texture::Texture() 
	XDEF	_0ct__Texture__T
_0ct__Texture__T
	move.l	4(a7),a0
L60
	clr.w	(a0)
	clr.w	2(a0)
	clr.l	4(a0)
	clr.l	$8(a0)
	clr.l	$C(a0)
	clr.l	$10(a0)
	clr.l	$14(a0)
	clr.l	$18(a0)
	move.l	#1,$1C(a0)
	clr.l	$20(a0)
	rts

	SECTION "_0dt__Texture__T:0",CODE


;Texture::~Texture()
	XDEF	_0dt__Texture__T
_0dt__Texture__T
	move.l	4(a7),a0
L61
;	destroy();
	move.l	a0,-(a7)
	jsr	destroy__Texture__T
	addq.w	#4,a7
	rts

	SECTION "create__Texture__TssEP07Palette:0",CODE


;sint32 Texture::create(S_WH, G3D::Texel t, Palette* p)
	XDEF	create__Texture__TssEP07Palette
create__Texture__TssEP07Palette
	movem.l	d2-d5/a2,-(a7)
	movem.l	$20(a7),d4/a1
	move.w	$1E(a7),d2
	move.w	$1C(a7),d3
	move.l	$18(a7),a2
L62
;	if (data || tex)
	tst.l	$C(a2)
	bne.b	L64
L63
	tst.l	$8(a2)
	beq.b	L65
L64
;		return ERR_RSC_LOCKED;
	move.l	#-$3050004,d0
	movem.l	(a7)+,d2-d5/a2
	rts
L65
;	if (w<G3D::MIN_TEX_WIDTH || h<G3D::MIN_TEX_HEIGHT ||
	move.w	d3,d0
	ext.l	d0
	cmp.l	#2,d0
	blt.b	L69
L66
	move.w	d2,d0
	ext.l	d0
	cmp.l	#2,d0
	blt.b	L69
L67
	move.w	d3,d0
	ext.l	d0
	cmp.l	#$200,d0
	bgt.b	L69
L68
	move.w	d2,d0
	ext.l	d0
	cmp.l	#$200,d0
	ble.b	L70
L69
;		return ERR_VALUE_ILLEGAL;
	move.l	#-$3010001,d0
	movem.l	(a7)+,d2-d5/a2
	rts
L70
;	size_t bytesPerTexel=0;
;	switch (t)
	move.l	d4,d0
	cmp.l	#$A,d0
	bhi.b	L77
	move.l	L81(pc,d0.l*4),a0
	jmp	(a0)
L81
	dc.l	L71
	dc.l	L73
	dc.l	L73
	dc.l	L73
	dc.l	L74
	dc.l	L74
	dc.l	L74
	dc.l	L74
	dc.l	L75
	dc.l	L76
	dc.l	L76
;		
L71
;		case G3D::TXL_LUT8:	if (!p)	
	cmp.w	#0,a1
	bne.b	L73
L72
;		case G3D::TXL_LUT8:	if (!p)	return E
	move.l	#-$3020002,d0
	movem.l	(a7)+,d2-d5/a2
	rts
L73
;			bytesPerTexel = 1;
	moveq	#1,d0
;			
	bra.b	L78
L74
;			bytesPerTexel = 2;
	moveq	#2,d0
;			
	bra.b	L78
L75
;			bytesPerTexel = 3;
	moveq	#3,d0
;			
	bra.b	L78
L76
;			bytesPerTexel = 4;
	moveq	#4,d0
;			
	bra.b	L78
L77
;			return ERR_VALUE_ILLEGAL;
	move.l	#-$3010001,d0
	movem.l	(a7)+,d2-d5/a2
	rts
L78
;	if (!(data = Mem::alloc(w*h*bytesPerTexel, false, Mem::ALIGN_CACHE)
	pea	$10.w
	clr.w	-(a7)
	move.w	d3,d1
	muls	d2,d1
	mulu.l	d0,d1
	move.l	d1,-(a7)
	jsr	alloc__Mem__UisE
	add.w	#$A,a7
	move.l	d0,$C(a2)
	bne.b	L80
L79
;		return ERR_NO_FREE_STORE;
	move.l	#-$3030001,d0
	movem.l	(a7)+,d2-d5/a2
	rts
L80
;	format	= t;
	move.l	d4,$14(a2)
;	width		= w;
	move.w	d3,(a2)
;	height	= h;
	move.w	d2,2(a2)
;	return OK;
	moveq	#0,d0
	movem.l	(a7)+,d2-d5/a2
	rts

	SECTION "destroy__Texture__T:0",CODE


;void Texture::destroy()
	XDEF	destroy__Texture__T
destroy__Texture__T
	move.l	a2,-(a7)
	move.l	$8(a7),a2
L82
;	disassociate();
	move.l	a2,-(a7)
	jsr	disassociate__Texture__T
	addq.w	#4,a7
;	if (data)
	tst.l	$C(a2)
	beq.b	L84
L83
;		Mem::free(data);
	move.l	$C(a2),-(a7)
	jsr	free__Mem__Pv
	addq.w	#4,a7
L84
;	data		= 0;
	clr.l	$C(a2)
;	palette = 0;
	clr.l	$10(a2)
;	format	= G3D::TXL_LUT8;
	clr.l	$14(a2)
	move.l	(a7)+,a2
	rts

	SECTION "associate__Texture__TP10Rasterizer:0",CODE


;sint32 Texture::associate(Rasterizer* r)
	XDEF	associate__Texture__TP10Rasterizer
associate__Texture__TP10Rasterizer
L98	EQU	-$34
	link	a5,#L98
	movem.l	a2/a3/a6,-(a7)
	move.l	$C(a5),a0
	move.l	$8(a5),a3
L85
;	if (tex)
	move.l	a3,a2
	tst.l	$8(a2)
	beq.b	L87
L86
;		return ERR_RSC_LOCKED;
	move.l	#-$3050004,d0
	movem.l	(a7)+,a2/a3/a6
	unlk	a5
	rts
L87
;	if (!data || !r || !(owner = getRasterizerContext(r)))
	move.l	a3,a2
	tst.l	$C(a2)
	beq.b	L90
L88
	cmp.w	#0,a0
	beq.b	L90
L89
	move.l	(a0),a0
	move.l	a3,a1
	move.l	a0,4(a1)
	cmp.w	#0,a0
	bne.b	L91
L90
;		return ERR_RSC_INVALID;
	move.l	#-$3050008,d0
	movem.l	(a7)+,a2/a3/a6
	unlk	a5
	rts
L91
;	TagItem allocTexTags[] = {
	lea	-$30(a5),a0
	move.l	#$80201000,(a0)+
	move.l	a3,a2
	move.l	$C(a2),(a0)+
	move.l	#$80201001,(a0)+
	move.l	a3,a1
	move.l	$14(a1),d0
	move.l	#_texel__Native3D,a2
	move.b	0(a2,d0.l),d0
	and.l	#$FF,d0
	move.l	d0,(a0)+
	move.l	#$80201002,(a0)+
	move.l	a3,a1
	move.w	(a1),d0
	ext.l	d0
	move.l	d0,(a0)+
	move.l	#$80201003,(a0)+
	move.l	a3,a1
	move.w	2(a1),d0
	ext.l	d0
	move.l	d0,(a0)+
	clr.l	(a0)+
	clr.l	(a0)+
	clr.l	(a0)+
	clr.l	(a0)
;	if (format == G3D::TXL_LUT8)
	move.l	a3,a0
	tst.l	$14(a0)
	bne.b	L95
L92
;		if (!palette)
	move.l	a3,a1
	tst.l	$10(a1)
	bne.b	L94
L93
;			return ERR_RSC_INVALID;
	move.l	#-$3050008,d0
	movem.l	(a7)+,a2/a3/a6
	unlk	a5
	rts
L94
;		allocTexTags[4].ti_Tag	= (uint32)W3D_ATO_PALETTE;
	lea	-$30(a5),a0
	move.l	#$80201005,$20(a0)
;		allocTexTags[4].ti_Data	= (uint32)(palette->getTable());
	move.l	a3,a0
	move.l	$10(a0),a1
	lea	-$30(a5),a0
	move.l	a1,$24(a0)
L95
;	uint32 error = 0;
	clr.l	-$34(a5)
;	if (!(tex = W3D_AllocTexObj(owner, &error, allocTexTags)))
	move.l	a3,a2
	move.l	4(a2),a0
	lea	-$30(a5),a6
	move.l	a6,a2
	move.l	_Warp3DBase,a6
	lea	-$34(a5),a1
	jsr	-$60(a6)
	move.l	a3,a1
	move.l	d0,$8(a1)
	bne.b	L97
L96
;		owner = 0;
	move.l	a3,a1
	clr.l	4(a1)
;		return ERR_RSC;
	move.l	#-$3050000,d0
	movem.l	(a7)+,a2/a3/a6
	unlk	a5
	rts
L97
;	W3D_SetTexEnv(owner, tex, getNativeTexEnv(env), 0);
	move.l	a3,a0
	move.l	$20(a0),d0
	move.l	#_texEnv__Native3D,a1
	moveq	#0,d1
	move.b	0(a1,d0.l),d1
	move.l	a3,a0
	move.l	$8(a0),a1
	move.l	a3,a2
	move.l	4(a2),a0
	move.l	_Warp3DBase,a6
	sub.l	a2,a2
	jsr	-$7E(a6)
;	W3D_SetFilter(owner, tex, getNativeTexFilter(min), getNativeTexFil
	move.l	a3,a0
	move.l	$18(a0),d0
	move.l	#_texFilter__Native3D,a1
	moveq	#0,d1
	move.b	0(a1,d0.l),d1
	move.l	a3,a0
	move.l	$1C(a0),d0
	move.l	#_texFilter__Native3D,a1
	move.b	0(a1,d0.l),d0
	and.l	#$FF,d0
	move.l	a3,a0
	move.l	$8(a0),a1
	move.l	a3,a2
	move.l	_Warp3DBase,a6
	move.l	4(a2),a0
	jsr	-$78(a6)
;	return OK;
	moveq	#0,d0
	movem.l	(a7)+,a2/a3/a6
	unlk	a5
	rts

	SECTION "disassociate__Texture__T:0",CODE


;void Texture::disassociate()
	XDEF	disassociate__Texture__T
disassociate__Texture__T
	movem.l	a2/a3/a6,-(a7)
	move.l	$10(a7),a3
L99
;	if (owner && tex)
	move.l	a3,a1
	tst.l	4(a1)
	beq.b	L102
L100
	move.l	a3,a1
	tst.l	$8(a1)
	beq.b	L102
L101
;		W3D_FreeTexObj(owner, tex);
	move.l	a3,a0
	move.l	$8(a0),a1
	move.l	a3,a2
	move.l	_Warp3DBase,a6
	move.l	4(a2),a0
	jsr	-$66(a6)
;		owner = 0;
	move.l	a3,a1
	clr.l	4(a1)
;		tex = 0;
	move.l	a3,a1
	clr.l	$8(a1)
L102
	movem.l	(a7)+,a2/a3/a6
	rts

	END
