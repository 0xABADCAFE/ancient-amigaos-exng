/***************************************************************************
**                                                                        **
** File:         madrats/fader.h                                          **
** Description:                                                           **
** Comment(s):                                                            **
** Created:      2005-11-12                                               **
** Updated:      2005-11-12                                               **
** Author(s):    Karl Churchill                                           **
** Note(s):                                                               **
**                                                                        **
****************************************************************************/

#ifndef _FADER_H_
#define _FADER_H_

/* this is just a gap filler for framework xbase definitions */

typedef signed char sint8;
typedef signed short int sint16;
typedef signed long int sint32;
typedef signed long long int sint64;
typedef unsigned char uint8;
typedef unsigned short int uint16;
typedef unsigned long int uint32;
typedef unsigned long long int uint64;
typedef float float32;
typedef double float64;

#define rsint8 register sint8
#define rsint16 register sint16
#define rsint32 register sint32
#define rsint64 register sint64
#define ruint8 register uint8
#define ruint16 register uint16
#define ruint32 register uint32
#define ruint64 register uint64
#define rfloat32 register float32
#define rfloat64 register float64

/* system includes */
#include <stdio.h>
#include <exec/types.h>
#include <proto/exec.h>
#include <proto/warp3d.h>

/*
	Simple vertex format
*/

typedef struct Vertex_s {
	float32 x, y, z;
	float32 w, u, v;

	/*WARNING - ASSUMES BIG ENDIAN CPU*/
	union {
		/* longword access */
		uint32 argb;

		/* unsigned 8-bit channel access */
		struct {
			uint8 a;
			uint8 r;
			uint8 g;
			uint8 b;
		} chan;
	} colour;
} Vertex;


/*
	Simple Texture object
*/
typedef struct Texture_s {
	W3D_Texture*	texture;
	uint32				format;
	sint16				width;
	sint16				height;
	uint8					data[4]; /* this is actually open ended, raw texel data starts here */
} Texture;

/* warp3d context */
extern				W3D_Context* context;

/* allocate and initialise graphics resources */
extern uint32	initGraphics(sint32 width, sint32 height);

/* free graphics resources */
extern void		doneGraphics(void);

/* show graphics info */
extern void		dumpGraphicsInfo(FILE* fp);

/* display refresh */
extern void		refreshDisplay(void);

/* display query */
extern uint16	getDisplayWidth(void);
extern uint16	getDisplayHeight(void);
extern uint32	getDisplayFormat(void);

/* texture stuff */
extern Texture*	loadTexture(const char* fileName, int setAlpha);
extern void			freeTexture(Texture* texture);

/* vertex stuff */

extern uint32		setVertexPointer(Vertex* v);

#endif
