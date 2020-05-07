//****************************************************************************//
//**                                                                        **//
//** File:         include/plat/amigaos3_68k/gfxlib/gfx3Dinline.hpp         **//
//** Description:  3D Graphics classes                                      **//
//** Comment(s):                                                            **//
//** Library:      Gfx                                                      **//
//** Created:      2003-04-27                                               **//
//** Updated:      2003-04-27                                               **//
//** Author(s):    Karl Churchill                                           **//
//** Note(s):                                                               **//
//** Copyright:    (C)1996-2003, eXtropia Studios                           **//
//**               Serkan YAZICI, Karl Churchill                            **//
//**               All Rights Reserved.                                     **//
//**                                                                        **//
//****************************************************************************//

#ifndef _EXTROPIA_GFXLIB_GFX3D_NATIVE_INLINE_HPP
#define _EXTROPIA_GFXLIB_GFX3D_NATIVE_INLINE_HPP

////////////////////////////////////////////////////////////////////////////////
//
//  Rasterizer
//
////////////////////////////////////////////////////////////////////////////////

inline bool Rasterizer::setDrawSurface(Surface* s)
{
  if (s && getSurfaceRep(s) && X_SYSNAME::W3D_SetDrawRegion(context, getSurfaceRep(s), 0, &drawRegion)==W3D_SUCCESS) {
    surface = s;
    return true;
  }
  return false;
}

inline bool Rasterizer::lock()
{
  if (flags & LOCKED)
    return true;
  if (X_SYSNAME::W3D_LockHardware(context)==W3D_SUCCESS) {
    flags |= LOCKED;
    return true;
  }
  return false;
}

////////////////////////////////////////////////////////////////////////////////

inline void Rasterizer::unlock()
{
  flags &= ~LOCKED;
  X_SYSNAME::W3D_UnLockHardware(context);
}

////////////////////////////////////////////////////////////////////////////////

inline bool Rasterizer::enable(G3D::State s)
{
  if (X_SYSNAME::W3D_SetState(context, getNativeState(s), W3D_ENABLE)==W3D_SUCCESS) {
    //stateMask |= (1UL<<s);
    return true;
  }
  //stateMask &= ~(1UL<<s);
  return false;
}

////////////////////////////////////////////////////////////////////////////////

inline bool Rasterizer::disable(G3D::State s)
{
  if (X_SYSNAME::W3D_SetState(context, getNativeState(s), W3D_DISABLE)==W3D_SUCCESS) {
    //stateMask &= ~(1UL<<s);
    return true;
  }
  //stateMask |= (1UL<<s);
  return false;
}

////////////////////////////////////////////////////////////////////////////////

inline bool Rasterizer::isEnabled(G3D::State s)
{
  return (X_SYSNAME::W3D_GetState(context, getNativeState(s))==W3D_ENABLED);
}

////////////////////////////////////////////////////////////////////////////////

inline bool Rasterizer::clearZBuffer(float64 v)
{
  return (X_SYSNAME::W3D_ClearZBuffer(context, &v)==W3D_SUCCESS);
}

////////////////////////////////////////////////////////////////////////////////

inline bool Rasterizer::setZTest(G3D::Compare m)
{
  if (X_SYSNAME::W3D_SetZCompareMode(context, getNativeZBuffTest(m))==W3D_SUCCESS) {
    zBuffTest = m;
    return true;
  }
  return false;
}

////////////////////////////////////////////////////////////////////////////////

inline bool Rasterizer::setStencilTest(G3D::Compare m, uint32 ref, uint32 mask)
{
  if(X_SYSNAME::W3D_SetStencilFunc(context, getNativeStencilTest(m), ref, mask)==W3D_SUCCESS) {
    stencilTest      = m;
    stencilTestRef  = ref;
    stencilMask      = mask;
    return true;
  }
  return false;
}

////////////////////////////////////////////////////////////////////////////////

inline bool Rasterizer::setStencilUpdate(uint32 s, G3D::StencilUpdate f, G3D::StencilUpdate p)
{
  if(X_SYSNAME::W3D_SetStencilOp(context, s, getNativeStencilUpdate(f), getNativeStencilUpdate(p))==W3D_SUCCESS) {
    stencilS      = s;
    stencilOnFail = f;
    stencilOnPass = p;
    return true;
  }
  return false;
}

////////////////////////////////////////////////////////////////////////////////

inline bool Rasterizer::clearStencilBuffer(uint32 v)
{
  return (X_SYSNAME::W3D_ClearStencilBuffer(context, &v)==W3D_SUCCESS);
}

////////////////////////////////////////////////////////////////////////////////

inline bool Rasterizer::writeStencilBuffer(S_2CRD, uint32* p)
{
  return (X_SYSNAME::W3D_FillStencilBuffer(context, x1, y1, x2-x1, y2-y1, 32, p)==W3D_SUCCESS);
}

////////////////////////////////////////////////////////////////////////////////

inline bool Rasterizer::writeStencilBuffer(S_2CRD, uint16* p)
{
  return (X_SYSNAME::W3D_FillStencilBuffer(context, x1, y1, x2-x1, y2-y1, 16, p)==W3D_SUCCESS);
}

////////////////////////////////////////////////////////////////////////////////

inline bool Rasterizer::writeStencilBuffer(S_2CRD, uint8* p)
{
  return (X_SYSNAME::W3D_FillStencilBuffer(context, x1, y1, x2-x1, y2-y1, 8, p)==W3D_SUCCESS);
}

////////////////////////////////////////////////////////////////////////////////

inline bool Rasterizer::setAlphaTest(G3D::Compare m, float32 ref)
{
  if (X_SYSNAME::W3D_SetAlphaMode(context, getNativeAlphaTest(m), &ref)==W3D_SUCCESS) {
    alphaTest      = m;
    alphaTestRef  = ref;
    return true;
  }
  return false;
}

////////////////////////////////////////////////////////////////////////////////

inline bool Rasterizer::setBlend(G3D::BlendMode s, G3D::BlendMode d)
{
  if (X_SYSNAME::W3D_SetBlendMode(context, getNativeBlendMode(s), getNativeBlendMode(d))==W3D_SUCCESS) {
    blendSrc = s;
    blendDst = d;
    return true;
  }
  return false;
}

////////////////////////////////////////////////////////////////////////////////

inline bool Rasterizer::setMaskColour(Colour c)
{
  if (X_SYSNAME::W3D_SetColorMask(context, c.red(), c.green(), c.blue(), c.alpha())==W3D_SUCCESS) {
    maskColour = c;
    return true;
  }
  return false;
}

////////////////////////////////////////////////////////////////////////////////

inline bool Rasterizer::setFog(G3D::FogMode m)
{
  if (m!=fogMode) {
    if (X_SYSNAME::W3D_SetFogParams(context, &fogData, getNativeFogMode(m))==W3D_SUCCESS) {
      fogMode = m;
      return true;
    }
    return false;
  }
  return true;
}

////////////////////////////////////////////////////////////////////////////////

inline bool Rasterizer::setVertexData(G3D::XYZ_f32* p, size_t stride)
{
  if (!context) return false;
  #if defined(FIX_WARP3D_POINTS) || defined(FIX_WARP3D_LINES)
  vrtPtrX        = (uint8*)p;
  vrtPtrY        = (uint8*)p+sizeof(float32);
  vrtPtrZ        = (uint8*)p+2*sizeof(float32);
  #endif
  vrtPtrType    = G3D::XYZ_FLOAT32;
  vrtPtrStride  = stride;
  X_SYSNAME::W3D_VertexPointer(context, p, (int)stride, W3D_VERTEX_F_F_F, 0);
  return true;
}

////////////////////////////////////////////////////////////////////////////////

inline bool Rasterizer::setVertexData(G3D::XYZ_f64* p, size_t stride)
{
  if (!context) return false;
  #if defined(FIX_WARP3D_POINTS) || defined(FIX_WARP3D_LINES)
  vrtPtrX        = (uint8*)p;
  vrtPtrY        = (uint8*)p+sizeof(float64);
  vrtPtrZ        = (uint8*)p+2*sizeof(float64);
  #endif
  vrtPtr        = p;
  vrtPtrType    = G3D::XYZ_FLOAT64;
  vrtPtrStride  = stride;
  X_SYSNAME::W3D_VertexPointer(context, p, (int)stride, W3D_VERTEX_D_D_D, 0);
  return true;
}

////////////////////////////////////////////////////////////////////////////////

inline bool Rasterizer::setColourData(G3D::ARGB_u8 *p, size_t stride)
{
  if (!context) return false;
  #if defined(FIX_WARP3D_POINTS) || defined(FIX_WARP3D_LINES)
  clrPtrA        = (uint8*)p;
  clrPtrR        = (uint8*)p+1;
  clrPtrG        = (uint8*)p+2;
  clrPtrB        = (uint8*)p+3;
  #endif
  clrPtr        = p;
  clrPtrType    = G3D::ARGB_UINT8;
  clrPtrStride  = stride;
  X_SYSNAME::W3D_ColorPointer(context, p, (int)stride, W3D_COLOR_UBYTE, W3D_CMODE_ARGB, 0);
  return true;
}

////////////////////////////////////////////////////////////////////////////////

inline bool Rasterizer::setColourData(G3D::RGBA_u8 *p, size_t stride)
{
  if (!context) return false;
  #if defined(FIX_WARP3D_POINTS) || defined(FIX_WARP3D_LINES)
  clrPtrA        = (uint8*)p+3;
  clrPtrR        = (uint8*)p;
  clrPtrG        = (uint8*)p+1;
  clrPtrB        = (uint8*)p+2;
  #endif
  clrPtr        = p;
  clrPtrType    = G3D::RGBA_UINT8;
  clrPtrStride  = stride;
  X_SYSNAME::W3D_ColorPointer(context, p, (int)stride, W3D_COLOR_UBYTE, W3D_CMODE_RGBA, 0);
  return true;
}

////////////////////////////////////////////////////////////////////////////////

inline bool Rasterizer::setColourData(G3D::ARGB_f32 *p, size_t stride)
{
  if (!context) return false;
  #if defined(FIX_WARP3D_POINTS) || defined(FIX_WARP3D_LINES)
  clrPtrA        = (uint8*)p;
  clrPtrR        = (uint8*)p+sizeof(float32);
  clrPtrG        = (uint8*)p+2*sizeof(float32);
  clrPtrB        = (uint8*)p+3*sizeof(float32);
  #endif
  clrPtr        = p;
  clrPtrType    = G3D::ARGB_FLOAT32;
  clrPtrStride  = stride;
  X_SYSNAME::W3D_ColorPointer(context, p, (int)stride, W3D_COLOR_FLOAT, W3D_CMODE_ARGB, 0);
  return true;
}

////////////////////////////////////////////////////////////////////////////////

inline bool Rasterizer::setColourData(G3D::RGBA_f32 *p, size_t stride)
{
  if (!context) return false;
  #if defined(FIX_WARP3D_POINTS) || defined(FIX_WARP3D_LINES)
  clrPtrA        = (uint8*)p+3*sizeof(float32);
  clrPtrR        = (uint8*)p;
  clrPtrG        = (uint8*)p+sizeof(float32);
  clrPtrB        = (uint8*)p+2*sizeof(float32);
  #endif
  clrPtr        = p;
  clrPtrType    = G3D::RGBA_FLOAT32;
  clrPtrStride  = stride;
  X_SYSNAME::W3D_ColorPointer(context, p, (int)stride, W3D_COLOR_FLOAT, W3D_CMODE_RGBA, 0);
  return true;
}

////////////////////////////////////////////////////////////////////////////////

inline bool Rasterizer::setTextureData(G3D::WUV_f32 *p, size_t stride)
{
  if (!context) return false;
  #if defined(FIX_WARP3D_POINTS) || defined(FIX_WARP3D_LINES)
  texPtrW        = (uint8*)p;
  texPtrUS      = (uint8*)p+sizeof(float32);
  texPtrVT      = (uint8*)p+2*sizeof(float32);
  #endif
  texPtr        = p;
  texPtrType    = G3D::WUV_FLOAT32;
  texPtrStride  = stride;
  X_SYSNAME::W3D_TexCoordPointer(context, ((uint8*)p)+sizeof(float32), (int)stride, 0,
                      sizeof(float32), -sizeof(float32), 0);
  return true;
}

////////////////////////////////////////////////////////////////////////////////

inline bool Rasterizer::setTextureData(G3D::UVW_f32 *p, size_t stride)
{
  if (!context) return false;
  #if defined(FIX_WARP3D_POINTS) || defined(FIX_WARP3D_LINES)
  texPtrW        = (uint8*)p+2*sizeof(float32);
  texPtrUS      = (uint8*)p;
  texPtrVT      = (uint8*)p+sizeof(float32);
  #endif
  texPtr        = p;
  texPtrType    = G3D::UVW_FLOAT32;
  texPtrStride  = stride;
  X_SYSNAME::W3D_TexCoordPointer(context, p, (int)stride, 0, sizeof(float32),
                      2*sizeof(float32), 0);
  return true;
}

////////////////////////////////////////////////////////////////////////////////

inline bool Rasterizer::setTextureData(G3D::WST_f32 *p, size_t stride)
{
  if (!context) return false;
  #if defined(FIX_WARP3D_POINTS) || defined(FIX_WARP3D_LINES)
  texPtrW        = (uint8*)p;
  texPtrUS      = (uint8*)p+sizeof(float32);
  texPtrVT      = (uint8*)p+2*sizeof(float32);
  #endif
  texPtr        = p;
  texPtrType    = G3D::WST_FLOAT32;
  texPtrStride  = stride;
  X_SYSNAME::W3D_TexCoordPointer(context, ((uint8*)p)+sizeof(float32), (int)stride, 0,
                      sizeof(float32), -sizeof(float32),
                      W3D_TEXCOORD_NORMALIZED);
  return true;
}

////////////////////////////////////////////////////////////////////////////////

inline bool Rasterizer::setTextureData(G3D::STW_f32 *p, size_t stride)
{
  if (!context) return false;
  #if defined(FIX_WARP3D_POINTS) || defined(FIX_WARP3D_LINES)
  texPtrW        = (uint8*)p+2*sizeof(float32);
  texPtrUS      = (uint8*)p;
  texPtrVT      = (uint8*)p+sizeof(float32);
  #endif
  texPtr        = p;
  texPtrType    = G3D::STW_FLOAT32;
  texPtrStride  = stride;
  X_SYSNAME::W3D_TexCoordPointer(context, p, (int)stride, 0, sizeof(float32),
                      2*sizeof(float32), W3D_TEXCOORD_NORMALIZED);
  return true;
}

////////////////////////////////////////////////////////////////////////////////

inline bool Rasterizer::setTexture(Texture* t)
{
  if (!t) {
    texture = 0;
    X_SYSNAME::W3D_BindTexture(context, 0, 0);
    return true;
  }
  if (t->owner != context || !t->tex)
    return false;
  texture = t;
  X_SYSNAME::W3D_BindTexture(context, 0, t->tex);
  return true;
}

////////////////////////////////////////////////////////////////////////////////

inline bool Rasterizer::clearDrawArea(Colour c)
{
  return (X_SYSNAME::W3D_ClearDrawRegion(context, (uint32)c)==W3D_SUCCESS);
}

////////////////////////////////////////////////////////////////////////////////

inline bool Rasterizer::clearDrawArea()
{
  return (X_SYSNAME::W3D_ClearDrawRegion(context, (uint32)flatColour)==W3D_SUCCESS);
}

////////////////////////////////////////////////////////////////////////////////

inline void Rasterizer::flush()
{
  X_SYSNAME::W3D_FlushFrame(context);
}

////////////////////////////////////////////////////////////////////////////////

#ifndef FIX_WARP3D_POINTS

inline bool Rasterizer::drawPoints(size_t ofs, size_t n)
{
  return (X_SYSNAME::W3D_DrawArray(context, W3D_PRIMITIVE_POINTS, ofs, n)==W3D_SUCCESS);
}

inline bool Rasterizer::drawPointsIdx8(size_t n, uint8* idxBuffer)
{
  return (X_SYSNAME::W3D_DrawElements(context, W3D_PRIMITIVE_POINTS, W3D_INDEX_UBYTE, n,
          idxBuffer)==W3D_SUCCESS);
}

inline bool Rasterizer::drawPointsIdx16(size_t n, uint16* idxBuffer)
{
  return (X_SYSNAME::W3D_DrawElements(context, W3D_PRIMITIVE_POINTS, W3D_INDEX_UWORD, n,
          idxBuffer)==W3D_SUCCESS);
}

inline bool Rasterizer::drawPointsIdx32(size_t n, uint32* idxBuffer)
{
  return (X_SYSNAME::W3D_DrawElements(context, W3D_PRIMITIVE_POINTS, W3D_INDEX_ULONG, n,
          idxBuffer)==W3D_SUCCESS);
}


#endif

////////////////////////////////////////////////////////////////////////////////

#ifndef FIX_WARP3D_LINES

////////////////////////////////////////////////////////////////////////////////

inline bool Rasterizer::drawLines(size_t ofs, size_t n)
{
  return (X_SYSNAME::W3D_DrawArray(context, W3D_PRIMITIVE_LINES, ofs, n)==W3D_SUCCESS);
}

inline bool Rasterizer::drawLinesIdx8(size_t n, uint8* idxBuffer)
{
  return (X_SYSNAME::W3D_DrawElements(context, W3D_PRIMITIVE_LINES, W3D_INDEX_UBYTE, n,
          idxBuffer)==W3D_SUCCESS);
}

inline bool Rasterizer::drawLinesIdx16(size_t n, uint16* idxBuffer)
{
  return (X_SYSNAME::W3D_DrawElements(context, W3D_PRIMITIVE_LINES, W3D_INDEX_UWORD, n,
          idxBuffer)==W3D_SUCCESS);
}

inline bool Rasterizer::drawLinesIdx32(size_t n, uint32* idxBuffer)
{
  return (X_SYSNAME::W3D_DrawElements(context, W3D_PRIMITIVE_LINES, W3D_INDEX_ULONG, n,
          idxBuffer)==W3D_SUCCESS);
}

////////////////////////////////////////////////////////////////////////////////

inline bool Rasterizer::drawLineStrip(size_t ofs, size_t n)
{
  return (X_SYSNAME::W3D_DrawArray(context, W3D_PRIMITIVE_LINESTRIP, ofs, n)==W3D_SUCCESS);
}

inline bool Rasterizer::drawLineStripIdx8(size_t n, uint8* idxBuffer)
{
  return (X_SYSNAME::W3D_DrawElements(context, W3D_PRIMITIVE_LINESTRIP, W3D_INDEX_UBYTE, n,
          idxBuffer)==W3D_SUCCESS);
}

inline bool Rasterizer::drawLineStripIdx16(size_t n, uint16* idxBuffer)
{
  return (X_SYSNAME::W3D_DrawElements(context, W3D_PRIMITIVE_LINESTRIP, W3D_INDEX_UWORD, n,
          idxBuffer)==W3D_SUCCESS);
}

inline bool Rasterizer::drawLineStripIdx32(size_t n, uint32* idxBuffer)
{
  return (X_SYSNAME::W3D_DrawElements(context, W3D_PRIMITIVE_LINESTRIP, W3D_INDEX_ULONG, n,
          idxBuffer)==W3D_SUCCESS);
}

////////////////////////////////////////////////////////////////////////////////

#endif

////////////////////////////////////////////////////////////////////////////////

inline bool Rasterizer::drawTris(size_t ofs, size_t n)
{
  return (X_SYSNAME::W3D_DrawArray(context, W3D_PRIMITIVE_TRIANGLES, ofs, n)==W3D_SUCCESS);
}

inline bool Rasterizer::drawTrisIdx8(size_t n, uint8* idxBuffer)
{
  return (X_SYSNAME::W3D_DrawElements(context, W3D_PRIMITIVE_TRIANGLES, W3D_INDEX_UBYTE, n,
          idxBuffer)==W3D_SUCCESS);
}

inline bool Rasterizer::drawTrisIdx16(size_t n, uint16* idxBuffer)
{
  return (X_SYSNAME::W3D_DrawElements(context, W3D_PRIMITIVE_TRIANGLES, W3D_INDEX_UWORD, n,
          idxBuffer)==W3D_SUCCESS);
}

inline bool Rasterizer::drawTrisIdx32(size_t n, uint32* idxBuffer)
{
  return (X_SYSNAME::W3D_DrawElements(context, W3D_PRIMITIVE_TRIANGLES, W3D_INDEX_ULONG, n,
          idxBuffer)==W3D_SUCCESS);
}

////////////////////////////////////////////////////////////////////////////////

inline bool Rasterizer::drawTriFan(size_t ofs, size_t n)
{
  return (X_SYSNAME::W3D_DrawArray(context, W3D_PRIMITIVE_TRIFAN, ofs, n)==W3D_SUCCESS);
}

inline bool Rasterizer::drawTriFanIdx8(size_t n, uint8* idxBuffer)
{
  return (X_SYSNAME::W3D_DrawElements(context, W3D_PRIMITIVE_TRIFAN, W3D_INDEX_UBYTE, n,
          idxBuffer)==W3D_SUCCESS);
}

inline bool Rasterizer::drawTriFanIdx16(size_t n, uint16* idxBuffer)
{
  return (X_SYSNAME::W3D_DrawElements(context, W3D_PRIMITIVE_TRIFAN, W3D_INDEX_UWORD, n,
          idxBuffer)==W3D_SUCCESS);
}

inline bool Rasterizer::drawTriFanIdx32(size_t n, uint32* idxBuffer)
{
  return (X_SYSNAME::W3D_DrawElements(context, W3D_PRIMITIVE_TRIFAN, W3D_INDEX_ULONG, n,
          idxBuffer)==W3D_SUCCESS);
}

////////////////////////////////////////////////////////////////////////////////

inline bool Rasterizer::drawTriStrip(size_t ofs, size_t n)
{
  return (X_SYSNAME::W3D_DrawArray(context, W3D_PRIMITIVE_TRISTRIP, ofs, n)==W3D_SUCCESS);
}

inline bool Rasterizer::drawTriStripIdx8(size_t n, uint8* idxBuffer)
{
  return (X_SYSNAME::W3D_DrawElements(context, W3D_PRIMITIVE_TRISTRIP, W3D_INDEX_UBYTE, n,
          idxBuffer)==W3D_SUCCESS);
}

inline bool Rasterizer::drawTriStripIdx16(size_t n, uint16* idxBuffer)
{
  return (X_SYSNAME::W3D_DrawElements(context, W3D_PRIMITIVE_TRISTRIP, W3D_INDEX_UWORD, n,
          idxBuffer)==W3D_SUCCESS);
}

inline bool Rasterizer::drawTriStripIdx32(size_t n, uint32* idxBuffer)
{
  return (X_SYSNAME::W3D_DrawElements(context, W3D_PRIMITIVE_TRISTRIP, W3D_INDEX_ULONG, n,
          idxBuffer)==W3D_SUCCESS);
}

////////////////////////////////////////////////////////////////////////////////
//
//  Texure
//
////////////////////////////////////////////////////////////////////////////////

inline bool Texture::setEnvironment(G3D::TexEnv e)
{
  if (owner && tex &&
      X_SYSNAME::W3D_SetTexEnv(owner, tex, getNativeTexEnv(e), 0)==W3D_SUCCESS) {
    env = e;
    return true;
  }
  return false;
}

////////////////////////////////////////////////////////////////////////////////

inline bool Texture::setFilter(G3D::TexFilter mg, G3D::TexFilter mn)
{
  if (owner && tex &&
      X_SYSNAME::W3D_SetFilter(owner, tex, getNativeTexFilter(mn), getNativeTexFilter(mg))==W3D_SUCCESS) {
    mag = mg; min = mn;
    return true;
  }
  return false;
}

////////////////////////////////////////////////////////////////////////////////

inline bool Texture::setWrapMode(G3D::TexFill s, G3D::TexFill t, Colour c)
{
  if (owner && tex) {
    rfloat32 sf = 1.0/255.0;
    X_SYSNAME::W3D_Color clamp = { sf*c.red(), sf*c.green(), sf*c.blue(), sf*c.alpha() };
    if (X_SYSNAME::W3D_SetWrapMode(owner, tex, getNativeTexFill(s), getNativeTexFill(t), &clamp)==W3D_SUCCESS)
      return true;
  }
  return false;
}

////////////////////////////////////////////////////////////////////////////////

inline void Texture::update()
{
  if (owner && tex)
    X_SYSNAME::W3D_UpdateTexImage(owner, tex, data, 0, 0);
}

////////////////////////////////////////////////////////////////////////////////

inline void Texture::updateRegion(S_XYWH)
{
  update();
}

#endif // _EXTROPIA_GFX_3D_NATIVE_INLINE_HPP
