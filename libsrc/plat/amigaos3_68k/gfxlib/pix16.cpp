//****************************************************************************//
//**                                                                        **//
//** File:         libsrc/plat/amigaos3_68k/gfxlib/pix16.cpp                **//
//** Description:  16-bit pixel conversions                                 **//
//** Comment(s):                                                            **//
//** Library:      gfxlib                                                   **//
//** Created:      2003-02-22                                               **//
//** Updated:      2003-02-22                                               **//
//** Author(s):    Serkan YAZICI, Karl Churchill                            **//
//** Note(s):                                                               **//
//** Copyright:    (C)1996-2003, eXtropia Studios                           **//
//**               Serkan YAZICI, Karl Churchill                            **//
//**               All Rights Reserved.                                     **//
//**                                                                        **//
//****************************************************************************//

#include <gfxlib/gfx.hpp>

#ifndef _PIX16_NATIVE // Use only if defined in native backend

#define _SWP16(x)   ((x<<8)|(x>>8))
#define _SWP32(x)    ((x<<24)|((x<<8)&0x00FF0000)|((x>>8)&0x0000FF00)|(x>>24))
#define _ROT16(x)    ((x>>11)|(x<<11)|(x&0x07E0))
#define _GET16X(x)  ((x&0xF800)>>8)
#define _GET16G(x)  ((x&0x07E0)>>3)
#define _GET16Y(x)  ((x&0x001F)<<3)
#define _16TO15(x)  (((x>>1)&0x7FE0)|(x&0x001F))
#define _16TO32(x)  ((x&0x0000F800)<<8|(x&0x000007E0)<<5|(x&0x0000001F)<<3)

////////////////////////////////////////////////////////////////////////////////
//
//  16 bit -> 15 bit
//
////////////////////////////////////////////////////////////////////////////////

void _Pix16::copy16BETo15BE(PXARG)
{// xGy16B    -> xGy15B
  h++; dSpan -= w; sSpan -= w;
  while(--h)
  {
    rsint32 x = w+1;
    while(--x)
    {
      ruint16 pix        = *((uint16*)src)++;
      *((uint16*)dst)++  = _16TO15(pix);
    }
    ((uint16*)dst)+=dSpan;
    ((uint16*)src)+=sSpan;
  }
}

////////////////////////////////////////////////////////////////////////////////

void _Pix16::copy16LETo15LE(PXARG)
{// xGy16L    -> xGy15L
  h++; dSpan -= w; sSpan -= w;
  while(--h)
  {
    rsint32 x = w+1;
    while(--x)
    {
      ruint16 pix        = *((uint16*)src)++;
      pix                = _SWP16(pix);
      pix                = _16TO15(pix);
      *((uint16*)dst)++  = _SWP16(pix);
    }
    ((uint16*)dst)+=dSpan;
    ((uint16*)src)+=sSpan;
  }
}

////////////////////////////////////////////////////////////////////////////////

void _Pix16::copy16BETo15LE(PXARG)
{// xGy16B    -> xGy15L
  h++; dSpan -= w; sSpan -= w;
  while(--h)
  {
    rsint32 x = w+1;
    while(--x)
    {
      ruint16 pix        = *((uint16*)src)++;
      pix                = _16TO15(pix);
      *((uint16*)dst)++  = _SWP16(pix);
    }
    ((uint16*)dst)+=dSpan;
    ((uint16*)src)+=sSpan;
  }
}

////////////////////////////////////////////////////////////////////////////////

void _Pix16::copy16LETo15BE(PXARG)
{// xGy16L    -> xGy15B
  h++; dSpan -= w; sSpan -= w;
  while(--h)
  {
    rsint32 x = w+1;
    while(--x)
    {
      ruint16 pix        = *((uint16*)src)++;
      pix                = _SWP16(pix);
      *((uint16*)dst)++  = _16TO15(pix);
    }
    ((uint16*)dst)+=dSpan;
    ((uint16*)src)+=sSpan;
  }
}

////////////////////////////////////////////////////////////////////////////////

void _Pix16::rotate16BETo15BE(PXARG)
{// xGy16B    -> yGx15B
  h++; dSpan -= w; sSpan -= w;
  while(--h)
  {
    rsint32 x = w+1;
    while(--x)
    {
      ruint16 pix        = *((uint16*)src)++;
      pix                = _ROT16(pix);
      *((uint16*)dst)++  = _16TO15(pix);
    }
    ((uint16*)dst)+=dSpan;
    ((uint16*)src)+=sSpan;
  }
}

////////////////////////////////////////////////////////////////////////////////

void _Pix16::rotate16LETo15LE(PXARG)
{// xGy16L    -> yGx15L
  h++; dSpan -= w; sSpan -= w;
  while(--h)
  {
    rsint32 x = w+1;
    while(--x)
    {
      ruint16 pix        = *((uint16*)src)++;
      pix                = _SWP16(pix);
      pix                = _ROT16(pix);
      pix                = _16TO15(pix);
      *((uint16*)dst)++  = _SWP16(pix);
    }
    ((uint16*)dst)+=dSpan;
    ((uint16*)src)+=sSpan;
  }
}

////////////////////////////////////////////////////////////////////////////////

void _Pix16::rotate16BETo15LE(PXARG)
{// xGy16B    -> yGx15L
  h++; dSpan -= w; sSpan -= w;
  while(--h)
  {
    rsint32 x = w+1;
    while(--x)
    {
      ruint16 pix        = *((uint16*)src)++;
      pix                = _ROT16(pix);
      pix                = _16TO15(pix);
      *((uint16*)dst)++  = _SWP16(pix);
    }
    ((uint16*)dst)+=dSpan;
    ((uint16*)src)+=sSpan;
  }
}

////////////////////////////////////////////////////////////////////////////////

void _Pix16::rotate16LETo15BE(PXARG)
{// xGy16L    -> yGx15B
  h++; dSpan -= w; sSpan -= w;
  while(--h)
  {
    rsint32 x = w+1;
    while(--x)
    {
      ruint16 pix        = *((uint16*)src)++;
      pix                = _SWP16(pix);
      pix                = _ROT16(pix);
      *((uint16*)dst)++  = _16TO15(pix);
    }
    ((uint16*)dst)+=dSpan;
    ((uint16*)src)+=sSpan;
  }
}

////////////////////////////////////////////////////////////////////////////////
//
//  16 bit -> 16 bit
//
////////////////////////////////////////////////////////////////////////////////

void _Pix16::copy16XETo16XE(PXARG)
{// xGy16B/L  -> xGy16B/L
  if (dst==src)
    return;
  else if (dSpan == sSpan && dSpan == w)
  {
    Mem::copy(dst, src, (w*h)<<1);
  }
  else
    {
    w<<=1; h++;
    while(--h)
    {
      Mem::copy(dst, src, w);
      ((uint16*)dst)+=dSpan;
      ((uint16*)src)+=sSpan;
    }
  }
}

////////////////////////////////////////////////////////////////////////////////

void _Pix16::copy16XETo16YE(PXARG)
{// xGy16B/L  -> xGy16L/B
  if (dSpan == sSpan && dSpan == w)
  {
    Mem::swap16(dst, src, w*h);
  }
  else
  {
    h++;
    while(--h)
    {
      Mem::swap16(dst, src, w);
      ((uint16*)dst)+=dSpan;
      ((uint16*)src)+=sSpan;
    }
  }
}

////////////////////////////////////////////////////////////////////////////////

void _Pix16::rotate16BETo16BE(PXARG)
{// xGy16B    -> yGx16B
  h++; dSpan -= w; sSpan -= w;
  while(--h)
  {
    rsint32 x = w+1;
    while(--x)
    {
      ruint16 pix        = *((uint16*)src)++;
      *((uint16*)dst)++  = _ROT16(pix);
    }
    ((uint16*)dst)+=dSpan;
    ((uint16*)src)+=sSpan;
  }
}

////////////////////////////////////////////////////////////////////////////////

void _Pix16::rotate16LETo16LE(PXARG)
{// xGy16L    -> yGx16L
  h++; dSpan -= w; sSpan -= w;
  while(--h)
  {
    rsint32 x = w+1;
    while(--x)
    {
      ruint16 pix        = *((uint16*)src)++;
      pix                = _SWP16(pix);
      pix                = _ROT16(pix);
      *((uint16*)dst)++ = _SWP16(pix);
    }
    ((uint16*)dst)+=dSpan;
    ((uint16*)src)+=sSpan;
  }
}

////////////////////////////////////////////////////////////////////////////////

void _Pix16::rotate16BETo16LE(PXARG)
{// xGy16B    -> yGx16L
  h++; dSpan -= w; sSpan -= w;
  while(--h)
  {
    rsint32 x = w+1;
    while(--x)
    {
      ruint16 pix        = *((uint16*)src)++;
      pix                = _ROT16(pix);
      *((uint16*)dst)++  = _SWP16(pix);
    }
    ((uint16*)dst)+=dSpan;
    ((uint16*)src)+=sSpan;
  }
}

////////////////////////////////////////////////////////////////////////////////

void _Pix16::rotate16LETo16BE(PXARG)
{// xGy16L    -> yGx16B
  h++; dSpan -= w; sSpan -= w;
  while(--h)
  {
    rsint32 x = w+1;
    while(--x)
    {
      ruint16 pix        = *((uint16*)src)++;
      pix                = _SWP16(pix);
      *((uint16*)dst)++  = _ROT16(pix);
    }
    ((uint16*)dst)+=dSpan;
    ((uint16*)src)+=sSpan;
  }
}

////////////////////////////////////////////////////////////////////////////////
//
//  16 bit -> 24 bit packed pixels
//
////////////////////////////////////////////////////////////////////////////////

void _Pix16::copy16BETo24XGY(PXARG)
{// xGy16B    -> xGy24
  h++; dSpan -= w; dSpan *= 3; sSpan -= w;
  while(--h)
  {
    rsint32 x = w+1;
    while(--x)
    {
      ruint16 pix        = *((uint16*)src)++;
      *((uint8*)dst)++  = _GET16X(pix);
      *((uint8*)dst)++  = _GET16G(pix);
      *((uint8*)dst)++  = _GET16Y(pix);
    }
    ((uint8*)dst)+=dSpan;
    ((uint16*)src)+=sSpan;
  }
}

////////////////////////////////////////////////////////////////////////////////

void _Pix16::copy16LETo24XGY(PXARG)
{// xGy16L    -> xGy24
  h++; dSpan -= w; dSpan *= 3; sSpan -= w;
  while(--h)
  {
    rsint32 x = w+1;
    while(--x)
    {
      ruint16 pix        = *((uint16*)src)++;
      pix                = _SWP16(pix);
      *((uint8*)dst)++  = _GET16X(pix);
      *((uint8*)dst)++  = _GET16G(pix);
      *((uint8*)dst)++  = _GET16Y(pix);
    }
    ((uint8*)dst)+=dSpan;
    ((uint16*)src)+=sSpan;
  }
}

////////////////////////////////////////////////////////////////////////////////

void _Pix16::rotate16BETo24XGY(PXARG)
{// xGy16B    -> yGx24
  h++; dSpan -= w; dSpan *= 3; sSpan -= w;
  while(--h)
  {
    rsint32 x = w+1;
    while(--x)
    {
      ruint16 pix        = *((uint16*)src)++;
      *((uint8*)dst)++  = _GET16Y(pix);
      *((uint8*)dst)++  = _GET16G(pix);
      *((uint8*)dst)++  = _GET16X(pix);
    }
    ((uint8*)dst)+=dSpan;
    ((uint16*)src)+=sSpan;
  }
}

////////////////////////////////////////////////////////////////////////////////

void _Pix16::rotate16LETo24XGY(PXARG)
{// xGy16L    -> yGx24
  h++; dSpan -= w; dSpan *= 3; sSpan -= w;
  while(--h)
  {
    rsint32 x = w+1;
    while(--x)
    {
      ruint16 pix        = *((uint16*)src)++;
      pix                = _SWP16(pix);
      *((uint8*)dst)++  = _GET16Y(pix);
      *((uint8*)dst)++  = _GET16G(pix);
      *((uint8*)dst)++  = _GET16X(pix);
    }
    ((uint8*)dst)+=dSpan;
    ((uint16*)src)+=sSpan;
  }
}

////////////////////////////////////////////////////////////////////////////////
//
//  16 bit -> 32 bit
//
////////////////////////////////////////////////////////////////////////////////

void _Pix16::copy16BETo32BE(PXARG)
{// xGy16B    -> AxGy32B
  h++; dSpan -= w; sSpan -= w;
  while(--h)
  {
    rsint32 x = w+1;
    while(--x)
    {
      ruint32 pix        = *((uint16*)src)++;
      *((uint32*)dst)++  = _16TO32(pix);
    }
    ((uint32*)dst)+=dSpan;
    ((uint16*)src)+=sSpan;
  }
}

////////////////////////////////////////////////////////////////////////////////

void _Pix16::copy16LETo32LE(PXARG)
{// xGy16L    -> AxGy32L
  h++; dSpan -= w; sSpan -= w;
  while(--h)
  {
    rsint32 x = w+1;
    while(--x)
    {
      ruint32 pix        = *((uint16*)src)++;
      pix                = _SWP16(pix);
      pix                = _16TO32(pix);
      *((uint32*)dst)++  = _SWP32(pix);
    }
    ((uint32*)dst)+=dSpan;
    ((uint16*)src)+=sSpan;
  }
}

////////////////////////////////////////////////////////////////////////////////

void _Pix16::copy16BETo32LE(PXARG)
{// xGy16B    -> AxGy32L
  h++; dSpan -= w; sSpan -= w;
  while(--h)
  {
    rsint32 x = w+1;
    while(--x)
    {
      ruint32 pix        = *((uint16*)src)++;
      pix                = _16TO32(pix);
      *((uint32*)dst)++  = _SWP32(pix);
    }
    ((uint32*)dst)+=dSpan;
    ((uint16*)src)+=sSpan;
  }
}

////////////////////////////////////////////////////////////////////////////////

void _Pix16::copy16LETo32BE(PXARG)
{// xGy16L    -> AxGy32B
  h++; dSpan -= w; sSpan -= w;
  while(--h)
  {
    rsint32 x = w+1;
    while(--x)
    {
      ruint32 pix        = *((uint16*)src)++;
      pix                = _SWP16(pix);
      *((uint32*)dst)++  = _16TO32(pix);
    }
    ((uint32*)dst)+=dSpan;
    ((uint16*)src)+=sSpan;
  }
}

////////////////////////////////////////////////////////////////////////////////

void _Pix16::rotate16BETo32BE(PXARG)
{// xGy16B    -> AyGx32B
  h++; dSpan -= w; sSpan -= w;
  while(--h)
  {
    rsint32 x = w+1;
    while(--x)
    {
      ruint32 pix        = *((uint16*)src)++;
      pix                = _ROT16(pix);
      *((uint32*)dst)++ =  _16TO32(pix);
    }
    ((uint32*)dst)+=dSpan;
    ((uint16*)src)+=sSpan;
  }
}

////////////////////////////////////////////////////////////////////////////////

void _Pix16::rotate16LETo32LE(PXARG)
{// xGy16L    -> AyGx32L
  h++; dSpan -= w; sSpan -= w;
  while(--h)
  {
    rsint32 x = w+1;
    while(--x)
    {
      ruint32 pix        = *((uint16*)src)++;
      pix                = _SWP16(pix);
      pix                = _ROT16(pix);
      pix                = _16TO32(pix);
      *((uint32*)dst)++  = _SWP32(pix);
    }
    ((uint32*)dst)+=dSpan;
    ((uint16*)src)+=sSpan;
  }
}

////////////////////////////////////////////////////////////////////////////////

void _Pix16::rotate16BETo32LE(PXARG)
{// xGy16B    -> AyGx32L
  h++; dSpan -= w; sSpan -= w;
  while(--h)
  {
    rsint32 x = w+1;
    while(--x)
    {
      ruint32 pix        = *((uint16*)src)++;
      pix                = _ROT16(pix);
      pix                = _16TO32(pix);
      *((uint32*)dst)++ = _SWP32(pix);
    }
    ((uint32*)dst)+=dSpan;
    ((uint16*)src)+=sSpan;
  }
}

////////////////////////////////////////////////////////////////////////////////

void _Pix16::rotate16LETo32BE(PXARG)
{// xGy16L    -> AyGx32B
  h++; dSpan -= w; sSpan -= w;
  while(--h)
  {
    rsint32 x = w+1;
    while(--x)
    {
      ruint32 pix        = *((uint16*)src)++;
      pix                = _SWP16(pix);
      pix                = _ROT16(pix);
      *((uint32*)dst)++  = _16TO32(pix);
    }
    ((uint32*)dst)+=dSpan;
    ((uint16*)src)+=sSpan;
  }
}

////////////////////////////////////////////////////////////////////////////////

#endif // _PIX16_NATIVE
