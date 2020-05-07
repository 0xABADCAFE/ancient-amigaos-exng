//****************************************************************************//
//**                                                                        **//
//** File:         prj/gfxTest/drawtest.cpp                                 **//
//** Description:  Rasterizer test application                              **//
//** Comment(s):                                                            **//
//** Created:      2003-04-30                                               **//
//** Updated:      2003-04-30                                               **//
//** Author(s):    Karl Churchill                                           **//
//** Note(s):                                                               **//
//** Copyright:    (C)1996-2003, eXtropia Studios                           **//
//**               Serkan YAZICI, Karl Churchill                            **//
//**               All Rights Reserved.                                     **//
//**                                                                        **//
//****************************************************************************//

#include <xbase.hpp>
#include <SystemLib/timer.hpp>
#include <GfxLib/gfxapp.hpp>
#include <gfxLib/gfx3d.hpp>

extern "C" {
  #include <math.h>
}

#define MESH_MIN 16
#define MESH_MAX 128
#define MESH_STP 16

class GfxTestApp : public AppBase, public DisplayWindow {
  private:
    static char  text[64];
    MilliClock  timer;
    sint32      width;
    sint32      height;

    Rasterizer*  gfx;
    DrawVertex*  vertices;
    bool        quit;
    bool        flat;
    bool        cull;
    bool        zbuff;

    void        genMesh(sint32 dx, sint32 dy);
    void        dumpPixelInfo(PixelDescriptor *pxl);
    void        testMesh1();
    void        testMesh2();

    void        drawTest(sint16 w, sint16 h);

  protected:
    // AppBase
    sint32  initApplication();
    sint32  runApplication();

  public:
    GfxTestApp();
    ~GfxTestApp();
};

char GfxTestApp::text[64] = {0};

////////////////////////////////////////////////////////////////////////////////

//  AppBase::

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

GfxTestApp::GfxTestApp() : DisplayWindow(), gfx(0), vertices(0), quit(false)
{
  width    = Clamp::integer(getInteger("width", false), 160, 1024);
  height  = Clamp::integer(getInteger("height", false), 120, 768);
  flat    = getSwitch("flat", false);
  cull    = getSwitch("cull", false);
  zbuff    = getSwitch("zbuff", false);
  printf("\n\nRasterizer test application log file\n" \
         "----------------------------------------------\n");

}

////////////////////////////////////////////////////////////////////////////////

GfxTestApp::~GfxTestApp()
{
  if (gfx)
  {
    delete gfx;
  }
  if (vertices)
    delete[] vertices;
  close();
}

////////////////////////////////////////////////////////////////////////////////

void GfxTestApp::genMesh(sint32 dx, sint32 dy)
{
  dx = Clamp::integer(dx, MESH_MIN, MESH_MAX);
  dy = Clamp::integer(dy, MESH_MIN, MESH_MAX);

  sprintf(text, "Calculating mesh %ld x %ld...", dx, dy);
  setTitle(text);

  float32 nx = 4.0*PI/(float32)width;
  float32 ny = 4.0*PI/(float32)height;

  float32 sx = ((float32)width)/(float32)(dx-1);
  float32 sy = ((float32)height)/(float32)(dy-1);
  float32 fy = 0.0;
  DrawVertex* p = vertices;
  for (sint32 y=0; y<dy; y++, fy+=sy)
  {
    float32 fx = 0.0;
    for (sint32 x=0; x<dx; x++, fx+=sx)
    {
      p->x = fx; p->y = fy;

      // Do a nice radial pattern for z/colour
      float32 tmpx = nx*(fx - 0.5*(float32)width);
      float32 tmpy = ny*(fy - 0.5*(float32)height);
      p->z = 0.5 + (0.45*cos((tmpx*tmpx)+(tmpy*tmpy)));

      p->w = 0; p->u = 0; p->v = 0;
      if ((x&1)^(y&1))
      {
        Colour tmpc = 0xFF0000FF;
        tmpc.scale(p->z);
        p->colour = (uint32)tmpc;
      }
      else
      {
        Colour tmpc = 0xFF00FFFF;
        tmpc.scale(p->z);
        p->colour = (uint32)tmpc;
      }
      p++;
    }
  }
}

////////////////////////////////////////////////////////////////////////////////

void GfxTestApp::testMesh1()
{
  uint32 timeTaken;

  printf("Row   Col   Draw Area    Time   Tris/s    MPix/s\n" \
         "------------------------------------------------\n");

  for (sint32 i=MESH_MIN; i<=MESH_MAX; i+=MESH_STP)
  {
    genMesh(i, i);
    sprintf(text, "Drawing %ld x %ld...", i, i);
    setTitle(text);
    if (gfx->lock())
    {
      timer.set();
      gfx->drawTriMesh(0, i, i);
      timeTaken = timer.elapsed();
      gfx->flush();
      gfx->unlock();
      refresh();
    }

    uint32 tris = (uint32)((1000f*2*(i-1)*(i-1))/(float32)timeTaken);
    float32 mpx = (width*height)/((float32)timeTaken*1000f);

    printf("%3ld x %3ld %5ld x %3ld %4lu ms %8lu %10.4f\n", i, i, \
            width, height, timeTaken, tris, mpx);
  }
}

////////////////////////////////////////////////////////////////////////////////

void GfxTestApp::testMesh2()
{
  uint32 timeTaken;


  printf("Row   Col   Draw Area    Time   Tris/s    MPix/s\n" \
         "------------------------------------------------\n");
//printf(" 16 x  16   160 x 120    8 ms    56250    2.4000");

  for (sint32 i=MESH_MIN; i<=MESH_MAX; i+=MESH_STP)
  {
    genMesh(i, i);
    sprintf(text, "Drawing %ld x %ld...", i, i);
    setTitle(text);
    if (gfx->lock())
    {
      timer.set();
      gfx->drawTriMesh2(0, i, i);
      timeTaken = timer.elapsed();
      gfx->flush();
      gfx->unlock();
      refresh();
    }

    uint32 tris = (uint32)((1000f*2*(i-1)*(i-1))/(float32)timeTaken);
    float32 mpx = (width*height)/((float32)timeTaken*1000f);

    printf("%3ld x %3ld %5ld x %3ld %4lu ms %8lu %10.4f\n", i, i, \
            width, height, timeTaken, tris, mpx);
  }
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

sint32 GfxTestApp::initApplication()
{
  vertices = new DrawVertex[MESH_MAX*MESH_MAX];
  if (!vertices)
  {
    X_ERROR("Failed to allocate vertices");
    return ERR_RSC_UNAVAILABLE;
  }

  if (open(width, height, Pixel::BPP16, "DrawTest")!=OK)
  {
    X_ERROR("Failed to open() display");
    return ERR_RSC_UNAVAILABLE;
  }

  gfx = new Rasterizer;
  if (!gfx)
  {
    X_ERROR("Failed to instansiate Rasterizer");
    return ERR_RSC_UNAVAILABLE;
  }

  if (gfx->create(getDrawSurface())!=OK)
  {
    X_ERROR("Failed to configure Rasterizer");
    return ERR_RSC_UNAVAILABLE;
  }

  if (zbuff)
  {
    if (gfx->createZBuffer()==false)
    {
      printf("\nWarning : unable to allocate z buffer\n");
      zbuff = false;
    }
  }

  return OK;
}
////////////////////////////////////////////////////////////////////////////////

sint32 GfxTestApp::runApplication()
{
  gfx->setVertices(vertices);

  printf("Display Properties\nWidth: %d, Height: %d, Modulus: %d\n", width, height, \
          getDrawSurface()->getModulus());

  printf("\nPixel format\n");
  dumpPixelInfo(getDrawSurface()->getDescriptor());

  printf("\nStates shade:");
  if (flat)
  {
    gfx->disable(G3D::GOURAUD);
    printf("flat");
  }
  else
  {
    gfx->enable(G3D::GOURAUD);
    printf("gouraud");
  }

  printf(", cull:");
  if (cull)
  {
    gfx->setFront(G3D::FRONT_CCW);
    gfx->enable(G3D::CULLING);
    printf("on (CCW)");
  }
  else
  {
    gfx->disable(G3D::CULLING);
    printf("off");
  }

  printf(", zbuff:");
  if (zbuff)
  {
    gfx->enable(G3D::ZBUFTEST);
    gfx->enable(G3D::ZBUFWRITE);
    gfx->setZTest(G3D::ZTEST_LT);
    printf("on (LESS/UPDATE)\n");
  }
  else
  {
    printf("off\n");
  }

  if (gfx->lock())
  {
    gfx->clearDrawArea(0x000000);
    if (zbuff)
      gfx->clearZBuffer(1.0);
    gfx->flush();
    gfx->unlock();
    refresh();
  }

  printf("\nTesting Rasterizer::drawTriMesh()\n\n");
  testMesh1();

  if (gfx->lock())
  {
    gfx->clearDrawArea(0x000000);
    if (zbuff)
      gfx->clearZBuffer(1.0);
    gfx->flush();
    gfx->unlock();
    refresh();
  }

  printf("\nTesting Rasterizer::drawTriMesh2()\n\n");
  testMesh2();

  setTitle("completed");

  return 0;
}

////////////////////////////////////////////////////////////////////////////////

