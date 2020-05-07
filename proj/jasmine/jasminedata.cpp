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

#include "Jasmine.hpp"

void JasmineOP::fSAVE(OP_ARGS)
{
  sint32 first  = (((sint8*)jvm->instPtr)[EA1BYTE])/*&0x1F*/;
  sint32 num    = (((sint8*)jvm->instPtr)[EA2BYTE])/*&0x1F*/ - first;
  jvm->instPtr++;
  jvm->exitReg = Jasmine::pushRegs(jvm, first, num);
}

void JasmineOP::fRESTORE(OP_ARGS)
{
  sint32 first  = (((sint8*)jvm->instPtr)[EA1BYTE])/*&0x1F*/;
  sint32 num    = (((sint8*)jvm->instPtr)[EA2BYTE])/*&0x1F*/ - first;
  jvm->instPtr++;
  jvm->exitReg = Jasmine::popRegs(jvm, first, num);
}

#ifndef JASMINE_MACRO_EA

////////////////////////////////////////////////////////////////////////////////
//
//  Seperate EA pass version, operand pointers saved in op[0] - op[2]
//
////////////////////////////////////////////////////////////////////////////////

void JasmineOP::fPUSH_X8(OP_ARGS)
{
  if (jvm->stack+Jasmine::STACK_SIZE_X8 < jvm->stackTop)
  {
    JasmineEA::D1_X8(jvm);
    *jvm->stack = *jvm->op[0].u8;
    jvm->stack += Jasmine::STACK_SIZE_X8;
    *jvm->stackTrace++ = Jasmine::STACK_TRACE_8;
  }
  else
    jvm->exitReg = Jasmine::STACK_OVERFLOW;
}

void JasmineOP::fPUSH_X16(OP_ARGS)
{
  if (jvm->stack+Jasmine::STACK_SIZE_X16 < jvm->stackTop)
  {
    JasmineEA::D1_X16(jvm);
    *((uint16*)jvm->stack) = *jvm->op[0].u16;
    jvm->stack += Jasmine::STACK_SIZE_X16;
    *jvm->stackTrace++ = Jasmine::STACK_TRACE_16;
  }
  else
    jvm->exitReg = Jasmine::STACK_OVERFLOW;
}

void JasmineOP::fPUSH_X32(OP_ARGS)
{
  if (jvm->stack+Jasmine::STACK_SIZE_X32 < jvm->stackTop)
  {
    JasmineEA::D1_X32(jvm);
    *((uint32*)jvm->stack) = *jvm->op[0].u32;
    jvm->stack += Jasmine::STACK_SIZE_X32;
    *jvm->stackTrace++ = Jasmine::STACK_TRACE_32;
  }
  else
    jvm->exitReg = Jasmine::STACK_OVERFLOW;
}

void JasmineOP::fPUSH_X64(OP_ARGS)
{
  if (jvm->stack+Jasmine::STACK_SIZE_X64 < jvm->stackTop)
  {
    JasmineEA::D1_X64(jvm);
    *((uint64*)jvm->stack) = *jvm->op[0].u64;
    jvm->stack += Jasmine::STACK_SIZE_X64;
    *jvm->stackTrace++ = Jasmine::STACK_TRACE_64;
  }
  else
    jvm->exitReg = Jasmine::STACK_OVERFLOW;
}

void JasmineOP::fPOP_X8(OP_ARGS)
{
  if (jvm->stack+Jasmine::STACK_SIZE_X8 > jvm->stackBase)
  {
    JasmineEA::D1_X8(jvm);
    jvm->stack -= Jasmine::STACK_SIZE_X8;
    *jvm->op[0].u8 = *jvm->stack;
    jvm->stackTrace--;
  }
  else
    jvm->exitReg = Jasmine::STACK_UNDERFLOW;
}

void JasmineOP::fPOP_X16(OP_ARGS)
{
  if (jvm->stack+Jasmine::STACK_SIZE_X16 > jvm->stackBase)
  {
    JasmineEA::D1_X16(jvm);
    jvm->stack -= Jasmine::STACK_SIZE_X16;
    *jvm->op[0].u16 = *((uint16*)jvm->stack);
    jvm->stackTrace--;
  }
  else
    jvm->exitReg = Jasmine::STACK_UNDERFLOW;
}

void JasmineOP::fPOP_X32(OP_ARGS)
{
  if (jvm->stack+Jasmine::STACK_SIZE_X32 > jvm->stackBase)
  {
    JasmineEA::D1_X32(jvm);
    jvm->stack -= Jasmine::STACK_SIZE_X32;
    *jvm->op[0].u32 = *((uint32*)jvm->stack);
    jvm->stackTrace--;
  }
  else
    jvm->exitReg = Jasmine::STACK_UNDERFLOW;
}

void JasmineOP::fPOP_X64(OP_ARGS)
{
  if (jvm->stack+Jasmine::STACK_SIZE_X64 > jvm->stackBase)
  {
    JasmineEA::D1_X64(jvm);
    jvm->stack -= Jasmine::STACK_SIZE_X64;
    *jvm->op[0].u64 = *((uint64*)jvm->stack);
    jvm->stackTrace--;
  }
  else
    jvm->exitReg = Jasmine::STACK_UNDERFLOW;
}

////////////////////////////////////////////////////////////////////////////////

void JasmineOP::fSET_X8(OP_ARGS)
{
  JasmineEA::D2_X8_X32(jvm);
  Mem::set(jvm->op[1].u8, *jvm->op[0].u8, *jvm->op[2].s32);
}

void JasmineOP::fSET_X16(OP_ARGS)
{
  JasmineEA::D2_X16_X32(jvm);
  Mem::set16(jvm->op[1].u16, *jvm->op[0].u16, *jvm->op[2].s32);
}

void JasmineOP::fSET_X32(OP_ARGS)
{
  JasmineEA::D3_X32(jvm);
  Mem::set32(jvm->op[1].u32, *jvm->op[0].u32, *jvm->op[2].s32);
}

void JasmineOP::fSET_X64(OP_ARGS)
{
  JasmineEA::D2_X64_X32(jvm);
  Mem::set64(jvm->op[1].u64, *jvm->op[0].u64, *jvm->op[2].s32);
}

////////////////////////////////////////////////////////////////////////////////

void JasmineOP::fMOVE_X8(OP_ARGS)
{
  JasmineEA::D2_X8_X32(jvm);
  Mem::copy(jvm->op[1].u8, jvm->op[0].u8, *jvm->op[2].s32);
}

void JasmineOP::fMOVE_X16(OP_ARGS)
{
  JasmineEA::D2_X16_X32(jvm);
  Mem::copy(jvm->op[1].u16, jvm->op[0].u16, (*jvm->op[2].s32)<<1);
}

void JasmineOP::fMOVE_X32(OP_ARGS)
{
  JasmineEA::D3_X32(jvm);
  Mem::copy(jvm->op[1].u32, jvm->op[0].u32, (*jvm->op[2].s32)<<2);
}

void JasmineOP::fMOVE_X64(OP_ARGS)
{
  JasmineEA::D2_X64_X32(jvm);
  Mem::copy(jvm->op[1].u64, jvm->op[0].u64, (*jvm->op[2].s32)<<3);
}

////////////////////////////////////////////////////////////////////////////////

void  JasmineOP::fEMOV_X16(OP_ARGS)
{
  JasmineEA::D2_X16_X32(jvm);
  Mem::swap16(jvm->op[1].u16, jvm->op[0].u16, *jvm->op[2].s32);
}

void  JasmineOP::fEMOV_X32(OP_ARGS)
{
  JasmineEA::D3_X32(jvm);
  Mem::swap32(jvm->op[1].u32, jvm->op[0].u32, *jvm->op[2].s32);
}

void  JasmineOP::fEMOV_X64(OP_ARGS)
{
  JasmineEA::D2_X64_X32(jvm);
  Mem::swap64(jvm->op[1].u64, jvm->op[0].u64, *jvm->op[2].s32);
}

////////////////////////////////////////////////////////////////////////////////

void  JasmineOP::fSWAP_X8(OP_ARGS)
{
  JasmineEA::D2_X8_X32(jvm);
  ruint8*  s    = jvm->op[0].u8;
  ruint8* d    = jvm->op[1].u8;
  sint32  i    = *jvm->op[2].s32;
  while (--i)
  {
    ruint8 t = *d;
    *d++ = *s;
    *s++ = t;
  }
}

void  JasmineOP::fSWAP_X16(OP_ARGS)
{
  JasmineEA::D2_X16_X32(jvm);
  ruint16*  s    = jvm->op[0].u16;
  ruint16*  d    = jvm->op[1].u16;
  sint32    i    = *jvm->op[2].s32;
  while (--i)
  {
    ruint16 t = *d;
    *d++ = *s;
    *s++ = t;
  }
}

void  JasmineOP::fSWAP_X32(OP_ARGS)
{
  JasmineEA::D3_X32(jvm);
  ruint32*  s    = jvm->op[0].u32;
  ruint32*  d    = jvm->op[1].u32;
  sint32    i    = *jvm->op[2].s32;
  while (--i)
  {
    ruint32 t = *d;
    *d++ = *s;
    *s++ = t;
  }
}

void  JasmineOP::fSWAP_X64(OP_ARGS)
{
  JasmineEA::D2_X64_X32(jvm);
  ruint64*  s    = jvm->op[0].u64;
  ruint64*  d    = jvm->op[1].u64;
  sint32    i    = *jvm->op[2].s32;
  while (--i)
  {
    ruint64 t = *d;
    *d++ = *s;
    *s++ = t;
  }
}

////////////////////////////////////////////////////////////////////////////////

#else // JASMINE_MACRO_EA

////////////////////////////////////////////////////////////////////////////////
//
//  Interleaved EA version, operand pointers generated on demand
//
////////////////////////////////////////////////////////////////////////////////

void JasmineOP::fPUSH_X8(OP_ARGS)
{
  if (jvm->stack+Jasmine::STACK_SIZE_X8 < jvm->stackTop)
  {
    OPINIT();
    *jvm->stack = OP1_8(uint8);
    jvm->stack += Jasmine::STACK_SIZE_X8;
    *jvm->stackTrace++ = Jasmine::STACK_TRACE_8;
    OPDONE();
  }
  else
    jvm->exitReg = Jasmine::STACK_OVERFLOW;
}

void JasmineOP::fPUSH_X16(OP_ARGS)
{
  if (jvm->stack+Jasmine::STACK_SIZE_X16 < jvm->stackTop)
  {
    OPINIT();
    *((uint16*)jvm->stack) = OP1_16(uint16);
    jvm->stack += Jasmine::STACK_SIZE_X16;
    *jvm->stackTrace++ = Jasmine::STACK_TRACE_16;
    OPDONE();
  }
  else
    jvm->exitReg = Jasmine::STACK_OVERFLOW;
}

void JasmineOP::fPUSH_X32(OP_ARGS)
{
  if (jvm->stack+Jasmine::STACK_SIZE_X32 < jvm->stackTop)
  {
    OPINIT();
    *((uint32*)jvm->stack) = OP1_32(uint32);
    jvm->stack += Jasmine::STACK_SIZE_X32;
    *jvm->stackTrace++ = Jasmine::STACK_TRACE_32;
    OPDONE();
  }
  else
    jvm->exitReg = Jasmine::STACK_OVERFLOW;
}

void JasmineOP::fPUSH_X64(OP_ARGS)
{
  if (jvm->stack+Jasmine::STACK_SIZE_X64 < jvm->stackTop)
  {
    OPINIT();
    *((uint64*)jvm->stack) = OP1_64(uint64);
    jvm->stack += Jasmine::STACK_SIZE_X64;
    *jvm->stackTrace++ = Jasmine::STACK_TRACE_64;
    OPDONE();
  }
  else
    jvm->exitReg = Jasmine::STACK_OVERFLOW;
}

void JasmineOP::fPOP_X8(OP_ARGS)
{
  if (jvm->stack+Jasmine::STACK_SIZE_X8 > jvm->stackBase)
  {
    OPINIT();
    jvm->stack -= Jasmine::STACK_SIZE_X8;
    OP1D_8(uint8) = *jvm->stack;
    --jvm->stackTrace;
    OPDONE();
  }
  else
    jvm->exitReg = Jasmine::STACK_UNDERFLOW;
}

void JasmineOP::fPOP_X16(OP_ARGS)
{
  if (jvm->stack+Jasmine::STACK_SIZE_X16 > jvm->stackBase)
  {
    OPINIT();
    jvm->stack -= Jasmine::STACK_SIZE_X16;
    OP1D_16(uint16) = *((uint16*)jvm->stack);
    --jvm->stackTrace;
    OPDONE();
  }
  else
    jvm->exitReg = Jasmine::STACK_UNDERFLOW;
}

void JasmineOP::fPOP_X32(OP_ARGS)
{
  if (jvm->stack+Jasmine::STACK_SIZE_X32 > jvm->stackBase)
  {
    OPINIT();
    jvm->stack -= Jasmine::STACK_SIZE_X32;
    OP1D_32(uint32) = *((uint32*)jvm->stack);
    --jvm->stackTrace;
    OPDONE();
  }
  else
    jvm->exitReg = Jasmine::STACK_UNDERFLOW;
}

void JasmineOP::fPOP_X64(OP_ARGS)
{
  if (jvm->stack+Jasmine::STACK_SIZE_X64 > jvm->stackBase)
  {
    OPINIT();
    jvm->stack -= Jasmine::STACK_SIZE_X64;
    OP1D_64(uint64) = *((uint64*)jvm->stack);
    --jvm->stackTrace;
    OPDONE();
  }
  else
    jvm->exitReg = Jasmine::STACK_UNDERFLOW;
}

////////////////////////////////////////////////////////////////////////////////

void JasmineOP::fSET_X8(OP_ARGS)
{
  OPINIT();
  {
    ruint8    v = OP1_8(uint8);
    ruint8*    d  = POP2D_8(uint8);
    rsint32    i  = OP3_32(sint32);
    Mem::set(d, v, i);
  }
  OPDONE();
}

void JasmineOP::fSET_X16(OP_ARGS)
{
  OPINIT();
  {
    ruint16    v = OP1_16(uint16);
    ruint16*  d  = POP2D_16(uint16);
    rsint32    i  = OP3_32(sint32);
    Mem::set16(d, v, i);
  }
  OPDONE();
}

void JasmineOP::fSET_X32(OP_ARGS)
{
  OPINIT();
  {
    ruint32    v = OP1_32(uint32);
    ruint32*  d  = POP2D_32(uint32);
    rsint32    i  = OP3_32(sint32);
    Mem::set32(d, v, i);
  }
  OPDONE();
}

void JasmineOP::fSET_X64(OP_ARGS)
{
  OPINIT();
  {
    ruint64    v = OP1_64(uint64);
    ruint64*  d  = POP2D_64(uint64);
    rsint32    i  = OP3_32(sint32);
    Mem::set32(d, v, i);
  }
  OPDONE();
}

/////////////////////////////////////////////////////////////////////////////////////

void JasmineOP::fMOVE_X8(OP_ARGS)
{
  OPINIT();
  {
    ruint8*    s = POP1_8(uint8);
    ruint8*    d  = POP2D_8(uint8);
    rsint32    i  = OP3_32(sint32);
    Mem::copy(d, s, i);
  }
  OPDONE();
}

void JasmineOP::fMOVE_X16(OP_ARGS)
{
  OPINIT();
  {
    ruint16*  s = POP1_16(uint16);
    ruint16*  d  = POP2D_16(uint16);
    rsint32    i  = OP3_32(sint32);
    Mem::copy(d, s, i<<1);
  }
  OPDONE();
}

void JasmineOP::fMOVE_X32(OP_ARGS)
{
  OPINIT();
  {
    ruint32*  s = POP1_32(uint32);
    ruint32*  d  = POP2D_32(uint32);
    rsint32    i  = OP3_32(sint32);
    Mem::copy(d, s, i<<2);
  }
  OPDONE();
}

void JasmineOP::fMOVE_X64(OP_ARGS)
{
  OPINIT();
  {
    ruint64*  s = POP1_64(uint64);
    ruint64*  d  = POP2D_64(uint64);
    rsint32    i  = OP3_32(sint32);
    Mem::copy(d, s, i<<3);
  }
  OPDONE();
}

/////////////////////////////////////////////////////////////////////////////////////

void  JasmineOP::fEMOV_X16(OP_ARGS)
{
  OPINIT();
  {
    ruint8* s = POP1_8(uint8);
    ruint8* d = POP2D_8(uint8);
    rsint32  i = OP3_32(sint32);
    Mem::swap16(d, s, i);
  }
  OPDONE();
}

void  JasmineOP::fEMOV_X32(OP_ARGS)
{
  OPINIT();
  {
    ruint8* s = POP1_8(uint8);
    ruint8* d = POP2D_8(uint8);
    rsint32  i = OP3_32(sint32);
    Mem::swap32(d, s, i);
  }
  OPDONE();
}

void  JasmineOP::fEMOV_X64(OP_ARGS)
{
  OPINIT();
  {
    ruint8* s = POP1_8(uint8);
    ruint8* d = POP2D_8(uint8);
    rsint32  i = OP3_32(sint32);
    Mem::swap64(d, s, i);
  }
  OPDONE();
}

/////////////////////////////////////////////////////////////////////////////////////

void  JasmineOP::fSWAP_X8(OP_ARGS)
{
  OPINIT();
  {
    ruint8*  pa = POP1D_8(uint8);
    ruint8*  pb = POP2D_8(uint8);
    rsint32  i  = OP3_32(sint32);
    while (--i)
    {
      ruint8 t = *pb;
      *pb++ = *pa;
      *pa++ = t;
    }
  }
  OPDONE();
}

void  JasmineOP::fSWAP_X16(OP_ARGS)
{
  OPINIT();
  {
    ruint16* pa = POP1D_16(uint16);
    ruint16* pb = POP2D_16(uint16);
    rsint32  i  = OP3_32(sint32);
    while (--i)
    {
      ruint16 t = *pb;
      *pb++ = *pa;
      *pa++ = t;
    }
  }
  OPDONE();
}

void  JasmineOP::fSWAP_X32(OP_ARGS)
{
  OPINIT();
  {
    ruint32* pa = POP1D_32(uint32);
    ruint32* pb = POP2D_32(uint32);
    rsint32  i  = OP3_32(sint32);
    while (--i)
    {
      ruint32 t = *pb;
      *pb++ = *pa;
      *pa++ = t;
    }
  }
  OPDONE();
}

void  JasmineOP::fSWAP_X64(OP_ARGS)
{
  OPINIT();
  {
    ruint64* pa = POP1D_64(uint64);
    ruint64* pb = POP2D_64(uint64);
    rsint32  i  = OP3_32(sint32);
    while (--i)
    {
      ruint64 t = *pb;
      *pb++ = *pa;
      *pa++ = t;
    }
  }
  OPDONE();
}

/////////////////////////////////////////////////////////////////////////////////////


#endif // JASMINE_MACRO_EA

