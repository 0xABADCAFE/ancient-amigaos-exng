//****************************************************************************//
//**                                                                        **//
//** File:         proj/jasmine/jasmineLUT.cpp                              **//
//** Description:                                                           **//
//** Comment(s):   Internal developer version only                          **//
//** Library:                                                               **//
//** Created:      2003-02-10                                               **//
//** Updated:      2003-02-10                                               **//
//** Author(s):    Karl Churchill                                           **//
//** Note(s):                                                               **//
//** Copyright:    (C)1996-2003, eXtropia Studios                           **//
//**               Serkan YAZICI, Karl Churchill                            **//
//**               All Rights Reserved.                                     **//
//**                                                                        **//
//****************************************************************************//

#include "JasmineObject.hpp"

const char*    JasmineObject::xsfIDString    = "Extropia Studios Virtual Machine";
const char*    JasmineObject::xsfFileSig      = "VMCODE";
const uint16  JasmineObject::xsfSuperClass  = 0x0000;
const uint16  JasmineObject::xsfSubClass    = 0x0000;
const uint8    JasmineObject::xsfDataFormat  = (XA_ALIGN32|X_ENDIAN|X_NEGATIVE);
const uint8    JasmineObject::xsfFileFormat  = 0;
const uint8    JasmineObject::xsfJasmineVer  = 1;
const uint8    JasmineObject::xsfJasmineRev  = 0;

/////////////////////////////////////////////////////////////////////////////////////

JasmineObject::JasmineObject() :
XSFStorable(xsfIDString, xsfSuperClass, xsfSubClass, xsfJasmineVer, xsfJasmineRev)
{
  init();
}

/////////////////////////////////////////////////////////////////////////////////////

JasmineObject::~JasmineObject()
{
  if (codeSpace)
    Mem::free(codeSpace);
  if (dataSpace)
    Mem::free(dataSpace);
}

/////////////////////////////////////////////////////////////////////////////////////

void JasmineObject::init()
{
  Mem::zero(&shared32, sizeof(shared32));
  Mem::zero(&shared16, sizeof(shared16));
  Mem::zero(&shared8, sizeof(shared8));
  codeSpace      = 0;
  dataSpace      = 0;
  funcResolved  = 0;
  funcTab        = 0;
  code          = 0;
  data64        = 0;
  data32        = 0;
  data16        = 0;
  data8          = 0;
  const64        = 0;
  const32        = 0;
  const16        = 0;
  const8        = 0;
  setRawSize(sizeof(shared32)+sizeof(shared16)+sizeof(shared8));
}

/////////////////////////////////////////////////////////////////////////////////////

void  JasmineObject::destroy()
{
  if (codeSpace)
    Mem::free(codeSpace);
  if (dataSpace)
    Mem::free(dataSpace);
  init();
}

/////////////////////////////////////////////////////////////////////////////////////

sint32 JasmineObject::readyForRead()
{
  return OK;
}

/////////////////////////////////////////////////////////////////////////////////////

sint32 JasmineObject::readyForWrite()
{
  if (!codeSpace && !dataSpace)
    return IOS::ERR_FILE_WRITE;
  return OK;
}

/////////////////////////////////////////////////////////////////////////////////////

sint32 JasmineObject::readBody(XSFStreamIn* f)
{
  destroy();
  // read the shared header info
  readElement32(f, &shared32, sizeof(shared32)/sizeof(uint32));
  readElement16(f, &shared16, sizeof(shared16)/sizeof(uint16));
  readElement8(f, &shared8,   sizeof(shared8));

  sint32 result = create();
  if (result != OK)
    return result;

  // read the function table
  if (funcTab && getFuncTabSize())
    readElement32(f, funcTab, getFuncTabSize()*(sizeof(JFInfo)/sizeof(uint32)));

  // read the code
  if (code && getCodeSize())
    readElement32(f, code, getCodeSize());

  // read the 64-bit data
  if (data64 && getData64Size())
    readElement64(f, data64, getData64Size());
  if (const64 && getConst64Size())
    readElement64(f, const64, getConst64Size());

  // read the 32-bit data
  if (data32 && getData32Size())
    readElement32(f, data32, getData32Size());
  if (const32 && getConst32Size())
    readElement32(f, const32, getConst32Size());

  // read the 16-bit data
  if (data16 && getData16Size())
    readElement16(f, data16, getData16Size());
  if (const16 && getConst16Size())
    readElement16(f, const16, getConst16Size());

  // read the 8-bit data
  if (data8 && getData8Size())
    readElement8(f, data8, getData8Size());
  if (const8 && getConst8Size())
    readElement8(f, const8, getConst8Size());

  // once loaded, we must resolve the runtime layout of the object
  // based on it's various tables.
  resolve();
  return getRawSize();
}

/////////////////////////////////////////////////////////////////////////////////////

sint32 JasmineObject::writeBody(XSFStreamOut* f)
{
  // write the shared header info
  writeElement32(f, &shared32,  sizeof(shared32)/sizeof(uint32));
  writeElement16(f, &shared16,  sizeof(shared16)/sizeof(uint16));
  writeElement8(f, &shared8,    sizeof(shared8));

  // write the function table
  if (funcTab)
    writeElement32(f, funcTab, getFuncTabSize()*(sizeof(JFInfo)/sizeof(uint32)));

  // write the code
  if (code)
    writeElement32(f, code, getCodeSize());

  // write the 64-bit data
  if (data64 && getData64Size())
    writeElement64(f, data64, getData64Size());
  if (const64 && getConst64Size())
    writeElement64(f, const64, getConst64Size());

  // write the 32-bit data
  if (data32 && getData32Size())
    writeElement32(f, data32, getData32Size());
  if (const32 && getConst32Size())
    writeElement32(f, const32, getConst32Size());

  // write the 16-bit data
  if (data16 && getData16Size())
    writeElement16(f, data16, getData16Size());
  if (const16 && getConst16Size())
    writeElement16(f, const16, getConst16Size());

  // write the 8-bit data
  if (data8 && getData8Size())
    writeElement8(f, data8, getData8Size());
  if (const8 && getConst8Size())
    writeElement8(f, const8, getConst8Size());

  return getRawSize();
}

/////////////////////////////////////////////////////////////////////////////////////

sint32 JasmineObject::create()
{
  // This method allocates the space for the objects tables, code and data as defined
  // in the shared header info. It also resolves the various data pointers to their
  // runtime addresses but does no further initialisation beyond this.
  // It does not resolve function pointers etc since these depend upon information
  // unavailable to the create() method.

  size_t codeSize    =  getFuncTabSize()*(sizeof(JFInfo)) +
                      getCodeSize()*sizeof(uint32);
  size_t dataSize    =  getDataLength();
  size_t constSize  = getConstLength();

  printf("JasmineObject::create() dataSize %lu, constSize %lu\n", dataSize, constSize);

  // A jasmine object may have no code, or no data, but must have at least one of
  // them
  if (codeSize+dataSize+constSize == 0)
  {
    return ERR_RSC_INVALID;
  }

  // Allocated code size must include the runtime resolved function addresses
  if (codeSize)
  {
    if (!(codeSpace = (uint8*)Mem::alloc(codeSize + getFuncTabSize()*sizeof(uint32), false, Mem::ALIGN_CACHE)))
    {
      destroy();
      X_ERROR("JasmineObject::create() - unable to allocate code space");
      return ERR_NO_FREE_STORE;
    }
    else
    {
      // Resolve the code pointers. First the function table, then the runtime resolved
      // function addresses, then the code
      funcTab         = (JFInfo*)codeSpace;
      funcResolved    = (uint32**)(&funcTab[getFuncTabSize()]);
      code            = (uint32*)(&funcResolved[getFuncTabSize()]);
    }
  }

  // round up the data/const sizes to cache boundaries
  if ((dataSize+constSize)!=0)
  {
    if (dataSize)
      dataSize = Mem::ALIGN_CACHE*((dataSize/Mem::ALIGN_CACHE) + ((dataSize%Mem::ALIGN_CACHE) ? 1 : 0));
    if (constSize)
      constSize = Mem::ALIGN_CACHE*((constSize/Mem::ALIGN_CACHE) + ((constSize%Mem::ALIGN_CACHE) ? 1 : 0));

    if (!(dataSpace = (uint8*)Mem::alloc(dataSize+constSize, false, Mem::ALIGN_CACHE)))
    {
      destroy();
      X_ERROR("JasmineObject::create() - unable to allocate data space");
      return ERR_NO_FREE_STORE;
    }
    else
    {
      // Resolve data pointers
      data64  = dataSpace;
      data32  = data64 + getData64Length();
      data16  = data32 + getData32Length();
      data8    = data16 + getData16Length();

      // Resolve the constant data pointers
      const64  = dataSpace+dataSize;
      const32  = const64 + getConst64Length();
      const16 = const32 + getConst32Length();
      const8  = const16 + getConst16Length();
      printf("JasmineObject::create() rounded dataSize %lu, constSize %lu\n", dataSize, constSize);
    }
  }
  // Set the created objects xsf rawsize. This only includes the size of data that is
  // XSFStorable and not other runtime data such as the resolved function table
  // size
  setRawSize(sizeof(shared32) + sizeof(shared16) + sizeof(shared8) +  // header
             getFuncTabSize() * sizeof(JFInfo) +                      // func table
             getCodeSize() * sizeof(uint32) +                          // code
             getDataLength() + getConstLength());                      // data
  return OK;
}

/////////////////////////////////////////////////////////////////////////////////////

void JasmineObject::resolve()
{
  // This method resolves function pointers etc. for a valid object after the tables
  // it contains have been loaded or in some other way set.
  if (funcTab && funcResolved)
  {
    for (sint32 i=0; i<getFuncTabSize(); i++)
      funcResolved[i] = &code[(funcTab[i].offset)];
  }
}

/////////////////////////////////////////////////////////////////////////////////////

size_t JasmineObject::getDataLength() const
{
  return (getData64Length() +
          getData32Length() +
          getData16Length() +
          getData8Length());
}

/////////////////////////////////////////////////////////////////////////////////////

size_t JasmineObject::getConstLength() const
{
  return (getConst64Length() +
          getConst32Length() +
          getConst16Length() +
          getConst8Length());
}

/////////////////////////////////////////////////////////////////////////////////////

const JFInfo*  JasmineObject::getMethod(uint32 index) const
{
  if (!funcTab || index > getFuncTabSize())
    return 0;
  return (const JFInfo*)(&funcTab[index]);
}

/////////////////////////////////////////////////////////////////////////////////////

void JasmineObject::listMethods() const
{
  if (getFuncTabSize() && funcTab)
  {
    puts("+-------------------------------------+");
    printf("| %-35s |\n", shared8.progName);
    puts("+-------------------------------------+");
    puts("| Func   Offset Name key   Sign. key  |");
    for (sint32 i=0; i<getFuncTabSize(); i++)
    {
      printf("| %4d %8d 0x%08X 0x%08X |\n", i, funcTab[i].offset,
            (uint32)funcTab[i].nameKey, (uint32)funcTab[i].signKey);
    }
    puts("+-------------------------------------+");
  }
}

/////////////////////////////////////////////////////////////////////////////////////

void JasmineObject::debugDump() const
{
  puts("\nJasmineObject Dump -----------------------------------------------------\n");
  printf(
    "Name          : %s\n"
    "Version       : %hd\n"
    "Revision      : %hd\n"
    "Registered Fn : %ld\n"
    "Code Size     : %8lu words [%8lu bytes], located at 0x%08X\n"
    "Data Size  64 : %8lu units [%8lu bytes], located at 0x%08X\n"
    "Data Size  32 : %8lu units [%8lu bytes], located at 0x%08X\n"
    "Data Size  16 : %8lu units [%8lu bytes], located at 0x%08X\n"
    "Data Size   8 : %8lu units [%8lu bytes], located at 0x%08X\n"
    "Const Size 64 : %8lu units [%8lu bytes], located at 0x%08X\n"
    "Const Size 32 : %8lu units [%8lu bytes], located at 0x%08X\n"
    "Const Size 16 : %8lu units [%8lu bytes], located at 0x%08X\n"
    "Const Size  8 : %8lu units [%8lu bytes], located at 0x%08X\n",
    getName(), getVersion(), getRevision(), getFuncTabSize(),
    getCodeSize(),    getCodeLength(),    (uint32)getCode(),
    getData64Size(),  getData64Length(),  (uint32)getData64(),
    getData32Size(),  getData32Length(),  (uint32)getData32(),
    getData16Size(),  getData16Length(),  (uint32)getData16(),
    getData8Size(),    getData8Length(),    (uint32)getData8(),
    getConst64Size(),  getConst64Length(),  (uint32)getConst64(),
    getConst32Size(),  getConst32Length(),  (uint32)getConst32(),
    getConst16Size(),  getConst16Length(),  (uint32)getConst16(),
    getConst8Size(),  getConst8Length(),  (uint32)getConst8()
  );
  for (sint32 i=0; i<getFuncTabSize(); i++)
  {
    const size_t size = getMethod(i)->getSize();
    const size_t offs = getMethod(i)->getOffset();
    printf(
      "Function %4ld : %8lu words [offset %7lu], located at 0x%08X\n",
      i, size, offs,
      ((uint32**)getFuncs())[i]
    );
  }
  puts("\n------------------------------------------------------------------------\n");
}

/////////////////////////////////////////////////////////////////////////////////////

sint32 JasmineObjectProvider::jasmineDestroyRep(JasmineObject* obj)
{
  if (!obj) return ERR_PTR_ZERO;
  obj->destroy();
  return OK;
}

/////////////////////////////////////////////////////////////////////////////////////

sint32 JasmineObjectProvider::jasmineCreateNewRep(JasmineObject* obj,
                               size_t numFuncs, size_t codeSize,
                               size_t d64, size_t d32, size_t d16, size_t d8,
                               size_t c64, size_t c32, size_t c16, size_t c8)
{
  if (!obj) return ERR_PTR_ZERO;
  obj->destroy();
  obj->shared32.funcTabLen    = numFuncs;
  obj->shared32.codeLen        = (codeSize&1) ? codeSize+1 : codeSize;  // always allocate even nbr
  obj->shared32.data64Len      = d64*sizeof(uint64);
  obj->shared32.data32Len      = d32*sizeof(uint32);
  obj->shared32.data16Len      = d16*sizeof(uint16);
  obj->shared32.data8Len      = d8 + (d8 ? 4 - (d8&3) : 0);
  obj->shared32.const64Len    = c64*sizeof(uint64);
  obj->shared32.const32Len    = c32*sizeof(uint32);
  obj->shared32.const16Len    = c16*sizeof(uint16);
  obj->shared32.const8Len      = c8 + (c8 ? 4 - (c8&3) : 0);
  return obj->create();
}

/////////////////////////////////////////////////////////////////////////////////////

sint32 JasmineObjectProvider::jasmineInstallFunc(JasmineObject* obj, JFInfo* func, size_t pos)
{
  if (!obj || !func || !obj->funcTab) return ERR_PTR_ZERO;
  if (pos>=obj->getFuncTabSize())
    return ERR_VALUE_MAX;

  if (func->getOffset() > obj->getCodeSize())
    return ERR_PTR_RANGE;

  obj->funcTab[pos] = *func;
  return OK;
}

/////////////////////////////////////////////////////////////////////////////////////

sint32 JasmineObjectProvider::jasmineInstallCode(JasmineObject* obj, uint32* code, size_t size, size_t ofs)
{
  if (!obj || !code || !obj->code) return ERR_PTR_ZERO;
  uint32* dest = (uint32*)(obj->getCode()+ofs);
  Mem::copy(dest, code, size*sizeof(uint32));
  return OK;
}

/////////////////////////////////////////////////////////////////////////////////////

sint32 JasmineObjectProvider::jasmineInstallData8(JasmineObject* obj, void* data, size_t size, size_t ofs)
{
  if (!obj || !data || !obj->getData8()) return ERR_PTR_ZERO;
  if (size+ofs > obj->getData8Size())
    return ERR_PTR_RANGE;
  uint8* dest = ((uint8*)(obj->getData8()))+ofs;
  Mem::copy(dest, data, size);
  return OK;
}

/////////////////////////////////////////////////////////////////////////////////////

sint32 JasmineObjectProvider::jasmineInstallData16(JasmineObject* obj, void* data, size_t size, size_t ofs)
{
  if (!obj || !data || !obj->getData16()) return ERR_PTR_ZERO;
  if (size+ofs > obj->getData16Size())
    return ERR_PTR_RANGE;
  uint16* dest = ((uint16*)(obj->getData16()))+ofs;
  Mem::copy(dest, data, size*sizeof(uint16));
  return OK;
}

/////////////////////////////////////////////////////////////////////////////////////

sint32 JasmineObjectProvider::jasmineInstallData32(JasmineObject* obj, void* data, size_t size, size_t ofs)
{
  if (!obj || !data || !obj->getData32()) return ERR_PTR_ZERO;
  if (size+ofs > obj->getData32Size())
    return ERR_PTR_RANGE;
  uint32* dest = ((uint32*)(obj->getData32()))+ofs;
  Mem::copy(dest, data, size*sizeof(uint32));
  return OK;
}

/////////////////////////////////////////////////////////////////////////////////////

sint32 JasmineObjectProvider::jasmineInstallData64(JasmineObject* obj, void* data, size_t size, size_t ofs)
{
  if (!obj || !data || !obj->getData64()) return ERR_PTR_ZERO;
  if (size+ofs > obj->getData64Size())
    return ERR_PTR_RANGE;
  uint64* dest = ((uint64*)(obj->getData64()))+ofs;
  Mem::copy(dest, data, size*sizeof(uint64));
  return OK;
}

/////////////////////////////////////////////////////////////////////////////////////

sint32 JasmineObjectProvider::jasmineInstallConst8(JasmineObject* obj, void* data, size_t size, size_t ofs)
{
  if (!obj || !data || !obj->getConst8()) return ERR_PTR_ZERO;
  if (size+ofs > obj->getConst8Size())
    return ERR_PTR_RANGE;
  uint8* dest = ((uint8*)(obj->getConst8()))+ofs;
  Mem::copy(dest, data, size);
  return OK;
}

/////////////////////////////////////////////////////////////////////////////////////

sint32 JasmineObjectProvider::jasmineInstallConst16(JasmineObject* obj, void* data, size_t size, size_t ofs)
{
  if (!obj || !data || !obj->getConst16()) return ERR_PTR_ZERO;
  if (size+ofs > obj->getConst16Size())
    return ERR_PTR_RANGE;
  uint16* dest = ((uint16*)(obj->getConst16()))+ofs;
  Mem::copy(dest, data, size*sizeof(uint16));
  return OK;
}

/////////////////////////////////////////////////////////////////////////////////////

sint32 JasmineObjectProvider::jasmineInstallConst32(JasmineObject* obj, void* data, size_t size, size_t ofs)
{
  if (!obj || !data || !obj->getConst32()) return ERR_PTR_ZERO;
  if (size+ofs > obj->getConst32Size())
    return ERR_PTR_RANGE;
  uint32* dest = ((uint32*)(obj->getConst32()))+ofs;
  Mem::copy(dest, data, size*sizeof(uint32));
  return OK;
}

/////////////////////////////////////////////////////////////////////////////////////

sint32 JasmineObjectProvider::jasmineInstallConst64(JasmineObject* obj, void* data, size_t size, size_t ofs)
{
  if (!obj || !data || !obj->getConst64()) return ERR_PTR_ZERO;
  if (size+ofs > obj->getConst64Size())
    return ERR_PTR_RANGE;
  uint64* dest = ((uint64*)(obj->getConst64()))+ofs;
  Mem::copy(dest, data, size*sizeof(uint64));
  return OK;
}

/////////////////////////////////////////////////////////////////////////////////////

/*
JasmineObject* JasmineFactory::create(char* n, sint16 v, sint16 r, size_t F, size_t I, size_t S, size_t MS, size_t RS, \
  size_t D64, size_t D32, size_t D16, size_t D8, size_t C64, size_t C32, size_t C16, size_t C8)
{
  JasmineObject* j = new JasmineObject;
  if (!j)
    return 0;
  j->shared32.funcTabLen    = F;
  j->shared32.codeLen        = (I&1) ? I+1 : I;  // always allocate even nbr
  j->shared32.data64Len      = D64*sizeof(uint64);
  j->shared32.data32Len      = D32*sizeof(uint32);
  j->shared32.data16Len      = D16*sizeof(uint16);
  j->shared32.data8Len      = D8 + (D8 ? 4 - (D8&3) : 0);
  j->shared32.const64Len    = D64*sizeof(uint64);
  j->shared32.const32Len    = D32*sizeof(uint32);
  j->shared32.const16Len    = D16*sizeof(uint16);
  j->shared32.const8Len      = C8 + (C8 ? 4 - (C8&3) : 0);
  if (j->create()==OK)
  {
    j->shared32.stackSize      = S  + (S ? 4 - (S&3) : 0);
    j->shared32.methodSize    = MS;
    j->shared32.regSize        = RS;
    j->shared16.progVersion    = v;
    j->shared16.progRevision  = r;
    strncpy(j->shared8.progName, n, 31);
    j->shared8.progName[31] = 0;
    return j;
  }
  delete j;
    return 0;
}
*/
/////////////////////////////////////////////////////////////////////////////////////
