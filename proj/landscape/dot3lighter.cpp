//****************************************************************************//
//**                                                                        **//
//** File:         proj/Landscape/app.cpp                                   **//
//** Description:                                                           **//
//** Comment(s):                                                            **//
//** Created:      2005-01-10                                               **//
//** Updated:      2003-01-10                                               **//
//** Author(s):    Karl Churchill                                           **//
//** Note(s):                                                               **//
//** Copyright:    (C)1996-2005, eXtropia Studios                           **//
//**               Serkan YAZICI, Karl Churchill                            **//
//**               All Rights Reserved.                                     **//
//**                                                                        **//
//****************************************************************************//

#include "dot3lighter.hpp"

////////////////////////////////////////////////////////////////////////////////

sint8*  Dot3Lighter::nMuls = 0;
sint32  Dot3Lighter::count = 0;

Dot3Lighter::Dot3Lighter() : ux(0), uy(0), uz(0)
{
  if (0 == count++) {
    if (nMuls = (sint8*)Mem::alloc(65536, false, Mem::ALIGN_CACHE))
      calculateTable();
  }
}

////////////////////////////////////////////////////////////////////////////////

Dot3Lighter::~Dot3Lighter()
{
  if (0 == --count) {
    if (nMuls) {
      Mem::free(nMuls);
      nMuls = 0;
    }
  }
  if (count<0)
    count = 0;
}

////////////////////////////////////////////////////////////////////////////////

void Dot3Lighter::calculateTable()
{
  sint8* p = nMuls;
  for (sint32 i=-128; i<128; i++) {
    for (sint32 j=-128; j<128; j++) {
      *p++ = ((i*j)>>8);
    }
  }
}

////////////////////////////////////////////////////////////////////////////////

void Dot3Lighter::setLightVector(float32 x, float32 y, float32 z)
{
  float32 scale = 128.0/sqrt(x*x + y*y + z*z);
  ux = (((sint16)(x*scale))+128)<<8;
  uy = (((sint16)(y*scale))+128)<<8;
  uz = (((sint16)(z*scale))+128)<<8;
}

ImageBuffer* Dot3Lighter::createGreyScale(ImageBuffer* dot3)
{
  if (!dot3 || !dot3->getData() || dot3->getFormat()!=Pixel::ARGB32B)
    return 0;
  ImageBuffer* grey = new ImageBuffer;
  if (!grey || grey->create(dot3->getW(), dot3->getH(), Pixel::INDEX8, 0, true, 256)!=OK) {
    delete grey;
    return 0;
  }

  Palette* p = grey->getPalette();
  if (p) {
    Colour* c = p->getTable();
    for (uint32 i=0; i<255; i++) {
      c[i] = (0xFF000000|i<<16|i<<8|i);
    }
  }

  uint8*  dst = (uint8*)grey->getData();
  uint8*  src = (uint8*)dot3->getData();

  rsint32  numPix = dot3->getH()*dot3->getW();

  sint32  min = 65536;
  sint32  max = 0;

  while (numPix--) {
    sint32 v = (nMuls[ux+src[1]] + nMuls[uy+src[2]] + nMuls[uz+src[3]])+128;
    if (v<min)
      min = v;
    if (v>max)
      max = v;
    *dst++ = (uint8)(v);
    src+=4;
  }

  printf("grey map : min %ld, max %ld\n", min, max);


  return grey;
}