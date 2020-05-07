;//****************************************************************************//
;//**                                                                        **//
;//** File:         libsrc/plat/amigaos3_68k/utilitylib/listopt.asm          **//
;//** Description:  Optimised list routines                                  **//
;//** Comment(s):                                                            **//
;//** Library:      utilitylib                                               **//
;//** Created:      2003-02-09                                               **//
;//** Updated:      2003-02-09                                               **//
;//** Author(s):    Karl Churchill                                           **//
;//** Note(s):      Asm definitions for _LLBase class functions              **//
;//** Copyright:    (C)1996-2003, eXtropia Studios                           **//
;//**               Serkan YAZICI, Karl Churchill                            **//
;//**               All Rights Reserved.                                     **//
;//**                                                                        **//
;//****************************************************************************//

	mc68040

	XREF	copy__Mem__r8Pvr9Pvr0Ui
	XREF	free__Mem__Pv
	XREF	alloc__Mem__UisE

	XREF	_allocated__Mem
	XREF	_totalSize__Mem
	XREF	_nextFree__Mem
	XREF	_count__Mem
	XREF	_maxAllocs__Mem

	XREF	_linkCache___LLBase
	XREF	_linkCacheSize___LLBase
	XREF	_linkCacheDelta___LLBase
	XREF	_linkCount___LLBase
	XREF	_nextFree___LLBase
	XREF	createLink___LLBase_
	XREF	destroyLink___LLBase__j
	XREF	expandCache___LLBase_
	XREF	_0ct___LLBase__T
	XREF	_0dt___LLBase__T

	XREF	findFwrd___LLBase__TjPv
	XREF	findBkwd___LLBase__TjPv

Link_prev 	EQU 0
Link_next 	EQU 4
Link_nfree	EQU 8
Link_item	EQU 12

NULL_LINK	EQU -1

;///////////////////////////////////////////////////////////////////////////////
;//
;//  sint32 _LLBase::rem([d0] sint32 s, [d1] sint32 e)
;//
;///////////////////////////////////////////////////////////////////////////////

;///////////////////////////////////////////////////////////////////////////////
;//
;//  sint32 _LLBase::rem([d0] sint32 s, [d1] sint32 e, [a0] void* p)
;//
;///////////////////////////////////////////////////////////////////////////////


	SECTION "rem___LLBase__r0jr1jr8Pv:0",CODE
	XDEF	rem___LLBase__r0jr1jr8Pv
rem___LLBase__r0jr1jr8Pv

	tst.l		a0
	beq		remp_BadArgs

	cmp.l		d0,	d1
	bgt.b		remp_argsDone
	exg		d0,	d1

remp_argsDone:
	;// save used regs
	movem.l	d2/d3/d4/d5, -(a7)
	move.l	_linkCache___LLBase,	a1

	;// d0 = start
	;// d1 = end
	;// a0 = obj
	;// a1 = linkCache
	;// scale start by Link size

	lsl.l		#4,	d0

	move.l	Link_next(a1, d0.l), d2
	moveq		#0,	d3

	;// d2 = search = linkCache[start].next
	;// d3 = n = 0
	
remp_LoopTest:
	;// while (search != NULL_LINK && search != end)
	cmp.l	NULL_LINK,	d2
	beq.b	remp_LoopDone
	cmp.l	d1,	d2
	beq.l remp_LoopDone

	move.l	d2,	d0
	lsl.l		#4,	d0

	;// d0 = search<<4
	
	;// if (linkCache[d0].item == p)
	cmp.l		Link_item(a1,	d0.l),	a0
	bne.b		remp_LoopIterate
	
;// d4 = link[search].next
	move.l	Link_next(a1,	d0.l),	d4

;// d5 = link[search].prev
	move.l	Link_prev(a1,	d0.l),	d5


;// link[link[search].prev].next  = d4

;// link[d5<<4] = d4
	move.l	d5,	d0
	lsl.l		#4,	d0
	move.l	d4,	Link_next(a1,	d0.l)

;// link[link[search].next].prev	= link[search].prev

;// link[d4<<4] = d5
	move.l	d4,	d0
	lsl.l		#4,	d0
	move.l	d5,	Link_prev(a1,	d0.l)

;// destroyLink(search)

	;// this call will doubtless trash d0/d1/a0/a1
	;// so save into d4/d5 now that were done with them
	move.l	a0,	d4
	move.l	a1,	d5
	move.l	d1,	-(a7)	

	move.l	d2,	-(a7)
	jsr		destroyLink___LLBase__j
	addq.w	#4,	a7	

	;// restore our regs
	move.l	(a7)+,	d1
	move.l	d4,		a0
	move.l	d5,		a1
	
	
;// n++	
	addq.l	#1,	d3

remp_LoopIterate:
	;// search = linkCache[search].next
	lsl.l		#4,	d2
	move.l	Link_next(a1,	d2.l), d2	
	bra.b		remp_LoopTest

remp_LoopDone:
	;// put result in return
	move.l	d3,	d0

remp_Done:
	;// restore regs
	movem.l		(a7)+, d2/d3/d4/d5/a2
	rts

	;// return zero for bad args
remp_BadArgs:
	moveq	#0,	d0
	rts
	

;///////////////////////////////////////////////////////////////////////////////
;//
;//  sint32 _LLBase::cnt([d0] sint32 s, [d1] sint32 e, [a0] void* p)
;//
;///////////////////////////////////////////////////////////////////////////////


	SECTION "cnt___LLBase__r0jr1jr8Pv:0",CODE
	XDEF	cnt___LLBase__r0jr1jr8Pv
cnt___LLBase__r0jr1jr8Pv
	movem.l	d2/d3/a2,-(a7)
L154
;//	if (p && s!=e)
	cmp.w	#0,a0
	beq.b	L165
L155
	cmp.l	d1,d0
	beq.b	L165
L156
;//		if (s>e)
	cmp.l	d1,d0
	ble.b	L158
L157
;//			sint32 t = s;//
	move.l	d0,d2
;//			s = e;//
	move.l	d1,d0
;//			e = t
	move.l	d2,d1
L158
;//		register Link* link = linkCache;//
	move.l	_linkCache___LLBase,a1
;//		rsint32 search = link[s].next;//
	asl.l	#4,d0
	move.l	Link_next(a1,d0.l),d2
;//		rsint32 n = 0;//
	moveq	#0,d0
;//		while (search!=NULL_LINK && search!=e)
	bra.b	L162
L159
;//			if (link[search].item == p)
	move.l	d2,d3
	asl.l	#4,d3
	move.l	Link_item(a1,d3.l),a2
	cmp.l	a0,a2
	bne.b	L161
L160
;//				n++;//
	addq.l	#1,d0
L161
;//			search = link[search].next;//
	asl.l	#4,d2
	move.l	Link_next(a1,d2.l),d2
L162
	cmp.l	#-1,d2
	beq.b	L164
L163
	cmp.l	d1,d2
	bne.b	L159
L164
;//		return n;//
	movem.l	(a7)+,d2/d3/a2
	rts
L165
;//	return 0;//
	moveq	#0,d0
	movem.l	(a7)+,d2/d3/a2
	rts



;///////////////////////////////////////////////////////////////////////////////
;//
;//  sint32 _LLBase::rep([d0] sint32 s, [d1] sint32 e, [a0] void* p, [a1] void* r)
;//
;///////////////////////////////////////////////////////////////////////////////


	SECTION "rep___LLBase__r0jr1jr8Pvr9Pv:0",CODE
	XDEF	rep___LLBase__r0jr1jr8Pvr9Pv
rep___LLBase__r0jr1jr8Pvr9Pv
	movem.l	d2/d3/a2-a4,-(a7)
L166
;//	if (p && r && p!=r && s!=e)
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
;//		if (s>e)
	cmp.l	d1,d0
	ble.b	L172
L171
;//			sint32 t = s;//
	move.l	d0,d2
;//			s = e;//
	move.l	d1,d0
;//			e = t
	move.l	d2,d1
L172
;//		register Link* link = linkCache;//
	move.l	_linkCache___LLBase,a2
;//		rsint32 search = link[s].next;//
	asl.l	#4,d0
	move.l	Link_next(a2,d0.l),d2
;//		rsint32 n = 0;//
	moveq	#0,d0
;//		while (search!=NULL_LINK && search!=e)
	bra.b	L176
L173
;//			if (link[search].item == p)
	move.l	d2,d3
	asl.l	#4,d3
	move.l	Link_item(a2,d3.l),a3
	cmp.l	a0,a3
	bne.b	L175
L174
;//				linkCache[search].item = r;//
	move.l	d2,d3
	asl.l	#4,d3
	move.l	_linkCache___LLBase,a4
	move.l	a1,Link_item(a4,d3.l)
;//				n++;//
	addq.l	#1,d0
L175
;//			search = link[search].next;//
	asl.l	#4,d2
	move.l	Link_next(a2,d2.l),d2
L176
	cmp.l	#-1,d2
	beq.b	L178
L177
	cmp.l	d1,d2
	bne.b	L173
L178
;//		return n;//
	movem.l	(a7)+,d2/d3/a2-a4
	rts
L179
;//	return 0;//
	moveq	#0,d0
	movem.l	(a7)+,d2/d3/a2-a4
	rts

	END
