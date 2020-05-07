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
#include <gfxlib/gfxapp.hpp>
#include <iolib/inprecord.hpp>

////////////////////////////////////////////////////////////////////////////////
//
//  Application
//
//  Main application
//
////////////////////////////////////////////////////////////////////////////////

#define RESPONSES (IFilter::IDEFAULT)

class Application : public AppBase, public InputFocus {
  private:
    InteractiveDisplay*    appWindow;
    SimpleEventRecorder*  recorder;
    bool                  refresh;
    bool                  sync;
    bool                  quit;

  protected:
    // AppBase
    sint32  initApplication();
    sint32  runApplication();

    // InputFocus
    void    keyPressNonPrintable(InputDispatcher* src, Key::CtrlKey code);

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
  return GfxLib::init();
}

////////////////////////////////////////////////////////////////////////////////

void AppBase::done()
{
  // Do any library cleanup after application exit
  GfxLib::done();
}

////////////////////////////////////////////////////////////////////////////////

AppBase* AppBase::createApplicationInstance()
{
  // Create our application object
  return new Application;
}

////////////////////////////////////////////////////////////////////////////////

void AppBase::destroyApplicationInstance(AppBase* app)
{
  // Destroy our application object
  delete app;
}

////////////////////////////////////////////////////////////////////////////////

Application::Application() : InputFocus(RESPONSES), appWindow(0), recorder(0),
                             sync(true), refresh(true), quit(false)
{
  if (getSwitch("fullscreen", false))
  {
    appWindow = new InteractiveScreen(RESPONSES, "id_application");
  }
  else
  {
    appWindow = new InteractiveWindow(RESPONSES, "id_application");
  }
  // disable display sync?
  if (getSwitch("nosync", false))
    sync = false;

  // disable refresh?
  if (getSwitch("norefresh", false))
    refresh = false;

  // make event log?
  const char* eventFileName = 0;
  if (eventFileName = getString("record", false))
  {
    if (!(recorder = new SimpleEventRecorder))
      SystemLib::dialogueBox("Warning", "Proceed", "Unable to create event recorder");
    else if (recorder->open(eventFileName)!=OK)
    {
      SystemLib::dialogueBox("Warning", "Proceed", "Unable to create event log file\n'%s'");
      delete recorder;
      recorder = 0;
    }
  }
}

////////////////////////////////////////////////////////////////////////////////

Application::~Application()
{
  // Cleanup and close
  if (recorder)    delete recorder;
  if (appWindow)  delete appWindow;
}

////////////////////////////////////////////////////////////////////////////////

void Application::keyPressNonPrintable(InputDispatcher* src, Key::CtrlKey code)
{
  // Respond to non printable key presses
  // This method overriden from Windowed
  switch (code)
  {
    case Key::ESC:  quit     = true;      break;
    case Key::F1:    sync     = !sync;    break;
    case Key::F2:    refresh  = !refresh;  break;
    default: break;
  }
}

////////////////////////////////////////////////////////////////////////////////

sint32 Application::initApplication()
{
  if (!appWindow)
  {
    SystemLib::dialogueBox("Error", "Exit", "Failed to create application window");
    return ERR_RSC_UNAVAILABLE;
  }

  if (appWindow->open(400, 300, Pixel::BPP8, "Input Test [Esc to quit]")!=OK)
  {
    SystemLib::dialogueBox("Error", "Exit", "Failed to open application window");
    return ERR_RSC_UNAVAILABLE;
  }

  // To get input, we need to register the input focus (the application)
  // with the dispatcher (the appWindow)
  appWindow->addFocus(this);

  if (recorder)
  {
    recorder->setFocusFilter(getFocusFilter());
    appWindow->addFocus(recorder);
  }
  return OK;
}

////////////////////////////////////////////////////////////////////////////////

sint32 Application::runApplication()
{
  // The main event loop here.
  // This method overriden from AppBase

  Clock    timer;
  sint32  events = 0;
  sint32  frames = 0;
  sint32  peak = 0;

  while (!quit)
  {
    sint32 eventsThisFrame = 0;

    // handle and count each event queued
    while (appWindow->handleEvent())
      eventsThisFrame++;

    // tally up the total events so far
    events += eventsThisFrame;

    // check the peak events per frame
    if (eventsThisFrame > peak)
      peak = eventsThisFrame;

    if (sync)
      appWindow->waitSync();
    if (refresh)
      appWindow->refresh();
    frames++;
  }

  appWindow->close();

  Time& totTime = timer.elapsed();
  float32 fps = (float32)(frames*1000)/(float32)((sint32)totTime.totMillis());
  float32 average = (float32)events/(float32)frames;

  SystemLib::dialogueBox("Info", "Ok", "Frames:%d, Events:%d\nAverage:%.4f, Peak %d\nFPS : %.4f",
    frames, events, average, peak, fps);

  return 0;
}

