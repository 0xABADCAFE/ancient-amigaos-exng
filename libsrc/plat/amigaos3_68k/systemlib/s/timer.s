
; Storm C Compiler
; EXNG:libsrc/plat/amigaos3_68k/systemlib/timer.cpp
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
	XREF	_TimerBase

	SECTION "getVolatile__Mem_:0",CODE

	rts

	SECTION "op__plus__R04TimeR04Time:0",CODE


;Time operator+(Time& a, Time& b)
	XDEF	op__plus__R04TimeR04Time
op__plus__R04TimeR04Time
L5	EQU	-$8
	link	a5,#L5
	movem.l	d2/d3/a2,-(a7)
	movem.l	$C(a5),a1/a2
L4
;	Time sum(a.totMillis() + b.totMillis());
	move.l	(a1),d0
	move.l	4(a1),d1
	move.l	(a2),d2
	move.l	4(a2),d3
	XREF	Add64
	jsr	Add64
	move.l	d0,-$8(a5)
	move.l	d1,-4(a5)
;	return sum;
	move.l	-$8(a5),d0
	move.l	-4(a5),d1
	move.l	$8(a5),a0
	move.l	d0,(a0)
	move.l	d1,4(a0)
	movem.l	(a7)+,d2/d3/a2
	unlk	a5
	rts

	SECTION "op__minus__R04TimeR04Time:0",CODE


;Time operator-(Time& a, Time& b)
	XDEF	op__minus__R04TimeR04Time
op__minus__R04TimeR04Time
L7	EQU	-$8
	link	a5,#L7
	movem.l	d2/d3/a2,-(a7)
	movem.l	$C(a5),a1/a2
L6
;	Time diff(a.totMillis() - b.totMillis());
	move.l	(a1),d0
	move.l	4(a1),d1
	move.l	(a2),d2
	move.l	4(a2),d3
	XREF	Sub64
	jsr	Sub64
	move.l	d0,-$8(a5)
	move.l	d1,-4(a5)
;	return diff;
	move.l	-$8(a5),d0
	move.l	-4(a5),d1
	move.l	$8(a5),a0
	move.l	d0,(a0)
	move.l	d1,4(a0)
	movem.l	(a7)+,d2/d3/a2
	unlk	a5
	rts

	SECTION "_clockFreq__MilliClock:1",DATA

	XDEF	_clockFreq__MilliClock
_clockFreq__MilliClock
	dc.l	0

	SECTION "elapsed__MilliClock__T:0",CODE


;uint32 MilliClock::elapsed()
	XDEF	elapsed__MilliClock__T
elapsed__MilliClock__T
L13	EQU	-$C
	link	a5,#L13
	movem.l	a2/a6,-(a7)
	move.l	$8(a5),a2
L9
;	ReadEClock(&current);
	move.l	_TimerBase,a6
	lea	-$8(a5),a0
	jsr	-$3C(a6)
;	if (current.ev_hi == mark.ev_hi)
	move.l	a2,a0
	move.l	-$8(a5),d1
	cmp.l	(a0),d1
	bne.b	L11
L10
;		ticks = current.ev_lo - mark.ev_lo;
	move.l	a2,a0
	move.l	-4(a5),d0
	sub.l	4(a0),d0
	bra.b	L12
L11
;		ticks = 0xFFFFFFFF-mark.ev_lo + current.ev_lo;
	move.l	a2,a0
	moveq	#-1,d0
	sub.l	4(a0),d0
	add.l	-4(a5),d0
L12
;	return (1000*ticks)/clockFreq;
	mulu.l	#$3E8,d0
	divul.l	_clockFreq__MilliClock,d0
	movem.l	(a7)+,a2/a6
	unlk	a5
	rts

	SECTION "elapsed__Clock__T:0",CODE


;Time& Clock::elapsed()
	XDEF	elapsed__Clock__T
elapsed__Clock__T
L15	EQU	-$8
	link	a5,#L15
	movem.l	d2/a2/a6,-(a7)
	move.l	$8(a5),a2
L14
;	GetSysTime(&current);
	move.l	_TimerBase,a6
	lea	-$8(a5),a0
	jsr	-$42(a6)
;	SubTime(&current, &mark);
	move.l	_TimerBase,a6
	lea	-$8(a5),a0
	move.l	a2,a1
	jsr	-$30(a6)
;	t.ms	= ((current.tv_secs*1000)+(current.tv_micro/1000));
	move.l	-$8(a5),d0
	mulu.l	#$3E8,d0
	move.l	-4(a5),d1
	divul.l	#$3E8,d1
	add.l	d1,d0
	move.l	d0,d1
	moveq	#0,d0
	move.l	a2,a0
	move.l	d0,$8(a0)
	move.l	d1,$C(a0)
;	return t;
	moveq	#$8,d0
	add.l	a2,d0
	movem.l	(a7)+,d2/a2/a6
	unlk	a5
	rts

	END
