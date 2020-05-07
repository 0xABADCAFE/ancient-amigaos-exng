//****************************************************************************//
//**                                                                        **//
//** File:         libsrc/plats/amigaos3_68k/systemlib/timer.cpp            **//
//** Description:  Timer and delay services                                 **//
//** Comment(s):                                                            **//
//** Library:      systemlib                                                **//
//** Created:      2003-02-08                                               **//
//** Updated:      2003-02-09                                               **//
//** Author(s):    Karl Churchill                                           **//
//** Note(s):                                                               **//
//** Copyright:    (C)1996-2003, eXtropia Studios                           **//
//**               Serkan YAZICI, Karl Churchill                            **//
//**               All Rights Reserved.                                     **//
//**                                                                        **//
//****************************************************************************//

#include <systemlib/timer.hpp>

namespace X_SYSNAME {
  extern "C" {
    #include <clib/alib_protos.h>
  }
};

using namespace X_SYSNAME;

////////////////////////////////////////////////////////////////////////////////
//
//  MilliClock
//
////////////////////////////////////////////////////////////////////////////////

extern  Device*  TimerBase;

uint32  MilliClock::clockFreq = 0;

////////////////////////////////////////////////////////////////////////////////

uint32 MilliClock::elapsed() const
{
  EClockVal  current;
  ReadEClock(&current);
  ruint32 ticks;
  if (current.ev_hi == mark.ev_hi) {
    ticks = current.ev_lo - mark.ev_lo;
  }
  else {
    ticks = 0xFFFFFFFF-mark.ev_lo + current.ev_lo;
  }
  return (1000*ticks)/clockFreq;
}

float64 MilliClock::elapsedFrac() const
{
  EClockVal  current;
  ReadEClock(&current);
  float64 ticks;
  static float64 cF = 1000.0/(float64)clockFreq;
  if (current.ev_hi == mark.ev_hi) {
    ticks = (current.ev_lo - mark.ev_lo);
  }
  else {
    ticks = (0xFFFFFFFF-mark.ev_lo + current.ev_lo);
  }
  return (cF*ticks);
}

////////////////////////////////////////////////////////////////////////////////
//
//  Clock
//
////////////////////////////////////////////////////////////////////////////////

const Time& Clock::elapsed() const
{
  timeval current;
  GetSysTime(&current);
  SubTime(&current, &mark);
  t.ms  = ((current.tv_secs*1000)+(current.tv_micro/1000));
  return t;
}
