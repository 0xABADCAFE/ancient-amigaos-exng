#NO_APP
.globl __7GUIBase$active
.data
	.even
__7GUIBase$active:
	.long 0
.text
	.even
.globl ___7GUIBase
___7GUIBase:
	link a5,#-52
	fmovem #0xfc,sp@-
	moveml #0x3f3a,sp@-
	jbsr ___get_eh_context
	movel d0,a5@(-52)
	movel #124799,sp@-
	movel a5@(8),sp@-
	jbsr ___10InputFocusUl
	movel a5@(-52),a0
	addql #4,a0
	movel a0@,a5@(-24)
	clrl a5@(-20)
	movel a5,a5@(-16)
	movel #L1103,a5@(-12)
	movel sp,a5@(-8)
	movel a0,a1
	jra L1102
	.even
L1103:
	jra L1115
	.even
L1102:
	lea a5@(-24),a2
	movel a2,a0@
	movel a5@(8),a0
	movel #___vt_7GUIBase,a0@(36)
	clrl a0@(40)
	clrl a0@(44)
	movel a1@,a0
	movel a0@,a1@
	movel a5@(8),d0
	jra L1114
	.even
L1115:
L1100:
	movel a5@(-52),a0
	addql #4,a0
	movel a0@,a5@(-48)
	clrl a5@(-44)
	movel a5,a5@(-40)
	movel #L1108,a5@(-36)
	movel sp,a5@(-32)
	jra L1107
	.even
L1108:
	jra L1116
	.even
L1107:
	lea a5@(-48),a1
	movel a1,a0@
	movel a5@(8),a2
	movel #___vt_10InputFocus,a2@(36)
	movel a5@(-52),a1
	addql #4,a1
	movel a1@,a0
	movel a0@,a1@
	jbsr ___sjthrow
	.even
L1116:
L1105:
	jbsr ___terminate
	.even
L1114:
	moveml a5@(-164),#0x5cfc
	fmovem a5@(-124),#0x3f
	unlk a5
	rts
	.even
.globl __$_7GUIBase
__$_7GUIBase:
	pea a5@
	movel sp,a5
	movel a5@(8),a0
	movel #___vt_10InputFocus,a0@(36)
	btst #0,a5@(15)
	jeq L1122
	movel a0,sp@-
	jbsr ___builtin_delete
L1122:
	unlk a5
	rts
LC0:
	.ascii "GUIBase::find() - nothing found\0"
LC1:
	.ascii "GUIBase::find() - no root\0"
	.even
.globl _find__7GUIBasess
_find__7GUIBasess:
	pea a5@
	movel sp,a5
	moveml #0x3a,sp@-
	movel a5@(8),a6
	movew a5@(14),a0
	movew a5@(18),d1
	movel a6@(40),d0
	jeq L1124
	movel d0,sp@-
	movew d1,a4
	movel a4,sp@-
	movew a0,a3
	movel a3,sp@-
	movel d0,sp@-
	jbsr _recFindHit__9GUIObjectssP9GUIObject
	movel d0,a2
	addw #16,sp
	cmpl a6@(40),a2
	jne L1125
	movel a2@(68),a0
	movel a4,sp@-
	movel a3,sp@-
	movel a2,sp@-
	movel a0@(8),a0
	jbsr a0@
	addw #12,sp
	tstb d0
	jne L1125
	clrl sp@-
	pea LC0
	jra L1127
	.even
L1125:
	movel a2,d0
	jra L1126
	.even
L1124:
	clrl sp@-
	pea LC1
L1127:
	jbsr _printDebug__9SystemLibPCci
	clrl d0
L1126:
	moveml a5@(-16),#0x5c00
	unlk a5
	rts
	.even
.globl _keyPressNonPrintable__7GUIBaseP15InputDispatcherQ23Key7CtrlKey
_keyPressNonPrintable__7GUIBaseP15InputDispatcherQ23Key7CtrlKey:
	pea a5@
	movel sp,a5
	movel d2,sp@-
	movel a5@(8),a0
	movel a5@(16),d2
	btst #0,a0@(47)
	jeq L1129
	movel d2,sp@-
	movel a0@(40),sp@-
	jbsr _recKeyPressNP__9GUIObjectQ23Key7CtrlKey
	addql #8,sp
L1129:
	movel __7GUIBase$active,a1
	tstl a1
	jeq L1130
	btst #1,a1@(55)
	jeq L1130
	movel a1@(68),a0
	movel d2,sp@-
	movel a1,sp@-
	movel a0@(28),a0
	jbsr a0@
L1130:
	movel a5@(-4),d2
	unlk a5
	rts
	.even
.globl _keyReleaseNonPrintable__7GUIBaseP15InputDispatcherQ23Key7CtrlKey
_keyReleaseNonPrintable__7GUIBaseP15InputDispatcherQ23Key7CtrlKey:
	pea a5@
	movel sp,a5
	movel d2,sp@-
	movel a5@(8),a0
	movel a5@(16),d2
	btst #0,a0@(47)
	jeq L1133
	movel d2,sp@-
	movel a0@(40),sp@-
	jbsr _recKeyReleaseNP__9GUIObjectQ23Key7CtrlKey
	addql #8,sp
L1133:
	movel __7GUIBase$active,a1
	tstl a1
	jeq L1134
	btst #3,a1@(55)
	jeq L1134
	movel a1@(68),a0
	movel d2,sp@-
	movel a1,sp@-
	movel a0@(32),a0
	jbsr a0@
L1134:
	movel a5@(-4),d2
	unlk a5
	rts
	.even
.globl _keyPressPrintable__7GUIBaseP15InputDispatcherl
_keyPressPrintable__7GUIBaseP15InputDispatcherl:
	pea a5@
	movel sp,a5
	movel d2,sp@-
	movel a5@(8),a0
	movel a5@(16),d2
	btst #0,a0@(47)
	jeq L1137
	movel d2,sp@-
	movel a0@(40),sp@-
	jbsr _recKeyPress__9GUIObjectl
	addql #8,sp
L1137:
	movel __7GUIBase$active,a1
	tstl a1
	jeq L1138
	btst #0,a1@(55)
	jeq L1138
	movel a1@(68),a0
	movel d2,sp@-
	movel a1,sp@-
	movel a0@(36),a0
	jbsr a0@
L1138:
	movel a5@(-4),d2
	unlk a5
	rts
	.even
.globl _keyReleasePrintable__7GUIBaseP15InputDispatcherl
_keyReleasePrintable__7GUIBaseP15InputDispatcherl:
	pea a5@
	movel sp,a5
	movel d2,sp@-
	movel a5@(8),a0
	movel a5@(16),d2
	btst #0,a0@(47)
	jeq L1141
	movel d2,sp@-
	movel a0@(40),sp@-
	jbsr _recKeyRelease__9GUIObjectl
	addql #8,sp
L1141:
	movel __7GUIBase$active,a1
	tstl a1
	jeq L1142
	btst #2,a1@(55)
	jeq L1142
	movel a1@(68),a0
	movel d2,sp@-
	movel a1,sp@-
	movel a0@(40),a0
	jbsr a0@
L1142:
	movel a5@(-4),d2
	unlk a5
	rts
LC2:
	.ascii "GUIBase::mousePress()\0"
	.even
.globl _mousePress__7GUIBaseP15InputDispatcherUl
_mousePress__7GUIBaseP15InputDispatcherUl:
	pea a5@
	movel sp,a5
	moveml #0x2030,sp@-
	movel a5@(8),a2
	movel a5@(16),d2
	clrl sp@-
	pea LC2
	jbsr _printDebug__9SystemLibPCci
	addql #8,sp
	moveq #1,d0
	cmpl d2,d0
	jeq L1146
	moveq #4,d0
	cmpl d2,d0
	jne L1145
L1146:
	movel __7GUIBase$active,a1
	tstl a1
	jeq L1148
	movel a1@(68),a0
	movew a2@(26),a3
	movel a3,sp@-
	movew a2@(24),a3
	movel a3,sp@-
	movel a1,sp@-
	movel a0@(8),a0
	jbsr a0@
	addw #12,sp
	tstb d0
	jne L1145
L1148:
	movew a2@(26),a0
	movel a0,sp@-
	movew a2@(24),a3
	movel a3,sp@-
	movel a2,sp@-
	jbsr _find__7GUIBasess
	movel d0,sp@-
	jbsr _setActive__7GUIBaseP9GUIObject
	addw #16,sp
L1145:
	btst #0,a2@(47)
	jeq L1153
	movel d2,sp@-
	movew a2@(26),a0
	movel a0,sp@-
	movew a2@(24),a3
	movel a3,sp@-
	movel a2@(40),sp@-
	jbsr _recMousePress__9GUIObjectssUl
	addw #16,sp
L1153:
	movel __7GUIBase$active,a1
	tstl a1
	jeq L1156
	moveq #112,d0
	andl a1@(52),d0
	jeq L1156
	movel a1@(68),a0
	movel d2,sp@-
	movew a2@(26),a3
	movel a3,sp@-
	movew a2@(24),a2
	movel a2,sp@-
	movel a1,sp@-
	movel a0@(44),a0
	jbsr a0@
L1156:
	moveml a5@(-12),#0xc04
	unlk a5
	rts
LC3:
	.ascii "GUIBase::mouseRelease()\0"
	.even
.globl _mouseRelease__7GUIBaseP15InputDispatcherUl
_mouseRelease__7GUIBaseP15InputDispatcherUl:
	pea a5@
	movel sp,a5
	moveml #0x2030,sp@-
	movel a5@(8),a2
	movel a5@(16),d2
	clrl sp@-
	pea LC3
	jbsr _printDebug__9SystemLibPCci
	addql #8,sp
	btst #0,a2@(47)
	jeq L1161
	movel d2,sp@-
	movew a2@(26),a0
	movel a0,sp@-
	movew a2@(24),a3
	movel a3,sp@-
	movel a2@(40),sp@-
	jbsr _recMouseRelease__9GUIObjectssUl
	addw #16,sp
L1161:
	movel __7GUIBase$active,a1
	tstl a1
	jeq L1164
	movel a1@(52),d0
	andl #1792,d0
	jeq L1164
	movel a1@(68),a0
	movel d2,sp@-
	movew a2@(26),a3
	movel a3,sp@-
	movew a2@(24),a2
	movel a2,sp@-
	movel a1,sp@-
	movel a0@(48),a0
	jbsr a0@
L1164:
	moveml a5@(-12),#0xc04
	unlk a5
	rts
	.even
.globl _mouseMove__7GUIBaseP15InputDispatcherssss
_mouseMove__7GUIBaseP15InputDispatcherssss:
	pea a5@
	movel sp,a5
	moveml #0x3c20,sp@-
	movel a5@(8),a0
	movew a5@(18),d5
	movew a5@(22),d4
	movew a5@(26),d3
	movew a5@(30),d2
	btst #0,a0@(47)
	jeq L1169
	movew d2,a1
	movel a1,sp@-
	movew d3,a2
	movel a2,sp@-
	movew d4,a1
	movel a1,sp@-
	movew d5,a2
	movel a2,sp@-
	movel a0@(40),sp@-
	jbsr _recMouseMove__9GUIObjectssss
	addw #20,sp
L1169:
	movel __7GUIBase$active,a1
	tstl a1
	jeq L1170
	btst #5,a1@(54)
	jeq L1170
	movel a1@(68),a0
	movew d2,a2
	movel a2,sp@-
	movew d3,a2
	movel a2,sp@-
	movew d4,a2
	movel a2,sp@-
	movew d5,a2
	movel a2,sp@-
	movel a1,sp@-
	movel a0@(52),a0
	jbsr a0@
L1170:
	moveml a5@(-20),#0x43c
	unlk a5
	rts
LC4:
	.ascii "GUIBase::mouseDrag()\0"
	.even
.globl _mouseDrag__7GUIBaseP15InputDispatcherssssUl
_mouseDrag__7GUIBaseP15InputDispatcherssssUl:
	pea a5@
	movel sp,a5
	moveml #0x3e20,sp@-
	movel a5@(8),a2
	movel a5@(32),d6
	movew a5@(18),d5
	movew a5@(22),d4
	movew a5@(26),d3
	movew a5@(30),d2
	clrl sp@-
	pea LC4
	jbsr _printDebug__9SystemLibPCci
	addql #8,sp
	btst #0,a2@(47)
	jeq L1173
	movel d6,sp@-
	movew d2,a0
	movel a0,sp@-
	movew d3,a0
	movel a0,sp@-
	movew d4,a0
	movel a0,sp@-
	movew d5,a0
	movel a0,sp@-
	movel a2@(40),sp@-
	jbsr _recMouseDrag__9GUIObjectssssUl
	addw #24,sp
L1173:
	movel __7GUIBase$active,a1
	tstl a1
	jeq L1174
	btst #6,a1@(54)
	jeq L1174
	movel a1@(68),a0
	movel d6,sp@-
	movew d2,a2
	movel a2,sp@-
	movew d3,a2
	movel a2,sp@-
	movew d4,a2
	movel a2,sp@-
	movew d5,a2
	movel a2,sp@-
	movel a1,sp@-
	movel a0@(56),a0
	jbsr a0@
L1174:
	moveml a5@(-24),#0x47c
	unlk a5
	rts
	.even
.globl _mouseScroll__7GUIBaseP15InputDispatcherss
_mouseScroll__7GUIBaseP15InputDispatcherss:
	pea a5@
	movel sp,a5
	moveml #0x3020,sp@-
	movel a5@(8),a0
	movew a5@(18),d3
	movew a5@(22),d2
	btst #0,a0@(47)
	jeq L1177
	movew d2,a1
	movel a1,sp@-
	movew d3,a2
	movel a2,sp@-
	movel a0@(40),sp@-
	jbsr _recMouseScroll__9GUIObjectss
	addw #12,sp
L1177:
	movel __7GUIBase$active,a1
	tstl a1
	jeq L1178
	movel a1@(52),d0
	andl #98304,d0
	jeq L1178
	movel a1@(68),a0
	movew d2,a2
	movel a2,sp@-
	movew d3,a2
	movel a2,sp@-
	movel a1,sp@-
	movel a0@(60),a0
	jbsr a0@
L1178:
	moveml a5@(-12),#0x40c
	unlk a5
	rts
	.even
.globl _setActive__7GUIBaseP9GUIObject
_setActive__7GUIBaseP9GUIObject:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel a5@(8),a2
	movel __7GUIBase$active,a1
	cmpl a2,a1
	jeq L1181
	tstl a1
	jeq L1182
	moveq #-3,d0
	andl d0,a1@(48)
	movel a1@(68),a0
	movel a1,sp@-
	movel a0@(24),a0
	jbsr a0@
	addql #4,sp
L1182:
	tstl a2
	jeq L1184
	moveq #2,d0
	orl d0,a2@(48)
	movel a2@(68),a0
	movel a2,sp@-
	movel a0@(20),a0
	jbsr a0@
L1184:
	movel a2,__7GUIBase$active
L1181:
	movel a5@(-4),a2
	unlk a5
	rts
	.even
.globl _draw__10RenderableP6Draw2D
_draw__10RenderableP6Draw2D:
	pea a5@
	movel sp,a5
	moveml #0x2030,sp@-
	movel a5@(8),a3
	movel a5@(12),a2
	tstl a2
	jne L1187
	movel #-50659333,d0
	jra L1189
	.even
L1187:
	movel a2@,a0
	movel a2,sp@-
	movel a0@(16),a0
	jbsr a0@
	movel d0,d2
	addql #4,sp
	jne L1188
	movel a3@(4),a0
	movel a2,sp@-
	movel a3,sp@-
	movel a0@(8),a0
	jbsr a0@
	movel d0,d2
	movel a2@,a0
	movel a2,sp@-
	movel a0@(20),a0
	jbsr a0@
L1188:
	movel d2,d0
L1189:
	moveml a5@(-12),#0xc04
	unlk a5
	rts
.globl ___vt_7GUIBase
	.even
___vt_7GUIBase:
	.long 0
	.long 0
	.long _keyPressNonPrintable__7GUIBaseP15InputDispatcherQ23Key7CtrlKey
	.long _keyReleaseNonPrintable__7GUIBaseP15InputDispatcherQ23Key7CtrlKey
	.long _keyPressPrintable__7GUIBaseP15InputDispatcherl
	.long _keyReleasePrintable__7GUIBaseP15InputDispatcherl
	.long _mousePress__7GUIBaseP15InputDispatcherUl
	.long _mouseRelease__7GUIBaseP15InputDispatcherUl
	.long _mouseMove__7GUIBaseP15InputDispatcherssss
	.long _mouseDrag__7GUIBaseP15InputDispatcherssssUl
	.long _mouseScroll__7GUIBaseP15InputDispatcherss
	.long _exitEvent__10InputFocusP15InputDispatcher
	.long __$_7GUIBase
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
	jeq L267
	movel a0,sp@-
	jbsr ___builtin_delete
L267:
	unlk a5
	rts
	.even
.globl _setRoot__7GUIBaseP9GUIObject
_setRoot__7GUIBaseP9GUIObject:
	pea a5@
	movel sp,a5
	movel a5@(8),a0
	movel a5@(12),a0@(40)
	unlk a5
	rts
	.even
.globl _getRoot__7GUIBase
_getRoot__7GUIBase:
	pea a5@
	movel sp,a5
	movel a5@(8),a0
	movel a0@(40),d0
	unlk a5
	rts
	.even
.globl _getActive__7GUIBase
_getActive__7GUIBase:
	pea a5@
	movel sp,a5
	movel __7GUIBase$active,d0
	unlk a5
	rts
	.even
.globl _enablePassive__7GUIBase
_enablePassive__7GUIBase:
	pea a5@
	movel sp,a5
	movel a5@(8),a0
	moveq #1,d0
	orl d0,a0@(44)
	unlk a5
	rts
	.even
.globl _disablePassive__7GUIBase
_disablePassive__7GUIBase:
	pea a5@
	movel sp,a5
	movel a5@(8),a0
	moveq #-2,d0
	andl d0,a0@(44)
	unlk a5
	rts
