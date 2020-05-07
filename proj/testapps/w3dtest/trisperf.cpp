//****************************************************************************//
//**                                                                        **//
//** File:         proj/W3DTest/trisperf.cpp                               **//
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

extern "C" {
  #include <math.h>
}

////////////////////////////////////////////////////////////////////////////////
//
//  Auxilliary functions
//
////////////////////////////////////////////////////////////////////////////////

static sint32 calcTrisLinFFF(GenericVertex* v, sint16 w, sint16 h, sint16 xDim, sint16 yDim)
{
  // Calculates a mesh of (xDim-1)*(yDim-1)*2 triangles, using no shared vertices
  rfloat32 xStep = ((float32)w-1)/((float32)(xDim-1));
  rfloat32 yStep = ((float32)h-1)/((float32)(yDim-1));
  rfloat32 y1 = 0.5f;
  rfloat32 y2 = y1 + yStep;
  for (rsint32 i=0; i<yDim-1; i++, y1+=yStep, y2+=yStep)
  {
    rfloat32 x1 = 0.5f;
    rfloat32 x2 = x1 + xStep;
    for (rsint32 j=0; j<xDim-1; j++, x1+=xStep, x2+=xStep)
    {
      // triangle 1 - top left of cell
      v->crd.fff.x = x1; v->crd.fff.y = y1; v->crd.fff.z = 0; v++;
      v->crd.fff.x = x2; v->crd.fff.y = y1; v->crd.fff.z = 0; v++;
      v->crd.fff.x = x1; v->crd.fff.y = y2; v->crd.fff.z = 0; v++;
      // triangle 2 - bottom right of cell
      v->crd.fff.x = x1; v->crd.fff.y = y2; v->crd.fff.z = 0; v++;
      v->crd.fff.x = x2; v->crd.fff.y = y1; v->crd.fff.z = 0; v++;
      v->crd.fff.x = x2; v->crd.fff.y = y2; v->crd.fff.z = 0; v++;
    }
  }
  return (xDim-1)*(yDim-1)*6; // number of vertices
}

////////////////////////////////////////////////////////////////////////////////

sint32 calcTrisLinFFD(GenericVertex* v, sint16 w, sint16 h, sint16 xDim, sint16 yDim)
{
  // Calculates a mesh of (xDim-1)*(yDim-1)*2 triangles, using no shared vertices
  rfloat32 xStep = ((float32)w-1)/((float32)(xDim-1));
  rfloat32 yStep = ((float32)h-1)/((float32)(yDim-1));
  rfloat32 y1 = 0.5f;
  rfloat32 y2 = y1 + yStep;
  for (rsint32 i=0; i<yDim-1; i++, y1+=yStep, y2+=yStep)
  {
    rfloat32 x1 = 0.5f;
    rfloat32 x2 = x1 + xStep;
    for (rsint32 j=0; j<xDim-1; j++, x1+=xStep, x2+=xStep)
    {
      // triangle 1 - top left of cell
      v->crd.ffd.x = x1; v->crd.ffd.y = y1; v->crd.ffd.z = 0; v++;
      v->crd.ffd.x = x2; v->crd.ffd.y = y1; v->crd.ffd.z = 0; v++;
      v->crd.ffd.x = x1; v->crd.ffd.y = y2; v->crd.ffd.z = 0; v++;
      // triangle 2 - bottom right of cell
      v->crd.ffd.x = x1; v->crd.ffd.y = y2; v->crd.ffd.z = 0; v++;
      v->crd.ffd.x = x2; v->crd.ffd.y = y1; v->crd.ffd.z = 0; v++;
      v->crd.ffd.x = x2; v->crd.ffd.y = y2; v->crd.ffd.z = 0; v++;
    }
  }
  return (xDim-1)*(yDim-1)*6; // number of vertices
}

////////////////////////////////////////////////////////////////////////////////

static sint32 calcTrisLinDDD(GenericVertex* v, sint16 w, sint16 h, sint16 xDim, sint16 yDim)
{
  // Calculates a mesh of (xDim-1)*(yDim-1)*2 triangles, using no shared vertices
  rfloat64 xStep = ((float32)w-1)/((float32)(xDim-1));
  rfloat64 yStep = ((float32)h-1)/((float32)(yDim-1));
  rfloat64 y1 = 0.5;
  rfloat64 y2 = y1 + yStep;
  for (rsint32 i=0; i<yDim-1; i++, y1+=yStep, y2+=yStep)
  {
    rfloat64 x1 = 0.5;
    rfloat64 x2 = x1 + xStep;
    for (rsint32 j=0; j<xDim-1; j++, x1+=xStep, x2+=xStep)
    {
      // triangle 1 - top left of cell
      v->crd.ddd.x = x1; v->crd.ddd.y = y1; v->crd.ddd.z = 0; v++;
      v->crd.ddd.x = x2; v->crd.ddd.y = y1; v->crd.ddd.z = 0; v++;
      v->crd.ddd.x = x1; v->crd.ddd.y = y2; v->crd.ddd.z = 0; v++;
      // triangle 2 - bottom right of cell
      v->crd.ddd.x = x1; v->crd.ddd.y = y2; v->crd.ddd.z = 0; v++;
      v->crd.ddd.x = x2; v->crd.ddd.y = y1; v->crd.ddd.z = 0; v++;
      v->crd.ddd.x = x2; v->crd.ddd.y = y2; v->crd.ddd.z = 0; v++;
    }
  }
  return (xDim-1)*(yDim-1)*6; // number of vertices
}

////////////////////////////////////////////////////////////////////////////////

static sint32 calcTrisLinUARGB(GenericVertex* v, sint16 w, sint16 h, sint16 xDim, sint16 yDim)
{
  rfloat32 xStep = ((float32)w-1)/((float32)(xDim-1));
  rfloat32 yStep = ((float32)h-1)/((float32)(yDim-1));

  float32 radFact = 1.0/sqrt((w*w)+(h*h));

  rfloat32 y1 = 0.5;
  rfloat32 y2 = y1 + yStep;
  for (rsint32 i=0; i<yDim-1; i++, y1+=yStep, y2+=yStep)
  {
    rfloat32 x1 = 0.5;
    rfloat32 x2 = x1 + xStep;
    for (rsint32 j=0; j<xDim-1; j++, x1+=xStep, x2+=xStep)
    {
      float32 v1 = 1.0 - Clamp::real(radFact*sqrt((x1*x1)+(y1*y1)), 0.0, 1.0);
      float32 v2 = 1.0 - Clamp::real(radFact*sqrt((x2*x2)+(y1*y1)), 0.0, 1.0);
      float32 v3 = 1.0 - Clamp::real(radFact*sqrt((x1*x1)+(y2*y2)), 0.0, 1.0);
      float32 v4 = 1.0 - Clamp::real(radFact*sqrt((x2*x2)+(y2*y2)), 0.0, 1.0);

      // triangle 1 - top left of cell
      v->clr.uargb.a = (uint8)(255.0*v1);
      v->clr.uargb.r = 0;
      v->clr.uargb.g = 0;
      v->clr.uargb.b = 0;
      v++;

      v->clr.uargb.a = 0;
      v->clr.uargb.r = (uint8)(255.0*v2);
      v->clr.uargb.g = 0;
      v->clr.uargb.b = 0;
      v++;

      v->clr.uargb.a = 0;
      v->clr.uargb.r = 0;
      v->clr.uargb.g = (uint8)(255.0*v3);
      v->clr.uargb.b = 0;
      v++;

      // triangle 2 - bottom right of cell
      v->clr.uargb.a = 0;
      v->clr.uargb.r = 0;
      v->clr.uargb.g = (uint8)(255.0*v3);
      v->clr.uargb.b = 0;
      v++;

      v->clr.uargb.a = 0;
      v->clr.uargb.r = (uint8)(255.0*v2);
      v->clr.uargb.g = 0;
      v->clr.uargb.b = 0;
      v++;

      v->clr.uargb.a = 0;
      v->clr.uargb.r = 0;
      v->clr.uargb.g = 0;
      v->clr.uargb.b = (uint8)(255.0*v4);
      v++;
    }
  }
  return (xDim-1)*(yDim-1)*6; // number of vertices
}

////////////////////////////////////////////////////////////////////////////////

static sint32 calcTrisLinFARGB(GenericVertex* v, sint16 w, sint16 h, sint16 xDim, sint16 yDim)
{
  rfloat32 xStep = ((float32)w-1)/((float32)(xDim-1));
  rfloat32 yStep = ((float32)h-1)/((float32)(yDim-1));

  float32 radFact = 1.0/sqrt((w*w)+(h*h));

  rfloat32 y1 = 0.5;
  rfloat32 y2 = y1 + yStep;
  for (rsint32 i=0; i<yDim-1; i++, y1+=yStep, y2+=yStep)
  {
    rfloat32 x1 = 0.5;
    rfloat32 x2 = x1 + xStep;
    for (rsint32 j=0; j<xDim-1; j++, x1+=xStep, x2+=xStep)
    {
      float32 v1 = MAX_F - Clamp::real(radFact*sqrt((x1*x1)+(y1*y1)), 0.0, MAX_F);
      float32 v2 = MAX_F - Clamp::real(radFact*sqrt((x2*x2)+(y1*y1)), 0.0, MAX_F);
      float32 v3 = MAX_F - Clamp::real(radFact*sqrt((x1*x1)+(y2*y2)), 0.0, MAX_F);
      float32 v4 = MAX_F - Clamp::real(radFact*sqrt((x2*x2)+(y2*y2)), 0.0, MAX_F);

      // triangle 1 - top left of cell
      v->clr.fargb.a = v1;
      v->clr.fargb.r = 0;
      v->clr.fargb.g = 0;
      v->clr.fargb.b = 0;
      v++;

      v->clr.fargb.a = 0;
      v->clr.fargb.r = v2;
      v->clr.fargb.g = 0;
      v->clr.fargb.b = 0;
      v++;

      v->clr.fargb.a = 0;
      v->clr.fargb.r = 0;
      v->clr.fargb.g = v3;
      v->clr.fargb.b = 0;
      v++;

      // triangle 2 - bottom right of cell
      v->clr.fargb.a = 0;
      v->clr.fargb.r = 0;
      v->clr.fargb.g = v3;
      v->clr.fargb.b = 0;
      v++;

      v->clr.fargb.a = 0;
      v->clr.fargb.r = v2;
      v->clr.fargb.g = 0;
      v->clr.fargb.b = 0;
      v++;

      v->clr.fargb.a = 0;
      v->clr.fargb.r = 0;
      v->clr.fargb.g = 0;
      v->clr.fargb.b = v4;
      v++;

    }
  }
  return (xDim-1)*(yDim-1)*6; // number of vertices
}

////////////////////////////////////////////////////////////////////////////////
//
//  Types
//
////////////////////////////////////////////////////////////////////////////////

typedef sint32 (*TestFunc)(GenericVertex* v, sint16 w, sint16 h, sint16 xDim, sint16 yDim);

struct VTest {
  GenericVertex::VFormat format;
  const char* name;
  TestFunc func;
};

struct CTest {
  GenericVertex::CFormat format;
  const char* name;
  TestFunc func;
};

////////////////////////////////////////////////////////////////////////////////
//
//  Tables
//
////////////////////////////////////////////////////////////////////////////////

static VTest vTestTab[] = {
  { GenericVertex::XYZ_FFF,  "FFF",  calcTrisLinFFF },
  { GenericVertex::XYZ_FFD,  "FFD",  calcTrisLinFFD },
  { GenericVertex::XYZ_DDD,  "DDD",  calcTrisLinDDD },
};

static CTest cTestTab[] = {
  { GenericVertex::CLR_URGB,  "RGB_U ",  calcTrisLinUARGB },
  { GenericVertex::CLR_UBGR,  "BGR_U ",  0 },
  { GenericVertex::CLR_URGBA,  "RGBA_U",  0 },
  { GenericVertex::CLR_UARGB,  "ARGB_U",  0 },
  { GenericVertex::CLR_UBGRA,  "BGRA_U",  0 },
  { GenericVertex::CLR_FRGB,  "RGB_F ",  calcTrisLinFARGB },
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

static const char* title      = "Warp3D Test : Triangle Render %lu [%ld x %ld %s:%s]";
static const char* titleCalc  = "Warp3D Test : Triangle Render [%ld x %ld] - Calculating %s";
static const char* logTxCull  = "Backface culled            : %2ld x %2ld %6ld tris/s\n";
static const char* logTxNorm  = "Colour Format %s       : %2ld x %2ld %6ld tris/s\n";

////////////////////////////////////////////////////////////////////////////////
//
//  Application Methods
//
////////////////////////////////////////////////////////////////////////////////

void TestWarp3D::measureTrisLinear()
{
  appWindow->setTitle("Warp3D Test : Linear Triangle Render Test");
  clear();

  Time estimated((sint64)
    (NUM_DIM*GenericVertex::_XYZ_NUM*(GenericVertex::_CLR_NUM+2)*minTestTime)
  );

  logFile->writeText("\n\nTriangle Render [Array Linear] ");
  if (!SystemLib::dialogueBox(dBoxInfo, dBoxRunSkip,
    "Triangle Render Test\n\n"
    "TestW3D will estimate the speed at which triangles can be\n"
    "rendered using vertex array methods on your configuration.\n"
    "The triangle test will iterate through each vertex and colour\n"
    "format. The test will be performed using a regular mesh of\n"
    "triangles and repeated for several mesh sizes.\n"
    "Only the average performance for culled, flat and shaded\n"
    "triangles will be reported, but each individual result will be\n"
    "recorded in the logfile.\n\n"
    "Please note, this following test may take some time to complete.\n"
    "[Estimated running time : %02ld:%02ld:%02ld hh:mm:ss]",
    estimated.hours(),
    estimated.mins(),
    (estimated.secs()+(estimated.millis()>=500 ? 1:0))
  ))
  {
    logFile->writeText(qTestSkip);
    return;
  }

  static float64  culled[NUM_DIM];
  static float64  unshaded[NUM_DIM];
  static float64  shaded[NUM_DIM];
  float64 totTime;
  float64 lockTime;
  float64 testTime      = minTestTime;

  gfx->disable(G3D::TEXTURE);
  gfx->disable(G3D::BLENDING);

  GenericVertex* gVert = (GenericVertex*)data;
  sint32 dim, dimS;
  for (dim=0, dimS = MIN_MESH; dim<NUM_DIM; dim++, dimS += MESH_STEP)
  {
    clear();
    culled[dim]          = 0;
    unshaded[dim]        = 0;
    shaded[dim]          = 0;
    sint32 culledReps    = 0;
    sint32 unshadedReps  = 0;
    sint32 shadedReps    = 0;

    gfx->setFront(G3D::FRONT_CCW);

    for (sint32 v=0; v<GenericVertex::_XYZ_NUM; v++)
    {
      if ((check & (1<<(v+CH_VERTEX_SHIFT)))==0)
      {
        // User test failed support of this colour format
        continue;
      }

      setArray(gVert, vTestTab[v].format);
      sint32  numVerts = vTestTab[v].func(gVert, width, height, dimS, dimS);

      sprintf(info, titleCalc, dimS, dimS, vTestTab[v].name);
      appWindow->setTitle(info);

      logFile->writeText(
        "\n\nVertex Format : %s ----------------------------------\n",
        vTestTab[v].name);

      // Culled
      {
        clear();
        gfx->disable(G3D::GOURAUD);
        gfx->enable(G3D::CULLING);
        totTime = 0;
        sint32  reps = 0;
        while(totTime<testTime)
        {
          sprintf(info, title, (uint32)totTime, dimS, dimS, vTestTab[v].name, "Cull");
          appWindow->setTitle(info);

          lockTime = 0;
          gfx->lock();
          while (lockTime<MAX_LOCKTIME)
          {
            timer.set();
            W3D_DrawArray(getRasterizerContext(gfx), W3D_PRIMITIVE_TRIANGLES, 0, numVerts);
            lockTime += timer.elapsedFrac();
            ++reps;
          }
          gfx->unlock();
          totTime+=lockTime;
        }

        sprintf(info, title, (uint32)totTime, dimS, dimS, vTestTab[v].name, "Cull");
        appWindow->setTitle(info);

        float64  trisPerSec = ((1000.0/3.0)*reps*numVerts)/(totTime);

        logFile->writeText(logTxCull, dimS, dimS, (sint32)trisPerSec);

        culled[dim] += trisPerSec;
        culledReps++;
        gfx->disable(G3D::CULLING);
      }


      // Unshaded
      {
        gfx->disable(G3D::GOURAUD);

        // show test gfx preview
        gfx->lock();
        W3D_DrawArray(getRasterizerContext(gfx), W3D_PRIMITIVE_TRIANGLES, 0, numVerts);
        gfx->unlock();
        appWindow->refresh();

        totTime=0;
        sint32  reps = 0;
        while (totTime<testTime)
        {
          sprintf(info, title, (uint32)totTime, dimS, dimS, vTestTab[v].name, "Flat");
          appWindow->setTitle(info);

          lockTime = 0;
          gfx->lock();
          while (lockTime<MAX_LOCKTIME)
          {
            timer.set();
            W3D_DrawArray(getRasterizerContext(gfx), W3D_PRIMITIVE_TRIANGLES, 0, numVerts);
            lockTime += timer.elapsedFrac();
            reps++;
          }
          gfx->unlock();
          totTime+=lockTime;
        }

        sprintf(info, title, (uint32)totTime, dimS, dimS, vTestTab[v].name, "Flat");
        appWindow->setTitle(info);

        float64  trisPerSec = ((1000.0/3.0)*reps*numVerts)/(totTime);

        logFile->writeText(logTxNorm, "[Flat]", dimS, dimS, (sint32)trisPerSec);

        unshaded[dim] += trisPerSec;
        unshadedReps++;
      }

      // Shaded
      {
        gfx->enable(G3D::GOURAUD);
        for (sint32 c=0; c<GenericVertex::_CLR_NUM; c++)
        {
          if ((check & (1<<(c+CH_COLOUR_SHIFT)))==0)
          {
            if (cTestTab[c].func)
              cTestTab[c].func(gVert, width, height, dimS, dimS);

            // User test failed support of this colour format
            continue;
          }

          setArray(gVert, vTestTab[v].format, cTestTab[c].format);

          if (cTestTab[c].func)
          {
            sprintf(info, titleCalc, dimS, dimS, cTestTab[c].name);
            appWindow->setTitle(info);
            cTestTab[c].func(gVert, width, height, dimS, dimS);
          }

          // show test gfx preview
          gfx->lock();
          W3D_DrawArray(getRasterizerContext(gfx), W3D_PRIMITIVE_TRIANGLES, 0, numVerts);
          gfx->unlock();
          appWindow->refresh();

          totTime=0;
          sint32  reps=0;
          while(totTime<testTime)
          {
            sprintf(info, title, (uint32)totTime, dimS, dimS, vTestTab[v].name, cTestTab[c].name);
            appWindow->setTitle(info);

            lockTime = 0;
            gfx->lock();
            while (lockTime<MAX_LOCKTIME)
            {
              timer.set();
              W3D_DrawArray(getRasterizerContext(gfx), W3D_PRIMITIVE_TRIANGLES, 0, numVerts);
              lockTime += timer.elapsedFrac();
              reps++;
            }
            gfx->unlock();
            totTime+=lockTime;
          }

          sprintf(info, title, (uint32)totTime, dimS, dimS, vTestTab[v].name, cTestTab[c].name);
          appWindow->setTitle(info);

          float64  trisPerSec = ((1000.0/3.0)*reps*numVerts)/(totTime);

          logFile->writeText(logTxNorm, cTestTab[c].name, dimS, dimS, (sint32)trisPerSec);

          shaded[dim] += trisPerSec;
          shadedReps++;
        }
      }
    }
    culled[dim] /= culledReps;
    unshaded[dim] /= unshadedReps;
    shaded[dim] /= shadedReps;
  }

  char* text;
  if (text = (char*)Mem::alloc(1024));
  {
    sint32 pos = sprintf(text, "Render Triangles (Linear)\n");
    for (dim=0, dimS=MIN_MESH; dim<NUM_DIM; dim++, dimS+=MESH_STEP)
    {
      pos += sprintf((text+pos),
        "\nAverage %3ld x %3ld culled : %6.2f tris/s\n"
        "Average %3ld x %3ld flat : %6.2f tris/s\n"
        "Average %3ld x %3ld shaded : %6.2f tris/s",
        dimS, dimS, culled[dim],
        dimS, dimS, unshaded[dim],
        dimS, dimS, shaded[dim]);
    }
    SystemLib::dialogueBox(dBoxInfo, dBoxProceed, text);
    Mem::free(text);
  }
}
