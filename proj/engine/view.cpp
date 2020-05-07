//****************************************************************************//
//**                                                                        **//
//** File:         proj/engine/view.cpp                                     **//
//** Description:                                                           **//
//** Comment(s):                                                            **//
//** Created:      2005-10-23                                               **//
//** Updated:      2005-10-23                                               **//
//** Author(s):    Karl Churchill                                           **//
//** Note(s):                                                               **//
//** Copyright:    (C)1996+, eXtropia Studios                               **//
//**               Serkan YAZICI, Karl Churchill                            **//
//**               All Rights Reserved.                                     **//
//**                                                                        **//
//****************************************************************************//

#include "view.hpp"


View::View() : dispW(0), dispH(0), scale(0), minX(0), minY(0), maxX(0), maxY(0)
{

}

View::~View()
{

}

sint32 View::init(sint16 w, sint16 h, float32 scaleFac, float32 minmX, float32 minmY, float32 maxmX, float32 maxmY)
{
  if (w<320 || w>1024 || h<240 || h>768)
    return ERR_VALUE;
  dispW = w;
  dispH = h;

  if (minmX>maxmX) {
    minX = maxmX;
    maxX = minmX;
  } else {
    minX = minmX;
    maxX = maxmX;
  }

  if (minmY>maxmY) {
    minY = maxmY;
    maxY = minmY;
  } else {
    minY = minmY;
    maxY = maxmY;
  }

  // initial viewport top right (origin at centre of display)
  origin.x = 0.5*(minX+maxX);
  origin.y = 0.5*(minY+maxY);
  iniTR.x = 0.5*dispW;
  iniTR.y = 0.5*dispH;
}

void  View::set(float32 x, float32 y, float32 zoom, float32 yaw, float32 over)
{
  origin.x  = Clamp::real(x, minX, maxX);
  origin.y  = Clamp::real(y, minY, maxY);
  over      = Clamp::real(over, minOver, maxOver);
  zoomLevel  = zoom;
  yawAngle  = yaw*(M_PI/180.0);
  overAngle  = over*(M_PI/180.0);

  project();
}

void View::project()
{
  float32 cYaw = cos(yawAngle);
  float32 sYaw = sin(yawAngle);
  float32 sx   = scale*zoomLevel;
  float32  sy   = sx/sin(overAngle);

  float32 x1   = sx*iniTR.x*cYaw;
  float32 y1   = sy*iniTR.y*sYaw;
  float32 x2   = sx*iniTR.x*sYaw;
  float32 y2   = sy*iniTR.y*cYaw;

  register Coord2D* v = projected;

  // The above variables now contain the following, note TR == View top right corner
  //
  // x1 = TRx * cos(A')
  // y1 = TRy * sin(A') - scaled for over angle
  // x2 = TRx * sin(A')
  // y2 = TRy * cos(A') - scaled for over angle
  // x = x
  // y = y
  //
  // rotate and translate ViewRect single step. We can do this simply by using
  // addition/subtraction of above terms and taking note of symmetry relating the corners
  // to BR

  v->x = origin.x - x1 - y1; // TL'x = Ox + [ -TRx *  cos A' ] + [  TRy * -sin A' ]
  v->y = origin.y - x2 + y2; // TL'y = Oy + [ -TRx *  sin A' ] + [  TRy *  cos A' ]
  //printf("TL [%0.2f, %0.2f]\n", v->x, v->y);
  v++;
  v->x = origin.x + x1 - y1; // TR'x = Ox + [  TRx *  cos A' ] + [  TRy * -sin A' ]
  v->y = origin.y + x2 + y2; // TR'y = Oy + [  TRx *  sin A' ] + [  TRy *  cos A' ]
  //printf("TR [%0.2f, %0.2f]\n", v->x, v->y);
  v++;
  v->x = origin.x - x1 + y1; // BL'x = Ox + [ -TRx *  cos A' ] + [ -TRy * -sin A' ]
  v->y = origin.y - x2 - y2; // BL'y = Oy + [ -TRx *  sin A' ] + [ -TRy *  cos A' ]
  //printf("BL [%0.2f, %0.2f]\n", v->x, v->y);
  v++;
  v->x = origin.x + x1 + y1; // BR'x = Ox + [  TRx *  cos A' ] + [ -TRy * -sin A' ]
  v->y = origin.y + x2 - y2; // BR'y = Oy + [  TRx *  sin A' ] + [ -TRy *  cos A' ]
  //printf("BR [%0.2f, %0.2f]\n", v->x, v->y);
}

void View::debugPrint()
{
  printf("XY [%0.2f, %0.2f]\n", origin.x, origin.y);
  printf("TL [%0.2f, %0.2f]\n", projected[0].x, projected[0].y);
  printf("TR [%0.2f, %0.2f]\n", projected[1].x, projected[1].y);
  printf("BL [%0.2f, %0.2f]\n", projected[2].x, projected[2].y);
  printf("BR [%0.2f, %0.2f]\n", projected[3].x, projected[3].y);

}
