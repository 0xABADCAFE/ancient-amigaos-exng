
; Storm C Compiler
; exng:libsrc/plat/amigaos3_68k/gfxlib/native3D.cpp
	mc68030
	mc68881
	XREF	_0dt__Texture__T
	XREF	_0dt__Rasterizer__T
	XREF	obtain__Rasterizer__P07Surface
	XREF	_W3D_DrawElements
	XREF	_W3D_DrawArray
	XREF	_W3D_BindTexture
	XREF	_W3D_ColorPointer
	XREF	_W3D_TexCoordPointer
	XREF	_W3D_VertexPointer
	XREF	destroy__Mesh__T
	XREF	create__Mesh__TUsUs
	XREF	getDrawSurface__Display__T
	XREF	setTitle__Display__TPCc
	XREF	refresh__Display__Tssss
	XREF	refresh__Display__T
	XREF	waitSync__Display__T
	XREF	close__Display__T
	XREF	reopen__Display__T
	XREF	open__Display__TP17DisplayPropertiesPCc
	XREF	open__Display__TssEPCc
	XREF	_0dt__NativeScreenDB__T
	XREF	_0ct__NativeScreenDB__T
	XREF	refresh__NativeScreenDB__T
	XREF	close__NativeScreenDB__T
	XREF	reopen__NativeScreenDB__T
	XREF	open__NativeScreenDB__TP17DisplayPropertiesPCc
	XREF	open__NativeScreenDB__TssEPCc
	XREF	_0dt__NativeScreen__T
	XREF	_0ct__NativeScreen__T
	XREF	close__NativeScreen__T
	XREF	reopen__NativeScreen__T
	XREF	open__NativeScreen__TP17DisplayPropertiesPCc
	XREF	open__NativeScreen__TssEPCc
	XREF	_0dt__NativeWindow__T
	XREF	_0ct__NativeWindow__T
	XREF	refresh__NativeWindow__Tssss
	XREF	refresh__NativeWindow__T
	XREF	close__NativeWindow__T
	XREF	open__NativeWindow__TP17DisplayPropertiesPCc
	XREF	open__NativeWindow__TssEPCc
	XREF	reopen__NativeWindow__T
	XREF	setDisplayTitle__DisplayNative__TPCcs
	XREF	waitForRefresh__DisplayNative__T
	XREF	blitCopy__Surface__P07SurfacessP07Surfacessss
	XREF	destroy__Surface__T
	XREF	init__Surface__T
	XREF	getHardwareFormat__Native2D__E
	XREF	findIndex__DisplayPropertiesProvider__ssEs
	XREF	getMode__DisplayPropertiesProvider__Ui
	XREF	destroy__ImageBuffer__T
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
	XREF	_propTab__PixelDescriptor
	XREF	_modesAvail__DisplayPropertiesProvider
	XREF	_numModes__DisplayPropertiesProvider
	XREF	_GfxBase
	XREF	_CyberGfxBase
	XREF	_pixelType__Native2D
	XREF	_convTab__Native2D
	XREF	_modeID__DisplayNative
	XREF	_Warp3DBase
	XREF	_coordType__Native3D
	XREF	_colourType__Native3D
	XREF	_texCoordType__Native3D
	XREF	_openCnt__Rasterizer
	XREF	_drawPointsXYZ_F32__Rasterizer
	XREF	_drawPointsXYZ_F64__Rasterizer
	XREF	_drawLinesXYZ_F32__Rasterizer
	XREF	_drawLinesXYZ_F64__Rasterizer
	XREF	_drawLineStripXYZ_F32__Rasterizer
	XREF	_drawLineStripXYZ_F64__Rasterizer
	XREF	_useArrayEmul__Rasterizer

	SECTION "getVolatile__Mem_:0",CODE

	rts

	SECTION "_redBalance__Colour:1",DATA

_redBalance__Colour
	dc.w	$4D

	SECTION "_greenBalance__Colour:1",DATA

_greenBalance__Colour
	dc.w	$96

	SECTION "_blueBalance__Colour:1",DATA

_blueBalance__Colour
	dc.w	$1C

	SECTION "_state__Native3D:1",DATA

	XDEF	_state__Native3D
_state__Native3D
	dc.l	$100,2,$10,$200,$400,$800000,$2000000,$80,$800,$1000,$200000
	dc.l	$4000,$2000,$400000,$80000,$4000000,$100000,$8000000,$8000,$10000,$20000,$40000

	SECTION "_query__Native3D:1",DATA

	XDEF	_query__Native3D
_query__Native3D
	dc.b	1,4,$A0,$8,$52,2,5,$A1,$9,6,$53
	dc.b	3,$B,7,$54,$A2,$5B,$83,$65,$55,$79,$1F
	dc.b	$20,$19,$3D,$3E,$3F,$29,$2A,$2B,$33,$34,$8D
	dc.b	$8E,$8F,$90,$91,$92,$93,$47,$48,$49,$4A,$4B
	dc.b	$73,$D,$C,$E,$B,$10,$F,$11,$13,$12,$18
	dc.b	$14,$15,$16,$17,$1C

	SECTION "_alphaTest__Native3D:1",DATA

	XDEF	_alphaTest__Native3D
_alphaTest__Native3D
	dc.b	2,4,7,3,5,6,1,$8

	SECTION "_zBuffTest__Native3D:1",DATA

	XDEF	_zBuffTest__Native3D
_zBuffTest__Native3D
	dc.b	2,4,7,3,5,6,1,$8

	SECTION "_logicOp__Native3D:1",DATA

	XDEF	_logicOp__Native3D
_logicOp__Native3D
	dc.b	1,2,3,4,5,6,7,$8,$9,$A,$B
	dc.b	$C,$D,$E,$F,$10

	SECTION "_fogMode__Native3D:1",DATA

	XDEF	_fogMode__Native3D
_fogMode__Native3D
	dc.b	1,2,3,4

	SECTION "_blendMode__Native3D:1",DATA

	XDEF	_blendMode__Native3D
_blendMode__Native3D
	dc.b	1,2,3,4,5,6,7,$8,$9,$A,$B
	dc.b	$C,$D,$E,$F

	SECTION "_frontFace__Native3D:1",DATA

	XDEF	_frontFace__Native3D
_frontFace__Native3D
	dc.b	0,1

	SECTION "_texel__Native3D:1",DATA

	XDEF	_texel__Native3D
_texel__Native3D
	dc.b	1,$8,$A,7,3,2,5,$9,4,6,$B

	SECTION "_texEnv__Native3D:1",DATA

	XDEF	_texEnv__Native3D
_texEnv__Native3D
	dc.b	1,2,3,4

	SECTION "_texFill__Native3D:1",DATA

	XDEF	_texFill__Native3D
_texFill__Native3D
	dc.b	2,1

	SECTION "_texFilter__Native3D:1",DATA

	XDEF	_texFilter__Native3D
_texFilter__Native3D
	dc.b	2,1,3,5,4,6

	END
