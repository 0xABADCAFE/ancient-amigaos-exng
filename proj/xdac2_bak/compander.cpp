//****************************************************************************//
//**                                                                        **//
//** File:         proj/sdac2/compander.cpp                                 **//
//** Description:  Gfx speed test application                               **//
//** Comment(s):   This software tests direct surface access timing and     **//
//**               pixel conversion.                                        **//
//** Created:      2004-03-18                                               **//
//** Updated:      2004-03-18                                               **//
//** Author(s):    Karl Churchill                                           **//
//** Note(s):      It's not my fault. Patrik made me do it.                 **//
//**               Application is not system idependent as it relies on     **//
//**               asm                                                      **//
//** Copyright:    (C)1996-2004, eXtropia Studios                           **//
//**               Serkan YAZICI, Karl Churchill                            **//
//**                                                                        **//
//**               All Rights Reserved.                                     **//
//**                                                                        **//
//****************************************************************************//


#include "compander.hpp"

sint32  CompBasic::cnt    = 0;
sint32*  CompBasic::decode  = 0;
uint8*  CompBasic::encode  = 0;

bool    CompBasic::createTables()
{
  if (!decode) {
    if (!(decode = (sint32*)Mem::alloc(256*sizeof(sint32), false, Mem::ALIGN_CACHE))) {
      return false;
    }
    static uint16 ex[16] = {
      0,    8,    16,    24,    32,    48,    64,    128,  256,  512,  1024,  2048,  4096,  8192,  16384,32768
    };
    static uint16 ls[16] = {
      1,    1,    1,    1,    2,    2,    8,    16,    32,    64,    128,  256,  512,  1024,  2048,  4096
    };
    sint32* p = decode;
    for (int i=0; i<16; i++) {
      int s = ls[i];
      int m = ex[i];
      *p++ = m; *p++ = -m; m+=s;
      *p++ = m; *p++ = -m; m+=s;
      *p++ = m; *p++ = -m; m+=s;
      *p++ = m; *p++ = -m; m+=s;
      *p++ = m; *p++ = -m; m+=s;
      *p++ = m; *p++ = -m; m+=s;
      *p++ = m; *p++ = -m; m+=s;
      *p++ = m; *p++ = -m;
    }

  }
  if (!encode) {
    if (!(encode = (uint8*)Mem::alloc(65536*sizeof(uint8), false, Mem::ALIGN_CACHE))) {
      Mem::free(decode);
      decode=0;
      return false;
    }
    sint32  dI  = 0;
    uint8*  e    = encode;
    sint32 i;
    for (int i=0; i<61440; i++) {
      if (i > ((decode[dI]+decode[dI+2])>>1) )
        dI+=2;
      *e++ = dI;
    }
    for (i=61440; i<65536; i++) {
      *e++ = dI;
    }
  }
  return true;
}

////////////////////////////////////////////////////////////////////////////////

CompBasic::CompBasic()
{
  if (cnt==0) {
    if (!createTables())
      return;
  }
  cnt++;
}

CompBasic::~CompBasic()
{
  --cnt;
  if (cnt==0) {
    Mem::free(decode);
    Mem::free(encode);
    decode=0;
    encode=0;
  }
}


void CompBasic::dumpCurve()
{
  for (int i=0; i<256; i+=2) {
    printf("%6ld,", decode[i]);
    if (((i+2)&15)==0)
      printf("\n");
  }
  printf("\n");

  for (int i=0; i<512; i++) {
    printf("%d:%ld, ", i, decode[encode[i]]);
    if (((i+2)&7)==0)
      printf("\n");
  }
}

////////////////////////////////////////////////////////////////////////////////
