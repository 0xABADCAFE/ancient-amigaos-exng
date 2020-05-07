//****************************************************************************//
//**                                                                        **//
//** File:         include/plats/amigaos3_68k/systemlib/base.hpp            **//
//** Description:  Type definitions, SystemLib and Mem classes              **//
//** Comment(s):                                                            **//
//** Library:      systemlib                                                **//
//** Created:      2003-02-08                                               **//
//** Updated:      2003-02-09                                               **//
//** Author(s):    Karl Churchill, Serkan YAZICI                            **//
//** Note(s):                                                               **//
//** Copyright:    (C)1996-2003, eXtropia Studios                           **//
//**               Serkan YAZICI, Karl Churchill                            **//
//**               All Rights Reserved.                                     **//
//**                                                                        **//
//****************************************************************************//

#ifndef _EXTROPIA_SYSTEMLIB_BASE_NATIVE_HPP
#define _EXTROPIA_SYSTEMLIB_BASE_NATIVE_HPP

////////////////////////////////////////////////////////////////////////////////
//
//  ARCHITECTURE DEFINITION
//
////////////////////////////////////////////////////////////////////////////////

#define X_ARCHITECTURE      "Motorola 680x0"
#define X_PLATFORM          "AmigaOS 3.x"
#define X_ALIGNMENT          XA_ALIGN32
#define X_PTRSIZE            XA_PTR32
#define X_ENDIAN            XA_BIGENDIAN
#define X_NEGATIVE          XA_TWOSCOMP
#define X_FPU_IEEE754

#define X_SYSNAME            AmigaOS3_68K

#ifndef _LC_TRASH
#define _LC_TRASH "d0", "d1", "a0", "a1", "a6", "cc"
#endif

namespace X_SYSNAME {
  extern "C" {
    #include <proto/exec.h>            // OS realtime kernel
    #include <proto/intuition.h>      // OS windowing environment
  }
};

////////////////////////////////////////////////////////////////////////////////
//
//  TYPES
//
////////////////////////////////////////////////////////////////////////////////

typedef unsigned char        uint8;
typedef unsigned short      uint16;
typedef unsigned long        uint32;
typedef unsigned long long  uint64;
typedef signed char          sint8;
typedef signed short        sint16;
typedef signed long          sint32;
typedef signed long long    sint64;
typedef float                float32;
typedef double              float64;
typedef float                floatF;

#define ruint8      register uint8
#define ruint16      register uint16
#define ruint32      register uint32
#define ruint64      register uint64
#define rsint8      register sint8
#define rsint16      register sint16
#define rsint32      register sint32
#define rsint64      register sint64
#define rbool        register bool
#define rfloat32    register float32
#define rfloat64    register float64
#define rfloatF      register floatF
#define rsize_t      register size_t

typedef uint32      SysSignal;

////////////////////////////////////////////////////////////////////////////////
//
//  REGISTER MACROS
//
//  REGPx Pointer register
//  REGIx Integer register
//  REGFx Floating point register
//
////////////////////////////////////////////////////////////////////////////////

/*
#define REGP0 register __a0
#define REGP1 register __a1
#define REGP2 register __a2
#define REGP3 register __a3
#define REGP4 register __a4
#define REGP5 register __a5
#define REGP6 register __a6
#define REGP7 register __a7

#define REGI0 register __d0
#define REGI1 register __d1
#define REGI2 register __d2
#define REGI3 register __d3
#define REGI4 register __d4
#define REGI5 register __d5
#define REGI6 register __d6
#define REGI7 register __d7

#define REGF0 register __fp0
#define REGF1 register __fp1
#define REGF2 register __fp2
#define REGF3 register __fp3
#define REGF4 register __fp4
#define REGF5 register __fp5
#define REGF6 register __fp6
#define REGF7 register __fp7
*/

#define REGP0
#define REGP1
#define REGP2
#define REGP3
#define REGP4
#define REGP5
#define REGP6
#define REGP7

#define REGI0
#define REGI1
#define REGI2
#define REGI3
#define REGI4
#define REGI5
#define REGI6
#define REGI7

#define REGF0
#define REGF1
#define REGF2
#define REGF3
#define REGF4
#define REGF5
#define REGF6
#define REGF7

////////////////////////////////////////////////////////////////////////////////
//
//  OTHER MACROS
//
////////////////////////////////////////////////////////////////////////////////

#define ALIGNSTACKOBJ32(T, name) uint8 __a32##name[sizeof(T)+3];  \
        T &name = *( (T*)((uint32)(__a32##name+3)&~3) );

#define ALIGNSTACKOBJ64(T, name) uint8 __a64##name[sizeof(T)+7];  \
        T &name = *( (T*)((uint32)(__a32##name+7)&~7) );

#define ALIGNSTACKBLOCK32(T,name,num) uint8 __ba32##name[3+((num)*sizeof(T))]; \
        T *name = (T*)((uint32)(__ba32##name+3) & ~3);

#define ALIGNSTACKBLOCK64(T,name,num) uint8 __ba64##name[7+((num)*sizeof(T))]; \
        T *name = (T*)((uint32)(__ba64##name+7) & ~7);

#define FILE_VIEWER_APP "Multiview"

////////////////////////////////////////////////////////////////////////////////
//
//  SYSTEM INLINES
//
////////////////////////////////////////////////////////////////////////////////



////////////////////////////////////////////////////////////////////////////////
//
//  GLOBALS
//
////////////////////////////////////////////////////////////////////////////////

#define EXNG_NUM_LINK_LIBS 8 // the maximum number of known exng libraries

// TO DO - build auto initialisation registry for exng linked libraries
// The following class will handle the registration of the library's init() and
// done() pair. This needs a priority to work correctly since there is no
// guarentee of order of initialisation of globals across translation units.

/*
typedef sint32 (*InitFn)();
typedef void (*DoneFn)();

class EXNGLinkedLib {
  friend class StartupLib;
  private:
    static InitFn        init[EXNG_NUM_LINK_LIBS];
    static DoneFn        done[EXNG_NUM_LINK_LIBS];
    static const char*  name[EXNG_NUM_LINK_LIBS];
    static sint32 num;
  protected:
    static  sint32 addResource(InitFn, DoneFn, const char*);
  public:
    static void dump();
};
*/
////////////////////////////////////////////////////////////////////////////////
//
//  class SystemLib [interface]
//
////////////////////////////////////////////////////////////////////////////////

class SystemLib /*: public EXNGLinkedLib*/ {
  public:
    static void      printDebug(const char* text, int level);
    static void      openExternalProgram(const char* name)  { system(name); }
    static void      openDebugFile(const char *name);
    static sint32    dialogueBox(const char* title, const char* opts, \
                                const char* body,...);

  protected:
    void add();

  private:
    static bool      debug;
    static sint32    init(); // called from StartupLib
    static void      done(); // called from StartupLib

    // Constructor for auto EXNGLinkedLib registry, should call addResource()
    //SystemLib();

  friend class StartupLib;
};

////////////////////////////////////////////////////////////////////////////////
//
//  class Mem [interface]
//
////////////////////////////////////////////////////////////////////////////////


class Mem {
  public:
    typedef enum {
      ALIGN_DEFAULT  = 0,
      ALIGN_16      = 2,
      ALIGN_32      = 4,
      ALIGN_64      = 8,
      ALIGN_CACHE    = 16
    } AlignType;

    static void*  alloc(size_t size, bool zero=false, AlignType align=ALIGN_DEFAULT);
    static void    free(void* p);
    static void    copy(void* dst, const void* src, size_t len);
    static void    swap16(void* dst, const void* src, size_t num);
    static void    swap32(void* dst, const void* src, size_t num);
    static void    swap64(void* dst, const void* src, size_t num);
    static void    zero(void* dst, size_t len);
    static void    set(void* dst, int val, size_t len);
    static void    set16(void* dst, uint16 val, size_t num);
    static void    set32(void* dst, uint32 val, size_t num);
    static void    set64(void* dst, const uint64& val, size_t num);

  private:
    typedef void (*MoveFunc)(void* dst, const void* src, size_t len);
    typedef void (*SetFunc)(void* dst, uint32 val, size_t len);
    typedef void (*Set64Func)(void* dst, const uint64& val, size_t len);

    // We provide versions optimised for 68020/30 and 68040/60
    // Actual routines chosen at runtime pending CPU detection
    static MoveFunc   _copy;
    static MoveFunc   _swap16;
    static MoveFunc   _swap32;
    static MoveFunc   _swap64;
    static SetFunc    _set;
    static SetFunc    _set16;
    static SetFunc    _set32;
    static Set64Func  _set64;
};


#endif

