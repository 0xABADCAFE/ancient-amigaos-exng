;//****************************************************************************//
;//**                                                                        **//
;//** File:         libsrc/plat/amigaos3_68k/gfxlib/pix32opt.asm             **//
;//** Description:  Optimised 32-bit pixel conversion routines               **//
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

	XDEF	copy32BETo15BE__Pix32__PvPvPUjssss
	XDEF	copy32LETo15LE__Pix32__PvPvPUjssss
	XDEF	copy32BETo15LE__Pix32__PvPvPUjssss
	XDEF	copy32LETo15BE__Pix32__PvPvPUjssss
	XDEF	rotate32BETo15BE__Pix32__PvPvPUjssss
	XDEF	rotate32LETo15LE__Pix32__PvPvPUjssss
	XDEF	rotate32BETo15LE__Pix32__PvPvPUjssss
	XDEF	rotate32LETo15BE__Pix32__PvPvPUjssss
	XDEF	copy32BETo16BE__Pix32__PvPvPUjssss
	XDEF	copy32LETo16LE__Pix32__PvPvPUjssss
	XDEF	copy32BETo16LE__Pix32__PvPvPUjssss
	XDEF	copy32LETo16BE__Pix32__PvPvPUjssss
	XDEF	rotate32BETo16BE__Pix32__PvPvPUjssss
	XDEF	rotate32LETo16LE__Pix32__PvPvPUjssss
	XDEF	rotate32BETo16LE__Pix32__PvPvPUjssss
	XDEF	rotate32LETo16BE__Pix32__PvPvPUjssss
	XDEF	copy32BETo24XGY__Pix32__PvPvPUjssss
	XDEF	copy32LETo24XGY__Pix32__PvPvPUjssss
	XDEF	rotate32BETo24XGY__Pix32__PvPvPUjssss
	XDEF	rotate32LETo24XGY__Pix32__PvPvPUjssss
	XDEF	copy32XETo32XE__Pix32__PvPvPUjssss
	XDEF	copy32XETo32YE__Pix32__PvPvPUjssss
	XDEF	rotate32BETo32BE__Pix32__PvPvPUjssss
	XDEF	rotate32LETo32LE__Pix32__PvPvPUjssss
	XDEF	rotate32BETo32LE__Pix32__PvPvPUjssss
	XDEF	rotate32LETo32BE__Pix32__PvPvPUjssss

	MACRO	ROT32
	;// Rotate A:X:G:Y 8:8:8:8 <-> A:Y:G:X 8:8:8:8
									;// dN.l = Aaaaaaaa Xxxxxxxx Gggggggg Yyyyyyyy
	rol.l		#8,			\1	;// dN.l = Xxxxxxxx Gggggggg Yyyyyyyy Aaaaaaaa
	rol.w		#8,			\1	;// dN.l = Xxxxxxxx Gggggggg Aaaaaaaa Yyyyyyyy
	swap		\1					;// dN.l = Aaaaaaaa Yyyyyyyy Xxxxxxxx Gggggggg
	rol.w		#8,			\1	;// dN.l = Aaaaaaaa Yyyyyyyy Gggggggg Xxxxxxxx
	ENDM



	MACRO AXGYTO15
									;// dN.l = Aaaaaaaa Xxxxxxxx Gggggggg Yyyyyyyy
	rol.l		#8,			\1	;// dN.l = Xxxxxxxx Gggggggg Yyyyyyyy Aaaaaaaa
	lsr.b		#7,			\1	;// dN.l = Xxxxxxxx Gggggggg Yyyyyyyy 0000000A
	rol.l		#8,			\1	;// dN.l = Gggggggg Yyyyyyyy 0000000A Xxxxxxxx
	lsr.w		#3,			\1	;// dN.l = Gggggggg Yyyyyyyy 00000000 00AXxxxx
	rol.l		#8,			\1	;// dN.l = Yyyyyyyy 00000000 00AXxxxx Gggggggg
	lsr.w		#3,			\1	;// dN.l = Yyyyyyyy 00000000 00000AXx xxxGgggg
	rol.l		#5,			\1	;// dN.w = -------- -------- AXxxxxGg gggYyyyy
	ENDM

	MACRO AYGXTO15
	ROT32		\1
	AXGYTO15	\1
	ENDM
		
	MACRO AXGYTO16
									;// dN.l = Aaaaaaaa Xxxxxxxx Gggggggg Yyyyyyyy
	swap		\1					;// dN.l = Gggggggg Yyyyyyyy Aaaaaaaa Xxxxxxxx
	lsr.w		#3,			\1	;// dN.l = Gggggggg Yyyyyyyy 000Aaaaa aaaXxxxx
	rol.l		#8,			\1	;// dN.l = Yyyyyyyy 000Aaaaa aaaXxxxx Gggggggg
	lsr.w		#2,			\1	;// dN.l = Yyyyyyyy 00000Aaa aaaaaXxx xxGggggg
	rol.l		#5,			\1	;// dN.w = -------- -------- XxxxxGgg gggYyyyy	
	ENDM

	MACRO AYGXTO16
									;// dN.l = Aaaaaaaa Yyyyyyyy Gggggggg Xxxxxxxx
	lsr.b		#3,			\1	;// dN.l = Aaaaaaaa Yyyyyyyy Gggggggg 000Xxxxx
	rol.w		#6,			\1	;// dN.l = Aaaaaaaa Yyyyyyyy gg000Xxx xxGggggg
	swap		\1					;// dN.l = gg000Xxx xxGggggg Aaaaaaaa Yyyyyyyy
	rol.w		#8,			\1	;// dN.l = gg000Xxx xxGggggg Yyyyyyyy Aaaaaaaa
	lsr.l		#8,			\1	;// dN.l = 00000000 gg000Xxx xxGggggg Yyyyyyyy
	lsr.l		#3,			\1	;// dN.w = -------- -------- XxxxxGgg gggYyyyy
	ENDM

	MACRO YGXATO16
									;// dN.l = Yyyyyyyy Gggggggg Xxxxxxxx Axxxxxxx
	lsr.w		#8,			\1	;// dN.l = Yyyyyyyy Gggggggg 00000000 Xxxxxxxx
	lsr.b		#3,			\1	;// dN.l = Yyyyyyyy Gggggggg 00000000 000Xxxxx
	swap		\1					;// dN.l = 00000000 000Xxxxx Yyyyyyyy Gggggggg
	rol.w		#8,			\1	;// dN.l = 00000000 000Xxxxx Gggggggg Yyyyyyyy
	lsr.l		#3,			\1	;// dN.l = 00000000 000000Xx xxxGgggg gggYyyyy
	ror.l		#5,			\1	;// dN.l = Yyyyy000 00000000 000Xxxxx Gggggggg
	lsr.w		#2,			\1	;// dN.l = Yyyyy000 00000000 00000Xxx xxGggggg
	rol.l		#5,			\1	;// dN.l = 00000000 00000000 XxxxxGgg gggYyyyy
	ENDM

	SECTION ":0", CODE

;///////////////////////////////////////////////////////////////////////////////
;//
;//  void Pix32::copy32BETo15BE
;//
;//  (void* dst, void* src, uint32* sPal, size_t w, size_t h, size_t dstSpan, size_t srcSpan)
;//
;///////////////////////////////////////////////////////////////////////////////

copy32BETo15BE__Pix32__PvPvPUjssss
	INIT
	lsl.w		#1,		d2
	lsl.w		#2,		d3
	bra.b		.scanlineLoopTest

.scanlineLoop
	move.w	d4,		d6
	lsr.w		#1,		d6
	bra.b		.pixelLoopTest

.pixelLoop
	move.l	(a1)+,	d0
	move.l	(a1)+,	d1
	AXGYTO15	d0
	AXGYTO15	d1
	swap		d0
	move.w	d1,		d0
	move.l	d0,		(a0)+

.pixelLoopTest
	dbra		d6,		.pixelLoop

.trailingPixel
	btst		#0,		d4
	beq.b		.pixelLoopDone
	move.l	(a1)+,	d0
	AXGYTO15	d0
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
;//  void Pix32::copy32LETo15LE
;//
;//  (void* dst, void* src, uint32* sPal, size_t w, size_t h, size_t dstSpan, size_t srcSpan)
;//
;///////////////////////////////////////////////////////////////////////////////

copy32LETo15LE__Pix32__PvPvPUjssss
	INIT
	;// scale srcSpan/dstSpan to match pointer size (uint32*/uint16*)
	lsl.w		#1,		d2
	lsl.w		#2,		d3
	bra.b		.scanlineLoopTest

.scanlineLoop
	move.w	d4,		d6
	lsr.w		#1,		d6
	bra.b		.pixelLoopTest

.pixelLoop
	move.l	(a1)+,	d0
	move.l	(a1)+,	d1
	SWP32		d0
	SWP32		d1
	AXGYTO15	d0
	AXGYTO15	d1
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
	move.l	(a1)+,	d0
	SWP32		d0
	AXGYTO15	d0
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
;//  void Pix32::copy32BETo15LE
;//
;//  (void* dst, void* src, uint32* sPal, size_t w, size_t h, size_t dstSpan, size_t srcSpan)
;//
;///////////////////////////////////////////////////////////////////////////////

copy32BETo15LE__Pix32__PvPvPUjssss
	INIT
	;// scale srcSpan/dstSpan to match pointer size (uint32*/uint16*)
	lsl.w		#1,		d2
	lsl.w		#2,		d3

.scanlineLoop
	move.w	d4,		d6
	lsr.w		#1,		d6
	bra.b		.pixelLoopTest

.pixelLoop
	move.l	(a1)+,	d0
	move.l	(a1)+,	d1
	AXGYTO15	d0
	SWP16		d0
	swap		d0
	AXGYTO15	d1
	SWP16		d1
	move.w	d1,		d0
	move.l	d0,		(a0)+

.pixelLoopTest
	dbra		d6,		.pixelLoop

.trailingPixel
	btst		#0,		d4
	beq.b		.pixelLoopDone
	move.l	(a1)+,	d0
	AXGYTO15	d0
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
;//  void Pix32::copy32LETo15BE
;//
;//  (void* dst, void* src, uint32* sPal, size_t w, size_t h, size_t dstSpan, size_t srcSpan)
;//
;///////////////////////////////////////////////////////////////////////////////

copy32LETo15BE__Pix32__PvPvPUjssss
	INIT
	;// scale srcSpan/dstSpan to match pointer size (uint32*/uint16*)
	lsl.w		#1,		d2
	lsl.w		#2,		d3
	bra.b		.scanlineLoopTest

.scanlineLoop
	move.w	d4,		d6
	lsr.w		#1,		d6
	bra.b		.pixelLoopTest

.pixelLoop
	move.l	(a1)+,	d0
	move.l	(a1)+,	d1
	SWP32		d0
	AXGYTO15	d0
	swap		d0
	SWP32		d1
	AXGYTO15	d1
	move.w	d1,		d0
	move.l	d0,		(a0)+

.pixelLoopTest
	dbra		d6,		.pixelLoop

.trailingPixel
	btst		#0,		d4
	beq.b		.pixelLoopDone
	move.l	(a1)+,	d0
	SWP32		d0
	AXGYTO15	d0
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
;//  void Pix32::rotate32BETo15BE
;//
;//  (void* dst, void* src, uint32* sPal, size_t w, size_t h, size_t dstSpan, size_t srcSpan)
;//
;///////////////////////////////////////////////////////////////////////////////

rotate32BETo15BE__Pix32__PvPvPUjssss
	INIT
	;// scale srcSpan/dstSpan to match pointer size (uint32*/uint16*)
	lsl.w		#1,		d2
	lsl.w		#2,		d3
	bra.b		.scanlineLoopTest

.scanlineLoop
	move.w	d4,		d6
	lsr.w		#1,		d6
	bra.b		.pixelLoopTest

.pixelLoop
	move.l	(a1)+,	d0
	move.l	(a1)+,	d1
	AYGXTO15	d0
	swap		d0
	AYGXTO15	d1
	move.w	d1,		d0
	move.l	d0,		(a0)+

.pixelLoopTest
	dbra		d6,		.pixelLoop

.trailingPixel
	btst		#0,		d4
	beq.b		.pixelLoopDone
	move.l	(a1)+,	d0
	AYGXTO15	d0
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
;//  void Pix32::rotate32LETo15LE
;//
;//  (void* dst, void* src, uint32* sPal, size_t w, size_t h, size_t dstSpan, size_t srcSpan)
;//
;///////////////////////////////////////////////////////////////////////////////

rotate32LETo15LE__Pix32__PvPvPUjssss
	INIT
	;// scale srcSpan/dstSpan to match pointer size (uint32*/uint16*)
	lsl.w		#1,		d2
	lsl.w		#2,		d3
	bra.b		.scanlineLoopTest

.scanlineLoop
	move.w	d4,		d6
	lsr.w		#1,		d6
	bra.b		.pixelLoopTest

.pixelLoop
	move.l	(a1)+,	d0
	move.l	(a1)+,	d1
	SWP32		d0
	AYGXTO15	d0
	SWP16		d0
	swap		d0
	SWP32		d1
	AYGXTO15	d1
	SWP16		d1
	move.w	d1,		d0
	move.l	d0,		(a0)+

.pixelLoopTest
	dbra		d6,		.pixelLoop

.trailingPixel
	btst		#0,		d4
	beq.b		.pixelLoopDone
	move.l	(a1)+,	d0
	SWP32		d0
	AYGXTO15	d0
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
;//  void Pix32::rotate32BETo15LE
;//
;//  (void* dst, void* src, uint32* sPal, size_t w, size_t h, size_t dstSpan, size_t srcSpan)
;//
;///////////////////////////////////////////////////////////////////////////////

rotate32BETo15LE__Pix32__PvPvPUjssss
	INIT
	;// scale srcSpan/dstSpan to match pointer size (uint32*/uint16*)
	lsl.w		#1,		d2
	lsl.w		#2,		d3
	bra.b		.scanlineLoopTest

.scanlineLoop
	move.w	d4,		d6
	lsr.w		#1,		d6
	bra.b		.pixelLoopTest

.pixelLoop
	move.l	(a1)+,	d0
	move.l	(a1)+,	d1
	AYGXTO15	d0
	AYGXTO15	d1
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
	move.l	(a1)+,	d0
	AYGXTO15	d0
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
;//  void Pix32::rotate32LETo15BE
;//
;//  (void* dst, void* src, uint32* sPal, size_t w, size_t h, size_t dstSpan, size_t srcSpan)
;//
;///////////////////////////////////////////////////////////////////////////////

rotate32LETo15BE__Pix32__PvPvPUjssss
	INIT
	;// scale srcSpan/dstSpan to match pointer size (uint32*/uint16*)
	lsl.w		#1,		d2
	lsl.w		#2,		d3
	bra.b		.scanlineLoopTest

.scanlineLoop
	move.w	d4,		d6
	lsr.w		#1,		d6
	bra.b		.pixelLoopTest

.pixelLoop
	move.l	(a1)+,	d0
	move.l	(a1)+,	d1
	SWP32		d0
	AYGXTO15	d0
	swap		d0
	SWP32		d1
	AYGXTO15 d1
	move.w	d1,		d0
	move.l	d0,		(a0)+

.pixelLoopTest
	dbra		d6,		.pixelLoop

.trailingPixel
	btst		#0,		d4
	beq.b		.pixelLoopDone
	move.l	(a1)+,	d0
	SWP32		d0
	AYGXTO15	d0
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
;//  void Pix32::copy32BETo16BE
;//
;//  (void* dst, void* src, uint32* sPal, size_t w, size_t h, size_t dstSpan, size_t srcSpan)
;//
;///////////////////////////////////////////////////////////////////////////////

copy32BETo16BE__Pix32__PvPvPUjssss
	INIT
	;// scale srcSpan/dstSpan to match pointer size (uint32*/uint16*)
	lsl.w		#1,		d2
	lsl.w		#2,		d3
	bra.b		.scanlineLoopTest

.scanlineLoop
	move.w	d4,		d6
	lsr.w		#1,		d6
	bra.b		.pixelLoopTest

.pixelLoop
	move.l	(a1)+,	d0
	move.l	(a1)+,	d1
	AXGYTO16	d0
	swap		d0
	AXGYTO16	d1
	move.w	d1,		d0
	move.l	d0,		(a0)+

.pixelLoopTest
	dbra		d6,		.pixelLoop

.trailingPixel
	btst		#0,		d4
	beq.b		.pixelLoopDone
	move.l	(a1)+,	d0
	AXGYTO16	d0
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
;//  void Pix32::copy32LETo16LE
;//
;//  (void* dst, void* src, uint32* sPal, size_t w, size_t h, size_t dstSpan, size_t srcSpan)
;//
;///////////////////////////////////////////////////////////////////////////////

copy32LETo16LE__Pix32__PvPvPUjssss
	INIT
	;// scale srcSpan/dstSpan to match pointer size (uint32*/uint16*)
	lsl.w		#1,		d2
	lsl.w		#2,		d3
	bra.b		.scanlineLoopTest

.scanlineLoop
	move.w	d4,		d6
	lsr.w		#1,		d6
	bra.b		.pixelLoopTest

.pixelLoop
	move.l	(a1)+,	d0
	move.l	(a1)+,	d1
	SWP32		d0
	SWP32		d1
	AXGYTO16	d0
	AXGYTO16	d1
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
	move.l	(a1)+,	d0
	SWP32		d0
	AXGYTO16	d0
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
;//  void Pix32::copy32BETo16LE
;//
;//  (void* dst, void* src, uint32* sPal, size_t w, size_t h, size_t dstSpan, size_t srcSpan)
;//
;///////////////////////////////////////////////////////////////////////////////

copy32BETo16LE__Pix32__PvPvPUjssss
	INIT
	;// scale srcSpan/dstSpan to match pointer size (uint32*/uint16*)
	lsl.w		#1,		d2
	lsl.w		#2,		d3
	bra.b		.scanlineLoopTest

.scanlineLoop
	move.w	d4,		d6
	lsr.w		#1,		d6
	bra.b		.pixelLoopTest

.pixelLoop
	move.l	(a1)+,	d0
	move.l	(a1)+,	d1
	AXGYTO16	d0
	AXGYTO16	d1
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
	move.l	(a1)+,	d0
	AXGYTO16	d0
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
;//  void Pix32::copy32LETo16BE
;//
;//  (void* dst, void* src, uint32* sPal, size_t w, size_t h, size_t dstSpan, size_t srcSpan)
;//
;///////////////////////////////////////////////////////////////////////////////

copy32LETo16BE__Pix32__PvPvPUjssss
	INIT
	;// scale srcSpan/dstSpan to match pointer size (uint32*/uint16*)
	lsl.w		#1,		d2
	lsl.w		#2,		d3
	bra.b		.scanlineLoopTest

.scanlineLoop
	move.w	d4,		d6
	lsr.w		#1,		d6
	bra.b		.pixelLoopTest

.pixelLoop
	move.l	(a1)+,	d0
	move.l	(a1)+,	d1
	SWP32		d0
	SWP32		d1
	AXGYTO16	d0
	AXGYTO16	d1
	swap		d0
	move.w	d1,		d0
	move.l	d0,		(a0)+

.pixelLoopTest
	dbra		d6,		.pixelLoop

.trailingPixel
	btst		#0,		d4
	beq.b		.pixelLoopDone
	move.l	(a1)+,	d0
	AXGYTO16	d0
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
;//  void Pix32::rotate32BETo16BE
;//
;//  (void* dst, void* src, uint32* sPal, size_t w, size_t h, size_t dstSpan, size_t srcSpan)
;//
;///////////////////////////////////////////////////////////////////////////////

rotate32BETo16BE__Pix32__PvPvPUjssss
	INIT
	;// scale srcSpan/dstSpan to match pointer size (uint32*/uint16*)
	lsl.w		#1,		d2
	lsl.w		#2,		d3
	bra.b		.scanlineLoopTest

.scanlineLoop
	move.w	d4,		d6
	lsr.w		#1,		d6
	bra.b		.pixelLoopTest

.pixelLoop
	move.l	(a1)+,	d0
	move.l	(a1)+,	d1
	AYGXTO16	d0
	AYGXTO16	d1
	swap		d0
	move.w	d1,		d0
	move.l	d0,		(a0)+

.pixelLoopTest
	dbra		d6,		.pixelLoop

.trailingPixel
	btst		#0,		d4
	beq.b		.pixelLoopDone
	move.l	(a1)+,	d0
	AYGXTO16	d0
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
;//  void Pix32::rotate32LETo16LE
;//
;//  (void* dst, void* src, uint32* sPal, size_t w, size_t h, size_t dstSpan, size_t srcSpan)
;//
;///////////////////////////////////////////////////////////////////////////////

rotate32LETo16LE__Pix32__PvPvPUjssss
	INIT
	;// scale srcSpan/dstSpan to match pointer size (uint32*/uint16*)
	lsl.w		#1,		d2
	lsl.w		#2,		d3
	bra.b		.scanlineLoopTest

.scanlineLoop
	move.w	d4,		d6
	lsr.w		#1,		d6
	bra.b		.pixelLoopTest

.pixelLoop
	move.l	(a1)+,	d0
	move.l	(a1)+,	d1
	SWP32		d0
	SWP32		d1
	AYGXTO16	d0
	AYGXTO16	d1
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
	move.l	(a1)+,	d0
	SWP32		d0
	AYGXTO16	d0
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
;//  void Pix32::rotate32BETo16LE
;//
;//  (void* dst, void* src, uint32* sPal, size_t w, size_t h, size_t dstSpan, size_t srcSpan)
;//
;///////////////////////////////////////////////////////////////////////////////

rotate32BETo16LE__Pix32__PvPvPUjssss
	INIT
	;// scale srcSpan/dstSpan to match pointer size (uint32*/uint16*)
	lsl.w		#1,		d2
	lsl.w		#2,		d3
	bra.b		.scanlineLoopTest

.scanlineLoop
	move.w	d4,		d6
	lsr.w		#1,		d6
	bra.b		.pixelLoopTest

.pixelLoop
	move.l	(a1)+,	d0
	move.l	(a1)+,	d1
	AYGXTO16	d0
	AYGXTO16	d1
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
	move.l	(a1)+,	d0
	AYGXTO16	d0
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
;//  void Pix32::rotate32LETo16BE
;//
;//  (void* dst, void* src, uint32* sPal, size_t w, size_t h, size_t dstSpan, size_t srcSpan)
;//
;///////////////////////////////////////////////////////////////////////////////

rotate32LETo16BE__Pix32__PvPvPUjssss
	INIT
	;// scale srcSpan/dstSpan to match pointer size (uint32*/uint16*)
	lsl.w		#1,		d2
	lsl.w		#2,		d3
	bra.b		.scanlineLoopTest

.scanlineLoop
	move.w	d4,		d6
	lsr.w		#1,		d6
	bra.b		.pixelLoopTest

.pixelLoop
	move.l	(a1)+,	d0
	move.l	(a1)+,	d1
	SWP32		d0
	SWP32		d1
	AYGXTO16	d0
	AYGXTO16	d1
	swap		d0
	move.w	d1,		d0
	move.l	d0,		(a0)+

.pixelLoopTest
	dbra		d6,		.pixelLoop

.trailingPixel
	btst		#0,		d4
	beq.b		.pixelLoopDone
	move.l	(a1)+,	d0
	SWP32		d0
	AYGXTO16	d0
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
;//  void Pix32::copy32BETo24XGY
;//
;//  (void* dst, void* src, uint32* sPal, size_t w, size_t h, size_t dstSpan, size_t srcSpan)
;//
;///////////////////////////////////////////////////////////////////////////////

copy32BETo24XGY__Pix32__PvPvPUjssss
	INIT
	;// scale srcSpan/dstSpan to match pointer size (uint32*/uint16*)
	move.w	d2,		d0
	lsl.w		#1,		d2
	add.w		d0,		d2
	lsl.w		#2,		d3
	bra.b		.scanlineLoopTest

.scanlineLoop
	move.w	d4,		d6
	bra.b		.pixelLoopTest

.pixelLoop
	move.l	(a1)+,	d0		;// d0 = AA XX GG YY
	swap		d0					;// d0 = GG YY AA XX
	move.b	d0,		(a0)+
	rol.l		#8,		d0		;// d0 = YY AA XX GG
	move.b	d0,		(a0)+
	rol.l		#8,		d0		;// d0 = AA XX GG YY
	move.b	d0,		(a0)+

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
;//  void Pix32::copy32LETo24XGY
;//
;//  (void* dst, void* src, uint32* sPal, size_t w, size_t h, size_t dstSpan, size_t srcSpan)
;//
;///////////////////////////////////////////////////////////////////////////////

copy32LETo24XGY__Pix32__PvPvPUjssss
	INIT
	;// scale srcSpan/dstSpan to match pointer size (uint32*/uint16*)
	move.w	d2,		d0
	lsl.w		#1,		d2
	add.w		d0,		d2
	lsl.w		#2,		d3
	bra.b		.scanlineLoopTest

.scanlineLoop
	move.w	d4,		d6
	bra.b		.pixelLoopTest

.pixelLoop
	move.l	(a1)+,	d0		;// d0 = YY GG XX AA
	lsr.l		#8,		d0		;// d0 = 00 YY GG XX
	move.b	d0,		(a0)+
	lsr.l		#8,		d0		;// d0 = 00 00 YY GG
	move.b	d0,		(a0)+
	lsr.l		#8,		d0		;// d0 = 00 00 00 YY
	move.b	d0,		(a0)+

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
;//  void Pix32::rotate32BETo24XGY
;//
;//  (void* dst, void* src, uint32* sPal, size_t w, size_t h, size_t dstSpan, size_t srcSpan)
;//
;///////////////////////////////////////////////////////////////////////////////

rotate32BETo24XGY__Pix32__PvPvPUjssss
	INIT
	;// scale srcSpan/dstSpan to match pointer size (uint32*/uint16*)
	move.w	d2,		d0
	lsl.w		#1,		d2
	add.w		d0,		d2
	lsl.w		#2,		d3
	bra.b		.scanlineLoopTest

.scanlineLoop
	move.w	d4,		d6
	bra.b		.pixelLoopTest

.pixelLoop
	move.l	(a1)+,	d0		;// d0 = AA YY GG XX
	move.b	d0,		(a0)+
	lsr.l		#8,		d0		;// d0 = 00 AA YY GG
	move.b	d0,		(a0)+
	lsr.l		#8,		d0		;// d0 = 00 00 AA YY
	move.b	d0,		(a0)+

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
;//  void Pix32::rotate32LETo24XGY
;//
;//  (void* dst, void* src, uint32* sPal, size_t w, size_t h, size_t dstSpan, size_t srcSpan)
;//
;///////////////////////////////////////////////////////////////////////////////

rotate32LETo24XGY__Pix32__PvPvPUjssss
	INIT
	;// scale srcSpan/dstSpan to match pointer size (uint32*/uint16*)
	move.w	d2,		d0
	lsl.w		#1,		d2
	add.w		d0,		d2
	lsl.w		#2,		d3
	bra.b		.scanlineLoopTest

.scanlineLoop
	move.w	d4,		d6
	bra.b		.pixelLoopTest

.pixelLoop
	move.l	(a1)+,	d0		;// d0 = XX GG YY AA
	rol.l		#8,		d0		;// d0 = GG YY AA XX
	move.b	d0,		(a0)+
	rol.l		#8,		d0		;// d0 = YY AA XX GG
	move.b	d0,		(a0)+
	rol.l		#8,		d0		;// d0 = AA XX GG YY
	move.b	d0,		(a0)+

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
;//  void Pix32::copy32XETo32XE
;//
;//  (void* dst, void* src, uint32* sPal, size_t w, size_t h, size_t dstSpan, size_t srcSpan)
;//
;///////////////////////////////////////////////////////////////////////////////

copy32XETo32XE__Pix32__PvPvPUjssss
	COPYNORMAL 2
	rts

;///////////////////////////////////////////////////////////////////////////////
;//
;//  void Pix32::copy32XETo32YE
;//
;//  (void* dst, void* src, uint32* sPal, size_t w, size_t h, size_t dstSpan, size_t srcSpan)
;//
;///////////////////////////////////////////////////////////////////////////////

copy32XETo32YE__Pix32__PvPvPUjssss
	COPYSWAP32
	rts

;///////////////////////////////////////////////////////////////////////////////
;//
;//  void Pix32::rotate32BETo32BE
;//
;//  (void* dst, void* src, uint32* sPal, size_t w, size_t h, size_t dstSpan, size_t srcSpan)
;//
;///////////////////////////////////////////////////////////////////////////////

rotate32BETo32BE__Pix32__PvPvPUjssss
	INIT
	;// scale srcSpan/dstSpan to match pointer size (uint32*)
	lsl.w		#2,		d2
	lsl.w		#2,		d3
	bra.b		.scanlineLoopTest

.scanlineLoop
	move.w	d4,		d6
	bra.b		.pixelLoopTest

.pixelLoop
	move.l	(a1)+,	d0
	ROT32		d0
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
;//  void Pix32::rotate32LETo32LE
;//
;//  (void* dst, void* src, uint32* sPal, size_t w, size_t h, size_t dstSpan, size_t srcSpan)
;//
;///////////////////////////////////////////////////////////////////////////////

rotate32LETo32LE__Pix32__PvPvPUjssss
	INIT
	;// scale srcSpan/dstSpan to match pointer size (uint32*)
	lsl.w		#2,		d2
	lsl.w		#2,		d3
	bra.b		.scanlineLoopTest

.scanlineLoop
	move.w	d4,		d6
	bra.b		.pixelLoopTest

.pixelLoop
	move.l	(a1)+,	d0	;// d0.l = XX GG YY AA
	ror.l		#8,		d0 ;// d0.l = AA XX GG YY
	rol.w		#8,		d0 ;// d0.l = AA XX YY GG
	swap		d0				;// d0.l = YY GG AA XX
	rol.w		#8,		d0 ;// d0.l = YY GG XX AA
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
;//  void Pix32::rotate32BETo32LE
;//
;//  (void* dst, void* src, uint32* sPal, size_t w, size_t h, size_t dstSpan, size_t srcSpan)
;//
;///////////////////////////////////////////////////////////////////////////////

rotate32BETo32LE__Pix32__PvPvPUjssss
	INIT
	;// scale srcSpan/dstSpan to match pointer size (uint32*)
	lsl.w		#2,		d2
	lsl.w		#2,		d3
	bra.b		.scanlineLoopTest

.scanlineLoop
	move.w	d4,		d6
	bra.b		.pixelLoopTest

.pixelLoop
	move.l	(a1)+,	d0	;// d0.l = AA YY GG XX
	rol.l		#8,		d0	;// d0.l = YY GG XX AA
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
;//  void Pix32::rotate32LETo32BE
;//
;//  (void* dst, void* src, uint32* sPal, size_t w, size_t h, size_t dstSpan, size_t srcSpan)
;//
;///////////////////////////////////////////////////////////////////////////////

rotate32LETo32BE__Pix32__PvPvPUjssss
	INIT
	;// scale srcSpan/dstSpan to match pointer size (uint32*)
	lsl.w		#2,		d2
	lsl.w		#2,		d3
	bra.b		.scanlineLoopTest

.scanlineLoop
	move.w	d4,		d6
	bra.b		.pixelLoopTest

.pixelLoop
	move.l	(a1)+,	d0	;// d0.l = XX GG YY AA
	ror.l		#8,		d0 ;// d0.l = AA XX GG YY
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
