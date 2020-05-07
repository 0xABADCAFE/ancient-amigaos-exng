//****************************************************************************//
//**                                                                        **//
//** File:         libsrc/common/iolib/inputcomm.cpp                        **//
//** Description:  Input device classes                                     **//
//** Comment(s):                                                            **//
//** Library:      iolib                                                    **//
//** Created:      2003-02-18                                               **//
//** Updated:      2003-02-20                                               **//
//** Author(s):    Karl Churchill                                           **//
//** Note(s):                                                               **//
//** Copyright:    (C)1996-2003, eXtropia Studios                           **//
//**               Serkan YAZICI, Karl Churchill                            **//
//**               All Rights Reserved.                                     **//
//**                                                                        **//
//****************************************************************************//

#include <iolib/inpdevs.hpp>


uint32 IFilter::enableIFilter(uint32 f)
{
  uint32 oldFilter = filter;
  filter |= f;
  return oldFilter;
}

////////////////////////////////////////////////////////////////////////////////

uint32 IFilter::disableIFilter(uint32 f)
{
  uint32 oldFilter = filter;
  filter &= ~f;
  return oldFilter;
}

////////////////////////////////////////////////////////////////////////////////

uint32 IFilter::toggleIFilter(uint32 f)
{
  uint32 oldFilter = filter;
  filter ^= f;
  return oldFilter;
}

////////////////////////////////////////////////////////////////////////////////

uint32 IFilter::setIFilter(uint32 f)
{
  uint32 m = filter;
  filter = f;
  return m;
}

////////////////////////////////////////////////////////////////////////////////
//
//  InputDispatcher
//
////////////////////////////////////////////////////////////////////////////////

void  InputDispatcher::dispatchKey(Key::CtrlKey key, bool state)
{
  // First check if the InputDispatcher is filtering the event
  if (state && !checkDispatchFilter(IFilter::IKEYNONPRINTPRESS))
    return;
  else if (!state && !checkDispatchFilter(IFilter::IKEYNONPRINTRELEASE))
    return;

  // Dispatch the key even to all the InputFocus in our list, each of which
  // can optionally filter the event or not.
  for (InputFocus* focus = foci.first(); focus; focus = foci.next()) {
    if (state && focus->checkFocusFilter(IFilter::IKEYNONPRINTPRESS)) {
      focus->lastCtrlD = key;
      focus->keyPressNonPrintable(this, key);
    }
    else if ((!state) && focus->checkFocusFilter(IFilter::IKEYNONPRINTRELEASE)) {
      focus->lastCtrlU = key;
      focus->keyReleaseNonPrintable(this, key);
    }
  }

}

////////////////////////////////////////////////////////////////////////////////

void  InputDispatcher::dispatchKeyPrintable(sint32 ch, bool state)
{
  // First check if the InputDispatcher is filtering the event
  if (state && !checkDispatchFilter(IFilter::IKEYPRINTPRESS))
    return;
  else if (!state && !checkDispatchFilter(IFilter::IKEYPRINTRELEASE))
    return;

  // Dispatch the event to all the InputFocus in our list, each of which
  // can optionally filter the event or not.
  for (InputFocus* focus = foci.first(); focus; focus = foci.next()) {
    if (state && focus->checkFocusFilter(IFilter::IKEYPRINTPRESS)) {
      focus->lastCharD = ch;
      focus->keyPressPrintable(this, ch);
    }
    else if ((!state) && focus->checkFocusFilter(IFilter::IKEYPRINTRELEASE)) {
      focus->lastCharU = ch;
      focus->keyReleasePrintable(this, ch);
    }
  }
}

////////////////////////////////////////////////////////////////////////////////

void  InputDispatcher::dispatchMove(sint16 x, sint16 xMin, sint16 xMax, sint16 y, sint16 yMin, sint16 yMax)
{
  if (!checkDispatchFilter(IFilter::IMOUSEDRAG|IFilter::IMOUSEMOVE))
    return;

  // Dispatch key event to all the InputFocus in our list, each of which
  // can optionally filter the event or not.
  for (InputFocus* focus = foci.first(); focus; focus = foci.next()) {
    if (!focus->checkFocusFilter(IFilter::IMOUSENOCLIP)) {
      x = Clamp::integer(x, xMin, xMax);
      y = Clamp::integer(y, yMin, yMax);
    }
    focus->deltaX  = x-focus->lastX;
    focus->lastX  = x;
    focus->deltaY  = y-focus->lastY;
    focus->lastY  = y;
    if ((focus->deltaY) || (focus->deltaX)) {
      // Only call the move handlers if the thing actually moved...
      // If dragging is enabled call the drag method whenever a mouse move occurs
      // whilst a key is active. Else call the move method, if moving is enabled
      if (focus->checkFocusFilter(IFilter::IMOUSEDRAG) && focus->lastM)
        focus->mouseDrag(this, x, y, focus->deltaX, focus->deltaY, focus->lastM);
      else if (focus->checkFocusFilter(IFilter::IMOUSEMOVE))
        focus->mouseMove(this, x, y, focus->deltaX, focus->deltaY);
    }
  }
}

////////////////////////////////////////////////////////////////////////////////

void  InputDispatcher::dispatchMouseKey(uint32 key, bool state)
{
  // First check if the InputDispatcher is filtering the event
  if (!checkDispatchFilter(IFilter::IMOUSEKEYS))
    return;

  // Dispatch the event to all the InputFocus in our list, each of which
  // can optionally filter the event or not.
  for (InputFocus* focus = foci.first(); focus; focus = foci.next()) {
    if (state) {
      focus->lastM |= key;
      switch (key) {
        case Mouse::KEYLEFT:
          if (focus->checkFocusFilter(IFilter::IMOUSELEFTPRESS))
            focus->mousePress(this, Mouse::KEYLEFT);
          break;
        case Mouse::KEYCENTRE:
          if (focus->checkFocusFilter(IFilter::IMOUSECENTREPRESS))
            focus->mousePress(this, Mouse::KEYCENTRE);
          break;
        case Mouse::KEYRIGHT:
          if (focus->checkFocusFilter(IFilter::IMOUSERIGHTPRESS))
            focus->mousePress(this, Mouse::KEYRIGHT);
          break;
        default:
          if (focus->checkFocusFilter(IFilter::IMOUSEOTHERPRESS))
            focus->mousePress(this, key);
          break;
      }
    }
    else {
      focus->lastM &= ~key;
      switch (key) {
        case Mouse::KEYLEFT:
          if (focus->checkFocusFilter(IFilter::IMOUSELEFTRELEASE))
            focus->mouseRelease(this, Mouse::KEYLEFT);
          break;
        case Mouse::KEYCENTRE:
          if (focus->checkFocusFilter(IFilter::IMOUSECENTRERELEASE))
            focus->mouseRelease(this, Mouse::KEYCENTRE);
          break;
        case Mouse::KEYRIGHT:
          if (focus->checkFocusFilter(IFilter::IMOUSERIGHTRELEASE))
            focus->mouseRelease(this, Mouse::KEYRIGHT);
          break;
        default:
          if (focus->checkFocusFilter(IFilter::IMOUSEOTHERRELEASE))
            focus->mouseRelease(this, key);
          break;
      }
    }
  }
}

////////////////////////////////////////////////////////////////////////////////

void InputDispatcher::dispatchMouseScroll(sint16 dx, sint16 dy)
{
  // First check if the InputDispatcher is filtering the event
  if (!checkDispatchFilter(IFilter::IMOUSESCROLL))
    return;

  // Dispatch the event to all the InputFocus in our list, each of which
  // can optionally filter the event or not.
  for (InputFocus* focus = foci.first(); focus; focus = foci.next()) {
    if ((dx && focus->checkFocusFilter(IFilter::IMOUSESCROLLX)) ||
        (dy && focus->checkFocusFilter(IFilter::IMOUSESCROLLY))) {
      focus->lastSX = dx;
      focus->lastSY = dy;
      focus->mouseScroll(this, dx, dy);
    }
  }
}

////////////////////////////////////////////////////////////////////////////////

void InputDispatcher::dispatchExit()
{
  // First check if the InputDispatcher is filtering the event
  if (!checkDispatchFilter(IFilter::ICLOSE))
    return;

  // Dispatch the event to all the InputFocus in our list, each of which
  // can optionally filter the event or not.
  for (InputFocus* focus = foci.first(); focus; focus = foci.next()) {
    focus->exitEvent(this);
  }
}

////////////////////////////////////////////////////////////////////////////////
//
//  InputFocus
//
////////////////////////////////////////////////////////////////////////////////

InputFocus::InputFocus(uint32 r) : IFilter(r),
                                   lastCtrlD(Key::UNASSIGNABLE), lastCtrlU(Key::UNASSIGNABLE),
                                   lastCharD(0), lastCharU(0), lastM(0), lastX(0), lastY(0),
                                   deltaX(0), deltaY(0), lastSX(0), lastSY(0)
{

}

////////////////////////////////////////////////////////////////////////////////
