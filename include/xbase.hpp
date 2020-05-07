//****************************************************************************//
//**                                                                        **//
//** File:         include/xbase.hpp                                        **//
//** Description:  eXtropia Studios System Abstraction Toolkit              **//
//** Comment(s):   This file is topmost in directory structure              **//
//** Library:      Root                                                     **//
//** Created:      2003-02-08                                               **//
//** Updated:      2003-02-08                                               **//
//** Author(s):    Karl Churchill, Serkan YAZICI                            **//
//** Note(s):                                                               **//
//** Copyright:    (C)1996-2003, eXtropia Studios                           **//
//**               Serkan YAZICI, Karl Churchill                            **//
//**               All Rights Reserved.                                     **//
//**                                                                        **//
//****************************************************************************//

////////////////////////////////////////////////////////////////////////////////
//
//  APPLICATION DESIGN
//
//  Applications are defined as objects that are inherited from class AppBase.
//  In particular, application designers must not define the main() function.
//  The base library defines main() itself and configures the application
//  environment. An instance of the application is then created, executed and
//  finally destroyed.
//  Applications may inherit existing system library components to build more
//  complex designs whilst maintaining portability.
//
//
//  DIRECTORY TREE STRUCTURE
//
//  All portable projects must only include the stub headers for any given
//  library. This in turn will include the relavent definitions for the target
//  under compilation.
//
//  Items in square brackets represent multiple instances
//
//  Root
//  |
//  +--->include/ (must be part of default include search path)
//  |    |
//  |    +--->xbase.hpp
//  |    |
//  |    +--->[library name]/
//  |    |    |
//  |    |    +--->[normal header or stub for plaform dependent components]
//  |    |
//  |    +--->plat/
//  |         |
//  |         +--->[platform name]/
//  |              |
//  |              +--->base.hpp
//  |              |
//  |              +--->[library name]/
//  |                   |
//  |                   +--->[platform dependent header]
//  |
//  +--->libsrc/ (library source code)
//       |
//       +--->common/
//       |    |
//       |    +--->xbase.cpp
//       |    |
//       |    +--->[library name]/
//       |         |
//       |         +--->[platform indepenent source]
//       |
//       +--->plat/
//            |
//            +--->[platform name]/
//                 |
//                 +--->[library name]
//                 |    |
//                 |    +--->[platform dependent source]
//                 |
//                 +--->[compiler projects, lib files etc]
//
////////////////////////////////////////////////////////////////////////////////

#ifndef _EXTROPIA_BASE_HPP
#define _EXTROPIA_BASE_HPP

#ifndef __cplusplus
  #error "The eXtropia Studios System Toolkit is for C++ use only"
#endif

////////////////////////////////////////////////////////////////////////////////
//
//  ANSI INCLUDES
//
////////////////////////////////////////////////////////////////////////////////

extern "C" {
  #include <stdlib.h>
  #include <stdio.h>
  #include <stdarg.h>
  #include <stddef.h>
}

////////////////////////////////////////////////////////////////////////////////
//
//  VERSION
//
//  Extropia Studios Abstract System Toolkit
//
////////////////////////////////////////////////////////////////////////////////

#define XBASE_VERSION 0x0200
#define XBASE_RELEASE 0x0001

////////////////////////////////////////////////////////////////////////////////
//
//  Compilation options
//
////////////////////////////////////////////////////////////////////////////////

// Debugging level
#define X_DEBUG_NONE      0            // No debugging messages
#define X_DEBUG_ERRORS    1            // Error debug messages only
#define X_DEBUG_ALL       2            // Errors and warnings

#define X_DEBUG           X_DEBUG_ALL  // Selected debug level

// Debug message types
#define X_DEBUG_INFO      0
#define X_DEBUG_WARN      1
#define X_DEBUG_ERROR     2

#if X_DEBUG == X_DEBUG_NONE
  // No debug info
  #define X_WARN(text)
  #define X_ERROR(text)
#elif X_DEBUG == X_DEBUG_ERROR
  // Errors only (relax warnings)
  #define X_WARN(text)
  #define X_ERROR(text) SystemLib::printDebug((text), X_DEBUG_ERROR)
#elif X_DEBUG == X_DEBUG_ALL
  // Warnings and errors
  #define X_WARN(text)  SystemLib::printDebug((text), X_DEBUG_WARN)
  #define X_ERROR(text) SystemLib::printDebug((text), X_DEBUG_ERROR)
#else
  #error "Unknown X_BEBUG level"
#endif

// Verbosity
#define X_VERBOSE      // Use verbose info

#ifdef X_VERBOSE
  #define X_INFO(text) SystemLib::printDebug((text), X_DEBUG_INFO)
#else
  #define X_INFO(text)
#endif

// Optimisations
#define X_HANDCODED    // Use handcoded (asm) code


////////////////////////////////////////////////////////////////////////////////
//
//  TARGET PLATFORM
//
//  Only one of the targets may be #defined
//  Only 32-bit or higher targets are supported
//
////////////////////////////////////////////////////////////////////////////////

#define XP_AMIGAOS3_68K  // AmigaOS 3.x+
/*
#define XP_AMIGAOS3_PPC  // AmigaOS 3.x / WarpOS 4.x / 5.x
#define XP_AMIGAOS4      // AmigaOS 4.x PowerPC
#define XP_AROS_BE       // AROS Big Endian Implementation (68K/PPC)
#define XP_AROS_LE       // AROS Litte Endian Implementation (x86)
#define XP_MORPHOS       // MorphOS PowerPC
#define XP_LINUX_PPC     // Linux PowerPC
#define XP_LINUX_X86     // Linux i386
#define XP_WIN9X         // Windows 95/98/Me
#define XP_WIN2K         // Windows 2000/XP
#define XP_MACOSX        // MacOS X PPC
*/

////////////////////////////////////////////////////////////////////////////////
//
//  HARDWARE ARCHITECTURE SIGNATURE
//
//  Appropriate flags from the following are specified within the platform
//  dependent header.
//
////////////////////////////////////////////////////////////////////////////////

#define XA_ALIGNMASK    0x07 // Alignment Mask
#define XA_ALIGN8       0x00 // Byte Alignment
#define XA_ALIGN16      0x01 // Word Alignment
#define XA_ALIGN32      0x02 // DWord Alignment
#define XA_ALIGN64      0x03 // QWord Alignment
#define XA_ALIGN128     0x04 // 128-Bit Alignment
#define XA_ALIGN256     0x05 // 256-Bit Alignment
#define XA_ALIGN512     0x06 // 512-Bit Alignment
#define XA_ALIGN1K      0x07 // 1K-Bit Alignment
#define XA_PTRMASK      0x18 // Pointer Size Mask
#define XA_PTR32        0x00 // 32-Bit Pointers
#define XA_PTR64        0x08 // 64-Bit Pointers
#define XA_PTR96        0x10 // 96-Bit Pointers
#define XA_PTR128       0x18 // 128-Bit Pointers
#define XA_ENDIANMASK   0x20 // Endian Type Mask
#define XA_BIGENDIAN    0x00 // 0 = Motorola (more common)
#define XA_LITTLEENDIAN 0x20 // 1 = Intel (most popular :)
#define XA_NEGATIVEMASK 0x40 // Negative Format Mask
#define XA_TWOSCOMP     0x00 // 0 = 2's compliment (more common)
#define XA_ONESCOMP     0x40 // 1 = 1's compliment (very rare)


////////////////////////////////////////////////////////////////////////////////
//
//  TARGET PLATFORM IMPLEMENTATION
//
//  base.hpp : typedefs, macros and system wrappers
//
////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
//
//  Native classes
//
////////////////////////////////////////////////////////////////////////////////

class SystemLib;  // startup and resource allocation
class Mem;        // memory wrapper
class CPU;        // processor wrapper

#if defined(XP_AMIGAOS3_68K)
  #include "plat/amigaos3_68k/systemlib/base.hpp"
#elif defined(XP_AMIGAOS3_PPC)
  #include "plat/amigaos3_wos/systemlib/base.hpp"
#elif defined(XP_AMIGAOS4)
  #include "plat/amigaos4/systemlib/base.hpp"
#elif defined(XP_AROS_BE)
  #include "plat/aros_be/systemlib/base.hpp"
#elif defined(XP_AROS_LE)
  #include "plat/aros_le/systemlib/base.hpp"
#elif defined(XP_MORPHOS)
  #include "plat/morphos/systemlib/base.hpp"
#elif defined(XP_LINUX_PPC)
  #include "plat/linux_ppc/systemlib/base.hpp"
#elif defined(XP_LINUX_X86)
  #include "plat/linux_i386/systemlib/base.hpp"
#elif defined(XP_WIN9X)
  #include "plat/win9x/systemlib/base.hpp"
#elif defined(XP_WIN2K)
  #include "plat/win2k/systemlib/base.hpp"
#elif defined(XP_MACOSX)
  #include "plat/macosx/systemlib/base.hpp"
#else
  #error "Platform implementation not defined"
#endif

////////////////////////////////////////////////////////////////////////////////
//
//  X_HARDWARE [BYTE]:
//
//  3bit [0-2]  Alignment (Fastest alignment of structures)
//  2bit [3,4]  Pointer Size
//  1bit [5]    Endian Type
//  1bit [6]    Negative Number format
//  1bit [7]    Reserved (0)
//
////////////////////////////////////////////////////////////////////////////////

#define X_HARDWARE (X_ALIGNMENT|X_PTRSIZE|X_ENDIAN|X_NEGATIVE)


////////////////////////////////////////////////////////////////////////////////
//
//  Elemental type enumeration
//
////////////////////////////////////////////////////////////////////////////////

typedef enum {
  T_VOID          = 0,
  T_CHAR,
  T_CHARARRAY,
  T_UINT8,
  T_UINT8ARRAY,
  T_SINT8,
  T_SINT8ARRAY,
  T_UINT16,
  T_UINT16ARRAY,
  T_SINT16,
  T_SINT16ARRAY,
  T_UINT32,
  T_UINT32ARRAY,
  T_SINT32,
  T_SINT32ARRAY,
  T_UINT64,
  T_UINT64ARRAY,
  T_SINT64,
  T_SINT64ARRAY,
  T_FLOAT32,
  T_FLOAT32ARRAY,
  T_FLOAT64,
  T_FLOAT64ARRAY,
  T_PTR
} ElemType;


////////////////////////////////////////////////////////////////////////////////
//
//  ERROR RETURNS
//
////////////////////////////////////////////////////////////////////////////////

typedef enum {
  SUCCESS      = 0,
  INFO         = 1,
  WARNING      = 2,
  ERROR        = 3,
  FATAL        = 4,
  CATACLYSMIC  = 15,
  RSBITS       = 24,
  RSMASK       = 0x0F000000
} ERRSEVERITY;

typedef enum {
  RESULT    = 0,
  VALUE     = 1,
  POINTER   = 2,
  MEMORY    = 3,
  IO        = 4,
  RESOURCE  = 5,
  USER      = 128, // if this bit is set, is a user error type
  RCBITS    = 16,
  RCMASK    = 0x00FF0000
} ERRCLASS;

#define GPRPT(s,c,v)  (-( ((s)<<RSBITS)      | ((c)<<RCBITS) | (v)) )
#define RPERR(c,v)    (-( (ERROR<<RSBITS)    | ((c)<<RCBITS) | (v)) )
#define RPWRN(c,v)    (-( (WARNING<<RSBITS)  | ((c)<<RCBITS) | (v)) )
#define RPINF(c,v)    (-( (INFO<<RSBITS)     | ((c)<<RCBITS) | (v)) )

enum {
  // value errors  - general purpose for 'value out of range' type
  ERR_VALUE_CHANGED    = RPERR(VALUE,7),
  ERR_VALUE_SIGN       = RPERR(VALUE,6),
  ERR_VALUE_RANGE      = RPERR(VALUE,5),
  ERR_VALUE_MIN        = RPERR(VALUE,4),
  ERR_VALUE_ZERO       = RPERR(VALUE,3),
  ERR_VALUE_MAX        = RPERR(VALUE,2),
  ERR_VALUE_ILLEGAL    = RPERR(VALUE,1),
  ERR_VALUE            = RPERR(VALUE,0),

  // resource errors - note that a resource can be anything
  ERR_RSC_LOST         = RPERR(RESOURCE,9),
  ERR_RSC_INVALID      = RPERR(RESOURCE,8),
  ERR_RSC_NOACCESS     = RPERR(RESOURCE,7),
  ERR_RSC_EXHAUSTED    = RPERR(RESOURCE,6),
  ERR_RSC_UNAVAILABLE  = RPERR(RESOURCE,5),
  ERR_RSC_LOCKED       = RPERR(RESOURCE,4),
  ERR_RSC_TYPE         = RPERR(RESOURCE,3),
  ERR_RSC_VERSION      = RPERR(RESOURCE,2),
  ERR_RSC_NOT_FOUND    = RPERR(RESOURCE,1),
  ERR_RSC              = RPERR(RESOURCE,0),
  // pointer errors
  ERR_PTR_INCONSISTENT = RPERR(POINTER,5), // anything using bidirectional pointers may return this
  ERR_PTR_RANGE        = RPERR(POINTER,4),  // anything expecting a pointer to be in a range can return this
  ERR_PTR_USED         = RPERR(POINTER,3),  // anything that requires a zero pointer to initialize can return this
  ERR_PTR_ZERO         = RPERR(POINTER,2),  // anything that requires a vailid pointer to something can return this
  ERR_PTR_NOT_UNIQUE   = RPERR(POINTER,1), // anything requiring a unique pointer can return this
  ERR_PTR              = RPERR(POINTER,0),
  // memory
  ERR_MULTIPLE_FREE    = RPERR(MEMORY,2),
  ERR_NO_FREE_STORE    = RPERR(MEMORY,1),  // anything allocating free space can return this
  // user
  ERR_USER             = RPERR(USER,0),
  // value errors  - general purpose for 'value out of range' type
  WRN_VALUE_CHANGED    = RPWRN(VALUE,7),
  WRN_VALUE_SIGN       = RPWRN(VALUE,6),
  WRN_VALUE_RANGE      = RPWRN(VALUE,5),
  WRN_VALUE_MIN        = RPWRN(VALUE,4),
  WRN_VALUE_ZERO       = RPWRN(VALUE,3),
  WRN_VALUE_MAX        = RPWRN(VALUE,2),
  WRN_VALUE_ILLEGAL    = RPWRN(VALUE,1),
  WRN_VALUE            = RPWRN(VALUE,0),

  // resorce warnings
  WRN_RSC_INVALID      = RPWRN(RESOURCE,8),
  WRN_RSC_NOACCESS     = RPWRN(RESOURCE,7),
  WRN_RSC_EXHAUSTED    = RPWRN(RESOURCE,6),
  WRN_RSC_UNAVAILABLE  = RPWRN(RESOURCE,5),
  WRN_RSC_LOCKED       = RPWRN(RESOURCE,4),
  WRN_RSC_TYPE         = RPWRN(RESOURCE,3),
  WRN_RSC_VERSION      = RPWRN(RESOURCE,2),
  WRN_RSC_NOT_FOUND    = RPWRN(RESOURCE,1),
  WRN_RSC              = RPWRN(RESOURCE,0),
  // pointer warnings
  WRN_PTR_INCONSISTENT = RPWRN(POINTER,5),
  WRN_PTR_RANGE        = RPWRN(POINTER,4),
  WRN_PTR_USED         = RPWRN(POINTER,3),
  WRN_PTR_ZERO         = RPWRN(POINTER,2),
  WRN_PTR_NOT_UNIQUE   = RPWRN(POINTER,1),
  WRN_PTR              = RPWRN(POINTER,0),
  // memory
  WRN_MULTIPLE_FREE    = RPWRN(MEMORY,2),
  WRN_NO_FREE_STORE    = RPWRN(MEMORY,1),
  // user
  WRN_USER             = RPWRN(USER,0),
  // info
  INFO_USER            = RPINF(USER,0),
  OK                   = 0        // hooray - sucess !
};

////////////////////////////////////////////////////////////////////////////////
//
//  Clamp : Simple methods for returning a range clamped value, used by many
//          library components
//
////////////////////////////////////////////////////////////////////////////////

class Clamp {
  public:
    static sint32 integer(sint32 v, sint32 min, sint32 max) {
      return (v < min) ? min : (v > max) ? max : v;
    }

    static float64 real(float64 v, float64 min, float64 max) {
      return (v < min) ? min : (v > max) ? max : v;
    }
};

////////////////////////////////////////////////////////////////////////////////
//
//  APPLICATION INTERFACE
//
//  const char* getString(const char* paramName, bool matchCase)
//    Returns a pointer to string of characters on the command line immediately
//    following paramName, or zero if no match for paramName was found.
//    Case sensitivity may be specified, default is to ignore case.
//
//  sint32 getInteger(const char* paramName, bool matchCase)
//    Returns the integer parsed string of characters on the command line
//    immediately following paramName. Returns zero no match for paramName was
//    found.
//    Case sensitivity may be specified, default is to ignore case.
//
//  float64 getFloat(const char* paramName, bool matchCase)
//    Returns floating point parsed string of characters on the command line
//    immediately following paramName. Returns zero if no match for paramName
//    was found.
//    Case sensitivity may be specified, default is to ignore case.
//
//  bool getSwitch(const char* paramName, bool matchCase)
//    Returns true if paramName was passed on the command line, false if no
//    match for paramName was found.
//    Case sensitivity may be specified, default is to ignore case.
//
//  sint32 init()
//    This method is called prior to application insansiation. It's job is
//    to ensure that any other libraries used that require an init() call before
//    use are correctly set up. The implementation of this method must be
//    defined by the application designer. The expected behaviour is to return
//    OK if all additional used libraries were sucessfully initialised, or an
//    appropriate error condition otherwise. If no additional libraries are
//    used, the function should simply return OK.
//
//  void done()
//    This method is called prior to exit (after application destruction). It's
//    job is to ensure that any other libraries used that require a done() call
//    are correctly finalised. The implementation of this method application
//    must be defined by the application designer. If no additional libraries
//    were used, a null function will suffice.
//
//  Example
//
//    1) No additional libraries used
//
//    sint32 AppBase::init() { return OK; }
//    void   AppBase::done() { }
//
//    2) GfxLib used
//
//    sint32 AppBase::init() { return GfxLib::init(); }
//    void   AppBase::done() { GfxLib::done(); }
//
//
//  AppBase* createApplicationInstance()
//    Factory used to create the AppBase derived application instance.
//    The implementation of this function must be provided by the library user.
//
//  void destroyApplicationInstance(AppBase*)
//    Removes the AppBase derived application instance. The implementation of
//    this function must be provided by the library user.
//
//  Example
//
//    class MyApplication : public AppBase {
//     ...
//      public:
//        sint32 initApplication();
//        void   doneApplication();
//        sint32 runApplication();
//
//        MyApplication();
//        ~MyApplication();
//    };
//
//    // Simple new/delete implementation. Other strategies are possible also.
//
//    AppBase* AppBase::createApplicationInstance()
//    {
//      return new MyApplication();
//    }
//
//    void AppBase::destroyApplicationInstance(AppBase* app)
//    {
//      delete app;
//    }
//
//  sint32 initApplication()
//    This method performs any initialization not performed by the applications'
//    constructor method. Should return OK on successful initialisation. At the
//    very least, the method should be used to verify that the application is in
//    a suitable state to launch(). Called from main().
//
//  void   doneApplication()
//    This method performs any cleanup that should be performed prior to the
//    applications' destructor.
//
//  sint32 runApplication()
//    This method runs the application. Value returned is used as the return
//    value for main() on completion. Must be overriden by the application.
//
////////////////////////////////////////////////////////////////////////////////


class AppBase {
  public:
    static sint32       numArgs();
    static const char*  getArg(sint32 n);
    static const char*  getString(const char* paramName, bool matchCase);
    static sint32       getInteger(const char* paramName, bool matchCase);
    static float64      getFloat(const char* paramName, bool matchCase);
    static bool         getSwitch(const char* paramName, bool matchCase);
 
  public:
    virtual ~AppBase() {}

  protected:
    static  sint32    init();
    static  void      done();
    static  AppBase*  createApplicationInstance();
    static  void      destroyApplicationInstance(AppBase* app);
    virtual sint32    initApplication()  { return OK; }
    virtual void      doneApplication()  { return; }
    virtual sint32    runApplication() = 0;

  friend class StartupLib;
};

#endif

