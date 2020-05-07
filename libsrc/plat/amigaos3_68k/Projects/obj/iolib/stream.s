#NO_APP
.text
	.even
.globl _sendPacket__17AsyncStreamBufferPv
_sendPacket__17AsyncStreamBufferPv:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel a5@(8),a2
	lea a2@(116),a0
	movel a0,a2@(72)
	movel a5@(12),a2@(92)
	pea a2@(48)
	movel a2@(44),sp@-
	jbsr _PutMsg
	moveq #1,d0
	orl d0,a2@(12)
	movel a5@(-4),a2
	unlk a5
	rts
	.even
.globl _waitPacket__17AsyncStreamBuffer
_waitPacket__17AsyncStreamBuffer:
	pea a5@
	movel sp,a5
	movel a3,sp@-
	movel a2,sp@-
	movel a5@(8),a2
	btst #0,a2@(15)
	jeq L158
	lea a2@(28),a3
	.even
L161:
	clrb a2@(130)
	pea a2@(116)
	jbsr _WaitPort
	movel d0,sp@-
	jbsr _Remove
	moveb #2,a2@(130)
	moveq #-2,d0
	andl d0,a2@(12)
	movel a2@(80),d0
	addql #8,sp
	jge L167
	clrl sp@-
	movel a2@(40),sp@-
	clrl sp@-
	movel a2@(84),sp@-
	jbsr _ErrorReport
	addw #16,sp
	tstl d0
	jeq L163
	moveq #-9,d0
	andl d0,a2@(12)
	movel #-50659333,d0
	jra L167
	.even
L163:
	btst #4,a2@(15)
	jeq L164
	movel a2@(16),d0
	jra L169
	.even
L164:
	moveq #1,d0
	subl a2@(16),d0
L169:
	movel a3@(d0:l:4),sp@-
	movel a2,sp@-
	jbsr _sendPacket__17AsyncStreamBufferPv
	addql #8,sp
	jra L161
	.even
L158:
	movel a2@(84),sp@-
	jbsr _SetIoErr
	movel a2@(80),d0
L167:
	movel a5@(-8),a2
	movel a5@(-4),a3
	unlk a5
	rts
	.even
.globl _requeuePacket__17AsyncStreamBuffer
_requeuePacket__17AsyncStreamBuffer:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel a5@(8),a2
	pea a2@(48)
	pea a2@(136)
	jbsr _AddHead
	moveq #1,d0
	orl d0,a2@(12)
	movel a5@(-4),a2
	unlk a5
	rts
	.even
.globl _recordSyncFailure__17AsyncStreamBuffer
_recordSyncFailure__17AsyncStreamBuffer:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel a5@(8),a2
	moveq #-1,d0
	movel d0,a2@(80)
	jbsr _IoErr
	movel d0,a2@(84)
	clrl a2@(24)
	moveq #-9,d0
	andl d0,a2@(12)
	movel a5@(-4),a2
	unlk a5
	rts
	.even
.globl _create__17AsyncStreamBufferUl
_create__17AsyncStreamBufferUl:
	pea a5@
	movel sp,a5
	moveml #0x3020,sp@-
	movel a5@(8),a2
	movel a5@(12),d3
	tstl a2@(40)
	jne L173
	movel #-50593792,d0
	jra L177
	.even
L173:
	tstl a2@(28)
	jeq L174
	movel #-50659328,d0
	jra L177
	.even
L174:
	pea 16:w
	subql #2,sp
	moveb #1,sp@(1)
	subql #2,sp
	movel d3,sp@-
	jbsr _alloc__3MemUlbQ23Mem9AlignType
	movel d0,d1
	movel d1,a2@(28)
	addw #12,sp
	jne L175
	movel #-50528257,d0
	jra L177
	.even
L175:
	movel a2@(40),d2
	lsll #2,d2
	movel d2,a0
	movel a0@(8),a2@(44)
	movel d3,d0
	lsrl #1,d0
	movel d0,a2@
	addl d1,d0
	movel d0,a2@(32)
	movel d1,a2@(36)
	clrl a2@(16)
	clrl a2@(20)
	moveq #-2,d0
	andl d0,a2@(12)
	lea a2@(140),a0
	movel a0,a2@(136)
	clrl a0@
	lea a2@(136),a0
	movel a0,a2@(144)
	moveb #4,a2@(124)
	clrl a2@(126)
	moveb #2,a2@(130)
	moveb #4,a2@(131)
	clrl sp@-
	jbsr _FindTask
	movel d0,a2@(132)
	lea a2@(48),a0
	movel a0,a2@(68)
	movel d2,a0
	movel a0@(36),a2@(88)
	movel a2@,a2@(96)
	clrl a2@(80)
	clrl a2@(84)
	lea a2@(68),a0
	movel a0,a2@(58)
	moveb #5,a2@(56)
	movew #68,a2@(66)
	clrl d0
L177:
	moveml a5@(-12),#0x40c
	unlk a5
	rts
	.even
.globl _destroy__17AsyncStreamBuffer
_destroy__17AsyncStreamBuffer:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel a5@(8),a2
	movel a2@(28),d0
	jeq L179
	movel d0,sp@-
	jbsr _free__3MemPv
	clrl a2@(28)
L179:
	movel a5@(-4),a2
	unlk a5
	rts
	.even
.globl _exists__17AsyncStreamBufferPCc
_exists__17AsyncStreamBufferPCc:
	pea a5@
	movel sp,a5
	pea 1005:w
	movel a5@(8),sp@-
	jbsr _Open
	addql #8,sp
	tstl d0
	jne L181
	clrb d0
	jra L182
	.even
L181:
	movel d0,sp@-
	jbsr _Close
	moveq #1,d0
L182:
	unlk a5
	rts
	.even
.globl __$_8StreamIn
__$_8StreamIn:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel d2,sp@-
	movel a5@(8),a2
	movel a5@(12),d2
	movel a2,sp@-
	jbsr _close__8StreamIn
	addql #4,sp
	pea a2@(2)
	jbsr _destroy__17AsyncStreamBuffer
	addql #4,sp
	btst #0,d2
	jeq L190
	movel a2,sp@-
	jbsr ___builtin_delete
L190:
	movel a5@(-8),d2
	movel a5@(-4),a2
	unlk a5
	rts
	.even
.globl _processIO__8StreamIn
_processIO__8StreamIn:
	pea a5@
	movel sp,a5
	moveml #0x3030,sp@-
	movel a5@(8),a2
	movel a2,d3
	addql #2,d3
	movel d3,sp@-
	jbsr _waitPacket__17AsyncStreamBuffer
	movel d0,d2
	addql #4,sp
	jgt L192
	jne L193
	moveq #2,d0
	orl d0,a2@(14)
	clrl sp@-
	jbsr _SetIoErr
	moveq #-1,d0
	jra L196
	.even
L193:
	moveq #-9,d0
	andl d0,a2@(14)
	movel #-50593796,d0
	jra L196
	.even
L192:
	movel a2@(18),d0
	eorw #1,d0
	lea a2@(30),a3
	movel a3@(d0:l:4),sp@-
	movel d3,sp@-
	jbsr _sendPacket__17AsyncStreamBufferPv
	cmpl a2@(22),d2
	jcc L195
	movel d2,a2@(22)
L195:
	movel a2@(18),d0
	movel a2@(22),d1
	movel a3@(d0:l:4),a3
	addl d1,a3
	movel a3,a2@(38)
	eorw #1,d0
	movel d0,a2@(18)
	subl d1,d2
	movel d2,a2@(26)
	clrl a2@(22)
	clrl d0
L196:
	moveml a5@(-16),#0xc0c
	unlk a5
	rts
	.even
.globl _open__8StreamInPCcbUl
_open__8StreamInPCcbUl:
	link a5,#-40
	moveml #0x3830,sp@-
	movel a5@(8),a2
	movel a5@(12),d2
	jne L198
	movel #-50462722,d0
	jra L210
	.even
L198:
	tstl a2@(42)
	jne L200
	pea 1005:w
	movel d2,sp@-
	jbsr _Open
	lea a2@(2),a0
	movel d0,a0@(40)
	addql #8,sp
	movel a0,d4
	tstl d0
	jeq L200
	pea 1:w
	clrl sp@-
	movel a2@(42),sp@-
	lea _Seek,a3
	jbsr a3@
	addw #12,sp
	tstl d0
	jge L201
	movel a2@(42),sp@-
	jbsr _Close
	clrl a2@(6)
	clrl a2@(42)
	movel #-50593794,d0
	jra L210
	.even
L201:
	clrl sp@-
	clrl sp@-
	movel a2@(42),sp@-
	jbsr a3@
	movel d0,a2@(6)
	addqw #8,sp
	movel #-1,sp@
	clrl sp@-
	movel a2@(42),sp@-
	jbsr a3@
	moveq #16,d0
	orl d0,a2@(14)
	movel #512,a2@(10)
	pea -2:w
	movel d2,sp@-
	jbsr _Lock
	movel d0,d3
	addw #20,sp
	jeq L203
	moveq #-37,d2
	addl a5,d2
	moveq #-4,d1
	andl d1,d2
	movel d2,sp@-
	movel d3,sp@-
	jbsr _Info
	addql #8,sp
	tstl d0
	jeq L204
	movel d2,a0
	movel a0@(20),a2@(10)
L204:
	movel d3,sp@-
	jbsr _UnLock
	addql #4,sp
L203:
	movel a2@(10),d2
	movel d2,d1
	addl d1,d1
	movel a5@(20),a0
	lea a0@(-1,d1:l),a0
	movel a0,d0
	divul d1,d0
	addl d0,d0
	mulsl d2,d0
	movel d0,sp@-
	movel d4,sp@-
	jbsr _create__17AsyncStreamBufferUl
	movel d0,d2
	addql #8,sp
	jne L205
	moveq #82,d0
	movel d0,a2@(78)
	clrl a2@(26)
	movel a2@(34),a2@(38)
	tstl a2@(46)
	jeq L206
	movel a2@(30),sp@-
	movel d4,sp@-
	jbsr _sendPacket__17AsyncStreamBufferPv
L206:
	movel a2@(14),d0
	moveq #8,d1
	orl d0,d1
	movel d1,a2@(14)
	tstb a5@(19)
	jeq L208
	moveq #119,d1
	notb d1
	orl d0,d1
	movel d1,a2@(14)
	jra L208
	.even
L205:
	andw #65287,a2@(16)
	movel a2@(42),sp@-
	jbsr _Close
	clrl a2@(42)
L208:
	movel d2,d0
	jra L210
	.even
L200:
	movel #-50593803,d0
L210:
	moveml a5@(-60),#0xc1c
	unlk a5
	rts
	.even
.globl _close__8StreamIn
_close__8StreamIn:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel d2,sp@-
	movel a5@(8),a2
	tstl a2@(42)
	jeq L212
	movel a2,d2
	addql #2,d2
	movel d2,sp@-
	jbsr _waitPacket__17AsyncStreamBuffer
	movel a2@(42),sp@-
	jbsr _Close
	movel d2,sp@-
	jbsr _destroy__17AsyncStreamBuffer
	clrl a2@(42)
	andw #65287,a2@(16)
L212:
	movel a5@(-8),d2
	movel a5@(-4),a2
	unlk a5
	rts
	.even
.globl _flush__8StreamIn
_flush__8StreamIn:
	pea a5@
	movel sp,a5
	movel a5@(8),a0
	tstl a0@(42)
	jeq L214
	pea a0@(2)
	jbsr _waitPacket__17AsyncStreamBuffer
L214:
	unlk a5
	rts
	.even
.globl _tell__8StreamIn
_tell__8StreamIn:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel d2,sp@-
	movel a5@(8),a2
	tstl a2@(42)
	jeq L217
	pea a2@(2)
	jbsr _waitPacket__17AsyncStreamBuffer
	movel d0,d2
	addql #4,sp
	jlt L217
	clrl sp@-
	clrl sp@-
	movel a2@(42),sp@-
	jbsr _Seek
	movel a2@(26),d1
	addl d2,d1
	subl d1,d0
	addl a2@(22),d0
	jra L218
	.even
L217:
	movel #-50593800,d0
L218:
	movel a5@(-8),d2
	movel a5@(-4),a2
	unlk a5
	rts
	.even
.globl _seek__8StreamInlQ23IOS8SeekMode
_seek__8StreamInlQ23IOS8SeekMode:
	link a5,#-264
	moveml #0x3f3a,sp@-
	movel a5@(8),a3
	movel a5@(12),d3
	movel a5@(16),a4
	tstl a3@(42)
	jeq L237
	movel a3,d2
	addql #2,d2
	movel d2,sp@-
	jbsr _waitPacket__17AsyncStreamBuffer
	movel d0,d7
	addql #4,sp
	movel d2,d4
	tstl d7
	jlt L237
	clrl sp@-
	clrl sp@-
	movel a3@(42),sp@-
	lea _Seek,a2
	jbsr a2@
	movel d0,d5
	addw #12,sp
	movel a2,a6
	jlt L238
	movel a3@(26),d2
	movel d2,d1
	addl d7,d1
	movel d5,d0
	subl d1,d0
	movel d0,d6
	addl a3@(22),d6
	movel d2,a0
	tstl a4
	jne L223
	addl d6,d3
	jra L224
	.even
L223:
	moveq #-1,d0
	cmpl a4,d0
	jeq L224
	movel a5,d2
	addl #-261,d2
	moveq #-4,d0
	andl d0,d2
	movel d2,sp@-
	movel a3@(42),sp@-
	jbsr _ExamineFH
	addql #8,sp
	tstw d0
	jeq L238
	movel d2,a0
	addl a0@(124),d3
	movel a3@(26),a0
L224:
	movel a3@(18),d0
	eorw #1,d0
	lea a3@(30),a2
	movel a2@(d0:l:4),a1
	movel a3@(38),d0
	subl a1,d0
	movel d6,d1
	subl d0,d1
	movel d6,d0
	addl a0,d0
	addl d7,d0
	movel d3,d2
	subl d6,d2
	cmpl d3,d1
	jgt L229
	cmpl d3,d0
	jgt L228
L229:
	movel a3@(10),d0
	movel d3,d2
	divsl d0,d2
	mulsl d0,d2
	clrl sp@-
	movel d2,d0
	subl d5,d0
	movel d0,sp@-
	movel a3@(42),sp@-
	jbsr a6@
	addw #12,sp
	tstl d0
	jge L230
L238:
	movel d4,sp@-
	jbsr _recordSyncFailure__17AsyncStreamBuffer
L237:
	movel #-50593800,d0
	jra L235
	.even
L230:
	movel a2@,sp@-
	movel d4,sp@-
	jbsr _sendPacket__17AsyncStreamBufferPv
	subl d2,d3
	movel d3,a3@(22)
	clrl a3@(26)
	clrl a3@(18)
	movel a3@(34),a3@(38)
	jra L231
	.even
L228:
	cmpl d3,d6
	jgt L233
	cmpl d2,a0
	jlt L232
L233:
	movel d4,sp@-
	jbsr _requeuePacket__17AsyncStreamBuffer
	subl d2,a3@(26)
	addl d2,a3@(38)
	jra L231
	.even
L232:
	movel a1,sp@-
	movel d4,sp@-
	jbsr _sendPacket__17AsyncStreamBufferPv
	movel a3@(26),d0
	subl a3@(22),d0
	subl d0,d2
	movel a3@(18),d0
	movel a2@(d0:l:4),a2
	addl d2,a2
	movel a2,a3@(38)
	subl d2,d7
	movel d7,a3@(26)
	clrl a3@(22)
	eorw #1,d0
	movel d0,a3@(18)
L231:
	movel d6,d0
L235:
	moveml a5@(-304),#0x5cfc
	unlk a5
	rts
	.even
.globl _readBytes__8StreamInPvUl
_readBytes__8StreamInPvUl:
	pea a5@
	movel sp,a5
	moveml #0x3e38,sp@-
	movel a5@(8),a2
	movel a5@(12),d4
	movel a5@(16),d3
	tstl a2@(42)
	jne L240
	movel #-50593796,d0
	jra L248
	.even
L249:
	moveq #2,d0
	orl d0,a2@(14)
	clrl sp@-
	jbsr _SetIoErr
	movel d6,d0
	jra L248
	.even
L240:
	clrl d6
	movel a2@(26),d0
	lea _copy__3MemPvPCvUl,a4
	cmpl d3,d0
	jcc L242
	movel a2,d5
	addql #2,d5
	.even
L243:
	movel d0,sp@-
	movel a2@(38),sp@-
	movel d4,sp@-
	jbsr a4@
	movel a2@(26),d0
	subl d0,d3
	addl d0,d4
	addl d0,d6
	clrl a2@(26)
	movel d5,sp@-
	jbsr _waitPacket__17AsyncStreamBuffer
	movel d0,d2
	addw #16,sp
	jgt L244
	jeq L249
	movel #-50593796,d0
	jra L248
	.even
L244:
	movel a2@(18),d0
	eorw #1,d0
	lea a2@(30),a3
	movel a3@(d0:l:4),sp@-
	movel d5,sp@-
	jbsr _sendPacket__17AsyncStreamBufferPv
	addql #8,sp
	cmpl a2@(22),d2
	jcc L246
	movel d2,a2@(22)
L246:
	movel a2@(18),d0
	movel a2@(22),d1
	movel a3@(d0:l:4),a3
	addl d1,a3
	movel a3,a2@(38)
	eorw #1,d0
	movel d0,a2@(18)
	movel d2,d0
	subl d1,d0
	movel d0,a2@(26)
	clrl a2@(22)
	cmpl d3,d0
	jcs L243
L242:
	movel d3,sp@-
	movel a2@(38),sp@-
	movel d4,sp@-
	jbsr a4@
	subl d3,a2@(26)
	addl d3,a2@(38)
	movel d6,d0
	addl d3,d0
L248:
	moveml a5@(-32),#0x1c7c
	unlk a5
	rts
	.even
.globl _read16Swap__8StreamInPvUl
_read16Swap__8StreamInPvUl:
	pea a5@
	movel sp,a5
	moveml #0x3e38,sp@-
	movel a5@(8),a2
	movel a5@(12),d4
	movel a5@(16),d3
	movel #-50593796,d0
	tstl a2@(42)
	jeq L261
	movel d4,d0
	orl a2@(38),d0
	btst #0,d0
	jeq L253
	movel #-50462720,d0
	jra L261
	.even
L262:
	moveq #2,d0
	orl d0,a2@(14)
	clrl sp@-
	jbsr _SetIoErr
	movel d6,d0
	asrl #1,d0
	jra L261
	.even
L253:
	addl d3,d3
	clrl d6
	movel a2@(26),d0
	lea _swap16__3MemPvPCvUl,a4
	cmpl d3,d0
	jcc L255
	movel a2,d5
	addql #2,d5
	.even
L256:
	asrl #1,d0
	movel d0,sp@-
	movel a2@(38),sp@-
	movel d4,sp@-
	jbsr a4@
	movel a2@(26),d0
	subl d0,d3
	addl d0,d4
	addl d0,d6
	clrl a2@(26)
	movel d5,sp@-
	jbsr _waitPacket__17AsyncStreamBuffer
	movel d0,d2
	addw #16,sp
	jgt L257
	jeq L262
	movel #-50593796,d0
	jra L261
	.even
L257:
	movel a2@(18),d0
	eorw #1,d0
	lea a2@(30),a3
	movel a3@(d0:l:4),sp@-
	movel d5,sp@-
	jbsr _sendPacket__17AsyncStreamBufferPv
	addql #8,sp
	cmpl a2@(22),d2
	jcc L259
	movel d2,a2@(22)
L259:
	movel a2@(18),d0
	movel a2@(22),d1
	movel a3@(d0:l:4),a3
	addl d1,a3
	movel a3,a2@(38)
	eorw #1,d0
	movel d0,a2@(18)
	movel d2,d0
	subl d1,d0
	movel d0,a2@(26)
	clrl a2@(22)
	cmpl d3,d0
	jcs L256
L255:
	movel d3,d0
	lsrl #1,d0
	movel d0,sp@-
	movel a2@(38),sp@-
	movel d4,sp@-
	jbsr a4@
	subl d3,a2@(26)
	addl d3,a2@(38)
	movel d6,d0
	addl d3,d0
	lsrl #1,d0
L261:
	moveml a5@(-32),#0x1c7c
	unlk a5
	rts
	.even
.globl _read32Swap__8StreamInPvUl
_read32Swap__8StreamInPvUl:
	pea a5@
	movel sp,a5
	moveml #0x3e38,sp@-
	movel a5@(8),a2
	movel a5@(12),d4
	movel a5@(16),d3
	movel #-50593796,d0
	tstl a2@(42)
	jeq L274
	movel d4,d0
	orl a2@(38),d0
	btst #0,d0
	jeq L266
	movel #-50462720,d0
	jra L274
	.even
L275:
	moveq #2,d0
	orl d0,a2@(14)
	clrl sp@-
	jbsr _SetIoErr
	movel d6,d0
	asrl #2,d0
	jra L274
	.even
L266:
	lsll #2,d3
	clrl d6
	movel a2@(26),d0
	lea _swap32__3MemPvPCvUl,a4
	cmpl d3,d0
	jcc L268
	movel a2,d5
	addql #2,d5
	.even
L269:
	asrl #2,d0
	movel d0,sp@-
	movel a2@(38),sp@-
	movel d4,sp@-
	jbsr a4@
	movel a2@(26),d0
	subl d0,d3
	addl d0,d4
	addl d0,d6
	clrl a2@(26)
	movel d5,sp@-
	jbsr _waitPacket__17AsyncStreamBuffer
	movel d0,d2
	addw #16,sp
	jgt L270
	jeq L275
	movel #-50593796,d0
	jra L274
	.even
L270:
	movel a2@(18),d0
	eorw #1,d0
	lea a2@(30),a3
	movel a3@(d0:l:4),sp@-
	movel d5,sp@-
	jbsr _sendPacket__17AsyncStreamBufferPv
	addql #8,sp
	cmpl a2@(22),d2
	jcc L272
	movel d2,a2@(22)
L272:
	movel a2@(18),d0
	movel a2@(22),d1
	movel a3@(d0:l:4),a3
	addl d1,a3
	movel a3,a2@(38)
	eorw #1,d0
	movel d0,a2@(18)
	movel d2,d0
	subl d1,d0
	movel d0,a2@(26)
	clrl a2@(22)
	cmpl d3,d0
	jcs L269
L268:
	movel d3,d0
	lsrl #2,d0
	movel d0,sp@-
	movel a2@(38),sp@-
	movel d4,sp@-
	jbsr a4@
	subl d3,a2@(26)
	addl d3,a2@(38)
	movel d6,d0
	addl d3,d0
	lsrl #2,d0
L274:
	moveml a5@(-32),#0x1c7c
	unlk a5
	rts
	.even
.globl _read64Swap__8StreamInPvUl
_read64Swap__8StreamInPvUl:
	pea a5@
	movel sp,a5
	moveml #0x3e38,sp@-
	movel a5@(8),a2
	movel a5@(12),d4
	movel a5@(16),d3
	movel #-50593796,d0
	tstl a2@(42)
	jeq L287
	movel d4,d0
	orl a2@(38),d0
	btst #0,d0
	jeq L279
	movel #-50462720,d0
	jra L287
	.even
L288:
	moveq #2,d0
	orl d0,a2@(14)
	clrl sp@-
	jbsr _SetIoErr
	movel d6,d0
	asrl #3,d0
	jra L287
	.even
L279:
	lsll #3,d3
	clrl d6
	movel a2@(26),d0
	lea _swap64__3MemPvPCvUl,a4
	cmpl d3,d0
	jcc L281
	movel a2,d5
	addql #2,d5
	.even
L282:
	asrl #3,d0
	movel d0,sp@-
	movel a2@(38),sp@-
	movel d4,sp@-
	jbsr a4@
	movel a2@(26),d0
	subl d0,d3
	addl d0,d4
	addl d0,d6
	clrl a2@(26)
	movel d5,sp@-
	jbsr _waitPacket__17AsyncStreamBuffer
	movel d0,d2
	addw #16,sp
	jgt L283
	jeq L288
	movel #-50593796,d0
	jra L287
	.even
L283:
	movel a2@(18),d0
	eorw #1,d0
	lea a2@(30),a3
	movel a3@(d0:l:4),sp@-
	movel d5,sp@-
	jbsr _sendPacket__17AsyncStreamBufferPv
	addql #8,sp
	cmpl a2@(22),d2
	jcc L285
	movel d2,a2@(22)
L285:
	movel a2@(18),d0
	movel a2@(22),d1
	movel a3@(d0:l:4),a3
	addl d1,a3
	movel a3,a2@(38)
	eorw #1,d0
	movel d0,a2@(18)
	movel d2,d0
	subl d1,d0
	movel d0,a2@(26)
	clrl a2@(22)
	cmpl d3,d0
	jcs L282
L281:
	movel d3,d0
	lsrl #3,d0
	movel d0,sp@-
	movel a2@(38),sp@-
	movel d4,sp@-
	jbsr a4@
	subl d3,a2@(26)
	addl d3,a2@(38)
	movel d6,d0
	addl d3,d0
	lsrl #3,d0
L287:
	moveml a5@(-32),#0x1c7c
	unlk a5
	rts
	.even
.globl _readText__8StreamInPclcl
_readText__8StreamInPclcl:
	pea a5@
	movel sp,a5
	moveml #0x3f30,sp@-
	movel a5@(8),a2
	movel a5@(16),d7
	movel a5@(24),d3
	moveb a5@(23),d6
	tstl a2@(42)
	jne L291
	movel #-50593796,d0
	jra L303
	.even
L291:
	movel a5@(12),a3
	movel d7,d2
	subql #1,d2
	jeq L293
	tstl d3
	jeq L293
	clrl d5
	clrl d4
	.even
L294:
	tstl a2@(26)
	jne L296
	movel a2,sp@-
	jbsr _processIO__8StreamIn
	addql #4,sp
	tstl d0
	jne L297
L296:
	subql #1,a2@(26)
	movel a2@(38),a0
	lea a0@(1),a1
	movel a1,a2@(38)
	moveb a0@,d5
	movel d5,d0
L297:
	cmpl #-50593796,d0
	jeq L293
	moveq #-1,d1
	cmpl d0,d1
	jeq L293
	moveb d6,d4
	cmpl d0,d4
	jne L301
	subql #1,d3
L301:
	moveb d0,a3@+
	subql #1,d2
	jeq L293
	tstl d3
	jne L294
L293:
	clrb a3@
	movel d7,d0
	subl d2,d0
L303:
	moveml a5@(-32),#0xcfc
	unlk a5
	rts
	.even
.globl _rawWriteBytes__8StreamInPCvUll
_rawWriteBytes__8StreamInPCvUll:
	pea a5@
	movel sp,a5
	clrl d0
	unlk a5
	rts
	.even
.globl __$_9StreamOut
__$_9StreamOut:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel a5@(8),a2
	movel a2,sp@-
	jbsr _close__9StreamOut
	addql #4,sp
	movel a2@(152),d0
	jeq L308
	movel d0,sp@-
	jbsr _free__3MemPv
	addql #4,sp
L308:
	pea a2@(2)
	jbsr _destroy__17AsyncStreamBuffer
	addql #4,sp
	movel a5@(12),d0
	btst #0,d0
	jeq L314
	movel a2,sp@-
	jbsr ___builtin_delete
L314:
	movel a5@(-4),a2
	unlk a5
	rts
	.even
.globl _open__9StreamOutPCcbT2Ul
_open__9StreamOutPCcbT2Ul:
	link a5,#-40
	moveml #0x3038,sp@-
	movel a5@(8),a2
	movel a5@(12),d0
	jne L316
	movel #-50462722,d0
	jra L331
	.even
L316:
	tstl a2@(42)
	jne L334
	cmpb #1,a5@(23)
	jne L318
	pea 1004:w
	movel d0,sp@-
	jbsr _Open
	lea a2@(2),a0
	movel d0,a0@(40)
	addql #8,sp
	movel a0,a4
	jeq L333
	moveq #64,d0
	orl d0,a2@(14)
	pea 1:w
	clrl sp@-
	movel a2@(42),sp@-
	lea _Seek,a3
	jbsr a3@
	addw #12,sp
	tstl d0
	jlt L320
	clrl sp@-
	clrl sp@-
	movel a2@(42),sp@-
	jbsr a3@
	movel d0,a2@(6)
	addw #12,sp
	jra L323
	.even
L320:
	movel a2@(42),sp@-
	jbsr _Close
	clrl a2@(6)
	clrl a2@(42)
L334:
	movel #-50593803,d0
	jra L331
	.even
L318:
	pea 1006:w
	movel d0,sp@-
	jbsr _Open
	lea a2@(2),a0
	movel d0,a0@(40)
	addql #8,sp
	movel a0,a4
	jne L324
L333:
	movel #-50593798,d0
	jra L331
	.even
L324:
	clrl a2@(6)
	moveq #32,d0
	orl d0,a2@(14)
L323:
	movel a2@(42),d0
	jeq L334
	movel #512,a2@(10)
	movel d0,sp@-
	jbsr _ParentOfFH
	movel d0,d3
	addql #4,sp
	jeq L327
	moveq #-37,d2
	addl a5,d2
	moveq #-4,d0
	andl d0,d2
	movel d2,sp@-
	movel d3,sp@-
	jbsr _Info
	addql #8,sp
	tstl d0
	jeq L328
	movel d2,a0
	movel a0@(20),a2@(10)
L328:
	movel d3,sp@-
	jbsr _UnLock
	addql #4,sp
L327:
	movel a2@(10),d2
	movel d2,d1
	addl d1,d1
	movel a5@(24),a0
	lea a0@(-1,d1:l),a0
	movel a0,d0
	divul d1,d0
	addl d0,d0
	mulsl d2,d0
	movel d0,sp@-
	movel a4,sp@-
	jbsr _create__17AsyncStreamBufferUl
	movel d0,d2
	addql #8,sp
	jne L329
	moveq #87,d0
	movel d0,a2@(78)
	movel a4@,a2@(26)
	moveq #8,d0
	orl d0,a2@(14)
	jra L330
	.even
L329:
	andw #65287,a2@(16)
	movel a2@(42),sp@-
	jbsr _Close
	clrl a2@(42)
L330:
	movel d2,d0
L331:
	moveml a5@(-60),#0x1c0c
	unlk a5
	rts
	.even
.globl _close__9StreamOut
_close__9StreamOut:
	pea a5@
	movel sp,a5
	moveml #0x2030,sp@-
	movel a5@(8),a2
	tstl a2@(42)
	jeq L336
	movel a2,d2
	addql #2,d2
	movel d2,sp@-
	jbsr _waitPacket__17AsyncStreamBuffer
	addql #4,sp
	movel d2,a3
	tstl d0
	jlt L337
	movel a3@,d1
	movel a2@(26),d0
	cmpl d1,d0
	jge L337
	subl d0,d1
	movel d1,sp@-
	movel a2@(18),d0
	lea a2@(30),a0
	movel a0@(d0:l:4),sp@-
	movel a2@(42),sp@-
	jbsr _Write
	addw #12,sp
L337:
	movel a2@(42),sp@-
	jbsr _Close
	clrl a2@(42)
	movel a3,sp@-
	jbsr _destroy__17AsyncStreamBuffer
	andw #65287,a2@(16)
L336:
	moveml a5@(-12),#0xc04
	unlk a5
	rts
	.even
.globl _flush__9StreamOut
_flush__9StreamOut:
	pea a5@
	movel sp,a5
	movel a3,sp@-
	movel a2,sp@-
	movel a5@(8),a3
	tstl a3@(42)
	jeq L340
	lea a3@(2),a2
	movel a2,sp@-
	jbsr _waitPacket__17AsyncStreamBuffer
	addql #4,sp
	tstl d0
	jlt L340
	movel a2@,d1
	movel a3@(26),d0
	cmpl d1,d0
	jge L340
	subl d0,d1
	movel d1,sp@-
	movel a3@(18),d0
	lea a3@(30),a0
	movel a0@(d0:l:4),sp@-
	movel a3@(42),sp@-
	jbsr _Write
L340:
	movel a5@(-8),a2
	movel a5@(-4),a3
	unlk a5
	rts
	.even
.globl _tell__9StreamOut
_tell__9StreamOut:
	pea a5@
	movel sp,a5
	movel a5@(8),a0
	tstl a0@(42)
	jeq L344
	clrl sp@-
	clrl sp@-
	movel a0,sp@-
	jbsr _seek__9StreamOutlQ23IOS8SeekMode
	jra L345
	.even
L344:
	movel #-50593800,d0
L345:
	unlk a5
	rts
	.even
.globl _seek__9StreamOutlQ23IOS8SeekMode
_seek__9StreamOutlQ23IOS8SeekMode:
	pea a5@
	movel sp,a5
	moveml #0x2030,sp@-
	movel a5@(8),a2
	tstl a2@(42)
	jeq L353
	movel a2,d2
	addql #2,d2
	movel d2,sp@-
	jbsr _waitPacket__17AsyncStreamBuffer
	addql #4,sp
	movel d2,a3
	tstl d0
	jlt L353
	movel a3@,d1
	movel a2@(26),d0
	cmpl d1,d0
	jge L349
	subl d0,d1
	movel d1,sp@-
	movel a2@(18),d0
	lea a2@(30),a0
	movel a0@(d0:l:4),sp@-
	movel a2@(42),sp@-
	jbsr _Write
	addw #12,sp
	tstl d0
	jlt L351
L349:
	movel a5@(16),sp@-
	movel a5@(12),sp@-
	movel a2@(42),sp@-
	jbsr _Seek
	addw #12,sp
	tstl d0
	jlt L351
	movel a2@(2),a2@(26)
	clrl a2@(18)
	movel a2@(30),a2@(38)
	jra L352
	.even
L351:
	movel a3,sp@-
	jbsr _recordSyncFailure__17AsyncStreamBuffer
L353:
	movel #-50593800,d0
L352:
	moveml a5@(-12),#0xc04
	unlk a5
	rts
	.even
.globl _writeBytes__9StreamOutPCvUl
_writeBytes__9StreamOutPCvUl:
	pea a5@
	movel sp,a5
	moveml #0x3838,sp@-
	movel a5@(8),a2
	movel a5@(12),d3
	movel a5@(16),d2
	tstl a2@(42)
	jne L355
L367:
	movel #-50593797,d0
	jra L363
	.even
L364:
	movel a2@(30),a2@(38)
	movel a2@(2),a2@(26)
	movel d2,d0
	jra L363
	.even
L355:
	clrl d4
	cmpl a2@(26),d2
	jls L357
	lea a2@(30),a4
	.even
L358:
	tstl a2@(46)
	jeq L364
	movel a2@(26),d0
	jeq L360
	movel d0,sp@-
	movel d3,sp@-
	movel a2@(38),sp@-
	jbsr _copy__3MemPvPCvUl
	movel a2@(26),d0
	subl d0,d2
	addl d0,d3
	addl d0,d4
	addw #12,sp
L360:
	lea a2@(2),a3
	movel a3,sp@-
	jbsr _waitPacket__17AsyncStreamBuffer
	addql #4,sp
	tstl d0
	jlt L367
	movel a2@(18),d0
	movel a4@(d0:l:4),sp@-
	movel a3,sp@-
	jbsr _sendPacket__17AsyncStreamBufferPv
	movel a2@(18),d0
	eorw #1,d0
	movel d0,a2@(18)
	movel a4@(d0:l:4),a2@(38)
	movel a3@,a2@(26)
	addql #8,sp
	cmpl a2@(26),d2
	jhi L358
L357:
	movel d2,sp@-
	movel d3,sp@-
	movel a2@(38),sp@-
	jbsr _copy__3MemPvPCvUl
	subl d2,a2@(26)
	addl d2,a2@(38)
	movel d4,d0
	addl d2,d0
L363:
	moveml a5@(-24),#0x1c1c
	unlk a5
	rts
	.even
.globl _write16Swap__9StreamOutPCvUl
_write16Swap__9StreamOutPCvUl:
	pea a5@
	movel sp,a5
	moveml #0x3838,sp@-
	movel a5@(8),a3
	movel a5@(12),d3
	movel a5@(16),d2
	movel #-50593797,d0
	tstl a3@(42)
	jeq L378
	movel d3,d0
	orl a3@(38),d0
	btst #0,d0
	jeq L370
	movel #-50462720,d0
	jra L378
	.even
L379:
	movel a3@(30),a3@(38)
	movel a3@(2),a3@(26)
	movel d2,d0
	jra L378
	.even
L380:
	movel #-50593797,d0
	jra L378
	.even
L370:
	addl d2,d2
	clrl d4
	cmpl a3@(26),d2
	jls L372
	lea a3@(30),a4
	.even
L373:
	tstl a3@(46)
	jeq L379
	movel a3@(26),d0
	jeq L375
	asrl #1,d0
	movel d0,sp@-
	movel d3,sp@-
	movel a3@(38),sp@-
	jbsr _swap16__3MemPvPCvUl
	movel a3@(26),d0
	subl d0,d2
	addl d0,d3
	addl d0,d4
	addw #12,sp
L375:
	lea a3@(2),a2
	movel a2,sp@-
	jbsr _waitPacket__17AsyncStreamBuffer
	addql #4,sp
	tstl d0
	jlt L380
	movel a3@(18),d0
	movel a4@(d0:l:4),sp@-
	movel a2,sp@-
	jbsr _sendPacket__17AsyncStreamBufferPv
	movel a3@(18),d0
	eorw #1,d0
	movel d0,a3@(18)
	movel a4@(d0:l:4),a3@(38)
	movel a2@,a3@(26)
	addql #8,sp
	cmpl a3@(26),d2
	jhi L373
L372:
	movel d2,d0
	lsrl #1,d0
	movel d0,sp@-
	movel d3,sp@-
	movel a3@(38),sp@-
	jbsr _swap16__3MemPvPCvUl
	subl d2,a3@(26)
	addl d2,a3@(38)
	movel d4,d0
	addl d2,d0
	lsrl #1,d0
L378:
	moveml a5@(-24),#0x1c1c
	unlk a5
	rts
	.even
.globl _write32Swap__9StreamOutPCvUl
_write32Swap__9StreamOutPCvUl:
	pea a5@
	movel sp,a5
	moveml #0x3838,sp@-
	movel a5@(8),a3
	movel a5@(12),d3
	movel a5@(16),d2
	movel #-50593797,d0
	tstl a3@(42)
	jeq L392
	movel d3,d0
	orl a3@(38),d0
	btst #0,d0
	jeq L384
	movel #-50462720,d0
	jra L392
	.even
L393:
	movel a3@(30),a3@(38)
	movel a3@(2),a3@(26)
	movel d2,d0
	jra L392
	.even
L394:
	movel #-50593797,d0
	jra L392
	.even
L384:
	lsll #2,d2
	clrl d4
	cmpl a3@(26),d2
	jls L386
	lea a3@(30),a4
	.even
L387:
	tstl a3@(46)
	jeq L393
	movel a3@(26),d0
	jeq L389
	asrl #2,d0
	movel d0,sp@-
	movel d3,sp@-
	movel a3@(38),sp@-
	jbsr _swap32__3MemPvPCvUl
	movel a3@(26),d0
	subl d0,d2
	addl d0,d3
	addl d0,d4
	addw #12,sp
L389:
	lea a3@(2),a2
	movel a2,sp@-
	jbsr _waitPacket__17AsyncStreamBuffer
	addql #4,sp
	tstl d0
	jlt L394
	movel a3@(18),d0
	movel a4@(d0:l:4),sp@-
	movel a2,sp@-
	jbsr _sendPacket__17AsyncStreamBufferPv
	movel a3@(18),d0
	eorw #1,d0
	movel d0,a3@(18)
	movel a4@(d0:l:4),a3@(38)
	movel a2@,a3@(26)
	addql #8,sp
	cmpl a3@(26),d2
	jhi L387
L386:
	movel d2,d0
	lsrl #2,d0
	movel d0,sp@-
	movel d3,sp@-
	movel a3@(38),sp@-
	jbsr _swap32__3MemPvPCvUl
	subl d2,a3@(26)
	addl d2,a3@(38)
	movel d4,d0
	addl d2,d0
	lsrl #2,d0
L392:
	moveml a5@(-24),#0x1c1c
	unlk a5
	rts
	.even
.globl _write64Swap__9StreamOutPCvUl
_write64Swap__9StreamOutPCvUl:
	pea a5@
	movel sp,a5
	moveml #0x3838,sp@-
	movel a5@(8),a3
	movel a5@(12),d3
	movel a5@(16),d2
	movel #-50593797,d0
	tstl a3@(42)
	jeq L406
	movel d3,d0
	orl a3@(38),d0
	btst #0,d0
	jeq L398
	movel #-50462720,d0
	jra L406
	.even
L407:
	movel a3@(30),a3@(38)
	movel a3@(2),a3@(26)
	movel d2,d0
	jra L406
	.even
L408:
	movel #-50593797,d0
	jra L406
	.even
L398:
	lsll #3,d2
	clrl d4
	cmpl a3@(26),d2
	jls L400
	lea a3@(30),a4
	.even
L401:
	tstl a3@(46)
	jeq L407
	movel a3@(26),d0
	jeq L403
	asrl #3,d0
	movel d0,sp@-
	movel d3,sp@-
	movel a3@(38),sp@-
	jbsr _swap64__3MemPvPCvUl
	movel a3@(26),d0
	subl d0,d2
	addl d0,d3
	addl d0,d4
	addw #12,sp
L403:
	lea a3@(2),a2
	movel a2,sp@-
	jbsr _waitPacket__17AsyncStreamBuffer
	addql #4,sp
	tstl d0
	jlt L408
	movel a3@(18),d0
	movel a4@(d0:l:4),sp@-
	movel a2,sp@-
	jbsr _sendPacket__17AsyncStreamBufferPv
	movel a3@(18),d0
	eorw #1,d0
	movel d0,a3@(18)
	movel a4@(d0:l:4),a3@(38)
	movel a2@,a3@(26)
	addql #8,sp
	cmpl a3@(26),d2
	jhi L401
L400:
	movel d2,d0
	lsrl #3,d0
	movel d0,sp@-
	movel d3,sp@-
	movel a3@(38),sp@-
	jbsr _swap64__3MemPvPCvUl
	subl d2,a3@(26)
	addl d2,a3@(38)
	movel d4,d0
	addl d2,d0
	lsrl #3,d0
L406:
	moveml a5@(-24),#0x1c1c
	unlk a5
	rts
	.even
.globl _writeText__9StreamOutPCce
_writeText__9StreamOutPCce:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel a5@(8),a2
	tstl a2@(42)
	jeq L415
	tstl a2@(152)
	jne L412
	clrl sp@-
	subql #2,sp
	moveb #0,sp@(1)
	subql #2,sp
	pea 2048:w
	jbsr _alloc__3MemUlbQ23Mem9AlignType
	movel d0,a2@(152)
	addw #12,sp
	jne L412
L415:
	movel #-50593797,d0
	jra L414
	.even
L412:
	pea a5@(16)
	movel a5@(12),sp@-
	movel a2@(152),sp@-
	jbsr _vsprintf
	movel d0,sp@-
	movel a2@(152),sp@-
	movel a2,sp@-
	jbsr _writeBytes__9StreamOutPCvUl
L414:
	movel a5@(-4),a2
	unlk a5
	rts
	.even
.globl _rawReadBytes__9StreamOutPvUll
_rawReadBytes__9StreamOutPvUll:
	pea a5@
	movel sp,a5
	moveml #0x3c30,sp@-
	movel a5@(8),a3
	movel a5@(12),d5
	movel a5@(16),d3
	movel a5@(20),d2
	clrl sp@-
	clrl sp@-
	movel a3@(42),sp@-
	lea _Seek,a2
	jbsr a2@
	movel d0,d4
	pea -1:w
	movel d2,sp@-
	movel a3@(42),sp@-
	jbsr a2@
	movel d3,sp@-
	movel d5,sp@-
	movel a3@(42),sp@-
	jbsr _Read
	movel d0,d2
	addw #32,sp
	movel #-1,sp@
	movel d4,sp@-
	movel a3@(42),sp@-
	jbsr a2@
	movel #-50593796,d0
	tstl d2
	jlt L418
	movel d2,d0
L418:
	moveml a5@(-24),#0xc3c
	unlk a5
	rts
