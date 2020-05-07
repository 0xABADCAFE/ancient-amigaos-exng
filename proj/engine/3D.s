#NO_APP
.text
	.even
.globl ___aml__8Vector3DRC14Transformation
___aml__8Vector3DRC14Transformation:
	pea a5@
	movel sp,a5
	fmovem #0x1c,sp@-
	movel a5@(8),a1
	movel a5@(12),a0
	movel a0@(128),a0
	fmoves a1@,fp2
	fmoves a1@(4),fp3
	fmoves a1@(8),fp4
	fmovex fp2,fp1
	fsglmuls a0@,fp1
	fmovex fp3,fp0
	fsglmuls a0@(4),fp0
	faddx fp0,fp1
	fmovex fp4,fp0
	fsglmuls a0@(8),fp0
	faddx fp0,fp1
	fadds a0@(12),fp1
	fmoves fp1,a1@
	fmovex fp2,fp1
	fsglmuls a0@(16),fp1
	fmovex fp3,fp0
	fsglmuls a0@(20),fp0
	faddx fp0,fp1
	fmovex fp4,fp0
	fsglmuls a0@(24),fp0
	faddx fp0,fp1
	fadds a0@(28),fp1
	fmoves fp1,a1@(4)
	fsglmuls a0@(32),fp2
	fsglmuls a0@(36),fp3
	faddx fp3,fp2
	fsglmuls a0@(40),fp4
	faddx fp4,fp2
	fadds a0@(44),fp2
	fmoves fp2,a1@(8)
	movel a1,d0
	fmovem sp@+,#0x38
	unlk a5
	rts
LC0:
	.ascii "\12Vector3D (%8.4f, %8.4f, %8.4f)\12\0"
	.even
.globl _debugPrint__8Vector3D
_debugPrint__8Vector3D:
	pea a5@
	movel sp,a5
	movel a5@(8),a0
	fmoves a0@(8),fp0
	fmoved fp0,sp@-
	fmoves a0@(4),fp0
	fmoved fp0,sp@-
	fmoves a0@,fp0
	fmoved fp0,sp@-
	pea LC0
	jbsr _printf
	unlk a5
	rts
LC1:
	.ascii "\12Vertex %8.4f, %8.4f, %8.4f\12\0"
LC2:
	.ascii "(Norm) %8.4f, %8.4f, %8.4f\12\0"
LC3:
	.ascii "(TexC) %8.4f, %8.4f, %8.4f\12\0"
LC4:
	.ascii "(RGB)  %8.4f, %8.4f, %8.4f\12\0"
	.even
.globl _debugPrint__6Vertex
_debugPrint__6Vertex:
	pea a5@
	movel sp,a5
	movel a3,sp@-
	movel a2,sp@-
	movel a5@(8),a2
	fmoves a2@(8),fp0
	fmoved fp0,sp@-
	fmoves a2@(4),fp0
	fmoved fp0,sp@-
	fmoves a2@,fp0
	fmoved fp0,sp@-
	pea LC1
	lea _printf,a3
	jbsr a3@
	addw #28,sp
	movel a2@(28),a0
	tstl a0
	jeq L979
	fmoves a0@(8),fp0
	fmoved fp0,sp@-
	fmoves a0@(4),fp0
	fmoved fp0,sp@-
	fmoves a0@,fp0
	fmoved fp0,sp@-
	pea LC2
	jbsr a3@
	addw #28,sp
L979:
	fmoves a2@(20),fp0
	fmoved fp0,sp@-
	fmoves a2@(16),fp0
	fmoved fp0,sp@-
	fmoves a2@(12),fp0
	fmoved fp0,sp@-
	pea LC3
	jbsr a3@
	clrw d0
	moveb a2@(27),d0
	fmoves #0r0.00392156886,fp1
	fmovex fp1,fp0
	fsglmulw d0,fp0
	fmoved fp0,sp@-
	clrw d0
	moveb a2@(26),d0
	fmovex fp1,fp0
	fsglmulw d0,fp0
	fmoved fp0,sp@-
	clrw d0
	moveb a2@(25),d0
	fsglmulw d0,fp1
	fmoved fp1,sp@-
	pea LC4
	jbsr a3@
	movel a5@(-8),a2
	movel a5@(-4),a3
	unlk a5
	rts
	.even
.globl ___14TransformationRC14Transformation
___14TransformationRC14Transformation:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel a5@(8),a2
	movel a5@(12),a0
	movel a2,a2@(128)
	movel a0@(128),a1
	movel a2,a0
	movel a0@+,a1@+
	movel a0@+,a1@+
	movel a0@+,a1@+
	movel a0@+,a1@+
	movel a0@+,a1@+
	movel a0@+,a1@+
	movel a0@+,a1@+
	movel a0@+,a1@+
	movel a0@+,a1@+
	movel a0@+,a1@+
	movel a0@+,a1@+
	movel a0@+,a1@+
	movel a0@+,a1@+
	movel a0@+,a1@+
	movel a0@+,a1@+
	movel a0@,a1@
	movel a2,d0
	movel sp@+,a2
	unlk a5
	rts
	.even
.globl ___as__14TransformationRC14Transformation
___as__14TransformationRC14Transformation:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel a5@(8),a2
	movel a5@(12),a0
	cmpl a0,a2
	jeq L983
	movel a0@(128),a1
	movel a2@(128),a0
	movel a0@+,a1@+
	movel a0@+,a1@+
	movel a0@+,a1@+
	movel a0@+,a1@+
	movel a0@+,a1@+
	movel a0@+,a1@+
	movel a0@+,a1@+
	movel a0@+,a1@+
	movel a0@+,a1@+
	movel a0@+,a1@+
	movel a0@+,a1@+
	movel a0@+,a1@+
	movel a0@+,a1@+
	movel a0@+,a1@+
	movel a0@+,a1@+
	movel a0@,a1@
L983:
	movel a2,d0
	movel sp@+,a2
	unlk a5
	rts
	.even
.globl _rotate__14Transformationfff
_rotate__14Transformationfff:
	pea a5@
	movel sp,a5
	fmovem #0x1c,sp@-
	moveml #0x3f30,sp@-
	movel a5@(8),a3
	movel a5@(16),d2
	movel a5@(20),d4
	fmoves a5@(12),fp2
	fmoved fp2,sp@-
	lea _sin,a2
	jbsr a2@
	movel d1,sp@-
	movel d0,sp@-
	fmoved sp@+,fp0
	fmoves fp0,d0
	fmoves d0,fp3
	fmoves d2,fp0
	fmoved fp0,sp@-
	movel sp@+,d2
	movel sp@+,d3
	movel d3,sp@-
	movel d2,sp@-
	jbsr a2@
	movel d1,sp@-
	movel d0,sp@-
	fmoved sp@+,fp0
	fmoves fp0,d0
	fmoves d0,fp4
	fmoves d4,fp0
	fmoved fp0,sp@-
	movel sp@+,d4
	movel sp@+,d5
	movel d5,sp@-
	movel d4,sp@-
	jbsr a2@
	movel d1,sp@-
	movel d0,sp@-
	fmoved sp@+,fp0
	fmoves fp0,d6
	fmoved fp2,sp@-
	lea _cos,a2
	jbsr a2@
	movel d1,sp@-
	movel d0,sp@-
	fmoved sp@+,fp0
	fmoves fp0,d7
	addw #32,sp
	movel d3,sp@-
	movel d2,sp@-
	jbsr a2@
	movel d1,sp@-
	movel d0,sp@-
	fmoved sp@+,fp0
	fmoves fp0,d2
	movel d5,sp@-
	movel d4,sp@-
	jbsr a2@
	movel d1,sp@-
	movel d0,sp@-
	fmoved sp@+,fp0
	fmoves fp0,d0
	movel a3,a0
	cmpl a3@(128),a3
	jne L985
	lea a3@(64),a0
L985:
	fmoves d2,fp0
	fsglmuls d0,fp0
	fmoves fp0,a0@+
	fmoves d2,fp0
	fsglmuls d6,fp0
	fnegx fp0,fp0
	fmoves fp0,a0@+
	fmoves fp4,a0@+
	addql #4,a0
	fmovex fp3,fp2
	fsglmulx fp4,fp2
	fmovex fp2,fp1
	fsglmuls d0,fp1
	fmoves d7,fp0
	fsglmuls d6,fp0
	faddx fp0,fp1
	fmoves fp1,a0@+
	fmoves d7,fp0
	fsglmuls d0,fp0
	fsglmuls d6,fp2
	fsubx fp2,fp0
	fmoves fp0,a0@+
	fmovex fp3,fp0
	fsglmuls d2,fp0
	fmoves fp0,a0@+
	addql #4,a0
	fmoves d7,fp2
	fsglmulx fp4,fp2
	fmovex fp2,fp1
	fsglmuls d0,fp1
	fmovex fp3,fp0
	fsglmuls d6,fp0
	faddx fp0,fp1
	fnegx fp1,fp1
	fmoves fp1,a0@+
	fsglmuls d6,fp2
	fsglmuls d0,fp3
	fsubx fp3,fp2
	fmoves fp2,a0@+
	fmoves d7,fp0
	fsglmuls d2,fp0
	fmoves fp0,a0@
	movel a3,a0
	movel a3@(128),a2
	cmpl a2,a3
	jne L987
	lea a3@(64),a0
L987:
	movel a0,a1
	fmoves a1@+,fp2
	fmoves a1@+,fp3
	fmoves a1@+,fp4
	addql #4,a1
	fmovex fp2,fp1
	fsglmuls a2@,fp1
	fmovex fp3,fp0
	fsglmuls a2@(16),fp0
	faddx fp0,fp1
	fmovex fp4,fp0
	fsglmuls a2@(32),fp0
	faddx fp0,fp1
	fmoves fp1,a0@+
	fmovex fp2,fp1
	fsglmuls a2@(4),fp1
	fmovex fp3,fp0
	fsglmuls a2@(20),fp0
	faddx fp0,fp1
	fmovex fp4,fp0
	fsglmuls a2@(36),fp0
	faddx fp0,fp1
	fmoves fp1,a0@+
	fmovex fp2,fp1
	fsglmuls a2@(8),fp1
	fmovex fp3,fp0
	fsglmuls a2@(24),fp0
	faddx fp0,fp1
	fmovex fp4,fp0
	fsglmuls a2@(40),fp0
	faddx fp0,fp1
	fmoves fp1,a0@+
	fsglmuls a2@(12),fp2
	fsglmuls a2@(28),fp3
	faddx fp3,fp2
	fsglmuls a2@(44),fp4
	faddx fp4,fp2
	fmoves fp2,a0@+
	fmoves a1@+,fp2
	fmoves a1@+,fp3
	fmoves a1@+,fp4
	addql #4,a1
	fmovex fp2,fp1
	fsglmuls a2@,fp1
	fmovex fp3,fp0
	fsglmuls a2@(16),fp0
	faddx fp0,fp1
	fmovex fp4,fp0
	fsglmuls a2@(32),fp0
	faddx fp0,fp1
	fmoves fp1,a0@+
	fmovex fp2,fp1
	fsglmuls a2@(4),fp1
	fmovex fp3,fp0
	fsglmuls a2@(20),fp0
	faddx fp0,fp1
	fmovex fp4,fp0
	fsglmuls a2@(36),fp0
	faddx fp0,fp1
	fmoves fp1,a0@+
	fmovex fp2,fp1
	fsglmuls a2@(8),fp1
	fmovex fp3,fp0
	fsglmuls a2@(24),fp0
	faddx fp0,fp1
	fmovex fp4,fp0
	fsglmuls a2@(40),fp0
	faddx fp0,fp1
	fmoves fp1,a0@+
	fsglmuls a2@(12),fp2
	fsglmuls a2@(28),fp3
	faddx fp3,fp2
	fsglmuls a2@(44),fp4
	faddx fp4,fp2
	fmoves fp2,a0@+
	fmoves a1@+,fp2
	fmoves a1@+,fp3
	fmoves a1@,fp4
	fmovex fp2,fp1
	fsglmuls a2@,fp1
	fmovex fp3,fp0
	fsglmuls a2@(16),fp0
	faddx fp0,fp1
	fmovex fp4,fp0
	fsglmuls a2@(32),fp0
	faddx fp0,fp1
	fmoves fp1,a0@+
	fmovex fp2,fp1
	fsglmuls a2@(4),fp1
	fmovex fp3,fp0
	fsglmuls a2@(20),fp0
	faddx fp0,fp1
	fmovex fp4,fp0
	fsglmuls a2@(36),fp0
	faddx fp0,fp1
	fmoves fp1,a0@+
	fmovex fp2,fp1
	fsglmuls a2@(8),fp1
	fmovex fp3,fp0
	fsglmuls a2@(24),fp0
	faddx fp0,fp1
	fmovex fp4,fp0
	fsglmuls a2@(40),fp0
	faddx fp0,fp1
	fmoves fp1,a0@+
	fsglmuls a2@(12),fp2
	fsglmuls a2@(28),fp3
	faddx fp3,fp2
	fsglmuls a2@(44),fp4
	faddx fp4,fp2
	fmoves fp2,a0@+
	clrl a0@+
	clrl a0@+
	clrl a0@+
	movel #0x3f800000,a0@
	movel a3,d0
	cmpl a3@(128),a3
	jne L989
	moveq #64,d0
	addl a3,d0
L989:
	movel d0,a3@(128)
	moveml a5@(-68),#0xcfc
	fmovem a5@(-36),#0x38
	unlk a5
	rts
	.even
.globl _transform__14TransformationP8Vector3DUl
_transform__14TransformationP8Vector3DUl:
	pea a5@
	movel sp,a5
	fmovem #0x1c,sp@-
	moveml #0x203a,sp@-
	movel a5@(8),a0
	movel a5@(12),a1
	movel a0@(128),a0
	movel a5@(16),d2
	subql #1,d2
	moveq #-1,d0
	cmpl d2,d0
	jeq L993
	movel a1,d1
	movel d2,d0
	notl d0
	btst #0,d0
	jeq L997
	fmoves a1@,fp2
	fmoves a1@(4),fp3
	fmoves a1@(8),fp4
	fmovex fp2,fp1
	fsglmuls a0@,fp1
	fmovex fp3,fp0
	fsglmuls a0@(4),fp0
	faddx fp0,fp1
	fmovex fp4,fp0
	fsglmuls a0@(8),fp0
	faddx fp0,fp1
	fadds a0@(12),fp1
	fmoves fp1,a1@
	fmovex fp2,fp1
	fsglmuls a0@(16),fp1
	fmovex fp3,fp0
	fsglmuls a0@(20),fp0
	faddx fp0,fp1
	fmovex fp4,fp0
	fsglmuls a0@(24),fp0
	faddx fp0,fp1
	fadds a0@(28),fp1
	fmoves fp1,a1@(4)
	fsglmuls a0@(32),fp2
	fsglmuls a0@(36),fp3
	faddx fp3,fp2
	fsglmuls a0@(40),fp4
	faddx fp4,fp2
	fadds a0@(44),fp2
	fmoves fp2,a1@(8)
	moveq #12,d1
	addl a1,d1
	subql #1,d2
	moveq #-1,d0
	cmpl d2,d0
	jeq L993
L997:
	movel d1,a2
	movel a2,a6
	movel a2,a1
	movel a2,a4
	movel a2,a3
	.even
L994:
	fmoves a1@,fp2
	fmoves a3@(4),fp3
	fmoves a4@(8),fp4
	fmovex fp2,fp1
	fsglmuls a0@,fp1
	fmovex fp3,fp0
	fsglmuls a0@(4),fp0
	faddx fp0,fp1
	fmovex fp4,fp0
	fsglmuls a0@(8),fp0
	faddx fp0,fp1
	fadds a0@(12),fp1
	fmoves fp1,a1@
	fmovex fp2,fp1
	fsglmuls a0@(16),fp1
	fmovex fp3,fp0
	fsglmuls a0@(20),fp0
	faddx fp0,fp1
	fmovex fp4,fp0
	fsglmuls a0@(24),fp0
	faddx fp0,fp1
	fadds a0@(28),fp1
	fmoves fp1,a6@(4)
	fsglmuls a0@(32),fp2
	fsglmuls a0@(36),fp3
	faddx fp3,fp2
	fsglmuls a0@(40),fp4
	faddx fp4,fp2
	fadds a0@(44),fp2
	fmoves fp2,a2@(8)
	fmoves a1@(12),fp2
	fmoves a3@(16),fp3
	fmoves a4@(20),fp4
	fmovex fp2,fp1
	fsglmuls a0@,fp1
	fmovex fp3,fp0
	fsglmuls a0@(4),fp0
	faddx fp0,fp1
	fmovex fp4,fp0
	fsglmuls a0@(8),fp0
	faddx fp0,fp1
	fadds a0@(12),fp1
	fmoves fp1,a1@(12)
	fmovex fp2,fp1
	fsglmuls a0@(16),fp1
	fmovex fp3,fp0
	fsglmuls a0@(20),fp0
	faddx fp0,fp1
	fmovex fp4,fp0
	fsglmuls a0@(24),fp0
	faddx fp0,fp1
	fadds a0@(28),fp1
	fmoves fp1,a6@(16)
	fsglmuls a0@(32),fp2
	fsglmuls a0@(36),fp3
	faddx fp3,fp2
	fsglmuls a0@(40),fp4
	faddx fp4,fp2
	fadds a0@(44),fp2
	fmoves fp2,a2@(20)
	addw #24,a2
	addw #24,a6
	addw #24,a1
	addw #24,a4
	addw #24,a3
	subql #2,d2
	moveq #-1,d0
	cmpl d2,d0
	jne L994
L993:
	moveml sp@+,#0x5c04
	fmovem sp@+,#0x38
	unlk a5
	rts
	.even
.globl _transform__14TransformationP8Vector3DPC8Vector3DUl
_transform__14TransformationP8Vector3DPC8Vector3DUl:
	pea a5@
	movel sp,a5
	fmovem #0x1c,sp@-
	moveml #0x38,sp@-
	movel a5@(8),a0
	movel a5@(12),a4
	movel a5@(16),a3
	movel a0@(128),a2
	movel a5@(20),d1
	subql #1,d1
	moveq #-1,d0
	cmpl d1,d0
	jeq L1007
	movel d1,d0
	notl d0
	btst #0,d0
	jeq L1008
	fmoves a3@,fp2
	fmoves a3@(4),fp3
	fmoves a3@(8),fp4
	fmovex fp2,fp1
	fsglmuls a2@,fp1
	fmovex fp3,fp0
	fsglmuls a2@(4),fp0
	faddx fp0,fp1
	fmovex fp4,fp0
	fsglmuls a2@(8),fp0
	faddx fp0,fp1
	fadds a2@(12),fp1
	fmoves fp1,a4@
	fmovex fp2,fp1
	fsglmuls a2@(16),fp1
	fmovex fp3,fp0
	fsglmuls a2@(20),fp0
	faddx fp0,fp1
	fmovex fp4,fp0
	fsglmuls a2@(24),fp0
	faddx fp0,fp1
	fadds a2@(28),fp1
	fmoves fp1,a4@(4)
	fsglmuls a2@(32),fp2
	fsglmuls a2@(36),fp3
	faddx fp3,fp2
	fsglmuls a2@(40),fp4
	faddx fp4,fp2
	fadds a2@(44),fp2
	fmoves fp2,a4@(8)
	addw #12,a3
	addw #12,a4
	subql #1,d1
	jra L1019
	.even
L1008:
	fmoves a3@,fp2
	fmoves a3@(4),fp3
	fmoves a3@(8),fp4
	fmovex fp2,fp1
	fsglmuls a2@,fp1
	fmovex fp3,fp0
	fsglmuls a2@(4),fp0
	faddx fp0,fp1
	fmovex fp4,fp0
	fsglmuls a2@(8),fp0
	faddx fp0,fp1
	fadds a2@(12),fp1
	fmoves fp1,a4@
	fmovex fp2,fp1
	fsglmuls a2@(16),fp1
	fmovex fp3,fp0
	fsglmuls a2@(20),fp0
	faddx fp0,fp1
	fmovex fp4,fp0
	fsglmuls a2@(24),fp0
	faddx fp0,fp1
	fadds a2@(28),fp1
	fmoves fp1,a4@(4)
	fsglmuls a2@(32),fp2
	fsglmuls a2@(36),fp3
	faddx fp3,fp2
	fsglmuls a2@(40),fp4
	faddx fp4,fp2
	fadds a2@(44),fp2
	fmoves fp2,a4@(8)
	lea a3@(12),a0
	lea a4@(12),a1
	fmoves a0@,fp2
	fmoves a0@(4),fp3
	fmoves a0@(8),fp4
	fmovex fp2,fp1
	fsglmuls a2@,fp1
	fmovex fp3,fp0
	fsglmuls a2@(4),fp0
	faddx fp0,fp1
	fmovex fp4,fp0
	fsglmuls a2@(8),fp0
	faddx fp0,fp1
	fadds a2@(12),fp1
	fmoves fp1,a1@
	fmovex fp2,fp1
	fsglmuls a2@(16),fp1
	fmovex fp3,fp0
	fsglmuls a2@(20),fp0
	faddx fp0,fp1
	fmovex fp4,fp0
	fsglmuls a2@(24),fp0
	faddx fp0,fp1
	fadds a2@(28),fp1
	fmoves fp1,a1@(4)
	fsglmuls a2@(32),fp2
	fsglmuls a2@(36),fp3
	faddx fp3,fp2
	fsglmuls a2@(40),fp4
	faddx fp4,fp2
	fadds a2@(44),fp2
	fmoves fp2,a1@(8)
	addw #24,a3
	addw #24,a4
	subql #2,d1
L1019:
	moveq #-1,d0
	cmpl d1,d0
	jne L1008
L1007:
	moveml sp@+,#0x1c00
	fmovem sp@+,#0x38
	unlk a5
	rts
	.even
.globl _transform__14TransformationP6VertexUl
_transform__14TransformationP6VertexUl:
	pea a5@
	movel sp,a5
	fmovem #0x1c,sp@-
	moveml #0x203a,sp@-
	movel a5@(8),a0
	movel a5@(12),a1
	movel a0@(128),a0
	movel a5@(16),d2
	subql #1,d2
	moveq #-1,d0
	cmpl d2,d0
	jeq L1022
	movel a1,d1
	movel d2,d0
	notl d0
	btst #0,d0
	jeq L1026
	fmoves a1@,fp2
	fmoves a1@(4),fp3
	fmoves a1@(8),fp4
	fmovex fp2,fp1
	fsglmuls a0@,fp1
	fmovex fp3,fp0
	fsglmuls a0@(4),fp0
	faddx fp0,fp1
	fmovex fp4,fp0
	fsglmuls a0@(8),fp0
	faddx fp0,fp1
	fadds a0@(12),fp1
	fmoves fp1,a1@
	fmovex fp2,fp1
	fsglmuls a0@(16),fp1
	fmovex fp3,fp0
	fsglmuls a0@(20),fp0
	faddx fp0,fp1
	fmovex fp4,fp0
	fsglmuls a0@(24),fp0
	faddx fp0,fp1
	fadds a0@(28),fp1
	fmoves fp1,a1@(4)
	fsglmuls a0@(32),fp2
	fsglmuls a0@(36),fp3
	faddx fp3,fp2
	fsglmuls a0@(40),fp4
	faddx fp4,fp2
	fadds a0@(44),fp2
	fmoves fp2,a1@(8)
	moveq #32,d1
	addl a1,d1
	subql #1,d2
	moveq #-1,d0
	cmpl d2,d0
	jeq L1022
L1026:
	movel d1,a2
	movel a2,a6
	movel a2,a1
	movel a2,a4
	movel a2,a3
	.even
L1023:
	fmoves a1@,fp2
	fmoves a3@(4),fp3
	fmoves a4@(8),fp4
	fmovex fp2,fp1
	fsglmuls a0@,fp1
	fmovex fp3,fp0
	fsglmuls a0@(4),fp0
	faddx fp0,fp1
	fmovex fp4,fp0
	fsglmuls a0@(8),fp0
	faddx fp0,fp1
	fadds a0@(12),fp1
	fmoves fp1,a1@
	fmovex fp2,fp1
	fsglmuls a0@(16),fp1
	fmovex fp3,fp0
	fsglmuls a0@(20),fp0
	faddx fp0,fp1
	fmovex fp4,fp0
	fsglmuls a0@(24),fp0
	faddx fp0,fp1
	fadds a0@(28),fp1
	fmoves fp1,a6@(4)
	fsglmuls a0@(32),fp2
	fsglmuls a0@(36),fp3
	faddx fp3,fp2
	fsglmuls a0@(40),fp4
	faddx fp4,fp2
	fadds a0@(44),fp2
	fmoves fp2,a2@(8)
	fmoves a1@(32),fp2
	fmoves a3@(36),fp3
	fmoves a4@(40),fp4
	fmovex fp2,fp1
	fsglmuls a0@,fp1
	fmovex fp3,fp0
	fsglmuls a0@(4),fp0
	faddx fp0,fp1
	fmovex fp4,fp0
	fsglmuls a0@(8),fp0
	faddx fp0,fp1
	fadds a0@(12),fp1
	fmoves fp1,a1@(32)
	fmovex fp2,fp1
	fsglmuls a0@(16),fp1
	fmovex fp3,fp0
	fsglmuls a0@(20),fp0
	faddx fp0,fp1
	fmovex fp4,fp0
	fsglmuls a0@(24),fp0
	faddx fp0,fp1
	fadds a0@(28),fp1
	fmoves fp1,a6@(36)
	fsglmuls a0@(32),fp2
	fsglmuls a0@(36),fp3
	faddx fp3,fp2
	fsglmuls a0@(40),fp4
	faddx fp4,fp2
	fadds a0@(44),fp2
	fmoves fp2,a2@(40)
	addw #64,a2
	addw #64,a6
	addw #64,a1
	addw #64,a4
	addw #64,a3
	subql #2,d2
	moveq #-1,d0
	cmpl d2,d0
	jne L1023
L1022:
	moveml sp@+,#0x5c04
	fmovem sp@+,#0x38
	unlk a5
	rts
	.even
.globl _transform__14TransformationP6VertexPC6VertexUl
_transform__14TransformationP6VertexPC6VertexUl:
	pea a5@
	movel sp,a5
	fmovem #0x1c,sp@-
	moveml #0x38,sp@-
	movel a5@(8),a0
	movel a5@(12),a4
	movel a5@(16),a3
	movel a0@(128),a2
	movel a5@(20),d1
	subql #1,d1
	moveq #-1,d0
	cmpl d1,d0
	jeq L1036
	movel d1,d0
	notl d0
	btst #0,d0
	jeq L1037
	fmoves a3@,fp2
	fmoves a3@(4),fp3
	fmoves a3@(8),fp4
	fmovex fp2,fp1
	fsglmuls a2@,fp1
	fmovex fp3,fp0
	fsglmuls a2@(4),fp0
	faddx fp0,fp1
	fmovex fp4,fp0
	fsglmuls a2@(8),fp0
	faddx fp0,fp1
	fadds a2@(12),fp1
	fmoves fp1,a4@
	fmovex fp2,fp1
	fsglmuls a2@(16),fp1
	fmovex fp3,fp0
	fsglmuls a2@(20),fp0
	faddx fp0,fp1
	fmovex fp4,fp0
	fsglmuls a2@(24),fp0
	faddx fp0,fp1
	fadds a2@(28),fp1
	fmoves fp1,a4@(4)
	fsglmuls a2@(32),fp2
	fsglmuls a2@(36),fp3
	faddx fp3,fp2
	fsglmuls a2@(40),fp4
	faddx fp4,fp2
	fadds a2@(44),fp2
	fmoves fp2,a4@(8)
	addw #32,a3
	addw #32,a4
	subql #1,d1
	jra L1048
	.even
L1037:
	fmoves a3@,fp2
	fmoves a3@(4),fp3
	fmoves a3@(8),fp4
	fmovex fp2,fp1
	fsglmuls a2@,fp1
	fmovex fp3,fp0
	fsglmuls a2@(4),fp0
	faddx fp0,fp1
	fmovex fp4,fp0
	fsglmuls a2@(8),fp0
	faddx fp0,fp1
	fadds a2@(12),fp1
	fmoves fp1,a4@
	fmovex fp2,fp1
	fsglmuls a2@(16),fp1
	fmovex fp3,fp0
	fsglmuls a2@(20),fp0
	faddx fp0,fp1
	fmovex fp4,fp0
	fsglmuls a2@(24),fp0
	faddx fp0,fp1
	fadds a2@(28),fp1
	fmoves fp1,a4@(4)
	fsglmuls a2@(32),fp2
	fsglmuls a2@(36),fp3
	faddx fp3,fp2
	fsglmuls a2@(40),fp4
	faddx fp4,fp2
	fadds a2@(44),fp2
	fmoves fp2,a4@(8)
	lea a3@(32),a0
	lea a4@(32),a1
	fmoves a0@,fp2
	fmoves a0@(4),fp3
	fmoves a0@(8),fp4
	fmovex fp2,fp1
	fsglmuls a2@,fp1
	fmovex fp3,fp0
	fsglmuls a2@(4),fp0
	faddx fp0,fp1
	fmovex fp4,fp0
	fsglmuls a2@(8),fp0
	faddx fp0,fp1
	fadds a2@(12),fp1
	fmoves fp1,a1@
	fmovex fp2,fp1
	fsglmuls a2@(16),fp1
	fmovex fp3,fp0
	fsglmuls a2@(20),fp0
	faddx fp0,fp1
	fmovex fp4,fp0
	fsglmuls a2@(24),fp0
	faddx fp0,fp1
	fadds a2@(28),fp1
	fmoves fp1,a1@(4)
	fsglmuls a2@(32),fp2
	fsglmuls a2@(36),fp3
	faddx fp3,fp2
	fsglmuls a2@(40),fp4
	faddx fp4,fp2
	fadds a2@(44),fp2
	fmoves fp2,a1@(8)
	addw #64,a3
	addw #64,a4
	subql #2,d1
L1048:
	moveq #-1,d0
	cmpl d1,d0
	jne L1037
L1036:
	moveml sp@+,#0x1c00
	fmovem sp@+,#0x38
	unlk a5
	rts
	.even
.globl _transformTex__14TransformationP6VertexUl
_transformTex__14TransformationP6VertexUl:
	pea a5@
	movel sp,a5
	fmovem #0x1c,sp@-
	moveml #0x303a,sp@-
	movel a5@(8),a0
	movel a5@(12),a2
	movel a0@(128),a1
	movel a5@(16),d2
	subql #1,d2
	moveq #-1,d0
	cmpl d2,d0
	jeq L1051
	moveq #20,d1
	addl a2,d1
	movel d2,d0
	notl d0
	btst #0,d0
	jeq L1055
	movel d1,a0
	fmoves a0@(-8),fp2
	fmoves a0@(-4),fp3
	fmoves a0@,fp4
	fmovex fp2,fp1
	fsglmuls a1@,fp1
	fmovex fp3,fp0
	fsglmuls a1@(4),fp0
	faddx fp0,fp1
	fmovex fp4,fp0
	fsglmuls a1@(8),fp0
	faddx fp0,fp1
	fadds a1@(12),fp1
	fmoves fp1,a0@(-8)
	fmovex fp2,fp1
	fsglmuls a1@(16),fp1
	fmovex fp3,fp0
	fsglmuls a1@(20),fp0
	faddx fp0,fp1
	fmovex fp4,fp0
	fsglmuls a1@(24),fp0
	faddx fp0,fp1
	fadds a1@(28),fp1
	fmoves fp1,a0@(-4)
	fsglmuls a1@(32),fp2
	fsglmuls a1@(36),fp3
	faddx fp3,fp2
	fsglmuls a1@(40),fp4
	faddx fp4,fp2
	fadds a1@(44),fp2
	fmoves fp2,a0@
	moveq #52,d1
	addl a2,d1
	subql #1,d2
	moveq #-1,d0
	cmpl d2,d0
	jeq L1051
L1055:
	movel d1,a0
	movel a0,d0
	movel a0,d3
	movel a0,a4
	movel a0,a3
	movel a0,a2
	.even
L1052:
	fmoves a2@(-8),fp2
	fmoves a3@(-4),fp3
	fmoves a4@,fp4
	fmovex fp2,fp1
	fsglmuls a1@,fp1
	fmovex fp3,fp0
	fsglmuls a1@(4),fp0
	faddx fp0,fp1
	fmovex fp4,fp0
	fsglmuls a1@(8),fp0
	faddx fp0,fp1
	fadds a1@(12),fp1
	movel d3,a6
	fmoves fp1,a6@(-8)
	fmovex fp2,fp1
	fsglmuls a1@(16),fp1
	fmovex fp3,fp0
	fsglmuls a1@(20),fp0
	faddx fp0,fp1
	fmovex fp4,fp0
	fsglmuls a1@(24),fp0
	faddx fp0,fp1
	fadds a1@(28),fp1
	movel d0,a6
	fmoves fp1,a6@(-4)
	fsglmuls a1@(32),fp2
	fsglmuls a1@(36),fp3
	faddx fp3,fp2
	fsglmuls a1@(40),fp4
	faddx fp4,fp2
	fadds a1@(44),fp2
	fmoves fp2,a0@
	fmoves a2@(24),fp2
	fmoves a3@(28),fp3
	fmoves a4@(32),fp4
	fmovex fp2,fp1
	fsglmuls a1@,fp1
	fmovex fp3,fp0
	fsglmuls a1@(4),fp0
	faddx fp0,fp1
	fmovex fp4,fp0
	fsglmuls a1@(8),fp0
	faddx fp0,fp1
	fadds a1@(12),fp1
	movel d3,a6
	fmoves fp1,a6@(24)
	fmovex fp2,fp1
	fsglmuls a1@(16),fp1
	fmovex fp3,fp0
	fsglmuls a1@(20),fp0
	faddx fp0,fp1
	fmovex fp4,fp0
	fsglmuls a1@(24),fp0
	faddx fp0,fp1
	fadds a1@(28),fp1
	movel d0,a6
	fmoves fp1,a6@(28)
	fsglmuls a1@(32),fp2
	fsglmuls a1@(36),fp3
	faddx fp3,fp2
	fsglmuls a1@(40),fp4
	faddx fp4,fp2
	fadds a1@(44),fp2
	fmoves fp2,a0@(32)
	addw #64,a0
	moveq #64,d1
	addl d1,d0
	addl d1,d3
	addw #64,a4
	addw #64,a3
	addw #64,a2
	subql #2,d2
	moveq #-1,d1
	cmpl d2,d1
	jne L1052
L1051:
	moveml sp@+,#0x5c0c
	fmovem sp@+,#0x38
	unlk a5
	rts
	.even
.globl _transformTex__14TransformationP6VertexPC6VertexUl
_transformTex__14TransformationP6VertexPC6VertexUl:
	pea a5@
	movel sp,a5
	fmovem #0x1c,sp@-
	moveml #0x303a,sp@-
	movel a5@(8),a0
	movel a5@(12),a3
	movel a5@(16),d2
	movel a0@(128),a2
	movel a5@(20),d3
	subql #1,d3
	moveq #-1,d0
	cmpl d3,d0
	jeq L1065
	moveq #20,d1
	addl a3,d1
	movel d3,d0
	notl d0
	btst #0,d0
	jeq L1069
	movel d2,a0
	lea a0@(20),a1
	fmoves a1@(-8),fp2
	fmoves a1@(-4),fp3
	fmoves a1@,fp4
	fmovex fp2,fp1
	fsglmuls a2@,fp1
	fmovex fp3,fp0
	fsglmuls a2@(4),fp0
	faddx fp0,fp1
	fmovex fp4,fp0
	fsglmuls a2@(8),fp0
	faddx fp0,fp1
	movel d1,a0
	fadds a2@(12),fp1
	fmoves fp1,a0@(-8)
	fmovex fp2,fp1
	fsglmuls a2@(16),fp1
	fmovex fp3,fp0
	fsglmuls a2@(20),fp0
	faddx fp0,fp1
	fmovex fp4,fp0
	fsglmuls a2@(24),fp0
	faddx fp0,fp1
	fadds a2@(28),fp1
	fmoves fp1,a0@(-4)
	fsglmuls a2@(32),fp2
	fsglmuls a2@(36),fp3
	faddx fp3,fp2
	fsglmuls a2@(40),fp4
	faddx fp4,fp2
	fadds a2@(44),fp2
	fmoves fp2,a0@
	moveq #32,d0
	addl d0,d2
	moveq #52,d1
	addl a3,d1
	subql #1,d3
	moveq #-1,d0
	cmpl d3,d0
	jeq L1065
L1069:
	movel d1,a0
	movel a0,a4
	movel a0,a3
	.even
L1066:
	movel d2,a6
	lea a6@(20),a1
	fmoves a1@(-8),fp2
	fmoves a1@(-4),fp3
	fmoves a1@,fp4
	fmovex fp2,fp1
	fsglmuls a2@,fp1
	fmovex fp3,fp0
	fsglmuls a2@(4),fp0
	faddx fp0,fp1
	fmovex fp4,fp0
	fsglmuls a2@(8),fp0
	faddx fp0,fp1
	fadds a2@(12),fp1
	fmoves fp1,a3@(-8)
	fmovex fp2,fp1
	fsglmuls a2@(16),fp1
	fmovex fp3,fp0
	fsglmuls a2@(20),fp0
	faddx fp0,fp1
	fmovex fp4,fp0
	fsglmuls a2@(24),fp0
	faddx fp0,fp1
	fadds a2@(28),fp1
	fmoves fp1,a4@(-4)
	fsglmuls a2@(32),fp2
	fsglmuls a2@(36),fp3
	faddx fp3,fp2
	fsglmuls a2@(40),fp4
	faddx fp4,fp2
	fadds a2@(44),fp2
	fmoves fp2,a0@
	lea a6@(52),a1
	fmoves a1@(-8),fp2
	fmoves a1@(-4),fp3
	fmoves a1@,fp4
	fmovex fp2,fp1
	fsglmuls a2@,fp1
	fmovex fp3,fp0
	fsglmuls a2@(4),fp0
	faddx fp0,fp1
	fmovex fp4,fp0
	fsglmuls a2@(8),fp0
	faddx fp0,fp1
	fadds a2@(12),fp1
	fmoves fp1,a3@(24)
	fmovex fp2,fp1
	fsglmuls a2@(16),fp1
	fmovex fp3,fp0
	fsglmuls a2@(20),fp0
	faddx fp0,fp1
	fmovex fp4,fp0
	fsglmuls a2@(24),fp0
	faddx fp0,fp1
	fadds a2@(28),fp1
	fmoves fp1,a4@(28)
	fsglmuls a2@(32),fp2
	fsglmuls a2@(36),fp3
	faddx fp3,fp2
	fsglmuls a2@(40),fp4
	faddx fp4,fp2
	fadds a2@(44),fp2
	fmoves fp2,a0@(32)
	moveq #64,d0
	addl d0,d2
	addw #64,a0
	addw #64,a4
	addw #64,a3
	subql #2,d3
	moveq #-1,d0
	cmpl d3,d0
	jne L1066
L1065:
	moveml sp@+,#0x5c0c
	fmovem sp@+,#0x38
	unlk a5
	rts
	.even
.globl ___aml__14TransformationRC14Transformation
___aml__14TransformationRC14Transformation:
	pea a5@
	movel sp,a5
	fmovem #0x1c,sp@-
	movel a3,sp@-
	movel a2,sp@-
	movel a5@(8),a3
	movel a5@(12),a0
	movel a3@(128),a1
	movel a0@(128),a0
	movel a1,a2
	fmoves a2@+,fp2
	fmoves a2@+,fp3
	fmoves a2@+,fp4
	addql #4,a2
	fmovex fp2,fp1
	fsglmuls a0@,fp1
	fmovex fp3,fp0
	fsglmuls a0@(16),fp0
	faddx fp0,fp1
	fmovex fp4,fp0
	fsglmuls a0@(32),fp0
	faddx fp0,fp1
	fmoves fp1,a1@+
	fmovex fp2,fp1
	fsglmuls a0@(4),fp1
	fmovex fp3,fp0
	fsglmuls a0@(20),fp0
	faddx fp0,fp1
	fmovex fp4,fp0
	fsglmuls a0@(36),fp0
	faddx fp0,fp1
	fmoves fp1,a1@+
	fmovex fp2,fp1
	fsglmuls a0@(8),fp1
	fmovex fp3,fp0
	fsglmuls a0@(24),fp0
	faddx fp0,fp1
	fmovex fp4,fp0
	fsglmuls a0@(40),fp0
	faddx fp0,fp1
	fmoves fp1,a1@+
	fsglmuls a0@(12),fp2
	fsglmuls a0@(28),fp3
	faddx fp3,fp2
	fsglmuls a0@(44),fp4
	faddx fp4,fp2
	fadds a1@,fp2
	fmoves fp2,a1@+
	fmoves a2@+,fp2
	fmoves a2@+,fp3
	fmoves a2@+,fp4
	addql #4,a2
	fmovex fp2,fp1
	fsglmuls a0@,fp1
	fmovex fp3,fp0
	fsglmuls a0@(16),fp0
	faddx fp0,fp1
	fmovex fp4,fp0
	fsglmuls a0@(32),fp0
	faddx fp0,fp1
	fmoves fp1,a1@+
	fmovex fp2,fp1
	fsglmuls a0@(4),fp1
	fmovex fp3,fp0
	fsglmuls a0@(20),fp0
	faddx fp0,fp1
	fmovex fp4,fp0
	fsglmuls a0@(36),fp0
	faddx fp0,fp1
	fmoves fp1,a1@+
	fmovex fp2,fp1
	fsglmuls a0@(8),fp1
	fmovex fp3,fp0
	fsglmuls a0@(24),fp0
	faddx fp0,fp1
	fmovex fp4,fp0
	fsglmuls a0@(40),fp0
	faddx fp0,fp1
	fmoves fp1,a1@+
	fsglmuls a0@(12),fp2
	fsglmuls a0@(28),fp3
	faddx fp3,fp2
	fsglmuls a0@(44),fp4
	faddx fp4,fp2
	fadds a1@,fp2
	fmoves fp2,a1@+
	fmoves a2@+,fp2
	fmoves a2@+,fp3
	fmoves a2@,fp4
	fmovex fp2,fp1
	fsglmuls a0@,fp1
	fmovex fp3,fp0
	fsglmuls a0@(16),fp0
	faddx fp0,fp1
	fmovex fp4,fp0
	fsglmuls a0@(32),fp0
	faddx fp0,fp1
	fmoves fp1,a1@+
	fmovex fp2,fp1
	fsglmuls a0@(4),fp1
	fmovex fp3,fp0
	fsglmuls a0@(20),fp0
	faddx fp0,fp1
	fmovex fp4,fp0
	fsglmuls a0@(36),fp0
	faddx fp0,fp1
	fmoves fp1,a1@+
	fmovex fp2,fp1
	fsglmuls a0@(8),fp1
	fmovex fp3,fp0
	fsglmuls a0@(24),fp0
	faddx fp0,fp1
	fmovex fp4,fp0
	fsglmuls a0@(40),fp0
	faddx fp0,fp1
	fmoves fp1,a1@+
	fsglmuls a0@(12),fp2
	fsglmuls a0@(28),fp3
	faddx fp3,fp2
	fsglmuls a0@(44),fp4
	faddx fp4,fp2
	fadds a1@,fp2
	fmoves fp2,a1@
	movel a3,d0
	movel sp@+,a2
	movel sp@+,a3
	fmovem sp@+,#0x38
	unlk a5
	rts
	.even
.globl ___ml__FRC14TransformationT0
___ml__FRC14TransformationT0:
	link a5,#-132
	fmovem #0x1c,sp@-
	moveml #0x2030,sp@-
	movel a1,d2
	movel a5@(8),a0
	movel a5@(12),a2
	lea a5@(-132),a1
	movel a1,a5@(-4)
	movel a1,a3
	movel a0@(128),a1
	movel a2@(128),a0
	fmoves a1@+,fp2
	fmoves a1@+,fp3
	fmoves a1@+,fp4
	addql #4,a1
	fmovex fp2,fp1
	fsglmuls a0@,fp1
	fmovex fp3,fp0
	fsglmuls a0@(16),fp0
	faddx fp0,fp1
	fmovex fp4,fp0
	fsglmuls a0@(32),fp0
	faddx fp0,fp1
	fmoves fp1,a3@
	fmovex fp2,fp1
	fsglmuls a0@(4),fp1
	fmovex fp3,fp0
	fsglmuls a0@(20),fp0
	faddx fp0,fp1
	fmovex fp4,fp0
	fsglmuls a0@(36),fp0
	faddx fp0,fp1
	fmoves fp1,a5@(-128)
	fmovex fp2,fp1
	fsglmuls a0@(8),fp1
	fmovex fp3,fp0
	fsglmuls a0@(24),fp0
	faddx fp0,fp1
	fmovex fp4,fp0
	fsglmuls a0@(40),fp0
	faddx fp0,fp1
	fmoves fp1,a5@(-124)
	fsglmuls a0@(12),fp2
	fsglmuls a0@(28),fp3
	faddx fp3,fp2
	fsglmuls a0@(44),fp4
	faddx fp4,fp2
	fadds a5@(-120),fp2
	fmoves fp2,a5@(-120)
	fmoves a1@+,fp2
	fmoves a1@+,fp3
	fmoves a1@+,fp4
	addql #4,a1
	fmovex fp2,fp1
	fsglmuls a0@,fp1
	fmovex fp3,fp0
	fsglmuls a0@(16),fp0
	faddx fp0,fp1
	fmovex fp4,fp0
	fsglmuls a0@(32),fp0
	faddx fp0,fp1
	fmoves fp1,a5@(-116)
	fmovex fp2,fp1
	fsglmuls a0@(4),fp1
	fmovex fp3,fp0
	fsglmuls a0@(20),fp0
	faddx fp0,fp1
	fmovex fp4,fp0
	fsglmuls a0@(36),fp0
	faddx fp0,fp1
	fmoves fp1,a5@(-112)
	fmovex fp2,fp1
	fsglmuls a0@(8),fp1
	fmovex fp3,fp0
	fsglmuls a0@(24),fp0
	faddx fp0,fp1
	fmovex fp4,fp0
	fsglmuls a0@(40),fp0
	faddx fp0,fp1
	fmoves fp1,a5@(-108)
	fsglmuls a0@(12),fp2
	fsglmuls a0@(28),fp3
	faddx fp3,fp2
	fsglmuls a0@(44),fp4
	faddx fp4,fp2
	fadds a5@(-104),fp2
	fmoves fp2,a5@(-104)
	fmoves a1@+,fp2
	fmoves a1@+,fp3
	fmoves a1@,fp4
	fmovex fp2,fp1
	fsglmuls a0@,fp1
	fmovex fp3,fp0
	fsglmuls a0@(16),fp0
	faddx fp0,fp1
	fmovex fp4,fp0
	fsglmuls a0@(32),fp0
	faddx fp0,fp1
	fmoves fp1,a5@(-100)
	fmovex fp2,fp1
	fsglmuls a0@(4),fp1
	fmovex fp3,fp0
	fsglmuls a0@(20),fp0
	faddx fp0,fp1
	fmovex fp4,fp0
	fsglmuls a0@(36),fp0
	faddx fp0,fp1
	fmoves fp1,a5@(-96)
	fmovex fp2,fp1
	fsglmuls a0@(8),fp1
	fmovex fp3,fp0
	fsglmuls a0@(24),fp0
	faddx fp0,fp1
	fmovex fp4,fp0
	fsglmuls a0@(40),fp0
	faddx fp0,fp1
	fmoves fp1,a5@(-92)
	fsglmuls a0@(12),fp2
	fsglmuls a0@(28),fp3
	faddx fp3,fp2
	fsglmuls a0@(44),fp4
	faddx fp4,fp2
	fadds a5@(-88),fp2
	fmoves fp2,a5@(-88)
	movel a3,sp@-
	movel d2,sp@-
	jbsr ___14TransformationRC14Transformation
	movel d2,d0
	moveml a5@(-180),#0xc04
	fmovem a5@(-168),#0x38
	unlk a5
	rts
LC5:
	.ascii "\12Transformation\12| %8.4f %8.4f %8.4f %8.4f |\12| %8.4f %8.4f %8.4f %8.4f |\12| %8.4f %8.4f %8.4f %8.4f |\12| %8.4f %8.4f %8.4f %8.4f |\12\0"
	.even
.globl _debugPrint__14Transformation
_debugPrint__14Transformation:
	pea a5@
	movel sp,a5
	movel a5@(8),a0
	movel a0@(128),a0
	fmoves a0@(60),fp0
	fmoved fp0,sp@-
	fmoves a0@(56),fp0
	fmoved fp0,sp@-
	fmoves a0@(52),fp0
	fmoved fp0,sp@-
	fmoves a0@(48),fp0
	fmoved fp0,sp@-
	fmoves a0@(44),fp0
	fmoved fp0,sp@-
	fmoves a0@(40),fp0
	fmoved fp0,sp@-
	fmoves a0@(36),fp0
	fmoved fp0,sp@-
	fmoves a0@(32),fp0
	fmoved fp0,sp@-
	fmoves a0@(28),fp0
	fmoved fp0,sp@-
	fmoves a0@(24),fp0
	fmoved fp0,sp@-
	fmoves a0@(20),fp0
	fmoved fp0,sp@-
	fmoves a0@(16),fp0
	fmoved fp0,sp@-
	fmoves a0@(12),fp0
	fmoved fp0,sp@-
	fmoves a0@(8),fp0
	fmoved fp0,sp@-
	fmoves a0@(4),fp0
	fmoved fp0,sp@-
	fmoves a0@,fp0
	fmoved fp0,sp@-
	pea LC5
	jbsr _printf
	unlk a5
	rts
