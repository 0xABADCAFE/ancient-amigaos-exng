//****************************************************************************//
//**                                                                        **//
//** File:         prj/gfxTest/drawtest.cpp                                 **//
//** Description:  Rasterizer test application                              **//
//** Comment(s):                                                            **//
//** Created:      2003-04-30                                               **//
//** Updated:      2003-09-22                                               **//
//** Author(s):    Karl Churchill                                           **//
//** Note(s):                                                               **//
//** Copyright:    (C)1996-2003, eXtropia Studios                           **//
//**               Serkan YAZICI, Karl Churchill                            **//
//**               All Rights Reserved.                                     **//
//**                                                                        **//
//****************************************************************************//

#include <xbase.hpp>
#include <gfxlib/gfxapp.hpp>
#include <gfxlib/gfxutil.hpp>
#include <gfxlib/gfx3d.hpp>
#include <gfxlib/gfxutil3d.hpp>

#include <new.h>

extern "C" {
  #include <math.h>
};

////////////////////////////////////////////////////////////////////////////////
//
//  WarpApp
//
//  Distorts an image in a manner similar to goo.
//
//  Loads a simple ppm image (restrictions apply, size must be 2^x * 2^y) and
//  applies it to a vertex mesh, defined in screen space.
//
//  A Rasterizer is used to render the mesh into our Display. Mouse and key
//  input from the user are handled by the application to deform and restore
//  the mesh.
//
////////////////////////////////////////////////////////////////////////////////

// Mesh limits

#define MAX_TESS 6
#define MIN_TESS 1
#define DEF_TESS 3

// Input filters
#define IRESPONSE (IFilter::IKEYNONPRINTPRESS)

class WarpApp : public AppBase, public InputFocus {
  private:

    char*                  strBuf;          // volatile string buffer
    InteractiveDisplay*    display;        // Display with InputDispatcher
    const char*            imageFileName;
    const char*            lightFileName;
    Rasterizer*            gfx;
    Texture*              colourMap;
    Texture*              alphaMap;
    ImageBuffer*          lightMap;
    DrawVertex*            polygon;
    DrawVertex*            mesh;
    uint32*                indexBuffer;
    float32                scale;
    sint16                tess;
    sint16                width;
    sint16                height;
    sint16                meshDim;
    struct {
      bool  redraw : 1;
      bool  showTex : 1;
      bool  showLight : 1;
      bool  shadeLight : 1;
      bool  showMesh : 1;
      bool  quit : 1;
    } flags;
    void                  createAlphaMap();

  protected:
    // AppBase
    sint32  initApplication();
    sint32  runApplication();

    // InputFocus
    void    keyPressNonPrintable(InputDispatcher* src, Key::CtrlKey code);

    // this application
    void    updateTitle();
    void    initMesh();
    void    render();

  public:
    WarpApp();
    ~WarpApp();
};

////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////

sint32 AppBase::init()
{
  // Do any library initialisation prior to application creation
  return GfxLib::init();
}

////////////////////////////////////////////////////////////////////////////////

void AppBase::done()
{
  // Do any library cleanup after application exit
  GfxLib::done();
}

////////////////////////////////////////////////////////////////////////////////

AppBase* AppBase::createApplicationInstance()
{
  // Create our application object
  return new(nothrow) WarpApp;
}

////////////////////////////////////////////////////////////////////////////////

void AppBase::destroyApplicationInstance(AppBase* app)
{
  // Destroy our application object
  delete app;
}

////////////////////////////////////////////////////////////////////////////////

#define MAX_VERTS ((1<<MAX_TESS)*(1<<MAX_TESS))

WarpApp::WarpApp() : InputFocus(IRESPONSE), display(0), polygon(0), colourMap(0), gfx(0)
{
  // Construct our application
  strBuf        = new(nothrow) char[128];

  // Get Commandline args
  scale          = Clamp::real(getFloat("scale", false), 1.0, 8.0);
  tess          = DEF_TESS;

  imageFileName  = getString("image", false);
  lightFileName  = getString("light", false);

  if (!imageFileName)
    imageFileName = "data/texture.ppm";
  if (!lightFileName)
    lightFileName = "data/lightmap128.png";

  display      = new(nothrow) InteractiveWindow(IRESPONSE);
  colourMap    = new(nothrow) Texture;
  alphaMap    = new(nothrow) Texture;
  polygon      = new(nothrow) DrawVertex[MAX_VERTS+4];
  indexBuffer  = new(nothrow) uint32[MAX_VERTS];
  mesh        = polygon+4;
  lightMap    = ImageLoader::loadImage(lightFileName);

  flags.showTex = true;
  flags.showLight = true;
  flags.shadeLight = true;
  flags.showMesh = true;
  flags.quit = false;
}

////////////////////////////////////////////////////////////////////////////////

WarpApp::~WarpApp()
{
  // Cleanup and close
  delete    colourMap;
  delete    alphaMap;
  delete    lightMap;
  delete    gfx;
  delete[]  polygon;
  delete[]  indexBuffer;
  delete    display;
  delete[]  strBuf;
}

////////////////////////////////////////////////////////////////////////////////

void WarpApp::createAlphaMap()
{
  if (lightMap && alphaMap) {
    // the ImageBuffer should be ARGB32. We should really check this
    Colour* clr = (Colour*)lightMap->getData();
    if (clr) {
      alphaMap->create(lightMap->getW(), lightMap->getH(), G3D::TXL_ARGB32);
      uint32* alpha = (uint32*)alphaMap->getData();
      if (alpha) {
        printf("Creating inverse alpha map for lightmap...");
        sint32 i = lightMap->getW()*lightMap->getH();
        while (i--) {
          *alpha++ = (255 - Clamp::integer((clr++)->getIntensity(), 0, 255))<<24;
        }
        printf("done\n");
      }
    }
  }
}

void WarpApp::updateTitle()
{
  sprintf(strBuf, "Test %hd x %hd, Tex : %s, Lit : %s, Shd: %s",
    meshDim, meshDim,
    (flags.showTex ? "On" : "Off"),
    (flags.showLight ? "On" : "Off"),
    (flags.shadeLight ? "On" : "Off")
  );
  display->setTitle(strBuf);
}

////////////////////////////////////////////////////////////////////////////////

void WarpApp::keyPressNonPrintable(InputDispatcher* src, Key::CtrlKey code)
{
  // Respond to non printable key presses
  // This method overriden from InputFocus
  bool update = true;
  switch (code)
  {
    case Key::ESC:  flags.quit = true;
      break;

    case Key::F1:
      flags.showTex = !flags.showTex;
      flags.redraw = true;
      break;

    case Key::F2:
      flags.showLight = !flags.showLight;
      flags.redraw = true;
      break;

    case Key::F3:
      flags.shadeLight = !flags.shadeLight;
      flags.redraw = true;
      break;

    case Key::F4:
      flags.showMesh = !flags.showMesh;
      flags.redraw = true;
      break;

    case Key::F5:
      tess = Clamp::integer(++tess, MIN_TESS, MAX_TESS);
      initMesh();
      flags.redraw = true;
      break;

    case Key::F6:
      tess = Clamp::integer(--tess, MIN_TESS, MAX_TESS);
      initMesh();
      flags.redraw = true;
      break;

    default:
      update = false;
      break;
  }
  if (update)
    updateTitle();
}

////////////////////////////////////////////////////////////////////////////////

sint32 WarpApp::initApplication()
{
  // This method performs any post construction initialisation
  // This method overidden from AppBase

  if (!strBuf) {
    SystemLib::dialogueBox("Error", "Exit", "Failed to create string buffer");
    return ERR_RSC_UNAVAILABLE;
  }

  if (!mesh) {
    SystemLib::dialogueBox("Error", "Exit", "Failed to create mesh");
    return ERR_RSC_UNAVAILABLE;
  }

  if (!display) {
    SystemLib::dialogueBox("Error", "Exit", "Failed to create application window");
    return ERR_RSC_UNAVAILABLE;
  }

  if (!lightMap) {
    SystemLib::dialogueBox("Error", "Exit", "Failed to load RGB lightmap");
    return ERR_RSC_UNAVAILABLE;
  }

  if (!colourMap) {
    SystemLib::dialogueBox("Error", "Exit", "Failed to create texture");
    return ERR_RSC_UNAVAILABLE;
  }

  if (TextureLoader::loadPPM(colourMap, imageFileName, G3D::TXL_ARGB32)!=OK) {
    SystemLib::dialogueBox("Error", "Exit", "Failed to load image\n'%s'", imageFileName);
    return ERR_RSC_UNAVAILABLE;
  }
  else {
    width    = Clamp::integer((sint32)(scale*colourMap->getW()), 128, 1024);
    height  = Clamp::integer((sint32)(scale*colourMap->getH()), 128, 768);
  }

  createAlphaMap();

  if (display->open(width, height, Pixel::BPP15, "Test")!=OK) {
    SystemLib::dialogueBox("Error", "Exit", "Failed to open application window");
    return ERR_RSC_UNAVAILABLE;
  }

  updateTitle();

  gfx = G3D::getRasterizer(display->getDrawSurface());
  if (!gfx) {
    SystemLib::dialogueBox("Error", "Exit", "Failed to obtain Rasterizer");
    return ERR_RSC_UNAVAILABLE;
  }

  if (gfx->setVertices(polygon)!=true) {
    SystemLib::dialogueBox("Error", "Exit", "Failed to set vertex array");
    return ERR_RSC_UNAVAILABLE;
  }

  if (colourMap->associate(gfx)!=OK) {
    SystemLib::dialogueBox("Error", "Exit", "Failed to associate texture");
    return ERR_RSC_UNAVAILABLE;
  }

  if (alphaMap->associate(gfx)!=OK) {
    SystemLib::dialogueBox("Error", "Exit", "Failed to associate light map");
    return ERR_RSC_UNAVAILABLE;
  }

  // Initialise our mesh and texture

  initMesh();
  colourMap->setFilter(G3D::LINEAR);
  colourMap->setEnvironment(G3D::MODULATE);

  alphaMap->setFilter(G3D::LINEAR);
  alphaMap->setEnvironment(G3D::REPLACE);

  gfx->enable(G3D::TEXTURE);
  gfx->enable(G3D::DITHERING);
  gfx->setFlatColour(0xFFFFFFFF);

  // Draw the initial display
  render();

  // To get input, we need to register the InputFocus (the application)
  // with the InputDispatcher (our display)
  display->addFocus(this);
  //display->addFocus(eventRec); // our event recorder
  return OK;
}

////////////////////////////////////////////////////////////////////////////////

void WarpApp::initMesh()
{
  // initialise the polygon. This is actually used to render the alpha map
  polygon[0].x=0.0f;
  polygon[0].y=0.0f;
  polygon[0].u=0.0f;
  polygon[0].v=0.0f;

  polygon[1].x=(float32)width;
  polygon[1].y=0.0f;
  polygon[1].u=(float32)alphaMap->getW();
  polygon[1].v=0.0f;

  polygon[2].x=0.0f;
  polygon[2].y=(float32)height;
  polygon[2].u=0.0f;
  polygon[2].v=(float32)alphaMap->getH();

  polygon[3].x=(float32)width;
  polygon[3].y=(float32)height;
  polygon[3].u=(float32)alphaMap->getW();
  polygon[3].v=(float32)alphaMap->getH();

  meshDim = 1<<tess;

  // initialise the mesh. This is actually used to render the texture, with
  // vertex sampled colours from the original light map
  DrawVertex* p = mesh;
  float32 sx = (float32)width/(float32)(meshDim-1);
  float32 sy = (float32)height/(float32)(meshDim-1);
  float32 su = (float32)colourMap->getW()/(float32)(meshDim-1);
  float32 sv = (float32)colourMap->getH()/(float32)(meshDim-1);

  float32 csx = (float32)(lightMap->getW()-1)/(float32)(meshDim-1);
  float32 csy = (float32)(lightMap->getH()-1)/(float32)(meshDim-1);

  float32 y = 0.0f;
  float32 v = 0.0f;
  float32 cy = 0.0f;

  Colour* clr = (Colour*)lightMap->getData();
  uint32* alp = (uint32*)alphaMap->getData();
  for (rsint32 row=0; row<meshDim; row++, y+=sy, v+=sv, cy+=csy) {
    float32 x = 0.0f;
    float32 u = 0.0f;
    float32 cx = 0.0f;
    for (rsint32 col=0; col<meshDim; col++, x+=sx, u+=su, cx+=csx, p++)
    {
      p->x = x; p->y = y; p->z = 0;
      p->w = 0; p->u = u; p->v = v;

      sint32 lightTexel = (((sint32)cy)*lightMap->getW())+((sint32)cx);
      Colour c = clr[lightTexel];
      uint32 a = alp[lightTexel]>>24;
      if (a>0)
        c.scale(255.0 / (float32)a);
      p->colour = c;
    }
  }
  uint32* idx = indexBuffer;
  for (rsint32 col=0; col<meshDim; col++) {
    for (rsint32 row=0; row<meshDim; row++) {
      *idx++ = col+(row*meshDim)+4; // mesh follows polygon on vertex buffer
    }
  }
}

////////////////////////////////////////////////////////////////////////////////

void WarpApp::render()
{
  // This method draws the mesh using the Rasterizer class drawTriMesh2()
  // method.
  if (gfx->lock())
  {
    gfx->clearDrawArea(Colour(0x00FFFFFF));  // clear the background
    gfx->disable(G3D::BLENDING);
    if (flags.showTex) {
      gfx->setTexture(colourMap);
      gfx->enable(G3D::TEXTURE);
    }
    else
      gfx->disable(G3D::TEXTURE);

    if (flags.shadeLight) {
      colourMap->setEnvironment(G3D::MODULATE);
      gfx->enable(G3D::GOURAUD);
    }
    else {
      colourMap->setEnvironment(G3D::REPLACE);
      gfx->disable(G3D::GOURAUD);
    }

    gfx->drawTriMesh2(4, meshDim, meshDim);  // render the texture on shaded mesh

    if (flags.showLight) {
      gfx->setTexture(alphaMap);
      gfx->enable(G3D::TEXTURE);
      gfx->enable(G3D::BLENDING);
      gfx->disable(G3D::GOURAUD);
      gfx->drawTriStrip(0, 4);  // render the alpha lightmap (simple tristrip)
    }

    if (flags.showMesh) {
      gfx->disable(G3D::BLENDING);
      gfx->disable(G3D::TEXTURE);
      gfx->disable(G3D::GOURAUD);
      uint32  ofs = 4;
      uint32*  p = indexBuffer;
      for (rsint32 i=0; i<meshDim; i++, ofs+=meshDim) {
        gfx->drawLineStrip(ofs, meshDim);
      }
      for (rsint32 i=0; i<meshDim; i++, p+=meshDim) {
        gfx->drawLineStripIdx32(meshDim+1, p);
      }
    }
    gfx->flush();                            // flush the frame
    gfx->unlock();
    display->refresh();                      // refresh the display
  }
}

////////////////////////////////////////////////////////////////////////////////

sint32 WarpApp::runApplication()
{
  // The main event loop here.
  // This method overriden from AppBase

  while (!flags.quit)
  {
    flags.redraw = false;
    while (display->handleEvent())
      ;
    if (flags.redraw)
      render();
    display->waitEvent();
  }

  return 0;
}