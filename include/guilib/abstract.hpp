//****************************************************************************//
//**                                                                        **//
//** File:         include/guilib/abstract.hpp                              **//
//** Description:  Abstract GUI definitions                                 **//
//** Comment(s):                                                            **//
//** Library:      guilib                                                   **//
//** Created:      2004-01-28                                               **//
//** Updated:      2004-01-28                                               **//
//** Author(s):    Karl Churchill                                           **//
//** Note(s):                                                               **//
//** Copyright:    (C)1996-2003, eXtropia Studios                           **//
//**               Serkan YAZICI, Karl Churchill                            **//
//**               All Rights Reserved.                                     **//
//**                                                                        **//
//****************************************************************************//

#ifndef _EXTROPIA_GUILIB_ABSTRACT_HPP
#define _EXTROPIA_GUILIB_ABSTRACT_HPP

#include <guilib/guibase.hpp>
/*
class AbstractPanel : public GUIObject {
  protected:
    AbstractPanel() : GUIObject() {}
    AbstractPanel(S_XYWH, uint32 z, uint32 act, uint32 inact);
};
*/

////////////////////////////////////////////////////////////////////////////////
//
//  AbstractButton
//
////////////////////////////////////////////////////////////////////////////////

class AbstractButton : public GUIObject {

  private:
    uint32  state;

  protected:
    // Button states
    enum {
      BUT_MOUSEOVER     = 0x00000001,  // set when mouse is over button
      BUT_LEFTPRESSED   = 0x00000002,  // set while the left key is pressd
      BUT_RIGHTPRESSED  = 0x00000004,  // set while the right key is pressed
      BUT_LEFTSELECTED  = 0x00000008,
      BUT_RIGHTSELECTED = 0x00000010,
      BUT_SELECTED      = 0x00000018
    };

    // GUIObject active methods
    void mouseMove(S_XYDXDY);
    void mouseRelease(S_XY, uint32 code);
    void mousePress(S_XY, uint32 code);
    void mouseDrag(S_XYDXDY, uint32 s);

    // GUIObject passive methods
    void passMouseMove(S_XYDXDY);

    // Other GUIObject methods
    void setInactive()  { state = 0; }

    // Methods unique to AbstractButton
    uint32  checkButtonState(uint32 s) { return state & s; }

    virtual void mouseOver()            = 0;
    virtual void mouseOut()             = 0;
    virtual void dragOver(uint32 c)     = 0;
    virtual void dragOut(uint32 c)      = 0;
    virtual void leftSelect()           = 0;
    virtual void leftRelease()          = 0;
    virtual void leftClicked()          = 0;
    virtual void rightSelect()          = 0;
    virtual void rightRelease()         = 0;
    virtual void rightClicked()         = 0;
    virtual void otherSelect(uint32 c)  = 0;
    virtual void otherRelease(uint32 c) = 0;

  protected:
    AbstractButton() : GUIObject(), state(0) {}
    AbstractButton(S_XYWH, uint32 z, uint32 act, uint32 inact);

  public:
    ~AbstractButton() {}
};

#endif
