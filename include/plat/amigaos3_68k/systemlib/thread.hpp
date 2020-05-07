//****************************************************************************//
//**                                                                        **//
//** File:         include/plats/amigaos3_68k/systemlib/thread.hpp          **//
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

#ifndef _EXTROPIA_SYSTEMLIB_THREAD_NATIVE_HPP
#define _EXTROPIA_SYSTEMLIB_THREAD_NATIVE_HPP

namespace X_SYSNAME {
  extern "C" {
    #include <proto/dos.h>            // IO
    #include <dos/dostags.h>          // Process
  }
};

class Runnable {
  protected:
    virtual sint32 run() = 0;
};

////////////////////////////////////////////////////////////////////////////////
//
//  Threaded
//
//  Multithreading service.
//
////////////////////////////////////////////////////////////////////////////////

class Threaded : public Runnable {

  public:
    enum {
      // return error constants
      ERR_STARTUP          = -1,
      ERR_ACCESS          = -2,
      ERR_NOTRUNNING      = -3,
      ERR_ALREADYRUNNING  = -4,
      ERR_UNWAKEABLE      = -5,
      ERR_UNKNOWNTHREAD    = -6,
      // sleep()/sleepResume() return constants
      REMOVE              = 0,
      WAKECALL            = 1,
      USERBREAK            = 2,
      TRIGGERSIGNAL        = 3,
      TIMEOUT              = 4,
      SLEEPABORTED        = 5,
      UNKNOWN              = 6,
      // other limits
      STACK_MINIMUM        = 2048,
      STACK_MAXIMUM        = 1048576,
      STACK_DEFAULT        = 4096
    };

    typedef enum {
      // thread priority levels
      PRI_DEFAULT          = 0,
      PRI_MINIMUM          = 1,
      PRI_BACKGROUND      = 2,
      PRI_LOW              = 3,
      PRI_BELOWNORMAL      = 4,
      PRI_NORMAL          = 5,
      PRI_ABOVENORMAL      = 6,
      PRI_HIGH            = 7,
      PRI_REALTIME        = 8,
      PRI_MAXIMUM          = 9
    } Priority;


  public:
    bool        hasStarted()    const { return state & SPAWNED; }
    bool        hasCompleted()  const { return state & COMPLETED; }
    bool        isSleeping()    const { return hasStarted() && (state & SLEEPING); }
    bool        isRunning()     const {
      return hasStarted() && (!hasCompleted()) && ((state & SLEEPING)==0);
    }
    Priority    getPriority()    const { return (Priority)priority; }
    const Time& getUptime();
    sint32      getRetVal()      const { return retVal; }
    const char*  getName()        const { return name; }

    sint32 start(const char* n=0, Priority p=PRI_DEFAULT, size_t s=STACK_DEFAULT);
    sint32 stop();
    sint32 wake();

  protected:
    sint32  sleep(uint32 ms, bool ignBrk, bool ignWk, bool abrtRq);
    sint32  sleepResume();
    void    sleepAbort();
    bool    shutDownReq()  { return (state & SHUTDOWN)==SHUTDOWN; }

    sint32  setPriority(Priority p);

    Threaded();
    virtual ~Threaded();


  private:
    // IdleTimer class, used for interruptable timed delays
    class IdleTimer {
      public:
        bool      init();
        void      done();
        uint32    suspend(uint32 millis, uint32 trigger);
        uint32     suspend();
        uint32    getTimerSignal()  const { return timerSignal; }
        uint32    getReqSignal()     const { return req; }
        void      abortDelay();

        IdleTimer() :timerPort(0), timerIO(0), timerSignal(0), req(0), flags(0) {}
        ~IdleTimer() { }

      private:
        enum {
          PORT_FAIL  = 0x00000001,
          IORQ_FAIL = 0x00000002,
          OPDV_FAIL = 0x00000004,
          IORQ_USED = 0x00000008,
          IORQ_4EVR  = 0x00000010,
          IORQ_PNDG  = 0x00000020,
        };
        X_SYSNAME::MsgPort*          timerPort;
        union {
          X_SYSNAME::IORequest*      timerIO;
          X_SYSNAME::timerequest*    timerReq;
        };
        uint32            timerSignal;
        uint32            req;
        uint32            flags;
    };

    enum {
      // flags
      SPAWNED        = 0x00000001,
      STARTERROR    = 0x00000002,
      COMPLETED      = 0x00000004,
      SHUTDOWN      = 0x00000008,
      SLEEPING      = 0x00000010,
      IGNOREWAKE    = 0x00000020,
      IGNOREBREAK    = 0x00000040,
      ABORTREQ      = 0x00000080,

      // id (used to differentiate Threaded tasks from ordinary tasks)
      IDTAG          = 0x58534C54,

      // predefined system signals used by Threaded
      SIGNAL_BREAK  = SIGBREAKF_CTRL_C, // Normal CTRL-C break
      SIGNAL_WAKE    = SIGBREAKF_CTRL_D,  // wake()
      SIGNAL_REMV    = SIGBREAKF_CTRL_E,  // stop()
      SIGNAL_SYNC    = SIGBREAKF_CTRL_F  // internal sync
    };

    static sint32            threadCnt;
    static sint32            threadsIdle;
    static X_SYSNAME::Task*  rootThread;
    static sint16            priTab[10];

    uint32                  classID;
    X_SYSNAME::Task*        external;
    X_SYSNAME::Process*      internal;
    size_t                  stackSize;
    sint16                  priority;
    uint16                  state;
    sint32                  retVal;
    IdleTimer                sleeper;
    Clock                    uptime;
    char                    name[16];

    static void entryPoint();
    static void exitPoint();


  friend class Thread;
  friend class MainThread;
  friend class Lockable;
  friend class ThreadedImplementor;
};

class ThreadedImplementor {
  protected:
    static uint32 waitForSignals(Threaded* thread, uint32 signals);
};

////////////////////////////////////////////////////////////////////////////////
//
//  Thread
//
//  Interface for Threaded access to current and main threads.
//
////////////////////////////////////////////////////////////////////////////////

class Thread {
  public:
    static sint32        num()            { return Threaded::threadCnt; }
    static sint32        numIdle()        { return Threaded::threadsIdle; }
    static sint32        numActive()      { return num() - numIdle(); }
    static Threaded*    getCurrent();
    static Threaded*    getMain();
    static bool          userBreak();
    static sint32        sleep(uint32 ms, bool ignBrk=true, bool ignWk=false,
                              bool abrtRq=false);
    static sint32        sleepResume();
    static void          sleepAbort();
    static const Time&  getUptime();
};

////////////////////////////////////////////////////////////////////////////////
//
//  Lockable
//
//  Shared access control service.
//
////////////////////////////////////////////////////////////////////////////////

class Lockable {
  public:
    enum {
      ALREADYLOCKED  = -1,
      INVALIDOWNER  = -2,
      DESTROYED      = -3
    };
    sint32    tryLock();
    sint32    tryReadOnlyLock();
    sint32    waitLock();
    sint32    waitReadOnlyLock();
    sint32    pending();
    sint32    active();
    void      freeLock();
    Threaded*  getExclusiveOwner();

  protected:
    Lockable();
    virtual ~Lockable();

  private:
    X_SYSNAME::SignalSemaphore  lock;
    bool destroyed;
};


#endif