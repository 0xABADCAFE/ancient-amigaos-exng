//****************************************************************************//
//**                                                                        **//
//** File:         libsrc/plat/amigaos3_68k/gfxlib/dispinput.cpp            **//
//** Description:                                                           **//
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

#include <gfxlib/gfx.hpp>

namespace X_SYSNAME {
  extern "C" {
    #include <proto/keymap.h>
    #include <proto/dos.h>
  }
};

using namespace X_SYSNAME;

sint32  _NatDisplay::mapChar(IntuiMessage* m)
{ // Generate a keyboard mapped character from the intuition message
  if (!m || ((m->Code & 0x7F) > 0x40)) {
    return 0;
  }
  else {
    InputEvent  inputEvent = {
      0,
      IECLASS_RAWKEY,
      0,
      m->Code,
      m->Qualifier
    };
    inputEvent.ie_EventAddress = *((uint8**)(m->IAddress));
    char mapped[2] = "";
    MapRawKey(&inputEvent, mapped, 2, 0);
    return (sint32)mapped[0];
  }
}

////////////////////////////////////////////////////////////////////////////////

void _NatDisplay::applyFilter(uint32 r)
{  // Adjust IDCMP input filter to best match the input mask
  if (win) {
    uint32 IDCMPflags = 0;
    IDCMPflags |= (r & IFilter::IKEYEVENTS)  ? IDCMP_RAWKEY : 0;
    IDCMPflags |= (r & (IFilter::IMOUSEKEYS|IFilter::IMOUSEDRAG))  ? IDCMP_MOUSEBUTTONS : 0;
    IDCMPflags |= (r & (IFilter::IMOUSEMOVE|IFilter::IMOUSEDRAG))  ? IDCMP_MOUSEMOVE : 0;
    IDCMPflags |= (r & IFilter::ICLOSE) ? IDCMP_CLOSEWINDOW : 0;
    ModifyIDCMP(win, IDCMPflags);
    SetMouseQueue(win, 4);
  }
/*
  else
    printf(
      "_NatDisplay::applyFilter() - DisplayWindow::win [0x%08X] is NULL!\n",
      (unsigned)(&(win)));
*/
}

////////////////////////////////////////////////////////////////////////////////

bool  _NatDisplay::waitEvent()
{
  uint32 eventSignal = 1UL<<win->UserPort->mp_SigBit;
  if ((Wait(eventSignal|SIGBREAKF_CTRL_C) & eventSignal)!=0) {
    return true;
  }
  return false;
}

////////////////////////////////////////////////////////////////////////////////

bool  _NatDisplay::handleEvent(InputDispatcher* d)
{  // Handles a single event in the input queue. Returns true if events are
  // still pending
  IntuiMessage* msg = (IntuiMessage*)GetMsg(win->UserPort);
  if (msg) {
    switch (msg->Class) {
      case IDCMP_RAWKEY: {
        sint32 ch = mapChar(msg);
        if (ch) {
          dispatchKeyPrintable(d, ch, ((msg->Code & 0x80UL)==0));
        }
        else {
          dispatchKey(d, getNPCode(msg->Code & 0x7FUL), ((msg->Code & 0x80UL)==0));
        }
      } break;

      case IDCMP_MOUSEBUTTONS: {
        switch(msg->Code) {
          case SELECTDOWN:
            dispatchMouseKey(d, Mouse::KEYLEFT, true);
            break;
          case MIDDLEDOWN:
            dispatchMouseKey(d, Mouse::KEYCENTRE, true);
            break;
          case MENUDOWN:
            dispatchMouseKey(d, Mouse::KEYRIGHT, true);
            break;
          case SELECTUP:
            dispatchMouseKey(d, Mouse::KEYLEFT, false);
            break;
          case MIDDLEUP:
            dispatchMouseKey(d, Mouse::KEYCENTRE, false);
            break;
          case MENUUP:
            dispatchMouseKey(d, Mouse::KEYRIGHT, false);
            break;
        }
      } break;

      case IDCMP_MOUSEMOVE: {
        sint16  mouseX  = msg->MouseX-(win->BorderLeft);
        sint16  mouseY  = msg->MouseY-(win->BorderTop);
        dispatchMove(d, mouseX, 0, width-1, mouseY, 0, height-1);
      }  break;

      case IDCMP_CLOSEWINDOW:
        dispatchExit(d);
        break;

      default:
        break;
    }
    ReplyMsg((Message*)msg);
    return true;
  }
  return false;
}

////////////////////////////////////////////////////////////////////////////////

void  _NatDisplay::discardQueue()
{ // discards any pending intuition messages
  if (win) {
    Message* dummy = 0;
    while(dummy = GetMsg(win->UserPort)) {
      ReplyMsg(dummy);
    }
  }
}

////////////////////////////////////////////////////////////////////////////////

bool  _NatDisplay::inputQueued()
{
  return false;
}

////////////////////////////////////////////////////////////////////////////////
