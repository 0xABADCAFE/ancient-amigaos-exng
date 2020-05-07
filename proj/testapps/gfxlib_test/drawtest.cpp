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
#include <systemlib/thread.hpp>
#include <systemlib/timer.hpp>
#include <gfxlib/gfx3d.hpp>
#include <gfxlib/gfxutil3d.hpp>
#include <gfxlib/gfxutil.hpp>

extern "C" {
  #include <math.h>
}

#define MESH_MIN 16
#define MESH_MAX 128
#define MESH_STP 16

class GfxTestApp : public AppBase {
  private:
    static char      text[64];
    char*            texName;
    MilliClock      timer;
    sint32          width;
    sint32          height;
    DisplayWindow*  appDisplay;
    Texture*        tex;
    Rasterizer*      gfx;
    DrawVertex*      vertices;
    bool            flat;
    bool            cull;
    bool            zbuff;
    void            genMesh(sint32 dx, sint32 dy);
    void            dumpPixelInfo(PixelDescriptor *pxl);
    void            testMesh1();
    void            testMesh2();

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

GfxTestApp::GfxTestApp() : appDisplay(0), gfx(0), vertices(0),
                           tex(0)
{
  texName    = (char*)getString("usetex", false);
  width      = Clamp::integer(getInteger("width", false), 320, 1024);
  height    = Clamp::integer(getInteger("height", false), 240, 768);
  flat      = getSwitch("flat", false);
  cull      = getSwitch("cull", false);
  zbuff      = getSwitch("zbuff", false);

  vertices  = new DrawVertex[MESH_MAX*MESH_MAX];
  appDisplay = new DisplayWindow();

  printf("\n\nRasterizer test application log file\n" \
         "----------------------------------------------\n");
}

////////////////////////////////////////////////////////////////////////////////

GfxTestApp::~GfxTestApp()
{
  if (tex)
    delete tex;
  if (gfx)
    delete gfx;
  if (vertices)
    delete[] vertices;
  if (appDisplay)
    delete appDisplay;
}

////////////////////////////////////////////////////////////////////////////////

void GfxTestApp::genMesh(sint32 dx, sint32 dy)
{
  dx = Clamp::integer(dx, MESH_MIN, MESH_MAX);
  dy = Clamp::integer(dy, MESH_MIN, MESH_MAX);

  sprintf(text, "Calculating mesh %ld x %ld...", dx, dy);
  appDisplay->setTitle(text);

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

      p->w = 0; p->u = fx; p->v = fy;
      if ((x&1)^(y&1))
      {
        Colour tmpc = 0xFF000000 | (uint32)(255.0*(fx/(float32)width));
        tmpc.scale(p->z);
        p->colour = (uint32)tmpc | (uint32)(128.0*(fx/(float32)width))<<8;
      }
      else
      {
        Colour tmpc = 0xFF000000 | ((uint32)(255.0*(fx/(float32)width)))<<16;
        tmpc.scale(p->z);
        p->colour = (uint32)tmpc | (uint32)(64.0*(fx/(float32)width))<<8;
      }
      p++;
    }
  }
}

////////////////////////////////////////////////////////////////////////////////

void GfxTestApp::testMesh1()
{
  uint32 timeTaken;

  printf("Row   Col   Draw Area    Time   Tris/s  MPix/s\n" \
         "----------------------------------------------\n");

  for (sint32 i=MESH_MIN; i<=MESH_MAX; i+=MESH_STP)
  {
    genMesh(i, i);
    sprintf(text, "Drawing %ld x %ld...", i, i);
    appDisplay->setTitle(text);
    if (gfx->lock())
    {
      timer.set();
      gfx->drawTriMesh(0, i, i);
      timeTaken = timer.elapsed();
      gfx->flush();
      gfx->unlock();
      appDisplay->refresh();
    }

    uint32 tris = (uint32)((1000f*2*(i-1)*(i-1))/(float32)timeTaken);
    float32 mpx = (width*height)/((float32)timeTaken*1000f);

    printf("%3ld x %3ld %5ld x %3ld %4lu ms %8lu %8.4f\n", i, i, \
            width, height, timeTaken, tris, mpx);

/*
    printf("%3ld x %3ld %5ld x %3ld %4lu ms %8lu %8.4f 0x%08x\n", i, i, \
            width, height, timeTaken, tris, mpx, gfx->getW3DResult());
*/
  }
}

////////////////////////////////////////////////////////////////////////////////

void GfxTestApp::testMesh2()
{
  uint32 timeTaken;


  printf("Row   Col   Draw Area    Time   Tris/s  MPix/s\n" \
         "----------------------------------------------\n");
//printf(" 16 x  16   160 x 120    8 ms    56250  2.4000");

  for (sint32 i=MESH_MIN; i<=MESH_MAX; i+=MESH_STP)
  {
    genMesh(i, i);
    sprintf(text, "Drawing %ld x %ld...", i, i);
    appDisplay->setTitle(text);
    if (gfx->lock())
    {
      timer.set();
      gfx->drawTriMesh2(0, i, i);
      timeTaken = timer.elapsed();
      gfx->flush();
      gfx->unlock();
      appDisplay->refresh();
    }

    uint32 tris = (uint32)((1000f*2*(i-1)*(i-1))/(float32)timeTaken);
    float32 mpx = (width*height)/((float32)timeTaken*1000f);

    printf("%3ld x %3ld %5ld x %3ld %4lu ms %8lu %8.4f\n", i, i, \
            width, height, timeTaken, tris, mpx);
/*
    printf("%3ld x %3ld %5ld x %3ld %4lu ms %8lu %8.4f 0x%08x\n", i, i, \
            width, height, timeTaken, tris, mpx, gfx->getW3DResult());
*/
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
  if (!appDisplay)
  {
    //SystemLib::dialogueBox("Error", "Exit", "Unable to create window");
    puts("***error: Unable to create window");
    return ERR_RSC_UNAVAILABLE;
  }
  if (!vertices)
  {
    //SystemLib::dialogueBox("Error", "Exit", "Unable to allocate vertex buffer");
    puts("***error: Unable to allocate vertex buffer");
    return ERR_RSC_UNAVAILABLE;
  }

  if (appDisplay->open(width, height, Pixel::BPP15, "DrawTest")!=OK)
  {
    //SystemLib::dialogueBox("Error", "Exit", "Unable to open window");
    puts("***error: Unable to open window");
    return ERR_RSC_UNAVAILABLE;
  }

  if ( !(gfx = G3D::getRasterizer(appDisplay->getDrawSurface())) )
  {
    //SystemLib::dialogueBox("Error", "Exit", "Failed to obtain Rasterizer");
    puts("***error: Unable to obtain Rasterizer");
    return ERR_RSC_UNAVAILABLE;
  }

  if (zbuff)
  {
    if (gfx->createZBuffer()==false)
    {
      puts("\n***warning: unable to allocate z buffer\n");
      zbuff = false;
    }
  }

  if (texName)
  {
    tex  = new Texture;
    if (TextureLoader::loadPPM(tex, texName, G3D::TXL_ARGB32)!=OK)
    {
      printf("***warning: Failed to load image %s\n", texName);
      delete tex;
      tex = 0;
    }
  }

  if (tex && (tex->associate(gfx)!=OK))
  {
    SystemLib::dialogueBox("Error", "Exit", "Unable to associate Texture");
    puts("***error: Failed to associate texture");
    return ERR_RSC_UNAVAILABLE;
  }

  return OK;
}
////////////////////////////////////////////////////////////////////////////////

sint32 GfxTestApp::runApplication()
{
  gfx->setVertices(vertices);

  printf("Display Properties\nWidth: %d, Height: %d, Modulus: %d\n", width, height, \
          appDisplay->getDrawSurface()->getModulus());

  printf("\nPixel format\n");
  dumpPixelInfo(appDisplay->getDrawSurface()->getDescriptor());

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
    printf("on (LESS/UPDATE)");
  }
  else
  {
    printf("off");
  }

  printf(", tex:");
  if (tex)
  {
    tex->setEnvironment(G3D::MODULATE);
    gfx->enable(G3D::TEXTURE);
    gfx->setTexture(tex);
    printf("%s\n", texName);
  }
  else
  {
    printf("none\n");
  }

  if (gfx->lock())
  {
    gfx->clearDrawArea(0x000000);
    if (zbuff)
      gfx->clearZBuffer(1.0);
    gfx->flush();
    gfx->unlock();
    appDisplay->refresh();
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
    appDisplay->refresh();
  }

  printf("\nTesting Rasterizer::drawTriMesh2()\n\n");
  testMesh2();

  appDisplay->setTitle("Tests completed");

  Thread::sleep(1000);
  return 0;
}

////////////////////////////////////////////////////////////////////////////////

