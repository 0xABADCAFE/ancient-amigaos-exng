//****************************************************************************//
//**                                                                        **//
//** File:         include/plat/amigaos3_68k/gfxlib/gfx.hpp                 **//
//** Description:  2D Graphics classes                                      **//
//** Comment(s):                                                            **//
//** Library:      Gfx                                                      **//
//** Created:      2003-02-22                                               **//
//** Updated:      2003-02-22                                               **//
//** Author(s):    Karl Churchill                                           **//
//** Note(s):                                                               **//
//** Copyright:    (C)1996-2003, eXtropia Studios                           **//
//**               Serkan YAZICI, Karl Churchill                            **//
//**               All Rights Reserved.                                     **//
//**                                                                        **//
//****************************************************************************//

#ifndef _EXTROPIA_GFXLIB_GFX_NATIVE_HPP
#define _EXTROPIA_GFXLIB_GFX_NATIVE_HPP

namespace X_SYSNAME {
  extern "C" {
    #include <proto/graphics.h>
    #include <proto/cybergraphics.h>
  }
};

////////////////////////////////////////////////////////////////////////////////
//
//  Colour
//
////////////////////////////////////////////////////////////////////////////////

inline uint16 Colour::getRGB15B() const {
  return  ((uint16)(chan[ARGB_R]&0xF8))<<7 |
          ((uint16)(chan[ARGB_G]&0xF8))<<2 |
          ((uint16)chan[ARGB_B])>>3;
}

inline uint16 Colour::getBGR15B() const {
  return  ((uint16)(chan[ARGB_B]&0xF8))<<7 |
          ((uint16)(chan[ARGB_G]&0xF8))<<2 |
          ((uint16)chan[ARGB_R])>>3;
}

inline uint16 Colour::getRGB15L() const {
  uint16 ret = getRGB15B();
  return ret<<8 | ret>>8;
}

inline uint16 Colour::getBGR15L() const {
  uint16 ret = getBGR15B();
  return ret<<8 | ret>>8;
}

inline uint16 Colour::getRGB16B() const {
  return  ((uint16)(chan[ARGB_R]&0xF8))<<8 |
          ((uint16)(chan[ARGB_G]&0xFC))<<3 |
          ((uint16)chan[ARGB_B])>>3;
}

inline uint16 Colour::getBGR16B() const {
  return  ((uint16)(chan[ARGB_B]&0xF8))<<8 |
          ((uint16)(chan[ARGB_G]&0xFC))<<3 |
          ((uint16)chan[ARGB_R])>>3;
}

inline uint16 Colour::getRGB16L() const {
  uint16 ret = getRGB16B();
  return ret<<8 | ret>>8;
}

inline uint16 Colour::getBGR16L() const {
  uint16 ret = getBGR16B();
  return ret<<8 | ret>>8;
}

inline uint32 Colour::getARGB32B() const {
  return argb;
}

inline uint32 Colour::getABGR32B() const {
  return (uint32)chan[ARGB_A]<<24 |
         (uint32)chan[ARGB_B]<<16 |
         (uint32)chan[ARGB_G]<<8 |
         (uint32)chan[ARGB_R];
}

inline uint32 Colour::getARGB32L() const {
  return (uint32)chan[ARGB_A] |
         (uint32)chan[ARGB_R]<<8 |
         (uint32)chan[ARGB_G]<<16 |
         (uint32)chan[ARGB_B]<<24;
}

inline uint32 Colour::getABGR32L() const {
  return (uint32)chan[ARGB_A] |
         (uint32)chan[ARGB_B]<<8 |
         (uint32)chan[ARGB_G]<<16 |
         (uint32)chan[ARGB_R]<<24;
}

inline uint16 Colour::getRGB15()  const { return getRGB15B(); }
inline uint16 Colour::getBGR15()  const { return getBGR15B(); }
inline uint16 Colour::getRGB16()  const { return getRGB16B(); }
inline uint16 Colour::getBGR16()  const { return getBGR16B(); }
inline uint32 Colour::getARGB32()  const { return getARGB32B(); }
inline uint32 Colour::getABGR32()  const { return getABGR32B(); }

////////////////////////////////////////////////////////////////////////////////
//
//  GfxLib
//
////////////////////////////////////////////////////////////////////////////////

class GfxLib : /*public EXNGLinkedLib,*/ private DisplayPropertiesProvider, private PixelProvider {

  protected:
    static sint32  buildDisplayDataBase();
    static void    freeDisplayDataBase();
    static sint32  getWindowedLimits();

  public:
    static sint32  init();
    static void    done();
/*
  public:
    GfxLib();
*/
};


////////////////////////////////////////////////////////////////////////////////
//
//  Native2D
//
////////////////////////////////////////////////////////////////////////////////

#define PXARG void* dst, void* src, uint32* sPal, sint16 w, sint16 h, sint16 dSpan, sint16 sSpan
#define PXCONV void* d, void* s, P_F df, P_F sf, sint16 w, sint16 h, sint16 ds, sint16 ss

class _Nat2D {
  friend class GfxLib;
  private:
    static uint32 abstractToNative[Pixel::MAXHWTYPES];
    static P_F    nativeToAbstract[];
    static void none(PXARG);
    static void copy8(PXARG);

  public:
    typedef void (*PixConv)(PXARG);

  private:
    static PixConv convTab[Pixel::MAXHWTYPES][Pixel::MAXHWTYPES];

  public:
    static sint32    convertPixels(PXCONV, Palette* sPal=0);
/*
    static P_F      getHardwareFormat(P_T t);
*/
  protected:
    static P_F      getHardwareFormat(uint32 native) { return nativeToAbstract[native];  }
    static uint32    getNativeFormat(P_F f) { return abstractToNative[f]; }
/*
    static uint32    getNativeFormat(P_T t) {
      return getNativeFormat(getHardwareFormat(t));
    }
*/
    static PixConv  getConversion(P_F df, P_F sf) { return convTab[sf][df]; }
};

////////////////////////////////////////////////////////////////////////////////
//
//  _Pix8 :  8 bit source format conversions
//
//  Source format is always considered to be indexed ARGB32 (big endian on 68k)
//
////////////////////////////////////////////////////////////////////////////////


class _Pix8 {
  friend class _Nat2D;
  private:
    static void convRGB15BE(PXARG);
    static void convBGR15BE(PXARG);
    static void convRGB15LE(PXARG);
    static void convBGR15LE(PXARG);
    static void convRGB16BE(PXARG);
    static void convBGR16BE(PXARG);
    static void convRGB16LE(PXARG);
    static void convBGR16LE(PXARG);
    static void convRGB24(PXARG);
    static void convBGR24(PXARG);
    static void convARGB32BE(PXARG);
    static void convABGR32BE(PXARG);
    static void convARGB32LE(PXARG);
    static void convABGR32LE(PXARG);
};

////////////////////////////////////////////////////////////////////////////////
//
//  Pix15 :  15 bit source format conversions
//
//  Copy operations may only affect byte ordering
//  Rotate operations exhange RGB / BGR odering
//
////////////////////////////////////////////////////////////////////////////////

#define _PIX15_NATIVE
#define _PIX16_NATIVE
#define _PIX24_NATIVE
#define _PIX32_NATIVE

#define _USEASM(x, className) asm (x "__" className "__PvPvPUjssss")

class _Pix15 {
  friend class _Nat2D;
  private:
#ifndef _PIX15_NATIVE
    // 15 bit -> 15 bit
    static void copy15XETo15XE(PXARG);    // xGy15B/L  -> xGy15B/L
    static void copy15XETo15YE(PXARG);    // xGy15B/L  -> xGy15L/B
    static void rotate15BETo15BE(PXARG);  // xGy15B    -> yGx15B
    static void rotate15LETo15LE(PXARG);  // xGy15L    -> yGx15L
    static void rotate15BETo15LE(PXARG);  // xGy15B    -> yGx15L
    static void rotate15LETo15BE(PXARG);  // xGy15L    -> yGx15B

    // 15 bit -> 16 bit
    static void copy15BETo16BE(PXARG);    // xGy15B    -> xGy16B
    static void copy15LETo16LE(PXARG);    // xGy15L    -> xGy16L
    static void copy15BETo16LE(PXARG);    // xGy15B    -> xGy16L
    static void copy15LETo16BE(PXARG);    // xGy15L    -> xGy16B
    static void rotate15BETo16BE(PXARG);  // xGy15B    -> yGx16B
    static void rotate15LETo16LE(PXARG);  // xGy15L    -> yGx16L
    static void rotate15BETo16LE(PXARG);  // xGy15B    -> yGx16L
    static void rotate15LETo16BE(PXARG);  // xGy15L    -> yGx16B

    // 15 bit -> 24 bit packed pixels
    static void copy15BETo24XGY(PXARG);    // xGy15B    -> xGy24
    static void copy15LETo24XGY(PXARG);    // xGy15L    -> xGy24
    static void rotate15BETo24XGY(PXARG);  // xGy15B    -> yGx24
    static void rotate15LETo24XGY(PXARG);  // xGy15L    -> yGx24

    // 15 bit -> 32 bit
    static void copy15BETo32BE(PXARG);    // xGy15B    -> AxGy32B
    static void copy15LETo32LE(PXARG);    // xGy15L    -> AxGy32L
    static void copy15BETo32LE(PXARG);    // xGy15B    -> AxGy32L
    static void copy15LETo32BE(PXARG);    // xGy15L    -> AxGy32B
    static void rotate15BETo32BE(PXARG);  // xGy15B    -> AyGx32B
    static void rotate15LETo32LE(PXARG);  // xGy15L    -> AyGx32L
    static void rotate15BETo32LE(PXARG);  // xGy15B    -> AyGx32L
    static void rotate15LETo32BE(PXARG);  // xGy15L    -> AyGx32B
#else
    static void copy15XETo15XE(PXARG)      _USEASM("copy15XETo15XE", "Pix15");
    static void copy15XETo15YE(PXARG)      _USEASM("copy15XETo15YE", "Pix15");
    static void rotate15BETo15BE(PXARG)    _USEASM("rotate15BETo15BE", "Pix15");
    static void rotate15LETo15LE(PXARG)    _USEASM("rotate15LETo15LE", "Pix15");
    static void rotate15BETo15LE(PXARG)    _USEASM("rotate15BETo15LE", "Pix15");
    static void rotate15LETo15BE(PXARG)    _USEASM("rotate15LETo15BE", "Pix15");

    // 15 bit -> 16 bit
    static void copy15BETo16BE(PXARG)      _USEASM("copy15BETo16BE", "Pix15");
    static void copy15LETo16LE(PXARG)      _USEASM("copy15LETo16LE", "Pix15");
    static void copy15BETo16LE(PXARG)      _USEASM("copy15BETo16LE", "Pix15");
    static void copy15LETo16BE(PXARG)      _USEASM("copy15LETo16BE", "Pix15");
    static void rotate15BETo16BE(PXARG)    _USEASM("rotate15BETo16BE", "Pix15");
    static void rotate15LETo16LE(PXARG)    _USEASM("rotate15LETo16LE", "Pix15");
    static void rotate15BETo16LE(PXARG)    _USEASM("rotate15BETo16LE", "Pix15");
    static void rotate15LETo16BE(PXARG)    _USEASM("rotate15LETo16BE", "Pix15");

    // 15 bit -> 24 bit packed pixels
    static void copy15BETo24XGY(PXARG)    _USEASM("copy15BETo24XGY", "Pix15");
    static void copy15LETo24XGY(PXARG)    _USEASM("copy15LETo24XGY", "Pix15");
    static void rotate15BETo24XGY(PXARG)  _USEASM("rotate15BETo24XGY", "Pix15");
    static void rotate15LETo24XGY(PXARG)  _USEASM("rotate15LETo24XGY", "Pix15");

    // 15 bit -> 32 bit
    static void copy15BETo32BE(PXARG)      _USEASM("copy15BETo32BE", "Pix15");
    static void copy15LETo32LE(PXARG)      _USEASM("copy15LETo32LE", "Pix15");
    static void copy15BETo32LE(PXARG)      _USEASM("copy15BETo32LE", "Pix15");
    static void copy15LETo32BE(PXARG)      _USEASM("copy15LETo32BE", "Pix15");
    static void rotate15BETo32BE(PXARG)    _USEASM("rotate15BETo32BE", "Pix15");
    static void rotate15LETo32LE(PXARG)    _USEASM("rotate15LETo32LE", "Pix15");
    static void rotate15BETo32LE(PXARG)    _USEASM("rotate15BETo32LE", "Pix15");
    static void rotate15LETo32BE(PXARG)    _USEASM("rotate15LETo32BE", "Pix15");
#endif
};


////////////////////////////////////////////////////////////////////////////////
//
//  _Pix16 :  16 bit source format conversions
//
//  Copy operations may only affect byte ordering
//  Rotate operations exhange RGB / BGR odering
//
////////////////////////////////////////////////////////////////////////////////

class _Pix16 {
  friend class _Nat2D;
  private:
#ifndef _PIX16_NATIVE
    // 16 bit -> 15 bit
    static void copy16BETo15BE(PXARG);    // xGy16B    -> xGy15B
    static void copy16LETo15LE(PXARG);    // xGy16L    -> xGy15L
    static void copy16BETo15LE(PXARG);    // xGy16B    -> xGy15L
    static void copy16LETo15BE(PXARG);    // xGy16L    -> xGy15B
    static void rotate16BETo15BE(PXARG);  // xGy16B    -> yGx15B
    static void rotate16LETo15LE(PXARG);  // xGy16L    -> yGx15L
    static void rotate16BETo15LE(PXARG);  // xGy16B    -> yGx15L
    static void rotate16LETo15BE(PXARG);  // xGy16L    -> yGx15B

    // 16 bit -> 16 bit
    static void copy16XETo16XE(PXARG);    // xGy16B/L  -> xGy16B/L
    static void copy16XETo16YE(PXARG);    // xGy16B/L  -> xGy16L/B
    static void rotate16BETo16BE(PXARG);  // xGy16B    -> yGx16B
    static void rotate16LETo16LE(PXARG);  // xGy16L    -> yGx16L
    static void rotate16BETo16LE(PXARG);  // xGy16B    -> yGx16L
    static void rotate16LETo16BE(PXARG);  // xGy16L    -> yGx16B

    // 16 bit -> 24 bit packed pixels
    static void copy16BETo24XGY(PXARG);    // xGy16B    -> xGy24
    static void copy16LETo24XGY(PXARG);    // xGy16L    -> xGy24
    static void rotate16BETo24XGY(PXARG);  // xGy16B    -> yGx24
    static void rotate16LETo24XGY(PXARG);  // xGy16L    -> yGx24

    // 16 bit -> 32 bit
    static void copy16BETo32BE(PXARG);    // xGy16B    -> AxGy32B
    static void copy16LETo32LE(PXARG);    // xGy16L    -> AxGy32L
    static void copy16BETo32LE(PXARG);    // xGy16B    -> AxGy32L
    static void copy16LETo32BE(PXARG);    // xGy16L    -> AxGy32B
    static void rotate16BETo32BE(PXARG);  // xGy16B    -> AyGx32B
    static void rotate16LETo32LE(PXARG);  // xGy16L    -> AyGx32L
    static void rotate16BETo32LE(PXARG);  // xGy16B    -> AyGx32L
    static void rotate16LETo32BE(PXARG);  // xGy16L    -> AyGx32B
#else
    // 16 bit -> 15 bit
    static void copy16BETo15BE(PXARG)      _USEASM("copy16BETo15BE", "Pix16");
    static void copy16LETo15LE(PXARG)      _USEASM("copy16LETo15LE", "Pix16");
    static void copy16BETo15LE(PXARG)      _USEASM("copy16BETo15LE", "Pix16");
    static void copy16LETo15BE(PXARG)      _USEASM("copy16LETo15BE", "Pix16");
    static void rotate16BETo15BE(PXARG)    _USEASM("rotate16BETo15BE", "Pix16");
    static void rotate16LETo15LE(PXARG)    _USEASM("rotate16LETo15LE", "Pix16");
    static void rotate16BETo15LE(PXARG)    _USEASM("rotate16BETo15LE", "Pix16");
    static void rotate16LETo15BE(PXARG)    _USEASM("rotate16LETo15BE", "Pix16");

    // 16 bit -> 16 bit
    static void copy16XETo16XE(PXARG)      _USEASM("copy16XETo16XE", "Pix16");
    static void copy16XETo16YE(PXARG)      _USEASM("copy16XETo16YE", "Pix16");
    static void rotate16BETo16BE(PXARG)    _USEASM("rotate16BETo16BE", "Pix16");
    static void rotate16LETo16LE(PXARG)    _USEASM("rotate16LETo16LE", "Pix16");
    static void rotate16BETo16LE(PXARG)    _USEASM("rotate16BETo16LE", "Pix16");
    static void rotate16LETo16BE(PXARG)    _USEASM("rotate16LETo16BE", "Pix16");

    // 16 bit -> 24 bit packed pixels
    static void copy16BETo24XGY(PXARG)    _USEASM("copy16BETo24XGY", "Pix16");
    static void copy16LETo24XGY(PXARG)    _USEASM("copy16LETo24XGY", "Pix16");
    static void rotate16BETo24XGY(PXARG)  _USEASM("rotate16BETo24XGY", "Pix16");
    static void rotate16LETo24XGY(PXARG)  _USEASM("rotate16LETo24XGY", "Pix16");

    // 16 bit -> 32 bit
    static void copy16BETo32BE(PXARG)      _USEASM("copy16BETo32BE", "Pix16");
    static void copy16LETo32LE(PXARG)      _USEASM("copy16LETo32LE", "Pix16");
    static void copy16BETo32LE(PXARG)      _USEASM("copy16BETo32LE", "Pix16");
    static void copy16LETo32BE(PXARG)      _USEASM("copy16LETo32BE", "Pix16");
    static void rotate16BETo32BE(PXARG)    _USEASM("rotate16BETo32BE", "Pix16");
    static void rotate16LETo32LE(PXARG)    _USEASM("rotate16LETo32LE", "Pix16");
    static void rotate16BETo32LE(PXARG)    _USEASM("rotate16BETo32LE", "Pix16");
    static void rotate16LETo32BE(PXARG)    _USEASM("rotate16LETo32BE", "Pix16");
#endif
};


////////////////////////////////////////////////////////////////////////////////
//
//  _Pix24 : 24 bit source format conversions
//
//  Copy operations may only affect byte ordering
//  Rotate operations exhange RGB / BGR odering
//
////////////////////////////////////////////////////////////////////////////////

class _Pix24 {
  friend class _Nat2D;
  private:
#ifndef _PIX24_NATIVE
    // 24 bit -> 15 bit
    static void copy24XGYTo15BE(PXARG);    // xGy24     -> xGy15B
    static void copy24XGYTo15LE(PXARG);    // xGy24     -> xGy15L
    static void rotate24XGYTo15BE(PXARG);  // xGy24     -> yGx15B
    static void rotate24XGYTo15LE(PXARG);  // xGy24     -> yGx15L

    // 24 bit -> 16 bit
    static void copy24XGYTo16BE(PXARG);    // xGy24     -> xGy16B
    static void copy24XGYTo16LE(PXARG);    // xGy24     -> xGy16L
    static void rotate24XGYTo16BE(PXARG);  // xGy24     -> yGx16B
    static void rotate24XGYTo16LE(PXARG);  // xGy24     -> yGx16L

    // 24 bit -> 24 bit
    static void copy24To24(PXARG);        // xGy24     -> xGy24
    static void rotate24To24(PXARG);      // xGy24     -> yGx24

    // 24 bit -> 32 bit
    static void copy24XGYTo32BE(PXARG);    // xGy24     -> AxGy32B
    static void copy24XGYTo32LE(PXARG);    // xGy24     -> AxGy32L
    static void rotate24XGYTo32BE(PXARG);  // xGy24     -> AyGx32B
    static void rotate24XGYTo32LE(PXARG);  // xGy24     -> AyGx32L
#else
    // 24 bit -> 15 bit
    static void copy24XGYTo15BE(PXARG)    _USEASM("copy24XGYTo15BE", "Pix24");
    static void copy24XGYTo15LE(PXARG)    _USEASM("copy24XGYTo15LE", "Pix24");
    static void rotate24XGYTo15BE(PXARG)  _USEASM("rotate24XGYTo15BE", "Pix24");
    static void rotate24XGYTo15LE(PXARG)  _USEASM("rotate24XGYTo15LE", "Pix24");

    // 24 bit -> 16 bit
    static void copy24XGYTo16BE(PXARG)    _USEASM("copy24XGYTo16BE", "Pix24");
    static void copy24XGYTo16LE(PXARG)    _USEASM("copy24XGYTo16LE", "Pix24");
    static void rotate24XGYTo16BE(PXARG)  _USEASM("rotate24XGYTo16BE", "Pix24");
    static void rotate24XGYTo16LE(PXARG)  _USEASM("rotate24XGYTo16LE", "Pix24");

    // 24 bit -> 24 bit
    static void copy24To24(PXARG)          _USEASM("copy24To24", "Pix24");
    static void rotate24To24(PXARG)        _USEASM("rotate24To24", "Pix24");

    // 24 bit -> 32 bit
    static void copy24XGYTo32BE(PXARG)    _USEASM("copy24XGYTo32BE", "Pix24");
    static void copy24XGYTo32LE(PXARG)    _USEASM("copy24XGYTo32LE", "Pix24");
    static void rotate24XGYTo32BE(PXARG)  _USEASM("rotate24XGYTo32BE", "Pix24");
    static void rotate24XGYTo32LE(PXARG)  _USEASM("rotate24XGYTo32LE", "Pix24");
#endif
};

////////////////////////////////////////////////////////////////////////////////
//
//  _Pix32 : 32 bit source format conversions
//
//  Copy operations may only affect byte ordering
//  Rotate operations exhange RGB / BGR odering
//
////////////////////////////////////////////////////////////////////////////////

class _Pix32 {
  friend class _Nat2D;
  friend class _Pix8;
  private:
#ifndef _PIX32_NATIVE
    // 32 bit -> 15 bit
    static void copy32BETo15BE(PXARG);    // AxGy32B    -> xGy15B
    static void copy32LETo15LE(PXARG);    // AxGy32L    -> xGy15L
    static void copy32BETo15LE(PXARG);    // AxGy32B    -> xGy15L
    static void copy32LETo15BE(PXARG);    // AxGy32L    -> xGy15B
    static void rotate32BETo15BE(PXARG);  // AxGy32B    -> yGx15B
    static void rotate32LETo15LE(PXARG);  // AxGy32L    -> yGx15L
    static void rotate32BETo15LE(PXARG);  // AxGy32B    -> yGx15L
    static void rotate32LETo15BE(PXARG);  // AxGy32L    -> yGx15B

    // 32 bit -> 16 bit
    static void copy32BETo16BE(PXARG);    // AxGy32B    -> xGy16B
    static void copy32LETo16LE(PXARG);    // AxGy32L    -> xGy16L
    static void copy32BETo16LE(PXARG);    // AxGy32B    -> xGy16L
    static void copy32LETo16BE(PXARG);    // AxGy32L    -> xGy16B
    static void rotate32BETo16BE(PXARG);  // AxGy32B    -> yGx16B
    static void rotate32LETo16LE(PXARG);  // AxGy32L    -> yGx16L
    static void rotate32BETo16LE(PXARG);  // AxGy32B    -> yGx16L
    static void rotate32LETo16BE(PXARG);  // AxGy32L    -> yGx16B

    // 32 bit -> 24 bit packed pixels
    static void copy32BETo24XGY(PXARG);    // AxGy16B    -> xGy24
    static void copy32LETo24XGY(PXARG);    // AxGy16L    -> xGy24
    static void rotate32BETo24XGY(PXARG);  // AxGy16B    -> yGx24
    static void rotate32LETo24XGY(PXARG);  // AxGy16L    -> yGx24

    // 32 bit -> 32 bit
    static void copy32XETo32XE(PXARG);    // AxGy32B/L  -> AxGy32B/L
    static void copy32XETo32YE(PXARG);    // AxGy32B/L  -> AxGy32L/B
    static void rotate32BETo32BE(PXARG);  // AxGy32B    -> AyGx32B
    static void rotate32LETo32LE(PXARG);  // AxGy32L    -> AyGx32L
    static void rotate32BETo32LE(PXARG);  // AxGy32B    -> AyGx32L
    static void rotate32LETo32BE(PXARG);  // AxGy32L    -> AyGx32B
#else
    static void copy32BETo15BE(PXARG)      _USEASM("copy32BETo15BE", "Pix32");
    static void copy32LETo15LE(PXARG)      _USEASM("copy32LETo15LE", "Pix32");
    static void copy32BETo15LE(PXARG)      _USEASM("copy32BETo15LE", "Pix32");
    static void copy32LETo15BE(PXARG)      _USEASM("copy32LETo15BE", "Pix32");
    static void rotate32BETo15BE(PXARG)    _USEASM("rotate32BETo15BE", "Pix32");
    static void rotate32LETo15LE(PXARG)    _USEASM("rotate32LETo15LE", "Pix32");
    static void rotate32BETo15LE(PXARG)    _USEASM("rotate32BETo15LE", "Pix32");
    static void rotate32LETo15BE(PXARG)    _USEASM("rotate32LETo15BE", "Pix32");

    // 32 bit -> 16 bit
    static void copy32BETo16BE(PXARG)      _USEASM("copy32BETo16BE", "Pix32");
    static void copy32LETo16LE(PXARG)      _USEASM("copy32LETo16LE", "Pix32");
    static void copy32BETo16LE(PXARG)      _USEASM("copy32BETo16LE", "Pix32");
    static void copy32LETo16BE(PXARG)      _USEASM("copy32LETo16BE", "Pix32");
    static void rotate32BETo16BE(PXARG)    _USEASM("rotate32BETo16BE", "Pix32");
    static void rotate32LETo16LE(PXARG)    _USEASM("rotate32LETo16LE", "Pix32");
    static void rotate32BETo16LE(PXARG)    _USEASM("rotate32BETo16LE", "Pix32");
    static void rotate32LETo16BE(PXARG)    _USEASM("rotate32LETo16BE", "Pix32");

    // 32 bit -> 24 bit packed pixels
    static void copy32BETo24XGY(PXARG)    _USEASM("copy32BETo24XGY", "Pix32");
    static void copy32LETo24XGY(PXARG)    _USEASM("copy32LETo24XGY", "Pix32");
    static void rotate32BETo24XGY(PXARG)  _USEASM("rotate32BETo24XGY", "Pix32");
    static void rotate32LETo24XGY(PXARG)  _USEASM("rotate32LETo24XGY", "Pix32");

    // 32 bit -> 32 bit
    static void copy32XETo32XE(PXARG)      _USEASM("copy32XETo32XE", "Pix32");
    static void copy32XETo32YE(PXARG)      _USEASM("copy32XETo32YE", "Pix32");
    static void rotate32BETo32BE(PXARG)    _USEASM("rotate32BETo32BE", "Pix32");
    static void rotate32LETo32LE(PXARG)    _USEASM("rotate32LETo32LE", "Pix32");
    static void rotate32BETo32LE(PXARG)    _USEASM("rotate32BETo32LE", "Pix32");
    static void rotate32LETo32BE(PXARG)    _USEASM("rotate32LETo32BE", "Pix32");
#endif
};


#endif
