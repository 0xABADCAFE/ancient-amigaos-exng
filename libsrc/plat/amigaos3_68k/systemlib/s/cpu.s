
; Storm C Compiler
; EXNG:libsrc/plat/amigaos3_68k/systemlib/cpu.cpp
	mc68030
	mc68881
	XREF	runApplication__AppBase__T
	XREF	_system
	XREF	_std__in
	XREF	_std__out
	XREF	_std__err
	XREF	_SysBase
	XREF	_IntuitionBase
	XREF	_debug__SystemLib
	XREF	_allocated__Mem
	XREF	_volatileBuff__Mem
	XREF	_totalSize__Mem
	XREF	_nextFree__Mem
	XREF	_count__Mem
	XREF	_maxAllocs__Mem

	SECTION "getVolatile__Mem_:0",CODE

	rts

	SECTION "_fpuPrecision__CPU:1",DATA

	XDEF	_fpuPrecision__CPU
_fpuPrecision__CPU
	dc.l	0

	SECTION "_cpuNames__CPU:0",CODE


L26
	dc.b	'ColdFire v4',0
L27
	dc.b	'ColdFire v5',0
L22
	dc.b	'MC68020',0
L23
	dc.b	'MC68030',0
L24
	dc.b	'MC68040',0
L25
	dc.b	'MC68060',0
L21
	dc.b	'MC680x0',0

	SECTION "_cpuNames__CPU:1",DATA

	XDEF	_cpuNames__CPU
_cpuNames__CPU
	dc.l	L21,L22,L23,L24,L25,L26,L27

	SECTION "_fpuNames__CPU:0",CODE


L32
	dc.b	'MC68040',0
L33
	dc.b	'MC68040+68882emu',0
L34
	dc.b	'MC68060',0
L35
	dc.b	'MC68060+68882emu'
	dc.b	'Software',0
L30
	dc.b	'MC68881',0
L31
	dc.b	'MC68882',0
L29
	dc.b	'MC6888x',0

	SECTION "_fpuNames__CPU:1",DATA

	XDEF	_fpuNames__CPU
_fpuNames__CPU
	dc.l	L29,L30,L31,L32,L33,L34,L35

	SECTION "cpuType__CPU_:0",CODE


;sint32 CPU::cpuType()
	XDEF	cpuType__CPU_
cpuType__CPU_
	move.l	d2,-(a7)
L37
;	if (!SysBase)
	tst.l	_SysBase
	bne.b	L39
L38
;		return MC680x0;
	moveq	#0,d0
	move.l	(a7)+,d2
	rts
L39
;	if (cpu<0)
	tst.l	_cpu__cpuType__CPU_
	bpl.b	L47
L40
;		uint16 info = SysBase->AttnFlags;
	move.l	_SysBase,a0
	move.w	$128(a0),d1
;		if (info & AFF_68040)
	moveq	#0,d0
	move.w	d1,d0
	and.l	#$8,d0
	beq.b	L42
L41
;			cpu = MC68040;
	move.l	#3,_cpu__cpuType__CPU_
	bra.b	L47
L42
;		else if (info & AFF_68030)
	moveq	#0,d0
	move.w	d1,d0
	and.l	#4,d0
	beq.b	L44
L43
;			cpu = MC68030;
	move.l	#2,_cpu__cpuType__CPU_
	bra.b	L47
L44
;		else if (info & AFF_68020)
	moveq	#0,d0
	move.w	d1,d0
	and.l	#2,d0
	beq.b	L46
L45
;			cpu = MC68020;
	move.l	#1,_cpu__cpuType__CPU_
	bra.b	L47
L46
;			cpu = MC680x0;
	clr.l	_cpu__cpuType__CPU_
L47
;	return cpu;
	move.l	_cpu__cpuType__CPU_,d0
	move.l	(a7)+,d2
	rts

	SECTION "cpuType__CPU_:1",DATA

_cpu__cpuType__CPU_
	dc.l	-1

	SECTION "fpuType__CPU_:0",CODE


;sint32 CPU::fpuType()
	XDEF	fpuType__CPU_
fpuType__CPU_
	move.l	d2,-(a7)
L48
;	if (!SysBase)
	tst.l	_SysBase
	bne.b	L50
L49
;		return MC6888x;
	moveq	#0,d0
	move.l	(a7)+,d2
	rts
L50
;	if (fpu<0)
	tst.l	_fpu__fpuType__CPU_
	bpl.b	L61
L51
;		uint16 info = SysBase->AttnFlags;
	move.l	_SysBase,a0
	move.w	$128(a0),d0
;		if (info & AFF_FPU40)
	moveq	#0,d1
	move.w	d0,d1
	and.l	#$40,d1
	beq.b	L56
L52
;			if (info & (AFF_68882|AFF_68881))
	and.l	#$FFFF,d0
	and.l	#$30,d0
	beq.b	L54
L53
;				fpu = MC68040FPEM;
	move.l	#4,_fpu__fpuType__CPU_
	bra.b	L55
L54
;				fpu = MC68040FP;
	move.l	#3,_fpu__fpuType__CPU_
L55
	bra.b	L61
L56
;		else if (info & AFF_68882)
	moveq	#0,d1
	move.w	d0,d1
	and.l	#$20,d1
	beq.b	L58
L57
;			fpu = MC68882;
	move.l	#2,_fpu__fpuType__CPU_
	bra.b	L61
L58
;		else if (info & AFF_68881)
	and.l	#$FFFF,d0
	and.l	#$10,d0
	beq.b	L60
L59
;			fpu = MC68881;
	move.l	#1,_fpu__fpuType__CPU_
	bra.b	L61
L60
;			fpu = SOFTFP;
	move.l	#7,_fpu__fpuType__CPU_
L61
;	return fpu;
	move.l	_fpu__fpuType__CPU_,d0
	move.l	(a7)+,d2
	rts

	SECTION "fpuType__CPU_:1",DATA

_fpu__fpuType__CPU_
	dc.l	-1

	SECTION "flushDataCache__CPU__PvUj:0",CODE


;void CPU::flushDataCache(void* adr, uint32 l)
	XDEF	flushDataCache__CPU__PvUj
flushDataCache__CPU__PvUj
	move.l	a6,-(a7)
	move.l	$C(a7),d0
	move.l	$8(a7),a0
L62
;	CacheClearE(adr, l, CACRF_ClearD);
	move.l	_SysBase,a6
	move.l	#$800,d1
	jsr	-$282(a6)
	move.l	(a7)+,a6
	rts

	SECTION "flushInstCache__CPU__PvUj:0",CODE


;void CPU::flushInstCache(void* adr, uint32 l)
	XDEF	flushInstCache__CPU__PvUj
flushInstCache__CPU__PvUj
	move.l	a6,-(a7)
	move.l	$C(a7),d0
	move.l	$8(a7),a0
L63
;	CacheClearE(adr, l, CACRF_ClearI);
	move.l	_SysBase,a6
	moveq	#$8,d1
	jsr	-$282(a6)
	move.l	(a7)+,a6
	rts

	SECTION "flushAllCaches__CPU__PvUj:0",CODE


;void CPU::flushAllCaches(void* adr, uint32 l)
	XDEF	flushAllCaches__CPU__PvUj
flushAllCaches__CPU__PvUj
	move.l	a6,-(a7)
	move.l	$C(a7),d0
	move.l	$8(a7),a0
L64
;	CacheClearE(adr, l, CACRF_ClearD|CACRF_ClearI);
	move.l	_SysBase,a6
	move.l	#$808,d1
	jsr	-$282(a6)
	move.l	(a7)+,a6
	rts

	SECTION "setPrecision__CPU__E:0",CODE


;void CPU::setPrecision(CPU::FPPrec p)
	XDEF	setPrecision__CPU__E
setPrecision__CPU__E
L65
	rts

	END
