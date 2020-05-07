//****************************************************************************//
//**                                                                        **//
//** File:         libsrc/plat/amigaos3_68k/gfxlib/drawhw.cpp               **//
//** Description:  Rasterizer based Draw2D implementation                   **//
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

#include <gfxlib/draw.hpp>

using namespace X_SYSNAME;
/*
class DrawBuffer : private RasterizerUser {
  protected:
    typedef void (*DrawFn)(DrawBuffer*, void*);
    typedef struct {
      DrawFn func;
      union {
        sint32        numVerts;
        uint32        colour;
        uint32        state;
        uint32        data;
        float32        depth;
        W3D_Texture*  sysTexture;
        BitMap*        sysSurf;
        DrawVertex*    vertBase;
        Texture*      texObject;
        void*          any;
      };
    } DrawCommand;

    typedef struct {
      DrawVertex* vBase;
      sint32      vPos;
    } VStack;

    typedef struct {
      uint32        stateReg;
      uint32        colourReg;
      uint32        fogReg;
      W3D_Texture*  texture;
    } RegBlock;
};
*/

////////////////////////////////////////////////////////////////////////////////
//
//  DrawImg : Implementaion of DrawImg interface for Rasterizer based Draw2D
//
////////////////////////////////////////////////////////////////////////////////

/*
class DrawImgHW : public DrawImg {
  friend class Draw2DHW;
  private:
    PixelDescriptor    pd;
    W3D_Texture*      tex;
    Draw2DHW*          owner;

  public:
    PixelDescriptor*  getFormat()  { return &pd; }
    sint16  getW()                { return tex->getW(); }
    sint16  getH()                { return tex->getH(); }

  private:
    // creation/destruction via owner Draw2D only
    DrawImgHW();
    ~DrawImgHW();
};




class Draw2DHW : public Draw2D, private RasterizerUser {
  friend class DrawFactory;

  private:
    Rasterizer* rast;
    DrawVertex*  verts;
    Colour      stroke, flat, clear;
    FillBlend    fillBlend;
    sint32      nestCnt;

  public:
    sint32      begin();
    void         end();
    sint32      setCanvas(Surface* s);
    Surface*    getCanvas();
    DrawImg*    createImg(ImageBuffer* i);
    void        destroyImg(DrawImg* i);

    void        setStrokeColour(Colour c);
    void        setFlatFillColour(Colour c);
    void        setClearColour(Colour c);

    Colour      getStrokeColour()      { return stroke; }
    Colour      getFlatFillColour()    { return flat; }
    Colour      getClearColour()      { return clear; }

    void        setFillImage(DrawImg* i, float32 ofsX, float32 ofsY, float32 magX, float32 magY, bool tile);
    virtual      DrawImg*  getFillImage()  { return fillImage; }

    void        setFillImageBlend(FillBlend f);
    FillBlend    getFillImageBlend()        { return fillBlend; }


  private:
    Draw2DHW(Rasterizer* r, DrawVertex* v);

  public:
    ~Draw2DHW();

  static Draw2D* create(Surface* s);

};

Draw2D* Draw2DHW::create(Surface* s)
{
  // obtain a rasterizer for the surface and a vertex buffer.

  Rasterizer* s = G3D::getRasterizer(s);
  if (!s)
    return 0;
  DrawVertex*  v = Mem::alloc(4096*sizeof(DrawVertex), true, Mem::ALIGN_CACHE);
  if (!v) {
    delete s;
    return 0;
  }
  Draw2DHW*   d = new(nothrow) Draw2DHW(s, v);
  if (!d) {
    delete s;
    Mem::free(v);
    return 0;
  }
  return d;
}

Draw2DHW::Draw2DHW(Rasterizer* r) : rast(r);
{
  clear =
}
*/
