#NO_APP
.globl __3Mem$allocated
.data
	.even
__3Mem$allocated:
	.long 0
.globl __3Mem$volatileBuff
	.even
__3Mem$volatileBuff:
	.long 0
.globl __3Mem$totalSize
	.even
__3Mem$totalSize:
	.long 0
.globl __3Mem$nextFree
	.even
__3Mem$nextFree:
	.long 0
.globl __3Mem$count
	.even
__3Mem$count:
	.long 0
.globl __3Mem$maxAllocs
	.even
__3Mem$maxAllocs:
	.long 0
.text
LC0:
	.ascii "Mem::init() unable to allocate list memory\0"
LC1:
	.ascii "Mem initialized\0"
	.even
.globl _init__3Mem
_init__3Mem:
	pea a5@
	movel sp,a5
	movel #65537,sp@-
	pea 16384:w
	jbsr _AllocVec
	movel d0,__3Mem$allocated
	addql #8,sp
	jeq L21
	addl #8208,d0
	movel d0,__3Mem$volatileBuff
	clrl sp@-
	pea LC1
	jbsr _printDebug__9SystemLibPCci
	clrl d0
	jra L22
	.even
L21:
	pea 2:w
	pea LC0
	jbsr _printDebug__9SystemLibPCci
	movel #-50528257,d0
L22:
	unlk a5
	rts
LC2:
	.ascii "Mem::done()\12Released %d block(s)\12totalling %d bytes\12\0"
LC3:
	.ascii "Proceed\0"
LC4:
	.ascii "Debug Info\0"
LC5:
	.ascii "Mem finalized\0"
	.even
.globl _done__3Mem
_done__3Mem:
	pea a5@
	movel sp,a5
	moveml #0x3830,sp@-
	tstl __3Mem$allocated
	jeq L24
	clrl d3
	clrl d4
	clrl d2
	lea _FreeVec,a3
	.even
L28:
	movel __3Mem$allocated,a0
	movel d2,a2
	movel a2,d0
	lsll #4,d0
	movel d0,a2
	movel a0@(a2:l),d0
	jeq L27
	movel d0,sp@-
	jbsr a3@
	movel __3Mem$allocated,a0
	movel a0@(8,a2:l),d0
	subl d0,__3Mem$totalSize
	addl d0,d4
	clrl a0@(a2:l)
	clrl a0@(4,a2:l)
	clrl a0@(8,a2:l)
	clrl a0@(12,a2:l)
	addql #1,d3
	subql #1,__3Mem$count
	addql #4,sp
L27:
	addql #1,d2
	cmpl #511,d2
	jle L28
	tstl d3
	jeq L31
	movel d4,sp@-
	movel d3,sp@-
	pea LC2
	pea LC3
	pea LC4
	jbsr _dialogueBox__9SystemLibPCcN21e
	addw #20,sp
L31:
	movel __3Mem$allocated,sp@-
	jbsr a3@
	clrl __3Mem$allocated
	clrl __3Mem$volatileBuff
	clrl sp@-
	pea LC5
	jbsr _printDebug__9SystemLibPCci
L24:
	moveml a5@(-20),#0xc1c
	unlk a5
	rts
	.even
.globl _alloc__3MemUlbQ23Mem9AlignType
_alloc__3MemUlbQ23Mem9AlignType:
	pea a5@
	movel sp,a5
	moveml #0x3c00,sp@-
	movel a5@(8),d5
	movel a5@(16),d1
	tstl __3Mem$allocated
	jeq L39
	cmpl #512,__3Mem$count
	jeq L39
	moveq #8,d0
	cmpl d1,d0
	sls d0
	extbl d0
	movel d1,d3
	andl d0,d3
	moveq #1,d0
	tstb a5@(15)
	jeq L37
	addl #65536,d0
L37:
	movel d0,sp@-
	movel d5,a0
	pea a0@(d3:l:2)
	jbsr _AllocVec
	movel d0,d1
	addql #8,sp
	jeq L39
	movel __3Mem$nextFree,d4
	movel __3Mem$allocated,a0
	movel d4,d2
	lsll #4,d2
	movel d1,a0@(d2:l)
	tstl d3
	jeq L40
	movel d3,d0
	subql #1,d0
	addl d0,d1
	notl d0
	andl d0,d1
L40:
	movel d1,a0@(4,d2:l)
	clrl sp@-
	jbsr _FindTask
	movel __3Mem$allocated,a0
	movel d4,d1
	lsll #4,d1
	movel d0,a0@(12,d1:l)
	movel d5,a0@(8,d1:l)
	addl d5,__3Mem$totalSize
	addql #1,__3Mem$count
	movel __3Mem$nextFree,d2
	movel d2,d0
	lsll #4,d0
	movel d1,a1
	tstl a0@(4,d0:l)
	jeq L43
	.even
L44:
	movel d2,d1
	addql #1,d1
	movel d1,d2
	movel d1,d0
	lsll #4,d0
	tstl a0@(4,d0:l)
	jne L44
	movel d1,__3Mem$nextFree
L43:
	movel __3Mem$allocated,a0
	movel a0@(4,a1:l),d0
	jra L46
	.even
L39:
	clrl d0
L46:
	moveml a5@(-16),#0x3c
	unlk a5
	rts
	.even
.globl _free__3MemPv
_free__3MemPv:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel d2,sp@-
	movel a5@(8),d0
	movel __3Mem$allocated,a1
	tstl a1
	jeq L48
	tstl d0
	jeq L48
	moveq #-1,d2
	lea a1@(-12),a0
	.even
L53:
	addql #1,d2
	addw #16,a0
	cmpl a0@,d0
	jeq L60
	cmpl #511,d2
	jle L53
	jra L48
	.even
L60:
	movel d2,a2
	movel a2,d0
	lsll #4,d0
	movel d0,a2
	movel a1@(a2:l),d0
	jeq L48
	movel d0,sp@-
	jbsr _FreeVec
	movel __3Mem$allocated,a0
	movel a0@(8,a2:l),d0
	subl d0,__3Mem$totalSize
	clrl a0@(a2:l)
	clrl a0@(4,a2:l)
	clrl a0@(12,a2:l)
	clrl a0@(8,a2:l)
	subql #1,__3Mem$count
	cmpl __3Mem$nextFree,d2
	jge L48
	movel d2,__3Mem$nextFree
L48:
	movel a5@(-8),d2
	movel a5@(-4),a2
	unlk a5
	rts
	.even
.globl _copy__3MemPvT1Ul
_copy__3MemPvT1Ul:
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
.globl _swap16__3MemPvT1Ul
_swap16__3MemPvT1Ul:
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
.globl _swap32__3MemPvT1Ul
_swap32__3MemPvT1Ul:
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
.globl _swap64__3MemPvT1Ul
_swap64__3MemPvT1Ul:
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
.comm ___ti7AppBase,8
LC6:
	.ascii "7AppBase\0"
