//****************************************************************************//
//**                                                                        **//
//** File:         include/gfxlib/gfx.hpp                                   **//
//** Description:  Common graphics definitions                              **//
//** Comment(s):   Stub header                                              **//
//** Library:      gfxlib                                                   **//
//** Created:      2003-02-22                                               **//
//** Updated:      2003-03-02                                               **//
//** Author(s):    Karl Churchill                                           **//
//** Note(s):                                                               **//
//** Copyright:    (C)1996-2003, eXtropia Studios                           **//
//**               Serkan YAZICI, Karl Churchill                            **//
//**               All Rights Reserved.                                     **//
//**                                                                        **//
//****************************************************************************//

#ifndef _EXTROPIA_GFXLIB_GFX_HPP
#define _EXTROPIA_GFXLIB_GFX_HPP

#include <xbase.hpp>

////////////////////////////////////////////////////////////////////////////////
//
//  Shortening macros for arg lists etc.
//
////////////////////////////////////////////////////////////////////////////////

#define S_XY    sint16 x, sint16 y
#define S_RXY   rsint16 x, rsint16 y
#define S_WH    sint16 w, sint16 h
#define S_RWH   rsint16 w, rsint16 h

#define S_WHD   sint16 w, sint16 h, Pixel::Depth d
#define S_WHT   sint16 w, sint16 h, Pixel::Type t
#define S_WHF   sint16 w, sint16 h, Pixel::HWType t
#define S_XYWH  sint16 x, sint16 y, sint16 w, sint16 h
#define S_XYWHD sint16 x, sint16 y, sint16 w, sint16 h, Pixel::Depth d
#define S_XYWHT sint16 x, sint16 y, sint16 w, sint16 h, Pixel::Type t
#define S_XYWHF sint16 x, sint16 y, sint16 w, sint16 h, Pixel::HWType f

#define S_1CRD  sint16 x, sint16 y
#define S_2CRD  sint16 x1, sint16 y1, sint16 x2, sint16 y2
#define S_3CRD  sint16 x1, sint16 y1, sint16 x2, sint16 y2, sint16 x3, sint16 y3

#define S_CRD1  sint16 x1, sint16 y1
#define S_CRD2  sint16 x2, sint16 y2
#define S_CRD3  sint16 x3, sint16 y3
#define S_CRD4  sint16 x4, sint16 y4

#define P_D     Pixel::Depth
#define P_F     Pixel::HWType
#define P_DSC   PixelDescriptor
#define D_PRP   DisplayProperties


////////////////////////////////////////////////////////////////////////////////
//
//  Pixel
//
//  Device-independent and absolute definitions
//
////////////////////////////////////////////////////////////////////////////////

class Pixel {
  friend class PixelProvider;
  public:
    // Depth only, unspecified pixel arrangement
    typedef enum {
      BPPUNK  = 0,
      BPP8    = 8,
      BPP15   = 15,
      BPP16   = 16,
      BPP24   = 24,
      BPP32   = 32
    } Depth;

    // Absolute hardware supported types, used in implementation
    // and user direct rendering
    typedef enum {
      INDEX8     = 0,  // 8-bit
      RGB15B     = 1,  // 15-bit, RGB    5:5:5, big endian
      BGR15B     = 2,  // 15-bit, BGR    5:5:5, big endian
      RGB15L     = 3,  // 15-bit, RGB    5:5:5, little endian
      BGR15L     = 4,  // 15-bit, BGR    5:5:5, little endian
      RGB16B     = 5,  // 16-bit, RGB    5:6:5, big endian
      BGR16B     = 6,  // 16-bit, BGR    5:6:5, big endian
      RGB16L     = 7,  // 16-bit, RGB    5:6:5, little endian
      BGR16L     = 8,  // 16-bit, BGR    5:6:5, little endian
      RGB24P     = 9,  // 24-bit, RGB    8:8:8, byte packed
      BGR24P     = 10,  // 24-bit, BGR    8:8:8, byte packed
      ARGB32B    = 11,  // 32-bit, ARGB 8:8:8:8, big endian,
      ABGR32B    = 12,  // 32-bit, ABGR 8:8:8:8, big endian
      ARGB32L    = 13,  // 32-bit, ARGB 8:8:8:8, little endian [aka BGRA32]
      ABGR32L    = 14,  // 32-bit, ABGR 8:8:8:8, little endian [aka RGBA32]
      OTHERFMT   = 15,  // Other format, requires PixelDescriptor
      MAXHWTYPES = 15
    } HWType;

    // Returns the peferred pixel format for a given depth definition.
    // This is defined by the implementation.
    static HWType getPrefFormat(Depth d);

  private:
    // preferred formats
    static HWType formats[6];
};

////////////////////////////////////////////////////////////////////////////////
//
//  PixelDescriptor
//
//  Defines the properties of a given Pixel::HWType, specifically
//
//  Pixel word size
//  Channel ranges, maxima, shift offsets and mask values
//  Data arrangement (endian swapped relative to current machine)
//
////////////////////////////////////////////////////////////////////////////////


class PixelDescriptor {
  friend class PixelDescriptorProvider;
  private:
    uint8 size;        // bytes
    uint8 accessSize;  // bytes
    uint8 indexed;     // used for 8-bit
    uint8 swapMode;    // is byte swapped wrt cpu native order
    uint8 bAlpha;
    uint8 bRed;
    uint8 bGreen;
    uint8 bBlue;
    uint8 sAlpha;      // bit shifts for word modes, byte offsets for packed modes
    uint8 sRed;
    uint8 sGreen;
    uint8 sBlue;

    static PixelDescriptor propTab[Pixel::MAXHWTYPES];

  public:
    PixelDescriptor() {}
    PixelDescriptor(
      uint8 s, uint8 acs, uint8 ii, uint8 sm, uint8 ba, uint8 br,
      uint8 bg, uint8 bb, uint8 sa, uint8 sr, uint8 sg, uint8 sb
    ) {
      size = s; accessSize = acs; indexed = ii; swapMode = sm;
      bAlpha = ba; bRed = br; bGreen = bg; bBlue = bb;
      sAlpha = sa; sRed = sr; sGreen = sg; sBlue = sb;
    }

    static const PixelDescriptor* get(Pixel::HWType t) { return &propTab[t]; }
    bool   isSwapped()      const { return swapMode != 0 ? true : false; }
    bool   isIndexed()      const { return indexed != 0 ? true : false; }
    size_t getSize()        const { return size; }
    uint32 getBitDepth()    const { return (bAlpha+bRed+bGreen+bBlue); }
    uint32 getBitsAlpha()   const { return bAlpha; }
    uint32 getBitsRed()     const { return bRed; }
    uint32 getBitsGreen()   const { return bGreen; }
    uint32 getBitsBlue()    const { return bBlue; }
    uint32 getRangeAlpha()  const { return (1UL << bAlpha); }
    uint32 getRangeRed()    const { return (1UL << bRed); }
    uint32 getRangeGreen()  const { return (1UL << bGreen); }
    uint32 getRangeBlue()   const { return (1UL << bBlue); }
    uint32 getMaxAlpha()    const { return (1UL << bAlpha) - 1; }
    uint32 getMaxRed()      const { return (1UL << bRed)   - 1; }
    uint32 getMaxGreen()    const { return (1UL << bGreen) - 1; }
    uint32 getMaxBlue()     const { return (1UL << bBlue)  - 1; }
    uint32 getShiftAlpha()  const { return sAlpha; }
    uint32 getShiftRed()    const { return sRed; }
    uint32 getShiftGreen()  const { return sGreen; }
    uint32 getShiftBlue()   const { return sBlue; }
    uint32 getMaskAlpha()   const { return getMaxAlpha() << sAlpha; }
    uint32 getMaskRed()     const { return getMaxRed()   << sRed; }
    uint32 getMaskGreen()   const { return getMaxGreen() << sGreen; }
    uint32 getMaskBlue()    const { return getMaxBlue()  << sBlue; }
};

////////////////////////////////////////////////////////////////////////////////
//
//  Colour
//
//  32-bit ARGB wrapper, supporting per channel access, additive and
//  multiplicative blending
//
////////////////////////////////////////////////////////////////////////////////

#if (X_ENDIAN == XA_BIGENDIAN)
  #define ARGB_A 0
  #define ARGB_R 1
  #define ARGB_G 2
  #define ARGB_B 3
#else
  #define ARGB_A 3
  #define ARGB_R 2
  #define ARGB_G 1
  #define ARGB_B 0
#endif

class Colour {
  friend bool operator==(const Colour&, const Colour&);
  friend bool operator!=(const Colour&, const Colour&);
  private:
    union {
      uint32 argb;
      uint8  chan[4];
      sint32 i;
    };

  public:
    // Brightness balances, used for YUV / greyscal calcs etc.
    enum {
      redBalance    = 77,
      greenBalance  = 150,
      blueBalance   = 28
    };
    Colour() : argb(0) {}

    Colour(uint32 c)                    { argb = c; }
    uint8&  alpha()                     { return chan[ARGB_A]; }
    uint8&  red()                       { return chan[ARGB_R]; }
    uint8&  green()                     { return chan[ARGB_G]; }
    uint8&  blue()                      { return chan[ARGB_B]; }

    Colour& operator=(const Colour& c)  { argb = c.argb; return *this; }
    Colour& operator=(uint32 c)         { argb = c; return *this; }
    operator int()                      { return i; }
    operator uint32()                   { return argb; }

    Colour& operator+=(const Colour& c) {
      // additive RGB mix, alpha ignored
      ruint32 s = 0x000000FF;
      ruint32  v = chan[ARGB_R]+c.chan[ARGB_R];
      chan[ARGB_R] = v > s ? s : v;
      v = chan[ARGB_G] + c.chan[ARGB_G];
      chan[ARGB_G] = v > s ? s : v;
      v = chan[ARGB_B] + c.chan[ARGB_B];
      chan[ARGB_B] = v > s ? s : v;
      return *this;
    }

    Colour& operator*=(const Colour& c) {
      // multiplicative RGB mix, alpha ignored
      chan[ARGB_R] = ((uint16)chan[ARGB_R]*(uint16)c.chan[ARGB_R])>>8;
      chan[ARGB_G] = ((uint16)chan[ARGB_G]*(uint16)c.chan[ARGB_G])>>8;
      chan[ARGB_B] = ((uint16)chan[ARGB_B]*(uint16)c.chan[ARGB_B])>>8;
      return *this;
    }

    void scale(float32 f) { 
      chan[ARGB_R] = Clamp::integer((uint32)(f*chan[ARGB_R]), 0, 255);
      chan[ARGB_G] = Clamp::integer((uint32)(f*chan[ARGB_G]), 0, 255);
      chan[ARGB_B] = Clamp::integer((uint32)(f*chan[ARGB_B]), 0, 255);
    }

    Colour& operator*=(float32 f) {
      scale(f);
      return *this;
    }

    // Standard absolute pixel representations (as word values).
    // These depend on endianess of host machine and are defined
    // as inline functions in {platform}/gfxlib/gfx.hpp
    uint16 getRGB15B()  const;
    uint16 getBGR15B()  const;
    uint16 getRGB15L()  const;
    uint16 getBGR15L()  const;

    uint16 getRGB16B()  const;
    uint16 getBGR16B()  const;
    uint16 getRGB16L()  const;
    uint16 getBGR16L()  const;

    uint32 getARGB32B() const;
    uint32 getABGR32B() const;
    uint32 getARGB32L() const;
    uint32 getABGR32L() const;

    // native pixel representations, always return endian native rep
    uint16 getRGB15()   const;
    uint16 getBGR15()   const;
    uint16 getRGB16()   const;
    uint16 getBGR16()   const;
    uint32 getARGB32()  const;
    uint32 getABGR32()  const;

    // Generic pixel representation for any PixelDescriptor
    uint32 getPixelRep(const PixelDescriptor *p) const;
    void   setFromPixel(const PixelDescriptor *p, uint32 data);

    uint32 const getIntensity() {
      return  (((uint32)(redBalance*(uint16)red())) +
              ((uint32)(greenBalance*(uint16)green())) +
              ((uint32)(blueBalance*(uint16)blue())))>>8;
    }
};

inline bool operator==(const Colour& a, const Colour& b) {
  return a.argb == b.argb;
}

inline bool operator!=(const Colour& a, const Colour& b) {
  return a.argb != b.argb;
}

////////////////////////////////////////////////////////////////////////////////
//
//  Americanisms :-)
//
////////////////////////////////////////////////////////////////////////////////

typedef Colour Color;

////////////////////////////////////////////////////////////////////////////////
//
//  Palette
//
////////////////////////////////////////////////////////////////////////////////

class Palette {
  private:
    Colour data[256];

  public:
    Colour& operator[](size_t n)  { return data[n & 255]; }
    void    scaleAlpha(float32 scf, sint8 ofs = 0, uint8 min = 0, uint8 max = 255);
    void    scaleRed(float32 scf, sint8 ofs = 0, uint8 min = 0, uint8 max = 255);
    void    scaleGreen(float32 scf, sint8 ofs = 0, uint8 min = 0, uint8 max = 255);
    void    scaleBlue(float32 scf, sint8 ofs = 0, uint8 min = 0, uint8 max = 255);

    size_t  findBestMatch(const Colour& c, bool igoreAlpha);
    Colour* getTable() { return data; }

  public:
    Palette() {}
    ~Palette() {}
};

////////////////////////////////////////////////////////////////////////////////
//
//  Area
//
////////////////////////////////////////////////////////////////////////////////

class Area {
  protected:
    sint16 width, height;

  public:
    sint32  getW() const { return width; }
    sint32  getH() const { return height; }

  public:
    Area() : width(0), height(0) {}
    Area(S_WH) : width(w), height(h) {}
};


////////////////////////////////////////////////////////////////////////////////
//
//  Rect
//
////////////////////////////////////////////////////////////////////////////////

class Rect : public Area {
  protected:
    sint16  xPos, yPos;

  public:
    sint32  getX()  const  { return xPos; }
    sint32  getY()  const  { return yPos; }
    sint32  getX2() const  { return xPos+getW() - 1; }
    sint32  getY2() const  { return yPos+getH() - 1; }

    Rect() : Area(), xPos(0), yPos(0) {}
    Rect(S_XYWH) : Area(w, h), xPos(x), yPos(y) {}
};

////////////////////////////////////////////////////////////////////////////////
//
//  ImageBuffer
//
//  Simple rectangular area of pixel data.
//
////////////////////////////////////////////////////////////////////////////////

class ImageBuffer : public Area {
  friend class ImageBufferProvider;
  private:
    uint32    properties;
    void*     data;
    Palette*  palette;
    P_DSC*    pixDesc;
    P_F       pixFormat;
    sint16    palSize;
    enum {
      OWN_DATA     = 0x00000001,
      OWN_PALETTE  = 0x00000002,
      OWN_PIXDESC  = 0x00000004
    };

  public:
    sint32          create(S_WH, P_DSC* dsc, Palette* p = 0, bool copyDsc = false, bool copyPal = false, sint16 sz = 0);
    sint32          create(S_WH, P_F f, Palette* p = 0, bool copyPal = false, sint16 sz = 0);
    void            destroy();
    void*           getData()             { return data; }
    P_F             getFormat()     const { return pixFormat; }
    const P_DSC*    getDescriptor() const;
    Palette*        getPalette()          { return palette; }
    sint32          setPalette(Palette* p, bool copy, sint16 sz);
    sint16          getPalSize()    const { return palSize; }

  public:
    ImageBuffer() : Area(), properties(0), data(0), palette(0), pixDesc(0),
                    pixFormat(Pixel::INDEX8), palSize(0) {}
    ~ImageBuffer() { destroy(); }
};


////////////////////////////////////////////////////////////////////////////////
//
//  DisplayProperties
//
//  Describes properties of an available display mode. This class may only
//  be instansiated and modified by DisplayPropertiesProvider.
//
////////////////////////////////////////////////////////////////////////////////

class DisplayProperties : public Area {
  friend class DisplayPropertiesProvider;
  private:
    static DisplayProperties*  modesAvail;
    static size_t  numModes;

    static  sint16  minWidth;
    static  sint16  maxWidth;
    static  sint16  minHeight;
    static  sint16  maxHeight;
    static  sint16  minDepth;
    static  sint16  maxDepth;

    uint32  modeIndex;
    uint32  horizRefreshNanoSec;
    uint32  vertRefreshMicroSec;
    float32 aspect;
    uint32  properties;
    P_D     depth;
    P_F     pixFormat;
    char    name[32];

    static size_t findIndex(S_WHD, bool e);

  private:
    DisplayProperties() {}

  public:
    enum {
      HIDDEN_BUFFER   = 0x00000001, // can have invisible back buffer
      BUFFER_BLIT     = 0x00000002, // uses blit for buffer switch
      BUFFER_FLIP     = 0x00000004,  // uses flip for buffer switch
      LARGER_BITMAP   = 0x00000008,  // can have a bitmap larger than view
      SCROLL_HORZ     = 0x00000010,  // can scroll large bitamp horizontal
      SCROLL_VERT     = 0x00000020,  // can scroll large bitmap vertical
      BLIT_VISIBLE    = 0x00000040,  // can use blitter on visible buf
      BLIT_HIDDEN     = 0x00000080,  // can use blitter on hidden buf
      EXC_LOCK_VIS    = 0x00000100, // can lock visible buffer
      EXC_LOCK_HID    = 0x00000200, // can lock hidden buffer
      PIX_WRITE_VIS   = 0x00000400,  // can write pixels to visible buf
      PIX_WRITE_HID   = 0x00000800,  // can write pixels to hidden buf
      PIX_READ_VIS    = 0x00001000, // can read pixels from visible buf
      PIX_READ_HID    = 0x00002000, // can read pixels from hidden buf
      ADV_RENDER_VIS  = 0x00004000, // can use hw render on visible buf
      ADV_RENDER_HID  = 0x00008000, // can use hw render on hidden buf
      WINDOWMODE      = 0x0000AAC3
    };

    float64 getHorizRefreshRatekHz()  const {
      return 1000000.0 / (float64)horizRefreshNanoSec;
    }

    float64 getVertRefreshRateHz()  const {
      return 1000000.0 / (float64)vertRefreshMicroSec;
    }

    uint32        getModeIndex()      const { return modeIndex; }
    uint32        getHorizPeriod()    const { return horizRefreshNanoSec; }
    uint32        getVertPeriod()     const { return vertRefreshMicroSec; }
    float32       getAspect()         const { return aspect; }
    P_D           getDepth()          const { return depth; }
    P_F           getFormat()         const { return pixFormat; }
    const char*   getName()           const { return name; }
    uint32        supports(uint32 p)  const { return p & properties; }

    // static members
    static sint32 getMinWidth()   { return minWidth; }
    static sint32 getMaxWidth()   { return maxWidth; }
    static sint32 getMinHeight()  { return minHeight; }
    static sint32 getMaxHeight()  { return maxHeight; }
    static sint32 getMinDepth()   { return minDepth; }
    static sint32 getMaxDepth()   { return maxDepth; }
    static size_t getNumModes()   { return numModes; }

    static const DisplayProperties*  getMode(size_t n) {
      if (modesAvail && n < numModes) {
        return &modesAvail[n];
      }
      return 0;
    }

    static const DisplayProperties* findMode(S_WHD, bool exact) {
      return getMode(findIndex(w, h, d, exact));
    }
};

////////////////////////////////////////////////////////////////////////////////
//
//  Display
//
//  Basic interface for all display types.
//
////////////////////////////////////////////////////////////////////////////////

class Surface;

class Display {
  public:
    virtual sint32    open(S_WHD, const char* title)          = 0;
    virtual sint32    open(const D_PRP* p, const char* title) = 0;
    virtual sint32    reopen()                                = 0;
    virtual void      close()                                 = 0;
    virtual void      waitSync()                              = 0;
    virtual void      refresh()                               = 0;
    virtual void      refresh(S_XYWH)                         = 0;
    virtual void      setTitle(const char* title)             = 0;
    virtual Surface*  getDrawSurface()                        = 0;
    virtual const D_PRP* getProperties()                      = 0;

    void    refresh(const Rect& rect) {
      refresh(rect.getX(), rect.getY(), rect.getW(), rect.getH());
    }

  public:
    virtual ~Display() { }
};

////////////////////////////////////////////////////////////////////////////////
//
//  Private classes (library backend)
//
//  Provider interfaces (used to implement system dependent components that must
//  provide/initialise/modify existing classes
//
//  PixelProvider
//  PixelDescriptorProvider
//  ImageBufferProvider
//  DisplayPropertiesProvider
//
//  Native classes
//
//  GfxLib
//  Surface
//
////////////////////////////////////////////////////////////////////////////////

#include "gfx_private.hpp"

////////////////////////////////////////////////////////////////////////////////
//
//  DisplayWindow
//
////////////////////////////////////////////////////////////////////////////////

class DisplayWindow : public Display, private _NatWin {

  public:
    sint32    open(S_WHD, const char* title) {
      return _NatWin::open(w, h, d, title);
    }

    sint32    open(const D_PRP* p, const char* title) {
      return _NatWin::open(p, title);
    }

    sint32    reopen()                    { return _NatWin::reopen(); }
    void      close()                     { _NatWin::close(); }
    void      waitSync()                  { _NatWin::waitSync(); }
    void      refresh()                   { _NatWin::refresh(); }
    void      refresh(S_XYWH)             { _NatWin::refresh(x, y, w, h); }
    void      setTitle(const char* title) { _NatWin::setTitle(title); }
    Surface*  getDrawSurface()            { return _NatWin::getDrawSurface(); }
    const D_PRP* getProperties()          { return _NatWin::getProperties(); }

    // window specific methods
    sint16    getWinX()                   { return _NatWin::getWinX(); }
    sint16    getWinY()                   { return _NatWin::getWinY(); }
    sint16    getWinW()                   { return _NatWin::getWinW(); }
    sint16    getWinH()                   { return _NatWin::getWinH(); }
    sint16    getWinBL()                  { return _NatWin::getWinBL(); }
    sint16    getWinBR()                  { return _NatWin::getWinBR(); }
    sint16    getWinBT()                  { return _NatWin::getWinBT(); }
    sint16    getWinBB()                  { return _NatWin::getWinBB(); }
    sint16    getViewX()                  { return _NatWin::getViewX(); }
    sint16    getViewY()                  { return _NatWin::getViewY(); }
    sint16    getViewW()                  {  return _NatWin::getViewW(); }
    sint16    getViewH()                  { return _NatWin::getViewH(); }
    void      setBorderless(bool s)       { _NatWin::setBorderless(s); }
    void      setMoveable(bool s)         { _NatWin::setMoveable(s); }
    void      setResizeable(bool s)       { _NatWin::setResizeable(s); }
    void      setCloseable(bool s)        { _NatWin::setCloseable(s); }
    bool      getBorderless()             { return _NatWin::getBorderless(); }
    bool      getMoveable()               { return _NatWin::getMoveable(); }
    bool      getResizeable()             { return _NatWin::getResizeable(); }
    bool      getCloseable()              { return _NatWin::getCloseable(); }

  public:
    DisplayWindow() : _NatWin() {}
    ~DisplayWindow() { close(); }
};

////////////////////////////////////////////////////////////////////////////////
//
//  DisplayScreen
//
////////////////////////////////////////////////////////////////////////////////

class DisplayScreen : public Display, private _NatScr {
  public:
    sint32    open(S_WHD, const char* title) {
      return _NatScr::open(w, h, d, title);
    }

    sint32    open(const D_PRP* p, const char* title) {
      return _NatScr::open(p, title);
    }

    sint32    reopen()                    { return _NatScr::reopen(); }
    void      close()                     { _NatScr::close(); }
    void      waitSync()                  { _NatScr::waitSync(); }
    void      refresh()                   { _NatScr::refresh(); }
    void      refresh(S_XYWH)             { _NatScr::refresh(x, y, w, h); }
    void      setTitle(const char* title) { _NatScr::setTitle(title); }
    Surface*  getDrawSurface()            { return _NatScr::getDrawSurface(); }
    const D_PRP* getProperties()          { return _NatScr::getProperties(); }

    // unique screen methods
  public:
    DisplayScreen() : _NatScr() {}
    ~DisplayScreen() { close(); }
};

////////////////////////////////////////////////////////////////////////////////
//
//  DisplayScreenBuffered
//
////////////////////////////////////////////////////////////////////////////////

class DisplayScreenBuffered : public Display, private _NatScrBuff {
  public:
    sint32    open(S_WHD, const char* title) {
      return _NatScrBuff::open(w, h, d, title);
    }

    sint32    open(const D_PRP* p, const char* title) {
      return _NatScrBuff::open(p, title);
    }

    sint32    reopen()                    { return _NatScrBuff::reopen(); }
    void      close()                     { _NatScrBuff::close(); }
    void      waitSync()                  { _NatScrBuff::waitSync(); }
    void      refresh()                   { _NatScrBuff::refresh(); }
    void      refresh(S_XYWH)             { _NatScrBuff::refresh(x, y, w, h); }
    void      setTitle(const char* title) { _NatScrBuff::setTitle(title); }
    Surface*  getDrawSurface()            { return _NatScrBuff::getDrawSurface(); }
    const D_PRP* getProperties()          { return _NatScrBuff::getProperties(); }

    // unique buffered screen methods
    void    setClone(bool s)              { _NatScrBuff::setClone(s); }
    bool    getClone()                    { return _NatScrBuff::getClone(); }
    bool    setNumBuffers(sint32 n)       { return _NatScrBuff::setNumBuffers(n); }
    sint32  getNumBuffers()               { return _NatScrBuff::getNumBuffers(); }

  public:
    DisplayScreenBuffered(sint32 n = 2, bool c = false) : _NatScrBuff(n, c) {}
    ~DisplayScreenBuffered() { close(); }
};

#endif
