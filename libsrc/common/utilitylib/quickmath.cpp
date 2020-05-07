//****************************************************************************//
//**                                                                        **//
//** File:         libsrc/common/utilitylib/quickmath.cpp                   **//
//** Description:  Quick approximations for trancendal functions            **//
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

#include <utilitylib/quickmath.hpp>

float32* QMath::data    = 0;
float32* QMath::arcData  = 0;
float32* QMath::eFrac    = 0;
float32* QMath::eInt    = 0;

////////////////////////////////////////////////////////////////////////////////

sint32 QMath::init()
{
  if (data) {
    return ERR_RSC;
  }
  // Allocate space for all tables as a single block and such that each section
  // begins at a cache aligned address

  size_t dataSize = 3*(((DATASIZE+2)*sizeof(float32) + Mem::ALIGN_CACHE) &
                   ~(Mem::ALIGN_CACHE-1)) +
                   (E_RANGE*sizeof(float32));

  if(!(data = (float32*)Mem::alloc(dataSize, false, Mem::ALIGN_CACHE))) {
    X_ERROR("QMath::init() - insufficient memory for tables");
    return ERR_NO_FREE_STORE;
  }

  size_t offset = (((DATASIZE+2)*sizeof(float32) + Mem::ALIGN_CACHE) &
                   ~(Mem::ALIGN_CACHE-1))/sizeof(float32);

  arcData  = data + offset;
  eFrac    = arcData + offset;
  eInt    = eFrac + offset;

  // Generate data for sin/asin/exp
  sint32 i;
  for (i=0; i<DATASIZE; i++) {
    data[i]      = ::sin(i*PI64/(2*DATASIZE));
    arcData[i]  = ::asin(i/DATASIZE);
    eFrac[i]    = ::exp(-i/DATASIZE);
  }
  data[DATASIZE]    = 1.0;
  eFrac[DATASIZE]    = 1.0;
  arcData[DATASIZE]  = PI64/2;
  for (i=0; i < E_RANGE; i++)
    eInt[i]      = ::exp(i+E_MIN_INT);
  return OK;
}

////////////////////////////////////////////////////////////////////////////////

void QMath::done()
{
  if (data) {
    Mem::free(data);
  }
  data    = 0;
  arcData  = 0;
  eFrac    = 0;
  eInt    = 0;
}

////////////////////////////////////////////////////////////////////////////////

float32  QMath::angleMod(float32 x)
{
  if (x<0) {
    return (2*PI32)+fmod(x, 2*PI32);
  }
  else if (x<2*PI32) {
    return x;
  }
  else {
    return fmod(x, 2*PI32);
  }
}

////////////////////////////////////////////////////////////////////////////////

float32 QMath::sin(float32 x)
{
  x *= (2*DATASIZE/PI32);
  ruint32 i = (uint32)x;
  x -= i;
  return (1.0F-x)*sini(i) + x*sini(i+1);
}

////////////////////////////////////////////////////////////////////////////////

float32 QMath::cos(float32 x)
{
  x *= (2*DATASIZE/PI32);
  ruint32 i = (uint32)x;
  x -= i;
  return (1.0F-x)*cosi(i) + x*cosi(i+1);
}

////////////////////////////////////////////////////////////////////////////////

float32 QMath::tan(float32 x)
{
  x *= (2*DATASIZE/PI32);
  ruint32 i = (uint32)x;
  x -= i;

  // Access is optimized to get each sin / cosine pair read together, which
  // increases chance of cache hit. i2 holds cosine index

  if (i<DATASIZE) {
    ruint32 i2 = DATASIZE-i;
    return ( (1.0F-x)*data[i] + x*data[i+1] ) / ( (1.0F-x)*data[i2] + x*data[i2+1] );
  }
  else if (i<(2*DATASIZE)) {
    ruint32 i2 = i-DATASIZE; i = (2*DATASIZE)-i;
    return ( -(1.0F-x)*data[i] - x*data[i+1] ) / ( (1.0F-x)*data[i2] + x*data[i2+1] );
  }
  else if (i<(3*DATASIZE)) {
    ruint32 i2 = (3*DATASIZE)-i; i -= (2*DATASIZE);
    return ( (1.0F-x)*data[i] + x*data[i+1]) / ( (1.0F-x)*data[i2] + x*data[i2+1] );
  }
  else if (i<(4*DATASIZE)) {
    ruint32 i2 = i-(3*DATASIZE); i = (4*DATASIZE)-i;
    return ( -(1.0F-x)*data[i] - x*data[i+1]) / ( (1.0F-x)*data[i2] + x*data[i2+1] );
  }
  else {
    ruint32 i2 = (5*DATASIZE)-i; i -= (4*DATASIZE);
    return ( (1.0F-x)*data[i] + x*data[i+1]) / ( (1.0F-x)*data[i2] + x*data[i2+1] );
  }
}

////////////////////////////////////////////////////////////////////////////////

float32 QMath::asin(float32 x)
{
  x *= DATASIZE;
  if (x<0.0f) {
    x = -x;
    ruint32 i = (uint32)(x - 0.5F);
    x -= i;
    return -(1.0F-x)*arcData[i] - x*arcData[i+1];
  }
  else {
    ruint32 i = (uint32)(x - 0.5F);
    x  -= i;
    return (1.0F-x)*arcData[i] + x*arcData[i+1];
  }
}

////////////////////////////////////////////////////////////////////////////////

float32 QMath::acos(float32 x)
{
  x *= DATASIZE;
  if (x<0.0f) {
    x = -x;
    ruint32 i = (uint32)(x - 0.5F);
    x -= i;
    return (PI32/2) + (1.0F-x)*arcData[i] + x*arcData[i+1];
  }
  else {
    ruint32 i = (uint32)(x - 0.5F);
    x  -= i;
    return (PI32/2) - (1.0F-x)*arcData[i] - x*arcData[i+1];
  }
}

////////////////////////////////////////////////////////////////////////////////

float32 QMath::exp(float32 x)
{
  rsint32 i = (uint32)(x+0.5F);
  x -= (i-1);
  x *= DATASIZE;
  ruint32 i2 = (uint32)(x-0.5F);  x -= i2;
  return eInt[i+(-E_MIN_INT)]*( (1.0F-x)*eFrac[i2] + x*eFrac[i2+1]);
}

////////////////////////////////////////////////////////////////////////////////

