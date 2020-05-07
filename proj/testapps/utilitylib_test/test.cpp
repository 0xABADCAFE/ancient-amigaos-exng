
#include <xbase.hpp>
#include <systemlib/timer.hpp>
#include <utilitylib/list.hpp>

extern "C" {
  #include <stdlib.h>
}

class Dummy {
  private:
    static uint32 rootID;
    uint32 id;
  public:
    sint32 getID()  { return id; }
    Dummy() { id = rootID++; }
};

uint32 Dummy::rootID = 0;

class UtilTestApp : public AppBase {
  private:
    RefList<Dummy> *testList;

  public:
    sint32  runApplication();

  public:
    UtilTestApp();
    ~UtilTestApp();
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
  return new UtilTestApp;
}

////////////////////////////////////////////////////////////////////////////////

void AppBase::destroyApplicationInstance(AppBase* app)
{
  delete app;
}

////////////////////////////////////////////////////////////////////////////////

UtilTestApp::UtilTestApp()
{
  _LLBase::setDelta(32768);
  testList = new RefList<Dummy>;
}

////////////////////////////////////////////////////////////////////////////////

UtilTestApp::~UtilTestApp()
{
  if (testList)
    delete testList;
}

////////////////////////////////////////////////////////////////////////////////

sint32 UtilTestApp::runApplication()
{
  if (!testList)
    return -1;

  Dummy* dummy = new Dummy[32];


  if (dummy)
  {
    for (sint32 r=0; r<1000; r++)
    {
      for (sint32 i=0; i<32; i++)
      {
        if (rand()>(RAND_MAX/2))
          testList->insertFirst(&dummy[i]);
        else
          testList->insertLast(&dummy[i]);
      }
    }

    printf("list entries : %d\n", testList->length());

    puts("\nTiming forward iteration\n");
    {
      MilliClock timer;
      rsint32 n = 0;
      for (register Dummy* test = testList->first(); test; test = testList->next())
      {
        n+=test->getID();
      }
      uint32 t = timer.elapsed();
      printf("Result = %ld\nTook %lu ms\n", n, t);
    }

    puts("\nTiming reverse iteration\n");
    {
      MilliClock timer;
      rsint32 n = 0;
      for (register Dummy* test = testList->last(); test; test = testList->prev())
      {
        n+=test->getID();
      }
      uint32 t = timer.elapsed();
      printf("Result = %ld\nTook %lu ms\n", n, t);
    }

    puts ("\nTiming block remove\n");
    {
      MilliClock timer;
      sint32 n = testList->removeAll(&dummy[4]);
      uint32 t = timer.elapsed();
      printf("Result = %ld\nTook %lu ms\n", n, t);
    }

    puts ("\nTiming block replace\n");
    {
      MilliClock timer;
      sint32 n = testList->replaceAll(&dummy[0], &dummy[9]);
      uint32 t = timer.elapsed();
      printf("Result = %ld\nTook %lu ms\n", n, t);
    }

    printf("list entries : %d\n", testList->length());

    puts("\nTiming forward iteration\n");
    {
      MilliClock timer;
      rsint32 n = 0;
      for (register Dummy* test = testList->first(); test; test = testList->next())
      {
        n+=test->getID();
      }
      uint32 t = timer.elapsed();
      printf("Result = %ld\nTook %lu ms\n", n, t);
    }

    delete[] dummy;

  }

  return 0;
}

////////////////////////////////////////////////////////////////////////////////

