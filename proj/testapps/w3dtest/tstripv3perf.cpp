//****************************************************************************//
//**                                                                        **//
//** File:         proj/W3DTest/tstripperf.cpp                              **//
//** Description:  Warp3D test application                                  **//
//** Comment(s):   This software calls Warp3D directly and is hence not     **//
//**               portable.                                                **//
//** Created:      2004-01-31                                               **//
//** Updated:      2004-02-01                                               **//
//** Author(s):    Karl Churchill                                           **//
//** Note(s):      Compile with StormC optimiser no higher than 5 due to    **//
//**               detected bug in register allocation of loop counter      **//
//**                                                                        **//
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

using X_SYSNAME::W3D_Vertex;
using X_SYSNAME::W3D_Triangle;
using X_SYSNAME::W3D_Triangles;

////////////////////////////////////////////////////////////////////////////////
//
//  Auxilliary functions
//
////////////////////////////////////////////////////////////////////////////////

static sint32 calcTriStripXYZ_W3D(W3D_Vertex* v, sint16 w, sint16 h, sint16 xDim, sint16 yDim)
{
  // Calculates a mesh of (xDim-1)*(yDim-1)*2 triangles, using no shared vertices
  rfloat32 xStep = ((float32)w-1)/((float32)(xDim-1));
  rfloat32 yStep = ((float32)h-1)/((float32)(yDim-1));
  rfloat32 y1 = 0.5f;
  rfloat32 y2 = y1 + yStep;
  for (rsint32 i=0; i<yDim-1; i++, y1+=yStep, y2+=yStep)
  {
    rfloat32 x = 0.5f;
    for (rsint32 j=0; j<xDim; j++, x+=xStep)
    {
      v->x = x; v->y = y1; v->z = 0; v++;
      v->x = x; v->y = y2; v->z = 0; v++;
    }
  }
  return (xDim)*(yDim-1)*2; // number of vertices;
}

static sint32 calcTriStripLinFRGBA_W3D(W3D_Vertex* v, sint16 w, sint16 h, sint16 xDim, sint16 yDim)
{
  rfloat32 xStep = ((float32)w-1)/((float32)(xDim-1));
  rfloat32 yStep = ((float32)h-1)/((float32)(yDim-1));

  float32 radFact = 1.0/sqrt((w*w)+(h*h));

  rfloat32 y1 = 0.5;
  rfloat32 y2 = y1 + yStep;
  for (rsint32 i=0; i<yDim-1; i++, y1+=yStep, y2+=yStep)
  {
    rfloat32 x = 0.5;
    for (rsint32 j=0; j<xDim; j++, x+=xStep)
    {
      float32 v1 = MAX_F - Clamp::real(radFact*sqrt((x*x)+(y1*y1)), 0.0, MAX_F);
      float32 v2 = MAX_F - Clamp::real(radFact*sqrt((x*x)+(y2*y2)), 0.0, MAX_F);

      if (j & 1)
      {
        v->color.a = 0;
        v->color.r = v1;
        v->color.g = v1;
        v->color.b = 0;
        v++;
        v->color.a = 0;
        v->color.r = v2;
        v->color.g = 0;
        v->color.b = v2;
        v++;
      }
      else
      {
        v->color.a = 0;
        v->color.r = v2;
        v->color.g = v2;
        v->color.b = 0;
        v++;
        v->color.a = 0;
        v->color.r = v1;
        v->color.g = 0;
        v->color.b = v1;
        v++;
      }
    }
  }
  return (xDim)*(yDim-1)*2; // number of vertices
}

////////////////////////////////////////////////////////////////////////////////
//
//  Types
//
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
//
//  Tables
//
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
//
//  Strings
//
////////////////////////////////////////////////////////////////////////////////

static const char* title      = "Warp3D Test : V1+ Triangle Strip Render %lu [%ld x %ld:%s]";
static const char* titleCalc  = "Warp3D Test : V1+ Triangle Strip Render [%ld x %ld] - Calculating";
static const char* logTxCull  = "Backface culled            : %2ld x %2ld %6ld tris/s\n";
static const char* logTxNorm  = "Colour Format %s       : %2ld x %2ld %6ld tris/s\n";

////////////////////////////////////////////////////////////////////////////////
//
//  Application Methods
//
////////////////////////////////////////////////////////////////////////////////

void TestWarp3D::measureTriStripV3()
{
  appWindow->setTitle("Warp3D Test : V1+ Triangle Strip Render Test");
  clear();

  logFile->writeText("\n\nV1+ Triangle Strip Render\n");
  if (!SystemLib::dialogueBox(dBoxInfo, dBoxRunSkip,
    "V1+ Triangle Strip Render Test\n\n"
    "TestW3D will estimate the speed at which triangle strips can be\n"
    "rendered using the original triangle strip methods on your configuration.\n"
  ))
  {
    logFile->writeText(qTestSkip);
    return;
  }

  static float64  culled[NUM_DIM];
  static float64  unshaded[NUM_DIM];
  static float64  shaded[NUM_DIM];
  static X_SYSNAME::W3D_Triangles  tris;

  float64 totTime;
  float64 lockTime;
  float64 testTime      = minTestTime;

  gfx->disable(G3D::TEXTURE);
  gfx->disable(G3D::BLENDING);
  gfx->setFront(G3D::FRONT_CCW);

  W3D_Vertex* verts = (W3D_Vertex*)data;

  sint32 dim, dimS;
  for (dim=0, dimS = MIN_MESH; dim<NUM_DIM; dim++, dimS += MESH_STEP)
  {
    sprintf(info, titleCalc, dimS, dimS);
    appWindow->setTitle(info);

    culled[dim]          = 0;
    unshaded[dim]        = 0;
    shaded[dim]          = 0;
    sint32 culledReps    = 0;
    sint32 unshadedReps  = 0;
    sint32 shadedReps    = 0;
    sint32 numVerts      = calcTriStripXYZ_W3D(verts, width, height, dimS, dimS);
    sint32 len          = dimS<<1;
    // Culled
    {
      clear();
      gfx->disable(G3D::GOURAUD);
      gfx->enable(G3D::CULLING);
      totTime = 0;
      sint32  reps = 0;
      while(totTime<testTime)
      {
        sprintf(info, title, (uint32)totTime, dimS, dimS, "Cull");
        appWindow->setTitle(info);

        lockTime = 0;
        gfx->lock();
        while (lockTime<MAX_LOCKTIME)
        {
          W3D_Vertex* v = verts;
          timer.set();
          for (sint32 i=1; i<dimS; i++, v+=len)
          {
            tris.vertexcount = len;
            tris.v = v;
            W3D_DrawTriStrip(getRasterizerContext(gfx), &tris);
          }
          lockTime += timer.elapsedFrac();
          reps++;
        }
        gfx->unlock();
        totTime+=lockTime;
      }

      sprintf(info, title, (uint32)totTime, dimS, dimS, "Cull");
      appWindow->setTitle(info);
      float64  trisPerSec = (1000.0*reps*(numVerts-3))/(totTime);
      logFile->writeText(logTxCull, dimS, dimS, (sint32)trisPerSec);
      culled[dim] += trisPerSec;
      culledReps++;
      gfx->disable(G3D::CULLING);
    }


    // Unshaded
    {
      gfx->disable(G3D::GOURAUD);

      totTime=0;
      sint32  reps = 0;
      while(totTime<testTime)
      {
        sprintf(info, title, (uint32)totTime, dimS, dimS, "Flat");
        appWindow->setTitle(info);

        lockTime = 0;
        gfx->lock();
        while (lockTime<MAX_LOCKTIME)
        {
          W3D_Vertex* v = verts;
          timer.set();
          for (sint32 i=1; i<dimS; i++, v+=len)
          {
            tris.vertexcount = len;
            tris.v = v;
            W3D_DrawTriStrip(getRasterizerContext(gfx), &tris);
          }
          lockTime += timer.elapsedFrac();
          reps++;
        }
        gfx->unlock();
        appWindow->refresh();
        totTime+=lockTime;
      }

      sprintf(info, title, (uint32)totTime, dimS, dimS, "Flat");
      appWindow->setTitle(info);
      float64  trisPerSec = (1000.0*reps*(numVerts-3))/(totTime);
      logFile->writeText(logTxNorm, "[Flat]", dimS, dimS, (sint32)trisPerSec);
      unshaded[dim] += trisPerSec;
      unshadedReps++;
    }

    // Shaded
    {
      gfx->enable(G3D::GOURAUD);
      calcTriStripLinFRGBA_W3D(verts, width, height, dimS, dimS);

      totTime=0;
      sint32  reps=0;
      while(totTime<testTime)
      {
        sprintf(info, title, (uint32)totTime, dimS, dimS, "RGBA_F");
        appWindow->setTitle(info);

        lockTime = 0;
        gfx->lock();
        while (lockTime<MAX_LOCKTIME)
        {
          W3D_Vertex* v = verts;
          timer.set();
          for (sint32 i=1; i<dimS; i++, v+=len)
          {
            tris.vertexcount = len;
            tris.v = v;
            W3D_DrawTriStrip(getRasterizerContext(gfx), &tris);
          }
          lockTime += timer.elapsedFrac();
          reps++;
        }
        gfx->unlock();
        appWindow->refresh();
        totTime+=lockTime;
      }

      sprintf(info, title, (uint32)totTime, dimS, dimS, "RGBA_F");
      appWindow->setTitle(info);
      float64  trisPerSec = (1000.0*reps*(numVerts-3))/(totTime);
      logFile->writeText(logTxNorm, "RGBA_F", dimS, dimS, (sint32)trisPerSec);
      shaded[dim] += trisPerSec;
      shadedReps++;
    }

    culled[dim] /= culledReps;
    unshaded[dim] /= unshadedReps;
    shaded[dim] /= shadedReps;
  }

  char* text;
  if (text = (char*)Mem::alloc(1024));
  {
    sint32 pos = sprintf(text, "Render Triangle Strip (V1+)\n");
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
