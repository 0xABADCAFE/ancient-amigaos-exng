
; Storm C Compiler
; EXNG:libsrc/plat/amigaos3_68k/systemlib/memory.cpp
	mc68030
	mc68881
	XREF	runApplication__AppBase__T
	XREF	dialogueBox__SystemLib__PCcPCcPCce
	XREF	printDebug__SystemLib__PCci
	XREF	_system
	XREF	_std__in
	XREF	_std__out
	XREF	_std__err
	XREF	_SysBase
	XREF	_IntuitionBase
	XREF	_debug__SystemLib

	SECTION "getVolatile__Mem_:0",CODE

	rts

	SECTION "_allocated__Mem:1",DATA

	XDEF	_allocated__Mem
_allocated__Mem
	dc.l	0

	SECTION "_volatileBuff__Mem:1",DATA

	XDEF	_volatileBuff__Mem
_volatileBuff__Mem
	dc.l	0

	SECTION "_totalSize__Mem:1",DATA

	XDEF	_totalSize__Mem
_totalSize__Mem
	dc.l	0

	SECTION "_nextFree__Mem:1",DATA

	XDEF	_nextFree__Mem
_nextFree__Mem
	dc.l	0

	SECTION "_count__Mem:1",DATA

	XDEF	_count__Mem
_count__Mem
	dc.l	0

	SECTION "_maxAllocs__Mem:1",DATA

	XDEF	_maxAllocs__Mem
_maxAllocs__Mem
	dc.l	0

	SECTION "init__Mem_:0",CODE


;sint32 Mem::init()
	XDEF	init__Mem_
init__Mem_
	move.l	a6,-(a7)
L30
;	if (!(allocated = (MemInfo*)AllocVec(MAXALLOCS*sizeof(MemInfo) + V
	move.l	_SysBase,a6
	move.l	#$4000,d0
	move.l	#$10001,d1
	jsr	-$2AC(a6)
	move.l	d0,_allocated__Mem
	tst.l	_allocated__Mem
	bne.b	L32
L31
;_ERROR("Mem::init
	pea	2.w
	move.l	#L28,-(a7)
	jsr	printDebug__SystemLib__PCci
	addq.w	#$8,a7
;		return ERR_NO_FREE_STORE;
	move.l	#-$3030001,d0
	move.l	(a7)+,a6
	rts
L32
;	volatileBuff = (void*)&allocated[MAXALLOCS+1];
	move.l	#$2010,d0
	add.l	_allocated__Mem,d0
	move.l	d0,_volatileBuff__Mem
;	X_INFO("Mem initialized");
	clr.l	-(a7)
	move.l	#L29,-(a7)
	jsr	printDebug__SystemLib__PCci
	addq.w	#$8,a7
;	return OK;
	moveq	#0,d0
	move.l	(a7)+,a6
	rts

L29
	dc.b	'Mem initialized',0
L28
	dc.b	'Mem::init() unable to allocate list memory',0

	SECTION "done__Mem_:0",CODE


;void Mem::done()
	XDEF	done__Mem_
done__Mem_
	movem.l	d2-d4/a6,-(a7)
L37
;	if (allocated)
	tst.l	_allocated__Mem
	beq	L46
L38
;		sint32 freed = 0;
	moveq	#0,d3
;		size_t size = 0;
	moveq	#0,d4
;		for (rsint32 i=0;
	moveq	#0,d2
	bra	L42
L39
;			if (allocated[i].real)
	move.l	d2,d0
	asl.l	#4,d0
	move.l	_allocated__Mem,a1
	tst.l	0(a1,d0.l)
	beq	L41
L40
;				FreeVec(allocated[i].real);
	move.l	d2,d0
	asl.l	#4,d0
	move.l	_allocated__Mem,a1
	move.l	_SysBase,a6
	move.l	0(a1,d0.l),a1
	jsr	-$2B2(a6)
;				totalSize -= allocated[i].size;
	move.l	d2,d0
	asl.l	#4,d0
	move.l	_allocated__Mem,a1
	move.l	_totalSize__Mem,d1
	sub.l	$C(a1,d0.l),d1
	move.l	d1,_totalSize__Mem
;				size += allocated[i].size;
	move.l	d2,d0
	asl.l	#4,d0
	move.l	_allocated__Mem,a1
	add.l	$C(a1,d0.l),d4
;				allocated[i].real			= 0;
	move.l	d2,d0
	asl.l	#4,d0
	move.l	_allocated__Mem,a1
	clr.l	0(a1,d0.l)
;				allocated[i].address	= 0;
	move.l	d2,d0
	asl.l	#4,d0
	move.l	_allocated__Mem,a1
	clr.l	4(a1,d0.l)
;				allocated[i].size			= 0;
	move.l	d2,d0
	asl.l	#4,d0
	move.l	_allocated__Mem,a1
	clr.l	$C(a1,d0.l)
;				allocated[i].owner 		= 0;
	move.l	d2,d0
	asl.l	#4,d0
	move.l	_allocated__Mem,a1
	clr.l	$8(a1,d0.l)
;				freed++;
	addq.l	#1,d3
;				count--;
	subq.l	#1,_count__Mem
L41
	addq.l	#1,d2
L42
	cmp.l	#$200,d2
	blt	L39
L43
;		if (freed)
	tst.l	d3
	beq.b	L45
L44
;			SystemLib::dialogueBox("Debug Info","Proceed","Mem:
	move.l	d4,-(a7)
	move.l	d3,-(a7)
	move.l	#L33,-(a7)
	move.l	#L34,-(a7)
	move.l	#L35,-(a7)
	jsr	dialogueBox__SystemLib__PCcPCcPCce
	add.w	#$14,a7
L45
;		FreeVec(allocated);
	move.l	_allocated__Mem,a1
	move.l	_SysBase,a6
	jsr	-$2B2(a6)
;		allocated = 0;
	clr.l	_allocated__Mem
;		volatileBuff = 0;
	clr.l	_volatileBuff__Mem
;		X_INFO("Mem finalized");
	clr.l	-(a7)
	move.l	#L36,-(a7)
	jsr	printDebug__SystemLib__PCci
	addq.w	#$8,a7
L46
	movem.l	(a7)+,d2-d4/a6
	rts

L35
	dc.b	'Debug Info',0
L36
	dc.b	'Mem finalized',0
L33
	dc.b	'Mem::done()',$A
	dc.b	'Released %d block(s)',$A,'totalling %d bytes',$A,0
L34
	dc.b	'Proceed',0

	SECTION "alloc__Mem__UisE:0",CODE


;void* Mem::alloc(size_t len, bool zero, Mem::AlignType align)
	XDEF	alloc__Mem__UisE
alloc__Mem__UisE
	movem.l	d2-d4/a2/a6,-(a7)
	move.l	$1E(a7),d0
	move.w	$1C(a7),d1
	move.l	$18(a7),d4
L47
;	if (!allocated || count == MAXALLOCS) 
	tst.l	_allocated__Mem
	beq.b	L49
L48
	move.l	_count__Mem,d2
	cmp.l	#$200,d2
	bne.b	L50
L49
;	if (!allocated || count == M
	moveq	#0,d0
	movem.l	(a7)+,d2-d4/a2/a6
	rts
L50
;	uint32 alignLen = ((uint32)align<8) ? 0 : align;
	cmp.l	#$8,d0
	bhs.b	L52
L51
	moveq	#0,d3
	bra.b	L53
L52
	move.l	d0,d3
L53
;	void* r = AllocVec((len+(alignLen<<1)), MEMF_PUBLIC|(zero ? MEMF_C
	tst.w	d1
	beq.b	L55
L54
	move.l	#$10000,d0
	bra.b	L56
L55
	moveq	#0,d0
L56
	move.l	d0,d1
	or.l	#1,d1
	move.l	d3,d0
	moveq	#1,d2
	asl.l	d2,d0
	add.l	d4,d0
	move.l	_SysBase,a6
	jsr	-$2AC(a6)
	move.l	d0,a0
;	if (r)
	cmp.w	#0,a0
	beq	L64
L57
;		sint32 index = nextFree;
	move.l	_nextFree__Mem,d2
;		allocated[index].real = r;
	move.l	d2,d0
	asl.l	#4,d0
	move.l	_allocated__Mem,a2
	move.l	a0,0(a2,d0.l)
;		if (alignLen)
	tst.l	d3
	beq.b	L59
L58
;			uint32 mask = alignLen-1;
	move.l	d3,d0
	subq.l	#1,d0
;			allocated[index].address	= (void*)((mask+(uint32)r) & ~mask);
	move.l	d0,d1
	add.l	a0,d1
	not.l	d0
	and.l	d0,d1
	move.l	d2,d0
	asl.l	#4,d0
	move.l	_allocated__Mem,a1
	move.l	d1,4(a1,d0.l)
	bra.b	L60
L59
;			allocated[index].address = r;
	move.l	d2,d0
	asl.l	#4,d0
	move.l	_allocated__Mem,a2
	move.l	a0,4(a2,d0.l)
L60
;		allocated[index].owner		= FindTask(0);
	move.l	_SysBase,a6
	sub.l	a1,a1
	jsr	-$126(a6)
	move.l	d2,d1
	asl.l	#4,d1
	move.l	_allocated__Mem,a1
	move.l	d0,$8(a1,d1.l)
;		allocated[index].size			= len;
	move.l	d2,d0
	asl.l	#4,d0
	move.l	_allocated__Mem,a1
	move.l	d4,$C(a1,d0.l)
;		totalSize += len;
	add.l	d4,_totalSize__Mem
;		count++;
	addq.l	#1,_count__Mem
;		while (allocated[nextFree].address != 0)
	bra.b	L62
L61
;			nextFree++;
	addq.l	#1,_nextFree__Mem
L62
	move.l	_nextFree__Mem,d0
	asl.l	#4,d0
	move.l	_allocated__Mem,a1
	move.l	4(a1,d0.l),a0
	cmp.w	#0,a0
	bne.b	L61
L63
;		return allocated[index].address;
	asl.l	#4,d2
	move.l	_allocated__Mem,a1
	move.l	4(a1,d2.l),d0
	movem.l	(a7)+,d2-d4/a2/a6
	rts
L64
;	return 0;
	moveq	#0,d0
	movem.l	(a7)+,d2-d4/a2/a6
	rts

	SECTION "free__Mem__Pv:0",CODE


;void Mem::free(void* ptr)
	XDEF	free__Mem__Pv
free__Mem__Pv
	movem.l	d2/a2/a6,-(a7)
	move.l	$10(a7),a1
L65
;	if (!allocated)	
	tst.l	_allocated__Mem
	bne.b	L67
L66
;	if (!allocated)	return;
	movem.l	(a7)+,d2/a2/a6
	rts
L67
;	if (ptr)
	cmp.w	#0,a1
	beq	L79
L68
;		sint32 index=-1
	moveq	#-1,d2
;		sint32 index=-1, found=0;
	moveq	#0,d0
;		while((found==0) && (index<MAXALLOCS))
	bra.b	L70
L69
;			found = (ptr==allocated[++index].address);
	addq.l	#1,d2
	move.l	d2,d0
	asl.l	#4,d0
	move.l	_allocated__Mem,a2
	move.l	a1,d1
	cmp.l	4(a2,d0.l),d1
	seq	d1
	and.l	#1,d1
	move.l	d1,d0
L70
	tst.l	d0
	bne.b	L72
L71
	cmp.l	#$200,d2
	blt.b	L69
L72
;		if (!found)
	tst.l	d0
	bne.b	L74
L73
;			return;
	movem.l	(a7)+,d2/a2/a6
	rts
L74
;		if (!allocated[index].real)
	move.l	d2,d0
	asl.l	#4,d0
	move.l	_allocated__Mem,a1
	tst.l	0(a1,d0.l)
	bne.b	L76
L75
;			return;
	movem.l	(a7)+,d2/a2/a6
	rts
L76
;		FreeVec(allocated[index].real);
	move.l	d2,d0
	asl.l	#4,d0
	move.l	_allocated__Mem,a1
	move.l	_SysBase,a6
	move.l	0(a1,d0.l),a1
	jsr	-$2B2(a6)
;		totalSize -= allocated[index].size;
	move.l	d2,d0
	asl.l	#4,d0
	move.l	_allocated__Mem,a1
	move.l	_totalSize__Mem,d1
	sub.l	$C(a1,d0.l),d1
	move.l	d1,_totalSize__Mem
;		allocated[index].real			= 0;
	move.l	d2,d0
	asl.l	#4,d0
	move.l	_allocated__Mem,a1
	clr.l	0(a1,d0.l)
;		allocated[index].address	= 0;
	move.l	d2,d0
	asl.l	#4,d0
	move.l	_allocated__Mem,a1
	clr.l	4(a1,d0.l)
;		allocated[index].owner		= 0;
	move.l	d2,d0
	asl.l	#4,d0
	move.l	_allocated__Mem,a1
	clr.l	$8(a1,d0.l)
;		allocated[index].size			= 0;
	move.l	d2,d0
	asl.l	#4,d0
	move.l	_allocated__Mem,a1
	clr.l	$C(a1,d0.l)
;		count--;
	subq.l	#1,_count__Mem
;		if (index < nextFree)
	cmp.l	_nextFree__Mem,d2
	bge.b	L78
L77
;			nextFree = index;
	move.l	d2,_nextFree__Mem
L78
;		return;
	movem.l	(a7)+,d2/a2/a6
	rts
L79
	movem.l	(a7)+,d2/a2/a6
	rts

	END
