//****************************************************************************//
//**                                                                        **//
//** File:         proj/jasmine/jasminecastfloat.cpp                        **//
//** Description:                                                           **//
//** Comment(s):   Internal developer version only                          **//
//** Library:                                                               **//
//** Created:      2003-02-10                                               **//
//** Updated:      2003-02-10                                               **//
//** Author(s):    Karl Churchill                                           **//
//** Note(s):                                                               **//
//** Copyright:    (C)1996-2003, eXtropia Studios                           **//
//**               Serkan YAZICI, Karl Churchill                            **//
//**               All Rights Reserved.                                     **//
//**                                                                        **//
//****************************************************************************//

#include "Jasmine.hpp"


#ifndef JASMINE_MACRO_EA

/////////////////////////////////////////////////////////////////////////////////////
//
//  Seperate EA pass version, operand pointers saved in op[0] - op[2]
//
/////////////////////////////////////////////////////////////////////////////////////

void JasmineOP::fF64_F32(OP_ARGS)
{
  JasmineEA::D2(jvm, 4,8);
  *jvm->op[1].f64 = *jvm->op[0].f32;
}

/////////////////////////////////////////////////////////////////////////////////////

void JasmineOP::fF32_F64(OP_ARGS)
{
  JasmineEA::D2(jvm, 8,4);
  *jvm->op[1].f32 = (float32)(*jvm->op[0].f64);
}

/////////////////////////////////////////////////////////////////////////////////////

#else // #ifndef JASMINE_MACRO_EA

/////////////////////////////////////////////////////////////////////////////////////
//
//  Interleaved EA version, operand pointers generated on demand
//
/////////////////////////////////////////////////////////////////////////////////////

void JasmineOP::fF64_F32(OP_ARGS)
{
  OPINIT();
  OP2D_64(float64) = OP1_32(float32);
  OPDONE();
}

/////////////////////////////////////////////////////////////////////////////////////

void JasmineOP::fF32_F64(OP_ARGS)
{
  OPINIT();
  OP2D_32(float32) = (float32)(OP1_64(float64));
  OPDONE();
}

#endif // #ifndef JASMINE_MACRO_EA

