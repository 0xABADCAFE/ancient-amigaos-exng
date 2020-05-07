//****************************************************************************//
//**                                                                        **//
//** File:         libsrc/plat/amigaos3_68k/gfxlib/pix15.cpp                **//
//** Description:  15-bit pixel conversions                                 **//
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

////////////////////////////////////////////////////////////////////////////////
//
//  TODO 2004-04-29
//
//  Add endian conditional code and move to common code branch
//
////////////////////////////////////////////////////////////////////////////////


#ifndef _PIX15_NATIVE // Use only if defined in native backend

#define _SWP16(x)   ((x<<8)|(x>>8))
#define _SWP32(x)    ((x<<24)|((x<<8)&0x00FF0000)|((x>>8)&0x0000FF00)|(x>>24))
#define _ROT15(x)   (((x>>10)|(x<<10)|(x&0x03E0))&0x7FFF)
#define _GET15X(x)  ((x&0x7C00)>>7)
#define _GET15G(x)  ((x&0x03E0)>>2)
#define _GET15Y(x)  ((x&0x001F)<<3)
#define _15TO16(x)  (((x<<1)&0xFFC0)|(x&0x001F))
#define _15TO32(x)  ((x&0x7C00)<<9|(x&0x03E0)<<6|(x&0x001F)<<3)

////////////////////////////////////////////////////////////////////////////////
//
//  15 bit -> 15 bit
//
////////////////////////////////////////////////////////////////////////////////

void _Pix15::copy15XETo15XE(PXARG)
{  // xGy15B/L  -> xGy15B/L
  if (dst==src) {
    return;
  }
  else if (dSpan == sSpan && dSpan == w) {
    // block copy
    Mem::copy(dst, src, (w*h)<<1);
  }
  else {  // span copy
    w<<=1; h++;
    while(--h) {
      Mem::copy(dst, src, w);
      ((uint16*)dst)+=dSpan;
      ((uint16*)src)+=sSpan;
    }
  }
}

////////////////////////////////////////////////////////////////////////////////

// void* dst, void* src, size_t w, size_t h, size_t dSpan, size_t sSpan

void _Pix15::copy15XETo15YE(PXARG)
{// xGy15B/L  -> xGy15L/B

  if (dSpan == sSpan && dSpan == w) {
    // block swap
    Mem::swap16(dst, src, w*h);
  }
  else {
    // span swap
    h++;
    while(--h) {
      Mem::swap16(dst, src, w);
      ((uint16*)dst)+=dSpan;
      ((uint16*)src)+=sSpan;
    }
  }
}

////////////////////////////////////////////////////////////////////////////////

// void* dst, void* src, size_t w, size_t h, size_t dSpan, size_t sSpan

void _Pix15::rotate15BETo15BE(PXARG)
{// xGy15B    -> yGx15B
  h++; dSpan -= w; sSpan -= w;
  while(--h) {
    rsint32 x = w+1;
    while(--x) {
      ruint16 pix        = *((uint16*)src)++;
      *((uint16*)dst)++  = _ROT15(pix);
    }
    ((uint16*)dst)+=dSpan;
    ((uint16*)src)+=sSpan;
  }
}

////////////////////////////////////////////////////////////////////////////////

// void* dst, void* src, size_t w, size_t h, size_t dSpan, size_t sSpan

void _Pix15::rotate15LETo15LE(PXARG)
{// xGy15L    -> yGx15L
  h++; dSpan -= w; sSpan -= w;
  while(--h) {
    rsint32 x = w+1;
    while(--x) {
      ruint16 pix        = *((uint16*)src)++;
      pix                = _SWP16(pix);
      pix                = _ROT15(pix);
      *((uint16*)dst)++  = _SWP16(pix);
    }
    ((uint16*)dst)+=dSpan;
    ((uint16*)src)+=sSpan;
  }
}

////////////////////////////////////////////////////////////////////////////////

void _Pix15::rotate15BETo15LE(PXARG)
{// xGy15B    -> yGx15L
  h++; dSpan -= w; sSpan -= w;
  while(--h) {
    rsint32 x = w+1;
    while(--x) {
      ruint16 pix        = *((uint16*)src)++;
      pix                = _ROT15(pix);
      *((uint16*)dst)++  = _SWP16(pix);
    }
    ((uint16*)dst)+=dSpan;
    ((uint16*)src)+=sSpan;
  }
}

////////////////////////////////////////////////////////////////////////////////

void _Pix15::rotate15LETo15BE(PXARG)
{// xGy15L    -> yGx15B
  h++; dSpan -= w; sSpan -= w;
  while(--h) {
    rsint32 x = w+1;
    while(--x) {
      ruint16 pix        = *((uint16*)src)++;
      pix                = _SWP16(pix);
      *((uint16*)dst)++  = _ROT15(pix);
    }
    ((uint16*)dst)+=dSpan;
    ((uint16*)src)+=sSpan;
  }
}


////////////////////////////////////////////////////////////////////////////////
//
//  15 bit -> 16 bit
//
////////////////////////////////////////////////////////////////////////////////

void _Pix15::copy15BETo16BE(PXARG)
{// xGy15B    -> xGy16B
  h++; dSpan -= w; sSpan -= w;
  while(--h) {
    rsint32 x = w+1;
    while(--x) {
      ruint16 pix        = *((uint16*)src)++;
      *((uint16*)dst)++  = _15TO16(pix);
    }
    ((uint16*)dst)+=dSpan;
    ((uint16*)src)+=sSpan;
  }
}

////////////////////////////////////////////////////////////////////////////////

void _Pix15::copy15LETo16LE(PXARG)
{// xGy15L    -> xGy16L
  h++; dSpan -= w; sSpan -= w;
  while(--h) {
    rsint32 x = w+1;
    while(--x) {
      ruint16 pix        = *((uint16*)src)++;
      pix                = _SWP16(pix);
      pix                = _15TO16(pix);
      *((uint16*)dst)++ = _SWP16(pix);
    }
    ((uint16*)dst)+=dSpan;
    ((uint16*)src)+=sSpan;
  }
}

////////////////////////////////////////////////////////////////////////////////

void _Pix15::copy15BETo16LE(PXARG)
{// xGy15B    -> xGy16L
  h++; dSpan -= w; sSpan -= w;
  while(--h) {
    rsint32 x = w+1;
    while(--x) {
      ruint16 pix        = *((uint16*)src)++;
      pix                = _15TO16(pix);
      *((uint16*)dst)++ = _SWP16(pix);
    }
    ((uint16*)dst)+=dSpan;
    ((uint16*)src)+=sSpan;
  }
}

////////////////////////////////////////////////////////////////////////////////

void _Pix15::copy15LETo16BE(PXARG)
{// xGy15L    -> xGy16B
  h++; dSpan -= w; sSpan -= w;
  while(--h) {
    rsint32 x = w+1;
    while(--x) {
      ruint16 pix        = *((uint16*)src)++;
      pix                = _SWP16(pix);
      *((uint16*)dst)++  = _15TO16(pix);
    }
    ((uint16*)dst)+=dSpan;
    ((uint16*)src)+=sSpan;
  }
}

////////////////////////////////////////////////////////////////////////////////

void _Pix15::rotate15BETo16BE(PXARG)
{// xGy15B    -> yGx16B
  h++; dSpan -= w; sSpan -= w;
  while(--h) {
    rsint32 x = w+1;
    while(--x) {
      ruint16 pix        = *((uint16*)src)++;
      pix                = _ROT15(pix);
      *((uint16*)dst)++ = _15TO16(pix);
    }
    ((uint16*)dst)+=dSpan;
    ((uint16*)src)+=sSpan;
  }
}

////////////////////////////////////////////////////////////////////////////////

void _Pix15::rotate15LETo16LE(PXARG)
{// xGy15L    -> yGx16L
  h++; dSpan -= w; sSpan -= w;
  while(--h) {
    rsint32 x = w+1;
    while(--x) {
      ruint16 pix        = *((uint16*)src)++;
      pix                = _SWP16(pix);
      pix                = _ROT15(pix);
      pix                = _15TO16(pix);
      *((uint16*)dst)++  = _SWP16(pix);
    }
    ((uint16*)dst)+=dSpan;
    ((uint16*)src)+=sSpan;
  }
}

////////////////////////////////////////////////////////////////////////////////

void _Pix15::rotate15BETo16LE(PXARG)
{// xGy15B    -> yGx16L
  h++; dSpan -= w; sSpan -= w;
  while(--h) {
    rsint32 x = w+1;
    while(--x) {
      ruint16 pix        = *((uint16*)src)++;
      pix                = _ROT15(pix);
      pix                = _15TO16(pix);
      *((uint16*)dst)++  = _SWP16(pix);
    }
    ((uint16*)dst)+=dSpan;
    ((uint16*)src)+=sSpan;
  }
}

////////////////////////////////////////////////////////////////////////////////

void _Pix15::rotate15LETo16BE(PXARG)
{// xGy15L    -> yGx16B
  h++; dSpan -= w; sSpan -= w;
  while(--h) {
    rsint32 x = w+1;
    while(--x) {
      ruint16 pix        = *((uint16*)src)++;
      pix                = _SWP16(pix);
      pix                = _ROT15(pix);
      *((uint16*)dst)++  = _15TO16(pix);
    }
    ((uint16*)dst)+=dSpan;
    ((uint16*)src)+=sSpan;
  }
}


////////////////////////////////////////////////////////////////////////////////
//
//  15 bit -> 24 bit packed pixels
//
////////////////////////////////////////////////////////////////////////////////

void _Pix15::copy15BETo24XGY(PXARG)
{// xGy15B    -> xGy24
  h++; dSpan -= w; dSpan *= 3; sSpan -= w;
  while(--h) {
    rsint32 x = w+1;
    while(--x) {
      ruint16 pix        = *((uint16*)src)++;
      *((uint8*)dst)++  = _GET15X(pix);
      *((uint8*)dst)++  = _GET15G(pix);
      *((uint8*)dst)++  = _GET15Y(pix);
    }
    ((uint8*)dst)+=dSpan;
    ((uint16*)src)+=sSpan;
  }
}

////////////////////////////////////////////////////////////////////////////////

void _Pix15::copy15LETo24XGY(PXARG)
{// xGy15L    -> xGy24
  h++; dSpan -= w; dSpan *= 3; sSpan -= w;
  while(--h) {
    rsint32 x = w+1;
    while(--x) {
      ruint16 pix        = *((uint16*)src)++;
      pix                = _SWP16(pix);
      *((uint8*)dst)++  = _GET15X(pix);
      *((uint8*)dst)++  = _GET15G(pix);
      *((uint8*)dst)++  = _GET15Y(pix);
    }
    ((uint8*)dst)+=dSpan;
    ((uint16*)src)+=sSpan;
  }
}

////////////////////////////////////////////////////////////////////////////////

void _Pix15::rotate15BETo24XGY(PXARG)
{// xGy15B    -> yGx24
  h++; dSpan -= w; dSpan *= 3; sSpan -= w;
  while(--h) {
    rsint32 x = w+1;
    while(--x) {
      ruint16 pix        = *((uint16*)src)++;
      *((uint8*)dst)++  = _GET15Y(pix);
      *((uint8*)dst)++  = _GET15G(pix);
      *((uint8*)dst)++  = _GET15X(pix);
    }
    ((uint8*)dst)+=dSpan;
    ((uint16*)src)+=sSpan;
  }
}

////////////////////////////////////////////////////////////////////////////////

void _Pix15::rotate15LETo24XGY(PXARG)
{// xGy15L    -> yGx24
  h++; dSpan -= w; dSpan *= 3; sSpan -= w;
  while(--h) {
    rsint32 x = w+1;
    while(--x) {
      ruint16 pix        = *((uint16*)src)++;
      pix                = _SWP16(pix);
      *((uint8*)dst)++  = _GET15Y(pix);
      *((uint8*)dst)++  = _GET15G(pix);
      *((uint8*)dst)++  = _GET15X(pix);
    }
    ((uint8*)dst)+=dSpan;
    ((uint16*)src)+=sSpan;
  }
}


////////////////////////////////////////////////////////////////////////////////
//
//  15 bit -> 32 bit
//
////////////////////////////////////////////////////////////////////////////////

void _Pix15::copy15BETo32BE(PXARG)
{// xGy15B    -> AxGy32B
  h++; dSpan -= w; sSpan -= w;
  while(--h) {
    rsint32 x = w+1;
    while(--x) {
      ruint32 pix        = *((uint16*)src)++;
      *((uint32*)dst)++ = _15TO32(pix);
    }
    ((uint32*)dst)+=dSpan;
    ((uint16*)src)+=sSpan;
  }
}

////////////////////////////////////////////////////////////////////////////////

void _Pix15::copy15LETo32LE(PXARG)
{// xGy15L    -> AxGy32L
  h++; dSpan -= w; sSpan -= w;
  while(--h) {
    rsint32 x = w+1;
    while(--x) {
      ruint32 pix        = *((uint16*)src)++;
      pix                = _SWP16(pix);
      pix                = _15TO32(pix);
      *((uint32*)dst)++ = _SWP32(pix);
    }
    ((uint32*)dst)+=dSpan;
    ((uint16*)src)+=sSpan;
  }
}

////////////////////////////////////////////////////////////////////////////////

void _Pix15::copy15BETo32LE(PXARG)
{// xGy15B    -> AxGy32L
  h++; dSpan -= w; sSpan -= w;
  while(--h) {
    rsint32 x = w+1;
    while(--x) {
      ruint32 pix        = *((uint16*)src)++;
      pix                = _15TO32(pix);
      *((uint32*)dst)++ = _SWP32(pix);
    }
    ((uint32*)dst)+=dSpan;
    ((uint16*)src)+=sSpan;
  }
}

////////////////////////////////////////////////////////////////////////////////

void _Pix15::copy15LETo32BE(PXARG)
{// xGy15L    -> AxGy32B
  h++; dSpan -= w; sSpan -= w;
  while(--h) {
    rsint32 x = w+1;
    while(--x) {
      ruint32 pix        = *((uint16*)src)++;
      pix                = _SWP16(pix);
      *((uint32*)dst)++  = _15TO32(pix);
    }
    ((uint32*)dst)+=dSpan;
    ((uint16*)src)+=sSpan;
  }
}

////////////////////////////////////////////////////////////////////////////////

void _Pix15::rotate15BETo32BE(PXARG)
{// xGy15B    -> AyGx32B
  h++; dSpan -= w; sSpan -= w;
  while(--h) {
    rsint32 x = w+1;
    while(--x) {
      ruint32 pix        = *((uint16*)src)++;
      pix                = _ROT15(pix);
      *((uint32*)dst)++  = _15TO32(pix);
    }
    ((uint32*)dst)+=dSpan;
    ((uint16*)src)+=sSpan;
  }
}

////////////////////////////////////////////////////////////////////////////////

void _Pix15::rotate15LETo32LE(PXARG)
{// xGy15L    -> AyGx32L
  h++; dSpan -= w; sSpan -= w;
  while(--h) {
    rsint32 x = w+1;
    while(--x) {
      ruint32 pix        = *((uint16*)src)++;
      pix                = _SWP16(pix);
      pix                = _ROT15(pix);
      pix                = _15TO32(pix);
      *((uint32*)dst)++  = _SWP32(pix);
    }
    ((uint32*)dst)+=dSpan;
    ((uint16*)src)+=sSpan;
  }
}

////////////////////////////////////////////////////////////////////////////////

void _Pix15::rotate15BETo32LE(PXARG)
{// xGy15B    -> AyGx32L
  h++; dSpan -= w; sSpan -= w;
  while(--h) {
    rsint32 x = w+1;
    while(--x) {
      ruint32 pix        = *((uint16*)src)++;
      pix                = _ROT15(pix);
      pix                =  _15TO32(pix);
      *((uint32*)dst)++  = _SWP32(pix);
    }
    ((uint32*)dst)+=dSpan;
    ((uint16*)src)+=sSpan;
  }
}

////////////////////////////////////////////////////////////////////////////////

void _Pix15::rotate15LETo32BE(PXARG)
{// xGy15L    -> AyGx32B
  h++; dSpan -= w; sSpan -= w;
  while(--h) {
    rsint32 x = w+1;
    while(--x) {
      ruint32 pix        = *((uint16*)src)++;
      pix                = _SWP16(pix);
      pix                = _ROT15(pix);
      *((uint32*)dst)++  = _15TO32(pix);
    }
    ((uint32*)dst)+=dSpan;
    ((uint16*)src)+=sSpan;
  }
}

////////////////////////////////////////////////////////////////////////////////

#endif // _PIX15_ASM
