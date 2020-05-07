//****************************************************************************//
//**                                                                        **//
//** File:         include/gfxlib/gfxutil.hpp                               **//
//** Description:  Graphics Utilities                                       **//
//** Comment(s):   Stub header                                              **//
//** Library:      gfxlib                                                   **//
//** Created:      2003-04-27                                               **//
//** Updated:      2003-04-27                                               **//
//** Author(s):    Karl Churchill                                           **//
//** Note(s):                                                               **//
//** Copyright:    (C)1996-2003, eXtropia Studios                           **//
//**               Serkan YAZICI, Karl Churchill                            **//
//**               All Rights Reserved.                                     **//
//**                                                                        **//
//****************************************************************************//

#ifndef _EXTROPIA_GFXLIB_UTIL_HPP
#define _EXTROPIA_GFXLIB_UTIL_HPP

#include <gfxlib/gfx.hpp>
#include <iolib/fileio.hpp>

////////////////////////////////////////////////////////////////////////////////
//
//  ImageLoader
//
//
//
////////////////////////////////////////////////////////////////////////////////

class ImageLoader : private ImageBufferProvider {
  public:
    static ImageBuffer* loadImage(const char* name, bool align=true);
};

#endif