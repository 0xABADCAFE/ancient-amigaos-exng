#NO_APP
.globl __14InputPCMStream$factories
.data
	.even
__14InputPCMStream$factories:
	.long 0
	.skip 60
.globl __14InputPCMStream$numFacs
	.even
__14InputPCMStream$numFacs:
	.long 0
.text
	.even
.globl _addFactory__14InputPCMStreamP15InputPCMFactory
_addFactory__14InputPCMStreamP15InputPCMFactory:
	pea a5@
	movel sp,a5
	movel __14InputPCMStream$numFacs,d0
	moveq #15,d1
	cmpl d0,d1
	jlt L33
	lea __14InputPCMStream$factories,a0
	movel a5@(8),a0@(d0:l:4)
	addql #1,__14InputPCMStream$numFacs
L33:
	unlk a5
	rts
	.even
.globl _getNumFactories__14InputPCMStream
_getNumFactories__14InputPCMStream:
	pea a5@
	movel sp,a5
	movel __14InputPCMStream$numFacs,d0
	unlk a5
	rts
	.even
.globl _add__15InputPCMFactory
_add__15InputPCMFactory:
	pea a5@
	movel sp,a5
	movel a5@(8),sp@-
	jbsr _addFactory__14InputPCMStreamP15InputPCMFactory
	unlk a5
	rts
	.even
.globl _getFactory__14InputPCMStreaml
_getFactory__14InputPCMStreaml:
	pea a5@
	movel sp,a5
	movel a5@(8),d0
	jlt L38
	cmpl __14InputPCMStream$numFacs,d0
	jle L37
L38:
	clrl d0
	jra L39
	.even
L37:
	lea __14InputPCMStream$factories,a0
	movel a0@(d0:l:4),d0
L39:
	unlk a5
	rts
