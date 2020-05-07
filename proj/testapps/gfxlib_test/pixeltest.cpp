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
//** Copyright:    (C)1996-2004, eXtropia Studios                           **//
//**               Serkan YAZICI, Karl Churchill                            **//
//**                                                                        **//
//**               All Rights Reserved.                                     **//
//**                                                                        **//
//****************************************************************************//


#include <xbase.hpp>
#include <systemlib/timer.hpp>
#include <systemlib/thread.hpp>
#include <gfxlib/gfx.hpp>

extern "C" {
  #include <string.h>
}

////////////////////////////////////////////////////////////////////////////////

class GfxTestApp : public AppBase, Native2D {
  private:
    Display*        appDisplay;
    char*            text;
    MilliClock      timer;
    sint32          width;
    sint32          height;
    Pixel::HWType    testDataFormat;
    void*            testData;

    sint32          createTestData();
    uint32          testBusZero();
    uint32          testBusSet();
    uint32          testBusCopy();
    uint32          testConversion();
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
  return new GfxTestApp;
}

void AppBase::destroyApplicationInstance(AppBase* app)
{
  delete app;
}

////////////////////////////////////////////////////////////////////////////////

GfxTestApp::GfxTestApp() : appDisplay(0)
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
  if (getSwitch("fullscreen", false)==true)
  {
    appDisplay = new DisplayScreen();
  }
  else
  {
    appDisplay  = new DisplayWindow();
  }
}

GfxTestApp::~GfxTestApp()
{
  delete appDisplay;
  delete[] text;
  if (testData)
    Mem::free(testData);
}

////////////////////////////////////////////////////////////////////////////////

sint32 GfxTestApp::initApplication()
{
  if (!appDisplay || (appDisplay->open(width, height, Pixel::BPP15, "EXNG Gfx test")!=OK))
    return ERR_RSC_UNAVAILABLE;

  const char*  s  = getString("fmt", false);
  if (s)
  {
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
  //  Use floating point for calcs to get best results

  // Get the pixel properties for the requested data format

  PixelDescriptor* pxl = PixelDescriptor::get(testDataFormat);

  if (!pxl || pxl->getSize()==1)
    return ERR_VALUE;

  // Get memory
  testData = Mem::alloc(width*height*pxl->getSize(), false, Mem::ALIGN_CACHE);
  if (!testData)
    return ERR_NO_FREE_STORE;

  // Get interpolation steps
  float32 deltaR = (float32)pxl->getMaxRed()/(float32)height;
  float32 deltaG = (float32)pxl->getMaxGreen()/(float32)width;
  float32 deltaB = (float32)pxl->getMaxBlue()/(float32)width;

  // These are offsets for the pixel fields
  uint32  offstR  = pxl->getShiftRed();
  uint32  offstG  = pxl->getShiftGreen();
  uint32  offstB  = pxl->getShiftBlue();

  switch (pxl->getSize())
  {
    case 2: {
      // 15/16-bit pixels
      ruint16*  p = (uint16*)testData;
      rfloat32  valR = 0;
      for (rsint32 y = 0; y<height; y++, valR += deltaR)
      {
        rfloat32 valB  = 0; rfloat32 valG  = pxl->getMaxGreen();
        for(rsint32 x = 0; x<width; x++, valB+=deltaB, valG -= deltaG)
        {
          *p++ = ((uint16)valR)<<offstR | ((uint16)valG)<<offstG | ((uint16)valB)<<offstB;
        }
      }
      if (pxl->isSwapped())
        Mem::swap16(testData, testData, width*height);
      return OK;
    } break;

    case 3: {
      // 24-bit packed pixels, channel offsets are byte indexes
      ruint8*  p = (uint8*)testData;
      rfloat32  valR = 0;
      for (rsint32 y = 0; y<height; y++, valR += deltaR)
      {
        rfloat32 valB  =  0; rfloat32 valG  = pxl->getMaxGreen();
        for(rsint32 x = 0; x<width; x++, valB += deltaB, valG -= deltaG, p+=3)
        {
          p[offstR] = (uint8)valR; p[offstG] = (uint8)valG; p[offstB] = (uint8)valB;
        }
      }
      return OK;
    } break;

    case 4: {
      // 32-bit pixels
      ruint32*  p = (uint32*)testData;
      rfloat32  valR = 0;

      for (rsint32 y = 0; y<height; y++, valR += deltaR)
      {
        rfloat32 valB  = 0; rfloat32 valG  = pxl->getMaxGreen();
        for(rsint32 x = 0; x<width; x++, valB += deltaB, valG -= deltaG)
        {
          *p++ = ((uint32)valR)<<offstR | ((uint32)valG)<<offstG | ((uint32)valB)<<offstB;
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

#define REPS 16

uint32 GfxTestApp::testBusSet()
{
  float64 timeTaken = 0;
  Surface* t = appDisplay->getDrawSurface();
  size_t   totPix = (height*(width+t->getModulus()));

  // We use the Mem:: set() / set16() / set32() methods since these are very
  // high performance and implemented to always write 32-bit data irrespective
  // of operand size. Thus, the bus speed, rather than code efficiency will
  // be the time dominating factor.

  uint32 i;

  switch (PixelDescriptor::get(testDataFormat)->getSize())
  {
    case 2:
      for (i=0; i<REPS; i++) {
        sprintf(text, "Testing bus set %ld / %ld", i, REPS);
        appDisplay->setTitle(text);
        void* d = t->lockData();
        if (d)
        {
          timer.set();
          Mem::set16(d, i, totPix);
          timeTaken += timer.elapsed();
          t->unlockData();
        }
        appDisplay->refresh();
      }

      break;
    case 3:
      for (i=0; i<REPS; i++) {
        sprintf(text, "Testing bus set %ld / %ld", i, REPS);
        appDisplay->setTitle(text);
        void* d = t->lockData();
        size_t tot = totPix*3;
        if (d) {
          timer.set();
          Mem::set(d, i, tot);
          timeTaken += timer.elapsed();
          t->unlockData();
        }
        appDisplay->refresh();
      }
      break;
    case 4:
      for (i=0; i<REPS; i++) {
        sprintf(text, "Testing bus set %ld / %ld", i, REPS);
        appDisplay->setTitle(text);
        void* d = t->lockData();
        if (d) {
          timer.set();
          Mem::set32(d, i, totPix);
          timeTaken += timer.elapsed();
          t->unlockData();
        }
        appDisplay->refresh();
      }
      break;
    default:
      break;
  }
  if (timeTaken > 0.0)
    return (uint32)((((float64)totPix)*1000.0*REPS)/timeTaken);
  return 1;
}

////////////////////////////////////////////////////////////////////////////////

uint32 GfxTestApp::testBusZero()
{
  float64 timeTaken = 0;
  Surface* t = appDisplay->getDrawSurface();
  size_t   totPix = (height*(width+t->getModulus()));

  for (sint32 i=0; i<REPS; i++)
  {
    sprintf(text, "Testing bus clear %ld / %ld", i, REPS);
    appDisplay->setTitle(text);
    void* d = t->lockData();
    size_t tot = totPix*3;
    if (d) {
      timer.set();
      Mem::zero(d, tot);
      timeTaken += timer.elapsed();
      t->unlockData();
    }
    appDisplay->refresh();
  }
  if (timeTaken > 0.0)
    return (uint32)((((float64)totPix)*1000.0*REPS)/timeTaken);
  return 1;
}

////////////////////////////////////////////////////////////////////////////////

uint32 GfxTestApp::testBusCopy()
{
  float64 timeTaken = 0;
  Surface* t = appDisplay->getDrawSurface();
  size_t   totPix = height*width;

  for (sint32 i=0; i<REPS; i++)
  {
    sprintf(text, "Testing bus copy %ld / %ld", i, REPS);
    appDisplay->setTitle(text);
    size_t tot = totPix*PixelDescriptor::get(t->getFormat())->getSize();
    void* d = t->lockData();
    if (d) {
      timer.set();
      Mem::copy(d, testData, tot);
      timeTaken += timer.elapsed();
      t->unlockData();
    }
    appDisplay->refresh();
  }
  if (timeTaken > 0.0)
    return (uint32)((((float64)totPix)*1000.0*REPS)/timeTaken);
  return 1;
}

////////////////////////////////////////////////////////////////////////////////

uint32 GfxTestApp::testConversion()
{
  float64    timeTaken = 0;
  Surface*  t = appDisplay->getDrawSurface();
  uint32    m = t->getModulus();
  Native2D::PixConv conv = getConversion(t->getFormat(), testDataFormat);

  for (uint32 i=0; i<REPS; i++)
  {
    sprintf(text, "Testing conversion %ld / %ld", i, REPS);
    appDisplay->setTitle(text);
    void* d = t->lockData();
    if (d)
    {
      timer.set();
      conv(d, testData, 0, width, height, width+m, width);
      timeTaken += timer.elapsed();
      t->unlockData();
    }
    appDisplay->refresh();
  }
  if (timeTaken > 0.0)
    return (uint32)((((float64)(width*height))*1000.0*REPS)/timeTaken);
  return 1;
}

////////////////////////////////////////////////////////////////////////////////

sint32 GfxTestApp::runApplication()
{
  Surface* t = appDisplay->getDrawSurface();
  if (t)
  {
    printf("Surface width: %d, height: %d, modulus: %d\n\n", width, height,
           t->getModulus());

    printf("Surface hwWidth: %d, hwHeight: %d\n", t->getHWWidth(), t->getHWHeight());

    printf("Test data pixel format\n");
    dumpPixelInfo(PixelDescriptor::get(testDataFormat));
    printf("Window pixel format\n");
    dumpPixelInfo(PixelDescriptor::get(t->getFormat()));

    uint32 setSpeed    = testBusSet();
    uint32 copySpeed  = testBusCopy();
    uint32 clearSpeed  = testBusZero();
    uint32 convSpeed  = testConversion();

    printf("\nSet  : %10lu pix/sec %9.2lf K/sec\n", setSpeed,
           (float64)(setSpeed*sizeof(uint16))/1024.0);

    printf("Zero : %10lu pix/sec %9.2lf K/sec\n", clearSpeed,
           (float64)(clearSpeed*sizeof(uint16))/1024.0);

    printf("Copy : %10lu pix/sec %9.2lf K/sec\n", copySpeed,
           (float64)(copySpeed*sizeof(uint16))/1024.0);

    printf("Conv : %10lu pix/sec %9.2lf K/sec\n", convSpeed,
           (float64)(convSpeed*sizeof(uint16))/1024.0);

    printf("\nConversion attained %7.2lf%% copy speed\n",
           100.0*(float64)convSpeed/(float64)copySpeed);
  }
  Thread::sleep(500);
  appDisplay->close();

  return 0;
}

////////////////////////////////////////////////////////////////////////////////

