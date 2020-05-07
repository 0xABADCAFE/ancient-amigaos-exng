//****************************************************************************//
//**                                                                        **//
//** File:         include/plats/amigaos3_68k/systemlib/timer.hpp           **//
//** Description:  Timer and delay services                                 **//
//** Comment(s):                                                            **//
//** Library:      systemlib                                                **//
//** Created:      2003-02-08                                               **//
//** Updated:      2003-03-03                                               **//
//** Author(s):    Karl Churchill                                           **//
//** Note(s):                                                               **//
//** Copyright:    (C)1996-2003, eXtropia Studios                           **//
//**               Serkan YAZICI, Karl Churchill                            **//
//**               All Rights Reserved.                                     **//
//**                                                                        **//
//****************************************************************************//

#ifndef _EXTROPIA_SYSTEMLIB_TIMER_NATIVE_HPP
#define _EXTROPIA_SYSTEMLIB_TIMER_NATIVE_HPP

namespace X_SYSNAME {
  extern "C" {
    #include <proto/timer.h>
  }
};

////////////////////////////////////////////////////////////////////////////////
//
//  class MilliClock
//
////////////////////////////////////////////////////////////////////////////////

class MilliClock {
  public:
    void      set()      { X_SYSNAME::ReadEClock(&mark); }
    uint32    elapsed() const ;
    float64    elapsedFrac() const;

  public:
    MilliClock() { clockFreq = X_SYSNAME::ReadEClock(&mark); }

  private:
    static uint32          clockFreq;
    X_SYSNAME::EClockVal  mark;
};


////////////////////////////////////////////////////////////////////////////////
//
//  class Clock
//
////////////////////////////////////////////////////////////////////////////////

class Clock {
  public:
    void    set() {
      X_SYSNAME::GetSysTime(&mark);
      t.ms = 0;
    }
    const Time&    elapsed() const;
    const Time&    last()    const { return t; }

  public:
    Clock() { set(); }

  private:
    X_SYSNAME::timeval  mark;
    mutable Time        t;
};

#endif
