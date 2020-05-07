//****************************************************************************//
//**                                                                        **//
//** File:         libsrc/plat/amigaos3_68k/iolib/stream.cpp                **//
//** Description:  Buffered file IO classes                                 **//
//** Comment(s):                                                            **//
//** Library:      iolib                                                    **//
//** Created:      2003-02-10                                               **//
//** Updated:      2003-02-10                                               **//
//** Author(s):    Karl Churchill                                           **//
//** Note(s):                                                               **//
//** Copyright:    (C)1996-2003, eXtropia Studios                           **//
//**               Serkan YAZICI, Karl Churchill                            **//
//**               All Rights Reserved.                                     **//
//**                                                                        **//
//****************************************************************************//

#include <iolib/fileio.hpp>

using namespace X_SYSNAME;

////////////////////////////////////////////////////////////////////////////////
//
//  AsyncStreamBuffer
//
////////////////////////////////////////////////////////////////////////////////

void AsyncStreamBuffer::sendPacket(void* p)
{
  packet.sp_Pkt.dp_Port = &packetPort;
  packet.sp_Pkt.dp_Arg2 = (sint32)p;
  PutMsg(handler, &packet.sp_Msg);
  flags |= WAIT_PACKET;
}

////////////////////////////////////////////////////////////////////////////////

sint32 AsyncStreamBuffer::waitPacket()
{
  if (flags & WAIT_PACKET) {
    while (true) {
      packetPort.mp_Flags = PA_SIGNAL;
      Remove((Node*)WaitPort(&packetPort));

      // Ignore spurious crap
      packetPort.mp_Flags = PA_IGNORE;
      flags &= ~WAIT_PACKET;

      sint32 bytes = packet.sp_Pkt.dp_Res1;
      if (bytes >= 0)
        return bytes;
      // see if the user wants to try again...
      if (ErrorReport(packet.sp_Pkt.dp_Res2,REPORT_STREAM,file,0)) {
        flags &= ~FILE_GOOD;
        return ERR_RSC_UNAVAILABLE;
      }
      if (flags & FILE_READ)
        sendPacket(buffers[currentBuf]);
      else
        sendPacket(buffers[1 - currentBuf]);
    }
  }
  SetIoErr(packet.sp_Pkt.dp_Res2);
  return packet.sp_Pkt.dp_Res1;
}

////////////////////////////////////////////////////////////////////////////////

void AsyncStreamBuffer::requeuePacket()
{
  AddHead(&packetPort.mp_MsgList,&packet.sp_Msg.mn_Node);
  flags |= WAIT_PACKET;
}

////////////////////////////////////////////////////////////////////////////////

void AsyncStreamBuffer::recordSyncFailure()
{
  packet.sp_Pkt.dp_Res1 = -1;
  packet.sp_Pkt.dp_Res2 = IoErr();
  bytesLeft = 0;
  flags &= ~FILE_GOOD;
}

////////////////////////////////////////////////////////////////////////////////

sint32 AsyncStreamBuffer::create(size_t reqSize)
{
  if (!file)
    return IOS::ERR_FILE;
  if (buffers[0])
    return ERR_RSC;
  buffers[0] = Mem::alloc(reqSize, true, Mem::ALIGN_CACHE);
  if (buffers[0]) {
    FileHandle*  fh  = (FileHandle*)BADDR(file);
    handler          = fh->fh_Type;
    bufferSize      = reqSize >> 1;
    buffers[1]      = (char*)(buffers[0]) + bufferSize;
    offset          = buffers[0];
    currentBuf      = 0;
    seekOffset      = 0;
    flags &= ~WAIT_PACKET;
    // message port setup
    packetPort.mp_MsgList.lh_Head      = (Node*)&packetPort.mp_MsgList.lh_Tail;
    packetPort.mp_MsgList.lh_Tail      = 0;
    packetPort.mp_MsgList.lh_TailPred  = (Node*)&packetPort.mp_MsgList.lh_Head;
    packetPort.mp_Node.ln_Type        = NT_MSGPORT;
    packetPort.mp_Node.ln_Name        = 0;
    packetPort.mp_Flags                = PA_IGNORE;
    packetPort.mp_SigBit              = SIGB_SINGLE;
    packetPort.mp_SigTask              = FindTask(0);
    packet.sp_Pkt.dp_Link              = &packet.sp_Msg;
    packet.sp_Pkt.dp_Arg1              = fh->fh_Arg1;
    packet.sp_Pkt.dp_Arg3              = bufferSize;
    packet.sp_Pkt.dp_Res1              = 0;
    packet.sp_Pkt.dp_Res2              = 0;
    packet.sp_Msg.mn_Node.ln_Name      = (char*)&packet.sp_Pkt;
    packet.sp_Msg.mn_Node.ln_Type      = NT_MESSAGE;
    packet.sp_Msg.mn_Length            = sizeof(StandardPacket);
  }
  else
    return ERR_NO_FREE_STORE;
  return OK;
}

////////////////////////////////////////////////////////////////////////////////

void AsyncStreamBuffer::destroy()
{
  if (buffers[0]) {
    Mem::free(buffers[0]);
    buffers[0] = 0;
  }
}

////////////////////////////////////////////////////////////////////////////////

bool AsyncStreamBuffer::exists(const char* fileName)
{
  BPTR handle = Open(fileName,MODE_OLDFILE);
  if (handle) {
    Close(handle);
    return true;
  }
  return false;
}

////////////////////////////////////////////////////////////////////////////////
//
//  StreamIn
//
////////////////////////////////////////////////////////////////////////////////

StreamIn::~StreamIn()
{
  close();
}

sint32 StreamIn::processIO()
{
  sint32 bytesArrived = waitPacket();
  if (bytesArrived <= 0) {
    if (bytesArrived == 0) { // end of file reached
      flags |= FILE_ATEND;
      X_SYSNAME::SetIoErr(0);
      return EOF;
    }  else {
      flags &= ~FILE_GOOD;
      return ERR_FILE_READ;
    }
  }
  sendPacket(buffers[currentBuf^1]); // ask that the buffer be filled
  if (seekOffset > bytesArrived)
    seekOffset = bytesArrived;
  offset      = ((char*)(buffers[currentBuf])+seekOffset);
  currentBuf  ^= 1;
  bytesLeft   = bytesArrived - seekOffset;
  seekOffset  = 0;
  return OK;
}

////////////////////////////////////////////////////////////////////////////////

sint32 StreamIn::open(const char* fileName, bool textMode, size_t reqSize)
{
  if (!fileName)
    return ERR_PTR_ZERO;
  if (file)
    return ERR_FILE_OPEN;
  if (file = Open(fileName,MODE_OLDFILE)) {
    if (Seek(file, 0, OFFSET_END)>=0)
      fileSize = Seek(file, 0, OFFSET_CURRENT);
    else {
      Close(file);
      fileSize = 0;
      file = 0;
      return ERR_FILE_EMPTY;
    }
    Seek(file, 0, OFFSET_BEGINNING);
    flags |= FILE_READ;
    blockSize  = 512;
    BPTR lock = 0;
    if (lock = Lock(fileName,ACCESS_READ)) {
      ALIGNSTACKOBJ32(InfoData, infoData);
      if (Info(lock,&infoData))
        blockSize  = infoData.id_BytesPerBlock;
      UnLock(lock);
    }
    reqSize = (((reqSize + (blockSize*2) - 1) / (blockSize*2)) * (blockSize*2));
    sint32 result = create(reqSize);
    if (result == OK) {  // prefetch
      packet.sp_Pkt.dp_Type  = ACTION_READ;
      bytesLeft              = 0;
      offset                = buffers[1];
      if (handler)
        sendPacket(buffers[0]);
      flags |= FILE_GOOD;
      if (textMode)
        flags |= FILE_TEXT;
    }
    else {
      flags &= ~(FILE_ACCESS|FILE_GOOD);
      Close(file);
      file = 0;
    }
    return result;
  }
  else
    return ERR_FILE_OPEN;
}

////////////////////////////////////////////////////////////////////////////////

void StreamIn::close()
{
  if (file)
  {
    waitPacket();
    Close(file);
    destroy();
    file = 0;
    flags &= ~(FILE_ACCESS|FILE_GOOD);
  }
}

////////////////////////////////////////////////////////////////////////////////

void StreamIn::flush()
{
  if (file)
    waitPacket();
}

////////////////////////////////////////////////////////////////////////////////

sint32 StreamIn::tell()
{
  if (!file)
    return ERR_FILE_SEEK;
  sint32 bytesArrived = waitPacket();
  if (bytesArrived < 0)
    return ERR_FILE_SEEK;
  return Seek(file, 0, OFFSET_CURRENT)-(bytesLeft+bytesArrived)+seekOffset;
}

////////////////////////////////////////////////////////////////////////////////

sint32 StreamIn::seek(sint32 position, IOS::SeekMode mode)
{
  if (!file)
    return ERR_FILE_SEEK;

  sint32 bytesArrived = waitPacket();
  if (bytesArrived < 0)
    return ERR_FILE_SEEK;

  // figure out what the actual file position is
  sint32 filePos = Seek(file, 0, OFFSET_CURRENT);
  if (filePos < 0) {
    recordSyncFailure();
    return ERR_FILE_SEEK;
  }
  // figure out what the caller's file position is
  sint32 current = filePos - (bytesLeft+bytesArrived) + seekOffset;
  sint32 target;
  // figure out the absolute offset within the file where we must seek to
  if (mode == SEEKCURR) {
    target = current + position;
  }
  else if (mode == SEEKSTART) {
    target = position;
  }
  else {
    ALIGNSTACKOBJ32(FileInfoBlock, fib);
    if (!ExamineFH(file,&fib))
    {
      recordSyncFailure();
      return ERR_FILE_SEEK;
    }
    target = fib.fib_Size + position;
  }
  // figure out what range of the file is currently in our buffers
  sint32 minBuf = current-(sint32)((uint32)offset-(uint32)buffers[currentBuf^1]);
  sint32 maxBuf = current + bytesLeft + bytesArrived;  // WARNING: this is one too big
  sint32 diff = target - current;

  if ((target < minBuf) || (target >= maxBuf)) {
    sint32 roundTarget = (target / blockSize) * blockSize;
    if (Seek(file,roundTarget-filePos,OFFSET_CURRENT) < 0) {
      recordSyncFailure();
      return ERR_FILE_SEEK;
    }
    sendPacket(buffers[0]);
    seekOffset = target-roundTarget;
    bytesLeft  = 0;
    currentBuf = 0;
    offset     = buffers[1];
  }
  else if ((target < current) || (diff <= bytesLeft)) {
    requeuePacket();
    bytesLeft        -= diff;
    ((char*)offset)  += diff;
  }
  else {
     sendPacket(buffers[currentBuf^1]);
    diff        -= bytesLeft - seekOffset;
    offset      = (char*)(buffers[currentBuf]) + diff;
    bytesLeft   = bytesArrived - diff;
    seekOffset  = 0;
    currentBuf  ^= 1;
  }
  return current;
}

////////////////////////////////////////////////////////////////////////////////

sint32 StreamIn::readBytes(void* buffer, size_t n)
{
  if (!file)
    return ERR_FILE_READ;
  sint32 totalBytes = 0;
  // if we need more bytes than there are in the current buffer, enter the read
  // loop
  while (n > bytesLeft) {
    Mem::copy(buffer, offset, bytesLeft);
    n                -= bytesLeft;
    ((char*)buffer)  += bytesLeft;
    totalBytes      += bytesLeft;
    bytesLeft        = 0;
    sint32 bytesArrived = waitPacket();
    if (bytesArrived <= 0) {
      if (bytesArrived == 0) { // end of file reached
        flags |= FILE_ATEND;
        SetIoErr(0);
        return totalBytes;
      }
      return ERR_FILE_READ;
    }
    // ask that the buffer be filled
    sendPacket(buffers[currentBuf^1]);
    if (seekOffset > bytesArrived)
      seekOffset = bytesArrived;
    offset      = (char*)(buffers[currentBuf]) + seekOffset;
    currentBuf  ^= 1;
    bytesLeft   = bytesArrived - seekOffset;
    seekOffset  = 0;
  }
  Mem::copy(buffer, offset, n);
  bytesLeft        -= n;
  ((char*)offset)  += n;
  return totalBytes + n;
}

////////////////////////////////////////////////////////////////////////////////

sint32 StreamIn::read16Swap(void* buffer,size_t n)
{
  if (!file)
    return ERR_FILE_READ;
  if (((uint32)buffer|(uint32)offset)&1UL)
    return ERR_PTR;
  n <<= 1;
  sint32 totalBytes = 0;
  while (n > bytesLeft) {
    Mem::swap16(buffer, offset, (bytesLeft>>1));
    n                    -= bytesLeft;
    ((char*)buffer)      += bytesLeft;
    totalBytes          += bytesLeft;
    bytesLeft        = 0;
    sint32 bytesArrived = waitPacket();
    if (bytesArrived <= 0)
    {
      if (bytesArrived == 0)
      { // end of file reached
        flags |= FILE_ATEND;
        SetIoErr(0);
        return totalBytes>>1;
      }
      return ERR_FILE_READ;
    }
    // ask that the buffer be filled
    sendPacket(buffers[currentBuf^1]);
    if (seekOffset > bytesArrived)
      seekOffset = bytesArrived;
    offset      = (char*)(buffers[currentBuf]) + seekOffset;
    currentBuf ^= 1;
    bytesLeft   = bytesArrived - seekOffset;
    seekOffset  = 0;
  }
  Mem::swap16(buffer, offset, (n>>1));

  bytesLeft        -= n;
  ((char*)offset)  += n;
  return (totalBytes + n)>>1;
}

////////////////////////////////////////////////////////////////////////////////

sint32 StreamIn::read32Swap(void* buffer,size_t n)
{
  if (!file)
    return ERR_FILE_READ;
  if (((uint32)buffer|(uint32)offset)&1UL)
    return ERR_PTR;
  n <<= 2;
  sint32 totalBytes = 0;
  while (n > bytesLeft) {
    Mem::swap32(buffer, offset, (bytesLeft>>2));
    n                    -= bytesLeft;
    ((char*)buffer)      += bytesLeft;
    totalBytes          += bytesLeft;
    bytesLeft        = 0;
    sint32 bytesArrived = waitPacket();
    if (bytesArrived <= 0)
    {
      if (bytesArrived == 0)
      { // end of file reached
        flags |= FILE_ATEND;
        SetIoErr(0);
        return totalBytes>>2;
      }
      return ERR_FILE_READ;
    }
    // ask that the buffer be filled
    sendPacket(buffers[currentBuf^1]);
    if (seekOffset > bytesArrived)
      seekOffset = bytesArrived;
    offset      = (char*)(buffers[currentBuf]) + seekOffset;
    currentBuf ^= 1;
    bytesLeft   = bytesArrived - seekOffset;
    seekOffset  = 0;
  }
  Mem::swap32(buffer, offset, (n>>2));
  bytesLeft        -= n;
  ((char*)offset)  += n;
  return (totalBytes + n)>>2;
}

////////////////////////////////////////////////////////////////////////////////

sint32 StreamIn::read64Swap(void* buffer,size_t n)
{
  if (!file)
    return ERR_FILE_READ;
  if (((uint32)buffer|(uint32)offset)&1UL)
    return ERR_PTR;
  n <<= 3;
  sint32 totalBytes = 0;
  while (n > bytesLeft) {
    Mem::swap64(buffer, offset, (bytesLeft>>3));
    //Mem::copy(buffer, offset, bytesLeft);
    n                    -= bytesLeft;
    ((char*)buffer)      += bytesLeft;
    totalBytes          += bytesLeft;
    bytesLeft        = 0;
    sint32 bytesArrived = waitPacket();
    if (bytesArrived <= 0)
    {
      if (bytesArrived == 0)
      { // end of file reached
        flags |= FILE_ATEND;
        SetIoErr(0);
        return totalBytes>>3;
      }
      return ERR_FILE_READ;
    }
    // ask that the buffer be filled
    sendPacket(buffers[currentBuf^1]);
    if (seekOffset > bytesArrived)
      seekOffset = bytesArrived;
    offset      = (char*)(buffers[currentBuf]) + seekOffset;
    currentBuf ^= 1;
    bytesLeft   = bytesArrived - seekOffset;
    seekOffset  = 0;
  }
  Mem::swap64(buffer, offset, (n>>3));
  //Mem::copy(buffer, offset, bytesLeft);
  bytesLeft        -= n;
  ((char*)offset)  += n;
  return (totalBytes + n)>>3;
}

////////////////////////////////////////////////////////////////////////////////

sint32 StreamIn::readText(char* buf, sint32 max, char mark, sint32 num)
{
  if (!file)
    return ERR_FILE_READ;
  char* p = buf;
  rsint32 i = max;
  while (--i && num)
  {
    rsint32 c = getChar();
    if (c==ERR_FILE_READ || c==EOF) // terminate if error
      break;
    if (c==(sint32)mark)
      num--;
    *(p++) = (char)c;
  }
  *p = 0; // null terminate
  return (max-i); // return num chars read
}

////////////////////////////////////////////////////////////////////////////////

sint32 StreamIn::rawWriteBytes(const void* buffer, size_t n, sint32 filePos)
{
  return 0;
}


////////////////////////////////////////////////////////////////////////////////
//
//  StreamOut
//
////////////////////////////////////////////////////////////////////////////////

StreamOut::~StreamOut()
{
  close();
  if (textBuffer)
    Mem::free(textBuffer);
}

////////////////////////////////////////////////////////////////////////////////

sint32 StreamOut::open(const char* fileName, bool textMode, bool append, size_t reqSize)
{
  if (!fileName)
    return ERR_PTR_ZERO;
  if (file)
    return ERR_FILE_OPEN;
  if (append == true) {
    if (file = Open(fileName, MODE_READWRITE)) {
      flags |= FILE_APPEND;
      if (Seek(file, 0, OFFSET_END)>=0)
        fileSize = Seek(file, 0, OFFSET_CURRENT);
      else {
        Close(file);
        fileSize = 0;
        file = 0;
        return ERR_FILE_OPEN;
      }
    }
    else
      return ERR_FILE_CREATE;
  }
  else {
    if (file = Open(fileName,MODE_NEWFILE)) {
      fileSize = 0;
      flags |= FILE_WRITE;
    }
    else
      return ERR_FILE_CREATE;
  }

  if (!file)
    return ERR_FILE_OPEN;

  BPTR lock = 0;
  blockSize = 512;
  if (lock = ParentOfFH(file)) {
    ALIGNSTACKOBJ32(InfoData, infoData);
    if (Info(lock,&infoData))
      blockSize  = infoData.id_BytesPerBlock;
    UnLock(lock);
  }
  reqSize = (((reqSize + (blockSize*2) - 1) / (blockSize*2)) * (blockSize*2));

  sint32 result = create(reqSize);

  if (result == OK) {
    packet.sp_Pkt.dp_Type  = ACTION_WRITE;
    bytesLeft              = bufferSize;
    flags |= FILE_GOOD;
  }
  else {
    flags &= ~(FILE_ACCESS|FILE_GOOD);
    Close(file);
    file = 0;
  }
  return result;
}

////////////////////////////////////////////////////////////////////////////////

void StreamOut::close()
{
  if (file) {
    sint32 result = waitPacket();
    if (result >= 0) {
      if (bufferSize > bytesLeft)
        result = Write(file,buffers[currentBuf],bufferSize - bytesLeft);
    }
    Close(file);
    file = 0;
    destroy();
    flags &= ~(FILE_ACCESS|FILE_GOOD);
  }
}

////////////////////////////////////////////////////////////////////////////////

void StreamOut::flush()
{
  if (file) {
    sint32 result = waitPacket();
    if (result >= 0) {
      if (bufferSize > bytesLeft)
        result = Write(file,buffers[currentBuf],bufferSize - bytesLeft);
    }
  }
}

////////////////////////////////////////////////////////////////////////////////

sint32 StreamOut::tell()
{
  if (!file)
    return ERR_FILE_SEEK;
  return seek(0, SEEKCURR);
}

////////////////////////////////////////////////////////////////////////////////

sint32 StreamOut::seek(sint32 position, IOS::SeekMode mode)
{
  if (!file)
    return ERR_FILE_SEEK;
  sint32 bytesArrived = waitPacket();
  if (bytesArrived < 0)
    return ERR_FILE_SEEK;
  if (bufferSize > bytesLeft) {
    if (Write(file,buffers[currentBuf],bufferSize - bytesLeft) < 0) {
      recordSyncFailure();
      return ERR_FILE_SEEK;
    }
  }
  sint32 current = Seek(file, position, mode);
  if (current < 0) {
    recordSyncFailure();
    return ERR_FILE_SEEK;
  }
  bytesLeft  = bufferSize;
  currentBuf = 0;
  offset     = buffers[0];
  return current;
}

////////////////////////////////////////////////////////////////////////////////

sint32 StreamOut::writeBytes(const void* buffer, size_t n)
{
  if (!file)
    return ERR_FILE_WRITE;
  sint32 totalBytes = 0;
  while (n > bytesLeft) {
    if (!handler) {  // NIL
      offset    = buffers[0];
      bytesLeft  = bufferSize;
      return n;
    }

    if (bytesLeft) {
      Mem::copy(offset, (void*)buffer, bytesLeft);
      n                -= bytesLeft;
      ((char*)buffer)  += bytesLeft;
      totalBytes      += bytesLeft;
    }
    if (waitPacket() < 0)
      return ERR_FILE_WRITE;

    // send the current buffer out to disk
    sendPacket(buffers[currentBuf]);

    currentBuf  ^= 1;
    offset      = buffers[currentBuf];
    bytesLeft    = bufferSize;
  }

  Mem::copy(offset, (void*)buffer, n);
  bytesLeft        -= n;
  ((char*)offset)  += n;
  return totalBytes + n;
}

////////////////////////////////////////////////////////////////////////////////

sint32 StreamOut::write16Swap(const void* buffer,size_t n)
{
  if (!file)
    return ERR_FILE_WRITE;
  if (((uint32)buffer|(uint32)offset)&1UL)
    return ERR_PTR;
  n <<= 1;
  sint32 totalBytes = 0;
  while (n > bytesLeft) {
    if (!handler) {  // NIL
      offset      = buffers[0];
      bytesLeft  = bufferSize;
      return n;
    }

    if (bytesLeft) {
      Mem::swap16(offset, (void*)buffer, (bytesLeft>>1));
      n                -= bytesLeft;
      ((char*)buffer)  += bytesLeft;
      totalBytes      += bytesLeft;
    }
    if (waitPacket() < 0)
      return ERR_FILE_WRITE;

    // send the current buffer out to disk
    sendPacket(buffers[currentBuf]);

    currentBuf ^= 1;
    offset      = buffers[currentBuf];
    bytesLeft  = bufferSize;
  }

  Mem::swap16(offset, (void*)buffer, (n>>1));
  bytesLeft        -= n;
  ((char*)offset)  += n;
  return (totalBytes + n)>>1;
}

////////////////////////////////////////////////////////////////////////////////

sint32 StreamOut::write32Swap(const void* buffer,size_t n)
{
  if (!file)
    return ERR_FILE_WRITE;
  if (((uint32)buffer|(uint32)offset)&1UL)
    return ERR_PTR;
  n <<= 2;
  sint32 totalBytes = 0;
  while (n > bytesLeft) {
    if (!handler) {  // NIL
      offset    = buffers[0];
      bytesLeft  = bufferSize;
      return n;
    }

    if (bytesLeft) {
      Mem::swap32(offset, (void*)buffer, (bytesLeft>>2));
      n                -= bytesLeft;
      ((char*)buffer)  += bytesLeft;
      totalBytes      += bytesLeft;
    }
    if (waitPacket() < 0)
      return ERR_FILE_WRITE;

    // send the current buffer out to disk
    sendPacket(buffers[currentBuf]);

    currentBuf ^= 1;
    offset      = buffers[currentBuf];
    bytesLeft  = bufferSize;
  }

  Mem::swap32(offset, (void*)buffer, (n>>2));
  bytesLeft        -= n;
  ((char*)offset)  += n;
  return (totalBytes + n)>>2;
}

////////////////////////////////////////////////////////////////////////////////

sint32 StreamOut::write64Swap(const void* buffer,size_t n)
{
  if (!file)
    return ERR_FILE_WRITE;
  if (((uint32)buffer|(uint32)offset)&1UL)
    return ERR_PTR;
  n <<= 3;
  sint32 totalBytes = 0;
  while (n > bytesLeft) {
    if (!handler) {  // NIL
      offset      = buffers[0];
      bytesLeft  = bufferSize;
      return n;
    }

    if (bytesLeft) {
      Mem::swap64(offset, (void*)buffer, (bytesLeft>>3));
      n                -= bytesLeft;
      ((char*)buffer)  += bytesLeft;
      totalBytes      += bytesLeft;
    }
    if (waitPacket() < 0)
      return ERR_FILE_WRITE;

    // send the current buffer out to disk
    sendPacket(buffers[currentBuf]);

    currentBuf ^= 1;
    offset      = buffers[currentBuf];
    bytesLeft    = bufferSize;
  }

  Mem::swap64(offset, (void*)buffer, (n>>3));
  bytesLeft        -= n;
  ((char*)offset)  += n;
  return (totalBytes + n)>>3;
}

////////////////////////////////////////////////////////////////////////////////

sint32 StreamOut::writeText(const char* format,...)
{
  if (!file)
    return ERR_FILE_WRITE;
  if (!textBuffer) {
    if (!(textBuffer = (char*)Mem::alloc(STREAMOUT_TEXTBUFFSIZE)))
      return ERR_FILE_WRITE;
  }
  va_list a;
  va_start(a,format);
  sint32 num = vsprintf(textBuffer, format, a);
  va_end(a);
  return writeBytes(textBuffer, num);
  return ERR_FILE_WRITE;
}

////////////////////////////////////////////////////////////////////////////////

sint32 StreamOut::rawReadBytes(void* buffer, size_t n, sint32 filePos)
{
  // Note the existing file position, move to the requested absolute position,
  // read and then reset the original position.
  sint32 oldPos = Seek(file, 0, OFFSET_CURRENT);
  Seek(file, filePos, OFFSET_BEGINNING);
  sint32 result = Read(file, buffer, n);
  Seek(file, oldPos, OFFSET_BEGINNING);
  if (result<0)
    return ERR_FILE_READ;
  return result;
}