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

#ifndef _COMPANDER_HPP
#define _COMPANDER_HPP

#include <xbase.hpp>

// Compander interface class

class Compander {
  protected:
    Compander() {}

    void dumpDecode(sint32* p);

  public:
    //virtual void setProperties(sint32 steps, sint32 max) = 0;
    virtual void dumpDecodeCurve() = 0;
    virtual  ~Compander() {}

    static Compander* get(int t);
};

#endif
