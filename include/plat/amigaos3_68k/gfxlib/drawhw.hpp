//****************************************************************************//
//**                                                                        **//
//** File:         include/plat/amigaos3_68k/gfxlib/drawhw.hpp              **//
//** Description:  Hardware Draw2D implementation                           **//
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

#ifndef _EXTROPIA_GFXLIB_DRAWHW_NATIVE_HPP
#define _EXTROPIA_GFXLIB_DRAWHW_NATIVE_HPP

#define DCMD_ARG

class GPU : protected RasterizerUser {
  protected:
    typedef void (*DrawFunc)(DCMD_ARG);
    struct DCommand {
      DrawFunc cmd;

    };
    static void drawLines(DCMD_ARG);
    static void drawTris(DCMD_ARG);
    static void drawTriFan(DCMD_ARG);

};



////////////////////////////////////////////////////////////////////////////////
//
//  DrawImg : Implementaion of DrawImg interface for Rasterizer based Draw2D
//
////////////////////////////////////////////////////////////////////////////////


class DrawImgHW : public DrawImg {
  friend class Draw2DHW;
  private:
    PixelDescriptor    pd;
    Texture*          tex;

  public:
    PixelDescriptor*  getFormat()  { return &pd; }
    sint16  getW()                { return tex->getW(); }
    sint16  getH()                { return tex->getH(); }

  private:
    // creation/destruction via owner Draw2D only
    DrawImgHW();
    ~DrawImgHW();
};

////////////////////////////////////////////////////////////////////////////////
//
//  Draw2DHW : Implementaion of Draw2D interface for 3D hardware Rasterizer
//
////////////////////////////////////////////////////////////////////////////////

class Draw2DHW : public Draw2D {
  friend class DrawFactory;
  private:
    Rasterizer* rast;
    DrawVertex*  verts;
    Colour      stroke, flat, clear;
    sint32      nestCnt;  // number of nested begin() calls



  public:
    sint32    begin();
    void       end();
    sint32    setCanvas(Surface* s);
    Surface*  getCanvas();
    DrawImg*  createImg(ImageBuffer* i);
    void      destroyImg(DrawImg* i);

    void    setStrokeColour(Colour c);
    void    setFlatFillColour(Colour c);
    void    setClearColour(Colour c);

    Colour  getStrokeColour()      { return stroke; }
    Colour  getFlatFillColour()    { return flat; }
    Colour  getClearColour()      { return clear; }

  private:
    Draw2DHW();

  public:
    ~Draw2DHW();
};


#endif