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

#ifndef _APP_HPP
#define _APP_HPP

#include <xbase.hpp>
#include <gfxlib/gfx.hpp>
#include <gfxlib/gfxapp.hpp>
#include <gfxlib/gfxutil.hpp>
#include "fractal.hpp"

////////////////////////////////////////////////////////////////////////////////
//
//
//
////////////////////////////////////////////////////////////////////////////////

#define MAX_RANGES 1024

typedef struct {
  int min : 16;
  int max : 16;
} Range;

class App : public AppBase, public InputFocus {
  private:
    InteractiveDisplay*  display;
    FractalMap*          frac;
    const char*          palName;
    ImageBuffer*        srcImage;
    ImageBuffer*        test;
    ImageBuffer*        normalMap;
    Range*  yRanges;
    Range*  xRanges;

    sint16  width;
    sint16  height;
    sint16  minA;
    sint16  maxA;
    char    titleBuffer[256];

    struct {
      bool  quit        : 1;
      bool  refresh      : 1;
      bool  fullScreen  : 1;
      bool  method      : 1;
      bool  showNormals  : 1;
    } flags;

  private:
    void  getSlice();
    int    tprint(const char* fmt,...);
    void  showIB(ImageBuffer* i, uint32 bg);

  protected:
    // AppBase
    sint32  initApplication();
    sint32  runApplication();

    // InputFocus
    void keyPressNonPrintable(I_SRC, Key::CtrlKey code);
    void keyPressPrintable(I_SRC, sint32 ch);
    void mousePress(I_SRC, uint32 code);
    void mouseRelease(I_SRC, uint32 code);
    void mouseMove(I_SRC, sint16 x, sint16 y, sint16 dx, sint16 dy);
    void mouseDrag(I_SRC, sint16 x, sint16 y, sint16 dx, sint16 dy, uint32 s);
  public:
    App();
    ~App();
};

#endif