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

class SimpleViewApp : public AppBase, public InputFocus {
  private:
    const char*            fileName;
    InteractiveDisplay*    display;
    ImageBuffer*          image;
    bool                  quit;

  protected:
    // AppBase
    sint32  initApplication();
    sint32  runApplication();

    // InputFocus
    void    keyPressNonPrintable(I_SRC, Key::CtrlKey code);

  public:
    SimpleViewApp();
    ~SimpleViewApp();
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
  return new SimpleViewApp;
}

////////////////////////////////////////////////////////////////////////////////

void AppBase::destroyApplicationInstance(AppBase* app)
{
  delete app;
}

////////////////////////////////////////////////////////////////////////////////

SimpleViewApp::SimpleViewApp() :
InputFocus(IFilter::IKEYPRESS), fileName(0), display(0), image(0), quit(false)
{

}

////////////////////////////////////////////////////////////////////////////////

SimpleViewApp::~SimpleViewApp()
{
  delete image;
  delete display;
}

////////////////////////////////////////////////////////////////////////////////

sint32 SimpleViewApp::initApplication()
{
  // Ensure the user passed a filename.
  // If so, attempt to create a new ImageBuffer from it.

  if (numArgs()<2 || !(fileName = getArg(1)))  {
    puts("Usage : simpleview <filename>");
    return -1;
  }
  else if (!(image = ImageLoader::loadImage(fileName)))  {
    printf("Couldn't open '%s'\n", fileName);
    return -1;
  }

  if(!(display = new InteractiveWindow(IFilter::IKEYPRESS))) {
    puts("Couldn't create display");
    return -1;
  }
  else {
    // Base the window size on the image, but clamp to
    // a sensible degree
    sint16 w = Clamp::integer(image->getW(), 128, DisplayProperties::getMaxWidth());
    sint16 h = Clamp::integer(image->getH(), 128, DisplayProperties::getMaxHeight());
    if (display->open(w, h, Pixel::BPP15, "SimpleView")!=OK) {
      puts("Couldn't open display");
      return -1;
    }


    // Add the application to the displays' InputFocus list.
    // We need to do this to ensure we receive input events.

    display->addFocus(this);

    // Render the image, as close to the centre of the window
    // as possible (if the image size is less than the window).

    sint16 x = 0;
    sint16 y = 0;
    if (w>image->getW()) {
      x = (w-image->getW())/2;
      w = image->getW();
    }
    if (h>image->getH()) {
      y = (h-image->getH())/2;
      h = image->getH();
    }

    // If the image is smaller than the minimum window size,
    // clear the draw surface before use to stop garbage
    // cluttering the display
    if (x>0 || y>0) {
      Colour back(0xFF000000);
      display->getDrawSurface()->clear(back);
    }

    // Draw the ImageBuffer onto the display's draw surface.
    // We use Surface::putImageBuffer() to do this.
    display->getDrawSurface()->putImageBuffer(image, x, y, 0, 0, w, h);
    display->refresh();
  }
  return OK;
}

////////////////////////////////////////////////////////////////////////////////

sint32 SimpleViewApp::runApplication()
{
  // Wait for the quit flag to be set
  while (!quit) {
    display->waitEvent();
    while(display->handleEvent())
      ;
  }
  return 0;
}

////////////////////////////////////////////////////////////////////////////////

void SimpleViewApp::keyPressNonPrintable(I_SRC, Key::CtrlKey code)
{
  // From InputFocus
  switch (code) {
    case Key::ESC:
      quit = true;
      break;

    default:
      break;
  }
}
