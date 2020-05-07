
#include <xbase.hpp>
#include <systemlib/timer.hpp>
#include <gfxlib/gfxapp.hpp>
#include <gfxlib/draw.hpp>
extern "C" {
  #include <string.h>
  #include <math.h>
}

#include "render.hpp"

extern Draw2D*  testCreateDraw(Surface* s);

////////////////////////////////////////////////////////////////////////////////

class GfxTestApp : public AppBase, public InputFocus {
  private:
    InteractiveDisplay*    appDisplay;
    Draw2D*                draw;
    MilliClock            timer;
    sint32                width;
    sint32                height;
    P_D                    depth;
    bool                  redraw;
    bool                  quit;
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
                           draw(0), redraw(true), quit(false)
{
  sint32 tw = getInteger("width", false);
  if (tw)
    width = Clamp::integer(tw, 160, 1024);
  else
    width    = 320;

  sint32 th = getInteger("height", false);
  if (th)
    height  = Clamp::integer(th, 120, 768);
  else
    height = 240;
  sint32 d = getInteger("bpp", false);
  switch (d) {
    case 8:   depth = Pixel::BPP8; break;
    case 15: depth = Pixel::BPP15; break;
    case 16: depth = Pixel::BPP16; break;
    case 24: depth = Pixel::BPP24; break;
    case 32: depth = Pixel::BPP32; break;
    default: depth = Pixel::BPP8; break;
  }
}

////////////////////////////////////////////////////////////////////////////////

GfxTestApp::~GfxTestApp()
{
  if (draw)
    delete draw;
  if (appDisplay)
    delete appDisplay;
}

////////////////////////////////////////////////////////////////////////////////

void GfxTestApp::keyPressNonPrintable(I_SRC, Key::CtrlKey code)
{
  switch (code)
  {
    case Key::ESC:
      quit = true;
      break;

    case Key::F1: {
        draw->begin();
        draw->eraseRect(0, 0, width-1, height-1);
        draw->end();
        redraw = true;
      }
      break;

    case Key::F2: {
        printf("Testing drawLine() : ");
        draw->begin();
        draw->fillRect(0, 0, width-1, height-1);
        timer.set();
        for (sint32 i=0, b=0; i<height; i++, b++)
        {
          draw->drawLine(0, i, width-1, height-i, b);
        }
        for (i=0, b=0; i<width; i++, b++)
        {
          draw->drawLine(i, 0, width-i, height-1, b);
        }
        sint32 t = timer.elapsed();
        draw->end();
        redraw = true;
        printf("%ld lines took %ld millis, %6.2lf lines/s\n",
          width+height, t,
          ((1000.0*(width+height))/(float64)t)
        );
      }
      break;

    case Key::F3: {
        printf("Testing drawRect() : ");
        draw->begin();
        draw->fillRect(0, 0, width-1, height-1);
        timer.set();
        for (sint32 i=0, b=0; i<height/2; i+=2, b++)
        {
          draw->drawRect(i, i, width-i, height-i, (b<<16|b));
        }
        sint32 t = timer.elapsed();
        draw->end();
        redraw = true;
        printf("Took %ld millis\n", t);
      }
      break;

    case Key::F4: {
        printf("Testing fillRect() : ");
        draw->begin();
        draw->fillRect(0, 0, width-1, height-1);
        timer.set();
        for (sint32 i=0, b=0; i<height/2; i+=2, b++)
        {
          draw->fillRect(i, i, width-i, height-i, (b<<17|b));
        }
        sint32 t = timer.elapsed();
        draw->end();
        redraw = true;
        printf("Took %ld millis\n", t);
      }
      break;


    case Key::F5: {
        printf("Testing SoftRender::line16() : ");

        Surface* surf = appDisplay->getDrawSurface();
        surf->clear(0);
        void *p;
        if (p = surf->lockData())
        {
          timer.set();
          for (sint32 i=0, b=0; i<height; i++, b++)
          {
            SoftRender::line16(p, surf->getHWWidth(), 0, i, width-1, height-i, b);
          }
          for (i=0, b=0; i<width; i++, b++)
          {
            SoftRender::line16(p, surf->getHWWidth(), i, 0, width-i, height-1, b);
          }
          sint32 t = timer.elapsed();
          surf->unlockData();
          redraw = true;
          printf("%ld lines took %ld millis, %6.2lf lines/s\n",
            width+height, t,
            ((1000.0*(width+height))/(float64)t)
          );
        }
      }
      break;

    default:
      break;
  }
}

////////////////////////////////////////////////////////////////////////////////

sint32 GfxTestApp::initApplication()
{
  appDisplay = new InteractiveWindow(getFocusFilter());
  if (!appDisplay || appDisplay->open(width, height, depth, "Application")!=OK)
  {
    SystemLib::dialogueBox("Error", "Exit", "Unable to create window");
    return ERR_RSC_UNAVAILABLE;
  }

  appDisplay->addFocus(this);

  draw = testCreateDraw(appDisplay->getDrawSurface());
  if (!draw)
  {
    SystemLib::dialogueBox("Error", "Exit", "Unable to obtain a Draw2D class");
    return ERR_RSC_UNAVAILABLE;
  }
  draw->setClearColour(0xFF000000);
  draw->setFlatFillColour(0xFF00007F);
  draw->setStrokeColour(0xFF0000FF);
  draw->eraseRect(0, 0, width-1, height-1);

  {
    Surface* s = appDisplay->getDrawSurface();
    void* p;

    sint16 cx = width/2;
    sint16 cy = height/2;
    sint16 sp = s->getHWWidth();
    sint16 r = (cy<cx) ? cy : cx;
    if (p = s->lockData())
    {
      for (sint32 i=0; i<512; i++)
      {
        sint16 rx = (sint16)(r*sin(((float32)i*PI)/256.0));
        sint16 ry = (sint16)(r*cos(((float32)i*PI)/256.0));
        SoftRender::line16(p, sp, cx, cy, cx+rx, cy+ry, i);
      }


      //SoftRender::line16(p, sp, cx, cy, cx+16, cy-32, 0x03E0);
      //SoftRender::line16(p, sp, cx, cy, cx+16, cy+32, 0xFC00);
      //SoftRender::line16(p, sp, cx, cy, cx-16, cy-32, 0xFFFF);
      s->unlockData();
    }
  }
  return OK;
}

////////////////////////////////////////////////////////////////////////////////

sint32 GfxTestApp::runApplication()
{
  while (!quit)
  {
    if (redraw)
    {
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

