#NO_APP
.text
LC0:
	.ascii "timer.device\0"
	.even
.globl _init__Q28Threaded9IdleTimer
_init__Q28Threaded9IdleTimer:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel a5@(8),a2
	jbsr _CreateMsgPort
	movel d0,a0
	movel a0,a2@
	jne L135
	moveq #1,d0
	jra L139
	.even
L135:
	clrl d1
	moveb a0@(15),d1
	moveq #1,d0
	lsll d1,d0
	movel d0,a2@(8)
	pea 40:w
	movel a0,sp@-
	jbsr _CreateExtIO
	movel d0,a2@(4)
	addql #8,sp
	jne L136
	moveq #2,d0
	jra L139
	.even
L136:
	clrl sp@-
	movel d0,sp@-
	clrl sp@-
	pea LC0
	jbsr _OpenDevice
	tstb d0
	jne L137
	moveq #1,d0
	jra L138
	.even
L137:
	moveq #4,d0
L139:
	orl d0,a2@(16)
	clrb d0
L138:
	movel a5@(-4),a2
	unlk a5
	rts
	.even
.globl _done__Q28Threaded9IdleTimer
_done__Q28Threaded9IdleTimer:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel a5@(8),a2
	movel a2@(4),d0
	jeq L141
	btst #3,a2@(19)
	jeq L142
	movel d0,sp@-
	jbsr _AbortIO
	movel a2@(4),sp@-
	jbsr _WaitIO
	movel a2@(8),sp@-
	clrl sp@-
	jbsr _SetSignal
	addw #16,sp
L142:
	movel a2@(4),sp@-
	jbsr _CloseDevice
	movel a2@(4),sp@-
	jbsr _DeleteExtIO
	addql #8,sp
L141:
	movel a2@,d0
	jeq L143
	movel d0,sp@-
	jbsr _DeleteMsgPort
L143:
	clrl a2@
	clrl a2@(4)
	clrl a2@(8)
	clrl a2@(16)
	movel a5@(-4),a2
	unlk a5
	rts
	.even
.globl _abortDelay__Q28Threaded9IdleTimer
_abortDelay__Q28Threaded9IdleTimer:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel a5@(8),a2
	movel a2@(4),d0
	jeq L145
	btst #3,a2@(19)
	jeq L145
	movel d0,sp@-
	jbsr _AbortIO
	movel a2@(4),sp@-
	jbsr _WaitIO
	movel a2@(8),sp@-
	clrl sp@-
	jbsr _SetSignal
L145:
	movel a5@(-4),a2
	unlk a5
	rts
	.even
.globl _suspend__Q28Threaded9IdleTimerUlUl
_suspend__Q28Threaded9IdleTimerUlUl:
	pea a5@
	movel sp,a5
	moveml #0x3020,sp@-
	movel a5@(8),a2
	movel a5@(12),d2
	movel a5@(16),d3
	movel d3,a2@(12)
	movel d2,d0
	orl d3,d0
	jne L147
	clrl d0
	jra L150
	.even
L147:
	movel a2,sp@-
	jbsr _abortDelay__Q28Threaded9IdleTimer
	addql #4,sp
	tstl d2
	jeq L148
	movel a2@(4),a0
	movew #9,a0@(28)
	movel a2@(4),a0
	divull #1000,d0:d2
	movel d2,a0@(32)
	movel a2@(4),a0
	mulsl #1000,d0
	movel d0,a0@(36)
	movel a2@(4),sp@-
	jbsr _SendIO
	moveq #8,d0
	orl a2@(16),d0
	moveq #-17,d1
	andl d0,d1
	movel d1,a2@(16)
	addql #4,sp
	jra L149
	.even
L148:
	moveq #16,d0
	orl d0,a2@(16)
L149:
	orl a2@(8),d3
	movel d3,sp@-
	jbsr _Wait
L150:
	moveml a5@(-12),#0x40c
	unlk a5
	rts
	.even
.globl _suspend__Q28Threaded9IdleTimer
_suspend__Q28Threaded9IdleTimer:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel a5@(8),a2
	tstl a2@(12)
	jeq L152
	movel a2@(4),d0
	jeq L152
	btst #3,a2@(19)
	jeq L152
	movel d0,sp@-
	jbsr _CheckIO
	addql #4,sp
	tstl d0
	jne L154
	movel a2@(12),d0
	orl a2@(8),d0
	movel d0,sp@-
	jbsr _Wait
	jra L156
	.even
L154:
	movel a2@(8),d0
	jra L156
	.even
L152:
	clrl d0
L156:
	movel a5@(-4),a2
	unlk a5
	rts
LC1:
	.ascii "Main\0"
	.even
.globl ___10MainThread
___10MainThread:
	link a5,#-60
	fmovem #0xfc,sp@-
	moveml #0x3f3a,sp@-
	jbsr ___get_eh_context
	movel d0,a5@(-56)
	movel a5@(8),sp@-
	jbsr ___8Threaded
	movel a5@(-56),a0
	addql #4,a0
	movel a0@,a5@(-24)
	clrl a5@(-20)
	movel a5,a5@(-16)
	movel #L164,a5@(-12)
	movel sp,a5@(-8)
	movel a0,a5@(-60)
	jra L163
	.even
L164:
	movel a5@(-56),a0
	addql #4,a0
	movel a0,a5@(-60)
	jra L161
	.even
L163:
	lea a5@(-24),a1
	movel a1,a0@
	movel a5@(8),a0
	movel #___vt_10MainThread,a0@
	addql #4,sp
	movel __8Threaded$rootThread,a0@(12)
	movew #1,a0@(22)
	moveb LC1,a0@(64)
	moveb LC1+1,a0@(65)
	moveb LC1+2,a0@(66)
	moveb LC1+3,a0@(67)
	moveb LC1+4,a0@(68)
	pea a0@(28)
	jbsr _init__Q28Threaded9IdleTimer
	movew #48,a1
	addl a5@(8),a1
	movel a1,a5@(-52)
	movel a1,sp@
	jbsr _GetSysTime
	movel a5@(-52),a0
	clrl a0@(8)
	clrl a0@(12)
	movel a5@(-60),a1
	movel a1@,a0
	movel a0@,a1@
	movel a5@(8),d0
	jra L172
	.even
L161:
	movel a5@(-60),a0
	movel a0@,a5@(-48)
	clrl a5@(-44)
	movel a5,a5@(-40)
	movel #L170,a5@(-36)
	movel sp,a5@(-32)
	jra L169
	.even
L170:
	jra L173
	.even
L169:
	lea a5@(-48),a0
	movel a5@(-60),a1
	movel a0,a1@
	clrl sp@-
	movel a5@(8),sp@-
	jbsr __$_8Threaded
	movel a5@(-56),a1
	addql #4,a1
	movel a1@,a0
	movel a0@,a1@
	addql #8,sp
	jbsr ___sjthrow
	.even
L173:
L167:
	jbsr ___terminate
	.even
L172:
	moveml a5@(-172),#0x5cfc
	fmovem a5@(-132),#0x3f
	unlk a5
	rts
	.even
.globl __$_10MainThread
__$_10MainThread:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel d2,sp@-
	movel a5@(8),a2
	movel a5@(12),d2
	movel #___vt_10MainThread,a2@
	pea a2@(28)
	jbsr _done__Q28Threaded9IdleTimer
	clrw a2@(22)
	movel d2,sp@
	movel a2,sp@-
	jbsr __$_8Threaded
	movel a5@(-8),d2
	movel a5@(-4),a2
	unlk a5
	rts
.lcomm _mainThread.180,80
.lcomm __$tmp_0.181,4
	.even
___tcf_0:
	pea a5@
	movel sp,a5
	pea 2:w
	pea _mainThread.180
	jbsr __$_10MainThread
	unlk a5
	rts
	.even
.globl _getMain__6Thread
_getMain__6Thread:
	pea a5@
	movel sp,a5
	tstl __$tmp_0.181
	jne L177
	pea _mainThread.180
	jbsr ___10MainThread
	addql #4,sp
	moveq #1,d0
	movel d0,__$tmp_0.181
	pea ___tcf_0
	jbsr _atexit
L177:
	movel #_mainThread.180,d0
	unlk a5
	rts
	.even
.globl _getCurrent__6Thread
_getCurrent__6Thread:
	pea a5@
	movel sp,a5
	clrl sp@-
	jbsr _FindTask
	movel d0,a0
	addql #4,sp
	cmpl __8Threaded$rootThread,a0
	jne L180
	jbsr _getMain__6Thread
	jra L184
	.even
L180:
	tstl a0
	jeq L181
	movel a0@(88),a0
	tstl a0
	jeq L181
	movel a0,d0
	cmpl #1481854036,a0@(4)
	jeq L184
L181:
	clrl d0
L184:
	unlk a5
	rts
	.even
.globl _userBreak__6Thread
_userBreak__6Thread:
	pea a5@
	movel sp,a5
	pea 4096:w
	clrl sp@-
	jbsr _SetSignal
	bfextu d0{#19:#1},d0
	unlk a5
	rts
	.even
.globl _sleep__6ThreadUlbN22
_sleep__6ThreadUlbN22:
	pea a5@
	movel sp,a5
	jbsr _getCurrent__6Thread
	tstl d0
	jne L187
	moveq #-2,d0
	jra L188
	.even
L187:
	subql #2,sp
	moveb a5@(23),sp@(1)
	subql #2,sp
	subql #2,sp
	moveb a5@(19),sp@(1)
	subql #2,sp
	subql #2,sp
	moveb a5@(15),sp@(1)
	subql #2,sp
	movel a5@(8),sp@-
	movel d0,sp@-
	jbsr _sleep__8ThreadedUlbN22
L188:
	unlk a5
	rts
	.even
.globl _sleepResume__6Thread
_sleepResume__6Thread:
	pea a5@
	movel sp,a5
	jbsr _getCurrent__6Thread
	tstl d0
	jne L190
	moveq #-2,d0
	jra L191
	.even
L190:
	movel d0,sp@-
	jbsr _sleepResume__8Threaded
L191:
	unlk a5
	rts
	.even
.globl _sleepAbort__6Thread
_sleepAbort__6Thread:
	pea a5@
	movel sp,a5
	jbsr _getCurrent__6Thread
	tstl d0
	jeq L193
	movel d0,sp@-
	jbsr _sleepAbort__8Threaded
L193:
	unlk a5
	rts
.lcomm _dummy.203,8
.lcomm __$tmp_1.204,4
	.even
.globl _getUptime__6Thread
_getUptime__6Thread:
	pea a5@
	movel sp,a5
	tstl __$tmp_1.204
	jne L195
	clrl _dummy.203
	clrl _dummy.203+4
	moveq #1,d0
	movel d0,__$tmp_1.204
L195:
	jbsr _getCurrent__6Thread
	tstl d0
	jne L198
	movel #_dummy.203,d0
	jra L199
	.even
L198:
	movel d0,sp@-
	jbsr _getUptime__8Threaded
L199:
	unlk a5
	rts
.globl __8Threaded$threadCnt
.data
	.even
__8Threaded$threadCnt:
	.long 1
.globl __8Threaded$threadsIdle
	.even
__8Threaded$threadsIdle:
	.long 0
.globl __8Threaded$priTab
	.even
__8Threaded$priTab:
	.word 0
	.word -127
	.word -100
	.word -10
	.word -5
	.word 0
	.word 5
	.word 10
	.word 20
	.word 100
.text
	.even
.globl ___8Threaded
___8Threaded:
	link a5,#-56
	fmovem #0xfc,sp@-
	moveml #0x3f3a,sp@-
	jbsr ___get_eh_context
	movel d0,d1
	movel a5@(8),a0
	movel #___vt_8Threaded,a0@
	movel #1481854036,a0@(4)
	clrl a0@(8)
	clrl a0@(12)
	clrl a0@(16)
	movew #5,a0@(20)
	clrw a0@(22)
	clrl a0@(24)
	addw #28,a0
	clrl a0@
	clrl a0@(8)
	clrl a0@(12)
	clrl a0@(16)
	clrl a0@(4)
	movel d1,a0
	addql #4,a0
	movel a0@,a5@(-24)
	clrl a5@(-20)
	movel a5,a5@(-16)
	movel #L210,a5@(-12)
	movel sp,a5@(-8)
	jra L209
	.even
L210:
	jra L227
	.even
L209:
	lea a5@(-24),a1
	movel a1,a0@
	movew #48,a0
	addl a5@(8),a0
	movel a0,a5@(-52)
	movel a5@(8),a1
	clrl a1@(56)
	clrl a1@(60)
	movel a0,sp@-
	movel d1,a0
	addql #4,a0
	movel a0,a5@(-56)
	jbsr _GetSysTime
	movel a5@(-52),a1
	clrl a1@(8)
	clrl a1@(12)
	movel a5@(-56),a1
	movel a1@,a0
	movel a0@,a1@
	movel a5@(8),d0
	jra L226
	.even
L227:
L207:
	movel a5@(-56),a0
	movel a0@,a5@(-48)
	clrl a5@(-44)
	movel a5,a5@(-40)
	movel #L220,a5@(-36)
	movel sp,a5@(-32)
	jra L219
	.even
L220:
	jra L228
	.even
L219:
	lea a5@(-48),a0
	movel a5@(-56),a1
	movel a0,a1@
	movel a0@,a1@
	jbsr ___sjthrow
	.even
L228:
L217:
	jbsr ___terminate
	.even
L226:
	moveml a5@(-168),#0x5cfc
	fmovem a5@(-128),#0x3f
	unlk a5
	rts
	.even
.globl __$_8Threaded
__$_8Threaded:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel d2,sp@-
	movel a5@(8),a2
	movel a5@(12),d2
	movel #___vt_8Threaded,a2@
	movel a2,sp@-
	jbsr _stop__8Threaded
	addql #4,sp
	btst #0,d2
	jeq L236
	movel a2,sp@-
	jbsr ___builtin_delete
L236:
	movel a5@(-8),d2
	movel a5@(-4),a2
	unlk a5
	rts
	.even
.globl _entryPoint__8Threaded
_entryPoint__8Threaded:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel #32768,sp@-
	jbsr _Wait
	jbsr _getCurrent__6Thread
	movel d0,a2
	addql #4,sp
	tstl a2
	jeq L237
	pea a2@(28)
	jbsr _init__Q28Threaded9IdleTimer
	addql #4,sp
	tstb d0
	jne L239
	orw #2,a2@(22)
	jra L237
	.even
L239:
	orw #1,a2@(22)
	movel #32768,sp@-
	movel a2@(8),sp@-
	jbsr _Signal
	addql #1,__8Threaded$threadCnt
	movel a2@,a0
	movel a2,sp@-
	movel a0@(8),a0
	jbsr a0@
	movel d0,a2@(24)
	subql #1,__8Threaded$threadCnt
	orw #4,a2@(22)
L237:
	movel a5@(-4),a2
	unlk a5
	rts
	.even
.globl _exitPoint__8Threaded
_exitPoint__8Threaded:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	jbsr _getCurrent__6Thread
	movel d0,a2
	tstl a2
	jeq L241
	pea a2@(28)
	jbsr _done__Q28Threaded9IdleTimer
	andw #65534,a2@(22)
	movel #32768,sp@-
	movel a2@(8),sp@-
	jbsr _Signal
L241:
	movel a5@(-4),a2
	unlk a5
	rts
	.even
.globl _sleep__8ThreadedUlbN22
_sleep__8ThreadedUlbN22:
	pea a5@
	movel sp,a5
	moveml #0x3830,sp@-
	movel a5@(8),a2
	moveb a5@(27),d4
	clrl sp@-
	jbsr _FindTask
	addql #4,sp
	cmpl a2@(12),d0
	jeq L243
	moveq #-2,d0
	jra L260
	.even
L243:
	tstb d4
	jeq L244
	orw #128,a2@(22)
	jra L245
	.even
L244:
	andw #65407,a2@(22)
L245:
	movel #16384,d0
	tstb a5@(19)
	jeq L246
	orw #64,a2@(22)
	jra L247
	.even
L246:
	andw #65471,a2@(22)
	movel #20480,d0
L247:
	tstb a5@(23)
	jeq L248
	orw #32,a2@(22)
	jra L249
	.even
L248:
	andw #65503,a2@(22)
	orw #8192,d0
L249:
	addql #1,__8Threaded$threadsIdle
	orw #16,a2@(22)
	movel d0,sp@-
	movel a5@(12),sp@-
	moveq #28,d2
	addl a2,d2
	movel d2,sp@-
	jbsr _suspend__Q28Threaded9IdleTimerUlUl
	movel d0,d3
	andw #65519,a2@(22)
	subql #1,__8Threaded$threadsIdle
	addw #12,sp
	movel d2,a3
	tstb d4
	jeq L250
	movel a2,sp@-
	jbsr _sleepAbort__8Threaded
	addql #4,sp
L250:
	btst #14,d3
	jeq L251
	movel a2,sp@-
	jbsr _sleepAbort__8Threaded
	orw #8,a2@(22)
	clrl d0
	jra L260
	.even
L251:
	btst #13,d3
	jeq L253
	btst #5,a2@(23)
	jne L253
	moveq #1,d0
	jra L260
	.even
L253:
	btst #12,d3
	jeq L255
	btst #6,a2@(23)
	jne L255
	moveq #2,d0
	jra L260
	.even
L255:
	andl a3@(8),d3
	moveq #6,d0
	tstl d3
	jeq L260
	moveq #4,d0
L260:
	moveml a5@(-20),#0xc1c
	unlk a5
	rts
	.even
.globl _sleepResume__8Threaded
_sleepResume__8Threaded:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel d2,sp@-
	movel a5@(8),a2
	clrl sp@-
	jbsr _FindTask
	addql #4,sp
	cmpl a2@(12),d0
	jeq L262
	moveq #-2,d0
	jra L273
	.even
L262:
	tstb a2@(23)
	jge L263
	moveq #5,d0
	jra L273
	.even
L263:
	moveq #28,d2
	addl a2,d2
	movel d2,sp@-
	jbsr _suspend__Q28Threaded9IdleTimer
	movel d0,d1
	addql #4,sp
	movel d2,a0
	btst #14,d1
	jeq L265
	movel a0,sp@-
	jbsr _abortDelay__Q28Threaded9IdleTimer
	orw #8,a2@(22)
	clrl d0
	jra L273
	.even
L265:
	btst #13,d1
	jeq L267
	btst #5,a2@(23)
	jne L267
	moveq #1,d0
	jra L273
	.even
L267:
	btst #12,d1
	jeq L269
	btst #6,a2@(23)
	jne L269
	moveq #2,d0
	jra L273
	.even
L269:
	andl a0@(8),d1
	moveq #4,d0
	tstl d1
	jne L273
	moveq #6,d0
L273:
	movel a5@(-8),d2
	movel a5@(-4),a2
	unlk a5
	rts
	.even
.globl _sleepAbort__8Threaded
_sleepAbort__8Threaded:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel a5@(8),a2
	pea a2@(28)
	jbsr _abortDelay__Q28Threaded9IdleTimer
	orw #128,a2@(22)
	movel a5@(-4),a2
	unlk a5
	rts
LC2:
	.ascii "Thread [%ld]\0"
	.even
.globl _start__8ThreadedPCcQ28Threaded8PriorityUl
_start__8ThreadedPCcQ28Threaded8PriorityUl:
	link a5,#-128
	moveml #0x2030,sp@-
	movel a5@(8),a3
	movel a5@(12),d2
	btst #0,a3@(23)
	jeq L276
	moveq #-4,d0
	jra L288
	.even
L276:
	clrl sp@-
	jbsr _FindTask
	movel d0,a3@(8)
	movel a5@(20),a3@(16)
	movew a5@(18),a3@(20)
	addql #4,sp
	tstl d2
	jeq L277
	pea 15:w
	movel d2,sp@-
	moveq #64,d2
	addl a3,d2
	movel d2,sp@-
	jbsr _strncpy
	jra L290
	.even
L277:
	movel __8Threaded$threadCnt,d0
	addql #1,d0
	movel d0,sp@-
	pea LC2
	moveq #64,d2
	addl a3,d2
	movel d2,sp@-
	jbsr _sprintf
L290:
	addw #12,sp
	movel #-2147482645,a5@(-128)
	movel #_entryPoint__8Threaded,a5@(-124)
	movel #-2147482637,a5@(-120)
	movel a3@(16),a5@(-116)
	movel #-2147482635,a5@(-112)
	movew a3@(20),a0
	lea __8Threaded$priTab,a1
	movew a1@(a0:l:2),a1
	movel a1,a5@(-108)
	movel #-2147482636,a5@(-104)
	movel d2,a5@(-100)
	movel #-2147482624,a5@(-96)
	movel #_exitPoint__8Threaded,a5@(-92)
	clrl a5@(-84)
	movel #-2147482646,a5@(-88)
	movel #-2147482641,a5@(-80)
	moveq #1,d0
	movel d0,a5@(-76)
	clrl a5@(-72)
	clrl a5@(-68)
	moveq #-64,d2
	addl a5,d2
	pea 64:w
	movel d2,sp@-
	pea a5@(-128)
	jbsr _bcopy
	addw #12,sp
	clrw a3@(22)
	movel d2,sp@-
	jbsr _CreateNewProc
	movel d0,a0
	movel a0,a3@(12)
	addql #4,sp
	jne L279
	moveq #-1,d0
	jra L288
	.even
L279:
	movel a3,a0@(88)
	lea a3@(48),a2
	movel a2,sp@-
	jbsr _GetSysTime
	clrl a2@(8)
	clrl a2@(12)
	movel #32768,sp@
	movel a3@(12),sp@-
	jbsr _Signal
	addql #8,sp
	bftst a3@(23){#5:#3}
	jne L283
	.even
L284:
	movel #32768,sp@-
	jbsr _Wait
	addql #4,sp
	bftst a3@(23){#5:#3}
	jeq L284
L283:
	movew a3@(22),d0
	btst #1,d0
	jeq L286
	clrw a3@(22)
	moveq #-1,d0
	jra L288
	.even
L286:
	btst #2,d0
	jeq L287
	movew #4,a3@(22)
	clrl a3@(12)
L287:
	clrl d0
L288:
	moveml a5@(-140),#0xc04
	unlk a5
	rts
	.even
.globl _stop__8Threaded
_stop__8Threaded:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel d2,sp@-
	movel a5@(8),a2
	movel a2@(12),d1
	cmpl __8Threaded$rootThread,d1
	jne L292
	moveq #-2,d0
	jra L300
	.even
L292:
	moveb a2@(23),d0
	eorb #1,d0
	btst #0,d0
	jne L294
	tstl d1
	jne L293
L294:
	moveq #-3,d0
	jra L300
	.even
L293:
	clrl sp@-
	jbsr _FindTask
	movel d0,a2@(8)
	movel a2@(12),d1
	addql #4,sp
	cmpl d1,d0
	jne L295
	clrl a2@(8)
	moveq #-2,d0
	jra L300
	.even
L295:
	orw #8,a2@(22)
	pea 16384:w
	movel d1,sp@-
	jbsr _Signal
	addql #8,sp
	moveq #48,d2
	addl a2,d2
	btst #0,a2@(23)
	jeq L297
	.even
L298:
	movel #32768,sp@-
	jbsr _Wait
	addql #4,sp
	btst #0,a2@(23)
	jne L298
L297:
	clrl a2@(12)
	movel d2,sp@-
	jbsr _elapsed__C5Clock
	clrl d0
L300:
	movel a5@(-8),d2
	movel a5@(-4),a2
	unlk a5
	rts
	.even
.globl _wake__8Threaded
_wake__8Threaded:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel a5@(8),a2
	tstl a2@(12)
	jeq L304
	moveb a2@(23),d0
	eorb #1,d0
	btst #0,d0
	jeq L303
L304:
	moveq #-3,d0
	jra L309
	.even
L303:
	clrl sp@-
	jbsr _FindTask
	movel a2@(12),d1
	addql #4,sp
	cmpl d1,d0
	jne L306
	moveq #-2,d0
	jra L309
	.even
L306:
	btst #5,a2@(23)
	jne L305
	pea 8192:w
	movel d1,sp@-
	jbsr _Signal
	clrl d0
	jra L309
	.even
L305:
	moveq #-5,d0
L309:
	movel a5@(-4),a2
	unlk a5
	rts
	.even
.globl _setPriority__8ThreadedQ28Threaded8Priority
_setPriority__8ThreadedQ28Threaded8Priority:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel d2,sp@-
	movel a5@(8),a2
	movel a5@(12),d2
	tstl a2@(12)
	jeq L312
	moveb a2@(23),d0
	eorb #1,d0
	btst #0,d0
	jeq L311
L312:
	moveq #-3,d0
	jra L315
	.even
L311:
	clrl sp@-
	jbsr _FindTask
	addql #4,sp
	cmpl a2@(12),d0
	jne L313
	moveq #5,d0
	cmpl d2,d0
	jge L313
	movel #-50397184,d0
	jra L315
	.even
L313:
	movew d2,a2@(20)
	movew d2,a1
	lea __8Threaded$priTab,a0
	movew a0@(a1:l:2),a0
	movel a0,sp@-
	movel a2@(12),sp@-
	jbsr _SetTaskPri
	clrl d0
L315:
	movel a5@(-8),d2
	movel a5@(-4),a2
	unlk a5
	rts
	.even
.globl _getUptime__8Threaded
_getUptime__8Threaded:
	pea a5@
	movel sp,a5
	movel a5@(8),a0
	tstl a0@(12)
	jeq L318
	moveb a0@(23),d0
	eorb #1,d0
	btst #0,d0
	jeq L317
L318:
	moveq #56,d0
	addl a0,d0
	jra L320
	.even
L317:
	pea a0@(48)
	jbsr _elapsed__C5Clock
L320:
	unlk a5
	rts
	.even
.globl _waitForSignals__19ThreadedImplementorP8ThreadedUl
_waitForSignals__19ThreadedImplementorP8ThreadedUl:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel d2,sp@-
	movel a5@(8),a2
	movel a5@(12),d2
	clrl sp@-
	jbsr _FindTask
	addql #4,sp
	cmpl a2@(12),d0
	jeq L322
	movel d2,d0
	notl d0
	jra L323
	.even
L322:
	movel d2,sp@-
	jbsr _Wait
L323:
	movel a5@(-8),d2
	movel a5@(-4),a2
	unlk a5
	rts
	.even
.globl _tryLock__8Lockable
_tryLock__8Lockable:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel a5@(8),a2
	tstb a2@(46)
	jeq L325
	moveq #-3,d0
	jra L329
	.even
L325:
	movel a2,sp@-
	jbsr _AttemptSemaphore
	addql #4,sp
	tstl d0
	jeq L326
	tstb a2@(46)
	jeq L327
	movel a2,sp@-
	jbsr _ReleaseSemaphore
	moveq #-3,d0
	jra L329
	.even
L327:
	clrl d0
	jra L329
	.even
L326:
	moveq #-1,d0
L329:
	movel a5@(-4),a2
	unlk a5
	rts
	.even
.globl _waitLock__8Lockable
_waitLock__8Lockable:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel a5@(8),a2
	tstb a2@(46)
	jne L334
	movel a2,sp@-
	jbsr _ObtainSemaphore
	addql #4,sp
	tstb a2@(46)
	jne L332
	clrl d0
	jra L333
	.even
L332:
	movel a2,sp@-
	jbsr _ReleaseSemaphore
L334:
	moveq #-3,d0
L333:
	movel a5@(-4),a2
	unlk a5
	rts
	.even
.globl _tryReadOnlyLock__8Lockable
_tryReadOnlyLock__8Lockable:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel a5@(8),a2
	tstb a2@(46)
	jeq L336
	moveq #-3,d0
	jra L340
	.even
L336:
	movel a2,sp@-
	jbsr _AttemptSemaphoreShared
	addql #4,sp
	tstl d0
	jeq L337
	tstb a2@(46)
	jeq L338
	movel a2,sp@-
	jbsr _ReleaseSemaphore
	moveq #-3,d0
	jra L340
	.even
L338:
	clrl d0
	jra L340
	.even
L337:
	moveq #-1,d0
L340:
	movel a5@(-4),a2
	unlk a5
	rts
	.even
.globl _waitReadOnlyLock__8Lockable
_waitReadOnlyLock__8Lockable:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel a5@(8),a2
	tstb a2@(46)
	jne L345
	movel a2,sp@-
	jbsr _ObtainSemaphoreShared
	addql #4,sp
	tstb a2@(46)
	jne L343
	clrl d0
	jra L344
	.even
L343:
	movel a2,sp@-
	jbsr _ReleaseSemaphore
L345:
	moveq #-3,d0
L344:
	movel a5@(-4),a2
	unlk a5
	rts
	.even
.globl _pending__8Lockable
_pending__8Lockable:
	pea a5@
	movel sp,a5
	movel a5@(8),a1
	tstb a1@(46)
	jne L347
	movew a1@(14),a0
	subw a1@(44),a0
	movel a0,d0
	subql #1,d0
	jra L348
	.even
L347:
	moveq #-3,d0
L348:
	unlk a5
	rts
	.even
.globl _freeLock__8Lockable
_freeLock__8Lockable:
	pea a5@
	movel sp,a5
	movel a5@(8),a0
	tstb a0@(46)
	jne L350
	movel a0,sp@-
	jbsr _ReleaseSemaphore
L350:
	unlk a5
	rts
	.even
.globl _active__8Lockable
_active__8Lockable:
	pea a5@
	movel sp,a5
	movel a5@(8),a0
	tstb a0@(46)
	jne L352
	movew a0@(14),d0
	extl d0
	jra L353
	.even
L352:
	moveq #-3,d0
L353:
	unlk a5
	rts
	.even
.globl _getExclusiveOwner__8Lockable
_getExclusiveOwner__8Lockable:
	pea a5@
	movel sp,a5
	movel a5@(8),a0
	tstb a0@(46)
	jne L355
	movel a0@(40),a0
	cmpl __8Threaded$rootThread,a0
	jne L356
	jbsr _getMain__6Thread
	jra L360
	.even
L356:
	tstl a0
	jeq L355
	movel a0@(88),a0
	tstl a0
	jeq L355
	movel a0,d0
	cmpl #1481854036,a0@(4)
	jeq L360
L355:
	clrl d0
L360:
	unlk a5
	rts
	.even
.globl ___8Lockable
___8Lockable:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel a5@(8),a2
	movel #___vt_8Lockable,a2@(48)
	clrb a2@(46)
	movel a2,sp@-
	jbsr _InitSemaphore
	movel a2,d0
	movel a5@(-4),a2
	unlk a5
	rts
	.even
.globl __$_8Lockable
__$_8Lockable:
	pea a5@
	movel sp,a5
	moveml #0x38,sp@-
	movel a5@(8),a4
	movel #___vt_8Lockable,a4@(48)
	tstb a4@(46)
	jne L365
	movel a4,sp@-
	lea _ObtainSemaphore,a3
	jbsr a3@
	moveb #1,a4@(46)
	movel a4,sp@-
	lea _ReleaseSemaphore,a2
	jbsr a2@
	movel a4,sp@-
	jbsr a3@
	movel a4,sp@-
	jbsr a2@
	addw #16,sp
L365:
	movel a5@(12),d0
	btst #0,d0
	jeq L367
	movel a4,sp@-
	jbsr ___builtin_delete
L367:
	moveml a5@(-12),#0x1c00
	unlk a5
	rts
.globl ___vt_10MainThread
	.even
___vt_10MainThread:
	.long 0
	.long ___tf10MainThread
	.long _run__10MainThread
	.long __$_10MainThread
	.skip 4
.globl ___vt_8Lockable
	.even
___vt_8Lockable:
	.long 0
	.long ___tf8Lockable
	.long __$_8Lockable
	.skip 4
.globl ___vt_8Threaded
	.even
___vt_8Threaded:
	.long 0
	.long ___tf8Threaded
	.long ___pure_virtual
	.long __$_8Threaded
	.skip 4
.globl __8Threaded$rootThread
	.bss
__8Threaded$rootThread:
	.skip 4
.text
	.even
___static_initialization_and_destruction_0:
	pea a5@
	movel sp,a5
	cmpl #65535,a5@(12)
	jne L369
	tstl a5@(8)
	jeq L369
	clrl sp@-
	jbsr _FindTask
	movel d0,__8Threaded$rootThread
L369:
	unlk a5
	rts
.comm ___ti7AppBase,8
LC3:
	.ascii "7AppBase\0"
.comm ___ti8Runnable,8
LC4:
	.ascii "8Runnable\0"
.comm ___ti8Threaded,12
LC5:
	.ascii "8Threaded\0"
.comm ___ti8Lockable,8
LC6:
	.ascii "8Lockable\0"
.comm ___ti10MainThread,12
LC7:
	.ascii "10MainThread\0"
	.even
.globl ___tf8Threaded
___tf8Threaded:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	lea ___ti8Threaded,a2
	tstl a2@
	jne L377
	tstl ___ti8Runnable
	jne L379
	pea LC4
	pea ___ti8Runnable
	jbsr ___rtti_user
	addql #8,sp
L379:
	pea ___ti8Runnable
	pea LC5
	movel a2,sp@-
	jbsr ___rtti_si
L377:
	movel #___ti8Threaded,d0
	movel a5@(-4),a2
	unlk a5
	rts
	.even
.globl _hasStarted__C8Threaded
_hasStarted__C8Threaded:
	pea a5@
	movel sp,a5
	movel a5@(8),a0
	moveb a0@(23),d0
	andb #1,d0
	unlk a5
	rts
	.even
.globl _hasCompleted__C8Threaded
_hasCompleted__C8Threaded:
	pea a5@
	movel sp,a5
	movel a5@(8),a0
	bfextu a0@(23){#5:#1},d0
	unlk a5
	rts
	.even
.globl _isSleeping__C8Threaded
_isSleeping__C8Threaded:
	pea a5@
	movel sp,a5
	movel a5@(8),a0
	clrb d0
	movew a0@(22),d1
	btst #0,d1
	jeq L95
	btst #4,d1
	sne d0
	negb d0
L95:
	unlk a5
	rts
	.even
.globl _isRunning__C8Threaded
_isRunning__C8Threaded:
	pea a5@
	movel sp,a5
	movel a5@(8),a0
	clrb d0
	movew a0@(22),d1
	btst #0,d1
	jeq L98
	btst #2,d1
	jne L98
	btst #4,d1
	seq d0
	negb d0
L98:
	unlk a5
	rts
	.even
.globl _getPriority__C8Threaded
_getPriority__C8Threaded:
	pea a5@
	movel sp,a5
	movel a5@(8),a0
	movew a0@(20),d0
	extl d0
	unlk a5
	rts
	.even
.globl _getRetVal__C8Threaded
_getRetVal__C8Threaded:
	pea a5@
	movel sp,a5
	movel a5@(8),a0
	movel a0@(24),d0
	unlk a5
	rts
	.even
.globl _getName__C8Threaded
_getName__C8Threaded:
	pea a5@
	movel sp,a5
	moveq #64,d0
	addl a5@(8),d0
	unlk a5
	rts
	.even
.globl _shutDownReq__8Threaded
_shutDownReq__8Threaded:
	pea a5@
	movel sp,a5
	movel a5@(8),a0
	bfextu a0@(23){#4:#1},d0
	unlk a5
	rts
	.even
.globl ___tf8Lockable
___tf8Lockable:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	lea ___ti8Lockable,a2
	tstl a2@
	jne L381
	pea LC6
	movel a2,sp@-
	jbsr ___rtti_user
L381:
	movel a2,d0
	movel a5@(-4),a2
	unlk a5
	rts
	.even
.globl ___tf10MainThread
___tf10MainThread:
	pea a5@
	movel sp,a5
	tstl ___ti10MainThread
	jne L383
	tstl ___ti8Threaded
	jne L387
	tstl ___ti8Runnable
	jne L386
	pea LC4
	pea ___ti8Runnable
	jbsr ___rtti_user
	addql #8,sp
L386:
	pea ___ti8Runnable
	pea LC5
	pea ___ti8Threaded
	jbsr ___rtti_si
	addw #12,sp
L387:
	pea ___ti8Threaded
	pea LC7
	pea ___ti10MainThread
	jbsr ___rtti_si
L383:
	movel #___ti10MainThread,d0
	unlk a5
	rts
	.even
.globl _run__10MainThread
_run__10MainThread:
	pea a5@
	movel sp,a5
	moveq #-2,d0
	unlk a5
	rts
	.even
.globl _start__10MainThreadlUl
_start__10MainThreadlUl:
	pea a5@
	movel sp,a5
	moveq #-2,d0
	unlk a5
	rts
	.even
.globl _stop__10MainThread
_stop__10MainThread:
	pea a5@
	movel sp,a5
	moveq #-2,d0
	unlk a5
	rts
	.even
.globl _INIT_8_init__Q28Threaded9IdleTimerthread_cpp
_INIT_8_init__Q28Threaded9IdleTimerthread_cpp:
	pea a5@
	movel sp,a5
	movel #65535,sp@-
	pea 1:w
	jbsr ___static_initialization_and_destruction_0
	unlk a5
	rts
.stabs "___CTOR_LIST__",22,0,0,_INIT_8_init__Q28Threaded9IdleTimerthread_cpp
