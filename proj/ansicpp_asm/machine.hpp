//****************************************************************************//
//**                                                                        **//
//** File:         machine.hpp                                              **//
//** Description:  Host Machine definitions                                 **//
//** Comment(s):   Internal developer version only                          **//
//** Library:                                                               **//
//** Created:      2005-08-29                                               **//
//** Updated:      2005-08-29                                               **//
//** Author(s):    Karl Churchill                                           **//
//** Note(s):      Stub replacement for needed exng/xbase.hpp defs          **//
//** Copyright:    (C)1996 - , eXtropia Studios                             **//
//**               Serkan YAZICI, Karl Churchill                            **//
//**               All Rights Reserved.                                     **//
//**                                                                        **//
//****************************************************************************//

#ifndef _VM_HOST_MACHINE_HPP_
#define _VM_HOST_MACHINE_HPP_
#include <cstdlib>

// this is just a gap filler for framework xbase definitions

typedef signed char sint8;
typedef signed short int sint16;
typedef signed long int sint32;
typedef signed long long int sint64;
typedef unsigned char uint8;
typedef unsigned short int uint16;
typedef unsigned long int uint32;
typedef unsigned long long int uint64;
typedef float float32;
typedef double float64;

#define rsint8 register sint8
#define rsint16 register sint16
#define rsint32 register sint32
#define rsint64 register sint64
#define ruint8 register uint8
#define ruint16 register uint16
#define ruint32 register uint32
#define ruint64 register uint64
#define rfloat32 register float32
#define rfloat64 register float64

#define XA_BIGENDIAN 0
#define XA_LITTLEENDIAN 1

// change this for other systems
#define _VM_HOST_LINUX_I386 1
#define _VM_HOST_WIN32_I386 2
#define _VM_HOST_AMIGAOS3_68K 3
#define _VM_HOST_AMIGAOS3_68K_ASM 4
#define _VM_HOST_AMIGAOS3_WARPUP 5

// only one of these must be uncommented
//#define _VM_HOST_OS _VM_HOST_WIN32_I386
//#define _VM_HOST_OS _VM_HOST_LINUX_I386
//#define _VM_HOST_OS _VM_HOST_AMIGAOS3_68K
#define _VM_HOST_OS _VM_HOST_AMIGAOS3_68K_ASM
//#define _VM_HOST_OS _VM_HOST_AMIGAOS3_WARPUP

#ifdef _ADD_TIMER_CLASS_

#if (_VM_HOST_OS == _VM_HOST_AMIGAOS3_68K) || (_VM_HOST_OS == _VM_HOST_AMIGAOS3_68K_ASM)
  #ifdef __PPC__
    #warning PowerPC directive set for AmigaOS 680x0 target, switching to warpos
    #undef _VM_HOST_OS
    #define _VM_HOST_OS _VM_HOST_AMIGAOS3_WARPUP
  #endif
#endif

#if _VM_HOST_OS == _VM_HOST_LINUX_I386
  #define X_ENDIAN XA_LITTLEENDIAN
  #include <sys/time.h>
  #include <time.h>
  #define _VM_USE_FUNCTION_HANDLERS

class MilliClock {
  friend class Clock;
  private:
    static struct timezone  tz;
    timeval mark;

  public:
    void      set()      { gettimeofday(&mark, &tz); }
    uint32    elapsed();
    float64    elapsedFrac();

  public:
    MilliClock() { set(); }
};

#elif _VM_HOST_OS == _VM_HOST_WIN32_I386
  #define X_ENDIAN XA_LITTLEENDIAN
  //#include <sys/types.h>
  //#include <sys/stat.h>
  #include <windows.h>
  #define _VM_USE_FUNCTION_HANDLERS

class MilliClock {
  private:
    uint32 mark;

  public:
    void      set()      { mark = GetTickCount(); }
    uint32    elapsed();
    float64    elapsedFrac();

  public:
    MilliClock() { set(); }
};

#elif (_VM_HOST_OS == _VM_HOST_AMIGAOS3_68K) || (_VM_HOST_OS == _VM_HOST_AMIGAOS3_68K_ASM)
  #define X_ENDIAN XA_BIGENDIAN
  #include <proto/timer.h>

  #if _VM_HOST_OS == _VM_HOST_AMIGAOS3_68K
    #define _VM_USE_FUNCTION_HANDLERS
  #endif

class MilliClock {
  private:
    static uint32  clockFreq;
    EClockVal      mark;

  public:
    void      set()      { ::ReadEClock(&mark); }
    uint32    elapsed();
    float64    elapsedFrac();

  public:
    MilliClock() { clockFreq = ::ReadEClock(&mark); }
};

#elif (_VM_HOST_OS == _VM_HOST_AMIGAOS3_WARPUP)
  #define X_ENDIAN XA_BIGENDIAN
  #include <devices/timer.h>
  #include <proto/powerpc.h>
  #define _VM_USE_FUNCTION_HANDLERS

class MilliClock {
  private:
    timeval    mark;

  public:
    void      set()      { ::GetSysTimePPC(&mark); }
    uint32    elapsed();
    float64    elapsedFrac();

  public:
    MilliClock() { set(); }
};

#else
  #error Unrecognised Machine
#endif

#endif

#endif
