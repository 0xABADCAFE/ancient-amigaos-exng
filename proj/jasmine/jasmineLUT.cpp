//****************************************************************************//
//**                                                                        **//
//** File:         proj/jasmine/jasmineLUT.cpp                              **//
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

JasmineEA::Handler JasmineEA::eaTable[256] =
{
  fR0,      fR1,      fR2,      fR3,       fR4,      fR5,      fR6,      fR7,
  fR8,      fR9,      fR10,      fR11,      fR12,      fR13,      fR14,      fR15,
  fR16,      fR17,      fR18,      fR19,      fR20,      fR21,      fR22,      fR23,
  fR24,      fR25,      fR26,      fR27,      fR28,      fR29,      fR30,      fR31,
  fIR0,      fIR1,      fIR2,      fIR3,     fIR4,      fIR5,      fIR6,      fIR7,
  fIR8,      fIR9,      fIR10,    fIR11,    fIR12,    fIR13,    fIR14,    fIR15,
  fIR16,    fIR17,    fIR18,    fIR19,    fIR20,    fIR21,    fIR22,    fIR23,
  fIR24,    fIR25,    fIR26,    fIR27,    fIR28,    fIR29,    fIR30,    fIR31,
  fLIR0,    fLIR1,    fLIR2,    fLIR3,     fLIR4,    fLIR5,    fLIR6,    fLIR7,
  fLIR8,    fLIR9,    fLIR10,    fLIR11,    fLIR12,    fLIR13,    fLIR14,    fLIR15,
  fLIR16,    fLIR17,    fLIR18,    fLIR19,    fLIR20,    fLIR21,    fLIR22,    fLIR23,
  fLIR24,    fLIR25,    fLIR26,    fLIR27,    fLIR28,    fLIR29,    fLIR30,    fLIR31,
  fLUIR0,    fLUIR1,    fLUIR2,    fLUIR3,   fLUIR4,    fLUIR5,    fLUIR6,    fLUIR7,
  fLUIR8,    fLUIR9,    fLUIR10,  fLUIR11,  fLUIR12,  fLUIR13,  fLUIR14,  fLUIR15,
  fLUIR16,  fLUIR17,  fLUIR18,  fLUIR19,  fLUIR20,  fLUIR21,  fLUIR22,  fLUIR23,
  fLUIR24,  fLUIR25,  fLUIR26,  fLUIR27,  fLUIR28,  fLUIR29,  fLUIR30,  fLUIR31,
  fIRRO,    fIRROU,
  fIRSRO,    fIRSROU,
  fCTR,
  fDS, fCDS,
  fLITERAL,
  fOFFSET_PC,
  fFUNC_TAB,
  0
};

JasmineOP::Handler JasmineOP::instTable[256] =
{
  fNOP,
  fEND,
  fSYS,
  fLEA,
  fBRA,
  fBNEQ_I8,      fBNEQ_I16,      fBNEQ_I32,      fBNEQ_I64,      fBNEQ_F32,      fBNEQ_F64,
  fBLS_I8,      fBLS_I16,        fBLS_I32,        fBLS_I64,        fBLS_F32,        fBLS_F64,
  fBLSEQ_I8,    fBLSEQ_I16,      fBLSEQ_I32,      fBLSEQ_I64,      fBLSEQ_F32,      fBLSEQ_F64,
  fBEQ_I8,      fBEQ_I16,        fBEQ_I32,        fBEQ_I64,        fBEQ_F32,        fBEQ_F64,
  fBGREQ_I8,    fBGREQ_I16,      fBGREQ_I32,      fBGREQ_I64,      fBGREQ_F32,      fBGREQ_F64,
  fBGR_I8,      fBGR_I16,        fBGR_I32,        fBGR_I64,        fBGR_F32,        fBGR_F64,

  fCALL,
  fRET,

  fPUSH_X8,      fPUSH_X16,      fPUSH_X32,      fPUSH_X64,
  fPOP_X8,      fPOP_X16,        fPOP_X32,        fPOP_X64,
  fSAVE,        fRESTORE,
  fSET_X8,      fSET_X16,        fSET_X32,        fSET_X64,
  fMOVE_X8,      fMOVE_X16,      fMOVE_X32,      fMOVE_X64,

  fEMOV_X16,    fEMOV_X32,      fEMOV_X64,
  fSWAP_X8,      fSWAP_X16,      fSWAP_X32,      fSWAP_X64,

  fI16_U8,      fI32_U8,        fI64_U8,        fF32_U8,        fF64_U8,
   fI32_U16,      fI64_U16,        fF32_U16,        fF64_U16,
  fI64_U32,      fF32_U32,        fF64_U32,
  fF32_U64,      fF64_U64,

  fI16_S8,      fI32_S8,        fI64_S8,        fF32_S8,        fF64_S8,
  fI32_S16,      fI64_S16,        fF32_S16,        fF64_S16,
  fI64_S32,      fF32_S32,        fF64_S32,
  fF32_S64,      fF64_S64,
  fF64_F32,

  fU64_F64,      fU32_F64,        fU16_F64,        fU8_F64,
  fU64_F32,      fU32_F32,        fU16_F32,        fU8_F32,

  fI32_U64,      fI16_U64,        fI8_U64,
  fI16_U32,      fI8_U32,
  fI8_U16,

  fF32_F64,      fS64_F64,        fS32_F64,      fS16_F64,          fS8_F64,
  fS64_F32,      fS32_F32,        fS16_F32,      fS8_F32,
  fI32_S64,      fI16_S64,        fI8_S64,
  fI16_S32,      fI8_S32,
  fI8_S16,

  fADD_I8,      fADD_I16,        fADD_I32,        fADD_I64,        fADD_F32,        fADD_F64,
  fSUB_I8,      fSUB_I16,        fSUB_I32,        fSUB_I64,        fSUB_F32,        fSUB_F64,

  fMUL_U8,      fMUL_U16,        fMUL_U32,        fMUL_U64,
  fMUL_I8,      fMUL_I16,        fMUL_I32,        fMUL_I64,        fMUL_F32,        fMUL_F64,
  fDIV_U8,      fDIV_U16,        fDIV_U32,        fDIV_U64,
  fDIV_I8,      fDIV_I16,        fDIV_I32,        fDIV_I64,        fDIV_F32,        fDIV_F64,
  fMOD_U8,      fMOD_U16,        fMOD_U32,        fMOD_U64,
  fMOD_I8,      fMOD_I16,        fMOD_I32,        fMOD_I64,        fMOD_F32,        fMOD_F64,

  fNEG_I8,      fNEG_I16,        fNEG_I32,        fNEG_I64,        fNEG_F32,        fNEG_F64,
  fSHL_I8,      fSHL_I16,        fSHL_I32,        fSHL_I64,
  fSHR_I8,      fSHR_I16,        fSHR_I32,        fSHR_I64,
  fAND_X8,      fAND_X16,        fAND_X32,        fAND_X64,
  fOR_X8,        fOR_X16,        fOR_X32,        fOR_X64,
  fXOR_X8,      fXOR_X16,        fXOR_X32,        fXOR_X64,
  fINV_X8,      fINV_X16,        fINV_X32,        fINV_X64,

  fSHL_X8,      fSHL_X16,        fSHL_X32,        fSHL_X64,
  fSHR_X8,      fSHR_X16,        fSHR_X32,        fSHR_X64,
  fROL_X8,      fROL_X16,        fROL_X32,        fROL_X64,
  fROR_X8,      fROR_X16,        fROR_X32,        fROR_X64,
  0
};

JasmineOP::Handler JasmineOP::sysTable[256] = {
  fSYS_OUT_U8,      fSYS_OUT_U16,        fSYS_OUT_U32,        fSYS_OUT_U64,
  fSYS_OUT_S8,      fSYS_OUT_S16,        fSYS_OUT_S32,        fSYS_OUT_S64,
  fSYS_OUT_F32,      fSYS_OUT_F64,        fSYS_OUT_STR,
  fSYS_INP_U8,      fSYS_INP_U16,        fSYS_INP_U32,        fSYS_INP_U64,
  fSYS_INP_S8,      fSYS_INP_S16,        fSYS_INP_S32,        fSYS_INP_S64,
  fSYS_INP_F32,      fSYS_INP_F64,        fSYS_INP_STR,
  fSYS_BRK,          fSYS_DUMP,          fSYS_VER,
  fSYS_NEW_X8,      fSYS_NEW_X16,        fSYS_NEW_X32,        fSYS_NEW_X64,
  fSYS_DEL_X8,      fSYS_DEL_X16,        fSYS_DEL_X32,        fSYS_DEL_X64,
  0
};

const char*  Jasmine::resultString[Jasmine::NUM_EXITCODES] =
{
  "Running",
  "Natural exit",
  "User break",
  "Divide by zero",
  "Stack overflow",
  "Stack underflow",
  "Method overflow",
  "Method underflow",
  "Reg stack overflow",
  "Reg stack underflow",
  "Illegal instruction",
  "Illegal addressing mode"
};

