#NO_APP
.globl __3CPU$fpuPrecision
.data
	.even
__3CPU$fpuPrecision:
	.long 0
.globl __3CPU$cpuNames
.text
LC0:
	.ascii "MC680x0\0"
LC1:
	.ascii "MC68020\0"
LC2:
	.ascii "MC68030\0"
LC3:
	.ascii "MC68040\0"
LC4:
	.ascii "MC68060\0"
LC5:
	.ascii "ColdFire v4\0"
LC6:
	.ascii "ColdFire v5\0"
.data
	.even
__3CPU$cpuNames:
	.long LC0
	.long LC1
	.long LC2
	.long LC3
	.long LC4
	.long LC5
	.long LC6
.globl __3CPU$fpuNames
.text
LC7:
	.ascii "MC6888x\0"
LC8:
	.ascii "MC68881\0"
LC9:
	.ascii "MC68882\0"
LC10:
	.ascii "MC68040+68882emu\0"
LC11:
	.ascii "MC68060+68882emuSoftware\0"
.data
	.even
__3CPU$fpuNames:
	.long LC7
	.long LC8
	.long LC9
	.long LC3
	.long LC10
	.long LC4
	.long LC11
	.even
_cpu.33:
	.long -1
.text
	.even
.globl _cpuType__3CPU
_cpuType__3CPU:
	pea a5@
	movel sp,a5
	tstl _cpu.33
	jge L29
	movel _SysBase,a0
	movew a0@(296),d0
	tstb d0
	jge L30
	moveq #4,d0
	movel d0,_cpu.33
	jra L29
	.even
L30:
	btst #3,d0
	jeq L32
	moveq #3,d0
	movel d0,_cpu.33
	jra L29
	.even
L32:
	btst #2,d0
	jeq L34
	moveq #2,d0
	movel d0,_cpu.33
	jra L29
	.even
L34:
	btst #1,d0
	jeq L36
	moveq #1,d0
	movel d0,_cpu.33
	jra L29
	.even
L36:
	clrl _cpu.33
L29:
	movel _cpu.33,d0
	unlk a5
	rts
.data
	.even
_fpu.37:
	.long -1
.text
	.even
.globl _fpuType__3CPU
_fpuType__3CPU:
	pea a5@
	movel sp,a5
	tstl _fpu.37
	jge L39
	movel _SysBase,a0
	movew a0@(296),d0
	tstb d0
	jge L40
	btst #6,d0
	jeq L39
	andw #48,d0
	jeq L42
	moveq #6,d0
	jra L53
	.even
L42:
	moveq #5,d0
	jra L53
	.even
L40:
	btst #6,d0
	jeq L45
	andw #48,d0
	jeq L46
	moveq #4,d0
	jra L53
	.even
L46:
	moveq #3,d0
	jra L53
	.even
L45:
	btst #5,d0
	jeq L49
	moveq #2,d0
	jra L53
	.even
L49:
	btst #4,d0
	jeq L51
	moveq #1,d0
	jra L53
	.even
L51:
	moveq #7,d0
L53:
	movel d0,_fpu.37
L39:
	movel _fpu.37,d0
	unlk a5
	rts
	.even
.globl _flushDataCache__3CPUPvUl
_flushDataCache__3CPUPvUl:
	pea a5@
	movel sp,a5
	pea 2048:w
	movel a5@(12),sp@-
	movel a5@(8),sp@-
	jbsr _CacheClearE
	unlk a5
	rts
	.even
.globl _flushInstCache__3CPUPvUl
_flushInstCache__3CPUPvUl:
	pea a5@
	movel sp,a5
	pea 8:w
	movel a5@(12),sp@-
	movel a5@(8),sp@-
	jbsr _CacheClearE
	unlk a5
	rts
	.even
.globl _flushAllCaches__3CPUPvUl
_flushAllCaches__3CPUPvUl:
	pea a5@
	movel sp,a5
	pea 2056:w
	movel a5@(12),sp@-
	movel a5@(8),sp@-
	jbsr _CacheClearE
	unlk a5
	rts
	.even
.globl _setPrecision__3CPUQ23CPU6FPPrec
_setPrecision__3CPUQ23CPU6FPPrec:
	pea a5@
	movel sp,a5
	unlk a5
	rts
