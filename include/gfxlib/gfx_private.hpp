//****************************************************************************//
//**                                                                        **//
//** File:         include/gfxlib/gfx.hpp                                   **//
//** Description:  Common graphics definitions                              **//
//** Comment(s):   Stub header                                              **//
//** Library:      gfxlib                                                   **//
//** Created:      2003-02-22                                               **//
//** Updated:      2003-03-02                                               **//
//** Author(s):    Karl Churchill                                           **//
//** Note(s):                                                               **//
//** Copyright:    (C)1996-2003, eXtropia Studios                           **//
//**               Serkan YAZICI, Karl Churchill                            **//
//**               All Rights Reserved.                                     **//
//**                                                                        **//
//****************************************************************************//

#ifndef _EXTROPIA_GFXLIB_PRIVATE_HPP
#define _EXTROPIA_GFXLIB_PRIVATE_HPP

class PixelProvider {
  protected:
    static void setPrefFormat(Pixel::Depth d, Pixel::HWType t)
    {
      Pixel::formats[d] = t;
    }
};

////////////////////////////////////////////////////////////////////////////////
//
//  PixelDescriptorProvider
//
////////////////////////////////////////////////////////////////////////////////

class PixelDescriptorProvider {
  protected:
    void setFormat(PixelDescriptor* p, bool swp, bool idx)
    {
      p->swapMode  = swp ? 1 : 0;
      p->indexed  = idx ? 1 : 0;
    }

    void setSize(PixelDescriptor* p, uint8 size)
    {
      p->size = size;
    }

    void setAlpha(PixelDescriptor* p, uint8 bits, uint8 ofs)
    {
      p->bAlpha = bits;
      p->sAlpha = ofs;
    }

    void setRed(PixelDescriptor* p, uint8 bits, uint8 ofs)
    {
      p->bRed = bits;
      p->sRed = ofs;
    }

    void setGreen(PixelDescriptor* p, uint8 bits, uint8 ofs)
    {
      p->bGreen = bits;
      p->sGreen = ofs;
    }

    void setBlue(PixelDescriptor* p, uint8 bits, uint8 ofs)
    {
      p->bBlue = bits;
      p->sBlue = ofs;
    }
};

////////////////////////////////////////////////////////////////////////////////
//
//  ImageBufferProvider
//
////////////////////////////////////////////////////////////////////////////////

class ImageBufferProvider {
  protected:
    static void setIBProps(ImageBuffer* img, bool ownDat, bool ownPal, bool ownDsc)
    {
      if (img) {
        img->properties = (ownDat ? ImageBuffer::OWN_DATA : 0) |
                          (ownPal ? ImageBuffer::OWN_PALETTE : 0) |
                          (ownDsc ? ImageBuffer::OWN_PIXDESC : 0);
      }
    }

    static bool hasOwnData(ImageBuffer* img)
    {
      if (img && (img->properties & ImageBuffer::OWN_DATA)) {
        return true;
      }
      return false;
    }

    static bool hasOwnPalette(ImageBuffer* img)
    {
      if (img && (img->properties & ImageBuffer::OWN_PALETTE)) {
        return true;
      }
      return false;
    }

    static bool hasOwnDescriptor(ImageBuffer* img)
    {
      if (img && (img->properties & ImageBuffer::OWN_PIXDESC)) {
        return true;
      }
      return false;
    }

    static void setIBFormat(ImageBuffer* img, P_F fmt)
    {
      if (img) {
        img->pixFormat = fmt;
      }
    }

    static void setIBPalSize(ImageBuffer* img, size_t s)
    {
      if (img) {
        img->palSize = s;
      }
    }

    static void setIBSize(ImageBuffer* img, S_WH)
    {
      if (img) {
        img->width = w;
        img->height = h;
      }
    }

    static void setIBData(ImageBuffer* img, void* data, bool setOwn);
    static void setIBPalette(ImageBuffer* img, Palette* data, bool setOwn);
};

////////////////////////////////////////////////////////////////////////////////
//
//  DisplayPropsModifier
//
//  Provides a list of DisplayProperties for all the available resolutions etc.
//  supported on the current system. This interface allows modification of
//  the DisplayProperties objects held in the list. The platform dependent
//  GfxLib class should implement the DisplayPropertyProvider to construct a
//  valid list of all available display modes.
//
////////////////////////////////////////////////////////////////////////////////

class DisplayPropertiesProvider {
  //friend class Display;

  protected:
    static void   setLimits(sint16 minW, sint16 maxW, sint16 minH, sint16 maxH, sint16 minD, sint16 maxD);
    static D_PRP* createModeDatabase(size_t n);
    static void   freeModeDatabase();
    static D_PRP* createNewProperty();
    static bool   setModeIndex(size_t i, uint32 e);
    static bool   setTiming(size_t i, uint32 h, uint32 v);
    static bool   setDimension(size_t i, S_WH);
    static bool   setAspect(size_t i, float32 a);
    static bool   setPropertyFlags(size_t i, uint16 f);
    static bool   setFormat(size_t i, P_F f, P_D d = Pixel::BPPUNK);
    static bool   setName(size_t i, const char* title);
};

////////////////////////////////////////////////////////////////////////////////

#if defined(XP_AMIGAOS3_68K)
  #include "plat/amigaos3_68k/gfxlib/gfx.hpp"
  #include "plat/amigaos3_68k/gfxlib/surface.hpp"
  #include "plat/amigaos3_68k/gfxlib/display.hpp"

#elif defined(XP_AMIGAOS3_PPC)
  #include "plat/amigaos3_wos/gfxlib/gfx.hpp"
  #include "plat/amigaos3_wos/gfxlib/surface.hpp"
  #include "plat/amigaos3_wos/gfxlib/display.hpp"

#elif defined(XP_AMIGAOS4)
  #include "plat/amigaos4/gfxlib/gfx.hpp"
  #include "plat/amigaos4/gfxlib/surface.hpp"
  #include "plat/amigaos4/gfxlib/display.hpp"

#elif defined(XP_AROS_BE)
  #include "plat/aros_be/gfxlib/gfx.hpp"
  #include "plat/aros_be/gfxlib/surface.hpp"
  #include "plat/aros_be/gfxlib/display.hpp"

#elif defined(XP_AROS_LE)
  #include "plat/aros_le/gfxlib/gfx.hpp"
  #include "plat/aros_le/gfxlib/surface.hpp"
  #include "plat/aros_le/gfxlib/display.hpp"

#elif defined(XP_MORPHOS)
  #include "plat/morphos/gfxlib/gfx.hpp"
  #include "plat/morphos/gfxlib/surface.hpp"
  #include "plat/morphos/gfxlib/display.hpp"

#elif defined(XP_LINUX_PPC)
  #include "plat/linux_ppc/gfxlib/gfx.hpp"
  #include "plat/linux_ppc/gfxlib/surface.hpp"
  #include "plat/linux_ppc/gfxlib/display.hpp"

#elif defined(XP_LINUX_X86)
  #include "plat/linux_i386/gfxlib/gfx.hpp"
  #include "plat/linux_i386/gfxlib/surface.hpp"
  #include "plat/linux_i386/gfxlib/display.hpp"

#elif defined(XP_WIN32)
  #include "plat/win32/gfxlib/gfx.hpp"
  #include "plat/win32/gfxlib/surface.hpp"
  #include "plat/win32/gfxlib/display.hpp"

#elif defined(XP_WIN2K)
  #include "plat/win2k/gfxlib/gfx.hpp"
  #include "plat/win2k/gfxlib/surface.hpp"
  #include "plat/win2k/gfxlib/display.hpp"

#elif defined(XP_MACOSX)
  #include "plat/macosx/gfxlib/gfx.hpp"
  #include "plat/macosx/gfxlib/surface.hpp"
  #include "plat/macosx/gfxlib/display.hpp"

#else
  #error "Platform implementation not defined"
#endif


#endif
