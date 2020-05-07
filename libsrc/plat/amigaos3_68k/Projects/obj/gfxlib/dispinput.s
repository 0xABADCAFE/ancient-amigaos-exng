#NO_APP
.text
LC0:
	.ascii "\0"
	.even
.globl _mapChar__11_NatDisplayPQ212AmigaOS3_68K12IntuiMessage
_mapChar__11_NatDisplayPQ212AmigaOS3_68K12IntuiMessage:
	link a5,#-44
	movel a2,sp@-
	movel a5@(8),a0
	tstl a0
	jeq L826
	movew a0@(24),d1
	movew d1,d0
	andw #127,d0
	cmpw #64,d0
	jls L825
L826:
	clrl d0
	jra L828
	.even
L825:
	clrl a5@(-44)
	clrl a5@(-40)
	clrl a5@(-36)
	clrl a5@(-32)
	clrl a5@(-28)
	clrw a5@(-24)
	lea a5@(-22),a2
	moveb #1,a5@(-40)
	movew d1,a5@(-38)
	movew a0@(26),a5@(-36)
	movel a5@(-44),a2@
	movel a5@(-40),a5@(-18)
	movel a5@(-36),a5@(-14)
	movel a5@(-32),a5@(-10)
	movel a5@(-28),a5@(-6)
	movew a5@(-24),a5@(-2)
	movel a0@(28),a0
	movel a0@,a5@(-12)
	moveb LC0,a5@(-44)
	pea 1:w
	pea a5@(-43)
	jbsr _bzero
	addqw #4,sp
	clrl sp@
	pea 2:w
	pea a5@(-44)
	movel a2,sp@-
	jbsr _MapRawKey
	clrl d0
	moveb a5@(-44),d0
L828:
	movel a5@(-48),a2
	unlk a5
	rts
	.even
.globl _applyFilter__11_NatDisplayUl
_applyFilter__11_NatDisplayUl:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel d2,sp@-
	movel a5@(8),a2
	movel a5@(12),d2
	movel a2@(6),a0
	tstl a0
	jeq L830
	bftst d2{#28:#4}
	sne d0
	moveb d0,d1
	extbl d1
	andl #1024,d1
	movel d2,d0
	andl #18288,d0
	jeq L832
	moveq #8,d0
	orl d0,d1
L832:
	movel d2,d0
	andl #24576,d0
	jeq L833
	moveq #16,d0
	orl d0,d1
L833:
	tstl d2
	jge L834
	orw #512,d1
L834:
	movel d1,sp@-
	movel a0,sp@-
	jbsr _ModifyIDCMP
	pea 4:w
	movel a2@(6),sp@-
	jbsr _SetMouseQueue
L830:
	movel a5@(-8),d2
	movel a5@(-4),a2
	unlk a5
	rts
	.even
.globl _waitEvent__11_NatDisplay
_waitEvent__11_NatDisplay:
	pea a5@
	movel sp,a5
	movel d2,sp@-
	movel a5@(8),a0
	movel a0@(6),a0
	movel a0@(86),a0
	clrl d0
	moveb a0@(15),d0
	moveq #1,d2
	lsll d0,d2
	movel d2,d0
	orw #4096,d0
	movel d0,sp@-
	jbsr _Wait
	andl d2,d0
	sne d0
	negb d0
	movel a5@(-4),d2
	unlk a5
	rts
	.even
.globl _handleEvent__11_NatDisplayP15InputDispatcher
_handleEvent__11_NatDisplayP15InputDispatcher:
	pea a5@
	movel sp,a5
	moveml #0x3830,sp@-
	movel a5@(8),a3
	movel a5@(12),d4
	movel a3@(6),a0
	movel a0@(86),sp@-
	jbsr _GetMsg
	movel d0,a2
	addql #4,sp
	tstl a2
	jeq L839
	movel a2@(20),d0
	moveq #16,d1
	cmpl d0,d1
	jeq L865
	jcs L871
	moveq #8,d1
	cmpl d0,d1
	jeq L847
	jra L840
	.even
L871:
	cmpl #512,d0
	jeq L867
	cmpl #1024,d0
	jne L840
	movel a2,sp@-
	jbsr _mapChar__11_NatDisplayPQ212AmigaOS3_68K12IntuiMessage
	movel d0,d1
	addql #4,sp
	jeq L842
	movew a2@(24),d0
	lsrw #7,d0
	eorb #1,d0
	andb #1,d0
	subql #2,sp
	moveb d0,sp@(1)
	subql #2,sp
	movel d1,sp@-
	movel d4,sp@-
	jbsr _dispatchKeyPrintable__15InputDispatcherlb
	addw #12,sp
	jra L840
	.even
L842:
	moveb a2@(25),d0
	moveq #127,d1
	andl d1,d0
	lea __9_NatInput$nonPrintMap,a0
	clrl d1
	moveb a0@(d0:l),d1
	movew a2@(24),d0
	lsrw #7,d0
	eorb #1,d0
	andb #1,d0
	subql #2,sp
	moveb d0,sp@(1)
	subql #2,sp
	movel d1,sp@-
	movel d4,sp@-
	jbsr _dispatchKey__15InputDispatcherQ23Key7CtrlKeyb
	addw #12,sp
	jra L840
	.even
L847:
	clrl d0
	movew a2@(24),d0
	moveq #106,d1
	cmpl d0,d1
	jeq L851
	jlt L863
	moveq #104,d1
	cmpl d0,d1
	jeq L849
	moveq #105,d1
	cmpl d0,d1
	jeq L853
	jra L840
	.even
L863:
	cmpl #233,d0
	jeq L859
	jgt L864
	cmpl #232,d0
	jeq L855
	jra L840
	.even
L864:
	cmpl #234,d0
	jeq L857
	jra L840
	.even
L849:
	subql #2,sp
	moveb #1,sp@(1)
	subql #2,sp
	pea 1:w
	jra L874
	.even
L851:
	subql #2,sp
	moveb #1,sp@(1)
	subql #2,sp
	pea 2:w
	jra L874
	.even
L853:
	subql #2,sp
	moveb #1,sp@(1)
	jra L875
	.even
L855:
	subql #2,sp
	moveb #0,sp@(1)
	subql #2,sp
	pea 1:w
	jra L874
	.even
L857:
	subql #2,sp
	moveb #0,sp@(1)
	subql #2,sp
	pea 2:w
	jra L874
	.even
L859:
	subql #2,sp
	moveb #0,sp@(1)
L875:
	subql #2,sp
	pea 4:w
L874:
	movel d4,sp@-
	jbsr _dispatchMouseKey__15InputDispatcherUlb
	addw #12,sp
	jra L840
	.even
L865:
	movel a3@(6),a0
	moveb a0@(54),d0
	extw d0
	movew a2@(32),d3
	subw d0,d3
	moveb a0@(55),d0
	extw d0
	movew a2@(34),d1
	subw d0,d1
	movew a3@(10),d2
	subqw #1,d2
	movew a3@(12),d0
	subqw #1,d0
	movew d0,a0
	movel a0,sp@-
	clrl sp@-
	movew d1,a0
	movel a0,sp@-
	movew d2,a0
	movel a0,sp@-
	clrl sp@-
	movew d3,a0
	movel a0,sp@-
	movel d4,sp@-
	jbsr _dispatchMove__15InputDispatcherssssss
	addw #28,sp
	jra L840
	.even
L867:
	movel d4,sp@-
	jbsr _dispatchExit__15InputDispatcher
	addql #4,sp
L840:
	movel a2,sp@-
	jbsr _ReplyMsg
	moveq #1,d0
	jra L873
	.even
L839:
	clrb d0
L873:
	moveml a5@(-20),#0xc1c
	unlk a5
	rts
	.even
.globl _discardQueue__11_NatDisplay
_discardQueue__11_NatDisplay:
	pea a5@
	movel sp,a5
	movel a3,sp@-
	movel a2,sp@-
	movel a5@(8),a3
	tstl a3@(6)
	jeq L882
	lea _GetMsg,a2
	jra L878
	.even
L880:
	movel d0,sp@-
	jbsr _ReplyMsg
	addql #4,sp
L878:
	movel a3@(6),a0
	movel a0@(86),sp@-
	jbsr a2@
	addql #4,sp
	tstl d0
	jne L880
L882:
	movel a5@(-8),a2
	movel a5@(-4),a3
	unlk a5
	rts
	.even
.globl _inputQueued__11_NatDisplay
_inputQueued__11_NatDisplay:
	pea a5@
	movel sp,a5
	clrb d0
	unlk a5
	rts
