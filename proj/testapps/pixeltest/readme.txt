Pixeltest

eXtropia Studios gfxlib pixel conversion benchmarking tool This software is part of the exng C++ framework test code. May contain all sorts of weirdness, use at own risk.

Overview:

Performs a series of tests to determine VRAM access speeds and RGB pixel format conversion. 8-bit displays are not supported by this application.

Usage (all optional arguments are in square brackets)

pixeltest [lock] [width <w>] [height <h>] [fullscreen <d>] [fmt <f>] 

lock : disables task switching and / or interrupts during test iterations
width : width in pixels (320-1024), default is 640
height : height in pixels (240 - 768), default is 480
fullscreen : use fullscreen (depth d) instead of windowed, default is windowed

fmt : source data format for conversion testing, default is same as present display. Valid options are

RGB15B, RGB15L, BRG15B, BGR15L
RGB16B, RGB16L, BGR16B, BGR16L
RGB24P, BGR24P
ARGB32B, ARGB32L, ABGR32B, ABGR32L

suffix : B = big endian, L = little endian, P = byte packed (24-bit only). Format names are not case sensitive.


Notes:

1) Destination (display surface) data format is always determined by the platform, only depth can be specified for fullscreen displays. Windowed mode requires at least a 15 bit desktop. The pixel format information for source data and destination data are reported in the output.

2) When specifying a custom pixel format that is not the same as the display format, make no assumption about the visual appearence of the data in "copy" mode - only the conversion test will show the expected gradients.

Amiga (68K/OS3 build) notes:

1) The framework library is compiled for 68020/FPU as a minimum base. Hence all applications require this.

2) The gfxlib section only supports RTG modes.

3) CPU::getCPU() is called to obtain the name of the installed processor. If the processor is a 68040 or a 68060, additional memory bandwidth tests using the move16 instruction will be performed in addition to the normal read/write/copy tests. Some pixel corruption has been observed on some platforms (my BPPC for one) when using move16 to clear/shufflecopy. The code will ask if you observed any glitching (eg a small span of corrupted pixels here and there) after each of these tests.