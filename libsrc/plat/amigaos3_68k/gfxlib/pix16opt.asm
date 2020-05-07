;//****************************************************************************//
;//**                                                                        **//
;//** File:         libsrc/plat/amigaos3_68k/gfxlib/pix16opt.asm             **//
;//** Description:  Optimised 16-bit pixel conversion routines               **//
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

	XDEF	copy16BETo15BE__Pix16__PvPvPUjssss
	XDEF	copy16LETo15LE__Pix16__PvPvPUjssss
	XDEF	copy16BETo15LE__Pix16__PvPvPUjssss
	XDEF	copy16LETo15BE__Pix16__PvPvPUjssss
	XDEF	rotate16BETo15BE__Pix16__PvPvPUjssss
	XDEF	rotate16LETo15LE__Pix16__PvPvPUjssss
	XDEF	rotate16BETo15LE__Pix16__PvPvPUjssss
	XDEF	rotate16LETo15BE__Pix16__PvPvPUjssss
	XDEF	copy16XETo16XE__Pix16__PvPvPUjssss
	XDEF	copy16XETo16YE__Pix16__PvPvPUjssss
	XDEF	rotate16BETo16BE__Pix16__PvPvPUjssss
	XDEF	rotate16LETo16LE__Pix16__PvPvPUjssss
	XDEF	rotate16BETo16LE__Pix16__PvPvPUjssss
	XDEF	rotate16LETo16BE__Pix16__PvPvPUjssss
	XDEF	copy16BETo24XGY__Pix16__PvPvPUjssss
	XDEF	copy16LETo24XGY__Pix16__PvPvPUjssss
	XDEF	rotate16BETo24XGY__Pix16__PvPvPUjssss
	XDEF	rotate16LETo24XGY__Pix16__PvPvPUjssss
	XDEF	copy16BETo32BE__Pix16__PvPvPUjssss
	XDEF	copy16LETo32LE__Pix16__PvPvPUjssss
	XDEF	copy16BETo32LE__Pix16__PvPvPUjssss
	XDEF	copy16LETo32BE__Pix16__PvPvPUjssss
	XDEF	rotate16BETo32BE__Pix16__PvPvPUjssss
	XDEF	rotate16LETo32LE__Pix16__PvPvPUjssss
	XDEF	rotate16BETo32LE__Pix16__PvPvPUjssss
	XDEF	rotate16LETo32BE__Pix16__PvPvPUjssss

	MACRO	ROT
	;// Rotate X:G:Y 5:6:5 <-> Y:G:X 5:6:5
										;// dN.w = -------- -------- xxxxxggg gggyyyyy
	rol.w		#8,			\1		;// dN.w = -------- -------- gggyyyyy xxxxxggg
	ror.b		#3,			\1		;// dN.w = -------- -------- gggyyyyy gggxxxxx
	rol.w		#3,			\1		;// dN.w = -------- -------- yyyyyggg xxxxxggg
	ror.b		#3,			\1		;// dN.w = -------- -------- yyyyyggg gggxxxxx
	ENDM

	MACRO SHR15
	;// Shrink X:G:Y 5:6:5 <-> A:X:G:Y 1:5:6:5
	;// Alpha bit zero
	move.w	\1,			\2		;// \2.w = -------- -------- xxxxxggg gggyyyyy
	lsr.w		#1,			\2		;// \2.w = -------- -------- 0xxxxxgg ggggyyyy
	and.w		#$001F,		\1		;// \1.w = -------- -------- 00000000 000yyyyy
	and.w		#$7FE0,		\2		;// \2.w = -------- -------- 0xxxxxgg ggg00000
	or.w		\2,			\1		;// \1.w = -------- -------- 0xxxxxgg gggyyyyy
	ENDM

	MACRO EXP32
	;// Expand X:G:Y 5:6:5 <-> A:X:G:Y 8:8:8:8
	;// Alpha channel zero
	rol.w		#6,			\1		;// \1.w = -------- -------- gggggyyy yyxxxxxg
	move.b	\1,			\2		;// \2.l = 00000000 00000000 00000000 yyxxxxxg
	lsl.l		#8,			\2		;// \1.l = 00000000 00000000 yyxxxxxg 00000000
	rol.w		#5,			\1		;// \1.w = -------- -------- yyyyyxxx xxgggggg
	move.b	\1,			\2		;// \2.l = 00000000 00000000 yyxxxxxg xxgggggg
	lsl.l		#8,			\2		;// \2.l = 00000000 yyxxxxxg xxgggggg 00000000
	rol.w		#6,			\1		;// \1.w = -------- -------- xxxxgggg ggyyyyyx
	move.b	\1,			\2		;// \2.l = 00000000 yyxxxxxg xxgggggg ggyyyyyx
	and.l		#$003E3F3E, \2		;// \2.l = 00000000 00xxxxx0 00gggggg 00yyyyy0
	lsl.l		#2,			\2		;// \2.l = 00000000 xxxxx000 gggggg00 yyyyy000	
	ENDM

	MACRO RTX32
	;// Expand X:G:Y 5:6:5 <-> A:Y:G:X 8:8:8:8
	;// Alpha channel zero
										;// \1.w = -------- -------- xxxxxggg gggyyyyy
	move.b	\1,			\2		;// \2.b = -------- -------- -------- gggyyyyy
	lsl.b		#1,			\2		;// \2.b = -------- -------- -------- ggyyyyy0
	lsr.w		#5,			\1		;// \1.w = -------- -------- 00000xxx xxgggggg
	lsl.w		#8,			\2		;// \2.w = -------- -------- ggyyyyy0 00000000
	move.b	\1,			\2		;// \2.w = -------- -------- ggyyyyy0 xxgggggg
	lsr.w		#5,			\1		;// \1.w = -------- -------- 00000000 00xxxxxg
	lsl.l		#8,			\2		;// \2.l = nnnnnnnn ggyyyyy0 xxgggggg 00000000
	move.b	\1,			\2		;// \2.l = nnnnnnnn ggyyyyy0 xxgggggg 00xxxxxg
	and.l		#$003E3F3E, \2		;// \2.l = 00000000 00yyyyy0 00gggggg 00xxxxx0
	lsl.l		#2,			\2		;// \2.l = 00000000 yyyyy000 gggggg00 xxxxx000

	ENDM

	MACRO GETX
	;// Extract 8-bit X from X:G:Y 5:6:5
	move.w	\1,			\2		;// d1.w = -------- -------- xxxxxggg gggyyyyy
	and.w		#$F800,		\2		;// d1.w = -------- -------- xxxxx000 00000000
	lsr.w		#8,			\2		;// d1.w = -------- -------- 00000000 xxxxx000
	ENDM

	MACRO GETG
	;// Extract 8-bit G from X:G:Y 5:6:5
	move.w	\1,			\2		;// d1.w = -------- -------- xxxxxggg gggyyyyy
	and.w		#$07E0,		\2		;// d1.w = -------- -------- 00000ggg ggg00000
	lsr.w		#3,			\2		;// d1.w = -------- -------- 00000000 gggggg00
	ENDM

	MACRO GETY
	;// Extract 8-bit Y from X:G:Y 5:6:5
	move.w	\1,			\2		;// d1.w = -------- -------- xxxxxggg gggyyyyy
	and.w		#$001F,		\2		;// d1.w = -------- -------- 00000000 000yyyyy
	lsl.w		#3,			\2		;// d1.w = -------- -------- 00000000 yyyyy000
	ENDM

	SECTION ":0", CODE

;///////////////////////////////////////////////////////////////////////////////
;//
;//  void Pix16::copy16BETo15BE
;//
;///////////////////////////////////////////////////////////////////////////////

copy16BETo15BE__Pix16__PvPvPUjssss
	INIT
	;// scale srcSpan/dstSpan to match pointer size (uint16*)
	lsl.w		#1,		d2
	lsl.w		#1,		d3
	bra.b		.scanlineLoopTest

.scanlineLoop
	move.w	d4,		d6
	lsr.w		#1,		d6
	bra.b		.pixelLoopTest

.pixelLoop
	move.l	(a1)+,	d0
	SHR15		d0,		d1
	swap		d0
	SHR15		d0,		d1
	swap		d0
	move.l	d0,		(a0)+

.pixelLoopTest
	dbra		d6,		.pixelLoop

.trailingPixel
	btst		#0,		d4
	beq.b		.pixelLoopDone
	move.w	(a1)+,	d0
	SHR15		d0,		d1
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
;//  void Pix16::copy16LETo15LE
;//
;///////////////////////////////////////////////////////////////////////////////

copy16LETo15LE__Pix16__PvPvPUjssss
	INIT
	;// scale srcSpan/dstSpan to match pointer size (uint16*)
	lsl.w		#1,		d2
	lsl.w		#1,		d3
	bra.b		.scanlineLoopTest

.scanlineLoop
	move.w	d4,		d6
	lsr.w		#1,		d6
	bra.b		.pixelLoopTest

.pixelLoop
	move.l	(a1)+,	d0
	SWP16		d0
	SHR15		d0,		d1
	SWP16		d0
	swap		d0
	SWP16		d0
	SHR15		d0,		d1
	SWP16		d0
	swap		d0	
	move.l	d0,		(a0)+

.pixelLoopTest
	dbra		d6,		.pixelLoop

.trailingPixel
	btst		#0,		d4
	beq.b		.pixelLoopDone
	move.w	(a1)+,	d0
	SWP16		d0
	SHR15		d0,		d1
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
;//  void Pix16::copy16BETo15LE
;//
;///////////////////////////////////////////////////////////////////////////////

copy16BETo15LE__Pix16__PvPvPUjssss
	INIT
	;// scale srcSpan/dstSpan to match pointer size (uint16*)
	lsl.w		#1,		d2
	lsl.w		#1,		d3
	bra.b		.scanlineLoopTest

.scanlineLoop
	move.w	d4,		d6
	lsr.w		#1,		d6
	bra.b		.pixelLoopTest

.pixelLoop
	move.l	(a1)+,	d0
	SHR15		d0,		d1
	SWP16		d0
	swap		d0
	SHR15		d0,		d1
	SWP16		d0
	swap		d0
	move.l	d0,		(a0)+

.pixelLoopTest
	dbra		d6,		.pixelLoop

.trailingPixel
	btst		#0,		d4
	beq.b		.pixelLoopDone
	move.w	(a1)+,	d0
	SHR15		d0,		d1
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
;//  void Pix16::copy16LETo15BE
;//
;///////////////////////////////////////////////////////////////////////////////

copy16LETo15BE__Pix16__PvPvPUjssss
	INIT
	;// scale srcSpan/dstSpan to match pointer size (uint16*)
	lsl.w		#1,		d2
	lsl.w		#1,		d3
	bra.b		.scanlineLoopTest

.scanlineLoop
	move.w	d4,		d6
	lsr.w		#1,		d6
	bra.b		.pixelLoopTest

.pixelLoop
	move.l	(a1)+,	d0
	SWP16		d0
	SHR15		d0,		d1
	swap		d0
	SWP16		d0
	SHR15		d0,		d1
	swap		d0
	move.l	d0,		(a0)+

.pixelLoopTest
	dbra		d6,		.pixelLoop

.trailingPixel
	btst		#0,		d4
	beq.b		.pixelLoopDone
	move.w	(a1)+,	d0
	SWP16		d0
	SHR15		d0,		d1
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
;//  void Pix16::rotate16BETo15BE
;//
;///////////////////////////////////////////////////////////////////////////////

rotate16BETo15BE__Pix16__PvPvPUjssss
	INIT
	;// scale srcSpan/dstSpan to match pointer size (uint16*)
	lsl.w		#1,		d2
	lsl.w		#1,		d3
	bra.b		.scanlineLoopTest

.scanlineLoop
	move.w	d4,		d6
	lsr.w		#1,		d6
	bra.b		.pixelLoopTest

.pixelLoop
	move.l	(a1)+,	d0
	ROT		d0
	SHR15		d0,		d1
	swap		d0
	ROT		d0
	SHR15		d0,		d1
	swap		d0	
	move.l	d0,		(a0)+

.pixelLoopTest
	dbra		d6,		.pixelLoop

.trailingPixel
	btst		#0,		d4
	beq.b		.pixelLoopDone
	move.w	(a1)+,	d0
	ROT		d0
	SHR15		d0,		d1
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
;//  void Pix16::rotate16LETo15LE
;//
;///////////////////////////////////////////////////////////////////////////////

rotate16LETo15LE__Pix16__PvPvPUjssss
	INIT
	;// scale srcSpan/dstSpan to match pointer size (uint16*)
	lsl.w		#1,		d2
	lsl.w		#1,		d3
	bra.b		.scanlineLoopTest

.scanlineLoop
	move.w	d4,		d6
	lsr.w		#1,		d6
	bra.b		.pixelLoopTest

.pixelLoop
	move.w	(a1)+,	d0
	SWP16		d0
	ROT		d0
	SHR15		d0,		d1
	SWP16		d0
	swap		d0
	SWP16		d0
	ROT		d0
	SHR15		d0,		d1
	SWP16		d0
	swap		d0
	move.w	d0,		(a0)+

.pixelLoopTest
	dbra		d6,		.pixelLoop

.trailingPixel
	btst		#0,		d4
	beq.b		.pixelLoopDone
	move.w	(a1)+,	d0
	SWP16		d0
	ROT		d0
	SHR15		d0,		d1
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
;//  void Pix16::rotate16BETo15LE
;//
;///////////////////////////////////////////////////////////////////////////////

rotate16BETo15LE__Pix16__PvPvPUjssss
	INIT
	;// scale srcSpan/dstSpan to match pointer size (uint16*)
	lsl.w		#1,		d2
	lsl.w		#1,		d3
	bra.b		.scanlineLoopTest

.scanlineLoop
	move.w	d4,		d6
	lsr.w		#1,		d6
	bra.b		.pixelLoopTest

.pixelLoop
	move.l	(a1)+,	d0
	ROT		d0
	SHR15		d0,		d1
	SWP16		d0
	swap		d0
	ROT		d0
	SHR15		d0,		d1
	SWP16		d0
	swap		d0
	move.l	d0,		(a0)+

.pixelLoopTest
	dbra		d6,		.pixelLoop

.trailingPixel
	btst		#0,		d4
	beq.b		.pixelLoopDone
	move.w	(a1)+,	d0
	ROT		d0
	SHR15		d0,		d1
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
;//  void Pix16::rotate16LETo15BE
;//
;///////////////////////////////////////////////////////////////////////////////

rotate16LETo15BE__Pix16__PvPvPUjssss
	INIT
	;// scale srcSpan/dstSpan to match pointer size (uint16*)
	lsl.w		#1,		d2
	lsl.w		#1,		d3
	bra.b		.scanlineLoopTest

.scanlineLoop
	move.w	d4,		d6
	lsr.w		#1,		d6
	bra.b		.pixelLoopTest

.pixelLoop
	move.l	(a1)+,	d0
	SWP16		d0
	ROT		d0
	SHR15		d0,		d1
	swap		d0
	SWP16		d0
	ROT		d0
	SHR15		d0,		d1
	swap		d0
	move.l	d0,		(a0)+

.pixelLoopTest
	dbra		d6,		.pixelLoop

.trailingPixel
	btst		#0,		d4
	beq.b		.pixelLoopDone
	move.w	(a1)+,	d0
	SWP16		d0
	ROT		d0
	SHR15		d0,		d1
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
;//  void Pix16::copy16XETo16XE
;//
;///////////////////////////////////////////////////////////////////////////////

copy16XETo16XE__Pix16__PvPvPUjssss
	COPYNORMAL	1
	rts
	
;///////////////////////////////////////////////////////////////////////////////
;//
;//  void Pix16::copy16XETo16YE
;//
;///////////////////////////////////////////////////////////////////////////////

copy16XETo16YE__Pix16__PvPvPUjssss
	COPYSWAP16
	rts

;///////////////////////////////////////////////////////////////////////////////
;//
;//  void Pix16::rotate16BETo16BE
;//
;///////////////////////////////////////////////////////////////////////////////

rotate16BETo16BE__Pix16__PvPvPUjssss
	INIT
	;// scale srcSpan/dstSpan to match pointer size (uint16*)
	lsl.w		#1,		d2
	lsl.w		#1,		d3
	bra.b		.scanlineLoopTest

.scanlineLoop
	move.w	d4,		d6
	lsr.w		#1,		d6
	bra.b		.pixelLoopTest

.pixelLoop
	move.l	(a1)+,	d0
	ROT		d0
	swap		d0
	ROT		d0
	swap		d0
	move.l	d0,		(a0)+

.pixelLoopTest
	dbra		d6,		.pixelLoop
	
.trailingPixel
	btst		#0,		d4
	beq.b		.pixelLoopDone
	move.w	(a1)+,	d0
	ROT		d0
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
;//  void Pix16::rotate16LETo16LE
;//
;///////////////////////////////////////////////////////////////////////////////

rotate16LETo16LE__Pix16__PvPvPUjssss
	INIT
	;// scale srcSpan/dstSpan to match pointer size (uint16*)
	lsl.w		#1,		d2
	lsl.w		#1,		d3
	bra.b		.scanlineLoopTest

.scanlineLoop
	move.w	d4,		d6
	lsr.w		#1,		d6
	bra.b		.pixelLoopTest

.pixelLoop
	move.l	(a1)+,	d0
	SWP16		d0
	ROT		d0
	SWP16		d0
	swap		d0
	SWP16		d0	
	ROT		d0
	SWP16		d0
	swap		d0
	move.l	d0,		(a0)+

.pixelLoopTest
	dbra		d6,		.pixelLoop

.trailingPixel
	btst		#0,		d4
	beq.b		.pixelLoopDone
	move.w	(a1)+,	d0
	SWP16		d0
	ROT		d0
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
;//  void Pix16::rotate16BETo16LE
;//
;///////////////////////////////////////////////////////////////////////////////

rotate16BETo16LE__Pix16__PvPvPUjssss
	INIT
	;// scale srcSpan/dstSpan to match pointer size (uint16*)
	lsl.w		#1,		d2
	lsl.w		#1,		d3
	bra.b		.scanlineLoopTest

.scanlineLoop
	move.w	d4,		d6
	lsr.w		#1,		d6
	bra.b		.pixelLoopTest

.pixelLoop
	move.l	(a1)+,	d0
	ROT		d0
	SWP16		d0
	swap		d0
	ROT		d0
	SWP16		d0
	swap		d0
	move.l	d0,		(a0)+

.pixelLoopTest
	dbra		d6,		.pixelLoop

.trailingPixel
	btst		#0,		d4
	beq.b		.pixelLoopDone
	move.w	(a1)+,	d0
	ROT		d0
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
;//  void Pix16::rotate16LETo16BE
;//
;///////////////////////////////////////////////////////////////////////////////

rotate16LETo16BE__Pix16__PvPvPUjssss
	INIT
	;// scale srcSpan/dstSpan to match pointer size (uint16*)
	lsl.w		#1,		d2
	lsl.w		#1,		d3
	bra.b		.scanlineLoopTest

.scanlineLoop
	move.w	d4,		d6
	lsr.w		#1,		d6
	bra.b		.pixelLoopTest

.pixelLoop
	move.l	(a1)+,	d0
	SWP16		d0
	ROT		d0
	swap		d0
	SWP16		d0
	ROT		d0
	swap		d0	
	move.l	d0,		(a0)+

.pixelLoopTest
	dbra		d6,		.pixelLoop

.trailingPixel
	btst		#0,		d4
	beq.b		.pixelLoopDone
	move.w	(a1)+,	d0
	SWP16		d0
	ROT		d0
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
;//  void Pix16::copy16BETo24XGY
;//
;///////////////////////////////////////////////////////////////////////////////

copy16BETo24XGY__Pix16__PvPvPUjssss
	INIT
	;// scale srcSpan to match pointer size
	move.w	d2,		d0
	lsl.w		#1,		d2
	add.w		d0,		d2
	lsl.w		#1,		d3
	bra.b		.scanlineLoopTest

.scanlineLoop
	move.w	d4,		d6
	bra.b		.pixelLoopTest

.pixelLoop
	move.w	(a1)+,	d0
	GETX		d0,		d1
	move.b	d1,		(a0)+
	GETG		d0,		d1
	move.b	d1,		(a0)+
	GETY		d0,		d1
	move.b	d1,		(a0)+

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
;//  void Pix16::copy16LETo24XGY
;//
;///////////////////////////////////////////////////////////////////////////////

copy16LETo24XGY__Pix16__PvPvPUjssss
	INIT
	;// scale srcSpan to match pointer size
	move.w	d2,		d0
	lsl.w		#1,		d2
	add.w		d0,		d2
	lsl.w		#1,		d3
	bra.b		.scanlineLoopTest

.scanlineLoop
	move.w	d4,		d6
	bra.b		.pixelLoopTest

.pixelLoop
	move.w	(a1)+,	d0
	SWP16		d0
	GETX		d0,		d1
	move.b	d1,		(a0)+
	GETG		d0,		d1
	move.b	d1,		(a0)+
	GETY		d0,		d1
	move.b	d1,		(a0)+

.pixelLoopTest
	subq.l	#1,		d6
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
;//  void Pix16::rotate16BETo24XGY
;//
;///////////////////////////////////////////////////////////////////////////////

rotate16BETo24XGY__Pix16__PvPvPUjssss
	INIT
	;// scale srcSpan to match pointer size
	move.w	d2,		d0
	lsl.w		#1,		d2
	add.w		d0,		d2
	lsl.w		#1,		d3
	bra.b		.scanlineLoopTest

.scanlineLoop
	move.w	d4,		d6
	bra.b		.pixelLoopTest

.pixelLoop
	;// instead of rotating word, simply pump the bytes out in YGX order
	move.w	(a1)+,	d0
	GETY		d0,		d1
	move.b	d1,		(a0)+
	GETG		d0,		d1
	move.b	d1,		(a0)+
	GETX		d0,		d1
	move.b	d1,		(a0)+

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
;//  void Pix16::rotate16LETo24XGY
;//
;///////////////////////////////////////////////////////////////////////////////

rotate16LETo24XGY__Pix16__PvPvPUjssss
	INIT
	;// scale srcSpan to match pointer size
	move.w	d2,		d0
	lsl.w		#1,		d2
	add.w		d0,		d2
	lsl.w		#1,		d3
	bra.b		.scanlineLoopTest

.scanlineLoop
	move.w	d4,		d6
	bra.b		.pixelLoopTest

.pixelLoop
	;// instead of rotating word, simply pump the bytes out in YGX order
	move.w	(a1)+,	d0
	SWP16		d0
	GETY		d0,		d1
	move.b	d1,		(a0)+
	GETG		d0,		d1
	move.b	d1,		(a0)+
	GETX		d0,		d1
	move.b	d1,		(a0)+

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
;//  void Pix16::copy16BETo32BE
;//
;///////////////////////////////////////////////////////////////////////////////

copy16BETo32BE__Pix16__PvPvPUjssss
	INIT
	;// scale spans to match pointer size (uint32*/uint16*)
	lsl.w		#2,		d2
	lsl.w		#1,		d3
	bra.b		.scanlineLoopTest

.scanlineLoop
	move.w	d4,		d6
	lsr.w		#1,		d6
	bra.b		.pixelLoopTest

.pixelLoop
	move.l	(a1)+,	d0
	swap		d0
	EXP32		d0,		d1
	move.l	d1,		(a0)+
	swap		d0
	EXP32		d0,		d1
	move.l	d1,		(a0)+
	
.pixelLoopTest
	dbra		d6,		.pixelLoop

.trailingPixel
	btst		#0,		d4
	beq.b		.pixelLoopDone
	move.w	(a1)+,	d0
	EXP32		d0,		d1
	move.l	d1,		(a0)+

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
;//  void Pix16::copy16LETo32LE
;//
;///////////////////////////////////////////////////////////////////////////////

copy16LETo32LE__Pix16__PvPvPUjssss
	INIT
	;// scale spans to match pointer size (uint32*/uint16*)
	lsl.w		#2,		d2
	lsl.w		#1,		d3
	bra.b		.scanlineLoopTest

.scanlineLoop
	move.w	d4,		d6
	lsr.w		#1,		d6
	bra.b		.pixelLoopTest

.pixelLoop
	move.l	(a1)+,	d0
	swap		d0
	SWP16		d0
	EXP32		d0,		d1
	SWP32		d1
	move.l	d1,		(a0)+
	swap		d0
	SWP16		d0
	EXP32		d0,		d1
	SWP32		d1
	move.l	d1,		(a0)+
	
.pixelLoopTest
	dbra		d6,		.pixelLoop

.trailingPixel
	btst		#0,		d4
	beq.b		.pixelLoopDone
	move.w	(a1)+,	d0
	SWP16		d0
	EXP32		d0,		d1
	SWP32		d1
	move.l	d1,		(a0)+

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
;//  void Pix16::copy16BETo32LE
;//
;///////////////////////////////////////////////////////////////////////////////

copy16BETo32LE__Pix16__PvPvPUjssss
	INIT
	;// scale spans to match pointer size (uint32*/uint16*)
	lsl.w		#2,		d2
	lsl.w		#1,		d3
	bra.b		.scanlineLoopTest

.scanlineLoop
	move.w	d4,		d6
	lsr.w		#1,		d6
	bra.b		.pixelLoopTest

.pixelLoop
	move.l	(a1)+,	d0
	swap		d0
	EXP32		d0,		d1
	SWP32		d1
	move.l	d1,		(a0)+
	swap		d0
	EXP32		d0,		d1
	SWP32		d1
	move.l	d1,		(a0)+
	
.pixelLoopTest
	dbra		d6,		.pixelLoop

.trailingPixel
	btst		#0,		d4
	beq.b		.pixelLoopDone
	move.w	(a1)+,	d0
	EXP32		d0,		d1
	SWP32		d1
	move.l	d1,		(a0)+

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
;//  void Pix16::copy16LETo32BE
;//
;///////////////////////////////////////////////////////////////////////////////

copy16LETo32BE__Pix16__PvPvPUjssss
	INIT
	;// scale spans to match pointer size (uint32*/uint16*)
	lsl.w		#2,		d2
	lsl.w		#1,		d3
	bra.b		.scanlineLoopTest

.scanlineLoop
	move.w	d4,		d6
	lsr.w		#1,		d6
	bra.b		.pixelLoopTest

.pixelLoop
	move.l	(a1)+,	d0
	swap		d0
	SWP16		d0
	EXP32		d0,		d1
	move.l	d1,		(a0)+
	swap		d0
	SWP16		d0
	EXP32		d0,		d1
	move.l	d1,		(a0)+
	
.pixelLoopTest
	dbra		d6,		.pixelLoop

.trailingPixel
	btst		#0,		d4
	beq.b		.pixelLoopDone
	move.w	(a1)+,	d0
	SWP16		d0
	EXP32		d0,		d1
	move.l	d1,		(a0)+

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
;//  void Pix16::rotate16BETo32BE
;//
;///////////////////////////////////////////////////////////////////////////////

rotate16BETo32BE__Pix16__PvPvPUjssss
	INIT
	;// scale spans to match pointer size (uint32*/uint16*)
	lsl.w		#2,		d2
	lsl.w		#1,		d3
	bra.b		.scanlineLoopTest

.scanlineLoop
	move.w	d4,		d6
	lsr.w		#1,		d6
	bra.b		.pixelLoopTest

.pixelLoop
	move.l	(a1)+,	d0
	swap		d0
	RTX32		d0,		d1
	move.l	d1,		(a0)+
	swap		d0
	RTX32		d0,		d1
	move.l	d1,		(a0)+
	
.pixelLoopTest
	dbra		d6,		.pixelLoop

.trailingPixel
	btst		#0,		d4
	beq.b		.pixelLoopDone
	move.w	(a1)+,	d0
	RTX32		d0,		d1
	move.l	d1,		(a0)+

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
;//  void Pix16::rotate16LETo32LE
;//
;///////////////////////////////////////////////////////////////////////////////

rotate16LETo32LE__Pix16__PvPvPUjssss
	INIT
	;// scale spans to match pointer size (uint32*/uint16*)
	lsl.w		#2,		d2
	lsl.w		#1,		d3
	bra.b		.scanlineLoopTest

.scanlineLoop
	move.w	d4,		d6
	lsr.w		#1,		d6
	bra.b		.pixelLoopTest

.pixelLoop
	move.l	(a1)+,	d0
	swap		d0
	SWP16		d0
	RTX32		d0,		d1
	SWP32		d1
	move.l	d1,		(a0)+
	swap		d0
	SWP16		d0
	RTX32		d0,		d1
	SWP32		d1
	move.l	d1,		(a0)+

.pixelLoopTest
	dbra		d6,		.pixelLoop

.trailingPixel
	btst		#0,		d4
	beq.b		.pixelLoopDone
	move.w	(a1)+,	d0
	SWP16		d0
	RTX32		d0,		d1
	SWP32		d1
	move.l	d1,		(a0)+

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
;//  void Pix16::rotate16BETo32LE
;//
;///////////////////////////////////////////////////////////////////////////////

rotate16BETo32LE__Pix16__PvPvPUjssss
	INIT
	;// scale spans to match pointer size (uint32*/uint16*)
	lsl.w		#2,		d2
	lsl.w		#1,		d3
	bra.b		.scanlineLoopTest

.scanlineLoop
	move.w	d4,		d6
	lsr.w		#1,		d6
	bra.b		.pixelLoopTest

.pixelLoop
	move.l	(a1)+,	d0
	swap		d0
	RTX32		d0,		d1
	SWP32		d1
	move.l	d1,		(a0)+
	swap		d0
	RTX32		d0,		d1
	SWP32		d1
	move.l	d1,		(a0)+
	
.pixelLoopTest
	dbra		d6,		.pixelLoop

.trailingPixel
	btst		#0,		d4
	beq.b		.pixelLoopDone
	move.w	(a1)+,	d0
	RTX32		d0,		d1
	SWP32		d1
	move.l	d1,		(a0)+

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
;//  void Pix16::rotate16LETo32BE
;//
;///////////////////////////////////////////////////////////////////////////////

rotate16LETo32BE__Pix16__PvPvPUjssss
	INIT
	;// scale spans to match pointer size (uint32*/uint16*)
	lsl.w		#2,		d2
	lsl.w		#1,		d3
	bra.b		.scanlineLoopTest

.scanlineLoop
	move.w	d4,		d6
	lsr.w		#1,		d6
	bra.b		.pixelLoopTest

.pixelLoop
	move.l	(a1)+,	d0
	swap		d0
	SWP16		d0
	RTX32		d0,		d1
	move.l	d1,		(a0)+
	swap		d0
	SWP16		d0
	RTX32		d0,		d1
	move.l	d1,		(a0)+
	
.pixelLoopTest
	dbra		d6,		.pixelLoop

.trailingPixel
	btst		#0,		d4
	beq.b		.pixelLoopDone
	move.w	(a1)+,	d0
	SWP16		d0
	RTX32		d0,		d1
	move.l	d1,		(a0)+

.pixelLoopDone
	add.w		d2,		a0
	add.w		d3,		a1

.scanlineLoopTest
	dbra		d5,		.scanlineLoop

.finished
	DONE
	rts

	END
