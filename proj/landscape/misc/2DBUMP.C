//-------------------------------------
// Coloured 2D Bump Mapping           |
// Coded By Dilwyn Thomas aka PSX     |
// Date :  21/01/98                   |
// Using Watcom C Ver 10.6            |
//-------------------------------------

#include <stdlib.h>
#include <stdio.h>
#include <conio.h>
#include <math.h>
#include "demo256.c"
#include "mouse.c"

unsigned short int mousex,mousey,button;
unsigned char *lightmap,*virtmem2,*coltable,*virtmem3;

void generate_2D_Bump(void)
{
        int x,y;
        float nX,nY,nZ; // normals

        for (y=0;y<256;y++)
        {
                for (x=0;x<256;x++)
                {
                        nX=(x-128)/128.0;
                        nY=(y-128)/128.0;
                        nZ=1-sqrt((nX*nX)+(nY*nY));
                        if (nZ<0) nZ=0;                        
                        lightmap[(y*256)+x]=(char)((nZ*255));                            
                }
        }
}

void do_2D_bump(void)
{
        int x,y;        
        int nx,ny;
        int rx,ry;
        int i;

        i=320*1;

        get_mouse_status(&mousex,&mousey,&button);

        for (y=1;y<198;y++)
        {
                for (x=0;x<320;x++)
                {
                        nx=virtmem3[i+1]-virtmem3[i-1];
                        ny=virtmem3[i+320]-virtmem3[i-320];

                        rx=x - mousex;
                        ry=y - mousey;
                        nx-=rx;
                        ny-=ry;

                        nx+=128;
                        ny+=128;
                        if (nx>255 || nx<0) { nx=255; }
                        if (ny>255 || ny<0) { ny=255; }
                        virtmem2[i]=coltable[(virtmem[i]*256)+(lightmap[(ny*256)+nx])];
                        i++;
                };
        }
}

void main(void)
{   
    init_mouse(&button);
    virtmem  = (char *)malloc(65535);
    virtmem2 = (char *)malloc(65535);
    virtmem3 = (char *)malloc(65535);        
    lightmap = (char *)malloc(65535);
    coltable = (char *)malloc(65535);
    memset(virtmem2,0, 65535);
    
    load_pcx("vf2bw.pcx",virtmem3,palette);
    load_pcx("vf2.pcx",virtmem,palette);
    load_fog("fog.tbl",coltable);
    graphics_mode(0x13);
    set_mouse_pos(160,100);
    setpal(palette);
    generate_2D_Bump();

    do
    {
                do_2D_bump();
                flip_screens(virtmem2,vgamem);
    }while(button!=right_button);
    graphics_mode(0x3);
    free(virtmem);
    printf("2D Coloured Bump Mapping - Coded By Dilwyn Thomas (PSX)\n");
}


