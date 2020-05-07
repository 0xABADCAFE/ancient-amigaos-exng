//****************************************************************************//
//**                                                                        **//
//** File:         include/gfxlib/draw.hpp                                  **//
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

#ifndef _EXTROPIA_GFXLIB_DRAW_HPP
#define _EXTROPIA_GFXLIB_DRAW_HPP

#include <gfxlib/gfx3d.hpp>

////////////////////////////////////////////////////////////////////////////////
//
//  Draw2D, simple high level 2D interface for primitives
//
////////////////////////////////////////////////////////////////////////////////


class Draw2D {
  public:
    virtual void begin()                            =  0;
    virtual void end()                              = 0;
    // lines
    virtual void line(S_2CRD)                        = 0;
    virtual void lineShd(S_2CRD, Colour* c)          = 0;

    // triangles
    virtual void tri(S_3CRD)                        = 0;
    virtual void triGrdHrz(S3_CRD, Colour* c)        = 0;
    virtual void triGrdVrt(S3_CRD, Colour* c)        = 0;
    virtual void triGrdCnr(S3_CRD, Colour* c)        = 0;

    // rectangles
    virtual void rect(S_2CRD)                        = 0;
    virtual void rectGrdHrz(S_2CRD, Colour* c)      = 0;
    virtual void rectGrdVrt(S_2CRD, Colour* c)      = 0;
    virtual void rectGrdCnr(S_2CRD, Colour* c)      = 0;

    virtual void circle(S_XY, sint16 r)             = 0;
    virtual void elipse(S_XY, sint16 rx, sint16 ry) = 0;
};

////////////////////////////////////////////////////////////////////////////////
//
//
//
////////////////////////////////////////////////////////////////////////////////

typedef void (*Handler)(REGP0 void* arg);

struct DrawCommand {
  union {
    opcode;
    Handler fn;
  };
  union {
    size_t        numVerts;
    uint32        colour;
    G3D::State    state;
    uint32        data;
    float32        depth;
    Texture*      texture;
    Surface*      surf;
    DrawVertex*    vertBase;
    void*          arg;
  };
};


class DrawBuffer {
  private:

    static void  _dummy(REGP(0) void* arg);
    static void  _skip(REGP(0) void* arg);
    static void  _clearRGB(REGP(0) void* arg);
    static void  _clearDepth(REGP(0) void* arg);
    static void  _drawPoints(REGP(0) void* arg);
    static void  _drawLines(REGP(0) void* arg);
    static void  _drawLineStrip(REGP(0) void* arg);
    static void  _drawTris(REGP(0) void* arg);
    static void  _drawTrifan(REGP(0) void* arg);
    static void  _drawTriStrip(REGP(0) void* arg);
    static void  _blitToBuffer(REGP(0) void* arg);
    static void  _blitFromBuffer(REGP(0) void* arg);
    static void  _setDrawArea(REGP(0) void* arg);
    static void  _setBlendMode(REGP(0) void* arg);
    static void  _setFogParms(REGP(0) void* arg);
    static void  _setColourMask(REGP(0) void* arg);
    static void  _setColour(REGP(0) void* arg);
    static void _setTexture(REGP(0) void* arg);
    static void  _setLogicOp(REGP(0) void* arg);
    static void  _setFogMode(REGP(0) void* arg);
    static void  _setZBuffTestMode(REGP(0) void* arg);
    static void  _setAlphaTestMode(REGP(0) void* arg);
    static void  _setLock(REGP(0) void* arg);
    static void  _enableState(REGP(0) void* arg);
    static void  _disableState(REGP(0) void* arg);
    static void  _pushDVS(REGP(0) void* arg);
    static void  _popDVS(REGP(0) void* arg);
    static void  _abort(REGP(0) void* arg);
    static void  _breakPoint(REGP(0) void* arg);

  public:

};



////////////////////////////////////////////////////////////////////////////////
//
//  Native classes
//
////////////////////////////////////////////////////////////////////////////////

#if defined(XP_AMIGAOS3_68K)
  #include "plat/amigaos3_68k/gfxlib/draw.hpp"
#elif defined(XP_AMIGAOS3_PPC)
  #include "plat/amigaos3_wos/gfxlib/draw.hpp"
#elif defined(XP_AMIGAOS4)
  #include "plat/amigaos4/gfxlib/draw.hpp"
#elif defined(XP_AROS_BE)
  #include "plat/aros_be/gfxlib/draw.hpp"
#elif defined(XP_AROS_LE)
  #include "plat/aros_le/gfxlib/draw.hpp"
#elif defined(XP_MORPHOS)
  #include "plat/morphos/gfxlib/draw.hpp"
#elif defined(XP_LINUX_PPC)
  #include "plat/linux_ppc/gfxlib/draw.hpp"
#elif defined(XP_LINUX_X86)
  #include "plat/linux_x86/gfxlib/draw.hpp"
#elif defined(XP_WIN9X)
  #include "plat/win9x/gfxlib/draw.hpp"
#elif defined(XP_WIN2K)
  #include "plat/win2k/gfxlib/draw.hpp"
#elif defined(XP_MACOSX)
  #include "plat/macosx/gfxlib/draw.hpp"
#else
  #error "Platform implementation not defined"
#endif



#endif