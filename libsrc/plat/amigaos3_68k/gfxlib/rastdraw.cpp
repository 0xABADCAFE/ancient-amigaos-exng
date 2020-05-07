//****************************************************************************//
//**                                                                        **//
//** File:         libsrc/plat/amigaos3_68k/gfxlib/rasterizerdraw.cpp       **//
//** Description:  3D rasterizer drawing definitions                        **//
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

using namespace X_SYSNAME;

////////////////////////////////////////////////////////////////////////////////
//
//  Rasterizer Drawing code
//
////////////////////////////////////////////////////////////////////////////////

bool Rasterizer::drawTriMesh(size_t ofs, size_t dx, size_t dy)
{
  // Render mesh as W3D_PRIMITIVE_TRIANGLES
  //
  //  Relationship of indicies (idx) to original vertex array position
  //
  //   1:3------4  idx[n+0] = ofs+n+dx
  //   | \      |  idx[n+1] = ofs+n
  //   |  \     |  idx[n+2] = ofs+n+dx+1
  //   |   \    |  idx[n+3] = ofs+n
  //   |    \   |  idx[n+4] = ofs+n+1
  //   |     \  |  idx[n+5] = ofs+n+dx+1
  //   |      \ |
  //   0------2:5


  size_t  totTris  = 2*((dx-1)*(dy-1));
  sint32  modx    = dx-1;                // end of span
  ruint32  i0      = ofs;                // ofs+n
  ruint32  i1      = ofs+dx;              // ofs+n+dx

  // Render mesh as blocks of MESH_MAX_TRIS_PER_CALL triangles

  while (totTris >= MESH_MAX_TRIS_PER_CALL)
  {  // Triangle list setup, always draw as pairs
    ruint16*  idx  = meshIndexBuffer;
    rsint32   i    = (MESH_MAX_TRIS_PER_CALL>>1)+1;
    while (--i)
    {
      idx[0]=i1++; idx[3]=idx[1]=i0++; idx[4]=i0; idx[5]=idx[2]=i1;
      idx+=6;
      if (--modx<=0)
      { // end of x span?
        modx = dx-1;
        i0++; i1++;
      }
    }
    if (W3D_DrawElements(context,  W3D_PRIMITIVE_TRIANGLES,          \
                         W3D_INDEX_UWORD, MESH_MAX_TRIS_PER_CALL*3,  \
                        (void*)meshIndexBuffer) != W3D_SUCCESS)
      return false;
    totTris -= MESH_MAX_TRIS_PER_CALL;
  }

  // Render any triangles left over
  if (totTris>0)
  {  // Triangle list setup, always draw as pairs
    ruint16*  idx  = meshIndexBuffer;
    rsint32   i    = (totTris>>1)+1;
    while (--i)
    {
      idx[0]=i1++; idx[3]=idx[1]=i0++; idx[4]=i0; idx[5]=idx[2]=i1;
      idx+=6;
      if (--modx<=0)
      { // end of x span ?
        modx = dx-1;
        i0++; i1++;
      }
    }
    if (W3D_DrawElements(context, W3D_PRIMITIVE_TRIANGLES,      \
                         W3D_INDEX_UWORD, totTris*3,            \
                        (void*)meshIndexBuffer) != W3D_SUCCESS)
      return false;
  }
  return true;
}

////////////////////////////////////////////////////////////////////////////////
/*
bool Rasterizer::drawTriStripClipped(size_t cnt)
{

  uint16*  idx = meshIndexBuffer;
  switch (vrtPtrType) {
    case G3D::XYZ_FLOAT32: {
      uint32 stripLen = 0;
      float32 x1 = drawRegion.left;
      float32 y1 = drawRegion.top;
      float32 x2 = x1 + drawRegion.width;
      float32 y2 = y1 + drawRegion.height;
      union {
        uint32  codes;
        uint8    cc[4];
      };
      bool start = true;
      while (cnt) {
        rfloat32* tmp;

        tmp = (float32*)(vertPtr + idx[0]*vrtPtrStride);
        cc[0] = tmp[0]<x1 ? 1 : tmp[0]>x2 ? 2 : 0;
        cc[0] |= tmp[1]<y1 ? 8 : tmp[1]>y2 ? 4 : 0;

        tmp = (float32*)(vertPtr + idx[1]*vrtPtrStride);
        cc[1] = tmp[0]<x1 ? 1 : tmp[0]>x2 ? 2 : 0;
        cc[1] |= tmp[1]<y1 ? 8 : tmp[1]>y2 ? 4 : 0;

        tmp = (float32*)(vertPtr + idx[1]*vrtPtrStride);
        cc[2] = tmp[0]<x1 ? 1 : tmp[0]>x2 ? 2 : 0;
        cc[2] |= tmp[1]<y1 ? 8 : tmp[1]>y2 ? 4 : 0;

        tmp = (float32*)(vertPtr + idx[1]*vrtPtrStride);
        cc[3] = tmp[0]<x1 ? 1 : tmp[0]>x2 ? 2 : 0;
        cc[3] |= tmp[1]<y1 ? 8 : tmp[1]>y2 ? 4 : 0;

        if (codes==0) {
          stripLen+=2;
        }
        else {
          if (start) {
            if (W3D_DrawElements(context,  W3D_PRIMITIVE_TRISTRIP,
                                  W3D_INDEX_UWORD, stripLen,
                                  (void*)meshIndexBuffer) != W3D_SUCCESS)
              return false;
          }
        }

        cnt-=2;
      }
    }
    break;

    case G3D::XYZ_FLOAT64: {
    }
    break;

    default: {
      return false;
    }
    break;
  }
  return false;
}
*/

bool Rasterizer::drawTriMesh2(size_t ofs, size_t dx, size_t dy)
{
  // Render mesh as W3D_PRIMITIVE_TRISTRIP

  //  Relationship of indicies (idx) to original vertex array pos (v[])
  //
  //   1---..   idx[n+0] = ofs+n+dx
  //   |\   :   idx[n+1] = ofs+n
  //   | \  :
  //   |  \ :
  //   |   \:
  //   0---..

  // Span must fit into meshIndexBuffer

  // FIXME : break into sections if span too large

  if ( dx<=((MESH_MAX_TRIS_PER_CALL+2)/2) )
  {
    while (--dy)
    {
      ruint16 *idx = meshIndexBuffer;
      rsint32 i = dx+1;
      while (--i)
      {
        *idx++ = ofs+dx; *idx++ = ofs++;
      }
      if (W3D_DrawElements(context,  W3D_PRIMITIVE_TRISTRIP,        \
                           W3D_INDEX_UWORD, dx<<1,                \
                          (void*)meshIndexBuffer) != W3D_SUCCESS)
        return false;
    }
    return true;
  }
  return false;
}

#ifdef FIX_WARP3D_POINTS

////////////////////////////////////////////////////////////////////////////////
//
//  Emulated Vertex Array code for point drawing
//
////////////////////////////////////////////////////////////////////////////////

bool Rasterizer::drawPoints(size_t ofs, size_t cnt)
{
  if (!vrtPtrX || cnt < 1)
    return false;

  if (useArrayEmul)
  {
    switch (vrtPtrType) {
      case G3D::XYZ_FLOAT32:
        return drawPointsXYZ_F32[clrPtrType](this, ofs, cnt);
        break;
      case G3D::XYZ_FLOAT64:
        return drawPointsXYZ_F64[clrPtrType](this, ofs, cnt);
        break;
      default:
        return false;
        break;
    }
  }
  else
  {
    return (W3D_DrawArray(context, W3D_PRIMITIVE_POINTS, ofs, cnt)==W3D_SUCCESS);
  }
}

////////////////////////////////////////////////////////////////////////////////

bool Rasterizer::drawPointsXYZ_F32_CLR_U8(Rasterizer* rast, size_t ofs, size_t cnt)
{
  //W3D_Point point;
  if (W3D_GetState(rast->context, W3D_GOURAUD)==W3D_ENABLED)
  {
  }
  return false;
}

////////////////////////////////////////////////////////////////////////////////

bool Rasterizer::drawPointsXYZ_F32_CLR_F32(Rasterizer* rast, size_t ofs, size_t cnt)
{
  if (W3D_GetState(rast->context, W3D_GOURAUD)==W3D_ENABLED)
  {
  }

  return false;
}

////////////////////////////////////////////////////////////////////////////////

bool Rasterizer::drawPointsXYZ_F64_CLR_U8(Rasterizer* rast, size_t ofs, size_t cnt)
{
  if (W3D_GetState(rast->context, W3D_GOURAUD)==W3D_ENABLED)
  {
  }
  return false;
}

////////////////////////////////////////////////////////////////////////////////

bool Rasterizer::drawPointsXYZ_F64_CLR_F32(Rasterizer* rast, size_t ofs, size_t cnt)
{
  if (W3D_GetState(rast->context, W3D_GOURAUD)==W3D_ENABLED)
  {
  }

  return false;
}

////////////////////////////////////////////////////////////////////////////////

Rasterizer::DrawFunc Rasterizer::drawPointsXYZ_F32[G3D::NUM_COLOURTYPE] =
{
  drawPointsXYZ_F32_CLR_U8,
  drawPointsXYZ_F32_CLR_U8,
  drawPointsXYZ_F32_CLR_F32,
  drawPointsXYZ_F32_CLR_F32
};

////////////////////////////////////////////////////////////////////////////////

Rasterizer::DrawFunc Rasterizer::drawPointsXYZ_F64[G3D::NUM_COLOURTYPE] =
{
  drawPointsXYZ_F64_CLR_U8,
  drawPointsXYZ_F64_CLR_U8,
  drawPointsXYZ_F64_CLR_F32,
  drawPointsXYZ_F64_CLR_F32
};

////////////////////////////////////////////////////////////////////////////////

#endif


#ifdef FIX_WARP3D_LINES

////////////////////////////////////////////////////////////////////////////////
//
//  Emulated Vertex Array code for line drawing
//
////////////////////////////////////////////////////////////////////////////////

bool Rasterizer::drawLines(size_t ofs, size_t cnt)
{
  if (!vrtPtrX || cnt < 2)
    return false;
  if (useArrayEmul)
  {
    switch (vrtPtrType) {
      case G3D::XYZ_FLOAT32:
        return drawLinesXYZ_F32[clrPtrType](this, ofs, cnt);
        break;
      case G3D::XYZ_FLOAT64:
        return drawLinesXYZ_F64[clrPtrType](this, ofs, cnt);
        break;
      default:
        return false;
        break;
    }
  }
  else
  {
    return (W3D_DrawArray(context, W3D_PRIMITIVE_LINES, ofs, cnt)==W3D_SUCCESS);
  }
}

////////////////////////////////////////////////////////////////////////////////

bool Rasterizer::drawLinesXYZ_F32_CLR_U8(Rasterizer* rast, size_t ofs, size_t cnt)
{
  W3D_Line line;
  // Create temporary pointers
  rsint32 ofst = ofs*rast->vrtPtrStride;
  uint8 *x = rast->vrtPtrX+ofst;
  uint8 *y = rast->vrtPtrY+ofst;
  uint8 *z = rast->vrtPtrZ+ofst;
  uint8 *a, *r, *g, *b, *u, *v, *w;
  bool shade, texture;

  if (shade = (W3D_GetState(rast->context, W3D_GOURAUD) == W3D_ENABLED))
  {
    ofst = ofs*rast->clrPtrStride;
    a = rast->clrPtrA+ofst;
    r = rast->clrPtrR+ofst;
    g = rast->clrPtrG+ofst;
    b = rast->clrPtrB+ofst;
  }

  if (texture = (W3D_GetState(rast->context, W3D_TEXMAPPING) == W3D_ENABLED))
  {
    line.tex  = rast->texture->tex;
    ofst = ofs*rast->texPtrStride;
    w = rast->texPtrW+ofst;
    u = rast->texPtrUS+ofst;
    v = rast->texPtrVT+ofst;
  }

  rfloat32 f = 1.0f/256.0f;
  rsint32 cnt2 = 1+(cnt>>1);
  while (--cnt2)
  {
    ofst = rast->vrtPtrStride;
    line.v1.x  = *((float32*)x); x += ofst;
    line.v1.y  = *((float32*)y); y += ofst;
    line.v1.z  = *((float32*)z); z += ofst;
    line.v2.x  = *((float32*)x); x += ofst;
    line.v2.y  = *((float32*)y); y += ofst;
    line.v2.z  = *((float32*)z); z += ofst;
    if (texture)
    {
      ofst = rast->texPtrStride;
      line.v1.w = *((float32*)w); w += ofst;
      line.v1.u = *((float32*)u); u += ofst;
      line.v1.v = *((float32*)v); v += ofst;
      line.v2.w = *((float32*)w); w += ofst;
      line.v2.u = *((float32*)u); u += ofst;
      line.v2.v = *((float32*)v); v += ofst;
    }
    if (shade)
    {
      ofst = rast->clrPtrStride;
      line.v1.color.r  = f*(*r);    r += ofst;
      line.v1.color.g  = f*(*g);    g += ofst;
      line.v1.color.b  = f*(*b);    b += ofst;
      line.v1.color.a  = f*(*a);    a += ofst;
      line.v2.color.r  = f*(*r);    r += ofst;
      line.v2.color.g  = f*(*g);    g += ofst;
      line.v2.color.b  = f*(*b);    b += ofst;
      line.v2.color.a  = f*(*a);    a += ofst;
    }
    if (W3D_DrawLine(rast->context, &line)!=W3D_SUCCESS)
      return false;
  }
  return true;
}

////////////////////////////////////////////////////////////////////////////////

bool Rasterizer::drawLinesXYZ_F32_CLR_F32(Rasterizer* rast, size_t ofs, size_t cnt)
{
  W3D_Line line;

  // Create temporary pointers
  rsint32 ofst = ofs*rast->vrtPtrStride;
  uint8 *x = rast->vrtPtrX+ofst;
  uint8 *y = rast->vrtPtrY+ofst;
  uint8 *z = rast->vrtPtrZ+ofst;

  uint8 *a, *r, *g, *b, *u, *v, *w;
  bool shade, texture;

  if (shade = (W3D_GetState(rast->context, W3D_GOURAUD) == W3D_ENABLED))
  {
    ofst = ofs*rast->clrPtrStride;
    a = rast->clrPtrA+ofst;
    r = rast->clrPtrR+ofst;
    g = rast->clrPtrG+ofst;
    b = rast->clrPtrB+ofst;
  }

  if (texture = (W3D_GetState(rast->context, W3D_TEXMAPPING) == W3D_ENABLED))
  {
    line.tex  = rast->texture->tex;
    ofst = ofs*rast->texPtrStride;
    w = rast->texPtrW+ofst;
    u = rast->texPtrUS+ofst;
    v = rast->texPtrVT+ofst;
  }

  rsint32 cnt2 = 1+(cnt>>1);

  while (--cnt2)
  {
    ofst = rast->vrtPtrStride;
    line.v1.x  = *((float32*)x); x += ofst;
    line.v1.y  = *((float32*)y); y += ofst;
    line.v1.z  = *((float32*)z); z += ofst;
    line.v2.x  = *((float32*)x); x += ofst;
    line.v2.y  = *((float32*)y); y += ofst;
    line.v2.z  = *((float32*)z); z += ofst;
    if (texture)
    {
      ofst = rast->texPtrStride;
      line.v1.w = *((float32*)w); w += ofst;
      line.v1.u = *((float32*)u); u += ofst;
      line.v1.v = *((float32*)v); v += ofst;
      line.v2.w = *((float32*)w); w += ofst;
      line.v2.u = *((float32*)u); u += ofst;
      line.v2.v = *((float32*)v); v += ofst;
    }
    if (shade)
    {
      ofst = rast->clrPtrStride;
      line.v1.color.r  = *((float32*)r); r += ofst;
      line.v1.color.g  = *((float32*)g); g += ofst;
      line.v1.color.b  = *((float32*)b); b += ofst;
      line.v1.color.a  = *((float32*)a); a += ofst;
      line.v2.color.r  = *((float32*)r); r += ofst;
      line.v2.color.g  = *((float32*)g); g += ofst;
      line.v2.color.b  = *((float32*)b); b += ofst;
      line.v2.color.a  = *((float32*)a); a += ofst;
    }
    if (W3D_DrawLine(rast->context, &line)!=W3D_SUCCESS)
      return false;
  }
  return true;
}

////////////////////////////////////////////////////////////////////////////////

bool Rasterizer::drawLinesXYZ_F64_CLR_U8(Rasterizer* rast, size_t ofs, size_t cnt)
{
  W3D_Line line;

  // Create temporary x/y/z pointers
  rsint32 ofst = ofs*rast->vrtPtrStride;
  uint8 *x = rast->vrtPtrX+ofst;
  uint8 *y = rast->vrtPtrY+ofst;
  uint8 *z = rast->vrtPtrZ+ofst;

  uint8 *a, *r, *g, *b, *u, *v, *w;
  bool shade, texture;

  if (shade = (W3D_GetState(rast->context, W3D_GOURAUD) == W3D_ENABLED))
  {
    ofst = ofs*rast->clrPtrStride;
    a = rast->clrPtrA+ofst;
    r = rast->clrPtrR+ofst;
    g = rast->clrPtrG+ofst;
    b = rast->clrPtrB+ofst;
  }

  if (texture = (W3D_GetState(rast->context, W3D_TEXMAPPING) == W3D_ENABLED))
  {
    line.tex  = rast->texture->tex;
    ofst = ofs*rast->texPtrStride;
    w = rast->texPtrW+ofst;
    u = rast->texPtrUS+ofst;
    v = rast->texPtrVT+ofst;
  }

  rfloat32 f = 1.0f/256.0f;
  rsint32 cnt2 = 1+(cnt>>1);
  while (--cnt2)
  {
    ofst = rast->vrtPtrStride;
    line.v1.x  = *((float64*)x); x += ofst;
    line.v1.y  = *((float64*)y); y += ofst;
    line.v1.z  = *((float64*)z); z += ofst;
    line.v2.x  = *((float64*)x); x += ofst;
    line.v2.y  = *((float64*)y); y += ofst;
    line.v2.z  = *((float64*)z); z += ofst;
    if (texture)
    {
      ofst = rast->texPtrStride;
      line.v1.w = *((float32*)w); w += ofst;
      line.v1.u = *((float32*)u); u += ofst;
      line.v1.v = *((float32*)v); v += ofst;
      line.v2.w = *((float32*)w); w += ofst;
      line.v2.u = *((float32*)u); u += ofst;
      line.v2.v = *((float32*)v); v += ofst;
    }
    if (shade)
    {
      ofst = rast->clrPtrStride;
      line.v1.color.r  = f*(*r); r += ofst;
      line.v1.color.g  = f*(*g); g += ofst;
      line.v1.color.b  = f*(*b); b += ofst;
      line.v1.color.a  = f*(*a); a += ofst;
      line.v2.color.r  = f*(*r); r += ofst;
      line.v2.color.g  = f*(*g); g += ofst;
      line.v2.color.b  = f*(*b); b += ofst;
      line.v2.color.a  = f*(*a); a += ofst;
    }
    if (W3D_DrawLine(rast->context, &line)!=W3D_SUCCESS)
      return false;
  }
  return true;
}

////////////////////////////////////////////////////////////////////////////////

bool Rasterizer::drawLinesXYZ_F64_CLR_F32(Rasterizer* rast, size_t ofs, size_t cnt)
{
  W3D_Line line;

  // Create temporary pointers
  rsint32 ofst = ofs*rast->vrtPtrStride;
  uint8 *x = rast->vrtPtrX+ofst;
  uint8 *y = rast->vrtPtrY+ofst;
  uint8 *z = rast->vrtPtrZ+ofst;

  uint8 *a, *r, *g, *b, *u, *v, *w;
  bool shade, texture;

  if (shade = (W3D_GetState(rast->context, W3D_GOURAUD) == W3D_ENABLED))
  {
    ofst = ofs*rast->clrPtrStride;
    a = rast->clrPtrA+ofst;
    r = rast->clrPtrR+ofst;
    g = rast->clrPtrG+ofst;
    b = rast->clrPtrB+ofst;
  }

  if (texture = (W3D_GetState(rast->context, W3D_TEXMAPPING) == W3D_ENABLED))
  {
    line.tex  = rast->texture->tex;
    ofst = ofs*rast->texPtrStride;
    w = rast->texPtrW+ofst;
    u = rast->texPtrUS+ofst;
    v = rast->texPtrVT+ofst;
  }

  rsint32 cnt2 = 1+(cnt>>1);
  while (--cnt2)
  {
    ofst = rast->vrtPtrStride;
    line.v1.x  = *((float64*)x); x += ofst;
    line.v1.y  = *((float64*)y); y += ofst;
    line.v1.z  = *((float64*)z); z += ofst;
    line.v2.x  = *((float64*)x); x += ofst;
    line.v2.y  = *((float64*)y); y += ofst;
    line.v2.z  = *((float64*)z); z += ofst;
    if (texture)
    {
      ofst = rast->texPtrStride;
      line.v1.w = *((float32*)w); w += ofst;
      line.v1.u = *((float32*)u); u += ofst;
      line.v1.v = *((float32*)v); v += ofst;
      line.v2.w = *((float32*)w); w += ofst;
      line.v2.u = *((float32*)u); u += ofst;
      line.v2.v = *((float32*)v); v += ofst;
    }
    if (shade)
    {
      ofst = rast->clrPtrStride;
      line.v1.color.r  = *((float32*)r); r += ofst;
      line.v1.color.g  = *((float32*)g); g += ofst;
      line.v1.color.b  = *((float32*)b); b += ofst;
      line.v1.color.a  = *((float32*)a); a += ofst;
      line.v2.color.r  = *((float32*)r); r += ofst;
      line.v2.color.g  = *((float32*)g); g += ofst;
      line.v2.color.b  = *((float32*)b); b += ofst;
      line.v2.color.a  = *((float32*)a); a += ofst;
    }
    if (W3D_DrawLine(rast->context, &line)!=W3D_SUCCESS)
      return false;
  }
  return true;
}

////////////////////////////////////////////////////////////////////////////////

Rasterizer::DrawFunc Rasterizer::drawLinesXYZ_F32[G3D::NUM_COLOURTYPE] =
{
  drawLinesXYZ_F32_CLR_U8,
  drawLinesXYZ_F32_CLR_U8,
  drawLinesXYZ_F32_CLR_F32,
  drawLinesXYZ_F32_CLR_F32
};

////////////////////////////////////////////////////////////////////////////////

Rasterizer::DrawFunc Rasterizer::drawLinesXYZ_F64[G3D::NUM_COLOURTYPE] =
{
  drawLinesXYZ_F64_CLR_U8,
  drawLinesXYZ_F64_CLR_U8,
  drawLinesXYZ_F64_CLR_F32,
  drawLinesXYZ_F64_CLR_F32
};

////////////////////////////////////////////////////////////////////////////////

bool Rasterizer::drawLineStrip(size_t ofs, size_t cnt)
{
  if (!vrtPtrX || cnt < 2)
    return false;
  if (useArrayEmul)
  {
    switch (vrtPtrType) {
      case G3D::XYZ_FLOAT32:
        return drawLineStripXYZ_F32[clrPtrType](this, ofs, cnt);
        break;
      case G3D::XYZ_FLOAT64:
        return drawLineStripXYZ_F64[clrPtrType](this, ofs, cnt);
        break;
      default:
        return false;
        break;
    }
  }
  else
  {
    return (W3D_DrawArray(context, W3D_PRIMITIVE_LINESTRIP, ofs, cnt)==W3D_SUCCESS);
  }
}

////////////////////////////////////////////////////////////////////////////////


/*
#define OLD_STRIP_SEGS 16

bool Rasterizer::drawLineStrip(size_t ofs, size_t cnt)
{
  if (vertPtr==0 || cnt < 2)
    return false;

  W3D_Vertex tempVert[OLD_STRIP_SEGS+2];
  W3D_Lines lines = {0,tempVert,texture->tex};
  register DrawVertex* d = vertPtr+ofs;
  Colour clr;
  if (W3D_GetState(context, W3D_GOURAUD)==W3D_ENABLED)
  { // shaded vertices require more work
    rsint32 c = --cnt;
    rfloat32 f = 1F/256F; lines.vertexcount = OLD_STRIP_SEGS+1;
    while (c>OLD_STRIP_SEGS)
    {
      register W3D_Vertex* v = tempVert; rsint32 i = OLD_STRIP_SEGS+2;
      while(--i)
      {
        v->x = d->x; v->y = d->y; v->z = d->z;
        v->w = d->w; v->u = d->u; v->v = d->v;
        clr                = (d++)->colour;
        v->color.r        = f*clr.red();
        v->color.g        = f*clr.green();
        v->color.b        = f*clr.blue();
        (v++)->color.a    = f*clr.alpha();
      }
      if (W3D_DrawLineStrip(context, &lines)!=W3D_SUCCESS)
        return false;
      d--;
      c-=OLD_STRIP_SEGS;
    }
    if (c>0)
    {
      if (c<cnt) // end of existing series of line segments
      {
        d--; c++;
      }
      register W3D_Vertex* v = tempVert;  lines.vertexcount = ++c;  rsint32 i = ++c;
      while(--i)
      {
        v->x = d->x; v->y = d->y; v->z = d->z;
        v->w = d->w; v->u = d->u; v->v = d->v;
        clr                = (d++)->colour;
        v->color.r        = f*clr.red();
        v->color.g        = f*clr.green();
        v->color.b        = f*clr.blue();
        (v++)->color.a    = f*clr.alpha();
      }
      if (W3D_DrawLineStrip(context, &lines)!=W3D_SUCCESS)
        return false;
    }
    return true;
  }
  else // non shaded vertices
  {
    rsint32 c = --cnt;
    lines.vertexcount = OLD_STRIP_SEGS+1;
    while (c>OLD_STRIP_SEGS)
    {
      register W3D_Vertex* v = tempVert;
      rsint32 i = OLD_STRIP_SEGS+2;
      while(--i)
      {
        v->x = d->x; v->y = d->y; v->z = d->z;
        v->w = d->w; v->u = d->u; (v++)->v = (d++)->v;
      }
      if (W3D_DrawLineStrip(context, &lines)!=W3D_SUCCESS)
        return false;
      d--;
      c-=OLD_STRIP_SEGS;
    }
    if (c>0)
    {
      if (c<cnt) // end of existing series of line segments
      {
        d--; c++;
      }
      register W3D_Vertex* v = tempVert; lines.vertexcount = ++c; rsint32 i = ++c;
      while (--i)
      {
        v->x = d->x; v->y = d->y; v->z = d->z;
        v->w = d->w; v->u = d->u; (v++)->v = (d++)->v;
      }
      if (W3D_DrawLineStrip(context, &lines)!=W3D_SUCCESS)
        return false;
    }
    return true;
  }
}

#undef OLD_STRIP_SEGS
*/


#define OLD_STRIP_SEGS 16

bool Rasterizer::drawLineStripXYZ_F32_CLR_U8(Rasterizer* rast, size_t ofs, size_t cnt)
{
  W3D_Vertex tempVert[OLD_STRIP_SEGS+2];
  W3D_Lines lines = {0, tempVert, 0};

  // Create temporary pointers
  rsint32 ofst = ofs*rast->vrtPtrStride;
  uint8 *x = rast->vrtPtrX+ofst;
  uint8 *y = rast->vrtPtrY+ofst;
  uint8 *z = rast->vrtPtrZ+ofst;

  uint8 *a, *r, *g, *b, *u, *v, *w;
  bool shade, texture;

  if (shade = (W3D_GetState(rast->context, W3D_GOURAUD) == W3D_ENABLED))
  {
    ofst = ofs*rast->clrPtrStride;
    a = rast->clrPtrA+ofst;
    r = rast->clrPtrR+ofst;
    g = rast->clrPtrG+ofst;
    b = rast->clrPtrB+ofst;
  }

  if (texture = (W3D_GetState(rast->context, W3D_TEXMAPPING) == W3D_ENABLED))
  {
    lines.tex  = rast->texture->tex;
    ofst = ofs*rast->texPtrStride;
    w = rast->texPtrW+ofst;
    u = rast->texPtrUS+ofst;
    v = rast->texPtrVT+ofst;
  }
  lines.vertexcount = OLD_STRIP_SEGS+1;
  rsint32 cnt2 = --cnt;
  rfloat32 f = 1.0f/256.0f;
  while (cnt2>OLD_STRIP_SEGS)
  {
    register W3D_Vertex* v = tempVert;
    rsint32 i = OLD_STRIP_SEGS+2;
    while(--i)
    {
      ofst = rast->vrtPtrStride;
      v->x = *((float32*)x); x += ofst;
      v->y = *((float32*)y); y += ofst;
      v->z = *((float32*)z); z += ofst;
      if (texture)
      {
        ofst = rast->texPtrStride;
        v->w = *((float32*)w); w += ofst;
        v->u = *((float32*)u); u += ofst;
        v->v = *((float32*)v); v += ofst;
      }
      if (shade)
      {
        ofst = rast->clrPtrStride;
        v->color.r = f*(*r); r += ofst;
        v->color.g = f*(*g); g += ofst;
        v->color.b = f*(*b); b += ofst;
        v->color.a = f*(*a); a += ofst;
      }
      v++;
    }
    if (W3D_DrawLineStrip(rast->context, &lines)!=W3D_SUCCESS)
      return false;
    cnt2-=OLD_STRIP_SEGS;
    ofst = rast->vrtPtrStride; x -= ofst; y -= ofst; z -= ofst;
    if (texture)
    {
      ofst = rast->texPtrStride; w -= ofst; u -= ofst; v -= ofst;
    }
    if (shade)
    {
      ofst = rast->clrPtrStride; r -= ofst; g -= ofst; b -= ofst; a -= ofst;
    }
  }
  if (cnt2>0)
  {
    if (cnt2<cnt) // end of existing series of line segments
    {
      ofst = rast->vrtPtrStride; x -= ofst; y -= ofst; z -= ofst;
      if (texture)
      {
        ofst = rast->texPtrStride; w -= ofst; u -= ofst; v -= ofst;
      }
      if (shade)
      {
        ofst = rast->clrPtrStride; r -= ofst; g -= ofst; b -= ofst; a -= ofst;
      }
      cnt2++;
    }
    register W3D_Vertex* v = tempVert;
    lines.vertexcount = ++cnt2;
    rsint32 i = ++cnt2;
    while(--i)
    {
      ofst = rast->vrtPtrStride;
      v->x = *((float32*)x); x += ofst;
      v->y = *((float32*)y); y += ofst;
      v->z = *((float32*)z); z += ofst;
      if (texture)
      {
        ofst = rast->texPtrStride;
        v->w = *((float32*)w); w += ofst;
        v->u = *((float32*)u); u += ofst;
        v->v = *((float32*)v); v += ofst;
      }
      if (shade)
      {
        ofst = rast->clrPtrStride;
        v->color.r = f*(*r); r += ofst;
        v->color.g = f*(*g); g += ofst;
        v->color.b = f*(*b); b += ofst;
        v->color.a = f*(*a); a += ofst;
      }
      v++;
    }
    if (W3D_DrawLineStrip(rast->context, &lines)!=W3D_SUCCESS)
      return false;
  }
  return true;
}

////////////////////////////////////////////////////////////////////////////////

bool Rasterizer::drawLineStripXYZ_F32_CLR_F32(Rasterizer* rast, size_t ofs, size_t cnt)
{
  W3D_Vertex tempVert[OLD_STRIP_SEGS+2];
  W3D_Lines lines = {0, tempVert, 0};

  // Create temporary pointers
  rsint32 ofst = ofs*rast->vrtPtrStride;
  uint8 *x = rast->vrtPtrX+ofst;
  uint8 *y = rast->vrtPtrY+ofst;
  uint8 *z = rast->vrtPtrZ+ofst;

  uint8 *a, *r, *g, *b, *u, *v, *w;
  bool shade, texture;

  if (shade = (W3D_GetState(rast->context, W3D_GOURAUD) == W3D_ENABLED))
  {
    ofst = ofs*rast->clrPtrStride;
    a = rast->clrPtrA+ofst;
    r = rast->clrPtrR+ofst;
    g = rast->clrPtrG+ofst;
    b = rast->clrPtrB+ofst;
  }

  if (texture = (W3D_GetState(rast->context, W3D_TEXMAPPING) == W3D_ENABLED))
  {
    lines.tex  = rast->texture->tex;
    ofst = ofs*rast->texPtrStride;
    w = rast->texPtrW+ofst;
    u = rast->texPtrUS+ofst;
    v = rast->texPtrVT+ofst;
  }
  lines.vertexcount = OLD_STRIP_SEGS+1;
  rsint32 cnt2 = --cnt;
  while (cnt2>OLD_STRIP_SEGS)
  {
    register W3D_Vertex* v = tempVert;
    rsint32 i = OLD_STRIP_SEGS+2;
    while(--i)
    {
      ofst = rast->vrtPtrStride;
      v->x = *((float32*)x); x += ofst;
      v->y = *((float32*)y); y += ofst;
      v->z = *((float32*)z); z += ofst;
      if (texture)
      {
        ofst = rast->texPtrStride;
        v->w = *((float32*)w); w += ofst;
        v->u = *((float32*)u); u += ofst;
        v->v = *((float32*)v); v += ofst;
      }
      if (shade)
      {
        ofst = rast->clrPtrStride;
        v->color.r = *((float32*)r); r += ofst;
        v->color.g = *((float32*)g); g += ofst;
        v->color.b = *((float32*)b); b += ofst;
        v->color.a = *((float32*)a); a += ofst;
      }
      v++;
    }
    if (W3D_DrawLineStrip(rast->context, &lines)!=W3D_SUCCESS)
      return false;
    cnt2-=OLD_STRIP_SEGS;
    ofst = rast->vrtPtrStride; x -= ofst; y -= ofst; z -= ofst;
    if (texture)
    {
      ofst = rast->texPtrStride; w -= ofst; u -= ofst; v -= ofst;
    }
    if (shade)
    {
      ofst = rast->clrPtrStride; r -= ofst; g -= ofst; b -= ofst; a -= ofst;
    }
  }
  if (cnt2>0)
  {
    if (cnt2<cnt) // end of existing series of line segments
    {
      ofst = rast->vrtPtrStride; x -= ofst; y -= ofst; z -= ofst;
      if (texture)
      {
        ofst = rast->texPtrStride; w -= ofst; u -= ofst; v -= ofst;
      }
      if (shade)
      {
        ofst = rast->clrPtrStride; r -= ofst; g -= ofst; b -= ofst; a -= ofst;
      }
      cnt2++;
    }
    register W3D_Vertex* v = tempVert;
    lines.vertexcount = ++cnt2;
    rsint32 i = ++cnt2;
    while(--i)
    {
      ofst = rast->vrtPtrStride;
      v->x = *((float32*)x); x += ofst;
      v->y = *((float32*)y); y += ofst;
      v->z = *((float32*)z); z += ofst;
      if (texture)
      {
        ofst = rast->texPtrStride;
        v->w = *((float32*)w); w += ofst;
        v->u = *((float32*)u); u += ofst;
        v->v = *((float32*)v); v += ofst;
      }
      if (shade)
      {
        ofst = rast->clrPtrStride;
        v->color.r = *((float32*)r); r += ofst;
        v->color.g = *((float32*)g); g += ofst;
        v->color.b = *((float32*)b); b += ofst;
        v->color.a = *((float32*)a); a += ofst;
      }
      v++;
    }
    if (W3D_DrawLineStrip(rast->context, &lines)!=W3D_SUCCESS)
      return false;
  }
  return true;
}


////////////////////////////////////////////////////////////////////////////////

bool Rasterizer::drawLineStripXYZ_F64_CLR_U8(Rasterizer* rast, size_t ofs, size_t cnt)
{
  W3D_Vertex tempVert[OLD_STRIP_SEGS+2];
  W3D_Lines lines = {0, tempVert, 0};

  // Create temporary pointers
  rsint32 ofst = ofs*rast->vrtPtrStride;
  uint8 *x = rast->vrtPtrX+ofst;
  uint8 *y = rast->vrtPtrY+ofst;
  uint8 *z = rast->vrtPtrZ+ofst;

  uint8 *a, *r, *g, *b, *u, *v, *w;
  bool shade, texture;

  if (shade = (W3D_GetState(rast->context, W3D_GOURAUD) == W3D_ENABLED))
  {
    ofst = ofs*rast->clrPtrStride;
    a = rast->clrPtrA+ofst;
    r = rast->clrPtrR+ofst;
    g = rast->clrPtrG+ofst;
    b = rast->clrPtrB+ofst;
  }

  if (texture = (W3D_GetState(rast->context, W3D_TEXMAPPING) == W3D_ENABLED))
  {
    lines.tex  = rast->texture->tex;
    ofst = ofs*rast->texPtrStride;
    w = rast->texPtrW+ofst;
    u = rast->texPtrUS+ofst;
    v = rast->texPtrVT+ofst;
  }
  lines.vertexcount = OLD_STRIP_SEGS+1;
  rsint32 cnt2 = --cnt;
  rfloat32 f = 1.0f/256.0f;
  while (cnt2>OLD_STRIP_SEGS)
  {
    register W3D_Vertex* v = tempVert;
    rsint32 i = OLD_STRIP_SEGS+2;
    while(--i)
    {
      ofst = rast->vrtPtrStride;
      v->x = *((float64*)x); x += ofst;
      v->y = *((float64*)y); y += ofst;
      v->z = *((float64*)z); z += ofst;
      if (texture)
      {
        ofst = rast->texPtrStride;
        v->w = *((float32*)w); w += ofst;
        v->u = *((float32*)u); u += ofst;
        v->v = *((float32*)v); v += ofst;
      }
      if (shade)
      {
        ofst = rast->clrPtrStride;
        v->color.r = f*(*r); r += ofst;
        v->color.g = f*(*g); g += ofst;
        v->color.b = f*(*b); b += ofst;
        v->color.a = f*(*a); a += ofst;
      }
      v++;
    }
    if (W3D_DrawLineStrip(rast->context, &lines)!=W3D_SUCCESS)
      return false;
    cnt2-=OLD_STRIP_SEGS;
    ofst = rast->vrtPtrStride; x -= ofst; y -= ofst; z -= ofst;
    if (texture)
    {
      ofst = rast->texPtrStride; w -= ofst; u -= ofst; v -= ofst;
    }
    if (shade)
    {
      ofst = rast->clrPtrStride; r -= ofst; g -= ofst; b -= ofst; a -= ofst;
    }
  }
  if (cnt2>0)
  {
    if (cnt2<cnt) // end of existing series of line segments
    {
      ofst = rast->vrtPtrStride; x -= ofst; y -= ofst; z -= ofst;
      if (texture)
      {
        ofst = rast->texPtrStride; w -= ofst; u -= ofst; v -= ofst;
      }
      if (shade)
      {
        ofst = rast->clrPtrStride; r -= ofst; g -= ofst; b -= ofst; a -= ofst;
      }
      cnt2++;
    }
    register W3D_Vertex* v = tempVert;
    lines.vertexcount = ++cnt2;
    rsint32 i = ++cnt2;
    while(--i)
    {
      ofst = rast->vrtPtrStride;
      v->x = *((float64*)x); x += ofst;
      v->y = *((float64*)y); y += ofst;
      v->z = *((float64*)z); z += ofst;
      if (texture)
      {
        ofst = rast->texPtrStride;
        v->w = *((float32*)w); w += ofst;
        v->u = *((float32*)u); u += ofst;
        v->v = *((float32*)v); v += ofst;
      }
      if (shade)
      {
        ofst = rast->clrPtrStride;
        v->color.r = f*(*r); r += ofst;
        v->color.g = f*(*g); g += ofst;
        v->color.b = f*(*b); b += ofst;
        v->color.a = f*(*a); a += ofst;
      }
      v++;
    }
    if (W3D_DrawLineStrip(rast->context, &lines)!=W3D_SUCCESS)
      return false;
  }
  return true;
}

////////////////////////////////////////////////////////////////////////////////

bool Rasterizer::drawLineStripXYZ_F64_CLR_F32(Rasterizer* rast, size_t ofs, size_t cnt)
{
  W3D_Vertex tempVert[OLD_STRIP_SEGS+2];
  W3D_Lines lines = {0, tempVert, 0};

  // Create temporary pointers
  rsint32 ofst = ofs*rast->vrtPtrStride;
  uint8 *x = rast->vrtPtrX+ofst;
  uint8 *y = rast->vrtPtrY+ofst;
  uint8 *z = rast->vrtPtrZ+ofst;

  uint8 *a, *r, *g, *b, *u, *v, *w;
  bool shade, texture;

  if (shade = (W3D_GetState(rast->context, W3D_GOURAUD) == W3D_ENABLED))
  {
    ofst = ofs*rast->clrPtrStride;
    a = rast->clrPtrA+ofst;
    r = rast->clrPtrR+ofst;
    g = rast->clrPtrG+ofst;
    b = rast->clrPtrB+ofst;
  }

  if (texture = (W3D_GetState(rast->context, W3D_TEXMAPPING) == W3D_ENABLED))
  {
    lines.tex  = rast->texture->tex;
    ofst = ofs*rast->texPtrStride;
    w = rast->texPtrW+ofst;
    u = rast->texPtrUS+ofst;
    v = rast->texPtrVT+ofst;
  }
  lines.vertexcount = OLD_STRIP_SEGS+1;
  rsint32 cnt2 = --cnt;
  while (cnt2>OLD_STRIP_SEGS)
  {
    register W3D_Vertex* v = tempVert;
    rsint32 i = OLD_STRIP_SEGS+2;
    while(--i)
    {
      ofst = rast->vrtPtrStride;
      v->x = *((float64*)x); x += ofst;
      v->y = *((float64*)y); y += ofst;
      v->z = *((float64*)z); z += ofst;
      if (texture)
      {
        ofst = rast->texPtrStride;
        v->w = *((float32*)w); w += ofst;
        v->u = *((float32*)u); u += ofst;
        v->v = *((float32*)v); v += ofst;
      }
      if (shade)
      {
        ofst = rast->clrPtrStride;
        v->color.r = *((float32*)r); r += ofst;
        v->color.g = *((float32*)g); g += ofst;
        v->color.b = *((float32*)b); b += ofst;
        v->color.a = *((float32*)a); a += ofst;
      }
      v++;
    }
    if (W3D_DrawLineStrip(rast->context, &lines)!=W3D_SUCCESS)
      return false;
    cnt2-=OLD_STRIP_SEGS;
    ofst = rast->vrtPtrStride; x -= ofst; y -= ofst; z -= ofst;
    if (texture)
    {
      ofst = rast->texPtrStride; w -= ofst; u -= ofst; v -= ofst;
    }
    if (shade)
    {
      ofst = rast->clrPtrStride; r -= ofst; g -= ofst; b -= ofst; a -= ofst;
    }
  }
  if (cnt2>0)
  {
    if (cnt2<cnt) // end of existing series of line segments
    {
      ofst = rast->vrtPtrStride; x -= ofst; y -= ofst; z -= ofst;
      if (texture)
      {
        ofst = rast->texPtrStride; w -= ofst; u -= ofst; v -= ofst;
      }
      if (shade)
      {
        ofst = rast->clrPtrStride; r -= ofst; g -= ofst; b -= ofst; a -= ofst;
      }
      cnt2++;
    }
    register W3D_Vertex* v = tempVert;
    lines.vertexcount = ++cnt2;
    rsint32 i = ++cnt2;
    while(--i)
    {
      ofst = rast->vrtPtrStride;
      v->x = *((float64*)x); x += ofst;
      v->y = *((float64*)y); y += ofst;
      v->z = *((float64*)z); z += ofst;
      if (texture)
      {
        ofst = rast->texPtrStride;
        v->w = *((float32*)w); w += ofst;
        v->u = *((float32*)u); u += ofst;
        v->v = *((float32*)v); v += ofst;
      }
      if (shade)
      {
        ofst = rast->clrPtrStride;
        v->color.r = *((float32*)r); r += ofst;
        v->color.g = *((float32*)g); g += ofst;
        v->color.b = *((float32*)b); b += ofst;
        v->color.a = *((float32*)a); a += ofst;
      }
      v++;
    }
    if (W3D_DrawLineStrip(rast->context, &lines)!=W3D_SUCCESS)
      return false;
  }
  return true;
}

////////////////////////////////////////////////////////////////////////////////

Rasterizer::DrawFunc Rasterizer::drawLineStripXYZ_F32[G3D::NUM_COLOURTYPE] =
{
  drawLineStripXYZ_F32_CLR_U8,
  drawLineStripXYZ_F32_CLR_U8,
  drawLineStripXYZ_F32_CLR_F32,
  drawLineStripXYZ_F32_CLR_F32
};

////////////////////////////////////////////////////////////////////////////////

Rasterizer::DrawFunc Rasterizer::drawLineStripXYZ_F64[G3D::NUM_COLOURTYPE] =
{
  drawLineStripXYZ_F64_CLR_U8,
  drawLineStripXYZ_F64_CLR_U8,
  drawLineStripXYZ_F64_CLR_F32,
  drawLineStripXYZ_F64_CLR_F32
};

////////////////////////////////////////////////////////////////////////////////


#endif