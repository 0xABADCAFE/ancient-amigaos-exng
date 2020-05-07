//****************************************************************************//
//**                                                                        **//
//** File:         libsrc/common/iolib/xsf.cpp                              **//
//** Description:  eXtropia Storage Format (XSF) core implementation        **//
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

#include <iolib/xsfio.hpp>

extern "C" {
  #include <string.h>
}

const uint8 XSF::verXSF = XSF_VER;
const uint8 XSF::revXSF = XSF_REV;

////////////////////////////////////////////////////////////////////////////////
//
//  XSFStream::XSFHeader
//
////////////////////////////////////////////////////////////////////////////////

char XSFStream::XSFHeader::sigXSF[4] = XSF_SIG;

void XSFStream::XSFHeader::init()
{
  verXSF      = XSF_VER;
  revXSF      = XSF_REV;
  sig[0]      = 0; sig[1] = 0; sig[2] = 0; sig[3] = 0; sig[4] = 0; sig[5] = 0;
  version      = 0;
  revision    = 0;
  dataFormat  = X_HARDWARE;
  fileOpts    = 0;
}

////////////////////////////////////////////////////////////////////////////////

void XSFStream::XSFHeader::set(const char* id, uint8 v, uint8 r, uint8 df, uint8 ff)
{
  // signature can be upto 6 chars. If less than 6 chars, remainder must be
  // zero bytes
  char* tID = (char*)id;
  {
    rsint16  i = 7; char* s = sig;
    while (--i)
      if ( !((*s++)=(*tID++)) )  break;
    if (i++)
      while (--i)  *s++ = 0;
  }
  version      = v;
  revision    = r;
  dataFormat  = df;
  fileOpts    = ff;
}

////////////////////////////////////////////////////////////////////////////////

sint32 XSFStream::XSFHeader::read(StreamIn* in)
{
  uint8 buffer[(4+sizeof(XSFHeader))];

  if (!in ||!in->valid() ||
      in->read8(buffer, (4+sizeof(XSFHeader)))!=(4+sizeof(XSFHeader)))
    return IOS::ERR_FILE_READ;
  if (strncmp((char*)buffer, sigXSF, 4)!=0)
    return XSF::ERR_FORMAT;
  verXSF = buffer[4];
  revXSF = buffer[5];
  set((char*)&buffer[6], buffer[12], buffer[13], buffer[14], buffer[15]);
  return OK;
}

////////////////////////////////////////////////////////////////////////////////

sint32 XSFStream::XSFHeader::read(StreamOut* out)
{
  uint8 buffer[(4+sizeof(XSFHeader))];

  if (!out ||!out->valid() ||
      rawReadBytes(out, buffer, (4+sizeof(XSFHeader)), 0)!=(4+sizeof(XSFHeader)))
    return IOS::ERR_FILE_READ;
  if (strncmp((char*)buffer, sigXSF, 4)!=0)
    return XSF::ERR_FORMAT;
  verXSF = buffer[4];
  revXSF = buffer[5];
  set((char*)&buffer[6], buffer[12], buffer[13], buffer[14], buffer[15]);
  return OK;
}

////////////////////////////////////////////////////////////////////////////////

sint32 XSFStream::XSFHeader::write(StreamOut* out)
{
  if (!out ||!out->valid())
    return IOS::ERR_FILE_WRITE;
  if (out->write8(sigXSF, 4)!=4)
    return IOS::ERR_FILE_WRITE;
  if (out->write8(&verXSF, sizeof(XSFHeader))!=sizeof(XSFHeader))
    return IOS::ERR_FILE_WRITE;
  return OK;
}

////////////////////////////////////////////////////////////////////////////////

void XSFStream::dump()
{
  char type[8] = {0};
  header.getSignature(type);
  printf("\nSignature     : %s\n", type);
  printf("XSF Version   : %ld\n",   (sint32)header.getXSFVersion());
  printf("XSF Revision  : %ld\n",   (sint32)header.getXSFRevision());
  printf("Version       : %ld\n",   (sint32)header.getVersion());
  printf("Revision      : %ld\n",   (sint32)header.getRevision());
  printf("Data Format   : 0x%02X\n",(unsigned)header.getDataFormat());
  printf("File Options  : 0x%02X\n\n",(unsigned)header.getFileOpts());
}

////////////////////////////////////////////////////////////////////////////////
//
//  XSFStreamIn
//
////////////////////////////////////////////////////////////////////////////////

XSFStreamIn::XSFStreamIn() : XSFStream()
{

}

////////////////////////////////////////////////////////////////////////////////

XSFStreamIn::~XSFStreamIn()
{
  close();
}

////////////////////////////////////////////////////////////////////////////////

sint32 XSFStreamIn::open(const char* name, size_t bufSize)
{  // open any XSF stream type
  sint32 result = StreamIn::open(name, false, bufSize);
  if (result != OK)
    return result;

  XSFHeader temp;
  result = temp.read(this);

  if (result==OK) {
    if ((temp.getDataFormat() & XA_ENDIANMASK) != X_ENDIAN) {
      convFlags |= XSF::CONV_BYTESWAP;
    }
    if ((temp.getDataFormat() & XA_NEGATIVEMASK) != X_NEGATIVE) {
      #if (X_NEGATIVE == X_TWOSCOMP)
      convFlags |= XSF::CONV_NEG1STO2S;
      #else
      convFlags |= XSF::CONV_NEG2STO1S;
      #endif
    }
    header = temp;
  }
  return result;
}

////////////////////////////////////////////////////////////////////////////////

sint32 XSFStreamIn::open(const char* name, const char* sig, uint8 minVer, uint8 minRev, size_t bufSize)
{  // open a specific XSF stream type
  sint32 result = StreamIn::open(name, false, bufSize);
  if (result != OK)
    return result;
  XSFHeader temp;
  result = temp.read(this);
  if (result != OK)
    return result;
  if (!temp.match(sig))
    return XSF::ERR_SUBFORMAT;
  if (minVer > temp.getVersion())
    return XSF::ERR_SUBFORMAT_VERSION;
  if (minRev > temp.getRevision())
    return XSF::ERR_SUBFORMAT_VERSION;

  if ((temp.getDataFormat() & XA_ENDIANMASK) != X_ENDIAN) {
    convFlags |= XSF::CONV_BYTESWAP;
  }
  if ((temp.getDataFormat() & XA_NEGATIVEMASK) != X_NEGATIVE) {
    #if (X_NEGATIVE == X_TWOSCOMP)
    convFlags |= XSF::CONV_NEG1STO2S;
    #else
    convFlags |= XSF::CONV_NEG2STO1S;
    #endif
  }
  header = temp;
  return OK;
}

////////////////////////////////////////////////////////////////////////////////

sint32 XSFStreamIn::close()
{
  StreamIn::close();
  convFlags = 0;
  return 0;
}

////////////////////////////////////////////////////////////////////////////////

sint32 XSFStreamIn::read8(void* buf, size_t n)
{
  return StreamIn::read8(buf, n);
}

////////////////////////////////////////////////////////////////////////////////

sint32 XSFStreamIn::read16(void* buf, size_t n)
{
  if (getConvState(XSF::CONV_BYTESWAP))
    return StreamIn::read16Swap(buf, n);
  else
    return StreamIn::read16(buf, n);
}

////////////////////////////////////////////////////////////////////////////////

sint32 XSFStreamIn::read32(void* buf, size_t n)
{
  if (getConvState(XSF::CONV_BYTESWAP))
    return StreamIn::read32Swap(buf, n);
  else
    return StreamIn::read32(buf, n);
}

////////////////////////////////////////////////////////////////////////////////

sint32 XSFStreamIn::read64(void* buf, size_t n)
{
  if (getConvState(XSF::CONV_BYTESWAP))
    return StreamIn::read64Swap(buf, n);
  else
    return StreamIn::read64(buf, n);
}


////////////////////////////////////////////////////////////////////////////////
//
//  XSFStreamOut
//
////////////////////////////////////////////////////////////////////////////////

XSFStreamOut::XSFStreamOut() : XSFStream()
{

}

////////////////////////////////////////////////////////////////////////////////

XSFStreamOut::~XSFStreamOut()
{
  close();
}

////////////////////////////////////////////////////////////////////////////////

sint32 XSFStreamOut::open(const char* name, size_t bufSize)
{
  sint32 result = StreamOut::open(name, false, true, bufSize);
  if (result != OK)
    return result;

  XSFHeader temp;
  result = temp.read(this);

  if (result==OK) {
    if ((temp.getDataFormat() & XA_ENDIANMASK) != X_ENDIAN) {
      convFlags |= XSF::CONV_BYTESWAP;
    }
    if ((temp.getDataFormat() & XA_NEGATIVEMASK) != X_NEGATIVE) {
      #if (X_NEGATIVE == X_TWOSCOMP)
      convFlags |= XSF::CONV_NEG1STO2S;
      #else
      convFlags |= XSF::CONV_NEG2STO1S;
      #endif
    }
    header = temp;
  }
  return result;
}

////////////////////////////////////////////////////////////////////////////////

sint32 XSFStreamOut::open(const char* name, const char* sig, uint8 ver, uint8 rev, uint8 d, uint8 f, size_t bufSize)
{  // open a specific XSF stream type
  sint32 result = StreamOut::open(name, false, bufSize);
  if (result != OK)
    return result;
  header.set(sig, ver, rev, d, f);
  result = header.write(this);
  if (result != OK)
    return result;

  // check for deliberate non-native data format specs
  if ((d & XA_ENDIANMASK) != X_ENDIAN)
    convFlags |= XSF::CONV_BYTESWAP;
  if ((d & XA_NEGATIVEMASK) != X_NEGATIVE) {
    #if (X_NEGATIVE == X_TWOSCOMP)
    convFlags |= XSF::CONV_NEG1STO2S;
    #else
    convFlags |= XSF::CONV_NEG2STO1S;
    #endif
  }
  return OK;
}

////////////////////////////////////////////////////////////////////////////////

sint32 XSFStreamOut::close()
{
  convFlags = 0;
  StreamOut::close();
  return 0;
}

////////////////////////////////////////////////////////////////////////////////

sint32 XSFStreamOut::write8(const void* buf, size_t n)
{
  return StreamOut::write8(buf, n);
}

////////////////////////////////////////////////////////////////////////////////

sint32 XSFStreamOut::write16(const void* buf, size_t n)
{
  if (getConvState(XSF::CONV_BYTESWAP))
    return StreamOut::write16Swap(buf, n);
  else
    return StreamOut::write16(buf, n);
}

////////////////////////////////////////////////////////////////////////////////

sint32 XSFStreamOut::write32(const void* buf, size_t n)
{
  if (getConvState(XSF::CONV_BYTESWAP))
    return StreamOut::write32Swap(buf, n);
  else
    return StreamOut::write32(buf, n);
}

////////////////////////////////////////////////////////////////////////////////

sint32 XSFStreamOut::write64(const void* buf, size_t n)
{
  if (getConvState(XSF::CONV_BYTESWAP))
    return StreamOut::write64Swap(buf, n);
  else
    return StreamOut::write64(buf, n);
}

////////////////////////////////////////////////////////////////////////////////
//
//  XSFStorable
//
////////////////////////////////////////////////////////////////////////////////

uint8 XSFStorable::fileMarker[4] = {'x','s','f',0};

////////////////////////////////////////////////////////////////////////////////

XSFStorable::XSFStorable() : chunkID("undefined"), superClass(T_none),
                             subClass(T_none), cnctSuper(T_none), cnctSub(T_none),
                             rawSize(0), namePtr(0), extProps(0), control(0),
                             version(0), revision(0)
{

}

////////////////////////////////////////////////////////////////////////////////

XSFStorable::XSFStorable(const char* desc, uint16 super, uint16 sub, uint8 ver, uint8 rev) :
                             chunkID(desc), superClass(super), subClass(sub),
                             cnctSuper(T_none), cnctSub(T_none), rawSize(0),
                             namePtr(0), extProps(0), control(0), version(ver),
                             revision(rev)
{

}

////////////////////////////////////////////////////////////////////////////////

sint32 XSFStorable::read(XSFStreamIn* in)
{
  if (!in)
    return ERR_PTR_ZERO;
  sint32 result = readyForRead();
  if (result != OK)
    return result;
  char marker[4] = {0};
  if (readElement8(in, marker, 4)!=4      || strncmp(marker, (char*)fileMarker, 3)!=0 ||
      readElement32(in, &chunkID, 1)!=1  || readElement16(in, &superClass, 4)!=4 ||
      readElement32(in, &rawSize, 3)!=3  || readElement16(in, &control, 1)!=1  ||
      readElement8(in, &version, 2)!=2)
    return XSF::ERR_OBJECT_READ_HEADER;
  result = readBody(in);
  if (result<0)
    return result;
  return result + SEEK_SIZE;
}

////////////////////////////////////////////////////////////////////////////////

sint32 XSFStorable::write(XSFStreamOut* out)
{
  if (!out)
    return ERR_PTR_ZERO;
  sint32 result = readyForRead();
  if (result != OK)
    return result;

  fileMarker[3] = out->getFormat();

  if (writeElement8(out, fileMarker, 4)!=4    || writeElement32(out, &chunkID, 1)!=1 ||
      writeElement16(out, &superClass, 4)!=4  || writeElement32(out, &rawSize, 3)!=3 ||
      writeElement16(out, &control, 1)!=1    || writeElement8(out, &version, 2)!=2)
    return XSF::ERR_OBJECT_WRITE_HEADER;

  result = writeBody(out);
  if (result<0)
    return result;
  return result + SEEK_SIZE;
}

////////////////////////////////////////////////////////////////////////////////

void XSFStorable::dump()
{
  puts("\nDump of XSFStorable object\n");
  printf("chunkID    0x%08X\n", (unsigned)chunkID);
  printf("superClass     0x%04X\n", (unsigned)superClass);
  printf("subClass       0x%04X\n", (unsigned)subClass);
  printf("cnctSuper      0x%04X\n", (unsigned)cnctSuper);
  printf("cnctSub        0x%04X\n", (unsigned)cnctSub);
  printf("rawSize    %10lu\n", rawSize);
  printf("namePtr    0x%08X\n", (unsigned)namePtr);
  printf("extProps   0x%08X\n", (unsigned)extProps);
  printf("control        0x%04X\n", (unsigned)control);
  printf("version    %ld\n", (sint32)version);
  printf("revision   %ld\n", (sint32)revision);
  dumpBody();
}

////////////////////////////////////////////////////////////////////////////////
