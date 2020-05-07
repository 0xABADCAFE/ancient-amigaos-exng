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

////////////////////////////////////////////////////////////////////////////////
//
//  Auxilliary functions
//
////////////////////////////////////////////////////////////////////////////////

static sint32 calcTriStripLinFFF(GenericVertex* v, sint16 w, sint16 h, sint16 xDim, sint16 yDim)
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
      v->crd.fff.x = x; v->crd.fff.y = y1; v->crd.fff.z = 0; v++;
      v->crd.fff.x = x; v->crd.fff.y = y2; v->crd.fff.z = 0; v++;
    }
  }
  return (xDim)*(yDim-1)*2; // number of vertices
}

////////////////////////////////////////////////////////////////////////////////

static sint32 calcTriStripLinFFD(GenericVertex* v, sint16 w, sint16 h, sint16 xDim, sint16 yDim)
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
      v->crd.ffd.x = x; v->crd.ffd.y = y1; v->crd.ffd.z = 0; v++;
      v->crd.ffd.x = x; v->crd.ffd.y = y2; v->crd.ffd.z = 0; v++;
    }
  }
  return (xDim)*(yDim-1)*2; // number of vertices
}

////////////////////////////////////////////////////////////////////////////////

static sint32 calcTriStripLinDDD(GenericVertex* v, sint16 w, sint16 h, sint16 xDim, sint16 yDim)
{
  // Calculates a mesh of (xDim-1)*(yDim-1)*2 triangles, using no shared vertices
  rfloat64 xStep = ((float32)w-1)/((float32)(xDim-1));
  rfloat64 yStep = ((float32)h-1)/((float32)(yDim-1));
  rfloat64 y1 = 0.5;
  rfloat64 y2 = y1 + yStep;
  for (rsint32 i=0; i<yDim-1; i++, y1+=yStep, y2+=yStep)
  {
    rfloat64 x = 0.5;
    for (rsint32 j=0; j<xDim; j++, x+=xStep)
    {
      v->crd.ddd.x = x; v->crd.ddd.y = y1; v->crd.ddd.z = 0; v++;
      v->crd.ddd.x = x; v->crd.ddd.y = y2; v->crd.ddd.z = 0; v++;
    }
  }
  return (xDim)*(yDim-1)*2; // number of vertices
}

////////////////////////////////////////////////////////////////////////////////

static sint32 calcTriStripLinUARGB(GenericVertex* v, sint16 w, sint16 h, sint16 xDim, sint16 yDim)
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
      float32 v1 = 1.0 - Clamp::real(radFact*sqrt((x*x)+(y1*y1)), 0.0, 1.0);
      float32 v2 = 1.0 - Clamp::real(radFact*sqrt((x*x)+(y2*y2)), 0.0, 1.0);

      if (j&1)
      {
        v->clr.uargb.a = (uint8)(255.0*v1);
        v->clr.uargb.r = 0;
        v->clr.uargb.g = (uint8)(255.0*v1);
        v->clr.uargb.b = 0;
        v++;
        v->clr.uargb.a = 0;
        v->clr.uargb.r = (uint8)(255.0*v2);
        v->clr.uargb.g = 0;
        v->clr.uargb.b = (uint8)(255.0*v2);
        v++;
      }
      else
      {
        v->clr.uargb.a = 0;
        v->clr.uargb.r = (uint8)(255.0*v1);
        v->clr.uargb.g = (uint8)(255.0*v1);
        v->clr.uargb.b = 0;
        v++;
        v->clr.uargb.a = (uint8)(255.0*v2);
        v->clr.uargb.r = 0;
        v->clr.uargb.g = 0;
        v->clr.uargb.b = (uint8)(255.0*v2);
        v++;
      }
    }
  }
  return (xDim)*(yDim-1)*2; // number of vertices
}

////////////////////////////////////////////////////////////////////////////////

static sint32 calcTriStripLinFARGB(GenericVertex* v, sint16 w, sint16 h, sint16 xDim, sint16 yDim)
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
        v->clr.fargb.a = v1;
        v->clr.fargb.r = 0;
        v->clr.fargb.g = v1;
        v->clr.fargb.b = 0;
        v++;
        v->clr.fargb.a = 0;
        v->clr.fargb.r = v2;
        v->clr.fargb.g = 0;
        v->clr.fargb.b = v2;
        v++;
      }
      else
      {
        v->clr.fargb.a = 0;
        v->clr.fargb.r = v1;
        v->clr.fargb.g = v1;
        v->clr.fargb.b = 0;
        v++;
        v->clr.fargb.a = v2;
        v->clr.fargb.r = 0;
        v->clr.fargb.g = 0;
        v->clr.fargb.b = v2;
        v++;
      }
    }
  }
  return (xDim)*(yDim-1)*2; // number of vertices
}

////////////////////////////////////////////////////////////////////////////////
/*
static void states1(Rasterizer* r)
{
  r->disable(G3D::TEXTURE);
  r->disable(G3D::PRESPECTIVE);
  r->disable(G3D::ZBUFTEST);
  r->disable(G3D::ZBUFWRITE);
}

static void states2(Rasterizer* r)
{
  r->disable(G3D::TEXTURE);
  r->disable(G3D::PRESPECTIVE);
  r->enable(G3D::ZBUFTEST);
  r->enable(G3D::ZBUFWRITE);
}

static void states3(Rasterizer* r)
{
  r->enable(G3D::TEXTURE);
  r->disable(G3D::PRESPECTIVE);
  r->disable(G3D::ZBUFTEST);
  r->disable(G3D::ZBUFWRITE);
}

static void states4(Rasterizer* r)
{
  r->enable(G3D::TEXTURE);
  r->disable(G3D::PRESPECTIVE);
  r->enable(G3D::ZBUFTEST);
  r->enable(G3D::ZBUFWRITE);
}
*/
////////////////////////////////////////////////////////////////////////////////
//
//  Types
//
////////////////////////////////////////////////////////////////////////////////

typedef void (*StateFunc)(Rasterizer* r);

typedef sint32 (*TestFunc)(GenericVertex* v, sint16 w, sint16 h, sint16 xDim, sint16 yDim);

struct STest {
  const char* name;
  StateFunc func;
};

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
/*
static STest sTestTab[] = {
  { "Texture [Off] Z [Off]", states1 },
  { "Texture [Off] Z [On]", states2 },
  { "Texture [Linear] Z [Off]", states3 },
  { "Texture [Linear] Z [On]", states4 }
};
*/
static VTest vTestTab[] = {
  { GenericVertex::XYZ_FFF,  "FFF",  calcTriStripLinFFF },
  { GenericVertex::XYZ_FFD,  "FFD",  calcTriStripLinFFD },
  { GenericVertex::XYZ_DDD,  "DDD",  calcTriStripLinDDD }
};

static CTest cTestTab[] = {
  { GenericVertex::CLR_URGB,  "RGB_U ",  calcTriStripLinUARGB },
  { GenericVertex::CLR_UBGR,  "BGR_U ",  0 },
  { GenericVertex::CLR_URGBA,  "RGBA_U",  0 },
  { GenericVertex::CLR_UARGB,  "ARGB_U",  0 },
  { GenericVertex::CLR_UBGRA,  "BGRA_U",  0 },
  { GenericVertex::CLR_FRGB,  "RGB_F ",  calcTriStripLinFARGB },
  { GenericVertex::CLR_FBGR,  "BGR_F ",  0 },
  { GenericVertex::CLR_FRGBA,  "RGBA_F",  0 },
  { GenericVertex::CLR_FARGB,  "ARGB_F",  0 },
  { GenericVertex::CLR_FBGRA,  "BGRA_F",  0 }
};

////////////////////////////////////////////////////////////////////////////////
//
//  Strings
//
////////////////////////////////////////////////////////////////////////////////

static const char* title      = "Warp3D Test : Triangle Strip Render %lu [%ld x %ld %s:%s]";
static const char* titleCalc  = "Warp3D Test : Triangle Strip Render [%ld x %ld] - Calculating %s";
static const char* logTxCull  = "Backface culled            : %2ld x %2ld %6ld tris/s\n";
static const char* logTxNorm  = "Colour Format %s       : %2ld x %2ld %6ld tris/s\n";

////////////////////////////////////////////////////////////////////////////////
//
//  Application Methods
//
////////////////////////////////////////////////////////////////////////////////

void TestWarp3D::measureTriStripLinear()
{
  appWindow->setTitle("Warp3D Test : Linear Triangle Strip Render Test");
  clear();

  Time estimated((sint64)
    (NUM_DIM*GenericVertex::_XYZ_NUM*(GenericVertex::_CLR_NUM+2)*minTestTime)
  );

  logFile->writeText("\n\nTriangle Strip Render [Array Linear] ");
  if (!SystemLib::dialogueBox(dBoxInfo, dBoxRunSkip,
    "Triangle Strip Render Test\n\n"
    "TestW3D will estimate the speed at which triangle strips can be\n"
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
            uint32 offs = 0, len = dimS<<1;
            timer.set();
            for (sint32 i=1; i<dimS; i++, offs+=len)
            {
              W3D_DrawArray(getRasterizerContext(gfx), W3D_PRIMITIVE_TRISTRIP, offs, len);
            }
            lockTime += timer.elapsedFrac();
            reps++;
          }
          gfx->unlock();
          totTime+=lockTime;
        }

        sprintf(info, title, (uint32)totTime, dimS, dimS, vTestTab[v].name, "Cull");
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

        // show test gfx preview
        gfx->lock();
        {
          uint32 offs = 0, len = dimS<<1;
          for (sint32 i=1; i<dimS; i++, offs+=len)
          {
            W3D_DrawArray(getRasterizerContext(gfx), W3D_PRIMITIVE_TRISTRIP, offs, len);
          }
        }
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
            uint32 offs = 0, len = dimS<<1;
            timer.set();
            for (sint32 i=1; i<dimS; i++, offs+=len)
            {
              W3D_DrawArray(getRasterizerContext(gfx), W3D_PRIMITIVE_TRISTRIP, offs, len);
            }
            lockTime += timer.elapsedFrac();
            reps++;
          }
          gfx->unlock();
          totTime+=lockTime;
        }

        sprintf(info, title, (uint32)totTime, dimS, dimS, vTestTab[v].name, "Flat");
        appWindow->setTitle(info);

        float64  trisPerSec = (1000.0*reps*(numVerts-3))/(totTime);

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
          {
            uint32 offs = 0, len = dimS<<1;
            for (sint32 i=1; i<dimS; i++, offs+=len)
            {
              W3D_DrawArray(getRasterizerContext(gfx), W3D_PRIMITIVE_TRISTRIP, offs, len);
            }
          }
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
              uint32 offs = 0, len = dimS<<1;
              timer.set();
              for (sint32 i=1; i<dimS; i++, offs+=len)
              {
                W3D_DrawArray(getRasterizerContext(gfx), W3D_PRIMITIVE_TRISTRIP, offs, len);
              }
              lockTime += timer.elapsedFrac();
              reps++;
            }
            gfx->unlock();
            totTime+=lockTime;
          }

          sprintf(info, title, (uint32)totTime, dimS, dimS, vTestTab[v].name, cTestTab[c].name);
          appWindow->setTitle(info);

          float64  trisPerSec = (1000.0*reps*(numVerts-3))/(totTime);

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
    sint32 pos = sprintf(text, "Render Triangle Strip (Linear)\n");
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
