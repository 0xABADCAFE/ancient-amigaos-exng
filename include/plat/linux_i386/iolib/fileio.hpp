//****************************************************************************//
//**                                                                        **//
//** File:         include/plat/linux_i388/iolib/fileio.hpp                 **//
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

#ifndef _EXTROPIA_IOLIB_FILEIO_NATIVE_HPP
#define _EXTROPIA_IOLIB_FILEIO_NATIVE_HPP

#define _SWAPBUFFSIZE 8192

////////////////////////////////////////////////////////////////////////////////
//
//  StreamIn
//
////////////////////////////////////////////////////////////////////////////////

class StreamIn : public IOS {
  private:
    FILE*    file;
    void*    swapBuffer;

  public:
    sint32  open(const char* f, bool textMode, size_t s=2048);
    void    close()
    {
      if (file) {
        fclose(file);
        file=0;
      }
    }
    void    flush() {  }
    sint32  tell()
    {
      if (file)
        return ftell(file);
      return ERR_FILE_SEEK;
    }
    sint32  seek(sint32 position, IOS::SeekMode m=SEEKSTART);
    bool    valid()
    {
      return file?true:false;
    }
    bool    end()
    {
      if (file)
        return feof(file)?true:false;
      return false;
    }
    bool    start()
    {
      if (file)
        return ftell(file)?false:true;
      return false;
    }
    sint32  size();
    sint32  getChar()
    {
      if (file)
        return fgetc(file);
      return ERR_FILE_READ;
    }
    sint32  readBytes(void* buffer, size_t n)
    {
      if (file)
        return fread(buffer, 1, n, file);
      return ERR_FILE_READ;
    }
    sint32  read8(void* d, size_t n)
    {
      if (file)
        return fread(buffer, 1, n, file);
      return ERR_FILE_READ;
    }
    sint32  read16(void* d, size_t n)
    {
      if (file)
        return fread(buffer, 2, n, file);
      return ERR_FILE_READ;
    }
    sint32  read32(void* d,size_t n)
    {
      if (file)
        return fread(buffer, 4, n, file);
      return ERR_FILE_READ;
    }
    sint32  read64(void* d, size_t n)
    {
      if (file)
        return fread(buffer, 8, n, file);
      return ERR_FILE_READ;
    }
    sint32  read16Swap(void* d, size_t n);
    sint32  read32Swap(void* d, size_t n);
    sint32  read64Swap(void* d, size_t n);
    sint32  readText(char*buf, sint32 max, char mark=0, sint32 num=-1);

  public:
    StreamIn();
    StreamIn(const char* f, bool textMode, size_t s=2048);
    ~StreamIn();
};

////////////////////////////////////////////////////////////////////////////////
//
//  StreamOut
//
////////////////////////////////////////////////////////////////////////////////

#define STREAMOUT_TEXTBUFFSIZE 2048

class StreamOut : public IOS {
  private:
    FILE*    file;
    void*    swapBuffer;

  public:
    sint32  open(const char* f, bool textMode, bool append = false, size_t s=2048);
    void    close()
    {
      if (file) {
        fclose(file);
        file=0;
      }
    }
    void    flush()
    {
      if (file)
        fflush(file);
    }
    sint32  tell()
    {
      if (file)
        return ftell(file);
      return ERR_FILE_SEEK;
    }
    sint32  seek(sint32 position, IOS::SeekMode m=SEEKSTART);
    bool    valid()
    {
      return file?true:false;
    }
    bool    end()
    {
      if (file)
        return feof(file)?true:false;
      return false;
    }
    bool    start()
    {
      if (file)
        return ftell(file)?false:true;
      return false;
    }
    sint32  size();
    sint32  putChar(char ch)
    {
      if (file)
        return fputc(ch, file);
      return ERR_FILE_WRITE;
    }
    sint32  writeBytes(void* buffer, size_t n)
    {
      if (file)
        return fwrite(buffer, 1, n, file);
      return ERR_FILE_WRITE;
    }
    sint32  write8(void* s, size_t n)
    {
      if (file)
        return fwrite(buffer, 1, n, file);
      return ERR_FILE_WRITE;
    }
    sint32  write16(void* s, size_t n)
    {
      if (file)
        return fwrite(buffer, 2, n, file);
      return ERR_FILE_WRITE;
    }
    sint32  write32(void* s, size_t n)
    {
      if (file)
        return fwrite(buffer, 4, n, file);
      return ERR_FILE_WRITE;
    }
    sint32  write64(void* s, size_t n)
    {
      if (file)
        return fwrite(buffer, 8, n, file);
      return ERR_FILE_WRITE;
    }
    sint32  write16Swap(void* s, size_t n);
    sint32  write32Swap(void* s, size_t n);
    sint32  write64Swap(void* s, size_t n);
    sint32  writeText(const char* format,...);

  public:
    StreamOut();
    StreamOut(const char* f, bool textMode, bool append, size_t s=2048);
    ~StreamOut();
};

////////////////////////////////////////////////////////////////////////////////
//
//  StreamUser
//
//  Exposes protected StreamIn/Out methods to inheritor
//
////////////////////////////////////////////////////////////////////////////////


#endif