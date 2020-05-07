//****************************************************************************//
//**                                                                        **//
//** File:         libsrc/plat/amigaos3_68k/gfxlib/display.cpp              **//
//** Description:  Display class definitions                                **//
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

extern "C" {
  #include <string.h>
}

namespace X_SYSNAME {
  extern "C" {
    #include <cybergraphx/cybergraphics.h>
    #include <clib/alib_protos.h>
  }
};

using namespace X_SYSNAME;

////////////////////////////////////////////////////////////////////////////////
//
//  _NatDisplay
//
////////////////////////////////////////////////////////////////////////////////

uint32*  _NatDisplay::modeID = 0;

_NatDisplay::_NatDisplay()
: scr(0), win(0), width(-1), height(-1), depth(Pixel::BPPUNK)
{
  strcpy(name, "Untitled Window");
}

////////////////////////////////////////////////////////////////////////////////

void _NatDisplay::waitForRefresh()
{
  if (scr) {
    WaitBOVP(&(scr->ViewPort));
  }
}

////////////////////////////////////////////////////////////////////////////////



sint32 _NatDisplay::openFullScreen(uint32 ID)
{
  if (scr) {
    return ERR_RSC_LOCKED;
  }
  if (!(scr = OpenScreenTags(0,
    SA_Depth,      8L,
    SA_DisplayID,  ID,
    SA_ShowTitle,  false,
    SA_Draggable,  false,
    SA_SharePens,  true,
    SA_Title,      (uint32)name,
    TAG_DONE))
  ) {
    X_ERROR("_NatDisplay::openFullScreen() : failed to create screen");
    goto error;
  }

  X_INFO("_NatDisplay::openFullScreen() : screen opened");

  if (!(win = OpenWindowTags(0,
    WA_CustomScreen,  (uint32)scr,
    WA_Width,          (uint32)width,
    WA_Height,        (uint32)height,
     WA_Left,          0,
    WA_Top,            0,
    WA_Title,          0,
    WA_Flags,          WFLG_ACTIVATE|WFLG_BORDERLESS|WFLG_BACKDROP|
                      WFLG_REPORTMOUSE|WFLG_RMBTRAP,
    TAG_DONE))
  ) {
    X_ERROR("_NatDisplay::openFullScreen() : failed to create window");
    goto error;
  }

  X_INFO("_NatDisplay::openFullScreen() : display created OK");

  return OK;
error:
  closeFullScreen();
  return ERR_RSC_UNAVAILABLE;
}

////////////////////////////////////////////////////////////////////////////////

void _NatDisplay::closeFullScreen()
{
  if (scr) {
    if (win)   {
      CloseWindow(win);
      win = 0;
      X_INFO("_NatDisplay::closeFullScreen() : window closed");
    }
    CloseScreen(scr);
    X_INFO("_NatDisplay::closeFullScreen() : screen closed");
    scr = 0;
    X_INFO("_NatDisplay::closeFullScreen() : resources freed");
  }
}

////////////////////////////////////////////////////////////////////////////////

void _NatDisplay::setDisplayTitle(const char* title, bool scrTitle)
{
  if (title) {
    strncpy(name, title, DISPLAY_NAME_LEN-1);
  }
  if (scrTitle && scr!=0) {
    SetWindowTitles(win, (char*)(0xFFFFFFFFUL), name);
  }
  else if (win!=0) {
    SetWindowTitles(win, name, (char*)(0xFFFFFFFFUL));
  }
}

////////////////////////////////////////////////////////////////////////////////
//
//  _NatWin
//
////////////////////////////////////////////////////////////////////////////////

_NatWin::_NatWin()
: _NatDisplay(), rast(0), drawSurface(0), top(0), left(0)
{
  flags = NW_CENTRE_X|NW_CENTRE_Y|NW_MOVEABLE;
}

////////////////////////////////////////////////////////////////////////////////

_NatWin::~_NatWin()
{
  closeWindow();
}

////////////////////////////////////////////////////////////////////////////////

void _NatWin::setBorderless(bool s)
{
  if (s) {
    flags |= NW_BORDERLESS;
  }  else {
    flags &= ~NW_BORDERLESS;
  }
}

void _NatWin::setMoveable(bool s)
{
  if (s) {
    flags |= NW_MOVEABLE;
  } else {
    flags &= ~NW_MOVEABLE;
  }
}

void _NatWin::setResizeable(bool s)
{
  if (s) {
    flags |= NW_RESIZEABLE;
  } else {
    flags &= ~NW_RESIZEABLE;
  }
}

void _NatWin::setCloseable(bool s)
{
  if (s) {
    flags |= NW_CLOSEABLE;
  }  else {
    flags &= ~NW_CLOSEABLE;
  }
}

////////////////////////////////////////////////////////////////////////////////

sint32 _NatWin::openWindow()
{
  if (!(scr =  LockPubScreen(0))) {
    X_ERROR("_NatWin::openWindow() : unable to lock screen");
    return ERR_RSC_UNAVAILABLE;
  }
  X_INFO("_NatDisplay::openWindow() : screen locked");
  if (GetCyberMapAttr(scr->RastPort.BitMap, CYBRMATTR_ISCYBERGFX)==false) {
    UnlockPubScreen(0, scr);
    X_ERROR("_NatWin::openWindow() : screen bitmap not cgx");
    scr = 0;
    return ERR_RSC_INVALID;
  }
  X_INFO("_NatDisplay::openWindow() : screen bitmap OK");
  sint32 scrW = GetCyberMapAttr(scr->RastPort.BitMap, CYBRMATTR_WIDTH);
  if (width > scrW) {
    UnlockPubScreen(0, scr);
    X_ERROR("_NatWin::openWindow() : width exceeds screen");
    return ERR_VALUE_RANGE;
  }
  sint32 scrH = GetCyberMapAttr(scr->RastPort.BitMap, CYBRMATTR_HEIGHT);
  if (height > scrH) {
    UnlockPubScreen(0, scr);
    X_ERROR("_NatWin::openWindow() : height exceeds screen");
    return ERR_VALUE_RANGE;
  }
  sint32 scrD = GetCyberMapAttr(scr->RastPort.BitMap, CYBRMATTR_DEPTH);
  if (depth > scrD) {
    UnlockPubScreen(0, scr);
    X_ERROR("_NatWin::openWindow() : depth exceeds screen");
    return ERR_VALUE_RANGE;
  }
  X_INFO("_NatDisplay::openWindow() : window parameters OK");

  if (!(flags & NW_REOPENED)) {
    if (flags & NW_CENTRE_X) {
      left = (scrW - width)>>1;
    } else {
      left = Clamp::integer(left, 0, scrW-width);
    }
    if (flags & NW_CENTRE_Y) {
      top = (scrH - height)>>1;
    } else {
      top = Clamp::integer(top, 0, scrH-height);
    }
  }

  if (!(rast = new(nothrow) RastPort)) {
    UnlockPubScreen(0, scr);
    X_ERROR("_NatWin::openWindow() : unable allocate RastPort");
    return ERR_RSC_UNAVAILABLE;
  }
  else {
    InitRastPort(rast);
  }
  X_INFO("_NatDisplay::openWindow() : RastPort allocated");

  uint32 wFlags = WFLG_REPORTMOUSE|WFLG_RMBTRAP|WFLG_ACTIVATE|
                  (flags & NW_MOVEABLE      ? WFLG_DRAGBAR : 0)                      |
                  (flags & NW_CLOSEABLE      ? WFLG_CLOSEGADGET : 0)                  |
                  (flags & NW_RESIZEABLE     ? WFLG_SIZEGADGET|WFLG_SIZEBRIGHT : 0)  |
                  (flags & NW_BORDERLESS    ? WFLG_BORDERLESS : 0)                  |
                  (flags & NW_NOSYSREFRESH  ? WFLG_SIMPLE_REFRESH|WFLG_NOCAREREFRESH : 0);

  win = OpenWindowTags(0,
    WA_PubScreen,    (uint32)scr,
    WA_InnerWidth,  (uint32)width,
    WA_InnerHeight,  (uint32)height,
    WA_Left,        left,
    WA_Top,          top,
    WA_Title,        (uint32)name,
    WA_DepthGadget,  true,
    WA_Flags,        wFlags,
    TAG_DONE
  );

   UnlockPubScreen(0, scr);

  X_INFO("_NatDisplay::openWindow() : screen Unlocked");

  if (!win) {
    X_ERROR("_NatWin::openWindow() : OpenWindowTags() failed");
    return ERR_RSC_UNAVAILABLE;
  }
  if (!(drawSurface = createSurface(win->RPort->BitMap, width, height))) {
    X_ERROR("_NatWin::openWindow() : failed to create draw Surface");
    closeWindow();
    return ERR_RSC;
  }
  setWinUser(drawSurface, win);
  rast->BitMap = getSurfaceRep(drawSurface);
  X_INFO("_NatDisplay::openWindow() : display created OK");
  return OK;
}

////////////////////////////////////////////////////////////////////////////////

void _NatWin::closeWindow()
{
  if (win) {
    // remember last position/size for reopen()
    top = getWinY();    left = getWinX();
    width = getViewW();  height = getViewH();
    CloseWindow(win);
    X_INFO("_NatDisplay::closeWindow() : window closed");
  }
  if (rast) {
    delete rast;
  }
  if (drawSurface) {
    delete drawSurface;
  }
  scr = 0;
  win = 0;
  rast = 0;
  drawSurface = 0;
}

////////////////////////////////////////////////////////////////////////////////

sint32 _NatWin::reopen()
{
  // if the window hasn't been opened before, return an error
  if (width == -1 || height == -1) {
    X_ERROR("_NatWin::reopen() : parameters unset");
    return ERR_RSC_UNAVAILABLE;
  }
  flags |= NW_REOPENED;
  return openWindow();
}

////////////////////////////////////////////////////////////////////////////////

void _NatWin::close()
{
  closeWindow();
}

////////////////////////////////////////////////////////////////////////////////

void _NatWin::refresh()
{
  if (win) {
    ClipBlit(
      rast, 0, 0, win->RPort,
      win->BorderLeft, win->BorderTop, width, height, 0xC0
    );
  }
}

////////////////////////////////////////////////////////////////////////////////

void _NatWin::refresh(S_XYWH)
{
  if (win) {
    // Refresh area must fit within the display
    if (x > width || y > height || (x+w) < 0 || (y+h) < 0) {
      return;
    }
    // Since coords can be negative, crop blit
    if (x<0)          {  w += x;  x = 0;  }
    if ((x+w)>width)  {  w = width - x;  }
    if (y<0)          {  h += y;  y = 0;  }
    if ((y+h)>height)  {  h = height - y;  }

    // Do the blit
    ClipBlit(
      rast, x, y,
      win->RPort, win->BorderLeft+x, win->BorderTop+y, w, h, 0xC0
    );
  }
}

////////////////////////////////////////////////////////////////////////////////

sint32 _NatWin::open(S_WHD, const char* title)
{
  // sanity check
  if (w<64 /*DisplayProperties::getMinWidth()*/ || w>DisplayProperties::getMaxWidth() ||
      h<64 /*DisplayProperties::getMinHeight()*/ || h>DisplayProperties::getMaxHeight()) {
    X_ERROR(
      "_NatWin::open(sint16 w, sint16 h, Pixel::Depth, "
      "const char* title) : illegal dimensions"
    );
    return ERR_VALUE_ILLEGAL;
  }
  width = w;
  height = h;
  depth = d;
  if (title) {
    strncpy(name, title, 63);
  }
  return openWindow();
}

////////////////////////////////////////////////////////////////////////////////

sint32 _NatWin::open(const D_PRP* p, const char* title)
{
  X_ERROR(
    "_NatWin::open(DisplayProperties*, const char* title) : "
    "method unavailable"
  );
  return ERR_RSC_UNAVAILABLE;
}


////////////////////////////////////////////////////////////////////////////////
//
//  _NatScr
//
////////////////////////////////////////////////////////////////////////////////

_NatScr::_NatScr()
: _NatDisplay(), displayID(0), drawSurface(0)
{

}

////////////////////////////////////////////////////////////////////////////////

_NatScr::~_NatScr()
{
  closeScreen();
}

////////////////////////////////////////////////////////////////////////////////

sint32 _NatScr::openScreen()
{
  if (scr) {
    return ERR_RSC_LOCKED;
  }
  if (openFullScreen(displayID)==OK) {
    if (!(drawSurface = assignNewSurface(win->RPort->BitMap))) {
      X_ERROR("_NatScr::openScreen() : failed to create draw Surface");
      closeScreen();
      return ERR_RSC_UNAVAILABLE;
    }
    setWinUser(drawSurface, win);
    return OK;
  }
  return ERR_RSC_UNAVAILABLE;
}

////////////////////////////////////////////////////////////////////////////////

void _NatScr::closeScreen()
{
  if (drawSurface) {
    delete drawSurface;
    drawSurface = 0;
  }
  closeFullScreen();
}

////////////////////////////////////////////////////////////////////////////////

sint32 _NatScr::open(S_WHD, const char* title)
{
  // sanity check
  if (w<DisplayProperties::getMinWidth() || w>DisplayProperties::getMaxWidth() ||
      h<DisplayProperties::getMinHeight() || h>DisplayProperties::getMaxHeight()) {
    X_ERROR(
      "_NatScr::open(sint16 w, sint16 h, Pixel::Depth, "
      "const char* title) : illegal dimensions"
    );
    return ERR_VALUE_ILLEGAL;
  }
  return open(DisplayProperties::findMode(w, h, d, false), title);
}

////////////////////////////////////////////////////////////////////////////////

sint32 _NatScr::open(const D_PRP* p, const char* title)
{
  if (!p) {
    X_ERROR(
      "_NatScr::open(DisplayProperties *p, "
      "const char* title) : null pointer"
    );
    return ERR_PTR_ZERO;
  }
  if (!(displayID = getDisplayID(p)) ) {
    X_ERROR(
      "_NatScr::open(DisplayProperties *p, "
      "const char* title) : Display unavailable"
    );
    return ERR_RSC_UNAVAILABLE;
  }
  width    = p->getW();
  height  = p->getH();
  depth    = p->getDepth();
  if (title)
    strncpy(name, title, 63);
  properties = p;
  return openScreen();
}

////////////////////////////////////////////////////////////////////////////////

sint32 _NatScr::reopen()
{
  if (width == -1 || height == -1) {
    X_ERROR("_NatScr::reopen() : parameters unset");
    return ERR_RSC_UNAVAILABLE;
  }
  return openScreen();
}

////////////////////////////////////////////////////////////////////////////////

void _NatScr::close()
{
  closeScreen();
}


////////////////////////////////////////////////////////////////////////////////
//
//  _NatScrBuff
//
////////////////////////////////////////////////////////////////////////////////

_NatScrBuff::_NatScrBuff(sint32 n, bool c)
: _NatDisplay(), displayID(0), drawSurface(0), drawBuffer(0), flags(0)
{
  vidSafePort = CreatePort(0,0);
  vidDispPort = CreatePort(0,0);
  buffer[0] = 0;
  buffer[1] = 0;
  buffer[2] = 0;
  if (c) {
    flags |= NSB_CLONE_BUFFER;
  }
  if (n==3) {
    flags |= NSB_TRIPLE_BUFFER;
  }
  if (!vidSafePort || !vidDispPort) {
    flags |= NSB_PORT_ERROR;
  }
}

////////////////////////////////////////////////////////////////////////////////

_NatScrBuff::~_NatScrBuff()
{
  closeScreen();
  if (vidDispPort) {
    DeletePort(vidDispPort);
  }
  if (vidSafePort) {
    DeletePort(vidSafePort);
  }
}

////////////////////////////////////////////////////////////////////////////////

void _NatScrBuff::setClone(bool s)
{
  if (s) {
    flags |= NSB_CLONE_BUFFER;
  }
  else {
    flags &= NSB_CLONE_BUFFER;
  }
}

////////////////////////////////////////////////////////////////////////////////

bool _NatScrBuff::setNumBuffers(sint32 num)
{
  if (!scr) {
    switch (num) {
      case 2:
        flags &= ~NSB_TRIPLE_BUFFER;
        return true;
        break;
      case 3:
        flags |= NSB_TRIPLE_BUFFER;
        return true;
        break;
      default:
        flags &= ~NSB_TRIPLE_BUFFER;
        break;
    }
  }
  return false;
}

////////////////////////////////////////////////////////////////////////////////

sint32 _NatScrBuff::openScreen()
{
  if (scr) {
    return ERR_RSC_LOCKED;
  }
  if (flags & NSB_PORT_ERROR) {
    X_ERROR("_NatScrBuff::openScreen() : problem allocating message ports");
    goto error;
  }
  if (openFullScreen(displayID)==OK) {
    if (!(buffer[0] = AllocScreenBuffer(scr, 0, SB_SCREEN_BITMAP))) {
      X_ERROR("_NatScrBuff::openScreen() : failed to create primary buffer");
      goto error;
    }

    X_INFO("_NatScrBuff::openScreen() : created primary buffer");

    if (!(buffer[1] = AllocScreenBuffer(scr, 0, 0))) {
      X_ERROR("_NatScrBuff::openScreen() : failed to create secondary buffer");
      goto error;
    }

    X_INFO("_NatScrBuff::openScreen() : created secondary buffer");

    if (flags & NSB_TRIPLE_BUFFER) {
      if (!(buffer[2] = AllocScreenBuffer(scr, 0, 0))) {
        X_ERROR("_NatScrBuff::openScreen() : failed to create tertiay buffer");
        goto error;
      }
    }

    drawBuffer = 1;

    if (!(drawSurface = assignNewSurface(buffer[drawBuffer]->sb_BitMap))) {
      X_ERROR("_NatScrBuff::openScreen() : failed to create draw Surface");
      goto error;
    }

    X_INFO("_NatScrBuff::openScreen() : created draw Surface");

    setWinUser(drawSurface, win);

    buffer[0]->sb_DBufInfo->dbi_DispMessage.mn_ReplyPort = vidDispPort;
    buffer[0]->sb_DBufInfo->dbi_SafeMessage.mn_ReplyPort = vidSafePort;
    buffer[1]->sb_DBufInfo->dbi_DispMessage.mn_ReplyPort = vidDispPort;
    buffer[1]->sb_DBufInfo->dbi_SafeMessage.mn_ReplyPort = vidSafePort;
    if (buffer[2]) {
      buffer[2]->sb_DBufInfo->dbi_DispMessage.mn_ReplyPort = vidDispPort;
      buffer[2]->sb_DBufInfo->dbi_SafeMessage.mn_ReplyPort = vidSafePort;
    }

    flags |= NSB_VID_DISP|NSB_VID_SAFE;
    return OK;
  }

error:
  closeScreen();
  return ERR_RSC_UNAVAILABLE;
}


////////////////////////////////////////////////////////////////////////////////

void _NatScrBuff::closeScreen()
{
  // discard any port messages
  sint32 m=0;
  if (!(flags & NSB_VID_SAFE)) {
    if (vidSafePort) {
      while(!GetMsg(vidSafePort)) {
        m++;
      }
    }
    printf("_NatScrBuff::closeScreen() : discarded %ld messages from vidSafePort\n", m);
    m=0;
  }
  if (!(flags & NSB_VID_DISP)) {
    if (vidDispPort) {
      while(!GetMsg(vidDispPort)) {
        m++;
      }
    }
    printf("_NatScrBuff::closeScreen() : discarded %ld messages from vidDispPort\n", m);
  }
  if (drawSurface) {
    delete drawSurface;
    drawSurface = 0;
    X_INFO("_NatScrBuff::closeScreen() : released draw Surface");
  }
  if (buffer[0]) {
    buffer[0]->sb_DBufInfo->dbi_SafeMessage.mn_ReplyPort = 0;
    while (!ChangeScreenBuffer(scr, buffer[0])) {
      ;
    }
    FreeScreenBuffer(scr, buffer[0]);
    buffer[0] = 0;
    X_INFO("_NatScrBuff::closeScreen() : released primary buffer");
  }
  if (buffer[1]) {
    FreeScreenBuffer(scr, buffer[1]);
    buffer[1] = 0;
    X_INFO("_NatScrBuff::closeScreen() : released secondary buffer");
  }
  if (buffer[2]) {
    FreeScreenBuffer(scr, buffer[2]);
    buffer[2] = 0;
    X_INFO("_NatScrBuff::closeScreen() : released tertiary buffer");
  }

  closeFullScreen();
}

////////////////////////////////////////////////////////////////////////////////

void _NatScrBuff::refresh()
{
  if (scr) {
    sint32 curBuf = drawBuffer;
    if (flags & NSB_TRIPLE_BUFFER) {
      if (++drawBuffer == 3) {
        drawBuffer = 0;
      }
    }
    else {
      drawBuffer ^=1;
    }
    buffer[curBuf]->sb_DBufInfo->dbi_SafeMessage.mn_ReplyPort = 0;

    // FIXME - proper double buffer switching seems to wait forever

/*
    if (ChangeScreenBuffer(scr, buffer[curBuf])!=0)
      flags &= ~(NSB_VID_DISP|NSB_VID_SAFE);

    if (!(flags & NSB_VID_SAFE)) {
      while (!GetMsg(vidSafePort))
        Wait(1<<vidSafePort->mp_SigBit);
      flags |= NSB_VID_SAFE;
    }
*/
    while(!ChangeScreenBuffer(scr, buffer[curBuf])) {
      ;
    }
    assignSurfaceQuick(drawSurface, buffer[drawBuffer]->sb_BitMap);

/*
    if (flags & NSB_CLONE_BUFFER)
    {
      BltBitMap(buffer[drawBuffer]->sb_BitMap, 0, 0,
                buffer[curBuf]->sb_BitMap, 0, 0,
                width, height, 0xC0, 0xFF, 0);
    }
*/
  }
}

void _NatScrBuff::waitSync()
{
  if (!(flags & NSB_VID_DISP)) {
    while (!GetMsg(vidDispPort)) {
      Wait(1<<vidDispPort->mp_SigBit);
    }
    flags |= NSB_VID_DISP;
  }
}

////////////////////////////////////////////////////////////////////////////////

sint32 _NatScrBuff::open(S_WHD, const char* title)
{
  // sanity check
  if (w<DisplayProperties::getMinWidth() || w>DisplayProperties::getMaxWidth() ||
      h<DisplayProperties::getMinHeight() || h>DisplayProperties::getMaxHeight()) {
    X_ERROR(
      "_NatScrBuff::open(sint16 w, sint16 h, Pixel::Depth, "
      "const char* title) : illegal dimensions"
    );
    return ERR_VALUE_ILLEGAL;
  }
  return open(DisplayProperties::findMode(w, h, d, false), title);
}

////////////////////////////////////////////////////////////////////////////////

sint32 _NatScrBuff::open(const D_PRP* p, const char* title)
{
  if (!p) {
    X_ERROR(
      "_NatScrBuff::open(DisplayProperties *p, "
      "const char* title) : null pointer"
    );
    return ERR_PTR_ZERO;
  }
  if (!(displayID = getDisplayID(p)) ) {
    X_ERROR(
      "_NatScrBuff::open(DisplayProperties *p, "
      "const char* title) : Display unavailable"
    );
    return ERR_RSC_UNAVAILABLE;
  }
  width    = p->getW();
  height  = p->getH();
  depth    = p->getDepth();
  if (title) {
    strncpy(name, title, 63);
  }
  properties = p;
  return openScreen();
}

////////////////////////////////////////////////////////////////////////////////

sint32 _NatScrBuff::reopen()
{
  if (width == -1 || height == -1) {
    X_ERROR("_NatScrBuff::reopen() : parameters unset");
    return ERR_RSC_UNAVAILABLE;
  }
  return openScreen();
}

////////////////////////////////////////////////////////////////////////////////

void _NatScrBuff::close()
{
  closeScreen();
}

////////////////////////////////////////////////////////////////////////////////
