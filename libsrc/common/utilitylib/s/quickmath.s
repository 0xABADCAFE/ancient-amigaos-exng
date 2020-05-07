
; Storm C Compiler
; EXNG:libsrc/common/utilitylib/quickmath.cpp
	mc68030
	mc68881
	XREF	_sin__r
	XREF	_fmod__r
	XREF	_exp__r
	XREF	_asin__r
	XREF	runApplication__AppBase__T
	XREF	free__Mem__Pv
	XREF	alloc__Mem__UisE
	XREF	printDebug__SystemLib__PCci
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

	SECTION "_data__QMath:1",DATA

	XDEF	_data__QMath
_data__QMath
	dc.l	0

	SECTION "_arcData__QMath:1",DATA

	XDEF	_arcData__QMath
_arcData__QMath
	dc.l	0

	SECTION "_eFrac__QMath:1",DATA

	XDEF	_eFrac__QMath
_eFrac__QMath
	dc.l	0

	SECTION "_eInt__QMath:1",DATA

	XDEF	_eInt__QMath
_eInt__QMath
	dc.l	0

	SECTION "init__QMath_:0",CODE


;sint32 QMath::init()
	XDEF	init__QMath_
init__QMath_
	move.l	d2,-(a7)
L60
;	if (data)
	tst.l	_data__QMath
	beq.b	L62
L61
;		return ERR_RSC;
	move.l	#-$3050000,d0
	move.l	(a7)+,d2
	rts
L62
;	size_t dataSize = 3*(((DATASIZE+2)*sizeof(float32) + Mem::ALIGN_CA
;	if(!(data = (float32*)Mem::alloc(dataSize, false, Mem::ALIGN_CACHE)
	pea	$10.w
	clr.w	-(a7)
	pea	$32F0.w
	jsr	alloc__Mem__UisE
	add.w	#$A,a7
	move.l	d0,_data__QMath
	tst.l	_data__QMath
	bne.b	L64
L63
;OR("QMath::init()
	pea	2.w
	move.l	#L59,-(a7)
	jsr	printDebug__SystemLib__PCci
	addq.w	#$8,a7
;		return ERR_NO_FREE_STORE;
	move.l	#-$3030001,d0
	move.l	(a7)+,d2
	rts
L64
;	size_t offset = (((DATASIZE+2)*sizeof(float32) + Mem::ALIGN_CACHE)
	move.l	#$404,d0
;	arcData	= data + offset;
	move.l	d0,d1
	asl.l	#2,d1
	add.l	_data__QMath,d1
	move.l	d1,_arcData__QMath
;	eFrac		= arcData + offset;
	move.l	d0,d1
	asl.l	#2,d1
	add.l	_arcData__QMath,d1
	move.l	d1,_eFrac__QMath
;	eInt		= eFrac + offset;
	asl.l	#2,d0
	add.l	_eFrac__QMath,d0
	move.l	d0,_eInt__QMath
;	for (i=0;
	moveq	#0,d2
	bra	L66
L65
;		data[i]			= ::sin(i*PI64/(2*DATASIZE));
	fmove.l	d2,fp0
	fmul.d	#$.400921FB.544486DA,fp0
	fdiv.d	#$.40A00000.00000000,fp0
	fmove.d	fp0,-(a7)
	jsr	_sin__r
	addq.w	#$8,a7
	move.l	_data__QMath,a1
	fmove.s	fp0,0(a1,d2.l*4)
;		arcData[i]	= ::asin(i/DATASIZE);
	move.l	d2,d0
	divsl.l	#$400,d0
	fmove.l	d0,fp0
	fmove.d	fp0,-(a7)
	jsr	_asin__r
	addq.w	#$8,a7
	move.l	_arcData__QMath,a1
	fmove.s	fp0,0(a1,d2.l*4)
;		eFrac[i]		= ::exp(-i/DATASIZE);
	move.l	d2,d0
	neg.l	d0
	divsl.l	#$400,d0
	fmove.l	d0,fp0
	fmove.d	fp0,-(a7)
	jsr	_exp__r
	addq.w	#$8,a7
	move.l	_eFrac__QMath,a1
	fmove.s	fp0,0(a1,d2.l*4)
	addq.l	#1,d2
L66
	cmp.l	#$400,d2
	blt	L65
L67
;	data[DATASIZE]		= 1.0;
	move.l	_data__QMath,a1
	move.l	#$3F800000,$1000(a1)
;	eFrac[DATASIZE]		= 1.0;
	move.l	_eFrac__QMath,a1
	move.l	#$3F800000,$1000(a1)
;	arcData[DATASIZE]	= PI64/2;
	move.l	_arcData__QMath,a1
	move.l	#$3FC90FDB,$1000(a1)
;	for (i=0;
	moveq	#0,d2
	bra.b	L69
L68
;		eInt[i]			= ::exp(i+E_MIN_INT);
	move.l	d2,d0
	sub.l	#$58,d0
	fmove.l	d0,fp0
	fmove.d	fp0,-(a7)
	jsr	_exp__r
	addq.w	#$8,a7
	move.l	_eInt__QMath,a1
	fmove.s	fp0,0(a1,d2.l*4)
	addq.l	#1,d2
L69
	cmp.l	#$B0,d2
	blt.b	L68
L70
;	return OK;
	moveq	#0,d0
	move.l	(a7)+,d2
	rts

L59
	dc.b	'QMath::init() - insufficient memory for tables',0

	SECTION "done__QMath_:0",CODE


;void QMath::done()
	XDEF	done__QMath_
done__QMath_
L71
;	if (data)
	tst.l	_data__QMath
	beq.b	L73
L72
;		Mem::free(data);
	move.l	_data__QMath,-(a7)
	jsr	free__Mem__Pv
	addq.w	#4,a7
L73
;	data		= 0;
	clr.l	_data__QMath
;	arcData	= 0;
	clr.l	_arcData__QMath
;	eFrac		= 0;
	clr.l	_eFrac__QMath
;	eInt		= 0;
	clr.l	_eInt__QMath
	rts

	SECTION "angleMod__QMath___r_f:0",CODE


;float32	QMath::angleMod(float32 x)
	XDEF	angleMod__QMath___r_f
angleMod__QMath___r_f
	fmove.s	4(a7),fp0
L74
;	if (x<0)
	fcmp.s	#$.00000000,fp0
	fboge.b	L76
L75
;		return (2*PI32)+fmod(x, 2*PI32);
	move.l	#$40000000,-(a7)
	move.l	#$401921FB,-(a7)
	fmove.d	fp0,-(a7)
	jsr	_fmod__r
	add.w	#$10,a7
	fadd.d	#$.401921FB.40000000,fp0
	rts
L76
;	else if (x<2*PI32)
	fcmp.s	#$.40C90FDA,fp0
	fboge.b	L78
L77
;		return x;
	rts
L78
;		return fmod(x, 2*PI32);
	move.l	#$40000000,-(a7)
	move.l	#$401921FB,-(a7)
	fmove.d	fp0,-(a7)
	jsr	_fmod__r
	add.w	#$10,a7
	rts

	SECTION "sin__QMath___r_f:0",CODE


;float32 QMath::sin(float32 x)
	XDEF	sin__QMath___r_f
sin__QMath___r_f
	move.l	d2,-(a7)
	fmovem.x fp2,-(a7)
	fmove.s	$14(a7),fp2
L79
;	x *= (2*DATASIZE/PI32);
	fmul.s	#$.4422F984,fp2
;	ruint32 i = (uint32)x;
	fmove.l	fp2,d1
;	x -= i;
	fmove.l	d1,fp0
	fsub.x	fp0,fp2
;	return (1.0F-x)*sini(i) + x*sini(i+1);
	fmove.s	#$.3F800000,fp0
	fsub.x	fp2,fp0
	move.l	d1,d0
	cmp.l	#$400,d0
	bhs.b	L81
L80
	move.l	_data__QMath,a1
	fmove.s	0(a1,d0.l*4),fp1
	bra.b	L88
L81
	cmp.l	#$800,d0
	bhs.b	L83
L82
	move.l	#$800,d2
	sub.l	d0,d2
	move.l	d2,d0
	move.l	_data__QMath,a1
	fmove.s	0(a1,d0.l*4),fp1
	bra.b	L88
L83
	cmp.l	#$C00,d0
	bhs.b	L85
L84
	sub.l	#$800,d0
	move.l	_data__QMath,a1
	fmove.s	0(a1,d0.l*4),fp1
	fneg.s	fp1
	bra.b	L88
L85
	cmp.l	#$1000,d0
	bhs.b	L87
L86
	move.l	#$1000,d2
	sub.l	d0,d2
	move.l	d2,d0
	move.l	_data__QMath,a1
	fmove.s	0(a1,d0.l*4),fp1
	fneg.s	fp1
	bra.b	L88
L87
	sub.l	#$1000,d0
	move.l	_data__QMath,a1
	fmove.s	0(a1,d0.l*4),fp1
L88
	fmul.x	fp1,fp0
	move.l	d1,d0
	addq.l	#1,d0
	cmp.l	#$400,d0
	bhs.b	L90
L89
	move.l	_data__QMath,a1
	fmove.s	0(a1,d0.l*4),fp1
	bra.b	L97
L90
	cmp.l	#$800,d0
	bhs.b	L92
L91
	move.l	#$800,d1
	sub.l	d0,d1
	move.l	d1,d0
	move.l	_data__QMath,a1
	fmove.s	0(a1,d0.l*4),fp1
	bra.b	L97
L92
	cmp.l	#$C00,d0
	bhs.b	L94
L93
	sub.l	#$800,d0
	move.l	_data__QMath,a1
	fmove.s	0(a1,d0.l*4),fp1
	fneg.s	fp1
	bra.b	L97
L94
	cmp.l	#$1000,d0
	bhs.b	L96
L95
	move.l	#$1000,d1
	sub.l	d0,d1
	move.l	d1,d0
	move.l	_data__QMath,a1
	fmove.s	0(a1,d0.l*4),fp1
	fneg.s	fp1
	bra.b	L97
L96
	sub.l	#$1000,d0
	move.l	_data__QMath,a1
	fmove.s	0(a1,d0.l*4),fp1
L97
	fmul.x	fp1,fp2
	fadd.x	fp2,fp0
	fmovem.x (a7)+,fp2
	move.l	(a7)+,d2
	rts

	SECTION "cos__QMath___r_f:0",CODE


;float32 QMath::cos(float32 x)
	XDEF	cos__QMath___r_f
cos__QMath___r_f
	move.l	d2,-(a7)
	fmovem.x fp2,-(a7)
	fmove.s	$14(a7),fp2
L98
;	x *= (2*DATASIZE/PI32);
	fmul.s	#$.4422F984,fp2
;	ruint32 i = (uint32)x;
	fmove.l	fp2,d1
;	x -= i;
	fmove.l	d1,fp0
	fsub.x	fp0,fp2
;	return (1.0F-x)*cosi(i) + x*cosi(i+1);
	fmove.s	#$.3F800000,fp0
	fsub.x	fp2,fp0
	move.l	d1,d0
	cmp.l	#$400,d0
	bhs.b	L100
L99
	move.l	#$400,d2
	sub.l	d0,d2
	move.l	d2,d0
	move.l	_data__QMath,a1
	fmove.s	0(a1,d0.l*4),fp1
	bra.b	L107
L100
	cmp.l	#$800,d0
	bhs.b	L102
L101
	sub.l	#$400,d0
	move.l	_data__QMath,a1
	fmove.s	0(a1,d0.l*4),fp1
	fneg.s	fp1
	bra.b	L107
L102
	cmp.l	#$C00,d0
	bhs.b	L104
L103
	move.l	#$C00,d2
	sub.l	d0,d2
	move.l	d2,d0
	move.l	_data__QMath,a1
	fmove.s	0(a1,d0.l*4),fp1
	fneg.s	fp1
	bra.b	L107
L104
	cmp.l	#$1000,d0
	bhs.b	L106
L105
	sub.l	#$C00,d0
	move.l	_data__QMath,a1
	fmove.s	0(a1,d0.l*4),fp1
	bra.b	L107
L106
	move.l	#$1400,d2
	sub.l	d0,d2
	move.l	d2,d0
	move.l	_data__QMath,a1
	fmove.s	0(a1,d0.l*4),fp1
L107
	fmul.x	fp1,fp0
	move.l	d1,d0
	addq.l	#1,d0
	cmp.l	#$400,d0
	bhs.b	L109
L108
	move.l	#$400,d1
	sub.l	d0,d1
	move.l	d1,d0
	move.l	_data__QMath,a1
	fmove.s	0(a1,d0.l*4),fp1
	bra.b	L116
L109
	cmp.l	#$800,d0
	bhs.b	L111
L110
	sub.l	#$400,d0
	move.l	_data__QMath,a1
	fmove.s	0(a1,d0.l*4),fp1
	fneg.s	fp1
	bra.b	L116
L111
	cmp.l	#$C00,d0
	bhs.b	L113
L112
	move.l	#$C00,d1
	sub.l	d0,d1
	move.l	d1,d0
	move.l	_data__QMath,a1
	fmove.s	0(a1,d0.l*4),fp1
	fneg.s	fp1
	bra.b	L116
L113
	cmp.l	#$1000,d0
	bhs.b	L115
L114
	sub.l	#$C00,d0
	move.l	_data__QMath,a1
	fmove.s	0(a1,d0.l*4),fp1
	bra.b	L116
L115
	move.l	#$1400,d1
	sub.l	d0,d1
	move.l	d1,d0
	move.l	_data__QMath,a1
	fmove.s	0(a1,d0.l*4),fp1
L116
	fmul.x	fp1,fp2
	fadd.x	fp2,fp0
	fmovem.x (a7)+,fp2
	move.l	(a7)+,d2
	rts

	SECTION "tan__QMath___r_f:0",CODE


;float32 QMath::tan(float32 x)
	XDEF	tan__QMath___r_f
tan__QMath___r_f
	move.l	d2,-(a7)
	fmovem.x fp2/fp3,-(a7)
	fmove.s	$20(a7),fp1
L117
;	x *= (2*DATASIZE/PI32);
	fmul.s	#$.4422F984,fp1
;	ruint32 i = (uint32)x;
	fmove.l	fp1,d0
;	x -= i;
	fmove.l	d0,fp0
	fsub.x	fp0,fp1
;	if (i<DATASIZE)
	cmp.l	#$400,d0
	bhs.b	L119
L118
;		ruint32 i2 = DATASIZE-i;
	move.l	#$400,d1
	sub.l	d0,d1
;		return ( (1.0F-x)*data[i] + x*data[i+1] ) / ( (1.0F-x)*data[i2] 
	fmove.s	#$.3F800000,fp0
	fsub.x	fp1,fp0
	move.l	_data__QMath,a1
	fmul.s	0(a1,d0.l*4),fp0
	addq.l	#1,d0
	move.l	_data__QMath,a1
	fmove.s	0(a1,d0.l*4),fp2
	fmul.x	fp1,fp2
	fadd.x	fp2,fp0
	fmove.s	#$.3F800000,fp2
	fsub.x	fp1,fp2
	move.l	_data__QMath,a1
	fmul.s	0(a1,d1.l*4),fp2
	addq.l	#1,d1
	move.l	_data__QMath,a1
	fmul.s	0(a1,d1.l*4),fp1
	fadd.x	fp1,fp2
	fdiv.x	fp2,fp0
	fmovem.x (a7)+,fp2/fp3
	move.l	(a7)+,d2
	rts
L119
;	else if (i<(2*DATASIZE))
	cmp.l	#$800,d0
	bhs	L121
L120
;		ruint32 i2 = i-DATASIZE;
	move.l	d0,d1
	sub.l	#$400,d1
; i = (2*DATASIZE)-i;
	move.l	#$800,d2
	sub.l	d0,d2
	move.l	d2,d0
;		return ( -(1.0F-x)*data[i] - x*data[i+1] ) / ( (1.0F-x)*data[i2]
	fmove.s	#$.3F800000,fp0
	fsub.x	fp1,fp0
	fneg.s	fp0
	move.l	_data__QMath,a1
	fmul.s	0(a1,d0.l*4),fp0
	addq.l	#1,d0
	move.l	_data__QMath,a1
	fmove.s	0(a1,d0.l*4),fp2
	fmul.x	fp1,fp2
	fsub.x	fp2,fp0
	fmove.s	#$.3F800000,fp2
	fsub.x	fp1,fp2
	move.l	_data__QMath,a1
	fmul.s	0(a1,d1.l*4),fp2
	addq.l	#1,d1
	move.l	_data__QMath,a1
	fmul.s	0(a1,d1.l*4),fp1
	fadd.x	fp1,fp2
	fdiv.x	fp2,fp0
	fmovem.x (a7)+,fp2/fp3
	move.l	(a7)+,d2
	rts
L121
;	else if (i<(3*DATASIZE))
	cmp.l	#$C00,d0
	bhs.b	L123
L122
;		ruint32 i2 = (3*DATASIZE)-i;
	move.l	#$C00,d1
	sub.l	d0,d1
; i -= (2*DATASIZE);
	sub.l	#$800,d0
;		return ( (1.0F-x)*data[i] + x*data[i+1]) / ( (1.0F-x)*data[i2] +
	fmove.s	#$.3F800000,fp0
	fsub.x	fp1,fp0
	move.l	_data__QMath,a1
	fmul.s	0(a1,d0.l*4),fp0
	addq.l	#1,d0
	move.l	_data__QMath,a1
	fmove.s	0(a1,d0.l*4),fp2
	fmul.x	fp1,fp2
	fadd.x	fp2,fp0
	fmove.s	#$.3F800000,fp2
	fsub.x	fp1,fp2
	move.l	_data__QMath,a1
	fmul.s	0(a1,d1.l*4),fp2
	addq.l	#1,d1
	move.l	_data__QMath,a1
	fmul.s	0(a1,d1.l*4),fp1
	fadd.x	fp1,fp2
	fdiv.x	fp2,fp0
	fmovem.x (a7)+,fp2/fp3
	move.l	(a7)+,d2
	rts
L123
;	else if (i<(4*DATASIZE))
	cmp.l	#$1000,d0
	bhs	L125
L124
;		ruint32 i2 = i-(3*DATASIZE);
	move.l	d0,d1
	sub.l	#$C00,d1
; i = (4*DATASIZE)-i;
	move.l	#$1000,d2
	sub.l	d0,d2
	move.l	d2,d0
;		return ( -(1.0F-x)*data[i] - x*data[i+1]) / ( (1.0F-x)*data[i2] 
	fmove.s	#$.3F800000,fp0
	fsub.x	fp1,fp0
	fneg.s	fp0
	move.l	_data__QMath,a1
	fmul.s	0(a1,d0.l*4),fp0
	addq.l	#1,d0
	move.l	_data__QMath,a1
	fmove.s	0(a1,d0.l*4),fp2
	fmul.x	fp1,fp2
	fsub.x	fp2,fp0
	fmove.s	#$.3F800000,fp2
	fsub.x	fp1,fp2
	move.l	_data__QMath,a1
	fmul.s	0(a1,d1.l*4),fp2
	addq.l	#1,d1
	move.l	_data__QMath,a1
	fmul.s	0(a1,d1.l*4),fp1
	fadd.x	fp1,fp2
	fdiv.x	fp2,fp0
	fmovem.x (a7)+,fp2/fp3
	move.l	(a7)+,d2
	rts
L125
;		ruint32 i2 = (5*DATASIZE)-i;
	move.l	#$1400,d1
	sub.l	d0,d1
; i -= (4*DATASIZE);
	sub.l	#$1000,d0
;		return ( (1.0F-x)*data[i] + x*data[i+1]) / ( (1.0F-x)*data[i2] +
	fmove.s	#$.3F800000,fp0
	fsub.x	fp1,fp0
	move.l	_data__QMath,a1
	fmul.s	0(a1,d0.l*4),fp0
	addq.l	#1,d0
	move.l	_data__QMath,a1
	fmove.s	0(a1,d0.l*4),fp2
	fmul.x	fp1,fp2
	fadd.x	fp2,fp0
	fmove.s	#$.3F800000,fp2
	fsub.x	fp1,fp2
	move.l	_data__QMath,a1
	fmul.s	0(a1,d1.l*4),fp2
	addq.l	#1,d1
	move.l	_data__QMath,a1
	fmul.s	0(a1,d1.l*4),fp1
	fadd.x	fp1,fp2
	fdiv.x	fp2,fp0
	fmovem.x (a7)+,fp2/fp3
	move.l	(a7)+,d2
	rts

	SECTION "asin__QMath___r_f:0",CODE


;float32 QMath::asin(float32 x)
	XDEF	asin__QMath___r_f
asin__QMath___r_f
	fmovem.x fp2,-(a7)
	fmove.s	$10(a7),fp1
L126
;	x *= DATASIZE;
	fmul.s	#$.44800000,fp1
;	if (x<0F)
	fcmp.s	#$.00000000,fp1
	fboge.b	L128
L127
;		x = -x;
	fneg.s	fp1
;		ruint32 i = (uint32)(x - 0.5F);
	fmove.x	fp1,fp0
	fsub.s	#$.3F000000,fp0
	fmove.l	fp0,d0
;		x -= i;
	fmove.l	d0,fp0
	fsub.x	fp0,fp1
;		return -(1.0F-x)*arcData[i] - x*arcData[i+1];
	fmove.s	#$.3F800000,fp0
	fsub.x	fp1,fp0
	fneg.s	fp0
	move.l	_arcData__QMath,a1
	fmul.s	0(a1,d0.l*4),fp0
	addq.l	#1,d0
	move.l	_arcData__QMath,a1
	fmul.s	0(a1,d0.l*4),fp1
	fsub.x	fp1,fp0
	fmovem.x (a7)+,fp2
	rts
L128
;		ruint32 i = (uint32)(x - 0.5F);
	fmove.x	fp1,fp0
	fsub.s	#$.3F000000,fp0
	fmove.l	fp0,d0
;		x	-= i;
	fmove.l	d0,fp0
	fsub.x	fp0,fp1
;		return (1.0F-x)*arcData[i] + x*arcData[i+1];
	fmove.s	#$.3F800000,fp0
	fsub.x	fp1,fp0
	move.l	_arcData__QMath,a1
	fmul.s	0(a1,d0.l*4),fp0
	addq.l	#1,d0
	move.l	_arcData__QMath,a1
	fmul.s	0(a1,d0.l*4),fp1
	fadd.x	fp1,fp0
	fmovem.x (a7)+,fp2
	rts

	SECTION "acos__QMath___r_f:0",CODE


;float32 QMath::acos(float32 x)
	XDEF	acos__QMath___r_f
acos__QMath___r_f
	fmovem.x fp2,-(a7)
	fmove.s	$10(a7),fp1
L129
;	x *= DATASIZE;
	fmul.s	#$.44800000,fp1
;	if (x<0F)
	fcmp.s	#$.00000000,fp1
	fboge.b	L131
L130
;		x = -x;
	fneg.s	fp1
;		ruint32 i = (uint32)(x - 0.5F);
	fmove.x	fp1,fp0
	fsub.s	#$.3F000000,fp0
	fmove.l	fp0,d0
;		x -= i;
	fmove.l	d0,fp0
	fsub.x	fp0,fp1
;		return (PI32/2) + (1.0F-x)*arcData[i] + x*arcData[i+1];
	fmove.s	#$.3F800000,fp0
	fsub.x	fp1,fp0
	move.l	_arcData__QMath,a1
	fmul.s	0(a1,d0.l*4),fp0
	fadd.s	#$.3FC90FDA,fp0
	addq.l	#1,d0
	move.l	_arcData__QMath,a1
	fmul.s	0(a1,d0.l*4),fp1
	fadd.x	fp1,fp0
	fmovem.x (a7)+,fp2
	rts
L131
;		ruint32 i = (uint32)(x - 0.5F);
	fmove.x	fp1,fp0
	fsub.s	#$.3F000000,fp0
	fmove.l	fp0,d0
;		x	-= i;
	fmove.l	d0,fp0
	fsub.x	fp0,fp1
;		return (PI32/2) - (1.0F-x)*arcData[i] - x*arcData[i+1];
	fmove.s	#$.3F800000,fp0
	fsub.x	fp1,fp0
	move.l	_arcData__QMath,a1
	fmul.s	0(a1,d0.l*4),fp0
	fmove.s	#$.3FC90FDA,fp2
	fsub.x	fp0,fp2
	fmove.x	fp2,fp0
	addq.l	#1,d0
	move.l	_arcData__QMath,a1
	fmul.s	0(a1,d0.l*4),fp1
	fsub.x	fp1,fp0
	fmovem.x (a7)+,fp2
	rts

	SECTION "exp__QMath___r_f:0",CODE


;float32 QMath::exp(float32 x)
	XDEF	exp__QMath___r_f
exp__QMath___r_f
	move.l	d2,-(a7)
	fmovem.x fp2/fp3,-(a7)
	fmove.s	$20(a7),fp1
L132
;	rsint32 i = (uint32)(x+0.5F);
	fmove.x	fp1,fp0
	fadd.s	#$.3F000000,fp0
	fmove.l	fp0,d1
;	x -= (i-1);
	move.l	d1,d0
	subq.l	#1,d0
	fmove.l	d0,fp0
	fsub.x	fp0,fp1
;	x *= DATASIZE;
	fmul.s	#$.44800000,fp1
;	ruint32 i2 = (uint32)(x-0.5F);
	fmove.x	fp1,fp0
	fsub.s	#$.3F000000,fp0
	fmove.l	fp0,d0
;	x -= i2;
	fmove.l	d0,fp0
	fsub.x	fp0,fp1
;	return eInt[i+(-E_MIN_INT)]*( (1.0F-x)*eFrac[i2] + x*eFrac[i2+1]);
	add.l	#$58,d1
	move.l	_eInt__QMath,a1
	fmove.s	0(a1,d1.l*4),fp0
	fmove.s	#$.3F800000,fp2
	fsub.x	fp1,fp2
	move.l	_eFrac__QMath,a1
	fmul.s	0(a1,d0.l*4),fp2
	addq.l	#1,d0
	move.l	_eFrac__QMath,a1
	fmul.s	0(a1,d0.l*4),fp1
	fadd.x	fp1,fp2
	fmul.x	fp2,fp0
	fmovem.x (a7)+,fp2/fp3
	move.l	(a7)+,d2
	rts

	END
