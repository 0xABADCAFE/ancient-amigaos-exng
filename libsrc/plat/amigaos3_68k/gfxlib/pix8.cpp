//****************************************************************************//
//**                                                                        **//
//** File:         libsrc/plat/amigaos3_68k/gfxlib/pix8.cpp                 **//
//** Description:  8-bit pixel conversions                                  **//
//** Comment(s):                                                            **//
//** Library:      gfxlib                                                   **//
//** Created:      2004-02-16                                               **//
//** Updated:      2004-02-16                                               **//
//** Author(s):    Serkan YAZICI, Karl Churchill                            **//
//** Note(s):                                                               **//
//** Copyright:    (C)1996-2004, eXtropia Studios                           **//
//**               Serkan YAZICI, Karl Churchill                            **//
//**               All Rights Reserved.                                     **//
//**                                                                        **//
//****************************************************************************//

#include <gfxlib/gfx.hpp>

/*
   FIXME

   1) Rewrite as asm (use rotate instructions)
   2) Optimise reads / writes as 32-bit
   3) Unroll copy loops (same strategy as Mem:: copy/set/clear/swap code)

*/


#define _SWP16(x)   ((x<<8)|(x>>8))
#define _SWP32(x)    ((x<<24)|((x<<8)&0x00FF0000)|((x>>8)&0x0000FF00)|(x>>24))

#define _ROT32(x)    ((x&0x00FF0000)>>16|(x&0xFF00FF00)|(x&0x000000FF)<<16)
#define _32TO16(x)  (((x>>8)&0x0000F800)|((x>>5)&0x000007E0)|((x>>3)&0x0000001F))
#define _32TO15(x)  (((x>>9)&0x00007C00)|((x>>6)&0x000003E0)|((x>>3)&0x0000001F))

#define _GET32X(x)  ((x&0x00FF0000)>>16)
#define _GET32G(x)  ((x&0x0000FF00)>>8)
#define _GET32Y(x)  (x&0x000000FF)

////////////////////////////////////////////////////////////////////////////////
//
////////////////////////////////////////////////////////////////////////////////

// void* dst, void* src, uint32* sPal, sint16 w, sint16 h, sint16 dSpan, sint16 sSpan

void _Pix8::convRGB15BE(PXARG)
{
  uint16 pal[256];
/*
  {
    // Convert source palette to RGB15B
    ruint16*  p = pal;
    rsint32   i = 256;
    while (i--)
    {
      ruint32  x  = *sPal++;
      *p++      = _32TO15(x);
    }
  }
*/
  _Pix32::copy32BETo15BE(pal, sPal, 0, 256, 1, 256, 256);

  h++; dSpan -= w; sSpan -= w;
  while (--h) {
    rsint32 x = w+1;
    while (--x) {
      *((uint16*)dst)++ = pal[*((uint8*)src)++];
    }
    ((uint16*)dst)  += dSpan;
    ((uint8*)src)    += sSpan;
  }
}

// void* dst, void* src, uint32* sPal, sint16 w, sint16 h, sint16 dSpan, sint16 sSpan

void _Pix8::convBGR15BE(PXARG)
{
  uint16 pal[256];
/*
  {
    // Convert source palette to BGR15B
    ruint16*  p = pal;
    rsint32    i = 256;
    while (i--)
    {
      ruint32 x  = *sPal++;
      x          = _ROT32(x);
      *p++      = _32TO15(x);
    }
  }
*/
  _Pix32::rotate32BETo15BE(pal, sPal, 0, 256, 1, 256, 256);

  h++; dSpan -= w; sSpan -= w;
  while (--h) {
    rsint32 x = w+1;
    while (--x) {
      *((uint16*)dst)++ = pal[*((uint8*)src)++];
    }
    ((uint16*)dst)  += dSpan;
    ((uint8*)src)    += sSpan;
  }
}

// void* dst, void* src, uint32* sPal, sint16 w, sint16 h, sint16 dSpan, sint16 sSpan

void _Pix8::convRGB15LE(PXARG)
{
  uint16 pal[256];
/*
  {
    // Convert source palette to RGB15L
    ruint16*  p = pal;
    rsint32    i = 256;
    while (i--)
    {
      ruint32 x = *sPal++;
      x          = _32TO15(x);
      *p++      = _SWP16(x);
    }
  }
*/
  _Pix32::copy32BETo15LE(pal, sPal, 0, 256, 1, 256, 256);

  h++; dSpan -= w; sSpan -= w;
  while (--h) {
    rsint32 x = w+1;
    while (--x) {
      *((uint16*)dst)++ = pal[*((uint8*)src)++];
    }
    ((uint16*)dst)  += dSpan;
    ((uint8*)src)    += sSpan;
  }
}

// void* dst, void* src, uint32* sPal, sint16 w, sint16 h, sint16 dSpan, sint16 sSpan

void _Pix8::convBGR15LE(PXARG)
{
  uint16 pal[256];
/*
  {
    // Convert source palette to RGB15L
    ruint16*  p = pal;
    rsint32    i = 256;
    while (i--)
    {
      ruint32  x = *sPal++;
      x          = _ROT32(x);
      x          = _32TO15(x);
      *p++      = _SWP16(x);
    }
  }
*/
  _Pix32::rotate32BETo15LE(pal, sPal, 0, 256, 1, 256, 256);

  h++; dSpan -= w; sSpan -= w;
  while (--h) {
    rsint32 x = w+1;
    while (--x) {
      *((uint16*)dst)++ = pal[*((uint8*)src)++];
    }
    ((uint16*)dst)  += dSpan;
    ((uint8*)src)    += sSpan;
  }
}

// void* dst, void* src, uint32* sPal, sint16 w, sint16 h, sint16 dSpan, sint16 sSpan

void _Pix8::convRGB16BE(PXARG)
{
  uint16 pal[256];
/*
  {
    // Convert source palette to RGB16B
    ruint16*  p = pal;
    rsint32    i = 256;
    while (i--)
    {
      ruint32 x  = *sPal++;
      *p++      = _32TO16(x);
    }
  }
*/
  _Pix32::copy32BETo16BE(pal, sPal, 0, 256, 1, 256, 256);

  h++; dSpan -= w; sSpan -= w;
  while (--h) {
    rsint32 x = w+1;
    while (--x) {
      *((uint16*)dst)++ = pal[*((uint8*)src)++];
    }
    ((uint16*)dst)  += dSpan;
    ((uint8*)src)    += sSpan;
  }
}

// void* dst, void* src, uint32* sPal, sint16 w, sint16 h, sint16 dSpan, sint16 sSpan

void _Pix8::convBGR16BE(PXARG)
{
  uint16 pal[256];
/*
  {
    // Convert source palette to BGR16B
    ruint16*  p = pal;
    rsint32    i = 256;
    while (i--)
    {
      ruint32 x  = *sPal++;
      x          = _ROT32(x);
      *p++      = _32TO16(x);
    }
  }
*/
  _Pix32::rotate32BETo16BE(pal, sPal, 0, 256, 1, 256, 256);

  h++; dSpan -= w; sSpan -= w;
  while (--h) {
    rsint32 x = w+1;
    while (--x) {
      *((uint16*)dst)++ = pal[*((uint8*)src)++];
    }
    ((uint16*)dst)  += dSpan;
    ((uint8*)src)    += sSpan;
  }
}

// void* dst, void* src, uint32* sPal, sint16 w, sint16 h, sint16 dSpan, sint16 sSpan

void _Pix8::convRGB16LE(PXARG)
{
  uint16 pal[256];
/*
  {
    // Convert source palette to RGB16L
    ruint16*  p = pal;
    rsint32    i = 256;
    while (i--)
    {
      ruint32 x  = *sPal++;
      x          = _32TO16(x);
      *p++      =  _SWP16(x);
    }
  }
*/
  _Pix32::copy32BETo16LE(pal, sPal, 0, 256, 1, 256, 256);

  h++; dSpan -= w; sSpan -= w;
  while (--h) {
    rsint32 x = w+1;
    while (--x) {
      *((uint16*)dst)++ = pal[*((uint8*)src)++];
    }
    ((uint16*)dst)  += dSpan;
    ((uint8*)src)    += sSpan;
  }
}

// void* dst, void* src, uint32* sPal, sint16 w, sint16 h, sint16 dSpan, sint16 sSpan

void _Pix8::convBGR16LE(PXARG)
{
  uint16 pal[256];
/*
  {
    // Convert source palette to BGR16L
    ruint16*  p = pal;
    rsint32    i = 256;
    while (i--)
    {
      ruint32 x  = *sPal++;
      x          = _ROT32(x);
      x          = _32TO16(x);
      *p++      =  _SWP16(x);
    }
  }
*/
  _Pix32::rotate32BETo16LE(pal, sPal, 0, 256, 1, 256, 256);

  h++; dSpan -= w; sSpan -= w;
  while (--h) {
    rsint32 x = w+1;
    while (--x) {
      *((uint16*)dst)++ = pal[*((uint8*)src)++];
    }
    ((uint16*)dst)  += dSpan;
    ((uint8*)src)    += sSpan;
  }
}

// void* dst, void* src, uint32* sPal, sint16 w, sint16 h, sint16 dSpan, sint16 sSpan

void _Pix8::convRGB24(PXARG)
{
  h++; dSpan -= w; sSpan -= w;
  while (--h) {
    rsint32 x = w+1;
    while (--x) {
      *((uint8*)dst)++ = sPal[*((uint8*)src)+1];
      *((uint8*)dst)++ = sPal[*((uint8*)src)+2];
      *((uint8*)dst)++ = sPal[*((uint8*)src)+3];
      ((uint8*)src)++;
    }
    ((uint32*)dst)  += dSpan;
    ((uint8*)src)    += sSpan;
  }
}

// void* dst, void* src, uint32* sPal, sint16 w, sint16 h, sint16 dSpan, sint16 sSpan

void _Pix8::convBGR24(PXARG)
{
  h++; dSpan -= w; sSpan -= w;
  while (--h) {
    rsint32 x = w+1;
    while (--x) {
      *((uint8*)dst)++ = sPal[*((uint8*)src)+3];
      *((uint8*)dst)++ = sPal[*((uint8*)src)+2];
      *((uint8*)dst)++ = sPal[*((uint8*)src)+1];
      ((uint8*)src)++;
    }
    ((uint32*)dst)  += dSpan;
    ((uint8*)src)    += sSpan;
  }
}

// void* dst, void* src, uint32* sPal, sint16 w, sint16 h, sint16 dSpan, sint16 sSpan

void _Pix8::convARGB32BE(PXARG)
{
  h++; dSpan -= w; sSpan -= w;
  while (--h) {
    rsint32 x = w+1;
    while (--x) {
      *((uint32*)dst)++ = sPal[*((uint8*)src)++];
    }
    ((uint32*)dst)  += dSpan;
    ((uint8*)src)    += sSpan;
  }
}

// void* dst, void* src, uint32* sPal, sint16 w, sint16 h, sint16 dSpan, sint16 sSpan

void _Pix8::convABGR32BE(PXARG)
{
  uint32 pal[256];
/*
  {
    // Convert source palette to ABGR32B
    ruint32*  p = pal;
    rsint32    i = 256;
    while (i--)
    {
      ruint32 x  = *sPal++;
      *p++      = _ROT32(x);
    }
  }
*/
  _Pix32::rotate32BETo32BE(pal, sPal, 0, 256, 1, 256, 256);

  h++; dSpan -= w; sSpan -= w;
  while (--h) {
    rsint32 x = w+1;
    while (--x) {
      *((uint32*)dst)++ = pal[*((uint8*)src)++];
    }
    ((uint32*)dst)  += dSpan;
    ((uint8*)src)    += sSpan;
  }
}

// void* dst, void* src, uint32* sPal, sint16 w, sint16 h, sint16 dSpan, sint16 sSpan

void _Pix8::convARGB32LE(PXARG)
{
  uint32 pal[256];
  Mem::swap32(pal, sPal, 256);

  h++; dSpan -= w; sSpan -= w;
  while (--h) {
    rsint32 x = w+1;
    while (--x) {
      *((uint32*)dst)++ = pal[*((uint8*)src)++];
    }
    ((uint32*)dst)  += dSpan;
    ((uint8*)src)    += sSpan;
  }
}

// void* dst, void* src, uint32* sPal, sint16 w, sint16 h, sint16 dSpan, sint16 sSpan

void _Pix8::convABGR32LE(PXARG)
{
  uint32 pal[256];
/*
  {
    // Convert source palette to ABGR32L
    ruint32*  p = pal;
    rsint32    i = 256;
    while (i--)
    {
      ruint32 x  = *sPal++;
      x          = _ROT32(x);
      *p++      = _SWP32(x);
    }
  }
*/
  _Pix32::rotate32BETo32LE(pal, sPal, 0, 256, 1, 256, 256);

  h++; dSpan -= w; sSpan -= w;
  while (--h) {
    rsint32 x = w+1;
    while (--x) {
      *((uint32*)dst)++ = pal[*((uint8*)src)++];
    }
    ((uint32*)dst)  += dSpan;
    ((uint8*)src)    += sSpan;
  }
}

