#NO_APP
.text
LC0:
	.ascii "bad_alloc\0"
.globl __8WorldMap$map
.data
	.even
__8WorldMap$map:
	.long 0
.globl __8WorldMap$scale
	.even
__8WorldMap$scale:
	.long 0x0
.globl __8WorldMap$scaledW
	.even
__8WorldMap$scaledW:
	.long 0x0
.globl __8WorldMap$scaledH
	.even
__8WorldMap$scaledH:
	.long 0x0
.globl __8WorldMap$scaledD
	.even
__8WorldMap$scaledD:
	.long 0x0
.globl __8WorldMap$width
	.even
__8WorldMap$width:
	.word 0
.globl __8WorldMap$height
	.even
__8WorldMap$height:
	.word 0
.globl __8WorldMap$dimW
__8WorldMap$dimW:
	.byte 0
.globl __8WorldMap$dimH
__8WorldMap$dimH:
	.byte 0
.globl __8WorldMap$depth
__8WorldMap$depth:
	.byte 1
.globl __8WorldMap$markVal
__8WorldMap$markVal:
	.byte 0
.text
LC1:
	.ascii "WorldMap::init(%0.2f, %hu,%hu,%hu)\12\0"
LC2:
	.ascii "\11already initialised\12\0"
LC3:
	.ascii "\11bad parameters\12\0"
LC4:
	.ascii "\11failed to allocate %ld bytes for map data\12\0"
LC5:
	.ascii "\11initialising extrinsic data [%ld cells]\12\0"
LC6:
	.ascii "\11OK\12\12\0"
	.even
.globl _init__8WorldMapfUsUsUs
_init__8WorldMapfUsUsUs:
	link a5,#-4
	fmovem #0xc,sp@-
	moveml #0x3f3a,sp@-
	fmoves a5@(8),fp2
	movel a5@(12),d1
	movel a5@(16),d0
	movel a5@(20),d3
	movew d1,d2
	movew d0,d4
	movew d3,d5
	movew d3,sp@-
	clrw sp@-
	movew d0,sp@-
	clrw sp@-
	movew d1,sp@-
	clrw sp@-
	fmoved fp2,sp@-
	pea LC1
	lea _printf,a2
	jbsr a2@
	addw #24,sp
	movel __8WorldMap$map,d6
	movel a2,a4
	jeq L1023
	pea LC2
	jbsr a4@
	movel #-50659332,d0
	jra L1037
	.even
L1023:
	fcmps #0r1,fp2
	fjlt L1025
	fcmps #0r128,fp2
	fjgt L1025
	cmpw #3,d2
	jls L1025
	cmpw #8,d2
	jhi L1025
	cmpw #3,d4
	jls L1025
	cmpw #8,d4
	jhi L1025
	tstw d3
	jeq L1025
	cmpw #1,d5
	jls L1024
L1025:
	pea LC3
	jbsr a4@
	movel #-50397189,d0
	jra L1037
	.even
L1024:
	fmoves fp2,__8WorldMap$scale
	moveb d2,__8WorldMap$dimW
	moveb d4,__8WorldMap$dimH
	moveb d5,__8WorldMap$depth
	clrl d0
	moveb d2,d0
	moveq #1,d1
	movel d1,d2
	lsll d0,d2
	movew d2,__8WorldMap$width
	clrl d0
	moveb d4,d0
	lsll d0,d1
	movew d1,__8WorldMap$height
	clrl d0
	movew d2,d0
	fmovex fp2,fp0
	fsglmull d0,fp0
	fmoves fp0,__8WorldMap$scaledW
	clrl d0
	movew d1,d0
	fmovex fp2,fp3
	fsglmull d0,fp3
	fmoves fp3,__8WorldMap$scaledH
	clrl d0
	moveb d5,d0
	fsglmull d0,fp2
	fmoves fp2,__8WorldMap$scaledD
	movew d2,d3
	mulu d1,d3
	mulsl d0,d3
	clrl sp@-
	subql #2,sp
	moveb #1,sp@(1)
	subql #2,sp
	movel d3,d2
	lsll #4,d2
	movel d2,sp@-
	jbsr _alloc__3MemUlbQ23Mem9AlignType
	movel d0,__8WorldMap$map
	addw #12,sp
	jne L1026
	movel d2,sp@-
	pea LC4
	jbsr a4@
	jbsr _done__8WorldMap
	movel #-50528257,d0
	jra L1037
	.even
L1026:
	movel d3,sp@-
	pea LC5
	jbsr a4@
	movel __8WorldMap$map,d4
	movew __8WorldMap$height,d2
	movew d2,d1
	subqw #1,d1
	clrw d3
	addql #8,sp
	clrl d0
	movew d2,d0
	cmpl d6,d0
	jle L1028
	lea 0:w,a6
	clrl d7
	movew __8WorldMap$width,a5@(-2)
	fmoves __8WorldMap$scale,fp2
	movew d2,a3
	movew d1,a2
	clrl d6
	.even
L1030:
	clrw d0
	movew a5@(-2),d7
	movew d3,d2
	addqw #1,d2
	cmpl a6,d7
	jle L1029
	fmovex fp2,fp1
	movel a2,a0
	subw d3,a0
	fmovex fp1,fp0
	movel a0,d1
	fsglmull d1,fp0
	clrl d1
	movew a5@(-2),d3
	movel d4,a1
	.even
L1034:
	fmovex fp1,fp3
	fsglmulw d0,fp3
	fmoves fp3,a1@
	fmoves fp0,a1@(4)
	clrl a1@(8)
	clrw a1@(12)
	clrw a1@(14)
	addw #16,a1
	moveq #16,d5
	addl d5,d4
	addqw #1,d0
	movew d0,a0
	movew d3,d1
	cmpl a0,d1
	jgt L1034
L1029:
	movew d2,d3
	movew d3,a0
	movew a3,d6
	cmpl a0,d6
	jgt L1030
L1028:
	pea LC6
	jbsr a4@
	clrl d0
L1037:
	moveml a5@(-68),#0x5cfc
	fmovem a5@(-28),#0x30
	unlk a5
	rts
LC7:
	.ascii "WorldMap::done()\12\11OK\12\12\0"
	.even
.globl _done__8WorldMap
_done__8WorldMap:
	pea a5@
	movel sp,a5
	movel __8WorldMap$map,d0
	jeq L1041
	movel d0,sp@-
	jbsr _free__3MemPv
	addql #4,sp
L1041:
	pea LC7
	jbsr _printf
	unlk a5
	rts
	.even
.globl _getRowOrdered__8WorldMapPP15MapCellInstancessss
_getRowOrdered__8WorldMapPP15MapCellInstancessss:
	link a5,#-4
	moveml #0x3f3a,sp@-
	movel a5@(8),a4
	movew a5@(14),a2
	movew a5@(18),d2
	movew a5@(22),a3
	movew a5@(26),d1
	movew d2,a1
	clrl d0
	moveb __8WorldMap$dimW,d0
	movel a1,d3
	lsll d0,d3
	movel d3,a1
	movew d1,d7
	extl d7
	lsll d0,d7
	lea a1@(a2:w),a0
	movel a0,d0
	lsll #4,d0
	movel __8WorldMap$map,a0
	addl d0,a0
	movew a3,d3
	subw a2,d3
	subw d2,d1
	tstw d3
	jge L1043
	negw d3
	movew #-1,a5@(-2)
	jra L1044
	.even
L1043:
	movew #1,a5@(-2)
L1044:
	tstw d1
	jge L1045
	negw d1
	movew __8WorldMap$width,d5
	negw d5
	jra L1046
	.even
L1045:
	movew __8WorldMap$width,d5
L1046:
	clrw d0
	moveb __8WorldMap$markVal,d0
	cmpw a0@(12),d0
	jeq L1047
	movel a0,a4@+
L1047:
	lslw #1,d3
	lslw #1,d1
	cmpw d3,d1
	jge L1048
	movew d3,d0
	asrw #1,d0
	movew d1,d2
	subw d0,d2
	movew a3,d0
	cmpw a2,d0
	jeq L1056
	movew a5@(-2),d7
	extl d7
	clrw d6
	movew d5,a6
	clrw d4
	.even
L1051:
	tstw d2
	jlt L1052
	lea a1@(a2:w),a0
	movel a0,d0
	addl d7,d0
	lsll #4,d0
	movel __8WorldMap$map,a0
	addl d0,a0
	moveb __8WorldMap$markVal,d6
	cmpw a0@(12),d6
	jeq L1053
	movel a0,a4@+
L1053:
	addl a6,a1
	subw d3,d2
L1052:
	addw a5@(-2),a2
	addw d1,d2
	lea a1@(a2:w),a0
	movel a0,d0
	lsll #4,d0
	movel __8WorldMap$map,a0
	addl d0,a0
	moveb __8WorldMap$markVal,d4
	cmpw a0@(12),d4
	jeq L1049
	movel a0,a4@+
L1049:
	movew a3,d0
	cmpw a2,d0
	jne L1051
	jra L1056
	.even
L1048:
	movew d1,d0
	asrw #1,d0
	movew d3,d2
	subw d0,d2
	cmpl a1,d7
	jeq L1056
	movew d5,a6
	clrw d6
	clrw d4
	.even
L1059:
	movew d5,a3
	tstw d2
	jlt L1060
	lea a1@(a2:w),a0
	movel a0,d0
	addl a6,d0
	lsll #4,d0
	movel __8WorldMap$map,a0
	addl d0,a0
	moveb __8WorldMap$markVal,d6
	cmpw a0@(12),d6
	jeq L1061
	movel a0,a4@+
L1061:
	addw a5@(-2),a2
	subw d1,d2
L1060:
	addl a3,a1
	addw d3,d2
	lea a1@(a2:w),a0
	movel a0,d0
	lsll #4,d0
	movel __8WorldMap$map,a0
	addl d0,a0
	moveb __8WorldMap$markVal,d4
	cmpw a0@(12),d4
	jeq L1057
	movel a0,a4@+
L1057:
	cmpl a1,d7
	jne L1059
L1056:
	movel a4,d0
	moveml sp@+,#0x5cfc
	unlk a5
	rts
LC8:
	.ascii "WorldMap::markArea({{%0.2f,%0.2f},{%0.2f,%0.2f},{%0.2f,%0.2f},{%0.2f,%0.2f}})\12\0"
LC9:
	.ascii "\11Marked %ld\12\11OK\12\12\0"
	.even
.globl _getAreaOrdered__8WorldMapPP15MapCellInstancePC7Coord2D
_getAreaOrdered__8WorldMapPP15MapCellInstancePC7Coord2D:
	link a5,#-8
	moveml #0x3f3a,sp@-
	movel a5@(12),a2
	fmoves a2@(28),fp0
	fmoved fp0,sp@-
	fmoves a2@(24),fp0
	fmoved fp0,sp@-
	fmoves a2@(20),fp0
	fmoved fp0,sp@-
	fmoves a2@(16),fp0
	fmoved fp0,sp@-
	fmoves a2@(12),fp0
	fmoved fp0,sp@-
	fmoves a2@(8),fp0
	fmoved fp0,sp@-
	fmoves a2@(4),fp0
	fmoved fp0,sp@-
	fmoves a2@,fp0
	fmoved fp0,sp@-
	pea LC8
	lea _printf,a3
	jbsr a3@
	fmoves __8WorldMap$scale,fp0
	fmoved #0r1.000000000000005,fp1
	fdivx fp0,fp1
	fmoves fp1,d0
	fmoves d0,fp1
	fmovex fp1,fp0
	fsglmuls a2@,fp0
	movel #0x3f000000,d3
	fadds d3,fp0
	fmoveml fpcr,d1
	moveq #16,d2
	orl d1,d2
	andw #-33,d2
	fmoveml d2,fpcr
	fmovew fp0,d6
	fmoveml d1,fpcr
	fmovex fp1,fp0
	fsglmuls a2@(4),fp0
	movel #0x3fc00000,d2
	fadds d2,fp0
	fmoveml fpcr,d4
	moveq #16,d5
	orl d4,d5
	andw #-33,d5
	fmoveml d5,fpcr
	fmovew fp0,d0
	fmoveml d4,fpcr
	movew __8WorldMap$height,a1
	movew a1,d4
	subw d0,d4
	fmovex fp1,fp0
	fsglmuls a2@(8),fp0
	fadds d3,fp0
	fmoveml fpcr,d7
	moveq #16,d0
	orl d7,d0
	andw #-33,d0
	fmoveml d0,fpcr
	fmovew fp0,d1
	fmoveml d7,fpcr
	fmovex fp1,fp0
	fsglmuls a2@(12),fp0
	fadds d2,fp0
	fmoveml fpcr,d7
	moveq #16,d0
	orl d7,d0
	andw #-33,d0
	fmoveml d0,fpcr
	fmovew fp0,d5
	fmoveml d7,fpcr
	movew d5,a0
	movew a1,d5
	subw a0,d5
	fmovex fp1,fp0
	fsglmuls a2@(16),fp0
	fadds d3,fp0
	fmoveml fpcr,d3
	moveq #16,d7
	orl d3,d7
	andw #-33,d7
	fmoveml d7,fpcr
	fmovew fp0,a5@(-2)
	fmoveml d3,fpcr
	fsglmuls a2@(20),fp1
	fadds d2,fp1
	fmovex fp1,fp0
	fmoveml fpcr,d2
	moveq #16,d3
	orl d2,d3
	andw #-33,d3
	fmoveml d3,fpcr
	fmovew fp0,d0
	fmoveml d2,fpcr
	movew a1,a6
	subw d0,a6
	movew a5@(-2),d7
	subw d6,d7
	movew a6,d3
	subw d4,d3
	addw #68,sp
	tstw d7
	jge L1067
	negw d7
	movew #-1,a4
	jra L1068
	.even
L1067:
	movew #1,a4
L1068:
	tstw d3
	jge L1069
	negw d3
	movew #-1,a3
	jra L1070
	.even
L1069:
	movew #1,a3
L1070:
	addqb #1,__8WorldMap$markVal
	movew d5,a0
	movel a0,sp@-
	movew d1,a1
	movel a1,sp@-
	movew d4,a0
	movel a0,sp@-
	movew d6,a1
	movel a1,sp@-
	movel a5@(8),sp@-
	lea _getRowOrdered__8WorldMapPP15MapCellInstancessss,a2
	movel d1,a5@(-6)
	jbsr a2@
	movel d0,a0
	lslw #1,d7
	lslw #1,d3
	addw #20,sp
	movel a5@(-6),d1
	cmpw d7,d3
	jge L1071
	movew d7,d0
	asrw #1,d0
	movew d3,d2
	subw d0,d2
	cmpw a5@(-2),d6
	jeq L1077
	.even
L1074:
	tstw d2
	jlt L1075
	addw a3,d4
	addw a3,d5
	subw d7,d2
L1075:
	addw a4,d6
	addw a4,d1
	addw d3,d2
	movew d5,a1
	movel a1,sp@-
	movew d1,a1
	movel a1,sp@-
	movew d4,a1
	movel a1,sp@-
	movew d6,a1
	movel a1,sp@-
	movel a0,sp@-
	movel d1,a5@(-6)
	jbsr a2@
	movel d0,a0
	addw #20,sp
	movel a5@(-6),d1
	cmpw a5@(-2),d6
	jne L1074
	jra L1077
	.even
L1071:
	movew d3,d0
	asrw #1,d0
	movew d7,d2
	subw d0,d2
	cmpw a6,d4
	jeq L1077
	.even
L1080:
	tstw d2
	jlt L1081
	addw a4,d6
	addw a4,d1
	subw d3,d2
L1081:
	addw a3,d4
	addw a3,d5
	addw d7,d2
	movew d5,a1
	movel a1,sp@-
	movew d1,a1
	movel a1,sp@-
	movew d4,a1
	movel a1,sp@-
	movew d6,a1
	movel a1,sp@-
	movel a0,sp@-
	movel d1,a5@(-6)
	jbsr a2@
	movel d0,a0
	addw #20,sp
	movel a5@(-6),d1
	cmpw a6,d4
	jne L1080
L1077:
	clrl a0@
	movel a0,d2
	subl a5@(8),d2
	asrl #2,d2
	movel d2,sp@-
	pea LC9
	jbsr _printf
	movel d2,d0
	moveml a5@(-48),#0x5cfc
	unlk a5
	rts
	.even
.globl _getCellAtPosition__8WorldMapRC8Vector3D
_getCellAtPosition__8WorldMapRC8Vector3D:
	pea a5@
	movel sp,a5
	fmovem #0xc,sp@-
	moveml #0x3800,sp@-
	movel a5@(8),a0
	movel __8WorldMap$map,a1
	tstl a1
	jeq L1088
	fmoves a0@,fp3
	fmovex fp3,fp0
	fjlt L1088
	fcmps __8WorldMap$scaledW,fp3
	fjgt L1088
	fmoves a0@(4),fp2
	fmovex fp2,fp0
	fcmpd #0r0.000000000000005,fp0
	fjlt L1088
	fcmps __8WorldMap$scaledH,fp2
	fjgt L1088
	fmoves a0@(8),fp1
	fmovex fp1,fp0
	fcmpd #0r0.000000000000005,fp0
	fjlt L1088
	fcmps __8WorldMap$scaledD,fp1
	fjle L1087
L1088:
	clrl d0
	jra L1089
	.even
L1087:
	fmoves __8WorldMap$scale,fp0
	fmoved #0r1.000000000000005,fp1
	fdivx fp0,fp1
	fmoves fp1,d2
	clrl d0
	movew __8WorldMap$height,d0
	fsglmuls d2,fp2
	fmovex fp2,fp0
	faddd #0r1.500000000000005,fp0
	fmoveml fpcr,d3
	moveq #16,d4
	orl d3,d4
	andw #-33,d4
	fmoveml d4,fpcr
	fmovel fp0,d1
	fmoveml d3,fpcr
	subl d1,d0
	clrl d1
	moveb __8WorldMap$dimW,d1
	lsll d1,d0
	fsglmuls d2,fp3
	fmoves fp3,d2
	fmoves d2,fp0
	faddd #0r0.5000000000000005,fp0
	fmoveml fpcr,d2
	moveq #16,d3
	orl d2,d3
	andw #-33,d3
	fmoveml d3,fpcr
	fmovel fp0,d1
	fmoveml d2,fpcr
	addl d1,d0
	lsll #4,d0
	addl a1,d0
L1089:
	moveml sp@+,#0x1c
	fmovem sp@+,#0x30
	unlk a5
	rts
	.even
.globl _createView__8WorldMapssf
_createView__8WorldMapssf:
	pea a5@
	movel sp,a5
	movel a5@(8),d0
	movel a5@(12),d1
	fmoves a5@(16),fp0
	movew d0,a1
	movew d1,a0
	tstl __8WorldMap$map
	jeq L1092
	tstw d0
	jle L1092
	tstw d1
	jle L1092
	fcmps __8WorldMap$scale,fp0
	fjge L1091
L1092:
	clrl d0
	jra L1093
	.even
L1091:
	fmoves fp0,sp@-
	movew a0,a0
	movel a0,sp@-
	movew a1,a1
	movel a1,sp@-
	pea _nothrow
	pea 218:w
	jbsr ___nw__FUlRC9nothrow_t
	addqw #4,sp
	movel d0,sp@
	jbsr ___9WorldViewssf
L1093:
	unlk a5
	rts
