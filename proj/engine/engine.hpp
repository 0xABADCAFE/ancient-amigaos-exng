//****************************************************************************//
//**                                                                        **//
//** File:         prj/gfxTest/drawtest.cpp                                 **//
//** Description:  Rasterizer test application                              **//
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

#ifndef _ENGINE_HPP_
#define _ENGINE_HPP_

#include <xbase.hpp>
#include <gfxlib/gfxapp.hpp>
#include <gfxlib/gfx3d.hpp>

#include <new.h>
#include "3d.hpp"
#include "world.hpp"

////////////////////////////////////////////////////////////////////////////////
//
//
////////////////////////////////////////////////////////////////////////////////

// Input filters
#define IRESPONSE (IFilter::IKEYPRESS|IFilter::IMOUSEPRESS|IFilter::IMOUSEDRAG)

class EngineApp : public AppBase, public InputFocus {
  private:
    InteractiveDisplay*  display;
    Rasterizer*          gfx;
    WorldView*          view;
    MapCellInstance**    renderList;
    Vertex*              vertexBuff;
    float32              yaw;
    float32              pitch;
    sint16              dispW;
    sint16              dispH;

    bool                quit;

    static const size_t    maxVisibleCells  = 4096;
    static const size_t    maxVertices      = 32768;
    static const float32  worldScale      = 4.0;  // each mapcell is 4x4x4

  protected:
    // AppBase
    sint32  initApplication();
    sint32  runApplication();
    void    doneApplication();

    // InputFocus
    void    keyPressPrintable(InputDispatcher* src, sint32 ch);
    void    keyPressNonPrintable(InputDispatcher* src, Key::CtrlKey code);
    void    mousePress(InputDispatcher* src, uint32 keys);
    void    mouseDrag(InputDispatcher* src, sint16 x, sint16 y, sint16 dx, sint16 dy, uint32 keys);


  public:
    EngineApp();
    ~EngineApp();
};

#endif