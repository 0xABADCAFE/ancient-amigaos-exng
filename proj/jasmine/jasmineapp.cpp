//****************************************************************************//
//**                                                                        **//
//** File:         proj/jasmine/jasmineapp.cpp                              **//
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

#include "jasmineapp.hpp"


sint32 AppBase::init()
{
  return OK;
}

////////////////////////////////////////////////////////////////////////////////

void AppBase::done()
{
}

////////////////////////////////////////////////////////////////////////////////

AppBase* AppBase::createApplicationInstance()
{
  return new JasmineApp;
}

////////////////////////////////////////////////////////////////////////////////

void AppBase::destroyApplicationInstance(AppBase* app)
{
  delete app;
}

////////////////////////////////////////////////////////////////////////////////

JasmineApp::JasmineApp() : file(0), jInterpreter(0), jObject(0)
{
  file          = new XSFStreamIn();
  jInterpreter  = new Jasmine;
  jObject        = new JasmineObject;
  puts("\n--- JasmineApp constructed ---\n");
}

////////////////////////////////////////////////////////////////////////////////

JasmineApp::~JasmineApp()
{
  delete jObject;
  delete jInterpreter;
  delete file;
  puts("\n---- JasmineApp destroyed ----\n");
}

////////////////////////////////////////////////////////////////////////////////

sint32 JasmineApp::runApplication()
{
  puts("\n----- JasmineApp running -----\n");
  jObject->debugDump();
  jInterpreter->execute(jObject);
  return 0;
}

////////////////////////////////////////////////////////////////////////////////

sint32 JasmineApp::initApplication()
{
  if (numArgs()<2)
  {
    puts("No object file specified : usage jasmine <filename>");
    return IOS::ERR_FILE;
  }
  if (!jInterpreter || !jObject || !file)
  {
    puts("Failed to instansiate components");
    return ERR_RSC;
  }
  if (file->open(getArg(1), JasmineObject::xsfFileSig, XSF::verXSF, XSF::revXSF)!=OK)
  {
    printf("Unable to open '%s'\n", getArg(1));
    return IOS::ERR_FILE_OPEN;
  }
  if (jObject->read(file)<0)
  {
    printf("Error occured when loading '%s'\n", getArg(1));
    return IOS::ERR_FILE_READ;
  }
  file->close();
  return OK;
}

////////////////////////////////////////////////////////////////////////////////

void JasmineApp::doneApplication()
{
}

////////////////////////////////////////////////////////////////////////////////

