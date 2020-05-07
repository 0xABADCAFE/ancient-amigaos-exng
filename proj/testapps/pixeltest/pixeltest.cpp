//****************************************************************************//
//**                                                                        **//
//** File:         proj/gfxTest/pixeltest.cpp                               **//
//** Description:  Gfx speed test application                               **//
//** Comment(s):   This software tests direct surface access timing and     **//
//**               pixel conversion.                                        **//
//** Created:      2004-03-18                                               **//
//** Updated:      2004-03-18                                               **//
//** Author(s):    Karl Churchill                                           **//
//** Note(s):      It's not my fault. Patrik made me do it.                 **//
//**               Application is not system idependent as it relies on     **//
//**               asm                                                      **//
//** Copyright:    (C)1996-2004, eXtropia Studios                           **//
//**               Serkan YAZICI, Karl Churchill                            **//
//**                                                                        **//
//**               All Rights Reserved.                                     **//
//**                                                                        **//
//****************************************************************************//


#include <xbase.hpp>
#include <systemlib/cpu.hpp>
#include <systemlib/timer.hpp>
#include <systemlib/thread.hpp>
#include <gfxlib/gfx.hpp>

#include <new>
using std::nothrow;

extern "C" {
  #include <string.h>
}



////////////////////////////////////////////////////////////////////////////////

class GfxTestApp : public AppBase, _Nat2D {
  private:
    Display*        appDisplay;
    char*            text;
    MilliClock      timer;
    sint32          width;
    sint32          height;
    Pixel::HWType    testDataFormat;
    Pixel::Depth    fullScreenDepth;
    void*            testData;
    void*            testData2;
    size_t          testDataSize;
    bool            move16Tests; // amiga only
    bool            useLock;


    // asm defined
    static void      readMem(void* src, size_t len);
    static void      copyMem16(void *dst, void* src, size_t len);
    static void      shuffleCopy16(void *dst, void* src, size_t len);
    static void      setMem16(void* dst, sint32 val, size_t len);
    //static void      swapCopy16_16(void* dst, void* src, size_t len);

    void            lockKernel();
    void            unlockKernel();

    sint32          createTestData();
    float64          testWriteVRAM();
    float64          testWrite16VRAM();
    float64          testReadVRAM();
    float64          testCopyRAM2VRAM();
    float64          testCopyVRAM2RAM();


    // for Patrik :-)
    float64          testCopy16RAM2VRAM();
    float64          testCopy16VRAM2RAM();
    float64          testWriteRAM();
    float64          testWrite16RAM();
    float64          testReadRAM();
    float64          testCopyRAM2RAM();
    float64          testCopy16RAM2RAM();
    float64          testCLibWriteRAM();
    float64          testCLibWriteVRAM();
    float64          testCLibCopyRAM2RAM();
    float64          testCLibCopyRAM2VRAM();

    //float64          testSwap16RAM2VRAM();

    float64          testShuffleCopy16RAM2VRAM(sint32 ofs);
    float64          testShuffleCopy16RAM2RAM(sint32 ofs);
    float64          testOSCopyMemRAM2VRAM(sint32 ofs);
    float64          testOSCopyMemRAM2RAM(sint32 ofs);


    float64          testConversion();
    void            dumpPixelInfo(PixelDescriptor* pxl);

  protected:
    sint32      initApplication();
    sint32      runApplication();

  public:
    GfxTestApp();
    ~GfxTestApp();
};

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
  return new(nothrow) GfxTestApp;
}

void AppBase::destroyApplicationInstance(AppBase* app)
{
  delete app;
}

////////////////////////////////////////////////////////////////////////////////

GfxTestApp::GfxTestApp() : appDisplay(0), fullScreenDepth(Pixel::BPP15), move16Tests(false)
{
  sint32 tw = getInteger("width", false);
  if (tw)
    width = Clamp::integer(tw, 160, 1024);
  else
    width    = 640;

  sint32 th = getInteger("height", false);
  if (th)
    height  = Clamp::integer(th, 120, 768);
  else
    height = 480;
  text        = new char[256];

  sint32 fsd = getInteger("fullscreen", false);

  useLock = getSwitch("lock", false);

  if (fsd!=0)
  {
    if (fsd == 16)
      fullScreenDepth = Pixel::BPP16;
    else if (fsd <= 24)
      fullScreenDepth = Pixel::BPP24;
    else
      fullScreenDepth = Pixel::BPP32;

    appDisplay = new DisplayScreen();
  }
  else
  {
    appDisplay  = new DisplayWindow();
  }

  if ((stricmp(CPU::getCPU(), "MC68040")==0) || stricmp(CPU::getCPU(), "MC68060")==0)
  {
    move16Tests = true;
  }
}

////////////////////////////////////////////////////////////////////////////////

GfxTestApp::~GfxTestApp()
{
  delete appDisplay;
  delete[] text;
  if (testData2)
    Mem::free(testData2);
  if (testData)
    Mem::free(testData);
}

////////////////////////////////////////////////////////////////////////////////

void GfxTestApp::lockKernel()
{
  if (useLock) {
    X_SYSNAME::Forbid();
    X_SYSNAME::Disable();
  }
}

void GfxTestApp::unlockKernel()
{
  if (useLock) {
    X_SYSNAME::Enable();
    X_SYSNAME::Permit();
  }
}

void GfxTestApp::readMem(void* src, size_t len)
{
  asm(
    "\n/*************************************/\n\n"
    "\tmove.l %0, a0\n"
    "\tmove.l %1, d0\n"
    "\tjsr readMem__GfxTestApp\n"
    "\n/*************************************/\n\n"
    :                                  // no outputs
    : "g"(src), "g"(len)              // inputs
    : "d0", "d1", "a0", "cc"          // clobbers
  );
}

////////////////////////////////////////////////////////////////////////////////

void GfxTestApp::copyMem16(void *dst, void* src, size_t len)
{
  asm(
    "\n/*************************************/\n\n"
    "\tmove.l %0, a0\n"
    "\tmove.l %1, a1\n"
    "\tmove.l %2, d0\n"
    "\tjsr copyMem16__GfxTestApp\n"
    "\n/*************************************/\n\n"
    :                                  // no outputs
    : "g"(dst), "g"(src), "g"(len)    // inputs
    : "d0", "d1", "a0", "a1", "cc"    // clobbers
  );
}

////////////////////////////////////////////////////////////////////////////////

void GfxTestApp::shuffleCopy16(void *dst, void* src, size_t len)
{
  asm(
    "\n/*************************************/\n\n"
    "\tmove.l %0, a0\n"
    "\tmove.l %1, a1\n"
    "\tmove.l %2, d0\n"
    "\tjsr shuffleCopy16__GfxTestApp\n"
    "\n/*************************************/\n\n"
    :                                  // no outputs
    : "g"(dst), "g"(src), "g"(len)    // inputs
    : "d0", "d1", "a0", "a1", "cc"    // clobbers
  );
}

////////////////////////////////////////////////////////////////////////////////

void GfxTestApp::setMem16(void *dst, sint32 val, size_t len)
{
  asm(
    "\n/*************************************/\n\n"
    "\tmove.l %0, a0\n"
    "\tmove.l %1, d0\n"
    "\tmove.l %2, d1\n"
    "\tjsr set16__GfxTestApp\n"
    "\n/*************************************/\n\n"
    :                                  // no outputs
    : "g"(dst), "g"(val), "g"(len)    // inputs
    : "d0", "d1", "a0", "a1", "cc"    // clobbers
  );
}

////////////////////////////////////////////////////////////////////////////////


//void GfxTestApp::swapCopy16_16(void *dst, void* src, size_t len)
//{
//  asm(
//    "\n/*************************************/\n\n"
//    "\tmove.l %0, a0\n"
//    "\tmove.l %1, a1\n"
//    "\tmove.l %2, d0\n"
//    "\tjsr swapCopy32_16__GfxTestApp\n"
//    "\n/*************************************/\n\n"
//    :                                  // no outputs
//    : "g"(dst), "g"(src), "g"(len)    // inputs
//    : "d0", "d1", "a0", "a1", "cc"    // clobbers
//  );
//}

////////////////////////////////////////////////////////////////////////////////

sint32 GfxTestApp::initApplication()
{
  if (!appDisplay || (appDisplay->open(width, height, fullScreenDepth, "EXNG pixeltest")!=OK))
    return ERR_RSC_UNAVAILABLE;

  const char*  s  = getString("fmt", false);
  if (s)
  {
/*
    if (stricmp(s, "INDEX8")==0)
      testDataFormat = Pixel::INDEX8;
*/
    if (stricmp(s, "RGB15B")==0)
      testDataFormat = Pixel::RGB15B;
    else if (stricmp(s, "BGR15B")==0)
      testDataFormat = Pixel::BGR15B;
    else if (stricmp(s, "RGB15L")==0)
      testDataFormat = Pixel::RGB15L;
    else if (stricmp(s, "BGR15L")==0)
      testDataFormat = Pixel::BGR15L;
    else if (stricmp(s, "RGB16B")==0)
      testDataFormat = Pixel::RGB16B;
    else if (stricmp(s, "BGR16B")==0)
      testDataFormat = Pixel::BGR16B;
    else if (stricmp(s, "RGB16L")==0)
      testDataFormat = Pixel::RGB16L;
    else if (stricmp(s, "BGR16L")==0)
      testDataFormat = Pixel::BGR16L;
    else if (stricmp(s, "RGB24P")==0)
      testDataFormat = Pixel::RGB24P;
    else if (stricmp(s, "BGR24P")==0)
      testDataFormat = Pixel::BGR24P;
    else if (stricmp(s, "ARGB32B")==0)
      testDataFormat = Pixel::ARGB32B;
    else if (stricmp(s, "ABGR32B")==0)
      testDataFormat = Pixel::ABGR32B;
    else if (stricmp(s, "ARGB32L")==0)
      testDataFormat = Pixel::ARGB32L;
    else if (stricmp(s, "ABGR32L")==0)
      testDataFormat = Pixel::ABGR32L;
    else
      testDataFormat = Pixel::RGB16B;
  }
  else
    testDataFormat = appDisplay->getDrawSurface()->getFormat();
  return createTestData();
}

////////////////////////////////////////////////////////////////////////////////

void GfxTestApp::dumpPixelInfo(PixelDescriptor *pxl)
{
  printf("\nBytes   : %lu, endian %s\n",
          pxl->getSize(),
          pxl->isSwapped() ? "swapped" : "native");
  printf("Bits    : A[%3lu] R[%3lu] G[%3lu] B[%3lu]\n",
          pxl->getBitsAlpha(),
          pxl->getBitsRed(),
          pxl->getBitsGreen(),
          pxl->getBitsBlue());
  printf("Offsets : A[%3lu] R[%3lu] G[%3lu] B[%3lu]\n",
          pxl->getShiftAlpha(),
          pxl->getShiftRed(),
          pxl->getShiftGreen(),
          pxl->getShiftBlue());
  printf("Maxima  : A[%3lu] R[%3lu] G[%3lu] B[%3lu]\n",
          pxl->getMaxAlpha(),
          pxl->getMaxRed(),
          pxl->getMaxGreen(),
          pxl->getMaxBlue());
  printf("\n");
}

////////////////////////////////////////////////////////////////////////////////

sint32 GfxTestApp::createTestData()
{
  //  Create a nice shaded rectangle that has RGB interpolation as a test set
  //  of data for the conversion routines
  //
  //  Red    0-max from top to bottom
  //  Green  0-max from right to left
  //  Blue   0-max from left to right
  //

  // Get the pixel properties for the requested data format

  PixelDescriptor* pxl = PixelDescriptor::get(testDataFormat);

  if (!pxl || pxl->getSize()==1)
    return ERR_VALUE;

  size_t size = width*height*pxl->getSize();
  size_t alloc = 0;

  while (alloc<size)
    alloc+=1048576;


  // Get memory, round up to nearest whole MB
  testData = Mem::alloc(alloc, false, Mem::ALIGN_CACHE);
  testData2 = Mem::alloc(alloc, false, Mem::ALIGN_CACHE);

  if (!testData || !testData2)
    return ERR_NO_FREE_STORE;

  testDataSize = alloc;

  // Get interpolation steps (16.16 fixed)
  uint32 deltaR = (pxl->getMaxRed()<<16)/height;
  uint32 deltaG = (pxl->getMaxGreen()<<16)/width;
  uint32 deltaB = (pxl->getMaxBlue()<<16)/width;

  // These are offsets for the pixel fields
  uint32  offstR  = pxl->getShiftRed();
  uint32  offstG  = pxl->getShiftGreen();
  uint32  offstB  = pxl->getShiftBlue();

  switch (pxl->getSize())
  {
/*
    case 1: {
      ruint8*    p = (uint8*)testData;
    } break;
*/
    case 2: {
      // 15/16-bit pixels
      ruint16*  p = (uint16*)testData;
      uint32    valR = 0;
      for (rsint32 y = 0; y<height; y++, valR += deltaR)
      {
        uint32 valB  = 0;
        uint32 valG  = (pxl->getMaxGreen())<<16;
        for(rsint32 x = 0; x<width; x++, valB+=deltaB, valG -= deltaG)
        {
          *p++ = (valR>>16)<<offstR | (valG>>16)<<offstG | (valB>>16)<<offstB;
        }
      }
      if (pxl->isSwapped())
        Mem::swap16(testData, testData, width*height);
      return OK;
    } break;

    case 3: {
      // 24-bit packed pixels, channel offsets are byte indexes
      ruint8*  p = (uint8*)testData;
      uint32  valR = 0;
      for (rsint32 y = 0; y<height; y++, valR += deltaR)
      {
        uint32 valB  =  0;
        uint32 valG  = (pxl->getMaxGreen())<<16;
        for(rsint32 x = 0; x<width; x++, valB += deltaB, valG -= deltaG, p+=3)
        {
          p[offstR] = (valR>>16); p[offstG] = (valG>>16); p[offstB] = (valB>>16);
        }
      }
      return OK;
    } break;

    case 4: {
      // 32-bit pixels
      ruint32*  p = (uint32*)testData;
      uint32    valR = 0;

      for (rsint32 y = 0; y<height; y++, valR += deltaR)
      {
        uint32 valB  = 0;
        uint32 valG  = (pxl->getMaxGreen())<<16;
        for(rsint32 x = 0; x<width; x++, valB += deltaB, valG -= deltaG)
        {
          *p++ = (valR>>16)<<offstR | (valG>>16)<<offstG | (valB>>16)<<offstB;
        }
      }
      if (pxl->isSwapped())
        Mem::swap32(testData, testData, width*height);
      return OK;
    } break;
  }
  return ERR_RSC;
}

////////////////////////////////////////////////////////////////////////////////

#define SAMPLETIME 2000.0 // sample duration limit
#define MAXLOCKTIME 50.0  // maximum lock

////////////////////////////////////////////////////////////////////////////////

float64 GfxTestApp::testWriteVRAM()
{
  Surface* surf          = appDisplay->getDrawSurface();
  PixelDescriptor*  pd  = surf->getDescriptor();
  sint32  totBytes      = pd->getSize()*(surf->getH()*(surf->getW() + surf->getModulus()));
  sint32  reps          = 0;
  float64  totTime        = 0.0;

  while (totTime < SAMPLETIME)
  {
    sprintf(text, "Graphics Write Test %.2f ms", totTime);
    appDisplay->setTitle(text);
    void *d = surf->lockData();
    if (d)
    {
      float64 lockTime = 0.0;
      while (lockTime<MAXLOCKTIME)
      {
        lockKernel();
        timer.set();
        Mem::set(d, (uint8)reps, totBytes);
        lockTime += timer.elapsedFrac();
        unlockKernel();
        reps++;
      }
      totTime += lockTime;
      surf->unlockData();
      appDisplay->refresh();
    }
    else
    {
      SystemLib::dialogueBox("Error", "Cancel", "Unable to lock surface");
      break;
    }
  }
  return ((float64)totBytes*1000*reps)/(totTime*1024.0);
}

////////////////////////////////////////////////////////////////////////////////

float64 GfxTestApp::testCLibWriteVRAM()
{
  Surface* surf          = appDisplay->getDrawSurface();
  PixelDescriptor*  pd  = surf->getDescriptor();
  sint32  totBytes      = pd->getSize()*(surf->getH()*(surf->getW() + surf->getModulus()));
  sint32  reps          = 0;
  float64  totTime        = 0.0;

  while (totTime < SAMPLETIME)
  {
    sprintf(text, "Graphics Write (memset) Test %.2f ms", totTime);
    appDisplay->setTitle(text);
    void *d = surf->lockData();
    if (d)
    {
      float64 lockTime = 0.0;
      while (lockTime<MAXLOCKTIME)
      {
        lockKernel();
        timer.set();
        memset(d, (int)reps, totBytes);
        lockTime += timer.elapsedFrac();
        unlockKernel();
        reps++;
      }
      totTime += lockTime;
      surf->unlockData();
      appDisplay->refresh();
    }
    else
    {
      SystemLib::dialogueBox("Error", "Cancel", "Unable to lock surface");
      break;
    }
  }
  return ((float64)totBytes*1000*reps)/(totTime*1024.0);
}

////////////////////////////////////////////////////////////////////////////////

float64 GfxTestApp::testWrite16VRAM()
{
  Surface* surf          = appDisplay->getDrawSurface();
  PixelDescriptor*  pd  = surf->getDescriptor();
  sint32  totBytes      = pd->getSize()*(surf->getH()*(surf->getW() + surf->getModulus()));
  sint32  reps          = 0;
  float64  totTime        = 0.0;

  while (totTime < SAMPLETIME)
  {
    sprintf(text, "Graphics Write (move16) Test %.2f ms", totTime);
    appDisplay->setTitle(text);
    void *d = surf->lockData();
    if (d)
    {
      float64 lockTime = 0.0;
      while (lockTime<MAXLOCKTIME)
      {
        lockKernel();
        timer.set();
        setMem16(d, (uint8)reps, totBytes);
        lockTime += timer.elapsedFrac();
        unlockKernel();
        reps++;
      }
      totTime += lockTime;
      surf->unlockData();
      appDisplay->refresh();
    }
    else
    {
      SystemLib::dialogueBox("Error", "Cancel", "Unable to lock surface");
      break;
    }
  }
  float64 res = ((float64)totBytes*1000*reps)/(totTime*1024.0);
  if (SystemLib::dialogueBox("Info", "Yes|No", "Any glitches?"))
    return -res;
  return res;
}

////////////////////////////////////////////////////////////////////////////////

float64 GfxTestApp::testReadVRAM()
{
  Surface* surf          = appDisplay->getDrawSurface();
  PixelDescriptor*  pd  = surf->getDescriptor();
  sint32  totBytes      = pd->getSize()*(surf->getH()*(surf->getW() + surf->getModulus()));
  sint32  reps          = 0;
  float64  totTime        = 0.0;

  while (totTime < SAMPLETIME)
  {
    sprintf(text, "Graphics Read Test %.2f ms", totTime);
    appDisplay->setTitle(text);
    void *d = surf->lockData();
    if (d)
    {
      float64 lockTime = 0.0;
      while (lockTime<MAXLOCKTIME)
      {
        lockKernel();
        timer.set();
        readMem(d, totBytes);
        lockTime += timer.elapsedFrac();
        unlockKernel();
        reps++;
      }
      totTime += lockTime;
      surf->unlockData();
    }
    else
    {
      SystemLib::dialogueBox("Error", "Proceed", "Unable to lock surface");
      break;
    }
  }
  return ((float64)totBytes*1000*reps)/(totTime*1024.0);
}

////////////////////////////////////////////////////////////////////////////////

float64 GfxTestApp::testCopyRAM2VRAM()
{
  Surface* surf          = appDisplay->getDrawSurface();
  PixelDescriptor*  pd  = surf->getDescriptor();
  sint32  totBytes      = pd->getSize()*(width*height);
  sint32  reps          = 0;
  float64  totTime        = 0.0;

  while  (totTime < SAMPLETIME)
  {
    sprintf(text, "Copy RAM to VRAM Test %.2f ms", totTime);
    appDisplay->setTitle(text);
    void *d = surf->lockData();
    if (d)
    {
      float64 lockTime = 0.0;
      while (lockTime<MAXLOCKTIME)
      {
        lockKernel();
        timer.set();
        Mem::copy(d, testData, totBytes);
        lockTime += timer.elapsedFrac();
        unlockKernel();
        reps++;
      }
      totTime += lockTime;
      surf->unlockData();
    }
    else
    {
      SystemLib::dialogueBox("Error", "Proceed", "Unable to lock surface");
      break;
    }
    appDisplay->refresh();
  }
  return ((float64)totBytes*1000*reps)/(totTime*1024.0);
}

////////////////////////////////////////////////////////////////////////////////
/*
float64 GfxTestApp::testOSCopyRAM2VRAM()
{
  Surface* surf          = appDisplay->getDrawSurface();
  PixelDescriptor*  pd  = surf->getDescriptor();
  sint32  totBytes      = pd->getSize()*(width*height);
  sint32  reps          = 0;
  float64  totTime        = 0.0;

  while  (totTime < SAMPLETIME)
  {
    sprintf(text, "Copy RAM to VRAM (CopyMem) Test %.2f ms", totTime);
    appDisplay->setTitle(text);
    void *d = surf->lockData();
    if (d)
    {
      float64 lockTime = 0.0;
      while (lockTime<MAXLOCKTIME)
      {
        lockKernel();
        timer.set();
        X_SYSNAME::CopyMem(testData, d, totBytes);
        lockTime += timer.elapsedFrac();
        unlockKernel();
        reps++;
      }
      totTime += lockTime;
      surf->unlockData();
    }
    else
    {
      SystemLib::dialogueBox("Error", "Proceed", "Unable to lock surface");
      break;
    }
    appDisplay->refresh();
  }
  return ((float64)totBytes*1000*reps)/(totTime*1024.0);
}
*/
////////////////////////////////////////////////////////////////////////////////

float64 GfxTestApp::testCLibCopyRAM2VRAM()
{
  Surface* surf          = appDisplay->getDrawSurface();
  PixelDescriptor*  pd  = surf->getDescriptor();
  sint32  totBytes      = pd->getSize()*(width*height);
  sint32  reps          = 0;
  float64  totTime        = 0.0;

  while  (totTime < SAMPLETIME)
  {
    sprintf(text, "Copy RAM to VRAM (memcpy) Test %.2f ms", totTime);
    appDisplay->setTitle(text);
    void *d = surf->lockData();
    if (d)
    {
      float64 lockTime = 0.0;
      while (lockTime<MAXLOCKTIME)
      {
        lockKernel();
        timer.set();
        memcpy(d, testData, totBytes);
        lockTime += timer.elapsedFrac();
        unlockKernel();
        reps++;
      }
      totTime += lockTime;
      surf->unlockData();
    }
    else
    {
      SystemLib::dialogueBox("Error", "Proceed", "Unable to lock surface");
      break;
    }
    appDisplay->refresh();
  }
  return ((float64)totBytes*1000*reps)/(totTime*1024.0);
}

////////////////////////////////////////////////////////////////////////////////

float64 GfxTestApp::testCopy16RAM2VRAM()
{
  if (!move16Tests)
    return 0;
  Surface* surf          = appDisplay->getDrawSurface();
  PixelDescriptor*  pd  = surf->getDescriptor();
  sint32  totBytes      = pd->getSize()*(width*height);
  sint32  reps          = 0;
  float64  totTime        = 0.0;

  while  (totTime < SAMPLETIME)
  {
    sprintf(text, "Copy RAM to VRAM (move16) Test %.2f ms", totTime);
    appDisplay->setTitle(text);
    void *d = surf->lockData();
    if (d)
    {
      float64 lockTime = 0.0;
      while (lockTime<MAXLOCKTIME)
      {
        lockKernel();
        timer.set();
        copyMem16(d, testData, totBytes);
        lockTime += timer.elapsedFrac();
        unlockKernel();
        reps++;
      }
      totTime += lockTime;
      surf->unlockData();
    }
    else
    {
      SystemLib::dialogueBox("Error", "Proceed", "Unable to lock surface");
      break;
    }
    appDisplay->refresh();
  }
  return ((float64)totBytes*1000*reps)/(totTime*1024.0);
}

////////////////////////////////////////////////////////////////////////////////
/*
float64 GfxTestApp::testSwap16RAM2VRAM()
{
  if (!move16Tests)
    return 0;
  Surface* surf          = appDisplay->getDrawSurface();
  PixelDescriptor*  pd  = surf->getDescriptor();
  sint32  totBytes      = pd->getSize()*(width*height);
  sint32  reps          = 0;
  float64  totTime        = 0.0;

  while  (totTime < SAMPLETIME)
  {
    sprintf(text, "Copy RAM to VRAM (move16) Test %.2f ms", totTime);
    appDisplay->setTitle(text);
    void *d = surf->lockData();
    if (d)
    {
      float64 lockTime = 0.0;
      while (lockTime<MAXLOCKTIME)
      {
        lockKernel();
        timer.set();
        swapCopy16_16(d, testData, totBytes);
        lockTime += timer.elapsedFrac();
        unlockKernel();
        reps++;
      }
      totTime += lockTime;
      surf->unlockData();
    }
    else
    {
      SystemLib::dialogueBox("Error", "Proceed", "Unable to lock surface");
      break;
    }
    appDisplay->refresh();
  }
  return ((float64)totBytes*1000*reps)/(totTime*1024.0);
}
*/
////////////////////////////////////////////////////////////////////////////////

float64 GfxTestApp::testShuffleCopy16RAM2VRAM(sint32 ofs)
{
  if (!move16Tests)
    return 0;
  Surface* surf          = appDisplay->getDrawSurface();
  PixelDescriptor*  pd  = surf->getDescriptor();
  sint32  totBytes      = (pd->getSize()*(width*height))-ofs;
  void*    srcData        = ((uint8*)testData)+ofs;
  sint32  reps          = 0;
  float64  totTime        = 0.0;

  while  (totTime < SAMPLETIME)
  {
    sprintf(text, "Shuffle RAM to VRAM (move16 : src offset %ld) Test %.2f ms", ofs, totTime);
    appDisplay->setTitle(text);
    void *d = surf->lockData();
    if (d)
    {
      float64 lockTime = 0.0;
      while (lockTime<MAXLOCKTIME)
      {
        lockKernel();
        timer.set();
        shuffleCopy16(d, srcData, totBytes);
        lockTime += timer.elapsedFrac();
        unlockKernel();
        reps++;
      }
      totTime += lockTime;
      surf->unlockData();
    }
    else
    {
      SystemLib::dialogueBox("Error", "Proceed", "Unable to lock surface");
      break;
    }
    appDisplay->refresh();
  }
  float64 res = ((float64)totBytes*1000*reps)/(totTime*1024.0);
  if (SystemLib::dialogueBox("Info", "Yes|No", "Any glitches?"))
    return -res;
  return res;
}

////////////////////////////////////////////////////////////////////////////////

float64 GfxTestApp::testShuffleCopy16RAM2RAM(sint32 ofs)
{
  if (!move16Tests)
    return 0;
  void*    srcData        = ((uint8*)testData)+ofs;
  sint32  reps          = 0;
  sint32  totBytes      = testDataSize-ofs;
  float64  totTime        = 0.0;

  while  (totTime < SAMPLETIME)
  {
    sprintf(text, "Shuffle RAM to RAM (move16 : src offset %ld) Test %.2f ms", ofs, totTime);
    appDisplay->setTitle(text);
    lockKernel();
    timer.set();
    shuffleCopy16(testData2, srcData, totBytes);
    totTime += timer.elapsedFrac();
    unlockKernel();
    reps++;
  }
  return ((float64)totBytes*1000*reps)/(totTime*1024.0);
}

////////////////////////////////////////////////////////////////////////////////

float64 GfxTestApp::testOSCopyMemRAM2VRAM(sint32 ofs)
{
  Surface* surf          = appDisplay->getDrawSurface();
  PixelDescriptor*  pd  = surf->getDescriptor();
  sint32  totBytes      = (pd->getSize()*(width*height))-ofs;
  void*    srcData        = ((uint8*)testData)+ofs;
  sint32  reps          = 0;
  float64  totTime        = 0.0;

  while  (totTime < SAMPLETIME)
  {
    sprintf(text, "Shuffle RAM to VRAM (CopyMem : src offset %ld) Test %.2f ms", ofs, totTime);
    appDisplay->setTitle(text);
    void *d = surf->lockData();
    if (d)
    {
      float64 lockTime = 0.0;
      while (lockTime<MAXLOCKTIME)
      {
        lockKernel();
        timer.set();
        X_SYSNAME::CopyMem(srcData, d, totBytes);
        lockTime += timer.elapsedFrac();
        unlockKernel();
        reps++;
      }
      totTime += lockTime;
      surf->unlockData();
    }
    else
    {
      SystemLib::dialogueBox("Error", "Proceed", "Unable to lock surface");
      break;
    }
    appDisplay->refresh();
  }
  float64 res = ((float64)totBytes*1000*reps)/(totTime*1024.0);
  if (SystemLib::dialogueBox("Info", "Yes|No", "Any glitches?"))
    return -res;
  return res;
}

////////////////////////////////////////////////////////////////////////////////

float64 GfxTestApp::testOSCopyMemRAM2RAM(sint32 ofs)
{
  void*    srcData        = ((uint8*)testData)+ofs;
  sint32  reps          = 0;
  sint32  totBytes      = testDataSize-ofs;
  float64  totTime        = 0.0;

  while  (totTime < SAMPLETIME)
  {
    sprintf(text, "Shuffle RAM to RAM (CopyMem : src offset %ld) Test %.2f ms", ofs, totTime);
    appDisplay->setTitle(text);
    lockKernel();
    timer.set();
    X_SYSNAME::CopyMem(testData2, srcData, totBytes);
    totTime += timer.elapsedFrac();
    unlockKernel();
    reps++;
  }
  return ((float64)totBytes*1000*reps)/(totTime*1024.0);
}

////////////////////////////////////////////////////////////////////////////////

float64 GfxTestApp::testCopyVRAM2RAM()
{
  Surface* surf          = appDisplay->getDrawSurface();
  PixelDescriptor*  pd  = surf->getDescriptor();
  sint32  totBytes      = pd->getSize()*(surf->getH()*(surf->getW() + surf->getModulus()));
  sint32  reps          = 0;
  float64  totTime        = 0.0;

  void* testBuffer = Mem::alloc(totBytes, false, Mem::ALIGN_CACHE);
  if (testBuffer)
  {
    while  (totTime<SAMPLETIME)
    {
      sprintf(text, "Copy VRAM to RAM Test %.2f ms", totTime);
      appDisplay->setTitle(text);
      void *d = surf->lockData();
      if (d)
      {
        float64 lockTime = 0.0;
        while (lockTime<MAXLOCKTIME)
        {
          lockKernel();
          timer.set();
          Mem::copy(testBuffer, d, totBytes);
          lockTime += timer.elapsedFrac();
          unlockKernel();
          reps++;
        }
        totTime += lockTime;
        surf->unlockData();
      }
      else
      {
        SystemLib::dialogueBox("Error", "Proceed", "Unable to lock surface");
        break;
      }
    }
    Mem::free(testBuffer);
    return ((float64)totBytes*1000*reps)/(totTime*1024.0);
  }
  return 0;
}

////////////////////////////////////////////////////////////////////////////////

float64 GfxTestApp::testCopy16VRAM2RAM()
{
  if (!move16Tests)
    return 0;

  Surface* surf          = appDisplay->getDrawSurface();
  PixelDescriptor*  pd  = surf->getDescriptor();
  sint32  totBytes      = pd->getSize()*(surf->getH()*(surf->getW() + surf->getModulus()));
  sint32  reps          = 0;
  float64  totTime        = 0.0;

  void* testBuffer = Mem::alloc(totBytes, false, Mem::ALIGN_CACHE);
  if (testBuffer)
  {
    while  (totTime<SAMPLETIME)
    {
      sprintf(text, "Copy VRAM to RAM (move16) Test %.2f ms", totTime);
      appDisplay->setTitle(text);
      void *d = surf->lockData();
      if (d)
      {
        float64 lockTime = 0.0;
        while (lockTime<MAXLOCKTIME)
        {
          lockKernel();
          timer.set();
          copyMem16(testBuffer, d, totBytes);
          lockTime += timer.elapsedFrac();
          unlockKernel();
          reps++;
        }
        totTime += lockTime;
        surf->unlockData();
      }
      else
      {
        SystemLib::dialogueBox("Error", "Proceed", "Unable to lock surface");
        break;
      }
    }
    Mem::free(testBuffer);
    return ((float64)totBytes*1000*reps)/(totTime*1024.0);
  }
  return 0;
}

////////////////////////////////////////////////////////////////////////////////

float64 GfxTestApp::testCopyRAM2RAM()
{
  sint32  reps          = 0;
  float64  totTime        = 0.0;
  while  (totTime < SAMPLETIME)
  {
    sprintf(text, "Copy RAM to RAM Test %.2f ms", totTime);
    appDisplay->setTitle(text);
    lockKernel();
    timer.set();
    Mem::copy(testData2, testData, testDataSize);
    totTime += timer.elapsedFrac();
    unlockKernel();
    reps++;
  }
  return ((float64)testDataSize*1000*reps)/(totTime*1024.0);
}

////////////////////////////////////////////////////////////////////////////////

float64 GfxTestApp::testCopy16RAM2RAM()
{
  if (!move16Tests)
    return 0;

  sint32  reps          = 0;
  float64  totTime        = 0.0;

  while  (totTime < SAMPLETIME)
  {
    sprintf(text, "Copy RAM to RAM (move16) Test %.2f ms", totTime);
    appDisplay->setTitle(text);
    lockKernel();
    timer.set();
    copyMem16(testData2, testData, testDataSize);
    totTime += timer.elapsedFrac();
    unlockKernel();
    reps++;
  }
  return ((float64)testDataSize*1000*reps)/(totTime*1024.0);
}

////////////////////////////////////////////////////////////////////////////////
/*
float64 GfxTestApp::testOSCopyRAM2RAM()
{
  sint32  reps          = 0;
  float64  totTime        = 0.0;

  while  (totTime < SAMPLETIME)
  {
    sprintf(text, "Copy RAM to RAM (CopyMem) Test %.2f ms", totTime);
    appDisplay->setTitle(text);
    lockKernel();
    timer.set();
    //Mem::copy(testBuffer, testData, totBytes);
    X_SYSNAME::CopyMem(testData2, testData, testDataSize);
    totTime += timer.elapsedFrac();
    unlockKernel();
    reps++;
  }
  return ((float64)testDataSize*1000*reps)/(totTime*1024.0);
}
*/
////////////////////////////////////////////////////////////////////////////////

float64 GfxTestApp::testCLibCopyRAM2RAM()
{
  sint32  reps          = 0;
  float64  totTime        = 0.0;

  while  (totTime < SAMPLETIME)
  {
    sprintf(text, "Copy RAM to RAM (memcpy) Test %.2f ms", totTime);
    appDisplay->setTitle(text);
    lockKernel();
    timer.set();
    memcpy(testData2, testData, testDataSize);
    totTime += timer.elapsedFrac();
    unlockKernel();
    reps++;
  }
  return ((float64)testDataSize*1000*reps)/(totTime*1024.0);
}

////////////////////////////////////////////////////////////////////////////////

float64 GfxTestApp::testWriteRAM()
{
  sint32  reps          = 0;
  float64  totTime        = 0.0;

  while  (totTime < SAMPLETIME)
  {
    sprintf(text, "RAM Write Test %.2f ms", totTime);
    appDisplay->setTitle(text);
    lockKernel();
    timer.set();
    Mem::set(testData, (uint8)reps, testDataSize);
    totTime += timer.elapsedFrac();
    unlockKernel();
    reps++;
  }
  return ((float64)testDataSize*1000*reps)/(totTime*1024.0);
}

////////////////////////////////////////////////////////////////////////////////

float64 GfxTestApp::testWrite16RAM()
{
  sint32  reps          = 0;
  float64  totTime        = 0.0;
  while  (totTime < SAMPLETIME)
  {
    sprintf(text, "RAM Write (move16) Test %.2f ms", totTime);
    appDisplay->setTitle(text);
    lockKernel();
    timer.set();
    setMem16(testData, (uint8)reps, testDataSize);
    totTime += timer.elapsedFrac();
    unlockKernel();
    reps++;
  }
  return ((float64)testDataSize*1000*reps)/(totTime*1024.0);
}

////////////////////////////////////////////////////////////////////////////////

float64 GfxTestApp::testCLibWriteRAM()
{
  sint32  reps          = 0;
  float64  totTime        = 0.0;

  while  (totTime < SAMPLETIME)
  {
    sprintf(text, "RAM Write (memset) Test %.2f ms", totTime);
    appDisplay->setTitle(text);
    lockKernel();
    timer.set();
    memset(testData, (int)reps, testDataSize);
    totTime += timer.elapsedFrac();
    unlockKernel();
    reps++;
  }
  return ((float64)testDataSize*1000*reps)/(totTime*1024.0);
}

////////////////////////////////////////////////////////////////////////////////

float64 GfxTestApp::testReadRAM()
{
  sint32  reps          = 0;
  float64  totTime        = 0.0;

  while (totTime < SAMPLETIME)
  {
    sprintf(text, "RAM Read Test %.2f ms", totTime);
    appDisplay->setTitle(text);
    lockKernel();
    timer.set();
    readMem(testData, testDataSize);
    totTime += timer.elapsedFrac();
    unlockKernel();
    reps++;
  }
  return ((float64)testDataSize*1000*reps)/(totTime*1024.0);
}

////////////////////////////////////////////////////////////////////////////////

float64 GfxTestApp::testConversion()
{
  sint32    reps    = 0;
  Surface*  surf = appDisplay->getDrawSurface();
  uint32    m = surf->getModulus();
  _Nat2D::PixConv conv = getConversion(surf->getFormat(), testDataFormat);
  float64    totTime = 0.0;
  while (totTime<SAMPLETIME)
  {
    sprintf(text, "Testing conversion %.2f ms", totTime);
    appDisplay->setTitle(text);
    void* d = surf->lockData();
    if (d)
    {
      float64 lockTime = 0.0;
      while (lockTime<MAXLOCKTIME)
      {
        lockKernel();
        timer.set();
        conv(d, testData, 0, width, height, width+m, width);
        lockTime += timer.elapsedFrac();
        unlockKernel();
        reps++;
      }
      totTime += lockTime;
      surf->unlockData();
    }
    appDisplay->refresh();
  }
  PixelDescriptor*  pd  = surf->getDescriptor();
  float64 res = ((float64)(pd->getSize()*width*height)*1000*reps)/(totTime*1024.0);
  if (SystemLib::dialogueBox("Info", "Yes|No", "Any glitches?"))
    return -res;
  return res;
}

////////////////////////////////////////////////////////////////////////////////

float64 readVSpeed;
float64 writeVSpeed;
float64 write16VSpeed;
float64 writeCVSpeed;
float64 copyR2VSpeed;
float64 copy16R2VSpeed;
float64 copyCR2VSpeed;
float64 copyOS_0R2VSpeed;
float64 copyOS_2R2VSpeed;
float64 copyOS_4R2VSpeed;
float64 copyOS_6R2VSpeed;
float64 copyOS_8R2VSpeed;
float64 copyOS_0R2RSpeed;
float64 copyOS_2R2RSpeed;
float64 copyOS_4R2RSpeed;
float64 copyOS_6R2RSpeed;
float64 copyOS_8R2RSpeed;
float64 shuffle16_0R2VSpeed;
float64 shuffle16_2R2VSpeed;
float64 shuffle16_4R2VSpeed;
float64 shuffle16_6R2VSpeed;
float64 shuffle16_8R2VSpeed;
float64 shuffle16_0R2RSpeed;
float64 shuffle16_2R2RSpeed;
float64 shuffle16_4R2RSpeed;
float64 shuffle16_6R2RSpeed;
float64 shuffle16_8R2RSpeed;
float64 copyV2RSpeed;
float64 copy16V2RSpeed;
float64 convSpeed;
float64 readRSpeed;
float64 writeRSpeed;
float64 write16RSpeed;
float64 writeCRSpeed;
float64 copyR2RSpeed;
float64 copy16R2RSpeed;
float64 copyOSR2RSpeed;
float64 copyCR2RSpeed;

sint32 GfxTestApp::runApplication()
{
  if (Surface* surf = appDisplay->getDrawSurface())
  {
    printf("Surface width: %ld, height: %ld, modulus: %ld\n\n", width, height,
           surf->getModulus());
    printf("Surface hwWidth: %ld, hwHeight: %ld\n", surf->getHWWidth(), surf->getHWHeight());
    printf("Test data pixel format\n");
    dumpPixelInfo(PixelDescriptor::get(testDataFormat));
    printf("Window pixel format\n");
    dumpPixelInfo(PixelDescriptor::get(surf->getFormat()));
    if (useLock)
      printf("Locking enabled. No task switches or interrupts during iterations.\n");
    if (move16Tests)
      printf("68040/060 detected. MOVE16 based tests will be performed.\n");

    surf->clear(0x00000000);
    appDisplay->refresh();
    readVSpeed = testReadVRAM();

    surf->clear(0x00000000);
    appDisplay->refresh();
    writeVSpeed = testWriteVRAM();

    if (move16Tests) {
      surf->clear(0x00000000);
      appDisplay->refresh();
      write16VSpeed = testWrite16VRAM();
    }

    surf->clear(0x00000000);
    appDisplay->refresh();
    writeCVSpeed = testCLibWriteVRAM();

    surf->clear(0x00000000);
    appDisplay->refresh();
    copyR2VSpeed = testCopyRAM2VRAM();

    if (move16Tests) {
      surf->clear(0x00000000);
      appDisplay->refresh();
      copy16R2VSpeed = testCopy16RAM2VRAM();
    }

    surf->clear(0x00000000);
    appDisplay->refresh();
    copyCR2VSpeed = testCLibCopyRAM2VRAM();

    surf->clear(0x00000000);
    copyOS_0R2VSpeed = testOSCopyMemRAM2VRAM(0);
    copyOS_2R2VSpeed = testOSCopyMemRAM2VRAM(2);
    copyOS_4R2VSpeed = testOSCopyMemRAM2VRAM(4);
    copyOS_6R2VSpeed = testOSCopyMemRAM2VRAM(6);
    copyOS_8R2VSpeed = testOSCopyMemRAM2VRAM(8);

    if (move16Tests) {
      surf->clear(0x00000000);
      shuffle16_0R2VSpeed = testShuffleCopy16RAM2VRAM(0);
      shuffle16_2R2VSpeed = testShuffleCopy16RAM2VRAM(2);
      shuffle16_4R2VSpeed = testShuffleCopy16RAM2VRAM(4);
      shuffle16_6R2VSpeed = testShuffleCopy16RAM2VRAM(6);
      shuffle16_8R2VSpeed = testShuffleCopy16RAM2VRAM(8);
    }

    surf->clear(0x00000000);
    appDisplay->refresh();
    copyV2RSpeed      = testCopyVRAM2RAM();
    if (move16Tests)
      copy16V2RSpeed  = testCopy16VRAM2RAM();
    convSpeed          = testConversion();

    // ram to ram
    readRSpeed          = testReadRAM();
    writeRSpeed          = testWriteRAM();
    writeCRSpeed        = testCLibWriteRAM();
    copyR2RSpeed        = testCopyRAM2RAM();
    copyCR2RSpeed        = testCLibCopyRAM2RAM();
    copyOS_0R2RSpeed = testOSCopyMemRAM2RAM(0);
    copyOS_2R2RSpeed = testOSCopyMemRAM2RAM(2);
    copyOS_4R2RSpeed = testOSCopyMemRAM2RAM(4);
    copyOS_6R2RSpeed = testOSCopyMemRAM2RAM(6);
    copyOS_8R2RSpeed = testOSCopyMemRAM2RAM(8);

    if (move16Tests) {
      write16RSpeed    = testWrite16RAM();
      copy16R2RSpeed  = testCopy16RAM2RAM();
      shuffle16_0R2RSpeed = testShuffleCopy16RAM2RAM(0);
      shuffle16_2R2RSpeed = testShuffleCopy16RAM2RAM(2);
      shuffle16_4R2RSpeed = testShuffleCopy16RAM2RAM(4);
      shuffle16_6R2RSpeed = testShuffleCopy16RAM2RAM(6);
      shuffle16_8R2RSpeed = testShuffleCopy16RAM2RAM(8);
    }


    float64 convPixPerSec      = 1024.0*convSpeed/(PixelDescriptor::get(surf->getFormat())->getSize());

    // RAM <-> RAM
    printf("Results (negative value indicates glitches were observed\n\n");
    printf("Read RAM      : %7.2f K/sec\n", readRSpeed);
    printf("Write RAM     : %7.2f K/sec\n", writeRSpeed);
    printf("Write RAM(C)  : %7.2f K/sec\n", writeCRSpeed);
    if (move16Tests)
      printf("Write RAM(16) : %7.2f K/sec\n", write16RSpeed);
    else
      printf("Write RAM(16) : N/A\n");
    printf("RAM->RAM      : %7.2f K/sec\n", copyR2RSpeed);
    printf("RAM->RAM(C)   : %7.2f K/sec\n", copyCR2RSpeed);
    printf("RAM->RAM(OS:0): %7.2f K/sec\n", copyOS_0R2RSpeed);
    printf("RAM->RAM(OS:2): %7.2f K/sec\n", copyOS_2R2RSpeed);
    printf("RAM->RAM(OS:4): %7.2f K/sec\n", copyOS_4R2RSpeed);
    printf("RAM->RAM(OS:6): %7.2f K/sec\n", copyOS_6R2RSpeed);
    printf("RAM->RAM(OS:8): %7.2f K/sec\n", copyOS_8R2RSpeed);

    if (move16Tests) {
      printf("RAM->RAM(16)  : %7.2f K/sec\n", copy16R2RSpeed);
      printf("RAM->RAM(16:0): %7.2f K/sec\n", shuffle16_0R2RSpeed);
      printf("RAM->RAM(16:2): %7.2f K/sec\n", shuffle16_2R2RSpeed);
      printf("RAM->RAM(16:4): %7.2f K/sec\n", shuffle16_4R2RSpeed);
      printf("RAM->RAM(16:6): %7.2f K/sec\n", shuffle16_6R2RSpeed);
      printf("RAM->RAM(16:8): %7.2f K/sec\n", shuffle16_8R2RSpeed);

    }
    printf("\n-------------------------------\n\n");

    // RAM -> VRAM
    printf("Read VRAM     : %7.2f K/sec\n", readVSpeed);
    printf("Write VRAM    : %7.2f K/sec\n", writeVSpeed);
    printf("Write VRAM(C) : %7.2f K/sec\n", writeCVSpeed);
    if (move16Tests) {
      printf("Write VRAM(16): %7.2f K/sec\n", write16VSpeed);
    }
    printf("RAM->VRAM      : %7.2f K/sec\n", copyR2VSpeed);
    printf("RAM->VRAM(C)   : %7.2f K/sec\n", copyCR2VSpeed);
    printf("RAM->VRAM(OS:0): %7.2f K/sec\n", copyOS_0R2RSpeed);
    printf("RAM->VRAM(OS:2): %7.2f K/sec\n", copyOS_2R2RSpeed);
    printf("RAM->VRAM(OS:4): %7.2f K/sec\n", copyOS_4R2RSpeed);
    printf("RAM->VRAM(OS:6): %7.2f K/sec\n", copyOS_6R2RSpeed);
    printf("RAM->VRAM(OS:8): %7.2f K/sec\n", copyOS_8R2RSpeed);

    if (move16Tests) {
      printf("RAM->VRAM(16)  : %7.2f K/sec\n", copy16R2VSpeed);
      printf("RAM->VRAM(16:0): %7.2f K/sec\n", shuffle16_0R2VSpeed);
      printf("RAM->VRAM(16:2): %7.2f K/sec\n", shuffle16_2R2VSpeed);
      printf("RAM->VRAM(16:4): %7.2f K/sec\n", shuffle16_4R2VSpeed);
      printf("RAM->VRAM(16:6): %7.2f K/sec\n", shuffle16_6R2VSpeed);
      printf("RAM->VRAM(16:8): %7.2f K/sec\n", shuffle16_8R2VSpeed);
    }
    printf("\n-------------------------------\n\n");

    // VRAM -> RAM
    printf("VRAM->RAM     : %7.2f K/sec\n", copyV2RSpeed);
    if (move16Tests)
      printf("VRAM->RAM(16) : %7.2f K/sec\n", copy16V2RSpeed);

    printf("\n-------------------------------\n\n");

    // conversion
    printf("Conversion    : %7.2f K/sec [output bandwidth]\n", convSpeed);
    printf("Conversion    : %7.2f pix/sec\n", convPixPerSec);

    printf("\nConversion attained %7.2f%% copy speed\n",
           (100.0*convSpeed/copyR2VSpeed));
  }
  Thread::sleep(500);
  appDisplay->close();

  return 0;
}

////////////////////////////////////////////////////////////////////////////////

