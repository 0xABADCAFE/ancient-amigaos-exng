#NO_APP
.text
LC0:
	.ascii "bad_alloc\0"
	.even
.globl _init__7AppBase
_init__7AppBase:
	pea a5@
	movel sp,a5
	jbsr _init__6GfxLib
	unlk a5
	rts
	.even
.globl _done__7AppBase
_done__7AppBase:
	pea a5@
	movel sp,a5
	jbsr _done__6GfxLib
	unlk a5
	rts
	.even
.globl _createApplicationInstance__7AppBase
_createApplicationInstance__7AppBase:
	pea a5@
	movel sp,a5
	pea _nothrow
	pea 78:w
	jbsr ___nw__FUlRC9nothrow_t
	movel d0,sp@-
	jbsr ___9EngineApp
	unlk a5
	rts
	.even
.globl _destroyApplicationInstance__7AppBaseP7AppBase
_destroyApplicationInstance__7AppBaseP7AppBase:
	pea a5@
	movel sp,a5
	movel a5@(8),a1
	tstl a1
	jeq L1375
	movel a1@,a0
	pea 3:w
	movel a1,sp@-
	movel a0@(20),a0
	jbsr a0@
L1375:
	unlk a5
	rts
LC1:
	.ascii "width\0"
LC2:
	.ascii "height\0"
	.even
.globl ___9EngineApp
___9EngineApp:
	pea a5@
	movel sp,a5
	movel a3,sp@-
	movel a2,sp@-
	movel a5@(8),a3
	movel a3,a0
	movel #___vt_7AppBase,a0@+
	pea 16499:w
	movel a0,sp@-
	jbsr ___10InputFocusUl
	movel #___vt_9EngineApp$10InputFocus,a3@(40)
	movel #___vt_9EngineApp,a3@
	clrl a3@(44)
	clrl a3@(48)
	clrl a3@(52)
	clrl a3@(56)
	clrl a3@(60)
	clrl a3@(64)
	movel #0x42b40000,a3@(68)
	clrb a3@(76)
	addql #8,sp
	subql #2,sp
	moveb #0,sp@(1)
	subql #2,sp
	pea LC1
	lea _getInteger__7AppBasePCcb,a2
	jbsr a2@
	movew d0,a3@(72)
	subql #2,sp
	moveb #0,sp@(1)
	subql #2,sp
	pea LC2
	jbsr a2@
	movew d0,a3@(74)
	addw #16,sp
	tstw a3@(72)
	jeq L1381
	movew a3@(72),a0
	cmpw #320,a0
	jlt L1383
	movel a0,d0
	cmpl #1024,d0
	jle L1382
	movel #1024,d0
	jra L1382
	.even
L1383:
	movel #320,d0
	jra L1382
	.even
L1381:
	movew #640,d0
L1382:
	movew d0,a3@(72)
	tstw a3@(74)
	jeq L1388
	movew a3@(74),a0
	cmpw #240,a0
	jlt L1390
	movel a0,d0
	cmpl #768,d0
	jle L1389
	movel #768,d0
	jra L1389
	.even
L1390:
	moveq #15,d0
	notb d0
	jra L1389
	.even
L1388:
	movew #480,d0
L1389:
	movew d0,a3@(74)
	pea _nothrow
	pea 322:w
	jbsr ___nw__FUlRC9nothrow_t
	movel d0,a2
	addql #8,sp
	movel a2,a0
	movel #___vt_7Display,a0@+
	movel #16499,a0@
	movel #___vt_15InputDispatcher,a0@(24)
	pea a0@(4)
	jbsr ___7_LLBase
	addql #4,sp
	clrl a2@(24)
	movel #___vt_18InteractiveDisplay$15InputDispatcher,a2@(28)
	movel #___vt_18InteractiveDisplay,a2@
	pea a2@(32)
	jbsr ___7_NatWin
	movel #___vt_17InteractiveWindow$15InputDispatcher,a2@(28)
	movel #___vt_17InteractiveWindow,a2@
	addql #4,sp
	movel a2,a3@(44)
	jeq L1410
	clrl sp@-
	subql #2,sp
	moveb #1,sp@(1)
	subql #2,sp
	pea 16384:w
	lea _alloc__3MemUlbQ23Mem9AlignType,a2
	jbsr a2@
	movel d0,a3@(56)
	addw #12,sp
	jeq L1410
	clrl sp@-
	subql #2,sp
	moveb #1,sp@(1)
	subql #2,sp
	movel #1048576,sp@-
	jbsr a2@
	movel d0,a3@(60)
L1410:
	movel a3,d0
	movel a5@(-8),a2
	movel a5@(-4),a3
	unlk a5
	rts
	.even
.globl __$_9EngineApp
__$_9EngineApp:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel a5@(8),a2
	movel #___vt_9EngineApp$10InputFocus,a2@(40)
	movel #___vt_9EngineApp,a2@
	movel a2@(60),d0
	jeq L1414
	movel d0,sp@-
	jbsr _free__3MemPv
	addql #4,sp
L1414:
	movel a2@(56),d0
	jeq L1415
	movel d0,sp@-
	jbsr _free__3MemPv
	addql #4,sp
L1415:
	movel a2@(44),a1
	tstl a1
	jeq L1418
	movel a1@,a0
	pea 3:w
	movel a1,sp@-
	movel a0@(48),a0
	jbsr a0@
	addql #8,sp
L1418:
	movel #___vt_10InputFocus,a2@(40)
	movel #___vt_7AppBase,a2@
	movel a5@(12),d0
	btst #0,d0
	jeq L1426
	movel a2,sp@-
	jbsr ___builtin_delete
L1426:
	movel a5@(-4),a2
	unlk a5
	rts
LC3:
	.ascii "EngineApp::initApplication()\12\0"
LC4:
	.ascii "\11resource allocation failed\12\0"
LC5:
	.ascii "Engine\0"
LC6:
	.ascii "\11couldn't open display\12\0"
LC7:
	.ascii "dimw\0"
LC8:
	.ascii "dimh\0"
LC9:
	.ascii "\11failed to initialise map\12\0"
LC10:
	.ascii "\11failed to obtain view\12\0"
LC11:
	.ascii "Map size : %0.2f x %0.2f\12\0"
	.even
.globl _initApplication__9EngineApp
_initApplication__9EngineApp:
	pea a5@
	movel sp,a5
	moveml #0x2038,sp@-
	movel a5@(8),a3
	pea LC3
	lea _printf,a2
	jbsr a2@
	addql #4,sp
	movel a3@(44),a1
	movel a2,a4
	tstl a1
	jeq L1429
	tstl a3@(56)
	jeq L1429
	tstl a3@(60)
	jne L1428
L1429:
	pea LC4
	jra L1455
	.even
L1428:
	movel a1@,a0
	pea LC5
	pea 15:w
	movew a3@(74),a2
	movel a2,sp@-
	movew a3@(72),a2
	movel a2,sp@-
	movel a1,sp@-
	movel a0@(8),a0
	jbsr a0@
	addw #20,sp
	tstl d0
	jeq L1430
	pea LC6
	jra L1455
	.even
L1430:
	subql #2,sp
	moveb #0,sp@(1)
	subql #2,sp
	pea LC7
	lea _getInteger__7AppBasePCcb,a2
	jbsr a2@
	addql #8,sp
	tstl d0
	jeq L1431
	moveq #4,d1
	cmpl d0,d1
	jgt L1433
	moveq #8,d1
	cmpl d0,d1
	jge L1435
	moveq #8,d0
	jra L1435
	.even
L1433:
	moveq #4,d0
L1435:
	movew d0,d2
	jra L1432
	.even
L1431:
	moveq #8,d2
L1432:
	subql #2,sp
	moveb #0,sp@(1)
	subql #2,sp
	pea LC8
	jbsr a2@
	addql #8,sp
	tstl d0
	jeq L1438
	moveq #4,d1
	cmpl d0,d1
	jgt L1440
	moveq #8,d1
	cmpl d0,d1
	jge L1439
	moveq #8,d0
	jra L1439
	.even
L1440:
	moveq #4,d0
	jra L1439
	.even
L1438:
	moveq #8,d0
L1439:
	pea 1:w
	movew d0,sp@-
	clrw sp@-
	movew d2,sp@-
	clrw sp@-
	movel #0x40800000,sp@-
	jbsr _init__8WorldMapfUsUsUs
	addw #16,sp
	tstl d0
	jeq L1445
	pea LC9
	jra L1455
	.even
L1445:
	movel #0x42800000,sp@-
	movew a3@(74),a0
	movel a0,sp@-
	movew a3@(72),a2
	movel a2,sp@-
	jbsr _createView__8WorldMapssf
	movel d0,a0
	movel a0,a3@(52)
	addw #12,sp
	jne L1446
	pea LC10
L1455:
	jbsr a4@
	movel #-50659328,d0
	jra L1454
	.even
L1446:
	movel a3@(68),d0
	fmoves a3@(64),fp0
	fmuld #0r0.01745329251994334,fp0
	fmoves fp0,a0@(208)
	fmoves d0,fp0
	fmuld #0r0.01745329251994334,fp0
	fmoves fp0,a0@(212)
	moveb #1,a0@(217)
	moveb #1,a0@(216)
	fmoves __8WorldMap$scaledH,fp0
	fmoved fp0,sp@-
	fmoves __8WorldMap$scaledW,fp0
	fmoved fp0,sp@-
	pea LC11
	jbsr a4@
	movel a3@(44),d0
	addql #4,d0
	lea a3@(4),a2
	addw #20,sp
	tstl a2
	jeq L1453
	movel d0,d2
	addql #4,d2
	movel a2,sp@-
	movel d2,sp@-
	jbsr _contains__C7_LLBasePv
	addql #8,sp
	tstb d0
	jne L1453
	movel a2,sp@-
	movel d2,sp@-
	jbsr _insLast__7_LLBasePv
L1453:
	clrl d0
L1454:
	moveml a5@(-16),#0x1c04
	unlk a5
	rts
	.even
.globl _doneApplication__9EngineApp
_doneApplication__9EngineApp:
	pea a5@
	movel sp,a5
	movel a5@(8),a0
	movel a0@(52),d0
	jeq L1458
	pea 3:w
	movel d0,sp@-
	jbsr __$_9WorldView
	addql #8,sp
L1458:
	jbsr _done__8WorldMap
	unlk a5
	rts
	.even
.globl _runApplication__9EngineApp
_runApplication__9EngineApp:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel a5@(8),a2
	tstb a2@(76)
	jne L1461
	.even
L1462:
	movel a2@(44),a0
	movel a0@(28),a1
	pea a0@(4)
	movel a1@(16),a0
	jbsr a0@
	addql #4,sp
	.even
L1463:
	movel a2@(44),a0
	movel a0@(28),a1
	pea a0@(4)
	movel a1@(20),a0
	jbsr a0@
	addql #4,sp
	tstb d0
	jne L1463
	tstb a2@(76)
	jeq L1462
L1461:
	clrl d0
	movel a5@(-4),a2
	unlk a5
	rts
	.even
.globl _keyPressPrintable__9EngineAppP15InputDispatcherl
_keyPressPrintable__9EngineAppP15InputDispatcherl:
	pea a5@
	movel sp,a5
	unlk a5
	rts
LC12:
	.ascii "Cell ------------\12\0"
LC13:
	.ascii "-----------------\12\0"
LC14:
	.ascii "There were %d visible cells\12\0"
	.even
.globl _keyPressNonPrintable__9EngineAppP15InputDispatcherQ23Key7CtrlKey
_keyPressNonPrintable__9EngineAppP15InputDispatcherQ23Key7CtrlKey:
	pea a5@
	movel sp,a5
	moveml #0x203a,sp@-
	movel a5@(8),a6
	movel a5@(16),d0
	subql #5,d0
	moveq #15,d1
	cmpl d0,d1
	jcs L1472
LI1502:
	movew pc@(L1502-LI1502-2:b,d0:l:2),d0
	jmp pc@(2,d0:w)
	.even
L1502:
	.word L1473-L1502
	.word L1472-L1502
	.word L1478-L1502
	.word L1484-L1502
	.word L1474-L1502
	.word L1476-L1502
	.word L1490-L1502
	.word L1472-L1502
	.word L1472-L1502
	.word L1472-L1502
	.word L1472-L1502
	.word L1472-L1502
	.word L1472-L1502
	.word L1472-L1502
	.word L1497-L1502
	.word L1500-L1502
	.even
L1473:
	moveb #1,a6@(76)
	jra L1472
	.even
L1474:
	fmoves a6@(64),fp0
	faddd #0r5.000000000000005,fp0
	fmoves fp0,d0
	movel d0,a6@(64)
	fmoves d0,fp0
	fcmpd #0r360.0000000000004,fp0
	fjle L1506
	fsubd #0r360.0000000000004,fp0
	fmoves fp0,a6@(64)
	jra L1506
	.even
L1476:
	fmoves a6@(64),fp0
	fsubd #0r5.000000000000005,fp0
	fmoves fp0,d0
	movel d0,a6@(64)
	fmoves d0,fp1
	fjge L1506
	fmoved #0r360.0000000000004,fp0
	fsubx fp1,fp0
	fmoves fp0,a6@(64)
	jra L1506
	.even
L1478:
	fmoves a6@(68),fp0
	faddd #0r5.000000000000005,fp0
	fcmpd #0r10.00000000000005,fp0
	fjge L1526
	jra L1485
	.even
L1484:
	fmoves a6@(68),fp0
	fsubd #0r5.000000000000005,fp0
	fcmpd #0r10.00000000000005,fp0
	fjlt L1485
L1526:
	fcmpd #0r90.00000000000005,fp0
	fjle L1487
	fmoved #0r90.00000000000005,fp0
	jra L1487
	.even
L1485:
	fmoved #0r10.00000000000005,fp0
L1487:
	fmoves fp0,a6@(68)
	jra L1506
	.even
L1490:
	movel a6@(52),a2
	movel a6@(56),d2
	tstb a2@(216)
	jeq L1491
	movel a2,sp@-
	jbsr _projectViewOnMap__9WorldView
	addql #4,sp
L1491:
	pea a2@(160)
	movel d2,sp@-
	jbsr _getAreaOrdered__8WorldMapPP15MapCellInstancePC7Coord2D
	addql #8,sp
	movel a6@(56),a4
	movel d0,d2
	subql #1,d2
	moveq #-1,d0
	cmpl d2,d0
	jeq L1472
	lea _printf,a3
	movel d2,d0
	notl d0
	moveq #3,d1
	andl d1,d0
	jeq L1495
	cmpl d0,d1
	jle L1509
	moveq #2,d1
	cmpl d0,d1
	jle L1510
	pea LC12
	jbsr a3@
	movel a4@+,sp@-
	jbsr _debugPrint__8Vector3D
	pea LC13
	jbsr a3@
	addw #12,sp
	subql #1,d2
L1510:
	pea LC12
	jbsr a3@
	movel a4@+,sp@-
	jbsr _debugPrint__8Vector3D
	pea LC13
	jbsr a3@
	addw #12,sp
	subql #1,d2
L1509:
	pea LC12
	jbsr a3@
	movel a4@+,sp@-
	jbsr _debugPrint__8Vector3D
	pea LC13
	jbsr a3@
	addw #12,sp
	subql #1,d2
	moveq #-1,d0
	cmpl d2,d0
	jeq L1472
	.even
L1495:
	pea LC12
	jbsr a3@
	movel a4,a2
	movel a2@+,sp@-
	jbsr _debugPrint__8Vector3D
	pea LC13
	jbsr a3@
	addqw #8,sp
	movel #LC12,sp@
	jbsr a3@
	movel a2@,sp@-
	lea a4@(8),a2
	jbsr _debugPrint__8Vector3D
	pea LC13
	jbsr a3@
	addqw #8,sp
	movel #LC12,sp@
	jbsr a3@
	movel a2@,sp@-
	lea a4@(12),a2
	jbsr _debugPrint__8Vector3D
	pea LC13
	jbsr a3@
	addqw #8,sp
	movel #LC12,sp@
	jbsr a3@
	movel a2@,sp@-
	addw #16,a4
	jbsr _debugPrint__8Vector3D
	pea LC13
	jbsr a3@
	addw #12,sp
	subql #4,d2
	moveq #-1,d1
	cmpl d2,d1
	jne L1495
	jra L1472
	.even
L1497:
	movel a6@(52),a2
	movel a6@(56),d2
	tstb a2@(216)
	jeq L1498
	movel a2,sp@-
	jbsr _projectViewOnMap__9WorldView
	addql #4,sp
L1498:
	pea a2@(160)
	movel d2,sp@-
	jbsr _getAreaOrdered__8WorldMapPP15MapCellInstancePC7Coord2D
	addqw #4,sp
	movel d0,sp@
	pea LC14
	jbsr _printf
	jra L1472
	.even
L1500:
	movel a6@(52),sp@-
	jbsr _debugPrint__9WorldView
L1472:
	clrb d0
	jeq L1505
L1506:
	movel a6@(52),a0
	movel a6@(68),d0
	fmoves a6@(64),fp0
	fmuld #0r0.01745329251994334,fp0
	fmoves fp0,a0@(208)
	fmoves d0,fp0
	fmuld #0r0.01745329251994334,fp0
	fmoves fp0,a0@(212)
	moveb #1,a0@(217)
	moveb #1,a0@(216)
L1505:
	moveml a5@(-20),#0x5c04
	unlk a5
	rts
	.even
.globl _mousePress__9EngineAppP15InputDispatcherUl
_mousePress__9EngineAppP15InputDispatcherUl:
	pea a5@
	movel sp,a5
	unlk a5
	rts
	.even
.globl _mouseDrag__9EngineAppP15InputDispatcherssssUl
_mouseDrag__9EngineAppP15InputDispatcherssssUl:
	pea a5@
	movel sp,a5
	unlk a5
	rts
	.even
___thunk_4_keyPressNonPrintable__9EngineAppP15InputDispatcherQ23Key7CtrlKey:
	pea a5@
	movel sp,a5
	movel a5@(16),sp@-
	movel a5@(12),sp@-
	movel a5@(8),d0
	subql #4,d0
	movel d0,sp@-
	jbsr _keyPressNonPrintable__9EngineAppP15InputDispatcherQ23Key7CtrlKey
	unlk a5
	rts
	.even
___thunk_4_keyPressPrintable__9EngineAppP15InputDispatcherl:
	pea a5@
	movel sp,a5
	movel a5@(16),sp@-
	movel a5@(12),sp@-
	movel a5@(8),d0
	subql #4,d0
	movel d0,sp@-
	jbsr _keyPressPrintable__9EngineAppP15InputDispatcherl
	unlk a5
	rts
	.even
___thunk_4_mousePress__9EngineAppP15InputDispatcherUl:
	pea a5@
	movel sp,a5
	movel a5@(16),sp@-
	movel a5@(12),sp@-
	movel a5@(8),d0
	subql #4,d0
	movel d0,sp@-
	jbsr _mousePress__9EngineAppP15InputDispatcherUl
	unlk a5
	rts
	.even
___thunk_4_mouseDrag__9EngineAppP15InputDispatcherssssUl:
	pea a5@
	movel sp,a5
	movel a5@(32),sp@-
	movew a5@(30),sp@-
	subql #2,sp
	movew a5@(26),sp@-
	subql #2,sp
	movew a5@(22),sp@-
	subql #2,sp
	movew a5@(18),sp@-
	subql #2,sp
	movel a5@(12),sp@-
	movel a5@(8),d0
	subql #4,d0
	movel d0,sp@-
	jbsr _mouseDrag__9EngineAppP15InputDispatcherssssUl
	unlk a5
	rts
	.even
___thunk_4__$_9EngineApp:
	pea a5@
	movel sp,a5
	movel a5@(12),sp@-
	movel a5@(8),d0
	subql #4,d0
	movel d0,sp@-
	jbsr __$_9EngineApp
	unlk a5
	rts
.globl ___vt_9EngineApp$10InputFocus
	.even
___vt_9EngineApp$10InputFocus:
	.long -4
	.long 0
	.long ___thunk_4_keyPressNonPrintable__9EngineAppP15InputDispatcherQ23Key7CtrlKey
	.long _keyReleaseNonPrintable__10InputFocusP15InputDispatcherQ23Key7CtrlKey
	.long ___thunk_4_keyPressPrintable__9EngineAppP15InputDispatcherl
	.long _keyReleasePrintable__10InputFocusP15InputDispatcherl
	.long ___thunk_4_mousePress__9EngineAppP15InputDispatcherUl
	.long _mouseRelease__10InputFocusP15InputDispatcherUl
	.long _mouseMove__10InputFocusP15InputDispatcherssss
	.long ___thunk_4_mouseDrag__9EngineAppP15InputDispatcherssssUl
	.long _mouseScroll__10InputFocusP15InputDispatcherss
	.long _exitEvent__10InputFocusP15InputDispatcher
	.long ___thunk_4__$_9EngineApp
	.skip 4
.globl ___vt_9EngineApp
	.even
___vt_9EngineApp:
	.long 0
	.long 0
	.long _initApplication__9EngineApp
	.long _doneApplication__9EngineApp
	.long _runApplication__9EngineApp
	.long __$_9EngineApp
	.skip 4
	.even
___thunk_4__$_18InteractiveDisplay:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel d2,sp@-
	movel a5@(8),a0
	movel a5@(12),d2
	lea a0@(-4),a2
	movel #___vt_18InteractiveDisplay$15InputDispatcher,a2@(28)
	movel #___vt_18InteractiveDisplay,a2@
	movel #___vt_15InputDispatcher,a0@(24)
	pea 2:w
	pea a0@(4)
	jbsr __$_7_LLBase
	addql #8,sp
	movel #___vt_7Display,a2@
	btst #0,d2
	jeq L1541
	movel a2,sp@-
	jbsr ___builtin_delete
L1541:
	movel a5@(-8),d2
	movel a5@(-4),a2
	unlk a5
	rts
	.even
___vt_18InteractiveDisplay$15InputDispatcher:
	.long -4
	.long 0
	.long ___pure_virtual
	.long ___pure_virtual
	.long ___pure_virtual
	.long ___pure_virtual
	.long ___pure_virtual
	.long ___thunk_4__$_18InteractiveDisplay
	.skip 4
	.even
___vt_18InteractiveDisplay:
	.long 0
	.long 0
	.long ___pure_virtual
	.long ___pure_virtual
	.long ___pure_virtual
	.long ___pure_virtual
	.long ___pure_virtual
	.long ___pure_virtual
	.long ___pure_virtual
	.long ___pure_virtual
	.long ___pure_virtual
	.long ___pure_virtual
	.long __$_18InteractiveDisplay
	.skip 4
	.even
___vt_10InputFocus:
	.long 0
	.long 0
	.long _keyPressNonPrintable__10InputFocusP15InputDispatcherQ23Key7CtrlKey
	.long _keyReleaseNonPrintable__10InputFocusP15InputDispatcherQ23Key7CtrlKey
	.long _keyPressPrintable__10InputFocusP15InputDispatcherl
	.long _keyReleasePrintable__10InputFocusP15InputDispatcherl
	.long _mousePress__10InputFocusP15InputDispatcherUl
	.long _mouseRelease__10InputFocusP15InputDispatcherUl
	.long _mouseMove__10InputFocusP15InputDispatcherssss
	.long _mouseDrag__10InputFocusP15InputDispatcherssssUl
	.long _mouseScroll__10InputFocusP15InputDispatcherss
	.long _exitEvent__10InputFocusP15InputDispatcher
	.long __$_10InputFocus
	.skip 4
	.even
___vt_15InputDispatcher:
	.long 0
	.long 0
	.long ___pure_virtual
	.long ___pure_virtual
	.long ___pure_virtual
	.long ___pure_virtual
	.long ___pure_virtual
	.long __$_15InputDispatcher
	.skip 4
	.even
___vt_7Display:
	.long 0
	.long 0
	.long ___pure_virtual
	.long ___pure_virtual
	.long ___pure_virtual
	.long ___pure_virtual
	.long ___pure_virtual
	.long ___pure_virtual
	.long ___pure_virtual
	.long ___pure_virtual
	.long ___pure_virtual
	.long ___pure_virtual
	.long __$_7Display
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
__$_7Display:
	pea a5@
	movel sp,a5
	movel a5@(8),a0
	movel #___vt_7Display,a0@
	btst #0,a5@(15)
	jeq L206
	movel a0,sp@-
	jbsr ___builtin_delete
L206:
	unlk a5
	rts
	.even
__$_15InputDispatcher:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel d2,sp@-
	movel a5@(8),a2
	movel a5@(12),d2
	movel #___vt_15InputDispatcher,a2@(24)
	pea 2:w
	pea a2@(4)
	jbsr __$_7_LLBase
	addql #8,sp
	btst #0,d2
	jeq L436
	movel a2,sp@-
	jbsr ___builtin_delete
L436:
	movel a5@(-8),d2
	movel a5@(-4),a2
	unlk a5
	rts
	.even
_keyPressNonPrintable__10InputFocusP15InputDispatcherQ23Key7CtrlKey:
	pea a5@
	movel sp,a5
	unlk a5
	rts
	.even
_keyReleaseNonPrintable__10InputFocusP15InputDispatcherQ23Key7CtrlKey:
	pea a5@
	movel sp,a5
	unlk a5
	rts
	.even
_keyPressPrintable__10InputFocusP15InputDispatcherl:
	pea a5@
	movel sp,a5
	unlk a5
	rts
	.even
_keyReleasePrintable__10InputFocusP15InputDispatcherl:
	pea a5@
	movel sp,a5
	unlk a5
	rts
	.even
_mousePress__10InputFocusP15InputDispatcherUl:
	pea a5@
	movel sp,a5
	unlk a5
	rts
	.even
_mouseRelease__10InputFocusP15InputDispatcherUl:
	pea a5@
	movel sp,a5
	unlk a5
	rts
	.even
_mouseMove__10InputFocusP15InputDispatcherssss:
	pea a5@
	movel sp,a5
	unlk a5
	rts
	.even
_mouseDrag__10InputFocusP15InputDispatcherssssUl:
	pea a5@
	movel sp,a5
	unlk a5
	rts
	.even
_mouseScroll__10InputFocusP15InputDispatcherss:
	pea a5@
	movel sp,a5
	unlk a5
	rts
	.even
_exitEvent__10InputFocusP15InputDispatcher:
	pea a5@
	movel sp,a5
	unlk a5
	rts
	.even
__$_10InputFocus:
	pea a5@
	movel sp,a5
	movel a5@(8),a0
	movel #___vt_10InputFocus,a0@(36)
	btst #0,a5@(15)
	jeq L469
	movel a0,sp@-
	jbsr ___builtin_delete
L469:
	unlk a5
	rts
	.even
__$_18InteractiveDisplay:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel d2,sp@-
	movel a5@(8),a2
	movel a5@(12),d2
	movel #___vt_18InteractiveDisplay$15InputDispatcher,a2@(28)
	movel a2,a0
	movel #___vt_18InteractiveDisplay,a0@+
	movel #___vt_15InputDispatcher,a0@(24)
	pea 2:w
	pea a0@(4)
	jbsr __$_7_LLBase
	addql #8,sp
	movel #___vt_7Display,a2@
	btst #0,d2
	jeq L733
	movel a2,sp@-
	jbsr ___builtin_delete
L733:
	movel a5@(-8),d2
	movel a5@(-4),a2
	unlk a5
	rts
