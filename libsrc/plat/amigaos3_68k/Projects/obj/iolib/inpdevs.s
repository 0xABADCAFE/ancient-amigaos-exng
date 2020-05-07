#NO_APP
.globl _KeyMapBase
.data
	.even
_KeyMapBase:
	.long 0
.globl __9_NatInput$openCount
	.even
__9_NatInput$openCount:
	.long 0
.globl __9_NatInput$nonPrintMap
__9_NatInput$nonPrintMap:
	.byte 0
	.byte 0
	.byte 0
	.byte 0
	.byte 0
	.byte 0
	.byte 0
	.byte 0
	.byte 0
	.byte 0
	.byte 0
	.byte 0
	.byte 0
	.byte 0
	.byte 0
	.byte 29
	.byte 0
	.byte 0
	.byte 0
	.byte 0
	.byte 0
	.byte 0
	.byte 0
	.byte 0
	.byte 0
	.byte 0
	.byte 0
	.byte 0
	.byte 0
	.byte 30
	.byte 31
	.byte 32
	.byte 0
	.byte 0
	.byte 0
	.byte 0
	.byte 0
	.byte 0
	.byte 0
	.byte 0
	.byte 0
	.byte 0
	.byte 0
	.byte 0
	.byte 0
	.byte 33
	.byte 34
	.byte 35
	.byte 0
	.byte 0
	.byte 0
	.byte 0
	.byte 0
	.byte 0
	.byte 0
	.byte 0
	.byte 0
	.byte 0
	.byte 0
	.byte 0
	.byte 42
	.byte 36
	.byte 37
	.byte 38
	.byte 1
	.byte 2
	.byte 3
	.byte 43
	.byte 4
	.byte 5
	.byte 6
	.byte 0
	.byte 0
	.byte 0
	.byte 44
	.byte 0
	.byte 7
	.byte 8
	.byte 9
	.byte 10
	.byte 11
	.byte 12
	.byte 13
	.byte 14
	.byte 15
	.byte 16
	.byte 17
	.byte 18
	.byte 19
	.byte 20
	.byte 0
	.byte 0
	.byte 0
	.byte 0
	.byte 45
	.byte 0
	.byte 23
	.byte 24
	.byte 25
	.byte 26
	.byte 27
	.byte 28
	.byte 21
	.byte 22
	.byte 0
	.byte 0
	.byte 0
	.byte 0
	.byte 0
	.byte 0
	.byte 0
	.byte 0
	.byte 0
	.byte 0
	.byte 0
	.byte 0
	.byte 0
	.byte 0
	.byte 0
	.byte 0
	.byte 0
	.byte 0
	.byte 0
	.byte 0
	.byte 0
	.byte 0
	.byte 0
	.byte 0
.text
LC0:
	.ascii "keymap.library\0"
	.even
.globl ___9_NatInput
___9_NatInput:
	pea a5@
	movel sp,a5
	movel __9_NatInput$openCount,d0
	movel d0,d1
	addql #1,d1
	movel d1,__9_NatInput$openCount
	tstl d0
	jne L278
	pea 37:w
	pea LC0
	jbsr _OpenLibrary
	movel d0,_KeyMapBase
	jne L278
	clrl __9_NatInput$openCount
L278:
	movel a5@(8),d0
	unlk a5
	rts
	.even
.globl __$_9_NatInput
__$_9_NatInput:
	pea a5@
	movel sp,a5
	movel __9_NatInput$openCount,d0
	movel d0,d1
	subql #1,d1
	movel d1,__9_NatInput$openCount
	subql #1,d0
	jne L280
	movel _KeyMapBase,d0
	jeq L284
	movel d0,sp@-
	jbsr _CloseLibrary
	clrl _KeyMapBase
	addql #4,sp
	jra L284
	.even
L280:
	tstl d0
	jge L284
	clrl __9_NatInput$openCount
L284:
	movel a5@(12),d0
	btst #0,d0
	jeq L286
	movel a5@(8),sp@-
	jbsr ___builtin_delete
L286:
	unlk a5
	rts
	.even
.globl _directReadMouseX__9_NatInput
_directReadMouseX__9_NatInput:
	pea a5@
	movel sp,a5
	movel _IntuitionBase,a0
	movew a0@(70),d0
	extl d0
	unlk a5
	rts
	.even
.globl _directReadMouseY__9_NatInput
_directReadMouseY__9_NatInput:
	pea a5@
	movel sp,a5
	movel _IntuitionBase,a0
	movew a0@(68),d0
	extl d0
	unlk a5
	rts
	.even
.globl _directReadMouseState__9_NatInput
_directReadMouseState__9_NatInput:
	pea a5@
	movel sp,a5
	clrl d0
	unlk a5
	rts
