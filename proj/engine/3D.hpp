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

#ifndef _ENGINE_3D_HPP_

#define _ENGINE_3D_HPP_

#include <xbase.hpp>
#include <gfxlib/gfx3D.hpp>

extern "C" {
  #include <math.h>
}

inline sint32 qabs(sint32 v)
{
  return v<0 ? -v : v;
}

inline float32 qabs(float32 v)
{
  return v<0.0f ? -v : v;
}

////////////////////////////////////////////////////////////////////////////////
//
//  Coord2D
//
//  Basic xy primitive, used for 2D operations.
//
////////////////////////////////////////////////////////////////////////////////


class Coord2D {
  public:
    float32 x;
    float32 y;

    // null constructor
    Coord2D() {}

    // float constructor
    Coord2D(float32 ix, float32 iy) : x(ix), y(iy) {}

    // copy constructor
    Coord2D(const Coord2D& c)
    {
       x=c.x; y=c.y;
    }

    // assignment
    Coord2D& operator=(const Coord2D& c)
    {
      x=c.x; y=c.y;
      return *this;
    }

    // add - assign
    Coord2D& operator+=(const Coord2D& c)
    {
      x+=c.x; y+=c.y;
      return *this;
    }

    // subtract - assign
    Coord2D& operator-=(const Coord2D& c)
    {
      x-=c.x; y-=c.y;
      return *this;
    }

    // scale by float - assign
    Coord2D& operator*=(float32 i)  {
      x*=i; y*=i;
      return *this;
    }

    Coord2D& operator/=(float32 i)
    {
      i=1.0f/i; x*=i; y*=i;
      return *this;
    }
};

////////////////////////////////////////////////////////////////////////////////
//
//  Vector3D
//
//  Basic xyz primitive, used for 3D calculations and as Vertex base class.
//
////////////////////////////////////////////////////////////////////////////////

class Transformation;

class Vector3D : public G3D::XYZ_f32 {
  public:
    // null constructor
    Vector3D() {}

    // float constructor
    Vector3D(float32 ix, float32 iy, float32 iz)
    {
      x = ix; y = iy; z = iz;
    }

    // copy constructor
    Vector3D(const Vector3D& v)
    {
       x=v.x; y=v.y; z=v.z;
    }

    // assignment
    Vector3D& operator=(const Vector3D& v)
    {
      x=v.x; y=v.y; z=v.z;
      return *this;
    }

    // add - assign
    Vector3D& operator+=(const Vector3D& v)
    {
      x+=v.x; y+=v.y; z+=v.z;
      return *this;
    }

    // subtract - assign
    Vector3D& operator-=(const Vector3D& v)
    {
      x-=v.x; y-=v.y; z-=v.z;
      return *this;
    }

    // scale by float - assign
    Vector3D& operator*=(float32 i)  {
      x*=i; y*=i; z*=i;
      return *this;
    }

    Vector3D& operator/=(float32 i)
    {
      i=1.0f/i; x*=i; y*=i; z*=i;
      return *this;
    }

    // cross product - assign
    Vector3D& operator*=(const Vector3D& v)
    {
      // A x B = (b1*c2-b2*c1)i + (a2*c1-a1*c2)j + (a1*b2-a2*b1)k
      rfloat32 tx = x;  x = y*v.z - v.y*z;  // (b1*c2-b2*c1)i
      rfloat32 ty = y;  y = v.x*z - tx*v.z; // (a2*c1-a1*c2)j
      z = tx*v.y - v.x*ty;                  // (a1*b2-a2*b1)k
      return *this;
    }

    // transform
    Vector3D& operator*=(const Transformation& t);

    // utilities
    float32 dot(const Vector3D& v) const
    {
      return (x*v.x)+(y*v.y)+(z*v.z);
    }

    float32 magnitude()  const
    {
      return sqrt(x*x + y*y + z*z);
    }

    float32 normalize()
    {
      float32 r = magnitude();
      (*this)/=r; return r;
    }

    float32 distanceFrom(const Vector3D& v) const
    {
      float32 s = x-v.x; s*=s;
      float32 t = y-v.y; t*=t;
      s += t;  t = z-v.z; t*=t;
      s += t;
      return sqrt(s);
    }

    Vector3D directionCosine() const
    {
      // returns a Vector3D comprising the direction cosines of this Vector3D
      Vector3D r(*this);
      r.normalize();
      return r;
    }

    float32 angleCosine(const Vector3D& v) const
    {
      // returns cos(a) where a is the angle between this Vector3D and v
      float32 t1 = x*v.x + y*v.y + z*v.z;
      float32 t2 = ((x*x) + (y*y) + (z*z))*((v.x*v.x) + (v.y*v.y) + (v.z*v.z));
      return t1 / sqrt(t2);
    }

    bool facing(const Vector3D& v) const
    {
      return (x*v.x + y*v.y + z*v.z)<0.0;
    }

    static float32 distance(const Vector3D& a, const Vector3D& b)
    {
      return a.distanceFrom(b);
    }

    void debugPrint();
};

// Non member operators

inline Vector3D operator+(const Vector3D& a, const Vector3D& b)
{
  Vector3D r(a);
  r+=b;
  return r;
}

inline Vector3D operator-(const Vector3D& a, const Vector3D& b)
{
  Vector3D r(a);
  r-=b;
  return r;
}

inline Vector3D operator*(const Vector3D& a, const Vector3D& b)
{
  Vector3D r(a);
  r*=b;
  return r;
}

inline bool operator==(const Vector3D& a, const Vector3D& b)
{
  if (a.x==b.x && a.y==b.y && a.z==b.z)
    return true;
  return false;
}

inline bool operator!=(const Vector3D& a, const Vector3D& b)
{
  if (a.x==b.x && a.y==b.y && a.z==b.z)
    return false;
   return true;
}
////////////////////////////////////////////////////////////////////////////////
//
//  Vertex
//
//  Represents a simple vertex, derived from Vector3D. Includes texture coords
//  and colour information.
//
//
////////////////////////////////////////////////////////////////////////////////

struct Vertex : public Vector3D {
  public:
    G3D::UVW_f32  texCrd;
    G3D::ARGB_u8  colour;
    Vector3D*      normal;
  public:
    Vertex() : normal(0) {}
    Vertex(float32 ix, float32 iy, float32 iz) : Vector3D(ix, iy, iz), normal(0) {}

    void debugPrint();
};

////////////////////////////////////////////////////////////////////////////////
//
//  Transformation
//
//  Encapsulates a 4x4 transformation matrix. Internally, a double buffered
//  system is used to reduce the need for temporaries/copying when performing
//  matrix multiplication.
//
////////////////////////////////////////////////////////////////////////////////

class Transformation {
  friend class Vector3D;
  friend Transformation operator*(const Transformation& a, const Transformation& b);

  private:
    float32   data[32]; // contains space for 2 4x4 matrices
    float32*  matrix;

  protected:
    Transformation(int)
    {
      matrix = data; // no further initialisation
    }

    void      swap()
    {
      matrix = ((matrix == data) ? data+16 : data);
    }

    float32*  getTemp()
    {
      return ((matrix == data) ? data+16 : data);
    }

  public:
    float32*  getMatrix()
    {
      return matrix;
    }

    void identity()
    {
      ruint32* m = (uint32*)matrix;
      ruint32 one = 0x3F800000;
      *(m++) = one;  *(m++) = 0;    *(m++) = 0;    *(m++) = 0;
      *(m++) = 0;    *(m++) = one;  *(m++) = 0;    *(m++) = 0;
      *(m++) = 0;    *(m++) = 0;    *(m++) = one; *(m++) = 0;
      *(m++) = 0;    *(m++) = 0;    *(m++) = 0;   *(m++) = one;
    }

    // scaling
    void scale(float32 s)
    {
      rfloat32* m = matrix;
      *(m++) *= s; *(m++) *= s; *(m++) *= s; *(m++) *= s;
      *(m++) *= s; *(m++) *= s; *(m++) *= s; *(m++) *= s;
      *(m++) *= s; *(m++) *= s; *(m++) *= s; *(m++) *= s;
    }

    void scale(float32 sx, float32 sy, float32 sz)
    {
      rfloat32* m = matrix;
      *(m++) *= sx; *(m++) *= sx; *(m++) *= sx; *(m++) *= sx;
      *(m++) *= sy; *(m++) *= sy; *(m++) *= sy; *(m++) *= sy;
      *(m++) *= sz; *(m++) *= sz; *(m++) *= sz; *(m++) *= sz;
    }

    void scale(const Vector3D& s)
    {
      scale(s.x, s.y, s.z);
    }

    // translation
    void translate(float32 tx, float32 ty, float32 tz)
    {
      matrix[3]+=tx;
      matrix[7]+=ty;
      matrix[11]+=tz;
    }

    void translate(const Vector3D& t)
    {
      translate(t.x, t.y, t.z);
    }

    // rotation
    void rotate(float32 rx, float32 ry, float32 rz);

    void rotate(const Vector3D& r)
    {
      rotate(r.x, r.y, r.z);
    }

    // vector/vertex transformation
    void transform(Vector3D* s, size_t n);
    void transform(Vector3D* d, const Vector3D* s, size_t n);
    void transform(Vertex* s, size_t n);
    void transform(Vertex* d, const Vertex* s, size_t n);

    // vertex texture coord transformation
    void transformTex(Vertex* s, size_t n);
    void transformTex(Vertex* d, const Vertex* s, size_t n);

    Transformation& operator=(const Transformation& t);
    Transformation& operator*=(const Transformation& t);

  public:
    Transformation()
    {
      matrix = data;
      identity();
    }

    Transformation(const Transformation& t);

    void debugPrint();
};

#endif