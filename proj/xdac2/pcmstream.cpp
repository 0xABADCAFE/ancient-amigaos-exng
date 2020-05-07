//****************************************************************************//
//**                                                                        **//
//** File:         proj/xdac2/compander.hpp                                 **//
//** Description:  Compander classes                                        **//
//** Comment(s):                                                            **//
//** Created:      2005-05-12                                               **//
//** Updated:      2005-05-12                                               **//
//** Author(s):    Karl Churchill                                           **//
//** Note(s):                                                               **//
//** Copyright:    (C)1996- , eXtropia Studios                              **//
//**               Serkan YAZICI, Karl Churchill                            **//
//**               All Rights Reserved.                                     **//
//**                                                                        **//
//****************************************************************************//

#include "pcmstream.hpp"

class InputPCMFactory;

#define MAX_FACTORIES 16

InputPCMFactory*  InputPCMStream::factories[MAX_FACTORIES] = { 0 };
sint32            InputPCMStream::numFacs = 0;

void InputPCMStream::addFactory(InputPCMFactory* fac)
{
  if (numFacs<MAX_FACTORIES)
    factories[numFacs++] = fac;
}

sint32 InputPCMStream::getNumFactories()
{
  return numFacs;
}

void InputPCMFactory::add()
{
  InputPCMStream::addFactory(this);
}

InputPCMFactory* InputPCMStream::getFactory(sint32 i)
{
  if (i<0 || i>numFacs)
    return 0;
  return factories[i];
}
