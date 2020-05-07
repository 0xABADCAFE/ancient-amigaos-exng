//****************************************************************************//
//**                                                                        **//
//** File:         include/utilitylib/quickmath.hpp                         **//
//** Description:  Quick approximations for trancendal functions            **//
//** Comment(s):                                                            **//
//** Library:      utilitylib                                               **//
//** Created:      2003-02-09                                               **//
//** Updated:      2003-02-09                                               **//
//** Author(s):    Karl Churchill                                           **//
//** Note(s):                                                               **//
//** Copyright:    (C)1996-2003, eXtropia Studios                           **//
//**               Serkan YAZICI, Karl Churchill                            **//
//**               All Rights Reserved.                                     **//
//**                                                                        **//
//****************************************************************************//

#ifndef _EXTROPIA_UTILITYLIB_QUICKMATH_HPP
#define _EXTROPIA_UTILITYLIB_QUICKMATH_HPP

#include <xbase.hpp>

extern "C" {
  #include <math.h>
  #include <limits.h>
}

////////////////////////////////////////////////////////////////////////////////
//
//  class QMath
//
////////////////////////////////////////////////////////////////////////////////

#define PI64 3.1415926536    // float64 PI
#define PI32 3.1415926536f  // float32 PI

class QMath {
  private:

    enum {
      DATASIZEX  = 10,            // Table size exponent
      DATASIZE  = 1<<DATASIZEX,  // Table size
      E_MIN_INT  = -88,          // exp(E_MIN_INT) > 1.0x10e-38
      E_RANGE    = 176            // exp(E_MIN_INT+E_RANGE) < 1.0x10e+38
    };

    static float32*  data;
    // Holds DATASIZE+2 points for sin(x)  : x = 0.0...PI/2

    static float32*  arcData;
    // Holds DATASIZE+2 points for asin(x) : x = 0.0...1.0

    static float32*  eFrac;
    // Holds DATASIZE+2 points for exp(x)  : x = -1.0...0

    static float32*  eInt;
    // Holds E_RANGE points for exp(x) : x = -88...+88

  public:
    typedef uint32 iangle;

    // Fastest methods, choose indexed value directly
    static float32  sini(iangle i) {
      if (i<DATASIZE)
        return data[i];                // sin(0...PI/2)
      else if (i<(2*DATASIZE))
        return data[(2*DATASIZE)-i];  // sin(PI/2...PI)
      else if (i<(3*DATASIZE))
        return -data[i-(2*DATASIZE)];  // sin(PI...3PI/2)
      else if (i<(4*DATASIZE))
        return -data[(4*DATASIZE)-i];  // sin(3PI/2...2PI)
      else
        return data[i-4*DATASIZE];
    }

    static float32  cosi(iangle i) {
      if (i<DATASIZE)
        return data[DATASIZE-i];      // cos(0...PI/2)
      else if (i<(2*DATASIZE))
        return -data[i-DATASIZE];      // cos(PI/2...PI)
      else if (i<(3*DATASIZE))
        return -data[(3*DATASIZE)-i];  // cos(PI...3PI/2)
      else if (i<(4*DATASIZE))
        return data[i-(3*DATASIZE)];  // cos(3PI/2...2PI)
      else
        return data[5*DATASIZE-i];
    }

    static float32  tani(iangle i) {
      if (i<DATASIZE)
        return data[i]/data[DATASIZE-i];
      else if (i<(2*DATASIZE))
        return -data[(2*DATASIZE)-i]/data[i-DATASIZE];
      else if (i<(3*DATASIZE))
        return data[i-(2*DATASIZE)]/data[(3*DATASIZE)-i];
      else if (i<(4*DATASIZE))
        return -data[(4*DATASIZE)-i]/data[i-(3*DATASIZE)];
      else
        return data[i-4*DATASIZE]/data[5*DATASIZE-i];
    }

    static float32  expi(sint32 i) {
      return (i<E_MIN_INT) ? 0 :
      ( (i>(E_MIN_INT+E_RANGE)) ? HUGE_VAL : eInt[i-E_MIN_INT]);
    }


    // AngleModulus : any angle conversion to ranged (0-2PI)
    static sint32    angleModI(iangle i) {
      if (i<0)
        return (4*DATASIZE)+(i & (4*DATASIZE-1));
      else if (i<(4*DATASIZE))
        return i;
      else
        return i & (4*DATASIZE-1);
    }

    static float32 angleMod(float32 x);

    // Quicker versions, inlined, choose closest indexed value
    static float32  sinq(float32 x) {
      x*=(2*DATASIZE/PI32); x+=0.5f;
      return sini((iangle)x);
    }
    static float32  cosq(float32 x) {
      x*=(2*DATASIZE/PI32); x+=0.5f;
      return cosi((iangle)x);
    }

    static float32  tanq(float32 x) {
      x*=(2*DATASIZE/PI32); x+=0.5f;
      return tani((iangle)x);
    }

    static float32  asinq(float32 x) {
      x*=DATASIZE;
      return (x<0.0f) ?
      -arcData[(uint32)(-0.5F-x)] : arcData[(uint32)(0.5F+x)];
    }

    static float32  acosq(float32 x) {
      x*=DATASIZE;
      return (x<0.0f) ?
      (PI32/2)+arcData[(uint32)(-0.5F-x)] : (PI32/2)-arcData[(uint32)(0.5F+x)];
    }

    // Normal trig methods. Linear interpolation of two nearest indexed values
    static float32  atanq(float32 x);
    static float32  sin(float32 x);
    static float32  cos(float32 x);
    static float32  tan(float32 x);
    static float32  asin(float32 x);
    static float32  acos(float32 x);
    static float32  atan(float32 x);
    static float32  exp(float32 x);

    static sint32    init();
    static void      done();
};

#endif
