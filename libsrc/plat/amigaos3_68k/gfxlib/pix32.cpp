//****************************************************************************//
//**                                                                        **//
//** File:         libsrc/plat/amigaos3_68k/gfxlib/pix32.cpp                **//
//** Description:  32-bit pixel conversions                                 **//
//** Comment(s):                                                            **//
//** Library:      gfxlib                                                   **//
//** Created:      2003-02-24                                               **//
//** Updated:      2003-02-24                                               **//
//** Author(s):    Serkan YAZICI, Karl Churchill                            **//
//** Note(s):                                                               **//
//** Copyright:    (C)1996-2003, eXtropia Studios                           **//
//**               Serkan YAZICI, Karl Churchill                            **//
//**               All Rights Reserved.                                     **//
//**                                                                        **//
//****************************************************************************//

#include <gfxlib/gfx.hpp>

#ifndef _PIX32_NATIVE // Use only if defined in native backend

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
//  32 bit -> 15 bit
//
////////////////////////////////////////////////////////////////////////////////

void _Pix32::copy32BETo15BE(PXARG)
{// AxGy32B    -> xGy15B
  h++; dSpan -= w; sSpan -= w;
  while(--h)
  {
    rsint32 x = w+1;
    while(--x)
    {
      ruint32 pix        = *((uint32*)src)++;
      *((uint16*)dst)++  = _32TO15(pix);
    }
    ((uint16*)dst)+=dSpan;
    ((uint32*)src)+=sSpan;
  }
}

////////////////////////////////////////////////////////////////////////////////

void _Pix32::copy32LETo15LE(PXARG)
{// AxGy32L    -> xGy15L
  h++; dSpan -= w; sSpan -= w;
  while(--h)
  {
    rsint32 x = w+1;
    while(--x)
    {
      ruint32  pix        = *((uint32*)src)++;
      pix                = _SWP32(pix);
      pix                = _32TO15(pix);
      *((uint16*)dst)++  = _SWP16(pix);
    }
    ((uint16*)dst)+=dSpan;
    ((uint32*)src)+=sSpan;
  }
}

////////////////////////////////////////////////////////////////////////////////

void _Pix32::copy32BETo15LE(PXARG)
{// AxGy32B    -> xGy15L
  h++; dSpan -= w; sSpan -= w;
  while(--h)
  {
    rsint32 x = w+1;
    while(--x)
    {
      ruint32 pix        = *((uint32*)src)++;
      pix                = _32TO15(pix);
      *((uint16*)dst)++  = _SWP16(pix);
    }
    ((uint16*)dst)+=dSpan;
    ((uint32*)src)+=sSpan;
  }
}

////////////////////////////////////////////////////////////////////////////////

void _Pix32::copy32LETo15BE(PXARG)
{// AxGy32L    -> xGy15B
  h++; dSpan -= w; sSpan -= w;
  while(--h)
  {
    rsint32 x = w+1;
    while(--x)
    {
      ruint32 pix        = *((uint32*)src)++;
      pix                = _SWP32(pix);
      *((uint16*)dst)++  = _32TO15(pix);
    }
    ((uint16*)dst)+=dSpan;
    ((uint32*)src)+=sSpan;
  }
}

////////////////////////////////////////////////////////////////////////////////

void _Pix32::rotate32BETo15BE(PXARG)
{// AxGy32B    -> yGx15B
  h++; dSpan -= w; sSpan -= w;
  while(--h)
  {
    rsint32 x = w+1;
    while(--x)
    {
      ruint32 pix        = *((uint32*)src)++;
      pix                = _ROT32(pix);
      *((uint16*)dst)++  = _32TO15(pix);
    }
    ((uint16*)dst)+=dSpan;
    ((uint32*)src)+=sSpan;
  }
}

////////////////////////////////////////////////////////////////////////////////

void _Pix32::rotate32LETo15LE(PXARG)
{// AxGy32L    -> yGx15L
  h++; dSpan -= w; sSpan -= w;
  while(--h)
  {
    rsint32 x = w+1;
    while(--x)
    {
      ruint32 pix        = *((uint32*)src)++;
      pix                = _SWP32(pix);
      pix                = _ROT32(pix);
      pix                = _32TO15(pix);
      *((uint16*)dst)++  = _SWP16(pix);
    }
    ((uint16*)dst)+=dSpan;
    ((uint32*)src)+=sSpan;
  }
}

////////////////////////////////////////////////////////////////////////////////

void _Pix32::rotate32BETo15LE(PXARG)
{// AxGy32B    -> yGx15L
  h++; dSpan -= w; sSpan -= w;
  while(--h)
  {
    rsint32 x = w+1;
    while(--x)
    {
      ruint32 pix        = *((uint32*)src)++;
      pix                = _ROT32(pix);
      pix                = _32TO15(pix);
      *((uint16*)dst)++  = _SWP16(pix);
    }
    ((uint16*)dst)+=dSpan;
    ((uint32*)src)+=sSpan;
  }
}

////////////////////////////////////////////////////////////////////////////////

void _Pix32::rotate32LETo15BE(PXARG)
{// AxGy32L    -> yGx15B
  h++; dSpan -= w; sSpan -= w;
  while(--h)
  {
    rsint32 x = w+1;
    while(--x)
    {
      ruint32 pix        = *((uint32*)src)++;
      pix                = _SWP32(pix);
      pix                = _ROT32(pix);
      *((uint16*)dst)++  = _32TO15(pix);
    }
    ((uint16*)dst)+=dSpan;
    ((uint32*)src)+=sSpan;
  }
}


////////////////////////////////////////////////////////////////////////////////
//
//  32 bit -> 16 bit
//
////////////////////////////////////////////////////////////////////////////////

void _Pix32::copy32BETo16BE(PXARG)
{// AxGy32B    -> xGy16B
  h++; dSpan -= w; sSpan -= w;
  while(--h)
  {
    rsint32 x = w+1;
    while(--x)
    {
      ruint32 pix        = *((uint32*)src)++;
      *((uint16*)dst)++  = _32TO16(pix);
    }
    ((uint16*)dst)+=dSpan;
    ((uint32*)src)+=sSpan;
  }
}

////////////////////////////////////////////////////////////////////////////////

void _Pix32::copy32LETo16LE(PXARG)
{// AxGy32L    -> xGy16L
  h++; dSpan -= w; sSpan -= w;
  while(--h)
  {
    rsint32 x = w+1;
    while(--x)
    {
      ruint32 pix        = *((uint32*)src)++;
      pix                = _SWP32(pix);
      pix                = _32TO16(pix);
      *((uint16*)dst)++  = _SWP16(pix);
    }
    ((uint16*)dst)+=dSpan;
    ((uint32*)src)+=sSpan;
  }
}

////////////////////////////////////////////////////////////////////////////////

void _Pix32::copy32BETo16LE(PXARG)
{// AxGy32B    -> xGy16L
  h++; dSpan -= w; sSpan -= w;
  while(--h)
  {
    rsint32 x = w+1;
    while(--x)
    {
      ruint32 pix        = *((uint32*)src)++;
      pix                = _32TO16(pix);
      *((uint16*)dst)++  = _SWP16(pix);
    }
    ((uint16*)dst)+=dSpan;
    ((uint32*)src)+=sSpan;
  }
}

////////////////////////////////////////////////////////////////////////////////

void _Pix32::copy32LETo16BE(PXARG)
{// AxGy32L    -> xGy16B
  h++; dSpan -= w; sSpan -= w;
  while(--h)
  {
    rsint32 x = w+1;
    while(--x)
    {
      ruint32 pix        = *((uint32*)src)++;
      pix                = _SWP32(pix);
      *((uint16*)dst)++  = _32TO16(pix);
    }
    ((uint16*)dst)+=dSpan;
    ((uint32*)src)+=sSpan;
  }
}

////////////////////////////////////////////////////////////////////////////////

void _Pix32::rotate32BETo16BE(PXARG)
{// AxGy32B    -> yGx16B
  h++; dSpan -= w; sSpan -= w;
  while(--h)
  {
    rsint32 x = w+1;
    while(--x)
    {
      ruint32 pix        = *((uint32*)src)++;
      pix                = _ROT32(pix);
      *((uint16*)dst)++  = _32TO16(pix);
    }
    ((uint16*)dst)+=dSpan;
    ((uint32*)src)+=sSpan;
  }
}

////////////////////////////////////////////////////////////////////////////////

void _Pix32::rotate32LETo16LE(PXARG)
{// AxGy32L    -> yGx16L
  h++; dSpan -= w; sSpan -= w;
  while(--h)
  {
    rsint32 x = w+1;
    while(--x)
    {
      ruint32 pix        = *((uint32*)src)++;
      pix                = _SWP32(pix);
      pix                = _ROT32(pix);
      pix                = _32TO16(pix);
      *((uint16*)dst)++  = _SWP16(pix);
    }
    ((uint16*)dst)+=dSpan;
    ((uint32*)src)+=sSpan;
  }
}

////////////////////////////////////////////////////////////////////////////////

void _Pix32::rotate32BETo16LE(PXARG)
{// AxGy32B    -> yGx16L
  h++; dSpan -= w; sSpan -= w;
  while(--h)
  {
    rsint32 x = w+1;
    while(--x)
    {
      ruint32 pix        = *((uint32*)src)++;
      pix                = _ROT32(pix);
      pix                = _32TO16(pix);
      *((uint16*)dst)++  = _SWP16(pix);
    }
    ((uint16*)dst)+=dSpan;
    ((uint32*)src)+=sSpan;
  }
}

////////////////////////////////////////////////////////////////////////////////

void _Pix32::rotate32LETo16BE(PXARG)
{// AxGy32L    -> yGx16B
  h++; dSpan -= w; sSpan -= w;
  while(--h)
  {
    rsint32 x = w+1;
    while(--x)
    {

      ruint32 pix        = *((uint32*)src)++;
      pix                = _SWP32(pix);
      pix                = _ROT32(pix);
      *((uint16*)dst)++  = _32TO16(pix);
    }
    ((uint16*)dst)+=dSpan;
    ((uint32*)src)+=sSpan;
  }
}

////////////////////////////////////////////////////////////////////////////////
//
//  32 bit -> 24 bit packed pixels
//
////////////////////////////////////////////////////////////////////////////////

void _Pix32::copy32BETo24XGY(PXARG)
{// AxGy16B    -> xGy24
  h++; dSpan -= w; dSpan *= 3; sSpan -= w;
  while(--h)
  {
    rsint32 x = w+1;
    while(--x)
    {
      ruint32 pix        = *((uint32*)src)++;
      *((uint8*)dst)++  = _GET32X(pix);
      *((uint8*)dst)++  = _GET32G(pix);
      *((uint8*)dst)++  = _GET32Y(pix);
    }
    ((uint8*)dst)+=dSpan;
    ((uint32*)src)+=sSpan;
  }
}

////////////////////////////////////////////////////////////////////////////////

void _Pix32::copy32LETo24XGY(PXARG)
{// AxGy16L    -> xGy24
  h++; dSpan -= w; dSpan *= 3; sSpan -= w;
  while(--h)
  {
    rsint32 x = w+1;
    while(--x)
    {
      ruint32 pix        = *((uint32*)src)++;
      *((uint8*)dst)++  = _GET32Y(pix);
      *((uint8*)dst)++  = _GET32G(pix);
      *((uint8*)dst)++  = _GET32X(pix);
    }
    ((uint8*)dst)+=dSpan;
    ((uint32*)src)+=sSpan;
  }
}

////////////////////////////////////////////////////////////////////////////////

void _Pix32::rotate32BETo24XGY(PXARG)
{// AxGy16B    -> yGx24
  h++; dSpan -= w; dSpan *= 3; sSpan -= w;
  while(--h)
  {
    rsint32 x = w+1;
    while(--x)
    {
      ruint32 pix        = *((uint32*)src)++;
      *((uint8*)dst)++  = _GET32Y(pix);
      *((uint8*)dst)++  = _GET32G(pix);
      *((uint8*)dst)++  = _GET32X(pix);
    }
    ((uint8*)dst)+=dSpan;
    ((uint32*)src)+=sSpan;
  }
}

////////////////////////////////////////////////////////////////////////////////

void _Pix32::rotate32LETo24XGY(PXARG)
{// AxGy16L    -> yGx24
  h++; dSpan -= w; dSpan *= 3; sSpan -= w;
  while(--h)
  {
    rsint32 x = w+1;
    while(--x)
    {
      ruint32 pix        = *((uint32*)src)++;
      *((uint8*)dst)++  = _GET32X(pix);
      *((uint8*)dst)++  = _GET32G(pix);
      *((uint8*)dst)++  = _GET32Y(pix);
    }
    ((uint8*)dst)+=dSpan;
    ((uint32*)src)+=sSpan;
  }
}

////////////////////////////////////////////////////////////////////////////////
//
//  32 bit -> 32 bit
//
////////////////////////////////////////////////////////////////////////////////

void _Pix32::copy32XETo32XE(PXARG)
{// AxGy32B/L  -> AxGy32B/L
  if (dst==src)
    return;
  else if (dSpan == sSpan && dSpan == w)
  {
    Mem::copy(dst, src, (w*h)<<2);
  }
  else
  {
    w<<=2; h++;
    while (--h)
    {
      Mem::copy(dst, src, w);
      ((uint32*)dst)+=dSpan;
      ((uint32*)src)+=sSpan;
    }
  }
}

////////////////////////////////////////////////////////////////////////////////

void _Pix32::copy32XETo32YE(PXARG)
{// AxGy32B/L  -> AxGy32L/B
  if (dSpan == sSpan && dSpan == w)
  {
    Mem::swap32(dst, src, w*h);
  }
  else
  {
    h++;
    while(--h)
    {
      Mem::swap32(dst, src, w);
      ((uint32*)dst)+=dSpan;
      ((uint32*)src)+=sSpan;
    }
  }
}

////////////////////////////////////////////////////////////////////////////////

void _Pix32::rotate32BETo32BE(PXARG)
{// AxGy32B    -> AyGx32B
  h++; dSpan -= w; sSpan -= w;
  while(--h)
  {
    rsint32 x = w+1;
    while(--x)
    {
      ruint32 pix        = *((uint32*)src)++;
      *((uint32*)dst)++ = _ROT32(pix);
    }
    ((uint32*)dst)+=dSpan;
    ((uint32*)src)+=sSpan;
  }
}

////////////////////////////////////////////////////////////////////////////////

void _Pix32::rotate32LETo32LE(PXARG)
{// AxGy32L    -> AyGx32L
  h++; dSpan -= w; sSpan -= w;
  while(--h)
  {
    rsint32 x = w+1;
    while(--x)
    {
      ruint32 pix = *((uint32*)src)++;
      pix                = _SWP32(pix);
      pix                = _ROT32(pix);
      *((uint32*)dst)++  =  _SWP32(pix);
    }
    ((uint32*)dst)+=dSpan;
    ((uint32*)src)+=sSpan;
  }
}

////////////////////////////////////////////////////////////////////////////////

void _Pix32::rotate32BETo32LE(PXARG)
{// AxGy32B    -> AyGx32L
  h++; dSpan -= w; sSpan -= w;
  while(--h)
  {
    rsint32 x = w+1;
    while(--x)
    {
      ruint32 pix        = *((uint32*)src)++;
      pix                = _ROT32(pix);
      *((uint32*)dst)++  = _SWP32(pix);
    }
    ((uint32*)dst)+=dSpan;
    ((uint32*)src)+=sSpan;
  }
}

////////////////////////////////////////////////////////////////////////////////

void _Pix32::rotate32LETo32BE(PXARG)
{// AxGy32L    -> AyGx32B
  h++; dSpan -= w; sSpan -= w;
  while(--h)
  {
    rsint32 x = w+1;
    while(--x)
    {
      ruint32 pix        = *((uint32*)src)++;
      pix                = _SWP32(pix);
      *((uint32*)dst)++  = _ROT32(pix);
    }
    ((uint32*)dst)+=dSpan;
    ((uint32*)src)+=sSpan;
  }
}

////////////////////////////////////////////////////////////////////////////////

#endif // _PIX32_NATIVE
