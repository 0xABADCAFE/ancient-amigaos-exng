//****************************************************************************//
//**                                                                        **//
//** File:         proj/W3DTest/buffperf.cpp                                **//
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


////////////////////////////////////////////////////////////////////////////////

void TestWarp3D::readMem(void* src, size_t len)
{
  // glue to call old stormc3/phxass asm
  asm(
    "\n/*************************************/\n\n"
    "\tmove.l %0, a0\n"
    "\tmove.l %1, d0\n"
    "\tjsr read__TestWarp3D\n"
    "\n/*************************************/\n\n"
    :                                  // no outputs
    : "g"(src), "g"(len)              // inputs
    : "d0", "d1", "a0", "cc"          // clobbers
  );
}

////////////////////////////////////////////////////////////////////////////////

void TestWarp3D::copyMem16(void *dst, void* src, size_t len)
{
  // glue to call old stormc3/phxass asm
  asm(
    "\n/*************************************/\n\n"
    "\tmove.l %0, a0\n"
    "\tmove.l %1, a1\n"
    "\tmove.l %2, d0\n"
    "\tjsr copy16__TestWarp3D\n"
    "\n/*************************************/\n\n"
    :                                  // no outputs
    : "g"(dst), "g"(src), "g"(len)    // inputs
    : "d0", "d1", "a0", "a1", "cc"    // clobbers
  );
}

////////////////////////////////////////////////////////////////////////////////

void TestWarp3D::setMem16(void *dst, sint32 val, size_t len)
{
  asm(
    "\n/*************************************/\n\n"
    "\tmove.l %0, a0\n"
    "\tmove.l %1, d0\n"
    "\tmove.l %2, d1\n"
    "\tjsr write16__TestWarp3D\n"
    "\n/*************************************/\n\n"
    :                                  // no outputs
    : "g"(dst), "g"(val), "g"(len)    // inputs
    : "d0", "d1", "a0", "a1", "cc"    // clobbers
  );
}

////////////////////////////////////////////////////////////////////////////////
//
//  VRAM bandwidth tests
//
////////////////////////////////////////////////////////////////////////////////

void TestWarp3D::measureVRAMAccess()
{
  appWindow->setTitle("Warp3D Test : Video Ram Bandwidth Test");
  clear();

  if (!SystemLib::dialogueBox(dBoxInfo, dBoxRunSkip,
    "Video Ram Bandwidth Test\n\n"
    "TestW3D will estimate the speed at which data can be\n"
    "written to and read from your graphics cards memory."
  ))
  {
    logFile->writeText("VRAM Access Bandwidth      : %s\n", qTestSkip);
    return;
  }

  Surface* surf = appWindow->getDrawSurface();
  if (!surf->isLinear())
  {
    if (!SystemLib::dialogueBox(dBoxInfo, dBoxRunSkip,
      "Warning\n\n"
      "TestW3D has detected that the graphics area\n"
      "it will use for the test does not appear to be\n"
      "continuous.\n"
      "Running this test is not advised. Proceed\n"
      "anyway?"
      ))
    {
      logFile->writeText("VRAM Access Bandwidth      : User skipped test [Possible non-linear surface]\n");
      return;
    }
  }

  logFile->writeText("VRAM Write Bandwidth       : ");

  float64  totTime        = 0;
  float64  testTime      = 10000.0;

  PixelDescriptor*  pd  = surf->getDescriptor();
  sint32  totBytes      = pd->getSize()*(surf->getH()*(surf->getW() + surf->getModulus()));
  sint32 i=0;
  while  (totTime<testTime)
  {
    sprintf(info, "Warp3D Test : Graphics Write Test %ld", i+1);
    appWindow->setTitle(info);
    void *d = surf->lockData();
    if (d)
    {
      timer.set();
      Mem::set(d, i, totBytes);
      totTime += timer.elapsedFrac();
      surf->unlockData();
      i++;
    }
    else
    {
      SystemLib::dialogueBox(dBoxError, dBoxProceed, "Unable to lock surface");
      break;
    }
    appWindow->refresh();
  }
  writeVRAMSpeed = ((float64)totBytes*1000*i)/(totTime*1024.0);
  logFile->writeText("%6.2f K/s\n", writeVRAMSpeed);

  if(check & CH_MOVE16)
  {
    totTime = 0;
    i = 0;
    logFile->writeText("VRAM Write Bandwidth [16]  : ");
    while  (totTime<testTime)
    {
      sprintf(info, "Warp3D Test : Graphics Write Test [move16] %ld", i+1);
      appWindow->setTitle(info);
      void *d = surf->lockData();
      if (d)
      {
        timer.set();
        setMem16(d, i, totBytes);
        totTime += timer.elapsedFrac();
        surf->unlockData();
        i++;
      }
      else
      {
        SystemLib::dialogueBox(dBoxError, dBoxProceed, "Unable to lock surface");
        break;
      }
      appWindow->refresh();
    }
    writeVRAMSpeed16 = ((float64)totBytes*1000*i)/(totTime*1024.0);
    logFile->writeText("%6.2f K/s\n", writeVRAMSpeed16);
  }
  else
    writeVRAMSpeed16 = 0;

  appWindow->setTitle("Warp3D Test : Graphics Read Test");
  clear();

  logFile->writeText("VRAM Read Bandwidth        : ");

  totTime  = 0;
  i=0;
  while  (totTime<testTime)
  {
    sprintf(info, "Warp3D Test : Graphics Read Test %ld", i+1);
    appWindow->setTitle(info);
    void *d = surf->lockData();
    if (d)
    {
      timer.set();
      readMem(d, totBytes);
      totTime += timer.elapsedFrac();
      surf->unlockData();
      i++;
    }
    else
    {
      SystemLib::dialogueBox(dBoxError, dBoxProceed, "Unable to lock surface");
      break;
    }
  }
  readVRAMSpeed = ((float64)totBytes*1000*i)/(totTime*1024.0);
  logFile->writeText("%6.2f K/s\n", readVRAMSpeed);

  void* testBuffer = Mem::alloc(totBytes+16, false, Mem::ALIGN_CACHE);
  if (testBuffer)
  {
    Mem::set32(testBuffer, 0xFFFF0000, totBytes/4);
    totTime = 0;
    i=0;
    while(totTime<testTime)
    {
      sprintf(info, "Warp3D Test : RAM to VRAM 32-bit %ld", i+1);
      appWindow->setTitle(info);
      void *d = surf->lockData();
      if (d)
      {
        timer.set();
        Mem::copy(d, testBuffer, totBytes);
        totTime += timer.elapsedFrac();
        surf->unlockData();
        i++;
      }
      else
      {
        SystemLib::dialogueBox(dBoxError, dBoxProceed, "Unable to lock surface");
        break;
      }
      appWindow->refresh();
    }
    copyR2VSpeed = (1000.0*totBytes*i)/(totTime*1024.0);

    logFile->writeText("RAM to VRAM                : %6.2f K/s\n", copyR2VSpeed);

    if (check & CH_MOVE16)
    {
      totTime = 0;
      i=0;
      while(totTime<testTime)
      {
        sprintf(info, "Warp3D Test : RAM to VRAM [move16] Test %ld", i+1);
        appWindow->setTitle(info);
        void *d = surf->lockData();
        if (d)
        {
          timer.set();
          copyMem16(d, testBuffer, totBytes);
          totTime += timer.elapsedFrac();
          surf->unlockData();
          i++;
        }
        else
        {
          SystemLib::dialogueBox(dBoxError, dBoxProceed, "Unable to lock surface");
          break;
        }
        appWindow->refresh();
      }
    }
    copyR2VSpeed16 = (1000.0*totBytes*i)/(totTime*1024.0);
    logFile->writeText("RAM to VRAM [16]           : %6.2f K/s\n", copyR2VSpeed16);
    Mem::free(testBuffer);
  }
  else
    copyR2VSpeed16 = 0;

  SystemLib::dialogueBox(dBoxInfo, dBoxProceed,
    "Video RAM Access\n\n"
    "CPU to VRAM 32-bit Write : %6.2f K/s\n"
    "CPU to VRAM line Write : %6.2f K/s\n"
    "VRAM to CPU 32-bit Read : %6.2f K/s\n"
    "Copy RAM to VRAM : %6.2f K/s\n"
    "Copy RAM to VRAM[16] : %6.2f K/s",
    writeVRAMSpeed,
    writeVRAMSpeed16,
    readVRAMSpeed,
    copyR2VSpeed,
    copyR2VSpeed16
  );
}

////////////////////////////////////////////////////////////////////////////////
//
//  ZBuffer bandwidth tests
//
////////////////////////////////////////////////////////////////////////////////

void TestWarp3D::measureZBufAccess()
{
  if (!(check & CH_GOTZBUFFER))
    return;
  appWindow->setTitle("Warp3D Test : Z Buffer Bandwidth Test");
  clear();

  if (!SystemLib::dialogueBox(dBoxInfo, dBoxRunSkip,
    "Z Buffer Bandwidth Test\n\n"
    "TestW3D will estimate the speed at which data can be\n"
    "written to and read from your Z Buffer.\n"
    "As Z Buffer formats change from chip to chip, Warp3D\n"
    "uses a normalized value (from 0.0 to 1.0) to represent\n"
    "Z data. The performance of Z buffer writing thus depends\n"
    "both on the access speed of you graphics memory and the\n"
    "quality of your drivers' conversion routines."
  ))
  {
    logFile->writeText("Z Buffer Access Bandwidth  : %s\n", qTestSkip);
    return;
  }

  logFile->writeText("Z Buffer Write Bandwidth   : ");

  float64    totTime    = 0;
  float64    testTime  = 10000.0;
  float64*  zData      = (float64*)data;
  uint32    totPix    = width*height;
  sint32     i = 0;
  while (totTime<testTime)
  {
    sprintf(info, "Warp3D Test : Z Buffer Write Test %ld", i+1);
    appWindow->setTitle(info);

    // quickly calculate some valid Z data
    {
      rfloat64 z = (float64)i/(i+1.0);
      for (rsint32 x=0; x<width; x++)
        zData[x] = z;
    }
    gfx->lock();
    timer.set();
    for (rsint32 y=0; y<height; y++)
    {
      W3D_WriteZSpan(getRasterizerContext(gfx), 0, y, width, zData, 0);
    }
    totTime += timer.elapsedFrac();
    gfx->unlock();
    i++;
  }

  writeZBufSpeed = ((float64)totPix*1000*i)/(totTime);

  logFile->writeText("%6.2f z-pixels/s\n", writeZBufSpeed);

  appWindow->setTitle("Warp3D Test : Z Buffer Read Test");
  clear();

  logFile->writeText("Z Buffer Read Bandwidth    : ");

  zData    = (float64*)data;
  totTime  = 0;
  i=0;

  while(totTime<testTime)
  {
    sprintf(info, "Warp3D Test : Z Buffer Read Test %ld", i+1);
    appWindow->setTitle(info);
    gfx->lock();
    timer.set();
    for (rsint32 y=0; y<height; y++)
    {
      W3D_ReadZSpan(getRasterizerContext(gfx), 0, y, width, zData);
    }
    totTime += timer.elapsedFrac();
    gfx->unlock();
    i++;
  }
  readZBufSpeed = ((float64)totPix*1000*i)/(totTime);
  logFile->writeText("%6.2f z-pixels/s\n", readZBufSpeed);

  SystemLib::dialogueBox(dBoxInfo, dBoxProceed,
    "Z Buffer Access\n\n"
    "RAM to Z Buffer Write : %6.2f z-pixels/s\n"
    "Z Buffer to RAM Read : %6.2f z-pixels/s",
    writeZBufSpeed,
    readZBufSpeed
  );
}

