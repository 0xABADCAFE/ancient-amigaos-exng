;//****************************************************************************//
;//**                                                                        **//
;//** File:         libsrc/plat/amigaos3_68k/systemlib/cpuopt.asm            **//
;//** Description:                                                           **//
;//** Comment(s):                                                            **//
;//** Library:      systemlib                                                **//
;//** Created:      2003-02-09                                               **//
;//** Updated:      2003-02-09                                               **//
;//** Author(s):    Karl Churchill                                           **//
;//** Note(s):      Asm definitions for 68K CPU class                        **//
;//** Copyright:    (C)1996-2003, eXtropia Studios                           **//
;//**               Serkan YAZICI, Karl Churchill                            **//
;//**               All Rights Reserved.                                     **//
;//**                                                                        **//
;//****************************************************************************//

	mc68000

	SECTION "synchronise__CPU_:0",CODE

	XDEF	synchronise__CPU_

synchronise__CPU_
	nop
	rts

	END
