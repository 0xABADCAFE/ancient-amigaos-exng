//****************************************************************************//
//**                                                                        **//
//** File:         libsrc/plat/amigaos3_68k/gfxlib/pix24.cpp                **//
//** Description:  24-bit pixel conversions                                 **//
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

#ifndef _PIX24_NATIVE // Use only if defined in native backend


#define _SWP16(x)   ((x<<8)|(x>>8))
#define _SWP32(x)    ((x<<24)|((x<<8)&0x00FF0000)|((x>>8)&0x0000FF00)|(x>>24))

#define _XTO15(x)    (((x)&0x00F8)<<7)
#define _GTO15(x)    (((x)&0x00F8)<<3)
#define _YTO15(x)    ((x)>>3)

#define _XTO16(x)    (((x)&0x00F8)<<8)
#define _GTO16(x)    (((x)&0x00FC)<<3)
#define _YTO16(x)    ((x)>>3)

#define  _SRC(x)      (*((uint8*)x)++)

////////////////////////////////////////////////////////////////////////////////
//
//  24 bit -> 15 bit
//
////////////////////////////////////////////////////////////////////////////////

void _Pix24::copy24XGYTo15BE(PXARG)
{// xGy24     -> xGy15B
  h++; dSpan -= w; sSpan -= w; sSpan *= 3;
  while(--h)
  {
    rsint32 x = w+1;
    while(--x)
    {
      ruint16 pix        =  _XTO15(*((uint8*)src)++);
      pix               |=  _GTO15(*((uint8*)src)++);
      *((uint16*)dst)++  = pix | _YTO15(*((uint8*)src)++);
    }
    ((uint16*)dst)+=dSpan;
    ((uint8*)src)+=sSpan;
  }
}

////////////////////////////////////////////////////////////////////////////////

void _Pix24::copy24XGYTo15LE(PXARG)
{// xGy24     -> xGy15L
  h++; dSpan -= w; sSpan -= w; sSpan *= 3;
  while(--h)
  {
    rsint32 x = w+1;
    while(--x)
    {
      ruint16 pix        = _XTO15(*((uint8*)src)++);
      pix               |= _GTO15(*((uint8*)src)++);
      pix               |= _YTO15(*((uint8*)src)++);
      *((uint16*)dst)++  =  _SWP16(pix);
    }
    ((uint16*)dst)+=dSpan;
    ((uint8*)src)+=sSpan;
  }
}

////////////////////////////////////////////////////////////////////////////////

void _Pix24::rotate24XGYTo15BE(PXARG)
{// xGy24     -> yGx15B
  h++; dSpan -= w; sSpan -= w; sSpan *= 3;
  while(--h)
  {
    rsint32 x = w+1;
    while(--x)
    {
      ruint16 pix        = _YTO15(*((uint8*)src)++);
      pix               |= _GTO15(*((uint8*)src)++);
      *((uint16*)dst)++ =  pix | _XTO15(*((uint8*)src)++);
    }
    ((uint16*)dst)+=dSpan;
    ((uint8*)src)+=sSpan;
  }
}

////////////////////////////////////////////////////////////////////////////////

void _Pix24::rotate24XGYTo15LE(PXARG)
{// xGy24     -> yGx15L
  h++; dSpan -= w; sSpan -= w; sSpan *= 3;
  while(--h)
  {
    rsint32 x = w+1;
    while(--x)
    {
      ruint16 pix        = _YTO15(*((uint8*)src)++);
      pix               |= _GTO15(*((uint8*)src)++);
      pix               |= _XTO15(*((uint8*)src)++);
      *((uint16*)dst)++  =  _SWP16(pix);
    }
    ((uint16*)dst)+=dSpan;
    ((uint8*)src)+=sSpan;
  }
}

////////////////////////////////////////////////////////////////////////////////
//
//  24 bit -> 16 bit
//
////////////////////////////////////////////////////////////////////////////////

void _Pix24::copy24XGYTo16BE(PXARG)
{// xGy24     -> xGy16B
  h++; dSpan -= w; sSpan -= w; sSpan *= 3;
  while(--h)
  {
    rsint32 x = w+1;
    while(--x)
    {
      ruint16 pix        =  _XTO16(*((uint8*)src)++);
      pix               |=  _GTO16(*((uint8*)src)++);
      *((uint16*)dst)++  = pix | _YTO16(*((uint8*)src)++);
    }
    ((uint16*)dst)+=dSpan;
    ((uint8*)src)+=sSpan;
  }
}

////////////////////////////////////////////////////////////////////////////////

void _Pix24::copy24XGYTo16LE(PXARG)
{// xGy24     -> xGy16L
  h++; dSpan -= w; sSpan -= w; sSpan *= 3;
  while(--h)
  {
    rsint32 x = w+1;
    while(--x)
    {
      ruint16 pix        = _XTO15(*((uint8*)src)++);
      pix               |= _GTO15(*((uint8*)src)++);
      pix               |= _YTO15(*((uint8*)src)++);
      *((uint16*)dst)++  =  _SWP16(pix);
    }
    ((uint16*)dst)+=dSpan;
    ((uint8*)src)+=sSpan;
  }
}

////////////////////////////////////////////////////////////////////////////////

void _Pix24::rotate24XGYTo16BE(PXARG)
{// xGy24     -> yGx16B
  h++; dSpan -= w; sSpan -= w; sSpan *= 3;
  while(--h)
  {
    rsint32 x = w+1;
    while(--x)
    {
      ruint16 pix        =  _YTO16(*((uint8*)src)++);
      pix               |=  _GTO16(*((uint8*)src)++);
      *((uint16*)dst)++  = pix | _XTO16(*((uint8*)src)++);
    }
    ((uint16*)dst)+=dSpan;
    ((uint8*)src)+=sSpan;
  }
}

////////////////////////////////////////////////////////////////////////////////

void _Pix24::rotate24XGYTo16LE(PXARG)
{// xGy24     -> yGx16L
  h++; dSpan -= w; sSpan -= w; sSpan *= 3;
  while(--h)
  {
    rsint32 x = w+1;
    while(--x)
    {
      ruint16 pix        = _YTO15(*((uint8*)src)++);
      pix               |= _GTO15(*((uint8*)src)++);
      pix               |= _XTO15(*((uint8*)src)++);
      *((uint16*)dst)++  =  _SWP16(pix);
    }
    ((uint16*)dst)+=dSpan;
    ((uint8*)src)+=sSpan;
  }
}


////////////////////////////////////////////////////////////////////////////////
//
//  24 bit -> 24 bit
//
////////////////////////////////////////////////////////////////////////////////

void _Pix24::copy24To24(PXARG)
{// xGy24     -> xGy24
  if (dst==src)
    return;

  else if (dSpan == sSpan && dSpan == w)
  {
    Mem::copy(dst, src, w*h*3);
  }
  else
  {
    dSpan *= 3; sSpan *= 3;  w *= 3;
    h++;
    while (--h)
    {
      Mem::copy(dst, src, w);
      ((uint8*)dst)+=dSpan;
      ((uint8*)src)+=sSpan;
    }
  }
}

////////////////////////////////////////////////////////////////////////////////

void _Pix24::rotate24To24(PXARG)
{// xGy24     -> yGx24
  dSpan -= w; sSpan -= w;
  dSpan *= 3; sSpan *= 3;
  h++;
  while(--h)
  {
    rsint32 x = w+1;
    while (--x)
    {
      *((uint8*)dst)++ = ((uint8*)src)[2];
      *((uint8*)dst)++ = ((uint8*)src)[1];
      *((uint8*)dst)++ = ((uint8*)src)[0];
      ((uint8*)src) += 3;
    }
    ((uint8*)dst)+=dSpan;
    ((uint8*)src)+=sSpan;
  }
}

////////////////////////////////////////////////////////////////////////////////
//
//  24 bit -> 32 bit
//
////////////////////////////////////////////////////////////////////////////////

void _Pix24::copy24XGYTo32BE(PXARG)
{// xGy24     -> AxGy32B
  h++; dSpan -= w; sSpan -= w; sSpan *= 3;
  while(--h)
  {
    rsint32 x = w+1;
    while(--x)
    {
      // Write as 0x00XXGGYY
      ruint32 pix        =  (*((uint8*)src)++)<<16;        // Get X
      pix               |=  (*((uint8*)src)++)<<8;        // Get G
      *((uint32*)dst)++  = pix | (*((uint8*)src)++);      // Get Y
    }
    ((uint32*)dst)+=dSpan;
    ((uint8*)src)+=sSpan;
  }
}

////////////////////////////////////////////////////////////////////////////////

void _Pix24::copy24XGYTo32LE(PXARG)
{// xGy24     -> AxGy32L
  h++; dSpan -= w; sSpan -= w; sSpan *= 3;
  while(--h)
  {
    rsint32 x = w+1;
    while(--x)
    {
      // Write as 0xYYGGBB00
      ruint32 pix        = (*((uint8*)src)++)<<8;        // Get X
      pix               |= (*((uint8*)src)++)<<16;        // Get G
      *((uint32*)dst)++  = pix | (*((uint8*)src)++)<<24;  // Get Y
    }
    ((uint32*)dst)+=dSpan;
    ((uint8*)src)+=sSpan;
  }
}

////////////////////////////////////////////////////////////////////////////////

void _Pix24::rotate24XGYTo32BE(PXARG)
{// xGy24     -> AyGx32B
  h++; dSpan -= w; sSpan -= w; sSpan *= 3;
  while(--h)
  {
    rsint32 x = w+1;
    while(--x)
    {
      // Write as 0x00YYGGXX
      ruint32 pix        = *((uint8*)src)++;              // Get X
      pix               |= (*((uint8*)src)++)<<8;        // Get G
      *((uint32*)dst)++  = pix | (*((uint8*)src)++)<<16;  // Get Y
    }
    ((uint32*)dst)+=dSpan;
    ((uint8*)src)+=sSpan;
  }
}

////////////////////////////////////////////////////////////////////////////////

void _Pix24::rotate24XGYTo32LE(PXARG)
{// xGy24     -> AyGx32L
  h++; dSpan -= w; sSpan -= w; sSpan *= 3;
  while(--h)
  {
    rsint32 x = w+1;
    while(--x)
    {
      // Write as 0xXXGGYY00
      ruint32 pix        = (*((uint8*)src)++)<<24;        // Get X
      pix               |= (*((uint8*)src)++)<<16;        // Get G
      *((uint32*)dst)++  = pix | (*((uint8*)src)++)<<8;  // Get Y
    }
    ((uint32*)dst)+=dSpan;
    ((uint8*)src)+=sSpan;
  }
}

////////////////////////////////////////////////////////////////////////////////

#endif // _PIX24_NATIVE
