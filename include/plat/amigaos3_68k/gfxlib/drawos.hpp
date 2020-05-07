//****************************************************************************//
//**                                                                        **//
//** File:         include/plat/amigaos3_68k/gfxlib/drawos.hpp              **//
//** Description:  AmigaOS derived Draw2D Implementation                    **//
//** Comment(s):                                                            **//
//** Library:      gfxlib                                                   **//
//** Created:      2003-04-27                                               **//
//** Updated:      2003-04-27                                               **//
//** Author(s):    Karl Churchill                                           **//
//** Note(s):                                                               **//
//** Copyright:    (C)1996-2003, eXtropia Studios                           **//
//**               Serkan YAZICI, Karl Churchill                            **//
//**               All Rights Reserved.                                     **//
//**                                                                        **//
//****************************************************************************//

#ifndef _EXTROPIA_GFXLIB_DRAW_AMIGAOS_HPP
#define _EXTROPIA_GFXLIB_DRAW_AMIGAOS_HPP

#include <gfxlib/draw.hpp>

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

    void        getPens();
    void        freePens();

    // Common pen-level drawing methods
    void        setPenRGB(sint16 pen, Colour &c);
    void        line(sint16 pen, S_2CRD);
    void        lineH(sint16 pen, sint16 x1, sint16 y, sint16 x2);
    void        lineV(sint16 pen, sint16 x, sint16 y1, sint16 y2);
    void        drawRect(sint16 pen, S_2CRD);
    void        fillRect(sint16 pen, S_2CRD);

  public:
    sint32      begin();
    void        end();
    sint32      setCanvas(Surface* s);
    Surface*    getCanvas();
    sint32      setClip(S_2CRD);

//    DrawImg*    createImage(ImageBuffer* i);
//    DrawImgWr*  createImageWriteable(ImageBuffer* i);
//    sint32      destroyImage(DrawImg* i);
//    sint32      destroyImage(DrawImgWr* i);
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
//    virtual void    drawLineGrad(S_2CRD);
//    virtual void    drawLineGrad(S_2CRD, Colour c1, Colour c2);
    // other line methods for multiple lines...

    void        drawLineH(S_XY, sint16 x2);
    void        drawLineH(S_XY, sint16 x2, Colour c);
    void        drawLineV(S_XY, sint16 y2);
    void        drawLineV(S_XY, sint16 y2, Colour c);


    // Triangles Outline
    void    drawTri(S_3CRD);
    void    drawTri(S_3CRD, Colour c);
//    void    drawTriGradH(S_3CRD);
//    void    drawTriGradV(S_3CRD);
//    void    drawTriGrad(S_3CRD);
//    void    drawTriGradH(S_3CRD, Colour c1, Colour c2);
//    void    drawTriGradV(S_3CRD, Colour c1, Colour c2);
//    void    drawTriGrad(S_3CRD, Colour c1, Colour c2, Colour c3);

    // Triangles Solid
//    void    fillTri(S_3CRD);
//    void    fillTri(S_3CRD, Colour c);
//    void    fillTriGradH(S_3CRD);
//    void    fillTriGradV(S_3CRD);
//    void    fillTriGrad(S_3CRD);
//    void    fillTriGradH(S_3CRD, Colour c1, Colour c2);
//    void    fillTriGradV(S_3CRD, Colour c1, Colour c2);
//    void    fillTriGrad(S_3CRD, Colour c1, Colour c2, Colour c3);

    // Rectangles Outline
    void    drawRect(S_2CRD);
    void    drawRect(S_2CRD, Colour c);
//    void    drawRectGradH(S_2CRD);
//    void    drawRectGradV(S_2CRD);
//    void    drawRectGrad(S_2CRD);
//    void    drawRectGradH(S_2CRD, Colour c1, Colour c2);
//    void    drawRectGradV(S_2CRD, Colour c1, Colour c2);

    // Rectangles Solid
    void    eraseRect(S_2CRD);
    void    fillRect(S_2CRD);
    void    fillRect(S_2CRD, Colour c);
//    void    fillRectGradH(S_2CRD);
//    void    fillRectGradV(S_2CRD);
//    void    fillRectGrad(S_2CRD);
//    void    fillRectGradH(S_2CRD, Colour c1, Colour c2);
//    void    fillRectGradV(S_2CRD, Colour c1, Colour c2);

    void        showInfo();
  public:
    DrawAmiOS();
    ~DrawAmiOS();
};

#endif
