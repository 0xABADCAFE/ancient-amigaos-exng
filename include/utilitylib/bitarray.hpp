//****************************************************************************//
//**                                                                        **//
//** File:         include/utilitylib/bitarray.hpp                          **//
//** Description:  Bit array class                                          **//
//** Comment(s):                                                            **//
//** Library:      utilitylib                                               **//
//** Created:      2003-02-09                                               **//
//** Updated:      2003-02-09                                               **//
//** Author(s):    Karl Churchill                                           **//
//** Note(s):                                                               **//
//** Copyright:    (C)1996-2003, eXtropia Studios                           **//
//**               Serkan YAZICI, Karl Churchill                            **//
//**               All Rights Reserved.                                     **//
//**                                                                        **//
//****************************************************************************//

#ifndef _EXTROPIA_UTILITYLIB_BITARRAY_HPP
#define _EXTROPIA_UTILITYLIB_BITARRAY_HPP

#include <xbase.hpp>

////////////////////////////////////////////////////////////////////////////////
//
//  class BitArray
//
////////////////////////////////////////////////////////////////////////////////

template<size_t s> class BitArray {
  private:
    uint32 data[(s>>5) + (s&31 ? 1: 0)];

  public:
    bool  bit(ruint32 n)   const { return (data[(n>>5)] & (1<<(n&31))) != 0; }
    void  set(ruint32 n)   { data[(n>>5)] |= (1<<(n&31)); }
    void  clr(ruint32 n)   { data[(n>>5)] &= ~(1<<(n&31)); }
    void  set(ruint32 n, ruint32 l);
    void  clr(ruint32 n, ruint32 l);

  public:
    BitArray()   { Mem::zero(data, s*sizeof(uint32); }
    ~BitArray()  { }
};


template<size_t s> void BitArray::clr(ruint32 n, ruint32 l)
{ // block clear
  if ((n>>5) == ((n+l)>>5))  {  // start and end are in same 32-bit block. Generate mask for bits to clear
    ruint32 mask = ~((1<<(n&31))-1);
    mask &= (1<<((n+l)&31))-1;
    data[(n>>5)] &= ~mask;
  }
  else  {
    // start and end are in different 32-bit blocks
    // generate masks for start and end
    {
      ruint32 mask = ~((1<<(n&31))-1);
      data[(n>>5)] &= ~mask;
      mask = (1<<((n+l)&31))-1;
      data[((n+l)>>5)] &= ~mask;
    }
    // clear inbetween 32-bit blocks directly
    rsint32 i = ((n+l)>>5)-1;
    while (i > (n>>5)) {
      data[i--] = 0;
    }
  }
}

template <size_t s> void BitArray::set(ruint32 n, ruint32 l)
{  // block set
  if ((n>>5) == ((n+l)>>5))  {
    // start and end are in same 32-bit block. Generate mask for bits to set
    ruint32 mask = ~((1<<(n&31))-1);
    mask &= (1<<((n+l)&31))-1;
    data[(n>>5)] |= mask;
  }
  else {
    // start and end are in different 32-bit blocks
    // generate masks for start and end
    {
      ruint32 mask = ~((1<<(n&31))-1);
      data[(n>>5)] |= mask;
      mask = (1<<((n+l)&31))-1;
      data[((n+l)>>5)] |= mask;
    }
    // set inbetween 32-bit blocks directly
    rsint32 i = ((n+l)>>5)-1;
    while (i > (n>>5))
      data[i--] = 0xFFFFFFFF;
  }
}

#endif
