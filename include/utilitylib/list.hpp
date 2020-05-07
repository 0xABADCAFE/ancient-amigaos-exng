//****************************************************************************//
//**                                                                        **//
//** File:         include/utilitylib/list.hpp                              **//
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

#ifndef _EXTROPIA_UTILITYLIB_LIST_HPP
#define _EXTROPIA_UTILITYLIB_LIST_HPP

#include <xbase.hpp>

#include <utilitylib/listbase.hpp>

////////////////////////////////////////////////////////////////////////////////
//
//  RefList<class T*>
//
//  Maintains a doubly linked list of references to objects of a specified type.
//
////////////////////////////////////////////////////////////////////////////////

template<class T> class RefList : private _LLBase {
  public:
    T*      first()                            { return (T*)_LLBase::first(); }
    T*      last()                            { return (T*)_LLBase::last(); }
    T*      next()                            { return (T*)_LLBase::next(); }
    T*      prev()                            { return (T*)_LLBase::prev(); }
    T*      curr()                            { return (T*)_LLBase::curr(); }
    bool    insertLast(T* t)                  { return _LLBase::insLast(t); }
    bool    insertFirst(T* t)                  { return _LLBase::insFirst(t); }
    bool    insertCurr(T* t)                  { return _LLBase::insCurr(t);  }
    T*      removeFirst()                      { return (T*)_LLBase::remFirst(); }
    T*      removeLast()                      { return (T*)_LLBase::remLast(); }
    T*      removeCurr()                      { return (T*)_LLBase::remCurr(); }
    sint32  removeAllBeforeCurr()              { return _LLBase::remBefCurr(); }
    sint32  removeAllAfterCurr()              { return _LLBase::remAftCurr(); }
    sint32  removeAll()                        { return _LLBase::remAll(); }
    bool    removeFirst(T* t)                  { return _LLBase::remFirst(t); }
    bool    removeLast(T* t)                  { return _LLBase::remLast(t); }
    sint32  removeAllBeforeCurr(T* t)          { return _LLBase::remBefCurr(t); }
    sint32  removeAllAfterCurr(T* t)          { return _LLBase::remAftCurr(t); }
    sint32  removeAll(T* t)                    { return _LLBase::remAll(t); }
    bool    searchForward(T* t, bool s)        { return _LLBase::srchFwrd(t, s); }
    bool    searchBackward(T* t, bool e)      { return _LLBase::srchBkwd(t, e); }
    bool    replaceFirst(T* t, T* r)          { return _LLBase::repFirst(t, r); }
    bool    replaceLast(T* t, T* r)            { return _LLBase::repLast(t, r); }
    sint32  replaceAllBeforeCurr(T* t, T* r)  { return _LLBase::repBefCurr(t, r); }
    sint32  replaceAllAfterCurr(T* t, T* r)    { return _LLBase::repAftCurr(t, r); }
    sint32  replaceAll(T* t, T* r)            { return _LLBase::repAll(t, r); }
    bool    contains(T* t) const              { return _LLBase::contains(t); }
    sint32  length()                          { return _LLBase::numLinks(); }

  public:
    RefList() : _LLBase() {}
};

////////////////////////////////////////////////////////////////////////////////
//
//  RefQueue<class T*>
//
//  Maintains a queue of references to objects of a specified type.
//
////////////////////////////////////////////////////////////////////////////////

template<class T> class RefQueue : private _LLBase {
  public:
    bool  add(T* t)            { return _LLBase::insLast(t); }
    T*    get()  {
      T* t = _LLBase::first();
      if (t)
        remFirst();
      return t;
    }
    sint32  length()          { return _LLBase::length(t); }
    bool    contains(T* t)    { return _LLBase::contains(t); }

  public:
    RefQueue() : _LLBase() {}
};

#endif

