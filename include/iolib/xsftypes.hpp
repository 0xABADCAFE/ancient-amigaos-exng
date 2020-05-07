//****************************************************************************//
//**                                                                        **//
//** File:         include/IOLib/xsfio.hpp                                  **//
//** Description:  XSF IO classes                                           **//
//** Comment(s):   Stub header                                              **//
//** Library:      IO                                                       **//
//** Created:      2003-02-10                                               **//
//** Updated:      2003-02-10                                               **//
//** Author(s):    Karl Churchill                                           **//
//** Note(s):                                                               **//
//** Copyright:    (C)1996-2003, eXtropia Studios                           **//
//**               Serkan YAZICI, Karl Churchill                            **//
//**               All Rights Reserved.                                     **//
//**                                                                        **//
//****************************************************************************//

#ifndef _EXTROPIA_IO_XSFIO_TYPES_HPP
#define _EXTROPIA_IO_XSFIO_TYPES_HPP

typedef enum {
// eXtropia reserved superclass id values
  T_none            = 0x0000,
  T_system          = 0x0001,
  T_resource         = 0x0002,
  T_exec_bin        = 0x0003,
  T_exec_script      = 0x0004,
  T_property        = 0x0005,
  T_text_raw        = 0x0100,
  T_text_format      = 0x0101,
  T_sound            = 0x0200,
  T_sound_seq        = 0x0201,
  T_image_raster    = 0x0300,
  T_image_vector    = 0x0301,
  T_anim_seq        = 0x0302,
  T_anim_stream      = 0x0303,
  T_3D_object        = 0x0304,
  T_3D_scene        = 0x0305,
  T_3D_seq          = 0x0306,
  T_feedback        = 0x0F00,
  T_gustatory        = 0x0F01,
  T_olfactory        = 0x0F02,
  T_immersion        = 0x0F03,
  T_sensenviron      = 0x0F04, // U know it :)
  T_archive          = 0x0FFF,
  T_binary          = 0x7FFF
} XSFSuperClassID;

typedef enum {
  // eXtropia reserved subclass id values
  // defaults
  T_all                  = 0x0000,
  T_EMBED                = 0x7FFF,
  // XSF file system
  T_chunkIndexMin       = 0x0001,
  T_chunkIndex          = 0x0002,
  T_nameIndex            = 0x0003,
  T_freeSpace            = 0x0004,
  // resource
  T_xLUT                = 0x0001, // Any form of multidimensional array data
  T_xDAT                = 0x0002, // Simple database
  T_xDBASE              = 0x0003, // Database
  T_xGUI                = 0x0004, // eXtropia User Interface description
  T_xDLG                = 0x0005, // eXtropia Window Definition
  // exec_bin
  T_external_app        = 0x0001, // external program
  T_external_lib        = 0x0002, // external library
  T_external_drv        = 0x0003, // external driver
  T_external_java_app    = 0x0011, // java standard applet
  T_external_java_lib    = 0x0012, // java function library
  T_external_java_drv    = 0x0013, // java driver
  T_internal_java_app    = 0x0021, // embedded java applet
  T_internal_java_lib    = 0x0022, // embedded java library
  T_internal_java_drv    = 0x0023, // embedded java driver
  T_internal_x86_app    = 0x0031, // cf. 80x86
  T_internal_x86_lib    = 0x0032, //
  T_internal_x86_drv    = 0x0033, //
  T_internal_ppc_app    = 0x0041, // cf. PowerPC
  T_internal_ppc_lib    = 0x0042, //
  T_internal_ppc_drv    = 0x0043, //
  T_internal_68k_app    = 0x0051, // cf. 680x0
  T_internal_68k_lib    = 0x0052, //
  T_internal_68k_drv    = 0x0053, //
  T_internal_elt_app    = 0x0061, // cf. elate(tm)
  T_internal_elt_lib    = 0x0062, //
  T_internal_elt_drv    = 0x0063, //
  T_internal_xvm        = 0x0071,

  // exec_script
  T_xEVENT              = 0x0001, //
  // property
  T_sheet                = 0x0001,
  T_init                = 0x0002,
  T_destroy              = 0x0003,
  T_control              = 0x0004,
  // text_raw
  T_ASCII7              = 0x0001,
  T_ASCII8              = 0x0002,
  T_IBMCS                = 0x0003,
  T_UNICODE              = 0x0010,
  T_KANJII              = 0x0011,
  T_ARABIC              = 0x0012,
  T_HEBREW              = 0x0013,
  // text_format
  T_xTEXT                = 0x0001,
  T_XDOC                = 0x0002,
  T_xHYPE                = 0x0003,
  // sound
  T_xPCM                = 0x0001,
  T_xDAC                = 0x0002,
  T_xFDA                = 0x0003,
  // sound_seq
  T_xASEQ                = 0x0001,
  T_xMUSEQ              = 0x0002,
  // image_raster
  T_xBIT                = 0x0001,
  T_xIMG                = 0x0002,
  T_xCUR                = 0x0003,
  T_xFONT                = 0x0004,
  T_xFRAME              = 0x0005,
  T_xTEXTUREMAP          = 0x0006,
  // image_vector
  T_xVEC                = 0x0001,
  // anim_seq
  T_xANIM                = 0x0001,
  // anim_stream
  T_xVIDEO              = 0x0001,
  // 3D_object
  T_xMODEL              = 0x0001,
  // 3D_scene
  T_xSCENE              = 0x0001,
  // 3D_seq
  T_x3DSEQ              = 0x0001,
  // feedback
  T_xFORCE              = 0x0001,
  // archive
  T_xCAT                = 0x0001,
  // binary
  T_xBIN                = 0x0001,
  T_xHEX                = 0x0002
} XSFSubClassID;

#endif
