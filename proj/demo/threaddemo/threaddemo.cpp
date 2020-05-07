//****************************************************************************//
//**                                                                        **//
//** File:         proj/ThreadDemo/threaddemo.cpp                           **//
//** Description:  Example use of Threadable service class                  **//
//** Comment(s):                                                            **//
//** Created:      2003-02-08                                               **//
//** Updated:      2004-02-12                                               **//
//** Author(s):    Karl Churchill                                           **//
//** Note(s):                                                               **//
//** Copyright:    (C)1996-2004, eXtropia Studios                           **//
//**               Serkan YAZICI, Karl Churchill                            **//
//**               All Rights Reserved.                                     **//
//**                                                                        **//
//****************************************************************************//

#include <xbase.hpp>
#include <systemlib/cpu.hpp>
#include <systemlib/thread.hpp>
#include <iolib/console.hpp>

#include <new.h>

////////////////////////////////////////////////////////////////////////////////
//
//  ThreadDemoApp
//
//  Any object can inherit the Threaded class to have its own internal thread
//  of execution that is controllable via the public portion of the Threaded
//  interface.
//
//  This simple demonstation defines a Threaded class that uses the internal
//  thread to increment a counter. The main thread requests input from the user
//  to control the internal thread. A seperate console window is used for the
//  internal threads output to simplify the implementation.
//
//  If you wanted to use the default output, you would have to make it
//  Lockable in order to get synchronized access to the resource.
//
////////////////////////////////////////////////////////////////////////////////


class ThreadDemoApp : public AppBase, Threaded {
  private:
    Console*  outputWindow;      // used by thread for output
    sint32    counter;

  protected:
    sint32  run();              // Threaded
    sint32  initApplication();  // AppBase
    sint32  runApplication();    // AppBase

  public:
    ThreadDemoApp();
    ~ThreadDemoApp();
};

////////////////////////////////////////////////////////////////////////////////

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
  return new ThreadDemoApp;
}

////////////////////////////////////////////////////////////////////////////////

void AppBase::destroyApplicationInstance(AppBase* app)
{
  delete app;
}

////////////////////////////////////////////////////////////////////////////////

ThreadDemoApp::ThreadDemoApp() : Threaded(), outputWindow(0), counter(0)
{
  outputWindow = new(nothrow) SystemConsole();
}

////////////////////////////////////////////////////////////////////////////////

ThreadDemoApp::~ThreadDemoApp()
{
  stop();
  delete outputWindow;
}

////////////////////////////////////////////////////////////////////////////////


sint32 ThreadDemoApp::initApplication()
{ // create a second console window for sub thread output
  if (!outputWindow) {
    SystemLib::dialogueBox("Error", "Exit", "Unable to create console");
    return ERR_RSC_UNAVAILABLE;
  }
  if (outputWindow->open("Thread Demo")!=OK) {
    SystemLib::dialogueBox("Error", "Exit", "Unable to open console");
    return IOS::ERR_FILE_OPEN;
  }
  return OK;
}

////////////////////////////////////////////////////////////////////////////////

sint32 ThreadDemoApp::runApplication()
{
  // Application main method.
  // Prompt user for choice until quit is selected.
  // Use simple C IO for this :-)

  puts("Chose method\n1 start()\n2 stop()\n3 wake()\n4 getUpTime()\n5 Quit");

  bool quit = false;
  while (!quit) {
    switch (getchar()) {
      case '1':
        if (start()!=OK)
          puts("Couldn't start()");
        break;

      case '2':
        if (stop()!=OK)
          puts("Couldn't stop()");
        break;

      case '3':
        if (wake()!=OK)
          puts("Couldn't wake()");
        break;

      case '4':
        {
          const Time& t = getUptime();
          printf("Uptime:%3lu days %02lu hours %02lu mins %02lu secs %03lu millis\n",
            t.days(), t.hours(), t.mins(), t.secs(), t.millis());
        }
        break;

      case '5':
        quit = true;
          break;

      default:
        break;
    }
  }
  return 0;
}

////////////////////////////////////////////////////////////////////////////////

sint32 ThreadDemoApp::run()
{
  // This is the Threaded entry point.

  outputWindow->writeText(
    "Hello World from the run() method!\n"       \
    "This thread increments a counter value\n"  \
    "belonging to the derived object once\n"    \
    "every 2 seconds.\n\n"
  );

  while (!shutDownReq()) {
    outputWindow->writeText("counter = %d\n", counter++);
    // test exceptions for a future library update. SC3 was not threadsafe!

    switch (sleep(2000, false, false, true))
    {
      case TIMEOUT:
        break;

      case WAKECALL:
        outputWindow->writeText("sleep() interrupted by wake()\n");
        break;

      case REMOVE:
        outputWindow->writeText("sleep() interrupted by stop()\n");
        break;

      case USERBREAK:
        outputWindow->writeText("sleep() interrupted by CTRL_C\n");
        break;

      default:
        outputWindow->writeText("sleep() interrupted by unknown\n");
        break;
    }
  }
  outputWindow->writeText("\nWell, my work is done here...Adios!\n\n");
  return OK;
}