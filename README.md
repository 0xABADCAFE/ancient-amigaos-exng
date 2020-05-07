# ancient-amigaos-exng
Ancient AmigaOS C++ framework, iteration 1

This represented the first attempt to build a reusable application development framework, primarily for AmigaOS3 using C++. Only a restricted subset of C++ was allowed for various reasons (compiler support, runtime support, executable size, performance etc) and is therefore best described as C with classes.

A notable omission from the standard was the use of Exceptions for error handling as this suffered all of the complications above. Instead, a large enumerated set of error codes was defined.

The framework was designed to compile into a set of modular libraries that application code would link.

Multiplatform support was intended but never realised. The library source structure is organised as follows.
```
  Root
  |
  +--->include/ (must be part of default include search path)
  |    |
  |    +--->xbase.hpp
  |    |
  |    +--->[library name]/
  |    |    |
  |    |    +--->[normal header or stub for plaform dependent components]
  |    |
  |    +--->plat/
  |         |
  |         +--->[platform name]/
  |              |
  |              +--->base.hpp
  |              |
  |              +--->[library name]/
  |                   |
  |                   +--->[platform dependent header]
  |
  +--->libsrc/ (library source code)
       |
       +--->common/
       |    |
       |    +--->xbase.cpp
       |    |
       |    +--->[library name]/
       |         |
       |         +--->[platform indepenent source]
       |
       +--->plat/
            |
            +--->[platform name]/
                 |
                 +--->[library name]
                 |    |
                 |    +--->[platform dependent source]
                 |
                 +--->[compiler projects, lib files etc]
```
