//****************************************************************************//
//**                                                                        **//
//** File:         libsrc/common/utilitylib/list.cpp                        **//
//** Description:  Simple containers                                        **//
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

#include <utilitylib/list.hpp>

_LLBase::Link*  _LLBase::linkCache = 0;
sint32          _LLBase::linkCacheSize = 0;
sint32          _LLBase::linkCacheDelta = 256;
sint32          _LLBase::linkCount = 0;
sint32          _LLBase::nextFree = _LLBase::NULL_LINK;

////////////////////////////////////////////////////////////////////////////////

sint32 _LLBase::createLink()
{
  // If the next link will overflow the last index we need to expand the cache
  if (++linkCount > linkCacheSize) {
    if (expandCache()==false) {
      linkCount--;
      return NULL_LINK;
    }
  }

  //printf("_LLBase::createLink() link = %ld\n", nextFree);
  // Obtain next free link and update  the next free link index
  sint32 link = nextFree;
  nextFree = linkCache[nextFree].nextFree;
  //printf("_LLBase::createLink() nextFree = %ld\n", nextFree);
  return link;
}

////////////////////////////////////////////////////////////////////////////////

void _LLBase::destroyLink(sint32 l)
{
  if (linkCount>0 && l!=NULL_LINK && l<linkCacheSize && linkCache[l].item!=0) {
    //printf("_LLBase::destroyLink() link = %ld, old nextFree = %ld\n", l, nextFree);
    linkCache[l].item = 0; // a null item flags link as free

    // This newly freed link will become the next available and the previous
    // nextFree will be referenced by it
    linkCache[l].nextFree = nextFree;
    nextFree = l;


    // If we are destroying the last link, then free the linkCache
    if (--linkCount == 0) {
      Mem::free(linkCache);
      linkCacheSize = 0;
      nextFree = NULL_LINK;
    }
  }
}

////////////////////////////////////////////////////////////////////////////////

bool _LLBase::expandCache()
{
  // This function increaes the cache, copying any existing entries.
  // Newly allocated Links have their item pointers zeroed and their
  // nextFree references set to point to the Link above.
  // Note, expandCache() will only be called when the existing cache is
  // completely full.
  // Failure to expand the cache does not modify the existing cache

  sint32 newSize = linkCacheSize + linkCacheDelta;
  void* newCache = Mem::alloc(newSize*sizeof(Link), false, Mem::ALIGN_CACHE);
  if (!newCache)
    return false;

  // Copy any existing entries
  if (linkCache) {
    Mem::copy(newCache, linkCache, linkCacheSize*sizeof(Link));
    Mem::free(linkCache);
  }

  // Set the linkCache pointer to this new area
  linkCache = (Link*)newCache;

  // Set up the Link data
  for (sint32 i = linkCacheSize; i<newSize; i++) {
    linkCache[i].nextFree = i+1; // each link.nextFree points to nextr object
    linkCache[i].item = 0;
  }
  nextFree = linkCacheSize;  // the nextFree index is automatically the old size
  linkCacheSize = newSize;
  return true;
}

////////////////////////////////////////////////////////////////////////////////

_LLBase::_LLBase() : num(0)
{
  head = createLink();
  tail = createLink();
  if (head!=NULL_LINK && tail!=NULL_LINK) {
    linkCache[head].prev = NULL_LINK;
    linkCache[head].next = tail;
    linkCache[head].item = this;
    linkCache[tail].prev = head;
    linkCache[tail].next = NULL_LINK;
    linkCache[tail].item = this;
    crnt = tail;
  }
  //puts("_LLBase constructed");
}

////////////////////////////////////////////////////////////////////////////////

_LLBase::~_LLBase()
{
  rsint32 t = linkCache[head].next;
  while (t!=NULL_LINK && t!=tail) {
    rsint32 nt = linkCache[t].next;
    destroyLink(t);
    t = nt;
  }
  destroyLink(head);
  destroyLink(tail);
  //puts("_LLBase destroyed");
}

////////////////////////////////////////////////////////////////////////////////

sint32 _LLBase::findFwrd(sint32 s, void *p)
{
  if (p && num>0) {
    register Link* link = linkCache;
    rsint32  search = link[s].next;

    while (search!=NULL_LINK && search!=tail) {
      if (link[search].item == p) {
        return search;
      }
      search = link[search].next;
    }
  }
  return NULL_LINK;
}

////////////////////////////////////////////////////////////////////////////////

sint32 _LLBase::findBkwd(sint32 s, void *p)
{
  if (p && num>0) {
    register Link* link = linkCache;
    rsint32  search = link[s].prev;

    while (search!=NULL_LINK && search!=head) {
      if (link[search].item == p) {
        return search;
      }
      search = link[search].prev;
    }
  }
  return NULL_LINK;
}

////////////////////////////////////////////////////////////////////////////////

sint32 _LLBase::rem(REGI0 sint32 s, REGI1 sint32 e)
{
  if (s!=e) {
    register Link* link = linkCache;
    rsint32 search = link[s].next;
    rsint32 n = 0;
    while (search!=NULL_LINK && search!=e) {
      destroyLink(search);
      search = link[search].next;
      n++;
    }
    link[s].next = e;
    link[e].prev = s;
    return n; // number removed
  }
  return 0;
}

////////////////////////////////////////////////////////////////////////////////

sint32 _LLBase::rem(REGI0 sint32 s, REGI1 sint32 e, REGP0 void* p)
{
  if (p && s!=e) {
    register Link* link = linkCache;
    rsint32 search = link[s].next;
    rsint32 n = 0;
    while (search!=NULL_LINK && search!=e) {
      rsint32 nxt = link[search].next;
      if (link[search].item == p) {
        rsint32 prv = link[search].prev;
        link[prv].next  = nxt;
        link[nxt].prev  = prv;
        destroyLink(search);
        n++;
      }
      search = nxt;
    }
    return n; // number removed
  }
  return 0;
}

////////////////////////////////////////////////////////////////////////////////

sint32 _LLBase::cnt(REGI0 sint32 s, REGI1 sint32 e, REGP0 void* p)
{
  if (p && s!=e) {
    register Link* link = linkCache;
    rsint32 search = link[s].next;
    rsint32 n = 0;
    while (search!=NULL_LINK && search!=e) {
      if (link[search].item == p) {
        n++;
      }
      search = link[search].next;
    }
    return n; // number replaced
  }
  return 0;
}

////////////////////////////////////////////////////////////////////////////////

sint32 _LLBase::rep(REGI0 sint32 s, REGI1 sint32 e, REGP0 void* p, REGP1 void* r)
{
  if (p && r && p!=r && s!=e) {
    register Link* link = linkCache;
    rsint32 search = link[s].next;
    rsint32 n = 0;
    while (search!=NULL_LINK && search!=e) {
      if (link[search].item == p) {
        linkCache[search].item = r;
        n++;
      }
      search = link[search].next;
    }
    return n; // number replaced
  }
  return 0;
}

////////////////////////////////////////////////////////////////////////////////


bool _LLBase::contains(void *p) const
{
  if (p && num>0) {
    // search from both ends towards centre
    register Link* link = linkCache;
    rsint32 rev = link[tail].prev;
    rsint32 fwd = link[head].next;
    rsint32 n = num+1;
    while (n>0) {
      if (link[fwd].item == p) {
        return true;
      }
      n--;
      fwd = link[fwd].next;
      if (link[rev].item == p) {
        return true;
      }
      n--;
      rev = link[rev].prev;
    }
  }
  return false;
}

////////////////////////////////////////////////////////////////////////////////

bool _LLBase::insLast(void* p)
{  // insert before list tail
  if (p) {
    sint32 add = createLink();
    if (add!=NULL_LINK) {
      register Link* link         = linkCache;
      link[add].item              = p;
      link[add].prev              = link[tail].prev;
      link[link[tail].prev].next  = add;
      link[add].next              = tail;
      link[tail].prev              = add;
      num++;
      return true;
    }
  }
  return false;
}

////////////////////////////////////////////////////////////////////////////////

bool _LLBase::insFirst(void* p)
{  // insert after list head
  if (p) {
    sint32 add = createLink();
    if (add!=NULL_LINK) {
      register Link* link         = linkCache;
      link[add].item              = p;
      link[add].next              = link[head].next;
      link[link[head].next].prev  = add;
      link[add].prev              = head;
      link[head].next              = add;
      num++;
      return true;
    }
  }
  return false;
}

////////////////////////////////////////////////////////////////////////////////

bool _LLBase::insCurr(void* p)
{  // insert before list crnt
  if (p) {
    sint32 add = createLink();
    if (add!=NULL_LINK) {
      register Link* link = linkCache;
      sint32 pre          = link[crnt].prev;
      link[add].item      = p;
      link[crnt].prev      = add;
      link[add].next      = crnt;
      link[add].prev      = pre;
      link[pre].next      = add;
      num++;
      return true;
    }
  }
  return false;
}

////////////////////////////////////////////////////////////////////////////////

void* _LLBase::remLast()
{
  if (num>0) {
    register  Link* link        = linkCache;
    sint32    removing          = link[tail].prev;
    void*      item              = link[removing].item;
    link[tail].prev              = link[removing].prev;
    link[link[tail].prev].next  = tail;

    if (crnt == removing) {
      crnt = link[tail].prev;
    }
    destroyLink(removing);
    num--;
    return item;
  }
  return 0;
}

////////////////////////////////////////////////////////////////////////////////

void* _LLBase::remFirst()
{
  if (num>0) {
    register  Link* link        = linkCache;
    sint32    removing          = link[head].next;
    void*      item              = link[removing].item;
    link[head].next              = link[removing].next;
    link[link[head].next].prev  = head;

    if (crnt == removing) {
      crnt = link[head].next;
    }
    destroyLink(removing);
    num--;
    return item;
  }
  return 0;
}

////////////////////////////////////////////////////////////////////////////////

void* _LLBase::remCurr()
{
  if (num>0) {
    register  Link* link        = linkCache;
    sint32    removing          = crnt;
    void*      item              = link[crnt].item;
    link[link[crnt].prev].next  = link[crnt].next;
    link[link[crnt].next].prev  = link[crnt].prev;
    crnt                        = link[crnt].next;
    destroyLink(removing);
    num--;
    return item;
  }
  return 0;
}

////////////////////////////////////////////////////////////////////////////////

bool _LLBase::remFirst(void *p)
{
  if (p && num>0) {
    sint32 found = findFwrd(head, p);
    if (found!=NULL_LINK) {
      register  Link* link        = linkCache;
      //printf("_LLBase::remFirst(0x%08X), found %ld\n", (uint32)p, found);

      // if found link is current, move current to next
      if (crnt == found) {
        crnt = link[found].next;
      }
      // join prev and next links to one another
      link[link[found].prev].next  = link[found].next;
      link[link[found].next].prev  = link[found].prev;
      destroyLink(found);
      num--;
      return true;
    }
  }
  return false;
}

////////////////////////////////////////////////////////////////////////////////

bool _LLBase::remLast(void *p)
{
  if (p && num>0) {
    sint32 found = findBkwd(tail, p);
    if (found!=NULL_LINK) {
      register  Link* link        = linkCache;
      //printf("_LLBase::remLast(0x%08X), found %ld\n", (uint32)p, found);
      // if found link is current, move current to previous
      if (crnt == found)
        crnt = link[found].prev;

      // join prev and next links to one another
      link[link[found].prev].next  = link[found].next;
      link[link[found].next].prev  = link[found].prev;
      destroyLink(found);
      num--;
      return true;
    }
  }
  return false;
}

////////////////////////////////////////////////////////////////////////////////

bool _LLBase::repFirst(void* p, void* r)
{
  if (p && r && p!=r && num>0) {
    sint32 found = findFwrd(head, p);
    if (found!=NULL_LINK) {
      linkCache[found].item = r;
      return true;
    }
  }
  return false;
}

////////////////////////////////////////////////////////////////////////////////

bool _LLBase::repLast(void* p, void* r)
{
  if (p && r && p!=r && num>0) {
    sint32 found = findBkwd(tail, p);
    if (found!=NULL_LINK) {
      linkCache[found].item = r;
      return true;
    }
  }
  return false;
}

////////////////////////////////////////////////////////////////////////////////

