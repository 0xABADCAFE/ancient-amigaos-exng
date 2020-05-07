//****************************************************************************//
//**                                                                        **//
//** File:         proj/W3DTest/impquality.cpp                              **//
//** Description:  Warp3D test application                                  **//
//** Comment(s):   This software calls Warp3D directly and is hence not     **//
//**               portable.                                                **//
//** Created:      2004-01-31                                               **//
//** Updated:      2004-02-01                                               **//
//** Author(s):    Karl Churchill                                           **//
//** Note(s):                                                               **//
//** Copyright:    (C)1996-2004, eXtropia Studios                           **//
//**               Serkan YAZICI, Karl Churchill                            **//
//**                                                                        **//
//**               Warp3D (C) Hyperion Entertainment                        **//
//**                                                                        **//
//**               All Rights Reserved.                                     **//
//**                                                                        **//
//****************************************************************************//

#include "testw3d.hpp"

#define LINESTRIP_LEN 1024
#define LINELOOP_LEN  512

////////////////////////////////////////////////////////////////////////////////

void TestWarp3D::getInfo()
{
  Surface*          surf  = appWindow->getDrawSurface();
  PixelDescriptor*  pxl    = surf->getDescriptor();

  chip  = chipNames[getRasterizerContext(gfx)->CurrentChip];

  logFile->writeText("3D Chipset                 : %s\n\n", chip);

  logFile->writeText("Display information:\n\n"
                     "Dimensions [visible]       : %hd x %hd\n"
                     "Dimensions [hardware]      : %hd x %hd\n",
                     width,
                     height,
                     surf->getHWWidth(),
                     surf->getHWHeight());
  logFile->writeText("Bytes per Pixel            : %lu, endian %s\n",
                      pxl->getSize(),
                      pxl->isSwapped() ? "swapped" : "native");
  logFile->writeText("Bits per Gun               : A[%3lu] R[%3lu] G[%3lu] B[%3lu]\n",
                      pxl->getBitsAlpha(),
                      pxl->getBitsRed(),
                      pxl->getBitsGreen(),
                      pxl->getBitsBlue());
  logFile->writeText("Bitwise Offset             : A[%3lu] R[%3lu] G[%3lu] B[%3lu]\n",
                      pxl->getShiftAlpha(),
                      pxl->getShiftRed(),
                      pxl->getShiftGreen(),
                      pxl->getShiftBlue());
  logFile->writeText("Gun Maxima                 : A[%3lu] R[%3lu] G[%3lu] B[%3lu]\n\n",
                      pxl->getMaxAlpha(),
                      pxl->getMaxRed(),
                      pxl->getMaxGreen(),
                      pxl->getMaxBlue());

  SystemLib::dialogueBox(dBoxInfo, dBoxProceed,
    "Welcome to TestW3D\n\n"
    "This program will perform a series of tests of your Warp3D (tm)\n"
    "supported graphics card. Both the quality of implementation and\n"
    "performance of your driver/hardware combination will be tested.\n\n"
    "All results will be logged to the file '%s'\n\n"
    "TestW3D has successfully initialised and determined your\n"
    "3D chip to be : %s\n",
    logName, chip);
}

////////////////////////////////////////////////////////////////////////////////

void TestWarp3D::testCompatibility()
{
  if (!SystemLib::dialogueBox(dBoxInfo, dBoxRunSkip,
    "Compatibility Tests\n\n"
    "Before we can proceed with the performance tests, TestW3D needs\n"
    "some basic quality of implementation level information for your\n"
    "system that is unavailable via the built in querying functions.\n\n"
    "A series of small tests will be performed and a message box\n"
    "opened with a description of what you should see for each\n"
    "test. You will then be asked if you are able to see the described\n"
    "image.\n"
    "Skipping these tests will tell TestW3D to assume that all vertex\n"
    "formats are correctly supported and that only triange based primitives\n"
    "may be rendered using array methods."
  ))
  {
    logFile->writeText("No Quality of Implementation tests performed\n");
    check |= CH_COLOUR_ALL|CH_VERTEX_ALL;
    return;
  }
  logFile->writeText("Quality of Implementation tests:\n\n");
  testVertexFormats();
  testColourFormats();
  testArrayPoints();
  testArrayLines();
  testArrayLineStrip();
  testArrayLineLoop();
}

////////////////////////////////////////////////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////
//
//  Auxilliary functions
//
////////////////////////////////////////////////////////////////////////////////

static void setFFF(GenericVertex* v, sint16 w, sint16 h)
{
  v[0].crd.fff.x = 4;
  v[0].crd.fff.y = h-4;
  v[0].crd.fff.z = 0;
  v[1].crd.fff.x = w/2;
  v[1].crd.fff.y = 4;
  v[1].crd.fff.z = 0;
  v[2].crd.fff.x = w-4;
  v[2].crd.fff.y = h-4;
  v[2].crd.fff.z = 0;
}

static void setFFD(GenericVertex* v, sint16 w, sint16 h)
{
  v[0].crd.ffd.x = 4;
  v[0].crd.ffd.y = h-4;
  v[0].crd.ffd.z = 0;
  v[1].crd.ffd.x = w/2;
  v[1].crd.ffd.y = 4;
  v[1].crd.ffd.z = 0;
  v[2].crd.ffd.x = w-4;
  v[2].crd.ffd.y = h-4;
  v[2].crd.ffd.z = 0;
}

static void setDDD(GenericVertex* v, sint16 w, sint16 h)
{
  v[0].crd.ddd.x = 4;
  v[0].crd.ddd.y = h-4;
  v[0].crd.ddd.z = 0;
  v[1].crd.ddd.x = w/2;
  v[1].crd.ddd.y = 4;
  v[1].crd.ddd.z = 0;
  v[2].crd.ddd.x = w-4;
  v[2].crd.ddd.y = h-4;
  v[2].crd.ddd.z = 0;
}


static void setURGB(GenericVertex* v)
{
  v[0].clr.urgb.r = 0xFF;  v[0].clr.urgb.g = 0x00;  v[0].clr.urgb.b = 0x00;
  v[1].clr.urgb.r = 0x00;  v[1].clr.urgb.g = 0xFF;  v[1].clr.urgb.b = 0x00;
  v[2].clr.urgb.r = 0x00;  v[2].clr.urgb.g = 0x00;  v[2].clr.urgb.b = 0xFF;
}

static void setUBGR(GenericVertex* v)
{
  v[0].clr.ubgr.r = 0xFF;  v[0].clr.ubgr.g = 0x00;  v[0].clr.ubgr.b = 0x00;
  v[1].clr.ubgr.r = 0x00;  v[1].clr.ubgr.g = 0xFF;  v[1].clr.ubgr.b = 0x00;
  v[2].clr.ubgr.r = 0x00;  v[2].clr.ubgr.g = 0x00;  v[2].clr.ubgr.b = 0xFF;
}

static void setURGBA(GenericVertex* v)
{
  v[0].clr.urgba.r = 0xFF; v[0].clr.urgba.g = 0x00; v[0].clr.urgba.b = 0x00; v[0].clr.urgba.a = 0x00;
  v[1].clr.urgba.r = 0x00; v[1].clr.urgba.g = 0xFF; v[1].clr.urgba.b = 0x00; v[1].clr.urgba.a = 0x00;
  v[2].clr.urgba.r = 0x00; v[2].clr.urgba.g = 0x00; v[2].clr.urgba.b = 0xFF; v[2].clr.urgba.a = 0x00;
}

static void setUARGB(GenericVertex* v)
{
  v[0].clr.uargb.r = 0xFF; v[0].clr.uargb.g = 0x00; v[0].clr.uargb.b = 0x00; v[0].clr.uargb.a = 0x00;
  v[1].clr.uargb.r = 0x00; v[1].clr.uargb.g = 0xFF; v[1].clr.uargb.b = 0x00; v[1].clr.uargb.a = 0x00;
  v[2].clr.uargb.r = 0x00; v[2].clr.uargb.g = 0x00; v[2].clr.uargb.b = 0xFF; v[2].clr.uargb.a = 0x00;
}

static void setUBGRA(GenericVertex* v)
{
  v[0].clr.ubgra.r = 0xFF; v[0].clr.ubgra.g = 0x00; v[0].clr.ubgra.b = 0x00; v[0].clr.ubgra.a = 0x00;
  v[1].clr.ubgra.r = 0x00; v[1].clr.ubgra.g = 0xFF; v[1].clr.ubgra.b = 0x00; v[1].clr.ubgra.a = 0x00;
  v[2].clr.ubgra.r = 0x00; v[2].clr.ubgra.g = 0x00; v[2].clr.ubgra.b = 0xFF; v[2].clr.ubgra.a = 0x00;
}

static void setFRGB(GenericVertex* v)
{
  v[0].clr.frgb.r = MAX_F;  v[0].clr.frgb.g = 0;    v[0].clr.frgb.b = 0;
  v[1].clr.frgb.r = 0;    v[1].clr.frgb.g = MAX_F;  v[1].clr.frgb.b = 0;
  v[2].clr.frgb.r = 0;    v[2].clr.frgb.g = 0;    v[2].clr.frgb.b = MAX_F;
}

static void setFBGR(GenericVertex* v)
{
  v[0].clr.fbgr.r = MAX_F;  v[0].clr.fbgr.g = 0;    v[0].clr.fbgr.b = 0;
  v[1].clr.fbgr.r = 0;    v[1].clr.fbgr.g = MAX_F;  v[1].clr.fbgr.b = 0;
  v[2].clr.fbgr.r = 0;    v[2].clr.fbgr.g = 0;    v[2].clr.fbgr.b = MAX_F;
}

static void setFRGBA(GenericVertex* v)
{
  v[0].clr.frgba.r = MAX_F;  v[0].clr.frgba.g = 0;      v[0].clr.frgba.b = 0;      v[0].clr.frgba.a = 0;
  v[1].clr.frgba.r = 0;      v[1].clr.frgba.g = MAX_F;  v[1].clr.frgba.b = 0;      v[1].clr.frgba.a = 0;
  v[2].clr.frgba.r = 0;      v[2].clr.frgba.g = 0;      v[2].clr.frgba.b = MAX_F;  v[2].clr.frgba.a = 0;
}

static void setFARGB(GenericVertex* v)
{
  v[0].clr.fargb.r = MAX_F;  v[0].clr.fargb.g = 0;      v[0].clr.fargb.b = 0;      v[0].clr.fargb.a = 0;
  v[1].clr.fargb.r = 0;      v[1].clr.fargb.g = MAX_F;  v[1].clr.fargb.b = 0;      v[1].clr.fargb.a = 0;
  v[2].clr.fargb.r = 0;      v[2].clr.fargb.g = 0;      v[2].clr.fargb.b = MAX_F;  v[2].clr.fargb.a = 0;
}

static void setFBGRA(GenericVertex* v)
{
  v[0].clr.fbgra.r = MAX_F;  v[0].clr.fbgra.g = 0;      v[0].clr.fbgra.b = 0;      v[0].clr.fbgra.a = 0;
  v[1].clr.fbgra.r = 0;      v[1].clr.fbgra.g = MAX_F;  v[1].clr.fbgra.b = 0;      v[1].clr.fbgra.a = 0;
  v[2].clr.fbgra.r = 0;      v[2].clr.fbgra.g = 0;      v[2].clr.fbgra.b = MAX_F;  v[2].clr.fbgra.a = 0;
}

////////////////////////////////////////////////////////////////////////////////
//
//  Types
//
////////////////////////////////////////////////////////////////////////////////

typedef void (*TestVertex)(GenericVertex* v, sint16 w, sint16 h);
typedef void (*TestColour)(GenericVertex* v);

struct VTest {
  GenericVertex::VFormat  format;
  TestVertex              func;
  const char*              logName;
  const char*              name;
};


struct CTest {
  GenericVertex::CFormat  format;
  TestColour              func;
  const char*              logMode;
  const char*              logName;
  const char*              name;
};

////////////////////////////////////////////////////////////////////////////////
//
//  Tables
//
////////////////////////////////////////////////////////////////////////////////

static const char* w3DCModeNames[] = {
  "W3D_CMODE_RGB",
  "W3D_CMODE_BGR",
  "W3D_CMODE_RGBA",
  "W3D_CMODE_ARGB",
  "W3D_CMODE_BGRA"
};

static VTest vTestTab[] = {
  {  GenericVertex::XYZ_FFF,  setFFF, "W3D_VERTEX_F_F_F", "float XYZ" },
  {  GenericVertex::XYZ_FFD,  setFFD, "W3D_VERTEX_F_F_D", "float XY, double Z" },
  {  GenericVertex::XYZ_DDD,  setDDD, "W3D_VERTEX_D_D_D", "double XYZ" },
};

static CTest cTestTab[] = {
  {  GenericVertex::CLR_URGB,  setURGB, "\nW3D_COLOR_UBYTE\n",
    w3DCModeNames[0], "8-bit RGB" },

  {  GenericVertex::CLR_UBGR,  setUBGR,  0,
    w3DCModeNames[1], "8-bit BGR" },

  {  GenericVertex::CLR_URGBA,  setURGBA,  0,
    w3DCModeNames[2], "8-bit RGBA" },

  {  GenericVertex::CLR_UARGB,  setUARGB,  0,
    w3DCModeNames[3], "8-bit ARGB" },

  {  GenericVertex::CLR_UBGRA,  setUBGRA,  0,
    w3DCModeNames[4], "8-bit BGRA" },

  {  GenericVertex::CLR_FRGB,  setFRGB,  "\nW3D_COLOR_FLOAT\n",
    w3DCModeNames[0], "32-bit float RGB" },

  {  GenericVertex::CLR_FBGR,  setFBGR,  0,
    w3DCModeNames[1], "32-bit float BGR" },

  {  GenericVertex::CLR_FRGBA,  setFRGBA,  0,
    w3DCModeNames[2], "32-bit float RGBA" },

  {  GenericVertex::CLR_FARGB,  setFARGB,  0,
    w3DCModeNames[3], "32-bit float ARGB" },

  {  GenericVertex::CLR_FBGRA,  setFBGRA,  0,
    w3DCModeNames[4], "32-bit float BGRA" }
};

////////////////////////////////////////////////////////////////////////////////
//
//  Application Methods
//
////////////////////////////////////////////////////////////////////////////////

void TestWarp3D::testVertexFormats()
{
  appWindow->setTitle("Warp3D Test : Array Vertex Format Test");
  clear();
  static const char query[] = "This is the vertex format test result %d/3.\n\n"
                              "The current mode is %s.\n"
                              "Do you see a light grey triangle?";

  if (!SystemLib::dialogueBox(dBoxInfo, dBoxRunSkip,
    "Warp3D v4 Array Vertex Format Test\n\n"
    "TestW3D will test the 3 defined Warp3D v4 Vertex Array vertex formats.\n"
    "In each case, you should see a light grey triangle.\n\n"
    "Skipping these tests will tell TestW3D to assume all vertex formats are\n"
    "correctly implemented by your driver."
  ))
  {
    logFile->writeText("Skipped array vertex format tests\n");
    check |= CH_VERTEX_ALL;
    return;
  }

  gfx->disable(G3D::GOURAUD);

  GenericVertex* gVert = (GenericVertex*)data;

  for (sint32 v=0; v<GenericVertex::_XYZ_NUM; v++)
  {
    vTestTab[v].func(gVert, width, height);
    setArray(gVert, vTestTab[v].format);
    gfx->lock();
    W3D_DrawArray(getRasterizerContext(gfx), W3D_PRIMITIVE_TRIANGLES, 0, 3);
    gfx->unlock();
    appWindow->refresh();

    logFile->writeText("%-26s : ", vTestTab[v].logName);

    if (SystemLib::dialogueBox(dBoxQuery, dBoxBool, query, v+1, vTestTab[v].name))
    {
      check |= (1<<(v+CH_VERTEX_SHIFT));
      logFile->writeText(qTestPass);
    }
    else
    {
      check &= ~(1<<(v+CH_VERTEX_SHIFT));
      logFile->writeText(qTestFail);
    }
    clear();
    //printf("check : 0x%08X\n", check);
    Thread::sleep(25);
  }
}

////////////////////////////////////////////////////////////////////////////////

void TestWarp3D::testColourFormats()
{
  appWindow->setTitle("Warp3D Test : Array Colour Format Test");
  clear();

  if (!SystemLib::dialogueBox(dBoxInfo, dBoxRunSkip,
    "Warp3D v4 Array Colour Format Test\n\n"
    "TestW3D will test the 10 defined Warp3D v4 Vertex Array colour formats.\n"
    "In each case, you should see a shaded triangle with the leftmost corner\n"
    "red, topmost corner green and rightmost corner blue.\n"
    "When asked, if the triangle on screen does not conform to this exact\n"
    "layout, you must answer 'No'.\n\n"
    "Skipping these tests will tell TestW3D to assume all colour formats are\n"
    "correctly implemented by your driver."
  ))
  {
    logFile->writeText("Skipped colour format tests\n");
    check |= CH_COLOUR_ALL;
    return;
  }
  static const char query[] = "This is the colour format test result %d/10.\n\n"
                              "The current mode is %s.\n"
                              "Do you see the shaded triangle?";

  GenericVertex* gVert = (GenericVertex*)data;
  setFFF(gVert, width, height);

  gfx->enable(G3D::GOURAUD);

  for (sint32 c=0; c<GenericVertex::_CLR_NUM; c++)
  {
    if (cTestTab[c].logMode)
      logFile->writeText(cTestTab[c].logMode);
    setArray(gVert, GenericVertex::XYZ_FFF, cTestTab[c].format);
    cTestTab[c].func(gVert);

    gfx->lock();
    W3D_DrawArray(getRasterizerContext(gfx), W3D_PRIMITIVE_TRIANGLES, 0, 3);
    gfx->unlock();
    appWindow->refresh();

    //logFile->writeText("W3D_CMODE_RGB              : ");
    logFile->writeText("%-26s : ", cTestTab[c].logName);
    if (SystemLib::dialogueBox(dBoxQuery, dBoxBool, query, c+1, cTestTab[c].name))
    {
      check |= (1<<(c+CH_COLOUR_SHIFT));
      logFile->writeText(qTestPass);
    }
    else
    {
      check &= ~(1<<(c+CH_COLOUR_SHIFT));
      logFile->writeText(qTestFail);
    }
    clear();
    //printf("check : 0x%08X\n", check);
    Thread::sleep(25);
  }
}

////////////////////////////////////////////////////////////////////////////////

void TestWarp3D::testArrayPoints()
{
  appWindow->setTitle("Warp3D Test : Array Point Render Test");
  clear();

  logFile->writeText("W3D_PRIMITIVE_POINTS       : ");
  if (!SystemLib::dialogueBox(dBoxInfo, dBoxRunSkip,
    "Warp3D v4 Array Point Render Test\n\n"
    "TestW3D will test point rendering using Warp3D v4 Vertex Array\n"
    "drawing. Not every driver supports point rendering via arrays.\n"
    "If your driver supports point rendering, you should see a grid\n"
    "of light grey pixels against a black background."
  ))
  {
    check &= ~CH_ARRAY_POINTS;
    logFile->writeText(qTestSkip);
    return;
  }

  DrawVertex*v = (DrawVertex*)data;
  for (sint32 y=0; y<height; y+=16)
  {
    for (sint32 x=0; x<width; x+=16)
    {
      v->x = x; v->y = y;
      v++;
    }
  }

  sint32 vCnt = v-((DrawVertex*)(data));

  gfx->setVertices((DrawVertex*)data);
  gfx->disable(G3D::GOURAUD);
  gfx->lock();
  // SYSTEM DEPENDENCY!
  W3D_DrawArray(getRasterizerContext(gfx), W3D_PRIMITIVE_POINTS, 0, vCnt);
  gfx->unlock();
  appWindow->refresh();
  if (SystemLib::dialogueBox(dBoxQuery, dBoxBool,
    "This is the point render result.\n\n"
    "Do you see a grid of light grey\n"
    "pixels against a black background?"
  ))
  {
    check |= CH_ARRAY_POINTS;
    logFile->writeText(qTestPass);
  }
  else
  {
    check &= ~CH_ARRAY_POINTS;
    logFile->writeText(qTestFail);
  }
}

////////////////////////////////////////////////////////////////////////////////

void TestWarp3D::testArrayLines()
{
  appWindow->setTitle("Warp3D Test : Array Line Render Test");
  clear();

  logFile->writeText("W3D_PRIMITIVE_LINES        : ");
  if (!SystemLib::dialogueBox(dBoxInfo, dBoxRunSkip,
    "Warp3D v4 Array Line Render Test\n\n"
    "TestW3D will test line rendering using Warp3D v4 Vertex Array\n"
    "drawing. Not every driver supports line rendering via arrays.\n"
    "If your driver supports line rendering, you should see a grid\n"
    "of horizontal and vertical light grey lines against a black\n"
    "background."
  ))
  {
    check &= ~CH_ARRAY_LINES;
    logFile->writeText(qTestSkip);
    return;
  }

  DrawVertex*v  = (DrawVertex*)data;
  {
    for (sint32 y=0; y<height; y+=16)
    {
      v->x = 0;          v->y = y; v++;
      v->x = (width-1);  v->y = y; v++;
    }
  }
  {
    for (sint32 x=0; x<width; x+=16)
    {
      v->x = x;  v->y = 0;            v++;
      v->x = x;  v->y = (height-1);  v++;
    }
  }

  sint32 vCnt = v - ((DrawVertex*)data);

  gfx->setVertices((DrawVertex*)data);
  gfx->disable(G3D::GOURAUD);
  gfx->lock();
  // SYSTEM DEPENDENCY!
  W3D_DrawArray(getRasterizerContext(gfx), W3D_PRIMITIVE_LINES, 0, vCnt);
  gfx->unlock();
  appWindow->refresh();
  if (SystemLib::dialogueBox(dBoxQuery, dBoxBool,
    "This is the line render result.\n\n"
    "Do you see a mesh of light grey\n"
    "lines against a black background?"
  ))
  {
    check |= CH_ARRAY_LINES;
    logFile->writeText(qTestPass);
  }
  else
  {
    check &= ~CH_ARRAY_LINES;
    logFile->writeText(qTestFail);
  }
}

////////////////////////////////////////////////////////////////////////////////

void TestWarp3D::testArrayLineStrip()
{
  appWindow->setTitle("Warp3D Test : Array Line Strip Render Test");
  clear();

  logFile->writeText("W3D_PRIMITIVE_LINESTRIP    : ");
  if (!SystemLib::dialogueBox(dBoxInfo, dBoxRunSkip,
    "Warp3D v4 Array Line Strip Render Test\n\n"
    "TestW3D will test line strip rendering using Warp3D v4 Vertex Array\n"
    "drawing. Not every driver supports line strip rendering via arrays.\n"
    "If your driver supports line strip rendering, you should see a light\n"
    "grey spiral line against a black background."
  ))
  {
    check &= ~CH_ARRAY_LSTRIP;
    logFile->writeText(qTestSkip);
    return;
  }

  DrawVertex* v = (DrawVertex*)data;
  uint32 a = 0;
  float32 rStep = (float32)(width<height ? width/2 : height/2)/(float32)LINESTRIP_LEN;
  float32 r = 1.0;
  float32 cx = (float32)width/2.0f;
  float32 cy = (float32)height/2.0f;

  while (a < LINESTRIP_LEN)
  {
    float32 ang = ((PI32/32.0f)*(float32)((a++)&63));
    v->x = cx + r*QMath::sinq(ang);
    v->y = cy + r*QMath::cosq(ang);
    v++;
    r += rStep;
  }

  gfx->setVertices((DrawVertex*)data);
  gfx->disable(G3D::GOURAUD);
  gfx->lock();
  // SYSTEM DEPENDENCY!
  W3D_DrawArray(getRasterizerContext(gfx), W3D_PRIMITIVE_LINESTRIP, 0, LINESTRIP_LEN);
  gfx->unlock();
  appWindow->refresh();

  if (SystemLib::dialogueBox(dBoxQuery, dBoxBool,
    "This is the line strip render result.\n\n"
    "Do you see a light grey spiral\n"
    "line against a black background?"
  ))
  {
    check |= CH_ARRAY_LSTRIP;
    logFile->writeText(qTestPass);
  }
  else
  {
    check &= ~CH_ARRAY_LSTRIP;
    logFile->writeText(qTestFail);
  }
}

////////////////////////////////////////////////////////////////////////////////

void TestWarp3D::testArrayLineLoop()
{
  appWindow->setTitle("Warp3D Test : Array Line Loop Render Test");
  clear();

  logFile->writeText("W3D_PRIMITIVE_LINELOOP     : ");
  if (!SystemLib::dialogueBox(dBoxInfo, dBoxRunSkip,
    "Warp3D v4 Array Line Loop Render Test\n\n"
    "TestW3D will test line loop rendering using Warp3D v4 Vertex Array\n"
    "drawing. Not every driver supports line loop rendering via arrays.\n"
    "If your driver supports line loop rendering, you should see a series\n"
    "of grey circles against a black background."
  ))
  {
    check &= ~CH_ARRAY_LLOOP;
    logFile->writeText(qTestSkip);
    return;
  }
  gfx->setVertices((DrawVertex*)data);
  gfx->disable(G3D::GOURAUD);

  float32 r    = (float32)((width<height ? width/2 : height/2)-4);
  float32 cx  = (float32)width/2.0f;
  float32 cy  = (float32)height/2.0f;

  while (r>16.0f)
  {
    DrawVertex*  v      = (DrawVertex*)data;
    sint32      len    = Clamp::integer((uint32)(r*r*PI32/400), 16, LINELOOP_LEN);

    float32     scale  = (2*PI32/(float32)len);
    for (sint32 a=0; a<len; a++)
    {
      float32 ang = scale*(float32)a;
      v->x = cx + r*QMath::sinq(ang);
      v->y = cy + r*QMath::cosq(ang);
      v++;
    }
    gfx->lock();
    // SYSTEM DEPENDENCY!
    W3D_DrawArray(getRasterizerContext(gfx), W3D_PRIMITIVE_LINELOOP, 0, len);
    gfx->unlock();
    r -= 8.0f;
  }
  appWindow->refresh();

  if (SystemLib::dialogueBox(dBoxQuery, dBoxBool,
    "This is the line loop render result.\n\n"
    "Do you see a series of light grey\n"
    "circles against a black background?"
  ))
  {
    check |= CH_ARRAY_LLOOP;
    logFile->writeText(qTestPass);
  }
  else
  {
    check &= ~CH_ARRAY_LLOOP;
    logFile->writeText(qTestFail);
  }
}

////////////////////////////////////////////////////////////////////////////////

void TestWarp3D::setArray(GenericVertex* v,
                          GenericVertex::VFormat vFmt,
                          GenericVertex::CFormat cFmt,
                          GenericVertex::TFormat tFmt)
{
  uint8* bytePtr = (uint8*)v;
  uint32 w3dFmt = 0;
  uint32 w3dMode = 0;
  switch (vFmt) {
    case GenericVertex::XYZ_FFF: w3dFmt = W3D_VERTEX_F_F_F;  break;
    case GenericVertex::XYZ_FFD: w3dFmt = W3D_VERTEX_F_F_D;  break;
    case GenericVertex::XYZ_DDD: w3dFmt = W3D_VERTEX_D_D_D;  break;
    default: break;
  }

  //printf("Vertex format : %lu\n", w3dFmt);

  W3D_VertexPointer(getRasterizerContext(gfx),
                    bytePtr+GV_OFS_XYZ, GV_STRIDE, w3dFmt, 0);
  switch (cFmt)
  {
    case GenericVertex::CLR_URGB:
      w3dFmt  = W3D_CMODE_RGB;
      w3dMode  = W3D_COLOR_UBYTE;
      break;

    case GenericVertex::CLR_UBGR:
      w3dFmt  = W3D_CMODE_BGR;
      w3dMode  = W3D_COLOR_UBYTE;
      break;

    case GenericVertex::CLR_URGBA:
      w3dFmt  = W3D_CMODE_RGBA;
      w3dMode  = W3D_COLOR_UBYTE;
      break;

    case GenericVertex::CLR_UARGB:
      w3dFmt  = W3D_CMODE_ARGB;
      w3dMode  = W3D_COLOR_UBYTE;
      break;

    case GenericVertex::CLR_UBGRA:
      w3dFmt  = W3D_CMODE_BGRA;
      w3dMode  = W3D_COLOR_UBYTE;
      break;

    case GenericVertex::CLR_FRGB:
      w3dFmt  = W3D_CMODE_RGB;
      w3dMode  = W3D_COLOR_FLOAT;
      break;

    case GenericVertex::CLR_FBGR:
      w3dFmt  = W3D_CMODE_BGR;
      w3dMode  = W3D_COLOR_FLOAT;
      break;

    case GenericVertex::CLR_FRGBA:
      w3dFmt  = W3D_CMODE_RGBA;
      w3dMode  = W3D_COLOR_FLOAT;
      break;

    case GenericVertex::CLR_FARGB:
      w3dFmt  = W3D_CMODE_ARGB;
      w3dMode  = W3D_COLOR_FLOAT;
      break;

    case GenericVertex::CLR_FBGRA:
      w3dFmt  = W3D_CMODE_BGRA;
      w3dMode  = W3D_COLOR_FLOAT;
      break;

    default:
      break;
  }

  //printf("Colour format : %lu, Mode : 0x%08X\n", w3dFmt, (unsigned)w3dMode);

  W3D_ColorPointer(getRasterizerContext(gfx),
                   bytePtr+GV_OFS_CLR,
                   GV_STRIDE, w3dMode, w3dFmt, 0);

  switch (tFmt)
  {
    case GenericVertex::TEX_UVW: w3dMode = 0; break;
    case GenericVertex::TEX_STW: w3dMode = W3D_TEXCOORD_NORMALIZED; break;
    default: break;
  }
  W3D_TexCoordPointer(getRasterizerContext(gfx),
                      bytePtr+GV_OFS_TEX,
                      GV_STRIDE, 0,
                      sizeof(float32), 2*sizeof(float32),
                      w3dMode);
}
