#NO_APP
.globl __10MilliClock$clockFreq
.data
	.even
__10MilliClock$clockFreq:
	.long 0
.text
	.even
.globl _elapsed__C10MilliClock
_elapsed__C10MilliClock:
	link a5,#-8
	movel a2,sp@-
	movel a5@(8),a2
	pea a5@(-8)
	jbsr _ReadEClock
	movel a5@(-8),d0
	cmpl a2@,d0
	jne L93
	movel a5@(-4),a0
	jra L95
	.even
L93:
	movel a5@(-4),a0
	subql #1,a0
L95:
	subl a2@(4),a0
	movel a0,d0
	lsll #5,d0
	subl a0,d0
	lea a0@(d0:l:4),a0
	movel a0,d0
	lsll #3,d0
	divul __10MilliClock$clockFreq,d0
	movel a5@(-12),a2
	unlk a5
	rts
.lcomm _cF.96,8
.lcomm __$tmp_0.97,4
	.even
.globl _elapsedFrac__C10MilliClock
_elapsedFrac__C10MilliClock:
	link a5,#-8
	movel a2,sp@-
	movel a5@(8),a2
	pea a5@(-8)
	jbsr _ReadEClock
	tstl __$tmp_0.97
	jne L97
	movel __10MilliClock$clockFreq,d0
	fdmovel d0,fp0
	tstl d0
	jge L98
	fdaddd #0r4294967296.000005,fp0
L98:
	fmoved #0r1000.000000000005,fp1
	fddivx fp0,fp1
	fmoved fp1,_cF.96
	moveq #1,d0
	movel d0,__$tmp_0.97
L97:
	movel a5@(-8),d0
	cmpl a2@,d0
	jne L99
	movel a5@(-4),d0
	jra L103
	.even
L99:
	movel a5@(-4),d0
	subql #1,d0
L103:
	subl a2@(4),d0
	fdmovel d0,fp0
	tstl d0
	jge L101
	fdaddd #0r4294967296.000005,fp0
L101:
	fdmuld _cF.96,fp0
	fmoved fp0,sp@-
	movel sp@+,d0
	movel sp@+,d1
	movel a5@(-12),a2
	unlk a5
	rts
	.even
.globl _elapsed__C5Clock
_elapsed__C5Clock:
	link a5,#-8
	movel a2,sp@-
	movel a5@(8),a2
	pea a5@(-8)
	jbsr _GetSysTime
	movel a2,sp@-
	pea a5@(-8)
	jbsr _SubTime
	movel a5@(-8),a0
	movel a0,d0
	lsll #5,d0
	subl a0,d0
	lea a0@(d0:l:4),a0
	movel a5@(-4),d0
	movel d0,d1
	mulul #274877907,d0:d1
	lsrl #6,d0
	movel d0,a1
	lea a1@(a0:l:8),a0
	movel a0,a2@(12)
	clrl a2@(8)
	movel a2,d0
	addql #8,d0
	movel a5@(-12),a2
	unlk a5
	rts
