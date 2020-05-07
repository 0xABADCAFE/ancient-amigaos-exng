//****************************************************************************//
//**                                                                        **//
//** File:         proj/jasmine/jasmineobject.hpp                           **//
//** Description:                                                           **//
//** Comment(s):   Internal developer version only                          **//
//** Library:                                                               **//
//** Created:      2003-02-10                                               **//
//** Updated:      2003-02-10                                               **//
//** Author(s):    Karl Churchill                                           **//
//** Note(s):                                                               **//
//** Copyright:    (C)1996-2003, eXtropia Studios                           **//
//**               Serkan YAZICI, Karl Churchill                            **//
//**               All Rights Reserved.                                     **//
//**                                                                        **//
//****************************************************************************//

#ifndef _JASMINE_GENCODE_HPP
#define _JASMINE_GENCODE_HPP

#include <xbase.hpp>
#include "jasmineobject.hpp"

class JasmineFactory {
  public:
    static JasmineObject*  create(char* n, sint16 v, sint16 r, size_t F, size_t I, size_t S,  size_t MS, size_t RS, \
    size_t D64, size_t D32, size_t D16, size_t D8, size_t C64, size_t C32, size_t C16, size_t C8);
};

struct FuncAccess {
  bool    exported      : 1;  // function is externally visible
  bool    constant      : 1;  // function does not modify data in the object
  bool    synchronized  : 1;  // function has threadsafe access
  bool    entryPoint    : 1;  // function is entry point of a program
  sint32  reserved      : 28;
}

struct DataAccess {
  bool    exported      : 1;  // data is externally visible
  bool    constant      : 1;  // data is constant
  bool    synchronized  : 1;  // data has threadsafe access
  sint32  reserved      : 29;
};

struct JasmineGlobalFunction {
  const char*  object;      // the jasmine code object to which this function belongs
  const char*  name;        // the name of the function
  const char*  signature;  // the signature of the function
  FuncAccess  access;
  size_t      size;
  uint32      code[0];
};

struct JasmineGlobalData8 {
  const char*  object;      // the jasmine code object to which this data belongs
  const char*  name;        // the name of this data
  DataAccess  access;
  size_t      size;
  uint8        data[0];
}

struct JasmineGlobalData16 {
  const char*  object;      // the jasmine code object to which this data belongs
  const char*  name;        // the name of this data
  DataAccess  access;
  size_t      size;
  uint16      data[0];
}

struct JasmineGlobalData32 {
  const char*  object;      // the jasmine code object to which this data belongs
  const char*  name;        // the name of this data
  DataAccess  access;
  size_t      size;
  uint32      data[0];
}

struct JasmineGlobalData64 {
  const char*  object;      // the jasmine code object to which this data belongs
  const char*  name;        // the name of this data
  DataAccess  access;
  size_t      size;
  uint64      data[0];
}


#endif