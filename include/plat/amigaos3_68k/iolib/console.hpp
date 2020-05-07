//****************************************************************************//
//**                                                                        **//
//** File:         include/plat/amigaos3_68k/iolib/console.hpp              **//
//** Description:  Native console classes                                   **//
//** Comment(s):                                                            **//
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

#ifndef _EXTROPIA_IOLIB_CONSOLE_NATIVE_HPP
#define _EXTROPIA_IOLIB_CONSOLE_NATIVE_HPP

class SystemConsole : public Console {
  private:
    char*    nameBuffer;
    FILE*    conHandle;

  public:
    sint32  open(sint16 x, sint16 y, sint16 w, sint16 h, const char* title);
    sint32  open(const char* title) { return open(64, 64, 400, 300, title); }
    sint32  close();
    sint32  writeText(const char* s,...);
    sint32  readText(char* s, size_t max);
    void    flush();
    void    clear();
  public:
    SystemConsole() : nameBuffer(0), conHandle(0) {}
    ~SystemConsole();
};

#endif