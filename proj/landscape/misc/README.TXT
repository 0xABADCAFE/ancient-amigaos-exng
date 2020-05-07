---------------------------------------------------------------------
2D Coloured Bump Mapping
---------------------------------------------------------------------
Coded By Dilwyn Thomas aka PSX
using Watcom C Ver 10.6
Date : 21/1/98

Email : PSX2@rocketmail.com

---------------------------------------------------------------------
This is a simple little 2D Colured bump mapping program. I havent
seen any demos in ages, then I saw this nifty effect on an Amiga demo,
so I decided to code one up in a extream rush which took about an hour
so the code in not optimized or anything but as its pure c its fairly
easy to understand as its less than 90 lines of code. As its colured
you need two copies of the picture your going to bump map , the first
is the normal picture with all the colours in it and the second is a
gray scaled version. This is because the the grey scaled version is
used to give us the hights of each pixel in the picture which will give
us the bumpy effect. As its a coloured 2D bump mapper a colour table is
needed for the coloured version. To get this run the program
<gcoltbl filename.pcx> which will generate the colour table for that
picture. For each colour in the picture it generated a 256 colour scale,
The first 128 is from Black to that colour and the next 128 if from that
colour to white.

Files :

        2DBump.c        :       The 2D bump mapping source code
        demo256.c       :       General Graphics library
        mouse.c         :       General Mouse routines
        gfogtbl.c       :       The colour table generator

                               
The Virtua fighter 2 picture is (C) Copyright of Sega.


Please spread this source.

If have any questions, any cool ideas or some effect you want coded,
or anything don't hesitate to mail me the above email address.

