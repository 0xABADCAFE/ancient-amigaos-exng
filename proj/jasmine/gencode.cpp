//****************************************************************************//
//**                                                                        **//
//** File:         proj/jasmine/gencode.cpp                                 **//
//** Description:  Jasmine VM test application                              **//
//** Comment(s):   Internal developer version only                          **//
//** Library:                                                               **//
//** Created:      2003-02-10                                               **//
//** Updated:      2003-02-10                                               **//
//** Author(s):    Karl Churchill                                           **//
//** Note(s):                                                               **//
//** Copyright:    (C)1996-2003, eXtropia Studios                           **//
//**               Serkan YAZICI, Karl Churchill                            **//
//**               All Rights Reserved.                                     **//
//**                                                                        **//
//****************************************************************************//

#include <xbase.hpp>
#include "jasminecode.hpp"
#include "jasmineobject.hpp"

#define FUNC_MAIN 0
#define FUNC_FACTORIAL 1

static char str1[] = "VM program to generate factorials\n\nPlease enter a number : ";
static char str2[] = "Factorials are defined for positive integers only\n";
static char str3[] = "Factorial is : ";
static char progName[] = "Factorial Demo";

static uint32 func1[] = {
  // main
  JCode::SYS<<24        | JCode::OUT_STR<<16    | JCode::CDS<<8, (0),
  JCode::SYS<<24        | JCode::INP_S32<<16    | JCode::R0<<8,

  JCode::BGREQ_I32<<24  | JCode::R0<<16          | JCode::IM0<<8, (4),
  JCode::SYS<<24        | JCode::OUT_STR<<16    | JCode::CDS<<8, (sizeof(str1)),
  JCode::END<<24,
  JCode::F64_S32<<24    | JCode::R0<<16          | JCode::R0<<8,
  JCode::F64_S32<<24    | JCode::IM1<<16        | JCode::R2<<8,
  JCode::F64_S32<<24    | JCode::IM2<<16        | JCode::R3<<8,
  JCode::PUSH_X64<<24    | JCode::R0<<16,
  JCode::CALL<<24        | JCode::FUNC_TAB<<16,  (FUNC_FACTORIAL), // call factorial()
  JCode::POP_X64<<24    | JCode::R0<<16,
  JCode::SYS<<24        | JCode::OUT_STR<<16    | JCode::CDS<<8, (sizeof(str1)+sizeof(str2)),
  JCode::SYS<<24        | JCode::OUT_F64<<16    | JCode::R0<<8,
  JCode::SYS<<24        | JCode::OUT_U8<<16      | JCode::LITERAL<<8, ('\n'),
  JCode::END<<24
};

static uint32 func2[] = {
  // factorial (n)
  JCode::SAVE<<24        |  JCode::R0<<16        | JCode::R1<<8,                // save local
  JCode::POP_X64<<24    | JCode::R0<<16,                                  // get n
  JCode::BLS_F64<<24    | JCode::IM0<<16      | JCode::R0<<8, (4),
  JCode::PUSH_X64<<24    | JCode::R2<<16,
  JCode::BRA<<24, (10),

  JCode::BGR_F64<<24    | JCode::R3<<16        | JCode::R0<<8,  (7),

  JCode::SUB_F64<<24    | JCode::R0<<16        | JCode::R2<<8  | JCode::R1,    // n-1
  JCode::PUSH_X64<<24    | JCode::R1<<16,
  JCode::CALL<<24        | JCode::OFFSET_PC<<16,  (-12),                    // recurse
  JCode::POP_X64<<24    | JCode::R1<<16,
  JCode::MUL_F64<<24    | JCode::R0<<16        | JCode::R1<<8    | JCode::R0,

  // return n
  JCode::PUSH_X64<<24    | JCode::R0<<16,
  JCode::RESTORE<<24    | JCode::R0<<16        | JCode::R1<<8,
  JCode::RET<<24
};

static uint32  func3[] = {
/*
  JCode::MOVE_X32<<24    | JCode::LITERAL<<16    | JCode::R31<<8, (100000),
  JCode::MOVE_X32<<24    | JCode::IM1<<16        | JCode::R30<<8,
  JCode::CLR_X32<<24    | JCode::R29<<16,
  JCode::SUB_I32<<24    | JCode::R31<<16        | JCode::R30<<8  | JCode::R31,
  JCode::BGR_I32<<24    | JCode::R31<<16        | JCode::R29<<8, (-2),
  JCode::END<<24,
*/
};

#define  NUM_FUNCS 2

#define CODE_SIZE ((sizeof(func1)+sizeof(func2))/sizeof(uint32))
#define DATA64_SIZE 0
#define DATA32_SIZE 0
#define DATA16_SIZE 0
#define DATA8_SIZE 0

#define CONST64_SIZE 0
#define CONST32_SIZE 0
#define CONST16_SIZE 0
#define CONST8_SIZE (sizeof(str1)+sizeof(str2)+sizeof(str3))

#define STACK_SIZE 1024
#define REG_STACK_SIZE 512
#define METHOD_STACK_SIZE 512

////////////////////////////////////////////////////////////////////////////////

class GenCodeApp : public AppBase, JasmineObjectProvider {
  private:
    XSFStreamOut*    file;
    JasmineObject*  jObject;

    sint32  createProgram();

  protected:
    // AppBase methods
    sint32  initApplication();
    sint32  runApplication();

  public:
    GenCodeApp();
    ~GenCodeApp();
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
  return new GenCodeApp;
}

////////////////////////////////////////////////////////////////////////////////

void AppBase::destroyApplicationInstance(AppBase* app)
{
  delete app;
}

////////////////////////////////////////////////////////////////////////////////

GenCodeApp::GenCodeApp() : file(0), jObject(0)
{
  file  = new XSFStreamOut();
  jObject  = new JasmineObject;
}

////////////////////////////////////////////////////////////////////////////////

GenCodeApp::~GenCodeApp()
{
  delete jObject;
  delete file;
}

////////////////////////////////////////////////////////////////////////////////

sint32 GenCodeApp::initApplication()
{
  if (numArgs()<2)
  {
    puts("No object file specified : usage gencode <filename>");
    return IOS::ERR_FILE;
  }
  if (!jObject || !file)
  {
    puts("Failed to instansiate components");
    return ERR_RSC;
  }
  return OK;
}

////////////////////////////////////////////////////////////////////////////////

sint32 GenCodeApp::runApplication()
{
  if (createProgram() == OK)
  {
    if (file->open(getArg(1), JasmineObject::xsfFileSig,
        XSF::verXSF, XSF::revXSF, X_HARDWARE, 0)!=OK)
    {
      printf("Unable to open '%s'\n", getArg(1));
      return IOS::ERR_FILE_OPEN;
    }
    if (jObject->write(file)<0)
    {
      printf("Error occured when writing '%s'\n", getArg(1));
      return IOS::ERR_FILE_READ;
    }
    file->close();
    return OK;
  }
  return ERR_RSC;
}

////////////////////////////////////////////////////////////////////////////////

sint32 GenCodeApp::createProgram()
{
  JFInfo funcDef;
  sint32 result = jasmineCreateNewRep(
                    jObject, NUM_FUNCS, CODE_SIZE,
                    DATA64_SIZE,   DATA32_SIZE,
                    DATA16_SIZE,   DATA8_SIZE,
                    CONST64_SIZE,  CONST32_SIZE,
                    CONST16_SIZE,  CONST8_SIZE);
  if (result!=OK)
  {
    puts("Failed to create program representation");
    return result;
  }
  puts("Creating program...");
  jasmineSetName(jObject, progName);
  jasmineSetVersion(jObject, 1);
  jasmineSetRevision(jObject, 0);
  jasmineSetStackSize(jObject, STACK_SIZE);
  jasmineSetRegisterStackSize(jObject, REG_STACK_SIZE);
  jasmineSetMethodStackSize(jObject, METHOD_STACK_SIZE);

  uint32 offset = 0;
  uint32 size = sizeof(func1)/sizeof(uint32);

  result = jasmineInstallCode(jObject, func1, size, offset);
  if (result!=OK)
  {
    printf("Failed to install code section at offset %lu, size %lu\n", offset, size);
    return result;
  }
  else
  {
    funcDef.define("main", "<none>", size, offset);
    jasmineInstallFunc(jObject, &funcDef, FUNC_MAIN);
    printf("Installed code section at offset %lu, size %lu\n", offset, size);
  }

  offset+=size;
  size = sizeof(func2)/sizeof(uint32);

  result = jasmineInstallCode(jObject, func2, size, offset);
  if (result!=OK)
  {
    printf("Failed to install code section at offset %lu, size %lu\n", offset, size);
    return result;
  }
  else
  {
    funcDef.define("factorial", "<stack>float64(<stack>float64)", size, offset);
    jasmineInstallFunc(jObject, &funcDef, FUNC_FACTORIAL);
    printf("Installed code section at offset %lu, size %lu\n", offset, size);
  }
  jasmineResolve(jObject);

  offset = 0;
  size = sizeof(str1);

  result = jasmineInstallConst8(jObject, str1, size, offset);
  if (result!=OK)
  {
    printf("Failed to install const8 section at offset %lu, size %lu\n", offset, size);
    return result;
  }
  else
  {
    printf("Installed const8 section at offset %lu, size %lu\n", offset, size);
  }

  offset += size;
  size = sizeof(str2);

  result = jasmineInstallConst8(jObject, str2, size, offset);
  if (result!=OK)
  {
    printf("Failed to install const8 section at offset %lu, size %lu\n", offset, size);
    return result;
  }
  else
  {
    printf("Installed const8 section at offset %lu, size %lu\n", offset, size);
  }

  offset += size;
  size = sizeof(str3);

  result = jasmineInstallConst8(jObject, str3, size, offset);
  if (result!=OK)
  {
    printf("Failed to install const8 section at offset %lu, size %lu\n", offset, size);
    return result;
  }
  else
  {
    printf("Installed const8 section at offset %lu, size %lu\n", offset, size);
  }

  jObject->debugDump();

  return result;
}