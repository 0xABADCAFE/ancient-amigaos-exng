#NO_APP
.text
	.even
.globl ___11InputAIFF16
___11InputAIFF16:
	link a5,#-144
	fmovem #0xfc,sp@-
	moveml #0x3f3a,sp@-
	jbsr ___get_eh_context
	movel d0,d2
	movel d2,a1
	movel a5@(8),a0
	movel #___vt_14InputPCMStream,a0@(2)
	movel d2,a0
	addql #4,a0
	movel a0@,a5@(-24)
	clrl a5@(-20)
	movel a5,a5@(-16)
	movel #L176,a5@(-12)
	movel sp,a5@(-8)
L176:
	moveq #-24,d1
	addl a5,d1
	movel d1,a0@
	movel d2,d0
	movel a5@(8),a0
	addql #8,a0
	clrl a0@(12)
	clrl a0@(40)
	clrl a0@(28)
	movel d2,a0
	addql #4,a0
	movel a0@,a5@(-48)
	clrl a5@(-44)
	movel d1,a5@(-40)
	movel #L182,a5@(-36)
	movel sp,a5@(-32)
L182:
	lea a5@(-48),a2
	movel a2,a0@
	addql #4,a1
	movel a1@,a0
	movel a0@,a1@
	movel d2,a0
	addql #4,a0
	movel a0@,a5@(-96)
	clrl a5@(-92)
	movel a5,a5@(-88)
	movel #L195,a5@(-84)
	movel sp,a5@(-80)
	movel a0,a1
L195:
	lea a5@(-96),a2
	movel a2,a0@
	movel a5@(8),a0
	movel #___vt_11InputAIFF16,a0@(2)
	movel a0,a2
	clrl a2@(158)
	clrl a2@(162)
	clrl a2@(166)
	clrl a2@(170)
	clrl a2@(174)
	movel a1@,a0
	movel a0@,a1@
	movel a1@,a0
	movel a0@,a1@
	movel a2,d0
	moveml a5@(-256),#0x5cfc
	fmovem a5@(-216),#0x3f
	unlk a5
	rts
	.even
.globl __$_11InputAIFF16
__$_11InputAIFF16:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel d2,sp@-
	movel a5@(8),a2
	movel a5@(12),d2
	movel #___vt_11InputAIFF16,a2@(2)
	movel a2,sp@-
	jbsr _close__11InputAIFF16
	clrl sp@
	pea a2@(6)
	jbsr __$_8StreamIn
	addql #8,sp
	movel #___vt_14InputPCMStream,a2@(2)
	btst #0,d2
	jeq L217
	movel a2,sp@-
	jbsr ___builtin_delete
L217:
	movel a5@(-8),d2
	movel a5@(-4),a2
	unlk a5
	rts
	.even
.globl _decodeIEEEExt__11InputAIFF16PUc
_decodeIEEEExt__11InputAIFF16PUc:
	pea a5@
	movel sp,a5
	fmovem #0xc,sp@-
	moveml #0x3020,sp@-
	movel a5@(12),a0
	moveb a0@,d3
	moveq #127,d0
	andl d0,d3
	lsll #8,d3
	orb a0@(1),d3
	moveb a0@(2),d1
	moveq #24,d0
	lsll d0,d1
	clrl d0
	moveb a0@(3),d0
	swap d0
	clrw d0
	orl d0,d1
	clrl d0
	moveb a0@(4),d0
	lsll #8,d0
	orl d0,d1
	orb a0@(5),d1
	moveb a0@(6),d2
	moveq #24,d0
	lsll d0,d2
	clrl d0
	moveb a0@(7),d0
	swap d0
	clrw d0
	orl d0,d2
	clrl d0
	moveb a0@(8),d0
	lsll #8,d0
	orl d0,d2
	orb a0@(9),d2
	tstl d3
	jne L219
	tstl d1
	jne L219
	tstl d2
	jne L219
	fmoved #0r0.000000000000005,fp3
	jra L220
	.even
L219:
	cmpl #32767,d3
	jne L221
	fmoved #0rinf,fp3
	jra L220
	.even
L221:
	addl #-16414,d3
	movel d3,sp@-
	movel d1,d0
	addl #-2147483648,d0
	fmoved #0r2147483648.000005,fp2
	fdmovex fp2,fp0
	fdaddl d0,fp0
	fmoved fp0,sp@-
	lea _ldexp,a2
	jbsr a2@
	movel d1,sp@-
	movel d0,sp@-
	fdmoved sp@+,fp3
	movel d3,a0
	pea a0@(-32)
	movel d2,d0
	addl #-2147483648,d0
	fdaddl d0,fp2
	fmoved fp2,sp@-
	jbsr a2@
	movel d1,sp@-
	movel d0,sp@-
	fdmoved sp@+,fp0
	fdaddx fp0,fp3
L220:
	fmoved #0r1.000000000000005,fp0
	fcmpx fp0,fp3
	fjlt L224
	fdmovex fp3,fp0
	fcmpd #0r1000000.000000005,fp0
	fjngt L224
	fmoved #0r1000000.000000005,fp0
L224:
	movel a5@(8),a0
	fmoved fp0,a0@(158)
	moveml a5@(-36),#0x40c
	fmovem a5@(-24),#0x30
	unlk a5
	rts
	.even
.globl _close__11InputAIFF16
_close__11InputAIFF16:
	pea a5@
	movel sp,a5
	movel a5@(8),a0
	clrl a0@(158)
	clrl a0@(162)
	clrl a0@(166)
	clrl a0@(170)
	clrl a0@(174)
	pea a0@(6)
	jbsr _close__8StreamIn
	unlk a5
	rts
LC0:
	.ascii "FORM\0"
LC1:
	.ascii "AIFF\0"
LC2:
	.ascii "COMM\0"
LC3:
	.ascii "%hu bit AIFF not supported\12\0"
LC4:
	.ascii "SSND\0"
	.even
.globl _open__11InputAIFF16PCc
_open__11InputAIFF16PCc:
	link a5,#-40
	moveml #0x3c30,sp@-
	movel a5@(8),a2
	pea 16384:w
	subql #2,sp
	moveb #0,sp@(1)
	subql #2,sp
	movel a5@(12),sp@-
	movel a2,d2
	addql #6,d2
	movel d2,sp@-
	jbsr _open__8StreamInPCcbUl
	addw #16,sp
	tstl d0
	jne L262
	pea 4:w
	pea a5@(-4)
	movel d2,sp@-
	jbsr _readBytes__8StreamInPvUl
	addw #12,sp
	moveq #4,d1
	cmpl d0,d1
	jne L233
	pea 4:w
	pea LC0
	movel a5,d4
	subql #4,d4
	movel d4,sp@-
	lea _strncmp,a3
	jbsr a3@
	addw #12,sp
	tstl d0
	jne L233
	pea 4:w
	pea a5@(-18)
	movel d2,sp@-
	jbsr _readBytes__8StreamInPvUl
	addw #12,sp
	tstl d0
	jle L235
	asrl #2,d0
L235:
	moveq #1,d1
	cmpl d0,d1
	jne L233
	pea 4:w
	movel d4,sp@-
	movel d2,sp@-
	jbsr _readBytes__8StreamInPvUl
	addw #12,sp
	moveq #4,d1
	cmpl d0,d1
	jne L233
	pea 4:w
	pea LC1
	movel d4,sp@-
	jbsr a3@
	addw #12,sp
	tstl d0
	jeq L232
L233:
	pea a2@(6)
	jbsr _close__8StreamIn
	movel #-50593796,d0
	jra L262
	.even
L232:
	pea 4:w
	movel d4,sp@-
	movel d2,sp@-
	jbsr _readBytes__8StreamInPvUl
	addw #12,sp
	moveq #4,d1
	cmpl d0,d1
	jne L239
	pea 4:w
	pea LC2
	movel d4,sp@-
	jbsr a3@
	addw #12,sp
	tstl d0
	jne L239
	moveq #-22,d5
	addl a5,d5
	pea 4:w
	movel d5,sp@-
	movel d2,sp@-
	jbsr _readBytes__8StreamInPvUl
	addw #12,sp
	tstl d0
	jle L241
	asrl #2,d0
L241:
	moveq #1,d1
	cmpl d0,d1
	jne L239
	moveq #18,d0
	cmpl a5@(-22),d0
	jne L239
	pea 2:w
	pea a5@(-24)
	movel d2,sp@-
	jbsr _readBytes__8StreamInPvUl
	addw #12,sp
	tstl d0
	jle L243
	asrl #1,d0
L243:
	moveq #1,d1
	cmpl d0,d1
	jne L239
	pea 4:w
	pea a5@(-28)
	movel d2,sp@-
	jbsr _readBytes__8StreamInPvUl
	addw #12,sp
	tstl d0
	jle L245
	asrl #2,d0
L245:
	moveq #1,d1
	cmpl d0,d1
	jne L239
	pea 2:w
	pea a5@(-30)
	movel d2,sp@-
	jbsr _readBytes__8StreamInPvUl
	addw #12,sp
	tstl d0
	jle L247
	asrl #1,d0
L247:
	moveq #1,d1
	cmpl d0,d1
	jne L239
	pea 10:w
	pea a5@(-14)
	movel d2,sp@-
	jbsr _readBytes__8StreamInPvUl
	addw #12,sp
	moveq #10,d1
	cmpl d0,d1
	jeq L238
L239:
	pea a2@(6)
	jra L263
	.even
L238:
	movew a5@(-30),d0
	cmpw #16,d0
	jeq L250
	movew d0,sp@-
	clrw sp@-
	pea LC3
	jbsr _printf
	jra L264
	.even
L250:
	pea 4:w
	movel d4,sp@-
	movel d2,sp@-
	jbsr _readBytes__8StreamInPvUl
	addw #12,sp
	movel d2,d3
	moveq #4,d1
	cmpl d0,d1
	jne L252
	pea 4:w
	pea LC4
	movel d4,sp@-
	jbsr a3@
	addw #12,sp
	tstl d0
	jne L252
	pea 4:w
	movel d5,sp@-
	movel d3,sp@-
	jbsr _readBytes__8StreamInPvUl
	addw #12,sp
	tstl d0
	jle L254
	asrl #2,d0
L254:
	movel a2,d3
	addql #6,d3
	moveq #1,d1
	cmpl d0,d1
	jne L252
	movel d3,d2
	pea 4:w
	pea a5@(-34)
	movel d2,sp@-
	jbsr _readBytes__8StreamInPvUl
	addw #12,sp
	tstl d0
	jle L256
	asrl #2,d0
L256:
	moveq #1,d1
	cmpl d0,d1
	jne L252
	pea 4:w
	pea a5@(-38)
	movel d2,sp@-
	jbsr _readBytes__8StreamInPvUl
	addw #12,sp
	tstl d0
	jle L258
	asrl #2,d0
L258:
	moveq #1,d1
	cmpl d0,d1
	jeq L251
L252:
	movel d3,sp@-
	jra L263
	.even
L251:
	tstl a5@(-38)
	jeq L260
L264:
	movel d2,sp@-
L263:
	jbsr _close__8StreamIn
	movel #-50593803,d0
	jra L262
	.even
L260:
	movel a5@(-34),d0
	jeq L261
	clrl sp@-
	movel d0,sp@-
	movel d2,sp@-
	jbsr _seek__8StreamInlQ23IOS8SeekMode
	addw #12,sp
L261:
	movel d2,sp@-
	jbsr _tell__8StreamIn
	movel d0,a2@(170)
	movel a5@(-28),a2@(174)
	clrl d0
	movew a5@(-24),d0
	movel d0,a2@(166)
	pea a5@(-14)
	movel a2,sp@-
	jbsr _decodeIEEEExt__11InputAIFF16PUc
	clrl d0
L262:
	moveml a5@(-64),#0xc3c
	unlk a5
	rts
	.even
.globl _readCombine__11InputAIFF16PvUl
_readCombine__11InputAIFF16PvUl:
	pea a5@
	movel sp,a5
	movel a5@(8),a0
	movel a5@(12),d1
	movel a5@(16),d0
	tstl d1
	jne L266
	movel #-50462722,d0
	jra L270
	.even
L266:
	tstl d0
	jne L267
	movel #-50397188,d0
	jra L270
	.even
L267:
	mulsl a0@(166),d0
	addl d0,d0
	movel d0,sp@-
	movel d1,sp@-
	pea a0@(6)
	jbsr _readBytes__8StreamInPvUl
	tstl d0
	jle L270
	asrl #1,d0
L270:
	unlk a5
	rts
	.even
.globl _readSplit__11InputAIFF16PPvUl
_readSplit__11InputAIFF16PPvUl:
	pea a5@
	movel sp,a5
	movel #-50593792,d0
	unlk a5
	rts
.globl ___vt_11InputAIFF16
	.even
___vt_11InputAIFF16:
	.long 0
	.long 0
	.long _open__11InputAIFF16PCc
	.long _close__11InputAIFF16
	.long _getRecFreq__11InputAIFF16
	.long _getNumChannels__11InputAIFF16
	.long _getBitDepth__11InputAIFF16
	.long _isSigned__11InputAIFF16
	.long _readCombine__11InputAIFF16PvUl
	.long _readSplit__11InputAIFF16PPvUl
	.long __$_11InputAIFF16
	.skip 4
	.even
___vt_14InputPCMStream:
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
	.long __$_14InputPCMStream
	.skip 4
	.even
__$_14InputPCMStream:
	pea a5@
	movel sp,a5
	movel a5@(8),a0
	movel #___vt_14InputPCMStream,a0@(2)
	btst #0,a5@(15)
	jeq L26
	movel a0,sp@-
	jbsr ___builtin_delete
L26:
	unlk a5
	rts
	.even
.globl _getRecFreq__11InputAIFF16
_getRecFreq__11InputAIFF16:
	pea a5@
	movel sp,a5
	movel a5@(8),a0
	movel a0@(158),d0
	movel a0@(162),d1
	unlk a5
	rts
	.even
.globl _getNumChannels__11InputAIFF16
_getNumChannels__11InputAIFF16:
	pea a5@
	movel sp,a5
	movel a5@(8),a0
	movel a0@(166),d0
	unlk a5
	rts
	.even
.globl _getBitDepth__11InputAIFF16
_getBitDepth__11InputAIFF16:
	pea a5@
	movel sp,a5
	moveq #16,d0
	unlk a5
	rts
	.even
.globl _isSigned__11InputAIFF16
_isSigned__11InputAIFF16:
	pea a5@
	movel sp,a5
	moveq #1,d0
	unlk a5
	rts
