#NO_APP
.text
	.even
.globl ___13DeltaAnalyser
___13DeltaAnalyser:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel a5@(8),a2
	clrl a2@(4)
	clrl a2@(8)
	clrl a2@(12)
	clrl a2@(16)
	clrl a2@(24)
	pea 16:w
	subql #2,sp
	moveb #1,sp@(1)
	subql #2,sp
	movel #262144,sp@-
	jbsr _alloc__3MemUlbQ23Mem9AlignType
	movel d0,a2@
	movel a2,d0
	movel a5@(-4),a2
	unlk a5
	rts
	.even
.globl __$_13DeltaAnalyser
__$_13DeltaAnalyser:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel a5@(8),a2
	movel a2@,d0
	jeq L29
	movel d0,sp@-
	jbsr _free__3MemPv
	addql #4,sp
L29:
	movel a5@(12),d0
	btst #0,d0
	jeq L31
	movel a2,sp@-
	jbsr ___builtin_delete
L31:
	movel a5@(-4),a2
	unlk a5
	rts
	.even
.globl _reset__13DeltaAnalyser
_reset__13DeltaAnalyser:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel a5@(8),a2
	movel #262140,sp@-
	movel a2@,sp@-
	jbsr _zero__3MemPvUl
	clrl a2@(4)
	clrl a2@(8)
	clrl a2@(12)
	clrl a2@(16)
	clrl a2@(20)
	clrl a2@(24)
	movel a5@(-4),a2
	unlk a5
	rts
	.even
.globl _analyse__13DeltaAnalyserPsUlUl
_analyse__13DeltaAnalyserPsUlUl:
	pea a5@
	movel sp,a5
	moveml #0x3820,sp@-
	movel a5@(8),a2
	movel a5@(12),a1
	movel a5@(20),d4
	movel a5@(16),d3
	divul d4,d3
	movel d3,d1
	tstl a1
	jne L34
	tstl d1
	jne L34
	movel #-50397184,d0
	jra L41
	.even
L34:
	tstl a2@
	jne L35
	movel #-50659328,d0
	jra L41
	.even
L35:
	clrl a2@(24)
	addl d3,a2@(4)
	movel a2@(20),d2
	movel d3,d1
	subql #1,d1
	moveq #-1,d0
	cmpl d1,d0
	jeq L37
	movel d4,d3
	addl d3,d3
	.even
L38:
	movew a1@,a0
	addl d3,a1
	movel a0,d0
	subl d2,d0
	movel a0,d2
	tstl d0
	jge L39
	negl d0
L39:
	movel a2@,a0
	addql #1,a0@(d0:l:4)
	dbra d1,L38
	clrw d1
	subql #1,d1
	jcc L38
L37:
	movel d2,a2@(20)
	clrl d0
L41:
	moveml sp@+,#0x41c
	unlk a5
	rts
	.even
.globl _getTotalUniqueDelta__13DeltaAnalyser
_getTotalUniqueDelta__13DeltaAnalyser:
	pea a5@
	movel sp,a5
	movel d2,sp@-
	movel a5@(8),a0
	movel a0@(24),d1
	btst #0,d1
	jeq L43
	movel a0@(8),d0
	jra L50
	.even
L43:
	clrl d0
	movel d1,d2
	movel a0@,a1
	moveq #0,d1
	notw d1
	.even
L47:
	tstl a1@+
	jeq L46
	addql #1,d0
L46:
	dbra d1,L47
	clrw d1
	subql #1,d1
	jcc L47
	moveq #1,d1
	orl d2,d1
	movel d1,a0@(24)
	movel d0,a0@(8)
L50:
	movel sp@+,d2
	unlk a5
	rts
	.even
.globl _getPeak__13DeltaAnalyser
_getPeak__13DeltaAnalyser:
	pea a5@
	movel sp,a5
	movel a5@(8),a1
	btst #1,a1@(27)
	jeq L52
	movel a1@(16),d0
	jra L59
	.even
L60:
	moveq #2,d0
	orl d0,a1@(24)
	movel d1,a1@(16)
	movel d1,d0
	jra L59
	.even
L52:
	moveq #0,d1
	notw d1
	movel a1@,a0
	addl #262140,a0
	.even
L56:
	movel a0@,d0
	subql #4,a0
	dbne d1,L56
	jne L60
	clrw d1
	subql #1,d1
	jpl L56
	clrl a1@(16)
	moveq #2,d0
	orl d0,a1@(24)
	clrl d0
L59:
	unlk a5
	rts
	.even
.globl _getMostFreq__13DeltaAnalyser
_getMostFreq__13DeltaAnalyser:
	pea a5@
	movel sp,a5
	movel d2,sp@-
	movel a5@(8),a1
	movel a1@(24),d0
	btst #2,d0
	jeq L62
	movel a1@(12),d0
	jra L69
	.even
L62:
	movel d0,d2
	movel a1@,a0
	moveq #0,d1
	notw d1
	.even
L66:
	movel a0@+,d0
	dbra d1,L66
	clrw d1
	subql #1,d1
	jcc L66
	moveq #4,d1
	orl d2,d1
	movel d1,a1@(24)
	movel d0,a1@(12)
L69:
	movel sp@+,d2
	unlk a5
	rts
LC0:
	.ascii "Range %5ld - %5ld : %ld [%.2f%%]\12\0"
	.even
.globl _dump__13DeltaAnalyser
_dump__13DeltaAnalyser:
	pea a5@
	movel sp,a5
	fmovem #0x4,sp@-
	moveml #0x2030,sp@-
	movel a5@(8),a0
	fsmovel a0@(4),fp0
	fmoved #0r100.0000000000005,fp1
	fddivx fp0,fp1
	fsmovex fp1,fp2
	movel a0@,a2
	lea 0:w,a0
	lea _printf,a3
	.even
L74:
	clrl d1
	lea a0@(1023),a1
	movel a0,d2
	addl #1024,d2
	movel #1023,d0
	.even
L78:
	addl a2@+,d1
	dbra d0,L78
	clrw d0
	subql #1,d0
	jcc L78
	fsmovex fp2,fp0
	fsmull d1,fp0
	fmoved fp0,sp@-
	movel d1,sp@-
	movel a1,sp@-
	movel a0,sp@-
	pea LC0
	jbsr a3@
	addw #24,sp
	movel d2,a0
	cmpl #65535,a0
	jle L74
	moveml a5@(-24),#0xc04
	fmovem a5@(-12),#0x20
	unlk a5
	rts
