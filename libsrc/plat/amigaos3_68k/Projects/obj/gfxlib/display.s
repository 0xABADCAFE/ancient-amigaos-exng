#NO_APP
.text
LC0:
	.ascii "bad_alloc\0"
.globl __11_NatDisplay$modeID
.data
	.even
__11_NatDisplay$modeID:
	.long 0
.text
LC1:
	.ascii "Untitled Window\0"
	.even
.globl ___11_NatDisplay
___11_NatDisplay:
	link a5,#-56
	fmovem #0xfc,sp@-
	moveml #0x3f3a,sp@-
	jbsr ___get_eh_context
	movel d0,a5@(-52)
	movel a5@(8),a0
	pea a0@(1)
	jbsr ___9_NatInput
	movel a5@(-52),a0
	addql #4,a0
	movel a0@,a5@(-24)
	clrl a5@(-20)
	movel a5,a5@(-16)
	movel #L897,a5@(-12)
	movel sp,a5@(-8)
	movel a0,a5@(-56)
	jra L896
	.even
L897:
	movel a5@(-52),a1
	addql #4,a1
	movel a1,a5@(-56)
	jra L894
	.even
L896:
	lea a5@(-24),a1
	movel a1,a0@
	movel a5@(8),a0
	clrl a0@(2)
	clrl a0@(6)
	movew #-1,a0@(10)
	movew #-1,a0@(12)
	clrl a0@(14)
	movel #16,sp@
	pea a0@(18)
	pea LC1
	jbsr _bcopy
	movel a5@(-56),a1
	movel a1@,a0
	movel a0@,a1@
	movel a5@(8),d0
	jra L904
	.even
L894:
	movel a5@(-56),a0
	movel a0@,a5@(-48)
	clrl a5@(-44)
	movel a5,a5@(-40)
	movel #L902,a5@(-36)
	movel sp,a5@(-32)
	jra L901
	.even
L902:
	jra L905
	.even
L901:
	lea a5@(-48),a0
	movel a5@(-56),a1
	movel a0,a1@
	clrl sp@-
	movel a5@(8),a1
	pea a1@(1)
	jbsr __$_9_NatInput
	movel a5@(-52),a1
	addql #4,a1
	movel a1@,a0
	movel a0@,a1@
	addql #8,sp
	jbsr ___sjthrow
	.even
L905:
L899:
	jbsr ___terminate
	.even
L904:
	moveml a5@(-168),#0x5cfc
	fmovem a5@(-128),#0x3f
	unlk a5
	rts
	.even
.globl _waitForRefresh__11_NatDisplay
_waitForRefresh__11_NatDisplay:
	pea a5@
	movel sp,a5
	movel a5@(8),a0
	movel a0@(2),a0
	tstl a0
	jeq L907
	pea a0@(44)
	jbsr _WaitBOVP
L907:
	unlk a5
	rts
LC2:
	.ascii "_NatDisplay::openFullScreen() : failed to create screen\0"
LC3:
	.ascii "_NatDisplay::openFullScreen() : screen opened\0"
LC4:
	.ascii "_NatDisplay::openFullScreen() : failed to create window\0"
LC5:
	.ascii "_NatDisplay::openFullScreen() : display created OK\0"
	.even
.globl _openFullScreen__11_NatDisplayUl
_openFullScreen__11_NatDisplayUl:
	pea a5@
	movel sp,a5
	movel a3,sp@-
	movel a2,sp@-
	movel a5@(8),a2
	tstl a2@(2)
	jeq L909
	movel #-50659332,d0
	jra L914
	.even
L909:
	clrl sp@-
	pea a2@(18)
	movel #-2147483608,sp@-
	pea 1:w
	movel #-2147483584,sp@-
	clrl sp@-
	movel #-2147483586,sp@-
	clrl sp@-
	movel #-2147483594,sp@-
	movel a5@(12),sp@-
	movel #-2147483598,sp@-
	pea 8:w
	movel #-2147483611,sp@-
	clrl sp@-
	jbsr _OpenScreenTags
	movel d0,a2@(2)
	addw #56,sp
	jne L910
	pea 2:w
	pea LC2
	jbsr _printDebug__9SystemLibPCci
	jra L915
	.even
L910:
	clrl sp@-
	pea LC3
	lea _printDebug__9SystemLibPCci,a3
	jbsr a3@
	clrl sp@-
	movel #72448,sp@-
	movel #-2147483541,sp@-
	clrl sp@-
	movel #-2147483538,sp@-
	clrl sp@-
	movel #-2147483547,sp@-
	clrl sp@-
	movel #-2147483548,sp@-
	movew a2@(12),a0
	movel a0,sp@-
	movel #-2147483545,sp@-
	movew a2@(10),a0
	movel a0,sp@-
	movel #-2147483546,sp@-
	movel a2@(2),sp@-
	movel #-2147483536,sp@-
	clrl sp@-
	jbsr _OpenWindowTags
	movel d0,a2@(6)
	addw #72,sp
	jeq L912
	clrl sp@-
	pea LC5
	jbsr a3@
	clrl d0
	jra L914
	.even
L912:
	pea 2:w
	pea LC4
	jbsr a3@
L915:
	addqw #4,sp
	movel a2,sp@
	jbsr _closeFullScreen__11_NatDisplay
	movel #-50659333,d0
L914:
	movel a5@(-8),a2
	movel a5@(-4),a3
	unlk a5
	rts
LC6:
	.ascii "_NatDisplay::closeFullScreen() : window closed\0"
LC7:
	.ascii "_NatDisplay::closeFullScreen() : screen closed\0"
LC8:
	.ascii "_NatDisplay::closeFullScreen() : resources freed\0"
	.even
.globl _closeFullScreen__11_NatDisplay
_closeFullScreen__11_NatDisplay:
	pea a5@
	movel sp,a5
	movel a3,sp@-
	movel a2,sp@-
	movel a5@(8),a2
	tstl a2@(2)
	jeq L919
	movel a2@(6),d0
	lea _printDebug__9SystemLibPCci,a3
	jeq L918
	movel d0,sp@-
	jbsr _CloseWindow
	clrl a2@(6)
	clrl sp@-
	pea LC6
	jbsr a3@
	addw #12,sp
L918:
	movel a2@(2),sp@-
	jbsr _CloseScreen
	clrl sp@-
	pea LC7
	jbsr a3@
	clrl a2@(2)
	clrl sp@-
	pea LC8
	jbsr a3@
L919:
	movel a5@(-8),a2
	movel a5@(-4),a3
	unlk a5
	rts
	.even
.globl _setDisplayTitle__11_NatDisplayPCcb
_setDisplayTitle__11_NatDisplayPCcb:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel a5@(8),a2
	movel a5@(12),d0
	jeq L921
	pea 255:w
	movel d0,sp@-
	pea a2@(18)
	jbsr _strncpy
	addw #12,sp
L921:
	tstb a5@(19)
	jeq L922
	tstl a2@(2)
	jeq L922
	pea a2@(18)
	pea -1:w
	movel a2@(6),sp@-
	jbsr _SetWindowTitles
	jra L925
	.even
L922:
	movel a2@(6),d0
	jeq L925
	pea -1:w
	pea a2@(18)
	movel d0,sp@-
	jbsr _SetWindowTitles
L925:
	movel a5@(-4),a2
	unlk a5
	rts
	.even
.globl ___7_NatWin
___7_NatWin:
	link a5,#-52
	fmovem #0xfc,sp@-
	moveml #0x3f3a,sp@-
	jbsr ___get_eh_context
	movel d0,a5@(-52)
	movel a5@(8),sp@-
	jbsr ___11_NatDisplay
	movel a5@(-52),a0
	addql #4,a0
	movel a0@,a5@(-24)
	clrl a5@(-20)
	movel a5,a5@(-16)
	movel #L930,a5@(-12)
	movel sp,a5@(-8)
	movel a0,a1
	jra L929
	.even
L930:
	jra L942
	.even
L929:
	lea a5@(-24),a2
	movel a2,a0@
	movel a5@(8),a0
	clrl a0@(274)
	clrl a0@(278)
	clrw a0@(286)
	clrw a0@(288)
	moveq #11,d0
	movel d0,a0@(282)
	movel a1@,a0
	movel a0@,a1@
	movel a5@(8),d0
	jra L941
	.even
L942:
L927:
	movel a5@(-52),a0
	addql #4,a0
	movel a0@,a5@(-48)
	clrl a5@(-44)
	movel a5,a5@(-40)
	movel #L935,a5@(-36)
	movel sp,a5@(-32)
	jra L934
	.even
L935:
	jra L943
	.even
L934:
	lea a5@(-48),a1
	movel a1,a0@
	clrl sp@-
	movel a5@(8),a2
	pea a2@(1)
	jbsr __$_9_NatInput
	addql #8,sp
	movel a5@(-52),a1
	addql #4,a1
	movel a1@,a0
	movel a0@,a1@
	jbsr ___sjthrow
	.even
L943:
L932:
	jbsr ___terminate
	.even
L941:
	moveml a5@(-164),#0x5cfc
	fmovem a5@(-124),#0x3f
	unlk a5
	rts
	.even
.globl __$_7_NatWin
__$_7_NatWin:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel d2,sp@-
	movel a5@(8),a2
	movel a5@(12),d2
	movel a2,sp@-
	jbsr _closeWindow__7_NatWin
	clrl sp@
	pea a2@(1)
	jbsr __$_9_NatInput
	addql #8,sp
	btst #0,d2
	jeq L949
	movel a2,sp@-
	jbsr ___builtin_delete
L949:
	movel a5@(-8),d2
	movel a5@(-4),a2
	unlk a5
	rts
	.even
.globl _setBorderless__7_NatWinb
_setBorderless__7_NatWinb:
	pea a5@
	movel sp,a5
	movel a5@(8),a0
	tstb a5@(15)
	jeq L951
	moveq #32,d0
	orl d0,a0@(282)
	jra L952
	.even
L951:
	moveq #-33,d0
	andl d0,a0@(282)
L952:
	unlk a5
	rts
	.even
.globl _setMoveable__7_NatWinb
_setMoveable__7_NatWinb:
	pea a5@
	movel sp,a5
	movel a5@(8),a0
	tstb a5@(15)
	jeq L954
	moveq #8,d0
	orl d0,a0@(282)
	jra L955
	.even
L954:
	moveq #-9,d0
	andl d0,a0@(282)
L955:
	unlk a5
	rts
	.even
.globl _setResizeable__7_NatWinb
_setResizeable__7_NatWinb:
	pea a5@
	movel sp,a5
	movel a5@(8),a0
	tstb a5@(15)
	jeq L957
	moveq #16,d0
	orl d0,a0@(282)
	jra L958
	.even
L957:
	moveq #-17,d0
	andl d0,a0@(282)
L958:
	unlk a5
	rts
	.even
.globl _setCloseable__7_NatWinb
_setCloseable__7_NatWinb:
	pea a5@
	movel sp,a5
	movel a5@(8),a0
	tstb a5@(15)
	jeq L960
	moveq #4,d0
	orl d0,a0@(282)
	jra L961
	.even
L960:
	moveq #-5,d0
	andl d0,a0@(282)
L961:
	unlk a5
	rts
LC9:
	.ascii "_NatWin::openWindow() : unable to lock screen\0"
LC10:
	.ascii "_NatDisplay::openWindow() : screen locked\0"
LC11:
	.ascii "_NatWin::openWindow() : screen bitmap not cgx\0"
LC12:
	.ascii "_NatDisplay::openWindow() : screen bitmap OK\0"
LC13:
	.ascii "_NatWin::openWindow() : width exceeds screen\0"
LC14:
	.ascii "_NatWin::openWindow() : height exceeds screen\0"
LC15:
	.ascii "_NatWin::openWindow() : depth exceeds screen\0"
LC16:
	.ascii "_NatDisplay::openWindow() : window parameters OK\0"
LC17:
	.ascii "_NatWin::openWindow() : unable allocate RastPort\0"
LC18:
	.ascii "_NatDisplay::openWindow() : RastPort allocated\0"
LC19:
	.ascii "_NatDisplay::openWindow() : screen Unlocked\0"
LC20:
	.ascii "_NatWin::openWindow() : OpenWindowTags() failed\0"
LC21:
	.ascii "_NatWin::openWindow() : failed to create draw Surface\0"
LC22:
	.ascii "_NatDisplay::openWindow() : display created OK\0"
	.even
.globl _openWindow__7_NatWin
_openWindow__7_NatWin:
	pea a5@
	movel sp,a5
	moveml #0x303a,sp@-
	movel a5@(8),a3
	clrl sp@-
	jbsr _LockPubScreen
	movel d0,a3@(2)
	addql #4,sp
	jne L963
	pea 2:w
	pea LC9
	jbsr _printDebug__9SystemLibPCci
	movel #-50659333,d0
	jra L995
	.even
L963:
	clrl sp@-
	pea LC10
	lea _printDebug__9SystemLibPCci,a2
	jbsr a2@
	movel #-2147483640,sp@-
	movel a3@(2),a0
	movel a0@(88),sp@-
	lea _GetCyberMapAttr,a6
	jbsr a6@
	addw #16,sp
	movel a2,d2
	tstl d0
	jne L964
	movel a3@(2),sp@-
	clrl sp@-
	jbsr _UnlockPubScreen
	pea 2:w
	pea LC11
	jbsr a2@
	clrl a3@(2)
	movel #-50659336,d0
	jra L995
	.even
L964:
	clrl sp@-
	pea LC12
	movel d2,a0
	jbsr a0@
	movel #-2147483643,sp@-
	movel a3@(2),a0
	movel a0@(88),sp@-
	jbsr a6@
	movel d0,a2
	movew a3@(10),a0
	addw #16,sp
	cmpl a0,a2
	jge L965
	movel a3@(2),sp@-
	clrl sp@-
	jbsr _UnlockPubScreen
	pea 2:w
	pea LC13
	jra L996
	.even
L965:
	movel #-2147483642,sp@-
	movel a3@(2),a0
	movel a0@(88),sp@-
	jbsr a6@
	movel d0,a4
	movew a3@(12),a0
	addql #8,sp
	cmpl a0,a4
	jge L966
	movel a3@(2),sp@-
	clrl sp@-
	jbsr _UnlockPubScreen
	pea 2:w
	pea LC14
	movel d2,a0
	jbsr a0@
	movel #-50397189,d0
	jra L995
	.even
L966:
	movel #-2147483641,sp@-
	movel a3@(2),a0
	movel a0@(88),sp@-
	jbsr a6@
	addql #8,sp
	cmpl a3@(14),d0
	jge L967
	movel a3@(2),sp@-
	clrl sp@-
	jbsr _UnlockPubScreen
	pea 2:w
	pea LC15
L996:
	movel d2,a1
	jbsr a1@
	movel #-50397189,d0
	jra L995
	.even
L967:
	clrl sp@-
	pea LC16
	movel d2,a0
	jbsr a0@
	addql #8,sp
	tstb a3@(285)
	jlt L968
	btst #0,a3@(285)
	jeq L969
	subw a3@(10),a2
	movel a2,d0
	asrl #1,d0
	movel d0,a2
	movew a2,a3@(288)
	jra L970
	.even
L969:
	movew a3@(288),a0
	movel a2,a1
	subw a3@(10),a1
	tstl a0
	jlt L971
	movel a0,d0
	cmpl d0,a1
	jge L973
	movel a1,d0
	jra L973
	.even
L971:
	clrl d0
L973:
	movew d0,a3@(288)
L970:
	btst #1,a3@(285)
	jeq L976
	subw a3@(12),a4
	movel a4,d3
	asrl #1,d3
	movel d3,a4
	movew a4,a3@(286)
	jra L968
	.even
L976:
	movew a3@(286),a0
	movel a4,a1
	subw a3@(12),a1
	tstl a0
	jlt L978
	movel a0,d0
	cmpl d0,a1
	jge L980
	movel a1,d0
	jra L980
	.even
L978:
	clrl d0
L980:
	movew d0,a3@(286)
L968:
	pea _nothrow
	pea 100:w
	jbsr ___nw__FUlRC9nothrow_t
	movel d0,a3@(274)
	addql #8,sp
	jne L983
	movel a3@(2),sp@-
	clrl sp@-
	jbsr _UnlockPubScreen
	pea 2:w
	pea LC17
	movel d2,a0
	jbsr a0@
	movel #-50659333,d0
	jra L995
	.even
L983:
	movel d0,sp@-
	jbsr _InitRastPort
	clrl sp@
	pea LC18
	movel d2,a2
	jbsr a2@
	addql #8,sp
	movel a3@(282),d1
	movel #70144,d0
	btst #3,d1
	jeq L985
	addql #2,d0
L985:
	btst #2,d1
	jeq L987
	moveq #8,d3
	orl d3,d0
L987:
	btst #4,d1
	jeq L988
	moveq #17,d3
	orl d3,d0
L988:
	btst #5,d1
	jeq L989
	orw #2048,d0
L989:
	btst #6,d1
	jeq L990
	orl #131136,d0
L990:
	clrl sp@-
	movel d0,sp@-
	movel #-2147483541,sp@-
	pea 1:w
	movel #-2147483517,sp@-
	pea a3@(18)
	movel #-2147483538,sp@-
	movew a3@(286),a0
	movel a0,sp@-
	movel #-2147483547,sp@-
	movew a3@(288),a1
	movel a1,sp@-
	movel #-2147483548,sp@-
	movew a3@(12),a0
	movel a0,sp@-
	movel #-2147483529,sp@-
	movew a3@(10),a1
	movel a1,sp@-
	movel #-2147483530,sp@-
	movel a3@(2),sp@-
	movel #-2147483527,sp@-
	clrl sp@-
	jbsr _OpenWindowTags
	movel d0,a3@(6)
	addw #68,sp
	movel a3@(2),sp@
	clrl sp@-
	jbsr _UnlockPubScreen
	clrl sp@-
	pea LC19
	jbsr a2@
	addw #16,sp
	movel a3@(6),a0
	tstl a0
	jne L991
	pea 2:w
	pea LC20
	jbsr a2@
	movel #-50659333,d0
	jra L995
	.even
L991:
	movew a3@(12),a1
	movel a1,sp@-
	movew a3@(10),a1
	movel a1,sp@-
	movel a0@(50),a0
	movel a0@(4),sp@-
	jbsr _createSurface__15SurfaceProviderPQ212AmigaOS3_68K6BitMapss
	movel d0,a0
	movel a0,a3@(278)
	addw #12,sp
	jeq L992
	movel a3@(6),a0@(8)
	movel a3@(278),a1
	movel a3@(274),a0
	movel a1@(12),a0@(4)
	clrl sp@-
	pea LC22
	jbsr a2@
	clrl d0
	jra L995
	.even
L992:
	pea 2:w
	pea LC21
	movel d2,a0
	jbsr a0@
	movel a3,sp@-
	jbsr _closeWindow__7_NatWin
	movel #-50659328,d0
L995:
	moveml a5@(-24),#0x5c0c
	unlk a5
	rts
LC23:
	.ascii "_NatDisplay::closeWindow() : window closed\0"
	.even
.globl _closeWindow__7_NatWin
_closeWindow__7_NatWin:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel d2,sp@-
	movel a5@(8),a2
	movel a2@(6),a0
	tstl a0
	jeq L998
	movew a0@(6),a2@(286)
	movew a0@(4),a2@(288)
	moveb a0@(54),d0
	extbl d0
	moveb a0@(56),d1
	extbl d1
	movew a0@(8),a1
	subw d0,a1
	movew a1,d0
	subw d1,d0
	movew d0,a2@(10)
	moveb a0@(55),d0
	extbl d0
	moveb a0@(57),d1
	extbl d1
	movew a0@(10),a1
	subw d0,a1
	movew a1,d0
	subw d1,d0
	movew d0,a2@(12)
	movel a0,sp@-
	jbsr _CloseWindow
	clrl sp@-
	pea LC23
	jbsr _printDebug__9SystemLibPCci
	addw #12,sp
L998:
	movel a2@(274),d0
	jeq L1009
	movel d0,sp@-
	jbsr ___builtin_delete
	addql #4,sp
L1009:
	movel a2@(278),d2
	jeq L1010
	movel d2,sp@-
	jbsr _destroy__7Surface
	movel d2,sp@
	jbsr ___builtin_delete
L1010:
	clrl a2@(2)
	clrl a2@(6)
	clrl a2@(274)
	clrl a2@(278)
	movel a5@(-8),d2
	movel a5@(-4),a2
	unlk a5
	rts
LC24:
	.ascii "_NatWin::reopen() : parameters unset\0"
	.even
.globl _reopen__7_NatWin
_reopen__7_NatWin:
	pea a5@
	movel sp,a5
	movel a5@(8),a0
	cmpw #-1,a0@(10)
	jeq L1019
	cmpw #-1,a0@(12)
	jne L1018
L1019:
	pea 2:w
	pea LC24
	jbsr _printDebug__9SystemLibPCci
	movel #-50659333,d0
	jra L1020
	.even
L1018:
	orw #128,a0@(284)
	movel a0,sp@-
	jbsr _openWindow__7_NatWin
L1020:
	unlk a5
	rts
	.even
.globl _close__7_NatWin
_close__7_NatWin:
	pea a5@
	movel sp,a5
	movel a5@(8),sp@-
	jbsr _closeWindow__7_NatWin
	unlk a5
	rts
	.even
.globl _refresh__7_NatWin
_refresh__7_NatWin:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel a5@(8),a1
	movel a1@(6),a0
	tstl a0
	jeq L1023
	pea 192:w
	movew a1@(12),a2
	movel a2,sp@-
	movew a1@(10),a2
	movel a2,sp@-
	moveb a0@(55),d0
	extbl d0
	movel d0,sp@-
	moveb a0@(54),d0
	extbl d0
	movel d0,sp@-
	movel a0@(50),sp@-
	clrl sp@-
	clrl sp@-
	movel a1@(274),sp@-
	jbsr _ClipBlit
L1023:
	movel a5@(-4),a2
	unlk a5
	rts
	.even
.globl _refresh__7_NatWinssss
_refresh__7_NatWinssss:
	pea a5@
	movel sp,a5
	moveml #0x3e3a,sp@-
	movel a5@(8),d3
	movel a5@(12),d1
	movel a5@(16),d5
	movew d1,a2
	movew d5,a3
	movew a5@(22),a6
	movew a5@(26),a4
	movel d3,a0
	movel a0@(6),d2
	jeq L1024
	movew a0@(10),d0
	cmpw a2,d0
	jlt L1024
	movew a0@(12),d4
	cmpw a3,d4
	jlt L1024
	movew a6,a0
	lea a0@(a2:w),a0
	tstl a0
	jlt L1024
	movew a4,a0
	lea a0@(a3:w),a0
	tstl a0
	jlt L1024
	tstw d1
	jge L1028
	addw a2,a6
	subl a2,a2
L1028:
	movew a2,d1
	extl d1
	movel d1,a1
	lea a1@(a6:w),a1
	movel a1,d6
	movel d3,a1
	movew a1@(10),a0
	cmpl d6,a0
	jge L1029
	movew d0,a6
	subw a2,a6
L1029:
	tstw d5
	jge L1030
	addw a3,a4
	subl a3,a3
L1030:
	movew a3,a2
	lea a2@(a4:w),a0
	movel a0,d0
	movel d3,a1
	movew a1@(12),a0
	cmpl d0,a0
	jge L1031
	movew d4,a4
	subw a3,a4
L1031:
	pea 192:w
	movew a4,a4
	movel a4,sp@-
	movew a6,a6
	movel a6,sp@-
	movel d2,a0
	moveb a0@(55),d0
	extbl d0
	pea a2@(d0:l)
	moveb a0@(54),d0
	extbl d0
	movel d0,a1
	pea a1@(d1:l)
	movel a0@(50),sp@-
	movel a2,sp@-
	movel d1,sp@-
	movel d3,a0
	movel a0@(274),sp@-
	jbsr _ClipBlit
L1024:
	moveml a5@(-36),#0x5c7c
	unlk a5
	rts
LC25:
	.ascii "_NatWin::open(sint16 w, sint16 h, Pixel::Depth, const char* title) : illegal dimensions\0"
	.even
.globl _open__7_NatWinssQ25Pixel5DepthPCc
_open__7_NatWinssQ25Pixel5DepthPCc:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel d2,sp@-
	movel a5@(8),a2
	movel a5@(12),a0
	movel a5@(16),a1
	movel a5@(24),d2
	movew a0,d0
	movew a1,d1
	cmpw #63,d0
	jle L1034
	cmpw __17DisplayProperties$maxWidth,d0
	jgt L1034
	cmpw #63,d1
	jle L1034
	cmpw __17DisplayProperties$maxHeight,d1
	jle L1033
L1034:
	pea 2:w
	pea LC25
	jbsr _printDebug__9SystemLibPCci
	movel #-50397185,d0
	jra L1038
	.even
L1033:
	movew a0,a2@(10)
	movew a1,a2@(12)
	movel a5@(20),a2@(14)
	tstl d2
	jeq L1037
	pea 63:w
	movel d2,sp@-
	pea a2@(18)
	jbsr _strncpy
	addw #12,sp
L1037:
	movel a2,sp@-
	jbsr _openWindow__7_NatWin
L1038:
	movel a5@(-8),d2
	movel a5@(-4),a2
	unlk a5
	rts
LC26:
	.ascii "_NatWin::open(DisplayProperties*, const char* title) : method unavailable\0"
	.even
.globl _open__7_NatWinPC17DisplayPropertiesPCc
_open__7_NatWinPC17DisplayPropertiesPCc:
	pea a5@
	movel sp,a5
	pea 2:w
	pea LC26
	jbsr _printDebug__9SystemLibPCci
	movel #-50659333,d0
	unlk a5
	rts
	.even
.globl ___7_NatScr
___7_NatScr:
	link a5,#-52
	fmovem #0xfc,sp@-
	moveml #0x3f3a,sp@-
	jbsr ___get_eh_context
	movel d0,a5@(-52)
	movel a5@(8),sp@-
	jbsr ___11_NatDisplay
	movel a5@(-52),a0
	addql #4,a0
	movel a0@,a5@(-24)
	clrl a5@(-20)
	movel a5,a5@(-16)
	movel #L1044,a5@(-12)
	movel sp,a5@(-8)
	movel a0,a1
	jra L1043
	.even
L1044:
	jra L1056
	.even
L1043:
	lea a5@(-24),a2
	movel a2,a0@
	movel a5@(8),a0
	clrl a0@(274)
	clrl a0@(278)
	movel a1@,a0
	movel a0@,a1@
	movel a5@(8),d0
	jra L1055
	.even
L1056:
L1041:
	movel a5@(-52),a0
	addql #4,a0
	movel a0@,a5@(-48)
	clrl a5@(-44)
	movel a5,a5@(-40)
	movel #L1049,a5@(-36)
	movel sp,a5@(-32)
	jra L1048
	.even
L1049:
	jra L1057
	.even
L1048:
	lea a5@(-48),a1
	movel a1,a0@
	clrl sp@-
	movel a5@(8),a2
	pea a2@(1)
	jbsr __$_9_NatInput
	addql #8,sp
	movel a5@(-52),a1
	addql #4,a1
	movel a1@,a0
	movel a0@,a1@
	jbsr ___sjthrow
	.even
L1057:
L1046:
	jbsr ___terminate
	.even
L1055:
	moveml a5@(-164),#0x5cfc
	fmovem a5@(-124),#0x3f
	unlk a5
	rts
	.even
.globl __$_7_NatScr
__$_7_NatScr:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel d2,sp@-
	movel a5@(8),a2
	movel a5@(12),d2
	movel a2,sp@-
	jbsr _closeScreen__7_NatScr
	clrl sp@
	pea a2@(1)
	jbsr __$_9_NatInput
	addql #8,sp
	btst #0,d2
	jeq L1063
	movel a2,sp@-
	jbsr ___builtin_delete
L1063:
	movel a5@(-8),d2
	movel a5@(-4),a2
	unlk a5
	rts
LC27:
	.ascii "_NatScr::openScreen() : failed to create draw Surface\0"
	.even
.globl _openScreen__7_NatScr
_openScreen__7_NatScr:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel a5@(8),a2
	tstl a2@(2)
	jeq L1065
	movel #-50659332,d0
	jra L1069
	.even
L1065:
	movel a2@(274),sp@-
	movel a2,sp@-
	jbsr _openFullScreen__11_NatDisplayUl
	addql #8,sp
	tstl d0
	jne L1066
	movel a2@(6),a0
	movel a0@(50),a0
	movel a0@(4),sp@-
	jbsr _assignNewSurface__15SurfaceProviderPQ212AmigaOS3_68K6BitMap
	movel d0,a0
	movel a0,a2@(278)
	addql #4,sp
	jeq L1067
	movel a2@(6),a0@(8)
	clrl d0
	jra L1069
	.even
L1067:
	pea 2:w
	pea LC27
	jbsr _printDebug__9SystemLibPCci
	movel a2,sp@-
	jbsr _closeScreen__7_NatScr
L1066:
	movel #-50659333,d0
L1069:
	movel a5@(-4),a2
	unlk a5
	rts
	.even
.globl _closeScreen__7_NatScr
_closeScreen__7_NatScr:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel d2,sp@-
	movel a5@(8),a2
	movel a2@(278),d2
	jeq L1071
	movel d2,sp@-
	jbsr _destroy__7Surface
	movel d2,sp@
	jbsr ___builtin_delete
	addql #4,sp
	clrl a2@(278)
L1071:
	movel a2,sp@-
	jbsr _closeFullScreen__11_NatDisplay
	movel a5@(-8),d2
	movel a5@(-4),a2
	unlk a5
	rts
LC28:
	.ascii "_NatScr::open(sint16 w, sint16 h, Pixel::Depth, const char* title) : illegal dimensions\0"
	.even
.globl _open__7_NatScrssQ25Pixel5DepthPCc
_open__7_NatScrssQ25Pixel5DepthPCc:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movew a5@(18),d0
	movew a5@(14),a2
	movew __17DisplayProperties$minWidth,d1
	cmpw a5@(14),d1
	jgt L1080
	movew __17DisplayProperties$maxWidth,a0
	cmpl a2,a0
	jlt L1080
	movew d0,a1
	cmpw __17DisplayProperties$minHeight,d0
	jlt L1080
	movew __17DisplayProperties$maxHeight,a0
	cmpl a1,a0
	jge L1079
L1080:
	pea 2:w
	pea LC28
	jbsr _printDebug__9SystemLibPCci
	movel #-50397185,d0
	jra L1088
	.even
L1079:
	movel a5@(24),sp@-
	subql #2,sp
	moveb #0,sp@(1)
	subql #2,sp
	movel a5@(20),sp@-
	movel a1,sp@-
	movel a2,sp@-
	jbsr _findIndex__17DisplayPropertiesssQ25Pixel5Depthb
	addw #16,sp
	movel __17DisplayProperties$modesAvail,d1
	jeq L1085
	cmpl __17DisplayProperties$numModes,d0
	jcc L1085
	lsll #6,d0
	addl d1,d0
	jra L1086
	.even
L1085:
	clrl d0
L1086:
	movel d0,sp@-
	movel a5@(8),sp@-
	jbsr _open__7_NatScrPC17DisplayPropertiesPCc
L1088:
	movel a5@(-4),a2
	unlk a5
	rts
LC29:
	.ascii "_NatScr::open(DisplayProperties *p, const char* title) : null pointer\0"
LC30:
	.ascii "_NatScr::open(DisplayProperties *p, const char* title) : Display unavailable\0"
	.even
.globl _open__7_NatScrPC17DisplayPropertiesPCc
_open__7_NatScrPC17DisplayPropertiesPCc:
	pea a5@
	movel sp,a5
	movel a3,sp@-
	movel a2,sp@-
	movel a5@(8),a2
	movel a5@(12),a3
	movel a5@(16),a1
	tstl a3
	jne L1102
	pea 2:w
	pea LC29
	jbsr _printDebug__9SystemLibPCci
	movel #-50462722,d0
	jra L1101
	.even
L1102:
	movel a3@(4),d1
	movel __11_NatDisplay$modeID,a0
	clrl d0
	tstl a0
	jeq L1094
	movel a0@(d1:l:4),d0
L1094:
	movel d0,a2@(274)
	jne L1091
	pea 2:w
	pea LC30
	jbsr _printDebug__9SystemLibPCci
	movel #-50659333,d0
	jra L1101
	.even
L1091:
	movew a3@,a2@(10)
	movew a3@(2),a2@(12)
	movel a3@(24),a2@(14)
	tstl a1
	jeq L1100
	pea 63:w
	movel a1,sp@-
	pea a2@(18)
	jbsr _strncpy
	addw #12,sp
L1100:
	movel a3,a2@(282)
	movel a2,sp@-
	jbsr _openScreen__7_NatScr
L1101:
	movel a5@(-8),a2
	movel a5@(-4),a3
	unlk a5
	rts
LC31:
	.ascii "_NatScr::reopen() : parameters unset\0"
	.even
.globl _reopen__7_NatScr
_reopen__7_NatScr:
	pea a5@
	movel sp,a5
	movel a5@(8),a0
	cmpw #-1,a0@(10)
	jeq L1105
	cmpw #-1,a0@(12)
	jne L1104
L1105:
	pea 2:w
	pea LC31
	jbsr _printDebug__9SystemLibPCci
	movel #-50659333,d0
	jra L1106
	.even
L1104:
	movel a0,sp@-
	jbsr _openScreen__7_NatScr
L1106:
	unlk a5
	rts
	.even
.globl _close__7_NatScr
_close__7_NatScr:
	pea a5@
	movel sp,a5
	movel a5@(8),sp@-
	jbsr _closeScreen__7_NatScr
	unlk a5
	rts
	.even
.globl ___11_NatScrBufflb
___11_NatScrBufflb:
	link a5,#-56
	fmovem #0xfc,sp@-
	moveml #0x3f3a,sp@-
	jbsr ___get_eh_context
	movel d0,a5@(-52)
	movel a5@(8),sp@-
	jbsr ___11_NatDisplay
	movel a5@(-52),a0
	addql #4,a0
	movel a0@,a5@(-24)
	clrl a5@(-20)
	movel a5,a5@(-16)
	movel #L1112,a5@(-12)
	movel sp,a5@(-8)
	movel a0,a5@(-56)
	jra L1111
	.even
L1112:
	movel a5@(-52),a0
	addql #4,a0
	movel a0,a5@(-56)
	jra L1109
	.even
L1111:
	lea a5@(-24),a1
	movel a1,a0@
	movel a5@(8),a0
	clrl a0@(294)
	clrl a0@(298)
	clrl a0@(302)
	clrl a0@(306)
	clrl sp@
	clrl sp@-
	jbsr _CreatePort
	movel a5@(8),a1
	movel d0,a1@(274)
	clrl sp@-
	clrl sp@-
	jbsr _CreatePort
	movel a5@(8),a0
	movel d0,a0@(278)
	clrl a0@(282)
	clrl a0@(286)
	clrl a0@(290)
	tstb a5@(19)
	jeq L1113
	moveq #2,d0
	orl d0,a0@(306)
L1113:
	moveq #3,d0
	cmpl a5@(12),d0
	jne L1114
	moveq #1,d0
	movel a5@(8),a0
	orl d0,a0@(306)
L1114:
	movel a5@(8),a1
	tstl a1@(274)
	jeq L1116
	tstl a1@(278)
	jne L1115
L1116:
	movel a5@(8),a0
	bset #7,a0@(306)
L1115:
	movel a5@(-56),a1
	movel a1@,a0
	movel a0@,a1@
	movel a5@(8),d0
	jra L1127
	.even
L1109:
	movel a5@(-56),a0
	movel a0@,a5@(-48)
	clrl a5@(-44)
	movel a5,a5@(-40)
	movel #L1121,a5@(-36)
	movel sp,a5@(-32)
	jra L1120
	.even
L1121:
	jra L1128
	.even
L1120:
	lea a5@(-48),a0
	movel a5@(-56),a1
	movel a0,a1@
	clrl sp@-
	movel a5@(8),a1
	pea a1@(1)
	jbsr __$_9_NatInput
	addql #8,sp
	movel a5@(-52),a1
	addql #4,a1
	movel a1@,a0
	movel a0@,a1@
	jbsr ___sjthrow
	.even
L1128:
L1118:
	jbsr ___terminate
	.even
L1127:
	moveml a5@(-168),#0x5cfc
	fmovem a5@(-128),#0x3f
	unlk a5
	rts
	.even
.globl __$_11_NatScrBuff
__$_11_NatScrBuff:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel a5@(8),a2
	movel a2,sp@-
	jbsr _closeScreen__11_NatScrBuff
	addql #4,sp
	movel a2@(278),d0
	jeq L1130
	movel d0,sp@-
	jbsr _DeletePort
	addql #4,sp
L1130:
	movel a2@(274),d0
	jeq L1133
	movel d0,sp@-
	jbsr _DeletePort
	addql #4,sp
L1133:
	clrl sp@-
	pea a2@(1)
	jbsr __$_9_NatInput
	addql #8,sp
	movel a5@(12),d0
	btst #0,d0
	jeq L1136
	movel a2,sp@-
	jbsr ___builtin_delete
L1136:
	movel a5@(-4),a2
	unlk a5
	rts
	.even
.globl _setClone__11_NatScrBuffb
_setClone__11_NatScrBuffb:
	pea a5@
	movel sp,a5
	movel a5@(8),a0
	tstb a5@(15)
	jeq L1138
	moveq #2,d0
	orl d0,a0@(306)
	jra L1139
	.even
L1138:
	moveq #2,d0
	andl d0,a0@(306)
L1139:
	unlk a5
	rts
	.even
.globl _setNumBuffers__11_NatScrBuffl
_setNumBuffers__11_NatScrBuffl:
	pea a5@
	movel sp,a5
	movel a5@(8),a0
	movel a5@(12),d0
	tstl a0@(2)
	jne L1141
	moveq #2,d1
	cmpl d0,d1
	jeq L1143
	moveq #3,d1
	cmpl d0,d1
	jeq L1144
	jra L1145
	.even
L1143:
	moveq #-2,d0
	andl d0,a0@(306)
	moveq #1,d0
	jra L1148
	.even
L1144:
	moveq #1,d1
	orl d1,a0@(306)
	moveq #1,d0
	jra L1148
	.even
L1145:
	moveq #-2,d0
	andl d0,a0@(306)
L1141:
	clrb d0
L1148:
	unlk a5
	rts
LC32:
	.ascii "_NatScrBuff::openScreen() : problem allocating message ports\0"
LC33:
	.ascii "_NatScrBuff::openScreen() : failed to create primary buffer\0"
LC34:
	.ascii "_NatScrBuff::openScreen() : created primary buffer\0"
LC35:
	.ascii "_NatScrBuff::openScreen() : failed to create secondary buffer\0"
LC36:
	.ascii "_NatScrBuff::openScreen() : created secondary buffer\0"
LC37:
	.ascii "_NatScrBuff::openScreen() : failed to create tertiay buffer\0"
LC38:
	.ascii "_NatScrBuff::openScreen() : failed to create draw Surface\0"
LC39:
	.ascii "_NatScrBuff::openScreen() : created draw Surface\0"
	.even
.globl _openScreen__11_NatScrBuff
_openScreen__11_NatScrBuff:
	pea a5@
	movel sp,a5
	moveml #0x38,sp@-
	movel a5@(8),a3
	tstl a3@(2)
	jeq L1150
	movel #-50659332,d0
	jra L1162
	.even
L1150:
	tstl a3@(306)
	jge L1151
	pea 2:w
	pea LC32
	jra L1163
	.even
L1151:
	movel a3@(294),sp@-
	movel a3,sp@-
	jbsr _openFullScreen__11_NatDisplayUl
	addql #8,sp
	tstl d0
	jne L1152
	pea 1:w
	clrl sp@-
	movel a3@(2),sp@-
	lea _AllocScreenBuffer,a4
	jbsr a4@
	movel d0,a3@(282)
	addw #12,sp
	jne L1154
	pea 2:w
	pea LC33
L1163:
	jbsr _printDebug__9SystemLibPCci
	addql #8,sp
	jra L1152
	.even
L1154:
	clrl sp@-
	pea LC34
	lea _printDebug__9SystemLibPCci,a2
	jbsr a2@
	clrl sp@-
	clrl sp@-
	movel a3@(2),sp@-
	jbsr a4@
	movel d0,a3@(286)
	addw #20,sp
	jne L1155
	pea 2:w
	pea LC35
	jra L1164
	.even
L1155:
	clrl sp@-
	pea LC36
	jbsr a2@
	addql #8,sp
	btst #0,a3@(309)
	jeq L1156
	clrl sp@-
	clrl sp@-
	movel a3@(2),sp@-
	jbsr a4@
	movel d0,a3@(290)
	addw #12,sp
	jne L1156
	pea 2:w
	pea LC37
	jra L1164
	.even
L1156:
	moveq #1,d0
	movel d0,a3@(302)
	movel a3@(286),a0
	movel a0@,sp@-
	jbsr _assignNewSurface__15SurfaceProviderPQ212AmigaOS3_68K6BitMap
	movel d0,a3@(298)
	addql #4,sp
	jne L1158
	pea 2:w
	pea LC38
L1164:
	jbsr a2@
	addql #8,sp
	jra L1152
	.even
L1158:
	clrl sp@-
	pea LC39
	jbsr a2@
	movel a3@(298),a0
	movel a3@(6),a0@(8)
	movel a3@(282),a0
	movel a0@(4),a0
	movel a3@(278),a0@(54)
	movel a3@(282),a0
	movel a0@(4),a0
	movel a3@(274),a0@(22)
	movel a3@(286),a0
	movel a0@(4),a0
	movel a3@(278),a0@(54)
	movel a3@(286),a0
	movel a0@(4),a0
	movel a3@(274),a0@(22)
	movel a3@(290),a0
	tstl a0
	jeq L1160
	movel a0@(4),a0
	movel a3@(278),a0@(54)
	movel a3@(290),a0
	movel a0@(4),a0
	movel a3@(274),a0@(22)
L1160:
	moveq #12,d0
	orl d0,a3@(306)
	clrl d0
	jra L1162
	.even
L1152:
	movel a3,sp@-
	jbsr _closeScreen__11_NatScrBuff
	movel #-50659333,d0
L1162:
	moveml a5@(-12),#0x1c00
	unlk a5
	rts
LC40:
	.ascii "_NatScrBuff::closeScreen() : discarded %ld messages from vidSafePort\12\0"
LC41:
	.ascii "_NatScrBuff::closeScreen() : discarded %ld messages from vidDispPort\12\0"
LC42:
	.ascii "_NatScrBuff::closeScreen() : released draw Surface\0"
LC43:
	.ascii "_NatScrBuff::closeScreen() : released primary buffer\0"
LC44:
	.ascii "_NatScrBuff::closeScreen() : released secondary buffer\0"
LC45:
	.ascii "_NatScrBuff::closeScreen() : released tertiary buffer\0"
	.even
.globl _closeScreen__11_NatScrBuff
_closeScreen__11_NatScrBuff:
	pea a5@
	movel sp,a5
	moveml #0x203a,sp@-
	movel a5@(8),a2
	clrl d2
	lea _closeFullScreen__11_NatDisplay,a6
	btst #2,a2@(309)
	jne L1166
	lea _printf,a4
	tstl a2@(274)
	jeq L1167
	lea _GetMsg,a3
	jra L1168
	.even
L1170:
	addql #1,d2
L1168:
	movel a2@(274),sp@-
	jbsr a3@
	addql #4,sp
	tstl d0
	jeq L1170
L1167:
	movel d2,sp@-
	pea LC40
	jbsr a4@
	clrl d2
	addql #8,sp
L1166:
	btst #3,a2@(309)
	jne L1172
	lea _printf,a4
	tstl a2@(278)
	jeq L1173
	lea _GetMsg,a3
	jra L1174
	.even
L1176:
	addql #1,d2
L1174:
	movel a2@(278),sp@-
	jbsr a3@
	addql #4,sp
	tstl d0
	jeq L1176
L1173:
	movel d2,sp@-
	pea LC41
	jbsr a4@
	addql #8,sp
L1172:
	movel a2@(298),d2
	jeq L1178
	movel d2,sp@-
	jbsr _destroy__7Surface
	movel d2,sp@
	jbsr ___builtin_delete
	addql #4,sp
	clrl a2@(298)
	clrl sp@-
	pea LC42
	jbsr _printDebug__9SystemLibPCci
	addql #8,sp
L1178:
	movel a2@(282),a0
	tstl a0
	jeq L1185
	movel a0@(4),a0
	clrl a0@(22)
	lea _ChangeScreenBuffer,a3
	.even
L1186:
	movel a2@(282),sp@-
	movel a2@(2),sp@-
	jbsr a3@
	addql #8,sp
	tstl d0
	jeq L1186
	movel a2@(282),sp@-
	movel a2@(2),sp@-
	jbsr _FreeScreenBuffer
	clrl a2@(282)
	clrl sp@-
	pea LC43
	jbsr _printDebug__9SystemLibPCci
	addw #16,sp
L1185:
	movel a2@(286),d0
	jeq L1190
	movel d0,sp@-
	movel a2@(2),sp@-
	jbsr _FreeScreenBuffer
	clrl a2@(286)
	clrl sp@-
	pea LC44
	jbsr _printDebug__9SystemLibPCci
	addw #16,sp
L1190:
	movel a2@(290),d0
	jeq L1191
	movel d0,sp@-
	movel a2@(2),sp@-
	jbsr _FreeScreenBuffer
	clrl a2@(290)
	clrl sp@-
	pea LC45
	jbsr _printDebug__9SystemLibPCci
	addw #16,sp
L1191:
	movel a2,sp@-
	jbsr a6@
	moveml a5@(-20),#0x5c04
	unlk a5
	rts
	.even
.globl _refresh__11_NatScrBuff
_refresh__11_NatScrBuff:
	pea a5@
	movel sp,a5
	moveml #0x2030,sp@-
	movel a5@(8),a2
	tstl a2@(2)
	jeq L1204
	movel a2@(302),d0
	btst #0,a2@(309)
	jeq L1196
	movel d0,d1
	addql #1,d1
	movel d1,a2@(302)
	moveq #2,d1
	cmpl d0,d1
	jne L1198
	clrl a2@(302)
	jra L1198
	.even
L1196:
	movel d0,d1
	eorw #1,d1
	movel d1,a2@(302)
L1198:
	lsll #2,d0
	movel a2@(282,d0:l),a0
	movel a0@(4),a0
	clrl a0@(22)
	movel d0,d2
	lea _ChangeScreenBuffer,a3
	.even
L1199:
	movel a2@(282,d2:l),sp@-
	movel a2@(2),sp@-
	jbsr a3@
	addql #8,sp
	tstl d0
	jeq L1199
	movel a2@(302),d0
	movel a2@(282,d0:l:4),a1
	movel a2@(298),a0
	movel a1@,a0@(12)
L1204:
	moveml a5@(-12),#0xc04
	unlk a5
	rts
	.even
.globl _waitSync__11_NatScrBuff
_waitSync__11_NatScrBuff:
	pea a5@
	movel sp,a5
	movel a3,sp@-
	movel a2,sp@-
	movel a5@(8),a2
	btst #3,a2@(309)
	jne L1212
	lea _GetMsg,a3
	jra L1208
	.even
L1210:
	movel a2@(278),a0
	clrl d1
	moveb a0@(15),d1
	moveq #1,d0
	lsll d1,d0
	movel d0,sp@-
	jbsr _Wait
	addql #4,sp
L1208:
	movel a2@(278),sp@-
	jbsr a3@
	addql #4,sp
	tstl d0
	jeq L1210
	moveq #8,d0
	orl d0,a2@(306)
L1212:
	movel a5@(-8),a2
	movel a5@(-4),a3
	unlk a5
	rts
LC46:
	.ascii "_NatScrBuff::open(sint16 w, sint16 h, Pixel::Depth, const char* title) : illegal dimensions\0"
	.even
.globl _open__11_NatScrBuffssQ25Pixel5DepthPCc
_open__11_NatScrBuffssQ25Pixel5DepthPCc:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movew a5@(18),d0
	movew a5@(14),a2
	movew __17DisplayProperties$minWidth,d1
	cmpw a5@(14),d1
	jgt L1215
	movew __17DisplayProperties$maxWidth,a0
	cmpl a2,a0
	jlt L1215
	movew d0,a1
	cmpw __17DisplayProperties$minHeight,d0
	jlt L1215
	movew __17DisplayProperties$maxHeight,a0
	cmpl a1,a0
	jge L1214
L1215:
	pea 2:w
	pea LC46
	jbsr _printDebug__9SystemLibPCci
	movel #-50397185,d0
	jra L1224
	.even
L1214:
	movel a5@(24),sp@-
	subql #2,sp
	moveb #0,sp@(1)
	subql #2,sp
	movel a5@(20),sp@-
	movel a1,sp@-
	movel a2,sp@-
	jbsr _findIndex__17DisplayPropertiesssQ25Pixel5Depthb
	addw #16,sp
	movel __17DisplayProperties$modesAvail,d1
	jeq L1220
	cmpl __17DisplayProperties$numModes,d0
	jcc L1220
	lsll #6,d0
	addl d1,d0
	jra L1221
	.even
L1220:
	clrl d0
L1221:
	movel d0,sp@-
	movel a5@(8),sp@-
	jbsr _open__11_NatScrBuffPC17DisplayPropertiesPCc
L1224:
	movel a5@(-4),a2
	unlk a5
	rts
LC47:
	.ascii "_NatScrBuff::open(DisplayProperties *p, const char* title) : null pointer\0"
LC48:
	.ascii "_NatScrBuff::open(DisplayProperties *p, const char* title) : Display unavailable\0"
	.even
.globl _open__11_NatScrBuffPC17DisplayPropertiesPCc
_open__11_NatScrBuffPC17DisplayPropertiesPCc:
	pea a5@
	movel sp,a5
	movel a3,sp@-
	movel a2,sp@-
	movel a5@(8),a2
	movel a5@(12),a3
	movel a5@(16),a1
	tstl a3
	jne L1239
	pea 2:w
	pea LC47
	jbsr _printDebug__9SystemLibPCci
	movel #-50462722,d0
	jra L1238
	.even
L1239:
	movel a3@(4),d1
	movel __11_NatDisplay$modeID,a0
	clrl d0
	tstl a0
	jeq L1230
	movel a0@(d1:l:4),d0
L1230:
	movel d0,a2@(294)
	jne L1227
	pea 2:w
	pea LC48
	jbsr _printDebug__9SystemLibPCci
	movel #-50659333,d0
	jra L1238
	.even
L1227:
	movew a3@,a2@(10)
	movew a3@(2),a2@(12)
	movel a3@(24),a2@(14)
	tstl a1
	jeq L1236
	pea 63:w
	movel a1,sp@-
	pea a2@(18)
	jbsr _strncpy
	addw #12,sp
L1236:
	movel a3,a2@(310)
	movel a2,sp@-
	jbsr _openScreen__11_NatScrBuff
L1238:
	movel a5@(-8),a2
	movel a5@(-4),a3
	unlk a5
	rts
LC49:
	.ascii "_NatScrBuff::reopen() : parameters unset\0"
	.even
.globl _reopen__11_NatScrBuff
_reopen__11_NatScrBuff:
	pea a5@
	movel sp,a5
	movel a5@(8),a0
	cmpw #-1,a0@(10)
	jeq L1242
	cmpw #-1,a0@(12)
	jne L1241
L1242:
	pea 2:w
	pea LC49
	jbsr _printDebug__9SystemLibPCci
	movel #-50659333,d0
	jra L1244
	.even
L1241:
	movel a0,sp@-
	jbsr _openScreen__11_NatScrBuff
L1244:
	unlk a5
	rts
	.even
.globl _close__11_NatScrBuff
_close__11_NatScrBuff:
	pea a5@
	movel sp,a5
	movel a5@(8),sp@-
	jbsr _closeScreen__11_NatScrBuff
	unlk a5
	rts
