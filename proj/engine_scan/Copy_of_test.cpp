
#include <new>
#include <xbase.hpp>
#include <systemlib/timer.hpp>
#include <gfxlib/gfxapp.hpp>

extern "C" {
  #include <string.h>
  #include <math.h>
}

#define MAP_DIM 8
#define MAP_W (1<<MAP_DIM)
#define MAP_H (1<<MAP_DIM)

///////////////////////////////////////////////////////////////////////////////

inline sint32 qabs(sint32 v)
{
  return v<0 ? -v : v;
}

class WorldMap {
  private:
    uint32        markCount;
    ImageBuffer*  image;

    void setCell(sint16 x, sint16 y, uint32 c)
    {
      if (x>=0 && x<MAP_W && y>=0 && y<MAP_H) {
        uint32* p = (uint32*)(image->getData());
        *(p+(y<<MAP_DIM)+x) = c;
      }
    }

    void markCellRow(S_2CRD);

  public:
    void setCoord(sint16 x, sint16 y, uint32 c)
    {
      // set a cartesian map point. This is inverted vertically
      // compared to a raster image
      y = MAP_H - y;
      setCell(x,y,c);
    }

    ImageBuffer* getImage()
    {
      return image;
    }

    sint32 markCells(sint16 tlX, sint16 tlY, sint16 trX, sint16 trY, sint16 blX, sint16 blY, sint16 brX, sint16 brY);

    void clearCells()
    {
      Mem::set32(image->getData(), 0xFFFFFFFF, MAP_W*MAP_H);
    }

    WorldMap() : markCount(0), image(0)
    {
      if (image = new(nothrow) ImageBuffer) {
        if (image->create(MAP_W, MAP_H, Pixel::ARGB32B)==OK) {
          Mem::set32(image->getData(), 0xFFFFFFFF, MAP_W*MAP_H);
        } else {
          delete image;
          image = 0;
        }
      }
    }
    ~WorldMap()
    {
      delete image;
    }
};

sint32 WorldMap::markCells(sint16 tlX, sint16 tlY, sint16 trX, sint16 trY, sint16 blX, sint16 blY, sint16 brX, sint16 brY)
{
  markCount++;

  // coordinates are cartesian, convert y ordinates to corresponding raster ordinates
  tlY = MAP_H - tlY;
  trY = MAP_H - trY;
  blY = MAP_H - blY;
  brY = MAP_H - brY;

  // Given the arbitary (rectangular) region defined by tl, tr, bl and br, we use a line scanning algorithm to
  // draw the 'filled' space with the emphasis on filling the space in tl to br order. The cells we traverse, in
  // order will then be equivalent to a left to right, rear to front row order in the transformed view.

  sint32 rowDX = blX-tlX;
  sint32 rowDY = blY-tlY;
  sint32 sx = (rowDX<0) ? (rowDX = -rowDX, -1) : 1;
  sint32 sy = (rowDY<0) ? (rowDY = -rowDY, -MAP_W) : MAP_W;
  sint32 leftY1 = tlY<<MAP_DIM;
  sint32 leftY2 = blY<<MAP_DIM;
  sint32 rightY1 = trY<<MAP_DIM;
  sint32 rightY2 = brY<<MAP_DIM;


  uint32 pix=0;
  uint32* base = (uint32*)image->getData();

  base[tlX+leftY1] = pix;
  base[trX+rightY1] = pix;

  rowDX<<=1;
  rowDY<<=1;

  if (rowDX > rowDY)
  {
    sint32 frac = rowDY - (rowDX>>1);
    while (tlX!=blX)
    {
      if (frac>=0)
      {
        leftY1 += sy;
        rightY1 += sy;
        frac -= rowDX;
      }
      tlX += sx;
      trX += sx;
      frac += rowDY;
      base[tlX+leftY1] = pix;
      base[trX+rightY1] = pix;
      pix += 0x00070707;
    }
  }
  else
  {
    sint32 frac = rowDX - (rowDY>>1);
    while (leftY1!=leftY2)
    {
      if (frac>=0)
      {
        tlX += sx;
        trX += sx;
        frac -= rowDY;
      }
      leftY1 += sy;
      rightY1 += sy;
      frac += rowDX;
      base[tlX+leftY1] = pix;
      base[trX+rightY1] = pix;
      pix += 0x00070707;
    }
  }
}

///////////////////////////////////////////////////////////////////////////////

class TRect {
  private:
    float32 itrX,  itrY; // initial top left coordinate
    float32 tlX,  tlY;  // transformed top left
    float32 trX,  trY;  // transformed top right
    float32 blX,  blY;  // transformed bottom left
    float32 brX,  brY;  // transformed bottom right
  public:
    void position(float32 x, float32 y, float32 angle);
    void impose(WorldMap* img);
    TRect(float32 w, float32 h) {
      // initial top right coordinate (based on origin of 0,0)
      itrX = 0.5*w;
      itrY = 0.5*h;
    }
};

void TRect::position(float32 x, float32 y, float32 angle)
{
  printf("TRect::position(%0.2f, %0.2f, %0.2f)\n", x, y, angle);

  angle *= (M_PI/180.0);
  float32 cA=cos(angle);
  float32 sA=sin(angle);

  float32 x1 = (itrX*cA);
  float32 y1 = (itrY*sA);
  float32 x2 = (itrX*sA);
  float32 y2 = (itrY*cA);

  // The above variables now contain the following, note TR == ViewRect top right corner
  //
  // x1 = TRx * cos(A')
  // y1 = TRy * sin(A')
  // x2 = TRx * sin(A')
  // y2 = TRy * cos(A')
  // x = x
  // y = y
  //
  // rotate and translate ViewRect single step. We can do this simply by using
  // addition/subtraction of above terms and taking note of symmetry relating the corners
  // to BR

  tlX = x - x1 - y1; // TL'x = Ox + [ -TRx *  cos A' ] + [  TRy * -sin A' ]
  tlY = y - x2 + y2; // TL'y = Oy + [ -TRx *  sin A' ] + [  TRy *  cos A' ]
  trX = x + x1 - y1; // TR'x = Ox + [  TRx *  cos A' ] + [  TRy * -sin A' ]
  trY = y + x2 + y2; // TR'y = Oy + [  TRx *  sin A' ] + [  TRy *  cos A' ]
  blX = x - x1 + y1; // BL'x = Ox + [ -TRx *  cos A' ] + [ -TRy * -sin A' ]
  blY = y - x2 - y2; // BL'y = Oy + [ -TRx *  sin A' ] + [ -TRy *  cos A' ]
  brX = x + x1 + y1; // BR'x = Ox + [  TRx *  cos A' ] + [ -TRy * -sin A' ]
  brY = y + x2 - y2; // BR'y = Oy + [  TRx *  sin A' ] + [ -TRy *  cos A' ]
  printf("TL [%0.2f, %0.2f]\n", tlX, tlY);
  printf("TR [%0.2f, %0.2f]\n", trX, trY);
  printf("BL [%0.2f, %0.2f]\n", blX, blY);
  printf("BR [%0.2f, %0.2f]\n", brX, brY);
}

void TRect::impose(WorldMap* map)
{
  map->setCoord(tlX, tlY, 0xFFFF0000);
  map->setCoord(trX, trY, 0xFF00FF00);
  map->setCoord(blX, blY, 0xFF0000FF);
  map->setCoord(brX, brY, 0xFF000000);
  map->markCells(tlX, tlY, trX, trY, blX, blY, brX, brY);
}


////////////////////////////////////////////////////////////////////////////////

class GfxTestApp : public AppBase, public InputFocus {
  private:
    InteractiveDisplay*    appDisplay;
    WorldMap*              map;
    TRect                  view;
    MilliClock            timer;
    float32                angle;
    bool                  quit;
    bool                  redraw;
    void                  keyPressNonPrintable(I_SRC, Key::CtrlKey code);

  public:
    sint32      initApplication();
    sint32      runApplication();

  public:
    GfxTestApp();
    ~GfxTestApp();
};

////////////////////////////////////////////////////////////////////////////////

sint32 AppBase::init()
{
  return GfxLib::init();
}

////////////////////////////////////////////////////////////////////////////////

void AppBase::done()
{
  GfxLib::done();
}

////////////////////////////////////////////////////////////////////////////////

AppBase* AppBase::createApplicationInstance()
{
  return new GfxTestApp;
}

////////////////////////////////////////////////////////////////////////////////

void AppBase::destroyApplicationInstance(AppBase* app)
{
  delete app;
}

////////////////////////////////////////////////////////////////////////////////

GfxTestApp::GfxTestApp() : InputFocus(IFilter::IKEYPRESS), appDisplay(0),
                           view(64,48), angle(0), quit(false), redraw(true)
{
  map = new(nothrow) WorldMap();
}

////////////////////////////////////////////////////////////////////////////////

GfxTestApp::~GfxTestApp()
{
  delete appDisplay;
  delete map;
}

////////////////////////////////////////////////////////////////////////////////

void GfxTestApp::keyPressNonPrintable(I_SRC, Key::CtrlKey code)
{
  switch (code)
  {
    case Key::ESC:
      quit = true;
      break;

    case Key::F1:
      angle += 5.0;
      if (angle >= 360)
        angle = 0.0;
      redraw = true;
      break;

    case Key::F2:
      angle -= 5.0;
      if (angle <= 0.0)
        angle = 0.0;
      redraw = true;
      break;

    default:
      break;
  }
}

////////////////////////////////////////////////////////////////////////////////

sint32 GfxTestApp::initApplication()
{
  if (!map || !map->getImage()) {
    SystemLib::dialogueBox("Error", "Exit", "Unable to create map");
    return ERR_RSC_UNAVAILABLE;
  }
  appDisplay = new(nothrow) InteractiveWindow(getFocusFilter());
  if (!appDisplay || appDisplay->open(MAP_W, MAP_H, Pixel::BPP8, "Application")!=OK) {
    SystemLib::dialogueBox("Error", "Exit", "Unable to create window");
    return ERR_RSC_UNAVAILABLE;
  }
  appDisplay->addFocus(this);
  return OK;
}

////////////////////////////////////////////////////////////////////////////////

sint32 GfxTestApp::runApplication()
{
  while (!quit)
  {
    if (redraw)
    {
      view.position(0.5*MAP_W, 0.5*MAP_H, angle);
      map->clearCells();
      view.impose(map);
      appDisplay->getDrawSurface()->putImageBuffer(map->getImage(), 0, 0, 0, 0, MAP_W, MAP_H);
      appDisplay->refresh();
      redraw = false;
    }
    while (appDisplay->handleEvent())
      ;
    appDisplay->waitEvent();
  }
  return 0;
}

////////////////////////////////////////////////////////////////////////////////

