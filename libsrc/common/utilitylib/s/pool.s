
; Storm C Compiler
; exng:libsrc/common/utilitylib/pool.cpp
	mc68030
	mc68881
	XREF	_0dt__PoolBase__T
	XREF	runApplication__AppBase__T
	XREF	copy__Mem__r8Pvr9Pvr0Ui
	XREF	free__Mem__Pv
	XREF	alloc__Mem__UisE
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

	SECTION "_0ct__PoolLargeRaw__TUiUi:0",CODE


;PoolLargeRaw::PoolLargeRaw(size_t entries, size_t type
	XDEF	_0ct__PoolLargeRaw__TUiUi
_0ct__PoolLargeRaw__TUiUi
	movem.l	d2/a2,-(a7)
	movem.l	$10(a7),d0/d1
	move.l	$C(a7),a1
L139
	move.l	a1,a0
	clr.l	(a0)
	clr.l	4(a0)
	clr.l	$C(a0)
	clr.l	$8(a0)
	move.l	#-1,$10(a0)
	clr.l	$14(a0)
	clr.l	$18(a0)
	clr.l	$1C(a0)
	clr.l	$24(a1)
;	getSpace(entries, typeSize);
	move.l	d1,-(a7)
	move.l	d0,-(a7)
	move.l	a1,-(a7)
	jsr	getSpace__PoolLargeRaw__TUiUi
	add.w	#$C,a7
	movem.l	(a7)+,d2/a2
	rts

	SECTION "_0dt__PoolLargeRaw__T:0",CODE


;PoolLargeRaw::~PoolLargeRaw()
	XDEF	_0dt__PoolLargeRaw__T
_0dt__PoolLargeRaw__T
	move.l	a2,-(a7)
	move.l	$8(a7),a2
L140
;	freeSpace(true);
	clr.w	-(a7)
	move.w	#1,-(a7)
	move.l	a2,-(a7)
	jsr	freeSpace__PoolLargeRaw__Tss
	addq.w	#$8,a7
	move.l	a2,-(a7)
	jsr	_0dt__PoolBase__T
	addq.w	#4,a7
	move.l	(a7)+,a2
	rts

	SECTION "examineBlock__PoolLargeRaw__TUj:0",CODE


;uint32 PoolLargeRaw::examineBlock(uint32 location)
	XDEF	examineBlock__PoolLargeRaw__TUj
examineBlock__PoolLargeRaw__TUj
	movem.l	d2/d3,-(a7)
	move.l	$10(a7),d0
	move.l	$C(a7),a0
L141
;	sint32 i = location
	move.l	d0,d1
;	sint32 i = location, endOfBlock = 0
	moveq	#0,d2
;	sint32 i = location, endOfBlo
	moveq	#1,d0
;	while (i < size && !endOfBlock)
	bra.b	L146
L142
;		i++;
	addq.l	#1,d1
;		if (lengthTable[i] || allocTable[i])
	move.l	$24(a0),a1
	tst.l	0(a1,d1.l*4)
	bne.b	L144
L143
	move.l	$18(a0),a1
	tst.l	0(a1,d1.l*4)
	beq.b	L145
L144
;			endOfBlock = length;
	move.l	d0,d2
	bra.b	L146
L145
;			length++;
	addq.l	#1,d0
L146
	cmp.l	4(a0),d1
	bge.b	L148
L147
	tst.l	d2
	beq.b	L142
L148
;	return length;
	movem.l	(a7)+,d2/d3
	rts

	SECTION "testConsistency__PoolLargeRaw__Ts:0",CODE


;sint32 PoolLargeRaw::testConsistency(bool strict)
	XDEF	testConsistency__PoolLargeRaw__Ts
testConsistency__PoolLargeRaw__Ts
	movem.l	d2-d5/a2,-(a7)
	move.l	$18(a7),a2
L149
;	sint32 mismatches = 0
	moveq	#0,d5
;	sint32 mismatches = 0, i = 0
	moveq	#0,d2
;	sint32 mismatches = 0, i = 0, blockE
	moveq	#0,d4
;		sint32 lastPos = 0;
	moveq	#0,d3
;		while (i < size)
	bra.b	L158
L150
;			uint32 sizeBuff = lengthTable[i];
	move.l	$24(a2),a0
	move.l	0(a0,d2.l*4),d0
;			if (!sizeBuff)
	bne.b	L152
L151
;				blockErrs++;
	addq.l	#1,d4
;				sizeBuff = examineBlock(lastPos);
	move.l	d3,-(a7)
	move.l	a2,-(a7)
	jsr	examineBlock__PoolLargeRaw__TUj
	addq.w	#$8,a7
;				lengthTable[lastPos] = sizeBuff;
	move.l	$24(a2),a0
	move.l	d0,0(a0,d3.l*4)
;				i = lastPos + sizeBuff;
	move.l	d3,d2
	add.l	d0,d2
L152
;			if (allocTable[i] && (*(allocTable[i]) != &pool[i*tSize]))
	move.l	$18(a2),a0
	tst.l	0(a0,d2.l*4)
	beq.b	L155
L153
	move.l	$18(a2),a0
	move.l	0(a0,d2.l*4),a0
	move.l	(a0),a1
	move.l	$C(a2),d1
	muls.l	d2,d1
	move.l	$1C(a2),a0
	lea	0(a0,d1.l*2),a0
	cmp.l	a0,a1
	beq.b	L155
L154
;				mismatches++;
	addq.l	#1,d5
L155
;			if (i + sizeBuff > size)
	move.l	d2,d3
	add.l	d0,d3
	cmp.l	4(a2),d3
	bls.b	L157
L156
;				blockErrs++;
	addq.l	#1,d4
;				sizeBuff = examineBlock(i);
	move.l	d2,-(a7)
	move.l	a2,-(a7)
	jsr	examineBlock__PoolLargeRaw__TUj
	addq.w	#$8,a7
;				lengthTable[i] = sizeBuff;
	move.l	$24(a2),a0
	move.l	d0,0(a0,d2.l*4)
L157
;			lastPos = i;
	move.l	d2,d3
;			i += sizeBuff;
	add.l	d0,d2
L158
	cmp.l	4(a2),d2
	blt.b	L150
L159
;	return mismatches;
	move.l	d5,d0
	movem.l	(a7)+,d2-d5/a2
	rts

	SECTION "getSpace__PoolLargeRaw__TUiUi:0",CODE


;sint32 PoolLargeRaw::getSpace(size_t s, size_t t)
	XDEF	getSpace__PoolLargeRaw__TUiUi
getSpace__PoolLargeRaw__TUiUi
	movem.l	d2/d3/a2,-(a7)
	move.l	$18(a7),d1
	move.l	$14(a7),d2
	move.l	$10(a7),a2
L160
;	if (pool)
	tst.l	$1C(a2)
	beq.b	L162
L161
;		return ERR_RSC_LOCKED;
	move.l	#-$3050004,d0
	movem.l	(a7)+,d2/d3/a2
	rts
L162
;	tSize = t/2 + (t & 1);
	move.l	d1,d0
	moveq	#1,d3
	lsr.l	d3,d0
	and.l	#1,d1
	add.l	d1,d0
	move.l	d0,$C(a2)
;	rawSize = tSize*s;
	move.l	$C(a2),d0
	mulu.l	d2,d0
	move.l	d0,$8(a2)
;	size_t allocationSize = s + s + (rawSize/2) + (rawSize & 1);
	move.l	d2,d0
	add.l	d2,d0
	move.l	$8(a2),d1
	moveq	#1,d3
	lsr.l	d3,d1
	add.l	d1,d0
	move.l	$8(a2),d1
	and.l	#1,d1
	add.l	d1,d0
;	data = (uint32*)Mem::alloc(allocationSize*sizeof(uint32), true);
	clr.l	-(a7)
	move.w	#1,-(a7)
	moveq	#2,d1
	asl.l	d1,d0
	move.l	d0,-(a7)
	jsr	alloc__Mem__UisE
	add.w	#$A,a7
	move.l	d0,(a2)
;	if (!data)
	tst.l	(a2)
	bne.b	L164
L163
;		init();
	move.l	a2,a0
	clr.l	$24(a0)
	clr.l	(a0)
	clr.l	4(a0)
	clr.l	$C(a0)
	clr.l	$8(a0)
	move.l	#-1,$10(a0)
	clr.l	$14(a0)
	clr.l	$18(a0)
	clr.l	$1C(a0)
;		return ERR_NO_FREE_STORE;
	move.l	#-$3030001,d0
	movem.l	(a7)+,d2/d3/a2
	rts
L164
;	allocTable = (uint16***)&data[0];
	move.l	(a2),a0
	move.l	a0,$18(a2)
;	lengthTable  = (uint32*)&data[s];
	move.l	(a2),a0
	lea	0(a0,d2.l*4),a0
	move.l	a0,$24(a2)
;	pool			 = (uint16*)&data[2*s];
	move.l	d2,d0
	moveq	#1,d1
	asl.l	d1,d0
	move.l	(a2),a0
	lea	0(a0,d0.l*4),a0
	move.l	a0,$1C(a2)
;	size          = s;
	move.l	d2,4(a2)
;	totalFree			= size;
	move.l	4(a2),d0
	move.l	d0,$14(a2)
;	nextFree			= 0;
	clr.l	$10(a2)
;	lengthTable[0]  = size;
	move.l	$24(a2),a0
	move.l	4(a2),(a0)
;	return OK;
	moveq	#0,d0
	movem.l	(a7)+,d2/d3/a2
	rts

	SECTION "freeSpace__PoolLargeRaw__Tss:0",CODE


;sint32 PoolLargeRaw::freeSpace(bool force, bool update)
	XDEF	freeSpace__PoolLargeRaw__Tss
freeSpace__PoolLargeRaw__Tss
	movem.l	d2-d4/a2/a3,-(a7)
	move.w	$1E(a7),d2
	move.w	$1C(a7),d3
	move.l	$18(a7),a2
L165
;	sint32 inUse =  size - totalFree;
	move.l	4(a2),d0
	sub.l	$14(a2),d0
;	if (!force)
	tst.w	d3
	bne.b	L169
L166
;		if (inUse)
	tst.l	d0
	beq.b	L168
L167
;			return ERR_RSC_LOCKED;
	move.l	#-$3050004,d0
	movem.l	(a7)+,d2-d4/a2/a3
	rts
L168
	bra.b	L180
L169
;		if (data && inUse && update)
	tst.l	(a2)
	beq.b	L180
L170
	tst.l	d0
	beq.b	L180
L171
	tst.w	d2
	beq.b	L180
L172
;			sint32 p = 0;
	moveq	#0,d3
;			for (sint32 i=0;
	moveq	#0,d0
	bra.b	L179
L173
;				if (isInPool(*(allocTable[i])))
	move.l	$18(a2),a0
	move.l	0(a0,d0.l*4),a0
	move.l	(a0),a1
	move.l	a2,a0
	moveq	#0,d2
	cmp.l	$1C(a0),a1
	blo.b	L176
L174
	move.l	$8(a0),d1
	subq.l	#1,d1
	move.l	$1C(a0),a3
	lea	0(a3,d1.l*2),a0
	cmp.l	a0,a1
	bhs.b	L176
L175
	moveq	#1,d2
L176
	tst.l	d2
	beq.b	L178
L177
;					*(allocTable[i]) = 0;
	move.l	$18(a2),a0
	move.l	0(a0,d0.l*4),a0
	clr.l	(a0)
L178
;				p++;
	addq.l	#1,d3
	addq.l	#1,d0
L179
	cmp.l	4(a2),d0
	blt.b	L173
L180
;	if (data)
	tst.l	(a2)
	beq.b	L182
L181
;		Mem::free(data);
	move.l	(a2),-(a7)
	jsr	free__Mem__Pv
	addq.w	#4,a7
;		init();
	move.l	a2,a0
	clr.l	$24(a0)
	clr.l	(a0)
	clr.l	4(a0)
	clr.l	$C(a0)
	clr.l	$8(a0)
	move.l	#-1,$10(a0)
	clr.l	$14(a0)
	clr.l	$18(a0)
	clr.l	$1C(a0)
L182
;	return OK;
	moveq	#0,d0
	movem.l	(a7)+,d2-d4/a2/a3
	rts

	SECTION "resize__PoolLargeRaw__TUi:0",CODE


;sint32 PoolLargeRaw::resize(size_t s)
	XDEF	resize__PoolLargeRaw__TUi
resize__PoolLargeRaw__TUi
L197	EQU	-$24
	link	a5,#L197
	movem.l	d2-d6/a2/a3/a6,-(a7)
	move.l	$C(a5),d4
	move.l	$8(a5),a2
L183
;	if (size == s)
	move.l	4(a2),d0
	cmp.l	d4,d0
	bne.b	L185
L184
;		return OK;
	moveq	#0,d0
	movem.l	(a7)+,d2-d6/a2/a3/a6
	unlk	a5
	rts
L185
;	if (s > (size - totalFree))
	move.l	4(a2),d0
	sub.l	$14(a2),d0
	cmp.l	d0,d4
	ble	L196
L186
;		if (testConsistency())
	clr.w	-(a7)
	move.l	a2,-(a7)
	jsr	testConsistency__PoolLargeRaw__Ts
	addq.w	#6,a7
	tst.l	d0
	beq.b	L188
L187
;			return ERR_ALLOC_INCONSISTENT;
	move.l	#-$3800004,d0
	movem.l	(a7)+,d2-d6/a2/a3/a6
	unlk	a5
	rts
L188
;		uint32 newRawSize = s*tSize;
	move.l	d4,d5
	mulu.l	$C(a2),d5
;		uint32 allocationSize = s + s + (newRawSize/2) + (newRawSize & 1)
	move.l	d4,d0
	add.l	d4,d0
	move.l	d5,d1
	moveq	#1,d2
	lsr.l	d2,d1
	add.l	d1,d0
	move.l	d5,d1
	and.l	#1,d1
	add.l	d1,d0
;		uint32* newData = (uint32*)Mem::alloc(allocationSize*sizeof(uint
	clr.l	-(a7)
	move.w	#1,-(a7)
	moveq	#2,d1
	asl.l	d1,d0
	move.l	d0,-(a7)
	jsr	alloc__Mem__UisE
	add.w	#$A,a7
	move.l	d0,-$C(a5)
;		if (!newData)
	tst.l	-$C(a5)
	bne.b	L190
L189
;			return ERR_NO_FREE_STORE;
	move.l	#-$3030001,d0
	movem.l	(a7)+,d2-d6/a2/a3/a6
	unlk	a5
	rts
L190
;		uint16***	newAllocTable = (uint16***)&newData[0];
	move.l	-$C(a5),-$10(a5)
;		uint32*		newASizeData  = (uint32*)&newData[s];
	move.l	d4,d0
	asl.l	#2,d0
	add.l	-$C(a5),d0
	move.l	d0,-$14(a5)
;		uint16*		newPool				= (uint16*)&newData[2*s];
	move.l	d4,d0
	moveq	#1,d1
	asl.l	d1,d0
	asl.l	#2,d0
	add.l	-$C(a5),d0
	move.l	d0,a6
;		rsint32 i = 0
	moveq	#0,d2
;		rsint32 i = 0, j = 0;
	moveq	#0,d3
;		while (i <size)
	bra.b	L194
L191
;			if (allocTable[i])
	move.l	$18(a2),a0
	tst.l	0(a0,d2.l*4)
	beq.b	L193
L192
;				newAllocTable[j]	= allocTable[i];
	move.l	$18(a2),a0
	move.l	0(a0,d2.l*4),a1
	move.l	-$10(a5),a3
	move.l	a1,0(a3,d3.l*4)
;				newASizeData[j]		= lengthTable[i];
	move.l	$24(a2),a0
	move.l	0(a0,d2.l*4),d0
	move.l	-$14(a5),a1
	move.l	d0,0(a1,d3.l*4)
;				Mem::copy(&newPool[j*tSize], &pool[i*tSize], lengthTabl
	move.l	$24(a2),a0
	move.l	0(a0,d2.l*4),d0
	mulu.l	$C(a2),d0
	moveq	#1,d1
	asl.l	d1,d0
	move.l	$C(a2),d1
	muls.l	d2,d1
	move.l	$1C(a2),a0
	lea	0(a0,d1.l*2),a1
	move.l	$C(a2),d1
	muls.l	d3,d1
	lea	0(a6,d1.l*2),a0
	jsr	copy__Mem__r8Pvr9Pvr0Ui
;				j += lengthTable[i];
	move.l	$24(a2),a0
	add.l	0(a0,d2.l*4),d3
L193
;			i += lengthTable[i];
	move.l	$24(a2),a0
	move.l	d2,d0
	add.l	0(a0,d2.l*4),d0
	move.l	d0,d2
L194
	cmp.l	4(a2),d2
	blt.b	L191
L195
;		Mem::free(data);
	move.l	(a2),-(a7)
	jsr	free__Mem__Pv
	addq.w	#4,a7
;		data				= newData;
	move.l	-$C(a5),(a2)
;		lengthTable		= newASizeData;
	move.l	-$14(a5),$24(a2)
;		pool				= newPool;
	move.l	a6,$1C(a2)
;		allocTable	= newAllocTable;
	move.l	-$10(a5),$18(a2)
;		totalFree += (s - size);
	move.l	d4,d1
	sub.l	4(a2),d1
	add.l	d1,$14(a2)
;		size			= s;
	move.l	d4,4(a2)
;		rawSize		= newRawSize;
	move.l	d5,$8(a2)
;		nextFree	= size - totalFree;
	move.l	4(a2),d0
	sub.l	$14(a2),d0
	move.l	d0,$10(a2)
;		return OK;
	moveq	#0,d0
	movem.l	(a7)+,d2-d6/a2/a3/a6
	unlk	a5
	rts
L196
;	return ERR_RESIZE_TO_SMALL;
	move.l	#-$3800005,d0
	movem.l	(a7)+,d2-d6/a2/a3/a6
	unlk	a5
	rts

	SECTION "defrag__PoolLargeRaw__T:0",CODE


;sint32 PoolLargeRaw::defrag()
	XDEF	defrag__PoolLargeRaw__T
defrag__PoolLargeRaw__T
	movem.l	d2-d7/a2,-(a7)
	move.l	$20(a7),a2
L198
;	if (testConsistency())
	clr.w	-(a7)
	move.l	a2,-(a7)
	jsr	testConsistency__PoolLargeRaw__Ts
	addq.w	#6,a7
	tst.l	d0
	beq.b	L200
L199
;		return ERR_ALLOC_INCONSISTENT;
	move.l	#-$3800004,d0
	movem.l	(a7)+,d2-d7/a2
	rts
L200
;	sint32 c = nextFree;
	move.l	$10(a2),d7
;	sint32 s = c+lengthTable[c];
	move.l	d7,d0
	move.l	$24(a2),a0
	move.l	d7,d4
	add.l	0(a0,d0.l*4),d4
;	while (s < size)
	bra	L211
L201
;		rsint32 sizeBuff = lengthTable[s];
	move.l	$24(a2),a0
	move.l	0(a0,d4.l*4),d5
;		if (allocTable[s])
	move.l	$18(a2),a0
	tst.l	0(a0,d4.l*4)
	beq	L210
L202
;			lengthTable[c]  = sizeBuff;
	move.l	d7,d0
	move.l	$24(a2),a0
	move.l	d5,0(a0,d0.l*4)
;			allocTable[c] = allocTable[s];
	move.l	$18(a2),a0
	move.l	0(a0,d4.l*4),a1
	move.l	d7,d0
	move.l	$18(a2),a0
	move.l	a1,0(a0,d0.l*4)
;			lengthTable[s]  = 0;
	move.l	$24(a2),a0
	clr.l	0(a0,d4.l*4)
;			allocTable[s] = 0;
	move.l	$18(a2),a0
	clr.l	0(a0,d4.l*4)
;			*(allocTable[c]) = &pool[c*tSize];
	move.l	$C(a2),d0
	muls.l	d7,d0
	move.l	$1C(a2),a0
	lea	0(a0,d0.l*2),a1
	move.l	d7,d0
	move.l	$18(a2),a0
	move.l	0(a0,d0.l*4),a0
	move.l	a1,(a0)
;			if (s-c > sizeBuff)
	move.l	d4,d0
	sub.l	d7,d0
	cmp.l	d5,d0
	ble.b	L204
L203
;				Mem::copy(&pool[c*tSize], &pool[s*tSize], sizeBuff*tSiz
	move.l	$C(a2),d0
	muls.l	d5,d0
	moveq	#1,d1
	asl.l	d1,d0
	move.l	$C(a2),d1
	muls.l	d4,d1
	move.l	$1C(a2),a0
	lea	0(a0,d1.l*2),a1
	move.l	$C(a2),d1
	muls.l	d7,d1
	move.l	$1C(a2),a0
	lea	0(a0,d1.l*2),a0
	jsr	copy__Mem__r8Pvr9Pvr0Ui
	bra	L209
L204
;				register sint32 t = 0
	moveq	#0,d2
;				register sint32 t = 0, max = s-c;
	move.l	d4,d3
	sub.l	d7,d3
;				while (t < sizeBuff)
	bra	L208
L205
;					Mem::copy(&pool[(c+t)*tSize], &pool[(s+t)*tSize], max
	move.l	$C(a2),d0
	muls.l	d3,d0
	moveq	#1,d1
	asl.l	d1,d0
	move.l	d4,d1
	add.l	d2,d1
	muls.l	$C(a2),d1
	move.l	$1C(a2),a0
	lea	0(a0,d1.l*2),a1
	move.l	d7,d1
	add.l	d2,d1
	muls.l	$C(a2),d1
	move.l	$1C(a2),a0
	lea	0(a0,d1.l*2),a0
	jsr	copy__Mem__r8Pvr9Pvr0Ui
;					if (t + max > sizeBuff)
	move.l	d2,d0
	add.l	d3,d0
	cmp.l	d5,d0
	ble.b	L207
L206
;						max = sizeBuff-t;
	move.l	d5,d3
	sub.l	d2,d3
;						t += max;
	add.l	d3,d2
;						Mem::copy(&pool[(c+t)*tSize], &pool[(s+t)*tSize], m
	move.l	$C(a2),d0
	muls.l	d3,d0
	moveq	#1,d1
	asl.l	d1,d0
	move.l	d4,d1
	add.l	d2,d1
	muls.l	$C(a2),d1
	move.l	$1C(a2),a0
	lea	0(a0,d1.l*2),a1
	move.l	d7,d1
	add.l	d2,d1
	muls.l	$C(a2),d1
	move.l	$1C(a2),a0
	lea	0(a0,d1.l*2),a0
	jsr	copy__Mem__r8Pvr9Pvr0Ui
L207
;					t += max;
	add.l	d3,d2
L208
	cmp.l	d5,d2
	blt	L205
L209
;			c += sizeBuff;
	move.l	d7,d0
	add.l	d5,d0
	move.l	d0,d7
L210
;		s += sizeBuff;
	add.l	d5,d4
L211
	cmp.l	4(a2),d4
	blt	L201
L212
;	nextFree = c;
	move.l	d7,$10(a2)
;	lengthTable[nextFree] = totalFree;
	move.l	$10(a2),d0
	move.l	$24(a2),a0
	move.l	$14(a2),0(a0,d0.l*4)
;	return OK;
	moveq	#0,d0
	movem.l	(a7)+,d2-d7/a2
	rts

	SECTION "assignSingle__PoolLargeRaw__TPv:0",CODE


;sint32 PoolLargeRaw::assignSingle(void* vt)
	XDEF	assignSingle__PoolLargeRaw__TPv
assignSingle__PoolLargeRaw__TPv
	movem.l	d2/a2,-(a7)
	movem.l	$C(a7),a0/a1
L213
;	ruint16** t = (uint16**)vt;
;	if (*(t) != 0)
	move.l	(a1),a2
	cmp.w	#0,a2
	beq.b	L215
L214
;		return ERR_PTR_USED;
	move.l	#-$3020003,d0
	movem.l	(a7)+,d2/a2
	rts
L215
;	if (totalFree)
	tst.l	$14(a0)
	beq	L225
L216
;		uint32 sizeBuff = lengthTable[nextFree];
	move.l	$10(a0),d0
	move.l	$24(a0),a2
	move.l	0(a2,d0.l*4),d1
;		allocTable[nextFree] = t;
	move.l	$10(a0),d0
	move.l	$18(a0),a2
	move.l	a1,0(a2,d0.l*4)
;		lengthTable[nextFree] = 1;
	move.l	$10(a0),d0
	move.l	$24(a0),a2
	move.l	#1,0(a2,d0.l*4)
;		*(t) = &pool[nextFree*tSize];
	move.l	$10(a0),d0
	muls.l	$C(a0),d0
	move.l	$1C(a0),a2
	lea	0(a2,d0.l*2),a2
	move.l	a2,(a1)
;		totalFree--;
	subq.l	#1,$14(a0)
;		if (totalFree)
	tst.l	$14(a0)
	beq.b	L224
L217
;			if (--sizeBuff) // sizeBuff > 1 == --sizeBuff > 0
	subq.l	#1,d1
	tst.l	d1
	beq.b	L219
L218
;				lengthTable[++nextFree] = sizeBuff;
	move.l	$24(a0),a1
	move.l	$10(a0),d0
	addq.l	#1,d0
	move.l	d0,$10(a0)
	move.l	d1,0(a1,d0.l*4)
;				return OK;
	moveq	#0,d0
	movem.l	(a7)+,d2/a2
	rts
L219
;			rsint32 i = nextFree+1;
	move.l	$10(a0),d0
	addq.l	#1,d0
;			while ((i < size) && allocTable[i]) // i < size just a precaut
	bra.b	L221
L220
;				i += lengthTable[i];
	move.l	$24(a0),a1
	move.l	d0,d1
	add.l	0(a1,d0.l*4),d1
	move.l	d1,d0
L221
	cmp.l	4(a0),d0
	bge.b	L223
L222
	move.l	$18(a0),a1
	tst.l	0(a1,d0.l*4)
	bne.b	L220
L223
;			nextFree = i;
	move.l	d0,$10(a0)
;			return OK;
	moveq	#0,d0
	movem.l	(a7)+,d2/a2
	rts
L224
;		nextFree = -1;
	move.l	#-1,$10(a0)
;		return WRN_RSC_EXHAUSTED;
	move.l	#-$2050006,d0
	movem.l	(a7)+,d2/a2
	rts
L225
;	return ERR_RSC_EXHAUSTED;
	move.l	#-$3050006,d0
	movem.l	(a7)+,d2/a2
	rts

	SECTION "assignVector__PoolLargeRaw__TPvUi:0",CODE


;sint32 PoolLargeRaw::assignVector(void* vt, size_t s)
	XDEF	assignVector__PoolLargeRaw__TPvUi
assignVector__PoolLargeRaw__TPvUi
	movem.l	d2-d4/a2,-(a7)
	move.l	$1C(a7),d2
	move.l	$14(a7),a0
	move.l	$18(a7),a1
L226
;	ruint16** t = (uint16**)vt;
	move.l	a1,a2
;	if (*(t) != 0) // already in use, possibly external
	move.l	(a2),a1
	cmp.w	#0,a1
	beq.b	L228
L227
;		return ERR_PTR_USED;
	move.l	#-$3020003,d0
	movem.l	(a7)+,d2-d4/a2
	rts
L228
;	if (totalFree < s)
	move.l	$14(a0),d0
	cmp.l	d2,d0
	bge.b	L230
L229
;		return ERR_NEW_ALLOC_TO_BIG;
	move.l	#-$3800006,d0
	movem.l	(a7)+,d2-d4/a2
	rts
L230
;	rsint32 i = nextFree
	move.l	$10(a0),d0
;	rsint32 i = nextFree, found = -1;
	moveq	#-1,d1
;	while ((i < size) && (found < 0))
	bra.b	L235
L231
;		if (allocTable[i] == 0 && lengthTable[i] >= s)
	move.l	$18(a0),a1
	move.l	0(a1,d0.l*4),a1
	cmp.w	#0,a1
	bne.b	L234
L232
	move.l	$24(a0),a1
	move.l	0(a1,d0.l*4),d3
	cmp.l	d2,d3
	blo.b	L234
L233
;			found = i;
	move.l	d0,d1
	bra.b	L235
L234
;			i += lengthTable[i];
	move.l	$24(a0),a1
	move.l	d0,d3
	add.l	0(a1,d0.l*4),d3
	move.l	d3,d0
L235
	cmp.l	4(a0),d0
	bge.b	L237
L236
	tst.l	d1
	bmi.b	L231
L237
;	if (found < 0)
	tst.l	d1
	bpl.b	L240
L238
;		if (defrag());
	move.l	a0,-(a7)
	jsr	defrag__PoolLargeRaw__T
	addq.w	#4,a7
L239
;			return ERR_ALLOC_INCONSISTENT;
	move.l	#-$3800004,d0
	movem.l	(a7)+,d2-d4/a2
	rts
L240
;	uint32 sizeBuff = lengthTable[found];
	move.l	$24(a0),a1
	move.l	0(a1,d1.l*4),d0
;	if (s < sizeBuff)
	cmp.l	d0,d2
	bhs.b	L242
L241
;		lengthTable[found] = s;
	move.l	$24(a0),a1
	move.l	d2,0(a1,d1.l*4)
;		lengthTable[found+s] = sizeBuff - s;
	sub.l	d2,d0
	move.l	d1,d3
	add.l	d2,d3
	move.l	$24(a0),a1
	move.l	d0,0(a1,d3.l*4)
L242
;	allocTable[found] = t;
	move.l	$18(a0),a1
	move.l	a2,0(a1,d1.l*4)
;	*(t) = &pool[found*tSize];
	move.l	$C(a0),d0
	muls.l	d1,d0
	move.l	$1C(a0),a1
	lea	0(a1,d0.l*2),a1
	move.l	a1,(a2)
;	totalFree -= s;
	sub.l	d2,$14(a0)
;	if (totalFree)
	tst.l	$14(a0)
	beq.b	L250
L243
;		if (nextFree == found)
	move.l	$10(a0),d0
	cmp.l	d1,d0
	bne.b	L249
L244
;			i = found+s;
	move.l	d1,d0
	add.l	d2,d0
;			while ((i < size) && allocTable[i])
	bra.b	L246
L245
;				i += lengthTable[i];
	move.l	$24(a0),a1
	move.l	d0,d1
	add.l	0(a1,d0.l*4),d1
	move.l	d1,d0
L246
	cmp.l	4(a0),d0
	bge.b	L248
L247
	move.l	$18(a0),a1
	tst.l	0(a1,d0.l*4)
	bne.b	L245
L248
;			nextFree = i;
	move.l	d0,$10(a0)
L249
;		return OK;
	moveq	#0,d0
	movem.l	(a7)+,d2-d4/a2
	rts
L250
;	nextFree = -1;
	move.l	#-1,$10(a0)
;	return WRN_RSC_EXHAUSTED;
	move.l	#-$2050006,d0
	movem.l	(a7)+,d2-d4/a2
	rts

	SECTION "unassign__PoolLargeRaw__TPv:0",CODE


;sint32 PoolLargeRaw::unassign(void* vt)
	XDEF	unassign__PoolLargeRaw__TPv
unassign__PoolLargeRaw__TPv
	movem.l	d2-d5/a2-a4,-(a7)
	movem.l	$20(a7),a0/a1
L251
;	ruint16** t = (uint16**)vt;
;	if (*(t) == 0)
	move.l	(a1),a2
	cmp.w	#0,a2
	bne.b	L253
L252
;		return ERR_PTR_ZERO;
	move.l	#-$3020002,d0
	movem.l	(a7)+,d2-d5/a2-a4
	rts
L253
;	if (!isInPool(*(t)))
	move.l	(a1),a3
	move.l	a0,a2
	moveq	#0,d1
	cmp.l	$1C(a2),a3
	blo.b	L256
L254
	move.l	$8(a2),d0
	subq.l	#1,d0
	move.l	$1C(a2),a4
	lea	0(a4,d0.l*2),a2
	cmp.l	a2,a3
	bhs.b	L256
L255
	moveq	#1,d1
L256
	tst.l	d1
	bne.b	L258
L257
;		return ERR_PTR_RANGE;
	move.l	#-$3020004,d0
	movem.l	(a7)+,d2-d5/a2-a4
	rts
L258
;	rsint32 found = -1;
;		ruint32 p = (uint32)(*(t) - pool);
	move.l	(a1),d0
	sub.l	$1C(a0),d0
	moveq	#1,d1
	asr.l	d1,d0
;		found = p/tSize;
	move.l	d0,d2
	divul.l	$C(a0),d2
;		if (!allocTable[found])
	move.l	$18(a0),a2
	tst.l	0(a2,d2.l*4)
	bne.b	L260
L259
;			return ERR_PTR_INCONSISTENT;
	move.l	#-$3020005,d0
	movem.l	(a7)+,d2-d5/a2-a4
	rts
L260
;	sint32 result = OK;
	moveq	#0,d0
;	*(t) = 0;
	clr.l	(a1)
;	allocTable[found] = 0;
	move.l	$18(a0),a1
	clr.l	0(a1,d2.l*4)
;	ruint32 sizeBuff = lengthTable[found];
	move.l	$24(a0),a1
	move.l	0(a1,d2.l*4),d5
;	totalFree += sizeBuff;
	add.l	d5,$14(a0)
;	if (found + sizeBuff < size)
	move.l	d2,d3
	add.l	d5,d3
	cmp.l	4(a0),d3
	bhs.b	L263
L261
;		uint32 next = found + sizeBuff;
	move.l	d2,d1
	add.l	d5,d1
;		if (allocTable[next] == 0)
	move.l	$18(a0),a1
	move.l	0(a1,d1.l*4),a1
	cmp.w	#0,a1
	bne.b	L263
L262
;			sizeBuff += lengthTable[next];
	move.l	$24(a0),a1
	add.l	0(a1,d1.l*4),d5
;			lengthTable[next] = 0;
	move.l	$24(a0),a1
	clr.l	0(a1,d1.l*4)
;			lengthTable[found] = sizeBuff;
	move.l	$24(a0),a1
	move.l	d5,0(a1,d2.l*4)
L263
;	if (found == 0 || found < nextFree || nextFree == -1)
	tst.l	d2
	beq.b	L266
L264
	cmp.l	$10(a0),d2
	blt.b	L266
L265
	move.l	$10(a0),d1
	cmp.l	#-1,d1
	bne.b	L267
L266
;		nextFree = found;
	move.l	d2,$10(a0)
;		return result;
	movem.l	(a7)+,d2-d5/a2-a4
	rts
L267
;		rsint32 prev = -1;
	moveq	#-1,d3
;		rsint32 i = nextFree;
	move.l	$10(a0),d1
;		while (i < found)
	bra.b	L272
L268
;			if (allocTable[i]==0)
	move.l	$18(a0),a1
	move.l	0(a1,d1.l*4),a1
	cmp.w	#0,a1
	bne.b	L270
L269
;				prev = i;
	move.l	d1,d3
	bra.b	L271
L270
;				prev = -1;
	moveq	#-1,d3
L271
;			i += lengthTable[i];
	move.l	$24(a0),a1
	move.l	d1,d4
	add.l	0(a1,d1.l*4),d4
	move.l	d4,d1
L272
	cmp.l	d2,d1
	blt.b	L268
L273
;		if (prev >= 0)
	tst.l	d3
	bmi.b	L275
L274
;			lengthTable[prev] += sizeBuff;
	move.l	$24(a0),a1
	lea	0(a1,d3.l*4),a1
	add.l	d5,(a1)
;			lengthTable[found] = 0;
	move.l	$24(a0),a0
	clr.l	0(a0,d2.l*4)
L275
;	return result;
	movem.l	(a7)+,d2-d5/a2-a4
	rts

	SECTION "_0ct__PoolSmallRaw__TUiUi:0",CODE


;PoolSmallRaw::PoolSmallRaw(size_t entries, size_t type
	XDEF	_0ct__PoolSmallRaw__TUiUi
_0ct__PoolSmallRaw__TUiUi
	movem.l	d2/a2,-(a7)
	movem.l	$10(a7),d0/d1
	move.l	$C(a7),a1
L276
	move.l	a1,a0
	clr.l	(a0)
	clr.l	4(a0)
	clr.l	$C(a0)
	clr.l	$8(a0)
	move.l	#-1,$10(a0)
	clr.l	$14(a0)
	clr.l	$18(a0)
	clr.l	$1C(a0)
	clr.l	$24(a1)
;	getSpace(entries, typeSize);
	move.l	d1,-(a7)
	move.l	d0,-(a7)
	move.l	a1,-(a7)
	jsr	getSpace__PoolSmallRaw__TUiUi
	add.w	#$C,a7
	movem.l	(a7)+,d2/a2
	rts

	SECTION "_0dt__PoolSmallRaw__T:0",CODE


;PoolSmallRaw::~PoolSmallRaw()
	XDEF	_0dt__PoolSmallRaw__T
_0dt__PoolSmallRaw__T
	move.l	a2,-(a7)
	move.l	$8(a7),a2
L277
;	freeSpace(true);
	clr.w	-(a7)
	move.w	#1,-(a7)
	move.l	a2,-(a7)
	jsr	freeSpace__PoolSmallRaw__Tss
	addq.w	#$8,a7
	move.l	a2,-(a7)
	jsr	_0dt__PoolBase__T
	addq.w	#4,a7
	move.l	(a7)+,a2
	rts

	SECTION "examineBlock__PoolSmallRaw__TUj:0",CODE


;uint32 PoolSmallRaw::examineBlock(uint32 location)
	XDEF	examineBlock__PoolSmallRaw__TUj
examineBlock__PoolSmallRaw__TUj
	movem.l	d2/d3,-(a7)
	move.l	$10(a7),d0
	move.l	$C(a7),a0
L278
;	uint32 i = location
	move.l	d0,d1
;	uint32 i = location, endOfBlock = 0
	moveq	#0,d2
;	uint32 i = location, endOfBlo
	moveq	#1,d0
;	while (i < size && !endOfBlock)
	bra.b	L283
L279
;		i++;
	addq.l	#1,d1
;		if (lengthTable[i] || allocTable[i])
	move.l	$24(a0),a1
	tst.w	0(a1,d1.l*2)
	bne.b	L281
L280
	move.l	$18(a0),a1
	tst.l	0(a1,d1.l*4)
	beq.b	L282
L281
;			endOfBlock = length;
	move.l	d0,d2
	bra.b	L283
L282
;			length++;
	addq.l	#1,d0
L283
	cmp.l	4(a0),d1
	bhs.b	L285
L284
	tst.l	d2
	beq.b	L279
L285
;	return length;
	movem.l	(a7)+,d2/d3
	rts

	SECTION "testConsistency__PoolSmallRaw__Ts:0",CODE


;sint32 PoolSmallRaw::testConsistency(bool strict)
	XDEF	testConsistency__PoolSmallRaw__Ts
testConsistency__PoolSmallRaw__Ts
	movem.l	d2-d5/a2,-(a7)
	move.l	$18(a7),a2
L286
;	sint32 mismatches = 0
	moveq	#0,d5
;	sint32 mismatches = 0, i = 0
	moveq	#0,d2
;	sint32 mismatches = 0, i = 0, blockE
	moveq	#0,d4
;		sint32 lastPos = 0;
	moveq	#0,d3
;		while (i < size)
	bra.b	L295
L287
;			uint32 sizeBuff = lengthTable[i];
	move.l	$24(a2),a0
	moveq	#0,d0
	move.w	0(a0,d2.l*2),d0
;			if (!sizeBuff)
	tst.l	d0
	bne.b	L289
L288
;				blockErrs++;
	addq.l	#1,d4
;				sizeBuff = examineBlock(lastPos);
	move.l	d3,-(a7)
	move.l	a2,-(a7)
	jsr	examineBlock__PoolSmallRaw__TUj
	addq.w	#$8,a7
;				lengthTable[lastPos] = sizeBuff;
	move.l	$24(a2),a0
	move.w	d0,0(a0,d3.l*2)
;				i = lastPos + sizeBuff;
	move.l	d3,d2
	add.l	d0,d2
L289
;			if (allocTable[i] && (*(allocTable[i]) != &pool[i*tSize]))
	move.l	$18(a2),a0
	tst.l	0(a0,d2.l*4)
	beq.b	L292
L290
	move.l	$18(a2),a0
	move.l	0(a0,d2.l*4),a0
	move.l	(a0),a1
	move.l	$C(a2),d1
	muls.l	d2,d1
	move.l	$1C(a2),a0
	lea	0(a0,d1.l*2),a0
	cmp.l	a0,a1
	beq.b	L292
L291
;				mismatches++;
	addq.l	#1,d5
L292
;			if (i + sizeBuff > size)
	move.l	d2,d3
	add.l	d0,d3
	cmp.l	4(a2),d3
	bls.b	L294
L293
;				blockErrs++;
	addq.l	#1,d4
;				sizeBuff = examineBlock(i);
	move.l	d2,-(a7)
	move.l	a2,-(a7)
	jsr	examineBlock__PoolSmallRaw__TUj
	addq.w	#$8,a7
;				lengthTable[i] = sizeBuff;
	move.l	$24(a2),a0
	move.w	d0,0(a0,d2.l*2)
L294
;			lastPos = i;
	move.l	d2,d3
;			i += sizeBuff;
	add.l	d0,d2
L295
	cmp.l	4(a2),d2
	blt	L287
L296
;	return mismatches;
	move.l	d5,d0
	movem.l	(a7)+,d2-d5/a2
	rts

	SECTION "getSpace__PoolSmallRaw__TUiUi:0",CODE


;sint32 PoolSmallRaw::getSpace(size_t s, size_t t)
	XDEF	getSpace__PoolSmallRaw__TUiUi
getSpace__PoolSmallRaw__TUiUi
	movem.l	d2/d3/a2,-(a7)
	move.l	$18(a7),d0
	move.l	$14(a7),d2
	move.l	$10(a7),a2
L297
;	if (pool)
	tst.l	$1C(a2)
	beq.b	L299
L298
;		return ERR_RSC_LOCKED;
	move.l	#-$3050004,d0
	movem.l	(a7)+,d2/d3/a2
	rts
L299
;	t &= 0x0000FFFF;
	and.l	#$FFFF,d0
;	tSize = t/2 + (t & 1);
	move.l	d0,d1
	moveq	#1,d3
	lsr.l	d3,d1
	and.l	#1,d0
	add.l	d0,d1
	move.l	d1,$C(a2)
;	rawSize = tSize*s;
	move.l	$C(a2),d0
	mulu.l	d2,d0
	move.l	d0,$8(a2)
;	size_t allocationSize = s + (s/2) + (s & 1) + (rawSize/2) + (rawSi
	move.l	d2,d0
	moveq	#1,d1
	lsr.l	d1,d0
	add.l	d2,d0
	move.l	d2,d1
	and.l	#1,d1
	add.l	d1,d0
	move.l	$8(a2),d1
	moveq	#1,d3
	lsr.l	d3,d1
	add.l	d1,d0
	move.l	$8(a2),d1
	and.l	#1,d1
	add.l	d1,d0
;	data = (uint32*)Mem::alloc(allocationSize*sizeof(uint32), true);
	clr.l	-(a7)
	move.w	#1,-(a7)
	moveq	#2,d1
	asl.l	d1,d0
	move.l	d0,-(a7)
	jsr	alloc__Mem__UisE
	add.w	#$A,a7
	move.l	d0,(a2)
;	if (!data)
	tst.l	(a2)
	bne.b	L301
L300
;		init();
	move.l	a2,a0
	clr.l	$24(a0)
	clr.l	(a0)
	clr.l	4(a0)
	clr.l	$C(a0)
	clr.l	$8(a0)
	move.l	#-1,$10(a0)
	clr.l	$14(a0)
	clr.l	$18(a0)
	clr.l	$1C(a0)
;		return ERR_NO_FREE_STORE;
	move.l	#-$3030001,d0
	movem.l	(a7)+,d2/d3/a2
	rts
L301
;	allocTable = (uint16***)&data[0];
	move.l	(a2),a0
	move.l	a0,$18(a2)
;	lengthTable  = (uint16*)&data[s];
	move.l	(a2),a0
	lea	0(a0,d2.l*4),a0
	move.l	a0,$24(a2)
;	pool			 = (uint16*)&data[s + (s/2) + (s&1)];
	move.l	d2,d0
	moveq	#1,d1
	lsr.l	d1,d0
	add.l	d2,d0
	move.l	d2,d1
	and.l	#1,d1
	add.l	d1,d0
	move.l	(a2),a0
	lea	0(a0,d0.l*4),a0
	move.l	a0,$1C(a2)
;	size          = s;
	move.l	d2,4(a2)
;	totalFree			= size;
	move.l	4(a2),d0
	move.l	d0,$14(a2)
;	nextFree			= 0;
	clr.l	$10(a2)
;	lengthTable[0]  = size;
	move.l	$24(a2),a0
	move.w	6(a2),(a0)
;	return OK;
	moveq	#0,d0
	movem.l	(a7)+,d2/d3/a2
	rts

	SECTION "freeSpace__PoolSmallRaw__Tss:0",CODE


;sint32 PoolSmallRaw::freeSpace(bool force, bool update)
	XDEF	freeSpace__PoolSmallRaw__Tss
freeSpace__PoolSmallRaw__Tss
	movem.l	d2-d4/a2/a3,-(a7)
	move.w	$1E(a7),d2
	move.w	$1C(a7),d3
	move.l	$18(a7),a2
L302
;	sint32 inUse =  size - totalFree;
	move.l	4(a2),d0
	sub.l	$14(a2),d0
;	if (!force)
	tst.w	d3
	bne.b	L306
L303
;		if (inUse)
	tst.l	d0
	beq.b	L305
L304
;			return ERR_RSC_LOCKED;
	move.l	#-$3050004,d0
	movem.l	(a7)+,d2-d4/a2/a3
	rts
L305
	bra.b	L317
L306
;		if (data && inUse && update)
	tst.l	(a2)
	beq.b	L317
L307
	tst.l	d0
	beq.b	L317
L308
	tst.w	d2
	beq.b	L317
L309
;			sint32 p = 0;
	moveq	#0,d3
;			for (sint32 i=0;
	moveq	#0,d0
	bra.b	L316
L310
;				if (isInPool(*(allocTable[i])))
	move.l	$18(a2),a0
	move.l	0(a0,d0.l*4),a0
	move.l	(a0),a1
	move.l	a2,a0
	moveq	#0,d2
	cmp.l	$1C(a0),a1
	blo.b	L313
L311
	move.l	$8(a0),d1
	subq.l	#1,d1
	move.l	$1C(a0),a3
	lea	0(a3,d1.l*2),a0
	cmp.l	a0,a1
	bhs.b	L313
L312
	moveq	#1,d2
L313
	tst.l	d2
	beq.b	L315
L314
;					*(allocTable[i]) = 0;
	move.l	$18(a2),a0
	move.l	0(a0,d0.l*4),a0
	clr.l	(a0)
L315
;				p++;
	addq.l	#1,d3
	addq.l	#1,d0
L316
	cmp.l	4(a2),d0
	blt.b	L310
L317
;	if (data)
	tst.l	(a2)
	beq.b	L319
L318
;		Mem::free(data);
	move.l	(a2),-(a7)
	jsr	free__Mem__Pv
	addq.w	#4,a7
;		init();
	move.l	a2,a0
	clr.l	$24(a0)
	clr.l	(a0)
	clr.l	4(a0)
	clr.l	$C(a0)
	clr.l	$8(a0)
	move.l	#-1,$10(a0)
	clr.l	$14(a0)
	clr.l	$18(a0)
	clr.l	$1C(a0)
L319
;	return OK;
	moveq	#0,d0
	movem.l	(a7)+,d2-d4/a2/a3
	rts

	SECTION "resize__PoolSmallRaw__TUi:0",CODE


;sint32 PoolSmallRaw::resize(size_t s)
	XDEF	resize__PoolSmallRaw__TUi
resize__PoolSmallRaw__TUi
L334	EQU	-$24
	link	a5,#L334
	movem.l	d2-d6/a2/a3/a6,-(a7)
	move.l	$C(a5),d4
	move.l	$8(a5),a2
L320
;	s &= 0x0000FFFF;
	and.l	#$FFFF,d4
;	if (size == s)
	move.l	4(a2),d0
	cmp.l	d4,d0
	bne.b	L322
L321
;		return OK;
	moveq	#0,d0
	movem.l	(a7)+,d2-d6/a2/a3/a6
	unlk	a5
	rts
L322
;	if (s > (size - totalFree))
	move.l	4(a2),d0
	sub.l	$14(a2),d0
	cmp.l	d0,d4
	ble	L333
L323
;		if (testConsistency())
	clr.w	-(a7)
	move.l	a2,-(a7)
	jsr	testConsistency__PoolSmallRaw__Ts
	addq.w	#6,a7
	tst.l	d0
	beq.b	L325
L324
;			return ERR_ALLOC_INCONSISTENT;
	move.l	#-$3800004,d0
	movem.l	(a7)+,d2-d6/a2/a3/a6
	unlk	a5
	rts
L325
;		uint32 newRawSize = s*tSize;
	move.l	d4,d5
	mulu.l	$C(a2),d5
;		uint32 allocationSize = s + (s/2) + (s & 1) + (rawSize/2) + (raw
	move.l	d4,d0
	moveq	#1,d1
	lsr.l	d1,d0
	add.l	d4,d0
	move.l	d4,d1
	and.l	#1,d1
	add.l	d1,d0
	move.l	$8(a2),d1
	moveq	#1,d2
	lsr.l	d2,d1
	add.l	d1,d0
	move.l	$8(a2),d1
	and.l	#1,d1
	add.l	d1,d0
;		uint32* newData = (uint32*)Mem::alloc(allocationSize*sizeof(uint
	clr.l	-(a7)
	move.w	#1,-(a7)
	moveq	#2,d1
	asl.l	d1,d0
	move.l	d0,-(a7)
	jsr	alloc__Mem__UisE
	add.w	#$A,a7
	move.l	d0,-$C(a5)
;		if (!newData)
	tst.l	-$C(a5)
	bne.b	L327
L326
;			return ERR_NO_FREE_STORE;
	move.l	#-$3030001,d0
	movem.l	(a7)+,d2-d6/a2/a3/a6
	unlk	a5
	rts
L327
;		uint16***	newAllocTable = (uint16***)&newData[0];
	move.l	-$C(a5),-$10(a5)
;		uint16*		newASizeData  = (uint16*)&newData[s];
	move.l	d4,d0
	asl.l	#2,d0
	add.l	-$C(a5),d0
	move.l	d0,-$14(a5)
;		uint16*		newPool				= (uint16*)&newData[s + (s/2 + s&1)];
	move.l	d4,d0
	moveq	#1,d1
	lsr.l	d1,d0
	add.l	d4,d0
	and.l	#1,d0
	add.l	d4,d0
	asl.l	#2,d0
	add.l	-$C(a5),d0
	move.l	d0,a6
;		rsint32 i = 0
	moveq	#0,d2
;		rsint32 i = 0, j = 0;
	moveq	#0,d3
;		while (i <size)
	bra.b	L331
L328
;			if (allocTable[i])
	move.l	$18(a2),a0
	tst.l	0(a0,d2.l*4)
	beq.b	L330
L329
;				newAllocTable[j]	= allocTable[i];
	move.l	$18(a2),a0
	move.l	0(a0,d2.l*4),a1
	move.l	-$10(a5),a3
	move.l	a1,0(a3,d3.l*4)
;				newASizeData[j]		= lengthTable[i];
	move.l	$24(a2),a0
	move.w	0(a0,d2.l*2),d0
	move.l	-$14(a5),a1
	move.w	d0,0(a1,d3.l*2)
;				Mem::copy(&newPool[j*tSize], &pool[i*tSize], lengthTabl
	move.l	$24(a2),a0
	moveq	#0,d0
	move.w	0(a0,d2.l*2),d0
	mulu.l	$C(a2),d0
	moveq	#1,d1
	asl.l	d1,d0
	move.l	$C(a2),d1
	muls.l	d2,d1
	move.l	$1C(a2),a0
	lea	0(a0,d1.l*2),a1
	move.l	$C(a2),d1
	muls.l	d3,d1
	lea	0(a6,d1.l*2),a0
	jsr	copy__Mem__r8Pvr9Pvr0Ui
;				j += lengthTable[i];
	move.l	$24(a2),a0
	moveq	#0,d0
	move.w	0(a0,d2.l*2),d0
	add.l	d0,d3
L330
;			i += lengthTable[i];
	move.l	$24(a2),a0
	moveq	#0,d0
	move.w	0(a0,d2.l*2),d0
	add.l	d0,d2
L331
	cmp.l	4(a2),d2
	blt	L328
L332
;		Mem::free(data);
	move.l	(a2),-(a7)
	jsr	free__Mem__Pv
	addq.w	#4,a7
;		data				= newData;
	move.l	-$C(a5),(a2)
;		lengthTable	= newASizeData;
	move.l	-$14(a5),$24(a2)
;		pool				= newPool;
	move.l	a6,$1C(a2)
;		allocTable	= newAllocTable;
	move.l	-$10(a5),$18(a2)
;		totalFree += (s - size);
	move.l	d4,d1
	sub.l	4(a2),d1
	add.l	d1,$14(a2)
;		size			= s;
	move.l	d4,4(a2)
;		rawSize		= newRawSize;
	move.l	d5,$8(a2)
;		nextFree	= size - totalFree;
	move.l	4(a2),d0
	sub.l	$14(a2),d0
	move.l	d0,$10(a2)
;		return OK;
	moveq	#0,d0
	movem.l	(a7)+,d2-d6/a2/a3/a6
	unlk	a5
	rts
L333
;	return ERR_RESIZE_TO_SMALL;
	move.l	#-$3800005,d0
	movem.l	(a7)+,d2-d6/a2/a3/a6
	unlk	a5
	rts

	SECTION "defrag__PoolSmallRaw__T:0",CODE


;sint32 PoolSmallRaw::defrag()
	XDEF	defrag__PoolSmallRaw__T
defrag__PoolSmallRaw__T
	movem.l	d2-d7/a2,-(a7)
	move.l	$20(a7),a2
L335
;	if (testConsistency())
	clr.w	-(a7)
	move.l	a2,-(a7)
	jsr	testConsistency__PoolSmallRaw__Ts
	addq.w	#6,a7
	tst.l	d0
	beq.b	L337
L336
;		return ERR_ALLOC_INCONSISTENT;
	move.l	#-$3800004,d0
	movem.l	(a7)+,d2-d7/a2
	rts
L337
;	sint32 c = nextFree;
	move.l	$10(a2),d7
;	sint32 s = c+lengthTable[c];
	move.l	d7,d0
	move.l	$24(a2),a0
	move.w	0(a0,d0.l*2),d0
	and.l	#$FFFF,d0
	move.l	d7,d4
	add.l	d0,d4
;	while (s < size)
	bra	L348
L338
;		rsint32 sizeBuff = lengthTable[s];
	move.l	$24(a2),a0
	moveq	#0,d5
	move.w	0(a0,d4.l*2),d5
;		if (allocTable[s])
	move.l	$18(a2),a0
	tst.l	0(a0,d4.l*4)
	beq	L347
L339
;			lengthTable[c]  = sizeBuff;
	move.l	d7,d1
	move.l	$24(a2),a0
	move.w	d5,0(a0,d1.l*2)
;			allocTable[c] = allocTable[s];
	move.l	$18(a2),a0
	move.l	0(a0,d4.l*4),a1
	move.l	d7,d0
	move.l	$18(a2),a0
	move.l	a1,0(a0,d0.l*4)
;			lengthTable[s]  = 0;
	move.l	$24(a2),a0
	clr.w	0(a0,d4.l*2)
;			allocTable[s] = 0;
	move.l	$18(a2),a0
	clr.l	0(a0,d4.l*4)
;			*(allocTable[c]) = &pool[c*tSize];
	move.l	$C(a2),d0
	muls.l	d7,d0
	move.l	$1C(a2),a0
	lea	0(a0,d0.l*2),a1
	move.l	d7,d0
	move.l	$18(a2),a0
	move.l	0(a0,d0.l*4),a0
	move.l	a1,(a0)
;			if (s-c > sizeBuff)
	move.l	d4,d0
	sub.l	d7,d0
	cmp.l	d5,d0
	ble.b	L341
L340
;				Mem::copy(&pool[c*tSize], &pool[s*tSize], sizeBuff*tSiz
	move.l	$C(a2),d0
	muls.l	d5,d0
	moveq	#1,d1
	asl.l	d1,d0
	move.l	$C(a2),d1
	muls.l	d4,d1
	move.l	$1C(a2),a0
	lea	0(a0,d1.l*2),a1
	move.l	$C(a2),d1
	muls.l	d7,d1
	move.l	$1C(a2),a0
	lea	0(a0,d1.l*2),a0
	jsr	copy__Mem__r8Pvr9Pvr0Ui
	bra	L346
L341
;				rsint32 t = 0
	moveq	#0,d2
;				rsint32 t = 0, max = s-c;
	move.l	d4,d3
	sub.l	d7,d3
;				while (t < sizeBuff)
	bra	L345
L342
;					Mem::copy(&pool[(c+t)*tSize], &pool[(s+t)*tSize], max
	move.l	$C(a2),d0
	muls.l	d3,d0
	moveq	#1,d1
	asl.l	d1,d0
	move.l	d4,d1
	add.l	d2,d1
	muls.l	$C(a2),d1
	move.l	$1C(a2),a0
	lea	0(a0,d1.l*2),a1
	move.l	d7,d1
	add.l	d2,d1
	muls.l	$C(a2),d1
	move.l	$1C(a2),a0
	lea	0(a0,d1.l*2),a0
	jsr	copy__Mem__r8Pvr9Pvr0Ui
;					if (t + max > sizeBuff)
	move.l	d2,d0
	add.l	d3,d0
	cmp.l	d5,d0
	ble.b	L344
L343
;						max = sizeBuff-t;
	move.l	d5,d3
	sub.l	d2,d3
;						t += max;
	add.l	d3,d2
;						Mem::copy(&pool[(c+t)*tSize], &pool[(s+t)*tSize], m
	move.l	$C(a2),d0
	muls.l	d3,d0
	moveq	#1,d1
	asl.l	d1,d0
	move.l	d4,d1
	add.l	d2,d1
	muls.l	$C(a2),d1
	move.l	$1C(a2),a0
	lea	0(a0,d1.l*2),a1
	move.l	d7,d1
	add.l	d2,d1
	muls.l	$C(a2),d1
	move.l	$1C(a2),a0
	lea	0(a0,d1.l*2),a0
	jsr	copy__Mem__r8Pvr9Pvr0Ui
L344
;					t += max;
	add.l	d3,d2
L345
	cmp.l	d5,d2
	blt	L342
L346
;			c += sizeBuff;
	move.l	d7,d0
	add.l	d5,d0
	move.l	d0,d7
L347
;		s += sizeBuff;
	add.l	d5,d4
L348
	cmp.l	4(a2),d4
	blt	L338
L349
;	nextFree = c;
	move.l	d7,$10(a2)
;	lengthTable[nextFree] = totalFree;
	move.l	$10(a2),d0
	move.l	$24(a2),a0
	move.w	$16(a2),0(a0,d0.l*2)
;	return OK;
	moveq	#0,d0
	movem.l	(a7)+,d2-d7/a2
	rts

	SECTION "assignSingle__PoolSmallRaw__TPv:0",CODE


;sint32 PoolSmallRaw::assignSingle(void* vt)
	XDEF	assignSingle__PoolSmallRaw__TPv
assignSingle__PoolSmallRaw__TPv
	movem.l	d2/a2,-(a7)
	movem.l	$C(a7),a0/a1
L350
;	ruint16** t = (uint16**)vt;
;	if (*(t) != 0)
	move.l	(a1),a2
	cmp.w	#0,a2
	beq.b	L352
L351
;		return ERR_PTR_USED;
	move.l	#-$3020003,d0
	movem.l	(a7)+,d2/a2
	rts
L352
;	if (totalFree)
	tst.l	$14(a0)
	beq	L362
L353
;		uint32 sizeBuff = lengthTable[nextFree];
	move.l	$10(a0),d0
	move.l	$24(a0),a2
	move.w	0(a2,d0.l*2),d0
	and.l	#$FFFF,d0
;		allocTable[nextFree] = t;
	move.l	$10(a0),d1
	move.l	$18(a0),a2
	move.l	a1,0(a2,d1.l*4)
;		lengthTable[nextFree] = 1;
	move.l	$10(a0),d1
	move.l	$24(a0),a2
	move.w	#1,0(a2,d1.l*2)
;		*(t) = &pool[nextFree*tSize];
	move.l	$10(a0),d1
	muls.l	$C(a0),d1
	move.l	$1C(a0),a2
	lea	0(a2,d1.l*2),a2
	move.l	a2,(a1)
;		totalFree--;
	subq.l	#1,$14(a0)
;		if (totalFree)
	tst.l	$14(a0)
	beq.b	L361
L354
;			if (--sizeBuff)
	subq.l	#1,d0
	tst.l	d0
	beq.b	L356
L355
;				lengthTable[++nextFree] = sizeBuff;
	move.w	d0,d1
	move.l	$24(a0),a1
	move.l	$10(a0),d0
	addq.l	#1,d0
	move.l	d0,$10(a0)
	move.w	d1,0(a1,d0.l*2)
;				return OK;
	moveq	#0,d0
	movem.l	(a7)+,d2/a2
	rts
L356
;			rsint32 i = nextFree+1;
	move.l	$10(a0),d0
	addq.l	#1,d0
;			while ((i < size) && allocTable[i])
	bra.b	L358
L357
;				i += lengthTable[i];
	move.l	$24(a0),a1
	moveq	#0,d1
	move.w	0(a1,d0.l*2),d1
	add.l	d1,d0
L358
	cmp.l	4(a0),d0
	bge.b	L360
L359
	move.l	$18(a0),a1
	tst.l	0(a1,d0.l*4)
	bne.b	L357
L360
;			nextFree = i;
	move.l	d0,$10(a0)
;			return OK;
	moveq	#0,d0
	movem.l	(a7)+,d2/a2
	rts
L361
;		nextFree = -1;
	move.l	#-1,$10(a0)
;		return WRN_RSC_EXHAUSTED;
	move.l	#-$2050006,d0
	movem.l	(a7)+,d2/a2
	rts
L362
;	return ERR_RSC_EXHAUSTED;
	move.l	#-$3050006,d0
	movem.l	(a7)+,d2/a2
	rts

	SECTION "assignVector__PoolSmallRaw__TPvUi:0",CODE


;sint32 PoolSmallRaw::assignVector(void* vt, size_t s)
	XDEF	assignVector__PoolSmallRaw__TPvUi
assignVector__PoolSmallRaw__TPvUi
	movem.l	d2-d4/a2/a3,-(a7)
	move.l	$20(a7),d2
	move.l	$1C(a7),a0
	move.l	$18(a7),a2
L363
;	s &= 0x0000FFFF;
	and.l	#$FFFF,d2
;	ruint16** t = (uint16**)vt;
	move.l	a0,a3
;	if (*(t) != 0)
	move.l	a3,a1
	move.l	(a1),a0
	cmp.w	#0,a0
	beq.b	L365
L364
;		return ERR_PTR_USED;
	move.l	#-$3020003,d0
	movem.l	(a7)+,d2-d4/a2/a3
	rts
L365
;	if (totalFree < s)
	move.l	$14(a2),d0
	cmp.l	d2,d0
	bge.b	L367
L366
;		return ERR_NEW_ALLOC_TO_BIG;
	move.l	#-$3800006,d0
	movem.l	(a7)+,d2-d4/a2/a3
	rts
L367
;	rsint32 i = nextFree
	move.l	$10(a2),d0
;	rsint32 i = nextFree, found = -1;
	moveq	#-1,d1
;	while ((i < size) && (found < 0))
	bra.b	L372
L368
;		if (allocTable[i] == 0 && lengthTable[i] >= s)
	move.l	$18(a2),a0
	move.l	0(a0,d0.l*4),a0
	cmp.w	#0,a0
	bne.b	L371
L369
	move.l	$24(a2),a0
	moveq	#0,d3
	move.w	0(a0,d0.l*2),d3
	cmp.l	d2,d3
	blo.b	L371
L370
;			found = i;
	move.l	d0,d1
	bra.b	L372
L371
;			i += lengthTable[i];
	move.l	$24(a2),a0
	moveq	#0,d3
	move.w	0(a0,d0.l*2),d3
	add.l	d3,d0
L372
	cmp.l	4(a2),d0
	bge.b	L374
L373
	tst.l	d1
	bmi.b	L368
L374
;	if (found < 0)
	tst.l	d1
	bpl.b	L378
L375
;		if (defrag())
	move.l	a2,-(a7)
	jsr	defrag__PoolSmallRaw__T
	addq.w	#4,a7
	tst.l	d0
	beq.b	L377
L376
;			return ERR_ALLOC_INCONSISTENT;
	move.l	#-$3800004,d0
	movem.l	(a7)+,d2-d4/a2/a3
	rts
L377
;		found = nextFree;
	move.l	$10(a2),d1
L378
;	uint32 sizeBuff = lengthTable[found];
	move.l	$24(a2),a0
	moveq	#0,d0
	move.w	0(a0,d1.l*2),d0
;	if (s < sizeBuff)
	cmp.l	d0,d2
	bhs.b	L380
L379
;		lengthTable[found] = s;
	move.l	$24(a2),a0
	move.w	d2,0(a0,d1.l*2)
;		lengthTable[found+s] = sizeBuff - s;
	sub.l	d2,d0
	move.w	d0,d3
	move.l	d1,d0
	add.l	d2,d0
	move.l	$24(a2),a0
	move.w	d3,0(a0,d0.l*2)
L380
;	allocTable[found] = t;
	move.l	$18(a2),a0
	move.l	a3,0(a0,d1.l*4)
;	*(t) = &pool[found*tSize];
	move.l	$C(a2),d0
	muls.l	d1,d0
	move.l	$1C(a2),a0
	lea	0(a0,d0.l*2),a0
	move.l	a3,a1
	move.l	a0,(a1)
;	totalFree -= s;
	sub.l	d2,$14(a2)
;	if (totalFree)
	tst.l	$14(a2)
	beq.b	L388
L381
;		if (nextFree == found)
	move.l	$10(a2),d0
	cmp.l	d1,d0
	bne.b	L387
L382
;			i = found+s;
	move.l	d1,d0
	add.l	d2,d0
;			while ((i < size) && allocTable[i])
	bra.b	L384
L383
;				i += lengthTable[i];
	move.l	$24(a2),a0
	moveq	#0,d1
	move.w	0(a0,d0.l*2),d1
	add.l	d1,d0
L384
	cmp.l	4(a2),d0
	bge.b	L386
L385
	move.l	$18(a2),a0
	tst.l	0(a0,d0.l*4)
	bne.b	L383
L386
;			nextFree = i;
	move.l	d0,$10(a2)
L387
;		return OK;
	moveq	#0,d0
	movem.l	(a7)+,d2-d4/a2/a3
	rts
L388
;	nextFree = -1;
	move.l	#-1,$10(a2)
;	return WRN_RSC_EXHAUSTED;
	move.l	#-$2050006,d0
	movem.l	(a7)+,d2-d4/a2/a3
	rts

	SECTION "unassign__PoolSmallRaw__TPv:0",CODE


;sint32 PoolSmallRaw::unassign(void* vt)
	XDEF	unassign__PoolSmallRaw__TPv
unassign__PoolSmallRaw__TPv
	movem.l	d2-d5/a2-a4,-(a7)
	movem.l	$20(a7),a0/a1
L389
;	ruint16** t = (uint16**)vt;
;	if (*(t) == 0)
	move.l	(a1),a2
	cmp.w	#0,a2
	bne.b	L391
L390
;		return ERR_PTR_ZERO;
	move.l	#-$3020002,d0
	movem.l	(a7)+,d2-d5/a2-a4
	rts
L391
;	if (!isInPool(*(t)))
	move.l	(a1),a3
	move.l	a0,a2
	moveq	#0,d1
	cmp.l	$1C(a2),a3
	blo.b	L394
L392
	move.l	$8(a2),d0
	subq.l	#1,d0
	move.l	$1C(a2),a4
	lea	0(a4,d0.l*2),a2
	cmp.l	a2,a3
	bhs.b	L394
L393
	moveq	#1,d1
L394
	tst.l	d1
	bne.b	L396
L395
;		return ERR_PTR_RANGE;
	move.l	#-$3020004,d0
	movem.l	(a7)+,d2-d5/a2-a4
	rts
L396
;	rsint32 found = -1;
;		ruint32 p = (uint32)(*(t) - pool);
	move.l	(a1),d0
	sub.l	$1C(a0),d0
	moveq	#1,d1
	asr.l	d1,d0
;		found = p/tSize;
	move.l	d0,d2
	divul.l	$C(a0),d2
;		if (!allocTable[found])
	move.l	$18(a0),a2
	tst.l	0(a2,d2.l*4)
	bne.b	L398
L397
;			return ERR_PTR_INCONSISTENT;
	move.l	#-$3020005,d0
	movem.l	(a7)+,d2-d5/a2-a4
	rts
L398
;	sint32 result = OK;
	moveq	#0,d0
;	*(t) = 0;
	clr.l	(a1)
;	allocTable[found] = 0;
	move.l	$18(a0),a1
	clr.l	0(a1,d2.l*4)
;	ruint32 sizeBuff = lengthTable[found];
	move.l	$24(a0),a1
	moveq	#0,d5
	move.w	0(a1,d2.l*2),d5
;	totalFree += sizeBuff;
	add.l	d5,$14(a0)
;	if (found + sizeBuff < size)
	move.l	d2,d3
	add.l	d5,d3
	cmp.l	4(a0),d3
	bhs.b	L401
L399
;		uint32 next = found + sizeBuff;
	move.l	d2,d1
	add.l	d5,d1
;		if (allocTable[next] == 0)
	move.l	$18(a0),a1
	move.l	0(a1,d1.l*4),a1
	cmp.w	#0,a1
	bne.b	L401
L400
;			sizeBuff += lengthTable[next];
	move.l	$24(a0),a1
	moveq	#0,d3
	move.w	0(a1,d1.l*2),d3
	add.l	d3,d5
;			lengthTable[next] = 0;
	move.l	$24(a0),a1
	clr.w	0(a1,d1.l*2)
;			lengthTable[found] = sizeBuff;
	move.l	$24(a0),a1
	move.w	d5,0(a1,d2.l*2)
L401
;	if (found == 0 || found < nextFree || nextFree == -1)
	tst.l	d2
	beq.b	L404
L402
	cmp.l	$10(a0),d2
	blt.b	L404
L403
	move.l	$10(a0),d1
	cmp.l	#-1,d1
	bne.b	L405
L404
;		nextFree = found;
	move.l	d2,$10(a0)
;		return result;
	movem.l	(a7)+,d2-d5/a2-a4
	rts
L405
;		rsint32 prev = -1;
	moveq	#-1,d3
;		rsint32 i = nextFree;
	move.l	$10(a0),d1
;		while (i < found)
	bra.b	L410
L406
;			if (allocTable[i]==0)
	move.l	$18(a0),a1
	move.l	0(a1,d1.l*4),a1
	cmp.w	#0,a1
	bne.b	L408
L407
;				prev = i;
	move.l	d1,d3
	bra.b	L409
L408
;				prev = -1;
	moveq	#-1,d3
L409
;			i += lengthTable[i];
	move.l	$24(a0),a1
	moveq	#0,d4
	move.w	0(a1,d1.l*2),d4
	add.l	d4,d1
L410
	cmp.l	d2,d1
	blt.b	L406
L411
;		if (prev >= 0)
	tst.l	d3
	bmi.b	L413
L412
;			lengthTable[prev] += sizeBuff;
	move.l	$24(a0),a1
	lea	0(a1,d3.l*2),a1
	add.w	d5,(a1)
;			lengthTable[found] = 0;
	move.l	$24(a0),a0
	clr.w	0(a0,d2.l*2)
L413
;	return result;
	movem.l	(a7)+,d2-d5/a2-a4
	rts

	END
