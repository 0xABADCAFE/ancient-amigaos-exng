;//****************************************************************************//
;//**                                                                        **//
;//** File:         libsrc/plat/amigaos3_68k/gfxlib/pix24opt.asm             **//
;//** Description:  Optimised 24-bit pixel conversion routines               **//
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

	INCDIR  "exng:libsrc/plat/amigaos3_68k/gfxlib/"
	INCLUDE "pixopt.i"

	XDEF	copy24XGYTo15BE__Pix24__PvPvPUjssss
	XDEF	copy24XGYTo15LE__Pix24__PvPvPUjssss
	XDEF	rotate24XGYTo15BE__Pix24__PvPvPUjssss
	XDEF	rotate24XGYTo15LE__Pix24__PvPvPUjssss
	XDEF	copy24XGYTo16BE__Pix24__PvPvPUjssss
	XDEF	copy24XGYTo16LE__Pix24__PvPvPUjssss
	XDEF	rotate24XGYTo16BE__Pix24__PvPvPUjssss
	XDEF	rotate24XGYTo16LE__Pix24__PvPvPUjssss
	XDEF	copy24To24__Pix24__PvPvPUjssss
	XDEF	rotate24To24__Pix24__PvPvPUjssss
	XDEF	copy24XGYTo32BE__Pix24__PvPvPUjssss
	XDEF	copy24XGYTo32LE__Pix24__PvPvPUjssss
	XDEF	rotate24XGYTo32BE__Pix24__PvPvPUjssss
	XDEF	rotate24XGYTo32LE__Pix24__PvPvPUjssss

	MACRO XGYTO15
	move.b	(a1)+,	\1		;// dN.l = 00000000 00000000 00000000 xxxxxxxx
	lsl.l		#5,		\1		;// dN.l = 00000000 00000000 000xxxxx xxx00000
	move.b	(a1)+,	\1		;// dN.l = 00000000 00000000 000xxxxx gggggggg
	lsl.l		#5,		\1		;// dN.l = 00000000 000000xx xxxggggg ggg00000
	move.b	(a1)+,	\1		;// dN.l = 00000000 000000xx xxxggggg yyyyyyyy
	lsr.l		#2,		\1		;// dN.w = -------- -------- xxxxxggg ggyyyyyy
	lsr.w		#1,		\1		;// \1.w = -------- -------- 0xxxxxgg gggyyyyy
	ENDM

	MACRO YGXTO15
	move.b	2(a1),	\1		;// dN.l = 00000000 00000000 00000000 yyyyyyyy
	lsl.l		#5,		\1		;// dN.l = 00000000 00000000 000yyyyy yyy00000
	move.b	1(a1),	\1		;// dN.l = 00000000 00000000 000yyyyy gggggggg
	lsl.l		#5,		\1		;// dN.l = 00000000 000000yy yyyggggg ggg00000
	move.b	0(a1),	\1		;// dN.l = 00000000 000000yy yyyggggg xxxxxxxx
	lsr.l		#2,		\1		;// dN.w = -------- -------- yyyyyggg ggxxxxxx
	lsr.w		#1,		\1		;// dN.w = -------- -------- 0yyyyygg gggxxxxx	
	addq.w	#3,		a1
	ENDM
	
	MACRO XGYTO16
	move.b	(a1)+,	\1		;// dN.l = 00000000 00000000 00000000 xxxxxxxx
	lsl.l		#5,		\1		;// dN.l = 00000000 00000000 000xxxxx xxx00000
	move.b	(a1)+,	\1		;// dN.l = 00000000 00000000 000xxxxx gggggggg
	lsl.l		#6,		\1		;// dN.l = 00000000 00000xxx xxgggggg gg000000
	move.b	(a1)+,	\1		;// dN.l = 00000000 00000xxx xxgggggg yyyyyyyy
	lsr.l		#3,		\1		;// dN.w = -------- -------- xxxxxggg gggyyyyy	
	ENDM
	
	MACRO YGXTO16
	move.b	2(a1),	\1		;// dN.l = 00000000 00000000 00000000 yyyyyyyy
	lsl.l		#5,		\1		;// dN.l = 00000000 00000000 000yyyyy yyy00000
	move.b	1(a1),	\1		;// dN.l = 00000000 00000000 000yyyyy gggggggg
	lsl.l		#6,		\1		;// dN.l = 00000000 00000yyy yygggggg gg000000
	move.b	0(a1),	\1		;// dN.l = 00000000 00000yyy yygggggg xxxxxxxx
	lsr.l		#3,		\1		;// dN.w = -------- -------- yyyyyggg gggxxxxx
	addq.w	#3,		a1
	ENDM

	MACRO XTO15
	and.w		#$00F8,	d0
	lsl.w		#7,		d0
	ENDM

	MACRO GTO15
	and.w		#$00F8,	d0
	lsl.w		#3,		d0
	ENDM

	MACRO YTO15
	and.w		#$00F8,	d0
	lsr.w		#3,		d0
	ENDM

	MACRO XTO16
	and.w		#$00F8,	d0
	lsl.w		#8,		d0
	ENDM

	MACRO GTO16
	and.w		#$00FC,	d0
	lsl.w		#3,		d0
	ENDM

	MACRO YTO16
	and.w		#$00FC,	d0
	lsr.w		#3,		d0
	ENDM

	SECTION ":0", CODE

;///////////////////////////////////////////////////////////////////////////////
;//
;//  void Pix24::copy24XGYTo15BE
;//
;//  (void* dst, void* src, uint32* sPal, size_t w, size_t h, size_t dstSpan, size_t srcSpan)
;//
;///////////////////////////////////////////////////////////////////////////////

copy24XGYTo15BE__Pix24__PvPvPUjssss
	INIT
	move.w	d3,		d0
	lsl.w		#1,		d3
	add.w		d0,		d3
	lsl.w		#1,		d2
	bra.b		.scanlineLoopTest

.scanlineLoop
	move.w	d4,		d6
	lsr.w		#1,		d6
	bra.b		.pixelLoopTest

.pixelLoop
	XGYTO15	d0
	XGYTO15	d1
	swap		d0
	move.w	d1,		d0
	move.l	d0,		(a0)+

.pixelLoopTest
	dbra		d6,		.pixelLoop

.trailingPixel
	btst		#0,		d4
	beq.b		.pixelLoopDone
	XGYTO15	d0
	move.w	d0,		(a0)+

.pixelLoopDone
	add.w		d2,		a0
	add.w		d3,		a1

.scanlineLoopTest
	dbra		d5,		.scanlineLoop

.finished
	DONE
	rts


;///////////////////////////////////////////////////////////////////////////////
;//
;//  void Pix24::copy24XGYTo15LE
;//
;//  (void* dst, void* src, uint32* sPal, size_t w, size_t h, size_t dstSpan, size_t srcSpan)
;//
;///////////////////////////////////////////////////////////////////////////////

copy24XGYTo15LE__Pix24__PvPvPUjssss
	INIT
	move.w	d3,		d0
	lsl.w		#1,		d3
	add.w		d0,		d3
	lsl.w		#1,		d2
	bra.b		.scanlineLoopTest

.scanlineLoop
	move.w	d4,		d6
	lsr.w		#1,		d6
	bra.b		.pixelLoopTest

.pixelLoop
	XGYTO15	d0
	XGYTO15	d1
	SWP16		d0
	SWP16		d1
	swap		d0
	move.w	d1,		d0
	move.l	d0,		(a0)+

.pixelLoopTest
	dbra		d6,		.pixelLoop

.trailingPixel
	btst		#0,		d4
	beq.b		.pixelLoopDone
	XGYTO15	d0
	SWP16		d0
	move.w	d0,		(a0)+

.pixelLoopDone
	add.w		d2,		a0
	add.w		d3,		a1

.scanlineLoopTest
	dbra		d5,		.scanlineLoop

.finished
	DONE
	rts


;///////////////////////////////////////////////////////////////////////////////
;//
;//  void Pix24::rotate24XGYTo15BE
;//
;//  (void* dst, void* src, uint32* sPal, size_t w, size_t h, size_t dstSpan, size_t srcSpan)
;//
;///////////////////////////////////////////////////////////////////////////////

rotate24XGYTo15BE__Pix24__PvPvPUjssss
	INIT
	move.w	d3,		d0
	lsl.w		#1,		d3
	add.w		d0,		d3
	lsl.w		#1,		d2
	bra.b		.scanlineLoopTest

.scanlineLoop
	move.w	d4,		d6
	lsr.w		#1,		d6
	bra.b		.pixelLoopTest

.pixelLoop
	YGXTO15	d0
	YGXTO15	d1
	swap		d0
	move.w	d1,		d0
	move.l	d0,		(a0)+

.pixelLoopTest
	dbra		d6,		.pixelLoop

.trailingPixel
	btst		#0,		d4
	beq.b		.pixelLoopDone
	YGXTO15	d0
	move.w	d0,		(a0)+

.pixelLoopDone
	add.w		d2,		a0
	add.w		d3,		a1

.scanlineLoopTest
	dbra		d5,		.scanlineLoop

.finished
	DONE
	rts


;///////////////////////////////////////////////////////////////////////////////
;//
;//  void Pix24::rotate24XGYTo15LE
;//
;//  (void* dst, void* src, uint32* sPal, size_t w, size_t h, size_t dstSpan, size_t srcSpan)
;//
;///////////////////////////////////////////////////////////////////////////////

rotate24XGYTo15LE__Pix24__PvPvPUjssss
	INIT
	move.w	d3,		d0
	lsl.w		#1,		d3
	add.w		d0,		d3
	lsl.w		#1,		d2
	bra.b		.scanlineLoopTest

.scanlineLoop
	move.w	d4,		d6
	lsr.w		#1,		d6
	bra.b		.pixelLoopTest

.pixelLoop
	YGXTO15	d0
	YGXTO15	d1
	SWP16		d0
	SWP16		d1
	swap		d0
	move.w	d1,		d0
	move.l	d0,		(a0)+

.pixelLoopTest
	dbra		d6,		.pixelLoop

.trailingPixel
	btst		#0,		d4
	beq.b		.pixelLoopDone
	YGXTO15	d0
	SWP16		d0
	move.w	d0,		(a0)+

.pixelLoopDone
	add.w		d2,		a0
	add.w		d3,		a1

.scanlineLoopTest
	dbra		d5,		.scanlineLoop

.finished
	DONE
	rts


;///////////////////////////////////////////////////////////////////////////////
;//
;//  void Pix24::copy24XGYTo16BE
;//
;//  (void* dst, void* src, uint32* sPal, size_t w, size_t h, size_t dstSpan, size_t srcSpan)
;//
;///////////////////////////////////////////////////////////////////////////////

copy24XGYTo16BE__Pix24__PvPvPUjssss
	INIT
	move.w	d3,		d0
	lsl.w		#1,		d3
	add.w		d0,		d3
	lsl.w		#1,		d2
	bra.b		.scanlineLoopTest

.scanlineLoop
	move.w	d4,		d6
	lsr.w		#1,		d6
	bra.b		.pixelLoopTest

.pixelLoop
	XGYTO16	d0
	XGYTO16	d1
	swap		d0
	move.w	d1,		d0	
	move.l	d0,		(a0)+

.pixelLoopTest
	dbra		d6,		.pixelLoop

.trailingPixel
	btst		#0,		d4
	beq.b		.pixelLoopDone
	XGYTO16	d0
	move.w	d0,		(a0)+
	
.pixelLoopDone
	add.w		d2,		a0
	add.w		d3,		a1

.scanlineLoopTest
	dbra		d5,		.scanlineLoop

.finished
	DONE
	rts

;///////////////////////////////////////////////////////////////////////////////
;//
;//  void Pix24::copy24XGYTo16LE
;//
;//  (void* dst, void* src, uint32* sPal, size_t w, size_t h, size_t dstSpan, size_t srcSpan)
;//
;///////////////////////////////////////////////////////////////////////////////

copy24XGYTo16LE__Pix24__PvPvPUjssss
	INIT
	move.w	d3,		d0
	lsl.w		#1,		d3
	add.w		d0,		d3
	lsl.w		#1,		d2
	bra.b		.scanlineLoopTest

.scanlineLoop
	move.w	d4,		d6
	lsr.w		#1,		d6
	bra.b		.pixelLoopTest

.pixelLoop
	XGYTO16	d0
	XGYTO16	d1
	SWP16		d0
	SWP16		d1
	swap		d0
	move.w	d1,		d0	
	move.l	d0,		(a0)+

.pixelLoopTest
	dbra		d6,		.pixelLoop

.trailingPixel
	btst		#0,		d4
	beq.b		.pixelLoopDone
	XGYTO16	d0
	SWP16		D0
	move.w	d0,		(a0)+

.pixelLoopDone
	add.w		d2,		a0
	add.w		d3,		a1

.scanlineLoopTest
	dbra		d5,		.scanlineLoop

.finished
	DONE
	rts


;///////////////////////////////////////////////////////////////////////////////
;//
;//  void Pix24::rotate24XGYTo16BE
;//
;//  (void* dst, void* src, uint32* sPal, size_t w, size_t h, size_t dstSpan, size_t srcSpan)
;//
;///////////////////////////////////////////////////////////////////////////////

rotate24XGYTo16BE__Pix24__PvPvPUjssss
	INIT
	move.w	d3,		d0
	lsl.w		#1,		d3
	add.w		d0,		d3
	lsl.w		#1,		d2
	bra.b		.scanlineLoopTest

.scanlineLoop
	move.w	d4,		d6
	lsr.w		#1,		d6
	bra.b		.pixelLoopTest

.pixelLoop
	YGXTO16	d0
	YGXTO16	d1
	swap		d0
	move.w	d1,		d0
	move.l	d0,		(a0)+

.pixelLoopTest
	dbra		d6,		.pixelLoop

.trailingPixel
	btst		#0,		d4
	beq.b		.pixelLoopDone
	YGXTO16	d0
	move.w	d0,		(a0)+

.pixelLoopDone
	add.w		d2,		a0
	add.w		d3,		a1

.scanlineLoopTest
	dbra		d5,		.scanlineLoop

.finished
	DONE
	rts


;///////////////////////////////////////////////////////////////////////////////
;//
;//  void Pix24::rotate24XGYTo16LE
;//
;//  (void* dst, void* src, uint32* sPal, size_t w, size_t h, size_t dstSpan, size_t srcSpan)
;//
;///////////////////////////////////////////////////////////////////////////////

rotate24XGYTo16LE__Pix24__PvPvPUjssss
	INIT
	move.w	d3,	d0
	lsl.w		#1,	d3
	add.w		d0,	d3
	lsl.w		#1,	d2
	bra.b		.scanlineLoopTest

.scanlineLoop
	move.w	d4,		d6
	lsr.w		#1,		d6
	bra.b		.pixelLoopTest

.pixelLoop
	YGXTO16	d0
	YGXTO16	d1
	SWP16		d0
	SWP16		d1
	swap		d0
	move.w	d1,		d0
	move.l	d0,		(a0)+

.pixelLoopTest
	dbra		d6,		.pixelLoop

.trailingPixel
	btst		#0,		d4
	beq.b		.pixelLoopDone
	YGXTO16	d0
	SWP16		d0
	move.w	d0,		(a0)+

.pixelLoopDone
	add.w		d2,		a0
	add.w		d3,		a1

.scanlineLoopTest
	dbra		d5,		.scanlineLoop

.finished
	DONE
	rts


;///////////////////////////////////////////////////////////////////////////////
;//
;//  void Pix24::copy24To24
;//
;//  (void* dst, void* src, uint32* sPal, size_t w, size_t h, size_t dstSpan, size_t srcSpan)
;//
;///////////////////////////////////////////////////////////////////////////////

copy24To24__Pix24__PvPvPUjssss
	COPYNORMAL24
	rts

;///////////////////////////////////////////////////////////////////////////////
;//
;//  void Pix24::rotate24To24
;//
;//  (void* dst, void* src, uint32* sPal, size_t w, size_t h, size_t dstSpan, size_t srcSpan)
;//
;///////////////////////////////////////////////////////////////////////////////

rotate24To24__Pix24__PvPvPUjssss
	INIT
	move.w	d2,		d0
	lsl.w		#1,		d2
	add.w		d0,		d2
	move.w	d3,		d0
	lsl.w		#1,		d3
	add.w		d0,		d3
	bra.b		.scanlineLoopTest

.scanlineLoop
	move.w	d4,	d6
	bra.b		.pixelLoopTest

.pixelLoop
	move.b	2(a1),	(a0)+
	move.b	1(a1),	(a0)+
	move.b	0(a1),	(a0)+
	addq.w	#3,		a1
		
.pixelLoopTest
	dbra		d6,		.pixelLoop

.pixelLoopDone
	add.w		d2,		a0
	add.w		d3,		a1

.scanlineLoopTest
	dbra		d5,		.scanlineLoop

.finished
	DONE
	rts

;///////////////////////////////////////////////////////////////////////////////
;//
;//  void Pix24::copy24XGYTo32BE
;//
;//  (void* dst, void* src, uint32* sPal, size_t w, size_t h, size_t dstSpan, size_t srcSpan)
;//
;///////////////////////////////////////////////////////////////////////////////

copy24XGYTo32BE__Pix24__PvPvPUjssss
	INIT
	move.w	d3,		d0
	lsl.w		#1,		d3
	add.w		d0,		d3
	lsl.w		#2,		d2
	bra.b		.scanlineLoopTest

.scanlineLoop
	move.w	d4,		d6
	bra.b		.pixelLoopTest

.pixelLoop
	moveq		#0,		d0		;// d0.l = 00000000 00000000 00000000 00000000
	move.b	(a1)+,	d0		;// d0.l = 00000000 00000000 00000000 xxxxxxxx
	lsl.l		#8,		d0		;// d0.l = 00000000 00000000 xxxxxxxx 00000000
	move.b	(a1)+,	d0		;// d0.l = 00000000 00000000 xxxxxxxx gggggggg
	lsl.l		#8,		d0		;// d0.l = 00000000 xxxxxxxx gggggggg 00000000
	move.b	(a1)+,	d0		;// d0.l = 00000000 xxxxxxxx gggggggg yyyyyyyy
	move.l	d0,		(a0)+

.pixelLoopTest
	dbra		d6,		.pixelLoop

.pixelLoopDone
	add.w		d2,		a0
	add.w		d3,		a1

.scanlineLoopTest
	dbra		d5,		.scanlineLoop

.finished
	DONE
	rts

;///////////////////////////////////////////////////////////////////////////////
;//
;//  void Pix24::copy24XGYTo32LE
;//
;//  (void* dst, void* src, uint32* sPal, size_t w, size_t h, size_t dstSpan, size_t srcSpan)
;//
;///////////////////////////////////////////////////////////////////////////////

copy24XGYTo32LE__Pix24__PvPvPUjssss
	INIT
	move.w	d3,		d0
	lsl.w		#1,		d3
	add.w		d0,		d3
	lsl.w		#2,		d2
	bra.b		.scanlineLoopTest

.scanlineLoop
	move.w	d4,		d6
	bra.b		.pixelLoopTest

.pixelLoop
	moveq		#0,		d0		;// d0.l = 00000000 00000000 00000000 00000000
	move.b	(a1)+,	d0		;// d0.l = 00000000 00000000 00000000 xxxxxxxx
	ror.l		#8,		d0		;// d0.l = xxxxxxxx 00000000 00000000 00000000
	move.b	(a1)+,	d0		;// d0.l = xxxxxxxx 00000000 00000000 gggggggg
	ror.l		#8,		d0		;// d0.l = gggggggg xxxxxxxx 00000000 00000000
	move.b	(a1)+,	d0		;// d0.l = gggggggg xxxxxxxx 00000000 yyyyyyyy
	ror.l		#8,		d0		;// d0.l = yyyyyyyy gggggggg xxxxxxxx 00000000
	move.l	d0,		(a0)+

.pixelLoopTest
	dbra		d6,		.pixelLoop

.pixelLoopDone
	add.w		d2,		a0
	add.w		d3,		a1

.scanlineLoopTest
	dbra		d5,		.scanlineLoop

.finished
	DONE
	rts

;///////////////////////////////////////////////////////////////////////////////
;//
;//  void Pix24::rotate24XGYTo32BE
;//
;//  (void* dst, void* src, uint32* sPal, size_t w, size_t h, size_t dstSpan, size_t srcSpan)
;//
;///////////////////////////////////////////////////////////////////////////////

rotate24XGYTo32BE__Pix24__PvPvPUjssss
	INIT
	move.w	d3,		d0
	lsl.w		#1,		d3
	add.w		d0,		d3
	lsl.w		#2,		d2
	bra.b		.scanlineLoopTest

.scanlineLoop
	move.w	d4,		d6
	bra.b		.pixelLoopTest

.pixelLoop
	moveq		#0,		d0		;// d0.l = 00000000 00000000 00000000 00000000
	move.b	2(a1),	d0		;// d0.l = 00000000 00000000 00000000 yyyyyyyy
	lsl.l		#8,		d0		;// d0.l = 00000000 00000000 yyyyyyyy 00000000
	move.b	1(a1),	d0		;// d0.l = 00000000 00000000 yyyyyyyy gggggggg
	lsl.l		#8,		d0		;// d0.l = 00000000 yyyyyyyy gggggggg 00000000
	move.b	0(a1),	d0		;// d0.l = 00000000 yyyyyyyy gggggggg xxxxxxxx
	move.l	d0,		(a0)+
	addq.w	#3,		a1

.pixelLoopTest
	dbra		d6,		.pixelLoop

.pixelLoopDone
	add.w		d2,		a0
	add.w		d3,		a1

.scanlineLoopTest
	dbra		d5,		.scanlineLoop

.finished
	DONE
	rts

;///////////////////////////////////////////////////////////////////////////////
;//
;//  void Pix24::rotate24XGYTo32LE
;//
;//  (void* dst, void* src, uint32* sPal, size_t w, size_t h, size_t dstSpan, size_t srcSpan)
;//
;///////////////////////////////////////////////////////////////////////////////

rotate24XGYTo32LE__Pix24__PvPvPUjssss
	INIT
	move.w	d3,		d0
	lsl.w		#1,		d3
	add.w		d0,		d3
	lsl.w		#2,		d2
	bra.b		.scanlineLoopTest

.scanlineLoop
	move.w	d4,		d6
	bra.b		.pixelLoopTest

.pixelLoop
	moveq		#0,		d0		;// d0.l = 00000000 00000000 00000000 00000000
	move.b	(a1)+,	d0		;// d0.l = 00000000 00000000 00000000 xxxxxxxx
	lsl.l		#8,		d0		;// d0.l = 00000000 00000000 xxxxxxxx 00000000
	move.b	(a1)+,	d0		;// d0.l = 00000000 00000000 xxxxxxxx gggggggg
	lsl.l		#8,		d0		;// d0.l = 00000000 xxxxxxxx gggggggg 00000000
	move.b	(a1)+,	d0		;// d0.l = 00000000 xxxxxxxx gggggggg yyyyyyyy
	lsl.l		#8,		d0		;// d0.l = xxxxxxxx gggggggg yyyyyyyy 00000000
	move.l	d0,		(a0)+

.pixelLoopTest
	dbra		d6,		.pixelLoop

.pixelLoopDone
	add.w		d2,		a0
	add.w		d3,		a1

.scanlineLoopTest
	dbra		d5,		.scanlineLoop

.finished
	DONE
	rts
	
	END