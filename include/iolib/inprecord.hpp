//****************************************************************************//
//**                                                                        **//
//** File:         include/iolib/inprecord.hpp                              **//
//** Description:  input device classes                                     **//
//** Comment(s):   Stub header                                              **//
//** Library:      iolib                                                    **//
//** Created:      2003-02-17                                               **//
//** Updated:      2003-02-18                                               **//
//** Author(s):    Karl Churchill                                           **//
//** Note(s):                                                               **//
//** Copyright:    (C)1996-2003, eXtropia Studios                           **//
//**               Serkan YAZICI, Karl Churchill                            **//
//**               All Rights Reserved.                                     **//
//**                                                                        **//
//****************************************************************************//

#ifndef _EXTROPIA_IOLIB_INPREC_HPP
#define _EXTROPIA_IOLIB_INPREC_HPP

#include <iolib/fileio.hpp>
#include <iolib/inpdevs.hpp>
#include <systemlib/timer.hpp>

class SimpleEvent {
  public:
    enum {
      KEY_PRESS_NONPRINTABLE    = 0,
      KEY_RELEASE_NONPRINTABLE,
      KEY_PRESS_PRINTABLE,
      KEY_RELEASE_PRINTABLE,
      MOUSE_PRESS,
      MOUSE_RELEASE,
      MOUSE_MOVE,
      MOUSE_DRAG,
      MOUSE_SCROLL,
      EXIT_EVENT
    };
};

////////////////////////////////////////////////////////////////////////////////
//
//  SimpleEventRecorder
//
//  Records events in textual format to a logfile
//
////////////////////////////////////////////////////////////////////////////////


class SimpleEventRecorder : public InputFocus {
  private:
    StreamOut*  eventFile;
    Clock        eventTimer;

    void timeStamp();

  protected:
    // InputFocus methods
    void keyPressNonPrintable(I_SRC, Key::CtrlKey code);
    void keyReleaseNonPrintable(I_SRC, Key::CtrlKey code);
    void keyPressPrintable(I_SRC, sint32 ch);
    void keyReleasePrintable(I_SRC, sint32 ch);
    void mousePress(I_SRC, uint32 code);
    void mouseRelease(I_SRC, uint32 code);
    void mouseMove(I_SRC, sint16 x, sint16 y, sint16 dx, sint16 dy);
    void mouseDrag(I_SRC, sint16 x, sint16 y, sint16 dx, sint16 dy, uint32 s);
    void mouseScroll(I_SRC, sint16 dx, sint16 dy);
    void exitEvent(I_SRC);

  public:
    sint32  open(const char* fileName);
    void    close();

  public:
    SimpleEventRecorder() : InputFocus(0xFFFFFFFF),
                            eventFile(0) {}
    ~SimpleEventRecorder();
};

////////////////////////////////////////////////////////////////////////////////
//
//  SimpleEventPlayer
//
//  Replays events from a logfile
//
////////////////////////////////////////////////////////////////////////////////
/*
class SimpleEventPlayer : public InputDispatcher {
  private:
    StreamIn*  eventFile;
    uint32    delayThreshold;
    Key32      source;
    uint32    event;
    uint32    code;
    sint16    x, y, dx, dy;

    void      readEvent();

  protected:
    // InputDispatcher methods
    void applyFilter();
    bool waitEvent();
    bool handleEvent();
    bool inputQueued();

  public:
    sint32  open(const char* fileName);
    sint32  play(bool noWait);
    void    close();
    Key32    eventSource() { return source; }

  public:
    // Anonymous InputDispatcher mode
    SimpleEventPlayer() : InputDispatcher(0xFFFFFFFF),
                          eventFile(0),
                          delayThreshold(20) {}

    // Named InputDispatcher mode
    SimpleEventPlayer(const char* name) : InputDispatcher(0xFFFFFFFF, name),
                                          eventFile(0),
                                          delayThreshold(20) {}
    ~SimpleEventPlayer();
};
*/
#endif