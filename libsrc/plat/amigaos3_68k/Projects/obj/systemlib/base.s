#NO_APP
.globl _IntuitionBase
.data
	.even
_IntuitionBase:
	.long 0
.globl __24_GLOBAL_$N$IntuitionBase$memSemaphore
	.even
__24_GLOBAL_$N$IntuitionBase$memSemaphore:
	.long 0
.globl __24_GLOBAL_$N$IntuitionBase$memPool
	.even
__24_GLOBAL_$N$IntuitionBase$memPool:
	.long 0
.globl __24_GLOBAL_$N$IntuitionBase$puddleSize
	.even
__24_GLOBAL_$N$IntuitionBase$puddleSize:
	.long 0
.globl __24_GLOBAL_$N$IntuitionBase$threshSize
	.even
__24_GLOBAL_$N$IntuitionBase$threshSize:
	.long 0
.globl __9SystemLib$debug
__9SystemLib$debug:
	.byte 0
.text
LC0:
	.ascii "-sysdebug\0"
LC1:
	.ascii "-syspuddlesize\0"
LC2:
	.ascii "intuition.library\0"
LC3:
	.ascii "SystemLib error : Failed to open intuition library v39\0"
LC4:
	.ascii "SystemLib error : Failed to create primary memory semaphore\0"
LC5:
	.ascii "SystemLib error : Failed to create primary memory pool\0"
LC6:
	.ascii "SystemLib created memory pool\0"
LC7:
	.ascii "SystemLib initialised\0"
	.even
.globl _init__9SystemLib
_init__9SystemLib:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	subql #2,sp
	moveb #1,sp@(1)
	subql #2,sp
	pea LC0
	jbsr _getSwitch__7AppBasePCcb
	moveb d0,__9SystemLib$debug
	subql #2,sp
	moveb #1,sp@(1)
	subql #2,sp
	pea LC1
	jbsr _getInteger__7AppBasePCcb
	addw #16,sp
	cmpl #4096,d0
	jlt L23
	cmpl #65536,d0
	jle L25
	moveq #1,d0
	swap d0
	jra L25
	.even
L23:
	movel #4096,d0
L25:
	movel d0,__24_GLOBAL_$N$IntuitionBase$puddleSize
	moveq #-64,d1
	addl d0,d1
	movel d1,__24_GLOBAL_$N$IntuitionBase$threshSize
	pea 39:w
	pea LC2
	jbsr _OpenLibrary
	movel d0,_IntuitionBase
	addql #8,sp
	jne L28
	pea 2:w
	pea LC3
	jra L34
	.even
L28:
	pea 1:w
	pea 46:w
	jbsr _AllocMem
	movel d0,__24_GLOBAL_$N$IntuitionBase$memSemaphore
	addql #8,sp
	jne L29
	pea 2:w
	pea LC4
	jra L34
	.even
L29:
	movel __24_GLOBAL_$N$IntuitionBase$threshSize,sp@-
	movel __24_GLOBAL_$N$IntuitionBase$puddleSize,sp@-
	pea 1:w
	jbsr _CreatePool
	movel d0,__24_GLOBAL_$N$IntuitionBase$memPool
	addw #12,sp
	jeq L30
	clrl sp@-
	pea LC6
	lea _printDebug__9SystemLibPCci,a2
	jbsr a2@
	addqw #4,sp
	clrl sp@
	pea LC7
	jbsr a2@
	movel __24_GLOBAL_$N$IntuitionBase$memSemaphore,sp@-
	jbsr _InitSemaphore
	clrl d0
	jra L33
	.even
L30:
	pea 2:w
	pea LC5
L34:
	jbsr _printDebug__9SystemLibPCci
	movel #-50659333,d0
L33:
	movel a5@(-4),a2
	unlk a5
	rts
LC8:
	.ascii "SystemLib freed memory pool\0"
LC9:
	.ascii "SystemLib finalized\0"
	.even
.globl _done__9SystemLib
_done__9SystemLib:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	lea _printDebug__9SystemLibPCci,a2
	tstl __24_GLOBAL_$N$IntuitionBase$memPool
	jeq L36
	clrl sp@-
	pea LC8
	jbsr a2@
	movel __24_GLOBAL_$N$IntuitionBase$memPool,sp@-
	jbsr _DeletePool
	clrl __24_GLOBAL_$N$IntuitionBase$memPool
	addw #12,sp
L36:
	movel __24_GLOBAL_$N$IntuitionBase$memSemaphore,d0
	jeq L37
	pea 46:w
	movel d0,sp@-
	jbsr _FreeMem
	clrl __24_GLOBAL_$N$IntuitionBase$memSemaphore
	addql #8,sp
L37:
	movel _IntuitionBase,d0
	jeq L38
	movel d0,sp@-
	jbsr _CloseLibrary
	clrl _IntuitionBase
	addql #4,sp
L38:
	clrl sp@-
	pea LC9
	jbsr a2@
	movel a5@(-4),a2
	unlk a5
	rts
LC10:
	.ascii "[ Info    ] %s\12\0"
LC11:
	.ascii "[ Warning ] %s\12\0"
LC12:
	.ascii "[ Error   ] %s\12\0"
LC13:
	.ascii "[ <Other> ] %s\12\0"
	.even
.globl _printDebug__9SystemLibPCci
_printDebug__9SystemLibPCci:
	pea a5@
	movel sp,a5
	movel d2,sp@-
	movel a5@(8),d1
	movel a5@(12),d0
	tstb __9SystemLib$debug
	jeq L49
	moveq #1,d2
	cmpl d0,d2
	jeq L44
	jlt L48
	tstl d0
	jeq L43
	jra L46
	.even
L48:
	moveq #2,d2
	cmpl d0,d2
	jeq L45
	jra L46
	.even
L43:
	movel d1,sp@-
	pea LC10
	jbsr _printf
	jra L49
	.even
L44:
	movel d1,sp@-
	pea LC11
	jbsr _printf
	jra L49
	.even
L45:
	movel d1,sp@-
	pea LC12
	jbsr _printf
	jra L49
	.even
L46:
	movel d1,sp@-
	pea LC13
	jbsr _printf
L49:
	movel a5@(-4),d2
	unlk a5
	rts
	.even
.globl _dialogueBox__9SystemLibPCcN21e
_dialogueBox__9SystemLibPCcN21e:
	link a5,#-20
	movel d3,sp@-
	movel d2,sp@-
	pea 1:w
	pea 8192:w
	jbsr _AllocMem
	movel d0,d3
	clrl d2
	addql #8,sp
	tstl d3
	jeq L51
	moveq #20,d2
	addl a5,d2
	movel d2,sp@-
	movel a5@(16),sp@-
	movel d3,sp@-
	jbsr _vsprintf
	clrl a5@(-16)
	moveq #20,d0
	movel d0,a5@(-20)
	movel a5@(8),a5@(-12)
	movel d3,a5@(-8)
	movel a5@(12),a5@(-4)
	movel d2,sp@-
	clrl sp@-
	pea a5@(-20)
	clrl sp@-
	jbsr _EasyRequest
	movel d0,d2
	pea 8192:w
	movel d3,sp@-
	jbsr _FreeMem
L51:
	movel d2,d0
	movel a5@(-28),d2
	movel a5@(-24),d3
	unlk a5
	rts
LC14:
	.ascii "Multiview\0"
LC15:
	.ascii "Run >NIL: %s \"%s\" \0"
	.even
.globl _openDebugFile__9SystemLibPCc
_openDebugFile__9SystemLibPCc:
	pea a5@
	movel sp,a5
	movel d3,sp@-
	movel d2,sp@-
	movel a5@(8),d3
	pea 1:w
	pea 8192:w
	jbsr _AllocMem
	movel d0,d2
	movel d3,sp@-
	pea LC14
	pea LC15
	movel d2,sp@-
	jbsr _sprintf
	addw #20,sp
	movel d2,sp@
	jbsr _system
	movel #8192,sp@
	movel d2,sp@-
	jbsr _FreeMem
	movel a5@(-8),d2
	movel a5@(-4),d3
	unlk a5
	rts
	.even
.globl _alloc__3MemUlbQ23Mem9AlignType
_alloc__3MemUlbQ23Mem9AlignType:
	pea a5@
	movel sp,a5
	moveml #0x3800,sp@-
	movel a5@(8),d4
	moveq #48,d3
	addl d4,d3
	movel __24_GLOBAL_$N$IntuitionBase$memSemaphore,sp@-
	jbsr _ObtainSemaphore
	movel d3,sp@-
	movel __24_GLOBAL_$N$IntuitionBase$memPool,sp@-
	jbsr _AllocPooled
	clrl d2
	addw #12,sp
	tstl d0
	jeq L56
	movel d0,a1
	lea a1@(15),a0
	movel a0,d1
	moveq #-16,d2
	andl d2,d1
	movel d1,a0
	movel #-1393885003,a0@
	clrl a0@(4)
	movel d3,a0@(8)
	movel d0,a0@(12)
	moveq #16,d2
	addl a0,d2
L56:
	movel __24_GLOBAL_$N$IntuitionBase$memSemaphore,sp@-
	jbsr _ReleaseSemaphore
	addql #4,sp
	tstl d2
	jeq L57
	tstb a5@(15)
	jeq L57
	movel d4,sp@-
	movel d2,sp@-
	jbsr _zero__3MemPvUl
L57:
	movel d2,d0
	moveml a5@(-12),#0x1c
	unlk a5
	rts
	.even
.globl _free__3MemPv
_free__3MemPv:
	pea a5@
	movel sp,a5
	movel d3,sp@-
	movel d2,sp@-
	movel a5@(8),d0
	jeq L59
	tstl __24_GLOBAL_$N$IntuitionBase$memPool
	jeq L59
	movel d0,a1
	lea a1@(-16),a0
	cmpl #-1393885003,a0@
	jne L59
	clrl a0@
	movel a0@(8),d2
	movel a0@(12),d3
	movel __24_GLOBAL_$N$IntuitionBase$memSemaphore,sp@-
	jbsr _ObtainSemaphore
	movel d2,sp@-
	movel d3,sp@-
	movel __24_GLOBAL_$N$IntuitionBase$memPool,sp@-
	jbsr _FreePooled
	movel __24_GLOBAL_$N$IntuitionBase$memSemaphore,sp@-
	jbsr _ReleaseSemaphore
L59:
	movel a5@(-8),d2
	movel a5@(-4),d3
	unlk a5
	rts
	.even
.globl _copy__3MemPvPCvUl
_copy__3MemPvPCvUl:
	pea a5@
	movel sp,a5
#APP
	
/*************************************/

	move.l a5@(8), a0
	move.l a5@(12), a1
	move.l a5@(16), d0
	jsr copy__Mem__r8Pvr9Pvr0Ui

/*************************************/


#NO_APP
	unlk a5
	rts
	.even
.globl _swap16__3MemPvPCvUl
_swap16__3MemPvPCvUl:
	pea a5@
	movel sp,a5
#APP
	
/*************************************/

	move.l a5@(8), a0
	move.l a5@(12), a1
	move.l a5@(16), d0
	jsr swap16__Mem__r8Pvr9Pvr0Ui

/*************************************/


#NO_APP
	unlk a5
	rts
	.even
.globl _swap32__3MemPvPCvUl
_swap32__3MemPvPCvUl:
	pea a5@
	movel sp,a5
#APP
	
/*************************************/

	move.l a5@(8), a0
	move.l a5@(12), a1
	move.l a5@(16), d0
	jsr swap32__Mem__r8Pvr9Pvr0Ui

/*************************************/


#NO_APP
	unlk a5
	rts
	.even
.globl _swap64__3MemPvPCvUl
_swap64__3MemPvPCvUl:
	pea a5@
	movel sp,a5
#APP
	
/*************************************/

	move.l a5@(8), a0
	move.l a5@(12), a1
	move.l a5@(16), d0
	jsr swap64__Mem__r8Pvr9Pvr0Ui

/*************************************/


#NO_APP
	unlk a5
	rts
	.even
.globl _zero__3MemPvUl
_zero__3MemPvUl:
	pea a5@
	movel sp,a5
#APP
	
/*************************************/

	move.l a5@(8), a0
	move.l a5@(12), d0
	jsr zero__Mem__r8Pvr0Ui

/*************************************/


#NO_APP
	unlk a5
	rts
	.even
.globl _set__3MemPviUl
_set__3MemPviUl:
	pea a5@
	movel sp,a5
#APP
	
/*************************************/

	move.l a5@(8), a0
	move.l a5@(12), d0
	move.l a5@(16), d1
	jsr set__Mem__r8Pvr0ir1Ui

/*************************************/


#NO_APP
	unlk a5
	rts
	.even
.globl _set16__3MemPvUsUl
_set16__3MemPvUsUl:
	pea a5@
	movel sp,a5
#APP
	
/*************************************/

	move.l a5@(8), a0
	move.l a5@(14), d0
	move.l a5@(16), d1
	jsr set16__Mem__r8Pvr0Usr1Ui

/*************************************/


#NO_APP
	unlk a5
	rts
	.even
.globl _set32__3MemPvUlUl
_set32__3MemPvUlUl:
	pea a5@
	movel sp,a5
#APP
	
/*************************************/

	move.l a5@(8), a0
	move.l a5@(12), d0
	move.l a5@(16), d1
	jsr set32__Mem__r8Pvr0Ujr1Ui

/*************************************/


#NO_APP
	unlk a5
	rts
	.even
.globl _set64__3MemPvRCUxUl
_set64__3MemPvRCUxUl:
	pea a5@
	movel sp,a5
#APP
	
/*************************************/

	move.l a5@(8), a0
	move.l a5@(12), a1
	move.l a5@(16), d0
	jsr set64__Mem__r8Pvr9RUlr0Ui

/*************************************/


#NO_APP
	unlk a5
	rts
.globl __3Mem$_copy
.data
	.even
__3Mem$_copy:
	.long 0
.globl __3Mem$_swap16
	.even
__3Mem$_swap16:
	.long 0
.globl __3Mem$_swap32
	.even
__3Mem$_swap32:
	.long 0
.globl __3Mem$_swap64
	.even
__3Mem$_swap64:
	.long 0
.globl __3Mem$_set
	.even
__3Mem$_set:
	.long 0
.globl __3Mem$_set16
	.even
__3Mem$_set16:
	.long 0
.globl __3Mem$_set32
	.even
__3Mem$_set32:
	.long 0
.globl __3Mem$_set64
	.even
__3Mem$_set64:
	.long 0
