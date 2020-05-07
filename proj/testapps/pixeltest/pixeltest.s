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
	pea 52:w
	jbsr ___nw__FUlRC9nothrow_t
	movel d0,a5@(-52)
	movel a5@(-56),a0
	addql #4,a0
	movel a0@,a5@(-24)
	clrl a5@(-20)
	movel a5,a5@(-16)
	movel #L997,a5@(-12)
	movel sp,a5@(-8)
	movel a0,a5@(-60)
	jra L996
	.even
L997:
	movel a5@(-56),a0
	addql #4,a0
	movel a0,a5@(-60)
	jra L994
	.even
L996:
	lea a5@(-24),a1
	movel a1,a0@
	movel a5@(-52),sp@-
	jbsr ___10GfxTestApp
	movel a5@(-60),a1
	movel a1@,a0
	movel a0@,a1@
	jra L1008
	.even
L994:
	movel a5@(-60),a0
	movel a0@,a5@(-48)
	clrl a5@(-44)
	movel a5,a5@(-40)
	movel #L1003,a5@(-36)
	movel sp,a5@(-32)
	jra L1002
	.even
L1003:
	jra L1009
	.even
L1002:
	lea a5@(-48),a0
	movel a5@(-60),a1
	movel a0,a1@
	moveq #1,d0
	jeq L1005
	pea _nothrow
	movel a5@(-52),sp@-
	jbsr ___dl__FPvRC9nothrow_t
	addql #8,sp
L1005:
	movel a5@(-56),a1
	addql #4,a1
	movel a1@,a0
	movel a0@,a1@
	jbsr ___sjthrow
	.even
L1009:
L1000:
	jbsr ___terminate
	.even
L1008:
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
	jeq L1012
	movel a1@,a0
	pea 3:w
	movel a1,sp@-
	movel a0@(20),a0
	jbsr a0@
L1012:
	unlk a5
	rts
LC1:
	.ascii "width\0"
LC2:
	.ascii "height\0"
LC3:
	.ascii "fullscreen\0"
LC4:
	.ascii "lock\0"
LC5:
	.ascii "MC68040\0"
LC6:
	.ascii "MC68060\0"
	.even
.globl ___10GfxTestApp
___10GfxTestApp:
	link a5,#-268
	fmovem #0xfc,sp@-
	moveml #0x3f3a,sp@-
	jbsr ___get_eh_context
	movel d0,a5@(-244)
	movel d0,a5@(-264)
	movel a5@(8),a0
	movel #___vt_7AppBase,a0@
	movel a5@(-244),a0
	addql #4,a0
	movel a0@,a5@(-24)
	clrl a5@(-20)
	movel a5,a5@(-16)
	movel #L1021,a5@(-12)
	movel sp,a5@(-8)
	jra L1020
	.even
L1021:
	jra L1127
	.even
L1020:
	lea a5@(-24),a1
	movel a1,a0@
	movel a5@(8),a2
	movel #___vt_10GfxTestApp,a2@
	clrl a2@(6)
	pea a2@(14)
	movel a5@(-264),a0
	addql #4,a0
	movel a0,a5@(-268)
	jbsr _ReadEClock
	movel d0,__10MilliClock$clockFreq
	addql #4,sp
	moveq #15,d0
	movel d0,a2@(34)
	clrb a2@(50)
	subql #2,sp
	moveb #0,sp@(1)
	subql #2,sp
	pea LC1
	jbsr _getInteger__7AppBasePCcb
	addql #8,sp
	tstl d0
	jeq L1024
	cmpl #160,d0
	jlt L1025
	cmpl #1024,d0
	jle L1027
	movel #1024,d0
	jra L1027
	.even
L1025:
	moveq #95,d0
	notb d0
L1027:
	movel a5@(8),a0
	movel d0,a0@(22)
	jra L1030
	.even
L1024:
	movel a5@(8),a1
	movel #640,a1@(22)
L1030:
	subql #2,sp
	moveb #0,sp@(1)
	subql #2,sp
	pea LC2
	movel a5@(-264),a2
	addql #4,a2
	movel a2,a5@(-268)
	jbsr _getInteger__7AppBasePCcb
	addql #8,sp
	tstl d0
	jeq L1031
	moveq #120,d1
	cmpl d0,d1
	jgt L1032
	cmpl #768,d0
	jle L1034
	movel #768,d0
	jra L1034
	.even
L1032:
	moveq #120,d0
L1034:
	movel a5@(8),a0
	movel d0,a0@(26)
	jra L1037
	.even
L1031:
	movel a5@(8),a1
	movel #480,a1@(26)
L1037:
	pea 256:w
	movel a5@(-264),a2
	addql #4,a2
	movel a2,a5@(-268)
	jbsr ___builtin_vec_new
	movel a5@(8),a0
	movel d0,a0@(10)
	subql #2,sp
	moveb #0,sp@(1)
	subql #2,sp
	pea LC3
	jbsr _getInteger__7AppBasePCcb
	movel d0,a5@(-248)
	subql #2,sp
	moveb #0,sp@(1)
	subql #2,sp
	pea LC4
	jbsr _getSwitch__7AppBasePCcb
	movel a5@(8),a1
	moveb d0,a1@(51)
	addw #20,sp
	tstl a5@(-248)
	jeq L1038
	moveq #16,d0
	cmpl a5@(-248),d0
	jne L1039
	movel d0,a1@(34)
	jra L1040
	.even
L1039:
	moveq #24,d1
	cmpl a5@(-248),d1
	jlt L1041
	movel a5@(8),a0
	movel d1,a0@(34)
	jra L1040
	.even
L1041:
	moveq #32,d0
	movel a5@(8),a0
	movel d0,a0@(34)
L1040:
	pea 290:w
	movel a5@(-264),a1
	addql #4,a1
	movel a1,a5@(-268)
	jbsr ___builtin_new
	movel d0,a5@(-252)
	moveb #1,a5@(-253)
	movel a5@(-268),a0
	movel a0@,a5@(-48)
	clrl a5@(-44)
	movel a5,a5@(-40)
	movel #L1046,a5@(-36)
	movel sp,a5@(-32)
	jra L1045
	.even
L1046:
	jra L1128
	.even
L1045:
	moveq #-48,d1
	addl a5,d1
	movel d1,a0@
	addql #4,sp
	movel a5@(-264),d0
	movel a5@(-252),a2
	movel #___vt_7Display,a2@
	movel d0,a0
	addql #4,a0
	movel a0@,a5@(-72)
	clrl a5@(-68)
	movel d1,a5@(-64)
	movel #L1051,a5@(-60)
	movel sp,a5@(-56)
L1051:
	lea a5@(-72),a1
	movel a1,a0@
	movel a5@(-252),a2
	pea a2@(4)
	jbsr ___7_NatScr
	movel a5@(-244),a0
	addql #4,a0
	movel a0@,a5@(-96)
	clrl a5@(-92)
	lea a5@(-48),a1
	movel a1,a5@(-88)
	movel #L1054,a5@(-84)
	movel sp,a5@(-80)
	movel a0,a1
L1054:
	lea a5@(-96),a2
	movel a2,a0@
	movel a5@(-252),a0
	movel #___vt_13DisplayScreen,a0@
	addql #4,sp
	movel a1@,a0
	movel a0@,a1@
	movel a1@,a0
	movel a0@,a1@
	jra L1056
	.even
L1049:
	movel a5@(-244),a0
	addql #4,a0
	movel a0@,a5@(-144)
	clrl a5@(-140)
	lea a5@(-48),a1
	movel a1,a5@(-136)
	movel #L1063,a5@(-132)
	movel sp,a5@(-128)
	movel a0,a1
L1063:
	lea a5@(-144),a2
	movel a2,a0@
	movel a5@(-252),a0
	movel #___vt_7Display,a0@
	movel a1@,a0
	movel a0@,a1@
	jbsr ___sjthrow
	.even
L1056:
	clrb a5@(-253)
	movel a5@(8),a1
	movel a5@(-252),a1@(6)
	jra L1129
	.even
L1038:
	pea 294:w
	jbsr ___builtin_new
	movel d0,a5@(-258)
	moveb #1,a5@(-259)
	movel a5@(-268),a1
	movel a1@,a5@(-168)
	clrl a5@(-164)
	lea a5@(-160),a0
	movel a5,a0@
	movel #L1074,a0@(4)
	movel sp,a0@(8)
	jra L1073
	.even
L1074:
	jra L1130
	.even
L1073:
	lea a5@(-168),a0
	movel a0,a1@
	addql #4,sp
	movel a5@(-264),d0
	movel a5@(-258),a1
	movel #___vt_7Display,a1@
	movel d0,a0
	addql #4,a0
	movel a0@,a5@(-72)
	clrl a5@(-68)
	lea a5@(-48),a2
	movel a2,a5@(-64)
	movel #L1079,a5@(-60)
	movel sp,a5@(-56)
L1079:
	lea a5@(-72),a1
	movel a1,a0@
	movel a5@(-258),a2
	pea a2@(4)
	jbsr ___7_NatWin
	movel a5@(-244),a0
	addql #4,a0
	movel a0@,a5@(-96)
	clrl a5@(-92)
	lea a5@(-48),a1
	movel a1,a5@(-88)
	movel #L1082,a5@(-84)
	movel sp,a5@(-80)
	movel a0,a1
L1082:
	lea a5@(-96),a2
	movel a2,a0@
	movel a5@(-258),a0
	movel #___vt_13DisplayWindow,a0@
	addql #4,sp
	movel a1@,a0
	movel a0@,a1@
	movel a1@,a0
	movel a0@,a1@
	jra L1084
	.even
L1077:
	movel a5@(-244),a0
	addql #4,a0
	movel a0@,a5@(-144)
	clrl a5@(-140)
	lea a5@(-48),a1
	movel a1,a5@(-136)
	movel #L1091,a5@(-132)
	movel sp,a5@(-128)
	movel a0,a1
L1091:
	lea a5@(-144),a2
	movel a2,a0@
	movel a5@(-258),a0
	movel #___vt_7Display,a0@
	movel a1@,a0
	movel a0@,a1@
	jbsr ___sjthrow
	.even
L1084:
	clrb a5@(-259)
	movel a5@(8),a1
	movel a5@(-258),a1@(6)
L1129:
	movel a5@(-268),a2
	movel a2@,a0
	movel a0@,a2@
	pea LC5
	jbsr _cpuType__3CPU
	lea __3CPU$cpuNames,a0
	movel a0@(d0:l:4),sp@-
	jbsr _stricmp
	addql #8,sp
	tstl d0
	jeq L1099
	pea LC6
	jbsr _cpuType__3CPU
	lea __3CPU$cpuNames,a1
	movel a1@(d0:l:4),sp@-
	jbsr _stricmp
	tstl d0
	jne L1098
L1099:
	movel a5@(8),a2
	moveb #1,a2@(50)
L1098:
	movel a5@(-268),a1
	movel a1@,a0
	movel a0@,a1@
	movel a5@(8),d0
	jra L1126
	.even
L1128:
L1043:
	movel a5@(-268),a2
	movel a2@,a5@(-192)
	clrl a5@(-188)
	lea a5@(-184),a0
	movel a5,a0@
	movel #L1108,a0@(4)
	movel sp,a0@(8)
	jra L1107
	.even
L1108:
	jra L1131
	.even
L1107:
	lea a5@(-192),a1
	movel a5@(-268),a0
	movel a1,a0@
	tstb a5@(-253)
	jeq L1110
	movel a5@(-252),sp@-
	jbsr ___builtin_delete
	addql #4,sp
L1110:
	movel a5@(-268),a2
	movel a2@,a0
	movel a0@,a2@
	jbsr ___sjthrow
	.even
L1130:
L1071:
	movel a5@(-268),a0
	movel a0@,a5@(-216)
	clrl a5@(-212)
	lea a5@(-208),a0
	movel a5,a0@
	movel #L1114,a0@(4)
	movel sp,a0@(8)
	jra L1113
	.even
L1114:
	jra L1132
	.even
L1113:
	lea a5@(-216),a2
	movel a5@(-268),a1
	movel a2,a1@
	tstb a5@(-259)
	jeq L1116
	movel a5@(-258),sp@-
	jbsr ___builtin_delete
	addql #4,sp
L1116:
	movel a5@(-268),a1
	movel a1@,a0
	movel a0@,a1@
	jbsr ___sjthrow
	.even
L1127:
L1018:
	movel a5@(-268),a2
	movel a2@,a5@(-240)
	clrl a5@(-236)
	lea a5@(-232),a0
	movel a5,a0@
	movel #L1120,a0@(4)
	movel sp,a0@(8)
	jra L1119
	.even
L1120:
	jra L1133
	.even
L1119:
	lea a5@(-240),a1
	movel a5@(-268),a0
	movel a1,a0@
	movel a5@(8),a2
	movel #___vt_7AppBase,a2@
	movel a0@,a0
	movel a5@(-268),a1
	movel a0@,a1@
	jbsr ___sjthrow
	.even
L1131:
L1105:
	jbsr ___terminate
	.even
L1132:
L1111:
	jbsr ___terminate
	.even
L1133:
L1117:
	jbsr ___terminate
	.even
L1126:
	moveml a5@(-380),#0x5cfc
	fmovem a5@(-340),#0x3f
	unlk a5
	rts
	.even
.globl __$_10GfxTestApp
__$_10GfxTestApp:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel a5@(8),a2
	movel #___vt_10GfxTestApp,a2@
	movel a2@(6),a1
	tstl a1
	jeq L1136
	movel a1@,a0
	pea 3:w
	movel a1,sp@-
	movel a0@(48),a0
	jbsr a0@
	addql #8,sp
L1136:
	movel a2@(10),d0
	jeq L1138
	movel d0,sp@-
	jbsr ___builtin_vec_delete
	addql #4,sp
L1138:
	movel a2@(42),d0
	jeq L1139
	movel d0,sp@-
	jbsr _free__3MemPv
	addql #4,sp
L1139:
	movel a2@(38),d0
	jeq L1141
	movel d0,sp@-
	jbsr _free__3MemPv
	addql #4,sp
L1141:
	movel #___vt_7AppBase,a2@
	movel a5@(12),d0
	btst #0,d0
	jeq L1145
	movel a2,sp@-
	jbsr ___builtin_delete
L1145:
	movel a5@(-4),a2
	unlk a5
	rts
	.even
.globl _lockKernel__10GfxTestApp
_lockKernel__10GfxTestApp:
	pea a5@
	movel sp,a5
	movel a5@(8),a0
	tstb a0@(51)
	jeq L1147
	jbsr _Forbid
	jbsr _Disable
L1147:
	unlk a5
	rts
	.even
.globl _unlockKernel__10GfxTestApp
_unlockKernel__10GfxTestApp:
	pea a5@
	movel sp,a5
	movel a5@(8),a0
	tstb a0@(51)
	jeq L1149
	jbsr _Enable
	jbsr _Permit
L1149:
	unlk a5
	rts
	.even
.globl _readMem__10GfxTestAppPvUl
_readMem__10GfxTestAppPvUl:
	pea a5@
	movel sp,a5
#APP
	
/*************************************/

	move.l a5@(8), a0
	move.l a5@(12), d0
	jsr readMem__GfxTestApp

/*************************************/


#NO_APP
	unlk a5
	rts
	.even
.globl _copyMem16__10GfxTestAppPvT1Ul
_copyMem16__10GfxTestAppPvT1Ul:
	pea a5@
	movel sp,a5
#APP
	
/*************************************/

	move.l a5@(8), a0
	move.l a5@(12), a1
	move.l a5@(16), d0
	jsr copyMem16__GfxTestApp

/*************************************/


#NO_APP
	unlk a5
	rts
	.even
.globl _shuffleCopy16__10GfxTestAppPvT1Ul
_shuffleCopy16__10GfxTestAppPvT1Ul:
	pea a5@
	movel sp,a5
#APP
	
/*************************************/

	move.l a5@(8), a0
	move.l a5@(12), a1
	move.l a5@(16), d0
	jsr shuffleCopy16__GfxTestApp

/*************************************/


#NO_APP
	unlk a5
	rts
	.even
.globl _setMem16__10GfxTestAppPvlUl
_setMem16__10GfxTestAppPvlUl:
	pea a5@
	movel sp,a5
#APP
	
/*************************************/

	move.l a5@(8), a0
	move.l a5@(12), d0
	move.l a5@(16), d1
	jsr set16__GfxTestApp

/*************************************/


#NO_APP
	unlk a5
	rts
LC7:
	.ascii "EXNG pixeltest\0"
LC8:
	.ascii "fmt\0"
LC9:
	.ascii "RGB15B\0"
LC10:
	.ascii "BGR15B\0"
LC11:
	.ascii "RGB15L\0"
LC12:
	.ascii "BGR15L\0"
LC13:
	.ascii "RGB16B\0"
LC14:
	.ascii "BGR16B\0"
LC15:
	.ascii "RGB16L\0"
LC16:
	.ascii "BGR16L\0"
LC17:
	.ascii "RGB24P\0"
LC18:
	.ascii "BGR24P\0"
LC19:
	.ascii "ARGB32B\0"
LC20:
	.ascii "ABGR32B\0"
LC21:
	.ascii "ARGB32L\0"
LC22:
	.ascii "ABGR32L\0"
	.even
.globl _initApplication__10GfxTestApp
_initApplication__10GfxTestApp:
	pea a5@
	movel sp,a5
	moveml #0x2030,sp@-
	movel a5@(8),a2
	movel a2@(6),a1
	tstl a1
	jeq L1156
	movel a1@,a0
	pea LC7
	movel a2@(34),sp@-
	movew a2@(28),a3
	movel a3,sp@-
	movew a2@(24),a3
	movel a3,sp@-
	movel a1,sp@-
	movel a0@(8),a0
	jbsr a0@
	addw #20,sp
	tstl d0
	jeq L1155
L1156:
	movel #-50659333,d0
	jra L1188
	.even
L1155:
	subql #2,sp
	moveb #0,sp@(1)
	subql #2,sp
	pea LC8
	jbsr _getString__7AppBasePCcb
	movel d0,d2
	addql #8,sp
	jeq L1157
	pea LC9
	movel d2,sp@-
	lea _stricmp,a3
	jbsr a3@
	addql #8,sp
	tstl d0
	jne L1158
	moveq #1,d0
	movel d0,a2@(30)
	jra L1186
	.even
L1158:
	pea LC10
	movel d2,sp@-
	jbsr a3@
	addql #8,sp
	tstl d0
	jne L1160
	moveq #2,d0
	movel d0,a2@(30)
	jra L1186
	.even
L1160:
	pea LC11
	movel d2,sp@-
	jbsr a3@
	addql #8,sp
	tstl d0
	jne L1162
	moveq #3,d0
	movel d0,a2@(30)
	jra L1186
	.even
L1162:
	pea LC12
	movel d2,sp@-
	jbsr a3@
	addql #8,sp
	tstl d0
	jne L1164
	moveq #4,d0
	movel d0,a2@(30)
	jra L1186
	.even
L1164:
	pea LC13
	movel d2,sp@-
	jbsr a3@
	addql #8,sp
	tstl d0
	jeq L1184
	pea LC14
	movel d2,sp@-
	jbsr a3@
	addql #8,sp
	tstl d0
	jne L1168
	moveq #6,d0
	movel d0,a2@(30)
	jra L1186
	.even
L1168:
	pea LC15
	movel d2,sp@-
	jbsr a3@
	addql #8,sp
	tstl d0
	jne L1170
	moveq #7,d0
	movel d0,a2@(30)
	jra L1186
	.even
L1170:
	pea LC16
	movel d2,sp@-
	jbsr a3@
	addql #8,sp
	tstl d0
	jne L1172
	moveq #8,d0
	movel d0,a2@(30)
	jra L1186
	.even
L1172:
	pea LC17
	movel d2,sp@-
	jbsr a3@
	addql #8,sp
	tstl d0
	jne L1174
	moveq #9,d0
	movel d0,a2@(30)
	jra L1186
	.even
L1174:
	pea LC18
	movel d2,sp@-
	jbsr a3@
	addql #8,sp
	tstl d0
	jne L1176
	moveq #10,d0
	movel d0,a2@(30)
	jra L1186
	.even
L1176:
	pea LC19
	movel d2,sp@-
	jbsr a3@
	addql #8,sp
	tstl d0
	jne L1178
	moveq #11,d0
	movel d0,a2@(30)
	jra L1186
	.even
L1178:
	pea LC20
	movel d2,sp@-
	jbsr a3@
	addql #8,sp
	tstl d0
	jne L1180
	moveq #12,d0
	movel d0,a2@(30)
	jra L1186
	.even
L1180:
	pea LC21
	movel d2,sp@-
	jbsr a3@
	addql #8,sp
	tstl d0
	jne L1182
	moveq #13,d0
	movel d0,a2@(30)
	jra L1186
	.even
L1182:
	pea LC22
	movel d2,sp@-
	jbsr a3@
	addql #8,sp
	tstl d0
	jne L1184
	moveq #14,d0
	movel d0,a2@(30)
	jra L1186
	.even
L1184:
	moveq #5,d0
	movel d0,a2@(30)
	jra L1186
	.even
L1157:
	movel a2@(6),a0
	movel a0@,a1
	movel a0,sp@-
	movel a1@(40),a0
	jbsr a0@
	movel d0,a0
	addql #4,sp
	movel a0@(36),a2@(30)
L1186:
	movel a2,sp@-
	jbsr _createTestData__10GfxTestApp
L1188:
	moveml a5@(-12),#0xc04
	unlk a5
	rts
LC23:
	.ascii "swapped\0"
LC24:
	.ascii "native\0"
LC25:
	.ascii "\12Bytes   : %lu, endian %s\12\0"
LC26:
	.ascii "Bits    : A[%3lu] R[%3lu] G[%3lu] B[%3lu]\12\0"
LC27:
	.ascii "Offsets : A[%3lu] R[%3lu] G[%3lu] B[%3lu]\12\0"
LC28:
	.ascii "Maxima  : A[%3lu] R[%3lu] G[%3lu] B[%3lu]\12\0"
LC29:
	.ascii "\12\0"
	.even
.globl _dumpPixelInfo__10GfxTestAppP15PixelDescriptor
_dumpPixelInfo__10GfxTestAppP15PixelDescriptor:
	pea a5@
	movel sp,a5
	moveml #0x2030,sp@-
	movel a5@(12),a3
	movel #LC24,d0
	tstb a3@(3)
	jeq L1190
	movel #LC23,d0
L1190:
	movel d0,sp@-
	clrl d0
	moveb a3@,d0
	movel d0,sp@-
	pea LC25
	lea _printf,a2
	jbsr a2@
	addw #12,sp
	clrl d0
	moveb a3@(7),d0
	movel d0,sp@-
	clrl d0
	moveb a3@(6),d0
	movel d0,sp@-
	clrl d0
	moveb a3@(5),d0
	movel d0,sp@-
	clrl d0
	moveb a3@(4),d0
	movel d0,sp@-
	pea LC26
	jbsr a2@
	addw #20,sp
	clrl d0
	moveb a3@(11),d0
	movel d0,sp@-
	clrl d0
	moveb a3@(10),d0
	movel d0,sp@-
	clrl d0
	moveb a3@(9),d0
	movel d0,sp@-
	clrl d0
	moveb a3@(8),d0
	movel d0,sp@-
	pea LC27
	jbsr a2@
	addw #20,sp
	clrl d2
	moveb a3@(7),d2
	moveq #1,d1
	movel d1,d0
	lsll d2,d0
	movel d0,a0
	pea a0@(-1)
	clrl d2
	moveb a3@(6),d2
	movel d1,d0
	lsll d2,d0
	movel d0,a0
	pea a0@(-1)
	clrl d2
	moveb a3@(5),d2
	movel d1,d0
	lsll d2,d0
	movel d0,a0
	pea a0@(-1)
	clrl d0
	moveb a3@(4),d0
	lsll d0,d1
	movel d1,a0
	pea a0@(-1)
	pea LC28
	jbsr a2@
	pea LC29
	jbsr a2@
	moveml a5@(-12),#0xc04
	unlk a5
	rts
	.even
.globl _createTestData__10GfxTestApp
_createTestData__10GfxTestApp:
	link a5,#-24
	moveml #0x3f3a,sp@-
	movel a5@(8),a3
	movel a3@(30),a0
	lea a0@(a0:l:2),a0
	movel a0,d0
	lsll #2,d0
	movel d0,a4
	addl #__15PixelDescriptor$propTab,a4
	tstl a4
	jeq L1209
	clrl d1
	moveb a4@,d1
	moveq #1,d0
	cmpl d1,d0
	jne L1208
L1209:
	movel #-50397184,d0
	jra L1270
	.even
L1208:
	movel a3@(22),d0
	mulsl a3@(26),d0
	mulsl d1,d0
	clrl d2
	lea _alloc__3MemUlbQ23Mem9AlignType,a2
	cmpl d2,d0
	jls L1213
	.even
L1214:
	addl #1048576,d2
	cmpl d2,d0
	jhi L1214
L1213:
	pea 16:w
	subql #2,sp
	moveb #0,sp@(1)
	subql #2,sp
	movel d2,sp@-
	jbsr a2@
	movel d0,a3@(38)
	pea 16:w
	subql #2,sp
	moveb #0,sp@(1)
	subql #2,sp
	movel d2,sp@-
	jbsr a2@
	movel d0,a3@(42)
	addw #24,sp
	movel a3@(38),d3
	jeq L1217
	tstl d0
	jne L1216
L1217:
	movel #-50528257,d0
	jra L1270
	.even
L1216:
	movel d2,a3@(46)
	clrl d2
	moveb a4@(5),d2
	moveq #1,d1
	movel d1,d0
	lsll d2,d0
	subql #1,d0
	swap d0
	clrw d0
	movel a3@(26),d5
	movel d0,d2
	divul d5,d2
	movel d2,a5@(-4)
	clrl d2
	moveb a4@(6),d2
	movel d1,d0
	lsll d2,d0
	subql #1,d0
	swap d0
	clrw d0
	movel d0,a5@(-8)
	movel a3@(22),d0
	movel a5@(-8),d4
	divul d0,d4
	movel d4,a5@(-8)
	clrl d2
	moveb a4@(7),d2
	lsll d2,d1
	movel d1,a6
	subql #1,a6
	movel a6,d7
	swap d7
	clrw d7
	divul d0,d7
	movel d7,a6
	clrl d0
	moveb a4@(9),d0
	movel d0,a5@(-12)
	clrl d1
	moveb a4@(10),d1
	movel d1,a5@(-16)
	clrl d2
	moveb a4@(11),d2
	movel d2,a5@(-20)
	clrl d0
	moveb a4@,d0
	moveq #3,d4
	cmpl d0,d4
	jeq L1239
	jcs L1268
	moveq #2,d7
	cmpl d0,d7
	jeq L1225
	jra L1224
	.even
L1268:
	moveq #4,d1
	cmpl d0,d1
	jeq L1251
	jra L1224
	.even
L1225:
	movel d3,a2
	clrl d1
	clrl d3
	cmpl d3,d5
	jle L1227
	clrl d6
	.even
L1229:
	lea 0:w,a1
	moveb a4@(6),d6
	moveq #1,d0
	lsll d6,d0
	movel d0,d2
	subql #1,d2
	swap d2
	clrw d2
	lea 0:w,a0
	movel d3,d5
	addql #1,d5
	movel a5@(-4),d4
	addl d1,d4
	cmpl a3@(22),a0
	jge L1228
	movel d1,d3
	clrw d3
	swap d3
	movel a5@(-12),d7
	lsll d7,d3
	.even
L1234:
	movel d2,d0
	clrw d0
	swap d0
	movel a5@(-16),d1
	lsll d1,d0
	movew d3,d1
	orw d0,d1
	movel a1,d0
	clrw d0
	swap d0
	movel a5@(-20),d7
	lsll d7,d0
	orw d0,d1
	movew d1,a2@+
	addql #1,a0
	addl a6,a1
	subl a5@(-8),d2
	cmpl a3@(22),a0
	jlt L1234
L1228:
	movel d5,d3
	movel d4,d1
	cmpl a3@(26),d3
	jlt L1229
L1227:
	tstb a4@(3)
	jeq L1263
	movel a3@(22),d0
	mulsl a3@(26),d0
	movel d0,sp@-
	movel a3@(38),sp@-
	movel a3@(38),sp@-
	jbsr _swap16__3MemPvPCvUl
	jra L1271
	.even
L1239:
	movel d3,d2
	clrl d4
	lea 0:w,a0
	cmpl a0,d5
	jle L1263
	movel a0,a5@(-24)
	.even
L1243:
	clrl d5
	moveb a4@(6),a5@(-21)
	moveq #1,d0
	movel a5@(-24),d1
	lsll d1,d0
	movel d0,d1
	subql #1,d1
	swap d1
	clrw d1
	clrl d3
	movel a0,d7
	addql #1,d7
	movel a5@(-4),d6
	addl d4,d6
	cmpl a3@(22),d3
	jge L1242
	clrw d4
	swap d4
	movel a5@(-20),a2
	addl d2,a2
	movel a5@(-16),a1
	addl d2,a1
	movel a5@(-12),a0
	addl d2,a0
	.even
L1248:
	moveb d4,a0@
	addql #3,a0
	movel d1,d0
	clrw d0
	swap d0
	moveb d0,a1@
	addql #3,a1
	movel d5,d0
	clrw d0
	swap d0
	moveb d0,a2@
	addql #3,a2
	addql #1,d3
	addl a6,d5
	subl a5@(-8),d1
	addql #3,d2
	cmpl a3@(22),d3
	jlt L1248
L1242:
	movel d7,a0
	movel d6,d4
	cmpl a3@(26),a0
	jlt L1243
	jra L1263
	.even
L1251:
	movel d3,a2
	clrl d1
	clrl d3
	cmpl d3,d5
	jle L1253
	clrl d6
	.even
L1255:
	lea 0:w,a1
	moveb a4@(6),d6
	moveq #1,d0
	lsll d6,d0
	movel d0,d2
	subql #1,d2
	swap d2
	clrw d2
	lea 0:w,a0
	movel d3,d5
	addql #1,d5
	movel a5@(-4),d4
	addl d1,d4
	cmpl a3@(22),a0
	jge L1254
	movel d1,d3
	clrw d3
	swap d3
	movel a5@(-12),d7
	lsll d7,d3
	.even
L1260:
	movel d2,d0
	clrw d0
	swap d0
	movel a5@(-16),d1
	lsll d1,d0
	movel d3,d1
	orl d0,d1
	movel a1,d0
	clrw d0
	swap d0
	movel a5@(-20),d7
	lsll d7,d0
	orl d0,d1
	movel d1,a2@+
	addql #1,a0
	addl a6,a1
	subl a5@(-8),d2
	cmpl a3@(22),a0
	jlt L1260
L1254:
	movel d5,d3
	movel d4,d1
	cmpl a3@(26),d3
	jlt L1255
L1253:
	tstb a4@(3)
	jeq L1263
	movel a3@(22),d0
	mulsl a3@(26),d0
	movel d0,sp@-
	movel a3@(38),sp@-
	movel a3@(38),sp@-
	jbsr _swap32__3MemPvPCvUl
L1271:
L1263:
	clrl d0
	jra L1270
	.even
L1224:
	movel #-50659328,d0
L1270:
	moveml a5@(-64),#0x5cfc
	unlk a5
	rts
LC30:
	.ascii "Graphics Write Test %.2f ms\0"
LC31:
	.ascii "Unable to lock surface\0"
LC32:
	.ascii "Cancel\0"
LC33:
	.ascii "Error\0"
	.even
.globl _testWriteVRAM__10GfxTestApp
_testWriteVRAM__10GfxTestApp:
	pea a5@
	movel sp,a5
	fmovem #0x1c,sp@-
	moveml #0x3f3a,sp@-
	movel a5@(8),a2
	movel a2@(6),a0
	movel a0@,a1
	movel a0,sp@-
	movel a1@(40),a0
	jbsr a0@
	movel d0,a3
	addql #4,sp
	movel a3@(36),a0
	lea a0@(a0:l:2),a0
	movel a0,d0
	lsll #2,d0
	movel d0,a0
	addl #__15PixelDescriptor$propTab,a0
	clrl d5
	moveb a0@,d5
	movew a3@(2),d1
	extl d1
	movew a3@,a1
	movew a3@(32),a0
	movel a1,d0
	addl a0,d0
	mulsl d0,d1
	mulsl d1,d5
	clrl d6
	fmoved #0r0.000000000000005,fp4
	.even
L1281:
	fmoved fp4,sp@-
	pea LC30
	movel a2@(10),sp@-
	jbsr _sprintf
	movel a2@(6),a0
	movel a0@,a1
	movel a2@(10),sp@-
	movel a0,sp@-
	movel a1@(36),a0
	jbsr a0@
	movel a3,sp@-
	jbsr _lockData__7Surface
	movel d0,d4
	addw #28,sp
	jeq L1282
	fmoved #0r0.000000000000005,fp3
	movel #_set__3MemPviUl,d7
	lea _elapsedFrac__C10MilliClock,a6
	lea _unlockKernel__10GfxTestApp,a4
	fdmovel d5,fp2
	moveq #14,d2
	addl a2,d2
	clrl d3
	.even
L1285:
	movel a2,sp@-
	jbsr _lockKernel__10GfxTestApp
	movel d2,sp@
	jbsr _ReadEClock
	movel d5,sp@
	moveb d6,d3
	movel d3,sp@-
	movel d4,sp@-
	movel d7,a0
	jbsr a0@
	movel d2,sp@-
	jbsr a6@
	movel d1,sp@-
	movel d0,sp@-
	fdmoved sp@+,fp0
	fdaddx fp0,fp3
	movel a2,sp@-
	jbsr a4@
	addql #1,d6
	addw #20,sp
	fcmpd #0r50.00000000000005,fp3
	fjlt L1285
	fdaddx fp3,fp4
	movel a3,sp@-
	jbsr _unlockData__7Surface
	movel a2@(6),a0
	movel a0@,a1
	movel a0,sp@-
	movel a1@(28),a0
	jbsr a0@
	addql #8,sp
	jra L1279
	.even
L1282:
	pea LC31
	pea LC32
	pea LC33
	jbsr _dialogueBox__9SystemLibPCcN21e
	fdmovel d5,fp2
	jra L1280
	.even
L1279:
	fcmpd #0r2000.000000000004,fp4
	fjlt L1281
L1280:
	fdmuld #0r1000.000000000005,fp2
	fdmull d6,fp2
	fdmuld #0r1024.000000000005,fp4
	fddivx fp4,fp2
	fmoved fp2,sp@-
	movel sp@+,d0
	movel sp@+,d1
	moveml a5@(-76),#0x5cfc
	fmovem a5@(-36),#0x38
	unlk a5
	rts
LC34:
	.ascii "Graphics Write (memset) Test %.2f ms\0"
	.even
.globl _testCLibWriteVRAM__10GfxTestApp
_testCLibWriteVRAM__10GfxTestApp:
	pea a5@
	movel sp,a5
	fmovem #0x1c,sp@-
	moveml #0x3f3a,sp@-
	movel a5@(8),a2
	movel a2@(6),a0
	movel a0@,a1
	movel a0,sp@-
	movel a1@(40),a0
	jbsr a0@
	movel d0,a3
	addql #4,sp
	movel a3@(36),a0
	lea a0@(a0:l:2),a0
	movel a0,d0
	lsll #2,d0
	movel d0,a0
	addl #__15PixelDescriptor$propTab,a0
	clrl d4
	moveb a0@,d4
	movew a3@(2),d1
	extl d1
	movew a3@,a1
	movew a3@(32),a0
	movel a1,d0
	addl a0,d0
	mulsl d0,d1
	mulsl d1,d4
	clrl d5
	fmoved #0r0.000000000000005,fp4
	.even
L1300:
	fmoved fp4,sp@-
	pea LC34
	movel a2@(10),sp@-
	jbsr _sprintf
	movel a2@(6),a0
	movel a0@,a1
	movel a2@(10),sp@-
	movel a0,sp@-
	movel a1@(36),a0
	jbsr a0@
	movel a3,sp@-
	jbsr _lockData__7Surface
	movel d0,d3
	addw #28,sp
	jeq L1301
	fmoved #0r0.000000000000005,fp3
	movel #_lockKernel__10GfxTestApp,d7
	movel #_memset,d6
	lea _elapsedFrac__C10MilliClock,a6
	lea _unlockKernel__10GfxTestApp,a4
	fdmovel d4,fp2
	moveq #14,d2
	addl a2,d2
	.even
L1304:
	movel a2,sp@-
	movel d7,a0
	jbsr a0@
	movel d2,sp@
	jbsr _ReadEClock
	movel d4,sp@
	movel d5,sp@-
	movel d3,sp@-
	movel d6,a0
	jbsr a0@
	movel d2,sp@-
	jbsr a6@
	movel d1,sp@-
	movel d0,sp@-
	fdmoved sp@+,fp0
	fdaddx fp0,fp3
	movel a2,sp@-
	jbsr a4@
	addql #1,d5
	addw #20,sp
	fcmpd #0r50.00000000000005,fp3
	fjlt L1304
	fdaddx fp3,fp4
	movel a3,sp@-
	jbsr _unlockData__7Surface
	movel a2@(6),a0
	movel a0@,a1
	movel a0,sp@-
	movel a1@(28),a0
	jbsr a0@
	addql #8,sp
	jra L1298
	.even
L1301:
	pea LC31
	pea LC32
	pea LC33
	jbsr _dialogueBox__9SystemLibPCcN21e
	fdmovel d4,fp2
	jra L1299
	.even
L1298:
	fcmpd #0r2000.000000000004,fp4
	fjlt L1300
L1299:
	fdmuld #0r1000.000000000005,fp2
	fdmull d5,fp2
	fdmuld #0r1024.000000000005,fp4
	fddivx fp4,fp2
	fmoved fp2,sp@-
	movel sp@+,d0
	movel sp@+,d1
	moveml a5@(-76),#0x5cfc
	fmovem a5@(-36),#0x38
	unlk a5
	rts
LC35:
	.ascii "Graphics Write (move16) Test %.2f ms\0"
LC36:
	.ascii "Any glitches?\0"
LC37:
	.ascii "Yes|No\0"
LC38:
	.ascii "Info\0"
	.even
.globl _testWrite16VRAM__10GfxTestApp
_testWrite16VRAM__10GfxTestApp:
	pea a5@
	movel sp,a5
	fmovem #0x1c,sp@-
	moveml #0x3f3a,sp@-
	movel a5@(8),a2
	movel a2@(6),a0
	movel a0@,a1
	movel a0,sp@-
	movel a1@(40),a0
	jbsr a0@
	movel d0,a3
	addql #4,sp
	movel a3@(36),a0
	lea a0@(a0:l:2),a0
	movel a0,d0
	lsll #2,d0
	movel d0,a0
	addl #__15PixelDescriptor$propTab,a0
	clrl d5
	moveb a0@,d5
	movew a3@(2),d1
	extl d1
	movew a3@,a1
	movew a3@(32),a0
	movel a1,d0
	addl a0,d0
	mulsl d0,d1
	mulsl d1,d5
	clrl d6
	fmoved #0r0.000000000000005,fp4
	.even
L1319:
	fmoved fp4,sp@-
	pea LC35
	movel a2@(10),sp@-
	jbsr _sprintf
	movel a2@(6),a0
	movel a0@,a1
	movel a2@(10),sp@-
	movel a0,sp@-
	movel a1@(36),a0
	jbsr a0@
	movel a3,sp@-
	jbsr _lockData__7Surface
	movel d0,d4
	addw #28,sp
	jeq L1320
	fmoved #0r0.000000000000005,fp2
	movel #_setMem16__10GfxTestAppPvlUl,d7
	lea _elapsedFrac__C10MilliClock,a6
	lea _unlockKernel__10GfxTestApp,a4
	fdmovel d5,fp3
	moveq #14,d2
	addl a2,d2
	clrl d3
	.even
L1323:
	movel a2,sp@-
	jbsr _lockKernel__10GfxTestApp
	movel d2,sp@
	jbsr _ReadEClock
	movel d5,sp@
	moveb d6,d3
	movel d3,sp@-
	movel d4,sp@-
	movel d7,a0
	jbsr a0@
	movel d2,sp@-
	jbsr a6@
	movel d1,sp@-
	movel d0,sp@-
	fdmoved sp@+,fp0
	fdaddx fp0,fp2
	movel a2,sp@-
	jbsr a4@
	addql #1,d6
	addw #20,sp
	fcmpd #0r50.00000000000005,fp2
	fjlt L1323
	fdaddx fp2,fp4
	movel a3,sp@-
	jbsr _unlockData__7Surface
	movel a2@(6),a0
	movel a0@,a1
	movel a0,sp@-
	movel a1@(28),a0
	jbsr a0@
	addql #8,sp
	jra L1317
	.even
L1320:
	pea LC31
	pea LC32
	pea LC33
	jbsr _dialogueBox__9SystemLibPCcN21e
	addw #12,sp
	fdmovel d5,fp3
	jra L1318
	.even
L1317:
	fcmpd #0r2000.000000000004,fp4
	fjlt L1319
L1318:
	fdmovex fp3,fp2
	fdmuld #0r1000.000000000005,fp2
	fdmull d6,fp2
	fdmuld #0r1024.000000000005,fp4
	fddivx fp4,fp2
	pea LC36
	pea LC37
	pea LC38
	jbsr _dialogueBox__9SystemLibPCcN21e
	tstl d0
	jne L1328
	fmoved fp2,sp@-
	movel sp@+,d0
	movel sp@+,d1
	jra L1329
	.even
L1328:
	fmoved fp2,sp@-
	movel sp@+,d0
	movel sp@+,d1
	bchg #31,d0
L1329:
	moveml a5@(-76),#0x5cfc
	fmovem a5@(-36),#0x38
	unlk a5
	rts
LC39:
	.ascii "Graphics Read Test %.2f ms\0"
LC40:
	.ascii "Proceed\0"
	.even
.globl _testReadVRAM__10GfxTestApp
_testReadVRAM__10GfxTestApp:
	pea a5@
	movel sp,a5
	fmovem #0x1c,sp@-
	moveml #0x3f3a,sp@-
	movel a5@(8),a2
	movel a2@(6),a0
	movel a0@,a1
	movel a0,sp@-
	movel a1@(40),a0
	jbsr a0@
	movel d0,a3
	addql #4,sp
	movel a3@(36),a0
	lea a0@(a0:l:2),a0
	movel a0,d0
	lsll #2,d0
	movel d0,a0
	addl #__15PixelDescriptor$propTab,a0
	clrl d3
	moveb a0@,d3
	movew a3@(2),d1
	extl d1
	movew a3@,a1
	movew a3@(32),a0
	movel a1,d0
	addl a0,d0
	mulsl d0,d1
	mulsl d1,d3
	clrl d7
	fmoved #0r0.000000000000005,fp4
	.even
L1339:
	fmoved fp4,sp@-
	pea LC39
	movel a2@(10),sp@-
	jbsr _sprintf
	movel a2@(6),a0
	movel a0@,a1
	movel a2@(10),sp@-
	movel a0,sp@-
	movel a1@(36),a0
	jbsr a0@
	movel a3,sp@-
	jbsr _lockData__7Surface
	movel d0,d4
	addw #28,sp
	jeq L1340
	fmoved #0r0.000000000000005,fp3
	movel #_lockKernel__10GfxTestApp,d6
	movel #_readMem__10GfxTestAppPvUl,d5
	lea _elapsedFrac__C10MilliClock,a6
	lea _unlockKernel__10GfxTestApp,a4
	fdmovel d3,fp2
	moveq #14,d2
	addl a2,d2
	.even
L1343:
	movel a2,sp@-
	movel d6,a0
	jbsr a0@
	movel d2,sp@
	jbsr _ReadEClock
	movel d3,sp@
	movel d4,sp@-
	movel d5,a0
	jbsr a0@
	movel d2,sp@-
	jbsr a6@
	movel d1,sp@-
	movel d0,sp@-
	fdmoved sp@+,fp0
	fdaddx fp0,fp3
	movel a2,sp@-
	jbsr a4@
	addql #1,d7
	addw #16,sp
	fcmpd #0r50.00000000000005,fp3
	fjlt L1343
	fdaddx fp3,fp4
	movel a3,sp@-
	jbsr _unlockData__7Surface
	addql #4,sp
	jra L1337
	.even
L1340:
	pea LC31
	pea LC40
	pea LC33
	jbsr _dialogueBox__9SystemLibPCcN21e
	fdmovel d3,fp2
	jra L1338
	.even
L1337:
	fcmpd #0r2000.000000000004,fp4
	fjlt L1339
L1338:
	fdmuld #0r1000.000000000005,fp2
	fdmull d7,fp2
	fdmuld #0r1024.000000000005,fp4
	fddivx fp4,fp2
	fmoved fp2,sp@-
	movel sp@+,d0
	movel sp@+,d1
	moveml a5@(-76),#0x5cfc
	fmovem a5@(-36),#0x38
	unlk a5
	rts
LC41:
	.ascii "Copy RAM to VRAM Test %.2f ms\0"
	.even
.globl _testCopyRAM2VRAM__10GfxTestApp
_testCopyRAM2VRAM__10GfxTestApp:
	pea a5@
	movel sp,a5
	fmovem #0x1c,sp@-
	moveml #0x3f3a,sp@-
	movel a5@(8),a2
	movel a2@(6),a0
	movel a0@,a1
	movel a0,sp@-
	movel a1@(40),a0
	jbsr a0@
	movel d0,d7
	addql #4,sp
	movel d7,a1
	movel a1@(36),a0
	lea a0@(a0:l:2),a0
	movel a0,d0
	lsll #2,d0
	movel d0,a0
	addl #__15PixelDescriptor$propTab,a0
	clrl d4
	moveb a0@,d4
	movel a2@(22),d0
	mulsl a2@(26),d0
	mulsl d0,d4
	clrl d6
	fmoved #0r0.000000000000005,fp4
	.even
L1354:
	fmoved fp4,sp@-
	pea LC41
	movel a2@(10),sp@-
	jbsr _sprintf
	movel a2@(6),a0
	movel a0@,a1
	movel a2@(10),sp@-
	movel a0,sp@-
	movel a1@(36),a0
	jbsr a0@
	movel d7,sp@-
	jbsr _lockData__7Surface
	movel d0,d3
	addw #28,sp
	jeq L1355
	fmoved #0r0.000000000000005,fp2
	movel #_lockKernel__10GfxTestApp,d5
	lea _copy__3MemPvPCvUl,a6
	lea _elapsedFrac__C10MilliClock,a4
	lea _unlockKernel__10GfxTestApp,a3
	fdmovel d4,fp3
	moveq #14,d2
	addl a2,d2
	.even
L1358:
	movel a2,sp@-
	movel d5,a0
	jbsr a0@
	movel d2,sp@
	jbsr _ReadEClock
	movel d4,sp@
	movel a2@(38),sp@-
	movel d3,sp@-
	jbsr a6@
	movel d2,sp@-
	jbsr a4@
	movel d1,sp@-
	movel d0,sp@-
	fdmoved sp@+,fp0
	fdaddx fp0,fp2
	movel a2,sp@-
	jbsr a3@
	addql #1,d6
	addw #20,sp
	fcmpd #0r50.00000000000005,fp2
	fjlt L1358
	fdaddx fp2,fp4
	movel d7,sp@-
	jbsr _unlockData__7Surface
	addql #4,sp
	jra L1361
	.even
L1355:
	pea LC31
	pea LC40
	pea LC33
	jbsr _dialogueBox__9SystemLibPCcN21e
	fdmovel d4,fp3
	jra L1353
	.even
L1361:
	movel a2@(6),a0
	movel a0@,a1
	movel a0,sp@-
	movel a1@(28),a0
	jbsr a0@
	addql #4,sp
	fcmpd #0r2000.000000000004,fp4
	fjlt L1354
L1353:
	fdmuld #0r1000.000000000005,fp3
	fdmull d6,fp3
	fdmuld #0r1024.000000000005,fp4
	fddivx fp4,fp3
	fmoved fp3,sp@-
	movel sp@+,d0
	movel sp@+,d1
	moveml a5@(-76),#0x5cfc
	fmovem a5@(-36),#0x38
	unlk a5
	rts
LC42:
	.ascii "Copy RAM to VRAM (memcpy) Test %.2f ms\0"
	.even
.globl _testCLibCopyRAM2VRAM__10GfxTestApp
_testCLibCopyRAM2VRAM__10GfxTestApp:
	pea a5@
	movel sp,a5
	fmovem #0x1c,sp@-
	moveml #0x3f3a,sp@-
	movel a5@(8),a2
	movel a2@(6),a0
	movel a0@,a1
	movel a0,sp@-
	movel a1@(40),a0
	jbsr a0@
	movel d0,d7
	addql #4,sp
	movel d7,a1
	movel a1@(36),a0
	lea a0@(a0:l:2),a0
	movel a0,d0
	lsll #2,d0
	movel d0,a0
	addl #__15PixelDescriptor$propTab,a0
	clrl d4
	moveb a0@,d4
	movel a2@(22),d0
	mulsl a2@(26),d0
	mulsl d0,d4
	clrl d6
	fmoved #0r0.000000000000005,fp4
	.even
L1369:
	fmoved fp4,sp@-
	pea LC42
	movel a2@(10),sp@-
	jbsr _sprintf
	movel a2@(6),a0
	movel a0@,a1
	movel a2@(10),sp@-
	movel a0,sp@-
	movel a1@(36),a0
	jbsr a0@
	movel d7,sp@-
	jbsr _lockData__7Surface
	movel d0,d3
	addw #28,sp
	jeq L1370
	fmoved #0r0.000000000000005,fp2
	movel #_lockKernel__10GfxTestApp,d5
	lea _memcpy,a6
	lea _elapsedFrac__C10MilliClock,a4
	lea _unlockKernel__10GfxTestApp,a3
	fdmovel d4,fp3
	moveq #14,d2
	addl a2,d2
	.even
L1373:
	movel a2,sp@-
	movel d5,a0
	jbsr a0@
	movel d2,sp@
	jbsr _ReadEClock
	movel d4,sp@
	movel a2@(38),sp@-
	movel d3,sp@-
	jbsr a6@
	movel d2,sp@-
	jbsr a4@
	movel d1,sp@-
	movel d0,sp@-
	fdmoved sp@+,fp0
	fdaddx fp0,fp2
	movel a2,sp@-
	jbsr a3@
	addql #1,d6
	addw #20,sp
	fcmpd #0r50.00000000000005,fp2
	fjlt L1373
	fdaddx fp2,fp4
	movel d7,sp@-
	jbsr _unlockData__7Surface
	addql #4,sp
	jra L1376
	.even
L1370:
	pea LC31
	pea LC40
	pea LC33
	jbsr _dialogueBox__9SystemLibPCcN21e
	fdmovel d4,fp3
	jra L1368
	.even
L1376:
	movel a2@(6),a0
	movel a0@,a1
	movel a0,sp@-
	movel a1@(28),a0
	jbsr a0@
	addql #4,sp
	fcmpd #0r2000.000000000004,fp4
	fjlt L1369
L1368:
	fdmuld #0r1000.000000000005,fp3
	fdmull d6,fp3
	fdmuld #0r1024.000000000005,fp4
	fddivx fp4,fp3
	fmoved fp3,sp@-
	movel sp@+,d0
	movel sp@+,d1
	moveml a5@(-76),#0x5cfc
	fmovem a5@(-36),#0x38
	unlk a5
	rts
LC43:
	.ascii "Copy RAM to VRAM (move16) Test %.2f ms\0"
	.even
.globl _testCopy16RAM2VRAM__10GfxTestApp
_testCopy16RAM2VRAM__10GfxTestApp:
	pea a5@
	movel sp,a5
	fmovem #0x1c,sp@-
	moveml #0x3f3a,sp@-
	movel a5@(8),a2
	tstb a2@(50)
	jne L1379
	clrl d0
	clrl d1
	jra L1394
	.even
L1379:
	movel a2@(6),a0
	movel a0@,a1
	movel a0,sp@-
	movel a1@(40),a0
	jbsr a0@
	movel d0,d7
	addql #4,sp
	movel d7,a1
	movel a1@(36),a0
	lea a0@(a0:l:2),a0
	movel a0,d0
	lsll #2,d0
	movel d0,a0
	addl #__15PixelDescriptor$propTab,a0
	clrl d4
	moveb a0@,d4
	movel a2@(22),d0
	mulsl a2@(26),d0
	mulsl d0,d4
	clrl d6
	fmoved #0r0.000000000000005,fp4
	.even
L1385:
	fmoved fp4,sp@-
	pea LC43
	movel a2@(10),sp@-
	jbsr _sprintf
	movel a2@(6),a0
	movel a0@,a1
	movel a2@(10),sp@-
	movel a0,sp@-
	movel a1@(36),a0
	jbsr a0@
	movel d7,sp@-
	jbsr _lockData__7Surface
	movel d0,d3
	addw #28,sp
	jeq L1386
	fmoved #0r0.000000000000005,fp2
	movel #_lockKernel__10GfxTestApp,d5
	lea _copyMem16__10GfxTestAppPvT1Ul,a6
	lea _elapsedFrac__C10MilliClock,a4
	lea _unlockKernel__10GfxTestApp,a3
	fdmovel d4,fp3
	moveq #14,d2
	addl a2,d2
	.even
L1389:
	movel a2,sp@-
	movel d5,a0
	jbsr a0@
	movel d2,sp@
	jbsr _ReadEClock
	movel d4,sp@
	movel a2@(38),sp@-
	movel d3,sp@-
	jbsr a6@
	movel d2,sp@-
	jbsr a4@
	movel d1,sp@-
	movel d0,sp@-
	fdmoved sp@+,fp0
	fdaddx fp0,fp2
	movel a2,sp@-
	jbsr a3@
	addql #1,d6
	addw #20,sp
	fcmpd #0r50.00000000000005,fp2
	fjlt L1389
	fdaddx fp2,fp4
	movel d7,sp@-
	jbsr _unlockData__7Surface
	addql #4,sp
	jra L1392
	.even
L1386:
	pea LC31
	pea LC40
	pea LC33
	jbsr _dialogueBox__9SystemLibPCcN21e
	fdmovel d4,fp3
	jra L1384
	.even
L1392:
	movel a2@(6),a0
	movel a0@,a1
	movel a0,sp@-
	movel a1@(28),a0
	jbsr a0@
	addql #4,sp
	fcmpd #0r2000.000000000004,fp4
	fjlt L1385
L1384:
	fdmuld #0r1000.000000000005,fp3
	fdmull d6,fp3
	fdmuld #0r1024.000000000005,fp4
	fddivx fp4,fp3
	fmoved fp3,sp@-
	movel sp@+,d0
	movel sp@+,d1
L1394:
	moveml a5@(-76),#0x5cfc
	fmovem a5@(-36),#0x38
	unlk a5
	rts
LC44:
	.ascii "Shuffle RAM to VRAM (move16 : src offset %ld) Test %.2f ms\0"
	.even
.globl _testShuffleCopy16RAM2VRAM__10GfxTestAppl
_testShuffleCopy16RAM2VRAM__10GfxTestAppl:
	link a5,#-8
	fmovem #0x1c,sp@-
	moveml #0x3f3a,sp@-
	movel a5@(8),a2
	tstb a2@(50)
	jne L1396
	clrl d0
	clrl d1
	jra L1412
	.even
L1396:
	movel a2@(6),a0
	movel a0@,a1
	movel a0,sp@-
	movel a1@(40),a0
	jbsr a0@
	movel d0,a5@(-4)
	addql #4,sp
	movel d0,a1
	movel a1@(36),a0
	lea a0@(a0:l:2),a0
	movel a0,d0
	lsll #2,d0
	movel d0,a0
	addl #__15PixelDescriptor$propTab,a0
	clrl d3
	moveb a0@,d3
	movel a2@(22),d0
	mulsl a2@(26),d0
	mulsl d0,d3
	subl a5@(12),d3
	movel a5@(12),d0
	addl a2@(38),d0
	movel d0,a5@(-8)
	clrl d6
	fmoved #0r0.000000000000005,fp4
	.even
L1402:
	fmoved fp4,sp@-
	movel a5@(12),sp@-
	pea LC44
	movel a2@(10),sp@-
	jbsr _sprintf
	movel a2@(6),a0
	movel a0@,a1
	movel a2@(10),sp@-
	movel a0,sp@-
	movel a1@(36),a0
	jbsr a0@
	movel a5@(-4),sp@-
	jbsr _lockData__7Surface
	movel d0,d4
	addw #32,sp
	jeq L1403
	fmoved #0r0.000000000000005,fp2
	movel #_lockKernel__10GfxTestApp,d5
	lea _shuffleCopy16__10GfxTestAppPvT1Ul,a6
	lea _elapsedFrac__C10MilliClock,a4
	lea _unlockKernel__10GfxTestApp,a3
	movel #_unlockData__7Surface,d7
	fdmovel d3,fp3
	moveq #14,d2
	addl a2,d2
	.even
L1406:
	movel a2,sp@-
	movel d5,a0
	jbsr a0@
	movel d2,sp@
	jbsr _ReadEClock
	movel d3,sp@
	movel a5@(-8),sp@-
	movel d4,sp@-
	jbsr a6@
	movel d2,sp@-
	jbsr a4@
	movel d1,sp@-
	movel d0,sp@-
	fdmoved sp@+,fp0
	fdaddx fp0,fp2
	movel a2,sp@-
	jbsr a3@
	addql #1,d6
	addw #20,sp
	fcmpd #0r50.00000000000005,fp2
	fjlt L1406
	fdaddx fp2,fp4
	movel a5@(-4),sp@-
	movel d7,a0
	jbsr a0@
	addql #4,sp
	jra L1409
	.even
L1403:
	pea LC31
	pea LC40
	pea LC33
	jbsr _dialogueBox__9SystemLibPCcN21e
	addw #12,sp
	fdmovel d3,fp3
	jra L1401
	.even
L1409:
	movel a2@(6),a0
	movel a0@,a1
	movel a0,sp@-
	movel a1@(28),a0
	jbsr a0@
	addql #4,sp
	fcmpd #0r2000.000000000004,fp4
	fjlt L1402
L1401:
	fdmovex fp3,fp2
	fdmuld #0r1000.000000000005,fp2
	fdmull d6,fp2
	fdmuld #0r1024.000000000005,fp4
	fddivx fp4,fp2
	pea LC36
	pea LC37
	pea LC38
	jbsr _dialogueBox__9SystemLibPCcN21e
	tstl d0
	jne L1411
	fmoved fp2,sp@-
	movel sp@+,d0
	movel sp@+,d1
	jra L1412
	.even
L1411:
	fmoved fp2,sp@-
	movel sp@+,d0
	movel sp@+,d1
	bchg #31,d0
L1412:
	moveml a5@(-84),#0x5cfc
	fmovem a5@(-44),#0x38
	unlk a5
	rts
LC45:
	.ascii "Shuffle RAM to RAM (move16 : src offset %ld) Test %.2f ms\0"
	.even
.globl _testShuffleCopy16RAM2RAM__10GfxTestAppl
_testShuffleCopy16RAM2RAM__10GfxTestAppl:
	pea a5@
	movel sp,a5
	fmovem #0x4,sp@-
	moveml #0x3f3a,sp@-
	movel a5@(8),a2
	movel a5@(12),d5
	tstb a2@(50)
	jne L1414
	clrl d0
	clrl d1
	jra L1420
	.even
L1414:
	movel a2@(38),d6
	addl d5,d6
	clrl d4
	movel a2@(46),d3
	subl d5,d3
	fmoved #0r0.000000000000005,fp2
	movel #_lockKernel__10GfxTestApp,d7
	lea _shuffleCopy16__10GfxTestAppPvT1Ul,a6
	lea _elapsedFrac__C10MilliClock,a4
	lea _unlockKernel__10GfxTestApp,a3
	moveq #14,d2
	addl a2,d2
	.even
L1417:
	fmoved fp2,sp@-
	movel d5,sp@-
	pea LC45
	movel a2@(10),sp@-
	jbsr _sprintf
	movel a2@(6),a0
	movel a0@,a1
	movel a2@(10),sp@-
	movel a0,sp@-
	movel a1@(36),a0
	jbsr a0@
	movel a2,sp@-
	movel d7,a0
	jbsr a0@
	addw #28,sp
	movel d2,sp@
	jbsr _ReadEClock
	movel d3,sp@
	movel d6,sp@-
	movel a2@(42),sp@-
	jbsr a6@
	movel d2,sp@-
	jbsr a4@
	movel d1,sp@-
	movel d0,sp@-
	fdmoved sp@+,fp0
	fdaddx fp0,fp2
	movel a2,sp@-
	jbsr a3@
	addql #1,d4
	addw #20,sp
	fcmpd #0r2000.000000000004,fp2
	fjlt L1417
	fmoved #0r1000.000000000005,fp0
	fdmull d3,fp0
	fdmull d4,fp0
	fdmuld #0r1024.000000000005,fp2
	fddivx fp2,fp0
	fmoved fp0,sp@-
	movel sp@+,d0
	movel sp@+,d1
L1420:
	moveml a5@(-52),#0x5cfc
	fmovem a5@(-12),#0x20
	unlk a5
	rts
LC46:
	.ascii "Shuffle RAM to VRAM (CopyMem : src offset %ld) Test %.2f ms\0"
	.even
.globl _testOSCopyMemRAM2VRAM__10GfxTestAppl
_testOSCopyMemRAM2VRAM__10GfxTestAppl:
	link a5,#-8
	fmovem #0x1c,sp@-
	moveml #0x3f3a,sp@-
	movel a5@(8),a2
	movel a2@(6),a0
	movel a0@,a1
	movel a0,sp@-
	movel a1@(40),a0
	jbsr a0@
	movel d0,a5@(-4)
	addql #4,sp
	movel d0,a1
	movel a1@(36),a0
	lea a0@(a0:l:2),a0
	movel a0,d0
	lsll #2,d0
	movel d0,a0
	addl #__15PixelDescriptor$propTab,a0
	clrl d3
	moveb a0@,d3
	movel a2@(22),d0
	mulsl a2@(26),d0
	mulsl d0,d3
	subl a5@(12),d3
	movel a5@(12),d0
	addl a2@(38),d0
	movel d0,a5@(-8)
	clrl d6
	fmoved #0r0.000000000000005,fp4
	.even
L1427:
	fmoved fp4,sp@-
	movel a5@(12),sp@-
	pea LC46
	movel a2@(10),sp@-
	jbsr _sprintf
	movel a2@(6),a0
	movel a0@,a1
	movel a2@(10),sp@-
	movel a0,sp@-
	movel a1@(36),a0
	jbsr a0@
	movel a5@(-4),sp@-
	jbsr _lockData__7Surface
	movel d0,d4
	addw #32,sp
	jeq L1428
	fmoved #0r0.000000000000005,fp2
	movel #_lockKernel__10GfxTestApp,d5
	lea _CopyMem,a6
	lea _elapsedFrac__C10MilliClock,a4
	lea _unlockKernel__10GfxTestApp,a3
	movel #_unlockData__7Surface,d7
	fdmovel d3,fp3
	moveq #14,d2
	addl a2,d2
	.even
L1431:
	movel a2,sp@-
	movel d5,a0
	jbsr a0@
	movel d2,sp@
	jbsr _ReadEClock
	movel d3,sp@
	movel d4,sp@-
	movel a5@(-8),sp@-
	jbsr a6@
	movel d2,sp@-
	jbsr a4@
	movel d1,sp@-
	movel d0,sp@-
	fdmoved sp@+,fp0
	fdaddx fp0,fp2
	movel a2,sp@-
	jbsr a3@
	addql #1,d6
	addw #20,sp
	fcmpd #0r50.00000000000005,fp2
	fjlt L1431
	fdaddx fp2,fp4
	movel a5@(-4),sp@-
	movel d7,a0
	jbsr a0@
	addql #4,sp
	jra L1434
	.even
L1428:
	pea LC31
	pea LC40
	pea LC33
	jbsr _dialogueBox__9SystemLibPCcN21e
	addw #12,sp
	fdmovel d3,fp3
	jra L1426
	.even
L1434:
	movel a2@(6),a0
	movel a0@,a1
	movel a0,sp@-
	movel a1@(28),a0
	jbsr a0@
	addql #4,sp
	fcmpd #0r2000.000000000004,fp4
	fjlt L1427
L1426:
	fdmovex fp3,fp2
	fdmuld #0r1000.000000000005,fp2
	fdmull d6,fp2
	fdmuld #0r1024.000000000005,fp4
	fddivx fp4,fp2
	pea LC36
	pea LC37
	pea LC38
	jbsr _dialogueBox__9SystemLibPCcN21e
	tstl d0
	jne L1436
	fmoved fp2,sp@-
	movel sp@+,d0
	movel sp@+,d1
	jra L1437
	.even
L1436:
	fmoved fp2,sp@-
	movel sp@+,d0
	movel sp@+,d1
	bchg #31,d0
L1437:
	moveml a5@(-84),#0x5cfc
	fmovem a5@(-44),#0x38
	unlk a5
	rts
LC47:
	.ascii "Shuffle RAM to RAM (CopyMem : src offset %ld) Test %.2f ms\0"
	.even
.globl _testOSCopyMemRAM2RAM__10GfxTestAppl
_testOSCopyMemRAM2RAM__10GfxTestAppl:
	pea a5@
	movel sp,a5
	fmovem #0x4,sp@-
	moveml #0x3f3a,sp@-
	movel a5@(8),a2
	movel a5@(12),d5
	movel a2@(38),d6
	addl d5,d6
	clrl d4
	movel a2@(46),d3
	subl d5,d3
	fmoved #0r0.000000000000005,fp2
	movel #_lockKernel__10GfxTestApp,d7
	lea _CopyMem,a6
	lea _elapsedFrac__C10MilliClock,a4
	lea _unlockKernel__10GfxTestApp,a3
	moveq #14,d2
	addl a2,d2
	.even
L1441:
	fmoved fp2,sp@-
	movel d5,sp@-
	pea LC47
	movel a2@(10),sp@-
	jbsr _sprintf
	movel a2@(6),a0
	movel a0@,a1
	movel a2@(10),sp@-
	movel a0,sp@-
	movel a1@(36),a0
	jbsr a0@
	movel a2,sp@-
	movel d7,a0
	jbsr a0@
	addw #28,sp
	movel d2,sp@
	jbsr _ReadEClock
	movel d3,sp@
	movel d6,sp@-
	movel a2@(42),sp@-
	jbsr a6@
	movel d2,sp@-
	jbsr a4@
	movel d1,sp@-
	movel d0,sp@-
	fdmoved sp@+,fp0
	fdaddx fp0,fp2
	movel a2,sp@-
	jbsr a3@
	addql #1,d4
	addw #20,sp
	fcmpd #0r2000.000000000004,fp2
	fjlt L1441
	fmoved #0r1000.000000000005,fp0
	fdmull d3,fp0
	fdmull d4,fp0
	fdmuld #0r1024.000000000005,fp2
	fddivx fp2,fp0
	fmoved fp0,sp@-
	movel sp@+,d0
	movel sp@+,d1
	moveml a5@(-52),#0x5cfc
	fmovem a5@(-12),#0x20
	unlk a5
	rts
LC48:
	.ascii "Copy VRAM to RAM Test %.2f ms\0"
	.even
.globl _testCopyVRAM2RAM__10GfxTestApp
_testCopyVRAM2RAM__10GfxTestApp:
	link a5,#-4
	fmovem #0x1c,sp@-
	moveml #0x3f3a,sp@-
	movel a5@(8),a2
	movel a2@(6),a0
	movel a0@,a1
	movel a0,sp@-
	movel a1@(40),a0
	jbsr a0@
	movel d0,a3
	addql #4,sp
	movel a3@(36),a0
	lea a0@(a0:l:2),a0
	movel a0,d0
	lsll #2,d0
	movel d0,a0
	addl #__15PixelDescriptor$propTab,a0
	clrl d4
	moveb a0@,d4
	movew a3@(2),d1
	extl d1
	movew a3@,a1
	movew a3@(32),a0
	movel a1,d0
	addl a0,d0
	mulsl d0,d1
	mulsl d1,d4
	clrl a5@(-4)
	fmoved #0r0.000000000000005,fp4
	pea 16:w
	subql #2,sp
	moveb #0,sp@(1)
	subql #2,sp
	movel d4,sp@-
	jbsr _alloc__3MemUlbQ23Mem9AlignType
	movel d0,d6
	addw #12,sp
	jeq L1451
	.even
L1454:
	fmoved fp4,sp@-
	pea LC48
	movel a2@(10),sp@-
	jbsr _sprintf
	movel a2@(6),a0
	movel a0@,a1
	movel a2@(10),sp@-
	movel a0,sp@-
	movel a1@(36),a0
	jbsr a0@
	movel a3,sp@-
	jbsr _lockData__7Surface
	movel d0,d3
	addw #28,sp
	jeq L1455
	fmoved #0r0.000000000000005,fp3
	movel #_lockKernel__10GfxTestApp,d7
	movel #_copy__3MemPvPCvUl,d5
	lea _elapsedFrac__C10MilliClock,a6
	lea _unlockKernel__10GfxTestApp,a4
	fdmovel d4,fp2
	moveq #14,d2
	addl a2,d2
	.even
L1458:
	movel a2,sp@-
	movel d7,a0
	jbsr a0@
	movel d2,sp@
	jbsr _ReadEClock
	movel d4,sp@
	movel d3,sp@-
	movel d6,sp@-
	movel d5,a0
	jbsr a0@
	movel d2,sp@-
	jbsr a6@
	movel d1,sp@-
	movel d0,sp@-
	fdmoved sp@+,fp0
	fdaddx fp0,fp3
	movel a2,sp@-
	jbsr a4@
	addql #1,a5@(-4)
	addw #20,sp
	fcmpd #0r50.00000000000005,fp3
	fjlt L1458
	fdaddx fp3,fp4
	movel a3,sp@-
	jbsr _unlockData__7Surface
	addql #4,sp
	jra L1452
	.even
L1455:
	pea LC31
	pea LC40
	pea LC33
	jbsr _dialogueBox__9SystemLibPCcN21e
	addw #12,sp
	fdmovel d4,fp2
	jra L1453
	.even
L1452:
	fcmpd #0r2000.000000000004,fp4
	fjlt L1454
L1453:
	movel d6,sp@-
	jbsr _free__3MemPv
	fdmuld #0r1000.000000000005,fp2
	fdmull a5@(-4),fp2
	fdmuld #0r1024.000000000005,fp4
	fddivx fp4,fp2
	fmoved fp2,sp@-
	movel sp@+,d0
	movel sp@+,d1
	jra L1463
	.even
L1451:
	fmoved fp4,sp@-
	movel sp@+,d0
	movel sp@+,d1
L1463:
	moveml a5@(-80),#0x5cfc
	fmovem a5@(-40),#0x38
	unlk a5
	rts
LC49:
	.ascii "Copy VRAM to RAM (move16) Test %.2f ms\0"
	.even
.globl _testCopy16VRAM2RAM__10GfxTestApp
_testCopy16VRAM2RAM__10GfxTestApp:
	link a5,#-4
	fmovem #0x1c,sp@-
	moveml #0x3f3a,sp@-
	movel a5@(8),a2
	tstb a2@(50)
	jeq L1472
	movel a2@(6),a0
	movel a0@,a1
	movel a0,sp@-
	movel a1@(40),a0
	jbsr a0@
	movel d0,a3
	addql #4,sp
	movel a3@(36),a0
	lea a0@(a0:l:2),a0
	movel a0,d0
	lsll #2,d0
	movel d0,a0
	addl #__15PixelDescriptor$propTab,a0
	clrl d4
	moveb a0@,d4
	movew a3@(2),d1
	extl d1
	movew a3@,a1
	movew a3@(32),a0
	movel a1,d0
	addl a0,d0
	mulsl d0,d1
	mulsl d1,d4
	clrl a5@(-4)
	fmoved #0r0.000000000000005,fp4
	pea 16:w
	subql #2,sp
	moveb #0,sp@(1)
	subql #2,sp
	movel d4,sp@-
	jbsr _alloc__3MemUlbQ23Mem9AlignType
	movel d0,d6
	addw #12,sp
	jeq L1472
	.even
L1475:
	fmoved fp4,sp@-
	pea LC49
	movel a2@(10),sp@-
	jbsr _sprintf
	movel a2@(6),a0
	movel a0@,a1
	movel a2@(10),sp@-
	movel a0,sp@-
	movel a1@(36),a0
	jbsr a0@
	movel a3,sp@-
	jbsr _lockData__7Surface
	movel d0,d3
	addw #28,sp
	jeq L1476
	fmoved #0r0.000000000000005,fp3
	movel #_lockKernel__10GfxTestApp,d7
	movel #_copyMem16__10GfxTestAppPvT1Ul,d5
	lea _elapsedFrac__C10MilliClock,a6
	lea _unlockKernel__10GfxTestApp,a4
	fdmovel d4,fp2
	moveq #14,d2
	addl a2,d2
	.even
L1479:
	movel a2,sp@-
	movel d7,a0
	jbsr a0@
	movel d2,sp@
	jbsr _ReadEClock
	movel d4,sp@
	movel d3,sp@-
	movel d6,sp@-
	movel d5,a0
	jbsr a0@
	movel d2,sp@-
	jbsr a6@
	movel d1,sp@-
	movel d0,sp@-
	fdmoved sp@+,fp0
	fdaddx fp0,fp3
	movel a2,sp@-
	jbsr a4@
	addql #1,a5@(-4)
	addw #20,sp
	fcmpd #0r50.00000000000005,fp3
	fjlt L1479
	fdaddx fp3,fp4
	movel a3,sp@-
	jbsr _unlockData__7Surface
	addql #4,sp
	jra L1473
	.even
L1476:
	pea LC31
	pea LC40
	pea LC33
	jbsr _dialogueBox__9SystemLibPCcN21e
	addw #12,sp
	fdmovel d4,fp2
	jra L1474
	.even
L1473:
	fcmpd #0r2000.000000000004,fp4
	fjlt L1475
L1474:
	movel d6,sp@-
	jbsr _free__3MemPv
	fdmuld #0r1000.000000000005,fp2
	fdmull a5@(-4),fp2
	fdmuld #0r1024.000000000005,fp4
	fddivx fp4,fp2
	fmoved fp2,sp@-
	movel sp@+,d0
	movel sp@+,d1
	jra L1484
	.even
L1472:
	clrl d0
	clrl d1
L1484:
	moveml a5@(-80),#0x5cfc
	fmovem a5@(-40),#0x38
	unlk a5
	rts
LC50:
	.ascii "Copy RAM to RAM Test %.2f ms\0"
	.even
.globl _testCopyRAM2RAM__10GfxTestApp
_testCopyRAM2RAM__10GfxTestApp:
	pea a5@
	movel sp,a5
	fmovem #0x4,sp@-
	moveml #0x3c3a,sp@-
	movel a5@(8),a2
	clrl d3
	fmoved #0r0.000000000000005,fp2
	movel #_sprintf,d5
	movel #_lockKernel__10GfxTestApp,d4
	lea _copy__3MemPvPCvUl,a6
	lea _elapsedFrac__C10MilliClock,a4
	lea _unlockKernel__10GfxTestApp,a3
	moveq #14,d2
	addl a2,d2
	.even
L1488:
	fmoved fp2,sp@-
	pea LC50
	movel a2@(10),sp@-
	movel d5,a0
	jbsr a0@
	movel a2@(6),a0
	movel a0@,a1
	movel a2@(10),sp@-
	movel a0,sp@-
	movel a1@(36),a0
	jbsr a0@
	movel a2,sp@-
	movel d4,a0
	jbsr a0@
	addw #24,sp
	movel d2,sp@
	jbsr _ReadEClock
	movel a2@(46),sp@
	movel a2@(38),sp@-
	movel a2@(42),sp@-
	jbsr a6@
	movel d2,sp@-
	jbsr a4@
	movel d1,sp@-
	movel d0,sp@-
	fdmoved sp@+,fp0
	fdaddx fp0,fp2
	movel a2,sp@-
	jbsr a3@
	addql #1,d3
	addw #20,sp
	fcmpd #0r2000.000000000004,fp2
	fjlt L1488
	movel a2@(46),d0
	fdmovel d0,fp0
	tstl d0
	jge L1491
	fdaddd #0r4294967296.000005,fp0
L1491:
	fdmuld #0r1000.000000000005,fp0
	fdmull d3,fp0
	fdmuld #0r1024.000000000005,fp2
	fddivx fp2,fp0
	fmoved fp0,sp@-
	movel sp@+,d0
	movel sp@+,d1
	moveml a5@(-44),#0x5c3c
	fmovem a5@(-12),#0x20
	unlk a5
	rts
LC51:
	.ascii "Copy RAM to RAM (move16) Test %.2f ms\0"
	.even
.globl _testCopy16RAM2RAM__10GfxTestApp
_testCopy16RAM2RAM__10GfxTestApp:
	pea a5@
	movel sp,a5
	fmovem #0x4,sp@-
	moveml #0x3c3a,sp@-
	movel a5@(8),a2
	tstb a2@(50)
	jne L1493
	clrl d0
	clrl d1
	jra L1500
	.even
L1493:
	clrl d3
	fmoved #0r0.000000000000005,fp2
	movel #_sprintf,d5
	movel #_lockKernel__10GfxTestApp,d4
	lea _copyMem16__10GfxTestAppPvT1Ul,a6
	lea _elapsedFrac__C10MilliClock,a4
	lea _unlockKernel__10GfxTestApp,a3
	moveq #14,d2
	addl a2,d2
	.even
L1496:
	fmoved fp2,sp@-
	pea LC51
	movel a2@(10),sp@-
	movel d5,a0
	jbsr a0@
	movel a2@(6),a0
	movel a0@,a1
	movel a2@(10),sp@-
	movel a0,sp@-
	movel a1@(36),a0
	jbsr a0@
	movel a2,sp@-
	movel d4,a0
	jbsr a0@
	addw #24,sp
	movel d2,sp@
	jbsr _ReadEClock
	movel a2@(46),sp@
	movel a2@(38),sp@-
	movel a2@(42),sp@-
	jbsr a6@
	movel d2,sp@-
	jbsr a4@
	movel d1,sp@-
	movel d0,sp@-
	fdmoved sp@+,fp0
	fdaddx fp0,fp2
	movel a2,sp@-
	jbsr a3@
	addql #1,d3
	addw #20,sp
	fcmpd #0r2000.000000000004,fp2
	fjlt L1496
	movel a2@(46),d0
	fdmovel d0,fp0
	tstl d0
	jge L1499
	fdaddd #0r4294967296.000005,fp0
L1499:
	fdmuld #0r1000.000000000005,fp0
	fdmull d3,fp0
	fdmuld #0r1024.000000000005,fp2
	fddivx fp2,fp0
	fmoved fp0,sp@-
	movel sp@+,d0
	movel sp@+,d1
L1500:
	moveml a5@(-44),#0x5c3c
	fmovem a5@(-12),#0x20
	unlk a5
	rts
LC52:
	.ascii "Copy RAM to RAM (memcpy) Test %.2f ms\0"
	.even
.globl _testCLibCopyRAM2RAM__10GfxTestApp
_testCLibCopyRAM2RAM__10GfxTestApp:
	pea a5@
	movel sp,a5
	fmovem #0x4,sp@-
	moveml #0x3c3a,sp@-
	movel a5@(8),a2
	clrl d3
	fmoved #0r0.000000000000005,fp2
	movel #_sprintf,d5
	movel #_lockKernel__10GfxTestApp,d4
	lea _memcpy,a6
	lea _elapsedFrac__C10MilliClock,a4
	lea _unlockKernel__10GfxTestApp,a3
	moveq #14,d2
	addl a2,d2
	.even
L1504:
	fmoved fp2,sp@-
	pea LC52
	movel a2@(10),sp@-
	movel d5,a0
	jbsr a0@
	movel a2@(6),a0
	movel a0@,a1
	movel a2@(10),sp@-
	movel a0,sp@-
	movel a1@(36),a0
	jbsr a0@
	movel a2,sp@-
	movel d4,a0
	jbsr a0@
	addw #24,sp
	movel d2,sp@
	jbsr _ReadEClock
	movel a2@(46),sp@
	movel a2@(38),sp@-
	movel a2@(42),sp@-
	jbsr a6@
	movel d2,sp@-
	jbsr a4@
	movel d1,sp@-
	movel d0,sp@-
	fdmoved sp@+,fp0
	fdaddx fp0,fp2
	movel a2,sp@-
	jbsr a3@
	addql #1,d3
	addw #20,sp
	fcmpd #0r2000.000000000004,fp2
	fjlt L1504
	movel a2@(46),d0
	fdmovel d0,fp0
	tstl d0
	jge L1507
	fdaddd #0r4294967296.000005,fp0
L1507:
	fdmuld #0r1000.000000000005,fp0
	fdmull d3,fp0
	fdmuld #0r1024.000000000005,fp2
	fddivx fp2,fp0
	fmoved fp0,sp@-
	movel sp@+,d0
	movel sp@+,d1
	moveml a5@(-44),#0x5c3c
	fmovem a5@(-12),#0x20
	unlk a5
	rts
LC53:
	.ascii "RAM Write Test %.2f ms\0"
	.even
.globl _testWriteRAM__10GfxTestApp
_testWriteRAM__10GfxTestApp:
	pea a5@
	movel sp,a5
	fmovem #0x4,sp@-
	moveml #0x3e3a,sp@-
	movel a5@(8),a2
	clrl d3
	fmoved #0r0.000000000000005,fp2
	movel #_sprintf,d6
	movel #_lockKernel__10GfxTestApp,d5
	lea _set__3MemPviUl,a6
	lea _elapsedFrac__C10MilliClock,a4
	lea _unlockKernel__10GfxTestApp,a3
	moveq #14,d2
	addl a2,d2
	clrl d4
	.even
L1511:
	fmoved fp2,sp@-
	pea LC53
	movel a2@(10),sp@-
	movel d6,a0
	jbsr a0@
	movel a2@(6),a0
	movel a0@,a1
	movel a2@(10),sp@-
	movel a0,sp@-
	movel a1@(36),a0
	jbsr a0@
	movel a2,sp@-
	movel d5,a0
	jbsr a0@
	addw #24,sp
	movel d2,sp@
	jbsr _ReadEClock
	movel a2@(46),sp@
	moveb d3,d4
	movel d4,sp@-
	movel a2@(38),sp@-
	jbsr a6@
	movel d2,sp@-
	jbsr a4@
	movel d1,sp@-
	movel d0,sp@-
	fdmoved sp@+,fp0
	fdaddx fp0,fp2
	movel a2,sp@-
	jbsr a3@
	addql #1,d3
	addw #20,sp
	fcmpd #0r2000.000000000004,fp2
	fjlt L1511
	movel a2@(46),d0
	fdmovel d0,fp0
	tstl d0
	jge L1514
	fdaddd #0r4294967296.000005,fp0
L1514:
	fdmuld #0r1000.000000000005,fp0
	fdmull d3,fp0
	fdmuld #0r1024.000000000005,fp2
	fddivx fp2,fp0
	fmoved fp0,sp@-
	movel sp@+,d0
	movel sp@+,d1
	moveml a5@(-48),#0x5c7c
	fmovem a5@(-12),#0x20
	unlk a5
	rts
LC54:
	.ascii "RAM Write (move16) Test %.2f ms\0"
	.even
.globl _testWrite16RAM__10GfxTestApp
_testWrite16RAM__10GfxTestApp:
	pea a5@
	movel sp,a5
	fmovem #0x4,sp@-
	moveml #0x3e3a,sp@-
	movel a5@(8),a2
	clrl d3
	fmoved #0r0.000000000000005,fp2
	movel #_sprintf,d6
	movel #_lockKernel__10GfxTestApp,d5
	lea _setMem16__10GfxTestAppPvlUl,a6
	lea _elapsedFrac__C10MilliClock,a4
	lea _unlockKernel__10GfxTestApp,a3
	moveq #14,d2
	addl a2,d2
	clrl d4
	.even
L1518:
	fmoved fp2,sp@-
	pea LC54
	movel a2@(10),sp@-
	movel d6,a0
	jbsr a0@
	movel a2@(6),a0
	movel a0@,a1
	movel a2@(10),sp@-
	movel a0,sp@-
	movel a1@(36),a0
	jbsr a0@
	movel a2,sp@-
	movel d5,a0
	jbsr a0@
	addw #24,sp
	movel d2,sp@
	jbsr _ReadEClock
	movel a2@(46),sp@
	moveb d3,d4
	movel d4,sp@-
	movel a2@(38),sp@-
	jbsr a6@
	movel d2,sp@-
	jbsr a4@
	movel d1,sp@-
	movel d0,sp@-
	fdmoved sp@+,fp0
	fdaddx fp0,fp2
	movel a2,sp@-
	jbsr a3@
	addql #1,d3
	addw #20,sp
	fcmpd #0r2000.000000000004,fp2
	fjlt L1518
	movel a2@(46),d0
	fdmovel d0,fp0
	tstl d0
	jge L1521
	fdaddd #0r4294967296.000005,fp0
L1521:
	fdmuld #0r1000.000000000005,fp0
	fdmull d3,fp0
	fdmuld #0r1024.000000000005,fp2
	fddivx fp2,fp0
	fmoved fp0,sp@-
	movel sp@+,d0
	movel sp@+,d1
	moveml a5@(-48),#0x5c7c
	fmovem a5@(-12),#0x20
	unlk a5
	rts
LC55:
	.ascii "RAM Write (memset) Test %.2f ms\0"
	.even
.globl _testCLibWriteRAM__10GfxTestApp
_testCLibWriteRAM__10GfxTestApp:
	pea a5@
	movel sp,a5
	fmovem #0x4,sp@-
	moveml #0x3c3a,sp@-
	movel a5@(8),a2
	clrl d3
	fmoved #0r0.000000000000005,fp2
	movel #_sprintf,d5
	movel #_lockKernel__10GfxTestApp,d4
	lea _memset,a6
	lea _elapsedFrac__C10MilliClock,a4
	lea _unlockKernel__10GfxTestApp,a3
	moveq #14,d2
	addl a2,d2
	.even
L1525:
	fmoved fp2,sp@-
	pea LC55
	movel a2@(10),sp@-
	movel d5,a0
	jbsr a0@
	movel a2@(6),a0
	movel a0@,a1
	movel a2@(10),sp@-
	movel a0,sp@-
	movel a1@(36),a0
	jbsr a0@
	movel a2,sp@-
	movel d4,a0
	jbsr a0@
	addw #24,sp
	movel d2,sp@
	jbsr _ReadEClock
	movel a2@(46),sp@
	movel d3,sp@-
	movel a2@(38),sp@-
	jbsr a6@
	movel d2,sp@-
	jbsr a4@
	movel d1,sp@-
	movel d0,sp@-
	fdmoved sp@+,fp0
	fdaddx fp0,fp2
	movel a2,sp@-
	jbsr a3@
	addql #1,d3
	addw #20,sp
	fcmpd #0r2000.000000000004,fp2
	fjlt L1525
	movel a2@(46),d0
	fdmovel d0,fp0
	tstl d0
	jge L1528
	fdaddd #0r4294967296.000005,fp0
L1528:
	fdmuld #0r1000.000000000005,fp0
	fdmull d3,fp0
	fdmuld #0r1024.000000000005,fp2
	fddivx fp2,fp0
	fmoved fp0,sp@-
	movel sp@+,d0
	movel sp@+,d1
	moveml a5@(-44),#0x5c3c
	fmovem a5@(-12),#0x20
	unlk a5
	rts
LC56:
	.ascii "RAM Read Test %.2f ms\0"
	.even
.globl _testReadRAM__10GfxTestApp
_testReadRAM__10GfxTestApp:
	pea a5@
	movel sp,a5
	fmovem #0x4,sp@-
	moveml #0x3c3a,sp@-
	movel a5@(8),a2
	clrl d3
	fmoved #0r0.000000000000005,fp2
	movel #_sprintf,d5
	movel #_lockKernel__10GfxTestApp,d4
	lea _readMem__10GfxTestAppPvUl,a6
	lea _elapsedFrac__C10MilliClock,a4
	lea _unlockKernel__10GfxTestApp,a3
	moveq #14,d2
	addl a2,d2
	.even
L1532:
	fmoved fp2,sp@-
	pea LC56
	movel a2@(10),sp@-
	movel d5,a0
	jbsr a0@
	movel a2@(6),a0
	movel a0@,a1
	movel a2@(10),sp@-
	movel a0,sp@-
	movel a1@(36),a0
	jbsr a0@
	movel a2,sp@-
	movel d4,a0
	jbsr a0@
	addw #24,sp
	movel d2,sp@
	jbsr _ReadEClock
	movel a2@(46),sp@
	movel a2@(38),sp@-
	jbsr a6@
	movel d2,sp@-
	jbsr a4@
	movel d1,sp@-
	movel d0,sp@-
	fdmoved sp@+,fp0
	fdaddx fp0,fp2
	movel a2,sp@-
	jbsr a3@
	addql #1,d3
	addw #16,sp
	fcmpd #0r2000.000000000004,fp2
	fjlt L1532
	movel a2@(46),d0
	fdmovel d0,fp0
	tstl d0
	jge L1535
	fdaddd #0r4294967296.000005,fp0
L1535:
	fdmuld #0r1000.000000000005,fp0
	fdmull d3,fp0
	fdmuld #0r1024.000000000005,fp2
	fddivx fp2,fp0
	fmoved fp0,sp@-
	movel sp@+,d0
	movel sp@+,d1
	moveml a5@(-44),#0x5c3c
	fmovem a5@(-12),#0x20
	unlk a5
	rts
LC57:
	.ascii "Testing conversion %.2f ms\0"
	.even
.globl _testConversion__10GfxTestApp
_testConversion__10GfxTestApp:
	link a5,#-4
	fmovem #0xc,sp@-
	moveml #0x3f3a,sp@-
	movel a5@(8),a2
	clrl d6
	movel a2@(6),a0
	movel a0@,a1
	movel a0,sp@-
	movel a1@(40),a0
	jbsr a0@
	movel d0,a3
	addql #4,sp
	movew a3@(32),a0
	movel a0,a5@(-4)
	movel a2@(30),d1
	movel d1,d0
	lsll #4,d0
	subl d1,d0
	addl a3@(36),d0
	lea __6_Nat2D$convTab,a0
	movel a0@(d0:l:4),d5
	fmoved #0r0.000000000000005,fp3
	.even
L1542:
	fmoved fp3,sp@-
	pea LC57
	movel a2@(10),sp@-
	jbsr _sprintf
	movel a2@(6),a0
	movel a0@,a1
	movel a2@(10),sp@-
	movel a0,sp@-
	movel a1@(36),a0
	jbsr a0@
	movel a3,sp@-
	jbsr _lockData__7Surface
	movel d0,d3
	addw #28,sp
	jeq L1543
	fmoved #0r0.000000000000005,fp2
	movel #_lockKernel__10GfxTestApp,d4
	lea _elapsedFrac__C10MilliClock,a6
	lea _unlockKernel__10GfxTestApp,a4
	movel #_unlockData__7Surface,d7
	moveq #14,d2
	addl a2,d2
	.even
L1546:
	movel a2,sp@-
	movel d4,a0
	jbsr a0@
	movel d2,sp@
	jbsr _ReadEClock
	addql #4,sp
	movew a2@(24),a0
	movel a0,sp@-
	movew a5@(-2),d0
	addw a2@(24),d0
	movew d0,a0
	movel a0,sp@-
	movew a2@(28),a0
	movel a0,sp@-
	movew a2@(24),a0
	movel a0,sp@-
	clrl sp@-
	movel a2@(38),sp@-
	movel d3,sp@-
	movel d5,a0
	jbsr a0@
	movel d2,sp@-
	jbsr a6@
	movel d1,sp@-
	movel d0,sp@-
	fdmoved sp@+,fp0
	fdaddx fp0,fp2
	addw #28,sp
	movel a2,sp@
	jbsr a4@
	addql #1,d6
	addql #4,sp
	fcmpd #0r50.00000000000005,fp2
	fjlt L1546
	fdaddx fp2,fp3
	movel a3,sp@-
	movel d7,a0
	jbsr a0@
	addql #4,sp
L1543:
	movel a2@(6),a0
	movel a0@,a1
	movel a0,sp@-
	movel a1@(28),a0
	jbsr a0@
	addql #4,sp
	fcmpd #0r2000.000000000004,fp3
	fjlt L1542
	movel a3@(36),a0
	lea a0@(a0:l:2),a0
	movel a0,d0
	lsll #2,d0
	movel d0,a0
	addl #__15PixelDescriptor$propTab,a0
	clrl d0
	moveb a0@,d0
	mulsl a2@(22),d0
	mulsl a2@(26),d0
	fdmovel d0,fp0
	tstl d0
	jge L1553
	fdaddd #0r4294967296.000005,fp0
L1553:
	fdmovex fp0,fp2
	fdmuld #0r1000.000000000005,fp2
	fdmull d6,fp2
	fdmuld #0r1024.000000000005,fp3
	fddivx fp3,fp2
	pea LC36
	pea LC37
	pea LC38
	jbsr _dialogueBox__9SystemLibPCcN21e
	tstl d0
	jne L1554
	fmoved fp2,sp@-
	movel sp@+,d0
	movel sp@+,d1
	jra L1555
	.even
L1554:
	fmoved fp2,sp@-
	movel sp@+,d0
	movel sp@+,d1
	bchg #31,d0
L1555:
	moveml a5@(-68),#0x5cfc
	fmovem a5@(-28),#0x30
	unlk a5
	rts
LC58:
	.ascii "Surface width: %ld, height: %ld, modulus: %ld\12\12\0"
LC59:
	.ascii "Surface hwWidth: %ld, hwHeight: %ld\12\0"
LC60:
	.ascii "Test data pixel format\12\0"
LC61:
	.ascii "Window pixel format\12\0"
LC62:
	.ascii "Locking enabled. No task switches or interrupts during iterations.\12\0"
LC63:
	.ascii "68040/060 detected. MOVE16 based tests will be performed.\12\0"
LC64:
	.ascii "Results (negative value indicates glitches were observed\12\12\0"
LC65:
	.ascii "Read RAM      : %7.2f K/sec\12\0"
LC66:
	.ascii "Write RAM     : %7.2f K/sec\12\0"
LC67:
	.ascii "Write RAM(C)  : %7.2f K/sec\12\0"
LC68:
	.ascii "Write RAM(16) : %7.2f K/sec\12\0"
LC69:
	.ascii "Write RAM(16) : N/A\12\0"
LC70:
	.ascii "RAM->RAM      : %7.2f K/sec\12\0"
LC71:
	.ascii "RAM->RAM(C)   : %7.2f K/sec\12\0"
LC72:
	.ascii "RAM->RAM(OS:0): %7.2f K/sec\12\0"
LC73:
	.ascii "RAM->RAM(OS:2): %7.2f K/sec\12\0"
LC74:
	.ascii "RAM->RAM(OS:4): %7.2f K/sec\12\0"
LC75:
	.ascii "RAM->RAM(OS:6): %7.2f K/sec\12\0"
LC76:
	.ascii "RAM->RAM(OS:8): %7.2f K/sec\12\0"
LC77:
	.ascii "RAM->RAM(16)  : %7.2f K/sec\12\0"
LC78:
	.ascii "RAM->RAM(16:0): %7.2f K/sec\12\0"
LC79:
	.ascii "RAM->RAM(16:2): %7.2f K/sec\12\0"
LC80:
	.ascii "RAM->RAM(16:4): %7.2f K/sec\12\0"
LC81:
	.ascii "RAM->RAM(16:6): %7.2f K/sec\12\0"
LC82:
	.ascii "RAM->RAM(16:8): %7.2f K/sec\12\0"
LC83:
	.ascii "\12-------------------------------\12\12\0"
LC84:
	.ascii "Read VRAM     : %7.2f K/sec\12\0"
LC85:
	.ascii "Write VRAM    : %7.2f K/sec\12\0"
LC86:
	.ascii "Write VRAM(C) : %7.2f K/sec\12\0"
LC87:
	.ascii "Write VRAM(16): %7.2f K/sec\12\0"
LC88:
	.ascii "RAM->VRAM      : %7.2f K/sec\12\0"
LC89:
	.ascii "RAM->VRAM(C)   : %7.2f K/sec\12\0"
LC90:
	.ascii "RAM->VRAM(OS:0): %7.2f K/sec\12\0"
LC91:
	.ascii "RAM->VRAM(OS:2): %7.2f K/sec\12\0"
LC92:
	.ascii "RAM->VRAM(OS:4): %7.2f K/sec\12\0"
LC93:
	.ascii "RAM->VRAM(OS:6): %7.2f K/sec\12\0"
LC94:
	.ascii "RAM->VRAM(OS:8): %7.2f K/sec\12\0"
LC95:
	.ascii "RAM->VRAM(16)  : %7.2f K/sec\12\0"
LC96:
	.ascii "RAM->VRAM(16:0): %7.2f K/sec\12\0"
LC97:
	.ascii "RAM->VRAM(16:2): %7.2f K/sec\12\0"
LC98:
	.ascii "RAM->VRAM(16:4): %7.2f K/sec\12\0"
LC99:
	.ascii "RAM->VRAM(16:6): %7.2f K/sec\12\0"
LC100:
	.ascii "RAM->VRAM(16:8): %7.2f K/sec\12\0"
LC101:
	.ascii "VRAM->RAM     : %7.2f K/sec\12\0"
LC102:
	.ascii "VRAM->RAM(16) : %7.2f K/sec\12\0"
LC103:
	.ascii "Conversion    : %7.2f K/sec [output bandwidth]\12\0"
LC104:
	.ascii "Conversion    : %7.2f pix/sec\12\0"
LC105:
	.ascii "\12Conversion attained %7.2f%% copy speed\12\0"
	.even
.globl _runApplication__10GfxTestApp
_runApplication__10GfxTestApp:
	link a5,#-40
	fmovem #0x4,sp@-
	moveml #0x203a,sp@-
	movel a5@(8),a4
	movel a4@(6),a0
	movel a0@,a1
	movel a0,sp@-
	movel a1@(40),a0
	jbsr a0@
	movel d0,a6
	addql #4,sp
	tstl a6
	jeq L1557
	movew a6@(32),a0
	movel a0,sp@-
	movel a4@(26),sp@-
	movel a4@(22),sp@-
	pea LC58
	lea _printf,a2
	jbsr a2@
	addw #16,sp
	movew a6@(30),a0
	movel a0,sp@-
	movew a6@(28),a0
	movel a0,sp@-
	pea LC59
	jbsr a2@
	pea LC60
	jbsr a2@
	movel a4@(30),a0
	addw #16,sp
	lea a0@(a0:l:2),a0
	movel a0,d0
	lsll #2,d0
	addl #__15PixelDescriptor$propTab,d0
	movel d0,sp@-
	movel a4,sp@-
	lea _dumpPixelInfo__10GfxTestAppP15PixelDescriptor,a3
	jbsr a3@
	pea LC61
	jbsr a2@
	addw #12,sp
	movel a6@(36),a0
	lea a0@(a0:l:2),a0
	movel a0,d0
	lsll #2,d0
	addl #__15PixelDescriptor$propTab,d0
	movel d0,sp@-
	movel a4,sp@-
	jbsr a3@
	addql #8,sp
	movel a2,d2
	tstb a4@(51)
	jeq L1564
	pea LC62
	jbsr a2@
	addql #4,sp
L1564:
	tstb a4@(50)
	jeq L1565
	pea LC63
	movel d2,a0
	jbsr a0@
	addql #4,sp
L1565:
	clrl a5@(-4)
	movel a5@(-4),sp@-
	movel a6,sp@-
	lea _clear__7SurfaceG6Colour,a3
	jbsr a3@
	movel a4@(6),a0
	movel a0@,a1
	movel a0,sp@-
	movel a1@(28),a0
	jbsr a0@
	movel a4,sp@-
	jbsr _testReadVRAM__10GfxTestApp
	movel d0,_readVSpeed
	movel d1,_readVSpeed+4
	addw #16,sp
	clrl a5@(-8)
	movel a5@(-8),sp@-
	movel a6,sp@-
	jbsr a3@
	movel a4@(6),a0
	movel a0@,a1
	movel a0,sp@-
	movel a1@(28),a0
	jbsr a0@
	movel a4,sp@-
	jbsr _testWriteVRAM__10GfxTestApp
	movel d0,_writeVSpeed
	movel d1,_writeVSpeed+4
	addw #16,sp
	tstb a4@(50)
	jeq L1570
	clrl a5@(-12)
	movel a5@(-12),sp@-
	movel a6,sp@-
	jbsr a3@
	movel a4@(6),a0
	movel a0@,a1
	movel a0,sp@-
	movel a1@(28),a0
	jbsr a0@
	movel a4,sp@-
	jbsr _testWrite16VRAM__10GfxTestApp
	movel d0,_write16VSpeed
	movel d1,_write16VSpeed+4
	addw #16,sp
L1570:
	clrl a5@(-16)
	movel a5@(-16),sp@-
	movel a6,sp@-
	jbsr a3@
	movel a4@(6),a0
	movel a0@,a1
	movel a0,sp@-
	movel a1@(28),a0
	jbsr a0@
	movel a4,sp@-
	jbsr _testCLibWriteVRAM__10GfxTestApp
	movel d0,_writeCVSpeed
	movel d1,_writeCVSpeed+4
	addw #16,sp
	clrl a5@(-20)
	movel a5@(-20),sp@-
	movel a6,sp@-
	jbsr a3@
	movel a4@(6),a0
	movel a0@,a1
	movel a0,sp@-
	movel a1@(28),a0
	jbsr a0@
	movel a4,sp@-
	jbsr _testCopyRAM2VRAM__10GfxTestApp
	movel d0,_copyR2VSpeed
	movel d1,_copyR2VSpeed+4
	addw #16,sp
	tstb a4@(50)
	jeq L1577
	clrl a5@(-24)
	movel a5@(-24),sp@-
	movel a6,sp@-
	jbsr a3@
	movel a4@(6),a0
	movel a0@,a1
	movel a0,sp@-
	movel a1@(28),a0
	jbsr a0@
	movel a4,sp@-
	jbsr _testCopy16RAM2VRAM__10GfxTestApp
	movel d0,_copy16R2VSpeed
	movel d1,_copy16R2VSpeed+4
	addw #16,sp
L1577:
	clrl a5@(-28)
	movel a5@(-28),sp@-
	movel a6,sp@-
	jbsr a3@
	movel a4@(6),a0
	movel a0@,a1
	movel a0,sp@-
	movel a1@(28),a0
	jbsr a0@
	movel a4,sp@-
	jbsr _testCLibCopyRAM2VRAM__10GfxTestApp
	movel d0,_copyCR2VSpeed
	movel d1,_copyCR2VSpeed+4
	addw #16,sp
	clrl a5@(-32)
	movel a5@(-32),sp@-
	movel a6,sp@-
	jbsr a3@
	clrl sp@-
	movel a4,sp@-
	lea _testOSCopyMemRAM2VRAM__10GfxTestAppl,a2
	jbsr a2@
	movel d0,_copyOS_0R2VSpeed
	movel d1,_copyOS_0R2VSpeed+4
	pea 2:w
	movel a4,sp@-
	jbsr a2@
	movel d0,_copyOS_2R2VSpeed
	movel d1,_copyOS_2R2VSpeed+4
	pea 4:w
	movel a4,sp@-
	jbsr a2@
	movel d0,_copyOS_4R2VSpeed
	movel d1,_copyOS_4R2VSpeed+4
	addw #28,sp
	movel #6,sp@
	movel a4,sp@-
	jbsr a2@
	movel d0,_copyOS_6R2VSpeed
	movel d1,_copyOS_6R2VSpeed+4
	pea 8:w
	movel a4,sp@-
	jbsr a2@
	movel d0,_copyOS_8R2VSpeed
	movel d1,_copyOS_8R2VSpeed+4
	addw #16,sp
	tstb a4@(50)
	jeq L1584
	clrl a5@(-36)
	movel a5@(-36),sp@-
	movel a6,sp@-
	jbsr a3@
	clrl sp@-
	movel a4,sp@-
	lea _testShuffleCopy16RAM2VRAM__10GfxTestAppl,a2
	jbsr a2@
	movel d0,_shuffle16_0R2VSpeed
	movel d1,_shuffle16_0R2VSpeed+4
	pea 2:w
	movel a4,sp@-
	jbsr a2@
	movel d0,_shuffle16_2R2VSpeed
	movel d1,_shuffle16_2R2VSpeed+4
	pea 4:w
	movel a4,sp@-
	jbsr a2@
	movel d0,_shuffle16_4R2VSpeed
	movel d1,_shuffle16_4R2VSpeed+4
	addw #28,sp
	movel #6,sp@
	movel a4,sp@-
	jbsr a2@
	movel d0,_shuffle16_6R2VSpeed
	movel d1,_shuffle16_6R2VSpeed+4
	pea 8:w
	movel a4,sp@-
	jbsr a2@
	movel d0,_shuffle16_8R2VSpeed
	movel d1,_shuffle16_8R2VSpeed+4
	addw #16,sp
L1584:
	clrl a5@(-40)
	movel a5@(-40),sp@-
	movel a6,sp@-
	jbsr a3@
	movel a4@(6),a0
	movel a0@,a1
	movel a0,sp@-
	movel a1@(28),a0
	jbsr a0@
	movel a4,sp@-
	jbsr _testCopyVRAM2RAM__10GfxTestApp
	movel d0,_copyV2RSpeed
	movel d1,_copyV2RSpeed+4
	addw #16,sp
	tstb a4@(50)
	jeq L1589
	movel a4,sp@-
	jbsr _testCopy16VRAM2RAM__10GfxTestApp
	movel d0,_copy16V2RSpeed
	movel d1,_copy16V2RSpeed+4
	addql #4,sp
L1589:
	movel a4,sp@-
	jbsr _testConversion__10GfxTestApp
	movel d0,_convSpeed
	movel d1,_convSpeed+4
	movel a4,sp@-
	jbsr _testReadRAM__10GfxTestApp
	movel d0,_readRSpeed
	movel d1,_readRSpeed+4
	movel a4,sp@-
	jbsr _testWriteRAM__10GfxTestApp
	movel d0,_writeRSpeed
	movel d1,_writeRSpeed+4
	movel a4,sp@-
	jbsr _testCLibWriteRAM__10GfxTestApp
	movel d0,_writeCRSpeed
	movel d1,_writeCRSpeed+4
	movel a4,sp@-
	jbsr _testCopyRAM2RAM__10GfxTestApp
	movel d0,_copyR2RSpeed
	movel d1,_copyR2RSpeed+4
	movel a4,sp@-
	jbsr _testCLibCopyRAM2RAM__10GfxTestApp
	movel d0,_copyCR2RSpeed
	movel d1,_copyCR2RSpeed+4
	clrl sp@-
	movel a4,sp@-
	lea _testOSCopyMemRAM2RAM__10GfxTestAppl,a2
	jbsr a2@
	movel d0,_copyOS_0R2RSpeed
	movel d1,_copyOS_0R2RSpeed+4
	addw #28,sp
	movel #2,sp@
	movel a4,sp@-
	jbsr a2@
	movel d0,_copyOS_2R2RSpeed
	movel d1,_copyOS_2R2RSpeed+4
	pea 4:w
	movel a4,sp@-
	jbsr a2@
	movel d0,_copyOS_4R2RSpeed
	movel d1,_copyOS_4R2RSpeed+4
	pea 6:w
	movel a4,sp@-
	jbsr a2@
	movel d0,_copyOS_6R2RSpeed
	movel d1,_copyOS_6R2RSpeed+4
	pea 8:w
	movel a4,sp@-
	jbsr a2@
	movel d0,_copyOS_8R2RSpeed
	movel d1,_copyOS_8R2RSpeed+4
	addw #32,sp
	tstb a4@(50)
	jeq L1590
	movel a4,sp@-
	jbsr _testWrite16RAM__10GfxTestApp
	movel d0,_write16RSpeed
	movel d1,_write16RSpeed+4
	movel a4,sp@-
	jbsr _testCopy16RAM2RAM__10GfxTestApp
	movel d0,_copy16R2RSpeed
	movel d1,_copy16R2RSpeed+4
	clrl sp@-
	movel a4,sp@-
	lea _testShuffleCopy16RAM2RAM__10GfxTestAppl,a2
	jbsr a2@
	movel d0,_shuffle16_0R2RSpeed
	movel d1,_shuffle16_0R2RSpeed+4
	pea 2:w
	movel a4,sp@-
	jbsr a2@
	movel d0,_shuffle16_2R2RSpeed
	movel d1,_shuffle16_2R2RSpeed+4
	pea 4:w
	movel a4,sp@-
	jbsr a2@
	movel d0,_shuffle16_4R2RSpeed
	movel d1,_shuffle16_4R2RSpeed+4
	addw #28,sp
	movel #6,sp@
	movel a4,sp@-
	jbsr a2@
	movel d0,_shuffle16_6R2RSpeed
	movel d1,_shuffle16_6R2RSpeed+4
	pea 8:w
	movel a4,sp@-
	jbsr a2@
	movel d0,_shuffle16_8R2RSpeed
	movel d1,_shuffle16_8R2RSpeed+4
	addw #16,sp
L1590:
	movel a6@(36),a0
	lea a0@(a0:l:2),a0
	movel a0,d0
	lsll #2,d0
	movel d0,a0
	addl #__15PixelDescriptor$propTab,a0
	clrl d0
	moveb a0@,d0
	fdmoved _convSpeed,fp1
	fdmuld #0r1024.000000000005,fp1
	fdmovel d0,fp0
	tstl d0
	jge L1594
	fdaddd #0r4294967296.000005,fp0
L1594:
	fdmovex fp1,fp2
	fddivx fp0,fp2
	pea LC64
	movel d2,a0
	jbsr a0@
	movel _readRSpeed+4,sp@-
	movel _readRSpeed,sp@-
	pea LC65
	movel d2,a0
	jbsr a0@
	movel _writeRSpeed+4,sp@-
	movel _writeRSpeed,sp@-
	pea LC66
	movel d2,a0
	jbsr a0@
	movel _writeCRSpeed+4,sp@-
	movel _writeCRSpeed,sp@-
	pea LC67
	movel d2,a0
	jbsr a0@
	addw #40,sp
	tstb a4@(50)
	jeq L1595
	movel _write16RSpeed+4,sp@-
	movel _write16RSpeed,sp@-
	pea LC68
	movel d2,a0
	jbsr a0@
	addw #12,sp
	jra L1596
	.even
L1595:
	pea LC69
	movel d2,a0
	jbsr a0@
	addql #4,sp
L1596:
	movel _copyR2RSpeed+4,sp@-
	movel _copyR2RSpeed,sp@-
	pea LC70
	movel d2,a2
	jbsr a2@
	movel _copyCR2RSpeed+4,sp@-
	movel _copyCR2RSpeed,sp@-
	pea LC71
	jbsr a2@
	movel _copyOS_0R2RSpeed+4,sp@-
	movel _copyOS_0R2RSpeed,sp@-
	pea LC72
	jbsr a2@
	addw #36,sp
	movel _copyOS_2R2RSpeed+4,sp@-
	movel _copyOS_2R2RSpeed,sp@-
	pea LC73
	jbsr a2@
	movel _copyOS_4R2RSpeed+4,sp@-
	movel _copyOS_4R2RSpeed,sp@-
	pea LC74
	jbsr a2@
	movel _copyOS_6R2RSpeed+4,sp@-
	movel _copyOS_6R2RSpeed,sp@-
	pea LC75
	jbsr a2@
	addw #36,sp
	movel _copyOS_8R2RSpeed+4,sp@-
	movel _copyOS_8R2RSpeed,sp@-
	pea LC76
	jbsr a2@
	addw #12,sp
	tstb a4@(50)
	jeq L1597
	movel _copy16R2RSpeed+4,sp@-
	movel _copy16R2RSpeed,sp@-
	pea LC77
	jbsr a2@
	movel _shuffle16_0R2RSpeed+4,sp@-
	movel _shuffle16_0R2RSpeed,sp@-
	pea LC78
	jbsr a2@
	movel _shuffle16_2R2RSpeed+4,sp@-
	movel _shuffle16_2R2RSpeed,sp@-
	pea LC79
	jbsr a2@
	addw #36,sp
	movel _shuffle16_4R2RSpeed+4,sp@-
	movel _shuffle16_4R2RSpeed,sp@-
	pea LC80
	jbsr a2@
	movel _shuffle16_6R2RSpeed+4,sp@-
	movel _shuffle16_6R2RSpeed,sp@-
	pea LC81
	jbsr a2@
	movel _shuffle16_8R2RSpeed+4,sp@-
	movel _shuffle16_8R2RSpeed,sp@-
	pea LC82
	jbsr a2@
	addw #36,sp
L1597:
	pea LC83
	jbsr a2@
	movel _readVSpeed+4,sp@-
	movel _readVSpeed,sp@-
	pea LC84
	jbsr a2@
	movel _writeVSpeed+4,sp@-
	movel _writeVSpeed,sp@-
	pea LC85
	jbsr a2@
	movel _writeCVSpeed+4,sp@-
	movel _writeCVSpeed,sp@-
	pea LC86
	jbsr a2@
	addw #40,sp
	tstb a4@(50)
	jeq L1598
	movel _write16VSpeed+4,sp@-
	movel _write16VSpeed,sp@-
	pea LC87
	jbsr a2@
	addw #12,sp
L1598:
	movel _copyR2VSpeed+4,sp@-
	movel _copyR2VSpeed,sp@-
	pea LC88
	jbsr a2@
	movel _copyCR2VSpeed+4,sp@-
	movel _copyCR2VSpeed,sp@-
	pea LC89
	jbsr a2@
	movel _copyOS_0R2RSpeed+4,sp@-
	movel _copyOS_0R2RSpeed,sp@-
	pea LC90
	jbsr a2@
	addw #36,sp
	movel _copyOS_2R2RSpeed+4,sp@-
	movel _copyOS_2R2RSpeed,sp@-
	pea LC91
	jbsr a2@
	movel _copyOS_4R2RSpeed+4,sp@-
	movel _copyOS_4R2RSpeed,sp@-
	pea LC92
	jbsr a2@
	movel _copyOS_6R2RSpeed+4,sp@-
	movel _copyOS_6R2RSpeed,sp@-
	pea LC93
	jbsr a2@
	addw #36,sp
	movel _copyOS_8R2RSpeed+4,sp@-
	movel _copyOS_8R2RSpeed,sp@-
	pea LC94
	jbsr a2@
	addw #12,sp
	tstb a4@(50)
	jeq L1599
	movel _copy16R2VSpeed+4,sp@-
	movel _copy16R2VSpeed,sp@-
	pea LC95
	jbsr a2@
	movel _shuffle16_0R2VSpeed+4,sp@-
	movel _shuffle16_0R2VSpeed,sp@-
	pea LC96
	jbsr a2@
	movel _shuffle16_2R2VSpeed+4,sp@-
	movel _shuffle16_2R2VSpeed,sp@-
	pea LC97
	jbsr a2@
	addw #36,sp
	movel _shuffle16_4R2VSpeed+4,sp@-
	movel _shuffle16_4R2VSpeed,sp@-
	pea LC98
	jbsr a2@
	movel _shuffle16_6R2VSpeed+4,sp@-
	movel _shuffle16_6R2VSpeed,sp@-
	pea LC99
	jbsr a2@
	movel _shuffle16_8R2VSpeed+4,sp@-
	movel _shuffle16_8R2VSpeed,sp@-
	pea LC100
	jbsr a2@
	addw #36,sp
L1599:
	pea LC83
	jbsr a2@
	movel _copyV2RSpeed+4,sp@-
	movel _copyV2RSpeed,sp@-
	pea LC101
	jbsr a2@
	addw #16,sp
	tstb a4@(50)
	jeq L1600
	movel _copy16V2RSpeed+4,sp@-
	movel _copy16V2RSpeed,sp@-
	pea LC102
	jbsr a2@
	addw #12,sp
L1600:
	pea LC83
	movel d2,a0
	jbsr a0@
	movel _convSpeed+4,sp@-
	movel _convSpeed,sp@-
	pea LC103
	movel d2,a0
	jbsr a0@
	fmoved fp2,sp@-
	pea LC104
	movel d2,a0
	jbsr a0@
	fdmoved _convSpeed,fp0
	fdmuld #0r100.0000000000005,fp0
	fddivd _copyR2VSpeed,fp0
	fmoved fp0,sp@-
	pea LC105
	movel d2,a0
	jbsr a0@
	addw #40,sp
L1557:
	subql #2,sp
	moveb #0,sp@(1)
	subql #2,sp
	subql #2,sp
	moveb #0,sp@(1)
	subql #2,sp
	subql #2,sp
	moveb #1,sp@(1)
	subql #2,sp
	pea 500:w
	jbsr _sleep__6ThreadUlbN22
	movel a4@(6),a0
	movel a0@,a1
	movel a0,sp@-
	movel a1@(20),a0
	jbsr a0@
	clrl d0
	moveml a5@(-72),#0x5c04
	fmovem a5@(-52),#0x20
	unlk a5
	rts
.globl ___vt_10GfxTestApp
	.even
___vt_10GfxTestApp:
	.long 0
	.long 0
	.long _initApplication__10GfxTestApp
	.long _doneApplication__7AppBase
	.long _runApplication__10GfxTestApp
	.long __$_10GfxTestApp
	.skip 4
	.even
___vt_13DisplayScreen:
	.long 0
	.long 0
	.long _open__13DisplayScreenssQ25Pixel5DepthPCc
	.long _open__13DisplayScreenPC17DisplayPropertiesPCc
	.long _reopen__13DisplayScreen
	.long _close__13DisplayScreen
	.long _waitSync__13DisplayScreen
	.long _refresh__13DisplayScreen
	.long _refresh__13DisplayScreenssss
	.long _setTitle__13DisplayScreenPCc
	.long _getDrawSurface__13DisplayScreen
	.long _getProperties__13DisplayScreen
	.long __$_13DisplayScreen
	.skip 4
	.even
___vt_13DisplayWindow:
	.long 0
	.long 0
	.long _open__13DisplayWindowssQ25Pixel5DepthPCc
	.long _open__13DisplayWindowPC17DisplayPropertiesPCc
	.long _reopen__13DisplayWindow
	.long _close__13DisplayWindow
	.long _waitSync__13DisplayWindow
	.long _refresh__13DisplayWindow
	.long _refresh__13DisplayWindowssss
	.long _setTitle__13DisplayWindowPCc
	.long _getDrawSurface__13DisplayWindow
	.long _getProperties__13DisplayWindow
	.long __$_13DisplayWindow
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
	jeq L22
	movel a0,sp@-
	jbsr ___builtin_delete
L22:
	unlk a5
	rts
	.even
__$_7Display:
	pea a5@
	movel sp,a5
	movel a5@(8),a0
	movel #___vt_7Display,a0@
	btst #0,a5@(15)
	jeq L304
	movel a0,sp@-
	jbsr ___builtin_delete
L304:
	unlk a5
	rts
	.even
_open__13DisplayWindowssQ25Pixel5DepthPCc:
	pea a5@
	movel sp,a5
	movel a5@(24),sp@-
	movel a5@(20),sp@-
	movew a5@(18),a0
	movel a0,sp@-
	movew a5@(14),a0
	movel a0,sp@-
	movel a5@(8),d0
	addql #4,d0
	movel d0,sp@-
	jbsr _open__7_NatWinssQ25Pixel5DepthPCc
	unlk a5
	rts
	.even
_open__13DisplayWindowPC17DisplayPropertiesPCc:
	pea a5@
	movel sp,a5
	movel a5@(16),sp@-
	movel a5@(12),sp@-
	movel a5@(8),d0
	addql #4,d0
	movel d0,sp@-
	jbsr _open__7_NatWinPC17DisplayPropertiesPCc
	unlk a5
	rts
	.even
_reopen__13DisplayWindow:
	pea a5@
	movel sp,a5
	movel a5@(8),d0
	addql #4,d0
	movel d0,sp@-
	jbsr _reopen__7_NatWin
	unlk a5
	rts
	.even
_close__13DisplayWindow:
	pea a5@
	movel sp,a5
	movel a5@(8),d0
	addql #4,d0
	movel d0,sp@-
	jbsr _close__7_NatWin
	unlk a5
	rts
	.even
_waitSync__13DisplayWindow:
	pea a5@
	movel sp,a5
	movel a5@(8),d0
	addql #4,d0
	movel d0,sp@-
	jbsr _waitForRefresh__11_NatDisplay
	unlk a5
	rts
	.even
_refresh__13DisplayWindow:
	pea a5@
	movel sp,a5
	movel a5@(8),d0
	addql #4,d0
	movel d0,sp@-
	jbsr _refresh__7_NatWin
	unlk a5
	rts
	.even
_refresh__13DisplayWindowssss:
	pea a5@
	movel sp,a5
	movew a5@(26),a0
	movel a0,sp@-
	movew a5@(22),a0
	movel a0,sp@-
	movew a5@(18),a0
	movel a0,sp@-
	movew a5@(14),a0
	movel a0,sp@-
	movel a5@(8),d0
	addql #4,d0
	movel d0,sp@-
	jbsr _refresh__7_NatWinssss
	unlk a5
	rts
	.even
_setTitle__13DisplayWindowPCc:
	pea a5@
	movel sp,a5
	subql #2,sp
	moveb #0,sp@(1)
	subql #2,sp
	movel a5@(12),sp@-
	movel a5@(8),d0
	addql #4,d0
	movel d0,sp@-
	jbsr _setDisplayTitle__11_NatDisplayPCcb
	unlk a5
	rts
	.even
_getDrawSurface__13DisplayWindow:
	pea a5@
	movel sp,a5
	movel a5@(8),a0
	addql #4,a0
	movel a0@(278),d0
	unlk a5
	rts
	.even
_getProperties__13DisplayWindow:
	pea a5@
	movel sp,a5
	clrl d0
	unlk a5
	rts
	.even
__$_13DisplayWindow:
	pea a5@
	movel sp,a5
	moveml #0x2030,sp@-
	movel a5@(8),a3
	movel a5@(12),d2
	movel a3,a2
	movel #___vt_13DisplayWindow,a2@+
	movel a2,sp@-
	jbsr _close__7_NatWin
	clrl sp@
	movel a2,sp@-
	jbsr __$_7_NatWin
	addql #8,sp
	movel #___vt_7Display,a3@
	btst #0,d2
	jeq L819
	movel a3,sp@-
	jbsr ___builtin_delete
L819:
	moveml a5@(-12),#0xc04
	unlk a5
	rts
	.even
_open__13DisplayScreenssQ25Pixel5DepthPCc:
	pea a5@
	movel sp,a5
	movel a5@(24),sp@-
	movel a5@(20),sp@-
	movew a5@(18),a0
	movel a0,sp@-
	movew a5@(14),a0
	movel a0,sp@-
	movel a5@(8),d0
	addql #4,d0
	movel d0,sp@-
	jbsr _open__7_NatScrssQ25Pixel5DepthPCc
	unlk a5
	rts
	.even
_open__13DisplayScreenPC17DisplayPropertiesPCc:
	pea a5@
	movel sp,a5
	movel a5@(16),sp@-
	movel a5@(12),sp@-
	movel a5@(8),d0
	addql #4,d0
	movel d0,sp@-
	jbsr _open__7_NatScrPC17DisplayPropertiesPCc
	unlk a5
	rts
	.even
_reopen__13DisplayScreen:
	pea a5@
	movel sp,a5
	movel a5@(8),d0
	addql #4,d0
	movel d0,sp@-
	jbsr _reopen__7_NatScr
	unlk a5
	rts
	.even
_close__13DisplayScreen:
	pea a5@
	movel sp,a5
	movel a5@(8),d0
	addql #4,d0
	movel d0,sp@-
	jbsr _close__7_NatScr
	unlk a5
	rts
	.even
_waitSync__13DisplayScreen:
	pea a5@
	movel sp,a5
	movel a5@(8),d0
	addql #4,d0
	movel d0,sp@-
	jbsr _waitForRefresh__11_NatDisplay
	unlk a5
	rts
	.even
_refresh__13DisplayScreen:
	pea a5@
	movel sp,a5
	unlk a5
	rts
	.even
_refresh__13DisplayScreenssss:
	pea a5@
	movel sp,a5
	unlk a5
	rts
	.even
_setTitle__13DisplayScreenPCc:
	pea a5@
	movel sp,a5
	subql #2,sp
	moveb #1,sp@(1)
	subql #2,sp
	movel a5@(12),sp@-
	movel a5@(8),d0
	addql #4,d0
	movel d0,sp@-
	jbsr _setDisplayTitle__11_NatDisplayPCcb
	unlk a5
	rts
	.even
_getDrawSurface__13DisplayScreen:
	pea a5@
	movel sp,a5
	movel a5@(8),a0
	addql #4,a0
	movel a0@(278),d0
	unlk a5
	rts
	.even
_getProperties__13DisplayScreen:
	pea a5@
	movel sp,a5
	movel a5@(8),a0
	addql #4,a0
	movel a0@(282),d0
	unlk a5
	rts
	.even
__$_13DisplayScreen:
	pea a5@
	movel sp,a5
	moveml #0x2030,sp@-
	movel a5@(8),a3
	movel a5@(12),d2
	movel a3,a2
	movel #___vt_13DisplayScreen,a2@+
	movel a2,sp@-
	jbsr _close__7_NatScr
	clrl sp@
	movel a2,sp@-
	jbsr __$_7_NatScr
	addql #8,sp
	movel #___vt_7Display,a3@
	btst #0,d2
	jeq L867
	movel a3,sp@-
	jbsr ___builtin_delete
L867:
	moveml a5@(-12),#0xc04
	unlk a5
	rts
.globl _readVSpeed
	.bss
_readVSpeed:
	.skip 8
.globl _writeVSpeed
_writeVSpeed:
	.skip 8
.globl _write16VSpeed
_write16VSpeed:
	.skip 8
.globl _writeCVSpeed
_writeCVSpeed:
	.skip 8
.globl _copyR2VSpeed
_copyR2VSpeed:
	.skip 8
.globl _copy16R2VSpeed
_copy16R2VSpeed:
	.skip 8
.globl _copyCR2VSpeed
_copyCR2VSpeed:
	.skip 8
.globl _copyOS_0R2VSpeed
_copyOS_0R2VSpeed:
	.skip 8
.globl _copyOS_2R2VSpeed
_copyOS_2R2VSpeed:
	.skip 8
.globl _copyOS_4R2VSpeed
_copyOS_4R2VSpeed:
	.skip 8
.globl _copyOS_6R2VSpeed
_copyOS_6R2VSpeed:
	.skip 8
.globl _copyOS_8R2VSpeed
_copyOS_8R2VSpeed:
	.skip 8
.globl _copyOS_0R2RSpeed
_copyOS_0R2RSpeed:
	.skip 8
.globl _copyOS_2R2RSpeed
_copyOS_2R2RSpeed:
	.skip 8
.globl _copyOS_4R2RSpeed
_copyOS_4R2RSpeed:
	.skip 8
.globl _copyOS_6R2RSpeed
_copyOS_6R2RSpeed:
	.skip 8
.globl _copyOS_8R2RSpeed
_copyOS_8R2RSpeed:
	.skip 8
.globl _shuffle16_0R2VSpeed
_shuffle16_0R2VSpeed:
	.skip 8
.globl _shuffle16_2R2VSpeed
_shuffle16_2R2VSpeed:
	.skip 8
.globl _shuffle16_4R2VSpeed
_shuffle16_4R2VSpeed:
	.skip 8
.globl _shuffle16_6R2VSpeed
_shuffle16_6R2VSpeed:
	.skip 8
.globl _shuffle16_8R2VSpeed
_shuffle16_8R2VSpeed:
	.skip 8
.globl _shuffle16_0R2RSpeed
_shuffle16_0R2RSpeed:
	.skip 8
.globl _shuffle16_2R2RSpeed
_shuffle16_2R2RSpeed:
	.skip 8
.globl _shuffle16_4R2RSpeed
_shuffle16_4R2RSpeed:
	.skip 8
.globl _shuffle16_6R2RSpeed
_shuffle16_6R2RSpeed:
	.skip 8
.globl _shuffle16_8R2RSpeed
_shuffle16_8R2RSpeed:
	.skip 8
.globl _copyV2RSpeed
_copyV2RSpeed:
	.skip 8
.globl _copy16V2RSpeed
_copy16V2RSpeed:
	.skip 8
.globl _convSpeed
_convSpeed:
	.skip 8
.globl _readRSpeed
_readRSpeed:
	.skip 8
.globl _writeRSpeed
_writeRSpeed:
	.skip 8
.globl _write16RSpeed
_write16RSpeed:
	.skip 8
.globl _writeCRSpeed
_writeCRSpeed:
	.skip 8
.globl _copyR2RSpeed
_copyR2RSpeed:
	.skip 8
.globl _copy16R2RSpeed
_copy16R2RSpeed:
	.skip 8
.globl _copyOSR2RSpeed
_copyOSR2RSpeed:
	.skip 8
.globl _copyCR2RSpeed
_copyCR2RSpeed:
	.skip 8
