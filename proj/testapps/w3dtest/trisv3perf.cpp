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

extern sint32 calcTrisLinFFD(GenericVertex* v, sint16 w, sint16 h, sint16 xDim, sint16 yDim);

static sint32 calcTrisLinFRGBA(GenericVertex* v, sint16 w, sint16 h, sint16 xDim, sint16 yDim)
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
      v->clr.fargb.a = 0;
      v->clr.fargb.r = v1;
      v->clr.fargb.g = 0;
      v->clr.fargb.b = 0;
      v++;

      v->clr.fargb.a = 0;
      v->clr.fargb.r = 0;
      v->clr.fargb.g = v2;
      v->clr.fargb.b = 0;
      v++;

      v->clr.fargb.a = 0;
      v->clr.fargb.r = 0;
      v->clr.fargb.g = 0;
      v->clr.fargb.b = v3;
      v++;

      // triangle 2 - bottom right of cell
      v->clr.fargb.a = 0;
      v->clr.fargb.r = 0;
      v->clr.fargb.g = 0;
      v->clr.fargb.b = v3;
      v++;

      v->clr.fargb.a = 0;
      v->clr.fargb.r = 0;
      v->clr.fargb.g = v2;
      v->clr.fargb.b = 0;
      v++;

      v->clr.fargb.a = 0;
      v->clr.fargb.r = v4;
      v->clr.fargb.g = 0;
      v->clr.fargb.b = 0;
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


////////////////////////////////////////////////////////////////////////////////
//
//  Strings
//
////////////////////////////////////////////////////////////////////////////////

static const char* title      = "Warp3D Test : V1+ Single Triangle Render %lu [%ld x %ld:%s]";
static const char* titleCalc  = "Warp3D Test : V1+ Single Triangle Render [%ld x %ld] - Calculating";
static const char* logTxCull  = "Backface culled            : %2ld x %2ld %6ld tris/s\n";
static const char* logTxNorm  = "Colour Format %s       : %2ld x %2ld %6ld tris/s\n";

////////////////////////////////////////////////////////////////////////////////
//
//  Application Methods
//
////////////////////////////////////////////////////////////////////////////////

void TestWarp3D::measureTrisV3()
{
  appWindow->setTitle("Warp3D Test : V1+ Single Triangle Render Test");
  clear();

  logFile->writeText("\n\nV1+ Single Triangle Render\n");
  if (!SystemLib::dialogueBox(dBoxInfo, dBoxRunSkip,
    "V1+ Triangle Render Test\n\n"
    "TestW3D will estimate the speed at which triangles can be\n"
    "rendered using the single triangle methods on your configuration.\n"
  ))
  {
    logFile->writeText(qTestSkip);
    return;
  }

  static float64 culled[NUM_DIM];
  static float64 unshaded[NUM_DIM];
  static float64 shaded[NUM_DIM];
  static X_SYSNAME::W3D_Triangle  tri;

  float64 totTime;
  float64 lockTime;
  float64 testTime      = minTestTime;

  gfx->disable(G3D::TEXTURE);
  gfx->disable(G3D::BLENDING);
  gfx->setFront(G3D::FRONT_CCW);
  GenericVertex* vert  = (GenericVertex*)data;

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
    sint32 numVerts      = calcTrisLinFFD(vert, width, height, dimS, dimS);
    sint32 numTris      = numVerts/3;

    // Culled
    {
      gfx->disable(G3D::GOURAUD);
      gfx->enable(G3D::CULLING);
      totTime = 0;
      sint32  reps = 0;
      while(totTime<testTime) {
        sprintf(info, title, (uint32)totTime, dimS, dimS, "Cull");
        appWindow->setTitle(info);
        lockTime = 0;
        gfx->lock();
        while (lockTime<MAX_LOCKTIME) {
          GenericVertex* v = vert;
          timer.set();
          for (sint32 i=0; i<numTris;i++) {
            tri.v1.x = v[0].crd.ffd.x;
            tri.v1.y = v[0].crd.ffd.y;
            tri.v1.z = v[0].crd.ffd.z;

            tri.v2.x = v[1].crd.ffd.x;
            tri.v2.y = v[1].crd.ffd.y;
            tri.v2.z = v[1].crd.ffd.z;

            tri.v3.x = v[2].crd.ffd.x;
            tri.v3.y = v[2].crd.ffd.y;
            tri.v3.z = v[2].crd.ffd.z;

            v+=3;

            W3D_DrawTriangle(getRasterizerContext(gfx), &tri);
          }
          lockTime += timer.elapsedFrac();
          ++reps;
        }
        gfx->unlock();
        totTime+=lockTime;
      }

      sprintf(info, title, (uint32)totTime, dimS, dimS, "Cull");
      appWindow->setTitle(info);
      float64  trisPerSec = ((1000.0/3.0)*reps*numVerts)/(totTime);
      logFile->writeText(logTxCull, dimS, dimS, (sint32)trisPerSec);
      culled[dim] += trisPerSec;
      culledReps++;
    }


    // Unshaded
    {
      gfx->disable(G3D::CULLING);

      totTime=0;
      sint32  reps = 0;
      while (totTime<testTime)
      {
        sprintf(info, title, (uint32)totTime, dimS, dimS, "Flat");
        appWindow->setTitle(info);
        lockTime = 0;
        gfx->lock();
        while (lockTime<MAX_LOCKTIME) {
          GenericVertex* v = vert;
          timer.set();
          for (sint32 i=0; i<numTris;i++) {
            tri.v1.x = v[0].crd.ffd.x;
            tri.v1.y = v[0].crd.ffd.y;
            tri.v1.z = v[0].crd.ffd.z;
            tri.v2.x = v[1].crd.ffd.x;
            tri.v2.y = v[1].crd.ffd.y;
            tri.v2.z = v[1].crd.ffd.z;
            tri.v3.x = v[2].crd.ffd.x;
            tri.v3.y = v[2].crd.ffd.y;
            tri.v3.z = v[2].crd.ffd.z;

            v+=3;

            W3D_DrawTriangle(getRasterizerContext(gfx), &tri);
          }
          lockTime += timer.elapsedFrac();
          ++reps;
        }
        gfx->unlock();
        appWindow->refresh();
        totTime+=lockTime;
      }

      sprintf(info, title, (uint32)totTime, dimS, dimS, "Flat");
      appWindow->setTitle(info);
      float64  trisPerSec = ((1000.0/3.0)*reps*numVerts)/(totTime);
      logFile->writeText(logTxNorm, "[Flat]", dimS, dimS, (sint32)trisPerSec);
      unshaded[dim] += trisPerSec;
      unshadedReps++;
    }



    // Shaded
    {
      gfx->enable(G3D::GOURAUD);
      calcTrisLinFRGBA(vert, width, height, dimS, dimS);

      totTime=0;
      sint32  reps=0;
      while(totTime<testTime)
      {
        sprintf(info, title, (uint32)totTime, dimS, dimS, "RBGA_F");
        appWindow->setTitle(info);
        lockTime = 0;
        gfx->lock();
        while (lockTime<MAX_LOCKTIME) {
          GenericVertex* v = vert;
          timer.set();
          for (sint32 i=0; i<numTris;i++) {
            tri.v1.x = v[0].crd.ffd.x;
            tri.v1.y = v[0].crd.ffd.y;
            tri.v1.z = v[0].crd.ffd.z;
            tri.v1.color.r = v[0].clr.fargb.r;
            tri.v1.color.g = v[0].clr.fargb.g;
            tri.v1.color.b = v[0].clr.fargb.b;
            tri.v1.color.a = v[0].clr.fargb.a;
            tri.v2.x = v[1].crd.ffd.x;
            tri.v2.y = v[1].crd.ffd.y;
            tri.v2.z = v[1].crd.ffd.z;
            tri.v1.color.r = v[1].clr.fargb.r;
            tri.v1.color.g = v[1].clr.fargb.g;
            tri.v1.color.b = v[1].clr.fargb.b;
            tri.v1.color.a = v[1].clr.fargb.a;
            tri.v3.x = v[2].crd.ffd.x;
            tri.v3.y = v[2].crd.ffd.y;
            tri.v3.z = v[2].crd.ffd.z;
            tri.v1.color.r = v[2].clr.fargb.r;
            tri.v1.color.g = v[2].clr.fargb.g;
            tri.v1.color.b = v[2].clr.fargb.b;
            tri.v1.color.a = v[2].clr.fargb.a;

            v+=3;

            W3D_DrawTriangle(getRasterizerContext(gfx), &tri);
          }
          lockTime += timer.elapsedFrac();
          ++reps;
        }
        gfx->unlock();
        appWindow->refresh();
        totTime+=lockTime;
      }

      sprintf(info, title, (uint32)totTime, dimS, dimS, "RGBA_F");
      appWindow->setTitle(info);
      float64  trisPerSec = ((1000.0/3.0)*reps*numVerts)/(totTime);
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
    sint32 pos = sprintf(text, "Render Triangles (v3)\n");
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
