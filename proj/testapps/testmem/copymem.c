/*
 *  CopyMemQuick() / CopyMem() evaluation code for ExecSG.
 *
 *  Author K. Churchill
 *
 *  Date 2004-05-09
 *
 *  Revision 1
 *
 *  Code passed all strain tests of all lengths from 0 bytes to 1K
 *  when compared to exec CopyMem() / CopyMemQuick() for each possible
 *  combination of relative and absolute alignment from 0-32.
 *  (Testing actually took over an hour to run on my system!).
 *
 */

#include <exec/types.h>

void Karl_CopyMemQuick(CONST APTR source, APTR dest, ULONG size);
void Karl_CopyMem(CONST APTR source, APTR dest, ULONG size);

/********************************************************************/

void Karl_CopyMemQuick(CONST APTR source, APTR dest, ULONG size)
{
	/*
		This code has the same constraints as exec/CopyMemQuick().
		Source and destination must be long aligned, size should be
		divisible by 4. Overlappig memory is not supported.
		Use the CopyMem() replacement for odd lengths and misaligned
		pointers.
	*/

	register void* to;
	register void* from;

	/*
		Simple sanity test for copying zero length or copying
		from same source to destination
	*/

	if ((source == dest) || (size==0))
		return;

	if ( (((ULONG)source)|((ULONG)dest)|size) & 3UL)
	{

		/*
			For people who dont read the docs. It's more than they
			deserve!
		*/

		Karl_CopyMem(source, dest, size);
		return;
	}

	/*
		Discard lower 3 bits of source and destination pointers
		and reduce size to number of 32-bit words.
	*/

	to		= (void*)(((ULONG)dest)& ~3UL);
	from	= (void*)(((ULONG)source)& ~3UL);
	size	>>= 2;

	/*
		If source and destination are relative aligned to 8 bytes
		then we can use a DOUBLE copy loop. We just need to handle
		any preceeding/trailing 32-bit words.
	*/

	if ( (((ULONG)from)&7UL) == (((ULONG)to)&7UL) )
	{
		/*
			Is there a preceeding word before 64-bit aligned area ?
			We can check by logically and'ing either address with 4.
		*/

		if (((ULONG)from)&4UL)
		{
			*((ULONG*)to)++ = *((ULONG*)from)++;
			size--;
		}

		/*
			Pre alignment copying may have reduced remaining size
			such that the Duff's Device code is not needed
			and the trailing word code will do the remainder.

			The Duff's Device code should now only be invoked for
			remaining size > 1 word, anything less can be handled
			by the trailing word copy code.
		*/

		if (size>1)
		{
			/*
				Duff's Device.
				We shift 128 bytes per iteration as 16x64-bit.

				"size" is in 32-bit words.

				Each move copies 2 words as a 64-bit DOUBLE:

				Block size  = ((words/2)+15)/16 = (words+30)/32 = (size + 30) >> 5
				Jump offset = (words/2)%16      = words % 32    = (size >> 1) & 15
			*/

			register ULONG blocks = (size+30)>>5;
			switch ((size>>1)&15UL) {
				case 0:	do {	*((DOUBLE*)to)++ = *((DOUBLE*)from)++;
				case 15:			*((DOUBLE*)to)++ = *((DOUBLE*)from)++;
				case 14:			*((DOUBLE*)to)++ = *((DOUBLE*)from)++;
				case 13:			*((DOUBLE*)to)++ = *((DOUBLE*)from)++;
				case 12:			*((DOUBLE*)to)++ = *((DOUBLE*)from)++;
				case 11:			*((DOUBLE*)to)++ = *((DOUBLE*)from)++;
				case 10:			*((DOUBLE*)to)++ = *((DOUBLE*)from)++;
				case 9:			*((DOUBLE*)to)++ = *((DOUBLE*)from)++;
				case 8:			*((DOUBLE*)to)++ = *((DOUBLE*)from)++;
				case 7:			*((DOUBLE*)to)++ = *((DOUBLE*)from)++;
				case 6:			*((DOUBLE*)to)++ = *((DOUBLE*)from)++;
				case 5:			*((DOUBLE*)to)++ = *((DOUBLE*)from)++;
				case 4:			*((DOUBLE*)to)++ = *((DOUBLE*)from)++;
				case 3:			*((DOUBLE*)to)++ = *((DOUBLE*)from)++;
				case 2:			*((DOUBLE*)to)++ = *((DOUBLE*)from)++;
				case 1:			*((DOUBLE*)to)++ = *((DOUBLE*)from)++;
							} while (--blocks);
			}
		}

		/*	Is there a trailing word remaining ?*/

		if (size & 1)
			*((ULONG*)to)++ = *((ULONG*)from)++;
	}
	else
	{

		/*
			Duff's Device.
			We shift 64 bytes per iteration as 16x32-bit.

			"size" is in 32-bit words.

			Each move copies 1 word as a 32-bit ULONG:

			Block size  = (words+15)/16 = (size + 15) >> 4
			Jump offset = words%16      = size & 15
		*/

		register ULONG blocks = (size+15)>>4;
		switch (size&15UL) {
			case 0:	do {	*((ULONG*)to)++ = *((ULONG*)from)++;
			case 15:			*((ULONG*)to)++ = *((ULONG*)from)++;
			case 14:			*((ULONG*)to)++ = *((ULONG*)from)++;
			case 13:			*((ULONG*)to)++ = *((ULONG*)from)++;
			case 12:			*((ULONG*)to)++ = *((ULONG*)from)++;
			case 11:			*((ULONG*)to)++ = *((ULONG*)from)++;
			case 10:			*((ULONG*)to)++ = *((ULONG*)from)++;
			case 9:			*((ULONG*)to)++ = *((ULONG*)from)++;
			case 8:			*((ULONG*)to)++ = *((ULONG*)from)++;
			case 7:			*((ULONG*)to)++ = *((ULONG*)from)++;
			case 6:			*((ULONG*)to)++ = *((ULONG*)from)++;
			case 5:			*((ULONG*)to)++ = *((ULONG*)from)++;
			case 4:			*((ULONG*)to)++ = *((ULONG*)from)++;
			case 3:			*((ULONG*)to)++ = *((ULONG*)from)++;
			case 2:			*((ULONG*)to)++ = *((ULONG*)from)++;
			case 1:			*((ULONG*)to)++ = *((ULONG*)from)++;
						} while (--blocks);
		}
	}
}

/********************************************************************/

void Karl_CopyMem(CONST APTR source, APTR dest, ULONG size)
{
	/*
		This code has the same constraints as exec/CopyMem().
		Overlapping memory is not supported.
	*/

	ULONG srcAlign			= ((ULONG)source)&7UL;
	ULONG dstAlign			= ((ULONG)dest)&7UL;

	/*
		Simple sanity test for copying zero length or copying
		from same source to destination.
	*/

	if ((source == dest) || (size==0))
		return;

	/*
		On PPC, we can optimise large copies by considering the relative
		alignemnt of the source and destination addresses:

		When the source and destination are 8 byte aligned, we can use
		DOUBLE transfers.

		When the source and destination are 4 byte aligned, we can use
		ULONG transfers.

		When the source and destination are 2 byte aligned, we can use
		UWORD transfers.

		We use byte copy only for preceeding/trailing sections and
		the worst case scenario of odd alignment.

		For all cases, we can further improve the throughput by manually
		unrolling the loop Duff's style.

		The relative alignment can be obtained by simply xoring the
		srcAlign and dstAlign values above.
	*/

	switch (srcAlign^dstAlign)
	{
		/* DOUBLE transfers *****************************************/
		case 0:
		{
			register void* to		= (void*)(dest);
			register void* from	= (void*)(source);

			/*
				If there's less than 8 bytes to copy, we can skip the
				Duff's Device code and use a simple unrolled bytecopy.
			*/

			if (size<8UL)
			{
				switch (size&7UL) {
					case 7:	*((UBYTE*)to)++ = *((UBYTE*)from)++;
					case 6:	*((UBYTE*)to)++ = *((UBYTE*)from)++;
					case 5:	*((UBYTE*)to)++ = *((UBYTE*)from)++;
					case 4:	*((UBYTE*)to)++ = *((UBYTE*)from)++;
					case 3:	*((UBYTE*)to)++ = *((UBYTE*)from)++;
					case 2:	*((UBYTE*)to)++ = *((UBYTE*)from)++;
					case 1:	*((UBYTE*)to)++ = *((UBYTE*)from)++;
					case 0: break;
				}
			}
			else
			{

				/*
					Bytecopy up to the next absolute 8 byte boundary
					before entering the 64-bit aligned copy code.

					The number of bytes to copy to the next aligned
					boundary is (8-srcAlign) and would logically
					have the range 1-8. However, a value of 8
					implies we are actually aligned already.

					Since the range is 1-8, we can manage without
					a loop and simply use a completely unrolled
					switch/case.
				*/

				int preceedingBytes	= (8UL-srcAlign)&7UL;
				switch (preceedingBytes) {
					case 7:	*((UBYTE*)to)++ = *((UBYTE*)from)++;
					case 6:	*((UWORD*)to)++ = *((UWORD*)from)++;
								*((ULONG*)to)++ = *((ULONG*)from)++;
								size -= preceedingBytes;
								break;
					case 5:	*((UBYTE*)to)++ = *((UBYTE*)from)++;
					case 4:	*((ULONG*)to)++ = *((ULONG*)from)++;
								size -= preceedingBytes;
								break;
					case 3:	*((UBYTE*)to)++ = *((UBYTE*)from)++;
					case 2:	*((UWORD*)to)++ = *((UWORD*)from)++;
								size -= preceedingBytes;
								break;
					case 1:	*((UBYTE*)to)++ = *((UBYTE*)from)++;
								size -= preceedingBytes;
								break;
				}

				/*
					Pre alignment copying may have reduced remaining size
					such that the Duff's Device code is not needed
					and the trailing bytes code will do the remainder.

					The Duff's Device code should now only be invoked for
					remaining size > 7 bytes, anything less can be handled
					by the trailing bytes copy code.
				*/

				if (size>7)
				{

					/*
						Duff's Device.
						We shift 128 bytes per iteration as 16x64-bit.

						"size" is in 8-bit bytes.

						Each move copies 8 bytes as a 64-bit DOUBLE:

						Block size  = ((bytes/8)+15)/16 = (bytes+120)/128 = (size + 120) >> 7
						Jump offset = (bytes/8)%16      = (size >> 3) & 15
					*/

					register ULONG blocks = (size+120)>>7;
					switch ((size>>3)&15UL) {
						case 0:	do {	*((DOUBLE*)to)++ = *((DOUBLE*)from)++;
						case 15:			*((DOUBLE*)to)++ = *((DOUBLE*)from)++;
						case 14:			*((DOUBLE*)to)++ = *((DOUBLE*)from)++;
						case 13:			*((DOUBLE*)to)++ = *((DOUBLE*)from)++;
						case 12:			*((DOUBLE*)to)++ = *((DOUBLE*)from)++;
						case 11:			*((DOUBLE*)to)++ = *((DOUBLE*)from)++;
						case 10:			*((DOUBLE*)to)++ = *((DOUBLE*)from)++;
						case 9:			*((DOUBLE*)to)++ = *((DOUBLE*)from)++;
						case 8:			*((DOUBLE*)to)++ = *((DOUBLE*)from)++;
						case 7:			*((DOUBLE*)to)++ = *((DOUBLE*)from)++;
						case 6:			*((DOUBLE*)to)++ = *((DOUBLE*)from)++;
						case 5:			*((DOUBLE*)to)++ = *((DOUBLE*)from)++;
						case 4:			*((DOUBLE*)to)++ = *((DOUBLE*)from)++;
						case 3:			*((DOUBLE*)to)++ = *((DOUBLE*)from)++;
						case 2:			*((DOUBLE*)to)++ = *((DOUBLE*)from)++;
						case 1:			*((DOUBLE*)to)++ = *((DOUBLE*)from)++;
									} while (--blocks);
					}
				}

				/*
					Here we have 0-7 aligned trailing bytes, so we can optimise in
					a similar way to the preceeding bytes.
				*/
				switch (size&7UL) {
					case 7:	*((ULONG*)to)++ = *((ULONG*)from)++;
								*((UWORD*)to)++ = *((UWORD*)from)++;
								*((UBYTE*)to)++ = *((UBYTE*)from)++;
								/* Finished! */
								return;

					case 6:	*((ULONG*)to)++ = *((ULONG*)from)++;
								*((UWORD*)to)++ = *((UWORD*)from)++;
								/* Finished! */
								return;

					case 5:	*((ULONG*)to)++ = *((ULONG*)from)++;
								*((UBYTE*)to)++ = *((UBYTE*)from)++;
								/* Finished! */
								return;

					case 4:	*((ULONG*)to)++ = *((ULONG*)from)++;
								/* Finished! */
								return;

					case 3:	*((UWORD*)to)++ = *((UWORD*)from)++;
								*((UBYTE*)to)++ = *((UBYTE*)from)++;
								/* Finished! */
								return;

					case 2:	*((UWORD*)to)++ = *((UWORD*)from)++;
								/* Finished! */
								return;

					case 1:	*((UBYTE*)to)++ = *((UBYTE*)from)++;
								/* Finished */
					case 0:	return;
				}
			}
		}
		break;

		/* ULONG transfers *******************************************/
		case 4:
		{
			register void* to		= (void*)(dest);
			register void* from	= (void*)(source);

			/*
				If there's less than 4 bytes to copy, we can skip the
				Duff's Device code and use a simple unrolled bytecopy.
			*/

			if (size < 4UL)
			{
				switch (size & 3UL) {
					case 3:	*((UBYTE*)to)++ = *((UBYTE*)from)++;
					case 2:	*((UBYTE*)to)++ = *((UBYTE*)from)++;
					case 1:	*((UBYTE*)to)++ = *((UBYTE*)from)++;
					case 0: break;
				}
			}
			else
			{

				/*
					Bytecopy up to the next absolute 4 byte boundary
					before entering the 32-bit aligned copy code.

					The number of bytes to copy to the next aligned
					boundary is (4-srcAlign) and would logically
					have the range 1-4. However, a value of 4
					implies we are actually aligned already.

					Since the range is 1-4, we can manage without
					a loop and simply use a completely unrolled
					switch/case.
				*/

				int preceedingBytes	= (4UL-srcAlign)&3UL;
				switch (preceedingBytes) {
					case 3:	*((UBYTE*)to)++ = *((UBYTE*)from)++;
					case 2:	*((UWORD*)to)++ = *((UWORD*)from)++;
								size -= preceedingBytes;
								break;
					case 1:	*((UBYTE*)to)++ = *((UBYTE*)from)++;
								size -= preceedingBytes;
								break;
				}

				/*
					Pre alignment copying may have reduced remaining size
					such that the Duff's Device code is not needed
					and the trailing bytes code will do the remainder.

					The Duff's Device code should now only be invoked for
					remaining size > 3 bytes, anything less can be handled
					by the trailing bytes copy code.
				*/

				if (size>3)
				{

					/*
						Duff's Device.
						We shift 64 bytes per iteration as 16x32-bit.

						"size" is in 8-bit bytes.

						Each move copies 4 bytes as a 32-bit ULONG:

						Block size  = ((bytes/4)+15)/16 = (bytes+60)/64 = (size + 60) >> 6
						Jump offset = (bytes/4)%16      = (size >> 2) & 15
					*/

					register ULONG blocks = (size+60)>>6;
					switch ((size>>2)&15UL) {
						case 0:	do {	*((ULONG*)to)++ = *((ULONG*)from)++;
						case 15:			*((ULONG*)to)++ = *((ULONG*)from)++;
						case 14:			*((ULONG*)to)++ = *((ULONG*)from)++;
						case 13:			*((ULONG*)to)++ = *((ULONG*)from)++;
						case 12:			*((ULONG*)to)++ = *((ULONG*)from)++;
						case 11:			*((ULONG*)to)++ = *((ULONG*)from)++;
						case 10:			*((ULONG*)to)++ = *((ULONG*)from)++;
						case 9:			*((ULONG*)to)++ = *((ULONG*)from)++;
						case 8:			*((ULONG*)to)++ = *((ULONG*)from)++;
						case 7:			*((ULONG*)to)++ = *((ULONG*)from)++;
						case 6:			*((ULONG*)to)++ = *((ULONG*)from)++;
						case 5:			*((ULONG*)to)++ = *((ULONG*)from)++;
						case 4:			*((ULONG*)to)++ = *((ULONG*)from)++;
						case 3:			*((ULONG*)to)++ = *((ULONG*)from)++;
						case 2:			*((ULONG*)to)++ = *((ULONG*)from)++;
						case 1:			*((ULONG*)to)++ = *((ULONG*)from)++;
									} while (--blocks);
					}
				}

				/*
					Here we have 0-3 trailing bytes. We are also aligned, so
					we can optimise in a similar way to the preceeding bytes.
				*/

				switch (size & 3UL) {
					case 3:	*((UWORD*)to)++ = *((UWORD*)from)++;
								*((UBYTE*)to)++ = *((UBYTE*)from)++;
								/* Finished! */
								return;

					case 2:	*((UWORD*)to)++ = *((UWORD*)from)++;
								/* Finished! */
								return;

					case 1:	*((UBYTE*)to)++ = *((UBYTE*)from)++;
								/* Finished */
					case 0:	return;
				}
			}
		}
		break;

		/* UWORD transfers *******************************************/
		case 2:
		case 6:
		{

			/*
				Bytecopy up to the next absolute 2 byte boundary
				before entering the 16-bit aligned copy code
			*/

			register void* to		= (void*)(dest);
			register void* from	= (void*)(source);

			if (srcAlign & 1UL)
			{
				*((UBYTE*)to)++ = *((UBYTE*)from)++;
				size--;
			}

			/*
				Alignment may have reduced remaining bytecount
				such that the Duff's Device code is not needed
				and the trailing bytes code will do the remainder.

				The Duff's Device code should now only be invoked for
				remaining size > 1 byte, anything less can be handled
				by the trailing bytes copy code.
			*/

			if (size>1)
			{

				/*
					Duff's Device.
					We shift 32 bytes per iteration as 16x16-bit.

					"size" is in 8-bit bytes.

					Each move copies 2 bytes as a 16-bit UWORD:

					Block size  = ((bytes/2)+15)/16 = (bytes+30)/32 = (size + 30) >> 5
					Jump offset = (bytes/2)%16      = (size >> 1) & 15
				*/

				register ULONG blocks = (size+30)>>5;
				switch ((size>>1)&15UL) {
					case 0:	do {	*((UWORD*)to)++ = *((UWORD*)from)++;
					case 15:			*((UWORD*)to)++ = *((UWORD*)from)++;
					case 14:			*((UWORD*)to)++ = *((UWORD*)from)++;
					case 13:			*((UWORD*)to)++ = *((UWORD*)from)++;
					case 12:			*((UWORD*)to)++ = *((UWORD*)from)++;
					case 11:			*((UWORD*)to)++ = *((UWORD*)from)++;
					case 10:			*((UWORD*)to)++ = *((UWORD*)from)++;
					case 9:			*((UWORD*)to)++ = *((UWORD*)from)++;
					case 8:			*((UWORD*)to)++ = *((UWORD*)from)++;
					case 7:			*((UWORD*)to)++ = *((UWORD*)from)++;
					case 6:			*((UWORD*)to)++ = *((UWORD*)from)++;
					case 5:			*((UWORD*)to)++ = *((UWORD*)from)++;
					case 4:			*((UWORD*)to)++ = *((UWORD*)from)++;
					case 3:			*((UWORD*)to)++ = *((UWORD*)from)++;
					case 2:			*((UWORD*)to)++ = *((UWORD*)from)++;
					case 1:			*((UWORD*)to)++ = *((UWORD*)from)++;
								} while (--blocks);
				}
			}

			/*
				By now we may have an odd byte left to copy. The main copy
				loop above has removed all the bulk in words, so the
				remainder is given by size & 1.
			*/

			if (size&1UL)
				*((UBYTE*)to)++ = *((UBYTE*)from)++;
		}
		break;

		/* UBYTE transfers *******************************************/
		case 1:
		case 3:
		case 5:
		case 7:
		{
			/*
				The absolute worst case scenario :-(
				But much simpler to write than the others :-)
			*/
			if (size>0)
			{

				/*
					Duff's Device.

					We shift 16 bytes per iteration as 16x8-bit.

					Almost no point, except to reduce the loop overhead.
				*/

				register void* to		= (void*)(dest);
				register void* from	= (void*)(source);
				register ULONG blocks = (size+15)>>4;
				switch (size&15UL) {
					case 0:	do {	*((UBYTE*)to)++ = *((UBYTE*)from)++;
					case 15:			*((UBYTE*)to)++ = *((UBYTE*)from)++;
					case 14:			*((UBYTE*)to)++ = *((UBYTE*)from)++;
					case 13:			*((UBYTE*)to)++ = *((UBYTE*)from)++;
					case 12:			*((UBYTE*)to)++ = *((UBYTE*)from)++;
					case 11:			*((UBYTE*)to)++ = *((UBYTE*)from)++;
					case 10:			*((UBYTE*)to)++ = *((UBYTE*)from)++;
					case 9:			*((UBYTE*)to)++ = *((UBYTE*)from)++;
					case 8:			*((UBYTE*)to)++ = *((UBYTE*)from)++;
					case 7:			*((UBYTE*)to)++ = *((UBYTE*)from)++;
					case 6:			*((UBYTE*)to)++ = *((UBYTE*)from)++;
					case 5:			*((UBYTE*)to)++ = *((UBYTE*)from)++;
					case 4:			*((UBYTE*)to)++ = *((UBYTE*)from)++;
					case 3:			*((UBYTE*)to)++ = *((UBYTE*)from)++;
					case 2:			*((UBYTE*)to)++ = *((UBYTE*)from)++;
					case 1:			*((UBYTE*)to)++ = *((UBYTE*)from)++;
								} while (--blocks);
				}
			}
		}
		break;
	}
}

