;//****************************************************************************//
;//**                                                                        **//
;//**  File:          test.asm                                               **//
;//**                                                                        **//
;//**  Description:   test                                                   **//
;//**  Comment(s):                                                           **//
;//**                                                                        **//
;//**  First Started: 2002-08-04                                             **//
;//**  Last Updated:  2002-08-24                                             **//
;//**                                                                        **//
;//**  Author(s):     Karl Churchill                                         **//
;//**                                                                        **//
;//**  Copyright:     (C)1998-2002, eXtropia Studios                         **//
;//**                 Serkan YAZICI, Karl Churchill                          **//
;//**                 All Rights Reserved.                                   **//
;//**                                                                        **//
;//****************************************************************************//


	SECTION ":0",CODE

;//////////////////////////////////////////////////////////////////////////////
;//
;//
;//
;//////////////////////////////////////////////////////////////////////////////

	MACRO	SPACER
	CNOP	0, 16
	ENDM

	XDEF _TestFunc

_TestFunc

	and.w		#$F, d0
	lsl.w		#4, d0
	jmp		jumpbase(pc, d0.w)

jumpbase
	move.w $0000, d0
	rts
	
	SPACER

	move.w $0101, d0
	rts

	SPACER

	move.w $0202, d0
	rts

	SPACER

	move.w $0303, d0
	rts

	SPACER

	move.w $0404, d0
	rts

	SPACER

	move.w $0505, d0
	rts

	SPACER

	move.w $0606, d0
	rts

	SPACER

	move.w $0707, d0
	rts

	SPACER

	move.w $0808, d0
	rts

	SPACER

	move.w $0909, d0
	rts

	SPACER

	move.w $0A0A, d0
	rts

	SPACER

	move.w $0B0B, d0
	rts

	SPACER

	move.w $0C0C, d0
	rts

	SPACER

	move.w $0D0D, d0
	rts
	
	SPACER

	move.w $0E0E, d0
	rts

	SPACER

	move.w $0F0F, d0
	rts

;//////////////////////////////////////////////////////////////////////////////
	
	END
	
;//////////////////////////////////////////////////////////////////////////////
