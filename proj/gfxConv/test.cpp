
#include <xbase.hpp>
#include <iolib/fileio.hpp>

class ConvertChunkyApp : public AppBase {
  private:
    uint32    pal[256];
    const char*      chunkyName;
    const char*      palName;
    const char*      ppmName;
    StreamIn  *in;
    StreamOut  *out;
    sint32    w, h;

  public:
    sint32  initApplication();
    sint32  runApplication();
  public:
    ConvertChunkyApp();
    ~ConvertChunkyApp();
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
  return new ConvertChunkyApp;
}

////////////////////////////////////////////////////////////////////////////////

void AppBase::destroyApplicationInstance(AppBase* app)
{
  delete app;
}

////////////////////////////////////////////////////////////////////////////////

ConvertChunkyApp::ConvertChunkyApp()
{
  chunkyName = getString("chk", false);
  palName = getString("pal", false);
  ppmName = getString("to", false);
  in  = new StreamIn;
  out = new StreamOut;
  w = Clamp::integer(getInteger("width", false), 2, 1024);
  h = Clamp::integer(getInteger("height", false), 2, 1024);
}

////////////////////////////////////////////////////////////////////////////////

ConvertChunkyApp::~ConvertChunkyApp()
{
  if (in)
    delete in;
  if (out)
    delete out;
}

////////////////////////////////////////////////////////////////////////////////

sint32 ConvertChunkyApp::initApplication()
{
  if (!chunkyName)
  {
    puts("Error : no source filename given");
    return ERR_PTR_ZERO;
  }
  if (!palName)
  {
    puts("Error : no palette filename given");
    return ERR_PTR_ZERO;
  }
  if (!ppmName)
  {
    puts("Error : no output filename given");
    return ERR_PTR_ZERO;
  }
  if (!in)
  {
    puts("Error : couldn't create StreamIn");
    return ERR_PTR_ZERO;
  }
  if (!out)
  {
    puts("Error : couldn't create StreamOut");
    return ERR_PTR_ZERO;
  }
  return OK;
}


////////////////////////////////////////////////////////////////////////////////

sint32 ConvertChunkyApp::runApplication()
{
  if (in->open(palName, false)!=OK)
  {
    puts("Error : couldn't open palette");
    return ERR_PTR_ZERO;
  }
  if (in->read32(pal, 256)!=256)
    puts("Warning : unexpected end of palette");
  in->close();

  if (in->open(chunkyName, false)!=OK)
  {
    puts("Error : couldn't open chunky source");
    return ERR_PTR_ZERO;
  }

  if (out->open(ppmName, false)!=OK)
  {
    puts("Error : couldn't open output");
    return ERR_PTR_ZERO;
  }

  out->writeText("P6\n%d\n%d\n255\n", w, h);

  size_t len = (w*h)+1;

  while (--len && !in->end())
  {
    char* p = (char*)(&pal[(((uint32)in->getChar())&255)]);
    out->putChar(*(++p));
    out->putChar(*(++p));
    out->putChar(*(++p));
  }
  in->close();
  out->close();
  if (len>0)
  {
    puts("warning : unexpected end of file");
  }

  return OK;
}

////////////////////////////////////////////////////////////////////////////////

