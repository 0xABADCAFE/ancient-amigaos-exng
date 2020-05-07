//****************************************************************************//
//**                                                                        **//
//** File:         libsrc/plat/linux_i386/iolib/stream.cpp                  **//
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

#include <iolib/fileio.hpp>

using namespace X_SYSNAME;

////////////////////////////////////////////////////////////////////////////////
//
//  StreamIn
//
////////////////////////////////////////////////////////////////////////////////

StreamIn::StreamIn() : file(0), swapBuffer(0)
{
  swapBuffer = Mem::alloc(_SWAPBUFFSIZE, false, Mem::ALIGN_CACHE);
}

////////////////////////////////////////////////////////////////////////////////

StreamIn::StreamIn(const char* f, bool textMode, size_t s) : file(0), swapBuffer(0)
{
  if (swapBuffer = Mem::alloc(_SWAPBUFFSIZE, false, Mem::ALIGN_CACHE))
    open(f, textMode, s);
}

////////////////////////////////////////////////////////////////////////////////

StreamIn::~StreamIn()
{
  close();
  if (swapBuffer)
    Mem::free(swapBuffer);
}

////////////////////////////////////////////////////////////////////////////////

sint32 StreamIn::open(const char* fileName, bool textMode, size_t reqSize)
{
  if (!swapBuffer)
    return ERR_NO_FREE_STORE;
  if (!fileName)
    return ERR_PTR_ZERO;
  if (file)
    return ERR_FILE_OPEN;
  if (textMode)
    file = fopen(fileName, "r");
  else
    file = fopen(fileName, "rb");
  if (!file)
    return ERR_FILE_OPEN;
  return OK;
}

////////////////////////////////////////////////////////////////////////////////

sint32 StreamIn::seek(sint32 position, IOS::SeekMode mode)
{
  if (!file)
    return ERR_FILE_SEEK;
  switch(mode) {
    case SEEKSTART:
      fseek(file, position, SEEK_SET);
      break;
    case SEEKCURR:
      fseek(file, position, SEEK_CUR);
      break;
    case SEEKEND:
      fseek(file, position, SEEK_END);
  }
  sint32 res = ftell(file);
  if (res>=0)
    return res;
  return ERR_FILE_SEEK;
}

////////////////////////////////////////////////////////////////////////////////

sint32 StreamIn::size()
{
  if (file) {
    int pos = ftell(file)
    fseek(file, 0, SEEK_END);
    int len = ftell(file);
    fseek(file, pos, SEEK_SET);
    return len;
  }
  return ERR_FILE_SEEK;
}

////////////////////////////////////////////////////////////////////////////////

sint32 StreamIn::read16Swap(void* buffer,size_t n)
{
  if (!file)
    return ERR_FILE_READ;
  if (((uint32)buffer)&1UL)
    return ERR_PTR;

  size_t blocks = (n<<1)/_SWAPBUFFSIZE;
  size_t nWords  = _SWAPBUFFSIZE>>1;

  size_t nRead = 0;

  while (blocks--) {
    nRead += fread(swapBuffer, 2, nWords, file);
    Mem::swap16(buffer, swapBuffer, nWords);
    n -= nWords;
  }
  nRead += fread(swapBuffer, 2, n, file);
  Mem::swap16(buffer, swapBuffer, n);
  return nRead;
}

////////////////////////////////////////////////////////////////////////////////

sint32 StreamIn::read32Swap(void* buffer,size_t n)
{
  if (!file)
    return ERR_FILE_READ;
  if (((uint32)buffer)&1UL)
    return ERR_PTR;

  size_t blocks = (n<<2)/_SWAPBUFFSIZE;
  size_t nWords  = _SWAPBUFFSIZE>>2;

  size_t nRead = 0;

  while (blocks--) {
    nRead += fread(swapBuffer, 4, nWords, file);
    Mem::swap32(buffer, swapBuffer, nWords);
    n -= nWords;
  }
  nRead += fread(swapBuffer, 4, n, file);
  Mem::swap32(buffer, swapBuffer, n);
  return nRead;
}

////////////////////////////////////////////////////////////////////////////////

sint32 StreamIn::read64Swap(void* buffer,size_t n)
{
  if (!file)
    return ERR_FILE_READ;
  if (((uint32)buffer)&1UL)
    return ERR_PTR;

  size_t blocks = (n<<3)/_SWAPBUFFSIZE;
  size_t nWords  = _SWAPBUFFSIZE>>3;

  size_t nRead = 0;

  while (blocks--) {
    nRead += fread(swapBuffer, 8, nWords, file);
    Mem::swap64(buffer, swapBuffer, nWords);
    n -= nWords;
  }
  nRead += fread(swapBuffer, 8, n, file);
  Mem::swap64(buffer, swapBuffer, n);
  return nRead;
}

////////////////////////////////////////////////////////////////////////////////

sint32 StreamIn::readText(char* buf, sint32 max, char mark, sint32 num)
{
  if (!file)
    return ERR_FILE_READ;
  char* p = buf;
  rsint32 i = max;
  while (--i && num)
  {
    rsint32 c = getChar();
    if (c==ERR_FILE_READ || c==EOF) // terminate if error
      break;
    if (c==(sint32)mark)
      num--;
    *(p++) = (char)c;
  }
  *p = 0; // null terminate
  return (max-i); // return num chars read
}

////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
//
//  StreamOut
//
////////////////////////////////////////////////////////////////////////////////


StreamOut::StreamOut() : file(0), swapBuffer(0)
{
  swapBuffer = Mem::alloc(_SWAPBUFFSIZE, false, Mem::ALIGN_CACHE);
}

////////////////////////////////////////////////////////////////////////////////

StreamOut::StreamIn(const char* f, bool textMode, bool append, size_t s) : file(0), swapBuffer(0)
{
  if (swapBuffer = Mem::alloc(_SWAPBUFFSIZE, false, Mem::ALIGN_CACHE))
    open(f, textMode, append, s);
}

////////////////////////////////////////////////////////////////////////////////

StreamIn::~StreamIn()
{
  close();
  if (swapBuffer)
    Mem::free(swapBuffer);
}

////////////////////////////////////////////////////////////////////////////////

sint32 StreamOut::open(const char* fileName, bool textMode, bool append, size_t reqSize)
{
  if (!swapBuffer)
    return ERR_NO_FREE_STORE;
  if (!fileName)
    return ERR_PTR_ZERO;
  if (file)
    return ERR_FILE_OPEN;
  if (append) {
    if (textMode)
      file = fopen(fileName, "a");
    else
      file = fopen(fileName, "ab");
  }
  else {
    if (textMode)
      file = fopen(fileName, "w");
    else
      file = fopen(fileName, "wb");
  }
  if (!file)
    return ERR_FILE_OPEN;
  return OK;
}

////////////////////////////////////////////////////////////////////////////////

sint32 StreamOut::seek(sint32 position, IOS::SeekMode mode)
{
  if (!file)
    return ERR_FILE_SEEK;
  switch(mode) {
    case SEEKSTART:
      fseek(file, position, SEEK_SET);
      break;
    case SEEKCURR:
      fseek(file, position, SEEK_CUR);
      break;
    case SEEKEND:
      fseek(file, position, SEEK_END);
  }
  sint32 res = ftell(file);
  if (res>=0)
    return res;
  return ERR_FILE_SEEK;
}

////////////////////////////////////////////////////////////////////////////////

sint32 StreamOut::write16Swap(void* buffer,size_t n)
{
  if (!file)
    return ERR_FILE_WRITE;
  if (((uint32)buffer|(uint32)offset)&1UL)
    return ERR_PTR;

  size_t blocks = (n<<1)/_SWAPBUFFSIZE;
  size_t nWords  = _SWAPBUFFSIZE>>1;

  size_t nWritten = 0;

  while (blocks--) {
    Mem::swap16(swapBuffer, buffer, nWords);
    nWritten += fwrite(swapBuffer, 2, nWords, file);
    n -= nWords;
  }
  Mem::swap16(buffer, swapBuffer, n);
  nWritten += fwrite(swapBuffer, 2, n, file);
  return nWritten;
}

////////////////////////////////////////////////////////////////////////////////

sint32 StreamOut::write32Swap(void* buffer,size_t n)
{
  if (!file)
    return ERR_FILE_WRITE;
  if (((uint32)buffer|(uint32)offset)&1UL)
    return ERR_PTR;

  size_t blocks = (n<<2)/_SWAPBUFFSIZE;
  size_t nWords  = _SWAPBUFFSIZE>>2;

  size_t nWritten = 0;

  while (blocks--) {
    Mem::swap16(swapBuffer, buffer, nWords);
    nWritten += fwrite(swapBuffer, 4, nWords, file);
    n -= nWords;
  }
  Mem::swap16(buffer, swapBuffer, n);
  nWritten += fwrite(swapBuffer, 4, n, file);
  return nWritten;
}

////////////////////////////////////////////////////////////////////////////////

sint32 StreamOut::write64Swap(void* buffer,size_t n)
{
  if (!file)
    return ERR_FILE_WRITE;
  if (((uint32)buffer|(uint32)offset)&1UL)
    return ERR_PTR;

  size_t blocks = (n<<3)/_SWAPBUFFSIZE;
  size_t nWords  = _SWAPBUFFSIZE>>3;

  size_t nWritten = 0;

  while (blocks--) {
    Mem::swap16(swapBuffer, buffer, nWords);
    nWritten += fwrite(swapBuffer, 8, nWords, file);
    n -= nWords;
  }
  Mem::swap16(buffer, swapBuffer, n);
  nWritten += fwrite(swapBuffer, 8, n, file);
  return nWritten;
}

////////////////////////////////////////////////////////////////////////////////

sint32 StreamOut::writeText(const char* format,...)
{
  if (!file)
    return ERR_FILE_WRITE;
  va_list a;
  va_start(a,format);
  sint32 num = vfprintf(file, textBuffer, format, a);
  va_end(a);
  if (num>0)
    return num;
  return ERR_FILE_WRITE;
}

////////////////////////////////////////////////////////////////////////////////

