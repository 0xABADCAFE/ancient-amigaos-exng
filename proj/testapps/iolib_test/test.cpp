
#include <xbase.hpp>
#include <IOLib/xsfio.hpp>

class IOTestApp : public AppBase {
  public:
    sint32  runApplication();        // AppBase

  public:
    IOTestApp();
    ~IOTestApp();
};

////////////////////////////////////////////////////////////////////////////////

class XSFTest : public XSFStorable {
  private:
    uint32    data[16];
    float64    stuff[4];

  protected:
    sint32 writeBody(XSFStreamOut* out) {
      sint32 total=0;
      sint32 result = write32(out, data, 16);
      if (result<0)
        return result;
      total += result;
      result = write64(out, stuff, 4);
      if (result<0)
        return result;
      total += result;
      return total;
    }

    sint32 readBody(XSFStreamIn* in) {
      sint32 total=0;
      sint32 result = read32(in, data, 16);
      if (result<0)
        return result;
      total += result;
      result = read64(in, stuff, 4);
      if (result<0)
        return result;
      total += result;
      return total;
    }

    void  dumpBody() {
      sint32 i;
      for (i=0; i<16; i++)
        printf("data       0x%08X\n", data[i]);

      uint32* p = (uint32*)stuff;

      for (i=0; i<8; i+=2)
        printf("data       0x%08X%08X\n", p[i], p[i+1]);

    }

  public:
    void  setData(uint32 v)  {
      data[0] = v;
    }

    XSFTest() : XSFStorable("A very long name to give an interesting key", 0x1234, 0xABDC, 1, 0)  {
      setRawSize(sizeof(data));
      setControl(0x0690);
      sint32 i;
      for (i=0; i<16; i++)
        data[i] = (i+3)<<24|(i+2)<<16|(i+1)<<8|i;
      for (i=0; i<4; i++)
        stuff[i] = 0.123*(float64)i+0.1;
    }
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
  return new IOTestApp;
}

////////////////////////////////////////////////////////////////////////////////

void AppBase::destroyApplicationInstance(AppBase* app)
{
  delete app;
}

////////////////////////////////////////////////////////////////////////////////

IOTestApp::IOTestApp()
{
}

////////////////////////////////////////////////////////////////////////////////

IOTestApp::~IOTestApp()
{
}

////////////////////////////////////////////////////////////////////////////////

#define X_BIG XA_PTR32|XA_BIGENDIAN|XA_ALIGN32
#define X_LIT XA_PTR32|XA_LITTLEENDIAN|XA_ALIGN32

sint32 IOTestApp::runApplication()
{
  uint8 format;

  if (getSwitch("little", false)==true)
    format = X_LIT;
  else
    format = X_BIG;

  XSFStreamOut out;
  if (out.open("ram:test.xsf", "Dummy", 1, 0, format, 0)==OK)
  {
    puts("created ram:test.xsf");
    out.dump();
    XSFTest test;
    test.setData(0xCAFEBABE);
    test.write(&out);
    out.close();
  }

  XSFStreamIn in;
  if (in.open("ram:test.xsf")==OK)
  {
    puts("opened ram:test.xsf");
    in.dump();
    XSFTest test;
    test.setData(0xDEADBEEF);
    test.dump();
    sint32 r = test.read(&in);
    printf("read returned : %ld\n", r);

    test.dump();
    in.close();
  }
/*
  StreamIn in;
  if (in.open("ram:test.xsf", false)==OK)
  {
    uint16 buf[4];
    while (!in.end())
    {
      in.read16Swap(buf,4);
      printf ("0x%08X 0x%08X 0x%08X 0x%08X\n", buf[0], buf[1], buf[2], buf[3]);
    }
  }
  in.close();
*/
  return 0;
}

////////////////////////////////////////////////////////////////////////////////

