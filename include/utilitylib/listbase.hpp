//****************************************************************************//
//**                                                                        **//
//** File:         include/utilitylib/listbase.hpp                          **//
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

#ifndef _EXTROPIA_UTILITYLIB_LIST_HPP
#error "utility/listbase.hpp may only be included by utilitylib/list.hpp"
#else

////////////////////////////////////////////////////////////////////////////////
//
//  _LLBase
//
//  Simple linked list of generic pointers, used as a common code base for
//  the type-safe list based containers. This prevents the usual template
//  bloat since all the real work is done here and the template is just
//  used as a type safe wrapper.
//
//  This class only handles references to objects and does not perform any
//  operations of any kind on the objects referenced.
//
//  Each link is comprised of the usual previous / next info and a void* pointer
//  to the object referenced. Since links need to be allocated every time an
//  object is added to a list, a cacheing system is used for links.
//
//  A single vector of links is maintained, all previous/next references are
//  indecies within the vector. All links allocated from any list instance are
//  allocated from this vector.
//
//  Each link contains a reference to the next free link after itself. Initially
//  this will be the next link in the vector. A static reference to the next
//  free link is maintained within the class itself.
//
//  When a link is freed, the static next free link reference is stored within
//  that links own next free reference. The static next free link then becomes
//  the newly freed link.
//
//  This means that the next unused or most recently freed link will always be
//  the next allocated.
//
//  When the existing link cache reaches capacity, it is expanded by a fixed
//  amount. Since links only reference one another by index, the resizing
//  process can safely copy the existing cache data.
//
//  The entire link system is implemented here and does not propagate beyond
//  this class.
//
////////////////////////////////////////////////////////////////////////////////

#define LINKCACHEDELTA  128

class _LLBase {
  friend class _LLBaseIterator;
  private:
    enum {
      NULL_LINK  = -1    // index for null link
    };

    struct Link {
      sint32 prev;
      sint32 next;
      sint32 nextFree;  // used to store the previous free link after this
      void*  item;
    };

    // Link cacheing system
    static Link*  linkCache;
    static sint32  linkCacheSize;    // the current size (in links)
    static sint32  linkCacheDelta;    // the number of links to expand / shrink
    static sint32 linkCount;        // current number of links
    static sint32 nextFree;          // the next freely available link

    static sint32  createLink();
    static void    destroyLink(sint32 l);
    static bool    expandCache();

    sint32  head;
    sint32  tail;
    sint32  crnt;
    sint32  num;

    sint32  findFwrd(sint32 s, void* p);
    sint32  findBkwd(sint32 s, void* p);

    static sint32  rem(REGI0 sint32 s, REGI1 sint32 e);
    static sint32  rem(REGI0 sint32 s, REGI1 sint32 e, REGP0 void* p);
    static sint32  cnt(REGI0 sint32 s, REGI1 sint32 e, REGP0 void* p);
    static sint32  rep(REGI0 sint32 s, REGI1 sint32 e, REGP0 void *p, REGP1 void* r);

  protected:

    // insert links before first / last / current
    bool   insLast(void* p);
    bool   insFirst(void* p);
    bool   insCurr(void* p);

    // remove at  first / last / current
    void*  remLast();
    void*  remFirst();
    void*  remCurr();

    // remove link ranges
    sint32  remBefCurr();
    sint32  remAftCurr();
    sint32  remAll();

    // remove matching links
    bool    remFirst(void* p);  // remove first occuring reference to p
    bool     remLast(void* p);    // remove last occuring reference to p

    // remove matching link ranges
    sint32  remBefCurr(void* p);
    sint32  remAftCurr(void* p);
    sint32  remAll(void* p);

    // replace matching links
    bool    repFirst(void* p, void* r);
    bool    repLast(void* p, void* r);

    // replace matching link ranges
    sint32  repBefCurr(void* p, void* r);
    sint32  repAftCurr(void* p, void* r);
    sint32  repAll(void* p, void* r);

    // search links
    bool    srchFwrd(void* p, bool start);
    bool    srchBkwd(void* p, bool end);

    // quick test for link (nonspecific search)
    bool    contains(void* p) const;

    sint32  cntBefCurr(void* p);
    sint32  cntAftCurr(void* p);
    sint32  cntAll(void* p);

    // cursor
    void*  curr();
    void*  first();
    void* last();
    void* next();
    void* prev();

    // other info
    sint32 numLinks()  const { return num; }

  protected:
    _LLBase();

  public:
    static void  setDelta(sint32 d)  { if (d>=4 && d<=32768) linkCacheDelta = d; }

    static sint32 getCacheSize()  { return linkCacheSize; }
    static sint32 getCacheDelta()  { return linkCacheDelta; }
    static sint32 getCacheUsed()  { return linkCount; }
    static sint32 getNextFree()    { return nextFree; }
    ~_LLBase();
};

////////////////////////////////////////////////////////////////////////////////

inline void* _LLBase::curr()
{
  return linkCache[crnt].item;
}

////////////////////////////////////////////////////////////////////////////////

inline void* _LLBase::first()
{
  if (num>0)
  {
    crnt = linkCache[head].next;
    return linkCache[crnt].item;
  }
  return 0;
}

////////////////////////////////////////////////////////////////////////////////

inline void* _LLBase::last()
{
  if (num>0)
  {
    crnt = linkCache[tail].prev;
    return curr();
  }
  return 0;
}

////////////////////////////////////////////////////////////////////////////////

inline void* _LLBase::next()
{
  sint32 l = linkCache[crnt].next;
  if (l==NULL_LINK || l==tail)
    return 0;
  crnt = l;
  return curr();
}

////////////////////////////////////////////////////////////////////////////////

inline void* _LLBase::prev()
{
  sint32 l = linkCache[crnt].prev;
  if (l==NULL_LINK || l==head)
    return 0;
  crnt = linkCache[crnt].prev;
  return curr();
}

////////////////////////////////////////////////////////////////////////////////

inline sint32 _LLBase::cntBefCurr(void* p)
{
  return cnt(head, crnt, p);
}

////////////////////////////////////////////////////////////////////////////////

inline sint32 _LLBase::cntAftCurr(void* p)
{
  return cnt(crnt, tail, p);
}

////////////////////////////////////////////////////////////////////////////////

inline sint32 _LLBase::cntAll(void* p)
{
  return cnt(head, tail, p);
}

////////////////////////////////////////////////////////////////////////////////

inline sint32 _LLBase::remBefCurr()
{
  if (num>0) {
    sint32 n = rem(head, crnt);
    num -= n;
    return n;
  }
  return 0;
}

////////////////////////////////////////////////////////////////////////////////

inline sint32 _LLBase::remAftCurr()
{
  if (num>0) {
    sint32 n = rem(crnt, tail);
    num -= n;
    return n;
  }
  return 0;
}

////////////////////////////////////////////////////////////////////////////////

inline sint32 _LLBase::remAll()
{
  if (num>0) {
    sint32 n = rem(head, tail);
    num -= n;
    return n;
  }
  return 0;
}

////////////////////////////////////////////////////////////////////////////////

inline sint32 _LLBase::remBefCurr(void* p)
{
  if (num>0) {
    sint32 n = rem(head, crnt, p);
    num -= n;
    return n;
  }
  return 0;
}

////////////////////////////////////////////////////////////////////////////////

inline sint32 _LLBase::remAftCurr(void* p)
{
  if (num>0) {
    sint32 n = rem(crnt, tail, p);
    num -= n;
    return n;
  }
  return 0;
}

////////////////////////////////////////////////////////////////////////////////

inline sint32 _LLBase::remAll(void* p)
{
  if (num>0) {
    sint32 n = rem(head, tail, p);
    num-=n;
    return n;
  }
  return 0;
}

////////////////////////////////////////////////////////////////////////////////

inline sint32 _LLBase::repBefCurr(void* p, void* r)
{
  if (num>0) {
    sint32 n = rep(head, crnt, p, r);
    num -= n;
    return n;
  }
  return 0;
}

////////////////////////////////////////////////////////////////////////////////

inline sint32 _LLBase::repAftCurr(void* p, void* r)
{
  if (num>0) {
    sint32 n = rep(crnt, tail, p, r);
    num -= n;
    return n;
  }
  return 0;
}

////////////////////////////////////////////////////////////////////////////////

inline sint32 _LLBase::repAll(void* p, void* r)
{
  if (num>0) {
    sint32 n = rep(head, tail, p, r);
    num -= n;
    return n;
  }
  return 0;
}

////////////////////////////////////////////////////////////////////////////////

inline bool _LLBase::srchFwrd(void* p, bool start)
{
  sint32 s = start==true ? head : crnt;
  sint32 f = findFwrd(s, p);
  if (f != NULL_LINK) {
    crnt = f;
    return true;
  }
  return false;
}

////////////////////////////////////////////////////////////////////////////////

inline bool _LLBase::srchBkwd(void* p, bool end)
{
  sint32 s = end==true ? tail : crnt;
  sint32 f = findBkwd(s, p);
  if (f != NULL_LINK)
  {
    crnt = f;
    return true;
  }
  return false;
}

////////////////////////////////////////////////////////////////////////////////

class _LLBaseIterator {
  private:
    _LLBase* list;

  protected:
    void* next();
    void* prev();
    void* first();
    void* last();
    _LLBaseIterator(_LLBase* l) : list(l) { }
};

#endif