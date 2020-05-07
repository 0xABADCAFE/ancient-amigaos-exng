//****************************************************************************//
//**                                                                        **//
//** File:         include/utilitylib/rangedint.hpp                         **//
//** Description:  Protected and range limited integer types                **//
//** Comment(s):                                                            **//
//** Library:      utilitylib                                               **//
//** Created:      2003-02-09                                               **//
//** Updated:      2003-02-09                                               **//
//** Author(s):    Serkan YAZICI                                            **//
//** Note(s):                                                               **//
//** Copyright:    (C)1996-2003, eXtropia Studios                           **//
//**               Serkan YAZICI, Karl Churchill                            **//
//**               All Rights Reserved.                                     **//
//**                                                                        **//
//****************************************************************************//

#ifndef _EXTROPIA_UTILITYLIB_RANGEDINT_HPP
#define _EXTROPIA_UTILITYLIB_RANGEDINT_HPP

#include <xbase.hpp>

////////////////////////////////////////////////////////////////////////////////
//
//  class xint32 : Poke protected 32-bit signed integer
//
////////////////////////////////////////////////////////////////////////////////

class Xint32 {
  private:
    sint32 val;
    sint32 old;
  public:  // Constructor
    Xint32():val(0),old(0){ }
    Xint32(int i)         { val=(i<<1)+1; old=0; }
  public:  // Operators
    void operator=(int i) { val=(i<<1)+1; }
    operator int()        { return (val-1)>>1; }
    int operator()()      { return (val-1)>>1; }
    int operator++()      { val+=2; return (val-1)>>1; }   //prefix
    int operator++(int)   { val+=2; return (val-3)>>1; }   //postfix
    int operator--()      { val-=2; return (val-1)>>1; }   //prefix
    int operator--(int)   { val-=2; return (val+1)>>1; }   //postfix
    int operator+=(int i) { val+=i<<1; return (val-1)>>1; }
    int operator-=(int i) { val-=i<<1; return (val-1)>>1; }
    int operator*=(int i) { val--; val*=i; val++; return (val-1)>>1; }
    int operator/=(int i) { val/=i; val+=!(val&1); return (val-1)>>1; }
  public:  // Expressions
    int operator==(int i) { return ((val-1)>>1)==i; }
    int operator!=(int i) { return ((val-1)>>1)!=i; }
    int operator>(int i)  { return ((val-1)>>1)>i; }
    int operator<(int i)  { return ((val-1)>>1)<i; }
    int operator>=(int i) { return ((val-1)>>1)>=i; }
    int operator<=(int i) { return ((val-1)>>1)<=i; }
  public:  // Utility Methods
    int    getActual()        { return val; }
    void  setActual(int i)  { val=i; }
    bool  hasChanged() {
      if(val!=old) {
        old=val;
        return true;
      }
      return false;
    }
};

////////////////////////////////////////////////////////////////////////////////
//
//  class Lint : Range limited integer
//
////////////////////////////////////////////////////////////////////////////////

template <class T,int min,int max> class Lint {
  private:
    T val;
  public:  // Construtor
    Lint() : val(min)     { }
    Lint(int i)           { (i>min)?((i<max)?(val=i):(val=max)):(val=min); }
    void operator=(int i) { (i>min)?((i<max)?(val=i):(val=max)):(val=min); }
  public:  // Operators
    operator T()          { return val; }
    T operator()()        { return val; }
    T operator++()        { return (val<max)?(++val):(val=max); }   //++prefix
    T operator++(int)     { return (val<max)?(val++):(val=max); }   //postfix++
    T operator--()        { return (val>min)?(--val):(val=min); }   //--prefix
    T operator--(int)     { return (val>min)?(val--):(val=min); }   //postfix--
    T operator+=(int i)   { return (val+i<max)?(val+=i):(val=max); }
    T operator-=(int i)   { return (val>min+i)?(val-=i):(val=min); }
    T operator*=(int i)   { return ((long)val*i<max)?(val*=i):(val=max); }
    T operator<<=(int i)  { return ((long)(val<<i)<max)?(val<<=i):(val=max); }
    T operator/=(int i)   { return ((long)val/i>min)?(val/=i):(val=min); }
    T operator>>=(int i)  { return ((long)(val>>i)>min)?(val>>=i):(val=min); }
};

//-- Ranged (Limited) Integer Types
#define LUINT8(min,max)   Lint<uint8,min,max>
#define LUINT16(min,max)  Lint<uint16,min,max>
#define LUINT32(min,max)  Lint<uint32,min,max>
#define LUINT64(min,max)  Lint<uint64,min,max>
#define LSINT8(min,max)   Lint<sint8,min,max>
#define LSINT16(min,max)  Lint<sint16,min,max>
#define LSINT32(min,max)  Lint<sint32,min,max>
#define LSINT64(min,max)  Lint<sint64,min,max>

#endif
