//****************************************************************************//
//**                                                                        **//
//** File:         include/plat/amigaos3_68k/iolib/filebrowser.hpp          **//
//** Description:  Buffered file IO classes                                 **//
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

#ifndef _EXTROPIA_IOLIB_FILEBROWSER_NATIVE_HPP
#define _EXTROPIA_IOLIB_FILEBROWSER_NATIVE_HPP

namespace X_SYSNAME {
  extern "C" {
    #include <libraries/asl.h>
    #include <proto/asl.h>
  }
};

class FileBrowser {
  private:
    static sint32 numReq;
    X_SYSNAME::FileRequester* aslReq;

  public:
    FileBrowser();
    ~FileBrowser();
}

#endif