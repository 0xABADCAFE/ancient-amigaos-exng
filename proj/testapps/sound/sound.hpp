//****************************************************************************//
//**                                                                        **//
//** File:                                                                  **//
//** Description:                                                           **//
//** Comment(s):                                                            **//
//** Created:      2003-02-08                                               **//
//** Updated:      2004-02-12                                               **//
//** Author(s):    Karl Churchill                                           **//
//** Note(s):                                                               **//
//** Copyright:    (C)1996-2004, eXtropia Studios                           **//
//**               Serkan YAZICI, Karl Churchill                            **//
//**               All Rights Reserved.                                     **//
//**                                                                        **//
//****************************************************************************//


#ifndef _SOUNDLIB_MXR_HPP_
#define _SOUNDLIB_MXR_HPP_
#include <xbase.hpp>
#include <systemlib/thread.hpp>


namespace X_SYSNAME {
#include <exec/exec.h>
#include <devices/ahi.h>
#include <proto/ahi.h>
}

class SoundMixer : protected Threaded {
  private:
    static const sint32 bytesPerSample = 2*sizeof(sint16);

    Console*            debug;
    size_t              bufferSize;
    uint32              mixFreq;
    void*                data;
    uint32              flags;
    uint32              ahiSignal;
    X_SYSNAME::MsgPort*  ahiMP;
    union {
      X_SYSNAME::AHIRequest*  ahi;
      X_SYSNAME::IORequest*    io;
      void* any;
    } req[2];
    sint16*              pcm[2];
    sint16              ahiDev;
    uint16              ahiUnit;

    enum {
      IO_USED = 0x00000001,
      IO_BRK  = 0x80000000
    };

  protected sint32 run();

  public:
    void close();
    sint32 open();

    sint32 test(sint32 num);

    SoundMixer();
    virtual ~SoundMixer();
};

#endif