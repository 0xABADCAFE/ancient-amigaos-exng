
; Storm C Compiler
; exng:libsrc/plat/amigaos3_68k/gfxlib/rastdraw.cpp
	mc68030
	mc68881
	XREF	_0dt__Texture__T
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

	SECTION "drawTriMesh__Rasterizer__TUiUiUi:0",CODE


;bool Rasterizer::drawTriMesh(size_t ofs, size_t dx, size_t dy)
	XDEF	drawTriMesh__Rasterizer__TUiUiUi
drawTriMesh__Rasterizer__TUiUiUi
	movem.l	d2-d7/a2,-(a7)
	move.l	$2C(a7),d1
	move.l	$24(a7),d2
	move.l	$28(a7),d5
	move.l	$20(a7),a2
L192
;	size_t	totTris	= 2*((dx-1)*(dy-1));
	move.l	d5,d0
	subq.l	#1,d0
	subq.l	#1,d1
	mulu.l	d1,d0
	moveq	#1,d1
	asl.l	d1,d0
	move.l	d0,d7
;	sint32	modx		= dx-1;
	move.l	d5,d4
	subq.l	#1,d4
;	ruint32	i0			= ofs;
	move.l	d2,d3
;	ruint32	i1			= ofs+dx;
	add.l	d5,d2
;	while (totTris >= MESH_MAX_TRIS_PER_CALL)
	bra.b	L200
L193
;		ruint16*	idx	= meshIndexBuffer;
	move.l	$A4(a2),a0
;		rsint32 	i		= (MESH_MAX_TRIS_PER_CALL>>1)+1;
	move.l	#$101,d0
;		while (--i)
	bra.b	L196
L194
;			idx[0]=i1++;
	move.l	d2,d1
	addq.l	#1,d2
	move.w	d1,(a0)
; idx[3]=idx[1]=i0++;
	move.l	d3,d1
	addq.l	#1,d3
	move.w	d1,2(a0)
	move.w	d1,6(a0)
; idx[4]=i0;
	move.w	d3,$8(a0)
; idx[5]=idx[2]=i1;
	move.w	d2,d1
	move.w	d1,4(a0)
	move.w	d1,$A(a0)
;			idx+=6;
	add.w	#$C,a0
;			if (--modx<=0)
	subq.l	#1,d4
	cmp.l	#0,d4
	bgt.b	L196
L195
;				modx = dx-1;
	move.l	d5,d4
	subq.l	#1,d4
;				i0++;
	addq.l	#1,d3
; i1++;
	addq.l	#1,d2
L196
	subq.l	#1,d0
	tst.l	d0
	bne.b	L194
L197
;		if (W3D_DrawElements(context,	W3D_PRIMITIVE_TRIANGLES,					\
	move.l	$A4(a2),-(a7)
	pea	$600.w
	pea	1.w
	clr.l	-(a7)
	move.l	(a2),-(a7)
	jsr	_W3D_DrawElements
	add.w	#$14,a7
	tst.l	d0
	beq.b	L199
L198
;			return false;
	moveq	#0,d0
	movem.l	(a7)+,d2-d7/a2
	rts
L199
;		totTris -= MESH_MAX_TRIS_PER_CALL;
	move.l	d7,d0
	sub.l	#$200,d0
	move.l	d0,d7
L200
	move.l	d7,d0
	cmp.l	#$200,d0
	bhs	L193
L201
;	if (totTris>0)
	tst.l	d7
	beq	L208
L202
;		ruint16*	idx	= meshIndexBuffer;
	move.l	$A4(a2),a0
;		rsint32 	i		= (totTris>>1)+1;
	move.l	d7,d0
	moveq	#1,d1
	lsr.l	d1,d0
	addq.l	#1,d0
;		while (--i)
	bra.b	L205
L203
;			idx[0]=i1++;
	move.l	d2,d1
	addq.l	#1,d2
	move.w	d1,(a0)
; idx[3]=idx[1]=i0++;
	move.l	d3,d1
	addq.l	#1,d3
	move.w	d1,2(a0)
	move.w	d1,6(a0)
; idx[4]=i0;
	move.w	d3,$8(a0)
; idx[5]=idx[2]=i1;
	move.w	d2,d1
	move.w	d1,4(a0)
	move.w	d1,$A(a0)
;			idx+=6;
	add.w	#$C,a0
;			if (--modx<=0)
	subq.l	#1,d4
	cmp.l	#0,d4
	bgt.b	L205
L204
;				modx = dx-1;
	move.l	d5,d4
	subq.l	#1,d4
;				i0++;
	addq.l	#1,d3
; i1++;
	addq.l	#1,d2
L205
	subq.l	#1,d0
	tst.l	d0
	bne.b	L203
L206
;		if (W3D_DrawElements(context, W3D_PRIMITIVE_TRIANGLES,			\
	move.l	$A4(a2),-(a7)
	move.l	d7,d0
	mulu.l	#3,d0
	move.l	d0,-(a7)
	pea	1.w
	clr.l	-(a7)
	move.l	(a2),-(a7)
	jsr	_W3D_DrawElements
	add.w	#$14,a7
	tst.l	d0
	beq.b	L208
L207
;			return false;
	moveq	#0,d0
	movem.l	(a7)+,d2-d7/a2
	rts
L208
;	return true;
	moveq	#1,d0
	movem.l	(a7)+,d2-d7/a2
	rts

	SECTION "drawTriMesh2__Rasterizer__TUiUiUi:0",CODE


;bool Rasterizer::drawTriMesh2(size_t ofs, size_t dx, size_t dy)
	XDEF	drawTriMesh2__Rasterizer__TUiUiUi
drawTriMesh2__Rasterizer__TUiUiUi
	movem.l	d2-d5/a2,-(a7)
	movem.l	$1C(a7),d2-d4
	move.l	$18(a7),a2
L209
;	if ( dx<=((MESH_MAX_TRIS_PER_CALL+2)/2) )
	cmp.l	#$101,d3
	bhi.b	L218
L210
;		while (--dy)
	bra.b	L216
L211
;			ruint16 *idx = meshIndexBuffer;
	move.l	$A4(a2),a0
;			rsint32 i = dx+1;
	move.l	d3,d0
	addq.l	#1,d0
;			while (--i)
	bra.b	L213
L212
;				*idx++ = ofs+dx;
	move.l	d2,d1
	add.l	d3,d1
	move.w	d1,(a0)+
; *idx++ = ofs++;
	move.l	d2,d1
	addq.l	#1,d2
	move.w	d1,(a0)+
L213
	subq.l	#1,d0
	tst.l	d0
	bne.b	L212
L214
;			if (W3D_DrawElements(context,	W3D_PRIMITIVE_TRISTRIP,				\
	move.l	$A4(a2),-(a7)
	move.l	d3,d0
	moveq	#1,d1
	asl.l	d1,d0
	move.l	d0,-(a7)
	pea	1.w
	pea	2.w
	move.l	(a2),-(a7)
	jsr	_W3D_DrawElements
	add.w	#$14,a7
	tst.l	d0
	beq.b	L216
L215
;				return false;
	moveq	#0,d0
	movem.l	(a7)+,d2-d5/a2
	rts
L216
	subq.l	#1,d4
	tst.l	d4
	bne.b	L211
L217
;		return true;
	moveq	#1,d0
	movem.l	(a7)+,d2-d5/a2
	rts
L218
;	return false;
	moveq	#0,d0
	movem.l	(a7)+,d2-d5/a2
	rts

	SECTION "drawPoints__Rasterizer__TUiUi:0",CODE


;bool Rasterizer::drawPoints(size_t ofs, size_t cnt)
	XDEF	drawPoints__Rasterizer__TUiUi
drawPoints__Rasterizer__TUiUi
	move.l	d2,-(a7)
	move.l	$10(a7),d0
	move.l	$C(a7),d1
	move.l	$8(a7),a0
L219
;	if (!vrtPtrX || cnt < 1)
	tst.l	$C(a0)
	beq.b	L221
L220
	tst.l	d0
	bne.b	L222
L221
;		return false;
	moveq	#0,d0
	move.l	(a7)+,d2
	rts
L222
;	if (useArrayEmul)
	tst.w	_useArrayEmul__Rasterizer
	beq.b	L227
L223
;		switch (vrtPtrType)
	move.l	$34(a0),d2
	cmp.l	#0,d2
	beq.b	L224
	cmp.l	#1,d2
	beq.b	L225
	bra.b	L226
;			
L224
;				return drawPointsXYZ_F32[clrPtrType](this, ofs, cnt);
	move.l	d0,-(a7)
	move.l	d1,-(a7)
	move.l	a0,-(a7)
	move.l	$38(a0),d0
	move.l	#_drawPointsXYZ_F32__Rasterizer,a1
	move.l	0(a1,d0.l*4),a0
	jsr	(a0)
	add.w	#$C,a7
	move.l	(a7)+,d2
	rts
L225
;				return drawPointsXYZ_F64[clrPtrType](this, ofs, cnt);
	move.l	d0,-(a7)
	move.l	d1,-(a7)
	move.l	a0,-(a7)
	move.l	$38(a0),d0
	move.l	#_drawPointsXYZ_F64__Rasterizer,a1
	move.l	0(a1,d0.l*4),a0
	jsr	(a0)
	add.w	#$C,a7
	move.l	(a7)+,d2
	rts
L226
;				return false;
	moveq	#0,d0
	move.l	(a7)+,d2
	rts
L227
;		return (W3D_DrawArray(context, W3D_PRIMITIVE_POINTS, ofs, cnt)==
	move.l	d0,-(a7)
	move.l	d1,-(a7)
	pea	3.w
	move.l	(a0),-(a7)
	jsr	_W3D_DrawArray
	add.w	#$10,a7
	tst.l	d0
	seq	d0
	and.l	#1,d0
	move.l	(a7)+,d2
	rts

	SECTION "drawPointsXYZ_F32_CLR_U8__Rasterizer__P10RasterizerUiUi:0",CODE


;bool Rasterizer::drawPointsXYZ_F32_CLR_U8(Rasterizer* rast, size_t o
	XDEF	drawPointsXYZ_F32_CLR_U8__Rasterizer__P10RasterizerUiUi
drawPointsXYZ_F32_CLR_U8__Rasterizer__P10RasterizerUiUi
	move.l	a6,-(a7)
	move.l	$8(a7),a0
L228
;	if (W3D_GetState(rast->context, W3D_GOURAUD)==W3D_ENABLED)
	move.l	_Warp3DBase,a6
	move.l	#$400,d1
	move.l	(a0),a0
	jsr	-$2A(a6)
L229
;	return false;
	moveq	#0,d0
	move.l	(a7)+,a6
	rts

	SECTION "drawPointsXYZ_F32_CLR_F32__Rasterizer__P10RasterizerUiUi:0",CODE


;bool Rasterizer::drawPointsXYZ_F32_CLR_F32(Rasterizer* rast, size_t 
	XDEF	drawPointsXYZ_F32_CLR_F32__Rasterizer__P10RasterizerUiUi
drawPointsXYZ_F32_CLR_F32__Rasterizer__P10RasterizerUiUi
	move.l	a6,-(a7)
	move.l	$8(a7),a0
L230
;	if (W3D_GetState(rast->context, W3D_GOURAUD)==W3D_ENABLED)
	move.l	_Warp3DBase,a6
	move.l	#$400,d1
	move.l	(a0),a0
	jsr	-$2A(a6)
L231
;	return false;
	moveq	#0,d0
	move.l	(a7)+,a6
	rts

	SECTION "drawPointsXYZ_F64_CLR_U8__Rasterizer__P10RasterizerUiUi:0",CODE


;bool Rasterizer::drawPointsXYZ_F64_CLR_U8(Rasterizer* rast, size_t o
	XDEF	drawPointsXYZ_F64_CLR_U8__Rasterizer__P10RasterizerUiUi
drawPointsXYZ_F64_CLR_U8__Rasterizer__P10RasterizerUiUi
	move.l	a6,-(a7)
	move.l	$8(a7),a0
L232
;	if (W3D_GetState(rast->context, W3D_GOURAUD)==W3D_ENABLED)
	move.l	_Warp3DBase,a6
	move.l	#$400,d1
	move.l	(a0),a0
	jsr	-$2A(a6)
L233
;	return false;
	moveq	#0,d0
	move.l	(a7)+,a6
	rts

	SECTION "drawPointsXYZ_F64_CLR_F32__Rasterizer__P10RasterizerUiUi:0",CODE


;bool Rasterizer::drawPointsXYZ_F64_CLR_F32(Rasterizer* rast, size_t 
	XDEF	drawPointsXYZ_F64_CLR_F32__Rasterizer__P10RasterizerUiUi
drawPointsXYZ_F64_CLR_F32__Rasterizer__P10RasterizerUiUi
	move.l	a6,-(a7)
	move.l	$8(a7),a0
L234
;	if (W3D_GetState(rast->context, W3D_GOURAUD)==W3D_ENABLED)
	move.l	_Warp3DBase,a6
	move.l	#$400,d1
	move.l	(a0),a0
	jsr	-$2A(a6)
L235
;	return false;
	moveq	#0,d0
	move.l	(a7)+,a6
	rts

	SECTION "_drawPointsXYZ_F32__Rasterizer:1",DATA

	XDEF	_drawPointsXYZ_F32__Rasterizer
_drawPointsXYZ_F32__Rasterizer
	dc.l	drawPointsXYZ_F32_CLR_U8__Rasterizer__P10RasterizerUiUi,drawPointsXYZ_F32_CLR_U8__Rasterizer__P10RasterizerUiUi,drawPointsXYZ_F32_CLR_F32__Rasterizer__P10RasterizerUiUi,drawPointsXYZ_F32_CLR_F32__Rasterizer__P10RasterizerUiUi

	SECTION "_drawPointsXYZ_F64__Rasterizer:1",DATA

	XDEF	_drawPointsXYZ_F64__Rasterizer
_drawPointsXYZ_F64__Rasterizer
	dc.l	drawPointsXYZ_F64_CLR_U8__Rasterizer__P10RasterizerUiUi,drawPointsXYZ_F64_CLR_U8__Rasterizer__P10RasterizerUiUi,drawPointsXYZ_F64_CLR_F32__Rasterizer__P10RasterizerUiUi,drawPointsXYZ_F64_CLR_F32__Rasterizer__P10RasterizerUiUi

	SECTION "drawLines__Rasterizer__TUiUi:0",CODE


;bool Rasterizer::drawLines(size_t ofs, size_t cnt)
	XDEF	drawLines__Rasterizer__TUiUi
drawLines__Rasterizer__TUiUi
	move.l	d2,-(a7)
	move.l	$10(a7),d0
	move.l	$C(a7),d1
	move.l	$8(a7),a0
L238
;	if (!vrtPtrX || cnt < 2)
	tst.l	$C(a0)
	beq.b	L240
L239
	cmp.l	#2,d0
	bhs.b	L241
L240
;		return false;
	moveq	#0,d0
	move.l	(a7)+,d2
	rts
L241
;	if (useArrayEmul)
	tst.w	_useArrayEmul__Rasterizer
	beq.b	L246
L242
;		switch (vrtPtrType)
	move.l	$34(a0),d2
	cmp.l	#0,d2
	beq.b	L243
	cmp.l	#1,d2
	beq.b	L244
	bra.b	L245
;			
L243
;				return drawLinesXYZ_F32[clrPtrType](this, ofs, cnt);
	move.l	d0,-(a7)
	move.l	d1,-(a7)
	move.l	a0,-(a7)
	move.l	$38(a0),d0
	move.l	#_drawLinesXYZ_F32__Rasterizer,a1
	move.l	0(a1,d0.l*4),a0
	jsr	(a0)
	add.w	#$C,a7
	move.l	(a7)+,d2
	rts
L244
;				return drawLinesXYZ_F64[clrPtrType](this, ofs, cnt);
	move.l	d0,-(a7)
	move.l	d1,-(a7)
	move.l	a0,-(a7)
	move.l	$38(a0),d0
	move.l	#_drawLinesXYZ_F64__Rasterizer,a1
	move.l	0(a1,d0.l*4),a0
	jsr	(a0)
	add.w	#$C,a7
	move.l	(a7)+,d2
	rts
L245
;				return false;
	moveq	#0,d0
	move.l	(a7)+,d2
	rts
L246
;		return (W3D_DrawArray(context, W3D_PRIMITIVE_LINES, ofs, cnt)==W
	move.l	d0,-(a7)
	move.l	d1,-(a7)
	pea	4.w
	move.l	(a0),-(a7)
	jsr	_W3D_DrawArray
	add.w	#$10,a7
	tst.l	d0
	seq	d0
	and.l	#1,d0
	move.l	(a7)+,d2
	rts

	SECTION "drawLinesXYZ_F32_CLR_U8__Rasterizer__P10RasterizerUiUi:0",CODE


;bool Rasterizer::drawLinesXYZ_F32_CLR_U8(Rasterizer* rast, size_t of
	XDEF	drawLinesXYZ_F32_CLR_U8__Rasterizer__P10RasterizerUiUi
drawLinesXYZ_F32_CLR_U8__Rasterizer__P10RasterizerUiUi
L260	EQU	-$EC
	link	a5,#L260
	movem.l	d2-d5/a2/a3/a6,-(a7)
	fmovem.x fp2,-(a7)
	move.l	$10(a5),d2
	move.l	$C(a5),d5
	move.l	$8(a5),a3
L247
;	rsint32 ofst = ofs*rast->vrtPtrStride;
	move.l	a3,a0
	move.l	$40(a0),d0
	mulu.l	d5,d0
;	uint8 *x = rast->vrtPtrX+ofst;
	move.l	a3,a1
	move.l	d0,d1
	add.l	$C(a1),d1
	move.l	d1,-$98(a5)
;	uint8 *y = rast->vrtPtrY+ofst;
	move.l	a3,a1
	move.l	d0,d1
	add.l	$10(a1),d1
	move.l	d1,-$9C(a5)
;	uint8 *z = rast->vrtPtrZ+ofst;
	move.l	a3,a1
	add.l	$14(a1),d0
	move.l	d0,-$A0(a5)
;	if (shade = (W3D_GetState(rast->context, W3D_GOURAUD) == W3D_ENABL
	move.l	a3,a1
	move.l	_Warp3DBase,a6
	move.l	#$400,d1
	move.l	(a1),a0
	jsr	-$2A(a6)
	cmp.l	#1,d0
	seq	d0
	and.l	#1,d0
	move.w	d0,d4
	beq.b	L249
L248
;		ofst = ofs*rast->clrPtrStride;
	move.l	a3,a0
	move.l	$44(a0),d0
	mulu.l	d5,d0
;		a = rast->clrPtrA+ofst;
	move.l	a3,a1
	move.l	d0,d1
	add.l	$18(a1),d1
	move.l	d1,-$A4(a5)
;		r = rast->clrPtrR+ofst;
	move.l	a3,a1
	move.l	d0,d1
	add.l	$1C(a1),d1
	move.l	d1,-$A8(a5)
;		g = rast->clrPtrG+ofst;
	move.l	a3,a1
	move.l	d0,d1
	add.l	$20(a1),d1
	move.l	d1,-$AC(a5)
;		b = rast->clrPtrB+ofst;
	move.l	a3,a1
	add.l	$24(a1),d0
	move.l	d0,-$B0(a5)
L249
;	if (texture = (W3D_GetState(rast->context, W3D_TEXMAPPING) == W3D_
	move.l	a3,a1
	move.l	_Warp3DBase,a6
	move.l	#$100,d1
	move.l	(a1),a0
	jsr	-$2A(a6)
	cmp.l	#1,d0
	seq	d0
	and.l	#1,d0
	move.w	d0,d3
	beq.b	L251
L250
;		line.tex	= rast->texture->tex;
	move.l	a3,a1
	move.l	$8(a1),a0
	move.l	$8(a0),-$10(a5)
;		ofst = ofs*rast->texPtrStride;
	move.l	a3,a0
	move.l	$48(a0),d0
	mulu.l	d5,d0
;		w = rast->texPtrW+ofst;
	move.l	a3,a1
	move.l	d0,d1
	add.l	$28(a1),d1
	move.l	d1,-$BC(a5)
;		u = rast->texPtrUS+ofst;
	move.l	a3,a1
	move.l	d0,d1
	add.l	$2C(a1),d1
	move.l	d1,-$B4(a5)
;		v = rast->texPtrVT+ofst;
	move.l	a3,a1
	add.l	$30(a1),d0
	move.l	d0,-$B8(a5)
L251
;	rfloat32 f = 1F/256F;
	fmove.s	#$.3B800000,fp2
;	rsint32 cnt2 = 1+(cnt>>1);
	moveq	#1,d0
	lsr.l	d0,d2
	addq.l	#1,d2
;	while (--cnt2)
	bra	L258
L252
;		ofst = rast->vrtPtrStride;
	move.l	a3,a0
	move.l	$40(a0),d0
;		line.v1.x	= *((float32*)x);
	move.l	-$98(a5),a0
	move.l	(a0),-$90(a5)
; x += ofst;
	move.l	d0,d1
	add.l	-$98(a5),d1
	move.l	d1,-$98(a5)
;		line.v1.y	= *((float32*)y);
	move.l	-$9C(a5),a0
	fmove.s	(a0),fp0
	fmove.s	fp0,-$8C(a5)
; y += ofst;
	move.l	d0,d1
	add.l	-$9C(a5),d1
	move.l	d1,-$9C(a5)
;		line.v1.z	= *((float32*)z);
	move.l	-$A0(a5),a0
	fmove.s	(a0),fp0
	fmove.d	fp0,-$88(a5)
; z += ofst;
	move.l	d0,d1
	add.l	-$A0(a5),d1
	move.l	d1,-$A0(a5)
;		line.v2.x	= *((float32*)x);
	move.l	-$98(a5),a0
	fmove.s	(a0),fp0
	fmove.s	fp0,-$50(a5)
; x += ofst;
	move.l	d0,d1
	add.l	-$98(a5),d1
	move.l	d1,-$98(a5)
;		line.v2.y	= *((float32*)y);
	move.l	-$9C(a5),a0
	fmove.s	(a0),fp0
	fmove.s	fp0,-$4C(a5)
; y += ofst;
	move.l	d0,d1
	add.l	-$9C(a5),d1
	move.l	d1,-$9C(a5)
;		line.v2.z	= *((float32*)z);
	move.l	-$A0(a5),a0
	fmove.s	(a0),fp0
	fmove.d	fp0,-$48(a5)
; z += ofst;
	add.l	-$A0(a5),d0
	move.l	d0,-$A0(a5)
;		if (texture)
	tst.w	d3
	beq	L254
L253
;			ofst = rast->texPtrStride;
	move.l	a3,a0
	move.l	$48(a0),d0
;			line.v1.w = *((float32*)w);
	move.l	-$BC(a5),a0
	fmove.s	(a0),fp0
	fmove.s	fp0,-$80(a5)
; w += ofst;
	move.l	d0,d1
	add.l	-$BC(a5),d1
	move.l	d1,-$BC(a5)
;			line.v1.u = *((float32*)u);
	move.l	-$B4(a5),a0
	fmove.s	(a0),fp0
	fmove.s	fp0,-$7C(a5)
; u += ofst;
	move.l	d0,d1
	add.l	-$B4(a5),d1
	move.l	d1,-$B4(a5)
;			line.v1.v = *((float32*)v);
	move.l	-$B8(a5),a0
	fmove.s	(a0),fp0
	fmove.s	fp0,-$78(a5)
; v += ofst;
	move.l	d0,d1
	add.l	-$B8(a5),d1
	move.l	d1,-$B8(a5)
;			line.v2.w = *((float32*)w);
	move.l	-$BC(a5),a0
	fmove.s	(a0),fp0
	fmove.s	fp0,-$40(a5)
; w += ofst;
	move.l	d0,d1
	add.l	-$BC(a5),d1
	move.l	d1,-$BC(a5)
;			line.v2.u = *((float32*)u);
	move.l	-$B4(a5),a0
	fmove.s	(a0),fp0
	fmove.s	fp0,-$3C(a5)
; u += ofst;
	move.l	d0,d1
	add.l	-$B4(a5),d1
	move.l	d1,-$B4(a5)
;			line.v2.v = *((float32*)v);
	move.l	-$B8(a5),a0
	fmove.s	(a0),fp0
	fmove.s	fp0,-$38(a5)
; v += ofst;
	add.l	-$B8(a5),d0
	move.l	d0,-$B8(a5)
L254
;		if (shade)
	tst.w	d4
	beq	L256
L255
;			ofst = rast->clrPtrStride;
	move.l	a3,a0
	move.l	$44(a0),d0
;			line.v1.color.r	= f*(*r);
	move.l	-$A8(a5),a0
	moveq	#0,d1
	move.b	(a0),d1
	fmove.l	d1,fp0
	fmul.x	fp2,fp0
	fmove.s	fp0,-$70(a5)
;		r += ofst;
	move.l	d0,d1
	add.l	-$A8(a5),d1
	move.l	d1,-$A8(a5)
;			line.v1.color.g	= f*(*g);
	move.l	-$AC(a5),a0
	moveq	#0,d1
	move.b	(a0),d1
	fmove.l	d1,fp0
	fmul.x	fp2,fp0
	fmove.s	fp0,-$6C(a5)
;		g += ofst;
	move.l	d0,d1
	add.l	-$AC(a5),d1
	move.l	d1,-$AC(a5)
;			line.v1.color.b	= f*(*b);
	move.l	-$B0(a5),a0
	moveq	#0,d1
	move.b	(a0),d1
	fmove.l	d1,fp0
	fmul.x	fp2,fp0
	fmove.s	fp0,-$68(a5)
;		b += ofst;
	move.l	d0,d1
	add.l	-$B0(a5),d1
	move.l	d1,-$B0(a5)
;			line.v1.color.a	= f*(*a);
	move.l	-$A4(a5),a0
	moveq	#0,d1
	move.b	(a0),d1
	fmove.l	d1,fp0
	fmul.x	fp2,fp0
	fmove.s	fp0,-$64(a5)
;		a += ofst;
	move.l	d0,d1
	add.l	-$A4(a5),d1
	move.l	d1,-$A4(a5)
;			line.v2.color.r	= f*(*r);
	move.l	-$A8(a5),a0
	moveq	#0,d1
	move.b	(a0),d1
	fmove.l	d1,fp0
	fmul.x	fp2,fp0
	fmove.s	fp0,-$30(a5)
;		r += ofst;
	move.l	d0,d1
	add.l	-$A8(a5),d1
	move.l	d1,-$A8(a5)
;			line.v2.color.g	= f*(*g);
	move.l	-$AC(a5),a0
	moveq	#0,d1
	move.b	(a0),d1
	fmove.l	d1,fp0
	fmul.x	fp2,fp0
	fmove.s	fp0,-$2C(a5)
;		g += ofst;
	move.l	d0,d1
	add.l	-$AC(a5),d1
	move.l	d1,-$AC(a5)
;			line.v2.color.b	= f*(*b);
	move.l	-$B0(a5),a0
	moveq	#0,d1
	move.b	(a0),d1
	fmove.l	d1,fp0
	fmul.x	fp2,fp0
	fmove.s	fp0,-$28(a5)
;		b += ofst;
	move.l	d0,d1
	add.l	-$B0(a5),d1
	move.l	d1,-$B0(a5)
;			line.v2.color.a	= f*(*a);
	move.l	-$A4(a5),a0
	moveq	#0,d1
	move.b	(a0),d1
	fmove.l	d1,fp0
	fmul.x	fp2,fp0
	fmove.s	fp0,-$24(a5)
;		a += ofst;
	add.l	-$A4(a5),d0
	move.l	d0,-$A4(a5)
L256
;		if (W3D_DrawLine(rast->context, &line)!=W3D_SUCCESS)
	move.l	a3,a2
	move.l	_Warp3DBase,a6
	move.l	(a2),a0
	lea	-$90(a5),a1
	jsr	-$96(a6)
	tst.l	d0
	beq.b	L258
L257
;			return false;
	moveq	#0,d0
	fmovem.x (a7)+,fp2
	movem.l	(a7)+,d2-d5/a2/a3/a6
	unlk	a5
	rts
L258
	subq.l	#1,d2
	tst.l	d2
	bne	L252
L259
;	return true;
	moveq	#1,d0
	fmovem.x (a7)+,fp2
	movem.l	(a7)+,d2-d5/a2/a3/a6
	unlk	a5
	rts

	SECTION "drawLinesXYZ_F32_CLR_F32__Rasterizer__P10RasterizerUiUi:0",CODE


;bool Rasterizer::drawLinesXYZ_F32_CLR_F32(Rasterizer* rast, size_t o
	XDEF	drawLinesXYZ_F32_CLR_F32__Rasterizer__P10RasterizerUiUi
drawLinesXYZ_F32_CLR_F32__Rasterizer__P10RasterizerUiUi
L274	EQU	-$EC
	link	a5,#L274
	movem.l	d2-d5/a2/a3/a6,-(a7)
	move.l	$10(a5),d2
	move.l	$C(a5),d5
	move.l	$8(a5),a3
L261
;	rsint32 ofst = ofs*rast->vrtPtrStride;
	move.l	a3,a0
	move.l	$40(a0),d0
	mulu.l	d5,d0
;	uint8 *x = rast->vrtPtrX+ofst;
	move.l	a3,a1
	move.l	d0,d1
	add.l	$C(a1),d1
	move.l	d1,-$98(a5)
;	uint8 *y = rast->vrtPtrY+ofst;
	move.l	a3,a1
	move.l	d0,d1
	add.l	$10(a1),d1
	move.l	d1,-$9C(a5)
;	uint8 *z = rast->vrtPtrZ+ofst;
	move.l	a3,a1
	add.l	$14(a1),d0
	move.l	d0,-$A0(a5)
;	if (shade = (W3D_GetState(rast->context, W3D_GOURAUD) == W3D_ENABL
	move.l	a3,a1
	move.l	_Warp3DBase,a6
	move.l	#$400,d1
	move.l	(a1),a0
	jsr	-$2A(a6)
	cmp.l	#1,d0
	seq	d0
	and.l	#1,d0
	move.w	d0,d4
	beq.b	L263
L262
;		ofst = ofs*rast->clrPtrStride;
	move.l	a3,a0
	move.l	$44(a0),d0
	mulu.l	d5,d0
;		a = rast->clrPtrA+ofst;
	move.l	a3,a1
	move.l	d0,d1
	add.l	$18(a1),d1
	move.l	d1,-$A4(a5)
;		r = rast->clrPtrR+ofst;
	move.l	a3,a1
	move.l	d0,d1
	add.l	$1C(a1),d1
	move.l	d1,-$A8(a5)
;		g = rast->clrPtrG+ofst;
	move.l	a3,a1
	move.l	d0,d1
	add.l	$20(a1),d1
	move.l	d1,-$AC(a5)
;		b = rast->clrPtrB+ofst;
	move.l	a3,a1
	add.l	$24(a1),d0
	move.l	d0,-$B0(a5)
L263
;	if (texture = (W3D_GetState(rast->context, W3D_TEXMAPPING) == W3D_
	move.l	a3,a1
	move.l	_Warp3DBase,a6
	move.l	#$100,d1
	move.l	(a1),a0
	jsr	-$2A(a6)
	cmp.l	#1,d0
	seq	d0
	and.l	#1,d0
	move.w	d0,d3
	beq.b	L265
L264
;		line.tex	= rast->texture->tex;
	move.l	a3,a1
	move.l	$8(a1),a0
	move.l	$8(a0),-$10(a5)
;		ofst = ofs*rast->texPtrStride;
	move.l	a3,a0
	move.l	$48(a0),d0
	mulu.l	d5,d0
;		w = rast->texPtrW+ofst;
	move.l	a3,a1
	move.l	d0,d1
	add.l	$28(a1),d1
	move.l	d1,-$BC(a5)
;		u = rast->texPtrUS+ofst;
	move.l	a3,a1
	move.l	d0,d1
	add.l	$2C(a1),d1
	move.l	d1,-$B4(a5)
;		v = rast->texPtrVT+ofst;
	move.l	a3,a1
	add.l	$30(a1),d0
	move.l	d0,-$B8(a5)
L265
;	rsint32 cnt2 = 1+(cnt>>1);
	moveq	#1,d0
	lsr.l	d0,d2
	addq.l	#1,d2
;	while (--cnt2)
	bra	L272
L266
;		ofst = rast->vrtPtrStride;
	move.l	a3,a0
	move.l	$40(a0),d0
;		line.v1.x	= *((float32*)x);
	move.l	-$98(a5),a0
	move.l	(a0),-$90(a5)
; x += ofst;
	move.l	d0,d1
	add.l	-$98(a5),d1
	move.l	d1,-$98(a5)
;		line.v1.y	= *((float32*)y);
	move.l	-$9C(a5),a0
	fmove.s	(a0),fp0
	fmove.s	fp0,-$8C(a5)
; y += ofst;
	move.l	d0,d1
	add.l	-$9C(a5),d1
	move.l	d1,-$9C(a5)
;		line.v1.z	= *((float32*)z);
	move.l	-$A0(a5),a0
	fmove.s	(a0),fp0
	fmove.d	fp0,-$88(a5)
; z += ofst;
	move.l	d0,d1
	add.l	-$A0(a5),d1
	move.l	d1,-$A0(a5)
;		line.v2.x	= *((float32*)x);
	move.l	-$98(a5),a0
	fmove.s	(a0),fp0
	fmove.s	fp0,-$50(a5)
; x += ofst;
	move.l	d0,d1
	add.l	-$98(a5),d1
	move.l	d1,-$98(a5)
;		line.v2.y	= *((float32*)y);
	move.l	-$9C(a5),a0
	fmove.s	(a0),fp0
	fmove.s	fp0,-$4C(a5)
; y += ofst;
	move.l	d0,d1
	add.l	-$9C(a5),d1
	move.l	d1,-$9C(a5)
;		line.v2.z	= *((float32*)z);
	move.l	-$A0(a5),a0
	fmove.s	(a0),fp0
	fmove.d	fp0,-$48(a5)
; z += ofst;
	add.l	-$A0(a5),d0
	move.l	d0,-$A0(a5)
;		if (texture)
	tst.w	d3
	beq	L268
L267
;			ofst = rast->texPtrStride;
	move.l	a3,a0
	move.l	$48(a0),d0
;			line.v1.w = *((float32*)w);
	move.l	-$BC(a5),a0
	fmove.s	(a0),fp0
	fmove.s	fp0,-$80(a5)
; w += ofst;
	move.l	d0,d1
	add.l	-$BC(a5),d1
	move.l	d1,-$BC(a5)
;			line.v1.u = *((float32*)u);
	move.l	-$B4(a5),a0
	fmove.s	(a0),fp0
	fmove.s	fp0,-$7C(a5)
; u += ofst;
	move.l	d0,d1
	add.l	-$B4(a5),d1
	move.l	d1,-$B4(a5)
;			line.v1.v = *((float32*)v);
	move.l	-$B8(a5),a0
	fmove.s	(a0),fp0
	fmove.s	fp0,-$78(a5)
; v += ofst;
	move.l	d0,d1
	add.l	-$B8(a5),d1
	move.l	d1,-$B8(a5)
;			line.v2.w = *((float32*)w);
	move.l	-$BC(a5),a0
	fmove.s	(a0),fp0
	fmove.s	fp0,-$40(a5)
; w += ofst;
	move.l	d0,d1
	add.l	-$BC(a5),d1
	move.l	d1,-$BC(a5)
;			line.v2.u = *((float32*)u);
	move.l	-$B4(a5),a0
	fmove.s	(a0),fp0
	fmove.s	fp0,-$3C(a5)
; u += ofst;
	move.l	d0,d1
	add.l	-$B4(a5),d1
	move.l	d1,-$B4(a5)
;			line.v2.v = *((float32*)v);
	move.l	-$B8(a5),a0
	fmove.s	(a0),fp0
	fmove.s	fp0,-$38(a5)
; v += ofst;
	add.l	-$B8(a5),d0
	move.l	d0,-$B8(a5)
L268
;		if (shade)
	tst.w	d4
	beq	L270
L269
;			ofst = rast->clrPtrStride;
	move.l	a3,a0
	move.l	$44(a0),d0
;			line.v1.color.r	= *((float32*)r);
	move.l	-$A8(a5),a0
	fmove.s	(a0),fp0
	fmove.s	fp0,-$70(a5)
; r += ofst;
	move.l	d0,d1
	add.l	-$A8(a5),d1
	move.l	d1,-$A8(a5)
;			line.v1.color.g	= *((float32*)g);
	move.l	-$AC(a5),a0
	fmove.s	(a0),fp0
	fmove.s	fp0,-$6C(a5)
; g += ofst;
	move.l	d0,d1
	add.l	-$AC(a5),d1
	move.l	d1,-$AC(a5)
;			line.v1.color.b	= *((float32*)b);
	move.l	-$B0(a5),a0
	fmove.s	(a0),fp0
	fmove.s	fp0,-$68(a5)
; b += ofst;
	move.l	d0,d1
	add.l	-$B0(a5),d1
	move.l	d1,-$B0(a5)
;			line.v1.color.a	= *((float32*)a);
	move.l	-$A4(a5),a0
	fmove.s	(a0),fp0
	fmove.s	fp0,-$64(a5)
; a += ofst;
	move.l	d0,d1
	add.l	-$A4(a5),d1
	move.l	d1,-$A4(a5)
;			line.v2.color.r	= *((float32*)r);
	move.l	-$A8(a5),a0
	fmove.s	(a0),fp0
	fmove.s	fp0,-$30(a5)
; r += ofst;
	move.l	d0,d1
	add.l	-$A8(a5),d1
	move.l	d1,-$A8(a5)
;			line.v2.color.g	= *((float32*)g);
	move.l	-$AC(a5),a0
	fmove.s	(a0),fp0
	fmove.s	fp0,-$2C(a5)
; g += ofst;
	move.l	d0,d1
	add.l	-$AC(a5),d1
	move.l	d1,-$AC(a5)
;			line.v2.color.b	= *((float32*)b);
	move.l	-$B0(a5),a0
	fmove.s	(a0),fp0
	fmove.s	fp0,-$28(a5)
; b += ofst;
	move.l	d0,d1
	add.l	-$B0(a5),d1
	move.l	d1,-$B0(a5)
;			line.v2.color.a	= *((float32*)a);
	move.l	-$A4(a5),a0
	fmove.s	(a0),fp0
	fmove.s	fp0,-$24(a5)
; a += ofst;
	add.l	-$A4(a5),d0
	move.l	d0,-$A4(a5)
L270
;		if (W3D_DrawLine(rast->context, &line)!=W3D_SUCCESS)
	move.l	a3,a2
	move.l	_Warp3DBase,a6
	move.l	(a2),a0
	lea	-$90(a5),a1
	jsr	-$96(a6)
	tst.l	d0
	beq.b	L272
L271
;			return false;
	moveq	#0,d0
	movem.l	(a7)+,d2-d5/a2/a3/a6
	unlk	a5
	rts
L272
	subq.l	#1,d2
	tst.l	d2
	bne	L266
L273
;	return true;
	moveq	#1,d0
	movem.l	(a7)+,d2-d5/a2/a3/a6
	unlk	a5
	rts

	SECTION "drawLinesXYZ_F64_CLR_U8__Rasterizer__P10RasterizerUiUi:0",CODE


;bool Rasterizer::drawLinesXYZ_F64_CLR_U8(Rasterizer* rast, size_t of
	XDEF	drawLinesXYZ_F64_CLR_U8__Rasterizer__P10RasterizerUiUi
drawLinesXYZ_F64_CLR_U8__Rasterizer__P10RasterizerUiUi
L288	EQU	-$EC
	link	a5,#L288
	movem.l	d2-d5/a2/a3/a6,-(a7)
	fmovem.x fp2,-(a7)
	move.l	$10(a5),d2
	move.l	$C(a5),d5
	move.l	$8(a5),a3
L275
;	rsint32 ofst = ofs*rast->vrtPtrStride;
	move.l	a3,a0
	move.l	$40(a0),d0
	mulu.l	d5,d0
;	uint8 *x = rast->vrtPtrX+ofst;
	move.l	a3,a1
	move.l	d0,d1
	add.l	$C(a1),d1
	move.l	d1,-$98(a5)
;	uint8 *y = rast->vrtPtrY+ofst;
	move.l	a3,a1
	move.l	d0,d1
	add.l	$10(a1),d1
	move.l	d1,-$9C(a5)
;	uint8 *z = rast->vrtPtrZ+ofst;
	move.l	a3,a1
	add.l	$14(a1),d0
	move.l	d0,-$A0(a5)
;	if (shade = (W3D_GetState(rast->context, W3D_GOURAUD) == W3D_ENABL
	move.l	a3,a1
	move.l	_Warp3DBase,a6
	move.l	#$400,d1
	move.l	(a1),a0
	jsr	-$2A(a6)
	cmp.l	#1,d0
	seq	d0
	and.l	#1,d0
	move.w	d0,d4
	beq.b	L277
L276
;		ofst = ofs*rast->clrPtrStride;
	move.l	a3,a0
	move.l	$44(a0),d0
	mulu.l	d5,d0
;		a = rast->clrPtrA+ofst;
	move.l	a3,a1
	move.l	d0,d1
	add.l	$18(a1),d1
	move.l	d1,-$A4(a5)
;		r = rast->clrPtrR+ofst;
	move.l	a3,a1
	move.l	d0,d1
	add.l	$1C(a1),d1
	move.l	d1,-$A8(a5)
;		g = rast->clrPtrG+ofst;
	move.l	a3,a1
	move.l	d0,d1
	add.l	$20(a1),d1
	move.l	d1,-$AC(a5)
;		b = rast->clrPtrB+ofst;
	move.l	a3,a1
	add.l	$24(a1),d0
	move.l	d0,-$B0(a5)
L277
;	if (texture = (W3D_GetState(rast->context, W3D_TEXMAPPING) == W3D_
	move.l	a3,a1
	move.l	_Warp3DBase,a6
	move.l	#$100,d1
	move.l	(a1),a0
	jsr	-$2A(a6)
	cmp.l	#1,d0
	seq	d0
	and.l	#1,d0
	move.w	d0,d3
	beq.b	L279
L278
;		line.tex	= rast->texture->tex;
	move.l	a3,a1
	move.l	$8(a1),a0
	move.l	$8(a0),-$10(a5)
;		ofst = ofs*rast->texPtrStride;
	move.l	a3,a0
	move.l	$48(a0),d0
	mulu.l	d5,d0
;		w = rast->texPtrW+ofst;
	move.l	a3,a1
	move.l	d0,d1
	add.l	$28(a1),d1
	move.l	d1,-$BC(a5)
;		u = rast->texPtrUS+ofst;
	move.l	a3,a1
	move.l	d0,d1
	add.l	$2C(a1),d1
	move.l	d1,-$B4(a5)
;		v = rast->texPtrVT+ofst;
	move.l	a3,a1
	add.l	$30(a1),d0
	move.l	d0,-$B8(a5)
L279
;	rfloat32 f = 1F/256F;
	fmove.s	#$.3B800000,fp2
;	rsint32 cnt2 = 1+(cnt>>1);
	moveq	#1,d0
	lsr.l	d0,d2
	addq.l	#1,d2
;	while (--cnt2)
	bra	L286
L280
;		ofst = rast->vrtPtrStride;
	move.l	a3,a0
	move.l	$40(a0),d0
;		line.v1.x	= *((float64*)x);
	move.l	-$98(a5),a0
	fmove.d	(a0),fp0
	fmove.s	fp0,-$90(a5)
; x += ofst;
	move.l	d0,d1
	add.l	-$98(a5),d1
	move.l	d1,-$98(a5)
;		line.v1.y	= *((float64*)y);
	move.l	-$9C(a5),a0
	fmove.d	(a0),fp0
	fmove.s	fp0,-$8C(a5)
; y += ofst;
	move.l	d0,d1
	add.l	-$9C(a5),d1
	move.l	d1,-$9C(a5)
;		line.v1.z	= *((float64*)z);
	move.l	-$A0(a5),a0
	fmove.d	(a0),fp0
	fmove.d	fp0,-$88(a5)
; z += ofst;
	move.l	d0,d1
	add.l	-$A0(a5),d1
	move.l	d1,-$A0(a5)
;		line.v2.x	= *((float64*)x);
	move.l	-$98(a5),a0
	fmove.d	(a0),fp0
	fmove.s	fp0,-$50(a5)
; x += ofst;
	move.l	d0,d1
	add.l	-$98(a5),d1
	move.l	d1,-$98(a5)
;		line.v2.y	= *((float64*)y);
	move.l	-$9C(a5),a0
	fmove.d	(a0),fp0
	fmove.s	fp0,-$4C(a5)
; y += ofst;
	move.l	d0,d1
	add.l	-$9C(a5),d1
	move.l	d1,-$9C(a5)
;		line.v2.z	= *((float64*)z);
	move.l	-$A0(a5),a0
	fmove.d	(a0),fp0
	fmove.d	fp0,-$48(a5)
; z += ofst;
	add.l	-$A0(a5),d0
	move.l	d0,-$A0(a5)
;		if (texture)
	tst.w	d3
	beq	L282
L281
;			ofst = rast->texPtrStride;
	move.l	a3,a0
	move.l	$48(a0),d0
;			line.v1.w = *((float32*)w);
	move.l	-$BC(a5),a0
	fmove.s	(a0),fp0
	fmove.s	fp0,-$80(a5)
; w += ofst;
	move.l	d0,d1
	add.l	-$BC(a5),d1
	move.l	d1,-$BC(a5)
;			line.v1.u = *((float32*)u);
	move.l	-$B4(a5),a0
	fmove.s	(a0),fp0
	fmove.s	fp0,-$7C(a5)
; u += ofst;
	move.l	d0,d1
	add.l	-$B4(a5),d1
	move.l	d1,-$B4(a5)
;			line.v1.v = *((float32*)v);
	move.l	-$B8(a5),a0
	fmove.s	(a0),fp0
	fmove.s	fp0,-$78(a5)
; v += ofst;
	move.l	d0,d1
	add.l	-$B8(a5),d1
	move.l	d1,-$B8(a5)
;			line.v2.w = *((float32*)w);
	move.l	-$BC(a5),a0
	fmove.s	(a0),fp0
	fmove.s	fp0,-$40(a5)
; w += ofst;
	move.l	d0,d1
	add.l	-$BC(a5),d1
	move.l	d1,-$BC(a5)
;			line.v2.u = *((float32*)u);
	move.l	-$B4(a5),a0
	fmove.s	(a0),fp0
	fmove.s	fp0,-$3C(a5)
; u += ofst;
	move.l	d0,d1
	add.l	-$B4(a5),d1
	move.l	d1,-$B4(a5)
;			line.v2.v = *((float32*)v);
	move.l	-$B8(a5),a0
	fmove.s	(a0),fp0
	fmove.s	fp0,-$38(a5)
; v += ofst;
	add.l	-$B8(a5),d0
	move.l	d0,-$B8(a5)
L282
;		if (shade)
	tst.w	d4
	beq	L284
L283
;			ofst = rast->clrPtrStride;
	move.l	a3,a0
	move.l	$44(a0),d0
;			line.v1.color.r	= f*(*r);
	move.l	-$A8(a5),a0
	moveq	#0,d1
	move.b	(a0),d1
	fmove.l	d1,fp0
	fmul.x	fp2,fp0
	fmove.s	fp0,-$70(a5)
; r += ofst;
	move.l	d0,d1
	add.l	-$A8(a5),d1
	move.l	d1,-$A8(a5)
;			line.v1.color.g	= f*(*g);
	move.l	-$AC(a5),a0
	moveq	#0,d1
	move.b	(a0),d1
	fmove.l	d1,fp0
	fmul.x	fp2,fp0
	fmove.s	fp0,-$6C(a5)
; g += ofst;
	move.l	d0,d1
	add.l	-$AC(a5),d1
	move.l	d1,-$AC(a5)
;			line.v1.color.b	= f*(*b);
	move.l	-$B0(a5),a0
	moveq	#0,d1
	move.b	(a0),d1
	fmove.l	d1,fp0
	fmul.x	fp2,fp0
	fmove.s	fp0,-$68(a5)
; b += ofst;
	move.l	d0,d1
	add.l	-$B0(a5),d1
	move.l	d1,-$B0(a5)
;			line.v1.color.a	= f*(*a);
	move.l	-$A4(a5),a0
	moveq	#0,d1
	move.b	(a0),d1
	fmove.l	d1,fp0
	fmul.x	fp2,fp0
	fmove.s	fp0,-$64(a5)
; a += ofst;
	move.l	d0,d1
	add.l	-$A4(a5),d1
	move.l	d1,-$A4(a5)
;			line.v2.color.r	= f*(*r);
	move.l	-$A8(a5),a0
	moveq	#0,d1
	move.b	(a0),d1
	fmove.l	d1,fp0
	fmul.x	fp2,fp0
	fmove.s	fp0,-$30(a5)
; r += ofst;
	move.l	d0,d1
	add.l	-$A8(a5),d1
	move.l	d1,-$A8(a5)
;			line.v2.color.g	= f*(*g);
	move.l	-$AC(a5),a0
	moveq	#0,d1
	move.b	(a0),d1
	fmove.l	d1,fp0
	fmul.x	fp2,fp0
	fmove.s	fp0,-$2C(a5)
; g += ofst;
	move.l	d0,d1
	add.l	-$AC(a5),d1
	move.l	d1,-$AC(a5)
;			line.v2.color.b	= f*(*b);
	move.l	-$B0(a5),a0
	moveq	#0,d1
	move.b	(a0),d1
	fmove.l	d1,fp0
	fmul.x	fp2,fp0
	fmove.s	fp0,-$28(a5)
; b += ofst;
	move.l	d0,d1
	add.l	-$B0(a5),d1
	move.l	d1,-$B0(a5)
;			line.v2.color.a	= f*(*a);
	move.l	-$A4(a5),a0
	moveq	#0,d1
	move.b	(a0),d1
	fmove.l	d1,fp0
	fmul.x	fp2,fp0
	fmove.s	fp0,-$24(a5)
; a += ofst;
	add.l	-$A4(a5),d0
	move.l	d0,-$A4(a5)
L284
;		if (W3D_DrawLine(rast->context, &line)!=W3D_SUCCESS)
	move.l	a3,a2
	move.l	_Warp3DBase,a6
	move.l	(a2),a0
	lea	-$90(a5),a1
	jsr	-$96(a6)
	tst.l	d0
	beq.b	L286
L285
;			return false;
	moveq	#0,d0
	fmovem.x (a7)+,fp2
	movem.l	(a7)+,d2-d5/a2/a3/a6
	unlk	a5
	rts
L286
	subq.l	#1,d2
	tst.l	d2
	bne	L280
L287
;	return true;
	moveq	#1,d0
	fmovem.x (a7)+,fp2
	movem.l	(a7)+,d2-d5/a2/a3/a6
	unlk	a5
	rts

	SECTION "drawLinesXYZ_F64_CLR_F32__Rasterizer__P10RasterizerUiUi:0",CODE


;bool Rasterizer::drawLinesXYZ_F64_CLR_F32(Rasterizer* rast, size_t o
	XDEF	drawLinesXYZ_F64_CLR_F32__Rasterizer__P10RasterizerUiUi
drawLinesXYZ_F64_CLR_F32__Rasterizer__P10RasterizerUiUi
L302	EQU	-$EC
	link	a5,#L302
	movem.l	d2-d5/a2/a3/a6,-(a7)
	move.l	$10(a5),d2
	move.l	$C(a5),d5
	move.l	$8(a5),a3
L289
;	rsint32 ofst = ofs*rast->vrtPtrStride;
	move.l	a3,a0
	move.l	$40(a0),d0
	mulu.l	d5,d0
;	uint8 *x = rast->vrtPtrX+ofst;
	move.l	a3,a1
	move.l	d0,d1
	add.l	$C(a1),d1
	move.l	d1,-$98(a5)
;	uint8 *y = rast->vrtPtrY+ofst;
	move.l	a3,a1
	move.l	d0,d1
	add.l	$10(a1),d1
	move.l	d1,-$9C(a5)
;	uint8 *z = rast->vrtPtrZ+ofst;
	move.l	a3,a1
	add.l	$14(a1),d0
	move.l	d0,-$A0(a5)
;	if (shade = (W3D_GetState(rast->context, W3D_GOURAUD) == W3D_ENABL
	move.l	a3,a1
	move.l	_Warp3DBase,a6
	move.l	#$400,d1
	move.l	(a1),a0
	jsr	-$2A(a6)
	cmp.l	#1,d0
	seq	d0
	and.l	#1,d0
	move.w	d0,d4
	beq.b	L291
L290
;		ofst = ofs*rast->clrPtrStride;
	move.l	a3,a0
	move.l	$44(a0),d0
	mulu.l	d5,d0
;		a = rast->clrPtrA+ofst;
	move.l	a3,a1
	move.l	d0,d1
	add.l	$18(a1),d1
	move.l	d1,-$A4(a5)
;		r = rast->clrPtrR+ofst;
	move.l	a3,a1
	move.l	d0,d1
	add.l	$1C(a1),d1
	move.l	d1,-$A8(a5)
;		g = rast->clrPtrG+ofst;
	move.l	a3,a1
	move.l	d0,d1
	add.l	$20(a1),d1
	move.l	d1,-$AC(a5)
;		b = rast->clrPtrB+ofst;
	move.l	a3,a1
	add.l	$24(a1),d0
	move.l	d0,-$B0(a5)
L291
;	if (texture = (W3D_GetState(rast->context, W3D_TEXMAPPING) == W3D_
	move.l	a3,a1
	move.l	_Warp3DBase,a6
	move.l	#$100,d1
	move.l	(a1),a0
	jsr	-$2A(a6)
	cmp.l	#1,d0
	seq	d0
	and.l	#1,d0
	move.w	d0,d3
	beq.b	L293
L292
;		line.tex	= rast->texture->tex;
	move.l	a3,a1
	move.l	$8(a1),a0
	move.l	$8(a0),-$10(a5)
;		ofst = ofs*rast->texPtrStride;
	move.l	a3,a0
	move.l	$48(a0),d0
	mulu.l	d5,d0
;		w = rast->texPtrW+ofst;
	move.l	a3,a1
	move.l	d0,d1
	add.l	$28(a1),d1
	move.l	d1,-$BC(a5)
;		u = rast->texPtrUS+ofst;
	move.l	a3,a1
	move.l	d0,d1
	add.l	$2C(a1),d1
	move.l	d1,-$B4(a5)
;		v = rast->texPtrVT+ofst;
	move.l	a3,a1
	add.l	$30(a1),d0
	move.l	d0,-$B8(a5)
L293
;	rsint32 cnt2 = 1+(cnt>>1);
	moveq	#1,d0
	lsr.l	d0,d2
	addq.l	#1,d2
;	while (--cnt2)
	bra	L300
L294
;		ofst = rast->vrtPtrStride;
	move.l	a3,a0
	move.l	$40(a0),d0
;		line.v1.x	= *((float64*)x);
	move.l	-$98(a5),a0
	fmove.d	(a0),fp0
	fmove.s	fp0,-$90(a5)
; x += ofst;
	move.l	d0,d1
	add.l	-$98(a5),d1
	move.l	d1,-$98(a5)
;		line.v1.y	= *((float64*)y);
	move.l	-$9C(a5),a0
	fmove.d	(a0),fp0
	fmove.s	fp0,-$8C(a5)
; y += ofst;
	move.l	d0,d1
	add.l	-$9C(a5),d1
	move.l	d1,-$9C(a5)
;		line.v1.z	= *((float64*)z);
	move.l	-$A0(a5),a0
	fmove.d	(a0),fp0
	fmove.d	fp0,-$88(a5)
; z += ofst;
	move.l	d0,d1
	add.l	-$A0(a5),d1
	move.l	d1,-$A0(a5)
;		line.v2.x	= *((float64*)x);
	move.l	-$98(a5),a0
	fmove.d	(a0),fp0
	fmove.s	fp0,-$50(a5)
; x += ofst;
	move.l	d0,d1
	add.l	-$98(a5),d1
	move.l	d1,-$98(a5)
;		line.v2.y	= *((float64*)y);
	move.l	-$9C(a5),a0
	fmove.d	(a0),fp0
	fmove.s	fp0,-$4C(a5)
; y += ofst;
	move.l	d0,d1
	add.l	-$9C(a5),d1
	move.l	d1,-$9C(a5)
;		line.v2.z	= *((float64*)z);
	move.l	-$A0(a5),a0
	fmove.d	(a0),fp0
	fmove.d	fp0,-$48(a5)
; z += ofst;
	add.l	-$A0(a5),d0
	move.l	d0,-$A0(a5)
;		if (texture)
	tst.w	d3
	beq	L296
L295
;			ofst = rast->texPtrStride;
	move.l	a3,a0
	move.l	$48(a0),d0
;			line.v1.w = *((float32*)w);
	move.l	-$BC(a5),a0
	fmove.s	(a0),fp0
	fmove.s	fp0,-$80(a5)
; w += ofst;
	move.l	d0,d1
	add.l	-$BC(a5),d1
	move.l	d1,-$BC(a5)
;			line.v1.u = *((float32*)u);
	move.l	-$B4(a5),a0
	fmove.s	(a0),fp0
	fmove.s	fp0,-$7C(a5)
; u += ofst;
	move.l	d0,d1
	add.l	-$B4(a5),d1
	move.l	d1,-$B4(a5)
;			line.v1.v = *((float32*)v);
	move.l	-$B8(a5),a0
	fmove.s	(a0),fp0
	fmove.s	fp0,-$78(a5)
; v += ofst;
	move.l	d0,d1
	add.l	-$B8(a5),d1
	move.l	d1,-$B8(a5)
;			line.v2.w = *((float32*)w);
	move.l	-$BC(a5),a0
	fmove.s	(a0),fp0
	fmove.s	fp0,-$40(a5)
; w += ofst;
	move.l	d0,d1
	add.l	-$BC(a5),d1
	move.l	d1,-$BC(a5)
;			line.v2.u = *((float32*)u);
	move.l	-$B4(a5),a0
	fmove.s	(a0),fp0
	fmove.s	fp0,-$3C(a5)
; u += ofst;
	move.l	d0,d1
	add.l	-$B4(a5),d1
	move.l	d1,-$B4(a5)
;			line.v2.v = *((float32*)v);
	move.l	-$B8(a5),a0
	fmove.s	(a0),fp0
	fmove.s	fp0,-$38(a5)
; v += ofst;
	add.l	-$B8(a5),d0
	move.l	d0,-$B8(a5)
L296
;		if (shade)
	tst.w	d4
	beq	L298
L297
;			ofst = rast->clrPtrStride;
	move.l	a3,a0
	move.l	$44(a0),d0
;			line.v1.color.r	= *((float32*)r);
	move.l	-$A8(a5),a0
	fmove.s	(a0),fp0
	fmove.s	fp0,-$70(a5)
; r += ofst;
	move.l	d0,d1
	add.l	-$A8(a5),d1
	move.l	d1,-$A8(a5)
;			line.v1.color.g	= *((float32*)g);
	move.l	-$AC(a5),a0
	fmove.s	(a0),fp0
	fmove.s	fp0,-$6C(a5)
; g += ofst;
	move.l	d0,d1
	add.l	-$AC(a5),d1
	move.l	d1,-$AC(a5)
;			line.v1.color.b	= *((float32*)b);
	move.l	-$B0(a5),a0
	fmove.s	(a0),fp0
	fmove.s	fp0,-$68(a5)
; b += ofst;
	move.l	d0,d1
	add.l	-$B0(a5),d1
	move.l	d1,-$B0(a5)
;			line.v1.color.a	= *((float32*)a);
	move.l	-$A4(a5),a0
	fmove.s	(a0),fp0
	fmove.s	fp0,-$64(a5)
; a += ofst;
	move.l	d0,d1
	add.l	-$A4(a5),d1
	move.l	d1,-$A4(a5)
;			line.v2.color.r	= *((float32*)r);
	move.l	-$A8(a5),a0
	fmove.s	(a0),fp0
	fmove.s	fp0,-$30(a5)
; r += ofst;
	move.l	d0,d1
	add.l	-$A8(a5),d1
	move.l	d1,-$A8(a5)
;			line.v2.color.g	= *((float32*)g);
	move.l	-$AC(a5),a0
	fmove.s	(a0),fp0
	fmove.s	fp0,-$2C(a5)
; g += ofst;
	move.l	d0,d1
	add.l	-$AC(a5),d1
	move.l	d1,-$AC(a5)
;			line.v2.color.b	= *((float32*)b);
	move.l	-$B0(a5),a0
	fmove.s	(a0),fp0
	fmove.s	fp0,-$28(a5)
; b += ofst;
	move.l	d0,d1
	add.l	-$B0(a5),d1
	move.l	d1,-$B0(a5)
;			line.v2.color.a	= *((float32*)a);
	move.l	-$A4(a5),a0
	fmove.s	(a0),fp0
	fmove.s	fp0,-$24(a5)
; a += ofst;
	add.l	-$A4(a5),d0
	move.l	d0,-$A4(a5)
L298
;		if (W3D_DrawLine(rast->context, &line)!=W3D_SUCCESS)
	move.l	a3,a2
	move.l	_Warp3DBase,a6
	move.l	(a2),a0
	lea	-$90(a5),a1
	jsr	-$96(a6)
	tst.l	d0
	beq.b	L300
L299
;			return false;
	moveq	#0,d0
	movem.l	(a7)+,d2-d5/a2/a3/a6
	unlk	a5
	rts
L300
	subq.l	#1,d2
	tst.l	d2
	bne	L294
L301
;	return true;
	moveq	#1,d0
	movem.l	(a7)+,d2-d5/a2/a3/a6
	unlk	a5
	rts

	SECTION "_drawLinesXYZ_F32__Rasterizer:1",DATA

	XDEF	_drawLinesXYZ_F32__Rasterizer
_drawLinesXYZ_F32__Rasterizer
	dc.l	drawLinesXYZ_F32_CLR_U8__Rasterizer__P10RasterizerUiUi,drawLinesXYZ_F32_CLR_U8__Rasterizer__P10RasterizerUiUi,drawLinesXYZ_F32_CLR_F32__Rasterizer__P10RasterizerUiUi,drawLinesXYZ_F32_CLR_F32__Rasterizer__P10RasterizerUiUi

	SECTION "_drawLinesXYZ_F64__Rasterizer:1",DATA

	XDEF	_drawLinesXYZ_F64__Rasterizer
_drawLinesXYZ_F64__Rasterizer
	dc.l	drawLinesXYZ_F64_CLR_U8__Rasterizer__P10RasterizerUiUi,drawLinesXYZ_F64_CLR_U8__Rasterizer__P10RasterizerUiUi,drawLinesXYZ_F64_CLR_F32__Rasterizer__P10RasterizerUiUi,drawLinesXYZ_F64_CLR_F32__Rasterizer__P10RasterizerUiUi

	SECTION "drawLineStrip__Rasterizer__TUiUi:0",CODE


;bool Rasterizer::drawLineStrip(size_t ofs, size_t cnt)
	XDEF	drawLineStrip__Rasterizer__TUiUi
drawLineStrip__Rasterizer__TUiUi
	move.l	d2,-(a7)
	move.l	$10(a7),d0
	move.l	$C(a7),d1
	move.l	$8(a7),a0
L305
;	if (!vrtPtrX || cnt < 2)
	tst.l	$C(a0)
	beq.b	L307
L306
	cmp.l	#2,d0
	bhs.b	L308
L307
;		return false;
	moveq	#0,d0
	move.l	(a7)+,d2
	rts
L308
;	if (useArrayEmul)
	tst.w	_useArrayEmul__Rasterizer
	beq.b	L313
L309
;		switch (vrtPtrType)
	move.l	$34(a0),d2
	cmp.l	#0,d2
	beq.b	L310
	cmp.l	#1,d2
	beq.b	L311
	bra.b	L312
;			
L310
;				return drawLineStripXYZ_F32[clrPtrType](this, ofs, cnt);
	move.l	d0,-(a7)
	move.l	d1,-(a7)
	move.l	a0,-(a7)
	move.l	$38(a0),d0
	move.l	#_drawLineStripXYZ_F32__Rasterizer,a1
	move.l	0(a1,d0.l*4),a0
	jsr	(a0)
	add.w	#$C,a7
	move.l	(a7)+,d2
	rts
L311
;				return drawLineStripXYZ_F64[clrPtrType](this, ofs, cnt);
	move.l	d0,-(a7)
	move.l	d1,-(a7)
	move.l	a0,-(a7)
	move.l	$38(a0),d0
	move.l	#_drawLineStripXYZ_F64__Rasterizer,a1
	move.l	0(a1,d0.l*4),a0
	jsr	(a0)
	add.w	#$C,a7
	move.l	(a7)+,d2
	rts
L312
;				return false;
	moveq	#0,d0
	move.l	(a7)+,d2
	rts
L313
;		return (W3D_DrawArray(context, W3D_PRIMITIVE_LINESTRIP, ofs, cnt)
	move.l	d0,-(a7)
	move.l	d1,-(a7)
	pea	6.w
	move.l	(a0),-(a7)
	jsr	_W3D_DrawArray
	add.w	#$10,a7
	tst.l	d0
	seq	d0
	and.l	#1,d0
	move.l	(a7)+,d2
	rts

	SECTION "drawLineStripXYZ_F32_CLR_U8__Rasterizer__P10RasterizerUiUi:0",CODE


;bool Rasterizer::drawLineStripXYZ_F32_CLR_U8(Rasterizer* rast, size_
	XDEF	drawLineStripXYZ_F32_CLR_U8__Rasterizer__P10RasterizerUiUi
drawLineStripXYZ_F32_CLR_U8__Rasterizer__P10RasterizerUiUi
L350	EQU	-$4F8
	link	a5,#L350
	movem.l	d2-d7/a2/a3/a6,-(a7)
	fmovem.x fp2,-(a7)
	movem.l	$C(a5),d2/d7
	move.l	$8(a5),a3
L314
;	W3D_Lines lines = {0, tempVert, 0};
	lea	-$498(a5),a0
	clr.l	(a0)+
	lea	-$480(a5),a1
	move.l	a1,(a0)+
	clr.l	(a0)+
	clr.l	(a0)+
	clr.l	(a0)+
	clr.l	(a0)+
;	rsint32 ofst = ofs*rast->vrtPtrStride;
	move.l	a3,a0
	move.l	$40(a0),d0
	mulu.l	d2,d0
;	uint8 *x = rast->vrtPtrX+ofst;
	move.l	a3,a1
	move.l	d0,d1
	add.l	$C(a1),d1
	move.l	d1,-$4A0(a5)
;	uint8 *y = rast->vrtPtrY+ofst;
	move.l	a3,a1
	move.l	d0,d1
	add.l	$10(a1),d1
	move.l	d1,-$4A4(a5)
;	uint8 *z = rast->vrtPtrZ+ofst;
	move.l	a3,a1
	add.l	$14(a1),d0
	move.l	d0,-$4A8(a5)
;	if (shade = (W3D_GetState(rast->context, W3D_GOURAUD) == W3D_ENABL
	move.l	a3,a1
	move.l	_Warp3DBase,a6
	move.l	#$400,d1
	move.l	(a1),a0
	jsr	-$2A(a6)
	cmp.l	#1,d0
	seq	d0
	and.l	#1,d0
	move.w	d0,d4
	beq.b	L316
L315
;		ofst = ofs*rast->clrPtrStride;
	move.l	a3,a0
	move.l	$44(a0),d0
	mulu.l	d2,d0
;		a = rast->clrPtrA+ofst;
	move.l	a3,a1
	move.l	d0,d1
	add.l	$18(a1),d1
	move.l	d1,-$4AC(a5)
;		r = rast->clrPtrR+ofst;
	move.l	a3,a1
	move.l	d0,d1
	add.l	$1C(a1),d1
	move.l	d1,-$4B0(a5)
;		g = rast->clrPtrG+ofst;
	move.l	a3,a1
	move.l	d0,d1
	add.l	$20(a1),d1
	move.l	d1,-$4B4(a5)
;		b = rast->clrPtrB+ofst;
	move.l	a3,a1
	add.l	$24(a1),d0
	move.l	d0,-$4B8(a5)
L316
;	if (texture = (W3D_GetState(rast->context, W3D_TEXMAPPING) == W3D_
	move.l	a3,a1
	move.l	_Warp3DBase,a6
	move.l	#$100,d1
	move.l	(a1),a0
	jsr	-$2A(a6)
	cmp.l	#1,d0
	seq	d0
	and.l	#1,d0
	move.w	d0,d3
	beq.b	L318
L317
;		lines.tex	= rast->texture->tex;
	move.l	a3,a1
	move.l	$8(a1),a0
	move.l	$8(a0),-$490(a5)
;		ofst = ofs*rast->texPtrStride;
	move.l	a3,a0
	move.l	$48(a0),d0
	mulu.l	d2,d0
;		w = rast->texPtrW+ofst;
	move.l	a3,a1
	move.l	d0,d1
	add.l	$28(a1),d1
	move.l	d1,-$4C4(a5)
;		u = rast->texPtrUS+ofst;
	move.l	a3,a1
	add.l	$2C(a1),d0
	move.l	d0,-$4BC(a5)
;		v = rast->texPtrVT+ofst;
L318
;	lines.vertexcount = OLD_STRIP_SEGS+1;
	move.l	#$11,-$498(a5)
;	rsint32 cnt2 = --cnt;
	move.l	d7,d5
	subq.l	#1,d5
	move.l	d5,d7
	move.l	d7,d5
;	rfloat32 f = 1F/256F;
	fmove.s	#$.3B800000,fp2
;	while (cnt2>OLD_STRIP_SEGS)
	bra	L332
L319
;		register W3D_Vertex* v = tempVert;
	lea	-$480(a5),a0
;		rsint32 i = OLD_STRIP_SEGS+2;
	moveq	#$12,d1
;		while(--i)
	bra	L325
L320
;			ofst = rast->vrtPtrStride;
	move.l	a3,a1
	move.l	$40(a1),d0
;			v->x = *((float32*)x);
	move.l	-$4A0(a5),a1
	move.l	(a1),(a0)
; x += ofst;
	move.l	d0,d2
	add.l	-$4A0(a5),d2
	move.l	d2,-$4A0(a5)
;			v->y = *((float32*)y);
	move.l	-$4A4(a5),a1
	move.l	(a1),4(a0)
; y += ofst;
	move.l	d0,d2
	add.l	-$4A4(a5),d2
	move.l	d2,-$4A4(a5)
;			v->z = *((float32*)z);
	move.l	-$4A8(a5),a1
	fmove.s	(a1),fp0
	fmove.d	fp0,$8(a0)
; z += ofst;
	add.l	-$4A8(a5),d0
	move.l	d0,-$4A8(a5)
;			if (texture)
	tst.w	d3
	beq.b	L322
L321
;				ofst = rast->texPtrStride;
	move.l	a3,a1
	move.l	$48(a1),d0
;				v->w = *((float32*)w);
	move.l	-$4C4(a5),a1
	move.l	(a1),$10(a0)
; w += ofst;
	move.l	d0,d2
	add.l	-$4C4(a5),d2
	move.l	d2,-$4C4(a5)
;				v->u = *((float32*)u);
	move.l	-$4BC(a5),a1
	move.l	(a1),$14(a0)
; u += ofst;
	move.l	d0,d2
	add.l	-$4BC(a5),d2
	move.l	d2,-$4BC(a5)
;				v->v = *((float32*)v);
	fmove.s	(a0),fp0
	fmove.s	fp0,$18(a0)
; v += ofst;
	moveq	#6,d2
	asl.l	d2,d0
	add.l	d0,a0
L322
;			if (shade)
	tst.w	d4
	beq	L324
L323
;				ofst = rast->clrPtrStride;
	move.l	a3,a1
	move.l	$44(a1),d0
;				v->color.r = f*(*r);
	move.l	-$4B0(a5),a1
	moveq	#0,d2
	move.b	(a1),d2
	fmove.l	d2,fp0
	fmul.x	fp2,fp0
	fmove.s	fp0,$20(a0)
; r += ofst;
	move.l	d0,d2
	add.l	-$4B0(a5),d2
	move.l	d2,-$4B0(a5)
;				v->color.g = f*(*g);
	move.l	-$4B4(a5),a1
	moveq	#0,d2
	move.b	(a1),d2
	fmove.l	d2,fp0
	fmul.x	fp2,fp0
	fmove.s	fp0,$24(a0)
; g += ofst;
	move.l	d0,d2
	add.l	-$4B4(a5),d2
	move.l	d2,-$4B4(a5)
;				v->color.b = f*(*b);
	move.l	-$4B8(a5),a1
	moveq	#0,d2
	move.b	(a1),d2
	fmove.l	d2,fp0
	fmul.x	fp2,fp0
	fmove.s	fp0,$28(a0)
; b += ofst;
	move.l	d0,d2
	add.l	-$4B8(a5),d2
	move.l	d2,-$4B8(a5)
;				v->color.a = f*(*a);
	move.l	-$4AC(a5),a1
	moveq	#0,d2
	move.b	(a1),d2
	fmove.l	d2,fp0
	fmul.x	fp2,fp0
	fmove.s	fp0,$2C(a0)
; a += ofst;
	add.l	-$4AC(a5),d0
	move.l	d0,-$4AC(a5)
L324
;			v++;
	add.w	#$40,a0
L325
	subq.l	#1,d1
	tst.l	d1
	bne	L320
L326
;		if (W3D_DrawLineStrip(rast->context, &lines)!=W3D_SUCCESS)
	move.l	a3,a2
	move.l	_Warp3DBase,a6
	move.l	(a2),a0
	lea	-$498(a5),a1
	jsr	-$186(a6)
	tst.l	d0
	beq.b	L328
L327
;			return false;
	moveq	#0,d0
	fmovem.x (a7)+,fp2
	movem.l	(a7)+,d2-d7/a2/a3/a6
	unlk	a5
	rts
L328
;		cnt2-=OLD_STRIP_SEGS;
	sub.l	#$10,d5
;		ofst = rast->vrtPtrStride;
	move.l	a3,a0
	move.l	$40(a0),d0
; x -= ofst;
	move.l	d0,d1
	neg.l	d1
	add.l	-$4A0(a5),d1
	move.l	d1,-$4A0(a5)
; y -= ofst;
	move.l	d0,d1
	neg.l	d1
	add.l	-$4A4(a5),d1
	move.l	d1,-$4A4(a5)
; z -= ofst;
	neg.l	d0
	add.l	-$4A8(a5),d0
	move.l	d0,-$4A8(a5)
;		if (texture)
	tst.w	d3
	beq.b	L330
L329
;			ofst = rast->texPtrStride;
	move.l	a3,a0
	move.l	$48(a0),d0
; w -= ofst;
	move.l	d0,d1
	neg.l	d1
	add.l	-$4C4(a5),d1
	move.l	d1,-$4C4(a5)
; u -= ofst;
	neg.l	d0
	add.l	-$4BC(a5),d0
	move.l	d0,-$4BC(a5)
; v -= ofst;
L330
;		if (shade)
	tst.w	d4
	beq.b	L332
L331
;			ofst = rast->clrPtrStride;
	move.l	a3,a0
	move.l	$44(a0),d0
; r -= ofst;
	move.l	d0,d1
	neg.l	d1
	add.l	-$4B0(a5),d1
	move.l	d1,-$4B0(a5)
; g -= ofst;
	move.l	d0,d1
	neg.l	d1
	add.l	-$4B4(a5),d1
	move.l	d1,-$4B4(a5)
; b -= ofst;
	move.l	d0,d1
	neg.l	d1
	add.l	-$4B8(a5),d1
	move.l	d1,-$4B8(a5)
; a -= ofst;
	neg.l	d0
	add.l	-$4AC(a5),d0
	move.l	d0,-$4AC(a5)
L332
	cmp.l	#$10,d5
	bgt	L319
L333
;	if (cnt2>0)
	cmp.l	#0,d5
	ble	L349
L334
;		if (cnt2<cnt) // end of existing series of line segments
	cmp.l	d7,d5
	bge	L340
L335
;			ofst = rast->vrtPtrStride;
	move.l	a3,a0
	move.l	$40(a0),d0
; x -= ofst;
	move.l	d0,d1
	neg.l	d1
	add.l	-$4A0(a5),d1
	move.l	d1,-$4A0(a5)
; y -= ofst;
	move.l	d0,d1
	neg.l	d1
	add.l	-$4A4(a5),d1
	move.l	d1,-$4A4(a5)
; z -= ofst;
	neg.l	d0
	add.l	-$4A8(a5),d0
	move.l	d0,-$4A8(a5)
;			if (texture)
	tst.w	d3
	beq.b	L337
L336
;				ofst = rast->texPtrStride;
	move.l	a3,a0
	move.l	$48(a0),d0
; w -= ofst;
	move.l	d0,d1
	neg.l	d1
	add.l	-$4C4(a5),d1
	move.l	d1,-$4C4(a5)
; u -= ofst;
	neg.l	d0
	add.l	-$4BC(a5),d0
	move.l	d0,-$4BC(a5)
; v -= ofst;
L337
;			if (shade)
	tst.w	d4
	beq.b	L339
L338
;				ofst = rast->clrPtrStride;
	move.l	a3,a0
	move.l	$44(a0),d0
; r -= ofst;
	move.l	d0,d1
	neg.l	d1
	add.l	-$4B0(a5),d1
	move.l	d1,-$4B0(a5)
; g -= ofst;
	move.l	d0,d1
	neg.l	d1
	add.l	-$4B4(a5),d1
	move.l	d1,-$4B4(a5)
; b -= ofst;
	move.l	d0,d1
	neg.l	d1
	add.l	-$4B8(a5),d1
	move.l	d1,-$4B8(a5)
; a -= ofst;
	neg.l	d0
	add.l	-$4AC(a5),d0
	move.l	d0,-$4AC(a5)
L339
;			cnt2++;
	addq.l	#1,d5
L340
;		register W3D_Vertex* v = tempVert;
	lea	-$480(a5),a0
;		lines.vertexcount = ++cnt2;
	move.l	d5,d0
	addq.l	#1,d0
	move.l	d0,d5
	move.l	d5,-$498(a5)
;		rsint32 i = ++cnt2;
	move.l	d5,d1
	addq.l	#1,d1
;		while(--i)
	bra	L346
L341
;			ofst = rast->vrtPtrStride;
	move.l	a3,a1
	move.l	$40(a1),d0
;			v->x = *((float32*)x);
	move.l	-$4A0(a5),a1
	move.l	(a1),(a0)
; x += ofst;
	move.l	d0,d2
	add.l	-$4A0(a5),d2
	move.l	d2,-$4A0(a5)
;			v->y = *((float32*)y);
	move.l	-$4A4(a5),a1
	move.l	(a1),4(a0)
; y += ofst;
	move.l	d0,d2
	add.l	-$4A4(a5),d2
	move.l	d2,-$4A4(a5)
;			v->z = *((float32*)z);
	move.l	-$4A8(a5),a1
	fmove.s	(a1),fp0
	fmove.d	fp0,$8(a0)
; z += ofst;
	add.l	-$4A8(a5),d0
	move.l	d0,-$4A8(a5)
;			if (texture)
	tst.w	d3
	beq.b	L343
L342
;				ofst = rast->texPtrStride;
	move.l	a3,a1
	move.l	$48(a1),d0
;				v->w = *((float32*)w);
	move.l	-$4C4(a5),a1
	move.l	(a1),$10(a0)
; w += ofst;
	move.l	d0,d2
	add.l	-$4C4(a5),d2
	move.l	d2,-$4C4(a5)
;				v->u = *((float32*)u);
	move.l	-$4BC(a5),a1
	move.l	(a1),$14(a0)
; u += ofst;
	move.l	d0,d2
	add.l	-$4BC(a5),d2
	move.l	d2,-$4BC(a5)
;				v->v = *((float32*)v);
	fmove.s	(a0),fp0
	fmove.s	fp0,$18(a0)
; v += ofst;
	moveq	#6,d2
	asl.l	d2,d0
	add.l	d0,a0
L343
;			if (shade)
	tst.w	d4
	beq	L345
L344
;				ofst = rast->clrPtrStride;
	move.l	a3,a1
	move.l	$44(a1),d0
;				v->color.r = f*(*r);
	move.l	-$4B0(a5),a1
	moveq	#0,d2
	move.b	(a1),d2
	fmove.l	d2,fp0
	fmul.x	fp2,fp0
	fmove.s	fp0,$20(a0)
; r += ofst;
	move.l	d0,d2
	add.l	-$4B0(a5),d2
	move.l	d2,-$4B0(a5)
;				v->color.g = f*(*g);
	move.l	-$4B4(a5),a1
	moveq	#0,d2
	move.b	(a1),d2
	fmove.l	d2,fp0
	fmul.x	fp2,fp0
	fmove.s	fp0,$24(a0)
; g += ofst;
	move.l	d0,d2
	add.l	-$4B4(a5),d2
	move.l	d2,-$4B4(a5)
;				v->color.b = f*(*b);
	move.l	-$4B8(a5),a1
	moveq	#0,d2
	move.b	(a1),d2
	fmove.l	d2,fp0
	fmul.x	fp2,fp0
	fmove.s	fp0,$28(a0)
; b += ofst;
	move.l	d0,d2
	add.l	-$4B8(a5),d2
	move.l	d2,-$4B8(a5)
;				v->color.a = f*(*a);
	move.l	-$4AC(a5),a1
	moveq	#0,d2
	move.b	(a1),d2
	fmove.l	d2,fp0
	fmul.x	fp2,fp0
	fmove.s	fp0,$2C(a0)
; a += ofst;
	add.l	-$4AC(a5),d0
	move.l	d0,-$4AC(a5)
L345
;			v++;
	add.w	#$40,a0
L346
	subq.l	#1,d1
	tst.l	d1
	bne	L341
L347
;		if (W3D_DrawLineStrip(rast->context, &lines)!=W3D_SUCCESS)
	move.l	a3,a2
	move.l	_Warp3DBase,a6
	move.l	(a2),a0
	lea	-$498(a5),a1
	jsr	-$186(a6)
	tst.l	d0
	beq.b	L349
L348
;			return false;
	moveq	#0,d0
	fmovem.x (a7)+,fp2
	movem.l	(a7)+,d2-d7/a2/a3/a6
	unlk	a5
	rts
L349
;	return true;
	moveq	#1,d0
	fmovem.x (a7)+,fp2
	movem.l	(a7)+,d2-d7/a2/a3/a6
	unlk	a5
	rts

	SECTION "drawLineStripXYZ_F32_CLR_F32__Rasterizer__P10RasterizerUiUi:0",CODE


;bool Rasterizer::drawLineStripXYZ_F32_CLR_F32(Rasterizer* rast, size
	XDEF	drawLineStripXYZ_F32_CLR_F32__Rasterizer__P10RasterizerUiUi
drawLineStripXYZ_F32_CLR_F32__Rasterizer__P10RasterizerUiUi
L387	EQU	-$4F8
	link	a5,#L387
	movem.l	d2-d7/a2/a3/a6,-(a7)
	movem.l	$C(a5),d4/d5
	move.l	$8(a5),a3
L351
;	W3D_Lines lines = {0, tempVert, 0};
	lea	-$498(a5),a0
	clr.l	(a0)+
	lea	-$480(a5),a1
	move.l	a1,(a0)+
	clr.l	(a0)+
	clr.l	(a0)+
	clr.l	(a0)+
	clr.l	(a0)+
;	rsint32 ofst = ofs*rast->vrtPtrStride;
	move.l	a3,a0
	move.l	$40(a0),d0
	mulu.l	d4,d0
;	uint8 *x = rast->vrtPtrX+ofst;
	move.l	a3,a1
	move.l	d0,d1
	add.l	$C(a1),d1
	move.l	d1,-$4A0(a5)
;	uint8 *y = rast->vrtPtrY+ofst;
	move.l	a3,a1
	move.l	d0,d1
	add.l	$10(a1),d1
	move.l	d1,-$4A4(a5)
;	uint8 *z = rast->vrtPtrZ+ofst;
	move.l	a3,a1
	add.l	$14(a1),d0
	move.l	d0,-$4A8(a5)
;	if (shade = (W3D_GetState(rast->context, W3D_GOURAUD) == W3D_ENABL
	move.l	a3,a1
	move.l	_Warp3DBase,a6
	move.l	#$400,d1
	move.l	(a1),a0
	jsr	-$2A(a6)
	cmp.l	#1,d0
	seq	d0
	and.l	#1,d0
	move.w	d0,d3
	beq.b	L353
L352
;		ofst = ofs*rast->clrPtrStride;
	move.l	a3,a0
	move.l	$44(a0),d0
	mulu.l	d4,d0
;		a = rast->clrPtrA+ofst;
	move.l	a3,a1
	move.l	d0,d1
	add.l	$18(a1),d1
	move.l	d1,-$4AC(a5)
;		r = rast->clrPtrR+ofst;
	move.l	a3,a1
	move.l	d0,d1
	add.l	$1C(a1),d1
	move.l	d1,-$4B0(a5)
;		g = rast->clrPtrG+ofst;
	move.l	a3,a1
	move.l	d0,d1
	add.l	$20(a1),d1
	move.l	d1,-$4B4(a5)
;		b = rast->clrPtrB+ofst;
	move.l	a3,a1
	add.l	$24(a1),d0
	move.l	d0,-$4B8(a5)
L353
;	if (texture = (W3D_GetState(rast->context, W3D_TEXMAPPING) == W3D_
	move.l	a3,a1
	move.l	_Warp3DBase,a6
	move.l	#$100,d1
	move.l	(a1),a0
	jsr	-$2A(a6)
	cmp.l	#1,d0
	seq	d0
	and.l	#1,d0
	move.w	d0,d2
	beq.b	L355
L354
;		lines.tex	= rast->texture->tex;
	move.l	a3,a1
	move.l	$8(a1),a0
	move.l	$8(a0),-$490(a5)
;		ofst = ofs*rast->texPtrStride;
	move.l	a3,a0
	move.l	$48(a0),d0
	mulu.l	d4,d0
;		w = rast->texPtrW+ofst;
	move.l	a3,a1
	move.l	d0,d1
	add.l	$28(a1),d1
	move.l	d1,-$4C4(a5)
;		u = rast->texPtrUS+ofst;
	move.l	a3,a1
	add.l	$2C(a1),d0
	move.l	d0,-$4BC(a5)
;		v = rast->texPtrVT+ofst;
L355
;	lines.vertexcount = OLD_STRIP_SEGS+1;
	move.l	#$11,-$498(a5)
;	rsint32 cnt2 = --cnt;
	move.l	d5,d4
	subq.l	#1,d4
	move.l	d4,d5
	move.l	d5,d4
;	while (cnt2>OLD_STRIP_SEGS)
	bra	L369
L356
;		register W3D_Vertex* v = tempVert;
	lea	-$480(a5),a0
;		rsint32 i = OLD_STRIP_SEGS+2;
	moveq	#$12,d1
;		while(--i)
	bra	L362
L357
;			ofst = rast->vrtPtrStride;
	move.l	a3,a1
	move.l	$40(a1),d0
;			v->x = *((float32*)x);
	move.l	-$4A0(a5),a1
	move.l	(a1),(a0)
; x += ofst;
	move.l	d0,d6
	add.l	-$4A0(a5),d6
	move.l	d6,-$4A0(a5)
;			v->y = *((float32*)y);
	move.l	-$4A4(a5),a1
	move.l	(a1),4(a0)
; y += ofst;
	move.l	d0,d6
	add.l	-$4A4(a5),d6
	move.l	d6,-$4A4(a5)
;			v->z = *((float32*)z);
	move.l	-$4A8(a5),a1
	fmove.s	(a1),fp0
	fmove.d	fp0,$8(a0)
; z += ofst;
	add.l	-$4A8(a5),d0
	move.l	d0,-$4A8(a5)
;			if (texture)
	tst.w	d2
	beq.b	L359
L358
;				ofst = rast->texPtrStride;
	move.l	a3,a1
	move.l	$48(a1),d0
;				v->w = *((float32*)w);
	move.l	-$4C4(a5),a1
	move.l	(a1),$10(a0)
; w += ofst;
	move.l	d0,d6
	add.l	-$4C4(a5),d6
	move.l	d6,-$4C4(a5)
;				v->u = *((float32*)u);
	move.l	-$4BC(a5),a1
	move.l	(a1),$14(a0)
; u += ofst;
	move.l	d0,d6
	add.l	-$4BC(a5),d6
	move.l	d6,-$4BC(a5)
;				v->v = *((float32*)v);
	fmove.s	(a0),fp0
	fmove.s	fp0,$18(a0)
; v += ofst;
	moveq	#6,d6
	asl.l	d6,d0
	add.l	d0,a0
L359
;			if (shade)
	tst.w	d3
	beq.b	L361
L360
;				ofst = rast->clrPtrStride;
	move.l	a3,a1
	move.l	$44(a1),d0
;				v->color.r = *((float32*)r);
	move.l	-$4B0(a5),a1
	move.l	(a1),$20(a0)
; r += ofst;
	move.l	d0,d6
	add.l	-$4B0(a5),d6
	move.l	d6,-$4B0(a5)
;				v->color.g = *((float32*)g);
	move.l	-$4B4(a5),a1
	move.l	(a1),$24(a0)
; g += ofst;
	move.l	d0,d6
	add.l	-$4B4(a5),d6
	move.l	d6,-$4B4(a5)
;				v->color.b = *((float32*)b);
	move.l	-$4B8(a5),a1
	move.l	(a1),$28(a0)
; b += ofst;
	move.l	d0,d6
	add.l	-$4B8(a5),d6
	move.l	d6,-$4B8(a5)
;				v->color.a = *((float32*)a);
	move.l	-$4AC(a5),a1
	move.l	(a1),$2C(a0)
; a += ofst;
	add.l	-$4AC(a5),d0
	move.l	d0,-$4AC(a5)
L361
;			v++;
	add.w	#$40,a0
L362
	subq.l	#1,d1
	tst.l	d1
	bne	L357
L363
;		if (W3D_DrawLineStrip(rast->context, &lines)!=W3D_SUCCESS)
	move.l	a3,a2
	move.l	_Warp3DBase,a6
	move.l	(a2),a0
	lea	-$498(a5),a1
	jsr	-$186(a6)
	tst.l	d0
	beq.b	L365
L364
;			return false;
	moveq	#0,d0
	movem.l	(a7)+,d2-d7/a2/a3/a6
	unlk	a5
	rts
L365
;		cnt2-=OLD_STRIP_SEGS;
	sub.l	#$10,d4
;		ofst = rast->vrtPtrStride;
	move.l	a3,a0
	move.l	$40(a0),d0
; x -= ofst;
	move.l	d0,d1
	neg.l	d1
	add.l	-$4A0(a5),d1
	move.l	d1,-$4A0(a5)
; y -= ofst;
	move.l	d0,d1
	neg.l	d1
	add.l	-$4A4(a5),d1
	move.l	d1,-$4A4(a5)
; z -= ofst;
	neg.l	d0
	add.l	-$4A8(a5),d0
	move.l	d0,-$4A8(a5)
;		if (texture)
	tst.w	d2
	beq.b	L367
L366
;			ofst = rast->texPtrStride;
	move.l	a3,a0
	move.l	$48(a0),d0
; w -= ofst;
	move.l	d0,d1
	neg.l	d1
	add.l	-$4C4(a5),d1
	move.l	d1,-$4C4(a5)
; u -= ofst;
	neg.l	d0
	add.l	-$4BC(a5),d0
	move.l	d0,-$4BC(a5)
; v -= ofst;
L367
;		if (shade)
	tst.w	d3
	beq.b	L369
L368
;			ofst = rast->clrPtrStride;
	move.l	a3,a0
	move.l	$44(a0),d0
; r -= ofst;
	move.l	d0,d1
	neg.l	d1
	add.l	-$4B0(a5),d1
	move.l	d1,-$4B0(a5)
; g -= ofst;
	move.l	d0,d1
	neg.l	d1
	add.l	-$4B4(a5),d1
	move.l	d1,-$4B4(a5)
; b -= ofst;
	move.l	d0,d1
	neg.l	d1
	add.l	-$4B8(a5),d1
	move.l	d1,-$4B8(a5)
; a -= ofst;
	neg.l	d0
	add.l	-$4AC(a5),d0
	move.l	d0,-$4AC(a5)
L369
	cmp.l	#$10,d4
	bgt	L356
L370
;	if (cnt2>0)
	cmp.l	#0,d4
	ble	L386
L371
;		if (cnt2<cnt) // end of existing series of line segments
	cmp.l	d5,d4
	bge	L377
L372
;			ofst = rast->vrtPtrStride;
	move.l	a3,a0
	move.l	$40(a0),d0
; x -= ofst;
	move.l	d0,d1
	neg.l	d1
	add.l	-$4A0(a5),d1
	move.l	d1,-$4A0(a5)
; y -= ofst;
	move.l	d0,d1
	neg.l	d1
	add.l	-$4A4(a5),d1
	move.l	d1,-$4A4(a5)
; z -= ofst;
	neg.l	d0
	add.l	-$4A8(a5),d0
	move.l	d0,-$4A8(a5)
;			if (texture)
	tst.w	d2
	beq.b	L374
L373
;				ofst = rast->texPtrStride;
	move.l	a3,a0
	move.l	$48(a0),d0
; w -= ofst;
	move.l	d0,d1
	neg.l	d1
	add.l	-$4C4(a5),d1
	move.l	d1,-$4C4(a5)
; u -= ofst;
	neg.l	d0
	add.l	-$4BC(a5),d0
	move.l	d0,-$4BC(a5)
; v -= ofst;
L374
;			if (shade)
	tst.w	d3
	beq.b	L376
L375
;				ofst = rast->clrPtrStride;
	move.l	a3,a0
	move.l	$44(a0),d0
; r -= ofst;
	move.l	d0,d1
	neg.l	d1
	add.l	-$4B0(a5),d1
	move.l	d1,-$4B0(a5)
; g -= ofst;
	move.l	d0,d1
	neg.l	d1
	add.l	-$4B4(a5),d1
	move.l	d1,-$4B4(a5)
; b -= ofst;
	move.l	d0,d1
	neg.l	d1
	add.l	-$4B8(a5),d1
	move.l	d1,-$4B8(a5)
; a -= ofst;
	neg.l	d0
	add.l	-$4AC(a5),d0
	move.l	d0,-$4AC(a5)
L376
;			cnt2++;
	addq.l	#1,d4
L377
;		register W3D_Vertex* v = tempVert;
	lea	-$480(a5),a0
;		lines.vertexcount = ++cnt2;
	move.l	d4,d0
	addq.l	#1,d0
	move.l	d0,d4
	move.l	d4,-$498(a5)
;		rsint32 i = ++cnt2;
	move.l	d4,d1
	addq.l	#1,d1
;		while(--i)
	bra	L383
L378
;			ofst = rast->vrtPtrStride;
	move.l	a3,a1
	move.l	$40(a1),d0
;			v->x = *((float32*)x);
	move.l	-$4A0(a5),a1
	move.l	(a1),(a0)
; x += ofst;
	move.l	d0,d4
	add.l	-$4A0(a5),d4
	move.l	d4,-$4A0(a5)
;			v->y = *((float32*)y);
	move.l	-$4A4(a5),a1
	move.l	(a1),4(a0)
; y += ofst;
	move.l	d0,d4
	add.l	-$4A4(a5),d4
	move.l	d4,-$4A4(a5)
;			v->z = *((float32*)z);
	move.l	-$4A8(a5),a1
	fmove.s	(a1),fp0
	fmove.d	fp0,$8(a0)
; z += ofst;
	add.l	-$4A8(a5),d0
	move.l	d0,-$4A8(a5)
;			if (texture)
	tst.w	d2
	beq.b	L380
L379
;				ofst = rast->texPtrStride;
	move.l	a3,a1
	move.l	$48(a1),d0
;				v->w = *((float32*)w);
	move.l	-$4C4(a5),a1
	move.l	(a1),$10(a0)
; w += ofst;
	move.l	d0,d4
	add.l	-$4C4(a5),d4
	move.l	d4,-$4C4(a5)
;				v->u = *((float32*)u);
	move.l	-$4BC(a5),a1
	move.l	(a1),$14(a0)
; u += ofst;
	move.l	d0,d4
	add.l	-$4BC(a5),d4
	move.l	d4,-$4BC(a5)
;				v->v = *((float32*)v);
	fmove.s	(a0),fp0
	fmove.s	fp0,$18(a0)
; v += ofst;
	moveq	#6,d4
	asl.l	d4,d0
	add.l	d0,a0
L380
;			if (shade)
	tst.w	d3
	beq.b	L382
L381
;				ofst = rast->clrPtrStride;
	move.l	a3,a1
	move.l	$44(a1),d0
;				v->color.r = *((float32*)r);
	move.l	-$4B0(a5),a1
	move.l	(a1),$20(a0)
; r += ofst;
	move.l	d0,d4
	add.l	-$4B0(a5),d4
	move.l	d4,-$4B0(a5)
;				v->color.g = *((float32*)g);
	move.l	-$4B4(a5),a1
	move.l	(a1),$24(a0)
; g += ofst;
	move.l	d0,d4
	add.l	-$4B4(a5),d4
	move.l	d4,-$4B4(a5)
;				v->color.b = *((float32*)b);
	move.l	-$4B8(a5),a1
	move.l	(a1),$28(a0)
; b += ofst;
	move.l	d0,d4
	add.l	-$4B8(a5),d4
	move.l	d4,-$4B8(a5)
;				v->color.a = *((float32*)a);
	move.l	-$4AC(a5),a1
	move.l	(a1),$2C(a0)
; a += ofst;
	add.l	-$4AC(a5),d0
	move.l	d0,-$4AC(a5)
L382
;			v++;
	add.w	#$40,a0
L383
	subq.l	#1,d1
	tst.l	d1
	bne	L378
L384
;		lines.vertexcount = ++cnt2;
	move.l	a3,a2
	move.l	_Warp3DBase,a6
	move.l	(a2),a0
	lea	-$498(a5),a1
	jsr	-$186(a6)
	tst.l	d0
	beq.b	L386
L385
;			return false;
	moveq	#0,d0
	movem.l	(a7)+,d2-d7/a2/a3/a6
	unlk	a5
	rts
L386
;	return true;
	moveq	#1,d0
	movem.l	(a7)+,d2-d7/a2/a3/a6
	unlk	a5
	rts

	SECTION "drawLineStripXYZ_F64_CLR_U8__Rasterizer__P10RasterizerUiUi:0",CODE


;bool Rasterizer::drawLineStripXYZ_F64_CLR_U8(Rasterizer* rast, size_
	XDEF	drawLineStripXYZ_F64_CLR_U8__Rasterizer__P10RasterizerUiUi
drawLineStripXYZ_F64_CLR_U8__Rasterizer__P10RasterizerUiUi
L424	EQU	-$4F8
	link	a5,#L424
	movem.l	d2-d7/a2/a3/a6,-(a7)
	fmovem.x fp2,-(a7)
	movem.l	$C(a5),d2/d7
	move.l	$8(a5),a3
L388
;	W3D_Lines lines = {0, tempVert, 0};
	lea	-$498(a5),a0
	clr.l	(a0)+
	lea	-$480(a5),a1
	move.l	a1,(a0)+
	clr.l	(a0)+
	clr.l	(a0)+
	clr.l	(a0)+
	clr.l	(a0)+
;	rsint32 ofst = ofs*rast->vrtPtrStride;
	move.l	a3,a0
	move.l	$40(a0),d0
	mulu.l	d2,d0
;	uint8 *x = rast->vrtPtrX+ofst;
	move.l	a3,a1
	move.l	d0,d1
	add.l	$C(a1),d1
	move.l	d1,-$4A0(a5)
;	uint8 *y = rast->vrtPtrY+ofst;
	move.l	a3,a1
	move.l	d0,d1
	add.l	$10(a1),d1
	move.l	d1,-$4A4(a5)
;	uint8 *z = rast->vrtPtrZ+ofst;
	move.l	a3,a1
	add.l	$14(a1),d0
	move.l	d0,-$4A8(a5)
;	if (shade = (W3D_GetState(rast->context, W3D_GOURAUD) == W3D_ENABL
	move.l	a3,a1
	move.l	_Warp3DBase,a6
	move.l	#$400,d1
	move.l	(a1),a0
	jsr	-$2A(a6)
	cmp.l	#1,d0
	seq	d0
	and.l	#1,d0
	move.w	d0,d4
	beq.b	L390
L389
;		ofst = ofs*rast->clrPtrStride;
	move.l	a3,a0
	move.l	$44(a0),d0
	mulu.l	d2,d0
;		a = rast->clrPtrA+ofst;
	move.l	a3,a1
	move.l	d0,d1
	add.l	$18(a1),d1
	move.l	d1,-$4AC(a5)
;		r = rast->clrPtrR+ofst;
	move.l	a3,a1
	move.l	d0,d1
	add.l	$1C(a1),d1
	move.l	d1,-$4B0(a5)
;		g = rast->clrPtrG+ofst;
	move.l	a3,a1
	move.l	d0,d1
	add.l	$20(a1),d1
	move.l	d1,-$4B4(a5)
;		b = rast->clrPtrB+ofst;
	move.l	a3,a1
	add.l	$24(a1),d0
	move.l	d0,-$4B8(a5)
L390
;	if (texture = (W3D_GetState(rast->context, W3D_TEXMAPPING) == W3D_
	move.l	a3,a1
	move.l	_Warp3DBase,a6
	move.l	#$100,d1
	move.l	(a1),a0
	jsr	-$2A(a6)
	cmp.l	#1,d0
	seq	d0
	and.l	#1,d0
	move.w	d0,d3
	beq.b	L392
L391
;		lines.tex	= rast->texture->tex;
	move.l	a3,a1
	move.l	$8(a1),a0
	move.l	$8(a0),-$490(a5)
;		ofst = ofs*rast->texPtrStride;
	move.l	a3,a0
	move.l	$48(a0),d0
	mulu.l	d2,d0
;		w = rast->texPtrW+ofst;
	move.l	a3,a1
	move.l	d0,d1
	add.l	$28(a1),d1
	move.l	d1,-$4C4(a5)
;		u = rast->texPtrUS+ofst;
	move.l	a3,a1
	add.l	$2C(a1),d0
	move.l	d0,-$4BC(a5)
;		v = rast->texPtrVT+ofst;
L392
;	lines.vertexcount = OLD_STRIP_SEGS+1;
	move.l	#$11,-$498(a5)
;	rsint32 cnt2 = --cnt;
	move.l	d7,d5
	subq.l	#1,d5
	move.l	d5,d7
	move.l	d7,d5
;	rfloat32 f = 1F/256F;
	fmove.s	#$.3B800000,fp2
;	while (cnt2>OLD_STRIP_SEGS)
	bra	L406
L393
;		register W3D_Vertex* v = tempVert;
	lea	-$480(a5),a0
;		rsint32 i = OLD_STRIP_SEGS+2;
	moveq	#$12,d1
;		while(--i)
	bra	L399
L394
;			ofst = rast->vrtPtrStride;
	move.l	a3,a1
	move.l	$40(a1),d0
;			v->x = *((float64*)x);
	move.l	-$4A0(a5),a1
	fmove.d	(a1),fp0
	fmove.s	fp0,(a0)
; x += ofst;
	move.l	d0,d2
	add.l	-$4A0(a5),d2
	move.l	d2,-$4A0(a5)
;			v->y = *((float64*)y);
	move.l	-$4A4(a5),a1
	fmove.d	(a1),fp0
	fmove.s	fp0,4(a0)
; y += ofst;
	move.l	d0,d2
	add.l	-$4A4(a5),d2
	move.l	d2,-$4A4(a5)
;			v->z = *((float64*)z);
	move.l	-$4A8(a5),a1
	move.l	(a1),$8(a0)
	move.l	4(a1),$C(a0)
; z += ofst;
	add.l	-$4A8(a5),d0
	move.l	d0,-$4A8(a5)
;			if (texture)
	tst.w	d3
	beq.b	L396
L395
;				ofst = rast->texPtrStride;
	move.l	a3,a1
	move.l	$48(a1),d0
;				v->w = *((float32*)w);
	move.l	-$4C4(a5),a1
	move.l	(a1),$10(a0)
; w += ofst;
	move.l	d0,d2
	add.l	-$4C4(a5),d2
	move.l	d2,-$4C4(a5)
;				v->u = *((float32*)u);
	move.l	-$4BC(a5),a1
	move.l	(a1),$14(a0)
; u += ofst;
	move.l	d0,d2
	add.l	-$4BC(a5),d2
	move.l	d2,-$4BC(a5)
;				v->v = *((float32*)v);
	fmove.s	(a0),fp0
	fmove.s	fp0,$18(a0)
; v += ofst;
	moveq	#6,d2
	asl.l	d2,d0
	add.l	d0,a0
L396
;			if (shade)
	tst.w	d4
	beq	L398
L397
;				ofst = rast->clrPtrStride;
	move.l	a3,a1
	move.l	$44(a1),d0
;				v->color.r = f*(*r);
	move.l	-$4B0(a5),a1
	moveq	#0,d2
	move.b	(a1),d2
	fmove.l	d2,fp0
	fmul.x	fp2,fp0
	fmove.s	fp0,$20(a0)
; r += ofst;
	move.l	d0,d2
	add.l	-$4B0(a5),d2
	move.l	d2,-$4B0(a5)
;				v->color.g = f*(*g);
	move.l	-$4B4(a5),a1
	moveq	#0,d2
	move.b	(a1),d2
	fmove.l	d2,fp0
	fmul.x	fp2,fp0
	fmove.s	fp0,$24(a0)
; g += ofst;
	move.l	d0,d2
	add.l	-$4B4(a5),d2
	move.l	d2,-$4B4(a5)
;				v->color.b = f*(*b);
	move.l	-$4B8(a5),a1
	moveq	#0,d2
	move.b	(a1),d2
	fmove.l	d2,fp0
	fmul.x	fp2,fp0
	fmove.s	fp0,$28(a0)
; b += ofst;
	move.l	d0,d2
	add.l	-$4B8(a5),d2
	move.l	d2,-$4B8(a5)
;				v->color.a = f*(*a);
	move.l	-$4AC(a5),a1
	moveq	#0,d2
	move.b	(a1),d2
	fmove.l	d2,fp0
	fmul.x	fp2,fp0
	fmove.s	fp0,$2C(a0)
; a += ofst;
	add.l	-$4AC(a5),d0
	move.l	d0,-$4AC(a5)
L398
;			v++;
	add.w	#$40,a0
L399
	subq.l	#1,d1
	tst.l	d1
	bne	L394
L400
;		if (W3D_DrawLineStrip(rast->context, &lines)!=W3D_SUCCESS)
	move.l	a3,a2
	move.l	_Warp3DBase,a6
	move.l	(a2),a0
	lea	-$498(a5),a1
	jsr	-$186(a6)
	tst.l	d0
	beq.b	L402
L401
;			return false;
	moveq	#0,d0
	fmovem.x (a7)+,fp2
	movem.l	(a7)+,d2-d7/a2/a3/a6
	unlk	a5
	rts
L402
;		cnt2-=OLD_STRIP_SEGS;
	sub.l	#$10,d5
;		ofst = rast->vrtPtrStride;
	move.l	a3,a0
	move.l	$40(a0),d0
; x -= ofst;
	move.l	d0,d1
	neg.l	d1
	add.l	-$4A0(a5),d1
	move.l	d1,-$4A0(a5)
; y -= ofst;
	move.l	d0,d1
	neg.l	d1
	add.l	-$4A4(a5),d1
	move.l	d1,-$4A4(a5)
; z -= ofst;
	neg.l	d0
	add.l	-$4A8(a5),d0
	move.l	d0,-$4A8(a5)
;		if (texture)
	tst.w	d3
	beq.b	L404
L403
;			ofst = rast->texPtrStride;
	move.l	a3,a0
	move.l	$48(a0),d0
; w -= ofst;
	move.l	d0,d1
	neg.l	d1
	add.l	-$4C4(a5),d1
	move.l	d1,-$4C4(a5)
; u -= ofst;
	neg.l	d0
	add.l	-$4BC(a5),d0
	move.l	d0,-$4BC(a5)
; v -= ofst;
L404
;		if (shade)
	tst.w	d4
	beq.b	L406
L405
;			ofst = rast->clrPtrStride;
	move.l	a3,a0
	move.l	$44(a0),d0
; r -= ofst;
	move.l	d0,d1
	neg.l	d1
	add.l	-$4B0(a5),d1
	move.l	d1,-$4B0(a5)
; g -= ofst;
	move.l	d0,d1
	neg.l	d1
	add.l	-$4B4(a5),d1
	move.l	d1,-$4B4(a5)
; b -= ofst;
	move.l	d0,d1
	neg.l	d1
	add.l	-$4B8(a5),d1
	move.l	d1,-$4B8(a5)
; a -= ofst;
	neg.l	d0
	add.l	-$4AC(a5),d0
	move.l	d0,-$4AC(a5)
L406
	cmp.l	#$10,d5
	bgt	L393
L407
;	if (cnt2>0)
	cmp.l	#0,d5
	ble	L423
L408
;		if (cnt2<cnt) // end of existing series of line segments
	cmp.l	d7,d5
	bge	L414
L409
;			ofst = rast->vrtPtrStride;
	move.l	a3,a0
	move.l	$40(a0),d0
; x -= ofst;
	move.l	d0,d1
	neg.l	d1
	add.l	-$4A0(a5),d1
	move.l	d1,-$4A0(a5)
; y -= ofst;
	move.l	d0,d1
	neg.l	d1
	add.l	-$4A4(a5),d1
	move.l	d1,-$4A4(a5)
; z -= ofst;
	neg.l	d0
	add.l	-$4A8(a5),d0
	move.l	d0,-$4A8(a5)
;			if (texture)
	tst.w	d3
	beq.b	L411
L410
;				ofst = rast->texPtrStride;
	move.l	a3,a0
	move.l	$48(a0),d0
; w -= ofst;
	move.l	d0,d1
	neg.l	d1
	add.l	-$4C4(a5),d1
	move.l	d1,-$4C4(a5)
; u -= ofst;
	neg.l	d0
	add.l	-$4BC(a5),d0
	move.l	d0,-$4BC(a5)
; v -= ofst;
L411
;			if (shade)
	tst.w	d4
	beq.b	L413
L412
;				ofst = rast->clrPtrStride;
	move.l	a3,a0
	move.l	$44(a0),d0
; r -= ofst;
	move.l	d0,d1
	neg.l	d1
	add.l	-$4B0(a5),d1
	move.l	d1,-$4B0(a5)
; g -= ofst;
	move.l	d0,d1
	neg.l	d1
	add.l	-$4B4(a5),d1
	move.l	d1,-$4B4(a5)
; b -= ofst;
	move.l	d0,d1
	neg.l	d1
	add.l	-$4B8(a5),d1
	move.l	d1,-$4B8(a5)
; a -= ofst;
	neg.l	d0
	add.l	-$4AC(a5),d0
	move.l	d0,-$4AC(a5)
L413
;			cnt2++;
	addq.l	#1,d5
L414
;		register W3D_Vertex* v = tempVert;
	lea	-$480(a5),a0
;		lines.vertexcount = ++cnt2;
	move.l	d5,d0
	addq.l	#1,d0
	move.l	d0,d5
	move.l	d5,-$498(a5)
;		rsint32 i = ++cnt2;
	move.l	d5,d1
	addq.l	#1,d1
;		while(--i)
	bra	L420
L415
;			ofst = rast->vrtPtrStride;
	move.l	a3,a1
	move.l	$40(a1),d0
;			v->x = *((float64*)x);
	move.l	-$4A0(a5),a1
	fmove.d	(a1),fp0
	fmove.s	fp0,(a0)
; x += ofst;
	move.l	d0,d2
	add.l	-$4A0(a5),d2
	move.l	d2,-$4A0(a5)
;			v->y = *((float64*)y);
	move.l	-$4A4(a5),a1
	fmove.d	(a1),fp0
	fmove.s	fp0,4(a0)
; y += ofst;
	move.l	d0,d2
	add.l	-$4A4(a5),d2
	move.l	d2,-$4A4(a5)
;			v->z = *((float64*)z);
	move.l	-$4A8(a5),a1
	move.l	(a1),$8(a0)
	move.l	4(a1),$C(a0)
; z += ofst;
	add.l	-$4A8(a5),d0
	move.l	d0,-$4A8(a5)
;			if (texture)
	tst.w	d3
	beq.b	L417
L416
;				ofst = rast->texPtrStride;
	move.l	a3,a1
	move.l	$48(a1),d0
;				v->w = *((float32*)w);
	move.l	-$4C4(a5),a1
	move.l	(a1),$10(a0)
; w += ofst;
	move.l	d0,d2
	add.l	-$4C4(a5),d2
	move.l	d2,-$4C4(a5)
;				v->u = *((float32*)u);
	move.l	-$4BC(a5),a1
	move.l	(a1),$14(a0)
; u += ofst;
	move.l	d0,d2
	add.l	-$4BC(a5),d2
	move.l	d2,-$4BC(a5)
;				v->v = *((float32*)v);
	fmove.s	(a0),fp0
	fmove.s	fp0,$18(a0)
; v += ofst;
	moveq	#6,d2
	asl.l	d2,d0
	add.l	d0,a0
L417
;			if (shade)
	tst.w	d4
	beq	L419
L418
;				ofst = rast->clrPtrStride;
	move.l	a3,a1
	move.l	$44(a1),d0
;				v->color.r = f*(*r);
	move.l	-$4B0(a5),a1
	moveq	#0,d2
	move.b	(a1),d2
	fmove.l	d2,fp0
	fmul.x	fp2,fp0
	fmove.s	fp0,$20(a0)
; r += ofst;
	move.l	d0,d2
	add.l	-$4B0(a5),d2
	move.l	d2,-$4B0(a5)
;				v->color.g = f*(*g);
	move.l	-$4B4(a5),a1
	moveq	#0,d2
	move.b	(a1),d2
	fmove.l	d2,fp0
	fmul.x	fp2,fp0
	fmove.s	fp0,$24(a0)
; g += ofst;
	move.l	d0,d2
	add.l	-$4B4(a5),d2
	move.l	d2,-$4B4(a5)
;				v->color.b = f*(*b);
	move.l	-$4B8(a5),a1
	moveq	#0,d2
	move.b	(a1),d2
	fmove.l	d2,fp0
	fmul.x	fp2,fp0
	fmove.s	fp0,$28(a0)
; b += ofst;
	move.l	d0,d2
	add.l	-$4B8(a5),d2
	move.l	d2,-$4B8(a5)
;				v->color.a = f*(*a);
	move.l	-$4AC(a5),a1
	moveq	#0,d2
	move.b	(a1),d2
	fmove.l	d2,fp0
	fmul.x	fp2,fp0
	fmove.s	fp0,$2C(a0)
; a += ofst;
	add.l	-$4AC(a5),d0
	move.l	d0,-$4AC(a5)
L419
;			v++;
	add.w	#$40,a0
L420
	subq.l	#1,d1
	tst.l	d1
	bne	L415
L421
;		if (W3D_DrawLineStrip(rast->context, &lines)!=W3D_SUCCESS)
	move.l	a3,a2
	move.l	_Warp3DBase,a6
	move.l	(a2),a0
	lea	-$498(a5),a1
	jsr	-$186(a6)
	tst.l	d0
	beq.b	L423
L422
;			return false;
	moveq	#0,d0
	fmovem.x (a7)+,fp2
	movem.l	(a7)+,d2-d7/a2/a3/a6
	unlk	a5
	rts
L423
;	return true;
	moveq	#1,d0
	fmovem.x (a7)+,fp2
	movem.l	(a7)+,d2-d7/a2/a3/a6
	unlk	a5
	rts

	SECTION "drawLineStripXYZ_F64_CLR_F32__Rasterizer__P10RasterizerUiUi:0",CODE


;bool Rasterizer::drawLineStripXYZ_F64_CLR_F32(Rasterizer* rast, size
	XDEF	drawLineStripXYZ_F64_CLR_F32__Rasterizer__P10RasterizerUiUi
drawLineStripXYZ_F64_CLR_F32__Rasterizer__P10RasterizerUiUi
L461	EQU	-$4F8
	link	a5,#L461
	movem.l	d2-d7/a2/a3/a6,-(a7)
	movem.l	$C(a5),d4/d5
	move.l	$8(a5),a3
L425
;	W3D_Lines lines = {0, tempVert, 0};
	lea	-$498(a5),a0
	clr.l	(a0)+
	lea	-$480(a5),a1
	move.l	a1,(a0)+
	clr.l	(a0)+
	clr.l	(a0)+
	clr.l	(a0)+
	clr.l	(a0)+
;	rsint32 ofst = ofs*rast->vrtPtrStride;
	move.l	a3,a0
	move.l	$40(a0),d0
	mulu.l	d4,d0
;	uint8 *x = rast->vrtPtrX+ofst;
	move.l	a3,a1
	move.l	d0,d1
	add.l	$C(a1),d1
	move.l	d1,-$4A0(a5)
;	uint8 *y = rast->vrtPtrY+ofst;
	move.l	a3,a1
	move.l	d0,d1
	add.l	$10(a1),d1
	move.l	d1,-$4A4(a5)
;	uint8 *z = rast->vrtPtrZ+ofst;
	move.l	a3,a1
	add.l	$14(a1),d0
	move.l	d0,-$4A8(a5)
;	if (shade = (W3D_GetState(rast->context, W3D_GOURAUD) == W3D_ENABL
	move.l	a3,a1
	move.l	_Warp3DBase,a6
	move.l	#$400,d1
	move.l	(a1),a0
	jsr	-$2A(a6)
	cmp.l	#1,d0
	seq	d0
	and.l	#1,d0
	move.w	d0,d3
	beq.b	L427
L426
;		ofst = ofs*rast->clrPtrStride;
	move.l	a3,a0
	move.l	$44(a0),d0
	mulu.l	d4,d0
;		a = rast->clrPtrA+ofst;
	move.l	a3,a1
	move.l	d0,d1
	add.l	$18(a1),d1
	move.l	d1,-$4AC(a5)
;		r = rast->clrPtrR+ofst;
	move.l	a3,a1
	move.l	d0,d1
	add.l	$1C(a1),d1
	move.l	d1,-$4B0(a5)
;		g = rast->clrPtrG+ofst;
	move.l	a3,a1
	move.l	d0,d1
	add.l	$20(a1),d1
	move.l	d1,-$4B4(a5)
;		b = rast->clrPtrB+ofst;
	move.l	a3,a1
	add.l	$24(a1),d0
	move.l	d0,-$4B8(a5)
L427
;	if (texture = (W3D_GetState(rast->context, W3D_TEXMAPPING) == W3D_
	move.l	a3,a1
	move.l	_Warp3DBase,a6
	move.l	#$100,d1
	move.l	(a1),a0
	jsr	-$2A(a6)
	cmp.l	#1,d0
	seq	d0
	and.l	#1,d0
	move.w	d0,d2
	beq.b	L429
L428
;		lines.tex	= rast->texture->tex;
	move.l	a3,a1
	move.l	$8(a1),a0
	move.l	$8(a0),-$490(a5)
;		ofst = ofs*rast->texPtrStride;
	move.l	a3,a0
	move.l	$48(a0),d0
	mulu.l	d4,d0
;		w = rast->texPtrW+ofst;
	move.l	a3,a1
	move.l	d0,d1
	add.l	$28(a1),d1
	move.l	d1,-$4C4(a5)
;		u = rast->texPtrUS+ofst;
	move.l	a3,a1
	add.l	$2C(a1),d0
	move.l	d0,-$4BC(a5)
;		v = rast->texPtrVT+ofst;
L429
;	lines.vertexcount = OLD_STRIP_SEGS+1;
	move.l	#$11,-$498(a5)
;	rsint32 cnt2 = --cnt;
	move.l	d5,d4
	subq.l	#1,d4
	move.l	d4,d5
	move.l	d5,d4
;	while (cnt2>OLD_STRIP_SEGS)
	bra	L443
L430
;		register W3D_Vertex* v = tempVert;
	lea	-$480(a5),a0
;		rsint32 i = OLD_STRIP_SEGS+2;
	moveq	#$12,d1
;		while(--i)
	bra	L436
L431
;			ofst = rast->vrtPtrStride;
	move.l	a3,a1
	move.l	$40(a1),d0
;			v->x = *((float64*)x);
	move.l	-$4A0(a5),a1
	fmove.d	(a1),fp0
	fmove.s	fp0,(a0)
; x += ofst;
	move.l	d0,d6
	add.l	-$4A0(a5),d6
	move.l	d6,-$4A0(a5)
;			v->y = *((float64*)y);
	move.l	-$4A4(a5),a1
	fmove.d	(a1),fp0
	fmove.s	fp0,4(a0)
; y += ofst;
	move.l	d0,d6
	add.l	-$4A4(a5),d6
	move.l	d6,-$4A4(a5)
;			v->z = *((float64*)z);
	move.l	-$4A8(a5),a1
	move.l	(a1),$8(a0)
	move.l	4(a1),$C(a0)
; z += ofst;
	add.l	-$4A8(a5),d0
	move.l	d0,-$4A8(a5)
;			if (texture)
	tst.w	d2
	beq.b	L433
L432
;				ofst = rast->texPtrStride;
	move.l	a3,a1
	move.l	$48(a1),d0
;				v->w = *((float32*)w);
	move.l	-$4C4(a5),a1
	move.l	(a1),$10(a0)
; w += ofst;
	move.l	d0,d6
	add.l	-$4C4(a5),d6
	move.l	d6,-$4C4(a5)
;				v->u = *((float32*)u);
	move.l	-$4BC(a5),a1
	move.l	(a1),$14(a0)
; u += ofst;
	move.l	d0,d6
	add.l	-$4BC(a5),d6
	move.l	d6,-$4BC(a5)
;				v->v = *((float32*)v);
	fmove.s	(a0),fp0
	fmove.s	fp0,$18(a0)
; v += ofst;
	moveq	#6,d6
	asl.l	d6,d0
	add.l	d0,a0
L433
;			if (shade)
	tst.w	d3
	beq.b	L435
L434
;				ofst = rast->clrPtrStride;
	move.l	a3,a1
	move.l	$44(a1),d0
;				v->color.r = *((float32*)r);
	move.l	-$4B0(a5),a1
	move.l	(a1),$20(a0)
; r += ofst;
	move.l	d0,d6
	add.l	-$4B0(a5),d6
	move.l	d6,-$4B0(a5)
;				v->color.g = *((float32*)g);
	move.l	-$4B4(a5),a1
	move.l	(a1),$24(a0)
; g += ofst;
	move.l	d0,d6
	add.l	-$4B4(a5),d6
	move.l	d6,-$4B4(a5)
;				v->color.b = *((float32*)b);
	move.l	-$4B8(a5),a1
	move.l	(a1),$28(a0)
; b += ofst;
	move.l	d0,d6
	add.l	-$4B8(a5),d6
	move.l	d6,-$4B8(a5)
;				v->color.a = *((float32*)a);
	move.l	-$4AC(a5),a1
	move.l	(a1),$2C(a0)
; a += ofst;
	add.l	-$4AC(a5),d0
	move.l	d0,-$4AC(a5)
L435
;			v++;
	add.w	#$40,a0
L436
	subq.l	#1,d1
	tst.l	d1
	bne	L431
L437
;		if (W3D_DrawLineStrip(rast->context, &lines)!=W3D_SUCCESS)
	move.l	a3,a2
	move.l	_Warp3DBase,a6
	move.l	(a2),a0
	lea	-$498(a5),a1
	jsr	-$186(a6)
	tst.l	d0
	beq.b	L439
L438
;			return false;
	moveq	#0,d0
	movem.l	(a7)+,d2-d7/a2/a3/a6
	unlk	a5
	rts
L439
;		cnt2-=OLD_STRIP_SEGS;
	sub.l	#$10,d4
;		ofst = rast->vrtPtrStride;
	move.l	a3,a0
	move.l	$40(a0),d0
; x -= ofst;
	move.l	d0,d1
	neg.l	d1
	add.l	-$4A0(a5),d1
	move.l	d1,-$4A0(a5)
; y -= ofst;
	move.l	d0,d1
	neg.l	d1
	add.l	-$4A4(a5),d1
	move.l	d1,-$4A4(a5)
; z -= ofst;
	neg.l	d0
	add.l	-$4A8(a5),d0
	move.l	d0,-$4A8(a5)
;		if (texture)
	tst.w	d2
	beq.b	L441
L440
;			ofst = rast->texPtrStride;
	move.l	a3,a0
	move.l	$48(a0),d0
; w -= ofst;
	move.l	d0,d1
	neg.l	d1
	add.l	-$4C4(a5),d1
	move.l	d1,-$4C4(a5)
; u -= ofst;
	neg.l	d0
	add.l	-$4BC(a5),d0
	move.l	d0,-$4BC(a5)
; v -= ofst;
L441
;		if (shade)
	tst.w	d3
	beq.b	L443
L442
;			ofst = rast->clrPtrStride;
	move.l	a3,a0
	move.l	$44(a0),d0
; r -= ofst;
	move.l	d0,d1
	neg.l	d1
	add.l	-$4B0(a5),d1
	move.l	d1,-$4B0(a5)
; g -= ofst;
	move.l	d0,d1
	neg.l	d1
	add.l	-$4B4(a5),d1
	move.l	d1,-$4B4(a5)
; b -= ofst;
	move.l	d0,d1
	neg.l	d1
	add.l	-$4B8(a5),d1
	move.l	d1,-$4B8(a5)
; a -= ofst;
	neg.l	d0
	add.l	-$4AC(a5),d0
	move.l	d0,-$4AC(a5)
L443
	cmp.l	#$10,d4
	bgt	L430
L444
;	if (cnt2>0)
	cmp.l	#0,d4
	ble	L460
L445
;		if (cnt2<cnt) // end of existing series of line segments
	cmp.l	d5,d4
	bge	L451
L446
;			ofst = rast->vrtPtrStride;
	move.l	a3,a0
	move.l	$40(a0),d0
; x -= ofst;
	move.l	d0,d1
	neg.l	d1
	add.l	-$4A0(a5),d1
	move.l	d1,-$4A0(a5)
; y -= ofst;
	move.l	d0,d1
	neg.l	d1
	add.l	-$4A4(a5),d1
	move.l	d1,-$4A4(a5)
; z -= ofst;
	neg.l	d0
	add.l	-$4A8(a5),d0
	move.l	d0,-$4A8(a5)
;			if (texture)
	tst.w	d2
	beq.b	L448
L447
;				ofst = rast->texPtrStride;
	move.l	a3,a0
	move.l	$48(a0),d0
; w -= ofst;
	move.l	d0,d1
	neg.l	d1
	add.l	-$4C4(a5),d1
	move.l	d1,-$4C4(a5)
; u -= ofst;
	neg.l	d0
	add.l	-$4BC(a5),d0
	move.l	d0,-$4BC(a5)
; v -= ofst;
L448
;			if (shade)
	tst.w	d3
	beq.b	L450
L449
;				ofst = rast->clrPtrStride;
	move.l	a3,a0
	move.l	$44(a0),d0
; r -= ofst;
	move.l	d0,d1
	neg.l	d1
	add.l	-$4B0(a5),d1
	move.l	d1,-$4B0(a5)
; g -= ofst;
	move.l	d0,d1
	neg.l	d1
	add.l	-$4B4(a5),d1
	move.l	d1,-$4B4(a5)
; b -= ofst;
	move.l	d0,d1
	neg.l	d1
	add.l	-$4B8(a5),d1
	move.l	d1,-$4B8(a5)
; a -= ofst;
	neg.l	d0
	add.l	-$4AC(a5),d0
	move.l	d0,-$4AC(a5)
L450
;			cnt2++;
	addq.l	#1,d4
L451
;		register W3D_Vertex* v = tempVert;
	lea	-$480(a5),a0
;		lines.vertexcount = ++cnt2;
	move.l	d4,d0
	addq.l	#1,d0
	move.l	d0,d4
	move.l	d4,-$498(a5)
;		rsint32 i = ++cnt2;
	move.l	d4,d1
	addq.l	#1,d1
;		while(--i)
	bra	L457
L452
;			ofst = rast->vrtPtrStride;
	move.l	a3,a1
	move.l	$40(a1),d0
;			v->x = *((float64*)x);
	move.l	-$4A0(a5),a1
	fmove.d	(a1),fp0
	fmove.s	fp0,(a0)
; x += ofst;
	move.l	d0,d4
	add.l	-$4A0(a5),d4
	move.l	d4,-$4A0(a5)
;			v->y = *((float64*)y);
	move.l	-$4A4(a5),a1
	fmove.d	(a1),fp0
	fmove.s	fp0,4(a0)
; y += ofst;
	move.l	d0,d4
	add.l	-$4A4(a5),d4
	move.l	d4,-$4A4(a5)
;			v->z = *((float64*)z);
	move.l	-$4A8(a5),a1
	move.l	(a1),$8(a0)
	move.l	4(a1),$C(a0)
; z += ofst;
	add.l	-$4A8(a5),d0
	move.l	d0,-$4A8(a5)
;			if (texture)
	tst.w	d2
	beq.b	L454
L453
;				ofst = rast->texPtrStride;
	move.l	a3,a1
	move.l	$48(a1),d0
;				v->w = *((float32*)w);
	move.l	-$4C4(a5),a1
	move.l	(a1),$10(a0)
; w += ofst;
	move.l	d0,d4
	add.l	-$4C4(a5),d4
	move.l	d4,-$4C4(a5)
;				v->u = *((float32*)u);
	move.l	-$4BC(a5),a1
	move.l	(a1),$14(a0)
; u += ofst;
	move.l	d0,d4
	add.l	-$4BC(a5),d4
	move.l	d4,-$4BC(a5)
;				v->v = *((float32*)v);
	fmove.s	(a0),fp0
	fmove.s	fp0,$18(a0)
; v += ofst;
	moveq	#6,d4
	asl.l	d4,d0
	add.l	d0,a0
L454
;			if (shade)
	tst.w	d3
	beq.b	L456
L455
;				ofst = rast->clrPtrStride;
	move.l	a3,a1
	move.l	$44(a1),d0
;				v->color.r = *((float32*)r);
	move.l	-$4B0(a5),a1
	move.l	(a1),$20(a0)
; r += ofst;
	move.l	d0,d4
	add.l	-$4B0(a5),d4
	move.l	d4,-$4B0(a5)
;				v->color.g = *((float32*)g);
	move.l	-$4B4(a5),a1
	move.l	(a1),$24(a0)
; g += ofst;
	move.l	d0,d4
	add.l	-$4B4(a5),d4
	move.l	d4,-$4B4(a5)
;				v->color.b = *((float32*)b);
	move.l	-$4B8(a5),a1
	move.l	(a1),$28(a0)
; b += ofst;
	move.l	d0,d4
	add.l	-$4B8(a5),d4
	move.l	d4,-$4B8(a5)
;				v->color.a = *((float32*)a);
	move.l	-$4AC(a5),a1
	move.l	(a1),$2C(a0)
; a += ofst;
	add.l	-$4AC(a5),d0
	move.l	d0,-$4AC(a5)
L456
;			v++;
	add.w	#$40,a0
L457
	subq.l	#1,d1
	tst.l	d1
	bne	L452
L458
;		if (W3D_DrawLineStrip(rast->context, &lines)!=W3D_SUCCESS)
	move.l	a3,a2
	move.l	_Warp3DBase,a6
	move.l	(a2),a0
	lea	-$498(a5),a1
	jsr	-$186(a6)
	tst.l	d0
	beq.b	L460
L459
;			return false;
	moveq	#0,d0
	movem.l	(a7)+,d2-d7/a2/a3/a6
	unlk	a5
	rts
L460
;	return true;
	moveq	#1,d0
	movem.l	(a7)+,d2-d7/a2/a3/a6
	unlk	a5
	rts

	SECTION "_drawLineStripXYZ_F32__Rasterizer:1",DATA

	XDEF	_drawLineStripXYZ_F32__Rasterizer
_drawLineStripXYZ_F32__Rasterizer
	dc.l	drawLineStripXYZ_F32_CLR_U8__Rasterizer__P10RasterizerUiUi,drawLineStripXYZ_F32_CLR_U8__Rasterizer__P10RasterizerUiUi,drawLineStripXYZ_F32_CLR_F32__Rasterizer__P10RasterizerUiUi,drawLineStripXYZ_F32_CLR_F32__Rasterizer__P10RasterizerUiUi

	SECTION "_drawLineStripXYZ_F64__Rasterizer:1",DATA

	XDEF	_drawLineStripXYZ_F64__Rasterizer
_drawLineStripXYZ_F64__Rasterizer
	dc.l	drawLineStripXYZ_F64_CLR_U8__Rasterizer__P10RasterizerUiUi,drawLineStripXYZ_F64_CLR_U8__Rasterizer__P10RasterizerUiUi,drawLineStripXYZ_F64_CLR_F32__Rasterizer__P10RasterizerUiUi,drawLineStripXYZ_F64_CLR_F32__Rasterizer__P10RasterizerUiUi

	END
