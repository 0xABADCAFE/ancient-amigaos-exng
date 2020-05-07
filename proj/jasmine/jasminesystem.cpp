//****************************************************************************//
//**                                                                        **//
//** File:         proj/jasmine/jasminesystem.cpp                           **//
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

#if (X_ENDIAN == XA_BIGENDIAN)

void JasmineEA::DSYS_EA(EA_ARGS)
{
  uint32 x = ((uint8*)jvm->instPtr)[2];
  if (x<JCode::IM0)
    jvm->op[0].any = eaTable[x](jvm,s);
  else
  {
    switch(s)
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
}

/////////////////////////////////////////////////////////////////////////////////////

void JasmineEA::D2SYS_EA(EA_2ARGS)
{
  uint32 x = ((uint8*)jvm->instPtr)[2];
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

  x = ((uint8*)jvm->instPtr)[3];
  if (x<JCode::IM0)
    jvm->op[1].any = eaTable[x](jvm,s2);
  else
  {
    switch(s2)
    {
      case 1:
        jvm->imReg[1].valU8() = x-JCode::IM0;
        jvm->op[1].any = jvm->imReg[1].data8();
        break;
      case 2:
        jvm->imReg[1].valU16() = x-JCode::IM0;
        jvm->op[1].any = jvm->imReg[1].data16();
        break;
      case 4:
        jvm->imReg[1].valU32() = x-JCode::IM0;
        jvm->op[1].any = jvm->imReg[1].data32();
        break;
      case 8:
        jvm->imReg[1].valU64() = x-JCode::IM0;
        jvm->op[1].any = jvm->imReg[1].data64();
        break;
    }
  }
}

/////////////////////////////////////////////////////////////////////////////////////

void JasmineOP::fSYS(OP_ARGS)
{
  sysTable[((uint8*)jvm->instPtr)[1]](OP_ARGVAL);
  jvm->instPtr++;
}

/////////////////////////////////////////////////////////////////////////////////////

#else // #if (X_ENDIAN == XA_BIGENDIAN)

void JasmineEA::DSYS_EA(EA_ARGS)
{
  uint32 x = ((uint8*)jvm->instPtr)[1];
  if (x<JCode::IM0)
    jvm->op[0].any = eaTable[x](jvm,s);
  else
  {
    switch(s)
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
}

/////////////////////////////////////////////////////////////////////////////////////

void JasmineEA::D2SYS_EA(EA_2ARGS)
{
  uint32 x = ((uint8*)jvm->instPtr)[1];
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

  x = ((uint8*)jvm->instPtr)[0];
  if (x<JCode::IM0)
    jvm->op[1].any = eaTable[x](jvm,s2);
  else
  {
    switch(s2)
    {
      case 1:
        jvm->imReg[1].valU8() = x-JCode::IM0;
        jvm->op[1].any = jvm->imReg[1].data8();
        break;
      case 2:
        jvm->imReg[1].valU16() = x-JCode::IM0;
        jvm->op[1].any = jvm->imReg[1].data16();
        break;
      case 4:
        jvm->imReg[1].valU32() = x-JCode::IM0;
        jvm->op[1].any = jvm->imReg[1].data32();
        break;
      case 8:
        jvm->imReg[1].valU64() = x-JCode::IM0;
        jvm->op[1].any = jvm->imReg[1].data64();
        break;
    }
  }
}

/////////////////////////////////////////////////////////////////////////////////////

void JasmineOP::fSYS(OP_ARGS)
{
  fflush(0);
  sysTable[((uint8*)jvm->instPtr)[2]](jvm);
  jvm->instPtr++;
}

#endif // #if (X_ENDIAN == XA_BIGENDIAN)

/////////////////////////////////////////////////////////////////////////////////////

void JasmineOP::fSYS_OUT_U8(OP_ARGS)
{
  JasmineEA::DSYS_EA(jvm,1);
  printf("%c", *jvm->op[0].u8);
}

void JasmineOP::fSYS_OUT_U16(OP_ARGS)
{
  JasmineEA::DSYS_EA(jvm,2);
  printf("%hu", *jvm->op[0].u16);
}

void JasmineOP::fSYS_OUT_U32(OP_ARGS)
{
  JasmineEA::DSYS_EA(jvm,4);
  printf("%lu", *jvm->op[0].u32);
}

void JasmineOP::fSYS_OUT_U64(OP_ARGS)
{
  JasmineEA::DSYS_EA(jvm,8);
  printf("0x%08X%08X",(jvm->op[0].u32)[0],(jvm->op[0].u32)[1]);
}

/////////////////////////////////////////////////////////////////////////////////////

void JasmineOP::fSYS_OUT_S8(OP_ARGS)
{
  JasmineEA::DSYS_EA(jvm,1);
  printf("%c", *jvm->op[0].s8);
}

void JasmineOP::fSYS_OUT_S16(OP_ARGS)
{
  JasmineEA::DSYS_EA(jvm,2);
  printf("%hi", *jvm->op[0].s16);
}

void JasmineOP::fSYS_OUT_S32(OP_ARGS)
{
  JasmineEA::DSYS_EA(jvm,4);
  printf("%li", *jvm->op[0].s32);
}

void JasmineOP::fSYS_OUT_S64(OP_ARGS)
{
  JasmineEA::DSYS_EA(jvm,8);
  printf("0x%08X%08X",(jvm->op[0].u32)[0],(jvm->op[0].u32)[1]);
}

/////////////////////////////////////////////////////////////////////////////////////

void JasmineOP::fSYS_OUT_F32(OP_ARGS)
{
  JasmineEA::DSYS_EA(jvm,4);
  printf("%.6G", *jvm->op[0].f32);
}

void JasmineOP::fSYS_OUT_F64(OP_ARGS)
{
  JasmineEA::DSYS_EA(jvm,8);
  printf("%.10G", *jvm->op[0].f64);
}

/////////////////////////////////////////////////////////////////////////////////////

void JasmineOP::fSYS_OUT_STR(OP_ARGS)
{
  JasmineEA::DSYS_EA(jvm,1);
  printf("%s", jvm->op[0].ch);
}

/////////////////////////////////////////////////////////////////////////////////////

void JasmineOP::fSYS_INP_U8(OP_ARGS)
{
  JasmineEA::DSYS_EA(jvm,1);
  scanf("%c", jvm->op[0].u8);
}

void JasmineOP::fSYS_INP_U16(OP_ARGS)
{
  JasmineEA::DSYS_EA(jvm,2);
  scanf("%hu", jvm->op[0].u16);
}

void JasmineOP::fSYS_INP_U32(OP_ARGS)
{
  JasmineEA::DSYS_EA(jvm,4);
  scanf("%lu", jvm->op[0].u32);
}

void JasmineOP::fSYS_INP_U64(OP_ARGS)
{
  JasmineEA::DSYS_EA(jvm,8);
  scanf("%lu", &(jvm->op[0].u32)[1]);
}

/////////////////////////////////////////////////////////////////////////////////////

void JasmineOP::fSYS_INP_S8(OP_ARGS)
{
  JasmineEA::DSYS_EA(jvm,1);
  scanf("%c", jvm->op[0].s8);
}

void JasmineOP::fSYS_INP_S16(OP_ARGS)
{
  JasmineEA::DSYS_EA(jvm,2);
  scanf("%hi", jvm->op[0].s16);
}

void JasmineOP::fSYS_INP_S32(OP_ARGS)
{
  JasmineEA::DSYS_EA(jvm,4);
  scanf("%li", jvm->op[0].s32);
}

void JasmineOP::fSYS_INP_S64(OP_ARGS)
{
  JasmineEA::DSYS_EA(jvm,8);
  scanf("%li", &(jvm->op[0].s32)[1]);
}

/////////////////////////////////////////////////////////////////////////////////////

void JasmineOP::fSYS_INP_F32(OP_ARGS)
{
  JasmineEA::DSYS_EA(jvm,4);
  scanf("%f", jvm->op[0].f32);
}

void JasmineOP::fSYS_INP_F64(OP_ARGS)
{
  JasmineEA::DSYS_EA(jvm,8);
  scanf("%lf", jvm->op[0].f64);
}

/////////////////////////////////////////////////////////////////////////////////////

void JasmineOP::fSYS_INP_STR(OP_ARGS)
{
  JasmineEA::D2SYS_EA(jvm,4,1);
  fflush(stdout);
  fgets((char*)(jvm->op[1].u8),*jvm->op[0].s32, stdin);
}

/////////////////////////////////////////////////////////////////////////////////////

void JasmineOP::fSYS_BRK(OP_ARGS)
{
  //puts("Kiss my chuddies, man!");
}

void JasmineOP::fSYS_DUMP(OP_ARGS)
{
  #ifdef JASMINE_DEBUG_ENABLE
  puts("                 ______________________");
  puts("  ______________/ VMCORE Register Dump \\______________");
  for (sint32 i=0; i<32; i+=2)
    printf("  r%-2d: 0x%08X:%08X    r%-2d: 0x%08X:%08X\n",
          i, jvm->gpRegs[i].getMSW(), jvm->gpRegs[i].getLSW(),
          i+1, jvm->gpRegs[i+1].getMSW(), jvm->gpRegs[i+1].getLSW()  );
  printf("  i%-2d: 0x%08X:%08X    i%-2d: 0x%08X:%08X\n", 0,
          jvm->imReg[0].getMSW(), jvm->imReg[0].getLSW(),       1,
          jvm->imReg[1].getMSW(), jvm->imReg[1].getLSW());

  printf("  PC  : %-5dMS  : %-5dRS   : %-5dDS  : %d\n",
          jvm->getPC(), (jvm->methodStack-jvm->methodStackBase),
          (jvm->regStack-jvm->regStackBase),
          (jvm->stack-jvm->stackBase)  );
  printf("  Code: %-5dData: %-5dConst: %-5d\n",
          jvm->vmObject->getCodeSize(), jvm->vmObject->getDataLength(), jvm->vmObject->getConstLength());
  puts("  ____________________________________________________\n");
  #endif
}

/////////////////////////////////////////////////////////////////////////////////////

void JasmineOP::fSYS_VER(OP_ARGS)
{
  puts("eXtropia JASMINE version 1");
}

#if (X_ENDIAN == XA_BIGENDIAN)

void JasmineOP::fSYS_NEW_X8(OP_ARGS)
{
  JasmineEA::DSYS_EA(jvm,4);
  jvm->gpRegs[((uint8*)jvm->instPtr)[3]/*&0x1F*/].ptrU8() = new uint8[*jvm->op[0].s32];
}

void JasmineOP::fSYS_NEW_X16(OP_ARGS)
{
  JasmineEA::DSYS_EA(jvm,4);
  jvm->gpRegs[((uint8*)jvm->instPtr)[3]/*&0x1F*/].ptrU16() = new uint16[*jvm->op[0].s32];
}

void JasmineOP::fSYS_NEW_X32(OP_ARGS)
{
  JasmineEA::DSYS_EA(jvm,4);
  jvm->gpRegs[((uint8*)jvm->instPtr)[3]/*&0x1F*/].ptrU32() = new uint32[*jvm->op[0].s32];
}

void JasmineOP::fSYS_NEW_X64(OP_ARGS)
{
  JasmineEA::DSYS_EA(jvm,4);
  jvm->gpRegs[((uint8*)jvm->instPtr)[3]/*&0x1F*/].ptrU64() = new uint64[*jvm->op[0].s32];
}

/////////////////////////////////////////////////////////////////////////////////////

void JasmineOP::fSYS_DEL_X8(OP_ARGS)
{
  delete[] jvm->gpRegs[((uint8*)jvm->instPtr)[3]/*&0x1F*/].ptrU8();
}

void JasmineOP::fSYS_DEL_X16(OP_ARGS)
{
  delete[] jvm->gpRegs[((uint8*)jvm->instPtr)[3]/*&0x1F*/].ptrU16();
}

void JasmineOP::fSYS_DEL_X32(OP_ARGS)
{
  delete[] jvm->gpRegs[((uint8*)jvm->instPtr)[3]/*&0x1F*/].ptrU32();
}

void JasmineOP::fSYS_DEL_X64(OP_ARGS)
{
  delete[] jvm->gpRegs[((uint8*)jvm->instPtr)[3]/*&0x1F*/].ptrU64();
}

/////////////////////////////////////////////////////////////////////////////////////


void JasmineOP::fSYS_NEWS_X8(OP_ARGS)
{
  JasmineEA::DSYS_EA(jvm,4);
  //jvm->gpRegs[((uint8*)jvm->instPtr)[3]/*&0x1F*/].ptrU8() = new uint8[*jvm->op[0].s32];
}

void JasmineOP::fSYS_NEWS_X16(OP_ARGS)
{
  JasmineEA::DSYS_EA(jvm,4);
  //jvm->gpRegs[((uint8*)jvm->instPtr)[3]/*&0x1F*/].ptrU16() = new uint16[*jvm->op[0].s32];
}

void JasmineOP::fSYS_NEWS_X32(OP_ARGS)
{
  JasmineEA::DSYS_EA(jvm,4);
  //jvm->gpRegs[((uint8*)jvm->instPtr)[3]/*&0x1F*/].ptrU32() = new uint32[*jvm->op[0].s32];
}

void JasmineOP::fSYS_NEWS_X64(OP_ARGS)
{
  JasmineEA::DSYS_EA(jvm,4);
  //jvm->gpRegs[((uint8*)jvm->instPtr)[3]/*&0x1F*/].ptrU64() = new uint64[*jvm->op[0].s32];
}

/////////////////////////////////////////////////////////////////////////////////////

void JasmineOP::fSYS_DELS_X8(OP_ARGS)
{
  //delete[] jvm->gpRegs[((uint8*)jvm->instPtr)[3]/*&0x1F*/].ptrU8();
}

void JasmineOP::fSYS_DELS_X16(OP_ARGS)
{
  //delete[] jvm->gpRegs[((uint8*)jvm->instPtr)[3]/*&0x1F*/].ptrU16();
}

void JasmineOP::fSYS_DELS_X32(OP_ARGS)
{
  //delete[] jvm->gpRegs[((uint8*)jvm->instPtr)[3]/*&0x1F*/].ptrU32();
}

void JasmineOP::fSYS_DELS_X64(OP_ARGS)
{
  //delete[] jvm->gpRegs[((uint8*)jvm->instPtr)[3]/*&0x1F*/].ptrU64();
}

/////////////////////////////////////////////////////////////////////////////////////

#else // #if (X_ENDIAN == XA_BIGENDIAN)

void JasmineOP::fSYS_NEW_X8(OP_ARGS)
{
  JasmineEA::DSYS_EA(jvm,4);
  jvm->gpRegs[((uint8*)jvm->instPtr)[0]/*&0x1F*/].ptrU8() = new uint8[*jvm->op[0].s32];
}

void JasmineOP::fSYS_NEW_X16(OP_ARGS)
{
  JasmineEA::DSYS_EA(jvm,4);
  jvm->gpRegs[((uint8*)jvm->instPtr)[0]/*&0x1F*/].ptrU16() = new uint16[*jvm->op[0].s32];
}

void JasmineOP::fSYS_NEW_X32(OP_ARGS)
{
  JasmineEA::DSYS_EA(jvm,4);
  jvm->gpRegs[((uint8*)jvm->instPtr)[0]/*&0x1F*/].ptrU32() = new uint32[*jvm->op[0].s32];
}

void JasmineOP::fSYS_NEW_X64(OP_ARGS)
{
  JasmineEA::DSYS_EA(jvm,4);
  jvm->gpRegs[((uint8*)jvm->instPtr)[0]/*&0x1F*/].ptrU64() = new uint64[*jvm->op[0].s32];
}

/////////////////////////////////////////////////////////////////////////////////////

void JasmineOP::fSYS_DEL_X8(OP_ARGS)
{
  delete[] jvm->gpRegs[((uint8*)jvm->instPtr)[0]/*&0x1F*/].ptrU8();
}

void JasmineOP::fSYS_DEL_X16(OP_ARGS)
{
  delete[] jvm->gpRegs[((uint8*)jvm->instPtr)[0]/*&0x1F*/].ptrU16();
}

void JasmineOP::fSYS_DEL_X32(OP_ARGS)
{
  delete[] jvm->gpRegs[((uint8*)jvm->instPtr)[0]/*&0x1F*/].ptrU32();
}

void JasmineOP::fSYS_DEL_X64(OP_ARGS)
{
  delete[] jvm->gpRegs[((uint8*)jvm->instPtr)[0]/*&0x1F*/].ptrU64();
}


#endif // #if (X_ENDIAN == XA_BIGENDIAN)

/////////////////////////////////////////////////////////////////////////////////////
