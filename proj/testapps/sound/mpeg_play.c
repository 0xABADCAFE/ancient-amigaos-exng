/*------------------------------------------------------------------------------

   Streamer2 MPEG player (based on MPEGA by Stephane Tavernard)
	Version 2 (24-May-2003)

------------------------------------------------------------------------------*/

#include <exec/exec.h>
#include <clib/exec_protos.h>
#include <pragmas/exec_pragmas.h>
#include <sys/types.h>
#include <dos.h>
#include <proto/dos.h>

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <devices/ahi.h>
#include <proto/ahi.h>

#include <libraries/mpega.h>
#include <clib/mpega_protos.h>
#include <pragmas/mpega_pragmas.h>

struct MsgPort    *AHImp       = NULL;
struct AHIRequest *AHIio       = NULL;
struct AHIRequest *AHIio2      = NULL;
BYTE               AHIDevice   = -1;

extern char *OutFileName;

struct Library *MPEGABase = NULL;

signed short *outbuf=NULL,*dubbuf=NULL;

MPEGA_STREAM *mps = NULL;


// Ram buffer
#define PCM_BUFFER_SIZE (MPEGA_MAX_CHANNELS*MPEGA_PCM_SIZE) //from mpega.h
#define AHIBUFFERSIZE MPEGA_PCM_SIZE*sizeof(WORD)
#define AHI_BUFFERS 24 /* no. of PCM_BUFFER_SIZE to write to AHI */

BYTE   *mpega_buffer = NULL;
ULONG  mpega_buffer_offset = 0;
ULONG  mpega_buffer_size = 0;

static int break_cleanup( void )
{
	if( mps ) {
		MPEGA_close( mps );
		mps = NULL;
	}
	if( MPEGABase ) {
		CloseLibrary( MPEGABase );
		MPEGABase = NULL;
	}
	if (AHIio) {
		AbortIO((struct IORequest *) AHIio);
		WaitIO((struct IORequest *) AHIio);
	}

	if(!AHIDevice) {
		CloseDevice((struct IORequest *)AHIio);
		AHIDevice = -1;
	}

	if(AHIio) {
	  DeleteIORequest((struct IORequest *)AHIio);
	  AHIio = NULL;
	}

	if(AHIio2) {
	  DeleteIORequest((struct IORequest *)AHIio2);
	  AHIio2 = NULL;
	}

	if(AHImp) {
	  DeleteMsgPort(AHImp);
	  AHImp = NULL;
	}

	return 1;
}

static void exit_cleanup( void )
{
	(void)break_cleanup();
}



int main(int argc, char *argv[])
{

		/* Edit the following to control volume, quality, etc */

	WORD fdiv=2; //1 full, 2 half, 4 quarter
	WORD qual=1; // 0 low - 2 high
	LONG mixfreq=44100; //Mix frequency -- fdiv must be set to 0
	double MPEG_vol=1; // Volume -- 0-1
	double MPEG_bal=0.5; //Balance 0=L 1=R
	ULONG MPEG_unit=2; //AHI output unit


	char *in_filename = argv[1]; // file to play, from command line
	int frame = 0;						//generic frame counter
	WORD i;								//generic counter
	LONG pcm_count= 1, total_pcm = 0; //count current pcm frames and total pcm frames
	WORD *pcma[ MPEGA_MAX_CHANNELS ]; //allocate an array of buffers for audio (most likely 2 of them)
	WORD *AHIpcmbuf, *AHIpcmdbuf;     //pointers to AHI PCM audio buffers
	register WORD *pcm0, *pcm1, *pcmLR; //pointers to use to copy to PCM buffers


	clock_t clk;
	int custom = 0;
	long br_sum = 0;

	static const char *layer_name[] = { "?", "I", "II", "III", };
	static const char *mode_name[] = { "stereo", "j-stereo", "dual", "mono", };


	ULONG AHIaudiotype, AHIcount=0, length=0;
	ULONG signals;
	BOOL terminated =FALSE;
	register int iCount=0;
	void *tmp;					// ptr for temp copy buffer (dbuffering)
	char *mpega_name = "mpega.library";
	struct AHIRequest *link = NULL;

	MPEGA_CTRL mpa_ctrl = {
	NULL,    // Bitstream access is default file I/O
	// Layers I & II settings (mono, stereo)
	{ FALSE, { fdiv, qual, mixfreq }, { fdiv, qual, mixfreq } },
	// Layer III settings (mono, stereo)
	{ FALSE, { fdiv, qual, mixfreq }, { fdiv, qual, mixfreq } },
	0,           // Don't check mpeg validity at start (needed for mux stream)
	16384        // Stream Buffer size
};


	#ifdef DEBUG
	printf( "MPEG Program settings:\n");
	printf( "Frequency Division: %i\n", fdiv);
	printf( "Quality: %i\n", qual);
	printf( "\n");
	#endif



	MPEGABase = OpenLibrary( mpega_name, 0L );
	if( !MPEGABase ) {
		printf("Couldn't open MPEGA.library\n");
		return 1;
	}


	for( i=0; i<MPEGA_MAX_CHANNELS; i++ ) {
		pcma[ i ] = malloc( MPEGA_PCM_SIZE * sizeof( WORD ) );
		if( !pcma[ i ] ) {
			printf("Couldn't allocate PCM buffers\n");
			return 2;
		}

	}


	AHIpcmbuf =  malloc(PCM_BUFFER_SIZE*sizeof(WORD)*AHI_BUFFERS); //buffer
	AHIpcmdbuf = malloc(PCM_BUFFER_SIZE*sizeof(WORD)*AHI_BUFFERS); // spare dbuf


#ifdef DEBUG
	printf( "Default bitstream access used\n" );
	printf( "Buffer size = %d\n", mpa_ctrl.stream_buffer_size );
#endif

	mps = MPEGA_open( in_filename, &mpa_ctrl );
	if( !mps ) {
		printf("MPEGA: Couldn't find audio stream\n");
		return 6;
	}

 /*set up AHI */
	if(AHImp=CreateMsgPort())
	if(AHIio=(struct AHIRequest *)CreateIORequest(AHImp,sizeof(struct AHIRequest)))
	{
		AHIio->ahir_Version = 4;
		AHIDevice=OpenDevice(AHINAME,MPEG_unit,(struct IORequest *)AHIio,NULL);
	}
	AHIio2 = AllocMem(sizeof(struct AHIRequest), MEMF_ANY);
	if (!AHIio2)
		break_cleanup();
	CopyMem(AHIio, AHIio2, sizeof(struct AHIRequest));

#ifdef DEBUG
	printf( "\n" );
	printf( "MPEG norm %d Layer %s\n", mps->norm, layer_name[ mps->layer ] );
	printf( "Bitrate: %d kbps\n", mps->bitrate );
	printf( "Frequency: %d Hz\n", mps->frequency );
	printf( "Mode: %d (%s)\n", mps->mode, mode_name[ mps->mode ] );
	printf( "Stream duration: %ld ms\n", mps->ms_duration );
	printf( "\n" );
	printf( "Output decoding parameters\n" );
	printf( "Channels: %d\n", mps->dec_channels );
	printf( "Quality: %d\n", mps->dec_quality );
	printf( "Frequency: %d Hz\n", mps->dec_frequency );
	printf( "\n" );
  #endif

	/* Automatically determine mono/stereo based on the stream info we have acquired */
	if (mps->dec_channels==1)
		AHIaudiotype = AHIST_M16S;
	else
		AHIaudiotype = AHIST_S16S;

	clk = clock();

			/* Begin main loop */
	while(!terminated) {

		/*Write to AHI */

		pcmLR =AHIpcmbuf;
		for (i=0; i<AHI_BUFFERS; i++) {
			pcm_count = MPEGA_decode_frame( mps, pcma );
			//MPEGA_decode_frame returns a number of samples or -1 on error
			if (pcm_count == -1) {terminated = TRUE; break;}
			br_sum += mps->bitrate;
			total_pcm += pcm_count;
			frame++;
			pcm0 = pcma[ 0 ];
			pcm1 = pcma[ 1 ];
			if (mps->dec_channels == 2) {
				/* Sort audio into proper PCM byte order (WORD) L/R/L/R...*/
				for (iCount=pcm_count; iCount > 0; iCount--) {
					*pcmLR++ = *pcm0++;
					*pcmLR++ = *pcm1++;
				}
			}
			else {
			/* Otherwise, copy the audio to the mono channel */
				for (iCount=pcm_count; iCount > 0; iCount--) {
					*pcmLR++ = *pcm0++;
				}
			}
		}

		/* Now we have copied the decoded PCM audio to buffers, send it to AHI*/

		//Calculate the buffer length (# of MPEG samples * channels * WORD (1 byte) * AHI_BUFFERS
		if (pcm_count>0)
			length = pcm_count*mps->dec_channels*sizeof(WORD)*AHI_BUFFERS;
		else break;

		//Prepare IO request
		AHIio->ahir_Std.io_Message.mn_Node.ln_Pri = 0;
		AHIio->ahir_Std.io_Command  = CMD_WRITE;
		AHIio->ahir_Std.io_Data     = AHIpcmbuf;
		AHIio->ahir_Std.io_Length   = length;
		AHIio->ahir_Std.io_Offset   = 0;
		AHIio->ahir_Frequency       = (ULONG) mps->dec_frequency;
		AHIio->ahir_Type            = AHIaudiotype;
		AHIio->ahir_Volume          = ((Fixed)((float)(MPEG_vol)*0x00010000L));
		AHIio->ahir_Position        = ((Fixed)((float)(MPEG_bal)*0x00010000L));
		AHIio->ahir_Link            = link;
		//Send IO Request
		SendIO((struct IORequest *) AHIio);
		AHIcount++;

		if(link) {
		// Wait until the last buffer is finished (== the new buffer is started)
			signals=Wait(SIGBREAKF_CTRL_C | (1L << AHImp->mp_SigBit));
		// Check for Ctrl-C and abort if pressed
			if(signals & SIGBREAKF_CTRL_C) {
				terminated = TRUE;
			}
		//Remove the reply and abort on error
			if(WaitIO((struct IORequest *) link)) {
				SetIoErr(ERROR_WRITE_PROTECTED);
				break;
			}
		}

	// Check to see if the buffer is part-full and quit if it is
	// Check for end-of-sound, and wait until it is finished before aborting
		if(pcm_count*sizeof(WORD) < MPEGA_PCM_SIZE*(mps->dec_frequency/mps->frequency)) {
			WaitIO((struct IORequest *) AHIio);
			break;
		}

	//Swap the buffers (double-buffering)
		link   = AHIio;
		tmp    = AHIpcmbuf;
		AHIpcmbuf = AHIpcmdbuf;
		AHIpcmdbuf = tmp;
		tmp    = AHIio;
		AHIio  = AHIio2;
		AHIio2 = tmp;

#ifdef DEBUG
		if( (frame & 31) == 0 ) {
			fprintf( stderr, "{%04d} %7.3fkbps pcm count %ld\r", frame, (double)br_sum / (double)(frame+1), pcm_count); fflush( stderr );
		}
#endif

	} /* end while pcm_count */

/*The loop has terminated, so we need to clean up. */
	if(AHIcount) {
		if(terminated) {
			AbortIO((struct IORequest *) AHIio);
			WaitIO((struct IORequest *) AHIio);
			if(AHIcount>1) {
				AbortIO((struct IORequest *) AHIio2);
				WaitIO((struct IORequest *) AHIio2);
			}
		}
		else
			WaitIO((struct IORequest *) AHIio2);
	}
	clk = clock() - clk; // #1
#ifdef DEBUG
	fprintf( stderr, "\n" );
	fprintf( stderr, "last pcm_count = %d\n", pcm_count );
	fprintf( stderr, "total_pcm = %d\n", total_pcm );
	printf("Exiting MPEG Process\n");
#endif
	MPEGA_close( mps );
	mps = NULL;
	CloseLibrary( MPEGABase );
	MPEGABase = NULL;
// Abort any pending iorequests
	break_cleanup();
	return 0;

}
