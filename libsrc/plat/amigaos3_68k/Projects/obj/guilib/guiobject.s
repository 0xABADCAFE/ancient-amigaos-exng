#NO_APP
.globl __9GUIObject$nextID
.data
	.even
__9GUIObject$nextID:
	.long 0
.text
	.even
.globl ___9GUIObject
___9GUIObject:
	link a5,#-208
	fmovem #0xfc,sp@-
	moveml #0x3f3a,sp@-
	jbsr ___get_eh_context
	movel d0,a5@(-204)
	movel d0,a5@(-196)
	movel a5@(8),a0
	clrw a0@
	clrw a0@(2)
	clrw a0@(4)
	clrw a0@(6)
	movel #___vt_9GUIObject,a0@(68)
	movel a5@(-204),d0
	pea a0@(12)
	jbsr ___7_LLBase
	movel a5@(-204),a0
	addql #4,a0
	movel a0@,a5@(-24)
	clrl a5@(-20)
	movel a5,a5@(-16)
	movel #L1117,a5@(-12)
	movel sp,a5@(-8)
	movel a0,a5@(-208)
L1117:
	lea a5@(-24),a1
	movel a1,a0@
	addql #4,sp
	movel a5@(-204),a1
	addql #4,a1
	movel a1@,a0
	movel a0@,a1@
	movel a5@(-208),a2
	movel a2@,a5@(-72)
	clrl a5@(-68)
	movel a5,a5@(-64)
	movel #L1129,a5@(-60)
	movel sp,a5@(-56)
	jra L1128
	.even
L1129:
	movel a5@(-204),a0
	addql #4,a0
	movel a0,a5@(-208)
	jra L1126
	.even
L1128:
	lea a5@(-72),a1
	movel a1,a5@(-200)
	movel a5@(-208),a2
	movel a1,a2@
	movel a5@(-204),d0
	movel a5@(8),a0
	pea a0@(28)
	jbsr ___7_LLBase
	movel a5@(-196),a0
	addql #4,a0
	movel a0@,a5@(-96)
	clrl a5@(-92)
	movel a5@(-200),a5@(-88)
	movel #L1143,a5@(-84)
	movel sp,a5@(-80)
	movel a0,a1
L1143:
	lea a5@(-96),a2
	movel a2,a0@
	addql #4,sp
	movel a1@,a0
	movel a0@,a1@
	movel a5@(-208),a0
	movel a0@,a5@(-144)
	clrl a5@(-140)
	lea a5@(-136),a0
	movel a5,a0@
	movel #L1155,a0@(4)
	movel sp,a5@(-128)
	jra L1154
	.even
L1155:
	jra L1171
	.even
L1154:
	lea a5@(-144),a2
	movel a5@(-208),a1
	movel a2,a1@
	movel a5@(8),a0
	clrl a0@(44)
	clrl a0@(48)
	clrl a0@(52)
	clrl a0@(56)
	clrl a0@(60)
	clrl a0@(64)
	movel __9GUIObject$nextID,a0@(8)
	addql #1,__9GUIObject$nextID
	movel a1@,a0
	movel a0@,a1@
	movel a1@,a0
	movel a0@,a1@
	movel a5@(8),d0
	jra L1170
	.even
L1171:
L1152:
	movel a5@(-204),a1
	addql #4,a1
	movel a1@,a5@(-168)
	clrl a5@(-164)
	lea a5@(-160),a0
	movel a5,a0@
	movel #L1160,a0@(4)
	movel sp,a0@(8)
	jra L1159
	.even
L1160:
	jra L1172
	.even
L1159:
	lea a5@(-168),a2
	movel a2,a1@
	clrl sp@-
	movel a5@(8),a0
	pea a0@(28)
	jbsr __$_7_LLBase
	addql #8,sp
	movel a5@(-204),a1
	addql #4,a1
	movel a1@,a0
	movel a0@,a1@
	jbsr ___sjthrow
	.even
L1126:
	movel a5@(-208),a1
	movel a1@,a5@(-192)
	clrl a5@(-188)
	lea a5@(-184),a0
	movel a5,a0@
	movel #L1166,a0@(4)
	movel sp,a0@(8)
	jra L1165
	.even
L1166:
	jra L1173
	.even
L1165:
	lea a5@(-192),a0
	movel a5@(-208),a2
	movel a0,a2@
	clrl sp@-
	movel a5@(8),a1
	pea a1@(12)
	jbsr __$_7_LLBase
	addql #8,sp
	movel a5@(-204),a1
	addql #4,a1
	movel a1@,a0
	movel a0@,a1@
	jbsr ___sjthrow
	.even
L1172:
L1157:
	jbsr ___terminate
	.even
L1173:
L1163:
	jbsr ___terminate
	.even
L1170:
	moveml a5@(-320),#0x5cfc
	fmovem a5@(-280),#0x3f
	unlk a5
	rts
	.even
.globl ___9GUIObjectssssUlUlUl
___9GUIObjectssssUlUlUl:
	link a5,#-208
	fmovem #0xfc,sp@-
	moveml #0x3f3a,sp@-
	jbsr ___get_eh_context
	movel d0,a5@(-204)
	movel d0,a5@(-196)
	movel a5@(8),a0
	movew a5@(22),a0@
	movew a5@(26),a0@(2)
	movew a5@(14),a0@(4)
	movew a5@(18),a0@(6)
	movel #___vt_9GUIObject,a0@(68)
	movel a5@(-204),d0
	pea a0@(12)
	jbsr ___7_LLBase
	movel a5@(-204),a0
	addql #4,a0
	movel a0@,a5@(-24)
	clrl a5@(-20)
	movel a5,a5@(-16)
	movel #L1181,a5@(-12)
	movel sp,a5@(-8)
	movel a0,a5@(-208)
L1181:
	lea a5@(-24),a1
	movel a1,a0@
	addql #4,sp
	movel a5@(-204),a1
	addql #4,a1
	movel a1@,a0
	movel a0@,a1@
	movel a5@(-208),a2
	movel a2@,a5@(-72)
	clrl a5@(-68)
	movel a5,a5@(-64)
	movel #L1191,a5@(-60)
	movel sp,a5@(-56)
	jra L1190
	.even
L1191:
	movel a5@(-204),a0
	addql #4,a0
	movel a0,a5@(-208)
	jra L1188
	.even
L1190:
	lea a5@(-72),a1
	movel a1,a5@(-200)
	movel a5@(-208),a2
	movel a1,a2@
	movel a5@(-204),d0
	movel a5@(8),a0
	pea a0@(28)
	jbsr ___7_LLBase
	movel a5@(-196),a0
	addql #4,a0
	movel a0@,a5@(-96)
	clrl a5@(-92)
	movel a5@(-200),a5@(-88)
	movel #L1194,a5@(-84)
	movel sp,a5@(-80)
	movel a0,a1
L1194:
	lea a5@(-96),a2
	movel a2,a0@
	addql #4,sp
	movel a1@,a0
	movel a0@,a1@
	movel a5@(-208),a0
	movel a0@,a5@(-144)
	clrl a5@(-140)
	lea a5@(-136),a0
	movel a5,a0@
	movel #L1204,a0@(4)
	movel sp,a5@(-128)
	jra L1203
	.even
L1204:
	jra L1220
	.even
L1203:
	lea a5@(-144),a2
	movel a5@(-208),a1
	movel a2,a1@
	movel a5@(8),a0
	clrl a0@(44)
	clrl a0@(48)
	movel a5@(32),a0@(52)
	movel a5@(36),a0@(56)
	movel a5@(28),a0@(60)
	clrl a0@(64)
	movel __9GUIObject$nextID,a0@(8)
	addql #1,__9GUIObject$nextID
	movel a1@,a0
	movel a0@,a1@
	movel a1@,a0
	movel a0@,a1@
	movel a5@(8),d0
	jra L1219
	.even
L1220:
L1201:
	movel a5@(-204),a1
	addql #4,a1
	movel a1@,a5@(-168)
	clrl a5@(-164)
	lea a5@(-160),a0
	movel a5,a0@
	movel #L1209,a0@(4)
	movel sp,a0@(8)
	jra L1208
	.even
L1209:
	jra L1221
	.even
L1208:
	lea a5@(-168),a2
	movel a2,a1@
	clrl sp@-
	movel a5@(8),a0
	pea a0@(28)
	jbsr __$_7_LLBase
	addql #8,sp
	movel a5@(-204),a1
	addql #4,a1
	movel a1@,a0
	movel a0@,a1@
	jbsr ___sjthrow
	.even
L1188:
	movel a5@(-208),a1
	movel a1@,a5@(-192)
	clrl a5@(-188)
	lea a5@(-184),a0
	movel a5,a0@
	movel #L1215,a0@(4)
	movel sp,a0@(8)
	jra L1214
	.even
L1215:
	jra L1222
	.even
L1214:
	lea a5@(-192),a0
	movel a5@(-208),a2
	movel a0,a2@
	clrl sp@-
	movel a5@(8),a1
	pea a1@(12)
	jbsr __$_7_LLBase
	addql #8,sp
	movel a5@(-204),a1
	addql #4,a1
	movel a1@,a0
	movel a0@,a1@
	jbsr ___sjthrow
	.even
L1221:
L1206:
	jbsr ___terminate
	.even
L1222:
L1212:
	jbsr ___terminate
	.even
L1219:
	moveml a5@(-320),#0x5cfc
	fmovem a5@(-280),#0x3f
	unlk a5
	rts
	.even
.globl __$_9GUIObject
__$_9GUIObject:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel d2,sp@-
	movel a5@(8),a2
	movel a5@(12),d2
	movel #___vt_9GUIObject,a2@(68)
	pea 2:w
	pea a2@(28)
	jbsr __$_7_LLBase
	addqw #4,sp
	movel #2,sp@
	pea a2@(12)
	jbsr __$_7_LLBase
	addql #8,sp
	btst #0,d2
	jeq L1230
	movel a2,sp@-
	jbsr ___builtin_delete
L1230:
	movel a5@(-8),d2
	movel a5@(-4),a2
	unlk a5
	rts
LC0:
	.ascii "GUIObject::recFindHit() current object found\0"
	.even
.globl _recFindHit__9GUIObjectssP9GUIObject
_recFindHit__9GUIObjectssP9GUIObject:
	pea a5@
	movel sp,a5
	moveml #0x3030,sp@-
	movel a5@(8),a2
	movel a5@(20),a3
	movew a5@(14),d3
	movew a5@(18),d2
	movel a2@(60),d0
	cmpl a3@(60),d0
	jcs L1232
	movel a2@(68),a0
	movew d2,a1
	movel a1,sp@-
	movew d3,a1
	movel a1,sp@-
	movel a2,sp@-
	movel a0@(8),a0
	jbsr a0@
	addw #12,sp
	tstb d0
	jeq L1232
	clrl sp@-
	pea LC0
	jbsr _printDebug__9SystemLibPCci
	movel a2,a3
	addql #8,sp
L1232:
	moveq #28,d0
	addl a2,d0
	movel d0,a2
	tstl a2@(12)
	jle L1236
	movel a2@,d0
	movel __7_LLBase$linkCache,a0
	lsll #4,d0
	movel a0@(4,d0:l),a2@(8)
	movel a2@(8),d0
	jra L1256
	.even
L1236:
	clrl d0
	jra L1250
	.even
L1242:
	movel a3,sp@-
	movew d2,a0
	movel a0,sp@-
	movew d3,a1
	movel a1,sp@-
	movel d0,sp@-
	jbsr _recFindHit__9GUIObjectssP9GUIObject
	movel d0,a3
	addw #16,sp
	movel a2@(8),d0
	movel __7_LLBase$linkCache,a0
	lsll #4,d0
	movel a0@(4,d0:l),d0
	moveq #-1,d1
	cmpl d0,d1
	jeq L1236
	cmpl a2@(4),d0
	jeq L1236
	movel d0,a2@(8)
L1256:
	lsll #4,d0
	movel a0@(12,d0:l),d0
L1250:
	tstl d0
	jne L1242
	movel a3,d0
	moveml a5@(-16),#0xc0c
	unlk a5
	rts
	.even
.globl _recKeyPressNP__9GUIObjectQ23Key7CtrlKey
_recKeyPressNP__9GUIObjectQ23Key7CtrlKey:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel d2,sp@-
	movel a5@(8),a2
	movel a5@(12),d2
	moveb a2@(51),d0
	eorb #1,d0
	btst #0,d0
	jne L1257
	cmpl __7GUIBase$active,a2
	jeq L1259
	btst #1,a2@(59)
	jeq L1259
	movel a2@(68),a0
	movel d2,sp@-
	movel a2,sp@-
	movel a0@(64),a0
	jbsr a0@
	addql #8,sp
L1259:
	moveq #28,d0
	addl a2,d0
	movel d0,a2
	tstl a2@(12)
	jle L1262
	movel a2@,d0
	movel __7_LLBase$linkCache,a0
	lsll #4,d0
	movel a0@(4,d0:l),a2@(8)
	movel a2@(8),d0
	jra L1276
	.even
L1262:
	clrl d0
	jra L1271
	.even
L1268:
	movel d2,sp@-
	movel d0,sp@-
	jbsr _recKeyPressNP__9GUIObjectQ23Key7CtrlKey
	addql #8,sp
	movel a2@(8),d0
	movel __7_LLBase$linkCache,a0
	lsll #4,d0
	movel a0@(4,d0:l),d0
	moveq #-1,d1
	cmpl d0,d1
	jeq L1262
	cmpl a2@(4),d0
	jeq L1262
	movel d0,a2@(8)
L1276:
	lsll #4,d0
	movel a0@(12,d0:l),d0
L1271:
	tstl d0
	jne L1268
L1257:
	movel a5@(-8),d2
	movel a5@(-4),a2
	unlk a5
	rts
	.even
.globl _recKeyReleaseNP__9GUIObjectQ23Key7CtrlKey
_recKeyReleaseNP__9GUIObjectQ23Key7CtrlKey:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel d2,sp@-
	movel a5@(8),a2
	movel a5@(12),d2
	moveb a2@(51),d0
	eorb #1,d0
	btst #0,d0
	jne L1277
	cmpl __7GUIBase$active,a2
	jeq L1279
	btst #3,a2@(59)
	jeq L1279
	movel a2@(68),a0
	movel d2,sp@-
	movel a2,sp@-
	movel a0@(68),a0
	jbsr a0@
	addql #8,sp
L1279:
	moveq #28,d0
	addl a2,d0
	movel d0,a2
	tstl a2@(12)
	jle L1282
	movel a2@,d0
	movel __7_LLBase$linkCache,a0
	lsll #4,d0
	movel a0@(4,d0:l),a2@(8)
	movel a2@(8),d0
	jra L1296
	.even
L1282:
	clrl d0
	jra L1291
	.even
L1288:
	movel d2,sp@-
	movel d0,sp@-
	jbsr _recKeyReleaseNP__9GUIObjectQ23Key7CtrlKey
	addql #8,sp
	movel a2@(8),d0
	movel __7_LLBase$linkCache,a0
	lsll #4,d0
	movel a0@(4,d0:l),d0
	moveq #-1,d1
	cmpl d0,d1
	jeq L1282
	cmpl a2@(4),d0
	jeq L1282
	movel d0,a2@(8)
L1296:
	lsll #4,d0
	movel a0@(12,d0:l),d0
L1291:
	tstl d0
	jne L1288
L1277:
	movel a5@(-8),d2
	movel a5@(-4),a2
	unlk a5
	rts
	.even
.globl _recKeyPress__9GUIObjectl
_recKeyPress__9GUIObjectl:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel d2,sp@-
	movel a5@(8),a2
	movel a5@(12),d2
	moveb a2@(51),d0
	eorb #1,d0
	btst #0,d0
	jne L1297
	cmpl __7GUIBase$active,a2
	jeq L1299
	btst #0,a2@(59)
	jeq L1299
	movel a2@(68),a0
	movel d2,sp@-
	movel a2,sp@-
	movel a0@(72),a0
	jbsr a0@
	addql #8,sp
L1299:
	moveq #28,d0
	addl a2,d0
	movel d0,a2
	tstl a2@(12)
	jle L1302
	movel a2@,d0
	movel __7_LLBase$linkCache,a0
	lsll #4,d0
	movel a0@(4,d0:l),a2@(8)
	movel a2@(8),d0
	jra L1316
	.even
L1302:
	clrl d0
	jra L1311
	.even
L1308:
	movel d2,sp@-
	movel d0,sp@-
	jbsr _recKeyPress__9GUIObjectl
	addql #8,sp
	movel a2@(8),d0
	movel __7_LLBase$linkCache,a0
	lsll #4,d0
	movel a0@(4,d0:l),d0
	moveq #-1,d1
	cmpl d0,d1
	jeq L1302
	cmpl a2@(4),d0
	jeq L1302
	movel d0,a2@(8)
L1316:
	lsll #4,d0
	movel a0@(12,d0:l),d0
L1311:
	tstl d0
	jne L1308
L1297:
	movel a5@(-8),d2
	movel a5@(-4),a2
	unlk a5
	rts
	.even
.globl _recKeyRelease__9GUIObjectl
_recKeyRelease__9GUIObjectl:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel d2,sp@-
	movel a5@(8),a2
	movel a5@(12),d2
	moveb a2@(51),d0
	eorb #1,d0
	btst #0,d0
	jne L1317
	cmpl __7GUIBase$active,a2
	jeq L1319
	btst #2,a2@(59)
	jeq L1319
	movel a2@(68),a0
	movel d2,sp@-
	movel a2,sp@-
	movel a0@(76),a0
	jbsr a0@
	addql #8,sp
L1319:
	moveq #28,d0
	addl a2,d0
	movel d0,a2
	tstl a2@(12)
	jle L1322
	movel a2@,d0
	movel __7_LLBase$linkCache,a0
	lsll #4,d0
	movel a0@(4,d0:l),a2@(8)
	movel a2@(8),d0
	jra L1336
	.even
L1322:
	clrl d0
	jra L1331
	.even
L1328:
	movel d2,sp@-
	movel d0,sp@-
	jbsr _recKeyRelease__9GUIObjectl
	addql #8,sp
	movel a2@(8),d0
	movel __7_LLBase$linkCache,a0
	lsll #4,d0
	movel a0@(4,d0:l),d0
	moveq #-1,d1
	cmpl d0,d1
	jeq L1322
	cmpl a2@(4),d0
	jeq L1322
	movel d0,a2@(8)
L1336:
	lsll #4,d0
	movel a0@(12,d0:l),d0
L1331:
	tstl d0
	jne L1328
L1317:
	movel a5@(-8),d2
	movel a5@(-4),a2
	unlk a5
	rts
	.even
.globl _recMousePress__9GUIObjectssUl
_recMousePress__9GUIObjectssUl:
	pea a5@
	movel sp,a5
	moveml #0x3820,sp@-
	movel a5@(8),a2
	movel a5@(20),d4
	movew a5@(14),d3
	movew a5@(18),d2
	moveb a2@(51),d0
	eorb #1,d0
	btst #0,d0
	jne L1337
	cmpl __7GUIBase$active,a2
	jeq L1339
	moveq #112,d0
	andl a2@(56),d0
	jeq L1339
	movel a2@(68),a0
	movel d4,sp@-
	movew d2,a1
	movel a1,sp@-
	movew d3,a1
	movel a1,sp@-
	movel a2,sp@-
	movel a0@(80),a0
	jbsr a0@
	addw #16,sp
L1339:
	moveq #28,d0
	addl a2,d0
	movel d0,a2
	tstl a2@(12)
	jle L1342
	movel a2@,d0
	movel __7_LLBase$linkCache,a0
	lsll #4,d0
	movel a0@(4,d0:l),a2@(8)
	movel a2@(8),d0
	jra L1356
	.even
L1342:
	clrl d0
	jra L1351
	.even
L1348:
	movel d4,sp@-
	movew d2,a0
	movel a0,sp@-
	movew d3,a1
	movel a1,sp@-
	movel d0,sp@-
	jbsr _recMousePress__9GUIObjectssUl
	addw #16,sp
	movel a2@(8),d0
	movel __7_LLBase$linkCache,a0
	lsll #4,d0
	movel a0@(4,d0:l),d0
	moveq #-1,d1
	cmpl d0,d1
	jeq L1342
	cmpl a2@(4),d0
	jeq L1342
	movel d0,a2@(8)
L1356:
	lsll #4,d0
	movel a0@(12,d0:l),d0
L1351:
	tstl d0
	jne L1348
L1337:
	moveml a5@(-16),#0x41c
	unlk a5
	rts
	.even
.globl _recMouseRelease__9GUIObjectssUl
_recMouseRelease__9GUIObjectssUl:
	pea a5@
	movel sp,a5
	moveml #0x3820,sp@-
	movel a5@(8),a2
	movel a5@(20),d4
	movew a5@(14),d3
	movew a5@(18),d2
	moveb a2@(51),d0
	eorb #1,d0
	btst #0,d0
	jne L1357
	cmpl __7GUIBase$active,a2
	jeq L1359
	movel a2@(56),d0
	andl #1792,d0
	jeq L1359
	movel a2@(68),a0
	movel d4,sp@-
	movew d2,a1
	movel a1,sp@-
	movew d3,a1
	movel a1,sp@-
	movel a2,sp@-
	movel a0@(84),a0
	jbsr a0@
	addw #16,sp
L1359:
	moveq #28,d0
	addl a2,d0
	movel d0,a2
	tstl a2@(12)
	jle L1362
	movel a2@,d0
	movel __7_LLBase$linkCache,a0
	lsll #4,d0
	movel a0@(4,d0:l),a2@(8)
	movel a2@(8),d0
	jra L1376
	.even
L1362:
	clrl d0
	jra L1371
	.even
L1368:
	movel d4,sp@-
	movew d2,a0
	movel a0,sp@-
	movew d3,a1
	movel a1,sp@-
	movel d0,sp@-
	jbsr _recMouseRelease__9GUIObjectssUl
	addw #16,sp
	movel a2@(8),d0
	movel __7_LLBase$linkCache,a0
	lsll #4,d0
	movel a0@(4,d0:l),d0
	moveq #-1,d1
	cmpl d0,d1
	jeq L1362
	cmpl a2@(4),d0
	jeq L1362
	movel d0,a2@(8)
L1376:
	lsll #4,d0
	movel a0@(12,d0:l),d0
L1371:
	tstl d0
	jne L1368
L1357:
	moveml a5@(-16),#0x41c
	unlk a5
	rts
	.even
.globl _recMouseMove__9GUIObjectssss
_recMouseMove__9GUIObjectssss:
	pea a5@
	movel sp,a5
	moveml #0x3c20,sp@-
	movel a5@(8),a2
	movew a5@(14),d5
	movew a5@(18),d4
	movew a5@(22),d3
	movew a5@(26),d2
	moveb a2@(51),d0
	eorb #1,d0
	btst #0,d0
	jne L1377
	cmpl __7GUIBase$active,a2
	jeq L1379
	btst #5,a2@(58)
	jeq L1379
	movel a2@(68),a0
	movew d2,a1
	movel a1,sp@-
	movew d3,a1
	movel a1,sp@-
	movew d4,a1
	movel a1,sp@-
	movew d5,a1
	movel a1,sp@-
	movel a2,sp@-
	movel a0@(88),a0
	jbsr a0@
	addw #20,sp
L1379:
	moveq #28,d0
	addl a2,d0
	movel d0,a2
	tstl a2@(12)
	jle L1382
	movel a2@,d0
	movel __7_LLBase$linkCache,a0
	lsll #4,d0
	movel a0@(4,d0:l),a2@(8)
	movel a2@(8),d0
	jra L1396
	.even
L1382:
	clrl d0
	jra L1391
	.even
L1388:
	movew d2,a0
	movel a0,sp@-
	movew d3,a1
	movel a1,sp@-
	movew d4,a0
	movel a0,sp@-
	movew d5,a1
	movel a1,sp@-
	movel d0,sp@-
	jbsr _recMouseMove__9GUIObjectssss
	addw #20,sp
	movel a2@(8),d0
	movel __7_LLBase$linkCache,a0
	lsll #4,d0
	movel a0@(4,d0:l),d0
	moveq #-1,d1
	cmpl d0,d1
	jeq L1382
	cmpl a2@(4),d0
	jeq L1382
	movel d0,a2@(8)
L1396:
	lsll #4,d0
	movel a0@(12,d0:l),d0
L1391:
	tstl d0
	jne L1388
L1377:
	moveml a5@(-20),#0x43c
	unlk a5
	rts
	.even
.globl _recMouseDrag__9GUIObjectssssUl
_recMouseDrag__9GUIObjectssssUl:
	pea a5@
	movel sp,a5
	moveml #0x3e20,sp@-
	movel a5@(8),a2
	movel a5@(28),d6
	movew a5@(14),d5
	movew a5@(18),d4
	movew a5@(22),d3
	movew a5@(26),d2
	moveb a2@(51),d0
	eorb #1,d0
	btst #0,d0
	jne L1397
	cmpl __7GUIBase$active,a2
	jeq L1399
	btst #6,a2@(58)
	jeq L1399
	movel a2@(68),a0
	movel d6,sp@-
	movew d2,a1
	movel a1,sp@-
	movew d3,a1
	movel a1,sp@-
	movew d4,a1
	movel a1,sp@-
	movew d5,a1
	movel a1,sp@-
	movel a2,sp@-
	movel a0@(92),a0
	jbsr a0@
	addw #24,sp
L1399:
	moveq #28,d0
	addl a2,d0
	movel d0,a2
	tstl a2@(12)
	jle L1402
	movel a2@,d0
	movel __7_LLBase$linkCache,a0
	lsll #4,d0
	movel a0@(4,d0:l),a2@(8)
	movel a2@(8),d0
	jra L1416
	.even
L1402:
	clrl d0
	jra L1411
	.even
L1408:
	movel d6,sp@-
	movew d2,a0
	movel a0,sp@-
	movew d3,a1
	movel a1,sp@-
	movew d4,a0
	movel a0,sp@-
	movew d5,a1
	movel a1,sp@-
	movel d0,sp@-
	jbsr _recMouseDrag__9GUIObjectssssUl
	addw #24,sp
	movel a2@(8),d0
	movel __7_LLBase$linkCache,a0
	lsll #4,d0
	movel a0@(4,d0:l),d0
	moveq #-1,d1
	cmpl d0,d1
	jeq L1402
	cmpl a2@(4),d0
	jeq L1402
	movel d0,a2@(8)
L1416:
	lsll #4,d0
	movel a0@(12,d0:l),d0
L1411:
	tstl d0
	jne L1408
L1397:
	moveml a5@(-24),#0x47c
	unlk a5
	rts
	.even
.globl _recMouseScroll__9GUIObjectss
_recMouseScroll__9GUIObjectss:
	pea a5@
	movel sp,a5
	moveml #0x3020,sp@-
	movel a5@(8),a2
	movew a5@(14),d3
	movew a5@(18),d2
	moveb a2@(51),d0
	eorb #1,d0
	btst #0,d0
	jne L1417
	cmpl __7GUIBase$active,a2
	jeq L1419
	movel a2@(56),d0
	andl #98304,d0
	jeq L1419
	movel a2@(68),a0
	movew d2,a1
	movel a1,sp@-
	movew d3,a1
	movel a1,sp@-
	movel a2,sp@-
	movel a0@(96),a0
	jbsr a0@
	addw #12,sp
L1419:
	moveq #28,d0
	addl a2,d0
	movel d0,a2
	tstl a2@(12)
	jle L1422
	movel a2@,d0
	movel __7_LLBase$linkCache,a0
	lsll #4,d0
	movel a0@(4,d0:l),a2@(8)
	movel a2@(8),d0
	jra L1436
	.even
L1422:
	clrl d0
	jra L1431
	.even
L1428:
	movew d2,a0
	movel a0,sp@-
	movew d3,a1
	movel a1,sp@-
	movel d0,sp@-
	jbsr _recMouseScroll__9GUIObjectss
	addw #12,sp
	movel a2@(8),d0
	movel __7_LLBase$linkCache,a0
	lsll #4,d0
	movel a0@(4,d0:l),d0
	moveq #-1,d1
	cmpl d0,d1
	jeq L1422
	cmpl a2@(4),d0
	jeq L1422
	movel d0,a2@(8)
L1436:
	lsll #4,d0
	movel a0@(12,d0:l),d0
L1431:
	tstl d0
	jne L1428
L1417:
	moveml a5@(-12),#0x40c
	unlk a5
	rts
	.even
.globl _updateListeners__9GUIObject
_updateListeners__9GUIObject:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel d2,sp@-
	movel a5@(8),d2
	movel d2,a0
	lea a0@(12),a1
	tstl a1@(12)
	jle L1441
	movel a1@,d0
	movel __7_LLBase$linkCache,a0
	lsll #4,d0
	movel a0@(4,d0:l),a1@(8)
	movel a1@(8),d0
	lsll #4,d0
	movel a0@(12,d0:l),d0
	jra L1442
	.even
L1441:
	clrl d0
L1442:
	movel d0,a1
	tstl a1
	jeq L1459
	movel d2,a0
	lea a0@(12),a2
	.even
L1447:
	movel a1@,a0
	movel d2,sp@-
	movel a1,sp@-
	movel a0@(8),a0
	jbsr a0@
	addql #8,sp
	movel a2@(8),d0
	movel __7_LLBase$linkCache,a0
	lsll #4,d0
	movel a0@(4,d0:l),d0
	moveq #-1,d1
	cmpl d0,d1
	jeq L1453
	cmpl a2@(4),d0
	jne L1454
L1453:
	clrl d0
	jra L1455
	.even
L1454:
	movel d0,a2@(8)
	lsll #4,d0
	movel a0@(12,d0:l),d0
L1455:
	movel d0,a1
	tstl a1
	jne L1447
L1459:
	movel a5@(-8),d2
	movel a5@(-4),a2
	unlk a5
	rts
	.even
.globl _coordHit__9GUIObjectss
_coordHit__9GUIObjectss:
	pea a5@
	movel sp,a5
	movel a3,sp@-
	movel a2,sp@-
	movel a5@(8),a3
	movew a5@(18),d0
	movew a5@(14),a2
	movew a3@(4),a1
	cmpl a2,a1
	jgt L1462
	movew a3@,a0
	lea a0@(-1,a1:l),a0
	cmpl a2,a0
	jlt L1462
	movew d0,a2
	movew a3@(6),a1
	cmpl a2,a1
	jgt L1462
	movew a3@(2),a0
	lea a0@(-1,a1:l),a0
	moveq #1,d0
	cmpl a2,a0
	jge L1469
L1462:
	clrb d0
L1469:
	movel sp@+,a2
	movel sp@+,a3
	unlk a5
	rts
	.even
.globl _addChild__9GUIObjectP9GUIObject
_addChild__9GUIObjectP9GUIObject:
	pea a5@
	movel sp,a5
	moveml #0x3020,sp@-
	movel a5@(8),d3
	movel a5@(12),a2
	tstl a2
	jeq L1471
	cmpl a2,d3
	jeq L1471
	tstl a2@(44)
	jne L1471
	moveq #28,d2
	addl d3,d2
	movel a2,sp@-
	movel d2,sp@-
	jbsr _contains__C7_LLBasePv
	addql #8,sp
	tstb d0
	jeq L1473
	moveq #1,d0
	jra L1478
	.even
L1473:
	movel a2,sp@-
	movel d2,sp@-
	jbsr _insLast__7_LLBasePv
	cmpb #1,d0
	jne L1471
	movel d3,a2@(44)
	moveq #1,d0
	jra L1478
	.even
L1471:
	clrb d0
L1478:
	moveml a5@(-12),#0x40c
	unlk a5
	rts
	.even
.globl _removeChild__9GUIObjectP9GUIObject
_removeChild__9GUIObjectP9GUIObject:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel a5@(8),d0
	movel a5@(12),a2
	tstl a2
	jeq L1480
	cmpl a2,d0
	jeq L1480
	movel a2@(44),a0
	cmpl a0,d0
	jne L1480
	movel a2,sp@-
	pea a0@(28)
	jbsr _remLast__7_LLBasePv
	cmpb #1,d0
	jne L1480
	clrl a2@(44)
	moveq #1,d0
	jra L1484
	.even
L1480:
	clrb d0
L1484:
	movel a5@(-4),a2
	unlk a5
	rts
	.even
.globl _addListener__9GUIObjectP11GUIListener
_addListener__9GUIObjectP11GUIListener:
	pea a5@
	movel sp,a5
	movel d3,sp@-
	movel d2,sp@-
	movel a5@(12),d2
	jeq L1486
	moveq #12,d3
	addl a5@(8),d3
	movel d2,sp@-
	movel d3,sp@-
	jbsr _contains__C7_LLBasePv
	addql #8,sp
	tstb d0
	jeq L1488
	moveq #1,d0
	jra L1492
	.even
L1488:
	movel d2,sp@-
	movel d3,sp@-
	jbsr _insLast__7_LLBasePv
	jra L1492
	.even
L1486:
	clrb d0
L1492:
	movel a5@(-8),d2
	movel a5@(-4),d3
	unlk a5
	rts
	.even
.globl _removeListener__9GUIObjectP11GUIListener
_removeListener__9GUIObjectP11GUIListener:
	pea a5@
	movel sp,a5
	movel a5@(12),d0
	jne L1494
	clrb d0
	jra L1497
	.even
L1494:
	movel d0,sp@-
	moveq #12,d0
	addl a5@(8),d0
	movel d0,sp@-
	jbsr _remLast__7_LLBasePv
L1497:
	unlk a5
	rts
.globl ___vt_9GUIObject
	.even
___vt_9GUIObject:
	.long 0
	.long 0
	.long _coordHit__9GUIObjectss
	.long _setEnabled__9GUIObject
	.long _setDisabled__9GUIObject
	.long _setActive__9GUIObject
	.long _setInactive__9GUIObject
	.long _keyPressNP__9GUIObjectQ23Key7CtrlKey
	.long _keyReleaseNP__9GUIObjectQ23Key7CtrlKey
	.long _keyPress__9GUIObjectl
	.long _keyRelease__9GUIObjectl
	.long _mousePress__9GUIObjectssUl
	.long _mouseRelease__9GUIObjectssUl
	.long _mouseMove__9GUIObjectssss
	.long _mouseDrag__9GUIObjectssssUl
	.long _mouseScroll__9GUIObjectss
	.long _passKeyPressNP__9GUIObjectQ23Key7CtrlKey
	.long _passKeyReleaseNP__9GUIObjectQ23Key7CtrlKey
	.long _passKeyPress__9GUIObjectl
	.long _passKeyRelease__9GUIObjectl
	.long _passMousePress__9GUIObjectssUl
	.long _passMouseRelease__9GUIObjectssUl
	.long _passMouseMove__9GUIObjectssss
	.long _passMouseDrag__9GUIObjectssssUl
	.long _passMouseScroll__9GUIObjectss
	.long __$_9GUIObject
	.skip 4
	.even
.globl _getActiveResponses__9GUIObjectUl
_getActiveResponses__9GUIObjectUl:
	pea a5@
	movel sp,a5
	movel a5@(8),a0
	movel a0@(52),d0
	andl a5@(12),d0
	sne d0
	negb d0
	unlk a5
	rts
	.even
.globl _getPassiveResponses__9GUIObjectUl
_getPassiveResponses__9GUIObjectUl:
	pea a5@
	movel sp,a5
	movel a5@(8),a0
	movel a0@(56),d0
	andl a5@(12),d0
	sne d0
	negb d0
	unlk a5
	rts
	.even
.globl _setActiveResponses__9GUIObjectUl
_setActiveResponses__9GUIObjectUl:
	pea a5@
	movel sp,a5
	movel a5@(8),a0
	movel a5@(12),d0
	orl d0,a0@(52)
	unlk a5
	rts
	.even
.globl _clrActiveResponses__9GUIObjectUl
_clrActiveResponses__9GUIObjectUl:
	pea a5@
	movel sp,a5
	movel a5@(8),a0
	movel a5@(12),d0
	notl d0
	andl d0,a0@(52)
	unlk a5
	rts
	.even
.globl _togActiveResponses__9GUIObjectUl
_togActiveResponses__9GUIObjectUl:
	pea a5@
	movel sp,a5
	movel a5@(8),a0
	movel a5@(12),d0
	eorl d0,a0@(52)
	unlk a5
	rts
	.even
.globl _setPassiveResponses__9GUIObjectUl
_setPassiveResponses__9GUIObjectUl:
	pea a5@
	movel sp,a5
	movel a5@(8),a0
	movel a5@(12),d0
	orl d0,a0@(56)
	unlk a5
	rts
	.even
.globl _clrPassiveResponses__9GUIObjectUl
_clrPassiveResponses__9GUIObjectUl:
	pea a5@
	movel sp,a5
	movel a5@(8),a0
	movel a5@(12),d0
	notl d0
	andl d0,a0@(56)
	unlk a5
	rts
	.even
.globl _togPassiveResponses__9GUIObjectUl
_togPassiveResponses__9GUIObjectUl:
	pea a5@
	movel sp,a5
	movel a5@(8),a0
	movel a5@(12),d0
	eorl d0,a0@(56)
	unlk a5
	rts
	.even
.globl _setEnabled__9GUIObject
_setEnabled__9GUIObject:
	pea a5@
	movel sp,a5
	unlk a5
	rts
	.even
.globl _setDisabled__9GUIObject
_setDisabled__9GUIObject:
	pea a5@
	movel sp,a5
	unlk a5
	rts
	.even
.globl _setActive__9GUIObject
_setActive__9GUIObject:
	pea a5@
	movel sp,a5
	unlk a5
	rts
	.even
.globl _setInactive__9GUIObject
_setInactive__9GUIObject:
	pea a5@
	movel sp,a5
	unlk a5
	rts
	.even
.globl _keyPressNP__9GUIObjectQ23Key7CtrlKey
_keyPressNP__9GUIObjectQ23Key7CtrlKey:
	pea a5@
	movel sp,a5
	unlk a5
	rts
	.even
.globl _keyReleaseNP__9GUIObjectQ23Key7CtrlKey
_keyReleaseNP__9GUIObjectQ23Key7CtrlKey:
	pea a5@
	movel sp,a5
	unlk a5
	rts
	.even
.globl _keyPress__9GUIObjectl
_keyPress__9GUIObjectl:
	pea a5@
	movel sp,a5
	unlk a5
	rts
	.even
.globl _keyRelease__9GUIObjectl
_keyRelease__9GUIObjectl:
	pea a5@
	movel sp,a5
	unlk a5
	rts
	.even
.globl _mousePress__9GUIObjectssUl
_mousePress__9GUIObjectssUl:
	pea a5@
	movel sp,a5
	unlk a5
	rts
	.even
.globl _mouseRelease__9GUIObjectssUl
_mouseRelease__9GUIObjectssUl:
	pea a5@
	movel sp,a5
	unlk a5
	rts
	.even
.globl _mouseMove__9GUIObjectssss
_mouseMove__9GUIObjectssss:
	pea a5@
	movel sp,a5
	unlk a5
	rts
	.even
.globl _mouseDrag__9GUIObjectssssUl
_mouseDrag__9GUIObjectssssUl:
	pea a5@
	movel sp,a5
	unlk a5
	rts
	.even
.globl _mouseScroll__9GUIObjectss
_mouseScroll__9GUIObjectss:
	pea a5@
	movel sp,a5
	unlk a5
	rts
	.even
.globl _passKeyPressNP__9GUIObjectQ23Key7CtrlKey
_passKeyPressNP__9GUIObjectQ23Key7CtrlKey:
	pea a5@
	movel sp,a5
	unlk a5
	rts
	.even
.globl _passKeyReleaseNP__9GUIObjectQ23Key7CtrlKey
_passKeyReleaseNP__9GUIObjectQ23Key7CtrlKey:
	pea a5@
	movel sp,a5
	unlk a5
	rts
	.even
.globl _passKeyPress__9GUIObjectl
_passKeyPress__9GUIObjectl:
	pea a5@
	movel sp,a5
	unlk a5
	rts
	.even
.globl _passKeyRelease__9GUIObjectl
_passKeyRelease__9GUIObjectl:
	pea a5@
	movel sp,a5
	unlk a5
	rts
	.even
.globl _passMousePress__9GUIObjectssUl
_passMousePress__9GUIObjectssUl:
	pea a5@
	movel sp,a5
	unlk a5
	rts
	.even
.globl _passMouseRelease__9GUIObjectssUl
_passMouseRelease__9GUIObjectssUl:
	pea a5@
	movel sp,a5
	unlk a5
	rts
	.even
.globl _passMouseMove__9GUIObjectssss
_passMouseMove__9GUIObjectssss:
	pea a5@
	movel sp,a5
	unlk a5
	rts
	.even
.globl _passMouseDrag__9GUIObjectssssUl
_passMouseDrag__9GUIObjectssssUl:
	pea a5@
	movel sp,a5
	unlk a5
	rts
	.even
.globl _passMouseScroll__9GUIObjectss
_passMouseScroll__9GUIObjectss:
	pea a5@
	movel sp,a5
	unlk a5
	rts
	.even
.globl _setEventType__9GUIObjectUl
_setEventType__9GUIObjectUl:
	pea a5@
	movel sp,a5
	movel a5@(8),a0
	movel a5@(12),a0@(64)
	unlk a5
	rts
	.even
.globl _enable__9GUIObject
_enable__9GUIObject:
	pea a5@
	movel sp,a5
	movel a5@(8),a0
	moveq #1,d0
	orl d0,a0@(48)
	movel a0@(68),a1
	movel a0,sp@-
	movel a1@(12),a0
	jbsr a0@
	unlk a5
	rts
	.even
.globl _disable__9GUIObject
_disable__9GUIObject:
	pea a5@
	movel sp,a5
	movel a5@(8),a0
	moveq #-2,d0
	andl d0,a0@(48)
	movel a0@(68),a1
	movel a0,sp@-
	movel a1@(16),a0
	jbsr a0@
	unlk a5
	rts
	.even
.globl _activate__9GUIObject
_activate__9GUIObject:
	pea a5@
	movel sp,a5
	movel a5@(8),a0
	moveq #2,d0
	orl d0,a0@(48)
	movel a0@(68),a1
	movel a0,sp@-
	movel a1@(20),a0
	jbsr a0@
	unlk a5
	rts
	.even
.globl _deactivate__9GUIObject
_deactivate__9GUIObject:
	pea a5@
	movel sp,a5
	movel a5@(8),a0
	moveq #-3,d0
	andl d0,a0@(48)
	movel a0@(68),a1
	movel a0,sp@-
	movel a1@(24),a0
	jbsr a0@
	unlk a5
	rts
	.even
.globl _enabled__9GUIObject
_enabled__9GUIObject:
	pea a5@
	movel sp,a5
	movel a5@(8),a0
	moveb a0@(51),d0
	andb #1,d0
	unlk a5
	rts
	.even
.globl _active__9GUIObject
_active__9GUIObject:
	pea a5@
	movel sp,a5
	movel a5@(8),a0
	bfextu a0@(51){#6:#1},d0
	unlk a5
	rts
	.even
.globl _getEventType__9GUIObject
_getEventType__9GUIObject:
	pea a5@
	movel sp,a5
	movel a5@(8),a0
	movel a0@(64),d0
	unlk a5
	rts
	.even
.globl _getID__9GUIObject
_getID__9GUIObject:
	pea a5@
	movel sp,a5
	movel a5@(8),a0
	movel a0@(8),d0
	unlk a5
	rts
