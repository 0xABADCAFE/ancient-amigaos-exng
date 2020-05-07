
; Storm C Compiler
; Developer:eXtropia/eXtropiaNG/libsrc/plat/amigaos3_68k/gfxlib/rasterizerdraw.cpp
	mc68030
	mc68881
	XREF	_0dt__Texture__T
	XREF	_0dt__Rasterizer__T
	XREF	obtain__Rasterizer__P07Surface
	XREF	destroy__Mesh__T
	XREF	create__Mesh__TUsUs
	XREF	_0dt__DisplayScreenDB__T
	XREF	refresh__DisplayScreenDB__T
	XREF	close__DisplayScreenDB__T
	XREF	reopen__DisplayScreenDB__T
	XREF	open__DisplayScreenDB__TP17DisplayPropertiesPCc
	XREF	open__DisplayScreenDB__TssEPCc
	XREF	_0dt__DisplayScreen__T
	XREF	close__DisplayScreen__T
	XREF	reopen__DisplayScreen__T
	XREF	open__DisplayScreen__TP17DisplayPropertiesPCc
	XREF	open__DisplayScreen__TssEPCc
	XREF	_0dt__DisplayWindow__T
	XREF	refresh__DisplayWindow__T
	XREF	close__DisplayWindow__T
	XREF	open__DisplayWindow__TP17DisplayPropertiesPCc
	XREF	open__DisplayWindow__TssEPCc
	XREF	reopen__DisplayWindow__T
	XREF	setTitle__DisplayNative__TPCcs
	XREF	waitForRefresh__DisplayNative__T
	XREF	destroy__Surface__T
	XREF	blitCopy__Surface__P07SurfacessP07Surfacessss
	XREF	create__Surface__TssP06BitMap
	XREF	init__Surface__T
	XREF	getHardwareFormat__Native2D__E
	XREF	getDrawSurface__Display__T
	XREF	refresh__Display__T
	XREF	waitSync__Display__T
	XREF	close__Display__T
	XREF	reopen__Display__T
	XREF	setTitle__Display__TPCc
	XREF	open__Display__TP17DisplayPropertiesPCc
	XREF	open__Display__TssEPCc
	XREF	findIndex__DisplayPropertiesProvider__ssEs
	XREF	getMode__DisplayPropertiesProvider__Ui
	XREF	destroy__ImageBuffer__T
	XREF	create__ImageBuffer__TssEP07Palettess
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
	movem.l	d2-d7/a2/a3/a6,-(a7)
	move.l	$34(a7),d1
	move.l	$2C(a7),d2
	move.l	$30(a7),d6
	move.l	$28(a7),a3
L185
;	size_t	totTris	= 2*((dx-1)*(dy-1));
	move.l	d6,d0
	subq.l	#1,d0
	subq.l	#1,d1
	mulu.l	d1,d0
	moveq	#1,d1
	asl.l	d1,d0
	move.l	d0,d7
;	sint32	modx		= dx-1;
	move.l	d6,d5
	subq.l	#1,d5
;	ruint32	i0			= ofs;
	move.l	d2,d4
;	ruint32	i1			= ofs+dx;
	move.l	d2,d3
	add.l	d6,d3
;	while (totTris >= MESH_MAX_TRIS_PER_CALL)
	bra	L193
L186
;		ruint16*	idx	= meshIndexBuffer;
	move.l	a3,a1
	move.l	$A4(a1),a0
;		rsint32 	i		= (MESH_MAX_TRIS_PER_CALL>>1)+1;
	move.l	#$101,d0
;		while (--i)
	bra.b	L189
L187
;			idx[0]=i1++;
	move.l	d3,d1
	addq.l	#1,d3
	move.w	d1,(a0)
; idx[3]=idx[1]=i0++;
	move.l	d4,d1
	addq.l	#1,d4
	move.w	d1,2(a0)
	move.w	d1,6(a0)
; idx[4]=i0;
	move.w	d4,$8(a0)
; idx[5]=idx[2]=i1;
	move.w	d3,d1
	move.w	d1,4(a0)
	move.w	d1,$A(a0)
;			idx+=6;
	add.w	#$C,a0
;			if (--modx<=0)
	subq.l	#1,d5
	cmp.l	#0,d5
	bgt.b	L189
L188
;				modx = dx-1;
	move.l	d6,d5
	subq.l	#1,d5
;				i0++;
	addq.l	#1,d4
; i1++;
	addq.l	#1,d3
L189
	subq.l	#1,d0
	tst.l	d0
	bne.b	L187
L190
;		if (W3D_DrawElements(context,	W3D_PRIMITIVE_TRIANGLES,					\
	move.l	a3,a0
	move.l	$A4(a0),a1
	move.l	a3,a2
	move.l	_Warp3DBase,a6
	moveq	#0,d0
	moveq	#1,d1
	move.l	#$600,d2
	move.l	(a2),a0
	jsr	-$20A(a6)
	tst.l	d0
	beq.b	L192
L191
;			return false;
	moveq	#0,d0
	movem.l	(a7)+,d2-d7/a2/a3/a6
	rts
L192
;		totTris -= MESH_MAX_TRIS_PER_CALL;
	move.l	d7,d0
	sub.l	#$200,d0
	move.l	d0,d7
L193
	move.l	d7,d0
	cmp.l	#$200,d0
	bhs	L186
L194
;	if (totTris>0)
	tst.l	d7
	beq	L201
L195
;		ruint16*	idx	= meshIndexBuffer;
	move.l	a3,a1
	move.l	$A4(a1),a0
;		rsint32 	i		= (totTris>>1)+1;
	move.l	d7,d0
	moveq	#1,d1
	lsr.l	d1,d0
	addq.l	#1,d0
;		while (--i)
	bra.b	L198
L196
;			idx[0]=i1++;
	move.l	d3,d1
	addq.l	#1,d3
	move.w	d1,(a0)
; idx[3]=idx[1]=i0++;
	move.l	d4,d1
	addq.l	#1,d4
	move.w	d1,2(a0)
	move.w	d1,6(a0)
; idx[4]=i0;
	move.w	d4,$8(a0)
; idx[5]=idx[2]=i1;
	move.w	d3,d1
	move.w	d1,4(a0)
	move.w	d1,$A(a0)
;			idx+=6;
	add.w	#$C,a0
;			if (--modx<=0)
	subq.l	#1,d5
	cmp.l	#0,d5
	bgt.b	L198
L197
;				modx = dx-1;
	move.l	d6,d5
	subq.l	#1,d5
;				i0++;
	addq.l	#1,d4
; i1++;
	addq.l	#1,d3
L198
	subq.l	#1,d0
	tst.l	d0
	bne.b	L196
L199
;		if (W3D_DrawElements(context, W3D_PRIMITIVE_TRIANGLES,			\
	move.l	a3,a0
	move.l	$A4(a0),a1
	move.l	d7,d2
	mulu.l	#3,d2
	move.l	a3,a2
	move.l	_Warp3DBase,a6
	moveq	#0,d0
	moveq	#1,d1
	move.l	(a2),a0
	jsr	-$20A(a6)
	tst.l	d0
	beq.b	L201
L200
;			return false;
	moveq	#0,d0
	movem.l	(a7)+,d2-d7/a2/a3/a6
	rts
L201
;	return true;
	moveq	#1,d0
	movem.l	(a7)+,d2-d7/a2/a3/a6
	rts

	SECTION "drawTriMesh2__Rasterizer__TUiUiUi:0",CODE


;bool Rasterizer::drawTriMesh2(size_t ofs, size_t dx, size_t dy)
	XDEF	drawTriMesh2__Rasterizer__TUiUiUi
drawTriMesh2__Rasterizer__TUiUiUi
	movem.l	d2-d5/a2/a3/a6,-(a7)
	movem.l	$24(a7),d3-d5
	move.l	$20(a7),a3
L202
;	if ( dx<=((MESH_MAX_TRIS_PER_CALL+2)/2) )
	cmp.l	#$101,d4
	bhi.b	L211
L203
;		while (--dy)
	bra.b	L209
L204
;			ruint16 *idx = meshIndexBuffer;
	move.l	a3,a1
	move.l	$A4(a1),a0
;			rsint32 i = dx+1;
	move.l	d4,d0
	addq.l	#1,d0
;			while (--i)
	bra.b	L206
L205
;				*idx++ = ofs+dx;
	move.l	d3,d1
	add.l	d4,d1
	move.w	d1,(a0)+
; *idx++ = ofs++;
	move.l	d3,d1
	addq.l	#1,d3
	move.w	d1,(a0)+
L206
	subq.l	#1,d0
	tst.l	d0
	bne.b	L205
L207
;			if (W3D_DrawElements(context,	W3D_PRIMITIVE_TRISTRIP,				\
	move.l	a3,a0
	move.l	$A4(a0),a1
	move.l	d4,d2
	moveq	#1,d0
	asl.l	d0,d2
	move.l	a3,a2
	move.l	_Warp3DBase,a6
	moveq	#2,d0
	moveq	#1,d1
	move.l	(a2),a0
	jsr	-$20A(a6)
	tst.l	d0
	beq.b	L209
L208
;				return false;
	moveq	#0,d0
	movem.l	(a7)+,d2-d5/a2/a3/a6
	rts
L209
	subq.l	#1,d5
	tst.l	d5
	bne.b	L204
L210
;		return true;
	moveq	#1,d0
	movem.l	(a7)+,d2-d5/a2/a3/a6
	rts
L211
;	return false;
	moveq	#0,d0
	movem.l	(a7)+,d2-d5/a2/a3/a6
	rts

	SECTION "drawPoints__Rasterizer__TUiUi:0",CODE


;bool Rasterizer::drawPoints(size_t ofs, size_t cnt)
	XDEF	drawPoints__Rasterizer__TUiUi
drawPoints__Rasterizer__TUiUi
	move.l	d2,-(a7)
	move.l	$10(a7),d0
	move.l	$C(a7),d1
	move.l	$8(a7),a0
L212
;	if (!vrtPtrX || cnt < 1)
	tst.l	$C(a0)
	beq.b	L214
L213
	tst.l	d0
	bne.b	L215
L214
;		return false;
	moveq	#0,d0
	move.l	(a7)+,d2
	rts
L215
;	switch (vrtPtrType)
	move.l	$34(a0),d2
	cmp.l	#0,d2
	beq.b	L216
	cmp.l	#1,d2
	beq.b	L217
	bra.b	L218
;		
L216
;			return drawPointsXYZ_F32[clrPtrType](this, ofs, cnt);
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
L217
;			return drawPointsXYZ_F64[clrPtrType](this, ofs, cnt);
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
L218
;			return false;
	moveq	#0,d0
	move.l	(a7)+,d2
	rts

	SECTION "drawPointsXYZ_F32_CLR_U8__Rasterizer__P10RasterizerUiUi:0",CODE


;bool Rasterizer::drawPointsXYZ_F32_CLR_U8(Rasterizer* rast, size_t o
	XDEF	drawPointsXYZ_F32_CLR_U8__Rasterizer__P10RasterizerUiUi
drawPointsXYZ_F32_CLR_U8__Rasterizer__P10RasterizerUiUi
	move.l	a6,-(a7)
	move.l	$8(a7),a0
L219
;	if (W3D_GetState(rast->context, W3D_GOURAUD)==W3D_ENABLED)
	move.l	_Warp3DBase,a6
	move.l	#$400,d1
	move.l	(a0),a0
	jsr	-$2A(a6)
L220
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
L221
;	if (W3D_GetState(rast->context, W3D_GOURAUD)==W3D_ENABLED)
	move.l	_Warp3DBase,a6
	move.l	#$400,d1
	move.l	(a0),a0
	jsr	-$2A(a6)
L222
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
L223
;	if (W3D_GetState(rast->context, W3D_GOURAUD)==W3D_ENABLED)
	move.l	_Warp3DBase,a6
	move.l	#$400,d1
	move.l	(a0),a0
	jsr	-$2A(a6)
L224
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
L225
;	if (W3D_GetState(rast->context, W3D_GOURAUD)==W3D_ENABLED)
	move.l	_Warp3DBase,a6
	move.l	#$400,d1
	move.l	(a0),a0
	jsr	-$2A(a6)
L226
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
L229
;	if (!vrtPtrX || cnt < 2)
	tst.l	$C(a0)
	beq.b	L231
L230
	cmp.l	#2,d0
	bhs.b	L232
L231
;		return false;
	moveq	#0,d0
	move.l	(a7)+,d2
	rts
L232
;	switch (vrtPtrType)
	move.l	$34(a0),d2
	cmp.l	#0,d2
	beq.b	L233
	cmp.l	#1,d2
	beq.b	L234
	bra.b	L235
;		
L233
;			return drawLinesXYZ_F32[clrPtrType](this, ofs, cnt);
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
L234
;			return drawLinesXYZ_F64[clrPtrType](this, ofs, cnt);
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
L235
;			return false;
	moveq	#0,d0
	move.l	(a7)+,d2
	rts

	SECTION "drawLinesXYZ_F32_CLR_U8__Rasterizer__P10RasterizerUiUi:0",CODE


;bool Rasterizer::drawLinesXYZ_F32_CLR_U8(Rasterizer* rast, size_t of
	XDEF	drawLinesXYZ_F32_CLR_U8__Rasterizer__P10RasterizerUiUi
drawLinesXYZ_F32_CLR_U8__Rasterizer__P10RasterizerUiUi
L249	EQU	-$EC
	link	a5,#L249
	movem.l	d2-d5/a2/a3/a6,-(a7)
	fmovem.x fp2,-(a7)
	move.l	$10(a5),d2
	move.l	$C(a5),d5
	move.l	$8(a5),a3
L236
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
	beq.b	L238
L237
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
L238
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
	beq.b	L240
L239
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
L240
;	rfloat32 f = 1F/256F;
	fmove.s	#$.3B800000,fp2
;	rsint32 cnt2 = 1+(cnt>>1);
	moveq	#1,d0
	lsr.l	d0,d2
	addq.l	#1,d2
;	while (--cnt2)
	bra	L247
L241
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
	beq	L243
L242
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
L243
;		if (shade)
	tst.w	d4
	beq	L245
L244
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
L245
;		if (W3D_DrawLine(rast->context, &line)!=W3D_SUCCESS)
	move.l	a3,a2
	move.l	_Warp3DBase,a6
	move.l	(a2),a0
	lea	-$90(a5),a1
	jsr	-$96(a6)
	tst.l	d0
	beq.b	L247
L246
;			return false;
	moveq	#0,d0
	fmovem.x (a7)+,fp2
	movem.l	(a7)+,d2-d5/a2/a3/a6
	unlk	a5
	rts
L247
	subq.l	#1,d2
	tst.l	d2
	bne	L241
L248
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
L263	EQU	-$EC
	link	a5,#L263
	movem.l	d2-d5/a2/a3/a6,-(a7)
	move.l	$10(a5),d2
	move.l	$C(a5),d5
	move.l	$8(a5),a3
L250
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
	beq.b	L252
L251
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
L252
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
	beq.b	L254
L253
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
L254
;	rsint32 cnt2 = 1+(cnt>>1);
	moveq	#1,d0
	lsr.l	d0,d2
	addq.l	#1,d2
;	while (--cnt2)
	bra	L261
L255
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
	beq	L257
L256
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
L257
;		if (shade)
	tst.w	d4
	beq	L259
L258
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
L259
;		if (W3D_DrawLine(rast->context, &line)!=W3D_SUCCESS)
	move.l	a3,a2
	move.l	_Warp3DBase,a6
	move.l	(a2),a0
	lea	-$90(a5),a1
	jsr	-$96(a6)
	tst.l	d0
	beq.b	L261
L260
;			return false;
	moveq	#0,d0
	movem.l	(a7)+,d2-d5/a2/a3/a6
	unlk	a5
	rts
L261
	subq.l	#1,d2
	tst.l	d2
	bne	L255
L262
;	return true;
	moveq	#1,d0
	movem.l	(a7)+,d2-d5/a2/a3/a6
	unlk	a5
	rts

	SECTION "drawLinesXYZ_F64_CLR_U8__Rasterizer__P10RasterizerUiUi:0",CODE


;bool Rasterizer::drawLinesXYZ_F64_CLR_U8(Rasterizer* rast, size_t of
	XDEF	drawLinesXYZ_F64_CLR_U8__Rasterizer__P10RasterizerUiUi
drawLinesXYZ_F64_CLR_U8__Rasterizer__P10RasterizerUiUi
L277	EQU	-$EC
	link	a5,#L277
	movem.l	d2-d5/a2/a3/a6,-(a7)
	fmovem.x fp2,-(a7)
	move.l	$10(a5),d2
	move.l	$C(a5),d5
	move.l	$8(a5),a3
L264
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
	beq.b	L266
L265
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
L266
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
	beq.b	L268
L267
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
L268
;	rfloat32 f = 1F/256F;
	fmove.s	#$.3B800000,fp2
;	rsint32 cnt2 = 1+(cnt>>1);
	moveq	#1,d0
	lsr.l	d0,d2
	addq.l	#1,d2
;	while (--cnt2)
	bra	L275
L269
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
	beq	L271
L270
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
L271
;		if (shade)
	tst.w	d4
	beq	L273
L272
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
L273
;		if (W3D_DrawLine(rast->context, &line)!=W3D_SUCCESS)
	move.l	a3,a2
	move.l	_Warp3DBase,a6
	move.l	(a2),a0
	lea	-$90(a5),a1
	jsr	-$96(a6)
	tst.l	d0
	beq.b	L275
L274
;			return false;
	moveq	#0,d0
	fmovem.x (a7)+,fp2
	movem.l	(a7)+,d2-d5/a2/a3/a6
	unlk	a5
	rts
L275
	subq.l	#1,d2
	tst.l	d2
	bne	L269
L276
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
L291	EQU	-$EC
	link	a5,#L291
	movem.l	d2-d5/a2/a3/a6,-(a7)
	move.l	$10(a5),d2
	move.l	$C(a5),d5
	move.l	$8(a5),a3
L278
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
	beq.b	L280
L279
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
L280
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
	beq.b	L282
L281
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
L282
;	rsint32 cnt2 = 1+(cnt>>1);
	moveq	#1,d0
	lsr.l	d0,d2
	addq.l	#1,d2
;	while (--cnt2)
	bra	L289
L283
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
	beq	L285
L284
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
L285
;		if (shade)
	tst.w	d4
	beq	L287
L286
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
L287
;		if (W3D_DrawLine(rast->context, &line)!=W3D_SUCCESS)
	move.l	a3,a2
	move.l	_Warp3DBase,a6
	move.l	(a2),a0
	lea	-$90(a5),a1
	jsr	-$96(a6)
	tst.l	d0
	beq.b	L289
L288
;			return false;
	moveq	#0,d0
	movem.l	(a7)+,d2-d5/a2/a3/a6
	unlk	a5
	rts
L289
	subq.l	#1,d2
	tst.l	d2
	bne	L283
L290
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
L294
;	if (!vrtPtrX || cnt < 2)
	tst.l	$C(a0)
	beq.b	L296
L295
	cmp.l	#2,d0
	bhs.b	L297
L296
;		return false;
	moveq	#0,d0
	move.l	(a7)+,d2
	rts
L297
;	switch (vrtPtrType)
	move.l	$34(a0),d2
	cmp.l	#0,d2
	beq.b	L298
	cmp.l	#1,d2
	beq.b	L299
	bra.b	L300
;		
L298
;			return drawLineStripXYZ_F32[clrPtrType](this, ofs, cnt);
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
L299
;			return drawLineStripXYZ_F64[clrPtrType](this, ofs, cnt);
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
L300
;			return false;
	moveq	#0,d0
	move.l	(a7)+,d2
	rts

	SECTION "drawLineStripXYZ_F32_CLR_U8__Rasterizer__P10RasterizerUiUi:0",CODE


;bool Rasterizer::drawLineStripXYZ_F32_CLR_U8(Rasterizer* rast, size_
	XDEF	drawLineStripXYZ_F32_CLR_U8__Rasterizer__P10RasterizerUiUi
drawLineStripXYZ_F32_CLR_U8__Rasterizer__P10RasterizerUiUi
L337	EQU	-$4F8
	link	a5,#L337
	movem.l	d2-d7/a2/a3/a6,-(a7)
	fmovem.x fp2,-(a7)
	movem.l	$C(a5),d2/d7
	move.l	$8(a5),a3
L301
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
	beq.b	L303
L302
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
L303
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
	beq.b	L305
L304
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
L305
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
	bra	L319
L306
;		register W3D_Vertex* v = tempVert;
	lea	-$480(a5),a0
;		rsint32 i = OLD_STRIP_SEGS+2;
	moveq	#$12,d1
;		while(--i)
	bra	L312
L307
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
	beq.b	L309
L308
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
L309
;			if (shade)
	tst.w	d4
	beq	L311
L310
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
L311
;			v++;
	add.w	#$40,a0
L312
	subq.l	#1,d1
	tst.l	d1
	bne	L307
L313
;		if (W3D_DrawLineStrip(rast->context, &lines)!=W3D_SUCCESS)
	move.l	a3,a2
	move.l	_Warp3DBase,a6
	move.l	(a2),a0
	lea	-$498(a5),a1
	jsr	-$186(a6)
	tst.l	d0
	beq.b	L315
L314
;			return false;
	moveq	#0,d0
	fmovem.x (a7)+,fp2
	movem.l	(a7)+,d2-d7/a2/a3/a6
	unlk	a5
	rts
L315
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
	beq.b	L317
L316
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
L317
;		if (shade)
	tst.w	d4
	beq.b	L319
L318
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
L319
	cmp.l	#$10,d5
	bgt	L306
L320
;	if (cnt2>0)
	cmp.l	#0,d5
	ble	L336
L321
;		if (cnt2<cnt) // end of existing series of line segments
	cmp.l	d7,d5
	bge	L327
L322
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
	beq.b	L324
L323
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
L324
;			if (shade)
	tst.w	d4
	beq.b	L326
L325
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
L326
;			cnt2++;
	addq.l	#1,d5
L327
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
	bra	L333
L328
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
	beq.b	L330
L329
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
L330
;			if (shade)
	tst.w	d4
	beq	L332
L331
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
L332
;			v++;
	add.w	#$40,a0
L333
	subq.l	#1,d1
	tst.l	d1
	bne	L328
L334
;		if (W3D_DrawLineStrip(rast->context, &lines)!=W3D_SUCCESS)
	move.l	a3,a2
	move.l	_Warp3DBase,a6
	move.l	(a2),a0
	lea	-$498(a5),a1
	jsr	-$186(a6)
	tst.l	d0
	beq.b	L336
L335
;			return false;
	moveq	#0,d0
	fmovem.x (a7)+,fp2
	movem.l	(a7)+,d2-d7/a2/a3/a6
	unlk	a5
	rts
L336
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
L374	EQU	-$4F8
	link	a5,#L374
	movem.l	d2-d7/a2/a3/a6,-(a7)
	movem.l	$C(a5),d4/d5
	move.l	$8(a5),a3
L338
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
	beq.b	L340
L339
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
L340
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
	beq.b	L342
L341
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
L342
;	lines.vertexcount = OLD_STRIP_SEGS+1;
	move.l	#$11,-$498(a5)
;	rsint32 cnt2 = --cnt;
	move.l	d5,d4
	subq.l	#1,d4
	move.l	d4,d5
	move.l	d5,d4
;	while (cnt2>OLD_STRIP_SEGS)
	bra	L356
L343
;		register W3D_Vertex* v = tempVert;
	lea	-$480(a5),a0
;		rsint32 i = OLD_STRIP_SEGS+2;
	moveq	#$12,d1
;		while(--i)
	bra	L349
L344
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
	beq.b	L346
L345
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
L346
;			if (shade)
	tst.w	d3
	beq.b	L348
L347
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
L348
;			v++;
	add.w	#$40,a0
L349
	subq.l	#1,d1
	tst.l	d1
	bne	L344
L350
;		if (W3D_DrawLineStrip(rast->context, &lines)!=W3D_SUCCESS)
	move.l	a3,a2
	move.l	_Warp3DBase,a6
	move.l	(a2),a0
	lea	-$498(a5),a1
	jsr	-$186(a6)
	tst.l	d0
	beq.b	L352
L351
;			return false;
	moveq	#0,d0
	movem.l	(a7)+,d2-d7/a2/a3/a6
	unlk	a5
	rts
L352
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
	beq.b	L354
L353
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
L354
;		if (shade)
	tst.w	d3
	beq.b	L356
L355
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
L356
	cmp.l	#$10,d4
	bgt	L343
L357
;	if (cnt2>0)
	cmp.l	#0,d4
	ble	L373
L358
;		if (cnt2<cnt) // end of existing series of line segments
	cmp.l	d5,d4
	bge	L364
L359
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
	beq.b	L361
L360
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
L361
;			if (shade)
	tst.w	d3
	beq.b	L363
L362
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
L363
;			cnt2++;
	addq.l	#1,d4
L364
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
	bra	L370
L365
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
	beq.b	L367
L366
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
L367
;			if (shade)
	tst.w	d3
	beq.b	L369
L368
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
L369
;			v++;
	add.w	#$40,a0
L370
	subq.l	#1,d1
	tst.l	d1
	bne	L365
L371
;		if (W3D_DrawLineStrip(rast->context, &lines)!=W3D_SUCCESS)
	move.l	a3,a2
	move.l	_Warp3DBase,a6
	move.l	(a2),a0
	lea	-$498(a5),a1
	jsr	-$186(a6)
	tst.l	d0
	beq.b	L373
L372
;			return false;
	moveq	#0,d0
	movem.l	(a7)+,d2-d7/a2/a3/a6
	unlk	a5
	rts
L373
;	return true;
	moveq	#1,d0
	movem.l	(a7)+,d2-d7/a2/a3/a6
	unlk	a5
	rts

	SECTION "drawLineStripXYZ_F64_CLR_U8__Rasterizer__P10RasterizerUiUi:0",CODE


;bool Rasterizer::drawLineStripXYZ_F64_CLR_U8(Rasterizer* rast, size_
	XDEF	drawLineStripXYZ_F64_CLR_U8__Rasterizer__P10RasterizerUiUi
drawLineStripXYZ_F64_CLR_U8__Rasterizer__P10RasterizerUiUi
L411	EQU	-$4F8
	link	a5,#L411
	movem.l	d2-d7/a2/a3/a6,-(a7)
	fmovem.x fp2,-(a7)
	movem.l	$C(a5),d2/d7
	move.l	$8(a5),a3
L375
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
	beq.b	L377
L376
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
L377
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
	beq.b	L379
L378
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
L379
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
	bra	L393
L380
;		register W3D_Vertex* v = tempVert;
	lea	-$480(a5),a0
;		rsint32 i = OLD_STRIP_SEGS+2;
	moveq	#$12,d1
;		while(--i)
	bra	L386
L381
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
	beq.b	L383
L382
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
L383
;			if (shade)
	tst.w	d4
	beq	L385
L384
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
L385
;			v++;
	add.w	#$40,a0
L386
	subq.l	#1,d1
	tst.l	d1
	bne	L381
L387
;		if (W3D_DrawLineStrip(rast->context, &lines)!=W3D_SUCCESS)
	move.l	a3,a2
	move.l	_Warp3DBase,a6
	move.l	(a2),a0
	lea	-$498(a5),a1
	jsr	-$186(a6)
	tst.l	d0
	beq.b	L389
L388
;			return false;
	moveq	#0,d0
	fmovem.x (a7)+,fp2
	movem.l	(a7)+,d2-d7/a2/a3/a6
	unlk	a5
	rts
L389
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
	beq.b	L391
L390
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
L391
;		if (shade)
	tst.w	d4
	beq.b	L393
L392
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
L393
	cmp.l	#$10,d5
	bgt	L380
L394
;	if (cnt2>0)
	cmp.l	#0,d5
	ble	L410
L395
;		if (cnt2<cnt) // end of existing series of line segments
	cmp.l	d7,d5
	bge	L401
L396
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
	beq.b	L398
L397
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
L398
;			if (shade)
	tst.w	d4
	beq.b	L400
L399
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
L400
;			cnt2++;
	addq.l	#1,d5
L401
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
	bra	L407
L402
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
	beq.b	L404
L403
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
L404
;			if (shade)
	tst.w	d4
	beq	L406
L405
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
L406
;			v++;
	add.w	#$40,a0
L407
	subq.l	#1,d1
	tst.l	d1
	bne	L402
L408
;		if (W3D_DrawLineStrip(rast->context, &lines)!=W3D_SUCCESS)
	move.l	a3,a2
	move.l	_Warp3DBase,a6
	move.l	(a2),a0
	lea	-$498(a5),a1
	jsr	-$186(a6)
	tst.l	d0
	beq.b	L410
L409
;			return false;
	moveq	#0,d0
	fmovem.x (a7)+,fp2
	movem.l	(a7)+,d2-d7/a2/a3/a6
	unlk	a5
	rts
L410
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
L448	EQU	-$4F8
	link	a5,#L448
	movem.l	d2-d7/a2/a3/a6,-(a7)
	movem.l	$C(a5),d4/d5
	move.l	$8(a5),a3
L412
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
	beq.b	L414
L413
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
L414
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
	beq.b	L416
L415
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
L416
;	lines.vertexcount = OLD_STRIP_SEGS+1;
	move.l	#$11,-$498(a5)
;	rsint32 cnt2 = --cnt;
	move.l	d5,d4
	subq.l	#1,d4
	move.l	d4,d5
	move.l	d5,d4
;	while (cnt2>OLD_STRIP_SEGS)
	bra	L430
L417
;		register W3D_Vertex* v = tempVert;
	lea	-$480(a5),a0
;		rsint32 i = OLD_STRIP_SEGS+2;
	moveq	#$12,d1
;		while(--i)
	bra	L423
L418
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
	beq.b	L420
L419
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
L420
;			if (shade)
	tst.w	d3
	beq.b	L422
L421
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
L422
;			v++;
	add.w	#$40,a0
L423
	subq.l	#1,d1
	tst.l	d1
	bne	L418
L424
;		if (W3D_DrawLineStrip(rast->context, &lines)!=W3D_SUCCESS)
	move.l	a3,a2
	move.l	_Warp3DBase,a6
	move.l	(a2),a0
	lea	-$498(a5),a1
	jsr	-$186(a6)
	tst.l	d0
	beq.b	L426
L425
;			return false;
	moveq	#0,d0
	movem.l	(a7)+,d2-d7/a2/a3/a6
	unlk	a5
	rts
L426
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
	beq.b	L428
L427
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
L428
;		if (shade)
	tst.w	d3
	beq.b	L430
L429
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
L430
	cmp.l	#$10,d4
	bgt	L417
L431
;	if (cnt2>0)
	cmp.l	#0,d4
	ble	L447
L432
;		if (cnt2<cnt) // end of existing series of line segments
	cmp.l	d5,d4
	bge	L438
L433
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
	beq.b	L435
L434
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
L435
;			if (shade)
	tst.w	d3
	beq.b	L437
L436
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
L437
;			cnt2++;
	addq.l	#1,d4
L438
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
	bra	L444
L439
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
	beq.b	L441
L440
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
L441
;			if (shade)
	tst.w	d3
	beq.b	L443
L442
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
L443
;			v++;
	add.w	#$40,a0
L444
	subq.l	#1,d1
	tst.l	d1
	bne	L439
L445
;		if (W3D_DrawLineStrip(rast->context, &lines)!=W3D_SUCCESS)
	move.l	a3,a2
	move.l	_Warp3DBase,a6
	move.l	(a2),a0
	lea	-$498(a5),a1
	jsr	-$186(a6)
	tst.l	d0
	beq.b	L447
L446
;			return false;
	moveq	#0,d0
	movem.l	(a7)+,d2-d7/a2/a3/a6
	unlk	a5
	rts
L447
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
