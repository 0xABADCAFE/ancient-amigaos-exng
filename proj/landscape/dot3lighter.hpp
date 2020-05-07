//****************************************************************************//
//**                                                                        **//
//** File:         proj/landscape/app.hpp                                   **//
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

#ifndef _LIGHT_HPP
#define _LIGHT_HPP

#include <xbase.hpp>
#include <gfxlib/gfx.hpp>

extern "C" {
#include <math.h>
}

class Dot3Lighter {
  private:
    static  sint32  count;
    static  sint8*  nMuls;
    uint16  ux;
    uint16  uy;
    uint16  uz;
    uint16  pd;

    static  void calculateTable();

  public:
    //void  illuminate(ImageBuffer* rgb, ImageBuffer* dot3);
    void  setLightVector(float32 x, float32 y, float32 z);

    ImageBuffer*  createGreyScale(ImageBuffer* dot3);

  public:
    Dot3Lighter();
    ~Dot3Lighter();
};

#endif