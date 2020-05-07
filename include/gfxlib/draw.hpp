//****************************************************************************//
//**                                                                        **//
//** File:         include/gfxlib/draw.hpp                                  **//
//** Description:  Drawing functions                                        **//
//** Comment(s):   Stub header                                              **//
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

#ifndef _EXTROPIA_GFXLIB_DRAW_HPP
#define _EXTROPIA_GFXLIB_DRAW_HPP

#include <gfxlib/gfx.hpp>
#include <gfxlib/gfx3d.hpp>

////////////////////////////////////////////////////////////////////////////////
//
//  Draw Library
//
//  This header is included by the native implementations and by library users
//
//
////////////////////////////////////////////////////////////////////////////////




////////////////////////////////////////////////////////////////////////////////
//
//  DrawImg, simple high level 2D image interface
//
//  Encapsulates an image that can be drawn using the Draw2D interface. Once
//  created, the image cannot be modified. A given Draw2D implementor will
//  implement this class in whatever way makes most sense for it.
//
////////////////////////////////////////////////////////////////////////////////

class DrawImg {
  public:
    virtual PixelDescriptor*  getFormat() = 0;
    virtual sint16  getW()                = 0;
    virtual sint16  getH()                = 0;
};


////////////////////////////////////////////////////////////////////////////////
//
//  DrawImgWritable, simple high level 2D image interface
//
//  Encapsulates an image that can be drawn using the Draw2D interface. This
//  variety of image allows modification of the pixel data.
//
////////////////////////////////////////////////////////////////////////////////

class DrawImgWr {
  public:
    virtual PixelDescriptor*  getFormat()       = 0;
    virtual sint16            getW()            = 0;
    virtual sint16            getH()            = 0;
    virtual sint16            getModulus()      = 0;
    virtual void*              lock()           = 0;
    virtual void              unlock()          = 0;
    virtual void              refresh(S_XYWH)   = 0;
};

////////////////////////////////////////////////////////////////////////////////
//
//  Draw2D, simple high level 2D interface for primitives
//
//  A Draw2D derived class is obtained from DrawFactory.
//
////////////////////////////////////////////////////////////////////////////////


class Draw2D {

  public:
    // Draw features. The user can use these constants to query the particular
    // Draw2D implementation they have to see what it can support.

    typedef enum {
      DR_LINES = 1,              // line draw
      DR_TRIS,                   // triangle draw
      DR_RECT,                   // rectangle draw
      DR_ELIPSE,                 // ellipse/circle draw
      FX_HORZ_GRAD,              // horizontal gradients in general
      FX_VERT_GRAD,              // vertical gradients in general
      FX_FREE_GRAD,              // free (colour per vertex) gradients in general
      FX_LINE_GRAD,              // line gradients
      FX_TRIS_GRAD,              // triangle gradients in general
      FX_TRIS_H_GRAD,            // horizontal triangle gradients
      FX_TRIS_V_GRAD,            // vertical triangle gradients
      FX_TRIS_F_GRAD,            // free triangle gradients
      FX_RECT_H_GRAD,            // horizontal rectangle gradients
      FX_RECT_V_GRAD,            // vertical rectangle gradients
      FX_RECT_F_GRAD,            // free rectangle gradients
      FX_TRANSPARENCY,           // transparency in general (alpha channels used)
      FX_TRANS_GRAD,             // transparency gradients (alpha channels interpolated)
      FX_IMAGE,                  // images
      FX_IMAGE_WRITE,            // writable images
      FX_IMAGE_SCALE,            // image scaling
      FX_IMAGE_BLEND,            // blends in general
      FX_IMAGE_BLEND_IMAGE,      // image (replace) blend
      FX_IMAGE_BLEND_DECAL,      // GL_DECAL style (image alpha controls image/colour mix) blend
      FX_IMAGE_BLEND_MODULATE    // GL_MODULATE style (image*colour mix) blend
    } Query;

    typedef enum {
      UNSUPPORTED = 0,    // no support at all
      PARTIAL,            // partial support (usually with 'general' queries)
      SLOW,               // feature implemented but may be slow, however
      SUPPORTED,          // feature is implemented sufficiently for normal use
      ACCELERATED         // wheee!
    } Support;

    virtual Support query(Query feature) = 0;

  public:
    // Draw gathering. No drawing methods may be called outside begin()/end().
    // Calls may be nested, but all begin() operations must be properly
    // terminated by end().
    // When the physical drawing takes place is up to the implementation.
    // Software only drawing may do it immediately, hardware versions may
    // buffer calls to gather into a short exclusive lock on the hardware
    // resources. Hence, You may not assume anything about the exact timing
    // of the actual rednering.

    virtual ~Draw2D() {}

    virtual sint32  begin() = 0;
    virtual void    end()   = 0;

    // Surface assignment. Each Draw2D implementor must be bound to a canvas
    // Surface upon which all its drawing operations will take place.
    // Changing the canvas is only possible outside of a begin()/end().
    // Implemtations must try to ensure that changing surfaces is quick when
    // the new surface matches the existing one (dimension/format).
    // This is essential for fast double buffering with fullscreen displays
    // where the mechanism uses a 'flip buffer' approach.

    virtual sint32    setCanvas(Surface* s)  = 0;
    virtual Surface*  getCanvas()            = 0;
    virtual sint32    setClip(S_2CRD)        = 0;

    // Image factory. Each Draw2D implementor will produce DrawImg objects
    // using a representation that makes most sense for it. DrawImg objects
    // created by one Draw2D object may not generally be used with another.
    // DrawImg objects are not modifiable once made, so are manufactured from
    // existing ImageBuffer objects that contain the actual source image data.
    // Since some user is bound to require an image they can modify, we also
    // have a factory for DrawImgWr, that allows locked access to its
    // representation. Due to large potential internal differences, DrawImg
    // and DrawImgWr share methods but are seperate classes and not
    // intented fot total interchangability.

    virtual DrawImg*    createImage(ImageBuffer* i)           = 0;
    virtual DrawImgWr*  createImageWriteable(ImageBuffer* i)  = 0;
    virtual sint32      destroyImage(DrawImg* i)              = 0;
    virtual sint32      destroyImage(DrawImgWr* i)            = 0;

    // Colours. We define several colours for general purpose drawing.
    // Stroke is for lines and outlines.
    // FlatFill is for normal solid fills
    // Clear is for background / erase operations

    virtual void    setStrokeColour(Colour c)                 = 0;
    virtual void    setFlatFillColour(Colour c)               = 0;
    virtual void    setClearColour(Colour c)                  = 0;

    virtual Colour  getStrokeColour()                         = 0;
    virtual Colour  getFlatFillColour()                       = 0;
    virtual Colour  getClearColour()                          = 0;

    // Fill images. Basically these allow us to set a default image to use
    // for solid fills and clear operations. Such fill images can be tiled
    // or stretched depending on the tile argument set.

    // Fill images may be mixed with the corresponding fill / gradient colours.

    // These features are optional to tbe implementor, default behaviour is to
    // safely 'do nothing'.

    typedef enum {
      IMAGE    = 0,
      DECAL,
      MODULATE
    } FillBlend;

    virtual void      setFillImage(DrawImg* i, float32 ofsX = 1.0, float32 ofsY = 1.0,
                                   float32 magX = 1.0, float32 magY = 1.0, bool tile = true) = 0;
    virtual  DrawImg*  getFillImage()                   = 0;

    virtual  void      setFillImageBlend(FillBlend f)   = 0;
    virtual FillBlend  getFillImageBlend()              = 0;

    // drawing

    // Lines
    virtual void    drawLine(S_2CRD)                                      { }
    virtual void    drawLine(S_2CRD, Colour c)                            { }
    virtual void    drawLineGrad(S_2CRD, Colour c1, Colour c2)            { }
    virtual void    drawLineH(S_XY, sint16 x2)                            { }
    virtual void    drawLineH(S_XY, sint16 x2, Colour c)                  { }
    virtual void    drawLineV(S_XY, sint16 y2)                            { }
    virtual void    drawLineV(S_XY, sint16 y2, Colour c)                  { }
    virtual void    drawLineHGrad(S_XY, sint16 x2, Colour c1, Colour c2)  { }
    virtual void    drawLineVGrad(S_XY, sint16 y2, Colour c1, Colour c2)  { }

    // Triangles Outline
    virtual void    drawTri(S_3CRD)                                       { }
    virtual void    drawTri(S_3CRD, Colour c)                             { }
    virtual void    drawTriGradH(S_3CRD, Colour c1, Colour c2)            { }
    virtual void    drawTriGradV(S_3CRD, Colour c1, Colour c2)            { }
    virtual void    drawTriGrad(S_3CRD, Colour c1, Colour c2, Colour c3)  { }

    // Triangles Solid
    virtual void    fillTri(S_3CRD)                                       { }
    virtual void    fillTri(S_3CRD, Colour c)                             { }
    virtual void    fillTriGradH(S_3CRD, Colour c1, Colour c2)            { }
    virtual void    fillTriGradV(S_3CRD, Colour c1, Colour c2)            { }
    virtual void    fillTriGrad(S_3CRD, Colour c1, Colour c2, Colour c3)  { }

    // Rectangles Outline
    virtual void    drawRect(S_2CRD)                                      { }
    virtual void    drawRect(S_2CRD, Colour c)                            { }
    virtual void    drawRectGradH(S_2CRD, Colour c1, Colour c2)           { }
    virtual void    drawRectGradV(S_2CRD, Colour c1, Colour c2)           { }

    // Rectangles Solid
    virtual void    eraseRect(S_2CRD)                                     { }
    virtual void    fillRect(S_2CRD)                                      { }
    virtual void    fillRect(S_2CRD, Colour c)                            { }
    virtual void    fillRectGradH(S_2CRD, Colour c1, Colour c2)           { }
    virtual void    fillRectGradV(S_2CRD, Colour c1, Colour c2)           { }

};

////////////////////////////////////////////////////////////////////////////////
//
//  DrawFactory
//
////////////////////////////////////////////////////////////////////////////////

class DrawFactory {
  public:
    static Draw2D* getDraw(Surface*);
    static Draw2D* getDraw(Rasterizer*);
};

#endif
