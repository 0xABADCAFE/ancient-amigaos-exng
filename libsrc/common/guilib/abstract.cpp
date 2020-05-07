//****************************************************************************//
//**                                                                        **//
//** File:         libsrc/common/guilib/abstract.cpp                        **//
//** Description:  Abstract GUI definitions                                 **//
//** Comment(s):                                                            **//
//** Library:      guilib                                                   **//
//** Created:      2004-01-28                                               **//
//** Updated:      2004-01-28                                               **//
//** Author(s):    Karl Churchill, Serkan YAZICI                            **//
//** Note(s):                                                               **//
//** Copyright:    (C)1996-2003, eXtropia Studios                           **//
//**               Serkan YAZICI, Karl Churchill                            **//
//**               All Rights Reserved.                                     **//
//**                                                                        **//
//****************************************************************************//

#include <guilib/abstract.hpp>

////////////////////////////////////////////////////////////////////////////////
//
//  AbstractButton
//
////////////////////////////////////////////////////////////////////////////////

AbstractButton::AbstractButton(S_XYWH, uint32 z, uint32 act, uint32 inact) :
GUIObject(x, y, w, h, z, act, inact), state(0)
{

}

////////////////////////////////////////////////////////////////////////////////

void AbstractButton::mousePress(S_XY, uint32 code)
{
  // By virtue of GUIBase behaviour, left or right mouse press events for the
  // active object always occur inside its hit area, since clicking outside the
  // active object deactivates it.

  // AbstractButton resolves left and right clicks into seperate methods for
  // the subclass, but all other clicks are passed to the subclass to resolve.

  switch (code)
  {
    case Mouse::KEYLEFT:
      state |= BUT_LEFTPRESSED|BUT_MOUSEOVER;
      if (!(state & BUT_SELECTED))
      {
        state |= BUT_LEFTSELECTED;
        leftSelect();
      }
      break;

    case Mouse::KEYRIGHT:
      state |= BUT_RIGHTPRESSED|BUT_MOUSEOVER;
      if (!(state & BUT_SELECTED))
      {
        state |= BUT_RIGHTSELECTED;
        rightSelect();
      }
      break;

    default:
      if (coordHit(x, y)==true)
      {
        state |= BUT_MOUSEOVER;
        otherSelect(code);
      }
      else
        state &= ~BUT_MOUSEOVER;
      break;
  }
}

////////////////////////////////////////////////////////////////////////////////

void AbstractButton::mouseRelease(S_XY, uint32 code)
{
  // AbstractButton resolves left and right releases and leaves all others up
  // to the subclass.

  // Mouse release events are further resolved into clicks and releases. A click
  // is defined by a mouse press and release within the hit area.

  switch (code)
  {
    case Mouse::KEYLEFT:
      state &= ~BUT_LEFTPRESSED;
      // If the button is already selected, a release within the hit
      // area is interpreted as a click, else just a release
      if (coordHit(x, y)==true && (state & BUT_LEFTSELECTED))
      {
        state &= ~BUT_LEFTSELECTED;
        leftClicked();
      }
      else
      {
        state &= ~BUT_MOUSEOVER|BUT_LEFTSELECTED;
        // assuming no other selection is held, issue the release
        if (!(state & BUT_SELECTED))
          leftRelease();
      }
      break;

    case Mouse::KEYRIGHT:
      state &= ~BUT_RIGHTPRESSED;
      // If the button is already selected, a release within the hit
      // area is interpreted as a click, else just a release
      if (coordHit(x, y)==true && (state & BUT_RIGHTSELECTED))
      {
        state &= ~BUT_RIGHTSELECTED;
        rightClicked();
      }
      else
      {
        state &= ~BUT_MOUSEOVER|BUT_RIGHTSELECTED;
        // assuming no other selection is held, issue the release
        if (!(state & BUT_SELECTED))
          rightRelease();
      }
      break;

    default:
      if (coordHit(x, y) == false)
        state &= ~BUT_MOUSEOVER;
      otherRelease(code);
      break;
  }
}

////////////////////////////////////////////////////////////////////////////////

void AbstractButton::mouseMove(S_XYDXDY)
{
  if (coordHit(x, y)==true)
  {
    // has mouse just moved over?
    if (!(state & BUT_MOUSEOVER))
    {
      state |= BUT_MOUSEOVER;
      mouseOver();
    }
  }
  else
  {
    // has mouse just moved out?
    if (state & BUT_MOUSEOVER)
    {
      state &= ~BUT_MOUSEOVER;
      mouseOut();
    }
  }
}

////////////////////////////////////////////////////////////////////////////////

void AbstractButton::mouseDrag(S_XYDXDY, uint32 c)
{
  // InputFocus drag events are only defined as mouse moves with a mouse key
  // held down. For our button, we only invoke its drag methods if the button
  // is genuinely selected and interpret anything else as a mouse over/out

  if (!(state & BUT_SELECTED))
  {
    mouseMove(x, y, dx, y);
    return;
  }
  if (coordHit(x, y)==true)
  {
    // has mouse just moved over?
    if (!(state & BUT_MOUSEOVER))
    {
      state |= BUT_MOUSEOVER;
      dragOver(c);
    }
  }
  else
  {
    // has mouse just moved out?
    if (state & BUT_MOUSEOVER)
    {
      state &= ~BUT_MOUSEOVER;
      dragOut(c);
    }
  }
}

////////////////////////////////////////////////////////////////////////////////

void AbstractButton::passMouseMove(S_XYDXDY)
{
  mouseMove(x, y, dx, dy);
}

////////////////////////////////////////////////////////////////////////////////
