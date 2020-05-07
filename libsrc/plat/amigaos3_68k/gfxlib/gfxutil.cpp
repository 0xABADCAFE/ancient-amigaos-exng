//****************************************************************************//
//**                                                                        **//
//** File:         libsrc/plat/amigaos3_68k/gfxlib/gfxutil.cpp              **//
//** Description:  Graphic utility class definitions                        **//
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

#include <gfxlib/gfxutil.hpp>
#include <new.h>

namespace X_SYSNAME {
  extern "C" {
    #include <clib/alib_protos.h>
    #include <clib/dos_protos.h>
    #include <clib/datatypes_protos.h>
    #include <datatypes/pictureclass.h>
  }
};

using namespace X_SYSNAME;

////////////////////////////////////////////////////////////////////////////////

ImageBuffer* ImageLoader::loadImage(const char* fileName, bool align)
{
  if (!fileName)
    return 0;
  ImageBuffer* img = new(nothrow) ImageBuffer;
  if (!img)
    return 0;

  // Create a picture datatype instance from the filename. We are only
  // concerned with obtaining the internal pixel array data so we need
  // to use v43 compliant image datatypes only.

  Object* src = NewDTObject((char*)fileName, DTA_GroupID, GID_PICTURE,
                            PDTA_Remap, FALSE, PDTA_DestMode, PMODE_V43,
                            TAG_END);
  if (src)
  {
    uint32   numColours;
    uint32*  clrRegs;

    // Load and decode whatever image we were given. AmigaOS Datatypes rule.
    // The ImageLoader services are gonna be a pain on other platforms

    DoMethod(src, DTM_PROCLAYOUT, NULL, 1);
    BitMapHeader* srcHead;
    GetDTAttrs(src,
               PDTA_BitMapHeader,  &srcHead,
               PDTA_NumColors,    &numColours,
               PDTA_CRegs,        &clrRegs,
               TAG_END);

    uint32        cpyFmt;
    Pixel::HWType  dstFmt;
    sint32        dstBytesPerRow;
    bool          usePal = false;

    if (srcHead->bmh_Depth<=8)
    {
      dstFmt  = Pixel::INDEX8;
      cpyFmt  = PBPAFMT_LUT8;
      usePal  = true;
      dstBytesPerRow = srcHead->bmh_Width;
    }
    else if (srcHead->bmh_Depth<=24 && align==false)
    {
      // For performance reasons, we only choose 24-bit
      // pixels when no alignment is asked for.
      // Othewise go to 32-bits, even if source is RGB
      // only.
      dstFmt  = Pixel::RGB24P;
      cpyFmt  = PBPAFMT_RGB;
      dstBytesPerRow = srcHead->bmh_Width*3;
    }
    else
    {
      dstFmt  = Pixel::ARGB32B;
      cpyFmt  = PBPAFMT_ARGB;
      dstBytesPerRow = srcHead->bmh_Width*4;
    }

    // Allocate the image data
    if (img->create(srcHead->bmh_Width, srcHead->bmh_Height,
                    dstFmt, 0, usePal, numColours)==OK)
    {
      // Copy the datatype pixelarray to the image data
      DoMethod(src, PDTM_READPIXELARRAY, img->getData(), cpyFmt,
               dstBytesPerRow, 0, 0, srcHead->bmh_Width,
               srcHead->bmh_Height);

      // For 8-bit images, copy any palette data
      if (dstFmt == Pixel::INDEX8 && clrRegs!=0)
      {
        Palette* clr = img->getPalette();
        if (clr)
        {
          for (sint32 i=0; i<numColours;i++)
          {
            (*clr)[i].red()=(*(clrRegs++)>>24);
            (*clr)[i].green()=(*(clrRegs++)>>24);
            (*clr)[i].blue()=(*(clrRegs++)>>24);
          }
        }
      }
    }
    DisposeDTObject(src);

    // All done
    return img;
  }
  // Datatype failed
  delete img;
  return 0;
}

////////////////////////////////////////////////////////////////////////////////
