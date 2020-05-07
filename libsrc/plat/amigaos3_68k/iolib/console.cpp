//****************************************************************************//
//**                                                                        **//
//** File:         libsrc/plat/amigaos3_68k/iolib/console.cpp               **//
//** Description:  Console classes                                          **//
//** Comment(s):                                                            **//
//** Library:      iolib                                                    **//
//** Created:      2003-02-18                                               **//
//** Updated:      2003-02-20                                               **//
//** Author(s):    Karl Churchill                                           **//
//** Note(s):                                                               **//
//** Copyright:    (C)1996-2003, eXtropia Studios                           **//
//**               Serkan YAZICI, Karl Churchill                            **//
//**               All Rights Reserved.                                     **//
//**                                                                        **//
//****************************************************************************//

#include <iolib/console.hpp>

SystemConsole::~SystemConsole()
{
  close();
  if (nameBuffer)
    Mem::free(nameBuffer);
}

////////////////////////////////////////////////////////////////////////////////

sint32 SystemConsole::open(sint16 x, sint16 y, sint16 w, sint16 h, const char* title)
{
  if (conHandle)
    return IOS::ERR_FILE_EXISTS;

  if ((!nameBuffer) && (!(nameBuffer = (char*)Mem::alloc(512))))
    return IOS::ERR_FILE_OPEN;

  sprintf(nameBuffer, "CON:%hi/%hi/%hi/%hi/%s/CLOSE", x, y, w, h,
          (title!=0 ? title : "Unnamed"));

  conHandle = fopen(nameBuffer, "w+");
  if (!conHandle)
    return IOS::ERR_FILE_OPEN;
  return OK;
}

////////////////////////////////////////////////////////////////////////////////

sint32 SystemConsole::close()
{
  if (conHandle) {
    fflush(conHandle);
    fclose(conHandle);
    conHandle = 0;
    return OK;
  }
  return IOS::ERR_FILE_CLOSE;
}

////////////////////////////////////////////////////////////////////////////////

sint32 SystemConsole::writeText(const char* s,...)
{
  if (!conHandle)
    return IOS::ERR_FILE_WRITE;
  va_list argList;
  va_start(argList, s);
  va_end(argList);
  return vfprintf(conHandle, s, argList);
}

////////////////////////////////////////////////////////////////////////////////

sint32 SystemConsole::readText(char* s, size_t max)
{
  if (!conHandle)
    return IOS::ERR_FILE_READ;
  fgets(s, max, conHandle);
  return OK;
}

////////////////////////////////////////////////////////////////////////////////

void SystemConsole::flush()
{
  if (conHandle)
    fflush(conHandle);
}

////////////////////////////////////////////////////////////////////////////////

void SystemConsole::clear()
{

}

////////////////////////////////////////////////////////////////////////////////
