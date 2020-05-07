
; Storm C Compiler
; EXNG:libsrc/common/xbase.cpp
	mc68030
	mc68881
	XREF	_strcmp
	XREF	_stricmp
	XREF	runApplication__AppBase__T
	XREF	destroyApplicationInstance__AppBase__P07AppBase
	XREF	createApplicationInstance__AppBase_
	XREF	done__AppBase_
	XREF	init__AppBase_
	XREF	printDebug__SystemLib__PCci
	XREF	done__SystemLib_
	XREF	init__SystemLib_
	XREF	_system
	XREF	_atol
	XREF	_atof__r
	XREF	op__delete__PvUi
	XREF	op__new__Ui
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

	SECTION "_numStartArgs__StartupLib:1",DATA

	XDEF	_numStartArgs__StartupLib
_numStartArgs__StartupLib
	dc.l	0

	SECTION "_startArgs__StartupLib:1",DATA

	XDEF	_startArgs__StartupLib
_startArgs__StartupLib
	dc.l	0

	SECTION "init__StartupLib__iPPc:0",CODE


;sint32 StartupLib::init(int argc, char** argv)
	XDEF	init__StartupLib__iPPc
init__StartupLib__iPPc
	movem.l	d2/a2/a3,-(a7)
	movem.l	$10(a7),d2/a2
L44
;	numStartArgs = argc;
	move.l	d2,_numStartArgs__StartupLib
;	startArgs = new char* [argc];
	move.l	d2,d0
	moveq	#2,d1
	asl.l	d1,d0
	move.l	d0,-(a7)
	jsr	op__new__Ui
	addq.w	#4,a7
	move.l	d0,_startArgs__StartupLib
;	if (!startArgs)
	tst.l	_startArgs__StartupLib
	bne.b	L46
L45
;		return ERR_NO_FREE_STORE;
	move.l	#-$3030001,d0
	movem.l	(a7)+,d2/a2/a3
	rts
L46
;	for (sint32 i=0;
	moveq	#0,d0
	bra.b	L48
L47
;		startArgs[i] = argv[i];
	move.l	_startArgs__StartupLib,a3
	move.l	0(a2,d0.l*4),0(a3,d0.l*4)
	addq.l	#1,d0
L48
	cmp.l	d2,d0
	blt.b	L47
L49
;	return SystemLib::init();
	jsr	init__SystemLib_
	movem.l	(a7)+,d2/a2/a3
	rts

	SECTION "runApplication__StartupLib_:0",CODE


;sint32 StartupLib::runApplication()
	XDEF	runApplication__StartupLib_
runApplication__StartupLib_
	movem.l	d2/a2,-(a7)
L53
;	sint32 ret = AppBase::init();
	jsr	init__AppBase_
	move.l	d0,d2
;	if (ret==OK)
	bne	L61
L54
;		AppBase *app = AppBase::createApplicationInstance();
	jsr	createApplicationInstance__AppBase_
	move.l	d0,a2
;		if (app)
	cmp.w	#0,a2
	beq.b	L59
L55
;			ret = app->initApplication();
	move.l	(a2),a0
	move.l	a2,d0
	add.l	$24(a0),d0
	move.l	d0,-(a7)
	move.l	$20(a0),a0
	jsr	(a0)
	addq.w	#4,a7
	move.l	d0,d2
;			if (ret==OK)
	bne.b	L57
L56
;				ret = app->runApplication();
	move.l	(a2),a0
	move.l	a2,d0
	add.l	$14(a0),d0
	move.l	d0,-(a7)
	move.l	$10(a0),a0
	jsr	(a0)
	addq.w	#4,a7
	move.l	d0,d2
	bra.b	L58
L57
;				X_ERROR("Applicat
	pea	2.w
	move.l	#L50,-(a7)
	jsr	printDebug__SystemLib__PCci
	addq.w	#$8,a7
L58
;			app->doneApplication();
	move.l	(a2),a0
	move.l	a2,d0
	add.l	$1C(a0),d0
	move.l	d0,-(a7)
	move.l	$18(a0),a0
	jsr	(a0)
	addq.w	#4,a7
;			AppBase::destroyApplicationInstance(app);
	move.l	a2,-(a7)
	jsr	destroyApplicationInstance__AppBase__P07AppBase
	addq.w	#4,a7
	bra.b	L60
L59
;			X_ERROR("Unable to creat
	pea	2.w
	move.l	#L51,-(a7)
	jsr	printDebug__SystemLib__PCci
	addq.w	#$8,a7
L60
	bra.b	L62
L61
;		X_ERROR("Library initiali
	pea	2.w
	move.l	#L52,-(a7)
	jsr	printDebug__SystemLib__PCci
	addq.w	#$8,a7
L62
;	AppBase::done();
	jsr	done__AppBase_
;	return ret;
	move.l	d2,d0
	movem.l	(a7)+,d2/a2
	rts

L50
	dc.b	'Application initialisation failed',0
L52
	dc.b	'Library initialisation failed',0
L51
	dc.b	'Unable to create application',0

	SECTION "done__StartupLib_:0",CODE


;void StartupLib::done()
	XDEF	done__StartupLib_
done__StartupLib_
L63
;	SystemLib::done();
	jsr	done__SystemLib_
;	if (startArgs)
	tst.l	_startArgs__StartupLib
	beq.b	L66
L64
;		delete startArgs;
	move.l	_startArgs__StartupLib,a0
	move.l	_startArgs__StartupLib,a1
	cmp.w	#0,a1
	beq.b	L66
L65
	pea	4.w
	move.l	a0,-(a7)
	jsr	op__delete__PvUi
	addq.w	#$8,a7
L66
;	startArgs = 0;
	clr.l	_startArgs__StartupLib
	rts

	SECTION "numArgs__AppBase_:0",CODE


;sint32 AppBase::numArgs() const
	XDEF	numArgs__AppBase_
numArgs__AppBase_
L67
;	return StartupLib::numStartArgs;
	move.l	_numStartArgs__StartupLib,d0
	rts

	SECTION "getArg__AppBase__j:0",CODE


;const char* AppBase::getArg(sint32 n) const
	XDEF	getArg__AppBase__j
getArg__AppBase__j
	move.l	4(a7),d0
L68
;	if (n<0 || n>=StartupLib::numStartArgs)
	tst.l	d0
	bmi.b	L70
L69
	cmp.l	_numStartArgs__StartupLib,d0
	blt.b	L71
L70
;		return 0;
	moveq	#0,d0
	rts
L71
;	return StartupLib::startArgs[n];
	move.l	_startArgs__StartupLib,a1
	move.l	0(a1,d0.l*4),d0
	rts

	SECTION "getString__AppBase__PCcs:0",CODE


;const char* AppBase::getString(const char* paramName, bool matchCase)
	XDEF	getString__AppBase__PCcs
getString__AppBase__PCcs
	movem.l	d2/a2,-(a7)
	move.w	$10(a7),d0
	move.l	$C(a7),a2
L72
;	if (StartupLib::numStartArgs<2)
	move.l	_numStartArgs__StartupLib,d1
	cmp.l	#2,d1
	bge.b	L74
L73
;		return 0;
	moveq	#0,d0
	movem.l	(a7)+,d2/a2
	rts
L74
;	if (matchCase)
	tst.w	d0
	beq.b	L82
L75
;		for (int i = 0;
	moveq	#0,d2
	bra.b	L80
L76
;			if (strcmp(StartupLib::startArgs[i], paramName) == 0)
	move.l	a2,-(a7)
	move.l	_startArgs__StartupLib,a1
	move.l	0(a1,d2.l*4),-(a7)
	jsr	_strcmp
	addq.w	#$8,a7
	tst.l	d0
	bne.b	L79
L77
;				if (++i<StartupLib::numStartArgs)
	addq.l	#1,d2
	cmp.l	_numStartArgs__StartupLib,d2
	bge.b	L79
L78
;					return StartupLib::startArgs[i];
	move.l	_startArgs__StartupLib,a1
	move.l	0(a1,d2.l*4),d0
	movem.l	(a7)+,d2/a2
	rts
L79
	addq.l	#1,d2
L80
	cmp.l	_numStartArgs__StartupLib,d2
	blt.b	L76
L81
	bra.b	L88
L82
;		for (int i = 0;
	moveq	#0,d2
	bra.b	L87
L83
;			if (stricmp(StartupLib::startArgs[i], paramName) == 0)
	move.l	a2,-(a7)
	move.l	_startArgs__StartupLib,a1
	move.l	0(a1,d2.l*4),-(a7)
	jsr	_stricmp
	addq.w	#$8,a7
	tst.l	d0
	bne.b	L86
L84
;				if (++i<StartupLib::numStartArgs)
	addq.l	#1,d2
	cmp.l	_numStartArgs__StartupLib,d2
	bge.b	L86
L85
;					return StartupLib::startArgs[i];
	move.l	_startArgs__StartupLib,a1
	move.l	0(a1,d2.l*4),d0
	movem.l	(a7)+,d2/a2
	rts
L86
	addq.l	#1,d2
L87
	cmp.l	_numStartArgs__StartupLib,d2
	blt.b	L83
L88
;	return 0;
	moveq	#0,d0
	movem.l	(a7)+,d2/a2
	rts

	SECTION "getInteger__AppBase__PCcs:0",CODE


;sint32 AppBase::getInteger(const char* paramName, bool matchCase) co
	XDEF	getInteger__AppBase__PCcs
getInteger__AppBase__PCcs
	move.w	$8(a7),d0
	move.l	4(a7),a0
L89
;	const char* p = getString(paramName, matchCase);
	move.w	d0,-(a7)
	move.l	a0,-(a7)
	jsr	getString__AppBase__PCcs
	addq.w	#6,a7
	move.l	d0,a0
;	if (p)
	cmp.w	#0,a0
	beq.b	L91
L90
;		return atol(p);
	move.l	a0,-(a7)
	jsr	_atol
	addq.w	#4,a7
	rts
L91
;	return 0;
	moveq	#0,d0
	rts

	SECTION "getFloat__AppBase___r_PCcs:0",CODE


;float64 AppBase::getFloat(const char* paramName, bool matchCase) con
	XDEF	getFloat__AppBase___r_PCcs
getFloat__AppBase___r_PCcs
	move.w	$8(a7),d0
	move.l	4(a7),a0
L92
;	const char* p = getString(paramName, matchCase);
	move.w	d0,-(a7)
	move.l	a0,-(a7)
	jsr	getString__AppBase__PCcs
	addq.w	#6,a7
	move.l	d0,a0
;	if (p)
	cmp.w	#0,a0
	beq.b	L94
L93
;		return atof(p);
	move.l	a0,-(a7)
	jsr	_atof__r
	addq.w	#4,a7
	rts
L94
;	return 0.0;
	fmove.d	#$.00000000.00000000,fp0
	rts

	SECTION "getSwitch__AppBase__PCcs:0",CODE


;bool AppBase::getSwitch(const char* paramName, bool matchCase) const
	XDEF	getSwitch__AppBase__PCcs
getSwitch__AppBase__PCcs
	movem.l	d2/a2,-(a7)
	move.w	$10(a7),d0
	move.l	$C(a7),a2
L95
;	if (StartupLib::numStartArgs<2)
	move.l	_numStartArgs__StartupLib,d1
	cmp.l	#2,d1
	bge.b	L97
L96
;		return false;
	moveq	#0,d0
	movem.l	(a7)+,d2/a2
	rts
L97
;	if (matchCase)
	tst.w	d0
	beq.b	L104
L98
;		for (int i = 0;
	moveq	#0,d2
	bra.b	L102
L99
;			if (strcmp(StartupLib::startArgs[i], paramName) == 0)
	move.l	a2,-(a7)
	move.l	_startArgs__StartupLib,a1
	move.l	0(a1,d2.l*4),-(a7)
	jsr	_strcmp
	addq.w	#$8,a7
	tst.l	d0
	bne.b	L101
L100
;				return true;
	moveq	#1,d0
	movem.l	(a7)+,d2/a2
	rts
L101
	addq.l	#1,d2
L102
	cmp.l	_numStartArgs__StartupLib,d2
	blt.b	L99
L103
	bra.b	L109
L104
;		for (int i = 0;
	moveq	#0,d2
	bra.b	L108
L105
;			if (stricmp(StartupLib::startArgs[i], paramName) == 0)
	move.l	a2,-(a7)
	move.l	_startArgs__StartupLib,a1
	move.l	0(a1,d2.l*4),-(a7)
	jsr	_stricmp
	addq.w	#$8,a7
	tst.l	d0
	bne.b	L107
L106
;				return true;
	moveq	#1,d0
	movem.l	(a7)+,d2/a2
	rts
L107
	addq.l	#1,d2
L108
	cmp.l	_numStartArgs__StartupLib,d2
	blt.b	L105
L109
;	return false;
	moveq	#0,d0
	movem.l	(a7)+,d2/a2
	rts

	SECTION "main__iPPc:0",CODE


;int main(int argc, char** argv)
	XDEF	main__iPPc
main__iPPc
	move.l	d2,-(a7)
	movem.l	$8(a7),d0/a0
L111
;	sint32 retVal = StartupLib::init(argc, argv);
	move.l	a0,-(a7)
	move.l	d0,-(a7)
	jsr	init__StartupLib__iPPc
	addq.w	#$8,a7
	move.l	d0,d2
;	if (retVal==OK)
	bne.b	L113
L112
;		retVal = StartupLib::runApplication();
	jsr	runApplication__StartupLib_
	move.l	d0,d2
	bra.b	L114
L113
;		X_ERROR("Unable to in
	pea	2.w
	move.l	#L110,-(a7)
	jsr	printDebug__SystemLib__PCci
	addq.w	#$8,a7
L114
;	StartupLib::done();
	jsr	done__StartupLib_
;	return retVal;
	move.l	d2,d0
	move.l	(a7)+,d2
	rts

L110
	dc.b	'Unable to initialise base library',0

	END
