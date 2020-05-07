;//****************************************************************************//
;//**                                                                        **//
;//** File:         readmem.asm                                              **//
;//** Description:  Simple read code to test memory read bandwidth           **//
;//** Comment(s):   Direct conversion of Mem::zero()                         **//
;//** Created:      2004-02-02                                               **//
;//** Updated:      2004-02-02                                               **//
;//** Author(s):    Karl Churchill                                           **//
;//** Copyright:    (C)1996-2004, eXtropia Studios                           **//
;//**               Serkan YAZICI, Karl Churchill                            **//
;//**               All Rights Reserved.                                     **//
;//**                                                                        **//
;//****************************************************************************//

	mc68040

	XDEF	readMem__GfxTestApp
	XDEF	copyMem16__GfxTestApp
	XDEF	shuffleCopy16__GfxTestApp
	XDEF  set16__GfxTestApp
	
	SECTION "read:0",CODE


;////////////////////////////////////////////////////////////////////////////////
;//
;//  void GfxTestApp::readMem([a0]void* dst, [d0]size_t len)
;//
;//  Basically only performs longword read estimation, a len of < 4 is ignored
;//
;////////////////////////////////////////////////////////////////////////////////

	CNOP 0,	4

readMem__GfxTestApp
	cmp.l		#63,		d0
	bgt.b		read_Align32
	rts
	
read_Align32
	;// Ensure start and length are nicely aligned and are
	;// inside the original memory area to avoid illegal access
	moveq		#3,		d1
	add.l		d1,		a0
	sub.l		d1,		d0
	not.l		d1
	and.l		d1,		d0	;// len = (len-3)&~3;
	;// and'ing to address reg not allowed
	exg		d0,		a0
	and.l		d1,		d0
	exg		d0,		a0 ;// src = (src+3)&~3;

read_Loop
	move.l	d0,		d1
	add.l		#60,		d0
	lsr.l		#2,		d1
	lsr.l		#6,		d0 ;// d0 = (len+60)>>6
	and.l		#15,		d1 ;// d1 = (len>>2)&15
	beq.b		.case0
	neg.w		d1
	add.w		#16,		d1
	jmp		.case0(pc, d1.w*2)

	CNOP	0, 8		
.case0	move.l	(a0)+,	d1
.case15	move.l	(a0)+,	d1
.case14	move.l	(a0)+,	d1
.case13	move.l	(a0)+,	d1
.case12	move.l	(a0)+,	d1
.case11	move.l	(a0)+,	d1
.case10	move.l	(a0)+,	d1
.case9	move.l	(a0)+,	d1
.case8	move.l	(a0)+,	d1
.case7	move.l	(a0)+,	d1
.case6	move.l	(a0)+,	d1
.case5	move.l	(a0)+,	d1
.case4	move.l	(a0)+,	d1
.case3	move.l	(a0)+,	d1
.case2	move.l	(a0)+,	d1
.case1	move.l	(a0)+,	d1

	subq.l	#1,		d0
	bgt.b		.case0

	rts


	CNOP 0,	4

;////////////////////////////////////////////////////////////////////////////////
;//
;//  void GfxTesApp::copyMem16([a0]void* dst, [a1]void* src, [d0]size_t len)
;//
;//  performs a test move16 based copy
;//  source and destination must be 16-byte aligned
;//
;////////////////////////////////////////////////////////////////////////////////

copyMem16__GfxTestApp
	move.l	d0,		d1
	add.l		#240,		d0
	lsr.l		#8,		d0 ;// d0 = (len+240)>>8
	lsr.l		#4,		d1
	and.l		#$F,		d1	;// d1 = (len>>4) & 15 (jump offset)
	beq		.case0
	neg.w		d1
	add.w		#16,		d1
	jmp		.case0(pc, d1.w*2)

	CNOP	0,8
.case0	move16	(a1)+,	(a0)+
.case15	move16	(a1)+,	(a0)+
.case14	move16	(a1)+,	(a0)+	
.case13	move16	(a1)+,	(a0)+
.case12	move16	(a1)+,	(a0)+
.case11	move16	(a1)+,	(a0)+
.case10	move16	(a1)+,	(a0)+
.case9	move16	(a1)+,	(a0)+
.case8	move16	(a1)+,	(a0)+
.case7	move16	(a1)+,	(a0)+
.case6	move16	(a1)+,	(a0)+
.case5	move16	(a1)+,	(a0)+
.case4	move16	(a1)+,	(a0)+
.case3	move16	(a1)+,	(a0)+
.case2	move16	(a1)+,	(a0)+
.case1
	subq.l	#1,		d0
	move16	(a1)+,	(a0)+ ;// wee optimisation since move16 doesnt affect CCR
	bgt.b		.case0
	rts

;////////////////////////////////////////////////////////////////////////////////
;//
;//
;////////////////////////////////////////////////////////////////////////////////

	CNOP	0,	4
shuffleCopy16__GfxTestApp
	lsr.l		#5,		d0 ;// d0 = len>>4
	beq		.end

	;// allocate an aligned area on the stack
	move.l	a3,			-(a7)
	link		a2,			#-96
	move.l	a7,			d1
	add.l		#31,			d1
	and.w		#$FFF0,		d1

.loop
	move.l	d1,		a3

	move.l	(a1)+,	(a3)
	move.l	(a1)+,	4(a3)
	move.l	(a1)+,	8(a3)
	move.l	(a1)+,	12(a3)
	move16	(a3)+,	(a0)+
	move.l	(a1)+,	(a3)
	move.l	(a1)+,	4(a3)
	move.l	(a1)+,	8(a3)
	move.l	(a1)+,	12(a3)
	subq.l	#1,		d0
	move16	(a3)+,	(a0)+

	bgt.b		.loop

	;// restore a2 and stack
	unlk		a2
	move.l	(a7)+,	a3
.end
	rts

;////////////////////////////////////////////////////////////////////////////////
;//
;//
;////////////////////////////////////////////////////////////////////////////////

	CNOP	0,	4
set16__GfxTestApp
	lsr.l		#6,		d1 ;// d0 = len>>4
	beq		.end

	move.l	d2,			-(a7)
	
	;// expand byte in d0 to fill 32-bit word (repeated)
	move.b	d0,			d2
	lsl.l		#8,			d2
	move.b	d0,			d2
	move.w	d2,			d0
	swap		d0
	move.w	d2,			d0

	;// allocate a cache aligned area on the stack
	link		a2,			#-128
	move.l	a7,			d2
	add.l		#31,			d2
	and.w		#$FFF0,		d2
	move.l	d2,			a1

	move.l	d0,			(a1)+
	move.l	d0,			(a1)+
	move.l	d0,			(a1)+
	move.l	d0,			(a1)+
	move.l	d0,			(a1)+
	move.l	d0,			(a1)+
	move.l	d0,			(a1)+
	move.l	d0,			(a1)+
	move.l	d0,			(a1)+
	move.l	d0,			(a1)+
	move.l	d0,			(a1)+
	move.l	d0,			(a1)+
	move.l	d0,			(a1)+
	move.l	d0,			(a1)+
	move.l	d0,			(a1)+
	move.l	d0,			(a1)+
	
	
	bra.b		.loop

	CNOP	0,	8
.loop
	;// each iteration copies the source 16-byte area from the stack
	;// to the destination. Since the source is continuously reset,
	;// the data stays in the cache. Therefore the end result is that
	;// the data is moved from the CPU cache to the destination using
	;// the move16.

	;// ensure cache line stays valid. Is there a better way?

	move.l	d2,			a1
	move16	(a1)+,		(a0)+
	move16	(a1)+,		(a0)+
	subq.l	#1,			d1
	move16	(a1)+,		(a0)+
	move16	(a1)+,		(a0)+
	bgt.b		.loop

	;// restore stack
	unlk		a2
	move.l	(a7)+,		d2
.end
	rts


;////////////////////////////////////////////////////////////////////////////////
;//
;//
;////////////////////////////////////////////////////////////////////////////////

	XDEF swapCopy32_16__GfxTestApp

	CNOP	0,	4
swapCopy32_16__GfxTestApp
	lsr.l		#4,		d0 ;// d0 = len>>4
	beq		.end

	;// allocate a cache aligned area on the stack
	move.l	d2,			-(a7)
	link		a2,			#-32
	move.l	a7,			d2
	add.l		#15,			d2
	and.l		#$FFFFFFF0,	d2

	bra.b		.loop

	CNOP	0,	8
.loop

	;// ensure cache line stays valid. Is there a better way?

	move.l	d2,			a7

	move.l	(a1)+,		d1
	rol.w		#8,			d1
	swap		d1
	rol.w		#8,			d1
	swap		d1
	move.l	d1,			(a7)

	move.l	(a1)+,		d1
	rol.w		#8,			d1
	swap		d1
	rol.w		#8,			d1
	swap		d1
	move.l	d1,			4(a7)
		
	move.l	(a1)+,		d1
	rol.w		#8,			d1
	swap		d1
	rol.w		#8,			d1
	swap		d1
	move.l	d1,			8(a7)
	
	move.l	(a1)+,		d1
	rol.w		#8,			d1
	swap		d1
	rol.w		#8,			d1
	swap		d1
	move.l	d1,			12(a7)

	subq.l	#1,			d0
	move16	(a7)+,		(a0)+
	bgt.b		.loop

	;// restore stack
	unlk		a2
	move.l	(a7)+,		d2
.end
	rts
	END
