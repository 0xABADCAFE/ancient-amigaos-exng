//****************************************************************************//
//**                                                                        **//
//** File:         include/plat/amigaos3_68k/iolib/inpdevs.hpp              **//
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

#ifndef _EXTROPIA_IOLIB_INPDEVS_NATIVE_HPP
#define _EXTROPIA_IOLIB_INPDEVS_NATIVE_HPP

////////////////////////////////////////////////////////////////////////////////
//
//  InputDispatcherUsers
//
////////////////////////////////////////////////////////////////////////////////

class InputDispatcherUser {
  protected:
    static void  dispatchKey(InputDispatcher* i, Key::CtrlKey k, bool state) {
      i->dispatchKey(k, state);
    }
    static void  dispatchKeyPrintable(InputDispatcher* i, sint32 ch, bool state) {
      i->dispatchKeyPrintable(ch, state);
    }
    static void  dispatchMove(InputDispatcher* i, sint16 x, sint16 xMin, sint16 xMax, sint16 y, sint16 yMin, sint16 yMax) {
      i->dispatchMove(x, xMin, xMax, y, yMin, yMax);
    }
    static void  dispatchMouseKey(InputDispatcher* i, uint32 key, bool state) {
      i->dispatchMouseKey(key, state);
    }
    static void  dispatchMouseScroll(InputDispatcher* i, sint16 dx, sint16 dy) {
      i->dispatchMouseScroll(dx, dy);
    }
    static void  dispatchExit(InputDispatcher* i) {
      i->dispatchExit();
    }
};

////////////////////////////////////////////////////////////////////////////////
//
//  _NatInput class
//
//  Performs resource aquisition (keyboard translation etc) for classes that
//  rely on direct input.
//
////////////////////////////////////////////////////////////////////////////////


class _NatInput : public  InputDispatcherUser {
  private:
    static sint32  openCount;
    static uint8  nonPrintMap[128];

  protected:
    static Key::CtrlKey  getNPCode(uint8 native) {
      return (Key::CtrlKey)nonPrintMap[(native&0x7F)];
    }
    static sint32 directReadMouseX();
    static sint32 directReadMouseY();
    static uint32  directReadMouseState();
    _NatInput();
    ~_NatInput();
};



#endif