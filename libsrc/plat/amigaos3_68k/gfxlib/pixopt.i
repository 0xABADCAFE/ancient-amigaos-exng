;//****************************************************************************//
;//**                                                                        **//
;//** File:         libsrc/plat/amigaos3_68k/gfxlib/pixopt.i                 **//
;//** Description:  Optimised conversion routines                            **//
;//** Comment(s):                                                            **//
;//** Library:      gfxlib                                                   **//
;//** Created:      2003-02-09                                               **//
;//** Updated:      2003-02-09                                               **//
;//** Author(s):    Karl Churchill                                           **//
;//** Note(s):                                                               **//
;//** Copyright:    (C)1996-2003, eXtropia Studios                           **//
;//**               Serkan YAZICI, Karl Churchill                            **//
;//**               All Rights Reserved.                                     **//
;//**                                                                        **//
;//****************************************************************************//

	mc68020

;// Argument offsets 

;arg_srcSpan	EQU	22
;arg_dstSpan	EQU	20
;arg_h			EQU	18
;arg_w			EQU	16
;arg_srcPal	EQU	12
;arg_src		EQU	8
;arg_dst		EQU	4
;_rtsaddr		EQU	0

;// stack 32-bit aligned with gcc calls...

arg_srcSpan	EQU	28
arg_dstSpan	EQU	24
arg_h			EQU	20
arg_w			EQU	16
arg_srcPal	EQU	12
arg_src		EQU	8
arg_dst		EQU	4
_rtsaddr		EQU	0

arg_base		EQU	20	;// sizeof d2+d3+d4+d5+d6

;///////////////////////////////////////////////////////////////////////////////

	XREF	swap16__Mem__r8Pvr9Pvr0Ui
	XREF	swap32__Mem__r8Pvr9Pvr0Ui
	XREF	copy__Mem__r8Pvr9Pvr0Ui

;///////////////////////////////////////////////////////////////////////////////

	MACRO INIT
	movem.l	d2-d6,	-(a7)
	move.l	arg_base+arg_dst(a7),		a0
	move.l	arg_base+arg_src(a7),		a1
	;move.w	arg_base+arg_w(a7),			d4
	;move.w	arg_base+arg_h(a7),			d5
	;move.w	arg_base+arg_dstSpan(a7),	d2
	;move.w	arg_base+arg_srcSpan(a7),	d3

	; stack aligned with gcc
	move.w	2+arg_base+arg_w(a7),			d4
	move.w	2+arg_base+arg_h(a7),			d5
	move.w	2+arg_base+arg_dstSpan(a7),	d2
	move.w	2+arg_base+arg_srcSpan(a7),	d3

	sub.w		d4,		d2	; // dstMod
	sub.w		d4,		d3	; // srcMod
	ENDM

	MACRO INITX
	movem.l	d2-d6,	-(a7)
	move.l	arg_base+arg_dst(a7),		a0
	move.l	arg_base+arg_src(a7),		a1

	;move.l	arg_base+arg_w(a7),			d2	;// d2 = w:h
	;move.l	arg_base+arg_dstSpan(a7),	d3	;// d3 = dSpan:sSpan

	; stack aligned with gcc
	move.w	2+arg_base+arg_w(a7),			d2
	swap		d2
	move.w	2+arg_base+arg_h(a7),			d2
	move.w	2+arg_base+arg_dstSpan(a7),	d3
	swap		d3
	move.w	2+arg_base+arg_srcSpan(a7),	d3

	swap		d2										;// d2 = h:w
	sub.w		d2,		d3							;// d3 = dSpan:sMod
	swap		d3										;// d3 = sMod:dSpan
	sub.w		d2,		d3							;// d3 = sMod:dMod
	swap		d2										;// d2 = w:h
	ENDM

	MACRO DONEX
	movem.l	(a7)+,	d2-d6
	ENDM

;///////////////////////////////////////////////////////////////////////////////

	MACRO DONE
	movem.l	(a7)+,	d2-d6
	ENDM

;///////////////////////////////////////////////////////////////////////////////

	MACRO CLR_SCRATCH
	moveq		#0,		d0
	moveq		#0,		d1
	ENDM

;///////////////////////////////////////////////////////////////////////////////

	MACRO SWP16
	;// 16-bit endian swap
										;// X.w = -------- -------- aaaaaaaa bbbbbbbb
	rol.w		#8,			\1		;// X.w = -------- -------- bbbbbbbb aaaaaaaa
	ENDM

;///////////////////////////////////////////////////////////////////////////////

	MACRO SWP32
	;// 32-bit endian swap
										;// X.w = aaaaaaaa bbbbbbbb cccccccc dddddddd
	rol.w		#8,			\1		;// X.l = aaaaaaaa bbbbbbbb dddddddd cccccccc
	swap		\1						;// X.l = dddddddd cccccccc aaaaaaaa bbbbbbbb
	rol.w		#8,			\1		;// X.l = dddddddd cccccccc bbbbbbbb aaaaaaaa
	ENDM

;///////////////////////////////////////////////////////////////////////////////

	MACRO SWP16_X2
	;// 2x16-bit endian swap
										;// X.w = aaaaaaaa bbbbbbbb cccccccc dddddddd
	SWP32	\1							;// X.l = dddddddd cccccccc bbbbbbbb aaaaaaaa
	swap	\1							;// X.l = bbbbbbbb aaaaaaaa dddddddd cccccccc
	ENDM	

;///////////////////////////////////////////////////////////////////////////////

	MACRO COPYNORMAL
	INIT
	cmp.l		a0,		a1
	bne.b		.checkBlockConvert
	DONE
	rts

.checkBlockConvert
	;// if dstMod == srcMod == 0, perform single block copy
	tst.w		d2
	bne.b		.convertScanlines		
	tst.w		d3
	bne.b		.convertScanlines
	
.blockConvert
	;// Mem::copy(dst, src, (w*h)<<N)
	mulu		d4,		d5
	move.l	d5,		d0
	lsl.l		#\1,		d0
	jsr		copy__Mem__r8Pvr9Pvr0Ui
	DONE
	rts
		
.convertScanlines
	;// restore spans
	add.w		d4,		d2
	add.w		d4,		d3
	;// a0/a1 are volatile so put in a2/a3
	movem.l	a2/a3,	-(a7)
	move.l	a0,		a2
	move.l	a1,		a3
	;// scale w/srcSpan/dstSpan to match pointer size
	lsl.w		#\1,		d4	;
	lsl.w		#\1,		d2	; // d2 = dstSpan
	lsl.w		#\1,		d3	; // d3 = srcSpan
	bra.b		.scanlineLoopTest
	
.scanlineLoop
	;// Mem::copy(dst, src, w)
	move.l	a2,		a0
	move.l	a3,		a1
	moveq		#0,		d0
	move.w	d4,		d0
	jsr		copy__Mem__r8Pvr9Pvr0Ui
	add.w		d2,		a2
	add.w		d3,		a3
	
.scanlineLoopTest
	dbra		d5,		.scanlineLoop

.finished
	movem.l	(a7)+,	a2/a3
	DONE
	ENDM

;///////////////////////////////////////////////////////////////////////////////
	
	MACRO COPYSWAP16
	INIT
	;// if dstMod == srcMod == 0, perform single block copy
	tst.w		d2
	bne.b		.convertScanlines		
	tst.w		d3
	bne.b		.convertScanlines
	
.blockConvert	
	;// Mem::swap16(dst, src, w*h)
	mulu		d4,		d5
	move.l	d5,		d0
	jsr		swap16__Mem__r8Pvr9Pvr0Ui
	DONE
	rts
	
.convertScanlines
	;// restore spans
	add.w		d4,		d2
	add.w		d4,		d3
	
	;// a0/d1 are volatile so put in a2/a3
	movem.l	a2/a3, -(a7)
	move.l	a0,		a2
	move.l	a1,		a3

	;// scale srcSpan/dstSpan to match pointer size (uint16*)
	lsl.w		#1,		d2
	lsl.w		#1,		d3
	bra.b		.scanlineLoopTest
	
.scanlineLoop
	;// Mem::swap16(dst, src, w)
	move.l	a2,		a0
	move.l	a3,		a1
	moveq		#0,		d0
	move.w	d4,		d0
	jsr		swap16__Mem__r8Pvr9Pvr0Ui
	;// (uint16*)dst += dstSpan; (uint16*)src += srcSpan
	add.w		d2,		a2
	add.w		d3,		a3
	
.scanlineLoopTest
	dbra		d5,		.scanlineLoop

.finished
	movem.l	(a7)+, a2/a3
	DONE
	ENDM
	
;///////////////////////////////////////////////////////////////////////////////
	
	MACRO COPYSWAP32
	INIT
	;// if dstMod == srcMod == 0, perform single block copy
	tst.w		d2
	bne.b		.convertScanlines		
	tst.w		d3
	bne.b		.convertScanlines
	
.blockConvert	
	;// Mem::swap32(dst, src, w*h)
	mulu		d4,		d5
	move.l	d5,		d0
	jsr		swap32__Mem__r8Pvr9Pvr0Ui
	DONE
	rts
	
.convertScanlines
	;// restore spans
	add.w		d4,		d2
	add.w		d4,		d3

	;// a0/a1 are volatile so put in a2/a3
	movem.l	a2/a3, -(a7)
	move.l	a0,		a2
	move.l	a1,		a3

	;// scale srcSpan/dstSpan to match pointer size (uint32*)
	lsl.w		#2,		d2
	lsl.w		#2,		d3
	bra.b		.scanlineLoopTest
	
.scanlineLoop
	;// Mem::swap32(dst, src, w)
	move.l	a2,		a0
	move.l	a3,		a1
	moveq		#0,		d0
	move.w	d4,		d0
	jsr		swap32__Mem__r8Pvr9Pvr0Ui
	add.w		d2,		a2
	add.w		d3,		a3
	
.scanlineLoopTest
	dbra		d5,		.scanlineLoop

.finished
	movem.l	(a7)+, a2/a3
	DONE
	ENDM

;///////////////////////////////////////////////////////////////////////////////
	
	MACRO	COPYNORMAL24
	INIT
	;// if src == dst, return
	cmp.l		a0,		a1
	bne.b		.checkBlockConvert
	DONE
	rts

.checkBlockConvert
	;// if dstMod == srcMod == 0, perform single block copy
	tst.w		d2
	bne.b		.convertScanlines		
	tst.w		d3
	bne.b		.convertScanlines
	
.blockConvert
	;// Mem::copy(dst, src, (w*h)*3)
	mulu		d4,		d5
	move.l	d4,		d0
	lsl.l		#1,		d0
	add.l		d5,		d0
	jsr		copy__Mem__r8Pvr9Pvr0Ui
	DONE
	rts
	
.convertScanlines
	;// a0/d1 are volatile so put in a2/a3
	movem.l	a2/a3, -(a7)
	move.l	a0,		a2
	move.l	a1,		a3
	;// clean up d0
	moveq		#0,		d0
	;// w*=3;
	move.w	d4,		d0
	lsl.w		#1,		d0
	add.w		d0,		d4
	;// dstSpan*=3
	move.w	d2,		d0
	lsl.w		#1,		d2
	add.w		d0,		d2
	;// srcSpan*=3	
	move.w	d3,		d0
	lsl.w		#1,		d3
	add.w		d0,		d3
	bra.b		.loopTest
	
.convertLoop
	;// Mem::copy(dst, src, w)
	move.l	a2,		a0
	move.l	a3,		a1
	move.w	d4,		d0
	jsr		copy__Mem__r8Pvr9Pvr0Ui
	add.w		d2,		a2
	add.w		d3,		a3
	
.loopTest
	dbra		d5,		.convertLoop

.finished
	movem.l	(a7)+, a2/a3
	DONE
	ENDM
	