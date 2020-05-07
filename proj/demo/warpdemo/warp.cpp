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
#define MIN_MESH   4
#define MAX_MESH   128
#define DEF_MESH  16

// Input filters
#define IRESPONSE (IFilter::IKEYNONPRINTPRESS|IFilter::IMOUSEPRESS|IFilter::IMOUSEDRAG)

class WarpApp : public AppBase, public InputFocus {
  private:

    char*                  strBuf;          // volatile string buffer
    InteractiveDisplay*    display;        // Display with InputDispatcher
    const char*            imageFileName;
    Rasterizer*            gfx;
    Texture*              tex;
    DrawVertex*            mesh;
    uint32*                indexBuffer;
    float32                scale;
    float32                warp;
    sint16                width;
    sint16                height;
    sint16                meshDim;
    bool                  redraw;
    bool                  drag;
    bool                  quit;
    bool                  showMesh;

  protected:
    // AppBase
    sint32  initApplication();
    sint32  runApplication();

    // InputFocus
    void    keyPressNonPrintable(InputDispatcher* src, Key::CtrlKey code);
    void    mousePress(InputDispatcher* src, uint32 keys);
    void    mouseDrag(InputDispatcher* src, sint16 x, sint16 y, sint16 dx, sint16 dy, uint32 keys);

    // this application
    void    updateTitle();
    void    initMesh();
    void    restoreMesh();
    void    warpMesh(float32 mx, float32 my, bool out);
    void    dragMesh(float32 mx, float32 my, float32 dx, float32 dy);
    void    unwarpMesh(float32 prop);
    void    zoomMesh(float32 factor);
    void    scrollMesh(sint16 x, sint16 y);
    void    rotateMesh(float32 ang);
    void    renderMesh();

  public:
    WarpApp();
    ~WarpApp();
};

////////////////////////////////////////////////////////////////////////////////

char version[] = "$VER: Warp 1.1 K. Churchill (25.1.2004)\n";

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

WarpApp::WarpApp() : InputFocus(IRESPONSE), display(0), mesh(0), tex(0), gfx(0),
                     warp(0.25F), drag(false), quit(false), showMesh(false)
{
  // Construct our application
  strBuf        = new(nothrow) char[128];

  // Get Commandline args
  scale          = Clamp::real(getFloat("scale", false), 1.0, 8.0);
  meshDim        = getInteger("mesh", false);
  imageFileName  = getString("image", false);

  if (meshDim == 0)
    meshDim = DEF_MESH;
  else
    meshDim = Clamp::integer(meshDim, MIN_MESH, MAX_MESH);

  display      = new(nothrow) InteractiveWindow(IRESPONSE);
  mesh        = new(nothrow) DrawVertex[meshDim*meshDim];
  indexBuffer  = new(nothrow) uint32[meshDim*meshDim];
}

////////////////////////////////////////////////////////////////////////////////

WarpApp::~WarpApp()
{
  // Cleanup and close
  delete    tex;
  delete    gfx;
  delete[]  mesh;
  delete[]  indexBuffer;
  delete    display;
  delete[]  strBuf;
}

////////////////////////////////////////////////////////////////////////////////

void WarpApp::updateTitle()
{
  if (drag)
  {
    sprintf(strBuf, "Warp %hd x %hd [D %3.2f] %s",
            meshDim, meshDim, warp, imageFileName);
  }
  else
  {
    sprintf(strBuf, "Warp %hd x %hd [Z %3.2f] %s",
            meshDim, meshDim, warp, imageFileName);
  }
  display->setTitle(strBuf);
}

////////////////////////////////////////////////////////////////////////////////

void WarpApp::keyPressNonPrintable(InputDispatcher* src, Key::CtrlKey code)
{
  // Respond to non printable key presses
  // This method overriden from InputFocus

  bool update = false;

  switch (code)
  {
    case Key::ESC:
      quit = true;
      break;

    case Key::F1:        restoreMesh();      update = true; redraw = true;  break;
    case Key::F2:        warp = 0.25F;        update = true;  break;
    case Key::F3:        warp *= 1.05F;      update = true;  break;
    case Key::F4:        warp /= 1.05F;      update = true;  break;
    case Key::F5:        unwarpMesh(0.025);  redraw = true;  break;
    case Key::F6:        if (drag) {
                          drag = false;
                          warp /= 8.0F;
                        }
                        else {
                          drag = true;
                          warp *= 8.0F;
                        }
                        update = true;
                        break;

    case Key::F7:        if (showMesh)
                          showMesh = false;
                        else
                          showMesh = true;
                        redraw = true;
                        break;

    case Key::NP_PLUS:  zoomMesh(1.025f);    redraw = true;  break;
    case Key::NP_MINUS:  zoomMesh(1.0f/1.025f);  redraw = true;  break;
    case Key::LEFT:      scrollMesh(-2, 0);  redraw = true;  break;
    case Key::RIGHT:    scrollMesh(2, 0);    redraw = true;  break;
    case Key::UP:        scrollMesh(0, -2);  redraw = true;  break;
    case Key::DOWN:      scrollMesh(0, 2);    redraw = true;  break;
    case Key::F9:        rotateMesh(-1.0f);  redraw = true;  break;
    case Key::F10:      rotateMesh(1.0f);    redraw = true;  break;
    default:
      break;
  }
  if (update)
    updateTitle();
}

////////////////////////////////////////////////////////////////////////////////

void WarpApp::mousePress(InputDispatcher* src, uint32 k)
{
  // Respond to mouse clicks, simply call the drag method
  // This method overriden from InputFocus
  mouseDrag(src, getMouseX(), getMouseY(), 0, 0, k);
}

////////////////////////////////////////////////////////////////////////////////

void WarpApp::mouseDrag(InputDispatcher* src, sint16 x, sint16 y, sint16 dx, sint16 dy, uint32 k)
{
  // Respond to mouse drags (movement with key pressed)
  // This method overriden from InputFocus
  if (drag)
  {
    dragMesh(x, y, dx, dy);
  }
  else
  {
    if (k & Mouse::KEYLEFT)
      warpMesh(x, y, false);
    if (k & Mouse::KEYRIGHT)
      warpMesh(x, y, true);
  }
  redraw = true;
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

  if (!(tex = Texture::convertImageBuffer(ImageLoader::loadImage(imageFileName), Texture::CONV_IB_DEL_ALWAYS))) {
    SystemLib::dialogueBox("Error", "Exit", "Failed to load image\n'%s'", imageFileName);
    return ERR_RSC_UNAVAILABLE;
  }
  else {
    width    = Clamp::integer((sint32)(scale*tex->getW()), 128, 1024);
    height  = Clamp::integer((sint32)(scale*tex->getH()), 128, 768);
  }

/*
  if (!eventRec || eventRec->open("ram:events.txt")!=OK)
  {
    SystemLib::dialogueBox("Error", "Exit", "Failed to create event log");
    return ERR_RSC_UNAVAILABLE;
  }
*/

  if (display->open(width, height , Pixel::BPP15, "Warp")!=OK) {
    SystemLib::dialogueBox("Error", "Exit", "Failed to open application window");
    return ERR_RSC_UNAVAILABLE;
  }

  updateTitle();


  gfx = G3D::getRasterizer(display->getDrawSurface());
  if (!gfx) {
    SystemLib::dialogueBox("Error", "Exit", "Failed to obtain Rasterizer");
    return ERR_RSC_UNAVAILABLE;
  }


  if (gfx->setVertices(mesh)!=true) {
    SystemLib::dialogueBox("Error", "Exit", "Failed to set vertex array");
    return ERR_RSC_UNAVAILABLE;
  }


  if (tex->associate(gfx)!=OK) {
    SystemLib::dialogueBox("Error", "Exit", "Failed to associate texture");
    return ERR_RSC_UNAVAILABLE;
  }


  // Initialise our mesh and texture

  initMesh();
  tex->setFilter(G3D::LINEAR);
  gfx->setTexture(tex);
  gfx->disable(G3D::CULLING);
  gfx->disable(G3D::GOURAUD);
  gfx->enable(G3D::TEXTURE);
  gfx->enable(G3D::DITHERING);
  gfx->setFlatColour(0xFFA0A0A0);

  // Draw the initial display
  renderMesh();

  // To get input, we need to register the InputFocus (the application)
  // with the InputDispatcher (our display)
  display->addFocus(this);
  //display->addFocus(eventRec); // our event recorder
  return OK;
}

////////////////////////////////////////////////////////////////////////////////

void WarpApp::initMesh()
{
  // This method sets up the default vertex mesh,
  register DrawVertex* p = mesh;
  float32 sx = (float32)width/(float32)(meshDim-1);
  float32 sy = (float32)height/(float32)(meshDim-1);
  float32 su = (float32)tex->getW()/(float32)(meshDim-1);
  float32 sv = (float32)tex->getH()/(float32)(meshDim-1);
  rfloat32 y = 0.0f;
  rfloat32 v = 0.0f;
  for (rsint32 row=0; row<meshDim; row++, y+=sy, v+=sv)
  {
    rfloat32 x = 0.0f;
    rfloat32 u = 0.0f;
    for (rsint32 col=0; col<meshDim; col++, x+=sx, u+=su, p++)
    {
      p->x = x; p->y = y; p->z = 0;
      p->w = 0; p->u = u; p->v = v;
    }
  }
  uint32* idx = indexBuffer;
  for (rsint32 col=0; col<meshDim; col++) {
    for (rsint32 row=0; row<meshDim; row++) {
      *idx++ = col+(row*meshDim);
    }
  }
}

////////////////////////////////////////////////////////////////////////////////

void WarpApp::warpMesh(float32 mx, float32 my, bool out)
{
  // This method warps the vertex mesh by pulling vertices towards the mouse
  // position (in) or pushing vertices away from the mouse position (out) by an
  // amount inverely proportional to the distance from the mouse position.
  register DrawVertex* p = mesh;
  for (rsint32 row=0; row<meshDim; row++)
  {
    for (rsint32 col=0; col<meshDim; col++, p++)
    {
      rfloat32 dx = mx-p->x;
      rfloat32 dy = my-p->y;
      rfloat32 scale = warp/sqrt((dx*dx)+(dy*dy));
      if (out)
        scale = -scale;
      p->x += (dx*scale);
      p->y += (dy*scale);
    }
  }
}

////////////////////////////////////////////////////////////////////////////////

void WarpApp::dragMesh(float32 mx, float32 my, float32 dx, float32 dy)
{
  // This method warps the vertex mesh by dragging the vertices in the
  // direction defined by (dx, dy) by an amount inverely proportional
  // to the distance from the mouse position.
  register DrawVertex* p = mesh;
  for (sint32 row=0; row<meshDim; row++)
  {
    for (sint32 col=0; col<meshDim; col++, p++)
    {
      float32 tx = mx-p->x;  tx *= tx;
      float32 ty = my-p->y;  ty *= ty;
      float32 scale = warp/sqrt(tx+ty);
      p->x += (dx*scale);
      p->y += (dy*scale);
    }
  }
}

////////////////////////////////////////////////////////////////////////////////

void WarpApp::restoreMesh()
{
  // This resets the vertices to their default positions.
  register DrawVertex* p = mesh;
  float32 sx = (float32)width/(float32)(meshDim-1);
  float32 sy = (float32)height/(float32)(meshDim-1);
  rfloat32 y = 0.0f;
  //rfloat32 v = 0.0f;
  for (rsint32 row=0; row<meshDim; row++, y+=sy)
  {
    rfloat32 x = 0.0f;
    //rfloat32 u = 0.0f;
    for (rsint32 col=0; col<meshDim; col++, x+=sx, p++)
    {
      p->x = x;
      p->y = y;
    }
  }
}

////////////////////////////////////////////////////////////////////////////////

void WarpApp::unwarpMesh(float32 prop)
{
  // This method unwarps the vertex mesh by moving the vertices gadually back
  // towards their default positions.
  register DrawVertex* p = mesh;
  float32 sx = (float32)width/(float32)(meshDim-1);
  float32 sy = (float32)height/(float32)(meshDim-1);
  rfloat32 y = 0.0f;
  //rfloat32 v = 0.0f;
  for (rsint32 row=0; row<meshDim; row++, y+=sy)
  {
    rfloat32 x = 0.0f;
    //rfloat32 u = 0.0f;
    for (rsint32 col=0; col<meshDim; col++, x+=sx, p++)
    {
      p->x = (1.0f-prop)*p->x + prop*x;
      p->y = (1.0f-prop)*p->y + prop*y;
    }
  }
}

////////////////////////////////////////////////////////////////////////////////

void WarpApp::scrollMesh(sint16 x, sint16 y)
{
  // This scrolls the mesh in the direction defined by x, y.
  register DrawVertex* p = mesh;
  rsint32 i = 1+meshDim*meshDim;
  while(--i)
  {
    p->x += x;
    p->y += y;
    p++;
  }
}

////////////////////////////////////////////////////////////////////////////////

void WarpApp::zoomMesh(float32 factor)
{
  // This zooms the mesh about the centre of the display by the factor given.
  register DrawVertex* p = mesh;
  rfloat32 cx = width/2;
  rfloat32 cy = height/2;

  rsint32 i = 1+meshDim*meshDim;
  while (--i)
  {
    p->x = cx + factor*(p->x-cx);
    p->y = cy + factor*(p->y-cy);
    p++;
  }
}

////////////////////////////////////////////////////////////////////////////////

void WarpApp::rotateMesh(float32 ang)
{
  float32 s = sin((PI/180)*ang);
  float32 c = cos((PI/180)*ang);

  register DrawVertex* p = mesh;
  rfloat32 cx = width/2;
  rfloat32 cy = height/2;
  rfloat32 tx, ty;
  rsint32 i = 1+meshDim*meshDim;
  while (--i)
  {
    tx = p->x-cx;
    ty = p->y-cy;
    p->x = cx + (c*tx + s*ty);
    p->y = cy + (-s*tx + c*ty);
    p++;
  }
}

////////////////////////////////////////////////////////////////////////////////

void WarpApp::renderMesh()
{
  // This method draws the mesh using the Rasterizer class drawTriMesh2()
  // method.
  if (gfx->lock())
  {
    if (showMesh)
      tex->setEnvironment(G3D::MODULATE);
    else
      tex->setEnvironment(G3D::REPLACE);

    gfx->clearDrawArea(Colour(0x00000000));  // clear the background
    gfx->drawTriMesh2(0, meshDim, meshDim);  // render the mesh
    if (showMesh) {
      uint32    ofs = 0;
      ruint32*  p = indexBuffer;
      gfx->setFlatColour(0x80FFFFFF);
      gfx->enable(G3D::BLENDING);
      gfx->disable(G3D::TEXTURE);
      for (rsint32 i=0; i<meshDim; i++, ofs+=meshDim) {
        gfx->drawLineStrip(ofs, meshDim);
      }
      for (rsint32 i=0; i<meshDim; i++, p+=meshDim) {
        gfx->drawLineStripIdx32(meshDim+1, p);
      }
      gfx->enable(G3D::TEXTURE);
      gfx->disable(G3D::BLENDING);
      gfx->setFlatColour(0xFFA0A0A0);
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

  while (!quit)
  {
    redraw = false;
    while (display->handleEvent())
      ;
    if (redraw)
      renderMesh();
    display->waitEvent();
  }

  return 0;
}