//****************************************************************************//
//**                                                                        **//
//** File:         proj/jasmine/jasmineea.cpp                               **//
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


/////////////////////////////////////////////////////////////////////
//
//  Effective address calculation
//
//  When the ea funcs are called, instPtr points to the current
//  opcode word. During evaluation, any literal data or extension
//  words cause instPtr to be incremented.
//
//  Upon completion, instPtr points to the word following the last
//  extension word/literal data:
//
//  Before
//
//  [ opcd ] [ ea 1 ] [ ea 2 ] [ ea 3 ] <- instPtr
//  [ ea 1 extension word             ]
//  [ ea 2 extension word             ]
//  [ instruction specific data       ]
//  [ opcd ] [ ea 1 ] [ ea 2 ] [ ea 3 ]
//
//  After
//
//  [ opcd ] [ ea 1 ] [ ea 2 ] [ ea 3 ]
//  [ ea 1 extension word             ]
//  [ ea 2 extension word             ]
//  [ instruction specific data       ] <- instPtr
//  [ opcd ] [ ea 1 ] [ ea 2 ] [ ea 3 ]
//
//  In most cases there will not be any instruction specific data
//  and instPtr points to the subsequent instruction
//
/////////////////////////////////////////////////////////////////////



#define EAOFFSET()      *((sint32*)(++jvm->instPtr))

#if (X_ENDIAN == XA_BIGENDIAN)
#define GETLITERAL(n)   (((uint8*)(++jvm->instPtr))+4-(n))
#define IRRO_BASEREG     jvm->gpRegs[((uint8*)(jvm->instPtr))[3]]
#define IRRO_OFSTREG()   jvm->gpRegs[((uint8*)(jvm->instPtr))[2]].valS32()
#define IRRO_SCALE()    ((sint32)(*((uint16*)jvm->instPtr)))
#else
#define GETLITERAL(n)   ((uint8*)(++jvm->instPtr))
#define IRRO_BASEREG     jvm->gpRegs[((uint8*)(jvm->instPtr))[0]]
#define IRRO_OFSTREG()   jvm->gpRegs[((uint8*)(jvm->instPtr))[1]].valS32()
#define IRRO_SCALE()    ((sint32)((uint16*)(jvm->instPtr)[1]))
#endif

void* JasmineEA::fR0(EA_ARGS)      {  return jvm->gpRegs[0].data(s); }
void* JasmineEA::fR1(EA_ARGS)      {  return jvm->gpRegs[1].data(s); }
void* JasmineEA::fR2(EA_ARGS)      {  return jvm->gpRegs[2].data(s); }
void* JasmineEA::fR3(EA_ARGS)      {  return jvm->gpRegs[3].data(s); }
void* JasmineEA::fR4(EA_ARGS)      {  return jvm->gpRegs[4].data(s); }
void* JasmineEA::fR5(EA_ARGS)      {  return jvm->gpRegs[5].data(s); }
void* JasmineEA::fR6(EA_ARGS)      {  return jvm->gpRegs[6].data(s); }
void* JasmineEA::fR7(EA_ARGS)      {  return jvm->gpRegs[7].data(s); }
void* JasmineEA::fR8(EA_ARGS)      {  return jvm->gpRegs[8].data(s); }
void* JasmineEA::fR9(EA_ARGS)      {  return jvm->gpRegs[9].data(s); }
void* JasmineEA::fR10(EA_ARGS)    {  return jvm->gpRegs[10].data(s); }
void* JasmineEA::fR11(EA_ARGS)    {  return jvm->gpRegs[11].data(s); }
void* JasmineEA::fR12(EA_ARGS)    {  return jvm->gpRegs[12].data(s); }
void* JasmineEA::fR13(EA_ARGS)    {  return jvm->gpRegs[13].data(s); }
void* JasmineEA::fR14(EA_ARGS)    {  return jvm->gpRegs[14].data(s); }
void* JasmineEA::fR15(EA_ARGS)    {  return jvm->gpRegs[15].data(s); }
void* JasmineEA::fR16(EA_ARGS)    {  return jvm->gpRegs[16].data(s); }
void* JasmineEA::fR17(EA_ARGS)    {  return jvm->gpRegs[17].data(s); }
void* JasmineEA::fR18(EA_ARGS)    {  return jvm->gpRegs[18].data(s); }
void* JasmineEA::fR19(EA_ARGS)    {  return jvm->gpRegs[19].data(s); }
void* JasmineEA::fR20(EA_ARGS)    {  return jvm->gpRegs[20].data(s); }
void* JasmineEA::fR21(EA_ARGS)    {  return jvm->gpRegs[21].data(s); }
void* JasmineEA::fR22(EA_ARGS)    {  return jvm->gpRegs[22].data(s); }
void* JasmineEA::fR23(EA_ARGS)    {  return jvm->gpRegs[23].data(s); }
void* JasmineEA::fR24(EA_ARGS)    {  return jvm->gpRegs[24].data(s); }
void* JasmineEA::fR25(EA_ARGS)    {  return jvm->gpRegs[25].data(s); }
void* JasmineEA::fR26(EA_ARGS)    {  return jvm->gpRegs[26].data(s); }
void* JasmineEA::fR27(EA_ARGS)    {  return jvm->gpRegs[27].data(s); }
void* JasmineEA::fR28(EA_ARGS)    {  return jvm->gpRegs[28].data(s); }
void* JasmineEA::fR29(EA_ARGS)    {  return jvm->gpRegs[29].data(s); }
void* JasmineEA::fR30(EA_ARGS)    {  return jvm->gpRegs[30].data(s); }
void* JasmineEA::fR31(EA_ARGS)    {  return jvm->gpRegs[31].data(s); }

void* JasmineEA::fIR0(EA_ARGS)    {  return jvm->gpRegs[0].ptrU8(); }
void* JasmineEA::fIR1(EA_ARGS)    {  return jvm->gpRegs[1].ptrU8(); }
void* JasmineEA::fIR2(EA_ARGS)    {  return jvm->gpRegs[2].ptrU8(); }
void* JasmineEA::fIR3(EA_ARGS)    {  return jvm->gpRegs[3].ptrU8(); }
void* JasmineEA::fIR4(EA_ARGS)    {  return jvm->gpRegs[4].ptrU8(); }
void* JasmineEA::fIR5(EA_ARGS)    {  return jvm->gpRegs[5].ptrU8(); }
void* JasmineEA::fIR6(EA_ARGS)    {  return jvm->gpRegs[6].ptrU8(); }
void* JasmineEA::fIR7(EA_ARGS)    {  return jvm->gpRegs[7].ptrU8(); }
void* JasmineEA::fIR8(EA_ARGS)    {  return jvm->gpRegs[8].ptrU8(); }
void* JasmineEA::fIR9(EA_ARGS)    {  return jvm->gpRegs[9].ptrU8(); }
void* JasmineEA::fIR10(EA_ARGS)    {  return jvm->gpRegs[10].ptrU8(); }
void* JasmineEA::fIR11(EA_ARGS)    {  return jvm->gpRegs[11].ptrU8(); }
void* JasmineEA::fIR12(EA_ARGS)    {  return jvm->gpRegs[12].ptrU8(); }
void* JasmineEA::fIR13(EA_ARGS)    {  return jvm->gpRegs[13].ptrU8(); }
void* JasmineEA::fIR14(EA_ARGS)    {  return jvm->gpRegs[14].ptrU8(); }
void* JasmineEA::fIR15(EA_ARGS)    {  return jvm->gpRegs[15].ptrU8(); }
void* JasmineEA::fIR16(EA_ARGS)    {  return jvm->gpRegs[16].ptrU8(); }
void* JasmineEA::fIR17(EA_ARGS)    {  return jvm->gpRegs[17].ptrU8(); }
void* JasmineEA::fIR18(EA_ARGS)    {  return jvm->gpRegs[18].ptrU8(); }
void* JasmineEA::fIR19(EA_ARGS)    {  return jvm->gpRegs[19].ptrU8(); }
void* JasmineEA::fIR20(EA_ARGS)    {  return jvm->gpRegs[20].ptrU8(); }
void* JasmineEA::fIR21(EA_ARGS)    {  return jvm->gpRegs[21].ptrU8(); }
void* JasmineEA::fIR22(EA_ARGS)    {  return jvm->gpRegs[22].ptrU8(); }
void* JasmineEA::fIR23(EA_ARGS)    {  return jvm->gpRegs[23].ptrU8(); }
void* JasmineEA::fIR24(EA_ARGS)    {  return jvm->gpRegs[24].ptrU8(); }
void* JasmineEA::fIR25(EA_ARGS)    {  return jvm->gpRegs[25].ptrU8(); }
void* JasmineEA::fIR26(EA_ARGS)    {  return jvm->gpRegs[26].ptrU8(); }
void* JasmineEA::fIR27(EA_ARGS)    {  return jvm->gpRegs[27].ptrU8(); }
void* JasmineEA::fIR28(EA_ARGS)    {  return jvm->gpRegs[28].ptrU8(); }
void* JasmineEA::fIR29(EA_ARGS)    {  return jvm->gpRegs[29].ptrU8(); }
void* JasmineEA::fIR30(EA_ARGS)    {  return jvm->gpRegs[30].ptrU8(); }
void* JasmineEA::fIR31(EA_ARGS)    {  return jvm->gpRegs[31].ptrU8(); }

void* JasmineEA::fLIR0(EA_ARGS)    { return jvm->gpRegs[0].ptrU8() + EAOFFSET(); }
void* JasmineEA::fLIR1(EA_ARGS)    { return jvm->gpRegs[1].ptrU8() + EAOFFSET(); }
void* JasmineEA::fLIR2(EA_ARGS)    { return jvm->gpRegs[2].ptrU8() + EAOFFSET(); }
void* JasmineEA::fLIR3(EA_ARGS)    { return jvm->gpRegs[3].ptrU8() + EAOFFSET(); }
void* JasmineEA::fLIR4(EA_ARGS)    { return jvm->gpRegs[4].ptrU8() + EAOFFSET(); }
void* JasmineEA::fLIR5(EA_ARGS)    { return jvm->gpRegs[5].ptrU8() + EAOFFSET(); }
void* JasmineEA::fLIR6(EA_ARGS)    { return jvm->gpRegs[6].ptrU8() + EAOFFSET(); }
void* JasmineEA::fLIR7(EA_ARGS)    { return jvm->gpRegs[7].ptrU8() + EAOFFSET(); }
void* JasmineEA::fLIR8(EA_ARGS)    { return jvm->gpRegs[8].ptrU8() + EAOFFSET(); }
void* JasmineEA::fLIR9(EA_ARGS)    { return jvm->gpRegs[9].ptrU8() + EAOFFSET(); }
void* JasmineEA::fLIR10(EA_ARGS)  { return jvm->gpRegs[10].ptrU8() + EAOFFSET(); }
void* JasmineEA::fLIR11(EA_ARGS)  { return jvm->gpRegs[11].ptrU8() + EAOFFSET(); }
void* JasmineEA::fLIR12(EA_ARGS)  { return jvm->gpRegs[12].ptrU8() + EAOFFSET(); }
void* JasmineEA::fLIR13(EA_ARGS)  { return jvm->gpRegs[13].ptrU8() + EAOFFSET(); }
void* JasmineEA::fLIR14(EA_ARGS)  { return jvm->gpRegs[14].ptrU8() + EAOFFSET(); }
void* JasmineEA::fLIR15(EA_ARGS)  { return jvm->gpRegs[15].ptrU8() + EAOFFSET(); }
void* JasmineEA::fLIR16(EA_ARGS)  { return jvm->gpRegs[16].ptrU8() + EAOFFSET(); }
void* JasmineEA::fLIR17(EA_ARGS)  { return jvm->gpRegs[17].ptrU8() + EAOFFSET(); }
void* JasmineEA::fLIR18(EA_ARGS)  { return jvm->gpRegs[18].ptrU8() + EAOFFSET(); }
void* JasmineEA::fLIR19(EA_ARGS)  { return jvm->gpRegs[19].ptrU8() + EAOFFSET(); }
void* JasmineEA::fLIR20(EA_ARGS)  { return jvm->gpRegs[20].ptrU8() + EAOFFSET(); }
void* JasmineEA::fLIR21(EA_ARGS)  { return jvm->gpRegs[21].ptrU8() + EAOFFSET(); }
void* JasmineEA::fLIR22(EA_ARGS)  { return jvm->gpRegs[22].ptrU8() + EAOFFSET(); }
void* JasmineEA::fLIR23(EA_ARGS)  { return jvm->gpRegs[23].ptrU8() + EAOFFSET(); }
void* JasmineEA::fLIR24(EA_ARGS)  { return jvm->gpRegs[24].ptrU8() + EAOFFSET(); }
void* JasmineEA::fLIR25(EA_ARGS)  { return jvm->gpRegs[25].ptrU8() + EAOFFSET(); }
void* JasmineEA::fLIR26(EA_ARGS)  { return jvm->gpRegs[26].ptrU8() + EAOFFSET(); }
void* JasmineEA::fLIR27(EA_ARGS)  { return jvm->gpRegs[27].ptrU8() + EAOFFSET(); }
void* JasmineEA::fLIR28(EA_ARGS)  { return jvm->gpRegs[28].ptrU8() + EAOFFSET(); }
void* JasmineEA::fLIR29(EA_ARGS)  { return jvm->gpRegs[29].ptrU8() + EAOFFSET(); }
void* JasmineEA::fLIR30(EA_ARGS)  { return jvm->gpRegs[30].ptrU8() + EAOFFSET(); }
void* JasmineEA::fLIR31(EA_ARGS)  { return jvm->gpRegs[31].ptrU8() + EAOFFSET(); }

void* JasmineEA::fLUIR0(EA_ARGS)
{
  uint8* &p = jvm->gpRegs[0].ptrU8();
  p += EAOFFSET();
  return p;
}

void* JasmineEA::fLUIR1(EA_ARGS)
{
  uint8* &p = jvm->gpRegs[1].ptrU8();
  p += EAOFFSET();
  return p;
}

void* JasmineEA::fLUIR2(EA_ARGS)
{
  uint8* &p = jvm->gpRegs[2].ptrU8();
  p += EAOFFSET();
  return p;
}

void* JasmineEA::fLUIR3(EA_ARGS)
{
  uint8* &p = jvm->gpRegs[3].ptrU8();
  p += EAOFFSET();
  return p;
}

void* JasmineEA::fLUIR4(EA_ARGS)
{
  uint8* &p = jvm->gpRegs[4].ptrU8();
  p += EAOFFSET();
  return p;
}

void* JasmineEA::fLUIR5(EA_ARGS)
{
  uint8* &p = jvm->gpRegs[5].ptrU8();
  p += EAOFFSET();
  return p;
}

void* JasmineEA::fLUIR6(EA_ARGS)
{
  uint8* &p = jvm->gpRegs[6].ptrU8();
  p += EAOFFSET();
  return p;
}

void* JasmineEA::fLUIR7(EA_ARGS)
{
  uint8* &p = jvm->gpRegs[7].ptrU8();
  p += EAOFFSET();
  return p;
}

void* JasmineEA::fLUIR8(EA_ARGS)
{
  uint8* &p = jvm->gpRegs[8].ptrU8();
  p += EAOFFSET();
  return p;
}

void* JasmineEA::fLUIR9(EA_ARGS)
{
  uint8* &p = jvm->gpRegs[9].ptrU8();
  p += EAOFFSET();
  return p;
}

void* JasmineEA::fLUIR10(EA_ARGS)
{
  uint8* &p = jvm->gpRegs[10].ptrU8();
  p += EAOFFSET();
  return p;
}

void* JasmineEA::fLUIR11(EA_ARGS)
{
  uint8* &p = jvm->gpRegs[11].ptrU8();
  p += EAOFFSET();
  return p;
}

void* JasmineEA::fLUIR12(EA_ARGS)
{
  uint8* &p = jvm->gpRegs[12].ptrU8();
  p += EAOFFSET();
  return p;
}

void* JasmineEA::fLUIR13(EA_ARGS)
{
  uint8* &p = jvm->gpRegs[13].ptrU8();
  p += EAOFFSET();
  return p;
}

void* JasmineEA::fLUIR14(EA_ARGS)
{
  uint8* &p = jvm->gpRegs[14].ptrU8();
  p += EAOFFSET();
  return p;
}

void* JasmineEA::fLUIR15(EA_ARGS)
{
  uint8* &p = jvm->gpRegs[15].ptrU8();
  p += EAOFFSET();
  return p;
}

void* JasmineEA::fLUIR16(EA_ARGS)
{
  uint8* &p = jvm->gpRegs[16].ptrU8();
  p += EAOFFSET();
  return p;
}

void* JasmineEA::fLUIR17(EA_ARGS)
{
  uint8* &p = jvm->gpRegs[17].ptrU8();
  p += EAOFFSET();
  return p;
}

void* JasmineEA::fLUIR18(EA_ARGS)
{
  uint8* &p = jvm->gpRegs[18].ptrU8();
  p += EAOFFSET();
  return p;
}

void* JasmineEA::fLUIR19(EA_ARGS)
{
  uint8* &p = jvm->gpRegs[19].ptrU8();
  p += EAOFFSET();
  return p;
}

void* JasmineEA::fLUIR20(EA_ARGS)
{
  uint8* &p = jvm->gpRegs[20].ptrU8();
  p += EAOFFSET();
  return p;
}

void* JasmineEA::fLUIR21(EA_ARGS)
{
  uint8* &p = jvm->gpRegs[21].ptrU8();
  p += EAOFFSET();
  return p;
}

void* JasmineEA::fLUIR22(EA_ARGS)
{
  uint8* &p = jvm->gpRegs[22].ptrU8();
  p += EAOFFSET();
  return p;
}

void* JasmineEA::fLUIR23(EA_ARGS)
{
  uint8* &p = jvm->gpRegs[23].ptrU8();
  p += EAOFFSET();
  return p;
}

void* JasmineEA::fLUIR24(EA_ARGS)
{
  uint8* &p = jvm->gpRegs[24].ptrU8();
  p += EAOFFSET();
  return p;
}

void* JasmineEA::fLUIR25(EA_ARGS)
{
  uint8* &p = jvm->gpRegs[25].ptrU8();
  p += EAOFFSET();
  return p;
}

void* JasmineEA::fLUIR26(EA_ARGS)
{
  uint8* &p = jvm->gpRegs[26].ptrU8();
  p += EAOFFSET();
  return p;
}

void* JasmineEA::fLUIR27(EA_ARGS)
{
  uint8* &p = jvm->gpRegs[27].ptrU8();
  p += EAOFFSET();
  return p;
}

void* JasmineEA::fLUIR28(EA_ARGS)
{
  uint8* &p = jvm->gpRegs[28].ptrU8();
  p += EAOFFSET();
  return p;
}

void* JasmineEA::fLUIR29(EA_ARGS)
{
  uint8* &p = jvm->gpRegs[29].ptrU8();
  p += EAOFFSET();
  return p;
}

void* JasmineEA::fLUIR30(EA_ARGS)
{
  uint8* &p = jvm->gpRegs[30].ptrU8();
  p += EAOFFSET();
  return p;
}

void* JasmineEA::fLUIR31(EA_ARGS)
{
  uint8* &p = jvm->gpRegs[31].ptrU8();
  p += EAOFFSET();
  return p;
}

void* JasmineEA::fIRRO(EA_ARGS)
{
  jvm->instPtr++;
  return IRRO_BASEREG.ptrU8() + IRRO_OFSTREG();
}

void* JasmineEA::fIRROU(EA_ARGS)
{
  jvm->instPtr++;
  uint8*  &p = IRRO_BASEREG.ptrU8();
  p += IRRO_OFSTREG();
  return p;
}

void* JasmineEA::fIRSRO(EA_ARGS)
{
  jvm->instPtr++;
  return IRRO_BASEREG.ptrU8() + IRRO_SCALE()*IRRO_OFSTREG();
}

void* JasmineEA::fIRSROU(EA_ARGS)
{
  jvm->instPtr++;
  uint8*  &p = IRRO_BASEREG.ptrU8();
  p += IRRO_SCALE()*IRRO_OFSTREG();
  return p;
}

void* JasmineEA::fCTR(EA_ARGS)
{
  return &jvm->countReg;
}

void* JasmineEA::fDS(EA_ARGS)
{
  return ((uint8*)jvm->dataSectPtr) + EAOFFSET();
}

void* JasmineEA::fCDS(EA_ARGS)
{
  return ((uint8*)jvm->constSectPtr) + EAOFFSET();
}

void* JasmineEA::fLITERAL(EA_ARGS)
{
  return GETLITERAL(s);
}

void* JasmineEA::fOFFSET_PC(EA_ARGS)
{
  jvm->instPtr++;
  return (uint32*)jvm->instPtr + *((sint32*)jvm->instPtr);
}

void* JasmineEA::fFUNC_TAB(EA_ARGS)
{
  return (void*)(jvm->methodTable[*((sint32*)(++jvm->instPtr))]);
}

#undef EAOFFSET
#undef GETLITERAL
#undef IRRO_BASEREG
#undef IRRO_OFSTREG


