//****************************************************************************//
//**                                                                        **//
//** File:         include/iolib/fileio.hpp                                 **//
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

#ifndef _EXTROPIA_IOLIB_FILEIO_HPP
#define _EXTROPIA_IOLIB_FILEIO_HPP


#include <xbase.hpp>

////////////////////////////////////////////////////////////////////////////////
//
//  class IOS
//
////////////////////////////////////////////////////////////////////////////////

class IOS {
  public:
    enum {
      ERR_FILE_MODE        = RPERR(IO,13),
      ERR_FILE_CLOSE      = RPERR(IO,12),
      ERR_FILE_OPEN        = RPERR(IO,11),
      ERR_FILE_SEEK_END    = RPERR(IO,10),
      ERR_FILE_SEEK_BEG    = RPERR(IO,9),
      ERR_FILE_SEEK        = RPERR(IO,8),
      ERR_FILE_EXISTS      = RPERR(IO,7),
      ERR_FILE_CREATE      = RPERR(IO,6),
      ERR_FILE_WRITE      = RPERR(IO,5),
      ERR_FILE_READ        = RPERR(IO,4),
      ERR_FILE_CORRUPT    = RPERR(IO,3),
      ERR_FILE_EMPTY      = RPERR(IO,2),
      ERR_FILE_NOT_FOUND  = RPERR(IO,1),
      ERR_FILE            = RPERR(IO,0),
      WRN_FILE_MODE        = RPWRN(IO,13),
      WRN_FILE_CLOSE      = RPWRN(IO,12),
      WRN_FILE_OPEN        = RPWRN(IO,11),
      WRN_FILE_SEEK_END    = RPWRN(IO,10),
      WRN_FILE_SEEK_BEG    = RPWRN(IO,9),
      WRN_FILE_SEEK        = RPWRN(IO,8),
      WRN_FILE_EXISTS      = RPWRN(IO,7),
      WRN_FILE_CREATE      = RPWRN(IO,6),
      WRN_FILE_WRITE      = RPWRN(IO,5),
      WRN_FILE_READ        = RPWRN(IO,4),
      WRN_FILE_CORRUPT    = RPWRN(IO,3),
      WRN_FILE_EMPTY      = RPWRN(IO,2),
      WRN_FILE_NOT_FOUND  = RPWRN(IO,1),
      WRN_FILE            = RPWRN(IO,0)
    };

    typedef enum {
      READ,
      WRITE,
      APPEND,
      READTEXT,
      WRITETEXT,
      APPENDTEXT,
    } OpenMode;

    typedef enum {
      SEEKSTART    = -1,
      SEEKCURR,
      SEEKEND
    } SeekMode;

    // permissions
    enum {
      READABLE    = 0x00000001,
      WRITEABLE    = 0x00000002,
      DELETEABLE  = 0x00000003
    };

    //
    typedef enum {
      FILE,
      FOLDER,
      VOLUME,
      DEVICE
    } ItemType;
};

class FileSystemItem : public IOS {
  public:
    virtual const char*    getName()          = 0;
    virtual size_t        getSize()          = 0;
    virtual uint32        getPermissions()  = 0;
};

////////////////////////////////////////////////////////////////////////////////
//
//  Native classes
//
//  StreamOut : Asynchronous file output
//  StreamIn  : Asynchronous file input
//
////////////////////////////////////////////////////////////////////////////////

class Folder;

class StreamOut;
class StreamIn;


#if defined(XP_AMIGAOS3_68K)
  #include "plat/amigaos3_68k/iolib/fileio.hpp"
#elif defined(XP_AMIGAOS3_PPC)
  #include "plat/amigaos3_wos/iolib/fileio.hpp"
#elif defined(XP_AMIGAOS4)
  #include "plat/amigaos4/iolib/fileio.hpp"
#elif defined(XP_AROS_BE)
  #include "plat/aros_be/iolib/fileio.hpp"
#elif defined(XP_AROS_LE)
  #include "plat/aros_le/iolib/fileio.hpp"
#elif defined(XP_MORPHOS)
  #include "plat/morphos/iolib/fileio.hpp"
#elif defined(XP_LINUX_PPC)
  #include "plat/linux_ppc/iolib/fileio.hpp"
#elif defined(XP_LINUX_X86)
  #include "plat/linux_i386/iolib/fileio.hpp"
#elif defined(XP_WIN9X)
  #include "plat/win9x/iolib/fileio.hpp"
#elif defined(XP_WIN2K)
  #include "plat/win2k/iolib/fileio.hpp"
#elif defined(XP_MACOSX)
  #include "plat/macosx/iolib/fileio.hpp"
#else
  #error "Platform implementation not defined"
#endif

#endif