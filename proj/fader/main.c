/***************************************************************************
**                                                                        **
** File:         main.c                                                   **
** Description:                                                           **
** Comment(s):                                                            **
** Created:      2005-11-12                                               **
** Updated:      2005-11-12                                               **
** Author(s):    Karl Churchill                                           **
** Note(s):                                                               **
**                                                                        **
****************************************************************************/

#include "graphics.h"

#include <proto/dos.h>

Texture*	textures[2] = {0, 0};
Vertex		vertices[4];

static W3D_Color flat = { 1.0, 1.0, 1.0, 1.0 };	/* colour for flatshade version */
static const float32 normChannel = 1.0/256.0;		/* scales uint8 colour channel to float */


/* texture list to load */
static const char* texNames[] = {
	"gfx/arnie.jpg",
	"gfx/peanut.jpg"
};

#define		NUM_TEX 2


static uint8 useFlat = 0;

/* clean up our texture(s) */
void doneTextures(void)
{
	int i;
	/* traverse the array of textures and release any found */
	for (i=0; i<NUM_TEX; i++) {
		if (textures[i]) {
			freeTexture(textures[i]);
			textures[i] = 0;
		}
	}
}

/* initialise all our texture(s) */
uint32 initTextures(void)
{
	int i;
	for (i=0; i<NUM_TEX; i++) {
		/* traverse the array of textures and try to load them */
		if (!(textures[i] = loadTexture(texNames[i], 0xFF))) {
			doneTextures();
			return 0;
		}
		printf("Loaded texture '%s'\n", texNames[i]);
		/* set desired texture environment and filter mode */
		W3D_SetTexEnv(context, textures[i]->texture, W3D_MODULATE, 0);
		W3D_SetFilter(context, textures[i]->texture, W3D_LINEAR, W3D_LINEAR);
	}
	return 1;
}

/* initialise our vertex array */
uint32 initVerts(void)
{
	float32 w = getDisplayWidth();
	float32 h = getDisplayHeight();

	/*
		only initialise the basic polygon vertices
		as the fade functions will change the colour
		and texture coords of the vertex anyway.
	*/
	vertices[0].x = 0.5*(w-h);
	vertices[0].y = 0;
	vertices[0].w = 0;

	vertices[1].x = 0.5*(w+h);
	vertices[1].y = 0;
	vertices[1].w = 0;

	vertices[2].x = 0.5*(w-h);
	vertices[2].y = h;
	vertices[2].w = 0;

	vertices[3].x = 0.5*(w+h);
	vertices[3].y = h;
	vertices[3].w = 0;

	if (setVertexPointer(vertices)) {
		printf("Vertices initialised OK\n");
		return 1;
	}
	printf("Vertex initialisation failed\n");
	return 0;
}

/*
	This works by using W3D_MODULATE and a vertex
	colour that ramps from black to white through
	all available greyscales.
*/

void fadeBlack(uint32 dir, Texture* t)
{
	uint32 grey;
	sint32 start, end, step;
	if (dir) {
		start = 0;
		end = 255;
		step = 1;
	} else {
		start = 255;
		end = 0;
		step = -1;
	}

	/* bind the texture we want to use */
	W3D_BindTexture(context, 0, t->texture);

	/* set the states we want for this effect */
	W3D_SetState(context, W3D_BLENDING, W3D_DISABLE);
	W3D_SetState(context, W3D_GOURAUD, (useFlat ? W3D_DISABLE : W3D_ENABLE));

	/* set up texture coordinates */
	vertices[0].u = 0;
	vertices[0].v = 0;

	vertices[1].u = t->width;
	vertices[1].v = 0;

	vertices[2].u = 0;
	vertices[2].v = t->height;

	vertices[3].u = t->width;
	vertices[3].v = t->height;

	/* fade in over 256 steps */
	for (grey=start; grey!=end; grey+=step) {
		if (useFlat) {
			/* create the required flatshade grey colour */
			flat.r = grey * normChannel;
			flat.g = grey * normChannel;
			flat.b = grey * normChannel;
			W3D_SetCurrentColor(context, &flat);
		}
		else {
			/* set the vertex greyscale */
			uint32 argb = 0xFF000000 | grey<<16 | grey<<8 | grey;
			vertices[0].colour.argb = argb;
			vertices[1].colour.argb = argb;
			vertices[2].colour.argb = argb;
			vertices[3].colour.argb = argb;
		}
		if (W3D_LockHardware(context)==W3D_SUCCESS) {
			W3D_DrawArray(context, W3D_PRIMITIVE_TRISTRIP, 0, 4);
			W3D_UnLockHardware(context);
		}
		refreshDisplay();
	}
}

void fadeImage(Texture* t1, Texture* t2)
{
	uint32 alpha;

	if (useFlat) {
		/* make sure the flatshade colour is white */
		flat.r = 1.0;
		flat.g = 1.0;
		flat.b = 1.0;
	}

	/* set the states we want for this effect */
	W3D_SetBlendMode(context, W3D_SRC_ALPHA, W3D_ONE_MINUS_SRC_ALPHA);
	W3D_SetState(context, W3D_GOURAUD, (useFlat ? W3D_DISABLE : W3D_ENABLE));

	/* fade  over 256 steps */
	for (alpha=0; alpha<255; alpha++) {
		if (useFlat) {
			flat.a = alpha * normChannel;
			W3D_SetCurrentColor(context, &flat);
		}
		else {
			/* set the vertex alpha */
			uint32 argb = 0x00FFFFFF | alpha<<24;
			vertices[0].colour.argb = argb;
			vertices[1].colour.argb = argb;
			vertices[2].colour.argb = argb;
			vertices[3].colour.argb = argb;
		}
		if (W3D_LockHardware(context)==W3D_SUCCESS) {
			/* set up the texture and texture coords for the background image */
			/* nobody said the textures have to be the same size ;-) */

			W3D_BindTexture(context, 0, t1->texture);
			vertices[0].u = 0;
			vertices[0].v = 0;

			vertices[1].u = t1->width;
			vertices[1].v = 0;

			vertices[2].u = 0;
			vertices[2].v = t1->height;

			vertices[3].u = t1->width;
			vertices[3].v = t1->height;

			/* turn off blending and draw background image */
			W3D_SetState(context, W3D_BLENDING, W3D_DISABLE);
			W3D_DrawArray(context, W3D_PRIMITIVE_TRISTRIP, 0, 4);

			/* set up the texture and texture coords for the foreground image */
			/* nobody said the textures have to be the same size ;-) */

			W3D_BindTexture(context, 0, t2->texture);
			vertices[0].u = 0;
			vertices[0].v = 0;

			vertices[1].u = t2->width;
			vertices[1].v = 0;

			vertices[2].u = 0;
			vertices[2].v = t2->height;

			vertices[3].u = t2->width;
			vertices[3].v = t2->height;

			/* turn on blending and draw foreground image */
			W3D_SetState(context, W3D_BLENDING, W3D_ENABLE);
			W3D_DrawArray(context, W3D_PRIMITIVE_TRISTRIP, 0, 4);
			W3D_UnLockHardware(context);
		}
		refreshDisplay();
	}
}


int main(int argN, char** argV)
{
	if (initGraphics(640, 480)) {
		printf("Graphics initialised OK\n");
		dumpGraphicsInfo(stdout);

		/* this is naughty but kind of essential :-( */

		switch(context->CurrentChip) {
			case W3D_CHIP_VIRGE:
				printf("Virge - this probably about as far as you will get...\n");
				break;

			case W3D_CHIP_PERMEDIA2:
				printf("Permedia2\n");
				useFlat = 1;
				break;
			case W3D_CHIP_VOODOO1:
				printf("Voodoo1\n");
				break;

			case W3D_CHIP_AVENGER_LE:
				printf("Voodoo Avenger (little endian)\n");
				break;

			case W3D_CHIP_AVENGER_BE:
				printf("Voodoo Avenger (big endian)\n");
				break;

			case W3D_CHIP_PERMEDIA3:
				printf("Permedia3\n");
				break;

			case W3D_CHIP_RADEON:
				printf("First generation radeon\n");
				break;

			case W3D_CHIP_RADEON2:
				printf("Second generation radeon\n");
				break;

			default:
				break;
		}

		/* initialise some of the unchanging states we want */
		W3D_SetState(context, W3D_DITHERING, W3D_ENABLE);
		W3D_SetState(context, W3D_TEXMAPPING, W3D_ENABLE);
		W3D_SetState(context, W3D_PERSPECTIVE, W3D_DISABLE);
		W3D_SetState(context, W3D_GOURAUD, W3D_DISABLE);

		if (initTextures()) {
			printf("Textures initialised OK\n");
			if (initVerts()) {

				/* wait a while */
				Delay(150);

				/* fade texture 0 from black */
				fadeBlack(1, textures[0]);
				Delay(50);

				/* crossfade texture 0 to texture 1 */
				fadeImage(textures[0], textures[1]);
				Delay(50);

				/* crossfade texture 1 to texture 0 */
				fadeImage(textures[1], textures[0]);
				Delay(50);

				/* fade texture 0 to black */
				fadeBlack(0, textures[0]);
				Delay(50);

			}
			doneTextures();
		}
		doneGraphics();
	}
 	return 0;
}