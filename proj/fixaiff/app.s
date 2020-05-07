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
	pea _nothrow
	pea 12:w
	jbsr ___nw__FUlRC9nothrow_t
	movel d0,a5@(-52)
	movel a5@(-56),a0
	addql #4,a0
	movel a0@,a5@(-24)
	clrl a5@(-20)
	movel a5,a5@(-16)
	movel #L288,a5@(-12)
	movel sp,a5@(-8)
	movel a0,a5@(-60)
	jra L287
	.even
L288:
	movel a5@(-56),a0
	addql #4,a0
	movel a0,a5@(-60)
	jra L285
	.even
L287:
	lea a5@(-24),a1
	movel a1,a0@
	movel a5@(-52),sp@-
	jbsr ___3App
	movel a5@(-60),a1
	movel a1@,a0
	movel a0@,a1@
	jra L299
	.even
L285:
	movel a5@(-60),a0
	movel a0@,a5@(-48)
	clrl a5@(-44)
	movel a5,a5@(-40)
	movel #L294,a5@(-36)
	movel sp,a5@(-32)
	jra L293
	.even
L294:
	jra L300
	.even
L293:
	lea a5@(-48),a0
	movel a5@(-60),a1
	movel a0,a1@
	moveq #1,d0
	jeq L296
	pea _nothrow
	movel a5@(-52),sp@-
	jbsr ___dl__FPvRC9nothrow_t
	addql #8,sp
L296:
	movel a5@(-56),a1
	addql #4,a1
	movel a1@,a0
	movel a0@,a1@
	jbsr ___sjthrow
	.even
L300:
L291:
	jbsr ___terminate
	.even
L299:
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
	jeq L303
	movel a1@,a0
	pea 3:w
	movel a1,sp@-
	movel a0@(20),a0
	jbsr a0@
L303:
	unlk a5
	rts
LC1:
	.ascii "-- constructing App --\0"
LC2:
	.ascii "file\0"
	.even
.globl ___3App
___3App:
	link a5,#-104
	fmovem #0xfc,sp@-
	moveml #0x3f3a,sp@-
	jbsr ___get_eh_context
	movel d0,d1
	movel a5@(8),a0
	movel #___vt_7AppBase,a0@
	movel d1,a0
	addql #4,a0
	movel a0@,a5@(-24)
	clrl a5@(-20)
	movel a5,a5@(-16)
	movel #L312,a5@(-12)
	movel sp,a5@(-8)
	jra L311
	.even
L312:
	jra L336
	.even
L311:
	lea a5@(-24),a1
	movel a1,a0@
	movel a5@(8),a0
	movel #___vt_3App,a0@
	clrl sp@-
	pea LC1
	movel d1,a1
	addql #4,a1
	movel a1,a5@(-104)
	jbsr _printDebug__9SystemLibPCci
	subql #2,sp
	moveb #0,sp@(1)
	subql #2,sp
	pea LC2
	jbsr _getString__7AppBasePCcb
	movel a5@(8),a0
	movel d0,a0@(4)
	pea _nothrow
	pea 60:w
	jbsr ___nw__FUlRC9nothrow_t
	movel d0,a5@(-100)
	movel a5@(-104),a0
	movel a0@,a5@(-48)
	clrl a5@(-44)
	movel a5,a5@(-40)
	movel #L316,a5@(-36)
	movel sp,a5@(-32)
	jra L315
	.even
L316:
	jra L337
	.even
L315:
	lea a5@(-48),a1
	movel a1,a0@
	movel a5@(-100),sp@-
	jbsr ___4AIFF
	movel a5@(8),a0
	movel d0,a0@(8)
	movel a5@(-104),a1
	movel a1@,a0
	movel a0@,a1@
	movel a1@,a0
	movel a0@,a1@
	movel a5@(8),d0
	jra L335
	.even
L337:
L313:
	movel a5@(-104),a0
	movel a0@,a5@(-72)
	clrl a5@(-68)
	movel a5,a5@(-64)
	movel #L323,a5@(-60)
	movel sp,a5@(-56)
	jra L322
	.even
L323:
	jra L338
	.even
L322:
	lea a5@(-72),a0
	movel a5@(-104),a1
	movel a0,a1@
	moveq #1,d0
	jeq L325
	pea _nothrow
	movel a5@(-100),sp@-
	jbsr ___dl__FPvRC9nothrow_t
	addql #8,sp
L325:
	movel a5@(-104),a1
	movel a1@,a0
	movel a0@,a1@
	jbsr ___sjthrow
	.even
L336:
L309:
	movel a5@(-104),a0
	movel a0@,a5@(-96)
	clrl a5@(-92)
	movel a5,a5@(-88)
	movel #L329,a5@(-84)
	movel sp,a5@(-80)
	jra L328
	.even
L329:
	jra L339
	.even
L328:
	lea a5@(-96),a0
	movel a5@(-104),a1
	movel a0,a1@
	movel a5@(8),a1
	movel #___vt_7AppBase,a1@
	movel a5@(-104),a1
	movel a1@,a0
	movel a0@,a1@
	jbsr ___sjthrow
	.even
L338:
L320:
	jbsr ___terminate
	.even
L339:
L326:
	jbsr ___terminate
	.even
L335:
	moveml a5@(-216),#0x5cfc
	fmovem a5@(-176),#0x3f
	unlk a5
	rts
LC3:
	.ascii "--- destroying App ---\0"
	.even
.globl __$_3App
__$_3App:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel a5@(8),a2
	movel #___vt_3App,a2@
	movel a2@(8),d0
	jeq L342
	pea 3:w
	movel d0,sp@-
	jbsr __$_4AIFF
	addql #8,sp
L342:
	clrl sp@-
	pea LC3
	jbsr _printDebug__9SystemLibPCci
	addql #8,sp
	movel #___vt_7AppBase,a2@
	movel a5@(12),d0
	btst #0,d0
	jeq L347
	movel a2,sp@-
	jbsr ___builtin_delete
L347:
	movel a5@(-4),a2
	unlk a5
	rts
LC4:
	.ascii "No source filename given\12\0"
LC5:
	.ascii "App::initApplication() OK\0"
	.even
.globl _initApplication__3App
_initApplication__3App:
	pea a5@
	movel sp,a5
	movel a5@(8),a0
	tstl a0@(4)
	jeq L349
	clrl sp@-
	pea LC5
	jbsr _printDebug__9SystemLibPCci
	clrl d0
	jra L350
	.even
L349:
	pea LC4
	jbsr _printf
	movel #-50593792,d0
L350:
	unlk a5
	rts
LC6:
	.ascii "failed to read %s\12\0"
	.even
.globl _runApplication__3App
_runApplication__3App:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel a5@(8),a2
	movel a2@(4),sp@-
	movel a2@(8),sp@-
	jbsr _read__4AIFFPCc
	addql #8,sp
	tstl d0
	jne L352
	movel a2@(8),sp@-
	jbsr _normalize__4AIFF
	movel a2@(4),sp@-
	movel a2@(8),sp@-
	jbsr _write__4AIFFPCc
	clrl d0
	jra L353
	.even
L352:
	movel a2@(4),sp@-
	pea LC6
	jbsr _printf
	movel #-50593796,d0
L353:
	movel a5@(-4),a2
	unlk a5
	rts
.globl ___vt_3App
	.even
___vt_3App:
	.long 0
	.long 0
	.long _initApplication__3App
	.long _doneApplication__7AppBase
	.long _runApplication__3App
	.long __$_3App
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
	jeq L22
	movel a0,sp@-
	jbsr ___builtin_delete
L22:
	unlk a5
	rts
