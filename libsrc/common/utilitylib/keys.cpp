//****************************************************************************//
//**                                                                        **//
//** File:         libsrc/utilitylib/keys.cpp                               **//
//** Description:  Integer Key classes for hash/ID/CRC-style purposes       **//
//** Comment(s):                                                            **//
//** Library:      utilitylib                                               **//
//** Created:      2003-03-04                                               **//
//** Updated:      2003-03-04                                               **//
//** Author(s):    Karl Churchill                                           **//
//** Note(s):                                                               **//
//** Copyright:    (C)1996-2003, eXtropia Studios                           **//
//**               Serkan YAZICI, Karl Churchill                            **//
//**               All Rights Reserved.                                     **//
//**                                                                        **//
//****************************************************************************//

#include <utilitylib/keys.hpp>

uint32 Key32::getValue(const char* text) const
{
  ruint32 v = 0;
  ruint32 m = 0x80000000;
  ruint8* p = (uint8*)text;
  while (*p) {
    // bitwise rotate (so bits are never lost) and xor with byte
    v = (v<<1) | ((v&m) ? 1UL : 0);
    v ^= (uint32) *p++;
  }
  return v;
}

////////////////////////////////////////////////////////////////////////////////

uint64 Key64::getValue(const char* text) const
{
  uint64 v = 0;
  ruint8* p = (uint8*)text;
  while (*p) {
    // bitwise rotate (so bits are never lost) and xor with byte
    v = (v<<1) | ((v&0x8000000000000000ULL) ? 1ULL : 0);
    v ^= (uint64) *p++;
  }
  return v;
}

