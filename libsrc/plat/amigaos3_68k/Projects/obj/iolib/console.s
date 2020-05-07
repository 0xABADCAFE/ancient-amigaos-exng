#NO_APP
.text
	.even
.globl __$_13SystemConsole
__$_13SystemConsole:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel a5@(8),a2
	movel #___vt_13SystemConsole,a2@
	movel a2,sp@-
	jbsr _close__13SystemConsole
	addql #4,sp
	movel a2@(4),d0
	jeq L182
	movel d0,sp@-
	jbsr _free__3MemPv
	addql #4,sp
L182:
	movel #___vt_7Console,a2@
	movel a5@(12),d0
	btst #0,d0
	jeq L186
	movel a2,sp@-
	jbsr ___builtin_delete
L186:
	movel a5@(-4),a2
	unlk a5
	rts
LC0:
	.ascii "Unnamed\0"
LC1:
	.ascii "CON:%hi/%hi/%hi/%hi/%s/CLOSE\0"
LC2:
	.ascii "w+\0"
	.even
.globl _open__13SystemConsolessssPCc
_open__13SystemConsolessssPCc:
	pea a5@
	movel sp,a5
	moveml #0x3c20,sp@-
	movel a5@(8),a2
	movew a5@(14),d5
	movew a5@(18),d4
	movew a5@(22),d3
	movew a5@(26),d2
	tstl a2@(8)
	jeq L188
	movel #-50593799,d0
	jra L192
	.even
L188:
	tstl a2@(4)
	jne L189
	clrl sp@-
	subql #2,sp
	moveb #0,sp@(1)
	subql #2,sp
	pea 512:w
	jbsr _alloc__3MemUlbQ23Mem9AlignType
	movel d0,a2@(4)
	addw #12,sp
	jne L189
	movel #-50593803,d0
	jra L192
	.even
L189:
	movel a5@(28),d0
	jne L190
	movel #LC0,d0
L190:
	movel d0,sp@-
	movew d2,a0
	movel a0,sp@-
	movew d3,a0
	movel a0,sp@-
	movew d4,a0
	movel a0,sp@-
	movew d5,a0
	movel a0,sp@-
	pea LC1
	movel a2@(4),sp@-
	jbsr _sprintf
	pea LC2
	movel a2@(4),sp@-
	jbsr _fopen
	movel d0,a2@(8)
	seq d0
	extbl d0
	andl #-50593803,d0
L192:
	moveml a5@(-20),#0x43c
	unlk a5
	rts
	.even
.globl _close__13SystemConsole
_close__13SystemConsole:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel a5@(8),a2
	movel a2@(8),d0
	jne L194
	movel #-50593804,d0
	jra L195
	.even
L194:
	movel d0,sp@-
	jbsr _fflush
	movel a2@(8),sp@-
	jbsr _fclose
	clrl a2@(8)
	clrl d0
L195:
	movel a5@(-4),a2
	unlk a5
	rts
	.even
.globl _writeText__13SystemConsolePCce
_writeText__13SystemConsolePCce:
	pea a5@
	movel sp,a5
	movel a5@(8),a0
	movel a0@(8),d0
	jeq L197
	pea a5@(16)
	movel a5@(12),sp@-
	movel d0,sp@-
	jbsr _vfprintf
	jra L198
	.even
L197:
	movel #-50593797,d0
L198:
	unlk a5
	rts
	.even
.globl _readText__13SystemConsolePcUl
_readText__13SystemConsolePcUl:
	pea a5@
	movel sp,a5
	movel a5@(8),a0
	movel a0@(8),d0
	jeq L200
	movel d0,sp@-
	movel a5@(16),sp@-
	movel a5@(12),sp@-
	jbsr _fgets
	clrl d0
	jra L201
	.even
L200:
	movel #-50593796,d0
L201:
	unlk a5
	rts
	.even
.globl _flush__13SystemConsole
_flush__13SystemConsole:
	pea a5@
	movel sp,a5
	movel a5@(8),a0
	movel a0@(8),d0
	jeq L203
	movel d0,sp@-
	jbsr _fflush
L203:
	unlk a5
	rts
	.even
.globl _clear__13SystemConsole
_clear__13SystemConsole:
	pea a5@
	movel sp,a5
	unlk a5
	rts
.globl ___vt_13SystemConsole
	.even
___vt_13SystemConsole:
	.long 0
	.long 0
	.long _open__13SystemConsolePCc
	.long _close__13SystemConsole
	.long _writeText__13SystemConsolePCce
	.long _readText__13SystemConsolePcUl
	.long _flush__13SystemConsole
	.long _clear__13SystemConsole
	.long __$_13SystemConsole
	.skip 4
	.even
___vt_7Console:
	.long 0
	.long 0
	.long ___pure_virtual
	.long ___pure_virtual
	.long ___pure_virtual
	.long ___pure_virtual
	.long ___pure_virtual
	.long ___pure_virtual
	.long __$_7Console
	.skip 4
	.even
__$_7Console:
	pea a5@
	movel sp,a5
	movel a5@(8),a0
	movel #___vt_7Console,a0@
	btst #0,a5@(15)
	jeq L159
	movel a0,sp@-
	jbsr ___builtin_delete
L159:
	unlk a5
	rts
	.even
.globl _open__13SystemConsolePCc
_open__13SystemConsolePCc:
	pea a5@
	movel sp,a5
	movel a5@(12),sp@-
	pea 300:w
	pea 400:w
	pea 64:w
	pea 64:w
	movel a5@(8),sp@-
	jbsr _open__13SystemConsolessssPCc
	unlk a5
	rts
	.even
.globl ___13SystemConsole
___13SystemConsole:
	link a5,#-48
	fmovem #0xfc,sp@-
	moveml #0x3f3a,sp@-
	jbsr ___get_eh_context
	movel d0,d1
	movel a5@(8),a0
	movel #___vt_7Console,a0@
	movel d1,a0
	addql #4,a0
	movel a0@,a5@(-24)
	clrl a5@(-20)
	movel a5,a5@(-16)
	movel #L168,a5@(-12)
	movel sp,a5@(-8)
L168:
	lea a5@(-24),a1
	movel a1,a0@
	movel a5@(8),a0
	movel #___vt_13SystemConsole,a0@
	clrl a0@(4)
	clrl a0@(8)
	movel d1,a1
	addql #4,a1
	movel a1@,a0
	movel a0@,a1@
	movel a5@(8),d0
	moveml a5@(-160),#0x5cfc
	fmovem a5@(-120),#0x3f
	unlk a5
	rts
