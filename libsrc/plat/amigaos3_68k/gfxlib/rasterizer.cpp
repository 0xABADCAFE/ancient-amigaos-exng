//****************************************************************************//
//**                                                                        **//
//** File:         libsrc/plat/amigaos3_68k/gfxlib/rasterizer.cpp           **//
//** Description:  3D rasterizer definitions                                **//
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

#include <gfxlib/gfx3d.hpp>

#include <new.h>

using namespace X_SYSNAME;

Library* X_SYSNAME::Warp3DBase = 0;

////////////////////////////////////////////////////////////////////////////////
//
//  Rasterizer
//
////////////////////////////////////////////////////////////////////////////////

sint32 Rasterizer::openCnt = 0;

#if defined(FIX_WARP3D_POINTS) || defined(FIX_WARP3D_LINES)
bool Rasterizer::useArrayEmul = true;
#endif

////////////////////////////////////////////////////////////////////////////////

sint32 Rasterizer::init()
{
  if (!(Warp3DBase = OpenLibrary("Warp3D.library", 4))) {
    X_ERROR("Rasterizer::init() : failed to open Warp3D.library v4");
    done();
    return ERR_RSC_UNAVAILABLE;
  }
  if (W3D_CheckDriver() == W3D_DRIVER_UNAVAILABLE) {
    X_ERROR("Rasterizer::init() : failed to query driver");
    done();
    return ERR_RSC_UNAVAILABLE;
  }
  X_INFO("Rasterizer:: initialized");
  #if defined(FIX_WARP3D_POINTS) || defined(FIX_WARP3D_LINES)
  if (AppBase::getSwitch("-no3darrayemul", false)==true) {
    useArrayEmul = false;
    X_INFO("Rasterizer:: disabled 3d array line/point emulation");
  }
  #endif
  return OK;
}

////////////////////////////////////////////////////////////////////////////////

void Rasterizer::done()
{
  X_INFO("Rasterizer:: finalized");
  if (Warp3DBase) {
    CloseLibrary(Warp3DBase);
    Warp3DBase = 0;
  }
}

////////////////////////////////////////////////////////////////////////////////

Rasterizer::Rasterizer()
{ // Set safe defaults
  context              = 0;
  drawRegion.left      = 0;
  drawRegion.top      = 0;
  drawRegion.width    = 0;
  drawRegion.height    = 0;

  surface              = 0;
  texture              = 0;
#if defined(FIX_WARP3D_POINTS) || defined(FIX_WARP3D_LINES)
  vrtPtrX              = 0;
  vrtPtrY              = 0;
  vrtPtrZ              = 0;
  clrPtrA              = 0;
  clrPtrR              = 0;
  clrPtrG              = 0;
  clrPtrB              = 0;
  texPtrW              = 0;
  texPtrUS            = 0;
  texPtrVT            = 0;
#endif
  // vertex pointer
  vrtPtr              = 0;
  vrtPtrType          = G3D::XYZ_FLOAT32;
  vrtPtrStride        = 0;

  // colour pointer
  clrPtr              = 0;
  clrPtrType          = G3D::ARGB_UINT8;
  clrPtrStride        = 0;

  // texcoord pointer
  texPtr              = 0;
  texPtrType          = G3D::WUV_FLOAT32;
  texPtrStride        = 0;

  // colours
  flatColour          = 0xFF000000;
  maskColour          = 0;

  // fogging
  fogColour            = 0xFF7F7F7F;
  fogMode              = G3D::FOG_LINEAR;
  fogData.fog_start    = 0.0F;
  fogData.fog_end      = 1.0F;
  fogData.fog_density  = 1.0F;
  fogData.fog_color.r = 0.5F;
  fogData.fog_color.g = 0.5F;
  fogData.fog_color.b = 0.5F;

  // alpha testing
  alphaTest            = G3D::TEST_PASS;
  alphaTestRef        = 0.0F;

  // z buffer
  zBuffTest            = G3D::TEST_LT;

  // stencil buffer
  stencilTest          = G3D::TEST_PASS;
  stencilOnPass        = G3D::ST_KEEP;
  stencilOnFail        = G3D::ST_KEEP;
  stencilTestRef      = 0;
  stencilMask          = 0;

  // logical ops
  logicOp              = G3D::LOP_NOP;

  // blending
  blendSrc            = G3D::BL_SRC_A;
  blendDst            = G3D::BL_1_MINUS_SRC_A;

  // misc
  windOrder            = G3D::FRONT_CW;
  meshIndexBuffer      = 0;

  // state stack
  uint32* tmp = (uint32*)Mem::alloc(RASTERIZER_DATA_AREA, true, Mem::ALIGN_CACHE);
  if (tmp) {
    pushStack = tmp;
    dataStack = tmp+RASTERIZER_STACK_DEPTH;
  }
  else {
    pushStack = 0;
    dataStack = 0;
  }
  stackPos = 0;
  flags = RESOURCEOK;
}

////////////////////////////////////////////////////////////////////////////////

Rasterizer* Rasterizer::obtain(Surface* s)
{
  // Returns a Rasterizer for use on the given Surface. This function is
  // used as the implementation of Rasterizer* G3D::getRasterizer(Surface*)
  if (s) {
    // First instance? Need to initialise, if that fails return 0...
    if (openCnt == 0) {
      if (init()==OK) {
        openCnt++;
      }
      else {
        return 0;
      }
    }
    // Construct a rasterizer and attempt to bind it to the surface
    Rasterizer* rast = new(nothrow) Rasterizer;
    if (rast) {
      if (rast->associate(s) != OK) {
        delete rast;
        rast = 0;
      }
      return rast;
    }
  }
  X_ERROR("Rasterizer::obtain() : null Surface\n");
  return 0;
}

////////////////////////////////////////////////////////////////////////////////

Rasterizer::~Rasterizer()
{
  disassociate();
  Mem::free(pushStack);
  // last instance?
  if (--openCnt==0) {
    done();
  }
}

////////////////////////////////////////////////////////////////////////////////

sint32 Rasterizer::associate(Surface* s)
{
  if (!(flags & RESOURCEOK)) {
    X_ERROR("Rasterizer::associate() : no 3D resources available\n");
    return ERR_RSC_UNAVAILABLE;
  }
  if (context) {
    X_ERROR("Rasterizer::associate() : context already exists\n");
    return ERR_RSC_LOCKED;
  }
  if (!s) {
    X_ERROR("Rasterizer::associate() : null Surface\n");
  }
  if (!getSurfaceRep(s)) {
    X_ERROR("Rasterizer::associate() : null Surface rep\n");
    return ERR_PTR_ZERO;
  }
  meshIndexBuffer = (uint16*)Mem::alloc(MESH_INDEX_SIZE*sizeof(uint16));
  if (!meshIndexBuffer) {
    X_ERROR("Rasterizer::associate() : not enough memory\n");
    return ERR_NO_FREE_STORE;
  }
  uint32 fault = 0;

  TagItem contextTags[] = {
    W3D_CC_BITMAP,      (uint32)(getSurfaceRep(s)),
    W3D_CC_DRIVERTYPE,  W3D_DRIVER_BEST,
    W3D_CC_FAST,        true,
    W3D_CC_YOFFSET,      0,
    TAG_DONE,            0UL
  };

  if (!(context = W3D_CreateContext(&fault, contextTags))) {
    X_ERROR("W3D_CreateContextTags() failed");
    return ERR_RSC_UNAVAILABLE;
  }
  else {
    surface = s;
    drawRegion.width  = s->getW();
    drawRegion.height  = s->getH();
    W3D_SetDrawRegion(context, getSurfaceRep(s), 0, &drawRegion);
    W3D_SetScissor(context, &drawRegion);
    W3D_SetBlendMode(context, getNativeBlendMode(blendSrc), getNativeBlendMode(blendDst));

    // set initial states to known defaults
    W3D_SetState(context, W3D_SCISSOR, W3D_ENABLE);
    W3D_SetState(context, W3D_DITHERING, W3D_ENABLE);
    W3D_SetState(context, W3D_GOURAUD, W3D_DISABLE);
    W3D_SetState(context, W3D_TEXMAPPING, W3D_DISABLE);
    W3D_SetState(context, W3D_ZBUFFER, W3D_DISABLE);
    W3D_SetState(context, W3D_ZBUFFERUPDATE, W3D_DISABLE);
    W3D_SetState(context, W3D_GLOBALTEXENV, W3D_DISABLE);
    W3D_SetState(context, W3D_BLENDING, W3D_DISABLE);
  }
  return OK;
}

////////////////////////////////////////////////////////////////////////////////

void Rasterizer::disassociate()
{
  if (meshIndexBuffer) {
    Mem::free(meshIndexBuffer);
    meshIndexBuffer = 0;
  }
  if (context) {
    W3D_BindTexture(context, 0, 0);
    W3D_FlushTextures(context);
    W3D_FreeZBuffer(context);
    W3D_FreeStencilBuffer(context);
    W3D_DestroyContext(context);
    context = 0;
  }
  surface = 0;
  //stateMask = 0;
}

////////////////////////////////////////////////////////////////////////////////

G3D::Support Rasterizer::supportsFeature(G3D::Query q)
{
  switch (
    W3D_Query(context, getNativeQuery(q),
    _Nat2D::getNativeFormat(surface->getFormat()))
  ) {
    case W3D_FULLY_SUPPORTED:
      return G3D::FULLY_SUPPORTED;
    case W3D_PARTIALLY_SUPPORTED:
      return G3D::PARTIALLY_SUPPORTED;
    default:
      return G3D::UNSUPPORTED;
  }
}

////////////////////////////////////////////////////////////////////////////////

G3D::Support Rasterizer::supportsTexelFormat(G3D::Texel q)
{
  uint32 res = W3D_GetTexFmtInfo(context, getNativeTexel(q),
               _Nat2D::getNativeFormat(surface->getFormat()));

  if (surface->getFormat()!=Pixel::INDEX8) {
    if (res & W3D_TEXFMT_ARGBFAST|W3D_TEXFMT_FAST) {
      return G3D::FULLY_SUPPORTED;
    }
    if (res & W3D_TEXFMT_SUPPORTED) {
      return G3D::EMULATED;
    }
    return G3D::UNSUPPORTED;
  }
  else {
    if (res & W3D_TEXFMT_CLUTFAST|W3D_TEXFMT_FAST) {
      return G3D::FULLY_SUPPORTED;
    }
    if (res & W3D_TEXFMT_SUPPORTED) {
      return G3D::EMULATED;
    }
    return G3D::UNSUPPORTED;
  }
}

////////////////////////////////////////////////////////////////////////////////

bool Rasterizer::setFront(G3D::FrontFace f)
{
  if (windOrder!=f) {
    windOrder = f;
    W3D_SetFrontFace(context, getNativeFrontFace(f));
  }
  return true;
}

////////////////////////////////////////////////////////////////////////////////

bool Rasterizer::setDrawArea(S_2CRD, Surface* s)
{
  drawRegion.left   = x1;      drawRegion.top = y1;
  drawRegion.width  = x2-x1;  drawRegion.height = y2-y1;
  if (!s || !getSurfaceRep(s)) {
    return (W3D_SetDrawRegion(context, 0, 0, &drawRegion)==W3D_SUCCESS);
  }
  surface = s;
  return (W3D_SetDrawRegion(context, getSurfaceRep(s), 0, &drawRegion)==W3D_SUCCESS);
}

////////////////////////////////////////////////////////////////////////////////

bool Rasterizer::createZBuffer()
{
  if (W3D_AllocZBuffer(context)==W3D_SUCCESS) {
    flags |= HAVEZBUFF;
    return true;
  }
  flags &= ~HAVEZBUFF;
  return false;
}

////////////////////////////////////////////////////////////////////////////////

void Rasterizer::destroyZBuffer()
{
  if (flags & HAVEZBUFF) {
    flags &=~HAVEZBUFF;
    W3D_FreeZBuffer(context);
  }
}

////////////////////////////////////////////////////////////////////////////////

bool Rasterizer::writeZBuffer(S_2CRD, float64* v)
{
  if (!v || (flags & HAVEZBUFF)==0) {
    return false;
  }
  uint32 span = x2-x1;
  uint32 h    = 1+y2-y1;
  while(--h) {
    W3D_WriteZSpan(context, x1, y1++, span, v, 0);
    v+=span;
  }
  return true;
}

////////////////////////////////////////////////////////////////////////////////

bool Rasterizer::readZBuffer(S_2CRD, float64* v)
{
  if (!v || (flags & HAVEZBUFF)==0) {
    return false;
  }
  uint32 span = x2-x1;
  uint32 h    = 1+y2-y1;
  while(--h) {
    if (W3D_ReadZSpan(context, x1, y1++, span, v)!=W3D_SUCCESS) {
      return false;
    }
    v+=span;
  }
  return true;
}

////////////////////////////////////////////////////////////////////////////////

bool Rasterizer::readStencilBuffer(S_2CRD, uint32* p)
{
  if (!p)  return false;
  uint32 span = x2-x1;
  uint32 h    = 1+y2-y1;
  while(--h) {
    if (W3D_ReadStencilSpan(context, x1, y1++, span, p)!=W3D_SUCCESS) {
      return false;
    }
    p+=span;
  }
  return true;
}

////////////////////////////////////////////////////////////////////////////////

bool Rasterizer::setFlatColour(Colour c)
{
  if (c==flatColour) {
    return true;
  }
  rfloat32 f = 1.0f/256.0f;

  W3D_Color rgba = { f*c.red(), f*c.green(), f*c.blue(), f*c.alpha() };

  if (W3D_SetCurrentColor(context, &rgba)==W3D_SUCCESS) {
    flatColour = c;
    return true;
  }
  return false;
}

////////////////////////////////////////////////////////////////////////////////

bool Rasterizer::setFog(G3D::FogMode m, Colour c, float32 s, float32 e, float32 d)
{
  fogData.fog_start    = s;
  fogData.fog_end      = e;
  fogData.fog_density  = d;
  if (c!=fogColour) {
    rfloat32 f = 1.0f/256.0f;
    fogData.fog_color.r = f*c.red();
    fogData.fog_color.g = f*c.green();
    fogData.fog_color.b = f*c.blue();
    fogColour = c;
  }
  return (W3D_SetFogParams(context, &fogData, getNativeFogMode(m))==W3D_SUCCESS);
}

////////////////////////////////////////////////////////////////////////////////

bool Rasterizer::setVertices(DrawVertex* v)
{
  if (!context) {
    return false;
  }
  vrtPtrType        = G3D::XYZ_FLOAT32;
  clrPtrType        = G3D::ARGB_UINT8;
  texPtrType        = G3D::WUV_FLOAT32;
  vrtPtrStride      = DV_STRIDE;
  clrPtrStride      = DV_STRIDE;
  texPtrStride      = DV_STRIDE;
#if defined(FIX_WARP3D_POINTS) || defined(FIX_WARP3D_LINES)
  if (v) {
    vrtPtrX          = (uint8*)v+DV_OFS_XYZ;
    vrtPtrY          = vrtPtrX+sizeof(float32);
    vrtPtrZ          = vrtPtrY+sizeof(float32);
    clrPtrA          = (uint8*)v+DV_OFS_CLR;
    clrPtrR          = clrPtrA+1;
    clrPtrG          = clrPtrR+1;
    clrPtrB          = clrPtrG+1;
    texPtrW          = (uint8*)v+DV_OFS_UV+DV_OFS_W;
    texPtrUS        = (uint8*)v+DV_OFS_UV;
    texPtrVT        = (uint8*)v+DV_OFS_UV+DV_OFS_V;
  }
  else {
    vrtPtrX          = 0;  vrtPtrY    = 0;  vrtPtrZ    = 0;
    clrPtrA          = 0;  clrPtrR    = 0;  clrPtrG    = 0;  clrPtrB    = 0;
    texPtrW          = 0;  texPtrUS  = 0;  texPtrVT  = 0;
  }
#else
  uint8* vrtPtrX = (uint8*)v+DV_OFS_XYZ;
  uint8* clrPtrA = (uint8*)v+DV_OFS_CLR;
  uint8* texPtrUS = (uint8*)v+DV_OFS_UV;
#endif
  W3D_VertexPointer(context, vrtPtrX, DV_STRIDE, W3D_VERTEX_F_F_F, 0);
  W3D_TexCoordPointer(context, texPtrUS, DV_STRIDE, 0, DV_OFS_V, DV_OFS_W, 0);
  W3D_ColorPointer(context, clrPtrA, DV_STRIDE, W3D_COLOR_UBYTE, W3D_CMODE_ARGB, 0);
  return true;
}

////////////////////////////////////////////////////////////////////////////////

bool Rasterizer::setVertexData(void* p, G3D::CoordType t, size_t stride)
{
  switch (t) {
    case G3D::XYZ_FLOAT32: return setVertexData(((G3D::XYZ_f32*)p), stride); break;
    case G3D::XYZ_FLOAT64: return setVertexData(((G3D::XYZ_f64*)p), stride); break;
    default: return false; break;
  }
}

////////////////////////////////////////////////////////////////////////////////

inline bool Rasterizer::setColourData(void* p, G3D::ColourType t, size_t stride)
{
  switch (t) {
    case ARGB_UINT8:    return setColourData(((G3D::ARGB_u8*)p), stride); break;
    case RGBA_UINT8:    return setColourData(((G3D::RGBA_u8*)p), stride); break;
    case ARGB_FLOAT32:  return setColourData(((G3D::ARGB_f32*)p), stride); break;
    case RGBA_FLOAT32:  return setColourData(((G3D::RGBA_f32*)p), stride); break;
    default: return false; break;
  }
}

////////////////////////////////////////////////////////////////////////////////

bool Rasterizer::setTextureData(void* p, G3D::TexCoordType t, size_t stride)
{
  switch (t) {
    case WUV_FLOAT32: return setTextureData(((G3D::WUV_f32*)p), stride); break;
    case UVW_FLOAT32: return setTextureData(((G3D::UVW_f32*)p), stride); break;
    case WST_FLOAT32: return setTextureData(((G3D::WST_f32*)p), stride); break;
    case STW_FLOAT32: return setTextureData(((G3D::STW_f32*)p), stride); break;
    default: return false; break;
  }
}

////////////////////////////////////////////////////////////////////////////////

bool Rasterizer::push(uint32 states)
{
/*
      SM_DRAW_SURFACE  = 0x00000001,  // render surface
      SM_DRAW_AREA    = 0x00000002, // draw region
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
      SM_TEXTURE_PTR  = 0x40000000,
*/
  if (stackPos<(RASTERIZER_STACK_DEPTH-1)) {
    pushStack[stackPos++] = states;
    if (states & SM_DRAW_SURFACE) {
      *dataStack++ = *((uint32*)(&surface));
    }
    if (states & SM_DRAW_AREA) {
      *dataStack++ = *((uint32*)(&(drawRegion.left)));
      *dataStack++ = *((uint32*)(&(drawRegion.top)));
      *dataStack++ = *((uint32*)(&(drawRegion.width)));
      *dataStack++ = *((uint32*)(&(drawRegion.height)));
    }
    if (states & SM_STATE) {
      *dataStack++ = *((uint32*)(&(context->state)));
    }
    if (states & SM_ZBUFF_TEST) {
      *dataStack++ = *((uint32*)(&zBuffTest));
    }
    if (states & SM_ALPHA_TEST) {
      *dataStack++ = *((uint32*)(&alphaTest));
      *dataStack++ = *((uint32*)(&alphaTestRef));
    }
    if (states & SM_STENCIL_TEST) {
      *dataStack++ = *((uint32*)(&stencilTest));
      *dataStack++ = *((uint32*)(&stencilTestRef));
      *dataStack++ = *((uint32*)(&stencilMask));
      *dataStack++ = *((uint32*)(&stencilS));
      *dataStack++ = *((uint32*)(&stencilOnFail));
      *dataStack++ = *((uint32*)(&stencilOnPass));
    }
    if (states & SM_FLAT_COLOUR) {
      *dataStack++ = *((uint32*)(&flatColour));
    }
    if (states & SM_TEXTURE) {
      *dataStack++ = *((uint32*)(&texture));
    }
    if (states & SM_BLEND) {
      *dataStack++ = *((uint32*)(&blendSrc));
      *dataStack++ = *((uint32*)(&blendDst));
    }
    if (states & SM_LOGIC) {
      *dataStack++ = *((uint32*)(&logicOp));
    }
    if (states & SM_FOG) {
      *dataStack++ = *((uint32*)(&fogColour));
      *dataStack++ = *((uint32*)(&fogMode));
      *dataStack++ = *((uint32*)(&(fogData.fog_start)));
      *dataStack++ = *((uint32*)(&(fogData.fog_end)));
      *dataStack++ = *((uint32*)(&(fogData.fog_density)));
      *dataStack++ = *((uint32*)(&(fogData.fog_color.r)));
      *dataStack++ = *((uint32*)(&(fogData.fog_color.g)));
      *dataStack++ = *((uint32*)(&(fogData.fog_color.b)));
    }
    if (states & SM_VERTEX_PTR) {
      *dataStack++ = *((uint32*)(&vrtPtr));
      *dataStack++ = *((uint32*)(&vrtPtrType));
      *dataStack++ = *((uint32*)(&vrtPtrStride));
    }
    if (states & SM_COLOUR_PTR) {
      *dataStack++ = *((uint32*)(&clrPtr));
      *dataStack++ = *((uint32*)(&clrPtrType));
      *dataStack++ = *((uint32*)(&clrPtrStride));
    }
    if (states & SM_TEXTURE_PTR) {
      *dataStack++ = *((uint32*)(&texPtr));
      *dataStack++ = *((uint32*)(&texPtrType));
      *dataStack++ = *((uint32*)(&texPtrStride));
    }
    return true;
  }
  return false;
}

////////////////////////////////////////////////////////////////////////////////

bool Rasterizer::pop()
{
  if (stackPos>0) {
    uint32 states = pushStack[--stackPos]; // get the last pushed states
    if (states & SM_TEXTURE_PTR) {
      size_t  s  =  *((size_t*)(--dataStack));
      uint32  t  = *((uint32*)(--dataStack));
      uint8*   p  = *((uint8**)(--dataStack));
      switch (t) {
        case WUV_FLOAT32: setTextureData(((G3D::WUV_f32*)p), s); break;
        case UVW_FLOAT32: setTextureData(((G3D::UVW_f32*)p), s); break;
        case WST_FLOAT32: setTextureData(((G3D::WST_f32*)p), s); break;
        case STW_FLOAT32: setTextureData(((G3D::STW_f32*)p), s); break;
        default: break;
      }
    }
    if (states & SM_COLOUR_PTR) {
      size_t  s  =  *((size_t*)(--dataStack));
      uint32  t  = *((uint32*)(--dataStack));
      uint8*   p  = *((uint8**)(--dataStack));
      switch (t) {
        case ARGB_UINT8:    setColourData(((G3D::ARGB_u8*)p), s); break;
        case RGBA_UINT8:    setColourData(((G3D::RGBA_u8*)p), s); break;
        case ARGB_FLOAT32:  setColourData(((G3D::ARGB_f32*)p), s); break;
        case RGBA_FLOAT32:  setColourData(((G3D::RGBA_f32*)p), s); break;
        default: break;
      }
    }
    if (states & SM_VERTEX_PTR) {
      size_t  s  =  *((size_t*)(--dataStack));
      uint32  t  = *((uint32*)(--dataStack));
      uint8*   p  = *((uint8**)(--dataStack));
      switch (t) {
        case WUV_FLOAT32: setTextureData(((G3D::WUV_f32*)p), s); break;
        case UVW_FLOAT32: setTextureData(((G3D::UVW_f32*)p), s); break;
        case WST_FLOAT32: setTextureData(((G3D::WST_f32*)p), s); break;
        case STW_FLOAT32: setTextureData(((G3D::STW_f32*)p), s); break;
        default: break;
      }
    }
    if (states & SM_FOG) {
      *((uint32*)(&(fogData.fog_color.b)))  =  *(--dataStack);
      *((uint32*)(&(fogData.fog_color.g)))  =  *(--dataStack);
      *((uint32*)(&(fogData.fog_color.r)))  =  *(--dataStack);
      *((uint32*)(&(fogData.fog_density)))  =  *(--dataStack);
      *((uint32*)(&(fogData.fog_end)))      =  *(--dataStack);
      *((uint32*)(&(fogData.fog_start)))    =  *(--dataStack);
      *((uint32*)(&fogMode))                =  *(--dataStack);
      *((uint32*)(&fogColour))              =  *(--dataStack);
      X_SYSNAME::W3D_SetFogParams(
        context,
        &fogData,
        getNativeFogMode(fogMode)
      );
    }
    if (states & SM_LOGIC) {
      *((uint32*)(&logicOp))                =  *(--dataStack);
    }
    if (states & SM_BLEND) {
      *((uint32*)(&blendDst))                =  *(--dataStack);
      *((uint32*)(&blendSrc))                =  *(--dataStack);
      X_SYSNAME::W3D_SetBlendMode(
        context,
        getNativeBlendMode(blendSrc),
        getNativeBlendMode(blendDst)
      );
    }
    if (states & SM_TEXTURE) {
      *((uint32*)(&texture))                =  *(--dataStack);
      setTexture(texture);
    }
    if (states & SM_FLAT_COLOUR) {
      *((uint32*)(&flatColour))              =  *(--dataStack);
    }
    if (states & SM_STENCIL_TEST) {
      *((uint32*)(&stencilOnPass))          =  *(--dataStack);
      *((uint32*)(&stencilOnFail))          =  *(--dataStack);
      *((uint32*)(&stencilS))                = *(--dataStack);
      *((uint32*)(&stencilMask))            =  *(--dataStack);
      *((uint32*)(&stencilTestRef))          =  *(--dataStack);
      *((uint32*)(&stencilTest))            =  *(--dataStack);
      X_SYSNAME::W3D_SetStencilFunc(
        context,
        getNativeStencilTest(stencilTest),
        stencilTestRef,
        stencilMask
      );
      X_SYSNAME::W3D_SetStencilOp(
        context,
        stencilS,
        getNativeStencilUpdate(stencilOnFail),
        getNativeStencilUpdate(stencilOnPass)
      );

    }
    if (states & SM_ALPHA_TEST) {
      *((uint32*)(&alphaTestRef))            = *(--dataStack);
      *((uint32*)(&alphaTest))              = *(--dataStack);
      X_SYSNAME::W3D_SetAlphaMode(
        context,
        getNativeAlphaTest(alphaTest),
        &alphaTestRef
      );
    }
    if (states & SM_ZBUFF_TEST) {
      *((uint32*)(&zBuffTest))              = *(--dataStack);
      X_SYSNAME::W3D_SetZCompareMode(
        context,
        getNativeZBuffTest(zBuffTest)
      );
    }
    if (states & SM_STATE) {
      *((uint32*)(&(context->state)))        = *(--dataStack);
    }
    if (states & SM_DRAW) {
      if (states & SM_DRAW_AREA) {
        *((uint32*)(&(drawRegion.height)))    = *(--dataStack);
        *((uint32*)(&(drawRegion.width)))      = *(--dataStack);
        *((uint32*)(&(drawRegion.top)))        = *(--dataStack);
        *((uint32*)(&(drawRegion.left)))      = *(--dataStack);
      }
      if (states & SM_DRAW_SURFACE) {
        *((uint32*)(&surface))                =  *(--dataStack);
      }
      X_SYSNAME::W3D_SetDrawRegion(
        context,
        getSurfaceRep(surface),
        0,
        &drawRegion
      );
    }
    return true;
  }
  return false;
}

////////////////////////////////////////////////////////////////////////////////

