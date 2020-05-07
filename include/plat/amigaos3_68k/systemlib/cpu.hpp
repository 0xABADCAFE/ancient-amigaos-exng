//****************************************************************************//
//**                                                                        **//
//** File:         include/plats/amigaos3_68k/systemlib/cpu.hpp             **//
//** Description:  System CPU interface                                     **//
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

#ifndef _EXTROPIA_SYSTEMLIB_CPU_NATIVE_HPP
#define _EXTROPIA_SYSTEBLIB_CPU_NATIVE_HPP

////////////////////////////////////////////////////////////////////////////////
//
//  class CPU [interface]
//
////////////////////////////////////////////////////////////////////////////////

class CPU {
  public:
    typedef enum {
      FP_DEFAULT,
      FP_HIGH,
      FP_LOW
    } FPPrec;

    typedef enum {
      DEFAULT,
      USER,
      SUPERVISOR,
    } Privilege;

  public:
    static const char*  getCPU() { return cpuNames[cpuType()]; }
    static const char*  getFPU() { return fpuNames[fpuType()]; }
    static void          flushDataCache(void* adr, uint32 l=0xFFFFFFFF);
    static void         flushInstCache(void* adr, uint32 l=0xFFFFFFFF);
    static void         flushAllCaches(void* adr, uint32 l=0xFFFFFFFF);
    static void         setPrecision(FPPrec p);
    static FPPrec        getPrecision() { return fpuPrecision; }
    static void          synchronise() { asm("\n\tnop\n"); }

  protected:
    // processor definitions are not public to discourage casual use
    enum {
      MC680x0      = 0,
      MC68020      = 1,
      MC68030      = 2,
      MC68040      = 3,
      MC68060      = 4
    };
    enum {
      MC6888x      = 0,
      MC68881      = 1,
      MC68882      = 2,
      MC68040FP    = 3,
      MC68040FPEM  = 4,
      MC68060FP    = 5,
      MC68060FPEM  = 6,
      SOFTFP      = 7
    };
    static sint32  cpuType();
    static sint32  fpuType();

  private:
    static FPPrec  fpuPrecision;
    static char*  cpuNames[];
    static char*  fpuNames[];

};

#endif
