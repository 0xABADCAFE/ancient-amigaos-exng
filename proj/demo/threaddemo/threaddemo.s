#NO_APP
.text
LC0:
	.ascii "bad_alloc\0"
	.even
.globl _init__7AppBase
_init__7AppBase:
	pea a5@
	movel sp,a5
	clrl d0
	unlk a5
	rts
	.even
.globl _done__7AppBase
_done__7AppBase:
	pea a5@
	movel sp,a5
	unlk a5
	rts
	.even
.globl _createApplicationInstance__7AppBase
_createApplicationInstance__7AppBase:
	link a5,#-60
	fmovem #0xfc,sp@-
	moveml #0x3f3a,sp@-
	jbsr ___get_eh_context
	movel d0,a5@(-56)
	pea 92:w
	jbsr ___builtin_new
	movel d0,a5@(-52)
	movel a5@(-56),a0
	addql #4,a0
	movel a0@,a5@(-24)
	clrl a5@(-20)
	movel a5,a5@(-16)
	movel #L340,a5@(-12)
	movel sp,a5@(-8)
	movel a0,a5@(-60)
	jra L339
	.even
L340:
	movel a5@(-56),a0
	addql #4,a0
	movel a0,a5@(-60)
	jra L337
	.even
L339:
	lea a5@(-24),a1
	movel a1,a0@
	movel a5@(-52),sp@-
	jbsr ___13ThreadDemoApp
	movel a5@(-60),a1
	movel a1@,a0
	movel a0@,a1@
	jra L351
	.even
L337:
	movel a5@(-60),a0
	movel a0@,a5@(-48)
	clrl a5@(-44)
	movel a5,a5@(-40)
	movel #L346,a5@(-36)
	movel sp,a5@(-32)
	jra L345
	.even
L346:
	jra L352
	.even
L345:
	lea a5@(-48),a0
	movel a5@(-60),a1
	movel a0,a1@
	moveq #1,d0
	jeq L348
	movel a5@(-52),sp@-
	jbsr ___builtin_delete
	addql #4,sp
L348:
	movel a5@(-56),a1
	addql #4,a1
	movel a1@,a0
	movel a0@,a1@
	jbsr ___sjthrow
	.even
L352:
L343:
	jbsr ___terminate
	.even
L351:
	moveml a5@(-172),#0x5cfc
	fmovem a5@(-132),#0x3f
	unlk a5
	rts
	.even
.globl _destroyApplicationInstance__7AppBaseP7AppBase
_destroyApplicationInstance__7AppBaseP7AppBase:
	pea a5@
	movel sp,a5
	movel a5@(8),a1
	tstl a1
	jeq L355
	movel a1@,a0
	pea 3:w
	movel a1,sp@-
	movel a0@(20),a0
	jbsr a0@
L355:
	unlk a5
	rts
	.even
.globl ___13ThreadDemoApp
___13ThreadDemoApp:
	link a5,#-216
	fmovem #0xfc,sp@-
	moveml #0x3f3a,sp@-
	jbsr ___get_eh_context
	movel d0,a5@(-196)
	movel d0,a5@(-206)
	movel a5@(8),a0
	movel #___vt_7AppBase,a0@
	movel a5@(-196),a0
	addql #4,a0
	movel a0@,a5@(-24)
	clrl a5@(-20)
	movel a5,a5@(-16)
	movel #L364,a5@(-12)
	movel sp,a5@(-8)
	jra L363
	.even
L364:
	jra L411
	.even
L363:
	lea a5@(-24),a1
	movel a1,a0@
	movel a5@(8),d0
	addql #4,d0
	movel d0,sp@-
	movel d0,a5@(-210)
	movel a5@(-206),a0
	addql #4,a0
	movel a0,a5@(-214)
	jbsr ___8Threaded
	movel a5@(-214),a0
	movel a0@,a5@(-48)
	clrl a5@(-44)
	movel a5,a5@(-40)
	movel #L368,a5@(-36)
	movel sp,a5@(-32)
	jra L367
	.even
L368:
	jra L412
	.even
L367:
	lea a5@(-48),a1
	movel a1,a0@
	movel a5@(8),a0
	movel #___vt_13ThreadDemoApp$8Threaded,a0@(4)
	movel #___vt_13ThreadDemoApp,a0@
	clrl a0@(84)
	clrl a0@(88)
	movel #_nothrow,sp@
	pea 12:w
	jbsr ___nw__FUlRC9nothrow_t
	movel d0,a5@(-200)
	movel a5@(-214),a1
	movel a1@,a5@(-72)
	clrl a5@(-68)
	movel a5,a5@(-64)
	movel #L372,a5@(-60)
	movel sp,a5@(-56)
	jra L371
	.even
L372:
	jra L413
	.even
L371:
	moveq #-72,d1
	addl a5,d1
	movel a5@(-214),a0
	movel d1,a0@
	addql #8,sp
	movel a5@(-206),d0
	movel a5@(-200),a1
	movel #___vt_7Console,a1@
	movel d0,a0
	addql #4,a0
	movel a0@,a5@(-96)
	clrl a5@(-92)
	movel d1,a5@(-88)
	movel #L377,a5@(-84)
	movel sp,a5@(-80)
L377:
	lea a5@(-96),a1
	movel a1,a0@
	movel a5@(-200),a0
	movel #___vt_13SystemConsole,a0@
	clrl a0@(4)
	clrl a0@(8)
	movel a5@(-196),a1
	addql #4,a1
	movel a1@,a0
	movel a0@,a1@
	movel a5@(8),a1
	movel a5@(-200),a1@(84)
	movel a5@(-214),a1
	movel a1@,a0
	movel a0@,a1@
	movel a1@,a0
	movel a0@,a1@
	movel a1@,a0
	movel a0@,a1@
	movel a5@(8),d0
	jra L410
	.even
L413:
L369:
	movel a5@(-214),a0
	movel a0@,a5@(-144)
	clrl a5@(-140)
	lea a5@(-136),a0
	movel a5,a0@
	movel #L394,a0@(4)
	movel sp,a5@(-128)
	jra L393
	.even
L394:
	jra L414
	.even
L393:
	lea a5@(-144),a0
	movel a5@(-214),a1
	movel a0,a1@
	tstb a5@(-201)
	jeq L396
	pea _nothrow
	movel a5@(-200),sp@-
	jbsr ___dl__FPvRC9nothrow_t
	addql #8,sp
L396:
	movel a5@(-214),a1
	movel a1@,a0
	movel a0@,a1@
	jbsr ___sjthrow
	.even
L412:
L365:
	movel a5@(-214),a0
	movel a0@,a5@(-168)
	clrl a5@(-164)
	lea a5@(-160),a0
	movel a5,a0@
	movel #L400,a0@(4)
	movel sp,a0@(8)
	jra L399
	.even
L400:
	jra L415
	.even
L399:
	lea a5@(-168),a0
	movel a5@(-214),a1
	movel a0,a1@
	clrl sp@-
	movel a5@(-210),sp@-
	jbsr __$_8Threaded
	movel a5@(-214),a1
	movel a1@,a0
	movel a0@,a1@
	addql #8,sp
	jbsr ___sjthrow
	.even
L411:
L361:
	movel a5@(-214),a0
	movel a0@,a5@(-192)
	clrl a5@(-188)
	lea a5@(-184),a0
	movel a5,a0@
	movel #L404,a0@(4)
	movel sp,a0@(8)
	jra L403
	.even
L404:
	jra L416
	.even
L403:
	lea a5@(-192),a0
	movel a5@(-214),a1
	movel a0,a1@
	movel a5@(8),a1
	movel #___vt_7AppBase,a1@
	movel a5@(-214),a1
	movel a1@,a0
	movel a0@,a1@
	jbsr ___sjthrow
	.even
L414:
L391:
	jbsr ___terminate
	.even
L415:
L397:
	jbsr ___terminate
	.even
L416:
L401:
	jbsr ___terminate
	.even
L410:
	moveml a5@(-328),#0x5cfc
	fmovem a5@(-288),#0x3f
	unlk a5
	rts
	.even
.globl __$_13ThreadDemoApp
__$_13ThreadDemoApp:
	pea a5@
	movel sp,a5
	movel a3,sp@-
	movel a2,sp@-
	movel a5@(8),a3
	movel #___vt_13ThreadDemoApp$8Threaded,a3@(4)
	movel a3,a2
	movel #___vt_13ThreadDemoApp,a2@+
	movel a2,sp@-
	jbsr _stop__8Threaded
	addql #4,sp
	movel a3@(84),a1
	tstl a1
	jeq L420
	movel a1@,a0
	pea 3:w
	movel a1,sp@-
	movel a0@(32),a0
	jbsr a0@
	addql #8,sp
L420:
	clrl sp@-
	movel a2,sp@-
	jbsr __$_8Threaded
	addql #8,sp
	movel #___vt_7AppBase,a3@
	movel a5@(12),d0
	btst #0,d0
	jeq L424
	movel a3,sp@-
	jbsr ___builtin_delete
L424:
	movel a5@(-8),a2
	movel a5@(-4),a3
	unlk a5
	rts
LC1:
	.ascii "Unable to create console\0"
LC2:
	.ascii "Exit\0"
LC3:
	.ascii "Error\0"
LC4:
	.ascii "Thread Demo\0"
LC5:
	.ascii "Unable to open console\0"
	.even
.globl _initApplication__13ThreadDemoApp
_initApplication__13ThreadDemoApp:
	pea a5@
	movel sp,a5
	movel a5@(8),a0
	movel a0@(84),a1
	tstl a1
	jne L426
	pea LC1
	pea LC2
	pea LC3
	jbsr _dialogueBox__9SystemLibPCcN21e
	movel #-50659333,d0
	jra L428
	.even
L426:
	movel a1@,a0
	pea LC4
	movel a1,sp@-
	movel a0@(8),a0
	jbsr a0@
	addql #8,sp
	tstl d0
	jne L427
	clrl d0
	jra L428
	.even
L427:
	pea LC5
	pea LC2
	pea LC3
	jbsr _dialogueBox__9SystemLibPCcN21e
	movel #-50593803,d0
L428:
	unlk a5
	rts
LC6:
	.ascii "Chose method\12"
	.ascii "1 start()\12"
	.ascii "2 stop()\12"
	.ascii "3 wake()\12"
	.ascii "4 getUpTime()\12"
	.ascii "5 Quit\0"
LC7:
	.ascii "Couldn't start()\0"
LC8:
	.ascii "Couldn't stop()\0"
LC9:
	.ascii "Couldn't wake()\0"
LC10:
	.ascii "Uptime:%3lu days %02lu hours %02lu mins %02lu secs %03lu millis\12\0"
	.even
.globl _runApplication__13ThreadDemoApp
_runApplication__13ThreadDemoApp:
	pea a5@
	movel sp,a5
	moveml #0x203a,sp@-
	movel a5@(8),a3
	pea LC6
	lea _puts,a2
	jbsr a2@
	clrb d2
	addql #4,sp
	movel a2,a4
	lea _getchar,a6
	.even
L432:
	jbsr a6@
	moveq #-49,d1
	addl d1,d0
	moveq #4,d1
	cmpl d0,d1
	jcs L430
LI452:
	movew pc@(L452-LI452-2:b,d0:l:2),d0
	jmp pc@(2,d0:w)
	.even
L452:
	.word L434-L452
	.word L436-L452
	.word L438-L452
	.word L440-L452
	.word L450-L452
	.even
L434:
	pea 4096:w
	clrl sp@-
	clrl sp@-
	pea a3@(4)
	jbsr _start__8ThreadedPCcQ28Threaded8PriorityUl
	addw #16,sp
	tstl d0
	jeq L430
	pea LC7
	jra L455
	.even
L436:
	pea a3@(4)
	jbsr _stop__8Threaded
	addql #4,sp
	tstl d0
	jeq L430
	pea LC8
	jra L455
	.even
L438:
	pea a3@(4)
	jbsr _wake__8Threaded
	addql #4,sp
	tstl d0
	jeq L430
	pea LC9
L455:
	jbsr a4@
	addql #4,sp
	jra L430
	.even
L440:
	pea a3@(4)
	jbsr _getUptime__8Threaded
	movel d0,a2
	addql #4,sp
	pea 1000:w
	clrl sp@-
	movel a2@(4),sp@-
	movel a2@,sp@-
	jbsr ___moddi3
	addw #12,sp
	movel d1,sp@
	pea 1000:w
	clrl sp@-
	movel a2@(4),sp@-
	movel a2@,sp@-
	jbsr ___divdi3
	addw #16,sp
	pea 60:w
	clrl sp@-
	movel d1,sp@-
	movel d0,sp@-
	jbsr ___moddi3
	addw #12,sp
	movel d1,sp@
	movel #60000,sp@-
	clrl sp@-
	movel a2@(4),sp@-
	movel a2@,sp@-
	jbsr ___divdi3
	addw #16,sp
	pea 60:w
	clrl sp@-
	movel d1,sp@-
	movel d0,sp@-
	jbsr ___moddi3
	addw #12,sp
	movel d1,sp@
	movel #3600000,sp@-
	clrl sp@-
	movel a2@(4),sp@-
	movel a2@,sp@-
	jbsr ___divdi3
	addw #16,sp
	pea 24:w
	clrl sp@-
	movel d1,sp@-
	movel d0,sp@-
	jbsr ___moddi3
	addw #12,sp
	movel d1,sp@
	movel #86400000,sp@-
	clrl sp@-
	movel a2@(4),sp@-
	movel a2@,sp@-
	jbsr ___divdi3
	addw #12,sp
	movel d1,sp@
	pea LC10
	jbsr _printf
	addw #24,sp
	jra L430
	.even
L450:
	moveq #1,d2
L430:
	tstb d2
	jeq L432
	clrl d0
	moveml a5@(-20),#0x5c04
	unlk a5
	rts
LC11:
	.ascii "Hello World from the run() method!\12This thread increments a counter value\12belonging to the derived object once\12every 2 seconds.\12\12\0"
LC12:
	.ascii "counter = %d\12\0"
LC13:
	.ascii "sleep() interrupted by wake()\12\0"
LC14:
	.ascii "sleep() interrupted by stop()\12\0"
LC15:
	.ascii "sleep() interrupted by CTRL_C\12\0"
LC16:
	.ascii "sleep() interrupted by unknown\12\0"
LC17:
	.ascii "\12Well, my work is done here...Adios!\12\12\0"
	.even
.globl _run__13ThreadDemoApp
_run__13ThreadDemoApp:
	pea a5@
	movel sp,a5
	movel a3,sp@-
	movel a2,sp@-
	movel a5@(8),a2
	movel a2@(84),a0
	movel a0@,a1
	pea LC11
	movel a0,sp@-
	movel a1@(16),a0
	jbsr a0@
	addql #8,sp
	lea a2@(4),a0
	btst #3,a0@(23)
	jne L471
	movel a0,a3
	.even
L459:
	movel a2@(84),a0
	movel a0@,a1
	movel a2@(88),sp@-
	addql #1,a2@(88)
	pea LC12
	movel a0,sp@-
	movel a1@(16),a0
	jbsr a0@
	addw #12,sp
	subql #2,sp
	moveb #1,sp@(1)
	subql #2,sp
	subql #2,sp
	moveb #0,sp@(1)
	subql #2,sp
	subql #2,sp
	moveb #0,sp@(1)
	subql #2,sp
	pea 2000:w
	pea a2@(4)
	jbsr _sleep__8ThreadedUlbN22
	addw #20,sp
	moveq #1,d1
	cmpl d0,d1
	jeq L463
	jlt L468
	tstl d0
	jeq L464
	jra L466
	.even
L468:
	moveq #2,d1
	cmpl d0,d1
	jeq L465
	moveq #4,d1
	cmpl d0,d1
	jne L466
	jra L457
	.even
L463:
	movel a2@(84),a0
	movel a0@,a1
	pea LC13
	jra L472
	.even
L464:
	movel a2@(84),a0
	movel a0@,a1
	pea LC14
	jra L472
	.even
L465:
	movel a2@(84),a0
	movel a0@,a1
	pea LC15
	jra L472
	.even
L466:
	movel a2@(84),a0
	movel a0@,a1
	pea LC16
L472:
	movel a0,sp@-
	movel a1@(16),a0
	jbsr a0@
	addql #8,sp
L457:
	btst #3,a3@(23)
	jeq L459
L471:
	movel a2@(84),a0
	movel a0@,a1
	pea LC17
	movel a0,sp@-
	movel a1@(16),a0
	jbsr a0@
	clrl d0
	movel a5@(-8),a2
	movel a5@(-4),a3
	unlk a5
	rts
.globl ___vt_13ThreadDemoApp
	.even
___vt_13ThreadDemoApp:
	.long 0
	.long 0
	.long _initApplication__13ThreadDemoApp
	.long _doneApplication__7AppBase
	.long _runApplication__13ThreadDemoApp
	.long __$_13ThreadDemoApp
	.skip 4
	.even
___thunk_4_run__13ThreadDemoApp:
	pea a5@
	movel sp,a5
	movel a5@(8),d0
	subql #4,d0
	movel d0,sp@-
	jbsr _run__13ThreadDemoApp
	unlk a5
	rts
	.even
___thunk_4__$_13ThreadDemoApp:
	pea a5@
	movel sp,a5
	movel a5@(12),sp@-
	movel a5@(8),d0
	subql #4,d0
	movel d0,sp@-
	jbsr __$_13ThreadDemoApp
	unlk a5
	rts
.globl ___vt_13ThreadDemoApp$8Threaded
	.even
___vt_13ThreadDemoApp$8Threaded:
	.long -4
	.long 0
	.long ___thunk_4_run__13ThreadDemoApp
	.long ___thunk_4__$_13ThreadDemoApp
	.skip 4
	.even
___vt_7Console:
	.long 0
	.long 0
	.long ___pure_virtual
	.long ___pure_virtual
	.long ___pure_virtual
	.long ___pure_virtual
	.long ___pure_virtual
	.long ___pure_virtual
	.long __$_7Console
	.skip 4
	.even
___vt_7AppBase:
	.long 0
	.long 0
	.long _initApplication__7AppBase
	.long _doneApplication__7AppBase
	.long ___pure_virtual
	.long __$_7AppBase
	.skip 4
	.even
_initApplication__7AppBase:
	pea a5@
	movel sp,a5
	clrl d0
	unlk a5
	rts
	.even
_doneApplication__7AppBase:
	pea a5@
	movel sp,a5
	unlk a5
	rts
	.even
__$_7AppBase:
	pea a5@
	movel sp,a5
	movel a5@(8),a0
	movel #___vt_7AppBase,a0@
	btst #0,a5@(15)
	jeq L21
	movel a0,sp@-
	jbsr ___builtin_delete
L21:
	unlk a5
	rts
	.even
__$_7Console:
	pea a5@
	movel sp,a5
	movel a5@(8),a0
	movel #___vt_7Console,a0@
	btst #0,a5@(15)
	jeq L244
	movel a0,sp@-
	jbsr ___builtin_delete
L244:
	unlk a5
	rts
