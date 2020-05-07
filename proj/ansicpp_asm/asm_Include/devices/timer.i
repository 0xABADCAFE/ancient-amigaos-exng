	IFND	DEVICES_TIMER_I
DEVICES_TIMER_I	SET	1
**
**	$VER: timer.i 36.10 (5.3.1991)
**	Includes Release 44.1
**
**	Timer device name and useful definitions.
**
**	(C) Copyright 1985-1999 Amiga, Inc.
**		All Rights Reserved
**


	IFND	EXEC_TYPES_I
	INCLUDE "exec/types.i"
	ENDC

	IFND	EXEC_IO_I
	INCLUDE "exec/io.i"
	ENDC

* unit defintions
UNIT_MICROHZ	EQU	0
UNIT_VBLANK	EQU	1
UNIT_ECLOCK	EQU	2
UNIT_WAITUNTIL	EQU	3
UNIT_WAITECLOCK	EQU	4

TIMERNAME	MACRO
		DC.B	'timer.device',0
		DS.W	0
		ENDM

 STRUCTURE TIMEVAL,0
	ULONG	TV_SECS
	ULONG	TV_MICRO
	LABEL	TV_SIZE

 STRUCTURE ECLOCKVAL,0
	ULONG	EV_HI
	ULONG	EV_LO
	LABEL	EV_SIZE

 STRUCTURE TIMEREQUEST,IO_SIZE
	STRUCT	IOTV_TIME,TV_SIZE
	LABEL	IOTV_SIZE

* IO_COMMAND to use for adding a timer
	DEVINIT
	DEVCMD	TR_ADDREQUEST
	DEVCMD	TR_GETSYSTIME
	DEVCMD	TR_SETSYSTIME

	ENDC	; DEVICES_TIMER_I
