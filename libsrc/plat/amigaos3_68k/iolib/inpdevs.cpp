//****************************************************************************//
//**                                                                        **//
//** File:         libsrc/plat/amigaos3_68k/iolib/inpdevs.cpp               **//
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

namespace X_SYSNAME {
  extern "C" {
    #include <intuition/intuitionbase.h>
    #include <proto/keymap.h>
  }
};

using namespace X_SYSNAME;

Library*  KeyMapBase              = 0;
sint32     _NatInput::openCount  = 0;

////////////////////////////////////////////////////////////////////////////////
//
//  _NatInput
//
////////////////////////////////////////////////////////////////////////////////

uint8 _NatInput::nonPrintMap[128] =
{
  Key::UNASSIGNABLE,  // 0x00
  Key::UNASSIGNABLE,  // 0x01
  Key::UNASSIGNABLE,  // 0x02
  Key::UNASSIGNABLE,  // 0x03
  Key::UNASSIGNABLE,  // 0x04
  Key::UNASSIGNABLE,  // 0x05
  Key::UNASSIGNABLE,  // 0x06
  Key::UNASSIGNABLE,  // 0x07
  Key::UNASSIGNABLE,  // 0x08
  Key::UNASSIGNABLE,  // 0x09
  Key::UNASSIGNABLE,  // 0x0A
  Key::UNASSIGNABLE,  // 0x0B
  Key::UNASSIGNABLE,  // 0x0C
  Key::UNASSIGNABLE,  // 0x0D
  Key::UNASSIGNABLE,  // 0x0E

  Key::NP_0,          // 0x0F

  Key::UNASSIGNABLE,  // 0x10
  Key::UNASSIGNABLE,  // 0x11
  Key::UNASSIGNABLE,  // 0x12
  Key::UNASSIGNABLE,  // 0x13
  Key::UNASSIGNABLE,  // 0x14
  Key::UNASSIGNABLE,  // 0x15
  Key::UNASSIGNABLE,  // 0x16
  Key::UNASSIGNABLE,  // 0x17
  Key::UNASSIGNABLE,  // 0x18
  Key::UNASSIGNABLE,  // 0x19
  Key::UNASSIGNABLE,  // 0x1A
  Key::UNASSIGNABLE,  // 0x1B
  Key::UNASSIGNABLE,  // 0x1C

  Key::NP_1,          // 0x1D
  Key::NP_2,          // 0x1E
  Key::NP_3,          // 0x1F

  Key::UNASSIGNABLE,  // 0x20
  Key::UNASSIGNABLE,  // 0x21
  Key::UNASSIGNABLE,  // 0x22
  Key::UNASSIGNABLE,  // 0x23
  Key::UNASSIGNABLE,  // 0x24
  Key::UNASSIGNABLE,  // 0x25
  Key::UNASSIGNABLE,  // 0x26
  Key::UNASSIGNABLE,  // 0x27
  Key::UNASSIGNABLE,  // 0x28
  Key::UNASSIGNABLE,  // 0x29
  Key::UNASSIGNABLE,  // 0x2A
  Key::UNASSIGNABLE,  // 0x2B
  Key::UNASSIGNABLE,  // 0x2C

  Key::NP_4,          // 0x2D
  Key::NP_5,          // 0x2E
  Key::NP_6,          // 0x2F

  Key::UNASSIGNABLE,  // 0x30
  Key::UNASSIGNABLE,  // 0x31
  Key::UNASSIGNABLE,  // 0x32
  Key::UNASSIGNABLE,  // 0x33
  Key::UNASSIGNABLE,  // 0x34
  Key::UNASSIGNABLE,  // 0x35
  Key::UNASSIGNABLE,  // 0x36
  Key::UNASSIGNABLE,  // 0x37
  Key::UNASSIGNABLE,  // 0x38
  Key::UNASSIGNABLE,  // 0x39
  Key::UNASSIGNABLE,  // 0x3A
  Key::UNASSIGNABLE,  // 0x3B

  Key::NP_PNT,        // 0x3C
  Key::NP_7,          // 0x3D
  Key::NP_8,          // 0x3E
  Key::NP_9,          // 0x3F
  Key::SPACE,          // 0x40
  Key::BACKSP,        // 0x41
  Key::TAB,            // 0x42
  Key::NP_ENT,        // 0x43
  Key::ENTER,          // 0x44
  Key::ESC,            // 0x45
  Key::DEL,            // 0x46

  Key::UNASSIGNABLE,  // 0x47
  Key::UNASSIGNABLE,  // 0x48
  Key::UNASSIGNABLE,  // 0x49

  Key::NP_MINUS,      // 0x4A

  Key::UNASSIGNABLE,  // 0x4B

  Key::UP,            // 0x4C
  Key::DOWN,          // 0x4D
  Key::RIGHT,          // 0x4E
  Key::LEFT,          // 0x4F
  Key::F1,            // 0x50
  Key::F2,            // 0x51
  Key::F3,            // 0x52
  Key::F4,            // 0x53
  Key::F5,            // 0x54
  Key::F6,            // 0x55
  Key::F7,            // 0x56
  Key::F8,            // 0x57
  Key::F9,            // 0x58
  Key::F10,            // 0x59

  Key::UNASSIGNABLE,  // 0x5A
  Key::UNASSIGNABLE,  // 0x5B
  Key::UNASSIGNABLE,  // 0x5C
  Key::UNASSIGNABLE,  // 0x5D

  Key::NP_PLUS,        // 0x5E

  Key::UNASSIGNABLE,  // 0x5F

  Key::SHIFTL,        // 0x60
  Key::SHIFTR,        // 0x61
  Key::CAPSL,          // 0x62
  Key::CTRL,          // 0x63
  Key::ALTL,          // 0x64
  Key::ALTR,          // 0x65
  Key::F11,            // 0x66 - Left Amiga
  Key::F12,            // 0x67 - Right Amiga

  Key::UNASSIGNABLE,  // 0x68
  Key::UNASSIGNABLE,  // 0x69
  Key::UNASSIGNABLE,  // 0x6A
  Key::UNASSIGNABLE,  // 0x6B
  Key::UNASSIGNABLE,  // 0x6C
  Key::UNASSIGNABLE,  // 0x6D
  Key::UNASSIGNABLE,  // 0x6E
  Key::UNASSIGNABLE,  // 0x6F
  Key::UNASSIGNABLE,  // 0x70
  Key::UNASSIGNABLE,  // 0x71
  Key::UNASSIGNABLE,  // 0x72
  Key::UNASSIGNABLE,  // 0x73
  Key::UNASSIGNABLE,  // 0x74
  Key::UNASSIGNABLE,  // 0x75
  Key::UNASSIGNABLE,  // 0x76
  Key::UNASSIGNABLE,  // 0x77
  Key::UNASSIGNABLE,  // 0x78
  Key::UNASSIGNABLE,  // 0x79
  Key::UNASSIGNABLE,  // 0x7A
  Key::UNASSIGNABLE,  // 0x7B
  Key::UNASSIGNABLE,  // 0x7C
  Key::UNASSIGNABLE,  // 0x7D
  Key::UNASSIGNABLE,  // 0x7E
  Key::UNASSIGNABLE  // 0x7F
};

_NatInput::_NatInput()
{
  if (0 == openCount++) {
    if ( !(KeyMapBase = OpenLibrary("keymap.library", 37)) )
      openCount = 0;
  }
}

////////////////////////////////////////////////////////////////////////////////

_NatInput::~_NatInput()
{
  if (--openCount == 0) {
    if (KeyMapBase) {
      CloseLibrary(KeyMapBase);
      KeyMapBase = 0;
    }
  }
  else if (openCount<0)
    openCount = 0;
}

////////////////////////////////////////////////////////////////////////////////

sint32 _NatInput::directReadMouseX()
{
  return IntuitionBase->MouseX;
}

////////////////////////////////////////////////////////////////////////////////

sint32 _NatInput::directReadMouseY()
{
  return IntuitionBase->MouseY;
}

////////////////////////////////////////////////////////////////////////////////

uint32 _NatInput::directReadMouseState()
{
  return 0;
}

////////////////////////////////////////////////////////////////////////////////

