#NO_APP
.globl __3XSF$verXSF
.text
__3XSF$verXSF:
	.byte 1
.globl __3XSF$revXSF
__3XSF$revXSF:
	.byte 0
.globl __Q29XSFStream9XSFHeader$sigXSF
.data
__Q29XSFStream9XSFHeader$sigXSF:
	.byte 88
	.byte 83
	.byte 70
	.byte 0
.text
	.even
.globl _init__Q29XSFStream9XSFHeader
_init__Q29XSFStream9XSFHeader:
	pea a5@
	movel sp,a5
	movel a5@(8),a0
	moveb #1,a0@(1)
	clrb a0@(2)
	clrb a0@(3)
	clrb a0@(4)
	clrb a0@(5)
	clrb a0@(6)
	clrb a0@(7)
	clrb a0@(8)
	clrb a0@(9)
	clrb a0@(10)
	moveb #2,a0@(11)
	clrb a0@(12)
	unlk a5
	rts
	.even
.globl _set__Q29XSFStream9XSFHeaderPCcUcUcUcUc
_set__Q29XSFStream9XSFHeaderPCcUcUcUcUc:
	pea a5@
	movel sp,a5
	moveml #0x3c20,sp@-
	movel a5@(8),a2
	moveb a5@(19),d2
	moveb a5@(23),d3
	moveb a5@(27),d4
	moveb a5@(31),d5
	movel a5@(12),a0
	moveq #7,d1
	lea a2@(3),a1
	.even
L272:
	subqw #1,d1
	jeq L270
	moveb a0@+,d0
	moveb d0,a1@+
	jne L272
L270:
	addqw #1,d1
	cmpw #1,d1
	jeq L273
	subqw #1,d1
	jeq L273
	movew d1,d0
	negw d0
	andw #3,d0
	jeq L276
	cmpw #3,d0
	jge L280
	cmpw #2,d0
	jge L281
	clrb a1@+
	subqw #1,d1
L281:
	clrb a1@+
	subqw #1,d1
L280:
	clrb a1@+
	subqw #1,d1
	jeq L273
	.even
L276:
	movel a1,a0
	clrb a0@+
	clrb a0@
	clrb a1@(2)
	clrb a1@(3)
	addql #4,a1
	subqw #4,d1
	jne L276
L273:
	moveb d2,a2@(9)
	moveb d3,a2@(10)
	moveb d4,a2@(11)
	moveb d5,a2@(12)
	moveml sp@+,#0x43c
	unlk a5
	rts
	.even
.globl _read__Q29XSFStream9XSFHeaderP8StreamIn
_read__Q29XSFStream9XSFHeaderP8StreamIn:
	link a5,#-20
	movel a2,sp@-
	movel a5@(8),a2
	movel a5@(12),a0
	tstl a0
	jeq L300
	btst #3,a0@(17)
	jeq L300
	pea 17:w
	pea a5@(-18)
	movel a0,sp@-
	jbsr _readBytes__8StreamInPvUl
	addw #12,sp
	moveq #17,d1
	cmpl d0,d1
	jeq L299
L300:
	movel #-50593796,d0
	jra L306
	.even
L299:
	pea 4:w
	pea __Q29XSFStream9XSFHeader$sigXSF
	pea a5@(-18)
	jbsr _strncmp
	addw #12,sp
	tstl d0
	jne L305
	moveb a5@(-14),a2@(1)
	moveb a5@(-13),a2@(2)
	clrl d0
	moveb a5@(-3),d0
	movel d0,sp@-
	clrl d0
	moveb a5@(-4),d0
	movel d0,sp@-
	clrl d0
	moveb a5@(-5),d0
	movel d0,sp@-
	clrl d0
	moveb a5@(-6),d0
	movel d0,sp@-
	pea a5@(-12)
	movel a2,sp@-
	jbsr _set__Q29XSFStream9XSFHeaderPCcUcUcUcUc
	clrl d0
	jra L306
	.even
L305:
	moveq #-1,d0
L306:
	movel a5@(-24),a2
	unlk a5
	rts
	.even
.globl _read__Q29XSFStream9XSFHeaderP9StreamOut
_read__Q29XSFStream9XSFHeaderP9StreamOut:
	link a5,#-20
	movel a2,sp@-
	movel a5@(8),a2
	movel a5@(12),a0
	tstl a0
	jeq L309
	btst #3,a0@(17)
	jeq L309
	clrl sp@-
	pea 17:w
	pea a5@(-18)
	movel a0,sp@-
	jbsr _rawReadBytes__9StreamOutPvUll
	addw #16,sp
	moveq #17,d1
	cmpl d0,d1
	jeq L308
L309:
	movel #-50593796,d0
	jra L315
	.even
L308:
	pea 4:w
	pea __Q29XSFStream9XSFHeader$sigXSF
	pea a5@(-18)
	jbsr _strncmp
	addw #12,sp
	tstl d0
	jne L314
	moveb a5@(-14),a2@(1)
	moveb a5@(-13),a2@(2)
	clrl d0
	moveb a5@(-3),d0
	movel d0,sp@-
	clrl d0
	moveb a5@(-4),d0
	movel d0,sp@-
	clrl d0
	moveb a5@(-5),d0
	movel d0,sp@-
	clrl d0
	moveb a5@(-6),d0
	movel d0,sp@-
	pea a5@(-12)
	movel a2,sp@-
	jbsr _set__Q29XSFStream9XSFHeaderPCcUcUcUcUc
	clrl d0
	jra L315
	.even
L314:
	moveq #-1,d0
L315:
	movel a5@(-24),a2
	unlk a5
	rts
	.even
.globl _write__Q29XSFStream9XSFHeaderP9StreamOut
_write__Q29XSFStream9XSFHeaderP9StreamOut:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel a5@(12),a2
	tstl a2
	jeq L322
	btst #3,a2@(17)
	jeq L322
	pea 4:w
	pea __Q29XSFStream9XSFHeader$sigXSF
	movel a2,sp@-
	jbsr _writeBytes__9StreamOutPCvUl
	addw #12,sp
	moveq #4,d1
	cmpl d0,d1
	jne L322
	pea 13:w
	movel a5@(8),d0
	addql #1,d0
	movel d0,sp@-
	movel a2,sp@-
	jbsr _writeBytes__9StreamOutPCvUl
	moveq #13,d1
	cmpl d0,d1
	sne d0
	extbl d0
	andl #-50593797,d0
	jra L326
	.even
L322:
	movel #-50593797,d0
L326:
	movel a5@(-4),a2
	unlk a5
	rts
LC0:
	.ascii "\12Signature     : %s\12\0"
LC1:
	.ascii "XSF Version   : %ld\12\0"
LC2:
	.ascii "XSF Revision  : %ld\12\0"
LC3:
	.ascii "Version       : %ld\12\0"
LC4:
	.ascii "Revision      : %ld\12\0"
LC5:
	.ascii "Data Format   : 0x%02X\12\0"
LC6:
	.ascii "File Options  : 0x%02X\12\12\0"
	.even
.globl _dump__9XSFStream
_dump__9XSFStream:
	link a5,#-8
	movel a3,sp@-
	movel a2,sp@-
	movel a5@(8),a0
	clrb a5@(-8)
	clrb a5@(-7)
	clrb a5@(-6)
	clrb a5@(-5)
	clrb a5@(-4)
	clrb a5@(-3)
	clrb a5@(-2)
	clrb a5@(-1)
	lea a0@(1),a3
	pea 6:w
	pea a0@(4)
	pea a5@(-8)
	jbsr _strncpy
	addw #12,sp
	pea a5@(-8)
	pea LC0
	lea _printf,a2
	jbsr a2@
	addql #8,sp
	clrl d0
	moveb a3@(1),d0
	movel d0,sp@-
	pea LC1
	jbsr a2@
	addql #8,sp
	clrl d0
	moveb a3@(1),d0
	movel d0,sp@-
	pea LC2
	jbsr a2@
	addql #8,sp
	clrl d0
	moveb a3@(9),d0
	movel d0,sp@-
	pea LC3
	jbsr a2@
	addql #8,sp
	clrl d0
	moveb a3@(10),d0
	movel d0,sp@-
	pea LC4
	jbsr a2@
	addql #8,sp
	clrl d0
	moveb a3@(11),d0
	movel d0,sp@-
	pea LC5
	jbsr a2@
	addql #8,sp
	clrl d0
	moveb a3@(12),d0
	movel d0,sp@-
	pea LC6
	jbsr a2@
	movel a5@(-16),a2
	movel a5@(-12),a3
	unlk a5
	rts
	.even
.globl ___11XSFStreamIn
___11XSFStreamIn:
	link a5,#-152
	fmovem #0xfc,sp@-
	moveml #0x3f3a,sp@-
	jbsr ___get_eh_context
	movel d0,a5@(-152)
	movel d0,a5@(-148)
	movel a5@(8),a0
	movel #___vt_9XSFStream,a0@(18)
	pea a0@(1)
	jbsr _init__Q29XSFStream9XSFHeader
	addql #4,sp
	movel a5@(8),a1
	clrl a1@(14)
	movel a5@(-152),a0
	addql #4,a0
	movel a0@,a5@(-24)
	clrl a5@(-20)
	movel a5,a5@(-16)
	movel #L343,a5@(-12)
	movel sp,a5@(-8)
	movel a0,a2
	jra L342
	.even
L343:
	jra L378
	.even
L342:
	moveq #-24,d1
	addl a5,d1
	movel d1,a0@
	movel a5@(-152),d0
	movel a5@(8),a1
	lea a1@(24),a0
	clrl a0@(12)
	clrl a0@(40)
	clrl a0@(28)
	movel d0,a0
	addql #4,a0
	movel a0@,a5@(-48)
	clrl a5@(-44)
	movel d1,a5@(-40)
	movel #L348,a5@(-36)
	movel sp,a5@(-32)
L348:
	lea a5@(-48),a1
	movel a1,a0@
	movel a5@(-148),a1
	addql #4,a1
	movel a1@,a0
	movel a0@,a1@
	movel a2@,a5@(-96)
	clrl a5@(-92)
	movel a5,a5@(-88)
	movel #L362,a5@(-84)
	movel sp,a5@(-80)
	jra L361
	.even
L362:
	jra L379
	.even
L361:
	lea a5@(-96),a0
	movel a0,a2@
	movel a5@(8),a1
	movel #___vt_11XSFStreamIn,a1@(18)
	movel a2@,a0
	movel a0@,a2@
	movel a2@,a0
	movel a0@,a2@
	movel a1,d0
	jra L377
	.even
L379:
L359:
	movel a5@(-152),a0
	addql #4,a0
	movel a0@,a5@(-120)
	clrl a5@(-116)
	movel a5,a5@(-112)
	movel #L367,a5@(-108)
	movel sp,a5@(-104)
	jra L366
	.even
L367:
	jra L380
	.even
L366:
	lea a5@(-120),a1
	movel a1,a0@
	clrl sp@-
	movel a5@(8),a0
	pea a0@(22)
	jbsr __$_8StreamIn
	movel a5@(-152),a1
	addql #4,a1
	movel a1@,a0
	movel a0@,a1@
	addql #8,sp
	jbsr ___sjthrow
	.even
L378:
L340:
	movel a5@(-152),a1
	addql #4,a1
	movel a1@,a5@(-144)
	clrl a5@(-140)
	lea a5@(-136),a0
	movel a5,a0@
	movel #L371,a0@(4)
	movel sp,a5@(-128)
	jra L370
	.even
L371:
	jra L381
	.even
L370:
	lea a5@(-144),a0
	movel a0,a1@
	movel a5@(8),a1
	movel #___vt_9XSFStream,a1@(18)
	movel a5@(-152),a1
	addql #4,a1
	movel a1@,a0
	movel a0@,a1@
	jbsr ___sjthrow
	.even
L380:
L364:
	jbsr ___terminate
	.even
L381:
L368:
	jbsr ___terminate
	.even
L377:
	moveml a5@(-264),#0x5cfc
	fmovem a5@(-224),#0x3f
	unlk a5
	rts
	.even
.globl __$_11XSFStreamIn
__$_11XSFStreamIn:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel d2,sp@-
	movel a5@(8),a2
	movel a5@(12),d2
	movel #___vt_11XSFStreamIn,a2@(18)
	movel a2,sp@-
	jbsr _close__11XSFStreamIn
	clrl sp@
	pea a2@(22)
	jbsr __$_8StreamIn
	addql #8,sp
	movel #___vt_9XSFStream,a2@(18)
	btst #0,d2
	jeq L387
	movel a2,sp@-
	jbsr ___builtin_delete
L387:
	movel a5@(-8),d2
	movel a5@(-4),a2
	unlk a5
	rts
	.even
.globl _open__11XSFStreamInPCcUl
_open__11XSFStreamInPCcUl:
	link a5,#-16
	moveml #0x2030,sp@-
	movel a5@(8),a2
	movel a5@(16),sp@-
	subql #2,sp
	moveb #0,sp@(1)
	subql #2,sp
	movel a5@(12),sp@-
	moveq #22,d2
	addl a2,d2
	movel d2,sp@-
	jbsr _open__8StreamInPCcbUl
	addw #16,sp
	tstl d0
	jne L397
	pea a5@(-14)
	jbsr _init__Q29XSFStream9XSFHeader
	movel d2,sp@
	lea a5@(-14),a3
	movel a3,sp@-
	jbsr _read__Q29XSFStream9XSFHeaderP8StreamIn
	tstl d0
	jne L397
	btst #5,a5@(-3)
	jeq L393
	moveq #1,d1
	orl d1,a2@(14)
L393:
	btst #6,a5@(-3)
	jeq L395
	moveq #2,d1
	orl d1,a2@(14)
L395:
	lea a2@(1),a0
	moveb a3@,a0@+
	moveb a5@(-13),a0@+
	moveb a5@(-12),a0@+
	moveb a5@(-11),a0@+
	moveb a5@(-10),a0@+
	moveb a5@(-9),a0@+
	moveb a5@(-8),a0@+
	moveb a5@(-7),a0@+
	moveb a5@(-6),a0@+
	moveb a5@(-5),a0@+
	moveb a5@(-4),a0@+
	moveb a5@(-3),a0@+
	moveb a5@(-2),a0@
L397:
	moveml a5@(-28),#0xc04
	unlk a5
	rts
	.even
.globl _open__11XSFStreamInPCcT1UcUcUl
_open__11XSFStreamInPCcT1UcUcUl:
	link a5,#-16
	moveml #0x3830,sp@-
	movel a5@(8),a2
	moveb a5@(23),d3
	moveb a5@(27),d4
	movel a5@(28),sp@-
	subql #2,sp
	moveb #0,sp@(1)
	subql #2,sp
	movel a5@(12),sp@-
	moveq #22,d2
	addl a2,d2
	movel d2,sp@-
	jbsr _open__8StreamInPCcbUl
	addw #16,sp
	tstl d0
	jne L413
	pea a5@(-14)
	jbsr _init__Q29XSFStream9XSFHeader
	movel d2,sp@
	lea a5@(-14),a3
	movel a3,sp@-
	jbsr _read__Q29XSFStream9XSFHeaderP8StreamIn
	addql #8,sp
	tstl d0
	jne L413
	pea 6:w
	pea a5@(-11)
	movel a5@(16),sp@-
	jbsr _strncmp
	tstl d0
	jeq L403
	moveq #-4,d0
	jra L413
	.even
L403:
	cmpb a5@(-5),d3
	jhi L414
	cmpb a5@(-4),d4
	jls L407
L414:
	moveq #-5,d0
	jra L413
	.even
L407:
	btst #5,a5@(-3)
	jeq L409
	moveq #1,d0
	orl d0,a2@(14)
L409:
	btst #6,a5@(-3)
	jeq L411
	moveq #2,d0
	orl d0,a2@(14)
L411:
	lea a2@(1),a0
	moveb a3@,a0@+
	moveb a5@(-13),a0@+
	moveb a5@(-12),a0@+
	moveb a5@(-11),a0@+
	moveb a5@(-10),a0@+
	moveb a5@(-9),a0@+
	moveb a5@(-8),a0@+
	moveb a5@(-7),a0@+
	moveb a5@(-6),a0@+
	moveb a5@(-5),a0@+
	moveb a5@(-4),a0@+
	moveb a5@(-3),a0@+
	moveb a5@(-2),a0@
	clrl d0
L413:
	moveml a5@(-36),#0xc1c
	unlk a5
	rts
	.even
.globl _close__11XSFStreamIn
_close__11XSFStreamIn:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel a5@(8),a2
	pea a2@(22)
	jbsr _close__8StreamIn
	clrl a2@(14)
	clrl d0
	movel a5@(-4),a2
	unlk a5
	rts
	.even
.globl _read8__11XSFStreamInPvUl
_read8__11XSFStreamInPvUl:
	pea a5@
	movel sp,a5
	movel a5@(16),sp@-
	movel a5@(12),sp@-
	moveq #22,d0
	addl a5@(8),d0
	movel d0,sp@-
	jbsr _readBytes__8StreamInPvUl
	unlk a5
	rts
	.even
.globl _read16__11XSFStreamInPvUl
_read16__11XSFStreamInPvUl:
	pea a5@
	movel sp,a5
	movel a5@(8),a0
	movel a5@(12),d1
	movel a5@(16),d0
	btst #0,a0@(17)
	jeq L419
	movel d0,sp@-
	movel d1,sp@-
	pea a0@(22)
	jbsr _read16Swap__8StreamInPvUl
	jra L425
	.even
L419:
	addl d0,d0
	movel d0,sp@-
	movel d1,sp@-
	pea a0@(22)
	jbsr _readBytes__8StreamInPvUl
	tstl d0
	jle L424
	asrl #1,d0
L425:
L424:
	unlk a5
	rts
	.even
.globl _read32__11XSFStreamInPvUl
_read32__11XSFStreamInPvUl:
	pea a5@
	movel sp,a5
	movel a5@(8),a0
	movel a5@(12),d1
	movel a5@(16),d0
	btst #0,a0@(17)
	jeq L427
	movel d0,sp@-
	movel d1,sp@-
	pea a0@(22)
	jbsr _read32Swap__8StreamInPvUl
	jra L433
	.even
L427:
	lsll #2,d0
	movel d0,sp@-
	movel d1,sp@-
	pea a0@(22)
	jbsr _readBytes__8StreamInPvUl
	tstl d0
	jle L432
	asrl #2,d0
L433:
L432:
	unlk a5
	rts
	.even
.globl _read64__11XSFStreamInPvUl
_read64__11XSFStreamInPvUl:
	pea a5@
	movel sp,a5
	movel a5@(8),a0
	movel a5@(12),d1
	movel a5@(16),d0
	btst #0,a0@(17)
	jeq L435
	movel d0,sp@-
	movel d1,sp@-
	pea a0@(22)
	jbsr _read64Swap__8StreamInPvUl
	jra L441
	.even
L435:
	lsll #3,d0
	movel d0,sp@-
	movel d1,sp@-
	pea a0@(22)
	jbsr _readBytes__8StreamInPvUl
	tstl d0
	jle L440
	asrl #3,d0
L441:
L440:
	unlk a5
	rts
	.even
.globl ___12XSFStreamOut
___12XSFStreamOut:
	link a5,#-152
	fmovem #0xfc,sp@-
	moveml #0x3f3a,sp@-
	jbsr ___get_eh_context
	movel d0,a5@(-152)
	movel d0,a5@(-148)
	movel a5@(8),a0
	movel #___vt_9XSFStream,a0@(18)
	pea a0@(1)
	jbsr _init__Q29XSFStream9XSFHeader
	addql #4,sp
	movel a5@(8),a1
	clrl a1@(14)
	movel a5@(-152),a0
	addql #4,a0
	movel a0@,a5@(-24)
	clrl a5@(-20)
	movel a5,a5@(-16)
	movel #L450,a5@(-12)
	movel sp,a5@(-8)
	movel a0,a2
	jra L449
	.even
L450:
	jra L485
	.even
L449:
	moveq #-24,d1
	addl a5,d1
	movel d1,a0@
	movel a5@(8),a3
	lea a3@(22),a1
	movel a5@(-152),d0
	lea a3@(24),a0
	clrl a0@(12)
	clrl a0@(40)
	clrl a0@(28)
	movel d0,a0
	addql #4,a0
	movel a0@,a5@(-48)
	clrl a5@(-44)
	movel d1,a5@(-40)
	movel #L455,a5@(-36)
	movel sp,a5@(-32)
L455:
	lea a5@(-48),a3
	movel a3,a0@
	clrl a1@(152)
	movel a5@(-148),a1
	addql #4,a1
	movel a1@,a0
	movel a0@,a1@
	movel a2@,a5@(-96)
	clrl a5@(-92)
	movel a5,a5@(-88)
	movel #L469,a5@(-84)
	movel sp,a5@(-80)
	jra L468
	.even
L469:
	jra L486
	.even
L468:
	lea a5@(-96),a0
	movel a0,a2@
	movel a5@(8),a1
	movel #___vt_12XSFStreamOut,a1@(18)
	movel a2@,a0
	movel a0@,a2@
	movel a2@,a0
	movel a0@,a2@
	movel a1,d0
	jra L484
	.even
L486:
L466:
	movel a5@(-152),a0
	addql #4,a0
	movel a0@,a5@(-120)
	clrl a5@(-116)
	movel a5,a5@(-112)
	movel #L474,a5@(-108)
	movel sp,a5@(-104)
	jra L473
	.even
L474:
	jra L487
	.even
L473:
	lea a5@(-120),a3
	movel a3,a0@
	clrl sp@-
	movel a5@(8),a0
	pea a0@(22)
	jbsr __$_9StreamOut
	movel a5@(-152),a1
	addql #4,a1
	movel a1@,a0
	movel a0@,a1@
	addql #8,sp
	jbsr ___sjthrow
	.even
L485:
L447:
	movel a5@(-152),a1
	addql #4,a1
	movel a1@,a5@(-144)
	clrl a5@(-140)
	lea a5@(-136),a0
	movel a5,a0@
	movel #L478,a0@(4)
	movel sp,a5@(-128)
	jra L477
	.even
L478:
	jra L488
	.even
L477:
	lea a5@(-144),a3
	movel a3,a1@
	movel a5@(8),a0
	movel #___vt_9XSFStream,a0@(18)
	movel a5@(-152),a1
	addql #4,a1
	movel a1@,a0
	movel a0@,a1@
	jbsr ___sjthrow
	.even
L487:
L471:
	jbsr ___terminate
	.even
L488:
L475:
	jbsr ___terminate
	.even
L484:
	moveml a5@(-264),#0x5cfc
	fmovem a5@(-224),#0x3f
	unlk a5
	rts
	.even
.globl __$_12XSFStreamOut
__$_12XSFStreamOut:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel d2,sp@-
	movel a5@(8),a2
	movel a5@(12),d2
	movel #___vt_12XSFStreamOut,a2@(18)
	movel a2,sp@-
	jbsr _close__12XSFStreamOut
	clrl sp@
	pea a2@(22)
	jbsr __$_9StreamOut
	addql #8,sp
	movel #___vt_9XSFStream,a2@(18)
	btst #0,d2
	jeq L494
	movel a2,sp@-
	jbsr ___builtin_delete
L494:
	movel a5@(-8),d2
	movel a5@(-4),a2
	unlk a5
	rts
	.even
.globl _open__12XSFStreamOutPCcUl
_open__12XSFStreamOutPCcUl:
	link a5,#-16
	moveml #0x2030,sp@-
	movel a5@(8),a2
	movel a5@(16),sp@-
	subql #2,sp
	moveb #1,sp@(1)
	subql #2,sp
	subql #2,sp
	moveb #0,sp@(1)
	subql #2,sp
	movel a5@(12),sp@-
	moveq #22,d2
	addl a2,d2
	movel d2,sp@-
	jbsr _open__9StreamOutPCcbT2Ul
	addw #20,sp
	tstl d0
	jne L504
	pea a5@(-14)
	jbsr _init__Q29XSFStream9XSFHeader
	movel d2,sp@
	lea a5@(-14),a3
	movel a3,sp@-
	jbsr _read__Q29XSFStream9XSFHeaderP9StreamOut
	tstl d0
	jne L504
	btst #5,a5@(-3)
	jeq L500
	moveq #1,d1
	orl d1,a2@(14)
L500:
	btst #6,a5@(-3)
	jeq L502
	moveq #2,d1
	orl d1,a2@(14)
L502:
	lea a2@(1),a0
	moveb a3@,a0@+
	moveb a5@(-13),a0@+
	moveb a5@(-12),a0@+
	moveb a5@(-11),a0@+
	moveb a5@(-10),a0@+
	moveb a5@(-9),a0@+
	moveb a5@(-8),a0@+
	moveb a5@(-7),a0@+
	moveb a5@(-6),a0@+
	moveb a5@(-5),a0@+
	moveb a5@(-4),a0@+
	moveb a5@(-3),a0@+
	moveb a5@(-2),a0@
L504:
	moveml a5@(-28),#0xc04
	unlk a5
	rts
	.even
.globl _open__12XSFStreamOutPCcT1UcUcUcUcUl
_open__12XSFStreamOutPCcT1UcUcUcUcUl:
	pea a5@
	movel sp,a5
	moveml #0x3f20,sp@-
	movel a5@(8),a2
	movel a5@(20),d7
	movel a5@(24),d5
	movel a5@(28),d2
	movel a5@(32),d4
	moveb d2,d6
	pea 2048:w
	tstl a5@(36)
	sne d0
	negb d0
	subql #2,sp
	moveb d0,sp@(1)
	subql #2,sp
	subql #2,sp
	moveb #0,sp@(1)
	subql #2,sp
	movel a5@(12),sp@-
	moveq #22,d3
	addl a2,d3
	movel d3,sp@-
	jbsr _open__9StreamOutPCcbT2Ul
	addw #20,sp
	tstl d0
	jne L510
	clrl sp@-
	moveb d4,sp@(3)
	clrl sp@-
	moveb d2,sp@(3)
	clrl sp@-
	moveb d5,sp@(3)
	clrl sp@-
	moveb d7,sp@(3)
	movel a5@(16),sp@-
	movel a2,d2
	addql #1,d2
	movel d2,sp@-
	jbsr _set__Q29XSFStream9XSFHeaderPCcUcUcUcUc
	movel d3,sp@-
	movel d2,sp@-
	jbsr _write__Q29XSFStream9XSFHeaderP9StreamOut
	tstl d0
	jne L510
	btst #5,d6
	jeq L508
	moveq #1,d0
	orl d0,a2@(14)
L508:
	btst #6,d6
	jeq L509
	moveq #2,d0
	orl d0,a2@(14)
L509:
	clrl d0
L510:
	moveml a5@(-28),#0x4fc
	unlk a5
	rts
	.even
.globl _close__12XSFStreamOut
_close__12XSFStreamOut:
	pea a5@
	movel sp,a5
	movel a5@(8),a0
	clrl a0@(14)
	pea a0@(22)
	jbsr _close__9StreamOut
	clrl d0
	unlk a5
	rts
	.even
.globl _write8__12XSFStreamOutPCvUl
_write8__12XSFStreamOutPCvUl:
	pea a5@
	movel sp,a5
	movel a5@(16),sp@-
	movel a5@(12),sp@-
	moveq #22,d0
	addl a5@(8),d0
	movel d0,sp@-
	jbsr _writeBytes__9StreamOutPCvUl
	unlk a5
	rts
	.even
.globl _write16__12XSFStreamOutPCvUl
_write16__12XSFStreamOutPCvUl:
	pea a5@
	movel sp,a5
	movel a5@(8),a0
	movel a5@(12),d1
	movel a5@(16),d0
	btst #0,a0@(17)
	jeq L515
	movel d0,sp@-
	movel d1,sp@-
	pea a0@(22)
	jbsr _write16Swap__9StreamOutPCvUl
	jra L521
	.even
L515:
	addl d0,d0
	movel d0,sp@-
	movel d1,sp@-
	pea a0@(22)
	jbsr _writeBytes__9StreamOutPCvUl
	tstl d0
	jle L520
	asrl #1,d0
L521:
L520:
	unlk a5
	rts
	.even
.globl _write32__12XSFStreamOutPCvUl
_write32__12XSFStreamOutPCvUl:
	pea a5@
	movel sp,a5
	movel a5@(8),a0
	movel a5@(12),d1
	movel a5@(16),d0
	btst #0,a0@(17)
	jeq L523
	movel d0,sp@-
	movel d1,sp@-
	pea a0@(22)
	jbsr _write32Swap__9StreamOutPCvUl
	jra L529
	.even
L523:
	lsll #2,d0
	movel d0,sp@-
	movel d1,sp@-
	pea a0@(22)
	jbsr _writeBytes__9StreamOutPCvUl
	tstl d0
	jle L528
	asrl #2,d0
L529:
L528:
	unlk a5
	rts
	.even
.globl _write64__12XSFStreamOutPCvUl
_write64__12XSFStreamOutPCvUl:
	pea a5@
	movel sp,a5
	movel a5@(8),a0
	movel a5@(12),d1
	movel a5@(16),d0
	btst #0,a0@(17)
	jeq L531
	movel d0,sp@-
	movel d1,sp@-
	pea a0@(22)
	jbsr _write64Swap__9StreamOutPCvUl
	jra L537
	.even
L531:
	lsll #3,d0
	movel d0,sp@-
	movel d1,sp@-
	pea a0@(22)
	jbsr _writeBytes__9StreamOutPCvUl
	tstl d0
	jle L536
	asrl #3,d0
L537:
L536:
	unlk a5
	rts
.globl __11XSFStorable$fileMarker
.data
__11XSFStorable$fileMarker:
	.byte 120
	.byte 115
	.byte 102
	.byte 0
.text
LC7:
	.ascii "undefined\0"
	.even
.globl ___11XSFStorable
___11XSFStorable:
	pea a5@
	movel sp,a5
	movel a3,sp@-
	movel a2,sp@-
	movel a5@(8),a2
	movel #___vt_11XSFStorable,a2@(30)
	lea a2@(2),a3
	pea LC7
	movel a3,sp@-
	jbsr _getValue__C5Key32PCc
	movel d0,a3@
	clrw a2@(6)
	clrw a2@(8)
	clrw a2@(10)
	clrw a2@(12)
	clrl a2@(14)
	clrl a2@(18)
	clrl a2@(22)
	clrw a2@(26)
	clrb a2@(28)
	clrb a2@(29)
	movel a2,d0
	movel a5@(-8),a2
	movel a5@(-4),a3
	unlk a5
	rts
	.even
.globl ___11XSFStorablePCcUsUsUcUc
___11XSFStorablePCcUsUsUcUc:
	pea a5@
	movel sp,a5
	moveml #0x3c30,sp@-
	movel a5@(8),a2
	movel a5@(16),d2
	movel a5@(20),d3
	movel a5@(24),d4
	movel a5@(28),d5
	movel #___vt_11XSFStorable,a2@(30)
	lea a2@(2),a3
	movel a5@(12),sp@-
	movel a3,sp@-
	jbsr _getValue__C5Key32PCc
	movel d0,a3@
	movew d2,a2@(6)
	movew d3,a2@(8)
	clrw a2@(10)
	clrw a2@(12)
	clrl a2@(14)
	clrl a2@(18)
	clrl a2@(22)
	clrw a2@(26)
	moveb d4,a2@(28)
	moveb d5,a2@(29)
	movel a2,d0
	moveml a5@(-24),#0xc3c
	unlk a5
	rts
	.even
.globl _read__11XSFStorableP11XSFStreamIn
_read__11XSFStorableP11XSFStreamIn:
	link a5,#-4
	movel a2,sp@-
	movel d2,sp@-
	movel a5@(8),a2
	movel a5@(12),d2
	jne L547
	movel #-50462722,d0
	jra L558
	.even
L547:
	movel a2@(30),a0
	movel a2,sp@-
	movel a0@(12),a0
	jbsr a0@
	addql #4,sp
	tstl d0
	jne L558
	clrb a5@(-4)
	clrb a5@(-3)
	clrb a5@(-2)
	clrb a5@(-1)
	pea 4:w
	pea a5@(-4)
	movel d2,sp@-
	jbsr _read8__11XSFStreamInPvUl
	addw #12,sp
	moveq #4,d1
	cmpl d0,d1
	jne L550
	pea 3:w
	pea __11XSFStorable$fileMarker
	pea a5@(-4)
	jbsr _strncmp
	addw #12,sp
	tstl d0
	jne L550
	pea 1:w
	pea a2@(2)
	movel d2,sp@-
	jbsr _read32__11XSFStreamInPvUl
	addw #12,sp
	moveq #1,d1
	cmpl d0,d1
	jne L550
	pea 4:w
	pea a2@(6)
	movel d2,sp@-
	jbsr _read16__11XSFStreamInPvUl
	addw #12,sp
	moveq #4,d1
	cmpl d0,d1
	jne L550
	pea 3:w
	pea a2@(14)
	movel d2,sp@-
	jbsr _read32__11XSFStreamInPvUl
	addw #12,sp
	moveq #3,d1
	cmpl d0,d1
	jne L550
	pea 1:w
	pea a2@(26)
	movel d2,sp@-
	jbsr _read16__11XSFStreamInPvUl
	addw #12,sp
	moveq #1,d1
	cmpl d0,d1
	jne L550
	pea 2:w
	pea a2@(28)
	movel d2,sp@-
	jbsr _read8__11XSFStreamInPvUl
	addw #12,sp
	moveq #2,d1
	cmpl d0,d1
	jeq L549
L550:
	moveq #-7,d0
	jra L558
	.even
L549:
	movel a2@(30),a0
	movel d2,sp@-
	movel a2,sp@-
	movel a0@(20),a0
	jbsr a0@
	tstl d0
	jlt L558
	moveq #32,d1
	addl d1,d0
L558:
	movel a5@(-12),d2
	movel a5@(-8),a2
	unlk a5
	rts
	.even
.globl _write__11XSFStorableP12XSFStreamOut
_write__11XSFStorableP12XSFStreamOut:
	pea a5@
	movel sp,a5
	movel a3,sp@-
	movel a2,sp@-
	movel a5@(8),a3
	movel a5@(12),a2
	tstl a2
	jne L560
	movel #-50462722,d0
	jra L573
	.even
L560:
	movel a3@(30),a0
	movel a3,sp@-
	movel a0@(12),a0
	jbsr a0@
	addql #4,sp
	tstl d0
	jne L573
	lea __11XSFStorable$fileMarker+3,a0
	moveb a2@(12),a0@
	pea 4:w
	pea a0@(-3)
	movel a2,sp@-
	jbsr _write8__12XSFStreamOutPCvUl
	addw #12,sp
	moveq #4,d1
	cmpl d0,d1
	jne L565
	pea 1:w
	pea a3@(2)
	movel a2,sp@-
	jbsr _write32__12XSFStreamOutPCvUl
	addw #12,sp
	moveq #1,d1
	cmpl d0,d1
	jne L565
	pea 4:w
	pea a3@(6)
	movel a2,sp@-
	jbsr _write16__12XSFStreamOutPCvUl
	addw #12,sp
	moveq #4,d1
	cmpl d0,d1
	jne L565
	pea 3:w
	pea a3@(14)
	movel a2,sp@-
	jbsr _write32__12XSFStreamOutPCvUl
	addw #12,sp
	moveq #3,d1
	cmpl d0,d1
	jne L565
	pea 1:w
	pea a3@(26)
	movel a2,sp@-
	jbsr _write16__12XSFStreamOutPCvUl
	addw #12,sp
	moveq #1,d1
	cmpl d0,d1
	jne L565
	pea 2:w
	pea a3@(28)
	movel a2,sp@-
	jbsr _write8__12XSFStreamOutPCvUl
	addw #12,sp
	moveq #2,d1
	cmpl d0,d1
	jeq L564
L565:
	moveq #-8,d0
	jra L573
	.even
L564:
	movel a3@(30),a0
	movel a2,sp@-
	movel a3,sp@-
	movel a0@(16),a0
	jbsr a0@
	tstl d0
	jlt L573
	moveq #32,d1
	addl d1,d0
L573:
	movel a5@(-8),a2
	movel a5@(-4),a3
	unlk a5
	rts
LC8:
	.ascii "\12Dump of XSFStorable object\12\0"
LC9:
	.ascii "chunkID    0x%08X\12\0"
LC10:
	.ascii "superClass     0x%04X\12\0"
LC11:
	.ascii "subClass       0x%04X\12\0"
LC12:
	.ascii "cnctSuper      0x%04X\12\0"
LC13:
	.ascii "cnctSub        0x%04X\12\0"
LC14:
	.ascii "rawSize    %10lu\12\0"
LC15:
	.ascii "namePtr    0x%08X\12\0"
LC16:
	.ascii "extProps   0x%08X\12\0"
LC17:
	.ascii "control        0x%04X\12\0"
LC18:
	.ascii "version    %ld\12\0"
LC19:
	.ascii "revision   %ld\12\0"
	.even
.globl _dump__11XSFStorable
_dump__11XSFStorable:
	pea a5@
	movel sp,a5
	movel a3,sp@-
	movel a2,sp@-
	movel a5@(8),a3
	pea LC8
	jbsr _puts
	movel a3@(2),sp@
	pea LC9
	lea _printf,a2
	jbsr a2@
	clrl d0
	movew a3@(6),d0
	movel d0,sp@-
	pea LC10
	jbsr a2@
	clrl d0
	movew a3@(8),d0
	movel d0,sp@-
	pea LC11
	jbsr a2@
	clrl d0
	movew a3@(10),d0
	movel d0,sp@-
	pea LC12
	jbsr a2@
	addw #32,sp
	clrl d0
	movew a3@(12),d0
	movel d0,sp@-
	pea LC13
	jbsr a2@
	movel a3@(14),sp@-
	pea LC14
	jbsr a2@
	movel a3@(18),sp@-
	pea LC15
	jbsr a2@
	movel a3@(22),sp@-
	pea LC16
	jbsr a2@
	addw #32,sp
	clrl d0
	movew a3@(26),d0
	movel d0,sp@-
	pea LC17
	jbsr a2@
	clrl d0
	moveb a3@(28),d0
	movel d0,sp@-
	pea LC18
	jbsr a2@
	clrl d0
	moveb a3@(29),d0
	movel d0,sp@-
	pea LC19
	jbsr a2@
	movel a3@(30),a0
	movel a3,sp@-
	movel a0@(24),a0
	jbsr a0@
	movel a5@(-8),a2
	movel a5@(-4),a3
	unlk a5
	rts
	.even
___vt_11XSFStorable:
	.long 0
	.long 0
	.long _readyForWrite__11XSFStorable
	.long _readyForRead__11XSFStorable
	.long _writeBody__11XSFStorableP12XSFStreamOut
	.long _readBody__11XSFStorableP11XSFStreamIn
	.long _dumpBody__11XSFStorable
	.long __$_11XSFStorable
	.skip 4
.globl ___vt_12XSFStreamOut
	.even
___vt_12XSFStreamOut:
	.long 0
	.long 0
	.long __$_12XSFStreamOut
	.skip 4
.globl ___vt_11XSFStreamIn
	.even
___vt_11XSFStreamIn:
	.long 0
	.long 0
	.long __$_11XSFStreamIn
	.skip 4
	.even
___vt_9XSFStream:
	.long 0
	.long 0
	.long __$_9XSFStream
	.skip 4
	.even
__$_9XSFStream:
	pea a5@
	movel sp,a5
	movel a5@(8),a0
	movel #___vt_9XSFStream,a0@(18)
	btst #0,a5@(15)
	jeq L210
	movel a0,sp@-
	jbsr ___builtin_delete
L210:
	unlk a5
	rts
	.even
.globl _seek__11XSFStreamInlQ23IOS8SeekMode
_seek__11XSFStreamInlQ23IOS8SeekMode:
	pea a5@
	movel sp,a5
	movel a5@(16),sp@-
	movel a5@(12),sp@-
	moveq #22,d0
	addl a5@(8),d0
	movel d0,sp@-
	jbsr _seek__8StreamInlQ23IOS8SeekMode
	unlk a5
	rts
	.even
.globl _seek__12XSFStreamOutlQ23IOS8SeekMode
_seek__12XSFStreamOutlQ23IOS8SeekMode:
	pea a5@
	movel sp,a5
	movel a5@(16),sp@-
	movel a5@(12),sp@-
	moveq #22,d0
	addl a5@(8),d0
	movel d0,sp@-
	jbsr _seek__9StreamOutlQ23IOS8SeekMode
	unlk a5
	rts
	.even
_readyForWrite__11XSFStorable:
	pea a5@
	movel sp,a5
	clrl d0
	unlk a5
	rts
	.even
_readyForRead__11XSFStorable:
	pea a5@
	movel sp,a5
	clrl d0
	unlk a5
	rts
	.even
_writeBody__11XSFStorableP12XSFStreamOut:
	pea a5@
	movel sp,a5
	clrl d0
	unlk a5
	rts
	.even
_readBody__11XSFStorableP11XSFStreamIn:
	pea a5@
	movel sp,a5
	clrl d0
	unlk a5
	rts
	.even
_dumpBody__11XSFStorable:
	pea a5@
	movel sp,a5
	unlk a5
	rts
	.even
__$_11XSFStorable:
	pea a5@
	movel sp,a5
	movel a5@(8),a0
	movel #___vt_11XSFStorable,a0@(30)
	btst #0,a5@(15)
	jeq L266
	movel a0,sp@-
	jbsr ___builtin_delete
L266:
	unlk a5
	rts
