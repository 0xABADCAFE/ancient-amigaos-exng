//****************************************************************************//
//**                                                                        **//
//** File:         proj/SimpleView/simpleview.cpp                           **//
//** Description:  Simple image viewer                                      **//
//** Comment(s):                                                            **//
//** Created:      2003-04-30                                               **//
//** Updated:      2003-09-22                                               **//
//** Author(s):    Karl Churchill                                           **//
//** Note(s):                                                               **//
//** Copyright:    (C)1996-2003, eXtropia Studios                           **//
//**               Serkan YAZICI, Karl Churchill                            **//
//**               All Rights Reserved.                                     **//
//**                                                                        **//
//****************************************************************************//

#include "simplepaint.hpp"

extern "C" {
  #include <math.h>
}

////////////////////////////////////////////////////////////////////////////////
//
//  SimpleBrush
//
////////////////////////////////////////////////////////////////////////////////

sint32   SimpleBrush::count = 0;
uint16*  SimpleBrush::blendTab = 0;
uint8*  SimpleBrush::divTab = 0;

////////////////////////////////////////////////////////////////////////////////

SimpleBrush::SimpleBrush(float32 r, float32 d, Colour c) : colour(c), data(0), bMode(ALPHA)
{
  radius    = Clamp::real(r, 2.0f, 32.0f);
  density    = Clamp::real(d, 0.0f, 8.0f);
  data      = (uint8*) Mem::alloc(((MAX_BRUSHRADIUS*2)*(MAX_BRUSHRADIUS*2)), false, Mem::ALIGN_CACHE);
  calculate();

  // if this is the first brush, initialise the blend table
  if (0 == count++)
  {
    if (!(blendTab = (uint16*)Mem::alloc(256*256*3, false, Mem::ALIGN_CACHE)))
      return;

    divTab  = (uint8*)(blendTab+65536);

    ruint16* p = blendTab;
    for (rsint32 alpha=0; alpha<256; alpha++)
    {
      for (rsint32 src=0; src<256; src++)
      {
        *p++ = (uint16)(src*alpha);
      }
    }

    ruint8* d = divTab;
    for (rsint32 i=0; i<65536; i++)
    {
      *d++ = i/255;
    }
  }
}

////////////////////////////////////////////////////////////////////////////////

SimpleBrush::~SimpleBrush()
{
  if (data)
    Mem::free(data);

  // if this was the last brush, remove the blend table
  if (0 == --count)
  {
    if (blendTab)
      Mem::free(blendTab);
    blendTab = 0;
    divTab = 0;
  }
}

////////////////////////////////////////////////////////////////////////////////

void SimpleBrush::calculate()
{
  size      =  (sint16)((2.0f*radius)+0.5f);
  span      = (MAX_BRUSHRADIUS*2) - size;
  ruint8*   p = data;
  rfloat32  s = density*255.0f/radius;
  for (sint32 y=0; y<size; y++)
  {
    for (sint32 x=0; x<size; x++)
    {
      float32 px  = ((float32)x)-radius;
      float32 py  = ((float32)y)-radius;
      sint32  v    = (sint32)(s*(radius-sqrt(px*px + py*py)));
      *p++ = Clamp::integer(v, 0, 255);
    }
    p += span;
  }
}


////////////////////////////////////////////////////////////////////////////////

void SimpleBrush::apply(ImageBuffer* image, uint8* mask, sint16 x, sint16 y)
{
  Pixel::HWType pType = Pixel::getPrefFormat(Pixel::BPP32);

  /*
    The hardware format returned for the above ARGB32 is guarenteed by the
    library to match the longword format of Colour. Hence we allocate our
    32-bit image buffers with this format such that the individual pixels
    are safely accessable as Colour.
  */

  if (!image || image->getFormat()!=pType)
    return;
  if (x<(size>>1) || y<(size>>1) ||
      x>(image->getW()-(size>>1)) ||
      y>(image->getH()-(size>>1)))
    return;
  sint32 dSpan = image->getW()-size;

  uint8*  p      = data;
  Colour* dest  = (Colour*)(image->getData())+
                  ((y-(size>>1))*image->getW()+(x-(size>>1)));

  switch (bMode)
  {
    case ALPHA:
      for (rsint32 py=0; py<size; py++)
      {
        for (rsint32 px=0; px<size; px++)
        {
          uint32 alpha = *p++;
          if (alpha == 255)
            *dest = colour;
          else if (alpha)
          {
            dest->red()    = blendChannelAlpha(colour.red(),    dest->red(),    alpha);
            dest->green() = blendChannelAlpha(colour.green(),  dest->green(),  alpha);
            dest->blue()  = blendChannelAlpha(colour.blue(),  dest->blue(),    alpha);
          }
          dest++;
        }
        p      += span;
        dest   += dSpan;
      }
      break;

    case MULTIPLY:
      for (rsint32 py=0; py<size; py++)
      {
        for (rsint32 px=0; px<size; px++)
        {
          uint32 alpha = *p++;
          if (alpha == 255)
            *dest = colour;
          else if (alpha)
          {
            dest->red()    = modulateChannel(colour.red(),    dest->red(),    alpha);
            dest->green() = modulateChannel(colour.green(),  dest->green(),  alpha);
            dest->blue()  = modulateChannel(colour.blue(),  dest->blue(),    alpha);
          }
          dest++;
        }
        p      += span;
        dest   += dSpan;
      }
      break;

    case NEGATIVE:
      if (!mask)
        return;
      else
      {
        ruint8*  m  = mask+((y-(size>>1))*image->getW()+(x-(size>>1)));

        for (rsint32 py=0; py<size; py++)
        {
          for (rsint32 px=0; px<size; px++)
          {
            uint32 alpha = *p++;
            if (alpha && (!(*m)))
            {
              dest->red()    = negateChannel(dest->red(), alpha);
              dest->green() = negateChannel(dest->green(), alpha);
              dest->blue()  = negateChannel(dest->blue(), alpha);
              *m = 1;
            }
            dest++;
            m++;
          }
          p      += span;
          dest   += dSpan;
          m      += dSpan;
        }
      }
      break;

    default:
      break;
  }
}

////////////////////////////////////////////////////////////////////////////////

const char* SimpleBrush::getMode()
{
  switch (bMode) {
    case ALPHA:      return "Normal";
    case NEGATIVE:  return "Negative";
    default:        return "Unknown";
  };
}