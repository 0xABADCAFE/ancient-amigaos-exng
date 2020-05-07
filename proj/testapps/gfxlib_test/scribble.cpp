
#include <gfxlib/gfxapp.hpp>
#include <gfxlib/gfxutil.hpp>

////////////////////////////////////////////////////////////////////////////////

class Scribble : public AppBase, public Fullscreen {
  private:
    Surface*  brush;
    bool      running;
    sint16    width;
    sint16    height;
    uint16*    data;
    sint16    modulus;
    Colour    pen1;
    Colour    pen2;
    uint16    pen1RGB16;
    uint16    pen2RGB16;

    void    drawRGBStrip();
    void    drawColours();
    void    clearBGColour();

  protected:
    sint32  initApplication();
    sint32  runApplication();
    void    doneApplication();
    void    keyPressNonPrintable(sint32 code);
    void    mouseDrag(sint16 x, sint16 y, sint16 dx, sint16 dy, uint32 keys);
    void    mousePress(uint32 code);

  public:
    Scribble();
    ~Scribble();
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
  return new Scribble;
}

////////////////////////////////////////////////////////////////////////////////

void AppBase::destroyApplicationInstance(AppBase* app)
{
  delete app;
}

////////////////////////////////////////////////////////////////////////////////

Scribble::Scribble() : Fullscreen(IKEYNONPRINTPRESS|IMOUSEDRAG|IMOUSEPRESS),
                       brush(0), running(false), pen1(0), pen2(0xFFC0C0C0)
{
  pen1RGB16  = pen1.getRGB16();
  pen2RGB16  = pen2.getRGB16();
}

////////////////////////////////////////////////////////////////////////////////

Scribble::~Scribble()
{
  close();
}


////////////////////////////////////////////////////////////////////////////////

void Scribble::drawRGBStrip()
{
  if (data)
  {
    ruint16*  t1  = data;
    rfloat32  stepX = 32.0F/(float32)width;
    rfloat32  stepG = 64.0F/(float32)width;
    for (rsint32 y = 0; y<8; y++)
    {
      ruint16*  t2 = t1 + ((width+modulus)<<3);
      ruint16*  t3 = t1 + ((width+modulus)<<4);
      rsint32    i = width+1;
      rfloat32  valX = 0;
      rfloat32  valG = 0;
      while (--i)
      {
        *t1++  = (uint16)valX<<11;  // red strip
        *t2++  = (uint16)valG<<5;  // green strip
        *t3++  = (uint16)valX;      // blue strip
        valX  += stepX;
        valG  += stepG;
      }
      t1+=modulus;
    }
  }
}

////////////////////////////////////////////////////////////////////////////////

void Scribble::drawColours()
{
  if (data)
  {
    ruint16* t = data + ((width+modulus)*24);
    for (rsint32 y=0; y<8; y++, t+=(width+modulus))
    {
      Mem::set16(t, pen1RGB16, (width>>1));
      Mem::set16(t+(width>>1), pen2RGB16, (width>>1));
    }
  }
}

////////////////////////////////////////////////////////////////////////////////

void Scribble::clearBGColour()
{
  if (data)
  {
    ruint16* t = data + ((width+modulus)<<5);
    for (rsint32 y=32; y<height; y++, t+=(width+modulus))
    {
      Mem::set16(t, pen2RGB16, width);
    }
  }
}

////////////////////////////////////////////////////////////////////////////////

void Scribble::keyPressNonPrintable(sint32 code)
{
  switch (code) {
    case Key::ESC:
      running = false;
      break;

    case Key::F1:
      pen1 = 0x000000FF;
      pen1RGB16 = pen1.getRGB16();
      drawColours();
      break;

    case Key::F2:
      pen1 = 0x00FF0000;
      pen1RGB16 = pen1.getRGB16();
      drawColours();
      break;

    case Key::F3:
      pen1 = 0x00FF00FF;
      pen1RGB16 = pen1.getRGB16();
      drawColours();
      break;

    case Key::F4:
      pen1 = 0x0000FF00;
      pen1RGB16 = pen1.getRGB16();
      drawColours();
      break;

    case Key::F5:
      pen1 = 0x0000FFFF;
      pen1RGB16 = pen1.getRGB16();
      drawColours();
      break;

    case Key::F6:
      pen1 = 0x00FFFF00;
      pen1RGB16 = pen1.getRGB16();
      drawColours();
      break;

    case Key::F7:
      pen1 = 0x00FFFFFF;
      pen1RGB16 = pen1.getRGB16();
      drawColours();
      break;

    case Key::F8:
      pen1 = 0x00000000;
      pen1RGB16 = pen1.getRGB16();
      drawColours();
      break;

    case Key::F9:
        getDrawSurface()->putSurface(brush, getMouseX()-brush->getW()/2,
                                      getMouseY()-brush->getH()/2,
                                      0, 0, brush->getW(), brush->getH());
      break;

    case Key::F10:
      clearBGColour();
      break;
    default:
      break;
  }
}

////////////////////////////////////////////////////////////////////////////////

void Scribble::mouseDrag(sint16 x, sint16 y, sint16 dx, sint16 dy, uint32 k)
{
  if (y>31)
  {
    switch (k)
    {
      case Mouse::KEYLEFT:
        data[x + y*(width+modulus)] = pen1RGB16;
        break;
      case Mouse::KEYRIGHT:
        //data[x + y*(width+modulus)] = pen2RGB16;

        getDrawSurface()->putSurface(brush, getMouseX()-brush->getW()/2,
                                      getMouseY()-brush->getH()/2,
                                      0, 0, brush->getW(), brush->getH());
        break;
      default:
      break;
    }
  }
  else if (y>23)
  {
  }
  else if (y>15)
  {// blue gradient - use component
    uint16 b = data[x + y*(width+modulus)];
    switch (k)
    {
      case Mouse::KEYLEFT:
        pen1RGB16 = (pen1RGB16 & 0xFFE0) | b;
        break;
      case Mouse::KEYRIGHT:
        pen2RGB16 = (pen2RGB16 & 0xFFE0) | b;
        break;
      default:
      break;
    }
    drawColours();
  }
  else if (y>7)
  {// green gradient - use component
    uint16 g = data[x + y*(width+modulus)];
    switch (k)
    {
      case Mouse::KEYLEFT:
        pen1RGB16 = (pen1RGB16 & 0xF81F) | g;
        break;
      case Mouse::KEYRIGHT:
        pen2RGB16 = (pen2RGB16 & 0xF81F) | g;
        break;
      default:
      break;
    }
    drawColours();
  }
  else
  {// red gradient - use component
    uint16 r = data[x + y*(width+modulus)];
    switch (k)
    {
      case Mouse::KEYLEFT:
        pen1RGB16 = (pen1RGB16 & 0x07FF) | r;
        break;
      case Mouse::KEYRIGHT:
        pen2RGB16 = (pen2RGB16 & 0x07FF) | r;
        break;
      default:
      break;
    }
    drawColours();
  }
}

////////////////////////////////////////////////////////////////////////////////

void Scribble::mousePress(uint32 code)
{
  mouseDrag(getMouseX(), getMouseY(), 0, 0, code);
}

////////////////////////////////////////////////////////////////////////////////

sint32 Scribble::initApplication()
{
  width    = Clamp::integer(getInteger("width", false), 320, 800);
  height  = Clamp::integer(getInteger("height", false), 240, 600);

  if (open(width, height, Pixel::BPP16, "Scribble")!=OK)
    return ERR_RSC_UNAVAILABLE;


  ImageBuffer* tempImage = new ImageBuffer;
  if (tempImage)
  {
    if (brush = new Surface)
    {
      ImageLoader::loadPPM(tempImage, "test.ppm", getDrawSurface()->getFormat());
      brush->create(tempImage->getW(), tempImage->getH(), getDrawSurface());
      brush->putImageBuffer(tempImage, 0, 0, 0, 0, tempImage->getW(), tempImage->getH());
    }
    delete tempImage;
  }
  modulus      = getDrawSurface()->getModulus();
  data        = (uint16*)(getDrawSurface()->lockData());
  if (data)
  {
    drawRGBStrip();
    drawColours();
    clearBGColour();
    getDrawSurface()->unlockData();
  }

  return OK;
}

////////////////////////////////////////////////////////////////////////////////

sint32 Scribble::runApplication()
{
  running = true;
  while (running)
  {
    data = (uint16*)(getDrawSurface()->lockData());
    while (handleEvent())
      ;
    getDrawSurface()->unlockData();
    refresh();
    waitEvent();
  }
  if (brush)
    delete brush;
  return 0;
}

void Scribble::doneApplication()
{
  close();
}

////////////////////////////////////////////////////////////////////////////////

