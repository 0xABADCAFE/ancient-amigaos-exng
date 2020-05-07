#NO_APP
.text
LC0:
	.ascii "bad_alloc\0"
	.even
.globl __$_19SimpleEventRecorder
__$_19SimpleEventRecorder:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel d2,sp@-
	movel a5@(8),a2
	movel a5@(12),d2
	movel #___vt_19SimpleEventRecorder,a2@(36)
	movel a2,sp@-
	jbsr _close__19SimpleEventRecorder
	addql #4,sp
	movel #___vt_10InputFocus,a2@(36)
	btst #0,d2
	jeq L544
	movel a2,sp@-
	jbsr ___builtin_delete
L544:
	movel a5@(-8),d2
	movel a5@(-4),a2
	unlk a5
	rts
LC1:
	.ascii "%03lu:%02lu:%02lu:%02lu:%03lu \0"
	.even
.globl _timeStamp__19SimpleEventRecorder
_timeStamp__19SimpleEventRecorder:
	link a5,#-8
	movel a2,sp@-
	movel a5@(8),a2
	pea a2@(44)
	jbsr _elapsed__C5Clock
	movel d0,a0
	addql #4,sp
	movel a0@,d0
	movel a0@(4),d1
	movel d0,a5@(-8)
	movel d1,a5@(-4)
	pea 1000:w
	clrl sp@-
	movel d1,sp@-
	movel d0,sp@-
	jbsr ___moddi3
	addw #12,sp
	movel d1,sp@
	pea 1000:w
	clrl sp@-
	movel a5@(-4),sp@-
	movel a5@(-8),sp@-
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
	movel a5@(-4),sp@-
	movel a5@(-8),sp@-
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
	movel a5@(-4),sp@-
	movel a5@(-8),sp@-
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
	movel a5@(-4),sp@-
	movel a5@(-8),sp@-
	jbsr ___divdi3
	addw #12,sp
	movel d1,sp@
	pea LC1
	movel a2@(40),sp@-
	jbsr _writeText__9StreamOutPCce
	movel a5@(-12),a2
	unlk a5
	rts
LC2:
	.ascii "%08X %ld\12%ld\12\0"
	.even
.globl _keyPressNonPrintable__19SimpleEventRecorderP15InputDispatcherQ23Key7CtrlKey
_keyPressNonPrintable__19SimpleEventRecorderP15InputDispatcherQ23Key7CtrlKey:
	link a5,#-4
	movel a2,sp@-
	movel a5@(8),a2
	tstl a2@(40)
	jeq L558
	movel a2,sp@-
	jbsr _timeStamp__19SimpleEventRecorder
	movel a5@(16),sp@-
	clrl sp@-
	movel a5@(12),a1
	lea a1@(20),a0
	movel a0@,a5@(-4)
	movel a0@,sp@-
	pea LC2
	movel a2@(40),sp@-
	jbsr _writeText__9StreamOutPCce
L558:
	movel a5@(-8),a2
	unlk a5
	rts
	.even
.globl _keyReleaseNonPrintable__19SimpleEventRecorderP15InputDispatcherQ23Key7CtrlKey
_keyReleaseNonPrintable__19SimpleEventRecorderP15InputDispatcherQ23Key7CtrlKey:
	link a5,#-4
	movel a2,sp@-
	movel a5@(8),a2
	tstl a2@(40)
	jeq L564
	movel a2,sp@-
	jbsr _timeStamp__19SimpleEventRecorder
	movel a5@(16),sp@-
	pea 1:w
	movel a5@(12),a1
	lea a1@(20),a0
	movel a0@,a5@(-4)
	movel a0@,sp@-
	pea LC2
	movel a2@(40),sp@-
	jbsr _writeText__9StreamOutPCce
L564:
	movel a5@(-8),a2
	unlk a5
	rts
LC3:
	.ascii "%08X %ld\12%c\12\0"
	.even
.globl _keyPressPrintable__19SimpleEventRecorderP15InputDispatcherl
_keyPressPrintable__19SimpleEventRecorderP15InputDispatcherl:
	link a5,#-4
	movel a2,sp@-
	movel a5@(8),a2
	tstl a2@(40)
	jeq L570
	movel a2,sp@-
	jbsr _timeStamp__19SimpleEventRecorder
	movel a5@(16),sp@-
	pea 2:w
	movel a5@(12),a1
	lea a1@(20),a0
	movel a0@,a5@(-4)
	movel a0@,sp@-
	pea LC3
	movel a2@(40),sp@-
	jbsr _writeText__9StreamOutPCce
L570:
	movel a5@(-8),a2
	unlk a5
	rts
	.even
.globl _keyReleasePrintable__19SimpleEventRecorderP15InputDispatcherl
_keyReleasePrintable__19SimpleEventRecorderP15InputDispatcherl:
	link a5,#-4
	movel a2,sp@-
	movel a5@(8),a2
	tstl a2@(40)
	jeq L576
	movel a2,sp@-
	jbsr _timeStamp__19SimpleEventRecorder
	movel a5@(16),sp@-
	pea 3:w
	movel a5@(12),a1
	lea a1@(20),a0
	movel a0@,a5@(-4)
	movel a0@,sp@-
	pea LC3
	movel a2@(40),sp@-
	jbsr _writeText__9StreamOutPCce
L576:
	movel a5@(-8),a2
	unlk a5
	rts
LC4:
	.ascii "%08X %ld\12%lu\12\0"
	.even
.globl _mousePress__19SimpleEventRecorderP15InputDispatcherUl
_mousePress__19SimpleEventRecorderP15InputDispatcherUl:
	link a5,#-4
	movel a2,sp@-
	movel a5@(8),a2
	tstl a2@(40)
	jeq L582
	movel a2,sp@-
	jbsr _timeStamp__19SimpleEventRecorder
	movel a5@(16),sp@-
	pea 4:w
	movel a5@(12),a1
	lea a1@(20),a0
	movel a0@,a5@(-4)
	movel a0@,sp@-
	pea LC4
	movel a2@(40),sp@-
	jbsr _writeText__9StreamOutPCce
L582:
	movel a5@(-8),a2
	unlk a5
	rts
	.even
.globl _mouseRelease__19SimpleEventRecorderP15InputDispatcherUl
_mouseRelease__19SimpleEventRecorderP15InputDispatcherUl:
	link a5,#-4
	movel a2,sp@-
	movel a5@(8),a2
	tstl a2@(40)
	jeq L588
	movel a2,sp@-
	jbsr _timeStamp__19SimpleEventRecorder
	movel a5@(16),sp@-
	pea 5:w
	movel a5@(12),a1
	lea a1@(20),a0
	movel a0@,a5@(-4)
	movel a0@,sp@-
	pea LC4
	movel a2@(40),sp@-
	jbsr _writeText__9StreamOutPCce
L588:
	movel a5@(-8),a2
	unlk a5
	rts
LC5:
	.ascii "%08X %ld\12%hd %hd %hd %hd\12\0"
	.even
.globl _mouseMove__19SimpleEventRecorderP15InputDispatcherssss
_mouseMove__19SimpleEventRecorderP15InputDispatcherssss:
	link a5,#-4
	moveml #0x3c20,sp@-
	movel a5@(8),a2
	movew a5@(18),d5
	movew a5@(22),d4
	movew a5@(26),d3
	movew a5@(30),d2
	tstl a2@(40)
	jeq L594
	movel a2,sp@-
	jbsr _timeStamp__19SimpleEventRecorder
	movew d2,a0
	movel a0,sp@-
	movew d3,a1
	movel a1,sp@-
	movew d4,a0
	movel a0,sp@-
	movew d5,a1
	movel a1,sp@-
	pea 6:w
	movel a5@(12),a1
	lea a1@(20),a0
	movel a0@,a5@(-4)
	movel a0@,sp@-
	pea LC5
	movel a2@(40),sp@-
	jbsr _writeText__9StreamOutPCce
L594:
	moveml a5@(-24),#0x43c
	unlk a5
	rts
LC6:
	.ascii "%08X %ld\12%hd %hd %hd %hd %lu\12\0"
	.even
.globl _mouseDrag__19SimpleEventRecorderP15InputDispatcherssssUl
_mouseDrag__19SimpleEventRecorderP15InputDispatcherssssUl:
	link a5,#-4
	moveml #0x3c20,sp@-
	movel a5@(8),a2
	movew a5@(18),d5
	movew a5@(22),d4
	movew a5@(26),d3
	movew a5@(30),d2
	tstl a2@(40)
	jeq L600
	movel a2,sp@-
	jbsr _timeStamp__19SimpleEventRecorder
	movel a5@(32),sp@-
	movew d2,a0
	movel a0,sp@-
	movew d3,a1
	movel a1,sp@-
	movew d4,a0
	movel a0,sp@-
	movew d5,a1
	movel a1,sp@-
	pea 7:w
	movel a5@(12),a1
	lea a1@(20),a0
	movel a0@,a5@(-4)
	movel a0@,sp@-
	pea LC6
	movel a2@(40),sp@-
	jbsr _writeText__9StreamOutPCce
L600:
	moveml a5@(-24),#0x43c
	unlk a5
	rts
LC7:
	.ascii "%08X %ld\12%hd %hd\12\0"
	.even
.globl _mouseScroll__19SimpleEventRecorderP15InputDispatcherss
_mouseScroll__19SimpleEventRecorderP15InputDispatcherss:
	link a5,#-4
	moveml #0x3020,sp@-
	movel a5@(8),a2
	movew a5@(18),d3
	movew a5@(22),d2
	tstl a2@(40)
	jeq L606
	movel a2,sp@-
	jbsr _timeStamp__19SimpleEventRecorder
	movew d2,a0
	movel a0,sp@-
	movew d3,a1
	movel a1,sp@-
	pea 8:w
	movel a5@(12),a1
	lea a1@(20),a0
	movel a0@,a5@(-4)
	movel a0@,sp@-
	pea LC7
	movel a2@(40),sp@-
	jbsr _writeText__9StreamOutPCce
L606:
	moveml a5@(-16),#0x40c
	unlk a5
	rts
LC8:
	.ascii "%08X %ld\12\0"
	.even
.globl _exitEvent__19SimpleEventRecorderP15InputDispatcher
_exitEvent__19SimpleEventRecorderP15InputDispatcher:
	link a5,#-4
	movel a2,sp@-
	movel a5@(8),a2
	tstl a2@(40)
	jeq L612
	movel a2,sp@-
	jbsr _timeStamp__19SimpleEventRecorder
	pea 9:w
	movel a5@(12),a1
	lea a1@(20),a0
	movel a0@,a5@(-4)
	movel a0@,sp@-
	pea LC8
	movel a2@(40),sp@-
	jbsr _writeText__9StreamOutPCce
L612:
	movel a5@(-8),a2
	unlk a5
	rts
LC9:
	.ascii "***SimpleEventRecorder\12\0"
	.even
.globl _open__19SimpleEventRecorderPCc
_open__19SimpleEventRecorderPCc:
	link a5,#-124
	fmovem #0xfc,sp@-
	moveml #0x3f3a,sp@-
	jbsr ___get_eh_context
	movel d0,a5@(-106)
	movel d0,a5@(-114)
	tstl a5@(12)
	jne L618
	movel #-50462722,d0
	jra L656
	.even
L618:
	movel a5@(8),a0
	tstl a0@(40)
	jeq L619
	movel #-50593803,d0
	jra L656
	.even
L619:
	pea _nothrow
	pea 156:w
	movel a5@(-106),a1
	addql #4,a1
	movel a1,a5@(-118)
	jbsr ___nw__FUlRC9nothrow_t
	movel d0,a5@(-100)
	moveb #1,a5@(-101)
	movel a5@(-118),a0
	movel a0@,a5@(-24)
	clrl a5@(-20)
	movel a5,a5@(-16)
	movel #L624,a5@(-12)
	movel sp,a5@(-8)
	jra L623
	.even
L624:
	jra L657
	.even
L623:
	moveq #-24,d1
	addl a5,d1
	movel d1,a0@
	addql #8,sp
	movel a5@(-114),d0
	movel a5@(-100),a0
	addql #2,a0
	clrl a0@(12)
	clrl a0@(40)
	clrl a0@(28)
	movel d0,a0
	addql #4,a0
	movel a0@,a5@(-48)
	clrl a5@(-44)
	movel d1,a5@(-40)
	movel #L629,a5@(-36)
	movel sp,a5@(-32)
L629:
	lea a5@(-48),a1
	movel a1,a0@
	movel a5@(-100),a0
	clrl a0@(152)
	pea 2048:w
	subql #2,sp
	moveb #0,sp@(1)
	subql #2,sp
	subql #2,sp
	moveb #1,sp@(1)
	subql #2,sp
	movel a5@(12),sp@-
	movel a0,sp@-
	jbsr _open__9StreamOutPCcbT2Ul
	addw #20,sp
	movel a5@(-106),a1
	addql #4,a1
	movel a1@,a0
	movel a0@,a1@
	jra L631
	.even
L627:
	movel a5@(-106),a0
	addql #4,a0
	movel a0@,a5@(-72)
	clrl a5@(-68)
	lea a5@(-24),a1
	movel a1,a5@(-64)
	movel #L635,a5@(-60)
	movel sp,a5@(-56)
	movel a0,a5@(-122)
L635:
	lea a5@(-72),a1
	movel a1,a0@
	movel a5@(-100),a0
	pea a0@(2)
	jbsr _destroy__17AsyncStreamBuffer
	addql #4,sp
	movel a5@(-122),a1
	movel a1@,a0
	movel a0@,a1@
	jbsr ___sjthrow
	.even
L633:
	jbsr ___terminate
	.even
L631:
	clrb a5@(-101)
	movel a5@(8),a0
	movel a5@(-100),a0@(40)
	movel a5@(-118),a1
	movel a1@,a0
	movel a0@,a1@
	tstl a5@(-100)
	jne L620
	movel #-50593798,d0
	jra L656
	.even
L620:
	movel a5@(8),a1
	movel a1@(40),a0
	btst #3,a0@(17)
	jne L642
	tstl a0
	jeq L647
	pea 3:w
	movel a0,sp@-
	jbsr __$_9StreamOut
L647:
	movel a5@(8),a0
	clrl a0@(40)
	movel #-50593798,d0
	jra L656
	.even
L642:
	movew #44,a1
	addl a5@(8),a1
	movel a1,a5@(-110)
	movel a1,sp@-
	jbsr _GetSysTime
	movel a5@(-110),a0
	clrl a0@(8)
	clrl a0@(12)
	movel #LC9,sp@
	movel a5@(8),a1
	movel a1@(40),sp@-
	jbsr _writeText__9StreamOutPCce
	clrl d0
	jra L656
	.even
L657:
L621:
	movel a5@(-118),a0
	movel a0@,a5@(-96)
	clrl a5@(-92)
	movel a5,a5@(-88)
	movel #L652,a5@(-84)
	movel sp,a5@(-80)
	jra L651
	.even
L652:
	jra L658
	.even
L651:
	lea a5@(-96),a0
	movel a5@(-118),a1
	movel a0,a1@
	tstb a5@(-101)
	jeq L654
	pea _nothrow
	movel a5@(-100),sp@-
	jbsr ___dl__FPvRC9nothrow_t
	addql #8,sp
L654:
	movel a5@(-118),a1
	movel a1@,a0
	movel a0@,a1@
	jbsr ___sjthrow
	.even
L658:
L649:
	jbsr ___terminate
	.even
L656:
	moveml a5@(-236),#0x5cfc
	fmovem a5@(-196),#0x3f
	unlk a5
	rts
LC10:
	.ascii "***End\12\0"
	.even
.globl _close__19SimpleEventRecorder
_close__19SimpleEventRecorder:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel a5@(8),a2
	movel a2@(40),d0
	jeq L660
	pea LC10
	movel d0,sp@-
	jbsr _writeText__9StreamOutPCce
	addql #8,sp
	movel a2@(40),d0
	jeq L662
	pea 3:w
	movel d0,sp@-
	jbsr __$_9StreamOut
L662:
	clrl a2@(40)
L660:
	movel a5@(-4),a2
	unlk a5
	rts
.globl ___vt_19SimpleEventRecorder
	.even
___vt_19SimpleEventRecorder:
	.long 0
	.long 0
	.long _keyPressNonPrintable__19SimpleEventRecorderP15InputDispatcherQ23Key7CtrlKey
	.long _keyReleaseNonPrintable__19SimpleEventRecorderP15InputDispatcherQ23Key7CtrlKey
	.long _keyPressPrintable__19SimpleEventRecorderP15InputDispatcherl
	.long _keyReleasePrintable__19SimpleEventRecorderP15InputDispatcherl
	.long _mousePress__19SimpleEventRecorderP15InputDispatcherUl
	.long _mouseRelease__19SimpleEventRecorderP15InputDispatcherUl
	.long _mouseMove__19SimpleEventRecorderP15InputDispatcherssss
	.long _mouseDrag__19SimpleEventRecorderP15InputDispatcherssssUl
	.long _mouseScroll__19SimpleEventRecorderP15InputDispatcherss
	.long _exitEvent__19SimpleEventRecorderP15InputDispatcher
	.long __$_19SimpleEventRecorder
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
	jeq L393
	movel a0,sp@-
	jbsr ___builtin_delete
L393:
	unlk a5
	rts
	.even
.globl ___19SimpleEventRecorder
___19SimpleEventRecorder:
	link a5,#-56
	fmovem #0xfc,sp@-
	moveml #0x3f3a,sp@-
	jbsr ___get_eh_context
	movel d0,a5@(-56)
	pea -1:w
	movel a5@(8),sp@-
	jbsr ___10InputFocusUl
	movel a5@(-56),a0
	addql #4,a0
	movel a0@,a5@(-24)
	clrl a5@(-20)
	movel a5,a5@(-16)
	movel #L453,a5@(-12)
	movel sp,a5@(-8)
L453:
	lea a5@(-24),a1
	movel a1,a0@
	movel a5@(8),a0
	movel #___vt_19SimpleEventRecorder,a0@(36)
	clrl a0@(40)
	movew #44,a1
	addl a0,a1
	movel a1,a5@(-52)
	addql #8,sp
	clrl a0@(52)
	clrl a0@(56)
	movel a1,sp@-
	jbsr _GetSysTime
	movel a5@(-52),a1
	clrl a1@(8)
	clrl a1@(12)
	movel a5@(-56),a1
	addql #4,a1
	movel a1@,a0
	movel a0@,a1@
	movel a5@(8),d0
	jra L663
	.even
L451:
	movel a5@(-56),a0
	addql #4,a0
	movel a0@,a5@(-48)
	clrl a5@(-44)
	movel a5,a5@(-40)
	movel #L463,a5@(-36)
	movel sp,a5@(-32)
L463:
	lea a5@(-48),a1
	movel a1,a0@
	movel a5@(8),a0
	movel #___vt_10InputFocus,a0@(36)
	movel a5@(-56),a1
	addql #4,a1
	movel a1@,a0
	movel a0@,a1@
	jbsr ___sjthrow
	.even
L663:
	moveml a5@(-168),#0x5cfc
	fmovem a5@(-128),#0x3f
	unlk a5
	rts
