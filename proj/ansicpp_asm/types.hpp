//****************************************************************************//
//**                                                                        **//
//** File:         machine.hpp                                              **//
//** Description:  Host Machine definitions                                 **//
//** Comment(s):   Internal developer version only                          **//
//** Library:                                                               **//
//** Created:      2005-08-29                                               **//
//** Updated:      2005-08-29                                               **//
//** Author(s):    Karl Churchill                                           **//
//** Note(s):      Stub replacement for needed exng/xbase.hpp defs          **//
//** Copyright:    (C)1996 - , eXtropia Studios                             **//
//**               Serkan YAZICI, Karl Churchill                            **//
//**               All Rights Reserved.                                     **//
//**                                                                        **//
//****************************************************************************//

#ifndef _NEW_TYPES_HPP_
#define _NEW_TYPES_HPP_

// this is just a gap filler for framework xbase definitions

typedef signed char sint8;
typedef signed short int sint16;
typedef signed long int sint32;
typedef signed long long int sint64;
typedef unsigned char uint8;
typedef unsigned short int uint16;
typedef unsigned long int uint32;
typedef unsigned long long int uint64;
typedef float float32;
typedef double float64;

#define rsint8 register sint8
#define rsint16 register sint16
#define rsint32 register sint32
#define rsint64 register sint64
#define ruint8 register uint8
#define ruint16 register uint16
#define ruint32 register uint32
#define ruint64 register uint64
#define rfloat32 register float32
#define rfloat64 register float64

#endif
