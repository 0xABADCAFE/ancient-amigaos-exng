//****************************************************************************//
//**                                                                        **//
//** File:         proj/jasmine/jasmineinline.hpp                           **//
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

#ifndef _JASMINE_INLINE_HPP
#define _JASMINE_INLINE_HPP


#if (X_ENDIAN == XA_BIGENDIAN)
  // Big endian (680x0/Coldfire/PowerPC/Alpha/Delta/MIPS/ARM/SPARC/Radix...etc)
  // Instruction word layout [opbyte][ea1byte][ea2byte][ea3byte]
  #define OPBYTE 0
  #define EA1BYTE 1
  #define EA2BYTE 2
  #define EA3BYTE 3
  #define REGOFS_8 7
  #define REGOFS_16 3
  #define REGOFS_32 1
  #define REGOFS_S(x) (8-(x))
  #define REGOFS_P 1
  #define REG_MSW 0
  #define REG_LSW 1
#else
  // Little endian (x86)
  // Instruction word layout [ea3byte][ea2byte][ea1byte][opbyte]
  #define OPBYTE 3
  #define EA1BYTE 2
  #define EA2BYTE 1
  #define EA3BYTE 0
  #define REGOFS_8 0
  #define REGOFS_16 0
  #define REGOFS_32 0
  #define REGOFS_S(x) 0
  #define REGOFS_P 0
  #define REG_MSW 1
  #define REG_LSW 0
#endif

///////////////////////////////////////////////////////////////////////////////
//
//  Register access
//
///////////////////////////////////////////////////////////////////////////////

inline void*    Jasmine::GPR::data8()          {  return &u8[REGOFS_8];     }
inline void*    Jasmine::GPR::data16()        { return &u16[REGOFS_16];   }
inline void*    Jasmine::GPR::data32()        { return &u32[REGOFS_32];   }
inline void*    Jasmine::GPR::data64()        { return &u64;               }
inline void*    Jasmine::GPR::data(uint32 s)  { return &u8[REGOFS_S(s)]; }
inline char*    &Jasmine::GPR::ptrCh()        { return pch[REGOFS_P];     }
inline uint8*    &Jasmine::GPR::ptrU8()        { return pu8[REGOFS_P];     }
inline uint16*  &Jasmine::GPR::ptrU16()        { return pu16[REGOFS_P];   }
inline uint32*  &Jasmine::GPR::ptrU32()        { return pu32[REGOFS_P];   }
inline uint64*  &Jasmine::GPR::ptrU64()        { return pu64[REGOFS_P];   }
inline sint8*    &Jasmine::GPR::ptrS8()        { return ps8[REGOFS_P];     }
inline sint16*  &Jasmine::GPR::ptrS16()        { return ps16[REGOFS_P];   }
inline sint32*  &Jasmine::GPR::ptrS32()        { return ps32[REGOFS_P];   }
inline sint64*  &Jasmine::GPR::ptrS64()        { return ps64[REGOFS_P];   }
inline float32*  &Jasmine::GPR::ptrF32()        { return pf32[REGOFS_P];   }
inline float64*  &Jasmine::GPR::ptrF64()        { return pf64[REGOFS_P];   }
inline uint8&    Jasmine::GPR::valU8()          {  return u8[REGOFS_8];     }
inline uint16&  Jasmine::GPR::valU16()        { return u16[REGOFS_16];   }
inline uint32&  Jasmine::GPR::valU32()        { return u32[REGOFS_32];   }
inline uint64&  Jasmine::GPR::valU64()        { return u64;               }
inline sint8&    Jasmine::GPR::valS8()          {  return s8[REGOFS_8];     }
inline sint16&  Jasmine::GPR::valS16()        { return s16[REGOFS_16];   }
inline sint32&  Jasmine::GPR::valS32()        { return s32[REGOFS_32];   }
inline sint64&  Jasmine::GPR::valS64()        { return s64;               }
inline float32&  Jasmine::GPR::valF32()        { return f32[REGOFS_32];   }
inline float64&  Jasmine::GPR::valF64()        { return f64;               }
inline uint32    Jasmine::GPR::getMSW()        { return u32[REG_MSW];     }
inline uint32    Jasmine::GPR::getLSW()        { return u32[REG_LSW];     }

///////////////////////////////////////////////////////////////////////////////
//
//  Effective address calculation (seperate EA phase)
//
//  All combinations of 1-3 8-64 bit operands are catered for, plus a few
//  special cases. Each case is optimised for the number/size of operands
//  decoded.
//  Operands are accessed through Jasmine op[0] - op[2] after decode.
//
///////////////////////////////////////////////////////////////////////////////

inline void JasmineEA::D1_X8(EA_ARG)
{
  uint32 x = ((uint8*)jvm->instPtr)[EA1BYTE];
  if (x<JCode::IM0)
    jvm->op[0].any = eaTable[x](jvm,1);
  else
  {
    jvm->imReg[0].valU8() = x-JCode::IM0;
    jvm->op[0].any = jvm->imReg[0].data8();
  }
  jvm->instPtr++;
}

///////////////////////////////////////////////////////////////////////////////

inline void JasmineEA::D1_X16(EA_ARG)
{
  uint32 x = ((uint8*)jvm->instPtr)[EA1BYTE];
  if (x<JCode::IM0)
    jvm->op[0].any = eaTable[x](jvm,2);
  else
  {
    jvm->imReg[0].valU16() = x-JCode::IM0;
    jvm->op[0].any = jvm->imReg[0].data16();
  }
  jvm->instPtr++;
}

///////////////////////////////////////////////////////////////////////////////

inline void JasmineEA::D1_X32(EA_ARG)
{
  uint32 x = ((uint8*)jvm->instPtr)[EA1BYTE];
  if (x<JCode::IM0)
    jvm->op[0].any = eaTable[x](jvm,4);
  else
  {
    jvm->imReg[0].valU32() = x-JCode::IM0;
    jvm->op[0].any = jvm->imReg[0].data32();
  }
  jvm->instPtr++;
}

///////////////////////////////////////////////////////////////////////////////

inline void JasmineEA::D1_X64(EA_ARG)
{
  uint32 x = ((uint8*)jvm->instPtr)[EA1BYTE];
  if (x<JCode::IM0)
    jvm->op[0].any = eaTable[x](jvm,8);
  else
  {
    jvm->imReg[0].valU64() = x-JCode::IM0;
    jvm->op[0].any = jvm->imReg[0].data64();
  }
  jvm->instPtr++;
}

///////////////////////////////////////////////////////////////////////////////

inline void JasmineEA::D2(EA_2ARGS)
{
  ruint32 x = ((uint8*)jvm->instPtr)[EA1BYTE];
  if (x<JCode::IM0)
    jvm->op[0].any = eaTable[x](jvm,s1);
  else
  {
    switch(s1)
    {
      case 1:
        jvm->imReg[0].valU8() = x-JCode::IM0;
        jvm->op[0].any = jvm->imReg[0].data8();
        break;
      case 2:
        jvm->imReg[0].valU16() = x-JCode::IM0;
        jvm->op[0].any = jvm->imReg[0].data16();
        break;
      case 4:
        jvm->imReg[0].valU32() = x-JCode::IM0;
        jvm->op[0].any = jvm->imReg[0].data32();
        break;
      case 8:
        jvm->imReg[0].valU64() = x-JCode::IM0;
        jvm->op[0].any = jvm->imReg[0].data64();
        break;
    }
  }
  x = ((uint8*)jvm->instPtr)[EA2BYTE];
  jvm->op[1].any = eaTable[x](jvm,s2);
  jvm->instPtr++;
}

///////////////////////////////////////////////////////////////////////////////

inline void JasmineEA::D2_X8(EA_ARG)
{
  ruint32 x = ((uint8*)jvm->instPtr)[EA1BYTE];
  if (x<JCode::IM0)
    jvm->op[0].any = eaTable[x](jvm,1);
  else
  {
    jvm->imReg[0].valU8() = x-JCode::IM0;
    jvm->op[0].any = jvm->imReg[0].data8();
  }
  x = ((uint8*)jvm->instPtr)[EA2BYTE];
  jvm->op[1].any = eaTable[x](jvm,1);
  jvm->instPtr++;
}

///////////////////////////////////////////////////////////////////////////////

inline void JasmineEA::D2_X16(EA_ARG)
{
  ruint32 x = ((uint8*)jvm->instPtr)[EA1BYTE];
  if (x<JCode::IM0)
    jvm->op[0].any = eaTable[x](jvm,2);
  else
  {
    jvm->imReg[0].valU16() = x-JCode::IM0;
    jvm->op[0].any = jvm->imReg[0].data16();
  }
  x = ((uint8*)jvm->instPtr)[EA2BYTE];
  jvm->op[1].any = eaTable[x](jvm,2);
  jvm->instPtr++;
}

///////////////////////////////////////////////////////////////////////////////

inline void JasmineEA::D2_X32(EA_ARG)
{
  ruint32 x = ((uint8*)jvm->instPtr)[EA1BYTE];
  if (x<JCode::IM0)
    jvm->op[0].any = eaTable[x](jvm,4);
  else
  {
    jvm->imReg[0].valU32() = x-JCode::IM0;
    jvm->op[0].any = jvm->imReg[0].data32();
  }
  x = ((uint8*)jvm->instPtr)[EA2BYTE];
  jvm->op[1].any = eaTable[x](jvm,4);
  jvm->instPtr++;
}

///////////////////////////////////////////////////////////////////////////////

inline void JasmineEA::D2_X64(EA_ARG)
{
  ruint32 x = ((uint8*)jvm->instPtr)[EA1BYTE];
  if (x<JCode::IM0)
    jvm->op[0].any = eaTable[x](jvm,8);
  else
  {
    jvm->imReg[0].valU64() = x-JCode::IM0;
    jvm->op[0].any = jvm->imReg[0].data64();
  }
  x = ((uint8*)jvm->instPtr)[EA2BYTE];
  jvm->op[1].any = eaTable[x](jvm,8);
  jvm->instPtr++;
}

///////////////////////////////////////////////////////////////////////////////

inline void JasmineEA::D2C_X8(EA_ARG)
{
  ruint32 x = ((uint8*)jvm->instPtr)[EA1BYTE];
  if (x<JCode::IM0)
    jvm->op[0].any = eaTable[x](jvm,1);
  else
  {
    jvm->imReg[0].valU8() = x-JCode::IM0;
    jvm->op[0].any = jvm->imReg[0].data8();
  }
  x = ((uint8*)jvm->instPtr)[EA2BYTE];
  if (x<JCode::IM0)
    jvm->op[1].any = eaTable[x](jvm,1);
  else
  {
    jvm->imReg[1].valU8() = x-JCode::IM0;
    jvm->op[1].any = jvm->imReg[1].data8();
  }
  jvm->instPtr++;
}

///////////////////////////////////////////////////////////////////////////////

inline void JasmineEA::D2C_X16(EA_ARG)
{
  ruint32 x = ((uint8*)jvm->instPtr)[EA2BYTE];
  if (x<JCode::IM0)
    jvm->op[0].any = eaTable[x](jvm,2);
  else
  {
    jvm->imReg[0].valU16() = x-JCode::IM0;
    jvm->op[0].any = jvm->imReg[0].data16();
  }
  x = ((uint8*)jvm->instPtr)[EA2BYTE];
  if (x<JCode::IM0)
    jvm->op[1].any = eaTable[x](jvm,2);
  else
  {
    jvm->imReg[1].valU16() = x-JCode::IM0;
    jvm->op[1].any = jvm->imReg[1].data16();
  }
  jvm->instPtr++;
}

///////////////////////////////////////////////////////////////////////////////

inline void JasmineEA::D2C_X32(EA_ARG)
{
  ruint32 x = ((uint8*)jvm->instPtr)[EA1BYTE];
  if (x<JCode::IM0)
    jvm->op[0].any = eaTable[x](jvm,4);
  else
  {
    jvm->imReg[0].valU32() = x-JCode::IM0;
    jvm->op[0].any = jvm->imReg[0].data32();
  }
  x = ((uint8*)jvm->instPtr)[EA2BYTE];
  if (x<JCode::IM0)
    jvm->op[1].any = eaTable[x](jvm,4);
  else
  {
    jvm->imReg[1].valU32() = x-JCode::IM0;
    jvm->op[1].any = jvm->imReg[1].data32();
  }
  jvm->instPtr++;
}

///////////////////////////////////////////////////////////////////////////////

inline void JasmineEA::D2C_X64(EA_ARG)
{
  ruint32 x = ((uint8*)jvm->instPtr)[EA1BYTE];
  if (x<JCode::IM0)
    jvm->op[0].any = eaTable[x](jvm,8);
  else
  {
    jvm->imReg[0].valU64() = x-JCode::IM0;
    jvm->op[0].any = jvm->imReg[0].data64();
  }
  x = ((uint8*)jvm->instPtr)[EA2BYTE];

  if (x<JCode::IM0)
    jvm->op[1].any = eaTable[x](jvm,8);
  else
  {
    jvm->imReg[1].valU64() = x-JCode::IM0;
    jvm->op[1].any = jvm->imReg[1].data64();
  }
  jvm->instPtr++;
}

///////////////////////////////////////////////////////////////////////////////

inline void JasmineEA::D3_X8(EA_ARG)
{
  ruint32 x = ((uint8*)jvm->instPtr)[EA1BYTE];
  if (x<JCode::IM0)
    jvm->op[0].any = eaTable[x](jvm,1);
  else
  {
    jvm->imReg[0].valU8() = x-JCode::IM0;
    jvm->op[0].any = jvm->imReg[0].data8();
  }
  x = ((uint8*)jvm->instPtr)[EA2BYTE];
  if (x<JCode::IM0)
    jvm->op[1].any = eaTable[x](jvm,1);
  else
  {
    jvm->imReg[1].valU8() = x-JCode::IM0;
    jvm->op[1].any = jvm->imReg[1].data8();
  }
  x = ((uint8*)jvm->instPtr)[EA3BYTE];
  jvm->op[2].any = eaTable[x](jvm,1);
  jvm->instPtr++;
}

///////////////////////////////////////////////////////////////////////////////

inline void JasmineEA::D3_X16(EA_ARG)
{
  ruint32 x = ((uint8*)jvm->instPtr)[EA1BYTE];
  if (x<JCode::IM0)
    jvm->op[0].any = eaTable[x](jvm,2);
  else
  {
    jvm->imReg[0].valU16() = x-JCode::IM0;
    jvm->op[0].any = jvm->imReg[0].data16();
  }

  x = ((uint8*)jvm->instPtr)[EA2BYTE];
  if (x<JCode::IM0)
    jvm->op[1].any = eaTable[x](jvm,2);
  else
  {
    jvm->imReg[1].valU16() = x-JCode::IM0;
    jvm->op[1].any = jvm->imReg[1].data16();
  }

  x = ((uint8*)jvm->instPtr)[EA3BYTE];
  jvm->op[2].any = eaTable[x](jvm,2);
  jvm->instPtr++;
}

///////////////////////////////////////////////////////////////////////////////

inline void JasmineEA::D3_X32(EA_ARG)
{
  ruint32 x = ((uint8*)jvm->instPtr)[EA1BYTE];
  if (x<JCode::IM0)
    jvm->op[0].any = eaTable[x](jvm,4);
  else
  {
    jvm->imReg[0].valU32() = x-JCode::IM0;
    jvm->op[0].any = jvm->imReg[0].data32();
  }
  x = ((uint8*)jvm->instPtr)[EA2BYTE];
  if (x<JCode::IM0)
    jvm->op[1].any = eaTable[x](jvm,4);
  else
  {
    jvm->imReg[1].valU32() = x-JCode::IM0;
    jvm->op[1].any = jvm->imReg[1].data32();
  }
  x = ((uint8*)jvm->instPtr)[EA3BYTE];
  jvm->op[2].any = eaTable[x](jvm,4);
  jvm->instPtr++;
}

///////////////////////////////////////////////////////////////////////////////

inline void JasmineEA::D3_X64(EA_ARG)
{
  ruint32 x = ((uint8*)jvm->instPtr)[EA1BYTE];
  if (x<JCode::IM0)
    jvm->op[0].any = eaTable[x](jvm,8);
  else
  {
    jvm->imReg[0].valU64() = x-JCode::IM0;
    jvm->op[0].any = jvm->imReg[0].data64();
  }
  x = ((uint8*)jvm->instPtr)[EA2BYTE];
  if (x<JCode::IM0)
    jvm->op[1].any = eaTable[x](jvm,8);
  else
  {
    jvm->imReg[1].valU64() = x-JCode::IM0;
    jvm->op[1].any = jvm->imReg[1].data64();
  }
  x = ((uint8*)jvm->instPtr)[EA3BYTE];
  jvm->op[2].any = eaTable[x](jvm,8);
  jvm->instPtr++;
}

///////////////////////////////////////////////////////////////////////////////

//inline void JasmineEA::D2_X8_X32(EA_2ARGS)
inline void JasmineEA::D2_X8_X32(EA_ARG)
{
  ruint32 x = ((uint8*)jvm->instPtr)[EA1BYTE];
  if (x<JCode::IM0)
    jvm->op[0].any = eaTable[x](jvm,1);
  else
  {
    jvm->imReg[0].valU8() = x-JCode::IM0;
    jvm->op[0].any = jvm->imReg[0].data8();
  }
  x = ((uint8*)jvm->instPtr)[EA2BYTE];
  if (x<JCode::IM0)
    jvm->op[1].any = eaTable[x](jvm,1);
  else
  {
    jvm->imReg[1].valU8() = x-JCode::IM0;
    jvm->op[1].any = jvm->imReg[1].data8();
  }

  x = ((uint8*)jvm->instPtr)[EA3BYTE];;
  if (x<JCode::IM0)
    jvm->op[2].any = eaTable[x](jvm,4);
  else
  {
    jvm->imReg[2].valS32() = x-JCode::IM0;
    jvm->op[2].any = jvm->imReg[2].data32();
  }
  jvm->instPtr++;
}

///////////////////////////////////////////////////////////////////////////////

//inline void JasmineEA::D2_X16_X32(EA_2ARGS)
inline void JasmineEA::D2_X16_X32(EA_ARG)
{
  ruint32 x = ((uint8*)jvm->instPtr)[EA1BYTE];
  if (x<JCode::IM0)
    jvm->op[0].any = eaTable[x](jvm,2);
  else
  {
    jvm->imReg[0].valU16() = x-JCode::IM0;
    jvm->op[0].any = jvm->imReg[0].data16();
  }
  x = ((uint8*)jvm->instPtr)[EA2BYTE];
  if (x<JCode::IM0)
    jvm->op[1].any = eaTable[x](jvm,2);
  else
  {
    jvm->imReg[1].valU16() = x-JCode::IM0;
    jvm->op[1].any = jvm->imReg[1].data16();
  }

  x = ((uint8*)jvm->instPtr)[EA3BYTE];
  if (x<JCode::IM0)
    jvm->op[2].any = eaTable[x](jvm,4);
  else
  {
    jvm->imReg[2].valS32() = x-JCode::IM0;
    jvm->op[2].any = jvm->imReg[2].data32();
  }
  jvm->instPtr++;
}

///////////////////////////////////////////////////////////////////////////////

//inline void JasmineEA::D2_X64_X32(EA_2ARGS)
inline void JasmineEA::D2_X64_X32(EA_ARG)
{
  ruint32 x = ((uint8*)jvm->instPtr)[EA1BYTE];
  if (x<JCode::IM0)
    jvm->op[0].any = eaTable[x](jvm,8);
  else
  {
    jvm->imReg[0].valU64() = x-JCode::IM0;
    jvm->op[0].any = jvm->imReg[0].data64();
  }

  x = ((uint8*)jvm->instPtr)[EA2BYTE];
  if (x<JCode::IM0)
    jvm->op[1].any = eaTable[x](jvm,8);
  else
  {
    jvm->imReg[1].valU64() = x-JCode::IM0;
    jvm->op[1].any = jvm->imReg[1].data64();
  }

  x = ((uint8*)jvm->instPtr)[EA3BYTE];
  if (x<JCode::IM0)
    jvm->op[2].any = eaTable[x](jvm,4);
  else
  {
    jvm->imReg[2].valS32() = x-JCode::IM0;
    jvm->op[2].any = jvm->imReg[2].data32();
  }
  jvm->instPtr++;
}


///////////////////////////////////////////////////////////////////////////////
//
//  Effective address calculation (operand on demand)
//
//  Operands are accessed on demand via POPn_x(<type>) / OPn_x(<type>) macros.
//  Prior to use, the macro OPINIT() must be used. After the desired operation
//  the OPDONE() macro must be used. The Jasmine op[n] operand pointers are not
//  used.
//
//  The macros have the advantage that no additional variables are introduced
//  during code generation, no temporaries are stored in op[n] and the most
//  common EA modes are expanded inline (no handler call required).
//
//  POPn_x(<type>) Generates <type> pointer to operand n, where x is the
//  operand size. The size is explicitly included since register access
//  functions are emdedded directly within the macros (and their names can't
//  easily be derived from a sizeof() expression).
//
//  POPnD_x(<type>) As above but generates a destination-only compatible
//  operand pointer.
//
//  OPn_x(<type>) Generates the operand n (via directly dereferencing POPn_x)
//
//  OPnD_x(<type>) Generates the operand n (via directly dereferencing POPnD_x)
//
///////////////////////////////////////////////////////////////////////////////

#ifdef JASMINE_MACRO_EA
#define OPINIT()  ruint8 *p = (uint8*)jvm->instPtr, v;

#ifdef XP_AMIGAOS3_68K
  #define EAFN(x) _ea[(x)]
#else
  #define EAFN(x) JasmineEA::eaTable[(x)]
#endif

#define POP1_8(t)    ((t*)(v = p[EA1BYTE],                            \
                          v<JCode::IR0 ?                            \
                            jvm->gpRegs[v].data8() : (              \
                          v<JCode::LIR0 ?                            \
                            jvm->gpRegs[v-JCode::IR0].ptrU8() : (    \
                          v<JCode::IM0 ?                            \
                            EAFN(v)(jvm, 1) : (                      \
                          jvm->imReg[0].valU8() = v-JCode::IM0,      \
                          jvm->imReg[0].data8()))))                  \
                    )
#define POP1_16(t)  ((t*)(v = p[EA1BYTE],                            \
                          v<JCode::IR0 ?                            \
                            jvm->gpRegs[v].data16(): (              \
                          v<JCode::LIR0 ?                            \
                            jvm->gpRegs[v-JCode::IR0].ptrU16() : (  \
                          v<JCode::IM0 ?                            \
                            EAFN(v)(jvm, 2) : (                      \
                          jvm->imReg[0].valU16()= v-JCode::IM0,      \
                          jvm->imReg[0].data16()))))                \
                    )
#define POP1_32(t)  ((t*)(v = p[EA1BYTE],                            \
                          v<JCode::IR0 ?                            \
                            jvm->gpRegs[v].data32(): (              \
                          v<JCode::LIR0 ?                            \
                            jvm->gpRegs[v-JCode::IR0].ptrU32() : (  \
                          v<JCode::IM0 ?                            \
                            EAFN(v)(jvm, 4) : (                      \
                          jvm->imReg[0].valU32()= v-JCode::IM0,      \
                          jvm->imReg[0].data32()))))                \
                    )
#define POP1_64(t)  ((t*)(v = p[EA1BYTE],                            \
                          v<JCode::IR0 ?                            \
                            jvm->gpRegs[v].data64(): (              \
                          v<JCode::LIR0 ?                            \
                            jvm->gpRegs[v-JCode::IR0].ptrU64() : (  \
                          v<JCode::IM0 ?                            \
                            EAFN(v)(jvm, 8) : (                      \
                          jvm->imReg[0].valU64()= v-JCode::IM0,      \
                          jvm->imReg[0].data64()))))                \
                    )
// Scared yet? You should be :)
// Here we find a non-initializer list use of the comma operator. Impressed? You should be!
#define POP1D_8(t)  ((t*)(v = p[EA1BYTE], v<JCode::IR0 ? jvm->gpRegs[v].data8() : (EAFN(v)(jvm, 1) )))
#define POP1D_16(t)  ((t*)(v = p[EA1BYTE], v<JCode::IR0 ? jvm->gpRegs[v].data16(): (EAFN(v)(jvm, 2) )))
#define POP1D_32(t)  ((t*)(v = p[EA1BYTE], v<JCode::IR0 ? jvm->gpRegs[v].data32(): (EAFN(v)(jvm, 4) )))
#define POP1D_64(t)  ((t*)(v = p[EA1BYTE], v<JCode::IR0 ? jvm->gpRegs[v].data64(): (EAFN(v)(jvm, 8) )))

#define POP2_8(t)    ((t*)(v = p[EA2BYTE],                            \
                          v<JCode::IR0 ?                            \
                            jvm->gpRegs[v].data8() : (              \
                          v<JCode::LIR0 ?                            \
                            jvm->gpRegs[v-JCode::IR0].ptrU8() : (    \
                          v<JCode::IM0 ?                            \
                            EAFN(v)(jvm, 1) : (                      \
                          jvm->imReg[1].valU8() = v-JCode::IM0,      \
                          jvm->imReg[1].data8()))))                  \
                    )
#define POP2_16(t)  ((t*)(v = p[EA2BYTE],                            \
                          v<JCode::IR0 ?                            \
                            jvm->gpRegs[v].data16(): (              \
                          v<JCode::LIR0 ?                            \
                            jvm->gpRegs[v-JCode::IR0].ptrU16() : (  \
                          v<JCode::IM0 ?                            \
                            EAFN(v)(jvm, 2) : (                      \
                          jvm->imReg[1].valU16()= v-JCode::IM0,      \
                          jvm->imReg[1].data16()))))                \
                    )
#define POP2_32(t)  ((t*)(v = p[EA2BYTE],                            \
                          v<JCode::IR0 ?                            \
                            jvm->gpRegs[v].data32(): (              \
                          v<JCode::LIR0 ?                            \
                            jvm->gpRegs[v-JCode::IR0].ptrU32() : (  \
                          v<JCode::IM0 ?                            \
                            EAFN(v)(jvm, 4) : (                      \
                          jvm->imReg[1].valU32()= v-JCode::IM0,      \
                          jvm->imReg[1].data32()))))                \
                    )
#define POP2_64(t)  ((t*)(v = p[EA2BYTE],                            \
                          v<JCode::IR0 ?                            \
                            jvm->gpRegs[v].data64(): (              \
                          v<JCode::LIR0 ?                            \
                            jvm->gpRegs[v-JCode::IR0].ptrU64() : (  \
                          v<JCode::IM0 ?                            \
                            EAFN(v)(jvm, 8) : (                      \
                          jvm->imReg[1].valU64()= v-JCode::IM0,      \
                          jvm->imReg[1].data64()))))                \
                    )

#define POP2D_8(t)  ((t*)(v = p[EA2BYTE], v<JCode::IR0 ? jvm->gpRegs[v].data8() : (EAFN(v)(jvm, 1))))
#define POP2D_16(t)  ((t*)(v = p[EA2BYTE], v<JCode::IR0 ? jvm->gpRegs[v].data16(): (EAFN(v)(jvm, 2))))
#define POP2D_32(t)  ((t*)(v = p[EA2BYTE], v<JCode::IR0 ? jvm->gpRegs[v].data32(): (EAFN(v)(jvm, 4))))
#define POP2D_64(t)  ((t*)(v = p[EA2BYTE], v<JCode::IR0 ? jvm->gpRegs[v].data64(): (EAFN(v)(jvm, 8))))
#define POP3_8(t)    ((t*)(v = p[EA3BYTE], v<JCode::IR0 ? jvm->gpRegs[v].data8() : (EAFN(v)(jvm, 1))))
#define POP3_16(t)  ((t*)(v = p[EA3BYTE], v<JCode::IR0 ? jvm->gpRegs[v].data16(): (EAFN(v)(jvm, 2))))
#define POP3_32(t)  ((t*)(v = p[EA3BYTE], v<JCode::IR0 ? jvm->gpRegs[v].data32(): (EAFN(v)(jvm, 4))))
#define POP3_64(t)  ((t*)(v = p[EA3BYTE], v<JCode::IR0 ? jvm->gpRegs[v].data64(): (EAFN(v)(jvm, 8))))
#define OP1_8(t)    (*POP1_8(t))
#define OP1_16(t)    (*POP1_16(t))
#define OP1_32(t)    (*POP1_32(t))
#define OP1_64(t)    (*POP1_64(t))
#define OP2_8(t)    (*POP2_8(t))
#define OP2_16(t)    (*POP2_16(t))
#define OP2_32(t)    (*POP2_32(t))
#define OP2_64(t)    (*POP2_64(t))
#define OP1D_8(t)    (*POP1D_8(t))
#define OP1D_16(t)  (*POP1D_16(t))
#define OP1D_32(t)  (*POP1D_32(t))
#define OP1D_64(t)  (*POP1D_64(t))
#define OP2D_8(t)    (*POP2D_8(t))
#define OP2D_16(t)  (*POP2D_16(t))
#define OP2D_32(t)  (*POP2D_32(t))
#define OP2D_64(t)  (*POP2D_64(t))
#define OP3_8(t)    (*POP3_8(t))
#define OP3_16(t)    (*POP3_16(t))
#define OP3_32(t)    (*POP3_32(t))
#define OP3_64(t)    (*POP3_64(t))
#define OPDONE()  jvm->instPtr++

#endif // JASMINE_MACRO_EA


#endif