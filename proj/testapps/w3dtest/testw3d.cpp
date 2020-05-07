//****************************************************************************//
//**                                                                        **//
//** File:         proj/W3DTest/testw3d.cpp                                 **//
//** Description:  Warp3D test application                                  **//
//** Comment(s):   This software calls Warp3D directly and is hence not     **//
//**               portable.                                                **//
//** Created:      2004-01-31                                               **//
//** Updated:      2004-02-01                                               **//
//** Author(s):    Karl Churchill                                           **//
//** Note(s):                                                               **//
//** Copyright:    (C)1996-2004, eXtropia Studios                           **//
//**               Serkan YAZICI, Karl Churchill                            **//
//**                                                                        **//
//**               Warp3D (C) Hyperion Entertainment                        **//
//**                                                                        **//
//**               All Rights Reserved.                                     **//
//**                                                                        **//
//****************************************************************************//

#include "testw3d.hpp"
#include <systemlib/cpu.hpp>

extern "C" {
  #include <string.h>
}

////////////////////////////////////////////////////////////////////////////////

const char TestWarp3D::dBoxExit[]      = "Exit";
const char TestWarp3D::dBoxProceed[]  = "Proceed";
const char TestWarp3D::dBoxRunSkip[]  = "Run Test|Skip Test";
const char TestWarp3D::dBoxError[]    = "Error";
const char TestWarp3D::dBoxInfo[]      = "Information";
const char TestWarp3D::dBoxQuery[]    = "Query";
const char TestWarp3D::dBoxBool[]      = "Yes|No";
const char TestWarp3D::qTestPass[]    = "User passed test\n";
const char TestWarp3D::qTestFail[]    = "User failed test\n";
const char TestWarp3D::qTestSkip[]    = "User skipped test\n";
const char version[] = "$VER: testw3d 1.0 (2.2.2004)\n";

char* TestWarp3D::info              = 0;

const char* TestWarp3D::chipNames[]  = {
  "No GPU",
  "Unknown GPU",
  "S3 Virge",
  "3DLabs Permedia2",
  "3Dfx Voodoo 1",
  "3Dfx Voodoo 3/Compatible [Litte endian mode]",
  "3Dfx Voodoo 3/Compatible [Big endian mode]",
  "3DLabs Permedia3",
  "ATI Radeon, first generation",
  "ATI Radeon, second generation",
  0
};

////////////////////////////////////////////////////////////////////////////////

sint32 AppBase::init()
{
  // Do any library initialisation prior to application creation
  sint32 r = QMath::init();
  if (r == OK)
    return GfxLib::init();
  return r;
}

////////////////////////////////////////////////////////////////////////////////

void AppBase::done()
{
  // Do any library cleanup after application exit
  GfxLib::done();
  QMath::done();
}

////////////////////////////////////////////////////////////////////////////////

AppBase* AppBase::createApplicationInstance()
{
  // Create our application object
  return new TestWarp3D;
}

////////////////////////////////////////////////////////////////////////////////

void AppBase::destroyApplicationInstance(AppBase* app)
{
  // Destroy our application object
  delete app;
}

////////////////////////////////////////////////////////////////////////////////

TestWarp3D::TestWarp3D() : gfx(0), logFile(0), minTestTime(500), width(640), height(480), check(0), logName("ram:test.log")
{
  uint32  t    = getInteger("time", false);
  sint16  w    = getInteger("width", false);
  sint16  h    = getInteger("height", false);
  bool    fs  = getSwitch("fullscreen", false);
  char*    s    = (char*)getString("log", false);

  if (t)
    minTestTime = Clamp::integer(t, 200, 2000);

  if (w)
    width = Clamp::integer(w, 320, 1024);
  if (h)
    height = Clamp::integer(h, 240, 768);
  if (s)
    logName = s;

  // Construct our applet
  data      = Mem::alloc(VERT_ALLOC*sizeof(X_SYSNAME::W3D_Vertex), true, Mem::ALIGN_CACHE);
  appWindow  = new DisplayWindow;
  tex        = new Texture;
  logFile    = new StreamOut(logName, true, false);

  if ((strcmp(CPU::getCPU(), "MC68040")==0) ||
       strcmp(CPU::getCPU(), "MC68060")==0)
  {
    check |= CH_MOVE16;
  }
}

////////////////////////////////////////////////////////////////////////////////

TestWarp3D::~TestWarp3D()
{
  // Cleanup and close
  if (logFile)
    delete logFile;
  if (tex)
    delete tex;
  if (gfx)
    delete gfx;
  if (appWindow)
    delete appWindow;
  if (data)
    Mem::free(data);
  delete[] info;
}

////////////////////////////////////////////////////////////////////////////////

sint32 TestWarp3D::initApplication()
{
  if (!(info = new char[512]))
  {
    SystemLib::dialogueBox(dBoxError, dBoxExit,
      "Failed to allocate string buffer"
    );
    return ERR_RSC_UNAVAILABLE;
  }
  if (!logFile || !(logFile->valid()))
  {
    SystemLib::dialogueBox(dBoxError, dBoxExit,
      "Failed to create logfile"
    );
    return ERR_RSC_UNAVAILABLE;
  }

  logFile->writeText("W3DTest Log\n\n");

  if (!data)
  {
    logFile->writeText("Error : Unable to allocate memory for vertex data\n");
    SystemLib::dialogueBox(dBoxError, dBoxExit,
      "Failed to allocate %d bytes for test data",
      VERT_ALLOC*sizeof(DrawVertex)
    );
    return ERR_RSC_UNAVAILABLE;
  }

  if (!appWindow)
  {
    logFile->writeText("Error : Unable to allocate window\n");
    SystemLib::dialogueBox(dBoxError, dBoxExit,
      "Failed to create application window"
    );
    return ERR_RSC_UNAVAILABLE;
  }

  if (appWindow->open(width, height, Pixel::BPP15, "Test")!=OK)
  {
    logFile->writeText("Error : Unable to open window\n");
    SystemLib::dialogueBox(dBoxError, dBoxExit,
      "Failed to open application window"
    );
    return ERR_RSC_UNAVAILABLE;
  }

  gfx = G3D::getRasterizer(appWindow->getDrawSurface());
  if (!gfx)
  {
    logFile->writeText("Error : Unable to create context\n");
    SystemLib::dialogueBox(dBoxError, dBoxExit,
      "Failed to create context"
    );
    return ERR_RSC_UNAVAILABLE;
  }

  if (!(gfx->createZBuffer()))
  {
    check &= ~CH_GOTZBUFFER;

    if (!SystemLib::dialogueBox(dBoxInfo, dBoxRunSkip,
      "Unable to allocate Z Buffer.\n\n"
      "The most likely reason is lack of available\n"
      "graphics card memory.\n"
      "TestW3D will be able to carry out all other\n"
      "tests and skip those that use the Z Buffer.\n\n"
      "If you wish to run the Z buffer tests, please\n"
      "ensure you have closed all other screens and\n"
      "windows, or try a smaller window size."
      ))
    {
      logFile->writeText("\nTestW3D aborted by user [no Z Buffer]\n");
      return ERR_RSC_UNAVAILABLE;
    }
    logFile->writeText("Warn  : Unable to allocate Z Buffer\n");
  }
  else
  {
    check |= CH_GOTZBUFFER;
  }

  gfx->lock();
  gfx->setFlatColour(0xFFC0C0C0);
  gfx->clearDrawArea(0x00000000);
  gfx->unlock();

  appWindow->refresh();

  return OK;
}

////////////////////////////////////////////////////////////////////////////////

sint32 TestWarp3D::runApplication()
{
  getInfo();
  testCompatibility();
  testPerformance();
  return 0;
}

////////////////////////////////////////////////////////////////////////////////

void TestWarp3D::clear()
{
  gfx->lock();
  gfx->clearDrawArea(0x00000000);
  gfx->unlock();
  appWindow->refresh();
}

////////////////////////////////////////////////////////////////////////////////


