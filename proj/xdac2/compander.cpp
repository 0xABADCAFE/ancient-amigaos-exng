//****************************************************************************//
//**                                                                        **//
//** File:         proj/xdac2/compander.cpp                                 **//
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

#include "compander.hpp"

// #include <new>
// using std::nothrow

#include <new.h>

extern "C" {
  #include <math.h>
}

void Compander::dumpDecode(sint32* p)
{
  for (int i=0; i<256; i+=2) {
    printf("%5ld ", p[i]);
    if (((i+2)&15)==0)
      putchar('\n');
  }
  putchar('\n');
}


///////////////////////////////////////////////////////////////////////////////
//
//  LinearCompander
//
//  Linar 8 bit quantization
//
///////////////////////////////////////////////////////////////////////////////
/*
class LinearCompander : public Compander {
  private:
    static sint32*  decTab;
    static uint8*    encTab;
    static sint32    count;

    static bool      initTables();
    static void      destroyTables();

  public:
    void dumpDecodeCurve();
    LinearCompander();
    ~LinearCompander();
};
*/

///////////////////////////////////////////////////////////////////////////////
//
//  BinaryCompander
//
//  Uses a quantization where 4 bits are used to encode an exponent value and
//  three bits to define a 1/8 linear step between successive exponents. Sign
//  requires 1 bit.
//
//  The 16 exponent values used are
//
//    0,   8,   16,   24,   32,   48,    64,   128,
//  256, 512, 1024, 2048, 4096, 8192, 16384, 32768
//
//  The corresponding linear step sizes are
//
//    1,   1,    1,    1,    2,    2,     8,    16,
//   32,  64,  128,  256,  512, 1024,  2048,  4096
//
//  This means the values 0 to 32 are stored with no loss. Subsequently
//  larger values are quantized more and more severely.
//
///////////////////////////////////////////////////////////////////////////////

class BinaryCompander : public Compander {
  private:
    static sint32*  decTab;
    static uint8*    encTab;
    static sint32    count;

    static bool      initTables();
    static void      destroyTables();

  public:
    void dumpDecodeCurve();
    BinaryCompander();
    ~BinaryCompander();
};


sint32* BinaryCompander::decTab = 0;
uint8* BinaryCompander::encTab = 0;
sint32 BinaryCompander::count = 0;

BinaryCompander::BinaryCompander()
{
  X_INFO("-- constructing BinaryCompander --");
  if (count==0) {
    if (initTables()) {
      count++;
    }
  } else {
    count++;
  }
}

BinaryCompander::~BinaryCompander()
{
  if (count>0) {
    if (--count == 0) {
      destroyTables();
    }
  }
  X_INFO("--- destroying BinaryCompander ---");
}

bool BinaryCompander::initTables()
{
  uint8* tDat = (uint8*)Mem::alloc((256*sizeof(sint32))+65536, false);

  if (!tDat) {
    X_ERROR("BinaryCompander::initTables() - unable to allocate table space");
    return false;
  }

  decTab = (sint32*)tDat;
  encTab = tDat+(256*sizeof(sint32));

  sint32 exp[16] = {
    0, 8, 16, 24, 32, 48, 64, 128, 256, 512, 1024, 2048, 4096, 8192, 16384, 32768
  };
  sint32 man[16] = {
    1, 1, 1, 1, 2, 2, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096
  };
  sint32* p = decTab;
  for (int i=0; i<256; i++) {
    sint32 v = (((i>>1)&7) * man[(i&0xF0)>>4]) + exp[(i&0xF0)>>4];
    *p++ = i&1 ? -v : v;
  }

  // build the encoding table
/*
  sint32 prev=0;
  sint32 currIdx=2;

  for (int i=1; i<65536; i++) {

  }
*/
  X_INFO("BinaryCompander::initTables() - created tables");
  return true;
}

void BinaryCompander::destroyTables()
{
  if (decTab) {
    Mem::free(decTab);
    decTab = 0;
    encTab = 0;
    X_INFO("BinaryCompander::destroyTables() - destroyed tables");
  }
}

void BinaryCompander::dumpDecodeCurve()
{
  if (!decTab) {
    X_ERROR("BinaryCompander::dumpDecCurve() - no table");
    return;
  }
  puts("Binary companding curve (positive half only)");
  dumpDecode(decTab);
}

///////////////////////////////////////////////////////////////////////////////
//
//  FibCompander
//
//  Uses a quantization based on Fibonnacci sequence, which is determined by the
//  function f(n) = (Phi^n)/sqrt(5) for any value of n. The range of n is
//  chosen so that f(n) = 0...65535
//
//  This method makes better use of the available bit depth than simply using
//  the Fibonnacci sequence itself, but tends to over favour the low order
//  values.
//
///////////////////////////////////////////////////////////////////////////////

class FibCompander : public Compander {
  private:
    static sint32*  decTab;
    static uint8*    encTab;
    static sint32    count;

    static bool      initTables();
    static void      destroyTables();

  public:
    void dumpDecodeCurve();
    FibCompander();
    ~FibCompander();
};

sint32* FibCompander::decTab = 0;
uint8* FibCompander::encTab = 0;
sint32 FibCompander::count = 0;

FibCompander::FibCompander()
{
  X_INFO("-- constructing FibCompander --");
  if (count==0) {
    if (initTables()) {
      count++;
    }
  } else {
    count++;
  }
}

FibCompander::~FibCompander()
{
  if (count>0) {
    if (--count == 0) {
      destroyTables();
    }
  }
  X_INFO("--- destroying FibCompander ---");
}

bool FibCompander::initTables()
{
  uint8* tDat = (uint8*)Mem::alloc((256*sizeof(sint32))+65536, false);

  if (!tDat) {
    X_ERROR("FibCompander::initTables() - unable to allocate table space");
    return false;
  }

  decTab = (sint32*)tDat;
  encTab = tDat+(256*sizeof(sint32));


/*
  Phi = [sqrt(5)+1]/2

  f(n) = (Phi^n) / sqrt(5) - general equation for the nth fibbonacci number

  We need the (non-integer) value of n so that f = 65535

  65535 = (Phi^N) / sqrt(5)

  65535.sqrt(5) = Phi^N

  ln [65535.sqrt(5)] = N.ln(Phi)

  N = ln[65535.sqrt(5)] / ln(Phi)

  Construct a table for f(n) with 128 intervals of n for the range 0-N, interleaved with their
  negative counterparts.

*/
  float64 ir5      = 1.0/2.236067977;
  float64 Phi      = 1.618033988;
  float64 n        = 24.7189657; // value for n where f(n) = 65535
  float64 xScale  = n/127.0;
  sint32*  p        = decTab;

  *p++ = 0;
  *p++ = 0;
  for (int i=1; i<128; i++) {
    float64 x = xScale*i;
    float64 f = 0.5+ir5*pow(Phi, x);
    *p++ = (sint32)(f);
    *p++ = (sint32)(-f);
  }
  X_INFO("FibCompander::initTables() - created tables");
  return true;
}

void FibCompander::destroyTables()
{
  if (decTab) {
    Mem::free(decTab);
    decTab = 0;
    encTab = 0;
    X_INFO("FibCompander::destroyTables() - destroyed tables");
  }
}

void FibCompander::dumpDecodeCurve()
{
  if (!decTab) {
    X_ERROR("FibCompander::dumpDecCurve() - no table");
    return;
  }
  puts("Linear Fibonacci companding curve (positive half only)");
  dumpDecode(decTab);
}

///////////////////////////////////////////////////////////////////////////////
//
//  RootFibCompander
//
//  Uses a quantization based on Fibonnacci sequence, which is determined by the
//  function f(n) = (Phi^n)/sqrt(5) for any value of n.
//
//  The basic FibCompander underutilises the range of available values by
//  over favouring the low order ones.
//
//  The f(n) curve is therefore replaced with f(g(n)). g(n) is a function that
//  transforms a linear range of n into a non linear range that varies as
//  sqrt(n). This caues the interval steps to be larger for low values of n
//  and gradually reduce as n increases.
//
//  This produces a superior range of values than basic linear interlpolation
//
///////////////////////////////////////////////////////////////////////////////

class RootFibCompander : public Compander {
  private:
    static sint32*  decTab;
    static uint8*    encTab;
    static sint32    count;

    static bool      initTables();
    static void      destroyTables();

  public:
    void dumpDecodeCurve();
    RootFibCompander();
    ~RootFibCompander();
};

sint32* RootFibCompander::decTab = 0;
uint8* RootFibCompander::encTab = 0;
sint32 RootFibCompander::count = 0;

RootFibCompander::RootFibCompander()
{
  X_INFO("-- constructing RootFibCompander --");
  if (count==0) {
    if (initTables()) {
      count++;
    }
  } else {
    count++;
  }
}

RootFibCompander::~RootFibCompander()
{
  if (count>0) {
    if (--count == 0) {
      destroyTables();
    }
  }
  X_INFO("--- destroying RootFibCompander ---");
}

bool RootFibCompander::initTables()
{
  uint8* tDat = (uint8*)Mem::alloc((256*sizeof(sint32))+65536, false);

  if (!tDat) {
    X_ERROR("RootFibCompander::initTables() - unable to allocate table space");
    return false;
  }

  decTab = (sint32*)tDat;
  encTab = tDat+(256*sizeof(sint32));

/*
  Phi = [sqrt(5)+1]/2

  f(n) = (Phi^n) / sqrt(5) - general equation for the nth fibbonacci number

  We need the (non-integer) value of n so that f = 65535

  65535 = (Phi^N) / sqrt(5)

  65535.sqrt(5) = Phi^N

  ln [65535.sqrt(5)] = N.ln(Phi)

  N = ln[65535.sqrt(5)] / ln(Phi)

  Construct a curve based on f(n) with a *non linear* N that better spreads the range
  of values between 0-65535.

  The curve chosen will be

  f(g(n))

  where g(n) = N.sqrt(n)

  for n=0 to n=1.0

  Construct a table with 128 intervals of n for this range, interleaved with their
  negative counterparts.

*/
  float64 ir5      = 1.0/2.236067977;
  float64 Phi      = 1.618033988;
  float64 n        = 24.7189657; // value for n where f(n) = 65535
  float64 xScale  = 1.0/127.0;
  sint32*  p        = decTab;

  *p++ = 0;
  *p++ = 0;
  for (int i=1; i<128; i++) {
    float64 x = xScale*i;
    float64 f = 0.5+ir5*pow(Phi, n*sqrt(x));
    *p++ = (sint32)(f);
    *p++ = (sint32)(-f);
  }
  X_INFO("RootFibCompander::initTables() - created tables");
  return true;
}

void RootFibCompander::destroyTables()
{
  if (decTab) {
    Mem::free(decTab);
    decTab = 0;
    encTab = 0;
    X_INFO("RootFibCompander::destroyTables() - destroyed tables");
  }
}

void RootFibCompander::dumpDecodeCurve()
{
  if (!decTab) {
    X_ERROR("RootFibCompander::dumpDecCurve() - no table");
    return;
  }
  puts("Root-Fibonacci companding curve (positive half only)");
  dumpDecode(decTab);
}

///////////////////////////////////////////////////////////////////////////////

Compander* Compander::get(int t)
{
  switch (t) {
    case 1:
      return new (nothrow) BinaryCompander;
      break;
    case 2:
      return new (nothrow) FibCompander;
      break;
    default:
      return new (nothrow) RootFibCompander;
      break;
  }
}