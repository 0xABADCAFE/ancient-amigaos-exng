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

#include <xbase.hpp>
#include <gfxlib/gfxapp.hpp>
#include <gfxlib/gfx3d.hpp>
#include <new.h>

namespace X_SYSNAME {
  extern "C" {
    #include <p2hack.h>
  }
}

using namespace X_SYSNAME;

////////////////////////////////////////////////////////////////////////////////
//
//  P2 Hack
//
////////////////////////////////////////////////////////////////////////////////

// Input filters
#define IRESPONSE (IFilter::IKEYNONPRINTPRESS/*|IFilter::IMOUSEPRESS|IFilter::IMOUSEDRAG*/)

class P2HackApp : public AppBase, public InputFocus, private RasterizerUser {
  private:

    InteractiveDisplay*    display;        // Display with InputDispatcher
    const char*            imageFileName;
    Rasterizer*            gfx;
    sint16                width;
    sint16                height;
    bool                  quit;

    //char                  strBuf[512];

  protected:
    // AppBase
    sint32  initApplication();
    sint32  runApplication();

    // InputFocus
    void    keyPressNonPrintable(InputDispatcher* src, Key::CtrlKey code);
    //void    mousePress(InputDispatcher* src, uint32 keys);
    //void    mouseDrag(InputDispatcher* src, sint16 x, sint16 y, sint16 dx, sint16 dy, uint32 keys);

    void clear();
    void trianglePIO();

  public:
    P2HackApp();
    ~P2HackApp();
};

////////////////////////////////////////////////////////////////////////////////

char version[] = "$VER: P2Hack 0.1 K. Churchill (07.11.2004)\n";

////////////////////////////////////////////////////////////////////////////////

sint32 AppBase::init()
{
  // Do any library initialisation prior to application creation
  return GfxLib::init();
}

////////////////////////////////////////////////////////////////////////////////

void AppBase::done()
{
  // Do any library cleanup after application exit
  GfxLib::done();
}

////////////////////////////////////////////////////////////////////////////////

AppBase* AppBase::createApplicationInstance()
{
  // Create our application object
  return new(nothrow) P2HackApp;
}

////////////////////////////////////////////////////////////////////////////////

void AppBase::destroyApplicationInstance(AppBase* app)
{
  // Destroy our application object
  delete app;
}

////////////////////////////////////////////////////////////////////////////////

P2HackApp::P2HackApp() : InputFocus(IRESPONSE), display(0), gfx(0), quit(false)
{
  // Construct our application
  sint16 w    = getInteger("width", false);
  sint16 h    = getInteger("height", false);
  width        = w ? w : 640;
  height      = h ? h : 480;
  display      = new(nothrow) InteractiveWindow(IRESPONSE);
}

////////////////////////////////////////////////////////////////////////////////

P2HackApp::~P2HackApp()
{
  // Cleanup and close
  delete    gfx;
  delete    display;
}

////////////////////////////////////////////////////////////////////////////////

void P2HackApp::keyPressNonPrintable(InputDispatcher* src, Key::CtrlKey code)
{
  switch (code)
  {
    case Key::ESC:
      quit = true;
      break;
    default:
      break;
  }
}

////////////////////////////////////////////////////////////////////////////////

sint32 P2HackApp::initApplication()
{
  // This method performs any post construction initialisation
  // This method overidden from AppBase
  if (!display)
  {
    SystemLib::dialogueBox("Error", "Exit", "Failed to create application window");
    return ERR_RSC_UNAVAILABLE;
  }

/*
  if (!eventRec || eventRec->open("ram:events.txt")!=OK)
  {
    SystemLib::dialogueBox("Error", "Exit", "Failed to create event log");
    return ERR_RSC_UNAVAILABLE;
  }
*/

  if (display->open(width, height, Pixel::BPP15, "P2Hack")!=OK)
  {
    SystemLib::dialogueBox("Error", "Exit", "Failed to open application window");
    return ERR_RSC_UNAVAILABLE;
  }

  gfx = G3D::getRasterizer(display->getDrawSurface());
  if (!gfx)
  {
    SystemLib::dialogueBox("Error", "Exit", "Failed to obtain Rasterizer");
    return ERR_RSC_UNAVAILABLE;
  }



  gfx->disable(G3D::CULLING);
  gfx->disable(G3D::GOURAUD);
  gfx->disable(G3D::TEXTURE);
  gfx->enable(G3D::DITHERING);
  gfx->setFlatColour(0xFFA0A0A0);

  // To get input, we need to register the InputFocus (the application)
  // with the InputDispatcher (our display)
  display->addFocus(this);
  //display->addFocus(eventRec); // our event recorder

  clear();
  return OK;
}

////////////////////////////////////////////////////////////////////////////////


void P2HackApp::clear()
{
  // This method draws the mesh using the Rasterizer class drawTriMesh2()
  if (gfx->lock())
  {
    gfx->clearDrawArea(0x00000000);
    gfx->flush();
    gfx->unlock();
    display->refresh();
  }
}

////////////////////////////////////////////////////////////////////////////////

void P2HackApp::trianglePIO()
{
  // This method draws the mesh using the Rasterizer class drawTriMesh2()
  if (gfx->lock())
  {
    setP2_RegisterF(getRasterizerContext(gfx),
                    P2_V0_X, 8.0);

    setP2_RegisterF(getRasterizerContext(gfx),
                    P2_V0_Y, (float32)(height-8));

    setP2_RegisterU(getRasterizerContext(gfx),
                    P2_V0_ABGR, 0xFF0000FF);

    setP2_RegisterF(getRasterizerContext(gfx),
                    P2_V1_X, (float32)(width>>1));

    setP2_RegisterF(getRasterizerContext(gfx),
                    P2_V1_Y, 8.0);

    setP2_RegisterU(getRasterizerContext(gfx),
                    P2_V1_ABGR, 0xFF00FF00);

    setP2_RegisterF(getRasterizerContext(gfx),
                    P2_V2_X, (float32)(width-8));

    setP2_RegisterF(getRasterizerContext(gfx),
                    P2_V2_Y, (float32)(height-8));

    setP2_RegisterU(getRasterizerContext(gfx),
                    P2_V2_ABGR, 0xFFFF0000);

    setP2_RegisterU(getRasterizerContext(gfx),
                    P2_REG_DRAWTRIANGLE,  P2_CMD_SPC|P2_CMD_P_TRIANGLE);

    gfx->flush();
    gfx->unlock();
    display->refresh();
  }
}

////////////////////////////////////////////////////////////////////////////////

sint32 P2HackApp::runApplication()
{
  // The main event loop here.
  // This method overriden from AppBase

  trianglePIO();

  while (!quit)
  {
    while (display->handleEvent())
      ;
    display->waitEvent();
  }

  return 0;
}