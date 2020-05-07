
#include <xbase.hpp>
#include <gfxlib/gfxapp.hpp>
#include "testgui.hpp"

extern Draw2D*  testCreateDraw(Surface* s);

////////////////////////////////////////////////////////////////////////////////


class GUITestApp : public AppBase, public InputFocus, public GUIListener {
  private:
    InteractiveDisplay*    appDisplay;
    Draw2D*                draw;
    GUIBase*               myGUI;
    SimpleButton*          myButton1;
    SimpleButton*          myButton2;
    SimpleButton*          myButton3;
    SimpleButton*          myButton4;


    sint16                width;
    sint16                height;
    bool                  update;
    bool                  quit;

    // InputFocus
    void                  keyPressNonPrintable(I_SRC, Key::CtrlKey code);

    // GUIListener
    void                  handleGUIEvent(GUIObject* o);

  public:
    sint32  initApplication();
    sint32  runApplication();

  public:
    GUITestApp();
    ~GUITestApp();
};

////////////////////////////////////////////////////////////////////////////////

sint32 AppBase::init()
{
  return GfxLib::init();
}

////////////////////////////////////////////////////////////////////////////////

void AppBase::done()
{
  GfxLib::done();
}

////////////////////////////////////////////////////////////////////////////////

AppBase* AppBase::createApplicationInstance()
{
  return new GUITestApp;
}

////////////////////////////////////////////////////////////////////////////////

void AppBase::destroyApplicationInstance(AppBase* app)
{
  delete app;
}

////////////////////////////////////////////////////////////////////////////////

GUITestApp::GUITestApp() : InputFocus(IFilter::IKEYPRESS), appDisplay(0),
                           draw(0), update(true), quit(false)
{
  sint32 tw = AppBase::getInteger("width", false);
  if (tw)
    width = Clamp::integer(tw, 160, 1024);
  else
    width    = 320;

  sint32 th = AppBase::getInteger("height", false);
  if (th)
    height  = Clamp::integer(th, 120, 768);
  else
    height = 240;
}

////////////////////////////////////////////////////////////////////////////////

GUITestApp::~GUITestApp()
{
  delete myButton1;
  delete myButton2;
  delete myGUI;
  delete draw;
  delete appDisplay;
}

////////////////////////////////////////////////////////////////////////////////

void GUITestApp::keyPressNonPrintable(I_SRC, Key::CtrlKey code)
{
  switch (code)
  {
    case Key::ESC:
      quit = true;
      break;

    default:
      break;
  }
}

////////////////////////////////////////////////////////////////////////////////

void GUITestApp::handleGUIEvent(GUIObject* o)
{
  if (o == (GUIObject*)myButton1)
    printf("button 1");
  else if (o == (GUIObject*)myButton2)
    printf("button 2");
  printf(": %ld\n", o->getEventType());
  update = true;
}

////////////////////////////////////////////////////////////////////////////////

sint32 GUITestApp::initApplication()
{
  appDisplay = new InteractiveWindow(IFilter::IDEFAULT);
  if (!appDisplay || appDisplay->open(width, height, Pixel::BPP8, "Test")!=OK)
  {
    SystemLib::dialogueBox("Error", "Exit", "Unable to create window");
    return ERR_RSC_UNAVAILABLE;
  }


  draw = testCreateDraw(appDisplay->getDrawSurface());
  if (!draw)
  {
    SystemLib::dialogueBox("Error", "Exit", "Unable to obtain a Draw2D class");
    return ERR_RSC_UNAVAILABLE;
  }
  draw->setClearColour(SimpleGUI::background);
  draw->setFlatFillColour(SimpleGUI::fill);
  draw->setStrokeColour(SimpleGUI::stroke);
  draw->eraseRect(0, 0, width-1, height-1);

  appDisplay->addFocus(this);

  if (!(myGUI = new GUIBase))
  {
    SystemLib::dialogueBox("Error", "Exit", "Unable to create GUIBase");
    return ERR_RSC_UNAVAILABLE;
  }



  sint16 cx = width/2;
  sint16 cy = height/2;

  if (!(myButton1 = new SimpleButton(cx-30, cy-25, 60, 20, 1, draw)))
  {
    SystemLib::dialogueBox("Error", "Exit", "Unable to create button 1");
    return ERR_RSC_UNAVAILABLE;
  }

  if (!(myButton2 = new SimpleButton(cx-30, cy+5, 60, 20, 1, draw)))
  {
    SystemLib::dialogueBox("Error", "Exit", "Unable to create button 2");
    return ERR_RSC_UNAVAILABLE;
  }

  myGUI->setRoot(myButton1);
  myButton1->addChild(myButton2);
  myGUI->enablePassive();
  myButton1->addListener(this);
  myButton2->addListener(this);
  myButton1->enable();
  myButton2->enable();
  myButton1->draw();
  myButton2->draw();

  appDisplay->addFocus(myGUI);
  appDisplay->refresh();
  return OK;
}

////////////////////////////////////////////////////////////////////////////////

sint32 GUITestApp::runApplication()
{
  while (!quit)
  {
    while (appDisplay->handleEvent())
      ;
    appDisplay->refresh();
    appDisplay->waitEvent();
  }
  return 0;
}

////////////////////////////////////////////////////////////////////////////////

