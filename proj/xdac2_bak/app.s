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
	pea 8:w
	jbsr ___nw__FUlRC9nothrow_t
	movel d0,a5@(-52)
	movel a5@(-56),a0
	addql #4,a0
	movel a0@,a5@(-24)
	clrl a5@(-20)
	movel a5,a5@(-16)
	movel #L105,a5@(-12)
	movel sp,a5@(-8)
	movel a0,a5@(-60)
	jra L104
	.even
L105:
	movel a5@(-56),a0
	addql #4,a0
	movel a0,a5@(-60)
	jra L102
	.even
L104:
	lea a5@(-24),a1
	movel a1,a0@
	movel a5@(-52),sp@-
	jbsr ___3App
	movel a5@(-60),a1
	movel a1@,a0
	movel a0@,a1@
	jra L116
	.even
L102:
	movel a5@(-60),a0
	movel a0@,a5@(-48)
	clrl a5@(-44)
	movel a5,a5@(-40)
	movel #L111,a5@(-36)
	movel sp,a5@(-32)
	jra L110
	.even
L111:
	jra L117
	.even
L110:
	lea a5@(-48),a0
	movel a5@(-60),a1
	movel a0,a1@
	moveq #1,d0
	jeq L113
	pea _nothrow
	movel a5@(-52),sp@-
	jbsr ___dl__FPvRC9nothrow_t
	addql #8,sp
L113:
	movel a5@(-56),a1
	addql #4,a1
	movel a1@,a0
	movel a0@,a1@
	jbsr ___sjthrow
	.even
L117:
L108:
	jbsr ___terminate
	.even
L116:
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
	jeq L120
	movel a1@,a0
	pea 3:w
	movel a1,sp@-
	movel a0@(20),a0
	jbsr a0@
L120:
	unlk a5
	rts
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
	movel #L129,a5@(-12)
	movel sp,a5@(-8)
	jra L128
	.even
L129:
	jra L153
	.even
L128:
	lea a5@(-24),a1
	movel a1,a0@
	movel a5@(8),a0
	movel #___vt_3App,a0@
	pea _nothrow
	pea 4:w
	movel d1,a1
	addql #4,a1
	movel a1,a5@(-104)
	jbsr ___nw__FUlRC9nothrow_t
	movel d0,a5@(-100)
	movel a5@(-104),a0
	movel a0@,a5@(-48)
	clrl a5@(-44)
	movel a5,a5@(-40)
	movel #L133,a5@(-36)
	movel sp,a5@(-32)
	jra L132
	.even
L133:
	jra L154
	.even
L132:
	lea a5@(-48),a1
	movel a1,a0@
	movel a5@(-100),sp@-
	jbsr ___9CompBasic
	movel a5@(8),a0
	movel d0,a0@(4)
	movel a5@(-104),a1
	movel a1@,a0
	movel a0@,a1@
	movel a1@,a0
	movel a0@,a1@
	movel a5@(8),d0
	jra L152
	.even
L154:
L130:
	movel a5@(-104),a0
	movel a0@,a5@(-72)
	clrl a5@(-68)
	movel a5,a5@(-64)
	movel #L140,a5@(-60)
	movel sp,a5@(-56)
	jra L139
	.even
L140:
	jra L155
	.even
L139:
	lea a5@(-72),a0
	movel a5@(-104),a1
	movel a0,a1@
	moveq #1,d0
	jeq L142
	pea _nothrow
	movel a5@(-100),sp@-
	jbsr ___dl__FPvRC9nothrow_t
	addql #8,sp
L142:
	movel a5@(-104),a1
	movel a1@,a0
	movel a0@,a1@
	jbsr ___sjthrow
	.even
L153:
L126:
	movel a5@(-104),a0
	movel a0@,a5@(-96)
	clrl a5@(-92)
	movel a5,a5@(-88)
	movel #L146,a5@(-84)
	movel sp,a5@(-80)
	jra L145
	.even
L146:
	jra L156
	.even
L145:
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
L155:
L137:
	jbsr ___terminate
	.even
L156:
L143:
	jbsr ___terminate
	.even
L152:
	moveml a5@(-216),#0x5cfc
	fmovem a5@(-176),#0x3f
	unlk a5
	rts
	.even
.globl __$_3App
__$_3App:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel a5@(8),a2
	movel #___vt_3App,a2@
	movel a2@(4),a1
	tstl a1
	jeq L160
	movel a1@,a0
	pea 3:w
	movel a1,sp@-
	movel a0@(12),a0
	jbsr a0@
	addql #8,sp
L160:
	movel #___vt_7AppBase,a2@
	movel a5@(12),d0
	btst #0,d0
	jeq L164
	movel a2,sp@-
	jbsr ___builtin_delete
L164:
	movel a5@(-4),a2
	unlk a5
	rts
	.even
.globl _initApplication__3App
_initApplication__3App:
	pea a5@
	movel sp,a5
	movel a5@(8),a0
	tstl a0@(4)
	seq d0
	extbl d0
	andl #-50528257,d0
	unlk a5
	rts
	.even
.globl _runApplication__3App
_runApplication__3App:
	pea a5@
	movel sp,a5
	movel a5@(8),a0
	movel a0@(4),a0
	movel a0@,a1
	movel a0,sp@-
	movel a1@(8),a0
	jbsr a0@
	clrl d0
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
