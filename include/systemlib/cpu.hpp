//****************************************************************************//
//**                                                                        **//
//** File:         include/systemlib/cpu.hpp                                **//
//** Description:  Processor interface                                      **//
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

#ifndef _EXTROPIA_SYSTEMLIB_CPU_HPP
#define _EXTROPIA_SYSTEMLIB_CPU_HPP

#include <xbase.hpp>

////////////////////////////////////////////////////////////////////////////////
//
//  Native classes
//
////////////////////////////////////////////////////////////////////////////////

class CPU;

/*
  Host Processor interface

  Public Constants

    Typedef'd Constants
      FPPrec
        FP_DEFAULT
        FP_HIGH
        FP_LOW

      Privilege
        DEFAULT
        USER
        SUPERVISOR

  Public Methods

    static const char* getCPU()
      Returns the name of the processor detected in the system.

      Return value                Signifies

      const char*                 Name of the processor.

    static const char* getFPU()
      Returns the name of the floating point processor detected in the system.

      Return value                Signifies

      const char*                 Name of the floating point processor.

    static void flushDataCache(void* adr, uint32 length)
      Flushes the processor data cache.

      Parameter                   Signifies

      void*  adr                  The start address of the area to expunge.
      uint32 length               The length of the range to flush. Defaults
                                  to 0xFFFFFFFF.

    static void flushInstCache(void* adr, uint32 length)
      Flushes the processor instruction cache.

      Parameter                   Signifies

      void*  adr                  The start address of the area to expunge.
      uint32 length               The length of the range to flush. Defaults
                                  to 0xFFFFFFFF.

    static void flushAllCaches(void* adr, uint32 length)
      Flushes the processor caches.

      Parameter                   Signifies

      void*  adr                  The start address of the area to expunge.
      uint32 length               The length of the range to flush. Defaults
                                  to 0xFFFFFFFF.

    static void setPrecision(FPPrec prec)
      Sets the operational precision of the floating point unit. Some systems may
      have higher performance for high or low precision.

      Parameter                   Signifies

      CPU::FPPrec prec            The precision level to use.

    static FPPrec getPrecision()
      Returns the current operational precision level of the floating point unit.

      Return value                Signifies

      CPU::FPPrec                 The current operational precision level.

    static void synchronise()
      Performs processor synchronisation and other operations such as ensuring
      correct order of memory writes. Usually this is performed by issuing a no-op
      command to the processor.

*/

#if defined(XP_AMIGAOS3_68K)
  #include "plat/amigaos3_68k/systemlib/cpu.hpp"
#elif defined(XP_AMIGAOS3_PPC)
  #include "plat/amigaos3_wos/systemlib/cpu.hpp"
#elif defined(XP_AMIGAOS4)
  #include "plat/amigaos4/systemlib/cpu.hpp"
#elif defined(XP_AROS_BE)
  #include "plat/aros_be/systemlib/cpu.hpp"
#elif defined(XP_AROS_LE)
  #include "plat/aros_le/systemlib/cpu.hpp"
#elif defined(XP_MORPHOS)
  #include "plat/morphos/systemlib/cpu.hpp"
#elif defined(XP_LINUX_PPC)
  #include "plat/linux_ppc/systemlib/cpu.hpp"
#elif defined(XP_LINUX_X86)
  #include "plat/linux_i386/systemlib/cpu.hpp"
#elif defined(XP_WIN9X)
  #include "plat/win9x/systemlib/cpu.hpp"
#elif defined(XP_WIN2K)
  #include "plat/win2k/systemlib/cpu.hpp"
#elif defined(XP_MACOSX)
  #include "plat/macosx/systemlib/cpu.hpp"
#else
  #error "Platform implementation not defined"
#endif

#endif