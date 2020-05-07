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

#include <new.h>
#include "world.hpp"

////////////////////////////////////////////////////////////////////////////////
//
//  WorldMap
//
////////////////////////////////////////////////////////////////////////////////

MapCellInstance*   WorldMap::map          = 0;

float32  WorldMap::scale                  = 0.0;
float32  WorldMap::scaledW                = 0.0;
float32  WorldMap::scaledH                = 0.0;
float32  WorldMap::scaledD                = 0.0;
uint16  WorldMap::width                  = 0;
uint16  WorldMap::height                = 0;
uint8    WorldMap::dimW                  = 0;
uint8    WorldMap::dimH                  = 0;
uint8    WorldMap::depth                  = 1;
uint8    WorldMap::markVal                = 0;

sint32 WorldMap::init(float32 s, uint16 dW, uint16 dH, uint16 d)
{
  printf("WorldMap::init(%0.2f, %hu,%hu,%hu)\n",s, dW,dH,d);
  if (map) {
    printf("\talready initialised\n");
    return ERR_RSC_LOCKED;
  }
  if (s<minScl  || s>maxScl ||
      dW<minDim || dW>maxDim ||
      dH<minDim || dH>maxDim ||
      d<minDep || d>maxDep) {
    printf("\tbad parameters\n");
    return ERR_VALUE_RANGE;
  }
  scale    = s;
  dimW    = dW;
  dimH    = dH;
  depth    = d;
  width    = 1<<dimW;
  height  = 1<<dimH;

  scaledW  = width*s;
  scaledH = height*s;
  scaledD = depth*s;

  // allocate MapCellInstance data
  size_t numCells = width*height*depth;
  if (!(map = (MapCellInstance*)Mem::alloc(numCells*sizeof(MapCellInstance), Mem::ALIGN_CACHE))) {
    printf("\tfailed to allocate %ld bytes for map data\n", numCells*sizeof(MapCellInstance));
    done();
    return ERR_NO_FREE_STORE;
  }

  // initialise extrinsic cell data
  printf("\tinitialising extrinsic data [%ld cells]\n", numCells);
  MapCellInstance* mci = map;
  sint16 hMax = height-1;
  for (sint16 y=0; y<height;y++) {
    for (sint16 x=0; x<width; x++) {
      mci->origin.x = scale*(float32)x;
      mci->origin.y = scale*(float32)(hMax-y);
      mci->origin.z = 0.0F;
      mci->marked = 0;
      mci->cell = 0;
      mci++;
    }
  }
  printf("\tOK\n\n");
  return OK;
}


void WorldMap::done()
{
  if (map)
    Mem::free(map);
  printf("WorldMap::done()\n\tOK\n\n");
}

MapCellInstance** WorldMap::getRowOrdered(MapCellInstance** list, sint16 x1, sint16 y1, sint16 x2, sint16 y2)
{
  // Use modified DDA line algorithm to scan from (x1,y1) to (x2,y2) marking
  // all cells that the line passes through.

  // delta x/y amd step x/y
  // To avoid index calculation requiring (y*width)+x, we use a derivative of y
  // and y step that are prescaled by the width.

  // All lines should be appropriately clipped by the outer scan routine, as
  // this routine needs to be as quick as realistically possible.

  sint32 _y1 = ((sint32)y1)<<dimW;
  sint32 _y2 = ((sint32)y2)<<dimW;

  MapCellInstance* mci = &map[x1+_y1];

  sint16 dx = x2-x1;
  sint16 dy = y2-y1;
  sint16 sx = (dx<0) ? (dx = -dx, -1) : 1;
  sint16 sy = (dy<0) ? (dy = -dy, -width) : width;

  if (mci->marked!= markVal) {
    *list++ = mci;
  }

  dx<<=1;
  dy<<=1;

  if (dx > dy) {
    // slope < 1 => x is the unit interval
    sint16 frac = dy - (dx>>1);

    while (x1!=x2) {
      if (frac>=0) {
        // step y
        // Here we also obtain the cell instance at y-1
        // otherwise holes appear
        mci = &map[x1+_y1+sx];
        // only add cell to list if not already marked this time
        if (mci->marked!=markVal) {
          *list++ = mci;
        }

        _y1 += sy;
        frac -= dx;
      }

      x1 += sx;
      frac += dy;
      mci = &map[x1+_y1];

      // only add cell to list if not already marked this time
      if (mci->marked!=markVal) {
        *list++ = mci;
      }
    }
  }
  else {
    // slope > 1 y is the unit interval
    sint16 frac = dx - (dy>>1);
    while (_y1!=_y2) {
      if (frac>=0) {
        // step x
        // Here we also obtain the cell instance at x-1
        // otherwise holes appear
        mci = &map[x1+_y1+sy];

        // only add cell to list if not already marked this time
        if (mci->marked!=markVal) {
          *list++ = mci;
        }
        x1 += sx;
        frac -= dy;
      }

      _y1 += sy;
      frac += dx;
      mci = &map[x1+_y1];

      // only add cell to list if not already marked this time
      if (mci->marked!=markVal) {
        *list++ = mci;
      }
    }
  }
  // return current list position
  return list;
}

sint32 WorldMap::getAreaOrdered(MapCellInstance** list, const Coord2D* coords)
{
  // This  function takes an arbitarty four sided rectangule defined by tl/tr/bl/br
  // and scans the map data to build a list of the MapCellInstances inside the area,
  // as defined by an approximately row major top->bottom, left->right order.
  // This is accomplised by using a modified lineDDA algorithm to  first determine
  // the lines of cells along the lines tl->bl and tr->br as start/end points for
  // an inner row scan.
  // References to the MapCellInstances touched by the scan are stored in markedList.

  // TODO : convert to a float DDA that clips each transformed row's endpoints into
  // the map area so that markRow() can be implemented blindly (for speed)

  printf("WorldMap::markArea({{%0.2f,%0.2f},{%0.2f,%0.2f},{%0.2f,%0.2f},{%0.2f,%0.2f}})\n",
    coords[0].x, coords[0].y,
    coords[1].x, coords[1].y,
    coords[2].x, coords[2].y,
    coords[3].x, coords[3].y
  );

  float32 sf = 1.0/scale;

  sint16 tlX = (sint16)(sf*coords[0].x+0.5f);  sint16 tlY = height - ((sint16)(sf*coords[0].y+1.5f));
  sint16 trX = (sint16)(sf*coords[1].x+0.5f);  sint16 trY = height - ((sint16)(sf*coords[1].y+1.5f));
  sint16 blX = (sint16)(sf*coords[2].x+0.5f);  sint16 blY = height - ((sint16)(sf*coords[2].y+1.5f));
  //sint16 brX = (sint16)(sf*coords[3].x+0.5f);  sint16 brY = height - ((sint16)(sf*coords[3].y+0.5f));
  sint16 rowDX = blX-tlX;
  sint16 rowDY = blY-tlY;
  sint16 sx = (rowDX<0) ? (rowDX = -rowDX, -1) : 1;
  sint16 sy = (rowDY<0) ? (rowDY = -rowDY, -1) : 1;

  ++markVal;

  // scan the initial row tl -> tr

  MapCellInstance** marked = list;

  marked = getRowOrdered(list, tlX,tlY,trX,trY);

  rowDX<<=1;
  rowDY<<=1;

  if (rowDX>rowDY) {
    // slope < 1 => x is the unit interval
    sint16 frac = rowDY - (rowDX>>1);
    while (tlX!=blX) {
      if (frac>=0) {
        tlY += sy;
        trY += sy;
        frac -= rowDX;
      }
      tlX += sx;
      trX += sx;
      frac += rowDY;
      marked = getRowOrdered(marked, tlX,tlY,trX,trY);
    }
  } else {
    // slope > 1 => y is the unit interval

    sint16 frac = rowDX - (rowDY>>1);
    while (tlY!=blY) {
      if (frac>=0) {
        tlX += sx;
        trX += sx;
        frac -= rowDY;
      }
      tlY += sy;
      trY += sy;
      frac += rowDX;
      marked = getRowOrdered(marked, tlX,tlY,trX,trY);
    }
  }

  // null terminate list
  *marked = 0;

  printf("\tMarked %ld\n\tOK\n\n",(marked-list));
  return (marked-list);
}

MapCellInstance* WorldMap::getCellAtPosition(const Vector3D& v)
{
  if (!map)
    return 0;
  if (v.x<0.0 || v.x>scaledW ||
      v.y<0.0 || v.y>scaledH ||
      v.z<0.0 || v.z>scaledD)
    return 0;
  float32 sf = 1.0/scale;
  sint32 i = ((height-((sint32)(sf*v.y+1.5)))<<dimW) + (sint32)(sf*v.x+0.5);
  return &map[i];
}

WorldView*  WorldMap::createView(sint16 w, sint16 h, float32 viewWidth)
{
  if (!map || w<1 || h<1 || viewWidth<scale)
    return 0;
  return new(nothrow) WorldView(w, h, viewWidth);
}

