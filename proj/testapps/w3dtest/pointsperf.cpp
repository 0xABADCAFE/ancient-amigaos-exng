//****************************************************************************//
//**                                                                        **//
//** File:         proj/W3DTest/pointsperf.cpp                              **//
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

static sint32 calcPointsLinFFF(GenericVertex* v, sint16 w, sint16 h, sint16 xDim, sint16 yDim)
{
  rfloat32 yStep = ((float32)h)/((float32)yDim);
  rfloat32 xStep = ((float32)w)/((float32)xDim);
  rfloat32 y = 0.5f;
  for (rsint32 i=0; i<yDim; i++, y+=yStep)
  {
    rfloat32 x = 0.5f;
    for (rsint32 j=0; j<xDim; j++, x+=xStep)
    {
      v->crd.fff.x = x;
      v->crd.fff.y = y;
      v->crd.fff.z = 0;
      v++;

      v->crd.fff.x = x+0.5*xStep;
      v->crd.fff.y = y+0.5*yStep;
      v->crd.fff.z = 0;
      v++;
    }
  }
  return 2*xDim*yDim; // number of vertices
}

////////////////////////////////////////////////////////////////////////////////

static sint32 calcPointsLinFFD(GenericVertex* v, sint16 w, sint16 h, sint16 xDim, sint16 yDim)
{
  rfloat32 yStep = ((float32)h)/((float32)yDim);
  rfloat32 xStep = ((float32)w)/((float32)xDim);
  rfloat32 y = 0.5f;
  for (rsint32 i=0; i<yDim; i++, y+=yStep)
  {
    rfloat32 x = 0.5f;
    for (rsint32 j=0; j<xDim; j++, x+=xStep)
    {
      v->crd.ffd.x = x;
      v->crd.ffd.y = y;
      v->crd.ffd.z = 0;
      v++;

      v->crd.ffd.x = x+0.5*xStep;
      v->crd.ffd.y = y+0.5*yStep;
      v->crd.ffd.z = 0;
      v++;
    }
  }
  return 2*xDim*yDim; // number of vertices
}

////////////////////////////////////////////////////////////////////////////////

static sint32 calcPointsLinDDD(GenericVertex* v, sint16 w, sint16 h, sint16 xDim, sint16 yDim)
{
  rfloat64 yStep = ((float64)h)/((float64)yDim);
  rfloat64 xStep = ((float64)w)/((float64)xDim);
  rfloat64 y = 0.5;
  for (rsint32 i=0; i<yDim; i++, y+=yStep)
  {
    rfloat64 x = 0.5;
    for (rsint32 j=0; j<xDim; j++, x+=xStep)
    {
      v->crd.ddd.x = x;
      v->crd.ddd.y = y;
      v->crd.ddd.z = 0;
      v++;

      v->crd.ddd.x = x+0.5*xStep;
      v->crd.ddd.y = y+0.5*yStep;
      v->crd.ddd.z = 0;
      v++;
    }
  }
  return 2*xDim*yDim; // number of vertices
}

////////////////////////////////////////////////////////////////////////////////

static sint32 calcPointsLinUARGB(GenericVertex* v, sint16 xDim, sint16 yDim)
{
  rsint32 n = 2*xDim*yDim;
  for (rsint32 i=0; i<n; i++)
  {
    v->clr.uargb.a = ((256*rand())/RAND_MAX);
    v->clr.uargb.r = ((256*rand())/RAND_MAX);
    v->clr.uargb.g = ((256*rand())/RAND_MAX);
    v->clr.uargb.b = ((256*rand())/RAND_MAX);
    v++;
  }
  return n;
}

////////////////////////////////////////////////////////////////////////////////

static sint32 calcPointsLinFARGB(GenericVertex* v, sint16 xDim, sint16 yDim)
{
  rsint32 n = 2*xDim*yDim;
  for (rsint32 i=0; i<n; i++)
  {
    v->clr.fargb.a = (((float32)rand())/((float32)RAND_MAX));
    v->clr.fargb.r = (((float32)rand())/((float32)RAND_MAX));
    v->clr.fargb.g = (((float32)rand())/((float32)RAND_MAX));
    v->clr.fargb.b = (((float32)rand())/((float32)RAND_MAX));
    v++;
  }
  return n;
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
  { GenericVertex::XYZ_FFF,  "FFF",  calcPointsLinFFF },
  { GenericVertex::XYZ_FFD,  "FFD",  calcPointsLinFFD },
  { GenericVertex::XYZ_DDD,  "DDD",  calcPointsLinDDD },
};

static CTest cTestTab[] = {
  { GenericVertex::CLR_URGB,  "RGB_U ",  calcPointsLinUARGB },
  { GenericVertex::CLR_UBGR,  "BGR_U ",  0 },
  { GenericVertex::CLR_URGBA,  "RGBA_U",  0 },
  { GenericVertex::CLR_UARGB,  "ARGB_U",  0 },
  { GenericVertex::CLR_UBGRA,  "BGRA_U",  0 },
  { GenericVertex::CLR_FRGB,  "RGB_F ",  calcPointsLinFARGB  },
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

static const char* title = "Warp3D Test : Point Render %lu [%s:%s]";
static const char* logTx = "Colour Format %s       : %6ld points/s\n";

////////////////////////////////////////////////////////////////////////////////
//
//  Application methods
//
////////////////////////////////////////////////////////////////////////////////

void TestWarp3D::measurePointsLinear()
{
  if (!(check & CH_ARRAY_POINTS))
    return;

  appWindow->setTitle("Warp3D Test : Point Render Test");
  clear();

  logFile->writeText("\n\nPoint Render [Array Linear] ");
  if (!SystemLib::dialogueBox(dBoxInfo, dBoxRunSkip,
    "Point Render Test\n\n"
    "TestW3D will estimate the speed at which points can be\n"
    "rendered using vertex array methods on your configuration.\n"
    "The point test will iterate through each vertex and colour\n"
    "format. Only the average performance for shaded versus\n"
    "unshaded points will be reported, but each individual result\n"
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
      // User test failed support of this vertex format
      continue;
    }
    setArray(gVert, vTestTab[v].format);
    sint32  numVerts = vTestTab[v].fn(gVert, width, height, MAX_MESH, MAX_MESH);

    logFile->writeText(
      "\n\nVertex Format : %s ----------------------------------\n",
      vTestTab[v].name);

    // Unshaded
    {
      gfx->disable(G3D::GOURAUD);

      // preview
      gfx->lock();
      W3D_DrawArray(getRasterizerContext(gfx), W3D_PRIMITIVE_POINTS, 0, numVerts);
      gfx->unlock();
      appWindow->refresh();

      totTime  = 0;
      sint32  reps = 0;
      while (totTime<testTime)
      {
        sprintf(info, title, (uint32)totTime, vTestTab[v].name, "Flat");
        appWindow->setTitle(info);

        lockTime = 0;
        gfx->lock();
        while (lockTime<MAX_LOCKTIME)
        {
          timer.set();
          W3D_DrawArray(getRasterizerContext(gfx), W3D_PRIMITIVE_POINTS, 0, numVerts);
          lockTime += timer.elapsedFrac();
          reps++;
        }
        gfx->unlock();
        totTime += lockTime;
      }
      sprintf(info, title, (uint32)totTime, vTestTab[v].name, "Flat");
      appWindow->setTitle(info);

      float64  pointsPerSec = (1000.0*reps*numVerts)/(totTime);
      logFile->writeText(logTx, "[Flat]", (sint32)pointsPerSec);
      unshaded += pointsPerSec;
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
            cTestTab[c].fn(gVert, MAX_MESH, MAX_MESH);
          // User test failed support of this colour format
          continue;
        }
        setArray(gVert, vTestTab[v].format, cTestTab[c].format);

        if (cTestTab[c].fn)
          cTestTab[c].fn(gVert, MAX_MESH, MAX_MESH);

        // preview
        gfx->lock();
        W3D_DrawArray(getRasterizerContext(gfx), W3D_PRIMITIVE_POINTS, 0, numVerts);
        gfx->unlock();
        appWindow->refresh();

        totTime=0;
        sint32  reps = 0;
        while (totTime<testTime)
        {
          sprintf(info, title, (uint32)totTime, vTestTab[v].name, cTestTab[c].name);
          appWindow->setTitle(info);

          lockTime = 0;
          gfx->lock();
          while (lockTime<MAX_LOCKTIME)
          {
            timer.set();
            W3D_DrawArray(getRasterizerContext(gfx), W3D_PRIMITIVE_POINTS, 0, numVerts);
            lockTime += timer.elapsedFrac();
            reps++;
          }
          gfx->unlock();
          totTime += lockTime;
        }

        sprintf(info, title, (uint32)totTime, vTestTab[v].name, cTestTab[c].name);
        appWindow->setTitle(info);

        float64  pointsPerSec = (1000.0*reps*numVerts)/(totTime);
        logFile->writeText(logTx, cTestTab[c].name, (sint32)pointsPerSec);
        shaded += pointsPerSec;
        shadedReps++;
      }
    }
  }
  unshaded /= (float64)unshadedReps;
  shaded /= (float64)shadedReps;
  SystemLib::dialogueBox(dBoxInfo, dBoxProceed,
    "Render Points (Linear)\n\n"
    "Average unshaded : %6.2f points/s\n"
    "Average shaded : %6.2f points/s",
    unshaded, shaded
  );
}
