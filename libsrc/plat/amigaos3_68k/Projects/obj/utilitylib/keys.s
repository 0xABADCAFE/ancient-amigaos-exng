#NO_APP
.text
	.even
.globl _getValue__C5Key32PCc
_getValue__C5Key32PCc:
	pea a5@
	movel sp,a5
	movel d2,sp@-
	clrl d0
	movel a5@(12),a0
	tstb a0@
	jeq L57
	clrl d2
	.even
L58:
	movel d0,d1
	addl d1,d1
	tstl d0
	jge L59
	moveq #1,d0
	orl d0,d1
L59:
	moveb a0@+,d2
	movel d2,d0
	eorl d1,d0
	tstb a0@
	jne L58
L57:
	movel sp@+,d2
	unlk a5
	rts
	.even
.globl _getValue__C5Key64PCc
_getValue__C5Key64PCc:
	pea a5@
	movel sp,a5
	movel d3,sp@-
	movel d2,sp@-
	clrl d2
	clrl d3
	movel a5@(12),a0
	tstb a0@
	jeq L64
	.even
L65:
	movel d2,d0
	movel d3,d1
	addl d1,d1
	addxl d0,d0
	addl d2,d2
	clrl d2
	clrl d3
	addxl d3,d3
	orl d0,d2
	orl d1,d3
	moveq #0,d0
	moveq #0,d1
	moveb a0@+,d1
	eorl d0,d2
	eorl d1,d3
	tstb a0@
	jne L65
L64:
	movel d2,d0
	movel d3,d1
	movel sp@+,d2
	movel sp@+,d3
	unlk a5
	rts
