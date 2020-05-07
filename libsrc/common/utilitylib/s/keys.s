
; Storm C Compiler
; exng:libsrc/common/utilitylib/keys.cpp
	mc68030
	mc68881
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

	SECTION "getVolatile__Mem_:0",CODE

	rts

	SECTION "getValue__Key32__TPCc:0",CODE


;uint32 Key32::getValue(const char* text)
	XDEF	getValue__Key32__TPCc
getValue__Key32__TPCc
	movem.l	d2/d3,-(a7)
	move.l	$10(a7),a0
L6
;	ruint32 v = 0;
	moveq	#0,d0
;	ruint32 m = 0x80000000;
	move.l	#$80000000,d2
;	ruint8* p = (uint8*)text;
;	while (*p)
	bra.b	L11
L7
;		v = (v<<1) | ((v&m) ? 1UL : 0);
	move.l	d0,d1
	moveq	#1,d3
	asl.l	d3,d1
	and.l	d2,d0
	beq.b	L9
L8
	moveq	#1,d0
	bra.b	L10
L9
	moveq	#0,d0
L10
	or.l	d1,d0
;		v ^= (uint32) *p++;
	moveq	#0,d1
	move.b	(a0)+,d1
	eor.l	d1,d0
L11
	tst.b	(a0)
	bne.b	L7
L12
;	return v;
	movem.l	(a7)+,d2/d3
	rts

	SECTION "getValue__Key64__TPCc:0",CODE


;uint64 Key64::getValue(const char* text)
	XDEF	getValue__Key64__TPCc
getValue__Key64__TPCc
	movem.l	d2-d7,-(a7)
	move.l	$20(a7),a1
L13
;	uint64 v = 0;
	moveq	#0,d4
	moveq	#0,d5
;	ruint8* p = (uint8*)text;
	move.l	a1,a0
;	while (*p)
	bra.b	L18
L14
;		v = (v<<1) | ((v&0x8000000000000000) ? 1UL : 0);
	move.l	d4,d0
	move.l	d5,d1
	moveq	#0,d2
	moveq	#1,d3
	XREF	lib_64bit_shl
	jsr	lib_64bit_shl
	move.l	d0,d6
	move.l	d1,d7
	move.l	d4,d0
	move.l	d5,d1
	move.l	#$80000000,d2
	moveq	#0,d3
	and.l	d2,d0
	and.l	d3,d1
	or.l	d0,d1
	beq.b	L16
L15
	moveq	#1,d0
	bra.b	L17
L16
	moveq	#0,d0
L17
	moveq	#0,d2
	move.l	d0,d3
	move.l	d6,d0
	move.l	d7,d1
	or.l	d2,d0
	or.l	d3,d1
	move.l	d0,d4
	move.l	d1,d5
;		v ^= (uint64) *p++;
	moveq	#0,d2
	moveq	#0,d2
	move.b	(a0)+,d3
	move.l	d4,d0
	move.l	d5,d1
	eor.l	d2,d0
	eor.l	d3,d1
	move.l	d0,d4
	move.l	d1,d5
L18
	tst.b	(a0)
	bne.b	L14
L19
;	return v;
	move.l	d4,d0
	move.l	d5,d1
	movem.l	(a7)+,d2-d7
	rts

	END
