
; Storm C Compiler
; exng:libsrc/plat/amigaos3_68k/gfxlib/drawhw.cpp
	mc68030
	mc68881
	XREF	setClip__Draw2D__Tssss
	XREF	getCanvas__Draw2D__T
	XREF	setCanvas__Draw2D__TP07Surface
	XREF	end__Draw2D__T
	XREF	begin__Draw2D__T
	XREF	query__Draw2D__TE
	XREF	refresh__DrawImgWr__Tssss
	XREF	unlock__DrawImgWr__T
	XREF	lock__DrawImgWr__T
	XREF	getModulus__DrawImgWr__T
	XREF	getH__DrawImgWr__T
	XREF	getW__DrawImgWr__T
	XREF	getFormat__DrawImgWr__T
	XREF	getH__DrawImg__T
	XREF	getW__DrawImg__T
	XREF	getFormat__DrawImg__T
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
	XREF	_state__Native3D
	XREF	_query__Native3D
	XREF	_alphaTest__Native3D
	XREF	_zBuffTest__Native3D
	XREF	_logicOp__Native3D
	XREF	_fogMode__Native3D
	XREF	_blendMode__Native3D
	XREF	_frontFace__Native3D
	XREF	_texel__Native3D
	XREF	_texEnv__Native3D
	XREF	_texFill__Native3D
	XREF	_texFilter__Native3D
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

	END
