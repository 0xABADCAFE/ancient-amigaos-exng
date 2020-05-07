
#include <xbase.hpp>
#include <gfxlib/draw.hpp>

using namespace X_SYSNAME;

////////////////////////////////////////////////////////////////////////////////

class DrawAmiOS : public Draw2D, SurfaceProvider {
  private:
    Surface*    canvas;
    ViewPort*    view;
    Colour      stroke;
    Colour      fill;
    Colour      clear;
    Colour      grad1;
    Colour      grad2;
    Colour      grad3;
    Colour      grad4;
    sint16      strokePen, fillPen, clearPen, tempPen;
    sint16      lastAPen, lastBPen;
    sint16      clipL, clipR, clipT, clipB;
    sint32      nest;

    RastPort    rastPort;

    bool        use8Bit; // desperate kludge for 8bit displays

    void        getPens();
    void        freePens();

    // Common pen-level drawing methods when in RGB mode
    void        setPenRGB(sint16 pen, Colour &c);
    void        line(sint16 pen, S_2CRD);
    void        lineH(sint16 pen, sint16 x1, sint16 y, sint16 x2);
    void        lineV(sint16 pen, sint16 x, sint16 y1, sint16 y2);
    void        drawRect(sint16 pen, S_2CRD);
    void        fillRect(sint16 pen, S_2CRD);

    // choose best pen 'on the fly' methods when in 8-bit mode
    void        line8(Colour& c, S_2CRD);
    void        lineH8(Colour& c, sint16 x1, sint16 y, sint16 x2);
    void        lineV8(Colour& c, sint16 x, sint16 y1, sint16 y2);
    void        drawRect8(Colour& c, S_2CRD);
    void        fillRect8(Colour& c, S_2CRD);

  public:
    Support      query(Query q) { return UNSUPPORTED; }
    sint32      begin();
    void        end();
    sint32      setCanvas(Surface* s);
    Surface*    getCanvas();
    sint32      setClip(S_2CRD);

    void        setStrokeColour(Colour c);
    void        setFlatFillColour(Colour c);
    void        setClearColour(Colour c);
    void        setGradPrimary(Colour c)    { grad1 = c; }
    void        setGradSecondary(Colour c)  { grad2 = c; }
    void        setGradTernary(Colour c)    { grad3 = c; }
    void        setGradQuaternary(Colour c)  { grad4 = c; }
    Colour      getStrokeColour()            { return stroke; }
    Colour      getFlatFillColour()          { return fill; }
    Colour      getClearColour()            { return clear; }
    Colour      getGradPrimary()            { return grad1; }
    Colour      getGradSecondary()          { return grad2; }
    Colour      getGradTernary()            { return grad3; }
    Colour      getGradQuaternary()          { return grad4; }


    // Lines
    void        drawLine(S_2CRD);
    void        drawLine(S_2CRD, Colour c);

    void        drawLineH(S_XY, sint16 x2);
    void        drawLineH(S_XY, sint16 x2, Colour c);
    void        drawLineV(S_XY, sint16 y2);
    void        drawLineV(S_XY, sint16 y2, Colour c);


    // Triangles Outline
    void    drawTri(S_3CRD);
    void    drawTri(S_3CRD, Colour c);

    // Rectangles Outline
    void    drawRect(S_2CRD);
    void    drawRect(S_2CRD, Colour c);

    // Rectangles Solid
    void    eraseRect(S_2CRD);
    void    fillRect(S_2CRD);
    void    fillRect(S_2CRD, Colour c);

    void        showInfo();
  public:
    DrawAmiOS();
    ~DrawAmiOS();
};

////////////////////////////////////////////////////////////////////////////////


DrawAmiOS::DrawAmiOS() : canvas(0), view(0), stroke(0xFF000000), fill(0xFFFFFFFF),
                   clear(0xFFC0C0C0), grad1(0), grad2(0), grad3(0), grad4(0),
                   strokePen(-1), fillPen(-1), clearPen(-1), tempPen(-1), nest(0),
                   use8Bit(false)
{
  InitRastPort(&rastPort);
}

////////////////////////////////////////////////////////////////////////////////

DrawAmiOS::~DrawAmiOS()
{
  freePens();
}

////////////////////////////////////////////////////////////////////////////////

void DrawAmiOS::getPens()
{
  // Allocate pens exclusively, setting desired colours at same time
  if (view && !use8Bit)
  {
    strokePen  = ObtainPen(view->ColorMap, -1,
                          stroke.red()<<24,
                          stroke.green()<<24,
                          stroke.blue()<<24,
                          PEN_EXCLUSIVE);

    fillPen    = ObtainPen(view->ColorMap, -1,
                          fill.red()<<24,
                          fill.green()<<24,
                          fill.blue()<<24,
                          PEN_EXCLUSIVE);

    clearPen  = ObtainPen(view->ColorMap, -1,
                          clear.red()<<24,
                          clear.green()<<24,
                          clear.blue()<<24,
                          PEN_EXCLUSIVE);

    tempPen    = ObtainPen(view->ColorMap, -1, 0, 0, 0, PEN_EXCLUSIVE);
  }
}

////////////////////////////////////////////////////////////////////////////////

void DrawAmiOS::freePens()
{
  if (view)
  {
    if (strokePen != -1)
    {
      ReleasePen(view->ColorMap, strokePen);
      strokePen = -1;
    }
    if (fillPen != -1)
    {
      ReleasePen(view->ColorMap, fillPen);
      fillPen = -1;
    }
    if (clearPen != -1)
    {
      ReleasePen(view->ColorMap, clearPen);
      clearPen = -1;
    }
    if (tempPen != -1)
    {
      ReleasePen(view->ColorMap, tempPen);
      tempPen = -1;
    }
  }
}

////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
//
//  Internally allocated pen drawing functions (for use on RGB screens)
//
////////////////////////////////////////////////////////////////////////////////

void DrawAmiOS::setPenRGB(sint16 pen, Colour& c)
{
  // according to docs, this is faster than SetRGB32, even for 1 colour...
  if (view && use8Bit==false)
  {
    uint32 rgb32tab[] = {
      1UL<<16|(pen&255),
      (uint32)(c.red())<<24,
      (uint32)(c.green())<<24,
      (uint32)(c.blue())<<24,
      0
    };
    LoadRGB32(view, rgb32tab);
  }
}

////////////////////////////////////////////////////////////////////////////////

void DrawAmiOS::line(sint16 pen, S_2CRD)
{
  // Does line segment cross clip area?

  // First check that the x range falls within our clip width.
  // If both x ordinates are simultaneously off-left or off-right, we can exit
  if ( ((x1 < clipL) && (x2 < clipL)) ||
       ((x1 > clipR) && (x2 > clipR)) )
    return;

  // Now check that the y range falls within our clip height.
  // If both y ordinates are simultaneously off-top or off-bottom, we can exit
  if ( ((y1 < clipT) && (y2 < clipT)) ||
       ((y1 > clipB) && (y2 > clipB)) )
    return;

  // TO DO : clip to segment
  if (pen != lastAPen)
  {
    SetAPen(&rastPort, pen);
    lastAPen = pen;
  }
  Move(&rastPort, x1, y1);
  Draw(&rastPort, x2, y2);
}

////////////////////////////////////////////////////////////////////////////////

void DrawAmiOS::lineH(sint16 pen, sint16 x1, sint16 y, sint16 x2)
{
  if ( (y < clipT) || (y > clipB) )
    return;
  if ( ((x1 < clipL) && (x2 < clipL)) ||
       ((x1 > clipR) && (x2 > clipR)) )
    return;

  if (pen != lastAPen)
  {
    SetAPen(&rastPort, pen);
    lastAPen = pen;
  }
  Move(&rastPort, Clamp::integer(x1, clipL, clipR), y);
  Draw(&rastPort, Clamp::integer(x2, clipL, clipR), y);
}

////////////////////////////////////////////////////////////////////////////////

void DrawAmiOS::lineV(sint16 pen, sint16 x, sint16 y1, sint16 y2)
{
  if ( (x < clipL) || (x > clipR) )
    return;
  if ( ((y1 < clipT) && (y2 < clipT)) ||
       ((y1 > clipB) && (y2 > clipB)) )
    return;

  if (pen != lastAPen)
  {
    SetAPen(&rastPort, pen);
    lastAPen = pen;
  }
  Move(&rastPort, x, Clamp::integer(y1, clipT, clipB));
  Draw(&rastPort, x, Clamp::integer(y2, clipT, clipB));
}

////////////////////////////////////////////////////////////////////////////////

void DrawAmiOS::drawRect(sint16 pen, S_2CRD)
{
  // First clamp the values to the clip extent
  if (pen != lastAPen)
  {
    SetAPen(&rastPort, pen);
    lastAPen = pen;
  }
  sint16 tx1 = Clamp::integer(x1, clipL, clipR);
  sint16 tx2 = Clamp::integer(x2, clipL, clipR);
  sint16 ty1 = Clamp::integer(y1, clipT, clipB);
  sint16 ty2 = Clamp::integer(y2, clipT, clipB);
  // top line
  if ((y1 >= clipT) && (y1 <= clipB))
  {
    Move(&rastPort, tx1, y1);
    Draw(&rastPort, tx2, y1);
  }
  // bottom line
  if ((y2 >= clipT) && (y2 <= clipB))
  {
    Move(&rastPort, tx1, y2);
    Draw(&rastPort, tx2, y2);
  }
  // left line
  if ((x1 >= clipL) && (x1 <= clipR))
  {
    Move(&rastPort, x1, ty1);
    Draw(&rastPort, x1, ty2);
  }
  // right line
  if ((x2 >= clipL) && (x2 <= clipR))
  {
    Move(&rastPort, x2, ty1);
    Draw(&rastPort, x2, ty2);
  }
}

////////////////////////////////////////////////////////////////////////////////

void DrawAmiOS::fillRect(sint16 pen, S_2CRD)
{
  // First clamp the values to the clip extent
  x1 = Clamp::integer(x1, clipL, clipR);
  x2 = Clamp::integer(x2, clipL, clipR);
  if (x1 == x2)
    return;
  else if (x2 < x1)
  {
    sint16 tx = x2;
    x2 = x1;
    x1 = tx;
  }
  y1 = Clamp::integer(y1, clipT, clipB);
  y2 = Clamp::integer(y2, clipT, clipB);
  if (y2 == y1)
    return;
  else if (y2 < y1)
  {
    sint16 ty = y2;
    y2 = y1;
    y1 = ty;
  }
  if (pen != lastAPen)
  {
    SetAPen(&rastPort, pen);
    lastAPen = pen;
  }
  RectFill(&rastPort, x1, y1, x2, y2);
}

////////////////////////////////////////////////////////////////////////////////
//
//  On the fly colour matching draw functions (for use on paletted screens)
//
////////////////////////////////////////////////////////////////////////////////

void DrawAmiOS::line8(Colour& c, S_2CRD)
{
  // Does line segment cross clip area?

  // First check that the x range falls within our clip width.
  // If both x ordinates are simultaneously off-left or off-right, we can exit
  if ( ((x1 < clipL) && (x2 < clipL)) ||
       ((x1 > clipR) && (x2 > clipR)) )
    return;

  // Now check that the y range falls within our clip height.
  // If both y ordinates are simultaneously off-top or off-bottom, we can exit
  if ( ((y1 < clipT) && (y2 < clipT)) ||
       ((y1 > clipB) && (y2 > clipB)) )
    return;

  uint32 pen = ObtainBestPen(view->ColorMap, c.red()<<24, c.green()<<24, c.blue()<<24,
                          OBP_Precision, PRECISION_IMAGE);
  SetAPen(&rastPort, pen);
  Move(&rastPort, x1, y1);
  Draw(&rastPort, x2, y2);
  ReleasePen(view->ColorMap, pen);
}

////////////////////////////////////////////////////////////////////////////////

void DrawAmiOS::lineH8(Colour& c, sint16 x1, sint16 y, sint16 x2)
{
  if ( (y < clipT) || (y > clipB) )
    return;
  if ( ((x1 < clipL) && (x2 < clipL)) ||
       ((x1 > clipR) && (x2 > clipR)) )
    return;

  uint32 pen = ObtainBestPen(view->ColorMap, c.red()<<24, c.green()<<24, c.blue()<<24,
                          OBP_Precision, PRECISION_IMAGE);
  SetAPen(&rastPort, pen);
  Move(&rastPort, Clamp::integer(x1, clipL, clipR), y);
  Draw(&rastPort, Clamp::integer(x2, clipL, clipR), y);
  ReleasePen(view->ColorMap, pen);
}

////////////////////////////////////////////////////////////////////////////////

void DrawAmiOS::lineV8(Colour& c, sint16 x, sint16 y1, sint16 y2)
{
  if ( (x < clipL) || (x > clipR) )
    return;
  if ( ((y1 < clipT) && (y2 < clipT)) ||
       ((y1 > clipB) && (y2 > clipB)) )
    return;

  uint32 pen = ObtainBestPen(view->ColorMap, c.red()<<24, c.green()<<24, c.blue()<<24,
                          OBP_Precision, PRECISION_IMAGE);
  SetAPen(&rastPort, pen);
  Move(&rastPort, x, Clamp::integer(y1, clipT, clipB));
  Draw(&rastPort, x, Clamp::integer(y2, clipT, clipB));
  ReleasePen(view->ColorMap, pen);
}

////////////////////////////////////////////////////////////////////////////////

void DrawAmiOS::drawRect8(Colour& c, S_2CRD)
{
  // First clamp the values to the clip extent
  uint32 pen = ObtainBestPen(view->ColorMap, c.red()<<24, c.green()<<24, c.blue()<<24,
                          OBP_Precision, PRECISION_IMAGE);
  SetAPen(&rastPort, pen);

  sint16 tx1 = Clamp::integer(x1, clipL, clipR);
  sint16 tx2 = Clamp::integer(x2, clipL, clipR);
  sint16 ty1 = Clamp::integer(y1, clipT, clipB);
  sint16 ty2 = Clamp::integer(y2, clipT, clipB);
  // top line
  if ((y1 >= clipT) && (y1 <= clipB))
  {
    Move(&rastPort, tx1, y1);
    Draw(&rastPort, tx2, y1);
  }
  // bottom line
  if ((y2 >= clipT) && (y2 <= clipB))
  {
    Move(&rastPort, tx1, y2);
    Draw(&rastPort, tx2, y2);
  }
  // left line
  if ((x1 >= clipL) && (x1 <= clipR))
  {
    Move(&rastPort, x1, ty1);
    Draw(&rastPort, x1, ty2);
  }
  // right line
  if ((x2 >= clipL) && (x2 <= clipR))
  {
    Move(&rastPort, x2, ty1);
    Draw(&rastPort, x2, ty2);
  }
  ReleasePen(view->ColorMap, pen);
}

////////////////////////////////////////////////////////////////////////////////

void DrawAmiOS::fillRect8(Colour& c, S_2CRD)
{
  // First clamp the values to the clip extent
  x1 = Clamp::integer(x1, clipL, clipR);
  x2 = Clamp::integer(x2, clipL, clipR);
  if (x1 == x2)
    return;
  else if (x2 < x1)
  {
    sint16 tx = x2;
    x2 = x1;
    x1 = tx;
  }
  y1 = Clamp::integer(y1, clipT, clipB);
  y2 = Clamp::integer(y2, clipT, clipB);
  if (y2 == y1)
    return;
  else if (y2 < y1)
  {
    sint16 ty = y2;
    y2 = y1;
    y1 = ty;
  }

  uint32 pen = ObtainBestPen(view->ColorMap, c.red()<<24, c.green()<<24, c.blue()<<24,
                          OBP_Precision, PRECISION_IMAGE);
  SetAPen(&rastPort, pen);
  RectFill(&rastPort, x1, y1, x2, y2);
  ReleasePen(view->ColorMap, pen);
}

////////////////////////////////////////////////////////////////////////////////


void DrawAmiOS::showInfo()
{
  if (use8Bit)
    SystemLib::dialogueBox("DrawAmiOS", "Ok", "8-bit mode : Using shared pens");
  else
    SystemLib::dialogueBox("DrawAmiOS", "Ok",
      "RGB mode : Using exclusive pens\n"
      "strokePen locked : %3hd\n"
      "fillPen   locked : %3hd\n"
      "clearPen  locked : %3hd\n"
      "tempPen   locked : %3hd",
      strokePen,
      fillPen,
      clearPen,
      tempPen);
}

////////////////////////////////////////////////////////////////////////////////

sint32 DrawAmiOS::begin()
{
  nest++;
  return OK;
}

////////////////////////////////////////////////////////////////////////////////

void DrawAmiOS::end()
{
  if (nest>0)
    --nest;
}

////////////////////////////////////////////////////////////////////////////////

Surface* DrawAmiOS::getCanvas()
{
  return canvas;
}

////////////////////////////////////////////////////////////////////////////////

sint32 DrawAmiOS::setCanvas(Surface* s)
{
  if (nest>0)
    return ERR_RSC_LOCKED;
  if (!s)
    return ERR_PTR_ZERO;
  if (s->getDepth() < 8)
    return ERR_RSC_TYPE;
  else if (s->getDepth()==8)
    use8Bit = true;
  else
    use8Bit = false;

  if (s != canvas)
  {
    BitMap*   bMap;
    ViewPort*  nView;
    if (!(bMap = getSurfaceRep(s)) || !getWinUser(s) ||
        !(nView = &(getWinUser(s)->WScreen->ViewPort)))
      return ERR_RSC_INVALID;

    // If new surface dimension is different reset clip area to new
    // canvas size
    if (s->getW() != canvas->getW() || s->getH() != canvas->getH())
    {
      clipL    = 0;
      clipT    = 0;
      clipR    = s->getW()-1;
      clipB    = s->getH()-1;
    }

    // Assign the new canvas and update RastPort
    canvas = s;
    rastPort.BitMap = bMap;

    // Check if new canvas' window handle referenes a different ColorMap
    if (nView != view)
    {
      view = nView;
      freePens();
      getPens();
    }
  }
  return OK;
}

////////////////////////////////////////////////////////////////////////////////

sint32 DrawAmiOS::setClip(S_2CRD)
{
  // First clamp the values to the maximum surface extent
  x1 = Clamp::integer(x1, 0, canvas->getW()-1);
  x2 = Clamp::integer(x2, 0, canvas->getW()-1);
  if (x1 == x2)
    return ERR_VALUE;
  else if (x2 < x1)
  {
    sint16 tx = x2;
    x2 = x1;
    x1 = tx;
  }
  y1 = Clamp::integer(y1, 0, canvas->getH()-1);
  y2 = Clamp::integer(y2, 0, canvas->getH()-1);
  if (y2 == y1)
    return ERR_VALUE;
  else if (y2 < y1)
  {
    sint16 ty = y2;
    y2 = y1;
    y1 = ty;
  }
  clipL = x1;
  clipR = x2;
  clipT = y1;
  clipB = y2;
  return OK;
}

////////////////////////////////////////////////////////////////////////////////

void DrawAmiOS::setStrokeColour(Colour c)
{
  if (stroke != c)
  {
    setPenRGB(strokePen, c);
    stroke = c;
  }
}

////////////////////////////////////////////////////////////////////////////////

void DrawAmiOS::setFlatFillColour(Colour c)
{
  if (fill != c)
  {
    setPenRGB(fillPen, c);
    fill = c;
  }
}

////////////////////////////////////////////////////////////////////////////////

void DrawAmiOS::setClearColour(Colour c)
{
  if (clear != c)
  {
    setPenRGB(clearPen, c);
    clear = c;
  }
}

////////////////////////////////////////////////////////////////////////////////

void DrawAmiOS::drawLine(S_2CRD)
{
  if (use8Bit)
    line8(stroke, x1, y1, x2, y2);
  else
    line(strokePen, x1, y1, x2, y2);
}

////////////////////////////////////////////////////////////////////////////////

void DrawAmiOS::drawLine(S_2CRD, Colour c)
{
  if (use8Bit)
    line8(c, x1, y1, x2, y2);
  else
  {
    setPenRGB(tempPen, c);
    line(tempPen, x1, y1, x2, y2);
  }
}

////////////////////////////////////////////////////////////////////////////////

void DrawAmiOS::drawLineH(S_XY, sint16 x2)
{
  if (use8Bit)
    lineH8(stroke, x, y, x2);
  else
    lineH(strokePen, x, y, x2);
}

////////////////////////////////////////////////////////////////////////////////

void DrawAmiOS::drawLineH(S_XY, sint16 x2, Colour c)
{
  if (use8Bit)
    lineH8(c, x, y, x2);
  else
  {
    setPenRGB(tempPen, c);
    lineH(tempPen, x, y, x2);
  }
}

////////////////////////////////////////////////////////////////////////////////

void DrawAmiOS::drawLineV(S_XY, sint16 y2)
{
  if (use8Bit)
    lineV8(stroke, x, y, y2);
  else
    lineV(strokePen, x, y, y2);
}

////////////////////////////////////////////////////////////////////////////////

void DrawAmiOS::drawLineV(S_XY, sint16 y2, Colour c)
{
  if (use8Bit)
    lineV8(stroke, x, y, y2);
  else
  {
    setPenRGB(tempPen, c);
    lineV(tempPen, x, y, y2);
  }
}

////////////////////////////////////////////////////////////////////////////////

void DrawAmiOS::drawTri(S_3CRD)
{
  if (use8Bit)
  {
    line8(stroke, x1, y1, x2, y2);
    line8(stroke, x2, y2, x3, y3);
    line8(stroke, x3, y3, x1, y1);
  }
  else
  {
    line(strokePen, x1, y1, x2, y2);
    line(strokePen, x2, y2, x3, y3);
    line(strokePen, x3, y3, x1, y1);
  }
}

////////////////////////////////////////////////////////////////////////////////

void DrawAmiOS::drawTri(S_3CRD, Colour c)
{
  if (use8Bit)
  {
    line8(c, x1, y1, x2, y2);
    line8(c, x2, y2, x3, y3);
    line8(c, x3, y3, x1, y1);
  }
  else
  {
    setPenRGB(tempPen, c);
    line(tempPen, x1, y1, x2, y2);
    line(tempPen, x2, y2, x3, y3);
    line(tempPen, x3, y3, x1, y1);
  }
}

////////////////////////////////////////////////////////////////////////////////

void DrawAmiOS::drawRect(S_2CRD)
{
  if (use8Bit)
    drawRect8(stroke, x1, y1, x2, y2);
  else
    drawRect(strokePen, x1, y1, x2, y2);
}

////////////////////////////////////////////////////////////////////////////////

void DrawAmiOS::drawRect(S_2CRD, Colour c)
{
  if (use8Bit)
    drawRect8(c, x1, y1, x2, y2);
  else
  {
    setPenRGB(tempPen, c);
    drawRect(tempPen, x1, y1, x2, y2);
  }
}

////////////////////////////////////////////////////////////////////////////////

void DrawAmiOS::eraseRect(S_2CRD)
{
  if (use8Bit)
    fillRect8(clear, x1, y1, x2, y2);
  else
    fillRect(clearPen, x1, y1, x2, y2);
}

////////////////////////////////////////////////////////////////////////////////

void DrawAmiOS::fillRect(S_2CRD)
{
  if (use8Bit)
    fillRect8(fill, x1, y1, x2, y2);
  else
    fillRect(fillPen, x1, y1, x2, y2);
}

////////////////////////////////////////////////////////////////////////////////

void DrawAmiOS::fillRect(S_2CRD, Colour c)
{
  if (use8Bit)
    fillRect8(c, x1, y1, x2, y2);
  else
  {
    setPenRGB(tempPen, c);
    fillRect(tempPen, x1, y1, x2, y2);
  }
}

////////////////////////////////////////////////////////////////////////////////
//
//  test factory
//
////////////////////////////////////////////////////////////////////////////////

Draw2D* testCreateDraw(Surface* s)
{
  if (!s)
    return 0;
  DrawAmiOS* d = new DrawAmiOS();
  if (d)
  {
    if (d->setCanvas(s) == OK)
    {
      //d->showInfo();
      return d;
    }
    delete d;
  }
  return 0;
}

////////////////////////////////////////////////////////////////////////////////