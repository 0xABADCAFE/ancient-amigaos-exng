#NO_APP
.text
	.even
.globl ___9WorldViewssf
___9WorldViewssf:
	pea a5@
	movel sp,a5
	fmovem #0x4,sp@-
	movel d2,sp@-
	movel a5@(8),a1
	movel a5@(12),d2
	movel a5@(16),d1
	movel a5@(20),d0
	movel a1,a1@(128)
	movel a1,a0
	movel #1065353216,a0@+
	clrl a0@+
	clrl a0@+
	clrl a0@+
	clrl a0@+
	movel #1065353216,a0@+
	clrl a0@+
	clrl a0@+
	clrl a0@+
	clrl a0@+
	movel #1065353216,a0@+
	clrl a0@+
	clrl a0@+
	clrl a0@+
	clrl a0@+
	movel #1065353216,a0@
	movew d2,a1@(192)
	movew d1,a1@(194)
	movel d0,a1@(196)
	movel #0x3f800000,a1@(200)
	movel #0x3f800000,a1@(204)
	clrl a1@(208)
	movel #0x3fc90fdb,a1@(212)
	moveb #1,a1@(216)
	moveb #1,a1@(217)
	fmoves __8WorldMap$scaledW,fp0
	fmoved #0r0.5000000000000005,fp2
	fmulx fp2,fp0
	fmoves fp0,a1@(144)
	fmoves __8WorldMap$scaledH,fp0
	fmulx fp2,fp0
	fmoves fp0,a1@(148)
	fmoves d0,fp1
	fmovex fp1,fp0
	fmulx fp2,fp0
	fmoves fp0,a1@(152)
	fmovew d1,fp0
	fmulx fp2,fp0
	fmulx fp0,fp1
	fmovew d2,fp0
	fdivx fp0,fp1
	fmoves fp1,a1@(156)
	movel a1,d0
	movel sp@+,d2
	fmovem sp@+,#0x20
	unlk a5
	rts
	.even
.globl __$_9WorldView
__$_9WorldView:
	pea a5@
	movel sp,a5
	btst #0,a5@(15)
	jeq L1037
	movel a5@(8),sp@-
	jbsr ___builtin_delete
L1037:
	unlk a5
	rts
	.even
.globl _set__9WorldViewfffff
_set__9WorldViewfffff:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel a5@(8),a2
	movel a5@(20),d0
	fmoves a5@(12),fp0
	fmoves __8WorldMap$scaledW,fp1
	fcmpd #0r0.000000000000005,fp0
	fjlt L1039
	fcmpx fp1,fp0
	fjle L1041
	fmovex fp1,fp0
	jra L1041
	.even
L1039:
	fmoved #0r0.000000000000005,fp0
L1041:
	fmoves fp0,a2@(144)
	fmoves a5@(16),fp0
	fmoves __8WorldMap$scaledH,fp1
	fcmpd #0r0.000000000000005,fp0
	fjlt L1044
	fcmpx fp1,fp0
	fjle L1046
	fmovex fp1,fp0
	jra L1046
	.even
L1044:
	fmoved #0r0.000000000000005,fp0
L1046:
	fmoves fp0,a2@(148)
	movel d0,a2@(200)
	fmoves d0,fp0
	fmoved #0r1.000000000000005,fp1
	fdivx fp0,fp1
	fmoves fp1,a2@(204)
	fmoves a5@(24),fp0
	fmoved #0r0.01745329251994334,fp1
	fmulx fp1,fp0
	fmoves fp0,a2@(208)
	fmoves a5@(28),fp0
	fmulx fp1,fp0
	fmoves fp0,a2@(212)
	movel a2,sp@-
	jbsr _projectViewOnMap__9WorldView
	movel a2,sp@-
	jbsr _buildTransformation__9WorldView
	movel a5@(-4),a2
	unlk a5
	rts
	.even
.globl _projectViewOnMap__9WorldView
_projectViewOnMap__9WorldView:
	pea a5@
	movel sp,a5
	fmovem #0x1c,sp@-
	moveml #0x3030,sp@-
	movel a5@(8),a2
	fmoves a2@(208),fp0
	fmoved fp0,sp@-
	jbsr _cos
	movel d1,sp@-
	movel d0,sp@-
	fmoved sp@+,fp0
	fmoves fp0,d3
	fmoves a2@(208),fp0
	fmoved fp0,sp@-
	lea _sin,a3
	jbsr a3@
	movel d1,sp@-
	movel d0,sp@-
	fmoved sp@+,fp0
	fmoves fp0,d2
	fmoves a2@(204),fp2
	fmoves a2@(212),fp0
	fmoved fp0,sp@-
	jbsr a3@
	fmovex fp2,fp1
	movel d1,sp@-
	movel d0,sp@-
	fmoved sp@+,fp0
	fdivx fp0,fp1
	fmoves fp1,d0
	fmoves d0,fp1
	fsglmuls a2@(152),fp2
	fmovex fp2,fp3
	fsglmuls d3,fp3
	fsglmuls a2@(156),fp1
	fmovex fp1,fp4
	fsglmuls d2,fp4
	fsglmuls d2,fp2
	fsglmuls d3,fp1
	lea a2@(160),a0
	fmoves a2@(144),fp0
	fsubx fp3,fp0
	fsubx fp4,fp0
	fmoves fp0,a0@
	fmoves a2@(148),fp0
	fsubx fp2,fp0
	faddx fp1,fp0
	fmoves fp0,a0@(4)
	addql #8,a0
	fmovex fp3,fp0
	fadds a2@(144),fp0
	fsubx fp4,fp0
	fmoves fp0,a0@
	fmovex fp2,fp0
	fadds a2@(148),fp0
	faddx fp1,fp0
	fmoves fp0,a0@(4)
	addql #8,a0
	fmoves a2@(144),fp0
	fsubx fp3,fp0
	faddx fp4,fp0
	fmoves fp0,a0@
	fmoves a2@(148),fp0
	fsubx fp2,fp0
	fsubx fp1,fp0
	fmoves fp0,a0@(4)
	addql #8,a0
	fadds a2@(144),fp3
	faddx fp4,fp3
	fmoves fp3,a0@
	fadds a2@(148),fp2
	fsubx fp1,fp2
	fmoves fp2,a0@(4)
	clrb a2@(216)
	moveml a5@(-52),#0xc0c
	fmovem a5@(-36),#0x38
	unlk a5
	rts
	.even
.globl _buildTransformation__9WorldView
_buildTransformation__9WorldView:
	pea a5@
	movel sp,a5
	fmovem #0x4,sp@-
	movel a2,sp@-
	movel a5@(8),a2
	movel a2@(128),a0
	movel #1065353216,a0@+
	clrl a0@+
	clrl a0@+
	clrl a0@+
	clrl a0@+
	movel #1065353216,a0@+
	clrl a0@+
	clrl a0@+
	clrl a0@+
	clrl a0@+
	movel #1065353216,a0@+
	clrl a0@+
	clrl a0@+
	clrl a0@+
	clrl a0@+
	movel #1065353216,a0@
	fnegs a2@(148),fp0
	movel a2@(128),a0
	fmoves a0@(12),fp1
	fsubs a2@(144),fp1
	fmoves fp1,a0@(12)
	movel a2@(128),a0
	fadds a0@(28),fp0
	fmoves fp0,a0@(28)
	fnegs a2@(208),fp0
	fmoves fp0,sp@-
	clrl sp@-
	fmoves a2@(212),fp0
	fmoved #0r1.570796326794901,fp1
	fsubx fp0,fp1
	fmoves fp1,sp@-
	movel a2,sp@-
	jbsr _rotate__14Transformationfff
	fmoves a2@(200),fp2
	fsgldivs a2@(196),fp2
	fmovex fp2,fp1
	fsglmulw a2@(192),fp1
	movew a2@(192),d0
	extl d0
	negl d0
	fsglmull d0,fp2
	movel a2@(128),a0
	fmovex fp1,fp0
	fsglmuls a0@,fp0
	fmoves fp0,a0@+
	fmovex fp1,fp0
	fsglmuls a0@,fp0
	fmoves fp0,a0@+
	fmovex fp1,fp0
	fsglmuls a0@,fp0
	fmoves fp0,a0@+
	fsglmuls a0@,fp1
	fmoves fp1,a0@+
	fmovex fp2,fp0
	fsglmuls a0@,fp0
	fmoves fp0,a0@+
	fmovex fp2,fp0
	fsglmuls a0@,fp0
	fmoves fp0,a0@+
	fmovex fp2,fp0
	fsglmuls a0@,fp0
	fmoves fp0,a0@+
	fsglmuls a0@,fp2
	fmoves fp2,a0@+
	clrl a0@+
	clrl a0@+
	clrl a0@+
	clrl a0@
	fmoved #0r0.5000000000000005,fp1
	fmovex fp1,fp0
	fmulw a2@(192),fp0
	fmoves fp0,d1
	fmulw a2@(194),fp1
	fmoves fp1,d0
	movel a2@(128),a0
	fmoves a0@(12),fp1
	fadds d1,fp1
	fmoves fp1,a0@(12)
	movel a2@(128),a0
	fmoves a0@(28),fp0
	fadds d0,fp0
	fmoves fp0,a0@(28)
	clrb a2@(217)
	movel a5@(-16),a2
	fmovem a5@(-12),#0x20
	unlk a5
	rts
LC0:
	.ascii "\12-----------------------------------------\12\0"
LC1:
	.ascii "View size    %hd x %hd\12\0"
LC2:
	.ascii "World size   %0.2f x %0.2f\12\0"
LC3:
	.ascii "View zoom    %0.2f\12\0"
LC4:
	.ascii "View yaw     %0.2f\12\0"
LC5:
	.ascii "View over     %0.2f\12\0"
LC6:
	.ascii "View origin  [%0.2f, %0.2f]\12\0"
LC7:
	.ascii "Projected TL [%0.2f, %0.2f]\12\0"
LC8:
	.ascii "Projected TR [%0.2f, %0.2f]\12\0"
LC9:
	.ascii "Projected BL [%0.2f, %0.2f]\12\0"
LC10:
	.ascii "Projected BR [%0.2f, %0.2f]\12\0"
LC11:
	.ascii "-----------------------------------------\12\12\0"
	.even
.globl _debugPrint__9WorldView
_debugPrint__9WorldView:
	link a5,#-48
	fmovem #0x4,sp@-
	moveml #0x38,sp@-
	movel a5@(8),a4
	tstb a4@(216)
	jeq L1056
	movel a4,sp@-
	jbsr _projectViewOnMap__9WorldView
	addql #4,sp
L1056:
	tstb a4@(217)
	jeq L1057
	movel a4,sp@-
	jbsr _buildTransformation__9WorldView
	addql #4,sp
L1057:
	pea LC0
	lea _printf,a2
	jbsr a2@
	movew a4@(194),a0
	movel a0,sp@-
	movew a4@(192),a0
	movel a0,sp@-
	pea LC1
	jbsr a2@
	fmoves a4@(212),fp0
	fmoved fp0,sp@-
	jbsr _sin
	fmoves a4@(156),fp0
	faddx fp0,fp0
	fmoves a4@(204),fp1
	fmulx fp1,fp0
	movel d1,sp@-
	movel d0,sp@-
	fmoved sp@+,fp2
	fdivx fp2,fp0
	fmoved fp0,sp@-
	fmoves a4@(152),fp0
	faddx fp0,fp0
	fmulx fp1,fp0
	fmoved fp0,sp@-
	pea LC2
	jbsr a2@
	addw #44,sp
	fmoves a4@(200),fp0
	fmoved fp0,sp@-
	pea LC3
	jbsr a2@
	fmoves a4@(208),fp0
	fmoved #0r57.29577951308238,fp2
	fmulx fp2,fp0
	fmoved fp0,sp@-
	pea LC4
	jbsr a2@
	fmoves a4@(212),fp0
	fmulx fp2,fp0
	fmoved fp0,sp@-
	pea LC5
	jbsr a2@
	addw #36,sp
	fmoves a4@(148),fp2
	fmoved fp2,sp@-
	fmoves a4@(144),fp0
	fmoved fp0,sp@-
	pea LC6
	jbsr a2@
	fmoves a4@(164),fp2
	fmoved fp2,sp@-
	fmoves a4@(160),fp0
	fmoved fp0,sp@-
	pea LC7
	jbsr a2@
	addw #40,sp
	fmoves a4@(172),fp2
	fmoved fp2,sp@-
	fmoves a4@(168),fp0
	fmoved fp0,sp@-
	pea LC8
	jbsr a2@
	fmoves a4@(180),fp2
	fmoved fp2,sp@-
	fmoves a4@(176),fp0
	fmoved fp0,sp@-
	pea LC9
	jbsr a2@
	addw #40,sp
	fmoves a4@(188),fp2
	fmoved fp2,sp@-
	fmoves a4@(184),fp0
	fmoved fp0,sp@-
	pea LC10
	jbsr a2@
	movel a4,sp@-
	jbsr _debugPrint__14Transformation
	pea LC11
	jbsr a2@
	lea a5@(-48),a3
	movel a4@(164),d0
	addw #28,sp
	movel a4@(160),a3@
	movel d0,a5@(-44)
	clrl a5@(-40)
	movel a4@(172),d0
	movel __8WorldMap$scaledD,d1
	movel a4@(168),a5@(-36)
	movel d0,a5@(-32)
	movel d1,a5@(-28)
	movel a4@(180),d0
	movel a4@(176),a5@(-24)
	movel d0,a5@(-20)
	clrl a5@(-16)
	movel a4@(188),d0
	movel a4@(184),a5@(-12)
	movel d0,a5@(-8)
	movel d1,a5@(-4)
	pea 4:w
	movel a3,sp@-
	movel a4,sp@-
	jbsr _transform__14TransformationP8Vector3DUl
	addw #12,sp
	lea _debugPrint__8Vector3D,a2
	movel a3,sp@-
	jbsr a2@
	addql #4,sp
	pea a5@(-36)
	jbsr a2@
	addql #4,sp
	pea a5@(-24)
	jbsr a2@
	addql #4,sp
	pea a5@(-12)
	jbsr a2@
	moveml a5@(-72),#0x1c00
	fmovem a5@(-60),#0x20
	unlk a5
	rts
