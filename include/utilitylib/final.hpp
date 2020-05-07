//****************************************************************************//
//**                                                                        **//
//** File:         include/utilitylib/final.hpp                             **//
//** Description:  Pseudoconstant types                                     **//
//** Comment(s):                                                            **//
//** Library:      utilitylib                                               **//
//** Created:      2003-03-04                                               **//
//** Updated:      2003-03-04                                               **//
//** Author(s):    Karl Churchill                                           **//
//** Note(s):                                                               **//
//** Copyright:    (C)1996-2003, eXtropia Studios                           **//
//**               Serkan YAZICI, Karl Churchill                            **//
//**               All Rights Reserved.                                     **//
//**                                                                        **//
//****************************************************************************//

#ifndef _EXTROPIA_UTILITYLIB_FINAL_HPP
#define _EXTROPIA_UTILITYLIB_FINAL_HPP

#include <xbase.hpp>

// Fixme : this lot is buggered :-)

////////////////////////////////////////////////////////////////////////////////
//
//  Final<T> : T, ideally should be an elemental type
//
////////////////////////////////////////////////////////////////////////////////
/*
template<class T> class Final {
  friend class FinalModifier<class T>;
  private:
    T value;

    // private assignment
    T operator=(T x)      { value = x; return value; }

  public:
    Final() : value(0)    { }
    Final(T v) : value(v)  { }

  public:  // Operators
    operator T()          { return value; }
};


////////////////////////////////////////////////////////////////////////////////
//
//  FinalModifier<T> : T, ideally should be an elemental type, allows
//                     modification of a Final<T> type.
//
////////////////////////////////////////////////////////////////////////////////

template<class T> class FinalModifier {
  protected:
    static void setFinal(Final<T>& x, T v) { x = v; }
};
*/


#endif
