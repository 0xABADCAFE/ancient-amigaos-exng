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

#ifndef _PCMSTREAM_AIFF_HPP
#define _PCMSTREAM_AIFF_HPP

#include "pcmstream.hpp"
#include <iolib/fileio.hpp>

class InputAIFF16 : public InputPCMStream, private StreamIn {
  private:
    float64 freq;
    sint32  numCh;
    size_t  dataOffset;
    size_t  dataSize;
    sint16*  splitBuffer;
    void    decodeIEEEExt(uint8* ieee);

  public:
    sint32 open(const char* fileName);
    void close();

    float64 getRecFreq()      { return freq; }
    sint32  getNumChannels()  { return numCh; }

    sint32  getBitDepth()      { return 16; }
    bool    isSigned()        { return true; }

    sint32  readCombine(void* buf, size_t len);
    sint32  readSplit(void* buf[], size_t len);

  public:
    InputAIFF16();
    ~InputAIFF16();
};


#endif
