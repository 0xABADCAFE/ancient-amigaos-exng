#NO_APP
.globl _CyberGfxBase
.data
	.even
_CyberGfxBase:
	.long 0
.globl _GfxBase
	.even
_GfxBase:
	.long 0
.text
LC0:
	.ascii "graphics.library\0"
LC1:
	.ascii "GfxLib::init() Unable to open graphics.library, v39\0"
LC2:
	.ascii "cybergraphics.library\0"
LC3:
	.ascii "GfxLib::init() Unable to open cybergraphics.library, v41\0"
	.even
.globl _init__6GfxLib
_init__6GfxLib:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	pea 39:w
	pea LC0
	lea _OpenLibrary,a2
	jbsr a2@
	movel d0,_GfxBase
	addql #8,sp
	jne L825
	pea 2:w
	pea LC1
	jra L828
	.even
L825:
	pea 41:w
	pea LC2
	jbsr a2@
	movel d0,_CyberGfxBase
	addql #8,sp
	jeq L826
	jbsr _buildDisplayDataBase__6GfxLib
	jra L827
	.even
L826:
	pea 2:w
	pea LC3
L828:
	jbsr _printDebug__9SystemLibPCci
	movel #-50659333,d0
L827:
	movel a5@(-4),a2
	unlk a5
	rts
	.even
.globl _done__6GfxLib
_done__6GfxLib:
	pea a5@
	movel sp,a5
	jbsr _freeDisplayDataBase__6GfxLib
	movel _CyberGfxBase,d0
	jeq L830
	movel d0,sp@-
	jbsr _CloseLibrary
	clrl _CyberGfxBase
	addql #4,sp
L830:
	movel _GfxBase,d0
	jeq L831
	movel d0,sp@-
	jbsr _CloseLibrary
	clrl _GfxBase
L831:
	unlk a5
	rts
LC4:
	.ascii "GfxLib::buildDisplayDataBase() Unable to get cybergraphics display list\0"
LC5:
	.ascii "GfxLib::buildDisplayDataBase() Unable to build display list\0"
LC6:
	.ascii "GfxLib::buildDisplayDataBase() Unable to build display mode ID table\0"
	.even
.globl _buildDisplayDataBase__6GfxLib
_buildDisplayDataBase__6GfxLib:
	link a5,#-136
	moveml #0x3f3a,sp@-
	clrl sp@-
	jbsr _AllocCModeListTagList
	movel d0,a5@(-130)
	addql #4,sp
	jne L833
	pea 2:w
	pea LC4
	jbsr _printDebug__9SystemLibPCci
	movel #-50659333,d0
	jra L871
	.even
L833:
	clrl d2
	movel a5@(-130),a0
	movel a0@,a3
	tstl a3@
	jeq L835
	.even
L837:
	addql #1,d2
	movel a3@,a3
	tstl a3@
	jne L837
L835:
	addql #1,d2
	movel d2,sp@-
	jbsr _createModeDatabase__25DisplayPropertiesProviderUl
	addql #4,sp
	tstl d0
	jne L839
	pea 2:w
	pea LC5
	jra L873
	.even
L839:
	clrl sp@-
	subql #2,sp
	moveb #0,sp@(1)
	subql #2,sp
	lsll #2,d2
	movel d2,sp@-
	jbsr _alloc__3MemUlbQ23Mem9AlignType
	movel d0,a0
	movel a0,__11_NatDisplay$modeID
	addw #12,sp
	jne L840
	pea 2:w
	pea LC6
L873:
	jbsr _printDebug__9SystemLibPCci
	movel a5@(-130),sp@-
	jbsr _FreeCModeList
	movel #-50659333,d0
	jra L871
	.even
L840:
	clrl a0@
	movel #43715,sp@-
	clrl sp@-
	lea _setPropertyFlags__25DisplayPropertiesProviderUlUs,a2
	jbsr a2@
	jbsr _getWindowedLimits__6GfxLib
	addql #8,sp
	movew __17DisplayProperties$minWidth,a6
	movew __17DisplayProperties$maxWidth,a4
	movew __17DisplayProperties$minHeight,d7
	movew __17DisplayProperties$maxHeight,d6
	movew __17DisplayProperties$minDepth,d5
	movew __17DisplayProperties$maxDepth,d4
	clrl a5@(-126)
	clrl a5@(-122)
	clrl a5@(-118)
	clrl a5@(-114)
	clrl a5@(-110)
	clrl a5@(-106)
	clrl a5@(-102)
	clrw a5@(-98)
	moveq #1,d3
	movel a5@(-130),a0
	movel a0@,a3
	lea a5@(-96),a0
	movel a0,a5@(-134)
	tstl a3@
	jeq L849
	lea 0:w,a2
	.even
L851:
	movel __11_NatDisplay$modeID,a0
	movel a3@(46),a0@(d3:l:4)
	movel d3,sp@-
	movel d3,sp@-
	jbsr _setModeIndex__25DisplayPropertiesProviderUlUl
	movel a3@(46),sp@-
	movel #-2147475456,sp@-
	pea 96:w
	movel a5@(-134),sp@-
	clrl sp@-
	jbsr _GetDisplayInfoData
	addw #28,sp
	moveq #37,d1
	cmpl d0,d1
	jcc L852
	movew a5@(-58),d0
	movel a2,d2
	movew d0,d2
	movel d2,a2
	movew a5@(-60),d1
	mulu #280,d1
	mulsl d2,d1
	movel d1,d2
	mulul #274877907,d1:d2
	lsrl #6,d1
	movel d1,sp@-
	mulu #280,d0
	movel d0,sp@-
	jra L874
	.even
L852:
	pea 20000:w
	pea 10000:w
L874:
	movel d3,sp@-
	jbsr _setTiming__25DisplayPropertiesProviderUlUlUl
	addw #12,sp
	clrl d0
	movew a3@(50),d0
	movew a6,a0
	cmpl d0,a0
	jle L854
	movew a3@(50),a6
	jra L855
	.even
L854:
	movew a4,a0
	cmpl d0,a0
	jge L855
	movew a3@(50),a4
L855:
	clrl d0
	movew a3@(52),d0
	movew d7,a0
	cmpl d0,a0
	jle L857
	movew a3@(52),d7
	jra L858
	.even
L857:
	movew d6,a0
	cmpl d0,a0
	jge L858
	movew a3@(52),d6
L858:
	clrl d0
	movew a3@(54),d0
	movew d5,a0
	cmpl d0,a0
	jle L860
	movew a3@(54),d5
	jra L861
	.even
L860:
	clrl d0
	movew a3@(52),d0
	movew d4,a0
	cmpl d0,a0
	jge L861
	movew a3@(54),d4
L861:
	movel a3@(46),sp@-
	movel #-2147483647,sp@-
	jbsr _GetCyberIDAttr
	addql #8,sp
	lea __6_Nat2D$nativeToAbstract,a0
	movel a0@(d0:l:4),d2
	addqw #1,a5@(-126,d2:l:2)
	movew a3@(52),a0
	movel a0,sp@-
	movew a3@(50),a0
	movel a0,sp@-
	movel d3,sp@-
	jbsr _setDimension__25DisplayPropertiesProviderUlss
	movel #65535,sp@-
	movel d3,sp@-
	jbsr _setPropertyFlags__25DisplayPropertiesProviderUlUs
	clrl d0
	movew a3@(54),d0
	movel d0,sp@-
	movel d2,sp@-
	movel d3,sp@-
	jbsr _setFormat__25DisplayPropertiesProviderUlQ25Pixel6HWTypeQ25Pixel5Depth
	addw #32,sp
	pea a3@(14)
	movel d3,sp@-
	jbsr _setName__25DisplayPropertiesProviderUlPCc
	addql #8,sp
	movel a3@,a3
	addql #1,d3
	tstl a3@
	jne L851
L849:
	movel a5@(-130),sp@-
	jbsr _FreeCModeList
	movew d4,a0
	movel a0,sp@-
	movew d5,a0
	movel a0,sp@-
	movew d6,a0
	movel a0,sp@-
	movew d7,a0
	movel a0,sp@-
	movew a4,a4
	movel a4,sp@-
	movew a6,a6
	movel a6,sp@-
	jbsr _setLimits__25DisplayPropertiesProviderssssss
	movew a5@(-124),d0
	cmpw a5@(-120),d0
	jge L865
	moveq #3,d1
	movel d1,__5Pixel$formats+60
L865:
	movew a5@(-116),d2
	cmpw a5@(-112),d2
	jge L867
	moveq #7,d0
	movel d0,__5Pixel$formats+64
L867:
	movew a5@(-104),d1
	cmpw a5@(-100),d1
	jge L869
	moveq #13,d2
	movel d2,__5Pixel$formats+128
L869:
	clrl d0
L871:
	moveml a5@(-176),#0x5cfc
	unlk a5
	rts
	.even
.globl _freeDisplayDataBase__6GfxLib
_freeDisplayDataBase__6GfxLib:
	pea a5@
	movel sp,a5
	jbsr _freeModeDatabase__25DisplayPropertiesProvider
	movel __11_NatDisplay$modeID,sp@-
	jbsr _free__3MemPv
	clrl __11_NatDisplay$modeID
	unlk a5
	rts
	.even
.globl _getWindowedLimits__6GfxLib
_getWindowedLimits__6GfxLib:
	link a5,#-96
	moveml #0x3c30,sp@-
	tstl __11_NatDisplay$modeID
	jeq L878
	clrl sp@-
	jbsr _LockPubScreen
	movel d0,a2
	addql #4,sp
	tstl a2
	jeq L878
	pea a2@(44)
	jbsr _GetVPModeID
	movel d0,sp@-
	movel #-2147475456,sp@-
	pea 96:w
	pea a5@(-96)
	clrl sp@-
	jbsr _GetDisplayInfoData
	addw #24,sp
	moveq #37,d1
	cmpl d0,d1
	jcc L879
	movew a5@(-58),d2
	clrl d0
	movew d2,d0
	movew a5@(-60),d1
	mulu #280,d1
	mulsl d1,d0
	movel d0,d1
	mulul #274877907,d0:d1
	lsrl #6,d0
	movel d0,sp@-
	mulu #280,d2
	movel d2,sp@-
	jra L884
	.even
L879:
	pea 20000:w
	pea 10000:w
L884:
	clrl sp@-
	jbsr _setTiming__25DisplayPropertiesProviderUlUlUl
	addqw #8,sp
	movel #-2147483640,sp@
	movel a2@(88),sp@-
	lea _GetCyberMapAttr,a3
	jbsr a3@
	addql #8,sp
	tstl d0
	jeq L881
	movel #-2147483643,sp@-
	movel a2@(88),sp@-
	jbsr a3@
	movew d0,d5
	movel #-2147483642,sp@-
	movel a2@(88),sp@-
	jbsr a3@
	movew d0,d3
	movel #-2147483641,sp@-
	movel a2@(88),sp@-
	jbsr a3@
	movel d0,d4
	movel #-2147483644,sp@-
	movel a2@(88),sp@-
	jbsr a3@
	addw #32,sp
	lea __6_Nat2D$nativeToAbstract,a0
	movel a0@(d0:l:4),d2
	movew d3,a0
	movel a0,sp@-
	movew d5,a0
	movel a0,sp@-
	clrl sp@-
	jbsr _setDimension__25DisplayPropertiesProviderUlss
	movel d4,sp@-
	movel d2,sp@-
	clrl sp@-
	jbsr _setFormat__25DisplayPropertiesProviderUlQ25Pixel6HWTypeQ25Pixel5Depth
	movel a2,sp@-
	clrl sp@-
	jbsr _UnlockPubScreen
	clrl d0
	jra L883
	.even
L881:
	movel #-50659336,d0
	jra L883
	.even
L878:
	movel #-50659333,d0
L883:
	moveml a5@(-120),#0xc3c
	unlk a5
	rts
.globl __6_Nat2D$abstractToNative
.data
	.even
__6_Nat2D$abstractToNative:
	.long 0
	.long 1
	.long 2
	.long 3
	.long 4
	.long 5
	.long 6
	.long 7
	.long 8
	.long 9
	.long 10
	.long 11
	.long 11
	.long 12
	.long 13
.globl __6_Nat2D$nativeToAbstract
	.even
__6_Nat2D$nativeToAbstract:
	.long 0
	.long 1
	.long 2
	.long 7
	.long 4
	.long 5
	.long 6
	.long 7
	.long 8
	.long 9
	.long 10
	.long 11
	.long 13
	.long 14
.text
	.even
.globl _convertPixels__6_Nat2DPvT1Q25Pixel6HWTypeT3ssssP7Palette
_convertPixels__6_Nat2DPvT1Q25Pixel6HWTypeT3ssssP7Palette:
	pea a5@
	movel sp,a5
	movel a5@(20),d1
	movel d1,d0
	lsll #4,d0
	subl d1,d0
	addl a5@(16),d0
	lea __6_Nat2D$convTab,a0
	movew a5@(38),a1
	movel a1,sp@-
	movew a5@(34),a1
	movel a1,sp@-
	movew a5@(30),a1
	movel a1,sp@-
	movew a5@(26),a1
	movel a1,sp@-
	movel a5@(40),sp@-
	movel a5@(12),sp@-
	movel a5@(8),sp@-
	movel a0@(d0:l:4),a0
	jbsr a0@
	clrl d0
	unlk a5
	rts
	.even
.globl _none__6_Nat2DPvT1PUlssss
_none__6_Nat2DPvT1PUlssss:
	pea a5@
	movel sp,a5
	unlk a5
	rts
	.even
.globl _copy8__6_Nat2DPvT1PUlssss
_copy8__6_Nat2DPvT1PUlssss:
	pea a5@
	movel sp,a5
	moveml #0x3f00,sp@-
	movel a5@(8),d3
	movel a5@(12),d2
	movew a5@(22),d7
	movew a5@(26),d4
	movew a5@(30),d0
	movew a5@(34),d1
	cmpl d3,d2
	jeq L888
	tstw d4
	jeq L888
	movew d0,d6
	extl d6
	addl d6,d6
	movew d1,d5
	extl d5
	addl d5,d5
	movew d4,d0
	negw d0
	andw #3,d0
	jeq L892
	cmpw #3,d0
	jge L896
	cmpw #2,d0
	jge L897
	movew d7,a0
	movel a0,sp@-
	movel d2,sp@-
	movel d3,sp@-
	jbsr _copy__3MemPvPCvUl
	addl d6,d3
	addl d5,d2
	addw #12,sp
	subqw #1,d4
L897:
	movew d7,a0
	movel a0,sp@-
	movel d2,sp@-
	movel d3,sp@-
	jbsr _copy__3MemPvPCvUl
	addl d6,d3
	addl d5,d2
	addw #12,sp
	subqw #1,d4
L896:
	movew d7,a0
	movel a0,sp@-
	movel d2,sp@-
	movel d3,sp@-
	jbsr _copy__3MemPvPCvUl
	addl d6,d3
	addl d5,d2
	addw #12,sp
	subqw #1,d4
	jeq L888
	.even
L892:
	movew d7,a0
	movel a0,sp@-
	movel d2,sp@-
	movel d3,sp@-
	jbsr _copy__3MemPvPCvUl
	addl d6,d3
	addl d5,d2
	addw #12,sp
	movew d7,a0
	movel a0,sp@-
	movel d2,sp@-
	movel d3,sp@-
	jbsr _copy__3MemPvPCvUl
	addl d6,d3
	addl d5,d2
	addw #12,sp
	movew d7,a0
	movel a0,sp@-
	movel d2,sp@-
	movel d3,sp@-
	jbsr _copy__3MemPvPCvUl
	addl d6,d3
	addl d5,d2
	addw #12,sp
	movew d7,a0
	movel a0,sp@-
	movel d2,sp@-
	movel d3,sp@-
	jbsr _copy__3MemPvPCvUl
	addl d6,d3
	addl d5,d2
	addw #12,sp
	subqw #4,d4
	jne L892
L888:
	moveml a5@(-24),#0xfc
	unlk a5
	rts
.globl __6_Nat2D$convTab
.data
	.even
__6_Nat2D$convTab:
	.long _copy8__6_Nat2DPvT1PUlssss
	.long _convRGB15BE__5_Pix8PvT1PUlssss
	.long _convBGR15BE__5_Pix8PvT1PUlssss
	.long _convRGB15LE__5_Pix8PvT1PUlssss
	.long _convBGR15LE__5_Pix8PvT1PUlssss
	.long _convRGB16BE__5_Pix8PvT1PUlssss
	.long _convBGR16BE__5_Pix8PvT1PUlssss
	.long _convRGB16LE__5_Pix8PvT1PUlssss
	.long _convBGR16LE__5_Pix8PvT1PUlssss
	.long _convRGB24__5_Pix8PvT1PUlssss
	.long _convBGR24__5_Pix8PvT1PUlssss
	.long _convARGB32BE__5_Pix8PvT1PUlssss
	.long _convABGR32BE__5_Pix8PvT1PUlssss
	.long _convARGB32LE__5_Pix8PvT1PUlssss
	.long _convABGR32LE__5_Pix8PvT1PUlssss
	.long _none__6_Nat2DPvT1PUlssss
	.long copy15XETo15XE__Pix15__PvPvPUjssss
	.long rotate15BETo15BE__Pix15__PvPvPUjssss
	.long copy15XETo15YE__Pix15__PvPvPUjssss
	.long rotate15BETo15LE__Pix15__PvPvPUjssss
	.long copy15BETo16BE__Pix15__PvPvPUjssss
	.long rotate15BETo16BE__Pix15__PvPvPUjssss
	.long copy15BETo16LE__Pix15__PvPvPUjssss
	.long rotate15BETo16LE__Pix15__PvPvPUjssss
	.long copy15BETo24XGY__Pix15__PvPvPUjssss
	.long rotate15BETo24XGY__Pix15__PvPvPUjssss
	.long copy15BETo32BE__Pix15__PvPvPUjssss
	.long rotate15BETo32BE__Pix15__PvPvPUjssss
	.long copy15BETo32LE__Pix15__PvPvPUjssss
	.long rotate15BETo32LE__Pix15__PvPvPUjssss
	.long _none__6_Nat2DPvT1PUlssss
	.long rotate15BETo15BE__Pix15__PvPvPUjssss
	.long copy15XETo15XE__Pix15__PvPvPUjssss
	.long rotate15BETo15LE__Pix15__PvPvPUjssss
	.long copy15XETo15YE__Pix15__PvPvPUjssss
	.long rotate15BETo16BE__Pix15__PvPvPUjssss
	.long copy15BETo16BE__Pix15__PvPvPUjssss
	.long rotate15BETo16LE__Pix15__PvPvPUjssss
	.long copy15BETo16LE__Pix15__PvPvPUjssss
	.long rotate15BETo24XGY__Pix15__PvPvPUjssss
	.long copy15BETo24XGY__Pix15__PvPvPUjssss
	.long rotate15BETo32BE__Pix15__PvPvPUjssss
	.long copy15BETo32BE__Pix15__PvPvPUjssss
	.long rotate15BETo32LE__Pix15__PvPvPUjssss
	.long copy15BETo32LE__Pix15__PvPvPUjssss
	.long _none__6_Nat2DPvT1PUlssss
	.long copy15XETo15YE__Pix15__PvPvPUjssss
	.long rotate15LETo15BE__Pix15__PvPvPUjssss
	.long copy15XETo15XE__Pix15__PvPvPUjssss
	.long rotate15LETo15LE__Pix15__PvPvPUjssss
	.long copy15LETo16BE__Pix15__PvPvPUjssss
	.long rotate15LETo16BE__Pix15__PvPvPUjssss
	.long copy15LETo16LE__Pix15__PvPvPUjssss
	.long rotate15LETo16LE__Pix15__PvPvPUjssss
	.long copy15LETo24XGY__Pix15__PvPvPUjssss
	.long rotate15LETo24XGY__Pix15__PvPvPUjssss
	.long copy15LETo32BE__Pix15__PvPvPUjssss
	.long rotate15LETo32BE__Pix15__PvPvPUjssss
	.long copy15LETo32LE__Pix15__PvPvPUjssss
	.long rotate15LETo32LE__Pix15__PvPvPUjssss
	.long _none__6_Nat2DPvT1PUlssss
	.long rotate15LETo15BE__Pix15__PvPvPUjssss
	.long copy15XETo15YE__Pix15__PvPvPUjssss
	.long rotate15LETo15LE__Pix15__PvPvPUjssss
	.long copy15XETo15XE__Pix15__PvPvPUjssss
	.long rotate15LETo16BE__Pix15__PvPvPUjssss
	.long copy15LETo16BE__Pix15__PvPvPUjssss
	.long rotate15LETo16LE__Pix15__PvPvPUjssss
	.long copy15LETo16LE__Pix15__PvPvPUjssss
	.long rotate15LETo24XGY__Pix15__PvPvPUjssss
	.long copy15LETo24XGY__Pix15__PvPvPUjssss
	.long rotate15LETo32BE__Pix15__PvPvPUjssss
	.long copy15LETo32BE__Pix15__PvPvPUjssss
	.long rotate15LETo32LE__Pix15__PvPvPUjssss
	.long copy15LETo32LE__Pix15__PvPvPUjssss
	.long _none__6_Nat2DPvT1PUlssss
	.long copy16BETo15BE__Pix16__PvPvPUjssss
	.long rotate16BETo15BE__Pix16__PvPvPUjssss
	.long copy16BETo15LE__Pix16__PvPvPUjssss
	.long rotate16BETo15LE__Pix16__PvPvPUjssss
	.long copy16XETo16XE__Pix16__PvPvPUjssss
	.long rotate16BETo16BE__Pix16__PvPvPUjssss
	.long copy16XETo16YE__Pix16__PvPvPUjssss
	.long rotate16BETo16LE__Pix16__PvPvPUjssss
	.long copy16BETo24XGY__Pix16__PvPvPUjssss
	.long rotate16BETo24XGY__Pix16__PvPvPUjssss
	.long copy16BETo32BE__Pix16__PvPvPUjssss
	.long rotate16BETo32BE__Pix16__PvPvPUjssss
	.long copy16BETo32LE__Pix16__PvPvPUjssss
	.long rotate16BETo32LE__Pix16__PvPvPUjssss
	.long _none__6_Nat2DPvT1PUlssss
	.long rotate16BETo15BE__Pix16__PvPvPUjssss
	.long copy16BETo15BE__Pix16__PvPvPUjssss
	.long rotate16BETo15LE__Pix16__PvPvPUjssss
	.long copy16BETo15LE__Pix16__PvPvPUjssss
	.long rotate16BETo16BE__Pix16__PvPvPUjssss
	.long copy16XETo16XE__Pix16__PvPvPUjssss
	.long rotate16BETo16LE__Pix16__PvPvPUjssss
	.long copy16XETo16YE__Pix16__PvPvPUjssss
	.long rotate16BETo24XGY__Pix16__PvPvPUjssss
	.long copy16BETo24XGY__Pix16__PvPvPUjssss
	.long rotate16BETo32BE__Pix16__PvPvPUjssss
	.long copy16BETo32BE__Pix16__PvPvPUjssss
	.long rotate16BETo32LE__Pix16__PvPvPUjssss
	.long copy16BETo32LE__Pix16__PvPvPUjssss
	.long _none__6_Nat2DPvT1PUlssss
	.long copy16LETo15BE__Pix16__PvPvPUjssss
	.long rotate16LETo15BE__Pix16__PvPvPUjssss
	.long copy16LETo15LE__Pix16__PvPvPUjssss
	.long rotate16LETo15LE__Pix16__PvPvPUjssss
	.long copy16XETo16YE__Pix16__PvPvPUjssss
	.long rotate16LETo16BE__Pix16__PvPvPUjssss
	.long copy16XETo16XE__Pix16__PvPvPUjssss
	.long rotate16LETo16LE__Pix16__PvPvPUjssss
	.long copy16LETo24XGY__Pix16__PvPvPUjssss
	.long rotate16LETo24XGY__Pix16__PvPvPUjssss
	.long copy16LETo32BE__Pix16__PvPvPUjssss
	.long rotate16LETo32BE__Pix16__PvPvPUjssss
	.long copy16LETo32LE__Pix16__PvPvPUjssss
	.long rotate16LETo32LE__Pix16__PvPvPUjssss
	.long _none__6_Nat2DPvT1PUlssss
	.long rotate16LETo15BE__Pix16__PvPvPUjssss
	.long copy16LETo15BE__Pix16__PvPvPUjssss
	.long rotate16LETo15LE__Pix16__PvPvPUjssss
	.long copy16LETo15LE__Pix16__PvPvPUjssss
	.long rotate16LETo16BE__Pix16__PvPvPUjssss
	.long copy16XETo16YE__Pix16__PvPvPUjssss
	.long rotate16LETo16LE__Pix16__PvPvPUjssss
	.long copy16XETo16XE__Pix16__PvPvPUjssss
	.long rotate16LETo24XGY__Pix16__PvPvPUjssss
	.long copy16LETo24XGY__Pix16__PvPvPUjssss
	.long rotate16LETo32BE__Pix16__PvPvPUjssss
	.long copy16LETo32BE__Pix16__PvPvPUjssss
	.long rotate16LETo32LE__Pix16__PvPvPUjssss
	.long copy16LETo32LE__Pix16__PvPvPUjssss
	.long _none__6_Nat2DPvT1PUlssss
	.long copy24XGYTo15BE__Pix24__PvPvPUjssss
	.long rotate24XGYTo15BE__Pix24__PvPvPUjssss
	.long copy24XGYTo15LE__Pix24__PvPvPUjssss
	.long rotate24XGYTo15LE__Pix24__PvPvPUjssss
	.long copy24XGYTo16BE__Pix24__PvPvPUjssss
	.long rotate24XGYTo16BE__Pix24__PvPvPUjssss
	.long copy24XGYTo16LE__Pix24__PvPvPUjssss
	.long rotate24XGYTo16LE__Pix24__PvPvPUjssss
	.long copy24To24__Pix24__PvPvPUjssss
	.long rotate24To24__Pix24__PvPvPUjssss
	.long copy24XGYTo32BE__Pix24__PvPvPUjssss
	.long rotate24XGYTo32BE__Pix24__PvPvPUjssss
	.long copy24XGYTo32LE__Pix24__PvPvPUjssss
	.long rotate24XGYTo32LE__Pix24__PvPvPUjssss
	.long _none__6_Nat2DPvT1PUlssss
	.long rotate24XGYTo15BE__Pix24__PvPvPUjssss
	.long copy24XGYTo15BE__Pix24__PvPvPUjssss
	.long rotate24XGYTo15LE__Pix24__PvPvPUjssss
	.long copy24XGYTo15LE__Pix24__PvPvPUjssss
	.long rotate24XGYTo16BE__Pix24__PvPvPUjssss
	.long copy24XGYTo16BE__Pix24__PvPvPUjssss
	.long rotate24XGYTo16LE__Pix24__PvPvPUjssss
	.long copy24XGYTo16LE__Pix24__PvPvPUjssss
	.long rotate24To24__Pix24__PvPvPUjssss
	.long copy24To24__Pix24__PvPvPUjssss
	.long rotate24XGYTo32BE__Pix24__PvPvPUjssss
	.long copy24XGYTo32BE__Pix24__PvPvPUjssss
	.long rotate24XGYTo32LE__Pix24__PvPvPUjssss
	.long copy24XGYTo32LE__Pix24__PvPvPUjssss
	.long _none__6_Nat2DPvT1PUlssss
	.long copy32BETo15BE__Pix32__PvPvPUjssss
	.long rotate32BETo15BE__Pix32__PvPvPUjssss
	.long copy32BETo15LE__Pix32__PvPvPUjssss
	.long rotate32BETo15LE__Pix32__PvPvPUjssss
	.long copy32BETo16BE__Pix32__PvPvPUjssss
	.long rotate32BETo16BE__Pix32__PvPvPUjssss
	.long copy32BETo16LE__Pix32__PvPvPUjssss
	.long rotate32BETo16LE__Pix32__PvPvPUjssss
	.long copy32BETo24XGY__Pix32__PvPvPUjssss
	.long rotate32BETo24XGY__Pix32__PvPvPUjssss
	.long copy32XETo32XE__Pix32__PvPvPUjssss
	.long rotate32BETo32BE__Pix32__PvPvPUjssss
	.long copy32XETo32YE__Pix32__PvPvPUjssss
	.long rotate32BETo32LE__Pix32__PvPvPUjssss
	.long _none__6_Nat2DPvT1PUlssss
	.long rotate32BETo15BE__Pix32__PvPvPUjssss
	.long copy32BETo15BE__Pix32__PvPvPUjssss
	.long rotate32BETo15LE__Pix32__PvPvPUjssss
	.long copy32BETo15LE__Pix32__PvPvPUjssss
	.long rotate32BETo16BE__Pix32__PvPvPUjssss
	.long copy32BETo16BE__Pix32__PvPvPUjssss
	.long rotate32BETo16LE__Pix32__PvPvPUjssss
	.long copy32BETo16LE__Pix32__PvPvPUjssss
	.long rotate32BETo24XGY__Pix32__PvPvPUjssss
	.long copy32BETo24XGY__Pix32__PvPvPUjssss
	.long rotate32BETo32BE__Pix32__PvPvPUjssss
	.long copy32XETo32XE__Pix32__PvPvPUjssss
	.long rotate32BETo32LE__Pix32__PvPvPUjssss
	.long copy32XETo32YE__Pix32__PvPvPUjssss
	.long _none__6_Nat2DPvT1PUlssss
	.long copy32LETo15BE__Pix32__PvPvPUjssss
	.long rotate32LETo15BE__Pix32__PvPvPUjssss
	.long copy32LETo15LE__Pix32__PvPvPUjssss
	.long rotate32LETo15LE__Pix32__PvPvPUjssss
	.long copy32LETo16BE__Pix32__PvPvPUjssss
	.long rotate32LETo16BE__Pix32__PvPvPUjssss
	.long copy32LETo16LE__Pix32__PvPvPUjssss
	.long rotate32LETo16LE__Pix32__PvPvPUjssss
	.long copy32LETo24XGY__Pix32__PvPvPUjssss
	.long rotate32LETo24XGY__Pix32__PvPvPUjssss
	.long copy32XETo32YE__Pix32__PvPvPUjssss
	.long rotate32LETo32BE__Pix32__PvPvPUjssss
	.long copy32XETo32XE__Pix32__PvPvPUjssss
	.long rotate32LETo32LE__Pix32__PvPvPUjssss
	.long _none__6_Nat2DPvT1PUlssss
	.long rotate32LETo15BE__Pix32__PvPvPUjssss
	.long copy32LETo15BE__Pix32__PvPvPUjssss
	.long rotate32LETo15LE__Pix32__PvPvPUjssss
	.long copy32LETo15LE__Pix32__PvPvPUjssss
	.long rotate32LETo16BE__Pix32__PvPvPUjssss
	.long copy32LETo16BE__Pix32__PvPvPUjssss
	.long rotate32LETo16LE__Pix32__PvPvPUjssss
	.long copy32LETo16LE__Pix32__PvPvPUjssss
	.long rotate32LETo24XGY__Pix32__PvPvPUjssss
	.long copy32LETo24XGY__Pix32__PvPvPUjssss
	.long rotate32LETo32BE__Pix32__PvPvPUjssss
	.long copy32XETo32YE__Pix32__PvPvPUjssss
	.long rotate32LETo32LE__Pix32__PvPvPUjssss
	.long copy32XETo32XE__Pix32__PvPvPUjssss
