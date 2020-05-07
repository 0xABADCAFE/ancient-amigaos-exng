//****************************************************************************//
//**                                                                        **//
//** File:         include/guilib/testgui.hpp                               **//
//** Description:  Test implementation of abstract gui                      **//
//** Comment(s):                                                            **//
//** Library:      guilib                                                   **//
//** Created:      2003-03-04                                               **//
//** Updated:      2003-03-04                                               **//
//** Author(s):    Karl Churchill                                           **//
//** Note(s):                                                               **//
//** Copyright:    (C)1996-2003, eXtropia Studios                           **//
//**               Serkan YAZICI, Karl Churchill                            **//
//**               All Rights Reserved.                                     **//
//**                                                                        **//
//****************************************************************************//

#ifndef _EXTROPIA_GUILIB_TEST_HPP
#define _EXTROPIA_GUILIB_TEST_HPP

#include <guilib/abstract.hpp>

class SimpleGUI {
  public:
    static Colour background;
    static Colour brightEdge;
    static Colour darkEdge;
    static Colour highlight;
    static Colour fill;
    static Colour stroke;
};

class SimpleButton : public AbstractButton, public Renderable {

  private:
    enum {
      DRAW_NORMAL      = 0,
      DRAW_MOUSEOVER  = 1,
      DRAW_SELECTED    = 2
    };
    uint16  drawState;

  protected:
    // AbstractButton
    void mouseOver();
    void mouseOut();
    void dragOver(uint32 c);
    void dragOut(uint32 c);
    void leftSelect();
    void leftRelease();
    void leftClicked();
    void rightSelect();
    void rightRelease();
    void rightClicked();
    void otherSelect(uint32 c);
    void otherRelease(uint32 c);
    void otherClicked(uint32 c);

    // Renderable
    sint32 render(Draw2D* gfx);

  public:
    // eventTypes for GUIObject::getEventType()
    enum {
      EVENT_MOUSEOVER    = 1,
      EVENT_MOUSEOUT    = 2,
      EVENT_LEFTCLICK    = 3,
      EVENT_RIGHTCLICK  = 4
    };

  public:
    SimpleButton(S_XYWH, uint32 z, Draw2D* g);
    ~SimpleButton();
};

#endif
