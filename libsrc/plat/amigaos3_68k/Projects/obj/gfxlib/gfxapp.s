#NO_APP
.text
	.even
.globl _open__17InteractiveWindowssQ25Pixel5DepthPCc
_open__17InteractiveWindowssQ25Pixel5DepthPCc:
	pea a5@
	movel sp,a5
	moveml #0x3020,sp@-
	movel a5@(8),a2
	movel a5@(24),sp@-
	movel a5@(20),sp@-
	movew a5@(18),a0
	movel a0,sp@-
	movew a5@(14),a0
	movel a0,sp@-
	moveq #32,d3
	addl a2,d3
	movel d3,sp@-
	jbsr _open__7_NatWinssQ25Pixel5DepthPCc
	movel d0,d2
	addw #20,sp
	jne L1603
	movel a2@(4),sp@-
	movel d3,sp@-
	jbsr _applyFilter__11_NatDisplayUl
L1603:
	movel d2,d0
	moveml a5@(-12),#0x40c
	unlk a5
	rts
	.even
.globl _open__17InteractiveWindowPC17DisplayPropertiesPCc
_open__17InteractiveWindowPC17DisplayPropertiesPCc:
	pea a5@
	movel sp,a5
	moveml #0x3020,sp@-
	movel a5@(8),a2
	movel a5@(16),sp@-
	movel a5@(12),sp@-
	moveq #32,d3
	addl a2,d3
	movel d3,sp@-
	jbsr _open__7_NatWinPC17DisplayPropertiesPCc
	movel d0,d2
	addw #12,sp
	jne L1608
	movel a2@(4),sp@-
	movel d3,sp@-
	jbsr _applyFilter__11_NatDisplayUl
L1608:
	movel d2,d0
	moveml a5@(-12),#0x40c
	unlk a5
	rts
	.even
.globl _reopen__17InteractiveWindow
_reopen__17InteractiveWindow:
	pea a5@
	movel sp,a5
	moveml #0x3020,sp@-
	movel a5@(8),a2
	moveq #32,d3
	addl a2,d3
	movel d3,sp@-
	jbsr _reopen__7_NatWin
	movel d0,d2
	addql #4,sp
	jne L1613
	movel a2@(4),sp@-
	movel d3,sp@-
	jbsr _applyFilter__11_NatDisplayUl
L1613:
	movel d2,d0
	moveml a5@(-12),#0x40c
	unlk a5
	rts
	.even
.globl _close__17InteractiveWindow
_close__17InteractiveWindow:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel d2,sp@-
	movel a5@(8),a2
	moveq #32,d2
	addl a2,d2
	movel d2,sp@-
	jbsr _discardQueue__11_NatDisplay
	addql #4,sp
	addql #4,a2
	clrl sp@-
	movel a2,sp@-
	jbsr _setIFilter__7IFilterUl
	movel a2@(24),a0
	movel a2,sp@-
	movel a0@(12),a0
	jbsr a0@
	addqw #8,sp
	movel d2,sp@
	jbsr _close__7_NatWin
	movel a5@(-8),d2
	movel a5@(-4),a2
	unlk a5
	rts
	.even
.globl _open__17InteractiveScreenssQ25Pixel5DepthPCc
_open__17InteractiveScreenssQ25Pixel5DepthPCc:
	pea a5@
	movel sp,a5
	moveml #0x3020,sp@-
	movel a5@(8),a2
	movel a5@(24),sp@-
	movel a5@(20),sp@-
	movew a5@(18),a0
	movel a0,sp@-
	movew a5@(14),a0
	movel a0,sp@-
	moveq #32,d3
	addl a2,d3
	movel d3,sp@-
	jbsr _open__7_NatScrssQ25Pixel5DepthPCc
	movel d0,d2
	addw #20,sp
	jne L1621
	movel a2@(4),sp@-
	movel d3,sp@-
	jbsr _applyFilter__11_NatDisplayUl
L1621:
	movel d2,d0
	moveml a5@(-12),#0x40c
	unlk a5
	rts
	.even
.globl _open__17InteractiveScreenPC17DisplayPropertiesPCc
_open__17InteractiveScreenPC17DisplayPropertiesPCc:
	pea a5@
	movel sp,a5
	moveml #0x3020,sp@-
	movel a5@(8),a2
	movel a5@(16),sp@-
	movel a5@(12),sp@-
	moveq #32,d3
	addl a2,d3
	movel d3,sp@-
	jbsr _open__7_NatScrPC17DisplayPropertiesPCc
	movel d0,d2
	addw #12,sp
	jne L1626
	movel a2@(4),sp@-
	movel d3,sp@-
	jbsr _applyFilter__11_NatDisplayUl
L1626:
	movel d2,d0
	moveml a5@(-12),#0x40c
	unlk a5
	rts
	.even
.globl _reopen__17InteractiveScreen
_reopen__17InteractiveScreen:
	pea a5@
	movel sp,a5
	moveml #0x3020,sp@-
	movel a5@(8),a2
	moveq #32,d3
	addl a2,d3
	movel d3,sp@-
	jbsr _reopen__7_NatScr
	movel d0,d2
	addql #4,sp
	jne L1631
	movel a2@(4),sp@-
	movel d3,sp@-
	jbsr _applyFilter__11_NatDisplayUl
L1631:
	movel d2,d0
	moveml a5@(-12),#0x40c
	unlk a5
	rts
	.even
.globl _close__17InteractiveScreen
_close__17InteractiveScreen:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel d2,sp@-
	movel a5@(8),a2
	moveq #32,d2
	addl a2,d2
	movel d2,sp@-
	jbsr _discardQueue__11_NatDisplay
	addql #4,sp
	addql #4,a2
	clrl sp@-
	movel a2,sp@-
	jbsr _setIFilter__7IFilterUl
	movel a2@(24),a0
	movel a2,sp@-
	movel a0@(12),a0
	jbsr a0@
	addqw #8,sp
	movel d2,sp@
	jbsr _close__7_NatScr
	movel a5@(-8),d2
	movel a5@(-4),a2
	unlk a5
	rts
	.even
.globl _open__25InteractiveScreenBufferedssQ25Pixel5DepthPCc
_open__25InteractiveScreenBufferedssQ25Pixel5DepthPCc:
	pea a5@
	movel sp,a5
	moveml #0x3020,sp@-
	movel a5@(8),a2
	movel a5@(24),sp@-
	movel a5@(20),sp@-
	movew a5@(18),a0
	movel a0,sp@-
	movew a5@(14),a0
	movel a0,sp@-
	moveq #32,d3
	addl a2,d3
	movel d3,sp@-
	jbsr _open__11_NatScrBuffssQ25Pixel5DepthPCc
	movel d0,d2
	addw #20,sp
	jne L1639
	movel a2@(4),sp@-
	movel d3,sp@-
	jbsr _applyFilter__11_NatDisplayUl
L1639:
	movel d2,d0
	moveml a5@(-12),#0x40c
	unlk a5
	rts
	.even
.globl _open__25InteractiveScreenBufferedPC17DisplayPropertiesPCc
_open__25InteractiveScreenBufferedPC17DisplayPropertiesPCc:
	pea a5@
	movel sp,a5
	moveml #0x3020,sp@-
	movel a5@(8),a2
	movel a5@(16),sp@-
	movel a5@(12),sp@-
	moveq #32,d3
	addl a2,d3
	movel d3,sp@-
	jbsr _open__11_NatScrBuffPC17DisplayPropertiesPCc
	movel d0,d2
	addw #12,sp
	jne L1644
	movel a2@(4),sp@-
	movel d3,sp@-
	jbsr _applyFilter__11_NatDisplayUl
L1644:
	movel d2,d0
	moveml a5@(-12),#0x40c
	unlk a5
	rts
	.even
.globl _reopen__25InteractiveScreenBuffered
_reopen__25InteractiveScreenBuffered:
	pea a5@
	movel sp,a5
	moveml #0x3020,sp@-
	movel a5@(8),a2
	moveq #32,d3
	addl a2,d3
	movel d3,sp@-
	jbsr _reopen__11_NatScrBuff
	movel d0,d2
	addql #4,sp
	jne L1649
	movel a2@(4),sp@-
	movel d3,sp@-
	jbsr _applyFilter__11_NatDisplayUl
L1649:
	movel d2,d0
	moveml a5@(-12),#0x40c
	unlk a5
	rts
	.even
.globl _close__25InteractiveScreenBuffered
_close__25InteractiveScreenBuffered:
	pea a5@
	movel sp,a5
	movel a3,sp@-
	movel a2,sp@-
	movel a5@(8),a3
	movel a3@(28),a0
	lea a3@(4),a2
	movel a2,sp@-
	movel a0@(8),a0
	jbsr a0@
	clrl sp@
	movel a2,sp@-
	jbsr _setIFilter__7IFilterUl
	movel a2@(24),a0
	movel a2,sp@-
	movel a0@(12),a0
	jbsr a0@
	addw #12,sp
	pea a3@(32)
	jbsr _close__11_NatScrBuff
	movel a5@(-8),a2
	movel a5@(-4),a3
	unlk a5
	rts
	.even
___thunk_4_discardQueue__25InteractiveScreenBuffered:
	pea a5@
	movel sp,a5
	moveq #28,d0
	addl a5@(8),d0
	movel d0,sp@-
	jbsr _discardQueue__11_NatDisplay
	unlk a5
	rts
	.even
___thunk_4_applyFilter__25InteractiveScreenBuffered:
	pea a5@
	movel sp,a5
	movel a5@(8),a0
	movel a0@,sp@-
	pea a0@(28)
	jbsr _applyFilter__11_NatDisplayUl
	unlk a5
	rts
	.even
___thunk_4_waitEvent__25InteractiveScreenBuffered:
	pea a5@
	movel sp,a5
	moveq #28,d0
	addl a5@(8),d0
	movel d0,sp@-
	jbsr _waitEvent__11_NatDisplay
	unlk a5
	rts
	.even
___thunk_4_handleEvent__25InteractiveScreenBuffered:
	pea a5@
	movel sp,a5
	movel a5@(8),a0
	movel a0,sp@-
	pea a0@(28)
	jbsr _handleEvent__11_NatDisplayP15InputDispatcher
	unlk a5
	rts
	.even
___thunk_4_inputQueued__25InteractiveScreenBuffered:
	pea a5@
	movel sp,a5
	moveq #28,d0
	addl a5@(8),d0
	movel d0,sp@-
	jbsr _inputQueued__11_NatDisplay
	unlk a5
	rts
	.even
___thunk_4__$_25InteractiveScreenBuffered:
	pea a5@
	movel sp,a5
	moveml #0x2030,sp@-
	movel a5@(8),a2
	movel a5@(12),d2
	lea a2@(-4),a3
	movel #___vt_25InteractiveScreenBuffered$15InputDispatcher,a3@(28)
	movel #___vt_25InteractiveScreenBuffered,a3@
	movel a3,sp@-
	jbsr _close__25InteractiveScreenBuffered
	clrl sp@
	pea a2@(28)
	jbsr __$_11_NatScrBuff
	addql #8,sp
	movel #___vt_18InteractiveDisplay$15InputDispatcher,a3@(28)
	movel #___vt_18InteractiveDisplay,a3@
	movel #___vt_15InputDispatcher,a2@(24)
	pea 2:w
	pea a2@(4)
	jbsr __$_7_LLBase
	addql #8,sp
	movel #___vt_7Display,a3@
	btst #0,d2
	jeq L1672
	movel a3,sp@-
	jbsr ___builtin_delete
L1672:
	moveml a5@(-12),#0xc04
	unlk a5
	rts
.globl ___vt_25InteractiveScreenBuffered$15InputDispatcher
	.even
___vt_25InteractiveScreenBuffered$15InputDispatcher:
	.long -4
	.long 0
	.long ___thunk_4_discardQueue__25InteractiveScreenBuffered
	.long ___thunk_4_applyFilter__25InteractiveScreenBuffered
	.long ___thunk_4_waitEvent__25InteractiveScreenBuffered
	.long ___thunk_4_handleEvent__25InteractiveScreenBuffered
	.long ___thunk_4_inputQueued__25InteractiveScreenBuffered
	.long ___thunk_4__$_25InteractiveScreenBuffered
	.skip 4
.globl ___vt_25InteractiveScreenBuffered
	.even
___vt_25InteractiveScreenBuffered:
	.long 0
	.long 0
	.long _open__25InteractiveScreenBufferedssQ25Pixel5DepthPCc
	.long _open__25InteractiveScreenBufferedPC17DisplayPropertiesPCc
	.long _reopen__25InteractiveScreenBuffered
	.long _close__25InteractiveScreenBuffered
	.long _waitSync__25InteractiveScreenBuffered
	.long _refresh__25InteractiveScreenBuffered
	.long _refresh__25InteractiveScreenBufferedssss
	.long _setTitle__25InteractiveScreenBufferedPCc
	.long _getDrawSurface__25InteractiveScreenBuffered
	.long _getProperties__25InteractiveScreenBuffered
	.long __$_25InteractiveScreenBuffered
	.skip 4
	.even
___thunk_4_discardQueue__17InteractiveScreen:
	pea a5@
	movel sp,a5
	moveq #28,d0
	addl a5@(8),d0
	movel d0,sp@-
	jbsr _discardQueue__11_NatDisplay
	unlk a5
	rts
	.even
___thunk_4_applyFilter__17InteractiveScreen:
	pea a5@
	movel sp,a5
	movel a5@(8),a0
	movel a0@,sp@-
	pea a0@(28)
	jbsr _applyFilter__11_NatDisplayUl
	unlk a5
	rts
	.even
___thunk_4_waitEvent__17InteractiveScreen:
	pea a5@
	movel sp,a5
	moveq #28,d0
	addl a5@(8),d0
	movel d0,sp@-
	jbsr _waitEvent__11_NatDisplay
	unlk a5
	rts
	.even
___thunk_4_handleEvent__17InteractiveScreen:
	pea a5@
	movel sp,a5
	movel a5@(8),a0
	movel a0,sp@-
	pea a0@(28)
	jbsr _handleEvent__11_NatDisplayP15InputDispatcher
	unlk a5
	rts
	.even
___thunk_4_inputQueued__17InteractiveScreen:
	pea a5@
	movel sp,a5
	moveq #28,d0
	addl a5@(8),d0
	movel d0,sp@-
	jbsr _inputQueued__11_NatDisplay
	unlk a5
	rts
	.even
___thunk_4__$_17InteractiveScreen:
	pea a5@
	movel sp,a5
	moveml #0x2030,sp@-
	movel a5@(8),a2
	movel a5@(12),d2
	lea a2@(-4),a3
	movel #___vt_17InteractiveScreen$15InputDispatcher,a3@(28)
	movel #___vt_17InteractiveScreen,a3@
	movel a3,sp@-
	jbsr _close__17InteractiveScreen
	clrl sp@
	pea a2@(28)
	jbsr __$_7_NatScr
	addql #8,sp
	movel #___vt_18InteractiveDisplay$15InputDispatcher,a3@(28)
	movel #___vt_18InteractiveDisplay,a3@
	movel #___vt_15InputDispatcher,a2@(24)
	pea 2:w
	pea a2@(4)
	jbsr __$_7_LLBase
	addql #8,sp
	movel #___vt_7Display,a3@
	btst #0,d2
	jeq L1704
	movel a3,sp@-
	jbsr ___builtin_delete
L1704:
	moveml a5@(-12),#0xc04
	unlk a5
	rts
.globl ___vt_17InteractiveScreen$15InputDispatcher
	.even
___vt_17InteractiveScreen$15InputDispatcher:
	.long -4
	.long 0
	.long ___thunk_4_discardQueue__17InteractiveScreen
	.long ___thunk_4_applyFilter__17InteractiveScreen
	.long ___thunk_4_waitEvent__17InteractiveScreen
	.long ___thunk_4_handleEvent__17InteractiveScreen
	.long ___thunk_4_inputQueued__17InteractiveScreen
	.long ___thunk_4__$_17InteractiveScreen
	.skip 4
.globl ___vt_17InteractiveScreen
	.even
___vt_17InteractiveScreen:
	.long 0
	.long 0
	.long _open__17InteractiveScreenssQ25Pixel5DepthPCc
	.long _open__17InteractiveScreenPC17DisplayPropertiesPCc
	.long _reopen__17InteractiveScreen
	.long _close__17InteractiveScreen
	.long _waitSync__17InteractiveScreen
	.long _refresh__17InteractiveScreen
	.long _refresh__17InteractiveScreenssss
	.long _setTitle__17InteractiveScreenPCc
	.long _getDrawSurface__17InteractiveScreen
	.long _getProperties__17InteractiveScreen
	.long __$_17InteractiveScreen
	.skip 4
	.even
___thunk_4_discardQueue__17InteractiveWindow:
	pea a5@
	movel sp,a5
	moveq #28,d0
	addl a5@(8),d0
	movel d0,sp@-
	jbsr _discardQueue__11_NatDisplay
	unlk a5
	rts
	.even
___thunk_4_applyFilter__17InteractiveWindow:
	pea a5@
	movel sp,a5
	movel a5@(8),a0
	movel a0@,sp@-
	pea a0@(28)
	jbsr _applyFilter__11_NatDisplayUl
	unlk a5
	rts
	.even
___thunk_4_waitEvent__17InteractiveWindow:
	pea a5@
	movel sp,a5
	moveq #28,d0
	addl a5@(8),d0
	movel d0,sp@-
	jbsr _waitEvent__11_NatDisplay
	unlk a5
	rts
	.even
___thunk_4_handleEvent__17InteractiveWindow:
	pea a5@
	movel sp,a5
	movel a5@(8),a0
	movel a0,sp@-
	pea a0@(28)
	jbsr _handleEvent__11_NatDisplayP15InputDispatcher
	unlk a5
	rts
	.even
___thunk_4_inputQueued__17InteractiveWindow:
	pea a5@
	movel sp,a5
	moveq #28,d0
	addl a5@(8),d0
	movel d0,sp@-
	jbsr _inputQueued__11_NatDisplay
	unlk a5
	rts
	.even
___thunk_4__$_17InteractiveWindow:
	pea a5@
	movel sp,a5
	moveml #0x2030,sp@-
	movel a5@(8),a2
	movel a5@(12),d2
	lea a2@(-4),a3
	movel #___vt_17InteractiveWindow$15InputDispatcher,a3@(28)
	movel #___vt_17InteractiveWindow,a3@
	movel a3,sp@-
	jbsr _close__17InteractiveWindow
	clrl sp@
	pea a2@(28)
	jbsr __$_7_NatWin
	addql #8,sp
	movel #___vt_18InteractiveDisplay$15InputDispatcher,a3@(28)
	movel #___vt_18InteractiveDisplay,a3@
	movel #___vt_15InputDispatcher,a2@(24)
	pea 2:w
	pea a2@(4)
	jbsr __$_7_LLBase
	addql #8,sp
	movel #___vt_7Display,a3@
	btst #0,d2
	jeq L1736
	movel a3,sp@-
	jbsr ___builtin_delete
L1736:
	moveml a5@(-12),#0xc04
	unlk a5
	rts
.globl ___vt_17InteractiveWindow$15InputDispatcher
	.even
___vt_17InteractiveWindow$15InputDispatcher:
	.long -4
	.long 0
	.long ___thunk_4_discardQueue__17InteractiveWindow
	.long ___thunk_4_applyFilter__17InteractiveWindow
	.long ___thunk_4_waitEvent__17InteractiveWindow
	.long ___thunk_4_handleEvent__17InteractiveWindow
	.long ___thunk_4_inputQueued__17InteractiveWindow
	.long ___thunk_4__$_17InteractiveWindow
	.skip 4
.globl ___vt_17InteractiveWindow
	.even
___vt_17InteractiveWindow:
	.long 0
	.long 0
	.long _open__17InteractiveWindowssQ25Pixel5DepthPCc
	.long _open__17InteractiveWindowPC17DisplayPropertiesPCc
	.long _reopen__17InteractiveWindow
	.long _close__17InteractiveWindow
	.long _waitSync__17InteractiveWindow
	.long _refresh__17InteractiveWindow
	.long _refresh__17InteractiveWindowssss
	.long _setTitle__17InteractiveWindowPCc
	.long _getDrawSurface__17InteractiveWindow
	.long _getProperties__17InteractiveWindow
	.long __$_17InteractiveWindow
	.skip 4
	.even
___thunk_4__$_18InteractiveDisplay:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel d2,sp@-
	movel a5@(8),a0
	movel a5@(12),d2
	lea a0@(-4),a2
	movel #___vt_18InteractiveDisplay$15InputDispatcher,a2@(28)
	movel #___vt_18InteractiveDisplay,a2@
	movel #___vt_15InputDispatcher,a0@(24)
	pea 2:w
	pea a0@(4)
	jbsr __$_7_LLBase
	addql #8,sp
	movel #___vt_7Display,a2@
	btst #0,d2
	jeq L1751
	movel a2,sp@-
	jbsr ___builtin_delete
L1751:
	movel a5@(-8),d2
	movel a5@(-4),a2
	unlk a5
	rts
	.even
___vt_18InteractiveDisplay$15InputDispatcher:
	.long -4
	.long 0
	.long ___pure_virtual
	.long ___pure_virtual
	.long ___pure_virtual
	.long ___pure_virtual
	.long ___pure_virtual
	.long ___thunk_4__$_18InteractiveDisplay
	.skip 4
	.even
___vt_18InteractiveDisplay:
	.long 0
	.long 0
	.long ___pure_virtual
	.long ___pure_virtual
	.long ___pure_virtual
	.long ___pure_virtual
	.long ___pure_virtual
	.long ___pure_virtual
	.long ___pure_virtual
	.long ___pure_virtual
	.long ___pure_virtual
	.long ___pure_virtual
	.long __$_18InteractiveDisplay
	.skip 4
	.even
___vt_15InputDispatcher:
	.long 0
	.long 0
	.long ___pure_virtual
	.long ___pure_virtual
	.long ___pure_virtual
	.long ___pure_virtual
	.long ___pure_virtual
	.long __$_15InputDispatcher
	.skip 4
	.even
___vt_7Display:
	.long 0
	.long 0
	.long ___pure_virtual
	.long ___pure_virtual
	.long ___pure_virtual
	.long ___pure_virtual
	.long ___pure_virtual
	.long ___pure_virtual
	.long ___pure_virtual
	.long ___pure_virtual
	.long ___pure_virtual
	.long ___pure_virtual
	.long __$_7Display
	.skip 4
	.even
__$_7Display:
	pea a5@
	movel sp,a5
	movel a5@(8),a0
	movel #___vt_7Display,a0@
	btst #0,a5@(15)
	jeq L206
	movel a0,sp@-
	jbsr ___builtin_delete
L206:
	unlk a5
	rts
	.even
__$_15InputDispatcher:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel d2,sp@-
	movel a5@(8),a2
	movel a5@(12),d2
	movel #___vt_15InputDispatcher,a2@(24)
	pea 2:w
	pea a2@(4)
	jbsr __$_7_LLBase
	addql #8,sp
	btst #0,d2
	jeq L499
	movel a2,sp@-
	jbsr ___builtin_delete
L499:
	movel a5@(-8),d2
	movel a5@(-4),a2
	unlk a5
	rts
	.even
__$_18InteractiveDisplay:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel d2,sp@-
	movel a5@(8),a2
	movel a5@(12),d2
	movel #___vt_18InteractiveDisplay$15InputDispatcher,a2@(28)
	movel a2,a0
	movel #___vt_18InteractiveDisplay,a0@+
	movel #___vt_15InputDispatcher,a0@(24)
	pea 2:w
	pea a0@(4)
	jbsr __$_7_LLBase
	addql #8,sp
	movel #___vt_7Display,a2@
	btst #0,d2
	jeq L945
	movel a2,sp@-
	jbsr ___builtin_delete
L945:
	movel a5@(-8),d2
	movel a5@(-4),a2
	unlk a5
	rts
	.even
.globl _waitSync__17InteractiveWindow
_waitSync__17InteractiveWindow:
	pea a5@
	movel sp,a5
	moveq #32,d0
	addl a5@(8),d0
	movel d0,sp@-
	jbsr _waitForRefresh__11_NatDisplay
	unlk a5
	rts
	.even
.globl _refresh__17InteractiveWindow
_refresh__17InteractiveWindow:
	pea a5@
	movel sp,a5
	moveq #32,d0
	addl a5@(8),d0
	movel d0,sp@-
	jbsr _refresh__7_NatWin
	unlk a5
	rts
	.even
.globl _refresh__17InteractiveWindowssss
_refresh__17InteractiveWindowssss:
	pea a5@
	movel sp,a5
	movew a5@(26),a0
	movel a0,sp@-
	movew a5@(22),a0
	movel a0,sp@-
	movew a5@(18),a0
	movel a0,sp@-
	movew a5@(14),a0
	movel a0,sp@-
	moveq #32,d0
	addl a5@(8),d0
	movel d0,sp@-
	jbsr _refresh__7_NatWinssss
	unlk a5
	rts
	.even
.globl _setTitle__17InteractiveWindowPCc
_setTitle__17InteractiveWindowPCc:
	pea a5@
	movel sp,a5
	subql #2,sp
	moveb #0,sp@(1)
	subql #2,sp
	movel a5@(12),sp@-
	moveq #32,d0
	addl a5@(8),d0
	movel d0,sp@-
	jbsr _setDisplayTitle__11_NatDisplayPCcb
	unlk a5
	rts
	.even
.globl _getDrawSurface__17InteractiveWindow
_getDrawSurface__17InteractiveWindow:
	pea a5@
	movel sp,a5
	movel a5@(8),a1
	lea a1@(32),a0
	movel a0@(278),d0
	unlk a5
	rts
	.even
.globl _getProperties__17InteractiveWindow
_getProperties__17InteractiveWindow:
	pea a5@
	movel sp,a5
	clrl d0
	unlk a5
	rts
	.even
.globl _applyFilter__17InteractiveWindow
_applyFilter__17InteractiveWindow:
	pea a5@
	movel sp,a5
	movel a5@(8),a0
	movel a0@(4),sp@-
	pea a0@(32)
	jbsr _applyFilter__11_NatDisplayUl
	unlk a5
	rts
	.even
.globl _discardQueue__17InteractiveWindow
_discardQueue__17InteractiveWindow:
	pea a5@
	movel sp,a5
	moveq #32,d0
	addl a5@(8),d0
	movel d0,sp@-
	jbsr _discardQueue__11_NatDisplay
	unlk a5
	rts
	.even
.globl _waitEvent__17InteractiveWindow
_waitEvent__17InteractiveWindow:
	pea a5@
	movel sp,a5
	moveq #32,d0
	addl a5@(8),d0
	movel d0,sp@-
	jbsr _waitEvent__11_NatDisplay
	unlk a5
	rts
	.even
.globl _handleEvent__17InteractiveWindow
_handleEvent__17InteractiveWindow:
	pea a5@
	movel sp,a5
	movel a5@(8),a0
	pea a0@(4)
	pea a0@(32)
	jbsr _handleEvent__11_NatDisplayP15InputDispatcher
	unlk a5
	rts
	.even
.globl _inputQueued__17InteractiveWindow
_inputQueued__17InteractiveWindow:
	pea a5@
	movel sp,a5
	moveq #32,d0
	addl a5@(8),d0
	movel d0,sp@-
	jbsr _inputQueued__11_NatDisplay
	unlk a5
	rts
	.even
.globl _getWinX__17InteractiveWindow
_getWinX__17InteractiveWindow:
	pea a5@
	movel sp,a5
	movel a5@(8),a1
	lea a1@(32),a0
	movel a0@(6),a0
	movew a0@(4),d0
	extl d0
	unlk a5
	rts
	.even
.globl _getWinY__17InteractiveWindow
_getWinY__17InteractiveWindow:
	pea a5@
	movel sp,a5
	movel a5@(8),a1
	lea a1@(32),a0
	movel a0@(6),a0
	movew a0@(6),d0
	extl d0
	unlk a5
	rts
	.even
.globl _getWinW__17InteractiveWindow
_getWinW__17InteractiveWindow:
	pea a5@
	movel sp,a5
	movel a5@(8),a1
	lea a1@(32),a0
	movel a0@(6),a0
	movew a0@(8),d0
	extl d0
	unlk a5
	rts
	.even
.globl _getWinH__17InteractiveWindow
_getWinH__17InteractiveWindow:
	pea a5@
	movel sp,a5
	movel a5@(8),a1
	lea a1@(32),a0
	movel a0@(6),a0
	movew a0@(10),d0
	extl d0
	unlk a5
	rts
	.even
.globl _getWinBL__17InteractiveWindow
_getWinBL__17InteractiveWindow:
	pea a5@
	movel sp,a5
	movel a5@(8),a1
	lea a1@(32),a0
	movel a0@(6),a0
	moveb a0@(54),d0
	extbl d0
	unlk a5
	rts
	.even
.globl _getWinBR__17InteractiveWindow
_getWinBR__17InteractiveWindow:
	pea a5@
	movel sp,a5
	movel a5@(8),a1
	lea a1@(32),a0
	movel a0@(6),a0
	moveb a0@(56),d0
	extbl d0
	unlk a5
	rts
	.even
.globl _getWinBT__17InteractiveWindow
_getWinBT__17InteractiveWindow:
	pea a5@
	movel sp,a5
	movel a5@(8),a1
	lea a1@(32),a0
	movel a0@(6),a0
	moveb a0@(55),d0
	extbl d0
	unlk a5
	rts
	.even
.globl _getWinBB__17InteractiveWindow
_getWinBB__17InteractiveWindow:
	pea a5@
	movel sp,a5
	movel a5@(8),a1
	lea a1@(32),a0
	movel a0@(6),a0
	moveb a0@(57),d0
	extbl d0
	unlk a5
	rts
	.even
.globl _getViewX__17InteractiveWindow
_getViewX__17InteractiveWindow:
	pea a5@
	movel sp,a5
	movel a5@(8),a1
	lea a1@(32),a0
	movel a0@(6),a0
	moveb a0@(54),d0
	extbl d0
	addw a0@(4),d0
	extl d0
	unlk a5
	rts
	.even
.globl _getViewY__17InteractiveWindow
_getViewY__17InteractiveWindow:
	pea a5@
	movel sp,a5
	movel a5@(8),a1
	lea a1@(32),a0
	movel a0@(6),a0
	moveb a0@(55),d0
	extbl d0
	addw a0@(6),d0
	extl d0
	unlk a5
	rts
	.even
.globl _getViewW__17InteractiveWindow
_getViewW__17InteractiveWindow:
	pea a5@
	movel sp,a5
	movel a5@(8),a1
	lea a1@(32),a0
	movel a0@(6),a0
	moveb a0@(54),d0
	extbl d0
	moveb a0@(56),d1
	extbl d1
	movew a0@(8),a0
	subw d0,a0
	movew a0,d0
	subw d1,d0
	extl d0
	unlk a5
	rts
	.even
.globl _getViewH__17InteractiveWindow
_getViewH__17InteractiveWindow:
	pea a5@
	movel sp,a5
	movel a5@(8),a1
	lea a1@(32),a0
	movel a0@(6),a0
	moveb a0@(55),d0
	extbl d0
	moveb a0@(57),d1
	extbl d1
	movew a0@(10),a0
	subw d0,a0
	movew a0,d0
	subw d1,d0
	extl d0
	unlk a5
	rts
	.even
.globl _setBorderless__17InteractiveWindowb
_setBorderless__17InteractiveWindowb:
	pea a5@
	movel sp,a5
	subql #2,sp
	moveb a5@(15),sp@(1)
	subql #2,sp
	moveq #32,d0
	addl a5@(8),d0
	movel d0,sp@-
	jbsr _setBorderless__7_NatWinb
	unlk a5
	rts
	.even
.globl _setMoveable__17InteractiveWindowb
_setMoveable__17InteractiveWindowb:
	pea a5@
	movel sp,a5
	subql #2,sp
	moveb a5@(15),sp@(1)
	subql #2,sp
	moveq #32,d0
	addl a5@(8),d0
	movel d0,sp@-
	jbsr _setMoveable__7_NatWinb
	unlk a5
	rts
	.even
.globl _setResizeable__17InteractiveWindowb
_setResizeable__17InteractiveWindowb:
	pea a5@
	movel sp,a5
	subql #2,sp
	moveb a5@(15),sp@(1)
	subql #2,sp
	moveq #32,d0
	addl a5@(8),d0
	movel d0,sp@-
	jbsr _setResizeable__7_NatWinb
	unlk a5
	rts
	.even
.globl _setCloseable__17InteractiveWindowb
_setCloseable__17InteractiveWindowb:
	pea a5@
	movel sp,a5
	subql #2,sp
	moveb a5@(15),sp@(1)
	subql #2,sp
	moveq #32,d0
	addl a5@(8),d0
	movel d0,sp@-
	jbsr _setCloseable__7_NatWinb
	unlk a5
	rts
	.even
.globl _getBorderless__17InteractiveWindow
_getBorderless__17InteractiveWindow:
	pea a5@
	movel sp,a5
	movel a5@(8),a1
	lea a1@(32),a0
	bfextu a0@(285){#2:#1},d0
	unlk a5
	rts
	.even
.globl _getMoveable__17InteractiveWindow
_getMoveable__17InteractiveWindow:
	pea a5@
	movel sp,a5
	movel a5@(8),a1
	lea a1@(32),a0
	bfextu a0@(285){#4:#1},d0
	unlk a5
	rts
	.even
.globl _getResizeable__17InteractiveWindow
_getResizeable__17InteractiveWindow:
	pea a5@
	movel sp,a5
	movel a5@(8),a1
	lea a1@(32),a0
	bfextu a0@(285){#3:#1},d0
	unlk a5
	rts
	.even
.globl _getCloseable__17InteractiveWindow
_getCloseable__17InteractiveWindow:
	pea a5@
	movel sp,a5
	movel a5@(8),a1
	lea a1@(32),a0
	bfextu a0@(285){#5:#1},d0
	unlk a5
	rts
	.even
.globl ___17InteractiveWindowUl
___17InteractiveWindowUl:
	link a5,#-304
	fmovem #0xfc,sp@-
	moveml #0x3f3a,sp@-
	jbsr ___get_eh_context
	movel d0,a5@(-300)
	movel d0,a5@(-292)
	movel a5@(8),a0
	movel #___vt_7Display,a0@
	movel a5@(-300),a0
	addql #4,a0
	movel a0@,a5@(-24)
	clrl a5@(-20)
	movel a5,a5@(-16)
	movel #L1019,a5@(-12)
	movel sp,a5@(-8)
L1019:
	lea a5@(-24),a1
	movel a1,a0@
	movel a5@(8),a2
	addql #4,a2
	movel a2,a5@(-296)
	movel a5@(-300),d0
	movel a5@(12),a2@
	movel #___vt_15InputDispatcher,a2@(24)
	movel a5@(-300),d0
	pea a2@(4)
	jbsr ___7_LLBase
	movel a5@(-292),a0
	addql #4,a0
	movel a0@,a5@(-48)
	clrl a5@(-44)
	lea a5@(-24),a1
	movel a1,a5@(-40)
	movel #L1024,a5@(-36)
	movel sp,a5@(-32)
	movel a0,a2
L1024:
	lea a5@(-48),a1
	movel a1,a0@
	addql #4,sp
	movel a5@(-292),a1
	addql #4,a1
	movel a1@,a0
	movel a0@,a1@
	movel a2@,a5@(-96)
	clrl a5@(-92)
	lea a5@(-24),a0
	movel a0,a5@(-88)
	movel #L1033,a5@(-84)
	movel sp,a5@(-80)
L1033:
	lea a5@(-96),a1
	movel a1,a2@
	movel a5@(-296),a0
	clrl a0@(20)
	movel a2@,a0
	movel a0@,a2@
	movel a5@(-300),a0
	addql #4,a0
	movel a0@,a5@(-144)
	clrl a5@(-140)
	movel a5,a5@(-136)
	movel #L1046,a5@(-132)
	movel sp,a5@(-128)
	movel a0,a1
L1046:
	lea a5@(-144),a2
	movel a2,a0@
	movel a5@(8),a0
	movel #___vt_18InteractiveDisplay$15InputDispatcher,a0@(28)
	movel #___vt_18InteractiveDisplay,a0@
	movel a1@,a0
	movel a0@,a1@
	movel a1@,a0
	movel a0@,a1@
	jra L1048
	.even
L1017:
	movel a5@(-300),a0
	addql #4,a0
	movel a0@,a5@(-192)
	clrl a5@(-188)
	movel a5,a5@(-184)
	movel #L1061,a5@(-180)
	movel sp,a5@(-176)
L1061:
	lea a5@(-192),a1
	movel a1,a0@
	movel a5@(8),a2
	movel #___vt_7Display,a2@
	movel a5@(-300),a1
	addql #4,a1
	movel a1@,a0
	movel a0@,a1@
	jbsr ___sjthrow
	.even
L1048:
	movel a5@(-300),a1
	addql #4,a1
	movel a1@,a5@(-216)
	clrl a5@(-212)
	lea a5@(-208),a0
	movel a5,a0@
	movel #L1068,a0@(4)
	movel sp,a0@(8)
	movel a1,a5@(-304)
L1068:
	lea a5@(-216),a0
	movel a0,a1@
	movel a5@(8),a1
	pea a1@(32)
	jbsr ___7_NatWin
	movel a5@(-304),a2
	movel a2@,a5@(-240)
	clrl a5@(-236)
	lea a5@(-232),a0
	movel a5,a0@
	movel #L1072,a0@(4)
	movel sp,a0@(8)
L1072:
	lea a5@(-240),a1
	movel a5@(-304),a0
	movel a1,a0@
	movel a5@(8),a2
	movel #___vt_17InteractiveWindow$15InputDispatcher,a2@(28)
	movel #___vt_17InteractiveWindow,a2@
	movel a0@,a0
	movel a5@(-304),a1
	movel a0@,a1@
	movel a1@,a0
	movel a0@,a1@
	movel a2,d0
	jra L1764
	.even
L1066:
	movel a5@(-304),a2
	movel a2@,a5@(-288)
	clrl a5@(-284)
	lea a5@(-280),a0
	movel a5,a0@
	movel #L1081,a0@(4)
	movel sp,a0@(8)
L1081:
	lea a5@(-288),a1
	movel a5@(-304),a0
	movel a1,a0@
	movel a5@(8),a2
	movel #___vt_18InteractiveDisplay$15InputDispatcher,a2@(28)
	movel a2,a0
	movel #___vt_18InteractiveDisplay,a0@+
	movel #___vt_15InputDispatcher,a0@(24)
	pea 2:w
	pea a0@(4)
	jbsr __$_7_LLBase
	addql #8,sp
	movel #___vt_7Display,a2@
	movel a5@(-300),a1
	addql #4,a1
	movel a1@,a0
	movel a0@,a1@
	jbsr ___sjthrow
	.even
L1079:
	jbsr ___terminate
	.even
L1764:
	moveml a5@(-416),#0x5cfc
	fmovem a5@(-376),#0x3f
	unlk a5
	rts
	.even
.globl ___17InteractiveWindowUlPCc
___17InteractiveWindowUlPCc:
	link a5,#-312
	fmovem #0xfc,sp@-
	moveml #0x3f3a,sp@-
	jbsr ___get_eh_context
	movel d0,a5@(-304)
	movel d0,a5@(-292)
	movel a5@(8),a0
	movel #___vt_7Display,a0@
	movel a5@(-304),a0
	addql #4,a0
	movel a0@,a5@(-24)
	clrl a5@(-20)
	movel a5,a5@(-16)
	movel #L1101,a5@(-12)
	movel sp,a5@(-8)
L1101:
	lea a5@(-24),a1
	movel a1,a0@
	movel a5@(8),a2
	addql #4,a2
	movel a2,a5@(-296)
	movel a5@(-304),d0
	movel a5@(12),a2@
	movel #___vt_15InputDispatcher,a2@(24)
	movel a5@(-304),d0
	pea a2@(4)
	jbsr ___7_LLBase
	movel a5@(-292),a0
	addql #4,a0
	movel a0@,a5@(-48)
	clrl a5@(-44)
	lea a5@(-24),a1
	movel a1,a5@(-40)
	movel #L1106,a5@(-36)
	movel sp,a5@(-32)
	movel a0,a5@(-312)
L1106:
	lea a5@(-48),a2
	movel a2,a0@
	addql #4,sp
	movel a5@(-292),a1
	addql #4,a1
	movel a1@,a0
	movel a0@,a1@
	movel a5@(-312),a0
	movel a0@,a5@(-96)
	clrl a5@(-92)
	lea a5@(-24),a1
	movel a1,a5@(-88)
	movel #L1115,a5@(-84)
	movel sp,a5@(-80)
L1115:
	lea a5@(-96),a0
	movel a5@(-312),a2
	movel a0,a2@
	movew #20,a1
	addl a5@(-296),a1
	movel a1,a5@(-300)
	movel a5@(16),sp@-
	movel a1,sp@-
	jbsr _getValue__C5Key32PCc
	movel a5@(-300),a2
	movel d0,a2@
	addql #8,sp
	movel a5@(-312),a1
	movel a1@,a0
	movel a0@,a1@
	jra L1119
	.even
L1113:
	movel a5@(-312),a2
	movel a2@,a5@(-120)
	clrl a5@(-116)
	lea a5@(-24),a0
	movel a0,a5@(-112)
	movel #L1122,a5@(-108)
	movel sp,a5@(-104)
L1122:
	lea a5@(-120),a2
	movel a5@(-312),a1
	movel a2,a1@
	clrl sp@-
	movel a5@(-296),a0
	pea a0@(4)
	jbsr __$_7_LLBase
	addql #8,sp
	movel a5@(-292),a1
	addql #4,a1
	movel a1@,a0
	movel a0@,a1@
	jbsr ___sjthrow
	.even
L1120:
	jbsr ___terminate
	.even
L1119:
	movel a5@(-304),a0
	addql #4,a0
	movel a0@,a5@(-144)
	clrl a5@(-140)
	movel a5,a5@(-136)
	movel #L1128,a5@(-132)
	movel sp,a5@(-128)
	movel a0,a1
L1128:
	lea a5@(-144),a2
	movel a2,a0@
	movel a5@(8),a0
	movel #___vt_18InteractiveDisplay$15InputDispatcher,a0@(28)
	movel #___vt_18InteractiveDisplay,a0@
	movel a1@,a0
	movel a0@,a1@
	movel a1@,a0
	movel a0@,a1@
	jra L1130
	.even
L1099:
	movel a5@(-304),a0
	addql #4,a0
	movel a0@,a5@(-192)
	clrl a5@(-188)
	movel a5,a5@(-184)
	movel #L1143,a5@(-180)
	movel sp,a5@(-176)
L1143:
	lea a5@(-192),a1
	movel a1,a0@
	movel a5@(8),a2
	movel #___vt_7Display,a2@
	movel a5@(-304),a1
	addql #4,a1
	movel a1@,a0
	movel a0@,a1@
	jbsr ___sjthrow
	.even
L1130:
	movel a5@(-304),a1
	addql #4,a1
	movel a1@,a5@(-216)
	clrl a5@(-212)
	lea a5@(-208),a0
	movel a5,a0@
	movel #L1150,a0@(4)
	movel sp,a0@(8)
	movel a1,a5@(-308)
L1150:
	lea a5@(-216),a0
	movel a0,a1@
	movel a5@(8),a1
	pea a1@(32)
	jbsr ___7_NatWin
	movel a5@(-308),a2
	movel a2@,a5@(-240)
	clrl a5@(-236)
	lea a5@(-232),a0
	movel a5,a0@
	movel #L1154,a0@(4)
	movel sp,a0@(8)
L1154:
	lea a5@(-240),a1
	movel a5@(-308),a0
	movel a1,a0@
	movel a5@(8),a2
	movel #___vt_17InteractiveWindow$15InputDispatcher,a2@(28)
	movel #___vt_17InteractiveWindow,a2@
	movel a0@,a0
	movel a5@(-308),a1
	movel a0@,a1@
	movel a1@,a0
	movel a0@,a1@
	movel a2,d0
	jra L1765
	.even
L1148:
	movel a5@(-308),a2
	movel a2@,a5@(-288)
	clrl a5@(-284)
	lea a5@(-280),a0
	movel a5,a0@
	movel #L1163,a0@(4)
	movel sp,a0@(8)
L1163:
	lea a5@(-288),a1
	movel a5@(-308),a0
	movel a1,a0@
	movel a5@(8),a2
	movel #___vt_18InteractiveDisplay$15InputDispatcher,a2@(28)
	movel a2,a0
	movel #___vt_18InteractiveDisplay,a0@+
	movel #___vt_15InputDispatcher,a0@(24)
	pea 2:w
	pea a0@(4)
	jbsr __$_7_LLBase
	addql #8,sp
	movel #___vt_7Display,a2@
	movel a5@(-304),a1
	addql #4,a1
	movel a1@,a0
	movel a0@,a1@
	jbsr ___sjthrow
	.even
L1161:
	jbsr ___terminate
	.even
L1765:
	moveml a5@(-424),#0x5cfc
	fmovem a5@(-384),#0x3f
	unlk a5
	rts
	.even
.globl __$_17InteractiveWindow
__$_17InteractiveWindow:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel d2,sp@-
	movel a5@(8),a2
	movel a5@(12),d2
	movel #___vt_17InteractiveWindow$15InputDispatcher,a2@(28)
	movel #___vt_17InteractiveWindow,a2@
	movel a2,sp@-
	jbsr _close__17InteractiveWindow
	clrl sp@
	pea a2@(32)
	jbsr __$_7_NatWin
	addql #8,sp
	movel #___vt_18InteractiveDisplay$15InputDispatcher,a2@(28)
	movel a2,a0
	movel #___vt_18InteractiveDisplay,a0@+
	movel #___vt_15InputDispatcher,a0@(24)
	pea 2:w
	pea a0@(4)
	jbsr __$_7_LLBase
	addql #8,sp
	movel #___vt_7Display,a2@
	btst #0,d2
	jeq L1191
	movel a2,sp@-
	jbsr ___builtin_delete
L1191:
	movel a5@(-8),d2
	movel a5@(-4),a2
	unlk a5
	rts
	.even
.globl _waitSync__17InteractiveScreen
_waitSync__17InteractiveScreen:
	pea a5@
	movel sp,a5
	moveq #32,d0
	addl a5@(8),d0
	movel d0,sp@-
	jbsr _waitForRefresh__11_NatDisplay
	unlk a5
	rts
	.even
.globl _refresh__17InteractiveScreen
_refresh__17InteractiveScreen:
	pea a5@
	movel sp,a5
	unlk a5
	rts
	.even
.globl _refresh__17InteractiveScreenssss
_refresh__17InteractiveScreenssss:
	pea a5@
	movel sp,a5
	unlk a5
	rts
	.even
.globl _setTitle__17InteractiveScreenPCc
_setTitle__17InteractiveScreenPCc:
	pea a5@
	movel sp,a5
	subql #2,sp
	moveb #1,sp@(1)
	subql #2,sp
	movel a5@(12),sp@-
	moveq #32,d0
	addl a5@(8),d0
	movel d0,sp@-
	jbsr _setDisplayTitle__11_NatDisplayPCcb
	unlk a5
	rts
	.even
.globl _getDrawSurface__17InteractiveScreen
_getDrawSurface__17InteractiveScreen:
	pea a5@
	movel sp,a5
	movel a5@(8),a1
	lea a1@(32),a0
	movel a0@(278),d0
	unlk a5
	rts
	.even
.globl _getProperties__17InteractiveScreen
_getProperties__17InteractiveScreen:
	pea a5@
	movel sp,a5
	movel a5@(8),a1
	lea a1@(32),a0
	movel a0@(282),d0
	unlk a5
	rts
	.even
.globl _applyFilter__17InteractiveScreen
_applyFilter__17InteractiveScreen:
	pea a5@
	movel sp,a5
	movel a5@(8),a0
	movel a0@(4),sp@-
	pea a0@(32)
	jbsr _applyFilter__11_NatDisplayUl
	unlk a5
	rts
	.even
.globl _discardQueue__17InteractiveScreen
_discardQueue__17InteractiveScreen:
	pea a5@
	movel sp,a5
	moveq #32,d0
	addl a5@(8),d0
	movel d0,sp@-
	jbsr _discardQueue__11_NatDisplay
	unlk a5
	rts
	.even
.globl _waitEvent__17InteractiveScreen
_waitEvent__17InteractiveScreen:
	pea a5@
	movel sp,a5
	moveq #32,d0
	addl a5@(8),d0
	movel d0,sp@-
	jbsr _waitEvent__11_NatDisplay
	unlk a5
	rts
	.even
.globl _handleEvent__17InteractiveScreen
_handleEvent__17InteractiveScreen:
	pea a5@
	movel sp,a5
	movel a5@(8),a0
	pea a0@(4)
	pea a0@(32)
	jbsr _handleEvent__11_NatDisplayP15InputDispatcher
	unlk a5
	rts
	.even
.globl _inputQueued__17InteractiveScreen
_inputQueued__17InteractiveScreen:
	pea a5@
	movel sp,a5
	moveq #32,d0
	addl a5@(8),d0
	movel d0,sp@-
	jbsr _inputQueued__11_NatDisplay
	unlk a5
	rts
	.even
.globl ___17InteractiveScreenUl
___17InteractiveScreenUl:
	link a5,#-304
	fmovem #0xfc,sp@-
	moveml #0x3f3a,sp@-
	jbsr ___get_eh_context
	movel d0,a5@(-300)
	movel d0,a5@(-292)
	movel a5@(8),a0
	movel #___vt_7Display,a0@
	movel a5@(-300),a0
	addql #4,a0
	movel a0@,a5@(-24)
	clrl a5@(-20)
	movel a5,a5@(-16)
	movel #L1221,a5@(-12)
	movel sp,a5@(-8)
L1221:
	lea a5@(-24),a1
	movel a1,a0@
	movel a5@(8),a2
	addql #4,a2
	movel a2,a5@(-296)
	movel a5@(-300),d0
	movel a5@(12),a2@
	movel #___vt_15InputDispatcher,a2@(24)
	movel a5@(-300),d0
	pea a2@(4)
	jbsr ___7_LLBase
	movel a5@(-292),a0
	addql #4,a0
	movel a0@,a5@(-48)
	clrl a5@(-44)
	lea a5@(-24),a1
	movel a1,a5@(-40)
	movel #L1226,a5@(-36)
	movel sp,a5@(-32)
	movel a0,a2
L1226:
	lea a5@(-48),a1
	movel a1,a0@
	addql #4,sp
	movel a5@(-292),a1
	addql #4,a1
	movel a1@,a0
	movel a0@,a1@
	movel a2@,a5@(-96)
	clrl a5@(-92)
	lea a5@(-24),a0
	movel a0,a5@(-88)
	movel #L1235,a5@(-84)
	movel sp,a5@(-80)
L1235:
	lea a5@(-96),a1
	movel a1,a2@
	movel a5@(-296),a0
	clrl a0@(20)
	movel a2@,a0
	movel a0@,a2@
	movel a5@(-300),a0
	addql #4,a0
	movel a0@,a5@(-144)
	clrl a5@(-140)
	movel a5,a5@(-136)
	movel #L1248,a5@(-132)
	movel sp,a5@(-128)
	movel a0,a1
L1248:
	lea a5@(-144),a2
	movel a2,a0@
	movel a5@(8),a0
	movel #___vt_18InteractiveDisplay$15InputDispatcher,a0@(28)
	movel #___vt_18InteractiveDisplay,a0@
	movel a1@,a0
	movel a0@,a1@
	movel a1@,a0
	movel a0@,a1@
	jra L1250
	.even
L1219:
	movel a5@(-300),a0
	addql #4,a0
	movel a0@,a5@(-192)
	clrl a5@(-188)
	movel a5,a5@(-184)
	movel #L1263,a5@(-180)
	movel sp,a5@(-176)
L1263:
	lea a5@(-192),a1
	movel a1,a0@
	movel a5@(8),a2
	movel #___vt_7Display,a2@
	movel a5@(-300),a1
	addql #4,a1
	movel a1@,a0
	movel a0@,a1@
	jbsr ___sjthrow
	.even
L1250:
	movel a5@(-300),a1
	addql #4,a1
	movel a1@,a5@(-216)
	clrl a5@(-212)
	lea a5@(-208),a0
	movel a5,a0@
	movel #L1270,a0@(4)
	movel sp,a0@(8)
	movel a1,a5@(-304)
L1270:
	lea a5@(-216),a0
	movel a0,a1@
	movel a5@(8),a1
	pea a1@(32)
	jbsr ___7_NatScr
	movel a5@(-304),a2
	movel a2@,a5@(-240)
	clrl a5@(-236)
	lea a5@(-232),a0
	movel a5,a0@
	movel #L1274,a0@(4)
	movel sp,a0@(8)
L1274:
	lea a5@(-240),a1
	movel a5@(-304),a0
	movel a1,a0@
	movel a5@(8),a2
	movel #___vt_17InteractiveScreen$15InputDispatcher,a2@(28)
	movel #___vt_17InteractiveScreen,a2@
	movel a0@,a0
	movel a5@(-304),a1
	movel a0@,a1@
	movel a1@,a0
	movel a0@,a1@
	movel a2,d0
	jra L1766
	.even
L1268:
	movel a5@(-304),a2
	movel a2@,a5@(-288)
	clrl a5@(-284)
	lea a5@(-280),a0
	movel a5,a0@
	movel #L1283,a0@(4)
	movel sp,a0@(8)
L1283:
	lea a5@(-288),a1
	movel a5@(-304),a0
	movel a1,a0@
	movel a5@(8),a2
	movel #___vt_18InteractiveDisplay$15InputDispatcher,a2@(28)
	movel a2,a0
	movel #___vt_18InteractiveDisplay,a0@+
	movel #___vt_15InputDispatcher,a0@(24)
	pea 2:w
	pea a0@(4)
	jbsr __$_7_LLBase
	addql #8,sp
	movel #___vt_7Display,a2@
	movel a5@(-300),a1
	addql #4,a1
	movel a1@,a0
	movel a0@,a1@
	jbsr ___sjthrow
	.even
L1281:
	jbsr ___terminate
	.even
L1766:
	moveml a5@(-416),#0x5cfc
	fmovem a5@(-376),#0x3f
	unlk a5
	rts
	.even
.globl ___17InteractiveScreenUlPCc
___17InteractiveScreenUlPCc:
	link a5,#-312
	fmovem #0xfc,sp@-
	moveml #0x3f3a,sp@-
	jbsr ___get_eh_context
	movel d0,a5@(-304)
	movel d0,a5@(-292)
	movel a5@(8),a0
	movel #___vt_7Display,a0@
	movel a5@(-304),a0
	addql #4,a0
	movel a0@,a5@(-24)
	clrl a5@(-20)
	movel a5,a5@(-16)
	movel #L1303,a5@(-12)
	movel sp,a5@(-8)
L1303:
	lea a5@(-24),a1
	movel a1,a0@
	movel a5@(8),a2
	addql #4,a2
	movel a2,a5@(-296)
	movel a5@(-304),d0
	movel a5@(12),a2@
	movel #___vt_15InputDispatcher,a2@(24)
	movel a5@(-304),d0
	pea a2@(4)
	jbsr ___7_LLBase
	movel a5@(-292),a0
	addql #4,a0
	movel a0@,a5@(-48)
	clrl a5@(-44)
	lea a5@(-24),a1
	movel a1,a5@(-40)
	movel #L1308,a5@(-36)
	movel sp,a5@(-32)
	movel a0,a5@(-312)
L1308:
	lea a5@(-48),a2
	movel a2,a0@
	addql #4,sp
	movel a5@(-292),a1
	addql #4,a1
	movel a1@,a0
	movel a0@,a1@
	movel a5@(-312),a0
	movel a0@,a5@(-96)
	clrl a5@(-92)
	lea a5@(-24),a1
	movel a1,a5@(-88)
	movel #L1317,a5@(-84)
	movel sp,a5@(-80)
L1317:
	lea a5@(-96),a0
	movel a5@(-312),a2
	movel a0,a2@
	movew #20,a1
	addl a5@(-296),a1
	movel a1,a5@(-300)
	movel a5@(16),sp@-
	movel a1,sp@-
	jbsr _getValue__C5Key32PCc
	movel a5@(-300),a2
	movel d0,a2@
	addql #8,sp
	movel a5@(-312),a1
	movel a1@,a0
	movel a0@,a1@
	jra L1321
	.even
L1315:
	movel a5@(-312),a2
	movel a2@,a5@(-120)
	clrl a5@(-116)
	lea a5@(-24),a0
	movel a0,a5@(-112)
	movel #L1324,a5@(-108)
	movel sp,a5@(-104)
L1324:
	lea a5@(-120),a2
	movel a5@(-312),a1
	movel a2,a1@
	clrl sp@-
	movel a5@(-296),a0
	pea a0@(4)
	jbsr __$_7_LLBase
	addql #8,sp
	movel a5@(-292),a1
	addql #4,a1
	movel a1@,a0
	movel a0@,a1@
	jbsr ___sjthrow
	.even
L1322:
	jbsr ___terminate
	.even
L1321:
	movel a5@(-304),a0
	addql #4,a0
	movel a0@,a5@(-144)
	clrl a5@(-140)
	movel a5,a5@(-136)
	movel #L1330,a5@(-132)
	movel sp,a5@(-128)
	movel a0,a1
L1330:
	lea a5@(-144),a2
	movel a2,a0@
	movel a5@(8),a0
	movel #___vt_18InteractiveDisplay$15InputDispatcher,a0@(28)
	movel #___vt_18InteractiveDisplay,a0@
	movel a1@,a0
	movel a0@,a1@
	movel a1@,a0
	movel a0@,a1@
	jra L1332
	.even
L1301:
	movel a5@(-304),a0
	addql #4,a0
	movel a0@,a5@(-192)
	clrl a5@(-188)
	movel a5,a5@(-184)
	movel #L1345,a5@(-180)
	movel sp,a5@(-176)
L1345:
	lea a5@(-192),a1
	movel a1,a0@
	movel a5@(8),a2
	movel #___vt_7Display,a2@
	movel a5@(-304),a1
	addql #4,a1
	movel a1@,a0
	movel a0@,a1@
	jbsr ___sjthrow
	.even
L1332:
	movel a5@(-304),a1
	addql #4,a1
	movel a1@,a5@(-216)
	clrl a5@(-212)
	lea a5@(-208),a0
	movel a5,a0@
	movel #L1352,a0@(4)
	movel sp,a0@(8)
	movel a1,a5@(-308)
L1352:
	lea a5@(-216),a0
	movel a0,a1@
	movel a5@(8),a1
	pea a1@(32)
	jbsr ___7_NatScr
	movel a5@(-308),a2
	movel a2@,a5@(-240)
	clrl a5@(-236)
	lea a5@(-232),a0
	movel a5,a0@
	movel #L1356,a0@(4)
	movel sp,a0@(8)
L1356:
	lea a5@(-240),a1
	movel a5@(-308),a0
	movel a1,a0@
	movel a5@(8),a2
	movel #___vt_17InteractiveScreen$15InputDispatcher,a2@(28)
	movel #___vt_17InteractiveScreen,a2@
	movel a0@,a0
	movel a5@(-308),a1
	movel a0@,a1@
	movel a1@,a0
	movel a0@,a1@
	movel a2,d0
	jra L1767
	.even
L1350:
	movel a5@(-308),a2
	movel a2@,a5@(-288)
	clrl a5@(-284)
	lea a5@(-280),a0
	movel a5,a0@
	movel #L1365,a0@(4)
	movel sp,a0@(8)
L1365:
	lea a5@(-288),a1
	movel a5@(-308),a0
	movel a1,a0@
	movel a5@(8),a2
	movel #___vt_18InteractiveDisplay$15InputDispatcher,a2@(28)
	movel a2,a0
	movel #___vt_18InteractiveDisplay,a0@+
	movel #___vt_15InputDispatcher,a0@(24)
	pea 2:w
	pea a0@(4)
	jbsr __$_7_LLBase
	addql #8,sp
	movel #___vt_7Display,a2@
	movel a5@(-304),a1
	addql #4,a1
	movel a1@,a0
	movel a0@,a1@
	jbsr ___sjthrow
	.even
L1363:
	jbsr ___terminate
	.even
L1767:
	moveml a5@(-424),#0x5cfc
	fmovem a5@(-384),#0x3f
	unlk a5
	rts
	.even
.globl __$_17InteractiveScreen
__$_17InteractiveScreen:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel d2,sp@-
	movel a5@(8),a2
	movel a5@(12),d2
	movel #___vt_17InteractiveScreen$15InputDispatcher,a2@(28)
	movel #___vt_17InteractiveScreen,a2@
	movel a2,sp@-
	jbsr _close__17InteractiveScreen
	clrl sp@
	pea a2@(32)
	jbsr __$_7_NatScr
	addql #8,sp
	movel #___vt_18InteractiveDisplay$15InputDispatcher,a2@(28)
	movel a2,a0
	movel #___vt_18InteractiveDisplay,a0@+
	movel #___vt_15InputDispatcher,a0@(24)
	pea 2:w
	pea a0@(4)
	jbsr __$_7_LLBase
	addql #8,sp
	movel #___vt_7Display,a2@
	btst #0,d2
	jeq L1393
	movel a2,sp@-
	jbsr ___builtin_delete
L1393:
	movel a5@(-8),d2
	movel a5@(-4),a2
	unlk a5
	rts
	.even
.globl _waitSync__25InteractiveScreenBuffered
_waitSync__25InteractiveScreenBuffered:
	pea a5@
	movel sp,a5
	moveq #32,d0
	addl a5@(8),d0
	movel d0,sp@-
	jbsr _waitSync__11_NatScrBuff
	unlk a5
	rts
	.even
.globl _refresh__25InteractiveScreenBuffered
_refresh__25InteractiveScreenBuffered:
	pea a5@
	movel sp,a5
	moveq #32,d0
	addl a5@(8),d0
	movel d0,sp@-
	jbsr _refresh__11_NatScrBuff
	unlk a5
	rts
	.even
.globl _refresh__25InteractiveScreenBufferedssss
_refresh__25InteractiveScreenBufferedssss:
	pea a5@
	movel sp,a5
	moveq #32,d0
	addl a5@(8),d0
	movel d0,sp@-
	jbsr _refresh__11_NatScrBuff
	unlk a5
	rts
	.even
.globl _setTitle__25InteractiveScreenBufferedPCc
_setTitle__25InteractiveScreenBufferedPCc:
	pea a5@
	movel sp,a5
	subql #2,sp
	moveb #1,sp@(1)
	subql #2,sp
	movel a5@(12),sp@-
	moveq #32,d0
	addl a5@(8),d0
	movel d0,sp@-
	jbsr _setDisplayTitle__11_NatDisplayPCcb
	unlk a5
	rts
	.even
.globl _getDrawSurface__25InteractiveScreenBuffered
_getDrawSurface__25InteractiveScreenBuffered:
	pea a5@
	movel sp,a5
	movel a5@(8),a1
	lea a1@(32),a0
	movel a0@(298),d0
	unlk a5
	rts
	.even
.globl _getProperties__25InteractiveScreenBuffered
_getProperties__25InteractiveScreenBuffered:
	pea a5@
	movel sp,a5
	movel a5@(8),a1
	lea a1@(32),a0
	movel a0@(310),d0
	unlk a5
	rts
	.even
.globl _applyFilter__25InteractiveScreenBuffered
_applyFilter__25InteractiveScreenBuffered:
	pea a5@
	movel sp,a5
	movel a5@(8),a0
	movel a0@(4),sp@-
	pea a0@(32)
	jbsr _applyFilter__11_NatDisplayUl
	unlk a5
	rts
	.even
.globl _discardQueue__25InteractiveScreenBuffered
_discardQueue__25InteractiveScreenBuffered:
	pea a5@
	movel sp,a5
	moveq #32,d0
	addl a5@(8),d0
	movel d0,sp@-
	jbsr _discardQueue__11_NatDisplay
	unlk a5
	rts
	.even
.globl _waitEvent__25InteractiveScreenBuffered
_waitEvent__25InteractiveScreenBuffered:
	pea a5@
	movel sp,a5
	moveq #32,d0
	addl a5@(8),d0
	movel d0,sp@-
	jbsr _waitEvent__11_NatDisplay
	unlk a5
	rts
	.even
.globl _handleEvent__25InteractiveScreenBuffered
_handleEvent__25InteractiveScreenBuffered:
	pea a5@
	movel sp,a5
	movel a5@(8),a0
	pea a0@(4)
	pea a0@(32)
	jbsr _handleEvent__11_NatDisplayP15InputDispatcher
	unlk a5
	rts
	.even
.globl _inputQueued__25InteractiveScreenBuffered
_inputQueued__25InteractiveScreenBuffered:
	pea a5@
	movel sp,a5
	moveq #32,d0
	addl a5@(8),d0
	movel d0,sp@-
	jbsr _inputQueued__11_NatDisplay
	unlk a5
	rts
	.even
.globl _setClone__25InteractiveScreenBufferedb
_setClone__25InteractiveScreenBufferedb:
	pea a5@
	movel sp,a5
	subql #2,sp
	moveb a5@(15),sp@(1)
	subql #2,sp
	moveq #32,d0
	addl a5@(8),d0
	movel d0,sp@-
	jbsr _setClone__11_NatScrBuffb
	unlk a5
	rts
	.even
.globl _getClone__25InteractiveScreenBuffered
_getClone__25InteractiveScreenBuffered:
	pea a5@
	movel sp,a5
	movel a5@(8),a1
	lea a1@(32),a0
	bfextu a0@(309){#6:#1},d0
	unlk a5
	rts
	.even
.globl _setNumBuffers__25InteractiveScreenBufferedl
_setNumBuffers__25InteractiveScreenBufferedl:
	pea a5@
	movel sp,a5
	movel a5@(12),sp@-
	moveq #32,d0
	addl a5@(8),d0
	movel d0,sp@-
	jbsr _setNumBuffers__11_NatScrBuffl
	unlk a5
	rts
	.even
.globl _getNumBuffers__25InteractiveScreenBuffered
_getNumBuffers__25InteractiveScreenBuffered:
	pea a5@
	movel sp,a5
	movel a5@(8),a1
	lea a1@(32),a0
	moveq #2,d0
	btst #0,a0@(309)
	jeq L1421
	moveq #3,d0
L1421:
	unlk a5
	rts
	.even
.globl ___25InteractiveScreenBufferedUllb
___25InteractiveScreenBufferedUllb:
	link a5,#-304
	fmovem #0xfc,sp@-
	moveml #0x3f3a,sp@-
	jbsr ___get_eh_context
	movel d0,a5@(-300)
	movel d0,a5@(-292)
	movel a5@(8),a0
	movel #___vt_7Display,a0@
	movel a5@(-300),a0
	addql #4,a0
	movel a0@,a5@(-24)
	clrl a5@(-20)
	movel a5,a5@(-16)
	movel #L1429,a5@(-12)
	movel sp,a5@(-8)
L1429:
	lea a5@(-24),a1
	movel a1,a0@
	movel a5@(8),a2
	addql #4,a2
	movel a2,a5@(-296)
	movel a5@(-300),d0
	movel a5@(12),a2@
	movel #___vt_15InputDispatcher,a2@(24)
	movel a5@(-300),d0
	pea a2@(4)
	jbsr ___7_LLBase
	movel a5@(-292),a0
	addql #4,a0
	movel a0@,a5@(-48)
	clrl a5@(-44)
	lea a5@(-24),a1
	movel a1,a5@(-40)
	movel #L1434,a5@(-36)
	movel sp,a5@(-32)
	movel a0,a2
L1434:
	lea a5@(-48),a1
	movel a1,a0@
	addql #4,sp
	movel a5@(-292),a1
	addql #4,a1
	movel a1@,a0
	movel a0@,a1@
	movel a2@,a5@(-96)
	clrl a5@(-92)
	lea a5@(-24),a0
	movel a0,a5@(-88)
	movel #L1443,a5@(-84)
	movel sp,a5@(-80)
L1443:
	lea a5@(-96),a1
	movel a1,a2@
	movel a5@(-296),a0
	clrl a0@(20)
	movel a2@,a0
	movel a0@,a2@
	movel a5@(-300),a0
	addql #4,a0
	movel a0@,a5@(-144)
	clrl a5@(-140)
	movel a5,a5@(-136)
	movel #L1456,a5@(-132)
	movel sp,a5@(-128)
	movel a0,a1
L1456:
	lea a5@(-144),a2
	movel a2,a0@
	movel a5@(8),a0
	movel #___vt_18InteractiveDisplay$15InputDispatcher,a0@(28)
	movel #___vt_18InteractiveDisplay,a0@
	movel a1@,a0
	movel a0@,a1@
	movel a1@,a0
	movel a0@,a1@
	jra L1458
	.even
L1427:
	movel a5@(-300),a0
	addql #4,a0
	movel a0@,a5@(-192)
	clrl a5@(-188)
	movel a5,a5@(-184)
	movel #L1471,a5@(-180)
	movel sp,a5@(-176)
L1471:
	lea a5@(-192),a1
	movel a1,a0@
	movel a5@(8),a2
	movel #___vt_7Display,a2@
	movel a5@(-300),a1
	addql #4,a1
	movel a1@,a0
	movel a0@,a1@
	jbsr ___sjthrow
	.even
L1458:
	movel a5@(-300),a1
	addql #4,a1
	movel a1@,a5@(-216)
	clrl a5@(-212)
	lea a5@(-208),a0
	movel a5,a0@
	movel #L1478,a0@(4)
	movel sp,a0@(8)
	movel a1,a5@(-304)
L1478:
	lea a5@(-216),a0
	movel a0,a1@
	subql #2,sp
	moveb a5@(23),sp@(1)
	subql #2,sp
	movel a5@(16),sp@-
	movel a5@(8),a1
	pea a1@(32)
	jbsr ___11_NatScrBufflb
	movel a5@(-304),a2
	movel a2@,a5@(-240)
	clrl a5@(-236)
	lea a5@(-232),a0
	movel a5,a0@
	movel #L1482,a0@(4)
	movel sp,a0@(8)
L1482:
	lea a5@(-240),a1
	movel a5@(-304),a0
	movel a1,a0@
	movel a5@(8),a2
	movel #___vt_25InteractiveScreenBuffered$15InputDispatcher,a2@(28)
	movel #___vt_25InteractiveScreenBuffered,a2@
	movel a0@,a0
	movel a5@(-304),a1
	movel a0@,a1@
	movel a1@,a0
	movel a0@,a1@
	movel a2,d0
	jra L1768
	.even
L1476:
	movel a5@(-304),a2
	movel a2@,a5@(-288)
	clrl a5@(-284)
	lea a5@(-280),a0
	movel a5,a0@
	movel #L1491,a0@(4)
	movel sp,a0@(8)
L1491:
	lea a5@(-288),a1
	movel a5@(-304),a0
	movel a1,a0@
	movel a5@(8),a2
	movel #___vt_18InteractiveDisplay$15InputDispatcher,a2@(28)
	movel a2,a0
	movel #___vt_18InteractiveDisplay,a0@+
	movel #___vt_15InputDispatcher,a0@(24)
	pea 2:w
	pea a0@(4)
	jbsr __$_7_LLBase
	addql #8,sp
	movel #___vt_7Display,a2@
	movel a5@(-300),a1
	addql #4,a1
	movel a1@,a0
	movel a0@,a1@
	jbsr ___sjthrow
	.even
L1489:
	jbsr ___terminate
	.even
L1768:
	moveml a5@(-416),#0x5cfc
	fmovem a5@(-376),#0x3f
	unlk a5
	rts
	.even
.globl ___25InteractiveScreenBufferedUlPCclb
___25InteractiveScreenBufferedUlPCclb:
	link a5,#-312
	fmovem #0xfc,sp@-
	moveml #0x3f3a,sp@-
	jbsr ___get_eh_context
	movel d0,a5@(-304)
	movel d0,a5@(-292)
	movel a5@(8),a0
	movel #___vt_7Display,a0@
	movel a5@(-304),a0
	addql #4,a0
	movel a0@,a5@(-24)
	clrl a5@(-20)
	movel a5,a5@(-16)
	movel #L1511,a5@(-12)
	movel sp,a5@(-8)
L1511:
	lea a5@(-24),a1
	movel a1,a0@
	movel a5@(8),a2
	addql #4,a2
	movel a2,a5@(-296)
	movel a5@(-304),d0
	movel a5@(12),a2@
	movel #___vt_15InputDispatcher,a2@(24)
	movel a5@(-304),d0
	pea a2@(4)
	jbsr ___7_LLBase
	movel a5@(-292),a0
	addql #4,a0
	movel a0@,a5@(-48)
	clrl a5@(-44)
	lea a5@(-24),a1
	movel a1,a5@(-40)
	movel #L1516,a5@(-36)
	movel sp,a5@(-32)
	movel a0,a5@(-312)
L1516:
	lea a5@(-48),a2
	movel a2,a0@
	addql #4,sp
	movel a5@(-292),a1
	addql #4,a1
	movel a1@,a0
	movel a0@,a1@
	movel a5@(-312),a0
	movel a0@,a5@(-96)
	clrl a5@(-92)
	lea a5@(-24),a1
	movel a1,a5@(-88)
	movel #L1525,a5@(-84)
	movel sp,a5@(-80)
L1525:
	lea a5@(-96),a0
	movel a5@(-312),a2
	movel a0,a2@
	movew #20,a1
	addl a5@(-296),a1
	movel a1,a5@(-300)
	movel a5@(16),sp@-
	movel a1,sp@-
	jbsr _getValue__C5Key32PCc
	movel a5@(-300),a2
	movel d0,a2@
	addql #8,sp
	movel a5@(-312),a1
	movel a1@,a0
	movel a0@,a1@
	jra L1529
	.even
L1523:
	movel a5@(-312),a2
	movel a2@,a5@(-120)
	clrl a5@(-116)
	lea a5@(-24),a0
	movel a0,a5@(-112)
	movel #L1532,a5@(-108)
	movel sp,a5@(-104)
L1532:
	lea a5@(-120),a2
	movel a5@(-312),a1
	movel a2,a1@
	clrl sp@-
	movel a5@(-296),a0
	pea a0@(4)
	jbsr __$_7_LLBase
	addql #8,sp
	movel a5@(-292),a1
	addql #4,a1
	movel a1@,a0
	movel a0@,a1@
	jbsr ___sjthrow
	.even
L1530:
	jbsr ___terminate
	.even
L1529:
	movel a5@(-304),a0
	addql #4,a0
	movel a0@,a5@(-144)
	clrl a5@(-140)
	movel a5,a5@(-136)
	movel #L1538,a5@(-132)
	movel sp,a5@(-128)
	movel a0,a1
L1538:
	lea a5@(-144),a2
	movel a2,a0@
	movel a5@(8),a0
	movel #___vt_18InteractiveDisplay$15InputDispatcher,a0@(28)
	movel #___vt_18InteractiveDisplay,a0@
	movel a1@,a0
	movel a0@,a1@
	movel a1@,a0
	movel a0@,a1@
	jra L1540
	.even
L1509:
	movel a5@(-304),a0
	addql #4,a0
	movel a0@,a5@(-192)
	clrl a5@(-188)
	movel a5,a5@(-184)
	movel #L1553,a5@(-180)
	movel sp,a5@(-176)
L1553:
	lea a5@(-192),a1
	movel a1,a0@
	movel a5@(8),a2
	movel #___vt_7Display,a2@
	movel a5@(-304),a1
	addql #4,a1
	movel a1@,a0
	movel a0@,a1@
	jbsr ___sjthrow
	.even
L1540:
	movel a5@(-304),a1
	addql #4,a1
	movel a1@,a5@(-216)
	clrl a5@(-212)
	lea a5@(-208),a0
	movel a5,a0@
	movel #L1560,a0@(4)
	movel sp,a0@(8)
	movel a1,a5@(-308)
L1560:
	lea a5@(-216),a0
	movel a0,a1@
	subql #2,sp
	moveb a5@(27),sp@(1)
	subql #2,sp
	movel a5@(20),sp@-
	movel a5@(8),a1
	pea a1@(32)
	jbsr ___11_NatScrBufflb
	movel a5@(-308),a2
	movel a2@,a5@(-240)
	clrl a5@(-236)
	lea a5@(-232),a0
	movel a5,a0@
	movel #L1564,a0@(4)
	movel sp,a0@(8)
L1564:
	lea a5@(-240),a1
	movel a5@(-308),a0
	movel a1,a0@
	movel a5@(8),a2
	movel #___vt_25InteractiveScreenBuffered$15InputDispatcher,a2@(28)
	movel #___vt_25InteractiveScreenBuffered,a2@
	movel a0@,a0
	movel a5@(-308),a1
	movel a0@,a1@
	movel a1@,a0
	movel a0@,a1@
	movel a2,d0
	jra L1769
	.even
L1558:
	movel a5@(-308),a2
	movel a2@,a5@(-288)
	clrl a5@(-284)
	lea a5@(-280),a0
	movel a5,a0@
	movel #L1573,a0@(4)
	movel sp,a0@(8)
L1573:
	lea a5@(-288),a1
	movel a5@(-308),a0
	movel a1,a0@
	movel a5@(8),a2
	movel #___vt_18InteractiveDisplay$15InputDispatcher,a2@(28)
	movel a2,a0
	movel #___vt_18InteractiveDisplay,a0@+
	movel #___vt_15InputDispatcher,a0@(24)
	pea 2:w
	pea a0@(4)
	jbsr __$_7_LLBase
	addql #8,sp
	movel #___vt_7Display,a2@
	movel a5@(-304),a1
	addql #4,a1
	movel a1@,a0
	movel a0@,a1@
	jbsr ___sjthrow
	.even
L1571:
	jbsr ___terminate
	.even
L1769:
	moveml a5@(-424),#0x5cfc
	fmovem a5@(-384),#0x3f
	unlk a5
	rts
	.even
.globl __$_25InteractiveScreenBuffered
__$_25InteractiveScreenBuffered:
	pea a5@
	movel sp,a5
	movel a2,sp@-
	movel d2,sp@-
	movel a5@(8),a2
	movel a5@(12),d2
	movel #___vt_25InteractiveScreenBuffered$15InputDispatcher,a2@(28)
	movel #___vt_25InteractiveScreenBuffered,a2@
	movel a2,sp@-
	jbsr _close__25InteractiveScreenBuffered
	clrl sp@
	pea a2@(32)
	jbsr __$_11_NatScrBuff
	addql #8,sp
	movel #___vt_18InteractiveDisplay$15InputDispatcher,a2@(28)
	movel a2,a0
	movel #___vt_18InteractiveDisplay,a0@+
	movel #___vt_15InputDispatcher,a0@(24)
	pea 2:w
	pea a0@(4)
	jbsr __$_7_LLBase
	addql #8,sp
	movel #___vt_7Display,a2@
	btst #0,d2
	jeq L1601
	movel a2,sp@-
	jbsr ___builtin_delete
L1601:
	movel a5@(-8),d2
	movel a5@(-4),a2
	unlk a5
	rts
