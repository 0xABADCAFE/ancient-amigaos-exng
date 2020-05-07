//****************************************************************************//
//**                                                                        **//
//** File:         render.hpp                                               **//
//** Description:  Drawing functions                                        **//
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

#ifndef _EXTROPIA_GFXLIB_RENDER_HPP
#define _EXTROPIA_GFXLIB_RENDER_HPP

#include <gfxlib/gfx.hpp>

class SoftRender {

  public:
/*
    static void lineV8(void* base, sint16 span, sint16 x, sint16 y1, sint16 y2, uint8 v);
    static void lineV16(void* base, sint16 span, sint16 x, sint16 y1, sint16 y2, uint16 v);
    static void lineV24(void* base, sint16 span, sint16 x, sint16 y1, sint16 y2, uint32 v);
    static void lineV32(void* base, sint16 span, sint16 x, sint16 y1, sint16 y2, uint32 v);

    static void lineH8(void* base, sint16 span, sint16 x1, sint16 x2, sint16 y, uint8 v);
    static void lineH16(void* base, sint16 span, sint16 x1, sint16 x2, sint16 y, uint16 v);
    static void lineH24(void* base, sint16 span, sint16 x1, sint16 x2, sint16 y, uint32 v);
    static void lineH32(void* base, sint16 span, sint16 x1, sint16 x2, sint16 y, uint32 v);
*/

    static void line8(REGP0 void* base, sint16 span, S_2CRD, uint8 v);
    static void line16(REGP0 void* base, sint16 span, S_2CRD, uint16 v);
    static void line24(REGP0 void* base, sint16 span, S_2CRD, uint8* v);
    static void line32(REGP0 void* base, sint16 span, S_2CRD, uint32 v);


    static void lineRGB16(REGP0 void* base, sint16 span, S_2CRD, Colour c1, Colour c2);
};



////////////////////////////////////////////////////////////////////////////////


#endif