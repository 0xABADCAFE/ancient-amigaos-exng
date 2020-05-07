#NO_APP
.text
	.even
.globl _enableIFilter__7IFilterUl
_enableIFilter__7IFilterUl:
	pea a5@
	movel sp,a5
	movel a5@(8),a0
	movel a0@,d0
	movel d0,d1
	orl a5@(12),d1
	movel d1,a0@
	unlk a5
	rts
	.even
.globl _disableIFilter__7IFilterUl
_disableIFilter__7IFilterUl:
	pea a5@
	movel sp,a5
	movel a5@(8),a0
	movel a0@,d0
	movel a5@(12),d1
	notl d1
	andl d0,d1
	movel d1,a0@
	unlk a5
	rts
	.even
.globl _toggleIFilter__7IFilterUl
_toggleIFilter__7IFilterUl:
	pea a5@
	movel sp,a5
	movel a5@(8),a0
	movel a0@,d0
	movel a5@(12),d1
	eorl d0,d1
	movel d1,a0@
	unlk a5
	rts
	.even
.globl _setIFilter__7IFilterUl
_setIFilter__7IFilterUl:
	pea a5@
	movel sp,a5
	movel a5@(8),a0
	movel a0@,d0
	movel a5@(12),a0@
	unlk a5
	rts
	.even
.globl _dispatchKey__15InputDispatcherQ23Key7CtrlKeyb
_dispatchKey__15InputDispatcherQ23Key7CtrlKeyb:
	pea a5@
	movel sp,a5
	moveml #0x3030,sp@-
	movel a5@(8),a3
	movel a5@(12),d2
	moveb a5@(19),d3
	jeq L315
	btst #1,a3@(3)
	jeq L279
	jra L283
	.even
L315:
	btst #3,a3@(3)
	jeq L279
L283:
	movel a3,d0
	addql #4,d0
	movel d0,a2
	tstl a2@(12)
	jle L290
	movel a2@,d0
	movel __7_LLBase$linkCache,a0
	lsll #4,d0
	movel a0@(4,d0:l),a2@(8)
	movel a2@(8),d0
	jra L319
	.even
L290:
	clrl d0
	jra L311
	.even
L296:
	tstb d3
	jeq L316
	btst #1,a1@(3)
	jeq L295
	movel d2,a1@(4)
	movel a1@(36),a0
	movel d2,sp@-
	movel a3,sp@-
	movel a1,sp@-
	movel a0@(8),a0
	jra L318
	.even
L316:
	btst #3,a1@(3)
	jeq L295
	movel d2,a1@(8)
	movel a1@(36),a0
	movel d2,sp@-
	movel a3,sp@-
	movel a1,sp@-
	movel a0@(12),a0
L318:
	jbsr a0@
	addw #12,sp
L295:
	movel a2@(8),d0
	movel __7_LLBase$linkCache,a0
	lsll #4,d0
	movel a0@(4,d0:l),d0
	moveq #-1,d1
	cmpl d0,d1
	jeq L290
	cmpl a2@(4),d0
	jeq L290
	movel d0,a2@(8)
L319:
	lsll #4,d0
	movel a0@(12,d0:l),d0
L311:
	movel d0,a1
	tstl a1
	jne L296
L279:
	moveml a5@(-16),#0xc0c
	unlk a5
	rts
	.even
.globl _dispatchKeyPrintable__15InputDispatcherlb
_dispatchKeyPrintable__15InputDispatcherlb:
	pea a5@
	movel sp,a5
	moveml #0x3030,sp@-
	movel a5@(8),a3
	movel a5@(12),d2
	moveb a5@(19),d3
	jeq L348
	btst #0,a3@(3)
	jeq L320
	jra L324
	.even
L348:
	btst #2,a3@(3)
	jeq L320
L324:
	movel a3,d0
	addql #4,d0
	movel d0,a2
	tstl a2@(12)
	jle L328
	movel a2@,d0
	movel __7_LLBase$linkCache,a0
	lsll #4,d0
	movel a0@(4,d0:l),a2@(8)
	movel a2@(8),d0
	jra L352
	.even
L328:
	clrl d0
	jra L344
	.even
L334:
	tstb d3
	jeq L349
	btst #0,a1@(3)
	jeq L333
	movel d2,a1@(12)
	movel a1@(36),a0
	movel d2,sp@-
	movel a3,sp@-
	movel a1,sp@-
	movel a0@(16),a0
	jra L351
	.even
L349:
	btst #2,a1@(3)
	jeq L333
	movel d2,a1@(16)
	movel a1@(36),a0
	movel d2,sp@-
	movel a3,sp@-
	movel a1,sp@-
	movel a0@(20),a0
L351:
	jbsr a0@
	addw #12,sp
L333:
	movel a2@(8),d0
	movel __7_LLBase$linkCache,a0
	lsll #4,d0
	movel a0@(4,d0:l),d0
	moveq #-1,d1
	cmpl d0,d1
	jeq L328
	cmpl a2@(4),d0
	jeq L328
	movel d0,a2@(8)
L352:
	lsll #4,d0
	movel a0@(12,d0:l),d0
L344:
	movel d0,a1
	tstl a1
	jne L334
L320:
	moveml a5@(-16),#0xc0c
	unlk a5
	rts
	.even
.globl _dispatchMove__15InputDispatcherssssss
_dispatchMove__15InputDispatcherssssss:
	pea a5@
	movel sp,a5
	moveml #0x3f3a,sp@-
	movel a5@(8),a6
	movew a5@(14),d3
	movew a5@(18),d7
	movew a5@(22),d6
	movew a5@(26),d2
	movew a5@(30),d5
	movew a5@(34),d4
	movel a6@,d0
	andl #24576,d0
	jeq L353
	movel a6,d0
	addql #4,d0
	movel d0,a4
	tstl a4@(12)
	jle L357
	movel a4@,d0
	movel __7_LLBase$linkCache,a0
	lsll #4,d0
	movel a0@(4,d0:l),a4@(8)
	movel a4@(8),d0
	jra L391
	.even
L357:
	clrl d0
	jra L387
	.even
L363:
	btst #4,a1@(2)
	jne L364
	movew d3,a2
	movew d7,a0
	movew d6,a3
	cmpl a2,a0
	jgt L367
	movel a2,d0
	cmpl d0,a3
	jge L369
	movel a3,d0
	jra L369
	.even
L367:
	movel a0,d0
L369:
	movew d0,d3
	movew d2,a2
	movew d5,a0
	movew d4,a3
	cmpl a2,a0
	jgt L372
	movel a2,d0
	cmpl d0,a3
	jge L374
	movel a3,d0
	jra L374
	.even
L372:
	movel a0,d0
L374:
	movew d0,d2
L364:
	movew d3,d0
	subw a1@(24),d0
	movew d0,a1@(28)
	movew d3,a1@(24)
	movew d2,d1
	subw a1@(26),d1
	movew d1,a1@(30)
	movew d2,a1@(26)
	movel a1@(28),d0
	jeq L362
	movel a1@,d0
	btst #14,d0
	jeq L378
	movel a1@(20),d1
	jeq L378
	movel a1@(36),a0
	movel d1,sp@-
	movew a1@(30),a2
	movel a2,sp@-
	movew a1@(28),a2
	movel a2,sp@-
	movew d2,a2
	movel a2,sp@-
	movew d3,a2
	movel a2,sp@-
	movel a6,sp@-
	movel a1,sp@-
	movel a0@(36),a0
	jbsr a0@
	addw #28,sp
	jra L362
	.even
L378:
	btst #13,d0
	jeq L362
	movel a1@(36),a0
	movew a1@(30),a2
	movel a2,sp@-
	movew a1@(28),a2
	movel a2,sp@-
	movew d2,a2
	movel a2,sp@-
	movew d3,a2
	movel a2,sp@-
	movel a6,sp@-
	movel a1,sp@-
	movel a0@(32),a0
	jbsr a0@
	addw #24,sp
L362:
	movel a4@(8),d0
	movel __7_LLBase$linkCache,a0
	lsll #4,d0
	movel a0@(4,d0:l),d0
	moveq #-1,d1
	cmpl d0,d1
	jeq L357
	cmpl a4@(4),d0
	jeq L357
	movel d0,a4@(8)
L391:
	lsll #4,d0
	movel a0@(12,d0:l),d0
L387:
	movel d0,a1
	tstl a1
	jne L363
L353:
	moveml a5@(-40),#0x5cfc
	unlk a5
	rts
	.even
.globl _dispatchMouseKey__15InputDispatcherUlb
_dispatchMouseKey__15InputDispatcherUlb:
	pea a5@
	movel sp,a5
	moveml #0x3030,sp@-
	movel a5@(8),a2
	movel a5@(12),d2
	moveb a5@(19),d3
	movel a2@,d0
	andl #1904,d0
	jeq L392
	movel a2,d0
	addql #4,d0
	movel d0,a3
	tstl a3@(12)
	jle L396
	movel a3@,d0
	movel __7_LLBase$linkCache,a0
	lsll #4,d0
	movel a0@(4,d0:l),a3@(8)
	movel a3@(8),d0
	jra L452
	.even
L396:
	clrl d0
	jra L445
	.even
L402:
	tstb d3
	jeq L403
	orl d2,a1@(20)
	moveq #2,d0
	cmpl d2,d0
	jeq L409
	jcs L422
	moveq #1,d1
	cmpl d2,d1
	jeq L405
	jra L417
	.even
L422:
	moveq #4,d0
	cmpl d2,d0
	jeq L413
	jra L417
	.even
L405:
	btst #4,a1@(3)
	jeq L401
	movel a1@(36),a0
	pea 1:w
	movel a2,sp@-
	movel a1,sp@-
	movel a0@(24),a0
	jra L450
	.even
L409:
	btst #5,a1@(3)
	jeq L401
	movel a1@(36),a0
	pea 2:w
	movel a2,sp@-
	movel a1,sp@-
	movel a0@(24),a0
	jra L450
	.even
L413:
	btst #6,a1@(3)
	jeq L401
	movel a1@(36),a0
	pea 4:w
	movel a2,sp@-
	movel a1,sp@-
	movel a0@(24),a0
	jra L450
	.even
L417:
	tstb a1@(3)
	jge L401
	movel a1@(36),a0
	movel d2,sp@-
	movel a2,sp@-
	movel a1,sp@-
	movel a0@(24),a0
	jra L450
	.even
L403:
	movel d2,d0
	notl d0
	andl d0,a1@(20)
	moveq #2,d1
	cmpl d2,d1
	jeq L429
	jcs L442
	moveq #1,d0
	cmpl d2,d0
	jeq L425
	jra L437
	.even
L442:
	moveq #4,d1
	cmpl d2,d1
	jeq L433
	jra L437
	.even
L425:
	btst #0,a1@(2)
	jeq L401
	movel a1@(36),a0
	pea 1:w
	jra L451
	.even
L429:
	btst #1,a1@(2)
	jeq L401
	movel a1@(36),a0
	pea 2:w
	jra L451
	.even
L433:
	btst #2,a1@(2)
	jeq L401
	movel a1@(36),a0
	pea 4:w
	jra L451
	.even
L437:
	btst #3,a1@(2)
	jeq L401
	movel a1@(36),a0
	movel d2,sp@-
L451:
	movel a2,sp@-
	movel a1,sp@-
	movel a0@(28),a0
L450:
	jbsr a0@
	addw #12,sp
L401:
	movel a3@(8),d0
	movel __7_LLBase$linkCache,a0
	lsll #4,d0
	movel a0@(4,d0:l),d0
	moveq #-1,d1
	cmpl d0,d1
	jeq L396
	cmpl a3@(4),d0
	jeq L396
	movel d0,a3@(8)
L452:
	lsll #4,d0
	movel a0@(12,d0:l),d0
L445:
	movel d0,a1
	tstl a1
	jne L402
L392:
	moveml a5@(-16),#0xc0c
	unlk a5
	rts
	.even
.globl _dispatchMouseScroll__15InputDispatcherss
_dispatchMouseScroll__15InputDispatcherss:
	pea a5@
	movel sp,a5
	moveml #0x3038,sp@-
	movel a5@(8),a3
	movew a5@(14),d3
	movew a5@(18),d2
	movel a3@,d0
	andl #98304,d0
	jeq L453
	movel a3,d0
	addql #4,d0
	movel d0,a2
	tstl a2@(12)
	jle L457
	movel a2@,d0
	movel __7_LLBase$linkCache,a0
	lsll #4,d0
	movel a0@(4,d0:l),a2@(8)
	movel a2@(8),d0
	jra L479
	.even
L457:
	clrl d0
	jra L473
	.even
L463:
	tstw d3
	jeq L466
	tstb a1@(2)
	jlt L465
L466:
	tstw d2
	jeq L462
	btst #0,a1@(1)
	jeq L462
L465:
	movew d3,a1@(32)
	movew d2,a1@(34)
	movel a1@(36),a0
	movew d2,a4
	movel a4,sp@-
	movew d3,a4
	movel a4,sp@-
	movel a3,sp@-
	movel a1,sp@-
	movel a0@(40),a0
	jbsr a0@
	addw #16,sp
L462:
	movel a2@(8),d0
	movel __7_LLBase$linkCache,a0
	lsll #4,d0
	movel a0@(4,d0:l),d0
	moveq #-1,d1
	cmpl d0,d1
	jeq L457
	cmpl a2@(4),d0
	jeq L457
	movel d0,a2@(8)
L479:
	lsll #4,d0
	movel a0@(12,d0:l),d0
L473:
	movel d0,a1
	tstl a1
	jne L463
L453:
	moveml a5@(-20),#0x1c0c
	unlk a5
	rts
	.even
.globl _dispatchExit__15InputDispatcher
_dispatchExit__15InputDispatcher:
	pea a5@
	movel sp,a5
	movel a3,sp@-
	movel a2,sp@-
	movel a5@(8),a3
	tstl a3@
	jge L480
	movel a3,d0
	addql #4,d0
	movel d0,a2
	tstl a2@(12)
	jle L484
	movel a2@,d0
	movel __7_LLBase$linkCache,a0
	lsll #4,d0
	movel a0@(4,d0:l),a2@(8)
	movel a2@(8),d0
	jra L499
	.even
L484:
	clrl d0
	jra L493
	.even
L490:
	movel a1@(36),a0
	movel a3,sp@-
	movel a1,sp@-
	movel a0@(44),a0
	jbsr a0@
	addql #8,sp
	movel a2@(8),d0
	movel __7_LLBase$linkCache,a0
	lsll #4,d0
	movel a0@(4,d0:l),d0
	moveq #-1,d1
	cmpl d0,d1
	jeq L484
	cmpl a2@(4),d0
	jeq L484
	movel d0,a2@(8)
L499:
	lsll #4,d0
	movel a0@(12,d0:l),d0
L493:
	movel d0,a1
	tstl a1
	jne L490
L480:
	movel a5@(-8),a2
	movel a5@(-4),a3
	unlk a5
	rts
	.even
.globl ___10InputFocusUl
___10InputFocusUl:
	pea a5@
	movel sp,a5
	movel a5@(8),a0
	movel a5@(12),a0@
	movel #___vt_10InputFocus,a0@(36)
	clrl a0@(4)
	clrl a0@(8)
	clrl a0@(12)
	clrl a0@(16)
	clrl a0@(20)
	clrw a0@(24)
	clrw a0@(26)
	clrw a0@(28)
	clrw a0@(30)
	clrw a0@(32)
	clrw a0@(34)
	movel a0,d0
	unlk a5
	rts
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
	jeq L267
	movel a0,sp@-
	jbsr ___builtin_delete
L267:
	unlk a5
	rts
