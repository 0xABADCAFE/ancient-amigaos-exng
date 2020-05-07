//****************************************************************************//
//**                                                                        **//
//** File:         prj/gfxTest/drawtest.cpp                                 **//
//** Description:  Rasterizer test application                              **//
//** Comment(s):                                                            **//
//** Created:      2003-04-30                                               **//
//** Updated:      2003-09-22                                               **//
//** Author(s):    Karl Churchill                                           **//
//** Note(s):                                                               **//
//** Copyright:    (C)1996-2003, eXtropia Studios                           **//
//**               Serkan YAZICI, Karl Churchill                            **//
//**               All Rights Reserved.                                     **//
//**                                                                        **//
//****************************************************************************//

#ifndef _ENGINE_VIEW_HPP_
#define _ENGINE_VIEW_HPP_

#include "3D.hpp"

////////////////////////////////////////////////////////////////////////////////
//
//  View
//
//  Maitains a view of the WorldMap defined by position, orientation, zoom,
//  viewport size and scale.
//
//  View orientation can be given in an angular format that is more suitable
//  for keyboard control (rotate/pitch).
//
//  Vector Orientation (same as world)
//
//  +y: north
//  -y: south
//  +x: east
//  -x: west
//  +z: up
//  -z: down
//
//  Angular definition
//
//  Yaw   (rotation about z axis), positive values rotate westward
//  Over  (rotation about x axis), 90 deg = top down, 30 deg = isometric
//
////////////////////////////////////////////////////////////////////////////////

class View {
  private:
    Transformation viewMatrix;
    Vector3D  orientation;
    Coord2D    origin;
    Coord2D    iniTR;
    Coord2D    projected[4];
    sint16    dispW;
    sint16    dispH;
    float32    scale;
    float32    minX;
    float32    minY;
    float32    maxX;
    float32    maxY;

    float32    zoomLevel;
    float32    yawAngle;
    float32    overAngle;

    void      project();

  public:
    static const float32  defYaw  = 45.0;
    static const float32  minOver = 10.0;
    static const float32  maxOver = 90.0;
    static const float32  defOver  = 30.0;

    void    set(float32 x, float32 y, float32 zoom, float32 yaw, float32 over);
    sint32  init(sint16 w, sint16 h, float32 scaleFac, float32 minmX, float32 minmY, float32 maxmX, float32 maxmY);

    View();
    ~View();

    void debugPrint();
};

#endif