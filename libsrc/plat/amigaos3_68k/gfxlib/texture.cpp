//****************************************************************************//
//**                                                                        **//
//** File:         libsrc/plat/amigaos3_68k/gfxlib/texture.cpp              **//
//** Description:  3D texture definitions                                   **//
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
//  Texture
//
//  Encapsulates a texture object. Textures may only be used with whatever
//  Rasterizer that they have been asssociated with. However, textures can
//  be dissasociated with a Rasterizer and can then be associated with another.
//
////////////////////////////////////////////////////////////////////////////////

Texture::Texture() : owner(0), tex(0), properties(0), data(0), palette(0),
                     format(G3D::TXL_LUT8), mag(G3D::LINEAR), min(G3D::NEAREST),
                     env(G3D::REPLACE)
{

}

////////////////////////////////////////////////////////////////////////////////

Texture::~Texture()
{
  destroy();
}

////////////////////////////////////////////////////////////////////////////////

sint32 Texture::setPalette(Palette* p, bool copy)
{
  if (copy)
  {  // If we have a palette allocated, copy the data to it
    // else create it and then copy from the pointer.
    // If the pointer is null, create the palette anyway
    // and zero it.

    if ( (!palette) || (!(properties & OWN_PALETTE)) ) {
      properties &= ~OWN_PALETTE;
      if (!(palette = (Palette*)Mem::alloc(sizeof(Palette), p ? false : true)))
        return ERR_NO_FREE_STORE;
      properties |= OWN_PALETTE;
    }
    if (p)
      Mem::copy(palette, p, sizeof(Palette));
  }
  else // if (copy)
  {  // if we have a palette allocated, free it up
    if (properties & OWN_PALETTE)
    {
      properties &= ~OWN_PALETTE;
      if (palette)
        Mem::free(palette);
    }
    // assign the palette to the passed pointer
    palette = p;
  }
  return OK;
}

////////////////////////////////////////////////////////////////////////////////

sint32 Texture::create(S_WH, G3D::Texel t, Palette* p, bool copyPal)
{
  if (data || tex)
    return ERR_RSC_LOCKED;
  if (w<G3D::MIN_TEX_WIDTH || h<G3D::MIN_TEX_HEIGHT ||
      w>G3D::MAX_TEX_WIDTH || h>G3D::MAX_TEX_HEIGHT)
    return ERR_VALUE_ILLEGAL;

  size_t bytesPerTexel=0;
  switch (t) {
    // 1 byte per texel
    case G3D::TXL_LUT8:
      if (setPalette(p, copyPal)!=OK)
        return ERR_RSC_INVALID;
    case G3D::TXL_A8:
    case G3D::TXL_G8:
    case G3D::TXL_I8:
      bytesPerTexel = 1;
      break;

    // 2 bytes per texel
    case G3D::TXL_A1RGB15:
    case G3D::TXL_RGB16:
    case G3D::TXL_A4RGB12:
    case G3D::TXL_GA88:
      bytesPerTexel = 2;
      break;

    // 3 bytes per texel
    case G3D::TXL_RGB24:
      bytesPerTexel = 3;
      break;

    // 4 bytes per texel
    case G3D::TXL_ARGB32:
    case G3D::TXL_RGBA32:
      bytesPerTexel = 4;
      break;
    default:
      return ERR_VALUE_ILLEGAL;
  }
  if (!(data = Mem::alloc(w*h*bytesPerTexel, false, Mem::ALIGN_CACHE)))
    return ERR_NO_FREE_STORE;
  properties |= OWN_DATA;
  format  = t;
  width    = w;
  height  = h;
  return OK;
}

////////////////////////////////////////////////////////////////////////////////

void Texture::destroy()
{
  disassociate();
  if (data && (properties & OWN_DATA))
    Mem::free(data);
  if (palette && (properties & OWN_PALETTE))
    Mem::free(palette);
  properties  = 0;
  data        = 0;
  palette      = 0;
  format      = G3D::TXL_LUT8;
}

////////////////////////////////////////////////////////////////////////////////

Texture* Texture::convertImageBuffer(ImageBuffer* iBuf, IBConv action)
{
  // This method converts an ImageBuffer to a texture, consuming its data in
  // the process. What this means is that after a successful call, the ImageBuffer
  // will be devoid of information. The method can optionally delete the ImageBuffer
  // but this is not automatic since the ImageBuffer might not have been allocated
  // using operator new.

  if (!iBuf)
    return 0;

  if (!iBuf->getData()) {
    if (action==CONV_IB_DEL_ALWAYS)
      delete iBuf;
    return 0;
  }
  else {
    // width and height must be powers of 2
    int i = iBuf->getW();
    int bits = 0;
    for (int bit=0; bit<16; bit++) {
      if (i & (1<<bit))
        bits++;
      if (bits>1) {
        if (action==CONV_IB_DEL_ALWAYS)
          delete iBuf;
        return 0;
      }
    }
    i = iBuf->getH();
    bits = 0;
    for (int bit=0; bit<16; bit++) {
      if (i & (1<<bit))
        bits++;
      if (bits>1) {
        if (action==CONV_IB_DEL_ALWAYS)
          delete iBuf;
        return 0;
      }
    }
  }

  // amiga 680x0 architecture is big endian
  int bytesPerTexel;
  G3D::Texel  fmt;
  bool swapBytes = false;
  switch (iBuf->getFormat()) {
    case Pixel::INDEX8: fmt = G3D::TXL_LUT8; bytesPerTexel = 1; break;

    case Pixel::RGB15L: swapBytes = true;
    case Pixel::RGB15B: fmt = G3D::TXL_A1RGB15; bytesPerTexel = 2; break;

    //case Pixel::BGR15B: // to do - call the _Nat2D pixel routines?
    //case Pixel::BGR15L: // to do

    case Pixel::RGB16L: swapBytes = true;
    case Pixel::RGB16B: fmt = G3D::TXL_RGB16; bytesPerTexel = 2; break;

    //case Pixel::BGR16B: // to do - call the _Nat2D pixel routines?
    //case Pixel::BGR16L: // to do

    case Pixel::RGB24P: fmt = G3D::TXL_RGB24; bytesPerTexel = 3; break;

    //case Pixel::BGR24P: // to do - call the _Nat2D pixel routines

    // 32-bit texel definitions are absolute. Remap 32-bit Pixel data to the
    // most sensible absolure texel format.
    case Pixel::ARGB32L: swapBytes = true;
    case Pixel::ARGB32B: fmt = G3D::TXL_ARGB32; bytesPerTexel = 4; break;

    case Pixel::ABGR32B: swapBytes = true;
    case Pixel::ABGR32L: fmt = G3D::TXL_RGBA32; bytesPerTexel = 4; break;

    default:
      if (action==CONV_IB_DEL_ALWAYS)
        delete iBuf;
      return 0;
      break;
  }
  // now we know the desired target format. We also know if we need to
  // do a byteswap for 15/16/32 bit ImageBuffer data.

  Texture* tex = new Texture();
  if (!tex) {
    if (action==CONV_IB_DEL_ALWAYS)
      delete iBuf;
    return 0;
  }

  void *src;
  void *dst;

  if (action==COPY_IB_ONLY) {
    if (tex->create(iBuf->getW(), iBuf->getH(), fmt, iBuf->getPalette(), true)!=OK) {
      delete tex;
      return 0;
    }
    dst = tex->getData();
    src = iBuf->getData();
  }
  else {
    // Rob the ImageBuffer of it's data. We take care to respect the ImageBuffer's data
    // ownership when it comes to the pixel data and palette. If the ImageBuffer did not
    // own these data, neither will the texture. This is to ensure the real owner is left
    // to manage deleting the data.
    // If the ImageBuffer did own the data, the Texture will assume ownership.

    tex->width      = iBuf->getW();
    tex->height      = iBuf->getH();
    tex->format      = fmt;
    tex->properties  = (hasOwnData(iBuf) ? OWN_DATA : 0) | (hasOwnPalette(iBuf) ? OWN_PALETTE : 0);
    tex->data        = iBuf->getData();
    tex->palette    = iBuf->getPalette();
    src = dst = tex->data;

    // change the ImageBuffer properties so that it no longer has ownership of the data
    // or palette before we null it (which would cause it to delete the data)

    setIBProps(iBuf, false, false, hasOwnDescriptor(iBuf));
    setIBData(iBuf, 0, false);
    setIBPalette(iBuf, 0, false);
  }

  // perform any data changes needed

  if (swapBytes) {
    switch (fmt) {
      case G3D::TXL_A1RGB15:
      case G3D::TXL_RGB16:
      case G3D::TXL_A4RGB12:
        Mem::swap16(dst, src, (tex->width*tex->height)/sizeof(uint16));
        break;

      case G3D::TXL_ARGB32:
      case G3D::TXL_RGBA32:
        Mem::swap32(dst, src, (tex->width*tex->height)/sizeof(uint32));
        break;

      default:
        break;
    }
  }

  // tidy up and get the hell outta dodge :-D

  switch(action) {
    case CONV_IB_DEL_NEVER:
      iBuf->destroy();
      break;
    case CONV_IB_DEL_SUCCESS:
    case CONV_IB_DEL_ALWAYS:
      delete iBuf;
      break;
    default:
      break;
  }
  return tex;
}

////////////////////////////////////////////////////////////////////////////////

sint32 Texture::associate(Rasterizer* r)
{
  if (tex)
    return ERR_RSC_LOCKED;
  if (!data || !r || !(owner = getRasterizerContext(r)))
    return ERR_RSC_INVALID;

  TagItem allocTexTags[] = {
    W3D_ATO_IMAGE,  (uint32)data,
    W3D_ATO_FORMAT,  (uint32)getNativeTexel(format),
    W3D_ATO_WIDTH,  (uint32)width,
    W3D_ATO_HEIGHT,  (uint32)height,
    TAG_DONE,        0UL,
    TAG_DONE,        0UL
  };

  if (format == G3D::TXL_LUT8)
  {
    if (!palette)
      return ERR_RSC_INVALID;
    allocTexTags[4].ti_Tag  = (uint32)W3D_ATO_PALETTE;
    allocTexTags[4].ti_Data  = (uint32)(palette->getTable());
  }
  uint32 error = 0;
  if (!(tex = W3D_AllocTexObj(owner, &error, allocTexTags)))
  {
    owner = 0;
    return ERR_RSC;
  }
  W3D_SetTexEnv(owner, tex, getNativeTexEnv(env), 0);
  W3D_SetFilter(owner, tex, getNativeTexFilter(min), getNativeTexFilter(mag));
  return OK;
}

////////////////////////////////////////////////////////////////////////////////

void Texture::disassociate()
{
  if (owner && tex)
  {
    W3D_FreeTexObj(owner, tex);
    owner = 0;
    tex = 0;
  }
}

////////////////////////////////////////////////////////////////////////////////
