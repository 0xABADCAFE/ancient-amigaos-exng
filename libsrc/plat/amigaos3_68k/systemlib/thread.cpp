//****************************************************************************//
//**                                                                        **//
//** File:         libsrc/plats/amigaos3_68k/systemlib/thread.cpp           **//
//** Description:  Multithreading services                                  **//
//** Comment(s):                                                            **//
//** Library:      systemlib                                                **//
//** Created:      2003-02-08                                               **//
//** Updated:      2003-02-09                                               **//
//** Author(s):    Karl Churchill                                           **//
//** Note(s):                                                               **//
//** Copyright:    (C)1996-2003, eXtropia Studios                           **//
//**               Serkan YAZICI, Karl Churchill                            **//
//**               All Rights Reserved.                                     **//
//**                                                                        **//
//****************************************************************************//

#include <systemlib/thread.hpp>

extern "C" {
  #include <string.h>
}

namespace X_SYSNAME {
  extern "C" {
    #include <clib/alib_protos.h>
  }
};

using namespace X_SYSNAME;

////////////////////////////////////////////////////////////////////////////////
//
//  Threaded::IdleTimer
//
////////////////////////////////////////////////////////////////////////////////

bool Threaded::IdleTimer::init()
{
  if ( !(timerPort = CreateMsgPort()) ) {
    flags |= PORT_FAIL;
    return false;
  }
  timerSignal = 1<<timerPort->mp_SigBit;
  if ( !(timerIO = CreateExtIO(timerPort, sizeof(timerequest))) )  {
    flags |= IORQ_FAIL;
    return false;
  }
  if (OpenDevice(TIMERNAME, UNIT_MICROHZ, timerIO, 0)!=0)  {
    flags |= OPDV_FAIL;
    return false;
  }
  return true;
}

////////////////////////////////////////////////////////////////////////////////

void Threaded::IdleTimer::done()
{
  if (timerIO) {
    if (flags & IORQ_USED) {
      AbortIO(timerIO);
      WaitIO(timerIO);
      SetSignal(0, timerSignal);
    }
    CloseDevice(timerIO);
    DeleteExtIO(timerIO);
  }
  if (timerPort) {
    DeleteMsgPort(timerPort);
  }
  timerPort = 0;
  timerIO = 0;
  timerSignal = 0;
  flags = 0;
}

////////////////////////////////////////////////////////////////////////////////

void Threaded::IdleTimer::abortDelay()
{
  // Cancels a scheduled wake up
  if (timerIO && (flags & IORQ_USED))  {
    AbortIO(timerIO);
    WaitIO(timerIO);
    SetSignal(0, timerSignal);
  }
}

////////////////////////////////////////////////////////////////////////////////

uint32 Threaded::IdleTimer::suspend(uint32 millis, uint32 trigger)
{
  req = trigger;
  if (!(millis|trigger)) {
    return 0;
  }
  abortDelay();
  if (millis)  {
    timerReq->tr_node.io_Command  = TR_ADDREQUEST;
    timerReq->tr_time.tv_secs      = (millis/1000);
    timerReq->tr_time.tv_micro    = 1000*(millis%1000);
    SendIO(timerIO);
    flags |= IORQ_USED;
    flags &= ~IORQ_4EVR;
  }
  else {
    flags |= IORQ_4EVR;
  }
  return Wait(timerSignal|trigger);
}

////////////////////////////////////////////////////////////////////////////////

uint32 Threaded::IdleTimer::suspend()
{
  if (req) {
    if (timerIO && (flags & IORQ_USED)) {
      if (CheckIO(timerIO)==0) {
        return Wait(req|timerSignal);
      }
      else {
        return timerSignal;
      }
    }
  }
  return 0;
}


////////////////////////////////////////////////////////////////////////////////
//
//  MainThread
//
//  This is only used to wrap the main execution path with a Threaded derived
//  interface.
//
////////////////////////////////////////////////////////////////////////////////

class MainThread : public Threaded
{
  protected:
    sint32  run() { return ERR_ACCESS; }

  public:
    sint32 start(sint32 pri=PRI_DEFAULT, size_t stk = STACK_DEFAULT) {
      return ERR_ACCESS;
    }
    sint32 stop() { return ERR_ACCESS; }
  public:
    MainThread();
    ~MainThread();
};

////////////////////////////////////////////////////////////////////////////////

MainThread::MainThread() : Threaded()
{
  internal = (Process*)rootThread;
  state = SPAWNED;
  strcpy(name, "Main");
  sleeper.init();
  uptime.set();
}

////////////////////////////////////////////////////////////////////////////////

MainThread::~MainThread()
{
  sleeper.done();
  state = 0;
  //X_INFO("MainThread destroyed");
}

////////////////////////////////////////////////////////////////////////////////
//
//  Thread
//
////////////////////////////////////////////////////////////////////////////////

Threaded* Thread::getMain()
{
  static MainThread mainThread;
  return &mainThread;
}

////////////////////////////////////////////////////////////////////////////////

Threaded* Thread::getCurrent()
{
  Task* task = FindTask(0);
  if (task==Threaded::rootThread) {
    //X_INFO("Thread::getCurrent() - root thread");
    return getMain();
  }
  else if (task) {
    Threaded* thread = (Threaded*)(task->tc_UserData);
    if (thread && thread->classID == Threaded::IDTAG) {
      return thread;
    }
  }
  //X_ERROR("Thread::getCurrent() - unknown thread");
  return 0;
}

////////////////////////////////////////////////////////////////////////////////

bool Thread::userBreak()
{
  return (SetSignal(0, SIGBREAKF_CTRL_C) & SIGBREAKF_CTRL_C) ? true : false;
}

////////////////////////////////////////////////////////////////////////////////

sint32 Thread::sleep(uint32 ms, bool ignBrk, bool ignWk, bool abrtRq)
{
  Threaded* t = getCurrent();
  if (t) {
    return t->sleep(ms, ignBrk, ignWk, abrtRq);
  }
  //X_ERROR("Thread::sleep() - unable to obtain Threaded handle");
  return Threaded::ERR_ACCESS;
}

////////////////////////////////////////////////////////////////////////////////

sint32 Thread::sleepResume()
{
  Threaded* t = getCurrent();
  if (t) {
    return t->sleepResume();
  }
  return Threaded::ERR_ACCESS;
}

////////////////////////////////////////////////////////////////////////////////

void Thread::sleepAbort()
{
  Threaded* t = getCurrent();
  if (t) {
    t->sleepAbort();
  }
}

////////////////////////////////////////////////////////////////////////////////

const Time& Thread::getUptime()
{
  static Time dummy(0);
  Threaded* t = getCurrent();
  if (t) {
    return t->getUptime();
  }
  return dummy;
}

////////////////////////////////////////////////////////////////////////////////
//
//  Threaded
//
////////////////////////////////////////////////////////////////////////////////

sint32  Threaded::threadCnt    = 1;
sint32  Threaded::threadsIdle  = 0;
Task*    Threaded::rootThread  = FindTask(0);

sint16  Threaded::priTab[10] = {
  0,    // PRI_DEFAULT,
  -127,  // PRI_MINIMUM
  -100, // PRI_BACKGROUND
  -10,  // PRI_LOW
  -5,    // PRI_BELOWNORMAL
  0,    // PRI_NORMAL
  5,    // PRI_ABOVENORMAL
  10,    // PRI_HIGH
  20,    // PRI_REALTIME
  100    // PRI_MAXIMUM
};

Threaded::Threaded() : classID(IDTAG), external(0), internal(0), sleeper(),
                       stackSize(0), priority(PRI_NORMAL), state(0), retVal(0)
{
}

////////////////////////////////////////////////////////////////////////////////

Threaded::~Threaded()
{
  stop();
}

////////////////////////////////////////////////////////////////////////////////

void Threaded::entryPoint()
{
  // immediately drop into a wait state until the creator signals it is ok to
  // proceed
  Wait(SIGNAL_SYNC);
  Threaded *t = Thread::getCurrent();
  if (t) {
    if (t->sleeper.init() == false) {
      t->state |= STARTERROR;
      return;
    }
    t->state |= SPAWNED;

    // By now, the creator thread should be waiting to hear from us to say
    // that we were initialised ok and that it may proceed.

    Signal(t->external, (uint32)SIGNAL_SYNC);
    ++threadCnt;

    // Now we have to do the job for which we were spawned :-)
    t->retVal = t->run();
    --threadCnt;
    t->state |= COMPLETED;
  }
}

////////////////////////////////////////////////////////////////////////////////

void Threaded::exitPoint()
{
  Threaded* t = Thread::getCurrent();
  if (t) {
    t->sleeper.done();
    t->state &= ~SPAWNED;
    Signal(t->external, (uint32)SIGNAL_SYNC);
  }
}

////////////////////////////////////////////////////////////////////////////////

sint32 Threaded::sleep(uint32 ms, bool ignBrk, bool ignWk, bool abrtRq)
{
  // Only spawned thread may idle(). A time value of zero means sleep forever
  // which really means sleep until someone calls stop(), wake() or one one
  // of the trigger signals is received.
  if ((&(internal->pr_Task))!=FindTask(0)) {
    //X_ERROR("Threaded::sleep() - internal call from external Thread");
    return ERR_ACCESS;
  }
  if (abrtRq) {
    state |= ABORTREQ;
  }
  else {
    state &= ~ABORTREQ;
  }

  uint32 gotSignals;
  uint32 trig = SIGNAL_REMV;

  if (ignBrk) {
    state |= IGNOREBREAK;
  }
  else {
    state &= ~IGNOREBREAK;
    trig |= SIGNAL_BREAK;
  }

  if (ignWk) {
    state |= IGNOREWAKE;
  }
  else {
    state &= ~IGNOREWAKE;
    trig |= SIGNAL_WAKE;
  }

  //X_INFO("Threaded::sleep() - starting delay");

  ++threadsIdle;
  state |= SLEEPING;
  gotSignals = sleeper.suspend(ms, trig);
  state &= ~SLEEPING;
  --threadsIdle;

  //X_INFO("Threaded::sleep() - ending delay");


  if (abrtRq) {
    sleepAbort();
  }

  // Return priority for multiple signal resolution:
  //
  // 1. SIGNAL_REMV
  // 2. SIGNAL_WAKE
  // 3. SIGNAL_BREAK
  // 4. TRIGGER
  // 5. TIMEOUT
  // 6. OTHER

  sint32 result;

  if (gotSignals & SIGNAL_REMV)  {
    sleepAbort();
    state |= SHUTDOWN;
    result = REMOVE;
  }
  else if ((gotSignals & SIGNAL_WAKE) && !(state & IGNOREWAKE)) {
    result = WAKECALL;
  }
  else if ((gotSignals & SIGNAL_BREAK) && !(state & IGNOREBREAK)) {
    result = USERBREAK;
  }
  else if (gotSignals & sleeper.getTimerSignal()) {
    result = TIMEOUT;
  }
  else {
    result = UNKNOWN;
  }
  return result;
}

////////////////////////////////////////////////////////////////////////////////

sint32 Threaded::sleepResume()
{
  if ((&(internal->pr_Task))!=FindTask(0)) {
    return ERR_ACCESS;
  }
  else if (state & ABORTREQ) {
    return SLEEPABORTED;
  }
  uint32 gotSignals = sleeper.suspend();

  // Return priority for multiple signal resolution:
  //
  // 1. SIGNAL_REMV
  // 2. SIGNAL_WAKE
  // 3. SIGNAL_BREAK
  // 4. TRIGGER
  // 5. TIMEOUT
  // 6. OTHER

  if (gotSignals & SIGNAL_REMV)  {
    sleeper.abortDelay();
    state |= SHUTDOWN;
    return REMOVE;
  }
  else if ((gotSignals & SIGNAL_WAKE) && !(state & IGNOREWAKE)) {
    return WAKECALL;
  }
  else if ((gotSignals & SIGNAL_BREAK) && !(state & IGNOREBREAK)) {
    return USERBREAK;
  }
  else if (gotSignals & sleeper.getTimerSignal()) {
    return TIMEOUT;
  }
  return UNKNOWN;
}

////////////////////////////////////////////////////////////////////////////////

void Threaded::sleepAbort()
{
  sleeper.abortDelay();
  state |= ABORTREQ;
}

////////////////////////////////////////////////////////////////////////////////

sint32 Threaded::start(const char* nm, Threaded::Priority pri, size_t stk)
{
  if (state & SPAWNED) {
    return ERR_ALREADYRUNNING;
  }
  external = FindTask(0);
/*
  stackSize = Clamp(stk, STACK_MINIMUM, STACK_MAXIMUM);
  priority  = Clamp(pri, PRI_MINIMUM, PRI_MAXIMUM);
*/
  stackSize = stk;
  priority  = pri;

  if (nm) {
    strncpy(name, nm, 15);
  }
  else {
    sprintf(name, "Thread [%ld]", threadCnt+1);
  }
  TagItem threadTags[] = {
    NP_Entry,        (uint32)&Threaded::entryPoint,
    NP_StackSize,    (uint32)stackSize,
    NP_Priority,    (uint32)priTab[priority],
    NP_Name,        (uint32)name,
    NP_ExitCode,    (uint32)&Threaded::exitPoint,
    NP_FreeSeglist, (uint32)false,
    NP_CloseOutput, (uint32)true,
    TAG_DONE,        0L
  };

// The entry point of our internal thread starts with Wait(SIGNAL_SYNC)
// Until we send SIGNAL_SYNC to the newly created thread, we can modify
// its data without fear of concurrency clashing.
// We set the task user data pointer and then signal the thread. This
// eliminates the older need for a Forbid()/Permit() pair and as such
// is cleaner.

  //::Forbid();
  state = 0;
  internal = CreateNewProc(threadTags);
  if (!internal) {
    //::Permit();
    return ERR_STARTUP;
  }
  else {
    // set up our our Threaded handle
    internal->pr_Task.tc_UserData = (void*)this;
  //::Permit();
  }

// timestamp the creation
  uptime.set();

// tell the internal thread to proceed
  Signal(&(internal->pr_Task), (uint32)SIGNAL_SYNC);

// Wait for the thread to call us back. When this happens, one of three
// possible things is true
//
// 1) Thread initialisation was a success and is running
//    --> return OK
//
// 2) Thread initialisation was a success and has finished already
//    --> clear thread pointer and all but COMPLETED state flag
//
// 3) Thread initialisation failed
//    --> clear thread pointer and all flags

  while ((state & (SPAWNED|STARTERROR|COMPLETED))==0) {
    Wait((uint32)SIGNAL_SYNC);
  }
  if (state & STARTERROR) {
    state = 0;
    return ERR_STARTUP;
  }
  if (state & COMPLETED) {
    state = COMPLETED;
    internal = 0;
  }
  return OK;
}

////////////////////////////////////////////////////////////////////////////////

sint32 Threaded::stop()
{
  if ((&(internal->pr_Task)) == rootThread) {
    return ERR_ACCESS;
  }
  if (!(state & SPAWNED) || !internal) {
    return ERR_NOTRUNNING;
  }
  external = FindTask(0);
  // Spawned threads may not call their own stop()
  if ((&(internal->pr_Task))==external)  {
    external = 0;
    return ERR_ACCESS;
  }
  state |= SHUTDOWN;
  Signal(&(internal->pr_Task), (uint32)SIGNAL_REMV);
  // wait for thread to finalize
  while(state & SPAWNED) {
    Wait((uint32)SIGNAL_SYNC);
  }
  internal = 0;

  // timestamp the finalization time
  uptime.elapsed();
  return OK;
}

////////////////////////////////////////////////////////////////////////////////

sint32 Threaded::wake()
{
  if (!internal || !(state & SPAWNED)) {
    return ERR_NOTRUNNING;
  }
  else if ((&(internal->pr_Task))==FindTask(0)) {
    return ERR_ACCESS;
  }
  else if (state & IGNOREWAKE) {
    return ERR_UNWAKEABLE;
  }
  Signal(&(internal->pr_Task), SIGNAL_WAKE);
  return OK;
}

////////////////////////////////////////////////////////////////////////////////

sint32 Threaded::setPriority(Threaded::Priority p)
{
  if (!internal || !(state & SPAWNED)) {
    return ERR_NOTRUNNING;
  }
  else if ((&(internal->pr_Task))==FindTask(0) && p>PRI_NORMAL) {
    return ERR_VALUE;
  }
  priority = p;
  SetTaskPri((&(internal->pr_Task)), priTab[priority]);
  return OK;
}

////////////////////////////////////////////////////////////////////////////////

const Time& Threaded::getUptime()
{
  // If the internal thread does not exist (not yet started or has terminated)
  // return the last timestamp recorded.
  // Otherwise, obtain the current Time since the thread was spawned.
  if (!internal || !(state & SPAWNED)) {
    return uptime.last();
  }
  return uptime.elapsed();
}

////////////////////////////////////////////////////////////////////////////////
//
//
//
////////////////////////////////////////////////////////////////////////////////


uint32 ThreadedImplementor::waitForSignals(Threaded* thread, uint32 signals)
{
  if ( FindTask(0) == (&(thread->internal->pr_Task)) ) {
    return Wait(signals);
  }
  return ~signals;
}

////////////////////////////////////////////////////////////////////////////////
//
//  Lockable
//
////////////////////////////////////////////////////////////////////////////////

sint32 Lockable::tryLock()
{
  // If the destructor has gotten past stage 1, the destroyed flag is set.
  // We must check this first and exit immediately if it is found to be set.
  if (destroyed) {
    return DESTROYED;
  }
  if (AttemptSemaphore(&lock)) {
    // If we have obtained te semaphore, it might be that the destructor
    // is now midway having flagged the destruction and waiting for all
    // the other threads to release their locks again.
    if (destroyed) {
      ReleaseSemaphore(&lock);
      return DESTROYED;
    }
    // OK, we now own the lock
    return OK;
  }
  else {
    // someone else has a lock already
    return ALREADYLOCKED;
  }
}

////////////////////////////////////////////////////////////////////////////////

sint32 Lockable::waitLock()
{
  // If the destructor has gotten past stage 1, the destroyed flag is set.
  // We must check this first and exit immediately if it is found to be set.
  if (destroyed) {
    return DESTROYED;
  }
  ObtainSemaphore(&lock);
  if (destroyed) {
    // If we have obtained te semaphore, it might be that the destructor
    // is now midway having flagged the destruction and waiting for all
    // the other threads to release their locks again.
    ReleaseSemaphore(&lock);
    return DESTROYED;
  }
  // OK, we now own the lock
  return OK;
}

////////////////////////////////////////////////////////////////////////////////

sint32 Lockable::tryReadOnlyLock()
{
  // If the destructor has gotten past stage 1, the destroyed flag is set.
  // We must check this first and exit immediately if it is found to be set.
  if (destroyed) {
    return DESTROYED;
  }
  if (AttemptSemaphoreShared(&lock)) {
    // If we have obtained te semaphore, it might be that the destructor
    // is now midway having flagged the destruction and waiting for all
    // the other threads to release their locks again.
    if (destroyed) {
      ReleaseSemaphore(&lock);
      return DESTROYED;
    }
    // OK, we now own the lock
    return OK;
  }
  else {
    // someone else has a lock already
    return ALREADYLOCKED;
  }
}

////////////////////////////////////////////////////////////////////////////////

sint32 Lockable::waitReadOnlyLock()
{
  // If the destructor has gotten past stage 1, the destroyed flag is set.
  // We must check this first and exit immediately if it is found to be set.
  if (destroyed) {
    return DESTROYED;
  }
  ObtainSemaphoreShared(&lock);
  if (destroyed) {
    // If we have obtained te semaphore, it might be that the destructor
    // is now midway having flagged the destruction and waiting for all
    // the other threads to release their locks again.
    ReleaseSemaphore(&lock);
    return DESTROYED;
  }
  // OK, we now own the lock
  return OK;
}

////////////////////////////////////////////////////////////////////////////////

sint32 Lockable::pending()
{
  if (destroyed) {
    return DESTROYED;
  }
  return lock.ss_NestCount - lock.ss_QueueCount - 1;
}

////////////////////////////////////////////////////////////////////////////////

void Lockable::freeLock()
{
  if (!destroyed) {
    ReleaseSemaphore(&lock);
  }
}

////////////////////////////////////////////////////////////////////////////////

sint32 Lockable::active()
{
  if (destroyed) {
    return DESTROYED;
  }
  return lock.ss_NestCount;
}


////////////////////////////////////////////////////////////////////////////////

Threaded* Lockable::getExclusiveOwner()
{
  if (!destroyed) {
    if (lock.ss_Owner==Threaded::rootThread) {
      return Thread::getMain();
    }
    else if (lock.ss_Owner) {
      Threaded* thread = (Threaded*)(lock.ss_Owner->tc_UserData);
      if (thread && thread->classID == Threaded::IDTAG) {
        return thread;
      }
    }
  }
  return 0;
}

////////////////////////////////////////////////////////////////////////////////

Lockable::Lockable() : destroyed(false)
{
  InitSemaphore(&lock);
}

////////////////////////////////////////////////////////////////////////////////

Lockable::~Lockable()
{
  // protect against the side effects of multiple deletion. Altough that itself
  // is a major programmer error, allowing it to go beyond upsetting the allocator
  // is not a good idea :-)
  if (!destroyed) {
    // phase 1 - get an exclusive lock and set the destroyed flag then release
    ObtainSemaphore(&lock);
    destroyed = true;
    ReleaseSemaphore(&lock);
    // From this point on, all user calls to lock an object will fail.
    // Pending locks will awaken in order of their queue position only to
    // find the object is due for destruction and will immediately
    // relinquish any lock they obtain, returning an error.

    // phase 2 - wait to get an exclusive lock then release
    ObtainSemaphore(&lock);
    ReleaseSemaphore(&lock);

    // This causes the destructor to pause again until it can get an
    // exclusive lock on the semaphore. In the meantime, all the other
    // threads that were pending will have aborted their calls, informing
    // the callers the object is going to get deleted. Waiting in this
    // fashion ensures that whilst this process takes place, the object
    // itself is not yet deleted, otherwise you would end up with references
    // to the newly freed memory in the processing of the other calls.
  }
}

////////////////////////////////////////////////////////////////////////////////

