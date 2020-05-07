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

#include "engine.hpp"
#include <systemlib/timer.hpp>

////////////////////////////////////////////////////////////////////////////////

sint32 AppBase::init()
{
  return GfxLib::init();
}

////////////////////////////////////////////////////////////////////////////////

void AppBase::done()
{
  GfxLib::done();
}

////////////////////////////////////////////////////////////////////////////////

AppBase* AppBase::createApplicationInstance()
{
  return new(nothrow) EngineApp;
}

////////////////////////////////////////////////////////////////////////////////

void AppBase::destroyApplicationInstance(AppBase* app)
{
  delete app;
}

////////////////////////////////////////////////////////////////////////////////

EngineApp::EngineApp() : InputFocus(IRESPONSE), display(0), gfx(0), view(0),
renderList(0), vertexBuff(0), yaw(0.0), pitch(90.0), quit(false)
{
  //puts("constructing application");
  dispW = getInteger("width", false);
  dispH = getInteger("height", false);

  dispW = dispW ? Clamp::integer(dispW, 320, 1024) : 640;
  dispH = dispH ? Clamp::integer(dispH, 240, 768) : 480;

  // Allocate stuff.
  if (!(display  = new(nothrow) InteractiveWindow(IRESPONSE)))
    return;
  if (!(renderList = (MapCellInstance**)Mem::alloc(maxVisibleCells*sizeof(MapCellInstance**), Mem::ALIGN_CACHE)))
    return;
  if (!(vertexBuff = (Vertex*)Mem::alloc(maxVertices*sizeof(Vertex), Mem::ALIGN_CACHE)))
    return;
}

////////////////////////////////////////////////////////////////////////////////

EngineApp::~EngineApp()
{
  //puts("destroying application");
  if (vertexBuff)
    Mem::free(vertexBuff);
  if (renderList)
    Mem::free(renderList);
  delete display;
}

////////////////////////////////////////////////////////////////////////////////

sint32 EngineApp::initApplication()
{
  printf("EngineApp::initApplication()\n");

  if (!display || !renderList || !vertexBuff) {
    printf("\tresource allocation failed\n");
    return ERR_RSC;
  }

  if (display->open(dispW, dispH, Pixel::BPP15, "Engine")!=OK) {
    printf("\tcouldn't open display\n");
    return ERR_RSC;
  }

  sint32 val = getInteger("dimw", false);
  sint16 dW = val ? Clamp::integer(val, WorldMap::minDim, WorldMap::maxDim) : 8;
  val = getInteger("dimh", false);
  sint16 dH = val ? Clamp::integer(val, WorldMap::minDim, WorldMap::maxDim) : 8;

  if (WorldMap::init(worldScale,  dW,  dH,  1)!=OK) {
    printf("\tfailed to initialise map\n");
    return ERR_RSC;
  }

  if (!(view = WorldMap::createView(dispW, dispH, 16*worldScale))) {
    printf("\tfailed to obtain view\n");
    return ERR_RSC;
  }

  view->setAngles(yaw, pitch);

  printf("Map size : %0.2f x %0.2f\n", WorldMap::getScaleWidth(), WorldMap::getScaleHeight());
  display->addFocus(this);
  return OK;
}

////////////////////////////////////////////////////////////////////////////////

void EngineApp::doneApplication()
{
  //puts("finishing application");
  delete view;
  WorldMap::done();
}

////////////////////////////////////////////////////////////////////////////////


sint32 EngineApp::runApplication()
{
  while(!quit) {
    display->waitEvent();
    while (display->handleEvent())
      ;

  }

  return OK;
}

////////////////////////////////////////////////////////////////////////////////

void EngineApp::keyPressPrintable(InputDispatcher* src, sint32 ch)
{

}

void EngineApp::keyPressNonPrintable(InputDispatcher* src, Key::CtrlKey code)
{
  bool changed=false;
  switch(code) {
    case Key::ESC:
      quit = true;
      break;

    case Key::RIGHT:
      yaw+=5.0;
      if (yaw>360.0) { yaw -= 360.0; }
      changed=true;
      break;

    case Key::LEFT:
      yaw-=5.0;
      if (yaw<0.0) { yaw = 360.0-yaw; }
      changed=true;
      break;

    case Key::UP:
      pitch = Clamp::real(pitch+5.0, 10.0, 90.0);
      changed=true;
      break;

    case Key::DOWN:
      pitch = Clamp::real(pitch-5.0, 10.0, 90.0);
      changed=true;
      break;

    case Key::F1: {
        sint32 n = view->getVisCellsSorted(renderList);
        MapCellInstance** cellPtr = renderList;
        while (n--) {
          printf("Cell ------------\n");
          (*cellPtr++)->origin.debugPrint();
          printf("-----------------\n");

        }
      }
      break;

    case Key::F9: {
        sint32 v = view->getVisCellsSorted(renderList);
        printf("There were %d visible cells\n", v);
      }
      break;

    case Key::F10:
      view->debugPrint();
      break;

    default:
      break;
  }
  if (changed) {
    view->setAngles(yaw, pitch);
    //view->debugPrint();
  }
}

void EngineApp::mousePress(InputDispatcher* src, uint32 keys)
{

}

void EngineApp::mouseDrag(InputDispatcher* src, sint16 x, sint16 y, sint16 dx, sint16 dy, uint32 keys)
{

}
