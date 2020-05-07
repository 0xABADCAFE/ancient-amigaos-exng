//****************************************************************************//
//**                                                                        **//
//** File:         render.cpp                                               **//
//** Description:  Drawing functions                                        **//
//** Comment(s):   Stub header                                              **//
//** Library:      gfxlib                                                   **//
//** Created:      2003-04-27                                               **//
//** Updated:      2003-04-27                                               **//
//** Author(s):    Karl Churchill                                           **//
//** Note(s):                                                               **//
//** Copyright:    (C)1996-2003, eXtropia Studios                           **//
//**               Serkan YAZICI, Karl Churchill                            **//
//**               All Rights Reserved.                                     **//
//**                                                                        **//
//****************************************************************************//

#include "render.hpp"

////////////////////////////////////////////////////////////////////////////////

void SoftRender::line8(REGP0 void* base, sint16 span, S_2CRD, uint8 v)
{
}

////////////////////////////////////////////////////////////////////////////////

void SoftRender::line16(REGP0 void* base, sint16 span, S_2CRD, uint16 v)
{
  sint32 dx = x2-x1;
  sint32 dy = y2-y1;
  sint32 _y1 = y1*span;
  sint32 _y2 = y2*span;

  rsint32 sx = (dx<0) ? (dx = -dx, -1) : 1;
  rsint32 sy = (dy<0) ? (dy = -dy, -span) : span;
  if (dx > dy)
  {
    // x is determinant
    if (x2<x1)
    {
      // swap the ordinates to ensure incremental x
      // which allows for a slight optimisation in
      // the pointer calculation
      sint32
      t  = x2;    x2  = x1;    x1  = t;
      t  = y2;    y2  = y1;    y1  = t;
      t  = _y2;  _y2  = _y1;  _y1  = t;
      sy = -sy;
    }

    ((uint16*)base) += x1+_y1;
    *((uint16*)base) = v;

    rsint32 i = dx+1;  dx<<=1; dy<<=1;
    rsint32 frac = dy - (dx>>1);
    while (--i)
    {
      if (frac>=0)
      {
        ((uint16*)base) += sy;
        frac -= dx;
      }
      frac += dy;
      *(++((uint16*)base)) = v;
    }
  }
  else
  {
    // y is determinant. We dont swap ordinates here
    // since incremental y is always in terms of
    // span widths and not pixels

    ((uint16*)base) += x1+_y1;
    *((uint16*)base) = v;

    rsint32 i = dy+1;  dx<<=1;  dy<<=1;
    rsint32 frac = dx - (dy>>1);
    while (--i)
    {
      if (frac>=0)
      {
        ((uint16*)base) += sx;
        frac -= dy;
      }
      ((uint16*)base) += sy;
      frac += dx;
      *((uint16*)base) = v;
    }
  }
}

////////////////////////////////////////////////////////////////////////////////

void SoftRender::line24(REGP0 void* base, sint16 span, S_2CRD, uint8* v)
{
}

////////////////////////////////////////////////////////////////////////////////

void SoftRender::line32(REGP0 void* base, sint16 span, S_2CRD, uint32 v)
{
}

////////////////////////////////////////////////////////////////////////////////

void SoftRender::lineRGB16(REGP0 void* base, sint16 span, S_2CRD, Colour c1, Colour c2)
{
  sint32 dx = x2-x1;
  sint32 dy = y2-y1;

  sint32 sx = (dx<0) ? (dx = -dx, -1) : 1;
  sint32 sy = (dy<0) ? (dy = -dy, -span) : span;

  sint32 _y1 = y1*span;
  sint32 _y2 = y2*span;

  // Colour step calculation are done in
  // 8.16 fixed pont format
  sint32 red  = c1.red()<<16;
  sint32 grn  = c1.green()<<16;
  sint32 blu  = c1.blue()<<16;
  sint32 redFrac  = ((c2.red()<<16)-red);
  sint32 grnFrac  = ((c2.green()<<16)-grn);
  sint32 bluFrac  = ((c2.blue()<<16)-blu);
  if (dx > dy)
  {
    redFrac/=dx;
    grnFrac/=dx;
    bluFrac/=dx;
  }
  else
  {
    redFrac/=dy;
    grnFrac/=dy;
    bluFrac/=dy;
  }

  ((uint16*)base)[x1+_y1] = ((red>>19)<<11)|((grn>>18)<<5)|(blu>>19);

  dx<<=1;
  dy<<=1;

  if (dx > dy)
  {
    sint32 frac = dy - (dx>>1);
    while (x1!=x2)
    {
      if (frac>=0)
      {
        _y1 += sy;
        frac -= dx;
      }
      x1 += sx;
      frac += dy;
      ((uint16*)base)[x1+_y1] = ((red>>19)<<11)|((grn>>18)<<5)|(blu>>19);
      red += redFrac;
      grn += grnFrac;
      blu += bluFrac;
    }
  }
  else
  {
    sint32 frac = dx - (dy>>1);
    while (_y1!=_y2)
    {
      if (frac>=0)
      {
        x1 += sx;
        frac -= dy;
      }
      _y1 += sy;
      frac += dx;
      ((uint16*)base)[x1+_y1] = ((red>>19)<<11)|((grn>>18)<<5)|(blu>>19);
      red += redFrac;
      grn += grnFrac;
      blu += bluFrac;
    }
  }
}

