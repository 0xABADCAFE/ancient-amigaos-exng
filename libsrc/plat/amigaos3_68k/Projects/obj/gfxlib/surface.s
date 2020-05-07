#NO_APP
.text
LC0:
	.ascii "bad_alloc\0"
	.even
.globl _blitCopy__7SurfaceP7SurfacessT1ssss
_blitCopy__7SurfaceP7SurfacessT1ssss:
	link a5,#-8
	moveml #0x3f3a,sp@-
	movel a5@(8),d2
	movel a5@(12),a5@(-4)
	movel a5@(16),a5@(-8)
	movel a5@(20),d7
	movel a5@(24),d0
	movel a5@(28),d1
	movel a5@(32),d3
	movel a5@(36),d4
	movew a5@(-2),a2
	movew a5@(-6),a3
	movew d0,d6
	movew d1,d5
	movew d3,a6
	movew d4,a4
	tstl d2
	jeq L895
	tstl d7
	jeq L895
	movel d2,a0
	tstl a0@(12)
	jne L894
L895:
	movel #-50462722,d0
	jra L907
	.even
L894:
	movel d7,a1
	movel a1@(36),a0
	movel d2,a1
	cmpl a1@(36),a0
	jeq L896
	movel #-50659331,d0
	jra L907
	.even
L896:
	tstw d0
	jlt L898
	tstw d1
	jlt L898
	tstw d3
	jle L898
	tstw d4
	jgt L897
L898:
	movel #-50397188,d0
	jra L907
	.even
L897:
	movew a6,d1
	extl d1
	movel d1,a1
	lea a1@(d6:w),a1
	movel a1,d0
	movel d7,a1
	movew a1@,a0
	cmpl d0,a0
	jlt L900
	movew a4,d0
	extl d0
	movel d0,a0
	lea a0@(d5:w),a0
	movel a0,d3
	movew a1@(2),a0
	cmpl d3,a0
	jge L899
L900:
	movel #-50397186,d0
	jra L907
	.even
L899:
	movel d2,a1
	movew a1@,d3
	cmpw a2,d3
	jle L908
	movew a1@(2),d4
	cmpw a3,d4
	jle L908
	movel d1,a1
	lea a1@(a2:w),a0
	tstl a0
	jle L908
	movel d0,a1
	lea a1@(a3:w),a0
	tstl a0
	jle L908
	tstw a5@(-2)
	jge L903
	addw a2,a6
	subw a2,d6
	subl a2,a2
L903:
	movew a2,d0
	extl d0
	movel d0,a0
	lea a0@(a6:w),a0
	movel a0,d1
	movel d2,a1
	movew a1@,a0
	cmpl d1,a0
	jge L904
	movew d3,a6
	subw a2,a6
L904:
	tstw a5@(-6)
	jge L905
	addw a3,a4
	subw a3,d5
	subl a3,a3
L905:
	movew a3,a2
	lea a2@(a4:w),a0
	movel a0,d1
	movel d2,a1
	movew a1@(2),a0
	cmpl d1,a0
	jge L906
	movew d4,a4
	subw a3,a4
L906:
	clrl sp@-
	pea 255:w
	pea 192:w
	movew a4,a4
	movel a4,sp@-
	movew a6,a6
	movel a6,sp@-
	movel a2,sp@-
	movel d0,sp@-
	movel d2,a0
	movel a0@(12),sp@-
	movew d5,a1
	movel a1,sp@-
	movew d6,a0
	movel a0,sp@-
	movel d7,a1
	movel a1@(12),sp@-
	jbsr _BltBitMap
L908:
	clrl d0
L907:
	moveml a5@(-48),#0x5cfc
	unlk a5
	rts
	.even
.globl _putImageBuffer__7SurfaceP11ImageBufferssssss
_putImageBuffer__7SurfaceP11ImageBufferssssss:
	link a5,#-12
	moveml #0x3f3a,sp@-
	movel a5@(8),a6
	movel a5@(16),a5@(-4)
	movel a5@(20),a5@(-8)
	movel a5@(24),d0
	movel a5@(28),d1
	movel a5@(32),d3
	movel a5@(36),d5
	movew a5@(-2),a2
	movew a5@(-6),d2
	movew d0,d6
	movew d1,d7
	movew d3,a3
	movew d5,d4
	tstl a6@(12)
	jeq L911
	tstl a5@(12)
	jeq L911
	movel a5@(12),a0
	movel a0@(8),a5@(-12)
	jne L910
L911:
	movel #-50462722,d0
	jra L938
	.even
L910:
	tstw d0
	jlt L914
	tstw d1
	jlt L914
	tstw d3
	jle L914
	tstw d5
	jgt L913
L914:
	movel #-50397188,d0
	jra L938
	.even
L913:
	movew a3,d0
	extl d0
	movel d0,a1
	lea a1@(d6:w),a0
	movel a5@(12),a1
	movew a1@,d5
	extl d5
	cmpl a0,d5
	jlt L916
	movew d4,a4
	lea a4@(d7:w),a0
	movel a0,d1
	movew a1@(2),a0
	cmpl d1,a0
	jge L915
L916:
	movel #-50397186,d0
	jra L938
	.even
L915:
	movew a6@,d1
	cmpw a2,d1
	jle L934
	movew a6@(2),d3
	cmpw d2,d3
	jle L934
	movel d0,a1
	lea a1@(a2:w),a0
	tstl a0
	jle L934
	lea a4@(d2:w),a0
	tstl a0
	jle L934
	tstw a5@(-2)
	jge L921
	addw a2,a3
	subw a2,d6
	subl a2,a2
L921:
	movew a2,a4
	lea a4@(a3:w),a1
	movew a6@,a0
	cmpl a1,a0
	jge L922
	movew d1,a3
	subw a2,a3
L922:
	tstw a5@(-6)
	jge L923
	addw d2,d4
	subw d2,d7
	clrw d2
L923:
	movew d4,a0
	lea a0@(d2:w),a1
	movew a6@(2),a0
	cmpl a1,a0
	jge L924
	movew d3,d4
	subw d2,d4
L924:
	movel a5@(12),a0
	movel a0@(20),a2
	movel a6@(36),a1
	lea a1@(a1:l:2),a0
	movel a0,d0
	lsll #2,d0
	movel d0,a0
	addl #__15PixelDescriptor$propTab,a0
	clrl d1
	moveb a0@,d1
	movew d2,d0
	muls a6@(28),d0
	movel a4,d3
	addl d0,d3
	mulsl d1,d3
	lea a2@(a2:l:2),a0
	movel a0,d0
	lsll #2,d0
	movel d0,a0
	addl #__15PixelDescriptor$propTab,a0
	clrl d1
	moveb a0@,d1
	movew d7,d0
	extl d0
	mulsl d5,d0
	movel d0,a0
	lea a0@(d6:w),a0
	movel a0,d2
	mulsl d1,d2
	tstl a6@(20)
	jeq L932
	movel a5@(12),a0
	movel a0@(12),sp@-
	movel d5,sp@-
	movew a6@(28),a0
	movel a0,sp@-
	movew d4,a0
	movel a0,sp@-
	movew a3,a3
	movel a3,sp@-
	movel a2,sp@-
	movel a1,sp@-
	movel a5@(-12),a1
	pea a1@(d2:l)
	addl a6@(16),d3
	movel d3,sp@-
	jbsr _convertPixels__6_Nat2DPvT1Q25Pixel6HWTypeT3ssssP7Palette
	jra L934
	.even
L932:
	movel a6,sp@-
	jbsr _lockData__7Surface
	movel d0,a0
	addql #4,sp
	tstl a0
	jne L935
	movel #-50659333,d0
	jra L938
	.even
L935:
	movel a5@(12),a1
	movel a1@(12),sp@-
	movel d5,sp@-
	movew a6@(28),a1
	movel a1,sp@-
	movew d4,a1
	movel a1,sp@-
	movew a3,a3
	movel a3,sp@-
	movel a2,sp@-
	movel a6@(36),sp@-
	movel a5@(-12),a1
	pea a1@(d2:l)
	pea a0@(d3:l)
	jbsr _convertPixels__6_Nat2DPvT1Q25Pixel6HWTypeT3ssssP7Palette
	addw #32,sp
	movel a6,sp@
	jbsr _unlockData__7Surface
L934:
	clrl d0
L938:
	moveml a5@(-52),#0x5cfc
	unlk a5
	rts
	.even
.globl _init__7Surface
_init__7Surface:
	pea a5@
	movel sp,a5
	movel a5@(8),a0
	clrw a0@
	clrw a0@(2)
	clrl a0@(8)
	clrl a0@(12)
	clrl a0@(16)
	clrl a0@(20)
	clrl a0@(24)
	clrw a0@(28)
	clrw a0@(30)
	clrw a0@(32)
	clrw a0@(34)
	moveq #15,d0
	movel d0,a0@(36)
	unlk a5
	rts
LC1:
	.ascii "\12[Surface not linear]\12\0"
	.even
.globl _queryBitMap__7Surface
_queryBitMap__7Surface:
	pea a5@
	movel sp,a5
	movel a3,sp@-
	movel a2,sp@-
	movel a5@(8),a3
	movel #-2147483643,sp@-
	movel a3@(12),sp@-
	lea _GetCyberMapAttr,a2
	jbsr a2@
	movew d0,a3@(28)
	movel #-2147483642,sp@-
	movel a3@(12),sp@-
	jbsr a2@
	movew d0,a3@(30)
	movel #-2147483641,sp@-
	movel a3@(12),sp@-
	jbsr a2@
	movew d0,a3@(34)
	movew a3@(28),d0
	subw a3@,d0
	movew d0,a3@(32)
	movel #-2147483639,sp@-
	movel a3@(12),sp@-
	jbsr a2@
	addw #32,sp
	tstl d0
	jeq L941
	moveq #4,d0
	orl d0,a3@(24)
	jra L942
	.even
L941:
	moveq #-5,d0
	andl d0,a3@(24)
	pea LC1
	jbsr _printf
	addql #4,sp
L942:
	movel #-2147483644,sp@-
	movel a3@(12),sp@-
	jbsr a2@
	lea __6_Nat2D$nativeToAbstract,a0
	movel a0@(d0:l:4),a3@(36)
	movel a5@(-8),a2
	movel a5@(-4),a3
	unlk a5
	rts
	.even
.globl _lockData__7Surface
_lockData__7Surface:
	link a5,#-16
	movel a3,sp@-
	movel a2,sp@-
	movel a5@(8),a3
	movel a3@(12),d0
	jeq L945
	tstl a3@(20)
	jeq L946
	movel a3@(16),d0
	jra L948
	.even
L946:
	movel #-2080370681,a5@(-16)
	lea a3@(16),a2
	movel a2,a5@(-12)
	clrl a5@(-8)
	clrl a5@(-4)
	pea a5@(-16)
	movel d0,sp@-
	jbsr _LockBitMapTagList
	movel d0,a3@(20)
	movel a2@,d0
	jra L948
	.even
L945:
	clrl d0
L948:
	movel a5@(-24),a2
	movel a5@(-20),a3
	unlk a5
	rts
	.even
.globl _unlockData__7Surface
_unlockData__7Surface:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel a5@(8),a2
	tstl a2@(12)
	jeq L950
	movel a2@(20),d0
	jeq L950
	movel d0,sp@-
	jbsr _UnLockBitMap
	clrl a2@(20)
L950:
	movel a5@(-4),a2
	unlk a5
	rts
	.even
.globl _create__7SurfacessP7Surface
_create__7SurfacessP7Surface:
	link a5,#-64
	fmovem #0xfc,sp@-
	moveml #0x3f3a,sp@-
	movew a5@(10),a5@(-50)
	movew a5@(14),a5@(-52)
	jbsr ___get_eh_context
	movel d0,d1
	tstl a5@(16)
	jeq L970
	movel a5@(16),a0
	tstl a0@(12)
	jeq L970
	pea _nothrow
	pea 42:w
	movel d1,a1
	addql #4,a1
	movel a1,a5@(-62)
	jbsr ___nw__FUlRC9nothrow_t
	movel d0,a5@(-56)
	moveb #1,a5@(-57)
	movel a5@(-62),a0
	movel a0@,a5@(-24)
	clrl a5@(-20)
	movel a5,a5@(-16)
	movel #L957,a5@(-12)
	movel sp,a5@(-8)
	jra L956
	.even
L957:
	jra L983
	.even
L956:
	lea a5@(-24),a1
	movel a1,a0@
	addql #8,sp
	moveq #40,d0
	addl a5@(-56),d0
	movel a5@(-56),a0
	movel d0,a0@(4)
	clrw a0@
	clrw a0@(2)
	movel a0,sp@-
	jbsr _init__7Surface
	addql #4,sp
	clrb a5@(-57)
	movel a5@(-62),a1
	movel a1@,a0
	movel a0@,a1@
	tstl a5@(-56)
	jeq L970
	movel a5@(16),a0
	movel a0@(12),sp@-
	movew a5@(-52),a1
	movel a1,sp@-
	movew a5@(-50),a0
	movel a0,sp@-
	movel a5@(-56),sp@-
	jbsr _create__7SurfacessPQ212AmigaOS3_68K6BitMap
	addw #16,sp
	tstl d0
	jne L968
	movel a5@(-56),d0
	jra L982
	.even
L968:
	movel a5@(-56),sp@-
	jbsr _destroy__7Surface
	movel a5@(-56),sp@
	jbsr ___builtin_delete
L970:
	clrl d0
	jra L982
	.even
L983:
L954:
	movel a5@(-62),a1
	movel a1@,a5@(-48)
	clrl a5@(-44)
	movel a5,a5@(-40)
	movel #L978,a5@(-36)
	movel sp,a5@(-32)
	jra L977
	.even
L978:
	jra L984
	.even
L977:
	lea a5@(-48),a1
	movel a5@(-62),a0
	movel a1,a0@
	tstb a5@(-57)
	jeq L980
	pea _nothrow
	movel a5@(-56),sp@-
	jbsr ___dl__FPvRC9nothrow_t
	addql #8,sp
L980:
	movel a5@(-62),a1
	movel a1@,a0
	movel a0@,a1@
	jbsr ___sjthrow
	.even
L984:
L975:
	jbsr ___terminate
	.even
L982:
	moveml a5@(-176),#0x5cfc
	fmovem a5@(-136),#0x3f
	unlk a5
	rts
LC2:
	.ascii "Surface::create(S_WH, BitMap*) : AllocBitmap() failed\0"
LC3:
	.ascii "Surface::create(S_WH, BitMap*) : not a CGX bitmap\0"
	.even
.globl _create__7SurfacessPQ212AmigaOS3_68K6BitMap
_create__7SurfacessPQ212AmigaOS3_68K6BitMap:
	pea a5@
	movel sp,a5
	moveml #0x3830,sp@-
	movel a5@(8),a3
	movel a5@(12),d0
	movel a5@(16),d1
	movel a5@(20),d2
	movew d0,d3
	movew d1,d4
	tstl a3@(12)
	jeq L986
	movel #-50659332,d0
	jra L996
	.even
L986:
	tstw d0
	jle L988
	tstw d1
	jgt L987
L988:
	movel #-50397184,d0
	jra L996
	.even
L987:
	tstl d2
	jne L989
	movel #-50462722,d0
	jra L996
	.even
L989:
	movel #-2147483640,sp@-
	movel d2,sp@-
	lea _GetCyberMapAttr,a2
	jbsr a2@
	addql #8,sp
	tstl d0
	jeq L997
	movel #-2147483641,sp@-
	movel d2,sp@-
	jbsr a2@
	addql #8,sp
	moveq #8,d1
	cmpl d0,d1
	jcs L991
	movel d2,sp@-
	pea 18:w
	pea 8:w
	jra L998
	.even
L991:
	movel d2,sp@-
	pea 18:w
	pea 9:w
L998:
	movew d4,a0
	movel a0,sp@-
	movew d3,a0
	movel a0,sp@-
	jbsr _AllocBitMap
	movel d0,a3@(12)
	addw #20,sp
	movel a3@(12),d0
	jne L993
	pea 2:w
	pea LC2
	jbsr _printDebug__9SystemLibPCci
	movel #-50528257,d0
	jra L996
	.even
L993:
	movel #-2147483640,sp@-
	movel d0,sp@-
	jbsr a2@
	addql #8,sp
	tstl d0
	jeq L994
	movew d3,a3@
	movew d4,a3@(2)
	movel a3,sp@-
	jbsr _queryBitMap__7Surface
	moveq #1,d0
	orl d0,a3@(24)
	clrl d0
	jra L996
	.even
L994:
	pea 2:w
	pea LC3
	jbsr _printDebug__9SystemLibPCci
	movel a3@(12),sp@-
	jbsr _FreeBitMap
	movel a3,sp@-
	jbsr _init__7Surface
L997:
	movel #-50659336,d0
L996:
	moveml a5@(-20),#0xc1c
	unlk a5
	rts
	.even
.globl _destroy__7Surface
_destroy__7Surface:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel a5@(8),a2
	tstl a2@(12)
	jeq L1000
	movel a2@(20),d0
	jeq L1001
	movel d0,sp@-
	jbsr _UnLockBitMap
	addql #4,sp
L1001:
	btst #0,a2@(27)
	jeq L1000
	movel a2@(12),sp@-
	jbsr _FreeBitMap
	addql #4,sp
L1000:
	movel a2,sp@-
	jbsr _init__7Surface
	movel a5@(-4),a2
	unlk a5
	rts
	.even
.globl _clear__7SurfaceG6Colour
_clear__7SurfaceG6Colour:
	link a5,#-100
	moveml #0x3030,sp@-
	movel a5@(8),a3
	tstl a3@(8)
	jeq L1004
	moveq #-100,d2
	addl a5,d2
	movel d2,sp@-
	jbsr _InitRastPort
	movel a3@(12),a5@(-96)
	movel a3@(8),a0
	movel a0@(46),a0
	lea a0@(44),a2
	pea -1:w
	movel #-2080374784,sp@-
	moveb a5@(15),d0
	moveq #24,d1
	lsll d1,d0
	movel d0,sp@-
	moveb a5@(14),d0
	lsll d1,d0
	movel d0,sp@-
	moveb a5@(13),d0
	lsll d1,d0
	movel d0,sp@-
	movel a2@(4),sp@-
	jbsr _ObtainBestPen
	movel d0,d3
	movel d3,sp@-
	movel d2,sp@-
	jbsr _SetAPen
	addw #36,sp
	movew a3@(2),a0
	pea a0@(-1)
	movew a3@,a0
	pea a0@(-1)
	clrl sp@-
	clrl sp@-
	movel d2,sp@-
	jbsr _RectFill
	movel d3,sp@-
	movel a2@(4),sp@-
	jbsr _ReleasePen
L1004:
	moveml a5@(-116),#0xc0c
	unlk a5
	rts
	.even
.globl _assignSurface__15SurfaceProviderP7SurfacePQ212AmigaOS3_68K6BitMap
_assignSurface__15SurfaceProviderP7SurfacePQ212AmigaOS3_68K6BitMap:
	pea a5@
	movel sp,a5
	moveml #0x2030,sp@-
	movel a5@(8),a2
	movel a5@(12),d2
	tstl a2
	jeq L1010
	tstl d2
	jeq L1010
	tstl a2@(12)
	jne L1010
	movel #-2147483640,sp@-
	movel d2,sp@-
	lea _GetCyberMapAttr,a3
	jbsr a3@
	addql #8,sp
	tstl d0
	jne L1009
L1010:
	clrb d0
	jra L1011
	.even
L1009:
	movel d2,a2@(12)
	movel #-2147483643,sp@-
	movel d2,sp@-
	jbsr a3@
	movew d0,a2@
	movel #-2147483642,sp@-
	movel d2,sp@-
	jbsr a3@
	movew d0,a2@(2)
	movel a2,sp@-
	jbsr _queryBitMap__7Surface
	moveq #-2,d0
	andl a2@(24),d0
	moveq #2,d1
	orl d0,d1
	movel d1,a2@(24)
	moveq #1,d0
L1011:
	moveml a5@(-12),#0xc04
	unlk a5
	rts
LC4:
	.ascii "SurfaceProvider::assignNewSurface() - null BitMap\12\0"
LC5:
	.ascii "SurfaceProvider::assignNewSurface() - not an RTG BitMap\12\0"
	.even
.globl _assignNewSurface__15SurfaceProviderPQ212AmigaOS3_68K6BitMap
_assignNewSurface__15SurfaceProviderPQ212AmigaOS3_68K6BitMap:
	link a5,#-64
	fmovem #0xfc,sp@-
	moveml #0x3f3a,sp@-
	jbsr ___get_eh_context
	movel d0,a5@(-58)
	tstl a5@(8)
	jne L1013
	pea 2:w
	pea LC4
	jra L1038
	.even
L1013:
	movel #-2147483640,sp@-
	movel a5@(8),sp@-
	jbsr _GetCyberMapAttr
	addql #8,sp
	tstl d0
	jne L1014
	pea 2:w
	pea LC5
L1038:
	jbsr _printDebug__9SystemLibPCci
	clrl d0
	jra L1037
	.even
L1014:
	pea _nothrow
	pea 42:w
	jbsr ___nw__FUlRC9nothrow_t
	movel d0,a5@(-52)
	moveb #1,a5@(-53)
	movel a5@(-58),a0
	addql #4,a0
	movel a0@,a5@(-24)
	clrl a5@(-20)
	movel a5,a5@(-16)
	movel #L1018,a5@(-12)
	movel sp,a5@(-8)
	movel a0,a5@(-62)
	jra L1017
	.even
L1018:
	movel a5@(-58),a0
	addql #4,a0
	movel a0,a5@(-62)
	jra L1015
	.even
L1017:
	lea a5@(-24),a1
	movel a1,a0@
	addql #8,sp
	moveq #40,d0
	addl a5@(-52),d0
	movel a5@(-52),a0
	movel d0,a0@(4)
	clrw a0@
	clrw a0@(2)
	movel a0,sp@-
	jbsr _init__7Surface
	addql #4,sp
	clrb a5@(-53)
	movel a5@(-62),a1
	movel a1@,a0
	movel a0@,a1@
	tstl a5@(-52)
	jeq L1029
	movel a5@(8),sp@-
	movel a5@(-52),sp@-
	jbsr _assignSurface__15SurfaceProviderP7SurfacePQ212AmigaOS3_68K6BitMap
L1029:
	movel a5@(-52),d0
	jra L1037
	.even
L1015:
	movel a5@(-62),a0
	movel a0@,a5@(-48)
	clrl a5@(-44)
	movel a5,a5@(-40)
	movel #L1033,a5@(-36)
	movel sp,a5@(-32)
	jra L1032
	.even
L1033:
	jra L1039
	.even
L1032:
	lea a5@(-48),a0
	movel a5@(-62),a1
	movel a0,a1@
	tstb a5@(-53)
	jeq L1035
	pea _nothrow
	movel a5@(-52),sp@-
	jbsr ___dl__FPvRC9nothrow_t
	addql #8,sp
L1035:
	movel a5@(-58),a1
	addql #4,a1
	movel a1@,a0
	movel a0@,a1@
	jbsr ___sjthrow
	.even
L1039:
L1030:
	jbsr ___terminate
	.even
L1037:
	moveml a5@(-176),#0x5cfc
	fmovem a5@(-136),#0x3f
	unlk a5
	rts
LC6:
	.ascii "SurfaceProvider::createSurface() - null BitMap\12\0"
LC7:
	.ascii "SurfaceProvider::createSurface() - not an RTG BitMap\12\0"
	.even
.globl _createSurface__15SurfaceProviderPQ212AmigaOS3_68K6BitMapss
_createSurface__15SurfaceProviderPQ212AmigaOS3_68K6BitMapss:
	link a5,#-68
	fmovem #0xfc,sp@-
	moveml #0x3f3a,sp@-
	movew a5@(14),a5@(-50)
	movew a5@(18),a5@(-52)
	jbsr ___get_eh_context
	movel d0,a5@(-62)
	tstl a5@(8)
	jne L1041
	pea 2:w
	pea LC6
	jra L1074
	.even
L1041:
	movel #-2147483640,sp@-
	movel a5@(8),sp@-
	jbsr _GetCyberMapAttr
	addql #8,sp
	tstl d0
	jne L1042
	pea 2:w
	pea LC7
L1074:
	jbsr _printDebug__9SystemLibPCci
L1075:
	clrl d0
	jra L1073
	.even
L1042:
	pea _nothrow
	pea 42:w
	jbsr ___nw__FUlRC9nothrow_t
	movel d0,a5@(-56)
	moveb #1,a5@(-57)
	movel a5@(-62),a0
	addql #4,a0
	movel a0@,a5@(-24)
	clrl a5@(-20)
	movel a5,a5@(-16)
	movel #L1046,a5@(-12)
	movel sp,a5@(-8)
	movel a0,a5@(-66)
	jra L1045
	.even
L1046:
	movel a5@(-62),a0
	addql #4,a0
	movel a0,a5@(-66)
	jra L1043
	.even
L1045:
	lea a5@(-24),a1
	movel a1,a0@
	addql #8,sp
	moveq #40,d0
	addl a5@(-56),d0
	movel a5@(-56),a0
	movel d0,a0@(4)
	clrw a0@
	clrw a0@(2)
	movel a0,sp@-
	jbsr _init__7Surface
	addql #4,sp
	clrb a5@(-57)
	movel a5@(-66),a1
	movel a1@,a0
	movel a0@,a1@
	tstl a5@(-56)
	jeq L1075
	movel a5@(8),sp@-
	movew a5@(-52),a0
	movel a0,sp@-
	movew a5@(-50),a1
	movel a1,sp@-
	movel a5@(-56),sp@-
	jbsr _create__7SurfacessPQ212AmigaOS3_68K6BitMap
	addw #16,sp
	tstl d0
	jne L1058
	movel a5@(-56),d0
	jra L1073
	.even
L1058:
	movel a5@(-56),sp@-
	jbsr _destroy__7Surface
	movel a5@(-56),sp@
	jbsr ___builtin_delete
	jra L1075
	.even
L1043:
	movel a5@(-66),a0
	movel a0@,a5@(-48)
	clrl a5@(-44)
	movel a5,a5@(-40)
	movel #L1069,a5@(-36)
	movel sp,a5@(-32)
	jra L1068
	.even
L1069:
	jra L1076
	.even
L1068:
	lea a5@(-48),a0
	movel a5@(-66),a1
	movel a0,a1@
	tstb a5@(-57)
	jeq L1071
	pea _nothrow
	movel a5@(-56),sp@-
	jbsr ___dl__FPvRC9nothrow_t
	addql #8,sp
L1071:
	movel a5@(-62),a1
	addql #4,a1
	movel a1@,a0
	movel a0@,a1@
	jbsr ___sjthrow
	.even
L1076:
L1066:
	jbsr ___terminate
	.even
L1073:
	moveml a5@(-180),#0x5cfc
	fmovem a5@(-140),#0x3f
	unlk a5
	rts
