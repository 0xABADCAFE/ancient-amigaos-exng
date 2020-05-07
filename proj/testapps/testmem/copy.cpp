

void Mem::copy(void* dest, void* source, size_t size)
{
  //  Overlapping memory is not supported.
  //  Simple sanity test for copying zero length or copying
  //  from same source to destination.

  if ((source == dest) || (size==0))
    return;

  uint32 srcAlign      = ((uint32)source)&3UL;
  uint32 dstAlign      = ((uint32)dest)&3UL;



  //  When the source and destination are 4 byte aligned, we can use
  //  uint32 transfers.
  //
  //  When the source and destination are 2 byte aligned, we can use
  //  uint16 transfers.
  //
  //  We use byte copy only for preceeding/trailing sections and
  //  the worst case scenario of odd alignment.
  //
  //  For all cases, we can further improve the throughput by manually
  //  unrolling the loop Duff's style.
  //
  //  The relative alignment can be obtained by simply xoring the
  //  srcAlign and dstAlign values above.


  switch (srcAlign^dstAlign)
  {
    // uint32 transfers
    case 0:
    {
      register void* to    = (void*)(dest);
      register void* from  = (void*)(source);

      //  If there's less than 4 bytes to copy, we can skip the
      //  Duff's Device code and let the trailing bytes code
      //  handle it.

      if (size>3)
      {
        //  Bytecopy up to the next absolute 4 byte boundary
        //  before entering the 32-bit aligned copy code.
        //
        //  The number of bytes to copy to the next aligned
        //  boundary is (4-srcAlign) and would logically
        //  have the range 1-4. However, a value of 4
        //  implies we are actually aligned already.
        //
        //  Since the range is 1-4, we can manage without
        //  a loop and simply use a completely unrolled
        //  switch/case.

        int preceedingBytes  = 4-srcAlign;
        switch (preceedingBytes) {
          case 3:  *((uint8*)to)++ = *((uint8*)from)++;
          case 2:  *((uint8*)to)++ = *((uint8*)from)++;
          case 1:  *((uint8*)to)++ = *((uint8*)from)++;

          //  Remember to decrement the overall length if we
          //  actually copied any preceding bytes during alignment.

          size -= preceedingBytes;
          default:  break;
        }

        //  Pre alignment copying may have reduced remaining size
        //  such that the Duff's Device code is not needed
        //  and the trailing bytes code will do the remainder.
        //
        //  The Duff's Device code should now only be invoked for
        //  remaining size > 3 bytes, anything less can be handled
        //  by the trailing bytes copy code.

        if (size>3)
        {
          //  Duff's Device.
          //  We shift 64 bytes per iteration as 16x32-bit.
          //  "size" is in 8-bit bytes.
          //
          //  Each move copies 4 bytes as a 32-bit uint32:
          //
          //  Block size  = ((bytes/4)+15)/16 = (bytes+60)/64 = (size + 60) >> 6
          //  Jump offset = (bytes/4)%16      = (size >> 2) & 15

          register uint32 blocks = (size+60)>>6;
          switch ((size>>2)&15UL) {
            case 0:  do {  *((uint32*)to)++ = *((uint32*)from)++;
            case 15:      *((uint32*)to)++ = *((uint32*)from)++;
            case 14:      *((uint32*)to)++ = *((uint32*)from)++;
            case 13:      *((uint32*)to)++ = *((uint32*)from)++;
            case 12:      *((uint32*)to)++ = *((uint32*)from)++;
            case 11:      *((uint32*)to)++ = *((uint32*)from)++;
            case 10:      *((uint32*)to)++ = *((uint32*)from)++;
            case 9:        *((uint32*)to)++ = *((uint32*)from)++;
            case 8:        *((uint32*)to)++ = *((uint32*)from)++;
            case 7:        *((uint32*)to)++ = *((uint32*)from)++;
            case 6:        *((uint32*)to)++ = *((uint32*)from)++;
            case 5:        *((uint32*)to)++ = *((uint32*)from)++;
            case 4:        *((uint32*)to)++ = *((uint32*)from)++;
            case 3:        *((uint32*)to)++ = *((uint32*)from)++;
            case 2:        *((uint32*)to)++ = *((uint32*)from)++;
            case 1:        *((uint32*)to)++ = *((uint32*)from)++;
                  } while (--blocks);
          }
        }
      }

      //  By now we only have 0-3 bytes left to copy. The main copy
      //  loop above has removed all the bulk as uint32s, so the
      //  remainder is given by size & 3UL.
      //
      //  Since the range is 0-3, we can manage without a loop and
      //  simply use a completely unrolled switch/case.

      switch (size & 3UL) {
        case 3:  *((uint8*)to)++ = *((uint8*)from)++;
        case 2:  *((uint8*)to)++ = *((uint8*)from)++;
        case 1:  *((uint8*)to)++ = *((uint8*)from)++;
        case 0: break;
      }
    }
    break;

    // uint16 transfers
    case 2:
    {
      //  FIXME : how about uint32 transfers with an aligned destination?
      //  Bytecopy up to the next absolute 2 byte boundary
      //  before entering the 16-bit aligned copy code

      register void* to    = (void*)(dest);
      register void* from  = (void*)(source);
      if (srcAlign & 1UL)
      {
        *((uint8*)to)++ = *((uint8*)from)++;
        size--;
      }

      //  Alignment may have reduced remaining bytecount
      //  such that the Duff's Device code is not needed
      //  and the trailing bytes code will do the remainder.
      //
      //  The Duff's Device code should now only be invoked for
      //  remaining size > 1 byte, anything less can be handled
      //  by the trailing bytes copy code.

      if (size>1)
      {
        //  Duff's Device.
        //  We shift 32 bytes per iteration as 16x16-bit.
        //
        //  "size" is in 8-bit bytes.
        //
        //  Each move copies 2 bytes as a 16-bit uint16:
        //
        //  Block size  = ((bytes/2)+15)/16 = (bytes+30)/32 = (size + 30) >> 5
        //  Jump offset = (bytes/2)%16      = (size >> 1) & 15

        register uint32 blocks = (size+30)>>5;
        switch ((size>>1)&15UL) {
          case 0:  do {  *((uint16*)to)++ = *((uint16*)from)++;
          case 15:      *((uint16*)to)++ = *((uint16*)from)++;
          case 14:      *((uint16*)to)++ = *((uint16*)from)++;
          case 13:      *((uint16*)to)++ = *((uint16*)from)++;
          case 12:      *((uint16*)to)++ = *((uint16*)from)++;
          case 11:      *((uint16*)to)++ = *((uint16*)from)++;
          case 10:      *((uint16*)to)++ = *((uint16*)from)++;
          case 9:      *((uint16*)to)++ = *((uint16*)from)++;
          case 8:      *((uint16*)to)++ = *((uint16*)from)++;
          case 7:      *((uint16*)to)++ = *((uint16*)from)++;
          case 6:      *((uint16*)to)++ = *((uint16*)from)++;
          case 5:      *((uint16*)to)++ = *((uint16*)from)++;
          case 4:      *((uint16*)to)++ = *((uint16*)from)++;
          case 3:      *((uint16*)to)++ = *((uint16*)from)++;
          case 2:      *((uint16*)to)++ = *((uint16*)from)++;
          case 1:      *((uint16*)to)++ = *((uint16*)from)++;
                } while (--blocks);
        }
      }

      //  By now we may have an odd byte left to copy. The main copy
      //  loop above has removed all the bulk in words, so the
      //  remainder is given by size & 1.

      if (size&1UL)
        *((uint8*)to)++ = *((uint8*)from)++;
    }
    break;

    // uint8 transfers
    case 1:
    case 3:
    {
      //  The absolute worst case scenario :-(
      //  But much simpler to write than the others :-)

      if (size>0)
      {
        //  FIXME : go for 32-bit aligned destination?
        //  Duff's Device.
        //
        //  We shift 16 bytes per iteration as 16x8-bit.
        //
        //  Almost no point, except to reduce the loop overhead.

        register void* to    = (void*)(dest);
        register void* from  = (void*)(source);
        register uint32 blocks = (size+15)>>4;
        switch (size&15UL) {
          case 0:  do {  *((uint8*)to)++ = *((uint8*)from)++;
          case 15:      *((uint8*)to)++ = *((uint8*)from)++;
          case 14:      *((uint8*)to)++ = *((uint8*)from)++;
          case 13:      *((uint8*)to)++ = *((uint8*)from)++;
          case 12:      *((uint8*)to)++ = *((uint8*)from)++;
          case 11:      *((uint8*)to)++ = *((uint8*)from)++;
          case 10:      *((uint8*)to)++ = *((uint8*)from)++;
          case 9:        *((uint8*)to)++ = *((uint8*)from)++;
          case 8:        *((uint8*)to)++ = *((uint8*)from)++;
          case 7:        *((uint8*)to)++ = *((uint8*)from)++;
          case 6:        *((uint8*)to)++ = *((uint8*)from)++;
          case 5:        *((uint8*)to)++ = *((uint8*)from)++;
          case 4:        *((uint8*)to)++ = *((uint8*)from)++;
          case 3:        *((uint8*)to)++ = *((uint8*)from)++;
          case 2:        *((uint8*)to)++ = *((uint8*)from)++;
          case 1:        *((uint8*)to)++ = *((uint8*)from)++;
                } while (--blocks);
        }
      }
    }
    break;
  }
}

