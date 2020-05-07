//****************************************************************************//
//**                                                                        **//
//** File:         proj/SimpleView/simplepaint.cpp                          **//
//** Description:  SimplePaint application                                  **//
//** Comment(s):                                                            **//
//** Created:      2004-02-16                                               **//
//** Updated:      2004-02-17                                               **//
//** Author(s):    Karl Churchill                                           **//
//** Note(s):                                                               **//
//** Copyright:    (C)1996-2004, eXtropia Studios                           **//
//**               Serkan YAZICI, Karl Churchill                            **//
//**               All Rights Reserved.                                     **//
//**                                                                        **//
//****************************************************************************//

#include "simplepaint.hpp"

#include <iolib/fileio.hpp>

#define APPRESPONSE (IFilter::IKEYPRESS|IFilter::IMOUSEPRESS|IFilter::IMOUSEDRAG)

////////////////////////////////////////////////////////////////////////////////
//
//  SimplePaintApp
//
//  Creates an ARGB 32-bit ImageBuffer used as a canvas. A SimpleBrush (see
//  simplepaint.hpp) is blended onto this canvas by drawing with the mouse.
//
//  The canvas is then drawn into the Display's draw Surface using the
//  putImageBuffer() method. Only the area changed during drawing is uploaded
//  to minimise overhead.
//
//  A second ImageBuffer contains a colour palette that can be toggled by
//  pressing F10. When active, mouse clicks within the palette area select the
//  colour under the cursor.
//
//  Instead of refreshing the entire Display after event processing, the
//  application refreshes just the area of the Display that changes for each
//  operation that updates the draw Surface. This gives a smoother response
//  for the user since updating only after all events are processed may take
//  some time in which no visible feedback occurs.
//
//  Keys
//
//  Esc - quits
//  F1  - increase brush radius
//  F2  - decrease brush radius
//  F3  - reset brush radius
//  F4  - increase brush density
//  F5  - decrease brush density
//  F6  - reset brush density
//  F7  - reset brush radius and density
//  F8  - clear page to white
//  F9  - clear page to current brush colour
//  F10 - show palette / colour select mode
//
//  1-8 - use brush preset 1..8
//  s   - write image as ppm
//  a    - use alpha paint mode
//  n    - use negate paint mode
//  c   - clear mask
//
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
  return new(nothrow) SimplePaintApp;
}

////////////////////////////////////////////////////////////////////////////////

void AppBase::destroyApplicationInstance(AppBase* app)
{
  delete app;
}

////////////////////////////////////////////////////////////////////////////////
//
//  Application constructor
//
//  Set up defaults here, whatever cannot be done here can be done in the
//  initApplication() method.
//
////////////////////////////////////////////////////////////////////////////////

SimplePaintApp::SimplePaintApp() : InputFocus(APPRESPONSE), display(0), canvas(0),
                                   canvasMask(0), currBrush(0),
paletteSelect(false), quit(false)
{
  titleBuffer  = new(nothrow) char[256];

  // default dimensions
  sint16  w    = getInteger("width", false);
  sint16  h    = getInteger("height", false);
  width        = w ? Clamp::integer(w, 320, 1024) : 640;
  height      = h ? Clamp::integer(h, 240, 768) : 480;
  display      = new(nothrow) InteractiveWindow(APPRESPONSE);

  // default brushes
  brush        = new(nothrow) SimpleBrush[NUM_BRUSH](8.0, 1.0, 0x00000000);
  if (brush) {
    // Ah, the good old zx spectrum colours :-D
    brush[0].setColour(0x000000FF);  // blue
    brush[1].setColour(0x00FF0000);  // red
    brush[2].setColour(0x00FF00FF);  // magenta
    brush[3].setColour(0x0000FF00);  // green
    brush[4].setColour(0x0000FFFF);  // cyan
    brush[5].setColour(0x00FFFF00);  // yellow
    brush[6].setColour(0x00FFFFFF);  // white
    brush[7].setColour(0x00000000);  // black
  }
}

////////////////////////////////////////////////////////////////////////////////
//
//  Application Destructor, clean up all the allocated stuff
//
////////////////////////////////////////////////////////////////////////////////

SimplePaintApp::~SimplePaintApp()
{
  delete[] brush;
  delete palette;
  delete canvas;
  delete display;
  delete[] canvasMask;
  delete[] titleBuffer;
}

////////////////////////////////////////////////////////////////////////////////
//
//  initApplication() (overriden from AppBase)
//
//  Performs final initialisation and checks before the main runApplication()
//  is called.
//
////////////////////////////////////////////////////////////////////////////////

sint32 SimplePaintApp::initApplication()
{
  if (!titleBuffer) {
    SystemLib::dialogueBox("Error", "Exit", "Coudn't allocate memory");
    return ERR_RSC;
  }

  Pixel::HWType pType = Pixel::getPrefFormat(Pixel::BPP32);

  printf("Pixel type %d\n", pType);

  /*
    The hardware format returned for the above ARGB32 is guarenteed by the
    library to match the longword format of Colour. Hence we allocate our
    32-bit image buffers with this format such that the individual pixels
    are safely accessable as Colour.
  */

  // Did the user specify an image to work on?
  const char* imageName = getString("image", false);
  bool imageLoaded = false;

  if (imageName) {
    if (canvas = ImageLoader::loadImage(imageName, true)) {
      // image loaded, reset dimensions to image
      width = canvas->getW();
      height = canvas->getH();
      imageLoaded = true;
    }
  }

  if (imageLoaded == false) {
    canvas = new(nothrow) ImageBuffer;
    if (!canvas || canvas->create(width, height, pType)!=OK) {
      SystemLib::dialogueBox("Error", "Exit", "Couldn't create canvas");
      return ERR_RSC;
    }
    else {
      Mem::set32(canvas->getData(), 0xFFFFFFFF, width*height);
    }
  }
/*
  printf("created canvas at 0x%08X\n", (unsigned)canvas);
  return ERR_RSC;
*/

  // Attempt to set up the canvas
  canvasMask  = new(nothrow) uint8[width*height];
  if (!canvasMask) {
    SystemLib::dialogueBox("Warning", "Proceed", "Couldn't create canvas mask");
  }

  // Load the palette image into an ImageBuffer
  if (!(palette = ImageLoader::loadImage("data/palette.png", true))) {
    SystemLib::dialogueBox("Error", "Exit", "Couldn't load palette");
    return ERR_RSC;
  }

  if (palette->getFormat()!=pType) {
    // FIXME : if the imageloader returns a format incompatible with
    // the pixel type, convert it.
    SystemLib::dialogueBox("Error", "Exit", "Palette format");
    return ERR_RSC;
  }

  // Open the display. Ask for at least 15-bits deep.
  if (!display || display->open(width, height, Pixel::BPP15, "SimplePaint")!=OK) {
    SystemLib::dialogueBox("Error", "Exit", "Couldn't open display");
    return ERR_RSC;
  }

  // Show the initial display
  if (imageLoaded) {
    display->getDrawSurface()->putImageBuffer(canvas, 0, 0, 0, 0, width, height);
  }
  else {
    display->getDrawSurface()->clear(Colour(0xFFFFFFFF));
  }
  display->refresh();

  // Add the application to the InteractiveDisplay's InputFocus list so we can
  // get input back from it.
  display->addFocus(this);
  refreshTitle();
  return OK;
}


////////////////////////////////////////////////////////////////////////////////
//
//  runApplication() (overriden from AppBase)
//
//  Believe it or not, this main event loop. We simply wait for events and
//  act upon them until something eventually flags a quit condition.
//
////////////////////////////////////////////////////////////////////////////////

sint32 SimplePaintApp::runApplication()
{
  while (!quit) {
    display->waitEvent();
    while (display->handleEvent())
      ;
  }
  return 0;
}


////////////////////////////////////////////////////////////////////////////////
//
//  keyPressPrintable() (overriden from InputFocus)
//
//  This method is called when we receive a printable keypress.
//
////////////////////////////////////////////////////////////////////////////////

void SimplePaintApp::keyPressPrintable(InputDispatcher* src, sint32 ch)
{
  bool updateTitle = false;
  switch (ch) {
    // Keys 1-8 select the brush
    case '1': currBrush = 0; updateTitle = true; break;
    case '2': currBrush = 1; updateTitle = true; break;
    case '3': currBrush = 2; updateTitle = true; break;
    case '4': currBrush = 3; updateTitle = true; break;
    case '5': currBrush = 4; updateTitle = true; break;
    case '6': currBrush = 5; updateTitle = true; break;
    case '7': currBrush = 6; updateTitle = true; break;
    case '8': currBrush = 7; updateTitle = true; break;

    // A sets normal paint mode
    case 'a':
    case 'A':
      brush[currBrush].setBlend(SimpleBrush::ALPHA);
      updateTitle = true;
      break;

    // N sets negative paint mode
    case 'n':
    case 'N': brush[currBrush].setBlend(SimpleBrush::NEGATIVE);
      updateTitle = true;
      break;

    // M sets multiply paint mode
    case 'm':
    case 'M': brush[currBrush].setBlend(SimpleBrush::MULTIPLY);
      updateTitle = true;
      break;

    // C clears the canvas mask
    case 'c':
    case 'C': if (canvasMask) Mem::zero(canvasMask, width*height); break;

    // S writes a screenshot
    case 's':
    case 'S':
      writeShot("simpleshot");
      break;

    default:
      break;
  }
  if (updateTitle) {
    refreshTitle();
  }
}


////////////////////////////////////////////////////////////////////////////////
//
//  keyPressNonPrintable() (overriden from InputFocus)
//
//  This method is called when we receive a non-printable keypress.
//
////////////////////////////////////////////////////////////////////////////////

void SimplePaintApp::keyPressNonPrintable(InputDispatcher* src, Key::CtrlKey code)
{
  bool updateTitle = false;
  switch(code) {
    // Esc quits
    case Key::ESC:
      if (SystemLib::dialogueBox("Warning", "OK|Cancel", "Really Quit?")!=0)
        quit = true;
      break;

    // F1 increases brush radius
    case Key::F1:
      brush[currBrush].setRadius(brush[currBrush].getRadius()+0.25f);
      updateTitle = true;
      break;

    // F2 decreases brush radius
    case Key::F2:
      brush[currBrush].setRadius(brush[currBrush].getRadius()-0.25f);
      updateTitle = true;
      break;

    // F3 resets brush radius to default
    case Key::F3:
      brush->setRadius(8.0f);
      updateTitle = true;
      break;

    // F4 increases brush density
    case Key::F4:
      brush[currBrush].setDensity(brush[currBrush].getDensity()*1.05f);
      updateTitle = true;
      break;

    // F5 decreases brush density
    case Key::F5:
      brush[currBrush].setDensity(brush[currBrush].getDensity()/1.05f);
      updateTitle = true;
      break;

    // F6 resets brush density to default
    case Key::F6:
      brush[currBrush].setDensity(1.0f);
      updateTitle = true;
      break;

    // F7 resets brush density/radius to default
    case Key::F7:
      brush[currBrush].setRadiusDensity(16.0f, 1.0f);
      brush->setRadiusDensity(16.0f, 1.0f);
      updateTitle = true;
      break;

    // F8 clears the canvas (to white)
    case Key::F8:
      if (SystemLib::dialogueBox("Warning", "OK|Cancel", "Really clear page?")!=0) {
        Mem::set32(canvas->getData(), 0xFFFFFFFF, width*height);
        if (canvasMask)
          Mem::zero(canvasMask, width*height);
        display->getDrawSurface()->clear(0xFFFFFFFF);
        display->refresh();
      }
      break;

    // F9 clears the canvas to current brush colour
    case Key::F9:
      if (SystemLib::dialogueBox("Warning", "OK|Cancel", "Really clear page to current colour?")!=0) {
        Colour c = brush[currBrush].getColour();
        Mem::set32(canvas->getData(), c, width*height);
        if (canvasMask)
          Mem::zero(canvasMask, width*height);
        display->getDrawSurface()->clear(c);
        display->refresh();
      }
      break;

    // F10 toggles the palette select tool
    case Key::F10:
      if (paletteSelect) {
        // restore the canvas in the centre of the display
        paletteSelect = false;
        display->getDrawSurface()->putImageBuffer(canvas,
          (width-palette->getW())>>1,
          (height-palette->getH())>>1,
          (width-palette->getW())>>1,
          (height-palette->getH())>>1,
          palette->getW(), palette->getH()
        );
      }
      else {
        // show the palette in the centre of the display
        paletteSelect = true;
        display->getDrawSurface()->putImageBuffer(palette,
          (width-palette->getW())>>1,
          (height-palette->getH())>>1,
          0,
          0,
          palette->getW(), palette->getH()
        );
      }
      display->refresh(
          (width-palette->getW())>>1,
          (height-palette->getH())>>1,
          palette->getW(), palette->getH()
      );

    default:
      break;
  }

  if (updateTitle)
    refreshTitle();
}


////////////////////////////////////////////////////////////////////////////////
//
//  mousePress() (overidden from InputFocus)
//
//  This method is called when we receive a mouse keypress.
//  Here we simply call the mouseDrag() method with a movement delta of zero.
//
////////////////////////////////////////////////////////////////////////////////

void SimplePaintApp::mousePress(InputDispatcher* src, uint32 keys)
{
  mouseDrag(src, getMouseX(), getMouseY(), 0, 0, keys);
}


////////////////////////////////////////////////////////////////////////////////
//
//  mouseDrag() (overidden from InputFocus)
//
//  This method is called when we receive a mouse movement whilst mouse keys
//  are still held (dragging).
//
//  This method is defined to either select the colour when the palette tool
//  is displayed, or paint the current brush otherwise.
//
////////////////////////////////////////////////////////////////////////////////

void SimplePaintApp::mouseDrag(InputDispatcher* src, sint16 x, sint16 y, sint16 dx, sint16 dy, uint32 keys)
{
  if (paletteSelect) {
    sint16 px = x - ((width-palette->getW())>>1);
    sint16 py = y - ((height-palette->getH())>>1);
    if (px>=0 && py>=0 && px<palette->getW() && py<palette->getH()) {
      sint32 ofs = (py*palette->getW())+px;
      Colour* c = (Colour*)(palette->getData());
      brush[currBrush].setColour(c[ofs]);
      refreshTitle();
    }
  }
  else {
    paintBrush(x, y);
  }
}


////////////////////////////////////////////////////////////////////////////////
//
//  refreshTitle()
//
//  Updates the display title, showing the brush number, drawing mode, size
//  density and colour for the current brush.
//
////////////////////////////////////////////////////////////////////////////////

void SimplePaintApp::refreshTitle()
{
  sprintf(titleBuffer, "SimplePaint [Brush %hd %s %5.2f : %5.2f : #%06X]",
          currBrush+1,
          brush[currBrush].getMode(),
          brush[currBrush].getRadius(),
          brush[currBrush].getDensity(),
          (uint32)(brush[currBrush].getColour()));
  display->setTitle(titleBuffer);
}


////////////////////////////////////////////////////////////////////////////////
//
//  paintBrush()
//
//  Paints the current brush onto the canvas and then copies the changed area
//  to the displays draw surface. Lastly it tells the display to refresh the
//  area it just copied.
//
////////////////////////////////////////////////////////////////////////////////

void SimplePaintApp::paintBrush(sint16 x, sint16 y)
{
  sint16 s = brush[currBrush].getSize();
  sint16 r = s>>1;
  // apply brush to canvas
  brush[currBrush].apply(canvas, canvasMask, x, y);

  // update changed area of surface
  display->getDrawSurface()->putImageBuffer(canvas, x-r, y-r, x-r, y-r, s, s);

  // refresh the display (just the section that changes is ok)
  display->refresh(x-r, y-r, s, s);
}


////////////////////////////////////////////////////////////////////////////////
//
//  writeShot()
//
//  Saves the current canvas as a simple PPM (portable pixel map) file.
//
////////////////////////////////////////////////////////////////////////////////

void SimplePaintApp::writeShot(const char* baseName)
{
  static sint32 shot = 0;

  char fileName[256];
  sprintf(fileName, "%s_%03ld.ppm", baseName, shot++);

  StreamOut ppmFile(fileName, false, false);
  if (ppmFile.valid()) {
    display->setTitle("Saving image...");
    ppmFile.writeText("P6\n%hd\n%hd\n255\n", width, height);
    Colour*  data    = (Colour*)(canvas->getData());
    sint32  numPix  = canvas->getH() * canvas->getW();
    for (rsint32 i=0; i<numPix; i++) {
      ppmFile.putChar((char)(data->red()));
      ppmFile.putChar((char)(data->green()));
      ppmFile.putChar((char)(data->blue()));
      data++;
    }
    ppmFile.close();
    refreshTitle();
  }
}

////////////////////////////////////////////////////////////////////////////////
