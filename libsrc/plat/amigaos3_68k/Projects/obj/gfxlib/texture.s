#NO_APP
.text
	.even
.globl ___7Texture
___7Texture:
	pea a5@
	movel sp,a5
	movel a5@(8),a0
	clrw a0@
	clrw a0@(2)
	clrl a0@(10)
	clrl a0@(14)
	clrl a0@(18)
	clrl a0@(22)
	clrl a0@(26)
	clrl a0@(30)
	clrl a0@(34)
	moveq #1,d0
	movel d0,a0@(38)
	clrl a0@(42)
	movel a0,d0
	unlk a5
	rts
	.even
.globl __$_7Texture
__$_7Texture:
	pea a5@
	movel sp,a5
	movel d3,sp@-
	movel d2,sp@-
	movel a5@(8),d3
	movel a5@(12),d2
	movel d3,sp@-
	jbsr _destroy__7Texture
	addql #4,sp
	btst #0,d2
	jeq L1015
	movel d3,sp@-
	jbsr ___builtin_delete
L1015:
	movel a5@(-8),d2
	movel a5@(-4),d3
	unlk a5
	rts
	.even
.globl _setPalette__7TextureP7Paletteb
_setPalette__7TextureP7Paletteb:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel d2,sp@-
	movel a5@(8),a2
	movel a5@(12),d2
	tstb a5@(19)
	jeq L1017
	movel a2@(18),d0
	tstl a2@(26)
	jeq L1019
	btst #1,d0
	jne L1018
L1019:
	moveq #-3,d1
	andl d0,d1
	movel d1,a2@(18)
	clrl sp@-
	tstl d2
	seq d0
	negb d0
	subql #2,sp
	moveb d0,sp@(1)
	subql #2,sp
	pea 1024:w
	jbsr _alloc__3MemUlbQ23Mem9AlignType
	movel d0,a2@(26)
	addw #12,sp
	jne L1020
	movel #-50528257,d0
	jra L1025
	.even
L1020:
	moveq #2,d0
	orl d0,a2@(18)
L1018:
	tstl d2
	jeq L1022
	pea 1024:w
	movel d2,sp@-
	movel a2@(26),sp@-
	jbsr _copy__3MemPvPCvUl
	jra L1022
	.even
L1017:
	movel a2@(18),d0
	btst #1,d0
	jeq L1023
	moveq #-3,d1
	andl d0,d1
	movel d1,a2@(18)
	movel a2@(26),d0
	jeq L1023
	movel d0,sp@-
	jbsr _free__3MemPv
L1023:
	movel d2,a2@(26)
L1022:
	clrl d0
L1025:
	movel a5@(-8),d2
	movel a5@(-4),a2
	unlk a5
	rts
	.even
.globl _create__7TexturessQ23G3D5TexelP7Paletteb
_create__7TexturessQ23G3D5TexelP7Paletteb:
	pea a5@
	movel sp,a5
	moveml #0x3820,sp@-
	movel a5@(8),a2
	movel a5@(20),d4
	movew a5@(14),d2
	movew a5@(18),d3
	tstl a2@(22)
	jne L1028
	tstl a2@(14)
	jeq L1027
L1028:
	movel #-50659332,d0
	jra L1048
	.even
L1027:
	cmpw #1,d2
	jle L1044
	cmpw #1,d3
	jle L1044
	cmpw #512,d2
	jgt L1044
	cmpw #512,d3
	jgt L1044
	moveq #10,d0
	cmpl d4,d0
	jcs L1044
LI1045:
	movew pc@(L1045-LI1045-2:b,d4:l:2),d0
	jmp pc@(2,d0:w)
	.even
L1045:
	.word L1032-L1045
	.word L1036-L1045
	.word L1036-L1045
	.word L1036-L1045
	.word L1040-L1045
	.word L1040-L1045
	.word L1040-L1045
	.word L1040-L1045
	.word L1041-L1045
	.word L1043-L1045
	.word L1043-L1045
	.even
L1032:
	subql #2,sp
	moveb a5@(31),sp@(1)
	subql #2,sp
	movel a5@(24),sp@-
	movel a2,sp@-
	jbsr _setPalette__7TextureP7Paletteb
	addw #12,sp
	tstl d0
	jeq L1036
	movel #-50659336,d0
	jra L1048
	.even
L1036:
	moveq #1,d1
	jra L1031
	.even
L1040:
	moveq #2,d1
	jra L1031
	.even
L1041:
	moveq #3,d1
	jra L1031
	.even
L1043:
	moveq #4,d1
	jra L1031
	.even
L1044:
	movel #-50397185,d0
	jra L1048
	.even
L1031:
	pea 16:w
	subql #2,sp
	moveb #0,sp@(1)
	subql #2,sp
	movew d2,d0
	muls d3,d0
	mulsl d1,d0
	movel d0,sp@-
	jbsr _alloc__3MemUlbQ23Mem9AlignType
	movel d0,a2@(22)
	jeq L1046
	moveq #1,d0
	orl d0,a2@(18)
	movel d4,a2@(30)
	movew d2,a2@
	movew d3,a2@(2)
	clrl d0
	jra L1048
	.even
L1046:
	movel #-50528257,d0
L1048:
	moveml a5@(-16),#0x41c
	unlk a5
	rts
	.even
.globl _destroy__7Texture
_destroy__7Texture:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel a5@(8),a2
	movel a2,sp@-
	jbsr _disassociate__7Texture
	addql #4,sp
	movel a2@(22),d0
	jeq L1050
	btst #0,a2@(21)
	jeq L1050
	movel d0,sp@-
	jbsr _free__3MemPv
	addql #4,sp
L1050:
	movel a2@(26),d0
	jeq L1051
	btst #1,a2@(21)
	jeq L1051
	movel d0,sp@-
	jbsr _free__3MemPv
L1051:
	clrl a2@(18)
	clrl a2@(22)
	clrl a2@(26)
	clrl a2@(30)
	movel a5@(-4),a2
	unlk a5
	rts
	.even
.globl _convertImageBuffer__7TextureP11ImageBufferQ27Texture6IBConv
_convertImageBuffer__7TextureP11ImageBufferQ27Texture6IBConv:
	link a5,#-80
	fmovem #0xfc,sp@-
	moveml #0x3f3a,sp@-
	jbsr ___get_eh_context
	movel d0,a5@(-76)
	tstl a5@(8)
	jne L1054
L1230:
	clrl d0
	jra L1188
	.even
L1054:
	movel a5@(8),a0
	tstl a0@(8)
	jne L1055
	moveq #3,d0
	cmpl a5@(12),d0
	jne L1230
	movel a0,sp@-
	jbsr _destroy__11ImageBuffer
	movel a5@(8),sp@
	jbsr ___builtin_delete
	jra L1230
	.even
L1055:
	movel a5@(8),a0
	movew a0@,d2
	extl d2
	clrl d1
	clrl d3
	.even
L1069:
	btst d3,d2
	jeq L1211
	addql #1,d1
L1211:
	moveq #1,d0
	cmpl d1,d0
	jge L1209
	moveq #3,d1
	cmpl a5@(12),d1
	jne L1230
	tstl a5@(8)
	jeq L1230
	movel a5@(8),sp@-
	jbsr _destroy__11ImageBuffer
	movel a5@(8),sp@
	jbsr ___builtin_delete
	jra L1230
	.even
L1209:
	moveq #30,d0
	subl d3,d0
	bftst d2{d0:#1}
	jeq L1216
	addql #1,d1
L1216:
	moveq #1,d0
	cmpl d1,d0
	jge L1214
	moveq #3,d1
	cmpl a5@(12),d1
	jne L1230
	tstl a5@(8)
	jeq L1230
	movel a5@(8),sp@-
	jbsr _destroy__11ImageBuffer
	movel a5@(8),sp@
	jbsr ___builtin_delete
	jra L1230
	.even
L1214:
	moveq #29,d0
	subl d3,d0
	bftst d2{d0:#1}
	jeq L1221
	addql #1,d1
L1221:
	moveq #1,d0
	cmpl d1,d0
	jge L1219
	moveq #3,d1
	cmpl a5@(12),d1
	jne L1230
	tstl a5@(8)
	jeq L1230
	movel a5@(8),sp@-
	jbsr _destroy__11ImageBuffer
	movel a5@(8),sp@
	jbsr ___builtin_delete
	jra L1230
	.even
L1219:
	moveq #28,d0
	subl d3,d0
	bftst d2{d0:#1}
	jeq L1226
	addql #1,d1
L1226:
	moveq #1,d0
	cmpl d1,d0
	jge L1224
	moveq #3,d1
	cmpl a5@(12),d1
	jne L1230
	tstl a5@(8)
	jeq L1230
	movel a5@(8),sp@-
	jbsr _destroy__11ImageBuffer
	movel a5@(8),sp@
	jbsr ___builtin_delete
	jra L1230
	.even
L1224:
	addql #4,d3
	moveq #15,d0
	cmpl d3,d0
	jge L1069
	movel a5@(8),a0
	movew a0@(2),d2
	extl d2
	clrl d1
	clrl d3
	.even
L1084:
	btst d3,d2
	jeq L1191
	addql #1,d1
L1191:
	moveq #1,d0
	cmpl d1,d0
	jge L1189
	moveq #3,d1
	cmpl a5@(12),d1
	jne L1230
	tstl a5@(8)
	jeq L1230
	movel a5@(8),sp@-
	jbsr _destroy__11ImageBuffer
	movel a5@(8),sp@
	jbsr ___builtin_delete
	jra L1230
	.even
L1189:
	moveq #30,d0
	subl d3,d0
	bftst d2{d0:#1}
	jeq L1196
	addql #1,d1
L1196:
	moveq #1,d0
	cmpl d1,d0
	jge L1194
	moveq #3,d1
	cmpl a5@(12),d1
	jne L1230
	tstl a5@(8)
	jeq L1230
	movel a5@(8),sp@-
	jbsr _destroy__11ImageBuffer
	movel a5@(8),sp@
	jbsr ___builtin_delete
	jra L1230
	.even
L1194:
	moveq #29,d0
	subl d3,d0
	bftst d2{d0:#1}
	jeq L1201
	addql #1,d1
L1201:
	moveq #1,d0
	cmpl d1,d0
	jge L1199
	moveq #3,d1
	cmpl a5@(12),d1
	jne L1230
	tstl a5@(8)
	jeq L1230
	movel a5@(8),sp@-
	jbsr _destroy__11ImageBuffer
	movel a5@(8),sp@
	jbsr ___builtin_delete
	jra L1230
	.even
L1199:
	moveq #28,d0
	subl d3,d0
	bftst d2{d0:#1}
	jeq L1206
	addql #1,d1
L1206:
	moveq #1,d0
	cmpl d1,d0
	jge L1204
	moveq #3,d1
	cmpl a5@(12),d1
	jne L1230
	tstl a5@(8)
	jeq L1230
	movel a5@(8),sp@-
	jbsr _destroy__11ImageBuffer
	movel a5@(8),sp@
	jbsr ___builtin_delete
	jra L1230
	.even
L1204:
	addql #4,d3
	moveq #15,d0
	cmpl d3,d0
	jge L1084
	clrb a5@(-53)
	movel a5@(8),a0
	movel a0@(20),d0
	moveq #14,d1
	cmpl d0,d1
	jcs L1106
LI1114:
	movew pc@(L1114-LI1114-2:b,d0:l:2),d0
	jmp pc@(2,d0:w)
	.even
L1114:
	.word L1096-L1114
	.word L1098-L1114
	.word L1106-L1114
	.word L1097-L1114
	.word L1106-L1114
	.word L1100-L1114
	.word L1106-L1114
	.word L1099-L1114
	.word L1106-L1114
	.word L1101-L1114
	.word L1106-L1114
	.word L1103-L1114
	.word L1104-L1114
	.word L1102-L1114
	.word L1105-L1114
	.even
L1096:
	clrl a5@(-52)
	jra L1095
	.even
L1097:
	moveb #1,a5@(-53)
L1098:
	movew #5,a0
	movel a0,a5@(-52)
	jra L1095
	.even
L1099:
	moveb #1,a5@(-53)
L1100:
	movew #4,a1
	movel a1,a5@(-52)
	jra L1095
	.even
L1101:
	moveq #8,d0
	movel d0,a5@(-52)
	jra L1095
	.even
L1102:
	moveb #1,a5@(-53)
L1103:
	moveq #9,d1
	movel d1,a5@(-52)
	jra L1095
	.even
L1104:
	moveb #1,a5@(-53)
L1105:
	movew #10,a0
	movel a0,a5@(-52)
	jra L1095
	.even
L1106:
	moveq #3,d0
	cmpl a5@(12),d0
	jne L1230
	tstl a5@(8)
	jeq L1230
	movel a5@(8),sp@-
	jbsr _destroy__11ImageBuffer
	movel a5@(8),sp@
	jbsr ___builtin_delete
	jra L1230
	.even
L1095:
	pea 46:w
	jbsr ___builtin_new
	movel d0,a5@(-58)
	moveb #1,a5@(-59)
	movel a5@(-76),a0
	addql #4,a0
	movel a0@,a5@(-24)
	clrl a5@(-20)
	movel a5,a5@(-16)
	movel #L1119,a5@(-12)
	movel sp,a5@(-8)
	movel a0,a5@(-80)
	jra L1118
	.even
L1119:
	movel a5@(-76),a0
	addql #4,a0
	movel a0,a5@(-80)
	jra L1116
	.even
L1118:
	lea a5@(-24),a1
	movel a1,a0@
	movel a5@(-58),sp@-
	jbsr ___7Texture
	movel d0,a5@(-64)
	clrb a5@(-59)
	movel a5@(-80),a1
	movel a1@,a0
	movel a0@,a1@
	addql #8,sp
	tstl a5@(-64)
	jne L1122
	moveq #3,d0
	cmpl a5@(12),d0
	jne L1230
	tstl a5@(8)
	jeq L1230
	movel a5@(8),sp@-
	jbsr _destroy__11ImageBuffer
	movel a5@(8),sp@
	jbsr ___builtin_delete
	jra L1230
	.even
L1122:
	tstl a5@(12)
	jne L1130
	subql #2,sp
	moveb #1,sp@(1)
	subql #2,sp
	movel a5@(8),a0
	movel a0@(12),sp@-
	movel a5@(-52),sp@-
	movew a0@(2),a1
	movel a1,sp@-
	movew a0@,a0
	movel a0,sp@-
	movel a5@(-64),sp@-
	jbsr _create__7TexturessQ23G3D5TexelP7Paletteb
	addw #24,sp
	tstl d0
	jeq L1131
	pea 3:w
	movel a5@(-64),sp@-
	jbsr __$_7Texture
	jra L1230
	.even
L1131:
	movel a5@(-64),a1
	movel a1@(22),a5@(-72)
	movel a5@(8),a0
	movel a0@(8),a5@(-68)
	jra L1139
	.even
L1130:
	movel a5@(-64),a1
	movel a5@(8),a0
	movew a0@,a1@
	movew a0@(2),a1@(2)
	movel a5@(-52),a1@(30)
	clrb d0
	tstl a0
	jeq L1144
	btst #0,a0@(7)
	sne d0
	negb d0
L1144:
	tstb d0
	sne d0
	extbl d0
	negl d0
	clrb d1
	tstl a5@(8)
	jeq L1148
	movel a5@(8),a1
	btst #1,a1@(7)
	sne d1
	negb d1
L1148:
	tstb d1
	jeq L1146
	moveq #2,d1
	orl d1,d0
L1146:
	movel a5@(-64),a0
	movel d0,a0@(18)
	movel a5@(8),a1
	movel a1@(8),d0
	movel d0,a0@(22)
	movel a1@(12),a0@(26)
	movel d0,a5@(-72)
	movel d0,a5@(-68)
	tstl a1
	jeq L1159
	btst #2,a1@(7)
	sne d0
	negb d0
	tstl a1
	jeq L1159
	tstb d0
	sne d0
	moveq #4,d1
	andl d0,d1
	movel d1,a1@(4)
L1159:
	subql #2,sp
	moveb #0,sp@(1)
	subql #2,sp
	clrl sp@-
	movel a5@(8),sp@-
	jbsr _setIBData__19ImageBufferProviderP11ImageBufferPvb
	subql #2,sp
	moveb #0,sp@(1)
	subql #2,sp
	clrl sp@-
	movel a5@(8),sp@-
	jbsr _setIBPalette__19ImageBufferProviderP11ImageBufferP7Paletteb
	addw #24,sp
L1139:
	tstb a5@(-53)
	jeq L1160
	moveq #4,d0
	cmpl a5@(-52),d0
	jgt L1160
	moveq #6,d1
	cmpl a5@(-52),d1
	jlt L1164
	movel a5@(-64),a0
	movew a0@,d0
	muls a0@(2),d0
	lsrl #1,d0
	movel d0,sp@-
	movel a5@(-68),sp@-
	movel a5@(-72),sp@-
	jbsr _swap16__3MemPvPCvUl
	jra L1231
	.even
L1164:
	moveq #10,d0
	cmpl a5@(-52),d0
	jlt L1160
	moveq #9,d1
	cmpl a5@(-52),d1
	jgt L1160
	movel a5@(-64),a0
	movew a0@,d0
	muls a0@(2),d0
	lsrl #2,d0
	movel d0,sp@-
	movel a5@(-68),sp@-
	movel a5@(-72),sp@-
	jbsr _swap32__3MemPvPCvUl
L1231:
	addw #12,sp
L1160:
	moveq #1,d0
	cmpl a5@(12),d0
	jne L1170
	movel a5@(8),sp@-
	jbsr _destroy__11ImageBuffer
	jra L1169
	.even
L1170:
	moveq #1,d1
	cmpl a5@(12),d1
	jgt L1169
	moveq #3,d0
	cmpl a5@(12),d0
	jlt L1169
	tstl a5@(8)
	jeq L1169
	movel a5@(8),sp@-
	jbsr _destroy__11ImageBuffer
	movel a5@(8),sp@
	jbsr ___builtin_delete
L1169:
	movel a5@(-64),d0
	jra L1188
	.even
L1116:
	movel a5@(-80),a0
	movel a0@,a5@(-48)
	clrl a5@(-44)
	movel a5,a5@(-40)
	movel #L1184,a5@(-36)
	movel sp,a5@(-32)
	jra L1183
	.even
L1184:
	jra L1232
	.even
L1183:
	lea a5@(-48),a0
	movel a5@(-80),a1
	movel a0,a1@
	tstb a5@(-59)
	jeq L1186
	movel a5@(-58),sp@-
	jbsr ___builtin_delete
	addql #4,sp
L1186:
	movel a5@(-76),a1
	addql #4,a1
	movel a1@,a0
	movel a0@,a1@
	jbsr ___sjthrow
	.even
L1232:
L1181:
	jbsr ___terminate
	.even
L1188:
	moveml a5@(-192),#0x5cfc
	fmovem a5@(-152),#0x3f
	unlk a5
	rts
	.even
.globl _associate__7TextureP10Rasterizer
_associate__7TextureP10Rasterizer:
	link a5,#-100
	movel a2,sp@-
	movel a5@(8),a2
	movel a5@(12),a0
	tstl a2@(14)
	jeq L1234
	movel #-50659332,d0
	jra L1246
	.even
L1234:
	movel a2@(22),d1
	jeq L1247
	tstl a0
	jeq L1247
	movel a0@(4),d0
	movel d0,a2@(10)
	jeq L1247
	movel #-2145382400,a5@(-96)
	movel d1,a5@(-92)
	movel #-2145382399,a5@(-88)
	movel a2@(30),d0
	lea __6_Nat3D$texel,a0
	clrl d1
	moveb a0@(d0:l),d1
	movel d1,a5@(-84)
	movel #-2145382398,a5@(-80)
	movew a2@,a0
	movel a0,a5@(-76)
	movel #-2145382397,a5@(-72)
	movew a2@(2),a0
	movel a0,a5@(-68)
	clrl a5@(-64)
	clrl a5@(-60)
	clrl a5@(-56)
	clrl a5@(-52)
	movel a5@(-96),a5@(-48)
	movel a5@(-92),a5@(-44)
	movel a5@(-88),a5@(-40)
	movel d1,a5@(-36)
	movel a5@(-80),a5@(-32)
	movel a5@(-76),a5@(-28)
	movel a5@(-72),a5@(-24)
	movel a0,a5@(-20)
	movel a5@(-64),a5@(-16)
	movel a5@(-60),a5@(-12)
	movel a5@(-56),a5@(-8)
	movel a5@(-52),a5@(-4)
	tstl d0
	jne L1239
	movel a2@(26),d0
	jne L1240
L1247:
	movel #-50659336,d0
	jra L1246
	.even
L1240:
	movel #-2145382395,a5@(-16)
	movel d0,a5@(-12)
L1239:
	clrl a5@(-100)
	pea a5@(-48)
	pea a5@(-100)
	movel a2@(10),sp@-
	jbsr _W3D_AllocTexObj
	movel d0,d1
	movel d1,a2@(14)
	addw #12,sp
	jeq L1242
	clrl sp@-
	movel a2@(42),d0
	lea __6_Nat3D$texEnv,a0
	moveb a0@(d0:l),d0
	andl #0xFF,d0
	movel d0,sp@-
	movel d1,sp@-
	movel a2@(10),sp@-
	jbsr _W3D_SetTexEnv
	movel a2@(34),d0
	addw #16,sp
	lea __6_Nat3D$texFilter,a0
	moveb a0@(d0:l),d0
	andl #0xFF,d0
	movel d0,sp@-
	movel a2@(38),d0
	moveb a0@(d0:l),d0
	andl #0xFF,d0
	movel d0,sp@-
	movel a2@(14),sp@-
	movel a2@(10),sp@-
	jbsr _W3D_SetFilter
	clrl d0
	jra L1246
	.even
L1242:
	clrl a2@(10)
	movel #-50659328,d0
L1246:
	movel a5@(-104),a2
	unlk a5
	rts
	.even
.globl _disassociate__7Texture
_disassociate__7Texture:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel a5@(8),a2
	movel a2@(10),d1
	jeq L1249
	movel a2@(14),d0
	jeq L1249
	movel d0,sp@-
	movel d1,sp@-
	jbsr _W3D_FreeTexObj
	clrl a2@(10)
	clrl a2@(14)
L1249:
	movel a5@(-4),a2
	unlk a5
	rts
