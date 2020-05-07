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

#include "aiff.hpp"

//#include <new>
//using std::nothrow;

#include <new.h>

#define DATASIZE 8192

class App : public AppBase {

  private:
    const char*  sourceName;
    AIFF*        aiff;

  protected:
    sint32 initApplication();
    sint32 runApplication();

  public:
    App();
    ~App();
};

//////////////////////////////////////////////////////////////////////////////////

sint32 AppBase::init()
{
  return OK;
}

void AppBase::done()
{

}

AppBase* AppBase::createApplicationInstance()
{
  return new(nothrow) App;
}

void AppBase::destroyApplicationInstance(AppBase* app)
{
  delete app;
}

//////////////////////////////////////////////////////////////////////////////////

App::App()
{
  X_INFO("-- constructing App --");
  sourceName  = getString("file", false);
  aiff        = new(nothrow) AIFF;
}

App::~App()
{
  delete aiff;
  X_INFO("--- destroying App ---");
}

//////////////////////////////////////////////////////////////////////////////////

sint32 App::initApplication()
{
  if (!sourceName) {
    printf("No source filename given\n");
    return IOS::ERR_FILE;
  }

  X_INFO("App::initApplication() OK");
  return OK;
}

sint32 App::runApplication()
{
  if (aiff->read(sourceName)!=OK) {
    printf("failed to read %s\n", sourceName);
    return IOS::ERR_FILE_READ;
  }
/*
  printf("Freq: %.2f\n", aiff->getFreq());
  printf("Norm: %.2f\n", aiff->getFactor());
  printf("Chan: %2ld\n", aiff->getChannels());
  printf("Bits: %2ld\n", aiff->getBits());
*/
  aiff->normalize();
  aiff->write(sourceName);
/*
  if (aiff->write(sourceName)!=OK) {
    printf("failed to write %s\n", sourceName);
    return IOS::ERR_FILE_WRITE;
  }
*/
  return 0;
}
//////////////////////////////////////////////////////////////////////////////////

