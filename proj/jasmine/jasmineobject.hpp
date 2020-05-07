//****************************************************************************//
//**                                                                        **//
//** File:         proj/jasmine/jasmineobject.hpp                           **//
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

#ifndef _JASMINE_OBJECT_HPP
#define _JASMINE_OBJECT_HPP

#include <iolib/xsfio.hpp>
#include <utilitylib/keys.hpp>

/////////////////////////////////////////////////////////////////////////////////////
//
//  JDInfo
//
//  Encapsulates a data item in a JasmineObject.
//
/////////////////////////////////////////////////////////////////////////////////////

class JDInfo {
  friend class JasmineObject;
  private:
    uint32  offset;
    Key32    nameKey;

  public:
    void define(const char* name, uint32 ofs)
    {
      offset = ofs;
      nameKey = name;
    }

    uint32  getOffset()     { return offset; }
    Key32    getNameKey()    { return nameKey; }

  public:
    JDInfo() : offset(0) {}
    JDInfo(const char* name, uint32 ofs)
    {
      define(name, ofs);
    }
    ~JDInfo() {}
};

/////////////////////////////////////////////////////////////////////////////////////
//
//  JFInfo
//
//  Encapsulates a function definition within a JasmineObject. The code offset of
//  the function from the code base of the JasmineObject is stored along with
//  information about the functions access.
//  Unique identifications generated from the original functions name and signature
//  are stored to allow runtime link resolution.
//
/////////////////////////////////////////////////////////////////////////////////////

class JFInfo {
  friend class JasmineObject;
  private:
    size_t    offset;            // offset from the code base pointer
    size_t    size;              // in instruction words
    Key32      nameKey;          // key generated from the original function name
    Key32      signKey;          // key generated from the original function signature

  public:
    void define(const char* name, const char* sig, size_t sz, size_t off)
    {
      offset  = off;
      size    = sz;
      nameKey = name;
      signKey = sig;
    }

    size_t  getOffset()       const { return offset; }
    size_t  getSize()         const { return size; }
    Key32    getNameKey()      const { return nameKey; }
    Key32    getSignatureKey()  const { return signKey; }

  public:
    JFInfo() : offset(0), size(0) {}
    JFInfo(const char* name, const char* sig, size_t sz, size_t off)
    {
      define(name, sig, sz, off);
    }
    ~JFInfo() {}
};

/////////////////////////////////////////////////////////////////////////////////////
//
//  JasmineObject
//
//  Encapsulates a collection of code and data. A JasmineObject does not represent
//  a class in the OOP sense, rather it is a '.o' file in the compiler evnironment
//  sense. Jasmine is intended to be a low level assembler VM that supports higher
//  level languages, not all of which are OOP.
//
//  A JasmineObject encapsulates a body of code defined by one or more JFInfo
//  entries.
//
/////////////////////////////////////////////////////////////////////////////////////

class JasmineObject : public XSFStorable {
  friend class Jasmine;
  friend class JasmineObjectProvider;
  private:
    struct {
      uint32  funcTabLen;    // function table size
      uint32  codeLen;      // total code size in instruction words
      uint32  data64Len;    // total 64-bit r/w data (in bytes)
      uint32  data32Len;    // total 32-bit r/w data (in bytes)
      uint32  data16Len;    // total 16-bit r/w data (in bytes)
      uint32  data8Len;      // total 8-bit r/w data (in bytes)
      uint32  const64Len;    // total 64-bit constant data (in bytes)
      uint32  const32Len;    // total 32-bit constant data (in bytes)
      uint32  const16Len;    // total 16-bit constant data (in bytes)
      uint32  const8Len;    // total 8-bit constant data (in bytes)
      uint32  stackSize;    // requested VM stack size (in bytes)
      uint32  methodSize;    // requested VM return stack size (in calls)
      uint32  regSize;      // requested VM register stack size (in units)
      uint32  checksum;
    } shared32;

    struct {
      sint16  progVersion;
      sint16  progRevision;
    } shared16;

    struct {
      char progName[32];
    } shared8;

    // allocation
    uint8*    codeSpace;    // code, functab, resolved tab
    uint8*    dataSpace;

    // resolved on loading
    JFInfo*    funcTab;
    uint32**  funcResolved;  // runtime addresses of functions
    uint32*    code;
    uint8*    data64;
    uint8*    data32;
    uint8*    data16;
    uint8*    data8;
    uint8*    const64;
    uint8*    const32;
    uint8*    const16;
    uint8*    const8;

    static const char* xsfIDString;

    void      init();
    sint32    create();
    void      destroy();
    void      resolve();

  protected:
    // object body IO
    sint32    readyForWrite();
    sint32    readyForRead();
    sint32    writeBody(XSFStreamOut* f);
    sint32    readBody(XSFStreamIn* f);

    void      setStackSize(size_t s)          { shared32.stackSize = s; }
    void      setMethodStackSize(size_t s)    { shared32.methodSize = s; }
    void      setRegisterStackSize(size_t s)  { shared32.regSize = s; }
    void      setVersion(sint16 v)            { shared16.progVersion = v; }
    void      setRevision(sint16 r)            { shared16.progRevision = r; }
    void      setName(const char* n)          { strncpy(shared8.progName, n, 31); }

  public:
    static const char*  xsfFileSig;
    static const uint16  xsfSuperClass;
    static const uint16 xsfSubClass;
    static const uint8  xsfDataFormat;
    static const uint8  xsfFileFormat;
    static const uint8  xsfJasmineVer;
    static const uint8  xsfJasmineRev;

    const uint32**    getFuncs()    const { return (const uint32**)funcResolved; }
    const uint32*      getCode()      const { return (const uint32*)code; }
    void*              getData()      const { return data64; }
    void*              getData64()    const { return data64; }
    void*              getData32()    const { return data32; }
    void*              getData16()    const { return data16; }
    void*              getData8()    const { return data8; }
    const void*        getConst()    const { return (const void*)const64; }
    const void*        getConst64()  const { return (const void*)const64; }
    const void*        getConst32()  const { return (const void*)const32; }
    const void*        getConst16()  const { return (const void*)const16; }
    const void*        getConst8()    const { return (const void*)const8; }

    sint16            getVersion()  const { return shared16.progVersion; }
    sint16            getRevision()  const { return shared16.progRevision; }
    const char*        getName()      const { return (const char*)shared8.progName; }


    // The get...Length() return the size of the section expressed in bytes
    size_t            getCodeLength()      const { return getCodeSize()*sizeof(uint32); }
    size_t            getData64Length()    const { return shared32.data64Len; }
    size_t            getData32Length()    const { return shared32.data32Len; }
    size_t            getData16Length()    const { return shared32.data16Len; }
    size_t            getData8Length()    const { return shared32.data8Len; }
    size_t            getDataLength()      const;

    size_t            getConst64Length()  const { return shared32.const64Len; }
    size_t            getConst32Length()  const { return shared32.const32Len; }
    size_t            getConst16Length()  const { return shared32.const16Len; }
    size_t            getConst8Length()    const { return shared32.const8Len; }
    size_t            getConstLength()    const;

    // The get...Size() return the size of the section expressed in terms
    // of the element size
    size_t            getStackSize()          const { return shared32.stackSize; }
    size_t            getMethodStackSize()    const { return shared32.methodSize; }
    size_t            getRegisterStackSize()  const { return shared32.regSize; }
    size_t            getFuncTabSize()        const { return shared32.funcTabLen; }
    size_t            getCodeSize()            const { return shared32.codeLen; }
    size_t            getData64Size()          const { return getData64Length()>>3; }
    size_t            getData32Size()          const { return getData32Length()>>2; }
    size_t            getData16Size()          const { return getData16Length()>>1; }
    size_t            getData8Size()          const { return getData8Length(); }
    size_t            getConst64Size()        const { return getConst64Length()>>3; }
    size_t            getConst32Size()        const { return getConst32Length()>>2; }
    size_t            getConst16Size()        const { return getConst16Length()>>1; }
    size_t            getConst8Size()          const { return getConst8Length(); }

    const JFInfo*      getMethod(uint32 index) const;
    void              listMethods()            const;

    void              debugDump()              const;

  public:
    JasmineObject();
    virtual ~JasmineObject();

};

class JasmineObjectProvider {
  protected:
    // destroy an existing object rep
    static sint32 jasmineDestroyRep(JasmineObject* obj);
    // create a new object rep. This destroys the old one automatically
    static sint32 jasmineCreateNewRep(JasmineObject* obj,
                               size_t numFuncs, size_t codeSize,
                               size_t d64, size_t d32, size_t d16, size_t d8,
                               size_t c64, size_t c32, size_t c16, size_t c8);
    // installation methods. All copy the data to the object
    static sint32 jasmineInstallFunc(JasmineObject* obj, JFInfo* func, size_t pos);
    static sint32 jasmineInstallCode(JasmineObject* obj, uint32* code, size_t size, size_t ofs=0);
    static sint32 jasmineInstallData8(JasmineObject* obj, void* data, size_t size, size_t ofs=0);
    static sint32 jasmineInstallData16(JasmineObject* obj, void* data, size_t size, size_t ofs=0);
    static sint32 jasmineInstallData32(JasmineObject* obj, void* data, size_t size, size_t ofs=0);
    static sint32 jasmineInstallData64(JasmineObject* obj, void* data, size_t size, size_t ofs=0);
    static sint32 jasmineInstallConst8(JasmineObject* obj, void* data, size_t size, size_t ofs=0);
    static sint32 jasmineInstallConst16(JasmineObject* obj, void* data, size_t size, size_t ofs=0);
    static sint32 jasmineInstallConst32(JasmineObject* obj, void* data, size_t size, size_t ofs=0);
    static sint32 jasmineInstallConst64(JasmineObject* obj, void* data, size_t size, size_t ofs=0);


    static void jasmineSetStackSize(JasmineObject* obj, size_t s)
    {
      if (obj) obj->setStackSize(s);
    }

    static void jasmineSetMethodStackSize(JasmineObject* obj, size_t s)
    {
      if (obj) obj->setMethodStackSize(s);
    }

    static void jasmineSetRegisterStackSize(JasmineObject* obj, size_t s)
    {
      if (obj) obj->setRegisterStackSize(s);
    }

    static void jasmineSetVersion(JasmineObject* obj, sint16 v)
    {
      if (obj) obj->setVersion(v);
    }

    static void jasmineSetRevision(JasmineObject* obj, sint16 r)
    {
      if (obj) obj->setRevision(r);
    }

    static void jasmineSetName(JasmineObject* obj, const char* n)
    {
      if (obj) obj->setName(n);
    }

    static void jasmineResolve(JasmineObject* obj)
    {
      if (obj) obj->resolve();
    }
};

#endif