
; Storm C Compiler
; Mendoza:Developer/eXtropiaNG/libsrc/common/utilitylib/list.cpp
	mc68030
	mc68881
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

	SECTION "_linkCache___LLBase:1",DATA

	XDEF	_linkCache___LLBase
_linkCache___LLBase
	dc.l	0

	SECTION "_linkCacheSize___LLBase:1",DATA

	XDEF	_linkCacheSize___LLBase
_linkCacheSize___LLBase
	dc.l	0

	SECTION "_linkCacheDelta___LLBase:1",DATA

	XDEF	_linkCacheDelta___LLBase
_linkCacheDelta___LLBase
	dc.l	$100

	SECTION "_linkCount___LLBase:1",DATA

	XDEF	_linkCount___LLBase
_linkCount___LLBase
	dc.l	0

	SECTION "_nextFree___LLBase:1",DATA

	XDEF	_nextFree___LLBase
_nextFree___LLBase
	dc.l	-1

	SECTION "createLink___LLBase_:0",CODE


;sint32 _LLBase::createLink()
	XDEF	createLink___LLBase_
createLink___LLBase_
L87
;	if (++linkCount > linkCacheSize)
	addq.l	#1,_linkCount___LLBase
	move.l	_linkCount___LLBase,d0
	cmp.l	_linkCacheSize___LLBase,d0
	ble.b	L90
L88
;		if (expandCache()==false)
	jsr	expandCache___LLBase_
	tst.w	d0
	bne.b	L90
L89
;			linkCount--;
	subq.l	#1,_linkCount___LLBase
;			return NULL_LINK;
	moveq	#-1,d0
	rts
L90
;	sint32 link = nextFree;
	move.l	_nextFree___LLBase,d0
;	nextFree = linkCache[nextFree].nextFree;
	move.l	_nextFree___LLBase,d1
	asl.l	#4,d1
	move.l	_linkCache___LLBase,a1
	move.l	$8(a1,d1.l),_nextFree___LLBase
;	return link;
	rts

	SECTION "destroyLink___LLBase__j:0",CODE


;void _LLBase::destroyLink(sint32 l)
	XDEF	destroyLink___LLBase__j
destroyLink___LLBase__j
	move.l	4(a7),d0
L91
;	if (linkCount>0 && l!=NULL_LINK && l<linkCacheSize && linkCache[l]
	move.l	_linkCount___LLBase,d1
	cmp.l	#0,d1
	ble.b	L97
L92
	cmp.l	#-1,d0
	beq.b	L97
L93
	cmp.l	_linkCacheSize___LLBase,d0
	bge.b	L97
L94
	move.l	d0,d1
	asl.l	#4,d1
	move.l	_linkCache___LLBase,a1
	move.l	$C(a1,d1.l),a0
	cmp.w	#0,a0
	beq.b	L97
L95
;		linkCache[l].item = 0;
	move.l	d0,d1
	asl.l	#4,d1
	move.l	_linkCache___LLBase,a1
	clr.l	$C(a1,d1.l)
;		linkCache[l].nextFree = nextFree;
	move.l	d0,d1
	asl.l	#4,d1
	move.l	_linkCache___LLBase,a1
	move.l	_nextFree___LLBase,$8(a1,d1.l)
;		nextFree = l;
	move.l	d0,_nextFree___LLBase
;		if (--linkCount == 0)
	subq.l	#1,_linkCount___LLBase
	tst.l	_linkCount___LLBase
	bne.b	L97
L96
;			Mem::free(linkCache);
	move.l	_linkCache___LLBase,-(a7)
	jsr	free__Mem__Pv
	addq.w	#4,a7
;			linkCacheSize = 0;
	clr.l	_linkCacheSize___LLBase
;			nextFree = NULL_LINK;
	move.l	#-1,_nextFree___LLBase
L97
	rts

	SECTION "expandCache___LLBase_:0",CODE


;bool _LLBase::expandCache()
	XDEF	expandCache___LLBase_
expandCache___LLBase_
	movem.l	d2/d3/a2,-(a7)
L98
;	sint32 newSize = linkCacheSize + linkCacheDelta;
	move.l	_linkCacheSize___LLBase,d2
	add.l	_linkCacheDelta___LLBase,d2
;	void* newCache = Mem::alloc(newSize*sizeof(Link), false, Mem::ALIG
	pea	$10.w
	clr.w	-(a7)
	move.l	d2,d0
	moveq	#4,d1
	asl.l	d1,d0
	move.l	d0,-(a7)
	jsr	alloc__Mem__UisE
	add.w	#$A,a7
	move.l	d0,a2
;	if (!newCache)
	cmp.w	#0,a2
	bne.b	L100
L99
;		return false;
	moveq	#0,d0
	movem.l	(a7)+,d2/d3/a2
	rts
L100
;	if (linkCache)
	tst.l	_linkCache___LLBase
	beq.b	L102
L101
;		Mem::copy(newCache, linkCache, linkCacheSize*sizeof(Link));
	move.l	_linkCacheSize___LLBase,d0
	moveq	#4,d1
	asl.l	d1,d0
	move.l	_linkCache___LLBase,a1
	move.l	a2,a0
	jsr	copy__Mem__r8Pvr9Pvr0Ui
;		Mem::free(linkCache);
	move.l	_linkCache___LLBase,-(a7)
	jsr	free__Mem__Pv
	addq.w	#4,a7
L102
;	linkCache = (Link*)newCache;
	move.l	a2,_linkCache___LLBase
;	for (sint32 i = linkCacheSize;
	move.l	_linkCacheSize___LLBase,d0
	bra.b	L104
L103
;		linkCache[i].nextFree = i+1;
	move.l	d0,d1
	addq.l	#1,d1
	move.l	d0,d3
	asl.l	#4,d3
	move.l	_linkCache___LLBase,a1
	move.l	d1,$8(a1,d3.l)
;		linkCache[i].item = 0;
	move.l	d0,d1
	asl.l	#4,d1
	move.l	_linkCache___LLBase,a1
	clr.l	$C(a1,d1.l)
	addq.l	#1,d0
L104
	cmp.l	d2,d0
	blt.b	L103
L105
;	nextFree = linkCacheSize;
	move.l	_linkCacheSize___LLBase,_nextFree___LLBase
;	linkCacheSize = newSize;
	move.l	d2,_linkCacheSize___LLBase
;	return true;
	moveq	#1,d0
	movem.l	(a7)+,d2/d3/a2
	rts

	SECTION "_0ct___LLBase__T:0",CODE


;_LLBase::_LLBase() 
	XDEF	_0ct___LLBase__T
_0ct___LLBase__T
	move.l	a2,-(a7)
	move.l	$8(a7),a2
L106
	clr.l	$C(a2)
;	head = createLink();
	jsr	createLink___LLBase_
	move.l	d0,(a2)
;	tail = createLink();
	jsr	createLink___LLBase_
	move.l	d0,4(a2)
;	if (head!=NULL_LINK && tail!=NULL_LINK)
	move.l	(a2),d0
	cmp.l	#-1,d0
	beq.b	L109
L107
	move.l	4(a2),d0
	cmp.l	#-1,d0
	beq.b	L109
L108
;		linkCache[head].prev = NULL_LINK;
	move.l	(a2),d0
	asl.l	#4,d0
	move.l	_linkCache___LLBase,a1
	move.l	#-1,0(a1,d0.l)
;		linkCache[head].next = tail;
	move.l	(a2),d0
	asl.l	#4,d0
	move.l	_linkCache___LLBase,a1
	move.l	4(a2),4(a1,d0.l)
;		linkCache[head].item = this;
	move.l	(a2),d0
	asl.l	#4,d0
	move.l	_linkCache___LLBase,a1
	move.l	a2,$C(a1,d0.l)
;		linkCache[tail].prev = head;
	move.l	4(a2),d0
	asl.l	#4,d0
	move.l	_linkCache___LLBase,a1
	move.l	(a2),0(a1,d0.l)
;		linkCache[tail].next = NULL_LINK;
	move.l	4(a2),d0
	asl.l	#4,d0
	move.l	_linkCache___LLBase,a1
	move.l	#-1,4(a1,d0.l)
;		linkCache[tail].item = this;
	move.l	4(a2),d0
	asl.l	#4,d0
	move.l	_linkCache___LLBase,a1
	move.l	a2,$C(a1,d0.l)
;		crnt = tail;
	move.l	4(a2),d0
	move.l	d0,$8(a2)
L109
	move.l	(a7)+,a2
	rts

	SECTION "_0dt___LLBase__T:0",CODE


;_LLBase::~_LLBase()
	XDEF	_0dt___LLBase__T
_0dt___LLBase__T
	movem.l	d2/a2,-(a7)
	move.l	$C(a7),a2
L110
;	rsint32 t = linkCache[head].next;
	move.l	(a2),d0
	asl.l	#4,d0
	move.l	_linkCache___LLBase,a1
	move.l	4(a1,d0.l),d0
;	while (t!=NULL_LINK && t!=tail)
	bra.b	L112
L111
;		rsint32 nt = linkCache[t].next;
	move.l	d0,d1
	asl.l	#4,d1
	move.l	_linkCache___LLBase,a1
	move.l	4(a1,d1.l),d2
;		destroyLink(t);
	move.l	d0,-(a7)
	jsr	destroyLink___LLBase__j
	addq.w	#4,a7
;		t = nt;
	move.l	d2,d0
L112
	cmp.l	#-1,d0
	beq.b	L114
L113
	cmp.l	4(a2),d0
	bne.b	L111
L114
;	destroyLink(head);
	move.l	(a2),-(a7)
	jsr	destroyLink___LLBase__j
	addq.w	#4,a7
;	destroyLink(tail);
	move.l	4(a2),-(a7)
	jsr	destroyLink___LLBase__j
	addq.w	#4,a7
	movem.l	(a7)+,d2/a2
	rts

	SECTION "findFwrd___LLBase__TjPv:0",CODE


;sint32 _LLBase::findFwrd(sint32 s, void *p)
	XDEF	findFwrd___LLBase__TjPv
findFwrd___LLBase__TjPv
	movem.l	a2/a3,-(a7)
	movem.l	$10(a7),d1/a3
	move.l	$C(a7),a2
L115
;	if (p && num>0)
	cmp.w	#0,a3
	beq.b	L123
L116
	move.l	$C(a2),d0
	cmp.l	#0,d0
	ble.b	L123
L117
;		register Link* link = linkCache;
	move.l	_linkCache___LLBase,a0
;		rsint32	search = link[s].next;
	asl.l	#4,d1
	move.l	4(a0,d1.l),d0
;		while (search!=NULL_LINK && search!=tail)
	bra.b	L121
L118
;			if (link[search].item == p)
	move.l	d0,d1
	asl.l	#4,d1
	move.l	$C(a0,d1.l),a1
	cmp.l	a3,a1
	bne.b	L120
L119
;				return search;
	movem.l	(a7)+,a2/a3
	rts
L120
;			search = link[search].next;
	asl.l	#4,d0
	move.l	4(a0,d0.l),d0
L121
	cmp.l	#-1,d0
	beq.b	L123
L122
	cmp.l	4(a2),d0
	bne.b	L118
L123
;	return NULL_LINK;
	moveq	#-1,d0
	movem.l	(a7)+,a2/a3
	rts

	SECTION "findBkwd___LLBase__TjPv:0",CODE


;sint32 _LLBase::findBkwd(sint32 s, void *p)
	XDEF	findBkwd___LLBase__TjPv
findBkwd___LLBase__TjPv
	movem.l	a2/a3,-(a7)
	movem.l	$10(a7),d1/a3
	move.l	$C(a7),a2
L124
;	if (p && num>0)
	cmp.w	#0,a3
	beq.b	L132
L125
	move.l	$C(a2),d0
	cmp.l	#0,d0
	ble.b	L132
L126
;		register Link* link = linkCache;
	move.l	_linkCache___LLBase,a0
;		rsint32	search = link[s].prev;
	asl.l	#4,d1
	move.l	0(a0,d1.l),d0
;		while (search!=NULL_LINK && search!=head)
	bra.b	L130
L127
;			if (link[search].item == p)
	move.l	d0,d1
	asl.l	#4,d1
	move.l	$C(a0,d1.l),a1
	cmp.l	a3,a1
	bne.b	L129
L128
;				return search;
	movem.l	(a7)+,a2/a3
	rts
L129
;			search = link[search].prev;
	asl.l	#4,d0
	move.l	0(a0,d0.l),d0
L130
	cmp.l	#-1,d0
	beq.b	L132
L131
	cmp.l	(a2),d0
	bne.b	L127
L132
;	return NULL_LINK;
	moveq	#-1,d0
	movem.l	(a7)+,a2/a3
	rts

	SECTION "rem___LLBase__r0jr1j:0",CODE


;sint32 _LLBase::rem(REGI0 sint32 s, REGI1 sint32 e)
	XDEF	rem___LLBase__r0jr1j
rem___LLBase__r0jr1j
	movem.l	d2-d5/a2,-(a7)
	move.l	d0,d5
	move.l	d1,d4
L133
;	if (s!=e)
	cmp.l	d4,d5
	beq.b	L141
L134
;		if (s>e)
	cmp.l	d4,d5
	ble.b	L136
L135
;			sint32 t = s;
	move.l	d5,d0
;			s = e;
	move.l	d4,d5
;			e = t
	move.l	d0,d4
L136
;		register Link* link = linkCache;
	move.l	_linkCache___LLBase,a2
;		rsint32 search = link[s].next;
	move.l	d5,d0
	asl.l	#4,d0
	move.l	4(a2,d0.l),d2
;		rsint32 n = 0;
	moveq	#0,d3
;		while (search!=NULL_LINK && search!=e)
	bra.b	L138
L137
;			destroyLink(search);
	move.l	d2,-(a7)
	jsr	destroyLink___LLBase__j
	addq.w	#4,a7
;			search = link[search].next;
	asl.l	#4,d2
	move.l	4(a2,d2.l),d2
;			n++;
	addq.l	#1,d3
L138
	cmp.l	#-1,d2
	beq.b	L140
L139
	cmp.l	d4,d2
	bne.b	L137
L140
;		link[s].next = e;
	move.l	d5,d0
	asl.l	#4,d0
	move.l	d4,4(a2,d0.l)
;		link[e].prev = s;
	asl.l	#4,d4
	move.l	d5,0(a2,d4.l)
;		return n;
	move.l	d3,d0
	movem.l	(a7)+,d2-d5/a2
	rts
L141
;	return 0;
	moveq	#0,d0
	movem.l	(a7)+,d2-d5/a2
	rts

	SECTION "rem___LLBase__r0jr1jr8Pv:0",CODE


;sint32 _LLBase::rem(REGI0 sint32 s, REGI1 sint32 e, REGP0 void* p)
	XDEF	rem___LLBase__r0jr1jr8Pv
rem___LLBase__r0jr1jr8Pv
	movem.l	d2-d4/a2/a3,-(a7)
	move.l	d1,d4
	move.l	a0,a3
L142
;	if (p && s!=e)
	cmp.w	#0,a3
	beq	L153
L143
	cmp.l	d4,d0
	beq.b	L153
L144
;		if (s>e)
	cmp.l	d4,d0
	ble.b	L146
L145
;			sint32 t = s;
	move.l	d0,d1
;			s = e;
	move.l	d4,d0
;			e = t
	move.l	d1,d4
L146
;		register Link* link = linkCache;
	move.l	_linkCache___LLBase,a2
;		rsint32 search = link[s].next;
	asl.l	#4,d0
	move.l	4(a2,d0.l),d2
;		rsint32 n = 0;
	moveq	#0,d3
;		while (search!=NULL_LINK && search!=e)
	bra.b	L150
L147
;			if (link[search].item == p)
	move.l	d2,d0
	asl.l	#4,d0
	move.l	$C(a2,d0.l),a0
	cmp.l	a3,a0
	bne.b	L149
L148
;				link[link[search].prev].next	= link[search].next;
	move.l	d2,d0
	asl.l	#4,d0
	move.l	4(a2,d0.l),d1
	move.l	d2,d0
	asl.l	#4,d0
	move.l	0(a2,d0.l),d0
	asl.l	#4,d0
	move.l	d1,4(a2,d0.l)
;				link[link[search].next].prev	= link[search].prev;
	move.l	d2,d0
	asl.l	#4,d0
	move.l	0(a2,d0.l),d1
	move.l	d2,d0
	asl.l	#4,d0
	move.l	4(a2,d0.l),d0
	asl.l	#4,d0
	move.l	d1,0(a2,d0.l)
;				destroyLink(search);
	move.l	d2,-(a7)
	jsr	destroyLink___LLBase__j
	addq.w	#4,a7
;				n++;
	addq.l	#1,d3
L149
;			search = link[search].next;
	asl.l	#4,d2
	move.l	4(a2,d2.l),d2
L150
	cmp.l	#-1,d2
	beq.b	L152
L151
	cmp.l	d4,d2
	bne.b	L147
L152
;		return n;
	move.l	d3,d0
	movem.l	(a7)+,d2-d4/a2/a3
	rts
L153
;	return 0;
	moveq	#0,d0
	movem.l	(a7)+,d2-d4/a2/a3
	rts

	SECTION "cnt___LLBase__r0jr1jr8Pv:0",CODE


;sint32 _LLBase::cnt(REGI0 sint32 s, REGI1 sint32 e, REGP0 void* p)
	XDEF	cnt___LLBase__r0jr1jr8Pv
cnt___LLBase__r0jr1jr8Pv
	movem.l	d2/d3/a2,-(a7)
L154
;	if (p && s!=e)
	cmp.w	#0,a0
	beq.b	L165
L155
	cmp.l	d1,d0
	beq.b	L165
L156
;		if (s>e)
	cmp.l	d1,d0
	ble.b	L158
L157
;			sint32 t = s;
	move.l	d0,d2
;			s = e;
	move.l	d1,d0
;			e = t
	move.l	d2,d1
L158
;		register Link* link = linkCache;
	move.l	_linkCache___LLBase,a1
;		rsint32 search = link[s].next;
	asl.l	#4,d0
	move.l	4(a1,d0.l),d2
;		rsint32 n = 0;
	moveq	#0,d0
;		while (search!=NULL_LINK && search!=e)
	bra.b	L162
L159
;			if (link[search].item == p)
	move.l	d2,d3
	asl.l	#4,d3
	move.l	$C(a1,d3.l),a2
	cmp.l	a0,a2
	bne.b	L161
L160
;				n++;
	addq.l	#1,d0
L161
;			search = link[search].next;
	asl.l	#4,d2
	move.l	4(a1,d2.l),d2
L162
	cmp.l	#-1,d2
	beq.b	L164
L163
	cmp.l	d1,d2
	bne.b	L159
L164
;		return n;
	movem.l	(a7)+,d2/d3/a2
	rts
L165
;	return 0;
	moveq	#0,d0
	movem.l	(a7)+,d2/d3/a2
	rts

	SECTION "rep___LLBase__r0jr1jr8Pvr9Pv:0",CODE


;sint32 _LLBase::rep(REGI0 sint32 s, REGI1 sint32 e, REGP0 void* p, R
	XDEF	rep___LLBase__r0jr1jr8Pvr9Pv
rep___LLBase__r0jr1jr8Pvr9Pv
	movem.l	d2/d3/a2-a4,-(a7)
L166
;	if (p && r && p!=r && s!=e)
	cmp.w	#0,a0
	beq.b	L179
L167
	cmp.w	#0,a1
	beq.b	L179
L168
	cmp.l	a1,a0
	beq.b	L179
L169
	cmp.l	d1,d0
	beq.b	L179
L170
;		if (s>e)
	cmp.l	d1,d0
	ble.b	L172
L171
;			sint32 t = s;
	move.l	d0,d2
;			s = e;
	move.l	d1,d0
;			e = t
	move.l	d2,d1
L172
;		register Link* link = linkCache;
	move.l	_linkCache___LLBase,a2
;		rsint32 search = link[s].next;
	asl.l	#4,d0
	move.l	4(a2,d0.l),d2
;		rsint32 n = 0;
	moveq	#0,d0
;		while (search!=NULL_LINK && search!=e)
	bra.b	L176
L173
;			if (link[search].item == p)
	move.l	d2,d3
	asl.l	#4,d3
	move.l	$C(a2,d3.l),a3
	cmp.l	a0,a3
	bne.b	L175
L174
;				linkCache[search].item = r;
	move.l	d2,d3
	asl.l	#4,d3
	move.l	_linkCache___LLBase,a4
	move.l	a1,$C(a4,d3.l)
;				n++;
	addq.l	#1,d0
L175
;			search = link[search].next;
	asl.l	#4,d2
	move.l	4(a2,d2.l),d2
L176
	cmp.l	#-1,d2
	beq.b	L178
L177
	cmp.l	d1,d2
	bne.b	L173
L178
;		return n;
	movem.l	(a7)+,d2/d3/a2-a4
	rts
L179
;	return 0;
	moveq	#0,d0
	movem.l	(a7)+,d2/d3/a2-a4
	rts

	SECTION "contains___LLBase__TPv:0",CODE


;bool _LLBase::contains(void *p)
	XDEF	contains___LLBase__TPv
contains___LLBase__TPv
	movem.l	d2/d3/a2/a3,-(a7)
	move.l	$18(a7),a1
	move.l	$14(a7),a2
L180
;	if (p && num>0)
	cmp.w	#0,a1
	beq.b	L189
L181
	move.l	$C(a2),d0
	cmp.l	#0,d0
	ble.b	L189
L182
;		register Link* link = linkCache;
	move.l	_linkCache___LLBase,a0
;		rsint32 rev = link[tail].prev;
	move.l	4(a2),d0
	asl.l	#4,d0
	move.l	0(a0,d0.l),d2
;		rsint32 fwd = link[head].next;
	move.l	(a2),d0
	asl.l	#4,d0
	move.l	4(a0,d0.l),d1
;		rsint32 n = num+1;
	move.l	$C(a2),d0
	addq.l	#1,d0
;		while (n>0)
	bra.b	L188
L183
;			if (link[fwd].item == p)
	move.l	d1,d3
	asl.l	#4,d3
	move.l	$C(a0,d3.l),a2
	cmp.l	a1,a2
	bne.b	L185
L184
;				return true;
	moveq	#1,d0
	movem.l	(a7)+,d2/d3/a2/a3
	rts
L185
;			n--;
	subq.l	#1,d0
;			fwd = link[fwd].next;
	asl.l	#4,d1
	move.l	4(a0,d1.l),d1
;			if (link[rev].item == p)
	move.l	d2,d3
	asl.l	#4,d3
	move.l	$C(a0,d3.l),a2
	cmp.l	a1,a2
	bne.b	L187
L186
;				return true;
	moveq	#1,d0
	movem.l	(a7)+,d2/d3/a2/a3
	rts
L187
;			n--;
	subq.l	#1,d0
;			rev = link[rev].prev;
	asl.l	#4,d2
	move.l	0(a0,d2.l),d2
L188
	cmp.l	#0,d0
	bgt.b	L183
L189
;	return false;
	moveq	#0,d0
	movem.l	(a7)+,d2/d3/a2/a3
	rts

	SECTION "insLast___LLBase__TPv:0",CODE


;bool _LLBase::insLast(void* p)
	XDEF	insLast___LLBase__TPv
insLast___LLBase__TPv
	movem.l	d2/a2/a3,-(a7)
	movem.l	$10(a7),a2/a3
L190
;	if (p)
	cmp.w	#0,a3
	beq.b	L193
L191
;		sint32 add = createLink();
	jsr	createLink___LLBase_
;		if (add!=NULL_LINK)
	cmp.l	#-1,d0
	beq.b	L193
L192
;			register Link* link 				= linkCache;
	move.l	_linkCache___LLBase,a0
;			link[add].item							= p;
	move.l	d0,d1
	asl.l	#4,d1
	move.l	a3,$C(a0,d1.l)
;			link[add].prev							= link[tail].prev;
	move.l	4(a2),d1
	asl.l	#4,d1
	move.l	d0,d2
	asl.l	#4,d2
	move.l	0(a0,d1.l),0(a0,d2.l)
;			link[link[tail].prev].next	= add;
	move.l	4(a2),d1
	asl.l	#4,d1
	move.l	0(a0,d1.l),d1
	asl.l	#4,d1
	move.l	d0,4(a0,d1.l)
;			link[add].next							= tail;
	move.l	d0,d2
	asl.l	#4,d2
	move.l	4(a2),4(a0,d2.l)
;			link[tail].prev							= add;
	move.l	4(a2),d1
	asl.l	#4,d1
	move.l	d0,0(a0,d1.l)
;			num++;
	addq.l	#1,$C(a2)
;			return true;
	moveq	#1,d0
	movem.l	(a7)+,d2/a2/a3
	rts
L193
;	return false;
	moveq	#0,d0
	movem.l	(a7)+,d2/a2/a3
	rts

	SECTION "insFirst___LLBase__TPv:0",CODE


;bool _LLBase::insFirst(void* p)
	XDEF	insFirst___LLBase__TPv
insFirst___LLBase__TPv
	movem.l	d2/a2/a3,-(a7)
	movem.l	$10(a7),a2/a3
L194
;	if (p)
	cmp.w	#0,a3
	beq.b	L197
L195
;		sint32 add = createLink();
	jsr	createLink___LLBase_
;		if (add!=NULL_LINK)
	cmp.l	#-1,d0
	beq.b	L197
L196
;			register Link* link 				= linkCache;
	move.l	_linkCache___LLBase,a0
;			link[add].item							= p;
	move.l	d0,d1
	asl.l	#4,d1
	move.l	a3,$C(a0,d1.l)
;			link[add].next							= link[head].next;
	move.l	(a2),d1
	asl.l	#4,d1
	move.l	d0,d2
	asl.l	#4,d2
	move.l	4(a0,d1.l),4(a0,d2.l)
;			link[link[head].next].prev	= add;
	move.l	(a2),d1
	asl.l	#4,d1
	move.l	4(a0,d1.l),d1
	asl.l	#4,d1
	move.l	d0,0(a0,d1.l)
;			link[add].prev							= head;
	move.l	d0,d2
	asl.l	#4,d2
	move.l	(a2),0(a0,d2.l)
;			link[head].next							= add;
	move.l	(a2),d1
	asl.l	#4,d1
	move.l	d0,4(a0,d1.l)
;			num++;
	addq.l	#1,$C(a2)
;			return true;
	moveq	#1,d0
	movem.l	(a7)+,d2/a2/a3
	rts
L197
;	return false;
	moveq	#0,d0
	movem.l	(a7)+,d2/a2/a3
	rts

	SECTION "insCurr___LLBase__TPv:0",CODE


;bool _LLBase::insCurr(void* p)
	XDEF	insCurr___LLBase__TPv
insCurr___LLBase__TPv
	movem.l	d2/d3/a2/a3,-(a7)
	movem.l	$14(a7),a2/a3
L198
;	if (p)
	cmp.w	#0,a3
	beq.b	L201
L199
;		sint32 add = createLink();
	jsr	createLink___LLBase_
;		if (add!=NULL_LINK)
	cmp.l	#-1,d0
	beq.b	L201
L200
;			register Link* link = linkCache;
	move.l	_linkCache___LLBase,a0
;			sint32 pre					= link[crnt].prev;
	move.l	$8(a2),d1
	asl.l	#4,d1
	move.l	0(a0,d1.l),d1
;			link[add].item			= p;
	move.l	d0,d2
	asl.l	#4,d2
	move.l	a3,$C(a0,d2.l)
;			link[crnt].prev			= add;
	move.l	$8(a2),d2
	asl.l	#4,d2
	move.l	d0,0(a0,d2.l)
;			link[add].next			= crnt;
	move.l	d0,d3
	asl.l	#4,d3
	move.l	$8(a2),4(a0,d3.l)
;			link[add].prev			= pre;
	move.l	d0,d2
	asl.l	#4,d2
	move.l	d1,0(a0,d2.l)
;			link[pre].next			= add;
	asl.l	#4,d1
	move.l	d0,4(a0,d1.l)
;			num++;
	addq.l	#1,$C(a2)
;			return true;
	moveq	#1,d0
	movem.l	(a7)+,d2/d3/a2/a3
	rts
L201
;	return false;
	moveq	#0,d0
	movem.l	(a7)+,d2/d3/a2/a3
	rts

	SECTION "remLast___LLBase__T:0",CODE


;void* _LLBase::remLast()
	XDEF	remLast___LLBase__T
remLast___LLBase__T
	movem.l	d2/a2/a3,-(a7)
	move.l	$10(a7),a2
L202
;	if (num>0)
	move.l	$C(a2),d0
	cmp.l	#0,d0
	ble.b	L206
L203
;		register	Link* link				= linkCache;
	move.l	_linkCache___LLBase,a0
;		sint32		removing					= link[tail].prev;
	move.l	4(a2),d0
	asl.l	#4,d0
	move.l	0(a0,d0.l),d0
;		void*			item							= link[removing].item;
	move.l	d0,d1
	asl.l	#4,d1
	move.l	$C(a0,d1.l),a3
;		link[tail].prev							= link[removing].prev;
	move.l	d0,d1
	asl.l	#4,d1
	move.l	0(a0,d1.l),d2
	move.l	4(a2),d1
	asl.l	#4,d1
	move.l	d2,0(a0,d1.l)
;		link[link[tail].prev].next	= tail;
	move.l	4(a2),d1
	asl.l	#4,d1
	move.l	0(a0,d1.l),d1
	asl.l	#4,d1
	move.l	4(a2),4(a0,d1.l)
;		if (crnt == removing)
	move.l	$8(a2),d1
	cmp.l	d0,d1
	bne.b	L205
L204
;			crnt = link[tail].prev;
	move.l	4(a2),d1
	asl.l	#4,d1
	move.l	0(a0,d1.l),$8(a2)
L205
;		destroyLink(removing);
	move.l	d0,-(a7)
	jsr	destroyLink___LLBase__j
	addq.w	#4,a7
;		num--;
	subq.l	#1,$C(a2)
;		return item;
	move.l	a3,d0
	movem.l	(a7)+,d2/a2/a3
	rts
L206
;	return 0;
	moveq	#0,d0
	movem.l	(a7)+,d2/a2/a3
	rts

	SECTION "remFirst___LLBase__T:0",CODE


;void* _LLBase::remFirst()
	XDEF	remFirst___LLBase__T
remFirst___LLBase__T
	movem.l	d2/a2/a3,-(a7)
	move.l	$10(a7),a2
L207
;	if (num>0)
	move.l	$C(a2),d0
	cmp.l	#0,d0
	ble.b	L211
L208
;		register	Link* link				= linkCache;
	move.l	_linkCache___LLBase,a0
;		sint32		removing					= link[head].next;
	move.l	(a2),d0
	asl.l	#4,d0
	move.l	4(a0,d0.l),d0
;		void*			item							= link[removing].item;
	move.l	d0,d1
	asl.l	#4,d1
	move.l	$C(a0,d1.l),a3
;		link[head].next							= link[removing].next;
	move.l	d0,d1
	asl.l	#4,d1
	move.l	4(a0,d1.l),d2
	move.l	(a2),d1
	asl.l	#4,d1
	move.l	d2,4(a0,d1.l)
;		link[link[head].next].prev	= head;
	move.l	(a2),d1
	asl.l	#4,d1
	move.l	4(a0,d1.l),d1
	asl.l	#4,d1
	move.l	(a2),0(a0,d1.l)
;		if (crnt == removing)
	move.l	$8(a2),d1
	cmp.l	d0,d1
	bne.b	L210
L209
;			crnt = link[head].next;
	move.l	(a2),d1
	asl.l	#4,d1
	move.l	4(a0,d1.l),$8(a2)
L210
;		destroyLink(removing);
	move.l	d0,-(a7)
	jsr	destroyLink___LLBase__j
	addq.w	#4,a7
;		num--;
	subq.l	#1,$C(a2)
;		return item;
	move.l	a3,d0
	movem.l	(a7)+,d2/a2/a3
	rts
L211
;	return 0;
	moveq	#0,d0
	movem.l	(a7)+,d2/a2/a3
	rts

	SECTION "remCurr___LLBase__T:0",CODE


;void* _LLBase::remCurr()
	XDEF	remCurr___LLBase__T
remCurr___LLBase__T
	movem.l	d2/a2/a3,-(a7)
	move.l	$10(a7),a2
L212
;	if (num>0)
	move.l	$C(a2),d0
	cmp.l	#0,d0
	ble.b	L214
L213
;		register	Link* link				= linkCache;
	move.l	_linkCache___LLBase,a0
;		sint32		removing					= crnt;
	move.l	$8(a2),d2
;		void*			item							= link[crnt].item;
	move.l	$8(a2),d0
	asl.l	#4,d0
	move.l	$C(a0,d0.l),a3
;		link[link[crnt].prev].next	= link[crnt].next;
	move.l	$8(a2),d0
	asl.l	#4,d0
	move.l	4(a0,d0.l),d1
	move.l	$8(a2),d0
	asl.l	#4,d0
	move.l	0(a0,d0.l),d0
	asl.l	#4,d0
	move.l	d1,4(a0,d0.l)
;		link[link[crnt].next].prev	= link[crnt].prev;
	move.l	$8(a2),d0
	asl.l	#4,d0
	move.l	0(a0,d0.l),d1
	move.l	$8(a2),d0
	asl.l	#4,d0
	move.l	4(a0,d0.l),d0
	asl.l	#4,d0
	move.l	d1,0(a0,d0.l)
;		crnt												= link[crnt].next;
	move.l	$8(a2),d0
	asl.l	#4,d0
	move.l	4(a0,d0.l),$8(a2)
;		destroyLink(removing);
	move.l	d2,-(a7)
	jsr	destroyLink___LLBase__j
	addq.w	#4,a7
;		num--;
	subq.l	#1,$C(a2)
;		return item;
	move.l	a3,d0
	movem.l	(a7)+,d2/a2/a3
	rts
L214
;	return 0;
	moveq	#0,d0
	movem.l	(a7)+,d2/a2/a3
	rts

	SECTION "remFirst___LLBase__TPv:0",CODE


;bool _LLBase::remFirst(void *p)
	XDEF	remFirst___LLBase__TPv
remFirst___LLBase__TPv
	move.l	a2,-(a7)
	move.l	$C(a7),a0
	move.l	$8(a7),a2
L215
;	if (p && num>0)
	cmp.w	#0,a0
	beq.b	L219
L216
	move.l	$C(a2),d0
	cmp.l	#0,d0
	ble.b	L219
L217
;		sint32 found = findFwrd(head, p);
	move.l	a0,-(a7)
	move.l	(a2),-(a7)
	move.l	a2,-(a7)
	jsr	findFwrd___LLBase__TjPv
	add.w	#$C,a7
;		if (found!=NULL_LINK)
	cmp.l	#-1,d0
	beq.b	L219
L218
;			destroyLink(found);
	move.l	d0,-(a7)
	jsr	destroyLink___LLBase__j
	addq.w	#4,a7
;			num--;
	subq.l	#1,$C(a2)
;			return true;
	moveq	#1,d0
	move.l	(a7)+,a2
	rts
L219
;	return false;
	moveq	#0,d0
	move.l	(a7)+,a2
	rts

	SECTION "remLast___LLBase__TPv:0",CODE


;bool _LLBase::remLast(void *p)
	XDEF	remLast___LLBase__TPv
remLast___LLBase__TPv
	move.l	a2,-(a7)
	move.l	$C(a7),a0
	move.l	$8(a7),a2
L220
;	if (p && num>0)
	cmp.w	#0,a0
	beq.b	L224
L221
	move.l	$C(a2),d0
	cmp.l	#0,d0
	ble.b	L224
L222
;		sint32 found = findBkwd(tail, p);
	move.l	a0,-(a7)
	move.l	4(a2),-(a7)
	move.l	a2,-(a7)
	jsr	findBkwd___LLBase__TjPv
	add.w	#$C,a7
;		if (found!=NULL_LINK)
	cmp.l	#-1,d0
	beq.b	L224
L223
;			destroyLink(found);
	move.l	d0,-(a7)
	jsr	destroyLink___LLBase__j
	addq.w	#4,a7
;			num--;
	subq.l	#1,$C(a2)
;			return true;
	moveq	#1,d0
	move.l	(a7)+,a2
	rts
L224
;	return false;
	moveq	#0,d0
	move.l	(a7)+,a2
	rts

	SECTION "repFirst___LLBase__TPvPv:0",CODE


;bool _LLBase::repFirst(void* p, void* r)
	XDEF	repFirst___LLBase__TPvPv
repFirst___LLBase__TPvPv
	move.l	a2,-(a7)
	movem.l	$8(a7),a0-a2
L225
;	if (p && r && p!=r && num>0)
	cmp.w	#0,a1
	beq.b	L231
L226
	cmp.w	#0,a2
	beq.b	L231
L227
	cmp.l	a2,a1
	beq.b	L231
L228
	move.l	$C(a0),d0
	cmp.l	#0,d0
	ble.b	L231
L229
;		sint32 found = findFwrd(head, p);
	move.l	a1,-(a7)
	move.l	(a0),-(a7)
	move.l	a0,-(a7)
	jsr	findFwrd___LLBase__TjPv
	add.w	#$C,a7
;		if (found!=NULL_LINK)
	cmp.l	#-1,d0
	beq.b	L231
L230
;			linkCache[found].item = r;
	asl.l	#4,d0
	move.l	_linkCache___LLBase,a1
	move.l	a2,$C(a1,d0.l)
;			return true;
	moveq	#1,d0
	move.l	(a7)+,a2
	rts
L231
;	return false;
	moveq	#0,d0
	move.l	(a7)+,a2
	rts

	SECTION "repLast___LLBase__TPvPv:0",CODE


;bool _LLBase::repLast(void* p, void* r)
	XDEF	repLast___LLBase__TPvPv
repLast___LLBase__TPvPv
	move.l	a2,-(a7)
	movem.l	$8(a7),a0-a2
L232
;	if (p && r && p!=r && num>0)
	cmp.w	#0,a1
	beq.b	L238
L233
	cmp.w	#0,a2
	beq.b	L238
L234
	cmp.l	a2,a1
	beq.b	L238
L235
	move.l	$C(a0),d0
	cmp.l	#0,d0
	ble.b	L238
L236
;		sint32 found = findBkwd(tail, p);
	move.l	a1,-(a7)
	move.l	4(a0),-(a7)
	move.l	a0,-(a7)
	jsr	findBkwd___LLBase__TjPv
	add.w	#$C,a7
;		if (found!=NULL_LINK)
	cmp.l	#-1,d0
	beq.b	L238
L237
;			linkCache[found].item = r;
	asl.l	#4,d0
	move.l	_linkCache___LLBase,a1
	move.l	a2,$C(a1,d0.l)
;			return true;
	moveq	#1,d0
	move.l	(a7)+,a2
	rts
L238
;	return false;
	moveq	#0,d0
	move.l	(a7)+,a2
	rts

	END
