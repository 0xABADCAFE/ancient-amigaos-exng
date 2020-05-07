//****************************************************************************//
//**                                                                        **//
//** File:         proj/Landscape/app.cpp                                   **//
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

#include "slicer.hpp"
#include <iolib/fileio.hpp>

////////////////////////////////////////////////////////////////////////////////
//
//  AppBase
//
////////////////////////////////////////////////////////////////////////////////

sint32 AppBase::init()
{
  return GfxLib::init();
}

void AppBase::done()
{
  GfxLib::done();
}

AppBase* AppBase::createApplicationInstance()
{
  return new App;
}

void AppBase::destroyApplicationInstance(AppBase* app)
{
  delete app;
}

////////////////////////////////////////////////////////////////////////////////
//
//  App / AppBase
//
////////////////////////////////////////////////////////////////////////////////

App::App() : InputFocus(IFilter::IDEFAULT), width(320), height(320)
{
/*
  if (getSwitch("fullscreen", false))
    display = new InteractiveScreenBuffered(IFilter::IDEFAULT);
  else
*/

  // fractal properties
  sint32   dim    = getInteger("dim", false);
  sint32   seed  = getInteger("seed", false);
  float32  rough  = getFloat("rough", false);
  float32 decay  = getFloat("decay", false);

  xRanges = new Range[MAX_RANGES];
  yRanges = new Range[MAX_RANGES];

  dim      = (dim > 0 )    ? Clamp::integer(dim, 4, 9) : 9;
  rough    = (rough > 0.0)  ? Clamp::real(rough, 0.1, 1.0) : 0.75;
  decay    = (decay > 0.0)  ? Clamp::real(decay, 0.01, 1.5) : 0.75;
  frac    = new FractalMap(seed, dim, rough, decay);

  palName = getString("pal", false);
  if (!palName)
    palName = "data/rgb/default.iff";

  // display
  display = new InteractiveWindow(IFilter::IDEFAULT);
  width = height = 1<<dim;
  minA = 0;
  maxA = 32;

  flags.showNormals = false;
  flags.method    = getSwitch("ds", false);
  flags.quit      = false;
}

App::~App()
{
  delete xRanges;
  delete yRanges;
  delete normalMap;
  delete test;
  delete srcImage;
  delete display;
  delete frac;
}

sint32 App::initApplication()
{
  if (!frac || !frac->isValid()) {
    SystemLib::dialogueBox("Error", "Exit", "Failed to allocate map data");
    return ERR_RSC_UNAVAILABLE;
  }
  if (!display || display->open(width, height, Pixel::BPP15, "TGIS - configuring")!=OK) {
    SystemLib::dialogueBox("Error", "Exit", "Failed to create Display");
    return ERR_RSC_UNAVAILABLE;
  }

  printf("Calculating fractal...");
  fflush(stdout);
  if (flags.method)
    frac->calculate1();
  else
    frac->calculate2();
  printf("done.\nExporting RGB map...");
  fflush(stdout);
  srcImage    = frac->exportRGB(palName);
  printf("done.\nExporting Normal map...");
  fflush(stdout);
  normalMap    = frac->exportNormalMap(16.0);
  printf("done.\n");

  if (test = new ImageBuffer()) {
    if (test->create(srcImage->getW(), srcImage->getH(), srcImage->getFormat())!=OK)
      return ERR_NO_FREE_STORE;
  }
  else {
    return ERR_NO_FREE_STORE;
  }

  getSlice();
  showIB(srcImage, 0);
  tprint("[%d x %d] [b %d] [r %d]",
    srcImage->getW(), srcImage->getH(), minA, maxA
  );
  display->addFocus(this);
  display->refresh();
  return OK;
}

sint32 App::runApplication()
{
  // Wait for the quit flag to be set
  while (!flags.quit)  {
    display->waitEvent();
    flags.refresh = false;
    while(display->handleEvent())
      ;
    if (flags.refresh)
      display->refresh();
  }
  return 0;
}

////////////////////////////////////////////////////////////////////////////////
//
//  App
//
////////////////////////////////////////////////////////////////////////////////

int App::tprint(const char* fmt,...)
{
  int res = 0;
  va_list args;
  va_start(args, fmt);
  res = vsprintf(titleBuffer, fmt, args);
  va_end(args);
  display->setTitle(titleBuffer);
  return res;
}

void  App::showIB(ImageBuffer* i, uint32 bg)
{
  sint16 x = 0;
  sint16 y = 0;

  if (width>i->getW())
  {
    x = (width-i->getW())/2;
  }
  if (height>i->getH())
  {
    y = (height-i->getH())/2;
  }
  if (x>0 || y>0)
    display->getDrawSurface()->clear(bg);
  display->getDrawSurface()->putImageBuffer(i, x, y, 0, 0, i->getW(), i->getH());
}

void App::getSlice()
{
  uint32 *src = (uint32*)srcImage->getData();
  uint32 *dst = (uint32*)test->getData();
  if (!(src && dst))
    return;
  sint16 h = srcImage->getH();
  while (h--) {
    sint16 w = srcImage->getW();
    while (w--) {
      uint8 val = *((uint8*)src); // warning - assumes big endian
      if (val<minA) {
        *dst++ = 0xFF00007F;
      }
      else if (val < (minA+maxA)) {
        *dst++ = 0xFFFFFFFF;
      }
      else {
        *dst++ = 0xFF7F0000;
      }
      src++;
    }
  }
}

////////////////////////////////////////////////////////////////////////////////
//
//  InputFocus
//
////////////////////////////////////////////////////////////////////////////////

void App::keyPressNonPrintable(I_SRC, Key::CtrlKey code)
{
  switch (code)
  {
    case Key::ESC:
      flags.quit = true;
      break;

    case Key::F1:
      showIB(srcImage, 0);
      flags.refresh = true;
      flags.showNormals = false;
      break;

    case Key::F2:
      getSlice();
      showIB(test, 0xFF00007F);
      flags.refresh = true;
      flags.showNormals = false;
      break;

    case Key::F3:
      minA = Clamp::integer(minA-maxA, 0, 256-maxA);
      break;

    case Key::F4:
      minA = Clamp::integer(minA+maxA, 0, 256-maxA);
      break;

    case Key::F5:
      maxA = Clamp::integer(maxA-1, 1, 256-minA);
      break;

    case Key::F6:
      maxA = Clamp::integer(maxA+1, 1, 256-minA);
      break;

    case Key::F10:
      showIB(normalMap, 0xFF00007F);
      flags.refresh = true;
      flags.showNormals = true;
      break;
    default:
      break;
  }

  tprint("[%d x %d] [b %d] [r %d]",
    srcImage->getW(), srcImage->getH(), minA, maxA
  );
}

void App::keyPressPrintable(I_SRC, sint32 ch)
{
}

void App::mousePress(I_SRC, uint32 code)
{
}

void App::mouseRelease(I_SRC, uint32 code)
{
}

void App::mouseMove(I_SRC, sint16 x, sint16 y, sint16 dx, sint16 dy)
{
}

void App::mouseDrag(I_SRC, sint16 x, sint16 y, sint16 dx, sint16 dy, uint32 s)
{
  if (flags.showNormals) {
    sint8* p = (sint8*)normalMap->getData();
    if (p) {
      float32 scale = 1.0/128.0;
      sint32 i = ((y*normalMap->getW())+x)*4;
      printf("Normal at %hd, %hd = [%4.2f %4.2f %4.2f]\n", x, y,
        (scale * p[i+1]),
        (scale * p[i+2]),
        (scale * p[i+3])
      );
    }
  }
}

