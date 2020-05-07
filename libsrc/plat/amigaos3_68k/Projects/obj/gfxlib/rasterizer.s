#NO_APP
.text
LC0:
	.ascii "bad_alloc\0"
.globl _Warp3DBase
.data
	.even
_Warp3DBase:
	.long 0
.globl __10Rasterizer$openCnt
	.even
__10Rasterizer$openCnt:
	.long 0
.text
LC1:
	.ascii "Warp3D.library\0"
LC2:
	.ascii "Rasterizer::init() : failed to open Warp3D.library v4\0"
LC3:
	.ascii "Rasterizer::init() : failed to query driver\0"
LC4:
	.ascii "Rasterizer:: initialized\0"
	.even
.globl _init__10Rasterizer
_init__10Rasterizer:
	pea a5@
	movel sp,a5
	pea 4:w
	pea LC1
	jbsr _OpenLibrary
	movel d0,_Warp3DBase
	addql #8,sp
	jne L1078
	pea 2:w
	pea LC2
	jra L1081
	.even
L1078:
	jbsr _W3D_CheckDriver
	moveq #1,d1
	cmpl d0,d1
	jeq L1079
	clrl sp@-
	pea LC4
	jbsr _printDebug__9SystemLibPCci
	clrl d0
	jra L1080
	.even
L1079:
	pea 2:w
	pea LC3
L1081:
	jbsr _printDebug__9SystemLibPCci
	jbsr _done__10Rasterizer
	movel #-50659333,d0
L1080:
	unlk a5
	rts
LC5:
	.ascii "Rasterizer:: finalized\0"
	.even
.globl _done__10Rasterizer
_done__10Rasterizer:
	pea a5@
	movel sp,a5
	clrl sp@-
	pea LC5
	jbsr _printDebug__9SystemLibPCci
	addql #8,sp
	movel _Warp3DBase,d0
	jeq L1083
	movel d0,sp@-
	jbsr _CloseLibrary
	clrl _Warp3DBase
L1083:
	unlk a5
	rts
	.even
.globl ___10Rasterizer
___10Rasterizer:
	pea a5@
	movel sp,a5
	movel a3,sp@-
	movel a2,sp@-
	movel a5@(8),a3
	lea a3@(68),a2
	clrl a2@
	lea a3@(72),a1
	clrl a1@
	lea a3@(76),a0
	clrl a0@
	clrl a3@(4)
	clrl a3@(8)
	clrl a3@(12)
	clrl a3@(16)
	clrl a3@(20)
	clrl a3@(24)
	clrl a3@(28)
	clrl a3@(32)
	clrl a3@(36)
	clrl a3@(40)
	clrl a3@(44)
	clrl a3@(48)
	clrl a3@(52)
	clrl a3@(56)
	clrl a3@(60)
	clrl a3@(64)
	movel #-16777216,a2@
	clrl a1@
	movel #-8421505,a0@
	clrl a3@(80)
	clrl a3@(84)
	movel #0x3f800000,a3@(88)
	movel #0x3f800000,a3@(92)
	movel #0x3f000000,a3@(96)
	movel #0x3f000000,a3@(100)
	movel #0x3f000000,a3@(104)
	moveq #7,d0
	movel d0,a3@(108)
	clrl a3@(112)
	clrl a3@(116)
	movel d0,a3@(120)
	clrl a3@(140)
	clrl a3@(136)
	clrl a3@(124)
	clrl a3@(128)
	moveq #5,d0
	movel d0,a3@(144)
	moveq #6,d0
	movel d0,a3@(148)
	moveq #7,d0
	movel d0,a3@(152)
	clrl a3@(156)
	clrl a3@(160)
	pea 16:w
	subql #2,sp
	moveb #1,sp@(1)
	subql #2,sp
	pea 5760:w
	jbsr _alloc__3MemUlbQ23Mem9AlignType
	tstl d0
	jeq L1094
	movel d0,a3@(168)
	addl #128,d0
	movel d0,a3@(172)
	jra L1095
	.even
L1094:
	clrl a3@(168)
	clrl a3@(172)
L1095:
	clrl a3@(176)
	moveq #1,d0
	movel d0,a3@(164)
	movel a3,d0
	movel a5@(-8),a2
	movel a5@(-4),a3
	unlk a5
	rts
LC6:
	.ascii "Rasterizer::obtain() : null Surface\12\0"
	.even
.globl _obtain__10RasterizerP7Surface
_obtain__10RasterizerP7Surface:
	link a5,#-68
	fmovem #0xfc,sp@-
	moveml #0x3f3a,sp@-
	jbsr ___get_eh_context
	movel d0,a5@(-62)
	tstl a5@(8)
	jeq L1098
	tstl __10Rasterizer$openCnt
	jne L1099
	jbsr _init__10Rasterizer
	tstl d0
	jeq L1100
	clrl d0
	jra L1119
	.even
L1100:
	addql #1,__10Rasterizer$openCnt
L1099:
	pea _nothrow
	pea 180:w
	jbsr ___nw__FUlRC9nothrow_t
	movel d0,a5@(-56)
	moveb #1,a5@(-57)
	movel a5@(-62),a0
	addql #4,a0
	movel a0@,a5@(-24)
	clrl a5@(-20)
	movel a5,a5@(-16)
	movel #L1105,a5@(-12)
	movel sp,a5@(-8)
	movel a0,a5@(-66)
	jra L1104
	.even
L1105:
	movel a5@(-62),a0
	addql #4,a0
	movel a0,a5@(-66)
	jra L1102
	.even
L1104:
	lea a5@(-24),a1
	movel a1,a0@
	movel a5@(-56),sp@-
	jbsr ___10Rasterizer
	clrb a5@(-57)
	movel d0,a5@(-52)
	movel a5@(-66),a1
	movel a1@,a0
	movel a0@,a1@
	addw #12,sp
	tstl a5@(-52)
	jeq L1098
	movel a5@(8),sp@-
	movel a5@(-52),sp@-
	jbsr _associate__10RasterizerP7Surface
	addql #8,sp
	tstl d0
	jeq L1109
	pea 3:w
	movel a5@(-52),sp@-
	jbsr __$_10Rasterizer
	clrl a5@(-52)
L1109:
	movel a5@(-52),d0
	jra L1119
	.even
L1098:
	pea 2:w
	pea LC6
	jbsr _printDebug__9SystemLibPCci
	clrl d0
	jra L1119
	.even
L1102:
	movel a5@(-66),a0
	movel a0@,a5@(-48)
	clrl a5@(-44)
	movel a5,a5@(-40)
	movel #L1115,a5@(-36)
	movel sp,a5@(-32)
	jra L1114
	.even
L1115:
	jra L1120
	.even
L1114:
	lea a5@(-48),a0
	movel a5@(-66),a1
	movel a0,a1@
	tstb a5@(-57)
	jeq L1117
	pea _nothrow
	movel a5@(-56),sp@-
	jbsr ___dl__FPvRC9nothrow_t
	addql #8,sp
L1117:
	movel a5@(-62),a1
	addql #4,a1
	movel a1@,a0
	movel a0@,a1@
	jbsr ___sjthrow
	.even
L1120:
L1112:
	jbsr ___terminate
	.even
L1119:
	moveml a5@(-180),#0x5cfc
	fmovem a5@(-140),#0x3f
	unlk a5
	rts
	.even
.globl __$_10Rasterizer
__$_10Rasterizer:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel a5@(8),a2
	movel a2,sp@-
	jbsr _disassociate__10Rasterizer
	movel a2@(168),sp@-
	jbsr _free__3MemPv
	movel __10Rasterizer$openCnt,d0
	movel d0,d1
	subql #1,d1
	movel d1,__10Rasterizer$openCnt
	addql #8,sp
	moveq #1,d1
	cmpl d0,d1
	jne L1123
	jbsr _done__10Rasterizer
L1123:
	movel a5@(12),d0
	btst #0,d0
	jeq L1125
	movel a2,sp@-
	jbsr ___builtin_delete
L1125:
	movel a5@(-4),a2
	unlk a5
	rts
LC7:
	.ascii "Rasterizer::associate() : no 3D resources available\12\0"
LC8:
	.ascii "Rasterizer::associate() : context already exists\12\0"
LC9:
	.ascii "Rasterizer::associate() : null Surface\12\0"
LC10:
	.ascii "Rasterizer::associate() : null Surface rep\12\0"
LC11:
	.ascii "Rasterizer::associate() : not enough memory\12\0"
LC12:
	.ascii "W3D_CreateContextTags() failed\0"
	.even
.globl _associate__10RasterizerP7Surface
_associate__10RasterizerP7Surface:
	link a5,#-84
	moveml #0x2030,sp@-
	movel a5@(8),a3
	movel a5@(12),a2
	moveb a3@(167),d0
	eorb #1,d0
	btst #0,d0
	jeq L1127
	pea 2:w
	pea LC7
	jra L1142
	.even
L1127:
	tstl a3@(4)
	jeq L1128
	pea 2:w
	pea LC8
	jbsr _printDebug__9SystemLibPCci
	movel #-50659332,d0
	jra L1141
	.even
L1128:
	tstl a2
	jne L1129
	pea 2:w
	pea LC9
	jbsr _printDebug__9SystemLibPCci
	addql #8,sp
L1129:
	tstl a2@(12)
	jne L1130
	pea 2:w
	pea LC10
	jbsr _printDebug__9SystemLibPCci
	movel #-50462722,d0
	jra L1141
	.even
L1130:
	clrl sp@-
	subql #2,sp
	moveb #0,sp@(1)
	subql #2,sp
	pea 3072:w
	jbsr _alloc__3MemUlbQ23Mem9AlignType
	movel d0,a3@(160)
	addw #12,sp
	jne L1132
	pea 2:w
	pea LC11
	jbsr _printDebug__9SystemLibPCci
	movel #-50528257,d0
	jra L1141
	.even
L1132:
	clrl a5@(-84)
	movel #-2145386496,a5@(-80)
	movel a2@(12),a5@(-76)
	movel #-2145386494,a5@(-72)
	moveq #2,d0
	movel d0,a5@(-68)
	movel #-2145386489,a5@(-64)
	moveq #1,d0
	movel d0,a5@(-60)
	clrl a5@(-52)
	movel #-2145386495,a5@(-56)
	clrl a5@(-48)
	clrl a5@(-44)
	movel a5@(-80),a5@(-40)
	movel a5@(-76),a5@(-36)
	movel a5@(-72),a5@(-32)
	movel a5@(-68),a5@(-28)
	movel a5@(-64),a5@(-24)
	movel d0,a5@(-20)
	movel a5@(-56),a5@(-16)
	movel a5@(-52),a5@(-12)
	movel a5@(-48),a5@(-8)
	movel a5@(-44),a5@(-4)
	pea a5@(-40)
	pea a5@(-84)
	jbsr _W3D_CreateContext
	movel d0,a3@(4)
	addql #8,sp
	jeq L1134
	movel a2,a3@(24)
	movew a2@,a0
	movel a0,a3@(16)
	movew a2@(2),a0
	movel a0,a3@(20)
	movel a3,d2
	addql #8,d2
	movel d2,sp@-
	clrl sp@-
	movel a2@(12),sp@-
	movel d0,sp@-
	jbsr _W3D_SetDrawRegion
	movel d2,sp@-
	movel a3@(4),sp@-
	jbsr _W3D_SetScissor
	movel a3@(152),d0
	addw #24,sp
	lea __6_Nat3D$blendMode,a0
	moveb a0@(d0:l),d0
	andl #0xFF,d0
	movel d0,sp@-
	movel a3@(148),d0
	moveb a0@(d0:l),d0
	andl #0xFF,d0
	movel d0,sp@-
	movel a3@(4),sp@-
	jbsr _W3D_SetBlendMode
	pea 1:w
	movel #33554432,sp@-
	movel a3@(4),sp@-
	lea _W3D_SetState,a2
	jbsr a2@
	pea 1:w
	movel #524288,sp@-
	movel a3@(4),sp@-
	jbsr a2@
	addw #32,sp
	movel #2,sp@
	pea 1024:w
	movel a3@(4),sp@-
	jbsr a2@
	pea 2:w
	pea 256:w
	movel a3@(4),sp@-
	jbsr a2@
	pea 2:w
	pea 2048:w
	movel a3@(4),sp@-
	jbsr a2@
	addw #32,sp
	movel #2,sp@
	pea 4096:w
	movel a3@(4),sp@-
	jbsr a2@
	pea 2:w
	pea 16:w
	movel a3@(4),sp@-
	jbsr a2@
	pea 2:w
	pea 8192:w
	movel a3@(4),sp@-
	jbsr a2@
	clrl d0
	jra L1141
	.even
L1134:
	pea 2:w
	pea LC12
L1142:
	jbsr _printDebug__9SystemLibPCci
	movel #-50659333,d0
L1141:
	moveml a5@(-96),#0xc04
	unlk a5
	rts
	.even
.globl _disassociate__10Rasterizer
_disassociate__10Rasterizer:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel a5@(8),a2
	movel a2@(160),d0
	jeq L1144
	movel d0,sp@-
	jbsr _free__3MemPv
	clrl a2@(160)
	addql #4,sp
L1144:
	movel a2@(4),d0
	jeq L1145
	clrl sp@-
	clrl sp@-
	movel d0,sp@-
	jbsr _W3D_BindTexture
	movel a2@(4),sp@-
	jbsr _W3D_FlushTextures
	movel a2@(4),sp@-
	jbsr _W3D_FreeZBuffer
	movel a2@(4),sp@-
	jbsr _W3D_FreeStencilBuffer
	movel a2@(4),sp@-
	jbsr _W3D_DestroyContext
	clrl a2@(4)
L1145:
	clrl a2@(24)
	movel a5@(-4),a2
	unlk a5
	rts
	.even
.globl _supportsFeature__10RasterizerQ23G3D5Query
_supportsFeature__10RasterizerQ23G3D5Query:
	pea a5@
	movel sp,a5
	movel a5@(8),a1
	movel a5@(12),d1
	movel a1@(24),a0
	movel a0@(36),d0
	lea __6_Nat2D$abstractToNative,a0
	movel a0@(d0:l:4),sp@-
	lea __6_Nat3D$query,a0
	clrl d0
	moveb a0@(d1:l),d0
	movel d0,sp@-
	movel a1@(4),sp@-
	jbsr _W3D_Query
	moveq #3,d1
	cmpl d0,d1
	jeq L1148
	moveq #4,d1
	cmpl d0,d1
	jeq L1149
	jra L1150
	.even
L1148:
	moveq #3,d0
	jra L1156
	.even
L1149:
	moveq #2,d0
	jra L1156
	.even
L1150:
	clrl d0
L1156:
	unlk a5
	rts
	.even
.globl _supportsTexelFormat__10RasterizerQ23G3D5Texel
_supportsTexelFormat__10RasterizerQ23G3D5Texel:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel a5@(8),a2
	movel a5@(12),d1
	movel a2@(24),a0
	movel a0@(36),d0
	lea __6_Nat2D$abstractToNative,a0
	movel a0@(d0:l:4),sp@-
	lea __6_Nat3D$texel,a0
	clrl d0
	moveb a0@(d1:l),d0
	movel d0,sp@-
	movel a2@(4),sp@-
	jbsr _W3D_GetTexFmtInfo
	moveq #3,d0
	movel a5@(-4),a2
	unlk a5
	rts
	.even
.globl _setFront__10RasterizerQ23G3D9FrontFace
_setFront__10RasterizerQ23G3D9FrontFace:
	pea a5@
	movel sp,a5
	movel a5@(8),a1
	movel a5@(12),d0
	cmpl a1@(156),d0
	jeq L1171
	movel d0,a1@(156)
	lea __6_Nat3D$frontFace,a0
	moveb a0@(d0:l),d0
	andl #0xFF,d0
	movel d0,sp@-
	movel a1@(4),sp@-
	jbsr _W3D_SetFrontFace
L1171:
	moveq #1,d0
	unlk a5
	rts
	.even
.globl _setDrawArea__10RasterizerssssP7Surface
_setDrawArea__10RasterizerssssP7Surface:
	pea a5@
	movel sp,a5
	moveml #0x3a,sp@-
	movel a5@(8),a4
	movel a5@(28),a6
	movew a5@(18),a1
	movew a5@(22),a0
	movew a5@(26),a2
	movew a5@(14),a3
	movel a3,a4@(8)
	movel a1,a4@(12)
	subl a3,a0
	movel a0,a4@(16)
	subl a1,a2
	movel a2,a4@(20)
	tstl a6
	jeq L1176
	tstl a6@(12)
	jne L1175
L1176:
	pea a4@(8)
	clrl sp@-
	clrl sp@-
	jra L1181
	.even
L1175:
	movel a6,a4@(24)
	pea a4@(8)
	clrl sp@-
	movel a6@(12),sp@-
L1181:
	movel a4@(4),sp@-
	jbsr _W3D_SetDrawRegion
	tstl d0
	seq d0
	negb d0
	moveml a5@(-16),#0x5c00
	unlk a5
	rts
	.even
.globl _createZBuffer__10Rasterizer
_createZBuffer__10Rasterizer:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel a5@(8),a2
	movel a2@(4),sp@-
	jbsr _W3D_AllocZBuffer
	tstl d0
	jeq L1183
	moveq #-5,d0
	andl d0,a2@(164)
	clrb d0
	jra L1185
	.even
L1183:
	moveq #4,d0
	orl d0,a2@(164)
	moveq #1,d0
L1185:
	movel a5@(-4),a2
	unlk a5
	rts
	.even
.globl _destroyZBuffer__10Rasterizer
_destroyZBuffer__10Rasterizer:
	pea a5@
	movel sp,a5
	movel a5@(8),a0
	movel a0@(164),d0
	btst #2,d0
	jeq L1188
	moveq #-5,d1
	andl d0,d1
	movel d1,a0@(164)
	movel a0@(4),sp@-
	jbsr _W3D_FreeZBuffer
L1188:
	unlk a5
	rts
	.even
.globl _writeZBuffer__10RasterizerssssPd
_writeZBuffer__10RasterizerssssPd:
	pea a5@
	movel sp,a5
	moveml #0x3e38,sp@-
	movel a5@(8),a4
	movel a5@(28),d3
	movew a5@(14),d2
	movew a5@(18),d4
	movew a5@(22),d0
	movew a5@(26),d1
	tstl d3
	jeq L1191
	btst #2,a4@(167)
	jne L1190
L1191:
	clrb d0
	jra L1197
	.even
L1190:
	movew d0,a3
	movew d2,a0
	subl a0,a3
	movew d1,a2
	movew d4,a1
	subl a1,a2
	movel a0,d6
	tstl a2
	jeq L1193
	movel a3,d5
	lsll #3,d5
	movel a2,d0
	negl d0
	moveq #3,d1
	andl d1,d0
	jeq L1194
	cmpl d0,d1
	jle L1200
	moveq #2,d1
	cmpl d0,d1
	jle L1201
	clrl sp@-
	movel d3,sp@-
	movel a3,sp@-
	movel a1,sp@-
	addqw #1,d4
	movel d6,sp@-
	movel a4@(4),sp@-
	jbsr _W3D_WriteZSpan
	addl d5,d3
	addw #24,sp
	subql #1,a2
L1201:
	clrl sp@-
	movel d3,sp@-
	movel a3,sp@-
	movew d4,a0
	movel a0,sp@-
	addqw #1,d4
	movel d6,sp@-
	movel a4@(4),sp@-
	jbsr _W3D_WriteZSpan
	addl d5,d3
	addw #24,sp
	subql #1,a2
L1200:
	clrl sp@-
	movel d3,sp@-
	movel a3,sp@-
	movew d4,a0
	movel a0,sp@-
	addqw #1,d4
	movel d6,sp@-
	movel a4@(4),sp@-
	jbsr _W3D_WriteZSpan
	addl d5,d3
	addw #24,sp
	subql #1,a2
	tstl a2
	jeq L1193
	.even
L1194:
	clrl sp@-
	movel d3,sp@-
	movel a3,sp@-
	movew d4,a0
	movel a0,sp@-
	movew d4,d2
	addqw #1,d2
	movel d6,sp@-
	movel a4@(4),sp@-
	jbsr _W3D_WriteZSpan
	addl d5,d3
	addw #20,sp
	clrl sp@
	movel d3,sp@-
	movel a3,sp@-
	movew d2,a0
	movel a0,sp@-
	addqw #1,d2
	movel d6,sp@-
	movel a4@(4),sp@-
	jbsr _W3D_WriteZSpan
	addl d5,d3
	addw #20,sp
	clrl sp@
	movel d3,sp@-
	movel a3,sp@-
	movew d2,a0
	movel a0,sp@-
	addqw #1,d2
	movel d6,sp@-
	movel a4@(4),sp@-
	jbsr _W3D_WriteZSpan
	addl d5,d3
	addw #20,sp
	clrl sp@
	movel d3,sp@-
	movel a3,sp@-
	movew d2,a0
	movel a0,sp@-
	addqw #4,d4
	movel d6,sp@-
	movel a4@(4),sp@-
	jbsr _W3D_WriteZSpan
	addl d5,d3
	addw #24,sp
	subql #4,a2
	tstl a2
	jne L1194
L1193:
	moveq #1,d0
L1197:
	moveml a5@(-32),#0x1c7c
	unlk a5
	rts
	.even
.globl _readZBuffer__10RasterizerssssPd
_readZBuffer__10RasterizerssssPd:
	pea a5@
	movel sp,a5
	moveml #0x3e38,sp@-
	movel a5@(8),a4
	movel a5@(28),d3
	movew a5@(14),d4
	movew a5@(18),d2
	movew a5@(22),d0
	movew a5@(26),d1
	tstl d3
	jeq L1219
	btst #2,a4@(167)
	jne L1218
L1219:
L1227:
	clrb d0
	jra L1226
	.even
L1218:
	movew d0,a3
	movew d4,a0
	subl a0,a3
	movew d1,a2
	movew d2,a1
	subl a1,a2
	movel a0,d6
	tstl a2
	jeq L1221
	movel a3,d5
	lsll #3,d5
	movel a2,d0
	negl d0
	moveq #3,d1
	andl d1,d0
	jeq L1229
	cmpl d0,d1
	jle L1230
	moveq #2,d1
	cmpl d0,d1
	jle L1231
	movel d3,sp@-
	movel a3,sp@-
	movel a1,sp@-
	addqw #1,d2
	movel d6,sp@-
	movel a4@(4),sp@-
	jbsr _W3D_ReadZSpan
	addw #20,sp
	tstl d0
	jne L1227
	addl d5,d3
	subql #1,a2
L1231:
	movel d3,sp@-
	movel a3,sp@-
	movew d2,a0
	movel a0,sp@-
	addqw #1,d2
	movel d6,sp@-
	movel a4@(4),sp@-
	jbsr _W3D_ReadZSpan
	addw #20,sp
	tstl d0
	jne L1227
	addl d5,d3
	subql #1,a2
L1230:
	movel d3,sp@-
	movel a3,sp@-
	movew d2,a0
	movel a0,sp@-
	addqw #1,d2
	movel d6,sp@-
	movel a4@(4),sp@-
	jbsr _W3D_ReadZSpan
	addw #20,sp
	tstl d0
	jne L1227
	addl d5,d3
	subql #1,a2
	tstl a2
	jeq L1221
L1229:
	movew d2,d4
	.even
L1222:
	movel d3,sp@-
	movel a3,sp@-
	movew d4,a0
	movel a0,sp@-
	movew d4,d2
	addqw #1,d2
	movel d6,sp@-
	movel a4@(4),sp@-
	jbsr _W3D_ReadZSpan
	addw #20,sp
	tstl d0
	jne L1227
	addl d5,d3
	movel d3,sp@-
	movel a3,sp@-
	movew d2,a0
	movel a0,sp@-
	addqw #1,d2
	movel d6,sp@-
	movel a4@(4),sp@-
	jbsr _W3D_ReadZSpan
	addw #20,sp
	tstl d0
	jne L1227
	addl d5,d3
	movel d3,sp@-
	movel a3,sp@-
	movew d2,a0
	movel a0,sp@-
	addqw #1,d2
	movel d6,sp@-
	movel a4@(4),sp@-
	jbsr _W3D_ReadZSpan
	addw #20,sp
	tstl d0
	jne L1227
	addl d5,d3
	movel d3,sp@-
	movel a3,sp@-
	movew d2,a0
	movel a0,sp@-
	addqw #4,d4
	movel d6,sp@-
	movel a4@(4),sp@-
	jbsr _W3D_ReadZSpan
	addw #20,sp
	tstl d0
	jne L1227
	addl d5,d3
	subql #4,a2
	tstl a2
	jne L1222
L1221:
	moveq #1,d0
L1226:
	moveml a5@(-32),#0x1c7c
	unlk a5
	rts
	.even
.globl _readStencilBuffer__10RasterizerssssPUl
_readStencilBuffer__10RasterizerssssPUl:
	pea a5@
	movel sp,a5
	moveml #0x3e38,sp@-
	movel a5@(8),a4
	movel a5@(28),d3
	movew a5@(14),d4
	movew a5@(18),d2
	movew a5@(22),d0
	movew a5@(26),d1
	tstl d3
	jne L1248
L1276:
	clrb d0
	jra L1255
	.even
L1248:
	movew d0,a3
	movew d4,a0
	subl a0,a3
	movew d1,a2
	movew d2,a1
	subl a1,a2
	movel a0,d6
	tstl a2
	jeq L1250
	movel a3,d5
	lsll #2,d5
	movel a2,d0
	negl d0
	moveq #3,d1
	andl d1,d0
	jeq L1258
	cmpl d0,d1
	jle L1259
	moveq #2,d1
	cmpl d0,d1
	jle L1260
	movel d3,sp@-
	movel a3,sp@-
	movel a1,sp@-
	addqw #1,d2
	movel d6,sp@-
	movel a4@(4),sp@-
	jbsr _W3D_ReadStencilSpan
	addw #20,sp
	tstl d0
	jne L1276
	addl d5,d3
	subql #1,a2
L1260:
	movel d3,sp@-
	movel a3,sp@-
	movew d2,a0
	movel a0,sp@-
	addqw #1,d2
	movel d6,sp@-
	movel a4@(4),sp@-
	jbsr _W3D_ReadStencilSpan
	addw #20,sp
	tstl d0
	jne L1276
	addl d5,d3
	subql #1,a2
L1259:
	movel d3,sp@-
	movel a3,sp@-
	movew d2,a0
	movel a0,sp@-
	addqw #1,d2
	movel d6,sp@-
	movel a4@(4),sp@-
	jbsr _W3D_ReadStencilSpan
	addw #20,sp
	tstl d0
	jne L1276
	addl d5,d3
	subql #1,a2
	tstl a2
	jeq L1250
L1258:
	movew d2,d4
	.even
L1251:
	movel d3,sp@-
	movel a3,sp@-
	movew d4,a0
	movel a0,sp@-
	movew d4,d2
	addqw #1,d2
	movel d6,sp@-
	movel a4@(4),sp@-
	jbsr _W3D_ReadStencilSpan
	addw #20,sp
	tstl d0
	jne L1276
	addl d5,d3
	movel d3,sp@-
	movel a3,sp@-
	movew d2,a0
	movel a0,sp@-
	addqw #1,d2
	movel d6,sp@-
	movel a4@(4),sp@-
	jbsr _W3D_ReadStencilSpan
	addw #20,sp
	tstl d0
	jne L1276
	addl d5,d3
	movel d3,sp@-
	movel a3,sp@-
	movew d2,a0
	movel a0,sp@-
	addqw #1,d2
	movel d6,sp@-
	movel a4@(4),sp@-
	jbsr _W3D_ReadStencilSpan
	addw #20,sp
	tstl d0
	jne L1276
	addl d5,d3
	movel d3,sp@-
	movel a3,sp@-
	movew d2,a0
	movel a0,sp@-
	addqw #4,d4
	movel d6,sp@-
	movel a4@(4),sp@-
	jbsr _W3D_ReadStencilSpan
	addw #20,sp
	tstl d0
	jne L1276
	addl d5,d3
	subql #4,a2
	tstl a2
	jne L1251
L1250:
	moveq #1,d0
L1255:
	moveml a5@(-32),#0x1c7c
	unlk a5
	rts
	.even
.globl _setFlatColour__10RasterizerG6Colour
_setFlatColour__10RasterizerG6Colour:
	link a5,#-32
	movel a3,sp@-
	movel a2,sp@-
	movel a5@(8),a1
	lea a5@(12),a2
	lea a1@(68),a3
	movel a2@,d0
	cmpl a3@,d0
	jeq L1288
	fmoves #0r0.00390625,fp0
	clrl a5@(-32)
	clrl a5@(-28)
	clrl a5@(-24)
	clrl a5@(-20)
	lea a5@(-16),a0
	clrl d0
	moveb a5@(13),d0
	fsmovex fp0,fp1
	fsmull d0,fp1
	fmoves fp1,a5@(-32)
	clrl d0
	moveb a5@(14),d0
	fsmovex fp0,fp1
	fsmull d0,fp1
	fmoves fp1,a5@(-28)
	clrl d0
	moveb a5@(15),d0
	fsmovex fp0,fp1
	fsmull d0,fp1
	fmoves fp1,a5@(-24)
	clrl d0
	moveb a2@,d0
	fsmull d0,fp0
	fmoves fp0,a5@(-20)
	movel a5@(-32),a0@
	movel a5@(-28),a5@(-12)
	movel a5@(-24),a5@(-8)
	movel a5@(-20),a5@(-4)
	movel a0,sp@-
	movel a1@(4),sp@-
	jbsr _W3D_SetCurrentColor
	tstl d0
	jeq L1284
	clrb d0
	jra L1287
	.even
L1284:
	movel a2@,a3@
L1288:
	moveq #1,d0
L1287:
	movel a5@(-40),a2
	movel a5@(-36),a3
	unlk a5
	rts
	.even
.globl _setFog__10RasterizerQ23G3D7FogModeG6Colourfff
_setFog__10RasterizerQ23G3D7FogModeG6Colourfff:
	pea a5@
	movel sp,a5
	movel a5@(8),a1
	movel a5@(20),a1@(84)
	movel a5@(24),a1@(88)
	movel a5@(28),a1@(92)
	lea a1@(76),a0
	movel a5@(16),d1
	cmpl a0@,d1
	jeq L1290
	fmoves #0r0.00390625,fp0
	clrl d0
	moveb a5@(17),d0
	fsmovex fp0,fp1
	fsmull d0,fp1
	fmoves fp1,a1@(96)
	clrl d0
	moveb a5@(18),d0
	fsmovex fp0,fp1
	fsmull d0,fp1
	fmoves fp1,a1@(100)
	clrl d0
	moveb a5@(19),d0
	fsmull d0,fp0
	fmoves fp0,a1@(104)
	movel d1,a0@
L1290:
	lea __6_Nat3D$fogMode,a0
	movel a5@(12),d0
	moveb a0@(d0:l),d0
	andl #0xFF,d0
	movel d0,sp@-
	pea a1@(84)
	movel a1@(4),sp@-
	jbsr _W3D_SetFogParams
	tstl d0
	seq d0
	negb d0
	unlk a5
	rts
	.even
.globl _setVertices__10RasterizerP10DrawVertex
_setVertices__10RasterizerP10DrawVertex:
	pea a5@
	movel sp,a5
	moveml #0x3020,sp@-
	movel a5@(8),a2
	movel a5@(12),d0
	movel a2@(4),d1
	jeq L1299
	clrl a2@(36)
	clrl a2@(48)
	clrl a2@(60)
	moveq #32,d2
	movel d2,a2@(40)
	movel d2,a2@(52)
	movel d2,a2@(64)
	moveq #24,d3
	addl d0,d3
	moveq #16,d2
	addl d0,d2
	clrl sp@-
	clrl sp@-
	pea 32:w
	movel d0,sp@-
	movel d1,sp@-
	jbsr _W3D_VertexPointer
	clrl sp@-
	pea -4:w
	pea 4:w
	clrl sp@-
	pea 32:w
	movel d2,sp@-
	movel a2@(4),sp@-
	jbsr _W3D_TexCoordPointer
	addw #44,sp
	clrl sp@
	pea 8:w
	movel #-2147483648,sp@-
	pea 32:w
	movel d3,sp@-
	movel a2@(4),sp@-
	jbsr _W3D_ColorPointer
	moveq #1,d0
	jra L1301
	.even
L1299:
	clrb d0
L1301:
	moveml a5@(-12),#0x40c
	unlk a5
	rts
	.even
.globl _setVertexData__10RasterizerPvQ23G3D9CoordTypeUl
_setVertexData__10RasterizerPvQ23G3D9CoordTypeUl:
	pea a5@
	movel sp,a5
	movel d2,sp@-
	movel a5@(8),a0
	movel a5@(12),a1
	movel a5@(16),d0
	movel a5@(20),d1
	tstl d0
	jeq L1304
	moveq #1,d2
	cmpl d0,d2
	jeq L1307
	jra L1310
	.even
L1304:
	movel a0@(4),d0
	jeq L1310
	clrl a0@(36)
	movel d1,a0@(40)
	clrl sp@-
	clrl sp@-
	jra L1314
	.even
L1307:
	movel a0@(4),d0
	jeq L1310
	movel a1,a0@(32)
	moveq #1,d2
	movel d2,a0@(36)
	movel d1,a0@(40)
	clrl sp@-
	pea 2:w
L1314:
	movel d1,sp@-
	movel a1,sp@-
	movel d0,sp@-
	jbsr _W3D_VertexPointer
	moveq #1,d0
	jra L1313
	.even
L1310:
	clrb d0
L1313:
	movel a5@(-4),d2
	unlk a5
	rts
	.even
.globl _setTextureData__10RasterizerPvQ23G3D12TexCoordTypeUl
_setTextureData__10RasterizerPvQ23G3D12TexCoordTypeUl:
	pea a5@
	movel sp,a5
	movel d2,sp@-
	movel a5@(8),a0
	movel a5@(12),a1
	movel a5@(16),d0
	movel a5@(20),d1
	moveq #1,d2
	cmpl d0,d2
	jeq L1338
	jlt L1349
	tstl d0
	jeq L1335
	jra L1347
	.even
L1349:
	moveq #2,d2
	cmpl d0,d2
	jeq L1344
	moveq #3,d2
	cmpl d0,d2
	jeq L1341
	jra L1347
	.even
L1335:
	movel a0@(4),d0
	jeq L1347
	movel a1,a0@(56)
	clrl a0@(60)
	movel d1,a0@(64)
	clrl sp@-
	pea -4:w
	pea 4:w
	clrl sp@-
	movel d1,sp@-
	pea a1@(4)
	jra L1352
	.even
L1338:
	movel a0@(4),d0
	jeq L1347
	movel a1,a0@(56)
	moveq #1,d2
	movel d2,a0@(60)
	movel d1,a0@(64)
	clrl sp@-
	jra L1353
	.even
L1341:
	movel a0@(4),d0
	jeq L1347
	movel a1,a0@(56)
	moveq #3,d2
	movel d2,a0@(60)
	movel d1,a0@(64)
	pea 1:w
	pea -4:w
	pea 4:w
	clrl sp@-
	movel d1,sp@-
	pea a1@(4)
	jra L1352
	.even
L1344:
	movel a0@(4),d0
	jeq L1347
	movel a1,a0@(56)
	moveq #2,d2
	movel d2,a0@(60)
	movel d1,a0@(64)
	pea 1:w
L1353:
	pea 8:w
	pea 4:w
	clrl sp@-
	movel d1,sp@-
	movel a1,sp@-
L1352:
	movel d0,sp@-
	jbsr _W3D_TexCoordPointer
	moveq #1,d0
	jra L1351
	.even
L1347:
	clrb d0
L1351:
	movel a5@(-4),d2
	unlk a5
	rts
	.even
.globl _push__10RasterizerUl
_push__10RasterizerUl:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel d2,sp@-
	movel a5@(8),a2
	movel a5@(12),d1
	movel a2@(176),d0
	moveq #30,d2
	cmpl d0,d2
	jlt L1355
	movel a2@(168),a0
	movel d1,a0@(d0:l:4)
	addql #1,a2@(176)
	btst #0,d1
	jeq L1356
	movel a2@(172),a0
	movel a2@(24),a0@
	addql #4,a2@(172)
L1356:
	btst #1,d1
	jeq L1357
	movel a2@(172),a0
	movel a2@(8),a0@
	addql #4,a2@(172)
	movel a2@(172),a0
	movel a2@(12),a0@
	addql #4,a2@(172)
	movel a2@(172),a0
	movel a2@(16),a0@
	addql #4,a2@(172)
	movel a2@(172),a0
	movel a2@(20),a0@
	addql #4,a2@(172)
L1357:
	btst #2,d1
	jeq L1358
	movel a2@(172),a1
	movel a2@(4),a0
	movel a0@(28),a1@
	addql #4,a2@(172)
L1358:
	btst #3,d1
	jeq L1359
	movel a2@(172),a0
	movel a2@(116),a0@
	addql #4,a2@(172)
L1359:
	btst #4,d1
	jeq L1360
	movel a2@(172),a0
	movel a2@(108),a0@
	addql #4,a2@(172)
	movel a2@(172),a0
	movel a2@(112),a0@
	addql #4,a2@(172)
L1360:
	btst #5,d1
	jeq L1361
	movel a2@(172),a0
	movel a2@(120),a0@
	addql #4,a2@(172)
	movel a2@(172),a0
	movel a2@(124),a0@
	addql #4,a2@(172)
	movel a2@(172),a0
	movel a2@(128),a0@
	addql #4,a2@(172)
	movel a2@(172),a0
	movel a2@(132),a0@
	addql #4,a2@(172)
	movel a2@(172),a0
	movel a2@(136),a0@
	addql #4,a2@(172)
	movel a2@(172),a0
	movel a2@(140),a0@
	addql #4,a2@(172)
L1361:
	btst #6,d1
	jeq L1362
	movel a2@(172),a0
	movel a2@(68),a0@
	addql #4,a2@(172)
L1362:
	tstb d1
	jge L1363
	movel a2@(172),a0
	movel a2@(28),a0@
	addql #4,a2@(172)
L1363:
	btst #8,d1
	jeq L1364
	movel a2@(172),a0
	movel a2@(148),a0@
	addql #4,a2@(172)
	movel a2@(172),a0
	movel a2@(152),a0@
	addql #4,a2@(172)
L1364:
	btst #9,d1
	jeq L1365
	movel a2@(172),a0
	movel a2@(144),a0@
	addql #4,a2@(172)
L1365:
	btst #10,d1
	jeq L1366
	movel a2@(172),a0
	movel a2@(76),a0@
	addql #4,a2@(172)
	movel a2@(172),a0
	movel a2@(80),a0@
	addql #4,a2@(172)
	movel a2@(172),a0
	movel a2@(84),a0@
	addql #4,a2@(172)
	movel a2@(172),a0
	movel a2@(88),a0@
	addql #4,a2@(172)
	movel a2@(172),a0
	movel a2@(92),a0@
	addql #4,a2@(172)
	movel a2@(172),a0
	movel a2@(96),a0@
	addql #4,a2@(172)
	movel a2@(172),a0
	movel a2@(100),a0@
	addql #4,a2@(172)
	movel a2@(172),a0
	movel a2@(104),a0@
	addql #4,a2@(172)
L1366:
	btst #28,d1
	jeq L1367
	movel a2@(172),a0
	movel a2@(32),a0@
	addql #4,a2@(172)
	movel a2@(172),a0
	movel a2@(36),a0@
	addql #4,a2@(172)
	movel a2@(172),a0
	movel a2@(40),a0@
	addql #4,a2@(172)
L1367:
	btst #29,d1
	jeq L1368
	movel a2@(172),a0
	movel a2@(44),a0@
	addql #4,a2@(172)
	movel a2@(172),a0
	movel a2@(48),a0@
	addql #4,a2@(172)
	movel a2@(172),a0
	movel a2@(52),a0@
	addql #4,a2@(172)
L1368:
	btst #30,d1
	jeq L1369
	movel a2@(172),a0
	movel a2@(56),a0@
	addql #4,a2@(172)
	movel a2@(172),a0
	movel a2@(60),a0@
	addql #4,a2@(172)
	movel a2@(172),a0
	movel a2@(64),a0@
	addql #4,a2@(172)
L1369:
	moveq #1,d0
	jra L1371
	.even
L1355:
	clrb d0
L1371:
	movel sp@+,d2
	movel sp@+,a2
	unlk a5
	rts
	.even
.globl _pop__10Rasterizer
_pop__10Rasterizer:
	pea a5@
	movel sp,a5
	moveml #0x3030,sp@-
	movel a5@(8),a2
	movel a2@(176),d0
	jle L1373
	movel d0,d1
	subql #1,d1
	movel d1,a2@(176)
	movel a2@(168),a0
	movel a0@(-4,d0:l:4),d2
	btst #30,d2
	jeq L1374
	movel a2@(172),a0
	lea a0@(-4),a1
	movel a1,a2@(172)
	movel a1,a0
	movel a0@,d1
	lea a0@(-4),a3
	movel a3,a2@(172)
	movel a3,a0
	movel a0@,d0
	lea a0@(-4),a1
	movel a1,a2@(172)
	movel a0@(-4),a0
	moveq #1,d3
	cmpl d0,d3
	jeq L1379
	jhi L1376
	moveq #2,d3
	cmpl d0,d3
	jeq L1385
	moveq #3,d3
	cmpl d0,d3
	jeq L1382
	jra L1374
	.even
L1376:
	movel a2@(4),d0
	jeq L1374
	movel a0,a2@(56)
	clrl a2@(60)
	movel d1,a2@(64)
	clrl sp@-
	pea -4:w
	pea 4:w
	clrl sp@-
	movel d1,sp@-
	pea a0@(4)
	jra L1449
	.even
L1379:
	movel a2@(4),d0
	jeq L1374
	movel a0,a2@(56)
	moveq #1,d3
	movel d3,a2@(60)
	movel d1,a2@(64)
	clrl sp@-
	jra L1450
	.even
L1382:
	movel a2@(4),d0
	jeq L1374
	movel a0,a2@(56)
	moveq #3,d3
	movel d3,a2@(60)
	movel d1,a2@(64)
	pea 1:w
	pea -4:w
	pea 4:w
	clrl sp@-
	movel d1,sp@-
	pea a0@(4)
	jra L1449
	.even
L1385:
	movel a2@(4),d0
	jeq L1374
	movel a0,a2@(56)
	moveq #2,d3
	movel d3,a2@(60)
	movel d1,a2@(64)
	pea 1:w
L1450:
	pea 8:w
	pea 4:w
	clrl sp@-
	movel d1,sp@-
	movel a0,sp@-
L1449:
	movel d0,sp@-
	jbsr _W3D_TexCoordPointer
	addw #28,sp
L1374:
	btst #29,d2
	jeq L1390
	movel a2@(172),a0
	lea a0@(-4),a1
	movel a1,a2@(172)
	movel a1,a0
	movel a0@,a1
	lea a0@(-4),a3
	movel a3,a2@(172)
	movel a3,a0
	movel a0@,d0
	lea a0@(-4),a3
	movel a3,a2@(172)
	movel a0@(-4),d1
	moveq #1,d3
	cmpl d0,d3
	jeq L1395
	jhi L1392
	moveq #2,d3
	cmpl d0,d3
	jeq L1398
	moveq #3,d3
	cmpl d0,d3
	jeq L1401
	jra L1390
	.even
L1392:
	movel a2@(4),d0
	jeq L1390
	movel d1,a2@(44)
	clrl a2@(48)
	movel a1,a2@(52)
	clrl sp@-
	pea 8:w
	movel #-2147483648,sp@-
	jra L1451
	.even
L1395:
	movel a2@(4),d0
	jeq L1390
	movel d1,a2@(44)
	moveq #1,d3
	movel d3,a2@(48)
	movel a1,a2@(52)
	clrl sp@-
	pea 4:w
	movel #-2147483648,sp@-
	jra L1451
	.even
L1398:
	movel a2@(4),d0
	jeq L1390
	movel d1,a2@(44)
	moveq #2,d3
	movel d3,a2@(48)
	movel a1,a2@(52)
	clrl sp@-
	pea 8:w
	jra L1452
	.even
L1401:
	movel a2@(4),d0
	jeq L1390
	movel d1,a2@(44)
	moveq #3,d3
	movel d3,a2@(48)
	movel a1,a2@(52)
	clrl sp@-
	pea 4:w
L1452:
	movel #1073741824,sp@-
L1451:
	movel a1,sp@-
	movel d1,sp@-
	movel d0,sp@-
	jbsr _W3D_ColorPointer
	addw #24,sp
L1390:
	btst #28,d2
	jeq L1406
	movel a2@(172),a0
	lea a0@(-4),a1
	movel a1,a2@(172)
	movel a1,a0
	movel a0@,d1
	lea a0@(-4),a3
	movel a3,a2@(172)
	movel a3,a0
	movel a0@,d0
	lea a0@(-4),a1
	movel a1,a2@(172)
	movel a0@(-4),a0
	moveq #1,d3
	cmpl d0,d3
	jeq L1411
	jhi L1408
	moveq #2,d3
	cmpl d0,d3
	jeq L1417
	moveq #3,d3
	cmpl d0,d3
	jeq L1414
	jra L1406
	.even
L1408:
	movel a2@(4),d0
	jeq L1406
	movel a0,a2@(56)
	clrl a2@(60)
	movel d1,a2@(64)
	clrl sp@-
	pea -4:w
	pea 4:w
	clrl sp@-
	movel d1,sp@-
	pea a0@(4)
	jra L1453
	.even
L1411:
	movel a2@(4),d0
	jeq L1406
	movel a0,a2@(56)
	moveq #1,d3
	movel d3,a2@(60)
	movel d1,a2@(64)
	clrl sp@-
	jra L1454
	.even
L1414:
	movel a2@(4),d0
	jeq L1406
	movel a0,a2@(56)
	moveq #3,d3
	movel d3,a2@(60)
	movel d1,a2@(64)
	pea 1:w
	pea -4:w
	pea 4:w
	clrl sp@-
	movel d1,sp@-
	pea a0@(4)
	jra L1453
	.even
L1417:
	movel a2@(4),d0
	jeq L1406
	movel a0,a2@(56)
	moveq #2,d3
	movel d3,a2@(60)
	movel d1,a2@(64)
	pea 1:w
L1454:
	pea 8:w
	pea 4:w
	clrl sp@-
	movel d1,sp@-
	movel a0,sp@-
L1453:
	movel d0,sp@-
	jbsr _W3D_TexCoordPointer
	addw #28,sp
L1406:
	btst #10,d2
	jeq L1422
	movel a2@(172),a0
	lea a0@(-4),a1
	movel a1,a2@(172)
	movel a1,a0
	movel a0@,a2@(104)
	lea a0@(-4),a3
	movel a3,a2@(172)
	movel a3,a0
	movel a0@,a2@(100)
	lea a0@(-4),a1
	movel a1,a2@(172)
	movel a1,a0
	movel a0@,a2@(96)
	lea a0@(-4),a3
	movel a3,a2@(172)
	movel a3,a0
	movel a0@,a2@(92)
	lea a0@(-4),a1
	movel a1,a2@(172)
	movel a1,a0
	movel a0@,a2@(88)
	lea a0@(-4),a3
	movel a3,a2@(172)
	movel a3,a0
	movel a0@,a2@(84)
	lea a0@(-4),a1
	movel a1,a2@(172)
	movel a1,a0
	movel a0@,a2@(80)
	lea a0@(-4),a3
	movel a3,a2@(172)
	movel a0@(-4),a2@(76)
	movel a2@(80),d0
	lea __6_Nat3D$fogMode,a0
	moveb a0@(d0:l),d0
	andl #0xFF,d0
	movel d0,sp@-
	pea a2@(84)
	movel a2@(4),sp@-
	jbsr _W3D_SetFogParams
	addw #12,sp
L1422:
	btst #9,d2
	jeq L1424
	movel a2@(172),a0
	lea a0@(-4),a1
	movel a1,a2@(172)
	movel a0@(-4),a2@(144)
L1424:
	btst #8,d2
	jeq L1425
	movel a2@(172),a0
	lea a0@(-4),a3
	movel a3,a2@(172)
	movel a3,a0
	movel a0@,a2@(152)
	lea a0@(-4),a1
	movel a1,a2@(172)
	movel a0@(-4),a2@(148)
	movel a2@(152),d0
	lea __6_Nat3D$blendMode,a0
	moveb a0@(d0:l),d0
	andl #0xFF,d0
	movel d0,sp@-
	movel a2@(148),d0
	moveb a0@(d0:l),d0
	andl #0xFF,d0
	movel d0,sp@-
	movel a2@(4),sp@-
	jbsr _W3D_SetBlendMode
	addw #12,sp
L1425:
	tstb d2
	jge L1428
	movel a2@(172),a0
	lea a0@(-4),a3
	movel a3,a2@(172)
	movel a0@(-4),a2@(28)
	movel a2@(28),a0
	tstl a0
	jne L1429
	clrl sp@-
	clrl sp@-
	movel a2@(4),sp@-
	jra L1455
	.even
L1429:
	movel a0@(10),d0
	cmpl a2@(4),d0
	jne L1428
	tstl a0@(14)
	jeq L1428
	movel a0@(14),sp@-
	clrl sp@-
	movel d0,sp@-
L1455:
	jbsr _W3D_BindTexture
	addw #12,sp
L1428:
	btst #6,d2
	jeq L1433
	movel a2@(172),a0
	lea a0@(-4),a1
	movel a1,a2@(172)
	movel a0@(-4),a2@(68)
L1433:
	btst #5,d2
	jeq L1434
	movel a2@(172),a0
	lea a0@(-4),a3
	movel a3,a2@(172)
	movel a3,a0
	movel a0@,a2@(140)
	lea a0@(-4),a1
	movel a1,a2@(172)
	movel a1,a0
	movel a0@,a2@(136)
	lea a0@(-4),a3
	movel a3,a2@(172)
	movel a3,a0
	movel a0@,a2@(132)
	lea a0@(-4),a1
	movel a1,a2@(172)
	movel a1,a0
	movel a0@,a2@(128)
	lea a0@(-4),a3
	movel a3,a2@(172)
	movel a3,a0
	movel a0@,a2@(124)
	lea a0@(-4),a1
	movel a1,a2@(172)
	movel a0@(-4),a2@(120)
	movel a2@(128),sp@-
	movel a2@(124),sp@-
	movel a2@(120),d0
	lea __6_Nat3D$stencilTest,a0
	moveb a0@(d0:l),d0
	andl #0xFF,d0
	movel d0,sp@-
	movel a2@(4),sp@-
	jbsr _W3D_SetStencilFunc
	movel a2@(140),d0
	addw #16,sp
	lea __6_Nat3D$stencilUpdate,a0
	moveb a0@(d0:l),d0
	andl #0xFF,d0
	movel d0,sp@-
	movel a2@(136),d0
	moveb a0@(d0:l),d0
	andl #0xFF,d0
	movel d0,sp@-
	movel a2@(132),sp@-
	movel a2@(4),sp@-
	jbsr _W3D_SetStencilOp
	addw #16,sp
L1434:
	btst #4,d2
	jeq L1438
	movel a2@(172),a0
	lea a0@(-4),a3
	movel a3,a2@(172)
	movel a3,a0
	movel a0@,a2@(112)
	lea a0@(-4),a1
	movel a1,a2@(172)
	movel a0@(-4),a2@(108)
	pea a2@(112)
	movel a2@(108),d0
	lea __6_Nat3D$alphaTest,a0
	moveb a0@(d0:l),d0
	andl #0xFF,d0
	movel d0,sp@-
	movel a2@(4),sp@-
	jbsr _W3D_SetAlphaMode
	addw #12,sp
L1438:
	btst #3,d2
	jeq L1440
	movel a2@(172),a0
	lea a0@(-4),a3
	movel a3,a2@(172)
	movel a0@(-4),a2@(116)
	movel a2@(116),d0
	lea __6_Nat3D$zBuffTest,a0
	moveb a0@(d0:l),d0
	andl #0xFF,d0
	movel d0,sp@-
	movel a2@(4),sp@-
	jbsr _W3D_SetZCompareMode
	addql #8,sp
L1440:
	btst #2,d2
	jeq L1442
	movel a2@(4),a1
	movel a2@(172),a0
	lea a0@(-4),a3
	movel a3,a2@(172)
	movel a0@(-4),a1@(28)
L1442:
	bftst d2{#30:#2}
	jeq L1443
	btst #1,d2
	jeq L1444
	movel a2@(172),a0
	lea a0@(-4),a1
	movel a1,a2@(172)
	movel a1,a0
	movel a0@,a2@(20)
	lea a0@(-4),a3
	movel a3,a2@(172)
	movel a3,a0
	movel a0@,a2@(16)
	lea a0@(-4),a1
	movel a1,a2@(172)
	movel a1,a0
	movel a0@,a2@(12)
	lea a0@(-4),a3
	movel a3,a2@(172)
	movel a0@(-4),a2@(8)
L1444:
	btst #0,d2
	jeq L1445
	movel a2@(172),a0
	lea a0@(-4),a1
	movel a1,a2@(172)
	movel a0@(-4),a2@(24)
L1445:
	pea a2@(8)
	clrl sp@-
	movel a2@(24),a0
	movel a0@(12),sp@-
	movel a2@(4),sp@-
	jbsr _W3D_SetDrawRegion
L1443:
	moveq #1,d0
	jra L1448
	.even
L1373:
	clrb d0
L1448:
	moveml a5@(-16),#0xc0c
	unlk a5
	rts
