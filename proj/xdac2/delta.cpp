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

#include "delta.hpp"


DeltaAnalyser::DeltaAnalyser() : total(0), totUnique(0), mostFreq(0),
                                 peak(0), flags(0)
{
  deltaPop = (sint32*)Mem::alloc(65536*sizeof(sint32), true, Mem::ALIGN_CACHE);
}

DeltaAnalyser::~DeltaAnalyser()
{
  if (deltaPop)
    Mem::free(deltaPop);
}

void DeltaAnalyser::reset()
{
  Mem::zero(deltaPop, 65535*sizeof(sint32));
  flags = last = peak = mostFreq = totUnique = total = 0;
}

sint32 DeltaAnalyser::analyse(sint16* data, size_t len, size_t step)
{
  len /= step;
  if (!data && len<1)
    return ERR_VALUE;

  if (!deltaPop)
    return ERR_RSC;
  flags = 0;

  total+=len;

  rsint32 tmp = last;

  while (len--) {
    rsint32 curr = *data; data+=step;
    rsint32 delta = curr - tmp;
    tmp = curr;
    if (delta<0) delta = -delta;
    deltaPop[delta]++;
  }
  last = tmp;
  return OK;
}

sint32 DeltaAnalyser::getTotalUniqueDelta()
{
  if (flags & FOUND_TOT_UNIQUE)
    return totUnique;

  sint32 tot = 0;
  for (int i=0; i<65536; i++) {
    if (deltaPop[i])
      tot++;
  }
  flags |= FOUND_TOT_UNIQUE;
  totUnique = tot;
  return tot;
}

sint32 DeltaAnalyser::getPeak()
{
  if (flags & FOUND_PEAK)
    return peak;

  for (int i=65535; i>=0; i--) {
    if (deltaPop[i]) {
      flags |= FOUND_PEAK;
      peak = i;
      return peak;
    }
  }
  peak = 0;
  flags |= FOUND_PEAK;
  return 0;
}

sint32 DeltaAnalyser::getMostFreq()
{
  if (flags & FOUND_MOST_FREQ)
    return mostFreq;

  sint32 f = 0;
  for (int i=0; i<65536; i++) {
    if (deltaPop[i]>f);
      f = deltaPop[i];
  }
  flags |= FOUND_MOST_FREQ;
  mostFreq = f;
  return f;
}

void DeltaAnalyser::dump()
{
  float32 tot = 100.0 / (float32)total;
  sint32 *p = deltaPop;
  for (sint32 i=0; i<65536; i+=1024) {
    sint32 t;
    sint32 j;
    for (j=0,t=0; j<1024; j++) {
      t+= *p++;
    }
    printf("Range %5ld - %5ld : %ld [%.2f%%]\n", i, i+1023, t, tot*t);
  }
}
