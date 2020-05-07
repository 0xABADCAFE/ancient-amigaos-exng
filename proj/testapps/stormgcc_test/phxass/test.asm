

	XDEF _testAsmFunc
	
_testAsmFunc
	swap.l d0
	move.l d0, (a0)
	rts