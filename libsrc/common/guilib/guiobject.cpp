//****************************************************************************//
//**                                                                        **//
//** File:         libsrc/common/guilib/guiobject.cpp                       **//
//** Description:  GUIObject base class definition                          **//
//** Comment(s):   All GUIObjects must be derived from this                 **//
//** Library:      guilib                                                   **//
//** Created:      2003-02-08                                               **//
//** Updated:      2004-01-28                                               **//
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
//  GUIObject
//
////////////////////////////////////////////////////////////////////////////////

uint32 GUIObject::nextID = 0;

GUIObject::GUIObject() : Rect(), parent(0), zOrder(0), state(0), aFilter(0),
                         pFilter(0), eventType(0)
{
  myID = nextID++;
}

////////////////////////////////////////////////////////////////////////////////

GUIObject::GUIObject(S_XYWH, uint32 z, uint32 act, uint32 ina) :
  Rect(x, y, w, h), parent(0), zOrder(z), state(0), aFilter(act), pFilter(ina),
  eventType(0)
{
  myID = nextID++;
}

////////////////////////////////////////////////////////////////////////////////

GUIObject::~GUIObject()
{

}

////////////////////////////////////////////////////////////////////////////////

GUIObject* GUIObject::recFindHit(S_XY, GUIObject* curr)
{
  // Is this object above the current object and the coord inside?
  if (zOrder >= curr->zOrder && coordHit(x, y))
  {
    X_INFO("GUIObject::recFindHit() current object found");
    curr = this;
  }
  // Recursively test the children for the same conditions
  for (GUIObject* o = children.first(); o; o = children.next())
    curr = o->recFindHit(x, y, curr);

  return curr;
}

////////////////////////////////////////////////////////////////////////////////

void GUIObject::recKeyPressNP(Key::CtrlKey code)
{
  // A disabled object is a brick wall to input. No children will receive the
  // event either

  if (!(state & ENABLED))
    return;

  // If this object is listening for the KEYNONPRINTPRESS raw event and isn't
  // the currently active object, process the event

  if (this != GUIBase::getActive() &&
      getPassiveResponses(IFilter::IKEYNONPRINTPRESS))
    passKeyPressNP(code);

  // Pass the raw KEYNONPRINTPRESS event to all the children
  for (GUIObject* child = children.first(); child; child = children.next())
    child->recKeyPressNP(code);
}

////////////////////////////////////////////////////////////////////////////////

void GUIObject::recKeyReleaseNP(Key::CtrlKey code)
{
  if (!(state & ENABLED))
    return;

  if (this != GUIBase::getActive() &&
      getPassiveResponses(IFilter::IKEYNONPRINTRELEASE))
    passKeyReleaseNP(code);

  for (GUIObject* child = children.first(); child; child = children.next())
    child->recKeyReleaseNP(code);
}

////////////////////////////////////////////////////////////////////////////////

void GUIObject::recKeyPress(sint32 ch)
{
  if (!(state & ENABLED))
    return;

  if (this != GUIBase::getActive() &&
      getPassiveResponses(IFilter::IKEYPRINTPRESS))
    passKeyPress(ch);

  for (GUIObject* child = children.first(); child; child = children.next())
    child->recKeyPress(ch);
}

////////////////////////////////////////////////////////////////////////////////

void GUIObject::recKeyRelease(sint32 ch)
{
  if (!(state & ENABLED))
    return;

  if (this != GUIBase::getActive() &&
      getPassiveResponses(IFilter::IKEYPRINTRELEASE))
    passKeyRelease(ch);

  for (GUIObject* child = children.first(); child; child = children.next())
    child->recKeyRelease(ch);
}

////////////////////////////////////////////////////////////////////////////////

void GUIObject::recMousePress(S_XY, uint32 code)
{
  if (!(state & ENABLED))
    return;

  if (this != GUIBase::getActive() &&
      getPassiveResponses(IFilter::IMOUSEPRESS))
    passMousePress(x, y, code);

  for (GUIObject* child = children.first(); child; child = children.next())
    child->recMousePress(x, y, code);
}

////////////////////////////////////////////////////////////////////////////////

void GUIObject::recMouseRelease(S_XY, uint32 code)
{
  if (!(state & ENABLED))
    return;

  if (this != GUIBase::getActive() &&
      getPassiveResponses(IFilter::IMOUSERELEASE))
    passMouseRelease(x, y, code);

  for (GUIObject* child = children.first(); child; child = children.next())
    child->recMouseRelease(x, y, code);
}

////////////////////////////////////////////////////////////////////////////////

void GUIObject::recMouseMove(S_XYDXDY)
{
  if (!(state & ENABLED))
    return;

  if (this != GUIBase::getActive() &&
      getPassiveResponses(IFilter::IMOUSEMOVE))
    passMouseMove(x, y, dx, dy);

  for (GUIObject* child = children.first(); child; child = children.next())
    child->recMouseMove(x, y, dx, dy);
}

////////////////////////////////////////////////////////////////////////////////

void GUIObject::recMouseDrag(S_XYDXDY, uint32 s)
{
  if (!(state & ENABLED))
    return;

  if (this != GUIBase::getActive() &&
      getPassiveResponses(IFilter::IMOUSEDRAG))
    passMouseDrag(x, y, dx, dy, s);

  for (GUIObject* child = children.first(); child; child = children.next())
    child->recMouseDrag(x, y, dx, dy, s);
}

////////////////////////////////////////////////////////////////////////////////

void GUIObject::recMouseScroll(S_XY)
{
  if (!(state & ENABLED))
    return;

  if (this != GUIBase::getActive() &&
      getPassiveResponses(IFilter::IMOUSESCROLL))
    passMouseScroll(x, y);

  for (GUIObject* child = children.first(); child; child = children.next())
    child->recMouseScroll(x, y);
}

////////////////////////////////////////////////////////////////////////////////

void GUIObject::updateListeners()
{
  for (GUIListener* listen = listeners.first(); listen; listen = listeners.next())
    listen->handleGUIEvent(this);
}

////////////////////////////////////////////////////////////////////////////////

bool GUIObject::coordHit(S_XY)
{
  // This is the default behaviour, subclasses may override this
  if (x>=getX() && x<=getX2() && y>=getY() && y<=getY2())
    return true;
  return false;
}

////////////////////////////////////////////////////////////////////////////////

bool GUIObject::addChild(GUIObject* o)
{
  if (o && o != this && o->parent == 0)
  {
    if (children.contains(o))
      return true;
    if (children.insertLast(o)==true)
    {
      o->parent = this;
      return true;
    }
  }
  return false;
}

////////////////////////////////////////////////////////////////////////////////

bool GUIObject::removeChild(GUIObject* o)
{
  if (o && o != this && o->parent == this)
  {
    if (children.removeLast(o)==true)
    {
      o->parent = 0;
      return true;
    }
  }
  return false;
}

////////////////////////////////////////////////////////////////////////////////

bool GUIObject::addListener(GUIListener* l)
{
  if (l)
  {
    if (listeners.contains(l))
      return true;
    return listeners.insertLast(l);
  }
  return false;
}

////////////////////////////////////////////////////////////////////////////////

bool GUIObject::removeListener(GUIListener* l)
{
  if (l)
    return listeners.removeLast(l);
  return false;
}
