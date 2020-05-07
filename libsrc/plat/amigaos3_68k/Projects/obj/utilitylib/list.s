#NO_APP
.globl __7_LLBase$linkCache
.data
	.even
__7_LLBase$linkCache:
	.long 0
.globl __7_LLBase$linkCacheSize
	.even
__7_LLBase$linkCacheSize:
	.long 0
.globl __7_LLBase$linkCacheDelta
	.even
__7_LLBase$linkCacheDelta:
	.long 256
.globl __7_LLBase$linkCount
	.even
__7_LLBase$linkCount:
	.long 0
.globl __7_LLBase$nextFree
	.even
__7_LLBase$nextFree:
	.long -1
.text
	.even
.globl _createLink__7_LLBase
_createLink__7_LLBase:
	pea a5@
	movel sp,a5
	movel __7_LLBase$linkCount,d0
	movel d0,d1
	addql #1,d1
	movel d1,__7_LLBase$linkCount
	addql #1,d0
	cmpl __7_LLBase$linkCacheSize,d0
	jle L77
	jbsr _expandCache__7_LLBase
	tstb d0
	jne L77
	subql #1,__7_LLBase$linkCount
	moveq #-1,d0
	jra L79
	.even
L77:
	movel __7_LLBase$nextFree,d0
	movel __7_LLBase$linkCache,a0
	movel d0,d1
	lsll #4,d1
	movel a0@(8,d1:l),__7_LLBase$nextFree
L79:
	unlk a5
	rts
	.even
.globl _destroyLink__7_LLBasel
_destroyLink__7_LLBasel:
	pea a5@
	movel sp,a5
	movel a5@(8),a1
	movel __7_LLBase$linkCount,d1
	jle L81
	moveq #-1,d0
	cmpl a1,d0
	jeq L81
	cmpl __7_LLBase$linkCacheSize,a1
	jge L81
	movel __7_LLBase$linkCache,a0
	movel a1,d0
	lsll #4,d0
	tstl a0@(12,d0:l)
	jeq L81
	clrl a0@(12,d0:l)
	movel __7_LLBase$nextFree,a0@(8,d0:l)
	movel a1,__7_LLBase$nextFree
	movel d1,d0
	subql #1,d0
	movel d0,__7_LLBase$linkCount
	moveq #1,d0
	cmpl d1,d0
	jne L81
	movel a0,sp@-
	jbsr _free__3MemPv
	clrl __7_LLBase$linkCacheSize
	moveq #-1,d0
	movel d0,__7_LLBase$nextFree
L81:
	unlk a5
	rts
	.even
.globl _expandCache__7_LLBase
_expandCache__7_LLBase:
	pea a5@
	movel sp,a5
	moveml #0x3020,sp@-
	movel __7_LLBase$linkCacheSize,d2
	addl __7_LLBase$linkCacheDelta,d2
	pea 16:w
	subql #2,sp
	moveb #0,sp@(1)
	subql #2,sp
	movel d2,d0
	lsll #4,d0
	movel d0,sp@-
	jbsr _alloc__3MemUlbQ23Mem9AlignType
	movel d0,a2
	addw #12,sp
	tstl a2
	jne L84
	clrb d0
	jra L91
	.even
L84:
	movel __7_LLBase$linkCache,d1
	jeq L85
	movel __7_LLBase$linkCacheSize,d0
	lsll #4,d0
	movel d0,sp@-
	movel d1,sp@-
	movel a2,sp@-
	jbsr _copy__3MemPvPCvUl
	movel __7_LLBase$linkCache,sp@-
	jbsr _free__3MemPv
L85:
	movel a2,__7_LLBase$linkCache
	movel __7_LLBase$linkCacheSize,d1
	cmpl d1,d2
	jle L87
	movel d1,d0
	lsll #4,d0
	lea a2@(12,d0:l),a0
	movel d2,d0
	subl d1,d0
	moveq #3,d3
	andl d3,d0
	jeq L93
	moveq #1,d3
	cmpl d0,d3
	jge L94
	moveq #2,d3
	cmpl d0,d3
	jge L95
	movel d1,d0
	addql #1,d0
	movel d0,a0@(-4)
	clrl a0@
	addw #16,a0
	movel d0,d1
L95:
	movel d1,d0
	addql #1,d0
	movel d0,a0@(-4)
	clrl a0@
	addw #16,a0
	movel d0,d1
L94:
	movel d1,d0
	addql #1,d0
	movel d0,a0@(-4)
	clrl a0@
	addw #16,a0
	movel d0,d1
	cmpl d1,d2
	jle L87
L93:
	movel a0,a1
	.even
L89:
	movel d1,d0
	addql #1,d0
	movel d0,a1@(-4)
	clrl a0@
	addql #1,d0
	movel d0,a1@(12)
	clrl a0@(16)
	addql #1,d0
	movel d0,a1@(28)
	clrl a0@(32)
	addql #1,d0
	movel d0,a1@(44)
	clrl a0@(48)
	addw #64,a0
	addw #64,a1
	movel d0,d1
	cmpl d1,d2
	jgt L89
L87:
	movel __7_LLBase$linkCacheSize,__7_LLBase$nextFree
	movel d2,__7_LLBase$linkCacheSize
	moveq #1,d0
L91:
	moveml a5@(-12),#0x40c
	unlk a5
	rts
	.even
.globl ___7_LLBase
___7_LLBase:
	pea a5@
	movel sp,a5
	moveml #0x2030,sp@-
	movel a5@(8),a3
	clrl a3@(12)
	lea _createLink__7_LLBase,a2
	jbsr a2@
	movel d0,a3@
	jbsr a2@
	movel d0,a3@(4)
	movel a3@,d1
	moveq #-1,d2
	cmpl d1,d2
	jeq L113
	cmpl d0,d2
	jeq L113
	movel __7_LLBase$linkCache,a0
	lsll #4,d1
	movel d2,a0@(d1:l)
	movel a3@,d0
	lsll #4,d0
	movel a3@(4),a0@(4,d0:l)
	movel a3@,d0
	lsll #4,d0
	movel a3,a0@(12,d0:l)
	movel a3@(4),d0
	lsll #4,d0
	movel a3@,a0@(d0:l)
	movel a3@(4),d0
	lsll #4,d0
	movel d2,a0@(4,d0:l)
	movel a3@(4),d0
	lsll #4,d0
	movel a3,a0@(12,d0:l)
	movel a3@(4),a3@(8)
L113:
	movel a3,d0
	moveml a5@(-12),#0xc04
	unlk a5
	rts
	.even
.globl __$_7_LLBase
__$_7_LLBase:
	pea a5@
	movel sp,a5
	moveml #0x2030,sp@-
	movel a5@(8),a2
	movel a2@,d0
	movel __7_LLBase$linkCache,a0
	lsll #4,d0
	movel a0@(4,d0:l),d1
	lea _destroyLink__7_LLBasel,a3
	moveq #-1,d0
	cmpl d1,d0
	jeq L116
	cmpl a2@(4),d1
	jeq L116
	.even
L117:
	movel __7_LLBase$linkCache,a0
	movel d1,d0
	lsll #4,d0
	movel a0@(4,d0:l),d2
	movel d1,sp@-
	jbsr a3@
	movel d2,d1
	addql #4,sp
	moveq #-1,d0
	cmpl d2,d0
	jeq L116
	cmpl a2@(4),d2
	jne L117
L116:
	movel a2@,sp@-
	jbsr a3@
	movel a2@(4),sp@-
	jbsr a3@
	addql #8,sp
	movel a5@(12),d0
	btst #0,d0
	jeq L122
	movel a2,sp@-
	jbsr ___builtin_delete
L122:
	moveml a5@(-12),#0xc04
	unlk a5
	rts
	.even
.globl _findFwrd__7_LLBaselPv
_findFwrd__7_LLBaselPv:
	pea a5@
	movel sp,a5
	movel d2,sp@-
	movel a5@(8),a1
	movel a5@(12),d0
	movel a5@(16),d2
	jeq L125
	tstl a1@(12)
	jle L125
	movel __7_LLBase$linkCache,a0
	lsll #4,d0
	movel a0@(4,d0:l),d0
	moveq #-1,d1
	cmpl d0,d1
	jeq L125
	movel a1@(4),d1
	cmpl d0,d1
	jeq L125
	movel d1,a1
	.even
L128:
	movel d0,d1
	lsll #4,d1
	cmpl a0@(12,d1:l),d2
	jeq L132
	movel a0@(4,d1:l),d0
	moveq #-1,d1
	cmpl d0,d1
	jeq L125
	cmpl d0,a1
	jne L128
L125:
	moveq #-1,d0
L132:
	movel sp@+,d2
	unlk a5
	rts
	.even
.globl _findBkwd__7_LLBaselPv
_findBkwd__7_LLBaselPv:
	pea a5@
	movel sp,a5
	movel d2,sp@-
	movel a5@(8),a1
	movel a5@(12),d0
	movel a5@(16),d2
	jeq L135
	tstl a1@(12)
	jle L135
	movel __7_LLBase$linkCache,a0
	lsll #4,d0
	movel a0@(d0:l),d0
	moveq #-1,d1
	cmpl d0,d1
	jeq L135
	movel a1@,d1
	cmpl d0,d1
	jeq L135
	movel d1,a1
	.even
L138:
	movel d0,d1
	lsll #4,d1
	cmpl a0@(12,d1:l),d2
	jeq L142
	movel a0@(d1:l),d0
	moveq #-1,d1
	cmpl d0,d1
	jeq L135
	cmpl d0,a1
	jne L138
L135:
	moveq #-1,d0
L142:
	movel sp@+,d2
	unlk a5
	rts
	.even
.globl _rem__7_LLBasell
_rem__7_LLBasell:
	pea a5@
	movel sp,a5
	moveml #0x3f20,sp@-
	movel a5@(8),d6
	movel a5@(12),d5
	cmpl d6,d5
	jeq L145
	movel __7_LLBase$linkCache,a2
	movel d6,d0
	lsll #4,d0
	movel a2@(4,d0:l),d2
	clrl d4
	movel d0,d7
	movel d5,d3
	lsll #4,d3
	jra L153
	.even
L148:
	movel d2,sp@-
	jbsr _destroyLink__7_LLBasel
	movel d2,d0
	lsll #4,d0
	movel a2@(4,d0:l),d2
	addql #1,d4
	addql #4,sp
L153:
	moveq #-1,d0
	cmpl d2,d0
	jeq L147
	cmpl d2,d5
	jne L148
L147:
	movel d5,a2@(4,d7:l)
	movel d6,a2@(d3:l)
	movel d4,d0
	jra L151
	.even
L145:
	clrl d0
L151:
	moveml a5@(-28),#0x4fc
	unlk a5
	rts
	.even
.globl _rem__7_LLBasellPv
_rem__7_LLBasellPv:
	pea a5@
	movel sp,a5
	moveml #0x3c20,sp@-
	movel a5@(8),d0
	movel a5@(12),d4
	movel a5@(16),d5
	jeq L155
	cmpl d0,d4
	jeq L155
	movel __7_LLBase$linkCache,a2
	lsll #4,d0
	movel a2@(4,d0:l),a0
	clrl d3
	moveq #-1,d0
	cmpl a0,d0
	jeq L157
	cmpl a0,d4
	jeq L157
	.even
L158:
	movel a0,d0
	lsll #4,d0
	movel a2@(4,d0:l),d2
	cmpl a2@(12,d0:l),d5
	jne L160
	movel a2@(d0:l),d0
	movel d0,d1
	lsll #4,d1
	movel d2,a2@(4,d1:l)
	movel d2,d1
	lsll #4,d1
	movel d0,a2@(d1:l)
	movel a0,sp@-
	jbsr _destroyLink__7_LLBasel
	addql #1,d3
	addql #4,sp
L160:
	movel d2,a0
	moveq #-1,d0
	cmpl d2,d0
	jeq L157
	cmpl d2,d4
	jne L158
L157:
	movel d3,d0
	jra L162
	.even
L155:
	clrl d0
L162:
	moveml a5@(-20),#0x43c
	unlk a5
	rts
	.even
.globl _cnt__7_LLBasellPv
_cnt__7_LLBasellPv:
	pea a5@
	movel sp,a5
	movel d3,sp@-
	movel d2,sp@-
	movel a5@(8),d0
	movel a5@(12),a1
	movel a5@(16),d2
	jeq L165
	cmpl d0,a1
	jeq L165
	movel __7_LLBase$linkCache,a0
	lsll #4,d0
	movel a0@(4,d0:l),d1
	clrl d0
	moveq #-1,d3
	cmpl d1,d3
	jeq L172
	cmpl d1,a1
	jeq L172
	.even
L168:
	lsll #4,d1
	cmpl a0@(12,d1:l),d2
	jne L170
	addql #1,d0
L170:
	movel a0@(4,d1:l),d1
	moveq #-1,d3
	cmpl d1,d3
	jeq L172
	cmpl d1,a1
	jne L168
	jra L172
	.even
L165:
	clrl d0
L172:
	movel sp@+,d2
	movel sp@+,d3
	unlk a5
	rts
	.even
.globl _rep__7_LLBasellPvT3
_rep__7_LLBasellPvT3:
	pea a5@
	movel sp,a5
	moveml #0x3c00,sp@-
	movel a5@(8),d0
	movel a5@(12),d4
	movel a5@(16),d3
	movel a5@(20),d2
	tstl d3
	jeq L175
	tstl d2
	jeq L175
	cmpl d3,d2
	jeq L175
	cmpl d0,d4
	jeq L175
	movel __7_LLBase$linkCache,a0
	lsll #4,d0
	movel a0@(4,d0:l),d1
	clrl d0
	moveq #-1,d5
	cmpl d1,d5
	jeq L182
	cmpl d1,d4
	jeq L182
	movel a0,a1
	.even
L178:
	lsll #4,d1
	cmpl a0@(12,d1:l),d3
	jne L180
	movel d2,a1@(12,d1:l)
	addql #1,d0
L180:
	movel a0@(4,d1:l),d1
	moveq #-1,d5
	cmpl d1,d5
	jeq L182
	cmpl d1,d4
	jne L178
	jra L182
	.even
L175:
	clrl d0
L182:
	moveml sp@+,#0x3c
	unlk a5
	rts
	.even
.globl _contains__C7_LLBasePv
_contains__C7_LLBasePv:
	pea a5@
	movel sp,a5
	movel d3,sp@-
	movel d2,sp@-
	movel a5@(8),a0
	movel a5@(12),d3
	jeq L185
	movel a0@(12),d2
	jle L185
	movel __7_LLBase$linkCache,a1
	movel a0@(4),d0
	lsll #4,d0
	movel a1@(d0:l),d1
	movel a0@,d0
	lsll #4,d0
	movel a1@(4,d0:l),d0
	movel d2,a0
	addql #1,a0
	tstl a0
	jle L185
	.even
L188:
	lsll #4,d0
	cmpl a1@(12,d0:l),d3
	jeq L194
	subql #1,a0
	movel a1@(4,d0:l),d0
	lsll #4,d1
	cmpl a1@(12,d1:l),d3
	jne L190
L194:
	moveq #1,d0
	jra L192
	.even
L190:
	subql #1,a0
	movel a1@(d1:l),d1
	tstl a0
	jgt L188
L185:
	clrb d0
L192:
	movel sp@+,d2
	movel sp@+,d3
	unlk a5
	rts
	.even
.globl _insLast__7_LLBasePv
_insLast__7_LLBasePv:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel d2,sp@-
	movel a5@(8),a2
	movel a5@(12),d2
	jeq L196
	jbsr _createLink__7_LLBase
	movel d0,a1
	moveq #-1,d0
	cmpl a1,d0
	jeq L196
	movel __7_LLBase$linkCache,a0
	movel a1,d1
	lsll #4,d1
	movel d2,a0@(12,d1:l)
	movel a2@(4),d0
	lsll #4,d0
	movel a0@(d0:l),a0@(d1:l)
	movel a2@(4),d0
	lsll #4,d0
	movel a0@(d0:l),d0
	lsll #4,d0
	movel a1,a0@(4,d0:l)
	movel a2@(4),a0@(4,d1:l)
	movel a2@(4),d0
	lsll #4,d0
	movel a1,a0@(d0:l)
	addql #1,a2@(12)
	moveq #1,d0
	jra L198
	.even
L196:
	clrb d0
L198:
	movel a5@(-8),d2
	movel a5@(-4),a2
	unlk a5
	rts
	.even
.globl _insFirst__7_LLBasePv
_insFirst__7_LLBasePv:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel d2,sp@-
	movel a5@(8),a2
	movel a5@(12),d2
	jeq L200
	jbsr _createLink__7_LLBase
	movel d0,a1
	moveq #-1,d0
	cmpl a1,d0
	jeq L200
	movel __7_LLBase$linkCache,a0
	movel a1,d1
	lsll #4,d1
	movel d2,a0@(12,d1:l)
	movel a2@,d0
	lsll #4,d0
	movel a0@(4,d0:l),a0@(4,d1:l)
	movel a2@,d0
	lsll #4,d0
	movel a0@(4,d0:l),d0
	lsll #4,d0
	movel a1,a0@(d0:l)
	movel a2@,a0@(d1:l)
	movel a2@,d0
	lsll #4,d0
	movel a1,a0@(4,d0:l)
	addql #1,a2@(12)
	moveq #1,d0
	jra L202
	.even
L200:
	clrb d0
L202:
	movel a5@(-8),d2
	movel a5@(-4),a2
	unlk a5
	rts
	.even
.globl _insCurr__7_LLBasePv
_insCurr__7_LLBasePv:
	pea a5@
	movel sp,a5
	moveml #0x3020,sp@-
	movel a5@(8),a2
	movel a5@(12),d3
	jeq L204
	jbsr _createLink__7_LLBase
	movel d0,a1
	moveq #-1,d0
	cmpl a1,d0
	jeq L204
	movel __7_LLBase$linkCache,a0
	movel a2@(8),d0
	lsll #4,d0
	movel a0@(d0:l),d2
	movel a1,d1
	lsll #4,d1
	movel d3,a0@(12,d1:l)
	movel a2@(8),d0
	lsll #4,d0
	movel a1,a0@(d0:l)
	movel a2@(8),a0@(4,d1:l)
	movel d2,a0@(d1:l)
	lsll #4,d2
	movel a1,a0@(4,d2:l)
	addql #1,a2@(12)
	moveq #1,d0
	jra L206
	.even
L204:
	clrb d0
L206:
	moveml a5@(-12),#0x40c
	unlk a5
	rts
	.even
.globl _remLast__7_LLBase
_remLast__7_LLBase:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel d2,sp@-
	movel a5@(8),a2
	tstl a2@(12)
	jle L208
	movel __7_LLBase$linkCache,a0
	movel a2@(4),d1
	lsll #4,d1
	movel a0@(d1:l),a1
	movel a1,d0
	lsll #4,d0
	movel a0@(12,d0:l),d2
	movel a0@(d0:l),a0@(d1:l)
	movel a2@(4),d1
	movel d1,d0
	lsll #4,d0
	movel a0@(d0:l),d0
	lsll #4,d0
	movel d1,a0@(4,d0:l)
	cmpl a2@(8),a1
	jne L209
	movel a2@(4),d0
	lsll #4,d0
	movel a0@(d0:l),a2@(8)
L209:
	movel a1,sp@-
	jbsr _destroyLink__7_LLBasel
	subql #1,a2@(12)
	movel d2,d0
	jra L210
	.even
L208:
	clrl d0
L210:
	movel a5@(-8),d2
	movel a5@(-4),a2
	unlk a5
	rts
	.even
.globl _remFirst__7_LLBase
_remFirst__7_LLBase:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel d2,sp@-
	movel a5@(8),a2
	tstl a2@(12)
	jle L212
	movel __7_LLBase$linkCache,a0
	movel a2@,d1
	lsll #4,d1
	movel a0@(4,d1:l),a1
	movel a1,d0
	lsll #4,d0
	movel a0@(12,d0:l),d2
	movel a0@(4,d0:l),a0@(4,d1:l)
	movel a2@,d1
	movel d1,d0
	lsll #4,d0
	movel a0@(4,d0:l),d0
	lsll #4,d0
	movel d1,a0@(d0:l)
	cmpl a2@(8),a1
	jne L213
	movel a2@,d0
	lsll #4,d0
	movel a0@(4,d0:l),a2@(8)
L213:
	movel a1,sp@-
	jbsr _destroyLink__7_LLBasel
	subql #1,a2@(12)
	movel d2,d0
	jra L214
	.even
L212:
	clrl d0
L214:
	movel a5@(-8),d2
	movel a5@(-4),a2
	unlk a5
	rts
	.even
.globl _remCurr__7_LLBase
_remCurr__7_LLBase:
	pea a5@
	movel sp,a5
	moveml #0x3020,sp@-
	movel a5@(8),a2
	tstl a2@(12)
	jgt L216
	clrl d0
	jra L217
	.even
L216:
	movel __7_LLBase$linkCache,a0
	movel a2@(8),d2
	movel d2,d1
	lsll #4,d1
	movel a0@(12,d1:l),d3
	movel a0@(d1:l),d0
	lsll #4,d0
	movel a0@(4,d1:l),a0@(4,d0:l)
	movel a2@(8),d1
	lsll #4,d1
	movel a0@(4,d1:l),d0
	lsll #4,d0
	movel a0@(d1:l),a0@(d0:l)
	movel a2@(8),d0
	lsll #4,d0
	movel a0@(4,d0:l),a2@(8)
	movel d2,sp@-
	jbsr _destroyLink__7_LLBasel
	subql #1,a2@(12)
	movel d3,d0
L217:
	moveml a5@(-12),#0x40c
	unlk a5
	rts
	.even
.globl _remFirst__7_LLBasePv
_remFirst__7_LLBasePv:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel a5@(8),a2
	movel a5@(12),d0
	jeq L219
	tstl a2@(12)
	jle L219
	movel d0,sp@-
	movel a2@,sp@-
	movel a2,sp@-
	jbsr _findFwrd__7_LLBaselPv
	movel d0,a1
	addw #12,sp
	moveq #-1,d0
	cmpl a1,d0
	jeq L219
	movel __7_LLBase$linkCache,a0
	movel a1,d1
	lsll #4,d1
	cmpl a2@(8),a1
	jne L221
	movel a0@(4,d1:l),a2@(8)
L221:
	movel a0@(d1:l),d0
	lsll #4,d0
	movel a0@(4,d1:l),a0@(4,d0:l)
	movel a0@(4,d1:l),d0
	lsll #4,d0
	movel a0@(d1:l),a0@(d0:l)
	movel a1,sp@-
	jbsr _destroyLink__7_LLBasel
	subql #1,a2@(12)
	moveq #1,d0
	jra L222
	.even
L219:
	clrb d0
L222:
	movel a5@(-4),a2
	unlk a5
	rts
	.even
.globl _remLast__7_LLBasePv
_remLast__7_LLBasePv:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel a5@(8),a2
	movel a5@(12),d0
	jeq L224
	tstl a2@(12)
	jle L224
	movel d0,sp@-
	movel a2@(4),sp@-
	movel a2,sp@-
	jbsr _findBkwd__7_LLBaselPv
	movel d0,a1
	addw #12,sp
	moveq #-1,d0
	cmpl a1,d0
	jeq L224
	movel __7_LLBase$linkCache,a0
	movel a1,d1
	lsll #4,d1
	cmpl a2@(8),a1
	jne L226
	movel a0@(d1:l),a2@(8)
L226:
	movel a0@(d1:l),d0
	lsll #4,d0
	movel a0@(4,d1:l),a0@(4,d0:l)
	movel a0@(4,d1:l),d0
	lsll #4,d0
	movel a0@(d1:l),a0@(d0:l)
	movel a1,sp@-
	jbsr _destroyLink__7_LLBasel
	subql #1,a2@(12)
	moveq #1,d0
	jra L227
	.even
L224:
	clrb d0
L227:
	movel a5@(-4),a2
	unlk a5
	rts
	.even
.globl _repFirst__7_LLBasePvT1
_repFirst__7_LLBasePvT1:
	pea a5@
	movel sp,a5
	movel d2,sp@-
	movel a5@(8),a0
	movel a5@(12),d0
	movel a5@(16),d2
	tstl d0
	jeq L229
	tstl d2
	jeq L229
	cmpl d0,d2
	jeq L229
	tstl a0@(12)
	jle L229
	movel d0,sp@-
	movel a0@,sp@-
	movel a0,sp@-
	jbsr _findFwrd__7_LLBaselPv
	moveq #-1,d1
	cmpl d0,d1
	jeq L229
	movel __7_LLBase$linkCache,a0
	lsll #4,d0
	movel d2,a0@(12,d0:l)
	moveq #1,d0
	jra L231
	.even
L229:
	clrb d0
L231:
	movel a5@(-4),d2
	unlk a5
	rts
	.even
.globl _repLast__7_LLBasePvT1
_repLast__7_LLBasePvT1:
	pea a5@
	movel sp,a5
	movel d2,sp@-
	movel a5@(8),a0
	movel a5@(12),d0
	movel a5@(16),d2
	tstl d0
	jeq L233
	tstl d2
	jeq L233
	cmpl d0,d2
	jeq L233
	tstl a0@(12)
	jle L233
	movel d0,sp@-
	movel a0@(4),sp@-
	movel a0,sp@-
	jbsr _findBkwd__7_LLBaselPv
	moveq #-1,d1
	cmpl d0,d1
	jeq L233
	movel __7_LLBase$linkCache,a0
	lsll #4,d0
	movel d2,a0@(12,d0:l)
	moveq #1,d0
	jra L235
	.even
L233:
	clrb d0
L235:
	movel a5@(-4),d2
	unlk a5
	rts
