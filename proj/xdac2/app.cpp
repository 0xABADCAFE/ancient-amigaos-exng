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

#include "delta.hpp"
#include "compander.hpp"
#include "pcm_aiff.hpp"

//#include <new>
//using std::nothrow;

#include <new.h>

#define DATASIZE 8192

class App : public AppBase {

  private:
    sint32            mode;
    const char*        sourceName;
    Compander*        comp;
    InputPCMStream*    inPCM;
    DeltaAnalyser*    delta;

    sint16 dummy[DATASIZE];

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
  mode        = getInteger("mode", false);
  //comp        = Compander::get(mode);
  sourceName  = getString("from", false);
  delta        = new(nothrow) DeltaAnalyser;
  inPCM        = new(nothrow) InputAIFF16;
}

App::~App()
{
  delete inPCM;
  delete delta;
  //delete comp;
  X_INFO("--- destroying App ---");
}

//////////////////////////////////////////////////////////////////////////////////

sint32 App::initApplication()
{
  if (!sourceName) {
    printf("No source filename given\n");
    return IOS::ERR_FILE;
  }

  if (/*!comp || */!inPCM || !delta) {
    return ERR_NO_FREE_STORE;
  }

  if (inPCM->open(sourceName)!=OK) {
    printf("Failed to open source file\n");
    return IOS::ERR_FILE_OPEN;
  }

  else {
    X_INFO("App::initApplication() OK");
  }
  return OK;
}

sint32 App::runApplication()
{
  printf("Freq: %.2lf\n", inPCM->getRecFreq());
  printf("Chan: %2ld\n", inPCM->getNumChannels());

  delta->reset();

  sint32 n = DATASIZE / inPCM->getNumChannels();

  sint32  i    = 0;
  sint32  len  = inPCM->readCombine(dummy, n);

  size_t  step = inPCM->getNumChannels();

  while (len>0) {
    delta->analyse(dummy, len, step);
    printf("Read : %5ld blocks last %5ld\r", ++i, len);
    fflush(stdout);
    len = inPCM->readCombine(dummy, n);
  }
  putchar('\n');

  printf("unique delta  = %ld\n", delta->getTotalUniqueDelta());
  printf("peak          = %ld\n", delta->getPeak());
  printf("most frequent = %ld\n", delta->getMostFreq());

  delta->dump();

  return 0;
}

//////////////////////////////////////////////////////////////////////////////////

