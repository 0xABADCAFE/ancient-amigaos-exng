#NO_APP
.text
LC0:
	.ascii "bad_alloc\0"
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
	pea 102:w
	jbsr ___nw__FUlRC9nothrow_t
	movel d0,a5@(-52)
	movel a5@(-56),a0
	addql #4,a0
	movel a0@,a5@(-24)
	clrl a5@(-20)
	movel a5,a5@(-16)
	movel #L1913,a5@(-12)
	movel sp,a5@(-8)
	movel a0,a5@(-60)
	jra L1912
	.even
L1913:
	movel a5@(-56),a0
	addql #4,a0
	movel a0,a5@(-60)
	jra L1910
	.even
L1912:
	lea a5@(-24),a1
	movel a1,a0@
	movel a5@(-52),sp@-
	jbsr ___7WarpApp
	movel a5@(-60),a1
	movel a1@,a0
	movel a0@,a1@
	jra L1924
	.even
L1910:
	movel a5@(-60),a0
	movel a0@,a5@(-48)
	clrl a5@(-44)
	movel a5,a5@(-40)
	movel #L1919,a5@(-36)
	movel sp,a5@(-32)
	jra L1918
	.even
L1919:
	jra L1925
	.even
L1918:
	lea a5@(-48),a0
	movel a5@(-60),a1
	movel a0,a1@
	moveq #1,d0
	jeq L1921
	pea _nothrow
	movel a5@(-52),sp@-
	jbsr ___dl__FPvRC9nothrow_t
	addql #8,sp
L1921:
	movel a5@(-56),a1
	addql #4,a1
	movel a1@,a0
	movel a0@,a1@
	jbsr ___sjthrow
	.even
L1925:
L1916:
	jbsr ___terminate
	.even
L1924:
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
	jeq L1928
	movel a1@,a0
	pea 3:w
	movel a1,sp@-
	movel a0@(20),a0
	jbsr a0@
L1928:
	unlk a5
	rts
LC1:
	.ascii "scale\0"
LC2:
	.ascii "image\0"
LC3:
	.ascii "light\0"
LC4:
	.ascii "data/texture.ppm\0"
LC5:
	.ascii "data/lightmap128.png\0"
	.even
.globl ___7WarpApp
___7WarpApp:
	link a5,#-572
	fmovem #0xfc,sp@-
	moveml #0x3f3a,sp@-
	jbsr ___get_eh_context
	movel d0,a5@(-532)
	movel d0,a5@(-558)
	movel a5@(8),a0
	movel #___vt_7AppBase,a0@
	movel a5@(-532),a0
	addql #4,a0
	movel a0@,a5@(-24)
	clrl a5@(-20)
	movel a5,a5@(-16)
	movel #L1937,a5@(-12)
	movel sp,a5@(-8)
	jra L1936
	.even
L1937:
	jra L2082
	.even
L1936:
	lea a5@(-24),a1
	movel a1,a0@
	pea 2:w
	movel a5@(8),d0
	addql #4,d0
	movel d0,sp@-
	movel d0,a5@(-562)
	movel a5@(-558),a2
	addql #4,a2
	movel a2,a5@(-566)
	jbsr ___10InputFocusUl
	movel a2,a0
	movel a2@,a5@(-48)
	clrl a5@(-44)
	movel a5,a5@(-40)
	movel #L1941,a5@(-36)
	movel sp,a5@(-32)
	jra L1940
	.even
L1941:
	jra L2083
	.even
L1940:
	lea a5@(-48),a1
	movel a1,a0@
	movel a5@(8),a2
	movel #___vt_7WarpApp$10InputFocus,a2@(40)
	movel #___vt_7WarpApp,a2@
	clrl a2@(48)
	clrl a2@(60)
	clrl a2@(64)
	clrl a2@(76)
	addqw #4,sp
	movel #_nothrow,sp@
	pea 128:w
	jbsr ___vn__FUlRC9nothrow_t
	movel d0,a2@(44)
	subql #2,sp
	moveb #0,sp@(1)
	subql #2,sp
	pea LC1
	jbsr _getFloat__7AppBasePCcb
	movel d1,sp@-
	movel d0,sp@-
	fdmoved sp@+,fp0
	addw #16,sp
	fcmpd #0r1.000000000000005,fp0
	fjlt L1942
	fcmpd #0r8.000000000000005,fp0
	fjle L1944
	fmoved #0r8.000000000000005,fp0
	jra L1944
	.even
L1942:
	fmoved #0r1.000000000000005,fp0
L1944:
	fsmovex fp0,fp0
	movel a5@(8),a0
	fmoves fp0,a0@(88)
	movew #3,a0@(92)
	subql #2,sp
	moveb #0,sp@(1)
	subql #2,sp
	pea LC2
	jbsr _getString__7AppBasePCcb
	movel a5@(8),a1
	movel d0,a1@(52)
	subql #2,sp
	moveb #0,sp@(1)
	subql #2,sp
	pea LC3
	jbsr _getString__7AppBasePCcb
	movel a5@(8),a2
	movel d0,a2@(56)
	addw #16,sp
	tstl a2@(52)
	jne L1947
	movel #LC4,a2@(52)
L1947:
	movel a5@(8),a0
	tstl a0@(56)
	jne L1948
	movel #LC5,a0@(56)
L1948:
	pea _nothrow
	pea 318:w
	jbsr ___nw__FUlRC9nothrow_t
	movel d0,a5@(-536)
	moveb #1,a5@(-537)
	movel a5@(-566),a1
	movel a1@,a5@(-72)
	clrl a5@(-68)
	movel a5,a5@(-64)
	movel #L1952,a5@(-60)
	movel sp,a5@(-56)
	jra L1951
	.even
L1952:
	jra L2084
	.even
L1951:
	moveq #-72,d0
	addl a5,d0
	movel a5@(-566),a2
	movel d0,a2@
	addql #8,sp
	movel a5@(-558),d1
	movel a5@(-536),a0
	movel #___vt_7Display,a0@
	movel a5@(-558),a0
	addql #4,a0
	movel a0@,a5@(-96)
	clrl a5@(-92)
	movel d0,a5@(-88)
	movel #L1957,a5@(-84)
	movel sp,a5@(-80)
L1957:
	lea a5@(-96),a1
	movel a1,a0@
	movel a5@(-536),a2
	addql #4,a2
	movel a2,a5@(-542)
	movel a5@(-558),d0
	moveq #2,d1
	movel d1,a2@
	movel #___vt_15InputDispatcher,a2@(24)
	pea a2@(4)
	jbsr ___7_LLBase
	movel a5@(-532),a0
	addql #4,a0
	movel a0@,a5@(-120)
	clrl a5@(-116)
	lea a5@(-96),a1
	movel a1,a5@(-112)
	movel #L1962,a5@(-108)
	movel sp,a5@(-104)
	movel a0,a5@(-570)
L1962:
	lea a5@(-120),a2
	movel a2,a0@
	addql #4,sp
	movel a5@(-532),a1
	addql #4,a1
	movel a1@,a0
	movel a0@,a1@
	movel a5@(-570),a0
	movel a0@,a5@(-168)
	clrl a5@(-164)
	lea a5@(-96),a1
	movel a1,a5@(-160)
	movel #L1971,a5@(-156)
	movel sp,a5@(-152)
L1971:
	lea a5@(-168),a0
	movel a5@(-570),a2
	movel a0,a2@
	movel a5@(-542),a1
	clrl a1@(20)
	movel a2@,a0
	movel a0@,a2@
	movel a5@(-532),a0
	addql #4,a0
	movel a0@,a5@(-216)
	clrl a5@(-212)
	lea a5@(-72),a2
	movel a2,a5@(-208)
	movel #L1984,a5@(-204)
	movel sp,a5@(-200)
	movel a0,a1
L1984:
	lea a5@(-216),a2
	movel a2,a0@
	movel a5@(-536),a0
	movel #___vt_18InteractiveDisplay$15InputDispatcher,a0@(28)
	movel #___vt_18InteractiveDisplay,a0@
	movel a1@,a0
	movel a0@,a1@
	movel a1@,a0
	movel a0@,a1@
	jra L1986
	.even
L1955:
	movel a5@(-532),a0
	addql #4,a0
	movel a0@,a5@(-264)
	clrl a5@(-260)
	lea a5@(-72),a1
	movel a1,a5@(-256)
	movel #L1998,a5@(-252)
	movel sp,a5@(-248)
L1998:
	lea a5@(-264),a2
	movel a2,a0@
	movel a5@(-536),a0
	movel #___vt_7Display,a0@
	movel a5@(-532),a1
	addql #4,a1
	movel a1@,a0
	movel a0@,a1@
	jbsr ___sjthrow
	.even
L1986:
	movel a5@(-570),a1
	movel a1@,a5@(-288)
	clrl a5@(-284)
	lea a5@(-72),a2
	movel a2,a5@(-280)
	movel #L2006,a5@(-276)
	movel sp,a5@(-272)
L2006:
	lea a5@(-288),a1
	movel a5@(-570),a0
	movel a1,a0@
	movel a5@(-536),a2
	pea a2@(32)
	jbsr ___12NativeWindow
	movel a5@(-570),a0
	movel a0@,a5@(-312)
	clrl a5@(-308)
	lea a5@(-72),a1
	movel a1,a5@(-304)
	movel #L2009,a5@(-300)
	movel sp,a5@(-296)
L2009:
	lea a5@(-312),a0
	movel a5@(-570),a2
	movel a0,a2@
	movel a5@(-536),a1
	movel #___vt_17InteractiveWindow$15InputDispatcher,a1@(28)
	movel #___vt_17InteractiveWindow,a1@
	addql #4,sp
	movel a2@,a0
	movel a0@,a2@
	movel a2@,a0
	movel a0@,a2@
	jra L2011
	.even
L2004:
	movel a5@(-570),a2
	movel a2@,a5@(-360)
	clrl a5@(-356)
	lea a5@(-72),a0
	movel a0,a5@(-352)
	movel #L2018,a5@(-348)
	movel sp,a5@(-344)
L2018:
	lea a5@(-360),a2
	movel a5@(-570),a1
	movel a2,a1@
	movel a5@(-536),a0
	movel #___vt_18InteractiveDisplay$15InputDispatcher,a0@(28)
	movel #___vt_18InteractiveDisplay,a0@+
	movel #___vt_15InputDispatcher,a0@(24)
	pea 2:w
	pea a0@(4)
	jbsr __$_7_LLBase
	addql #8,sp
	movel a5@(-536),a1
	movel #___vt_7Display,a1@
	movel a5@(-570),a2
	movel a2@,a0
	movel a0@,a2@
	jbsr ___sjthrow
	.even
L2016:
	jbsr ___terminate
	.even
L2011:
	clrb a5@(-537)
	movel a5@(8),a0
	movel a5@(-536),a0@(48)
	movel a5@(-566),a1
	movel a1@,a0
	movel a0@,a1@
	pea _nothrow
	pea 40:w
	jbsr ___nw__FUlRC9nothrow_t
	movel d0,a5@(-546)
	moveb #1,a5@(-547)
	movel a5@(-566),a2
	movel a2@,a5@(-384)
	clrl a5@(-380)
	lea a5@(-376),a0
	movel a5,a0@
	movel #L2036,a0@(4)
	movel sp,a0@(8)
	jra L2035
	.even
L2036:
	jra L2085
	.even
L2035:
	lea a5@(-384),a1
	movel a5@(-566),a0
	movel a1,a0@
	movel a5@(-546),sp@-
	jbsr ___7Texture
	clrb a5@(-547)
	movel a5@(8),a2
	movel d0,a2@(64)
	movel a5@(-566),a1
	movel a1@,a0
	movel a0@,a1@
	addqw #8,sp
	movel #_nothrow,sp@
	pea 40:w
	jbsr ___nw__FUlRC9nothrow_t
	movel d0,a5@(-552)
	moveb #1,a5@(-553)
	movel a5@(-566),a2
	movel a2@,a5@(-408)
	clrl a5@(-404)
	lea a5@(-400),a0
	movel a5,a0@
	movel #L2042,a0@(4)
	movel sp,a0@(8)
	jra L2041
	.even
L2042:
	jra L2086
	.even
L2041:
	lea a5@(-408),a1
	movel a5@(-566),a0
	movel a1,a0@
	movel a5@(-552),sp@-
	jbsr ___7Texture
	clrb a5@(-553)
	movel a5@(8),a2
	movel d0,a2@(68)
	movel a5@(-566),a1
	movel a1@,a0
	movel a0@,a1@
	addqw #8,sp
	movel #_nothrow,sp@
	movel #131200,sp@-
	jbsr ___vn__FUlRC9nothrow_t
	movel d0,a2@(76)
	pea _nothrow
	pea 16384:w
	jbsr ___vn__FUlRC9nothrow_t
	movel d0,a2@(84)
	movel a2@(76),d0
	addl #128,d0
	movel d0,a2@(80)
	subql #2,sp
	moveb #1,sp@(1)
	subql #2,sp
	movel a2@(56),sp@-
	jbsr _loadImage__11ImageLoaderPCcb
	movel d0,a2@(72)
	moveb a2@(100),d0
	orb #120,d0
	andb #251,d0
	moveb d0,a2@(100)
	movel a5@(-566),a1
	movel a1@,a0
	movel a0@,a1@
	movel a1@,a0
	movel a0@,a1@
	movel a2,d0
	jra L2081
	.even
L2084:
L1949:
	movel a5@(-566),a2
	movel a2@,a5@(-432)
	clrl a5@(-428)
	lea a5@(-424),a0
	movel a5,a0@
	movel #L2049,a0@(4)
	movel sp,a0@(8)
	jra L2048
	.even
L2049:
	jra L2087
	.even
L2048:
	lea a5@(-432),a1
	movel a5@(-566),a0
	movel a1,a0@
	tstb a5@(-537)
	jeq L2051
	pea _nothrow
	movel a5@(-536),sp@-
	jbsr ___dl__FPvRC9nothrow_t
	addql #8,sp
L2051:
	movel a5@(-566),a2
	movel a2@,a0
	movel a0@,a2@
	jbsr ___sjthrow
	.even
L2085:
L2033:
	movel a5@(-566),a0
	movel a0@,a5@(-456)
	clrl a5@(-452)
	lea a5@(-448),a0
	movel a5,a0@
	movel #L2055,a0@(4)
	movel sp,a0@(8)
	jra L2054
	.even
L2055:
	jra L2088
	.even
L2054:
	lea a5@(-456),a2
	movel a5@(-566),a1
	movel a2,a1@
	tstb a5@(-547)
	jeq L2057
	pea _nothrow
	movel a5@(-546),sp@-
	jbsr ___dl__FPvRC9nothrow_t
	addql #8,sp
L2057:
	movel a5@(-566),a1
	movel a1@,a0
	movel a0@,a1@
	jbsr ___sjthrow
	.even
L2086:
L2039:
	movel a5@(-566),a2
	movel a2@,a5@(-480)
	clrl a5@(-476)
	lea a5@(-472),a0
	movel a5,a0@
	movel #L2061,a0@(4)
	movel sp,a0@(8)
	jra L2060
	.even
L2061:
	jra L2089
	.even
L2060:
	lea a5@(-480),a1
	movel a5@(-566),a0
	movel a1,a0@
	tstb a5@(-553)
	jeq L2063
	pea _nothrow
	movel a5@(-552),sp@-
	jbsr ___dl__FPvRC9nothrow_t
	addql #8,sp
L2063:
	movel a5@(-566),a2
	movel a2@,a0
	movel a0@,a2@
	jbsr ___sjthrow
	.even
L2083:
L1938:
	movel a5@(-566),a0
	movel a0@,a5@(-504)
	clrl a5@(-500)
	lea a5@(-496),a0
	movel a5,a0@
	movel #L2067,a0@(4)
	movel sp,a0@(8)
	jra L2066
	.even
L2067:
	jra L2090
	.even
L2066:
	lea a5@(-504),a2
	movel a5@(-566),a1
	movel a2,a1@
	movel a5@(-562),a0
	movel #___vt_10InputFocus,a0@(36)
	movel a1@,a0
	movel a0@,a1@
	jbsr ___sjthrow
	.even
L2082:
L1934:
	movel a5@(-566),a1
	movel a1@,a5@(-528)
	clrl a5@(-524)
	lea a5@(-520),a0
	movel a5,a0@
	movel #L2075,a0@(4)
	movel sp,a0@(8)
	jra L2074
	.even
L2075:
	jra L2091
	.even
L2074:
	lea a5@(-528),a0
	movel a5@(-566),a2
	movel a0,a2@
	movel a5@(8),a1
	movel #___vt_7AppBase,a1@
	movel a2@,a0
	movel a0@,a2@
	jbsr ___sjthrow
	.even
L2087:
L2046:
	jbsr ___terminate
	.even
L2088:
L2052:
	jbsr ___terminate
	.even
L2089:
L2058:
	jbsr ___terminate
	.even
L2090:
L2064:
	jbsr ___terminate
	.even
L2091:
L2072:
	jbsr ___terminate
	.even
L2081:
	moveml a5@(-684),#0x5cfc
	fmovem a5@(-644),#0x3f
	unlk a5
	rts
	.even
.globl __$_7WarpApp
__$_7WarpApp:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel d2,sp@-
	movel a5@(8),a2
	movel #___vt_7WarpApp$10InputFocus,a2@(40)
	movel #___vt_7WarpApp,a2@
	movel a2@(64),d0
	jeq L2094
	pea 3:w
	movel d0,sp@-
	jbsr __$_7Texture
	addql #8,sp
L2094:
	movel a2@(68),d0
	jeq L2096
	pea 3:w
	movel d0,sp@-
	jbsr __$_7Texture
	addql #8,sp
L2096:
	movel a2@(72),d2
	jeq L2098
	movel d2,sp@-
	jbsr _destroy__11ImageBuffer
	movel d2,sp@
	jbsr ___builtin_delete
	addql #4,sp
L2098:
	movel a2@(60),d0
	jeq L2104
	pea 3:w
	movel d0,sp@-
	jbsr __$_10Rasterizer
	addql #8,sp
L2104:
	movel a2@(76),d0
	jeq L2106
	movel d0,sp@-
	jbsr ___builtin_vec_delete
	addql #4,sp
L2106:
	movel a2@(84),d0
	jeq L2108
	movel d0,sp@-
	jbsr ___builtin_vec_delete
	addql #4,sp
L2108:
	movel a2@(48),a1
	tstl a1
	jeq L2110
	movel a1@,a0
	pea 3:w
	movel a1,sp@-
	movel a0@(44),a0
	jbsr a0@
	addql #8,sp
L2110:
	movel a2@(44),d0
	jeq L2113
	movel d0,sp@-
	jbsr ___builtin_vec_delete
	addql #4,sp
L2113:
	movel #___vt_10InputFocus,a2@(40)
	movel #___vt_7AppBase,a2@
	movel a5@(12),d0
	btst #0,d0
	jeq L2121
	movel a2,sp@-
	jbsr ___builtin_delete
L2121:
	movel a5@(-8),d2
	movel a5@(-4),a2
	unlk a5
	rts
LC6:
	.ascii "Creating inverse alpha map for lightmap...\0"
LC7:
	.ascii "done\12\0"
	.even
.globl _createAlphaMap__7WarpApp
_createAlphaMap__7WarpApp:
	pea a5@
	movel sp,a5
	moveml #0x3c38,sp@-
	movel a5@(8),a3
	movel a3@(72),a0
	tstl a0
	jeq L2123
	movel a3@(68),d0
	jeq L2123
	movel a0@(8),d5
	jeq L2123
	clrl sp@-
	pea 9:w
	movew a0@(2),a1
	movel a1,sp@-
	movew a0@,a0
	movel a0,sp@-
	movel d0,sp@-
	jbsr _create__7TexturessQ23G3D5TexelP7Palette
	movel a3@(68),a0
	addw #20,sp
	movel a0@(16),a4
	tstl a4
	jeq L2123
	pea LC6
	lea _printf,a2
	jbsr a2@
	movel a3@(72),a0
	addql #4,sp
	movew a0@(2),d2
	muls a0@,d2
	subql #1,d2
	moveq #-1,d0
	cmpl d2,d0
	jeq L2133
	clrl d4
	clrl d3
	movel d5,a1
	subql #1,a1
	.even
L2134:
	addql #4,a1
	moveb a1@(-2),d4
	movel d4,d1
	moveq #77,d0
	mulsl d0,d1
	moveb a1@(-1),d3
	movel d3,a3
	lea a3@(d3:l:4),a0
	movel a0,d0
	lsll #4,d0
	subl a0,d0
	movel d1,a3
	lea a3@(d0:l:2),a0
	clrl d1
	moveb a1@,d1
	movel d1,d0
	lsll #3,d0
	subl d1,d0
	lea a0@(d0:l:4),a0
	movel a0,d0
	lsrl #8,d0
	jlt L2139
	cmpl #255,d0
	jle L2141
	moveq #0,d0
	notb d0
	jra L2141
	.even
L2139:
	clrl d0
L2141:
	moveq #0,d1
	notb d1
	subl d0,d1
	movel d1,d0
	moveq #24,d1
	lsll d1,d0
	movel d0,a4@+
	dbra d2,L2134
	clrw d2
	subql #1,d2
	jcc L2134
L2133:
	pea LC7
	jbsr a2@
L2123:
	moveml a5@(-28),#0x1c3c
	unlk a5
	rts
LC8:
	.ascii "On\0"
LC9:
	.ascii "Off\0"
LC10:
	.ascii "Test %hd x %hd, Tex : %s, Lit : %s, Shd: %s\0"
	.even
.globl _updateTitle__7WarpApp
_updateTitle__7WarpApp:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel a5@(8),a2
	movel #LC9,d1
	movel d1,d0
	btst #4,a2@(100)
	jeq L2146
	movel #LC8,d0
L2146:
	movel d0,sp@-
	movel d1,d0
	btst #5,a2@(100)
	jeq L2148
	movel #LC8,d0
L2148:
	movel d0,sp@-
	movel d1,d0
	btst #6,a2@(100)
	jeq L2150
	movel #LC8,d0
L2150:
	movel d0,sp@-
	movew a2@(98),a0
	movel a0,sp@-
	movew a2@(98),a0
	movel a0,sp@-
	pea LC10
	movel a2@(44),sp@-
	jbsr _sprintf
	movel a2@(48),a0
	movel a0@,a1
	movel a2@(44),sp@-
	movel a0,sp@-
	movel a1@(36),a0
	jbsr a0@
	movel a5@(-4),a2
	unlk a5
	rts
	.even
.globl _keyPressNonPrintable__7WarpAppP15InputDispatcherQ23Key7CtrlKey
_keyPressNonPrintable__7WarpAppP15InputDispatcherQ23Key7CtrlKey:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel d2,sp@-
	movel a5@(8),a2
	moveq #1,d2
	movel a5@(16),d0
	subql #5,d0
	moveq #11,d1
	cmpl d0,d1
	jcs L2171
LI2172:
	movew pc@(L2172-LI2172-2:b,d0:l:2),d0
	jmp pc@(2,d0:w)
	.even
L2172:
	.word L2154-L2172
	.word L2171-L2172
	.word L2171-L2172
	.word L2171-L2172
	.word L2171-L2172
	.word L2171-L2172
	.word L2155-L2172
	.word L2156-L2172
	.word L2157-L2172
	.word L2158-L2172
	.word L2159-L2172
	.word L2165-L2172
	.even
L2154:
	orb #4,a2@(100)
	jra L2153
	.even
L2155:
	bfextu a2@(100){#1:#1},d0
	eorb #1,d0
	bfins d0,a2@(100){#1:#1}
	orb #128,a2@(100)
	jra L2153
	.even
L2156:
	bfextu a2@(100){#2:#1},d0
	eorb #1,d0
	bfins d0,a2@(100){#2:#1}
	orb #128,a2@(100)
	jra L2153
	.even
L2157:
	bfextu a2@(100){#3:#1},d0
	eorb #1,d0
	bfins d0,a2@(100){#3:#1}
	orb #128,a2@(100)
	jra L2153
	.even
L2158:
	bfextu a2@(100){#4:#1},d0
	eorb #1,d0
	bfins d0,a2@(100){#4:#1}
	orb #128,a2@(100)
	jra L2153
	.even
L2159:
	addqw #1,a2@(92)
	movew a2@(92),a0
	moveq #1,d0
	cmpl a0,d0
	jle L2175
	jra L2166
	.even
L2165:
	subqw #1,a2@(92)
	movew a2@(92),a0
	moveq #1,d0
	cmpl a0,d0
	jgt L2166
L2175:
	movel a0,d0
	moveq #6,d1
	cmpl d0,d1
	jge L2168
	moveq #6,d0
	jra L2168
	.even
L2166:
	moveq #1,d0
L2168:
	movew d0,a2@(92)
	movel a2,sp@-
	jbsr _initMesh__7WarpApp
	orb #128,a2@(100)
	addql #4,sp
	jra L2153
	.even
L2171:
	clrb d2
L2153:
	tstb d2
	jeq L2174
	movel a2,sp@-
	jbsr _updateTitle__7WarpApp
L2174:
	movel a5@(-8),d2
	movel a5@(-4),a2
	unlk a5
	rts
LC11:
	.ascii "Failed to create string buffer\0"
LC12:
	.ascii "Exit\0"
LC13:
	.ascii "Error\0"
LC14:
	.ascii "Failed to create mesh\0"
LC15:
	.ascii "Failed to create application window\0"
LC16:
	.ascii "Failed to load RGB lightmap\0"
LC17:
	.ascii "Failed to create texture\0"
LC18:
	.ascii "Failed to load image\12'%s'\0"
LC19:
	.ascii "Test\0"
LC20:
	.ascii "Failed to open application window\0"
LC21:
	.ascii "Failed to obtain Rasterizer\0"
LC22:
	.ascii "Failed to set vertex array\0"
LC23:
	.ascii "Failed to associate texture\0"
LC24:
	.ascii "Failed to associate light map\0"
	.even
.globl _initApplication__7WarpApp
_initApplication__7WarpApp:
	link a5,#-4
	moveml #0x2030,sp@-
	movel a5@(8),a3
	tstl a3@(44)
	jne L2177
	pea LC11
	jra L2230
	.even
L2177:
	tstl a3@(80)
	jne L2178
	pea LC14
	jra L2230
	.even
L2178:
	tstl a3@(48)
	jne L2179
	pea LC15
	jra L2230
	.even
L2179:
	tstl a3@(72)
	jne L2180
	pea LC16
	jra L2230
	.even
L2180:
	movel a3@(64),d0
	jne L2181
	pea LC17
	jra L2230
	.even
L2181:
	pea 9:w
	movel a3@(52),sp@-
	movel d0,sp@-
	jbsr _loadPPM__13TextureLoaderP7TexturePCcQ23G3D5Texel
	addw #12,sp
	tstl d0
	jeq L2182
	movel a3@(52),sp@-
	pea LC18
	pea LC12
	pea LC13
	jbsr _dialogueBox__9SystemLibPCcN21e
	movel #-50659333,d0
	jra L2229
	.even
L2182:
	movel a3@(64),a0
	movew a0@,d0
	extl d0
	fsmoves a3@(88),fp0
	fsmull d0,fp0
	fmoveml fpcr,d1
	moveq #16,d2
	orl d1,d2
	andw #-33,d2
	fmoveml d2,fpcr
	fmovel fp0,d0
	fmoveml d1,fpcr
	cmpl #128,d0
	jlt L2185
	cmpl #1024,d0
	jle L2187
	movel #1024,d0
	jra L2187
	.even
L2185:
	moveq #127,d0
	notb d0
L2187:
	movew d0,a3@(94)
	movel a3@(64),a0
	movew a0@(2),d0
	extl d0
	fsmoves a3@(88),fp0
	fsmull d0,fp0
	fmoveml fpcr,d1
	moveq #16,d2
	orl d1,d2
	andw #-33,d2
	fmoveml d2,fpcr
	fmovel fp0,d0
	fmoveml d1,fpcr
	cmpl #128,d0
	jlt L2191
	cmpl #768,d0
	jle L2193
	movel #768,d0
	jra L2193
	.even
L2191:
	moveq #127,d0
	notb d0
L2193:
	movew d0,a3@(96)
	movel a3,sp@-
	jbsr _createAlphaMap__7WarpApp
	movel a3@(48),a0
	movel a0@,a1
	pea LC19
	pea 15:w
	movew a3@(96),a2
	movel a2,sp@-
	movew a3@(94),a2
	movel a2,sp@-
	movel a0,sp@-
	movel a1@(8),a0
	jbsr a0@
	addw #24,sp
	tstl d0
	jeq L2196
	pea LC20
	jra L2230
	.even
L2196:
	movel a3,sp@-
	jbsr _updateTitle__7WarpApp
	movel a3@(48),a0
	movel a0@,a1
	movel a0,sp@-
	movel a1@(40),a0
	jbsr a0@
	addqw #4,sp
	movel d0,sp@
	jbsr _obtain__10RasterizerP7Surface
	addql #4,sp
	movel d0,a3@(60)
	jne L2198
	pea LC21
	jra L2230
	.even
L2198:
	movel a3@(76),sp@-
	movel d0,sp@-
	jbsr _setVertices__10RasterizerP10DrawVertex
	addql #8,sp
	cmpb #1,d0
	jeq L2199
	pea LC22
	jra L2230
	.even
L2199:
	movel a3@(60),sp@-
	movel a3@(64),sp@-
	lea _associate__7TextureP10Rasterizer,a2
	jbsr a2@
	addql #8,sp
	tstl d0
	jeq L2200
	pea LC23
	jra L2230
	.even
L2200:
	movel a3@(60),sp@-
	movel a3@(68),sp@-
	jbsr a2@
	addql #8,sp
	tstl d0
	jeq L2201
	pea LC24
L2230:
	pea LC12
	pea LC13
	jbsr _dialogueBox__9SystemLibPCcN21e
	movel #-50659333,d0
	jra L2229
	.even
L2201:
	movel a3,sp@-
	jbsr _initMesh__7WarpApp
	movel a3@(64),a2
	addql #4,sp
	tstl a2@(8)
	jeq L2202
	tstl a2@(12)
	jeq L2202
	clrl d0
	moveb __8Native3D$texFilter,d0
	movel d0,sp@-
	clrl d0
	moveb __8Native3D$texFilter+1,d0
	movel d0,sp@-
	movel a2@(12),sp@-
	movel a2@(8),sp@-
	jbsr _W3D_SetFilter
	addw #16,sp
L2202:
	clrl a2@(28)
	moveq #1,d0
	movel d0,a2@(32)
	movel a3@(64),a2
	tstl a2@(8)
	jeq L2206
	tstl a2@(12)
	jeq L2206
	clrl sp@-
	clrl d0
	moveb __8Native3D$texEnv+2,d0
	movel d0,sp@-
	movel a2@(12),sp@-
	movel a2@(8),sp@-
	jbsr _W3D_SetTexEnv
	addw #16,sp
L2206:
	moveq #2,d1
	movel d1,a2@(36)
	movel a3@(68),a2
	tstl a2@(8)
	jeq L2209
	tstl a2@(12)
	jeq L2209
	clrl d0
	moveb __8Native3D$texFilter,d0
	movel d0,sp@-
	clrl d0
	moveb __8Native3D$texFilter+1,d0
	movel d0,sp@-
	movel a2@(12),sp@-
	movel a2@(8),sp@-
	jbsr _W3D_SetFilter
	addw #16,sp
L2209:
	clrl a2@(28)
	moveq #1,d2
	movel d2,a2@(32)
	movel a3@(68),a2
	tstl a2@(8)
	jeq L2213
	tstl a2@(12)
	jeq L2213
	clrl sp@-
	clrl d0
	moveb __8Native3D$texEnv,d0
	movel d0,sp@-
	movel a2@(12),sp@-
	movel a2@(8),sp@-
	jbsr _W3D_SetTexEnv
	addw #16,sp
L2213:
	clrl a2@(36)
	movel a3@(60),a0
	pea 1:w
	movel __8Native3D$state,sp@-
	movel a0@(4),sp@-
	jbsr _W3D_SetState
	addw #12,sp
	movel a3@(60),a0
	pea 1:w
	movel __8Native3D$state+56,sp@-
	movel a0@(4),sp@-
	jbsr _W3D_SetState
	addw #12,sp
	moveq #-1,d0
	movel d0,a5@(-4)
	movel d0,sp@-
	movel a3@(60),sp@-
	jbsr _setFlatColour__10RasterizerG6Colour
	movel a3,sp@-
	jbsr _render__7WarpApp
	movel a3@(48),d0
	addql #4,d0
	lea a3@(4),a2
	addw #12,sp
	tstl a2
	jeq L2227
	movel d0,a3
	addql #4,a3
	movel a2,sp@-
	movel a3,sp@-
	jbsr _contains__7_LLBasePv
	addql #8,sp
	tstb d0
	jne L2227
	movel a2,sp@-
	movel a3,sp@-
	jbsr _insLast__7_LLBasePv
L2227:
	clrl d0
L2229:
	moveml a5@(-16),#0xc04
	unlk a5
	rts
	.even
.globl _initMesh__7WarpApp
_initMesh__7WarpApp:
	link a5,#-44
	fmovem #0xfc,sp@-
	moveml #0x3f3a,sp@-
	movel a5@(8),a3
	movel a3@(76),a1
	clrl a1@
	movel a3@(76),a0
	movel a1@,a0@(4)
	movel a3@(76),a0
	clrl a0@(16)
	movel a3@(76),a0
	clrl a0@(20)
	movel a3@(76),a0
	fsmovew a3@(94),fp0
	fmoves fp0,a0@(32)
	movel a3@(76),a0
	clrl a0@(36)
	movel a3@(68),a0
	movew a0@,d0
	extl d0
	movel a3@(76),a0
	fsmovel d0,fp1
	fmoves fp1,a0@(48)
	movel a3@(76),a0
	clrl a0@(52)
	movel a3@(76),a0
	clrl a0@(64)
	movel a3@(76),a0
	fsmovew a3@(96),fp0
	fmoves fp0,a0@(68)
	movel a3@(76),a0
	clrl a0@(80)
	movel a3@(68),a0
	movew a0@(2),d0
	extl d0
	movel a3@(76),a0
	fsmovel d0,fp1
	fmoves fp1,a0@(84)
	movel a3@(76),a0
	fsmovew a3@(94),fp0
	fmoves fp0,a0@(96)
	movel a3@(76),a0
	fsmovew a3@(96),fp1
	fmoves fp1,a0@(100)
	movel a3@(68),a0
	movew a0@,d0
	extl d0
	movel a3@(76),a0
	fsmovel d0,fp0
	fmoves fp0,a0@(112)
	movel a3@(68),a0
	movew a0@(2),d0
	extl d0
	movel a3@(76),a0
	fsmovel d0,fp1
	fmoves fp1,a0@(116)
	movew a3@(92),d1
	extl d1
	moveq #1,d0
	lsll d1,d0
	movew d0,a3@(98)
	movel a3@(80),d3
	fsmovew a3@(94),fp0
	fmoves fp0,a5@(-8)
	movew a3@(98),a2
	movel a2,d0
	subql #1,d0
	fsmovel d0,fp0
	fsmoves a5@(-8),fp1
	fsdivx fp0,fp1
	fmoves fp1,a5@(-8)
	fsmovew a3@(96),fp1
	fsdivx fp0,fp1
	fmoves fp1,a5@(-12)
	movel a3@(64),a0
	movew a0@,d0
	extl d0
	fsmovel d0,fp1
	fsdivx fp0,fp1
	fmoves fp1,a5@(-16)
	movew a0@(2),d0
	extl d0
	fsmovel d0,fp1
	fsdivx fp0,fp1
	fmoves fp1,a5@(-20)
	movel a3@(72),a1
	movew a1@,a0
	movel a0,d0
	subql #1,d0
	fsmovel d0,fp1
	fsdivx fp0,fp1
	fmoves fp1,a5@(-24)
	movew a1@(2),a0
	movel a0,d0
	subql #1,d0
	fsmovel d0,fp1
	fsdivx fp0,fp1
	fmoves fp1,a5@(-28)
	clrl a5@(-44)
	movel a5@(-44),a4
	movel a4,d1
	movel a1@(8),a5@(-32)
	movel a3@(68),a0
	movel a0@(16),a5@(-36)
	clrl d0
	cmpl d0,a2
	jle L2243
	clrl d5
	.even
L2245:
	fmoves #0r0,fp5
	fsmovex fp5,fp7
	fsmovex fp5,fp6
	clrl d2
	movel d0,a6
	addql #1,a6
	movel a4,sp@-
	fsmoves sp@+,fp2
	fsadds a5@(-12),fp2
	fsmoves a5@(-44),fp3
	fsadds a5@(-20),fp3
	fsmoves d1,fp4
	fsadds a5@(-28),fp4
	cmpl d2,a2
	jle L2244
	fdmoves d1,fp0
	fmoveml fpcr,d0
	moveq #16,d1
	orl d0,d1
	andw #-33,d1
	fmoveml d1,fpcr
	fmovel fp0,a5@(-40)
	fmoveml d0,fpcr
	clrl d4
	movel d3,a1
	.even
L2249:
	fmoves fp7,a1@
	movel a4,a1@(4)
	clrl a1@(8)
	clrl a1@(12)
	fmoves fp5,a1@(16)
	movel a5@(-44),a1@(20)
	movel a3@(72),a0
	movew a0@,d0
	extl d0
	mulsl a5@(-40),d0
	fdmovex fp6,fp0
	fmoveml fpcr,d7
	moveq #16,d1
	orl d7,d1
	andw #-33,d1
	fmoveml d1,fpcr
	fmovel fp0,d6
	fmoveml d7,fpcr
	movel d6,a0
	addl a0,d0
	movel a5@(-32),a0
	movel a0@(d0:l:4),a5@(-4)
	movel a5@(-36),a0
	moveb a0@(d0:l:4),d0
	andl #0xFF,d0
	lea a5@(-4),a0
	jeq L2251
	fdmovel d0,fp0
	tstl d0
	jge L2252
	fdaddd #0r4294967296.000005,fp0
L2252:
	fsmovex fp0,fp0
	fmoved #0r255.0000000000005,fp1
	fddivx fp0,fp1
	fsmovex fp1,fp1
	movel a0,a2
	moveb a5@(-3),d4
	fsmovex fp1,fp0
	fsmull d4,fp0
	fcmpd #0r2147483648.000005,fp0
	fjge L2253
	fmoveml fpcr,d1
	moveq #16,d6
	orl d1,d6
	andw #-33,d6
	fmoveml d6,fpcr
	fmovel fp0,d0
	fmoveml d1,fpcr
	jra L2254
	.even
L2253:
	fdsubd #0r2147483648.000005,fp0
	fmoveml fpcr,d7
	moveq #16,d1
	orl d7,d1
	andw #-33,d1
	fmoveml d1,fpcr
	fmovel fp0,d0
	fmoveml d7,fpcr
	bchg #31,d0
L2254:
	tstl d0
	jlt L2255
	cmpl #255,d0
	jle L2257
	moveq #0,d0
	notb d0
	jra L2257
	.even
L2255:
	clrl d0
L2257:
	moveb d0,a2@(1)
	moveb a2@(2),d5
	fsmovex fp1,fp0
	fsmull d5,fp0
	fcmpd #0r2147483648.000005,fp0
	fjge L2260
	fmoveml fpcr,d6
	moveq #16,d7
	orl d6,d7
	andw #-33,d7
	fmoveml d7,fpcr
	fmovel fp0,d0
	fmoveml d6,fpcr
	jra L2261
	.even
L2260:
	fdsubd #0r2147483648.000005,fp0
	fmoveml fpcr,d1
	moveq #16,d6
	orl d1,d6
	andw #-33,d6
	fmoveml d6,fpcr
	fmovel fp0,d0
	fmoveml d1,fpcr
	bchg #31,d0
L2261:
	tstl d0
	jlt L2262
	cmpl #255,d0
	jle L2264
	moveq #0,d0
	notb d0
	jra L2264
	.even
L2262:
	clrl d0
L2264:
	moveb d0,a2@(2)
	clrl d0
	moveb a2@(3),d0
	fsmull d0,fp1
	fdmovex fp1,fp0
	fcmpd #0r2147483648.000005,fp0
	fjge L2267
	fmoveml fpcr,d7
	moveq #16,d1
	orl d7,d1
	andw #-33,d1
	fmoveml d1,fpcr
	fmovel fp0,d0
	fmoveml d7,fpcr
	jra L2268
	.even
L2267:
	fdsubd #0r2147483648.000005,fp0
	fmoveml fpcr,d6
	moveq #16,d7
	orl d6,d7
	andw #-33,d7
	fmoveml d7,fpcr
	fmovel fp0,d0
	fmoveml d6,fpcr
	bchg #31,d0
L2268:
	tstl d0
	jlt L2269
	cmpl #255,d0
	jle L2271
	moveq #0,d0
	notb d0
	jra L2271
	.even
L2269:
	clrl d0
L2271:
	moveb d0,a2@(3)
L2251:
	movel a0@,a1@(24)
	addql #1,d2
	fsadds a5@(-8),fp7
	fsadds a5@(-16),fp5
	fsadds a5@(-24),fp6
	addw #32,a1
	moveq #32,d0
	addl d0,d3
	movew a3@(98),a0
	cmpl d2,a0
	jgt L2249
L2244:
	movel a6,d0
	fmoves fp2,sp@-
	movel sp@+,a4
	fmoves fp3,a5@(-44)
	fmoves fp4,d1
	movew a3@(98),a2
	cmpl d0,a2
	jgt L2245
L2243:
	movel a3@(84),a2
	lea 0:w,a1
	jra L2289
	.even
L2281:
	clrl d1
	movel a0,d0
	lea a1@(1),a0
	cmpl d1,d0
	jle L2280
	.even
L2285:
	mulsl d1,d0
	lea a1@(4,d0:l),a4
	movel a4,a2@+
	addql #1,d1
	movew a3@(98),d0
	extl d0
	cmpl d1,d0
	jgt L2285
L2280:
	movel a0,a1
L2289:
	movew a3@(98),a0
	cmpl a1,a0
	jgt L2281
	moveml sp@+,#0x5cfc
	fmovem sp@+,#0x3f
	unlk a5
	rts
	.even
.globl _render__7WarpApp
_render__7WarpApp:
	link a5,#-4
	moveml #0x2038,sp@-
	movel a5@(8),a3
	movel a3@(60),a2
	btst #1,a2@(167)
	jne L2368
	movel a2@(4),sp@-
	jbsr _W3D_LockHardware
	addql #4,sp
	tstl d0
	jne L2367
	moveq #2,d0
	orl d0,a2@(164)
L2368:
	movel a3@(60),a0
	movel #16777215,a5@(-4)
	movel #16777215,sp@-
	movel a0@(4),sp@-
	jbsr _W3D_ClearDrawRegion
	addql #8,sp
	movel a3@(60),a0
	pea 2:w
	movel __8Native3D$state+48,sp@-
	movel a0@(4),sp@-
	jbsr _W3D_SetState
	addw #12,sp
	btst #6,a3@(100)
	jeq L2302
	movel a3@(60),a1
	movel a3@(64),a0
	tstl a0
	jne L2303
	clrl a1@(28)
	clrl sp@-
	jra L2369
	.even
L2303:
	movel a0@(8),d0
	cmpl a1@(4),d0
	jne L2304
	tstl a0@(12)
	jeq L2304
	movel a0,a1@(28)
	movel a0@(12),sp@-
L2369:
	clrl sp@-
	movel a1@(4),sp@-
	jbsr _W3D_BindTexture
	addw #12,sp
L2304:
	movel a3@(60),a0
	pea 1:w
	jra L2370
	.even
L2302:
	movel a3@(60),a0
	pea 2:w
L2370:
	movel __8Native3D$state,sp@-
	movel a0@(4),sp@-
	jbsr _W3D_SetState
	addw #12,sp
	btst #4,a3@(100)
	jeq L2314
	movel a3@(64),a2
	tstl a2@(8)
	jeq L2315
	tstl a2@(12)
	jeq L2315
	clrl sp@-
	clrl d0
	moveb __8Native3D$texEnv+2,d0
	movel d0,sp@-
	movel a2@(12),sp@-
	movel a2@(8),sp@-
	jbsr _W3D_SetTexEnv
	addw #16,sp
L2315:
	moveq #2,d0
	movel d0,a2@(36)
	movel a3@(60),a0
	pea 1:w
	jra L2371
	.even
L2314:
	movel a3@(64),a2
	tstl a2@(8)
	jeq L2322
	tstl a2@(12)
	jeq L2322
	clrl sp@-
	clrl d0
	moveb __8Native3D$texEnv,d0
	movel d0,sp@-
	movel a2@(12),sp@-
	movel a2@(8),sp@-
	jbsr _W3D_SetTexEnv
	addw #16,sp
L2322:
	clrl a2@(36)
	movel a3@(60),a0
	pea 2:w
L2371:
	movel __8Native3D$state+16,sp@-
	movel a0@(4),sp@-
	jbsr _W3D_SetState
	addw #12,sp
	movew a3@(98),a0
	movel a0,sp@-
	movew a3@(98),a0
	movel a0,sp@-
	pea 4:w
	movel a3@(60),sp@-
	jbsr _drawTriMesh2__10RasterizerUlUlUl
	addw #16,sp
	btst #5,a3@(100)
	jeq L2328
	movel a3@(60),a1
	movel a3@(68),a0
	tstl a0
	jne L2329
	clrl a1@(28)
	clrl sp@-
	jra L2372
	.even
L2329:
	movel a0@(8),d0
	cmpl a1@(4),d0
	jne L2330
	tstl a0@(12)
	jeq L2330
	movel a0,a1@(28)
	movel a0@(12),sp@-
L2372:
	clrl sp@-
	movel a1@(4),sp@-
	jbsr _W3D_BindTexture
	addw #12,sp
L2330:
	movel a3@(60),a0
	pea 1:w
	movel __8Native3D$state,sp@-
	movel a0@(4),sp@-
	jbsr _W3D_SetState
	addw #12,sp
	movel a3@(60),a0
	pea 1:w
	movel __8Native3D$state+48,sp@-
	movel a0@(4),sp@-
	jbsr _W3D_SetState
	addw #12,sp
	movel a3@(60),a0
	pea 2:w
	movel __8Native3D$state+16,sp@-
	movel a0@(4),sp@-
	jbsr _W3D_SetState
	addw #12,sp
	movel a3@(60),a0
	pea 4:w
	clrl sp@-
	pea 2:w
	movel a0@(4),sp@-
	jbsr _W3D_DrawArray
	addw #16,sp
L2328:
	btst #3,a3@(100)
	jeq L2343
	movel a3@(60),a0
	pea 2:w
	movel __8Native3D$state+48,sp@-
	movel a0@(4),sp@-
	jbsr _W3D_SetState
	addw #12,sp
	movel a3@(60),a0
	pea 2:w
	movel __8Native3D$state,sp@-
	movel a0@(4),sp@-
	jbsr _W3D_SetState
	addw #12,sp
	movel a3@(60),a0
	pea 2:w
	movel __8Native3D$state+16,sp@-
	movel a0@(4),sp@-
	jbsr _W3D_SetState
	addw #12,sp
	moveq #4,d2
	movel a3@(84),a4
	lea 0:w,a2
	movew a3@(98),a1
	cmpl a2,a1
	jle L2354
	.even
L2356:
	movel a3@(60),a0
	movel a1,sp@-
	movel d2,sp@-
	pea 6:w
	movel a0@(4),sp@-
	jbsr _W3D_DrawArray
	addw #16,sp
	addql #1,a2
	movew a3@(98),a0
	addl a0,d2
	movel a0,a1
	cmpl a2,a1
	jgt L2356
L2354:
	lea 0:w,a2
	movew a3@(98),a1
	cmpl a2,a1
	jle L2343
	.even
L2362:
	movel a3@(60),a0
	movel a4,sp@-
	pea a1@(1)
	pea 2:w
	pea 6:w
	movel a0@(4),sp@-
	jbsr _W3D_DrawElements
	addw #20,sp
	addql #1,a2
	movew a3@(98),a0
	lea a4@(a0:l:4),a4
	movel a0,a1
	cmpl a2,a1
	jgt L2362
L2343:
	movel a3@(60),a0
	movel a0@(4),sp@-
	jbsr _W3D_FlushFrame
	addql #4,sp
	movel a3@(60),a0
	moveq #-3,d0
	andl d0,a0@(164)
	movel a0@(4),sp@-
	jbsr _W3D_UnLockHardware
	addql #4,sp
	movel a3@(48),a0
	movel a0@,a1
	movel a0,sp@-
	movel a1@(28),a0
	jbsr a0@
L2367:
	moveml a5@(-20),#0x1c04
	unlk a5
	rts
	.even
.globl _runApplication__7WarpApp
_runApplication__7WarpApp:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel a5@(8),a2
	btst #2,a2@(100)
	jne L2375
	.even
L2376:
	andb #127,a2@(100)
	.even
L2377:
	movel a2@(48),a0
	movel a0@(28),a1
	pea a0@(4)
	movel a1@(20),a0
	jbsr a0@
	addql #4,sp
	tstb d0
	jne L2377
	tstb a2@(100)
	jge L2381
	movel a2,sp@-
	jbsr _render__7WarpApp
	addql #4,sp
L2381:
	movel a2@(48),a0
	movel a0@(28),a1
	pea a0@(4)
	movel a1@(16),a0
	jbsr a0@
	addql #4,sp
	btst #2,a2@(100)
	jeq L2376
L2375:
	clrl d0
	movel a5@(-4),a2
	unlk a5
	rts
	.even
___thunk_4_keyPressNonPrintable__7WarpAppP15InputDispatcherQ23Key7CtrlKey:
	pea a5@
	movel sp,a5
	movel a5@(16),sp@-
	movel a5@(12),sp@-
	movel a5@(8),d0
	subql #4,d0
	movel d0,sp@-
	jbsr _keyPressNonPrintable__7WarpAppP15InputDispatcherQ23Key7CtrlKey
	unlk a5
	rts
	.even
___thunk_4__$_7WarpApp:
	pea a5@
	movel sp,a5
	movel a5@(12),sp@-
	movel a5@(8),d0
	subql #4,d0
	movel d0,sp@-
	jbsr __$_7WarpApp
	unlk a5
	rts
.globl ___vt_7WarpApp$10InputFocus
	.even
___vt_7WarpApp$10InputFocus:
	.long -4
	.long 0
	.long ___thunk_4_keyPressNonPrintable__7WarpAppP15InputDispatcherQ23Key7CtrlKey
	.long _keyReleaseNonPrintable__10InputFocusP15InputDispatcherQ23Key7CtrlKey
	.long _keyPressPrintable__10InputFocusP15InputDispatcherl
	.long _keyReleasePrintable__10InputFocusP15InputDispatcherl
	.long _mousePress__10InputFocusP15InputDispatcherUl
	.long _mouseRelease__10InputFocusP15InputDispatcherUl
	.long _mouseMove__10InputFocusP15InputDispatcherssss
	.long _mouseDrag__10InputFocusP15InputDispatcherssssUl
	.long _mouseScroll__10InputFocusP15InputDispatcherss
	.long _exitEvent__10InputFocusP15InputDispatcher
	.long ___thunk_4__$_7WarpApp
	.skip 4
.globl ___vt_7WarpApp
	.even
___vt_7WarpApp:
	.long 0
	.long 0
	.long _initApplication__7WarpApp
	.long _doneApplication__7AppBase
	.long _runApplication__7WarpApp
	.long __$_7WarpApp
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
	jeq L2388
	movel a2,sp@-
	jbsr ___builtin_delete
L2388:
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
	jeq L21
	movel a0,sp@-
	jbsr ___builtin_delete
L21:
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
	jeq L513
	movel a2,sp@-
	jbsr ___builtin_delete
L513:
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
	jeq L546
	movel a0,sp@-
	jbsr ___builtin_delete
L546:
	unlk a5
	rts
	.even
__$_7Display:
	pea a5@
	movel sp,a5
	movel a5@(8),a0
	movel #___vt_7Display,a0@
	btst #0,a5@(15)
	jeq L647
	movel a0,sp@-
	jbsr ___builtin_delete
L647:
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
	jeq L944
	movel a2,sp@-
	jbsr ___builtin_delete
L944:
	movel a5@(-8),d2
	movel a5@(-4),a2
	unlk a5
	rts
