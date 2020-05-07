//****************************************************************************//
//**                                                                        **//
//** File:         include/plat/amigaos3_68k/gfxlib/gfx3d.hpp               **//
//** Description:  3D Graphics classes                                      **//
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

#ifndef _EXTROPIA_GFXLIB_GFX3D_NATIVE_HPP
#define _EXTROPIA_GFXLIB_GFX3D_NATIVE_HPP

namespace X_SYSNAME {
  extern "C" {
    #include <proto/warp3d.h>
  }

  extern Library*  Warp3DBase;
};

// size defs for custom vertex array support
#define DV_OFS_XYZ  0                  // byte offset of xyz data
#define DV_OFS_UV    4*sizeof(float32)  //  "     "    "  uv (texture coord) data
#define DV_OFS_W    -sizeof(float32)  //  "     "    "  w from uv
#define DV_OFS_V    sizeof(float32)    //  "     "    "  v from uv
#define DV_OFS_CLR  6*sizeof(float32)  //  "     "    "  colour data
#define DV_STRIDE    sizeof(DrawVertex)//  "     "    "  sequential vertices

////////////////////////////////////////////////////////////////////////////////
//
//  Native3D
//
//  Maps the G3D constants into the values used by the native implementation
//
////////////////////////////////////////////////////////////////////////////////

// Pixel -> Texel conversion
#define PX2TXCONV void* d, void* s, sint16 w, sint16 h, sint16 ds, sint16 ss

class _Nat3D {
  private:
    static uint32 state[G3D::NUM_STATES];

    static uint8  query[G3D::NUM_QUERY];
    static uint8  alphaTest[G3D::NUM_TEST];
    static uint8  zBuffTest[G3D::NUM_TEST];
    static uint8  stencilTest[G3D::NUM_TEST];
    static uint8  stencilUpdate[G3D::NUM_STENCIL];
    static uint8  logicOp[G3D::NUM_LOGIC];
    static uint8  fogMode[G3D::NUM_FOG];
    static uint8  blendMode[G3D::NUM_BLEND];
    static uint8  frontFace[G3D::NUM_FACE];
    static uint8  texel[G3D::NUM_TEXEL];
    static uint8  texEnv[G3D::NUM_TEXENV];
    static uint8  texFill[G3D::NUM_TEXFILL];
    static uint8  texFilter[G3D::NUM_TEXFILTER];

    static uint32  coordType[G3D::NUM_COORDTYPE];
    static uint32  colourType[G3D::NUM_COLOURTYPE];
    static uint32  texCoordType[G3D::NUM_TEXCOORDTYPE];
/*
    typedef void (*Pix2Tex)(PX2TXCONV);
    static Pix2Tex convTabP2T[G3D::NUMTEXEL][Pixel::MAXHWTYPES];
*/
  protected:
    static uint32 getNativeQuery(G3D::Query n)                  { return query[n]; }
    static uint32 getNativeState(G3D::State n)                  { return state[n]; }
    static uint32 getNativeAlphaTest(G3D::Compare n)            { return alphaTest[n]; }
    static uint32 getNativeZBuffTest(G3D::Compare n)            { return zBuffTest[n]; }
    static uint32 getNativeStencilTest(G3D::Compare n)          { return stencilTest[n]; }
    static uint32 getNativeStencilUpdate(G3D::StencilUpdate n)  { return stencilUpdate[n]; }
    static uint32 getNativeLogicOp(G3D::LogicOp n)              { return logicOp[n]; }
    static uint32 getNativeFogMode(G3D::FogMode n)              { return fogMode[n]; }
    static uint32 getNativeBlendMode(G3D::BlendMode n)          { return blendMode[n]; }
    static uint32 getNativeFrontFace(G3D::FrontFace n)          { return frontFace[n]; }
    static uint32 getNativeTexel(G3D::Texel n)                  { return texel[n]; }
    static uint32 getNativeTexEnv(G3D::TexEnv n)                { return texEnv[n]; }
    static uint32 getNativeTexFill(G3D::TexFill n)              { return texFill[n]; }
    static uint32 getNativeTexFilter(G3D::TexFilter n)          { return texFilter[n]; }
    static uint32  getNativeCoordType(G3D::CoordType n)          { return coordType[n]; }
    static uint32  getNativeColourType(G3D::ColourType n)        { return colourType[n]; }
    static uint32  getNativeTexCoordType(G3D::TexCoordType n)    { return texCoordType[n]; }
};


////////////////////////////////////////////////////////////////////////////////
//
//  Rasterizer
//
//  Low level native 3D drawing interface. AmigaOS version encapsulates Warp3D
//  API (v4) using vertex buffer based drawing.
//
////////////////////////////////////////////////////////////////////////////////

#define MESH_MAX_TRIS_PER_CALL  512
#define MESH_INDEX_SIZE          MESH_MAX_TRIS_PER_CALL*3

//#define FIX_WARP3D_POINTS  // use old v3 point rendering
//#define FIX_WARP3D_LINES    // use old v3 line rendering

#define WARP3D_ACCESS_CONTEXT  // dangerous hack that allows direct context access

#define RASTERIZER_STACK_DEPTH 32
#define RASTERIZER_DATA_AREA (sizeof(Rasterizer)*RASTERIZER_STACK_DEPTH)

class Rasterizer : public G3D, protected SurfaceUser, private _Nat3D, private _Nat2D {
  friend Rasterizer* G3D::getRasterizer(Surface*);
  friend class RasterizerUser;
  private:
    static sint32  openCnt;
    X_SYSNAME::W3D_Context*  context;
    X_SYSNAME::W3D_Scissor  drawRegion;

    Surface*      surface;
    Texture*      texture;
#if defined(FIX_WARP3D_POINTS) || defined(FIX_WARP3D_LINES)
    uint8          *vrtPtrX, *vrtPtrY, *vrtPtrZ;
    uint8          *clrPtrA, *clrPtrR, *clrPtrG, *clrPtrB;
    uint8          *texPtrW, *texPtrUS,*texPtrVT;
#endif

    void*                vrtPtr;
    CoordType            vrtPtrType;
    size_t              vrtPtrStride;

    void*                clrPtr;
    ColourType          clrPtrType;
    size_t              clrPtrStride;

    void*                texPtr;
    TexCoordType        texPtrType;
    size_t              texPtrStride;

    Colour              flatColour;
    Colour              maskColour;

    Colour              fogColour;
    FogMode              fogMode;
    X_SYSNAME::W3D_Fog  fogData;

    Compare              alphaTest;
    float32              alphaTestRef;

    Compare              zBuffTest;

    Compare              stencilTest;
    uint32              stencilTestRef;
    uint32              stencilMask;
    uint32              stencilS;
    StencilUpdate        stencilOnFail;
    StencilUpdate       stencilOnPass;

    LogicOp              logicOp;

    BlendMode            blendSrc;
    BlendMode            blendDst;

    FrontFace            windOrder;
    //uint32              stateMask;

    uint16*              meshIndexBuffer;
    uint32              flags;

    // state management stack
    uint32*              pushStack;  // stack push() requests
    uint32*              dataStack;  // contains the data associated with pushes
    sint32              stackPos;

    enum {
      RESOURCEOK  = 0x00000001,
      LOCKED      = 0x00000002,
      HAVEZBUFF    = 0x00000004,
      HAVESTENCIL  = 0x00000008,
    };

  private:
    Rasterizer();                  // Construction via factory only

  private:
  // Vertex array emulation workaround for lines and points
  #if defined(FIX_WARP3D_POINTS) || defined(FIX_WARP3D_LINES)
    typedef bool (*DrawFunc)(Rasterizer*, size_t ofs, size_t cnt);
    #ifdef FIX_WARP3D_POINTS
    static bool drawPointsXYZ_F32_CLR_U8(Rasterizer*, size_t ofs, size_t cnt);
    static bool drawPointsXYZ_F32_CLR_F32(Rasterizer*, size_t ofs, size_t cnt);
    static bool drawPointsXYZ_F64_CLR_U8(Rasterizer*, size_t ofs, size_t cnt);
    static bool drawPointsXYZ_F64_CLR_F32(Rasterizer*, size_t ofs, size_t cnt);
    static DrawFunc drawPointsXYZ_F32[G3D::NUM_COLOURTYPE];
    static DrawFunc drawPointsXYZ_F64[G3D::NUM_COLOURTYPE];
    #endif
    #ifdef FIX_WARP3D_LINES
    static bool drawLinesXYZ_F32_CLR_U8(Rasterizer*, size_t ofs, size_t cnt);
    static bool drawLinesXYZ_F32_CLR_F32(Rasterizer*, size_t ofs, size_t cnt);
    static bool drawLinesXYZ_F64_CLR_U8(Rasterizer*, size_t ofs, size_t cnt);
    static bool drawLinesXYZ_F64_CLR_F32(Rasterizer*, size_t ofs, size_t cnt);
    static bool drawLineStripXYZ_F32_CLR_U8(Rasterizer*, size_t ofs, size_t cnt);
    static bool drawLineStripXYZ_F32_CLR_F32(Rasterizer*, size_t ofs, size_t cnt);
    static bool drawLineStripXYZ_F64_CLR_U8(Rasterizer*, size_t ofs, size_t cnt);
    static bool drawLineStripXYZ_F64_CLR_F32(Rasterizer*, size_t ofs, size_t cnt);
    static DrawFunc drawLinesXYZ_F32[G3D::NUM_COLOURTYPE];
    static DrawFunc drawLinesXYZ_F64[G3D::NUM_COLOURTYPE];
    static DrawFunc drawLineStripXYZ_F32[G3D::NUM_COLOURTYPE];
    static DrawFunc drawLineStripXYZ_F64[G3D::NUM_COLOURTYPE];
    #endif
    static bool useArrayEmul;
  #endif

    // Resource management
    static sint32  init();
    static void    done();
    sint32        associate(Surface* s);
    void          disassociate();
    static        Rasterizer* obtain(Surface* s);  // used by G3D::getRasterizer()

    bool renderTriStripClipped(size_t cnt);

  public:
    Support    supportsFeature(G3D::Query);
    Support    supportsTexelFormat(G3D::Texel);

  #if defined(FIX_WARP3D_POINTS) || defined(FIX_WARP3D_LINES)
    static void    setArrayEmul(bool s) { useArrayEmul = s; }
  #endif
    // Locking
    bool      lock();
    void      unlock();
    bool      isLocked()          { return (flags & LOCKED)!=0; }

    // State
    bool      enable(State s);
    bool      disable(State s);
    bool      isEnabled(State s);

    // Culling
    bool      setFront(FrontFace);
    FrontFace  getFront()          { return windOrder; }

    // Z Buffer
    bool      createZBuffer();
    void      destroyZBuffer();
    bool      writeZBuffer(S_2CRD, float64* p);
    bool      readZBuffer(S_2CRD, float64* p);
    bool      haveZBuffer()        { return (flags & HAVEZBUFF)!=0; }
    bool      clearZBuffer(float64 v);
    bool      setZTest(Compare m);
    Compare    getZTest()          { return zBuffTest; }

    // Stencil Buffer
    bool      createStencilBuffer();
    void      destroyStencilBuffer();
    bool      haveStencilBuffer()  { return (flags & HAVESTENCIL)!=0; }
    bool      clearStencilBuffer(uint32 v);
    bool      writeStencilBuffer(S_2CRD, uint32* p);
    bool      writeStencilBuffer(S_2CRD, uint16* p);
    bool      writeStencilBuffer(S_2CRD, uint8* p);
    bool      readStencilBuffer(S_2CRD, uint32* p);
    bool      setStencilTest(Compare cmp, uint32 ref, uint32 mask);
    bool      setStencilUpdate(uint32 s, StencilUpdate f, StencilUpdate p);
    Compare    getStencilTest()     { return stencilTest; }
    uint32    getStencilRef()      { return stencilTestRef; }
    uint32    getStencilMask()    { return stencilMask; }

    // Alpha testing
    bool       setAlphaTest(Compare m, float32 ref);
    Compare    getAlphaTest()      { return alphaTest; }
    float32    getAlphaRef()        { return alphaTestRef; }

    // Blending
    bool      setBlend(BlendMode s, BlendMode d);
    BlendMode  getBlendSource()    { return blendSrc; }
    BlendMode  getBlendDest()      { return blendDst; }

    // Flat colour
    bool      setFlatColour(Colour c);
    Colour    getFlatColour()      { return flatColour; }


    // Colour masking
    bool      setMaskColour(Colour c);
    Colour    getMaskColour()      { return maskColour; }

    // Fog
    bool      setFog(FogMode m);
    bool      setFog(FogMode m, Colour c, float32 s, float32 e, float32 d);
    FogMode    getFogMode()        { return fogMode; }
    Colour     getFogColour()      { return fogColour; }
    float32    getFogStart()        { return fogData.fog_start; }
    float32    getFogEnd()          { return fogData.fog_end; }
    float32    getFogDensity()      { return fogData.fog_density; }

    // Textures
    bool      setTexture(Texture* t);
    Texture*  getTexture()          { return texture; }
    void      setUnit(size_t unit)  { }
    size_t    getUnit()              { return 0; }

    // States management
    enum {
      // each flag defines a pushable entity
      SM_DRAW_SURFACE  = 0x00000001,  // render surface
      SM_DRAW_AREA    = 0x00000002, // draw region
      SM_DRAW          = 0x00000003,
      SM_STATE        = 0x00000004,  // state switches
      SM_ZBUFF_TEST    = 0x00000008,
      SM_ALPHA_TEST    = 0x00000010,
      SM_STENCIL_TEST  = 0x00000020,
      SM_FLAT_COLOUR  = 0x00000040, // flat shade colour
      SM_TEXTURE      = 0x00000080,
      SM_BLEND        = 0x00000100,
      SM_LOGIC        = 0x00000200, // logic op
      SM_FOG          = 0x00000400,
      SM_VERTEX_PTR    = 0x10000000,
      SM_COLOUR_PTR    = 0x20000000,
      SM_TEXTURE_PTR  = 0x40000000
    };
    bool      push(uint32 flags);
    bool      pop();

    // Drawing
    bool      setDrawSurface(Surface* s);
    Surface*  getDrawSurface()    { return surface; }
    bool      setDrawArea(S_2CRD, Surface* s=0);
    sint32    getLeftLimit()      { return drawRegion.left; }
    sint32    getRightLimit()      { return drawRegion.left + drawRegion.width; }
    sint32    getTopLimit()        { return drawRegion.top; }
    sint32    getBottomLimit()    { return drawRegion.top + drawRegion.height; }
    bool      clearDrawArea(Colour c);
    bool      clearDrawArea();
    void      flush();

    // Array setup
    bool      setVertices(DrawVertex* v);
    bool      setVertexData(XYZ_f32* p, size_t stride);
    bool      setVertexData(XYZ_f64* p, size_t stride);
    bool      setVertexData(void* p, CoordType, size_t stride);
    bool      setColourData(ARGB_u8 *p, size_t stride);
    bool      setColourData(RGBA_u8 *p, size_t stride);
    bool      setColourData(ARGB_f32 *p, size_t stride);
    bool      setColourData(RGBA_f32 *p, size_t stride);
    bool      setColourData(void* p, ColourType, size_t stride);
    bool      setTextureData(WUV_f32 *p, size_t stride);
    bool      setTextureData(UVW_f32 *p, size_t stride);
    bool      setTextureData(WST_f32 *p, size_t stride);
    bool      setTextureData(STW_f32 *p, size_t stride);
    bool      setTextureData(void* p, TexCoordType, size_t stride);

    // Drawing
    bool      drawPoints(size_t ofs, size_t n);
    bool      drawPointsIdx8(size_t n, uint8* idxBuffer);
    bool      drawPointsIdx16(size_t n, uint16* idxBuffer);
    bool      drawPointsIdx32(size_t n, uint32* idxBuffer);
    bool      drawLines(size_t ofs, size_t n);
    bool      drawLinesIdx8(size_t n, uint8* idxBuffer);
    bool      drawLinesIdx16(size_t n, uint16* idxBuffer);
    bool      drawLinesIdx32(size_t n, uint32* idxBuffer);
    bool      drawLineStrip(size_t ofs, size_t n);
    bool      drawLineStripIdx8(size_t n, uint8* idxBuffer);
    bool      drawLineStripIdx16(size_t n, uint16* idxBuffer);
    bool      drawLineStripIdx32(size_t n, uint32* idxBuffer);
    bool      drawTris(size_t ofs, size_t n);
    bool      drawTrisIdx8(size_t n, uint8* idxBuffer);
    bool      drawTrisIdx16(size_t n, uint16* idxBuffer);
    bool      drawTrisIdx32(size_t n, uint32* idxBuffer);
    bool      drawTriFan(size_t ofs, size_t n);
    bool      drawTriFanIdx8(size_t n, uint8* idxBuffer);
    bool      drawTriFanIdx16(size_t n, uint16* idxBuffer);
    bool      drawTriFanIdx32(size_t n, uint32* idxBuffer);
    bool      drawTriStrip(size_t ofs, size_t n);
    bool      drawTriStripIdx8(size_t n, uint8* idxBuffer);
    bool      drawTriStripIdx16(size_t n, uint16* idxBuffer);
    bool      drawTriStripIdx32(size_t n, uint32* idxBuffer);
    bool      drawTriMesh(size_t ofs, size_t dx, size_t dy);
    bool      drawTriMesh2(size_t ofs, size_t dx, size_t dy);


    uint32    getW3DResult() { return context->TPFlags[15]; }


  public:
    ~Rasterizer();
};

////////////////////////////////////////////////////////////////////////////////
//
//  RasterizerUser
//
////////////////////////////////////////////////////////////////////////////////

class RasterizerUser {
  protected:
    static X_SYSNAME::W3D_Context*  getRasterizerContext(Rasterizer* r) {
      return r->context;
    }
};

////////////////////////////////////////////////////////////////////////////////
//
//  Texture
//
//  Encapsulates a texture object. Textures may only be used with whatever
//  Rasterizer that they have been asssociated with. However, textures can
//  be dissasociated with a Rasterizer and can then be associated with another.
//
////////////////////////////////////////////////////////////////////////////////

class Texture : public Area, private _Nat3D, private ImageBufferProvider, protected RasterizerUser {
  friend class Rasterizer;
  private:
    X_SYSNAME::W3D_Context*    owner;
    X_SYSNAME::W3D_Texture*    tex;
    uint32          properties;
    void*            data;
    Palette*        palette;
    G3D::Texel      format;
    G3D::TexFilter  mag, min;
    G3D::TexEnv      env;
    enum {
      OWN_DATA    = 0x00000001,
      OWN_PALETTE  = 0x00000002
    };
  public:
    typedef enum {
      COPY_IB_ONLY        = 0,
      CONV_IB_DEL_NEVER,
      CONV_IB_DEL_SUCCESS,
      CONV_IB_DEL_ALWAYS
    } IBConv;
    static        Texture* convertImageBuffer(ImageBuffer* iBuf, IBConv action);
    void*          getData()      { return data; }
    G3D::Texel    getFormat()    { return format; }
    Palette*      getPalette()  { return palette; }
    sint32        setPalette(Palette* p, bool copy);
    bool          setEnvironment(G3D::TexEnv e);
    bool          setFilter(G3D::TexFilter mag, G3D::TexFilter min=G3D::NEAREST);
    sint32        create(S_WH, G3D::Texel t, Palette* p=0, bool copyPal=false);
    void          destroy();
    sint32        associate(Rasterizer* r);
    void          disassociate();
    void          update();
    void          updateRegion(S_XYWH);
    bool          setWrapMode(G3D::TexFill s, G3D::TexFill t, Colour c);
    Texture();
    ~Texture();
};

#include <plat/amigaos3_68k/gfxlib/gfx3dinline.hpp>

#endif