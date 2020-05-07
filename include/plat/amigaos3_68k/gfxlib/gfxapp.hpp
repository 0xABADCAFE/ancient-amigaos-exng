//****************************************************************************//
//**                                                                        **//
//** File:         include/plat/amigaos3_68k/gfxlib/gfxapp.hpp              **//
//** Description:  Display wrapper classes                                  **//
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

#ifndef _EXTROPIA_GFXLIB_GFXAPP_NATIVE_HPP
#define _EXTROPIA_GFXLIB_GFXAPP_NATIVE_HPP

////////////////////////////////////////////////////////////////////////////////
//
//  InteractiveDisplay
//
//  Shared AmigaOS input context code used by all display variants. Class uses
//  virtual base inheritance for DisplaNative and can thus be 'grafted' into
//  any DisplayNative derived display.
//
////////////////////////////////////////////////////////////////////////////////

class NativeDisplayHandler : private _NatInput, private _NatDisplayUser
{
  private:
    static sint32  mapChar(X_SYSNAME::IntuiMessage* m);

  // overidden from InputDispatcher
  protected:
    static void    applyFilter(_NatDisplay* d);
    static void    discardQueue(_NatDisplay* d);
    static bool    waitEvent(_NatDisplay* d);
    static bool    handleEvent(_NatDisplay* d);
    static bool    inputQueued(_NatDisplay* d);
};


#endif