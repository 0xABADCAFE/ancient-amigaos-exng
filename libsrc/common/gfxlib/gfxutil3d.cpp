//****************************************************************************//
//**                                                                        **//
//** File:         libsrc/common/gfxlib/gfxutil3d.cpp                       **//
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

#include <gfxlib/gfxutil3d.hpp>

////////////////////////////////////////////////////////////////////////////////

sint32 TextureLoader::loadPPM(Texture* tex, const char* ppm, G3D::Texel fmt)
{
  // We need a valid, empty texture to load the data into
  if (!tex || !ppm)
    return ERR_PTR_ZERO;
  if (tex->getData())
    return ERR_RSC_LOCKED;

  // Eliminate any texel types unsuitable for RGB data
  switch (fmt) {
    case G3D::TXL_LUT8:
    case G3D::TXL_G8:
    case G3D::TXL_I8:
    case G3D::TXL_A8:
    case G3D::TXL_GA88:  return ERR_RSC_TYPE; break;
    default: break;
  }

  StreamIn ppmFile;
  sint32 result = ppmFile.open(ppm, false);
  if (result!=OK)
    return result;

  // Read the textual PPM header (4 lines)
  char header[64];
  result = ppmFile.readText(header, 63, '\n', 4);
  if (result <0)
    return result;

  // Scan the header and validate the size information
  sint32 width, height;
  if (sscanf(header, "P6\n%ld\n%ld\n255\n", &width, &height)!=2)
    return IOS::ERR_FILE_READ;
  if (width < G3D::MIN_TEX_WIDTH    || width > G3D::MAX_TEX_WIDTH ||
      height < G3D::MIN_TEX_HEIGHT  || height > G3D::MAX_TEX_HEIGHT)
    return ERR_VALUE;

  // Create the texture
  result = tex->create(width, height, fmt);
  if (result!=OK)
    return result;

  // Load the body data, converting to texel format on-the-fly, setting any
  // alpha channel data opaque...
  size_t numTexels = width*height;
  switch (fmt) {
    case G3D::TXL_RGB16:
    {
      uint16* data = (uint16*)tex->getData();
      numTexels++;
      while (--numTexels && !ppmFile.end())
      {
        ruint16 txl = ((uint8)ppmFile.getChar()&0xF8)<<8;
        txl |= ((uint8)ppmFile.getChar()&0xFC)<<3;
        txl |= ((uint8)ppmFile.getChar())>>3;
        *data++ = txl;
      }
      if (numTexels!=0)
        return IOS::WRN_FILE_READ;
      return OK;
    }

    case G3D::TXL_A1RGB15:
    {
      uint16* data = (uint16*)tex->getData();
      numTexels++;
      while (--numTexels && !ppmFile.end())
      {
        ruint16 txl = 0x8000 | ((uint8)ppmFile.getChar()&0xF8)<<7;
        txl |= ((uint8)ppmFile.getChar()&0xF8)<<2;
        txl |= ((uint8)ppmFile.getChar())>>3;
        *data++ = txl;
      }
      if (numTexels!=0)
        return IOS::WRN_FILE_READ;
      return OK;
    }

    case G3D::TXL_A4RGB12:
    {
      uint16* data = (uint16*)tex->getData();
      numTexels++;
      while (--numTexels && !ppmFile.end())
      {
        ruint16 txl = 0xF000 | ((uint8)ppmFile.getChar()&0xF0)<<4;
        txl |= ((uint8)ppmFile.getChar()&0xF0);
        txl |= ((uint8)ppmFile.getChar())>>4;
        *data++ = txl;
      }
      if (numTexels!=0)
        return IOS::WRN_FILE_READ;
      return OK;
    }

    case G3D::TXL_RGB24:
    {
      numTexels*=3;
      result = ppmFile.read8(tex->getData(), numTexels);
      if (result<0)
        return result;
      if (result==numTexels)
        return OK;
      return IOS::WRN_FILE_READ;
    }

    case G3D::TXL_ARGB32:
    {
      uint32* data = (uint32*)tex->getData();
      numTexels++;
      while (--numTexels && !ppmFile.end())
      {
        ruint32 txl = 0xFF000000 | ((uint8)ppmFile.getChar())<<16;
        txl |= ((uint8)ppmFile.getChar())<<8;
        txl |= ((uint8)ppmFile.getChar());
        *data++ = txl;
      }
      if (numTexels!=0)
        return IOS::WRN_FILE_READ;
      return OK;
    }

    case G3D::TXL_RGBA32:
    {
      uint32* data = (uint32*)tex->getData();
      numTexels++;
      while (--numTexels && !ppmFile.end())
      {
        ruint32 txl = 0x000000FF | ((uint8)ppmFile.getChar())<<24;
        txl |= ((uint8)ppmFile.getChar())<<16;
        txl |= ((uint8)ppmFile.getChar())<<8;
        *data++ = txl;
      }
      if (numTexels!=0)
        return IOS::WRN_FILE_READ;
      return OK;
    }
    break;

    default: return ERR_VALUE; break;
  }
}

////////////////////////////////////////////////////////////////////////////////

sint32 TextureLoader::loadPPMPGM(Texture* tex, const char* ppm, const char* pgm, G3D::Texel fmt)
{
  return OK;
}

////////////////////////////////////////////////////////////////////////////////
