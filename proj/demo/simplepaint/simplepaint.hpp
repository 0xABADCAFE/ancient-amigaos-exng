//****************************************************************************//
//**                                                                        **//
//** File:         proj/SimpleView/simpleview.hpp                           **//
//** Description:  Simple paint tool r                                      **//
//** Comment(s):                                                            **//
//** Created:      2003-04-30                                               **//
//** Updated:      2003-09-22                                               **//
//** Author(s):    Karl Churchill                                           **//
//** Note(s):                                                               **//
//** Copyright:    (C)1996-2003, eXtropia Studios                           **//
//**               Serkan YAZICI, Karl Churchill                            **//
//**               All Rights Reserved.                                     **//
//**                                                                        **//
//****************************************************************************//

#ifndef _SIMPLEPAINT_HPP
#define _SIMPLEPAINT_HPP

#include <xbase.hpp>
#include <gfxlib/gfx.hpp>
#include <gfxlib/gfxapp.hpp>
#include <gfxlib/gfxutil.hpp>

#include <new.h>

extern "C" {
  #include <math.h>
}

////////////////////////////////////////////////////////////////////////////////
//
//  SimplePaintApp
//
////////////////////////////////////////////////////////////////////////////////

#define NUM_BRUSH 8

class SimpleBrush;

class SimplePaintApp : public AppBase, public InputFocus {
  private:
    char*                  titleBuffer;
    InteractiveDisplay*    display;
    ImageBuffer*          canvas;
    uint8*                canvasMask;
    ImageBuffer*          palette;
    SimpleBrush*          brush;
    sint16                width;
    sint16                height;
    sint16                currBrush;
    bool                  paletteSelect;
    bool                  quit;

  private:
    void                  refreshTitle();

  protected:

    // AppBase
    sint32  initApplication();
    sint32  runApplication();

    void    paintBrush(sint16 x, sint16 y);

    void    writeShot(const char* baseName);

    // InputFocus
    void    keyPressPrintable(InputDispatcher* src, sint32 ch);
    void    keyPressNonPrintable(InputDispatcher* src, Key::CtrlKey code);
    void    mousePress(InputDispatcher* src, uint32 keys);
    void    mouseDrag(InputDispatcher* src, sint16 x, sint16 y, sint16 dx, sint16 dy, uint32 keys);

  public:
    SimplePaintApp();
    ~SimplePaintApp();
};

////////////////////////////////////////////////////////////////////////////////
//
//  SimpleBrush
//
//  Maintains a circular alpha gradient, zero at the outside edge to a maximum
//  at the centre. The size and gradient may be modified. This alpha data is
//  used to blend the brushes Colour with pixels in a 32-bit ARGB image buffer.
//
////////////////////////////////////////////////////////////////////////////////

#define MIN_BRUSHRADIUS  2
#define MAX_BRUSHRADIUS  32
#define MAX_DENSITY 8
#define MIN_DENSITY 0

class SimpleBrush {
  public:
    typedef enum {
      ALPHA        = 0,
      MULTIPLY,
      NEGATIVE
    } BlendMode;

  private:
    static uint16*  blendTab;    // contains the products n*m for n=0-255, m=0-255
    static uint8*    divTab;      // contains n/255 for n = 0-65535
    static sint32    count;
    Colour          colour;
    uint8*          data;
    float32          radius;
    float32          density;
    BlendMode        bMode;
    sint16          size;
    sint16          span;

    uint8    blendChannelAlpha(const uint32 s, const uint32 d, uint32 a) {
      a<<=8;
      return divTab[blendTab[a+s] + blendTab[65280-a+d]];
    }

    uint8    negateChannel(uint32 s, uint32 a) {
      return 255-s;
    }

    uint8    modulateChannel(const uint32 s, const uint32 d, uint32 a) {
      uint32 x = s<<8; a<<=8;
      x = divTab[blendTab[x+d]]; // x = s*d;
      return divTab[blendTab[a+x] + blendTab[65280-a+d]];
    }

    void    calculate();

  public:

    void          setBlend(BlendMode b) { bMode = b; }
    BlendMode      getBlend()            { return bMode; }
    const char*    getMode();
    sint16        getSize()              { return size; }
    float32        getRadius()            { return radius; }
    float32        getDensity()          { return density; }
    Colour        getColour()            { return colour; }

    void          setColour(Colour c)    { colour = c; }
    void          setRadius(float32 r)  {
      radius = Clamp::real(r, MIN_BRUSHRADIUS, MAX_BRUSHRADIUS);
      calculate();
    }

    void          setDensity(float32 d)  {
      density = Clamp::real(d, MIN_DENSITY, MAX_DENSITY);
      calculate();
    }

    void          setRadiusDensity(float32 r, float32 d) {
      radius = Clamp::real(r, MIN_BRUSHRADIUS, MAX_BRUSHRADIUS);
      density = Clamp::real(d, MIN_DENSITY, MAX_DENSITY);
      calculate();
    }

    void          set(float32 r, float32 d, Colour c) {
      radius = Clamp::real(r, MIN_BRUSHRADIUS, MAX_BRUSHRADIUS);
      density = Clamp::real(d, MIN_DENSITY, MAX_DENSITY);
      colour = c;
      calculate();
    }

    void          apply(ImageBuffer* img, uint8* mask, sint16 x, sint16 y);

    SimpleBrush(float32 r, float32 d, Colour c);
    ~SimpleBrush();
};

#endif