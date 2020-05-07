//****************************************************************************//
//**                                                                        **//
//** File:         proj/W3DTest/testw3d.hpp                                 **//
//** Description:  Warp3D test application                                  **//
//** Comment(s):   This software calls Warp3D directly and is hence not     **//
//**               portable.                                                **//
//** Created:      2004-01-31                                               **//
//** Updated:      2004-02-01                                               **//
//** Author(s):    Karl Churchill                                           **//
//** Copyright:    (C)1996-2004, eXtropia Studios                           **//
//**               Serkan YAZICI, Karl Churchill                            **//
//**                                                                        **//
//**               Warp3D (C) Hyperion Entertainment                        **//
//**                                                                        **//
//**               All Rights Reserved.                                     **//
//**                                                                        **//
//****************************************************************************//

#ifndef TESDW3D_HPP
#define TESTW3D_HPP

#include <xbase.hpp>
#include <systemlib/thread.hpp>
#include <systemlib/timer.hpp>
#include <iolib/fileio.hpp>
#include <gfxlib/gfxapp.hpp>
#include <gfxlib/gfx3d.hpp>
#include <gfxlib/gfxutil3d.hpp>
#include <utilitylib/quickmath.hpp>

////////////////////////////////////////////////////////////////////////////////
//
//  GenericVertex
//
//  Single vertex structure that supports all Warp3D vertex array formats for
//  testing.
//
////////////////////////////////////////////////////////////////////////////////

struct GenericVertex {
  // vertex position coords
  union {
    // 3 vertex coord formats
    struct { float32 x, y, z;  } fff;
    struct { float32 x, y; float64 z; } ffd;
    struct { float64 x, y, z; } ddd;
  } crd;

  // vertex texture coords
  union {
    // not really different formats, but treat S/T and U/V as seperate
    struct { float32 u, v, w; } uvw;
    struct { float32 s, t, w; } stw;
  } tex;

  // vertex colour coords
  union {
    // 10 vertex colour formats
    struct { uint8 r, g, b, _pad; } urgb;
    struct { uint8 b, g, r, _pad; } ubgr;
    struct { uint8 r, g, b, a; } urgba;
    struct { uint8 a, r, g, b; } uargb;
    struct { uint8 b, g, r, a; } ubgra;
    struct { float32 r, g, b; } frgb;
    struct { float32 b, g, r; } fbgr;
    struct { float32 r, g, b,a; } frgba;
    struct { float32 a, r, g, b; } fargb;
    struct { float32 b, g, r, a; } fbgra;
  } clr;

  typedef enum {
    XYZ_FFF  = 0,
    XYZ_FFD,
    XYZ_DDD,
    _XYZ_NUM
  } VFormat;

  typedef enum {
    CLR_URGB = 0,
    CLR_UBGR,
    CLR_URGBA,
    CLR_UARGB,
    CLR_UBGRA,
    CLR_FRGB,
    CLR_FBGR,
    CLR_FRGBA,
    CLR_FARGB,
    CLR_FBGRA,
    _CLR_NUM
  } CFormat;

  typedef enum {
    TEX_UVW = 0,
    TEX_STW,
    _TEX_NUM
  } TFormat;
};

#define GV_STRIDE    sizeof(GenericVertex)
#define GV_OFS_XYZ  offsetof(GenericVertex, crd)
#define GV_OFS_TEX  offsetof(GenericVertex, tex)
#define GV_OFS_CLR  offsetof(GenericVertex, clr)


////////////////////////////////////////////////////////////////////////////////
//
//  TestWarp3D
//
//  Main application
//
////////////////////////////////////////////////////////////////////////////////

#define MAX_MESH          64  // maximum vertex grid size
#define MIN_MESH          32  // minimum vertex grid size
#define MESH_STEP          16  // minimum vertex grid size
#define MAX_LINEAR_VERTS  3    // maximum linear vertices per primitive (triangle)
#define MESH_TRIS_UNIT    2    // triangles per mesh square
#define  VERT_ALLOC        ((MAX_MESH-1)*(MAX_MESH-1)*MAX_LINEAR_VERTS*MESH_TRIS_UNIT)

#define NUM_DIM (((MAX_MESH - MIN_MESH)/MESH_STEP)+1)

#define MAX_LOCKTIME      100  // maximum hardware lock time (ms)

class TestWarp3D : public AppBase, private RasterizerUser {
  private:
    static char* info;

    static const char dBoxExit[];
    static const char dBoxProceed[];
    static const char dBoxRunSkip[];
    static const char dBoxError[];
    static const char dBoxInfo[];
    static const char dBoxQuery[];
    static const char dBoxBool[];
    static const char qTestPass[];
    static const char qTestFail[];
    static const char qTestSkip[];
    static const char* chipNames[];

    MilliClock  timer;
    void*        data;
    Display*    appWindow;
    Rasterizer*  gfx;
    Texture*    tex;
    const char*  logName;
    StreamOut*  logFile;
    uint32      minTestTime;
    sint16      width;
    sint16      height;

    uint32 check;

    enum {
      CH_VERTEX_FFF    = 0x00000001,
      CH_VERTEX_FFD    = 0x00000002,
      CH_VERTEX_DDD    = 0x00000004,

      CH_VERTEX_ALL    = 0x00000007,

      CH_COLOUR_URGB  = 0x00000008,
      CH_COLOUR_UBGR  = 0x00000010,
      CH_COLOUR_URGBA  = 0x00000020,
      CH_COLOUR_UARGB  = 0x00000040,
      CH_COLOUR_UBGRA  = 0x00000080,

      CH_COLOUR_FRGB  = 0x00000100,
      CH_COLOUR_FBGR  = 0x00000200,
      CH_COLOUR_FRGBA  = 0x00000400,
      CH_COLOUR_FARGB  = 0x00000800,
      CH_COLOUR_FBGRA  = 0x00001000,

      CH_COLOUR_ALL    = 0x00001FF8,

      CH_ARRAY_POINTS  = 0x00002000,
      CH_ARRAY_LINES  = 0x00004000,
      CH_ARRAY_LSTRIP  = 0x00008000,
      CH_ARRAY_LLOOP  = 0x00010000,

      CH_GOTZBUFFER    = 0x00020000,

      CH_MOVE16        = 0x80000000, // used for 040/060

      CH_VERTEX_SHIFT  = 0,
      CH_COLOUR_SHIFT  = 2
    };

    const char*  chip;
    float32      writeVRAMSpeed;      // in K/s
    float32      writeVRAMSpeed16;
    float32      readVRAMSpeed;
    float32      copyR2VSpeed;
    float32      copyR2VSpeed16;
    float32      writeZBufSpeed;      // in Pix/s
    float32      readZBufSpeed;      // in Pix/s
    float32      texUploadSpeed;      // in K/s
    float32      texSubUploadSpeed;  // in K/s

    // Mem:: class has no reverse equivalent of set() method
    // that can be used to estimate memory reading times, so
    // we define one here and implement in asm to ensure that
    // the unused read access is not discarded by the compiler.

    // asm defined
    static void  readMem(void* src, size_t len);
    static void  copyMem16(void *dst, void* src, size_t len);
    static void  setMem16(void *dst, sint32 val, size_t len);

    void    clear();

    void    setArray(GenericVertex* v,
                     GenericVertex::VFormat vFmt = GenericVertex::XYZ_FFF,
                     GenericVertex::CFormat cFmt = GenericVertex::CLR_UARGB,
                     GenericVertex::TFormat tFmt = GenericVertex::TEX_UVW);

    // compatibility tests
    void    getInfo();
    void    testArrayPoints();
    void    testArrayLines();
    void    testArrayLineStrip();
    void    testArrayLineLoop();
    void    testVertexFormats();
    void    testColourFormats();
    void    testCompatibility();

    // bandwidth strain tests
    void    measureVRAMAccess();
    void    measureZBufAccess();
    void    measureTextureUpload();
/*
    // 8 bit formats
    void    measureTexUploadCLUT();
    void    measureTexUploadA8();
    void    measureTexUploadL8();
    void    measureTexUploadI8();

    // 16 bit formats
    void    measureTexUploadA1R5G5B5();
    void    measureTexUploadR5G5B5();
    void    measureTexUploadA4R4G4B4();
    void    measureTexUploadL8A8();

    // 32 bit formats
    void    measureTexUploadA8R8G8B8();
    void    measureTexUploadR8G8B8A8();
*/

    // render strain tests

    void    calcTestMesh(sint16 dimX, sint16 dimY, sint16 texW, sint16 texH,
                         GenericVertex* v,
                         GenericVertex::VFormat vFmt,
                         GenericVertex::CFormat cFmt,
                         GenericVertex::TFormat tFmt);


    void    measurePointsLinear();
    void    measureLinesLinear();
    void    measureLineStripLinear();
    void    measureLineLoopLinear();
    void    measureTrisLinear();
    void    measureTriStripLinear();

    void    measureTrisV3();
    void    measureTriStripV3();

    void    testPerformance();


  protected:
    // AppBase
    sint32  initApplication();
    sint32  runApplication();

  public:
    TestWarp3D();
    ~TestWarp3D();
};

#define MAX_F (255.0f/256.0f)

#endif
