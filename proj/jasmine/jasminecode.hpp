//****************************************************************************//
//**                                                                        **//
//** File:         proj/jasmine/jasminecode.hpp                             **//
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

#ifndef _JASMINE_CODE_HPP
#define _JASMINE_CODE_HPP


class JCode {
  public:
    enum {
      // datatypes
      U8,      U16,    U32,    U64,    S8,      S16,    S32,    S64,
      F32,    F64,
      PU8,    PU16,    PU32,    PU64,    PS8,    PS16,    PS32,    PS64,
      PF32,    PF64
    };

    enum {
      // Basic addressing modes

      // GP register value
      // Operand value = r<n>
      R0,      R1,      R2,      R3,     R4,      R5,      R6,      R7,
      R8,      R9,      R10,    R11,    R12,    R13,    R14,    R15,
      R16,    R17,    R18,    R19,    R20,    R21,    R22,    R23,
      R24,    R25,    R26,    R27,    R28,    R29,    R30,    R31,

      // GP register pointer
      // Operand value = *r<n>
      IR0,    IR1,    IR2,    IR3,     IR4,    IR5,    IR6,    IR7,
      IR8,    IR9,    IR10,    IR11,    IR12,    IR13,    IR14,    IR15,
      IR16,    IR17,    IR18,    IR19,    IR20,    IR21,    IR22,    IR23,
      IR24,    IR25,    IR26,    IR27,    IR28,    IR29,    IR30,    IR31,

      // GP register pointer, signed offset
      // Operand value = *(r<n> + offset)
      // Requires 1 extension word for offset
      LIR0,    LIR1,    LIR2,    LIR3,   LIR4,    LIR5,    LIR6,    LIR7,
      LIR8,    LIR9,    LIR10,  LIR11,  LIR12,  LIR13,  LIR14,  LIR15,
      LIR16,  LIR17,  LIR18,  LIR19,  LIR20,  LIR21,  LIR22,  LIR23,
      LIR24,  LIR25,  LIR26,  LIR27,  LIR28,  LIR29,  LIR30,  LIR31,

      // GP register pointer, signed offset with update
      // r<n> += offset, operand value = *(r<n>)
      // Requires 1 extension word for offset
      LUIR0,  LUIR1,  LUIR2,  LUIR3,   LUIR4,  LUIR5,  LUIR6,  LUIR7,
      LUIR8,  LUIR9,  LUIR10,  LUIR11,  LUIR12,  LUIR13,  LUIR14,  LUIR15,
      LUIR16,  LUIR17,  LUIR18,  LUIR19,  LUIR20,  LUIR21,  LUIR22,  LUIR23,
      LUIR24,  LUIR25,  LUIR26,  LUIR27,  LUIR28,  LUIR29,  LUIR30,  LUIR31,

      // Special address modes

      // GP register pointer, gp register signed offset / update
      // Operand value = *(r<n> + r<ofs>) [, r<n> += r<ofs>]
      // Nore : r<ofs> assumed to hold signed 32-bit integer
      // Requires 1 word extension for base and offset regs
      IRRO,    IRROU,
      IRSRO,  IRSROU,  // as above with 16-bit litetal scale

      // Count register, used for block instructions
      CTR,

      // Writable / Constant data section pointer, unsigned offset
      // Operand value = ds[offset] / cds[offset]
      // Requires 1 extension word for offset. Constant section valid as source
      // operand only
      DS, CDS,

      // Literal data in instruction stream. Signed integers < 32-bits are stored
      // as 32-bit sign extended.
      // 64-bit literal data is not allowed. 64-bit literals must be stored in the
      // constant data section of the program
      // Source operand only
      // Requires 1 word extension
      LITERAL,

      // Offset from the current PC : used for CALL only
      OFFSET_PC,

      // Registered function in the current object, used for CALL only
      FUNC_TAB,

      NUM_EA,
      REGMASK      = 0x1F,
      TYPE        = 0xE0,
      R_DIR        = 0x00,
      R_IND        = 0x20,
      R_IND_OFS    = 0x40,
      R_IND_OFSU  = 0x60,
      SPECIAL      = 0x80,

      // small literals
      IM0=224,IM1,    IM2,    IM3,     IM4,    IM5,    IM6,    IM7,
      IM8,    IM9,    IM10,    IM11,    IM12,    IM13,    IM14,    IM15,
      IM16,    IM17,    IM18,    IM19,    IM20,    IM21,    IM22,    IM23,
      IM24,    IM25,    IM26,    IM27,    IM28,    IM29,    IM30,    IM31
    };

    enum {
      NOP,
      END,
      SYS,
      LEA,    // load effective address
      BRA,    // branch

      BNEQ_I8,    BNEQ_I16,      BNEQ_I32,      BNEQ_I64,      BNEQ_F32,      BNEQ_F64,
      BLS_I8,      BLS_I16,      BLS_I32,      BLS_I64,      BLS_F32,      BLS_F64,
      BLSEQ_I8,    BLSEQ_I16,    BLSEQ_I32,    BLSEQ_I64,    BLSEQ_F32,    BLSEQ_F64,
      BEQ_I8,      BEQ_I16,      BEQ_I32,      BEQ_I64,      BEQ_F32,      BEQ_F64,
      BGREQ_I8,    BGREQ_I16,    BGREQ_I32,    BGREQ_I64,    BGREQ_F32,    BGREQ_F64,
      BGR_I8,      BGR_I16,      BGR_I32,      BGR_I64,      BGR_F32,      BGR_F64,

      CALL,
      RET,

      // Standard arg commands (1,2 operands)
      PUSH_X8,    PUSH_X16,      PUSH_X32,      PUSH_X64,
      POP_X8,      POP_X16,      POP_X32,      POP_X64,
      SAVE,        RESTORE,
      SET_X8,      SET_X16,      SET_X32,      SET_X64,
      MOVE_X8,    MOVE_X16,      MOVE_X32,      MOVE_X64,

      EMOV_X16,    EMOV_X32,      EMOV_X64,
      SWAP_X8,    SWAP_X16,      SWAP_X32,      SWAP_X64,

      // Widening type casts <dest type>_<src type>
      // Unsigned source
      I16_U8,      I32_U8,        I64_U8,        F32_U8,        F64_U8,
       I32_U16,    I64_U16,      F32_U16,      F64_U16,
      I64_U32,    F32_U32,      F64_U32,
      F32_U64,    F64_U64,

      // Signed source
      I16_S8,      I32_S8,        I64_S8,        F32_S8,        F64_S8,
      I32_S16,    I64_S16,      F32_S16,      F64_S16,
      I64_S32,    F32_S32,      F64_S32,
      F32_S64,    F64_S64,

      // Real source
      F64_F32,

      // Narrowing type casts <dest type>_<src type>
      // Real source, unsigned dest
      U64_F64,    U32_F64,      U16_F64,      U8_F64,
      U64_F32,    U32_F32,      U16_F32,      U8_F32,

      // Unsigned source
      I32_U64,    I16_U64,      I8_U64,
      I16_U32,    I8_U32,
      I8_U16,

      // Real source, real/signed dest
      F32_F64,
      S64_F64,    S32_F64,      S16_F64,      S8_F64,
      S64_F32,    S32_F32,      S16_F32,      S8_F32,

      // Signed dest
      I32_S64,    I16_S64,      I8_S64,
      I16_S32,    I8_S32,
      I8_S16,

      // Arithmetic commands, data treat as signed integer / float (3 operands)
      ADD_I8,      ADD_I16,      ADD_I32,      ADD_I64,      ADD_F32,      ADD_F64,
      SUB_I8,      SUB_I16,      SUB_I32,      SUB_I64,      SUB_F32,      SUB_F64,
      MUL_U8,      MUL_U16,      MUL_U32,      MUL_U64,
      MUL_I8,      MUL_I16,      MUL_I32,      MUL_I64,      MUL_F32,      MUL_F64,
      DIV_U8,      DIV_U16,      DIV_U32,      DIV_U64,
      DIV_I8,      DIV_I16,      DIV_I32,      DIV_I64,      DIV_F32,      DIV_F64,
      MOD_U8,      MOD_U16,      MOD_U32,      MOD_U64,
      MOD_I8,      MOD_I16,      MOD_I32,      MOD_I64,      MOD_F32,      MOD_F64,
      NEG_I8,      NEG_I16,      NEG_I32,      NEG_I64,      NEG_F32,      NEG_F64,
      SHL_I8,      SHL_I16,      SHL_I32,      SHL_I64,
      SHR_I8,      SHR_I16,      SHR_I32,      SHR_I64,

      // Logic commands, data treat as unsigned binary (2/3 operands)
      AND_X8,      AND_X16,      AND_X32,      AND_X64,
      OR_X8,      OR_X16,        OR_X32,        OR_X64,
      XOR_X8,      XOR_X16,      XOR_X32,      XOR_X64,
      INV_X8,      INV_X16,      INV_X32,      INV_X64,
      SHL_X8,      SHL_X16,      SHL_X32,      SHL_X64,
      SHR_X8,      SHR_X16,      SHR_X32,      SHR_X64,
      ROL_X8,      ROL_X16,      ROL_X32,      ROL_X64,
      ROR_X8,      ROR_X16,      ROR_X32,      ROR_X64,

      // Object level commands
      NEW_OBJ,
      DEL_OBJ,
      CALL_STATIC,
      CALL_METHOD,
      CALL_VIRTUAL,
      CALL_NATIVE,

      NUM_OPS
    };

  // SYS opcode subcommands
  enum {
      OUT_U8,      OUT_U16,      OUT_U32,      OUT_U64,
      OUT_S8,      OUT_S16,      OUT_S32,      OUT_S64,
      OUT_F32,    OUT_F64,      OUT_STR,
      INP_U8,      INP_U16,      INP_U32,      INP_U64,
      INP_S8,      INP_S16,      INP_S32,      INP_S64,
      INP_F32,    INP_F64,      INP_STR,
      BRK,        DUMP,          VER,
      NEW_X8,      NEW_X16,      NEW_X32,      NEW_X64,
      DEL_X8,      DEL_X16,      DEL_X32,      DEL_X64,
      NEWS_X8,    NEWS_X16,      NEWS_X32,      NEWS_X64,
      DELS_X8,    DELS_X16,      DELS_X32,      DELS_X64,
      NUM_SYS
  };
};

#endif