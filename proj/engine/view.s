#NO_APP
.text
	.even
.globl ___4Viewssfffff
___4Viewssfffff:
	pea a5@
	movel sp,a5
	fmovem #0x4,sp@-
	movel a5@(8),a1
	movel a5@(12),d0
	movel a5@(16),d1
	fmoves a5@(24),fp2
	fmoves a5@(32),fp1
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
	movew d0,a1@(192)
	movew d1,a1@(194)
	movel a5@(20),a1@(196)
	fmoves fp2,a1@(200)
	movel a5@(28),a1@(204)
	fmoves fp1,a1@(208)
	movel a5@(36),a1@(212)
	fmovew d0,fp0
	fsgldivw d1,fp0
	fmoves fp0,a1@(220)
	fcmpx fp1,fp2
	fjle L1024
	fmoves fp2,a1@(208)
	fmoves fp1,a1@(200)
	.even
L1024:
	fmoves a1@(204),fp0
	movel a1@(212),d0
	fcmps d0,fp0
	fjle L1025
	fmoves fp0,a1@(212)
	movel d0,a1@(204)
L1025:
	fmoves a1@(200),fp0
	fadds a1@(208),fp0
	fmoved #0r0.5000000000000005,fp1
	fmulx fp1,fp0
	fmoves fp0,a1@(144)
	fmoves a1@(204),fp0
	fadds a1@(212),fp0
	fmulx fp1,fp0
	fmoves fp0,a1@(148)
	fmovex fp1,fp0
	fmulw a1@(192),fp0
	fmoves fp0,a1@(152)
	fmulw a1@(194),fp1
	fmoves fp1,a1@(156)
	movel a1,d0
	fmovem sp@+,#0x20
	unlk a5
	rts
	.even
.globl __$_4View
__$_4View:
	pea a5@
	movel sp,a5
	btst #0,a5@(15)
	jeq L1038
	movel a5@(8),sp@-
	jbsr ___builtin_delete
L1038:
	unlk a5
	rts
	.even
.globl _set__4Viewfffff
_set__4Viewfffff:
	pea a5@
	movel sp,a5
	fmovem #0x4,sp@-
	movel a5@(8),a0
	movel a5@(28),d0
	fmoves a5@(12),fp2
	fmoves a0@(200),fp0
	fmoves a0@(208),fp1
	fcmpx fp0,fp2
	fjlt L1042
	fmovex fp2,fp0
	fcmpx fp1,fp0
	fjle L1042
	fmovex fp1,fp0
L1042:
	fmoves fp0,a0@(144)
	fmoves a5@(16),fp2
	fmoves a0@(204),fp0
	fmoves a0@(212),fp1
	fcmpx fp0,fp2
	fjlt L1047
	fmovex fp2,fp0
	fcmpx fp1,fp0
	fjle L1047
	fmovex fp1,fp0
L1047:
	fmoves fp0,a0@(148)
	fmoves d0,fp0
	fcmpd #0r10.00000000000005,fp0
	fjlt L1050
	fcmpd #0r90.00000000000005,fp0
	fjle L1052
	fmoved #0r90.00000000000005,fp0
	jra L1052
	.even
L1050:
	fmoved #0r10.00000000000005,fp0
L1052:
	fmoves fp0,d0
	movel a5@(20),a0@(216)
	fmoves a5@(24),fp0
	fmoved #0r0.01745329251994334,fp1
	fmulx fp1,fp0
	fmoves fp0,a0@(224)
	fmoves d0,fp0
	fmulx fp1,fp0
	fmoves fp0,a0@(228)
	movel a0,sp@-
	jbsr _project__4View
	fmovem a5@(-12),#0x20
	unlk a5
	rts
	.even
.globl _project__4View
_project__4View:
	pea a5@
	movel sp,a5
	fmovem #0x1c,sp@-
	moveml #0x3030,sp@-
	movel a5@(8),a2
	fmoves a2@(224),fp0
	fmoved fp0,sp@-
	jbsr _cos
	movel d1,sp@-
	movel d0,sp@-
	fmoved sp@+,fp0
	fmoves fp0,d3
	fmoves a2@(224),fp0
	fmoved fp0,sp@-
	lea _sin,a3
	jbsr a3@
	movel d1,sp@-
	movel d0,sp@-
	fmoved sp@+,fp0
	fmoves fp0,d2
	fmoves a2@(196),fp2
	fsglmuls a2@(216),fp2
	fmoves a2@(228),fp0
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
	moveml a5@(-52),#0xc0c
	fmovem a5@(-36),#0x38
	unlk a5
	rts
LC0:
	.ascii "XY [%0.2f, %0.2f]\12\0"
LC1:
	.ascii "TL [%0.2f, %0.2f]\12\0"
LC2:
	.ascii "TR [%0.2f, %0.2f]\12\0"
LC3:
	.ascii "BL [%0.2f, %0.2f]\12\0"
LC4:
	.ascii "BR [%0.2f, %0.2f]\12\0"
	.even
.globl _debugPrint__4View
_debugPrint__4View:
	pea a5@
	movel sp,a5
	movel a3,sp@-
	movel a2,sp@-
	movel a5@(8),a2
	fmoves a2@(148),fp0
	fmoved fp0,sp@-
	fmoves a2@(144),fp0
	fmoved fp0,sp@-
	pea LC0
	lea _printf,a3
	jbsr a3@
	fmoves a2@(164),fp0
	fmoved fp0,sp@-
	fmoves a2@(160),fp0
	fmoved fp0,sp@-
	pea LC1
	jbsr a3@
	addw #40,sp
	fmoves a2@(172),fp0
	fmoved fp0,sp@-
	fmoves a2@(168),fp0
	fmoved fp0,sp@-
	pea LC2
	jbsr a3@
	fmoves a2@(180),fp0
	fmoved fp0,sp@-
	fmoves a2@(176),fp0
	fmoved fp0,sp@-
	pea LC3
	jbsr a3@
	addw #40,sp
	fmoves a2@(188),fp0
	fmoved fp0,sp@-
	fmoves a2@(184),fp0
	fmoved fp0,sp@-
	pea LC4
	jbsr a3@
	movel a5@(-8),a2
	movel a5@(-4),a3
	unlk a5
	rts
