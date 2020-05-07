#NO_APP
.globl __9CompBasic$cnt
.data
	.even
__9CompBasic$cnt:
	.long 0
.globl __9CompBasic$decode
	.even
__9CompBasic$decode:
	.long 0
.globl __9CompBasic$encode
	.even
__9CompBasic$encode:
	.long 0
	.even
_ex.30:
	.word 0
	.word 8
	.word 16
	.word 24
	.word 32
	.word 48
	.word 64
	.word 128
	.word 256
	.word 512
	.word 1024
	.word 2048
	.word 4096
	.word 8192
	.word 16384
	.word 32768
	.even
_ls.31:
	.word 1
	.word 1
	.word 1
	.word 1
	.word 2
	.word 2
	.word 8
	.word 16
	.word 32
	.word 64
	.word 128
	.word 256
	.word 512
	.word 1024
	.word 2048
	.word 4096
.text
	.even
.globl _createTables__9CompBasic
_createTables__9CompBasic:
	pea a5@
	movel sp,a5
	moveml #0x3820,sp@-
	tstl __9CompBasic$decode
	jne L31
	pea 16:w
	subql #2,sp
	moveb #0,sp@(1)
	subql #2,sp
	pea 1024:w
	jbsr _alloc__3MemUlbQ23Mem9AlignType
	movel d0,__9CompBasic$decode
	addw #12,sp
	jne L32
	clrb d0
	jra L51
	.even
L32:
	movel d0,a0
	lea _ls.31,a2
	clrl d1
	lea _ex.30,a1
	clrl d2
	moveq #15,d3
	.even
L36:
	movew a2@(d2:l),d1
	clrl d0
	movew a1@(d2:l),d0
	movel d0,a0@+
	movel d0,d4
	negl d4
	movel d4,a0@+
	addl d1,d0
	movel d0,a0@+
	movel d0,d4
	negl d4
	movel d4,a0@+
	addl d1,d0
	movel d0,a0@+
	movel d0,d4
	negl d4
	movel d4,a0@+
	addl d1,d0
	movel d0,a0@+
	movel d0,d4
	negl d4
	movel d4,a0@+
	addl d1,d0
	movel d0,a0@+
	movel d0,d4
	negl d4
	movel d4,a0@+
	addl d1,d0
	movel d0,a0@+
	movel d0,d4
	negl d4
	movel d4,a0@+
	addl d1,d0
	movel d0,a0@+
	movel d0,d4
	negl d4
	movel d4,a0@+
	addl d1,d0
	movel d0,a0@+
	negl d0
	movel d0,a0@+
	addql #2,d2
	dbra d3,L36
	clrw d3
	subql #1,d3
	jcc L36
L31:
	tstl __9CompBasic$encode
	jne L38
	pea 16:w
	subql #2,sp
	moveb #0,sp@(1)
	subql #2,sp
	movel #65536,sp@-
	jbsr _alloc__3MemUlbQ23Mem9AlignType
	movel d0,__9CompBasic$encode
	addw #12,sp
	jne L39
	movel __9CompBasic$decode,sp@-
	jbsr _free__3MemPv
	clrl __9CompBasic$decode
	clrb d0
	jra L51
	.even
L39:
	clrl d2
	movel d0,a1
	clrl d1
	.even
L43:
	movel __9CompBasic$decode,a0
	movel a0@(d2:l:4),d0
	addl a0@(8,d2:l:4),d0
	asrl #1,d0
	cmpl d1,d0
	jge L44
	addql #2,d2
L44:
	moveb d2,a1@+
	addql #1,d1
	cmpl #61439,d1
	jle L43
	movel #4095,d0
	.even
L49:
	moveb d2,a1@+
	dbra d0,L49
	clrw d0
	subql #1,d0
	jcc L49
L38:
	moveq #1,d0
L51:
	moveml a5@(-16),#0x41c
	unlk a5
	rts
	.even
.globl ___9CompBasic
___9CompBasic:
	link a5,#-56
	fmovem #0xfc,sp@-
	moveml #0x3f3a,sp@-
	jbsr ___get_eh_context
	movel d0,a5@(-52)
	movel a5@(8),a0
	movel #___vt_9Compander,a0@
	movel a5@(-52),a0
	addql #4,a0
	movel a0@,a5@(-24)
	clrl a5@(-20)
	movel a5,a5@(-16)
	movel #L58,a5@(-12)
	movel sp,a5@(-8)
	jra L57
	.even
L58:
	jra L72
	.even
L57:
	lea a5@(-24),a1
	movel a1,a0@
	movel a5@(8),a0
	movel #___vt_9CompBasic,a0@
	tstl __9CompBasic$cnt
	jne L59
	movel a5@(-52),a1
	addql #4,a1
	movel a1,a5@(-56)
	jbsr _createTables__9CompBasic
	tstb d0
	jne L59
	movel a5@(-56),a1
	jra L73
	.even
L59:
	addql #1,__9CompBasic$cnt
	movel a5@(-52),a1
	addql #4,a1
L73:
	movel a1@,a0
	movel a0@,a1@
	movel a5@(8),d0
	jra L71
	.even
L72:
L55:
	movel a5@(-56),a0
	movel a0@,a5@(-48)
	clrl a5@(-44)
	movel a5,a5@(-40)
	movel #L65,a5@(-36)
	movel sp,a5@(-32)
	jra L64
	.even
L65:
	jra L74
	.even
L64:
	lea a5@(-48),a0
	movel a5@(-56),a1
	movel a0,a1@
	movel a5@(8),a1
	movel #___vt_9Compander,a1@
	movel a5@(-56),a1
	movel a1@,a0
	movel a0@,a1@
	jbsr ___sjthrow
	.even
L74:
L62:
	jbsr ___terminate
	.even
L71:
	moveml a5@(-168),#0x5cfc
	fmovem a5@(-128),#0x3f
	unlk a5
	rts
	.even
.globl __$_9CompBasic
__$_9CompBasic:
	pea a5@
	movel sp,a5
	movel a3,sp@-
	movel a2,sp@-
	movel a5@(8),a3
	movel #___vt_9CompBasic,a3@
	movel __9CompBasic$cnt,d0
	movel d0,d1
	subql #1,d1
	movel d1,__9CompBasic$cnt
	moveq #1,d1
	cmpl d0,d1
	jne L77
	movel __9CompBasic$decode,sp@-
	lea _free__3MemPv,a2
	jbsr a2@
	movel __9CompBasic$encode,sp@-
	jbsr a2@
	clrl __9CompBasic$decode
	clrl __9CompBasic$encode
	addql #8,sp
L77:
	movel #___vt_9Compander,a3@
	movel a5@(12),d0
	btst #0,d0
	jeq L81
	movel a3,sp@-
	jbsr ___builtin_delete
L81:
	movel a5@(-8),a2
	movel a5@(-4),a3
	unlk a5
	rts
LC0:
	.ascii "%6ld,\0"
LC1:
	.ascii "\12\0"
LC2:
	.ascii "%d:%ld, \0"
	.even
.globl _dumpCurve__9CompBasic
_dumpCurve__9CompBasic:
	pea a5@
	movel sp,a5
	moveml #0x2030,sp@-
	clrl d2
	lea _printf,a3
	movel a3,a2
	.even
L86:
	movel __9CompBasic$decode,a0
	movel a0@(d2:l:4),sp@-
	pea LC0
	jbsr a2@
	addql #2,d2
	addql #8,sp
	bftst d2{#28:#4}
	jne L85
	pea LC1
	jbsr a2@
	addql #4,sp
L85:
	cmpl #255,d2
	jle L86
	pea LC1
	jbsr a3@
	lea 0:w,a2
	addql #4,sp
	clrl d2
	.even
L92:
	movel __9CompBasic$encode,a0
	moveb a2@(a0:l),d2
	movel __9CompBasic$decode,a0
	movel a0@(d2:l:4),sp@-
	movel a2,sp@-
	pea LC2
	jbsr a3@
	movel a2,d0
	addql #2,d0
	addw #12,sp
	bftst d0{#29:#3}
	jne L91
	pea LC1
	jbsr a3@
	addql #4,sp
L91:
	addql #1,a2
	cmpw #511,a2
	jle L92
	moveml a5@(-12),#0xc04
	unlk a5
	rts
.globl ___vt_9CompBasic
	.even
___vt_9CompBasic:
	.long 0
	.long 0
	.long _dumpCurve__9CompBasic
	.long __$_9CompBasic
	.skip 4
	.even
___vt_9Compander:
	.long 0
	.long 0
	.long _dumpCurve__9Compander
	.long __$_9Compander
	.skip 4
	.even
_dumpCurve__9Compander:
	pea a5@
	movel sp,a5
	unlk a5
	rts
	.even
__$_9Compander:
	pea a5@
	movel sp,a5
	movel a5@(8),a0
	movel #___vt_9Compander,a0@
	btst #0,a5@(15)
	jeq L29
	movel a0,sp@-
	jbsr ___builtin_delete
L29:
	unlk a5
	rts
