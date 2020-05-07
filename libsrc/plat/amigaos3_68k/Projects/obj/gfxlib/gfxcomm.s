#NO_APP
.text
LC0:
	.ascii "bad_alloc\0"
.globl __5Pixel$formats
.data
	.even
__5Pixel$formats:
	.long 15
	.long 0
	.long 1
	.long 5
	.long 9
	.long 11
.text
	.even
.globl _getPrefFormat__5PixelQ25Pixel5Depth
_getPrefFormat__5PixelQ25Pixel5Depth:
	pea a5@
	movel sp,a5
	movel a5@(8),d0
	moveq #32,d1
	cmpl d0,d1
	jcs L901
LI902:
	movew pc@(L902-LI902-2:b,d0:l:2),d0
	jmp pc@(2,d0:w)
	.even
L902:
	.word L901-L902
	.word L901-L902
	.word L901-L902
	.word L901-L902
	.word L901-L902
	.word L901-L902
	.word L901-L902
	.word L901-L902
	.word L896-L902
	.word L901-L902
	.word L901-L902
	.word L901-L902
	.word L901-L902
	.word L901-L902
	.word L901-L902
	.word L897-L902
	.word L898-L902
	.word L901-L902
	.word L901-L902
	.word L901-L902
	.word L901-L902
	.word L901-L902
	.word L901-L902
	.word L901-L902
	.word L899-L902
	.word L901-L902
	.word L901-L902
	.word L901-L902
	.word L901-L902
	.word L901-L902
	.word L901-L902
	.word L901-L902
	.word L900-L902
	.even
L896:
	movel __5Pixel$formats+4,d0
	jra L904
	.even
L897:
	movel __5Pixel$formats+8,d0
	jra L904
	.even
L898:
	movel __5Pixel$formats+12,d0
	jra L904
	.even
L899:
	movel __5Pixel$formats+16,d0
	jra L904
	.even
L900:
	movel __5Pixel$formats+20,d0
	jra L904
	.even
L901:
	movel __5Pixel$formats,d0
L904:
	unlk a5
	rts
	.even
.globl _getPixelRep__C6ColourPC15PixelDescriptor
_getPixelRep__C6ColourPC15PixelDescriptor:
	pea a5@
	movel sp,a5
	moveml #0x3800,sp@-
	movel a5@(8),a1
	movel a5@(12),a0
	clrl d2
	clrl d1
	moveb a0@(4),d1
	jeq L906
	moveq #1,d0
	lsll d1,d0
	subql #1,d0
	clrl d2
	moveb a0@(8),d2
	clrl d1
	moveb a1@,d1
	andl #0xFFFF,d0
	mulsl d0,d1
	fmoves #0r0.00392156886,fp0
	fsmull d1,fp0
	fcmpd #0r2147483648.000005,fp0
	fjge L910
	fmoveml fpcr,d1
	moveq #16,d3
	orl d1,d3
	andw #-33,d3
	fmoveml d3,fpcr
	fmovel fp0,d0
	fmoveml d1,fpcr
	jra L911
	.even
L910:
	fdsubd #0r2147483648.000005,fp0
	fmoveml fpcr,d4
	moveq #16,d1
	orl d4,d1
	andw #-33,d1
	fmoveml d1,fpcr
	fmovel fp0,d0
	fmoveml d4,fpcr
	bchg #31,d0
L911:
	lsll d2,d0
	movel d0,d2
L906:
	clrl d1
	moveb a0@(5),d1
	moveq #1,d0
	lsll d1,d0
	subql #1,d0
	clrl d3
	moveb a0@(9),d3
	clrl d1
	moveb a1@(1),d1
	andl #0xFFFF,d0
	mulsl d0,d1
	fmoves #0r0.00392156886,fp0
	fsmull d1,fp0
	fcmpd #0r2147483648.000005,fp0
	fjge L914
	fmoveml fpcr,d4
	moveq #16,d1
	orl d4,d1
	andw #-33,d1
	fmoveml d1,fpcr
	fmovel fp0,d0
	fmoveml d4,fpcr
	jra L915
	.even
L914:
	fdsubd #0r2147483648.000005,fp0
	fmoveml fpcr,d4
	moveq #16,d1
	orl d4,d1
	andw #-33,d1
	fmoveml d1,fpcr
	fmovel fp0,d0
	fmoveml d4,fpcr
	bchg #31,d0
L915:
	lsll d3,d0
	orl d0,d2
	clrl d1
	moveb a0@(6),d1
	moveq #1,d0
	lsll d1,d0
	subql #1,d0
	clrl d3
	moveb a0@(10),d3
	clrl d1
	moveb a1@(2),d1
	andl #0xFFFF,d0
	mulsl d0,d1
	fmoves #0r0.00392156886,fp0
	fsmull d1,fp0
	fcmpd #0r2147483648.000005,fp0
	fjge L918
	fmoveml fpcr,d4
	moveq #16,d1
	orl d4,d1
	andw #-33,d1
	fmoveml d1,fpcr
	fmovel fp0,d0
	fmoveml d4,fpcr
	jra L919
	.even
L918:
	fdsubd #0r2147483648.000005,fp0
	fmoveml fpcr,d4
	moveq #16,d1
	orl d4,d1
	andw #-33,d1
	fmoveml d1,fpcr
	fmovel fp0,d0
	fmoveml d4,fpcr
	bchg #31,d0
L919:
	lsll d3,d0
	orl d0,d2
	clrl d1
	moveb a0@(7),d1
	moveq #1,d0
	lsll d1,d0
	subql #1,d0
	clrl d3
	moveb a0@(11),d3
	clrl d1
	moveb a1@(3),d1
	andl #0xFFFF,d0
	mulsl d0,d1
	fmoves #0r0.00392156886,fp0
	fsmull d1,fp0
	fcmpd #0r2147483648.000005,fp0
	fjge L922
	fmoveml fpcr,d4
	moveq #16,d1
	orl d4,d1
	andw #-33,d1
	fmoveml d1,fpcr
	fmovel fp0,d0
	fmoveml d4,fpcr
	jra L923
	.even
L922:
	fdsubd #0r2147483648.000005,fp0
	fmoveml fpcr,d4
	moveq #16,d1
	orl d4,d1
	andw #-33,d1
	fmoveml d1,fpcr
	fmovel fp0,d0
	fmoveml d4,fpcr
	bchg #31,d0
L923:
	lsll d3,d0
	orl d0,d2
	tstb a0@(3)
	jeq L924
	clrl d0
	moveb a0@,d0
	moveq #2,d3
	cmpl d0,d3
	jne L926
	movel d2,d0
	lsll #8,d0
	lsrl #8,d2
	orl d0,d2
	clrl d0
	movew d2,d0
	jra L931
	.even
L926:
	moveq #4,d4
	cmpl d0,d4
	jne L924
	movel d2,d0
	moveq #24,d1
	lsll d1,d0
	movel d2,d1
	swap d1
	clrw d1
	andl #16711680,d1
	orl d1,d0
	clrw d2
	swap d2
	movel d2,d1
	andl #65280,d1
	orl d1,d0
	lsrl #8,d2
	orl d2,d0
	jra L931
	.even
L924:
	movel d2,d0
L931:
	moveml sp@+,#0x1c
	unlk a5
	rts
	.even
.globl _setFromPixel__6ColourPC15PixelDescriptorUl
_setFromPixel__6ColourPC15PixelDescriptorUl:
	pea a5@
	movel sp,a5
	moveml #0x3820,sp@-
	movel a5@(8),a2
	movel a5@(12),a0
	movel a5@(16),d2
	tstb a0@(3)
	jeq L933
	clrl d0
	moveb a0@,d0
	moveq #2,d1
	cmpl d0,d1
	jne L935
	movel d2,d0
	lsrl #8,d0
	lsll #8,d2
	orl d0,d2
	andl #65535,d2
	jra L933
	.even
L935:
	moveq #4,d1
	cmpl d0,d1
	jne L933
	movel d2,d1
	moveq #24,d0
	lsll d0,d1
	movel d2,d0
	swap d0
	clrw d0
	andl #16711680,d0
	orl d0,d1
	clrw d2
	swap d2
	movel d2,d0
	andl #65280,d0
	orl d0,d1
	movel d2,d0
	lsrl #8,d0
	movel d1,d2
	orl d0,d2
L933:
	clrl a2@
	clrl d0
	moveb a0@(4),d0
	movew #1,a1
	movel a1,d1
	lsll d0,d1
	movel d1,d3
	subql #1,d3
	clrl d4
	moveb a0@(8),d4
	movel d3,d0
	lsll d4,d0
	movel d2,d1
	andl d0,d1
	jeq L940
	movel d1,d0
	lsll #8,d0
	subl d1,d0
	lsrl d4,d0
	divul d3,d0
	moveb d0,a2@
L940:
	clrl d1
	moveb a0@(5),d1
	movel a1,d0
	lsll d1,d0
	movel d0,d3
	subql #1,d3
	clrl d4
	moveb a0@(9),d4
	movel d3,d1
	lsll d4,d1
	jeq L948
	btst #0,d2
	jeq L948
	movel d2,d0
	andl d1,d0
	movel d0,d1
	lsll #8,d1
	subl d0,d1
	lsrl d4,d1
	divul d3,d1
	moveb d1,a2@(1)
L948:
	clrl d1
	moveb a0@(6),d1
	moveq #1,d0
	lsll d1,d0
	movel d0,d3
	subql #1,d3
	clrl d4
	moveb a0@(10),d4
	movel d3,d1
	lsll d4,d1
	jeq L958
	btst #0,d2
	jeq L958
	movel d2,d0
	andl d1,d0
	movel d0,d1
	lsll #8,d1
	subl d0,d1
	lsrl d4,d1
	divul d3,d1
	moveb d1,a2@(2)
L958:
	clrl d1
	moveb a0@(7),d1
	moveq #1,d0
	lsll d1,d0
	movel d0,d3
	subql #1,d3
	clrl d4
	moveb a0@(11),d4
	movel d3,d0
	lsll d4,d0
	jeq L968
	btst #0,d2
	jeq L968
	andl d2,d0
	movel d0,d1
	lsll #8,d1
	subl d0,d1
	lsrl d4,d1
	divul d3,d1
	moveb d1,a2@(3)
L968:
	moveml sp@+,#0x41c
	unlk a5
	rts
	.even
.globl _scaleAlpha__7PalettefScUcUc
_scaleAlpha__7PalettefScUcUc:
	pea a5@
	movel sp,a5
	moveml #0x3f30,sp@-
	fsmoves a5@(12),fp1
	moveb a5@(23),d5
	moveb a5@(27),d4
	movel a5@(8),a0
	movew #32,a3
	lea 0:w,a2
	moveb a5@(19),d3
	extbl d3
	clrl d7
	clrl d6
	.even
L981:
	movel a0,a1
	movel a2,d0
	moveb a0@,d0
	movel d0,a2
	fsmovex fp1,fp0
	fsmull d0,fp0
	fmoveml fpcr,d1
	moveq #16,d2
	orl d1,d2
	andw #-33,d2
	fmoveml d2,fpcr
	fmovel fp0,d0
	fmoveml d1,fpcr
	addl d3,d0
	addql #4,a0
	moveb d5,d6
	moveb d4,d7
	cmpl d0,d6
	jgt L984
	cmpl d0,d7
	jge L986
	movel d7,d0
	jra L986
	.even
L984:
	movel d6,d0
L986:
	moveb d0,a1@
	movel a0,a1
	clrl d0
	moveb a0@,d0
	fsmovex fp1,fp0
	fsmull d0,fp0
	fmoveml fpcr,d1
	moveq #16,d2
	orl d1,d2
	andw #-33,d2
	fmoveml d2,fpcr
	fmovel fp0,d0
	fmoveml d1,fpcr
	addl d3,d0
	addql #4,a0
	clrl d1
	moveb d5,d1
	clrl d2
	moveb d4,d2
	cmpl d0,d1
	jgt L991
	cmpl d0,d2
	jge L993
	movel d2,d0
	jra L993
	.even
L991:
	movel d1,d0
L993:
	moveb d0,a1@
	movel a0,a1
	clrl d0
	moveb a0@,d0
	fsmovex fp1,fp0
	fsmull d0,fp0
	fmoveml fpcr,d1
	moveq #16,d2
	orl d1,d2
	andw #-33,d2
	fmoveml d2,fpcr
	fmovel fp0,d0
	fmoveml d1,fpcr
	addl d3,d0
	addql #4,a0
	clrl d1
	moveb d5,d1
	clrl d2
	moveb d4,d2
	cmpl d0,d1
	jgt L998
	cmpl d0,d2
	jge L1000
	movel d2,d0
	jra L1000
	.even
L998:
	movel d1,d0
L1000:
	moveb d0,a1@
	movel a0,a1
	clrl d0
	moveb a0@,d0
	fsmovex fp1,fp0
	fsmull d0,fp0
	fmoveml fpcr,d1
	moveq #16,d2
	orl d1,d2
	andw #-33,d2
	fmoveml d2,fpcr
	fmovel fp0,d0
	fmoveml d1,fpcr
	addl d3,d0
	addql #4,a0
	clrl d1
	moveb d5,d1
	clrl d2
	moveb d4,d2
	cmpl d0,d1
	jgt L1005
	cmpl d0,d2
	jge L1007
	movel d2,d0
	jra L1007
	.even
L1005:
	movel d1,d0
L1007:
	moveb d0,a1@
	movel a0,a1
	clrl d0
	moveb a0@,d0
	fsmovex fp1,fp0
	fsmull d0,fp0
	fmoveml fpcr,d1
	moveq #16,d2
	orl d1,d2
	andw #-33,d2
	fmoveml d2,fpcr
	fmovel fp0,d0
	fmoveml d1,fpcr
	addl d3,d0
	addql #4,a0
	clrl d1
	moveb d5,d1
	clrl d2
	moveb d4,d2
	cmpl d0,d1
	jgt L1012
	cmpl d0,d2
	jge L1014
	movel d2,d0
	jra L1014
	.even
L1012:
	movel d1,d0
L1014:
	moveb d0,a1@
	movel a0,a1
	clrl d0
	moveb a0@,d0
	fsmovex fp1,fp0
	fsmull d0,fp0
	fmoveml fpcr,d1
	moveq #16,d2
	orl d1,d2
	andw #-33,d2
	fmoveml d2,fpcr
	fmovel fp0,d0
	fmoveml d1,fpcr
	addl d3,d0
	addql #4,a0
	clrl d1
	moveb d5,d1
	clrl d2
	moveb d4,d2
	cmpl d0,d1
	jgt L1019
	cmpl d0,d2
	jge L1021
	movel d2,d0
	jra L1021
	.even
L1019:
	movel d1,d0
L1021:
	moveb d0,a1@
	movel a0,a1
	clrl d0
	moveb a0@,d0
	fsmovex fp1,fp0
	fsmull d0,fp0
	fmoveml fpcr,d1
	moveq #16,d2
	orl d1,d2
	andw #-33,d2
	fmoveml d2,fpcr
	fmovel fp0,d0
	fmoveml d1,fpcr
	addl d3,d0
	addql #4,a0
	clrl d1
	moveb d5,d1
	clrl d2
	moveb d4,d2
	cmpl d0,d1
	jgt L1026
	cmpl d0,d2
	jge L1028
	movel d2,d0
	jra L1028
	.even
L1026:
	movel d1,d0
L1028:
	moveb d0,a1@
	movel a0,a1
	clrl d0
	moveb a1@,d0
	fsmovex fp1,fp0
	fsmull d0,fp0
	fmoveml fpcr,d1
	moveq #16,d2
	orl d1,d2
	andw #-33,d2
	fmoveml d2,fpcr
	fmovel fp0,d0
	fmoveml d1,fpcr
	addl d3,d0
	lea a1@(4),a0
	clrl d1
	moveb d5,d1
	clrl d2
	moveb d4,d2
	cmpl d0,d1
	jgt L1033
	cmpl d0,d2
	jge L1035
	movel d2,d0
	jra L1035
	.even
L1033:
	movel d1,d0
L1035:
	moveb d0,a1@
	subql #1,a3
	tstl a3
	jne L981
	moveml sp@+,#0xcfc
	unlk a5
	rts
	.even
.globl _scaleRed__7PalettefScUcUc
_scaleRed__7PalettefScUcUc:
	pea a5@
	movel sp,a5
	moveml #0x3f38,sp@-
	fsmoves a5@(12),fp1
	moveb a5@(23),d5
	moveb a5@(27),d4
	movel a5@(8),a1
	movew #32,a4
	lea 0:w,a3
	moveb a5@(19),d3
	extbl d3
	clrl d7
	clrl d6
	lea a1@(1),a0
	.even
L1042:
	movel a3,d0
	moveb a0@,d0
	movel d0,a3
	fsmovex fp1,fp0
	fsmull d0,fp0
	fmoveml fpcr,d1
	moveq #16,d2
	orl d1,d2
	andw #-33,d2
	fmoveml d2,fpcr
	fmovel fp0,d0
	fmoveml d1,fpcr
	movel d0,d1
	addl d3,d1
	addql #4,a0
	addql #4,a1
	moveb d5,d6
	moveb d4,d7
	cmpl d1,d6
	jgt L1045
	movel d1,d0
	cmpl d0,d7
	jge L1047
	movel d7,d0
	jra L1047
	.even
L1045:
	movel d6,d0
L1047:
	moveb d0,a0@(-4)
	clrl d0
	moveb a0@,d0
	fsmovex fp1,fp0
	fsmull d0,fp0
	fmoveml fpcr,d1
	moveq #16,d2
	orl d1,d2
	andw #-33,d2
	fmoveml d2,fpcr
	fmovel fp0,d0
	fmoveml d1,fpcr
	movel d0,d1
	addl d3,d1
	movel a1,d0
	addql #4,a0
	addql #4,a1
	movel d0,a2
	addql #1,a2
	clrl d0
	moveb d5,d0
	clrl d2
	moveb d4,d2
	cmpl d1,d0
	jgt L1054
	movel d1,d0
	cmpl d0,d2
	jge L1054
	movel d2,d0
L1054:
	moveb d0,a2@
	clrl d0
	moveb a0@,d0
	fsmovex fp1,fp0
	fsmull d0,fp0
	fmoveml fpcr,d1
	moveq #16,d2
	orl d1,d2
	andw #-33,d2
	fmoveml d2,fpcr
	fmovel fp0,d0
	fmoveml d1,fpcr
	movel d0,d1
	addl d3,d1
	movel a1,d0
	addql #4,a0
	addql #4,a1
	movel d0,a2
	addql #1,a2
	clrl d0
	moveb d5,d0
	clrl d2
	moveb d4,d2
	cmpl d1,d0
	jgt L1061
	movel d1,d0
	cmpl d0,d2
	jge L1061
	movel d2,d0
L1061:
	moveb d0,a2@
	clrl d0
	moveb a0@,d0
	fsmovex fp1,fp0
	fsmull d0,fp0
	fmoveml fpcr,d1
	moveq #16,d2
	orl d1,d2
	andw #-33,d2
	fmoveml d2,fpcr
	fmovel fp0,d0
	fmoveml d1,fpcr
	movel d0,d1
	addl d3,d1
	movel a1,d0
	addql #4,a0
	addql #4,a1
	movel d0,a2
	addql #1,a2
	clrl d0
	moveb d5,d0
	clrl d2
	moveb d4,d2
	cmpl d1,d0
	jgt L1068
	movel d1,d0
	cmpl d0,d2
	jge L1068
	movel d2,d0
L1068:
	moveb d0,a2@
	clrl d0
	moveb a0@,d0
	fsmovex fp1,fp0
	fsmull d0,fp0
	fmoveml fpcr,d1
	moveq #16,d2
	orl d1,d2
	andw #-33,d2
	fmoveml d2,fpcr
	fmovel fp0,d0
	fmoveml d1,fpcr
	movel d0,d1
	addl d3,d1
	movel a1,d0
	addql #4,a0
	addql #4,a1
	movel d0,a2
	addql #1,a2
	clrl d0
	moveb d5,d0
	clrl d2
	moveb d4,d2
	cmpl d1,d0
	jgt L1075
	movel d1,d0
	cmpl d0,d2
	jge L1075
	movel d2,d0
L1075:
	moveb d0,a2@
	clrl d0
	moveb a0@,d0
	fsmovex fp1,fp0
	fsmull d0,fp0
	fmoveml fpcr,d1
	moveq #16,d2
	orl d1,d2
	andw #-33,d2
	fmoveml d2,fpcr
	fmovel fp0,d0
	fmoveml d1,fpcr
	movel d0,d1
	addl d3,d1
	movel a1,d0
	addql #4,a0
	addql #4,a1
	movel d0,a2
	addql #1,a2
	clrl d0
	moveb d5,d0
	clrl d2
	moveb d4,d2
	cmpl d1,d0
	jgt L1082
	movel d1,d0
	cmpl d0,d2
	jge L1082
	movel d2,d0
L1082:
	moveb d0,a2@
	clrl d0
	moveb a0@,d0
	fsmovex fp1,fp0
	fsmull d0,fp0
	fmoveml fpcr,d1
	moveq #16,d2
	orl d1,d2
	andw #-33,d2
	fmoveml d2,fpcr
	fmovel fp0,d0
	fmoveml d1,fpcr
	movel d0,d1
	addl d3,d1
	movel a1,d0
	addql #4,a0
	addql #4,a1
	movel d0,a2
	addql #1,a2
	clrl d0
	moveb d5,d0
	clrl d2
	moveb d4,d2
	cmpl d1,d0
	jgt L1089
	movel d1,d0
	cmpl d0,d2
	jge L1089
	movel d2,d0
L1089:
	moveb d0,a2@
	clrl d0
	moveb a0@,d0
	fsmovex fp1,fp0
	fsmull d0,fp0
	fmoveml fpcr,d1
	moveq #16,d2
	orl d1,d2
	andw #-33,d2
	fmoveml d2,fpcr
	fmovel fp0,d0
	fmoveml d1,fpcr
	movel d0,d1
	addl d3,d1
	movel a1,d0
	addql #4,a0
	addql #4,a1
	movel d0,a2
	addql #1,a2
	clrl d0
	moveb d5,d0
	clrl d2
	moveb d4,d2
	cmpl d1,d0
	jgt L1096
	movel d1,d0
	cmpl d0,d2
	jge L1096
	movel d2,d0
L1096:
	moveb d0,a2@
	subql #1,a4
	tstl a4
	jne L1042
	moveml sp@+,#0x1cfc
	unlk a5
	rts
	.even
.globl _scaleGreen__7PalettefScUcUc
_scaleGreen__7PalettefScUcUc:
	pea a5@
	movel sp,a5
	moveml #0x3f38,sp@-
	fsmoves a5@(12),fp1
	moveb a5@(23),d5
	moveb a5@(27),d4
	movel a5@(8),a1
	movew #32,a4
	lea 0:w,a3
	moveb a5@(19),d3
	extbl d3
	clrl d7
	clrl d6
	lea a1@(2),a0
	.even
L1103:
	movel a3,d0
	moveb a0@,d0
	movel d0,a3
	fsmovex fp1,fp0
	fsmull d0,fp0
	fmoveml fpcr,d1
	moveq #16,d2
	orl d1,d2
	andw #-33,d2
	fmoveml d2,fpcr
	fmovel fp0,d0
	fmoveml d1,fpcr
	movel d0,d1
	addl d3,d1
	addql #4,a0
	addql #4,a1
	moveb d5,d6
	moveb d4,d7
	cmpl d1,d6
	jgt L1106
	movel d1,d0
	cmpl d0,d7
	jge L1108
	movel d7,d0
	jra L1108
	.even
L1106:
	movel d6,d0
L1108:
	moveb d0,a0@(-4)
	clrl d0
	moveb a0@,d0
	fsmovex fp1,fp0
	fsmull d0,fp0
	fmoveml fpcr,d1
	moveq #16,d2
	orl d1,d2
	andw #-33,d2
	fmoveml d2,fpcr
	fmovel fp0,d0
	fmoveml d1,fpcr
	movel d0,d1
	addl d3,d1
	movel a1,d0
	addql #4,a0
	addql #4,a1
	movel d0,a2
	addql #2,a2
	clrl d0
	moveb d5,d0
	clrl d2
	moveb d4,d2
	cmpl d1,d0
	jgt L1115
	movel d1,d0
	cmpl d0,d2
	jge L1115
	movel d2,d0
L1115:
	moveb d0,a2@
	clrl d0
	moveb a0@,d0
	fsmovex fp1,fp0
	fsmull d0,fp0
	fmoveml fpcr,d1
	moveq #16,d2
	orl d1,d2
	andw #-33,d2
	fmoveml d2,fpcr
	fmovel fp0,d0
	fmoveml d1,fpcr
	movel d0,d1
	addl d3,d1
	movel a1,d0
	addql #4,a0
	addql #4,a1
	movel d0,a2
	addql #2,a2
	clrl d0
	moveb d5,d0
	clrl d2
	moveb d4,d2
	cmpl d1,d0
	jgt L1122
	movel d1,d0
	cmpl d0,d2
	jge L1122
	movel d2,d0
L1122:
	moveb d0,a2@
	clrl d0
	moveb a0@,d0
	fsmovex fp1,fp0
	fsmull d0,fp0
	fmoveml fpcr,d1
	moveq #16,d2
	orl d1,d2
	andw #-33,d2
	fmoveml d2,fpcr
	fmovel fp0,d0
	fmoveml d1,fpcr
	movel d0,d1
	addl d3,d1
	movel a1,d0
	addql #4,a0
	addql #4,a1
	movel d0,a2
	addql #2,a2
	clrl d0
	moveb d5,d0
	clrl d2
	moveb d4,d2
	cmpl d1,d0
	jgt L1129
	movel d1,d0
	cmpl d0,d2
	jge L1129
	movel d2,d0
L1129:
	moveb d0,a2@
	clrl d0
	moveb a0@,d0
	fsmovex fp1,fp0
	fsmull d0,fp0
	fmoveml fpcr,d1
	moveq #16,d2
	orl d1,d2
	andw #-33,d2
	fmoveml d2,fpcr
	fmovel fp0,d0
	fmoveml d1,fpcr
	movel d0,d1
	addl d3,d1
	movel a1,d0
	addql #4,a0
	addql #4,a1
	movel d0,a2
	addql #2,a2
	clrl d0
	moveb d5,d0
	clrl d2
	moveb d4,d2
	cmpl d1,d0
	jgt L1136
	movel d1,d0
	cmpl d0,d2
	jge L1136
	movel d2,d0
L1136:
	moveb d0,a2@
	clrl d0
	moveb a0@,d0
	fsmovex fp1,fp0
	fsmull d0,fp0
	fmoveml fpcr,d1
	moveq #16,d2
	orl d1,d2
	andw #-33,d2
	fmoveml d2,fpcr
	fmovel fp0,d0
	fmoveml d1,fpcr
	movel d0,d1
	addl d3,d1
	movel a1,d0
	addql #4,a0
	addql #4,a1
	movel d0,a2
	addql #2,a2
	clrl d0
	moveb d5,d0
	clrl d2
	moveb d4,d2
	cmpl d1,d0
	jgt L1143
	movel d1,d0
	cmpl d0,d2
	jge L1143
	movel d2,d0
L1143:
	moveb d0,a2@
	clrl d0
	moveb a0@,d0
	fsmovex fp1,fp0
	fsmull d0,fp0
	fmoveml fpcr,d1
	moveq #16,d2
	orl d1,d2
	andw #-33,d2
	fmoveml d2,fpcr
	fmovel fp0,d0
	fmoveml d1,fpcr
	movel d0,d1
	addl d3,d1
	movel a1,d0
	addql #4,a0
	addql #4,a1
	movel d0,a2
	addql #2,a2
	clrl d0
	moveb d5,d0
	clrl d2
	moveb d4,d2
	cmpl d1,d0
	jgt L1150
	movel d1,d0
	cmpl d0,d2
	jge L1150
	movel d2,d0
L1150:
	moveb d0,a2@
	clrl d0
	moveb a0@,d0
	fsmovex fp1,fp0
	fsmull d0,fp0
	fmoveml fpcr,d1
	moveq #16,d2
	orl d1,d2
	andw #-33,d2
	fmoveml d2,fpcr
	fmovel fp0,d0
	fmoveml d1,fpcr
	movel d0,d1
	addl d3,d1
	movel a1,d0
	addql #4,a0
	addql #4,a1
	movel d0,a2
	addql #2,a2
	clrl d0
	moveb d5,d0
	clrl d2
	moveb d4,d2
	cmpl d1,d0
	jgt L1157
	movel d1,d0
	cmpl d0,d2
	jge L1157
	movel d2,d0
L1157:
	moveb d0,a2@
	subql #1,a4
	tstl a4
	jne L1103
	moveml sp@+,#0x1cfc
	unlk a5
	rts
	.even
.globl _scaleBlue__7PalettefScUcUc
_scaleBlue__7PalettefScUcUc:
	pea a5@
	movel sp,a5
	moveml #0x3f38,sp@-
	fsmoves a5@(12),fp1
	moveb a5@(23),d5
	moveb a5@(27),d4
	movel a5@(8),a1
	movew #32,a4
	lea 0:w,a3
	moveb a5@(19),d3
	extbl d3
	clrl d7
	clrl d6
	lea a1@(3),a0
	.even
L1164:
	movel a3,d0
	moveb a0@,d0
	movel d0,a3
	fsmovex fp1,fp0
	fsmull d0,fp0
	fmoveml fpcr,d1
	moveq #16,d2
	orl d1,d2
	andw #-33,d2
	fmoveml d2,fpcr
	fmovel fp0,d0
	fmoveml d1,fpcr
	movel d0,d1
	addl d3,d1
	addql #4,a0
	addql #4,a1
	moveb d5,d6
	moveb d4,d7
	cmpl d1,d6
	jgt L1167
	movel d1,d0
	cmpl d0,d7
	jge L1169
	movel d7,d0
	jra L1169
	.even
L1167:
	movel d6,d0
L1169:
	moveb d0,a0@(-4)
	clrl d0
	moveb a0@,d0
	fsmovex fp1,fp0
	fsmull d0,fp0
	fmoveml fpcr,d1
	moveq #16,d2
	orl d1,d2
	andw #-33,d2
	fmoveml d2,fpcr
	fmovel fp0,d0
	fmoveml d1,fpcr
	movel d0,d1
	addl d3,d1
	movel a1,d0
	addql #4,a0
	addql #4,a1
	movel d0,a2
	addql #3,a2
	clrl d0
	moveb d5,d0
	clrl d2
	moveb d4,d2
	cmpl d1,d0
	jgt L1176
	movel d1,d0
	cmpl d0,d2
	jge L1176
	movel d2,d0
L1176:
	moveb d0,a2@
	clrl d0
	moveb a0@,d0
	fsmovex fp1,fp0
	fsmull d0,fp0
	fmoveml fpcr,d1
	moveq #16,d2
	orl d1,d2
	andw #-33,d2
	fmoveml d2,fpcr
	fmovel fp0,d0
	fmoveml d1,fpcr
	movel d0,d1
	addl d3,d1
	movel a1,d0
	addql #4,a0
	addql #4,a1
	movel d0,a2
	addql #3,a2
	clrl d0
	moveb d5,d0
	clrl d2
	moveb d4,d2
	cmpl d1,d0
	jgt L1183
	movel d1,d0
	cmpl d0,d2
	jge L1183
	movel d2,d0
L1183:
	moveb d0,a2@
	clrl d0
	moveb a0@,d0
	fsmovex fp1,fp0
	fsmull d0,fp0
	fmoveml fpcr,d1
	moveq #16,d2
	orl d1,d2
	andw #-33,d2
	fmoveml d2,fpcr
	fmovel fp0,d0
	fmoveml d1,fpcr
	movel d0,d1
	addl d3,d1
	movel a1,d0
	addql #4,a0
	addql #4,a1
	movel d0,a2
	addql #3,a2
	clrl d0
	moveb d5,d0
	clrl d2
	moveb d4,d2
	cmpl d1,d0
	jgt L1190
	movel d1,d0
	cmpl d0,d2
	jge L1190
	movel d2,d0
L1190:
	moveb d0,a2@
	clrl d0
	moveb a0@,d0
	fsmovex fp1,fp0
	fsmull d0,fp0
	fmoveml fpcr,d1
	moveq #16,d2
	orl d1,d2
	andw #-33,d2
	fmoveml d2,fpcr
	fmovel fp0,d0
	fmoveml d1,fpcr
	movel d0,d1
	addl d3,d1
	movel a1,d0
	addql #4,a0
	addql #4,a1
	movel d0,a2
	addql #3,a2
	clrl d0
	moveb d5,d0
	clrl d2
	moveb d4,d2
	cmpl d1,d0
	jgt L1197
	movel d1,d0
	cmpl d0,d2
	jge L1197
	movel d2,d0
L1197:
	moveb d0,a2@
	clrl d0
	moveb a0@,d0
	fsmovex fp1,fp0
	fsmull d0,fp0
	fmoveml fpcr,d1
	moveq #16,d2
	orl d1,d2
	andw #-33,d2
	fmoveml d2,fpcr
	fmovel fp0,d0
	fmoveml d1,fpcr
	movel d0,d1
	addl d3,d1
	movel a1,d0
	addql #4,a0
	addql #4,a1
	movel d0,a2
	addql #3,a2
	clrl d0
	moveb d5,d0
	clrl d2
	moveb d4,d2
	cmpl d1,d0
	jgt L1204
	movel d1,d0
	cmpl d0,d2
	jge L1204
	movel d2,d0
L1204:
	moveb d0,a2@
	clrl d0
	moveb a0@,d0
	fsmovex fp1,fp0
	fsmull d0,fp0
	fmoveml fpcr,d1
	moveq #16,d2
	orl d1,d2
	andw #-33,d2
	fmoveml d2,fpcr
	fmovel fp0,d0
	fmoveml d1,fpcr
	movel d0,d1
	addl d3,d1
	movel a1,d0
	addql #4,a0
	addql #4,a1
	movel d0,a2
	addql #3,a2
	clrl d0
	moveb d5,d0
	clrl d2
	moveb d4,d2
	cmpl d1,d0
	jgt L1211
	movel d1,d0
	cmpl d0,d2
	jge L1211
	movel d2,d0
L1211:
	moveb d0,a2@
	clrl d0
	moveb a0@,d0
	fsmovex fp1,fp0
	fsmull d0,fp0
	fmoveml fpcr,d1
	moveq #16,d2
	orl d1,d2
	andw #-33,d2
	fmoveml d2,fpcr
	fmovel fp0,d0
	fmoveml d1,fpcr
	movel d0,d1
	addl d3,d1
	movel a1,d0
	addql #4,a0
	addql #4,a1
	movel d0,a2
	addql #3,a2
	clrl d0
	moveb d5,d0
	clrl d2
	moveb d4,d2
	cmpl d1,d0
	jgt L1218
	movel d1,d0
	cmpl d0,d2
	jge L1218
	movel d2,d0
L1218:
	moveb d0,a2@
	subql #1,a4
	tstl a4
	jne L1164
	moveml sp@+,#0x1cfc
	unlk a5
	rts
	.even
.globl _findBestMatch__7PaletteRC6Colourb
_findBestMatch__7PaletteRC6Colourb:
	pea a5@
	movel sp,a5
	clrl d0
	unlk a5
	rts
	.even
.globl _getDescriptor__C11ImageBuffer
_getDescriptor__C11ImageBuffer:
	pea a5@
	movel sp,a5
	movel a5@(8),a1
	movel a1@(20),a0
	moveq #15,d0
	cmpl a0,d0
	jne L1227
	movel a1@(16),d0
	jra L1229
	.even
L1227:
	lea a0@(a0:l:2),a0
	movel a0,d0
	lsll #2,d0
	addl #__15PixelDescriptor$propTab,d0
L1229:
	unlk a5
	rts
	.even
.globl _setPalette__11ImageBufferP7Palettebs
_setPalette__11ImageBufferP7Palettebs:
	pea a5@
	movel sp,a5
	moveml #0x3020,sp@-
	movel a5@(8),a2
	movel a5@(12),d2
	movew a5@(22),d3
	tstb a5@(19)
	jeq L1231
	movel a2@(4),d0
	tstl a2@(12)
	jeq L1233
	btst #1,d0
	jne L1232
L1233:
	moveq #-3,d1
	andl d0,d1
	movel d1,a2@(4)
	clrl sp@-
	tstl d2
	seq d0
	negb d0
	subql #2,sp
	moveb d0,sp@(1)
	subql #2,sp
	pea 1024:w
	jbsr _alloc__3MemUlbQ23Mem9AlignType
	movel d0,a2@(12)
	addw #12,sp
	jne L1234
	movel #-50528257,d0
	jra L1244
	.even
L1234:
	moveq #2,d0
	orl d0,a2@(4)
L1232:
	tstl d2
	jeq L1236
	pea 1024:w
	movel d2,sp@-
	movel a2@(12),sp@-
	jbsr _copy__3MemPvPCvUl
	jra L1236
	.even
L1231:
	movel a2@(4),d0
	btst #1,d0
	jeq L1237
	moveq #-3,d1
	andl d0,d1
	movel d1,a2@(4)
	movel a2@(12),d0
	jeq L1237
	movel d0,sp@-
	jbsr _free__3MemPv
L1237:
	movel d2,a2@(12)
L1236:
	movew d3,a0
	tstl a0
	jlt L1239
	movel a0,d0
	cmpl #256,d0
	jle L1241
	movel #256,d0
	jra L1241
	.even
L1239:
	clrl d0
L1241:
	movew d0,a2@(24)
	clrl d0
L1244:
	moveml a5@(-12),#0x40c
	unlk a5
	rts
	.even
.globl _create__11ImageBufferssQ25Pixel6HWTypeP7Palettebs
_create__11ImageBufferssQ25Pixel6HWTypeP7Palettebs:
	pea a5@
	movel sp,a5
	moveml #0x3e30,sp@-
	movel a5@(8),a2
	movel a5@(12),d2
	movel a5@(16),d3
	movel a5@(20),a3
	movew d2,d5
	movew d3,d4
	movew a5@(34),d6
	tstl a2@(8)
	jeq L1246
	movel #-50659332,d0
	jra L1254
	.even
L1246:
	tstw d2
	jle L1248
	tstw d3
	jgt L1247
L1248:
	movel #-50397188,d0
	jra L1254
	.even
L1247:
	lea a3@(a3:l:2),a0
	movel a0,d0
	lsll #2,d0
	movel d0,a0
	addl #__15PixelDescriptor$propTab,a0
	clrl d1
	moveb a0@,d1
	movew d5,d0
	muls d4,d0
	pea 16:w
	subql #2,sp
	moveb #0,sp@(1)
	subql #2,sp
	mulsl d1,d0
	movel d0,sp@-
	jbsr _alloc__3MemUlbQ23Mem9AlignType
	movel d0,a2@(8)
	addw #12,sp
	jne L1251
	movel #-50528257,d0
	jra L1254
	.even
L1251:
	moveq #1,d0
	movel d0,a2@(4)
	movew d2,a2@
	movew d3,a2@(2)
	movel a3,a2@(20)
	clrw a2@(24)
	tstl a3
	jne L1252
	movew d6,a0
	movel a0,sp@-
	subql #2,sp
	moveb a5@(31),sp@(1)
	subql #2,sp
	movel a5@(24),sp@-
	movel a2,sp@-
	jbsr _setPalette__11ImageBufferP7Palettebs
	addw #16,sp
	tstl d0
	jeq L1252
	movel a2,sp@-
	jbsr _destroy__11ImageBuffer
	movel #-50659333,d0
	jra L1254
	.even
L1252:
	clrl d0
L1254:
	moveml a5@(-28),#0xc7c
	unlk a5
	rts
	.even
.globl _create__11ImageBufferssP15PixelDescriptorP7PalettebT5s
_create__11ImageBufferssP15PixelDescriptorP7PalettebT5s:
	link a5,#-76
	fmovem #0xfc,sp@-
	moveml #0x3f3a,sp@-
	movel a5@(12),a5@(-54)
	movel a5@(16),a5@(-60)
	movew a5@(-52),a5@(-50)
	movew a5@(-58),a5@(-56)
	movew a5@(38),a5@(-62)
	jbsr ___get_eh_context
	movel d0,a5@(-74)
	movel a5@(8),a0
	tstl a0@(8)
	jeq L1256
	movel #-50659332,d0
	jra L1282
	.even
L1256:
	tstw a5@(-52)
	jle L1258
	tstw a5@(-58)
	jgt L1257
L1258:
	movel #-50397188,d0
	jra L1282
	.even
L1257:
	tstl a5@(20)
	jne L1259
	movel #-50462722,d0
	jra L1282
	.even
L1259:
	movel a5@(20),a1
	clrl d0
	moveb a1@,d0
	movew a5@(-50),d1
	muls a5@(-56),d1
	mulsl d1,d0
	movel d0,a5@(-66)
	movel a5@(8),a0
	clrl a0@(4)
	tstb a5@(31)
	jeq L1261
	pea _nothrow
	pea 12:w
	jbsr ___nw__FUlRC9nothrow_t
	movel d0,a5@(-70)
	movel a5@(-74),a0
	addql #4,a0
	movel a0@,a5@(-24)
	clrl a5@(-20)
	movel a5,a5@(-16)
	movel #L1266,a5@(-12)
	movel sp,a5@(-8)
	movel a0,a1
	jra L1265
	.even
L1266:
	jra L1283
	.even
L1265:
	lea a5@(-24),a2
	movel a2,a0@
	addql #8,sp
	movel a5@(8),a0
	movel a5@(-70),a0@(16)
	movel a1@,a0
	movel a0@,a1@
	movel #-50528257,d0
	tstl a5@(-70)
	jeq L1282
	moveq #4,d0
	movel a5@(8),a0
	orl d0,a0@(4)
	movel a0@(16),a1
	movel a5@(20),a2
	moveb a2@+,a1@+
	movel a2,a0
	moveb a0@+,a1@+
	moveb a0@+,a1@+
	moveb a0@+,a1@+
	moveb a0@+,a1@+
	moveb a0@+,a1@+
	moveb a0@+,a1@+
	moveb a0@+,a1@+
	moveb a0@+,a1@+
	moveb a0@+,a1@+
	moveb a0@+,a1@+
	moveb a0@,a1@
	jra L1271
	.even
L1261:
	movel a5@(8),a0
	movel a5@(20),a0@(16)
L1271:
	clrl sp@-
	subql #2,sp
	moveb #0,sp@(1)
	subql #2,sp
	movel a5@(-66),sp@-
	jbsr _alloc__3MemUlbQ23Mem9AlignType
	movel a5@(8),a1
	movel d0,a1@(8)
	addw #12,sp
	jne L1272
	movel #-50528257,d0
	jra L1282
	.even
L1272:
	moveq #1,d0
	movel a5@(8),a0
	orl d0,a0@(4)
	movew a5@(-50),a0@
	movew a5@(-56),a0@(2)
	moveq #15,d0
	movel d0,a0@(20)
	clrw a0@(24)
	tstl a5@(24)
	jeq L1273
	movew a5@(-62),a0
	movel a0,sp@-
	subql #2,sp
	moveb a5@(35),sp@(1)
	subql #2,sp
	movel a5@(24),sp@-
	movel a5@(8),sp@-
	jbsr _setPalette__11ImageBufferP7Palettebs
	addw #16,sp
	tstl d0
	jeq L1273
	movel a5@(8),sp@-
	jbsr _destroy__11ImageBuffer
	movel #-50659333,d0
	jra L1282
	.even
L1273:
	clrl d0
	jra L1282
	.even
L1283:
L1263:
	movel a5@(-74),a0
	addql #4,a0
	movel a0@,a5@(-48)
	clrl a5@(-44)
	movel a5,a5@(-40)
	movel #L1278,a5@(-36)
	movel sp,a5@(-32)
	jra L1277
	.even
L1278:
	jra L1284
	.even
L1277:
	lea a5@(-48),a1
	movel a1,a0@
	clrb d0
	jeq L1280
	pea _nothrow
	movel a5@(-70),sp@-
	jbsr ___dl__FPvRC9nothrow_t
	addql #8,sp
L1280:
	movel a5@(-74),a1
	addql #4,a1
	movel a1@,a0
	movel a0@,a1@
	jbsr ___sjthrow
	.even
L1284:
L1275:
	jbsr ___terminate
	.even
L1282:
	moveml a5@(-188),#0x5cfc
	fmovem a5@(-148),#0x3f
	unlk a5
	rts
	.even
.globl _destroy__11ImageBuffer
_destroy__11ImageBuffer:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel a5@(8),a2
	btst #0,a2@(7)
	jeq L1286
	movel a2@(8),d0
	jeq L1286
	movel d0,sp@-
	jbsr _free__3MemPv
	addql #4,sp
L1286:
	btst #1,a2@(7)
	jeq L1287
	movel a2@(12),d0
	jeq L1287
	movel d0,sp@-
	jbsr _free__3MemPv
	addql #4,sp
L1287:
	btst #2,a2@(7)
	jeq L1288
	movel a2@(16),d0
	jeq L1288
	movel d0,sp@-
	jbsr ___builtin_delete
L1288:
	clrl a2@(4)
	clrl a2@(8)
	clrl a2@(12)
	clrl a2@(16)
	clrw a2@(24)
	clrw a2@(2)
	clrw a2@
	clrl a2@(20)
	movel a5@(-4),a2
	unlk a5
	rts
	.even
.globl _setIBData__19ImageBufferProviderP11ImageBufferPvb
_setIBData__19ImageBufferProviderP11ImageBufferPvb:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel a5@(8),a2
	tstl a2
	jeq L1289
	movel a2@(8),d0
	jeq L1291
	btst #0,a2@(7)
	jeq L1291
	movel d0,sp@-
	jbsr _free__3MemPv
	moveq #-2,d0
	andl d0,a2@(4)
L1291:
	movel a5@(12),a2@(8)
	tstb a5@(19)
	jeq L1289
	moveq #1,d0
	orl d0,a2@(4)
L1289:
	movel a5@(-4),a2
	unlk a5
	rts
	.even
.globl _setIBPalette__19ImageBufferProviderP11ImageBufferP7Paletteb
_setIBPalette__19ImageBufferProviderP11ImageBufferP7Paletteb:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel a5@(8),a2
	tstl a2
	jeq L1293
	movel a2@(12),d0
	jeq L1295
	btst #1,a2@(7)
	jeq L1295
	movel d0,sp@-
	jbsr _free__3MemPv
	moveq #-3,d0
	andl d0,a2@(4)
L1295:
	movel a5@(12),a2@(12)
	tstb a5@(19)
	jeq L1293
	moveq #2,d0
	orl d0,a2@(4)
L1293:
	movel a5@(-4),a2
	unlk a5
	rts
.globl __17DisplayProperties$modesAvail
.data
	.even
__17DisplayProperties$modesAvail:
	.long 0
.globl __17DisplayProperties$numModes
	.even
__17DisplayProperties$numModes:
	.long 0
.globl __17DisplayProperties$minWidth
	.even
__17DisplayProperties$minWidth:
	.word 640
.globl __17DisplayProperties$maxWidth
	.even
__17DisplayProperties$maxWidth:
	.word 640
.globl __17DisplayProperties$minHeight
	.even
__17DisplayProperties$minHeight:
	.word 480
.globl __17DisplayProperties$maxHeight
	.even
__17DisplayProperties$maxHeight:
	.word 480
.globl __17DisplayProperties$minDepth
	.even
__17DisplayProperties$minDepth:
	.word 8
.globl __17DisplayProperties$maxDepth
	.even
__17DisplayProperties$maxDepth:
	.word 8
.text
	.even
.globl _findIndex__17DisplayPropertiesssQ25Pixel5Depthb
_findIndex__17DisplayPropertiesssQ25Pixel5Depthb:
	pea a5@
	movel sp,a5
	moveml #0x3830,sp@-
	movel a5@(16),d4
	movew a5@(10),a0
	movew a5@(14),a1
	clrl d1
	tstb a5@(23)
	jeq L1298
	moveq #1,d2
	movel __17DisplayProperties$numModes,d0
	cmpl d2,d0
	jls L1309
	movew a0,a3
	movew a1,a2
	movel d0,d3
	movel __17DisplayProperties$modesAvail,a0
	lea a0@(64),a1
	.even
L1301:
	movew a1@,a0
	clrl d1
	cmpl a0,a3
	jne L1303
	movew a1@(2),a0
	cmpl a0,a2
	jne L1303
	cmpl a1@(24),d4
	seq d0
	extbl d0
	movel d2,d1
	andl d0,d1
L1303:
	addw #64,a1
	addql #1,d2
	cmpl d2,d3
	jls L1309
	tstl d1
	jeq L1301
	jra L1309
	.even
L1298:
	moveq #1,d2
	movel __17DisplayProperties$numModes,d0
	cmpl d2,d0
	jls L1309
	movew a0,a3
	movew a1,a2
	movel d0,d3
	movel __17DisplayProperties$modesAvail,a0
	lea a0@(64),a1
	.even
L1312:
	movew a1@,a0
	clrl d1
	cmpl a0,a3
	jgt L1314
	movew a1@(2),a0
	cmpl a0,a2
	jgt L1314
	cmpl a1@(24),d4
	sle d0
	extbl d0
	movel d2,d1
	andl d0,d1
L1314:
	addw #64,a1
	addql #1,d2
	cmpl d2,d3
	jls L1309
	tstl d1
	jeq L1312
L1309:
	movel d1,d0
	moveml sp@+,#0xc1c
	unlk a5
	rts
LC1:
	.ascii "Windowed\0"
	.even
.globl _createModeDatabase__25DisplayPropertiesProviderUl
_createModeDatabase__25DisplayPropertiesProviderUl:
	pea a5@
	movel sp,a5
	movel d2,sp@-
	movel a5@(8),d2
	tstl __17DisplayProperties$modesAvail
	jne L1324
	clrl sp@-
	subql #2,sp
	moveb #1,sp@(1)
	subql #2,sp
	movel d2,d0
	lsll #6,d0
	movel d0,sp@-
	jbsr _alloc__3MemUlbQ23Mem9AlignType
	addw #12,sp
	tstl d0
	jne L1325
	clrl __17DisplayProperties$numModes
	clrl d0
	jra L1327
	.even
L1325:
	movel d2,__17DisplayProperties$numModes
	movel d0,__17DisplayProperties$modesAvail
L1324:
	pea 1:w
	pea 1:w
	clrl sp@-
	jbsr _setTiming__25DisplayPropertiesProviderUlUlUl
	pea 240:w
	pea 320:w
	clrl sp@-
	jbsr _setDimension__25DisplayPropertiesProviderUlss
	movel #43715,sp@-
	clrl sp@-
	jbsr _setPropertyFlags__25DisplayPropertiesProviderUlUs
	addw #28,sp
	clrl sp@
	pea 15:w
	clrl sp@-
	jbsr _setFormat__25DisplayPropertiesProviderUlQ25Pixel6HWTypeQ25Pixel5Depth
	pea LC1
	clrl sp@-
	jbsr _setName__25DisplayPropertiesProviderUlPCc
	movel __17DisplayProperties$modesAvail,d0
L1327:
	movel a5@(-4),d2
	unlk a5
	rts
	.even
.globl _freeModeDatabase__25DisplayPropertiesProvider
_freeModeDatabase__25DisplayPropertiesProvider:
	pea a5@
	movel sp,a5
	movel __17DisplayProperties$modesAvail,d0
	jeq L1329
	movel d0,sp@-
	jbsr _free__3MemPv
L1329:
	clrl __17DisplayProperties$modesAvail
	clrl __17DisplayProperties$numModes
	unlk a5
	rts
	.even
.globl _setLimits__25DisplayPropertiesProviderssssss
_setLimits__25DisplayPropertiesProviderssssss:
	pea a5@
	movel sp,a5
	moveml #0x3800,sp@-
	movel a5@(12),d0
	movel a5@(16),d1
	movel a5@(20),d2
	movel a5@(24),d3
	movel a5@(28),d4
	movew a5@(10),__17DisplayProperties$minWidth
	movew d0,__17DisplayProperties$maxWidth
	movew d1,__17DisplayProperties$minHeight
	movew d2,__17DisplayProperties$maxHeight
	movew d3,__17DisplayProperties$minDepth
	movew d4,__17DisplayProperties$maxDepth
	moveml sp@+,#0x1c
	unlk a5
	rts
	.even
.globl _setModeIndex__25DisplayPropertiesProviderUlUl
_setModeIndex__25DisplayPropertiesProviderUlUl:
	pea a5@
	movel sp,a5
	movel a5@(8),d0
	movel __17DisplayProperties$modesAvail,a0
	tstl a0
	jeq L1332
	cmpl __17DisplayProperties$numModes,d0
	jcc L1332
	lsll #6,d0
	movel a5@(12),a0@(4,d0:l)
	moveq #1,d0
	jra L1333
	.even
L1332:
	clrb d0
L1333:
	unlk a5
	rts
	.even
.globl _setTiming__25DisplayPropertiesProviderUlUlUl
_setTiming__25DisplayPropertiesProviderUlUlUl:
	pea a5@
	movel sp,a5
	movel a5@(8),d0
	movel __17DisplayProperties$modesAvail,a0
	tstl a0
	jeq L1335
	cmpl __17DisplayProperties$numModes,d0
	jcc L1335
	lsll #6,d0
	movel a5@(12),a0@(8,d0:l)
	movel a5@(16),a0@(12,d0:l)
	moveq #1,d0
	jra L1336
	.even
L1335:
	clrb d0
L1336:
	unlk a5
	rts
	.even
.globl _setDimension__25DisplayPropertiesProviderUlss
_setDimension__25DisplayPropertiesProviderUlss:
	pea a5@
	movel sp,a5
	moveml #0x3800,sp@-
	movel a5@(8),d4
	movel a5@(12),d0
	movel a5@(16),d1
	movew d0,d3
	movew d1,d2
	movel __17DisplayProperties$modesAvail,a1
	tstl a1
	jeq L1338
	cmpl __17DisplayProperties$numModes,d4
	jcc L1338
	lsll #6,d4
	movel d4,a0
	movew d0,a1@(a0:l)
	movew d1,a1@(2,a0:l)
	fsmovew d2,fp0
	fsdivw d3,fp0
	fdmuld #0r1.333333333333338,fp0
	fsmovex fp0,fp0
	fmoves fp0,a1@(16,a0:l)
	moveq #1,d0
	jra L1339
	.even
L1338:
	clrb d0
L1339:
	moveml sp@+,#0x1c
	unlk a5
	rts
	.even
.globl _setAspect__25DisplayPropertiesProviderUlf
_setAspect__25DisplayPropertiesProviderUlf:
	pea a5@
	movel sp,a5
	movel a5@(8),d0
	movel __17DisplayProperties$modesAvail,a0
	tstl a0
	jeq L1341
	cmpl __17DisplayProperties$numModes,d0
	jcc L1341
	lsll #6,d0
	movel a5@(12),a0@(16,d0:l)
	moveq #1,d0
	jra L1342
	.even
L1341:
	clrb d0
L1342:
	unlk a5
	rts
	.even
.globl _setPropertyFlags__25DisplayPropertiesProviderUlUs
_setPropertyFlags__25DisplayPropertiesProviderUlUs:
	pea a5@
	movel sp,a5
	movel a5@(8),d0
	movel a5@(12),d1
	movel __17DisplayProperties$modesAvail,a0
	tstl a0
	jeq L1344
	cmpl __17DisplayProperties$numModes,d0
	jcc L1344
	lsll #6,d0
	clrw a0@(20,d0:l)
	movew d1,a0@(22,d0:l)
	moveq #1,d0
	jra L1345
	.even
L1344:
	clrb d0
L1345:
	unlk a5
	rts
	.even
.globl _setFormat__25DisplayPropertiesProviderUlQ25Pixel6HWTypeQ25Pixel5Depth
_setFormat__25DisplayPropertiesProviderUlQ25Pixel6HWTypeQ25Pixel5Depth:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel a5@(8),d0
	movel a5@(12),a1
	movel a5@(16),d1
	movel __17DisplayProperties$modesAvail,a0
	tstl a0
	jeq L1347
	cmpl __17DisplayProperties$numModes,d0
	jcc L1347
	lsll #6,d0
	movel a1,a0@(28,d0:l)
	movel d0,a2
	tstl d1
	jne L1348
	moveq #14,d0
	cmpl a1,d0
	jcs L1348
LI1366:
	movew pc@(L1366-LI1366-2:b,a1:l:2),d0
	jmp pc@(2,d0:w)
	.even
L1366:
	.word L1350-L1366
	.word L1354-L1366
	.word L1354-L1366
	.word L1354-L1366
	.word L1354-L1366
	.word L1358-L1366
	.word L1358-L1366
	.word L1358-L1366
	.word L1358-L1366
	.word L1360-L1366
	.word L1360-L1366
	.word L1364-L1366
	.word L1364-L1366
	.word L1364-L1366
	.word L1364-L1366
	.even
L1350:
	moveq #8,d1
	jra L1348
	.even
L1354:
	moveq #15,d1
	jra L1348
	.even
L1358:
	moveq #16,d1
	jra L1348
	.even
L1360:
	moveq #24,d1
	jra L1348
	.even
L1364:
	moveq #32,d1
L1348:
	movel __17DisplayProperties$modesAvail,a0
	movel d1,a0@(24,a2:l)
	moveq #1,d0
	jra L1368
	.even
L1347:
	clrb d0
L1368:
	movel sp@+,a2
	unlk a5
	rts
	.even
.globl _setName__25DisplayPropertiesProviderUlPCc
_setName__25DisplayPropertiesProviderUlPCc:
	pea a5@
	movel sp,a5
	movel a5@(8),d0
	movel __17DisplayProperties$modesAvail,a0
	tstl a0
	jeq L1370
	cmpl __17DisplayProperties$numModes,d0
	jcc L1370
	pea 31:w
	movel a5@(12),sp@-
	lsll #6,d0
	pea a0@(32,d0:l)
	jbsr _strncpy
	moveq #1,d0
	jra L1372
	.even
L1370:
	clrb d0
L1372:
	unlk a5
	rts
.globl __15PixelDescriptor$propTab
	.bss
__15PixelDescriptor$propTab:
	.skip 180
.text
	.even
___static_initialization_and_destruction_0:
	pea a5@
	movel sp,a5
	cmpl #65535,a5@(12)
	jne L1407
	tstl a5@(8)
	jeq L1407
	lea __15PixelDescriptor$propTab,a0
	moveb #1,a0@
	moveb #1,a0@(1)
	moveb #1,a0@(2)
	clrb a0@(3)
	moveb #8,a0@(4)
	moveb #8,a0@(5)
	moveb #8,a0@(6)
	moveb #8,a0@(7)
	clrb a0@(8)
	clrb a0@(9)
	clrb a0@(10)
	clrb a0@(11)
	lea __15PixelDescriptor$propTab+12,a0
	moveb #2,a0@
	moveb #2,a0@(1)
	clrb a0@(2)
	clrb a0@(3)
	clrb a0@(4)
	moveb #5,a0@(5)
	moveb #5,a0@(6)
	moveb #5,a0@(7)
	clrb a0@(8)
	moveb #10,a0@(9)
	moveb #5,a0@(10)
	clrb a0@(11)
	lea __15PixelDescriptor$propTab+24,a0
	moveb #2,a0@
	moveb #2,a0@(1)
	clrb a0@(2)
	clrb a0@(3)
	clrb a0@(4)
	moveb #5,a0@(5)
	moveb #5,a0@(6)
	moveb #5,a0@(7)
	clrb a0@(8)
	clrb a0@(9)
	moveb #5,a0@(10)
	moveb #10,a0@(11)
	lea __15PixelDescriptor$propTab+36,a0
	moveb #2,a0@
	moveb #2,a0@(1)
	clrb a0@(2)
	moveb #1,a0@(3)
	clrb a0@(4)
	moveb #5,a0@(5)
	moveb #5,a0@(6)
	moveb #5,a0@(7)
	clrb a0@(8)
	moveb #10,a0@(9)
	moveb #5,a0@(10)
	clrb a0@(11)
	lea __15PixelDescriptor$propTab+48,a0
	moveb #2,a0@
	moveb #2,a0@(1)
	clrb a0@(2)
	moveb #1,a0@(3)
	clrb a0@(4)
	moveb #5,a0@(5)
	moveb #5,a0@(6)
	moveb #5,a0@(7)
	clrb a0@(8)
	clrb a0@(9)
	moveb #5,a0@(10)
	moveb #10,a0@(11)
	lea __15PixelDescriptor$propTab+60,a0
	moveb #2,a0@
	moveb #2,a0@(1)
	clrb a0@(2)
	clrb a0@(3)
	clrb a0@(4)
	moveb #5,a0@(5)
	moveb #6,a0@(6)
	moveb #5,a0@(7)
	clrb a0@(8)
	moveb #11,a0@(9)
	moveb #5,a0@(10)
	clrb a0@(11)
	lea __15PixelDescriptor$propTab+72,a0
	moveb #2,a0@
	moveb #2,a0@(1)
	clrb a0@(2)
	clrb a0@(3)
	clrb a0@(4)
	moveb #5,a0@(5)
	moveb #6,a0@(6)
	moveb #5,a0@(7)
	clrb a0@(8)
	clrb a0@(9)
	moveb #5,a0@(10)
	moveb #11,a0@(11)
	lea __15PixelDescriptor$propTab+84,a0
	moveb #2,a0@
	moveb #2,a0@(1)
	clrb a0@(2)
	moveb #1,a0@(3)
	clrb a0@(4)
	moveb #5,a0@(5)
	moveb #6,a0@(6)
	moveb #5,a0@(7)
	clrb a0@(8)
	moveb #11,a0@(9)
	moveb #5,a0@(10)
	clrb a0@(11)
	lea __15PixelDescriptor$propTab+96,a0
	moveb #2,a0@
	moveb #2,a0@(1)
	clrb a0@(2)
	moveb #1,a0@(3)
	clrb a0@(4)
	moveb #5,a0@(5)
	moveb #6,a0@(6)
	moveb #5,a0@(7)
	clrb a0@(8)
	clrb a0@(9)
	moveb #5,a0@(10)
	moveb #11,a0@(11)
	lea __15PixelDescriptor$propTab+108,a0
	moveb #3,a0@
	moveb #3,a0@(1)
	clrb a0@(2)
	clrb a0@(3)
	clrb a0@(4)
	moveb #8,a0@(5)
	moveb #8,a0@(6)
	moveb #8,a0@(7)
	clrb a0@(8)
	clrb a0@(9)
	moveb #1,a0@(10)
	moveb #2,a0@(11)
	lea __15PixelDescriptor$propTab+120,a0
	moveb #3,a0@
	moveb #3,a0@(1)
	clrb a0@(2)
	clrb a0@(3)
	clrb a0@(4)
	moveb #8,a0@(5)
	moveb #8,a0@(6)
	moveb #8,a0@(7)
	clrb a0@(8)
	moveb #2,a0@(9)
	moveb #1,a0@(10)
	clrb a0@(11)
	lea __15PixelDescriptor$propTab+132,a0
	moveb #4,a0@
	moveb #4,a0@(1)
	clrb a0@(2)
	clrb a0@(3)
	moveb #8,a0@(4)
	moveb #8,a0@(5)
	moveb #8,a0@(6)
	moveb #8,a0@(7)
	moveb #24,a0@(8)
	moveb #16,a0@(9)
	moveb #8,a0@(10)
	clrb a0@(11)
	lea __15PixelDescriptor$propTab+144,a0
	moveb #4,a0@
	moveb #4,a0@(1)
	clrb a0@(2)
	clrb a0@(3)
	moveb #8,a0@(4)
	moveb #8,a0@(5)
	moveb #8,a0@(6)
	moveb #8,a0@(7)
	moveb #24,a0@(8)
	clrb a0@(9)
	moveb #8,a0@(10)
	moveb #16,a0@(11)
	lea __15PixelDescriptor$propTab+156,a0
	moveb #4,a0@
	moveb #4,a0@(1)
	clrb a0@(2)
	moveb #1,a0@(3)
	moveb #8,a0@(4)
	moveb #8,a0@(5)
	moveb #8,a0@(6)
	moveb #8,a0@(7)
	moveb #24,a0@(8)
	moveb #16,a0@(9)
	moveb #8,a0@(10)
	clrb a0@(11)
	lea __15PixelDescriptor$propTab+168,a0
	moveb #4,a0@
	moveb #4,a0@(1)
	clrb a0@(2)
	moveb #1,a0@(3)
	moveb #8,a0@(4)
	moveb #8,a0@(5)
	moveb #8,a0@(6)
	moveb #8,a0@(7)
	moveb #24,a0@(8)
	clrb a0@(9)
	moveb #8,a0@(10)
	moveb #16,a0@(11)
L1407:
	unlk a5
	rts
	.even
.globl _INIT_8__5Pixel$formatsgfxcomm_cpp
_INIT_8__5Pixel$formatsgfxcomm_cpp:
	pea a5@
	movel sp,a5
	movel #65535,sp@-
	pea 1:w
	jbsr ___static_initialization_and_destruction_0
	unlk a5
	rts
.stabs "___CTOR_LIST__",22,0,0,_INIT_8__5Pixel$formatsgfxcomm_cpp
