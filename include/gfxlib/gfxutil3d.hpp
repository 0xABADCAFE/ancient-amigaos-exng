//****************************************************************************//
//**                                                                        **//
//** File:         include/gfxlib/gfxutil3d.hpp                             **//
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

#ifndef _EXTROPIA_GFXLIB_GFXUTIL3D_HPP
#define _EXTROPIA_GFXLIB_GFXUTIL3D_HPP

#include <gfxlib/gfx3d.hpp>
#include <iolib/fileio.hpp>

////////////////////////////////////////////////////////////////////////////////
//
//  TextureLoader
//
////////////////////////////////////////////////////////////////////////////////

class TextureLoader {
  public:
    static sint32    loadPPM(Texture* tex, const char* ppm, G3D::Texel fmt);
    static sint32    loadPPMPGM(Texture* tex, const char* ppm, const char* pgm, G3D::Texel fmt);
    static Texture*  loadPPM(const char* ppm, G3D::Texel fmt);
};

#endif