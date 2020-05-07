
; Storm C Compiler
; EXNG:libsrc/plat/amigaos3_68k/systemlib/thread.cpp
	mc68030
	mc68881
	XREF	_DeleteExtIO
	XREF	_CreateExtIO
	XREF	_strcpy
	XREF	_strncpy
	XREF	run__Threadable__T
	XREF	elapsed__Clock__T
	XREF	runApplication__AppBase__T
	XREF	_sprintf
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
	XREF	_clockFreq__MilliClock
	XREF	_DOSBase

	SECTION "getVolatile__Mem_:0",CODE

	rts

	SECTION "op__plus__R04TimeR04Time:0",CODE


;Time operator+(Time& a, Time& b)
	XDEF	op__plus__R04TimeR04Time
op__plus__R04TimeR04Time
L97	EQU	-$8
	link	a5,#L97
	movem.l	d2/d3/a2,-(a7)
	movem.l	$C(a5),a1/a2
L96
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
L99	EQU	-$8
	link	a5,#L99
	movem.l	d2/d3/a2,-(a7)
	movem.l	$C(a5),a1/a2
L98
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

	SECTION "init__IdleTimer__Threadable__T:0",CODE


;bool Threadable::IdleTimer::init()
	XDEF	init__IdleTimer__Threadable__T
init__IdleTimer__Threadable__T
	movem.l	a2/a6,-(a7)
	move.l	$C(a7),a2
L101
;	if ( !(timerPort = ::CreateMsgPort()) )
	move.l	_SysBase,a6
	jsr	-$29A(a6)
	move.l	a2,a1
	move.l	d0,(a1)
	bne.b	L103
L102
;		flags |= PORT_FAIL;
	move.l	a2,a0
	move.l	$10(a0),d0
	or.l	#1,d0
	move.l	a2,a0
	move.l	d0,$10(a0)
;		return false;
	moveq	#0,d0
	movem.l	(a7)+,a2/a6
	rts
L103
;	timerSignal = 1<<timerPort->mp_SigBit;
	move.l	a2,a1
	move.l	(a1),a0
	moveq	#0,d0
	move.b	$F(a0),d0
	moveq	#1,d1
	asl.l	d0,d1
	move.l	a2,a0
	move.l	d1,$8(a0)
;	if ( !(timerIO = ::CreateExtIO(timerPort, sizeof(timerequest))) )
	pea	$28.w
	move.l	a2,a1
	move.l	(a1),-(a7)
	jsr	_CreateExtIO
	addq.w	#$8,a7
	move.l	a2,a1
	move.l	d0,4(a1)
	bne.b	L105
L104
;		flags |= IORQ_FAIL;
	move.l	a2,a0
	move.l	$10(a0),d0
	or.l	#2,d0
	move.l	a2,a0
	move.l	d0,$10(a0)
;		return false;
	moveq	#0,d0
	movem.l	(a7)+,a2/a6
	rts
L105
;	if (::OpenDevice(TIMERNAME, UNIT_MICROHZ, timerIO, 0)!=0)
	move.l	a2,a0
	move.l	4(a0),a1
	move.l	_SysBase,a6
	moveq	#0,d0
	moveq	#0,d1
	move.l	#L100,a0
	jsr	-$1BC(a6)
	ext.w	d0
	tst.w	d0
	beq.b	L107
L106
;		flags |= OPDV_FAIL;
	move.l	a2,a0
	move.l	$10(a0),d0
	or.l	#4,d0
	move.l	a2,a0
	move.l	d0,$10(a0)
;		return false;
	moveq	#0,d0
	movem.l	(a7)+,a2/a6
	rts
L107
;	return true;
	moveq	#1,d0
	movem.l	(a7)+,a2/a6
	rts

L100
	dc.b	'timer.device',0

	SECTION "done__IdleTimer__Threadable__T:0",CODE


;void Threadable::IdleTimer::done()
	XDEF	done__IdleTimer__Threadable__T
done__IdleTimer__Threadable__T
	movem.l	a2/a6,-(a7)
	move.l	$C(a7),a2
L108
;	if (timerIO)
	move.l	a2,a1
	tst.l	4(a1)
	beq.b	L112
L109
;		if (flags & IORQ_USED)
	move.l	a2,a0
	move.l	$10(a0),d0
	and.l	#$8,d0
	beq.b	L111
L110
;			::AbortIO(timerIO);
	move.l	a2,a0
	move.l	_SysBase,a6
	move.l	4(a0),a1
	jsr	-$1E0(a6)
;			::WaitIO(timerIO);
	move.l	a2,a0
	move.l	_SysBase,a6
	move.l	4(a0),a1
	jsr	-$1DA(a6)
;			::SetSignal(0, timerSignal);
	move.l	a2,a0
	move.l	_SysBase,a6
	moveq	#0,d0
	move.l	$8(a0),d1
	jsr	-$132(a6)
L111
;		::CloseDevice(timerIO);
	move.l	a2,a0
	move.l	_SysBase,a6
	move.l	4(a0),a1
	jsr	-$1C2(a6)
;		::DeleteExtIO(timerIO);
	move.l	a2,a1
	move.l	4(a1),-(a7)
	jsr	_DeleteExtIO
	addq.w	#4,a7
L112
;	if (timerPort)
	move.l	a2,a1
	tst.l	(a1)
	beq.b	L114
L113
;		::DeleteMsgPort(timerPort);
	move.l	a2,a1
	move.l	_SysBase,a6
	move.l	(a1),a0
	jsr	-$2A0(a6)
L114
;	timerPort = 0;
	move.l	a2,a1
	clr.l	(a1)
;	timerIO = 0;
	move.l	a2,a1
	clr.l	4(a1)
;	timerSignal = 0;
	move.l	a2,a0
	clr.l	$8(a0)
;	flags = 0;
	move.l	a2,a0
	clr.l	$10(a0)
	movem.l	(a7)+,a2/a6
	rts

	SECTION "abortDelay__IdleTimer__Threadable__T:0",CODE


;void Threadable::IdleTimer::abortDelay()
	XDEF	abortDelay__IdleTimer__Threadable__T
abortDelay__IdleTimer__Threadable__T
	movem.l	a2/a6,-(a7)
	move.l	$C(a7),a2
L115
;	if (timerIO && (flags & IORQ_USED))
	move.l	a2,a1
	tst.l	4(a1)
	beq.b	L118
L116
	move.l	a2,a0
	move.l	$10(a0),d0
	and.l	#$8,d0
	beq.b	L118
L117
;		::AbortIO(timerIO);
	move.l	a2,a0
	move.l	_SysBase,a6
	move.l	4(a0),a1
	jsr	-$1E0(a6)
;		::WaitIO(timerIO);
	move.l	a2,a0
	move.l	_SysBase,a6
	move.l	4(a0),a1
	jsr	-$1DA(a6)
;		::SetSignal(0, timerSignal);
	move.l	a2,a0
	move.l	_SysBase,a6
	moveq	#0,d0
	move.l	$8(a0),d1
	jsr	-$132(a6)
L118
	movem.l	(a7)+,a2/a6
	rts

	SECTION "suspend__IdleTimer__Threadable__TUjUj:0",CODE


;uint32 Threadable::IdleTimer::suspend(uint32 millis, uint32 trigger)
	XDEF	suspend__IdleTimer__Threadable__TUjUj
suspend__IdleTimer__Threadable__TUjUj
	movem.l	d2/d3/a2/a6,-(a7)
	movem.l	$18(a7),d2/d3
	move.l	$14(a7),a2
L119
;	req = trigger;
	move.l	a2,a0
	move.l	d3,$C(a0)
;	if (!(millis|trigger))
	move.l	d2,d0
	or.l	d3,d0
	bne.b	L121
L120
;		return 0;
	moveq	#0,d0
	movem.l	(a7)+,d2/d3/a2/a6
	rts
L121
;	abortDelay();
	move.l	a2,-(a7)
	jsr	abortDelay__IdleTimer__Threadable__T
	addq.w	#4,a7
;	if (millis)
	tst.l	d2
	beq.b	L123
L122
;		timerReq->tr_node.io_Command	= TR_ADDREQUEST;
	move.l	a2,a1
	move.l	4(a1),a0
	move.w	#$9,$1C(a0)
;		timerReq->tr_time.tv_secs			= (millis/1000);
	move.l	d2,d0
	divul.l	#$3E8,d0
	move.l	a2,a1
	move.l	4(a1),a0
	move.l	d0,$20(a0)
;		timerReq->tr_time.tv_micro		= 1000*(millis%1000);
	divul.l	#$3E8,d0:d2
	mulu.l	#$3E8,d0
	move.l	a2,a1
	move.l	4(a1),a0
	move.l	d0,$24(a0)
;		::SendIO(timerIO);
	move.l	a2,a0
	move.l	_SysBase,a6
	move.l	4(a0),a1
	jsr	-$1CE(a6)
;		flags |= IORQ_USED;
	move.l	a2,a0
	move.l	$10(a0),d0
	or.l	#$8,d0
	move.l	a2,a0
	move.l	d0,$10(a0)
;		flags &= ~IORQ_4EVR;
	move.l	a2,a0
	move.l	$10(a0),d0
	and.l	#-$11,d0
	move.l	a2,a0
	move.l	d0,$10(a0)
	bra.b	L124
L123
;		flags |= IORQ_4EVR;
	move.l	a2,a0
	move.l	$10(a0),d0
	or.l	#$10,d0
	move.l	a2,a0
	move.l	d0,$10(a0)
L124
;	return ::Wait(timerSignal|trigger);
	move.l	a2,a0
	move.l	$8(a0),d0
	or.l	d3,d0
	move.l	_SysBase,a6
	jsr	-$13E(a6)
	movem.l	(a7)+,d2/d3/a2/a6
	rts

	SECTION "suspend__IdleTimer__Threadable__T:0",CODE


;uint32 Threadable::IdleTimer::suspend()
	XDEF	suspend__IdleTimer__Threadable__T
suspend__IdleTimer__Threadable__T
	movem.l	a2/a6,-(a7)
	move.l	$C(a7),a2
L125
;	if (req)
	move.l	a2,a0
	tst.l	$C(a0)
	beq.b	L131
L126
;		if (timerIO && (flags & IORQ_USED))
	move.l	a2,a1
	tst.l	4(a1)
	beq.b	L131
L127
	move.l	a2,a0
	move.l	$10(a0),d0
	and.l	#$8,d0
	beq.b	L131
L128
;		if (::CheckIO(timerIO)==0)
	move.l	a2,a0
	move.l	_SysBase,a6
	move.l	4(a0),a1
	jsr	-$1D4(a6)
	move.l	d0,a0
	cmp.w	#0,a0
	bne.b	L130
L129
;			return ::Wait(req|timerSignal);
	move.l	a2,a0
	move.l	$C(a0),d0
	move.l	a2,a0
	or.l	$8(a0),d0
	move.l	_SysBase,a6
	jsr	-$13E(a6)
	movem.l	(a7)+,a2/a6
	rts
L130
;			return timerSignal;
	move.l	a2,a0
	move.l	$8(a0),d0
	movem.l	(a7)+,a2/a6
	rts
L131
;	return 0;
	moveq	#0,d0
	movem.l	(a7)+,a2/a6
	rts

	SECTION "_0ct__MainThread__T:0",CODE


;MainThread::MainThread() 
	XDEF	_0ct__MainThread__T
_0ct__MainThread__T
	movem.l	a2/a6,-(a7)
	move.l	$C(a7),a6
L133
	move.l	a6,-(a7)
	jsr	_0ct__Threadable__T
	addq.w	#4,a7
;	internal = (Process*)rootThread;
	move.l	_rootThread__Threadable,$8(a6)
;	state = SPAWNED;
	move.w	#1,$12(a6)
;	strcpy(name, "Main");
	move.l	#L132,-(a7)
	pea	$3C(a6)
	jsr	_strcpy
	addq.w	#$8,a7
;	sleeper.init();
	pea	$18(a6)
	jsr	init__IdleTimer__Threadable__T
	addq.w	#4,a7
;	uptime.set();
	lea	$2C(a6),a0
	move.l	a0,a2
	move.l	_TimerBase,a6
	move.l	a2,a0
	jsr	-$42(a6)
	move.l	a2,a0
	clr.l	$8(a0)
	clr.l	$C(a0)
	movem.l	(a7)+,a2/a6
	rts

L132
	dc.b	'Main',0

	SECTION "_0dt__MainThread__T:0",CODE


;MainThread::~MainThread()
	XDEF	_0dt__MainThread__T
_0dt__MainThread__T
	move.l	a2,-(a7)
	move.l	$8(a7),a2
L134
;	sleeper.done();
	pea	$18(a2)
	jsr	done__IdleTimer__Threadable__T
	addq.w	#4,a7
;	state = 0;
	clr.w	$12(a2)
	move.l	a2,-(a7)
	jsr	_0dt__Threadable__T
	addq.w	#4,a7
	move.l	(a7)+,a2
	rts

	SECTION "_mainThread:0",CODE


	XDEF	_INIT_8_thread_cpp__mainThread
_INIT_8_thread_cpp__mainThread
L135
;static MainThread mainThread;
	move.l	#_0virttab__10MainThread__10MainThread,_mainThread+$4C
	pea	_mainThread
	jsr	_0ct__MainThread__T
	addq.w	#4,a7
	clr.l	_dummy__getUptime__Thread_
	clr.l	_dummy__getUptime__Thread_+4
	rts

	XDEF	_EXIT_8_thread_cpp__mainThread
_EXIT_8_thread_cpp__mainThread
L136
	move.l	#_mainThread,-(a7)
	jsr	_0dt__MainThread__T
	addq.w	#4,a7
	rts

	SECTION "_mainThread:2",BSS

_mainThread
	ds.b	80

	SECTION "getMain__Thread_:0",CODE


;Threadable* Thread::getMain()
	XDEF	getMain__Thread_
getMain__Thread_
L137
;	return &mainThread;
	move.l	#_mainThread,d0
	rts

	SECTION "getCurrent__Thread_:0",CODE


;Threadable* Thread::getCurrent()
	XDEF	getCurrent__Thread_
getCurrent__Thread_
	move.l	a6,-(a7)
L138
;	Task* task = ::FindTask(0);
	move.l	_SysBase,a6
	sub.l	a1,a1
	jsr	-$126(a6)
	move.l	d0,a0
;	if (task==Threadable::rootThread)
	cmp.l	_rootThread__Threadable,a0
	bne.b	L140
L139
;		return getMain();
	jsr	getMain__Thread_
	move.l	(a7)+,a6
	rts
L140
;	else if (task)
	cmp.w	#0,a0
	beq.b	L144
L141
;		Threadable* thread = (Threadable*)(task->tc_UserData);
	move.l	$58(a0),a0
;		if (thread && thread->classID == Threadable::IDTAG)
	cmp.w	#0,a0
	beq.b	L144
L142
	move.l	(a0),d0
	cmp.l	#$58534C54,d0
	bne.b	L144
L143
;			return thread;
	move.l	a0,d0
	move.l	(a7)+,a6
	rts
L144
;	return 0;
	moveq	#0,d0
	move.l	(a7)+,a6
	rts

	SECTION "userBreak__Thread_:0",CODE


;bool Thread::userBreak()
	XDEF	userBreak__Thread_
userBreak__Thread_
	move.l	a6,-(a7)
L145
;	return (::SetSignal(0, SIGBREAKF_CTRL_C) & SIGBREAKF_CTRL_C) ? tru
	move.l	_SysBase,a6
	moveq	#0,d0
	move.l	#$1000,d1
	jsr	-$132(a6)
	and.l	#$1000,d0
	beq.b	L147
L146
	moveq	#1,d0
	bra.b	L148
L147
	moveq	#0,d0
L148
	move.l	(a7)+,a6
	rts

	SECTION "sleep__Thread__Ujsss:0",CODE


;sint32 Thread::sleep(uint32 ms, bool ignBrk, bool ignWk, bool abrtRq)
	XDEF	sleep__Thread__Ujsss
sleep__Thread__Ujsss
	movem.l	d2-d5,-(a7)
	move.l	$14(a7),d2
	move.w	$18(a7),d3
	move.w	$1A(a7),d4
	move.w	$1C(a7),d5
L149
;	Threadable* t = getCurrent();
	jsr	getCurrent__Thread_
	move.l	d0,a0
;	if (t)
	cmp.w	#0,a0
	beq.b	L151
L150
;		return t->sleep(ms, ignBrk, ignWk, abrtRq);
	move.w	d5,-(a7)
	move.w	d4,-(a7)
	move.w	d3,-(a7)
	move.l	d2,-(a7)
	move.l	a0,-(a7)
	jsr	sleep__Threadable__TUjsss
	add.w	#$E,a7
	movem.l	(a7)+,d2-d5
	rts
L151
;	return Threadable::ERR_ACCESS;
	moveq	#-2,d0
	movem.l	(a7)+,d2-d5
	rts

	SECTION "sleepResume__Thread_:0",CODE


;sint32 Thread::sleepResume()
	XDEF	sleepResume__Thread_
sleepResume__Thread_
L152
;	Threadable* t = getCurrent();
	jsr	getCurrent__Thread_
	move.l	d0,a0
;	if (t)
	cmp.w	#0,a0
	beq.b	L154
L153
;		return t->sleepResume();
	move.l	a0,-(a7)
	jsr	sleepResume__Threadable__T
	addq.w	#4,a7
	rts
L154
;	return Threadable::ERR_ACCESS;
	moveq	#-2,d0
	rts

	SECTION "sleepAbort__Thread_:0",CODE


;void Thread::sleepAbort()
	XDEF	sleepAbort__Thread_
sleepAbort__Thread_
L155
;	Threadable* t = getCurrent();
	jsr	getCurrent__Thread_
	move.l	d0,a0
;	if (t)
	cmp.w	#0,a0
	beq.b	L157
L156
;		t->sleepAbort();
	move.l	a0,-(a7)
	jsr	sleepAbort__Threadable__T
	addq.w	#4,a7
L157
	rts

	SECTION "getUptime__Thread_:0",CODE


;Time& Thread::getUptime()
	XDEF	getUptime__Thread_
getUptime__Thread_
L158
;	Threadable* t = getCurrent();
	jsr	getCurrent__Thread_
	move.l	d0,a0
;	if (t)
	cmp.w	#0,a0
	beq.b	L160
L159
;		t->getUptime();
	move.l	a0,-(a7)
	jsr	getUptime__Threadable__T
	addq.w	#4,a7
L160
;	return dummy;
	move.l	#_dummy__getUptime__Thread_,d0
	rts

	SECTION "getUptime__Thread_:2",BSS

_dummy__getUptime__Thread_
	ds.l	2

	SECTION "_threadCnt__Threadable:1",DATA

	XDEF	_threadCnt__Threadable
_threadCnt__Threadable
	dc.l	1

	SECTION "_threadsIdle__Threadable:1",DATA

	XDEF	_threadsIdle__Threadable
_threadsIdle__Threadable
	dc.l	0

	SECTION "_rootThread__Threadable:0",CODE


	XDEF	_INIT_8_thread_cpp__rootThread__Threadable
_INIT_8_thread_cpp__rootThread__Threadable
	move.l	a6,-(a7)
L163
;Task*		Threadable::rootThread	= ::FindTask(0);
	move.l	_SysBase,a6
	sub.l	a1,a1
	jsr	-$126(a6)
	move.l	d0,_rootThread__Threadable
	move.l	(a7)+,a6
	rts

	SECTION "_rootThread__Threadable:1",DATA

	XDEF	_rootThread__Threadable
_rootThread__Threadable
	ds.l	1

	SECTION "_priTab__Threadable:1",DATA

	XDEF	_priTab__Threadable
_priTab__Threadable
	dc.w	0,-$7F,-$64,-$A,-5,0,5,$A,$14,$64

	SECTION "_0ct__Threadable__T:0",CODE


;Threadable::Threadable() 
	XDEF	_0ct__Threadable__T
_0ct__Threadable__T
	movem.l	a2/a6,-(a7)
	move.l	$C(a7),a0
L165
	move.l	#$58534C54,(a0)
	clr.l	4(a0)
	clr.l	$8(a0)
	clr.l	$C(a0)
	move.w	#5,$10(a0)
	clr.w	$12(a0)
	clr.l	$14(a0)
	lea	$18(a0),a1
	clr.l	(a1)
	clr.l	4(a1)
	clr.l	$8(a1)
	clr.l	$C(a1)
	clr.l	$10(a1)
	add.w	#$2C,a0
	clr.l	$8(a0)
	clr.l	$C(a0)
	move.l	a0,a2
	move.l	_TimerBase,a6
	jsr	-$42(a6)
	move.l	a2,a0
	clr.l	$8(a0)
	clr.l	$C(a0)
	movem.l	(a7)+,a2/a6
	rts

	SECTION "_0dt__Threadable__T:0",CODE


;Threadable::~Threadable()
	XDEF	_0dt__Threadable__T
_0dt__Threadable__T
	move.l	4(a7),a0
L166
;	stop();
	move.l	a0,-(a7)
	jsr	stop__Threadable__T
	addq.w	#4,a7
	rts

	SECTION "entryPoint__Threadable_:0",CODE


;void Threadable::entryPoint()
	XDEF	entryPoint__Threadable_
entryPoint__Threadable_
	movem.l	a2/a6,-(a7)
L167
;	::Wait(SIGNAL_SYNC);
	move.l	_SysBase,a6
	move.l	#$8000,d0
	jsr	-$13E(a6)
;	Threadable *t = Thread::getCurrent();
	jsr	getCurrent__Thread_
	move.l	d0,a2
;	if (t)
	cmp.w	#0,a2
	beq	L171
L168
;		if (t->sleeper.init() == false)
	pea	$18(a2)
	jsr	init__IdleTimer__Threadable__T
	addq.w	#4,a7
	tst.w	d0
	bne.b	L170
L169
;			t->state |= STARTERROR;
	move.l	a2,a0
	move.w	$12(a0),d0
	or.w	#2,d0
	move.l	a2,a0
	move.w	d0,$12(a0)
;			return;
	movem.l	(a7)+,a2/a6
	rts
L170
;		t->state |= SPAWNED;
	move.l	a2,a0
	move.w	$12(a0),d0
	or.w	#1,d0
	move.l	a2,a0
	move.w	d0,$12(a0)
;		::Signal(t->external, (uint32)SIGNAL_SYNC);
	move.l	a2,a0
	move.l	_SysBase,a6
	move.l	#$8000,d0
	move.l	4(a0),a1
	jsr	-$144(a6)
;		++threadCnt;
	addq.l	#1,_threadCnt__Threadable
;		retVal = t->run();
	move.l	a2,a1
	move.l	$4C(a1),a0
	move.l	a2,d0
	add.l	$14(a0),d0
	move.l	d0,-(a7)
	move.l	$10(a0),a0
	jsr	(a0)
	addq.w	#4,a7
	move.l	d0,d2
;		--threadCnt;
	subq.l	#1,_threadCnt__Threadable
;		t->state |= COMPLETED;
	move.l	a2,a0
	move.w	$12(a0),d0
	or.w	#4,d0
	move.l	a2,a0
	move.w	d0,$12(a0)
;		return;
	movem.l	(a7)+,a2/a6
	rts
L171
	movem.l	(a7)+,a2/a6
	rts

	SECTION "exitPoint__Threadable_:0",CODE


;void Threadable::exitPoint()
	XDEF	exitPoint__Threadable_
exitPoint__Threadable_
	move.l	a6,-(a7)
L172
;	Threadable* t = Thread::getCurrent();
	jsr	getCurrent__Thread_
	move.l	d0,a6
;	if (t)
	cmp.w	#0,a6
	beq.b	L174
L173
;		t->sleeper.done();
	pea	$18(a6)
	jsr	done__IdleTimer__Threadable__T
	addq.w	#4,a7
;		t->state &= ~SPAWNED;
	and.w	#$FFFE,$12(a6)
;		::Signal(t->external, (uint32)SIGNAL_SYNC);
	move.l	4(a6),a1
	move.l	_SysBase,a6
	move.l	#$8000,d0
	jsr	-$144(a6)
L174
	move.l	(a7)+,a6
	rts

	SECTION "sleep__Threadable__TUjsss:0",CODE


;sint32 Threadable::sleep(uint32 ms, bool ignBrk, bool ignWk, bool ab
	XDEF	sleep__Threadable__TUjsss
sleep__Threadable__TUjsss
	movem.l	d2-d5/a2/a3/a6,-(a7)
	move.l	$24(a7),d2
	move.w	$2C(a7),d3
	move.w	$2A(a7),d4
	move.w	$28(a7),d5
	move.l	$20(a7),a2
L175
;	if ((&(internal->pr_Task))!=::FindTask(0))
	move.l	a2,a0
	move.l	$8(a0),a3
	move.l	_SysBase,a6
	sub.l	a1,a1
	jsr	-$126(a6)
	move.l	a3,a0
	cmp.l	d0,a0
	beq.b	L177
L176
;		return ERR_ACCESS;
	moveq	#-2,d0
	movem.l	(a7)+,d2-d5/a2/a3/a6
	rts
L177
;	if (abrtRq)
	tst.w	d3
	beq.b	L179
L178
;		state |= ABORTREQ;
	move.l	a2,a0
	move.w	$12(a0),d0
	or.w	#$80,d0
	move.l	a2,a0
	move.w	d0,$12(a0)
	bra.b	L180
L179
;		state &= ~ABORTREQ;
	move.l	a2,a0
	move.w	$12(a0),d0
	and.w	#$FF7F,d0
	move.l	a2,a0
	move.w	d0,$12(a0)
L180
;	uint32 trig = SIGNAL_REMV;
	move.l	#$4000,d0
;	if (ignBrk)
	tst.w	d5
	beq.b	L182
L181
;		state |= IGNOREBREAK;
	move.l	a2,a0
	move.w	$12(a0),d1
	or.w	#$40,d1
	move.l	a2,a0
	move.w	d1,$12(a0)
	bra.b	L183
L182
;		state &= ~IGNOREBREAK;
	move.l	a2,a0
	move.w	$12(a0),d1
	and.w	#$FFBF,d1
	move.l	a2,a0
	move.w	d1,$12(a0)
;		trig |= SIGNAL_BREAK;
	or.l	#$1000,d0
L183
;	if (ignWk)
	tst.w	d4
	beq.b	L185
L184
;		state |= IGNOREWAKE;
	move.l	a2,a0
	move.w	$12(a0),d1
	or.w	#$20,d1
	move.l	a2,a0
	move.w	d1,$12(a0)
	bra.b	L186
L185
;		state &= ~IGNOREWAKE;
	move.l	a2,a0
	move.w	$12(a0),d1
	and.w	#$FFDF,d1
	move.l	a2,a0
	move.w	d1,$12(a0)
;		trig |= SIGNAL_WAKE;
	or.l	#$2000,d0
L186
;	++threadsIdle;
	addq.l	#1,_threadsIdle__Threadable
;	state |= SLEEPING;
	move.l	a2,a0
	move.w	$12(a0),d1
	or.w	#$10,d1
	move.l	a2,a0
	move.w	d1,$12(a0)
;	gotSignals = sleeper.suspend(ms, trig);
	move.l	d0,-(a7)
	move.l	d2,-(a7)
	pea	$18(a2)
	jsr	suspend__IdleTimer__Threadable__TUjUj
	add.w	#$C,a7
	move.l	d0,d2
;	state &= ~SLEEPING;
	move.l	a2,a0
	move.w	$12(a0),d0
	and.w	#$FFEF,d0
	move.l	a2,a0
	move.w	d0,$12(a0)
;	--threadsIdle;
	subq.l	#1,_threadsIdle__Threadable
;	if (abrtRq)
	tst.w	d3
	beq.b	L188
L187
;	  sleepAbort();
	move.l	a2,-(a7)
	jsr	sleepAbort__Threadable__T
	addq.w	#4,a7
L188
;	if (gotSignals & SIGNAL_REMV)
	move.l	d2,d0
	and.l	#$4000,d0
	beq.b	L190
L189
;		sleepAbort();
	move.l	a2,-(a7)
	jsr	sleepAbort__Threadable__T
	addq.w	#4,a7
;		state |= SHUTDOWN;
	move.l	a2,a0
	move.w	$12(a0),d0
	or.w	#$8,d0
	move.l	a2,a0
	move.w	d0,$12(a0)
;		result = REMOVE;
	moveq	#0,d0
	bra.b	L199
L190
;	else if ((gotSignals & SIGNAL_WAKE) && !(state & IGNOREWAKE))
	move.l	d2,d0
	and.l	#$2000,d0
	beq.b	L193
L191
	move.l	a2,a0
	moveq	#0,d0
	move.w	$12(a0),d0
	and.l	#$20,d0
	bne.b	L193
L192
;		result = WAKECALL;
	moveq	#1,d0
	bra.b	L199
L193
;	else if ((gotSignals & SIGNAL_BREAK) && !(state & IGNOREBREAK)
	move.l	d2,d0
	and.l	#$1000,d0
	beq.b	L196
L194
	move.l	a2,a0
	moveq	#0,d0
	move.w	$12(a0),d0
	and.l	#$40,d0
	bne.b	L196
L195
;		result = USERBREAK;
	moveq	#2,d0
	bra.b	L199
L196
;	else if (gotSignals & sleeper.getTimerSignal())
	and.l	$20(a2),d2
	beq.b	L198
L197
;		result = TIMEOUT;
	moveq	#4,d0
	bra.b	L199
L198
;		result = UNKNOWN;
	moveq	#6,d0
L199
;	return result;
	movem.l	(a7)+,d2-d5/a2/a3/a6
	rts

	SECTION "sleepResume__Threadable__T:0",CODE


;sint32 Threadable::sleepResume()
	XDEF	sleepResume__Threadable__T
sleepResume__Threadable__T
	movem.l	d2/a2/a3/a6,-(a7)
	move.l	$14(a7),a2
L200
;	if ((&(internal->pr_Task))!=::FindTask(0))
	move.l	a2,a0
	move.l	$8(a0),a3
	move.l	_SysBase,a6
	sub.l	a1,a1
	jsr	-$126(a6)
	move.l	a3,a0
	cmp.l	d0,a0
	beq.b	L202
L201
;		return ERR_ACCESS;
	moveq	#-2,d0
	movem.l	(a7)+,d2/a2/a3/a6
	rts
L202
;	else if (state & ABORTREQ)
	move.l	a2,a0
	moveq	#0,d0
	move.w	$12(a0),d0
	and.l	#$80,d0
	beq.b	L204
L203
;		return SLEEPABORTED;
	moveq	#5,d0
	movem.l	(a7)+,d2/a2/a3/a6
	rts
L204
;	uint32 gotSignals = sleeper.suspend();
	pea	$18(a2)
	jsr	suspend__IdleTimer__Threadable__T
	addq.w	#4,a7
;	if (gotSignals & SIGNAL_REMV)
	move.l	d0,d1
	and.l	#$4000,d1
	beq.b	L206
L205
;		sleeper.abortDelay();
	pea	$18(a2)
	jsr	abortDelay__IdleTimer__Threadable__T
	addq.w	#4,a7
;		state |= SHUTDOWN;
	move.l	a2,a0
	move.w	$12(a0),d0
	or.w	#$8,d0
	move.l	a2,a0
	move.w	d0,$12(a0)
;		return REMOVE;
	moveq	#0,d0
	movem.l	(a7)+,d2/a2/a3/a6
	rts
L206
;	else if ((gotSignals & SIGNAL_WAKE) && !(state & IGNOREWAKE))
	move.l	d0,d1
	and.l	#$2000,d1
	beq.b	L209
L207
	move.l	a2,a0
	moveq	#0,d1
	move.w	$12(a0),d1
	and.l	#$20,d1
	bne.b	L209
L208
;		return WAKECALL;
	moveq	#1,d0
	movem.l	(a7)+,d2/a2/a3/a6
	rts
L209
;//////////////////////////////////
	move.l	d0,d1
	and.l	#$1000,d1
	beq.b	L212
L210
	move.l	a2,a0
	moveq	#0,d1
	move.w	$12(a0),d1
	and.l	#$40,d1
	bne.b	L212
L211
;		return USERBREAK;
	moveq	#2,d0
	movem.l	(a7)+,d2/a2/a3/a6
	rts
L212
;	else if (gotSignals & sleeper.getTimerSignal())
	and.l	$20(a2),d0
	beq.b	L214
L213
;		return TIMEOUT;
	moveq	#4,d0
	movem.l	(a7)+,d2/a2/a3/a6
	rts
L214
;	return UNKNOWN;
	moveq	#6,d0
	movem.l	(a7)+,d2/a2/a3/a6
	rts

	SECTION "sleepAbort__Threadable__T:0",CODE


;void Threadable::sleepAbort()
	XDEF	sleepAbort__Threadable__T
sleepAbort__Threadable__T
	move.l	a2,-(a7)
	move.l	$8(a7),a2
L215
;	sleeper.abortDelay();
	pea	$18(a2)
	jsr	abortDelay__IdleTimer__Threadable__T
	addq.w	#4,a7
;	state |= ABORTREQ;
	or.w	#$80,$12(a2)
	move.l	(a7)+,a2
	rts

	SECTION "start__Threadable__TPCcEUi:0",CODE


;sint32 Threadable::start(const char* nm, Threadable::Priority pri, s
	XDEF	start__Threadable__TPCcEUi
start__Threadable__TPCcEUi
L232	EQU	-$40
	link	a5,#L232
	movem.l	d2/d3/a2/a3/a6,-(a7)
	movem.l	$10(a5),d2/d3
	move.l	$C(a5),a2
	move.l	$8(a5),a3
L217
;	if (state & SPAWNED)
	move.l	a3,a0
	moveq	#0,d0
	move.w	$12(a0),d0
	and.l	#1,d0
	beq.b	L219
L218
;		return ERR_ALREADYRUNNING;
	moveq	#-4,d0
	movem.l	(a7)+,d2/d3/a2/a3/a6
	unlk	a5
	rts
L219
;	external = ::FindTask(0);
	move.l	_SysBase,a6
	sub.l	a1,a1
	jsr	-$126(a6)
	move.l	a3,a1
	move.l	d0,4(a1)
;	stackSize = stk;
	move.l	a3,a0
	move.l	d3,$C(a0)
;	priority	= pri;
	move.l	a3,a0
	move.w	d2,$10(a0)
;	if (nm)
	cmp.w	#0,a2
	beq.b	L221
L220
;		strncpy(name, nm, 15);
	pea	$F.w
	move.l	a2,-(a7)
	pea	$3C(a3)
	jsr	_strncpy
	add.w	#$C,a7
	bra.b	L222
L221
;		sprintf(name, "Thread [%d]", threadCnt+1);
	move.l	_threadCnt__Threadable,d0
	addq.l	#1,d0
	move.l	d0,-(a7)
	move.l	#L216,-(a7)
	pea	$3C(a3)
	jsr	_sprintf
	add.w	#$C,a7
L222
;	TagItem threadTags[] = {
	lea	-$40(a5),a0
	move.l	#$800003EB,(a0)+
	move.l	#entryPoint__Threadable_,(a0)+
	move.l	#$800003F3,(a0)+
	move.l	a3,a1
	move.l	$C(a1),(a0)+
	move.l	#$800003F5,(a0)+
	move.l	a3,a1
	move.w	$10(a1),d0
	ext.l	d0
	move.l	#_priTab__Threadable,a2
	move.w	0(a2,d0.l*2),d0
	ext.l	d0
	move.l	d0,(a0)+
	move.l	#$800003F4,(a0)+
	lea	$3C(a3),a1
	move.l	a1,(a0)+
	move.l	#$80000400,(a0)+
	move.l	#exitPoint__Threadable_,(a0)+
	move.l	#$800003EA,(a0)+
	clr.l	(a0)+
	move.l	#$800003EF,(a0)+
	move.l	#1,(a0)+
	clr.l	(a0)+
	clr.l	(a0)
;	state = 0;
	move.l	a3,a0
	clr.w	$12(a0)
;	internal = ::CreateNewProc(threadTags);
	lea	-$40(a5),a0
	move.l	_DOSBase,a6
	move.l	a0,d1
	jsr	-$1F2(a6)
	move.l	a3,a1
	move.l	d0,$8(a1)
;	if (!internal)
	move.l	a3,a1
	tst.l	$8(a1)
	bne.b	L224
L223
;		return ERR_STARTUP;
	moveq	#-1,d0
	movem.l	(a7)+,d2/d3/a2/a3/a6
	unlk	a5
	rts
L224
;		internal->pr_Task.tc_UserData = (void*)this;
	move.l	a3,a1
	move.l	$8(a1),a0
	move.l	a3,$58(a0)
;	uptime.set();
	lea	$2C(a3),a0
	move.l	a0,a2
	move.l	_TimerBase,a6
	move.l	a2,a0
	jsr	-$42(a6)
	move.l	a2,a0
	clr.l	$8(a0)
	clr.l	$C(a0)
;	::Signal(&(internal->pr_Task), (uint32)SIGNAL_SYNC);
	move.l	a3,a0
	move.l	_SysBase,a6
	move.l	#$8000,d0
	move.l	$8(a0),a1
	jsr	-$144(a6)
;	while ((state & (SPAWNED|STARTERROR|COMPLETED))==0)
	bra.b	L226
L225
;		::Wait((uint32)SIGNAL_SYNC);
	move.l	_SysBase,a6
	move.l	#$8000,d0
	jsr	-$13E(a6)
L226
	move.l	a3,a0
	moveq	#0,d0
	move.w	$12(a0),d0
	and.l	#7,d0
	beq.b	L225
L227
;	if (state & STARTERROR)
	move.l	a3,a0
	moveq	#0,d0
	move.w	$12(a0),d0
	and.l	#2,d0
	beq.b	L229
L228
;		state = 0;
	move.l	a3,a0
	clr.w	$12(a0)
;		return ERR_STARTUP;
	moveq	#-1,d0
	movem.l	(a7)+,d2/d3/a2/a3/a6
	unlk	a5
	rts
L229
;	if (state & COMPLETED)
	move.l	a3,a0
	moveq	#0,d0
	move.w	$12(a0),d0
	and.l	#4,d0
	beq.b	L231
L230
;		state = COMPLETED;
	move.l	a3,a0
	move.w	#4,$12(a0)
;		internal = 0;
	move.l	a3,a1
	clr.l	$8(a1)
L231
;	return OK;
	moveq	#0,d0
	movem.l	(a7)+,d2/d3/a2/a3/a6
	unlk	a5
	rts

L216
	dc.b	'Thread [%d]',0

	SECTION "stop__Threadable__T:0",CODE


;sint32 Threadable::stop()
	XDEF	stop__Threadable__T
stop__Threadable__T
	movem.l	a2/a3/a6,-(a7)
	move.l	$10(a7),a3
L233
;	if ((&(internal->pr_Task)) == rootThread)
	move.l	a3,a1
	move.l	$8(a1),a0
	cmp.l	_rootThread__Threadable,a0
	bne.b	L235
L234
;		return ERR_ACCESS;
	moveq	#-2,d0
	movem.l	(a7)+,a2/a3/a6
	rts
L235
;	if (!(state & SPAWNED) || !internal)
	move.l	a3,a0
	moveq	#0,d0
	move.w	$12(a0),d0
	and.l	#1,d0
	beq.b	L237
L236
	move.l	a3,a1
	tst.l	$8(a1)
	bne.b	L238
L237
;		return ERR_NOTRUNNING;
	moveq	#-3,d0
	movem.l	(a7)+,a2/a3/a6
	rts
L238
;	external = ::FindTask(0);
	move.l	_SysBase,a6
	sub.l	a1,a1
	jsr	-$126(a6)
	move.l	a3,a1
	move.l	d0,4(a1)
;	if ((&(internal->pr_Task))==external)
	move.l	a3,a0
	move.l	$8(a0),a1
	move.l	a3,a2
	cmp.l	4(a2),a1
	bne.b	L240
L239
;		external = 0;
	move.l	a3,a1
	clr.l	4(a1)
;		return ERR_ACCESS;
	moveq	#-2,d0
	movem.l	(a7)+,a2/a3/a6
	rts
L240
;	state |= SHUTDOWN;
	move.l	a3,a0
	move.w	$12(a0),d0
	or.w	#$8,d0
	move.l	a3,a0
	move.w	d0,$12(a0)
;	::Signal(&(internal->pr_Task), (uint32)SIGNAL_REMV);
	move.l	a3,a0
	move.l	_SysBase,a6
	move.l	#$4000,d0
	move.l	$8(a0),a1
	jsr	-$144(a6)
;	while(state & SPAWNED)
	bra.b	L242
L241
;		::Wait((uint32)SIGNAL_SYNC);
	move.l	_SysBase,a6
	move.l	#$8000,d0
	jsr	-$13E(a6)
L242
	move.l	a3,a0
	moveq	#0,d0
	move.w	$12(a0),d0
	and.l	#1,d0
	bne.b	L241
L243
;	internal = 0;
	move.l	a3,a1
	clr.l	$8(a1)
;	uptime.elapsed();
	pea	$2C(a3)
	jsr	elapsed__Clock__T
	addq.w	#4,a7
;	return OK;
	moveq	#0,d0
	movem.l	(a7)+,a2/a3/a6
	rts

	SECTION "wake__Threadable__T:0",CODE


;sint32 Threadable::wake()
	XDEF	wake__Threadable__T
wake__Threadable__T
	movem.l	a2/a3/a6,-(a7)
	move.l	$10(a7),a2
L244
;	if (!internal || !(state & SPAWNED))
	move.l	a2,a1
	tst.l	$8(a1)
	beq.b	L246
L245
	move.l	a2,a0
	moveq	#0,d0
	move.w	$12(a0),d0
	and.l	#1,d0
	bne.b	L247
L246
;		return ERR_NOTRUNNING;
	moveq	#-3,d0
	movem.l	(a7)+,a2/a3/a6
	rts
L247
;	else if ((&(internal->pr_Task))==::FindTask(0))
	move.l	a2,a0
	move.l	$8(a0),a3
	move.l	_SysBase,a6
	sub.l	a1,a1
	jsr	-$126(a6)
	move.l	a3,a0
	cmp.l	d0,a0
	bne.b	L249
L248
;		return ERR_ACCESS;
	moveq	#-2,d0
	movem.l	(a7)+,a2/a3/a6
	rts
L249
;	else if (state & IGNOREWAKE)
	move.l	a2,a0
	moveq	#0,d0
	move.w	$12(a0),d0
	and.l	#$20,d0
	beq.b	L251
L250
;		return ERR_UNWAKEABLE;
	moveq	#-5,d0
	movem.l	(a7)+,a2/a3/a6
	rts
L251
;	::Signal(&(internal->pr_Task), SIGNAL_WAKE);
	move.l	a2,a0
	move.l	_SysBase,a6
	move.l	#$2000,d0
	move.l	$8(a0),a1
	jsr	-$144(a6)
;	return OK;
	moveq	#0,d0
	movem.l	(a7)+,a2/a3/a6
	rts

	SECTION "setPriority__Threadable__TE:0",CODE


;sint32 Threadable::setPriority(Threadable::Priority p)
	XDEF	setPriority__Threadable__TE
setPriority__Threadable__TE
	movem.l	d2/a2/a3/a6,-(a7)
	move.l	$18(a7),d2
	move.l	$14(a7),a2
L252
;	if (!internal || !(state & SPAWNED))
	move.l	a2,a1
	tst.l	$8(a1)
	beq.b	L254
L253
	move.l	a2,a0
	moveq	#0,d0
	move.w	$12(a0),d0
	and.l	#1,d0
	bne.b	L255
L254
;		return ERR_NOTRUNNING;
	moveq	#-3,d0
	movem.l	(a7)+,d2/a2/a3/a6
	rts
L255
;	else if ((&(internal->pr_Task))==::FindTask(0) && p>PRI_NORMA
	move.l	a2,a0
	move.l	$8(a0),a3
	move.l	_SysBase,a6
	sub.l	a1,a1
	jsr	-$126(a6)
	move.l	a3,a0
	cmp.l	d0,a0
	bne.b	L258
L256
	cmp.l	#5,d2
	ble.b	L258
L257
;		return ERR_VALUE;
	move.l	#-$3010000,d0
	movem.l	(a7)+,d2/a2/a3/a6
	rts
L258
;	priority = p;
	move.l	a2,a0
	move.w	d2,$10(a0)
;	SetTaskPri((&(internal->pr_Task)), priTab[priority]);
	move.l	a2,a0
	move.w	$10(a0),d0
	ext.l	d0
	move.l	#_priTab__Threadable,a1
	move.w	0(a1,d0.l*2),d0
	ext.l	d0
	move.l	a2,a0
	move.l	_SysBase,a6
	move.l	$8(a0),a1
	jsr	-$12C(a6)
;	return OK;
	moveq	#0,d0
	movem.l	(a7)+,d2/a2/a3/a6
	rts

	SECTION "getUptime__Threadable__T:0",CODE


;Time& Threadable::getUptime()
	XDEF	getUptime__Threadable__T
getUptime__Threadable__T
	move.l	4(a7),a0
L259
;	if (!internal || !(state & SPAWNED))
	tst.l	$8(a0)
	beq.b	L261
L260
	moveq	#0,d0
	move.w	$12(a0),d0
	and.l	#1,d0
	bne.b	L262
L261
;		return uptime.last();
	lea	$2C(a0),a0
	moveq	#$8,d0
	add.l	a0,d0
	rts
L262
;	return uptime.elapsed();
	pea	$2C(a0)
	jsr	elapsed__Clock__T
	addq.w	#4,a7
	rts

	SECTION "tryLock__Lockable__T:0",CODE


;sint32 Lockable::tryLock()
	XDEF	tryLock__Lockable__T
tryLock__Lockable__T
	move.l	a6,-(a7)
	move.l	$8(a7),a0
L263
;	if (destructor)
	tst.l	$32(a0)
	beq.b	L265
L264
;		return DESTROYED;
	moveq	#-3,d0
	move.l	(a7)+,a6
	rts
L265
;	return ::AttemptSemaphore(&lock)!=0 ? OK : ALREADYLOCKED;
	move.l	_SysBase,a6
	jsr	-$240(a6)
	tst.l	d0
	beq.b	L267
L266
	moveq	#0,d0
	bra.b	L268
L267
	moveq	#-1,d0
L268
	move.l	(a7)+,a6
	rts

	SECTION "waitLock__Lockable__T:0",CODE


;sint32 Lockable::waitLock()
	XDEF	waitLock__Lockable__T
waitLock__Lockable__T
	movem.l	a2/a6,-(a7)
	move.l	$C(a7),a2
L269
;	if (destructor)
	move.l	a2,a1
	tst.l	$32(a1)
	beq.b	L271
L270
;		return DESTROYED;
	moveq	#-3,d0
	movem.l	(a7)+,a2/a6
	rts
L271
;	::ObtainSemaphore(&lock);
	move.l	_SysBase,a6
	move.l	a2,a0
	jsr	-$234(a6)
;	if (destructor)
	move.l	a2,a1
	tst.l	$32(a1)
	beq.b	L273
L272
;		return DESTROYED;
	moveq	#-3,d0
	movem.l	(a7)+,a2/a6
	rts
L273
;	return OK;
	moveq	#0,d0
	movem.l	(a7)+,a2/a6
	rts

	SECTION "tryReadOnlyLock__Lockable__T:0",CODE


;sint32 Lockable::tryReadOnlyLock()
	XDEF	tryReadOnlyLock__Lockable__T
tryReadOnlyLock__Lockable__T
	move.l	a6,-(a7)
	move.l	$8(a7),a0
L274
;	if (destructor)
	tst.l	$32(a0)
	beq.b	L276
L275
;		return DESTROYED;
	moveq	#-3,d0
	move.l	(a7)+,a6
	rts
L276
;	return ::AttemptSemaphoreShared(&lock)!=0 ? OK : ALREADYLOCKED;
	move.l	_SysBase,a6
	jsr	-$2D0(a6)
	tst.l	d0
	beq.b	L278
L277
	moveq	#0,d0
	bra.b	L279
L278
	moveq	#-1,d0
L279
	move.l	(a7)+,a6
	rts

	SECTION "waitReadOnlyLock__Lockable__T:0",CODE


;sint32 Lockable::waitReadOnlyLock()
	XDEF	waitReadOnlyLock__Lockable__T
waitReadOnlyLock__Lockable__T
	movem.l	a2/a6,-(a7)
	move.l	$C(a7),a2
L280
;	if (destructor)
	move.l	a2,a1
	tst.l	$32(a1)
	beq.b	L282
L281
;		return DESTROYED;
	moveq	#-3,d0
	movem.l	(a7)+,a2/a6
	rts
L282
;	::ObtainSemaphoreShared(&lock);
	move.l	_SysBase,a6
	move.l	a2,a0
	jsr	-$2A6(a6)
;	if (destructor)
	move.l	a2,a1
	tst.l	$32(a1)
	beq.b	L284
L283
;		return DESTROYED;
	moveq	#-3,d0
	movem.l	(a7)+,a2/a6
	rts
L284
;	return OK;
	moveq	#0,d0
	movem.l	(a7)+,a2/a6
	rts

	SECTION "pending__Lockable__T:0",CODE


;sint32 Lockable::pending()
	XDEF	pending__Lockable__T
pending__Lockable__T
	move.l	4(a7),a0
L285
;	if (destructor)
	tst.l	$32(a0)
	beq.b	L287
L286
;		return DESTROYED;
	moveq	#-3,d0
	rts
L287
;	return lock.ss_NestCount - lock.ss_QueueCount - 1;
	move.w	$E(a0),d0
	ext.l	d0
	move.w	$2C(a0),d1
	ext.l	d1
	sub.l	d1,d0
	subq.l	#1,d0
	rts

	SECTION "freeLock__Lockable__T:0",CODE


;void Lockable::freeLock()
	XDEF	freeLock__Lockable__T
freeLock__Lockable__T
	move.l	a6,-(a7)
	move.l	$8(a7),a0
L288
;	if (!destructor && lock.ss_NestCount>0)
	tst.l	$32(a0)
	bne.b	L291
L289
	move.w	$E(a0),d0
	cmp.w	#0,d0
	ble.b	L291
L290
;		::ReleaseSemaphore(&lock);
	move.l	_SysBase,a6
	jsr	-$23A(a6)
L291
	move.l	(a7)+,a6
	rts

	SECTION "active__Lockable__T:0",CODE


;sint32 Lockable::active()
	XDEF	active__Lockable__T
active__Lockable__T
	move.l	4(a7),a1
L292
;	if (destructor)
	tst.l	$32(a1)
	beq.b	L294
L293
;		return DESTROYED;
	moveq	#-3,d0
	rts
L294
;	return lock.ss_NestCount;
	move.w	$E(a1),d0
	ext.l	d0
	rts

	SECTION "getExclusiveOwner__Lockable__T:0",CODE


;Threadable* Lockable::getExclusiveOwner()
	XDEF	getExclusiveOwner__Lockable__T
getExclusiveOwner__Lockable__T
	move.l	4(a7),a0
L295
;	if (lock.ss_Owner==Threadable::rootThread)
	move.l	$28(a0),a1
	cmp.l	_rootThread__Threadable,a1
	bne.b	L297
L296
;		return Thread::getMain();
	jsr	getMain__Thread_
	rts
L297
;	else if (lock.ss_Owner)
	tst.l	$28(a0)
	beq.b	L301
L298
;		Threadable* thread = (Threadable*)(lock.ss_Owner->tc_U
	move.l	$28(a0),a0
	move.l	$58(a0),a0
;		if (thread && thread->classID == Threadable::IDTAG)
	cmp.w	#0,a0
	beq.b	L301
L299
	move.l	(a0),d0
	cmp.l	#$58534C54,d0
	bne.b	L301
L300
;			return thread;
	move.l	a0,d0
	rts
L301
;	return 0;
	moveq	#0,d0
	rts

	SECTION "_0ct__Lockable__T:0",CODE


;Lockable::Lockable() 
	XDEF	_0ct__Lockable__T
_0ct__Lockable__T
	movem.l	a2/a6,-(a7)
	move.l	$C(a7),a2
L302
	move.l	a2,a1
	clr.l	$32(a1)
;	creator = ::FindTask(0);
	move.l	_SysBase,a6
	sub.l	a1,a1
	jsr	-$126(a6)
	move.l	a2,a1
	move.l	d0,$2E(a1)
;	::InitSemaphore(&lock);
	move.l	_SysBase,a6
	move.l	a2,a0
	jsr	-$22E(a6)
	movem.l	(a7)+,a2/a6
	rts

	SECTION "_0dt__Lockable__T:0",CODE


;Lockable::~Lockable()
	XDEF	_0dt__Lockable__T
_0dt__Lockable__T
	movem.l	a2/a6,-(a7)
	move.l	$C(a7),a2
L303
;	if (!destructor)
	move.l	a2,a1
	tst.l	$32(a1)
	bne.b	L307
L304
;		destructor = ::FindTask(0);
	move.l	_SysBase,a6
	sub.l	a1,a1
	jsr	-$126(a6)
	move.l	a2,a1
	move.l	d0,$32(a1)
;		::ObtainSemaphore(&lock);
	move.l	_SysBase,a6
	move.l	a2,a0
	jsr	-$234(a6)
;		while (lock.ss_NestCount)
	bra.b	L306
L305
;			::ReleaseSemaphore(&lock);
	move.l	_SysBase,a6
	move.l	a2,a0
	jsr	-$23A(a6)
L306
	move.l	a2,a0
	tst.w	$E(a0)
	bne.b	L305
L307
	movem.l	(a7)+,a2/a6
	rts

	SECTION "run__MainThread__T:0",CODE

	CNOP	0,2

	XDEF	run__MainThread__T
run__MainThread__T
L308
	moveq	#-2,d0
	rts

	SECTION "_0virttab__10MainThread__10MainThread:0",CODE

	XDEF	_0virttab__10MainThread__10MainThread
_0virttab__10MainThread__10MainThread
	dc.l	$50,0
	dc.l	_0dt__MainThread__T,0
	dc.l	run__MainThread__T,0
	dc.l	$50,0
	dc.l	_0dt__MainThread__T,0
	dc.l	run__MainThread__T,0

	END
