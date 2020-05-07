//****************************************************************************//
//**                                                                        **//
//** File:         include/iolib/xsfio.hpp                                  **//
//** Description:  XSF IO classes                                           **//
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

////////////////////////////////////////////////////////////////////////////////


#ifndef _EXTROPIA_IOLIB_XSFIO_HPP
#define _EXTROPIA_IOLIB_XSFIO_HPP

#include <iolib/fileio.hpp>
#include <iolib/xsftypes.hpp>
#include <utilitylib/keys.hpp>

extern "C" {
  #include <string.h>
}

#define XSF_SIG {'X','S','F',0}
#define XSF_VER 1
#define XSF_REV 0
#define XSF_DEF_BUFSIZE 8192

////////////////////////////////////////////////////////////////////////////////
//
//  XSF
//
//  Base enumerations
//
////////////////////////////////////////////////////////////////////////////////

class XSF {
  public:
    enum {
      ERR_FORMAT                = -1,
      ERR_VERSION                = -2,
      ERR_REVISION              = -3,
      ERR_SUBFORMAT              = -4,
      ERR_SUBFORMAT_VERSION      = -5,
      ERR_SUBFORMAT_REVISION    = -6,
      ERR_OBJECT_READ_HEADER    = -7,
      ERR_OBJECT_WRITE_HEADER    = -8,
      ERR_OBJECT_UNREADY_READ    = -9,
      ERR_OBJECT_UNREADY_WRITE  = -10
    };

    enum {
      CONV_BYTESWAP      = 0x00000001,
      CONV_NEG1STO2S    = 0x00000002,
      CONV_NEG2STO1S    = 0x00000004,
    };
    static const uint8  verXSF;
    static const uint8  revXSF;
};

////////////////////////////////////////////////////////////////////////////////
//
//  XSFStream
//
//  Forms the basis of an XSF storage file. The file signature and formatting
//  parameters are maintained here. The data therein is always read from and
//  written to the very beginning of a file.
//
////////////////////////////////////////////////////////////////////////////////


class XSFStream : public XSF {
  protected:
    class XSFHeader : protected StreamUser {
      private:
        static  char  sigXSF[4]; // XSF\0
        uint8          verXSF;
        uint8          revXSF;
        char          sig[6];
        uint8          version;
        uint8          revision;
        uint8         dataFormat;
        uint8          fileOpts;
        void          init();

      public:
        void    getSignature(char* buf) { strncpy(buf, sig, 6); }
        sint32  read(StreamIn* in);
        sint32  read(StreamOut* out);
        sint32  write(StreamOut* out);

        void    set(const char* id, uint8 v, uint8 r, uint8 df, uint8 ff);
        uint8    getXSFVersion()    const { return verXSF; }
        uint8    getXSFRevision()  const { return verXSF; }
        uint8    getVersion()      const {  return version; }
        uint8    getRevision()      const {  return revision; }
        uint8    getDataFormat()    const { return dataFormat; }
        uint8    getFileOpts()      const { return fileOpts; }
        bool    match(const char* id) {  return strncmp(id, sig, 6)==0 ? true : false;  }

        XSFHeader()
        {
          init();
        }

        XSFHeader(const char* id, uint8 v, uint8 r, uint8 df=X_HARDWARE, uint8 ff=0)
        {
          init();
          set(id, v, r, df, ff);
        }
    };

    XSFHeader  header;
    uint32    convFlags;

  protected:
    XSFStream() : header(), convFlags(0) { }

  public:
    void      dump();
    uint32    getConvState(uint32 c)  const { return (convFlags & c); }
    uint8      getVersion()            const { return header.getVersion(); }
    uint8      getRevision()            const { return header.getRevision(); }
    uint8      getFormat()              const { return header.getDataFormat(); }
    uint8      getOptions()            const { return header.getFileOpts(); }
    virtual   ~XSFStream()            {}
};

class XSFStorable;

////////////////////////////////////////////////////////////////////////////////
//
//  XSFStreamIn
//
////////////////////////////////////////////////////////////////////////////////

class XSFStreamIn : public XSFStream, private StreamIn {
  friend class XSFStreamUser;

  protected:
    // As in the equivalent StreamOut, these functions return the number of
    // elements written. These functions are exposed by XSFStreamUser
    sint32  read8(void* buf, size_t n);
    sint32  read16(void* buf, size_t n);
    sint32  read32(void* buf, size_t n);
    sint32  read64(void* buf, size_t n);
    sint32  seek(sint32 pos, IOS::SeekMode mode)
    {
      return StreamIn::seek(pos, mode);
    }

  public:
    sint32  open(const char* name, size_t bufSize=XSF_DEF_BUFSIZE);
    sint32  open(const char* name, const char* sig, uint8 minVer, uint8 minRev, size_t bufSize=XSF_DEF_BUFSIZE);
    sint32  close();

  public:
    XSFStreamIn();
    ~XSFStreamIn();
};

////////////////////////////////////////////////////////////////////////////////
//
//  XSFStreamOut
//
////////////////////////////////////////////////////////////////////////////////

class XSFStreamOut : public XSFStream, private StreamOut {
  friend class XSFStreamUser;

  protected:
    // As in the equivalent StreamOut, these functions return the number of
    // elements written. These functions are exposed by XSFStreamUser
    sint32  write8(const void* buf, size_t n);
    sint32  write16(const void* buf, size_t n);
    sint32  write32(const void* buf, size_t n);
    sint32  write64(const void* buf, size_t n);
    sint32  seek(sint32 pos, IOS::SeekMode mode)
    {
      return StreamOut::seek(pos, mode);
    }

  public:
    sint32  open(const char* name, size_t bufSize=XSF_DEF_BUFSIZE);
    sint32  open(const char* name, const char* sig, uint8 ver, uint8 rev, uint8 d, uint8 f, size_t bufSize=XSF_DEF_BUFSIZE);
    sint32  close();

  public:
    XSFStreamOut();
    ~XSFStreamOut();
};

////////////////////////////////////////////////////////////////////////////////
//
//  XSFStreamUser
//
////////////////////////////////////////////////////////////////////////////////

class XSFStreamUser {
  protected:
    static sint32 seek(XSFStreamIn* xin, sint32 pos, IOS::SeekMode mode)
    {
      return xin->seek(pos, mode);
    }

    static sint32 seek(XSFStreamOut* xout, sint32 pos, IOS::SeekMode mode)
    {
      return xout->seek(pos, mode);
    }

    // readElementN/writeElementN return number of elements transferred
    static sint32  readElement8(XSFStreamIn* xin, void* data, size_t n)
    {
      return xin->read8(data, n);
    }

    static sint32  readElement16(XSFStreamIn* xin, void* data,size_t n)
    {
      return xin->read16(data, n);
    }

    static sint32  readElement32(XSFStreamIn* xin, void* data, size_t n)
    {
      return xin->read32(data, n);
    }

    static sint32  readElement64(XSFStreamIn* xin, void* data, size_t n)
    {
      return xin->read64(data, n);
    }

    static sint32  writeElement8(XSFStreamOut* xout, const void* data, size_t n)
    {
      return xout->write8(data, n);
    }

    static sint32  writeElement16(XSFStreamOut* xout, const void* data, size_t n)
    {
      return xout->write16(data, n);
    }

    static sint32  writeElement32(XSFStreamOut* xout, const void* data, size_t n)
    {
      return xout->write32(data, n);
    }

    static sint32  writeElement64(XSFStreamOut* xout, const void* data, size_t n)
    {
      return xout->write64(data, n);
    }

    // readN/writeN return number of bytes transferred
    static sint32  read8(XSFStreamIn* xin, void* data, size_t n)
    {
      return xin->read8(data, n);
    }

    static sint32  read16(XSFStreamIn* xin, void* data,size_t n)
    {
      sint32 result = xin->read16(data, n);
      return (result<=0) ? result : result<<1;
    }

    static sint32  read32(XSFStreamIn* xin, void* data, size_t n)
    {
      sint32 result = xin->read32(data, n);
      return (result<=0) ? result : result<<2;
    }

    static sint32  read64(XSFStreamIn* xin, void* data, size_t n)
    {
      sint32 result = xin->read64(data, n);
      return (result<=0) ? result : result<<3;
    }

    static sint32  write8(XSFStreamOut* xout, const void* data, size_t n)
    {
      return xout->write8(data, n);
    }

    static sint32  write16(XSFStreamOut* xout, const void* data, size_t n)
    {
      sint32 result = xout->write16(data, n);
      return (result<=0) ? result : result<<1;
    }

    static sint32  write32(XSFStreamOut* xout, const void* data, size_t n)
    {
      sint32 result = xout->write32(data, n);
      return (result<=0) ? result : result<<2;
    }

    static sint32  write64(XSFStreamOut* xout, const void* data, size_t n)
    {
      sint32 result = xout->write64(data, n);
      return (result<=0) ? result : result<<3;
    }
};


////////////////////////////////////////////////////////////////////////////////
//
//  XSFStorable
//
//  This is the base for any object that can be written or read from an XSF
//  binary stream.
//
////////////////////////////////////////////////////////////////////////////////

class XSFStorable : protected XSFStreamUser {
  private:
    static uint8 fileMarker[4];
    Key32    chunkID;
    uint16  superClass;
    uint16  subClass;
    uint16  cnctSuper;
    uint16  cnctSub;
    uint32  rawSize;
    uint32  namePtr;
    uint32  extProps;
    uint16  control;
    uint8    version;
    uint8    revision;

  protected:
    void    setID(const char* text)          { chunkID = text; }
    void    setSuperClass(uint16 c)          { superClass = c; }
    void    setSubClass(uint16 c)            { subClass = c; }
    void    setRawSize(size_t t)            { rawSize = t; }
    void    setExtendedProps(uint32 p)      { extProps = p; }
    void    setControl(uint16 c)            { control = c; }
    void    setVersion(uint8 v)              { version = v; }
    void    setRevision(uint8 r)            { revision = r; }

    // object body IO
    virtual sint32 readyForWrite()            { return OK; }
    virtual sint32 readyForRead()              { return OK; }
    virtual sint32 writeBody(XSFStreamOut* f)  { return 0; }        // must return bytes written or error type
    virtual sint32 readBody(XSFStreamIn* f)    { return 0; }        // must return bytes read or error type

    virtual  void   dumpBody()  {}

  public:
    enum {
      SEEK_CHUNKID        = 4,
      SEEK_SUPERCLASS      = 6,
      SEEK_SUBCLASS        = 8,
      SEEK_CONSUPERCLASS  = 10,
      SEEK_CONSUBCLASS    = 12,
      SEEK_RAWSIZE        = 16,
      SEEK_NAMEPTR        = 20,
      SEEK_EXTPROPS        = 24,
      SEEK_CONTROL        = 28,
      SEEK_VERSION        = 30,
      SEEK_REVISION        = 31,
      SEEK_OBJECTDATA      = 32,
      SEEK_SIZE           = ((sizeof(Key32))+(5*sizeof(uint16))+(3*sizeof(uint32))+(6*sizeof(uint8)))
    };

    Key32    getID()              const  { return chunkID; }
    uint16  getSuperClass()      const  { return superClass; }
    uint16  getSubClass()        const  { return subClass; }
    uint32  getRawSize()        const  { return rawSize; }
    uint32  getExtendedProps()  const  { return extProps; }
    uint16  getControl()        const { return control; }
    uint8    getVersion()        const { return version; }
    uint8    getRevision()        const { return revision; }
    sint32  write(XSFStreamOut* f);  // returns total bytes written (or error)
    sint32  read(XSFStreamIn* f);    // returns total bytes read (or error)

    void    dump();

  public:
    XSFStorable();
    XSFStorable(const char* desc, uint16 super, uint16 sub, uint8 ver, uint8 rev);
    virtual ~XSFStorable() {}
};


#endif
