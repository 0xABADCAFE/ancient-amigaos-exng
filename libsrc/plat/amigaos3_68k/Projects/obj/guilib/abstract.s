#NO_APP
.text
	.even
.globl ___14AbstractButtonssssUlUlUl
___14AbstractButtonssssUlUlUl:
	link a5,#-52
	fmovem #0xfc,sp@-
	moveml #0x3f3a,sp@-
	jbsr ___get_eh_context
	movel d0,a5@(-52)
	movel a5@(36),sp@-
	movel a5@(32),sp@-
	movel a5@(28),sp@-
	movew a5@(26),a0
	movel a0,sp@-
	movew a5@(22),a1
	movel a1,sp@-
	movew a5@(18),a2
	movel a2,sp@-
	movew a5@(14),a0
	movel a0,sp@-
	movel a5@(8),sp@-
	jbsr ___9GUIObjectssssUlUlUl
	movel a5@(-52),a0
	addql #4,a0
	movel a0@,a5@(-24)
	clrl a5@(-20)
	movel a5,a5@(-16)
	movel #L1118,a5@(-12)
	movel sp,a5@(-8)
	movel a0,a1
	jra L1117
	.even
L1118:
	jra L1126
	.even
L1117:
	lea a5@(-24),a2
	movel a2,a0@
	movel a5@(8),a0
	movel #___vt_14AbstractButton,a0@(68)
	clrl a0@(72)
	movel a1@,a0
	movel a0@,a1@
	movel a5@(8),d0
	jra L1125
	.even
L1126:
L1115:
	movel a5@(-52),a0
	addql #4,a0
	movel a0@,a5@(-48)
	clrl a5@(-44)
	movel a5,a5@(-40)
	movel #L1123,a5@(-36)
	movel sp,a5@(-32)
	jra L1122
	.even
L1123:
	jra L1127
	.even
L1122:
	lea a5@(-48),a1
	movel a1,a0@
	clrl sp@-
	movel a5@(8),sp@-
	jbsr __$_9GUIObject
	movel a5@(-52),a1
	addql #4,a1
	movel a1@,a0
	movel a0@,a1@
	addql #8,sp
	jbsr ___sjthrow
	.even
L1127:
L1120:
	jbsr ___terminate
	.even
L1125:
	moveml a5@(-164),#0x5cfc
	fmovem a5@(-124),#0x3f
	unlk a5
	rts
	.even
.globl _mousePress__14AbstractButtonssUl
_mousePress__14AbstractButtonssUl:
	pea a5@
	movel sp,a5
	moveml #0x3020,sp@-
	movel a5@(8),a2
	movel a5@(20),d2
	movew a5@(14),d1
	movew a5@(18),d0
	moveq #1,d3
	cmpl d2,d3
	jeq L1130
	moveq #4,d3
	cmpl d2,d3
	jeq L1132
	jra L1134
	.even
L1130:
	movel a2@(72),d1
	movel d1,d0
	moveq #3,d2
	orl d2,d0
	movel d0,a2@(72)
	moveq #24,d3
	andl d3,d0
	jne L1138
	moveq #11,d0
	orl d1,d0
	movel d0,a2@(72)
	movel a2@(68),a0
	movel a2,sp@-
	movel a0@(120),a0
	jbsr a0@
	jra L1138
	.even
L1132:
	movel a2@(72),d1
	movel d1,d0
	moveq #5,d2
	orl d2,d0
	movel d0,a2@(72)
	moveq #24,d3
	andl d3,d0
	jne L1138
	moveq #21,d0
	orl d1,d0
	movel d0,a2@(72)
	movel a2@(68),a0
	movel a2,sp@-
	movel a0@(132),a0
	jbsr a0@
	jra L1138
	.even
L1134:
	movel a2@(68),a0
	movew d0,a1
	movel a1,sp@-
	movew d1,a1
	movel a1,sp@-
	movel a2,sp@-
	movel a0@(8),a0
	jbsr a0@
	addw #12,sp
	cmpb #1,d0
	jne L1135
	moveq #1,d0
	orl d0,a2@(72)
	movel a2@(68),a0
	movel d2,sp@-
	movel a2,sp@-
	movel a0@(144),a0
	jbsr a0@
	jra L1138
	.even
L1135:
	moveq #-2,d2
	andl d2,a2@(72)
L1138:
	moveml a5@(-12),#0x40c
	unlk a5
	rts
	.even
.globl _mouseRelease__14AbstractButtonssUl
_mouseRelease__14AbstractButtonssUl:
	pea a5@
	movel sp,a5
	moveml #0x3020,sp@-
	movel a5@(8),a2
	movel a5@(20),d2
	movew a5@(14),d1
	movew a5@(18),d0
	moveq #1,d3
	cmpl d2,d3
	jeq L1141
	moveq #4,d3
	cmpl d2,d3
	jeq L1145
	jra L1149
	.even
L1141:
	moveq #-3,d2
	andl d2,a2@(72)
	movel a2@(68),a0
	movew d0,a1
	movel a1,sp@-
	movew d1,a1
	movel a1,sp@-
	movel a2,sp@-
	movel a0@(8),a0
	jbsr a0@
	addw #12,sp
	cmpb #1,d0
	jne L1142
	movel a2@(72),d0
	btst #3,d0
	jeq L1142
	moveq #-9,d1
	andl d0,d1
	movel d1,a2@(72)
	movel a2@(68),a0
	movel a2,sp@-
	movel a0@(128),a0
	jbsr a0@
	jra L1152
	.even
L1142:
	movel a2@(72),d0
	moveq #-2,d2
	andl d0,d2
	movel d2,a2@(72)
	moveq #24,d3
	andl d3,d0
	jne L1152
	movel a2@(68),a0
	movel a2,sp@-
	movel a0@(124),a0
	jbsr a0@
	jra L1152
	.even
L1145:
	moveq #-5,d2
	andl d2,a2@(72)
	movel a2@(68),a0
	movew d0,a1
	movel a1,sp@-
	movew d1,a1
	movel a1,sp@-
	movel a2,sp@-
	movel a0@(8),a0
	jbsr a0@
	addw #12,sp
	cmpb #1,d0
	jne L1146
	movel a2@(72),d0
	btst #4,d0
	jeq L1146
	moveq #-17,d1
	andl d0,d1
	movel d1,a2@(72)
	movel a2@(68),a0
	movel a2,sp@-
	movel a0@(140),a0
	jbsr a0@
	jra L1152
	.even
L1146:
	movel a2@(72),d0
	moveq #-2,d2
	andl d0,d2
	movel d2,a2@(72)
	moveq #24,d3
	andl d3,d0
	jne L1152
	movel a2@(68),a0
	movel a2,sp@-
	movel a0@(136),a0
	jbsr a0@
	jra L1152
	.even
L1149:
	movel a2@(68),a0
	movew d0,a1
	movel a1,sp@-
	movew d1,a1
	movel a1,sp@-
	movel a2,sp@-
	movel a0@(8),a0
	jbsr a0@
	addw #12,sp
	tstb d0
	jne L1150
	moveq #-2,d0
	andl d0,a2@(72)
L1150:
	movel a2@(68),a0
	movel d2,sp@-
	movel a2,sp@-
	movel a0@(148),a0
	jbsr a0@
L1152:
	moveml a5@(-12),#0x40c
	unlk a5
	rts
	.even
.globl _mouseMove__14AbstractButtonssss
_mouseMove__14AbstractButtonssss:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel a5@(8),a2
	movel a2@(68),a0
	movew a5@(18),a1
	movel a1,sp@-
	movew a5@(14),a1
	movel a1,sp@-
	movel a2,sp@-
	movel a0@(8),a0
	jbsr a0@
	addw #12,sp
	cmpb #1,d0
	jne L1154
	moveb a2@(75),d0
	eorb #1,d0
	btst #0,d0
	jeq L1158
	moveq #1,d0
	orl d0,a2@(72)
	movel a2@(68),a0
	movel a2,sp@-
	movel a0@(104),a0
	jbsr a0@
	jra L1158
	.even
L1154:
	movel a2@(72),d0
	btst #0,d0
	jeq L1158
	moveq #-2,d1
	andl d0,d1
	movel d1,a2@(72)
	movel a2@(68),a0
	movel a2,sp@-
	movel a0@(108),a0
	jbsr a0@
L1158:
	movel a5@(-4),a2
	unlk a5
	rts
	.even
.globl _mouseDrag__14AbstractButtonssssUl
_mouseDrag__14AbstractButtonssssUl:
	pea a5@
	movel sp,a5
	moveml #0x3830,sp@-
	movel a5@(8),a2
	movel a5@(28),d4
	movew a5@(14),d3
	movew a5@(18),d1
	movew a5@(22),d2
	moveq #24,d0
	andl a2@(72),d0
	jne L1160
	movel a2@(68),a1
	movew d1,a0
	movel a0,sp@-
	movew d2,a3
	movel a3,sp@-
	movel a0,sp@-
	movew d3,a0
	movel a0,sp@-
	movel a2,sp@-
	movel a1@(52),a0
	jbsr a0@
	jra L1159
	.even
L1160:
	movel a2@(68),a0
	movew d1,a1
	movel a1,sp@-
	movew d3,a3
	movel a3,sp@-
	movel a2,sp@-
	movel a0@(8),a0
	jbsr a0@
	addw #12,sp
	cmpb #1,d0
	jne L1161
	moveb a2@(75),d0
	eorb #1,d0
	btst #0,d0
	jeq L1159
	moveq #1,d0
	orl d0,a2@(72)
	movel a2@(68),a0
	movel d4,sp@-
	movel a2,sp@-
	movel a0@(112),a0
	jbsr a0@
	jra L1159
	.even
L1161:
	movel a2@(72),d0
	btst #0,d0
	jeq L1159
	moveq #-2,d1
	andl d0,d1
	movel d1,a2@(72)
	movel a2@(68),a0
	movel d4,sp@-
	movel a2,sp@-
	movel a0@(116),a0
	jbsr a0@
L1159:
	moveml a5@(-20),#0xc1c
	unlk a5
	rts
	.even
.globl _passMouseMove__14AbstractButtonssss
_passMouseMove__14AbstractButtonssss:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel a5@(8),a0
	movel a0@(68),a1
	movew a5@(26),a2
	movel a2,sp@-
	movew a5@(22),a2
	movel a2,sp@-
	movew a5@(18),a2
	movel a2,sp@-
	movew a5@(14),a2
	movel a2,sp@-
	movel a0,sp@-
	movel a1@(52),a0
	jbsr a0@
	movel a5@(-4),a2
	unlk a5
	rts
.globl ___vt_14AbstractButton
	.even
___vt_14AbstractButton:
	.long 0
	.long 0
	.long _coordHit__9GUIObjectss
	.long _setEnabled__9GUIObject
	.long _setDisabled__9GUIObject
	.long _setActive__9GUIObject
	.long _setInactive__14AbstractButton
	.long _keyPressNP__9GUIObjectQ23Key7CtrlKey
	.long _keyReleaseNP__9GUIObjectQ23Key7CtrlKey
	.long _keyPress__9GUIObjectl
	.long _keyRelease__9GUIObjectl
	.long _mousePress__14AbstractButtonssUl
	.long _mouseRelease__14AbstractButtonssUl
	.long _mouseMove__14AbstractButtonssss
	.long _mouseDrag__14AbstractButtonssssUl
	.long _mouseScroll__9GUIObjectss
	.long _passKeyPressNP__9GUIObjectQ23Key7CtrlKey
	.long _passKeyReleaseNP__9GUIObjectQ23Key7CtrlKey
	.long _passKeyPress__9GUIObjectl
	.long _passKeyRelease__9GUIObjectl
	.long _passMousePress__9GUIObjectssUl
	.long _passMouseRelease__9GUIObjectssUl
	.long _passMouseMove__14AbstractButtonssss
	.long _passMouseDrag__9GUIObjectssssUl
	.long _passMouseScroll__9GUIObjectss
	.long __$_14AbstractButton
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
	.long ___pure_virtual
	.long ___pure_virtual
	.skip 4
	.even
.globl _setInactive__14AbstractButton
_setInactive__14AbstractButton:
	pea a5@
	movel sp,a5
	movel a5@(8),a0
	clrl a0@(72)
	unlk a5
	rts
	.even
.globl _checkButtonState__14AbstractButtonUl
_checkButtonState__14AbstractButtonUl:
	pea a5@
	movel sp,a5
	movel a5@(8),a0
	movel a0@(72),d0
	andl a5@(12),d0
	unlk a5
	rts
	.even
.globl ___14AbstractButton
___14AbstractButton:
	link a5,#-52
	fmovem #0xfc,sp@-
	moveml #0x3f3a,sp@-
	jbsr ___get_eh_context
	movel d0,a5@(-52)
	movel a5@(8),sp@-
	jbsr ___9GUIObject
	movel a5@(-52),a0
	addql #4,a0
	movel a0@,a5@(-24)
	clrl a5@(-20)
	movel a5,a5@(-16)
	movel #L1104,a5@(-12)
	movel sp,a5@(-8)
L1104:
	lea a5@(-24),a1
	movel a1,a0@
	movel a5@(8),a0
	movel #___vt_14AbstractButton,a0@(68)
	clrl a0@(72)
	movel a5@(-52),a1
	addql #4,a1
	movel a1@,a0
	movel a0@,a1@
	movel a5@(8),d0
	moveml a5@(-164),#0x5cfc
	fmovem a5@(-124),#0x3f
	unlk a5
	rts
	.even
.globl __$_14AbstractButton
__$_14AbstractButton:
	pea a5@
	movel sp,a5
	movel a5@(8),a0
	movel #___vt_14AbstractButton,a0@(68)
	movel a5@(12),sp@-
	movel a0,sp@-
	jbsr __$_9GUIObject
	unlk a5
	rts
