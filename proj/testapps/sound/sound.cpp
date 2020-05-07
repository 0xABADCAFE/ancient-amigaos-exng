
#include "sound.hpp"
#include <cmath>

using namespace X_SYSNAME;

namespace X_SYSNAME {
  #include <dos/dos.h>
  #include <proto/dos.h>
};

////////////////////////////////////////////////////////////////////////////////

SoundMixer::SoundMixer() : bufferSize(4096), mixFreq(22050), data(0), flags(0),
ahiSignal(0), ahiMP(0), ahiDev(-1), ahiUnit(AHI_DEFAULT_UNIT)
{
  req[0].io = 0;
  req[1].io = 0;
  pcm[0] = 0;
  pcm[1] = 0;

  sint32 unit = AppBase::getInteger("-amiga_ahiunit", false);
  if (unit) {
    ahiUnit = unit;
  }
}

SoundMixer::~SoundMixer()
{
  close();
}

void SoundMixer::close()
{
  printf("SoundMixer::close()\n");
  if (req[0].io) {
    if (flags & IO_USED) {
      printf("Aborting IO...");
      fflush(stdout);
      if (!CheckIO(req[0].io)) {
        AbortIO(req[0].io);
      }
      WaitIO(req[0].io);
      SetSignal(0, ahiSignal);
      printf("done\n");
    }
  }
  if (!ahiDev) {
    CloseDevice(req[0].io);
    ahiDev = -1;
    printf("Closed AHI device\n");
  }
  if (req[0].io) {
    DeleteIORequest(req[0].io);
    req[0].io = 0;
    printf("Deleted primary IORequest\n");
  }

  if (req[1].io) {
    DeleteIORequest(req[1].io);
    req[1].io = 0;
    printf("Deleted secondary IORequest\n");
  }

  if (ahiMP) {
    DeleteMsgPort(ahiMP);
    ahiMP = 0;
    printf("Deleted MsgPort\n");
  }
  pcm[0] = pcm[1] = 0;
  if (data) {
    Mem::free(data);
    data = 0;
    printf("Released buffers\n");
  }
  flags = 0;
}

sint32 SoundMixer::open()
{
  if (ahiMP) {
    printf("SoundMixer::open() - already open\n");
    return ERR_RSC_LOCKED;
  }

  // allocate the pcm buffers as 1 block with pcm[1] offset at the midpoint
  if (!(data = Mem::alloc(2*bufferSize*bytesPerSample, true, Mem::ALIGN_CACHE))) {
    printf("SoundMixer::open() - failed to allocate buffers\n");
    close();
    return ERR_NO_FREE_STORE;
  }
  pcm[0] = (sint16*)data;
  pcm[1] = pcm[0]+(bufferSize*2);


  if (!(ahiMP = CreateMsgPort())) {
    close();
    return ERR_RSC_UNAVAILABLE;
  }

  ahiSignal = 1UL<<ahiMP->mp_SigBit;

  if (req[0].ahi = (AHIRequest*)CreateIORequest(ahiMP, sizeof(struct AHIRequest))) {
    req[0].ahi->ahir_Version = 4;
    if (!(ahiDev = OpenDevice(AHINAME, ahiUnit, req[0].io, 0))) {

      if (req[1].ahi =(AHIRequest*)AllocMem(sizeof(AHIRequest), MEMF_FAST)) {
        *(req[1].ahi) = *(req[0].ahi);
      }
      else {
        printf("SoundMixer::open() - failed to create secondary AHIRequest\n");
        close();
        return ERR_RSC_UNAVAILABLE;
      }

    }
    else {
      printf("SoundMixer::open() - failed to open AHI device\n");
      return ERR_RSC_UNAVAILABLE;
    }
  }
  else {
    printf("SoundMixer::open() - failed to create primary AHIRequest\n");
    close();
    return ERR_RSC_UNAVAILABLE;
  }
  printf("SoundMixer::open() OK\n");
  printf("Opened AHI device unit %hu\n", ahiUnit);
  printf("Buffers at 0x%08X / 0x%08X\n", (unsigned)pcm[0], (unsigned)pcm[1]);
  return OK;
}

////////////////////////////////////////////////////////////////////////////////

sint32 SoundMixer::run()
{
  AHIRequest*  link = 0;
  sint16*      tBuf = 0;
  void*        tReq = 0;
  size_t      ioLength = bufferSize*bytesPerSample;
  sint32      count = 0;
  flags        |= IO_USED;
  while(!shutDownReq()) {
    //Prepare IO request
    req[0].ahi->ahir_Std.io_Message.mn_Node.ln_Pri = 0;
    req[0].ahi->ahir_Std.io_Command  = CMD_WRITE;
    req[0].ahi->ahir_Std.io_Data     = pcm[0];
    req[0].ahi->ahir_Std.io_Length   = ioLength;
    req[0].ahi->ahir_Std.io_Offset   = 0;
    req[0].ahi->ahir_Frequency       = mixFreq;
    req[0].ahi->ahir_Type            = AHIST_S16S;
    req[0].ahi->ahir_Volume          = ((Fixed)0x00010000L);
    req[0].ahi->ahir_Position        = ((Fixed)0x00008000L);
    req[0].ahi->ahir_Link            = link;
    //Send IO Request
    SendIO(req[0].io);
    count++;
    if(link) {
      uint32 signals=Wait(SIGBREAKF_CTRL_C | ahiSignal);
    // Check for Ctrl-C and abort if pressed
      if(signals & SIGBREAKF_CTRL_C) {
        flags |= IO_BRK;
        num = 0;
      }

      if(WaitIO((IORequest*)link)) {
        SetIoErr(ERROR_WRITE_PROTECTED);
        break;
      }
    }

    // swap those pesky buffers
    link        = req[0].ahi;
    tBuf        = pcm[0];
    pcm[0]      = pcm[1];
    pcm[1]      = tBuf;
    tReq        = req[0].any;
    req[0].any  = req[1].any;
    req[1].any  = tReq;
  }
  if (flags & IO_BRK) {
    printf("aborting primary IO\n");
    AbortIO(req[0].io);
    WaitIO(req[0].io);
    if (count>2) {
      printf("aborting secondary IO\n");
      AbortIO(req[1].io);
      WaitIO(req[1].io);
    }
  } else {
    printf("completing IO\n");
    WaitIO(req[1].io);
  }

  return OK;
}


////////////////////////////////////////////////////////////////////////////////

sint32 SoundMixer::test(sint32 num)
{
  float64 sl = (128.0*M_PI)/(float64)(bufferSize);
  float64 sr = (256.0*M_PI)/(float64)(bufferSize);
  float64 sc = (64.0*M_PI)/(float64)(bufferSize);
  for (sint32 i=0; i<(bufferSize<<1); i+=2) {
    pcm[1][i] = pcm[0][i] = (sint16)(8192.0 * (sin(sr*i) + cos(sc*i)));
    pcm[1][i+1] = pcm[0][i+1] = (sint16)(8192.0 * (sin(sl*i) + cos(sc*i)));
  }

  AHIRequest*  link = 0;
  sint16*      tBuf = 0;
  void*        tReq = 0;
  size_t      ioLength = bufferSize*bytesPerSample;
  sint32      count = 0;
  flags        |= IO_USED;

  while (num--) {

    //Prepare IO request
    req[0].ahi->ahir_Std.io_Message.mn_Node.ln_Pri = 0;
    req[0].ahi->ahir_Std.io_Command  = CMD_WRITE;
    req[0].ahi->ahir_Std.io_Data     = pcm[0];
    req[0].ahi->ahir_Std.io_Length   = ioLength;
    req[0].ahi->ahir_Std.io_Offset   = 0;
    req[0].ahi->ahir_Frequency       = mixFreq;
    req[0].ahi->ahir_Type            = AHIST_S16S;
    req[0].ahi->ahir_Volume          = ((Fixed)0x00010000L);
    req[0].ahi->ahir_Position        = ((Fixed)0x00008000L);
    req[0].ahi->ahir_Link            = link;
    //Send IO Request
    SendIO(req[0].io);
    count++;
    if(link) {
      uint32 signals=Wait(SIGBREAKF_CTRL_C | ahiSignal);
    // Check for Ctrl-C and abort if pressed
      if(signals & SIGBREAKF_CTRL_C) {
        flags |= IO_BRK;
        num = 0;
      }

      if(WaitIO((IORequest*)link)) {
        SetIoErr(ERROR_WRITE_PROTECTED);
        break;
      }
    }

    // swap those pesky buffers
    link        = req[0].ahi;
    tBuf        = pcm[0];
    pcm[0]      = pcm[1];
    pcm[1]      = tBuf;
    tReq        = req[0].any;
    req[0].any  = req[1].any;
    req[1].any  = tReq;
  }
  if (flags & IO_BRK) {
    printf("aborting primary IO\n");
    AbortIO(req[0].io);
    WaitIO(req[0].io);
    if (count>2) {
      printf("aborting secondary IO\n");
      AbortIO(req[1].io);
      WaitIO(req[1].io);
    }
  } else {
    printf("completing IO\n");
    WaitIO(req[1].io);
  }

  return OK;
}
