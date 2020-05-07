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


#ifndef _DELTA_HPP
#define _DELTA_HPP

#include <xbase.hpp>

class DeltaAnalyser {
  private:
    sint32* deltaPop;   // population table
    sint32  total;      // total delta values
    sint32  totUnique;  // totlal unique delta values
    sint32  mostFreq;
    sint32  peak;
    sint32  last;
    uint32  flags;

    enum {
      FOUND_TOT_UNIQUE  = 0x00000001,
      FOUND_PEAK        = 0x00000002,
      FOUND_MOST_FREQ    = 0x00000004
    };

  public:
    void    reset();
    sint32  analyse(sint16* data, size_t len, size_t step);
    sint32  getTotalDelta() { return total; }
    sint32  getTotalUniqueDelta();
    sint32  getPeak();
    sint32  getMostFreq();

    void    dump();

    DeltaAnalyser();
    ~DeltaAnalyser();
};

#endif
