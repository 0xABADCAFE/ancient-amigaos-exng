#NO_APP
.text
LC0:
	.ascii "bad_alloc\0"
.globl _version
.data
_version:
	.ascii "$VER: Warp 1.1 K. Churchill (25.1.2004)\12\0"
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
	pea 90:w
	jbsr ___nw__FUlRC9nothrow_t
	movel d0,a5@(-52)
	movel a5@(-56),a0
	addql #4,a0
	movel a0@,a5@(-24)
	clrl a5@(-20)
	movel a5,a5@(-16)
	movel #L1985,a5@(-12)
	movel sp,a5@(-8)
	movel a0,a5@(-60)
	jra L1984
	.even
L1985:
	movel a5@(-56),a0
	addql #4,a0
	movel a0,a5@(-60)
	jra L1982
	.even
L1984:
	lea a5@(-24),a1
	movel a1,a0@
	movel a5@(-52),sp@-
	jbsr ___7WarpApp
	movel a5@(-60),a1
	movel a1@,a0
	movel a0@,a1@
	jra L1996
	.even
L1982:
	movel a5@(-60),a0
	movel a0@,a5@(-48)
	clrl a5@(-44)
	movel a5,a5@(-40)
	movel #L1991,a5@(-36)
	movel sp,a5@(-32)
	jra L1990
	.even
L1991:
	jra L1997
	.even
L1990:
	lea a5@(-48),a0
	movel a5@(-60),a1
	movel a0,a1@
	moveq #1,d0
	jeq L1993
	pea _nothrow
	movel a5@(-52),sp@-
	jbsr ___dl__FPvRC9nothrow_t
	addql #8,sp
L1993:
	movel a5@(-56),a1
	addql #4,a1
	movel a1@,a0
	movel a0@,a1@
	jbsr ___sjthrow
	.even
L1997:
L1988:
	jbsr ___terminate
	.even
L1996:
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
	jeq L2000
	movel a1@,a0
	pea 3:w
	movel a1,sp@-
	movel a0@(20),a0
	jbsr a0@
L2000:
	unlk a5
	rts
LC1:
	.ascii "scale\0"
LC2:
	.ascii "mesh\0"
LC3:
	.ascii "image\0"
	.even
.globl ___7WarpApp
___7WarpApp:
	link a5,#-464
	fmovem #0xfc,sp@-
	moveml #0x3f3a,sp@-
	jbsr ___get_eh_context
	movel d0,a5@(-436)
	movel d0,a5@(-450)
	movel a5@(8),a0
	movel #___vt_7AppBase,a0@
	movel a5@(-436),a0
	addql #4,a0
	movel a0@,a5@(-24)
	clrl a5@(-20)
	movel a5,a5@(-16)
	movel #L2009,a5@(-12)
	movel sp,a5@(-8)
	jra L2008
	.even
L2009:
	jra L2135
	.even
L2008:
	lea a5@(-24),a1
	movel a1,a0@
	pea 16498:w
	movel a5@(8),d0
	addql #4,d0
	movel d0,sp@-
	movel d0,a5@(-462)
	movel a5@(-450),a2
	addql #4,a2
	movel a2,a5@(-454)
	jbsr ___10InputFocusUl
	movel a2,a0
	movel a2@,a5@(-48)
	clrl a5@(-44)
	movel a5,a5@(-40)
	movel #L2013,a5@(-36)
	movel sp,a5@(-32)
	jra L2012
	.even
L2013:
	jra L2136
	.even
L2012:
	lea a5@(-48),a1
	movel a1,a0@
	movel a5@(8),a2
	movel #___vt_7WarpApp$10InputFocus,a2@(40)
	movel #___vt_7WarpApp,a2@
	clrl a2@(48)
	clrl a2@(56)
	clrl a2@(60)
	clrl a2@(64)
	movel #0x3e800000,a2@(76)
	clrb a2@(87)
	clrb a2@(88)
	clrb a2@(89)
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
	fjlt L2014
	fcmpd #0r8.000000000000005,fp0
	fjle L2016
	fmoved #0r8.000000000000005,fp0
	jra L2016
	.even
L2014:
	fmoved #0r1.000000000000005,fp0
L2016:
	fsmovex fp0,fp0
	movel a5@(8),a0
	fmoves fp0,a0@(72)
	subql #2,sp
	moveb #0,sp@(1)
	subql #2,sp
	pea LC2
	jbsr _getInteger__7AppBasePCcb
	movel a5@(8),a1
	movew d0,a1@(84)
	subql #2,sp
	moveb #0,sp@(1)
	subql #2,sp
	pea LC3
	jbsr _getString__7AppBasePCcb
	movel a5@(8),a2
	movel d0,a2@(52)
	addw #16,sp
	tstw a2@(84)
	jne L2019
	movew #16,a2@(84)
	jra L2020
	.even
L2019:
	movel a5@(8),a1
	movew a1@(84),a0
	moveq #4,d0
	cmpl a0,d0
	jgt L2021
	movel a0,d0
	cmpl #128,d0
	jle L2023
	moveq #127,d0
	notb d0
	jra L2023
	.even
L2021:
	moveq #4,d0
L2023:
	movel a5@(8),a0
	movew d0,a0@(84)
L2020:
	pea _nothrow
	pea 322:w
	jbsr ___nw__FUlRC9nothrow_t
	movel d0,a5@(-440)
	moveb #1,a5@(-441)
	movel a5@(-454),a1
	movel a1@,a5@(-72)
	clrl a5@(-68)
	movel a5,a5@(-64)
	movel #L2029,a5@(-60)
	movel sp,a5@(-56)
	jra L2028
	.even
L2029:
	jra L2137
	.even
L2028:
	moveq #-72,d0
	addl a5,d0
	movel a5@(-454),a2
	movel d0,a2@
	addql #8,sp
	movel a5@(-450),d1
	movel a5@(-440),a0
	movel #___vt_7Display,a0@
	movel a5@(-450),a0
	addql #4,a0
	movel a0@,a5@(-96)
	clrl a5@(-92)
	movel d0,a5@(-88)
	movel #L2034,a5@(-84)
	movel sp,a5@(-80)
L2034:
	lea a5@(-96),a1
	movel a1,a0@
	movel a5@(-440),a2
	addql #4,a2
	movel a2,a5@(-446)
	movel a5@(-450),d0
	movel #16498,a2@
	movel #___vt_15InputDispatcher,a2@(24)
	pea a2@(4)
	jbsr ___7_LLBase
	movel a5@(-436),a0
	addql #4,a0
	movel a0@,a5@(-120)
	clrl a5@(-116)
	lea a5@(-96),a1
	movel a1,a5@(-112)
	movel #L2039,a5@(-108)
	movel sp,a5@(-104)
	movel a0,a5@(-458)
L2039:
	lea a5@(-120),a2
	movel a2,a0@
	addql #4,sp
	movel a5@(-436),a1
	addql #4,a1
	movel a1@,a0
	movel a0@,a1@
	movel a5@(-458),a0
	movel a0@,a5@(-168)
	clrl a5@(-164)
	lea a5@(-96),a1
	movel a1,a5@(-160)
	movel #L2048,a5@(-156)
	movel sp,a5@(-152)
L2048:
	lea a5@(-168),a0
	movel a5@(-458),a2
	movel a0,a2@
	movel a5@(-446),a1
	clrl a1@(20)
	movel a2@,a0
	movel a0@,a2@
	movel a5@(-436),a0
	addql #4,a0
	movel a0@,a5@(-216)
	clrl a5@(-212)
	lea a5@(-72),a2
	movel a2,a5@(-208)
	movel #L2061,a5@(-204)
	movel sp,a5@(-200)
	movel a0,a1
L2061:
	lea a5@(-216),a2
	movel a2,a0@
	movel a5@(-440),a0
	movel #___vt_18InteractiveDisplay$15InputDispatcher,a0@(28)
	movel #___vt_18InteractiveDisplay,a0@
	movel a1@,a0
	movel a0@,a1@
	movel a1@,a0
	movel a0@,a1@
	jra L2063
	.even
L2032:
	movel a5@(-436),a0
	addql #4,a0
	movel a0@,a5@(-264)
	clrl a5@(-260)
	lea a5@(-72),a1
	movel a1,a5@(-256)
	movel #L2075,a5@(-252)
	movel sp,a5@(-248)
L2075:
	lea a5@(-264),a2
	movel a2,a0@
	movel a5@(-440),a0
	movel #___vt_7Display,a0@
	movel a5@(-436),a1
	addql #4,a1
	movel a1@,a0
	movel a0@,a1@
	jbsr ___sjthrow
	.even
L2063:
	movel a5@(-458),a1
	movel a1@,a5@(-288)
	clrl a5@(-284)
	lea a5@(-72),a2
	movel a2,a5@(-280)
	movel #L2083,a5@(-276)
	movel sp,a5@(-272)
L2083:
	lea a5@(-288),a1
	movel a5@(-458),a0
	movel a1,a0@
	movel a5@(-440),a2
	pea a2@(32)
	jbsr ___7_NatWin
	movel a5@(-458),a0
	movel a0@,a5@(-312)
	clrl a5@(-308)
	lea a5@(-72),a1
	movel a1,a5@(-304)
	movel #L2086,a5@(-300)
	movel sp,a5@(-296)
L2086:
	lea a5@(-312),a0
	movel a5@(-458),a2
	movel a0,a2@
	movel a5@(-440),a1
	movel #___vt_17InteractiveWindow$15InputDispatcher,a1@(28)
	movel #___vt_17InteractiveWindow,a1@
	addql #4,sp
	movel a2@,a0
	movel a0@,a2@
	movel a2@,a0
	movel a0@,a2@
	jra L2088
	.even
L2081:
	movel a5@(-458),a2
	movel a2@,a5@(-360)
	clrl a5@(-356)
	lea a5@(-72),a0
	movel a0,a5@(-352)
	movel #L2095,a5@(-348)
	movel sp,a5@(-344)
L2095:
	lea a5@(-360),a2
	movel a5@(-458),a1
	movel a2,a1@
	movel a5@(-440),a0
	movel #___vt_18InteractiveDisplay$15InputDispatcher,a0@(28)
	movel #___vt_18InteractiveDisplay,a0@+
	movel #___vt_15InputDispatcher,a0@(24)
	pea 2:w
	pea a0@(4)
	jbsr __$_7_LLBase
	addql #8,sp
	movel a5@(-440),a1
	movel #___vt_7Display,a1@
	movel a5@(-458),a2
	movel a2@,a0
	movel a0@,a2@
	jbsr ___sjthrow
	.even
L2093:
	jbsr ___terminate
	.even
L2088:
	clrb a5@(-441)
	movel a5@(8),a0
	movel a5@(-440),a0@(48)
	movel a5@(-454),a1
	movel a1@,a0
	movel a0@,a1@
	pea _nothrow
	movel a5@(8),a2
	movew a2@(84),d0
	muls d0,d0
	lsll #5,d0
	movel d0,sp@-
	jbsr ___vn__FUlRC9nothrow_t
	movel d0,a2@(64)
	pea _nothrow
	movew a2@(84),d0
	muls d0,d0
	lsll #2,d0
	movel d0,sp@-
	jbsr ___vn__FUlRC9nothrow_t
	movel d0,a2@(68)
	movel a5@(-454),a1
	movel a1@,a0
	movel a0@,a1@
	movel a1@,a0
	movel a0@,a1@
	movel a2,d0
	jra L2134
	.even
L2137:
L2026:
	movel a5@(-454),a2
	movel a2@,a5@(-384)
	clrl a5@(-380)
	lea a5@(-376),a0
	movel a5,a0@
	movel #L2114,a0@(4)
	movel sp,a0@(8)
	jra L2113
	.even
L2114:
	jra L2138
	.even
L2113:
	lea a5@(-384),a1
	movel a5@(-454),a0
	movel a1,a0@
	tstb a5@(-441)
	jeq L2116
	pea _nothrow
	movel a5@(-440),sp@-
	jbsr ___dl__FPvRC9nothrow_t
	addql #8,sp
L2116:
	movel a5@(-454),a2
	movel a2@,a0
	movel a0@,a2@
	jbsr ___sjthrow
	.even
L2136:
L2010:
	movel a5@(-454),a0
	movel a0@,a5@(-408)
	clrl a5@(-404)
	lea a5@(-400),a0
	movel a5,a0@
	movel #L2120,a0@(4)
	movel sp,a0@(8)
	jra L2119
	.even
L2120:
	jra L2139
	.even
L2119:
	lea a5@(-408),a2
	movel a5@(-454),a1
	movel a2,a1@
	movel a5@(-462),a0
	movel #___vt_10InputFocus,a0@(36)
	movel a1@,a0
	movel a0@,a1@
	jbsr ___sjthrow
	.even
L2135:
L2006:
	movel a5@(-454),a1
	movel a1@,a5@(-432)
	clrl a5@(-428)
	lea a5@(-424),a0
	movel a5,a0@
	movel #L2128,a0@(4)
	movel sp,a0@(8)
	jra L2127
	.even
L2128:
	jra L2140
	.even
L2127:
	lea a5@(-432),a0
	movel a5@(-454),a2
	movel a0,a2@
	movel a5@(8),a1
	movel #___vt_7AppBase,a1@
	movel a2@,a0
	movel a0@,a2@
	jbsr ___sjthrow
	.even
L2138:
L2111:
	jbsr ___terminate
	.even
L2139:
L2117:
	jbsr ___terminate
	.even
L2140:
L2125:
	jbsr ___terminate
	.even
L2134:
	moveml a5@(-576),#0x5cfc
	fmovem a5@(-536),#0x3f
	unlk a5
	rts
	.even
.globl __$_7WarpApp
__$_7WarpApp:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel a5@(8),a2
	movel #___vt_7WarpApp$10InputFocus,a2@(40)
	movel #___vt_7WarpApp,a2@
	movel a2@(60),d0
	jeq L2143
	pea 3:w
	movel d0,sp@-
	jbsr __$_7Texture
	addql #8,sp
L2143:
	movel a2@(56),d0
	jeq L2145
	pea 3:w
	movel d0,sp@-
	jbsr __$_10Rasterizer
	addql #8,sp
L2145:
	movel a2@(64),d0
	jeq L2147
	movel d0,sp@-
	jbsr ___builtin_vec_delete
	addql #4,sp
L2147:
	movel a2@(68),d0
	jeq L2149
	movel d0,sp@-
	jbsr ___builtin_vec_delete
	addql #4,sp
L2149:
	movel a2@(48),a1
	tstl a1
	jeq L2151
	movel a1@,a0
	pea 3:w
	movel a1,sp@-
	movel a0@(48),a0
	jbsr a0@
	addql #8,sp
L2151:
	movel a2@(44),d0
	jeq L2154
	movel d0,sp@-
	jbsr ___builtin_vec_delete
	addql #4,sp
L2154:
	movel #___vt_10InputFocus,a2@(40)
	movel #___vt_7AppBase,a2@
	movel a5@(12),d0
	btst #0,d0
	jeq L2162
	movel a2,sp@-
	jbsr ___builtin_delete
L2162:
	movel a5@(-4),a2
	unlk a5
	rts
LC4:
	.ascii "Warp %hd x %hd [D %3.2f] %s\0"
LC5:
	.ascii "Warp %hd x %hd [Z %3.2f] %s\0"
	.even
.globl _updateTitle__7WarpApp
_updateTitle__7WarpApp:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel a5@(8),a2
	tstb a2@(87)
	jeq L2164
	movel a2@(52),sp@-
	fsmoves a2@(76),fp0
	fmoved fp0,sp@-
	movew a2@(84),a0
	movel a0,sp@-
	movew a2@(84),a0
	movel a0,sp@-
	pea LC4
	jra L2166
	.even
L2164:
	movel a2@(52),sp@-
	fsmoves a2@(76),fp0
	fmoved fp0,sp@-
	movew a2@(84),a0
	movel a0,sp@-
	movew a2@(84),a0
	movel a0,sp@-
	pea LC5
L2166:
	movel a2@(44),sp@-
	jbsr _sprintf
	addw #28,sp
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
	clrb d2
	movel a5@(16),d0
	subql #5,d0
	moveq #40,d1
	cmpl d0,d1
	jcs L2168
LI2190:
	movew pc@(L2190-LI2190-2:b,d0:l:2),d0
	jmp pc@(2,d0:w)
	.even
L2190:
	.word L2169-L2190
	.word L2168-L2190
	.word L2185-L2190
	.word L2186-L2190
	.word L2184-L2190
	.word L2183-L2190
	.word L2170-L2190
	.word L2171-L2190
	.word L2172-L2190
	.word L2173-L2190
	.word L2174-L2190
	.word L2175-L2190
	.word L2178-L2190
	.word L2168-L2190
	.word L2187-L2190
	.word L2188-L2190
	.word L2168-L2190
	.word L2168-L2190
	.word L2168-L2190
	.word L2168-L2190
	.word L2168-L2190
	.word L2168-L2190
	.word L2168-L2190
	.word L2168-L2190
	.word L2168-L2190
	.word L2168-L2190
	.word L2168-L2190
	.word L2168-L2190
	.word L2168-L2190
	.word L2168-L2190
	.word L2168-L2190
	.word L2168-L2190
	.word L2168-L2190
	.word L2168-L2190
	.word L2168-L2190
	.word L2168-L2190
	.word L2168-L2190
	.word L2168-L2190
	.word L2168-L2190
	.word L2182-L2190
	.word L2181-L2190
	.even
L2169:
	moveb #1,a2@(88)
	jra L2168
	.even
L2170:
	movel a2,sp@-
	jbsr _restoreMesh__7WarpApp
	moveq #1,d2
	moveb #1,a2@(86)
	addql #4,sp
	jra L2168
	.even
L2171:
	movel #0x3e800000,a2@(76)
	jra L2193
	.even
L2172:
	fsmoves a2@(76),fp0
	fsmuls #0r1.04999995,fp0
	fmoves fp0,a2@(76)
	jra L2193
	.even
L2173:
	fsmoves a2@(76),fp0
	fsmuls #0r0.952381015,fp0
	fmoves fp0,a2@(76)
	jra L2193
	.even
L2174:
	movel #0x3ccccccd,sp@-
	movel a2,sp@-
	jbsr _unwarpMesh__7WarpAppf
	jra L2194
	.even
L2175:
	tstb a2@(87)
	jeq L2176
	clrb a2@(87)
	fsmoves a2@(76),fp0
	fsmuls #0r0.125,fp0
	fmoves fp0,a2@(76)
	jra L2193
	.even
L2176:
	moveb #1,a2@(87)
	fsmoves a2@(76),fp0
	fsmuls #0r8,fp0
	fmoves fp0,a2@(76)
	jra L2193
	.even
L2178:
	tstb a2@(89)
	jeq L2179
	clrb a2@(89)
	jra L2180
	.even
L2179:
	moveb #1,a2@(89)
L2180:
	moveb #1,a2@(86)
	jra L2168
	.even
L2181:
	movel #0x3f833333,sp@-
	movel a2,sp@-
	jbsr _zoomMesh__7WarpAppf
	jra L2194
	.even
L2182:
	movel #0x3f79c190,sp@-
	movel a2,sp@-
	jbsr _zoomMesh__7WarpAppf
	jra L2194
	.even
L2183:
	clrl sp@-
	pea -2:w
	jra L2195
	.even
L2184:
	clrl sp@-
	pea 2:w
	jra L2195
	.even
L2185:
	pea -2:w
	jra L2196
	.even
L2186:
	pea 2:w
L2196:
	clrl sp@-
L2195:
	movel a2,sp@-
	jbsr _scrollMesh__7WarpAppss
	moveb #1,a2@(86)
	addw #12,sp
	jra L2168
	.even
L2187:
	movel #0xbf800000,sp@-
	jra L2197
	.even
L2188:
	movel #0x3f800000,sp@-
L2197:
	movel a2,sp@-
	jbsr _rotateMesh__7WarpAppf
L2194:
	moveb #1,a2@(86)
	addql #8,sp
L2168:
	tstb d2
	jeq L2192
L2193:
	movel a2,sp@-
	jbsr _updateTitle__7WarpApp
L2192:
	movel a5@(-8),d2
	movel a5@(-4),a2
	unlk a5
	rts
	.even
.globl _mousePress__7WarpAppP15InputDispatcherUl
_mousePress__7WarpAppP15InputDispatcherUl:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel a5@(8),a0
	movel a0@(40),a1
	movel a5@(16),sp@-
	clrl sp@-
	clrl sp@-
	addql #4,a0
	movew a0@(26),a2
	movel a2,sp@-
	movew a0@(24),a2
	movel a2,sp@-
	movel a5@(12),sp@-
	movel a0,sp@-
	movel a1@(36),a0
	jbsr a0@
	movel a5@(-4),a2
	unlk a5
	rts
	.even
.globl _mouseDrag__7WarpAppP15InputDispatcherssssUl
_mouseDrag__7WarpAppP15InputDispatcherssssUl:
	pea a5@
	movel sp,a5
	moveml #0x3820,sp@-
	movel a5@(8),a2
	movel a5@(32),d4
	movew a5@(18),d3
	movew a5@(22),d2
	movew a5@(26),d1
	movew a5@(30),d0
	tstb a2@(87)
	jeq L2203
	fsmovew d0,fp0
	fmoves fp0,sp@-
	fsmovew d1,fp0
	fmoves fp0,sp@-
	fsmovew d2,fp0
	fmoves fp0,sp@-
	fsmovew d3,fp0
	fmoves fp0,sp@-
	movel a2,sp@-
	jbsr _dragMesh__7WarpAppffff
	jra L2204
	.even
L2203:
	btst #0,d4
	jeq L2205
	subql #2,sp
	moveb #0,sp@(1)
	subql #2,sp
	fsmovew d2,fp0
	fmoves fp0,sp@-
	fsmovew d3,fp0
	fmoves fp0,sp@-
	movel a2,sp@-
	jbsr _warpMesh__7WarpAppffb
	addw #16,sp
L2205:
	btst #2,d4
	jeq L2204
	subql #2,sp
	moveb #1,sp@(1)
	subql #2,sp
	fsmovew d2,fp0
	fmoves fp0,sp@-
	fsmovew d3,fp0
	fmoves fp0,sp@-
	movel a2,sp@-
	jbsr _warpMesh__7WarpAppffb
L2204:
	moveb #1,a2@(86)
	moveml a5@(-16),#0x41c
	unlk a5
	rts
LC6:
	.ascii "Failed to create string buffer\0"
LC7:
	.ascii "Exit\0"
LC8:
	.ascii "Error\0"
LC9:
	.ascii "Failed to create mesh\0"
LC10:
	.ascii "Failed to create application window\0"
LC11:
	.ascii "Failed to load image\12'%s'\0"
LC12:
	.ascii "Warp\0"
LC13:
	.ascii "Failed to open application window\0"
LC14:
	.ascii "Failed to obtain Rasterizer\0"
LC15:
	.ascii "Failed to set vertex array\0"
LC16:
	.ascii "Failed to associate texture\0"
	.even
.globl _initApplication__7WarpApp
_initApplication__7WarpApp:
	link a5,#-4
	moveml #0x2030,sp@-
	movel a5@(8),a3
	tstl a3@(44)
	jne L2209
	pea LC6
	jra L2259
	.even
L2209:
	tstl a3@(64)
	jne L2210
	pea LC9
	jra L2259
	.even
L2210:
	tstl a3@(48)
	jne L2211
	pea LC10
	jra L2259
	.even
L2211:
	pea 3:w
	subql #2,sp
	moveb #1,sp@(1)
	subql #2,sp
	movel a3@(52),sp@-
	jbsr _loadImage__11ImageLoaderPCcb
	addqw #4,sp
	movel d0,sp@
	jbsr _convertImageBuffer__7TextureP11ImageBufferQ27Texture6IBConv
	movel d0,a0
	movel a0,a3@(60)
	addql #8,sp
	jne L2212
	movel a3@(52),sp@-
	pea LC11
	pea LC7
	pea LC8
	jbsr _dialogueBox__9SystemLibPCcN21e
	movel #-50659333,d0
	jra L2258
	.even
L2212:
	movew a0@,d0
	extl d0
	fsmoves a3@(72),fp0
	fsmull d0,fp0
	fmoveml fpcr,d1
	moveq #16,d2
	orl d1,d2
	andw #-33,d2
	fmoveml d2,fpcr
	fmovel fp0,d0
	fmoveml d1,fpcr
	cmpl #128,d0
	jlt L2215
	cmpl #1024,d0
	jle L2217
	movel #1024,d0
	jra L2217
	.even
L2215:
	moveq #127,d0
	notb d0
L2217:
	movew d0,a3@(80)
	movel a3@(60),a0
	movew a0@(2),d0
	extl d0
	fsmoves a3@(72),fp0
	fsmull d0,fp0
	fmoveml fpcr,d1
	moveq #16,d2
	orl d1,d2
	andw #-33,d2
	fmoveml d2,fpcr
	fmovel fp0,d0
	fmoveml d1,fpcr
	cmpl #128,d0
	jlt L2221
	cmpl #768,d0
	jle L2223
	movel #768,d0
	jra L2223
	.even
L2221:
	moveq #127,d0
	notb d0
L2223:
	movew d0,a3@(82)
	movel a3@(48),a0
	movel a0@,a1
	pea LC12
	pea 15:w
	movew d0,a2
	movel a2,sp@-
	movew a3@(80),a2
	movel a2,sp@-
	movel a0,sp@-
	movel a1@(8),a0
	jbsr a0@
	addw #20,sp
	tstl d0
	jeq L2226
	pea LC13
	jra L2259
	.even
L2226:
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
	movel d0,a3@(56)
	jne L2228
	pea LC14
	jra L2259
	.even
L2228:
	movel a3@(64),sp@-
	movel d0,sp@-
	jbsr _setVertices__10RasterizerP10DrawVertex
	addql #8,sp
	cmpb #1,d0
	jeq L2229
	pea LC15
	jra L2259
	.even
L2229:
	movel a3@(56),sp@-
	movel a3@(60),sp@-
	jbsr _associate__7TextureP10Rasterizer
	addql #8,sp
	tstl d0
	jeq L2230
	pea LC16
L2259:
	pea LC7
	pea LC8
	jbsr _dialogueBox__9SystemLibPCcN21e
	movel #-50659333,d0
	jra L2258
	.even
L2230:
	movel a3,sp@-
	jbsr _initMesh__7WarpApp
	movel a3@(60),a2
	addql #4,sp
	tstl a2@(10)
	jeq L2234
	tstl a2@(14)
	jeq L2234
	clrl d0
	moveb __6_Nat3D$texFilter,d0
	movel d0,sp@-
	clrl d0
	moveb __6_Nat3D$texFilter+1,d0
	movel d0,sp@-
	movel a2@(14),sp@-
	movel a2@(10),sp@-
	jbsr _W3D_SetFilter
	addw #16,sp
	tstl d0
	jne L2234
	clrl a2@(34)
	moveq #1,d0
	movel d0,a2@(38)
L2234:
	movel a3@(56),a1
	movel a3@(60),a0
	tstl a0
	jne L2235
	clrl a1@(28)
	clrl sp@-
	jra L2260
	.even
L2235:
	movel a0@(10),d1
	cmpl a1@(4),d1
	jne L2236
	tstl a0@(14)
	jeq L2236
	movel a0,a1@(28)
	movel a0@(14),sp@-
L2260:
	clrl sp@-
	movel a1@(4),sp@-
	jbsr _W3D_BindTexture
	addw #12,sp
L2236:
	movel a3@(56),a0
	pea 2:w
	movel __6_Nat3D$state+68,sp@-
	movel a0@(4),sp@-
	jbsr _W3D_SetState
	addw #12,sp
	movel a3@(56),a0
	pea 2:w
	movel __6_Nat3D$state+16,sp@-
	movel a0@(4),sp@-
	jbsr _W3D_SetState
	addw #12,sp
	movel a3@(56),a0
	pea 1:w
	movel __6_Nat3D$state,sp@-
	movel a0@(4),sp@-
	jbsr _W3D_SetState
	addw #12,sp
	movel a3@(56),a0
	pea 1:w
	movel __6_Nat3D$state+56,sp@-
	movel a0@(4),sp@-
	jbsr _W3D_SetState
	addw #12,sp
	movel #-6250336,a5@(-4)
	movel a5@(-4),sp@-
	movel a3@(56),sp@-
	jbsr _setFlatColour__10RasterizerG6Colour
	movel a3,sp@-
	jbsr _renderMesh__7WarpApp
	movel a3@(48),d0
	addql #4,d0
	movel a3,d2
	addql #4,d2
	addw #12,sp
	jeq L2256
	movel d0,a2
	addql #4,a2
	movel d2,sp@-
	movel a2,sp@-
	jbsr _contains__C7_LLBasePv
	addql #8,sp
	tstb d0
	jne L2256
	movel d2,sp@-
	movel a2,sp@-
	jbsr _insLast__7_LLBasePv
L2256:
	clrl d0
L2258:
	moveml a5@(-16),#0xc04
	unlk a5
	rts
	.even
.globl _initMesh__7WarpApp
_initMesh__7WarpApp:
	pea a5@
	movel sp,a5
	fmovem #0xfc,sp@-
	moveml #0x3c30,sp@-
	movel a5@(8),a2
	movel a2@(64),d2
	fsmovew a2@(80),fp6
	movew a2@(84),a1
	movel a1,d0
	subql #1,d0
	fsmovel d0,fp0
	fsdivx fp0,fp6
	fsmovew a2@(82),fp7
	fsdivx fp0,fp7
	movel a2@(60),a0
	movew a0@,d0
	extl d0
	fsmovel d0,fp4
	fsdivx fp0,fp4
	movew a0@(2),d0
	extl d0
	fsmovel d0,fp5
	fsdivx fp0,fp5
	clrl d3
	movel d3,d4
	clrl d0
	cmpl d0,a1
	jle L2265
	.even
L2267:
	fmoves #0r0,fp2
	fsmovex fp2,fp3
	clrl d1
	addql #1,d0
	fsmoves d4,fp0
	fsaddx fp7,fp0
	fsmoves d3,fp1
	fsaddx fp5,fp1
	cmpl d1,a1
	jle L2266
	movel d2,a1
	.even
L2271:
	fmoves fp3,a1@
	movel d4,a1@(4)
	clrl a1@(8)
	clrl a1@(12)
	fmoves fp2,a1@(16)
	movel d3,a1@(20)
	addql #1,d1
	fsaddx fp6,fp3
	fsaddx fp4,fp2
	addw #32,a1
	moveq #32,d5
	addl d5,d2
	movew a2@(84),a0
	cmpl d1,a0
	jgt L2271
L2266:
	fmoves fp0,d4
	fmoves fp1,d3
	movew a2@(84),a1
	cmpl d0,a1
	jgt L2267
L2265:
	movel a2@(68),a3
	lea 0:w,a1
	jra L2289
	.even
L2277:
	clrl d1
	movel a0,d0
	lea a1@(1),a0
	cmpl d1,d0
	jle L2276
	.even
L2281:
	mulsl d1,d0
	addl a1,d0
	movel d0,a3@+
	addql #1,d1
	movew a2@(84),d0
	extl d0
	cmpl d1,d0
	jgt L2281
L2276:
	movel a0,a1
L2289:
	movew a2@(84),a0
	cmpl a1,a0
	jgt L2277
	moveml sp@+,#0xc3c
	fmovem sp@+,#0x3f
	unlk a5
	rts
	.even
.globl _warpMesh__7WarpAppffb
_warpMesh__7WarpAppffb:
	pea a5@
	movel sp,a5
	fmovem #0x1c,sp@-
	moveml #0x3e20,sp@-
	movel a5@(8),a2
	movel a5@(12),d6
	movel a5@(16),d5
	moveb a5@(23),d4
	movel a2@(64),a1
	clrl d0
	jra L2305
	.even
L2294:
	clrl d2
	movel d0,d3
	addql #1,d3
	cmpl d2,a0
	jle L2293
	.even
L2298:
	movel a1@,d0
	fsmoves d6,fp3
	fssubs d0,fp3
	movel a1@(4),d1
	fsmoves d5,fp4
	fssubs d1,fp4
	fdmoves a2@(76),fp0
	fsmovex fp3,fp1
	fsmulx fp1,fp1
	fsmovex fp4,fp2
	fsmulx fp2,fp2
	fsaddx fp2,fp1
	fdsqrtx fp1,fp1
	fddivx fp1,fp0
	fsmovex fp0,fp0
	tstb d4
	jeq L2299
	fsnegx fp0,fp0
L2299:
	fsmulx fp0,fp3
	fsadds d0,fp3
	fmoves fp3,a1@
	fsmulx fp0,fp4
	fsadds d1,fp4
	fmoves fp4,a1@(4)
	addql #1,d2
	addw #32,a1
	movew a2@(84),a0
	cmpl d2,a0
	jgt L2298
L2293:
	movel d3,d0
L2305:
	movew a2@(84),a0
	cmpl d0,a0
	jgt L2294
	moveml sp@+,#0x47c
	fmovem sp@+,#0x38
	unlk a5
	rts
	.even
.globl _dragMesh__7WarpAppffff
_dragMesh__7WarpAppffff:
	pea a5@
	movel sp,a5
	fmovem #0x4,sp@-
	moveml #0x3f20,sp@-
	movel a5@(8),a2
	movel a5@(12),d7
	movel a5@(16),d6
	movel a5@(20),d5
	movel a5@(24),d4
	movel a2@(64),a1
	clrl d0
	jra L2320
	.even
L2310:
	clrl d2
	movel d0,d3
	addql #1,d3
	cmpl d2,a0
	jle L2309
	.even
L2314:
	movel a1@,d1
	fsmoves d7,fp0
	fssubs d1,fp0
	fsmulx fp0,fp0
	movel a1@(4),d0
	fsmoves d6,fp2
	fssubs d0,fp2
	fsmulx fp2,fp2
	fdmoves a2@(76),fp1
	fsaddx fp2,fp0
	fdsqrtx fp0,fp0
	fddivx fp0,fp1
	fsmovex fp1,fp1
	fsmoves d5,fp0
	fsmulx fp1,fp0
	fsadds d1,fp0
	fmoves fp0,a1@
	fsmuls d4,fp1
	fsadds d0,fp1
	fmoves fp1,a1@(4)
	addql #1,d2
	addw #32,a1
	movew a2@(84),a0
	cmpl d2,a0
	jgt L2314
L2309:
	movel d3,d0
L2320:
	movew a2@(84),a0
	cmpl d0,a0
	jgt L2310
	moveml sp@+,#0x4fc
	fmovem sp@+,#0x20
	unlk a5
	rts
	.even
.globl _restoreMesh__7WarpApp
_restoreMesh__7WarpApp:
	pea a5@
	movel sp,a5
	fmovem #0xc,sp@-
	movel a2,sp@-
	movel d2,sp@-
	movel a5@(8),a2
	movel a2@(64),a1
	fsmovew a2@(80),fp3
	movew a2@(84),a0
	movel a0,d0
	subql #1,d0
	fsmovel d0,fp0
	fsdivx fp0,fp3
	fsmovew a2@(82),fp2
	fsdivx fp0,fp2
	clrl d2
	clrl d1
	cmpl d1,a0
	jle L2332
	.even
L2325:
	fmoves #0r0,fp1
	clrl d0
	addql #1,d1
	fsmoves d2,fp0
	fsaddx fp2,fp0
	cmpl d0,a0
	jle L2324
	.even
L2329:
	fmoves fp1,a1@
	movel d2,a1@(4)
	addql #1,d0
	fsaddx fp3,fp1
	addw #32,a1
	movew a2@(84),a0
	cmpl d0,a0
	jgt L2329
L2324:
	fmoves fp0,d2
	movew a2@(84),a0
	cmpl d1,a0
	jgt L2325
L2332:
	movel sp@+,d2
	movel sp@+,a2
	fmovem sp@+,#0x30
	unlk a5
	rts
	.even
.globl _unwarpMesh__7WarpAppf
_unwarpMesh__7WarpAppf:
	pea a5@
	movel sp,a5
	fmovem #0xfc,sp@-
	moveml #0x3020,sp@-
	movel a5@(8),a2
	movel a5@(12),d2
	movel a2@(64),a1
	fsmovew a2@(80),fp6
	movew a2@(84),a0
	movel a0,d0
	subql #1,d0
	fsmovel d0,fp0
	fsdivx fp0,fp6
	fsmovew a2@(82),fp7
	fsdivx fp0,fp7
	fmoves #0r0,fp0
	clrl d0
	cmpl d0,a0
	jle L2346
	movel #0x3f800000,d3
	.even
L2339:
	fmoves #0r0,fp5
	clrl d1
	addql #1,d0
	fsmovex fp0,fp4
	fsaddx fp7,fp4
	cmpl d1,a0
	jle L2338
	fsmoves d3,fp2
	fssubs d2,fp2
	fsmoves d2,fp3
	fsmulx fp0,fp3
	.even
L2343:
	fsmovex fp2,fp1
	fsmuls a1@,fp1
	fsmoves d2,fp0
	fsmulx fp5,fp0
	fsaddx fp0,fp1
	fmoves fp1,a1@
	fsmovex fp2,fp0
	fsmuls a1@(4),fp0
	fsaddx fp3,fp0
	fmoves fp0,a1@(4)
	addql #1,d1
	fsaddx fp6,fp5
	addw #32,a1
	movew a2@(84),a0
	cmpl d1,a0
	jgt L2343
L2338:
	fsmovex fp4,fp0
	movew a2@(84),a0
	cmpl d0,a0
	jgt L2339
L2346:
	moveml sp@+,#0x40c
	fmovem sp@+,#0x3f
	unlk a5
	rts
	.even
.globl _scrollMesh__7WarpAppss
_scrollMesh__7WarpAppss:
	pea a5@
	movel sp,a5
	fmovem #0x4,sp@-
	movel d2,sp@-
	movel a5@(8),a0
	movew a5@(14),d0
	movew a5@(18),d2
	movel a0@(64),a1
	movew a0@(84),d1
	muls d1,d1
	jeq L2354
	fsmovew d0,fp1
	fsmovew d2,fp0
	movel d1,d0
	negl d0
	moveq #3,d2
	andl d2,d0
	jeq L2352
	cmpl d0,d2
	jle L2357
	moveq #2,d2
	cmpl d0,d2
	jle L2358
	fsmoves a1@,fp2
	fsaddx fp1,fp2
	fmoves fp2,a1@
	fsmoves a1@(4),fp2
	fsaddx fp0,fp2
	fmoves fp2,a1@(4)
	addw #32,a1
	subql #1,d1
L2358:
	fsmoves a1@,fp2
	fsaddx fp1,fp2
	fmoves fp2,a1@
	fsmoves a1@(4),fp2
	fsaddx fp0,fp2
	fmoves fp2,a1@(4)
	addw #32,a1
	subql #1,d1
L2357:
	fsmoves a1@,fp2
	fsaddx fp1,fp2
	fmoves fp2,a1@
	fsmoves a1@(4),fp2
	fsaddx fp0,fp2
	fmoves fp2,a1@(4)
	addw #32,a1
	subql #1,d1
	jeq L2354
	.even
L2352:
	fsmoves a1@,fp2
	fsaddx fp1,fp2
	fmoves fp2,a1@
	fsmoves a1@(4),fp2
	fsaddx fp0,fp2
	fmoves fp2,a1@(4)
	lea a1@(32),a0
	fsmoves a0@,fp2
	fsaddx fp1,fp2
	fmoves fp2,a0@
	fsmoves a0@(4),fp2
	fsaddx fp0,fp2
	fmoves fp2,a0@(4)
	lea a1@(64),a0
	fsmoves a0@,fp2
	fsaddx fp1,fp2
	fmoves fp2,a0@
	fsmoves a0@(4),fp2
	fsaddx fp0,fp2
	fmoves fp2,a0@(4)
	lea a1@(96),a0
	fsmoves a0@,fp2
	fsaddx fp1,fp2
	fmoves fp2,a0@
	fsmoves a0@(4),fp2
	fsaddx fp0,fp2
	fmoves fp2,a0@(4)
	addw #128,a1
	subql #4,d1
	jne L2352
L2354:
	movel sp@+,d2
	fmovem sp@+,#0x20
	unlk a5
	rts
	.even
.globl _zoomMesh__7WarpAppf
_zoomMesh__7WarpAppf:
	pea a5@
	movel sp,a5
	fmovem #0x4,sp@-
	movel d3,sp@-
	movel d2,sp@-
	movel a5@(8),a0
	movel a5@(12),d2
	movel a0@(64),a1
	movew a0@(80),d1
	movew d1,d0
	moveq #15,d3
	lsrw d3,d0
	addw d0,d1
	asrw #1,d1
	fsmovew d1,fp2
	movew a0@(82),d1
	movew d1,d0
	lsrw d3,d0
	addw d0,d1
	asrw #1,d1
	fsmovew d1,fp1
	movew a0@(84),d1
	muls d1,d1
	jeq L2379
	movel d1,d0
	negl d0
	moveq #3,d3
	andl d3,d0
	jeq L2377
	cmpl d0,d3
	jle L2382
	moveq #2,d3
	cmpl d0,d3
	jle L2383
	fsmoves a1@,fp0
	fssubx fp2,fp0
	fsmuls d2,fp0
	fsaddx fp2,fp0
	fmoves fp0,a1@
	fsmoves a1@(4),fp0
	fssubx fp1,fp0
	fsmuls d2,fp0
	fsaddx fp1,fp0
	fmoves fp0,a1@(4)
	addw #32,a1
	subql #1,d1
L2383:
	fsmoves a1@,fp0
	fssubx fp2,fp0
	fsmuls d2,fp0
	fsaddx fp2,fp0
	fmoves fp0,a1@
	fsmoves a1@(4),fp0
	fssubx fp1,fp0
	fsmuls d2,fp0
	fsaddx fp1,fp0
	fmoves fp0,a1@(4)
	addw #32,a1
	subql #1,d1
L2382:
	fsmoves a1@,fp0
	fssubx fp2,fp0
	fsmuls d2,fp0
	fsaddx fp2,fp0
	fmoves fp0,a1@
	fsmoves a1@(4),fp0
	fssubx fp1,fp0
	fsmuls d2,fp0
	fsaddx fp1,fp0
	fmoves fp0,a1@(4)
	addw #32,a1
	subql #1,d1
	jeq L2379
	.even
L2377:
	fsmoves a1@,fp0
	fssubx fp2,fp0
	fsmuls d2,fp0
	fsaddx fp2,fp0
	fmoves fp0,a1@
	fsmoves a1@(4),fp0
	fssubx fp1,fp0
	fsmuls d2,fp0
	fsaddx fp1,fp0
	fmoves fp0,a1@(4)
	lea a1@(32),a0
	fsmoves a0@,fp0
	fssubx fp2,fp0
	fsmuls d2,fp0
	fsaddx fp2,fp0
	fmoves fp0,a0@
	fsmoves a0@(4),fp0
	fssubx fp1,fp0
	fsmuls d2,fp0
	fsaddx fp1,fp0
	fmoves fp0,a0@(4)
	lea a1@(64),a0
	fsmoves a0@,fp0
	fssubx fp2,fp0
	fsmuls d2,fp0
	fsaddx fp2,fp0
	fmoves fp0,a0@
	fsmoves a0@(4),fp0
	fssubx fp1,fp0
	fsmuls d2,fp0
	fsaddx fp1,fp0
	fmoves fp0,a0@(4)
	lea a1@(96),a0
	fsmoves a0@,fp0
	fssubx fp2,fp0
	fsmuls d2,fp0
	fsaddx fp2,fp0
	fmoves fp0,a0@
	fsmoves a0@(4),fp0
	fssubx fp1,fp0
	fsmuls d2,fp0
	fsaddx fp1,fp0
	fmoves fp0,a0@(4)
	addw #128,a1
	subql #4,d1
	jne L2377
L2379:
	movel sp@+,d2
	movel sp@+,d3
	fmovem sp@+,#0x20
	unlk a5
	rts
	.even
.globl _rotateMesh__7WarpAppf
_rotateMesh__7WarpAppf:
	pea a5@
	movel sp,a5
	fmovem #0xfc,sp@-
	movel d3,sp@-
	movel d2,sp@-
	movel a5@(8),a0
	fdmoves a5@(12),fp0
	fdmuld #0r0.01745329251994334,fp0
	fsinx fp0,fp1
	fsmovex fp1,fp1
	fmoves fp1,d2
	fcosx fp0,fp0
	fsmovex fp0,fp6
	movel a0@(64),a1
	movew a0@(80),d1
	movew d1,d0
	moveq #15,d3
	lsrw d3,d0
	addw d0,d1
	asrw #1,d1
	fsmovew d1,fp5
	movew a0@(82),d1
	movew d1,d0
	lsrw d3,d0
	addw d0,d1
	asrw #1,d1
	fsmovew d1,fp4
	movew a0@(84),d1
	muls d1,d1
	jeq L2404
	fsnegs d2,fp7
	movel d1,d0
	negl d0
	moveq #3,d3
	andl d3,d0
	jeq L2402
	cmpl d0,d3
	jle L2407
	moveq #2,d3
	cmpl d0,d3
	jle L2408
	fsmoves a1@,fp2
	fssubx fp5,fp2
	fsmoves a1@(4),fp3
	fssubx fp4,fp3
	fsmovex fp6,fp1
	fsmulx fp2,fp1
	fsmoves d2,fp0
	fsmulx fp3,fp0
	fsaddx fp0,fp1
	fsaddx fp5,fp1
	fmoves fp1,a1@
	fsmulx fp7,fp2
	fsmulx fp6,fp3
	fsaddx fp3,fp2
	fsaddx fp4,fp2
	fmoves fp2,a1@(4)
	addw #32,a1
	subql #1,d1
L2408:
	fsmoves a1@,fp2
	fssubx fp5,fp2
	fsmoves a1@(4),fp3
	fssubx fp4,fp3
	fsmovex fp6,fp1
	fsmulx fp2,fp1
	fsmoves d2,fp0
	fsmulx fp3,fp0
	fsaddx fp0,fp1
	fsaddx fp5,fp1
	fmoves fp1,a1@
	fsmulx fp7,fp2
	fsmulx fp6,fp3
	fsaddx fp3,fp2
	fsaddx fp4,fp2
	fmoves fp2,a1@(4)
	addw #32,a1
	subql #1,d1
L2407:
	fsmoves a1@,fp2
	fssubx fp5,fp2
	fsmoves a1@(4),fp3
	fssubx fp4,fp3
	fsmovex fp6,fp1
	fsmulx fp2,fp1
	fsmoves d2,fp0
	fsmulx fp3,fp0
	fsaddx fp0,fp1
	fsaddx fp5,fp1
	fmoves fp1,a1@
	fsmulx fp7,fp2
	fsmulx fp6,fp3
	fsaddx fp3,fp2
	fsaddx fp4,fp2
	fmoves fp2,a1@(4)
	addw #32,a1
	subql #1,d1
	jeq L2404
	.even
L2402:
	fsmoves a1@,fp2
	fssubx fp5,fp2
	fsmoves a1@(4),fp3
	fssubx fp4,fp3
	fsmovex fp6,fp1
	fsmulx fp2,fp1
	fsmoves d2,fp0
	fsmulx fp3,fp0
	fsaddx fp0,fp1
	fsaddx fp5,fp1
	fmoves fp1,a1@
	fsmulx fp7,fp2
	fsmulx fp6,fp3
	fsaddx fp3,fp2
	fsaddx fp4,fp2
	fmoves fp2,a1@(4)
	lea a1@(32),a0
	fsmoves a0@,fp2
	fssubx fp5,fp2
	fsmoves a0@(4),fp3
	fssubx fp4,fp3
	fsmovex fp6,fp1
	fsmulx fp2,fp1
	fsmoves d2,fp0
	fsmulx fp3,fp0
	fsaddx fp0,fp1
	fsaddx fp5,fp1
	fmoves fp1,a0@
	fsmulx fp7,fp2
	fsmulx fp6,fp3
	fsaddx fp3,fp2
	fsaddx fp4,fp2
	fmoves fp2,a0@(4)
	lea a1@(64),a0
	fsmoves a0@,fp2
	fssubx fp5,fp2
	fsmoves a0@(4),fp3
	fssubx fp4,fp3
	fsmovex fp6,fp1
	fsmulx fp2,fp1
	fsmoves d2,fp0
	fsmulx fp3,fp0
	fsaddx fp0,fp1
	fsaddx fp5,fp1
	fmoves fp1,a0@
	fsmulx fp7,fp2
	fsmulx fp6,fp3
	fsaddx fp3,fp2
	fsaddx fp4,fp2
	fmoves fp2,a0@(4)
	lea a1@(96),a0
	fsmoves a0@,fp2
	fssubx fp5,fp2
	fsmoves a0@(4),fp3
	fssubx fp4,fp3
	fsmovex fp6,fp1
	fsmulx fp2,fp1
	fsmoves d2,fp0
	fsmulx fp3,fp0
	fsaddx fp0,fp1
	fsaddx fp5,fp1
	fmoves fp1,a0@
	fsmulx fp7,fp2
	fsmulx fp6,fp3
	fsaddx fp3,fp2
	fsaddx fp4,fp2
	fmoves fp2,a0@(4)
	addw #128,a1
	subql #4,d1
	jne L2402
L2404:
	movel sp@+,d2
	movel sp@+,d3
	fmovem sp@+,#0x3f
	unlk a5
	rts
	.even
.globl _renderMesh__7WarpApp
_renderMesh__7WarpApp:
	link a5,#-12
	moveml #0x303a,sp@-
	movel a5@(8),a3
	movel a3@(56),a2
	btst #1,a2@(167)
	jne L2473
	movel a2@(4),sp@-
	jbsr _W3D_LockHardware
	addql #4,sp
	tstl d0
	jne L2472
	moveq #2,d0
	orl d0,a2@(164)
L2473:
	tstb a3@(89)
	jeq L2429
	movel a3@(60),a2
	tstl a2@(10)
	jeq L2433
	tstl a2@(14)
	jeq L2433
	clrl sp@-
	clrl d0
	moveb __6_Nat3D$texEnv+2,d0
	movel d0,sp@-
	movel a2@(14),sp@-
	movel a2@(10),sp@-
	jbsr _W3D_SetTexEnv
	addw #16,sp
	tstl d0
	jne L2433
	moveq #2,d0
	movel d0,a2@(42)
	jra L2433
	.even
L2429:
	movel a3@(60),a2
	tstl a2@(10)
	jeq L2433
	tstl a2@(14)
	jeq L2433
	clrl sp@-
	clrl d0
	moveb __6_Nat3D$texEnv,d0
	movel d0,sp@-
	movel a2@(14),sp@-
	movel a2@(10),sp@-
	jbsr _W3D_SetTexEnv
	addw #16,sp
	tstl d0
	jne L2433
	clrl a2@(42)
L2433:
	movel a3@(56),a0
	clrl a5@(-4)
	clrl sp@-
	movel a0@(4),sp@-
	jbsr _W3D_ClearDrawRegion
	addql #8,sp
	movew a3@(84),a0
	movel a0,sp@-
	movew a3@(84),a0
	movel a0,sp@-
	clrl sp@-
	movel a3@(56),sp@-
	jbsr _drawTriMesh2__10RasterizerUlUlUl
	addw #16,sp
	tstb a3@(89)
	jeq L2441
	clrl d3
	movel a3@(68),a4
	movel #-2130706433,a5@(-8)
	movel a5@(-8),sp@-
	movel a3@(56),sp@-
	lea _setFlatColour__10RasterizerG6Colour,a2
	jbsr a2@
	movel a3@(56),a0
	addqw #4,sp
	movel #1,sp@
	movel __6_Nat3D$state+48,sp@-
	movel a0@(4),sp@-
	jbsr _W3D_SetState
	addw #12,sp
	movel a3@(56),a0
	pea 2:w
	movel __6_Nat3D$state,sp@-
	movel a0@(4),sp@-
	jbsr _W3D_SetState
	addw #12,sp
	clrl d2
	movew a3@(84),a1
	movel a2,a6
	lea a5@(-12),a2
	cmpl d2,a1
	jle L2451
	.even
L2453:
	movel a3@(56),a0
	movel a1,sp@-
	movel d3,sp@-
	pea 6:w
	movel a0@(4),sp@-
	jbsr _W3D_DrawArray
	addw #16,sp
	addql #1,d2
	movew a3@(84),a0
	addl a0,d3
	movel a0,a1
	cmpl d2,a1
	jgt L2453
L2451:
	clrl d2
	movew a3@(84),a1
	cmpl d2,a1
	jle L2457
	.even
L2459:
	movel a3@(56),a0
	movel a4,sp@-
	pea a1@(1)
	pea 2:w
	pea 6:w
	movel a0@(4),sp@-
	jbsr _W3D_DrawElements
	addw #20,sp
	addql #1,d2
	movew a3@(84),a0
	lea a4@(a0:l:4),a4
	movel a0,a1
	cmpl d2,a1
	jgt L2459
L2457:
	movel a3@(56),a0
	pea 1:w
	movel __6_Nat3D$state,sp@-
	movel a0@(4),sp@-
	jbsr _W3D_SetState
	addw #12,sp
	movel a3@(56),a0
	pea 2:w
	movel __6_Nat3D$state+48,sp@-
	movel a0@(4),sp@-
	jbsr _W3D_SetState
	addw #12,sp
	movel #-6250336,a2@
	movel a5@(-12),sp@-
	movel a3@(56),sp@-
	jbsr a6@
	addql #8,sp
L2441:
	movel a3@(56),a0
	movel a0@(4),sp@-
	jbsr _W3D_FlushFrame
	addql #4,sp
	movel a3@(56),a0
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
L2472:
	moveml a5@(-36),#0x5c0c
	unlk a5
	rts
	.even
.globl _runApplication__7WarpApp
_runApplication__7WarpApp:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel a5@(8),a2
	tstb a2@(88)
	jne L2478
	.even
L2479:
	clrb a2@(86)
	.even
L2480:
	movel a2@(48),a0
	movel a0@(28),a1
	pea a0@(4)
	movel a1@(20),a0
	jbsr a0@
	addql #4,sp
	tstb d0
	jne L2480
	tstb a2@(86)
	jeq L2484
	movel a2,sp@-
	jbsr _renderMesh__7WarpApp
	addql #4,sp
L2484:
	movel a2@(48),a0
	movel a0@(28),a1
	pea a0@(4)
	movel a1@(16),a0
	jbsr a0@
	addql #4,sp
	tstb a2@(88)
	jeq L2479
L2478:
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
___thunk_4_mousePress__7WarpAppP15InputDispatcherUl:
	pea a5@
	movel sp,a5
	movel a5@(16),sp@-
	movel a5@(12),sp@-
	movel a5@(8),d0
	subql #4,d0
	movel d0,sp@-
	jbsr _mousePress__7WarpAppP15InputDispatcherUl
	unlk a5
	rts
	.even
___thunk_4_mouseDrag__7WarpAppP15InputDispatcherssssUl:
	pea a5@
	movel sp,a5
	movel a5@(32),sp@-
	movew a5@(30),sp@-
	subql #2,sp
	movew a5@(26),sp@-
	subql #2,sp
	movew a5@(22),sp@-
	subql #2,sp
	movew a5@(18),sp@-
	subql #2,sp
	movel a5@(12),sp@-
	movel a5@(8),d0
	subql #4,d0
	movel d0,sp@-
	jbsr _mouseDrag__7WarpAppP15InputDispatcherssssUl
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
	.long ___thunk_4_mousePress__7WarpAppP15InputDispatcherUl
	.long _mouseRelease__10InputFocusP15InputDispatcherUl
	.long _mouseMove__10InputFocusP15InputDispatcherssss
	.long ___thunk_4_mouseDrag__7WarpAppP15InputDispatcherssssUl
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
	jeq L2497
	movel a2,sp@-
	jbsr ___builtin_delete
L2497:
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
	.long ___pure_virtual
	.long __$_18InteractiveDisplay
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
	.long ___pure_virtual
	.long __$_7Display
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
__$_7Display:
	pea a5@
	movel sp,a5
	movel a5@(8),a0
	movel #___vt_7Display,a0@
	btst #0,a5@(15)
	jeq L208
	movel a0,sp@-
	jbsr ___builtin_delete
L208:
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
	jeq L501
	movel a2,sp@-
	jbsr ___builtin_delete
L501:
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
	jeq L534
	movel a0,sp@-
	jbsr ___builtin_delete
L534:
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
	jeq L947
	movel a2,sp@-
	jbsr ___builtin_delete
L947:
	movel a5@(-8),d2
	movel a5@(-4),a2
	unlk a5
	rts
