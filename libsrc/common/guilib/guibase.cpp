//****************************************************************************//
//**                                                                        **//
//** File:         libsrc/common/guilib/guibase.cpp                         **//
//** Description:  GUIBase class definition                                 **//
//** Comment(s):                                                            **//
//** Library:      guilib                                                   **//
//** Created:      2003-02-08                                               **//
//** Updated:      2003-02-09                                               **//
//** Author(s):    Karl Churchill, Serkan YAZICI                            **//
//** Note(s):                                                               **//
//** Copyright:    (C)1996-2003, eXtropia Studios                           **//
//**               Serkan YAZICI, Karl Churchill                            **//
//**               All Rights Reserved.                                     **//
//**                                                                        **//
//****************************************************************************//

#include <guilib/guibase.hpp>

////////////////////////////////////////////////////////////////////////////////
//
//  GUIBase
//
////////////////////////////////////////////////////////////////////////////////

GUIObject* GUIBase::active = 0;

GUIBase::GUIBase() : InputFocus(IFilter::IDEFAULT), root(0), state(0)
{

}

////////////////////////////////////////////////////////////////////////////////

GUIBase::~GUIBase()
{

}

////////////////////////////////////////////////////////////////////////////////

GUIObject* GUIBase::find(sint16 x, sint16 y)
{
  if (root)
  {
    GUIObject* found = root->recFindHit(x, y, root);

    // It is possible that no GUIObject was found under the coordinates.
    // The recursive nature of the search means that if we get the
    // same object we started the search with, it might be that nothing
    // else was found. To resolve this, we check the returned object.

    if (found == root && root->coordHit(x, y)==false)
    {
      X_INFO("GUIBase::find() - nothing found");
      return 0;
    }
    return found;
  }
  X_INFO("GUIBase::find() - no root");
  return 0;
}

////////////////////////////////////////////////////////////////////////////////

void GUIBase::keyPressNonPrintable(I_SRC, Key::CtrlKey code)
{
  if (state & BROADCASTPASSIVE)
    root->recKeyPressNP(code);
  if (active && active->getActiveResponses(IFilter::IKEYNONPRINTPRESS))
    active->keyPressNP(code);
}

////////////////////////////////////////////////////////////////////////////////

void GUIBase::keyReleaseNonPrintable(I_SRC, Key::CtrlKey code)
{
  if (state & BROADCASTPASSIVE)
    root->recKeyReleaseNP(code);
  if (active && active->getActiveResponses(IFilter::IKEYNONPRINTRELEASE))
    active->keyReleaseNP(code);
}

////////////////////////////////////////////////////////////////////////////////

void GUIBase::keyPressPrintable(I_SRC, sint32 ch)
{
  if (state & BROADCASTPASSIVE)
    root->recKeyPress(ch);
  if (active && active->getActiveResponses(IFilter::IKEYPRINTPRESS))
    active->keyPress(ch);
}

////////////////////////////////////////////////////////////////////////////////

void GUIBase::keyReleasePrintable(I_SRC, sint32 ch)
{
  if (state & BROADCASTPASSIVE)
    root->recKeyRelease(ch);
  if (active && active->getActiveResponses(IFilter::IKEYPRINTRELEASE))
    active->keyRelease(ch);
}

////////////////////////////////////////////////////////////////////////////////

void GUIBase::mousePress(I_SRC, uint32 code)
{
  X_INFO("GUIBase::mousePress()");
  if (code == Mouse::KEYLEFT || code == Mouse::KEYRIGHT)
  {
    // did the user click outside the currently active GUIObjects hit area?
    if (!active || active->coordHit(getMouseX(), getMouseY())==false)
    {
      setActive(find(getMouseX(), getMouseY()));
    }
  }
  if (state & BROADCASTPASSIVE)
    root->recMousePress(getMouseX(), getMouseY(), code);
  if (active && active->getActiveResponses(IFilter::IMOUSEPRESS))
    active->mousePress(getMouseX(), getMouseY(), code);
}

////////////////////////////////////////////////////////////////////////////////

void GUIBase::mouseRelease(I_SRC, uint32 code)
{
  X_INFO("GUIBase::mouseRelease()");
  if (state & BROADCASTPASSIVE)
    root->recMouseRelease(getMouseX(), getMouseY(), code);
  if (active && active->getActiveResponses(IFilter::IMOUSERELEASE))
    active->mouseRelease(getMouseX(), getMouseY(), code);
}

////////////////////////////////////////////////////////////////////////////////

void GUIBase::mouseMove(I_SRC, S_XYDXDY)
{
  if (state & BROADCASTPASSIVE)
    root->recMouseMove(x, y, dx, dy);
  if (active && active->getActiveResponses(IFilter::IMOUSEMOVE))
    active->mouseMove(x, y, dx, dy);
}

////////////////////////////////////////////////////////////////////////////////

void GUIBase::mouseDrag(I_SRC, S_XYDXDY, uint32 s)
{
  X_INFO("GUIBase::mouseDrag()");
  if (state & BROADCASTPASSIVE)
    root->recMouseDrag(x, y, dx, dy, s);
  if (active && active->getActiveResponses(IFilter::IMOUSEDRAG))
    active->mouseDrag(x, y, dx, dy, s);
}

////////////////////////////////////////////////////////////////////////////////

void GUIBase::mouseScroll(I_SRC, S_XY)
{
  if (state & BROADCASTPASSIVE)
    root->recMouseScroll(x, y);
  if (active && active->getActiveResponses(IFilter::IMOUSESCROLL))
    active->mouseScroll(x, y);
}

////////////////////////////////////////////////////////////////////////////////

void GUIBase::setActive(GUIObject* o)
{
  if (o!=active)
  {
    if (active)
      active->deactivate();
    if (o)
      o->activate();
    active = o;
  }
}

////////////////////////////////////////////////////////////////////////////////
//
//  Renderable
//
////////////////////////////////////////////////////////////////////////////////

sint32 Renderable::draw(Draw2D* g)
{
  if (!g)
    return ERR_RSC_UNAVAILABLE;
  sint32 r = g->begin();
  if (r==OK)
  {
    r = render(g);
    g->end();
  }
  return r;
};