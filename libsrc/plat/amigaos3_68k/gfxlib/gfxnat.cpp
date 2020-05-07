//****************************************************************************//
//**                                                                        **//
//** File:         libsrc/plat/amigaos368k/GfxLib/gfx.cpp                   **//
//** Description:  GfxLib graphics definitions                              **//
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

#include <GfxLib/gfx.hpp>

extern "C" {
  #include <graphics/displayinfo.h>
  #include <stddef.h>
}

GFXBASE  *GfxBase        = 0;
LIBRARY  *CyberGfxBase    = 0;

////////////////////////////////////////////////////////////////////////////////

sint32 GfxLib::init()
{
  // Open libraries...
  GfxBase = (GFXBASE*)OpenLibrary("graphics.library", 39);
  if (!GfxBase)
  {
    X_ERROR("GfxLib::init() Unable to open graphics.library, v39");
    return ERR_RSC_UNAVAILABLE;
  }
  CyberGfxBase = OpenLibrary("cybergraphics.library", 41);
  if (!CyberGfxBase)
  {
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
  // Close ze libraries
  if (CyberGfxBase)
  {
    CloseLibrary(CyberGfxBase);
    CyberGfxBase = 0;
  }
  if (GfxBase)
  {
    CloseLibrary((LIBRARY*)GfxBase);
    GfxBase = 0;
  }
}

////////////////////////////////////////////////////////////////////////////////

sint32 GfxLib::buildDisplayDataBase()
{
  MonitorInfo monInfo;
  List* cyberModeList = AllocCModeListTagList(0);
  if (!cyberModeList)
  {
    X_ERROR("GfxLib::buildDisplayDataBase() Unable to get cybergraphics display list");
    return ERR_RSC_UNAVAILABLE;
  }
  // count the number of modes present, add 1 for window mode
  size_t numModes = 0;
  Node* node;
  for (node = cyberModeList->lh_Head; node->ln_Succ; node = node->ln_Succ)
    numModes++;
  numModes++;
  if (!createModeDatabase(numModes))
  {
    X_ERROR("GfxLib::buildDisplayDataBase() Unable to build display list");
    FreeCModeList(cyberModeList);
    return ERR_RSC_UNAVAILABLE;
  }
  if (!(DisplayNative::modeID = new uint32[numModes]))
  {
    X_ERROR("GfxLib::buildDisplayDataBase() Unable to build display mode ID table");
    FreeCModeList(cyberModeList);
    return ERR_RSC_UNAVAILABLE;
  }
  else
  {
    DisplayNative::modeID[0] = 0;
    setPropertyFlags(0, D_PRP::WINDOWMODE);
    setTiming(0, 10000, 20000);
    getWindowedLimits();
  }

  sint32 i = 1;
  for (node = cyberModeList->lh_Head; node->ln_Succ; node = node->ln_Succ, i++)
  {
    CyberModeNode* p = (CyberModeNode*)node;
    DisplayNative::modeID[i] = p->DisplayID;
    setModeIndex(i, i);
    if (GetDisplayInfoData(0, (uint8*)&monInfo, sizeof(MonitorInfo), DTAG_MNTR,
        p->DisplayID) >= offsetof(MonitorInfo, TotalColorClocks) )
    {
      uint32 hNano  = (280*(uint32)monInfo.TotalColorClocks);
      uint32 vMicro = (280*(uint32)monInfo.TotalColorClocks*(uint32)monInfo.TotalRows)/1000;
      setTiming(i, hNano, vMicro);
    }
    else
      setTiming(i, 1, 20000);
    setDimension(i, p->Width, p->Height);
    setPropertyFlags(i, 0xFFFF);
    setFormat(i, (P_F)GetCyberIDAttr(CYBRIDATTR_PIXFMT, p->DisplayID),
              (P_D)p->Depth);
    setName(i, p->ModeText);
  }
  FreeCModeList(cyberModeList);
  return OK;
}

////////////////////////////////////////////////////////////////////////////////

void GfxLib::freeDisplayDataBase()
{
  // release the DisplayProperties list
  freeModeDatabase();
  delete DisplayNative::modeID;
  DisplayNative::modeID = 0;
}

////////////////////////////////////////////////////////////////////////////////

sint32 GfxLib::getWindowedLimits()
{
  if (!DisplayNative::modeID)
    return ERR_RSC_UNAVAILABLE;
  // mode zero is a reference for windowed mode
  Screen* s;
  if (s = LockPubScreen(0))
  {
    if (GetCyberMapAttr(s->RastPort.BitMap, CYBRMATTR_ISCYBERGFX))
    {
      sint16 w = GetCyberMapAttr(s->RastPort.BitMap, CYBRMATTR_WIDTH);
      sint16 h = GetCyberMapAttr(s->RastPort.BitMap, CYBRMATTR_HEIGHT);
      P_D d = (P_D)GetCyberMapAttr(s->RastPort.BitMap, CYBRMATTR_DEPTH);
      P_F f = (P_F)GetCyberMapAttr(s->RastPort.BitMap, CYBRMATTR_PIXFMT);
      setDimension(0, w, h);
      setFormat(0, f, d);
      UnlockPubScreen(0, s);
      return OK;
    }
    return ERR_RSC_INVALID;
  }
  return ERR_RSC_UNAVAILABLE;
}

////////////////////////////////////////////////////////////////////////////////
