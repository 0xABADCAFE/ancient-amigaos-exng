//****************************************************************************//
//**                                                                        **//
//** File:         include/utilitylib/poll.hpp                              **//
//** Description:  Polling services                                         **//
//** Comment(s):                                                            **//
//** Library:      utilitylib                                               **//
//** Created:      2004-02-01                                               **//
//** Updated:      2004-02-01                                               **//
//** Author(s):    Karl Churchill                                           **//
//** Note(s):                                                               **//
//** Copyright:    (C)1996-2004, eXtropia Studios                           **//
//**               Serkan YAZICI, Karl Churchill                            **//
//**               All Rights Reserved.                                     **//
//**                                                                        **//
//****************************************************************************//

#ifndef _EXTROPIA_UTILITYLIB_POLL_HPP
#define _EXTROPIA_UTILITYLIB_POLL_HPP

#include <systemlib/thread.hpp>
#include <utilitylib/list.hpp>

////////////////////////////////////////////////////////////////////////////////
//
//  Polling
//
////////////////////////////////////////////////////////////////////////////////

/*
class Poll;

class Pollable : public Lockable {
  friend class Poll;

  private:
    sint32 ok;

  protected:
    virtual sint32 poll() = 0;

  public:
    sint32  setContReturn(sint32 okVal) {
      sint32 r = ok;
      ok = okVal;
      return r;
    }

    sint32  getContReturn() { return ok; }

  protected:
    Pollable(sint32 okVal=OK) : Lockable(), ok(okVal) {}

  public:
    virtual ~Pollable() {}
};

class Poll : public Threadable {
  private:
    MilliClock    timer;
    uint32        period;
    RefList<Poll>  jobs;
  protected:
    sint32        run();
  public:
    sint32        add(Pollable* p);
    sint32        remove(Pollable* p);
};
*/

#endif