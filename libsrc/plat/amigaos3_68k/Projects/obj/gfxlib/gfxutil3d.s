#NO_APP
.text
LC0:
	.ascii "P6\12%ld\12%ld\12"
	.ascii "255\12\0"
	.even
.globl _loadPPM__13TextureLoaderP7TexturePCcQ23G3D5Texel
_loadPPM__13TextureLoaderP7TexturePCcQ23G3D5Texel:
	link a5,#-284
	moveml #0x3c3a,sp@-
	movel a5@(8),a4
	movel a5@(12),d3
	movel a5@(16),d4
	jbsr ___get_eh_context
	movel d0,d1
	movel d1,d2
	tstl a4
	jeq L1132
	tstl d3
	jne L1131
L1132:
	movel #-50462722,d0
	jra L1268
	.even
L1131:
	tstl a4@(22)
	jeq L1133
	movel #-50659332,d0
	jra L1268
	.even
L1133:
	tstl d4
	jlt L1135
	moveq #3,d0
	cmpl d4,d0
	jge L1140
	moveq #7,d0
	cmpl d4,d0
	jne L1135
L1140:
	movel #-50659331,d0
	jra L1268
	.even
L1135:
	movel d1,d0
	clrl a5@(-138)
	clrl a5@(-110)
	clrl a5@(-122)
	movel d1,a0
	addql #4,a0
	movel a0@,a5@(-176)
	clrl a5@(-172)
	lea a5@(-152),a1
	movel a1,a5@(-168)
	movel #L1147,a5@(-164)
	movel sp,a5@(-160)
L1147:
	lea a5@(-176),a1
	movel a1,a0@
	movel d2,a1
	addql #4,a1
	movel a1@,a0
	movel a0@,a1@
	movel d1,a2
	addql #4,a2
	movel a2@,a0
	addql #4,a0
	movel a0@,a5@(-212)
	movel #__$_8StreamIn,a5@(-208)
	movel a5,d2
	addl #-152,d2
	movel d2,a5@(-204)
	lea a5@(-212),a1
	movel a1,a0@
	pea 2048:w
	subql #2,sp
	moveb #0,sp@(1)
	subql #2,sp
	movel d3,sp@-
	movel d2,sp@-
	jbsr _open__8StreamInPCcbUl
	movel d0,d3
	addw #16,sp
	movel a2,a3
	movel d2,d5
	tstl d3
	jne L1269
	pea 4:w
	pea 10:w
	pea 63:w
	movel a5,d2
	addl #-276,d2
	movel d2,sp@-
	movel d5,sp@-
	jbsr _readText__8StreamInPclcl
	movel d0,d3
	addw #20,sp
	jlt L1269
	pea a5@(-280)
	pea a5@(-284)
	pea LC0
	movel d2,sp@-
	jbsr _sscanf
	addw #16,sp
	moveq #2,d1
	cmpl d0,d1
	jeq L1160
	movel a3@,a1
	addql #4,a1
	movel a1@,a0
	movel a0@,a1@
	pea 2:w
	movel d5,sp@-
	jbsr __$_8StreamIn
	movel #-50593796,d0
	jra L1268
	.even
L1160:
	movel a5@(-284),d0
	subql #2,d0
	cmpl #510,d0
	jhi L1265
	movel a5@(-280),d0
	moveq #1,d1
	cmpl d0,d1
	jge L1265
	cmpl #512,d0
	jgt L1265
	subql #2,sp
	moveb #0,sp@(1)
	subql #2,sp
	clrl sp@-
	movel d4,sp@-
	movew a5@(-278),a0
	movel a0,sp@-
	movew a5@(-282),a1
	movel a1,sp@-
	movel a4,sp@-
	jbsr _create__7TexturessQ23G3D5TexelP7Paletteb
	movel d0,d3
	addw #24,sp
	jne L1269
	movel a5@(-284),d0
	mulsl a5@(-280),d0
	movel d0,a2
	movel d4,d0
	subql #4,d0
	moveq #6,d1
	cmpl d0,d1
	jcs L1265
LI1266:
	movew pc@(L1266-LI1266-2:b,d0:l:2),d0
	jmp pc@(2,d0:w)
	.even
L1266:
	.word L1165-L1266
	.word L1184-L1266
	.word L1203-L1266
	.word L1265-L1266
	.word L1222-L1266
	.word L1227-L1266
	.word L1246-L1266
	.even
L1165:
	movel a4@(22),a4
	lea __$_8StreamIn,a6
	tstl a2
	jeq L1264
	btst #1,a5@(-135)
	jne L1168
	clrl d4
	clrw d2
	.even
L1169:
	tstl a5@(-126)
	jne L1173
	pea a5@(-152)
	jbsr _processIO__8StreamIn
	addql #4,sp
	tstl d0
	jne L1174
L1173:
	subql #1,a5@(-126)
	movel a5@(-114),a0
	lea a0@(1),a1
	movel a1,a5@(-114)
	moveb a0@,d4
	movel d4,d0
L1174:
	andb #248,d0
	moveb d0,d2
	movew d2,d3
	lslw #8,d3
	tstl a5@(-126)
	jne L1176
	pea a5@(-152)
	jbsr _processIO__8StreamIn
	addql #4,sp
	tstl d0
	jne L1177
L1176:
	subql #1,a5@(-126)
	movel a5@(-114),a0
	lea a0@(1),a1
	movel a1,a5@(-114)
	clrl d0
	moveb a0@,d0
L1177:
	andw #252,d0
	lslw #3,d0
	orw d0,d3
	tstl a5@(-126)
	jne L1179
	pea a5@(-152)
	jbsr _processIO__8StreamIn
	addql #4,sp
	tstl d0
	jne L1180
L1179:
	subql #1,a5@(-126)
	movel a5@(-114),a0
	lea a0@(1),a1
	movel a1,a5@(-114)
	clrl d0
	moveb a0@,d0
L1180:
	bfextu d0{#24:#5},d0
	orw d0,d3
	movew d3,a4@+
	subql #1,a2
	tstl a2
	jeq L1264
	btst #1,a5@(-135)
	jeq L1169
L1168:
	tstl a2
	jne L1270
	jra L1264
	.even
L1184:
	movel a4@(22),a4
	lea __$_8StreamIn,a6
	tstl a2
	jeq L1264
	btst #1,a5@(-135)
	jne L1168
	clrl d3
	clrw d4
	.even
L1188:
	tstl a5@(-126)
	jne L1192
	pea a5@(-152)
	jbsr _processIO__8StreamIn
	addql #4,sp
	tstl d0
	jne L1193
L1192:
	subql #1,a5@(-126)
	movel a5@(-114),a0
	lea a0@(1),a1
	movel a1,a5@(-114)
	moveb a0@,d3
	movel d3,d0
L1193:
	andb #248,d0
	moveb d0,d4
	movew d4,d2
	lslw #7,d2
	orw #-32768,d2
	tstl a5@(-126)
	jne L1195
	pea a5@(-152)
	jbsr _processIO__8StreamIn
	addql #4,sp
	tstl d0
	jne L1196
L1195:
	subql #1,a5@(-126)
	movel a5@(-114),a0
	lea a0@(1),a1
	movel a1,a5@(-114)
	clrl d0
	moveb a0@,d0
L1196:
	andw #248,d0
	lslw #2,d0
	orw d0,d2
	tstl a5@(-126)
	jne L1198
	pea a5@(-152)
	jbsr _processIO__8StreamIn
	addql #4,sp
	tstl d0
	jne L1199
L1198:
	subql #1,a5@(-126)
	movel a5@(-114),a0
	lea a0@(1),a1
	movel a1,a5@(-114)
	clrl d0
	moveb a0@,d0
L1199:
	bfextu d0{#24:#5},d0
	orw d0,d2
	movew d2,a4@+
	subql #1,a2
	tstl a2
	jeq L1264
	btst #1,a5@(-135)
	jeq L1188
	jra L1168
	.even
L1203:
	movel a4@(22),a4
	lea __$_8StreamIn,a6
	tstl a2
	jeq L1264
	btst #1,a5@(-135)
	jne L1168
	clrl d3
	clrw d4
	.even
L1207:
	tstl a5@(-126)
	jne L1211
	pea a5@(-152)
	jbsr _processIO__8StreamIn
	addql #4,sp
	tstl d0
	jne L1212
L1211:
	subql #1,a5@(-126)
	movel a5@(-114),a0
	lea a0@(1),a1
	movel a1,a5@(-114)
	moveb a0@,d3
	movel d3,d0
L1212:
	andb #240,d0
	moveb d0,d4
	movew d4,d2
	lslw #4,d2
	orw #-4096,d2
	tstl a5@(-126)
	jne L1214
	pea a5@(-152)
	jbsr _processIO__8StreamIn
	addql #4,sp
	tstl d0
	jne L1215
L1214:
	subql #1,a5@(-126)
	movel a5@(-114),a0
	lea a0@(1),a1
	movel a1,a5@(-114)
	clrl d0
	moveb a0@,d0
L1215:
	andw #240,d0
	orw d0,d2
	tstl a5@(-126)
	jne L1217
	pea a5@(-152)
	jbsr _processIO__8StreamIn
	addql #4,sp
	tstl d0
	jne L1218
L1217:
	subql #1,a5@(-126)
	movel a5@(-114),a0
	lea a0@(1),a1
	movel a1,a5@(-114)
	clrl d0
	moveb a0@,d0
L1218:
	bfextu d0{#24:#4},d0
	orw d0,d2
	movew d2,a4@+
	subql #1,a2
	tstl a2
	jeq L1264
	btst #1,a5@(-135)
	jeq L1207
	jra L1168
	.even
L1222:
	lea a2@(a2:l:2),a2
	movel a2,sp@-
	movel a4@(22),sp@-
	pea a5@(-152)
	jbsr _readBytes__8StreamInPvUl
	movel d0,d3
	addw #12,sp
	jge L1225
L1269:
	movel a3@,a1
	addql #4,a1
	movel a1@,a0
	movel a0@,a1@
	pea 2:w
	movel d5,sp@-
	jbsr __$_8StreamIn
	movel d3,d0
	jra L1268
	.even
L1225:
	cmpl d3,a2
	jne L1226
	movel a3@,a1
	addql #4,a1
	movel a1@,a0
	movel a0@,a1@
	pea 2:w
	movel d5,sp@-
	jbsr __$_8StreamIn
	clrl d0
	jra L1268
	.even
L1226:
	movel a3@,a1
	addql #4,a1
	movel a1@,a0
	movel a0@,a1@
	pea 2:w
	movel d5,sp@-
	jbsr __$_8StreamIn
	movel #-33816580,d0
	jra L1268
	.even
L1227:
	movel a4@(22),a4
	lea __$_8StreamIn,a6
	tstl a2
	jeq L1264
	btst #1,a5@(-135)
	jne L1168
	clrl d3
	clrl d4
	.even
L1231:
	tstl a5@(-126)
	jne L1235
	pea a5@(-152)
	jbsr _processIO__8StreamIn
	addql #4,sp
	tstl d0
	jne L1236
L1235:
	subql #1,a5@(-126)
	movel a5@(-114),a0
	lea a0@(1),a1
	movel a1,a5@(-114)
	moveb a0@,d3
	movel d3,d0
L1236:
	moveb d0,d4
	movel d4,d2
	swap d2
	clrw d2
	orl #-16777216,d2
	tstl a5@(-126)
	jne L1238
	pea a5@(-152)
	jbsr _processIO__8StreamIn
	addql #4,sp
	tstl d0
	jne L1239
L1238:
	subql #1,a5@(-126)
	movel a5@(-114),a0
	lea a0@(1),a1
	movel a1,a5@(-114)
	clrl d0
	moveb a0@,d0
L1239:
	andl #0xFF,d0
	lsll #8,d0
	orl d0,d2
	tstl a5@(-126)
	jne L1241
	pea a5@(-152)
	jbsr _processIO__8StreamIn
	addql #4,sp
	tstl d0
	jne L1242
L1241:
	subql #1,a5@(-126)
	movel a5@(-114),a0
	lea a0@(1),a1
	movel a1,a5@(-114)
	clrl d0
	moveb a0@,d0
L1242:
	orb d0,d2
	movel d2,a4@+
	subql #1,a2
	tstl a2
	jeq L1264
	btst #1,a5@(-135)
	jeq L1231
	jra L1168
	.even
L1246:
	movel a4@(22),a4
	lea __$_8StreamIn,a6
	tstl a2
	jeq L1264
	btst #1,a5@(-135)
	jne L1249
	clrl d3
	clrl d4
	.even
L1250:
	tstl a5@(-126)
	jne L1254
	pea a5@(-152)
	jbsr _processIO__8StreamIn
	addql #4,sp
	tstl d0
	jne L1255
L1254:
	subql #1,a5@(-126)
	movel a5@(-114),a0
	lea a0@(1),a1
	movel a1,a5@(-114)
	moveb a0@,d3
	movel d3,d0
L1255:
	moveb d0,d4
	movel d4,d2
	moveq #24,d0
	lsll d0,d2
	moveq #0,d1
	notb d1
	orl d1,d2
	tstl a5@(-126)
	jne L1257
	pea a5@(-152)
	jbsr _processIO__8StreamIn
	addql #4,sp
	tstl d0
	jne L1258
L1257:
	subql #1,a5@(-126)
	movel a5@(-114),a0
	lea a0@(1),a1
	movel a1,a5@(-114)
	clrl d0
	moveb a0@,d0
L1258:
	andl #0xFF,d0
	swap d0
	clrw d0
	orl d0,d2
	tstl a5@(-126)
	jne L1260
	pea a5@(-152)
	jbsr _processIO__8StreamIn
	addql #4,sp
	tstl d0
	jne L1261
L1260:
	subql #1,a5@(-126)
	movel a5@(-114),a0
	lea a0@(1),a1
	movel a1,a5@(-114)
	clrl d0
	moveb a0@,d0
L1261:
	andl #0xFF,d0
	lsll #8,d0
	orl d0,d2
	movel d2,a4@+
	subql #1,a2
	tstl a2
	jeq L1264
	btst #1,a5@(-135)
	jeq L1250
L1249:
	tstl a2
	jeq L1264
L1270:
	movel a3@,a1
	addql #4,a1
	movel a1@,a0
	movel a0@,a1@
	pea 2:w
	movel d5,sp@-
	jbsr a6@
	movel #-33816580,d0
	jra L1268
	.even
L1264:
	movel a3@,a1
	addql #4,a1
	movel a1@,a0
	movel a0@,a1@
	pea 2:w
	movel d5,sp@-
	jbsr a6@
	clrl d0
	jra L1268
	.even
L1265:
	movel a3@,a1
	addql #4,a1
	movel a1@,a0
	movel a0@,a1@
	pea 2:w
	movel d5,sp@-
	jbsr __$_8StreamIn
	movel #-50397184,d0
L1268:
	moveml a5@(-316),#0x5c3c
	unlk a5
	rts
	.even
.globl _loadPPMPGM__13TextureLoaderP7TexturePCcT2Q23G3D5Texel
_loadPPMPGM__13TextureLoaderP7TexturePCcT2Q23G3D5Texel:
	pea a5@
	movel sp,a5
	clrl d0
	unlk a5
	rts
