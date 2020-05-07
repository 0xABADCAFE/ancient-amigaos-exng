//****************************************************************************//
//**                                                                        **//
//** File:         proj/SimpleView/simpleview.cpp                           **//
//** Description:  Simple image viewer                                      **//
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
#include <systemlib/thread.hpp>
#include <gfxlib/gfx.hpp>
#include <gfxlib/gfxapp.hpp>
#include <gfxlib/gfxutil.hpp>

////////////////////////////////////////////////////////////////////////////////
//
//  SimpleViewApp
//
//  Very simple windowed picture viewer. Renders an ImageBuffer directly onto
//  the windows draw surface.
//
//  ImageBuffer loading is provided with ImageLoader. Under AmigaOS this uses
//  datatypes. Other systems will rely on their implementations to provide
//  some level of image decoding support.
//
//  Notes
//
//  Decoding to an image buffer and then copying to the surface is not the
//  most optimal arrangement possible for this task, but the purpose of the
//  excersise is to show some of the ease of use of the system. Direct to
//  surface image loading will soon be added, making this kind of application
//  even simpler to write and faster to execute.
//
////////////////////////////////////////////////////////////////////////////////

class TestDisplayApp : public AppBase, public InputFocus {
  private:
    const char*            fileName;
    InteractiveDisplay*    display;
    bool                  quit;

  protected:
    // AppBase
    sint32  initApplication();
    sint32  runApplication();

    // InputFocus
    void    keyPressNonPrintable(I_SRC, Key::CtrlKey code);

  public:
    TestDisplayApp();
    ~TestDisplayApp();
};

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
  return new TestDisplayApp;
}

////////////////////////////////////////////////////////////////////////////////

void AppBase::destroyApplicationInstance(AppBase* app)
{
  delete app;
}

////////////////////////////////////////////////////////////////////////////////

TestDisplayApp::TestDisplayApp() :
InputFocus(IFilter::IKEYPRESS), fileName(0), display(0), quit(false)
{
  int type = getInteger("mode", false);
  switch (type) {
    case 1:
      display = new InteractiveScreen();
      break;
    case 2:
      display = new InteractiveScreenBuffered();
      break;

    default:
      display = new InteractiveWindow();
      break;
  }
}

////////////////////////////////////////////////////////////////////////////////

TestDisplayApp::~TestDisplayApp()
{
  delete display;
}

////////////////////////////////////////////////////////////////////////////////

sint32 TestDisplayApp::initApplication()
{
  if (!display)
  {
    puts("Couldn't create display");
    return -1;
  }

  int type = getInteger("mode", false);

  if (type==2)
    ((InteractiveScreenBuffered*)display)->setNumBuffers(3);

  if (display->open(640, 480, Pixel::BPP15, "DisplayTest")!=OK)
  {
    puts("Couldn't open display");
    return -1;
  }


  // Add the application to the displays' InputFocus list.
  // We need to do this to ensure we receive input events.
  display->addFocus(this);
  //display->refresh();

  if(type==2) {
    display->getDrawSurface()->clear(0x007F0000);
    display->refresh();
    display->getDrawSurface()->clear(0x00007F00);
    display->refresh();
    display->getDrawSurface()->clear(0x0000007F);
    display->refresh();
  }


  Surface* s = display->getDrawSurface();

  if (!s) {
    puts("FFS!");
  }

  printf("got drawSurface at 0x%08X\n", (unsigned)(display->getDrawSurface()));

  return OK;
}

////////////////////////////////////////////////////////////////////////////////

sint32 TestDisplayApp::runApplication()
{
  puts("runApplication()");
  // Wait for the quit flag to be set
  while (!quit)
  {
    display->waitEvent();
    while(display->handleEvent())
      ;
    display->refresh();
  }
  Thread::sleep(500);
  return 0;
}

////////////////////////////////////////////////////////////////////////////////

void TestDisplayApp::keyPressNonPrintable(I_SRC, Key::CtrlKey code)
{
  // From InputFocus
  switch (code)
  {
    case Key::ESC:
      quit = true;
      break;

    default:
      break;
  }
}
