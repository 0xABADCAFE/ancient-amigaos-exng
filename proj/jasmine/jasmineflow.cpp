//****************************************************************************//
//**                                                                        **//
//** File:         proj/jasmine/jasmineflow.cpp                             **//
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

#ifndef JASMINE_BREAK_DETECT_ALWAYS
  #ifdef JASMINE_BREAK_DETECT_BRANCH_ONLY

    #include <SystemLib/thread.hpp>

    #define CHECKBREAK()                      \
    if (Thread::userBreak())                  \
    {                                          \
      jvm->exitReg = Jasmine::USER_BREAK;      \
      return;                                  \
    }
  #else
    #define CHECKBREAK()
  #endif
#endif


void JasmineOP::fNOP(OP_ARGS)
{
  jvm->instPtr++;
}

void JasmineOP::fEND(OP_ARGS)
{
  jvm->exitReg = Jasmine::END_OF_CODE;
}

// #ifndef JASMINE_MACRO_EA

void JasmineOP::fLEA(OP_ARGS)
{
  // source must be non reg-direct EA
  // dest must be reg direct
  JasmineEA::D2(jvm,1,8);
  jvm->op[1].reg->ptrU8() = jvm->op[0].u8;
}

void JasmineOP::fBRA(OP_ARGS)
{
  CHECKBREAK();
  jvm->instPtr += *((sint32*)++jvm->instPtr);
}

///////////////////////////////////////////////////////////////////////////////
//
//  Conditional branching infos
//
///////////////////////////////////////////////////////////////////////////////

void JasmineOP::fBNEQ_I8(OP_ARGS)
{
  CHECKBREAK();
  JasmineEA::D2C_X8(jvm);
  if (*jvm->op[0].s8!=*jvm->op[1].s8)
    jvm->instPtr += *((sint32*)jvm->instPtr);
  else
    jvm->instPtr++;
}

void JasmineOP::fBNEQ_I16(OP_ARGS)
{
  CHECKBREAK();
  JasmineEA::D2C_X16(jvm);
  if (*jvm->op[0].s16!=*jvm->op[1].s16)
    jvm->instPtr += *((sint32*)jvm->instPtr);
  else
    jvm->instPtr++;
}

void JasmineOP::fBNEQ_I32(OP_ARGS)
{
  CHECKBREAK();
  JasmineEA::D2C_X32(jvm);
  if (*jvm->op[0].s32!=*jvm->op[1].s32)
    jvm->instPtr += *((sint32*)jvm->instPtr);
  else
    jvm->instPtr++;
}

void JasmineOP::fBNEQ_I64(OP_ARGS)
{
  CHECKBREAK();
  JasmineEA::D2C_X64(jvm);
  if (*jvm->op[0].s64!=*jvm->op[0].s64)
    jvm->instPtr += *((sint32*)jvm->instPtr);
  else
    jvm->instPtr++;
}

void JasmineOP::fBNEQ_F32(OP_ARGS)
{
  CHECKBREAK();
  JasmineEA::D2C_X32(jvm);
  if (*jvm->op[0].f32!=*jvm->op[1].f32)
    jvm->instPtr += *((sint32*)jvm->instPtr);
  else
    jvm->instPtr++;
}

void JasmineOP::fBNEQ_F64(OP_ARGS)
{
  CHECKBREAK();
  JasmineEA::D2C_X64(jvm);
  if (*jvm->op[0].f64!=*jvm->op[1].f64)
    jvm->instPtr += *((sint32*)jvm->instPtr);
  else
    jvm->instPtr++;
}

void JasmineOP::fBLS_I8(OP_ARGS)
{
  CHECKBREAK();
  JasmineEA::D2C_X8(jvm);
  if (*jvm->op[0].s8<*jvm->op[1].s8)
    jvm->instPtr += *((sint32*)jvm->instPtr);
  else
    jvm->instPtr++;
}

void JasmineOP::fBLS_I16(OP_ARGS)
{
  CHECKBREAK();
  JasmineEA::D2C_X16(jvm);
  if (*jvm->op[0].s16<*jvm->op[1].s16)
    jvm->instPtr += *((sint32*)jvm->instPtr);
  else
    jvm->instPtr++;
}

void JasmineOP::fBLS_I32(OP_ARGS)
{
  CHECKBREAK();
  JasmineEA::D2C_X32(jvm);
  if (*jvm->op[0].s32<*jvm->op[1].s32)
    jvm->instPtr += *((sint32*)jvm->instPtr);
  else
    jvm->instPtr++;
}

void JasmineOP::fBLS_I64(OP_ARGS)
{
  CHECKBREAK();
  JasmineEA::D2C_X64(jvm);
  if (*jvm->op[0].s64<*jvm->op[1].s64)
    jvm->instPtr += *((sint32*)jvm->instPtr);
  else
    jvm->instPtr++;
}

void JasmineOP::fBLS_F32(OP_ARGS)
{
  CHECKBREAK();
  JasmineEA::D2C_X32(jvm);
  if (*jvm->op[0].f32<*jvm->op[1].f32)
    jvm->instPtr += *((sint32*)jvm->instPtr);
  else
    jvm->instPtr++;
}

void JasmineOP::fBLS_F64(OP_ARGS)
{
  CHECKBREAK();
  JasmineEA::D2C_X64(jvm);
  if (*jvm->op[0].f64<*jvm->op[1].f64)
    jvm->instPtr += *((sint32*)jvm->instPtr);
  else
    jvm->instPtr++;
}

void JasmineOP::fBLSEQ_I8(OP_ARGS)
{
  CHECKBREAK();
  JasmineEA::D2C_X8(jvm);
  if (*jvm->op[0].s8<=*jvm->op[1].s8)
    jvm->instPtr += *((sint32*)jvm->instPtr);
  else
    jvm->instPtr++;
}

void JasmineOP::fBLSEQ_I16(OP_ARGS)
{
  CHECKBREAK();
  JasmineEA::D2C_X16(jvm);
  if (*jvm->op[0].s16<=*jvm->op[1].s16)
    jvm->instPtr += *((sint32*)jvm->instPtr);
  else
    jvm->instPtr++;
}

void JasmineOP::fBLSEQ_I32(OP_ARGS)
{
  CHECKBREAK();
  JasmineEA::D2C_X32(jvm);
  if (*jvm->op[0].s32<=*jvm->op[1].s32)
    jvm->instPtr += *((sint32*)jvm->instPtr);
  else
    jvm->instPtr++;
}

void JasmineOP::fBLSEQ_I64(OP_ARGS)
{
  CHECKBREAK();
  JasmineEA::D2C_X64(jvm);
  if (*jvm->op[0].s64<=*jvm->op[1].s64)
    jvm->instPtr += *((sint32*)jvm->instPtr);
  else
    jvm->instPtr++;
}

void JasmineOP::fBLSEQ_F32(OP_ARGS)
{
  CHECKBREAK();
  JasmineEA::D2C_X32(jvm);
  if (*jvm->op[0].f32<=*jvm->op[1].f32)
    jvm->instPtr += *((sint32*)jvm->instPtr);
  else
    jvm->instPtr++;
}

void JasmineOP::fBLSEQ_F64(OP_ARGS)
{
  CHECKBREAK();
  JasmineEA::D2C_X64(jvm);
  if (*jvm->op[0].f64<=*jvm->op[0].f64)
    jvm->instPtr += *((sint32*)jvm->instPtr);
  else
    jvm->instPtr++;
}

void JasmineOP::fBEQ_I8(OP_ARGS)
{
  CHECKBREAK();
  JasmineEA::D2C_X8(jvm);
  if (*jvm->op[0].s8==*jvm->op[1].s8)
    jvm->instPtr += *((sint32*)jvm->instPtr);
  else
    jvm->instPtr++;
}

void JasmineOP::fBEQ_I16(OP_ARGS)
{
  CHECKBREAK();
  JasmineEA::D2C_X16(jvm);
  if (*jvm->op[0].s16==*jvm->op[1].s16)
    jvm->instPtr += *((sint32*)jvm->instPtr);
  else
    jvm->instPtr++;
}

void JasmineOP::fBEQ_I32(OP_ARGS)
{
  CHECKBREAK();
  JasmineEA::D2C_X32(jvm);
  if (*jvm->op[0].s32==*jvm->op[1].s32)
    jvm->instPtr += *((sint32*)jvm->instPtr);
  else
    jvm->instPtr++;
}

void JasmineOP::fBEQ_I64(OP_ARGS)
{
  CHECKBREAK();
  JasmineEA::D2C_X64(jvm);
  if (*jvm->op[0].s64==*jvm->op[1].s64)
    jvm->instPtr += *((sint32*)jvm->instPtr);
  else
    jvm->instPtr++;
}

void JasmineOP::fBEQ_F32(OP_ARGS)
{
  CHECKBREAK();
  JasmineEA::D2C_X32(jvm);
  if (*jvm->op[0].f32==*jvm->op[1].f32)
    jvm->instPtr += *((sint32*)jvm->instPtr);
  else
    jvm->instPtr++;
}

void JasmineOP::fBEQ_F64(OP_ARGS)
{
  CHECKBREAK();
  JasmineEA::D2C_X64(jvm);
  if (*jvm->op[0].f64==*jvm->op[1].f64)
    jvm->instPtr += *((sint32*)jvm->instPtr);
  else
    jvm->instPtr++;
}

void JasmineOP::fBGREQ_I8(OP_ARGS)
{
  CHECKBREAK();
  JasmineEA::D2C_X8(jvm);
  if (*jvm->op[0].s8>=*jvm->op[1].s8)
    jvm->instPtr += *((sint32*)jvm->instPtr);
  else
    jvm->instPtr++;
}

void JasmineOP::fBGREQ_I16(OP_ARGS)
{
  CHECKBREAK();
  JasmineEA::D2C_X16(jvm);
  if (*jvm->op[0].s16>=*jvm->op[1].s16)
    jvm->instPtr += *((sint32*)jvm->instPtr);
  else
    jvm->instPtr++;
}

void JasmineOP::fBGREQ_I32(OP_ARGS)
{
  CHECKBREAK();
  JasmineEA::D2C_X32(jvm);
  if (*jvm->op[0].s32>=*jvm->op[1].s32)
    jvm->instPtr += *((sint32*)jvm->instPtr);
  else
    jvm->instPtr++;
}

void JasmineOP::fBGREQ_I64(OP_ARGS)
{
  CHECKBREAK();
  JasmineEA::D2C_X64(jvm);
  if (*jvm->op[0].s64>=*jvm->op[1].s64)
    jvm->instPtr += *((sint32*)jvm->instPtr);
  else
    jvm->instPtr++;
}

void JasmineOP::fBGREQ_F32(OP_ARGS)
{
  CHECKBREAK();
  JasmineEA::D2C_X32(jvm);
  if (*jvm->op[0].f32>=*jvm->op[1].f32)
    jvm->instPtr += *((sint32*)jvm->instPtr);
  else
    jvm->instPtr++;
}

void JasmineOP::fBGREQ_F64(OP_ARGS)
{
  CHECKBREAK();
  JasmineEA::D2C_X64(jvm);
  if (*jvm->op[0].f64>=*jvm->op[1].f64)
    jvm->instPtr += *((sint32*)jvm->instPtr);
  else
    jvm->instPtr++;
}

void JasmineOP::fBGR_I8(OP_ARGS)
{
  CHECKBREAK();
  JasmineEA::D2C_X8(jvm);
  if (*jvm->op[0].s8>*jvm->op[1].s8)
    jvm->instPtr += *((sint32*)jvm->instPtr);
  else
    jvm->instPtr++;
}

void JasmineOP::fBGR_I16(OP_ARGS)
{
  CHECKBREAK();
  JasmineEA::D2C_X16(jvm);
  if (*jvm->op[0].s16>*jvm->op[1].s16)
    jvm->instPtr += *((sint32*)jvm->instPtr);
  else
    jvm->instPtr++;
}

void JasmineOP::fBGR_I32(OP_ARGS)
{
  CHECKBREAK();
  JasmineEA::D2C_X32(jvm);
  if (*jvm->op[0].s32>*jvm->op[1].s32)
    jvm->instPtr += *((sint32*)jvm->instPtr);
  else
    jvm->instPtr++;
}

void JasmineOP::fBGR_I64(OP_ARGS)
{
  CHECKBREAK();
  JasmineEA::D2C_X64(jvm);
  if (*jvm->op[0].s64>*jvm->op[1].s64)
    jvm->instPtr += *((sint32*)jvm->instPtr);
  else
    jvm->instPtr++;
}

void JasmineOP::fBGR_F32(OP_ARGS)
{
  CHECKBREAK();
  JasmineEA::D1_X32(jvm);
  if (*jvm->op[0].f32>*jvm->op[1].f32)
    jvm->instPtr += *((sint32*)jvm->instPtr);
  else
    jvm->instPtr++;
}

void JasmineOP::fBGR_F64(OP_ARGS)
{
  CHECKBREAK();
  JasmineEA::D1_X64(jvm);
  if (*jvm->op[0].f64>*jvm->op[1].f64)
    jvm->instPtr += *((sint32*)jvm->instPtr);
  else
    jvm->instPtr++;
}

void JasmineOP::fCALL(OP_ARGS)
{
  if (jvm->methodStack<jvm->methodStackTop)
  {
    JasmineEA::D1_X32(jvm);
    *(jvm->methodStack++) = jvm->instPtr;
    jvm->instPtr = jvm->op[0].u32;
  }
  else
    jvm->exitReg = Jasmine::METHD_OVERFLOW;
}

void JasmineOP::fRET(OP_ARGS)
{
  if (jvm->methodStack>jvm->methodStackBase)
    jvm->instPtr = *(--jvm->methodStack);
  else
    jvm->exitReg = Jasmine::METHD_UNDERFLOW;
}

// #else // JASMINE_MACRO_EA

// #endif // JASMINE_MACRO_EA

#undef CHECKBREAK