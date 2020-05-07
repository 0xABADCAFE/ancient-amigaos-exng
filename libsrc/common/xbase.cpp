//****************************************************************************//
//**                                                                        **//
//** File:         libsrc/common/xbase.cpp                                  **//
//** Description:  Application startup                                      **//
//** Comment(s):                                                            **//
//** Library:      systemlib                                                **//
//** Created:      2003-02-08                                               **//
//** Updated:      2003-02-09                                               **//
//** Author(s):    Karl Churchill, Serkan YAZICI                            **//
//** Note(s):                                                               **//
//** Copyright:    (C)1996-2003, eXtropia Studios                           **//
//**               Serkan YAZICI, Karl Churchill                            **//
//**               All Rights Reserved.                                     **//
//**                                                                        **//
//****************************************************************************//

#include <xbase.hpp>
/*
extern "C" {
  #include <string.h>
}
*/
#include <cstring>
#include <new>
//using std::nothrow;

using namespace std;

////////////////////////////////////////////////////////////////////////////////
//
//  StartupLib
//
////////////////////////////////////////////////////////////////////////////////

class StartupLib {
  public:
    static sint32  init(int argc, char** argv);
    static sint32  runApplication();
    static void    done();

  private:
    static sint32  numStartArgs;
    static char**  startArgs;

  friend class AppBase;
};


////////////////////////////////////////////////////////////////////////////////

sint32  StartupLib::numStartArgs = 0;
char**  StartupLib::startArgs = 0;

sint32 StartupLib::init(int argc, char** argv)
{
  // allocate storage for argument pointers
  numStartArgs = argc;
  if (!(startArgs = new(nothrow) char* [argc])) {
    return ERR_NO_FREE_STORE;
  }
  for (sint32 i=0; i<argc; i++) {
    startArgs[i] = argv[i];
  }
  return SystemLib::init();
};

////////////////////////////////////////////////////////////////////////////////

sint32 StartupLib::runApplication()
{
  sint32 ret = AppBase::init();
  if (ret==OK) {
    AppBase *app = AppBase::createApplicationInstance();
    if (app) {
      ret = app->initApplication();
      if (ret==OK) {
        ret = app->runApplication();
      }
      else {
        X_ERROR("Application initialisation failed");
      }
      app->doneApplication();
      AppBase::destroyApplicationInstance(app);
    }
    else {
      X_ERROR("Unable to create application");
    }
  }
  else {
    X_ERROR("Library initialisation failed");
  }
  AppBase::done();
  return ret;
}

////////////////////////////////////////////////////////////////////////////////

void StartupLib::done()
{
  SystemLib::done();
  delete[] startArgs;
  startArgs = 0;
}


////////////////////////////////////////////////////////////////////////////////
//
//  EXNGLinkedLib
//
////////////////////////////////////////////////////////////////////////////////
/*
InitFn      EXNGLinkedLib::init[EXNG_NUM_LINK_LIBS] = { 0 };
DoneFn      EXNGLinkedLib::done[EXNG_NUM_LINK_LIBS] = { 0 };
const char* EXNGLinkedLib::name[EXNG_NUM_LINK_LIBS] = { 0 };

sint32 EXNGLinkedLib::num = 0;

sint32 EXNGLinkedLib::addResource(InitFn i, DoneFn f, const char* c)
{
  if (num<EXNG_NUM_LINK_LIBS) {
    init[num] = i;
    done[num] = f;
    name[num] = c;
    num++;
    return 0;
  }
  return ERR_RSC;
}

void EXNGLinkedLib::dump()
{
  for (sint32 i=0; i<num; i++) {
    const char* n = name[i] ? name[i] : "Unnamed";
    printf("%3ld : [%16s] : 0x%08X : 0x%08X\n", i, n, (unsigned)(init[i]), (unsigned)(done[i]));
  }
}
*/
////////////////////////////////////////////////////////////////////////////////
//
//  AppBase
//
////////////////////////////////////////////////////////////////////////////////

sint32 AppBase::numArgs()
{
  return StartupLib::numStartArgs;
}

////////////////////////////////////////////////////////////////////////////////

const char* AppBase::getArg(sint32 n)
{
  if (n<0 || n>=StartupLib::numStartArgs) {
    return 0;
  }
  return StartupLib::startArgs[n];
}

////////////////////////////////////////////////////////////////////////////////

const char* AppBase::getString(const char* paramName, bool matchCase)
{
  if (StartupLib::numStartArgs<2) {
    return 0;
  }
  if (matchCase) {
    for (int i = 0; i<StartupLib::numStartArgs; i++) {
      if (strcmp(StartupLib::startArgs[i], paramName) == 0) {
        if (++i<StartupLib::numStartArgs) {
          return StartupLib::startArgs[i];
        }
      }
    }
  }
  else  {
    for (int i = 0; i<StartupLib::numStartArgs; i++) {
      if (strcasecmp(StartupLib::startArgs[i], paramName) == 0) {
        if (++i<StartupLib::numStartArgs) {
          return StartupLib::startArgs[i];
        }
      }
    }
  }
  return 0;
}

////////////////////////////////////////////////////////////////////////////////

sint32 AppBase::getInteger(const char* paramName, bool matchCase)
{
  const char* p = getString(paramName, matchCase);
  if (p) {
    return atol(p);
  }
  return 0;
}

////////////////////////////////////////////////////////////////////////////////

float64 AppBase::getFloat(const char* paramName, bool matchCase)
{
  const char* p = getString(paramName, matchCase);
  if (p) {
    return atof(p);
  }
  return 0.0;
}

////////////////////////////////////////////////////////////////////////////////

bool AppBase::getSwitch(const char* paramName, bool matchCase)
{
  if (StartupLib::numStartArgs<2) {
    return false;
  }
  if (matchCase) {
    for (int i = 0; i<StartupLib::numStartArgs; i++) {
      if (strcmp(StartupLib::startArgs[i], paramName) == 0) {
        return true;
      }
    }
  }
  else {
    for (int i = 0; i<StartupLib::numStartArgs; i++) {
      if (strcasecmp(StartupLib::startArgs[i], paramName) == 0) {
        return true;
      }
    }
  }
  return false;
}

////////////////////////////////////////////////////////////////////////////////
//
//  Main Program
//
////////////////////////////////////////////////////////////////////////////////


int main(int argc, char** argv)
{
  sint32 retVal = StartupLib::init(argc, argv);
  if (retVal==OK)  {
    retVal = StartupLib::runApplication();
  }
  else {
    X_ERROR("Unable to initialise base library");
  }
  StartupLib::done();
  return retVal;
}

