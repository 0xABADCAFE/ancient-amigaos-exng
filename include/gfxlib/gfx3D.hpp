//****************************************************************************//
//**                                                                        **//
//** File:         include/gfxlib/gfx3D.hpp                                 **//
//** Description:  Common 3D definitions                                    **//
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

#ifndef _EXTROPIA_GFXLIB_GFX3D_HPP
#define _EXTROPIA_GFXLIB_GFX3D_HPP

#include <gfxlib/gfx.hpp>

////////////////////////////////////////////////////////////////////////////////
//
//  G3D
//
////////////////////////////////////////////////////////////////////////////////

class Rasterizer; // our actual 3D drawing class

class G3D {
  public:
    // Querying constants used to determine what 3D features we have
    typedef enum {
      Q_POINT = 0,
      Q_POINT_SIZE,
      Q_POINT_TEX,
      Q_POINT_FX,
      Q_POINT_ANTIALIAS,
      Q_LINE,
      Q_LINE_WIDTH,
      Q_LINE_TEX,
      Q_LINE_FX,
      Q_LINE_STIPPLE,
      Q_LINE_ANTIALIAS,
      Q_TRIANGLE,
      Q_TRIANGLE_TEX,
      Q_TRIANGLE_STIPPLE,
      Q_TRIANGLE_ANTIALIAS,
      Q_CULLFACE,
      Q_DITHER,
      Q_COLOUR_MASKING,
      Q_SCISSOR,
      Q_SCREEN_ANTIALIAS,
      Q_LOGIC,
      Q_FLAT_SHADE,
      Q_GOURAUD_SHADE,
      Q_SPECULAR,
      Q_BLENDING,
      Q_BLEND_SRC_FACTORS,
      Q_BLEND_DST_FACTORS,
      Q_Z_BUFFER,
      Q_Z_BUFFER_WRITE,
      Q_Z_BUFFER_COMPAREMODES,
      Q_ALPHATEST,
      Q_ALPHATEST_COMPAREMODES,
      Q_STENCIL_BUFFER,
      Q_STENCIL_MASK,
      Q_STENCIL_FUNC,
      Q_STENCIL_SFAIL,
      Q_STENCIL_DPFAIL,
      Q_STENCIL_DPPASS,
      Q_STENCIL_WRITEMASK,
      Q_FOGGING,
      Q_FOG_LINEAR,
      Q_FOG_EXPONENTIAL,
      Q_FOG_SQR_EXPONENTIAL,
      Q_FOG_INTERPOLATED,
      Q_TEX_RECTANGULAR,
      Q_TEX_FILTER,
      Q_TEX_MIPMAP,
      Q_TEX_MIPMAP_FILTER,
      Q_TEX_LINEAR,
      Q_TEX_LINEAR_CLAMP,
      Q_TEX_LINEAR_REPEAT,
      Q_TEX_PERSPECTIVE,
      Q_TEX_PERSP_CLAMP,
      Q_TEX_PERSP_REPEAT,
      Q_TEX_WRAP_ASYMMETRIC,
      Q_TEX_ENV_REPLACE,
      Q_TEX_ENV_DECAL,
      Q_TEX_ENV_MODULATE,
      Q_TEX_ENV_BLEND,
      Q_TEX_CHROMATEST,
      NUM_QUERY
    } Query;

    // Support level constants used to describe implementation of features
    typedef enum {
      UNSUPPORTED = 0,
      EMULATED,
      PARTIALLY_SUPPORTED,
      FULLY_SUPPORTED,
      NUM_SUPPORT
    } Support;

    // Rendering states
    typedef enum {
      TEXTURE = 0,
      AUTOTEXMANAGE,
      GLOBALTEXENV,
      PERSPECTIVE,
      GOURAUD,
      SPECULAR,
      SCISSOR,
      CLIPSCREEN,
      ZBUFTEST,
      ZBUFWRITE,
      STENCILBUF,
      FOGGING,
      BLENDING,
      ALPHATEST,
      DITHERING,
      CHROMATEST,
      LOGIC,
      CULLING,
      ANTIALIASPOINT,
      ANTIALIASLINE,
      ANTIALIASPOLY,
      ANTIALIASFULLSCREEN,
      NUM_STATES
    } State;
/*
    // Alpha testing modes
    typedef enum {
      ATEST_LT      = 0,
      ATEST_LTEQ,
      ATEST_EQ,
      ATEST_GTEQ,
      ATEST_GT,
      ATEST_NEQ,
      ATEST_FAIL,
      ATEST_PASS,
      NUM_ATEST
    } AlphaTest;

    // Z Buffer testing modes
    typedef enum {
      ZTEST_LT      = 0,
      ZTEST_LTEQ,
      ZTEST_EQ,
      ZTEST_GTEQ,
      ZTEST_GT,
      ZTEST_NEQ,
      ZTEST_FAIL,
      ZTEST_PASS,
      NUM_ZTEST
    } ZBuffTest;
*/
    // Stencil/Z/Alpha testing modes
    typedef enum {
      TEST_LT = 0,
      TEST_LTEQ,
      TEST_EQ,
      TEST_GTEQ,
      TEST_GT,
      TEST_NEQ,
      TEST_FAIL,
      TEST_PASS,
      NUM_TEST
    } Compare;

    typedef enum {
      ST_KEEP = 0,
      ST_ZERO,
      ST_REPLACE,
      ST_INCR,
      ST_DECR,
      ST_INVERT,
      NUM_STENCIL
    } StencilUpdate;

    // Logical operations
    typedef enum {
      LOP_CLR = 0,
      LOP_AND,
      LOP_AND_REV,
      LOP_COPY,
      LOP_AND_INV,
      LOP_NOP,
      LOP_XOR,
      LOP_OR,
      LOP_NOR,
      LOP_EQUIV,
      LOP_INV,
      LOP_OR_REV,
      LOP_COPY_INV,
      LOP_OR_INV,
      LOP_NAND,
      LOP_SET,
      NUM_LOGIC
    } LogicOp;

    // Fogging modes
    typedef enum {
      FOG_LINEAR = 0,
      FOG_EXP,
      FOG_EXP_SQUARED,
      FOG_INTERPOLATED,
      NUM_FOG
    } FogMode;

    // Blending modes
    typedef enum {
      BL_0 = 0,
      BL_1,
      BL_SRC_RGB,
      BL_DST_RGB,
      BL_1_MINUS_SRC_RGB,
      BL_1_MINUS_DST_RGB,
      BL_SRC_A,
      BL_1_MINUS_SRC_A,
      BL_DST_A,
      BL_1_MINUS_DST_A,
      BL_SRC_A_SAT,
      BL_CONST_RGB,
      BL_1_MINUS_CONST_RGB,
      BL_CONST_A,
      BL_1_MINUS_CONST_A,
      NUM_BLEND
    } BlendMode;

    // Face order modes
    typedef enum {
      FRONT_CW = 0,
      FRONT_CCW,
      NUM_FACE
    } FrontFace;

    // Texel formats
    typedef enum {
      TXL_LUT8 = 0,
      TXL_G8,
      TXL_I8,
      TXL_A8,
      TXL_RGB16,
      TXL_A1RGB15,
      TXL_A4RGB12,
      TXL_GA88,
      TXL_RGB24,
      TXL_ARGB32,
      TXL_RGBA32,
      NUM_TEXEL
    } Texel;

    // Texture environments
    typedef enum {
      REPLACE = 0,
      DECAL,
      MODULATE,
      BLEND,
      NUM_TEXENV
    } TexEnv;

    // Texture fill methods
    typedef enum {
      CLAMP = 0,
      REPEAT,
      NUM_TEXFILL
    } TexFill;

    // Texture filter methods
    typedef enum {
      LINEAR = 0,
      NEAREST,
      NEAR_MIP_NEAR,
      LINR_MIP_NEAR,
      NEAR_MIP_LINR,
      LINR_MIP_LINR,
      NUM_TEXFILTER
    } TexFilter;

    typedef enum {
      MIN_TEX_WIDTH   = 2,
      MIN_TEX_HEIGHT  = 2,
      MAX_TEX_WIDTH   = 512,
      MAX_TEX_HEIGHT  = 512
    } TexLimits;

    // Vertex definitions
    typedef enum {
      XYZ_FLOAT32 = 0,
      XYZ_FLOAT64,
      NUM_COORDTYPE
    } CoordType;

    typedef enum {
      ARGB_UINT8  = 0,
      RGBA_UINT8,
      ARGB_FLOAT32,
      RGBA_FLOAT32,
      NUM_COLOURTYPE
    } ColourType;

    typedef enum {
      WUV_FLOAT32 = 0,
      UVW_FLOAT32,
      STW_FLOAT32,
      WST_FLOAT32,
      NUM_TEXCOORDTYPE
    } TexCoordType;

    // Predefined vertex elements
    typedef struct { float32 x, y, z;  }    XYZ_f32;
    typedef struct { float64 x, y, z;  }    XYZ_f64;
    typedef struct { uint8 a, r, g, b; }    ARGB_u8;
    typedef struct { uint8 r, g, b, a; }    RGBA_u8;
    typedef struct { float32 a, r, g, b; }  ARGB_f32;
    typedef struct { float32 r, g, b, a; }  RGBA_f32;
    typedef struct { float32 w, u, v;  }    WUV_f32;
    typedef struct { float32 u, v, w;  }    UVW_f32;
    typedef struct { float32 s, t, w;  }    STW_f32;
    typedef struct { float32 w, s, t;  }    WST_f32;

    // Factory
    static Rasterizer*  getRasterizer(Surface* s);
};


////////////////////////////////////////////////////////////////////////////////
//
//  DrawVertex structure. Contains single 3D vertex or 8 other 32-bit data
//
////////////////////////////////////////////////////////////////////////////////

struct DrawVertex {
  //      vertex           int crd 2D    float crd  2D  other data
  union {  float32 x;      sint32 x1;    float32 fx1;  uint32 data1; };
  union {  float32 y;      sint32 y1;    float32 fy1;  uint32 data2; };
  union {  float32 z;      sint32 x2;    float32 fx2;  uint32 data3; };
  union {  float32 w;      sint32 y2;    float32 fy2;  uint32 data4; };
  union {  float32 u;      sint32 x3;    float32 fx3;  uint32 data5; };
  union {  float32 v;      sint32 y3;    float32 fy3;  uint32 data6; };
  union {  uint32  colour;  sint32 x4;    float32 fx4;  uint32 data7; };
  union {  uint32  spec;    sint32 y4;    float32 fy4;  uint32 data8; };
};

////////////////////////////////////////////////////////////////////////////////
//
//  Mesh
//
////////////////////////////////////////////////////////////////////////////////

class Mesh {
  private:
    uint16        width;
    uint16        height;
    size_t        totVerts;
    DrawVertex*    vertices;

  public:
    sint32      create(uint16 w, uint16 h);
    void        destroy();
    DrawVertex*  getVerts()  { return vertices; }
    uint16      getWDim()    { return width; }
    uint16      getHDim()    { return height; }


    Mesh() : width(0), height(0), totVerts(0), vertices(0) {}
    Mesh(uint16 w, uint16 h) { create(w, h);}
    ~Mesh() { destroy(); }
};

////////////////////////////////////////////////////////////////////////////////
//
//  Native classes
//
////////////////////////////////////////////////////////////////////////////////

class Rasterizer;
class Texture;

#if defined(XP_AMIGAOS3_68K)
  #include "plat/amigaos3_68k/gfxlib/gfx3d.hpp"
#elif defined(XP_AMIGAOS3_PPC)
  #include "plat/amigaos3_wos/gfxlib/gfx3d.hpp"
#elif defined(XP_AMIGAOS4)
  #include "plat/amigaos4/gfxlib/gfx3d.hpp"
#elif defined(XP_AROS_BE)
  #include "plat/aros_be/gfxlib/gfx3d.hpp"
#elif defined(XP_AROS_LE)
  #include "plat/aros_le/gfxlib/gfx3d.hpp"
#elif defined(XP_MORPHOS)
  #include "plat/morphos/gfxlib/gfx3d.hpp"
#elif defined(XP_LINUX_PPC)
  #include "plat/linux_ppc/gfxlib/gfx3d.hpp"
#elif defined(XP_LINUX_X86)
  #include "plat/linux_i386/gfxlib/gfx3d.hpp"
#elif defined(XP_WIN9X)
  #include "plat/win9x/gfxlib/gfx3d.hpp"
#elif defined(XP_WIN2K)
  #include "plat/win2k/gfxlib/gfx3d.hpp"
#elif defined(XP_MACOSX)
  #include "plat/macosx/gfxlib/gfx3d.hpp"
#else
  #error "Platform implementation not defined"
#endif

////////////////////////////////////////////////////////////////////////////////
//
//  Inlines
//
////////////////////////////////////////////////////////////////////////////////

inline Rasterizer* G3D::getRasterizer(Surface* s)
{
  return Rasterizer::obtain(s);
}

#endif
