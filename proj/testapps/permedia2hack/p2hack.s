#NO_APP
.text
LC0:
	.ascii "bad_alloc\0"
.globl _version
.data
_version:
	.ascii "$VER: P2Hack 0.1 K. Churchill (07.11.2004)\12\0"
.text
	.even
.globl _init__7AppBase
_init__7AppBase:
	pea a5@
	movel sp,a5
	jbsr _init__6GfxLib
	unlk a5
	rts
	.even
.globl _done__7AppBase
_done__7AppBase:
	pea a5@
	movel sp,a5
	jbsr _done__6GfxLib
	unlk a5
	rts
	.even
.globl _createApplicationInstance__7AppBase
_createApplicationInstance__7AppBase:
	link a5,#-60
	fmovem #0xfc,sp@-
	moveml #0x3f3a,sp@-
	jbsr ___get_eh_context
	movel d0,a5@(-56)
	pea _nothrow
	pea 64:w
	jbsr ___nw__FUlRC9nothrow_t
	movel d0,a5@(-52)
	movel a5@(-56),a0
	addql #4,a0
	movel a0@,a5@(-24)
	clrl a5@(-20)
	movel a5,a5@(-16)
	movel #L1729,a5@(-12)
	movel sp,a5@(-8)
	movel a0,a5@(-60)
	jra L1728
	.even
L1729:
	movel a5@(-56),a0
	addql #4,a0
	movel a0,a5@(-60)
	jra L1726
	.even
L1728:
	lea a5@(-24),a1
	movel a1,a0@
	movel a5@(-52),sp@-
	jbsr ___9P2HackApp
	movel a5@(-60),a1
	movel a1@,a0
	movel a0@,a1@
	jra L1740
	.even
L1726:
	movel a5@(-60),a0
	movel a0@,a5@(-48)
	clrl a5@(-44)
	movel a5,a5@(-40)
	movel #L1735,a5@(-36)
	movel sp,a5@(-32)
	jra L1734
	.even
L1735:
	jra L1741
	.even
L1734:
	lea a5@(-48),a0
	movel a5@(-60),a1
	movel a0,a1@
	moveq #1,d0
	jeq L1737
	pea _nothrow
	movel a5@(-52),sp@-
	jbsr ___dl__FPvRC9nothrow_t
	addql #8,sp
L1737:
	movel a5@(-56),a1
	addql #4,a1
	movel a1@,a0
	movel a0@,a1@
	jbsr ___sjthrow
	.even
L1741:
L1732:
	jbsr ___terminate
	.even
L1740:
	moveml a5@(-172),#0x5cfc
	fmovem a5@(-132),#0x3f
	unlk a5
	rts
	.even
.globl _destroyApplicationInstance__7AppBaseP7AppBase
_destroyApplicationInstance__7AppBaseP7AppBase:
	pea a5@
	movel sp,a5
	movel a5@(8),a1
	tstl a1
	jeq L1744
	movel a1@,a0
	pea 3:w
	movel a1,sp@-
	movel a0@(20),a0
	jbsr a0@
L1744:
	unlk a5
	rts
LC1:
	.ascii "width\0"
LC2:
	.ascii "height\0"
	.even
.globl ___9P2HackApp
___9P2HackApp:
	link a5,#-464
	fmovem #0xfc,sp@-
	moveml #0x3f3a,sp@-
	jbsr ___get_eh_context
	movel d0,a5@(-436)
	movel d0,a5@(-452)
	movel a5@(8),a0
	movel #___vt_7AppBase,a0@
	movel a5@(-436),a0
	addql #4,a0
	movel a0@,a5@(-24)
	clrl a5@(-20)
	movel a5,a5@(-16)
	movel #L1753,a5@(-12)
	movel sp,a5@(-8)
	jra L1752
	.even
L1753:
	jra L1869
	.even
L1752:
	lea a5@(-24),a1
	movel a1,a0@
	pea 2:w
	movel a5@(8),d0
	addql #4,d0
	movel d0,sp@-
	movel d0,a5@(-456)
	movel a5@(-452),a2
	addql #4,a2
	movel a2,a5@(-460)
	jbsr ___10InputFocusUl
	movel a2,a0
	movel a2@,a5@(-48)
	clrl a5@(-44)
	movel a5,a5@(-40)
	movel #L1757,a5@(-36)
	movel sp,a5@(-32)
	jra L1756
	.even
L1757:
	jra L1870
	.even
L1756:
	lea a5@(-48),a1
	movel a1,a0@
	movel a5@(8),a2
	movel #___vt_9P2HackApp$10InputFocus,a2@(40)
	movel #___vt_9P2HackApp,a2@
	clrl a2@(46)
	clrl a2@(54)
	clrb a2@(62)
	addql #8,sp
	subql #2,sp
	moveb #0,sp@(1)
	subql #2,sp
	pea LC1
	jbsr _getInteger__7AppBasePCcb
	movel d0,a5@(-440)
	subql #2,sp
	moveb #0,sp@(1)
	subql #2,sp
	pea LC2
	jbsr _getInteger__7AppBasePCcb
	addw #16,sp
	movew a5@(-438),a2@(58)
	jne L1758
	movew #640,a2@(58)
L1758:
	movel a5@(8),a0
	movew d0,a0@(60)
	jne L1759
	movew #480,a0@(60)
L1759:
	pea _nothrow
	pea 318:w
	jbsr ___nw__FUlRC9nothrow_t
	movel d0,a5@(-444)
	movel a5@(-460),a1
	movel a1@,a5@(-72)
	clrl a5@(-68)
	movel a5,a5@(-64)
	movel #L1763,a5@(-60)
	movel sp,a5@(-56)
	jra L1762
	.even
L1763:
	jra L1871
	.even
L1762:
	moveq #-72,d0
	addl a5,d0
	movel a5@(-460),a2
	movel d0,a2@
	addql #8,sp
	movel a5@(-452),d1
	movel a5@(-444),a0
	movel #___vt_7Display,a0@
	movel a5@(-452),a0
	addql #4,a0
	movel a0@,a5@(-96)
	clrl a5@(-92)
	movel d0,a5@(-88)
	movel #L1768,a5@(-84)
	movel sp,a5@(-80)
L1768:
	lea a5@(-96),a1
	movel a1,a0@
	movel a5@(-444),a2
	addql #4,a2
	movel a2,a5@(-448)
	movel a5@(-452),d0
	moveq #2,d1
	movel d1,a2@
	movel #___vt_15InputDispatcher,a2@(24)
	pea a2@(4)
	jbsr ___7_LLBase
	movel a5@(-436),a0
	addql #4,a0
	movel a0@,a5@(-120)
	clrl a5@(-116)
	lea a5@(-96),a1
	movel a1,a5@(-112)
	movel #L1773,a5@(-108)
	movel sp,a5@(-104)
	movel a0,a5@(-464)
L1773:
	lea a5@(-120),a2
	movel a2,a0@
	addql #4,sp
	movel a5@(-436),a1
	addql #4,a1
	movel a1@,a0
	movel a0@,a1@
	movel a5@(-464),a0
	movel a0@,a5@(-168)
	clrl a5@(-164)
	lea a5@(-96),a1
	movel a1,a5@(-160)
	movel #L1782,a5@(-156)
	movel sp,a5@(-152)
L1782:
	lea a5@(-168),a0
	movel a5@(-464),a2
	movel a0,a2@
	movel a5@(-448),a1
	clrl a1@(20)
	movel a2@,a0
	movel a0@,a2@
	movel a5@(-436),a0
	addql #4,a0
	movel a0@,a5@(-216)
	clrl a5@(-212)
	lea a5@(-72),a2
	movel a2,a5@(-208)
	movel #L1795,a5@(-204)
	movel sp,a5@(-200)
	movel a0,a1
L1795:
	lea a5@(-216),a2
	movel a2,a0@
	movel a5@(-444),a0
	movel #___vt_18InteractiveDisplay$15InputDispatcher,a0@(28)
	movel #___vt_18InteractiveDisplay,a0@
	movel a1@,a0
	movel a0@,a1@
	movel a1@,a0
	movel a0@,a1@
	jra L1797
	.even
L1766:
	movel a5@(-436),a0
	addql #4,a0
	movel a0@,a5@(-264)
	clrl a5@(-260)
	lea a5@(-72),a1
	movel a1,a5@(-256)
	movel #L1809,a5@(-252)
	movel sp,a5@(-248)
L1809:
	lea a5@(-264),a2
	movel a2,a0@
	movel a5@(-444),a0
	movel #___vt_7Display,a0@
	movel a5@(-436),a1
	addql #4,a1
	movel a1@,a0
	movel a0@,a1@
	jbsr ___sjthrow
	.even
L1797:
	movel a5@(-464),a1
	movel a1@,a5@(-288)
	clrl a5@(-284)
	lea a5@(-72),a2
	movel a2,a5@(-280)
	movel #L1817,a5@(-276)
	movel sp,a5@(-272)
L1817:
	lea a5@(-288),a1
	movel a5@(-464),a0
	movel a1,a0@
	movel a5@(-444),a2
	pea a2@(32)
	jbsr ___12NativeWindow
	movel a5@(-464),a0
	movel a0@,a5@(-312)
	clrl a5@(-308)
	lea a5@(-72),a1
	movel a1,a5@(-304)
	movel #L1820,a5@(-300)
	movel sp,a5@(-296)
L1820:
	lea a5@(-312),a0
	movel a5@(-464),a2
	movel a0,a2@
	movel a5@(-444),a1
	movel #___vt_17InteractiveWindow$15InputDispatcher,a1@(28)
	movel #___vt_17InteractiveWindow,a1@
	movel a2@,a0
	movel a0@,a2@
	movel a2@,a0
	movel a0@,a2@
	jra L1822
	.even
L1815:
	movel a5@(-464),a2
	movel a2@,a5@(-360)
	clrl a5@(-356)
	lea a5@(-72),a0
	movel a0,a5@(-352)
	movel #L1829,a5@(-348)
	movel sp,a5@(-344)
L1829:
	lea a5@(-360),a2
	movel a5@(-464),a1
	movel a2,a1@
	movel a5@(-444),a0
	movel #___vt_18InteractiveDisplay$15InputDispatcher,a0@(28)
	movel #___vt_18InteractiveDisplay,a0@+
	movel #___vt_15InputDispatcher,a0@(24)
	pea 2:w
	pea a0@(4)
	jbsr __$_7_LLBase
	addql #8,sp
	movel a5@(-444),a1
	movel #___vt_7Display,a1@
	movel a5@(-464),a2
	movel a2@,a0
	movel a0@,a2@
	jbsr ___sjthrow
	.even
L1827:
	jbsr ___terminate
	.even
L1822:
	movel a5@(8),a0
	movel a5@(-444),a0@(46)
	movel a5@(-460),a1
	movel a1@,a0
	movel a0@,a1@
	movel a1@,a0
	movel a0@,a1@
	movel a1@,a0
	movel a0@,a1@
	movel a5@(8),d0
	jra L1868
	.even
L1871:
L1760:
	movel a5@(-460),a2
	movel a2@,a5@(-384)
	clrl a5@(-380)
	lea a5@(-376),a0
	movel a5,a0@
	movel #L1848,a0@(4)
	movel sp,a0@(8)
	jra L1847
	.even
L1848:
	jra L1872
	.even
L1847:
	lea a5@(-384),a1
	movel a5@(-460),a0
	movel a1,a0@
	moveq #1,d0
	jeq L1850
	pea _nothrow
	movel a5@(-444),sp@-
	jbsr ___dl__FPvRC9nothrow_t
	addql #8,sp
L1850:
	movel a5@(-460),a1
	movel a1@,a0
	movel a0@,a1@
	jbsr ___sjthrow
	.even
L1870:
L1754:
	movel a5@(-460),a2
	movel a2@,a5@(-408)
	clrl a5@(-404)
	lea a5@(-400),a0
	movel a5,a0@
	movel #L1854,a0@(4)
	movel sp,a0@(8)
	jra L1853
	.even
L1854:
	jra L1873
	.even
L1853:
	lea a5@(-408),a1
	movel a5@(-460),a0
	movel a1,a0@
	movel a5@(-456),a2
	movel #___vt_10InputFocus,a2@(36)
	movel a0@,a0
	movel a5@(-460),a1
	movel a0@,a1@
	jbsr ___sjthrow
	.even
L1869:
L1750:
	movel a5@(-460),a2
	movel a2@,a5@(-432)
	clrl a5@(-428)
	lea a5@(-424),a0
	movel a5,a0@
	movel #L1862,a0@(4)
	movel sp,a0@(8)
	jra L1861
	.even
L1862:
	jra L1874
	.even
L1861:
	lea a5@(-432),a1
	movel a5@(-460),a0
	movel a1,a0@
	movel a5@(8),a2
	movel #___vt_7AppBase,a2@
	movel a0@,a0
	movel a5@(-460),a1
	movel a0@,a1@
	jbsr ___sjthrow
	.even
L1872:
L1845:
	jbsr ___terminate
	.even
L1873:
L1851:
	jbsr ___terminate
	.even
L1874:
L1859:
	jbsr ___terminate
	.even
L1868:
	moveml a5@(-576),#0x5cfc
	fmovem a5@(-536),#0x3f
	unlk a5
	rts
	.even
.globl __$_9P2HackApp
__$_9P2HackApp:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel a5@(8),a2
	movel #___vt_9P2HackApp$10InputFocus,a2@(40)
	movel #___vt_9P2HackApp,a2@
	movel a2@(54),d0
	jeq L1877
	pea 3:w
	movel d0,sp@-
	jbsr __$_10Rasterizer
	addql #8,sp
L1877:
	movel a2@(46),a1
	tstl a1
	jeq L1880
	movel a1@,a0
	pea 3:w
	movel a1,sp@-
	movel a0@(44),a0
	jbsr a0@
	addql #8,sp
L1880:
	movel #___vt_10InputFocus,a2@(40)
	movel #___vt_7AppBase,a2@
	movel a5@(12),d0
	btst #0,d0
	jeq L1888
	movel a2,sp@-
	jbsr ___builtin_delete
L1888:
	movel a5@(-4),a2
	unlk a5
	rts
	.even
.globl _keyPressNonPrintable__9P2HackAppP15InputDispatcherQ23Key7CtrlKey
_keyPressNonPrintable__9P2HackAppP15InputDispatcherQ23Key7CtrlKey:
	pea a5@
	movel sp,a5
	moveq #5,d0
	cmpl a5@(16),d0
	jne L1894
	movel a5@(8),a0
	moveb #1,a0@(62)
L1894:
	unlk a5
	rts
LC3:
	.ascii "Failed to create application window\0"
LC4:
	.ascii "Exit\0"
LC5:
	.ascii "Error\0"
LC6:
	.ascii "P2Hack\0"
LC7:
	.ascii "Failed to open application window\0"
LC8:
	.ascii "Failed to obtain Rasterizer\0"
	.even
.globl _initApplication__9P2HackApp
_initApplication__9P2HackApp:
	link a5,#-4
	moveml #0x2030,sp@-
	movel a5@(8),a3
	movel a3@(46),a1
	tstl a1
	jne L1896
	pea LC3
	jra L1920
	.even
L1896:
	movel a1@,a0
	pea LC6
	pea 15:w
	movew a3@(60),a2
	movel a2,sp@-
	movew a3@(58),a2
	movel a2,sp@-
	movel a1,sp@-
	movel a0@(8),a0
	jbsr a0@
	addw #20,sp
	tstl d0
	jeq L1897
	pea LC7
	jra L1920
	.even
L1897:
	movel a3@(46),a0
	movel a0@,a1
	movel a0,sp@-
	movel a1@(40),a0
	jbsr a0@
	movel d0,sp@
	jbsr _obtain__10RasterizerP7Surface
	movel d0,a2
	addql #4,sp
	movel a2,a3@(54)
	jne L1899
	pea LC8
L1920:
	pea LC4
	pea LC5
	jbsr _dialogueBox__9SystemLibPCcN21e
	movel #-50659333,d0
	jra L1919
	.even
L1899:
	pea 2:w
	movel __8Native3D$state+68,sp@-
	movel a2@(4),sp@-
	jbsr _W3D_SetState
	addw #12,sp
	tstl d0
	jne L1901
	bclr #1,a2@(165)
	jra L1902
	.even
L1901:
	bset #1,a2@(165)
L1902:
	movel a3@(54),a2
	pea 2:w
	movel __8Native3D$state+16,sp@-
	movel a2@(4),sp@-
	jbsr _W3D_SetState
	addw #12,sp
	tstl d0
	jne L1904
	moveq #-17,d0
	andl d0,a2@(164)
	jra L1905
	.even
L1904:
	moveq #16,d0
	orl d0,a2@(164)
L1905:
	movel a3@(54),a2
	pea 2:w
	movel __8Native3D$state,sp@-
	movel a2@(4),sp@-
	jbsr _W3D_SetState
	addw #12,sp
	tstl d0
	jne L1907
	moveq #-2,d0
	andl d0,a2@(164)
	jra L1908
	.even
L1907:
	moveq #1,d0
	orl d0,a2@(164)
L1908:
	movel a3@(54),a2
	pea 1:w
	movel __8Native3D$state+56,sp@-
	movel a2@(4),sp@-
	jbsr _W3D_SetState
	addw #12,sp
	tstl d0
	jne L1910
	orw #16384,a2@(166)
	jra L1911
	.even
L1910:
	andw #49151,a2@(166)
L1911:
	movel #-6250336,a5@(-4)
	movel a5@(-4),sp@-
	movel a3@(54),sp@-
	jbsr _setFlatColour__10RasterizerG6Colour
	movel a3@(46),d0
	addql #4,d0
	lea a3@(4),a2
	addql #8,sp
	tstl a2
	jeq L1917
	movel d0,d2
	addql #4,d2
	movel a2,sp@-
	movel d2,sp@-
	jbsr _contains__7_LLBasePv
	addql #8,sp
	tstb d0
	jne L1917
	movel a2,sp@-
	movel d2,sp@-
	jbsr _insLast__7_LLBasePv
	addql #8,sp
L1917:
	movel a3,sp@-
	jbsr _clear__9P2HackApp
	clrl d0
L1919:
	moveml a5@(-16),#0xc04
	unlk a5
	rts
	.even
.globl _clear__9P2HackApp
_clear__9P2HackApp:
	link a5,#-4
	movel a3,sp@-
	movel a2,sp@-
	movel a5@(8),a3
	movel a3@(54),a2
	btst #1,a2@(175)
	jne L1933
	movel a2@(4),sp@-
	jbsr _W3D_LockHardware
	addql #4,sp
	tstl d0
	jne L1932
	moveq #2,d0
	orl d0,a2@(172)
L1933:
	movel a3@(54),a0
	clrl a5@(-4)
	clrl sp@-
	movel a0@(4),sp@-
	jbsr _W3D_ClearDrawRegion
	addql #8,sp
	movel a3@(54),a0
	movel a0@(4),sp@-
	jbsr _W3D_FlushFrame
	addql #4,sp
	movel a3@(54),a0
	moveq #-3,d0
	andl d0,a0@(172)
	movel a0@(4),sp@-
	jbsr _W3D_UnLockHardware
	addql #4,sp
	movel a3@(46),a0
	movel a0@,a1
	movel a0,sp@-
	movel a1@(28),a0
	jbsr a0@
L1932:
	movel a5@(-12),a2
	movel a5@(-8),a3
	unlk a5
	rts
	.even
.globl _trianglePIO__9P2HackApp
_trianglePIO__9P2HackApp:
	pea a5@
	movel sp,a5
	moveml #0x38,sp@-
	movel a5@(8),a4
	movel a4@(54),a2
	btst #1,a2@(175)
	jne L1952
	movel a2@(4),sp@-
	jbsr _W3D_LockHardware
	addql #4,sp
	tstl d0
	jne L1951
	moveq #2,d0
	orl d0,a2@(172)
L1952:
	movel #0x41000000,sp@-
	movel #37328,sp@-
	movel a4@(54),a0
	movel a0@(4),sp@-
	lea _setP2_RegisterF,a2
	jbsr a2@
	movew a4@(60),a0
	movel a0,d0
	subql #8,d0
	fsmovel d0,fp0
	fmoves fp0,sp@-
	movel #37336,sp@-
	movel a4@(54),a0
	movel a0@(4),sp@-
	jbsr a2@
	movel #-16776961,sp@-
	movel #37360,sp@-
	movel a4@(54),a0
	movel a0@(4),sp@-
	lea _setP2_RegisterU,a3
	jbsr a3@
	addw #36,sp
	movew a4@(58),d0
	asrw #1,d0
	fsmovew d0,fp0
	fmoves fp0,sp@-
	movel #37456,sp@-
	movel a4@(54),a0
	movel a0@(4),sp@-
	jbsr a2@
	movel #0x41000000,sp@-
	movel #37464,sp@-
	movel a4@(54),a0
	movel a0@(4),sp@-
	jbsr a2@
	movel #-16711936,sp@-
	movel #37488,sp@-
	movel a4@(54),a0
	movel a0@(4),sp@-
	jbsr a3@
	addw #36,sp
	movew a4@(58),a0
	movel a0,d0
	subql #8,d0
	fsmovel d0,fp0
	fmoves fp0,sp@-
	movel #37584,sp@-
	movel a4@(54),a0
	movel a0@(4),sp@-
	jbsr a2@
	movew a4@(60),a0
	movel a0,d0
	subql #8,d0
	fsmovel d0,fp0
	fmoves fp0,sp@-
	movel #37592,sp@-
	movel a4@(54),a0
	movel a0@(4),sp@-
	jbsr a2@
	movel #-65536,sp@-
	movel #37616,sp@-
	movel a4@(54),a0
	movel a0@(4),sp@-
	jbsr a3@
	addw #32,sp
	movel #65600,sp@
	movel #37640,sp@-
	movel a4@(54),a0
	movel a0@(4),sp@-
	jbsr a3@
	movel a4@(54),a0
	addqw #8,sp
	movel a0@(4),sp@
	jbsr _W3D_FlushFrame
	addql #4,sp
	movel a4@(54),a0
	moveq #-3,d0
	andl d0,a0@(172)
	movel a0@(4),sp@-
	jbsr _W3D_UnLockHardware
	addql #4,sp
	movel a4@(46),a0
	movel a0@,a1
	movel a0,sp@-
	movel a1@(28),a0
	jbsr a0@
L1951:
	moveml a5@(-12),#0x1c00
	unlk a5
	rts
	.even
.globl _runApplication__9P2HackApp
_runApplication__9P2HackApp:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel a5@(8),a2
	movel a2,sp@-
	jbsr _trianglePIO__9P2HackApp
	jra L1963
	.even
L1957:
	movel a2@(46),a0
	movel a0@(28),a1
	pea a0@(4)
	movel a1@(20),a0
	jbsr a0@
	addql #4,sp
	tstb d0
	jne L1957
	movel a2@(46),a0
	movel a0@(28),a1
	pea a0@(4)
	movel a1@(16),a0
	jbsr a0@
L1963:
	addql #4,sp
	tstb a2@(62)
	jeq L1957
	clrl d0
	movel a5@(-4),a2
	unlk a5
	rts
	.even
___thunk_4_keyPressNonPrintable__9P2HackAppP15InputDispatcherQ23Key7CtrlKey:
	pea a5@
	movel sp,a5
	movel a5@(16),sp@-
	movel a5@(12),sp@-
	movel a5@(8),d0
	subql #4,d0
	movel d0,sp@-
	jbsr _keyPressNonPrintable__9P2HackAppP15InputDispatcherQ23Key7CtrlKey
	unlk a5
	rts
	.even
___thunk_4__$_9P2HackApp:
	pea a5@
	movel sp,a5
	movel a5@(12),sp@-
	movel a5@(8),d0
	subql #4,d0
	movel d0,sp@-
	jbsr __$_9P2HackApp
	unlk a5
	rts
.globl ___vt_9P2HackApp$10InputFocus
	.even
___vt_9P2HackApp$10InputFocus:
	.long -4
	.long 0
	.long ___thunk_4_keyPressNonPrintable__9P2HackAppP15InputDispatcherQ23Key7CtrlKey
	.long _keyReleaseNonPrintable__10InputFocusP15InputDispatcherQ23Key7CtrlKey
	.long _keyPressPrintable__10InputFocusP15InputDispatcherl
	.long _keyReleasePrintable__10InputFocusP15InputDispatcherl
	.long _mousePress__10InputFocusP15InputDispatcherUl
	.long _mouseRelease__10InputFocusP15InputDispatcherUl
	.long _mouseMove__10InputFocusP15InputDispatcherssss
	.long _mouseDrag__10InputFocusP15InputDispatcherssssUl
	.long _mouseScroll__10InputFocusP15InputDispatcherss
	.long _exitEvent__10InputFocusP15InputDispatcher
	.long ___thunk_4__$_9P2HackApp
	.skip 4
.globl ___vt_9P2HackApp
	.even
___vt_9P2HackApp:
	.long 0
	.long 0
	.long _initApplication__9P2HackApp
	.long _doneApplication__7AppBase
	.long _runApplication__9P2HackApp
	.long __$_9P2HackApp
	.skip 4
	.even
___thunk_4__$_18InteractiveDisplay:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel d2,sp@-
	movel a5@(8),a0
	movel a5@(12),d2
	lea a0@(-4),a2
	movel #___vt_18InteractiveDisplay$15InputDispatcher,a2@(28)
	movel #___vt_18InteractiveDisplay,a2@
	movel #___vt_15InputDispatcher,a0@(24)
	pea 2:w
	pea a0@(4)
	jbsr __$_7_LLBase
	addql #8,sp
	movel #___vt_7Display,a2@
	btst #0,d2
	jeq L1968
	movel a2,sp@-
	jbsr ___builtin_delete
L1968:
	movel a5@(-8),d2
	movel a5@(-4),a2
	unlk a5
	rts
	.even
___vt_18InteractiveDisplay$15InputDispatcher:
	.long -4
	.long 0
	.long ___pure_virtual
	.long ___pure_virtual
	.long ___pure_virtual
	.long ___pure_virtual
	.long ___pure_virtual
	.long ___thunk_4__$_18InteractiveDisplay
	.skip 4
	.even
___vt_18InteractiveDisplay:
	.long 0
	.long 0
	.long ___pure_virtual
	.long ___pure_virtual
	.long ___pure_virtual
	.long ___pure_virtual
	.long ___pure_virtual
	.long ___pure_virtual
	.long ___pure_virtual
	.long ___pure_virtual
	.long ___pure_virtual
	.long __$_18InteractiveDisplay
	.skip 4
	.even
___vt_7Display:
	.long 0
	.long 0
	.long ___pure_virtual
	.long ___pure_virtual
	.long ___pure_virtual
	.long ___pure_virtual
	.long ___pure_virtual
	.long ___pure_virtual
	.long ___pure_virtual
	.long ___pure_virtual
	.long ___pure_virtual
	.long __$_7Display
	.skip 4
	.even
___vt_10InputFocus:
	.long 0
	.long 0
	.long _keyPressNonPrintable__10InputFocusP15InputDispatcherQ23Key7CtrlKey
	.long _keyReleaseNonPrintable__10InputFocusP15InputDispatcherQ23Key7CtrlKey
	.long _keyPressPrintable__10InputFocusP15InputDispatcherl
	.long _keyReleasePrintable__10InputFocusP15InputDispatcherl
	.long _mousePress__10InputFocusP15InputDispatcherUl
	.long _mouseRelease__10InputFocusP15InputDispatcherUl
	.long _mouseMove__10InputFocusP15InputDispatcherssss
	.long _mouseDrag__10InputFocusP15InputDispatcherssssUl
	.long _mouseScroll__10InputFocusP15InputDispatcherss
	.long _exitEvent__10InputFocusP15InputDispatcher
	.long __$_10InputFocus
	.skip 4
	.even
___vt_15InputDispatcher:
	.long 0
	.long 0
	.long ___pure_virtual
	.long ___pure_virtual
	.long ___pure_virtual
	.long ___pure_virtual
	.long ___pure_virtual
	.long __$_15InputDispatcher
	.skip 4
	.even
___vt_7AppBase:
	.long 0
	.long 0
	.long _initApplication__7AppBase
	.long _doneApplication__7AppBase
	.long ___pure_virtual
	.long __$_7AppBase
	.skip 4
	.even
_initApplication__7AppBase:
	pea a5@
	movel sp,a5
	clrl d0
	unlk a5
	rts
	.even
_doneApplication__7AppBase:
	pea a5@
	movel sp,a5
	unlk a5
	rts
	.even
__$_7AppBase:
	pea a5@
	movel sp,a5
	movel a5@(8),a0
	movel #___vt_7AppBase,a0@
	btst #0,a5@(15)
	jeq L18
	movel a0,sp@-
	jbsr ___builtin_delete
L18:
	unlk a5
	rts
	.even
__$_15InputDispatcher:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel d2,sp@-
	movel a5@(8),a2
	movel a5@(12),d2
	movel #___vt_15InputDispatcher,a2@(24)
	pea 2:w
	pea a2@(4)
	jbsr __$_7_LLBase
	addql #8,sp
	btst #0,d2
	jeq L468
	movel a2,sp@-
	jbsr ___builtin_delete
L468:
	movel a5@(-8),d2
	movel a5@(-4),a2
	unlk a5
	rts
	.even
_keyPressNonPrintable__10InputFocusP15InputDispatcherQ23Key7CtrlKey:
	pea a5@
	movel sp,a5
	unlk a5
	rts
	.even
_keyReleaseNonPrintable__10InputFocusP15InputDispatcherQ23Key7CtrlKey:
	pea a5@
	movel sp,a5
	unlk a5
	rts
	.even
_keyPressPrintable__10InputFocusP15InputDispatcherl:
	pea a5@
	movel sp,a5
	unlk a5
	rts
	.even
_keyReleasePrintable__10InputFocusP15InputDispatcherl:
	pea a5@
	movel sp,a5
	unlk a5
	rts
	.even
_mousePress__10InputFocusP15InputDispatcherUl:
	pea a5@
	movel sp,a5
	unlk a5
	rts
	.even
_mouseRelease__10InputFocusP15InputDispatcherUl:
	pea a5@
	movel sp,a5
	unlk a5
	rts
	.even
_mouseMove__10InputFocusP15InputDispatcherssss:
	pea a5@
	movel sp,a5
	unlk a5
	rts
	.even
_mouseDrag__10InputFocusP15InputDispatcherssssUl:
	pea a5@
	movel sp,a5
	unlk a5
	rts
	.even
_mouseScroll__10InputFocusP15InputDispatcherss:
	pea a5@
	movel sp,a5
	unlk a5
	rts
	.even
_exitEvent__10InputFocusP15InputDispatcher:
	pea a5@
	movel sp,a5
	unlk a5
	rts
	.even
__$_10InputFocus:
	pea a5@
	movel sp,a5
	movel a5@(8),a0
	movel #___vt_10InputFocus,a0@(36)
	btst #0,a5@(15)
	jeq L501
	movel a0,sp@-
	jbsr ___builtin_delete
L501:
	unlk a5
	rts
	.even
__$_7Display:
	pea a5@
	movel sp,a5
	movel a5@(8),a0
	movel #___vt_7Display,a0@
	btst #0,a5@(15)
	jeq L602
	movel a0,sp@-
	jbsr ___builtin_delete
L602:
	unlk a5
	rts
	.even
__$_18InteractiveDisplay:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel d2,sp@-
	movel a5@(8),a2
	movel a5@(12),d2
	movel #___vt_18InteractiveDisplay$15InputDispatcher,a2@(28)
	movel a2,a0
	movel #___vt_18InteractiveDisplay,a0@+
	movel #___vt_15InputDispatcher,a0@(24)
	pea 2:w
	pea a0@(4)
	jbsr __$_7_LLBase
	addql #8,sp
	movel #___vt_7Display,a2@
	btst #0,d2
	jeq L899
	movel a2,sp@-
	jbsr ___builtin_delete
L899:
	movel a5@(-8),d2
	movel a5@(-4),a2
	unlk a5
	rts
