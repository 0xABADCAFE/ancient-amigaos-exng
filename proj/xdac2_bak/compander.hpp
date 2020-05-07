//****************************************************************************//
//**                                                                        **//
//** File:         proj/sdac2/compander.hpp                                 **//
//** Description:  Gfx speed test application                               **//
//** Comment(s):   This software tests direct surface access timing and     **//
//**               pixel conversion.                                        **//
//** Created:      2004-03-18                                               **//
//** Updated:      2004-03-18                                               **//
//** Author(s):    Karl Churchill                                           **//
//** Note(s):      It's not my fault. Patrik made me do it.                 **//
//**               Application is not system idependent as it relies on     **//
//**               asm                                                      **//
//** Copyright:    (C)1996-2004, eXtropia Studios                           **//
//**               Serkan YAZICI, Karl Churchill                            **//
//**                                                                        **//
//**               All Rights Reserved.                                     **//
//**                                                                        **//
//****************************************************************************//


#include <xbase.hpp>

////////////////////////////////////////////////////////////////////////////////

class Compander {
  protected:
    Compander() {}
  public:
    virtual void dumpCurve() {}
    virtual ~Compander() {}
};

class CompBasic : public Compander {
  private:
    static sint32    cnt;
    static sint32*  decode;
    static uint8*    encode;
    static bool      createTables();
  public:
    void dumpCurve();
    CompBasic();
    ~CompBasic();
};

////////////////////////////////////////////////////////////////////////////////
