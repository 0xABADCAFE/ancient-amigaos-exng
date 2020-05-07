//****************************************************************************//
//**                                                                        **//
//** File:         include/plat/amigaos3_68k/gfxlib/display.hpp             **//
//** Description:  Display wrapper classes                                  **//
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

#ifndef _EXTROPIA_GFXLIB_DISPLAY_NATIVE_HPP
#define _EXTROPIA_GFXLIB_DISPLAY_NATIVE_HPP

#include <iolib/inpdevs.hpp>

////////////////////////////////////////////////////////////////////////////////
//
//  DisplayNative
//
//  Shared AmigaOS code used by all display variants
//
////////////////////////////////////////////////////////////////////////////////

#define DISPLAY_NAME_LEN 256

class _NatDisplay : protected SurfaceProvider, private _NatInput
{
  friend class GfxLib;
  friend class DisplayIDUser;
  friend class _NatDisplayUser;
  private:
    static  uint32*  modeID;
    static  sint32  mapChar(X_SYSNAME::IntuiMessage* m);

  protected:
    X_SYSNAME::Screen*  scr;      // own screen (fullscreen) or public screen (windowed)
    X_SYSNAME::Window*  win;      // window
    sint16        width;
    sint16        height;
    P_D            depth;
    char          name[DISPLAY_NAME_LEN];

    void          waitForRefresh();
    sint32        openFullScreen(uint32 ID);
    void          closeFullScreen();
    void          setDisplayTitle(const char* title, bool scrTitle);

    static uint32  getDisplayID(size_t i)
    {
      if (modeID)
        return modeID[i];
      return 0;
    }

    static uint32 getDisplayID(const D_PRP* p)
    {
      if (p)
        return getDisplayID(p->getModeIndex());
      return 0;
    }

    // Input handling resources
    void            applyFilter(uint32 mask);
    void            discardQueue();
    bool            waitEvent();
    bool            handleEvent(InputDispatcher* d);
    bool            inputQueued();

  public:
    _NatDisplay();
    ~_NatDisplay() {}
};

class _NatDisplayUser {
  protected:
    X_SYSNAME::Screen* getScreen(_NatDisplay* d)  { return d->scr; }
    X_SYSNAME::Window* getWindow(_NatDisplay* d)  { return d->win; }
    const char* getTitle(_NatDisplay* d)          { return d->name; }
};


////////////////////////////////////////////////////////////////////////////////
//
//  DisplayIDUser
//
//  Small interface for classes that need to access display ID values directly
//
////////////////////////////////////////////////////////////////////////////////

class DisplayIDUser {
  protected:
    static uint32 getDisplayID(size_t i) { return _NatDisplay::getDisplayID(i); }
    static uint32 getDisplayID(D_PRP* p) { return _NatDisplay::getDisplayID(p); }
};


////////////////////////////////////////////////////////////////////////////////
//
//  _NatWin
//
//  Provides a windowed Display:: variant. The window comes complete with
//  hidden buffer for offscreen rendering. Direct rendering to the front
//  buffer is not supported.
//
////////////////////////////////////////////////////////////////////////////////

class _NatWin : private _NatDisplay {
  private:
    X_SYSNAME::RastPort*  rast;
    Surface*  drawSurface;
    uint32    flags;
    sint16    top;
    sint16    left;

    enum {
      NW_CENTRE_X     = 0x00000001,
      NW_CENTRE_Y     = 0x00000002,
      NW_CLOSEABLE    = 0x00000004,
      NW_MOVEABLE      = 0x00000008,
      NW_RESIZEABLE    = 0x00000010,
      NW_BORDERLESS    = 0x00000020,
      NW_NOSYSREFRESH  = 0x00000040,
      NW_REOPENED      = 0x00000080
    };

    sint32    openWindow();
    void      closeWindow();

  protected:
    void applyFilter(uint32 mask)          { _NatDisplay::applyFilter(mask); }
    void discardQueue()                    { _NatDisplay::discardQueue(); }
    bool waitEvent()                      { return _NatDisplay::waitEvent(); }
    bool handleEvent(InputDispatcher* d)  { return _NatDisplay::handleEvent(d); }
    bool inputQueued()                    { return _NatDisplay::inputQueued(); }

    sint16    getWinX()    { return win->LeftEdge; }
    sint16    getWinY()    { return win->TopEdge; }
    sint16    getWinW()    { return win->Width; }
    sint16    getWinH()    { return win->Height; }
    sint16    getWinBL()  { return win->BorderLeft; }
    sint16    getWinBR()  { return win->BorderRight; }
    sint16    getWinBT()  { return win->BorderTop; }
    sint16    getWinBB()  { return win->BorderBottom; }
    sint16    getViewX()  { return getWinX()+getWinBL(); }
    sint16    getViewY()  { return getWinY()+getWinBT(); }
    sint16    getViewW()  {  return getWinW()-getWinBL()-getWinBR(); }
    sint16    getViewH()  { return getWinH()-getWinBT()-getWinBB(); }

    sint32    reopen();
    sint32    open(S_WHD, const char* title);
    sint32    open(const D_PRP* p, const char* title);
    void      setTitle(const char* title) { setDisplayTitle(title, false); }
    void      close();
    void       waitSync()       { waitForRefresh(); }
    void      refresh();
    void      refresh(S_XYWH);
    Surface*  getDrawSurface() { return drawSurface; }

    // window specific methods
    void      setBorderless(bool s);
    void      setMoveable(bool s);
    void      setResizeable(bool s);
    void      setCloseable(bool s);

    bool      getBorderless()        { return (flags & NW_BORDERLESS); }
    bool      getMoveable()          { return (flags & NW_MOVEABLE); }
    bool      getResizeable()        { return (flags & NW_RESIZEABLE); }
    bool      getCloseable()        { return (flags & NW_CLOSEABLE); }

    const D_PRP* getProperties()    { return 0; }

    _NatWin();
  public:
    ~_NatWin();

  // temp hack
    X_SYSNAME::Window* getAmigaWin() { return win; }
    X_SYSNAME::Screen* getAmigaScr() { return scr; }
};


////////////////////////////////////////////////////////////////////////////////
//
//  _NatScr
//
//  Provides a fullscreen Display:: variant.
//
////////////////////////////////////////////////////////////////////////////////

class _NatScr : private _NatDisplay {
  private:
    uint32        displayID;
    Surface*      drawSurface;
    const D_PRP*  properties;
    sint32        openScreen();
    void          closeScreen();

  protected:
    void applyFilter(uint32 mask)          { _NatDisplay::applyFilter(mask); }
    void discardQueue()                    { _NatDisplay::discardQueue(); }
    bool waitEvent()                      { return _NatDisplay::waitEvent(); }
    bool handleEvent(InputDispatcher* d)  { return _NatDisplay::handleEvent(d); }
    bool inputQueued()                    { return _NatDisplay::inputQueued(); }

    sint32    open(S_WHD, const char* title);
    sint32    open(const D_PRP* p, const char* title);
    sint32    reopen();
    void      setTitle(const char* title) { setDisplayTitle(title, true); }
    void      close();
    void       waitSync()                  { waitForRefresh(); }
    void      refresh()                    { }
    void      refresh(S_XYWH)              { }
    Surface*  getDrawSurface()            { return drawSurface; }
    const D_PRP* getProperties()          { return properties; }

    _NatScr();

  public:
    ~_NatScr();

  // temp hack
    X_SYSNAME::Window* getAmigaWin() { return win; }
    X_SYSNAME::Screen* getAmigaScr() { return scr; }
};


////////////////////////////////////////////////////////////////////////////////
//
//  _NatScrBuff
//
//  Provides a fullscreen Display:: variant. The screen comes complete with
//  hidden buffer for offscreen rendering.
//
////////////////////////////////////////////////////////////////////////////////

class _NatScrBuff : private _NatDisplay {
  private:
    //X_SYSNAME::Task*          flipTask;    // buffer control task
    X_SYSNAME::MsgPort*        vidSafePort;  // safe to use bitmap
    X_SYSNAME::MsgPort*        vidDispPort;  // frame has been displayed
    X_SYSNAME::ScreenBuffer*  buffer[3];    // up to triple buffering
    uint32                    displayID;
    Surface*                  drawSurface;
    sint32                    drawBuffer;
    uint32                    flags;
    const D_PRP*              properties;

    enum {
      NSB_TRIPLE_BUFFER = 0x00000001,
      NSB_CLONE_BUFFER  = 0x00000002,
      NSB_VID_SAFE      = 0x00000004,
      NSB_VID_DISP      = 0x00000008,
      NSB_PORT_ERROR    = 0x80000000
    };

    sint32    openScreen();
    void      closeScreen();

  protected:
    void applyFilter(uint32 mask)          { _NatDisplay::applyFilter(mask); }
    void discardQueue()                    { _NatDisplay::discardQueue(); }
    bool waitEvent()                      { return _NatDisplay::waitEvent(); }
    bool handleEvent(InputDispatcher* d)  { return _NatDisplay::handleEvent(d); }
    bool inputQueued()                    { return _NatDisplay::inputQueued(); }

    sint32    open(S_WHD, const char* title);
    sint32    open(const D_PRP* p, const char* title);
    sint32    reopen();
    void      setTitle(const char* title) { setDisplayTitle(title, true); }
    void      close();
    void       waitSync();
    void      refresh();
    void      refresh(S_XYWH)              { refresh(); }
    Surface*  getDrawSurface()            { return drawSurface; }
    const D_PRP* getProperties()          { return properties; }

    // screen buffered specific methods
    void      setClone(bool s);
    bool      getClone()                  { return (flags & NSB_CLONE_BUFFER) ? true : false; }
    bool      setNumBuffers(sint32 num);
    sint32    getNumBuffers()              { return (flags & NSB_TRIPLE_BUFFER) ? 3 : 2; }

    _NatScrBuff(sint32 n, bool c);



  public:
    ~_NatScrBuff();

  // temp hack
    X_SYSNAME::Window* getAmigaWin() { return win; }
    X_SYSNAME::Screen* getAmigaScr() { return scr; }
};


#endif
