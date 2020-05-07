//****************************************************************************//
//**                                                                        **//
//** File:         proj/xdac2/compander.hpp                                 **//
//** Description:  Compander classes                                        **//
//** Comment(s):                                                            **//
//** Created:      2005-05-12                                               **//
//** Updated:      2005-05-12                                               **//
//** Author(s):    Karl Churchill                                           **//
//** Note(s):                                                               **//
//** Copyright:    (C)1996- , eXtropia Studios                              **//
//**               Serkan YAZICI, Karl Churchill                            **//
//**               All Rights Reserved.                                     **//
//**                                                                        **//
//****************************************************************************//

#include "pcm_aiff.hpp"

#include <math.h>
#include <string.h>

// AIFF is always organised as big endian

#if (X_ENDIAN == XA_BIGENDIAN)
  #define _READBIG64(d,n) (read64((d),(n)))
  #define _READBIG32(d,n) (read32((d),(n)))
  #define _READBIG16(d,n) (read16((d),(n)))
  #define _WRITEBIG64(d,n) (write64((d),(n)))
  #define _WRITEBIG32(d,n) (write32((d),(n)))
  #define _WRITEBIG16(d,n) (write16((d),(n)))
#else
  #define _READBIG64(d,n) (read64Swap((d),(n)))
  #define _READBIG32(d,n) (read32Swap((d),(n)))
  #define _READBIG16(d,n) (read16Swap((d),(n)))
  #define _WRITEBIG64(d,n) (write64Swap((d),(n)))
  #define _WRITEBIG32(d,n) (write32Swap((d),(n)))
  #define _WRITEBIG16(d,n) (write16Swap((d),(n)))
#endif

////////////////////////////////////////////////////////////////////////////////
//
//  InputAIFF16
//
//  InputPCMStream implementation, supports basic AIFF 16 only
//
////////////////////////////////////////////////////////////////////////////////


#define COMMSIZE 18
#define  SSNDSIZE 8

InputAIFF16::InputAIFF16() : StreamIn(), freq(0), numCh(0), dataOffset(0), dataSize(0)
{

}

InputAIFF16::~InputAIFF16()
{
  close();
}

#define U2F(u) (((float64)((sint32)(u - 2147483647L - 1))) + 2147483648.0)

void InputAIFF16::decodeIEEEExt(uint8* ieee)
{
  float64 f;

  sint32  expnt    = ((ieee[0] & 0x7F)<<8) | (ieee[1] & 0xFF);
  uint32  hiMant  = ((uint32)(ieee[2]))<<24
                  | ((uint32)(ieee[3]))<<16
                  | ((uint32)(ieee[4]))<<8
                  | ((uint32)(ieee[5]));
  uint32  loMant  = ((uint32)(ieee[6]))<<24
                  | ((uint32)(ieee[7]))<<16
                  | ((uint32)(ieee[8]))<<8
                  | ((uint32)(ieee[9]));

  if ((!expnt) && (!hiMant) && (!loMant))
    f = 0;
  else
  {
    if (expnt == 0x7FFF)
      f = HUGE_VAL;
    else
    {
      expnt -= 16383;
      f  =    ldexp(U2F(hiMant), expnt-=31);
      f  +=  ldexp(U2F(loMant), expnt-=32);
    }
  }
  freq = Clamp::real(f, 1.0, 1000000.0);
}

void InputAIFF16::close()
{
  freq        = 0;
  numCh        = 0;
  dataOffset  = 0;
  dataSize    = 0;
/*
  if (splitBuffer) {
    Mem::free(splitBuffer);
    splitBuffer=0;
  }
*/
  StreamIn::close();
}

sint32 InputAIFF16::open(const char* fileName)
{
  sint32 res = StreamIn::open(fileName, false, 16384);
  if (res!=OK)
    return res;

  char chunkName[4];

  // FORM chunk
  uint32  totalSize;
  if ((read8(chunkName, 4)!=4) || (strncmp(chunkName, "FORM", 4)!=0) ||
      (_READBIG32(&totalSize,1)!=1) ||
      (read8(chunkName, 4)!=4) || (strncmp(chunkName, "AIFF", 4)!=0)) {
    X_WARN("InputAIFF16::open() - couldn't read FORM header");
    StreamIn::close();
    return IOS::ERR_FILE_READ;
  }

  // COMM chunk
  uint32  chunkSize;
  uint32  samples;
  uint16  chan;
  uint16  bitsPerSample;
  uint8    freqIEEEExt[10];

  if ((read8(chunkName, 4)!=4) || (strncmp(chunkName, "COMM", 4)!=0) ||
      (_READBIG32(&chunkSize, 1)!=1) || (chunkSize!=COMMSIZE) ||
      (_READBIG16(&chan, 1)!=1) || (_READBIG32(&samples, 1)!=1) ||
      (_READBIG16(&bitsPerSample, 1)!=1) || (read8(freqIEEEExt, 10)!=10)) {
    X_WARN("InputAIFF16::open() - couldn't read COMM chunk");
    StreamIn::close();
    return ERR_FILE_OPEN;
  }

  if (bitsPerSample!=16) {
    printf("%hu bit AIFF not supported\n", bitsPerSample);
    X_WARN("InputAIFF16::open() - only 16 bit AIFF supported");
    StreamIn::close();
    return ERR_FILE_OPEN;
  }

  // SSND chunk
  uint32 offset;
  uint32 blockSize;

  if ((read8(chunkName, 4)!=4) || (strncmp(chunkName, "SSND", 4)!=0) ||
      (_READBIG32(&chunkSize, 1)!=1) || (_READBIG32(&offset, 1)!=1) ||
      (_READBIG32(&blockSize, 1)!=1)) {
    X_WARN("InputAIFF16::open() - couldn't read SSND chunk");
    StreamIn::close();
    return ERR_FILE_OPEN;
  }

  if (blockSize) {
    X_WARN("InputAIFF16::open() - Non zero SSND blocksize unsupported");
    StreamIn::close();
    return ERR_FILE_OPEN;
  }

  if (offset)
    StreamIn::seek(offset, IOS::SEEKCURR);
/*
  if (!(splitBuffer = Mem::alloc(256*numCh*sizeof(sint16), false, Mem::ALIGN_CACHE))) {
    X_ERROR("InputAIFF16::open() - unable to allocate split buffer");
    StreamIn::close();
    return ERR_NO_FREE_STORE;
  }
*/

  dataOffset  = StreamIn::tell();
  dataSize    = samples;
  numCh        = chan;
  decodeIEEEExt(freqIEEEExt);


  // we have now read the gubbins and are ready to rock and roll.
  return OK;
}

sint32 InputAIFF16::readCombine(void* buf, size_t len)
{
  if (!buf)
    return ERR_PTR_ZERO;
  if (len <1)
    return ERR_VALUE_MIN;
  return _READBIG16(buf, len*numCh);
}

sint32 InputAIFF16::readSplit(void* buf[], size_t len)
{
  return ERR_FILE;
}

