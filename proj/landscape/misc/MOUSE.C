#include <dos.h>
#include <i86.h>

#define mouse_int 0x33
#define left_button   1
#define right_button  2
#define middle_button 4

int xdiff;

void mouse(unsigned short int function_number,
            unsigned short int *bx,
            unsigned short int *cx,
            unsigned short int *dx)
{
        union REGS iregs,oregs;

        iregs.w.ax=function_number;
        iregs.w.bx=*bx;
        iregs.w.cx=*cx;
        iregs.w.dx=*dx;
        int386(mouse_int, &iregs, &oregs);
        *bx = oregs.w.bx;
        *cx = oregs.w.cx;
        *dx = oregs.w.dx;
}



unsigned short int init_mouse(unsigned short int *button)
{
           unsigned short int temp;     
           unsigned short int *dummy;      
           unsigned short int *ax;
           unsigned short int val;
           dummy = &temp;
           ax = &val;
           mouse(0,ax,button,dummy);
           xdiff=640 /319;
//           val = *ax;
           return(val);
}

void display_mouse(void)
{
        unsigned short int temp;     
        unsigned short int *dummy;
        dummy = &temp;       
        mouse(1,dummy,dummy,dummy);
}

void hide_mouse(void)
{
        unsigned short int temp;     
        unsigned short int *dummy;
        dummy = &temp;       
        mouse(2,dummy,dummy,dummy);
}

void get_mouse_status(unsigned short int *xmouse,unsigned short int *ymouse,unsigned short int *button_status)
{
        unsigned short int mx,my,but_stat;
        mouse(3,&but_stat,&mx,&my);
        *button_status = but_stat;
        *ymouse = my;
        *xmouse = (unsigned short)(mx / xdiff);
}


void set_mouse_pos(unsigned short int x,unsigned short int y)
{
        unsigned short int temp;     
        unsigned short int *dummy;
        dummy = &temp;       
        x = x * xdiff;
        mouse(4,dummy,&x,&y);
}



void mouse_limits(unsigned short int xmin,
                   unsigned short int ymin,
                   unsigned short int xmax,
                   unsigned short int ymax)
{
        unsigned short int temp;     
        unsigned short int *dummy;
        dummy = &temp;
        
        xmin = xmin*xdiff;
        xmax = xmax*xdiff;
        mouse(7,dummy,&xmin,&xmax);
        mouse(8,dummy,&ymin,&ymax);

}

