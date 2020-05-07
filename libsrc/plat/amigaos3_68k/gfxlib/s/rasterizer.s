
; Storm C Compiler
; exng:libsrc/plat/amigaos3_68k/gfxlib/rasterizer.cpp
	mc68030
	mc68881
	XREF	_0dt__Texture__T
	XREF	_W3D_SetFrontFace
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
	XREF	getSwitch__AppBase__PCcs
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
	XREF	_drawPointsXYZ_F32__Rasterizer
	XREF	_drawPointsXYZ_F64__Rasterizer
	XREF	_drawLinesXYZ_F32__Rasterizer
	XREF	_drawLinesXYZ_F64__Rasterizer
	XREF	_drawLineStripXYZ_F32__Rasterizer
	XREF	_drawLineStripXYZ_F64__Rasterizer

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

	SECTION "_Warp3DBase:1",DATA

	XDEF	_Warp3DBase
_Warp3DBase
	dc.l	0

	SECTION "_openCnt__Rasterizer:1",DATA

	XDEF	_openCnt__Rasterizer
_openCnt__Rasterizer
	dc.l	0

	SECTION "_useArrayEmul__Rasterizer:1",DATA

	XDEF	_useArrayEmul__Rasterizer
_useArrayEmul__Rasterizer
	dc.w	1

	SECTION "init__Rasterizer_:0",CODE


;sint32 Rasterizer::init()
	XDEF	init__Rasterizer_
init__Rasterizer_
	move.l	a6,-(a7)
L117
;	if (!(Warp3DBase = OpenLibrary("Warp3D.library", 4)))
	move.l	_SysBase,a6
	moveq	#4,d0
	move.l	#L111,a1
	jsr	-$228(a6)
	move.l	d0,_Warp3DBase
	tst.l	_Warp3DBase
	bne.b	L119
L118
;terizer::init() :
	pea	2.w
	move.l	#L112,-(a7)
	jsr	printDebug__SystemLib__PCci
	addq.w	#$8,a7
;		done();
	jsr	done__Rasterizer_
;		return ERR_RSC_UNAVAILABLE;
	move.l	#-$3050005,d0
	move.l	(a7)+,a6
	rts
L119
;	if (W3D_CheckDriver() == W3D_DRIVER_UNAVAILABLE)
	move.l	_Warp3DBase,a6
	jsr	-$36(a6)
	cmp.l	#1,d0
	bne.b	L121
L120
;ERROR("Rasterizer
	pea	2.w
	move.l	#L113,-(a7)
	jsr	printDebug__SystemLib__PCci
	addq.w	#$8,a7
;		done();
	jsr	done__Rasterizer_
;		return ERR_RSC_UNAVAILABLE;
	move.l	#-$3050005,d0
	move.l	(a7)+,a6
	rts
L121
;	X_INFO("Rasterizer:: initialized")
	clr.l	-(a7)
	move.l	#L114,-(a7)
	jsr	printDebug__SystemLib__PCci
	addq.w	#$8,a7
;	if (AppBase::getSwitch("-no3darrayemul", false)==true)
	clr.w	-(a7)
	move.l	#L115,-(a7)
	jsr	getSwitch__AppBase__PCcs
	addq.w	#6,a7
	cmp.w	#1,d0
	bne.b	L123
L122
;		useArrayEmul = false;
	clr.w	_useArrayEmul__Rasterizer
;asterizer:: disab
	clr.l	-(a7)
	move.l	#L116,-(a7)
	jsr	printDebug__SystemLib__PCci
	addq.w	#$8,a7
L123
;	return OK;
	moveq	#0,d0
	move.l	(a7)+,a6
	rts

L115
	dc.b	'-no3darrayemul',0
L116
	dc.b	'Rasterizer:: disabled 3d array line/point emulation',0
L114
	dc.b	'Rasterizer:: initialized',0
L112
	dc.b	'Rasterizer::init() : failed to open Warp3D.library v4',0
L113
	dc.b	'Rasterizer::init() : failed to query driver',0
L111
	dc.b	'Warp3D.library',0

	SECTION "done__Rasterizer_:0",CODE


;void Rasterizer::done()
	XDEF	done__Rasterizer_
done__Rasterizer_
	move.l	a6,-(a7)
L125
;	X_INFO("Rasterizer:: finalized");
	clr.l	-(a7)
	move.l	#L124,-(a7)
	jsr	printDebug__SystemLib__PCci
	addq.w	#$8,a7
;	if (Warp3DBase)
	tst.l	_Warp3DBase
	beq.b	L127
L126
;		CloseLibrary(Warp3DBase);
	move.l	_Warp3DBase,a1
	move.l	_SysBase,a6
	jsr	-$19E(a6)
;		Warp3DBase = 0;
	clr.l	_Warp3DBase
L127
	move.l	(a7)+,a6
	rts

L124
	dc.b	'Rasterizer:: finalized',0

	SECTION "_0ct__Rasterizer__T:0",CODE


;Rasterizer::Rasterizer()
	XDEF	_0ct__Rasterizer__T
_0ct__Rasterizer__T
	move.l	4(a7),a0
L128
	clr.l	$5C(a0)
	clr.l	$60(a0)
	clr.l	$64(a0)
;	context							= 0;
	clr.l	(a0)
;	surface							= 0;
	clr.l	4(a0)
;	texture							= 0;
	clr.l	$8(a0)
;	vrtPtrX							= 0;
	clr.l	$C(a0)
;	vrtPtrY							= 0;
	clr.l	$10(a0)
;	vrtPtrZ							= 0;
	clr.l	$14(a0)
;	clrPtrA							= 0;
	clr.l	$18(a0)
;	clrPtrR							= 0;
	clr.l	$1C(a0)
;	clrPtrG							= 0;
	clr.l	$20(a0)
;	clrPtrB							= 0;
	clr.l	$24(a0)
;	texPtrW							= 0;
	clr.l	$28(a0)
;	texPtrUS						= 0;
	clr.l	$2C(a0)
;	texPtrVT						= 0;
	clr.l	$30(a0)
;	vrtPtrType					= G3D::XYZ_FLOAT32;
	clr.l	$34(a0)
;	clrPtrType					= G3D::ARGB_UINT8;
	clr.l	$38(a0)
;	texPtrType					= G3D::WUV_FLOAT32;
	clr.l	$3C(a0)
;	vrtPtrStride				= 0;
	clr.l	$40(a0)
;	clrPtrStride				= 0;
	clr.l	$44(a0)
;	texPtrStride				= 0;
	clr.l	$48(a0)
;	drawRegion.left			= 0;
	clr.l	$4C(a0)
;	drawRegion.top			= 0;
	clr.l	$50(a0)
;	drawRegion.width		= 0;
	clr.l	$54(a0)
;	drawRegion.height		= 0;
	clr.l	$58(a0)
;	flatColour					= 0xFF000000;
	move.l	#-$1000000,$5C(a0)
;	maskColour					= 0;
	clr.l	$60(a0)
;	fogColour						= 0xFF7F7F7F;
	move.l	#-$808081,$64(a0)
;	fogMode							= G3D::FOG_LINEAR;
	clr.l	$68(a0)
;	fogData.fog_start		= 0.0F;
	clr.l	$6C(a0)
;	fogData.fog_end			= 1.0F;
	move.l	#$3F800000,$70(a0)
;	fogData.fog_density	= 1.0F;
	move.l	#$3F800000,$74(a0)
;	fogData.fog_color.r = 0.5F;
	move.l	#$3F000000,$78(a0)
;	fogData.fog_color.g = 0.5F;
	move.l	#$3F000000,$7C(a0)
;	fogData.fog_color.b = 0.5F;
	move.l	#$3F000000,$80(a0)
;	alphaTest						= G3D::ATEST_PASS;
	move.l	#7,$84(a0)
;	alphaTestRef				= 0.0F;
	clr.l	$88(a0)
;	zBuffTest						= G3D::ZTEST_LT;
	clr.l	$8C(a0)
;	logicOp							= G3D::LOP_NOP;
	move.l	#5,$90(a0)
;	blendSrc						= G3D::BL_SRC_A;
	move.l	#6,$94(a0)
;	blendDst						= G3D::BL_1_MINUS_SRC_A;
	move.l	#7,$98(a0)
;	windOrder						= G3D::FRONT_CW;
	clr.l	$9C(a0)
;	meshIndexBuffer			= 0;
	clr.l	$A4(a0)
;	flags = RESOURCEOK;
	move.l	#1,$A8(a0)
	rts

	SECTION "obtain__Rasterizer__P07Surface:0",CODE


;Rasterizer* Rasterizer::obtain(Surface* s)
	XDEF	obtain__Rasterizer__P07Surface
obtain__Rasterizer__P07Surface
	movem.l	a2/a3,-(a7)
	move.l	$C(a7),a3
L129
;	if (s)
	cmp.w	#0,a3
	beq	L142
L130
;		if (openCnt == 0)
	tst.l	_openCnt__Rasterizer
	bne.b	L134
L131
;			if (init()==OK)
	jsr	init__Rasterizer_
	tst.l	d0
	bne.b	L133
L132
;				openCnt++;
	addq.l	#1,_openCnt__Rasterizer
	bra.b	L134
L133
;				return 0;
	moveq	#0,d0
	movem.l	(a7)+,a2/a3
	rts
L134
;		Rasterizer* rast = new Rasterizer;
	pea	$AC.w
	jsr	op__new__Ui
	move.l	d0,a2
	addq.w	#4,a7
	cmp.w	#0,a2
	beq.b	L136
L135
	move.l	a2,-(a7)
	jsr	_0ct__Rasterizer__T
	addq.w	#4,a7
L136
;		if (rast)
	cmp.w	#0,a2
	beq.b	L142
L137
;			if (rast->associate(s) != OK)
	move.l	a3,-(a7)
	move.l	a2,-(a7)
	jsr	associate__Rasterizer__TP07Surface
	addq.w	#$8,a7
	tst.l	d0
	beq.b	L141
L138
;				delete rast;
	cmp.w	#0,a2
	beq.b	L140
L139
	move.l	a2,-(a7)
	jsr	_0dt__Rasterizer__T
	addq.w	#4,a7
	pea	$AC.w
	move.l	a2,-(a7)
	jsr	op__delete__PvUi
	addq.w	#$8,a7
L140
;				rast = 0;
	sub.l	a2,a2
L141
;			return rast;
	move.l	a2,d0
	movem.l	(a7)+,a2/a3
	rts
L142
;	return 0;
	moveq	#0,d0
	movem.l	(a7)+,a2/a3
	rts

	SECTION "_0dt__Rasterizer__T:0",CODE


;Rasterizer::~Rasterizer()
	XDEF	_0dt__Rasterizer__T
_0dt__Rasterizer__T
	move.l	4(a7),a0
L143
;	disassociate();
	move.l	a0,-(a7)
	jsr	disassociate__Rasterizer__T
	addq.w	#4,a7
;	if (--openCnt==0)
	subq.l	#1,_openCnt__Rasterizer
	tst.l	_openCnt__Rasterizer
	bne.b	L145
L144
;		done();
	jsr	done__Rasterizer_
L145
	rts

	SECTION "associate__Rasterizer__TP07Surface:0",CODE


;sint32 Rasterizer::associate(Surface* s)
	XDEF	associate__Rasterizer__TP07Surface
associate__Rasterizer__TP07Surface
L160	EQU	-4
	link	a5,#L160
	movem.l	a2/a3/a6,-(a7)
	move.l	$C(a5),a2
	move.l	$8(a5),a3
L147
;	if (!(flags & RESOURCEOK))
	move.l	a3,a0
	move.l	$A8(a0),d0
	and.l	#1,d0
	bne.b	L149
L148
;		return ERR_RSC_UNAVAILABLE;
	move.l	#-$3050005,d0
	movem.l	(a7)+,a2/a3/a6
	unlk	a5
	rts
L149
;	if (context)
	move.l	a3,a1
	tst.l	(a1)
	beq.b	L151
L150
;		return ERR_RSC_LOCKED;
	move.l	#-$3050004,d0
	movem.l	(a7)+,a2/a3/a6
	unlk	a5
	rts
L151
;	if (!s || !getSurfaceRep(s))
	cmp.w	#0,a2
	beq.b	L154
L152
	tst.l	$E(a2)
	bne.b	L155
L153
L154
;		return ERR_PTR_ZERO;
	move.l	#-$3020002,d0
	movem.l	(a7)+,a2/a3/a6
	unlk	a5
	rts
L155
;	meshIndexBuffer = new uint16[MESH_INDEX_SIZE];
	pea	$C00.w
	jsr	op__new__Ui
	addq.w	#4,a7
	move.l	a3,a1
	move.l	d0,$A4(a1)
;	if (!meshIndexBuffer)
	move.l	a3,a1
	tst.l	$A4(a1)
	bne.b	L157
L156
;		return ERR_NO_FREE_STORE;
	move.l	#-$3030001,d0
	movem.l	(a7)+,a2/a3/a6
	unlk	a5
	rts
L157
;	uint32 fault = 0;
	clr.l	-4(a5)
;	context = W3D_CreateContextTags(&fault,
	clr.l	-(a7)
	clr.l	-(a7)
	move.l	#$80200001,-(a7)
	pea	1.w
	move.l	#$80200007,-(a7)
	pea	2.w
	move.l	#$80200002,-(a7)
	move.l	$E(a2),-(a7)
	move.l	#$80200000,-(a7)
	move.l	_Warp3DBase,a6
	lea	-4(a5),a0
	move.l	a7,a1
	jsr	-$1E(a6)
	add.w	#$24,a7
	move.l	a3,a1
	move.l	d0,(a1)
;	if (!context)
	move.l	a3,a1
	tst.l	(a1)
	bne.b	L159
L158
;		X_ERROR("W3D_CreateConte
	pea	2.w
	move.l	#L146,-(a7)
	jsr	printDebug__SystemLib__PCci
	addq.w	#$8,a7
;		return ERR_RSC_UNAVAILABLE;
	move.l	#-$3050005,d0
	movem.l	(a7)+,a2/a3/a6
	unlk	a5
	rts
L159
;		surface = s;
	move.l	a3,a1
	move.l	a2,4(a1)
;		drawRegion.width	= s->getW();
	move.w	(a2),d0
	ext.l	d0
	move.l	a3,a0
	move.l	d0,$54(a0)
;		drawRegion.height	= s->getH();
	move.w	2(a2),d0
	ext.l	d0
	move.l	a3,a0
	move.l	d0,$58(a0)
;		W3D_SetDrawRegion(context, getSurfaceRep(s), 0, &drawRegion);
	move.l	$E(a2),a1
	move.l	a3,a2
	move.l	(a2),a0
	lea	$4C(a3),a6
	move.l	a6,a2
	move.l	_Warp3DBase,a6
	moveq	#0,d1
	jsr	-$C0(a6)
;		W3D_SetScissor(context, &drawRegion);
	move.l	a3,a2
	move.l	_Warp3DBase,a6
	move.l	(a2),a0
	lea	$4C(a3),a1
	jsr	-$1AA(a6)
;		W3D_SetBlendMode(context, getNativeBlendMode(blendSrc), getNativ
	move.l	a3,a0
	move.l	$98(a0),d0
	move.l	#_blendMode__Native3D,a1
	moveq	#0,d1
	move.b	0(a1,d0.l),d1
	move.l	a3,a0
	move.l	$94(a0),d0
	move.l	#_blendMode__Native3D,a1
	move.b	0(a1,d0.l),d0
	and.l	#$FF,d0
	move.l	a3,a1
	move.l	_Warp3DBase,a6
	move.l	(a1),a0
	jsr	-$BA(a6)
;		W3D_SetState(context, W3D_SCISSOR, W3D_ENABLE);
	move.l	a3,a1
	move.l	_Warp3DBase,a6
	move.l	#$2000000,d0
	moveq	#1,d1
	move.l	(a1),a0
	jsr	-$30(a6)
;		W3D_SetState(context, W3D_DITHERING, W3D_ENABLE);
	move.l	a3,a1
	move.l	_Warp3DBase,a6
	move.l	#$80000,d0
	moveq	#1,d1
	move.l	(a1),a0
	jsr	-$30(a6)
;		W3D_SetState(context, W3D_GOURAUD, W3D_DISABLE);
	move.l	a3,a1
	move.l	_Warp3DBase,a6
	move.l	#$400,d0
	moveq	#2,d1
	move.l	(a1),a0
	jsr	-$30(a6)
;		W3D_SetState(context, W3D_TEXMAPPING, W3D_DISABLE);
	move.l	a3,a1
	move.l	_Warp3DBase,a6
	move.l	#$100,d0
	moveq	#2,d1
	move.l	(a1),a0
	jsr	-$30(a6)
;		W3D_SetState(context, W3D_ZBUFFER, W3D_DISABLE);
	move.l	a3,a1
	move.l	_Warp3DBase,a6
	move.l	#$800,d0
	moveq	#2,d1
	move.l	(a1),a0
	jsr	-$30(a6)
;		W3D_SetState(context, W3D_ZBUFFERUPDATE, W3D_DISABLE);
	move.l	a3,a1
	move.l	_Warp3DBase,a6
	move.l	#$1000,d0
	moveq	#2,d1
	move.l	(a1),a0
	jsr	-$30(a6)
;		W3D_SetState(context, W3D_GLOBALTEXENV, W3D_DISABLE);
	move.l	a3,a1
	move.l	_Warp3DBase,a6
	moveq	#$10,d0
	moveq	#2,d1
	move.l	(a1),a0
	jsr	-$30(a6)
;		W3D_SetState(context, W3D_BLENDING, W3D_DISABLE);
	move.l	a3,a1
	move.l	_Warp3DBase,a6
	move.l	#$2000,d0
	moveq	#2,d1
	move.l	(a1),a0
	jsr	-$30(a6)
;	return OK;
	moveq	#0,d0
	movem.l	(a7)+,a2/a3/a6
	unlk	a5
	rts

L146
	dc.b	'W3D_CreateContextTags() failed',0

	SECTION "disassociate__Rasterizer__T:0",CODE


;void Rasterizer::disassociate()
	XDEF	disassociate__Rasterizer__T
disassociate__Rasterizer__T
	movem.l	a2/a6,-(a7)
	move.l	$C(a7),a2
L161
;	if (meshIndexBuffer)
	move.l	a2,a1
	tst.l	$A4(a1)
	beq.b	L165
L162
;		delete[] meshIndexBuffer;
	move.l	a2,a1
	move.l	$A4(a1),a0
	cmp.w	#0,a0
	beq.b	L164
L163
	move.l	#-$2A,-(a7)
	move.l	a0,-(a7)
	jsr	op__delete__PvUi
	addq.w	#$8,a7
L164
;		meshIndexBuffer = 0;
	move.l	a2,a1
	clr.l	$A4(a1)
L165
;	if (context)
	move.l	a2,a1
	tst.l	(a1)
	beq.b	L167
L166
;		W3D_BindTexture(context, 0, 0);
	clr.l	-(a7)
	clr.l	-(a7)
	move.l	a2,a1
	move.l	(a1),-(a7)
	jsr	_W3D_BindTexture
	add.w	#$C,a7
;		W3D_FlushTextures(context);
	move.l	a2,a1
	move.l	_Warp3DBase,a6
	move.l	(a1),a0
	jsr	-$72(a6)
;		W3D_FreeZBuffer(context);
	move.l	a2,a1
	move.l	_Warp3DBase,a6
	move.l	(a1),a0
	jsr	-$DE(a6)
;		W3D_FreeStencilBuffer(context);
	move.l	a2,a1
	move.l	_Warp3DBase,a6
	move.l	(a1),a0
	jsr	-$10E(a6)
;		W3D_DestroyContext(context);
	move.l	a2,a1
	move.l	_Warp3DBase,a6
	move.l	(a1),a0
	jsr	-$24(a6)
;		context = 0;
	move.l	a2,a1
	clr.l	(a1)
L167
;	surface = 0;
	move.l	a2,a1
	clr.l	4(a1)
;	stateMask = 0;
	move.l	a2,a0
	clr.l	$A0(a0)
	movem.l	(a7)+,a2/a6
	rts

	SECTION "supportsFeature__Rasterizer__TE:0",CODE


;G3D::Support Rasterizer::supportsFeature(G3D::Query q)
	XDEF	supportsFeature__Rasterizer__TE
supportsFeature__Rasterizer__TE
	movem.l	d2/a2/a6,-(a7)
	move.l	$14(a7),d2
	move.l	$10(a7),a1
L168
;	switch (W3D_Query(context, getNativeQuery(q),
	move.l	4(a1),a0
	move.l	$26(a0),d0
	move.l	#_pixelType__Native2D,a2
	move.l	0(a2,d0.l*4),d1
	move.l	d2,d0
	move.l	#_query__Native3D,a2
	move.b	0(a2,d0.l),d0
	and.l	#$FF,d0
	move.l	_Warp3DBase,a6
	move.l	(a1),a0
	jsr	-$54(a6)
	cmp.l	#3,d0
	beq.b	L169
	cmp.l	#4,d0
	beq.b	L170
	bra.b	L171
;		
L169
;			return G3D::FULLY_SUPPORTED;
	moveq	#3,d0
	movem.l	(a7)+,d2/a2/a6
	rts
L170
;			return G3D::PARTIALLY_SUPPORTED;
	moveq	#2,d0
	movem.l	(a7)+,d2/a2/a6
	rts
L171
;			return G3D::UNSUPPORTED;
	moveq	#0,d0
	movem.l	(a7)+,d2/a2/a6
	rts

	SECTION "supportsTexelFormat__Rasterizer__TE:0",CODE


;G3D::Support Rasterizer::supportsTexelFormat(G3D::Texel q)
	XDEF	supportsTexelFormat__Rasterizer__TE
supportsTexelFormat__Rasterizer__TE
	movem.l	d2/a2/a6,-(a7)
	move.l	$14(a7),d2
	move.l	$10(a7),a2
L172
;	uint32 res = W3D_GetTexFmtInfo(context, getNativeTexel(q),
	move.l	a2,a1
	move.l	4(a1),a0
	move.l	$26(a0),d0
	move.l	#_pixelType__Native2D,a1
	move.l	0(a1,d0.l*4),d1
	move.l	d2,d0
	move.l	#_texel__Native3D,a1
	move.b	0(a1,d0.l),d0
	and.l	#$FF,d0
	move.l	a2,a1
	move.l	_Warp3DBase,a6
	move.l	(a1),a0
	jsr	-$5A(a6)
;	if (surface->getFormat()!=Pixel::INDEX8)
	move.l	a2,a1
	move.l	4(a1),a0
	tst.l	$26(a0)
	beq.b	L178
L173
;		if (res & W3D_TEXFMT_ARGBFAST|W3D_TEXFMT_FAST)
	move.l	d0,d1
	and.l	#$40000,d1
	or.l	#$10000,d1
	beq.b	L175
L174
;			return G3D::FULLY_SUPPORTED;
	moveq	#3,d0
	movem.l	(a7)+,d2/a2/a6
	rts
L175
;		if (res & W3D_TEXFMT_SUPPORTED)
	and.l	#1,d0
	beq.b	L177
L176
;			return G3D::EMULATED;
	moveq	#1,d0
	movem.l	(a7)+,d2/a2/a6
	rts
L177
;		return G3D::UNSUPPORTED;
	moveq	#0,d0
	movem.l	(a7)+,d2/a2/a6
	rts
L178
;		if (res & W3D_TEXFMT_CLUTFAST|W3D_TEXFMT_FAST)
	move.l	d0,d1
	and.l	#$20000,d1
	or.l	#$10000,d1
	beq.b	L180
L179
;			return G3D::FULLY_SUPPORTED;
	moveq	#3,d0
	movem.l	(a7)+,d2/a2/a6
	rts
L180
;	if (W3D_SetCurrentColor(context, &rgba)==W3D_SUCCE
	and.l	#1,d0
	beq.b	L182
L181
;			return G3D::EMULATED;
	moveq	#1,d0
	movem.l	(a7)+,d2/a2/a6
	rts
L182
;		return G3D::UNSUPPORTED;
	moveq	#0,d0
	movem.l	(a7)+,d2/a2/a6
	rts

	SECTION "setFront__Rasterizer__TE:0",CODE


;bool Rasterizer::setFront(G3D::FrontFace f)
	XDEF	setFront__Rasterizer__TE
setFront__Rasterizer__TE
	move.l	a2,-(a7)
	move.l	$C(a7),d0
	move.l	$8(a7),a0
L183
;	if (windOrder!=f)
	move.l	$9C(a0),d1
	cmp.l	d0,d1
	beq.b	L185
L184
;		windOrder = f;
	move.l	d0,$9C(a0)
;		W3D_SetFrontFace(context, getNativeFrontFace(f));
	move.l	#_frontFace__Native3D,a2
	move.b	0(a2,d0.l),d0
	and.l	#$FF,d0
	move.l	d0,-(a7)
	move.l	(a0),-(a7)
	jsr	_W3D_SetFrontFace
	addq.w	#$8,a7
L185
;	return true;
	moveq	#1,d0
	move.l	(a7)+,a2
	rts

	SECTION "setDrawArea__Rasterizer__TssssP07Surface:0",CODE


;bool Rasterizer::setDrawArea(S_2CRD, Surface* s)
	XDEF	setDrawArea__Rasterizer__TssssP07Surface
setDrawArea__Rasterizer__TssssP07Surface
	movem.l	d2-d4/a2/a6,-(a7)
	move.w	$1C(a7),d1
	move.w	$1E(a7),d2
	move.w	$22(a7),d3
	move.w	$20(a7),d4
	move.l	$18(a7),a0
	move.l	$24(a7),a1
L186
;	drawRegion.left 	= x1;
	move.w	d1,d0
	ext.l	d0
	move.l	d0,$4C(a0)
;			drawRegion.top = y1;
	move.w	d2,d0
	ext.l	d0
	move.l	d0,$50(a0)
;	drawRegion.width	= x2-x1;
	move.w	d4,d0
	ext.l	d0
	ext.l	d1
	sub.l	d1,d0
	move.l	d0,$54(a0)
;	drawRegion.height = y2-y1;
	move.w	d3,d0
	ext.l	d0
	move.w	d2,d1
	ext.l	d1
	sub.l	d1,d0
	move.l	d0,$58(a0)
;	if (!s || !getSurfaceRep(s))
	cmp.w	#0,a1
	beq.b	L189
L187
	tst.l	$E(a1)
	bne.b	L190
L188
L189
;		return (W3D_SetDrawRegion(context, 0, 0, &drawRegion)==W3D_SUCCE
	lea	$4C(a0),a2
	move.l	_Warp3DBase,a6
	moveq	#0,d1
	move.l	(a0),a0
	sub.l	a1,a1
	jsr	-$C0(a6)
	tst.l	d0
	seq	d0
	and.l	#1,d0
	movem.l	(a7)+,d2-d4/a2/a6
	rts
L190
;	surface = s;
	move.l	a1,4(a0)
;	return (W3D_SetDrawRegion(context, getSurfaceRep(s), 0, &drawRegio
	lea	$4C(a0),a2
	move.l	_Warp3DBase,a6
	moveq	#0,d1
	move.l	(a0),a0
	move.l	$E(a1),a1
	jsr	-$C0(a6)
	tst.l	d0
	seq	d0
	and.l	#1,d0
	movem.l	(a7)+,d2-d4/a2/a6
	rts

	SECTION "createZBuffer__Rasterizer__T:0",CODE


;bool Rasterizer::createZBuffer()
	XDEF	createZBuffer__Rasterizer__T
createZBuffer__Rasterizer__T
	movem.l	a2/a6,-(a7)
	move.l	$C(a7),a2
L191
;	if (W3D_AllocZBuffer(context)==W3D_SUCCESS)
	move.l	a2,a1
	move.l	_Warp3DBase,a6
	move.l	(a1),a0
	jsr	-$D8(a6)
	tst.l	d0
	bne.b	L193
L192
;		flags |= HAVEZBUFF;
	move.l	a2,a0
	move.l	$A8(a0),d0
	or.l	#4,d0
	move.l	a2,a0
	move.l	d0,$A8(a0)
;		return true;
	moveq	#1,d0
	movem.l	(a7)+,a2/a6
	rts
L193
;	flags &= ~HAVEZBUFF;
	move.l	a2,a0
	move.l	$A8(a0),d0
	and.l	#-5,d0
	move.l	a2,a0
	move.l	d0,$A8(a0)
;	return false;
	moveq	#0,d0
	movem.l	(a7)+,a2/a6
	rts

	SECTION "destroyZBuffer__Rasterizer__T:0",CODE


;void Rasterizer::destroyZBuffer()
	XDEF	destroyZBuffer__Rasterizer__T
destroyZBuffer__Rasterizer__T
	move.l	a6,-(a7)
	move.l	$8(a7),a0
L194
;	if (flags & HAVEZBUFF)
	move.l	$A8(a0),d0
	and.l	#4,d0
	beq.b	L196
L195
;		flags &=~HAVEZBUFF;
	and.l	#-5,$A8(a0)
;		W3D_FreeZBuffer(context);
	move.l	_Warp3DBase,a6
	move.l	(a0),a0
	jsr	-$DE(a6)
L196
	move.l	(a7)+,a6
	rts

	SECTION "writeZBuffer__Rasterizer__TssssPd:0",CODE


;bool Rasterizer::writeZBuffer(S_2CRD, float64* v)
	XDEF	writeZBuffer__Rasterizer__TssssPd
writeZBuffer__Rasterizer__TssssPd
L204	EQU	-$10
	link	a5,#L204
	movem.l	d2-d5/a2/a3/a6,-(a7)
	move.w	$12(a5),d1
	move.w	$10(a5),d2
	move.w	$E(a5),d4
	move.w	$C(a5),d5
	move.l	$14(a5),a3
L197
;	if (!v || (flags & HAVEZBUFF)==0)
	cmp.w	#0,a3
	beq.b	L199
L198
	move.l	$8(a5),a0
	move.l	$A8(a0),d0
	and.l	#4,d0
	bne.b	L200
L199
;		return false;
	moveq	#0,d0
	movem.l	(a7)+,d2-d5/a2/a3/a6
	unlk	a5
	rts
L200
;	uint32 span = x2-x1;
	ext.l	d2
	move.w	d5,d0
	ext.l	d0
	sub.l	d0,d2
;	uint32 h		= 1+y2-y1;
	move.w	d1,d0
	ext.l	d0
	move.l	d0,d3
	addq.l	#1,d3
	move.w	d4,d0
	ext.l	d0
	sub.l	d0,d3
;	while(--h)
	bra.b	L202
L201
;		W3D_WriteZSpan(context, x1, y1++, span, v, 0);
	move.w	d4,d1
	addq.w	#1,d4
	ext.l	d1
	move.w	d5,d0
	ext.l	d0
	move.l	$8(a5),a1
	move.l	(a1),a0
	move.l	_Warp3DBase,a6
	move.l	a3,a1
	sub.l	a2,a2
	jsr	-$162(a6)
;		v+=span;
	move.l	d2,d0
	moveq	#3,d1
	asl.l	d1,d0
	add.l	a3,d0
	move.l	d0,a3
L202
	subq.l	#1,d3
	tst.l	d3
	bne.b	L201
L203
;	return true;
	moveq	#1,d0
	movem.l	(a7)+,d2-d5/a2/a3/a6
	unlk	a5
	rts

	SECTION "readZBuffer__Rasterizer__TssssPd:0",CODE


;bool Rasterizer::readZBuffer(S_2CRD, float64* v)
	XDEF	readZBuffer__Rasterizer__TssssPd
readZBuffer__Rasterizer__TssssPd
	movem.l	d2-d5/a2/a3/a6,-(a7)
	move.w	$2A(a7),d1
	move.w	$28(a7),d2
	move.w	$26(a7),d4
	move.w	$24(a7),d5
	move.l	$2C(a7),a2
	move.l	$20(a7),a3
L205
;	if (!v || (flags & HAVEZBUFF)==0)
	cmp.w	#0,a2
	beq.b	L207
L206
	move.l	a3,a0
	move.l	$A8(a0),d0
	and.l	#4,d0
	bne.b	L208
L207
;		return false;
	moveq	#0,d0
	movem.l	(a7)+,d2-d5/a2/a3/a6
	rts
L208
;	uint32 span = x2-x1;
	ext.l	d2
	move.w	d5,d0
	ext.l	d0
	sub.l	d0,d2
;	uint32 h		= 1+y2-y1;
	move.w	d1,d0
	ext.l	d0
	move.l	d0,d3
	addq.l	#1,d3
	move.w	d4,d0
	ext.l	d0
	sub.l	d0,d3
;	while(--h)
	bra.b	L212
L209
;		if (W3D_ReadZSpan(context, x1, y1++, span, v)!=W3D_SUCCESS)
	move.w	d4,d1
	addq.w	#1,d4
	ext.l	d1
	move.w	d5,d0
	ext.l	d0
	move.l	a3,a1
	move.l	(a1),a0
	move.l	_Warp3DBase,a6
	move.l	a2,a1
	jsr	-$F0(a6)
	tst.l	d0
	beq.b	L211
L210
;			return false;
	moveq	#0,d0
	movem.l	(a7)+,d2-d5/a2/a3/a6
	rts
L211
;		v+=span;
	move.l	d2,d0
	moveq	#3,d1
	asl.l	d1,d0
	add.l	a2,d0
	move.l	d0,a2
L212
	subq.l	#1,d3
	tst.l	d3
	bne.b	L209
L213
;	return true;
	moveq	#1,d0
	movem.l	(a7)+,d2-d5/a2/a3/a6
	rts

	SECTION "readStencilBuffer__Rasterizer__TssssPUj:0",CODE


;bool Rasterizer::readStencilBuffer(S_2CRD, uint32* p)
	XDEF	readStencilBuffer__Rasterizer__TssssPUj
readStencilBuffer__Rasterizer__TssssPUj
	movem.l	d2-d5/a2/a3/a6,-(a7)
	move.w	$2A(a7),d1
	move.w	$28(a7),d2
	move.w	$26(a7),d4
	move.w	$24(a7),d5
	move.l	$2C(a7),a2
	move.l	$20(a7),a3
L214
;	if (!p)	
	cmp.w	#0,a2
	bne.b	L216
L215
;	if (!p)	return false;
	moveq	#0,d0
	movem.l	(a7)+,d2-d5/a2/a3/a6
	rts
L216
;	uint32 span = x2-x1;
	ext.l	d2
	move.w	d5,d0
	ext.l	d0
	sub.l	d0,d2
;	uint32 h		= 1+y2-y1;
	move.w	d1,d0
	ext.l	d0
	move.l	d0,d3
	addq.l	#1,d3
	move.w	d4,d0
	ext.l	d0
	sub.l	d0,d3
;	while(--h)
	bra.b	L220
L217
;		if (W3D_ReadStencilSpan(context, x1, y1++, span, p)!=W3D_SUCCESS)
	move.w	d4,d1
	addq.w	#1,d4
	ext.l	d1
	move.w	d5,d0
	ext.l	d0
	move.l	a3,a1
	move.l	(a1),a0
	move.l	_Warp3DBase,a6
	move.l	a2,a1
	jsr	-$11A(a6)
	tst.l	d0
	beq.b	L219
L218
;			return false;
	moveq	#0,d0
	movem.l	(a7)+,d2-d5/a2/a3/a6
	rts
L219
;		p+=span;
	move.l	d2,d0
	moveq	#2,d1
	asl.l	d1,d0
	add.l	a2,d0
	move.l	d0,a2
L220
	subq.l	#1,d3
	tst.l	d3
	bne.b	L217
L221
;	return true;
	moveq	#1,d0
	movem.l	(a7)+,d2-d5/a2/a3/a6
	rts

	SECTION "setFlatColour__Rasterizer__T06Colour:0",CODE


;bool Rasterizer::setFlatColour(Colour c)
	XDEF	setFlatColour__Rasterizer__T06Colour
setFlatColour__Rasterizer__T06Colour
L227	EQU	-$10
	link	a5,#L227
	movem.l	a2/a3/a6,-(a7)
	fmovem.x fp2,-(a7)
	move.l	$8(a5),a3
L222
;	if (c==flatColour)
	move.l	$C(a5),d0
	cmp.l	$5C(a3),d0
	seq	d0
	and.l	#1,d0
	tst.w	d0
	beq.b	L224
L223
;		return true;
	moveq	#1,d0
	fmovem.x (a7)+,fp2
	movem.l	(a7)+,a2/a3/a6
	unlk	a5
	rts
L224
;	rfloat32 f = 1F/256F;
	fmove.s	#$.3B800000,fp0
;	W3D_Color rgba = { f*c.red(), f*c.green(), f*c.blue(), f
	lea	-$10(a5),a0
	lea	$C(a5),a1
	moveq	#0,d0
	move.b	1(a1),d0
	fmove.l	d0,fp1
	fmul.x	fp0,fp1
	fmove.s	fp1,(a0)+
	lea	$C(a5),a1
	moveq	#0,d0
	move.b	2(a1),d0
	fmove.l	d0,fp1
	fmul.x	fp0,fp1
	fmove.s	fp1,(a0)+
	lea	$C(a5),a1
	moveq	#0,d0
	move.b	3(a1),d0
	fmove.l	d0,fp1
	fmul.x	fp0,fp1
	fmove.s	fp1,(a0)+
	moveq	#0,d0
	move.b	$C(a5),d0
	fmove.l	d0,fp1
	fmul.x	fp1,fp0
	fmove.s	fp0,(a0)
;	if (W3D_SetCurrentColor(context, &rgba)==W3D_SUCCESS)
	move.l	a3,a2
	move.l	_Warp3DBase,a6
	move.l	(a2),a0
	lea	-$10(a5),a1
	jsr	-$168(a6)
	tst.l	d0
	bne.b	L226
L225
;		flatColour = c;
	move.l	$C(a5),$5C(a3)
;		return true;
	moveq	#1,d0
	fmovem.x (a7)+,fp2
	movem.l	(a7)+,a2/a3/a6
	unlk	a5
	rts
L226
;	return false;
	moveq	#0,d0
	fmovem.x (a7)+,fp2
	movem.l	(a7)+,a2/a3/a6
	unlk	a5
	rts

	SECTION "setFog__Rasterizer__TE06Colourfff:0",CODE


;bool Rasterizer::setFog(G3D::FogMode m, Colour c, float32 s, float32
	XDEF	setFog__Rasterizer__TE06Colourfff
setFog__Rasterizer__TE06Colourfff
L231	EQU	0
	link	a5,#L231
	movem.l	d2/a2/a6,-(a7)
	fmovem.x fp2,-(a7)
	move.l	$C(a5),d2
	move.l	$8(a5),a0
	fmove.s	$1C(a5),fp0
	fmove.s	$18(a5),fp1
	fmove.s	$14(a5),fp2
L228
;	fogData.fog_start		= s;
	fmove.s	fp2,$6C(a0)
;	fogData.fog_end			= e;
	fmove.s	fp1,$70(a0)
;	fogData.fog_density	= d;
	fmove.s	fp0,$74(a0)
;	if (c!=fogColour)
	move.l	$10(a5),d0
	cmp.l	$64(a0),d0
	sne	d0
	and.l	#1,d0
	tst.w	d0
	beq.b	L230
L229
;		rfloat32 f = 1F/256F;
	fmove.s	#$.3B800000,fp0
;		fogData.fog_color.r = f*c.red();
	lea	$10(a5),a1
	moveq	#0,d0
	move.b	1(a1),d0
	fmove.l	d0,fp1
	fmul.x	fp0,fp1
	fmove.s	fp1,$78(a0)
;		fogData.fog_color.g = f*c.green();
	lea	$10(a5),a1
	moveq	#0,d0
	move.b	2(a1),d0
	fmove.l	d0,fp1
	fmul.x	fp0,fp1
	fmove.s	fp1,$7C(a0)
;		fogData.fog_color.b = f*c.blue();
	lea	$10(a5),a1
	moveq	#0,d0
	move.b	3(a1),d0
	fmove.l	d0,fp1
	fmul.x	fp1,fp0
	fmove.s	fp0,$80(a0)
;		fogColour = c;
	move.l	$10(a5),$64(a0)
L230
;	return (W3D_SetFogParams(context, &fogData, getNativeFogMode(m))==
	move.l	d2,d0
	move.l	#_fogMode__Native3D,a2
	moveq	#0,d1
	move.b	0(a2,d0.l),d1
	lea	$6C(a0),a1
	move.l	_Warp3DBase,a6
	move.l	(a0),a0
	jsr	-$C6(a6)
	tst.l	d0
	seq	d0
	and.l	#1,d0
	fmovem.x (a7)+,fp2
	movem.l	(a7)+,d2/a2/a6
	unlk	a5
	rts

	SECTION "setVertices__Rasterizer__TP10DrawVertex:0",CODE


;bool Rasterizer::setVertices(DrawVertex* v)
	XDEF	setVertices__Rasterizer__TP10DrawVertex
setVertices__Rasterizer__TP10DrawVertex
	move.l	a2,-(a7)
	move.l	$C(a7),a0
	move.l	$8(a7),a2
L232
;	if (!context)
	tst.l	(a2)
	bne.b	L234
L233
;		return false;
	moveq	#0,d0
	move.l	(a7)+,a2
	rts
L234
;	vrtPtrType				= G3D::XYZ_FLOAT32;
	clr.l	$34(a2)
;	clrPtrType				= G3D::ARGB_UINT8;
	clr.l	$38(a2)
;	texPtrType				= G3D::WUV_FLOAT32;
	clr.l	$3C(a2)
;	vrtPtrStride			= DV_STRIDE;
	move.l	#$20,$40(a2)
;	clrPtrStride			= DV_STRIDE;
	move.l	#$20,$44(a2)
;	texPtrStride			= DV_STRIDE;
	move.l	#$20,$48(a2)
;	if (v)
	cmp.w	#0,a0
	beq.b	L236
L235
;		vrtPtrX					= (uint8*)v+DV_OFS_XYZ;
	move.l	a0,$C(a2)
;		vrtPtrY					= vrtPtrX+sizeof(float32);
	move.l	$C(a2),a1
	lea	4(a1),a1
	move.l	a1,$10(a2)
;		vrtPtrZ					= vrtPtrY+sizeof(float32);
	move.l	$10(a2),a1
	lea	4(a1),a1
	move.l	a1,$14(a2)
;		clrPtrA					= (uint8*)v+DV_OFS_CLR;
	lea	$18(a0),a1
	move.l	a1,$18(a2)
;		clrPtrR					= clrPtrA+1;
	move.l	$18(a2),a1
	lea	1(a1),a1
	move.l	a1,$1C(a2)
;		clrPtrG					= clrPtrR+1;
	move.l	$1C(a2),a1
	lea	1(a1),a1
	move.l	a1,$20(a2)
;		clrPtrB					= clrPtrG+1;
	move.l	$20(a2),a1
	lea	1(a1),a1
	move.l	a1,$24(a2)
;		texPtrW					= (uint8*)v+DV_OFS_UV+DV_OFS_W;
	lea	$10(a0),a1
	lea	-4(a1),a1
	move.l	a1,$28(a2)
;		texPtrUS				= (uint8*)v+DV_OFS_UV;
	lea	$10(a0),a1
	move.l	a1,$2C(a2)
;		texPtrVT				= (uint8*)v+DV_OFS_UV+DV_OFS_V;
	lea	$10(a0),a0
	lea	4(a0),a0
	move.l	a0,$30(a2)
	bra.b	L237
L236
;		vrtPtrX					= 0;
	clr.l	$C(a2)
;	vrtPtrY		= 0;
	clr.l	$10(a2)
;	vrtPtrZ		= 0;
	clr.l	$14(a2)
;		clrPtrA					= 0;
	clr.l	$18(a2)
;	clrPtrR		= 0;
	clr.l	$1C(a2)
;	clrPtrG		= 0;
	clr.l	$20(a2)
;	clrPtrB		= 0;
	clr.l	$24(a2)
;		texPtrW					= 0;
	clr.l	$28(a2)
;	texPtrUS	= 0;
	clr.l	$2C(a2)
;	texPtrVT	= 0;
	clr.l	$30(a2)
L237
;	W3D_VertexPointer(context, vrtPtrX, DV_STRIDE, W3D_VERTEX_F_F_F, 0)
	clr.l	-(a7)
	clr.l	-(a7)
	pea	$20.w
	move.l	$C(a2),-(a7)
	move.l	(a2),-(a7)
	jsr	_W3D_VertexPointer
	add.w	#$14,a7
;	W3D_TexCoordPointer(context, texPtrUS, DV_STRIDE, 0, DV_OFS_V, DV_
	clr.l	-(a7)
	move.l	#-4,-(a7)
	pea	4.w
	clr.l	-(a7)
	pea	$20.w
	move.l	$2C(a2),-(a7)
	move.l	(a2),-(a7)
	jsr	_W3D_TexCoordPointer
	add.w	#$1C,a7
;	W3D_ColorPointer(context, clrPtrA, DV_STRIDE, W3D_COLOR_UBYTE, W3D
	clr.l	-(a7)
	pea	$8.w
	move.l	#$80000000,-(a7)
	pea	$20.w
	move.l	$18(a2),-(a7)
	move.l	(a2),-(a7)
	jsr	_W3D_ColorPointer
	add.w	#$18,a7
;	return true;
	moveq	#1,d0
	move.l	(a7)+,a2
	rts

	SECTION "setVertexData__Rasterizer__TPvEUi:0",CODE


;bool Rasterizer::setVertexData(void* p, G3D::CoordType t, size_t str
	XDEF	setVertexData__Rasterizer__TPvEUi
setVertexData__Rasterizer__TPvEUi
	move.l	a2,-(a7)
	move.l	$14(a7),d0
	move.l	$10(a7),d1
	move.l	$8(a7),a0
	move.l	$C(a7),a1
L238
;	switch (t)
	cmp.l	#0,d1
	beq.b	L239
	cmp.l	#1,d1
	beq.b	L243
	bra	L247
;		
L239
;		case G3D::XYZ_FLOAT32: return setVertexDa
	tst.l	(a0)
	bne.b	L241
L240
	moveq	#0,d0
	bra.b	L242
L241
	move.l	a1,$C(a0)
	lea	4(a1),a2
	move.l	a2,$10(a0)
	lea	$8(a1),a2
	move.l	a2,$14(a0)
	clr.l	$34(a0)
	move.l	d0,$40(a0)
	clr.l	-(a7)
	clr.l	-(a7)
	move.l	d0,-(a7)
	move.l	a1,-(a7)
	move.l	(a0),-(a7)
	jsr	_W3D_VertexPointer
	add.w	#$14,a7
	moveq	#1,d0
L242
	move.l	(a7)+,a2
	rts
L243
;		case G3D::XYZ_FLOAT64: return setVertexDa
	tst.l	(a0)
	bne.b	L245
L244
	moveq	#0,d0
	bra.b	L246
L245
	move.l	a1,$C(a0)
	lea	$8(a1),a2
	move.l	a2,$10(a0)
	lea	$10(a1),a2
	move.l	a2,$14(a0)
	move.l	#1,$34(a0)
	move.l	d0,$40(a0)
	clr.l	-(a7)
	pea	2.w
	move.l	d0,-(a7)
	move.l	a1,-(a7)
	move.l	(a0),-(a7)
	jsr	_W3D_VertexPointer
	add.w	#$14,a7
	moveq	#1,d0
L246
	move.l	(a7)+,a2
	rts
L247
;		default: return false;
	moveq	#0,d0
	move.l	(a7)+,a2
	rts

	SECTION "setTextureData__Rasterizer__TPvEUi:0",CODE


;bool Rasterizer::setTextureData(void* p, G3D::TexCoordType t, size_t
	XDEF	setTextureData__Rasterizer__TPvEUi
setTextureData__Rasterizer__TPvEUi
	move.l	a2,-(a7)
	move.l	$14(a7),d0
	move.l	$10(a7),d1
	move.l	$8(a7),a0
	move.l	$C(a7),a1
L248
;	switch (t)
	cmp.l	#2,d1
	beq	L261
	bgt.b	L266
	cmp.l	#0,d1
	beq.b	L249
	cmp.l	#1,d1
	beq.b	L253
	bra	L265
L266
	cmp.l	#3,d1
	beq	L257
	bra	L265
;		
L249
;		case WUV_FLOAT32: return setTextureData(((G3D:
	tst.l	(a0)
	bne.b	L251
L250
	moveq	#0,d0
	bra.b	L252
L251
	move.l	a1,$28(a0)
	lea	4(a1),a2
	move.l	a2,$2C(a0)
	lea	$8(a1),a2
	move.l	a2,$30(a0)
	clr.l	$3C(a0)
	move.l	d0,$48(a0)
	clr.l	-(a7)
	move.l	#-4,-(a7)
	pea	4.w
	clr.l	-(a7)
	move.l	d0,-(a7)
	pea	4(a1)
	move.l	(a0),-(a7)
	jsr	_W3D_TexCoordPointer
	add.w	#$1C,a7
	moveq	#1,d0
L252
	move.l	(a7)+,a2
	rts
L253
;		case UVW_FLOAT32: return setTextureData(((G3D:
	tst.l	(a0)
	bne.b	L255
L254
	moveq	#0,d0
	bra.b	L256
L255
	lea	$8(a1),a2
	move.l	a2,$28(a0)
	move.l	a1,$2C(a0)
	lea	4(a1),a2
	move.l	a2,$30(a0)
	move.l	#1,$3C(a0)
	move.l	d0,$48(a0)
	clr.l	-(a7)
	pea	$8.w
	pea	4.w
	clr.l	-(a7)
	move.l	d0,-(a7)
	move.l	a1,-(a7)
	move.l	(a0),-(a7)
	jsr	_W3D_TexCoordPointer
	add.w	#$1C,a7
	moveq	#1,d0
L256
	move.l	(a7)+,a2
	rts
L257
;		case WST_FLOAT32: return setTextureData(((G3D:
	tst.l	(a0)
	bne.b	L259
L258
	moveq	#0,d0
	bra.b	L260
L259
	move.l	a1,$28(a0)
	lea	4(a1),a2
	move.l	a2,$2C(a0)
	lea	$8(a1),a2
	move.l	a2,$30(a0)
	move.l	#3,$3C(a0)
	move.l	d0,$48(a0)
	pea	1.w
	move.l	#-4,-(a7)
	pea	4.w
	clr.l	-(a7)
	move.l	d0,-(a7)
	pea	4(a1)
	move.l	(a0),-(a7)
	jsr	_W3D_TexCoordPointer
	add.w	#$1C,a7
	moveq	#1,d0
L260
	move.l	(a7)+,a2
	rts
L261
;		case STW_FLOAT32: return setTextureData(((G3D:
	tst.l	(a0)
	bne.b	L263
L262
	moveq	#0,d0
	bra.b	L264
L263
	lea	$8(a1),a2
	move.l	a2,$28(a0)
	move.l	a1,$2C(a0)
	lea	4(a1),a2
	move.l	a2,$30(a0)
	move.l	#2,$3C(a0)
	move.l	d0,$48(a0)
	pea	1.w
	pea	$8.w
	pea	4.w
	clr.l	-(a7)
	move.l	d0,-(a7)
	move.l	a1,-(a7)
	move.l	(a0),-(a7)
	jsr	_W3D_TexCoordPointer
	add.w	#$1C,a7
	moveq	#1,d0
L264
	move.l	(a7)+,a2
	rts
L265
;		default: return false;
	moveq	#0,d0
	move.l	(a7)+,a2
	rts

	END
