//****************************************************************************//
//**                                                                        **//
//** File:         include/iolib/inpdevs.hpp                                **//
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

#ifndef _EXTROPIA_IOLIB_INPDEVS_HPP
#define _EXTROPIA_IOLIB_INPDEVS_HPP

#include <xbase.hpp>
#include <utilitylib/keys.hpp>
#include <utilitylib/list.hpp>

////////////////////////////////////////////////////////////////////////////////
//
//  Mouse class
//
////////////////////////////////////////////////////////////////////////////////

class Mouse {
  public:
    enum {// mouse keys
      KEY1        = 0x00000001,
      KEY2        = 0x00000002,
      KEY3        = 0x00000004,
      KEY4        = 0x00000008,
      KEY5        = 0x00000010,
      KEYLEFT      = KEY1,
      KEYCENTRE    = KEY2,
      KEYRIGHT    = KEY3,
      WHEELUP      = 0x00010000,
      WHEELDOWN    = 0x00020000,
      WHEELLEFT    = 0x00040000,
      WHEELRIGHT  = 0x00080000
    };
};

////////////////////////////////////////////////////////////////////////////////
//
//  Key
//
////////////////////////////////////////////////////////////////////////////////

class Key {
  public:
    typedef enum {
      UNASSIGNABLE = 0,
      SPACE,
      BACKSP,
      TAB,
      ENTER,
      ESC,
      DEL,
      UP,
      DOWN,
      RIGHT,
      LEFT,
      F1,  F2,  F3,  F4,  F5,  F6,  F7,  F8,  F9,  F10, F11, F12,
      SHIFTL, SHIFTR,
      CAPSL,
      CTRL,
      ALTL, ALTR,
      NP_0, NP_1, NP_2, NP_3, NP_4, NP_5, NP_6, NP_7, NP_8, NP_9,
      NP_INS,
      NP_END,
      NP_DEL,
      NP_PNT,
      NP_ENT,
      NP_MINUS,
      NP_PLUS,
      NUM_NPKEYS
    } CtrlKey;
};


////////////////////////////////////////////////////////////////////////////////
//
//  IFilter Interface
//
//  Defines a set of filtering states and methods for maintaining them. These
//  are used by the InputDispatcher and InputFocus interfaces for controlling
//  which sorts of input are transmitted and received respectively.
//
////////////////////////////////////////////////////////////////////////////////

class IFilter {
  private:
    uint32  filter;

  protected:
    uint32  getIFilter() const {
      return filter;
    }

    uint32  checkIFilter(uint32 f) const {
      return filter & f;
    }

    uint32  enableIFilter(uint32 f);
    uint32  disableIFilter(uint32 f);
    uint32  toggleIFilter(uint32 f);
    uint32  setIFilter(uint32 f);

  protected:
    IFilter(uint32 f) : filter(f) {}

  public:
    enum {
      // Individual input response states
      IKEYPRINTPRESS      = 0x00000001,
      IKEYNONPRINTPRESS    = 0x00000002,
      IKEYPRINTRELEASE    = 0x00000004,
      IKEYNONPRINTRELEASE  = 0x00000008,
      IMOUSELEFTPRESS      = 0x00000010,
      IMOUSECENTREPRESS    = 0x00000020,
      IMOUSERIGHTPRESS    = 0x00000040,
      IMOUSEOTHERPRESS    = 0x00000080,
      IMOUSELEFTRELEASE    = 0x00000100,
      IMOUSECENTRERELEASE  = 0x00000200,
      IMOUSERIGHTRELEASE  = 0x00000400,
      IMOUSEOTHERRELEASE  = 0x00000800,
      IMOUSENOCLIP        = 0x00001000,
      IMOUSEMOVE          = 0x00002000,
      IMOUSEDRAG          = 0x00004000,
      IMOUSESCROLLX        = 0x00008000,
      IMOUSESCROLLY        = 0x00010000,
      ICLOSE              = 0x80000000,

      // Input response masks
      IKEYPRESS        = IKEYPRINTPRESS|IKEYNONPRINTPRESS,
      IKEYRELEASE      = IKEYPRINTRELEASE|IKEYNONPRINTRELEASE,
      IKEYEVENTS      = IKEYPRESS|IKEYRELEASE,
      IMOUSEPRESS      = IMOUSELEFTPRESS|IMOUSECENTREPRESS|IMOUSERIGHTPRESS,
      IMOUSERELEASE    = IMOUSELEFTRELEASE|IMOUSECENTRERELEASE|IMOUSERIGHTRELEASE,
      IMOUSEKEYS      = IMOUSEPRESS|IMOUSERELEASE,
      IMOUSESCROLL    = IMOUSESCROLLX|IMOUSESCROLLY,
      IMOUSEEVENTS    = IMOUSEKEYS|IMOUSEMOVE|IMOUSEDRAG|IMOUSESCROLL,
      IDEFAULT        = IKEYEVENTS|IMOUSEEVENTS
    };

};

////////////////////////////////////////////////////////////////////////////////
//
//  InputDispatcher interface
//
//  The InputDispatcher interface is overriden by some system dependent class
//  to provide the basis for input handling. Each InputDispatcher maintains a
//  list of InputFocus to which the generated input is sent (by calling the
//  given InputFocus' event methods).
//
//  The IFilter interface is implemented to provide event filtering.
//  Any filters applied to the InputDispatcher prevent events propagating to
//  the InputFocus registered with it.
//
////////////////////////////////////////////////////////////////////////////////

class InputFocus;

class InputDispatcher : protected IFilter {
  friend class InputDispatcherUser;
  friend class InputFocus;
  private:
    RefList<InputFocus> foci;    // reference list of filters
    Key32                idKey;  // unique key for this Dispatcher (optional)

  protected:
    void  dispatchKey(Key::CtrlKey k, bool state);
    void  dispatchKeyPrintable(sint32 ch, bool state);
    void  dispatchMove(sint16 x, sint16 xMin, sint16 xMax, sint16 y, sint16 yMin, sint16 yMax);
    void  dispatchMouseKey(uint32 key, bool state);
    void  dispatchMouseScroll(sint16 dx, sint16 dy);
    void  dispatchExit();

    // Subclass needs to override these
    virtual void  discardQueue() = 0;    // Discard any pending events

    // filter setup
  protected:
    virtual void applyFilter() = 0;

    void    setIDKey(const char* name) {
      idKey = name;
    }

  public:
    Key32    getIDKey()          const { return idKey; }
    uint32  getDispatchFilter()  const { return getIFilter(); }
    uint32  checkDispatchFilter(uint32 f) { return checkIFilter(f); }

    uint32  enableDispatchFilter(uint32 f) {
      uint32 r = enableIFilter(f);
      applyFilter();
      return r;
    }

    uint32  disableDispatchFilter(uint32 f) {
      uint32 r = disableIFilter(f);
      applyFilter();
      return r;
    }

    uint32  toggleDispatchFilter(uint32 f) {
      uint32 r = toggleIFilter(f);
      applyFilter();
      return r;
    }

    uint32  setDispatchFilter(uint32 f) {
      uint32 r = setIFilter(f);
      applyFilter();
      return r;
    }

    bool    addFocus(InputFocus* f) {
      // Attempts to add a focus. Returns true if focus was already in the list.
      if (f && !foci.contains(f)) {
        return foci.insertLast(f);
      }
      return false;
    }

    bool    removeFocus(InputFocus* f) {
      // Attempts to remove a focus from the list. Returns true if the focus was removed
      if (f) {
        return foci.removeLast(f);
      }
      return false;
    }

    bool    hasFocus(InputFocus* f) const {
      // Checks if a focus is in the list
      if (f) {
        return foci.contains(f);
      }
      return false;
    }

    // Subclass needs to override these
    virtual bool  waitEvent()            = 0;  // Waits for an event to occur
    virtual bool  handleEvent()          = 0;  // Handles an event in the queue
    virtual bool  inputQueued()          = 0;  // Checks if events are still pending

  protected:
    InputDispatcher() : IFilter(0), idKey() {}
    InputDispatcher(uint32 f) : IFilter(f), idKey() {}
    InputDispatcher(uint32 f, const char* name) : IFilter(f), idKey(name) {}

  public:
    virtual ~InputDispatcher() {}

};

////////////////////////////////////////////////////////////////////////////////
//
//  InputFocus interface
//
////////////////////////////////////////////////////////////////////////////////

#define I_SRC InputDispatcher* src

class InputFocus : public IFilter {
  friend class InputDispatcher;
  private:
    Key::CtrlKey  lastCtrlD;
    Key::CtrlKey  lastCtrlU;
    sint32        lastCharD;
    sint32        lastCharU;
    uint32        lastM;
    sint16        lastX;
    sint16        lastY;
    sint16        deltaX;
    sint16        deltaY;
    sint16        lastSX;
    sint16        lastSY;

  public:
    uint32        getMouseKeys()            const { return lastM; }
    sint16        getMouseX()                const { return lastX; }
    sint16        getMouseY()                const { return lastY; }
    sint16        getMouseDeltaX()          const { return deltaX; }
    sint16        getMouseDeltaY()          const { return deltaY; }
    sint16        getMouseScrollX()          const { return lastSX; }
    sint16        getMouseScrollY()          const { return lastSY; }
    sint32        getLastPrintPress()        const { return lastCharD; }
    sint32        getLastPrintRelease()      const { return lastCharU; }
    Key::CtrlKey  getLastNonPrintPress()    const { return lastCtrlD; }
    Key::CtrlKey  getLastNonPrintRelease()  const { return lastCtrlU; }

    // filter setup
    uint32  getFocusFilter()              const { return getIFilter(); }
    uint32  checkFocusFilter(uint32 f)     { return checkIFilter(f); }
    uint32  enableFocusFilter(uint32 f)    { return enableIFilter(f); }
    uint32  disableFocusFilter(uint32 f)  { return disableIFilter(f); }
    uint32  toggleFocusFilter(uint32 f)    { return toggleIFilter(f); }
    uint32  setFocusFilter(uint32 f)      { return setIFilter(f); }

  protected:
    // event handler methods, override as required
    virtual void keyPressNonPrintable(I_SRC, Key::CtrlKey code)                        {}
    virtual void keyReleaseNonPrintable(I_SRC, Key::CtrlKey code)                      {}
    virtual void keyPressPrintable(I_SRC, sint32 ch)                                  {}
    virtual void keyReleasePrintable(I_SRC, sint32 ch)                                {}
    virtual void mousePress(I_SRC, uint32 code)                                        {}
    virtual void mouseRelease(I_SRC, uint32 code)                                      {}
    virtual void mouseMove(I_SRC, sint16 x, sint16 y, sint16 dx, sint16 dy)            {}
    virtual void mouseDrag(I_SRC, sint16 x, sint16 y, sint16 dx, sint16 dy, uint32 s)  {}
    virtual void mouseScroll(I_SRC, sint16 dx, sint16 dy)                              {}
    virtual void exitEvent(I_SRC)                                                      {}

  protected:
    InputFocus(uint32 r);

  public:
    virtual ~InputFocus() {}
};


////////////////////////////////////////////////////////////////////////////////
//
//  Native classes
//
////////////////////////////////////////////////////////////////////////////////

class Joystick;

#if defined(XP_AMIGAOS3_68K)
  #include "plat/amigaos3_68k/iolib/inpdevs.hpp"
#elif defined(XP_AMIGAOS3_PPC)
  #include "plat/amigaos3_wos/iolib/inpdevs.hpp"
#elif defined(XP_AMIGAOS4)
  #include "plat/amigaos4/iolib/inpdevs.hpp"
#elif defined(XP_AROS_BE)
  #include "plat/aros_be/iolib/inpdevs.hpp"
#elif defined(XP_AROS_LE)
  #include "plat/aros_le/iolib/inpdevs.hpp"
#elif defined(XP_MORPHOS)
  #include "plat/morphos/iolib/inpdevs.hpp"
#elif defined(XP_LINUX_PPC)
  #include "plat/linux_ppc/iolib/inpdevs.hpp"
#elif defined(XP_LINUX_X86)
  #include "plat/linux_i386/iolib/inpdevs.hpp"
#elif defined(XP_WIN9X)
  #include "plat/win9x/iolib/inpdevs.hpp"
#elif defined(XP_WIN2K)
  #include "plat/win2k/iolib/inpdevs.hpp"
#elif defined(XP_MACOSX)
  #include "plat/macosx/iolib/inpdevs.hpp"
#else
  #error "Platform implementation not defined"
#endif

#endif