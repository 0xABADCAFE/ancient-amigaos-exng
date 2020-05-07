//****************************************************************************//
//**                                                                        **//
//** File:         proj/Landscape/app.cpp                                   **//
//** Description:                                                           **//
//** Comment(s):                                                            **//
//** Created:      2005-01-10                                               **//
//** Updated:      2003-01-10                                               **//
//** Author(s):    Karl Churchill                                           **//
//** Note(s):                                                               **//
//** Copyright:    (C)1996-2005, eXtropia Studios                           **//
//**               Serkan YAZICI, Karl Churchill                            **//
//**               All Rights Reserved.                                     **//
//**                                                                        **//
//****************************************************************************//

#include "fractal.hpp"
#include <iolib/fileio.hpp>

////////////////////////////////////////////////////////////////////////////////

FractalMap::FractalMap(sint32 seed, sint32 dim, float32 rough, float32 decay)
{
  this->seed    = seed;
  this->dim    = Clamp::integer(dim, 4, 10);
  this->size    = 1<<dim;
  this->rough  = Clamp::real(rough, 0.1, 1.0);
  this->decay  = Clamp::real(decay, 0.01, 1.5);

  finalMin    = -0.01;
  finalMax    = 0.01;
  data        = (float32*)Mem::alloc(((size+1)*(size+1))*sizeof(float32), true);
}

////////////////////////////////////////////////////////////////////////////////

FractalMap::~FractalMap()
{
  if (data)
    Mem::free(data);
}

////////////////////////////////////////////////////////////////////////////////

void FractalMap::calculate1()
{
  srand(seed);
  point(0,0)        = rnd(rough);
  point(0,size)      = rnd(rough);
  point(size,size)  = rnd(rough);
  point(size,0)      = rnd(rough);

  float32 tRough = rough;
  for (int i=0; i<dim; ++i) {
    //srand(seed);
    int r=1<<(dim-i), s = r>>1;
    for (int j=0; j<size; j+=r)
      for (int k=0; k<size; k+=r)
        diamond(j, k, r, tRough);
    if (s>0)
      for (int j=0; j<=size; j+=s)
        for (int k=(j+s)%r; k<=size; k+=r)
          square(j-s, k-s, r, tRough);
    tRough *= decay;
  }
}

////////////////////////////////////////////////////////////////////////////////

void FractalMap::calculate2()
{
  srand(seed);
  point(0,0)        = rnd(rough);
  point(0,size)      = rnd(rough);
  point(size,size)  = rnd(rough);
  point(size,0)      = rnd(rough);

  float32 tRough = rough;

  for (int level=dim; level>=0; level--) {
    int stepSize = 1<<level;
    for (int x=0; x<size; x+=stepSize) {
      for (int y=0; y<size; y+=stepSize) {
        int r = (1<<(level+1))-1;
        int z1 = x & r;
        int z2 = y & r;
        if (z1|z2) {
          if (z1==0) {
            float32 avg = 0.5*(point(x, y+stepSize) + point(x, y-stepSize));
            avg += rnd(tRough*(avg+0.5));
            if (avg<finalMin)
              finalMin=avg;
            else if (avg>finalMax)
              finalMax=avg;
            point(x,y)=avg;
          }
          else if (z2==0) {
            float32 avg = 0.5*(point(x+stepSize, y) + point(x-stepSize, y));
            avg += rnd(tRough*(avg+0.5));
            if (avg<finalMin)
              finalMin=avg;
            else if (avg>finalMax)
              finalMax=avg;
            point(x,y)=avg;
          }
          else {

            float32 avg = 0.25*(point(x+stepSize, y+stepSize) +
                                point(x+stepSize, y-stepSize) +
                                point(x-stepSize, y+stepSize) +
                                point(x-stepSize, y-stepSize));
            avg += rnd(tRough*(avg+0.5));
            if (avg<finalMin)
              finalMin=avg;
            else if (avg>finalMax)
              finalMax=avg;
            point(x,y)=avg;
          }
        }
      }
    }
    tRough *= decay;
  }
}

////////////////////////////////////////////////////////////////////////////////

ImageBuffer* FractalMap::exportGreyScale(sint16 x, sint16 y, sint16 w, sint16 h)
{
  ImageBuffer* img = new ImageBuffer;
  if (!img)
    return 0;
  if (w<0) w = size;
  if (h<0) h = size;
  x = Clamp::integer(x, 0, size-1);
  y = Clamp::integer(y, 0, size-1);
  w = Clamp::integer(w, 1, size-x);
  h = Clamp::integer(h, 1, size-y);
  if (img->create(w, h, Pixel::INDEX8, 0, true, 256)!=OK) {
    delete img;
    return 0;
  }

  Palette* p = img->getPalette();
  if (p) {
    Colour* c = p->getTable();
    for (uint32 i=0; i<255; i++) {
      c[i] = (0xFF000000|i<<16|i<<8|i);
    }
  }

  uint8* dst = (uint8*)img->getData();

  if (dst) {
    float32 normal = 255.0f / fabs(finalMax-finalMin);
    float32 zeroPt = -finalMin;

    while (h--) {
      sint32 tw = w;
      float32* src = &data[(y<<dim)+y+x];
      while (tw--) {
        *dst++ = (uint8)(normal*((*src++)+zeroPt));
      }
      y++;
    }
  }
  return img;
}


////////////////////////////////////////////////////////////////////////////////

ImageBuffer* FractalMap::exportRGB(const char* palName, sint16 x, sint16 y, sint16 w, sint16 h)
{
  ImageBuffer* img = new ImageBuffer;
  if (!img)
    return 0;
  if (w<0) w = size;
  if (h<0) h = size;
  x = Clamp::integer(x, 0, size-1);
  y = Clamp::integer(y, 0, size-1);
  w = Clamp::integer(w, 1, size-x);
  h = Clamp::integer(h, 1, size-y);
  if (img->create(w, h, Pixel::ARGB32B)!=OK) {
    delete img;
    return 0;
  }

  static uint32 cmap[256];

  StreamIn palette(palName, false);
  if (palette.valid()) {
    palette.seek(48);
    for (uint32 i=0; i<255; i++) {
      cmap[i] = (i<<24) |
      ((uint32)palette.getChar())<<16 |
      ((uint32)palette.getChar())<<8 |
      ((uint32)palette.getChar());
    }
    palette.close();
  }

  uint32* dst = (uint32*)img->getData();

  if (dst) {
    float32 normal = 255.0f / fabs(finalMax-finalMin);
    float32 zeroPt = -finalMin;
    while (h--) {
      sint32 tw = w;
      float32* src = &data[(y<<dim)+y+x];
      while (tw--) {
        *dst++ = cmap[(uint8)(normal*((*src++)+zeroPt))];
      }
      y++;
    }
  }
  else {
    delete img;
    return 0;
  }
  return img;
}

ImageBuffer* FractalMap::exportNormalMap(float32 zScale, sint16 x, sint16 y, sint16 w, sint16 h)
{
  ImageBuffer* img = new ImageBuffer;
  if (!img)
    return 0;
  if (w<0) w = size;
  if (h<0) h = size;
  x = Clamp::integer(x, 0, size-1);
  y = Clamp::integer(y, 0, size-1);
  w = Clamp::integer(w, 1, size-x);
  h = Clamp::integer(h, 1, size-y);
  if (img->create(w, h, Pixel::ARGB32B)!=OK) {
    delete img;
    return 0;
  }
  uint32* dst = (uint32*)img->getData();
  if (dst) {
    float32 scale = zScale / fabs(finalMax-finalMin);
    float32  hScale  = 255.0 / fabs(finalMax-finalMin);
    float32 zeroPt = -finalMin;
    while (h--) {
      sint32 tw = w;
      float32* src1 = &data[(y<<dim)+y+x];
      float32* src2 = &data[((y+1)<<dim)+y+x];
      while (tw--) {
        // for the case in point, we have unit steps of x and y
        // which reduces the usual full vector product to just
        // c2 + c1 - 1.0

        // calculate the end result of the pair of normals for
        // 2 triangles that cross the area of the pixel

        //float32 nx = scale*(src1[0]-src1[1]);
        //float32 ny = scale*(src1[1]-src2[0]);
        //float32 n2x  = scale*(src2[1]-src2[0]);
        //float32 n2y  = scale*(src1[1]-src2[1]);

        float32 nx = scale*((src1[0]-src1[1]) + (src2[1]-src2[0]));
        float32 ny = scale*((src1[1]-src2[0]) + (src1[1]-src2[1]));
        float32 sf = 127.0/sqrt(nx*nx + ny*ny + 4.0); // normalizing factor

        // Encode normal into RGB as R=Nx, G=Ny, B = Nz
        // Data stored as an 8-bit unsigned, 0 = -1.0, 128 = 0.0, 255 = 1.0
        // Store the maximum scale height in the alpha component

        *dst++ = ((uint8)((src1[0]+zeroPt)*hScale))<<24 |
                 ((uint8)(sf*nx)+128)<<16 |
                 ((uint8)(sf*ny)+128)<<8 |
                 ((uint8)(sf)+128);
        src1++;
        src2++;
      }
      y++;
    }
  }
  else {
    delete img;
    return 0;
  }
  return img;
}
