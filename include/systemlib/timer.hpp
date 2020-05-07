//****************************************************************************//
//**                                                                        **//
//** File:         include/systemlib/timer.hpp                              **//
//** Description:  Timer and delay services                                 **//
//** Comment(s):   Stub header                                              **//
//** Library:      systemlib                                                **//
//** Created:      2003-02-08                                               **//
//** Updated:      2003-02-08                                               **//
//** Author(s):    Karl Churchill                                           **//
//** Note(s):                                                               **//
//** Copyright:    (C)1996-2003, eXtropia Studios                           **//
//**               Serkan YAZICI, Karl Churchill                            **//
//**               All Rights Reserved.                                     **//
//**                                                                        **//
//****************************************************************************//

#ifndef _EXTROPIA_SYSTEMLIB_TIMER_HPP
#define _EXTROPIA_SYSTEMLIB_TIMER_HPP

#include <xbase.hpp>


////////////////////////////////////////////////////////////////////////////////
//
//  Time
//
////////////////////////////////////////////////////////////////////////////////

/*
  Simple object used to represent a time interval stored as a signed number of
  milliseconds. Internally, the time value is stored to 64 bits, allowing for
  a range of -292271023 years to +292271023 years expressed to the nearest
  millisecond.

  Constructors
    public Time()
      Produces a zero initialised Time object

    public Time(sint32 secs, sint32 millis)
      Produces a Time object initialised with the values given. The internal
      number of milliseconds is thus 1000*secs + millis.

      Parameter                   Signifies

      sint32 secs                 Number of seconds.
      sint32 millis               Number of milliseconds.

    public Time(sint64 millis)
      Produces a Time object initialised with the value given.

      Parameter                   Signifies

      sint64 millis               Number of milliseconds.

  Destructor

  Public methods

    sint64 totMillis()
      Returns the total time expressed in milliseconds.

      Return value                Signifies

      sint64                      Overall time expressed in milliseconds.

    sint64 totSecs()
      Returns the total time expressed in seconds. The value is not rounded.

      Return value                Signifies

      sint64                      Overall time in seconds.

    sint64 totMins()
      Returns the total time expressed in minutes. The value is not rounded.

      Return value                Signifies

      sint64                      Overall time in minutes.

    sint64 totHours()
      Returns the total time expressed in hours. The value is not rounded.

      Return value                Signifies

      sint64                      Overall time in hours.

    sint64 totDays()
      Returns the total time expressed in days. The value is not rounded.

      Return value                Signifies

      sint64                      Elapsed time in days.


    sint32 days()
      Returns the total time expressed in days. The value returned is a
      normal 32-bit signed integer, which cannot fully express the total
      time range available (aproximately +/-1.0675E+11 days).

      Return value                Signifies

      sint32                      Elapsed time in days.

    sint32 millis()
      Returns the millisecond portion of the overall time.

      Return value                Signifies

      sint32                      Millisecond fragment of overall time (0-999).

    sint32 secs()
      Returns the second portion of the overall time.

      Return value                Signifies

      sint32                      Second fragment of overall time (0-59).

    sint32 mins()
      Returns the minute portion of the overall time.

      Return value                Signifies

      sint32                      Minute fragment of overall time (0-59).

    sint32 hours()
      Returns the minute portion of the overall time.

      Return value                Signifies

      sint32                      Hour fragment of overall time (0-23).

    void set(sint32 days, sint32 hours, sint32 mins, sint32 secs, sint32 millis)
      Sets the time value according to the parameters passed. Note that each fragment
      simply adds to the overall internal millisecond value and no range checking
      is performed.
*/

class Time {
  public:
    enum {
      // handy constants
      MILLIS_PER_SEC  = 1000,
      MILLIS_PER_MIN  = 60000,
      MILLIS_PER_HOUR  = 3600000,
      MILLIS_PER_DAY  = 86400000,
      SECS_PER_MIN    = 60,
      SECS_PER_HOUR    = 360,
      SECS_PER_DAY    = 86400,
      MINS_PER_HOUR    = 60,
      MINS_PER_DAY    = 1440,
      HOURS_PER_DAY    = 24
    };
    sint64  totMillis()  const { return ms; }
    sint64  totSecs()    const { return ms/MILLIS_PER_SEC; }
    sint64  totMins()    const { return ms/MILLIS_PER_MIN; }
    sint64  totHours()  const { return ms/MILLIS_PER_HOUR; }
    sint64  totDays()    const { return ms/MILLIS_PER_DAY; }
    sint32  days()      const { return (sint32)totDays(); }
    sint32  millis()    const { return (sint32)(ms%MILLIS_PER_SEC); }
    sint32  secs()       const { return (sint32)(totSecs()%SECS_PER_MIN); }
    sint32  mins()      const { return (sint32)(totMins()%MINS_PER_HOUR); }
    sint32  hours()      const { return (sint32)(totHours()%HOURS_PER_DAY); }

    void    set(sint32 days, sint32 hours, sint32 mins, sint32 secs, sint32 millis) {
      ms = (sint64)millis +
           ((sint64)secs*MILLIS_PER_SEC) +
           ((sint64)mins*MILLIS_PER_MIN) +
           ((sint64)hours*MILLIS_PER_HOUR) +
           ((sint64)days*MILLIS_PER_DAY);
    }

    Time& operator+=(const Time& t) {
      ms += t.ms;
      return *this;
    }

    Time& operator-=(const Time& t) {
      ms -= t.ms;
      return *this;
    }

  public:
    Time() : ms(0) {}
    Time(const Time& t) : ms(t.ms)   { }
    Time(sint64 millis) : ms(millis) { }
    Time(sint32 secs, sint32 millis) { ms = 1000*secs + millis; }

  private:
    sint64 ms;
    friend class Clock;

};

inline Time operator+(Time& a, Time& b)
{
  Time sum(a.totMillis() + b.totMillis());
  return sum;
}

inline Time operator-(Time& a, Time& b)
{
  Time diff(a.totMillis() - b.totMillis());
  return diff;
}

////////////////////////////////////////////////////////////////////////////////
//
//  Native classes
//
////////////////////////////////////////////////////////////////////////////////

class MilliClock;

/*
  Millisecond accurate timer class, used for short time interval measure. Gives
  accurate results for short time intervals (several seconds).

  Constructors
    public MilliClock()

  Destructor
    ~MilliClock()

  Public methods

    void set()
      Zeros the internal millisecond counter.

    uint32 elapsed() const
      Returns the number of milliseconds that have elapsed since the last call
      to set() or from when the object was instansiated if set() has not been
      called yet.

      Return value                Signifies

      uint32                      Elapsed time in milliseconds.

    float64 elapsedFrac() const
      Returns the fractional number of milliseconds that have elapsed since the
      last call to set() or from when the object was instansiated if set() has
      not been called yet. Is at least as accurate as elapsed(), but the total
      granularity is system dependent. It should not be depended on for very
      small intervals.

      Return value                Signifies

      float64                     Elapsed time in milliseconds.
*/

class Clock;

/*
  Millisecond precise timer class, used for long time interval measure. Unlike
  MilliClock, while time measurements are reported with millisecond precision,
  they are not necessarily millisecond accurate. Clock is stable over long periods
  of time (years).

  Constructors
    public Clock()

  Destructor
    public ~Clock()

  Public methods

    void set()
      Zeros the internal counter.

    Time& elapsed() const
      Returns the Time that has elapsed since the last call to set() or from when
      the object was instansiated if set() has not been called yet. For performance
      reasons, a reference to the Clock objects' internal timestamp is returned.

      Return value                Signifies

      const Time&                 Elapsed time expressed as a Time object.

    Time& last() const
      Returns the last recorded Time that was recorded by elapsed(). For performance
      reasons, a reference to the Clock objects' internal timestamp is returned.

      Return value                Signifies

      const Time&                 Last recorded Elapsed time expressed as a Time
                                  object.

*/

#if defined(XP_AMIGAOS3_68K)
  #include "plat/amigaos3_68k/systemlib/timer.hpp"
#elif defined(XP_AMIGAOS3_PPC)
  #include "plat/amigaos3_wos/systemlib/timer.hpp"
#elif defined(XP_AMIGAOS4)
  #include "plat/amigaos4/systemlib/timer.hpp"
#elif defined(XP_AROS_BE)
  #include "plat/aros_be/systemlib/timer.hpp"
#elif defined(XP_AROS_LE)
  #include "plat/aros_le/systemlib/timer.hpp"
#elif defined(XP_MORPHOS)
  #include "plat/morphos/systemlib/timer.hpp"
#elif defined(XP_LINUX_PPC)
  #include "plat/linux_ppc/systemlib/timer.hpp"
#elif defined(XP_LINUX_X86)
  #include "plat/linux_i386/systemlib/timer.hpp"
#elif defined(XP_WIN9X)
  #include "plat/win9x/systemlib/timer.hpp"
#elif defined(XP_WIN2K)
  #include "plat/win2k/systemlib/timer.hpp"
#elif defined(XP_MACOSX)
  #include "plat/macosx/systemlib/timer.hpp"
#else
  #error "Platform implementation not defined"
#endif

#endif
