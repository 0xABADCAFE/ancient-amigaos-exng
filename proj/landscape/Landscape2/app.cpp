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

#include "app.hpp"
#include <iolib/fileio.hpp>

#include <math.h>

////////////////////////////////////////////////////////////////////////////////
//
//  AppBase
//
////////////////////////////////////////////////////////////////////////////////

bool App::verbose = false;

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

App::App() : InputFocus(IFilter::IDEFAULT), display(0), gfx(0), width(320), height(240)
{
  if (!(mapRGB = getString("rgb", false))) {
    mapRGB = "data/mapimg/default_rgb.png";
  }
  if (!(mapHeight = getString("hgt", false))) {
    mapHeight = "data/mapimg/default_hgt.png";
  }

  // display
  if (getSwitch("window", false))
    display = new InteractiveWindow(IFilter::IDEFAULT);
  else
    display = new InteractiveScreenBuffered(IFilter::IDEFAULT, 3);

  sint32 d = getInteger("width", false);
  if (d) {
    width = Clamp::integer(d, 320, 800);
  }
  d  = getInteger("height", false);
  if (d) {
    height = Clamp::integer(d, 240, 600);
  }
  first = 64;
  step  = 16;

  ImageBuffer *rgb = ImageLoader::loadImage(mapRGB);
  ImageBuffer *hgt = ImageLoader::loadImage(mapHeight);
  if (!rgb) {
    printf("Couldn't load %s\n", mapRGB);
    delete rgb;
    delete hgt;
  }
  else if (!hgt) {
    printf("Couldn't load %s\n", mapHeight);
    delete rgb;
    delete hgt;
  }
  else if (rgb->getW()!= hgt->getW()) {
    printf("Bad dimensions %ld x %ld, %ld x %ld\n", rgb->getW(), rgb->getH(), hgt->getW(), hgt->getH());
    delete rgb;
    delete hgt;
  }
  else if (rgb->getH() != hgt->getH()) {
    printf("Bad dimensions %ld x %ld, %ld x %ld\n", rgb->getW(), rgb->getH(), hgt->getW(), hgt->getH());
    delete rgb;
    delete hgt;
  }
  else {
    uint8* p1 = (uint8*)rgb->getData();
    uint8* p2 = (uint8*)hgt->getData();
    size_t n = rgb->getW() * rgb->getH();
    while (n--) {
      *p1 = *p2++;
      p1 += 4;
    }
    delete hgt;
    texture    = Texture::convertImageBuffer(rgb, Texture::CONV_IB_DEL_ALWAYS);

    // vertex buffer
    // 0,0
    vertBuffer[0].z = 0;
    vertBuffer[0].u = 0;
    vertBuffer[0].v = 0;
    vertBuffer[0].colour = 0xFF0000FF;

    // 0,h
    vertBuffer[1].z = 0;
    vertBuffer[1].u = 0;
    vertBuffer[1].v = texture->getH();
    vertBuffer[1].colour = 0xFF00FF00;

    // w,0
    vertBuffer[2].z = 0;
    vertBuffer[2].u = texture->getW();
    vertBuffer[2].v = 0;
    vertBuffer[2].colour = 0xFFFF0000;

    // w,h
    vertBuffer[3].z = 0;
    vertBuffer[3].u = texture->getW();
    vertBuffer[3].v = texture->getH();
    vertBuffer[3].colour = 0xFFFFFFFF;
  }

  flags.method    = getSwitch("ds", false);
  flags.baseOnly  = false;
  flags.gouraud    = false;
  flags.dithering  = true;
  flags.filtering  = true;
  flags.quit      = false;
  verbose          = getSwitch("verbose", false);
  dprint("Application instance created\n");
}

App::~App()
{
  delete texture;
  delete gfx;
  delete display;
  dprint("Application instance destroyed\n");
}

sint32 App::initApplication()
{
  if (!display || display->open(width, height, Pixel::BPP16, "TGIS - configuring")!=OK) {
    SystemLib::dialogueBox("Error", "Exit", "Failed to create Display");
    return ERR_RSC_UNAVAILABLE;
  }
  if (!(gfx = G3D::getRasterizer(display->getDrawSurface()))) {
    SystemLib::dialogueBox("Error", "Exit", "Failed to obtain Rasterizer");
    return ERR_RSC_UNAVAILABLE;
  }
  if (gfx->setVertices(vertBuffer)!=true) {
    SystemLib::dialogueBox("Error", "Exit", "Failed to set Vertex Buffer");
    return ERR_RSC_UNAVAILABLE;
  }

  if (!texture || texture->associate(gfx)!=OK) {
    SystemLib::dialogueBox("Error", "Exit", "Failed to setup texture data");
    return ERR_RSC_UNAVAILABLE;
  }

/*
  for (int i=0; i<3; i++) {
    display->getDrawSurface()->clear(0);
    display->refresh();
  }
*/

  texture->setFilter(G3D::LINEAR);
  texture->setEnvironment(G3D::REPLACE);
  texture->setWrapMode(G3D::REPEAT, G3D::REPEAT, 0);
  gfx->setTexture(texture);
  gfx->disable(G3D::CULLING);
  gfx->disable(G3D::GOURAUD);
  gfx->disable(G3D::BLENDING);
  gfx->enable(G3D::TEXTURE);
  gfx->enable(G3D::DITHERING);
  gfx->setFlatColour(0xFFFFFFFF);
  display->addFocus(this);
  tprint("TGIS [map %d x %d] [base %d] [step %d] [filter %s] [dither %s]",
    texture->getW(), texture->getH(), first, step,
    flags.filtering ? "on" : "off",
    flags.dithering ? "on" : "off"
  );
  return OK;
}

sint32 App::runApplication()
{
  float32 theta=0.0;
  float32 step=0.5;

  sint32 i=0;
  sint32 j=texture->getW();

  // Wait for the quit flag to be set
  while (!flags.quit)  {
    while(display->handleEvent())
      ;
/*
    rotate(theta);
    theta += step;
    if (theta>=512.0)
      theta=0.0;
    render();
*/
    display->refresh();
    gfx->setDrawSurface(display->getDrawSurface());
    display->waitSync();
/*
    // vertex buffer
    vertBuffer[0].u += 1.0;
    vertBuffer[0].v += 1.0;
    vertBuffer[1].u += 1.0;
    vertBuffer[1].v += 1.0;
    vertBuffer[2].u += 1.0;
    vertBuffer[2].v += 1.0;
    vertBuffer[3].u += 1.0;
    vertBuffer[3].v += 1.0;

    if (++i == j) {
      i = 0;
      vertBuffer[0].u -= j;
      vertBuffer[0].v -= j;
      vertBuffer[1].u -= j;
      vertBuffer[1].v -= j;
      vertBuffer[2].u -= j;
      vertBuffer[2].v -= j;
      vertBuffer[3].u -= j;
      vertBuffer[3].v -= j;
    }
*/
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

int App::dprint(const char* fmt,...)
{
  int res = 0;
  if (verbose) {
    va_list args;
    va_start(args, fmt);
    res = vprintf(fmt, args);
    va_end(args);
  }
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

void App::rotate(float32 ang)
{
  float32 s = sin((PI/256)*ang);
  float32 c = cos((PI/256)*ang);

  rfloat32 cx = width/2;
  rfloat32 cy = height/2;

  rfloat32 tx;
  rfloat32 ty;

  // 0,0
  tx = 0-cx; ty = 0-cx;
  vertBuffer[0].x = cx + 0.7*(c*tx + s*ty);
  vertBuffer[0].y = cy + 0.35*(-s*tx + c*ty);

  // 0,h
  tx = 0-cx; ty = width-cx;
  vertBuffer[1].x = cx + 0.7*(c*tx + s*ty);
  vertBuffer[1].y = cy + 0.35*(-s*tx + c*ty);

  // w,0
  tx = width-cx; ty = 0-cx;
  vertBuffer[2].x = cx + 0.7*(c*tx + s*ty);
  vertBuffer[2].y = cy + 0.35*(-s*tx + c*ty);

  // w,h
  tx = width-cx; ty=width-cx;
  vertBuffer[3].x = cx + 0.7*(c*tx + s*ty);
  vertBuffer[3].y = cy + 0.35*(-s*tx + c*ty);
}

void App::render()
{
  gfx->disable(G3D::BLENDING);
  gfx->enable(G3D::ALPHATEST);
  float32 fac = 1.0/256.0;
  if (gfx->lock()) {
    //gfx->clearDrawArea(0x00000000);
    gfx->setAlphaTest(G3D::TEST_LTEQ, fac*(first));
    gfx->drawTriStrip(0, 4);
    if (!flags.baseOnly) {
      for (int i=first; i<256; i+=step) {
        gfx->setAlphaTest(G3D::TEST_GT, fac*i);
        gfx->drawTriStrip(0, 4);
        vertBuffer[0].y-=1;
        vertBuffer[1].y-=1;
        vertBuffer[2].y-=1;
        vertBuffer[3].y-=1;
      }
    }
    gfx->flush();
    gfx->unlock();
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
      flags.filtering = !flags.filtering;
      if (flags.filtering)
        texture->setFilter(G3D::LINEAR);
      else
        texture->setFilter(G3D::NEAREST);
      break;

    case Key::F2:
      flags.dithering = !flags.dithering;
      if (flags.dithering)
        gfx->enable(G3D::DITHERING);
      else
        gfx->disable(G3D::DITHERING);
      break;

    case Key::F3:
      first = Clamp::integer(first-8, 0, 248);
      break;

    case Key::F4:
      first = Clamp::integer(first+8, 0, 248);
      break;

    case Key::F5:
      step = Clamp::integer(step-1, 2, 32);
      break;

    case Key::F6:
      step = Clamp::integer(step+1, 2, 32);
      break;

    case Key::F7:
      flags.gouraud = !flags.gouraud;
      if (flags.gouraud) {
        texture->setEnvironment(G3D::MODULATE);
        gfx->enable(G3D::GOURAUD);
      }
      else {
        texture->setEnvironment(G3D::REPLACE);
        gfx->disable(G3D::GOURAUD);
      }
      break;

    case Key::F8:
      flags.baseOnly = !flags.baseOnly;
      break;

    case Key::F10:
      verbose = !verbose;
      break;

    default:
      dprint("keyPressNonPrintable() %d\n", code);
      break;
  }
  tprint("TGIS [map %d x %d] [base %d] [step %d] [filter %s] [dither %s]",
    texture->getW(), texture->getH(), first, step,
    flags.filtering ? "on" : "off",
    flags.dithering ? "on" : "off"
  );
}

void App::keyPressPrintable(I_SRC, sint32 ch)
{
  dprint("keyPressPrintable() %c\n", ch);
}

void App::mousePress(I_SRC, uint32 code)
{
  dprint("mousePress() 0x%08X\n", (unsigned)code);
}

void App::mouseRelease(I_SRC, uint32 code)
{
  dprint("mouseRelease() 0x%08X\n", (unsigned)code);
}

void App::mouseMove(I_SRC, sint16 x, sint16 y, sint16 dx, sint16 dy)
{
  dprint("mouseMove() %hd, %hd, %hd, %hd\n", x, y, dx, dy);
}

void App::mouseDrag(I_SRC, sint16 x, sint16 y, sint16 dx, sint16 dy, uint32 s)
{
  dprint("mouseDrag() %hd, %hd, %hd, %hd, 0x%08X\n", x, y, dx, dy, (unsigned)s);
}

