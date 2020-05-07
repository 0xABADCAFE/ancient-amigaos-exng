//****************************************************************************//
//**                                                                        **//
//** File:         exec.hpp                                                 **//
//** Description:  Amiga exec.library wrapper                               **//
//** Comment(s):   Internal developer version only                          **//
//** Library:                                                               **//
//** Created:      2006-02-19                                               **//
//** Updated:      2006-02-19                                               **//
//** Author(s):    Karl Churchill                                           **//
//** Note(s):                                                               **//
//** Copyright:    (C)1996 - , eXtropia Studios                             **//
//**               Serkan YAZICI, Karl Churchill                            **//
//**               All Rights Reserved.                                     **//
//**                                                                        **//
//****************************************************************************//

#ifndef _INLINECPP_AMIGAEXEC_HPP_
#define _INLINECPP_AMIGAEXEC_HPP_

// Assume all functions trash d0/d1/a0/a1/a6/cc (in accordance with RKM docs

#ifndef _LC_TRASH
#define _LC_TRASH "d0", "d1", "a0", "a1", "a6", "cc"
#endif


struct IORequest;
struct Device;
struct Library;
struct Interrupt;
struct MsgPort;
struct SignalSemaphore;
struct List;
struct MinList;
struct Node;
struct MinNode;
struct MemHeader;
struct MemList;
struct Task;
extern struct ExecBase* SysBase;

class ExecLibrary {
  public:
    static void abortIO(register IORequest* ioReq)
    {
      //_LVOAbortIO                   EQU  -480
      // ioReq in a1
      __asm__ (
        "/* void ExecLibrary::abortIO(IORequest*) */\n"
        "\t move.l %0, a1\n"
        "\t move.l %1, a6\n"
        "\t jsr -480(a6)\n"
        "\t/***************/\n"
        :
        : "g"(ioReq), "g"(::SysBase)
        : _LC_TRASH
      );
    }

    static void addDevice(register Device* device)
    {
      //_LVOAddDevice                 EQU  -432
      // device in a1
      __asm__ (
        "/* void ExecLibrary::addDevice(Device*) */\n"
        "\t move.l %0, a1\n"
        "\t move.l %1, a6\n"
        "\t jsr -432(a6)\n"
        "\t/***************/\n"
        :
        : "g"(device), "g"(::SysBase)
        : _LC_TRASH
      );
    }

    static void addHead(register List* list, register Node* node)
    {
      // _LVOAddHead                   EQU  -240
      // list in a0
      // node in a1
      __asm__ (
        "/* void ExecLibrary::addHead(List*, Node*) */\n"
        "\t move.l %0, a0\n"
        "\t move.l %1, a1\n"
        "\t move.l %2, a6\n"
        "\t jsr -240(a6)\n"
        "\t/***************/\n"
        :
        : "g"(list), "g"(node), "g"(::SysBase)
        : _LC_TRASH
      );
    }

    static void addIntServer(register uint32 intNum, register Interrupt* interrupt)
    {
      //_LVOAddIntServer              EQU  -168
      // intNum in d0
      // interrupt in a1
      __asm__ (
        "/* void ExecLibrary::addIntServer(uint32, Interrupt*) */\n"
        "\t move.l %0, d0\n"
        "\t move.l %1, a1\n"
        "\t move.l %2, a6\n"
        "\t jsr -168(a6)\n"
        "\t/***************/\n"
        :
        : "g"(intNum), "g"(interrupt), "g"(::SysBase)
        : _LC_TRASH
      );
    }

    static void addLibrary(register Library* library)
    {
      // _LVOAddLibrary                EQU  -396
      // library in a1
      __asm__ (
        "/* void ExecLibrary::addLibrary(Library*) */\n"
        "\t move.l %0, a1\n"
        "\t move.l %1, a6\n"
        "\t jsr -396(a6)\n"
        "\t/***************/\n"
        :
        : "g"(library), "g"(::SysBase)
        : _LC_TRASH
      );
    }

    static void addMemHandler(register Interrupt* interrupt)
    {
      //_LVOAddMemHandler             EQU  -774
      // interrupt in a1
      __asm__ (
        "/* void ExecLibrary::addMemHandler(Interrupt*) */\n"
        "\t move.l %0, a1\n"
        "\t move.l %1, a6\n"
        "\t jsr -774(a6)\n"
        "\t/***************/\n"
        :
        : "g"(interrupt), "g"(::SysBase)
        : _LC_TRASH
      );
    }

    static void addMemList(register uint32 size, register uint32 attr, register uint32 pri, register void* base, register const char* name)
    {
      //_LVOAddMemList                EQU  -618
      // size in d0
      // attr in d1
      // pri in d2
      // base in a0
      // name in a1
      __asm__ (
        "/* void ExecLibrary::addMemList(uint32,uint32,uint32,void*,const char*) */\n"
        "\t move.l %0, d0\n"
        "\t move.l %1, d1\n"
        "\t move.l %2, d2\n"
        "\t move.l %3, a0\n"
        "\t move.l %4, a1\n"
        "\t move.l %5, a6\n"
        "\t jsr -618(a6)\n"
        "\t/***************/\n"
        :
        : "g"(size), "g"(attr), "g"(pri), "g"(base), "g"(name), "g"(::SysBase)
        : _LC_TRASH, "d2"
      );
    }

    static void addPort(register MsgPort* port)
    {
      //_LVOAddPort                   EQU  -354
      // port in a1
      __asm__ (
        "/* void ExecLibrary::addPort(MsgPort*) */\n"
        "\t move.l %0, a1\n"
        "\t move.l %1, a6\n"
        "\t jsr -354(a6)\n"
        "\t/***************/\n"
        :
        : "g"(port), "g"(::SysBase)
        : _LC_TRASH
      );
    }

    static void addResource(register void* resource)
    {
      //_LVOAddResource               EQU  -486
      // resource in a1
      __asm__ (
        "/* void ExecLibrary::addResource(void*) */\n"
        "\t move.l %0, a1\n"
        "\t move.l %1, a6\n"
        "\t jsr -486(a6)\n"
        "\t/***************/\n"
        :
        : "g"(resource), "g"(::SysBase)
        : _LC_TRASH
      );
    }

    static void addSemaphore(register SignalSemaphore* semaphore)
    {
      //_LVOAddSemaphore              EQU  -600
      // semaphoire in a1
      __asm__ (
        "/* void ExecLibrary::addSemaphore(SignalSemaphore*) */\n"
        "\t move.l %0, a1\n"
        "\t move.l %1, a6\n"
        "\t jsr -600(a6)\n"
        "\t/***************/\n"
        :
        : "g"(semaphore), "g"(::SysBase)
        : _LC_TRASH
      );
    }

    static void addTail(register List* list, register Node* node)
    {
      // _LVOAddTail                   EQU  -246
      // list in a0
      // node in a1
      __asm__ (
        "/* void ExecLibrary::addTail(List*, Node*) */\n"
        "\t move.l %0, a0\n"
        "\t move.l %1, a1\n"
        "\t move.l %2, a6\n"
        "\t jsr -246(a6)\n"
        "\t/***************/\n"
        :
        : "g"(list), "g"(node), "g"(::SysBase)
        : _LC_TRASH
      );
    }

    static void* addTask(register Task* task, register void* iniPC, register void* finPC)
    {
      // _LVOAddTask                   EQU  -282
      // task in a1
      // iniPC in a2
      // finPC in a3
      register void* res;
      __asm__ (
        "/* void* ExecLibrary::addTask(Task*,void*,void*) */\n"
        "\t move.l %1, a1\n"
        "\t move.l %2, a2\n"
        "\t move.l %3, a3\n"
        "\t move.l %4, a6\n"
        "\t jsr -282(a6)\n"
        "\t move.l d0, %0\n"
        "\t/***************/\n"
        : "=r"(res)
        : "g"(task), "g"(iniPC), "g"(finPC), "g"(::SysBase)
        : _LC_TRASH, "a2", "a3"
      );
      return res;
    }

    static void alert(register uint32 alertNum)
    {
      // _LVOAlert -108
      // alertNum in d7
      __asm__ (
        "/* void ExecLibrary::alert(uint32) */\n"
        "\t move.l %0, d7\n"
        "\t move.l %1, a6\n"
        "\t jsr -108(a6)\n"
        "\t/***************/\n"
        :
        : "g"(alertNum), "g"(::SysBase)
        : _LC_TRASH, "d7"
      );
    }

    static void* allocAbs(register uint32 size, register void* location)
    {
      // _LVOAllocAbs                  EQU  -204
      // size in d0
      // location in d1
      // return d0
      register void* res;
      __asm__ (
        "/* void* ExecLibrary::allocAbs(uint32, void*) */\n"
        "\t move.l %1, d0\n"
        "\t move.l %2, a1\n"
        "\t move.l %3, a6\n"
        "\t jsr -204(a6)\n"
        "\t move.l d0, %0\n"
        "\t/***************/\n"
        : "=r"(res)
        : "g"(size), "g"(location), "g"(::SysBase)
        : _LC_TRASH
      );
      return res;
    }

/*

// _LVOAllocate                  EQU  -186
// _LVOAllocEntry                EQU  -222
// _LVOAllocMem                  EQU  -198
// _LVOAllocPooled               EQU  -708
// _LVOAllocSignal               EQU  -330
// _LVOAllocTrap                 EQU  -342
// _LVOAllocVec                  EQU  -684
// _LVOAttemptSemaphore          EQU  -576
// _LVOAttemptSemaphoreShared    EQU  -720

*/


    static void* allocate(register MemHeader* memHeader, register uint32 byteSize)
    {
      //  -186
      // size in d0
      // location in d1
      // return d0
      register void* res;
      __asm__ (
        "/* void* ExecLibrary::allocate(MemHeader*, uint32) */\n"
        "\t move.l %1, a0\n"
        "\t move.l %2, d0\n"
        "\t move.l %3, a6\n"
        "\t jsr -186(a6)\n"
        "\t move.l d0, %0\n"
        "\t/***************/\n"
        : "=r"(res)
        : "g"(memHeader),"g"(byteSize),  "g"(::SysBase)
        : _LC_TRASH
      );
      return res;
    }

    static MemList* allocEntry(register MemList* memList)
    {
      //                EQU  -222
      register MemList* res;
      __asm__ (
        "/* MemList* ExecLibrary::allocEntry(MemHeader*, uint32) */\n"
        "\t move.l %1, a0\n"
        "\t move.l %2, a6\n"
        "\t jsr -222(a6)\n"
        "\t move.l d0, %0\n"
        "\t/***************/\n"
        : "=r"(res)
        : "g"(memList), "g"(::SysBase)
        : _LC_TRASH
      );
      return res;
    }

    static void* allocMem(register uint32 byteSize, register uint32 attr)
    {
      //                  EQU  -198
      register void* res;
      __asm__ (
        "/* void* ExecLibrary::allocMem(uint32, uint32) */\n"
        "\t move.l %1, d0\n"
        "\t move.l %2, d1\n"
        "\t move.l %3, a6\n"
        "\t jsr -190(a6)\n"
        "\t move.l d0, %0\n"
        "\t/***************/\n"
        : "=r"(res)
        : "g"(byteSize), "g"(attr), "g"(::SysBase)
        : _LC_TRASH
      );
      return res;
    }

    static void* allocPooled(register void* poolHeader, register uint32 memSize)
    {
      //               EQU  -708
      register void* res;
      __asm__ (
        "/* void* ExecLibrary::allocPooled(void*, uint32) */\n"
        "\t move.l %1, a0\n"
        "\t move.l %2, d0\n"
        "\t move.l %3, a6\n"
        "\t jsr -708(a6)\n"
        "\t move.l d0, %0\n"
        "\t/***************/\n"
        : "=r"(res)
        : "g"(poolHeader), "g"(memSize), "g"(::SysBase)
        : _LC_TRASH
      );
      return res;
    }

    static sint32 allocSignal(register sint32 signalNum)
    {
      //               EQU  -330
      register sint8 res;
      __asm__ (
        "/* sint32 ExecLibrary::allocSignal(sint32) */\n"
        "\t move.l %1, d0\n"
        "\t move.l %2, a6\n"
        "\t jsr -330(a6)\n"
        "\t move.b d0, %0\n"
        "\t/***************/\n"
        : "=r"(res)
        : "g"(signalNum), "g"(::SysBase)
        : _LC_TRASH
      );
      return res;
    }

    static sint32 allocTrap(register sint32 trapNum)
    {
      //                 EQU  -342
      register sint8 res;
      __asm__ (
        "/* sint32 ExecLibrary::allocTrap(sint8) */\n"
        "\t move.l %1, d0\n"
        "\t move.l %2, a6\n"
        "\t jsr -342(a6)\n"
        "\t move.b d0, %0\n"
        "\t/***************/\n"
        : "=r"(res)
        : "g"(trapNum), "g"(::SysBase)
        : _LC_TRASH
      );
      return res;
    }

    static void* allocVec(register uint32 byteSize, register uint32 attr)
    {
      //                  EQU  -684
      register void* res;
      __asm__ (
        "/* void* ExecLibrary::allocVec(uint32, uint32) */\n"
        "\t move.l %1, d0\n"
        "\t move.l %2, d1\n"
        "\t move.l %3, a6\n"
        "\t jsr -684(a6)\n"
        "\t move.l d0, %0\n"
        "\t/***************/\n"
        : "=r"(res)
        : "g"(byteSize), "g"(attr), "g"(::SysBase)
        : _LC_TRASH
      );
      return res;
    }

    static sint32 attemptSemaphore(register SignalSemaphore* sigSem)
    {
      //          EQU  -576
      register sint32 res;
      __asm__ (
        "/* sint32 ExecLibrary::attemptSemaphore(SignalSemaphore* sigSem) */\n"
        "\t move.l %1, a0\n"
        "\t move.l %2, a6\n"
        "\t jsr -576(a6)\n"
        "\t move.l d0, %0\n"
        "\t/***************/\n"
        : "=r"(res)
        : "g"(sigSem), "g"(::SysBase)
        : _LC_TRASH
      );
      return res;
    }

    static uint32 attemptSemaphoreShared(register SignalSemaphore* sigSem)
    {
      //    EQU  -720
      register uint32 res;
      __asm__ (
        "/* sint32 ExecLibrary::attemptSemaphoreShared(register SignalSemaphore*) */\n"
        "\t move.l %1, a0\n"
        "\t move.l %2, a6\n"
        "\t jsr -720(a6)\n"
        "\t move.l d0, %0\n"
        "\t/***************/\n"
        : "=r"(res)
        : "g"(sigSem), "g"(::SysBase)
        : _LC_TRASH
      );
      return res;
    }

    static uint32 availMem(register uint32 type)
    {
      // _LVOAvailMem                  EQU  -216
      // type in d1
      // return d0
      register uint32 res;
      __asm__ (
        "/* uint32 ExecLibrary::availMem(uint32) */\n"
        "\t move.l %1, d1\n"
        "\t move.l %2, a6\n"
        "\t jsr -216(a6)\n"
        "\t move.l d0, %0\n"
        "\t/***************/\n"
        : "=r"(res)
        : "g"(type), "g"(::SysBase)
        : _LC_TRASH
      );
      return res;
    }
/*

_LVOCacheClearE               EQU  -642
_LVOCacheClearU               EQU  -636
_LVOCacheControl              EQU  -648
_LVOCachePostDMA              EQU  -768
_LVOCachePreDMA               EQU  -762
_LVOCause                     EQU  -180
_LVOCheckIO                   EQU  -468
_LVOChildFree                 EQU  -738
_LVOChildOrphan               EQU  -744
_LVOChildStatus               EQU  -750
_LVOChildWait                 EQU  -756
_LVOCloseDevice               EQU  -450
_LVOCloseLibrary              EQU  -414
_LVOColdReboot                EQU  -726
_LVOCopyMem                   EQU  -624
_LVOCopyMemQuick              EQU  -630
_LVOCreateIORequest           EQU  -654
_LVOCreateMsgPort             EQU  -666
_LVOCreatePool                EQU  -696
_LVODeallocate                EQU  -192
_LVODebug                     EQU  -114
_LVODeleteIORequest           EQU  -660
_LVODeleteMsgPort             EQU  -672
_LVODeletePool                EQU  -702
_LVODisable                   EQU  -120
_LVODoIO                      EQU  -456
_LVOEnable                    EQU  -126
_LVOEnqueue                   EQU  -270
_LVOFindName                  EQU  -276
_LVOFindPort                  EQU  -390
_LVOFindResident              EQU  -96
_LVOFindSemaphore             EQU  -594
_LVOFindTask                  EQU  -294
_LVOForbid                    EQU  -132
_LVOFreeEntry                 EQU  -228
_LVOFreeMem                   EQU  -210
_LVOFreePooled                EQU  -714
_LVOFreeSignal                EQU  -336
_LVOFreeTrap                  EQU  -348
_LVOFreeVec                   EQU  -690
_LVOGetCC                     EQU  -528
_LVOGetMsg                    EQU  -372
_LVOInitCode                  EQU  -72
_LVOInitResident              EQU  -102
_LVOInitSemaphore             EQU  -558
_LVOInitStruct                EQU  -78
_LVOInsert                    EQU  -234
_LVOMakeFunctions             EQU  -90
_LVOMakeLibrary               EQU  -84
_LVOObtainQuickVector         EQU  -786
_LVOObtainSemaphore           EQU  -564
_LVOObtainSemaphoreList       EQU  -582
_LVOObtainSemaphoreShared     EQU  -678
_LVOOldOpenLibrary            EQU  -408
_LVOOpenDevice                EQU  -444
_LVOOpenLibrary               EQU  -552
_LVOOpenResource              EQU  -498
_LVOPermit                    EQU  -138
_LVOProcure                   EQU  -540
_LVOPutMsg                    EQU  -366
_LVORawDoFmt                  EQU  -522
_LVOReleaseSemaphore          EQU  -570
_LVOReleaseSemaphoreList      EQU  -588
_LVORemDevice                 EQU  -438
_LVORemHead                   EQU  -258
_LVORemIntServer              EQU  -174
_LVORemLibrary                EQU  -402
_LVORemMemHandler             EQU  -780
_LVORemove                    EQU  -252
_LVORemPort                   EQU  -360
_LVORemResource               EQU  -492
_LVORemSemaphore              EQU  -606
_LVORemTail                   EQU  -264
_LVORemTask                   EQU  -288
_LVOReplyMsg                  EQU  -378
_LVOSendIO                    EQU  -462
_LVOSetExcept                 EQU  -312
_LVOSetFunction               EQU  -420
_LVOSetIntVector              EQU  -162
_LVOSetSignal                 EQU  -306
_LVOSetSR                     EQU  -144
_LVOSetTaskPri                EQU  -300
_LVOSignal                    EQU  -324
_LVOStackSwap                 EQU  -732
_LVOSumKickData               EQU  -612
_LVOSumLibrary                EQU  -426
_LVOSuperState                EQU  -150
_LVOSupervisor                EQU  -30
_LVOTypeOfMem                 EQU  -534
_LVOUserState                 EQU  -156
_LVOVacate                    EQU  -546
_LVOWait                      EQU  -318
_LVOWaitIO                    EQU  -474
_LVOWaitPort                  EQU  -384
*/
};

#endif
