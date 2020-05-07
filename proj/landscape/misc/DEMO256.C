#include <dos.h>
#include <stdio.h>
#include <time.h>
#include <conio.h>
#include <process.h>
#include <math.h>

typedef struct
{
        unsigned char r,g,b;
} pal;


pal palette[256];
int gfx_screen_width = 320;
int gfx_screen_height = 200;
char *textmem;
int font_width = 6;
int font_height = 6;
int font_screen_width;
int font_screen_height;
int font_xpos;
int font_ypos;

int current_time,previous_time;
char *virtmem;
char *virtmem2;
char *vgamem =(char *) 0xA0000;
int start_clock_tick,end_clock_tick,frame_counter;


void display_comiler_details(void)
{
    #ifdef __WATCOMC__
        printf("\nUsing 32-bit compiler Watcom C version %d.%d.",
        (__WATCOMC__)/100,(__WATCOMC__%100));
    #endif
    printf("\nLast compiled %s %s.\n",__DATE__,__TIME__);    
}

void putpixel(int x,int y,unsigned char col)
{
    char *screenpointer;
    screenpointer = virtmem;
    screenpointer+=((y*320)+x);
    *screenpointer=col;
}



void graphics_mode(unsigned short int);
#pragma aux graphics_mode = \
  "int  10h                "\
   parm [ax]                \
   modify [ax];

void flip_screens(char *source,char *dest);
#pragma aux flip_screens = \
  "mov  ecx,16000"         \
  "cld"                    \
  "rep  movsd"             \
   parm [esi] [edi]        \
   modify [eax ecx];




void put_pixle(char x,char y,char col,char *dest);
#pragma aux put_pixle    = \
  "mov ebx,eax"              \
  "shl ebx,8"               \
  "shl eax,6"               \
  "add ebx,eax"              \
  "add ebx,edx"              \
  "add edi,ebx"              \
  "mov eax,ecx"              \
  "mov [edi],eax"           \
   parm [edx] [eax] [ecx] [edi]        \
   modify [eax ebx ecx edx edi];

int get_pixle(char x,char y,char *source)
{
    char *s;
    s=source;
    s+=((y*320)+x);
    return (char)(*s);

}

void start_fps(void)
{
        start_clock_tick=clock();
        frame_counter=0;

}

void end_fps(void)
{
        end_clock_tick=clock();
//        cprintf("Coded By Dilwyn Thomas (aka PSX) - Future Shock\r\n");
//        cprintf("%5.2f Frames Per Second\r\n", ((float)(frame_counter*CLK_TCK))/(end_clock_tick-start_clock_tick));
}


void setdacrgb(char col,char r,char g,char b)
{
   outp(0x3c8,col);
   outp(0x3c9,r);
   outp(0x3c9,g);
   outp(0x3c9,b);
}


void setpal(pal *palptr)
{
        int count;

        for (count = 0;count <=255;count++)
        {
                setdacrgb(count,palptr[count].r,palptr[count].g,palptr[count].b);
        }
}




long filesize(FILE *stream)
{
   long curpos, length;

   curpos = ftell(stream);
   fseek(stream, 0L, 2);
   length = ftell(stream);
   fseek(stream, curpos, SEEK_SET);
   return length;
}

void spancolours(unsigned int start,
                 unsigned int finish,
                 unsigned int sr,
                 unsigned int sg,
                 unsigned int sb,
                 unsigned int fr,
                 unsigned int fg,
                 unsigned int fb)
{

int shade,colour_number;

        shade=0;

        for (colour_number = start;colour_number <=finish;colour_number++)
        {

            setdacrgb((colour_number),
                      (((fr-sr) * shade / (finish-start))+sr),
                      (((fg-sg) * shade / (finish-start))+sg),
                      (((fb-sb) * shade / (finish-start))+sb));
                shade++;
        }
}




void load_pcx(char *filename,unsigned char *dest,pal *palptr)
{
      FILE *infile;
      long i;
      unsigned short int c;
      long file_size;
      unsigned int x;

      infile = fopen (filename, "rb");
      file_size = (filesize(infile)-(768+128));
      fseek (infile,128L,SEEK_SET);

      for (i = 0; i < (file_size);)
      {
           c = fgetc (infile) & 0xff;
           i++;

           if ((c & 0xc0) == 0xc0)
           {
                x = c & 0x3f;
                c = fgetc (infile);
                i++;

                while (x--)
                {
                     *dest = c;
                      dest++;
                }
           }
           else
           {
                *dest = c;
                 dest++;

           }
      }

      fseek(infile,-768L,2);
      for (i = 0; i <255;i++)
      {
             c = fgetc (infile);
             palptr[i].r = (c >> 2);
             c = fgetc (infile);
             palptr[i].g = (c >> 2);
             c = fgetc (infile);
             palptr[i].b = (c >> 2);
      }

      fclose (infile);
}


void create_gourad(char *dest,pal *palptr)
{
        int count,shade,count3;
        unsigned char r,g,b;
        int search_r,search_g,search_b;
        int abs_dif,smallest_difference;
        int closest_col_match;

        printf("Creating Fog table :");

        for (count = 0;count <=255;count++)
        {
                r=palptr[count].r;
                g=palptr[count].g;
                b=palptr[count].b;

                for (shade=0;shade<=63;shade++)
                {
                        search_r=(r*shade)/63;
                        search_g=(g*shade)/63;
                        search_b=(b*shade)/63;

                        smallest_difference=768;

                        for (count3=0;count3<=255;count3++)
                        {
                                abs_dif=(abs(palptr[count3].r-search_r)+
                                         abs(palptr[count3].g-search_g)+
                                         abs(palptr[count3].b-search_b));

                                if (abs_dif < smallest_difference)
                                {
                                        smallest_difference=abs_dif;
                                        closest_col_match=count3;
                                }

                        }
                        *dest=closest_col_match;
                        dest++;
                        putpixel(count,50+shade,closest_col_match);
                        if (1==(count && 3))
                        {
                                printf(".");
                        }
                }
        }
        printf("\n");                                   
}




unsigned char BestColour(float r, float g, float b,pal *palette)
{
        int             n;
        unsigned char  bestcol = 0;
        float           bestdist = 256000.0;
        float           dist, rdist, gdist, bdist;
             

        for(n=0;n<=255;n++)
        {
            rdist = (float)palette[n].r - r;
            gdist = (float)palette[n].g - g;
            bdist = (float)palette[n].b - b;                        
            dist = sqrt(rdist*rdist+gdist*gdist+bdist*bdist);

            if (dist < bestdist)
            {
                bestdist =dist;
                bestcol = (char)n;
            }
        }
        return (bestcol);
}        


void Generate_Fog_Table(float r, float g, float b,char *dest,pal *pallete)
{
        int shade,col_num;
        float pr,pg,pb;
        float sr,sb,sg;


        for (col_num=0;col_num<=255;col_num++)
        {
                pr = (float)pallete[col_num].r;
                pg = (float)pallete[col_num].g;
                pb = (float)pallete[col_num].b;                                
                                
                for (shade=0;shade<=255;shade++)                
                {
                        sr = pr+(((r-pr)*(float)shade)/256.0);
                        sg = pg+(((g-pg)*(float)shade)/256.0);
                        sb = pb+(((b-pb)*(float)shade)/256.0);                              
                        *dest=BestColour(sr,sg,sb,palette);
                        dest++;
                        
                }
                put_pixle(40+col_num,100,col_num,vgamem);                
        }
}

void load_fog(char *filename,unsigned char *dest)
{
      FILE *infile;
      long file_size;

      infile = fopen (filename, "rb");
      file_size = (filesize(infile));
      fseek(infile,SEEK_SET, 0);
      fread(dest,file_size,1,infile);      
}



void init_gfxtext(void)
{
    textmem = (char *)malloc(65535);
    memset(textmem,0, 65535);
    load_pcx("font.pcx",textmem,palette);
    setpal(palette);
    font_xpos = 0;
    font_ypos = 0;
    font_screen_width = gfx_screen_width/font_width;
    font_screen_height = gfx_screen_height/font_height;
    current_time  = 0.0;
    previous_time = 0.0;
}

void gotoxy(int xpos,int ypos)
{
        font_xpos = xpos;
        font_ypos = ypos;
}


void outchar(int ch,char *dest)
{
        char *src;
        int div = font_screen_width;
        int mod = gfx_screen_width / font_height;

        int src_font_y = font_height * (ch / div);
        int src_font_x = font_width * (ch % mod);

        int x = font_xpos * font_width;
        int y = font_ypos * (font_height+2);

        int nextline = gfx_screen_width-font_width;
        char col;

        int lx,ly;

        dest += (y*gfx_screen_width)+x;
        src = textmem;
        src += (src_font_y * gfx_screen_width)+src_font_x;

        for (ly=0; ly < font_height; ly++)
        {
                for (lx=0; lx < font_width; lx++)
                {
                        col = *src;
                        if (col !=0)
                        {
                               *dest=col;
                        }
                        src++;
                        dest++;
                }
                src+=nextline;
                dest+=nextline;
        }
        font_xpos++;
}

void outnumber(int num,char *dest)
{
    int div;
    int mag;

    mag  =1;

    while ((mag * 10) <= num)
    {
        mag *=10;
    }
    
    while (mag > 0)
    {
        div = num/mag;
        num = num % mag;
        mag/=10;
        outchar(div+'0',dest);
    }
}


void outstring(char *string,char *dest)
{
        int length;
        int c;
        char ch;
        
        length = strlen(string);

        for(c=0;c<length;c++)
        {
                ch = string[c];                
                outchar(ch,dest);
        }
}


void display_3D_Engine_Stats(int poly_drawn_count,char *dest)
{
        int fps;
        
        current_time = clock();
        gotoxy(1,1);
        outstring("Frame Counter         : ",dest);
        fps = (int)((float)(CLK_TCK)/(float)((current_time-previous_time)+0.001));
        outnumber(fps,dest);
        previous_time = current_time;
        gotoxy(1,2);
        outstring("Polys Drawn Per Frame : ",dest);
        outnumber(poly_drawn_count,dest);
        gotoxy(1,3);
        outstring("Polys Per Second      : ",dest);
        outnumber(fps*poly_drawn_count,dest);
}



