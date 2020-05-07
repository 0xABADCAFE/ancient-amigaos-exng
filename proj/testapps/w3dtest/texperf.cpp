//****************************************************************************//
//**                                                                        **//
//** File:         proj/W3DTest/texperf.cpp                                 **//
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

#include "testw3d.hpp"

////////////////////////////////////////////////////////////////////////////////
//
//  Texture upload bandwidth tests
//
////////////////////////////////////////////////////////////////////////////////

#define TREPS    256
#define FLAME_H 128
#define FLAME_W 64

static uint32 flamePal [256] = {
  0x00000000, 0x00030001, 0x00050002, 0x00080004, 0x000B0005, 0x000D0006, 0x00100007, 0x00120008,
  0x00150009, 0x0018000B, 0x001A000C, 0x001D000D, 0x0020000E, 0x0022000F, 0x00250011, 0x00280012,
  0x002A0013, 0x002D0014, 0x00300015, 0x00320016, 0x00350018, 0x00370019, 0x003A001A, 0x003D001B,
  0x003F001C, 0x0042001D, 0x0045001F, 0x00470020, 0x004A0021, 0x004D0022, 0x004F0023, 0x00520025,
  0x00550026, 0x00570027, 0x005A0028, 0x005C0029, 0x005F002A, 0x0062002C, 0x0064002D, 0x0067002E,
  0x006A002C, 0x006D002B, 0x00700029, 0x00730027, 0x00760025, 0x00790024, 0x007C0022, 0x007F0020,
  0x0082001E, 0x0085001C, 0x0088001B, 0x008B0019, 0x008D0017, 0x00900015, 0x00930014, 0x00960012,
  0x00990010, 0x009C000E, 0x009F000C, 0x00A2000B, 0x00A50009, 0x00A80007, 0x00AB0005, 0x00AE0004,
  0x00B10002, 0x00B40000, 0x00B80000, 0x00BA0000, 0x00BD0000, 0x00BF0000, 0x00C30000, 0x00C70000,
  0x00C90000, 0x00CD0000, 0x00CF0000, 0x00D20000, 0x00D40000, 0x00D80000, 0x00DB0000, 0x00DF0000,
  0x00E10000, 0x00E50000, 0x00E70000, 0x00EA0000, 0x00EC0000, 0x00F10000, 0x00F30000, 0x00F70000,
  0x00FA0000, 0x00FD0000, 0x00FF0000, 0x00FF0000, 0x00FF0000, 0x00FF0000, 0x00FF0000, 0x00FF0000,
  0x00FF0300, 0x00FF0600, 0x00FF0C00, 0x00FF0F00, 0x00FF1500, 0x00FF1800, 0x00FF1C00, 0x00FF2000,
  0x00FF2500, 0x00FF2800, 0x00FF2D00, 0x00FF3100, 0x00FF3600, 0x00FF3A00, 0x00FF3E00, 0x00FF4200,
  0x00FF4600, 0x00FF4B00, 0x00FF5000, 0x00FF5300, 0x00FF5800, 0x00FF5B00, 0x00FF5F00, 0x00FF6300,
  0x00FF6900, 0x00FF6D00, 0x00FF7100, 0x00FF7400, 0x00FF7900, 0x00FF7C00, 0x00FF8100, 0x00FF8400,
  0x00FF8800, 0x00FF8C00, 0x00FF9000, 0x00FF9400, 0x00FF9900, 0x00FF9D00, 0x00FFA200, 0x00FFA500,
  0x00FFA900, 0x00FFAE00, 0x00FFB200, 0x00FFB500, 0x00FFBB00, 0x00FFBE00, 0x00FFC400, 0x00FFC700,
  0x00FFCB00, 0x00FFCD00, 0x00FFCF00, 0x00FFD000, 0x00FFD300, 0x00FFD500, 0x00FFD600, 0x00FFDA00,
  0x00FFDB00, 0x00FFDD00, 0x00FFDE00, 0x00FFE000, 0x00FFE300, 0x00FFE400, 0x00FFE600, 0x00FFE700,
  0x00FFE900, 0x00FFEA00, 0x00FFEE00, 0x00FFF100, 0x00FFF200, 0x00FFF400, 0x00FFF500, 0x00FFF700,
  0x00FFFA00, 0x00FFFB00, 0x00FFFD00, 0x00FFFE00, 0x00FFFF00, 0x00FFFF00, 0x00FFFF00, 0x00FFFF00,
  0x00FFFF00, 0x00FFFF00, 0x00FFFF00, 0x00FFFF00, 0x00FFFF00, 0x00FFFF00, 0x00FFFF00, 0x00FFFF00,
  0x00FFFF00, 0x00FFFF00, 0x00FFFF00, 0x00FFFF00, 0x00FFFF00, 0x00FFFF00, 0x00FFFF00, 0x00FFFF00,
  0x00FFFF00, 0x00FFFF00, 0x00FFFF02, 0x00FFFF07, 0x00FFFF0D, 0x00FFFF12, 0x00FFFF19, 0x00FFFF1F,
  0x00FFFF24, 0x00FFFF2A, 0x00FFFF2F, 0x00FFFF35, 0x00FFFF3A, 0x00FFFF42, 0x00FFFF48, 0x00FFFF4C,
  0x00FFFF52, 0x00FFFF57, 0x00FFFF5F, 0x00FFFF65, 0x00FFFF69, 0x00FFFF6F, 0x00FFFF74, 0x00FFFF7A,
  0x00FFFF82, 0x00FFFF87, 0x00FFFF8C, 0x00FFFF91, 0x00FFFF97, 0x00FFFF9D, 0x00FFFFA2, 0x00FFFFA7,
  0x00FFFFAD, 0x00FFFFB2, 0x00FFFFB9, 0x00FFFFBF, 0x00FFFFC4, 0x00FFFFCA, 0x00FFFFCF, 0x00FFFFD7,
  0x00FFFFDA, 0x00FFFFE1, 0x00FFFFE7, 0x00FFFFEC, 0x00FFFFF3, 0x00FFFFF7, 0x00FFFFFC, 0x00FFFFFF,
  0x00FFFFFF, 0x00FFFFFF, 0x00FFFFFF, 0x00FFFFFF, 0x00FFFFFF, 0x00FFFFFF, 0x00FFFFFF, 0x00FFFFFF,
  0x00FFFFFF, 0x00FFFFFF, 0x00FFFFFF, 0x00FFFFFF, 0x00FFFFFF, 0x00FFFFFF, 0x00FFFFFF, 0x00FFFFFF
};
/*
static void calcFlame8(uint8* calcBuf, uint8* dest)
{
  ruint8*  s = calcBuf  + (FLAME_H-1)*(FLAME_W);
  ruint8*  d = dest    + (FLAME_H-1)*(FLAME_W);
  {
    rsint32  i = FLAME_W;
    while(--i)
    {
      uint32 v = (rand()>(RAND_MAX/5)) ? 255 : 0;
      *d++ = *s++ = v;
    }

    i = 16 + (32*rand())/RAND_MAX;
    while (--i)
    {
      uint8* p = calcBuf + (FLAME_W*FLAME_H*rand())/RAND_MAX;
      uint32 v = *p + (127*rand())/RAND_MAX;
      *p = (v>255) ? 255 : v;
    }
  }

  s = calcBuf  + (FLAME_H-2)*(FLAME_W);
  d = dest    + (FLAME_H-2)*(FLAME_W);

  {
    rsint32 y = FLAME_H;
    while (--y)
    {
      ruint8* t = s + FLAME_W-1;
      rsint32 x = FLAME_W+1;
      while (--x)
      {
        ruint32 v = *s;  v += *t++;  v += *t++;  v += *t--; v>>=2;
        *d++ = *s++ = (v>0) ? --v : 0;
      }
      d -= (FLAME_W<<1);
      s -= (FLAME_W<<1);
    }
  }
}

static void calcFlame16(uint8* calcBuf, uint16* dest, uint16* lut)
{
  ruint8*    s = calcBuf  + (FLAME_H-1)*(FLAME_W);
  ruint16*  d = dest     + (FLAME_H-1)*(FLAME_W);
  ruint16*  p = lut;
  {
    rsint32 i = FLAME_W;
    while(--i)
    {
      uint32 v = (rand()>(RAND_MAX/5)) ? 255 : 0;
      *s++ = v;
      *d++ = p[v];
    }

    i = 16 + (32*rand())/RAND_MAX;
    while (--i)
    {
      uint8* p = calcBuf + (FLAME_W*FLAME_H*rand())/RAND_MAX;
      uint32 v = *p + (127*rand())/RAND_MAX;
      *p = (v>255) ? 255 : v;
    }
  }

  s = calcBuf  + (FLAME_H-2)*(FLAME_W);
  d = dest    + (FLAME_H-2)*(FLAME_W);

  {
    rsint32 y = FLAME_H;
    while (--y)
    {
      ruint8* t = s + FLAME_W-1;
      rsint32 x = FLAME_W+1;
      while (--x)
      {
        ruint16 v = *s;  v += *t++; v += *t++; v += *t--; v>>=2;
        *s++ = (v>0) ? --v : 0;
        *d++ = p[v];
      }
      d -= (FLAME_W<<1);
      s -= (FLAME_W<<1);
    }
  }
}
*/
static void calcFlame32(uint8* calcBuf, uint32* dest, uint32* lut)
{
  ruint8*    s = calcBuf  + (FLAME_H-1)*(FLAME_W);
  ruint32*  d = dest    + (FLAME_H-1)*(FLAME_W);
  ruint32*  p = lut;
  {
    rsint32    i = FLAME_W;
    while(--i)
    {
      uint32 v = (rand()>(RAND_MAX/5)) ? 255 : 0;
      *s++ = v;
      *d++ = p[v];
    }

    i = 16 + (32*rand())/RAND_MAX;
    while (--i)
    {
      uint8* p = calcBuf + (FLAME_W*FLAME_H*rand())/RAND_MAX;
      uint32 v = *p + (127*rand())/RAND_MAX;
      *p = (v>255) ? 255 : v;
    }
  }

  s = calcBuf  + (FLAME_H-2)*(FLAME_W);
  d = dest    + (FLAME_H-2)*(FLAME_W);

  {
    rsint32 y = FLAME_H;
    while (--y)
    {
      ruint8* t = s + FLAME_W-1;
      rsint32 x = FLAME_W+1;
      while (--x)
      {
        ruint32 v = *s; v += *t++; v += *t++; v += *t--; v>>=2;
        *s++ = (v>0) ? --v : 0;
        *d++ = p[v];
      }
      d -= (FLAME_W<<1);
      s -= (FLAME_W<<1);
    }
  }
}

void TestWarp3D::measureTextureUpload()
{
  appWindow->setTitle("Warp3D Test : Texture Upload Test");
  clear();

  logFile->writeText("Texture Upload Bandwidth   : ");
  if (!SystemLib::dialogueBox(dBoxInfo, dBoxRunSkip,
    "Texture Upload Test\n\n"
    "TestW3D will estimate the speed at which texture data\n"
    "can be uploaded to your card.\n"
    "A 32-bit ARGB texture will be generated realtime, thus\n"
    "forcing Warp3D to upload the texture each frame.\n"
    "Due to optimised driver 'load on demand' texture management\n"
    "the entire time taken to update, lock, draw and unlock is\n"
    "measured. To isolate the update time, a small calibration\n"
    "loop is performed first that includes only the locking and\n"
    "drawing. You will not see anything during this time."
  ))
  {
    logFile->writeText(qTestSkip);
    return;
  }

  if (!tex || tex->create(FLAME_W, FLAME_H, G3D::TXL_ARGB32)!=OK)
    return;

  tex->associate(gfx);

  DrawVertex*  v  = (DrawVertex*)data;
  {
    v[0].x = 0;        v[0].y = 0;          v[0].z = 0;
    v[0].w = 0;        v[0].u = 0;          v[0].v = 0;
    v[1].x = 0;        v[1].y = height;    v[1].z = 0;
    v[1].w = 0;        v[1].u = 0;          v[1].v = FLAME_H;
    v[2].x = width;    v[2].y = 0;          v[2].z = 0;
    v[2].w = 0;        v[2].u = FLAME_W*2;  v[2].v = 0;
    v[3].x = width;    v[3].y = height;    v[3].z = 0;
    v[3].w = 0;        v[3].u = FLAME_W*2;  v[3].v = FLAME_H;
  }
  gfx->setVertices(v);
  gfx->setTexture(tex);
  gfx->enable(G3D::TEXTURE);
  gfx->disable(G3D::GOURAUD);
  gfx->disable(G3D::BLENDING);

  uint32      totBytes  = FLAME_W*FLAME_H*4;
  uint8*      flameBuf  = (uint8*)(&v[4]);
  uint32*      texData    = (uint32*)(tex->getData());
  Mem::zero(flameBuf, FLAME_W*FLAME_H);

  appWindow->setTitle("Warp3D Test : Texture Upload Test - Calibrating");

  // Calibrate draw timing
  // First ensure texture is uploaded
  tex->update();
  gfx->lock();
  gfx->drawTriStrip(0, 4);
  gfx->unlock();

  uint32  totCalibTime = 0;
  sint32 i;
  for (i = 0; i<TREPS; i++)
  {
    timer.set();
    gfx->lock();
    gfx->drawTriStrip(0, 4);
    gfx->unlock();
    totCalibTime += timer.elapsed();
  }

  appWindow->setTitle("Warp3D Test : Texture Upload Test");

  uint32  totTime = 0;
  for (i = 0; i<TREPS; i++)
  {
    calcFlame32(flameBuf, texData, flamePal);
    timer.set();
    tex->update();
    gfx->lock();
    gfx->drawTriStrip(0, 4);
    gfx->unlock();
    totTime += timer.elapsed();
    appWindow->refresh();
    //appWindow->waitSync();
  }

  gfx->setTexture(0);
  tex->disassociate();
  tex->destroy();

  texUploadSpeed = ((float64)totBytes*1000*TREPS)/((float64)(totTime-totCalibTime)*1024);
  logFile->writeText("%6.2f K/s\n", texUploadSpeed);
  SystemLib::dialogueBox(dBoxInfo, dBoxProceed,
    "Texture Upload Test\n\n"
    "Calibration time %lu ms\n"
    "Running time %lu ms\n"
    "Adjusted time %lu ms\n"
    "Repetitions %ld, Data size %lu\n"
    "ARGB 32-bit upload : %6.2f K/s",
    totCalibTime,  totTime, totTime-totCalibTime, TREPS, totBytes, texUploadSpeed
  );

}
