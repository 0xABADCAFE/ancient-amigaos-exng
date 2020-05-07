#NO_APP
.text
LC0:
	.ascii "bad_alloc\0"
	.even
.globl _loadImage__11ImageLoaderPCcb
_loadImage__11ImageLoaderPCcb:
	link a5,#-84
	fmovem #0xfc,sp@-
	moveml #0x3f3a,sp@-
	jbsr ___get_eh_context
	movel d0,d1
	tstl a5@(8)
	jeq L1066
	pea _nothrow
	pea 26:w
	movel d1,a0
	addql #4,a0
	movel a0,a5@(-84)
	jbsr ___nw__FUlRC9nothrow_t
	movel d0,a5@(-64)
	movel a5@(-84),a0
	movel a0@,a5@(-24)
	clrl a5@(-20)
	movel a5,a5@(-16)
	movel #L1020,a5@(-12)
	movel sp,a5@(-8)
	jra L1019
	.even
L1020:
	jra L1065
	.even
L1019:
	lea a5@(-24),a1
	movel a1,a0@
	addql #8,sp
	movel a5@(-64),a0
	clrw a0@
	clrw a0@(2)
	clrl a0@(4)
	clrl a0@(8)
	clrl a0@(12)
	clrl a0@(16)
	clrl a0@(20)
	clrw a0@(24)
	movel a5@(-84),a1
	movel a1@,a0
	movel a0@,a1@
	tstl a5@(-64)
	jeq L1066
	clrl sp@-
	pea 1:w
	movel #-2147479301,sp@-
	clrl sp@-
	movel #-2147479341,sp@-
	movel #1885954932,sp@-
	movel #-2147479521,sp@-
	movel a5@(8),sp@-
	jbsr _NewDTObject
	movel d0,a5@(-68)
	addw #32,sp
	jeq L1028
	pea 1:w
	clrl sp@-
	pea 1538:w
	movel d0,sp@-
	jbsr _DoMethod
	clrl sp@-
	pea a5@(-52)
	movel #-2147479348,sp@-
	pea a5@(-56)
	movel #-2147479343,sp@-
	pea a5@(-60)
	movel #-2147479351,sp@-
	movel a5@(-68),sp@-
	jbsr _GetDTAttrs
	clrb d1
	movel a5@(-60),a0
	moveb a0@(8),d0
	addw #48,sp
	cmpb #8,d0
	jhi L1029
	clrl a5@(-76)
	moveq #3,d0
	movel d0,a5@(-72)
	moveq #1,d1
	clrl d2
	movew a0@,d2
	movel d2,a5@(-80)
	jra L1030
	.even
L1029:
	cmpb #24,d0
	jhi L1031
	tstb a5@(15)
	jne L1031
	movew #9,a1
	movel a1,a5@(-76)
	clrl a5@(-72)
	movew a0@,d0
	mulu #3,d0
	jra L1067
	.even
L1031:
	moveq #11,d2
	movel d2,a5@(-76)
	movew #2,a1
	movel a1,a5@(-72)
	clrl d0
	movew a0@,d0
	lsll #2,d0
L1067:
	movel d0,a5@(-80)
L1030:
	movew a5@(-54),a1
	movel a1,sp@-
	subql #2,sp
	moveb d1,sp@(1)
	subql #2,sp
	clrl sp@-
	movel a5@(-76),sp@-
	movew a0@(2),a0
	movel a0,sp@-
	movel a5@(-60),a0
	movew a0@,a0
	movel a0,sp@-
	movel a5@(-64),sp@-
	jbsr _create__11ImageBufferssQ25Pixel6HWTypeP7Palettebs
	addw #28,sp
	tstl d0
	jne L1033
	movel a5@(-60),a0
	clrl d0
	movew a0@(2),d0
	movel d0,sp@-
	clrl d0
	movew a0@,d0
	movel d0,sp@-
	clrl sp@-
	clrl sp@-
	movel a5@(-80),sp@-
	movel a5@(-72),sp@-
	movel a5@(-64),a0
	movel a0@(8),sp@-
	pea 1633:w
	movel a5@(-68),sp@-
	jbsr _DoMethod
	addw #36,sp
	tstl a5@(-76)
	jne L1033
	tstl a5@(-52)
	jeq L1033
	movel a5@(-64),a1
	movel a1@(12),a2
	tstl a2
	jeq L1033
	clrl d1
	cmpl a5@(-56),d1
	jcc L1033
	.even
L1041:
	movel d1,d0
	moveq #0,d2
	notb d2
	andl d2,d0
	lea a2@(d0:l:4),a1
	movel a5@(-52),a0
	moveb a0@,a1@(1)
	addql #4,a5@(-52)
	movel a5@(-52),a0
	moveb a0@,a1@(2)
	addql #4,a5@(-52)
	movel a5@(-52),a0
	moveb a0@,a1@(3)
	addql #4,a5@(-52)
	addql #1,d1
	cmpl a5@(-56),d1
	jcs L1041
L1033:
	movel a5@(-68),sp@-
	jbsr _DisposeDTObject
	movel a5@(-64),d0
	jra L1062
	.even
L1028:
	movel a5@(-64),sp@-
	jbsr _destroy__11ImageBuffer
	movel a5@(-64),sp@
	jbsr ___builtin_delete
L1066:
	clrl d0
	jra L1062
	.even
L1065:
L1017:
	movel a5@(-84),a0
	movel a0@,a5@(-48)
	clrl a5@(-44)
	movel a5,a5@(-40)
	movel #L1058,a5@(-36)
	movel sp,a5@(-32)
	jra L1057
	.even
L1058:
	jra L1068
	.even
L1057:
	lea a5@(-48),a0
	movel a5@(-84),a1
	movel a0,a1@
	clrb d0
	jeq L1060
	pea _nothrow
	movel a5@(-64),sp@-
	jbsr ___dl__FPvRC9nothrow_t
	addql #8,sp
L1060:
	movel a5@(-84),a1
	movel a1@,a0
	movel a0@,a1@
	jbsr ___sjthrow
	.even
L1068:
L1055:
	jbsr ___terminate
	.even
L1062:
	moveml a5@(-196),#0x5cfc
	fmovem a5@(-156),#0x3f
	unlk a5
	rts
