#NO_APP
.text
LC0:
	.ascii "bad_alloc\0"
.globl __10StartupLib$numStartArgs
.data
	.even
__10StartupLib$numStartArgs:
	.long 0
.globl __10StartupLib$startArgs
	.even
__10StartupLib$startArgs:
	.long 0
.text
	.even
.globl _init__10StartupLibiPPc
_init__10StartupLibiPPc:
	pea a5@
	movel sp,a5
	moveml #0x2030,sp@-
	movel a5@(8),d2
	movel d2,__10StartupLib$numStartArgs
	pea _nothrow
	movel d2,d0
	lsll #2,d0
	movel d0,sp@-
	jbsr ___vn__FUlRC9nothrow_t
	movel d0,__10StartupLib$startArgs
	addql #8,sp
	jne L92
	movel #-50528257,d0
	jra L98
	.even
L92:
	tstl d2
	jle L94
	movel d0,a3
	movel a5@(12),a2
	movel d2,d0
	movel d0,d1
	negl d1
	moveq #3,d2
	andl d2,d1
	jeq L96
	cmpl d1,d2
	jle L101
	moveq #2,d2
	cmpl d1,d2
	jle L102
	movel a2@+,a3@+
	subql #1,d0
L102:
	movel a2@+,a3@+
	subql #1,d0
L101:
	movel a2@+,a3@+
	subql #1,d0
	jeq L94
	.even
L96:
	movel a3,a1
	movel a2,a0
	movel a0@+,a1@+
	movel a0@,a1@
	movel a2@(8),a3@(8)
	movel a2@(12),a3@(12)
	addw #16,a2
	addw #16,a3
	subql #4,d0
	jne L96
L94:
	jbsr _init__9SystemLib
L98:
	moveml a5@(-12),#0xc04
	unlk a5
	rts
LC1:
	.ascii "Application initialisation failed\0"
LC2:
	.ascii "Unable to create application\0"
LC3:
	.ascii "Library initialisation failed\0"
	.even
.globl _runApplication__10StartupLib
_runApplication__10StartupLib:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel d2,sp@-
	jbsr _init__7AppBase
	movel d0,d2
	jne L119
	jbsr _createApplicationInstance__7AppBase
	movel d0,a2
	tstl a2
	jeq L120
	movel a2@,a0
	movel a2,sp@-
	movel a0@(12),a0
	jbsr a0@
	movel d0,d2
	addql #4,sp
	jne L121
	movel a2@,a0
	movel a2,sp@-
	movel a0@(20),a0
	jbsr a0@
	movel d0,d2
	addql #4,sp
	jra L122
	.even
L121:
	pea 2:w
	pea LC1
	jbsr _printDebug__9SystemLibPCci
	addql #8,sp
L122:
	movel a2@,a0
	movel a2,sp@-
	movel a0@(16),a0
	jbsr a0@
	movel a2,sp@-
	jbsr _destroyApplicationInstance__7AppBaseP7AppBase
	jra L125
	.even
L120:
	pea 2:w
	pea LC2
	jra L126
	.even
L119:
	pea 2:w
	pea LC3
L126:
	jbsr _printDebug__9SystemLibPCci
L125:
	addql #8,sp
	jbsr _done__7AppBase
	movel d2,d0
	movel a5@(-8),d2
	movel a5@(-4),a2
	unlk a5
	rts
	.even
.globl _done__10StartupLib
_done__10StartupLib:
	pea a5@
	movel sp,a5
	jbsr _done__9SystemLib
	movel __10StartupLib$startArgs,d0
	jeq L129
	movel d0,sp@-
	jbsr ___builtin_vec_delete
L129:
	clrl __10StartupLib$startArgs
	unlk a5
	rts
	.even
.globl _numArgs__7AppBase
_numArgs__7AppBase:
	pea a5@
	movel sp,a5
	movel __10StartupLib$numStartArgs,d0
	unlk a5
	rts
	.even
.globl _getArg__7AppBasel
_getArg__7AppBasel:
	pea a5@
	movel sp,a5
	movel a5@(8),d0
	jlt L133
	cmpl __10StartupLib$numStartArgs,d0
	jlt L132
L133:
	clrl d0
	jra L134
	.even
L132:
	movel __10StartupLib$startArgs,a0
	movel a0@(d0:l:4),d0
L134:
	unlk a5
	rts
	.even
.globl _getString__7AppBasePCcb
_getString__7AppBasePCcb:
	pea a5@
	movel sp,a5
	movel d3,sp@-
	movel d2,sp@-
	movel a5@(8),d3
	movel __10StartupLib$numStartArgs,d0
	moveq #1,d1
	cmpl d0,d1
	jge L145
	tstb a5@(15)
	jeq L137
	clrl d2
	cmpl d2,d0
	jle L145
	.even
L141:
	movel d3,sp@-
	movel __10StartupLib$startArgs,a0
	movel a0@(d2:l:4),sp@-
	jbsr _strcmp
	addql #8,sp
	tstl d0
	jne L140
	addql #1,d2
	cmpl __10StartupLib$numStartArgs,d2
	jlt L154
L140:
	addql #1,d2
	cmpl __10StartupLib$numStartArgs,d2
	jlt L141
	jra L145
	.even
L154:
L155:
	movel __10StartupLib$startArgs,a0
	movel a0@(d2:l:4),d0
	jra L153
	.even
L137:
	clrl d2
	cmpl d2,d0
	jle L145
	.even
L149:
	movel d3,sp@-
	movel __10StartupLib$startArgs,a0
	movel a0@(d2:l:4),sp@-
	jbsr _strcasecmp
	addql #8,sp
	tstl d0
	jne L148
	addql #1,d2
	cmpl __10StartupLib$numStartArgs,d2
	jlt L155
L148:
	addql #1,d2
	cmpl __10StartupLib$numStartArgs,d2
	jlt L149
L145:
	clrl d0
L153:
	movel a5@(-8),d2
	movel a5@(-4),d3
	unlk a5
	rts
	.even
.globl _getInteger__7AppBasePCcb
_getInteger__7AppBasePCcb:
	pea a5@
	movel sp,a5
	subql #2,sp
	moveb a5@(15),sp@(1)
	subql #2,sp
	movel a5@(8),sp@-
	jbsr _getString__7AppBasePCcb
	addql #8,sp
	tstl d0
	jne L159
	clrl d0
	jra L160
	.even
L159:
	movel d0,sp@-
	jbsr _atol
L160:
	unlk a5
	rts
	.even
.globl _getFloat__7AppBasePCcb
_getFloat__7AppBasePCcb:
	pea a5@
	movel sp,a5
	subql #2,sp
	moveb a5@(15),sp@(1)
	subql #2,sp
	movel a5@(8),sp@-
	jbsr _getString__7AppBasePCcb
	addql #8,sp
	tstl d0
	jne L162
	clrl d0
	clrl d1
	jra L163
	.even
L162:
	movel d0,sp@-
	jbsr _atof
L163:
	unlk a5
	rts
	.even
.globl _getSwitch__7AppBasePCcb
_getSwitch__7AppBasePCcb:
	pea a5@
	movel sp,a5
	movel d3,sp@-
	movel d2,sp@-
	movel a5@(8),d3
	movel __10StartupLib$numStartArgs,d0
	moveq #1,d1
	cmpl d0,d1
	jge L173
	tstb a5@(15)
	jeq L166
	clrl d2
	cmpl d2,d0
	jle L173
	.even
L170:
	movel d3,sp@-
	movel __10StartupLib$startArgs,a0
	movel a0@(d2:l:4),sp@-
	jbsr _strcmp
	addql #8,sp
	tstl d0
	jeq L181
	addql #1,d2
	cmpl __10StartupLib$numStartArgs,d2
	jlt L170
	jra L173
	.even
L181:
L182:
	moveq #1,d0
	jra L180
	.even
L166:
	clrl d2
	cmpl d2,d0
	jle L173
	.even
L177:
	movel d3,sp@-
	movel __10StartupLib$startArgs,a0
	movel a0@(d2:l:4),sp@-
	jbsr _strcasecmp
	addql #8,sp
	tstl d0
	jeq L182
	addql #1,d2
	cmpl __10StartupLib$numStartArgs,d2
	jlt L177
L173:
	clrb d0
L180:
	movel a5@(-8),d2
	movel a5@(-4),d3
	unlk a5
	rts
LC4:
	.ascii "Unable to initialise base library\0"
	.even
.globl _main
_main:
	pea a5@
	movel sp,a5
	movel d2,sp@-
	movel a5@(12),sp@-
	movel a5@(8),sp@-
	jbsr _init__10StartupLibiPPc
	movel d0,d2
	addql #8,sp
	jne L186
	jbsr _runApplication__10StartupLib
	movel d0,d2
	jra L187
	.even
L186:
	pea 2:w
	pea LC4
	jbsr _printDebug__9SystemLibPCci
	addql #8,sp
L187:
	jbsr _done__10StartupLib
	movel d2,d0
	movel a5@(-4),d2
	unlk a5
	rts
