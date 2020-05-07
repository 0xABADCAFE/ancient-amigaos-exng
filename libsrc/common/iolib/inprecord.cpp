//****************************************************************************//
//**                                                                        **//
//** File:         libsrc/common/iolib/inprecord.cpp                        **//
//** Description:  Input device classes                                     **//
//** Comment(s):                                                            **//
//** Library:      iolib                                                    **//
//** Created:      2003-02-18                                               **//
//** Updated:      2003-02-20                                               **//
//** Author(s):    Karl Churchill                                           **//
//** Note(s):                                                               **//
//** Copyright:    (C)1996-2003, eXtropia Studios                           **//
//**               Serkan YAZICI, Karl Churchill                            **//
//**               All Rights Reserved.                                     **//
//**                                                                        **//
//****************************************************************************//

#include <iolib/inprecord.hpp>

#include <new.h>

////////////////////////////////////////////////////////////////////////////////
//
//  SimpleEventRecorder
//
////////////////////////////////////////////////////////////////////////////////

SimpleEventRecorder::~SimpleEventRecorder()
{
  close();
}

////////////////////////////////////////////////////////////////////////////////

void SimpleEventRecorder::timeStamp()
{
  Time t = eventTimer.elapsed();
  eventFile->writeText("%03lu:%02lu:%02lu:%02lu:%03lu ",
  t.days(), t.hours(), t.mins(), t.secs(), t.millis());
}

////////////////////////////////////////////////////////////////////////////////

void SimpleEventRecorder::keyPressNonPrintable(I_SRC, Key::CtrlKey code)
{
  if (eventFile) {
    timeStamp();
    eventFile->writeText("%08X %ld\n%ld\n",
      (src->getIDKey()).value(), SimpleEvent::KEY_PRESS_NONPRINTABLE,
      code);
  }
}

////////////////////////////////////////////////////////////////////////////////

void SimpleEventRecorder::keyReleaseNonPrintable(I_SRC, Key::CtrlKey code)
{
  if (eventFile) {
    timeStamp();
    eventFile->writeText("%08X %ld\n%ld\n",
      (src->getIDKey()).value(), SimpleEvent::KEY_RELEASE_NONPRINTABLE,
      code);
  }
}

////////////////////////////////////////////////////////////////////////////////

void SimpleEventRecorder::keyPressPrintable(I_SRC, sint32 ch)
{
  if (eventFile) {
    timeStamp();
    eventFile->writeText("%08X %ld\n%c\n",
      (src->getIDKey()).value(), SimpleEvent::KEY_PRESS_PRINTABLE,
      ch);
  }
}

////////////////////////////////////////////////////////////////////////////////

void SimpleEventRecorder::keyReleasePrintable(I_SRC, sint32 ch)
{
  if (eventFile) {
    timeStamp();
    eventFile->writeText("%08X %ld\n%c\n",
      (src->getIDKey()).value(), SimpleEvent::KEY_RELEASE_PRINTABLE,
      ch);
  }
}

////////////////////////////////////////////////////////////////////////////////

void SimpleEventRecorder::mousePress(I_SRC, uint32 code)
{
  if (eventFile) {
    timeStamp();
    eventFile->writeText("%08X %ld\n%lu\n",
      (src->getIDKey()).value(), SimpleEvent::MOUSE_PRESS,
      code);
  }
}

////////////////////////////////////////////////////////////////////////////////

void SimpleEventRecorder::mouseRelease(I_SRC, uint32 code)
{
  if (eventFile) {
    timeStamp();
    eventFile->writeText("%08X %ld\n%lu\n",
      (src->getIDKey()).value(), SimpleEvent::MOUSE_RELEASE,
      code);
  }
}

////////////////////////////////////////////////////////////////////////////////

void SimpleEventRecorder::mouseMove(I_SRC, sint16 x, sint16 y, sint16 dx, sint16 dy)
{
  if (eventFile) {
    timeStamp();
    eventFile->writeText("%08X %ld\n%hd %hd %hd %hd\n",
      (src->getIDKey()).value(), SimpleEvent::MOUSE_MOVE,
      x, y, dx, dy);
  }
}

////////////////////////////////////////////////////////////////////////////////

void SimpleEventRecorder::mouseDrag(I_SRC, sint16 x, sint16 y, sint16 dx, sint16 dy, uint32 s)
{
  if (eventFile) {
    timeStamp();
    eventFile->writeText("%08X %ld\n%hd %hd %hd %hd %lu\n",
      (src->getIDKey()).value(), SimpleEvent::MOUSE_DRAG,
      x, y, dx, dy, s);
  }
}

////////////////////////////////////////////////////////////////////////////////

void SimpleEventRecorder::mouseScroll(I_SRC, sint16 dx, sint16 dy)
{
  if (eventFile) {
    timeStamp();
    eventFile->writeText("%08X %ld\n%hd %hd\n",
      (src->getIDKey()).value(), SimpleEvent::MOUSE_SCROLL,
      dx, dy);
  }
}

////////////////////////////////////////////////////////////////////////////////

void SimpleEventRecorder::exitEvent(I_SRC)
{
  if (eventFile) {
    timeStamp();
    eventFile->writeText("%08X %ld\n",
      (src->getIDKey()).value(), SimpleEvent::EXIT_EVENT);
  }
}

////////////////////////////////////////////////////////////////////////////////

sint32 SimpleEventRecorder::open(const char* fileName)
{
  if (!fileName)
    return ERR_PTR_ZERO;
  if (eventFile)
    return IOS::ERR_FILE_OPEN;
  if (!(eventFile = new(nothrow) StreamOut(fileName, true, false)))
    return IOS::ERR_FILE_CREATE;
  if (eventFile->valid()==false) {
    delete eventFile;
    eventFile = 0;
    return IOS::ERR_FILE_CREATE;
  }
  eventTimer.set();
  eventFile->writeText("***SimpleEventRecorder\n");
  return OK;
}

////////////////////////////////////////////////////////////////////////////////

void SimpleEventRecorder::close()
{
  if (eventFile) {
    eventFile->writeText("***End\n");
    delete eventFile;
    eventFile = 0;
  }
}

////////////////////////////////////////////////////////////////////////////////
//
//  SimpleEventPlayer
//
////////////////////////////////////////////////////////////////////////////////
/*
SimpleEventPlayer::~SimpleEventPlayer()
{
  close();
}
*/
