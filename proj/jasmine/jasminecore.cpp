//****************************************************************************//
//**                                                                        **//
//** File:         proj/jasmine/jasminecore.cpp                             **//
//** Description:                                                           **//
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

#include "Jasmine.hpp"

extern "C" {
  #include <stddef.h>
}

sint32 Jasmine::illegalDone = 0;

void* JasmineEA::illegalAddress(EA_ARGS)
{
  #ifdef JASMINE_DEBUG_ENABLE
  printf("\n\nIllegal Address : inst %p\n", (void*)(jvm->instPtr));
  JasmineOP::fSYS_DUMP(OP_ARGVAL2);
  #endif
  jvm->exitReg = Jasmine::ILLEGAL_EATYPE;
  return jvm->imReg[0].data64();
}

///////////////////////////////////////////////////////////////////////////////

void JasmineOP::illegalOpcode(OP_ARGS)
{
  #ifdef JASMINE_DEBUG_ENABLE
  printf("\n\nIllegal Opcode : 0x%8X\n", *(jvm->instPtr));
  JasmineOP::fSYS_DUMP(OP_ARGVAL);
  #endif
  jvm->exitReg = Jasmine::ILLEGAL_OPCODE;
}

///////////////////////////////////////////////////////////////////////////////

Jasmine::Jasmine() : countReg(0), exitReg(0), instPtr(0), dataSectPtr(0), constSectPtr(0),
                   methodStackBase(0), stackBase(0), regStackBase(0)
{
  for(sint32 i=0; i<32;i++)
    gpRegs[i].valU64() = 0;
  imReg[0].valU64() = 0;
  imReg[1].valU64() = 0;

  // set up the undefined bytecodes to point to the appropriate 'illegal' handlers
  if (!illegalDone)
  {
    illegalDone = 1;
    sint32 i;
    for (i = JCode::NUM_EA; i<256; i++)
      JasmineEA::eaTable[i] = &JasmineEA::illegalAddress;
    for (i = JCode::NUM_OPS; i<256; i++)
      JasmineOP::instTable[i] = &JasmineOP::illegalOpcode;
    for (i = JCode::NUM_SYS; i<256; i++)
      JasmineOP::sysTable[i] = &JasmineOP::illegalOpcode;
  }
}

///////////////////////////////////////////////////////////////////////////////

Jasmine::~Jasmine()
{
  destroy();
}

///////////////////////////////////////////////////////////////////////////////

sint32  Jasmine::create(size_t stackSize, size_t methStackSize, size_t regStackSize)
{
  destroy();
  if (methStackSize)
  {
    if (!(methodStackBase = new const uint32*[methStackSize]))
      return ERR_NO_FREE_STORE;
    methodStackTop  = methodStackBase + methStackSize-1;
  }
  else
    methodStack = methodStackBase = methodStackTop = 0;

  if (stackSize)
  {
    if (!(stackBase = new uint8[(stackSize<<1)]))
    {
      destroy();
      return ERR_NO_FREE_STORE;
    }
    stackTrace = stackBase + stackSize;
    stackTop  = stackTrace-1;
  }
  else
    stack = stackBase = stackTop = 0;

  if (regStackSize)
  {
    if (!(regStackBase = new uint64[regStackSize]))
    {
      destroy();
      return ERR_NO_FREE_STORE;
    }
    regStackTop = regStackBase+regStackSize-1;
  }
  else
    regStack = regStackBase = regStackTop = 0;
  return OK;
}

///////////////////////////////////////////////////////////////////////////////

void Jasmine::destroy()
{
  if (methodStack)
    delete[] methodStackBase;
  if (stackBase)
    delete[] stackBase;
  if (regStackBase)
    delete[] regStackBase;
  vmObject = 0;
  methodStack = methodStackBase = methodStackTop = 0;
  stackTrace = stack = stackBase = stackTop = 0;
  regStack = regStackBase = regStackTop = 0;
}

///////////////////////////////////////////////////////////////////////////////

#ifndef JASMINE_HANDCODED

void Jasmine::execute(EX_ARGS)
{
  while (!jvm->exitReg)
  {
    JasmineOP::instTable[EX_OPCODE](OP_ARGVAL);
  }
}

#endif // JASMINE_HANDCODED

///////////////////////////////////////////////////////////////////////////////

uint32 Jasmine::execute(JasmineObject* prog)
{
  if (!prog)
  {
    puts("No program");
  }
  if (create(prog->getStackSize(),
             prog->getMethodStackSize(),
             prog->getRegisterStackSize())!=OK)
  {
    puts("VM Program initialization failed (not enough memory)");
    return 0;
  }
  vmObject      = prog;
  instPtr        = (uint32*)prog->getCode();
  dataSectPtr    = prog->getData();
  constSectPtr  = prog->getConst();
  methodStack    = methodStackBase;
  stack          = stackBase;
  regStack      = regStackBase;
  methodTable    = prog->getFuncs();
  exitReg        = 0;
  countReg      = 0;

  //puts("Executing VM code\n");

  execute(EX_ARGVAL);

  if (exitReg!=END_OF_CODE)
    printf("\nError in VM program : %s [%d]\n", getExitResult(), (sint32)exitReg);
/*
  else
    puts("\nExecution complete");
*/
  return exitReg;
}

///////////////////////////////////////////////////////////////////////////////

sint32 Jasmine::getPC()
{
  if (vmObject && vmObject->getCode()!=0)
    return (sint32)(instPtr - vmObject->getCode());
  return -1;
}

///////////////////////////////////////////////////////////////////////////////

sint32  Jasmine::pushRegs(JCLASSP, VLDREG1 sint32 first, VLDREG2 sint32 num)
{
  if (num>=0)
  {
    num++;
    if (jvm->regStack+num < jvm->regStackTop)
    {
      ruint32* rp = (uint32*)(&jvm->gpRegs[first]);
      while(num--)
      {
        *(((uint32*)jvm->regStack)++) = *rp++;
        *(((uint32*)jvm->regStack)++) = *rp++;
      }
      return 0;
    }
    else
      return REGS_OVERFLOW;
  }
  else
  {
    num = 1-num;
    if (jvm->regStack+num < jvm->regStackTop)
    {
      ruint32* rp = (uint32*)(&jvm->gpRegs[first]);
      while(num--)
      {
        *(((uint32*)jvm->regStack)++) = rp[0];//*(--rp);
        *(((uint32*)jvm->regStack)++) = rp[1];//*(--rp);
        rp-=2;
      }
      return 0;
    }
    else
      return REGS_OVERFLOW;
  }
}

///////////////////////////////////////////////////////////////////////////////

sint32  Jasmine::popRegs(JCLASSP, VLDREG1 sint32 first, VLDREG2 sint32 num)
{
  if (num>=0)
  {
    num++;
    if (jvm->regStack-num >= jvm->regStackBase)
    {
      ruint32* rp = (uint32*)(&jvm->gpRegs[first+num]);
      while(num--)
      {
        *(--rp) = *(--((uint32*)jvm->regStack));
        *(--rp) = *(--((uint32*)jvm->regStack));
      }
      return 0;
    }
    else
      return REGS_UNDERFLOW;
  }
  else
  {
    first += num;
    num = 1-num;
    if (jvm->regStack-num >= jvm->regStackBase)
    {
      ruint32* rp = (uint32*)(&jvm->gpRegs[first]);
      while(num--)
      {
        --jvm->regStack;
        *rp++ = ((uint32*)jvm->regStack)[0];//*(--((uint32*)jvm->regStack));
        *rp++ = ((uint32*)jvm->regStack)[1];//*(--((uint32*)jvm->regStack));
      }
      return 0;
    }
    else
      return REGS_UNDERFLOW;
  }
}

///////////////////////////////////////////////////////////////////////////////
/*
void Jasmine::genInclude()
{

    }  gpRegs[32];
    GPR  imReg[2];
    uint32*   instPtr;
    union {
      uint8* u8;      uint16* u16;      uint32* u32;      uint64* u64;
      sint8* s8;      sint16* s16;      sint32* s32;      sint64* s64;
      float32* f32;    float64* f64;      char*    ch;        wchar_t* wch;
      void*    any;    GPR* reg;
    } op[3];
    uint64*    regStack;
    uint8*    stack;
    uint32**  methodStack;
    void*      dataSectPtr;
    void*      constSectPtr;
    uint32    exitReg;
    sint32    countReg;
    uint32    machineReg;

  printf ("Jasmine_gpRegs EQU $%X\n", offsetof(Jasmine,gpRegs[0]));
  printf ("Jasmine_imReg_0 EQU $%X\n", offsetof(Jasmine,imReg[0]));
  printf ("Jasmine_imReg_1 EQU $%X\n", offsetof(Jasmine,imReg[1]));
  printf ("Jasmine_op_0 EQU $%X\n", offsetof(Jasmine,op[0]));
  printf ("Jasmine_op_1 EQU $%X\n", offsetof(Jasmine,op[1]));
  printf ("Jasmine_op_2 EQU $%X\n", offsetof(Jasmine,op[2]));
  printf ("Jasmine_regStack EQU $%X\n", offsetof(Jasmine,regStack));
  printf ("Jasmine_stack EQU $%X\n", offsetof(Jasmine,stack));
  printf ("Jasmine_methodStack EQU $%X\n", offsetof(Jasmine,methodStack));
  printf ("Jasmine_dataSectPtr EQU $%X\n", offsetof(Jasmine,dataSectPtr));
  printf ("Jasmine_constSectPtr EQU $%X\n", offsetof(Jasmine,constSectPtr));
  printf ("Jasmine_exitReg EQU $%X\n", offsetof(Jasmine,exitReg));
  printf ("Jasmine_countReg EQU $%X\n", offsetof(Jasmine,countReg));
  printf ("Jasmine_machineReg EQU $%X\n", offsetof(Jasmine,machineReg));

}
*/