#NO_APP
.text
	.even
.globl _drawTriMesh__10RasterizerUlUlUl
_drawTriMesh__10RasterizerUlUlUl:
	link a5,#-4
	moveml #0x3f3a,sp@-
	movel a5@(16),d6
	movel d6,d0
	subql #1,d0
	movel a5@(20),d5
	subql #1,d5
	mulsl d0,d5
	addl d5,d5
	movel d0,d4
	movel a5@(12),d2
	movel d2,d3
	addl d6,d3
	cmpl #511,d5
	jls L1010
	.even
L1011:
	movel a5@(8),a0
	movel a0@(160),d0
	movel #256,d1
	movel d0,a0
	movel a0,a6
	movel a0,a4
	movel a0,a3
	movel a0,a2
	movel a0,a1
	.even
L1014:
	movew d3,a1@
	addql #1,d3
	movew d2,a2@(2)
	movew d2,a3@(6)
	addql #1,d2
	movew d2,a4@(8)
	movew d3,a6@(4)
	movew d3,a0@(10)
	subql #1,d4
	tstl d4
	jgt L1053
	movel d6,d4
	subql #1,d4
	addql #1,d2
	addql #1,d3
L1053:
	movew d3,a1@(12)
	addql #1,d3
	movew d2,a2@(14)
	movew d2,a3@(18)
	addql #1,d2
	movew d2,a4@(20)
	movew d3,a6@(16)
	movew d3,a0@(22)
	subql #1,d4
	tstl d4
	jgt L1056
	movel d6,d4
	subql #1,d4
	addql #1,d2
	addql #1,d3
L1056:
	movew d3,a1@(24)
	addql #1,d3
	movew d2,a2@(26)
	movew d2,a3@(30)
	addql #1,d2
	movew d2,a4@(32)
	movew d3,a6@(28)
	movew d3,a0@(34)
	subql #1,d4
	tstl d4
	jgt L1059
	movel d6,d4
	subql #1,d4
	addql #1,d2
	addql #1,d3
L1059:
	movew d3,a1@(36)
	addql #1,d3
	movew d2,a2@(38)
	movew d2,a3@(42)
	addql #1,d2
	movew d2,a4@(44)
	movew d3,a6@(40)
	movew d3,a0@(46)
	addw #48,a0
	addw #48,a6
	addw #48,a4
	addw #48,a3
	addw #48,a2
	addw #48,a1
	subql #1,d4
	tstl d4
	jgt L1062
	movel d6,d4
	subql #1,d4
	addql #1,d2
	addql #1,d3
L1062:
	subql #4,d1
	jne L1014
	movel a5@(8),a0
	movel a0@(160),sp@-
	pea 1536:w
	pea 1:w
	clrl sp@-
	movel a0@(4),sp@-
	jbsr _W3D_DrawElements
	addw #20,sp
	tstl d0
	jeq L1017
	clrb d0
	jra L1026
	.even
L1017:
	addl #-512,d5
	cmpl #511,d5
	jhi L1011
L1010:
	tstl d5
	jeq L1019
	movel a5@(8),a0
	movel a0@(160),a1
	movel d5,d1
	lsrl #1,d1
	movel d5,d0
	addl d0,d0
	movel d0,a5@(-4)
	tstl d1
	jeq L1021
	movel a1,a0
	movel d1,d0
	negl d0
	moveq #3,d7
	andl d7,d0
	jeq L1028
	cmpl d0,d7
	jle L1029
	moveq #2,d7
	cmpl d0,d7
	jle L1030
	movew d3,a1@
	addql #1,d3
	movew d2,a1@(2)
	movew d2,a1@(6)
	addql #1,d2
	movew d2,a1@(8)
	movew d3,a1@(4)
	movew d3,a1@(10)
	lea a1@(12),a0
	subql #1,d4
	tstl d4
	jgt L1032
	movel d6,d4
	subql #1,d4
	addql #1,d2
	addql #1,d3
L1032:
	subql #1,d1
L1030:
	movew d3,a0@
	addql #1,d3
	movew d2,a0@(2)
	movew d2,a0@(6)
	addql #1,d2
	movew d2,a0@(8)
	movew d3,a0@(4)
	movew d3,a0@(10)
	addw #12,a0
	subql #1,d4
	tstl d4
	jgt L1035
	movel d6,d4
	subql #1,d4
	addql #1,d2
	addql #1,d3
L1035:
	subql #1,d1
L1029:
	movew d3,a0@
	addql #1,d3
	movew d2,a0@(2)
	movew d2,a0@(6)
	addql #1,d2
	movew d2,a0@(8)
	movew d3,a0@(4)
	movew d3,a0@(10)
	addw #12,a0
	subql #1,d4
	tstl d4
	jgt L1038
	movel d6,d4
	subql #1,d4
	addql #1,d2
	addql #1,d3
L1038:
	subql #1,d1
	jeq L1021
L1028:
	movel a0,a6
	movel a0,a4
	movel a0,a3
	movel a0,a2
	movel a0,a1
	.even
L1022:
	movew d3,a1@
	addql #1,d3
	movew d2,a2@(2)
	movew d2,a3@(6)
	addql #1,d2
	movew d2,a4@(8)
	movew d3,a6@(4)
	movew d3,a0@(10)
	subql #1,d4
	tstl d4
	jgt L1041
	movel d6,d4
	subql #1,d4
	addql #1,d2
	addql #1,d3
L1041:
	movew d3,a1@(12)
	addql #1,d3
	movew d2,a2@(14)
	movew d2,a3@(18)
	addql #1,d2
	movew d2,a4@(20)
	movew d3,a6@(16)
	movew d3,a0@(22)
	subql #1,d4
	tstl d4
	jgt L1044
	movel d6,d4
	subql #1,d4
	addql #1,d2
	addql #1,d3
L1044:
	movew d3,a1@(24)
	addql #1,d3
	movew d2,a2@(26)
	movew d2,a3@(30)
	addql #1,d2
	movew d2,a4@(32)
	movew d3,a6@(28)
	movew d3,a0@(34)
	subql #1,d4
	tstl d4
	jgt L1047
	movel d6,d4
	subql #1,d4
	addql #1,d2
	addql #1,d3
L1047:
	movew d3,a1@(36)
	addql #1,d3
	movew d2,a2@(38)
	movew d2,a3@(42)
	addql #1,d2
	movew d2,a4@(44)
	movew d3,a6@(40)
	movew d3,a0@(46)
	addw #48,a0
	addw #48,a6
	addw #48,a4
	addw #48,a3
	addw #48,a2
	addw #48,a1
	subql #1,d4
	tstl d4
	jgt L1050
	movel d6,d4
	subql #1,d4
	addql #1,d2
	addql #1,d3
L1050:
	subql #4,d1
	jne L1022
L1021:
	movel a5@(8),a0
	movel a0@(160),sp@-
	movel a5@(-4),a0
	pea a0@(d5:l)
	pea 1:w
	clrl sp@-
	movel a5@(8),a0
	movel a0@(4),sp@-
	jbsr _W3D_DrawElements
	movel d0,d1
	clrb d0
	tstl d1
	jne L1026
L1019:
	moveq #1,d0
L1026:
	moveml a5@(-44),#0x5cfc
	unlk a5
	rts
	.even
.globl _drawTriMesh2__10RasterizerUlUlUl
_drawTriMesh2__10RasterizerUlUlUl:
	pea a5@
	movel sp,a5
	moveml #0x3e30,sp@-
	movel a5@(8),a2
	movel a5@(12),d2
	movel a5@(16),d3
	movel a5@(20),d4
	cmpl #257,d3
	jhi L1066
	subql #1,d4
	jeq L1068
	movel d3,d5
	addl d5,d5
	lea _W3D_DrawElements,a3
	.even
L1069:
	movel a2@(160),a1
	movel d3,d1
	jeq L1071
	movel d1,d0
	negl d0
	moveq #3,d6
	andl d6,d0
	jeq L1072
	cmpl d0,d6
	jle L1080
	moveq #2,d6
	cmpl d0,d6
	jle L1081
	movew d2,a0
	addw d1,a0
	movew a0,a1@+
	movew d2,a1@+
	addql #1,d2
	subql #1,d1
L1081:
	movew d2,d0
	addw d3,d0
	movew d0,a1@+
	movew d2,a1@+
	addql #1,d2
	subql #1,d1
L1080:
	movew d2,d6
	addw d3,d6
	movew d6,a1@+
	movew d2,a1@+
	addql #1,d2
	subql #1,d1
	jeq L1071
	.even
L1072:
	movel a1,a0
	movew d2,d0
	addw d3,d0
	movew d0,a0@+
	movew d2,a0@
	movel d2,d0
	addql #1,d0
	movew d0,d6
	addw d3,d6
	movew d6,a1@(4)
	movew d0,a1@(6)
	addql #1,d0
	movew d0,a0
	addw d3,a0
	movew a0,a1@(8)
	movew d0,a1@(10)
	addql #1,d0
	movew d0,d6
	addw d3,d6
	movew d6,a1@(12)
	movew d0,a1@(14)
	addql #4,d2
	addw #16,a1
	subql #4,d1
	jne L1072
L1071:
	movel a2@(160),sp@-
	movel d5,sp@-
	pea 1:w
	pea 2:w
	movel a2@(4),sp@-
	jbsr a3@
	addw #20,sp
	tstl d0
	jne L1077
	subql #1,d4
	jne L1069
L1068:
	moveq #1,d0
	jra L1076
	.even
L1077:
L1066:
	clrb d0
L1076:
	moveml a5@(-28),#0xc7c
	unlk a5
	rts
