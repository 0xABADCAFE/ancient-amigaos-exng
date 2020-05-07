//****************************************************************************//
//**                                                                        **//
//** File:         proj/gfxTest/pixeltest.cpp                               **//
//** Description:  Gfx speed test application                               **//
//** Comment(s):   This software tests direct surface access timing and     **//
//**               pixel conversion.                                        **//
//** Created:      2004-03-18                                               **//
//** Updated:      2004-03-18                                               **//
//** Author(s):    Karl Churchill                                           **//
//** Note(s):      It's not my fault. Patrik made me do it.                 **//
//**               Application is not system idependent as it relies on     **//
//**               asm                                                      **//
//** Copyright:    (C)1996-2004, eXtropia Studios                           **//
//**               Serkan YAZICI, Karl Churchill                            **//
//**                                                                        **//
//**               All Rights Reserved.                                     **//
//**                                                                        **//
//****************************************************************************//

#include "compander.hpp"
#include <new.h>



////////////////////////////////////////////////////////////////////////////////

class App : public AppBase {
  private:
    Compander*  comp;

  protected:
    sint32  initApplication();
    sint32  runApplication();

  public:
    App();
    ~App();
};

////////////////////////////////////////////////////////////////////////////////

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

////////////////////////////////////////////////////////////////////////////////

App::App()
{
  comp = new(nothrow) CompBasic;
}

////////////////////////////////////////////////////////////////////////////////

App::~App()
{
  delete comp;
}


////////////////////////////////////////////////////////////////////////////////

sint32 App::initApplication()
{
  if (!comp)
    return ERR_NO_FREE_STORE;
  return OK;
}

sint32 App::runApplication()
{
  comp->dumpCurve();
  return 0;
}

////////////////////////////////////////////////////////////////////////////////


