//****************************************************************************//
//**                                                                        **//
//** File:         include/systemlib/thread.hpp                             **//
//** Description:  Multithreading services                                  **//
//** Comment(s):   Stub header                                              **//
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

#ifndef _EXTROPIA_SYSTEMLIB_THREAD_HPP
#define _EXTROPIA_SYSTEMLIB_THREAD_HPP

#include <systemlib/timer.hpp>

////////////////////////////////////////////////////////////////////////////////
//
//  Native classes
//
////////////////////////////////////////////////////////////////////////////////

class Threaded;

/*
  Threaded service class

  Allows an object to have its own thread of exection running within the
  context of the object. The internal thread may not outlive the lifespan of
  the object which spawned it.

  Constructors
    protected Threaded()

  Destructor
    protected virtual ~Threaded()
      The destructor will waits upon the internal thread to complete before
      finalizing the object.

  Public Constants

    Return Constants
      REMOVE
      WAKECALL
      USERBREAK
      TRIGGERSIGNAL
      TIMEOUT
      SLEEPABORTED
      UNKNOWN
      ERR_STARTUP
      ERR_ACCESS
      ERR_NOTRUNNING
      ERR_ALREADYRUNNING
      ERR_UNWAKEABLE
      ERR_UNKNOWNTHREAD

    Typedef'd Constants
      Priority
        PRI_MINIMUM
        PRI_BACKGROUND
        PRI_LOW
        PRI_BELOWNORMAL
        PRI_NORMAL
        PRI_ABOVENORMAL
        PRI_HIGH
        PRI_REALTIME
        PRI_MAXIMUM
        PRI_DEFAULT

    Other Constants
      STACK_MINIMUM
      STACK_MAXIMUM
      STACK_DEFAULT

  Public Methods

    bool hasStarted()
      Checks if the thread has been started.

      Return value                Signifies

      true                        The thread has been started (but may have
                                  already completed).
      false                       The thread has not been started.

    bool hasCompleted()
      Checks if the thread has completed.

      Return value                Signifies

      true                        The thread completed and removed itself.
      false                       The thread has not yet completed.

    bool isSleeping()
      Checks if the thread is currently in the idle state.

      Return value                Signifies

      true                        The thread is currently idle.
      false                       The thread is not currently idle.

    bool isRunning()
      Checks if the thread is currently running (not idle).

      Return value                Signifies

      true                        The thread is currently running.
      false                       The thread is currently idle or has not been
                                  started.

    sint32 getRetVal()
      Obtains the value returned by the internal threads return from run().
      The value returned is meaningless if the thread has not yet completed.

      Return value                Signifies

      signed integer              The value returned from run().

    const char* getName()
      Returns the name assigned to the thread when it was started.

      Return value                Signifies

      char*                       The name assigned to the started thread or 0
                                  if not yet started or no name was assigned.

    Threaded::Priority getPriority()
      Returns the priority assigned to the thread.

      Return value                Signifies

      Threaded::Priority        The priority assigned to the thread when
                                  it was started or on the last call to
                                  setPriority().

    Time& getUptime()
      Returns the Time the thread has spent in its run() method. This value
      is increasing the whole time from the point start() was called to the
      point stop() has sucessfully shut down the thread. After the thread
      has been shut down, the value represents the time after which the run()
      method returned.
      The timer is reset each time the thread is started on a successful call
      to start().
      For performance reasons, a reference to the internal timestamp is returned.

      Return value                Signifies

      Time&                       Elapsed time spent in run() method expressed
                                  as a Time object.


    sint32 start(const char* name, Priority pri, size_t stack)
      Attempts to launch the internal thread.

      Parameter                   Signifies

      const char* name            Assigns a name to the internal thread.
                                  Defaults to 0.
      Threaded::Priority pri    Assigns the priority of the internal thread.

    sint32 stop()
      Signals the exit condition for the internal thread. Any wait state is
      interrupted and the shutdown flag is set. The internal thread, if
      executing a loop must poll shutDownReq() which will return true in this
      case. The stop method may only be called by exterbal threads and will
      cause the caller to wait until the internal thread has completed its
      call to run().

      Return value                Signifies

      OK                          The thread was succesfully terminated.
      Threaded::ERR_NOTRUNNING  The internal thread was not running.
      Threaded::ERR_ACCESS      The internal thread attempted to stop()
                                  itself.

    sint32 wake()
      Signals the internal thread to waken after it has gone idle(). Calling
      wake() when the thread is not idle is legal.

      Return value                Signifies

      OK                          The signal was succecfully sent.
      Threaded::ERR_UNWAKEABLE  The idle state is ignoring the wake call.
      Threaded::ERR_NOTRUNNING  The internal thread was not running.
      Threaded::ERR_ACCESS      The internal thread attempted to stop()
                                  itself.

  Protected Interface

    virtual sint32 run() [pure]
      This method must be overriden by the subclass. It provides the entry
      point for the internally running thread. Natural exit of the thread is
      by return from this method. The return value is passed back to the class.

      Return value                Signifies

      sint32                      Final return value from thread shutdown.


    sint32 getPriority(Threaded::Priority pri)
      Sets the priority of thread. This method is available to both the
      internal and external threads, though the internal thread may not set
      its own priority above PRI_NORMAL.

      Warning : Priorities above PRI_NORMAL may take precedence over other
                operating system activites and are NOT reccommended for
                general useage.

      Parameter                   Signifies

      Threaded::Priority pri    The new priority level.

        PRI_MINIMUM               Absolute minimum priority supported by the OS.
        PRI_BACKGROUND            Very low priority, suitable for background
                                  or very time consuming processes.
        PRI_LOW                   Low priority, suitable for background processes.
        PRI_BELOWNORMAL           Below average priority.
        PRI_NORMAL                Normal priority, suitable for most normal
                                  processes.
        PRI_ABOVENORMAL           Higher priority, suitable for processes that
                                  spend much time in the sleep() state but also
                                  need to respond quickly to events.
        PRI_HIGH                  High priority, suitable only for processes that
                                  must be serviced in a short timeframe.
        PRI_REALTIME              Very high priority, suitable for top level
                                  handler type applications that must have a
                                  realtime response level to activities
        PRI_MAXIMUM               Absolute maximum priority supported by the OS.
        PRI_DEFAULT               The default priority, equivalent to PRI_NORMAL.

      Return value                Signifies

      OK                          The new priority was successfuly set.
      Threaded::ERR_NOTRUNNING  The internal thread was not running.
      ERR_VALUE                   When called by the internal thread, a
                                  value above PRI_NORMAL was requested.


    sint32 sleep(uint32 millis, bool ignoreBreak, bool ignoreWake, bool abortReq)
      This method is reserved for the internally running thread. It suspends
      the thread for a set time and/or until a certian trigger signal is
      generated.

      Parameter                   Signifies

      uint32 millis               The number of milliseconds to wait. A value of
                                  zero results in an infinite pause.
      bool ignoreBreak            If true, the thread will ignore attempts to
                                  interrupt the idle state via system CTRL-C
                                  signals.
      bool ignoreWake             If true, the thread will ignore attempts to
                                  interrupt the idle state via the wake() method.
      bool abortReq               If true, the thread will discard any remaining
                                  idle delay time if it is interrupted early.
      Return value                Signifies

      Threaded::ERR_ACCESS      Method was not called by the internal thread.
      Threaded::REMOVE          The idle state was interrupted by stop().
      Threaded::USERBREAK       The idle state was interrupted by CTRL-C.
      Threaded::WAKECALL        The idle state was interrupted by wake().
      Threaded::TIMEOUT         The idle state expired naturally.
      Threaded::UNKNOWN         The idle state was interrupted by an unknown
                                  event (typically an OS specific event).
                                  This return should be consideres exeptional.

    sint3 sleepResume()
      This method is reserved for the internally running thread. It returns
      to the idle state after a call to sleep() was interrupted before it
      expired. The ignore break / wake options used in the previous call to
      sleep() are maintained.

      Return value                Signifies

      Threaded::ERR_ACCESS      Method was not called by the internal thread.
      Threaded::REMOVE          The idle state was interrupted by stop().
      Threaded::USERBREAK       The idle state was interrupted by CTRL-C.
      Threaded::WAKECALL        The idle state was interrupted by wake().
      Threaded::TIMEOUT         The idle state expired naturally.
      Threadabke::SLEEPABORTED    The original delay request was discarded.
      Threaded::UNKNOWN         The idle state was interrupted by an unknown
                                  event (typically an OS specific event).
                                  This return should be consideres exeptional.

    void sleepAbort()
      Aborts any pending delay after an interrupt of the idle state. After this
      call, attempts to sleepResume() will fail.

    bool shutDownReq()
      Checks if the thread has been requested to exit via a call to stop().
      Any endlessly looping code executed by the internal thread is required
      to test this condition at some point within the loop to ensure that the
      thread can safely exit. The Threaded object will always wait for
      the internal thread to exit before it can be destroyed.

      Return value                Signifies

      true                        The thread has been asked to remove itself
                                  via a call to stop() or the destructor.
      false                       The thread has not been asked to remove
                                  itself.
*/


class Thread;
/*
  Thread class

  Provides a public interface to Threaded properties of the currently executing
  thread outside the context of the Threaded object itself.

  Public methods

    static sint32 num()
      Returns the number of currently created Threaded threads. Native
      threads not encapsulated by Threaded are not included in the count.

      Return value                Signifies

      sint32                      Number of Threaded derived threads.

    static sint32 numIdle()
      Returns the number of currently created Threaded threads that are
      idle. Native threads not encapsulated by Threaded are not included
      in the count.

      Return value                Signifies

      sint32                      Number of Threaded derived idle threads.

    static sint32 numActive()
      Returns the number of currently created Threaded threads that are
      active and running. Native threads not encapsulated by Threaded are
      not included in the count.

      Return value                Signifies

      sint32                      Number of Threaded derived active threads.

    static Threaded* getCurrent()
      Returns a pointer to the Threaded object encapsulating the currently
      executing thread (that which called the function).

      Return value                Signifies

      Threaded*                 Pointer to current Threaded derived thread
                                  or 0 if calling thread not derived from
                                  Threaded class.

    static Threaded* getMain()
      Returns a pointer to the Threaded object encapsulating the main thread,
      defined as the thread that executed main().

      Return value                Signifies

      Threaded*                 Pointer to main Threaded derived thread.

    static bool userBreak()
      Tests if a user break (CTRL C) has been generated for the current thread.

      Return value                Signifies

      true                        CTRL-C signal was generated.
      false                       CTRL-C signal has not been generated.

    static sint32 sleep(uint32 ms, bool ignoreBreak, bool ignoreWake, bool abortReq)
      This inkoves the sleep() method for the currently executing Threaded thread.

      Parameter                   Signifies

      [See Threaded::sleep()]

      Return value                Signifies

      [See Threaded::sleep()]
      Threaded::ERR_ACCESS      The thread calling sleep() is not encapsulated
                                  by a Threaded object.

    static sint32 sleepResume()
      This invokes the sleepResume() method for the currently executing Threaded
      thread.

      Return value                Signifies

      [See Threaded::sleep()]
      Threaded::ERR_ACCESS      The thread calling sleepResume() is not
                                  encapsulated by a Threaded object.

    static void sleepAbort()
      This invokes the sleepAbort() method for the currently executing Threaded
      thread.

    Time& getUptime()
      This invokes the getUptime() method for the currently executing Threaded
      thread.

      If the currently executing thread is not a Threaded thread, a Time value
      of zero is returned. For performance reasons, a reference to the threads internal
      timestamp is returned.

      Return value                Signifies
      [See Threaded::getUptime]

*/

class Lockable;
/*
  Lockable service class

  Thread aware locking service. Both read-only (shared) and read/write locks
  (exclusive) are possible on the object.

  Read-only locks are sharable in that several threads may have access
  simultaneously. A read-only lock on the object is only possible when there
  is no existing read/write lock on the object.

  Read/write locks are always exclusive and are only possible when all shared
  locks are reeased. The sole exception to this behaviour is when a single
  read-only lock is held by the same thread attempting the read/write lock.

  Both forms of locking can be tried or waited upon. Trying to obtain a lock
  always returns immediately. Waiting for a lock will suspend the calling
  thread until the lock is granted or the object is destroyed. All waiting
  lock requests are held in a queue.

  Constructors
    protected Lockable()

  Destructor
    protected virtual ~Lockable()
      Once invoked, the destructor waits to get an exclusive lock on the
      object. It then cancels any pending locks requested since, causing those
      threads waiting for access to be awakened and an error return from their
      attempts to lock the object.

  Public Constants

    Return Constants
      ALREADYLOCKED
      INVALIDOWNER
      DESTROYED

  Public Methods

    sint32 tryLock()
      Attempts to obtain a read/write (exclusive lock). Returns immediately.

      Return values             Singifies

      OK                        Exlusive lock was obtained
      Lockable::ALREADYLOCKED   Object is already locked
      Lockable::DESTROYED       Object is undergoing destruction

    sint32 tryReadOnlyLock()
      Attempts to obtain a read only lock. Returns immediately

      Return values             Signifies

      OK                        Exlusive lock was obtained
      Lockable::ALREADYLOCKED   Object is already locked
      Lockable::DESTROYED       Object is undergoing destruction

    sint32 waitLock()
      Attempts to obtain a read/write (exclusive lock). Returns immediately
      if the lock was granted or the object is undergoing destruction. In
      any other event, the calling thread is suspended until either of the
      above conditions are met.

      Return values             Signifies

      OK                        Exlusive lock was obtained
      Lockable::ALREADYLOCKED   Object is already locked
      Lockable::DESTROYED       Object is undergoing destruction

    sint32 waitReadOnlyLock()
      Attempts to obtain a read only lock. Returns immediately if the lock
      was granted or the object is undergoing destruction. In any other event,
      the calling thread is suspended until either of the above conditions are
      met. Waiting is incumbent only upon the release of a read/write lock.

      Return values             Signifies

      OK                        Exlusive lock was obtained
      Lockable::ALREADYLOCKED   Object is already locked
      Lockable::DESTROYED       Object is undergoing destruction

    sint32 pending()
      Returns the number of lock requests currently queued on the object.

      Return values             Signifies

      Positive integer          Number of lock requests currently pending
      Lockable::DESTROYED       Object is undergoing destruction

    sint32 active()
      Returns the number of number of locks currently active on the object.

      Positive integer          Number of lock requests currently active
      Lockable::DESTROYED       Object is undergoing destruction

    void freeLock()
      Releases a lock on the object. Calling this method without currently
      owning a lock on the object is illegal.

    Threaded* getExclusiveOwner()
      Returns a pointer to the thread that currently has an exclusive lock
      on the object.
*/

#if defined(XP_AMIGAOS3_68K)
  #include "plat/amigaos3_68k/systemlib/thread.hpp"
#elif defined(XP_AMIGAOS3_PPC)
  #include "plat/amigaos3_wos/systemlib/thread.hpp"
#elif defined(XP_AMIGAOS4)
  #include "plat/amigaos4/systemlib/thread.hpp"
#elif defined(XP_AROS_BE)
  #include "plat/aros_be/systemlib/thread.hpp"
#elif defined(XP_AROS_LE)
  #include "plat/aros_le/systemlib/thread.hpp"
#elif defined(XP_MORPHOS)
  #include "plat/morphos/systemlib/thread.hpp"
#elif defined(XP_LINUX_PPC)
  #include "plat/linux_ppc/systemlib/thread.hpp"
#elif defined(XP_LINUX_X86)
   #include "plat/linux_x86/systemlib/thread.hpp"
#elif defined(XP_WIN9X)
   #include "plat/win9x/systemlib/thread.hpp"
#elif defined(XP_WIN2K)
  #include "plat/win2k/systemlib/thread.hpp"
#elif defined(XP_MACOSX)
  #include "plat/macosx/systemlib/thread.hpp"
#else
  #error "Platform implementation not defined"
#endif

// Auxilliary classes for making methods 'synchronized'

class Lock {
  public:
    Lock(Lockable* l) : lockable(0)
    {
      if (l->waitLock()==OK)
        lockable=l;
    }

    ~Lock()
    {
      if (lockable)
        lockable->freeLock();
    }

  private:
    Lockable* lockable;
};

class ReadOnlyLock {
  public:
    ReadOnlyLock(Lockable* l) : lockable(0)
    {
      if (l->waitReadOnlyLock()==OK)
        lockable=l;
    }

    ~ReadOnlyLock()
    {
      if (lockable)
        lockable->freeLock();
    }

  private:
    Lockable* lockable;
};

#endif