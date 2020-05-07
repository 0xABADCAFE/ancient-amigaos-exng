//****************************************************************************//
//**                                                                        **//
//** File:         testgui.cpp                                              **//
//** Description:  Simple implementations of Abstract GUI                   **//
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

#include "testgui.hpp"

Colour SimpleGUI::background(0xFFA0A0A0);
Colour SimpleGUI::brightEdge(0xFFFFFFFF);
Colour SimpleGUI::darkEdge(0xFF000000);
Colour SimpleGUI::stroke(0xFF000000);
Colour SimpleGUI::highlight(0xFFA0A0FF);
Colour SimpleGUI::fill(0xFF6060FF);


////////////////////////////////////////////////////////////////////////////////
//
//  SimpleButtom
//
////////////////////////////////////////////////////////////////////////////////

#define ACTIVE  (IFilter::IMOUSEKEYS|IFilter::IMOUSEDRAG|IFilter::IMOUSEMOVE)
#define PASSIVE (IFilter::IMOUSEMOVE)

SimpleButton::SimpleButton(S_XYWH, uint32 z, Draw2D* d) :
AbstractButton(x, y, w, h, z, ACTIVE, PASSIVE), Renderable(d), drawState(DRAW_NORMAL)
{
}

////////////////////////////////////////////////////////////////////////////////

SimpleButton::~SimpleButton()
{

}

////////////////////////////////////////////////////////////////////////////////

void SimpleButton::mouseOver()
{
  X_INFO("SimpleButton::mouseOver()");
  drawState = DRAW_MOUSEOVER;
  draw();
  setEventType(EVENT_MOUSEOVER);
  updateListeners();
}

////////////////////////////////////////////////////////////////////////////////

void SimpleButton::mouseOut()
{
  X_INFO("SimpleButton::mouseOut()");
  drawState = DRAW_NORMAL;
  draw();
  setEventType(EVENT_MOUSEOUT);
  updateListeners();
}

////////////////////////////////////////////////////////////////////////////////

void SimpleButton::dragOver(uint32 mKeys)
{
  X_INFO("SimpleButton::dragOver()");
  if (checkButtonState(BUT_LEFTSELECTED))
    drawState = DRAW_SELECTED;
  else
    drawState = DRAW_MOUSEOVER;
  draw();
}

////////////////////////////////////////////////////////////////////////////////

void SimpleButton::dragOut(uint32 mKeys)
{
  X_INFO("SimpleButton::dragOut()");
  drawState = DRAW_NORMAL;
  draw();
}

////////////////////////////////////////////////////////////////////////////////

void SimpleButton::leftSelect()
{
  X_INFO("SimpleButton::leftSelect()");
  drawState = DRAW_SELECTED;
  draw();
}

////////////////////////////////////////////////////////////////////////////////

void SimpleButton::leftRelease()
{
  X_INFO("SimpleButton::leftRelease()");
  if (checkButtonState(BUT_MOUSEOVER))
    drawState = DRAW_MOUSEOVER;
  else
    drawState = DRAW_NORMAL;
  draw();
}

////////////////////////////////////////////////////////////////////////////////

void SimpleButton::leftClicked()
{
  X_INFO("SimpleButton::leftClicked()");
  if (checkButtonState(BUT_MOUSEOVER))
    drawState = DRAW_MOUSEOVER;
  else
    drawState = DRAW_NORMAL;
  draw();
  setEventType(EVENT_LEFTCLICK);
  updateListeners();
}

////////////////////////////////////////////////////////////////////////////////

void SimpleButton::rightSelect()
{
  X_INFO("SimpleButton::rightSelect()");
}

////////////////////////////////////////////////////////////////////////////////

void SimpleButton::rightRelease()
{
  X_INFO("SimpleButton::rightRelease()");
}

////////////////////////////////////////////////////////////////////////////////

void SimpleButton::rightClicked()
{
  X_INFO("SimpleButton::rightClicked()");
  setEventType(EVENT_RIGHTCLICK);
  updateListeners();
}

////////////////////////////////////////////////////////////////////////////////

void SimpleButton::otherSelect(uint32 c)
{
  X_INFO("SimpleButton::otherSelect()");
}

////////////////////////////////////////////////////////////////////////////////

void SimpleButton::otherRelease(uint32 c)
{
  X_INFO("SimpleButton::otherRelease()");
}

////////////////////////////////////////////////////////////////////////////////

void SimpleButton::otherClicked(uint32 c)
{
  X_INFO("SimpleButton::otherClicked()");
}

////////////////////////////////////////////////////////////////////////////////

sint32 SimpleButton::render(Draw2D* g)
{
  switch (drawState) {
    case   DRAW_MOUSEOVER:
      g->fillRect(getX()+1, getY()+1, getX2()-1, getY2()-1, SimpleGUI::highlight);
      g->drawLine(getX(), getY2(), getX(), getY(), SimpleGUI::brightEdge);
      g->drawLine(getX(), getY(), getX2(), getY(), SimpleGUI::brightEdge);
      g->drawLine(getX2(), getY(), getX2(), getY2(), SimpleGUI::darkEdge);
      g->drawLine(getX2(), getY2(), getX(), getY2(), SimpleGUI::darkEdge);
      break;

    case DRAW_SELECTED:
      g->fillRect(getX()+1, getY()+1, getX2()-1, getY2()-1, SimpleGUI::fill);
      g->drawLine(getX(), getY2(), getX(), getY(), SimpleGUI::darkEdge);
      g->drawLine(getX(), getY(), getX2(), getY(), SimpleGUI::darkEdge);
      g->drawLine(getX2(), getY(), getX2(), getY2(), SimpleGUI::brightEdge);
      g->drawLine(getX2(), getY2(), getX(), getY2(), SimpleGUI::brightEdge);
      break;

    default:
      g->fillRect(getX()+1, getY()+1, getX2()-1, getY2()-1, SimpleGUI::background);
      g->drawLine(getX(), getY2(), getX(), getY(), SimpleGUI::brightEdge);
      g->drawLine(getX(), getY(), getX2(), getY(), SimpleGUI::brightEdge);
      g->drawLine(getX2(), getY(), getX2(), getY2(), SimpleGUI::darkEdge);
      g->drawLine(getX2(), getY2(), getX(), getY2(), SimpleGUI::darkEdge);
      break;
  }
  return OK;
}