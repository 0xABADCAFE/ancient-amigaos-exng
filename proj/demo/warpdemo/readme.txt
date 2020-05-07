Hi,

Since this is simply a test program for part of a much larger project, there wasn't any manual :-) So I quicky cobbled together this...

Description

Simple test of Rasterizer class. A window showing the specified image is opened and can be distorted realtime with the mouse. What basically happens is that the image is wrapped onto a 2D mesh of vertices that are moved around to distort the image

Usage (for people who dont read manuals)

warp image arnie.jpg scale 2


Usage (proper)

warp [mesh <dimension>] [scale <factor>] image <file>

mesh <dimension>

Sets the mesh dimension (an integer value), larger meshes give finer adjustments but are slower. Value is clipped from 4 - 128, default is 16. Larger values can slow down considerably depending on your CPU / 3D processor.

scale <factor>

Sets the default scale factor. The window size is the size of the image multiplied by this value. Value is clipped from 1.0 to 8.0, default is 1.0

image <file>

The source image to use. Can be any datatype you have a descriptor for and must be a power of 2 in width / height.

Control

Left mouse : pulls the image in towards the pointer
Right mouse : blows the image out away from the pointer

F1 : restores the original image
F2 : restores the warp strength
F3 : increases the warp strength
F4 : decreases the warp strength
F5 : gradually restores the original image
F6 : toggle drag / zoom mode
F7 : show mesh
F9 : rotate
F10 : rotate

Keypad + : zoom in
Keypad - : zoom out
Cursor Left : scroll left
Cursor Right : scroll right
Cursor Up : scroll up
Cursor Down : scroll down
Esc : exits program

The drag mode is a bit naff, but the zoom mode works ok. I have included three
images for your viewing amusement. Source is also included but pretty useless
without the my C++ layer it is built upon. You might find it interesting though.

You'll need to use a screen grabber to capture your distorted masterpieces :-)

Have fun,

Karl