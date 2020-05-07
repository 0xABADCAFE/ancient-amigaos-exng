//****************************************************************************//
//**                                                                        **//
//** File:         include/iolib/console.hpp                                **//
//** Description:  Buffered file IO classes                                 **//
//** Comment(s):   Stub header                                              **//
//** Library:      iolib                                                    **//
//** Created:      2003-02-10                                               **//
//** Updated:      2003-02-10                                               **//
//** Author(s):    Karl Churchill                                           **//
//** Note(s):                                                               **//
//** Copyright:    (C)1996-2003, eXtropia Studios                           **//
//**               Serkan YAZICI, Karl Churchill                            **//
//**               All Rights Reserved.                                     **//
//**                                                                        **//
//****************************************************************************//

#ifndef _EXTROPIA_IOLIB_CONSOLE_HPP
#define _EXTROPIA_IOLIB_CONSOLE_HPP

#include <iolib/fileio.hpp>

////////////////////////////////////////////////////////////////////////////////
//
//  class Console
//
//  Simple interface for console IO
//
////////////////////////////////////////////////////////////////////////////////

class Console {

  public:
    virtual sint32  open(const char* title)        = 0;
    virtual sint32  close()                        = 0;
    virtual sint32  writeText(const char* s,...)  = 0;
    virtual sint32  readText(char* s, size_t max)  = 0;
    virtual void    flush()                        = 0;
    virtual void    clear()                        = 0;

  public:
    virtual ~Console() {}
};


////////////////////////////////////////////////////////////////////////////////
//
//  Native classes
//
////////////////////////////////////////////////////////////////////////////////

class SystemConsole;

#if defined(XP_AMIGAOS3_68K)
  #include "plat/amigaos3_68k/iolib/console.hpp"
#elif defined(XP_AMIGAOS3_PPC)
  #include "plat/amigaos3_wos/iolib/console.hpp"
#elif defined(XP_AMIGAOS4)
  #include "plat/amigaos4/iolib/console.hpp"
#elif defined(XP_AROS_BE)
  #include "plat/aros_be/iolib/console.hpp"
#elif defined(XP_AROS_LE)
  #include "plat/aros_le/iolib/console.hpp"
#elif defined(XP_MORPHOS)
  #include "plat/morphos/iolib/console.hpp"
#elif defined(XP_LINUX_PPC)
  #include "plat/linux_ppc/iolib/console.hpp"
#elif defined(XP_LINUX_X86)
  #include "plat/linux_i386/iolib/console.hpp"
#elif defined(XP_WIN9X)
  #include "plat/win9x/iolib/console.hpp"
#elif defined(XP_WIN2K)
  #include "plat/win2k/iolib/console.hpp"
#elif defined(XP_MACOSX)
  #include "plat/macosx/iolib/console.hpp"
#else
  #error "Platform implementation not defined"
#endif

#endif