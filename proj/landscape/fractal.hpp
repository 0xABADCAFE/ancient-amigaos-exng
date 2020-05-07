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

#ifndef _FRACTAL_HPP
#define _FRACTAL_HPP

#include <xbase.hpp>
#include <gfxlib/gfx.hpp>

extern "C" {
#include <math.h>
}

class FractalMap {
  friend class FractalMapProcessor;
  private:
    sint32  seed;
    sint16   dim;
    sint16   size;
    float32  rough;
    float32  decay;
    float32  finalMin;
    float32 finalMax;
    float32  *data;

  private:
    float32& point(sint32 x, sint32 y) {
      return data[(y<<dim)+y+x];
    }

    float32 rnd(float32 scale) {
      return scale*(((2.0/RAND_MAX)*rand())-1.0);
    }

    void square(sint32 x, sint32 y, sint32 side, float32 scale) {
      sint32 half = side>>1;
      sint32 sum = 0;
      float32 avg = 0.0f;
      if (x>=0) {
        avg += point(x, y+half); sum++;
      }
      if (y>=0) {
        avg += point(x+half, y); sum++;
      }
      if (x+side <= dim) {
        avg += point(x+side, y+half); sum++;
      }
      if (y+side <= dim) {
        avg += point(x+half, y+side); sum++;
      }
      avg = (avg/(float32)sum)+rnd(scale);
      if (avg<finalMin)
        finalMin = avg;
      else if (avg>finalMax)
        finalMax = avg;
      point(x+half, y+half) = avg;
    }

    void diamond(sint32 x, sint32 y, sint32 side, float32 scale) {
      if (side>1) {
        sint32 half=side>>1;
        float32 avg = 0.25f*(point(x,y)+
                             point(x+side,y)+
                             point(x+side,y+side)+
                             point(x,y+side));
        avg = avg+rnd(scale);
        if (avg<finalMin)
          finalMin = avg;
        else if (avg>finalMax)
          finalMax = avg;
        point(x+half, y+half) = avg;
      }
    }

  public:
    void calculate1();  // diamond square
    void calculate2();  // regular

    float32 getSample(sint32 x, sint32 y) {
      x &= (size-1);
      y &= (size-1);
      return data[(y<<dim)+y+x];
    }

    bool isValid() { return data!=0 ? true : false; }

  public:
    ImageBuffer* exportGreyScale(sint16 x=0, sint16 y=0, sint16 w=-1, sint16 h=-1);
    ImageBuffer* exportRGB(const char* pal, sint16 x=0, sint16 y=0, sint16 w=-1, sint16 h=-1);
    ImageBuffer* exportNormalMap(float32 zScale, sint16 x=0, sint16 y=0, sint16 w=-1, sint16 h=-1);

  public:
    FractalMap(sint32 seed, sint32 dim, float32 rough, float32 decay);
    ~FractalMap();
};

#endif