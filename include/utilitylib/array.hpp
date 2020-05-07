//****************************************************************************//
//**                                                                        **//
//** File:         include/utilitylib/array.hpp                             **//
//** Description:  Simple container types                                   **//
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

#ifndef _EXTROPIA_UTILITYLIB_ARRAY_HPP
#define _EXTROPIA_UTILITYLIB_ARRAY_HPP

#include <xbase.hpp>

inline void* operator new(size_t s, void* p) { return p; }

////////////////////////////////////////////////////////////////////////////////
//
//  class Array [template]
//
//  Objects are created in memory allocated via Mem::alloc() and so can be
//  tracked by the library.
//
//  Note : works around StormC v3 new[] bug that sometimes fails to initialise
//         arrays of polymorphic objects.
//
////////////////////////////////////////////////////////////////////////////////


template<class T> class Array {
  private:
    T*      objMem;
    size_t  numObj;

  public:
    T* create(size_t num, Mem::aligntype align=Mem::ALIGN_DEFAULT)
    {
      void* p = Mem::alloc(num*sizeof(T), false, align);
      if (p) {
        register T* o = objMem = (T*)p;
        numObj = num++;
        while (--num)
          new(o++) T;
        return objMem;
      }
      else {
        numObj=0;
      }
      return 0;
    }

    void destroy()
    {
      if (objMem)  {
        register T* o = objMem;
        rsize_t n = numObj+1;
        while(--n) {
          delete(o++);
        }
        Mem::free(objMem);
        objMem = 0;
      }
    }
    T& operator[](size_t i) { return objMem[i]; }
    T* getDirect()          { return objMem; }

    size_t  length()        const { return numObj; }

  public:
    Array() : objMem(0), numObj(0) {}
    Array(size_t num, Mem::aligntype align = Mem::ALIGN_DEFAULT) : objMem(0)
    {
      create(num, align);
    }
    ~Array() { free() }
};

#endif

