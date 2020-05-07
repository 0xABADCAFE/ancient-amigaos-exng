//****************************************************************************//
//**                                                                        **//
//** File:         prj/gfxTest/drawtest.cpp                                 **//
//** Description:  Rasterizer test application                              **//
//** Comment(s):                                                            **//
//** Created:      2003-04-30                                               **//
//** Updated:      2003-09-22                                               **//
//** Author(s):    Karl Churchill                                           **//
//** Note(s):                                                               **//
//** Copyright:    (C)1996-2003, eXtropia Studios                           **//
//**               Serkan YAZICI, Karl Churchill                            **//
//**               All Rights Reserved.                                     **//
//**                                                                        **//
//****************************************************************************//

#include <xbase.hpp>
#include <new.h>

////////////////////////////////////////////////////////////////////////////////
//
//  Application
//
//  Main application
//
////////////////////////////////////////////////////////////////////////////////

class Application : public AppBase {
  private:
  protected:
    sint32  runApplication();

  public:
    Application();
    ~Application();
};

////////////////////////////////////////////////////////////////////////////////

char version[] = "$VER: test 0.1 K. Churchill (26.1.2004)\n";

////////////////////////////////////////////////////////////////////////////////

sint32 AppBase::init()
{
  // Do any library initialisation prior to application creation
  return OK;
}

////////////////////////////////////////////////////////////////////////////////

void AppBase::done()
{
}

////////////////////////////////////////////////////////////////////////////////

AppBase* AppBase::createApplicationInstance()
{
  // Create our application object
  return new(nothrow) Application;
}

////////////////////////////////////////////////////////////////////////////////

void AppBase::destroyApplicationInstance(AppBase* app)
{
  // Destroy our application object
  delete app;
}

////////////////////////////////////////////////////////////////////////////////

Application::Application()
{
}

////////////////////////////////////////////////////////////////////////////////

Application::~Application()
{
}

////////////////////////////////////////////////////////////////////////////////

sint32 Application::runApplication()
{
  EXNGLinkedLib::dump();

  void* p = Mem::alloc(1024, false);
  if (p) {
    printf("Allocated : 0x%08X\n", ((unsigned)p));
    Mem::free(p);
  }
  return 0;
}

