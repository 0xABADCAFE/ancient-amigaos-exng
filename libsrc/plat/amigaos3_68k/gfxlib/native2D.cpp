//****************************************************************************//
//**                                                                        **//
//** File:         libsrc/plat/amigaos3_68k/gfxlib/native2d.cpp             **//
//** Description:  Native gfxlib class definitions                          **//
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

extern "C" {
  #include <stddef.h>
}

namespace X_SYSNAME {
  extern "C" {
    #include <cybergraphx/cybergraphics.h>
    #include <graphics/displayinfo.h>
  }
};

using namespace X_SYSNAME;

Library*        X_SYSNAME::CyberGfxBase  = 0;
struct GfxBase*  GfxBase                  = 0;

////////////////////////////////////////////////////////////////////////////////
/*
GfxLib::GfxLib()
{
  addResource(init, done, "gfxlib");
}
*/
sint32 GfxLib::init()
{
  // Open libraries...
  if (!(::GfxBase = (struct GfxBase*)OpenLibrary("graphics.library", 39))) {
    X_ERROR("GfxLib::init() Unable to open graphics.library, v39");
    return ERR_RSC_UNAVAILABLE;
  }
  CyberGfxBase = OpenLibrary("cybergraphics.library", 41);
  if (!CyberGfxBase) {
    X_ERROR("GfxLib::init() Unable to open cybergraphics.library, v41");
    return ERR_RSC_UNAVAILABLE;
  }

  // Construct DisplayProperties list, really an array :)
  return buildDisplayDataBase();
}

////////////////////////////////////////////////////////////////////////////////

void GfxLib::done()
{
  freeDisplayDataBase();
  if (CyberGfxBase) {
    CloseLibrary(CyberGfxBase);
    CyberGfxBase = 0;
  }
  if (::GfxBase) {
    CloseLibrary((Library*)::GfxBase);
    ::GfxBase = 0;
  }
}

////////////////////////////////////////////////////////////////////////////////

sint32 GfxLib::buildDisplayDataBase()
{
  MonitorInfo monInfo;
  List* cyberModeList = AllocCModeListTagList(0);
  if (!cyberModeList) {
    X_ERROR("GfxLib::buildDisplayDataBase() Unable to get cybergraphics display list");
    return ERR_RSC_UNAVAILABLE;
  }
  // count the number of modes present, add 1 for window mode
  size_t numModes = 0;
  Node* node;
  for (node = cyberModeList->lh_Head; node->ln_Succ; node = node->ln_Succ) {
    numModes++;
  }
  numModes++;

  if (!createModeDatabase(numModes)) {
    X_ERROR("GfxLib::buildDisplayDataBase() Unable to build display list");
    FreeCModeList(cyberModeList);
    return ERR_RSC_UNAVAILABLE;
  }
  if (!(_NatDisplay::modeID = (uint32*)Mem::alloc(numModes*sizeof(uint32)))) {
    X_ERROR("GfxLib::buildDisplayDataBase() Unable to build display mode ID table");
    FreeCModeList(cyberModeList);
    return ERR_RSC_UNAVAILABLE;
  }
  else {
    _NatDisplay::modeID[0] = 0;
    setPropertyFlags(0, D_PRP::WINDOWMODE);
    getWindowedLimits();
  }

  sint16 minW = DisplayProperties::getMinWidth();
  sint16 maxW = DisplayProperties::getMaxWidth();
  sint16 minH = DisplayProperties::getMinHeight();
  sint16 maxH = DisplayProperties::getMaxHeight();
  sint16 minD = DisplayProperties::getMinDepth();
  sint16 maxD = DisplayProperties::getMaxDepth();

  sint16 formats[Pixel::MAXHWTYPES] = {0};

  sint32 i = 1;
  for (node = cyberModeList->lh_Head; node->ln_Succ; node = node->ln_Succ, i++) {
    CyberModeNode* p = (CyberModeNode*)node;
    _NatDisplay::modeID[i] = p->DisplayID;
    setModeIndex(i, i);
    if (GetDisplayInfoData(0, (uint8*)&monInfo, sizeof(MonitorInfo), DTAG_MNTR,
        p->DisplayID) >= offsetof(MonitorInfo, TotalColorClocks) ) {
      uint32 hNano  = (280*(uint32)monInfo.TotalColorClocks);
      uint32 vMicro = (280*(uint32)monInfo.TotalColorClocks*(uint32)monInfo.TotalRows)/1000;
      setTiming(i, hNano, vMicro);
    }
    else {
      setTiming(i, 10000, 20000);
    }

    if (p->Width < minW) {
      minW = p->Width;
    }
    else if (p->Width > maxW) {
      maxW = p->Width;
    }

    if (p->Height < minH) {
      minH = p->Height;
    }
    else if (p->Height > maxH) {
      maxH = p->Height;
    }

    if (p->Depth < minD) {
      minD = p->Depth;
    }
    else if (p->Height > maxD) {
      maxD = p->Depth;
    }

    Pixel::HWType pixFmt = _Nat2D::getHardwareFormat(GetCyberIDAttr(CYBRIDATTR_PIXFMT, p->DisplayID));

    formats[pixFmt]++;

    setDimension(i, p->Width, p->Height);
    setPropertyFlags(i, 0xFFFF);
    setFormat(i, pixFmt, (P_D)p->Depth);
    setName(i, p->ModeText);
  }
  FreeCModeList(cyberModeList);
  setLimits(minW, maxW, minH, maxH, minD, maxD);

  // set the preferred pixel formats to match the ones detected in the system displays.
  // for amiga, always prefer big endian if possible.

/*
  if ((formats[Pixel::BGR15B]>formats[Pixel::RGB15B) || (formats[Pixel::BGR15L]>formats[Pixel::RGB15L)) {
    // BGR preferred?
    if (formats[Pixel::BGR15L]>formats[Pixel::BGR15B]) {
      PixelProvider::setPrefFormat(Pixel::BPP15, Pixel::BGR15L);
    }
  }
  else {
*/
    // RGB preferred?
    if (formats[Pixel::RGB15L]>formats[Pixel::RGB15B]) {
      // little endian?
      PixelProvider::setPrefFormat(Pixel::BPP15, Pixel::RGB15L);
    }
/*
  }

  if ((formats[Pixel::BGR16B]>formats[Pixel::RGB16B) || (formats[Pixel::BGR16L]>formats[Pixel::RGB16L)) {
    // BGR preferred?
    if (formats[Pixel::RGB16L]>formats[Pixel::RGB16B]) {
      // little endian?
      PixelProvider::setPrefFormat(Pixel::BPP16, Pixel::RGB16L);
    }
  }
  else {
*/
    // RGB preferred?
    if (formats[Pixel::RGB16L]>formats[Pixel::RGB16B]) {
      // little endian?
      PixelProvider::setPrefFormat(Pixel::BPP16, Pixel::RGB16L);
    }
/*
  }

  if ((formats[Pixel::ABGR32B]>formats[Pixel::ARGB32B) || (formats[Pixel::ABGR32L]>formats[Pixel::ARGB32L)) {
    // ABGR preferred?
    if (formats[Pixel::ARGB32L]>formats[Pixel::ARGB32B]) {
      // little endian?
      PixelProvider::setPrefFormat(Pixel::BPP32, Pixel::ABGR32L);
    }
  }
  else {
*/
    // ARGB preferred?
    if (formats[Pixel::ARGB32L]>formats[Pixel::ARGB32B]) {
      // little endian?
      PixelProvider::setPrefFormat(Pixel::BPP32, Pixel::ARGB32L);
    }
/*
  }
*/
  return OK;
}

////////////////////////////////////////////////////////////////////////////////

void GfxLib::freeDisplayDataBase()
{
  // release the DisplayProperties list
  freeModeDatabase();
  Mem::free(_NatDisplay::modeID);
  _NatDisplay::modeID = 0;
}

////////////////////////////////////////////////////////////////////////////////

sint32 GfxLib::getWindowedLimits()
{
  if (!_NatDisplay::modeID) {
    return ERR_RSC_UNAVAILABLE;
  }
  // mode zero is a reference for windowed mode
  MonitorInfo monInfo;
  Screen* s;
  if (s = LockPubScreen(0)) {
    uint32 workbenchModeId = GetVPModeID(&(s->ViewPort));

    if (GetDisplayInfoData(0, (uint8*)&monInfo, sizeof(MonitorInfo), DTAG_MNTR,
        workbenchModeId) >= offsetof(MonitorInfo, TotalColorClocks) ) {
      uint32 hNano  = (280*(uint32)monInfo.TotalColorClocks);
      uint32 vMicro = (280*(uint32)monInfo.TotalColorClocks*(uint32)monInfo.TotalRows)/1000;
      setTiming(0, hNano, vMicro);
    }
    else {
      setTiming(0, 10000, 20000);
    }
    if (GetCyberMapAttr(s->RastPort.BitMap, CYBRMATTR_ISCYBERGFX)) {
      sint16 w = GetCyberMapAttr(s->RastPort.BitMap, CYBRMATTR_WIDTH);
      sint16 h = GetCyberMapAttr(s->RastPort.BitMap, CYBRMATTR_HEIGHT);
      P_D d = (P_D)GetCyberMapAttr(s->RastPort.BitMap, CYBRMATTR_DEPTH);
      P_F f = _Nat2D::getHardwareFormat(GetCyberMapAttr(s->RastPort.BitMap, CYBRMATTR_PIXFMT));
      setDimension(0, w, h);
      setFormat(0, f, d);
      UnlockPubScreen(0, s);
      return OK;
    }
    return ERR_RSC_INVALID;
  }
  return ERR_RSC_UNAVAILABLE;
}

//GfxLib _gfxLib = GfxLib();

////////////////////////////////////////////////////////////////////////////////
//
//  _Nat2D
//
////////////////////////////////////////////////////////////////////////////////

uint32 _Nat2D::abstractToNative[Pixel::MAXHWTYPES] = {
  // Maps abstract hardware types to CGX native types
  PIXFMT_LUT8,      // INDEX8
  PIXFMT_RGB15,      // RGB15B
  PIXFMT_BGR15,      // BGR15B
  PIXFMT_RGB15PC,    // RGB15L
  PIXFMT_BGR15PC,    // BGR15L
  PIXFMT_RGB16,      // RGB16B
  PIXFMT_BGR16,      // BGR15L
  PIXFMT_RGB16PC,    // RGB16L
  PIXFMT_BGR16PC,    // BGR16L
  PIXFMT_RGB24,      // RGB24P
  PIXFMT_BGR24,      // BGR24P
  PIXFMT_ARGB32,    // ARGB32B
  PIXFMT_ARGB32,    // ABGR32B - unsupported in cgx?
  PIXFMT_BGRA32,    // ARGB32L
  PIXFMT_RGBA32      // ABGR32L
};

P_F _Nat2D::nativeToAbstract[] = {
  // Maps CGX native types to the abstract hardware types
  Pixel::INDEX8,    // PIXFMT_LUT8    (0UL)
  Pixel::RGB15B,    // PIXFMT_RGB15    (1UL)
  Pixel::BGR15B,    // PIXFMT_BGR15    (2UL)
  Pixel::RGB16L,    // PIXFMT_RGB15PC  (3UL)
  Pixel::BGR15L,    // PIXFMT_BGR15PC  (4UL)
  Pixel::RGB16B,    // PIXFMT_RGB16    (5UL)
  Pixel::BGR16B,    // PIXFMT_BGR16    (6UL)
  Pixel::RGB16L,    // PIXFMT_RGB16PC  (7UL)
  Pixel::BGR16L,    // PIXFMT_BGR16PC  (8UL)
  Pixel::RGB24P,    // PIXFMT_RGB24    (9UL)
  Pixel::BGR24P,    // PIXFMT_BGR24    (10UL)
  Pixel::ARGB32B,    // PIXFMT_ARGB32  (11UL)
  Pixel::ARGB32L,    // PIXFMT_BGRA32  (12UL)
  Pixel::ABGR32L    // PIXFMT_RGBA32  (13UL)
};


////////////////////////////////////////////////////////////////////////////////
/*
P_F _Nat2D::getHardwareFormat(P_T t)
{ // convert Pixel::Type to Pixel::HWType
  static P_F map[] = {
    Pixel::INDEX8,  // CLUT8
    Pixel::INDEX8,  // GREY8
    Pixel::INDEX8,  // RGB8
    Pixel::RGB15B,  // RGB15
    Pixel::RGB16B,  // RGB16
    Pixel::RGB24P,  // RGB24
    Pixel::ARGB32B  // ARGB32
  };
  return map[t];
}
*/
////////////////////////////////////////////////////////////////////////////////

sint32 _Nat2D::convertPixels(PXCONV, Palette* sPal)
{
  convTab[sf][df](d, s, (uint32*)(sPal->getTable()), w, h, ds, ss);
  return OK;
}

////////////////////////////////////////////////////////////////////////////////

void _Nat2D::none(PXARG)
{
}

////////////////////////////////////////////////////////////////////////////////

void _Nat2D::copy8(PXARG)
{
  if (dst==src) {
    return;
  }
  h++;
  while(--h) {
    Mem::copy(dst, src, w);
    ((uint16*)dst)+=dSpan;
    ((uint16*)src)+=sSpan;
  }
}

////////////////////////////////////////////////////////////////////////////////
//
//  INDEX8 to other format
//
////////////////////////////////////////////////////////////////////////////////

#define P00    &_Nat2D::copy8
#define P01    &_Pix8::convRGB15BE
#define P02    &_Pix8::convBGR15BE
#define P03    &_Pix8::convRGB15LE
#define P04    &_Pix8::convBGR15LE
#define P05    &_Pix8::convRGB16BE
#define P06    &_Pix8::convBGR16BE
#define P07    &_Pix8::convRGB16LE
#define P08    &_Pix8::convBGR16LE
#define P09    &_Pix8::convRGB24
#define P0A    &_Pix8::convBGR24
#define P0B    &_Pix8::convARGB32BE
#define P0C    &_Pix8::convABGR32BE
#define P0D    &_Pix8::convARGB32LE
#define P0E    &_Pix8::convABGR32LE

////////////////////////////////////////////////////////////////////////////////
//
//  Pix15
//
////////////////////////////////////////////////////////////////////////////////

//  RGB15B to other format
#define P10    &_Nat2D::none                  // RGB15B -> INDEX8
#define P11    &_Pix15::copy15XETo15XE        // RGB15B -> RGB15B
#define P12    &_Pix15::rotate15BETo15BE      // RGB15B -> BGR15B
#define P13    &_Pix15::copy15XETo15YE        // RGB15B -> RGB15L
#define P14    &_Pix15::rotate15BETo15LE      // RGB15B -> BGR15L
#define P15    &_Pix15::copy15BETo16BE        // RGB15B -> RGB16B
#define P16    &_Pix15::rotate15BETo16BE      // RGB15B -> BGR16B
#define P17    &_Pix15::copy15BETo16LE        // RGB15B -> RGB16L
#define P18    &_Pix15::rotate15BETo16LE      // RGB15B -> BGR16L
#define P19    &_Pix15::copy15BETo24XGY      // RGB15B -> RGB24
#define P1A    &_Pix15::rotate15BETo24XGY    // RGB15B -> BGR24
#define P1B    &_Pix15::copy15BETo32BE        // RGB15B -> ARGB32B
#define P1C    &_Pix15::rotate15BETo32BE      // RGB15B -> ABGR32B
#define P1D    &_Pix15::copy15BETo32LE        // RGB15B -> ARGB32L
#define P1E    &_Pix15::rotate15BETo32LE      // RGB15B -> ABGR32L

// BGR15B to other format
#define P20    &_Nat2D::none                  // BGR15B -> INDEX8
#define P21    &_Pix15::rotate15BETo15BE      // BGR15B -> RGB15B
#define P22    &_Pix15::copy15XETo15XE        // BGR15B -> BGR15B
#define P23    &_Pix15::rotate15BETo15LE      // BGR15B -> RGB15L
#define P24    &_Pix15::copy15XETo15YE        // BGR15B -> BGR15L
#define P25    &_Pix15::rotate15BETo16BE      // BGR15B -> RGB16B
#define P26    &_Pix15::copy15BETo16BE        // BGR15B -> BGR16B
#define P27    &_Pix15::rotate15BETo16LE      // BGR15B -> RGB16L
#define P28    &_Pix15::copy15BETo16LE        // BGR15B -> BGR16L
#define P29    &_Pix15::rotate15BETo24XGY    // BGR15B -> RGB24
#define P2A    &_Pix15::copy15BETo24XGY      // BGR15B -> BGR24
#define P2B    &_Pix15::rotate15BETo32BE      // BGR15B -> ARGB32B
#define P2C    &_Pix15::copy15BETo32BE        // BGR15B -> ABGR32B
#define P2D    &_Pix15::rotate15BETo32LE      // BGR15B -> ARGB32L
#define P2E    &_Pix15::copy15BETo32LE        // BGR15B -> ABGR32L

// RGB15L to other format
#define P30    &_Nat2D::none                  // RGB15L -> INDEX8
#define P31    &_Pix15::copy15XETo15YE        // RGB15L -> RGB15B
#define P32    &_Pix15::rotate15LETo15BE      // RGB15L -> BGR15B
#define P33    &_Pix15::copy15XETo15XE        // RGB15L -> RGB15L
#define P34    &_Pix15::rotate15LETo15LE      // RGB15L -> BGR15L
#define P35    &_Pix15::copy15LETo16BE        // RGB15L -> RGB16B
#define P36    &_Pix15::rotate15LETo16BE      // RGB15L -> BGR16B
#define P37    &_Pix15::copy15LETo16LE        // RGB15L -> RGB16L
#define P38    &_Pix15::rotate15LETo16LE      // RGB15L -> BGR16L
#define P39    &_Pix15::copy15LETo24XGY      // RGB15L -> RGB24
#define P3A    &_Pix15::rotate15LETo24XGY    // RGB15L -> BGR24
#define P3B    &_Pix15::copy15LETo32BE        // RGB15L -> ARGB32B
#define P3C    &_Pix15::rotate15LETo32BE      // RGB15L -> ABGR32B
#define P3D    &_Pix15::copy15LETo32LE        // RGB15L -> ARGB32L
#define P3E    &_Pix15::rotate15LETo32LE      // RGB15L -> ABGR32L

// BGR15L to other format
#define P40    &_Nat2D::none                  // BGR15L -> INDEX8
#define P41    &_Pix15::rotate15LETo15BE      // BGR15L -> RGB15B
#define P42    &_Pix15::copy15XETo15YE        // BGR15L -> BGR15B
#define P43    &_Pix15::rotate15LETo15LE      // BGR15L -> RGB15L
#define P44    &_Pix15::copy15XETo15XE        // BGR15L -> BGR15L
#define P45    &_Pix15::rotate15LETo16BE      // BGR15L -> RGB16B
#define P46    &_Pix15::copy15LETo16BE        // BGR15L -> BGR16B
#define P47    &_Pix15::rotate15LETo16LE      // BGR15L -> RGB16L
#define P48    &_Pix15::copy15LETo16LE        // BGR15L -> BGR16L
#define P49    &_Pix15::rotate15LETo24XGY    // BGR15L -> RGB24
#define P4A    &_Pix15::copy15LETo24XGY      // BGR15L -> BGR24
#define P4B    &_Pix15::rotate15LETo32BE      // BGR15L -> ARGB32B
#define P4C    &_Pix15::copy15LETo32BE        // BGR15L -> ABGR32B
#define P4D    &_Pix15::rotate15LETo32LE      // BGR15L -> ARGB32L
#define P4E    &_Pix15::copy15LETo32LE        // BGR15L -> ABGR32L


////////////////////////////////////////////////////////////////////////////////
//
//  Pix16
//
////////////////////////////////////////////////////////////////////////////////

// RGB16B to other format
#define P50    &_Nat2D::none                  // RGB16B -> INDEX8
#define P51    &_Pix16::copy16BETo15BE        // RGB16B -> RGB15B
#define P52    &_Pix16::rotate16BETo15BE      // RGB16B -> BGR15B
#define P53    &_Pix16::copy16BETo15LE        // RGB16B -> RGB15L
#define P54    &_Pix16::rotate16BETo15LE      // RGB16B -> BGR15L
#define P55    &_Pix16::copy16XETo16XE        // RGB16B -> RGB16B
#define P56    &_Pix16::rotate16BETo16BE      // RGB16B -> BGR16B
#define P57    &_Pix16::copy16XETo16YE        // RGB16B -> RGB16L
#define P58    &_Pix16::rotate16BETo16LE      // RGB16B -> BGR16L
#define P59    &_Pix16::copy16BETo24XGY      // RGB16B -> RGB24
#define P5A    &_Pix16::rotate16BETo24XGY    // RGB16B -> BGR24
#define P5B    &_Pix16::copy16BETo32BE        // RGB16B -> ARGB32B
#define P5C    &_Pix16::rotate16BETo32BE      // RGB16B -> ABGR32B
#define P5D    &_Pix16::copy16BETo32LE        // RGB16B -> ARGB32L
#define P5E    &_Pix16::rotate16BETo32LE      // RGB16B -> ABGR32L

// BGR16B to other format
#define P60    &_Nat2D::none                  // BGR16B -> INEDX8
#define P61    &_Pix16::rotate16BETo15BE      // BGR16B -> RGB15B
#define P62    &_Pix16::copy16BETo15BE        // BGR16B -> BGR15B
#define P63    &_Pix16::rotate16BETo15LE      // BGR16B -> RGB15L
#define P64    &_Pix16::copy16BETo15LE        // BGR16B -> BGR15L
#define P65    &_Pix16::rotate16BETo16BE      // BGR16B -> RGB16B
#define P66    &_Pix16::copy16XETo16XE        // BGR16B -> BGR16B
#define P67    &_Pix16::rotate16BETo16LE      // BGR16B -> RGB16L
#define P68    &_Pix16::copy16XETo16YE        // BGR16B -> BGR16L
#define P69    &_Pix16::rotate16BETo24XGY    // BGR16B -> RGB24
#define P6A    &_Pix16::copy16BETo24XGY      // BGR16B -> BGR24
#define P6B    &_Pix16::rotate16BETo32BE      // BGR16B -> ARGB32B
#define P6C    &_Pix16::copy16BETo32BE        // BGR16B -> ABGR32B
#define P6D    &_Pix16::rotate16BETo32LE      // BGR16B -> ARGB32L
#define P6E    &_Pix16::copy16BETo32LE        // BGR16B -> ABGR32L

// RGB16L to other format
#define P70    &_Nat2D::none                  // RGB16L -> INDEX8
#define P71    &_Pix16::copy16LETo15BE        // RGB16L -> RGB15B
#define P72    &_Pix16::rotate16LETo15BE      // RGB16L -> BGR15B
#define P73    &_Pix16::copy16LETo15LE        // RGB16L -> RGB15L
#define P74    &_Pix16::rotate16LETo15LE      // RGB16L -> BGR15L
#define P75    &_Pix16::copy16XETo16YE        // RGB16L -> RGB16B
#define P76    &_Pix16::rotate16LETo16BE      // RGB16L -> BGR16B
#define P77    &_Pix16::copy16XETo16XE        // RGB16L -> RGB16L
#define P78    &_Pix16::rotate16LETo16LE      // RGB16L -> BGR16L
#define P79    &_Pix16::copy16LETo24XGY      // RGB16L -> RGB24
#define P7A    &_Pix16::rotate16LETo24XGY    // RGB16L -> BGR24
#define P7B    &_Pix16::copy16LETo32BE        // RGB16L -> ARGB32B
#define P7C    &_Pix16::rotate16LETo32BE      // RGB16L -> ABGR32B
#define P7D    &_Pix16::copy16LETo32LE        // RGB16L -> ARGB32L
#define P7E    &_Pix16::rotate16LETo32LE      // RGB16L -> ABGR32L

// BGR16L to other format
#define P80    &_Nat2D::none                  // BGR16L -> INDEX8
#define P81    &_Pix16::rotate16LETo15BE      // BGR16L -> RGB15B
#define P82    &_Pix16::copy16LETo15BE        // BGR16L -> BGR15B
#define P83    &_Pix16::rotate16LETo15LE      // BGR16L -> RGB15L
#define P84    &_Pix16::copy16LETo15LE        // BGR16L -> BGR15L
#define P85    &_Pix16::rotate16LETo16BE      // BGR16L -> RGB16B
#define P86    &_Pix16::copy16XETo16YE        // BGR16L -> BGR16B
#define P87    &_Pix16::rotate16LETo16LE      // BGR16L -> RGB16L
#define P88    &_Pix16::copy16XETo16XE        // BGR16L -> BGR16L
#define P89    &_Pix16::rotate16LETo24XGY    // BGR16L -> RGB24
#define P8A    &_Pix16::copy16LETo24XGY      // BGR16L -> BGR24
#define P8B    &_Pix16::rotate16LETo32BE      // BGR16L -> ARGB32B
#define P8C    &_Pix16::copy16LETo32BE        // BGR16L -> ABGR32B
#define P8D    &_Pix16::rotate16LETo32LE      // BGR16L -> ARGB32L
#define P8E    &_Pix16::copy16LETo32LE        // BGR16L -> ABGR32L


////////////////////////////////////////////////////////////////////////////////
//
//  Pix24
//
////////////////////////////////////////////////////////////////////////////////

// RGB24 to other format
#define P90    &_Nat2D::none                    // RGB24  -> INDEX8
#define P91    &_Pix24::copy24XGYTo15BE        // RGB24  -> RGB15B
#define P92    &_Pix24::rotate24XGYTo15BE      // RGB24  -> BGR15B
#define P93    &_Pix24::copy24XGYTo15LE        // RGB24  -> RGB15L
#define P94    &_Pix24::rotate24XGYTo15LE      // RGB24  -> BGR15L
#define P95    &_Pix24::copy24XGYTo16BE        // RGB24  -> RGB16B
#define P96    &_Pix24::rotate24XGYTo16BE      // RGB24  -> BGR16B
#define P97    &_Pix24::copy24XGYTo16LE        // RGB24  -> RGB16L
#define P98    &_Pix24::rotate24XGYTo16LE      // RGB24  -> BGR16L
#define P99    &_Pix24::copy24To24              // RGB24  -> RGB24
#define P9A    &_Pix24::rotate24To24            // RGB24  -> BGR24
#define P9B    &_Pix24::copy24XGYTo32BE        // RGB24  -> ARGB32B
#define P9C    &_Pix24::rotate24XGYTo32BE      // RGB24  -> ABGR32B
#define P9D    &_Pix24::copy24XGYTo32LE        // RGB24  -> ARGB32L
#define P9E    &_Pix24::rotate24XGYTo32LE      // RGB24  -> ABGR32L

// BGR24 to other format
#define PA0    &_Nat2D::none                    // BGR24  -> INDEX8
#define PA1    &_Pix24::rotate24XGYTo15BE      // BGR24  -> RGB15B
#define PA2    &_Pix24::copy24XGYTo15BE        // BGR24  -> BGR15B
#define PA3    &_Pix24::rotate24XGYTo15LE      // BGR24  -> RGB15L
#define PA4    &_Pix24::copy24XGYTo15LE        // BGR24  -> BGR15L
#define PA5    &_Pix24::rotate24XGYTo16BE      // BGR24  -> RGB16B
#define PA6    &_Pix24::copy24XGYTo16BE        // BGR24  -> BGR16B
#define PA7    &_Pix24::rotate24XGYTo16LE      // BGR24  -> RGB16L
#define PA8    &_Pix24::copy24XGYTo16LE        // BGR24  -> BGR16L
#define PA9    &_Pix24::rotate24To24            // BGR24  -> RGB24
#define PAA    &_Pix24::copy24To24              // BGR24  -> BGR24
#define PAB    &_Pix24::rotate24XGYTo32BE      // BGR24  -> ARGB32B
#define PAC    &_Pix24::copy24XGYTo32BE        // BGR24  -> ABGR32B
#define PAD    &_Pix24::rotate24XGYTo32LE      // BGR24  -> ARGB32L
#define PAE    &_Pix24::copy24XGYTo32LE        // BGR24  -> ABGR32L


////////////////////////////////////////////////////////////////////////////////
//
//  Pix32
//
////////////////////////////////////////////////////////////////////////////////

// ARGB32B to other format
#define PB0    &_Nat2D::none                  // ARGB32B -> INDEX8
#define PB1    &_Pix32::copy32BETo15BE        // ARGB32B -> RGB15B
#define PB2    &_Pix32::rotate32BETo15BE      // ARGB32B -> BGR15B
#define PB3    &_Pix32::copy32BETo15LE        // ARGB32B -> RGB15L
#define PB4    &_Pix32::rotate32BETo15LE      // ARGB32B -> BGR15L
#define PB5    &_Pix32::copy32BETo16BE        // ARGB32B -> RGB16B
#define PB6    &_Pix32::rotate32BETo16BE      // ARGB32B -> BGR16B
#define PB7    &_Pix32::copy32BETo16LE        // ARGB32B -> RGB16L
#define PB8    &_Pix32::rotate32BETo16LE      // ARGB32B -> BGR16L
#define PB9    &_Pix32::copy32BETo24XGY      // ARGB32B -> RGB24
#define PBA    &_Pix32::rotate32BETo24XGY    // ARGB32B -> BGR24
#define PBB    &_Pix32::copy32XETo32XE        // ARGB32B -> ARGB32B
#define PBC    &_Pix32::rotate32BETo32BE      // ARGB32B -> ABGR32B
#define PBD    &_Pix32::copy32XETo32YE        // ARGB32B -> ARGB32L
#define PBE    &_Pix32::rotate32BETo32LE      // ARGB32B -> ABGR32L

// ABGR32B to other format
#define PC0    &_Nat2D::none                  // ABGR32B -> INEDX8
#define PC1    &_Pix32::rotate32BETo15BE      // ABGR32B -> RGB15B
#define PC2    &_Pix32::copy32BETo15BE        // ABGR32B -> BGR15B
#define PC3    &_Pix32::rotate32BETo15LE      // ABGR32B -> RGB15L
#define PC4    &_Pix32::copy32BETo15LE        // ABGR32B -> BGR15L
#define PC5    &_Pix32::rotate32BETo16BE      // ABGR32B -> RGB16B
#define PC6    &_Pix32::copy32BETo16BE        // ABGR32B -> BGR16B
#define PC7    &_Pix32::rotate32BETo16LE      // ABGR32B -> RGB16L
#define PC8    &_Pix32::copy32BETo16LE        // ABGR32B -> BGR16L
#define PC9    &_Pix32::rotate32BETo24XGY    // ABGR32B -> RGB24
#define PCA    &_Pix32::copy32BETo24XGY      // ABGR32B -> BGR24
#define PCB    &_Pix32::rotate32BETo32BE      // ABGR32B -> ARGB32B
#define PCC    &_Pix32::copy32XETo32XE        // ABGR32B -> ABGR32B
#define PCD    &_Pix32::rotate32BETo32LE      // ABGR32B -> ARGB32L
#define PCE    &_Pix32::copy32XETo32YE        // ABGR32B -> ABGR32L

// ARGB32L to other format
#define PD0    &_Nat2D::none                  // ARGB32L -> INDEX8
#define PD1    &_Pix32::copy32LETo15BE        // ARGB32L -> RGB15B
#define PD2    &_Pix32::rotate32LETo15BE      // ARGB32L -> BGR15B
#define PD3    &_Pix32::copy32LETo15LE        // ARGB32L -> RGB15L
#define PD4    &_Pix32::rotate32LETo15LE      // ARGB32L -> BGR15L
#define PD5    &_Pix32::copy32LETo16BE        // ARGB32L -> RGB16B
#define PD6    &_Pix32::rotate32LETo16BE      // ARGB32L -> BGR16B
#define PD7    &_Pix32::copy32LETo16LE        // ARGB32L -> RGB16L
#define PD8    &_Pix32::rotate32LETo16LE      // ARGB32L -> BGR16L
#define PD9    &_Pix32::copy32LETo24XGY      // ARGB32L -> RGB24
#define PDA    &_Pix32::rotate32LETo24XGY    // ARGB32L -> BGR24
#define PDB    &_Pix32::copy32XETo32YE        // ARGB32L -> ARGB32B
#define PDC    &_Pix32::rotate32LETo32BE      // ARGB32L -> ABGR32B
#define PDD    &_Pix32::copy32XETo32XE        // ARGB32L -> ARGB32L
#define PDE    &_Pix32::rotate32LETo32LE      // ARGB32L -> ABGR32L


// ABGR32L to other format
#define PE0    &_Nat2D::none                  // ABGR32L -> INDEX8
#define PE1    &_Pix32::rotate32LETo15BE      // ABGR32L -> RGB15B
#define PE2    &_Pix32::copy32LETo15BE        // ABGR32L -> BGR15B
#define PE3    &_Pix32::rotate32LETo15LE      // ABGR32L -> RGB15L
#define PE4    &_Pix32::copy32LETo15LE        // ABGR32L -> BGR15L
#define PE5    &_Pix32::rotate32LETo16BE      // ABGR32L -> RGB16B
#define PE6    &_Pix32::copy32LETo16BE        // ABGR32L -> BGR16B
#define PE7    &_Pix32::rotate32LETo16LE      // ABGR32L -> RGB16L
#define PE8    &_Pix32::copy32LETo16LE        // ABGR32L -> BGR16L
#define PE9    &_Pix32::rotate32LETo24XGY    // ABGR32L -> RGB24
#define PEA    &_Pix32::copy32LETo24XGY      // ABGR32L -> BGR24
#define PEB    &_Pix32::rotate32LETo32BE      // ABGR32L -> ARGB32B
#define PEC    &_Pix32::copy32XETo32YE        // ABGR32L -> ABGR32B
#define PED    &_Pix32::rotate32LETo32LE      // ABGR32L -> ARGB32L
#define PEE    &_Pix32::copy32XETo32XE        // ABGR32L -> ABGR32L

// Row is source pixel format, column is destination pixel format

_Nat2D::PixConv _Nat2D::convTab[Pixel::MAXHWTYPES][Pixel::MAXHWTYPES] = {
// INDEX8  RGB15B  BGR15B  RGB15L  BGR15L  RGB16B  BGR16B  RGB16L  BGR16L  RGB24  BGR24    ARGB32B  ABGR32B  ARGB32L  ABGR32L
  {P00,    P01,    P02,    P03,    P04,    P05,    P06,    P07,    P08,    P09,  P0A,    P0B,    P0C,    P0D,    P0E},  // INDEX8
  {P10,    P11,    P12,    P13,    P14,    P15,    P16,    P17,    P18,    P19,  P1A,    P1B,    P1C,    P1D,    P1E},  // RGB15B
  {P20,    P21,    P22,    P23,    P24,    P25,    P26,    P27,    P28,    P29,  P2A,    P2B,    P2C,    P2D,    P2E},  // BGR15B
  {P30,    P31,    P32,    P33,    P34,    P35,    P36,    P37,    P38,    P39,  P3A,    P3B,    P3C,    P3D,    P3E},  // RGB15L
  {P40,    P41,    P42,    P43,    P44,    P45,    P46,    P47,    P48,    P49,  P4A,    P4B,    P4C,    P4D,    P4E},  // BGR15L
  {P50,    P51,    P52,    P53,    P54,    P55,    P56,    P57,    P58,    P59,  P5A,    P5B,    P5C,    P5D,    P5E},  // RGB16B
  {P60,    P61,    P62,    P63,    P64,    P65,    P66,    P67,    P68,    P69,  P6A,    P6B,    P6C,    P6D,    P6E},  // BGR16B
  {P70,    P71,    P72,    P73,    P74,    P75,    P76,    P77,    P78,    P79,  P7A,    P7B,    P7C,    P7D,    P7E},  // RGB16L
  {P80,    P81,    P82,    P83,    P84,    P85,    P86,    P87,    P88,    P89,  P8A,    P8B,    P8C,    P8D,    P8E},  // BGR16L
  {P90,    P91,    P92,    P93,    P94,    P95,    P96,    P97,    P98,    P99,  P9A,    P9B,    P9C,    P9D,    P9E},  // RGB24
  {PA0,    PA1,    PA2,    PA3,    PA4,    PA5,    PA6,    PA7,    PA8,    PA9,  PAA,    PAB,    PAC,    PAD,    PAE},  // BGR24
  {PB0,    PB1,    PB2,    PB3,    PB4,    PB5,    PB6,    PB7,    PB8,    PB9,  PBA,    PBB,    PBC,    PBD,    PBE},  // ARGB32B
  {PC0,    PC1,    PC2,    PC3,    PC4,    PC5,    PC6,    PC7,    PC8,    PC9,  PCA,    PCB,    PCC,    PCD,    PCE},  // ABGR32B
  {PD0,    PD1,    PD2,    PD3,    PD4,    PD5,    PD6,    PD7,    PD8,    PD9,  PDA,    PDB,    PDC,    PDD,    PDE},  // ARGB32L
  {PE0,    PE1,    PE2,    PE3,    PE4,    PE5,    PE6,    PE7,    PE8,    PE9,  PEA,    PEB,    PEC,    PED,    PEE},  // ABGR32L
};

