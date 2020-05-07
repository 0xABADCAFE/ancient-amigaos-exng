;//****************************************************************************//
;//**                                                                        **//
;//** File:         libsrc/plat/amigaos3_68k/systemlib/memopt.asm            **//
;//** Description:  Optimised memory clear/set/copy/swap routines            **//
;//** Comment(s):                                                            **//
;//** Library:      systemlib                                                **//
;//** Created:      2003-02-09                                               **//
;//** Updated:      2003-02-09                                               **//
;//** Author(s):    Karl Churchill                                           **//
;//** Note(s):      Asm definitions for 68K Mem class functions              **//
;//** Copyright:    (C)1996-2003, eXtropia Studios                           **//
;//**               Serkan YAZICI, Karl Churchill                            **//
;//**               All Rights Reserved.                                     **//
;//**                                                                        **//
;//****************************************************************************//

	mc68040

	XDEF	zero__Mem__r8Pvr0Ui
	XDEF	set__Mem__r8Pvr0ir1Ui
	XDEF	set16__Mem__r8Pvr0Usr1Ui
	XDEF	set32__Mem__r8Pvr0Ujr1Ui
	XDEF	set64__Mem__r8Pvr9RUlr0Ui
	XDEF	copy__Mem__r8Pvr9Pvr0Ui
	XDEF	swap16__Mem__r8Pvr9Pvr0Ui
	XDEF	swap32__Mem__r8Pvr9Pvr0Ui
	XDEF	swap64__Mem__r8Pvr9Pvr0Ui

	XDEF	copy16__Mem

;////////////////////////////////////////////////////////////////////////////////
;//
;//  All functions trash d0, d1, a0, a1
;//
;//  Wherever possible, data is moved using full 32-bit bus aligned transfers
;//  Large data moves are unrolled to move up to 64 bytes per loop
;//
;////////////////////////////////////////////////////////////////////////////////


	SECTION "zero and set:0",CODE


;////////////////////////////////////////////////////////////////////////////////
;//
;//  void Mem::zero([a0]void* dst, [d0]size_t len)
;//
;////////////////////////////////////////////////////////////////////////////////

zero__Mem__r8Pvr0Ui
	move.l d0,	d1
	moveq	#0,	d0
	;// drop through

;////////////////////////////////////////////////////////////////////////////////
;//
;//  void Mem::set([a0] void* dst, [d0] int c, [d1] size_t len)
;//
;////////////////////////////////////////////////////////////////////////////////


set__Mem__r8Pvr0ir1Ui
	tst.l		d1
	bgt.b		set_Small
	rts

set_Small
	cmp.l		#3,		d1
	bls.b		set_TrailingBytes

	move.l	d1,		a1
	bra.b		set_Loop
	
set_Align32	
	move.l	d1,		a1;// save d1 in a1 as scratch
	move.l	a0,		d1
	and.l		#3,		d1;// start = ((uint32)dst & 3UL)
	beq.b		set_Loop
	exg		d0,		a1
	subq		#4,		d0
	add.l		d1,		d0;// len -= (4+start)
	subq		#1,		d1
	exg		d0,		a1
	jmp		.start(pc, d1.l*2)

.start
	move.b	d0,		(a0)+
	move.b	d0,		(a0)+
	move.b	d0,		(a0)+

	;// Has start alignment caused len to drop below 4?
	move.l	a1,		d1
	cmp.l		#3,		d1
	bls.b		set_TrailingBytes

set_Loop
	;// d0 value
	;// d1 counter
	;// d2 scratch
	;// a0 dst

	;// Make 32-bit version of byte to set

	move.b	d0,		d1	;// d1 = 00:00:00:XX
	rol.w		#8,		d1	;// d1 = 00:00:XX:00
	move.b	d0,		d1	;// d1 = 00:00:XX:XX
	move.w	d1,		d0 ;// d0 = 00:00:XX:XX
	swap		d0				;// d0 = XX:XX:00:00
	move.w	d1,		d0	;// d0 = XX:XX:XX:XX

	move.l	a1,		d1 ;// restore len in d1
	move.l	d2,-(a7)		;// save copy on stack

	move.l	d1,		d2	
	add.l		#60,		d1
	lsr.l		#2,		d2
	lsr.l		#6,		d1 ;// d1 = (len+60)>>6
	and.l		#15,		d2 ;// d2 = (len>>2)&15
	beq.b		.case0
	neg.w		d2
	add.w		#16,		d2
	jmp		.case0(pc, d2.w*2)

	CNOP	0,4
.case0	move.l	d0,	(a0)+
.case15	move.l	d0,	(a0)+
.case14	move.l	d0,	(a0)+
.case13	move.l	d0,	(a0)+
.case12	move.l	d0,	(a0)+
.case11	move.l	d0,	(a0)+
.case10	move.l	d0,	(a0)+
.case9	move.l	d0,	(a0)+
.case8	move.l	d0,	(a0)+
.case7	move.l	d0,	(a0)+
.case6	move.l	d0,	(a0)+
.case5	move.l	d0,	(a0)+
.case4	move.l	d0,	(a0)+
.case3	move.l	d0,	(a0)+
.case2	move.l	d0,	(a0)+
.case1	move.l	d0,	(a0)+

	subq.l	#1,		d1
	bgt.b		.case0
	
	move.l	(a7)+,	d2
	move.l	a1,		d1 ;// restore len
	
set_TrailingBytes
	move.l	d0,		a1 ;// save d0 value to scratch
	moveq		#3,		d0
	and.l		d0,		d1 ;// d1 = len & 3
	sub.l		d1,		d0 ;// d0 = 3 - (len&3)
	move.l	a1,		d1 ;// restore scratch, d1 = value
	jmp		.end(pc, d0.l*2)

.end
	move.b	d1,	(a0)+
	move.b	d1,	(a0)+
	move.b	d1,	(a0)+
	rts

;// endbytes jump debug
	move.l	$0BADC0DE, d0
	rts

;////////////////////////////////////////////////////////////////////////////////
;//
;//  void Mem::set16([a0] void* dst, [d0] uint16 c, [d1] size_t cnt)
;//
;////////////////////////////////////////////////////////////////////////////////

set16__Mem__r8Pvr0Usr1Ui
	tst.l		d1
	bgt.b		set16_AlignCheck
	rts

set16_AlignCheck
	move.l	d1,		a1
	move.l	a0,		d1
	and.l		#1,		d1
	beq.b		set16_Small
	rts
	
set16_Small
	;// count of 1?
	move.l	a1,		d1
	cmp.l		#1,		d1
	bgt.b		set16_Align32
	move.w	d0,		(a0)+
	rts
	
set16_Align32
	;// check start for 32-bit alignment
	move.l	a0,		d1
	and.l		#2,		d1
	exg		d1,		a1
	beq.b		set16_Loop

	;// write first word
	move.w	d0,		(a0)+
	subq		#1,		d1

	;// test if remaining count > 1 else write last word
	cmp.l		#1,		d1
	bgt.b		set16_Loop
	move.w	d0,		(a0)+
	rts	


set16_Loop
	;// d0 value
	;// d1 counter
	;// d2 scratch
	;// a0 dst
	;// a1 scratch
	
	move.l	d1,		a1

	;// Make 32-bit version of byte to set
	move.w	d0,		d1	;// d1 = 00:00:XX:XX
	swap		d0				;// d0 = XX:XX:00:00
	move.w	d1,		d0	;// d0 = XX:XX:XX:XX

	move.l	a1,		d1 ;// restore len in d1
	move.l	d2,-(a7)		;// save d2 on stack

	move.l	d1,		d2	
	add.l		#30,		d1
	lsr.l		#1,		d2
	lsr.l		#5,		d1 ;// d1 = (cnt+30)>>5
	and.l		#15,		d2 ;// d2 = (cnt>>1)&15
	beq.b		.case0
	neg.w		d2
	add.w		#16,		d2
	jmp		.case0(pc, d2.w*2)

	CNOP	0,4
.case0	move.l	d0,	(a0)+
.case15	move.l	d0,	(a0)+
.case14	move.l	d0,	(a0)+
.case13	move.l	d0,	(a0)+
.case12	move.l	d0,	(a0)+
.case11	move.l	d0,	(a0)+
.case10	move.l	d0,	(a0)+
.case9	move.l	d0,	(a0)+
.case8	move.l	d0,	(a0)+
.case7	move.l	d0,	(a0)+
.case6	move.l	d0,	(a0)+
.case5	move.l	d0,	(a0)+
.case4	move.l	d0,	(a0)+
.case3	move.l	d0,	(a0)+
.case2	move.l	d0,	(a0)+
.case1	move.l	d0,	(a0)+

	subq.l	#1,		d1
	bgt.b		.case0
	
	move.l	(a7)+,	d2
	move.l	a1,		d1 ;// restore len
	and.l		#1,		d1
	beq		set16_Done

set16_TrailingWord
	move.w	d0,		(a0)+

set16_Done
	rts

;// endbytes jump debug
	move.l	$0BADC0DE, d0
	rts

;////////////////////////////////////////////////////////////////////////////////
;//
;//  void Mem::set32([a0] void* dst, [d0] uint32 c, [d1] size_t cnt)
;//
;////////////////////////////////////////////////////////////////////////////////

set32__Mem__r8Pvr0Ujr1Ui
	tst.l		d1
	bgt.b		set32_AlignCheck
	rts

set32_AlignCheck
	move.l	d1,		a1
	move.l	a0,		d1
	and.l		#1,		d1
	exg		a1,		d1
	beq		set32_Loop
	rts
	
set32_Loop
	;// d0 value
	;// d1 counter
	;// d2 scratch
	;// a0 dst
	;// a1 scratch
	
	move.l	d2,	-(a7)	;// save d2 on stack

	move.l	d1,		d2	
	add.l		#15,		d1
	lsr.l		#4,		d1 ;// d1 = (cnt+15)>>4
	and.l		#15,		d2 ;// d2 = cnt&15
	beq.b		.case0
	neg.w		d2
	add.w		#16,		d2
	jmp		.case0(pc, d2.w*2)

	CNOP	0,4
.case0	move.l	d0,	(a0)+
.case15	move.l	d0,	(a0)+
.case14	move.l	d0,	(a0)+
.case13	move.l	d0,	(a0)+
.case12	move.l	d0,	(a0)+
.case11	move.l	d0,	(a0)+
.case10	move.l	d0,	(a0)+
.case9	move.l	d0,	(a0)+
.case8	move.l	d0,	(a0)+
.case7	move.l	d0,	(a0)+
.case6	move.l	d0,	(a0)+
.case5	move.l	d0,	(a0)+
.case4	move.l	d0,	(a0)+
.case3	move.l	d0,	(a0)+
.case2	move.l	d0,	(a0)+
.case1	move.l	d0,	(a0)+

	subq.l	#1,		d1
	bgt.b		.case0
	move.l	(a7)+,	d2
	rts

;// endbytes jump debug
	move.l	$0BADC0DE, d0
	rts


;////////////////////////////////////////////////////////////////////////////////
;//
;//  void Mem::set64([a0] void* dst, [a1] uint64& c, [d0] size_t cnt)
;//
;////////////////////////////////////////////////////////////////////////////////


set64__Mem__r8Pvr9RUlr0Ui
	tst.l		d0
	bgt		set64_AlignCheck
	rts

set64_AlignCheck
	move.l	a0,		d1
	and.l		#1,		d1
	beq.b		set64_AlignCheck2
	rts

set64_AlignCheck2
	move.l	a1,		d1
	and.l		#1,		d1
	beq.b		set64_Loop
	rts


set64_Loop
	movem.l	d2/d3,	-(a7)
	move.l	(a1),		d2
	move.l	4(a1),	d3
	move.l	d0,		d1
	addq		#7,		d0
	lsr.l		#3,		d0 ;// d0 = (cnt+7)>>3
	and.l		#7,		d1	;// d1 = (cnt & 7)
	beq.b		.case0
	neg.w		d1
	add.w		#16,		d1
	jmp		.case0(pc,d1.w*4)

.case0	move.l	d2, (a0)+
			move.l	d3, (a0)+
.case7	move.l	d2, (a0)+
			move.l	d3, (a0)+
.case6	move.l	d2, (a0)+
			move.l	d3, (a0)+
.case5	move.l	d2, (a0)+
			move.l	d3, (a0)+
.case4	move.l	d2, (a0)+
			move.l	d3, (a0)+
.case3	move.l	d2, (a0)+
			move.l	d3, (a0)+
.case2	move.l	d2, (a0)+
			move.l	d3, (a0)+
.case1	move.l	d2, (a0)+
			move.l	d3, (a0)+

	subq.l	#1,	d0
	bgt.b		.case0

	movem.l	(a7)+,	d2/d3
	rts

;////////////////////////////////////////////////////////////////////////////////


	SECTION "copy:0",CODE

	XREF	_SysBase
LVO_CopyMem EQU -$270

;////////////////////////////////////////////////////////////////////////////////
;//
;//  void Mem::copy([a0]void* dst, [a1]void* src, [d0]size_t cnt)
;//
;//  Source and destination must be at least 16-bit aligned.
;//  Best performance when both are 32-bit aligned
;//
;////////////////////////////////////////////////////////////////////////////////

copy__Mem__r8Pvr9Pvr0Ui
	tst.l		d0
	bgt.b		copy_Small
	rts

copy_Small
	cmp.l		#3,		d0
	bls		copy_TrailingBytes

copy_DestTest
	move.l	a0,		d1
	and.l		#1,		d1
	beq		copy_SourceTest

	;// fall back onto exec/copyMem()
	exg		a0,		a1
	move.l	a6,		-(a7)
	move.l	_SysBase,a6
	jsr		LVO_CopyMem(a6)
	move.l	(a7)+,	a6
	rts

copy_SourceTest
	move.l	a1,		d1
	and.l		#1,		d1
	beq		copy_Loop

	;// fall back onto exec/CopyMem()
	exg		a0,		a1
	move.l	a6,		-(a7)
	move.l	_SysBase,a6
	jsr		LVO_CopyMem(a6)
	move.l	(a7)+,	a6
	rts

copy_Loop
	;// d0 counter
	;// d1 scratch
	;// a0 src
	;// a1 dst
	move.l	d0,		-(a7)
	move.l	d0,		d1
	add.l		#60,		d0
	lsr.l		#2,		d1
	lsr.l		#6,		d0		;// d0 = (len+60)>>6
	and.l		#$F,		d1		;// d1 = (len>>2) & 15
	beq		.case0
	neg.w		d1
	add.w		#16,		d1
	jmp		.case0(pc, d1.w*2)

	CNOP	0,4
.case0	move.l	(a1)+,	(a0)+
.case15	move.l	(a1)+,	(a0)+
.case14	move.l	(a1)+,	(a0)+	
.case13	move.l	(a1)+,	(a0)+
.case12	move.l	(a1)+,	(a0)+
.case11	move.l	(a1)+,	(a0)+
.case10	move.l	(a1)+,	(a0)+
.case9	move.l	(a1)+,	(a0)+
.case8	move.l	(a1)+,	(a0)+
.case7	move.l	(a1)+,	(a0)+
.case6	move.l	(a1)+,	(a0)+
.case5	move.l	(a1)+,	(a0)+
.case4	move.l	(a1)+,	(a0)+
.case3	move.l	(a1)+,	(a0)+
.case2	move.l	(a1)+,	(a0)+
.case1	move.l	(a1)+,	(a0)+

	subq.l	#1,		d0
	bgt.b		.case0
	move.l	(a7)+,	d0

copy_TrailingBytes
	moveq		#3,		d1
	and.l		d1,		d0
	sub.l		d0,		d1
	jmp		.end(pc, d1.l*2)

.end
	move.b	(a1)+,	(a0)+
	move.b	(a1)+,	(a0)+
	move.b	(a1)+,	(a0)+
	rts

;// endbytes jump debug
	move.l	$0BADC0DE, d0
	rts

;////////////////////////////////////////////////////////////////////////////////


	SECTION "swap:0",CODE


;////////////////////////////////////////////////////////////////////////////////
;//
;//  void Mem::swap16([a0]void* dst, [a1]void* src, [d0]size_t cnt)
;//
;//  Source and destination must be at least 16-bit aligned.
;//  Best performance when both are 32-bit aligned
;//
;////////////////////////////////////////////////////////////////////////////////

	MACRO SWAP16
	move.l	(a1)+,	d1
	rol.w		#8,		d1			; // AA BB CC DD -> AA BB DD CC
	swap		d1						; // AA BB DD CC -> DD CC AA BB
	rol.w		#8,		d1			; // DD CC AA BB -> DD CC BB AA
	swap		d1						; // DD CC BB AA -> BB AA DD CC
	move.l	d1,		(a0)+
	ENDM

swap16__Mem__r8Pvr9Pvr0Ui
	tst.l		d0
	bgt		swap16_DestTest
	rts

swap16_DestTest
	move.l	a0,		d1
	and.l		#1,		d1
	beq		swap16_SourceTest
	rts

swap16_SourceTest
	move.l	a1,		d1
	and.l		#1,		d1
	beq		swap16_swap
	rts

swap16_swap
	cmp.l		#1,		d0
	beq		swap16_TrailingWord
	;// d0 counter
	;// d1 scratch
	;// a0 src
	;// a1 dst
	;// a2 jump target
	movem.l	d0/a2,	-(a7)
	move.l	d0,		d1
	add.l		#30,		d0
	lsr.l		#5,		d0	;// d0 = (cnt+30)>>5;
	lsr.l		#1,		d1
	and.l		#$F,		d1 ;// d1 = ((cnt>>1) & 15)
	move.l	.switch(pc,d1.l*4),a2
	jmp		(a2)

.switch
	dc.l .case0,	.case1,	.case2,	.case3
	dc.l .case4,	.case5,	.case6,	.case7
	dc.l .case8,	.case9,	.case10,	.case11
	dc.l .case12,	.case13,	.case14,	.case15

.case0	SWAP16
.case15	SWAP16
.case14	SWAP16
.case13	SWAP16
.case12	SWAP16
.case11	SWAP16
.case10	SWAP16
.case9	SWAP16
.case8	SWAP16
.case7	SWAP16
.case6	SWAP16
.case5	SWAP16
.case4	SWAP16
.case3	SWAP16
.case2	SWAP16
.case1	SWAP16

	subq.l	#1,		d0
	bgt.b		.case0

	movem.l	(a7)+,	d0/a2
	and.l		#1,		d0
	beq.b		swap16_Done

swap16_TrailingWord
	move.w	(a1)+,	d0
	rol.w		#8,		d0
	move.w	d0,		(a0)+

swap16_Done
	rts


;////////////////////////////////////////////////////////////////////////////////
;//
;//  void Mem::swap32([a0]void* dst, [a1]void* src, [d0]size_t count)
;//
;//  Source and destination must be at least 16-bit aligned.
;//  Best performance when both are 32-bit aligned
;//
;////////////////////////////////////////////////////////////////////////////////

	MACRO	SWAP32
	move.l (a1)+, d1
	rol.w	#8, d1			;// AABBCCDD -> AABBDDCC
	swap	d1					;// AABBDDCC -> DDCCAABB
	rol.w	#8, d1			;// DDCCAABB -> DDCCBBAA
	move.l	d1, (a0)+	
	ENDM

swap32__Mem__r8Pvr9Pvr0Ui
	tst.l		d0
	bgt.b		swap32_DestTest
	rts

swap32_DestTest
	move.l	a0,		d1
	and.l		#1,		d1
	beq		swap32_SourceTest
	rts

swap32_SourceTest
	move.l	a1,		d1
	and.l		#1,		d1
	beq		swap32_swap
	rts

swap32_swap
	;// d0 counter
	;// d1 scratch
	;// a0 src
	;// a1 dst
	;// a2 jump target
	move.l	a2,	-(a7)
	move.l	d0,		d1
	add.l		#15,		d0
	lsr.l		#4,		d0		;// d0 = (cnt+15)>>4
	and.l		#$F,		d1		;// d1 = count & 15
	move.l	.switch(pc,d1.l*4),a2
	jmp		(a2)

.switch
	dc.l .case0,	.case1,	.case2,	.case3
	dc.l .case4,	.case5,	.case6,	.case7
	dc.l .case8,	.case9,	.case10,	.case11
	dc.l .case12,	.case13,	.case14,	.case15

.case0	SWAP32
.case15	SWAP32
.case14	SWAP32
.case13	SWAP32
.case12	SWAP32
.case11	SWAP32
.case10	SWAP32
.case9	SWAP32
.case8	SWAP32
.case7	SWAP32
.case6	SWAP32
.case5	SWAP32
.case4	SWAP32
.case3	SWAP32
.case2	SWAP32
.case1	SWAP32

	subq.l	#1,		d0
	bgt.b		.case0
	move.l	(a7)+,	a2
	rts

;////////////////////////////////////////////////////////////////////////////////
;//
;//  void Mem::swap64([a0]void* dst, [a1]void* src, [d0]size_t count)
;//
;//  Source and destination must be at least 16-bit aligned.
;//  Best performance when both are 32-bit aligned
;//
;////////////////////////////////////////////////////////////////////////////////

	MACRO	SWAP64
	move.l (a1)+, d1
	move.l (a1)+, d2
	rol.w	#8, d1			;// AABBCCDD -> AABBDDCC
	swap	d1					;// AABBDDCC -> DDCCAABB
	rol.w	#8, d1			;// DDCCAABB -> DDCCBAAB
	rol.w	#8, d2			;// AABBCCDD -> AABBDDCC
	swap	d2					;// AABBDDCC -> DDCCAABB
	rol.w	#8, d2			;// DDCCAABB -> DDCCBBAA
	move.l	d2, (a0)+	;// write longwords in reverse order of reading
	move.l	d1, (a0)+	;// to perform MSDW LSDW swap
	ENDM
		
swap64__Mem__r8Pvr9Pvr0Ui
	tst.l		d0
	bgt		swap64_DestTest
	rts

swap64_DestTest
	move.l	a0,		d1
	and.l		#1,		d1
	beq		swap64_SourceTest
	rts

swap64_SourceTest
	move.l	a1,		d1
	and.l		#1,		d1
	beq		swap64_swap
	rts

swap64_swap
	;// d0 counter
	;// d1 scratch
	;// d2 scratch
	;// a0 src
	;// a1 dst
	;// a2 jump target
	movem.l	d2/a2,	-(a7)
	move.l	d0,		d1
	addq		#7,		d0
	lsr.l		#3,		d0		;// d0 = (cnt+7)>>3
	and.l		#$7,		d1		;// d1 = cnt & 7
	move.l	.switch(pc,d1.l*4),a2
	jmp		(a2)

.switch
	dc.l .case0,	.case1,	.case2,	.case3
	dc.l .case4,	.case5,	.case6,	.case7

.case0	SWAP64
.case7	SWAP64
.case6	SWAP64
.case5	SWAP64
.case4	SWAP64
.case3	SWAP64
.case2	SWAP64
.case1	SWAP64

	subq.l	#1,		d0
	bgt.b	.case0

	movem.l	(a7)+,	d2/a2
	rts

	END
