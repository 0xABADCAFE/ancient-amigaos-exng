#NO_APP
.text
LC0:
	.ascii "bad_alloc\0"
	.even
.globl ___4AIFF
___4AIFF:
	link a5,#-172
	fmovem #0xfc,sp@-
	moveml #0x3f3a,sp@-
	jbsr ___get_eh_context
	movel d0,a5@(-162)
	movel d0,a5@(-152)
	movel a5@(8),sp@-
	jbsr _ReadEClock
	movel d0,__10MilliClock$clockFreq
	addql #4,sp
	movel a5@(8),a0
	clrl a0@(24)
	clrl a0@(28)
	clrl a0@(32)
	clrw a0@(44)
	clrw a0@(46)
	pea _nothrow
	pea 152:w
	jbsr ___nw__FUlRC9nothrow_t
	movel d0,a5@(-148)
	movel a5@(-162),a0
	addql #4,a0
	movel a0@,a5@(-24)
	clrl a5@(-20)
	movel a5,a5@(-16)
	movel #L288,a5@(-12)
	movel sp,a5@(-8)
	movel a0,a5@(-166)
	jra L287
	.even
L288:
	jra L342
	.even
L287:
	moveq #-24,d1
	addl a5,d1
	movel d1,a0@
	addql #8,sp
	movel a5@(-162),d0
	movel a5@(-148),a0
	addql #2,a0
	clrl a0@(12)
	clrl a0@(40)
	clrl a0@(28)
	movel a5@(-162),a0
	addql #4,a0
	movel a0@,a5@(-48)
	clrl a5@(-44)
	movel d1,a5@(-40)
	movel #L293,a5@(-36)
	movel sp,a5@(-32)
L293:
	lea a5@(-48),a1
	movel a1,a0@
	movel a5@(-152),a0
	addql #4,a0
	movel a0@,a1
	movel a1@,a0@
	movel a0,a5@(-170)
	movel a5@(8),a0
	movel a5@(-148),a0@(8)
	movel a5@(-166),a1
	movel a1@,a0
	movel a0@,a1@
	pea _nothrow
	pea 156:w
	jbsr ___nw__FUlRC9nothrow_t
	movel d0,a5@(-156)
	movel a5@(-166),a0
	movel a0@,a5@(-96)
	clrl a5@(-92)
	movel a5,a5@(-88)
	movel #L309,a5@(-84)
	movel sp,a5@(-80)
	jra L308
	.even
L309:
	jra L343
	.even
L308:
	lea a5@(-96),a0
	movel a5@(-166),a1
	movel a0,a1@
	addql #8,sp
	movel a5@(-162),d0
	movel a5@(-156),a0
	addql #2,a0
	clrl a0@(12)
	clrl a0@(40)
	clrl a0@(28)
	movel d0,a0
	addql #4,a0
	movel a0@,a5@(-48)
	clrl a5@(-44)
	lea a5@(-24),a1
	movel a1,a5@(-40)
	movel #L314,a5@(-36)
	movel sp,a5@(-32)
L314:
	lea a5@(-48),a1
	movel a1,a0@
	movel a5@(-156),a0
	clrl a0@(152)
	movel a5@(-170),a1
	movel a1@,a0
	movel a0@,a1@
	movel a5@(8),a0
	movel a5@(-156),a0@(12)
	movel a5@(-166),a1
	movel a1@,a0
	movel a0@,a1@
	movel a5@(8),d0
	jra L341
	.even
L342:
L285:
	movel a5@(-162),a0
	addql #4,a0
	movel a0@,a5@(-120)
	clrl a5@(-116)
	movel a5,a5@(-112)
	movel #L331,a5@(-108)
	movel sp,a5@(-104)
	jra L330
	.even
L331:
	jra L344
	.even
L330:
	lea a5@(-120),a1
	movel a1,a0@
	clrb d0
	jeq L333
	pea _nothrow
	movel a5@(-148),sp@-
	jbsr ___dl__FPvRC9nothrow_t
	addql #8,sp
L333:
	movel a5@(-162),a1
	addql #4,a1
	movel a1@,a0
	movel a0@,a1@
	jbsr ___sjthrow
	.even
L343:
L306:
	movel a5@(-162),a1
	addql #4,a1
	movel a1@,a5@(-144)
	clrl a5@(-140)
	lea a5@(-136),a0
	movel a5,a0@
	movel #L337,a0@(4)
	movel sp,a5@(-128)
	jra L336
	.even
L337:
	jra L345
	.even
L336:
	lea a5@(-144),a0
	movel a0,a1@
	tstb a5@(-157)
	jeq L339
	pea _nothrow
	movel a5@(-156),sp@-
	jbsr ___dl__FPvRC9nothrow_t
	addql #8,sp
L339:
	movel a5@(-162),a1
	addql #4,a1
	movel a1@,a0
	movel a0@,a1@
	jbsr ___sjthrow
	.even
L344:
L328:
	jbsr ___terminate
	.even
L345:
L334:
	jbsr ___terminate
	.even
L341:
	moveml a5@(-284),#0x5cfc
	fmovem a5@(-244),#0x3f
	unlk a5
	rts
	.even
.globl __$_4AIFF
__$_4AIFF:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel a5@(8),a2
	movel a2@(12),d0
	jeq L348
	pea 3:w
	movel d0,sp@-
	jbsr __$_9StreamOut
	addql #8,sp
L348:
	movel a2@(8),d0
	jeq L350
	pea 3:w
	movel d0,sp@-
	jbsr __$_8StreamIn
	addql #8,sp
L350:
	movel a2@(32),d0
	jeq L352
	movel d0,sp@-
	jbsr _free__3MemPv
	addql #4,sp
L352:
	movel a5@(12),d0
	btst #0,d0
	jeq L354
	movel a2,sp@-
	jbsr ___builtin_delete
L354:
	movel a5@(-4),a2
	unlk a5
	rts
	.even
.globl _decodeIEEEExt__4AIFF
_decodeIEEEExt__4AIFF:
	pea a5@
	movel sp,a5
	fmovem #0xc,sp@-
	moveml #0x3030,sp@-
	movel a5@(8),a3
	moveb a3@(48),d3
	moveq #127,d0
	andl d0,d3
	lsll #8,d3
	orb a3@(49),d3
	moveb a3@(50),d1
	moveq #24,d0
	lsll d0,d1
	clrl d0
	moveb a3@(51),d0
	swap d0
	clrw d0
	orl d0,d1
	clrl d0
	moveb a3@(52),d0
	lsll #8,d0
	orl d0,d1
	orb a3@(53),d1
	moveb a3@(54),d2
	moveq #24,d0
	lsll d0,d2
	clrl d0
	moveb a3@(55),d0
	swap d0
	clrw d0
	orl d0,d2
	clrl d0
	moveb a3@(56),d0
	lsll #8,d0
	orl d0,d2
	orb a3@(57),d2
	tstl d3
	jne L356
	tstl d1
	jne L356
	tstl d2
	jne L356
	fmoved #0r0.000000000000005,fp3
	jra L357
	.even
L356:
	cmpl #32767,d3
	jne L358
	fmoved #0rinf,fp3
	jra L357
	.even
L358:
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
L357:
	fmoved #0r1.000000000000005,fp0
	fcmpx fp0,fp3
	fjlt L361
	fdmovex fp3,fp0
	fcmpd #0r1000000.000000005,fp0
	fjngt L361
	fmoved #0r1000000.000000005,fp0
L361:
	fmoved fp0,a3@(24)
	moveml a5@(-40),#0xc0c
	fmovem a5@(-24),#0x30
	unlk a5
	rts
LC1:
	.ascii "\12AIFF::read() - opening file %s\12\0"
LC2:
	.ascii "FORM\0"
LC3:
	.ascii "AIFF\0"
LC4:
	.ascii "AIFF::read() - couldn't read FORM header\0"
LC5:
	.ascii "AIFF::read() - couldn't read chunk header\0"
LC6:
	.ascii "COMM\0"
LC7:
	.ascii "(found chunk '%s', skipping)\12\0"
LC8:
	.ascii "AIFF::read() - couldn't read chunk length\0"
LC9:
	.ascii "AIFF::read() - couldn't read COMM chunk\0"
LC10:
	.ascii "SSND\0"
LC11:
	.ascii "AIFF::read() - couldn't read SSND chunk\0"
LC12:
	.ascii "AIFF::read() - Non zero SSND blocksize unsupported\0"
LC13:
	.ascii "AIFF::read() - failed to allocate %lu bytes\12\0"
LC14:
	.ascii "AIFF::read() - allocated %lu bytes for 32-bit data\12\0"
LC15:
	.ascii "AIFF::read() - unsupported sample size %hd\12\0"
	.even
.globl _read__4AIFFPCc
_read__4AIFFPCc:
	link a5,#-32
	moveml #0x383a,sp@-
	movel a5@(8),a3
	movel a5@(12),d3
	movel a3@(8),d0
	jne L367
	movel #-50659328,d0
	jra L430
	.even
L367:
	pea 16384:w
	subql #2,sp
	moveb #0,sp@(1)
	subql #2,sp
	movel d3,sp@-
	movel d0,sp@-
	jbsr _open__8StreamInPCcbUl
	movel d0,d2
	addw #16,sp
	jne L430
	movel d3,sp@-
	pea LC1
	lea _printf,a2
	jbsr a2@
	clrl a5@(-16)
	clrl d2
	clrb a5@(-8)
	clrb a5@(-7)
	clrb a5@(-6)
	clrb a5@(-5)
	clrb a5@(-4)
	clrb a5@(-3)
	clrb a5@(-2)
	clrb a5@(-1)
	addqw #4,sp
	movel #4,sp@
	pea a5@(-8)
	movel a3@(8),sp@-
	jbsr _readBytes__8StreamInPvUl
	addw #12,sp
	movel a2,a6
	movel a5,d3
	subql #8,d3
	moveq #4,d1
	cmpl d0,d1
	jne L370
	pea 4:w
	pea LC2
	movel d3,sp@-
	lea _strncmp,a2
	jbsr a2@
	addw #12,sp
	tstl d0
	jne L370
	pea 4:w
	pea a5@(-12)
	movel a3@(8),sp@-
	jbsr _readBytes__8StreamInPvUl
	addw #12,sp
	tstl d0
	jle L372
	asrl #2,d0
L372:
	moveq #1,d1
	cmpl d0,d1
	jne L370
	pea 4:w
	movel d3,sp@-
	movel a3@(8),sp@-
	jbsr _readBytes__8StreamInPvUl
	addw #12,sp
	moveq #4,d1
	cmpl d0,d1
	jne L370
	pea 4:w
	pea LC3
	movel d3,sp@-
	jbsr a2@
	addw #12,sp
	tstl d0
	jeq L369
L370:
	pea LC4
	jra L435
	.even
L369:
	pea 4:w
	movel d3,sp@-
	movel a3@(8),sp@-
	jbsr _readBytes__8StreamInPvUl
	addw #12,sp
	moveq #4,d1
	cmpl d0,d1
	jeq L375
	pea LC5
L435:
	jbsr _puts
	movel a3@(8),sp@-
	jbsr _close__8StreamIn
	movel #-50593803,d0
	jra L430
	.even
L375:
	lea _close__8StreamIn,a4
	jra L377
	.even
L379:
	movel d3,sp@-
	pea LC7
	jbsr a6@
	addqw #4,sp
	movel #4,sp@
	pea a5@(-16)
	movel a3@(8),sp@-
	jbsr _readBytes__8StreamInPvUl
	addw #12,sp
	movel d0,d1
	jle L382
	asrl #2,d1
L382:
	moveq #1,d0
	cmpl d1,d0
	jne L431
	clrl sp@-
	movel a5@(-16),sp@-
	movel a3@(8),sp@-
	jbsr _seek__8StreamInlQ23IOS8SeekMode
	addqw #8,sp
	movel #4,sp@
	movel d3,sp@-
	movel a3@(8),sp@-
	jbsr _readBytes__8StreamInPvUl
	addw #12,sp
	moveq #4,d1
	cmpl d0,d1
	jne L434
L377:
	pea 4:w
	pea LC6
	movel d3,sp@-
	jbsr a2@
	addw #12,sp
	tstl d0
	jeq L378
	addql #1,d2
	moveq #15,d0
	cmpl d2,d0
	jcc L379
L378:
	pea 4:w
	pea LC6
	movel d3,sp@-
	jbsr a2@
	addw #12,sp
	tstl d0
	jne L388
	moveq #-20,d2
	addl a5,d2
	pea 4:w
	movel d2,sp@-
	movel a3@(8),sp@-
	jbsr _readBytes__8StreamInPvUl
	addw #12,sp
	movel d2,d4
	tstl d0
	jle L389
	asrl #2,d0
L389:
	moveq #1,d1
	cmpl d0,d1
	jne L388
	moveq #18,d0
	cmpl a5@(-20),d0
	jne L388
	pea 2:w
	pea a5@(-22)
	movel a3@(8),sp@-
	jbsr _readBytes__8StreamInPvUl
	addw #12,sp
	tstl d0
	jle L391
	asrl #1,d0
L391:
	moveq #1,d1
	cmpl d0,d1
	jne L388
	pea 4:w
	pea a5@(-26)
	movel a3@(8),sp@-
	jbsr _readBytes__8StreamInPvUl
	addw #12,sp
	tstl d0
	jle L393
	asrl #2,d0
L393:
	moveq #1,d1
	cmpl d0,d1
	jne L388
	pea 2:w
	pea a5@(-28)
	movel a3@(8),sp@-
	jbsr _readBytes__8StreamInPvUl
	addw #12,sp
	tstl d0
	jle L395
	asrl #1,d0
L395:
	moveq #1,d1
	cmpl d0,d1
	jne L388
	pea 10:w
	pea a3@(48)
	movel a3@(8),sp@-
	jbsr _readBytes__8StreamInPvUl
	addw #12,sp
	moveq #10,d1
	cmpl d0,d1
	jeq L387
L388:
	pea LC9
	jra L436
	.even
L387:
	pea 4:w
	movel d3,sp@-
	movel a3@(8),sp@-
	jbsr _readBytes__8StreamInPvUl
	addw #12,sp
	moveq #4,d1
	cmpl d0,d1
	jne L434
	clrl d2
	jra L400
	.even
L402:
	movel d3,sp@-
	pea LC7
	jbsr a6@
	addqw #4,sp
	movel #4,sp@
	pea a5@(-16)
	movel a3@(8),sp@-
	jbsr _readBytes__8StreamInPvUl
	addw #12,sp
	movel d0,d1
	jle L405
	asrl #2,d1
L405:
	moveq #1,d0
	cmpl d1,d0
	jne L433
	clrl sp@-
	movel a5@(-16),sp@-
	movel a3@(8),sp@-
	jbsr _seek__8StreamInlQ23IOS8SeekMode
	addqw #8,sp
	movel #4,sp@
	movel d3,sp@-
	movel a3@(8),sp@-
	jbsr _readBytes__8StreamInPvUl
	addw #12,sp
	moveq #4,d1
	cmpl d0,d1
	jne L434
L400:
	pea 4:w
	pea LC10
	movel d3,sp@-
	jbsr a2@
	addw #12,sp
	tstl d0
	jeq L401
	addql #1,d2
	moveq #15,d0
	cmpl d2,d0
	jcc L402
L401:
	pea 4:w
	pea LC10
	movel d3,sp@-
	jbsr a2@
	addw #12,sp
	tstl d0
	jne L411
	pea 4:w
	movel d4,sp@-
	movel a3@(8),sp@-
	jbsr _readBytes__8StreamInPvUl
	addw #12,sp
	tstl d0
	jle L412
	asrl #2,d0
L412:
	moveq #1,d1
	cmpl d0,d1
	jne L411
	pea 4:w
	pea a5@(-16)
	movel a3@(8),sp@-
	jbsr _readBytes__8StreamInPvUl
	addw #12,sp
	tstl d0
	jle L414
	asrl #2,d0
L414:
	moveq #1,d1
	cmpl d0,d1
	jne L411
	pea 4:w
	pea a5@(-32)
	movel a3@(8),sp@-
	jbsr _readBytes__8StreamInPvUl
	addw #12,sp
	tstl d0
	jle L416
	asrl #2,d0
L416:
	moveq #1,d1
	cmpl d0,d1
	jeq L410
L411:
	pea LC11
	jra L436
	.even
L410:
	tstl a5@(-32)
	jeq L418
	pea LC12
	jra L436
	.even
L418:
	movel a5@(-16),d0
	jeq L419
	clrl sp@-
	movel d0,sp@-
	movel a3@(8),sp@-
	jbsr _seek__8StreamInlQ23IOS8SeekMode
	addw #12,sp
L419:
	movel a3@(8),sp@-
	jbsr _tell__8StreamIn
	movel d0,a3@(36)
	movel a5@(-26),a3@(40)
	movew a5@(-22),a3@(46)
	movew a5@(-28),a3@(44)
	clrl d0
	movew a5@(-22),d0
	mulsl a5@(-26),d0
	lsll #2,d0
	movel d0,d2
	addl #4096,d2
	addql #4,sp
	movel a3@(32),d0
	jeq L420
	movel d0,sp@-
	jbsr _free__3MemPv
	addql #4,sp
L420:
	pea 16:w
	subql #2,sp
	moveb #0,sp@(1)
	subql #2,sp
	movel d2,sp@-
	jbsr _alloc__3MemUlbQ23Mem9AlignType
	movel d0,a3@(32)
	addw #12,sp
	jne L421
	movel d2,sp@-
	pea LC13
	jbsr a6@
	movel a3@(8),sp@-
	jbsr a4@
	movel #-50528257,d0
	jra L430
	.even
L421:
	movel d2,sp@-
	pea LC14
	jbsr a6@
	movel a3,sp@-
	jbsr _decodeIEEEExt__4AIFF
	movew a5@(-28),d0
	addw #12,sp
	bfextu d0{#16:#13},d1
	bftst d0{#29:#3}
	jeq L422
	addql #1,d1
L422:
	moveq #2,d0
	cmpl d1,d0
	jeq L425
	jcs L429
	moveq #1,d0
	cmpl d1,d0
	jeq L424
	jra L427
	.even
L429:
	moveq #3,d0
	cmpl d1,d0
	jeq L426
	jra L427
	.even
L424:
	movel a3,sp@-
	jbsr _read8__4AIFF
	jra L437
	.even
L425:
	movel a3,sp@-
	jbsr _read16__4AIFF
	jra L437
	.even
L426:
	movel a3,sp@-
	jbsr _read24__4AIFF
L437:
	movel d0,d2
	addql #4,sp
	jra L423
	.even
L431:
	pea LC8
	jra L436
	.even
L433:
	pea LC8
	jra L436
	.even
L434:
	pea LC5
L436:
	jbsr _puts
	movel a3@(8),sp@-
	jbsr a4@
	movel #-50593803,d0
	jra L430
	.even
L427:
	clrl d0
	movew a3@(44),d0
	movel d0,sp@-
	pea LC15
	jbsr a6@
	movel #-50593796,d2
	addql #8,sp
L423:
	movel a3@(8),sp@-
	jbsr a4@
	movel d2,d0
L430:
	moveml a5@(-60),#0x5c1c
	unlk a5
	rts
LC16:
	.ascii "AIFF::read8() - \0"
LC17:
	.ascii "unexpected EOF\0"
LC18:
	.ascii "OK, load and conversion took %.2f ms\12\0"
	.even
.globl _read8__4AIFF
_read8__4AIFF:
	pea a5@
	movel sp,a5
	moveml #0x383a,sp@-
	movel a5@(8),a4
	movel a4@(32),a3
	clrl d2
	movew a4@(46),d2
	mulsl a4@(40),d2
	clrl d4
	pea LC16
	lea _printf,a2
	jbsr a2@
	movel ___sF,a0
	movel a0@(4),sp@-
	jbsr _fflush
	addqw #4,sp
	movel a4,sp@
	jbsr _ReadEClock
	addql #4,sp
	subql #1,d2
	movel a2,a6
	moveq #-1,d0
	cmpl d2,d0
	jeq L441
	clrl d3
	.even
L442:
	movel a4@(8),a2
	tstl a2@(26)
	jne L443
	movel a2,sp@-
	jbsr _processIO__8StreamIn
	addql #4,sp
	tstl d0
	jne L444
L443:
	subql #1,a2@(26)
	movel a2@(38),a0
	lea a0@(1),a1
	movel a1,a2@(38)
	moveb a0@,d3
	movel d3,d0
L444:
	moveq #-1,d1
	cmpl d0,d1
	jeq L446
	clrl a3@
	moveb d0,a3@
	movel a3@+,d0
	jge L447
	negl d0
L447:
	cmpl d4,d0
	jle L440
	movel d0,d4
	jra L440
	.even
L446:
	pea LC17
	jbsr _puts
	movel #-50593796,d0
	jra L451
	.even
L440:
	dbra d2,L442
	clrw d2
	subql #1,d2
	jcc L442
L441:
	fmoved #0r2147483648.000005,fp0
	fddivl d4,fp0
	fmoved fp0,a4@(16)
	movel a4,sp@-
	jbsr _elapsedFrac__10MilliClock
	movel d1,sp@-
	movel d0,sp@-
	pea LC18
	jbsr a6@
	clrl d0
L451:
	moveml a5@(-28),#0x5c1c
	unlk a5
	rts
LC19:
	.ascii "AIFF::read16() - \0"
	.even
.globl _read16__4AIFF
_read16__4AIFF:
	pea a5@
	movel sp,a5
	moveml #0x3c3a,sp@-
	movel a5@(8),a4
	movel a4@(32),d3
	clrl d2
	movew a4@(46),d2
	mulsl a4@(40),d2
	clrl d5
	pea LC19
	lea _printf,a2
	jbsr a2@
	movel ___sF,a0
	movel a0@(4),sp@-
	jbsr _fflush
	addqw #4,sp
	movel a4,sp@
	jbsr _ReadEClock
	addql #4,sp
	subql #1,d2
	movel a2,a6
	moveq #-1,d0
	cmpl d2,d0
	jeq L455
	clrl d4
	movel d3,a3
	.even
L456:
	movel a4@(8),a2
	tstl a2@(26)
	jne L457
	movel a2,sp@-
	jbsr _processIO__8StreamIn
	addql #4,sp
	tstl d0
	jeq L457
	movel d0,d3
	jra L458
	.even
L457:
	subql #1,a2@(26)
	movel a2@(38),a0
	lea a0@(1),a1
	movel a1,a2@(38)
	moveb a0@,d4
	movel d4,d3
L458:
	movel a4@(8),a2
	tstl a2@(26)
	jne L460
	movel a2,sp@-
	jbsr _processIO__8StreamIn
	addql #4,sp
	tstl d0
	jne L461
L460:
	subql #1,a2@(26)
	movel a2@(38),a0
	lea a0@(1),a1
	movel a1,a2@(38)
	clrl d0
	moveb a0@,d0
L461:
	moveq #-1,d1
	cmpl d0,d1
	jeq L463
	clrl a3@
	moveb d3,a3@
	moveb d0,a3@(1)
	movel a3@+,d0
	jge L464
	negl d0
L464:
	cmpl d5,d0
	jle L454
	movel d0,d5
	jra L454
	.even
L463:
	pea LC17
	jbsr _puts
	movel #-50593796,d0
	jra L468
	.even
L454:
	dbra d2,L456
	clrw d2
	subql #1,d2
	jcc L456
L455:
	fmoved #0r2147483648.000005,fp0
	fddivl d5,fp0
	fmoved fp0,a4@(16)
	movel a4,sp@-
	jbsr _elapsedFrac__10MilliClock
	movel d1,sp@-
	movel d0,sp@-
	pea LC18
	jbsr a6@
	clrl d0
L468:
	moveml a5@(-32),#0x5c3c
	unlk a5
	rts
LC20:
	.ascii "AIFF::read24() - \0"
	.even
.globl _read24__4AIFF
_read24__4AIFF:
	pea a5@
	movel sp,a5
	moveml #0x3f3a,sp@-
	movel a5@(8),a4
	movel a4@(32),d2
	clrl d3
	movew a4@(46),d3
	mulsl a4@(40),d3
	clrl d7
	pea LC20
	lea _printf,a2
	jbsr a2@
	movel ___sF,a0
	movel a0@(4),sp@-
	jbsr _fflush
	addqw #4,sp
	movel a4,sp@
	jbsr _ReadEClock
	addql #4,sp
	subql #1,d3
	movel a2,a6
	moveq #-1,d0
	cmpl d3,d0
	jeq L472
	clrl d6
	clrl d5
	movel d2,a3
	.even
L473:
	movel a4@(8),a2
	tstl a2@(26)
	jne L474
	movel a2,sp@-
	jbsr _processIO__8StreamIn
	addql #4,sp
	tstl d0
	jeq L474
	movel d0,d4
	jra L475
	.even
L474:
	subql #1,a2@(26)
	movel a2@(38),a0
	lea a0@(1),a1
	movel a1,a2@(38)
	moveb a0@,d6
	movel d6,d4
L475:
	movel a4@(8),a2
	tstl a2@(26)
	jne L477
	movel a2,sp@-
	jbsr _processIO__8StreamIn
	addql #4,sp
	tstl d0
	jeq L477
	movel d0,d2
	jra L478
	.even
L477:
	subql #1,a2@(26)
	movel a2@(38),a0
	lea a0@(1),a1
	movel a1,a2@(38)
	moveb a0@,d5
	movel d5,d2
L478:
	movel a4@(8),a2
	tstl a2@(26)
	jne L480
	movel a2,sp@-
	jbsr _processIO__8StreamIn
	addql #4,sp
	tstl d0
	jne L481
L480:
	subql #1,a2@(26)
	movel a2@(38),a0
	lea a0@(1),a1
	movel a1,a2@(38)
	clrl d0
	moveb a0@,d0
L481:
	moveq #-1,d1
	cmpl d0,d1
	jeq L483
	clrl a3@
	moveb d4,a3@
	moveb d2,a3@(1)
	moveb d0,a3@(2)
	movel a3@+,d0
	jge L484
	negl d0
L484:
	cmpl d7,d0
	jle L471
	movel d0,d7
	jra L471
	.even
L483:
	pea LC17
	jbsr _puts
	movel #-50593796,d0
	jra L488
	.even
L471:
	dbra d3,L473
	clrw d3
	subql #1,d3
	jcc L473
L472:
	fmoved #0r2147483648.000005,fp0
	fddivl d7,fp0
	fmoved fp0,a4@(16)
	movel a4,sp@-
	jbsr _elapsedFrac__10MilliClock
	movel d1,sp@-
	movel d0,sp@-
	pea LC18
	jbsr a6@
	clrl d0
L488:
	moveml a5@(-40),#0x5cfc
	unlk a5
	rts
LC21:
	.ascii "AIFF::write() '%s' - \0"
LC22:
	.ascii "failed to open output file\0"
LC23:
	.ascii "failed to write FORM chunk\0"
LC24:
	.ascii "failed to write COMM chunk\0"
LC25:
	.ascii "OK, took %.2f ms\12\0"
	.even
.globl _write__4AIFFPCc
_write__4AIFFPCc:
	link a5,#-16
	fmovem #0x4,sp@-
	moveml #0x3c3a,sp@-
	movel a5@(8),d3
	movel a5@(12),d2
	movel d3,a0
	tstl a0@(32)
	jeq L491
	tstl a0@(12)
	jeq L491
	tstl d2
	jne L490
L491:
	movel #-50659328,d0
	jra L524
	.even
L490:
	movel d2,sp@-
	pea LC21
	lea _printf,a2
	jbsr a2@
	movel ___sF,a0
	movel a0@(4),sp@-
	jbsr _fflush
	pea 16384:w
	subql #2,sp
	moveb #0,sp@(1)
	subql #2,sp
	subql #2,sp
	moveb #0,sp@(1)
	subql #2,sp
	movel d2,sp@-
	movel d3,a1
	movel a1@(12),sp@-
	jbsr _open__9StreamOutPCcbT2Ul
	movel d0,d2
	addw #32,sp
	movel a2,d5
	tstl d2
	jeq L492
	pea LC22
	jbsr _puts
	movel d2,d0
	jra L524
	.even
L492:
	clrl a5@(-14)
	clrl a5@(-10)
	movel d3,a0
	clrl d2
	movew a0@(46),d2
	mulsl a0@(40),d2
	addl d2,d2
	moveq #46,d0
	addl d2,d0
	movel d0,a5@(-4)
	pea 4:w
	pea LC2
	movel a0@(12),sp@-
	lea _writeBytes__9StreamOutPCvUl,a2
	jbsr a2@
	addw #12,sp
	moveq #4,d1
	cmpl d0,d1
	jne L494
	movel a5,d4
	subql #4,d4
	pea 4:w
	movel d4,sp@-
	movel d3,a0
	movel a0@(12),sp@-
	jbsr _writeBytes__9StreamOutPCvUl
	addw #12,sp
	tstl d0
	jle L495
	asrl #2,d0
L495:
	moveq #1,d1
	cmpl d0,d1
	jne L494
	pea 4:w
	pea LC3
	movel d3,a0
	movel a0@(12),sp@-
	jbsr a2@
	addw #12,sp
	moveq #4,d1
	cmpl d0,d1
	jeq L493
L494:
	pea LC23
	jra L525
	.even
L493:
	moveq #18,d0
	movel d0,a5@(-4)
	movew #16,a5@(-6)
	pea 4:w
	pea LC6
	movel d3,a0
	movel a0@(12),sp@-
	jbsr a2@
	addw #12,sp
	moveq #4,d1
	cmpl d0,d1
	jne L508
	pea 4:w
	movel d4,sp@-
	movel d3,a0
	movel a0@(12),sp@-
	jbsr _writeBytes__9StreamOutPCvUl
	addw #12,sp
	tstl d0
	jle L499
	asrl #2,d0
L499:
	moveq #1,d1
	cmpl d0,d1
	jne L508
	movel d3,a0
	lea a0@(46),a4
	pea 2:w
	movel a4,sp@-
	movel a0@(12),sp@-
	jbsr _writeBytes__9StreamOutPCvUl
	addw #12,sp
	tstl d0
	jle L501
	asrl #1,d0
L501:
	moveq #1,d1
	cmpl d0,d1
	jne L508
	movel d3,a0
	lea a0@(40),a3
	pea 4:w
	movel a3,sp@-
	movel a0@(12),sp@-
	jbsr _writeBytes__9StreamOutPCvUl
	addw #12,sp
	tstl d0
	jle L503
	asrl #2,d0
L503:
	moveq #1,d1
	cmpl d0,d1
	jne L508
	pea 2:w
	pea a5@(-6)
	movel d3,a0
	movel a0@(12),sp@-
	jbsr _writeBytes__9StreamOutPCvUl
	addw #12,sp
	tstl d0
	jle L505
	asrl #1,d0
L505:
	moveq #1,d1
	cmpl d0,d1
	jne L508
	pea 10:w
	movel d3,a0
	pea a0@(48)
	movel a0@(12),sp@-
	jbsr a2@
	addw #12,sp
	moveq #10,d1
	cmpl d0,d1
	jne L508
	addql #8,d2
	movel d2,a5@(-4)
	pea 4:w
	pea LC10
	movel d3,a1
	movel a1@(12),sp@-
	jbsr a2@
	addw #12,sp
	moveq #4,d1
	cmpl d0,d1
	jne L508
	pea 4:w
	movel d4,sp@-
	movel d3,a0
	movel a0@(12),sp@-
	jbsr _writeBytes__9StreamOutPCvUl
	addw #12,sp
	tstl d0
	jle L509
	asrl #2,d0
L509:
	moveq #1,d1
	cmpl d0,d1
	jne L508
	pea 8:w
	pea a5@(-14)
	movel d3,a0
	movel a0@(12),sp@-
	jbsr _writeBytes__9StreamOutPCvUl
	addw #12,sp
	tstl d0
	jle L511
	asrl #2,d0
L511:
	moveq #2,d1
	cmpl d0,d1
	jeq L507
L508:
	pea LC24
L525:
	jbsr _puts
	movel d3,a0
	movel a0@(12),sp@-
	jbsr _close__9StreamOut
	movel #-50593797,d0
	jra L524
	.even
L507:
	movel d3,sp@-
	jbsr _ReadEClock
	addql #4,sp
	clrl d2
	movew a4@,d2
	mulsl a3@,d2
	movel d3,a1
	movel a1@(32),d0
	subql #1,d2
	moveq #-1,d1
	cmpl d2,d1
	jeq L515
	movel d0,a6
	.even
L516:
	movel d3,a0
	movel a0@(12),a3
	moveb a6@,d4
	tstl a3@(26)
	jne L517
	lea a3@(2),a4
	movel a4,sp@-
	jbsr _waitPacket__17AsyncStreamBuffer
	addql #4,sp
	tstl d0
	jge L518
	moveq #-9,d0
	andl d0,a3@(14)
	jra L519
	.even
L518:
	movel a3@(18),d0
	lea a3@(30),a2
	movel a2@(d0:l:4),sp@-
	movel a4,sp@-
	jbsr _sendPacket__17AsyncStreamBufferPv
	movel a3@(18),d0
	eorw #1,d0
	movel d0,a3@(18)
	movel a2@(d0:l:4),a3@(38)
	movel a4@,a3@(26)
	addql #8,sp
L517:
	subql #1,a3@(26)
	movel a3@(38),a0
	lea a0@(1),a1
	movel a1,a3@(38)
	moveb d4,a0@
L519:
	movel d3,a0
	movel a0@(12),a3
	moveb a6@(1),d4
	tstl a3@(26)
	jne L520
	lea a3@(2),a4
	movel a4,sp@-
	jbsr _waitPacket__17AsyncStreamBuffer
	addql #4,sp
	tstl d0
	jge L521
	moveq #-9,d0
	andl d0,a3@(14)
	jra L522
	.even
L521:
	movel a3@(18),d0
	lea a3@(30),a2
	movel a2@(d0:l:4),sp@-
	movel a4,sp@-
	jbsr _sendPacket__17AsyncStreamBufferPv
	movel a3@(18),d0
	eorw #1,d0
	movel d0,a3@(18)
	movel a2@(d0:l:4),a3@(38)
	movel a4@,a3@(26)
	addql #8,sp
L520:
	subql #1,a3@(26)
	movel a3@(38),a0
	lea a0@(1),a1
	movel a1,a3@(38)
	moveb d4,a0@
L522:
	addql #4,a6
	dbra d2,L516
	clrw d2
	subql #1,d2
	jcc L516
L515:
	movel d3,sp@-
	jbsr _elapsedFrac__10MilliClock
	movel d1,sp@-
	movel d0,sp@-
	fdmoved sp@+,fp2
	movel d3,a0
	movel a0@(12),sp@-
	jbsr _close__9StreamOut
	fmoved fp2,sp@-
	pea LC25
	movel d5,a1
	jbsr a1@
	clrl d0
L524:
	moveml a5@(-60),#0x5c3c
	fmovem a5@(-28),#0x20
	unlk a5
	rts
LC26:
	.ascii "AIFF::normalize() - \0"
LC27:
	.ascii "[%.2f%%] OK, took %.2f ms\12\0"
LC28:
	.ascii "skipped\0"
LC29:
	.ascii "failed\0"
	.even
.globl _normalize__4AIFF
_normalize__4AIFF:
	pea a5@
	movel sp,a5
	moveml #0x2030,sp@-
	movel a5@(8),a3
	pea LC26
	lea _printf,a2
	jbsr a2@
	movel ___sF,a0
	movel a0@(4),sp@-
	jbsr _fflush
	addql #8,sp
	tstl a3@(32)
	jeq L527
	fdmoved a3@(16),fp0
	fcmpd #0r1.050000000000005,fp0
	fjngt L528
	movel a3,sp@-
	jbsr _ReadEClock
	addql #4,sp
	fdmoved a3@(16),fp1
	movel a3@(32),a0
	clrl d0
	movew a3@(46),d0
	mulsl a3@(40),d0
	subql #1,d0
	moveq #-1,d1
	cmpl d0,d1
	jeq L531
	.even
L532:
	fdmovex fp1,fp0
	fdmull a0@,fp0
	fmoveml fpcr,d2
	moveq #16,d1
	orl d2,d1
	andw #-33,d1
	fmoveml d1,fpcr
	fmovel fp0,a0@+
	fmoveml d2,fpcr
	dbra d0,L532
	clrw d0
	subql #1,d0
	jcc L532
L531:
	movel a3,sp@-
	jbsr _elapsedFrac__10MilliClock
	movel d1,sp@-
	movel d0,sp@-
	fdmoved a3@(16),fp0
	fdmuld #0r100.0000000000005,fp0
	fmoved fp0,sp@-
	pea LC27
	jbsr a2@
	jra L535
	.even
L528:
	pea LC28
	jbsr _puts
	jra L535
	.even
L527:
	pea LC29
	jbsr _puts
L535:
	moveml a5@(-12),#0xc04
	unlk a5
	rts
