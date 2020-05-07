//****************************************************************************//
//**                                                                        **//
//** File:         libsrc/plat/amigaos3_68k/gfxlib/native3d.cpp             **//
//** Description:  3D rasterizer definitions                                **//
//** Comment(s):                                                            **//
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

#include <gfxlib/gfx3d.hpp>

using namespace X_SYSNAME;

////////////////////////////////////////////////////////////////////////////////
//
//  _Nat3D
//
//  Maps the G3D constants into the values used by the native implementation
//
////////////////////////////////////////////////////////////////////////////////

uint32 _Nat3D::state[G3D::NUM_STATES] = {
  W3D_TEXMAPPING,
  W3D_AUTOTEXMANAGEMENT,
  W3D_GLOBALTEXENV,
  W3D_PERSPECTIVE,
  W3D_GOURAUD,
  W3D_SPECULAR,
  W3D_SCISSOR,
  W3D_AUTOCLIP,
  W3D_ZBUFFER,
  W3D_ZBUFFERUPDATE,
  W3D_STENCILBUFFER,
  W3D_FOGGING,
  W3D_BLENDING,
  W3D_ALPHATEST,
  W3D_DITHERING,
  W3D_CHROMATEST,
  W3D_LOGICOP,
  W3D_CULLFACE,
  W3D_ANTI_POINT,
  W3D_ANTI_LINE,
  W3D_ANTI_POLYGON,
  W3D_ANTI_FULLSCREEN
};

////////////////////////////////////////////////////////////////////////////////

uint8 _Nat3D::query[G3D::NUM_QUERY] = {

  W3D_Q_DRAW_POINT,
  W3D_Q_DRAW_POINT_X,
  W3D_Q_DRAW_POINT_TEX,
  W3D_Q_DRAW_POINT_FX,
  W3D_Q_ANTI_POINT,

  W3D_Q_DRAW_LINE,
  W3D_Q_DRAW_LINE_X,
  W3D_Q_DRAW_LINE_TEX,
  W3D_Q_DRAW_LINE_FX,
  W3D_Q_DRAW_LINE_ST,
  W3D_Q_ANTI_LINE,

  W3D_Q_DRAW_TRIANGLE,
  W3D_Q_TEXMAPPING,
  W3D_Q_DRAW_POLY_ST,
  W3D_Q_ANTI_POLYGON,

  W3D_Q_CULLFACE,
  W3D_Q_DITHERING,
  W3D_Q_MASKING,
  W3D_Q_SCISSOR,
  W3D_Q_ANTI_FULLSCREEN,
  W3D_Q_LOGICOP,

  W3D_Q_FLATSHADING,
  W3D_Q_GOURAUDSHADING,
  W3D_Q_SPECULAR,

  W3D_Q_BLENDING,
  W3D_Q_SRCFACTORS,
  W3D_Q_DESTFACTORS,

  W3D_Q_ZBUFFER,
  W3D_Q_ZBUFFERUPDATE,
  W3D_Q_ZCOMPAREMODES,

  W3D_Q_ALPHATEST,
  W3D_Q_ALPHATESTMODES,

  W3D_Q_STENCILBUFFER,
  W3D_Q_STENCIL_MASK,
  W3D_Q_STENCIL_FUNC,
  W3D_Q_STENCIL_SFAIL,
  W3D_Q_STENCIL_DPFAIL,
  W3D_Q_STENCIL_DPPASS,
  W3D_Q_STENCIL_WRMASK,

  W3D_Q_FOGGING,
  W3D_Q_LINEAR,
  W3D_Q_EXPONENTIAL,
  W3D_Q_S_EXPONENTIAL,
  W3D_Q_INTERPOLATED,

  W3D_Q_RECTTEXTURES,
  W3D_Q_BILINEARFILTER,
  W3D_Q_MIPMAPPING,
  W3D_Q_MMFILTER,
  W3D_Q_TEXMAPPING,
  W3D_Q_LINEAR_CLAMP,
  W3D_Q_LINEAR_REPEAT,
  W3D_Q_PERSPECTIVE,
  W3D_Q_PERSP_CLAMP,
  W3D_Q_PERSP_REPEAT,
  W3D_Q_WRAP_ASYM,
  W3D_Q_ENV_REPLACE,
  W3D_Q_ENV_DECAL,
  W3D_Q_ENV_MODULATE,
  W3D_Q_ENV_BLEND,
  W3D_Q_CHROMATEST
};

////////////////////////////////////////////////////////////////////////////////

uint8 _Nat3D::alphaTest[G3D::NUM_TEST] = {
  W3D_A_LESS,
  W3D_A_LEQUAL,
  W3D_A_EQUAL,
  W3D_A_GEQUAL,
  W3D_A_GREATER,
  W3D_A_NOTEQUAL,
  W3D_A_NEVER,
  W3D_A_ALWAYS
};

////////////////////////////////////////////////////////////////////////////////

uint8 _Nat3D::zBuffTest[G3D::NUM_TEST] = {
  W3D_Z_LESS,
  W3D_Z_LEQUAL,
  W3D_Z_EQUAL,
  W3D_Z_GEQUAL,
  W3D_Z_GREATER,
  W3D_Z_NOTEQUAL,
  W3D_Z_NEVER,
  W3D_Z_ALWAYS
};

////////////////////////////////////////////////////////////////////////////////

uint8 _Nat3D::stencilTest[G3D::NUM_TEST] = {
  W3D_ST_LESS,
  W3D_ST_LEQUAL,
  W3D_ST_EQUAL,
  W3D_ST_GEQUAL,
  W3D_ST_GREATER,
  W3D_ST_NOTEQUAL,
  W3D_ST_NEVER,
  W3D_ST_ALWAYS
};

////////////////////////////////////////////////////////////////////////////////

uint8 _Nat3D::stencilUpdate[G3D::NUM_STENCIL] = {
  W3D_ST_KEEP,
  W3D_ST_ZERO,
  W3D_ST_REPLACE,
  W3D_ST_INCR,
  W3D_ST_DECR,
  W3D_ST_INVERT
};
////////////////////////////////////////////////////////////////////////////////

uint8 _Nat3D::logicOp[G3D::NUM_LOGIC] = {
  W3D_LO_CLEAR,
  W3D_LO_AND,
  W3D_LO_AND_REVERSE,
  W3D_LO_COPY,
  W3D_LO_AND_INVERTED,
  W3D_LO_NOOP,
  W3D_LO_XOR,
  W3D_LO_OR,
  W3D_LO_NOR,
  W3D_LO_EQUIV,
  W3D_LO_INVERT,
  W3D_LO_OR_REVERSE,
  W3D_LO_COPY_INVERTED,
  W3D_LO_OR_INVERTED,
  W3D_LO_NAND,
  W3D_LO_SET
};

////////////////////////////////////////////////////////////////////////////////

uint8 _Nat3D::fogMode[G3D::NUM_FOG] = {
  W3D_FOG_LINEAR,
  W3D_FOG_EXP,
  W3D_FOG_EXP_2,
  W3D_FOG_INTERPOLATED
};

////////////////////////////////////////////////////////////////////////////////

uint8 _Nat3D::blendMode[G3D::NUM_BLEND] = {
  W3D_ZERO,
  W3D_ONE,
  W3D_SRC_COLOR,
  W3D_DST_COLOR,
  W3D_ONE_MINUS_SRC_COLOR,
  W3D_ONE_MINUS_DST_COLOR,
  W3D_SRC_ALPHA,
  W3D_ONE_MINUS_SRC_ALPHA,
  W3D_DST_ALPHA,
  W3D_ONE_MINUS_DST_ALPHA,
  W3D_SRC_ALPHA_SATURATE,
  W3D_CONSTANT_COLOR,
  W3D_ONE_MINUS_CONSTANT_COLOR,
  W3D_CONSTANT_ALPHA,
  W3D_ONE_MINUS_CONSTANT_ALPHA
};

////////////////////////////////////////////////////////////////////////////////

uint8 _Nat3D::frontFace[G3D::NUM_FACE] = {
  W3D_CW,
  W3D_CCW
};

////////////////////////////////////////////////////////////////////////////////

uint8 _Nat3D::texel[G3D::NUM_TEXEL] = {
  W3D_CHUNKY,
  W3D_L8,
  W3D_I8,
  W3D_A8,
  W3D_R5G6B5,
  W3D_A1R5G5B5,
  W3D_A4R4G4B4,
  W3D_L8A8,
  W3D_R8G8B8,
  W3D_A8R8G8B8,
  W3D_R8G8B8A8
};

////////////////////////////////////////////////////////////////////////////////

uint8 _Nat3D::texEnv[G3D::NUM_TEXENV] = {
  W3D_REPLACE,
  W3D_DECAL,
  W3D_MODULATE,
  W3D_BLEND
};

////////////////////////////////////////////////////////////////////////////////

uint8 _Nat3D::texFill[G3D::NUM_TEXFILL] = {
  W3D_CLAMP,
  W3D_REPEAT
};

////////////////////////////////////////////////////////////////////////////////

uint8 _Nat3D::texFilter[G3D::NUM_TEXFILTER] = {
  W3D_LINEAR,
  W3D_NEAREST,
  W3D_NEAREST_MIP_NEAREST,
  W3D_LINEAR_MIP_NEAREST,
  W3D_NEAREST_MIP_LINEAR,
  W3D_LINEAR_MIP_LINEAR
};

