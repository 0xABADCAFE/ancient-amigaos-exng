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

#include "aiff.hpp"

#include <new.h>
#include <math.h>
#include <string.h>

// AIFF is always organised as big endian

#if (X_ENDIAN == XA_BIGENDIAN)
  #define _READBIG64(d,n) (inFile->read64((d),(n)))
  #define _READBIG32(d,n) (inFile->read32((d),(n)))
  #define _READBIG16(d,n) (inFile->read16((d),(n)))
  #define _WRITEBIG64(d,n) (outFile->write64((d),(n)))
  #define _WRITEBIG32(d,n) (outFile->write32((d),(n)))
  #define _WRITEBIG16(d,n) (outFile->write16((d),(n)))
  #define _BYTE0 0
  #define _BYTE1 1
  #define _BYTE2 2
  #define _BYTE3 3
#else
  #define _READBIG64(d,n) (inFile->read64Swap((d),(n)))
  #define _READBIG32(d,n) (inFile->read32Swap((d),(n)))
  #define _READBIG16(d,n) (inFile->read16Swap((d),(n)))
  #define _WRITEBIG64(d,n) (outFile->write64Swap((d),(n)))
  #define _WRITEBIG32(d,n) (outFile->write32Swap((d),(n)))
  #define _WRITEBIG16(d,n) (outFile->write16Swap((d),(n)))
  #define _BYTE0 3
  #define _BYTE1 2
  #define _BYTE2 1
  #define _BYTE3 0
#endif

////////////////////////////////////////////////////////////////////////////////
//
//  InputAIFF
//
//  InputPCMStream implementation, supports basic AIFF 16 only
//
////////////////////////////////////////////////////////////////////////////////


#define COMMSIZE 18
#define  SSNDSIZE 8

AIFF::AIFF() : data(0), freq(0), bps(0), numCh(0)
{
  inFile = new(nothrow) StreamIn;
  outFile = new(nothrow) StreamOut;
}

AIFF::~AIFF()
{
  delete outFile;
  delete inFile;
  if (data)
    Mem::free(data);
}

#define U2F(u) (((float64)((sint32)(u - 2147483647L - 1))) + 2147483648.0)

void AIFF::decodeIEEEExt()
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


sint32 AIFF::read(const char* fileName)
{
  if (!inFile)
    return ERR_RSC;
  sint32 res = inFile->open(fileName, false, 16384);
  if (res!=OK)
    return res;

  printf("\nAIFF::read() - opening file %s\n", fileName);


  uint32 offset = 0;
  uint32 chunkSkips = 0;
  char chunkName[8] = {0};

  // FORM chunk
  uint32  totalSize;
  if ((inFile->read8(chunkName, 4)!=4) || (strncmp(chunkName, "FORM", 4)!=0) ||
      (_READBIG32(&totalSize,1)!=1) ||
      (inFile->read8(chunkName, 4)!=4) || (strncmp(chunkName, "AIFF", 4)!=0)) {
    puts("AIFF::read() - couldn't read FORM header");
    inFile->close();
    return IOS::ERR_FILE_OPEN;
  }

  // COMM chunk
  uint32  chunkSize;
  uint32  samples;
  uint16  chan;
  uint16  bitsPerSample;

  // scan for COMM chunk due to ultra lame apple arsefez programmers.

  if (inFile->read8(chunkName, 4)!=4) {
    puts("AIFF::read() - couldn't read chunk header");
    inFile->close();
    return IOS::ERR_FILE_OPEN;
  }

  while(strncmp(chunkName, "COMM", 4)!=0 && ++chunkSkips<16) {
    printf("(found chunk '%s', skipping)\n", chunkName);
    if (_READBIG32(&offset,1)!=1) {
      puts("AIFF::read() - couldn't read chunk length");
      inFile->close();
      return IOS::ERR_FILE_OPEN;
    }
    inFile->seek(offset, IOS::SEEKCURR);
    if (inFile->read8(chunkName, 4)!=4)  {
      puts("AIFF::read() - couldn't read chunk header");
      inFile->close();
      return IOS::ERR_FILE_OPEN;
    }
  }

  if (strncmp(chunkName, "COMM", 4)!=0 ||
      _READBIG32(&chunkSize, 1)!=1 ||  chunkSize!=COMMSIZE ||
      _READBIG16(&chan, 1)!=1 ||
      _READBIG32(&samples, 1)!=1 ||
      _READBIG16(&bitsPerSample, 1)!=1 ||
      inFile->read8(ieee, 10)!=10) {
    puts("AIFF::read() - couldn't read COMM chunk");
    inFile->close();
    return IOS::ERR_FILE_OPEN;
  }

  // SSND chunk
  uint32 blockSize;

  // scan for SSND chunk due to ultra lame apple arsefez programmers.
  if (inFile->read8(chunkName, 4)!=4)  {
    puts("AIFF::read() - couldn't read chunk header");
    inFile->close();
    return IOS::ERR_FILE_OPEN;
  }
/*
  if (strncmp(chunkName, "SSND", 4)!=0) {
    do {
      chunkName[0] = inFile->getChar();
    } while (chunkName[0]!='S' && ++offset<2048);
    if (chunkName[0]=='S') {
      chunkName[1] = inFile->getChar();
      chunkName[2] = inFile->getChar();
      chunkName[3] = inFile->getChar();
      if (strncmp(chunkName, "SSND", 4)!=0) {
        puts("AIFF::read() - couldn't find SSND chunk");
        inFile->close();
        return IOS::ERR_FILE_OPEN;
      }
    }
  }
*/
  chunkSkips=0;
  while(strncmp(chunkName, "SSND", 4)!=0 && ++chunkSkips<16) {
    printf("(found chunk '%s', skipping)\n", chunkName);
    if (_READBIG32(&offset,1)!=1) {
      puts("AIFF::read() - couldn't read chunk length");
      inFile->close();
      return IOS::ERR_FILE_OPEN;
    }
    inFile->seek(offset, IOS::SEEKCURR);
    if (inFile->read8(chunkName, 4)!=4)  {
      puts("AIFF::read() - couldn't read chunk header");
      inFile->close();
      return IOS::ERR_FILE_OPEN;
    }
  }

  if (strncmp(chunkName, "SSND", 4)!=0 ||
      _READBIG32(&chunkSize, 1)!=1 ||
      _READBIG32(&offset, 1)!=1 ||
      _READBIG32(&blockSize, 1)!=1) {
    puts("AIFF::read() - couldn't read SSND chunk");
    inFile->close();
    return IOS::ERR_FILE_OPEN;
  }

  if (blockSize) {
    puts("AIFF::read() - Non zero SSND blocksize unsupported");
    inFile->close();
    return IOS::ERR_FILE_OPEN;
  }

  if (offset)
    inFile->seek(offset, IOS::SEEKCURR);

  dataOffset  = inFile->tell();
  numSamples  = samples;
  numCh        = chan;
  bps          = bitsPerSample;

  size_t rawSize = 4096 + samples*chan*sizeof(sint32);

  if (data)
    Mem::free(data);
  if (!(data = (sint32*)Mem::alloc(rawSize, false, Mem::ALIGN_CACHE))) {
    printf("AIFF::read() - failed to allocate %lu bytes\n", rawSize);
    inFile->close();
    return ERR_NO_FREE_STORE;
  }
  printf("AIFF::read() - allocated %lu bytes for 32-bit data\n", rawSize);

  decodeIEEEExt();

  size_t bytesPerSample = (bitsPerSample>>3) + (bitsPerSample&0x7 ? 1 : 0);

  switch (bytesPerSample) {
    case 1:
      res = read8();
      break;
    case 2:
      res = read16();
      break;
    case 3:
      res = read24();
      break;
    default:
      printf("AIFF::read() - unsupported sample size %hd\n", bps);
      res = IOS::ERR_FILE_READ;
      break;
  }
  inFile->close();
/*
  unsigned* p = (unsigned*)data;

  for(sint32 i=0; i<128; i++)
  {
    printf("0x%08X ", *p++);
    if (((i+1)&7)==0)
      putchar('\n');
  }
  putchar('\n');
*/
  return res;
}

sint32 AIFF::read8()
{
  char*  p = (char*)data;
  uint32  len = numSamples*numCh;
  sint32  peak = 0;
  printf("AIFF::read8() - ");
  fflush(stdout);
  timer.set();
  while (len--) {
    sint32 c=inFile->getChar();
    if (c!=EOF) {
      *((uint32*)p) = 0;
      p[_BYTE0] = (char)c;
      sint32 t = *((sint32*)p)++;
      t=(t<0) ? -t:t;
      if (peak<t)
        peak=t;
    }
    else {
      puts("unexpected EOF");
      return IOS::ERR_FILE_READ;
    }
  }
  factor = 2147483648.0 / (float64)peak;
  float64 ms = timer.elapsedFrac();
  printf("OK, load and conversion took %.2f ms\n", ms);
  return OK;
}

sint32 AIFF::read16()
{
  char*  p = (char*)data;
  uint32  len = numSamples*numCh;
  sint32  peak = 0;
  printf("AIFF::read16() - ");
  fflush(stdout);
  timer.set();
  while (len--) {
    sint32 c1=inFile->getChar();
    sint32 c2=inFile->getChar();
    if (c2!=EOF) {
      *((uint32*)p) = 0;
      p[_BYTE0] = (char)c1;
      p[_BYTE1] = (char)c2;
      sint32 t = *((sint32*)p)++;
      t=(t<0) ? -t:t;
      if (peak<t)
        peak=t;
    }
    else {
      puts("unexpected EOF");
      return IOS::ERR_FILE_READ;
    }
  }
  factor = 2147483648.0 / (float64)peak;
  float64 ms = timer.elapsedFrac();
  printf("OK, load and conversion took %.2f ms\n", ms);

  return OK;
}

sint32 AIFF::read24()
{
  char*    p = (char*)data;
  uint32  len = numSamples*numCh;
  sint32  peak = 0;
  printf("AIFF::read24() - ");
  fflush(stdout);
  timer.set();
  while (len--) {
    sint32 c1=inFile->getChar();
    sint32 c2=inFile->getChar();
    sint32 c3=inFile->getChar();
    if (c3!=EOF) {
      *((uint32*)p) = 0;
      p[_BYTE0] = (char)c1;
      p[_BYTE1] = (char)c2;
      p[_BYTE2] = (char)c3;
      sint32 t = *((sint32*)p)++;
      t=(t<0) ? -t:t;
      if (peak<t)
        peak=t;
    }
    else {
      puts("unexpected EOF");
      return IOS::ERR_FILE_READ;
    }
  }
  factor = 2147483648.0 / (float64)peak;
  float64 ms = timer.elapsedFrac();
  printf("OK, load and conversion took %.2f ms\n", ms);
  return OK;
}

#define AIFFHEADSIZE (8+18+8+12) // COMM head, COMM body, SSND head, SSND body
#define COMMSIZE 18
#define  SSNDSIZE 8

sint32 AIFF::write(const char* fileName)
{
  if (!data || !outFile || !fileName)
    return ERR_RSC;

  printf("AIFF::write() '%s' - ", fileName);
  fflush(stdout);
  sint32 res = outFile->open(fileName, false, false, 16384);
  if (res!=OK) {
    puts("failed to open output file");
    return res;
  }
  uint32 dummy[2]={0};
  uint32 size = numSamples*numCh*sizeof(sint16);
  uint32 chunkSize = AIFFHEADSIZE + size;

  // FORM
  if (outFile->writeBytes("FORM",4)!=4 ||
      _WRITEBIG32(&chunkSize,1)!=1 ||
      outFile->writeBytes("AIFF",4)!=4) {
    puts("failed to write FORM chunk");
    outFile->close();
    return IOS::ERR_FILE_WRITE;
  }

  // COMM
  chunkSize = COMMSIZE;
  uint16 bits = 16;
  if (outFile->writeBytes("COMM",4)!=4  ||
      _WRITEBIG32(&chunkSize,1)!=1  ||
      _WRITEBIG16(&numCh,1)!=1  ||
      _WRITEBIG32(&numSamples,1)!=1  ||
      _WRITEBIG16(&bits,1)!=1  ||
      outFile->writeBytes(ieee,10)!=10 )
  {
    puts("failed to write COMM chunk");
    outFile->close();
    return IOS::ERR_FILE_WRITE;
  }

  // SSND
  chunkSize = SSNDSIZE + size;

  if (outFile->writeBytes("SSND",4)!=4  ||
      _WRITEBIG32(&chunkSize,1)!=1 ||
      _WRITEBIG32(dummy,2)!=2 )
  {
    puts("failed to write COMM chunk");
    outFile->close();
    return IOS::ERR_FILE_WRITE;
  }

  timer.set();
  ruint32 n = numSamples*numCh;
  char* p = (char*)data;
  while(n--)
  {
    outFile->putChar(p[_BYTE0]);
    outFile->putChar(p[_BYTE1]);
    p+=4;
  }
  float64 ms = timer.elapsedFrac();
  outFile->close();
  printf("OK, took %.2f ms\n", ms);
  return OK;
}

void AIFF::normalize()
{
  printf("AIFF::normalize() - ");
  fflush(stdout);
  if (data) {
    if (factor>1.05) {
      timer.set();
      rfloat64 f = factor;
      rsint32* p = data;
      uint32 n = numSamples*numCh;
      while(n--) {
        *p++ = (sint32)(f * (float64)(*p));
      }
      float64 ms = timer.elapsedFrac();
      printf("[%.2f%%] OK, took %.2f ms\n", 100.0*factor, ms);
    }
    else {
      puts("skipped");
    }
  }
  else {
    puts("failed");
  }
}