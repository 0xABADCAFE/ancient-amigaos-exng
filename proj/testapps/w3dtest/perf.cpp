//****************************************************************************//
//**                                                                        **//
//** File:         proj/W3DTest/perf.cpp                                    **//
//** Description:  Warp3D test application                                  **//
//** Comment(s):   This software calls Warp3D directly and is hence not     **//
//**               portable.                                                **//
//** Created:      2004-01-31                                               **//
//** Updated:      2004-02-01                                               **//
//** Author(s):    Karl Churchill                                           **//
//** Note(s):                                                               **//
//** Copyright:    (C)1996-2004, eXtropia Studios                           **//
//**               Serkan YAZICI, Karl Churchill                            **//
//**                                                                        **//
//**               Warp3D (C) Hyperion Entertainment                        **//
//**                                                                        **//
//**               All Rights Reserved.                                     **//
//**                                                                        **//
//****************************************************************************//

#include "testw3d.hpp"

////////////////////////////////////////////////////////////////////////////////

void TestWarp3D::testPerformance()
{
  if (!SystemLib::dialogueBox(dBoxInfo, dBoxRunSkip,
    "Performance Tests\n\n"
    "The following tests will measure various aspects of\n"
    "your hardware and driver performance."
  ))
  {
    logFile->writeText("No Performance tests performed\n");
    return;
  }
  logFile->writeText("\nPerformance tests:\n\n");
  measureVRAMAccess();
  measureZBufAccess();
  measureTextureUpload();
  measureTrisV3();
  measureTriStripV3();
  measurePointsLinear();
  measureLinesLinear();
  measureLineStripLinear();
  measureTrisLinear();
  measureTriStripLinear();
}
