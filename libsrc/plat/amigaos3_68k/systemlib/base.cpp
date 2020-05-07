//****************************************************************************//
//**                                                                        **//
//** File:         libsrc/plat/amigaos3_68k/systemlib/base.cpp              **//
//** Description:  SystemLib class definition                               **//
//** Comment(s):                                                            **//
//** Library:      systemlib                                                **//
//** Created:      2003-02-08                                               **//
//** Updated:      2003-02-08                                               **//
//** Author(s):    Karl Churchill                                           **//
//** Note(s):                                                               **//
//** Copyright:    (C)1996-2003, eXtropia Studios                           **//
//**               Serkan YAZICI, Karl Churchill                            **//
//**               All Rights Reserved.                                     **//
//**                                                                        **//
//****************************************************************************//

#include <xbase.hpp>

using namespace X_SYSNAME;

struct IntuitionBase*  IntuitionBase = 0;

#define MEM_IDENTIFIER 0xACEB00B5

namespace {
  SignalSemaphore*    memSemaphore  = 0;
  void*                memPool        = 0;
  size_t              puddleSize    = 0;
  size_t              threshSize    = 0;
  struct MemInfo {
    uint32  identifier;
    uint32  flags;
    size_t  size;
    void*    baseAddress; // 16 bytes (one cache line on 68040/060)
  };
}

bool SystemLib::debug = false;
/*
SystemLib::SystemLib()
{
  addResource(init, done, "systemlib");
}
*/
////////////////////////////////////////////////////////////////////////////////

sint32 SystemLib::init()
{
  debug = AppBase::getSwitch("-sysdebug", true);
  puddleSize = Clamp::integer(AppBase::getInteger("-syspuddlesize", true), 4096, 65536);
  threshSize = puddleSize - 4*Mem::ALIGN_CACHE;
  if (!(::IntuitionBase = (struct IntuitionBase*)OpenLibrary("intuition.library", 39)))  {
    X_ERROR("SystemLib error : Failed to open intuition library v39");
    return ERR_RSC_UNAVAILABLE;
  }
  if (!(memSemaphore = (SignalSemaphore*)AllocMem(sizeof(SignalSemaphore), MEMF_PUBLIC)))  {
    X_ERROR("SystemLib error : Failed to create primary memory semaphore");
    return ERR_RSC_UNAVAILABLE;
  }
  if (!(memPool = CreatePool(MEMF_PUBLIC, puddleSize, threshSize)))  {
    X_ERROR("SystemLib error : Failed to create primary memory pool");
    return ERR_RSC_UNAVAILABLE;
  }
  else {
    X_INFO("SystemLib created memory pool");
  }
  X_INFO("SystemLib initialised");
  InitSemaphore(memSemaphore);
  return OK;
}

////////////////////////////////////////////////////////////////////////////////

void SystemLib::done()
{
  if (memPool) {
    X_INFO("SystemLib freed memory pool");
    DeletePool(memPool);
    memPool = 0;
  }
  if (memSemaphore)  {
    FreeMem(memSemaphore, sizeof(SignalSemaphore));
    memSemaphore = 0;
  }
  if (::IntuitionBase) {
    CloseLibrary((Library*)::IntuitionBase);
    ::IntuitionBase = 0;
  }
  X_INFO("SystemLib finalized");
}

////////////////////////////////////////////////////////////////////////////////

void SystemLib::printDebug(const char* text, int level)
{
  if (debug) {
    switch (level) {
      case X_DEBUG_INFO:  printf("[ Info    ] %s\n", text);  break;
      case X_DEBUG_WARN:  printf("[ Warning ] %s\n", text);  break;
      case X_DEBUG_ERROR:  printf("[ Error   ] %s\n", text);  break;
      default:            printf("[ <Other> ] %s\n", text);  break;
    }
  }
}

////////////////////////////////////////////////////////////////////////////////

sint32 SystemLib::dialogueBox(const char* title, const char* opts, const char* body,...)
{
  char* textBuff = (char*)AllocMem(8192, MEMF_PUBLIC);
  sint32 result = 0;
  if (textBuff) {
    va_list argList;
    va_start(argList, body);
    vsprintf(textBuff, body, argList);
    va_end(argList);
    EasyStruct easy = { sizeof(EasyStruct), 0, (char*)title, textBuff, (char*)opts};
    result = EasyRequest(0, &easy, 0, argList);
    FreeMem(textBuff, 8192);
  }
  return result;
}

////////////////////////////////////////////////////////////////////////////////

void SystemLib::openDebugFile(const char *name)
{
  char* textBuff = (char*)AllocMem(8192, MEMF_PUBLIC);
  sprintf(textBuff,"Run >NIL: %s \"%s\" ", FILE_VIEWER_APP, name);
  openExternalProgram(textBuff);
  FreeMem(textBuff, 8192);
}

////////////////////////////////////////////////////////////////////////////////
//
//  Memory
//
////////////////////////////////////////////////////////////////////////////////

void* Mem::alloc(size_t size, bool zero=false, AlignType align=ALIGN_DEFAULT)
{
  // we ignore the alignment and just go for cache aligned stuff for 680x0
  uint32 alignLen = ALIGN_CACHE;
  uint32 allocSize = size + sizeof(MemInfo) + (alignLen<<1);

  // the allocator does some low level pointer stuff which I'd rather not do but
  // as long as the user obeys the "never free whatever you didn't allocate" things
  // should be ok.

  ObtainSemaphore(memSemaphore); // lock the memory list
  void* block   = AllocPooled(memPool, allocSize);
  void*  result  = 0;
  if (block) {
    uint32    mask    = alignLen-1;
    MemInfo*  info    = (MemInfo*)((mask+(uint32)block) & ~mask); // this is aligned
    info->identifier  = MEM_IDENTIFIER;
    info->flags        = 0;
    info->size        = allocSize;
    info->baseAddress  = block;
    result            = (((uint8*)info)+sizeof(MemInfo));
    //printf("Mem::alloc() : requested %lu bytes, allocated %lu at 0x%08X, info at 0x%08X\n", size, allocSize, (unsigned)block, (unsigned)info);
  }
  ReleaseSemaphore(memSemaphore);
  if (result) {
    if (zero) {
      Mem::zero(result, size);
    }
  }
  return result;
}

////////////////////////////////////////////////////////////////////////////////

void Mem::free(void* ptr)
{
  if (!ptr || !memPool) return;

  // the allocator does some low level pointer stuff which I'd rather not do but
  // as long as the user obeys the "never free whatever you didn't allocate" things
  // should be ok.

  MemInfo* info = (MemInfo*)(((uint32)ptr)-16);
  if (info->identifier == MEM_IDENTIFIER) {
    info->identifier = 0;
    uint32  size = info->size;
    void*    addr = info->baseAddress;
    ObtainSemaphore(memSemaphore);
    FreePooled(memPool, addr, size);
    ReleaseSemaphore(memSemaphore);
  }
}


////////////////////////////////////////////////////////////////////////////////

void Mem::copy(void* dst, const void* src, size_t len)
{
  asm(
    "\n/*************************************/\n\n"
    "\tmove.l %0, a0\n"
    "\tmove.l %1, a1\n"
    "\tmove.l %2, d0\n"
    "\tjsr copy__Mem__r8Pvr9Pvr0Ui\n"
    "\n/*************************************/\n\n"
    :                                // no outputs
    : "g"(dst), "g"(src), "g"(len)  // inputs
    : "d0", "d1", "a0", "a1","cc"    // clobbers
  );
}

////////////////////////////////////////////////////////////////////////////////

void Mem::swap16(void* dst, const void* src, size_t num)
{
  asm(
    "\n/*************************************/\n\n"
    "\tmove.l %0, a0\n"
    "\tmove.l %1, a1\n"
    "\tmove.l %2, d0\n"
    "\tjsr swap16__Mem__r8Pvr9Pvr0Ui\n"
    "\n/*************************************/\n\n"
    :                                  // no outputs
    : "g"(dst), "g"(src), "g"(num)    // inputs
    : "d0", "d1", "a0", "a1", "cc"    // clobbers
  );
}

////////////////////////////////////////////////////////////////////////////////

void Mem::swap32(void* dst, const void* src, size_t num)
{
  asm(
    "\n/*************************************/\n\n"
    "\tmove.l %0, a0\n"
    "\tmove.l %1, a1\n"
    "\tmove.l %2, d0\n"
    "\tjsr swap32__Mem__r8Pvr9Pvr0Ui\n"
    "\n/*************************************/\n\n"
    :                                  // no outputs
    : "g"(dst), "g"(src), "g"(num)    // inputs
    : "d0", "d1", "a0", "a1","cc"      // clobbers
  );
}

////////////////////////////////////////////////////////////////////////////////

void Mem::swap64(void* dst, const void* src, size_t num)
{
  asm(
    "\n/*************************************/\n\n"
    "\tmove.l %0, a0\n"
    "\tmove.l %1, a1\n"
    "\tmove.l %2, d0\n"
    "\tjsr swap64__Mem__r8Pvr9Pvr0Ui\n"
    "\n/*************************************/\n\n"
    :                                  // no outputs
    : "g"(dst), "g"(src), "g"(num)    // inputs
    : "d0", "d1", "a0", "a1","cc"      // clobbers
  );
}

////////////////////////////////////////////////////////////////////////////////

void Mem::zero(void* dst, size_t len)
{
  asm(
    "\n/*************************************/\n\n"
    "\tmove.l %0, a0\n"
    "\tmove.l %1, d0\n"
    "\tjsr zero__Mem__r8Pvr0Ui\n"
    "\n/*************************************/\n\n"
    :                                  // no outputs
    : "g"(dst), "g"(len)              // inputs
    : "d0", "d1", "a0", "a1","cc"      // clobbers
  );
}

////////////////////////////////////////////////////////////////////////////////

void Mem::set(void* dst, int val, size_t len)
{
  asm(
    "\n/*************************************/\n\n"
    "\tmove.l %0, a0\n"
    "\tmove.l %1, d0\n"
    "\tmove.l %2, d1\n"
    "\tjsr set__Mem__r8Pvr0ir1Ui\n"
    "\n/*************************************/\n\n"
    :                                  // no outputs
    : "g"(dst), "g"(val), "g"(len)    // inputs
    : "d0", "d1", "a0", "a1","cc"      // clobbers
  );
}

////////////////////////////////////////////////////////////////////////////////

void Mem::set16(void* dst, uint16 val, size_t num)
{
  asm(
    "\n/*************************************/\n\n"
    "\tmove.l %0, a0\n"
    "\tmove.l %1, d0\n"
    "\tmove.l %2, d1\n"
    "\tjsr set16__Mem__r8Pvr0Usr1Ui\n"
    "\n/*************************************/\n\n"
    :                                  // no outputs
    : "g"(dst), "g"(val), "g"(num)    // inputs
    : "d0", "d1", "a0", "a1","cc"      // clobbers
  );
}

////////////////////////////////////////////////////////////////////////////////

void Mem::set32(void* dst, uint32 val, size_t num)
{
  asm(
    "\n/*************************************/\n\n"
    "\tmove.l %0, a0\n"
    "\tmove.l %1, d0\n"
    "\tmove.l %2, d1\n"
    "\tjsr set32__Mem__r8Pvr0Ujr1Ui\n"
    "\n/*************************************/\n\n"
    :                                  // no outputs
    : "g"(dst), "g"(val), "g"(num)    // inputs
    : "d0", "d1", "a0", "a1","cc"      // clobbers
  );
}

////////////////////////////////////////////////////////////////////////////////

void Mem::set64(void* dst, const uint64& val, size_t num)
{
  asm(
    "\n/*************************************/\n\n"
    "\tmove.l %0, a0\n"
    "\tmove.l %1, a1\n"
    "\tmove.l %2, d0\n"
    "\tjsr set64__Mem__r8Pvr9RUlr0Ui\n"
    "\n/*************************************/\n\n"
    :                                  // no outputs
    : "g"(dst), "g"(&val), "g"(num)    // inputs
    : "d0", "d1", "a0", "a1","cc"      // clobbers
  );
}

Mem::MoveFunc   Mem::_copy    = 0;
Mem::MoveFunc   Mem::_swap16  = 0;
Mem::MoveFunc   Mem::_swap32  = 0;
Mem::MoveFunc   Mem::_swap64  = 0;
Mem::SetFunc    Mem::_set      = 0;
Mem::SetFunc    Mem::_set16    = 0;
Mem::SetFunc    Mem::_set32    = 0;
Mem::Set64Func  Mem::_set64    = 0;

////////////////////////////////////////////////////////////////////////////////
//
//  Auto registration
//
////////////////////////////////////////////////////////////////////////////////

//SystemLib _systemLib = SystemLib();
