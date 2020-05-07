#NO_APP
.text
	.even
.globl _convRGB15BE__5_Pix8PvT1PUlssss
_convRGB15BE__5_Pix8PvT1PUlssss:
	link a5,#-512
	moveml #0x3e3a,sp@-
	movel a5@(8),a2
	movel a5@(12),a3
	movew a5@(22),a4
	movew a5@(26),d3
	movew a5@(30),d4
	movew a5@(34),d5
	pea 256:w
	pea 256:w
	pea 1:w
	pea 256:w
	clrl sp@-
	movel a5@(16),sp@-
	movel a5,d2
	addl #-512,d2
	movel d2,sp@-
	jbsr copy32BETo15BE__Pix32__PvPvPUjssss
	subw a4,d4
	subw a4,d5
	movel d2,d6
	tstw d3
	jeq L826
	movew a4,d2
	extl d2
	extl d4
	movew d5,a6
	addl d4,d4
	.even
L827:
	movel d2,a1
	subqw #1,d3
	tstl a1
	jeq L829
	clrl d1
	movel d6,a4
	movel a1,d0
	negl d0
	moveq #3,d5
	andl d5,d0
	jeq L830
	cmpl d0,d5
	jle L835
	moveq #2,d5
	cmpl d0,d5
	jle L836
	movel a2,a0
	addql #2,a2
	addql #1,a3
	orb a3@(-1),d1
	movew a4@(d1:l:2),a0@
	subql #1,a1
L836:
	movel a2,a0
	addql #2,a2
	addql #1,a3
	moveb a3@(-1),d1
	movew a4@(d1:l:2),a0@
	subql #1,a1
L835:
	movel a2,a0
	addql #2,a2
	addql #1,a3
	moveb a3@(-1),d1
	movew a4@(d1:l:2),a0@
	subql #1,a1
	tstl a1
	jeq L829
	.even
L830:
	movel a3,a0
	moveb a0@+,d0
	moveb d0,d1
	movew a4@(d1:l:2),a2@
	moveb a0@,d1
	movew a4@(d1:l:2),a2@(2)
	lea a2@(6),a0
	moveb a3@(2),d1
	movew a4@(d1:l:2),a2@(4)
	addql #8,a2
	addql #4,a3
	moveb a3@(-1),d1
	movew a4@(d1:l:2),a0@
	subql #4,a1
	tstl a1
	jne L830
L829:
	addl d4,a2
	addl a6,a3
	tstw d3
	jne L827
L826:
	moveml a5@(-548),#0x5c7c
	unlk a5
	rts
	.even
.globl _convBGR15BE__5_Pix8PvT1PUlssss
_convBGR15BE__5_Pix8PvT1PUlssss:
	link a5,#-512
	moveml #0x3e3a,sp@-
	movel a5@(8),a2
	movel a5@(12),a3
	movew a5@(22),a4
	movew a5@(26),d3
	movew a5@(30),d4
	movew a5@(34),d5
	pea 256:w
	pea 256:w
	pea 1:w
	pea 256:w
	clrl sp@-
	movel a5@(16),sp@-
	movel a5,d2
	addl #-512,d2
	movel d2,sp@-
	jbsr rotate32BETo15BE__Pix32__PvPvPUjssss
	subw a4,d4
	subw a4,d5
	movel d2,d6
	tstw d3
	jeq L854
	movew a4,d2
	extl d2
	extl d4
	movew d5,a6
	addl d4,d4
	.even
L855:
	movel d2,a1
	subqw #1,d3
	tstl a1
	jeq L857
	clrl d1
	movel d6,a4
	movel a1,d0
	negl d0
	moveq #3,d5
	andl d5,d0
	jeq L858
	cmpl d0,d5
	jle L863
	moveq #2,d5
	cmpl d0,d5
	jle L864
	movel a2,a0
	addql #2,a2
	addql #1,a3
	orb a3@(-1),d1
	movew a4@(d1:l:2),a0@
	subql #1,a1
L864:
	movel a2,a0
	addql #2,a2
	addql #1,a3
	moveb a3@(-1),d1
	movew a4@(d1:l:2),a0@
	subql #1,a1
L863:
	movel a2,a0
	addql #2,a2
	addql #1,a3
	moveb a3@(-1),d1
	movew a4@(d1:l:2),a0@
	subql #1,a1
	tstl a1
	jeq L857
	.even
L858:
	movel a3,a0
	moveb a0@+,d0
	moveb d0,d1
	movew a4@(d1:l:2),a2@
	moveb a0@,d1
	movew a4@(d1:l:2),a2@(2)
	lea a2@(6),a0
	moveb a3@(2),d1
	movew a4@(d1:l:2),a2@(4)
	addql #8,a2
	addql #4,a3
	moveb a3@(-1),d1
	movew a4@(d1:l:2),a0@
	subql #4,a1
	tstl a1
	jne L858
L857:
	addl d4,a2
	addl a6,a3
	tstw d3
	jne L855
L854:
	moveml a5@(-548),#0x5c7c
	unlk a5
	rts
	.even
.globl _convRGB15LE__5_Pix8PvT1PUlssss
_convRGB15LE__5_Pix8PvT1PUlssss:
	link a5,#-512
	moveml #0x3e3a,sp@-
	movel a5@(8),a2
	movel a5@(12),a3
	movew a5@(22),a4
	movew a5@(26),d3
	movew a5@(30),d4
	movew a5@(34),d5
	pea 256:w
	pea 256:w
	pea 1:w
	pea 256:w
	clrl sp@-
	movel a5@(16),sp@-
	movel a5,d2
	addl #-512,d2
	movel d2,sp@-
	jbsr copy32BETo15LE__Pix32__PvPvPUjssss
	subw a4,d4
	subw a4,d5
	movel d2,d6
	tstw d3
	jeq L882
	movew a4,d2
	extl d2
	extl d4
	movew d5,a6
	addl d4,d4
	.even
L883:
	movel d2,a1
	subqw #1,d3
	tstl a1
	jeq L885
	clrl d1
	movel d6,a4
	movel a1,d0
	negl d0
	moveq #3,d5
	andl d5,d0
	jeq L886
	cmpl d0,d5
	jle L891
	moveq #2,d5
	cmpl d0,d5
	jle L892
	movel a2,a0
	addql #2,a2
	addql #1,a3
	orb a3@(-1),d1
	movew a4@(d1:l:2),a0@
	subql #1,a1
L892:
	movel a2,a0
	addql #2,a2
	addql #1,a3
	moveb a3@(-1),d1
	movew a4@(d1:l:2),a0@
	subql #1,a1
L891:
	movel a2,a0
	addql #2,a2
	addql #1,a3
	moveb a3@(-1),d1
	movew a4@(d1:l:2),a0@
	subql #1,a1
	tstl a1
	jeq L885
	.even
L886:
	movel a3,a0
	moveb a0@+,d0
	moveb d0,d1
	movew a4@(d1:l:2),a2@
	moveb a0@,d1
	movew a4@(d1:l:2),a2@(2)
	lea a2@(6),a0
	moveb a3@(2),d1
	movew a4@(d1:l:2),a2@(4)
	addql #8,a2
	addql #4,a3
	moveb a3@(-1),d1
	movew a4@(d1:l:2),a0@
	subql #4,a1
	tstl a1
	jne L886
L885:
	addl d4,a2
	addl a6,a3
	tstw d3
	jne L883
L882:
	moveml a5@(-548),#0x5c7c
	unlk a5
	rts
	.even
.globl _convBGR15LE__5_Pix8PvT1PUlssss
_convBGR15LE__5_Pix8PvT1PUlssss:
	link a5,#-512
	moveml #0x3e3a,sp@-
	movel a5@(8),a2
	movel a5@(12),a3
	movew a5@(22),a4
	movew a5@(26),d3
	movew a5@(30),d4
	movew a5@(34),d5
	pea 256:w
	pea 256:w
	pea 1:w
	pea 256:w
	clrl sp@-
	movel a5@(16),sp@-
	movel a5,d2
	addl #-512,d2
	movel d2,sp@-
	jbsr rotate32BETo15LE__Pix32__PvPvPUjssss
	subw a4,d4
	subw a4,d5
	movel d2,d6
	tstw d3
	jeq L910
	movew a4,d2
	extl d2
	extl d4
	movew d5,a6
	addl d4,d4
	.even
L911:
	movel d2,a1
	subqw #1,d3
	tstl a1
	jeq L913
	clrl d1
	movel d6,a4
	movel a1,d0
	negl d0
	moveq #3,d5
	andl d5,d0
	jeq L914
	cmpl d0,d5
	jle L919
	moveq #2,d5
	cmpl d0,d5
	jle L920
	movel a2,a0
	addql #2,a2
	addql #1,a3
	orb a3@(-1),d1
	movew a4@(d1:l:2),a0@
	subql #1,a1
L920:
	movel a2,a0
	addql #2,a2
	addql #1,a3
	moveb a3@(-1),d1
	movew a4@(d1:l:2),a0@
	subql #1,a1
L919:
	movel a2,a0
	addql #2,a2
	addql #1,a3
	moveb a3@(-1),d1
	movew a4@(d1:l:2),a0@
	subql #1,a1
	tstl a1
	jeq L913
	.even
L914:
	movel a3,a0
	moveb a0@+,d0
	moveb d0,d1
	movew a4@(d1:l:2),a2@
	moveb a0@,d1
	movew a4@(d1:l:2),a2@(2)
	lea a2@(6),a0
	moveb a3@(2),d1
	movew a4@(d1:l:2),a2@(4)
	addql #8,a2
	addql #4,a3
	moveb a3@(-1),d1
	movew a4@(d1:l:2),a0@
	subql #4,a1
	tstl a1
	jne L914
L913:
	addl d4,a2
	addl a6,a3
	tstw d3
	jne L911
L910:
	moveml a5@(-548),#0x5c7c
	unlk a5
	rts
	.even
.globl _convRGB16BE__5_Pix8PvT1PUlssss
_convRGB16BE__5_Pix8PvT1PUlssss:
	link a5,#-512
	moveml #0x3e3a,sp@-
	movel a5@(8),a2
	movel a5@(12),a3
	movew a5@(22),a4
	movew a5@(26),d3
	movew a5@(30),d4
	movew a5@(34),d5
	pea 256:w
	pea 256:w
	pea 1:w
	pea 256:w
	clrl sp@-
	movel a5@(16),sp@-
	movel a5,d2
	addl #-512,d2
	movel d2,sp@-
	jbsr copy32BETo16BE__Pix32__PvPvPUjssss
	subw a4,d4
	subw a4,d5
	movel d2,d6
	tstw d3
	jeq L938
	movew a4,d2
	extl d2
	extl d4
	movew d5,a6
	addl d4,d4
	.even
L939:
	movel d2,a1
	subqw #1,d3
	tstl a1
	jeq L941
	clrl d1
	movel d6,a4
	movel a1,d0
	negl d0
	moveq #3,d5
	andl d5,d0
	jeq L942
	cmpl d0,d5
	jle L947
	moveq #2,d5
	cmpl d0,d5
	jle L948
	movel a2,a0
	addql #2,a2
	addql #1,a3
	orb a3@(-1),d1
	movew a4@(d1:l:2),a0@
	subql #1,a1
L948:
	movel a2,a0
	addql #2,a2
	addql #1,a3
	moveb a3@(-1),d1
	movew a4@(d1:l:2),a0@
	subql #1,a1
L947:
	movel a2,a0
	addql #2,a2
	addql #1,a3
	moveb a3@(-1),d1
	movew a4@(d1:l:2),a0@
	subql #1,a1
	tstl a1
	jeq L941
	.even
L942:
	movel a3,a0
	moveb a0@+,d0
	moveb d0,d1
	movew a4@(d1:l:2),a2@
	moveb a0@,d1
	movew a4@(d1:l:2),a2@(2)
	lea a2@(6),a0
	moveb a3@(2),d1
	movew a4@(d1:l:2),a2@(4)
	addql #8,a2
	addql #4,a3
	moveb a3@(-1),d1
	movew a4@(d1:l:2),a0@
	subql #4,a1
	tstl a1
	jne L942
L941:
	addl d4,a2
	addl a6,a3
	tstw d3
	jne L939
L938:
	moveml a5@(-548),#0x5c7c
	unlk a5
	rts
	.even
.globl _convBGR16BE__5_Pix8PvT1PUlssss
_convBGR16BE__5_Pix8PvT1PUlssss:
	link a5,#-512
	moveml #0x3e3a,sp@-
	movel a5@(8),a2
	movel a5@(12),a3
	movew a5@(22),a4
	movew a5@(26),d3
	movew a5@(30),d4
	movew a5@(34),d5
	pea 256:w
	pea 256:w
	pea 1:w
	pea 256:w
	clrl sp@-
	movel a5@(16),sp@-
	movel a5,d2
	addl #-512,d2
	movel d2,sp@-
	jbsr rotate32BETo16BE__Pix32__PvPvPUjssss
	subw a4,d4
	subw a4,d5
	movel d2,d6
	tstw d3
	jeq L966
	movew a4,d2
	extl d2
	extl d4
	movew d5,a6
	addl d4,d4
	.even
L967:
	movel d2,a1
	subqw #1,d3
	tstl a1
	jeq L969
	clrl d1
	movel d6,a4
	movel a1,d0
	negl d0
	moveq #3,d5
	andl d5,d0
	jeq L970
	cmpl d0,d5
	jle L975
	moveq #2,d5
	cmpl d0,d5
	jle L976
	movel a2,a0
	addql #2,a2
	addql #1,a3
	orb a3@(-1),d1
	movew a4@(d1:l:2),a0@
	subql #1,a1
L976:
	movel a2,a0
	addql #2,a2
	addql #1,a3
	moveb a3@(-1),d1
	movew a4@(d1:l:2),a0@
	subql #1,a1
L975:
	movel a2,a0
	addql #2,a2
	addql #1,a3
	moveb a3@(-1),d1
	movew a4@(d1:l:2),a0@
	subql #1,a1
	tstl a1
	jeq L969
	.even
L970:
	movel a3,a0
	moveb a0@+,d0
	moveb d0,d1
	movew a4@(d1:l:2),a2@
	moveb a0@,d1
	movew a4@(d1:l:2),a2@(2)
	lea a2@(6),a0
	moveb a3@(2),d1
	movew a4@(d1:l:2),a2@(4)
	addql #8,a2
	addql #4,a3
	moveb a3@(-1),d1
	movew a4@(d1:l:2),a0@
	subql #4,a1
	tstl a1
	jne L970
L969:
	addl d4,a2
	addl a6,a3
	tstw d3
	jne L967
L966:
	moveml a5@(-548),#0x5c7c
	unlk a5
	rts
	.even
.globl _convRGB16LE__5_Pix8PvT1PUlssss
_convRGB16LE__5_Pix8PvT1PUlssss:
	link a5,#-512
	moveml #0x3e3a,sp@-
	movel a5@(8),a2
	movel a5@(12),a3
	movew a5@(22),a4
	movew a5@(26),d3
	movew a5@(30),d4
	movew a5@(34),d5
	pea 256:w
	pea 256:w
	pea 1:w
	pea 256:w
	clrl sp@-
	movel a5@(16),sp@-
	movel a5,d2
	addl #-512,d2
	movel d2,sp@-
	jbsr copy32BETo16LE__Pix32__PvPvPUjssss
	subw a4,d4
	subw a4,d5
	movel d2,d6
	tstw d3
	jeq L994
	movew a4,d2
	extl d2
	extl d4
	movew d5,a6
	addl d4,d4
	.even
L995:
	movel d2,a1
	subqw #1,d3
	tstl a1
	jeq L997
	clrl d1
	movel d6,a4
	movel a1,d0
	negl d0
	moveq #3,d5
	andl d5,d0
	jeq L998
	cmpl d0,d5
	jle L1003
	moveq #2,d5
	cmpl d0,d5
	jle L1004
	movel a2,a0
	addql #2,a2
	addql #1,a3
	orb a3@(-1),d1
	movew a4@(d1:l:2),a0@
	subql #1,a1
L1004:
	movel a2,a0
	addql #2,a2
	addql #1,a3
	moveb a3@(-1),d1
	movew a4@(d1:l:2),a0@
	subql #1,a1
L1003:
	movel a2,a0
	addql #2,a2
	addql #1,a3
	moveb a3@(-1),d1
	movew a4@(d1:l:2),a0@
	subql #1,a1
	tstl a1
	jeq L997
	.even
L998:
	movel a3,a0
	moveb a0@+,d0
	moveb d0,d1
	movew a4@(d1:l:2),a2@
	moveb a0@,d1
	movew a4@(d1:l:2),a2@(2)
	lea a2@(6),a0
	moveb a3@(2),d1
	movew a4@(d1:l:2),a2@(4)
	addql #8,a2
	addql #4,a3
	moveb a3@(-1),d1
	movew a4@(d1:l:2),a0@
	subql #4,a1
	tstl a1
	jne L998
L997:
	addl d4,a2
	addl a6,a3
	tstw d3
	jne L995
L994:
	moveml a5@(-548),#0x5c7c
	unlk a5
	rts
	.even
.globl _convBGR16LE__5_Pix8PvT1PUlssss
_convBGR16LE__5_Pix8PvT1PUlssss:
	link a5,#-512
	moveml #0x3e3a,sp@-
	movel a5@(8),a2
	movel a5@(12),a3
	movew a5@(22),a4
	movew a5@(26),d3
	movew a5@(30),d4
	movew a5@(34),d5
	pea 256:w
	pea 256:w
	pea 1:w
	pea 256:w
	clrl sp@-
	movel a5@(16),sp@-
	movel a5,d2
	addl #-512,d2
	movel d2,sp@-
	jbsr rotate32BETo16LE__Pix32__PvPvPUjssss
	subw a4,d4
	subw a4,d5
	movel d2,d6
	tstw d3
	jeq L1022
	movew a4,d2
	extl d2
	extl d4
	movew d5,a6
	addl d4,d4
	.even
L1023:
	movel d2,a1
	subqw #1,d3
	tstl a1
	jeq L1025
	clrl d1
	movel d6,a4
	movel a1,d0
	negl d0
	moveq #3,d5
	andl d5,d0
	jeq L1026
	cmpl d0,d5
	jle L1031
	moveq #2,d5
	cmpl d0,d5
	jle L1032
	movel a2,a0
	addql #2,a2
	addql #1,a3
	orb a3@(-1),d1
	movew a4@(d1:l:2),a0@
	subql #1,a1
L1032:
	movel a2,a0
	addql #2,a2
	addql #1,a3
	moveb a3@(-1),d1
	movew a4@(d1:l:2),a0@
	subql #1,a1
L1031:
	movel a2,a0
	addql #2,a2
	addql #1,a3
	moveb a3@(-1),d1
	movew a4@(d1:l:2),a0@
	subql #1,a1
	tstl a1
	jeq L1025
	.even
L1026:
	movel a3,a0
	moveb a0@+,d0
	moveb d0,d1
	movew a4@(d1:l:2),a2@
	moveb a0@,d1
	movew a4@(d1:l:2),a2@(2)
	lea a2@(6),a0
	moveb a3@(2),d1
	movew a4@(d1:l:2),a2@(4)
	addql #8,a2
	addql #4,a3
	moveb a3@(-1),d1
	movew a4@(d1:l:2),a0@
	subql #4,a1
	tstl a1
	jne L1026
L1025:
	addl d4,a2
	addl a6,a3
	tstw d3
	jne L1023
L1022:
	moveml a5@(-548),#0x5c7c
	unlk a5
	rts
	.even
.globl _convRGB24__5_Pix8PvT1PUlssss
_convRGB24__5_Pix8PvT1PUlssss:
	link a5,#-4
	moveml #0x3f3a,sp@-
	movel a5@(8),d5
	movel a5@(12),a2
	movel a5@(16),a3
	movew a5@(22),d1
	movew a5@(30),d2
	subw d1,d2
	movew a5@(34),d3
	subw d1,d3
	movew a5@(26),d0
	jeq L1050
	movew d1,a6
	movew d2,d6
	extl d6
	movew d3,a4
	clrl d3
	lsll #2,d6
	.even
L1051:
	movel a6,d4
	subqw #1,d0
	movew d0,a5@(-2)
	tstl d4
	jeq L1053
	clrl d2
	movel d5,a1
	subql #1,a1
	clrl d1
	movel d4,d0
	negl d0
	moveq #3,d7
	andl d7,d0
	jeq L1054
	cmpl d0,d7
	jle L1059
	moveq #2,d7
	cmpl d0,d7
	jle L1060
	movel d5,a1
	moveb a2@,d2
	moveb a3@(7,d2:l:4),a1@+
	moveb a2@,d3
	moveb a3@(11,d3:l:4),a1@+
	addql #3,d5
	moveb a2@+,d1
	moveb a3@(15,d1:l:4),a1@
	subql #1,d4
L1060:
	addql #1,a1
	moveb a2@,d2
	moveb a3@(7,d2:l:4),a1@+
	moveb a2@,d3
	moveb a3@(11,d3:l:4),a1@+
	addql #3,d5
	moveb a2@+,d1
	moveb a3@(15,d1:l:4),a1@
	subql #1,d4
L1059:
	addql #1,a1
	moveb a2@,d2
	moveb a3@(7,d2:l:4),a1@+
	moveb a2@,d3
	moveb a3@(11,d3:l:4),a1@+
	addql #3,d5
	moveb a2@+,d1
	moveb a3@(15,d1:l:4),a1@
	subql #1,d4
	jeq L1053
	.even
L1054:
	moveb a2@,d2
	moveb a3@(7,d2:l:4),a1@(1)
	moveb a2@,d3
	moveb a3@(11,d3:l:4),a1@(2)
	movel a2,a0
	moveb a0@+,d1
	moveb a3@(15,d1:l:4),a1@(3)
	moveb a0@,d2
	moveb a3@(7,d2:l:4),a1@(4)
	moveb a0@,d3
	moveb a3@(11,d3:l:4),a1@(5)
	moveb a0@,d1
	moveb a3@(15,d1:l:4),a1@(6)
	lea a2@(2),a0
	moveb a0@,d2
	moveb a3@(7,d2:l:4),a1@(7)
	moveb a0@,d3
	moveb a3@(11,d3:l:4),a1@(8)
	moveb a0@,d1
	moveb a3@(15,d1:l:4),a1@(9)
	lea a2@(3),a0
	moveb a0@,d2
	moveb a3@(7,d2:l:4),a1@(10)
	moveb a0@,d3
	moveb a3@(11,d3:l:4),a1@(11)
	addw #12,a1
	moveq #12,d0
	addl d0,d5
	moveb a0@,d1
	moveb a3@(15,d1:l:4),a1@
	addql #4,a2
	subql #4,d4
	jne L1054
L1053:
	addl d6,d5
	addl a4,a2
	movew a5@(-2),d0
	jne L1051
L1050:
	moveml sp@+,#0x5cfc
	unlk a5
	rts
	.even
.globl _convBGR24__5_Pix8PvT1PUlssss
_convBGR24__5_Pix8PvT1PUlssss:
	link a5,#-4
	moveml #0x3f3a,sp@-
	movel a5@(8),d5
	movel a5@(12),a2
	movel a5@(16),a3
	movew a5@(22),d1
	movew a5@(30),d2
	subw d1,d2
	movew a5@(34),d3
	subw d1,d3
	movew a5@(26),d0
	jeq L1078
	movew d1,a6
	movew d2,d6
	extl d6
	movew d3,a4
	clrl d3
	lsll #2,d6
	.even
L1079:
	movel a6,d4
	subqw #1,d0
	movew d0,a5@(-2)
	tstl d4
	jeq L1081
	clrl d2
	movel d5,a1
	subql #1,a1
	clrl d1
	movel d4,d0
	negl d0
	moveq #3,d7
	andl d7,d0
	jeq L1082
	cmpl d0,d7
	jle L1087
	moveq #2,d7
	cmpl d0,d7
	jle L1088
	movel d5,a1
	moveb a2@,d2
	moveb a3@(15,d2:l:4),a1@+
	moveb a2@,d3
	moveb a3@(11,d3:l:4),a1@+
	addql #3,d5
	moveb a2@+,d1
	moveb a3@(7,d1:l:4),a1@
	subql #1,d4
L1088:
	addql #1,a1
	moveb a2@,d2
	moveb a3@(15,d2:l:4),a1@+
	moveb a2@,d3
	moveb a3@(11,d3:l:4),a1@+
	addql #3,d5
	moveb a2@+,d1
	moveb a3@(7,d1:l:4),a1@
	subql #1,d4
L1087:
	addql #1,a1
	moveb a2@,d2
	moveb a3@(15,d2:l:4),a1@+
	moveb a2@,d3
	moveb a3@(11,d3:l:4),a1@+
	addql #3,d5
	moveb a2@+,d1
	moveb a3@(7,d1:l:4),a1@
	subql #1,d4
	jeq L1081
	.even
L1082:
	moveb a2@,d2
	moveb a3@(15,d2:l:4),a1@(1)
	moveb a2@,d3
	moveb a3@(11,d3:l:4),a1@(2)
	movel a2,a0
	moveb a0@+,d1
	moveb a3@(7,d1:l:4),a1@(3)
	moveb a0@,d2
	moveb a3@(15,d2:l:4),a1@(4)
	moveb a0@,d3
	moveb a3@(11,d3:l:4),a1@(5)
	moveb a0@,d1
	moveb a3@(7,d1:l:4),a1@(6)
	lea a2@(2),a0
	moveb a0@,d2
	moveb a3@(15,d2:l:4),a1@(7)
	moveb a0@,d3
	moveb a3@(11,d3:l:4),a1@(8)
	moveb a0@,d1
	moveb a3@(7,d1:l:4),a1@(9)
	lea a2@(3),a0
	moveb a0@,d2
	moveb a3@(15,d2:l:4),a1@(10)
	moveb a0@,d3
	moveb a3@(11,d3:l:4),a1@(11)
	addw #12,a1
	moveq #12,d0
	addl d0,d5
	moveb a0@,d1
	moveb a3@(7,d1:l:4),a1@
	addql #4,a2
	subql #4,d4
	jne L1082
L1081:
	addl d6,d5
	addl a4,a2
	movew a5@(-2),d0
	jne L1079
L1078:
	moveml sp@+,#0x5cfc
	unlk a5
	rts
	.even
.globl _convARGB32BE__5_Pix8PvT1PUlssss
_convARGB32BE__5_Pix8PvT1PUlssss:
	pea a5@
	movel sp,a5
	moveml #0x3c3a,sp@-
	movel a5@(8),a1
	movel a5@(12),a2
	movel a5@(16),a3
	movew a5@(22),d1
	movew a5@(30),d2
	subw d1,d2
	movew a5@(34),a0
	subw d1,a0
	movew a5@(26),d0
	jeq L1106
	movew d1,a6
	movew d2,d3
	extl d3
	movew a0,a4
	lsll #2,d3
	.even
L1107:
	movel a6,d2
	movew d0,d4
	subqw #1,d4
	tstl d2
	jeq L1109
	clrl d1
	movel d2,d0
	negl d0
	moveq #3,d5
	andl d5,d0
	jeq L1110
	cmpl d0,d5
	jle L1115
	moveq #2,d5
	cmpl d0,d5
	jle L1116
	movel a1,a0
	addql #4,a1
	addql #1,a2
	orb a2@(-1),d1
	movel a3@(d1:l:4),a0@
	subql #1,d2
L1116:
	movel a1,a0
	addql #4,a1
	addql #1,a2
	moveb a2@(-1),d1
	movel a3@(d1:l:4),a0@
	subql #1,d2
L1115:
	movel a1,a0
	addql #4,a1
	addql #1,a2
	moveb a2@(-1),d1
	movel a3@(d1:l:4),a0@
	subql #1,d2
	jeq L1109
	.even
L1110:
	movel a2,a0
	moveb a0@+,d0
	moveb d0,d1
	movel a3@(d1:l:4),a1@
	moveb a0@,d1
	movel a3@(d1:l:4),a1@(4)
	lea a1@(12),a0
	moveb a2@(2),d1
	movel a3@(d1:l:4),a1@(8)
	addw #16,a1
	addql #4,a2
	moveb a2@(-1),d1
	movel a3@(d1:l:4),a0@
	subql #4,d2
	jne L1110
L1109:
	addl d3,a1
	addl a4,a2
	movew d4,d0
	jne L1107
L1106:
	moveml sp@+,#0x5c3c
	unlk a5
	rts
	.even
.globl _convABGR32BE__5_Pix8PvT1PUlssss
_convABGR32BE__5_Pix8PvT1PUlssss:
	link a5,#-1024
	moveml #0x3e3a,sp@-
	movel a5@(8),a2
	movel a5@(12),a3
	movew a5@(22),a4
	movew a5@(26),d3
	movew a5@(30),d4
	movew a5@(34),d5
	pea 256:w
	pea 256:w
	pea 1:w
	pea 256:w
	clrl sp@-
	movel a5@(16),sp@-
	movel a5,d2
	addl #-1024,d2
	movel d2,sp@-
	jbsr rotate32BETo32BE__Pix32__PvPvPUjssss
	subw a4,d4
	subw a4,d5
	movel d2,d6
	tstw d3
	jeq L1134
	movew a4,d2
	extl d2
	extl d4
	movew d5,a6
	lsll #2,d4
	.even
L1135:
	movel d2,a1
	subqw #1,d3
	tstl a1
	jeq L1137
	clrl d1
	movel d6,a4
	movel a1,d0
	negl d0
	moveq #3,d5
	andl d5,d0
	jeq L1138
	cmpl d0,d5
	jle L1143
	moveq #2,d5
	cmpl d0,d5
	jle L1144
	movel a2,a0
	addql #4,a2
	addql #1,a3
	orb a3@(-1),d1
	movel a4@(d1:l:4),a0@
	subql #1,a1
L1144:
	movel a2,a0
	addql #4,a2
	addql #1,a3
	moveb a3@(-1),d1
	movel a4@(d1:l:4),a0@
	subql #1,a1
L1143:
	movel a2,a0
	addql #4,a2
	addql #1,a3
	moveb a3@(-1),d1
	movel a4@(d1:l:4),a0@
	subql #1,a1
	tstl a1
	jeq L1137
	.even
L1138:
	movel a3,a0
	moveb a0@+,d0
	moveb d0,d1
	movel a4@(d1:l:4),a2@
	moveb a0@,d1
	movel a4@(d1:l:4),a2@(4)
	lea a2@(12),a0
	moveb a3@(2),d1
	movel a4@(d1:l:4),a2@(8)
	addw #16,a2
	addql #4,a3
	moveb a3@(-1),d1
	movel a4@(d1:l:4),a0@
	subql #4,a1
	tstl a1
	jne L1138
L1137:
	addl d4,a2
	addl a6,a3
	tstw d3
	jne L1135
L1134:
	moveml a5@(-1060),#0x5c7c
	unlk a5
	rts
	.even
.globl _convARGB32LE__5_Pix8PvT1PUlssss
_convARGB32LE__5_Pix8PvT1PUlssss:
	link a5,#-1024
	moveml #0x3e3a,sp@-
	movel a5@(8),a2
	movel a5@(12),a3
	movew a5@(22),a4
	movew a5@(26),d3
	movew a5@(30),d4
	movew a5@(34),d5
	pea 256:w
	movel a5@(16),sp@-
	movel a5,d2
	addl #-1024,d2
	movel d2,sp@-
	jbsr _swap32__3MemPvPCvUl
	subw a4,d4
	subw a4,d5
	movel d2,d6
	tstw d3
	jeq L1162
	movew a4,d2
	extl d2
	extl d4
	movew d5,a6
	lsll #2,d4
	.even
L1163:
	movel d2,a1
	subqw #1,d3
	tstl a1
	jeq L1165
	clrl d1
	movel d6,a4
	movel a1,d0
	negl d0
	moveq #3,d5
	andl d5,d0
	jeq L1166
	cmpl d0,d5
	jle L1171
	moveq #2,d5
	cmpl d0,d5
	jle L1172
	movel a2,a0
	addql #4,a2
	addql #1,a3
	orb a3@(-1),d1
	movel a4@(d1:l:4),a0@
	subql #1,a1
L1172:
	movel a2,a0
	addql #4,a2
	addql #1,a3
	moveb a3@(-1),d1
	movel a4@(d1:l:4),a0@
	subql #1,a1
L1171:
	movel a2,a0
	addql #4,a2
	addql #1,a3
	moveb a3@(-1),d1
	movel a4@(d1:l:4),a0@
	subql #1,a1
	tstl a1
	jeq L1165
	.even
L1166:
	movel a3,a0
	moveb a0@+,d0
	moveb d0,d1
	movel a4@(d1:l:4),a2@
	moveb a0@,d1
	movel a4@(d1:l:4),a2@(4)
	lea a2@(12),a0
	moveb a3@(2),d1
	movel a4@(d1:l:4),a2@(8)
	addw #16,a2
	addql #4,a3
	moveb a3@(-1),d1
	movel a4@(d1:l:4),a0@
	subql #4,a1
	tstl a1
	jne L1166
L1165:
	addl d4,a2
	addl a6,a3
	tstw d3
	jne L1163
L1162:
	moveml a5@(-1060),#0x5c7c
	unlk a5
	rts
	.even
.globl _convABGR32LE__5_Pix8PvT1PUlssss
_convABGR32LE__5_Pix8PvT1PUlssss:
	link a5,#-1024
	moveml #0x3e3a,sp@-
	movel a5@(8),a2
	movel a5@(12),a3
	movew a5@(22),a4
	movew a5@(26),d3
	movew a5@(30),d4
	movew a5@(34),d5
	pea 256:w
	pea 256:w
	pea 1:w
	pea 256:w
	clrl sp@-
	movel a5@(16),sp@-
	movel a5,d2
	addl #-1024,d2
	movel d2,sp@-
	jbsr rotate32BETo32LE__Pix32__PvPvPUjssss
	subw a4,d4
	subw a4,d5
	movel d2,d6
	tstw d3
	jeq L1190
	movew a4,d2
	extl d2
	extl d4
	movew d5,a6
	lsll #2,d4
	.even
L1191:
	movel d2,a1
	subqw #1,d3
	tstl a1
	jeq L1193
	clrl d1
	movel d6,a4
	movel a1,d0
	negl d0
	moveq #3,d5
	andl d5,d0
	jeq L1194
	cmpl d0,d5
	jle L1199
	moveq #2,d5
	cmpl d0,d5
	jle L1200
	movel a2,a0
	addql #4,a2
	addql #1,a3
	orb a3@(-1),d1
	movel a4@(d1:l:4),a0@
	subql #1,a1
L1200:
	movel a2,a0
	addql #4,a2
	addql #1,a3
	moveb a3@(-1),d1
	movel a4@(d1:l:4),a0@
	subql #1,a1
L1199:
	movel a2,a0
	addql #4,a2
	addql #1,a3
	moveb a3@(-1),d1
	movel a4@(d1:l:4),a0@
	subql #1,a1
	tstl a1
	jeq L1193
	.even
L1194:
	movel a3,a0
	moveb a0@+,d0
	moveb d0,d1
	movel a4@(d1:l:4),a2@
	moveb a0@,d1
	movel a4@(d1:l:4),a2@(4)
	lea a2@(12),a0
	moveb a3@(2),d1
	movel a4@(d1:l:4),a2@(8)
	addw #16,a2
	addql #4,a3
	moveb a3@(-1),d1
	movel a4@(d1:l:4),a0@
	subql #4,a1
	tstl a1
	jne L1194
L1193:
	addl d4,a2
	addl a6,a3
	tstw d3
	jne L1191
L1190:
	moveml a5@(-1060),#0x5c7c
	unlk a5
	rts
