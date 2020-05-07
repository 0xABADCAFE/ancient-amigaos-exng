//****************************************************************************//
//**                                                                        **//
//** File:         prj/hello/hello.cpp                                      **//
//** Description:  Test                                                     **//
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

extern "C" {
  #include <string.h>
}

namespace X_SYSNAME {
  extern "C" {
    void Karl_CopyMemQuick(CONST APTR source, APTR dest, ULONG size);
    void Karl_CopyMem(CONST APTR source, APTR dest, ULONG size);
  }
};

using namespace X_SYSNAME; // the OS stuff is under this #defined namespace

////////////////////////////////////////////////////////////////////////////////
//
//  Application
//
////////////////////////////////////////////////////////////////////////////////

#define TEST_SIZE 1024

class Application : public AppBase {
  private:
    char*    sourceData;
    char*    destinationData;
    char*    compareData;
    char*    printBuffer;

    void    setData();
    void    printRange(size_t ofs, size_t len);
    bool    compareRange(size_t ofs, size_t len);

    sint32  strainCopyMem();
    sint32    strainCopyMemQuick();

  protected:
    sint32  initApplication();
    sint32  runApplication();

  public:
    Application();
    ~Application();
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
  return new Application;
}

////////////////////////////////////////////////////////////////////////////////

void AppBase::destroyApplicationInstance(AppBase* app)
{
  delete app;
}

////////////////////////////////////////////////////////////////////////////////

Application::Application()
{
  sourceData = (char*)Mem::alloc(TEST_SIZE, false, Mem::ALIGN_CACHE);
  destinationData = (char*)Mem::alloc(TEST_SIZE, false, Mem::ALIGN_CACHE);
  compareData = (char*)Mem::alloc(TEST_SIZE, false, Mem::ALIGN_CACHE);
  printBuffer = (char*)Mem::alloc(128, true);
}

////////////////////////////////////////////////////////////////////////////////

Application::~Application()
{
  if (sourceData)
    Mem::free(sourceData);
  if (destinationData)
    Mem::free(destinationData);
  if (compareData)
    Mem::free(compareData);
  if (printBuffer)
    Mem::free(printBuffer);
}

////////////////////////////////////////////////////////////////////////////////

sint32 Application::initApplication()
{
  if (sourceData!=0 && destinationData!=0 && printBuffer!=0)
  {
    setData();
    return OK;
  }
  return ERR_NO_FREE_STORE;
}

////////////////////////////////////////////////////////////////////////////////

sint32 Application::runApplication()
{
  sint32 errors = 0;
  printf("Strain Testing CopyMem/CopyMemQuick replacement code\n");
  errors+=strainCopyMemQuick();
  errors+=strainCopyMem();
  printf("\n\nAll done, found %ld errors.\n", errors);
  return 0;
}

sint32 Application::strainCopyMem()
{
  sint32 totErrors = 0;
  for (sint32 rela=0; rela<8; rela++)
  {
    for (sint32 abso=0; abso<8; abso++)
    {
      sint32 errors = 0;
      Mem::set(destinationData, '.', TEST_SIZE);
      Mem::set(compareData, '.', TEST_SIZE);
      printf("Strain testing Karl_CopyMem() : Absolute %ld, Relative %ld, lengths 0-%ld\n", abso, rela, TEST_SIZE-128);
      for (sint32 i=0; i<TEST_SIZE-128; i++)
      {
        CopyMem(sourceData+abso, compareData+abso+rela, i);
        Karl_CopyMem(sourceData+abso, destinationData+abso+rela, i);
        if (compareRange(0, TEST_SIZE)==false)
        {
          printf("Strain test failed for length %ld\n", i);
          printRange(i-16, 32);
          ++errors;
        }
      }
      printf("Errors detected %ld\n", errors);
      totErrors += errors;
    }
  }
  printf("Total errors detected %ld\n\n", totErrors);
  return totErrors;
}

sint32 Application::strainCopyMemQuick()
{
  sint32 totErrors = 0;
  for (sint32 rela=0; rela<32; rela+=4)
  {
    for (sint32 abso=0; abso<32; abso+=4)
    {
      sint32 errors = 0;
      Mem::set(destinationData, '.', TEST_SIZE);
      Mem::set(compareData, '.', TEST_SIZE);
      printf("Strain testing Karl_CopyMemQuick() : Absolute %ld, Relative %ld, lengths 0-%ld\n", abso, rela, TEST_SIZE-128);
      for (sint32 i=0; i<TEST_SIZE-128; i+=4)
      {
        CopyMemQuick(sourceData+abso, compareData+abso+rela, i);
        Karl_CopyMemQuick(sourceData+abso, destinationData+abso+rela, i);
        if (compareRange(0, TEST_SIZE)==false)
        {
          printf("Strain test failed for length %ld\n", i);
          printRange(i-16, 32);
          ++errors;
        }
      }
      printf("Errors detected %ld\n", errors);
      totErrors += errors;
    }
  }
  printf("Total errors detected %ld\n\n", totErrors);
  return totErrors;
}

bool Application::compareRange(size_t ofs, size_t len)
{
  if (strncmp(destinationData+ofs, compareData+ofs, len)!=0)
    return false;
  return true;
}

void Application::printRange(size_t ofs, size_t len)
{
  printf("\nRange %lu - %lu\n", ofs, (ofs+len-1));
  strncpy(printBuffer, sourceData+ofs, len);
  printf("Src: %s\n\n", printBuffer);
  strncpy(printBuffer, destinationData+ofs, len);
  printf("Dst: %s\n", printBuffer);
  strncpy(printBuffer, compareData+ofs, len);
  printf("Cmp: %s\n\n", printBuffer);
}

void Application::setData()
{
  char* p = sourceData;
  for (sint32 i=0; i<TEST_SIZE; i++)
  {
    *p++ = (char)('0' + (i&7));
  }
}