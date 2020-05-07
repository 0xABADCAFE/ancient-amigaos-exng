//****************************************************************************//
//**                                                                        **//
//** File:         include/utilitylib/pool.hpp                              **//
//** Description:  Simple container types                                   **//
//** Comment(s):                                                            **//
//** Library:      utilitylib                                               **//
//** Created:      2003-02-09                                               **//
//** Updated:      2003-02-09                                               **//
//** Author(s):    Karl Churchill                                           **//
//** Note(s):                                                               **//
//** Copyright:    (C)1996-2003, eXtropia Studios                           **//
//**               Serkan YAZICI, Karl Churchill                            **//
//**               All Rights Reserved.                                     **//
//**                                                                        **//
//****************************************************************************//

#ifndef _EXTROPIA_UTILITYLIB_POOL_HPP
#define _EXTROPIA_UTILITYLIB_POOL_HPP

#include <xbase.hpp>

inline void* operator new(size_t s, void* p) { return p; }

////////////////////////////////////////////////////////////////////////////////
//
//  class PoolBase
//
////////////////////////////////////////////////////////////////////////////////

class PoolBase {
  protected:
    uint32*      data;          // actual pool data
    size_t       size;          // size of pool (number of T)
    uint32      rawSize;      // size of pool in 16-bit words
    size_t      tSize;        // size of element T, in bytes
    sint32       nextFree;      // position of next unused T in pool
    sint32      totalFree;    // remaining free T in pool
    uint16***    allocTable;    // pointer to allocation address table
    uint16*      pool;          // pointer to pool

  protected:
    // only to be used by derived class
    void    baseInit() {
      data        = 0;
      size        = 0;
      tSize        = 0;
      rawSize      = 0;
      nextFree    = -1;
      totalFree    = 0;
      allocTable  = 0;
      pool        = 0;
    }

    sint32  isInPool(void* t) const
    {
      return (((uint16*)t >= pool) && ((uint16*)t < &pool[rawSize-1]));
    }

  protected:
    PoolBase() { baseInit(); }
  public:
    virtual ~PoolBase();

  public:
    enum {
      ERR_NEW_ALLOC_TO_BIG     = RPERR(USER,6),
      ERR_RESIZE_TO_SMALL      = RPERR(USER,5),
      ERR_ALLOC_INCONSISTENT  = RPERR(USER,4),
      ERR_ALLOC_CORRUPT        = RPERR(USER,3),
      ERR_POOL_CORRUPT        = RPERR(USER,2),
      ERR_POOL_FRAGMENTED     = RPERR(USER,1),
      ERR_POOL                = RPERR(USER,0)
    };
    size_t  getSize()    const  { return size; }
    size_t  getSpace()  const  { return totalFree; }
    sint32  getNext()    const  { return nextFree; }
};

////////////////////////////////////////////////////////////////////////////////
//
// Large data, 2G entries max / 2G array size max / 64 bits per allocation entry
//
////////////////////////////////////////////////////////////////////////////////

class PoolLargeRaw : public PoolBase {
  private:
    uint32* lengthTable;

    void    init()                             { lengthTable = 0; baseInit(); }
    uint32  examineBlock(uint32 location);
    sint32  testConsistency(bool strict=0);

  public:
    sint32  defrag();
    sint32  resize(size_t s);
  protected:
    // These are the performance critical methods that should be inlined
    sint32  getSpace(size_t entries, size_t typeSize);
    sint32  freeSpace(bool force=0, bool unallocate=0);
    sint32  assignSingle(void* vt);
    sint32  assignVector(void* vt, size_t s);
    sint32  unassign(void* vt);
    PoolLargeRaw() : lengthTable(0) { }
    PoolLargeRaw(size_t entries, size_t typeSize);

  public:
    ~PoolLargeRaw();
};


////////////////////////////////////////////////////////////////////////////////
//
// Small data, 2G entries max / 2G array size max / 64 bits per allocation entry
//
////////////////////////////////////////////////////////////////////////////////

class PoolSmallRaw : public PoolBase {
  private:
    uint16* lengthTable;
    void    init()                             { lengthTable = 0; baseInit(); }
    uint32  examineBlock(uint32 location);
    sint32  testConsistency(bool strict=0);

  public:
    sint32  defrag();
    sint32  resize(size_t s);

  protected:
    sint32  getSpace(size_t entries, size_t typeSize);
    sint32  freeSpace(bool force=0, bool unallocate=0);
    sint32  assignSingle(void* vt);
    sint32  assignVector(void* vt, size_t s);
    sint32  unassign(void* vt);
    PoolSmallRaw() : lengthTable(0) { }
    PoolSmallRaw(size_t entries, size_t typeSize);

  public:
    ~PoolSmallRaw();
};


////////////////////////////////////////////////////////////////////////////////
//
//  PoolSmall
//
////////////////////////////////////////////////////////////////////////////////

template<class T> class PoolSmall : public PoolSmallRaw {

  public:
    sint32  create(size_t entries, bool construct)
    {
      sint32 retVal = PoolSmallRaw::getSpace(entries, sizeof(T));
      if (retVal==OK && construct==true) {
        register T* o = (T*)pool;
        rsint32 n = entries+1;
        while (--n) {
          new(o++) T;
        }
      }
      return retVal;
    }

    sint32 destroy(bool deconstruct=0, bool force=0, bool unallocate=0)
    {
      if (pool!=0 && deconstruct==true) {
        register T* o = (T*)pool;
        rsint32 n = size+1;
        while (--n) {
          delete(o++);
        }
      }
      return PoolSmallRaw::freeSpace(force, unallocate);
    }

    sint32  newObj(T** t)
    {
      return PoolSmallRaw::assignSingle(t);
    }

    sint32  newBlock(T** t, size_t num)
    {
      return PoolSmallRaw::assignVector(t, num);
    }

    sint32  del(T** t)
    {
      return PoolSmallRaw::unassign(t);
    }

  public:
    PoolSmall() {}
    PoolSmall(size_t entries) : PoolSmallRaw(entries, sizeof(T)) {}
    ~PoolSmall() {}
};


////////////////////////////////////////////////////////////////////////////////
//
//  PoolSmall
//
////////////////////////////////////////////////////////////////////////////////

template<class T> class PoolLarge : public PoolLargeRaw {
  public:
    sint32  create(size_t entries, bool construct)
    {
      sint32 retVal = PoolLargeRaw::getSpace(entries, sizeof(T));
      if (retVal==OK && construct==true) {
        register T* o = (T*)pool;
        rsint32 n = entries+1;
        while (--n) {
          new(o++) T;
        }
      }
      return retVal;
    }

    sint32 destroy(bool deconstruct=0, bool force=0, bool unallocate=0)
    {
      if (pool!=0 && deconstruct==true) {
        register T* o = (T*)pool;
        rsint32 n = size+1;
        while (--n) {
          delete(o++);
        }
      }
      return PoolLargeRaw::freeSpace(force, unallocate);
    }

    sint32  newObj(T** t)
    {
      return PoolLargeRaw::assignSingle(t);
    }

    sint32  newBlock(T** t, size_t num)
    {
      return PoolLargeRaw::assignVector(t, num);
    }

    sint32  del(T** t)
    {
      return PoolLargeRaw::unassign(t);
    }

  public:
    PoolLarge() {}
    PoolLarge(size_t entries) : PoolLargeRaw(entries, sizeof(T)) {}
    ~PoolLarge() {}
};


#endif

