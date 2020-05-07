
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
    ImageBuffer*  image;
    sint32*        marked;
    Colour        point;
    uint32        markCurr;
    sint32        numMarked;
    sint32        numMulti;

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

    void markCells(sint16 tlX, sint16 tlY, sint16 trX, sint16 trY, sint16 blX, sint16 blY, sint16 brX, sint16 brY);

    void clearCells()
    {
      if (numMarked>0) {
        uint32 *p = (uint32*)image->getData();
        sint32* m = marked;
        sint32 i = numMarked;
        while(i--) {
          p[(*m++)] = 0xFFDDDDFF;
        }
      } else {
        Mem::set32(image->getData(), 0xFFFFFFFF, MAP_W*MAP_H);
      }
    }

    void markStats()
    {
      printf("Last mark: %ld marked, %ld multiple\n", numMarked, numMulti);
    }

    void dumpList()
    {
      int n=0;
      puts("Cell dump");
      while (n<numMarked) {
        printf("%5ld, ", marked[n]);
        if (((++n)&15)==0) {
          putchar('\n');
        }
      }
      puts("\n----------\n");
    }

  public:
    WorldMap() : image(0), point(0), markCurr(0), numMarked(0), numMulti(0)
    {
      if (marked = new(nothrow) sint32[MAP_W*MAP_H]) {
        if (image = new(nothrow) ImageBuffer) {
          if (image->create(MAP_W, MAP_H, Pixel::ARGB32B)==OK) {
            Mem::set32(image->getData(), 0xFFFFFFFF, MAP_W*MAP_H);
          } else {
            delete image;
            image = 0;
          }
        }
      }
    }

    ~WorldMap()
    {
      delete marked;
      delete image;
    }
};

void WorldMap::markCellRow(S_2CRD)
{
  point.blue() = 0;
  sint32 dx = x2-x1;
  sint32 dy = y2-y1;

  sint32 sx = (dx<0) ? (dx = -dx, -1) : 1;
  sint32 sy = (dy<0) ? (dy = -dy, -MAP_W) : MAP_W;

  sint32 _y1 = y1<<MAP_DIM;
  sint32 _y2 = y2<<MAP_DIM;

  Colour* base = (Colour*)image->getData();

  sint32 i = x1+_y1;

  if (base[i].alpha()!= markCurr) {
    base[i] = point;
    marked[numMarked++] = i;
  } else {
    numMulti++;
  }

  dx<<=1;
  dy<<=1;

  if (dx > dy) {
    sint32 frac = dy - (dx>>1);
    while (x1!=x2) {
      if (frac>=0) {
        i = x1+_y1+sx;
        //if (i>=0 && i<(MAP_W*MAP_H)) {
          if (base[i].alpha()!=markCurr) {
            base[i] = point;
            marked[numMarked++] = i;
          } else {
            numMulti++;
          }
          point.blue()+=8;
        //}
        _y1 += sy;
        frac -= dx;
      }
      x1 += sx;
      frac += dy;
      i = x1+_y1;
      //if (i>=0 && i<(MAP_W*MAP_H)) {
        if (base[i].alpha()!=markCurr) {
          base[i] = point;
          marked[numMarked++]=i;
        } else {
          numMulti++;
        }
        point.blue()+=8;
      //}
    }
  }
  else {
    sint32 frac = dx - (dy>>1);
    while (_y1!=_y2) {
      if (frac>=0) {
        i = x1+_y1+sy;
        //if (i>=0 && i<(MAP_W*MAP_H)) {
          if (base[i].alpha()!=markCurr) {
            base[i] = point;
            marked[numMarked++]=i;
          } else {
            numMulti++;
          }
          point.blue()+=8;
        //}
        x1 += sx;
        frac -= dy;
      }
      _y1 += sy;
      frac += dx;
      i = x1+_y1;
      //if (i>=0 && i<(MAP_W*MAP_H)) {
        if (base[i].alpha()!=markCurr) {
          base[i] = point;
          marked[numMarked++]=i;
        } else {
          numMulti++;
        }
        point.blue()+=8;
      //}
    }
  }
}

void WorldMap::markCells(sint16 tlX, sint16 tlY, sint16 trX, sint16 trY, sint16 blX, sint16 blY, sint16 brX, sint16 brY)
{
  numMarked = 0;
  numMulti = 0;
  markCurr = (markCurr+1)&0xFF;

  point = 0x00000000;
  point.alpha() = markCurr;

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
  sint32 sy = (rowDY<0) ? (rowDY = -rowDY, -1) : 1;

  markCellRow(tlX,tlY,trX,trY);
  rowDX<<=1;
  rowDY<<=1;

  if (rowDX > rowDY) {
    sint32 frac = rowDY - (rowDX>>1);
    while (tlX!=blX) {
      point.green()+=8;
      if (frac>=0) {
        tlY += sy;
        trY += sy;
        frac -= rowDX;
      }
      tlX += sx;
      trX += sx;
      frac += rowDY;
      markCellRow(tlX,tlY,trX,trY);
    }
  }
  else {
    sint32 frac = rowDX - (rowDY>>1);
    while (tlY!=blY) {
      point.green()+=8;
      if (frac>=0) {
        tlX += sx;
        trX += sx;
        frac -= rowDY;
      }
      tlY += sy;
      trY += sy;
      frac += rowDX;
      markCellRow(tlX,tlY,trX,trY);
    }
  }
}

///////////////////////////////////////////////////////////////////////////////

class TRect {
  private:
    // initial position
    float32 itrX,  itrY;
    // transformed points
    float32 tlX,  tlY;
    float32 trX,  trY;
    float32 blX,  blY;
    float32 brX,  brY;
    float32 mnX,  mnY;
    float32  mxX,  mxY;
  public:
    void position(float32 x, float32 y, float32 angle);
    void impose(WorldMap* img);

    float32 minX() { return mnX; }
    float32 maxX() { return mxX; }
    float32 minY() { return mnY; }
    float32 maxY() { return mxY; }

    TRect(float32 w, float32 h)
    {
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
  //printf("TL [%0.2f, %0.2f]\n", tlX, tlY);
  //printf("TR [%0.2f, %0.2f]\n", trX, trY);
  //printf("BL [%0.2f, %0.2f]\n", blX, blY);
  //printf("BR [%0.2f, %0.2f]\n", brX, brY);
  if (angle<(0.5*M_PI/2)) {
    // 0 - 90 degrees
    mnX = tlX;  // top left -> min X
    mxX = brX;  // bot right -> max X
    mnY = blY;  // bot left -> min Y
    mxY = trY;  // top right -> max Y
  } else if (angle<M_PI) {
    // 90 - 180 degrees
    mnX = trX;  // top right -> min X
    mxX = blX;  // bot left -> max X
    mnY = tlY;  // top left -> min Y
    mxY = brY;  // bot right -> max Y
  } else if (angle<(1.5*M_PI)) {
    // 180 - 270 degrees
    mnX = brX;  // bot right -> min X
    mxX = tlX;  // top left -> max X
    mnY = trY;  // top right -> min Y
    mxY = blY;  // bot left -> max Y
  } else {
    // 270 - 360 degrees
    mnX = blX;  // bot left -> min X
    mxX = trX;  // top right -> max X
    mnY = brY;  // bot right -> min Y
    mxY = trY;  // top left -> max Y
  }
}

void TRect::impose(WorldMap* map)
{
  map->markCells(
    (sint16)(tlX+0.5), (sint16)(tlY+0.5),
    (sint16)(trX+0.5), (sint16)(trY+0.5),
    (sint16)(blX+0.5), (sint16)(blY+0.5),
    (sint16)(brX+0.5), (sint16)(brY+0.5)
  );
}


////////////////////////////////////////////////////////////////////////////////

class GfxTestApp : public AppBase, public InputFocus {
  private:
    InteractiveDisplay*    appDisplay;
    WorldMap*              map;
    TRect                  view;
    MilliClock            timer;
    float32                angle;
    float32                posX;
    float32                posY;
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

GfxTestApp::GfxTestApp()
: InputFocus(IFilter::IKEYPRESS), appDisplay(0), view(32,24), angle(0), posX(MAP_W/2), posY(MAP_H/2), quit(false), redraw(true)
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
  switch (code)  {
    case Key::ESC:
      quit = true;
      break;

    case Key::F1:
      angle += 0.5;
      if (angle >= 360)
        angle = 0.0;
      redraw = true;
      break;

    case Key::F2:
      angle -= 0.5;
      if (angle < 0.0)
        angle = 359.5;
      redraw = true;
      break;

    case Key::F10:
      map->dumpList();
      break;

    case Key::LEFT:
      if ((view.minX()-1)>0) {
        posX-= 1;
        redraw = true;
      }
      break;

    case Key::RIGHT:
      if ((view.maxX()+1)<MAP_W) {
        posX+= 1;
        redraw = true;
      }
      break;

    case Key::DOWN:
      if ((view.minY()-1)>0) {
        posY-= 1;
        redraw = true;
      }
      break;

    case Key::UP:
      if ((view.maxY()+1)<MAP_H) {
        posY+= 1;
        redraw = true;
      }
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
  float avg = 0.0;
  uint32 f=0;
  appDisplay->getDrawSurface()->putImageBuffer(
    map->getImage(),
    0, 0,
    0, 0,
    MAP_W,
    MAP_H
  );
  appDisplay->refresh();
  while (!quit) {
    if (redraw) {
      f++;
      view.position(posX, posY, angle);
      map->clearCells();
      timer.set();
      view.impose(map);
      avg += timer.elapsedFrac();
      map->markStats();
      appDisplay->getDrawSurface()->putImageBuffer(
        map->getImage(),
        view.minX(), (MAP_H-view.maxY()),
        view.minX(), (MAP_H-view.maxY()),
        view.maxX() - view.minX(),
        view.maxY() - view.minY()
      );
      appDisplay->refresh();
      redraw = false;
    }
    while (appDisplay->handleEvent()) {
      ;
    }
    appDisplay->waitEvent();
  }
  printf("Average scan time: %0.2f ms\n", (avg/(float64)f));
  return 0;
}

////////////////////////////////////////////////////////////////////////////////

