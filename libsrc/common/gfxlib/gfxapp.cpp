//****************************************************************************//
//**                                                                        **//
//** File:         libsrc/common/gfxlib/gfxapp.cpp                          **//
//** Description:                                                           **//
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

#include <gfxlib/gfxapp.hpp>

////////////////////////////////////////////////////////////////////////////////
//
//  DisplayWindowInput
//
////////////////////////////////////////////////////////////////////////////////

sint32 InteractiveWindow::open(S_WHD, const char* title)
{
  sint32 r = _NatWin::open(w, h, d, title);
  if (r==OK) {
    _NatWin::applyFilter(getDispatchFilter());
  }
  return r;
}

////////////////////////////////////////////////////////////////////////////////

sint32 InteractiveWindow::open(const D_PRP* p, const char* title)
{
  sint32 r = _NatWin::open(p, title);
  if (r==OK) {
    _NatWin::applyFilter(getDispatchFilter());
  }
  return r;
}

////////////////////////////////////////////////////////////////////////////////

sint32 InteractiveWindow::reopen()
{
  sint32 r = _NatWin::reopen();
  if (r==OK) {
    _NatWin::applyFilter(getDispatchFilter());
  }
  return r;
}

////////////////////////////////////////////////////////////////////////////////

void InteractiveWindow::close()
{
  _NatWin::discardQueue();
  setDispatchFilter(0);
  _NatWin::close();
}

////////////////////////////////////////////////////////////////////////////////
//
//  InteractiveScreen
//
////////////////////////////////////////////////////////////////////////////////

sint32 InteractiveScreen::open(S_WHD, const char* title)
{
  sint32 r = _NatScr::open(w, h, d, title);
  if (r==OK) {
    _NatScr::applyFilter(getDispatchFilter());
  }
  return r;
}

////////////////////////////////////////////////////////////////////////////////

sint32 InteractiveScreen::open(const D_PRP* p, const char* title)
{
  sint32 r = _NatScr::open(p, title);
  if (r==OK) {
    _NatScr::applyFilter(getDispatchFilter());
  }
  return r;
}

////////////////////////////////////////////////////////////////////////////////

sint32 InteractiveScreen::reopen()
{
  sint32 r = _NatScr::reopen();
  if (r==OK) {
    _NatScr::applyFilter(getDispatchFilter());
  }
  return r;
}

////////////////////////////////////////////////////////////////////////////////

void InteractiveScreen::close()
{
  _NatScr::discardQueue();
  setDispatchFilter(0);
  _NatScr::close();
}

////////////////////////////////////////////////////////////////////////////////
//
//  InteractiveScreenBuffered
//
////////////////////////////////////////////////////////////////////////////////

sint32 InteractiveScreenBuffered::open(S_WHD, const char* title)
{
  sint32 r = _NatScrBuff::open(w, h, d, title);
  if (r==OK) {
    _NatScrBuff::applyFilter(getDispatchFilter());
  }
  return r;
}

////////////////////////////////////////////////////////////////////////////////

sint32 InteractiveScreenBuffered::open(const D_PRP* p, const char* title)
{
  sint32 r = _NatScrBuff::open(p, title);
  if (r==OK) {
    _NatScrBuff::applyFilter(getDispatchFilter());
  }
  return r;
}

////////////////////////////////////////////////////////////////////////////////

sint32 InteractiveScreenBuffered::reopen()
{
  sint32 r = _NatScrBuff::reopen();
  if (r==OK) {
    _NatScrBuff::applyFilter(getDispatchFilter());
  }
  return r;
}

////////////////////////////////////////////////////////////////////////////////

void InteractiveScreenBuffered::close()
{
  discardQueue();
  setDispatchFilter(0);
  _NatScrBuff::close();
}

////////////////////////////////////////////////////////////////////////////////
