//****************************************************************************//
//**                                                                        **//
//** File:         proj/jasmine/jasminelogic.cpp                            **//
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

#ifndef JASMINE_MACRO_EA

/////////////////////////////////////////////////////////////////////////////////////
//
//  Seperate EA pass version, operand pointers saved in op[0] - op[2]
//
/////////////////////////////////////////////////////////////////////////////////////

void JasmineOP::fAND_X8(OP_ARGS)
{
  JasmineEA::D3_X8(jvm);
  *jvm->op[2].u8 = *jvm->op[0].u8 & *jvm->op[1].u8;
}

void JasmineOP::fAND_X16(OP_ARGS)
{
  JasmineEA::D3_X16(jvm);
  *jvm->op[2].u16 = *jvm->op[0].u16 & *jvm->op[1].u16;
}

void JasmineOP::fAND_X32(OP_ARGS)
{
  JasmineEA::D3_X32(jvm);
  *jvm->op[2].u32 = *jvm->op[0].u32 & *jvm->op[1].u32;
}

void JasmineOP::fAND_X64(OP_ARGS)
{
  JasmineEA::D3_X64(jvm);
  *jvm->op[2].u64 = *jvm->op[0].u64 & *jvm->op[1].u64;
}

/////////////////////////////////////////////////////////////////////////////////////

void JasmineOP::fOR_X8(OP_ARGS)
{
  JasmineEA::D3_X8(jvm);
  *jvm->op[2].u8 = *jvm->op[0].u8 | *jvm->op[1].u8;
}

void JasmineOP::fOR_X16(OP_ARGS)
{
  JasmineEA::D3_X16(jvm);
  *jvm->op[2].u16 = *jvm->op[0].u16 | *jvm->op[1].u16;
}

void JasmineOP::fOR_X32(OP_ARGS)
{
  JasmineEA::D3_X32(jvm);
  *jvm->op[2].u32 = *jvm->op[0].u32 | *jvm->op[1].u32;
}

void JasmineOP::fOR_X64(OP_ARGS)
{
  JasmineEA::D3_X64(jvm);
  *jvm->op[2].u64 = *jvm->op[0].u64 | *jvm->op[1].u64;
}

/////////////////////////////////////////////////////////////////////////////////////

void JasmineOP::fXOR_X8(OP_ARGS)
{
  JasmineEA::D3_X8(jvm);
  *jvm->op[2].u8 = *jvm->op[0].u32 ^ *jvm->op[1].u8;
}

void JasmineOP::fXOR_X16(OP_ARGS)
{
  JasmineEA::D3_X16(jvm);
  *jvm->op[2].u16 = *jvm->op[0].u16 ^ *jvm->op[1].u16;
}

void JasmineOP::fXOR_X32(OP_ARGS)
{
  JasmineEA::D3_X32(jvm);
  *jvm->op[2].u32 = *jvm->op[0].u32 ^ *jvm->op[1].u32;
}

void JasmineOP::fXOR_X64(OP_ARGS)
{
  JasmineEA::D3_X64(jvm);
  *jvm->op[2].u64 = *jvm->op[0].u64 ^ *jvm->op[1].u64;
}

/////////////////////////////////////////////////////////////////////////////////////

void JasmineOP::fINV_X8(OP_ARGS)
{
  JasmineEA::D2_X8(jvm);
  *jvm->op[1].u8 = ~(*jvm->op[0].u8);
}

void JasmineOP::fINV_X16(OP_ARGS)
{
  JasmineEA::D2_X16(jvm);
  *jvm->op[1].u16 = ~(*jvm->op[0].u16);
}

void JasmineOP::fINV_X32(OP_ARGS)
{
  JasmineEA::D2_X32(jvm);
  *jvm->op[1].u32 = ~(*jvm->op[0].u32);
}

void JasmineOP::fINV_X64(OP_ARGS)
{
  JasmineEA::D2_X64(jvm);
  *jvm->op[1].u64 = ~(*jvm->op[0].u64);
}

/////////////////////////////////////////////////////////////////////////////////////

void JasmineOP::fSHL_X8(OP_ARGS)
{
  JasmineEA::D3_X8(jvm);
  *jvm->op[2].u8 = (*jvm->op[0].u8) << *jvm->op[1].u8;
}

void JasmineOP::fSHL_X16(OP_ARGS)
{
  JasmineEA::D3_X16(jvm);
  *jvm->op[2].u16 = (*jvm->op[0].u16) << *jvm->op[1].u16;
}

void JasmineOP::fSHL_X32(OP_ARGS)
{
  JasmineEA::D3_X32(jvm);
  *jvm->op[2].u32 = (*jvm->op[0].u32) << *jvm->op[1].u32;
}

void JasmineOP::fSHL_X64(OP_ARGS)
{
  JasmineEA::D3_X64(jvm);
  *jvm->op[2].u64 = (*jvm->op[0].u64) << *jvm->op[1].u64;
}

/////////////////////////////////////////////////////////////////////////////////////

void JasmineOP::fSHR_X8(OP_ARGS)
{
  JasmineEA::D3_X8(jvm);
  *jvm->op[2].u8 = (*jvm->op[0].u8) >> *jvm->op[1].u8;
}

void JasmineOP::fSHR_X16(OP_ARGS)
{
  JasmineEA::D3_X16(jvm);
  *jvm->op[2].u16 = (*jvm->op[0].u16) >> *jvm->op[1].u16;
}

void JasmineOP::fSHR_X32(OP_ARGS)
{
  JasmineEA::D3_X32(jvm);
  *jvm->op[2].u32 = (*jvm->op[0].u32) >> *jvm->op[1].u32;
}

void JasmineOP::fSHR_X64(OP_ARGS)
{
  JasmineEA::D3_X64(jvm);
  *jvm->op[2].u64 = (*jvm->op[0].u64) >> *jvm->op[1].u64;
}

/////////////////////////////////////////////////////////////////////////////////////

void JasmineOP::fROL_X8(OP_ARGS)
{
  JasmineEA::D3_X8(jvm);
  ruint32 val      = (*jvm->op[0].u8);
  ruint32 shift    = (*jvm->op[1].u8)&0x7;
  *jvm->op[2].u8  = (val<<shift | val>>(8-shift));
}

void JasmineOP::fROL_X16(OP_ARGS)
{
  JasmineEA::D3_X16(jvm);
  ruint32 val      = (*jvm->op[0].u16);
  ruint32 shift    = (*jvm->op[1].u16)&0xF;
  *jvm->op[2].u16  = (val<<shift | val>>(16-shift));
}

void JasmineOP::fROL_X32(OP_ARGS)
{
  JasmineEA::D3_X32(jvm);
  ruint32 val      = (*jvm->op[0].u32);
  ruint32 shift    = (*jvm->op[1].u32)&0x1F;
  *jvm->op[2].u32  = (val<<shift | val>>(32-shift));
}

void JasmineOP::fROL_X64(OP_ARGS)
{
  JasmineEA::D3_X64(jvm);
  ruint64 val      = (*jvm->op[0].u64);
  ruint32 shift    = (*jvm->op[1].u64)&0x3F;
  *jvm->op[2].u64  = (val<<shift | val>>(64-shift));
}

/////////////////////////////////////////////////////////////////////////////////////

void JasmineOP::fROR_X8(OP_ARGS)
{
  JasmineEA::D3_X8(jvm);
  ruint32 val      = (*jvm->op[0].u8);
  ruint32 shift    = (*jvm->op[1].u8)&0x7;
  *jvm->op[2].u8  = (val>>shift | val<<(8-shift));
}

void JasmineOP::fROR_X16(OP_ARGS)
{
  JasmineEA::D3_X16(jvm);
  ruint32 val      = (*jvm->op[0].u16);
  ruint32 shift    = (*jvm->op[1].u16)&0xF;
  *jvm->op[2].u16  = (val>>shift | val<<(16-shift));
}

void JasmineOP::fROR_X32(OP_ARGS)
{
  JasmineEA::D3_X32(jvm);
  ruint32 val      = (*jvm->op[0].u32);
  ruint32 shift    = (*jvm->op[1].u32)&0x1F;
  *jvm->op[2].u32  = (val>>shift | val<<(32-shift));
}

void JasmineOP::fROR_X64(OP_ARGS)
{
  JasmineEA::D3_X64(jvm);
  ruint64 val      = (*jvm->op[0].u64);
  ruint32 shift    = (*jvm->op[1].u64)&0x3F;
  *jvm->op[2].u64  = (val>>shift | val<<(64-shift));
}

/////////////////////////////////////////////////////////////////////////////////////

#else // #ifndef JasmineMACRO_EA

/////////////////////////////////////////////////////////////////////////////////////
//
//  Interleaved EA version, operand pointers generated on demand
//
/////////////////////////////////////////////////////////////////////////////////////

void JasmineOP::fAND_X8(OP_ARGS)
{
  OPINIT();
  OP3_8(uint8) = OP1_8(uint8) & OP2_8(uint8);
  OPDONE();
}

void JasmineOP::fAND_X16(OP_ARGS)
{
  OPINIT();
  OP3_16(uint16) = OP1_16(uint16) & OP2_16(uint16);
  OPDONE();
}

void JasmineOP::fAND_X32(OP_ARGS)
{
  OPINIT();
  OP3_32(uint32) = OP1_32(uint32) & OP2_32(uint32);
  OPDONE();
}

void JasmineOP::fAND_X64(OP_ARGS)
{
  OPINIT();
  OP3_64(uint64) = OP1_64(uint64) & OP2_64(uint64);
  OPDONE();
}

/////////////////////////////////////////////////////////////////////////////////////

void JasmineOP::fOR_X8(OP_ARGS)
{
  OPINIT();
  OP3_8(uint8) = OP1_8(uint8) | OP2_8(uint8);
  OPDONE();
}

void JasmineOP::fOR_X16(OP_ARGS)
{
  OPINIT();
  OP3_16(uint16) = OP1_16(uint16) | OP2_16(uint16);
  OPDONE();
}

void JasmineOP::fOR_X32(OP_ARGS)
{
  OPINIT();
  OP3_32(uint32) = OP1_32(uint32) | OP2_32(uint32);
  OPDONE();
}

void JasmineOP::fOR_X64(OP_ARGS)
{
  OPINIT();
  OP3_64(uint64) = OP1_64(uint64) | OP2_64(uint64);
  OPDONE();
}

/////////////////////////////////////////////////////////////////////////////////////

void JasmineOP::fXOR_X8(OP_ARGS)
{
  OPINIT();
  OP3_8(uint8) = OP1_8(uint8) ^ OP2_8(uint8);
  OPDONE();
}

void JasmineOP::fXOR_X16(OP_ARGS)
{
  OPINIT();
  OP3_16(uint16) = OP1_16(uint16) ^ OP2_16(uint16);
  OPDONE();
}

void JasmineOP::fXOR_X32(OP_ARGS)
{
  OPINIT();
  OP3_32(uint32) = OP1_32(uint32) ^ OP2_32(uint32);
  OPDONE();
}

void JasmineOP::fXOR_X64(OP_ARGS)
{
  OPINIT();
  OP3_64(uint64) = OP1_64(uint64) ^ OP2_64(uint64);
  OPDONE();
}

/////////////////////////////////////////////////////////////////////////////////////

void JasmineOP::fINV_X8(OP_ARGS)
{
  OPINIT();
  OP2D_8(uint8) = ~(OP1_8(uint8));
  OPDONE();
}

void JasmineOP::fINV_X16(OP_ARGS)
{
  OPINIT();
  OP2D_16(uint16) = ~(OP1_16(uint16));
  OPDONE();
}

void JasmineOP::fINV_X32(OP_ARGS)
{
  OPINIT();
  OP2D_32(uint32) = ~(OP1_32(uint32));
  OPDONE();
}

void JasmineOP::fINV_X64(OP_ARGS)
{
  OPINIT();
  OP2D_64(uint64) = ~(OP1_64(uint64));
  OPDONE();
}

/////////////////////////////////////////////////////////////////////////////////////

void JasmineOP::fSHL_X8(OP_ARGS)
{
  OPINIT();
  OP3_8(uint8) = OP1_8(uint8) << OP2_8(uint8);
  OPDONE();
}

void JasmineOP::fSHL_X16(OP_ARGS)
{
  OPINIT();
  OP3_16(uint16) = OP1_16(uint16) << OP2_16(uint16);
  OPDONE();
}

void JasmineOP::fSHL_X32(OP_ARGS)
{
  OPINIT();
  OP3_32(uint32) = OP1_32(uint32) << OP2_32(uint32);
  OPDONE();
}

void JasmineOP::fSHL_X64(OP_ARGS)
{
  OPINIT();
  OP3_64(uint64) = OP1_64(uint64) << OP2_64(uint64);
  OPDONE();
}

/////////////////////////////////////////////////////////////////////////////////////

void JasmineOP::fSHR_X8(OP_ARGS)
{
  OPINIT();
  OP3_8(uint8) = OP1_8(uint8) >> OP2_8(uint8);
  OPDONE();
}

void JasmineOP::fSHR_X16(OP_ARGS)
{
  OPINIT();
  OP3_16(uint16) = OP1_16(uint16) >> OP2_16(uint16);
  OPDONE();
}

void JasmineOP::fSHR_X32(OP_ARGS)
{
  OPINIT();
  OP3_32(uint32) = OP1_32(uint32) >> OP2_32(uint32);
  OPDONE();
}

void JasmineOP::fSHR_X64(OP_ARGS)
{
  OPINIT();
  OP3_64(uint64) = OP1_64(uint64) >> OP2_64(uint64);
  OPDONE();
}


void JasmineOP::fROL_X8(OP_ARGS)
{
  OPINIT();
  {
    ruint32 val      = OP1_8(uint8);
    ruint32 shift    = OP2_8(uint8) & 0x7;
    OP3_8(uint8)    = (val<<shift | val>>(8-shift));
  }
  OPDONE();
}

void JasmineOP::fROL_X16(OP_ARGS)
{
  OPINIT();
  {
    ruint32 val      = OP1_16(uint16);
    ruint32 shift    = OP2_16(uint16) & 0xF;
    OP3_16(uint16)  = (val<<shift | val>>(16-shift));
  }
  OPDONE();
}

void JasmineOP::fROL_X32(OP_ARGS)
{
  OPINIT();
  {
    ruint32 val      = OP1_32(uint32);
    ruint32 shift    = OP2_32(uint32) & 0x1F;
    OP3_32(uint32)  = (val<<shift | val>>(32-shift));
  }
  OPDONE();
}

void JasmineOP::fROL_X64(OP_ARGS)
{
  OPINIT();
  {
    ruint64 val      = OP1_64(uint64);
    ruint32 shift    = OP2_64(uint64) & 0x3F;
    OP3_64(uint64)  = (val<<shift | val>>(64-shift));
  }
  OPDONE();
}

/////////////////////////////////////////////////////////////////////////////////////

void JasmineOP::fROR_X8(OP_ARGS)
{
  OPINIT();
  {
    ruint32 val      = OP1_8(uint8);
    ruint32 shift    = OP2_8(uint8) & 0x7;
    OP3_8(uint8)    = (val>>shift | val<<(8-shift));
  }
  OPDONE();
}

void JasmineOP::fROR_X16(OP_ARGS)
{
  OPINIT();
  {
    ruint32 val      = OP1_16(uint16);
    ruint32 shift    = OP2_16(uint16) & 0xF;
    OP3_16(uint16)  = (val>>shift | val<<(16-shift));
  }
  OPDONE();
}

void JasmineOP::fROR_X32(OP_ARGS)
{
  OPINIT();
  {
    ruint32 val      = OP1_32(uint32);
    ruint32 shift    = OP2_32(uint32) & 0x1F;
    OP3_32(uint32)  = (val>>shift | val<<(32-shift));
  }
  OPDONE();
}

void JasmineOP::fROR_X64(OP_ARGS)
{
  OPINIT();
  {
    ruint64 val      = OP1_64(uint64);
    ruint32 shift    = OP2_64(uint64) & 0x3F;
    OP3_64(uint64)  = (val>>shift | val<<(64-shift));
  }
  OPDONE();
}

/////////////////////////////////////////////////////////////////////////////////////


#endif // #ifndef JASMINEMACRO_EA

