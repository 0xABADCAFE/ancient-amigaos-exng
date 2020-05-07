#include <conio.h>
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <dos.h>
#include <malloc.h>
#include <string.h>
#include "demo256.C"


void main(int argc, char *argv[])
{
          int i2,i;
          char *fogtable;
          char *fogtable2;
          char *fogtable3;          
          FILE *stream;

          if (argc < 2) {
                printf("\nColour Table Generator Coded by            Dilwyn Thomas aka PSX");
                printf("\n----------------------------------------------------------------\n\n");                
                printf("Usage: GCOLTBL file.PCX\n");
                exit(1);
          }

          if ((stream = fopen("FOG.TBL", "wb")) == NULL) /* open FOG.TBL */
          {
                fprintf(stderr, "Cannot open output file.\n");
          }


          virtmem = (char *)malloc(65535);
          fogtable = (char *)malloc(65535);
          fogtable2 = (char *)malloc(65535);
          fogtable3 = (char *)malloc(65535);
          
          memset(virtmem,0, 65535);
          memset(fogtable,0, 65535);
          memset(fogtable2,0, 65535);
          memset(fogtable3,0, 65535);                              
          
          graphics_mode(0x13);
          load_pcx(argv[1],virtmem,palette);
          setpal(palette);
          memset(virtmem,0, 65535);
          flip_screens(virtmem,vgamem);

          Generate_Fog_Table(63,63,63,fogtable,palette);
          Generate_Fog_Table(0,0,0,fogtable2,palette);
          
          for (i=0;i<256;i++)
          {
                for (i2=0;i2 < 128;i2++)
                {
                        fogtable3[(i*256)+i2]       = fogtable2[(i*256)+((127-i2)*2)];
                        fogtable3[(i*256)+(i2+128)] = fogtable [(i*256)+(i2*2)];
                }        
          }

          for (i=0;i<199;i++)
          {
                for (i2=0;i2 < 256;i2++)
                {
                        put_pixle(i2,i,fogtable3[(i*256)+i2],vgamem);
                }        
          }
          
          getche();
          fwrite(fogtable3,65535, 1, stream);
          free(virtmem);
          graphics_mode(0x3);
          fclose(stream); /* close file */
}

