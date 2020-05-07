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

#include "3D.hpp"

////////////////////////////////////////////////////////////////////////////////
//
//  Vector3D
//
////////////////////////////////////////////////////////////////////////////////

Vector3D& Vector3D::operator*=(const Transformation& t)
{
  rfloat32*  m  = t.matrix;
  rfloat32  tx = x;
  rfloat32  ty = y;
  rfloat32  tz = z;
  x = tx*m[0] + ty*m[1] + tz*m[2] + m[3];
  y = tx*m[4] + ty*m[5] + tz*m[6] + m[7];
  z = tx*m[8] + ty*m[9] + tz*m[10] + m[11];
  return *this;
}

////////////////////////////////////////////////////////////////////////////////

void Vector3D::debugPrint()
{
  printf("\nVector3D (%8.4f, %8.4f, %8.4f)\n", x, y, z);
}

////////////////////////////////////////////////////////////////////////////////
//
//  Vertex
//
////////////////////////////////////////////////////////////////////////////////

void Vertex::debugPrint()
{
  printf("\nVertex %8.4f, %8.4f, %8.4f\n", x, y, z);
  if (normal)
    printf("(Norm) %8.4f, %8.4f, %8.4f\n", normal->x, normal->y, normal->z);
  printf("(TexC) %8.4f, %8.4f, %8.4f\n", texCrd.u, texCrd.v, texCrd.w);
  printf("(RGB)  %8.4f, %8.4f, %8.4f\n",
    (float32)(colour.r)/255.0f,
    (float32)(colour.g)/255.0f,
    (float32)(colour.b)/255.0f
  );
}

////////////////////////////////////////////////////////////////////////////////
//
//  Transformation
//
////////////////////////////////////////////////////////////////////////////////

Transformation::Transformation(const Transformation& t)
{
  matrix = data;
  ruint32* s = (uint32*)t.matrix;
  ruint32* d = (uint32*)matrix;
  *(s++) = *(d++); *(s++) = *(d++); *(s++) = *(d++); *(s++) = *(d++);
  *(s++) = *(d++); *(s++) = *(d++); *(s++) = *(d++); *(s++) = *(d++);
  *(s++) = *(d++); *(s++) = *(d++); *(s++) = *(d++); *(s++) = *(d++);
  *(s++) = *(d++); *(s++) = *(d++); *(s++) = *(d++); *(s) = *(d);
}

////////////////////////////////////////////////////////////////////////////////

Transformation& Transformation::operator=(const Transformation& t)
{
  if (&t!=this)
  {
    ruint32* s = (uint32*)t.matrix;
    ruint32* d = (uint32*)matrix;
    *(s++) = *(d++); *(s++) = *(d++); *(s++) = *(d++); *(s++) = *(d++);
    *(s++) = *(d++); *(s++) = *(d++); *(s++) = *(d++); *(s++) = *(d++);
    *(s++) = *(d++); *(s++) = *(d++); *(s++) = *(d++); *(s++) = *(d++);
    *(s++) = *(d++); *(s++) = *(d++); *(s++) = *(d++); *(s) = *(d);
  }
  return *this;
}

////////////////////////////////////////////////////////////////////////////////

void Transformation::rotate(float32 rx, float32 ry, float32 rz)
{
  // Performs M' = R.M
  // Build rotation matrix below, then multiply our internal matrix by it.
  //
  //
  //    | C(y)C(z)              -C(y)S(z)               S(y)      0 |
  //    |                                                           |
  //    | S(x)S(y)C(z)+C(x)S(z) -S(x)S(y)S(z)+C(x)C(z)  S(x)C(y)  0 |
  //    |                                                           |
  //    |-C(x)S(y)C(z)-S(x)S(z)  C(x)S(y)S(z)-S(x)C(z)  C(x)C(y)  0 |
  //    |                                                           |
  //    | 0                      0                      0         1 |

  {
    float32 f0 = sin(rx);  float32 f1 = sin(ry);  float32 f2 = sin(rz);
    float32 f3 = cos(rx);  float32 f4 = cos(ry);  float32 f5 = cos(rz);
    rfloat32* m = getTemp();
    // correct layout as above, each row must include zero end terms, even though we'd never use them
    *(m++) = f4*f5;                  *(m++) = -(f4*f2);            *(m++) = f1;    m++; //*(m++) = 0F;
    *(m++) = f0*f1*f5 + f3*f2;      *(m++) = f3*f5 - (f0*f1*f2);  *(m++) = f0*f4;  m++; //*(m++) = 0F;
    *(m++) = -(f3*f1*f5 + f0*f2);    *(m++) = f3*f1*f2 - (f0*f5);  *(m++) = f3*f4;       //*(m) = 0F;
  }

  {
    rfloat32* d = getTemp();
    rfloat32* s1 = d;
    rfloat32* s2 = matrix;

    // Optimized
    // This could be a loop, but is it worth it for 3 iterations ?
    // Note use of simplest addressing modes made possible by using a row * row structure

    // 1st row
    {
      // 'cache' source row terms
      rfloat32 t1 = *(s1++);
      rfloat32 t2 = *(s1++);
      rfloat32 t3 = *(s1++);
      s1++; // s1 points to next row of source matrix

      *(d++) = (t1 * s2[0]) + (t2 * s2[4]) + (t3 * s2[8]);
      *(d++) = (t1 * s2[1]) + (t2 * s2[5]) + (t3 * s2[9]);
      *(d++) = (t1 * s2[2]) + (t2 * s2[6]) + (t3 * s2[10]);
      *(d++) = (t1 * s2[3]) + (t2 * s2[7]) + (t3 * s2[11]);
    }
    // 2nd row
    {
      // 'cache' source row terms
      rfloat32 t1 = *(s1++);
      rfloat32 t2 = *(s1++);
      rfloat32 t3 = *(s1++);
      s1++;

      *(d++) = (t1 * s2[0]) + (t2 * s2[4]) + (t3 * s2[8]);
      *(d++) = (t1 * s2[1]) + (t2 * s2[5]) + (t3 * s2[9]);
      *(d++) = (t1 * s2[2]) + (t2 * s2[6]) + (t3 * s2[10]);
      *(d++) = (t1 * s2[3]) + (t2 * s2[7]) + (t3 * s2[11]);
    }
    // 3rd row
    {
      // 'cache' source row terms
      rfloat32 t1 = *(s1++);
      rfloat32 t2 = *(s1++);
      rfloat32 t3 = *(s1++);

      *(d++) = (t1 * s2[0]) + (t2 * s2[4]) + (t3 * s2[8]);
      *(d++) = (t1 * s2[1]) + (t2 * s2[5]) + (t3 * s2[9]);
      *(d++) = (t1 * s2[2]) + (t2 * s2[6]) + (t3 * s2[10]);
      *(d++) = (t1 * s2[3]) + (t2 * s2[7]) + (t3 * s2[11]);
    }
    // 4th row
    {
      *(d++) = 0;
      *(d++) = 0;
      *(d++) = 0;
      *(d++) = 1.0f;
    }
  }
  // Switch matrix buffer such that the result becomes the current matrix
  swap();
}

////////////////////////////////////////////////////////////////////////////////

void Transformation::transform(Vector3D* s, size_t n)
{
  rfloat32*  m = matrix;
  while (n--)
  {
    rfloat32  tx = s->x;
    rfloat32  ty = s->y;
    rfloat32  tz = s->z;
    s->x = tx*m[0] + ty*m[1] + tz*m[2] + m[3];
    s->y = tx*m[4] + ty*m[5] + tz*m[6] + m[7];
    s->z = tx*m[8] + ty*m[9] + tz*m[10] + m[11];
    s++;
  }
}

////////////////////////////////////////////////////////////////////////////////

void Transformation::transform(Vector3D* d, const Vector3D* s, size_t n)
{
  rfloat32*  m = matrix;
  while (n--)
  {
    rfloat32  tx = s->x;
    rfloat32  ty = s->y;
    rfloat32  tz = s->z;
    d->x = tx*m[0] + ty*m[1] + tz*m[2] + m[3];
    d->y = tx*m[4] + ty*m[5] + tz*m[6] + m[7];
    d->z = tx*m[8] + ty*m[9] + tz*m[10] + m[11];
    s++;
    d++;
  }
}

////////////////////////////////////////////////////////////////////////////////

void Transformation::transform(Vertex* s, size_t n)
{
  rfloat32*  m = matrix;
  while (n--)
  {
    rfloat32  tx = s->x;
    rfloat32  ty = s->y;
    rfloat32  tz = s->z;
    s->x = tx*m[0] + ty*m[1] + tz*m[2] + m[3];
    s->y = tx*m[4] + ty*m[5] + tz*m[6] + m[7];
    s->z = tx*m[8] + ty*m[9] + tz*m[10] + m[11];
    s++;
  }
}

////////////////////////////////////////////////////////////////////////////////

void Transformation::transform(Vertex* d, const Vertex* s, size_t n)
{
  rfloat32*  m = matrix;
  while (n--)
  {
    rfloat32  tx = s->x;
    rfloat32  ty = s->y;
    rfloat32  tz = s->z;
    d->x = tx*m[0] + ty*m[1] + tz*m[2] + m[3];
    d->y = tx*m[4] + ty*m[5] + tz*m[6] + m[7];
    d->z = tx*m[8] + ty*m[9] + tz*m[10] + m[11];
    s++;
    d++;
  }
}

////////////////////////////////////////////////////////////////////////////////

void Transformation::transformTex(Vertex* s, size_t n)
{
  rfloat32*  m = matrix;
  while (n--)
  {
    rfloat32  tu = s->texCrd.u;
    rfloat32  tv = s->texCrd.v;
    rfloat32  tw = s->texCrd.w;
    s->texCrd.u = tu*m[0] + tv*m[1] + tw*m[2] + m[3];
    s->texCrd.v = tu*m[4] + tv*m[5] + tw*m[6] + m[7];
    s->texCrd.w = tu*m[8] + tv*m[9] + tw*m[10] + m[11];
    s++;
  }
}

////////////////////////////////////////////////////////////////////////////////

void Transformation::transformTex(Vertex* d, const Vertex *s, size_t n)
{
  rfloat32*  m = matrix;
  while (n--)
  {
    rfloat32  tu = s->texCrd.u;
    rfloat32  tv = s->texCrd.v;
    rfloat32  tw = s->texCrd.w;
    d->texCrd.u = tu*m[0] + tv*m[1] + tw*m[2] + m[3];
    d->texCrd.v = tu*m[4] + tv*m[5] + tw*m[6] + m[7];
    d->texCrd.w = tu*m[8] + tv*m[9] + tw*m[10] + m[11];
    s++;
    d++;
  }
}

////////////////////////////////////////////////////////////////////////////////

Transformation& Transformation::operator*=(const Transformation& t)
{
  // a*A + b*E + c*I,    a*B + b*F + c*J,    a*C + b*G + c*K,    d + a*D + b*H + c*L
  //
  // e*A + f*E + g*I,    e*B + f*F + g*J,    e*C + f*G + g*K,    h + e*D + f*H + g*L
  //
  // i*A + j*E + k*I,    i*B + j*F + k*J,    i*C + j*G + k*K,    l + i*D + j*H + k*L
  //
  // 0                  0                   0                   1

  rfloat32* d  = matrix;
  rfloat32* s1 = d;
  rfloat32* s2 = t.matrix;

  // 1st row
  {
      // 'cache' source row terms, except last which is used once
      rfloat32 t1 = *(s1++);
      rfloat32 t2 = *(s1++);
      rfloat32 t3 = *(s1++);
      s1++;

      *(d++) = (t1 * s2[0]) + (t2 * s2[4]) + (t3 * s2[8]);
      *(d++) = (t1 * s2[1]) + (t2 * s2[5]) + (t3 * s2[9]);
      *(d++) = (t1 * s2[2]) + (t2 * s2[6]) + (t3 * s2[10]);
      *(d++) += (t1 * s2[3]) + (t2 * s2[7]) + (t3 * s2[11]);
  }
  // 2nd row
  {
      // 'cache' source row terms
      rfloat32 t1 = *(s1++);
      rfloat32 t2 = *(s1++);
      rfloat32 t3 = *(s1++);
      s1++;

      *(d++) = (t1 * s2[0]) + (t2 * s2[4]) + (t3 * s2[8]);
      *(d++) = (t1 * s2[1]) + (t2 * s2[5]) + (t3 * s2[9]);
      *(d++) = (t1 * s2[2]) + (t2 * s2[6]) + (t3 * s2[10]);
      *(d++) += (t1 * s2[3]) + (t2 * s2[7]) + (t3 * s2[11]);
  }
  // 3rd row
  {
      // 'cache' source row terms
      rfloat32 t1 = *(s1++);
      rfloat32 t2 = *(s1++);
      rfloat32 t3 = *(s1++);

      *(d++) = (t1 * s2[0]) + (t2 * s2[4]) + (t3 * s2[8]);
      *(d++) = (t1 * s2[1]) + (t2 * s2[5]) + (t3 * s2[9]);
      *(d++) = (t1 * s2[2]) + (t2 * s2[6]) + (t3 * s2[10]);
      *(d++) += (t1 * s2[3]) + (t2 * s2[7]) + (t3 * s2[11]);
  }
  return *this;
}

////////////////////////////////////////////////////////////////////////////////

Transformation operator*(const Transformation& a, const Transformation& b)
{
  Transformation r(0);

  rfloat32* d  = r.matrix;
  rfloat32* s1 = a.matrix;
  rfloat32* s2 = b.matrix;

  // 1st row
  {
      // 'cache' source row terms, except last which is used once
      rfloat32 t1 = *(s1++);
      rfloat32 t2 = *(s1++);
      rfloat32 t3 = *(s1++);
      s1++;

      *(d++) = (t1 * s2[0]) + (t2 * s2[4]) + (t3 * s2[8]);
      *(d++) = (t1 * s2[1]) + (t2 * s2[5]) + (t3 * s2[9]);
      *(d++) = (t1 * s2[2]) + (t2 * s2[6]) + (t3 * s2[10]);
      *(d++) += (t1 * s2[3]) + (t2 * s2[7]) + (t3 * s2[11]);
  }
  // 2nd row
  {
      // 'cache' source row terms
      rfloat32 t1 = *(s1++);
      rfloat32 t2 = *(s1++);
      rfloat32 t3 = *(s1++);
      s1++;

      *(d++) = (t1 * s2[0]) + (t2 * s2[4]) + (t3 * s2[8]);
      *(d++) = (t1 * s2[1]) + (t2 * s2[5]) + (t3 * s2[9]);
      *(d++) = (t1 * s2[2]) + (t2 * s2[6]) + (t3 * s2[10]);
      *(d++) += (t1 * s2[3]) + (t2 * s2[7]) + (t3 * s2[11]);
  }
  // 3rd row
  {
      // 'cache' source row terms
      rfloat32 t1 = *(s1++);
      rfloat32 t2 = *(s1++);
      rfloat32 t3 = *(s1++);

      *(d++) = (t1 * s2[0]) + (t2 * s2[4]) + (t3 * s2[8]);
      *(d++) = (t1 * s2[1]) + (t2 * s2[5]) + (t3 * s2[9]);
      *(d++) = (t1 * s2[2]) + (t2 * s2[6]) + (t3 * s2[10]);
      *(d++) += (t1 * s2[3]) + (t2 * s2[7]) + (t3 * s2[11]);
  }
  return r;
}

////////////////////////////////////////////////////////////////////////////////

void Transformation::debugPrint()
{
  printf("\nTransformation\n"
        "| %8.4f %8.4f %8.4f %8.4f |\n"
        "| %8.4f %8.4f %8.4f %8.4f |\n"
        "| %8.4f %8.4f %8.4f %8.4f |\n"
        "| %8.4f %8.4f %8.4f %8.4f |\n",
        matrix[0], matrix[1], matrix[2], matrix[3],
        matrix[4], matrix[5], matrix[6], matrix[7],
        matrix[8], matrix[9], matrix[10], matrix[11],
        matrix[12], matrix[13], matrix[14], matrix[15]
  );
}

