//****************************************************************************//
//**                                                                        **//
//** File:         proj/engine/map.cpp                                      **//
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

#include "world.hpp"

////////////////////////////////////////////////////////////////////////////////
//
//  WorldView
//
////////////////////////////////////////////////////////////////////////////////

WorldView::WorldView(sint16 w, sint16 h, float32 vW) :
dispW(w), dispH(h), viewW(vW), zoom(1.0), invZoom(1.0), yawAngle(0.0), overAngle(M_PI/2.0),
reproject(1), retransform(1)
{
  // initial viewport top right (origin at centre of display)
  origin.x = 0.5*(WorldMap::scaledW);
  origin.y = 0.5*(WorldMap::scaledH);

  iniTR.x = 0.5*vW;
  iniTR.y = 0.5*vW*((float32)h) / ((float32)w);
}

WorldView::~WorldView()
{

}

void WorldView::set(float32 x, float32 y, float32 z, float32 yaw, float32 over)
{
  origin.x  = Clamp::real(x, 0.0, WorldMap::scaledW);
  origin.y  = Clamp::real(y, 0.0, WorldMap::scaledH);
  zoom = z;
  invZoom = 1.0/z;
  yawAngle  = yaw*(M_PI/180.0);
  overAngle  = over*(M_PI/180.0);
  projectViewOnMap();
  buildTransformation();
}

void WorldView::projectViewOnMap()
{
  float32 cYaw = cos(yawAngle);
  float32 sYaw = sin(yawAngle);
  float32 sx   = invZoom;
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

  reproject=0;
}

void WorldView::buildTransformation()
{
  // Build the View to display transformation.
  // TO DO - work these through on paper and produce a single stage operation

  viewTransform.identity();

  // First redefine the origin to be that of the WorldView
  // This is acheived by subtracting the WorldView origin from the
  // incoming vertex coordinates, so we need -origin.x, -origin.y
  viewTransform.translate(-origin.x, -origin.y, 0.0);

  // Next rotate the world axes to match that of the WorldView.
  // This is achieved by rotating the world z axis by -yawAngle and the
  // world x axis by overAngle
  viewTransform.rotate((0.5*M_PI)-overAngle, 0.0, -yawAngle);

  // Next scale the fit zoom / screen space (y axis inverted).

  float32 scaleXY = zoom/viewW;
  float32 scaleZ = -scaleXY;

  viewTransform.scale(scaleXY*dispW, scaleXY*(-dispW), 0);

  // Recenter on the display centre
  viewTransform.translate(0.5*dispW, 0.5*dispH, 0.0);

  retransform = 0;
}

void WorldView::debugPrint()
{
  if (reproject)
    projectViewOnMap();
  if (retransform)
    buildTransformation();

  printf("\n-----------------------------------------\n");
  printf("View size    %hd x %hd\n", dispW, dispH);
  printf("World size   %0.2f x %0.2f\n", (iniTR.x*2.0*invZoom), (iniTR.y*2.0*invZoom/sin(overAngle)));
  printf("View zoom    %0.2f\n", zoom);
  printf("View yaw     %0.2f\n", (180.0/M_PI)*yawAngle);
  printf("View over     %0.2f\n", (180.0/M_PI)*overAngle);
  printf("View origin  [%0.2f, %0.2f]\n", origin.x, origin.y);
  printf("Projected TL [%0.2f, %0.2f]\n", projected[0].x, projected[0].y);
  printf("Projected TR [%0.2f, %0.2f]\n", projected[1].x, projected[1].y);
  printf("Projected BL [%0.2f, %0.2f]\n", projected[2].x, projected[2].y);
  printf("Projected BR [%0.2f, %0.2f]\n", projected[3].x, projected[3].y);
  viewTransform.debugPrint();
  printf("-----------------------------------------\n\n");

  Vector3D test[4] = {
    Vector3D(projected[0].x, projected[0].y, 0.0),
    Vector3D(projected[1].x, projected[1].y, WorldMap::scaledD),
    Vector3D(projected[2].x, projected[2].y, 0.0),
    Vector3D(projected[3].x, projected[3].y, WorldMap::scaledD)
  };

  viewTransform.transform(test,4);
  for (sint32 i=0;i<4;i++) {
    test[i].debugPrint();
  }
}

