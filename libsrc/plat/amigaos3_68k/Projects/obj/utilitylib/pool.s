#NO_APP
.text
	.even
.globl ___12PoolLargeRawUlUl
___12PoolLargeRawUlUl:
	link a5,#-52
	fmovem #0xfc,sp@-
	moveml #0x3f3a,sp@-
	jbsr ___get_eh_context
	movel d0,d1
	movel a5@(8),a0
	movel #___vt_8PoolBase,a0@(32)
	clrl a0@
	clrl a0@(4)
	clrl a0@(12)
	clrl a0@(8)
	moveq #-1,d0
	movel d0,a0@(16)
	clrl a0@(20)
	clrl a0@(24)
	clrl a0@(28)
	movel d1,a0
	addql #4,a0
	movel a0@,a5@(-24)
	clrl a5@(-20)
	movel a5,a5@(-16)
	movel #L71,a5@(-12)
	movel sp,a5@(-8)
	jra L70
	.even
L71:
	jra L79
	.even
L70:
	lea a5@(-24),a1
	movel a1,a0@
	movel a5@(8),a0
	movel #___vt_12PoolLargeRaw,a0@(32)
	clrl a0@(36)
	movel a5@(16),sp@-
	movel a5@(12),sp@-
	movel a0,sp@-
	movel d1,a1
	addql #4,a1
	movel a1,a5@(-52)
	jbsr _getSpace__12PoolLargeRawUlUl
	movel a5@(-52),a1
	movel a1@,a0
	movel a0@,a1@
	movel a5@(8),d0
	jra L78
	.even
L79:
L68:
	movel a5@(-52),a0
	movel a0@,a5@(-48)
	clrl a5@(-44)
	movel a5,a5@(-40)
	movel #L76,a5@(-36)
	movel sp,a5@(-32)
	jra L75
	.even
L76:
	jra L80
	.even
L75:
	lea a5@(-48),a0
	movel a5@(-52),a1
	movel a0,a1@
	clrl sp@-
	movel a5@(8),sp@-
	jbsr __$_8PoolBase
	movel a5@(-52),a1
	movel a1@,a0
	movel a0@,a1@
	addql #8,sp
	jbsr ___sjthrow
	.even
L80:
L73:
	jbsr ___terminate
	.even
L78:
	moveml a5@(-164),#0x5cfc
	fmovem a5@(-124),#0x3f
	unlk a5
	rts
	.even
.globl __$_12PoolLargeRaw
__$_12PoolLargeRaw:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel d2,sp@-
	movel a5@(8),a2
	movel a5@(12),d2
	movel #___vt_12PoolLargeRaw,a2@(32)
	subql #2,sp
	moveb #0,sp@(1)
	subql #2,sp
	subql #2,sp
	moveb #1,sp@(1)
	subql #2,sp
	movel a2,sp@-
	jbsr _freeSpace__12PoolLargeRawbT1
	addqw #8,sp
	movel d2,sp@
	movel a2,sp@-
	jbsr __$_8PoolBase
	movel a5@(-8),d2
	movel a5@(-4),a2
	unlk a5
	rts
	.even
.globl _examineBlock__12PoolLargeRawUl
_examineBlock__12PoolLargeRawUl:
	pea a5@
	movel sp,a5
	moveml #0x3820,sp@-
	movel a5@(8),a2
	movel a5@(12),d1
	clrl d3
	moveq #1,d2
	movel a2@(4),d0
	cmpl d1,d0
	jls L85
	movel d0,d4
	movel d1,d0
	lsll #2,d0
	movel d0,a1
	addl a2@(36),a1
	.even
L86:
	addql #1,d1
	addql #4,a1
	tstl a1@
	jne L89
	movel a2@(24),a0
	tstl a0@(d1:l:4)
	jeq L88
L89:
	movel d2,d3
	jra L84
	.even
L88:
	addql #1,d2
L84:
	cmpl d1,d4
	jls L85
	tstl d3
	jeq L86
L85:
	movel d2,d0
	moveml sp@+,#0x41c
	unlk a5
	rts
	.even
.globl _testConsistency__12PoolLargeRawb
_testConsistency__12PoolLargeRawb:
	pea a5@
	movel sp,a5
	moveml #0x3820,sp@-
	movel a5@(8),a2
	clrl d4
	clrl d2
	clrl d3
	cmpl a2@(4),d4
	jcc L95
	.even
L96:
	movel a2@(36),a0
	movel a0@(d2:l:4),d1
	jne L97
	movel d3,sp@-
	movel a2,sp@-
	jbsr _examineBlock__12PoolLargeRawUl
	movel d0,d1
	movel a2@(36),a0
	movel d1,a0@(d3:l:4)
	movel d3,d2
	addl d1,d2
	addql #8,sp
L97:
	movel a2@(24),a0
	movel a0@(d2:l:4),a1
	tstl a1
	jeq L98
	movel d2,d0
	mulsl a2@(12),d0
	movel a2@(28),a0
	lea a0@(d0:l:2),a0
	cmpl a1@,a0
	jeq L98
	addql #1,d4
L98:
	movel d2,d0
	addl d1,d0
	cmpl a2@(4),d0
	jls L99
	movel d2,sp@-
	movel a2,sp@-
	jbsr _examineBlock__12PoolLargeRawUl
	movel d0,d1
	movel a2@(36),a0
	movel d1,a0@(d2:l:4)
	addql #8,sp
L99:
	movel d2,d3
	addl d1,d2
	cmpl a2@(4),d2
	jcs L96
L95:
	movel d4,d0
	moveml a5@(-16),#0x41c
	unlk a5
	rts
	.even
.globl _getSpace__12PoolLargeRawUlUl
_getSpace__12PoolLargeRawUlUl:
	pea a5@
	movel sp,a5
	moveml #0x3020,sp@-
	movel a5@(8),a2
	movel a5@(12),d2
	movel a5@(16),d1
	movel #-50659332,d0
	tstl a2@(28)
	jne L107
	movel d1,d0
	moveq #1,d3
	andl d3,d0
	lsrl #1,d1
	addl d1,d0
	movel d0,a2@(12)
	movel d2,d1
	mulsl d0,d1
	movel d1,a2@(8)
	movel d1,d0
	lsrl #1,d0
	movel d0,a1
	lea a1@(d2:l:2),a0
	andl d3,d1
	addl a0,d1
	clrl sp@-
	subql #2,sp
	moveb #1,sp@(1)
	subql #2,sp
	lsll #2,d1
	movel d1,sp@-
	jbsr _alloc__3MemUlbQ23Mem9AlignType
	movel d0,a1
	movel a1,a2@
	jeq L104
	movel a1,a2@(24)
	lea a1@(d2:l:4),a0
	movel a0,a2@(36)
	lea a1@(d2:l:8),a1
	movel a1,a2@(28)
	movel d2,a2@(4)
	movel d2,a2@(20)
	clrl a2@(16)
	movel d2,a0@
	clrl d0
	jra L107
	.even
L104:
	clrl a2@(36)
	clrl a2@(4)
	clrl a2@(12)
	clrl a2@(8)
	moveq #-1,d0
	movel d0,a2@(16)
	clrl a2@(20)
	clrl a2@(24)
	clrl a2@(28)
	movel #-50528257,d0
L107:
	moveml a5@(-12),#0x40c
	unlk a5
	rts
	.even
.globl _freeSpace__12PoolLargeRawbT1
_freeSpace__12PoolLargeRawbT1:
	pea a5@
	movel sp,a5
	moveml #0x2030,sp@-
	movel a5@(8),a2
	movel a2@(4),d1
	movel d1,d0
	subl a2@(20),d0
	tstb a5@(15)
	jne L109
	tstl d0
	jeq L111
	movel #-50659332,d0
	jra L124
	.even
L109:
	tstl a2@
	jeq L121
	tstl d0
	jeq L111
	tstb a5@(19)
	jeq L111
	clrl d2
	cmpl d2,d1
	jls L111
	.even
L116:
	movel a2@(24),a0
	movel a0@(d2:l:4),a3
	movel a3@,d1
	clrl d0
	movel a2@(28),a1
	cmpl d1,a1
	jhi L118
	movel a2@(8),a0
	lea a1@(-2,a0:l:2),a0
	cmpl d1,a0
	shi d0
	extbl d0
	negl d0
L118:
	tstl d0
	jeq L117
	clrl a3@
L117:
	addql #1,d2
	cmpl a2@(4),d2
	jcs L116
L111:
	movel a2@,d0
	jeq L121
	movel d0,sp@-
	jbsr _free__3MemPv
	clrl a2@(36)
	clrl a2@
	clrl a2@(4)
	clrl a2@(12)
	clrl a2@(8)
	moveq #-1,d0
	movel d0,a2@(16)
	clrl a2@(20)
	clrl a2@(24)
	clrl a2@(28)
L121:
	clrl d0
L124:
	moveml a5@(-12),#0xc04
	unlk a5
	rts
	.even
.globl _resize__12PoolLargeRawUl
_resize__12PoolLargeRawUl:
	pea a5@
	movel sp,a5
	moveml #0x3c3a,sp@-
	movel a5@(8),a2
	movel a5@(12),d4
	movel a2@(4),d0
	cmpl d0,d4
	jne L127
	clrl d0
	jra L136
	.even
L127:
	subl a2@(20),d0
	cmpl d4,d0
	jcc L128
	subql #2,sp
	moveb #0,sp@(1)
	subql #2,sp
	movel a2,sp@-
	jbsr _testConsistency__12PoolLargeRawb
	addql #8,sp
	tstl d0
	jeq L129
	movel #-58720260,d0
	jra L136
	.even
L129:
	movel d4,d5
	mulsl a2@(12),d5
	movel d5,d0
	lsrl #1,d0
	movel d0,a1
	lea a1@(d4:l:2),a0
	movel d5,d0
	moveq #1,d1
	andl d1,d0
	addl a0,d0
	clrl sp@-
	subql #2,sp
	moveb #1,sp@(1)
	subql #2,sp
	lsll #2,d0
	movel d0,sp@-
	jbsr _alloc__3MemUlbQ23Mem9AlignType
	movel d0,a3
	addw #12,sp
	tstl a3
	jne L130
	movel #-50528257,d0
	jra L136
	.even
L130:
	lea a3@(d4:l:4),a6
	lea a3@(d4:l:8),a4
	clrl d2
	clrl d3
	cmpl a2@(4),d2
	jcc L132
	.even
L133:
	movel a2@(24),a0
	movel a0@(d2:l:4),d0
	jeq L134
	movel d0,a3@(d3:l:4)
	movel a2@(36),a0
	movel a0@(d2:l:4),a6@(d3:l:4)
	movel a2@(36),a0
	movel a2@(12),d1
	movel d1,d0
	mulsl a0@(d2:l:4),d0
	addl d0,d0
	movel d0,sp@-
	movel d2,d0
	mulsl d1,d0
	movel a2@(28),a0
	pea a0@(d0:l:2)
	mulsl d3,d1
	pea a4@(d1:l:2)
	jbsr _copy__3MemPvPCvUl
	movel a2@(36),a0
	addl a0@(d2:l:4),d3
	addw #12,sp
L134:
	movel a2@(36),a0
	addl a0@(d2:l:4),d2
	cmpl a2@(4),d2
	jcs L133
L132:
	movel a2@,sp@-
	jbsr _free__3MemPv
	movel a3,a2@
	movel a6,a2@(36)
	movel a4,a2@(28)
	movel a3,a2@(24)
	movel d4,d0
	subl a2@(4),d0
	addl a2@(20),d0
	movel d0,a2@(20)
	movel d4,a2@(4)
	movel d5,a2@(8)
	subl d0,d4
	movel d4,a2@(16)
	clrl d0
	jra L136
	.even
L128:
	movel #-58720261,d0
L136:
	moveml a5@(-32),#0x5c3c
	unlk a5
	rts
	.even
.globl _defrag__12PoolLargeRaw
_defrag__12PoolLargeRaw:
	pea a5@
	movel sp,a5
	moveml #0x3f30,sp@-
	movel a5@(8),a2
	subql #2,sp
	moveb #0,sp@(1)
	subql #2,sp
	movel a2,sp@-
	jbsr _testConsistency__12PoolLargeRawb
	addql #8,sp
	tstl d0
	jeq L139
	movel #-58720260,d0
	jra L152
	.even
L139:
	movel a2@(16),d4
	movel a2@(36),a0
	movel d4,d5
	addl a0@(d4:l:4),d5
	movel a2@(4),d0
	cmpl d5,d0
	jls L141
	.even
L142:
	movel a2@(36),a1
	movel a1@(d5:l:4),d6
	movel a2@(24),a0
	tstl a0@(d5:l:4)
	jeq L143
	movel d6,a1@(d4:l:4)
	movel a2@(24),a0
	movel a0@(d5:l:4),a0@(d4:l:4)
	movel a2@(36),a0
	clrl a0@(d5:l:4)
	movel a2@(24),a0
	clrl a0@(d5:l:4)
	movel a2@(24),a0
	movel a0@(d4:l:4),a1
	movel d4,d0
	mulsl a2@(12),d0
	movel a2@(28),a0
	lea a0@(d0:l:2),a0
	movel a0,a1@
	movel d5,d0
	subl d4,d0
	cmpl d0,d6
	jge L144
	movel a2@(12),d1
	movel d6,d0
	mulsl d1,d0
	addl d0,d0
	movel d0,sp@-
	movel d5,d0
	mulsl d1,d0
	movel a2@(28),a0
	pea a0@(d0:l:2)
	mulsl d4,d1
	pea a0@(d1:l:2)
	jbsr _copy__3MemPvPCvUl
	addw #12,sp
	movel d4,d7
	addl d6,d7
	jra L145
	.even
L144:
	clrl d3
	movel d0,d2
	movel d4,d7
	addl d6,d7
	cmpl d3,d6
	jle L145
	lea _copy__3MemPvPCvUl,a3
	.even
L148:
	movel a2@(12),d1
	movel d2,d0
	mulsl d1,d0
	addl d0,d0
	movel d0,sp@-
	movel d5,d0
	addl d3,d0
	mulsl d1,d0
	movel a2@(28),a0
	pea a0@(d0:l:2)
	movel d4,d0
	addl d3,d0
	mulsl d1,d0
	pea a0@(d0:l:2)
	jbsr a3@
	movel d3,d0
	addl d2,d0
	addw #12,sp
	cmpl d0,d6
	jge L149
	movel d6,d2
	subl d3,d2
	addl d2,d3
	movel a2@(12),d1
	movel d2,d0
	mulsl d1,d0
	addl d0,d0
	movel d0,sp@-
	movel d5,d0
	addl d3,d0
	mulsl d1,d0
	movel a2@(28),a0
	pea a0@(d0:l:2)
	movel d4,d0
	addl d3,d0
	mulsl d1,d0
	pea a0@(d0:l:2)
	jbsr a3@
	addw #12,sp
L149:
	addl d2,d3
	cmpl d3,d6
	jgt L148
L145:
	movel d7,d4
	movel a2@(4),d0
L143:
	addl d6,d5
	cmpl d5,d0
	jhi L142
L141:
	movel d4,a2@(16)
	movel a2@(36),a0
	movel a2@(20),a0@(d4:l:4)
	clrl d0
L152:
	moveml a5@(-32),#0xcfc
	unlk a5
	rts
	.even
.globl _assignSingle__12PoolLargeRawPv
_assignSingle__12PoolLargeRawPv:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel d2,sp@-
	movel a5@(8),a1
	movel a5@(12),a2
	tstl a2@
	jeq L155
	movel #-50462723,d0
	jra L164
	.even
L155:
	tstl a1@(20)
	jeq L156
	movel a1@(16),d0
	movel a1@(36),a0
	movel a0@(d0:l:4),d1
	movel a1@(24),a0
	movel a2,a0@(d0:l:4)
	movel a1@(16),d0
	movel a1@(36),a0
	moveq #1,d2
	movel d2,a0@(d0:l:4)
	movel a1@(16),d0
	mulsl a1@(12),d0
	movel a1@(28),a0
	lea a0@(d0:l:2),a0
	movel a0,a2@
	movel a1@(20),d0
	movel d0,a0
	subql #1,a0
	movel a0,a1@(20)
	cmpl d0,d2
	jeq L157
	subql #1,d1
	jeq L158
	movel a1@(16),d0
	movel d0,d2
	addql #1,d2
	movel d2,a1@(16)
	movel a1@(36),a0
	movel d1,a0@(4,d0:l:4)
	clrl d0
	jra L164
	.even
L158:
	movel a1@(16),d0
	addql #1,d0
	movel a1@(4),d1
	cmpl d0,d1
	jls L160
	movel a1@(24),a0
	tstl a0@(d0:l:4)
	jeq L160
	movel a1@(36),a2
	.even
L161:
	addl a2@(d0:l:4),d0
	cmpl d0,d1
	jls L160
	tstl a0@(d0:l:4)
	jne L161
L160:
	movel d0,a1@(16)
	clrl d0
	jra L164
	.even
L157:
	moveq #-1,d0
	movel d0,a1@(16)
	movel #-33882118,d0
	jra L164
	.even
L156:
	movel #-50659334,d0
L164:
	movel sp@+,d2
	movel sp@+,a2
	unlk a5
	rts
	.even
.globl _assignVector__12PoolLargeRawPvUl
_assignVector__12PoolLargeRawPvUl:
	pea a5@
	movel sp,a5
	moveml #0x2038,sp@-
	movel a5@(8),a1
	movel a5@(12),a4
	movel a5@(16),a2
	movel #-50462723,d0
	tstl a4@
	jne L186
	movel #-58720262,d0
	cmpl a1@(20),a2
	jhi L186
	movel a1@(16),d0
	moveq #-1,d2
	movel a1@(4),d1
	cmpl d0,d1
	jls L170
	movel a1@(24),a3
	.even
L171:
	movel a1@(36),a0
	tstl a3@(d0:l:4)
	jne L173
	cmpl a0@(d0:l:4),a2
	jhi L173
	movel d0,d2
	jra L169
	.even
L173:
	addl a0@(d0:l:4),d0
L169:
	cmpl d0,d1
	jls L170
	tstl d2
	jlt L171
L170:
	tstl d2
	jge L176
	movel a1,sp@-
	jbsr _defrag__12PoolLargeRaw
	movel #-58720260,d0
	jra L186
	.even
L176:
	movel a1@(36),a0
	movel a0@(d2:l:4),d1
	cmpl a2,d1
	jls L178
	movel a2,a0@(d2:l:4)
	movel d2,d0
	addl a2,d0
	movel a1@(36),a0
	subl a2,d1
	movel d1,a0@(d0:l:4)
L178:
	movel a1@(24),a0
	movel a4,a0@(d2:l:4)
	movel d2,d0
	mulsl a1@(12),d0
	movel a1@(28),a0
	lea a0@(d0:l:2),a0
	movel a0,a4@
	movel a1@(20),d0
	subl a2,d0
	movel d0,a1@(20)
	jeq L179
	cmpl a1@(16),d2
	jne L180
	movel d2,d0
	addl a2,d0
	movel a1@(4),d1
	cmpl d0,d1
	jls L182
	movel a1@(24),a0
	tstl a0@(d0:l:4)
	jeq L182
	movel a1@(36),a2
	.even
L183:
	addl a2@(d0:l:4),d0
	cmpl d0,d1
	jls L182
	tstl a0@(d0:l:4)
	jne L183
L182:
	movel d0,a1@(16)
L180:
	clrl d0
	jra L186
	.even
L179:
	moveq #-1,d0
	movel d0,a1@(16)
	movel #-33882118,d0
L186:
	moveml a5@(-16),#0x1c04
	unlk a5
	rts
	.even
.globl _unassign__12PoolLargeRawPv
_unassign__12PoolLargeRawPv:
	pea a5@
	movel sp,a5
	moveml #0x3030,sp@-
	movel a5@(8),a2
	movel a5@(12),a3
	movel a3@,d1
	movel #-50462722,d0
	tstl d1
	jeq L206
	clrl d0
	movel a2@(28),a1
	cmpl d1,a1
	jhi L192
	movel a2@(8),a0
	lea a1@(-2,a0:l:2),a0
	cmpl d1,a0
	shi d0
	extbl d0
	negl d0
L192:
	tstl d0
	jne L191
	movel #-50462724,d0
	jra L206
	.even
L191:
	subl a1,d1
	asrl #1,d1
	divul a2@(12),d1
	movel a2@(24),a0
	tstl a0@(d1:l:4)
	jne L194
	movel #-50462725,d0
	jra L206
	.even
L194:
	clrl a3@
	movel a2@(24),a0
	clrl a0@(d1:l:4)
	movel a2@(36),a1
	movel a1@(d1:l:4),d2
	addl d2,a2@(20)
	movel d1,d0
	addl d2,d0
	cmpl a2@(4),d0
	jcc L195
	movel a2@(24),a0
	tstl a0@(d0:l:4)
	jne L195
	addl a1@(d0:l:4),d2
	clrl a1@(d0:l:4)
	movel a2@(36),a0
	movel d2,a0@(d1:l:4)
L195:
	tstl d1
	jeq L198
	movel a2@(16),d0
	cmpl d1,d0
	jgt L198
	moveq #-1,d3
	cmpl d0,d3
	jne L197
L198:
	movel d1,a2@(16)
	jra L205
	.even
L197:
	movew #-1,a1
	cmpl d0,d1
	jle L200
	movel a2@(24),a3
	.even
L201:
	movew #-1,a1
	tstl a3@(d0:l:4)
	jne L202
	movel d0,a1
L202:
	movel a2@(36),a0
	addl a0@(d0:l:4),d0
	cmpl d0,d1
	jgt L201
L200:
	tstl a1
	jlt L205
	movel a2@(36),a0
	addl d2,a0@(a1:l:4)
	movel a2@(36),a0
	clrl a0@(d1:l:4)
L205:
	clrl d0
L206:
	moveml sp@+,#0xc0c
	unlk a5
	rts
	.even
.globl ___12PoolSmallRawUlUl
___12PoolSmallRawUlUl:
	link a5,#-52
	fmovem #0xfc,sp@-
	moveml #0x3f3a,sp@-
	jbsr ___get_eh_context
	movel d0,d1
	movel a5@(8),a0
	movel #___vt_8PoolBase,a0@(32)
	clrl a0@
	clrl a0@(4)
	clrl a0@(12)
	clrl a0@(8)
	moveq #-1,d0
	movel d0,a0@(16)
	clrl a0@(20)
	clrl a0@(24)
	clrl a0@(28)
	movel d1,a0
	addql #4,a0
	movel a0@,a5@(-24)
	clrl a5@(-20)
	movel a5,a5@(-16)
	movel #L215,a5@(-12)
	movel sp,a5@(-8)
	jra L214
	.even
L215:
	jra L223
	.even
L214:
	lea a5@(-24),a1
	movel a1,a0@
	movel a5@(8),a0
	movel #___vt_12PoolSmallRaw,a0@(32)
	clrl a0@(36)
	movel a5@(16),sp@-
	movel a5@(12),sp@-
	movel a0,sp@-
	movel d1,a1
	addql #4,a1
	movel a1,a5@(-52)
	jbsr _getSpace__12PoolSmallRawUlUl
	movel a5@(-52),a1
	movel a1@,a0
	movel a0@,a1@
	movel a5@(8),d0
	jra L222
	.even
L223:
L212:
	movel a5@(-52),a0
	movel a0@,a5@(-48)
	clrl a5@(-44)
	movel a5,a5@(-40)
	movel #L220,a5@(-36)
	movel sp,a5@(-32)
	jra L219
	.even
L220:
	jra L224
	.even
L219:
	lea a5@(-48),a0
	movel a5@(-52),a1
	movel a0,a1@
	clrl sp@-
	movel a5@(8),sp@-
	jbsr __$_8PoolBase
	movel a5@(-52),a1
	movel a1@,a0
	movel a0@,a1@
	addql #8,sp
	jbsr ___sjthrow
	.even
L224:
L217:
	jbsr ___terminate
	.even
L222:
	moveml a5@(-164),#0x5cfc
	fmovem a5@(-124),#0x3f
	unlk a5
	rts
	.even
.globl __$_12PoolSmallRaw
__$_12PoolSmallRaw:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel d2,sp@-
	movel a5@(8),a2
	movel a5@(12),d2
	movel #___vt_12PoolSmallRaw,a2@(32)
	subql #2,sp
	moveb #0,sp@(1)
	subql #2,sp
	subql #2,sp
	moveb #1,sp@(1)
	subql #2,sp
	movel a2,sp@-
	jbsr _freeSpace__12PoolSmallRawbT1
	addqw #8,sp
	movel d2,sp@
	movel a2,sp@-
	jbsr __$_8PoolBase
	movel a5@(-8),d2
	movel a5@(-4),a2
	unlk a5
	rts
	.even
.globl _examineBlock__12PoolSmallRawUl
_examineBlock__12PoolSmallRawUl:
	pea a5@
	movel sp,a5
	moveml #0x3820,sp@-
	movel a5@(8),a2
	movel a5@(12),d1
	clrl d3
	moveq #1,d2
	movel a2@(4),d0
	cmpl d1,d0
	jls L229
	movel d0,d4
	movel d1,d0
	addl d0,d0
	movel d0,a1
	addl a2@(36),a1
	.even
L230:
	addql #1,d1
	addql #2,a1
	tstw a1@
	jne L233
	movel a2@(24),a0
	tstl a0@(d1:l:4)
	jeq L232
L233:
	movel d2,d3
	jra L228
	.even
L232:
	addql #1,d2
L228:
	cmpl d1,d4
	jls L229
	tstl d3
	jeq L230
L229:
	movel d2,d0
	moveml sp@+,#0x41c
	unlk a5
	rts
	.even
.globl _testConsistency__12PoolSmallRawb
_testConsistency__12PoolSmallRawb:
	pea a5@
	movel sp,a5
	moveml #0x3820,sp@-
	movel a5@(8),a2
	clrl d4
	clrl d2
	clrl d3
	cmpl a2@(4),d4
	jcc L239
	.even
L240:
	movel a2@(36),a0
	clrl d1
	movew a0@(d2:l:2),d1
	jne L241
	movel d3,sp@-
	movel a2,sp@-
	jbsr _examineBlock__12PoolSmallRawUl
	movel d0,d1
	movel a2@(36),a0
	movew d1,a0@(d3:l:2)
	movel d3,d2
	addl d1,d2
	addql #8,sp
L241:
	movel a2@(24),a0
	movel a0@(d2:l:4),a1
	tstl a1
	jeq L242
	movel d2,d0
	mulsl a2@(12),d0
	movel a2@(28),a0
	lea a0@(d0:l:2),a0
	cmpl a1@,a0
	jeq L242
	addql #1,d4
L242:
	movel d2,d0
	addl d1,d0
	cmpl a2@(4),d0
	jls L243
	movel d2,sp@-
	movel a2,sp@-
	jbsr _examineBlock__12PoolSmallRawUl
	movel d0,d1
	movel a2@(36),a0
	movew d1,a0@(d2:l:2)
	addql #8,sp
L243:
	movel d2,d3
	addl d1,d2
	cmpl a2@(4),d2
	jcs L240
L239:
	movel d4,d0
	moveml a5@(-16),#0x41c
	unlk a5
	rts
	.even
.globl _getSpace__12PoolSmallRawUlUl
_getSpace__12PoolSmallRawUlUl:
	pea a5@
	movel sp,a5
	moveml #0x3820,sp@-
	movel a5@(8),a2
	movel a5@(12),d3
	movel a5@(16),d1
	tstl a2@(28)
	jeq L247
	movel #-50659332,d0
	jra L251
	.even
L247:
	andl #65535,d1
	movel d1,d0
	moveq #1,d2
	andl d2,d0
	lsrl #1,d1
	addl d1,d0
	movel d0,a2@(12)
	movel d3,d2
	mulsl d0,d2
	movel d2,a2@(8)
	movel d3,d1
	lsrl #1,d1
	addl d3,d1
	movel d3,d0
	moveq #1,d4
	andl d4,d0
	movel d1,d4
	addl d0,d4
	movel d2,d0
	lsrl #1,d0
	addl d4,d0
	moveq #1,d1
	andl d1,d2
	addl d2,d0
	clrl sp@-
	subql #2,sp
	moveb #1,sp@(1)
	subql #2,sp
	lsll #2,d0
	movel d0,sp@-
	jbsr _alloc__3MemUlbQ23Mem9AlignType
	movel d0,a1
	movel a1,a2@
	jeq L248
	movel a1,a2@(24)
	lea a1@(d3:l:4),a0
	movel a0,a2@(36)
	lea a1@(d4:l:4),a1
	movel a1,a2@(28)
	movel d3,a2@(4)
	movel d3,a2@(20)
	clrl a2@(16)
	movew a2@(6),a0@
	clrl d0
	jra L251
	.even
L248:
	clrl a2@(36)
	clrl a2@(4)
	clrl a2@(12)
	clrl a2@(8)
	moveq #-1,d2
	movel d2,a2@(16)
	clrl a2@(20)
	clrl a2@(24)
	clrl a2@(28)
	movel #-50528257,d0
L251:
	moveml a5@(-16),#0x41c
	unlk a5
	rts
	.even
.globl _freeSpace__12PoolSmallRawbT1
_freeSpace__12PoolSmallRawbT1:
	pea a5@
	movel sp,a5
	moveml #0x2030,sp@-
	movel a5@(8),a2
	movel a2@(4),d1
	movel d1,d0
	subl a2@(20),d0
	tstb a5@(15)
	jne L253
	tstl d0
	jeq L255
	movel #-50659332,d0
	jra L268
	.even
L253:
	tstl a2@
	jeq L265
	tstl d0
	jeq L255
	tstb a5@(19)
	jeq L255
	clrl d2
	cmpl d2,d1
	jls L255
	.even
L260:
	movel a2@(24),a0
	movel a0@(d2:l:4),a3
	movel a3@,d1
	clrl d0
	movel a2@(28),a1
	cmpl d1,a1
	jhi L262
	movel a2@(8),a0
	lea a1@(-2,a0:l:2),a0
	cmpl d1,a0
	shi d0
	extbl d0
	negl d0
L262:
	tstl d0
	jeq L261
	clrl a3@
L261:
	addql #1,d2
	cmpl a2@(4),d2
	jcs L260
L255:
	movel a2@,d0
	jeq L265
	movel d0,sp@-
	jbsr _free__3MemPv
	clrl a2@(36)
	clrl a2@
	clrl a2@(4)
	clrl a2@(12)
	clrl a2@(8)
	moveq #-1,d0
	movel d0,a2@(16)
	clrl a2@(20)
	clrl a2@(24)
	clrl a2@(28)
L265:
	clrl d0
L268:
	moveml a5@(-12),#0xc04
	unlk a5
	rts
	.even
.globl _resize__12PoolSmallRawUl
_resize__12PoolSmallRawUl:
	pea a5@
	movel sp,a5
	moveml #0x3f3a,sp@-
	movel a5@(8),a2
	clrl d4
	movew a5@(14),d4
	movel a2@(4),d0
	cmpl d0,d4
	jne L271
	clrl d0
	jra L280
	.even
L271:
	subl a2@(20),d0
	cmpl d4,d0
	jcc L272
	subql #2,sp
	moveb #0,sp@(1)
	subql #2,sp
	movel a2,sp@-
	jbsr _testConsistency__12PoolSmallRawb
	addql #8,sp
	tstl d0
	jeq L273
	movel #-58720260,d0
	jra L280
	.even
L273:
	movel d4,d7
	mulsl a2@(12),d7
	movel d4,d0
	lsrl #1,d0
	movel d4,d3
	addl d0,d3
	movel d4,d1
	moveq #1,d0
	andl d0,d1
	addl d3,d1
	movel a2@(8),d2
	movel d2,d0
	lsrl #1,d0
	addl d0,d1
	moveq #1,d0
	andl d0,d2
	addl d2,d1
	clrl sp@-
	subql #2,sp
	moveb #1,sp@(1)
	subql #2,sp
	lsll #2,d1
	movel d1,sp@-
	jbsr _alloc__3MemUlbQ23Mem9AlignType
	movel d0,a3
	addw #12,sp
	tstl a3
	jne L274
	movel #-50528257,d0
	jra L280
	.even
L274:
	lea a3@(d4:l:4),a6
	moveq #1,d0
	andl d0,d3
	movel d4,d0
	addl d3,d0
	lea a3@(d0:l:4),a4
	clrl d2
	clrl d3
	cmpl a2@(4),d2
	jcc L276
	clrl d6
	clrl d5
	.even
L277:
	movel a2@(24),a0
	movel a0@(d2:l:4),d0
	jeq L278
	movel d0,a3@(d3:l:4)
	movel a2@(36),a0
	movew a0@(d2:l:2),a6@(d3:l:2)
	movel a2@(36),a0
	movew a0@(d2:l:2),d6
	movel a2@(12),d1
	movel d6,d0
	mulsl d1,d0
	addl d0,d0
	movel d0,sp@-
	movel d2,d0
	mulsl d1,d0
	movel a2@(28),a0
	pea a0@(d0:l:2)
	mulsl d3,d1
	pea a4@(d1:l:2)
	jbsr _copy__3MemPvPCvUl
	movel a2@(36),a0
	movew a0@(d2:l:2),d5
	addl d5,d3
	addw #12,sp
L278:
	movel a2@(36),a0
	clrl d0
	movew a0@(d2:l:2),d0
	addl d0,d2
	cmpl a2@(4),d2
	jcs L277
L276:
	movel a2@,sp@-
	jbsr _free__3MemPv
	movel a3,a2@
	movel a6,a2@(36)
	movel a4,a2@(28)
	movel a3,a2@(24)
	movel d4,d0
	subl a2@(4),d0
	addl a2@(20),d0
	movel d0,a2@(20)
	movel d4,a2@(4)
	movel d7,a2@(8)
	subl d0,d4
	movel d4,a2@(16)
	clrl d0
	jra L280
	.even
L272:
	movel #-58720261,d0
L280:
	moveml a5@(-40),#0x5cfc
	unlk a5
	rts
	.even
.globl _defrag__12PoolSmallRaw
_defrag__12PoolSmallRaw:
	pea a5@
	movel sp,a5
	moveml #0x3f30,sp@-
	movel a5@(8),a2
	subql #2,sp
	moveb #0,sp@(1)
	subql #2,sp
	movel a2,sp@-
	jbsr _testConsistency__12PoolSmallRawb
	addql #8,sp
	tstl d0
	jeq L283
	movel #-58720260,d0
	jra L296
	.even
L283:
	movel a2@(16),d5
	movel a2@(36),a0
	clrl d0
	movew a0@(d5:l:2),d0
	movel d5,d4
	addl d0,d4
	movel a2@(4),d0
	cmpl d4,d0
	jls L285
	clrl d6
	.even
L286:
	movel a2@(36),a1
	movew a1@(d4:l:2),d6
	movel a2@(24),a0
	tstl a0@(d4:l:4)
	jeq L287
	movew d6,a1@(d5:l:2)
	movel a2@(24),a0
	movel a0@(d4:l:4),a0@(d5:l:4)
	movel a2@(36),a0
	clrw a0@(d4:l:2)
	movel a2@(24),a0
	clrl a0@(d4:l:4)
	movel a2@(24),a0
	movel a0@(d5:l:4),a1
	movel d5,d0
	mulsl a2@(12),d0
	movel a2@(28),a0
	lea a0@(d0:l:2),a0
	movel a0,a1@
	movel d4,d0
	subl d5,d0
	cmpl d0,d6
	jge L288
	movel a2@(12),d1
	movel d6,d0
	mulsl d1,d0
	addl d0,d0
	movel d0,sp@-
	movel d4,d0
	mulsl d1,d0
	movel a2@(28),a0
	pea a0@(d0:l:2)
	mulsl d5,d1
	pea a0@(d1:l:2)
	jbsr _copy__3MemPvPCvUl
	addw #12,sp
	movel d5,d7
	addl d6,d7
	jra L289
	.even
L288:
	clrl d3
	movel d0,d2
	movel d5,d7
	addl d6,d7
	cmpl d3,d6
	jle L289
	lea _copy__3MemPvPCvUl,a3
	.even
L292:
	movel a2@(12),d1
	movel d2,d0
	mulsl d1,d0
	addl d0,d0
	movel d0,sp@-
	movel d4,d0
	addl d3,d0
	mulsl d1,d0
	movel a2@(28),a0
	pea a0@(d0:l:2)
	movel d5,d0
	addl d3,d0
	mulsl d1,d0
	pea a0@(d0:l:2)
	jbsr a3@
	movel d3,d0
	addl d2,d0
	addw #12,sp
	cmpl d0,d6
	jge L293
	movel d6,d2
	subl d3,d2
	addl d2,d3
	movel a2@(12),d1
	movel d2,d0
	mulsl d1,d0
	addl d0,d0
	movel d0,sp@-
	movel d4,d0
	addl d3,d0
	mulsl d1,d0
	movel a2@(28),a0
	pea a0@(d0:l:2)
	movel d5,d0
	addl d3,d0
	mulsl d1,d0
	pea a0@(d0:l:2)
	jbsr a3@
	addw #12,sp
L293:
	addl d2,d3
	cmpl d3,d6
	jgt L292
L289:
	movel d7,d5
	movel a2@(4),d0
L287:
	addl d6,d4
	cmpl d4,d0
	jhi L286
L285:
	movel d5,a2@(16)
	movel a2@(36),a0
	movew a2@(22),a0@(d5:l:2)
	clrl d0
L296:
	moveml a5@(-32),#0xcfc
	unlk a5
	rts
	.even
.globl _assignSingle__12PoolSmallRawPv
_assignSingle__12PoolSmallRawPv:
	pea a5@
	movel sp,a5
	moveml #0x2030,sp@-
	movel a5@(8),a1
	movel a5@(12),a2
	tstl a2@
	jeq L299
	movel #-50462723,d0
	jra L308
	.even
L299:
	tstl a1@(20)
	jeq L300
	movel a1@(16),d0
	movel a1@(36),a0
	clrl d1
	movew a0@(d0:l:2),d1
	movel a1@(24),a0
	movel a2,a0@(d0:l:4)
	movel a1@(16),d0
	movel a1@(36),a0
	movew #1,a0@(d0:l:2)
	movel a1@(16),d0
	mulsl a1@(12),d0
	movel a1@(28),a0
	lea a0@(d0:l:2),a0
	movel a0,a2@
	movel a1@(20),d0
	movel d0,d2
	subql #1,d2
	movel d2,a1@(20)
	moveq #1,d2
	cmpl d0,d2
	jeq L301
	subql #1,d1
	jeq L302
	movel a1@(16),d0
	movel d0,a0
	addql #1,a0
	movel a0,a1@(16)
	movel a1@(36),a0
	movew d1,a0@(2,d0:l:2)
	clrl d0
	jra L308
	.even
L302:
	movel a1@(16),d0
	addql #1,d0
	movel a1@(4),a2
	cmpl d0,a2
	jls L304
	movel a1@(24),a0
	tstl a0@(d0:l:4)
	jeq L304
	movel a1@(36),a3
	clrl d1
	.even
L305:
	movew a3@(d0:l:2),d1
	addl d1,d0
	cmpl d0,a2
	jls L304
	tstl a0@(d0:l:4)
	jne L305
L304:
	movel d0,a1@(16)
	clrl d0
	jra L308
	.even
L301:
	moveq #-1,d0
	movel d0,a1@(16)
	movel #-33882118,d0
	jra L308
	.even
L300:
	movel #-50659334,d0
L308:
	moveml sp@+,#0xc04
	unlk a5
	rts
	.even
.globl _assignVector__12PoolSmallRawPvUl
_assignVector__12PoolSmallRawPvUl:
	pea a5@
	movel sp,a5
	moveml #0x3838,sp@-
	movel a5@(8),a2
	movel a5@(12),a4
	clrl d2
	movew a5@(18),d2
	movel #-50462723,d0
	tstl a4@
	jne L330
	movel #-58720262,d0
	cmpl a2@(20),d2
	jhi L330
	movel a2@(16),d0
	movew #-1,a1
	movel a2@(4),d1
	cmpl d0,d1
	jls L314
	movel a2@(24),a3
	clrl d3
	movel d1,d4
	clrl d1
	.even
L315:
	movel a2@(36),a0
	tstl a3@(d0:l:4)
	jne L317
	movew a0@(d0:l:2),d3
	cmpl d3,d2
	jhi L317
	movel d0,a1
	jra L313
	.even
L317:
	movew a0@(d0:l:2),d1
	addl d1,d0
L313:
	cmpl d0,d4
	jls L314
	tstl a1
	jlt L315
L314:
	tstl a1
	jge L320
	movel a2,sp@-
	jbsr _defrag__12PoolSmallRaw
	tstl d0
	jeq L321
	movel #-58720260,d0
	jra L330
	.even
L321:
	movel a2@(16),a1
L320:
	movel a2@(36),a0
	clrl d1
	movew a0@(a1:l:2),d1
	cmpl d2,d1
	jls L322
	movew d2,a0@(a1:l:2)
	movel a1,d0
	addl d2,d0
	movel a2@(36),a0
	subw d2,d1
	movew d1,a0@(d0:l:2)
L322:
	movel a2@(24),a0
	movel a4,a0@(a1:l:4)
	movel a1,d0
	mulsl a2@(12),d0
	movel a2@(28),a0
	lea a0@(d0:l:2),a0
	movel a0,a4@
	movel a2@(20),d0
	subl d2,d0
	movel d0,a2@(20)
	jeq L323
	cmpl a2@(16),a1
	jne L324
	movel a1,d0
	addl d2,d0
	movel a2@(4),d1
	cmpl d0,d1
	jls L326
	movel a2@(24),a0
	tstl a0@(d0:l:4)
	jeq L326
	movel a2@(36),a1
	clrl d2
	.even
L327:
	movew a1@(d0:l:2),d2
	addl d2,d0
	cmpl d0,d1
	jls L326
	tstl a0@(d0:l:4)
	jne L327
L326:
	movel d0,a2@(16)
L324:
	clrl d0
	jra L330
	.even
L323:
	moveq #-1,d0
	movel d0,a2@(16)
	movel #-33882118,d0
L330:
	moveml a5@(-24),#0x1c1c
	unlk a5
	rts
	.even
.globl _unassign__12PoolSmallRawPv
_unassign__12PoolSmallRawPv:
	pea a5@
	movel sp,a5
	moveml #0x3030,sp@-
	movel a5@(8),a2
	movel a5@(12),a3
	movel a3@,d1
	movel #-50462722,d0
	tstl d1
	jeq L350
	clrl d0
	movel a2@(28),a1
	cmpl d1,a1
	jhi L336
	movel a2@(8),a0
	lea a1@(-2,a0:l:2),a0
	cmpl d1,a0
	shi d0
	extbl d0
	negl d0
L336:
	tstl d0
	jne L335
	movel #-50462724,d0
	jra L350
	.even
L335:
	subl a1,d1
	asrl #1,d1
	divul a2@(12),d1
	movel a2@(24),a0
	tstl a0@(d1:l:4)
	jne L338
	movel #-50462725,d0
	jra L350
	.even
L338:
	clrl a3@
	movel a2@(24),a0
	clrl a0@(d1:l:4)
	movel a2@(36),a3
	clrl d3
	movew a3@(d1:l:2),d3
	addl d3,a2@(20)
	movel d1,a1
	addl d3,a1
	cmpl a2@(4),a1
	jcc L339
	movel a2@(24),a0
	tstl a0@(a1:l:4)
	jne L339
	clrl d0
	movew a3@(a1:l:2),d0
	addl d0,d3
	clrw a3@(a1:l:2)
	movel a2@(36),a0
	movew d3,a0@(d1:l:2)
L339:
	tstl d1
	jeq L342
	movel a2@(16),d0
	cmpl d1,d0
	jgt L342
	moveq #-1,d2
	cmpl d0,d2
	jne L341
L342:
	movel d1,a2@(16)
	jra L349
	.even
L341:
	movew #-1,a1
	cmpl d0,d1
	jle L344
	movel a2@(24),a3
	clrl d2
	.even
L345:
	movew #-1,a1
	tstl a3@(d0:l:4)
	jne L346
	movel d0,a1
L346:
	movel a2@(36),a0
	movew a0@(d0:l:2),d2
	addl d2,d0
	cmpl d0,d1
	jgt L345
L344:
	tstl a1
	jlt L349
	movel a2@(36),a0
	addw d3,a0@(a1:l:2)
	movel a2@(36),a0
	clrw a0@(d1:l:2)
L349:
	clrl d0
L350:
	moveml sp@+,#0xc0c
	unlk a5
	rts
.globl ___vt_12PoolSmallRaw
	.even
___vt_12PoolSmallRaw:
	.long 0
	.long 0
	.long __$_12PoolSmallRaw
	.skip 4
.globl ___vt_12PoolLargeRaw
	.even
___vt_12PoolLargeRaw:
	.long 0
	.long 0
	.long __$_12PoolLargeRaw
	.skip 4
	.even
.globl _init__12PoolLargeRaw
_init__12PoolLargeRaw:
	pea a5@
	movel sp,a5
	movel a5@(8),a0
	clrl a0@(36)
	clrl a0@
	clrl a0@(4)
	clrl a0@(12)
	clrl a0@(8)
	moveq #-1,d0
	movel d0,a0@(16)
	clrl a0@(20)
	clrl a0@(24)
	clrl a0@(28)
	unlk a5
	rts
	.even
.globl ___12PoolLargeRaw
___12PoolLargeRaw:
	link a5,#-48
	fmovem #0xfc,sp@-
	moveml #0x3f3a,sp@-
	jbsr ___get_eh_context
	movel d0,d1
	movel a5@(8),a0
	movel #___vt_8PoolBase,a0@(32)
	clrl a0@
	clrl a0@(4)
	clrl a0@(12)
	clrl a0@(8)
	moveq #-1,d0
	movel d0,a0@(16)
	clrl a0@(20)
	clrl a0@(24)
	clrl a0@(28)
	movel d1,a0
	addql #4,a0
	movel a0@,a5@(-24)
	clrl a5@(-20)
	movel a5,a5@(-16)
	movel #L40,a5@(-12)
	movel sp,a5@(-8)
L40:
	lea a5@(-24),a1
	movel a1,a0@
	movel a5@(8),a0
	movel #___vt_12PoolLargeRaw,a0@(32)
	clrl a0@(36)
	movel d1,a1
	addql #4,a1
	movel a1@,a0
	movel a0@,a1@
	movel a5@(8),d0
	moveml a5@(-160),#0x5cfc
	fmovem a5@(-120),#0x3f
	unlk a5
	rts
	.even
.globl _init__12PoolSmallRaw
_init__12PoolSmallRaw:
	pea a5@
	movel sp,a5
	movel a5@(8),a0
	clrl a0@(36)
	clrl a0@
	clrl a0@(4)
	clrl a0@(12)
	clrl a0@(8)
	moveq #-1,d0
	movel d0,a0@(16)
	clrl a0@(20)
	clrl a0@(24)
	clrl a0@(28)
	unlk a5
	rts
	.even
.globl ___12PoolSmallRaw
___12PoolSmallRaw:
	link a5,#-48
	fmovem #0xfc,sp@-
	moveml #0x3f3a,sp@-
	jbsr ___get_eh_context
	movel d0,d1
	movel a5@(8),a0
	movel #___vt_8PoolBase,a0@(32)
	clrl a0@
	clrl a0@(4)
	clrl a0@(12)
	clrl a0@(8)
	moveq #-1,d0
	movel d0,a0@(16)
	clrl a0@(20)
	clrl a0@(24)
	clrl a0@(28)
	movel d1,a0
	addql #4,a0
	movel a0@,a5@(-24)
	clrl a5@(-20)
	movel a5,a5@(-16)
	movel #L56,a5@(-12)
	movel sp,a5@(-8)
L56:
	lea a5@(-24),a1
	movel a1,a0@
	movel a5@(8),a0
	movel #___vt_12PoolSmallRaw,a0@(32)
	clrl a0@(36)
	movel d1,a1
	addql #4,a1
	movel a1@,a0
	movel a0@,a1@
	movel a5@(8),d0
	moveml a5@(-160),#0x5cfc
	fmovem a5@(-120),#0x3f
	unlk a5
	rts
