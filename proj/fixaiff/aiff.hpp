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
#include <exec/types.h>
#include <proto/exec.h>
#include <warp3d/warp3d.h>
#include <clib/warp3d_protos.h>
#include <clib/cybergraphics_protos.h>
#include <pragmas/cybergraphics_pragmas.h>
#include <cybergraphx/cybergraphics.h>
#include <proto/graphics.h>

/*
  Simple vertex format
*/

typedef struct Vertex_s {
  float32 x, y, z;
  float32 u, v, w;
  float32 s, t;

  /*WARNING - ASSUMES BIG ENDIAN*/
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
  } color;
} Vertex;

/*
  Simple texture
*/
typedef struct Texture_s {
  W3D_Texture* w3dTexture;
  void* data;
  sint16 width;
  sint16 height;
} Texture;

/*
  Simple DisplayContext
*/

typedef struct DisplayContext_s {
  struct Screen*        screen;
  struct Window*        window;
  struct ScreenBuffer*  scrBuffer[2];
  W3D_Context*          context;
  W3D_Scissor            scissor;
  sint16                drawBuffer;
} DisplayContext;

#endif
