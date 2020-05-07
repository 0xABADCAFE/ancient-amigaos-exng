
; Storm C Compiler
; exng:libsrc/plat/amigaos3_68k/gfxlib/dispinput.cpp
	mc68030
	mc68881
	XREF	close__InteractiveScreenBuffered__T
	XREF	reopen__InteractiveScreenBuffered__T
	XREF	open__InteractiveScreenBuffered__TP17DisplayPropertiesPCc
	XREF	open__InteractiveScreenBuffered__TssEPCc
	XREF	close__InteractiveScreen__T
	XREF	reopen__InteractiveScreen__T
	XREF	open__InteractiveScreen__TP17DisplayPropertiesPCc
	XREF	open__InteractiveScreen__TssEPCc
	XREF	close__InteractiveWindow__T
	XREF	reopen__InteractiveWindow__T
	XREF	open__InteractiveWindow__TP17DisplayPropertiesPCc
	XREF	open__InteractiveWindow__TssEPCc
	XREF	_0dt__NativeInput__T
	XREF	_0ct__NativeInput__T
	XREF	inputQueued__InputDispatcher__T
	XREF	handleEvent__InputDispatcher__T
	XREF	waitEvent__InputDispatcher__T
	XREF	applyFilter__InputDispatcher__T
	XREF	discardQueue__InputDispatcher__T
	XREF	dispatchExit__InputDispatcher__T
	XREF	dispatchMouseKey__InputDispatcher__TUjs
	XREF	dispatchMove__InputDispatcher__Tssssss
	XREF	dispatchKeyPrintable__InputDispatcher__Tjs
	XREF	dispatchKey__InputDispatcher__TEs
	XREF	setIFilter__IFilter__TUj
	XREF	toggleIFilter__IFilter__TUj
	XREF	disableIFilter__IFilter__TUj
	XREF	enableIFilter__IFilter__TUj
	XREF	_0dt___LLBase__T
	XREF	_0ct___LLBase__T
	XREF	contains___LLBase__TPv
	XREF	repLast___LLBase__TPvPv
	XREF	repFirst___LLBase__TPvPv
	XREF	remLast___LLBase__TPv
	XREF	remFirst___LLBase__TPv
	XREF	remCurr___LLBase__T
	XREF	remFirst___LLBase__T
	XREF	remLast___LLBase__T
	XREF	insCurr___LLBase__TPv
	XREF	insFirst___LLBase__TPv
	XREF	insLast___LLBase__TPv
	XREF	rep___LLBase__r0jr1jr8Pvr9Pv
	XREF	cnt___LLBase__r0jr1jr8Pv
	XREF	rem___LLBase__r0jr1jr8Pv
	XREF	rem___LLBase__r0jr1j
	XREF	findBkwd___LLBase__TjPv
	XREF	findFwrd___LLBase__TjPv
	XREF	getValue__Key64__TPCc
	XREF	getValue__Key32__TPCc
	XREF	getDrawSurface__Display__T
	XREF	setTitle__Display__TPCc
	XREF	refresh__Display__Tssss
	XREF	refresh__Display__T
	XREF	waitSync__Display__T
	XREF	close__Display__T
	XREF	reopen__Display__T
	XREF	open__Display__TP17DisplayPropertiesPCc
	XREF	open__Display__TssEPCc
	XREF	_0dt__NativeScreenDB__T
	XREF	_0ct__NativeScreenDB__T
	XREF	refresh__NativeScreenDB__T
	XREF	close__NativeScreenDB__T
	XREF	reopen__NativeScreenDB__T
	XREF	open__NativeScreenDB__TP17DisplayPropertiesPCc
	XREF	open__NativeScreenDB__TssEPCc
	XREF	_0dt__NativeScreen__T
	XREF	_0ct__NativeScreen__T
	XREF	close__NativeScreen__T
	XREF	reopen__NativeScreen__T
	XREF	open__NativeScreen__TP17DisplayPropertiesPCc
	XREF	open__NativeScreen__TssEPCc
	XREF	_0dt__NativeWindow__T
	XREF	_0ct__NativeWindow__T
	XREF	refresh__NativeWindow__Tssss
	XREF	refresh__NativeWindow__T
	XREF	close__NativeWindow__T
	XREF	open__NativeWindow__TP17DisplayPropertiesPCc
	XREF	open__NativeWindow__TssEPCc
	XREF	reopen__NativeWindow__T
	XREF	_0ct__DisplayNative__T
	XREF	setDisplayTitle__DisplayNative__TPCcs
	XREF	waitForRefresh__DisplayNative__T
	XREF	blitCopy__Surface__P07SurfacessP07Surfacessss
	XREF	destroy__Surface__T
	XREF	init__Surface__T
	XREF	getHardwareFormat__Native2D__E
	XREF	findIndex__DisplayPropertiesProvider__ssEs
	XREF	getMode__DisplayPropertiesProvider__Ui
	XREF	destroy__ImageBuffer__T
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
	XREF	_propTab__PixelDescriptor
	XREF	_modesAvail__DisplayPropertiesProvider
	XREF	_numModes__DisplayPropertiesProvider
	XREF	_GfxBase
	XREF	_CyberGfxBase
	XREF	_pixelType__Native2D
	XREF	_convTab__Native2D
	XREF	_modeID__DisplayNative
	XREF	_linkCache___LLBase
	XREF	_linkCacheSize___LLBase
	XREF	_linkCacheDelta___LLBase
	XREF	_linkCount___LLBase
	XREF	_nextFree___LLBase
	XREF	_openCount__NativeInput
	XREF	_nonPrintMap__NativeInput
	XREF	_KeymapBase
	XREF	_DOSBase

	SECTION "getVolatile__Mem_:0",CODE

	rts

	SECTION "_redBalance__Colour:1",DATA

_redBalance__Colour
	dc.w	$4D

	SECTION "_greenBalance__Colour:1",DATA

_greenBalance__Colour
	dc.w	$96

	SECTION "_blueBalance__Colour:1",DATA

_blueBalance__Colour
	dc.w	$1C

	SECTION "mapChar__InteractiveDisplay__P12IntuiMessage:0",CODE


;sint32	InteractiveDisplay::mapChar(IntuiMessage* m)
	XDEF	mapChar__InteractiveDisplay__P12IntuiMessage
mapChar__InteractiveDisplay__P12IntuiMessage
L81	EQU	-$18
	link	a5,#L81
	movem.l	a2/a6,-(a7)
	move.l	$8(a5),a1
L77
;	if (!m || ((m->Code & 0x7F) > 0x40))
	cmp.w	#0,a1
	beq.b	L79
L78
	moveq	#0,d0
	move.w	$18(a1),d0
	and.l	#$7F,d0
	cmp.l	#$40,d0
	ble.b	L80
L79
;		return 0;
	moveq	#0,d0
	movem.l	(a7)+,a2/a6
	unlk	a5
	rts
L80
;		InputEvent	inputEvent = {
	lea	-$16(a5),a0
	clr.l	(a0)+
	move.b	#1,(a0)+
	clr.b	(a0)+
	move.w	$18(a1),(a0)+
	move.w	$1A(a1),(a0)+
	clr.l	(a0)+
	clr.l	(a0)+
	clr.l	(a0)+
;		inputEvent.ie_EventAddress = *((uint8**)(m->IAddress));
	move.l	$1C(a1),a0
	move.l	(a0),-$C(a5)
;		char mapped[2] = "";
	move.l	#L76,a1
	lea	-$18(a5),a0
	move.b	(a1),(a0)
;		MapRawKey(&inputEvent, mapped, 2, 0);
	move.l	_KeymapBase,a6
	moveq	#2,d1
	lea	-$16(a5),a0
	lea	-$18(a5),a1
	sub.l	a2,a2
	jsr	-$2A(a6)
;		return (sint32)mapped[0];
	move.b	-$18(a5),d0
	extb.l	d0
	movem.l	(a7)+,a2/a6
	unlk	a5
	rts

L76
	dc.b	0

	SECTION "applyFilter__InteractiveDisplay__T:0",CODE


;void InteractiveDisplay::applyFilter()
	XDEF	applyFilter__InteractiveDisplay__T
applyFilter__InteractiveDisplay__T
	movem.l	d2/d3/a2/a6,-(a7)
	move.l	$14(a7),a2
L82
;	if (DisplayNative::win)
	move.l	a2,a0
	cmp.w	#0,a0
	beq.b	L84
L83
	move.l	$20(a0),a0
L84
	tst.l	4(a0)
	beq	L104
L85
;		uint32 r = getDispatchFilter();
	move.l	a2,a0
	cmp.w	#0,a0
	beq.b	L87
L86
	addq.w	#4,a0
L87
	move.l	(a0),d1
;		uint32 IDCMPflags = 0;
	moveq	#0,d0
;		IDCMPflags |= (r & IFilter::IKEYEVENTS)	? IDCMP_RAWKEY : 0;
	move.l	d1,d2
	and.l	#$F,d2
	beq.b	L89
L88
	move.l	#$400,d2
	bra.b	L90
L89
	moveq	#0,d2
L90
	or.l	d2,d0
;		IDCMPflags |= (r & (IFilter::IMOUSEKEYS|IFilter::IMOUSEDRAG))	? 
	move.l	d1,d2
	and.l	#$4770,d2
	beq.b	L92
L91
	moveq	#$8,d2
	bra.b	L93
L92
	moveq	#0,d2
L93
	or.l	d2,d0
;		IDCMPflags |= (r & (IFilter::IMOUSEMOVE|IFilter::IMOUSEDRAG))	? 
	move.l	d1,d2
	and.l	#$6000,d2
	beq.b	L95
L94
	moveq	#$10,d2
	bra.b	L96
L95
	moveq	#0,d2
L96
	or.l	d2,d0
;		IDCMPflags |= (r & IFilter::ICLOSE) ? IDCMP_CLOSEWINDOW : 0;
	and.l	#$80000000,d1
	beq.b	L98
L97
	move.l	#$200,d1
	bra.b	L99
L98
	moveq	#0,d1
L99
	or.l	d1,d0
;		ModifyIDCMP(DisplayNative::win, IDCMPflags);
	move.l	a2,a0
	cmp.w	#0,a0
	beq.b	L101
L100
	move.l	$20(a0),a0
L101
	move.l	_IntuitionBase,a6
	move.l	4(a0),a0
	jsr	-$96(a6)
;		SetMouseQueue(DisplayNative::win, 8);
	move.l	a2,a0
	cmp.w	#0,a0
	beq.b	L103
L102
	move.l	a2,a0
	move.l	$20(a0),a2
L103
	move.l	a2,a1
	move.l	_IntuitionBase,a6
	moveq	#$8,d0
	move.l	4(a1),a0
	jsr	-$1F2(a6)
L104
	movem.l	(a7)+,d2/d3/a2/a6
	rts

	SECTION "waitEvent__InteractiveDisplay__T:0",CODE


;bool	InteractiveDisplay::waitEvent()
	XDEF	waitEvent__InteractiveDisplay__T
waitEvent__InteractiveDisplay__T
	movem.l	d2/a6,-(a7)
	move.l	$C(a7),a0
L105
;	uint32 eventSignal = 1UL<<DisplayNative::win->UserPort->mp_SigBit;
	cmp.w	#0,a0
	beq.b	L107
L106
	move.l	$20(a0),a0
L107
	move.l	4(a0),a0
	move.l	$56(a0),a0
	moveq	#0,d0
	move.b	$F(a0),d0
	moveq	#1,d2
	asl.l	d0,d2
;	if ((Wait(eventSignal|SIGBREAKF_CTRL_C) & eventSignal)!=0)
	move.l	d2,d0
	or.l	#$1000,d0
	move.l	_SysBase,a6
	jsr	-$13E(a6)
	and.l	d2,d0
	beq.b	L109
L108
;		return true;
	moveq	#1,d0
	movem.l	(a7)+,d2/a6
	rts
L109
;	return false;
	moveq	#0,d0
	movem.l	(a7)+,d2/a6
	rts

	SECTION "handleEvent__InteractiveDisplay__T:0",CODE


;bool	InteractiveDisplay::handleEvent()
	XDEF	handleEvent__InteractiveDisplay__T
handleEvent__InteractiveDisplay__T
	movem.l	d2/d3/a2/a6,-(a7)
	move.l	$14(a7),a2
L110
;	IntuiMessage* msg = (IntuiMessage*)GetMsg(DisplayNativ
	move.l	a2,a0
	cmp.w	#0,a0
	beq.b	L112
L111
	move.l	$20(a0),a0
L112
	move.l	4(a0),a0
	move.l	_SysBase,a6
	move.l	$56(a0),a0
	jsr	-$174(a6)
	move.l	d0,a6
;	if (msg)
	cmp.w	#0,a6
	beq	L158
L113
;		switch (msg->Class)
	move.l	$14(a6),d0
	cmp.l	#$200,d0
	beq	L153
	bhi.b	L159
	cmp.l	#$8,d0
	beq	L122
	cmp.l	#$10,d0
	beq	L142
	bra	L156
L159
	cmp.l	#$400,d0
	beq.b	L114
	bra	L156
;			
L114
;				sint32 ch = mapChar(msg);
	move.l	a6,-(a7)
	jsr	mapChar__InteractiveDisplay__P12IntuiMessage
	addq.w	#4,a7
;				if (ch)
	tst.l	d0
	beq.b	L118
L115
;					dispatchKeyPrintable(ch, ((msg->Code & 0x80UL)==0));
	moveq	#0,d1
	move.w	$18(a6),d1
	and.l	#$80,d1
	seq	d1
	and.l	#1,d1
	move.w	d1,-(a7)
	move.l	d0,-(a7)
	move.l	a2,a0
	cmp.w	#0,a0
	beq.b	L117
L116
	moveq	#4,d0
	add.l	a2,d0
	move.l	d0,a2
L117
	move.l	a2,-(a7)
	jsr	dispatchKeyPrintable__InputDispatcher__Tjs
	add.w	#$A,a7
	bra.b	L121
L118
;					dispatchKey(getNPCode(msg->Code & 0x7FUL), ((msg->Code & 0
	moveq	#0,d0
	move.w	$18(a6),d0
	and.l	#$80,d0
	seq	d0
	and.l	#1,d0
	move.w	d0,-(a7)
	moveq	#0,d0
	move.w	$18(a6),d0
	and.l	#$7F,d0
	and.l	#$FF,d0
	and.l	#$7F,d0
	move.l	#_nonPrintMap__NativeInput,a1
	move.b	0(a1,d0.l),d0
	and.l	#$FF,d0
	move.l	d0,-(a7)
	move.l	a2,a0
	cmp.w	#0,a0
	beq.b	L120
L119
	moveq	#4,d0
	add.l	a2,d0
	move.l	d0,a2
L120
	move.l	a2,-(a7)
	jsr	dispatchKey__InputDispatcher__TEs
	add.w	#$A,a7
L121
; 
	bra	L157
L122
;				switch(msg->Code)
	move.w	$18(a6),d0
	cmp.w	#$E8,d0
	beq	L132
	bhi.b	L160
	cmp.w	#$69,d0
	beq.b	L129
	bhi.b	L161
	cmp.w	#$68,d0
	beq.b	L123
	bra	L141
L161
	cmp.w	#$6A,d0
	beq.b	L126
	bra	L141
L160
	cmp.w	#$E9,d0
	beq	L138
	cmp.w	#$EA,d0
	beq	L135
	bra	L141
;					
L123
;					case SELECTDOWN:	dispatchMouseKey(Mouse::
	move.w	#1,-(a7)
	pea	1.w
	move.l	a2,a0
	cmp.w	#0,a0
	beq.b	L125
L124
	moveq	#4,d0
	add.l	a2,d0
	move.l	d0,a2
L125
	move.l	a2,-(a7)
	jsr	dispatchMouseKey__InputDispatcher__TUjs
	add.w	#$A,a7
;			
	bra	L141
L126
;					case MIDDLEDOWN:	dispatchMouseKey(Mouse::
	move.w	#1,-(a7)
	pea	2.w
	move.l	a2,a0
	cmp.w	#0,a0
	beq.b	L128
L127
	moveq	#4,d0
	add.l	a2,d0
	move.l	d0,a2
L128
	move.l	a2,-(a7)
	jsr	dispatchMouseKey__InputDispatcher__TUjs
	add.w	#$A,a7
;		
	bra	L141
L129
;					case MENUDOWN:		dispatchMouseKey(Mouse::KE
	move.w	#1,-(a7)
	pea	4.w
	move.l	a2,a0
	cmp.w	#0,a0
	beq.b	L131
L130
	moveq	#4,d0
	add.l	a2,d0
	move.l	d0,a2
L131
	move.l	a2,-(a7)
	jsr	dispatchMouseKey__InputDispatcher__TUjs
	add.w	#$A,a7
;		
	bra.b	L141
L132
;					case SELECTUP:		dispatchMouseKey(Mouse::KE
	clr.w	-(a7)
	pea	1.w
	move.l	a2,a0
	cmp.w	#0,a0
	beq.b	L134
L133
	moveq	#4,d0
	add.l	a2,d0
	move.l	d0,a2
L134
	move.l	a2,-(a7)
	jsr	dispatchMouseKey__InputDispatcher__TUjs
	add.w	#$A,a7
;		
	bra.b	L141
L135
;					case MIDDLEUP:		dispatchMouseKey(Mouse::KE
	clr.w	-(a7)
	pea	2.w
	move.l	a2,a0
	cmp.w	#0,a0
	beq.b	L137
L136
	moveq	#4,d0
	add.l	a2,d0
	move.l	d0,a2
L137
	move.l	a2,-(a7)
	jsr	dispatchMouseKey__InputDispatcher__TUjs
	add.w	#$A,a7
;	
	bra.b	L141
L138
;					case MENUUP:			dispatchMouseKey(Mouse::KEYR
	clr.w	-(a7)
	pea	4.w
	move.l	a2,a0
	cmp.w	#0,a0
	beq.b	L140
L139
	moveq	#4,d0
	add.l	a2,d0
	move.l	d0,a2
L140
	move.l	a2,-(a7)
	jsr	dispatchMouseKey__InputDispatcher__TUjs
	add.w	#$A,a7
;		
L141
; 
	bra	L157
L142
;				sint16	mouseX	= msg->MouseX-(DisplayNative::win->BorderLeft);
	move.w	$20(a6),d0
	ext.l	d0
	move.l	a2,a0
	cmp.w	#0,a0
	beq.b	L144
L143
	move.l	$20(a0),a0
L144
	move.l	4(a0),a0
	move.b	$36(a0),d1
	extb.l	d1
	sub.l	d1,d0
	move.w	d0,d2
;				sint16	mouseY	= msg->MouseY-(DisplayNative::win->BorderTop);
	move.w	$22(a6),d0
	ext.l	d0
	move.l	a2,a0
	cmp.w	#0,a0
	beq.b	L146
L145
	move.l	$20(a0),a0
L146
	move.l	4(a0),a0
	move.b	$37(a0),d1
	extb.l	d1
	sub.l	d1,d0
	move.w	d0,d1
;				dispatchMove(mouseX, 0, DisplayNative::width-1, mouseY, 0, D
	move.l	a2,a0
	cmp.w	#0,a0
	beq.b	L148
L147
	move.l	$20(a0),a0
L148
	move.w	$A(a0),d0
	ext.l	d0
	subq.l	#1,d0
	move.w	d0,-(a7)
	clr.w	-(a7)
	move.w	d1,-(a7)
	move.l	a2,a0
	cmp.w	#0,a0
	beq.b	L150
L149
	move.l	$20(a0),a0
L150
	move.w	$8(a0),d0
	ext.l	d0
	subq.l	#1,d0
	move.w	d0,-(a7)
	clr.w	-(a7)
	move.w	d2,-(a7)
	move.l	a2,a0
	cmp.w	#0,a0
	beq.b	L152
L151
	moveq	#4,d0
	add.l	a2,d0
	move.l	d0,a2
L152
	move.l	a2,-(a7)
	jsr	dispatchMove__InputDispatcher__Tssssss
	add.w	#$10,a7
;	
	bra.b	L157
L153
;				dispatchExit();
	move.l	a2,a0
	cmp.w	#0,a0
	beq.b	L155
L154
	moveq	#4,d0
	add.l	a2,d0
	move.l	d0,a2
L155
	move.l	a2,-(a7)
	jsr	dispatchExit__InputDispatcher__T
	addq.w	#4,a7
;				
L156
;				
L157
;		ReplyMsg((Message*)msg);
	move.l	a6,a1
	move.l	_SysBase,a6
	jsr	-$17A(a6)
;		return true;
	moveq	#1,d0
	movem.l	(a7)+,d2/d3/a2/a6
	rts
L158
;	return false;
	moveq	#0,d0
	movem.l	(a7)+,d2/d3/a2/a6
	rts

	SECTION "discardQueue__InteractiveDisplay__T:0",CODE


;void	InteractiveDisplay::discardQueue()
	XDEF	discardQueue__InteractiveDisplay__T
discardQueue__InteractiveDisplay__T
	movem.l	a2/a6,-(a7)
	move.l	$C(a7),a2
L162
;	if (DisplayNative::win)
	move.l	a2,a0
	cmp.w	#0,a0
	beq.b	L164
L163
	move.l	$20(a0),a0
L164
	tst.l	4(a0)
	beq.b	L170
L165
;		Message* dummy = 0;
;		while(dummy = GetMsg(DisplayNative::win->UserPort))
	bra.b	L167
L166
;			ReplyMsg(dummy);
	move.l	_SysBase,a6
	jsr	-$17A(a6)
L167
	move.l	a2,a0
	cmp.w	#0,a0
	beq.b	L169
L168
	move.l	$20(a0),a0
L169
	move.l	4(a0),a0
	move.l	_SysBase,a6
	move.l	$56(a0),a0
	jsr	-$174(a6)
	move.l	d0,a1
	cmp.w	#0,a1
	bne.b	L166
L170
	movem.l	(a7)+,a2/a6
	rts

	SECTION "inputQueued__InteractiveDisplay__T:0",CODE


;bool	InteractiveDisplay::inputQueued()
	XDEF	inputQueued__InteractiveDisplay__T
inputQueued__InteractiveDisplay__T
L171
;	return false;
	moveq	#0,d0
	rts

	END
