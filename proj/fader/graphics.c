/***************************************************************************
**                                                                        **
** File:         fader.c                                                  **
** Description:                                                           **
** Comment(s):                                                            **
** Created:      2005-11-12                                               **
** Updated:      2005-11-12                                               **
** Author(s):    Karl Churchill                                           **
** Note(s):                                                               **
**                                                                        **
****************************************************************************/

#include "graphics.h"

#include <graphics/displayinfo.h>
#include <cybergraphx/cybergraphics.h>

#include <proto/graphics.h>
#include <proto/intuition.h>
#include <proto/cybergraphics.h>
#include <libraries/asl.h>

#include <clib/alib_protos.h>
#include <clib/dos_protos.h>
#include <clib/datatypes_protos.h>
#include <datatypes/pictureclass.h>

/* globals */

struct IntuitionBase* IntuitionBase = NULL;
struct Library* Warp3DBase = NULL;
struct Library* CyberGfxBase = NULL;

W3D_Context* context = NULL;

/* private */

static W3D_Scissor scissor = {0,0,0,0};
static struct Screen* screen = NULL;
static struct Window* window = NULL;
static struct ScreenBuffer* buffer[2] = {0,0};

static uint32 pixelFormat;		/* true screen pixel format */
static uint16 screenWidth;		/* true screen width */
static uint16 screenHeight;		/* true screen height */
static uint32 hNano;					/* horizontal timing in nanosecs */
static uint32 vMicro;					/* vertical timing in microsecs */
static sint16 drawBuffer = 1;
static const char* pixelFormats[] = {
	"PIXFMT_LUT8",
	"PIXFMT_RGB15",
	"PIXFMT_BGR15",
	"PIXFMT_RGB15PC",
	"PIXFMT_BGR15PC",
	"PIXFMT_RGB16",
	"PIXFMT_BGR16",
	"PIXFMT_RGB16PC",
	"PIXFMT_BGR16PC",
	"PIXFMT_RGB24",
	"PIXFMT_BGR24",
	"PIXFMT_ARGB32",
	"PIXFMT_ARGB32",
	"PIXFMT_BGRA32",
	"PIXFMT_RGBA32"
};

/* initialised flag for whole file */
static uint8	initialised = 0;


/*****************************************************************************/

/* query display */

uint16 getDisplayWidth(void)
{
	return screenWidth;
}

uint16 getDisplayHeight(void)
{
	return screenHeight;
}

uint32 getDisplayFormat(void)
{
	return pixelFormat;
}

/*****************************************************************************/

/*
	Open libraries
*/

static uint32 openAmigaLibraries(void)
{
	/* ask for intuition v39 */
	if (!(IntuitionBase = (struct IntuitionBase*)OpenLibrary("intuition.library", 39L))) {
		fprintf(stderr, "Failed to open intuition.library v39\n");
		return 0;
	}
	/* ask for CGX, any old version for now */
	if (!(CyberGfxBase = OpenLibrary("cybergraphics.library", 0L))) {
		fprintf(stderr, "Failed to open cybergraphics.library\n");
		return 0;
	}

	/* ask for v4 of warp3d for vertex array methods */
	if (!(Warp3DBase = OpenLibrary("Warp3D.library", 4L))) {
		fprintf(stderr, "Failed to open Warp3D.library v4\n");
		return 0;
	}
	return 1;
}

/*****************************************************************************/

/*
	Close Libraries
*/

static void closeAmigaLibraries(void)
{
	if (Warp3DBase) {
		CloseLibrary(Warp3DBase);
		Warp3DBase = NULL;
	}
	if (CyberGfxBase) {
		CloseLibrary(CyberGfxBase);
		CyberGfxBase = NULL;
	}
	if (IntuitionBase) {
		CloseLibrary((struct Library*)IntuitionBase);
		IntuitionBase = 0;
	}
}

/*****************************************************************************/

/*
	Create Display
*/

static uint32 createDisplay(sint32 w, sint32 h)
{
	/* I don't like varargs version of taglist functions */
	struct TagItem tags[9];
	struct MonitorInfo monInfo;
	uint32 modeId;
	uint32 error;

	/* get a supported mode */
	tags[0].ti_Tag	= W3D_SMR_TYPE;
	tags[0].ti_Data	= (uint32)W3D_DRIVER_3DHW;
	tags[1].ti_Tag	= W3D_SMR_SIZEFILTER;
	tags[1].ti_Data	= (uint32)TRUE;
	tags[2].ti_Tag	= W3D_SMR_DESTFMT;
	tags[2].ti_Data	= (uint32)(~W3D_FMT_CLUT);
	tags[3].ti_Tag	= ASLSM_MinWidth;
	tags[3].ti_Data	= (uint32)w,
	tags[4].ti_Tag	= ASLSM_MinHeight;
	tags[4].ti_Data	= (uint32)h, // min screenmode
	tags[5].ti_Tag	= ASLSM_MaxWidth;
	tags[5].ti_Data	= (uint32)w,
	tags[6].ti_Tag	= ASLSM_MaxHeight;
	tags[6].ti_Data	= (uint32)h, // max screenmode
	tags[7].ti_Tag	= ASLSM_MaxDepth;
	tags[7].ti_Data	= 16UL;
	tags[8].ti_Tag	= TAG_DONE;
	tags[8].ti_Data	= 0UL;

	modeId = W3D_RequestMode(tags);
	if (modeId == INVALID_ID) {
		fprintf(stderr, "Failed to obtain a valid mode Id\n");
		return 0;
	}

	/* open the screen */
	tags[0].ti_Tag	= SA_Depth;
	tags[0].ti_Data	= 16UL;
	tags[1].ti_Tag	= SA_DisplayID;
	tags[1].ti_Data	= modeId;
	tags[2].ti_Tag	= SA_ErrorCode;
	tags[2].ti_Data	= (uint32)(&error);
	tags[3].ti_Tag	= SA_ShowTitle;
	tags[3].ti_Data	= (uint32)FALSE;
	tags[4].ti_Tag	= SA_Draggable;
	tags[4].ti_Data	= (uint32)FALSE;
	tags[5].ti_Tag	= TAG_DONE;
	tags[5].ti_Data	= 0UL;

	if (!(screen = OpenScreenTagList(NULL, tags))) {
		fprintf(stderr, "Failed to open screen\n");
		return 0;
	}

	/* allocate screen buffers */
	if (!(buffer[0] = AllocScreenBuffer(screen, NULL, SB_SCREEN_BITMAP))) {
		fprintf(stderr, "Failed to create primary ScreenBuffer\n");
		return 0;
	}
	if (!(buffer[1] = AllocScreenBuffer(screen, NULL, 0))) {
		fprintf(stderr, "Failed to create secondary ScreenBuffer\n");
		return 0;
	}

	/*
		Query the basic properties of the returned display

		We assume any mode ID returned by Warp3D is CGX friendly.
		If feeling anal, you can check the mode ID first.
		Here we get the true properties of our graphics system, namely
		the display width, height, pixel format and timing characteristics.
		The basic stuff we get from GetCyberIDAttr(), the timing stuff we
		need to get from a MonitorInfo record.
	*/
	screenWidth		= GetCyberIDAttr(CYBRIDATTR_WIDTH, modeId);
	screenHeight	= GetCyberIDAttr(CYBRIDATTR_HEIGHT, modeId);
	pixelFormat		= GetCyberIDAttr(CYBRIDATTR_PIXFMT, modeId);

	scissor.left = 0;
	scissor.top = 0;
	scissor.width = screenWidth;
	scissor.height = screenHeight;

	if (GetDisplayInfoData(0, (uint8*)&monInfo, sizeof(struct MonitorInfo), DTAG_MNTR,
			modeId) >= offsetof(struct MonitorInfo, TotalColorClocks) ) {
		hNano = (280*(uint32)monInfo.TotalColorClocks);
		vMicro = (280*(uint32)monInfo.TotalColorClocks*(uint32)monInfo.TotalRows)/1000;
	}

	/* yay */
	return 1;
}

/*****************************************************************************/

/*
	Destroy Display
*/

static void destroyDisplay(void)
{
	if (buffer[0]) {
		buffer[0]->sb_DBufInfo->dbi_SafeMessage.mn_ReplyPort = 0;
		while (!ChangeScreenBuffer(screen, buffer[0]))
			;
		FreeScreenBuffer(screen, buffer[0]);
		buffer[0] = 0;
	}
	if (buffer[1]) {
		FreeScreenBuffer(screen, buffer[1]);
		buffer[1] = 0;
	}
	if (screen) {
		CloseScreen(screen);
		screen = NULL;
		window = NULL;
	}
}

/*****************************************************************************/

uint32 initGraphics(sint32 w, sint32 h)
{
	/* I don't like varargs version of taglist functions */
	struct TagItem tags[6];
	uint32 error;

	/* open needed libraries */
	if (!openAmigaLibraries()) {
		goto failed;
	}

	if (!createDisplay(w, h)) {
		goto failed;
	}

	/* create a context */
	tags[0].ti_Tag	= W3D_CC_BITMAP;
	tags[0].ti_Data	= (uint32)(screen->RastPort.BitMap);
	tags[1].ti_Tag	= W3D_CC_DRIVERTYPE;
	tags[1].ti_Data	= W3D_DRIVER_BEST;
	tags[2].ti_Tag	= W3D_CC_FAST;
	tags[2].ti_Data	= (uint32)TRUE,
	tags[3].ti_Tag	= W3D_CC_YOFFSET;
	tags[3].ti_Data	= 0UL;
	tags[4].ti_Tag	= TAG_DONE;
	tags[4].ti_Data	= 0UL;

	context = W3D_CreateContext(&error, tags);
	switch((sint32)error) {
		case W3D_SUCCESS:
			break;
		case W3D_ILLEGALINPUT:
			fprintf(stderr, "W3D_CreateContext() - bad parameters\n");
			goto failed;
			break;
		case W3D_NOMEMORY:
			fprintf(stderr, "W3D_CreateContext() - insufficient memory\n");
			goto failed;
			break;
		case W3D_NODRIVER:
			fprintf(stderr, "W3D_CreateContext() - no driver available\n");
			goto failed;
			break;
		case W3D_UNSUPPORTEDFMT:
			fprintf(stderr, "W3D_CreateContext() - unsupported format\n");
			goto failed;
			break;
		case W3D_ILLEGALBITMAP:
			fprintf(stderr, "W3D_CreateContext() - illegal BitMap\n");
			goto failed;
			break;
		default:
			fprintf(stderr, "W3D_CreateContext() - undiagnosed error code %lu\n", error);
			goto failed;
			break;
	}

	/* define the initial states */
	W3D_SetDrawRegion(context, buffer[drawBuffer]->sb_BitMap,0, &scissor);
	W3D_SetBlendMode(context, W3D_SRC_ALPHA, W3D_ONE_MINUS_SRC_ALPHA);

	/* set initial states to known defaults */
	W3D_SetState(context, W3D_SCISSOR, W3D_ENABLE);
	W3D_SetState(context, W3D_DITHERING, W3D_ENABLE);
	W3D_SetState(context, W3D_GOURAUD, W3D_DISABLE);
	W3D_SetState(context, W3D_TEXMAPPING, W3D_DISABLE);
	W3D_SetState(context, W3D_ZBUFFER, W3D_DISABLE);
	W3D_SetState(context, W3D_ZBUFFERUPDATE, W3D_DISABLE);
	W3D_SetState(context, W3D_GLOBALTEXENV, W3D_DISABLE);
	W3D_SetState(context, W3D_BLENDING, W3D_DISABLE);

	/* clear the display to black (both buffers) */
	if (W3D_LockHardware(context)==W3D_SUCCESS) {
		W3D_ClearDrawRegion(context, 0);
		W3D_UnLockHardware(context);
	}
	refreshDisplay();

	if (W3D_LockHardware(context)==W3D_SUCCESS) {
		W3D_ClearDrawRegion(context, 0);
		W3D_UnLockHardware(context);
	}
	refreshDisplay();

	/* we are outta here! */
	initialised = 1;
	return 1;

failed:
	/* its all gone horribly wrong! */
	fflush(stderr);
	doneGraphics();
	return 0;
}

/*****************************************************************************/

void doneGraphics(void)
{
	if (context) {
		//W3D_FreeAllTexObj(context);
		W3D_DestroyContext(context);
		context = NULL;
	}
	destroyDisplay();
	closeAmigaLibraries();
	initialised = 0;
}

/*****************************************************************************/

void dumpGraphicsInfo(FILE* fp)
{
	/* general debug dump, prints graphics info to whatever file stream you ask*/
	fprintf(fp, "--- Graphics ---\n");
	if (!initialised) {
		fprintf(fp, "Error: Graphics not initialised\n");
		fflush(fp);
		return;
	}
	fprintf(fp, "Screen %4hd x %4hd: %s, allocated at 0x%08X\n",
		screenWidth, screenHeight,
		pixelFormats[pixelFormat],
		(unsigned)(screen)
	);
	fprintf(fp, "Horizontal period : %lu nanosecs (%.2f kHz)\n",
		hNano, 1000000.0 / (float64)hNano
	);
	fprintf(fp, "Vertical period   : %lu microsecs (%.2f Hz)\n",
		vMicro, 1000000.0 / (float64)vMicro
	);
	fprintf(fp, "Primary buffer allocated at 0x%08X\n",
		(unsigned)(buffer[0])
	);
	fprintf(fp, "Secondary buffer allocated at 0x%08X\n",
		(unsigned)(buffer[1])
	);
	fprintf(fp, "W3D_Context allocated at 0x%08X\n",
		(unsigned)context
	);
	fprintf(fp, "----------------\n");
}

/*****************************************************************************/

void refreshDisplay(void)
{
	/* ideally, you should use proper dbi message driven system, this is a bit hacky */
	buffer[drawBuffer]->sb_DBufInfo->dbi_SafeMessage.mn_ReplyPort=0;
	while (!ChangeScreenBuffer(screen, buffer[drawBuffer]))
		;
	drawBuffer ^=1;
	/* reset the draw region */
	W3D_SetDrawRegion(context, buffer[drawBuffer]->sb_BitMap,0, &scissor);
	WaitBOVP(&(screen->ViewPort));
}

/*****************************************************************************/

static uint32 idealSize(uint32 size)
{
	/* quickly work out the smallest power of 2 >= size */
	uint32 n=1;
	while (n<size) {
		n<<=1;
	}
	return n;
}

/*****************************************************************************/

Texture* loadTexture(const char* fileName, int setAlpha)
{
	/* Loads texture data from a dataype :-D */
	struct				TagItem tags[5];
	struct				BitMapHeader* bmHead;
	uint32				error;
	uint32				numColours;
	uint32*				clrRegs;
	uint8*				pAlpha;
	sint32				numTexels;
	W3D_Texture*	w3dTex = 0;
	Texture*			tex = 0;
	Object*				dtImage = 0;

	uint32				allocSize;

	if (!fileName)
		return NULL;

	setAlpha &= 0xFF;

	tags[0].ti_Tag	= DTA_GroupID;
	tags[0].ti_Data	= GID_PICTURE;
	tags[1].ti_Tag	= PDTA_Remap;
	tags[1].ti_Data	= (uint32)FALSE;
	tags[2].ti_Tag	= PDTA_DestMode;
	tags[2].ti_Data	= PMODE_V43;
	tags[3].ti_Tag	= TAG_DONE;
	tags[3].ti_Data	= 0UL;

	/*
		Create a picture datatype instance from the filename. We are only
		concerned with obtaining the internal pixel array data so we need
		to use v43 compliant image datatypes only.
	*/

	if (!(dtImage = NewDTObjectA((char*)fileName, tags)))
		return NULL;

	/* Load and decode the datatype */
	DoMethod(dtImage, DTM_PROCLAYOUT, NULL, 1);

	/* get properties */
	tags[0].ti_Tag	= PDTA_BitMapHeader;
	tags[0].ti_Data	= (uint32)(&bmHead);
	tags[1].ti_Tag	= PDTA_NumColors;
	tags[1].ti_Data	= (uint32)(&numColours);
	tags[2].ti_Tag	= PDTA_CRegs;
	tags[2].ti_Data	= (uint32)(&clrRegs);
	tags[3].ti_Tag	= TAG_DONE;
	tags[3].ti_Data	= 0UL;
	GetDTAttrsA(dtImage, tags);

	/* check the image dimensions */
	if (bmHead->bmh_Width!=idealSize(bmHead->bmh_Width)) {
		fprintf(stderr, "loadDTTexture() - width %ld is not a power of 2\n", (sint32)bmHead->bmh_Width);
		goto failed;
	}

	if (bmHead->bmh_Height!=idealSize(bmHead->bmh_Height)) {
		fprintf(stderr, "loadDTTexture() - height %ld is not a power of 2\n", (sint32)bmHead->bmh_Height);
		goto failed;
	}

	/* allocate a Texture object and the raw storage together */

	allocSize = sizeof(Texture) + (bmHead->bmh_Width*bmHead->bmh_Height*4);

	if (!(tex = (Texture*)AllocVec(allocSize, MEMF_FAST))) {
		fprintf(stderr, "loadDTTexture() - failed to allocate memory\n");
		goto failed;
	}

	pAlpha		= tex->data;
	numTexels	= bmHead->bmh_Width * bmHead->bmh_Height;

	/* use PDTM_READPIXELARRAY to copy the image data as ARGB32 */
	DoMethod(
		dtImage,
		PDTM_READPIXELARRAY,
		tex->data,
		PBPAFMT_ARGB,
		(bmHead->bmh_Width<<2),	/* bytes per row */
		0,
		0,
		(bmHead->bmh_Width),
		(bmHead->bmh_Height)
	);
	tex->width		= bmHead->bmh_Width;
	tex->height		= bmHead->bmh_Height;
	tex->format		= W3D_A8R8G8B8;
	DisposeDTObject(dtImage);
	dtImage = 0;

	/*
		Most datatypes don't supply the alpha channel, fill the alpha channel component
		with the supplied value, unless zero (then assume the image contains the alpha)
	*/
	if (setAlpha) {
		while (numTexels--) {
			*pAlpha = setAlpha;
			pAlpha += 4;
		}
	}

	/*
		Now we need to allocate a Warp3D texture
	*/

	tags[0].ti_Tag	= W3D_ATO_IMAGE;
	tags[0].ti_Data	= (uint32)(tex->data);
	tags[1].ti_Tag	= W3D_ATO_FORMAT;
	tags[1].ti_Data	= (uint32)(tex->format);
	tags[2].ti_Tag	= W3D_ATO_WIDTH;
	tags[2].ti_Data	= (uint32)(tex->width);
	tags[3].ti_Tag	= W3D_ATO_HEIGHT;
	tags[3].ti_Data	= (uint32)(tex->height);
	tags[4].ti_Tag	= TAG_DONE;
	tags[4].ti_Data	= 0UL;

	if (!(w3dTex = W3D_AllocTexObj(context, &error, tags))) {
		switch((sint32)error) {
			case W3D_ILLEGALINPUT:
				fprintf(stderr, "loadDTTexture() - illegal parameters for W3D_AllocTexObj()\n");
				break;
			case W3D_NOMEMORY:
				fprintf(stderr, "loadDTTexture() - insufficient memory for W3D_AllocTexObj()\n");
				break;
			case W3D_NOPALETTE:
				fprintf(stderr, "loadDTTexture() - palette required for W3D_AllocTexObj()\n");
				break;
			case W3D_UNSUPPORTEDTEXFMT:
				fprintf(stderr, "loadDTTexture() - unsupported texture format for W3D_AllocTexObj()\n");
				break;
			default:
				fprintf(stderr, "loadDTTexture() - undiagnosed error return for W3D_AllocTexObj()\n");
				break;
		}
		goto failed;
	}

	/*
		initialise the texture filter and environment and ask that it be uploaded
	*/
	W3D_SetFilter(context, w3dTex, W3D_NEAREST, W3D_NEAREST);
	W3D_SetTexEnv(context, w3dTex, W3D_REPLACE, 0);
	W3D_UploadTexture(context, w3dTex);

	tex->texture = w3dTex;
	return tex;

failed:
	fflush(stderr);
	if (w3dTex) {
		W3D_FreeTexObj(context, w3dTex);
	}
	if (tex) {
		FreeVec(tex);
	}
	if (dtImage) {
		DisposeDTObject(dtImage);
	}
	return NULL;
}

/*****************************************************************************/

void freeTexture(Texture* texture)
{
	if (!texture) {
		fprintf(stderr, "freeTexture() attempt to free null pointer\n");
		return;
	}
	if (context && texture->texture) {
		W3D_FreeTexObj(context, texture->texture);
	}
	FreeVec(texture);
}

/*****************************************************************************/

/* size defs for custom vertex array support */
#define DV_OFS_XYZ	0									/* byte offset of xyz data */
#define DV_OFS_UV		4*sizeof(float32)	/*  "     "    "  uv (texture coord) data */
#define DV_OFS_W		-sizeof(float32)	/*  "     "    "  w from uv */
#define DV_OFS_V		sizeof(float32)		/*  "     "    "  v from uv */
#define DV_OFS_CLR	6*sizeof(float32)	/*  "     "    "  colour data */
#define DV_STRIDE		sizeof(Vertex)		/*  "     "    "  sequential vertices */

uint32 setVertexPointer(Vertex* v)
{
	/* set the warp3d vertex pointers to understand our Vertex format */
	uint8* vrtPtrX = (uint8*)v+DV_OFS_XYZ;
	uint8* clrPtrA = (uint8*)v+DV_OFS_CLR;
	uint8* texPtrUS = (uint8*)v+DV_OFS_UV;

	if (!context)
		return 0;

	W3D_VertexPointer(context, vrtPtrX, DV_STRIDE, W3D_VERTEX_F_F_F, 0);
	W3D_TexCoordPointer(context, texPtrUS, DV_STRIDE, 0, DV_OFS_V, DV_OFS_W, 0);
	W3D_ColorPointer(context, clrPtrA, DV_STRIDE, W3D_COLOR_UBYTE, W3D_CMODE_ARGB, 0);
	return 1;
}
