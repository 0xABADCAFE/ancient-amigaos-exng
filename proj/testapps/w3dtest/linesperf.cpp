//****************************************************************************//
//**                                                                        **//
//** File:         proj/W3DTest/linesperf.cpp                               **//
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
//
//  Auxilliary functions
//
////////////////////////////////////////////////////////////////////////////////

static sint32 calcLinesLinFFF(GenericVertex* v, sint16 w, sint16 h, sint16 xDim, sint16 yDim)
{
  {
    rfloat32 step = ((float32)w)/((float32)xDim);
    rfloat32 x = 0.5;
    for (rsint32 i=0; i<xDim; i++, x+=step)
    {
      v->crd.fff.x = x;
      v->crd.fff.y = 0.5;
      v->crd.fff.z = ((float32)i)/((float32)xDim);
      v++;
      v->crd.fff.x = ((float32)w)-x;
      v->crd.fff.y = ((float32)h);
      v->crd.fff.z = ((float32)(xDim-i))/((float32)xDim);
      v++;
    }
  }
  {
    rfloat32 step = ((float32)h)/((float32)yDim);
    rfloat32 y = 0.5;
    for (rsint32 i=0; i<yDim; i++, y+=step)
    {
      v->crd.fff.x = ((float32)w)-0.5;
      v->crd.fff.y = y;
      v->crd.fff.z = ((float32)i)/((float32)yDim);
      v++;
      v->crd.fff.x = 0.5;
      v->crd.fff.y = ((float32)h)-y;
      v->crd.fff.z = ((float32)(yDim-i))/((float32)yDim);
      v++;
    }
  }
  return (xDim+yDim)*2; // number of vertices
}

////////////////////////////////////////////////////////////////////////////////

static sint32 calcLinesLinFFD(GenericVertex* v, sint16 w, sint16 h, sint16 xDim, sint16 yDim)
{
  {
    rfloat32 step = ((float32)w)/((float32)xDim);
    rfloat32 x = 0.5;
    for (rsint32 i=0; i<xDim; i++, x+=step)
    {
      v->crd.ffd.x = x;
      v->crd.ffd.y = 0.5;
      v->crd.ffd.z = ((float64)i)/((float64)xDim);
      v++;
      v->crd.ffd.x = ((float32)w)-x;
      v->crd.ffd.y = ((float32)h);
      v->crd.ffd.z = ((float64)(xDim-i))/((float64)xDim);
      v++;
    }
  }
  {
    rfloat32 step = ((float32)h)/((float32)yDim);
    rfloat32 y = 0.5;
    for (rsint32 i=0; i<yDim; i++, y+=step)
    {
      v->crd.ffd.x = ((float32)w)-0.5;
      v->crd.ffd.y = y;
      v->crd.ffd.z = ((float64)i)/((float64)yDim);
      v++;
      v->crd.ffd.x = 0.5;
      v->crd.ffd.y = ((float32)h)-y;
      v->crd.ffd.z = ((float64)(yDim-i))/((float64)yDim);
      v++;
    }
  }
  return (xDim+yDim)*2; // number of vertices
}

////////////////////////////////////////////////////////////////////////////////

static sint32 calcLinesLinDDD(GenericVertex* v, sint16 w, sint16 h, sint16 xDim, sint16 yDim)
{
  {
    rfloat64 step = ((float64)w)/((float64)xDim);
    rfloat64 x = 0.5;
    for (rsint32 i=0; i<xDim; i++, x+=step)
    {
      v->crd.ddd.x = x;
      v->crd.ddd.y = 0.5;
      v->crd.ddd.z = ((float64)i)/((float64)xDim);
      v++;
      v->crd.ddd.x = ((float64)w)-x;
      v->crd.ddd.y = ((float64)h);
      v->crd.ddd.z = ((float64)(xDim-i))/((float64)xDim);
      v++;
    }
  }
  {
    rfloat64 step = ((float64)h)/((float64)yDim);
    rfloat64 y = 0.5;
    for (rsint32 i=0; i<yDim; i++, y+=step)
    {
      v->crd.ddd.x = ((float64)w)-0.5;
      v->crd.ddd.y = y;
      v->crd.ddd.z = ((float64)i)/((float64)yDim);
      v++;
      v->crd.ddd.x = 0.5;
      v->crd.ddd.y = ((float64)h)-y;
      v->crd.ddd.z = ((float64)(yDim-i))/((float64)yDim);
      v++;
    }
  }
  return (xDim+yDim)*2; // number of vertices
}

////////////////////////////////////////////////////////////////////////////////

static sint32 calcLinesLinUARGB(GenericVertex* v, sint16 xDim, sint16 yDim)
{
  {
    for (rsint32 i=0; i<xDim; i++)
    {
      v->clr.uargb.a = ((256*rand())/RAND_MAX);
      v->clr.uargb.r = ((256*rand())/RAND_MAX);
      v->clr.uargb.g = ((256*rand())/RAND_MAX);
      v->clr.uargb.b = ((256*rand())/RAND_MAX);
      v++;
      v->clr.uargb.a = 0;
      v->clr.uargb.r = 0;
      v->clr.uargb.g = 0;
      v->clr.uargb.b = 0;
      v++;
    }
  }
  {
    for (rsint32 i=0; i<yDim; i++)
    {
      v->clr.uargb.a = ((256*rand())/RAND_MAX);
      v->clr.uargb.r = ((256*rand())/RAND_MAX);
      v->clr.uargb.g = ((256*rand())/RAND_MAX);
      v->clr.uargb.b = ((256*rand())/RAND_MAX);
      v++;
      v->clr.uargb.a = 255;
      v->clr.uargb.r = 255;
      v->clr.uargb.g = 255;
      v->clr.uargb.b = 255;
      v++;
    }
  }
  return (xDim+yDim)*2; // number of vertices
}

////////////////////////////////////////////////////////////////////////////////

static sint32 calcLinesLinFARGB(GenericVertex* v, sint16 xDim, sint16 yDim)
{
  {
    for (rsint32 i=0; i<xDim; i++)
    {
      v->clr.fargb.a = (((float32)rand())/((float32)RAND_MAX));
      v->clr.fargb.r = (((float32)rand())/((float32)RAND_MAX));
      v->clr.fargb.g = (((float32)rand())/((float32)RAND_MAX));
      v->clr.fargb.b = (((float32)rand())/((float32)RAND_MAX));
      v++;
      v->clr.fargb.a = 0;
      v->clr.fargb.r = 0;
      v->clr.fargb.g = 0;
      v->clr.fargb.b = 0;
      v++;
    }
  }
  {
    for (rsint32 i=0; i<yDim; i++)
    {
      v->clr.fargb.a = (((float32)rand())/((float32)RAND_MAX));
      v->clr.fargb.r = (((float32)rand())/((float32)RAND_MAX));
      v->clr.fargb.g = (((float32)rand())/((float32)RAND_MAX));
      v->clr.fargb.b = (((float32)rand())/((float32)RAND_MAX));
      v++;
      v->clr.fargb.a = MAX_F;
      v->clr.fargb.r = MAX_F;
      v->clr.fargb.g = MAX_F;
      v->clr.fargb.b = MAX_F;
      v++;
    }
  }
  return (xDim+yDim)*2; // number of vertices
}

////////////////////////////////////////////////////////////////////////////////
//
//  Types
//
////////////////////////////////////////////////////////////////////////////////

typedef sint32 (*VFunc)(GenericVertex* v, sint16 w, sint16 h, sint16 xDim, sint16 yDim);
typedef sint32 (*CFunc)(GenericVertex* v, sint16 xDim, sint16 yDim);

struct VTest {
  GenericVertex::VFormat format;
  const char* name;
  VFunc fn;
};

struct CTest {
  GenericVertex::CFormat format;
  const char* name;
  CFunc fn;
};

////////////////////////////////////////////////////////////////////////////////
//
//  Tables
//
////////////////////////////////////////////////////////////////////////////////

static VTest vTestTab[] = {
  { GenericVertex::XYZ_FFF,  "FFF",  calcLinesLinFFF },
  { GenericVertex::XYZ_FFD,  "FFD",  calcLinesLinFFD },
  { GenericVertex::XYZ_DDD,  "DDD",  calcLinesLinDDD },
};

static CTest cTestTab[] = {
  { GenericVertex::CLR_URGB,  "RGB_U ",  calcLinesLinUARGB },
  { GenericVertex::CLR_UBGR,  "BGR_U ",  0 },
  { GenericVertex::CLR_URGBA,  "RGBA_U",  0 },
  { GenericVertex::CLR_UARGB,  "ARGB_U",  0 },
  { GenericVertex::CLR_UBGRA,  "BGRA_U",  0 },
  { GenericVertex::CLR_FRGB,  "RGB_F ",  calcLinesLinFARGB },
  { GenericVertex::CLR_FBGR,  "BGR_F ",  0 },
  { GenericVertex::CLR_FRGBA,  "RGBA_F",  0 },
  { GenericVertex::CLR_FARGB,  "ARGB_F",  0 },
  { GenericVertex::CLR_FBGRA,  "BGRA_F",  0 },
};

////////////////////////////////////////////////////////////////////////////////
//
//  Strings
//
////////////////////////////////////////////////////////////////////////////////

static const char* titleLines = "Warp3D Test : Line Render %lu [%s:%s]";
//static const char* titleLStrip = "Warp3D Test : Line Strip Render %lu [%s:%s]";
//static const char* titleLLoop = "Warp3D Test : Line Loop Render %lu [%s:%s]";
static const char* logTx = "Colour Format %s       : %6ld lines/s\n";

////////////////////////////////////////////////////////////////////////////////
//
//  Application methods
//
////////////////////////////////////////////////////////////////////////////////

// Renders numVerts/2 distinct lines

void TestWarp3D::measureLinesLinear()
{
  if (!(check & CH_ARRAY_LINES))
    return;

  appWindow->setTitle("Warp3D Test : Line Render Test");
  clear();

  logFile->writeText("\n\nLine Render [Array Linear] ");
  if (!SystemLib::dialogueBox(dBoxInfo, dBoxRunSkip,
    "Line Render Test\n\n"
    "TestW3D will estimate the speed at which lines can be\n"
    "rendered using vertex array methods on your configuration.\n"
    "The line test will iterate through each vertex and colour\n"
    "format. Only the average performance for shaded versus\n"
    "unshaded lines will be reported, but each individual result\n"
    "will be recorded in the logfile."
  ))
  {
    logFile->writeText(qTestSkip);
    return;
  }

  float64 unshaded      = 0;
  float64 shaded        = 0;
  float64 totTime;
  float64 lockTime;
  float64 testTime      = minTestTime;
  sint32  unshadedReps  = 0;
  sint32  shadedReps    = 0;

  gfx->disable(G3D::TEXTURE);
  gfx->disable(G3D::BLENDING);

  GenericVertex* gVert = (GenericVertex*)data;

  for (sint32 v=0; v<GenericVertex::_XYZ_NUM; v++)
  {
    if ((check & (1<<(v+CH_VERTEX_SHIFT)))==0)
    {
      // User test failed support of this colour format
      continue;
    }
    setArray(gVert, vTestTab[v].format);
    sint32  numVerts = vTestTab[v].fn(gVert, width, height, width, height);

    logFile->writeText(
      "\n\nVertex Format : %s ----------------------------------\n",
      vTestTab[v].name);

    // Unshaded
    {
      gfx->disable(G3D::GOURAUD);

      // preview
      gfx->lock();
      W3D_DrawArray(getRasterizerContext(gfx), W3D_PRIMITIVE_LINES, 0, numVerts);
      gfx->unlock();
      appWindow->refresh();

      totTime  = 0;
      sint32  reps    = 0;
      while (totTime<testTime)
      {
        sprintf(info, titleLines, (uint32)totTime, vTestTab[v].name, "Flat");
        appWindow->setTitle(info);

        lockTime = 0;
        gfx->lock();
        while (lockTime<MAX_LOCKTIME)
        {
          timer.set();
          W3D_DrawArray(getRasterizerContext(gfx), W3D_PRIMITIVE_LINES, 0, numVerts);
          lockTime += timer.elapsedFrac();
          reps++;
        }
        gfx->unlock();
        totTime += lockTime;
      }

      sprintf(info, titleLines, (uint32)totTime, vTestTab[v].name, "Flat");
      appWindow->setTitle(info);

      float64  linesPerSec = ((1000.0/2.0)*reps*numVerts)/(totTime);
      logFile->writeText(logTx, "[Flat]", (sint32)linesPerSec);
      unshaded += linesPerSec;
      unshadedReps++;
    }

    // Shaded
    {
      gfx->enable(G3D::GOURAUD);
      for (sint32 c=0; c<GenericVertex::_CLR_NUM; c++)
      {
        if ((check & (1<<(c+CH_COLOUR_SHIFT)))==0)
        {
          if (cTestTab[c].fn)
            cTestTab[c].fn(gVert, width, height);
          // User test failed support of this colour format
          continue;
        }
        setArray(gVert, vTestTab[v].format, cTestTab[c].format);

        if (cTestTab[c].fn)
          cTestTab[c].fn(gVert, width, height);

        // preview
        gfx->lock();
        W3D_DrawArray(getRasterizerContext(gfx), W3D_PRIMITIVE_LINES, 0, numVerts);
        gfx->unlock();
        appWindow->refresh();

        totTime  = 0;
        sint32  reps    = 0;
        while (totTime<testTime)
        {
          sprintf(info, titleLines, (uint32)totTime, vTestTab[v].name, cTestTab[c].name);
          appWindow->setTitle(info);

          lockTime = 0;
          gfx->lock();
          while (lockTime<MAX_LOCKTIME)
          {
            timer.set();
            W3D_DrawArray(getRasterizerContext(gfx), W3D_PRIMITIVE_LINES, 0, numVerts);
            lockTime += timer.elapsedFrac();
            reps++;
          }
          gfx->unlock();
          totTime += lockTime;
        }

        sprintf(info, titleLines, (uint32)totTime, vTestTab[v].name, cTestTab[c].name);
        appWindow->setTitle(info);

        float64  linesPerSec = ((1000.0/2.0)*reps*numVerts)/(totTime);
        logFile->writeText(logTx, cTestTab[c].name, (sint32)linesPerSec);
        shaded += linesPerSec;
        shadedReps++;
      }
    }
  }
  unshaded /= (float64)unshadedReps;
  shaded /= (float64)shadedReps;
  SystemLib::dialogueBox(dBoxInfo, dBoxProceed,
    "Render Lines (Linear)\n\n"
    "Average unshaded : %6.2f lines/s\n"
    "Average shaded : %6.2f lines/s",
    unshaded, shaded
  );
}

////////////////////////////////////////////////////////////////////////////////

// Renders numVerts-1 joined lines

void TestWarp3D::measureLineStripLinear()
{
  if (!(check & CH_ARRAY_LSTRIP))
    return;

  appWindow->setTitle("Warp3D Test : Line Strip Render Test");
  clear();

  logFile->writeText("\n\nLine Strip Render [Array Linear] ");
  if (!SystemLib::dialogueBox(dBoxInfo, dBoxRunSkip,
    "Line Strip Render Test\n\n"
    "TestW3D will estimate the speed at which line strips can be\n"
    "rendered using vertex array methods on your configuration.\n"
    "The line strip test will iterate through each vertex and colour\n"
    "format. Only the average performance for shaded versus\n"
    "unshaded lines will be reported, but each individual result\n"
    "will be recorded in the logfile."
  ))
  {
    logFile->writeText(qTestSkip);
    return;
  }

  float64 unshaded      = 0;
  float64 shaded        = 0;
  float64 totTime;
  float64 lockTime;
  float64 testTime      = minTestTime;
  sint32  unshadedReps  = 0;
  sint32  shadedReps    = 0;

  gfx->disable(G3D::TEXTURE);
  gfx->disable(G3D::BLENDING);

  GenericVertex* gVert = (GenericVertex*)data;

  for (sint32 v=0; v<GenericVertex::_XYZ_NUM; v++)
  {
    if ((check & (1<<(v+CH_VERTEX_SHIFT)))==0)
    {
      // User test failed support of this colour format
      continue;
    }
    setArray(gVert, vTestTab[v].format);
    sint32  numVerts = vTestTab[v].fn(gVert, width, height, width, height);

    logFile->writeText(
      "\n\nVertex Format : %s ----------------------------------\n",
      vTestTab[v].name);

    // Unshaded
    {
      gfx->disable(G3D::GOURAUD);

      // preview
      gfx->lock();
      W3D_DrawArray(getRasterizerContext(gfx), W3D_PRIMITIVE_LINESTRIP, 0, numVerts);
      gfx->unlock();
      appWindow->refresh();

      totTime  = 0;
      sint32  reps = 0;
      while (totTime<testTime)
      {
        sprintf(info, titleLines, (uint32)totTime, vTestTab[v].name, "Flat");
        appWindow->setTitle(info);

        lockTime = 0;
        gfx->lock();
        while (lockTime<MAX_LOCKTIME)
        {
          timer.set();
          W3D_DrawArray(getRasterizerContext(gfx), W3D_PRIMITIVE_LINESTRIP, 0, numVerts);
          lockTime += timer.elapsedFrac();
          reps++;
        }
        gfx->unlock();
        totTime += lockTime;
      }

      sprintf(info, titleLines, (uint32)totTime, vTestTab[v].name, "Flat");
      appWindow->setTitle(info);

      float64  linesPerSec = (1000.0*reps*(numVerts-1))/(totTime);
      logFile->writeText(logTx, "[Flat]", (sint32)linesPerSec);
      unshaded += linesPerSec;
      unshadedReps++;
    }

    // Shaded
    {
      gfx->enable(G3D::GOURAUD);
      for (sint32 c=0; c<GenericVertex::_CLR_NUM; c++)
      {
        if ((check & (1<<(c+CH_COLOUR_SHIFT)))==0)
        {
          if (cTestTab[c].fn)
            cTestTab[c].fn(gVert, width, height);
          // User test failed support of this colour format
          continue;
        }
        setArray(gVert, vTestTab[v].format, cTestTab[c].format);

        if (cTestTab[c].fn)
          cTestTab[c].fn(gVert, width, height);

        // preview
        gfx->lock();
        W3D_DrawArray(getRasterizerContext(gfx), W3D_PRIMITIVE_LINESTRIP, 0, numVerts);
        gfx->unlock();
        appWindow->refresh();

        totTime  = 0;
        sint32  reps    = 0;
        while (totTime<testTime)
        {
          sprintf(info, titleLines, (uint32)totTime, vTestTab[v].name, cTestTab[c].name);
          appWindow->setTitle(info);

          lockTime = 0;
          gfx->lock();
          while (lockTime<MAX_LOCKTIME)
          {
            timer.set();
            W3D_DrawArray(getRasterizerContext(gfx), W3D_PRIMITIVE_LINESTRIP, 0, numVerts);
            lockTime += timer.elapsedFrac();
            reps++;
          }
          gfx->unlock();
          totTime += lockTime;
        }

        sprintf(info, titleLines, (uint32)totTime, vTestTab[v].name, cTestTab[c].name);
        appWindow->setTitle(info);

        float64  linesPerSec = (1000.0*reps*(numVerts-1))/(totTime);
        logFile->writeText(logTx, cTestTab[c].name, (sint32)linesPerSec);
        shaded += linesPerSec;
        shadedReps++;
      }
    }
  }
  unshaded /= (float64)unshadedReps;
  shaded /= (float64)shadedReps;
  SystemLib::dialogueBox(dBoxInfo, dBoxProceed,
    "Render Line Strip (Linear)\n\n"
    "Average unshaded : %6.2f lines/s\n"
    "Average shaded : %6.2f lines/s",
    unshaded, shaded
  );
}
