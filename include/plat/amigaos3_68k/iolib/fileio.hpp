//****************************************************************************//
//**                                                                        **//
//** File:         include/plat/amigaos3_68k/iolib/fileio.hpp               **//
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

namespace X_SYSNAME {
  extern "C" {
    #include <proto/dos.h>
  }
};


////////////////////////////////////////////////////////////////////////////////
//
//  AsyncStreamBuffer
//
//  Common system code for both input and output asynchronous streams. This is
//  purely an implementation class and should be inherited at the private access
//  level.
//
////////////////////////////////////////////////////////////////////////////////

class AsyncStreamBuffer {
  protected:
    sint32  bufferSize;
    sint32  fileSize;
    sint32  blockSize;
    uint32  flags;
    uint32  currentBuf;
    uint32  seekOffset;
    sint32  bytesLeft;
    void*    buffers[2];
    void*    offset;

    X_SYSNAME::BPTR            file;
    X_SYSNAME::MsgPort*        handler;
    X_SYSNAME::StandardPacket  packet;
    X_SYSNAME::MsgPort        packetPort;


    sint32  waitPacket();
    void    sendPacket(void* p);
    void    requeuePacket();
    void    recordSyncFailure();

    enum {
      WAIT_PACKET = 0x00000001,
      FILE_ATEND  = 0x00000002,
      FILE_START  = 0x00000004,
      FILE_GOOD    = 0x00000008,
      FILE_READ    = 0x00000010,
      FILE_WRITE  = 0x00000020,
      FILE_APPEND  = 0x00000040,
      FILE_TEXT    = 0x00000080,
      FILE_ACCESS  = 0x000000F0,
      BUFF_ERROR  = 0x00010000
    };

    static  bool exists(const char* f);
    sint32  create(size_t s);
    void    destroy();

    bool    valid()  const  { return flags & FILE_GOOD; }
    bool    end()   const  { return flags & FILE_ATEND; }
    bool    start()  const  { return flags & FILE_START; }
    sint32  size()   const  { return (flags & FILE_ACCESS) ? fileSize : IOS::ERR_FILE; }

    AsyncStreamBuffer() : file(0), flags(0) { buffers[0] = 0; }
    ~AsyncStreamBuffer()  { destroy(); }
};

////////////////////////////////////////////////////////////////////////////////
//
//  StreamIn
//
////////////////////////////////////////////////////////////////////////////////

class StreamIn : public IOS, private AsyncStreamBuffer {
  friend class StreamUser;
  private:
    sint32  processIO();

  protected:
    sint32  rawWriteBytes(const void* buffer, size_t n, sint32 filePos);

  public:
    sint32  open(const char* f, bool textMode, size_t s=2048);
    void    close();
    void    flush();
    sint32  tell();
    sint32  seek(sint32 position, IOS::SeekMode m=SEEKSTART);
    bool    valid()      const { return AsyncStreamBuffer::valid(); }
    bool    end()       const { return AsyncStreamBuffer::end(); }
    bool    start()      const { return AsyncStreamBuffer::start(); }
    sint32  size()       const { return AsyncStreamBuffer::size(); }
    sint32  getChar()
    {
      if (bytesLeft==0)  {
        sint32 res = processIO();
        if (res!=OK) {
          return res;
        }
      }
      bytesLeft--;
      return *((char*)offset)++;
    }

    sint32  readBytes(void* buffer, size_t n);

    sint32  read8(void* d, size_t n)
    {
      return readBytes(d, n);
    }

    sint32  read16(void* d, size_t n)
    {
      sint32 res = readBytes(d, n<<1);
      return res>0 ? res>>1 : res;
    }

    sint32  read32(void* d,size_t n)
    {
      sint32 res = readBytes(d, n<<2);
      return res>0 ? res>>2 : res;
    }

    sint32  read64(void* d, size_t n)
    {
      sint32 res = readBytes(d, n<<3);
      return res>0 ? res>>3 : res;
    }

    sint32  read16Swap(void* d, size_t n);
    sint32  read32Swap(void* d, size_t n);
    sint32  read64Swap(void* d, size_t n);
    sint32  readText(char*buf, sint32 max, char mark=0, sint32 num=-1);

  public:
    StreamIn() : AsyncStreamBuffer() {}
    StreamIn(const char* f, bool textMode, size_t s=2048) : AsyncStreamBuffer()
    {
      open(f, textMode, s);
    };
    ~StreamIn();
};

////////////////////////////////////////////////////////////////////////////////
//
//  StreamOut
//
////////////////////////////////////////////////////////////////////////////////

#define STREAMOUT_TEXTBUFFSIZE 2048

class StreamOut : public IOS, private AsyncStreamBuffer {
  friend class StreamUser;

  private:
    char*    textBuffer;

  protected:
    sint32  rawReadBytes(void* buffer, size_t n, sint32 filePos);

  public:
    sint32  open(const char* f, bool textMode, bool append = false, size_t s=2048);
    void    close();
    void    flush();
    sint32  tell();
    sint32  seek(sint32 position, IOS::SeekMode m=SEEKSTART);
    bool    valid()      const { return AsyncStreamBuffer::valid(); }
    bool    end()       const { return AsyncStreamBuffer::end(); }
    bool    start()      const { return AsyncStreamBuffer::start(); }
    sint32  size()       const { return AsyncStreamBuffer::size(); }
    sint32  putChar(char ch)
    {
      if (bytesLeft==0)  {
        if (waitPacket() < 0)  {
          flags &= ~FILE_GOOD;
          return ERR_FILE_WRITE;
        }
        sendPacket(buffers[currentBuf]); // send the current buffer
        currentBuf  ^= 1;
        offset      = buffers[currentBuf];
        bytesLeft    = bufferSize;
      }
      bytesLeft--;
      *(((char*)offset)++) = ch;
      return ch;
    }

    sint32  writeBytes(const void* buffer, size_t n);

    sint32  write8(const void* s, size_t n)
    {
      return writeBytes(s, n);
    }

    sint32  write16(const void* s, size_t n)
    {
      sint32 res = writeBytes(s, n<<1);
      return res>0 ? res>>1 : res;
    }

    sint32  write32(const void* s, size_t n)
    {
      sint32 res = writeBytes(s, n<<2);
      return res>0 ? res>>2 : res;
    }

    sint32  write64(const void* s, size_t n)
    {
      sint32 res = writeBytes(s, n<<3);
      return res>0 ? res>>3 : res;
    }

    sint32  write16Swap(const void* s, size_t n);
    sint32  write32Swap(const void* s, size_t n);
    sint32  write64Swap(const void* s, size_t n);
    sint32  writeText(const char* format,...);

  public:
    StreamOut() : AsyncStreamBuffer(), textBuffer(0) {}
    StreamOut(const char* f, bool textMode, bool append, size_t s=2048) :
    AsyncStreamBuffer(), textBuffer(0)
    {
      open(f, textMode, append, s);
    };
    ~StreamOut();
};

////////////////////////////////////////////////////////////////////////////////
//
//  StreamUser
//
//  Exposes protected StreamIn/Out methods to inheritor
//
////////////////////////////////////////////////////////////////////////////////

class StreamUser {
  protected:
    static sint32 rawReadBytes(StreamOut* out, void* buffer, size_t n, sint32 filePos)
    {
      return out->rawReadBytes(buffer, n, filePos);
    }

    static sint32 rawWriteBytes(StreamIn* in, void* buffer, size_t n, sint32 filePos)
    {
      return in->rawWriteBytes(buffer, n, filePos);
    }
};

#endif