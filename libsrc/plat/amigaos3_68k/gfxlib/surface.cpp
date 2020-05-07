//****************************************************************************//
//**                                                                        **//
//** File:         libsrc/plat/amigaos3_68k/gfxlib/surface.cpp              **//
//** Description:  Common graphics definitions                              **//
//** Comment(s):                                                            **//
//** Library:      gfxlib                                                   **//
//** Created:      2003-02-22                                               **//
//** Updated:      2003-02-22                                               **//
//** Author(s):    Karl Churchill                                           **//
//** Note(s):                                                               **//
//** Copyright:    (C)1996-2003, eXtropia Studios                           **//
//**               Serkan YAZICI, Karl Churchill                            **//
//**               All Rights Reserved.                                     **//
//**                                                                        **//
//****************************************************************************//

#include <gfxlib/gfx.hpp>

#include <new.h>

namespace X_SYSNAME {
  extern "C" {
    #include <cybergraphx/cybergraphics.h>
    //#include <graphics/displayinfo.h>
    //#include <stddef.h>
  }
};

using namespace X_SYSNAME;

////////////////////////////////////////////////////////////////////////////////
//
//  Surface
//
////////////////////////////////////////////////////////////////////////////////

sint32 Surface::blitCopy(Surface* dst, S_CRD1, Surface* src, S_CRD2, S_WH)
{

  // blitCopy(dst, x1, y1, src, x2, y2, w, h)

  // Copies the rectangular section of the source surface defined by x2,y2,w,h
  // to the destination surface starting at top left x1,y1 using hardware.
  // The copy rectangle must fit within the source bitmap but may be larger
  // than the destination. Negative values for x1 and y1 are also possible.
  // The area is cropped to fit automatically.
  // The source and destination bitmaps must be of the same format.

  if ((!dst) || (!src) || (!dst->bitMap) || (!dst->bitMap)) {
    return ERR_PTR_ZERO;
  }
  // Source and destination must be of the same pixel format
  if (src->pixFormat != dst->pixFormat) {
    return ERR_RSC_TYPE;
  }
  // Source coords must not be negative, width and height must be positive and
  // non-zero
  if (x2<0 || y2<0 || w<1 || h<1) {
    return ERR_VALUE_MIN;
  }
  // Source area must fit within the source bitmap
  if (x2+w > src->width || y2+h > src->height) {
    return ERR_VALUE_MAX;
  }
  // Since destination coords can be negative, crop the blit to the destination.
  // Return OK if blit outside destination bitmap entirely

  // Is destination fully outside bitmap area?
  if (x1>=dst->width || y1>=dst->height || (x1+w)<1 || (y1+h)<1) {
    return OK;
  }
  // clip left, right, top then bottom until the transfer area is within the
  // destination surface area
  if (x1<0)                { w += x1; x2 -= x1; x1 = 0; }
  if (x1+w > dst->width)  { w = dst->width - x1; }
  if (y1<0)                { h += y1; y2 -= y1; y1 = 0; }
  if (y1+h > dst->height)  { h = dst->height - y1; }

  // Perform an basic blit now that area is cropped
  BltBitMap(src->bitMap, x2, y2, dst->bitMap, x1, y1, w, h, 0xC0, 0xFF, 0);
  return OK;
}

////////////////////////////////////////////////////////////////////////////////

sint32 Surface::putImageBuffer(ImageBuffer* img, S_CRD1, S_CRD2, S_WH)
{
  // putImageBuffer(img, x1, y1, x2, y2, w, h)

  // Copies the rectangular section of the source image defined by x2,y2,w,h
  // to the destination surface starting at top left x1,y1
  // The copy rectangle must fit within the source image but may be larger
  // than the destination. Negative values for x1 and y1 are also possible.
  // The area is cropped to fit automatically.

  if (!bitMap || !img || (!img->getData())) {
    return ERR_PTR_ZERO;
  }
  // Source coords must not be negative, width and height must be positive and
  // non-zero
  if (x2<0 || y2<0 || w<1 || h<1) {
    return ERR_VALUE_MIN;
  }
  // Source area must fit within the source image
  if (x2+w > img->getW() || y2+h > img->getH()) {
    return ERR_VALUE_MAX;
  }
  // Since destination coords can be negative, crop the blit to the destination.
  // Return OK if blit outside destination bitmap entirely

  // Is destination fully outside bitmap area?
  if (x1>=width || y1>=height || (x1+w)<1 || (y1+h)<1) {
    return OK;
  }
  // clip left, right, top then bottom until transfer area is within
  // the destination surface area
  if (x1<0)            { w  += x1; x2 -= x1; x1 = 0; }
  if (x1+w > width)    { w = width - x1; }
  if (y1<0)            { h += y1; y2 -= y1; y1 = 0; }
  if (y1+h > height)  { h = height - y1; }


  P_F      srcFormat = img->getFormat();
  sint32  srcWidth  = img->getW();
  void*    srcData    = img->getData();

  // _Nat2D coversion routines use absolute addresses for source / destination.
  // Hence we need to calculate the start address offsets for the destination and
  // source pixel data. In each case this is (y*abswidth + x)*pixelsize
  // The absolute width is inclusive of any modulus, hwWidth for Surface objects.
  // Note ImageBuffer objects do not have a modulus so the normal width suffices.

  // destination offset
  size_t dofs = (x1+(y1*hwWidth))*(PixelDescriptor::get(pixFormat)->getSize());

  // source offset
  size_t sofs = (x2+(y2*srcWidth))*(PixelDescriptor::get(srcFormat)->getSize());

  // The Surface needs to be locked for direct access. If it isn't already
  // locked, lock it temporarily
  if (lockAddr) {
    void* dst  = ((uint8*)gfxAddr)+dofs;
    void* src = ((uint8*)srcData)+sofs;
    convertPixels(dst, src, pixFormat, srcFormat, w, h, hwWidth, srcWidth, img->getPalette());
  }
  else {
    void* dst;
    if (dst = lockData()) {
      ((uint8*)dst) += dofs; void* src = ((uint8*)srcData)+sofs;
      convertPixels(dst, src, pixFormat, srcFormat, w, h, hwWidth, srcWidth, img->getPalette());
      unlockData();
    }
    else {
      return ERR_RSC_UNAVAILABLE;
    }
  }
  return OK;
}

////////////////////////////////////////////////////////////////////////////////

void Surface::init()
{
  width        = 0;  height      = 0;
  winUser      = 0;
  bitMap      = 0;  gfxAddr      = 0;
  lockAddr    = 0;  properties  = 0;
  hwWidth      = 0;  hwHeight    = 0;
  modulus      = 0;  depth        = 0;
  pixFormat    = Pixel::OTHERFMT;
}

////////////////////////////////////////////////////////////////////////////////

void Surface::queryBitMap()
{
  hwWidth    = GetCyberMapAttr(bitMap, CYBRMATTR_WIDTH);
  hwHeight  = GetCyberMapAttr(bitMap, CYBRMATTR_HEIGHT);
  depth      = GetCyberMapAttr(bitMap, CYBRMATTR_DEPTH);
  modulus    = hwWidth - width;

  if (GetCyberMapAttr(bitMap, CYBRMATTR_ISLINEARMEM)) {
    properties |= LINEARMEM;
  }
  else {
    properties &= ~LINEARMEM;
    printf("\n[Surface not linear]\n");
  }

  pixFormat  = getHardwareFormat(GetCyberMapAttr(bitMap, CYBRMATTR_PIXFMT));

/*
  uint32 f = GetCyberMapAttr(bitMap, CYBRMATTR_PIXFMT);
  static char* cgxNames[] = {
    "PIXFMT_LUT8",
    "PIXFMT_RGB15",
    "PIXFMT_BGR15",
    "PIXFMT_RGB15PC",
    "PIXFMT_BGR15PC",
    "PIXFMT_RGB16",
    "PIXFMT_BGR16",
    "PIXFMT_RGB16PC",
    "PIXFMT_BGR16PC",
    "PIXFMT_RGB24",
    "PIXFMT_BGR24",
    "PIXFMT_ARGB32",
    "PIXFMT_BGRA32",
    "PIXFMT_RGBA32"
  };

  printf("\n[Info : BitMap CGX format %s, W:%hd H:%hd D:%d HW:%hd HH:%hd M:%hd]\n",
    cgxNames[f],
    width,
    height,
    depth,
    hwWidth,
    hwHeight,
    modulus
  );
*/
}

////////////////////////////////////////////////////////////////////////////////

void* Surface::lockData()
{
  if (bitMap) {
    if (lockAddr) {
      return gfxAddr;
    }
    TagItem t[2] = {
      {LBMI_BASEADDRESS, (uint32)(&gfxAddr)},
      {TAG_DONE, 0}
    };
    lockAddr = LockBitMapTagList(bitMap, t);
    return gfxAddr; // may be 0 if couldnt lock
  }
  else {
    return 0;
  }
}

////////////////////////////////////////////////////////////////////////////////

void Surface::unlockData()
{
  if (bitMap && lockAddr) {
    UnLockBitMap(lockAddr);
    lockAddr = 0;
  }
}

////////////////////////////////////////////////////////////////////////////////

Surface* Surface::create(S_WH, Surface* clone)
{
  // This is the surface factory. Users can only create a surface based on
  // one already existing. There is no method available to create an arbitarty
  // surface since the allocation of resources at the OS level may not allow
  // this.
  // To create a surface, a user must use this factory and a handle to an
  // existing surface, such as a displays draw surface.
  // Only the dimensions of the new surface are under user control, the pixel
  // format is decided by the OS.
  if (!clone || !clone->bitMap) {
    return 0;
  }
  Surface* newSurf = new(nothrow) Surface;
  if (newSurf && newSurf->create(w, h, clone->bitMap)==OK) {
    return newSurf;
  }
  delete newSurf;
  return 0;
}

////////////////////////////////////////////////////////////////////////////////

sint32 Surface::create(sint16 w, sint16 h, BitMap* clone)
{
  if (bitMap) {
    return ERR_RSC_LOCKED;
  }
  if (w <=0 || h <= 0) {
    return ERR_VALUE;
  }
  if (!clone) {
    return ERR_PTR_ZERO;
  }
  if (!GetCyberMapAttr(clone, CYBRMATTR_ISCYBERGFX)) {
    return ERR_RSC_INVALID;
  }
  uint32 bmf = BMF_MINPLANES | BMF_DISPLAYABLE;

  if (GetCyberMapAttr(clone, CYBRMATTR_DEPTH)<=8) {
    bitMap = AllocBitMap(w, h, 8, bmf, clone);
  }
  else {
    #define BIZZARE_PLANES_FIX 9
    bitMap = AllocBitMap(w, h, BIZZARE_PLANES_FIX, bmf, clone);
    #undef BIZZARE_PLANES_FIX
  }

  if (!bitMap) {
    X_ERROR("Surface::create(S_WH, BitMap*) : AllocBitmap() failed");
    return ERR_NO_FREE_STORE;
  }
  else if (!GetCyberMapAttr(bitMap, CYBRMATTR_ISCYBERGFX)) {
    X_ERROR("Surface::create(S_WH, BitMap*) : not a CGX bitmap");
    FreeBitMap(bitMap);
    init();
    return ERR_RSC_INVALID;
  }
  width    = w;
  height  = h;
  queryBitMap();
  properties |= OWNBITMAP;
  return OK;
}

////////////////////////////////////////////////////////////////////////////////

void Surface::destroy()
{
  if (bitMap) {
    if (lockAddr) {
      UnLockBitMap(lockAddr);
    }
    if (properties & OWNBITMAP) {
      FreeBitMap(bitMap);
    }
  }
  init();
}

////////////////////////////////////////////////////////////////////////////////

void Surface::clear(Colour c)
{
  if (winUser) {
    RastPort rPort;
    InitRastPort(&rPort);
    rPort.BitMap = bitMap;
    ViewPort*  view = &(winUser->WScreen->ViewPort);
    uint32 pen = ObtainBestPen(
      view->ColorMap, c.red()<<24, c.green()<<24, c.blue()<<24,
      OBP_Precision, PRECISION_EXACT
    );
    SetAPen(&rPort, pen);
    RectFill(&rPort, 0, 0, width-1, height-1);
    ReleasePen(view->ColorMap, pen);
  }
}

////////////////////////////////////////////////////////////////////////////////

bool SurfaceProvider::assignSurface(Surface* srf, BitMap* bmp)
{
  if ((!srf) || (!bmp) || (srf->bitMap) ||
      (!GetCyberMapAttr(bmp, CYBRMATTR_ISCYBERGFX))) {
    return false;
  }
  // Get inital data directly from bitmap
  srf->bitMap = bmp;
  srf->width        = GetCyberMapAttr(bmp, CYBRMATTR_WIDTH);
  srf->height        = GetCyberMapAttr(bmp, CYBRMATTR_HEIGHT);
  // Set up Surface by internal queryBitMap() call
  srf->queryBitMap();
  srf->properties    &= ~Surface::OWNBITMAP;
  srf->properties    |= Surface::EXTBITMAP;
  return true;
}

////////////////////////////////////////////////////////////////////////////////

Surface* SurfaceProvider::assignNewSurface(BitMap* bmp)
{
  if (!bmp) {
    X_ERROR("SurfaceProvider::assignNewSurface() - null BitMap\n");
    return 0;
  }

  if (!GetCyberMapAttr(bmp, CYBRMATTR_ISCYBERGFX)) {
    X_ERROR("SurfaceProvider::assignNewSurface() - not an RTG BitMap\n");
    return 0;
  }

  Surface* t = new(nothrow) Surface;
  if (t) {
    assignSurface(t, bmp);
  }
  return t;
}

////////////////////////////////////////////////////////////////////////////////

Surface* SurfaceProvider::createSurface(BitMap* bmp, S_WH)
{
  if (!bmp) {
    X_ERROR("SurfaceProvider::createSurface() - null BitMap\n");
    return 0;
  }
  if (!GetCyberMapAttr(bmp, CYBRMATTR_ISCYBERGFX)) {
    X_ERROR("SurfaceProvider::createSurface() - not an RTG BitMap\n");
    return 0;
  }
  Surface* t = new(nothrow) Surface;
  if (t) {
    if (t->create(w, h, bmp)==OK) {
      return t;
    }
    else {
      delete t;
    }
  }
  return 0;
}
