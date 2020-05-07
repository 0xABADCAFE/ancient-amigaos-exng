//****************************************************************************//
//**                                                                        **//
//** File:         libsrc/plat/amigaos3_68k/systemlib/cpu.cpp               **//
//** Description:  eXtropia Library Base API                                **//
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

#include <systemlib/cpu.hpp>

namespace X_SYSNAME {
  extern "C" {
    #include <exec/execbase.h>
  }
};

using namespace X_SYSNAME;

CPU::FPPrec CPU::fpuPrecision = CPU::FP_DEFAULT;

char* CPU::cpuNames[] = {
  "MC680x0",
  "MC68020",
  "MC68030",
  "MC68040",
  "MC68060",
  "ColdFire v4",  // cold fusion accelerator, if it ever gets released!
  "ColdFire v5"
};

char* CPU::fpuNames[] = {
  "MC6888x",
  "MC68881",
  "MC68882",
  "MC68040",
  "MC68040+68882emu",
  "MC68060",
  "MC68060+68882emu"
  "Software"
};

// why arent these in my ndk 44.1 release execbase.h?

#ifndef AFB_68060
#define AFB_68060 7
#endif

#ifndef AFF_68060
#define AFF_68060 (1<<AFB_68060)
#endif

sint32 CPU::cpuType()
{
/*
  if (!SysBase) {
    // prpft, likely LOL!
    return MC680x0;
  }
*/
  static sint32 cpu = -1;
  if (cpu<0) {
    // fixme : add 68060 detection
    uint16 info = SysBase->AttnFlags;
    // is this correct ?
    if (info & AFF_68060) {
      cpu = MC68060;
    }
    else if (info & AFF_68040) {
      cpu = MC68040;
    }
    else if (info & AFF_68030) {
      cpu = MC68030;
    }
    else if (info & AFF_68020) {
      cpu = MC68020;
    }
    else {
      cpu = MC680x0;
    }
  }
  return cpu;
}

sint32 CPU::fpuType()
{
/*
  if (!SysBase) {
    return MC6888x;
  }
*/
  static sint32 fpu = -1;
  if (fpu<0) {
    uint16 info = SysBase->AttnFlags;
    // is this correct ?
    if (info & AFF_68060) {
      if (info & AFF_FPU40) {
        if (info & (AFF_68882|AFF_68881)) {
          fpu = MC68060FPEM;
        }
        else {
          fpu = MC68060FP;
        }
      }

    }
    else if (info & AFF_FPU40) {
      if (info & (AFF_68882|AFF_68881)) {
        fpu = MC68040FPEM;
      }
      else {
        fpu = MC68040FP;
      }
    }
    else if (info & AFF_68882) {
      fpu = MC68882;
    }
    else if (info & AFF_68881) {
      fpu = MC68881;
    }
    else {
      fpu = SOFTFP;
    }
  }
  return fpu;
}

void CPU::flushDataCache(void* adr, uint32 l)
{
  CacheClearE(adr, l, CACRF_ClearD);
}

void CPU::flushInstCache(void* adr, uint32 l)
{
  CacheClearE(adr, l, CACRF_ClearI);
}

void CPU::flushAllCaches(void* adr, uint32 l)
{
  CacheClearE(adr, l, CACRF_ClearD|CACRF_ClearI);
}

void CPU::setPrecision(CPU::FPPrec p)
{
  // define in asm for CPUs that may support this feature
}

/*
void CPU::synchronise()
{
  // define in asm
  // nop
  // rts
}
*/