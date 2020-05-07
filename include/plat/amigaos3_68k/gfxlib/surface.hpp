//****************************************************************************//
//**                                                                        **//
//** File:         include/plat/amigaos3_68k/gfxlib/surface.hpp             **//
//** Description:  System displayable surface wrapper                       **//
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

#ifndef _EXTROPIA_GFXLIB_SURFACE_NATIVE_HPP
#define _EXTROPIA_GFXLIB_SURFACE_NATIVE_HPP

////////////////////////////////////////////////////////////////////////////////
//
//  Surface
//    Abstracts an OS BitMap
//
////////////////////////////////////////////////////////////////////////////////

class Surface : public Area, virtual private _Nat2D {
  friend class SurfaceProvider;
  friend class SurfaceUser;
  private:
    X_SYSNAME::Window*  winUser;  // this handle is used by AmigaOS Draw2D implementation
    X_SYSNAME::BitMap*  bitMap;
    void*    gfxAddr;
    void*    lockAddr;
    uint32  properties;
    sint16  hwWidth;  // Hardware rounded width
    sint16  hwHeight;  // Hardware rounded height
    sint16  modulus;  // Row modulus for direct access
    sint16  depth;
    P_F      pixFormat;

    void    queryBitMap();
    void    init();
    sint32  create(S_WH, X_SYSNAME::BitMap* clone);
    void    destroy();
    Surface() {  init();  }

  protected:
    enum {
      OWNBITMAP  = 0x00000001,  // internally allocated BitMap
      EXTBITMAP  = 0x00000002, // externally provided BitMap
      LINEARMEM  = 0x00000004,
    };

    static        sint32 blitCopy(Surface* dst, S_CRD1, Surface* src, S_CRD2, S_WH);

  public:
    bool          isAllocated()   { return (bitMap!=0); }
    bool          isLinear()      { return ((properties&LINEARMEM)!=0); }
    P_F            getFormat()      { return pixFormat; }
    const P_DSC*  getDescriptor()  { return PixelDescriptor::get(pixFormat); }
    sint32        getDepth()      { return depth; }    // in bits
    sint32        getModulus()    { return modulus; }  // in pixel units

    sint32        getHWWidth()    { return hwWidth; }
    sint32        getHWHeight()    { return hwHeight; }

    // Elemental draw access
    void*    lockData();
    void    unlockData();
    void    clear(Colour c);
    sint32  putImageBuffer(ImageBuffer* img, S_CRD1, S_CRD2, S_WH);
    sint32  putSurface(Surface* other, S_CRD1, S_CRD2, S_WH) {
      return blitCopy(this, x1, y1, other, x2, y2, w, h);
    }

  public:
    // User creation of new surfaces via factory only
    static Surface* create(S_WH, Surface* clone);
    ~Surface()  { destroy(); }
};


////////////////////////////////////////////////////////////////////////////////
//
//  SurfaceUser
//    Grants access to the underlying surface representation
//
//  SurfaceProvider
//    Wraps a Surface object around a pre-existing OS BitMap
//
////////////////////////////////////////////////////////////////////////////////

class SurfaceUser {
  protected:
    static X_SYSNAME::BitMap*  getSurfaceRep(Surface* s) { return s->bitMap; }
    static X_SYSNAME::Window*  getWinUser(Surface* s) { return s->winUser; }
};

class SurfaceProvider : protected SurfaceUser {
  protected:
    static bool      assignSurface(Surface* s, X_SYSNAME::BitMap* b);
    static void      assignSurfaceQuick(Surface* s, X_SYSNAME::BitMap* b) {
      s->bitMap = b;
    }
    static Surface*  assignNewSurface(X_SYSNAME::BitMap* b);
    static Surface*  createSurface(X_SYSNAME::BitMap* b, S_WH);
    static void      setWinUser(Surface* s, X_SYSNAME::Window* w) {
      s->winUser = w;
    }
};

#endif