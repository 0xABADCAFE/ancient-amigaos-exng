//****************************************************************************//
//**                                                                        **//
//** File:         proj/ListDisplayModes/listmodes.cpp                      **//
//** Description:  Display Mode Query Demonstration                         **//
//** Comment(s):                                                            **//
//** Created:      2003-04-30                                               **//
//** Updated:      2004-02-12                                               **//
//** Author(s):    Karl Churchill                                           **//
//** Note(s):                                                               **//
//** Copyright:    (C)1996-2004, eXtropia Studios                           **//
//**               Serkan YAZICI, Karl Churchill                            **//
//**               All Rights Reserved.                                     **//
//**                                                                        **//
//****************************************************************************//

#include <xbase.hpp>
#include <gfxlib/gfx.hpp>

////////////////////////////////////////////////////////////////////////////////
//
//  ListmodesApp
//
//  Queries the Display class to obtain the DisplayProperties for each mode
//  provided by the host OS that EXNG may use.
//
//  This code makes use of gfxlib, which in turn requires initialisation before
//  use. As such, we  must call GfxLib::init() and GfxLib::done() in the main
//  AppBase::init() and AppBase::done() methods. This ensures that our test
//  application is only instansiated once the gfxlib has been successfully
//  initialised.
//
////////////////////////////////////////////////////////////////////////////////

class ListmodesApp : public AppBase {
  private:
    static char* pixelNames[];  // Meaningful names for Pixel format enumeration

  protected:
    sint32  runApplication();    // AppBase

  public:
    ListmodesApp() {}
    ~ListmodesApp() {}
};

////////////////////////////////////////////////////////////////////////////////

volatile char version[] = "$VER: listmodes 1.0 K. Churchill (26.1.2004)\n";

char* ListmodesApp::pixelNames[] = {
  "8-bit CLUT",
  "15-bit RGB 555 (big endian)",
  "15-bit BGR 555 (big endian)",
  "15-bit RGB 555 (little endian)",
  "15-bit BGR 555 (little endian)",
  "16-bit RGB 565 (big endian)",
  "16-bit BGR 565 (big endian)",
  "16-bit RGB 565 (little endian)",
  "16-bit BGR 565 (little endian)",
  "24-bit RGB 888",
  "24-bit BGR 888",
  "32-bit ARGB 8888 (big endian)",
  "32-bit ABGR 8888 (big endian)",
  "32-bit ARGB 8888 (little endian) [BGRA]",
  "32-bit ABGR 8888 (little endian) [RGBA]",
  "Unknown"
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
  return new ListmodesApp;
}

////////////////////////////////////////////////////////////////////////////////

void AppBase::destroyApplicationInstance(AppBase* app)
{
  delete app;
}

////////////////////////////////////////////////////////////////////////////////

sint32 ListmodesApp::runApplication()
{
  // Obtain the number of modes available and for each one, display the
  // basic properties defined in the corresponding DisplayProperties object.
  sint32 numModes = DisplayProperties::getNumModes();

  printf("EXNG DisplayProperties test\n");
  printf("Min Width:  %ld\n", DisplayProperties::getMinWidth());
  printf("Min Height: %ld\n", DisplayProperties::getMinHeight());
  printf("Max Width:  %ld\n", DisplayProperties::getMaxWidth());
  printf("Max Height: %ld\n", DisplayProperties::getMaxHeight());
  printf("Min Depth:  %ld\n", DisplayProperties::getMinDepth());
  printf("Max Depth:  %ld\n", DisplayProperties::getMaxDepth());

  printf("\nPreferred 8-bit: %s\n", pixelNames[Pixel::getPrefFormat(Pixel::BPP8)]);
  printf("Preferred 15-bit: %s\n", pixelNames[Pixel::getPrefFormat(Pixel::BPP15)]);
  printf("Preferred 16-bit: %s\n", pixelNames[Pixel::getPrefFormat(Pixel::BPP16)]);
  printf("Preferred 24-bit: %s\n", pixelNames[Pixel::getPrefFormat(Pixel::BPP24)]);
  printf("Preferred 32-bit: %s\n", pixelNames[Pixel::getPrefFormat(Pixel::BPP32)]);

  printf("\nNumber of available modes: %ld\n\n", numModes);

  for (sint32 i = 0; i < numModes; i++)
  {
    const DisplayProperties* p = DisplayProperties::getMode(i);
    printf("Mode %d/%d [%s]\n", i+1, numModes, p->getName());
    printf("Size   : %4d x %4d x %2d, aspect : %4.2f\n"
           "Format : %s\n"
           "Timing : %5.2f Hz, %5.2f kHz\n\n",
           p->getW(), p->getH(), p->getDepth(), p->getAspect(),
           pixelNames[p->getFormat()],
           p->getVertRefreshRateHz(), p->getHorizRefreshRatekHz());
  }
  return 0;
}

