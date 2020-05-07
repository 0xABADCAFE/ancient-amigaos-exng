//****************************************************************************//
//**                                                                        **//
//** File:         proj/jasmine/jasminecastuint.cpp                         **//
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

void JasmineOP::fI16_U8(OP_ARGS)
{
  JasmineEA::D2(jvm, 1,2);
  *jvm->op[1].u16 = *jvm->op[0].u8;
}

void JasmineOP::fI32_U8(OP_ARGS)
{
  JasmineEA::D2(jvm, 1,4);
  *jvm->op[1].u32 = *jvm->op[0].u8;
}

void JasmineOP::fI64_U8(OP_ARGS)
{
  JasmineEA::D2(jvm, 1,8);
  *jvm->op[1].u64 = *jvm->op[0].u8;
}

void JasmineOP::fF32_U8(OP_ARGS)
{
  JasmineEA::D2(jvm, 1,4);
  *jvm->op[1].f32 = (float32)(*jvm->op[0].u8);
}

void JasmineOP::fF64_U8(OP_ARGS)
{
  JasmineEA::D2(jvm, 1,8);
  *jvm->op[1].f64 = (float64)(*jvm->op[0].u8);
}

/////////////////////////////////////////////////////////////////////////////////////

void JasmineOP::fI32_U16(OP_ARGS)
{
  JasmineEA::D2(jvm, 2,4);
  *jvm->op[1].u32 = *jvm->op[0].u16;
}

void JasmineOP::fI64_U16(OP_ARGS)
{
  JasmineEA::D2(jvm, 2,8);
  *jvm->op[1].u64 = *jvm->op[0].u16;
}

void JasmineOP::fF32_U16(OP_ARGS)
{
  JasmineEA::D2(jvm, 2,4);
  *jvm->op[1].f32 = (float32)(*jvm->op[0].u16);
}

void JasmineOP::fF64_U16(OP_ARGS)
{
  JasmineEA::D2(jvm, 2,8);
  *jvm->op[1].f64 = (float64)(*jvm->op[0].u16);
}

/////////////////////////////////////////////////////////////////////////////////////

void JasmineOP::fI64_U32(OP_ARGS)
{
  JasmineEA::D2(jvm, 4,8);
  *jvm->op[1].u64 = *jvm->op[0].u32;
}

void JasmineOP::fF32_U32(OP_ARGS)
{
  JasmineEA::D2_X32(jvm);
  *jvm->op[1].f32 = (float32)(*jvm->op[0].u32);
}

void JasmineOP::fF64_U32(OP_ARGS)
{
  JasmineEA::D2(jvm, 4,8);
  *jvm->op[1].f64 = (float64)(*jvm->op[0].u32);
}

/////////////////////////////////////////////////////////////////////////////////////

void JasmineOP::fF32_U64(OP_ARGS)
{
  JasmineEA::D2(jvm, 8,4);
  *jvm->op[1].f32 = /*(float32)*/(*jvm->op[0].u64);
}

void JasmineOP::fF64_U64(OP_ARGS)
{
  JasmineEA::D2_X64(jvm);
  *jvm->op[1].f64 = (float64)(*jvm->op[0].u64);
}

/////////////////////////////////////////////////////////////////////////////////////

void JasmineOP::fU64_F64(OP_ARGS)
{
  JasmineEA::D2_X64(jvm);
  *jvm->op[1].u64 = (uint64)(*jvm->op[0].f64);
}

void JasmineOP::fU32_F64(OP_ARGS)
{
  JasmineEA::D2(jvm, 8,4);
  *jvm->op[1].u32 = (uint32)(*jvm->op[0].f64);
}

void JasmineOP::fU16_F64(OP_ARGS)
{
  JasmineEA::D2(jvm, 8,2);
  *jvm->op[1].u16 = (uint16)(*jvm->op[0].f64);
}

void JasmineOP::fU8_F64(OP_ARGS)
{
  JasmineEA::D2(jvm, 8,1);
  *jvm->op[1].u8 = (uint8)(*jvm->op[0].f64);
}

/////////////////////////////////////////////////////////////////////////////////////

void JasmineOP::fU64_F32(OP_ARGS)
{
  JasmineEA::D2(jvm, 4,8);
  *jvm->op[1].u64 = /*(uint64)*/(*jvm->op[0].f32);
}

void JasmineOP::fU32_F32(OP_ARGS)
{
  JasmineEA::D2_X32(jvm);
  *jvm->op[1].u32 = (uint32)(*jvm->op[0].f32);
}

void JasmineOP::fU16_F32(OP_ARGS)
{
  JasmineEA::D2(jvm, 4,2);
  *jvm->op[1].u16 = (uint16)(*jvm->op[0].f32);
}

void JasmineOP::fU8_F32(OP_ARGS)
{
  JasmineEA::D2(jvm, 4,1);
  *jvm->op[1].u8 = (sint8)(*jvm->op[0].f32);
}

/////////////////////////////////////////////////////////////////////////////////////

void JasmineOP::fI32_U64(OP_ARGS)
{
  JasmineEA::D2(jvm, 8,4);
  *jvm->op[1].u32 = (uint32)(*jvm->op[0].u64);
}

void JasmineOP::fI16_U64(OP_ARGS)
{
  JasmineEA::D2(jvm, 8,2);
  *jvm->op[1].u16 = (uint16)(*jvm->op[0].u64);
}

void JasmineOP::fI8_U64(OP_ARGS)
{
  JasmineEA::D2(jvm, 8,1);
  *jvm->op[1].u8 = (uint8)(*jvm->op[0].u64);
}

/////////////////////////////////////////////////////////////////////////////////////

void JasmineOP::fI16_U32(OP_ARGS)
{
  JasmineEA::D2(jvm, 4,2);
  *jvm->op[1].u16 = (uint16)(*jvm->op[0].u32);
}

void JasmineOP::fI8_U32(OP_ARGS)
{
  JasmineEA::D2(jvm, 4,1);
  *jvm->op[1].u8 = (uint8)(*jvm->op[0].u32);
}

/////////////////////////////////////////////////////////////////////////////////////

void JasmineOP::fI8_U16(OP_ARGS)
{
  JasmineEA::D2(jvm, 2,1);
  *jvm->op[1].u8 = (uint8)(*jvm->op[0].u16);
}

#else // #ifndef JASMINE_MACRO_EA

/////////////////////////////////////////////////////////////////////////////////////
//
//  Interleaved EA version, operand pointers generated on demand
//
/////////////////////////////////////////////////////////////////////////////////////


void JasmineOP::fI16_U8(OP_ARGS)
{
  OPINIT();
  OP2D_16(uint16) = OP1_8(uint8);
  OPDONE();
}

void JasmineOP::fI32_U8(OP_ARGS)
{
  OPINIT();
  OP2D_32(uint32) = OP1_8(uint8);
  OPDONE();
}

void JasmineOP::fI64_U8(OP_ARGS)
{
  OPINIT();
  OP2D_64(uint64) = OP1_8(uint8);
  OPDONE();
}

void JasmineOP::fF32_U8(OP_ARGS)
{
  OPINIT();
  OP2D_32(float32) = (float32)(OP1_8(uint8));
  OPDONE();
}

void JasmineOP::fF64_U8(OP_ARGS)
{
  OPINIT();
  OP2D_64(float64) = (float64)(OP1_8(uint8));
  OPDONE();
}

/////////////////////////////////////////////////////////////////////////////////////

void JasmineOP::fI32_U16(OP_ARGS)
{
  OPINIT();
  OP2D_32(uint32) = OP1_16(uint16);
  OPDONE();
}

void JasmineOP::fI64_U16(OP_ARGS)
{
  OPINIT();
  OP2D_64(uint64) = OP1_16(uint16);
  OPDONE();
}

void JasmineOP::fF32_U16(OP_ARGS)
{
  OPINIT();
  OP2D_32(float32) = (float32)(OP1_16(uint16));
  OPDONE();
}

void JasmineOP::fF64_U16(OP_ARGS)
{
  OPINIT();
  OP2D_64(float64) = (float64)(OP1_16(uint16));
  OPDONE();
}

/////////////////////////////////////////////////////////////////////////////////////

void JasmineOP::fI64_U32(OP_ARGS)
{
  OPINIT();
  OP2D_64(uint64) = OP1_32(uint32);
  OPDONE();
}

void JasmineOP::fF32_U32(OP_ARGS)
{
  OPINIT();
  OP2D_32(float32) = (float32)(OP1_32(uint32));
  OPDONE();
}

void JasmineOP::fF64_U32(OP_ARGS)
{
  OPINIT();
  OP2D_64(float64) = (float64)(OP1_32(uint32));
  OPDONE();
}

/////////////////////////////////////////////////////////////////////////////////////

void JasmineOP::fF32_U64(OP_ARGS)
{
  OPINIT();
  OP2D_32(float32) = (float32)(OP1_64(uint64));
  OPDONE();
}

void JasmineOP::fF64_U64(OP_ARGS)
{
  OPINIT();
  OP2D_64(float64) = (float64)(OP1_64(uint64));
  OPDONE();
}

/////////////////////////////////////////////////////////////////////////////////////

void JasmineOP::fU64_F64(OP_ARGS)
{
  OPINIT();
  OP2D_64(uint64) = (uint64)(OP1_64(float64));
  OPDONE();
}

void JasmineOP::fU32_F64(OP_ARGS)
{
  OPINIT();
  OP2D_32(uint32) = (uint32)(OP1_64(float64));
  OPDONE();
}

void JasmineOP::fU16_F64(OP_ARGS)
{
  OPINIT();
  OP2D_16(uint16) = (uint16)(OP1_64(float64));
  OPDONE();
}

void JasmineOP::fU8_F64(OP_ARGS)
{
  OPINIT();
  OP2D_8(uint8) = (uint8)(OP1_64(float64));
  OPDONE();
}

/////////////////////////////////////////////////////////////////////////////////////

void JasmineOP::fU64_F32(OP_ARGS)
{
  OPINIT();
  OP2D_64(uint64) = (uint64)OP1_32(float32);
  OPDONE();
}

void JasmineOP::fU32_F32(OP_ARGS)
{
  OPINIT();
  OP2D_32(uint32) = (uint32)(OP1_32(float32));
  OPDONE();
}

void JasmineOP::fU16_F32(OP_ARGS)
{
  OPINIT();
  OP2D_16(uint16) = (uint16)(OP1_32(float32));
  OPDONE();
}

void JasmineOP::fU8_F32(OP_ARGS)
{
  OPINIT();
  OP2D_8(uint8) = (uint8)(OP1_32(float32));
  OPDONE();
}

/////////////////////////////////////////////////////////////////////////////////////

void JasmineOP::fI32_U64(OP_ARGS)
{
  OPINIT();
  OP2D_32(uint32) = (uint32)(OP1_64(uint64));
  OPDONE();
}

void JasmineOP::fI16_U64(OP_ARGS)
{
  OPINIT();
  OP2D_16(uint16) = (uint16)(OP1_64(uint64));
  OPDONE();
}

void JasmineOP::fI8_U64(OP_ARGS)
{
  OPINIT();
  OP2D_8(uint8) = (uint8)(OP1_64(uint64));
  OPDONE();
}

/////////////////////////////////////////////////////////////////////////////////////

void JasmineOP::fI16_U32(OP_ARGS)
{
  OPINIT();
  OP2D_16(uint16) = (uint16)(OP1_32(uint32));
  OPDONE();
}

void JasmineOP::fI8_U32(OP_ARGS)
{
  OPINIT();
  OP2D_8(uint8) = (uint8)(OP1_32(uint32));
  OPDONE();
}

/////////////////////////////////////////////////////////////////////////////////////

void JasmineOP::fI8_U16(OP_ARGS)
{
  OPINIT();
  OP2D_8(uint8) = (uint8)(OP1_16(uint16));
  OPDONE();
}

#endif // #ifndef JASMINE_MACRO_EA

