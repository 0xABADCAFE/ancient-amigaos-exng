//****************************************************************************//
//**                                                                        **//
//** File:         proj/jasmine/jasmineapp.hpp                              **//
//** Description:  Jasmine VM test application                              **//
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

#ifndef _JASMINE_TEST_APP_HPP
#define _JASMINE_TEST_APP_HPP

#include "jasmine.hpp"

class JasmineApp : public AppBase {
  private:
    XSFStreamIn*    file;
    Jasmine*        jInterpreter;
    JasmineObject*  jObject;

  protected:
    // AppBase methods
    sint32  initApplication();
    void    doneApplication();
    sint32  runApplication();

  public:
    JasmineApp();
    ~JasmineApp();
};

#endif