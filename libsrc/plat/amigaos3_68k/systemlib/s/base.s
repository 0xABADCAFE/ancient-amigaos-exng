
; Storm C Compiler
; EXNG:libsrc/plat/amigaos3_68k/systemlib/base.cpp
	mc68030
	mc68881
	XREF	runApplication__AppBase__T
	XREF	getSwitch__AppBase__PCcs
	XREF	done__Mem_
	XREF	init__Mem_
	XREF	_vsprintf
	XREF	_sprintf
	XREF	_printf
	XREF	_system
	XREF	_std__in
	XREF	_std__out
	XREF	_std__err
	XREF	_SysBase
	XREF	_allocated__Mem
	XREF	_volatileBuff__Mem
	XREF	_totalSize__Mem
	XREF	_nextFree__Mem
	XREF	_count__Mem
	XREF	_maxAllocs__Mem

	SECTION "getVolatile__Mem_:0",CODE

	rts

	SECTION "_IntuitionBase:1",DATA

	XDEF	_IntuitionBase
_IntuitionBase
	dc.l	0

	SECTION "_debug__SystemLib:1",DATA

	XDEF	_debug__SystemLib
_debug__SystemLib
	dc.w	0

	SECTION "init__SystemLib_:0",CODE


;sint32 SystemLib::init()
	XDEF	init__SystemLib_
init__SystemLib_
	move.l	a6,-(a7)
L17
;	debug = AppBase::getSwitch("-sysdebug", true);
	move.w	#1,-(a7)
	move.l	#L13,-(a7)
	jsr	getSwitch__AppBase__PCcs
	addq.w	#6,a7
	move.w	d0,_debug__SystemLib
;	if ( (::IntuitionBase = (struct IntuitionBase*)OpenLibrary("intuit
	move.l	_SysBase,a6
	moveq	#$27,d0
	move.l	#L14,a1
	jsr	-$228(a6)
	move.l	d0,_IntuitionBase
	tst.l	_IntuitionBase
	beq.b	L19
L18
;		X_INFO("SystemLib initialised");
	clr.l	-(a7)
	move.l	#L15,-(a7)
	jsr	printDebug__SystemLib__PCci
	addq.w	#$8,a7
;		return Mem::init();
	jsr	init__Mem_
	move.l	(a7)+,a6
	rts
L19
;emLib error : Fai
	pea	2.w
	move.l	#L16,-(a7)
	jsr	printDebug__SystemLib__PCci
	addq.w	#$8,a7
;		return ERR_RSC_UNAVAILABLE;
	move.l	#-$3050005,d0
	move.l	(a7)+,a6
	rts

L13
	dc.b	'-sysdebug',0
L16
	dc.b	'SystemLib error : Failed to open intuition library v39',0
L15
	dc.b	'SystemLib initialised',0
L14
	dc.b	'intuition.library',0

	SECTION "done__SystemLib_:0",CODE


;void SystemLib::done()
	XDEF	done__SystemLib_
done__SystemLib_
	move.l	a6,-(a7)
L21
;	Mem::done();
	jsr	done__Mem_
;	if (::IntuitionBase)
	tst.l	_IntuitionBase
	beq.b	L23
L22
;		CloseLibrary((Library*)::IntuitionBase);
	move.l	_IntuitionBase,a1
	move.l	_SysBase,a6
	jsr	-$19E(a6)
;		::IntuitionBase = 0;
	clr.l	_IntuitionBase
L23
;	X_INFO("SystemLib finalized");
	clr.l	-(a7)
	move.l	#L20,-(a7)
	jsr	printDebug__SystemLib__PCci
	addq.w	#$8,a7
	move.l	(a7)+,a6
	rts

L20
	dc.b	'SystemLib finalized',0

	SECTION "printDebug__SystemLib__PCci:0",CODE


;void SystemLib::printDebug(const char* text, int level)
	XDEF	printDebug__SystemLib__PCci
printDebug__SystemLib__PCci
	move.l	$8(a7),d0
	move.l	4(a7),a0
L28
;	if (debug)
	tst.w	_debug__SystemLib
	beq.b	L34
L29
;		switch (level)
	cmp.l	#1,d0
	beq.b	L31
	bgt.b	L35
	cmp.l	#0,d0
	beq.b	L30
	bra.b	L33
L35
	cmp.l	#2,d0
	beq.b	L32
	bra.b	L33
;			
L30
;			case X_DEBUG_INFO:	printf("[ Info    ] %s\n
	move.l	a0,-(a7)
	move.l	#L24,-(a7)
	jsr	_printf
	addq.w	#$8,a7
;	
	bra.b	L34
L31
;			case X_DEBUG_WARN:	printf("[ Warning ] %s\n
	move.l	a0,-(a7)
	move.l	#L25,-(a7)
	jsr	_printf
	addq.w	#$8,a7
;	
	bra.b	L34
L32
;			case X_DEBUG_ERROR:	printf("[ Error   ] %s
	move.l	a0,-(a7)
	move.l	#L26,-(a7)
	jsr	_printf
	addq.w	#$8,a7
;	
	bra.b	L34
L33
;			default:						printf("[ <Other> ] %s\n", text);
	move.l	a0,-(a7)
	move.l	#L27,-(a7)
	jsr	_printf
	addq.w	#$8,a7
;	
L34
	rts

L27
	dc.b	'[ <Other> ] %s',$A,0
L26
	dc.b	'[ Error   ] %s',$A,0
L24
	dc.b	'[ Info    ] %s',$A,0
L25
	dc.b	'[ Warning ] %s',$A,0

	SECTION "dialogueBox__SystemLib__PCcPCcPCce:0",CODE


;sint32 SystemLib::dialogueBox(const char* title, const char* opts, c
	XDEF	dialogueBox__SystemLib__PCcPCcPCce
dialogueBox__SystemLib__PCcPCcPCce
L37	EQU	-$1C
	link	a5,#L37
	movem.l	d2/a2/a3/a6,-(a7)
	move.l	$C(a5),a3
	move.l	$8(a5),a6
L36
;	char* textBuff = (char*)Mem::getVolatile();
	move.l	_volatileBuff__Mem,a2
;	va_start(argList, body)
	lea	$10(a5),a0
	move.l	a0,d2
	addq.l	#4,d2
;	vsprintf(textBuff, body, argList);
	move.l	d2,-(a7)
	move.l	$10(a5),-(a7)
	move.l	a2,-(a7)
	jsr	_vsprintf
	add.w	#$C,a7
;	EasyStruct easy = { sizeof(EasyStruct), 0, (char*)title
	lea	-$1C(a5),a0
	move.l	#$14,(a0)+
	clr.l	(a0)+
	move.l	a6,(a0)+
	move.l	a2,(a0)+
	move.l	a3,(a0)
;	return EasyRequest(0, &easy, 0, argList);
	move.l	d2,-(a7)
	move.l	_IntuitionBase,a6
	sub.l	a0,a0
	lea	-$1C(a5),a1
	sub.l	a2,a2
	move.l	a7,a3
	jsr	-$24C(a6)
	addq.w	#4,a7
	movem.l	(a7)+,d2/a2/a3/a6
	unlk	a5
	rts

	SECTION "openDebugFile__SystemLib__PCc:0",CODE


;void SystemLib::openDebugFile(const char *name)
	XDEF	openDebugFile__SystemLib__PCc
openDebugFile__SystemLib__PCc
	move.l	a2,-(a7)
	move.l	$8(a7),a0
L40
;	char* textBuff = (char*)Mem::getVolatile();
	move.l	_volatileBuff__Mem,a2
;	sprintf(textBuff,"Run >NIL: %s \"%s\" ", FILE_VIEWER_APP, name);
	move.l	a0,-(a7)
	move.l	#L38,-(a7)
	move.l	#L39,-(a7)
	move.l	a2,-(a7)
	jsr	_sprintf
	add.w	#$10,a7
;	openExternalProgram(textBuff);
	pea	(a2)
	jsr	_system
	addq.w	#4,a7
	move.l	(a7)+,a2
	rts

L38
	dc.b	'Multiview',0
L39
	dc.b	'Run >NIL: %s ',$22,'%s',$22,' ',0

	END
