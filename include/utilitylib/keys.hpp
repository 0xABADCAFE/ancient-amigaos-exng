//****************************************************************************//
//**                                                                        **//
//** File:         include/utilitylib/keys.hpp                              **//
//** Description:  Integer Key classes for hash/ID/CRC-style purposes       **//
//** Comment(s):                                                            **//
//** Library:      utilitylib                                               **//
//** Created:      2003-03-04                                               **//
//** Updated:      2003-03-04                                               **//
//** Author(s):    Karl Churchill                                           **//
//** Note(s):                                                               **//
//** Copyright:    (C)1996-2003, eXtropia Studios                           **//
//**               Serkan YAZICI, Karl Churchill                            **//
//**               All Rights Reserved.                                     **//
//**                                                                        **//
//****************************************************************************//

#ifndef _EXTROPIA_UTILITYLIB_KEYS_HPP
#define _EXTROPIA_UTILITYLIB_KEYS_HPP

#include <xbase.hpp>

class Key32 {
  private:
    uint32 val;
    uint32 getValue(const char* text) const;

  public:
    Key32& operator=(const char* text) {
      val = getValue(text);
      return *this;
    }

    operator int() { return val; }
    uint32 value() { return val; }

    bool operator==(const Key32& i)  const { return val==i.val; }
    bool operator!=(const Key32& i)  const { return val!=i.val; }
    bool operator==(const char* text) const { return val==getValue(text); }
    bool operator!=(const char* text) const { return val!=getValue(text); }


  public:
    Key32(const Key32& k) : val(k.val) {}
    Key32() : val(0) {}
    Key32(const char* text) { val = getValue(text); }
};

class Key64 {
  private:
    uint64 val;
    uint64 getValue(const char* text) const;

  public:
    Key64& operator=(const char* text) {
      val = getValue(text);
      return *this;
    }

    operator uint64() const { return val; }
    uint64 value() const { return val; }

    bool operator==(const Key64& i)  const { return val==i.val; }
    bool operator!=(const Key64& i)  const { return val!=i.val; }
    bool operator==(const char* text) const { return val==getValue(text); }
    bool operator!=(const char* text) const { return val!=getValue(text); }

  public:
    Key64(const Key64& k) : val(k.val) {}
    Key64() : val(0) {}
    Key64(const char* text) { val = getValue(text); }
};


#endif
