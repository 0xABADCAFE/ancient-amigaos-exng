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

#ifndef _ENGINE_MAP_HPP_
#define _ENGINE_MAP_HPP_

#include "3d.hpp"

////////////////////////////////////////////////////////////////////////////////
//
//  MapCell (Flyweight)
//
//  Represents a prefabricated cell used to construct the main map. This can
//  be viewed as the 3D equivalent of using tiles in a 2D engine.
//  Each cell occupies a fixed cubic volume and may contain up to MAX_TRIS
//  unique triangle definitions. Triangles may share vertices for smoothly
//  shaded geometry.
//
//  Each map may use up to MAX_CELLS unique cells.
//
//  The cell orientation is the same as the world space orientation. This allows
//  various calculations like global lighting and visibility analysis to be
//  applied to each cell rather than for every instance of a cell.
//
////////////////////////////////////////////////////////////////////////////////
/*
class MapCell {
  public:
    enum {
      // cell limits
      CELL_MAX_UNIQUE        = 256,              // Maximum cell definitions per map
      CELL_MAX_TRIS          = 32,                // Maximum triangles per cell
      CELL_MAX_VERTS        = CELL_MAX_TRIS*3,  // Maximum vertices per cell
      CELL_MAX_TEXTURES      = 256,              // Maximum textures per map

      // cell face definitions
      CELL_FACE_EAST_WALL    =  0x01,  // x = 1.0
      CELL_FACE_WEST_WALL    = 0x02,  // x = 0.0
      CELL_FACE_NORTH_WALL  = 0x04,  // y = 1.0
      CELL_FACE_SOUTH_WALL  = 0x88,  // y = 0.0
      CELL_FACE_CEILING      = 0x10,  // z = 1.0
      CELL_FACE_FLOOR        = 0x20,  // z = 0.0

      // cell content definitions
      CELL_SPACE            = 0,
      CELL_SOLID            = 1,
      CELL_WATER            = 2,
    };

    struct TriDef {
      uint8  iVtx1;      // index of first vertex
      uint8 iVtx2;
      uint8 iVtx3;
      uint8 iNrm;        // index of face normal
      uint8  iTex;        // index of texture
      uint8  pad;
    };

  private:
    static  Vertex*    vertexHeap;
    static  Vector3D*  normalHeap;
    static  TriDef*    triangleHeap;
    static  MapCell*  cellHeap;

    float32 faceVis[6]; // face visibility fraction
    uint8    faceSolid;  // bitvector of impassible faces
    uint8    content;
    uint8    floorType;
    uint8    visDone;
    uint8    numVerts;      // number of vertices in this cell
    uint8    numTris;      // number of complete triangle defs in this cell
    uint8    numFaceNorms;  // number of face normal defs in this cell
    uint8    numVertNorms;  // number of vertex normal defs in this cell

    TriDef*    iniTris;      // initial triangle definitions
    Vertex*    iniVerts;      // initial vertex definitions
    Vector3D*  iniFaceNorms;  // initial face normals
    Vector3D*  iniVertNorms;  // initial vertex normals

    TriDef*    tris;          // triangle definitions after visibility
    Vertex*    verts;        // vertex definitions after visibility
    Vector3D*  faceNorms;    // face normals after visibility
    Vector3D*  vertNorms;    // vertex normals after visibility

  private:
    MapCell();

  public:
    static

};
*/

struct MapCell {
  // initial placeholder class
  Vertex verts[4];
};

////////////////////////////////////////////////////////////////////////////////
//
//  MapCellInstance
//
//  Represents an instance of a MapCell within a map.
//
////////////////////////////////////////////////////////////////////////////////

struct MapCellInstance {
  Vector3D  origin;
  uint16    marked;
  uint16    cell;
  // 16 bytes
};

////////////////////////////////////////////////////////////////////////////////
//
//  WorldMap
//
//  Maintains the collection of MapCellInstance and MapCell objects that
//  comprise the basic map.
//
//  Also defines the principal scale of the map, converting the MapCell's
//  normalized unit (0.0 - 1.0) into a 'realworld' value in whatever unit the
//  engine defines.
//
//  Vector Orientation
//
//  +y: north
//  -y: south
//  +x: east
//  -x: west
//  +z: up
//  -z: down
//
////////////////////////////////////////////////////////////////////////////////

class WorldView;

class WorldMap {
  friend class WorldView;
  private:
    static MapCellInstance*    map;        // main map data
    static MapCell*            cells;      // actual cell definitions

    static float32            scale;      // cell unit size
    static float32            scaledW;
    static float32            scaledH;
    static float32            scaledD;
    static uint16              width;
    static uint16              height;
    static uint8              dimW;
    static uint8              dimH;
    static uint8              depth;      // layers deep, unused just now
    static uint8              markVal;

    static MapCellInstance**  getRowOrdered(MapCellInstance** list, sint16 x1, sint16 y1, sint16 x2, sint16 y2);

    // this function captures an arbitary rectangular area, returning
    // a list of cells that are approximately ordered in the rectangle's own
    // top to bottom / left to right row major definition.
    // This is primarily intended to assist rear to front drawing of cells that
    // fall within a transformed (into map space) viewport. Do not rely on this
    // for distance *exact* ordering.
    static sint32 getAreaOrdered(MapCellInstance** list, const Coord2D* coords);

  public:
    static const float32      minScl = 1.0;
    static const float32      maxScl = 128.0;
    static const uint8        minDim = 4;
    static const uint8        maxDim = 8;
    static const uint8        minDep = 1;
    static const uint8        maxDep = 1;


    static sint32  init(float32 s, uint16 dW, uint16 dH, uint16 d);
    static void    done();

    static float32 getScaleWidth()  { return scaledW; }
    static float32 getScaleHeight()  { return scaledH; }
    static float32 getScaleDepth()  { return scaledD; }


    static MapCellInstance*    getCellAtPosition(const Vector3D& v);



    static WorldView*  createView(sint16 w, sint16 h, float32 viewWidth);
};

////////////////////////////////////////////////////////////////////////////////
//
//  WorldView
//
////////////////////////////////////////////////////////////////////////////////


class WorldView {
  friend class WorldMap;
  private:
    Transformation viewTransform;
    Vector3D  orientation;
    Coord2D    origin;
    Coord2D    iniTR;
    Coord2D    projected[4];

    sint16    dispW;
    sint16    dispH;
    float32    viewW;
    float32    zoom;
    float32    invZoom;
    float32    yawAngle;
    float32    overAngle;

    uint8      reproject;
    uint8      retransform;

    // can only be created by WorldMap::createView()
    WorldView(sint16 w, sint16 h, float32 viewWidth);

  public:
    static const float32  defYaw  = 45.0;
    static const float32  minOver = 10.0;
    static const float32  maxOver = 90.0;
    static const float32  defOver  = 30.0;

    void projectViewOnMap();
    void buildTransformation();

    void setOrigin(float32 x, float32 y)
    {
      origin.x  = Clamp::real(x, 0.0, WorldMap::scaledW);
      origin.y  = Clamp::real(y, 0.0, WorldMap::scaledH);
      reproject = retransform = 1;
    }

    void setOrigin(const Coord2D& c)
    {
      setOrigin(c.x,c.y);
    }

    void setAngles(float32 yaw, float32 over)
    {
      yawAngle  = yaw*(M_PI/180.0);
      overAngle  = over*(M_PI/180.0);
      reproject = retransform = 1;
    }

    void setZoom(float32 z)
    {
      zoom = z;
      invZoom = 1.0/z;
      reproject = retransform = 1;
    }

    sint32  getVisCellsSorted(MapCellInstance** list)
    {
      if (reproject) {
        projectViewOnMap();
      }
      return WorldMap::getAreaOrdered(list, projected);
    }

    const  Transformation& getTransform()
    {
      if (retransform) {
        buildTransformation();
      }
      return viewTransform;
    }

    void set(float32 x, float32 y, float32 z, float32 yaw, float32 over);
    void debugPrint();

    ~WorldView();
};

#endif

