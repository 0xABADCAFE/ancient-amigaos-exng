//****************************************************************************//
//**                                                                        **//
//** File:         libsrc/common/gfxlib/gfxcomm.cpp                         **//
//** Description:  Common graphic class definitions                         **//
//** Comment(s):                                                            **//
//** Library:      gfxlib                                                   **//
//** Created:      2003-02-22                                               **//
//** Updated:      2003-02-22                                               **//
//** Author(s):    Karl Churchill                                           **//
//** Note(s):                                                               **//
//** Copyright:    (C)1996-2003, eXtropia Studios                           **//
//**               Serkan YAZICI, Karl Churchill                            **//
//**               All Rights Reserved.                                     **//
//**                                                                        **//
//****************************************************************************//

#include <gfxlib/gfx.hpp>

extern "C" {
  #include <string.h>
};

#include <new.h>

#if (X_ENDIAN == XA_BIGENDIAN)
  #define _SB      0 // swap big
  #define _SL      1 // swap little
  #define _PB      0 // packed byte
  #define _RGB15  Pixel::RGB15B
  #define _RGB16  Pixel::RGB16B
  #define _ARGB32  Pixel::ARGB32B
#else
  #define _SB      1
  #define _SL      0
  #define _PB      0
  #define _RGB15  Pixel::RGB15L
  #define _RGB16  Pixel::RGB16L
  #define _ARGB32  Pixel::ARGB32L
#endif

////////////////////////////////////////////////////////////////////////////////
//
//  Pixel
//
////////////////////////////////////////////////////////////////////////////////

// initial values for hardware types, may be reassigned by GfxLib::init()

Pixel::HWType Pixel::formats[6] = {
  Pixel::OTHERFMT,
  Pixel::INDEX8,
  _RGB15,
  _RGB16,
  Pixel::RGB24P,
  _ARGB32
};

Pixel::HWType Pixel::getPrefFormat(Pixel::Depth d)
{
  switch(d) {
    case BPPUNK:return formats[0];
    case BPP8:  return formats[1];
    case BPP15:  return formats[2];
    case BPP16: return formats[3];
    case BPP24:  return formats[4];
    case BPP32:  return formats[5];
    default:    return formats[0];
  }
  return formats[0];
}

////////////////////////////////////////////////////////////////////////////////
//
//  PixelDescriptor
//
////////////////////////////////////////////////////////////////////////////////


PixelDescriptor PixelDescriptor::propTab[Pixel::MAXHWTYPES] = {
  //              sz  sz  ix  sw  ba  br  bg  bb  sa  sr  sg  sb
  PixelDescriptor(1,  1,  1,  _PB,  8,  8,  8,  8,  0,  0,  0,  0),    // INDEX8
  PixelDescriptor(2,  2,  0,  _SB,  0,  5,  5,  5,  0,  10,  5,  0),    // RGB15B
  PixelDescriptor(2,  2,  0,  _SB,  0,  5,  5,  5,  0,  0,  5,  10),  // BGR15B
  PixelDescriptor(2,  2,  0,  _SL,  0,  5,  5,  5,  0,  10,  5,  0),    // RGB15L
  PixelDescriptor(2,  2,  0,  _SL,  0,  5,  5,  5,  0,  0,  5,  10),  // BGR15L
  PixelDescriptor(2,  2,  0,  _SB,  0,  5,  6,  5,  0,  11,  5,  0),    // RGB16B
  PixelDescriptor(2,  2,  0,  _SB,  0,  5,  6,  5,  0,  0,  5,  11),  // BGR16B
  PixelDescriptor(2,  2,  0,  _SL,  0,  5,  6,  5,  0,  11,  5,  0),    // RGB16L
  PixelDescriptor(2,  2,  0,  _SL,  0,  5,  6,  5,  0,  0,  5,  11),  // BGR16L
  PixelDescriptor(3,  3,  0,  _PB,  0,  8,  8,  8,  0,  0,  1,  2),    // RGB24P
  PixelDescriptor(3,  3,  0,  _PB,  0,  8,  8,  8,  0,  2,  1,  0),    // BGR24P
  PixelDescriptor(4,  4,  0,  _SB,  8,  8,  8,  8,  24,  16,  8,  0),    // ARGB32B
  PixelDescriptor(4,  4,  0,  _SB,  8,  8,  8,  8,  24,  0,  8,  16),  // ABGR32B
  PixelDescriptor(4,  4,  0,  _SL,  8,  8,  8,  8,  24,  16,  8,  0),    // ARGB32L
  PixelDescriptor(4,  4,  0,  _SL,  8,  8,  8,  8,  24,  0,  8,  16)    // ABGR32L
};

#undef _PB
#undef _SB
#undef _SL

////////////////////////////////////////////////////////////////////////////////
//
//  Colour
//
////////////////////////////////////////////////////////////////////////////////

uint32 Colour::getPixelRep(const PixelDescriptor *p) const
{
  // Generates a value representing the colour expressed as a pixel defined by
  // the PixelDescriptor. This method is completely generic and assumes nothing
  // about the pixel format. For standard pixel formats, there are individually
  // optimised routines.

  ruint32 ret = 0;

  rfloat32 sf = (1.0/255.0); // this 'normalizes' our colour channel value
  if (p->getBitsAlpha()) {
    ret = (uint32)(sf*((uint16)chan[ARGB_A]*(uint16)p->getMaxAlpha()))<<p->getShiftAlpha();
  }
  ret |= (uint32)(sf*((uint16)chan[ARGB_R]*(uint16)p->getMaxRed()))<<p->getShiftRed();
  ret |= (uint32)(sf*((uint16)chan[ARGB_G]*(uint16)p->getMaxGreen()))<<p->getShiftGreen();
  ret |= (uint32)(sf*((uint16)chan[ARGB_B]*(uint16)p->getMaxBlue()))<<p->getShiftBlue();

  if (p->isSwapped()) {
    // handle byteswapping if required
    if (p->getSize()==2) {
      return (ret>>8 | ret<<8) & 0x0000FFFF;
    } else if (p->getSize()==4) {
      return ret<<24 | ((ret<<16)&0x00FF0000) | ((ret>>16)&0x0000FF00) | ret>>24;
    }
  }
  return ret;
}

////////////////////////////////////////////////////////////////////////////////

void Colour::setFromPixel(const PixelDescriptor *p, uint32 data)
{
  // Converts a pixel value into a Colour using the specified PixelDescriptor.
  // This method is completely generic and assumes nothing
  // about the pixel format. For standard pixel formats, there are individually
  // optimised routines.

  if (p->isSwapped()) {
    // handle byteswapping if required
    if (p->getSize()==2) {
      data = (data<<8 | data>>8) & 0x0000FFFF;
    } else if (p->getSize()==4) {
      data = data<<24 | ((data<<16)&0x00FF0000) | ((data>>16)&0x0000FF00) | data>>24;
    }
  }

  argb = 0; // quickly zero colour representation

  // For each channel, isolate the bits using getMask...()
  // Convert masked range to integer using getShift...()
  // Scale by 255 and divide through by getMax...() to get the 0..255 range used by Colour

  // Note : is floating point scaling better for this?

  if ((data & p->getMaskAlpha())!=0) {
    alpha() = (uint8)((255UL*(data & p->getMaskAlpha())>>p->getShiftAlpha())/p->getMaxAlpha());
  }
  if (data & p->getMaskRed()!=0) {
    red() = (uint8)((255UL*(data & p->getMaskRed())>>p->getShiftRed())/p->getMaxRed());
  }
  if (data & p->getMaskGreen()!=0) {
    green() = (uint8)((255UL*(data & p->getMaskGreen())>>p->getShiftGreen())/p->getMaxGreen());
  }
  if (data & p->getMaskBlue()!=0) {
    blue() = (uint8)((255UL*(data & p->getMaskBlue())>>p->getShiftBlue())/p->getMaxBlue());
  }
}


////////////////////////////////////////////////////////////////////////////////
//
//  Palette
//
////////////////////////////////////////////////////////////////////////////////


void  Palette::scaleAlpha(float32 scf, sint8 ofs, uint8 min, uint8 max)
{
  register Colour* c = data;
  rsint32 t, n = 33;
  while (--n) {
    t = (sint32)(scf*c->alpha())+ofs; (c++)->alpha()=Clamp::integer(t, min, max);
    t = (sint32)(scf*c->alpha())+ofs; (c++)->alpha()=Clamp::integer(t, min, max);
    t = (sint32)(scf*c->alpha())+ofs; (c++)->alpha()=Clamp::integer(t, min, max);
    t = (sint32)(scf*c->alpha())+ofs; (c++)->alpha()=Clamp::integer(t, min, max);
    t = (sint32)(scf*c->alpha())+ofs; (c++)->alpha()=Clamp::integer(t, min, max);
    t = (sint32)(scf*c->alpha())+ofs; (c++)->alpha()=Clamp::integer(t, min, max);
    t = (sint32)(scf*c->alpha())+ofs; (c++)->alpha()=Clamp::integer(t, min, max);
    t = (sint32)(scf*c->alpha())+ofs; (c++)->alpha()=Clamp::integer(t, min, max);
  }
}

////////////////////////////////////////////////////////////////////////////////

void  Palette::scaleRed(float32 scf, sint8 ofs, uint8 min, uint8 max)
{
  register Colour* c = data;
  rsint32 t, n = 33;
  while (--n) {
    t = (sint32)(scf*c->red())+ofs; (c++)->red()=Clamp::integer(t, min, max);
    t = (sint32)(scf*c->red())+ofs; (c++)->red()=Clamp::integer(t, min, max);
    t = (sint32)(scf*c->red())+ofs; (c++)->red()=Clamp::integer(t, min, max);
    t = (sint32)(scf*c->red())+ofs; (c++)->red()=Clamp::integer(t, min, max);
    t = (sint32)(scf*c->red())+ofs; (c++)->red()=Clamp::integer(t, min, max);
    t = (sint32)(scf*c->red())+ofs; (c++)->red()=Clamp::integer(t, min, max);
    t = (sint32)(scf*c->red())+ofs; (c++)->red()=Clamp::integer(t, min, max);
    t = (sint32)(scf*c->red())+ofs; (c++)->red()=Clamp::integer(t, min, max);
  }
}

////////////////////////////////////////////////////////////////////////////////

void  Palette::scaleGreen(float32 scf, sint8 ofs, uint8 min, uint8 max)
{
  register Colour* c = data;
  rsint32 t, n = 33;
  while (--n) {
    t = (sint32)(scf*c->green())+ofs; (c++)->green()=Clamp::integer(t, min, max);
    t = (sint32)(scf*c->green())+ofs; (c++)->green()=Clamp::integer(t, min, max);
    t = (sint32)(scf*c->green())+ofs; (c++)->green()=Clamp::integer(t, min, max);
    t = (sint32)(scf*c->green())+ofs; (c++)->green()=Clamp::integer(t, min, max);
    t = (sint32)(scf*c->green())+ofs; (c++)->green()=Clamp::integer(t, min, max);
    t = (sint32)(scf*c->green())+ofs; (c++)->green()=Clamp::integer(t, min, max);
    t = (sint32)(scf*c->green())+ofs; (c++)->green()=Clamp::integer(t, min, max);
    t = (sint32)(scf*c->green())+ofs; (c++)->green()=Clamp::integer(t, min, max);
  }
}

////////////////////////////////////////////////////////////////////////////////

void  Palette::scaleBlue(float32 scf, sint8 ofs, uint8 min, uint8 max)
{
  register Colour* c = data;
  rsint32 t, n = 33;
  while (--n) {
    t = (sint32)(scf*c->blue())+ofs; (c++)->blue()=Clamp::integer(t, min, max);
    t = (sint32)(scf*c->blue())+ofs; (c++)->blue()=Clamp::integer(t, min, max);
    t = (sint32)(scf*c->blue())+ofs; (c++)->blue()=Clamp::integer(t, min, max);
    t = (sint32)(scf*c->blue())+ofs; (c++)->blue()=Clamp::integer(t, min, max);
    t = (sint32)(scf*c->blue())+ofs; (c++)->blue()=Clamp::integer(t, min, max);
    t = (sint32)(scf*c->blue())+ofs; (c++)->blue()=Clamp::integer(t, min, max);
    t = (sint32)(scf*c->blue())+ofs; (c++)->blue()=Clamp::integer(t, min, max);
    t = (sint32)(scf*c->blue())+ofs; (c++)->blue()=Clamp::integer(t, min, max);
  }
}

////////////////////////////////////////////////////////////////////////////////

size_t Palette::findBestMatch(const Colour& c, bool ignoreAlpha)
{
  if (ignoreAlpha) {
    size_t best = 0;
    return best;
  }
  else {
    size_t best = 0;
    return best;
  }
}

////////////////////////////////////////////////////////////////////////////////
//
//  ImageBuffer
//
////////////////////////////////////////////////////////////////////////////////

const P_DSC* ImageBuffer::getDescriptor() const
{
  if (pixFormat!=Pixel::OTHERFMT) {
    return PixelDescriptor::get(pixFormat);
  }
  return pixDesc;
}

////////////////////////////////////////////////////////////////////////////////

sint32 ImageBuffer::setPalette(Palette* p, bool copy, sint16 sz)
{
  if (copy)  {
    // If we have a palette allocated, copy the data to it
    // else create it and then copy from the pointer.
    // If the pointer is null, create the palette anyway
    // and zero it.

    if ( (!palette) || (!(properties & OWN_PALETTE)) ) {
      properties &= ~OWN_PALETTE;
      if (!(palette = (Palette*)Mem::alloc(sizeof(Palette), p ? false : true))) {
        return ERR_NO_FREE_STORE;
      }
      properties |= OWN_PALETTE;
    }
    if (p) {
      Mem::copy(palette, p, sizeof(Palette));
    }
  }
  else {
    // if we have a palette allocated, free it up
    if (properties & OWN_PALETTE) {
      properties &= ~OWN_PALETTE;
      if (palette) {
        Mem::free(palette);
      }
    }
    // assign the palette to the passed pointer
    palette = p;
  }
  palSize = Clamp::integer(sz, 0, 256);
  return OK;
}

////////////////////////////////////////////////////////////////////////////////

sint32 ImageBuffer::create(S_WH, P_F f, Palette* p, bool copyPal, sint16 sz)
{
  if (data) {
    return ERR_RSC_LOCKED;
  }
  if (w<1 || h<1) {
    return ERR_VALUE_MIN;
  }
  const PixelDescriptor* pD = PixelDescriptor::get(f);

  size_t size = w*h*(pD->getSize());

  if (!(data = Mem::alloc(size, false, Mem::ALIGN_CACHE))) {
    return ERR_NO_FREE_STORE;
  }
  properties = OWN_DATA;
  width = w;
  height = h;
  pixFormat = f;
  palSize = 0;
  if (pixFormat == Pixel::INDEX8) {
    if (setPalette(p, copyPal, sz)!=OK) {
      destroy();
      return ERR_RSC_UNAVAILABLE;
    }
  }
  return OK;
}

////////////////////////////////////////////////////////////////////////////////

sint32 ImageBuffer::create(S_WH, P_DSC* dsc, Palette* p, bool copyDsc, bool copyPal, sint16 sz)
{
  if (data) {
    return ERR_RSC_LOCKED;
  }
  if (w<1 || h<1) {
    return ERR_VALUE_MIN;
  }
  if (!dsc) {
    return ERR_PTR_ZERO;
  }
  size_t size = w*h*dsc->getSize();

  properties = 0;

  if (copyDsc) {
    if (!(pixDesc = new(nothrow) PixelDescriptor)) {
      return ERR_NO_FREE_STORE;
    }
    properties |= OWN_PIXDESC;
    *pixDesc = *dsc;
  }
  else {
    pixDesc = dsc;
  }
  if (!(data = Mem::alloc(size, false))) {
    return ERR_NO_FREE_STORE;
  }
  properties |= OWN_DATA;
  width = w;
  height = h;
  pixFormat = Pixel::OTHERFMT;
  palSize = 0;
  if (p) {
    if (setPalette(p, copyPal, sz)!=OK) {
      destroy();
      return ERR_RSC_UNAVAILABLE;
    }
  }
  return OK;
}

////////////////////////////////////////////////////////////////////////////////

void ImageBuffer::destroy()
{
  if ((properties & OWN_DATA) && data!=0) {
    Mem::free(data);
  }
  if ((properties & OWN_PALETTE) && palette!=0) {
    Mem::free(palette);
  }
  if ((properties & OWN_PIXDESC) && pixDesc!=0) {
    delete pixDesc;
  }
  properties = 0;
  data = 0;
  palette = 0;
  pixDesc = 0;
  palSize  = 0;
  width = height = 0;
  pixFormat = Pixel::INDEX8;
}

////////////////////////////////////////////////////////////////////////////////

void ImageBufferProvider::setIBData(ImageBuffer* img, void* data, bool setOwn)
{
  if (!img) return;
  if (img->data && (img->properties & ImageBuffer::OWN_DATA)) {
    Mem::free(img->data);
    img->properties &= ~ImageBuffer::OWN_DATA;
  }
  img->data = data;
  if (setOwn) {
    img->properties |= ImageBuffer::OWN_DATA;
  }
}

////////////////////////////////////////////////////////////////////////////////

void ImageBufferProvider::setIBPalette(ImageBuffer* img, Palette* pal, bool setOwn)
{
  if (!img) return;
  if (img->palette && (img->properties & ImageBuffer::OWN_PALETTE)) {
    Mem::free(img->palette);
    img->properties &= ~ImageBuffer::OWN_PALETTE;
  }
  img->palette = pal;
  if (setOwn) {
    img->properties |= ImageBuffer::OWN_PALETTE;
  }
}


////////////////////////////////////////////////////////////////////////////////
//
//  DisplayProperties
//
////////////////////////////////////////////////////////////////////////////////

DisplayProperties*  DisplayProperties::modesAvail = 0;

size_t DisplayProperties::numModes  = 0;
sint16 DisplayProperties::minWidth  = 640;
sint16 DisplayProperties::maxWidth  = 640;
sint16 DisplayProperties::minHeight  = 480;
sint16 DisplayProperties::maxHeight  = 480;
sint16 DisplayProperties::minDepth  = 8;
sint16 DisplayProperties::maxDepth  = 8;

////////////////////////////////////////////////////////////////////////////////

size_t DisplayProperties::findIndex(S_WHD, bool exact)
{
  sint32 found = 0;
  if (exact) {
    sint32 m = 0;
    while (++m < numModes && found == 0) {
      found = ((modesAvail[m].getW() == w) &&
               (modesAvail[m].getH() == h) &&
               (modesAvail[m].getDepth() == d)) ? m : 0;
    }
  }
  else {
    sint32 m = 0;
    while (++m < numModes && found == 0) {
      found = ((modesAvail[m].getW() >= w) &&
               (modesAvail[m].getH() >= h) &&
               (modesAvail[m].getDepth() >= d)) ? m : 0;
    }
  }
  return found;
}

////////////////////////////////////////////////////////////////////////////////
//
//  DisplayPropertiesProvider
//
////////////////////////////////////////////////////////////////////////////////

DisplayProperties* DisplayPropertiesProvider::createModeDatabase(size_t n)
{
  if (!DisplayProperties::modesAvail)  {
    void* p = Mem::alloc(n*sizeof(D_PRP), true);
    if (p) {
      DisplayProperties::numModes = n;
      DisplayProperties::modesAvail = (D_PRP*)p;
    }
    else {
      DisplayProperties::numModes = 0;
      return 0;
    }
  }
  // First mode is basically window mode referece
  setTiming(0, 1, 1);
  setDimension(0, 320, 240);
  setPropertyFlags(0, D_PRP::WINDOWMODE);
  setFormat(0, Pixel::MAXHWTYPES);
  setName(0, "Windowed");
  return DisplayProperties::modesAvail;
}

////////////////////////////////////////////////////////////////////////////////

void DisplayPropertiesProvider::freeModeDatabase()
{
  if (DisplayProperties::modesAvail) {
    Mem::free(DisplayProperties::modesAvail);
  }
  DisplayProperties::modesAvail = 0;
  DisplayProperties::numModes = 0;
}

////////////////////////////////////////////////////////////////////////////////

void DisplayPropertiesProvider::setLimits(sint16 minW, sint16 maxW,
sint16 minH, sint16 maxH, sint16 minD, sint16 maxD)
{
  DisplayProperties::minWidth = minW;
  DisplayProperties::maxWidth = maxW;
  DisplayProperties::minHeight = minH;
  DisplayProperties::maxHeight = maxH;
  DisplayProperties::minDepth = minD;
  DisplayProperties::maxDepth = maxD;
}

bool DisplayPropertiesProvider::setModeIndex(size_t i,uint32 val)
{
  if (DisplayProperties::modesAvail && i < DisplayProperties::numModes) {
    DisplayProperties::modesAvail[i].modeIndex = val;
    return true;
  }
  return false;
}

////////////////////////////////////////////////////////////////////////////////

bool DisplayPropertiesProvider::setTiming(size_t i, uint32 h, uint32 v)
{
  if (DisplayProperties::modesAvail && i < DisplayProperties::numModes) {
    DisplayProperties::modesAvail[i].horizRefreshNanoSec = h;
    DisplayProperties::modesAvail[i].vertRefreshMicroSec = v;
    return true;
  }
  return false;
}

////////////////////////////////////////////////////////////////////////////////

bool DisplayPropertiesProvider::setDimension(size_t i, S_WH)
{
  if (DisplayProperties::modesAvail && i < DisplayProperties::numModes) {
    DisplayProperties::modesAvail[i].width = w;
    DisplayProperties::modesAvail[i].height = h;
    DisplayProperties::modesAvail[i].aspect = ((float32)h/(float32)w)/0.75;
    return true;
  }
  return false;
}

////////////////////////////////////////////////////////////////////////////////

bool DisplayPropertiesProvider::setAspect(size_t i, float32 a)
{
  if (DisplayProperties::modesAvail && i < DisplayProperties::numModes) {
    DisplayProperties::modesAvail[i].aspect = a;
    return true;
  }
  return false;
}

////////////////////////////////////////////////////////////////////////////////

bool DisplayPropertiesProvider::setPropertyFlags(size_t i, uint16 f)
{
  if (DisplayProperties::modesAvail && i < DisplayProperties::numModes) {
    DisplayProperties::modesAvail[i].properties = f;
    return true;
  }
  return false;
}

////////////////////////////////////////////////////////////////////////////////

bool DisplayPropertiesProvider::setFormat(size_t i, P_F f, P_D d)
{
  if (DisplayProperties::modesAvail && i < DisplayProperties::numModes) {
    DisplayProperties::modesAvail[i].pixFormat = f;
    if (d==Pixel::BPPUNK) {
      switch (f) {
        case Pixel::INDEX8:  d = Pixel::BPP8; break;
        case Pixel::RGB15B:
        case Pixel::BGR15B:
        case Pixel::RGB15L:
        case Pixel::BGR15L:  d = Pixel::BPP15; break;
        case Pixel::RGB16B:
        case Pixel::BGR16B:
        case Pixel::RGB16L:
        case Pixel::BGR16L:  d = Pixel::BPP16; break;
        case Pixel::RGB24P:
        case Pixel::BGR24P:  d = Pixel::BPP24; break;
        case Pixel::ARGB32B:
        case Pixel::ABGR32B:
        case Pixel::ABGR32L:
        case Pixel::ARGB32L:d = Pixel::BPP32; break;
        default: break;
      }
    }
    DisplayProperties::modesAvail[i].depth = d;
    return true;
  }
  return false;
}

////////////////////////////////////////////////////////////////////////////////

bool DisplayPropertiesProvider::setName(size_t i, const char* title)
{
  if (DisplayProperties::modesAvail && i < DisplayProperties::numModes) {
    strncpy(DisplayProperties::modesAvail[i].name, title, 31);
    return true;
  }
  return false;
}

////////////////////////////////////////////////////////////////////////////////

