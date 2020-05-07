//****************************************************************************//
//**                                                                        **//
//** File:         include/iolib/filebrowser.hpp                            **//
//** Description:  File browser utility, wraps native browser.              **//
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

#ifndef _EXTROPIA_IOLIB_FILEBROWSER_HPP
#define _EXTROPIA_IOLIB_FILEBROWSER_HPP

#include <xbase.hpp>

#if defined(XP_AMIGAOS3_68K)
  #include "plat/amigaos3_68k/iolib/filebrowser.hpp"
#elif defined(XP_AMIGAOS3_PPC)
  #include "plat/amigaos3_wos/iolib/filebrowser.hpp"
#elif defined(XP_AMIGAOS4)
  #include "plat/amigaos4/iolib/filebrowser.hpp"
#elif defined(XP_AROS_BE)
  #include "plat/aros_be/iolib/filebrowser.hpp"
#elif defined(XP_AROS_LE)
  #include "plat/aros_le/iolib/filebrowser.hpp"
#elif defined(XP_MORPHOS)
  #include "plat/morphos/iolib/filebrowser.hpp"
#elif defined(XP_LINUX_PPC)
  #include "plat/linux_ppc/iolib/filebrowser.hpp"
#elif defined(XP_LINUX_X86)
  #include "plat/linux_x86/iolib/filebrowser.hpp"
#elif defined(XP_WIN9X)
  #include "plat/win9x/iolib/filebrowser.hpp"
#elif defined(XP_WIN2K)
  #include "plat/win2k/iolib/filebrowser.hpp"
#elif defined(XP_MACOSX)
  #include "plat/macosx/iolib/filebrowser.hpp"
#else
  #error "Platform implementation not defined"
#endif

#endif