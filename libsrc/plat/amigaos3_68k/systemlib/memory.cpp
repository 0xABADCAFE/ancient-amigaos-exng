//****************************************************************************//
//**                                                                        **//
//** File:         libsrc/plat/amigaos3_68k/systemlib/memory.cpp            **//
//** Description:  Mem class definition                                     **//
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

Mem::MemInfo* Mem::allocated    = 0;
void*          Mem::volatileBuff  = 0;
size_t        Mem::totalSize    = 0;
sint32        Mem::nextFree      = 0;
sint32        Mem::count        = 0;
sint32        Mem::maxAllocs    = 0;

////////////////////////////////////////////////////////////////////////////////

sint32 Mem::init()
{
  if (!(allocated = (MemInfo*)AllocVec(MAXALLOCS*sizeof(MemInfo) + VOLATILESIZE,
                                       MEMF_CLEAR|MEMF_PUBLIC)))
  {
    X_ERROR("Mem::init() unable to allocate list memory");
    return ERR_NO_FREE_STORE;
  }
  volatileBuff = (void*)&allocated[MAXALLOCS+1];
  X_INFO("Mem initialized");
  return OK;
}

////////////////////////////////////////////////////////////////////////////////

void Mem::done()
{
  if (allocated)
  {
    sint32 freed = 0;
    size_t size = 0;
    for (rsint32 i=0; i<MAXALLOCS; i++)
    {
      if (allocated[i].real)
      {
        FreeVec(allocated[i].real);
        totalSize -= allocated[i].size;
        size += allocated[i].size;
        allocated[i].real      = 0;
        allocated[i].address  = 0;
        allocated[i].size      = 0;
        allocated[i].owner     = 0;
        freed++;
        count--;
      }
    }
    #if X_DEBUG > 0
    if (freed)
      SystemLib::dialogueBox("Debug Info","Proceed","Mem::done()\n"
                             "Released %d block(s)\ntotalling %d bytes\n",
                             freed, size);
    #endif
    FreeVec(allocated);
    allocated = 0;
    volatileBuff = 0;
    X_INFO("Mem finalized");
  }
}

////////////////////////////////////////////////////////////////////////////////

void* Mem::alloc(size_t len, bool zero, Mem::AlignType align)
{
  if (!allocated || count == MAXALLOCS) return 0;
  // AllocVec has minimum 4-byte alignment anyway
  uint32 alignLen = ((uint32)align<8) ? 0 : align;
  void* r = AllocVec((len+(alignLen<<1)), MEMF_PUBLIC|(zero ? MEMF_CLEAR : 0));
  if (r)
  {
    sint32 index = nextFree;
    allocated[index].real = r;
    if (alignLen)
    {
      uint32 mask = alignLen-1;
      allocated[index].address  = (void*)((mask+(uint32)r) & ~mask);
    }
    else
      allocated[index].address = r;
    allocated[index].owner    = FindTask(0);
    allocated[index].size      = len;
    totalSize += len;
    count++;
    while (allocated[nextFree].address != 0)
      nextFree++;

    //printf("Info : Mem:: Got memory at 0x%08X\n", (unsigned)(allocated[index].real));

    return allocated[index].address;
  }
  return 0;
}

////////////////////////////////////////////////////////////////////////////////

void Mem::free(void* ptr)
{
  if (!allocated)  return;
  if (ptr)
  {
    sint32 index=-1, found=0;
    while((found==0) && (index<MAXALLOCS))
      found = (ptr==allocated[++index].address);

    if (!found)
    {
      X_WARN("Mem::free() Address not recognised");
      return;
    }

    if (!allocated[index].real)
    {
      X_WARN("Mem::free() Memory already free");
      return;
    }

    //printf("Info : Mem:: Freeing memory at 0x%08X\n", (unsigned)(allocated[index].real));

    FreeVec(allocated[index].real);
    totalSize -= allocated[index].size;
    allocated[index].real      = 0;
    allocated[index].address  = 0;
    allocated[index].owner    = 0;
    allocated[index].size      = 0;
    count--;
    if (index < nextFree)
      nextFree = index;
    return;
  }
  X_WARN("Mem::free() Attempt to free null address");
}

////////////////////////////////////////////////////////////////////////////////

void Mem::copy(void* dst, void* src, size_t len)
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

void Mem::swap16(void* dst, void* src, size_t num)
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

void Mem::swap32(void* dst, void* src, size_t num)
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

void Mem::swap64(void* dst, void* src, size_t num)
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
