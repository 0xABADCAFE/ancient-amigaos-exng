//****************************************************************************//
//**                                                                        **//
//** File:         proj/jasmine/jasminearithmetoc.cpp                       **//
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

#include "jasmine.hpp"

extern "C" {
  #include <math.h>
}

#ifndef JASMINE_MACRO_EA

/////////////////////////////////////////////////////////////////////////////////////
//
//  Seperate EA pass version, operand pointers saved in op[0] - op[2]
//
/////////////////////////////////////////////////////////////////////////////////////

void JasmineOP::fADD_I8(OP_ARGS)
{
  JasmineEA::D3_X8(jvm);
  *jvm->op[2].s8 = *jvm->op[0].s8 + *jvm->op[1].s8;
}

void JasmineOP::fADD_I16(OP_ARGS)
{
  JasmineEA::D3_X16(jvm);
  *jvm->op[2].s16 = *jvm->op[0].s16 + *jvm->op[1].s16;
}

void JasmineOP::fADD_I32(OP_ARGS)
{
  JasmineEA::D3_X32(jvm);
  *jvm->op[2].s32 = *jvm->op[0].s32 + *jvm->op[1].s32;
}

void JasmineOP::fADD_I64(OP_ARGS)
{
  JasmineEA::D3_X64(jvm);
  *jvm->op[2].s64 = *jvm->op[0].s64 + *jvm->op[1].s64;
}

void JasmineOP::fADD_F32(OP_ARGS)
{
  JasmineEA::D3_X32(jvm);
  *jvm->op[2].f32 = *jvm->op[0].f32 + *jvm->op[1].f32;
}

void JasmineOP::fADD_F64(OP_ARGS)
{
  JasmineEA::D3_X64(jvm);
  *jvm->op[2].f64 = *jvm->op[0].f64 + *jvm->op[1].f64;
}

/////////////////////////////////////////////////////////////////////////////////////

void JasmineOP::fSUB_I8(OP_ARGS)
{
  JasmineEA::D3_X8(jvm);
  *jvm->op[2].s8 = *jvm->op[0].s8 - *jvm->op[1].s8;
}

void JasmineOP::fSUB_I16(OP_ARGS)
{
  JasmineEA::D3_X16(jvm);
  *jvm->op[2].s16 = *jvm->op[0].s16 - *jvm->op[1].s16;
}

void JasmineOP::fSUB_I32(OP_ARGS)
{
  JasmineEA::D3_X32(jvm);
  *jvm->op[2].s32 = *jvm->op[0].s32 - *jvm->op[1].s32;
}

void JasmineOP::fSUB_I64(OP_ARGS)
{
  JasmineEA::D3_X64(jvm);
  *jvm->op[2].s64 = *jvm->op[0].s64 - *jvm->op[1].s64;
}

void JasmineOP::fSUB_F32(OP_ARGS)
{
  JasmineEA::D3_X32(jvm);
  *jvm->op[2].f32 = *jvm->op[0].f32 - *jvm->op[1].f32;
}

void JasmineOP::fSUB_F64(OP_ARGS)
{
  JasmineEA::D3_X64(jvm);
  *jvm->op[2].f64 = *jvm->op[0].f64 - *jvm->op[1].f64;
}

/////////////////////////////////////////////////////////////////////////////////////

void JasmineOP::fMUL_I8(OP_ARGS)
{
  JasmineEA::D3_X8(jvm);
  *jvm->op[2].s8 = *jvm->op[0].s8 * *jvm->op[1].s8;
}

void JasmineOP::fMUL_I16(OP_ARGS)
{
  JasmineEA::D3_X16(jvm);
  *jvm->op[2].s16 = *jvm->op[0].s16 * *jvm->op[1].s16;
}

void JasmineOP::fMUL_I32(OP_ARGS)
{
  JasmineEA::D3_X32(jvm);
  *jvm->op[2].s32 = *jvm->op[0].s32 * *jvm->op[1].s32;
}

void JasmineOP::fMUL_I64(OP_ARGS)
{
  JasmineEA::D3_X64(jvm);
  *jvm->op[2].s64 = *jvm->op[0].s64 * *jvm->op[1].s64;
}

void JasmineOP::fMUL_F32(OP_ARGS)
{
  JasmineEA::D3_X32(jvm);
  *jvm->op[2].f32 = *jvm->op[0].f32 * *jvm->op[1].f32;
}

void JasmineOP::fMUL_F64(OP_ARGS)
{
  JasmineEA::D3_X64(jvm);
  *jvm->op[2].f64 = *jvm->op[0].f64 * *jvm->op[1].f64;
}

/////////////////////////////////////////////////////////////////////////////////////

void JasmineOP::fDIV_I8(OP_ARGS)
{
  JasmineEA::D3_X8(jvm);
  if (*jvm->op[1].s8)
    *jvm->op[2].s8 = *jvm->op[0].s8 / *jvm->op[1].s8;
  else
    jvm->exitReg = Jasmine::MATH_DIVBYZERO;
}

void JasmineOP::fDIV_I16(OP_ARGS)
{
  JasmineEA::D3_X16(jvm);
  if (*jvm->op[1].s16)
    *jvm->op[2].s16 = *jvm->op[0].s16 / *jvm->op[1].s16;
  else
    jvm->exitReg = Jasmine::MATH_DIVBYZERO;
}

void JasmineOP::fDIV_I32(OP_ARGS)
{
  JasmineEA::D3_X32(jvm);
  if (*jvm->op[1].s32)
    *jvm->op[2].s32 = *jvm->op[0].s32 / *jvm->op[1].s32;
  else
    jvm->exitReg = Jasmine::MATH_DIVBYZERO;
}

void JasmineOP::fDIV_I64(OP_ARGS)
{
  JasmineEA::D3_X64(jvm);
  if (*jvm->op[1].s64)
    *jvm->op[2].s64 = *jvm->op[0].s64 / *jvm->op[1].s64;
  else
    jvm->exitReg = Jasmine::MATH_DIVBYZERO;
}

void JasmineOP::fDIV_F32(OP_ARGS)
{
  JasmineEA::D3_X32(jvm);
    *jvm->op[2].f32 = *jvm->op[0].f32 / *jvm->op[1].f32;
}

void JasmineOP::fDIV_F64(OP_ARGS)
{
  JasmineEA::D3_X64(jvm);
    *jvm->op[2].f64 = *jvm->op[0].f64 / *jvm->op[1].f64;
}

/////////////////////////////////////////////////////////////////////////////////////

void JasmineOP::fMOD_I8(OP_ARGS)
{
  JasmineEA::D3_X8(jvm);
  if (*jvm->op[1].s8)
    *jvm->op[2].s8 = *jvm->op[0].s8 % *jvm->op[1].s8;
  else
    jvm->exitReg = Jasmine::MATH_DIVBYZERO;
}

void JasmineOP::fMOD_I16(OP_ARGS)
{
  JasmineEA::D3_X16(jvm);
  if (*jvm->op[1].s16)
    *jvm->op[2].s16 = *jvm->op[0].s16 % *jvm->op[1].s16;
  else
    jvm->exitReg = Jasmine::MATH_DIVBYZERO;
}

void JasmineOP::fMOD_I32(OP_ARGS)
{
  JasmineEA::D3_X32(jvm);
  if (*jvm->op[1].s32)
    *jvm->op[2].s32 = *jvm->op[0].s32 % *jvm->op[1].s32;
  else
    jvm->exitReg = Jasmine::MATH_DIVBYZERO;
}

void JasmineOP::fMOD_I64(OP_ARGS)
{
  JasmineEA::D3_X64(jvm);
  if (*jvm->op[1].s64)
    *jvm->op[2].s64 = *jvm->op[0].s64 % *jvm->op[1].s64;
  else
    jvm->exitReg = Jasmine::MATH_DIVBYZERO;
}

void JasmineOP::fMOD_F32(OP_ARGS)
{
  JasmineEA::D3_X32(jvm);
  *jvm->op[2].f32 = (float32)fmod(*jvm->op[0].f32, *jvm->op[1].f32);
}

void JasmineOP::fMOD_F64(OP_ARGS)
{
  JasmineEA::D3_X64(jvm);
  *jvm->op[2].f64 = fmod(*jvm->op[0].f64, *jvm->op[1].f64);
}

/////////////////////////////////////////////////////////////////////////////////////

void JasmineOP::fMUL_U8(OP_ARGS)
{
  JasmineEA::D3_X8(jvm);
  *jvm->op[2].u8 = *jvm->op[0].u8 * *jvm->op[1].u8;
}

void JasmineOP::fMUL_U16(OP_ARGS)
{
  JasmineEA::D3_X16(jvm);
  *jvm->op[2].u16 = *jvm->op[0].u16 * *jvm->op[1].u16;
}

void JasmineOP::fMUL_U32(OP_ARGS)
{
  JasmineEA::D3_X32(jvm);
  *jvm->op[2].u32 = *jvm->op[0].u32 * *jvm->op[1].u32;
}

void JasmineOP::fMUL_U64(OP_ARGS)
{
  JasmineEA::D3_X64(jvm);
  *jvm->op[2].u64 = *jvm->op[0].u64 * *jvm->op[1].u64;
}

void JasmineOP::fDIV_U8(OP_ARGS)
{
  JasmineEA::D3_X8(jvm);
  if (*jvm->op[1].u8)
    *jvm->op[2].u8 = *jvm->op[0].u8 / *jvm->op[1].u8;
  else
    jvm->exitReg = Jasmine::MATH_DIVBYZERO;
}

void JasmineOP::fDIV_U16(OP_ARGS)
{
  JasmineEA::D3_X16(jvm);
  if (*jvm->op[1].u16)
    *jvm->op[2].u16 = *jvm->op[0].u16 / *jvm->op[1].u16;
  else
    jvm->exitReg = Jasmine::MATH_DIVBYZERO;
}

void JasmineOP::fDIV_U32(OP_ARGS)
{
  JasmineEA::D3_X32(jvm);
  if (*jvm->op[1].u32)
    *jvm->op[2].u32 = *jvm->op[0].u32 / *jvm->op[1].u32;
  else
    jvm->exitReg = Jasmine::MATH_DIVBYZERO;
}

void JasmineOP::fDIV_U64(OP_ARGS)
{
  JasmineEA::D3_X64(jvm);
  if (*jvm->op[1].u64)
    *jvm->op[2].u64 = *jvm->op[0].u64 / *jvm->op[1].u64;
  else
    jvm->exitReg = Jasmine::MATH_DIVBYZERO;
}

/////////////////////////////////////////////////////////////////////////////////////

void JasmineOP::fMOD_U8(OP_ARGS)
{
  JasmineEA::D3_X8(jvm);
  if (*jvm->op[1].u8)
    *jvm->op[2].u8 = *jvm->op[0].u8 % *jvm->op[1].u8;
  else
    jvm->exitReg = Jasmine::MATH_DIVBYZERO;
}

void JasmineOP::fMOD_U16(OP_ARGS)
{
  JasmineEA::D3_X16(jvm);
  if (*jvm->op[1].u16)
    *jvm->op[2].u16 = *jvm->op[0].u16 % *jvm->op[1].u16;
  else
    jvm->exitReg = Jasmine::MATH_DIVBYZERO;
}

void JasmineOP::fMOD_U32(OP_ARGS)
{
  JasmineEA::D3_X32(jvm);
  if (*jvm->op[1].u32)
    *jvm->op[2].u32 = *jvm->op[0].u32 % *jvm->op[1].u32;
  else
    jvm->exitReg = Jasmine::MATH_DIVBYZERO;
}

void JasmineOP::fMOD_U64(OP_ARGS)
{
  JasmineEA::D3_X8(jvm);
  if (*jvm->op[1].u64)
    *jvm->op[2].u64 = *jvm->op[0].u64 % *jvm->op[1].u64;
  else
    jvm->exitReg = Jasmine::MATH_DIVBYZERO;
}

/////////////////////////////////////////////////////////////////////////////////////

void JasmineOP::fNEG_I8(OP_ARGS)
{
  JasmineEA::D2_X8(jvm);
  *jvm->op[1].s8 = -(*jvm->op[0].s8);
}

void JasmineOP::fNEG_I16(OP_ARGS)
{
  JasmineEA::D2_X16(jvm);
  *jvm->op[1].s16 = -(*jvm->op[0].s16);
}

void JasmineOP::fNEG_I32(OP_ARGS)
{
  JasmineEA::D2_X32(jvm);
  *jvm->op[1].s32 = -(*jvm->op[0].s32);
}

void JasmineOP::fNEG_I64(OP_ARGS)
{
  JasmineEA::D2_X64(jvm);
  *jvm->op[1].s64 = -(*jvm->op[0].s64);
}

void JasmineOP::fNEG_F32(OP_ARGS)
{
  JasmineEA::D2_X32(jvm);
  *jvm->op[1].f32 = -(*jvm->op[0].f32);
}

void JasmineOP::fNEG_F64(OP_ARGS)
{
  JasmineEA::D2_X64(jvm);
  *jvm->op[1].f64 = -(*jvm->op[0].f64);
}

/////////////////////////////////////////////////////////////////////////////////////

void JasmineOP::fSHL_I8(OP_ARGS)
{
  JasmineEA::D3_X8(jvm);
  *jvm->op[2].s8 = (*jvm->op[0].s8) << (*jvm->op[1].s8);
}

void JasmineOP::fSHL_I16(OP_ARGS)
{
  JasmineEA::D3_X16(jvm);
  *jvm->op[2].s16 = (*jvm->op[0].s16) << (*jvm->op[1].s16);
}

void JasmineOP::fSHL_I32(OP_ARGS)
{
  JasmineEA::D3_X32(jvm);
  *jvm->op[2].s32 = (*jvm->op[0].s32) << (*jvm->op[1].s32);
}

void JasmineOP::fSHL_I64(OP_ARGS)
{
  JasmineEA::D3_X64(jvm);
  *jvm->op[2].s64 = (*jvm->op[0].s64) << (*jvm->op[1].s64);
}

/////////////////////////////////////////////////////////////////////////////////////

void JasmineOP::fSHR_I8(OP_ARGS)
{
  JasmineEA::D3_X8(jvm);
  *jvm->op[2].s8 = (*jvm->op[0].s8) >> (*jvm->op[1].s8);
}

void JasmineOP::fSHR_I16(OP_ARGS)
{
  JasmineEA::D3_X16(jvm);
  *jvm->op[2].s16 = (*jvm->op[0].s16) >> (*jvm->op[1].s16);
}

void JasmineOP::fSHR_I32(OP_ARGS)
{
  JasmineEA::D3_X32(jvm);
  *jvm->op[2].s32 = (*jvm->op[0].s32) >> (*jvm->op[1].s32);
}

void JasmineOP::fSHR_I64(OP_ARGS)
{
  JasmineEA::D3_X64(jvm);
  *jvm->op[2].s64 = (*jvm->op[0].s64) >> (*jvm->op[1].s64);
}

/////////////////////////////////////////////////////////////////////////////////////

#else // #ifndef JasmineMACRO_EA

/////////////////////////////////////////////////////////////////////////////////////
//
//  Interleaved EA version, operand pointers generated on demand
//
/////////////////////////////////////////////////////////////////////////////////////

void JasmineOP::fADD_I8(OP_ARGS)
{
  OPINIT();
  OP3_8(sint8) = OP1_8(sint8) + OP2_8(sint8);
  OPDONE();
}

void JasmineOP::fADD_I16(OP_ARGS)
{
  OPINIT();
  OP3_16(sint16) = OP1_16(sint16) + OP2_16(sint16);
  OPDONE();
}

void JasmineOP::fADD_I32(OP_ARGS)
{
  OPINIT();
  OP3_32(sint32) = OP1_32(sint32) + OP2_32(sint32);
  OPDONE();
}

void JasmineOP::fADD_I64(OP_ARGS)
{
  OPINIT();
  OP3_64(sint64) = OP1_64(sint64) + OP2_64(sint64);
  OPDONE();
}

void JasmineOP::fADD_F32(OP_ARGS)
{
  OPINIT();
  OP3_32(float32) = OP1_32(float32) + OP2_32(float32);
  OPDONE();
}

void JasmineOP::fADD_F64(OP_ARGS)
{
  OPINIT();
  OP3_64(float64) = OP1_64(float64) + OP2_64(float64);
  OPDONE();
}


/////////////////////////////////////////////////////////////////////////////////////


void JasmineOP::fSUB_I8(OP_ARGS)
{
  OPINIT();
  OP3_8(sint8) = OP1_8(sint8) - OP2_8(sint8);
  OPDONE();
}

void JasmineOP::fSUB_I16(OP_ARGS)
{
  OPINIT();
  OP3_16(sint16) = OP1_16(sint16) - OP2_16(sint16);
  OPDONE();
}

void JasmineOP::fSUB_I32(OP_ARGS)
{
  OPINIT();
  OP3_32(sint32) = OP1_32(sint32) - OP2_32(sint32);
  OPDONE();
}

void JasmineOP::fSUB_I64(OP_ARGS)
{
  OPINIT();
  OP3_64(sint64) = OP1_64(sint64) - OP2_64(sint64);
  OPDONE();
}

void JasmineOP::fSUB_F32(OP_ARGS)
{
  OPINIT();
  OP3_32(float32) = OP1_32(float32) - OP2_32(float32);
  OPDONE();
}

void JasmineOP::fSUB_F64(OP_ARGS)
{
  OPINIT();
  OP3_64(float64) = OP1_64(float64) - OP2_64(float64);
  OPDONE();
}


/////////////////////////////////////////////////////////////////////////////////////


void JasmineOP::fMUL_I8(OP_ARGS)
{
  OPINIT();
  OP3_8(sint8) = OP1_8(sint8) * OP2_8(sint8);
  OPDONE();
}

void JasmineOP::fMUL_I16(OP_ARGS)
{
  OPINIT();
  OP3_16(sint16) = OP1_16(sint16) * OP2_16(sint16);
  OPDONE();
}

void JasmineOP::fMUL_I32(OP_ARGS)
{
  OPINIT();
  OP3_32(sint32) = OP1_32(sint32) * OP2_32(sint32);
  OPDONE();
}

void JasmineOP::fMUL_I64(OP_ARGS)
{
  OPINIT();
  OP3_64(sint64) = OP1_64(sint64) * OP2_64(sint64);
  OPDONE();
}

void JasmineOP::fMUL_F32(OP_ARGS)
{
  OPINIT();
  OP3_32(float32) = OP1_32(float32) * OP2_32(float32);
  OPDONE();
}

void JasmineOP::fMUL_F64(OP_ARGS)
{
  OPINIT();
  OP3_64(float64) = OP1_64(float64) * OP2_64(float64);
  OPDONE();
}

/////////////////////////////////////////////////////////////////////////////////////

void JasmineOP::fDIV_I8(OP_ARGS)
{
  OPINIT();
  sint8 d = OP1_8(sint8);
  if (d)
    OP3_8(sint8) = OP1_8(sint8) / d;
  else
    jvm->exitReg = Jasmine::MATH_DIVBYZERO;
  OPDONE();
}

void JasmineOP::fDIV_I16(OP_ARGS)
{
  OPINIT();
  sint16 d = OP1_16(sint16);
  if (d)
    OP3_16(sint16) = OP1_16(sint16) / d;
  else
    jvm->exitReg = Jasmine::MATH_DIVBYZERO;
  OPDONE();
}

void JasmineOP::fDIV_I32(OP_ARGS)
{
  OPINIT();
  sint32 d = OP1_32(sint32);
  if (d)
    OP3_32(sint32) = OP1_32(sint32) / d;
  else
    jvm->exitReg = Jasmine::MATH_DIVBYZERO;
  OPDONE();
}

void JasmineOP::fDIV_I64(OP_ARGS)
{
  OPINIT();
  sint64 d = OP1_64(sint64);
  if (d)
    OP3_64(sint64) = OP1_64(sint64) / d;
  else
    jvm->exitReg = Jasmine::MATH_DIVBYZERO;
  OPDONE();
}

void JasmineOP::fDIV_F32(OP_ARGS)
{
  OPINIT();
  OP3_32(float32) = OP1_32(float32) / OP2_32(float32);
  OPDONE();
}

void JasmineOP::fDIV_F64(OP_ARGS)
{
  OPINIT();
  OP3_64(float64) = OP1_64(float64) / OP2_64(float64);
  OPDONE();
}

/////////////////////////////////////////////////////////////////////////////////////


void JasmineOP::fMOD_I8(OP_ARGS)
{
  OPINIT();
  sint8 d = OP1_8(sint8);
  if (d)
    OP3_8(sint8) = OP1_8(sint8) % d;
  else
    jvm->exitReg = Jasmine::MATH_DIVBYZERO;
  OPDONE();
}

void JasmineOP::fMOD_I16(OP_ARGS)
{
  OPINIT();
  sint16 d = OP1_16(sint16);
  if (d)
    OP3_16(sint16) = OP1_16(sint16) % d;
  else
    jvm->exitReg = Jasmine::MATH_DIVBYZERO;
  OPDONE();
}

void JasmineOP::fMOD_I32(OP_ARGS)
{
  OPINIT();
  sint32 d = OP1_32(sint32);
  if (d)
    OP3_32(sint32) = OP1_32(sint32) % d;
  else
    jvm->exitReg = Jasmine::MATH_DIVBYZERO;
  OPDONE();
}

void JasmineOP::fMOD_I64(OP_ARGS)
{
  OPINIT();
  sint64 d = OP1_64(sint64);
  if (d)
    OP3_64(sint64) = OP1_64(sint64) % d;
  else
    jvm->exitReg = Jasmine::MATH_DIVBYZERO;
  OPDONE();
}

void JasmineOP::fMOD_F32(OP_ARGS)
{
  OPINIT();
  OP3_32(float32) = (float32) fmod(OP1_32(float32), OP2_32(float32));
  OPDONE();
}

void JasmineOP::fMOD_F64(OP_ARGS)
{
  OPINIT();
  OP3_64(float64) = fmod(OP1_64(float64), OP2_64(float64));
  OPDONE();
}

/////////////////////////////////////////////////////////////////////////////////////

void JasmineOP::fMUL_U8(OP_ARGS)
{
  OPINIT();
  OP3_8(uint8) = OP1_8(uint8) * OP2_8(uint8);
  OPDONE();
}

void JasmineOP::fMUL_U16(OP_ARGS)
{
  OPINIT();
  OP3_16(uint16) = OP1_16(uint16) * OP2_16(uint16);
  OPDONE();
}

void JasmineOP::fMUL_U32(OP_ARGS)
{
  OPINIT();
  OP3_32(uint32) = OP1_32(uint32) * OP2_32(uint32);
  OPDONE();
}

void JasmineOP::fMUL_U64(OP_ARGS)
{
  OPINIT();
  OP3_64(uint64) = OP1_64(uint64) * OP2_64(uint64);
  OPDONE();
}

/////////////////////////////////////////////////////////////////////////////////////

void JasmineOP::fDIV_U8(OP_ARGS)
{
  OPINIT();
  uint8 d = OP1_8(uint8);
  if (d)
    OP3_8(uint8) = OP1_8(uint8) / d;
  else
    jvm->exitReg = Jasmine::MATH_DIVBYZERO;
  OPDONE();
}

void JasmineOP::fDIV_U16(OP_ARGS)
{
  OPINIT();
  uint16 d = OP1_16(uint16);
  if (d)
    OP3_16(uint16) = OP1_16(uint16) / d;
  else
    jvm->exitReg = Jasmine::MATH_DIVBYZERO;
  OPDONE();
}

void JasmineOP::fDIV_U32(OP_ARGS)
{
  OPINIT();
  uint32 d = OP1_32(uint32);
  if (d)
    OP3_32(uint32) = OP1_32(uint32) / d;
  else
    jvm->exitReg = Jasmine::MATH_DIVBYZERO;
  OPDONE();
}

void JasmineOP::fDIV_U64(OP_ARGS)
{
  OPINIT();
  uint64 d = OP1_64(uint64);
  if (d)
    OP3_64(uint64) = OP1_64(uint64) / d;
  else
    jvm->exitReg = Jasmine::MATH_DIVBYZERO;
  OPDONE();
}

/////////////////////////////////////////////////////////////////////////////////////

void JasmineOP::fMOD_U8(OP_ARGS)
{
  OPINIT();
  uint8 d = OP1_8(uint8);
  if (d)
    OP3_8(uint8) = OP1_8(uint8) % d;
  else
    jvm->exitReg = Jasmine::MATH_DIVBYZERO;
  OPDONE();
}

void JasmineOP::fMOD_U16(OP_ARGS)
{
  OPINIT();
  uint16 d = OP1_16(uint16);
  if (d)
    OP3_16(uint16) = OP1_16(uint16) % d;
  else
    jvm->exitReg = Jasmine::MATH_DIVBYZERO;
  OPDONE();
}

void JasmineOP::fMOD_U32(OP_ARGS)
{
  OPINIT();
  uint32 d = OP1_32(uint32);
  if (d)
    OP3_32(uint32) = OP1_32(uint32) % d;
  else
    jvm->exitReg = Jasmine::MATH_DIVBYZERO;
  OPDONE();
}

void JasmineOP::fMOD_U64(OP_ARGS)
{
  OPINIT();
  uint64 d = OP1_64(uint64);
  if (d)
    OP3_64(uint64) = OP1_64(uint64) % d;
  else
    jvm->exitReg = Jasmine::MATH_DIVBYZERO;
  OPDONE();
}

/////////////////////////////////////////////////////////////////////////////////////

void JasmineOP::fNEG_I8(OP_ARGS)
{
  OPINIT();
  OP2D_8(sint8) = -(OP1_8(sint8));
  OPDONE();
}

void JasmineOP::fNEG_I16(OP_ARGS)
{
  OPINIT();
  OP2D_16(sint16) = -(OP1_16(sint16));
  OPDONE();
}

void JasmineOP::fNEG_I32(OP_ARGS)
{
  OPINIT();
  OP2D_32(sint32) = -(OP1_32(sint32));
  OPDONE();
}

void JasmineOP::fNEG_I64(OP_ARGS)
{
  OPINIT();
  OP2D_64(sint64) = -(OP1_64(sint64));
  OPDONE();
}

void JasmineOP::fNEG_F32(OP_ARGS)
{
  OPINIT();
  OP2D_32(float32) = -(OP1_32(float32));
  OPDONE();
}

void JasmineOP::fNEG_F64(OP_ARGS)
{
  OPINIT();
  OP2D_64(float64) = -(OP1_64(float64));
  OPDONE();
}

/////////////////////////////////////////////////////////////////////////////////////

void JasmineOP::fSHL_I8(OP_ARGS)
{
  OPINIT();
  OP3_8(sint8) = OP1_8(sint8) << OP2_8(sint8);
  OPDONE();
}

void JasmineOP::fSHL_I16(OP_ARGS)
{
  OPINIT();
  OP3_16(sint16) = OP1_16(sint16) << OP2_16(sint16);
  OPDONE();
}

void JasmineOP::fSHL_I32(OP_ARGS)
{
  OPINIT();
  OP3_32(sint32) = OP1_32(sint32) << OP2_32(sint32);
  OPDONE();
}

void JasmineOP::fSHL_I64(OP_ARGS)
{
  OPINIT();
  OP3_64(sint64) = OP1_64(sint64) << OP2_64(sint16);
  OPDONE();
}

/////////////////////////////////////////////////////////////////////////////////////

void JasmineOP::fSHR_I8(OP_ARGS)
{
  OPINIT();
  OP3_8(sint8) = OP1_8(sint8) >> OP2_8(sint8);
  OPDONE();
}

void JasmineOP::fSHR_I16(OP_ARGS)
{
  OPINIT();
  OP3_16(sint16) = OP1_16(sint16) >> OP2_16(sint16);
  OPDONE();
}

void JasmineOP::fSHR_I32(OP_ARGS)
{
  OPINIT();
  OP3_32(sint32) = OP1_32(sint32) >> OP2_32(sint32);
  OPDONE();
}

void JasmineOP::fSHR_I64(OP_ARGS)
{
  OPINIT();
  OP3_64(sint64) = OP1_64(sint64) >> OP2_64(sint16);
  OPDONE();
}


/////////////////////////////////////////////////////////////////////////////////////

#endif // #ifndef JASMINEMACRO_EA

