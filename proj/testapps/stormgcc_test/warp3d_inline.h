#ifndef _INLINE_WARP3D_H
#define _INLINE_WARP3D_H

#ifndef WARP3D_BASE_NAME
#define WARP3D_BASE_NAME Warp3DBase
#endif

static __inline W3D_Context    * W3D_CreateContext(ULONG * error, struct TagItem * CCTags)
{
  return ((W3D_Context    * (*)(ULONG * __asm("a0"), struct TagItem * __asm("a1"), struct Library * __asm("a6")))
  (((char *) WARP3D_BASE_NAME) - 30))(error, CCTags, (struct Library *) WARP3D_BASE_NAME);
}

static __inline void W3D_DestroyContext(W3D_Context * context)
{
  ((void (*)(W3D_Context * __asm("a0"), struct Library * __asm("a6")))
  (((char *) WARP3D_BASE_NAME) - 36))(context, (struct Library *) WARP3D_BASE_NAME);
}

static __inline ULONG W3D_GetState(W3D_Context * context, ULONG state)
{
  return ((ULONG (*)(W3D_Context * __asm("a0"), ULONG __asm("d1"), struct Library * __asm("a6")))
  (((char *) WARP3D_BASE_NAME) - 42))(context, state, (struct Library *) WARP3D_BASE_NAME);
}

static __inline ULONG W3D_SetState(W3D_Context * context, ULONG state, ULONG action)
{
  return ((ULONG (*)(W3D_Context * __asm("a0"), ULONG __asm("d0"), ULONG __asm("d1"), struct Library * __asm("a6")))
  (((char *) WARP3D_BASE_NAME) - 48))(context, state, action, (struct Library *) WARP3D_BASE_NAME);
}

static __inline ULONG W3D_CheckDriver()
{
  return ((ULONG (*)(struct Library * __asm("a6")))
  (((char *) WARP3D_BASE_NAME) - 54))((struct Library *) WARP3D_BASE_NAME);
}

static __inline ULONG W3D_LockHardware(W3D_Context * context)
{
  return ((ULONG (*)(W3D_Context * __asm("a0"), struct Library * __asm("a6")))
  (((char *) WARP3D_BASE_NAME) - 60))(context, (struct Library *) WARP3D_BASE_NAME);
}

static __inline void W3D_UnLockHardware(W3D_Context * context)
{
  ((void (*)(W3D_Context * __asm("a0"), struct Library * __asm("a6")))
  (((char *) WARP3D_BASE_NAME) - 66))(context, (struct Library *) WARP3D_BASE_NAME);
}

static __inline void W3D_WaitIdle(W3D_Context * context)
{
  ((void (*)(W3D_Context * __asm("a0"), struct Library * __asm("a6")))
  (((char *) WARP3D_BASE_NAME) - 72))(context, (struct Library *) WARP3D_BASE_NAME);
}

static __inline ULONG W3D_CheckIdle(W3D_Context * context)
{
  return ((ULONG (*)(W3D_Context * __asm("a0"), struct Library * __asm("a6")))
  (((char *) WARP3D_BASE_NAME) - 78))(context, (struct Library *) WARP3D_BASE_NAME);
}

static __inline ULONG W3D_Query(W3D_Context * context, ULONG query, ULONG destfmt)
{
  return ((ULONG (*)(W3D_Context * __asm("a0"), ULONG __asm("d0"), ULONG __asm("d1"), struct Library * __asm("a6")))
  (((char *) WARP3D_BASE_NAME) - 84))(context, query, destfmt, (struct Library *) WARP3D_BASE_NAME);
}

static __inline ULONG W3D_GetTexFmtInfo(W3D_Context * context, ULONG format, ULONG destfmt)
{
  return ((ULONG (*)(W3D_Context * __asm("a0"), ULONG __asm("d0"), ULONG __asm("d1"), struct Library * __asm("a6")))
  (((char *) WARP3D_BASE_NAME) - 90))(context, format, destfmt, (struct Library *) WARP3D_BASE_NAME);
}

static __inline W3D_Texture    * W3D_AllocTexObj(W3D_Context * context, ULONG * error, struct TagItem * ATOTags)
{
  return ((W3D_Texture    * (*)(W3D_Context * __asm("a0"), ULONG * __asm("a1"), struct TagItem * __asm("a2"), struct Library * __asm("a6")))
  (((char *) WARP3D_BASE_NAME) - 96))(context, error, ATOTags, (struct Library *) WARP3D_BASE_NAME);
}

static __inline void W3D_FreeTexObj(W3D_Context * context, W3D_Texture * texture)
{
  ((void (*)(W3D_Context * __asm("a0"), W3D_Texture * __asm("a1"), struct Library * __asm("a6")))
  (((char *) WARP3D_BASE_NAME) - 102))(context, texture, (struct Library *) WARP3D_BASE_NAME);
}

static __inline void W3D_ReleaseTexture(W3D_Context * context, W3D_Texture * texture)
{
  ((void (*)(W3D_Context * __asm("a0"), W3D_Texture * __asm("a1"), struct Library * __asm("a6")))
  (((char *) WARP3D_BASE_NAME) - 108))(context, texture, (struct Library *) WARP3D_BASE_NAME);
}

static __inline void W3D_FlushTextures(W3D_Context * context)
{
  ((void (*)(W3D_Context * __asm("a0"), struct Library * __asm("a6")))
  (((char *) WARP3D_BASE_NAME) - 114))(context, (struct Library *) WARP3D_BASE_NAME);
}

static __inline ULONG W3D_SetFilter(W3D_Context * context, W3D_Texture * texture, ULONG min, ULONG mag)
{
  return ((ULONG (*)(W3D_Context * __asm("a0"), W3D_Texture * __asm("a1"), ULONG __asm("d0"), ULONG __asm("d1"), struct Library * __asm("a6")))
  (((char *) WARP3D_BASE_NAME) - 120))(context, texture, min, mag, (struct Library *) WARP3D_BASE_NAME);
}

static __inline ULONG W3D_SetTexEnv(W3D_Context * context, W3D_Texture * texture, ULONG envparam, W3D_Color * envcolor)
{
  return ((ULONG (*)(W3D_Context * __asm("a0"), W3D_Texture * __asm("a1"), ULONG __asm("d1"), W3D_Color * __asm("a2"), struct Library * __asm("a6")))
  (((char *) WARP3D_BASE_NAME) - 126))(context, texture, envparam, envcolor, (struct Library *) WARP3D_BASE_NAME);
}

static __inline ULONG W3D_SetWrapMode(W3D_Context * context, W3D_Texture * texture, ULONG mode_s, ULONG mode_t, W3D_Color * bordercolor)
{
  return ((ULONG (*)(W3D_Context * __asm("a0"), W3D_Texture * __asm("a1"), ULONG __asm("d0"), ULONG __asm("d1"), W3D_Color * __asm("a2"), struct Library * __asm("a6")))
  (((char *) WARP3D_BASE_NAME) - 132))(context, texture, mode_s, mode_t, bordercolor, (struct Library *) WARP3D_BASE_NAME);
}

static __inline ULONG W3D_UpdateTexImage(W3D_Context * context, W3D_Texture * texture, void * teximage, int level, ULONG * palette)
{
  return ((ULONG (*)(W3D_Context * __asm("a0"), W3D_Texture * __asm("a1"), void * __asm("a2"), int __asm("d1"), ULONG * __asm("a3"), struct Library * __asm("a6")))
  (((char *) WARP3D_BASE_NAME) - 138))(context, texture, teximage, level, palette, (struct Library *) WARP3D_BASE_NAME);
}

static __inline ULONG W3D_UploadTexture(W3D_Context * context, W3D_Texture * texture)
{
  return ((ULONG (*)(W3D_Context * __asm("a0"), W3D_Texture * __asm("a1"), struct Library * __asm("a6")))
  (((char *) WARP3D_BASE_NAME) - 144))(context, texture, (struct Library *) WARP3D_BASE_NAME);
}

static __inline ULONG W3D_DrawLine(W3D_Context * context, W3D_Line * line)
{
  return ((ULONG (*)(W3D_Context * __asm("a0"), W3D_Line * __asm("a1"), struct Library * __asm("a6")))
  (((char *) WARP3D_BASE_NAME) - 150))(context, line, (struct Library *) WARP3D_BASE_NAME);
}

static __inline ULONG W3D_DrawPoint(W3D_Context * context, W3D_Point * point)
{
  return ((ULONG (*)(W3D_Context * __asm("a0"), W3D_Point * __asm("a1"), struct Library * __asm("a6")))
  (((char *) WARP3D_BASE_NAME) - 156))(context, point, (struct Library *) WARP3D_BASE_NAME);
}

static __inline ULONG W3D_DrawTriangle(W3D_Context * context, W3D_Triangle * triangle)
{
  return ((ULONG (*)(W3D_Context * __asm("a0"), W3D_Triangle * __asm("a1"), struct Library * __asm("a6")))
  (((char *) WARP3D_BASE_NAME) - 162))(context, triangle, (struct Library *) WARP3D_BASE_NAME);
}

static __inline ULONG W3D_DrawTriFan(W3D_Context * context, W3D_Triangles * triangles)
{
  return ((ULONG (*)(W3D_Context * __asm("a0"), W3D_Triangles * __asm("a1"), struct Library * __asm("a6")))
  (((char *) WARP3D_BASE_NAME) - 168))(context, triangles, (struct Library *) WARP3D_BASE_NAME);
}

static __inline ULONG W3D_DrawTriStrip(W3D_Context * context, W3D_Triangles * triangles)
{
  return ((ULONG (*)(W3D_Context * __asm("a0"), W3D_Triangles * __asm("a1"), struct Library * __asm("a6")))
  (((char *) WARP3D_BASE_NAME) - 174))(context, triangles, (struct Library *) WARP3D_BASE_NAME);
}

static __inline ULONG W3D_SetAlphaMode(W3D_Context * context, ULONG mode, W3D_Float * refval)
{
  return ((ULONG (*)(W3D_Context * __asm("a0"), ULONG __asm("d1"), W3D_Float * __asm("a1"), struct Library * __asm("a6")))
  (((char *) WARP3D_BASE_NAME) - 180))(context, mode, refval, (struct Library *) WARP3D_BASE_NAME);
}

static __inline ULONG W3D_SetBlendMode(W3D_Context * context, ULONG srcfunc, ULONG dstfunc)
{
  return ((ULONG (*)(W3D_Context * __asm("a0"), ULONG __asm("d0"), ULONG __asm("d1"), struct Library * __asm("a6")))
  (((char *) WARP3D_BASE_NAME) - 186))(context, srcfunc, dstfunc, (struct Library *) WARP3D_BASE_NAME);
}

static __inline ULONG W3D_SetDrawRegion(W3D_Context * context, struct BitMap * bm, int yoffset, W3D_Scissor * scissor)
{
  return ((ULONG (*)(W3D_Context * __asm("a0"), struct BitMap * __asm("a1"), int __asm("d1"), W3D_Scissor * __asm("a2"), struct Library * __asm("a6")))
  (((char *) WARP3D_BASE_NAME) - 192))(context, bm, yoffset, scissor, (struct Library *) WARP3D_BASE_NAME);
}

static __inline ULONG W3D_SetFogParams(W3D_Context * context, W3D_Fog * fogparams, ULONG fogmode)
{
  return ((ULONG (*)(W3D_Context * __asm("a0"), W3D_Fog * __asm("a1"), ULONG __asm("d1"), struct Library * __asm("a6")))
  (((char *) WARP3D_BASE_NAME) - 198))(context, fogparams, fogmode, (struct Library *) WARP3D_BASE_NAME);
}

static __inline ULONG W3D_SetColorMask(W3D_Context * context, W3D_Bool red, W3D_Bool green, W3D_Bool blue, W3D_Bool alpha)
{
  return ((ULONG (*)(W3D_Context * __asm("a0"), W3D_Bool __asm("d0"), W3D_Bool __asm("d1"), W3D_Bool __asm("d2"), W3D_Bool __asm("d3"), struct Library * __asm("a6")))
  (((char *) WARP3D_BASE_NAME) - 204))(context, red, green, blue, alpha, (struct Library *) WARP3D_BASE_NAME);
}

static __inline ULONG W3D_SetStencilFunc(W3D_Context * context, ULONG func, ULONG refvalue, ULONG mask)
{
  return ((ULONG (*)(W3D_Context * __asm("a0"), ULONG __asm("d0"), ULONG __asm("d1"), ULONG __asm("d2"), struct Library * __asm("a6")))
  (((char *) WARP3D_BASE_NAME) - 210))(context, func, refvalue, mask, (struct Library *) WARP3D_BASE_NAME);
}

static __inline ULONG W3D_AllocZBuffer(W3D_Context * context)
{
  return ((ULONG (*)(W3D_Context * __asm("a0"), struct Library * __asm("a6")))
  (((char *) WARP3D_BASE_NAME) - 216))(context, (struct Library *) WARP3D_BASE_NAME);
}

static __inline ULONG W3D_FreeZBuffer(W3D_Context * context)
{
  return ((ULONG (*)(W3D_Context * __asm("a0"), struct Library * __asm("a6")))
  (((char *) WARP3D_BASE_NAME) - 222))(context, (struct Library *) WARP3D_BASE_NAME);
}

static __inline ULONG W3D_ClearZBuffer(W3D_Context * context, W3D_Double * clearvalue)
{
  return ((ULONG (*)(W3D_Context * __asm("a0"), W3D_Double * __asm("a1"), struct Library * __asm("a6")))
  (((char *) WARP3D_BASE_NAME) - 228))(context, clearvalue, (struct Library *) WARP3D_BASE_NAME);
}

static __inline ULONG W3D_ReadZPixel(W3D_Context * context, ULONG x, ULONG y, W3D_Double * z)
{
  return ((ULONG (*)(W3D_Context * __asm("a0"), ULONG __asm("d0"), ULONG __asm("d1"), W3D_Double * __asm("a1"), struct Library * __asm("a6")))
  (((char *) WARP3D_BASE_NAME) - 234))(context, x, y, z, (struct Library *) WARP3D_BASE_NAME);
}

static __inline ULONG W3D_ReadZSpan(W3D_Context * context, ULONG x, ULONG y, ULONG n, W3D_Double * z)
{
  return ((ULONG (*)(W3D_Context * __asm("a0"), ULONG __asm("d0"), ULONG __asm("d1"), ULONG __asm("d2"), W3D_Double * __asm("a1"), struct Library * __asm("a6")))
  (((char *) WARP3D_BASE_NAME) - 240))(context, x, y, n, z, (struct Library *) WARP3D_BASE_NAME);
}

static __inline ULONG W3D_SetZCompareMode(W3D_Context * context, ULONG mode)
{
  return ((ULONG (*)(W3D_Context * __asm("a0"), ULONG __asm("d1"), struct Library * __asm("a6")))
  (((char *) WARP3D_BASE_NAME) - 246))(context, mode, (struct Library *) WARP3D_BASE_NAME);
}

static __inline ULONG W3D_AllocStencilBuffer(W3D_Context * context)
{
  return ((ULONG (*)(W3D_Context * __asm("a0"), struct Library * __asm("a6")))
  (((char *) WARP3D_BASE_NAME) - 252))(context, (struct Library *) WARP3D_BASE_NAME);
}

static __inline ULONG W3D_ClearStencilBuffer(W3D_Context * context, ULONG * clearval)
{
  return ((ULONG (*)(W3D_Context * __asm("a0"), ULONG * __asm("a1"), struct Library * __asm("a6")))
  (((char *) WARP3D_BASE_NAME) - 258))(context, clearval, (struct Library *) WARP3D_BASE_NAME);
}

static __inline ULONG W3D_FillStencilBuffer(W3D_Context * context, ULONG x, ULONG y, ULONG width, ULONG height, ULONG depth, void * data)
{
  return ((ULONG (*)(W3D_Context * __asm("a0"), ULONG __asm("d0"), ULONG __asm("d1"), ULONG __asm("d2"), ULONG __asm("d3"), ULONG __asm("d4"), void * __asm("a1"), struct Library * __asm("a6")))
  (((char *) WARP3D_BASE_NAME) - 264))(context, x, y, width, height, depth, data, (struct Library *) WARP3D_BASE_NAME);
}

static __inline ULONG W3D_FreeStencilBuffer(W3D_Context * context)
{
  return ((ULONG (*)(W3D_Context * __asm("a0"), struct Library * __asm("a6")))
  (((char *) WARP3D_BASE_NAME) - 270))(context, (struct Library *) WARP3D_BASE_NAME);
}

static __inline ULONG W3D_ReadStencilPixel(W3D_Context * context, ULONG x, ULONG y, ULONG * st)
{
  return ((ULONG (*)(W3D_Context * __asm("a0"), ULONG __asm("d0"), ULONG __asm("d1"), ULONG * __asm("a1"), struct Library * __asm("a6")))
  (((char *) WARP3D_BASE_NAME) - 276))(context, x, y, st, (struct Library *) WARP3D_BASE_NAME);
}

static __inline ULONG W3D_ReadStencilSpan(W3D_Context * context, ULONG x, ULONG y, ULONG n, ULONG * st)
{
  return ((ULONG (*)(W3D_Context * __asm("a0"), ULONG __asm("d0"), ULONG __asm("d1"), ULONG __asm("d2"), ULONG * __asm("a1"), struct Library * __asm("a6")))
  (((char *) WARP3D_BASE_NAME) - 282))(context, x, y, n, st, (struct Library *) WARP3D_BASE_NAME);
}

static __inline ULONG W3D_SetLogicOp(W3D_Context * context, ULONG operation)
{
  return ((ULONG (*)(W3D_Context * __asm("a0"), ULONG __asm("d1"), struct Library * __asm("a6")))
  (((char *) WARP3D_BASE_NAME) - 288))(context, operation, (struct Library *) WARP3D_BASE_NAME);
}

static __inline ULONG W3D_Hint(W3D_Context * context, ULONG mode, ULONG quality)
{
  return ((ULONG (*)(W3D_Context * __asm("a0"), ULONG __asm("d0"), ULONG __asm("d1"), struct Library * __asm("a6")))
  (((char *) WARP3D_BASE_NAME) - 294))(context, mode, quality, (struct Library *) WARP3D_BASE_NAME);
}

static __inline ULONG W3D_SetDrawRegionWBM(W3D_Context * context, W3D_Bitmap * bitmap, W3D_Scissor * scissor)
{
  return ((ULONG (*)(W3D_Context * __asm("a0"), W3D_Bitmap * __asm("a1"), W3D_Scissor * __asm("a2"), struct Library * __asm("a6")))
  (((char *) WARP3D_BASE_NAME) - 300))(context, bitmap, scissor, (struct Library *) WARP3D_BASE_NAME);
}

static __inline ULONG W3D_GetDriverState(W3D_Context * context)
{
  return ((ULONG (*)(W3D_Context * __asm("a0"), struct Library * __asm("a6")))
  (((char *) WARP3D_BASE_NAME) - 306))(context, (struct Library *) WARP3D_BASE_NAME);
}

static __inline ULONG W3D_Flush(W3D_Context * context)
{
  return ((ULONG (*)(W3D_Context * __asm("a0"), struct Library * __asm("a6")))
  (((char *) WARP3D_BASE_NAME) - 312))(context, (struct Library *) WARP3D_BASE_NAME);
}

static __inline ULONG W3D_SetPenMask(W3D_Context * context, ULONG pen)
{
  return ((ULONG (*)(W3D_Context * __asm("a0"), ULONG __asm("d1"), struct Library * __asm("a6")))
  (((char *) WARP3D_BASE_NAME) - 318))(context, pen, (struct Library *) WARP3D_BASE_NAME);
}

static __inline ULONG W3D_SetStencilOp(W3D_Context * context, ULONG sfail, ULONG dpfail, ULONG dppass)
{
  return ((ULONG (*)(W3D_Context * __asm("a0"), ULONG __asm("d0"), ULONG __asm("d1"), ULONG __asm("d2"), struct Library * __asm("a6")))
  (((char *) WARP3D_BASE_NAME) - 324))(context, sfail, dpfail, dppass, (struct Library *) WARP3D_BASE_NAME);
}

static __inline ULONG W3D_SetWriteMask(W3D_Context * context, ULONG mask)
{
  return ((ULONG (*)(W3D_Context * __asm("a0"), ULONG __asm("d1"), struct Library * __asm("a6")))
  (((char *) WARP3D_BASE_NAME) - 330))(context, mask, (struct Library *) WARP3D_BASE_NAME);
}

static __inline ULONG W3D_WriteStencilPixel(W3D_Context * context, ULONG x, ULONG y, ULONG st)
{
  return ((ULONG (*)(W3D_Context * __asm("a0"), ULONG __asm("d0"), ULONG __asm("d1"), ULONG __asm("d2"), struct Library * __asm("a6")))
  (((char *) WARP3D_BASE_NAME) - 336))(context, x, y, st, (struct Library *) WARP3D_BASE_NAME);
}

static __inline ULONG W3D_WriteStencilSpan(W3D_Context * context, ULONG x, ULONG y, ULONG n, ULONG * st, UBYTE * mask)
{
  return ((ULONG (*)(W3D_Context * __asm("a0"), ULONG __asm("d0"), ULONG __asm("d1"), ULONG __asm("d2"), ULONG * __asm("a1"), UBYTE * __asm("a2"), struct Library * __asm("a6")))
  (((char *) WARP3D_BASE_NAME) - 342))(context, x, y, n, st, mask, (struct Library *) WARP3D_BASE_NAME);
}

static __inline void W3D_WriteZPixel(W3D_Context * context, ULONG x, ULONG y, W3D_Double * z)
{
  ((void (*)(W3D_Context * __asm("a0"), ULONG __asm("d0"), ULONG __asm("d1"), W3D_Double * __asm("a1"), struct Library * __asm("a6")))
  (((char *) WARP3D_BASE_NAME) - 348))(context, x, y, z, (struct Library *) WARP3D_BASE_NAME);
}

static __inline void W3D_WriteZSpan(W3D_Context * context, ULONG x, ULONG y, ULONG n, W3D_Double * z, UBYTE * maks)
{
  ((void (*)(W3D_Context * __asm("a0"), ULONG __asm("d0"), ULONG __asm("d1"), ULONG __asm("d2"), W3D_Double * __asm("a1"), UBYTE * __asm("a2"), struct Library * __asm("a6")))
  (((char *) WARP3D_BASE_NAME) - 354))(context, x, y, n, z, maks, (struct Library *) WARP3D_BASE_NAME);
}

static __inline ULONG W3D_SetCurrentColor(W3D_Context * context, W3D_Color * color)
{
  return ((ULONG (*)(W3D_Context * __asm("a0"), W3D_Color * __asm("a1"), struct Library * __asm("a6")))
  (((char *) WARP3D_BASE_NAME) - 360))(context, color, (struct Library *) WARP3D_BASE_NAME);
}

static __inline ULONG W3D_SetCurrentPen(W3D_Context * context, ULONG pen)
{
  return ((ULONG (*)(W3D_Context * __asm("a0"), ULONG __asm("d1"), struct Library * __asm("a6")))
  (((char *) WARP3D_BASE_NAME) - 366))(context, pen, (struct Library *) WARP3D_BASE_NAME);
}

static __inline ULONG W3D_UpdateTexSubImage(W3D_Context * context, W3D_Texture * texture, void * teximage, ULONG lev, ULONG * palette, W3D_Scissor* scissor, ULONG srcbpr)
{
  return ((ULONG (*)(W3D_Context * __asm("a0"), W3D_Texture * __asm("a1"), void * __asm("a2"), ULONG __asm("d1"), ULONG * __asm("a3"), W3D_Scissor* __asm("a4"), ULONG __asm("d0"), struct Library * __asm("a6")))
  (((char *) WARP3D_BASE_NAME) - 372))(context, texture, teximage, lev, palette, scissor, srcbpr, (struct Library *) WARP3D_BASE_NAME);
}

static __inline ULONG W3D_FreeAllTexObj(W3D_Context * context)
{
  return ((ULONG (*)(W3D_Context * __asm("a0"), struct Library * __asm("a6")))
  (((char *) WARP3D_BASE_NAME) - 378))(context, (struct Library *) WARP3D_BASE_NAME);
}

static __inline ULONG W3D_GetDestFmt()
{
  return ((ULONG (*)(struct Library * __asm("a6")))
  (((char *) WARP3D_BASE_NAME) - 384))((struct Library *) WARP3D_BASE_NAME);
}

static __inline ULONG W3D_DrawLineStrip(W3D_Context * context, W3D_Lines * lines)
{
  return ((ULONG (*)(W3D_Context * __asm("a0"), W3D_Lines * __asm("a1"), struct Library * __asm("a6")))
  (((char *) WARP3D_BASE_NAME) - 390))(context, lines, (struct Library *) WARP3D_BASE_NAME);
}

static __inline ULONG W3D_DrawLineLoop(W3D_Context * context, W3D_Lines * lines)
{
  return ((ULONG (*)(W3D_Context * __asm("a0"), W3D_Lines * __asm("a1"), struct Library * __asm("a6")))
  (((char *) WARP3D_BASE_NAME) - 396))(context, lines, (struct Library *) WARP3D_BASE_NAME);
}

static __inline W3D_Driver ** W3D_GetDrivers()
{
  return ((W3D_Driver ** (*)(struct Library * __asm("a6")))
  (((char *) WARP3D_BASE_NAME) - 402))((struct Library *) WARP3D_BASE_NAME);
}

static __inline ULONG W3D_QueryDriver(W3D_Driver* driver, ULONG query, ULONG destfmt)
{
  return ((ULONG (*)(W3D_Driver* __asm("a0"), ULONG __asm("d0"), ULONG __asm("d1"), struct Library * __asm("a6")))
  (((char *) WARP3D_BASE_NAME) - 408))(driver, query, destfmt, (struct Library *) WARP3D_BASE_NAME);
}

static __inline ULONG W3D_GetDriverTexFmtInfo(W3D_Driver* driver, ULONG format, ULONG destfmt)
{
  return ((ULONG (*)(W3D_Driver* __asm("a0"), ULONG __asm("d0"), ULONG __asm("d1"), struct Library * __asm("a6")))
  (((char *) WARP3D_BASE_NAME) - 414))(driver, format, destfmt, (struct Library *) WARP3D_BASE_NAME);
}

static __inline ULONG W3D_RequestMode(struct TagItem * taglist)
{
  return ((ULONG (*)(struct TagItem * __asm("a0"), struct Library * __asm("a6")))
  (((char *) WARP3D_BASE_NAME) - 420))(taglist, (struct Library *) WARP3D_BASE_NAME);
}

static __inline ULONG W3D_RequestModeTags(Tag taglist, ...)
{
  return W3D_RequestMode((struct TagItem *) &taglist);
}

static __inline void W3D_SetScissor(W3D_Context * context, W3D_Scissor * scissor)
{
  ((void (*)(W3D_Context * __asm("a0"), W3D_Scissor * __asm("a1"), struct Library * __asm("a6")))
  (((char *) WARP3D_BASE_NAME) - 426))(context, scissor, (struct Library *) WARP3D_BASE_NAME);
}

static __inline void W3D_FlushFrame(W3D_Context * context)
{
  ((void (*)(W3D_Context * __asm("a0"), struct Library * __asm("a6")))
  (((char *) WARP3D_BASE_NAME) - 432))(context, (struct Library *) WARP3D_BASE_NAME);
}

static __inline W3D_Driver * W3D_TestMode(ULONG ModeID)
{
  return ((W3D_Driver * (*)(ULONG __asm("d0"), struct Library * __asm("a6")))
  (((char *) WARP3D_BASE_NAME) - 438))(ModeID, (struct Library *) WARP3D_BASE_NAME);
}

static __inline ULONG W3D_SetChromaTestBounds(W3D_Context * context, W3D_Texture * texture, ULONG rgba_lower, ULONG rgba_upper, ULONG mode)
{
  return ((ULONG (*)(W3D_Context * __asm("a0"), W3D_Texture * __asm("a1"), ULONG __asm("d0"), ULONG __asm("d1"), ULONG __asm("d2"), struct Library * __asm("a6")))
  (((char *) WARP3D_BASE_NAME) - 444))(context, texture, rgba_lower, rgba_upper, mode, (struct Library *) WARP3D_BASE_NAME);
}

static __inline ULONG W3D_ClearDrawRegion(W3D_Context * context, ULONG color)
{
  return ((ULONG (*)(W3D_Context * __asm("a0"), ULONG __asm("d0"), struct Library * __asm("a6")))
  (((char *) WARP3D_BASE_NAME) - 450))(context, color, (struct Library *) WARP3D_BASE_NAME);
}

static __inline ULONG W3D_DrawTriangleV(W3D_Context * context, W3D_TriangleV * triangle)
{
  return ((ULONG (*)(W3D_Context * __asm("a0"), W3D_TriangleV * __asm("a1"), struct Library * __asm("a6")))
  (((char *) WARP3D_BASE_NAME) - 456))(context, triangle, (struct Library *) WARP3D_BASE_NAME);
}

static __inline ULONG W3D_DrawTriFanV(W3D_Context * context, W3D_TrianglesV * triangles)
{
  return ((ULONG (*)(W3D_Context * __asm("a0"), W3D_TrianglesV * __asm("a1"), struct Library * __asm("a6")))
  (((char *) WARP3D_BASE_NAME) - 462))(context, triangles, (struct Library *) WARP3D_BASE_NAME);
}

static __inline ULONG W3D_DrawTriStripV(W3D_Context * context, W3D_TrianglesV * triangles)
{
  return ((ULONG (*)(W3D_Context * __asm("a0"), W3D_TrianglesV * __asm("a1"), struct Library * __asm("a6")))
  (((char *) WARP3D_BASE_NAME) - 468))(context, triangles, (struct Library *) WARP3D_BASE_NAME);
}

static __inline W3D_ScreenMode * W3D_GetScreenmodeList()
{
  return ((W3D_ScreenMode * (*)(struct Library * __asm("a6")))
  (((char *) WARP3D_BASE_NAME) - 474))((struct Library *) WARP3D_BASE_NAME);
}

static __inline void W3D_FreeScreenmodeList(W3D_ScreenMode * list)
{
  ((void (*)(W3D_ScreenMode * __asm("a0"), struct Library * __asm("a6")))
  (((char *) WARP3D_BASE_NAME) - 480))(list, (struct Library *) WARP3D_BASE_NAME);
}

static __inline ULONG W3D_BestModeID(struct TagItem * tags)
{
  return ((ULONG (*)(struct TagItem * __asm("a0"), struct Library * __asm("a6")))
  (((char *) WARP3D_BASE_NAME) - 486))(tags, (struct Library *) WARP3D_BASE_NAME);
}

static __inline ULONG W3D_BestModeIDTags(Tag tags, ...)
{
  return W3D_BestModeID((struct TagItem *) &tags);
}

static __inline ULONG W3D_VertexPointer(W3D_Context* context, void * pointer, int stride, ULONG mode, ULONG flags)
{
  return ((ULONG (*)(W3D_Context* __asm("a0"), void * __asm("a1"), int __asm("d0"), ULONG __asm("d1"), ULONG __asm("d2"), struct Library * __asm("a6")))
  (((char *) WARP3D_BASE_NAME) - 492))(context, pointer, stride, mode, flags, (struct Library *) WARP3D_BASE_NAME);
}

static __inline ULONG W3D_TexCoordPointer(W3D_Context* context, void * pointer, int stride, int unit, int off_v, int off_w, ULONG flags)
{
  return ((ULONG (*)(W3D_Context* __asm("a0"), void * __asm("a1"), int __asm("d0"), int __asm("d1"), int __asm("d2"), int __asm("d3"), ULONG __asm("d4"), struct Library * __asm("a6")))
  (((char *) WARP3D_BASE_NAME) - 498))(context, pointer, stride, unit, off_v, off_w, flags, (struct Library *) WARP3D_BASE_NAME);
}

static __inline ULONG W3D_ColorPointer(W3D_Context* context, void * pointer, int stride, ULONG format, ULONG mode, ULONG flags)
{
  return ((ULONG (*)(W3D_Context* __asm("a0"), void * __asm("a1"), int __asm("d0"), ULONG __asm("d1"), ULONG __asm("d2"), ULONG __asm("d3"), struct Library * __asm("a6")))
  (((char *) WARP3D_BASE_NAME) - 504))(context, pointer, stride, format, mode, flags, (struct Library *) WARP3D_BASE_NAME);
}

static __inline ULONG W3D_BindTexture(W3D_Context* context, ULONG tmu, W3D_Texture * texture)
{
  return ((ULONG (*)(W3D_Context* __asm("a0"), ULONG __asm("d0"), W3D_Texture * __asm("a1"), struct Library * __asm("a6")))
  (((char *) WARP3D_BASE_NAME) - 510))(context, tmu, texture, (struct Library *) WARP3D_BASE_NAME);
}

static __inline ULONG W3D_DrawArray(W3D_Context* context, ULONG primitive, ULONG base, ULONG count)
{
  return ((ULONG (*)(W3D_Context* __asm("a0"), ULONG __asm("d0"), ULONG __asm("d1"), ULONG __asm("d2"), struct Library * __asm("a6")))
  (((char *) WARP3D_BASE_NAME) - 516))(context, primitive, base, count, (struct Library *) WARP3D_BASE_NAME);
}

static __inline ULONG W3D_DrawElements(W3D_Context* context, ULONG primitive, ULONG type, ULONG count, void * indices)
{
  return ((ULONG (*)(W3D_Context* __asm("a0"), ULONG __asm("d0"), ULONG __asm("d1"), ULONG __asm("d2"), void * __asm("a1"), struct Library * __asm("a6")))
  (((char *) WARP3D_BASE_NAME) - 522))(context, primitive, type, count, indices, (struct Library *) WARP3D_BASE_NAME);
}

static __inline void W3D_SetFrontFace(W3D_Context* context, ULONG direction)
{
  ((void (*)(W3D_Context* __asm("a0"), ULONG __asm("d0"), struct Library * __asm("a6")))
  (((char *) WARP3D_BASE_NAME) - 528))(context, direction, (struct Library *) WARP3D_BASE_NAME);
}

#endif /*  _INLINE_WARP3D_H  */
