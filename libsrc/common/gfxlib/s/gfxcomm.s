
; Storm C Compiler
; exng:libsrc/common/gfxlib/gfxcomm.cpp
	mc68030
	mc68881
	XREF	_strncpy
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
	XREF	runApplication__AppBase__T
	XREF	zero__Mem__r8Pvr0Ui
	XREF	copy__Mem__r8Pvr9Pvr0Ui
	XREF	free__Mem__Pv
	XREF	alloc__Mem__UisE
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

	SECTION "_propTab__PixelDescriptor:0",CODE


	XDEF	_INIT_8_gfxcomm_cpp__propTab__PixelDescriptor
_INIT_8_gfxcomm_cpp__propTab__PixelDescriptor
L99	EQU	-$3C
	link	a5,#L99
	movem.l	d2-d7,-(a7)
L98
;{
	lea	_propTab__PixelDescriptor,a0
	clr.b	-$2E(a5)
	clr.b	-$1F(a5)
	clr.b	-$10(a5)
	clr.b	-1(a5)
	move.b	#1,(a0)
	move.b	#1,1(a0)
	move.b	#1,2(a0)
	clr.b	3(a0)
	move.b	#$8,4(a0)
	move.b	#$8,5(a0)
	move.b	#$8,6(a0)
	move.b	#$8,7(a0)
	move.b	-1(a5),$8(a0)
	move.b	-$10(a5),$9(a0)
	move.b	-$1F(a5),$A(a0)
	move.b	-$2E(a5),$B(a0)
	add.w	#$C,a0
	clr.b	-$2F(a5)
	move.b	#5,-$20(a5)
	move.b	#$A,-$11(a5)
	clr.b	-2(a5)
	move.b	#2,(a0)
	move.b	#2,1(a0)
	clr.b	2(a0)
	clr.b	3(a0)
	clr.b	4(a0)
	move.b	#5,5(a0)
	move.b	#5,6(a0)
	move.b	#5,7(a0)
	move.b	-2(a5),$8(a0)
	move.b	-$11(a5),$9(a0)
	move.b	-$20(a5),$A(a0)
	move.b	-$2F(a5),$B(a0)
	add.w	#$C,a0
	move.b	#$A,-$30(a5)
	move.b	#5,-$21(a5)
	clr.b	-$12(a5)
	clr.b	-3(a5)
	move.b	#2,(a0)
	move.b	#2,1(a0)
	clr.b	2(a0)
	clr.b	3(a0)
	clr.b	4(a0)
	move.b	#5,5(a0)
	move.b	#5,6(a0)
	move.b	#5,7(a0)
	move.b	-3(a5),$8(a0)
	move.b	-$12(a5),$9(a0)
	move.b	-$21(a5),$A(a0)
	move.b	-$30(a5),$B(a0)
	add.w	#$C,a0
	clr.b	-$31(a5)
	move.b	#5,-$22(a5)
	move.b	#$A,-$13(a5)
	clr.b	-4(a5)
	move.b	#2,(a0)
	move.b	#2,1(a0)
	clr.b	2(a0)
	move.b	#1,3(a0)
	clr.b	4(a0)
	move.b	#5,5(a0)
	move.b	#5,6(a0)
	move.b	#5,7(a0)
	move.b	-4(a5),$8(a0)
	move.b	-$13(a5),$9(a0)
	move.b	-$22(a5),$A(a0)
	move.b	-$31(a5),$B(a0)
	add.w	#$C,a0
	move.b	#$A,-$32(a5)
	move.b	#5,-$23(a5)
	clr.b	-$14(a5)
	clr.b	-5(a5)
	move.b	#2,(a0)
	move.b	#2,1(a0)
	clr.b	2(a0)
	move.b	#1,3(a0)
	clr.b	4(a0)
	move.b	#5,5(a0)
	move.b	#5,6(a0)
	move.b	#5,7(a0)
	move.b	-5(a5),$8(a0)
	move.b	-$14(a5),$9(a0)
	move.b	-$23(a5),$A(a0)
	move.b	-$32(a5),$B(a0)
	add.w	#$C,a0
	clr.b	-$33(a5)
	move.b	#5,-$24(a5)
	move.b	#$B,-$15(a5)
	clr.b	-6(a5)
	move.b	#2,(a0)
	move.b	#2,1(a0)
	clr.b	2(a0)
	clr.b	3(a0)
	clr.b	4(a0)
	move.b	#5,5(a0)
	move.b	#6,6(a0)
	move.b	#5,7(a0)
	move.b	-6(a5),$8(a0)
	move.b	-$15(a5),$9(a0)
	move.b	-$24(a5),$A(a0)
	move.b	-$33(a5),$B(a0)
	add.w	#$C,a0
	move.b	#$B,-$34(a5)
	move.b	#5,-$25(a5)
	clr.b	-$16(a5)
	clr.b	-7(a5)
	move.b	#2,(a0)
	move.b	#2,1(a0)
	clr.b	2(a0)
	clr.b	3(a0)
	clr.b	4(a0)
	move.b	#5,5(a0)
	move.b	#6,6(a0)
	move.b	#5,7(a0)
	move.b	-7(a5),$8(a0)
	move.b	-$16(a5),$9(a0)
	move.b	-$25(a5),$A(a0)
	move.b	-$34(a5),$B(a0)
	add.w	#$C,a0
	clr.b	-$35(a5)
	move.b	#5,-$26(a5)
	move.b	#$B,-$17(a5)
	clr.b	-$8(a5)
	move.b	#2,(a0)
	move.b	#2,1(a0)
	clr.b	2(a0)
	move.b	#1,3(a0)
	clr.b	4(a0)
	move.b	#5,5(a0)
	move.b	#6,6(a0)
	move.b	#5,7(a0)
	move.b	-$8(a5),$8(a0)
	move.b	-$17(a5),$9(a0)
	move.b	-$26(a5),$A(a0)
	move.b	-$35(a5),$B(a0)
	add.w	#$C,a0
	move.b	#$B,-$36(a5)
	move.b	#5,-$27(a5)
	clr.b	-$18(a5)
	clr.b	-$9(a5)
	move.b	#2,(a0)
	move.b	#2,1(a0)
	clr.b	2(a0)
	move.b	#1,3(a0)
	clr.b	4(a0)
	move.b	#5,5(a0)
	move.b	#6,6(a0)
	move.b	#5,7(a0)
	move.b	-$9(a5),$8(a0)
	move.b	-$18(a5),$9(a0)
	move.b	-$27(a5),$A(a0)
	move.b	-$36(a5),$B(a0)
	add.w	#$C,a0
	move.b	#2,-$37(a5)
	move.b	#1,-$28(a5)
	clr.b	-$19(a5)
	clr.b	-$A(a5)
	move.b	#3,(a0)
	move.b	#3,1(a0)
	clr.b	2(a0)
	clr.b	3(a0)
	clr.b	4(a0)
	move.b	#$8,5(a0)
	move.b	#$8,6(a0)
	move.b	#$8,7(a0)
	move.b	-$A(a5),$8(a0)
	move.b	-$19(a5),$9(a0)
	move.b	-$28(a5),$A(a0)
	move.b	-$37(a5),$B(a0)
	add.w	#$C,a0
	clr.b	-$38(a5)
	move.b	#1,-$29(a5)
	move.b	#2,-$1A(a5)
	clr.b	-$B(a5)
	move.b	#3,(a0)
	move.b	#3,1(a0)
	clr.b	2(a0)
	clr.b	3(a0)
	clr.b	4(a0)
	move.b	#$8,5(a0)
	move.b	#$8,6(a0)
	move.b	#$8,7(a0)
	move.b	-$B(a5),$8(a0)
	move.b	-$1A(a5),$9(a0)
	move.b	-$29(a5),$A(a0)
	move.b	-$38(a5),$B(a0)
	add.w	#$C,a0
	clr.b	-$39(a5)
	move.b	#$8,-$2A(a5)
	move.b	#$10,-$1B(a5)
	move.b	#$18,-$C(a5)
	move.b	#4,(a0)
	move.b	#4,1(a0)
	clr.b	2(a0)
	clr.b	3(a0)
	move.b	#$8,4(a0)
	move.b	#$8,5(a0)
	move.b	#$8,6(a0)
	move.b	#$8,7(a0)
	move.b	-$C(a5),$8(a0)
	move.b	-$1B(a5),$9(a0)
	move.b	-$2A(a5),$A(a0)
	move.b	-$39(a5),$B(a0)
	add.w	#$C,a0
	move.b	#$10,-$3A(a5)
	move.b	#$8,-$2B(a5)
	clr.b	-$1C(a5)
	move.b	#$18,-$D(a5)
	move.b	#4,(a0)
	move.b	#4,1(a0)
	clr.b	2(a0)
	clr.b	3(a0)
	move.b	#$8,4(a0)
	move.b	#$8,5(a0)
	move.b	#$8,6(a0)
	move.b	#$8,7(a0)
	move.b	-$D(a5),$8(a0)
	move.b	-$1C(a5),$9(a0)
	move.b	-$2B(a5),$A(a0)
	move.b	-$3A(a5),$B(a0)
	add.w	#$C,a0
	clr.b	-$3B(a5)
	move.b	#$8,-$2C(a5)
	move.b	#$10,-$1D(a5)
	move.b	#$18,-$E(a5)
	move.b	#4,(a0)
	move.b	#4,1(a0)
	clr.b	2(a0)
	move.b	#1,3(a0)
	move.b	#$8,4(a0)
	move.b	#$8,5(a0)
	move.b	#$8,6(a0)
	move.b	#$8,7(a0)
	move.b	-$E(a5),$8(a0)
	move.b	-$1D(a5),$9(a0)
	move.b	-$2C(a5),$A(a0)
	move.b	-$3B(a5),$B(a0)
	add.w	#$C,a0
	move.b	#$10,-$3C(a5)
	move.b	#$8,-$2D(a5)
	clr.b	-$1E(a5)
	move.b	#$18,-$F(a5)
	move.b	#4,(a0)
	move.b	#4,1(a0)
	clr.b	2(a0)
	move.b	#1,3(a0)
	move.b	#$8,4(a0)
	move.b	#$8,5(a0)
	move.b	#$8,6(a0)
	move.b	#$8,7(a0)
	move.b	-$F(a5),$8(a0)
	move.b	-$1E(a5),$9(a0)
	move.b	-$2D(a5),$A(a0)
	move.b	-$3C(a5),$B(a0)
	movem.l	(a7)+,d2-d7
	unlk	a5
	rts

	SECTION "_propTab__PixelDescriptor:1",DATA

	XDEF	_propTab__PixelDescriptor
_propTab__PixelDescriptor
	ds.b	180

	SECTION "getPixelRep__Colour__TP15PixelDescriptor:0",CODE


;uint32 Colour::getPixelRep(PixelDescriptor *p)
	XDEF	getPixelRep__Colour__TP15PixelDescriptor
getPixelRep__Colour__TP15PixelDescriptor
	movem.l	d2/d3/a2,-(a7)
	fmovem.x fp2,-(a7)
	move.l	$20(a7),a0
	move.l	$1C(a7),a1
L100
;	ruint32 ret = 0;
	moveq	#0,d0
;	rfloat32 sf = (1.0/255.0);
	fmove.s	#$.3B808080,fp0
;	if (p->getBitsAlpha())
	moveq	#0,d1
	move.b	4(a0),d1
	tst.l	d1
	beq.b	L102
L101
;		ret = (uint32)(sf*((uint16)chan[ARGB_A]*(uint16)p->getMaxAlpha())
	moveq	#0,d1
	move.b	(a1),d1
	moveq	#0,d0
	move.b	4(a0),d0
	moveq	#1,d2
	asl.l	d0,d2
	move.l	d2,d0
	subq.l	#1,d0
	mulu	d1,d0
	fmove.l	d0,fp1
	fmul.x	fp0,fp1
	fmove.l	fp1,d0
	moveq	#0,d1
	move.b	$8(a0),d1
	asl.l	d1,d0
L102
;	ret |= (uint32)(sf*((uint16)chan[ARGB_R]*(uint16)p->getMaxRed()))<
	moveq	#0,d2
	move.b	1(a1),d2
	moveq	#0,d1
	move.b	5(a0),d1
	moveq	#1,d3
	asl.l	d1,d3
	move.l	d3,d1
	subq.l	#1,d1
	mulu	d2,d1
	fmove.l	d1,fp1
	fmul.x	fp0,fp1
	fmove.l	fp1,d1
	moveq	#0,d2
	move.b	$9(a0),d2
	asl.l	d2,d1
	or.l	d1,d0
;	ret |= (uint32)(sf*((uint16)chan[ARGB_G]*(uint16)p->getMaxGreen()))
	moveq	#0,d2
	move.b	2(a1),d2
	moveq	#0,d1
	move.b	6(a0),d1
	moveq	#1,d3
	asl.l	d1,d3
	move.l	d3,d1
	subq.l	#1,d1
	mulu	d2,d1
	fmove.l	d1,fp1
	fmul.x	fp0,fp1
	fmove.l	fp1,d1
	moveq	#0,d2
	move.b	$A(a0),d2
	asl.l	d2,d1
	or.l	d1,d0
;	ret |= (uint32)(sf*((uint16)chan[ARGB_B]*(uint16)p->getMaxBlue()))
	moveq	#0,d2
	move.b	3(a1),d2
	moveq	#0,d1
	move.b	7(a0),d1
	moveq	#1,d3
	asl.l	d1,d3
	move.l	d3,d1
	subq.l	#1,d1
	mulu	d2,d1
	fmove.l	d1,fp1
	fmul.x	fp1,fp0
	fmove.l	fp0,d1
	moveq	#0,d2
	move.b	$B(a0),d2
	asl.l	d2,d1
	or.l	d1,d0
;	if (p->isSwapped()) // handle byteswapping if required
	tst.b	3(a0)
	beq.b	L104
L103
	moveq	#1,d1
	bra.b	L105
L104
	moveq	#0,d1
L105
	tst.w	d1
	beq.b	L110
L106
;		if (p->getSize()==2)
	moveq	#0,d1
	move.b	(a0),d1
	cmp.l	#2,d1
	bne.b	L108
L107
;			return (ret>>8 | ret<<8) & 0x0000FFFF;
	move.l	d0,d1
	moveq	#$8,d2
	lsr.l	d2,d1
	moveq	#$8,d2
	asl.l	d2,d0
	or.l	d1,d0
	and.l	#$FFFF,d0
	fmovem.x (a7)+,fp2
	movem.l	(a7)+,d2/d3/a2
	rts
L108
;		if (p->getSize()==4)
	moveq	#0,d1
	move.b	(a0),d1
	cmp.l	#4,d1
	bne.b	L110
L109
;			return ret<<24 | ((ret<<16)&0x00FF0000) | ((ret>>16)&0x0000FF0
	move.l	d0,d1
	moveq	#$18,d2
	asl.l	d2,d1
	move.l	d0,d2
	moveq	#$10,d3
	asl.l	d3,d2
	and.l	#$FF0000,d2
	or.l	d2,d1
	move.l	d0,d2
	moveq	#$10,d3
	lsr.l	d3,d2
	and.l	#$FF00,d2
	or.l	d2,d1
	moveq	#$18,d2
	lsr.l	d2,d0
	or.l	d1,d0
	fmovem.x (a7)+,fp2
	movem.l	(a7)+,d2/d3/a2
	rts
L110
;	return ret;
	fmovem.x (a7)+,fp2
	movem.l	(a7)+,d2/d3/a2
	rts

	SECTION "setFromPixel__Colour__TP15PixelDescriptorUj:0",CODE


;void Colour::setFromPixel(PixelDescriptor *p, uint32 data)
	XDEF	setFromPixel__Colour__TP15PixelDescriptorUj
setFromPixel__Colour__TP15PixelDescriptorUj
	movem.l	d2/d3/a2,-(a7)
	move.l	$18(a7),d0
	move.l	$14(a7),a0
	move.l	$10(a7),a1
L111
;	if (p->isSwapped()) // handle byteswapping if required
	tst.b	3(a0)
	beq.b	L113
L112
	moveq	#1,d1
	bra.b	L114
L113
	moveq	#0,d1
L114
	tst.w	d1
	beq.b	L119
L115
;		if (p->getSize()==2)
	moveq	#0,d1
	move.b	(a0),d1
	cmp.l	#2,d1
	bne.b	L117
L116
;			data = (data<<8 | data>>8) & 0x0000FFFF;
	move.l	d0,d1
	moveq	#$8,d2
	asl.l	d2,d1
	moveq	#$8,d2
	lsr.l	d2,d0
	or.l	d1,d0
	and.l	#$FFFF,d0
	bra.b	L119
L117
;		else if (p->getSize()==4)
	moveq	#0,d1
	move.b	(a0),d1
	cmp.l	#4,d1
	bne.b	L119
L118
;			data = data<<24 | ((data<<16)&0x00FF0000) | ((data>>16)&0x0000
	move.l	d0,d1
	moveq	#$18,d2
	asl.l	d2,d1
	move.l	d0,d2
	moveq	#$10,d3
	asl.l	d3,d2
	and.l	#$FF0000,d2
	or.l	d2,d1
	move.l	d0,d2
	moveq	#$10,d3
	lsr.l	d3,d2
	and.l	#$FF00,d2
	or.l	d2,d1
	moveq	#$18,d2
	lsr.l	d2,d0
	or.l	d1,d0
L119
;	argb = 0;
	clr.l	(a1)
;	rsint32 t, n = 33;
	moveq	#0,d1
	move.b	4(a0),d1
	moveq	#1,d2
	asl.l	d1,d2
	move.l	d2,d1
	subq.l	#1,d1
	moveq	#0,d2
	move.b	$8(a0),d2
	asl.l	d2,d1
	and.l	d0,d1
	beq.b	L121
L120
;		alpha() = (uint8)((255UL*(data & p->getMaskAlpha())>>p->getShift
	moveq	#0,d1
	move.b	4(a0),d1
	moveq	#1,d2
	asl.l	d1,d2
	move.l	d2,d1
	subq.l	#1,d1
	moveq	#0,d2
	move.b	$8(a0),d2
	asl.l	d2,d1
	and.l	d0,d1
	mulu.l	#$FF,d1
	moveq	#0,d2
	move.b	$8(a0),d2
	lsr.l	d2,d1
	moveq	#0,d2
	move.b	4(a0),d2
	moveq	#1,d3
	asl.l	d2,d3
	move.l	d3,d2
	subq.l	#1,d2
	divul.l	d2,d1
	move.b	d1,(a1)
L121
;	if (data & p->getMaskRed()!=0)
	moveq	#0,d1
	move.b	5(a0),d1
	moveq	#1,d2
	asl.l	d1,d2
	move.l	d2,d1
	subq.l	#1,d1
	moveq	#0,d2
	move.b	$9(a0),d2
	asl.l	d2,d1
	tst.l	d1
	sne	d1
	and.l	#1,d1
	and.l	d0,d1
	beq.b	L123
L122
;		red() = (uint8)((255UL*(data & p->getMaskRed())>>p->getShiftRed()
	moveq	#0,d1
	move.b	5(a0),d1
	moveq	#1,d2
	asl.l	d1,d2
	move.l	d2,d1
	subq.l	#1,d1
	moveq	#0,d2
	move.b	$9(a0),d2
	asl.l	d2,d1
	and.l	d0,d1
	mulu.l	#$FF,d1
	moveq	#0,d2
	move.b	$9(a0),d2
	lsr.l	d2,d1
	moveq	#0,d2
	move.b	5(a0),d2
	moveq	#1,d3
	asl.l	d2,d3
	move.l	d3,d2
	subq.l	#1,d2
	divul.l	d2,d1
	move.b	d1,1(a1)
L123
;	if (data & p->getMaskGreen()!=0)
	moveq	#0,d1
	move.b	6(a0),d1
	moveq	#1,d2
	asl.l	d1,d2
	move.l	d2,d1
	subq.l	#1,d1
	moveq	#0,d2
	move.b	$A(a0),d2
	asl.l	d2,d1
	tst.l	d1
	sne	d1
	and.l	#1,d1
	and.l	d0,d1
	beq.b	L125
L124
;		green() = (uint8)((255UL*(data & p->getMaskGreen())>>p->getShift
	moveq	#0,d1
	move.b	6(a0),d1
	moveq	#1,d2
	asl.l	d1,d2
	move.l	d2,d1
	subq.l	#1,d1
	moveq	#0,d2
	move.b	$A(a0),d2
	asl.l	d2,d1
	and.l	d0,d1
	mulu.l	#$FF,d1
	moveq	#0,d2
	move.b	$A(a0),d2
	lsr.l	d2,d1
	moveq	#0,d2
	move.b	6(a0),d2
	moveq	#1,d3
	asl.l	d2,d3
	move.l	d3,d2
	subq.l	#1,d2
	divul.l	d2,d1
	move.b	d1,2(a1)
L125
;	if (data & p->getMaskBlue()!=0)
	moveq	#0,d1
	move.b	7(a0),d1
	moveq	#1,d2
	asl.l	d1,d2
	move.l	d2,d1
	subq.l	#1,d1
	moveq	#0,d2
	move.b	$B(a0),d2
	asl.l	d2,d1
	tst.l	d1
	sne	d1
	and.l	#1,d1
	and.l	d0,d1
	beq.b	L127
L126
;		blue() = (uint8)((255UL*(data & p->getMaskBlue())>>p->getShiftBl
	moveq	#0,d1
	move.b	7(a0),d1
	moveq	#1,d2
	asl.l	d1,d2
	move.l	d2,d1
	subq.l	#1,d1
	moveq	#0,d2
	move.b	$B(a0),d2
	asl.l	d2,d1
	and.l	d1,d0
	mulu.l	#$FF,d0
	moveq	#0,d1
	move.b	$B(a0),d1
	lsr.l	d1,d0
	moveq	#0,d1
	move.b	7(a0),d1
	moveq	#1,d2
	asl.l	d1,d2
	move.l	d2,d1
	subq.l	#1,d1
	divul.l	d1,d0
	move.b	d0,3(a1)
L127
	movem.l	(a7)+,d2/d3/a2
	rts

	SECTION "scaleAlpha__Palette__TfScUcUc:0",CODE


;void	Palette::scaleAlpha(float32 scf, sint8 ofs, uint8 min, uint8 ma
	XDEF	scaleAlpha__Palette__TfScUcUc
scaleAlpha__Palette__TfScUcUc
	movem.l	d2-d6,-(a7)
	fmovem.x fp2,-(a7)
	move.b	$2E(a7),d1
	move.b	$30(a7),d2
	move.b	$2C(a7),d3
	move.l	$24(a7),a0
	fmove.s	$28(a7),fp0
L128
;	register Colour* c = data;
;	rsint32 t, n = 33;
	moveq	#$21,d4
;	while (--n)
	bra	L178
L129
;		t = (sint32)(scf*c->alpha())+ofs;
	moveq	#0,d0
	move.b	(a0),d0
	fmove.l	d0,fp1
	fmul.x	fp0,fp1
	fmove.l	fp1,d0
	move.b	d3,d5
	extb.l	d5
	add.l	d5,d0
; (c++)->alpha()=Clamp::integer(t, min, max);
	moveq	#0,d6
	move.b	d2,d6
	moveq	#0,d5
	move.b	d1,d5
	cmp.l	d5,d0
	bge.b	L131
L130
	move.l	d5,d0
	bra.b	L135
L131
	cmp.l	d6,d0
	ble.b	L133
L132
	move.l	d6,d0
L133
L134
L135
	move.l	a0,a1
	addq.w	#4,a0
	move.b	d0,(a1)
;		t = (sint32)(scf*c->alpha())+ofs;
	moveq	#0,d0
	move.b	(a0),d0
	fmove.l	d0,fp1
	fmul.x	fp0,fp1
	fmove.l	fp1,d0
	move.b	d3,d5
	extb.l	d5
	add.l	d5,d0
; (c++)->alpha()=Clamp::integer(t, min, max);
	moveq	#0,d6
	move.b	d2,d6
	moveq	#0,d5
	move.b	d1,d5
	cmp.l	d5,d0
	bge.b	L137
L136
	move.l	d5,d0
	bra.b	L141
L137
	cmp.l	d6,d0
	ble.b	L139
L138
	move.l	d6,d0
L139
L140
L141
	move.l	a0,a1
	addq.w	#4,a0
	move.b	d0,(a1)
;		t = (sint32)(scf*c->alpha())+ofs;
	moveq	#0,d0
	move.b	(a0),d0
	fmove.l	d0,fp1
	fmul.x	fp0,fp1
	fmove.l	fp1,d0
	move.b	d3,d5
	extb.l	d5
	add.l	d5,d0
; (c++)->alpha()=Clamp::integer(t, min, max);
	moveq	#0,d6
	move.b	d2,d6
	moveq	#0,d5
	move.b	d1,d5
	cmp.l	d5,d0
	bge.b	L143
L142
	move.l	d5,d0
	bra.b	L147
L143
	cmp.l	d6,d0
	ble.b	L145
L144
	move.l	d6,d0
L145
L146
L147
	move.l	a0,a1
	addq.w	#4,a0
	move.b	d0,(a1)
;		t = (sint32)(scf*c->alpha())+ofs;
	moveq	#0,d0
	move.b	(a0),d0
	fmove.l	d0,fp1
	fmul.x	fp0,fp1
	fmove.l	fp1,d0
	move.b	d3,d5
	extb.l	d5
	add.l	d5,d0
; (c++)->alpha()=Clamp::integer(t, min, max);
	moveq	#0,d6
	move.b	d2,d6
	moveq	#0,d5
	move.b	d1,d5
	cmp.l	d5,d0
	bge.b	L149
L148
	move.l	d5,d0
	bra.b	L153
L149
	cmp.l	d6,d0
	ble.b	L151
L150
	move.l	d6,d0
L151
L152
L153
	move.l	a0,a1
	addq.w	#4,a0
	move.b	d0,(a1)
;		t = (sint32)(scf*c->alpha())+ofs;
	moveq	#0,d0
	move.b	(a0),d0
	fmove.l	d0,fp1
	fmul.x	fp0,fp1
	fmove.l	fp1,d0
	move.b	d3,d5
	extb.l	d5
	add.l	d5,d0
; (c++)->alpha()=Clamp::integer(t, min, max);
	moveq	#0,d6
	move.b	d2,d6
	moveq	#0,d5
	move.b	d1,d5
	cmp.l	d5,d0
	bge.b	L155
L154
	move.l	d5,d0
	bra.b	L159
L155
	cmp.l	d6,d0
	ble.b	L157
L156
	move.l	d6,d0
L157
L158
L159
	move.l	a0,a1
	addq.w	#4,a0
	move.b	d0,(a1)
;		t = (sint32)(scf*c->alpha())+ofs;
	moveq	#0,d0
	move.b	(a0),d0
	fmove.l	d0,fp1
	fmul.x	fp0,fp1
	fmove.l	fp1,d0
	move.b	d3,d5
	extb.l	d5
	add.l	d5,d0
; (c++)->alpha()=Clamp::integer(t, min, max);
	moveq	#0,d6
	move.b	d2,d6
	moveq	#0,d5
	move.b	d1,d5
	cmp.l	d5,d0
	bge.b	L161
L160
	move.l	d5,d0
	bra.b	L165
L161
	cmp.l	d6,d0
	ble.b	L163
L162
	move.l	d6,d0
L163
L164
L165
	move.l	a0,a1
	addq.w	#4,a0
	move.b	d0,(a1)
;		t = (sint32)(scf*c->alpha())+ofs;
	moveq	#0,d0
	move.b	(a0),d0
	fmove.l	d0,fp1
	fmul.x	fp0,fp1
	fmove.l	fp1,d0
	move.b	d3,d5
	extb.l	d5
	add.l	d5,d0
; (c++)->alpha()=Clamp::integer(t, min, max);
	moveq	#0,d6
	move.b	d2,d6
	moveq	#0,d5
	move.b	d1,d5
	cmp.l	d5,d0
	bge.b	L167
L166
	move.l	d5,d0
	bra.b	L171
L167
	cmp.l	d6,d0
	ble.b	L169
L168
	move.l	d6,d0
L169
L170
L171
	move.l	a0,a1
	addq.w	#4,a0
	move.b	d0,(a1)
;		t = (sint32)(scf*c->alpha())+ofs;
	moveq	#0,d0
	move.b	(a0),d0
	fmove.l	d0,fp1
	fmul.x	fp0,fp1
	fmove.l	fp1,d0
	move.b	d3,d5
	extb.l	d5
	add.l	d5,d0
; (c++)->alpha()=Clamp::integer(t, min, max);
	moveq	#0,d6
	move.b	d2,d6
	moveq	#0,d5
	move.b	d1,d5
	cmp.l	d5,d0
	bge.b	L173
L172
	move.l	d5,d0
	bra.b	L177
L173
	cmp.l	d6,d0
	ble.b	L175
L174
	move.l	d6,d0
L175
L176
L177
	move.l	a0,a1
	addq.w	#4,a0
	move.b	d0,(a1)
L178
	subq.l	#1,d4
	tst.l	d4
	bne	L129
L179
	fmovem.x (a7)+,fp2
	movem.l	(a7)+,d2-d6
	rts

	SECTION "scaleRed__Palette__TfScUcUc:0",CODE


;void	Palette::scaleRed(float32 scf, sint8 ofs, uint8 min, uint8 max)
	XDEF	scaleRed__Palette__TfScUcUc
scaleRed__Palette__TfScUcUc
	movem.l	d2-d6,-(a7)
	fmovem.x fp2,-(a7)
	move.b	$2E(a7),d1
	move.b	$30(a7),d2
	move.b	$2C(a7),d3
	move.l	$24(a7),a0
	fmove.s	$28(a7),fp0
L180
;	register Colour* c = data;
;	rsint32 t, n = 33;
	moveq	#$21,d4
;	while (--n)
	bra	L230
L181
;		t = (sint32)(scf*c->red())+ofs;
	moveq	#0,d0
	move.b	1(a0),d0
	fmove.l	d0,fp1
	fmul.x	fp0,fp1
	fmove.l	fp1,d0
	move.b	d3,d5
	extb.l	d5
	add.l	d5,d0
; (c++)->red()=Clamp::integer(t, min, max);
	moveq	#0,d6
	move.b	d2,d6
	moveq	#0,d5
	move.b	d1,d5
	cmp.l	d5,d0
	bge.b	L183
L182
	move.l	d5,d0
	bra.b	L187
L183
	cmp.l	d6,d0
	ble.b	L185
L184
	move.l	d6,d0
L185
L186
L187
	move.l	a0,a1
	addq.w	#4,a0
	move.b	d0,1(a1)
;		t = (sint32)(scf*c->red())+ofs;
	moveq	#0,d0
	move.b	1(a0),d0
	fmove.l	d0,fp1
	fmul.x	fp0,fp1
	fmove.l	fp1,d0
	move.b	d3,d5
	extb.l	d5
	add.l	d5,d0
; (c++)->red()=Clamp::integer(t, min, max);
	moveq	#0,d6
	move.b	d2,d6
	moveq	#0,d5
	move.b	d1,d5
	cmp.l	d5,d0
	bge.b	L189
L188
	move.l	d5,d0
	bra.b	L193
L189
	cmp.l	d6,d0
	ble.b	L191
L190
	move.l	d6,d0
L191
L192
L193
	move.l	a0,a1
	addq.w	#4,a0
	move.b	d0,1(a1)
;		t = (sint32)(scf*c->red())+ofs;
	moveq	#0,d0
	move.b	1(a0),d0
	fmove.l	d0,fp1
	fmul.x	fp0,fp1
	fmove.l	fp1,d0
	move.b	d3,d5
	extb.l	d5
	add.l	d5,d0
; (c++)->red()=Clamp::integer(t, min, max);
	moveq	#0,d6
	move.b	d2,d6
	moveq	#0,d5
	move.b	d1,d5
	cmp.l	d5,d0
	bge.b	L195
L194
	move.l	d5,d0
	bra.b	L199
L195
	cmp.l	d6,d0
	ble.b	L197
L196
	move.l	d6,d0
L197
L198
L199
	move.l	a0,a1
	addq.w	#4,a0
	move.b	d0,1(a1)
;		t = (sint32)(scf*c->red())+ofs;
	moveq	#0,d0
	move.b	1(a0),d0
	fmove.l	d0,fp1
	fmul.x	fp0,fp1
	fmove.l	fp1,d0
	move.b	d3,d5
	extb.l	d5
	add.l	d5,d0
; (c++)->red()=Clamp::integer(t, min, max);
	moveq	#0,d6
	move.b	d2,d6
	moveq	#0,d5
	move.b	d1,d5
	cmp.l	d5,d0
	bge.b	L201
L200
	move.l	d5,d0
	bra.b	L205
L201
	cmp.l	d6,d0
	ble.b	L203
L202
	move.l	d6,d0
L203
L204
L205
	move.l	a0,a1
	addq.w	#4,a0
	move.b	d0,1(a1)
;		t = (sint32)(scf*c->red())+ofs;
	moveq	#0,d0
	move.b	1(a0),d0
	fmove.l	d0,fp1
	fmul.x	fp0,fp1
	fmove.l	fp1,d0
	move.b	d3,d5
	extb.l	d5
	add.l	d5,d0
; (c++)->red()=Clamp::integer(t, min, max);
	moveq	#0,d6
	move.b	d2,d6
	moveq	#0,d5
	move.b	d1,d5
	cmp.l	d5,d0
	bge.b	L207
L206
	move.l	d5,d0
	bra.b	L211
L207
	cmp.l	d6,d0
	ble.b	L209
L208
	move.l	d6,d0
L209
L210
L211
	move.l	a0,a1
	addq.w	#4,a0
	move.b	d0,1(a1)
;		t = (sint32)(scf*c->red())+ofs;
	moveq	#0,d0
	move.b	1(a0),d0
	fmove.l	d0,fp1
	fmul.x	fp0,fp1
	fmove.l	fp1,d0
	move.b	d3,d5
	extb.l	d5
	add.l	d5,d0
; (c++)->red()=Clamp::integer(t, min, max);
	moveq	#0,d6
	move.b	d2,d6
	moveq	#0,d5
	move.b	d1,d5
	cmp.l	d5,d0
	bge.b	L213
L212
	move.l	d5,d0
	bra.b	L217
L213
	cmp.l	d6,d0
	ble.b	L215
L214
	move.l	d6,d0
L215
L216
L217
	move.l	a0,a1
	addq.w	#4,a0
	move.b	d0,1(a1)
;		t = (sint32)(scf*c->red())+ofs;
	moveq	#0,d0
	move.b	1(a0),d0
	fmove.l	d0,fp1
	fmul.x	fp0,fp1
	fmove.l	fp1,d0
	move.b	d3,d5
	extb.l	d5
	add.l	d5,d0
; (c++)->red()=Clamp::integer(t, min, max);
	moveq	#0,d6
	move.b	d2,d6
	moveq	#0,d5
	move.b	d1,d5
	cmp.l	d5,d0
	bge.b	L219
L218
	move.l	d5,d0
	bra.b	L223
L219
	cmp.l	d6,d0
	ble.b	L221
L220
	move.l	d6,d0
L221
L222
L223
	move.l	a0,a1
	addq.w	#4,a0
	move.b	d0,1(a1)
;		t = (sint32)(scf*c->red())+ofs;
	moveq	#0,d0
	move.b	1(a0),d0
	fmove.l	d0,fp1
	fmul.x	fp0,fp1
	fmove.l	fp1,d0
	move.b	d3,d5
	extb.l	d5
	add.l	d5,d0
; (c++)->red()=Clamp::integer(t, min, max);
	moveq	#0,d6
	move.b	d2,d6
	moveq	#0,d5
	move.b	d1,d5
	cmp.l	d5,d0
	bge.b	L225
L224
	move.l	d5,d0
	bra.b	L229
L225
	cmp.l	d6,d0
	ble.b	L227
L226
	move.l	d6,d0
L227
L228
L229
	move.l	a0,a1
	addq.w	#4,a0
	move.b	d0,1(a1)
L230
	subq.l	#1,d4
	tst.l	d4
	bne	L181
L231
	fmovem.x (a7)+,fp2
	movem.l	(a7)+,d2-d6
	rts

	SECTION "scaleGreen__Palette__TfScUcUc:0",CODE


;void	Palette::scaleGreen(float32 scf, sint8 ofs, uint8 min, uint8 ma
	XDEF	scaleGreen__Palette__TfScUcUc
scaleGreen__Palette__TfScUcUc
	movem.l	d2-d6,-(a7)
	fmovem.x fp2,-(a7)
	move.b	$2E(a7),d1
	move.b	$30(a7),d2
	move.b	$2C(a7),d3
	move.l	$24(a7),a0
	fmove.s	$28(a7),fp0
L232
;	register Colour* c = data;
;	rsint32 t, n = 33;
	moveq	#$21,d4
;	while (--n)
	bra	L282
L233
;		t = (sint32)(scf*c->green())+ofs;
	moveq	#0,d0
	move.b	2(a0),d0
	fmove.l	d0,fp1
	fmul.x	fp0,fp1
	fmove.l	fp1,d0
	move.b	d3,d5
	extb.l	d5
	add.l	d5,d0
; (c++)->green()=Clamp::integer(t, min, max);
	moveq	#0,d6
	move.b	d2,d6
	moveq	#0,d5
	move.b	d1,d5
	cmp.l	d5,d0
	bge.b	L235
L234
	move.l	d5,d0
	bra.b	L239
L235
	cmp.l	d6,d0
	ble.b	L237
L236
	move.l	d6,d0
L237
L238
L239
	move.l	a0,a1
	addq.w	#4,a0
	move.b	d0,2(a1)
;		t = (sint32)(scf*c->green())+ofs;
	moveq	#0,d0
	move.b	2(a0),d0
	fmove.l	d0,fp1
	fmul.x	fp0,fp1
	fmove.l	fp1,d0
	move.b	d3,d5
	extb.l	d5
	add.l	d5,d0
; (c++)->green()=Clamp::integer(t, min, max);
	moveq	#0,d6
	move.b	d2,d6
	moveq	#0,d5
	move.b	d1,d5
	cmp.l	d5,d0
	bge.b	L241
L240
	move.l	d5,d0
	bra.b	L245
L241
	cmp.l	d6,d0
	ble.b	L243
L242
	move.l	d6,d0
L243
L244
L245
	move.l	a0,a1
	addq.w	#4,a0
	move.b	d0,2(a1)
;		t = (sint32)(scf*c->green())+ofs;
	moveq	#0,d0
	move.b	2(a0),d0
	fmove.l	d0,fp1
	fmul.x	fp0,fp1
	fmove.l	fp1,d0
	move.b	d3,d5
	extb.l	d5
	add.l	d5,d0
; (c++)->green()=Clamp::integer(t, min, max);
	moveq	#0,d6
	move.b	d2,d6
	moveq	#0,d5
	move.b	d1,d5
	cmp.l	d5,d0
	bge.b	L247
L246
	move.l	d5,d0
	bra.b	L251
L247
	cmp.l	d6,d0
	ble.b	L249
L248
	move.l	d6,d0
L249
L250
L251
	move.l	a0,a1
	addq.w	#4,a0
	move.b	d0,2(a1)
;		t = (sint32)(scf*c->green())+ofs;
	moveq	#0,d0
	move.b	2(a0),d0
	fmove.l	d0,fp1
	fmul.x	fp0,fp1
	fmove.l	fp1,d0
	move.b	d3,d5
	extb.l	d5
	add.l	d5,d0
; (c++)->green()=Clamp::integer(t, min, max);
	moveq	#0,d6
	move.b	d2,d6
	moveq	#0,d5
	move.b	d1,d5
	cmp.l	d5,d0
	bge.b	L253
L252
	move.l	d5,d0
	bra.b	L257
L253
	cmp.l	d6,d0
	ble.b	L255
L254
	move.l	d6,d0
L255
L256
L257
	move.l	a0,a1
	addq.w	#4,a0
	move.b	d0,2(a1)
;		t = (sint32)(scf*c->green())+ofs;
	moveq	#0,d0
	move.b	2(a0),d0
	fmove.l	d0,fp1
	fmul.x	fp0,fp1
	fmove.l	fp1,d0
	move.b	d3,d5
	extb.l	d5
	add.l	d5,d0
; (c++)->green()=Clamp::integer(t, min, max);
	moveq	#0,d6
	move.b	d2,d6
	moveq	#0,d5
	move.b	d1,d5
	cmp.l	d5,d0
	bge.b	L259
L258
	move.l	d5,d0
	bra.b	L263
L259
	cmp.l	d6,d0
	ble.b	L261
L260
	move.l	d6,d0
L261
L262
L263
	move.l	a0,a1
	addq.w	#4,a0
	move.b	d0,2(a1)
;		t = (sint32)(scf*c->green())+ofs;
	moveq	#0,d0
	move.b	2(a0),d0
	fmove.l	d0,fp1
	fmul.x	fp0,fp1
	fmove.l	fp1,d0
	move.b	d3,d5
	extb.l	d5
	add.l	d5,d0
; (c++)->green()=Clamp::integer(t, min, max);
	moveq	#0,d6
	move.b	d2,d6
	moveq	#0,d5
	move.b	d1,d5
	cmp.l	d5,d0
	bge.b	L265
L264
	move.l	d5,d0
	bra.b	L269
L265
	cmp.l	d6,d0
	ble.b	L267
L266
	move.l	d6,d0
L267
L268
L269
	move.l	a0,a1
	addq.w	#4,a0
	move.b	d0,2(a1)
;		t = (sint32)(scf*c->green())+ofs;
	moveq	#0,d0
	move.b	2(a0),d0
	fmove.l	d0,fp1
	fmul.x	fp0,fp1
	fmove.l	fp1,d0
	move.b	d3,d5
	extb.l	d5
	add.l	d5,d0
; (c++)->green()=Clamp::integer(t, min, max);
	moveq	#0,d6
	move.b	d2,d6
	moveq	#0,d5
	move.b	d1,d5
	cmp.l	d5,d0
	bge.b	L271
L270
	move.l	d5,d0
	bra.b	L275
L271
	cmp.l	d6,d0
	ble.b	L273
L272
	move.l	d6,d0
L273
L274
L275
	move.l	a0,a1
	addq.w	#4,a0
	move.b	d0,2(a1)
;		t = (sint32)(scf*c->green())+ofs;
	moveq	#0,d0
	move.b	2(a0),d0
	fmove.l	d0,fp1
	fmul.x	fp0,fp1
	fmove.l	fp1,d0
	move.b	d3,d5
	extb.l	d5
	add.l	d5,d0
; (c++)->green()=Clamp::integer(t, min, max);
	moveq	#0,d6
	move.b	d2,d6
	moveq	#0,d5
	move.b	d1,d5
	cmp.l	d5,d0
	bge.b	L277
L276
	move.l	d5,d0
	bra.b	L281
L277
	cmp.l	d6,d0
	ble.b	L279
L278
	move.l	d6,d0
L279
L280
L281
	move.l	a0,a1
	addq.w	#4,a0
	move.b	d0,2(a1)
L282
	subq.l	#1,d4
	tst.l	d4
	bne	L233
L283
	fmovem.x (a7)+,fp2
	movem.l	(a7)+,d2-d6
	rts

	SECTION "scaleBlue__Palette__TfScUcUc:0",CODE


;void	Palette::scaleBlue(float32 scf, sint8 ofs, uint8 min, uint8 max)
	XDEF	scaleBlue__Palette__TfScUcUc
scaleBlue__Palette__TfScUcUc
	movem.l	d2-d6,-(a7)
	fmovem.x fp2,-(a7)
	move.b	$2E(a7),d1
	move.b	$30(a7),d2
	move.b	$2C(a7),d3
	move.l	$24(a7),a0
	fmove.s	$28(a7),fp0
L284
;	register Colour* c = data;
;	rsint32 t, n = 33;
	moveq	#$21,d4
;	while (--n)
	bra	L334
L285
;		t = (sint32)(scf*c->blue())+ofs;
	moveq	#0,d0
	move.b	3(a0),d0
	fmove.l	d0,fp1
	fmul.x	fp0,fp1
	fmove.l	fp1,d0
	move.b	d3,d5
	extb.l	d5
	add.l	d5,d0
; (c++)->blue()=Clamp::integer(t, min, max);
	moveq	#0,d6
	move.b	d2,d6
	moveq	#0,d5
	move.b	d1,d5
	cmp.l	d5,d0
	bge.b	L287
L286
	move.l	d5,d0
	bra.b	L291
L287
	cmp.l	d6,d0
	ble.b	L289
L288
	move.l	d6,d0
L289
L290
L291
	move.l	a0,a1
	addq.w	#4,a0
	move.b	d0,3(a1)
;		t = (sint32)(scf*c->blue())+ofs;
	moveq	#0,d0
	move.b	3(a0),d0
	fmove.l	d0,fp1
	fmul.x	fp0,fp1
	fmove.l	fp1,d0
	move.b	d3,d5
	extb.l	d5
	add.l	d5,d0
; (c++)->blue()=Clamp::integer(t, min, max);
	moveq	#0,d6
	move.b	d2,d6
	moveq	#0,d5
	move.b	d1,d5
	cmp.l	d5,d0
	bge.b	L293
L292
	move.l	d5,d0
	bra.b	L297
L293
	cmp.l	d6,d0
	ble.b	L295
L294
	move.l	d6,d0
L295
L296
L297
	move.l	a0,a1
	addq.w	#4,a0
	move.b	d0,3(a1)
;		t = (sint32)(scf*c->blue())+ofs;
	moveq	#0,d0
	move.b	3(a0),d0
	fmove.l	d0,fp1
	fmul.x	fp0,fp1
	fmove.l	fp1,d0
	move.b	d3,d5
	extb.l	d5
	add.l	d5,d0
; (c++)->blue()=Clamp::integer(t, min, max);
	moveq	#0,d6
	move.b	d2,d6
	moveq	#0,d5
	move.b	d1,d5
	cmp.l	d5,d0
	bge.b	L299
L298
	move.l	d5,d0
	bra.b	L303
L299
	cmp.l	d6,d0
	ble.b	L301
L300
	move.l	d6,d0
L301
L302
L303
	move.l	a0,a1
	addq.w	#4,a0
	move.b	d0,3(a1)
;		t = (sint32)(scf*c->blue())+ofs;
	moveq	#0,d0
	move.b	3(a0),d0
	fmove.l	d0,fp1
	fmul.x	fp0,fp1
	fmove.l	fp1,d0
	move.b	d3,d5
	extb.l	d5
	add.l	d5,d0
; (c++)->blue()=Clamp::integer(t, min, max);
	moveq	#0,d6
	move.b	d2,d6
	moveq	#0,d5
	move.b	d1,d5
	cmp.l	d5,d0
	bge.b	L305
L304
	move.l	d5,d0
	bra.b	L309
L305
	cmp.l	d6,d0
	ble.b	L307
L306
	move.l	d6,d0
L307
L308
L309
	move.l	a0,a1
	addq.w	#4,a0
	move.b	d0,3(a1)
;		t = (sint32)(scf*c->blue())+ofs;
	moveq	#0,d0
	move.b	3(a0),d0
	fmove.l	d0,fp1
	fmul.x	fp0,fp1
	fmove.l	fp1,d0
	move.b	d3,d5
	extb.l	d5
	add.l	d5,d0
; (c++)->blue()=Clamp::integer(t, min, max);
	moveq	#0,d6
	move.b	d2,d6
	moveq	#0,d5
	move.b	d1,d5
	cmp.l	d5,d0
	bge.b	L311
L310
	move.l	d5,d0
	bra.b	L315
L311
	cmp.l	d6,d0
	ble.b	L313
L312
	move.l	d6,d0
L313
L314
L315
	move.l	a0,a1
	addq.w	#4,a0
	move.b	d0,3(a1)
;		t = (sint32)(scf*c->blue())+ofs;
	moveq	#0,d0
	move.b	3(a0),d0
	fmove.l	d0,fp1
	fmul.x	fp0,fp1
	fmove.l	fp1,d0
	move.b	d3,d5
	extb.l	d5
	add.l	d5,d0
; (c++)->blue()=Clamp::integer(t, min, max);
	moveq	#0,d6
	move.b	d2,d6
	moveq	#0,d5
	move.b	d1,d5
	cmp.l	d5,d0
	bge.b	L317
L316
	move.l	d5,d0
	bra.b	L321
L317
	cmp.l	d6,d0
	ble.b	L319
L318
	move.l	d6,d0
L319
L320
L321
	move.l	a0,a1
	addq.w	#4,a0
	move.b	d0,3(a1)
;		t = (sint32)(scf*c->blue())+ofs;
	moveq	#0,d0
	move.b	3(a0),d0
	fmove.l	d0,fp1
	fmul.x	fp0,fp1
	fmove.l	fp1,d0
	move.b	d3,d5
	extb.l	d5
	add.l	d5,d0
; (c++)->blue()=Clamp::integer(t, min, max);
	moveq	#0,d6
	move.b	d2,d6
	moveq	#0,d5
	move.b	d1,d5
	cmp.l	d5,d0
	bge.b	L323
L322
	move.l	d5,d0
	bra.b	L327
L323
	cmp.l	d6,d0
	ble.b	L325
L324
	move.l	d6,d0
L325
L326
L327
	move.l	a0,a1
	addq.w	#4,a0
	move.b	d0,3(a1)
;		t = (sint32)(scf*c->blue())+ofs;
	moveq	#0,d0
	move.b	3(a0),d0
	fmove.l	d0,fp1
	fmul.x	fp0,fp1
	fmove.l	fp1,d0
	move.b	d3,d5
	extb.l	d5
	add.l	d5,d0
; (c++)->blue()=Clamp::integer(t, min, max);
	moveq	#0,d6
	move.b	d2,d6
	moveq	#0,d5
	move.b	d1,d5
	cmp.l	d5,d0
	bge.b	L329
L328
	move.l	d5,d0
	bra.b	L333
L329
	cmp.l	d6,d0
	ble.b	L331
L330
	move.l	d6,d0
L331
L332
L333
	move.l	a0,a1
	addq.w	#4,a0
	move.b	d0,3(a1)
L334
	subq.l	#1,d4
	tst.l	d4
	bne	L285
L335
	fmovem.x (a7)+,fp2
	movem.l	(a7)+,d2-d6
	rts

	SECTION "findBestMatch__Palette__TRC06Colours:0",CODE


;size_t Palette::findBestMatch(const Colour& c, bool ignoreAlpha)
	XDEF	findBestMatch__Palette__TRC06Colours
findBestMatch__Palette__TRC06Colours
	move.w	$C(a7),d0
L336
;	if (ignoreAlpha)
	tst.w	d0
	beq.b	L338
L337
;		size_t best = 0;
;		return best;
	moveq	#0,d0
	rts
L338
;		size_t best = 0;
;		return best;
	moveq	#0,d0
	rts

	SECTION "getDescriptor__ImageBuffer__T:0",CODE


;P_DSC* ImageBuffer::getDescriptor()
	XDEF	getDescriptor__ImageBuffer__T
getDescriptor__ImageBuffer__T
	move.l	4(a7),a0
L339
;	if (pixFormat!=Pixel::OTHERFMT)
	move.l	$14(a0),d0
	cmp.l	#$F,d0
	beq.b	L341
L340
;		return PixelDescriptor::get(pixFormat);
	move.l	$14(a0),d0
	muls.l	#$C,d0
	add.l	#_propTab__PixelDescriptor,d0
	rts
L341
;	return pixDesc;
	move.l	$10(a0),d0
	rts

	SECTION "setPalette__ImageBuffer__TP07Palettess:0",CODE


;sint32 ImageBuffer::setPalette(Palette* p, bool copy, sint16 sz)
	XDEF	setPalette__ImageBuffer__TP07Palettess
setPalette__ImageBuffer__TP07Palettess
	movem.l	d2/d3/a2/a3,-(a7)
	movem.l	$14(a7),a2/a3
	move.w	$1C(a7),d0
	move.w	$1E(a7),d3
L342
;	if (copy)
	tst.w	d0
	beq.b	L352
L343
;		if (!palette || !(properties & OWN_PALETTE))
	tst.l	$C(a2)
	beq.b	L345
L344
	move.l	4(a2),d0
	and.l	#2,d0
	bne.b	L348
L345
;			if (!(palette = (Palette*)Mem::alloc(sizeof(Palette), false)))
	clr.l	-(a7)
	clr.w	-(a7)
	pea	$400.w
	jsr	alloc__Mem__UisE
	add.w	#$A,a7
	move.l	d0,$C(a2)
	bne.b	L347
L346
;				properties &= ~OWN_PALETTE;
	and.l	#-3,4(a2)
;				return ERR_NO_FREE_STORE;
	move.l	#-$3030001,d0
	movem.l	(a7)+,d2/d3/a2/a3
	rts
L347
;				properties |= OWN_PALETTE;
	or.l	#2,4(a2)
L348
;		if (p!=0)
	move.l	a3,a0
	cmp.w	#0,a0
	beq.b	L350
L349
;			Mem::copy(palette, p, sizeof(Palette));
	move.l	#$400,d0
	move.l	$C(a2),a0
	move.l	a3,a1
	jsr	copy__Mem__r8Pvr9Pvr0Ui
	bra.b	L351
L350
;			Mem::zero(palette, sizeof(Palette));
	move.l	#$400,d0
	move.l	$C(a2),a0
	jsr	zero__Mem__r8Pvr0Ui
L351
	bra.b	L356
L352
;		if (properties & OWN_PALETTE)
	move.l	4(a2),d0
	and.l	#2,d0
	beq.b	L355
L353
;			properties &= ~OWN_PALETTE;
	and.l	#-3,4(a2)
;			if (palette)
	tst.l	$C(a2)
	beq.b	L355
L354
;				Mem::free(palette);
	move.l	$C(a2),-(a7)
	jsr	free__Mem__Pv
	addq.w	#4,a7
L355
;		palette = p;
	move.l	a3,$C(a2)
L356
;	palSize = Clamp::integer(sz, 0, 256);
	move.l	#$100,d2
	moveq	#0,d1
	move.w	d3,d0
	ext.l	d0
	cmp.l	d1,d0
	bge.b	L358
L357
	move.l	d1,d0
	bra.b	L362
L358
	cmp.l	d2,d0
	ble.b	L360
L359
	move.l	d2,d0
L360
L361
L362
	move.w	d0,$18(a2)
;	return OK;
	moveq	#0,d0
	movem.l	(a7)+,d2/d3/a2/a3
	rts

	SECTION "create__ImageBuffer__TssEP07Palettess:0",CODE


;sint32 ImageBuffer::create(S_WH, P_F f, Palette* p, bool copyPal, si
	XDEF	create__ImageBuffer__TssEP07Palettess
create__ImageBuffer__TssEP07Palettess
	movem.l	d2-d6/a2/a3,-(a7)
	movem.l	$28(a7),d4/a3
	move.w	$26(a7),d2
	move.w	$24(a7),d3
	move.w	$30(a7),d5
	move.w	$32(a7),d6
	move.l	$20(a7),a2
L363
;	if (data)
	tst.l	$8(a2)
	beq.b	L365
L364
;		return ERR_RSC_LOCKED;
	move.l	#-$3050004,d0
	movem.l	(a7)+,d2-d6/a2/a3
	rts
L365
;	if (w<1 || h<1)
	cmp.w	#1,d3
	blt.b	L367
L366
	cmp.w	#1,d2
	bge.b	L368
L367
;		return ERR_VALUE_MIN;
	move.l	#-$3010004,d0
	movem.l	(a7)+,d2-d6/a2/a3
	rts
L368
;	size_t size = w*h*(PixelDescriptor::get(f)->getSize());
	move.w	d3,d0
	muls	d2,d0
	move.l	d4,d1
	muls.l	#$C,d1
	move.l	#_propTab__PixelDescriptor,a1
	move.b	0(a1,d1.l),d1
	and.l	#$FF,d1
	mulu.l	d1,d0
;	if (!(data = Mem::alloc(size, false, Mem::ALIGN_CACHE)))
	pea	$10.w
	clr.w	-(a7)
	move.l	d0,-(a7)
	jsr	alloc__Mem__UisE
	add.w	#$A,a7
	move.l	d0,$8(a2)
	bne.b	L370
L369
;		return ERR_NO_FREE_STORE;
	move.l	#-$3030001,d0
	movem.l	(a7)+,d2-d6/a2/a3
	rts
L370
;	properties = OWN_DATA;
	move.l	#1,4(a2)
;	width = w;
	move.w	d3,(a2)
;	height = h;
	move.w	d2,2(a2)
;	pixFormat = f;
	move.l	d4,$14(a2)
;	palSize = 0;
	clr.w	$18(a2)
;	if (pixFormat == Pixel::INDEX8)
	tst.l	$14(a2)
	bne.b	L373
L371
;		if (setPalette(p, copyPal, sz)!=OK)
	move.w	d6,-(a7)
	move.w	d5,-(a7)
	move.l	a3,-(a7)
	move.l	a2,-(a7)
	jsr	setPalette__ImageBuffer__TP07Palettess
	add.w	#$C,a7
	tst.l	d0
	beq.b	L373
L372
;			destroy();
	move.l	a2,-(a7)
	jsr	destroy__ImageBuffer__T
	addq.w	#4,a7
;			return ERR_RSC_UNAVAILABLE;
	move.l	#-$3050005,d0
	movem.l	(a7)+,d2-d6/a2/a3
	rts
L373
;	return OK;
	moveq	#0,d0
	movem.l	(a7)+,d2-d6/a2/a3
	rts

	SECTION "create__ImageBuffer__TssP15PixelDescriptorP07Palettesss:0",CODE


;sint32 ImageBuffer::create(S_WH, P_DSC* dsc, Palette* p, bool copyDs
	XDEF	create__ImageBuffer__TssP15PixelDescriptorP07Palettesss
create__ImageBuffer__TssP15PixelDescriptorP07Palettesss
	movem.l	d2-d6/a2/a3/a6,-(a7)
	move.w	$34(a7),d1
	move.w	$2A(a7),d3
	move.w	$28(a7),d4
	move.w	$36(a7),d5
	move.w	$38(a7),d6
	move.l	$24(a7),a2
	move.l	$2C(a7),a3
	move.l	$30(a7),a6
L374
;	if (data)
	tst.l	$8(a2)
	beq.b	L376
L375
;		return ERR_RSC_LOCKED;
	move.l	#-$3050004,d0
	movem.l	(a7)+,d2-d6/a2/a3/a6
	rts
L376
;	if (w<1 || h<1)
	cmp.w	#1,d4
	blt.b	L378
L377
	cmp.w	#1,d3
	bge.b	L379
L378
;		return ERR_VALUE_MIN;
	move.l	#-$3010004,d0
	movem.l	(a7)+,d2-d6/a2/a3/a6
	rts
L379
;	if (!dsc)
	cmp.w	#0,a3
	bne.b	L381
L380
;		return ERR_PTR_ZERO;
	move.l	#-$3020002,d0
	movem.l	(a7)+,d2-d6/a2/a3/a6
	rts
L381
;	size_t size = w*h*dsc->getSize();
	move.w	d4,d2
	muls	d3,d2
	moveq	#0,d0
	move.b	(a3),d0
	mulu.l	d0,d2
;	properties = 0;
	clr.l	4(a2)
;	if (copyDsc)
	tst.w	d1
	beq.b	L387
L382
;		if (!(pixDesc = new PixelDescriptor))
	pea	$C.w
	jsr	op__new__Ui
	addq.w	#4,a7
	move.l	d0,a0
	cmp.w	#0,a0
L383
L384
	move.l	d0,$10(a2)
	bne.b	L386
L385
;			return ERR_NO_FREE_STORE;
	move.l	#-$3030001,d0
	movem.l	(a7)+,d2-d6/a2/a3/a6
	rts
L386
;		properties |= OWN_PIXDESC;
	or.l	#4,4(a2)
;		*pixDesc = *dsc;
	move.l	a3,a1
	move.l	$10(a2),a0
	move.l	(a1)+,(a0)+
	move.l	(a1)+,(a0)+
	move.l	(a1)+,(a0)+
	bra.b	L388
L387
;		pixDesc = dsc;
	move.l	a3,$10(a2)
L388
;	if (!(data = Mem::alloc(size, false)))
	clr.l	-(a7)
	clr.w	-(a7)
	move.l	d2,-(a7)
	jsr	alloc__Mem__UisE
	add.w	#$A,a7
	move.l	d0,$8(a2)
	bne.b	L390
L389
;		return ERR_NO_FREE_STORE;
	move.l	#-$3030001,d0
	movem.l	(a7)+,d2-d6/a2/a3/a6
	rts
L390
;	properties |= OWN_DATA;
	or.l	#1,4(a2)
;	width = w;
	move.w	d4,(a2)
;	height = h;
	move.w	d3,2(a2)
;	pixFormat = Pixel::OTHERFMT;
	move.l	#$F,$14(a2)
;	palSize = 0;
	clr.w	$18(a2)
;	if (p)
	cmp.w	#0,a6
	beq.b	L393
L391
;		if (setPalette(p, copyPal, sz)!=OK)
	move.w	d6,-(a7)
	move.w	d5,-(a7)
	move.l	a6,-(a7)
	move.l	a2,-(a7)
	jsr	setPalette__ImageBuffer__TP07Palettess
	add.w	#$C,a7
	tst.l	d0
	beq.b	L393
L392
;			destroy();
	move.l	a2,-(a7)
	jsr	destroy__ImageBuffer__T
	addq.w	#4,a7
;			return ERR_RSC_UNAVAILABLE;
	move.l	#-$3050005,d0
	movem.l	(a7)+,d2-d6/a2/a3/a6
	rts
L393
;	return OK;
	moveq	#0,d0
	movem.l	(a7)+,d2-d6/a2/a3/a6
	rts

	SECTION "destroy__ImageBuffer__T:0",CODE


;void ImageBuffer::destroy()
	XDEF	destroy__ImageBuffer__T
destroy__ImageBuffer__T
	move.l	a2,-(a7)
	move.l	$8(a7),a2
L394
;	if ((properties & OWN_DATA) && data!=0)
	move.l	4(a2),d0
	and.l	#1,d0
	beq.b	L397
L395
	move.l	$8(a2),a0
	cmp.w	#0,a0
	beq.b	L397
L396
;		Mem::free(data);
	move.l	$8(a2),-(a7)
	jsr	free__Mem__Pv
	addq.w	#4,a7
L397
;	if ((properties & OWN_PALETTE) && palette!=0)
	move.l	4(a2),d0
	and.l	#2,d0
	beq.b	L400
L398
	move.l	$C(a2),a0
	cmp.w	#0,a0
	beq.b	L400
L399
;		Mem::free(palette);
	move.l	$C(a2),-(a7)
	jsr	free__Mem__Pv
	addq.w	#4,a7
L400
;	if ((properties & OWN_PIXDESC) && pixDesc!=0)
	move.l	4(a2),d0
	and.l	#4,d0
	beq.b	L404
L401
	move.l	$10(a2),a0
	cmp.w	#0,a0
	beq.b	L404
L402
;		delete pixDesc;
	move.l	$10(a2),a0
	cmp.w	#0,a0
	beq.b	L404
L403
	pea	$C.w
	move.l	a0,-(a7)
	jsr	op__delete__PvUi
	addq.w	#$8,a7
L404
;	properties = 0;
	clr.l	4(a2)
;	data = 0;
	clr.l	$8(a2)
;	palette = 0;
	clr.l	$C(a2)
;	pixDesc = 0;
	clr.l	$10(a2)
;	palSize	= 0;
	clr.w	$18(a2)
;	width = height = 0;
	clr.w	2(a2)
	clr.w	(a2)
;	pixFormat = Pixel::INDEX8;
	clr.l	$14(a2)
	move.l	(a7)+,a2
	rts

	SECTION "setIBData__ImageBufferProvider__P11ImageBufferPvs:0",CODE


;void ImageBufferProvider::setIBData(ImageBuffer* img, void* data, bo
	XDEF	setIBData__ImageBufferProvider__P11ImageBufferPvs
setIBData__ImageBufferProvider__P11ImageBufferPvs
	movem.l	d2/a2/a3,-(a7)
	movem.l	$10(a7),a2/a3
	move.w	$18(a7),d2
L405
;	if (!img) 
	cmp.w	#0,a2
	bne.b	L407
L406
;	if (!img) return;
	movem.l	(a7)+,d2/a2/a3
	rts
L407
;	if (img->data && (img->properties & ImageBuffer::OWN_DATA))
	tst.l	$8(a2)
	beq.b	L410
L408
	move.l	4(a2),d0
	and.l	#1,d0
	beq.b	L410
L409
;		Mem::free(img->data);
	move.l	$8(a2),-(a7)
	jsr	free__Mem__Pv
	addq.w	#4,a7
;		img->properties &= ~ImageBuffer::OWN_DATA;
	and.l	#-2,4(a2)
L410
;	img->data = data;
	move.l	a3,$8(a2)
;	if (setOwn)
	tst.w	d2
	beq.b	L412
L411
;		img->properties |= ImageBuffer::OWN_DATA;
	or.l	#1,4(a2)
L412
	movem.l	(a7)+,d2/a2/a3
	rts

	SECTION "setIBPalette__ImageBufferProvider__P11ImageBufferP07Palettes:0",CODE


;void ImageBufferProvider::setIBPalette(ImageBuffer* img, Palette* pa
	XDEF	setIBPalette__ImageBufferProvider__P11ImageBufferP07Palettes
setIBPalette__ImageBufferProvider__P11ImageBufferP07Palettes
	movem.l	d2/a2/a3,-(a7)
	movem.l	$10(a7),a2/a3
	move.w	$18(a7),d2
L413
;	if (!img) 
	cmp.w	#0,a2
	bne.b	L415
L414
;	if (!img) return;
	movem.l	(a7)+,d2/a2/a3
	rts
L415
;	if (img->palette && (img->properties & ImageBuffer::OWN_PALETTE))
	tst.l	$C(a2)
	beq.b	L418
L416
	move.l	4(a2),d0
	and.l	#2,d0
	beq.b	L418
L417
;		Mem::free(img->palette);
	move.l	$C(a2),-(a7)
	jsr	free__Mem__Pv
	addq.w	#4,a7
;		img->properties &= ~ImageBuffer::OWN_PALETTE;
	and.l	#-3,4(a2)
L418
;	img->palette = pal;
	move.l	a3,$C(a2)
;	if (setOwn)
	tst.w	d2
	beq.b	L420
L419
;		img->properties |= ImageBuffer::OWN_PALETTE;
	or.l	#2,4(a2)
L420
	movem.l	(a7)+,d2/a2/a3
	rts

	SECTION "_modesAvail__DisplayPropertiesProvider:1",DATA

	XDEF	_modesAvail__DisplayPropertiesProvider
_modesAvail__DisplayPropertiesProvider
	dc.l	0

	SECTION "_numModes__DisplayPropertiesProvider:1",DATA

	XDEF	_numModes__DisplayPropertiesProvider
_numModes__DisplayPropertiesProvider
	dc.l	0

	SECTION "createModeDatabase__DisplayPropertiesProvider__Ui:0",CODE


;D_PRP* DisplayPropertiesProvider::createModeDatabase(size_t n)
	XDEF	createModeDatabase__DisplayPropertiesProvider__Ui
createModeDatabase__DisplayPropertiesProvider__Ui
	move.l	d2,-(a7)
	move.l	$8(a7),d2
L424
;	if (!modesAvail)
	tst.l	_modesAvail__DisplayPropertiesProvider
	bne.b	L428
L425
;		void* p = Mem::alloc(n*sizeof(D_PRP), true);
	clr.l	-(a7)
	move.w	#1,-(a7)
	move.l	d2,d0
	moveq	#6,d1
	asl.l	d1,d0
	move.l	d0,-(a7)
	jsr	alloc__Mem__UisE
	add.w	#$A,a7
	move.l	d0,a0
;		if (p)
	cmp.w	#0,a0
	beq.b	L427
L426
;			numModes = n;
	move.l	d2,_numModes__DisplayPropertiesProvider
;			modesAvail = (D_PRP*)p;
	move.l	a0,_modesAvail__DisplayPropertiesProvider
	bra.b	L428
L427
;			numModes = 0;
	clr.l	_numModes__DisplayPropertiesProvider
;			return 0;
	moveq	#0,d0
	move.l	(a7)+,d2
	rts
L428
;	setTiming(0, 1, 1);
	pea	1.w
	pea	1.w
	clr.l	-(a7)
	jsr	setTiming__DisplayPropertiesProvider__UiUjUj
	add.w	#$C,a7
;	setDimension(0, 320, 240);
	move.w	#$F0,-(a7)
	move.w	#$140,-(a7)
	clr.l	-(a7)
	jsr	setDimension__DisplayPropertiesProvider__Uiss
	addq.w	#$8,a7
;	setPropertyFlags(0, D_PRP::WINDOWMODE);
	move.w	#$AAC3,-(a7)
	clr.l	-(a7)
	jsr	setPropertyFlags__DisplayPropertiesProvider__UiUs
	addq.w	#6,a7
;	setFormat(0, Pixel::MAXHWTYPES);
	clr.l	-(a7)
	pea	$F.w
	clr.l	-(a7)
	jsr	setFormat__DisplayPropertiesProvider__UiEE
	add.w	#$C,a7
;	setName(0, "Windowed");
	move.l	#L423,-(a7)
	clr.l	-(a7)
	jsr	setName__DisplayPropertiesProvider__UiPCc
	addq.w	#$8,a7
;	return modesAvail;
	move.l	_modesAvail__DisplayPropertiesProvider,d0
	move.l	(a7)+,d2
	rts

L423
	dc.b	'Windowed',0

	SECTION "freeModeDatabase__DisplayPropertiesProvider_:0",CODE


;void DisplayPropertiesProvider::freeModeDatabase()
	XDEF	freeModeDatabase__DisplayPropertiesProvider_
freeModeDatabase__DisplayPropertiesProvider_
L429
;	if (modesAvail)
	tst.l	_modesAvail__DisplayPropertiesProvider
	beq.b	L431
L430
;		Mem::free(modesAvail);
	move.l	_modesAvail__DisplayPropertiesProvider,-(a7)
	jsr	free__Mem__Pv
	addq.w	#4,a7
L431
;	modesAvail = 0;
	clr.l	_modesAvail__DisplayPropertiesProvider
;	numModes = 0;
	clr.l	_numModes__DisplayPropertiesProvider
	rts

	SECTION "getMode__DisplayPropertiesProvider__Ui:0",CODE


;D_PRP* DisplayPropertiesProvider::getMode(size_t n)
	XDEF	getMode__DisplayPropertiesProvider__Ui
getMode__DisplayPropertiesProvider__Ui
	move.l	4(a7),d0
L432
;	if (modesAvail && n < numModes)
	tst.l	_modesAvail__DisplayPropertiesProvider
	beq.b	L435
L433
	cmp.l	_numModes__DisplayPropertiesProvider,d0
	bhs.b	L435
L434
;		return &modesAvail[n];
	asl.l	#6,d0
	add.l	_modesAvail__DisplayPropertiesProvider,d0
	rts
L435
;	return 0;
	moveq	#0,d0
	rts

	SECTION "setModeIndex__DisplayPropertiesProvider__UiUj:0",CODE


;bool DisplayPropertiesProvider::setModeIndex(size_t i,uint32 val)
	XDEF	setModeIndex__DisplayPropertiesProvider__UiUj
setModeIndex__DisplayPropertiesProvider__UiUj
	move.l	d2,-(a7)
	movem.l	$8(a7),d0/d1
L436
;	if (modesAvail && i < numModes)
	tst.l	_modesAvail__DisplayPropertiesProvider
	beq.b	L439
L437
	cmp.l	_numModes__DisplayPropertiesProvider,d0
	bhs.b	L439
L438
;		modesAvail[i].modeIndex = val;
	asl.l	#6,d0
	move.l	_modesAvail__DisplayPropertiesProvider,a1
	move.l	d1,4(a1,d0.l)
;		return true;
	moveq	#1,d0
	move.l	(a7)+,d2
	rts
L439
;	return false;
	moveq	#0,d0
	move.l	(a7)+,d2
	rts

	SECTION "setTiming__DisplayPropertiesProvider__UiUjUj:0",CODE


;bool DisplayPropertiesProvider::setTiming(size_t i, uint32 h, uint32
	XDEF	setTiming__DisplayPropertiesProvider__UiUjUj
setTiming__DisplayPropertiesProvider__UiUjUj
	movem.l	d2/d3,-(a7)
	movem.l	$C(a7),d0/d2
	move.l	$14(a7),d1
L440
;	if (modesAvail && i < numModes)
	tst.l	_modesAvail__DisplayPropertiesProvider
	beq.b	L443
L441
	cmp.l	_numModes__DisplayPropertiesProvider,d0
	bhs.b	L443
L442
;		modesAvail[i].horizRefreshNanoSec = h;
	move.l	d0,d3
	asl.l	#6,d3
	move.l	_modesAvail__DisplayPropertiesProvider,a1
	move.l	d2,$8(a1,d3.l)
;		modesAvail[i].vertRefreshMicroSec = v;
	asl.l	#6,d0
	move.l	_modesAvail__DisplayPropertiesProvider,a1
	move.l	d1,$C(a1,d0.l)
;		return true;
	moveq	#1,d0
	movem.l	(a7)+,d2/d3
	rts
L443
;	return false;
	moveq	#0,d0
	movem.l	(a7)+,d2/d3
	rts

	SECTION "setDimension__DisplayPropertiesProvider__Uiss:0",CODE


;bool DisplayPropertiesProvider::setDimension(size_t i, S_WH)
	XDEF	setDimension__DisplayPropertiesProvider__Uiss
setDimension__DisplayPropertiesProvider__Uiss
	movem.l	d2/d3,-(a7)
	move.l	$C(a7),d0
	move.w	$12(a7),d1
	move.w	$10(a7),d2
L444
;	if (modesAvail && i < numModes)
	tst.l	_modesAvail__DisplayPropertiesProvider
	beq.b	L447
L445
	cmp.l	_numModes__DisplayPropertiesProvider,d0
	bhs.b	L447
L446
;		modesAvail[i].width = w;
	move.l	d0,d3
	asl.l	#6,d3
	move.l	_modesAvail__DisplayPropertiesProvider,a1
	move.w	d2,0(a1,d3.l)
;		modesAvail[i].height = h;
	move.l	d0,d3
	asl.l	#6,d3
	move.l	_modesAvail__DisplayPropertiesProvider,a1
	move.w	d1,2(a1,d3.l)
;		modesAvail[i].aspect = ((float32)h/(float32)w)/0.75;
	ext.l	d1
	fmove.l	d1,fp0
	move.w	d2,d1
	ext.l	d1
	fmove.l	d1,fp1
	fdiv.x	fp1,fp0
	fdiv.d	#$.3FE7FFFF.FFFFFFFF,fp0
	asl.l	#6,d0
	move.l	_modesAvail__DisplayPropertiesProvider,a1
	fmove.s	fp0,$10(a1,d0.l)
;		return true;
	moveq	#1,d0
	movem.l	(a7)+,d2/d3
	rts
L447
;	return false;
	moveq	#0,d0
	movem.l	(a7)+,d2/d3
	rts

	SECTION "setAspect__DisplayPropertiesProvider__Uif:0",CODE


;bool DisplayPropertiesProvider::setAspect(size_t i, float32 a)
	XDEF	setAspect__DisplayPropertiesProvider__Uif
setAspect__DisplayPropertiesProvider__Uif
	move.l	4(a7),d0
	fmove.s	$8(a7),fp0
L448
;	if (modesAvail && i < numModes)
	tst.l	_modesAvail__DisplayPropertiesProvider
	beq.b	L451
L449
	cmp.l	_numModes__DisplayPropertiesProvider,d0
	bhs.b	L451
L450
;		modesAvail[i].aspect = a;
	asl.l	#6,d0
	move.l	_modesAvail__DisplayPropertiesProvider,a1
	fmove.s	fp0,$10(a1,d0.l)
;		return true;
	moveq	#1,d0
	rts
L451
;	return false;
	moveq	#0,d0
	rts

	SECTION "setPropertyFlags__DisplayPropertiesProvider__UiUs:0",CODE


;bool DisplayPropertiesProvider::setPropertyFlags(size_t i, uint16 f)
	XDEF	setPropertyFlags__DisplayPropertiesProvider__UiUs
setPropertyFlags__DisplayPropertiesProvider__UiUs
	move.l	d2,-(a7)
	move.w	$C(a7),d0
	move.l	$8(a7),d1
L452
;	if (modesAvail && i < numModes)
	tst.l	_modesAvail__DisplayPropertiesProvider
	beq.b	L455
L453
	cmp.l	_numModes__DisplayPropertiesProvider,d1
	bhs.b	L455
L454
;		modesAvail[i].properties = f;
	and.l	#$FFFF,d0
	asl.l	#6,d1
	move.l	_modesAvail__DisplayPropertiesProvider,a1
	move.l	d0,$14(a1,d1.l)
;		return true;
	moveq	#1,d0
	move.l	(a7)+,d2
	rts
L455
;	return false;
	moveq	#0,d0
	move.l	(a7)+,d2
	rts

	SECTION "setFormat__DisplayPropertiesProvider__UiEE:0",CODE


;bool DisplayPropertiesProvider::setFormat(size_t i, P_F f, P_D d)
	XDEF	setFormat__DisplayPropertiesProvider__UiEE
setFormat__DisplayPropertiesProvider__UiEE
	movem.l	d2/d3,-(a7)
	move.l	$14(a7),d0
	move.l	$C(a7),d1
	move.l	$10(a7),d2
L456
;	if (modesAvail && i < numModes)
	tst.l	_modesAvail__DisplayPropertiesProvider
	beq	L467
L457
	cmp.l	_numModes__DisplayPropertiesProvider,d1
	bhs	L467
L458
;		modesAvail[i].pixFormat = f;
	move.l	d1,d3
	asl.l	#6,d3
	move.l	_modesAvail__DisplayPropertiesProvider,a1
	move.l	d2,$1C(a1,d3.l)
;		if (d==Pixel::BPPUNK)
	tst.l	d0
	bne.b	L466
L459
;			switch (f)
	cmp.l	#$E,d2
	bhi.b	L465
	move.l	L468(pc,d2.l*4),a0
	jmp	(a0)
L468
	dc.l	L460
	dc.l	L461
	dc.l	L461
	dc.l	L461
	dc.l	L461
	dc.l	L462
	dc.l	L462
	dc.l	L462
	dc.l	L462
	dc.l	L463
	dc.l	L463
	dc.l	L464
	dc.l	L464
	dc.l	L464
	dc.l	L464
;				
L460
;				case Pixel::INDEX8:	d = Pixel::BPP8;
	moveq	#$8,d0
; 
	bra.b	L466
L461
;				case Pixel::BGR15L:	d = Pixel::BPP15;
	moveq	#$F,d0
; 
	bra.b	L466
L462
;				case Pixel::BGR16L:	d = Pixel::BPP16;
	moveq	#$10,d0
; 
	bra.b	L466
L463
;				case Pixel::BGR24P:	d = Pixel::BPP24;
	moveq	#$18,d0
; 
	bra.b	L466
L464
;				case Pixel::ARGB32L:d = Pixel::BPP32;
	moveq	#$20,d0
; 
L465
;				default: 
L466
;		modesAvail[i].depth = d;
	asl.l	#6,d1
	move.l	_modesAvail__DisplayPropertiesProvider,a1
	move.l	d0,$18(a1,d1.l)
;		return true;
	moveq	#1,d0
	movem.l	(a7)+,d2/d3
	rts
L467
;	return false;
	moveq	#0,d0
	movem.l	(a7)+,d2/d3
	rts

	SECTION "setName__DisplayPropertiesProvider__UiPCc:0",CODE


;bool DisplayPropertiesProvider::setName(size_t i, const char* title)
	XDEF	setName__DisplayPropertiesProvider__UiPCc
setName__DisplayPropertiesProvider__UiPCc
	movem.l	4(a7),d0/a0
L469
;	if (modesAvail && i < numModes)
	tst.l	_modesAvail__DisplayPropertiesProvider
	beq.b	L472
L470
	cmp.l	_numModes__DisplayPropertiesProvider,d0
	bhs.b	L472
L471
;		strncpy(modesAvail[i].name, title, 31);
	pea	$1F.w
	move.l	a0,-(a7)
	asl.l	#6,d0
	move.l	_modesAvail__DisplayPropertiesProvider,a1
	lea	0(a1,d0.l),a0
	pea	$20(a0)
	jsr	_strncpy
	add.w	#$C,a7
;		return true;
	moveq	#1,d0
	rts
L472
;	return false;
	moveq	#0,d0
	rts

	SECTION "findIndex__DisplayPropertiesProvider__ssEs:0",CODE


;size_t DisplayPropertiesProvider::findIndex(S_WHD, bool exact)
	XDEF	findIndex__DisplayPropertiesProvider__ssEs
findIndex__DisplayPropertiesProvider__ssEs
	movem.l	d2-d5,-(a7)
	move.w	$1C(a7),d1
	move.l	$18(a7),d3
	move.w	$16(a7),d4
	move.w	$14(a7),d5
L473
;	sint32 found = 0;
	moveq	#0,d0
;	if (exact)
	tst.w	d1
	beq.b	L484
L474
;		sint32 m = 0;
	moveq	#0,d1
;		while (++m < numModes && found == 0)
	bra.b	L481
L475
;			found = ((modesAvail[m].getW() == w) &&
	move.l	d1,d0
	asl.l	#6,d0
	move.l	_modesAvail__DisplayPropertiesProvider,a1
	move.w	0(a1,d0.l),d2
	ext.l	d2
	move.w	d5,d0
	ext.l	d0
	cmp.l	d0,d2
	bne.b	L479
L476
	move.l	d1,d0
	asl.l	#6,d0
	move.l	_modesAvail__DisplayPropertiesProvider,a1
	move.w	2(a1,d0.l),d2
	ext.l	d2
	move.w	d4,d0
	ext.l	d0
	cmp.l	d0,d2
	bne.b	L479
L477
	move.l	d1,d0
	asl.l	#6,d0
	move.l	_modesAvail__DisplayPropertiesProvider,a1
	move.l	$18(a1,d0.l),d0
	cmp.l	d3,d0
	bne.b	L479
L478
	move.l	d1,d0
	bra.b	L480
L479
	moveq	#0,d0
L480
L481
	addq.l	#1,d1
	cmp.l	_numModes__DisplayPropertiesProvider,d1
	bge.b	L483
L482
	tst.l	d0
	beq.b	L475
L483
	bra.b	L493
L484
;		sint32 m = 0;
	moveq	#0,d1
;		while (++m < numModes && found == 0)
	bra.b	L491
L485
;			found = ((modesAvail[m].getW() >= w) &&
	move.l	d1,d0
	asl.l	#6,d0
	move.l	_modesAvail__DisplayPropertiesProvider,a1
	move.w	0(a1,d0.l),d2
	ext.l	d2
	move.w	d5,d0
	ext.l	d0
	cmp.l	d0,d2
	blt.b	L489
L486
	move.l	d1,d0
	asl.l	#6,d0
	move.l	_modesAvail__DisplayPropertiesProvider,a1
	move.w	2(a1,d0.l),d2
	ext.l	d2
	move.w	d4,d0
	ext.l	d0
	cmp.l	d0,d2
	blt.b	L489
L487
	move.l	d1,d0
	asl.l	#6,d0
	move.l	_modesAvail__DisplayPropertiesProvider,a1
	move.l	$18(a1,d0.l),d0
	cmp.l	d3,d0
	blt.b	L489
L488
	move.l	d1,d0
	bra.b	L490
L489
	moveq	#0,d0
L490
L491
	addq.l	#1,d1
	cmp.l	_numModes__DisplayPropertiesProvider,d1
	bge.b	L493
L492
	tst.l	d0
	beq.b	L485
L493
;	return found;
	movem.l	(a7)+,d2-d5
	rts

	END
