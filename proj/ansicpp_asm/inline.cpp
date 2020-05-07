/*
  Test code 2006-02-13

  Attempt to create ANSI C++ exec library wrapper with
  proper inline asm function calls (no more linklib trampolines!)

  K Churchill

*/

#include "types.hpp"
#include "include/exec.hpp"
#include <stdio.h>
#include <proto/exec.h>

int main(int argN, char** argV)
{
  uint32 memType = MEMF_FAST;
  uint32 mem1 = AvailMem(memType);
  uint32 mem2 = ExecLibrary::availMem(memType);
  printf("Hello World %lu : %lu : %lu\n", memType, mem1, mem2);

  void* mem = ExecLibrary::allocVec(1024, memType);

  if (mem) {
    printf("Allocated 1024 bytes at 0x%08X\n", (unsigned)mem);
    FreeVec(mem);
  }

  return 0;
}