/*

  ASM with Ansi C++ mode :-D

*/

extern "C" {
  #include <stdio.h>
}

using namespace std; /* genuine C++ :-D */

inline void test(int i, int const* p)
{
  asm volatile ("\n/*-----------------------------------*/\n\n"
/*
       "\tmove.l %0, d0\n"
       "\tmove.l %1, a0\n"
*/
       "\tjsr _testAsmFunc\n"
       "\n/*-----------------------------------*/\n\n"
       : /* No outputs */
       : "d0"(i), "a0"(p) : "cc");
}

int main(int argc, char** argv)
{
  int i = 1969;
  int j = 0;
  printf(" i = %d, j = %d\n", i, j);
  test(i, &j);
  printf(" i = %d, j = %d\n", i, j);
  test(5, &i);
  printf(" i = %d, j = %d\n", i, j);
  return 0;
}