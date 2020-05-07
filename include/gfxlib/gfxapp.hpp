//****************************************************************************//
//**                                                                        **//
//** File:         include/gfxlib/gfxapp.hpp                                **//
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

#ifndef _EXTROPIA_GFXLIB_GFXAPP_HPP
#define _EXTROPIA_GFXLIB_GFXAPP_HPP

#include <gfxlib/gfx.hpp>
#include <iolib/inpdevs.hpp>

////////////////////////////////////////////////////////////////////////////////
//
//  Native classes
//
//  InteractiveDisplay : public Display, public InputDispatcher
//
////////////////////////////////////////////////////////////////////////////////

class InteractiveDisplay : public Display, public InputDispatcher {

  protected:
    InteractiveDisplay(uint32 r) : InputDispatcher(r) {}
    InteractiveDisplay(uint32 r, const char* i) : InputDispatcher(r, i) {}
  public:
    virtual ~InteractiveDisplay() {}
};

#if defined(XP_AMIGAOS3_68K)
  #include "plat/amigaos3_68k/gfxlib/gfxapp.hpp"
#elif defined(XP_AMIGAOS3_PPC)
  #include "plat/amigaos3_wos/gfxlib/gfxapp.hpp"
#elif defined(XP_AMIGAOS4)
  #include "plat/amigaos4/gfxlib/gfxapp.hpp"
#elif defined(XP_AROS_BE)
  #include "plat/aros_be/gfxlib/gfxapp.hpp"
#elif defined(XP_AROS_LE)
  #include "plat/aros_le/gfxlib/gfxapp.hpp"
#elif defined(XP_MORPHOS)
  #include "plat/morphos/gfxlib/gfxapp.hpp"
#elif defined(XP_LINUX_PPC)
  #include "plat/linux_ppc/gfxlib/gfxapp.hpp"
#elif defined(XP_LINUX_X86)
  #include "plat/linux_i386/gfxlib/gfxapp.hpp"
#elif defined(XP_WIN9X)
  #include "plat/win9x/gfxlib/gfxapp.hpp"
#elif defined(XP_WIN2K)
  #include "plat/win2k/gfxlib/gfxapp.hpp"
#elif defined(XP_MACOSX)
  #include "plat/macosx/gfxlib/gfxapp.hpp"
#else
  #error "Platform implementation not defined"
#endif

////////////////////////////////////////////////////////////////////////////////
//
//  InteractiveWindow
//
////////////////////////////////////////////////////////////////////////////////

class InteractiveWindow : public InteractiveDisplay, private _NatWin
{
  public:
    sint32    open(S_WHD, const char* title);
    sint32    open(const D_PRP* p, const char* title);
    sint32    reopen();
    void      close();
    void       waitSync()                 { _NatWin::waitSync(); }
    void      refresh()                   { _NatWin::refresh(); }
    void      refresh(S_XYWH)             { _NatWin::refresh(x, y, w, h); }
    void      setTitle(const char* title) { _NatWin::setTitle(title); }
    Surface*  getDrawSurface()            { return _NatWin::getDrawSurface(); }
    const D_PRP* getProperties()          { return _NatWin::getProperties(); }

    void    applyFilter()                 { _NatWin::applyFilter(getDispatchFilter()); }
    void    discardQueue()                { _NatWin::discardQueue(); }
    bool    waitEvent()                   { return _NatWin::waitEvent(); }
    bool    handleEvent()                 { return _NatWin::handleEvent(this); }
    bool    inputQueued()                 { return _NatWin::inputQueued(); }
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


    InteractiveWindow(uint32 r=IFilter::IDEFAULT) : _NatWin(), InteractiveDisplay(r) {}
    InteractiveWindow(uint32 r, const char* i) : _NatWin(), InteractiveDisplay(r, i) {}
    ~InteractiveWindow() { close(); }
};


////////////////////////////////////////////////////////////////////////////////
//
//  InteractiveScreen
//
////////////////////////////////////////////////////////////////////////////////

class InteractiveScreen : public InteractiveDisplay, private _NatScr
{
  public:
    sint32    open(S_WHD, const char* title);
    sint32    open(const D_PRP* p, const char* title);
    sint32    reopen();
    void      close();
    void      waitSync()                  { _NatScr::waitSync(); }
    void      refresh()                   { _NatScr::refresh(); }
    void      refresh(S_XYWH)             { _NatScr::refresh(x, y, w, h); }
    void      setTitle(const char* title) { _NatScr::setTitle(title); }
    Surface*  getDrawSurface()            { return _NatScr::getDrawSurface(); }
    const D_PRP* getProperties()          { return _NatScr::getProperties(); }

    void      applyFilter()               { _NatScr::applyFilter(getDispatchFilter()); }
    void      discardQueue()              { _NatScr::discardQueue(); }
    bool      waitEvent()                 { return _NatScr::waitEvent(); }
    bool      handleEvent()               { return _NatScr::handleEvent(this); }
    bool      inputQueued()               { return _NatScr::inputQueued(); }

    InteractiveScreen(uint32 r=IFilter::IDEFAULT) : _NatScr(), InteractiveDisplay(r) {}
    InteractiveScreen(uint32 r, const char* i) : _NatScr(), InteractiveDisplay(r, i) {}
    ~InteractiveScreen() { close(); }
};

////////////////////////////////////////////////////////////////////////////////
//
//  InteractiveScreenBuffered
//
////////////////////////////////////////////////////////////////////////////////

class InteractiveScreenBuffered : public InteractiveDisplay, private _NatScrBuff
{
  public:
    sint32    open(S_WHD, const char* title);
    sint32    open(const D_PRP* p, const char* title);
    sint32    reopen();
    void      close();
    void      waitSync()                  { _NatScrBuff::waitSync(); }
    void      refresh()                   { _NatScrBuff::refresh(); }
    void      refresh(S_XYWH)             { _NatScrBuff::refresh(x, y, w, h); }
    void      setTitle(const char* title) { _NatScrBuff::setTitle(title); }
    Surface*  getDrawSurface()            { return _NatScrBuff::getDrawSurface(); }
    const D_PRP* getProperties()          { return _NatScrBuff::getProperties(); }

    void      applyFilter()               { _NatScrBuff::applyFilter(getDispatchFilter()); }
    void      discardQueue()              { _NatScrBuff::discardQueue(); }
    bool      waitEvent()                 { return _NatScrBuff::waitEvent(); }
    bool      handleEvent()               { return _NatScrBuff::handleEvent(this); }
    bool      inputQueued()               { return _NatScrBuff::inputQueued(); }

    void      setClone(bool s)            { _NatScrBuff::setClone(s); }
    bool      getClone()                  { return _NatScrBuff::getClone(); }
    bool      setNumBuffers(sint32 num)   { return _NatScrBuff::setNumBuffers(num); }
    sint32    getNumBuffers()             { return _NatScrBuff::getNumBuffers(); }

    InteractiveScreenBuffered(uint32 r=IFilter::IDEFAULT, sint32 n=2, bool c=false) : _NatScrBuff(n, c), InteractiveDisplay(r) {}
    InteractiveScreenBuffered(uint32 r, const char* i, sint32 n=2, bool c=false) : _NatScrBuff(n, c), InteractiveDisplay(r, i) {}
    ~InteractiveScreenBuffered() { close(); }
};

#endif
