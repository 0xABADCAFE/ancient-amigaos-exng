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
	pea 16408:w
	jbsr ___nw__FUlRC9nothrow_t
	movel d0,a5@(-52)
	movel a5@(-56),a0
	addql #4,a0
	movel a0@,a5@(-24)
	clrl a5@(-20)
	movel a5,a5@(-16)
	movel #L240,a5@(-12)
	movel sp,a5@(-8)
	movel a0,a5@(-60)
	jra L239
	.even
L240:
	movel a5@(-56),a0
	addql #4,a0
	movel a0,a5@(-60)
	jra L237
	.even
L239:
	lea a5@(-24),a1
	movel a1,a0@
	movel a5@(-52),sp@-
	jbsr ___3App
	movel a5@(-60),a1
	movel a1@,a0
	movel a0@,a1@
	jra L251
	.even
L237:
	movel a5@(-60),a0
	movel a0@,a5@(-48)
	clrl a5@(-44)
	movel a5,a5@(-40)
	movel #L246,a5@(-36)
	movel sp,a5@(-32)
	jra L245
	.even
L246:
	jra L252
	.even
L245:
	lea a5@(-48),a0
	movel a5@(-60),a1
	movel a0,a1@
	moveq #1,d0
	jeq L248
	pea _nothrow
	movel a5@(-52),sp@-
	jbsr ___dl__FPvRC9nothrow_t
	addql #8,sp
L248:
	movel a5@(-56),a1
	addql #4,a1
	movel a1@,a0
	movel a0@,a1@
	jbsr ___sjthrow
	.even
L252:
L243:
	jbsr ___terminate
	.even
L251:
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
	jeq L255
	movel a1@,a0
	pea 3:w
	movel a1,sp@-
	movel a0@(20),a0
	jbsr a0@
L255:
	unlk a5
	rts
LC1:
	.ascii "-- constructing App --\0"
LC2:
	.ascii "mode\0"
LC3:
	.ascii "from\0"
	.even
.globl ___3App
___3App:
	link a5,#-160
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
	movel #L264,a5@(-12)
	movel sp,a5@(-8)
	jra L263
	.even
L264:
	jra L300
	.even
L263:
	lea a5@(-24),a1
	movel a1,a0@
	movel a5@(8),a0
	movel #___vt_3App,a0@
	clrl sp@-
	pea LC1
	movel d1,a1
	addql #4,a1
	movel a1,a5@(-158)
	jbsr _printDebug__9SystemLibPCci
	subql #2,sp
	moveb #0,sp@(1)
	subql #2,sp
	pea LC2
	jbsr _getInteger__7AppBasePCcb
	movel a5@(8),a0
	movel d0,a0@(4)
	subql #2,sp
	moveb #0,sp@(1)
	subql #2,sp
	pea LC3
	jbsr _getString__7AppBasePCcb
	movel a5@(8),a1
	movel d0,a1@(8)
	pea _nothrow
	pea 28:w
	jbsr ___nw__FUlRC9nothrow_t
	movel d0,a5@(-148)
	moveb #1,a5@(-149)
	movel a5@(-158),a0
	movel a0@,a5@(-48)
	clrl a5@(-44)
	movel a5,a5@(-40)
	movel #L268,a5@(-36)
	movel sp,a5@(-32)
	jra L267
	.even
L268:
	jra L301
	.even
L267:
	lea a5@(-48),a1
	movel a1,a0@
	addw #28,sp
	movel a5@(-148),sp@
	jbsr ___13DeltaAnalyser
	clrb a5@(-149)
	movel a5@(8),a0
	movel d0,a0@(20)
	movel a5@(-158),a1
	movel a1@,a0
	movel a0@,a1@
	movel #_nothrow,sp@
	pea 182:w
	jbsr ___nw__FUlRC9nothrow_t
	movel d0,a5@(-154)
	movel a5@(-158),a0
	movel a0@,a5@(-72)
	clrl a5@(-68)
	movel a5,a5@(-64)
	movel #L274,a5@(-60)
	movel sp,a5@(-56)
	jra L273
	.even
L274:
	jra L302
	.even
L273:
	lea a5@(-72),a0
	movel a5@(-158),a1
	movel a0,a1@
	movel a5@(-154),sp@-
	jbsr ___11InputAIFF16
	movel a5@(8),a1
	movel d0,a1@(16)
	movel a5@(-158),a1
	movel a1@,a0
	movel a0@,a1@
	movel a1@,a0
	movel a0@,a1@
	movel a5@(8),d0
	jra L299
	.even
L301:
L265:
	movel a5@(-158),a0
	movel a0@,a5@(-96)
	clrl a5@(-92)
	movel a5,a5@(-88)
	movel #L281,a5@(-84)
	movel sp,a5@(-80)
	jra L280
	.even
L281:
	jra L303
	.even
L280:
	lea a5@(-96),a0
	movel a5@(-158),a1
	movel a0,a1@
	tstb a5@(-149)
	jeq L283
	pea _nothrow
	movel a5@(-148),sp@-
	jbsr ___dl__FPvRC9nothrow_t
	addql #8,sp
L283:
	movel a5@(-158),a1
	movel a1@,a0
	movel a0@,a1@
	jbsr ___sjthrow
	.even
L302:
L271:
	movel a5@(-158),a0
	movel a0@,a5@(-120)
	clrl a5@(-116)
	movel a5,a5@(-112)
	movel #L287,a5@(-108)
	movel sp,a5@(-104)
	jra L286
	.even
L287:
	jra L304
	.even
L286:
	lea a5@(-120),a0
	movel a5@(-158),a1
	movel a0,a1@
	moveq #1,d0
	jeq L289
	pea _nothrow
	movel a5@(-154),sp@-
	jbsr ___dl__FPvRC9nothrow_t
	addql #8,sp
L289:
	movel a5@(-158),a1
	movel a1@,a0
	movel a0@,a1@
	jbsr ___sjthrow
	.even
L300:
L261:
	movel a5@(-158),a0
	movel a0@,a5@(-144)
	clrl a5@(-140)
	lea a5@(-136),a0
	movel a5,a0@
	movel #L293,a0@(4)
	movel sp,a5@(-128)
	jra L292
	.even
L293:
	jra L305
	.even
L292:
	lea a5@(-144),a0
	movel a5@(-158),a1
	movel a0,a1@
	movel a5@(8),a1
	movel #___vt_7AppBase,a1@
	movel a5@(-158),a1
	movel a1@,a0
	movel a0@,a1@
	jbsr ___sjthrow
	.even
L303:
L278:
	jbsr ___terminate
	.even
L304:
L284:
	jbsr ___terminate
	.even
L305:
L290:
	jbsr ___terminate
	.even
L299:
	moveml a5@(-272),#0x5cfc
	fmovem a5@(-232),#0x3f
	unlk a5
	rts
LC4:
	.ascii "--- destroying App ---\0"
	.even
.globl __$_3App
__$_3App:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel a5@(8),a2
	movel #___vt_3App,a2@
	movel a2@(16),a1
	tstl a1
	jeq L308
	movel a1@(2),a0
	pea 3:w
	movel a1,sp@-
	movel a0@(40),a0
	jbsr a0@
	addql #8,sp
L308:
	movel a2@(20),d0
	jeq L310
	pea 3:w
	movel d0,sp@-
	jbsr __$_13DeltaAnalyser
	addql #8,sp
L310:
	clrl sp@-
	pea LC4
	jbsr _printDebug__9SystemLibPCci
	addql #8,sp
	movel #___vt_7AppBase,a2@
	movel a5@(12),d0
	btst #0,d0
	jeq L315
	movel a2,sp@-
	jbsr ___builtin_delete
L315:
	movel a5@(-4),a2
	unlk a5
	rts
LC5:
	.ascii "No source filename given\12\0"
LC6:
	.ascii "Failed to open source file\12\0"
LC7:
	.ascii "App::initApplication() OK\0"
	.even
.globl _initApplication__3App
_initApplication__3App:
	pea a5@
	movel sp,a5
	movel a5@(8),a0
	movel a0@(8),d0
	jne L317
	pea LC5
	jbsr _printf
	movel #-50593792,d0
	jra L322
	.even
L317:
	movel a0@(16),a1
	tstl a1
	jeq L319
	tstl a0@(20)
	jne L318
L319:
	movel #-50528257,d0
	jra L322
	.even
L318:
	movel a1@(2),a0
	movel d0,sp@-
	movel a1,sp@-
	movel a0@(8),a0
	jbsr a0@
	addql #8,sp
	tstl d0
	jne L320
	clrl sp@-
	pea LC7
	jbsr _printDebug__9SystemLibPCci
	clrl d0
	jra L322
	.even
L320:
	pea LC6
	jbsr _printf
	movel #-50593803,d0
L322:
	unlk a5
	rts
LC8:
	.ascii "Freq: %.2lf\12\0"
LC9:
	.ascii "Chan: %2ld\12\0"
LC10:
	.ascii "Read : %5ld blocks last %5ld\15\0"
LC11:
	.ascii "unique delta  = %ld\12\0"
LC12:
	.ascii "peak          = %ld\12\0"
LC13:
	.ascii "most frequent = %ld\12\0"
	.even
.globl _runApplication__3App
_runApplication__3App:
	pea a5@
	movel sp,a5
	moveml #0x3e30,sp@-
	movel a5@(8),a3
	movel a3@(16),a0
	movel a0@(2),a1
	movel a0,sp@-
	movel a1@(16),a0
	jbsr a0@
	movel d1,sp@-
	movel d0,sp@-
	pea LC8
	lea _printf,a2
	jbsr a2@
	movel a3@(16),a0
	movel a0@(2),a1
	movel a0,sp@-
	movel a1@(20),a0
	jbsr a0@
	movel d0,sp@-
	pea LC9
	jbsr a2@
	movel a3@(20),sp@-
	jbsr _reset__13DeltaAnalyser
	addw #32,sp
	movel a3@(16),a0
	movel a0@(2),a1
	movel a0,sp@-
	movel a1@(20),a0
	jbsr a0@
	movel #8192,d4
	divsl d0,d4
	clrl d5
	movel a3@(16),a0
	movel a0@(2),a1
	movel d4,sp@-
	moveq #24,d3
	addl a3,d3
	movel d3,sp@-
	movel a0,sp@-
	movel a1@(32),a0
	jbsr a0@
	movel d0,d2
	movel a3@(16),a0
	movel a0@(2),a1
	movel a0,sp@-
	movel a1@(20),a0
	jbsr a0@
	movel d0,d6
	addw #20,sp
	tstl d2
	jle L325
	.even
L326:
	movel d6,sp@-
	movel d2,sp@-
	movel d3,sp@-
	movel a3@(20),sp@-
	jbsr _analyse__13DeltaAnalyserPsUlUl
	movel d2,sp@-
	addql #1,d5
	movel d5,sp@-
	pea LC10
	jbsr a2@
	movel ___sF,a0
	movel a0@(4),sp@-
	jbsr _fflush
	addw #32,sp
	movel a3@(16),a0
	movel a0@(2),a1
	movel d4,sp@-
	movel d3,sp@-
	movel a0,sp@-
	movel a1@(32),a0
	jbsr a0@
	movel d0,d2
	addw #12,sp
	jgt L326
L325:
	pea 10:w
	jbsr _putchar
	movel a3@(20),sp@-
	jbsr _getTotalUniqueDelta__13DeltaAnalyser
	movel d0,sp@-
	pea LC11
	jbsr a2@
	movel a3@(20),sp@-
	jbsr _getPeak__13DeltaAnalyser
	movel d0,sp@-
	pea LC12
	jbsr a2@
	movel a3@(20),sp@-
	jbsr _getMostFreq__13DeltaAnalyser
	movel d0,sp@-
	pea LC13
	jbsr a2@
	addw #36,sp
	movel a3@(20),sp@
	jbsr _dump__13DeltaAnalyser
	clrl d0
	moveml a5@(-28),#0xc7c
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
