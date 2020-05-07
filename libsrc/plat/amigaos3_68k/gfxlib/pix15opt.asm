;//****************************************************************************//
;//**                                                                        **//
;//** File:         libsrc/plat/amigaos3_68k/gfxlib/pix15opt.asm             **//
;//** Description:  Optimised 15-bit pixel conversion routines               **//
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

	XDEF	copy15XETo15XE__Pix15__PvPvPUjssss
	XDEF	copy15XETo15YE__Pix15__PvPvPUjssss
	XDEF	rotate15BETo15BE__Pix15__PvPvPUjssss
	XDEF	rotate15LETo15LE__Pix15__PvPvPUjssss
	XDEF	rotate15BETo15LE__Pix15__PvPvPUjssss
	XDEF	rotate15LETo15BE__Pix15__PvPvPUjssss
	XDEF	copy15BETo16BE__Pix15__PvPvPUjssss
	XDEF	copy15LETo16LE__Pix15__PvPvPUjssss
	XDEF	copy15BETo16LE__Pix15__PvPvPUjssss
	XDEF	copy15LETo16BE__Pix15__PvPvPUjssss
	XDEF	rotate15BETo16BE__Pix15__PvPvPUjssss
	XDEF	rotate15LETo16LE__Pix15__PvPvPUjssss
	XDEF	rotate15BETo16LE__Pix15__PvPvPUjssss
	XDEF	rotate15LETo16BE__Pix15__PvPvPUjssss
	XDEF	copy15BETo24XGY__Pix15__PvPvPUjssss
	XDEF	copy15LETo24XGY__Pix15__PvPvPUjssss
	XDEF	rotate15BETo24XGY__Pix15__PvPvPUjssss
	XDEF	rotate15LETo24XGY__Pix15__PvPvPUjssss
	XDEF	copy15BETo32BE__Pix15__PvPvPUjssss
	XDEF	copy15LETo32LE__Pix15__PvPvPUjssss
	XDEF	copy15BETo32LE__Pix15__PvPvPUjssss
	XDEF	copy15LETo32BE__Pix15__PvPvPUjssss
	XDEF	rotate15BETo32BE__Pix15__PvPvPUjssss
	XDEF	rotate15LETo32LE__Pix15__PvPvPUjssss
	XDEF	rotate15BETo32LE__Pix15__PvPvPUjssss
	XDEF	rotate15LETo32BE__Pix15__PvPvPUjssss

;///////////////////////////////////////////////////////////////////////////////

	MACRO	ROT
	;// Rotate A:X:G:Y 1:5:5:5 <-> A:Y:G:X 1:5:5:5
	;// Alpha bit preserved
	;// \1 = pixel
	;// \2 = scratch

	move.w	\1,			\2		;// 2.w = -------- -------- Nxxxxxgg gggyyyyy
	lsl.b		#2,			\2		;// 2.w = -------- -------- Nxxxxxgg gyyyyy00
	rol.w		#8,			\2		;// 2.w = -------- -------- gyyyyy00 Nxxxxxgg
	lsr.b		#2,			\2		;// 2.w = -------- -------- gyyyyy00 00Nxxxxx
	and.w		#$7C1F,		\2		;// 2.w = -------- -------- 0yyyyy00 000xxxxx
	and.w		#$83E0,		\1		;// 1.w = -------- -------- N00000gg ggg00000
	or.w		\2,			\1		;// 1.w = -------- -------- Nyyyyygg gggxxxxx	
	ENDM

;///////////////////////////////////////////////////////////////////////////////

	MACRO	ROT_X2
	;// Rotate 2x A:X:G:Y 1:5:5:5 <-> 2x A:Y:G:X 1:5:5:5
	;// Alpha bit preserved
	;// \1 = pixel pair
	;// \2 = scratch
	;// \3 = rotateMask
	
	move.l	\1,			\2		;// 2.l = AXxxxxGg gggYyyyy AXxxxxGg gggYyyyy
	lsl.b		#2,			\2		;// 2.l = AXxxxxGg gggYyyyy AXxxxxGg gYyyyy00
	rol.w		#8,			\2		;// 2.l = AXxxxxGg gggYyyyy gYyyyy00 AXxxxxGg
	lsr.b		#2,			\2		;// 2.l = AXxxxxGg gggYyyyy gYyyyy00 00AXxxxx
	swap		\2						;// switch XY pixels 
	lsl.b		#2,			\2		;// 2.l = gYyyyy00 00AXxxxx AXxxxxGg gYyyyy00
	rol.w		#8,			\2		;// 2.l = gYyyyy00 00AXxxxx gYyyyy00 AXxxxxGg
	lsr.b		#2,			\2		;// 2.l = gYyyyy00 00AXxxxx gYyyyy00 00AXxxxx
	and.l		\3,			\2		;// 2.l = 0Yyyyy00 000Xxxxx 0Yyyyy00 000Xxxxx
	swap		\1						;// switch AG pixels
	not.l		\3						;// invert mask
	and.l		\3,			\1		;// 1.l = A00000Gg ggg00000 A00000Gg ggg00000
	not.l		\3						;// invert mask
	or.l		\2,			\1		;// 1.l = AYyyyyGg gggXxxxx AYyyyyGg gggXxxxx	
	swap		\1						;// switch finished pixels
	ENDM

;///////////////////////////////////////////////////////////////////////////////

	MACRO EXP16
	;// Expand A:X:G:Y 1:5:5:5 <-> X:G:Y 5:6:5
	;// Dest not alpha capable
	;// \1 = pixel
	;// \2 = scratch

	move.w	\1,			\2		;// 2.w = -------- -------- Nxxxxxgg gggyyyyy
	lsl.w		#1,			\1		;// 1.w = -------- -------- xxxxxggg ggyyyyy0
	and.w		#$001F,		\2		;// 2.w = -------- -------- 00000000 000yyyyy
	and.w		#$FFC0,		\1		;// 1.w = -------- -------- xxxxxggg gg000000
	or.w		\2,			\1		;// 1.w = -------- -------- xxxxxggg gg0yyyyy
	ENDM

;///////////////////////////////////////////////////////////////////////////////

	MACRO EXP16_X2
	;// Expand 2x A:X:G:Y 1:5:5:5 <-> 2x X:G:Y 5:6:5
	;// Dest not alpha capable
	;// \1 = pixel pair
	;// \2 = scratch
	;// \3 = expYMask
	;// \3 = expXGMask
	
	move.l	\1,		\2		;// 2.l = AXxxxxGg gggYyyyy AXxxxxGg gggYyyyy
	lsl.l		#1,		\1		;// 1.l = XxxxxGgg ggYyyyyA XxxxxGgg ggYyyyy0
	and.l		\3,		\2		;// 2.l = 00000000 000Yyyyy 00000000 000Yyyyy
	and.l		\4,		\1		;// 1.l = XxxxxGgg gg000000 XxxxxGgg gg000000
	or.l		\2,		\1		;// 1.l = XxxxxGgg gg0Yyyyy XxxxxGgg gg0Yyyyy
	ENDM

;///////////////////////////////////////////////////////////////////////////////

	MACRO EXP32
	;// Expand A:X:G:Y 1:5:5:5 <-> A:X:G:Y 8:8:8:8
	;// Alpha channel zero
	rol.w		#6,			\1		;// 1.w = -------- -------- gggggyyy yyNxxxxx
	move.b	\1,			\2		;// 2.l = 00000000 00000000 00000000 yyNxxxxx
	lsl.l		#8,			\2		;// 2.l = 00000000 00000000 yyNxxxxx 00000000
	rol.w		#5,			\1		;// 1.w = -------- -------- yyyyyNxx xxxggggg
	move.b	\1,			\2		;// 2.l = 00000000 00000000 yyNxxxxx xxxggggg
	lsl.l		#8,			\2		;// 2.l = 00000000 yyNxxxxx xxxggggg 00000000
	rol.w		#5,			\1		;// 1.w = -------- -------- Nxxxxxgg gggyyyyy
	move.b	\1,			\2		;// 2.l = 00000000 yyNxxxxx xxxggggg gggyyyyy
	and.l		#$001F1F1F, \2		;// 2.l = 00000000 000xxxxx 000ggggg 000yyyyy
	lsl.l		#3,			\2		;// 2.l = 00000000 xxxxx000 ggggg000 yyyyy000	
	ENDM

;///////////////////////////////////////////////////////////////////////////////

	MACRO RTX32
	;// Expand A:X:G:Y 1:5:5:5 <-> A:Y:G:X 8:8:8:8
	;// Alpha channel zero
	move.b	\1,			\2		;// 2.l = 00000000 00000000 00000000 gggyyyyy
	lsl.l		#8,			\2		;// 2.l = 00000000 00000000 gggyyyyy 00000000
	lsr.w		#5,			\1		;// 1.w = -------- -------- 00000Nxx xxxggggg
	move.b	\1,			\2		;// 2.l = 00000000 00000000 gggyyyyy xxxggggg
	lsl.l		#8,			\2		;// 2.l = 00000000 gggyyyyy xxxggggg 00000000
	lsr.w		#5,			\1		;// 1.w = -------- -------- 00000000 00Nxxxxx
	move.b	\1,			\2		;// 2.l = 00000000 gggyyyyy xxxggggg 00Nxxxxx
	and.l		#$001F1F1F,	\2		;// 2.l = 00000000 000yyyyy 000ggggg 000xxxxx
	lsl.l		#3,			\2		;// 2.l = 00000000 yyyyy000 ggggg000 xxxxx000
	ENDM

;///////////////////////////////////////////////////////////////////////////////

	MACRO GETX
	;// Extract 8-bit X from A:X:G:Y 1:5:5:5
	move.w	\1,			\2		;// 2.w = -------- -------- Nxxxxxgg gggyyyyy
	and.w		#$7C00,		\2		;// 2.w = -------- -------- 0xxxxx00 00000000
	lsr.w		#7,			\2		;// 2.w = -------- -------- 00000000 xxxxx000
	ENDM

;///////////////////////////////////////////////////////////////////////////////

	MACRO GETG
	;// Extract 8-bit G from A:X:G:Y 1:5:5:5
	move.w	\1,			\2		;// 2.w = -------- -------- Nxxxxxgg gggyyyyy
	and.w		#$03E0,		\2		;// 2.w = -------- -------- 000000gg ggg00000
	lsr.w		#2,			\2		;// 2.w = -------- -------- 00000000 ggggg000
	ENDM

;///////////////////////////////////////////////////////////////////////////////

	MACRO GETY
	;// Extract 8-bit Y from A:X:G:Y 1:5:5:5
	move.w	\1,			\2		;// 2.w = -------- -------- Nxxxxxgg gggyyyyy
	and.w		#$001F,		\2		;// 2.w = -------- -------- 00000000 000yyyyy
	lsl.w		#3,			\2		;// 2.w = -------- -------- 00000000 yyyyy000
	ENDM

;///////////////////////////////////////////////////////////////////////////////

	SECTION ":0",CODE

	CNOP	0,	4
rotMask
	dc.l	$7C1F7C1F
exp16YMask
	dc.l	$001F001F
exp16XGMask
	dc.l	$FFC0FFC0
	
;///////////////////////////////////////////////////////////////////////////////
;//
;//  Pix15::copy15XETo15XE
;//
;///////////////////////////////////////////////////////////////////////////////

copy15XETo15XE__Pix15__PvPvPUjssss
	COPYNORMAL	1
	rts

;///////////////////////////////////////////////////////////////////////////////
;//
;//  Pix15::copy15XETo15YE
;//
;///////////////////////////////////////////////////////////////////////////////

copy15XETo15YE__Pix15__PvPvPUjssss
	COPYSWAP16
	rts

;///////////////////////////////////////////////////////////////////////////////
;//
;//  Pix15::rotate15BETo15BE
;//
;///////////////////////////////////////////////////////////////////////////////

rotate15BETo15BE__Pix15__PvPvPUjssss
	INIT
	;// scale srcSpan/dstSpan to match pointer size (uint16*)
	lsl.w		#1,		d2
	lsl.w		#1,		d3
	bra.b		.scanlineLoopTest

.scanlineLoop
	;// convert 2 16-bit pixels at once, need w>>1 loops
	move.w	d4,		d6
	lsr.w		#1,		d6
	bra.b		.pixelLoopTest

.pixelLoop
	move.l	(a1)+,	d0
	ROT		d0,		d1
	swap		d0
	ROT		d0,		d1
	swap		d0
	move.l	d0,		(a0)+

.pixelLoopTest
	dbra		d6,		.pixelLoop

.trailingPixel
	btst		#0,		d4
	beq.b		.pixelLoopDone
	move.w	(a1)+,	d0
	ROT		d0,		d1
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
;//  void Pix15::rotate15LETo15LE
;//
;///////////////////////////////////////////////////////////////////////////////

rotate15LETo15LE__Pix15__PvPvPUjssss
	INIT
	;// scale srcSpan/dstSpan to match pointer size (uint16*)
	lsl.w		#1,		d2
	lsl.w		#1,		d3
	bra.b		.scanlineLoopTest

.scanlineLoop
	;// convert 2 16-bit pixels at once, need w>>1 loops
	move.w	d4,		d6
	lsr.w		#1,		d6
	bra.b		.pixelLoopTest

.pixelLoop
	move.l	(a1)+,	d0
	SWP16		d0
	ROT		d0,		d1
	swap		d0
	SWP16		d0
	ROT		d0,		d1	
	move.l	d0,		(a0)+

.pixelLoopTest
	dbra		d6,		.pixelLoop

.trailingPixel
	btst		#0,		d4
	beq.b		.pixelLoopDone
	move.w	(a1)+,	d0
	SWP16		d0
	ROT		d0,		d1
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
;//  void Pix15::rotate15BETo15LE
;//
;///////////////////////////////////////////////////////////////////////////////

rotate15BETo15LE__Pix15__PvPvPUjssss
	INIT
	;// scale srcSpan/dstSpan to match pointer size (uint16*)
	lsl.w		#1,		d2
	lsl.w		#1,		d3
	bra.b		.scanlineLoopTest

.scanlineLoop
	;// convert 2 16-bit pixels at once, need w>>1 loops
	move.w	d4,		d6
	lsr.w		#1,		d6
	bra.b		.pixelLoopTest

.pixelLoop
	move.l	(a1)+,	d0
	ROT		d0,		d1
	SWP16		d0
	swap		d0
	ROT		d0,		d1
	SWP16		d0
	swap		d0
	move.l	d0,		(a0)+

.pixelLoopTest
	dbra		d6,		.pixelLoop

.trailingPixel
	btst		#0,		d4
	beq.b		.pixelLoopDone
	move.w	(a1)+,	d0
	ROT		d0,		d1
	SWP16		d0
	move.w	d0,		(a0)+

.pixelLoopDone
	add.w		d2,		a0
	add.w		d3,		a1

.scanlineLoopTest
	dbra		d5,		.scanlineLoop

	DONE
	rts


;///////////////////////////////////////////////////////////////////////////////
;//
;//  void Pix15::rotate15LETo15BE
;//
;///////////////////////////////////////////////////////////////////////////////

rotate15LETo15BE__Pix15__PvPvPUjssss
	INIT
	;// scale srcSpan/dstSpan to match pointer size (uint16*)
	lsl.w		#1,		d2
	lsl.w		#1,		d3
	bra.b		.scanlineLoopTest

.scanlineLoop
	;// convert 2 16-bit pixels at once, need w>>1 loops
	move.w	d4,		d6
	lsr.w		#1,		d6
	bra.b		.pixelLoopTest

.pixelLoop
	move.l	(a1)+,	d0
	SWP16		d0
	ROT		d0,		d1
	swap		d0
	SWP16		d0
	ROT		d0,		d1
	swap		d0
	move.l	d0,		(a0)+

.pixelLoopTest
	dbra		d6,		.pixelLoop

.trailingPixel
	btst		#0,		d4
	beq.b		.pixelLoopDone
	move.w	(a1)+,	d0
	SWP16		d0
	ROT		d0,		d1
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
;//  void Pix15::copy15BETo16BE
;//
;///////////////////////////////////////////////////////////////////////////////

copy15BETo16BE__Pix15__PvPvPUjssss
	INITX
	lsl.l		#1,				d3
	move.l	exp16YMask,		d5
	move.l	exp16XGMask,	d6
	bra.b		.scanlineLoopTest

.scanlineLoop
	;// convert 2 16-bit pixels at once, need w>>1 loops
	move.l	d2,		d4	;// d4.l = w:h
	swap		d4				;// d4.w = x
	lsr.w		#1,		d4
	bra.b		.pixelLoopTest

.pixelLoop
	move.l	(a1)+,	d0
	EXP16_X2	d0,		d1,		d5,		d6
	move.l	d0,		(a0)+

.pixelLoopTest
	dbra		d4,		.pixelLoop

.trailingPixel
	btst		#16,		d2			;// test lsb of w
	beq.b		.pixelLoopDone
	move.w	(a1)+,	d0
	EXP16_X2	d0,		d1,		d5,		d6
	move.w	d0,		(a0)+

.pixelLoopDone
	;// d3 sMod:dMod
	add.w		d3,		a0
	swap		d3
	add.w		d3,		a1
	swap		d3
	
.scanlineLoopTest
	;// d2 = w:h
	dbra		d2,		.scanlineLoop

.finished
	DONEX
	rts

;///////////////////////////////////////////////////////////////////////////////
;//
;//  void Pix15::copy15LETo16LE
;//
;///////////////////////////////////////////////////////////////////////////////

copy15LETo16LE__Pix15__PvPvPUjssss
	INITX
	lsl.l		#1,				d3
	move.l	exp16YMask,		d5
	move.l	exp16XGMask,	d6
	bra.b		.scanlineLoopTest

.scanlineLoop
	;// convert 2 16-bit pixels at once, need w>>1 loops
	move.l	d2,		d4	;// d4.l = w:h
	swap		d4				;// d4.w = x
	lsr.w		#1,		d4
	bra.b		.pixelLoopTest

.pixelLoop
	move.l	(a1)+,	d0
	SWP16_X2	d0
	EXP16_X2	d0,		d1,		d5,		d6
	SWP16_X2	d0
	move.l	d0,		(a0)+

.pixelLoopTest
	dbra		d4,		.pixelLoop

.trailingPixel
	btst		#16,		d2			;// test lsb of w
	beq.b		.pixelLoopDone
	move.w	(a1)+,	d0
	SWP16		d0
	EXP16_X2	d0,		d1,		d5,		d6
	SWP16		d0
	move.w	d0,		(a0)+

.pixelLoopDone
	;// d3 sMod:dMod
	add.w		d3,		a0
	swap		d3
	add.w		d3,		a1
	swap		d3
	
.scanlineLoopTest
	;// d2 = w:h
	dbra		d2,		.scanlineLoop

.finished
	DONEX
	rts

;///////////////////////////////////////////////////////////////////////////////
;//
;//  void Pix15::copy15BETo16LE
;//
;///////////////////////////////////////////////////////////////////////////////

copy15BETo16LE__Pix15__PvPvPUjssss
	INITX
	lsl.l		#1,				d3
	move.l	exp16YMask,		d5
	move.l	exp16XGMask,	d6
	bra.b		.scanlineLoopTest

.scanlineLoop
	;// convert 2 16-bit pixels at once, need w>>1 loops
	move.l	d2,		d4	;// d4.l = w:h
	swap		d4				;// d4.w = x
	lsr.w		#1,		d4
	bra.b		.pixelLoopTest

.pixelLoop
	move.l	(a1)+,	d0
	EXP16_X2	d0,		d1,		d5,		d6
	SWP16_X2	d0
	move.l	d0,		(a0)+

.pixelLoopTest
	dbra		d4,		.pixelLoop

.trailingPixel
	btst		#16,		d2			;// test lsb of w
	beq.b		.pixelLoopDone
	move.w	(a1)+,	d0
	EXP16_X2	d0,		d1,		d5,		d6
	SWP16		d0
	move.w	d0,		(a0)+

.pixelLoopDone
	;// d3 sMod:dMod
	add.w		d3,		a0
	swap		d3
	add.w		d3,		a1
	swap		d3
	
.scanlineLoopTest
	;// d2 = w:h
	dbra		d2,		.scanlineLoop

.finished
	DONEX
	rts


;///////////////////////////////////////////////////////////////////////////////
;//
;//  void Pix15::copy15LETo16BE
;//
;///////////////////////////////////////////////////////////////////////////////

copy15LETo16BE__Pix15__PvPvPUjssss
	INITX
	lsl.l		#1,				d3
	move.l	exp16YMask,		d5
	move.l	exp16XGMask,	d6
	bra.b		.scanlineLoopTest

.scanlineLoop
	;// convert 2 16-bit pixels at once, need w>>1 loops
	move.l	d2,		d4	;// d4.l = w:h
	swap		d4				;// d4.w = x
	lsr.w		#1,		d4
	bra.b		.pixelLoopTest

.pixelLoop
	move.l	(a1)+,	d0
	SWP16_X2	d0
	EXP16_X2	d0,		d1,		d5,		d6
	move.l	d0,		(a0)+

.pixelLoopTest
	dbra		d4,		.pixelLoop

.trailingPixel
	btst		#16,		d2			;// test lsb of w
	beq.b		.pixelLoopDone
	move.w	(a1)+,	d0
	SWP16		d0
	EXP16_X2	d0,		d1,		d5,		d6
	move.w	d0,		(a0)+

.pixelLoopDone
	;// d3 sMod:dMod
	add.w		d3,		a0
	swap		d3
	add.w		d3,		a1
	swap		d3
	
.scanlineLoopTest
	;// d2 = w:h
	dbra		d2,		.scanlineLoop

.finished
	DONEX
	rts


;///////////////////////////////////////////////////////////////////////////////
;//
;//  void Pix15::rotate15BETo16BE
;//
;///////////////////////////////////////////////////////////////////////////////

rotate15BETo16BE__Pix15__PvPvPUjssss
	INITX
	move.l	d7,				-(a7)
	lsl.l		#1,				d3
	move.l	exp16YMask,		d5
	move.l	exp16XGMask,	d6
	move.l	rotMask,			d7
	bra.b		.scanlineLoopTest

.scanlineLoop
	;// convert 2 16-bit pixels at once, need w>>1 loops
	move.l	d2,		d4	;// d4.l = w:h
	swap		d4				;// d4.w = x
	lsr.w		#1,		d4
	bra.b		.pixelLoopTest

.pixelLoop
	move.l	(a1)+,	d0
	ROT_X2	d0,		d1,		d7
	EXP16_X2	d0,		d1,		d5,		d6
	move.l	d0,		(a0)+

.pixelLoopTest
	dbra		d4,		.pixelLoop

.trailingPixel
	btst		#16,		d2			;// test lsb of w
	beq.b		.pixelLoopDone
	move.w	(a1)+,	d0
	ROT		d0,		d1
	EXP16_X2	d0,		d1,		d5,		d6
	move.w	d0,		(a0)+

.pixelLoopDone
	;// d3 sMod:dMod
	add.w		d3,		a0
	swap		d3
	add.w		d3,		a1
	swap		d3
	
.scanlineLoopTest
	;// d2 = w:h
	dbra		d2,		.scanlineLoop

.finished
	move.l	(a7)+,	d7
	DONEX
	rts

;///////////////////////////////////////////////////////////////////////////////
;//
;//  void Pix15::rotate15LETo16LE
;//
;///////////////////////////////////////////////////////////////////////////////

rotate15LETo16LE__Pix15__PvPvPUjssss
	INIT
	;// scale srcSpan/dstSpan to match pointer size (uint16*)
	lsl.w		#1,		d2
	lsl.w		#1,		d3
	bra.b		.scanlineLoopTest

.scanlineLoop
	;// convert 2 16-bit pixels at once, need w>>1 loops
	move.w	d4,		d6
	lsr.w		#1,		d6
	bra.b		.pixelLoopTest

.pixelLoop
	move.l	(a1)+,	d0
	SWP16		d0
	ROT		d0,		d1
	EXP16		d0,		d1
	SWP16		d0
	swap		d0
	SWP16		d0
	ROT		d0,		d1
	EXP16		d0,		d1
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
	ROT		d0,		d1
	EXP16		d0,		d1
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
;//  void Pix15::rotate15BETo16LE
;//
;///////////////////////////////////////////////////////////////////////////////

rotate15BETo16LE__Pix15__PvPvPUjssss
	INIT
	;// scale srcSpan/dstSpan to match pointer size (uint16*)
	lsl.w		#1,		d2
	lsl.w		#1,		d3
	bra.b		.scanlineLoopTest

.scanlineLoop
	;// convert 2 16-bit pixels at once, need w>>1 loops
	move.w	d4,		d6
	lsr.w		#1,		d6
	bra.b		.pixelLoopTest

.pixelLoop
	move.l	(a1)+,	d0
	ROT		d0,		d1
	EXP16		d0,		d1
	SWP16		d0
	swap		d0
	ROT		d0,		d1
	EXP16		d0,		d1
	SWP16		d0
	swap		d0
	move.l	d0,		(a0)+

.pixelLoopTest
	dbra		d6,		.pixelLoop

.trailingPixel
	btst		#0,		d4
	beq.b		.pixelLoopDone
	move.w	(a1)+,	d0
	ROT		d0,		d1
	EXP16		d0,		d1
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
;//  void Pix15::rotate15LETo16BE
;//
;///////////////////////////////////////////////////////////////////////////////

rotate15LETo16BE__Pix15__PvPvPUjssss
	INIT
	;// scale srcSpan/dstSpan to match pointer size (uint16*)
	lsl.w		#1,		d2
	lsl.w		#1,		d3
	bra.b		.scanlineLoopTest

.scanlineLoop
	;// convert 2 16-bit pixels at once, need w>>1 loops
	move.w	d4,		d6
	lsr.w		#1,		d6
	bra.b		.pixelLoopTest

.pixelLoop
	move.l	(a1)+,	d0
	SWP16		d0
	ROT		d0,		d1
	EXP16		d0,		d1
	swap		d0
	SWP16		d0
	ROT		d0,		d1
	EXP16		d0,		d1
	swap		d0	
	move.l	d0,		(a0)+

.pixelLoopTest
	dbra		d6,		.pixelLoop

.trailingPixel
	btst		#0,		d4
	beq.b		.pixelLoopDone
	move.w	(a1)+,	d0
	SWP16		d0
	ROT		d0,		d1
	EXP16		d0,		d1
	move.w	d0,		(a0)+

.pixelLoopDone
	add.w		d2,	a0
	add.w		d3,	a1

.scanlineLoopTest
	dbra		d5,		.scanlineLoop

.finished
	DONE
	rts


;///////////////////////////////////////////////////////////////////////////////
;//
;//  void Pix15::copy15BETo24XGY
;//
;///////////////////////////////////////////////////////////////////////////////

copy15BETo24XGY__Pix15__PvPvPUjssss
	INIT
	;// scale srcSpan/dstSpan to match pointer size
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
;//  void Pix15::copy15LETo24XGY
;//
;///////////////////////////////////////////////////////////////////////////////

copy15LETo24XGY__Pix15__PvPvPUjssss
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
;//  void Pix15::rotate15BETo24XGY
;//
;///////////////////////////////////////////////////////////////////////////////

rotate15BETo24XGY__Pix15__PvPvPUjssss
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
;//  void Pix15::rotate15LETo24XGY
;//
;///////////////////////////////////////////////////////////////////////////////

rotate15LETo24XGY__Pix15__PvPvPUjssss
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
;//  void Pix15::copy15BETo32BE
;//
;///////////////////////////////////////////////////////////////////////////////

copy15BETo32BE__Pix15__PvPvPUjssss
	INIT
	;// scale spans to match pointer size (uint32*/uint16*)
	lsl.w		#2,		d2
	lsl.w		#1,		d3
	bra.b		.scanlineLoopTest

.scanlineLoop
	;// convert 2 16-bit pixels at once, need w>>1 loops
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
	move.w	d1,		(a0)+

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
;//  void Pix15::copy15LETo32LE
;//
;///////////////////////////////////////////////////////////////////////////////

copy15LETo32LE__Pix15__PvPvPUjssss
	INIT
	;// scale spans to match pointer size (uint32*/uint16*)
	lsl.w		#2,		d2
	lsl.w		#1,		d3
	bra.b		.scanlineLoopTest

.scanlineLoop
	;// convert 2 16-bit pixels at once, need w>>1 loops
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
	move.w	d1,		(a0)+
	
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
;//  void Pix15::copy15BETo32LE
;//
;///////////////////////////////////////////////////////////////////////////////

copy15BETo32LE__Pix15__PvPvPUjssss
	INIT
	;// scale spans to match pointer size (uint32*/uint16*)
	lsl.w		#2,		d2
	lsl.w		#1,		d3
	bra.b		.scanlineLoopTest

.scanlineLoop
	;// convert 2 16-bit pixels at once, need w>>1 loops
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
	move.w	d1,		(a0)+

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
;//  void Pix15::copy15LETo32BE
;//
;///////////////////////////////////////////////////////////////////////////////

copy15LETo32BE__Pix15__PvPvPUjssss
	INIT
	;// scale spans to match pointer size (uint32*/uint16*)
	lsl.w		#2,		d2
	lsl.w		#1,		d3
	bra.b		.scanlineLoopTest

.scanlineLoop
	;// convert 2 16-bit pixels at once, need w>>1 loops
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
	move.w	d1,		(a0)+

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
;//  void Pix15::rotate15BETo32BE
;//
;///////////////////////////////////////////////////////////////////////////////

rotate15BETo32BE__Pix15__PvPvPUjssss
	INIT
	;// scale spans to match pointer size (uint32*/uint16*)
	lsl.w		#2,		d2
	lsl.w		#1,		d3
	bra.b		.scanlineLoopTest

.scanlineLoop
	;// convert 2 16-bit pixels at once, need w>>1 loops
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
	move.w	d1,		(a0)+

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
;//  void Pix15::rotate15LETo32LE
;//
;///////////////////////////////////////////////////////////////////////////////

rotate15LETo32LE__Pix15__PvPvPUjssss
	INIT
	;// scale spans to match pointer size (uint32*/uint16*)
	lsl.w		#2,		d2
	lsl.w		#1,		d3
	bra.b		.scanlineLoopTest

.scanlineLoop
	;// convert 2 16-bit pixels at once, need w>>1 loops
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
	move.w	d1,		(a0)+

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
;//  void Pix15::rotate15BETo32LE
;//
;///////////////////////////////////////////////////////////////////////////////

rotate15BETo32LE__Pix15__PvPvPUjssss
	INIT
	;// scale spans to match pointer size (uint32*/uint16*)
	lsl.w		#2,		d2
	lsl.w		#1,		d3
	bra.b		.scanlineLoopTest

.scanlineLoop
	;// convert 2 16-bit pixels at once, need w>>1 loops
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
	move.w	d1,		(a0)+

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
;//  void Pix15::rotate15LETo32BE
;//
;///////////////////////////////////////////////////////////////////////////////

rotate15LETo32BE__Pix15__PvPvPUjssss
	INIT
	;// scale spans to match pointer size (uint32*/uint16*)
	lsl.w		#2,		d2
	lsl.w		#1,		d3
	bra.b		.scanlineLoopTest

.scanlineLoop
	;// convert 2 16-bit pixels at once, need w>>1 loops
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
	move.w	d1,		(a0)+

.pixelLoopDone
	add.w		d2,		a0
	add.w		d3,		a1

.scanlineLoopTest
	dbra		d5,		.scanlineLoop

.finished
	DONE
	rts

	END
