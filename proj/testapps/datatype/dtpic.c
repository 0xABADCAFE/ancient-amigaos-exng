/* Programmname                                                             */

/*--------------------------------------------------------------------------*/
/* System Includes                                                          */
/*--------------------------------------------------------------------------*/

#include <clib/exec_protos.h>
#include <clib/alib_protos.h>
#include <clib/graphics_protos.h>
#include <clib/intuition_protos.h>
#include <clib/datatypes_protos.h>
#include <clib/dos_protos.h>
#include <clib/utility_protos.h>
#include <exec/memory.h>
#include <datatypes/pictureclass.h>

#include <stdlib.h>
#include <stdio.h>
#include <string.h>

/*--------------------------------------------------------------------------*/
/* Konstanten und Makros                                                    */
/*--------------------------------------------------------------------------*/

/*--------------------------------------------------------------------------*/
/* Typdefinitionen                                                          */
/*--------------------------------------------------------------------------*/

struct Picture {
	short w;
	short h;
	short d;
	struct BitMap *bm;
	short ncols;
	ULONG *cregs;
};

/*--------------------------------------------------------------------------*/
/* Globale Variablen                                                        */
/*--------------------------------------------------------------------------*/

short brk = 0;
short debug = 0;

/*--------------------------------------------------------------------------*/
/* Prototypen                                                               */
/*--------------------------------------------------------------------------*/

/*--------------------------------------------------------------------------*/
/* CTRL-C handling                                                          */
/*--------------------------------------------------------------------------*/

int chk_brk()
{
	brk = 1;
	return (0);
}

/*--------------------------------------------------------------------------*/
/*                                                                          */
/*--------------------------------------------------------------------------*/

struct BitMap *copy_bitmap(struct BitMap *oldbm)
{
	struct BitMap *newbm;
	long w,h;

	if (newbm = AllocBitMap(
		w = GetBitMapAttr(oldbm,BMA_WIDTH),
		h = GetBitMapAttr(oldbm,BMA_HEIGHT),
		GetBitMapAttr(oldbm,BMA_DEPTH),
		GetBitMapAttr(oldbm,BMA_FLAGS),
		NULL))
	{
		BltBitMap (oldbm, 0, 0, newbm, 0, 0, w, h, 0x0c0, 0xff, NULL);
	}
	return newbm;
}

/*--------------------------------------------------------------------------*/
/*                                                                          */
/*--------------------------------------------------------------------------*/

struct Picture *load_pic(char *name)
{
	struct Picture *pic = NULL;
	Object *o;
	struct BitMapHeader *bmhd;
	struct BitMap *dtbm;
	ULONG ncols;
	ULONG *cregs;
	long i;

	if (o = NewDTObject(name, DTA_GroupID, GID_PICTURE, PDTA_Remap, FALSE, TAG_END))
	{
		i = DoMethod(o, DTM_PROCLAYOUT, NULL, 1);
		printf("PROCLAYOUT = %d\n", i);
		GetDTAttrs(o, PDTA_BitMapHeader, &bmhd, PDTA_BitMap, &dtbm, PDTA_NumColors, &ncols, PDTA_CRegs, &cregs, TAG_END);

		if (pic = AllocMem(sizeof(struct Picture), MEMF_CLEAR))
		{
			pic->bm    = copy_bitmap(dtbm);
			pic->w     = bmhd->bmh_Width;
			pic->h     = bmhd->bmh_Height;
			pic->d     = GetBitMapAttr(pic->bm, BMA_DEPTH);
			pic->ncols = ncols;
			if (pic->cregs = AllocMem(12*pic->ncols, 0))
				memcpy(pic->cregs, cregs, 12*pic->ncols);
		}
		DisposeDTObject(o);
	}
	else
		PrintFault(IoErr(),NULL);
	return pic;
}

/*--------------------------------------------------------------------------*/
/*                                                                          */
/*--------------------------------------------------------------------------*/

struct Picture *load_clip(void)
{
	struct Picture *pic = NULL;
	Object *o;
	struct BitMapHeader *bmhd;
	struct BitMap *dtbm;
	ULONG ncols;
	ULONG *cregs;

	if (o = NewDTObject(0, DTA_SourceType, DTST_CLIPBOARD, DTA_GroupID, GID_PICTURE, PDTA_Remap, FALSE, TAG_END))
	{
		DoMethod(o, DTM_PROCLAYOUT, NULL, 1);
		GetDTAttrs(o, PDTA_BitMapHeader, &bmhd, PDTA_BitMap, &dtbm, PDTA_NumColors, &ncols, PDTA_CRegs, &cregs, TAG_END);

		if (pic = AllocMem(sizeof(struct Picture), MEMF_CLEAR))
		{
			pic->bm    = copy_bitmap(dtbm);
			pic->w     = bmhd->bmh_Width;
			pic->h     = bmhd->bmh_Height;
			pic->d     = GetBitMapAttr (pic->bm,BMA_DEPTH);
			pic->ncols = ncols;
			if (pic->cregs = AllocMem(12*pic->ncols, 0))
				memcpy(pic->cregs, cregs,12*pic->ncols);
		}
		DisposeDTObject(o);
	}
	else
		PrintFault(IoErr(), NULL);
	return pic;
}

/*--------------------------------------------------------------------------*/
/*                                                                          */
/*--------------------------------------------------------------------------*/

void save_pic(struct Picture *pic,char *name)
{
	Object *o;
	struct BitMapHeader *bmhd;
	struct BitMap *bm;
	UBYTE *cmap;
	long i;
	BPTR fhand;

	if (bm = copy_bitmap (pic->bm))
	{
		if (o = NewDTObject(NULL, DTA_SourceType, DTST_RAM, DTA_GroupID, GID_PICTURE,
				PDTA_BitMap, bm, PDTA_NumColors, (LONG)pic->ncols, PDTA_ModeID, 0,
				TAG_END))
		{
			GetDTAttrs(o, PDTA_BitMapHeader, &bmhd, PDTA_ColorRegisters, &cmap, TAG_END);

			bmhd->bmh_Width  = pic->w;
			bmhd->bmh_Height = pic->h;
			bmhd->bmh_Depth  = pic->d;

			for (i = pic->ncols*3-1; i >= 0; i--)
				cmap[i] = pic->cregs[i] >> 24;

			if (fhand = Open(name, MODE_NEWFILE))
			{
				i = DoMethod(o, DTM_WRITE, NULL, fhand, DTWM_IFF, TAG_END);
				PrintFault(IoErr(),NULL);
				Close(fhand);
				if (!i)
				{
					printf("write failed\n");
					DeleteFile(name);
				}
			}
			else
				PrintFault(IoErr(), "cannot open output file");
			DisposeDTObject (o);
		}
		else
			FreeBitMap (bm);
	}
}

/*--------------------------------------------------------------------------*/
/*                                                                          */
/*--------------------------------------------------------------------------*/

void clip_pic(struct Picture *pic)
{
	Object *o;
	struct BitMapHeader *bmhd;
	struct BitMap *bm;
	UBYTE *cmap;
	long i;

	if (bm = copy_bitmap(pic->bm))
	{
		if (o = NewDTObject(NULL, DTA_SourceType, DTST_RAM, DTA_GroupID, GID_PICTURE,
				PDTA_BitMap, bm, PDTA_NumColors, (LONG)pic->ncols, PDTA_ModeID, 0, TAG_END))
		{
			GetDTAttrs(o, PDTA_BitMapHeader, &bmhd, PDTA_ColorRegisters, &cmap, TAG_END);
			bmhd->bmh_Width  = pic->w;
			bmhd->bmh_Height = pic->h;
			bmhd->bmh_Depth  = pic->d;
			for (i = pic->ncols*3-1; i >= 0; i--)
				cmap[i] = pic->cregs[i] >> 24;
			DoMethod (o, DTM_CLEARSELECTED, NULL);
			DoMethod (o, DTM_COPY, NULL);
			DisposeDTObject(o);
		}
		else
			FreeBitMap(bm);
	}
}

/*--------------------------------------------------------------------------*/
/*                                                                          */
/*--------------------------------------------------------------------------*/

long min(long a,long b)
{
	if (a < b)
		return (a);
	return (b);
}

/*--------------------------------------------------------------------------*/
/* Construct Name for ModeID                                                */
/*--------------------------------------------------------------------------*/

BOOL NameMode(ULONG modeID, STRPTR result)
{
	struct NameInfo nameInfo;
	struct DisplayInfo dispInfo;
	struct DimensionInfo dimInfo;
	struct MonitorInfo monInfo;
	char buffer[DISPLAYNAMELEN + 1];
	UWORD len;
	DisplayInfoHandle dh;

	result[0] = 0;

	dh = FindDisplayInfo(modeID);
	if (GetDisplayInfoData(dh, (APTR) &dispInfo, sizeof(struct DisplayInfo),
							DTAG_DISP, INVALID_ID), INVALID_ID)
	{
		if (!dispInfo.NotAvailable)
		{
			if (GetDisplayInfoData (dh, (APTR) &dimInfo, sizeof(struct DimensionInfo),
									DTAG_DIMS, INVALID_ID))
			{
				/* Get name or make one if no name available */
				if (GetDisplayInfoData(dh, (APTR) &nameInfo,sizeof(struct NameInfo),
										DTAG_NAME, INVALID_ID))
				{
					strcpy (result, nameInfo.Name);
					return TRUE;
				}
				else
				{
					if (GetDisplayInfoData (dh, (APTR) &monInfo, sizeof(struct MonitorInfo),
											DTAG_MNTR, INVALID_ID))
					{
						if ((monInfo.Mspc) && (monInfo.Mspc->ms_Node.xln_Name))
						{
							strcpy(buffer, monInfo.Mspc->ms_Node.xln_Name);
							len = strlen(buffer);
							if ((len > 8) && (Strnicmp(&buffer[len - 8], ".monitor", len - 8) == 0))
							{
								buffer[len - 8] = 0;
								len -= 8;
							}

							while (len > 0)
								buffer[--len] = ToUpper(buffer[len]);
						}
					}

					sprintf(result,"%s:%lu x %lu %s%s%s",
						buffer,
						(dimInfo.Nominal.MaxX - dimInfo.Nominal.MinX + 1),
						(dimInfo.Nominal.MaxY - dimInfo.Nominal.MinY + 1),
						(dispInfo.PropertyFlags & DIPF_IS_HAM) ? "HAM " :
						(dispInfo.PropertyFlags & DIPF_IS_EXTRAHALFBRITE) ? "EHB " : "",
						(dispInfo.PropertyFlags & DIPF_IS_PF2PRI) ? "DPF2 " :
						(dispInfo.PropertyFlags & DIPF_IS_DUALPF) ? "DPF " : "",
						(dispInfo.PropertyFlags & DIPF_IS_LACE) ? "Laced " : "", "");
					return TRUE;
				}
			}
		}
	}
	return FALSE;
}

/*--------------------------------------------------------------------------*/
/* Print Picture Datatype Attributes                                        */
/*--------------------------------------------------------------------------*/

void print_dtattrs(Object *o)
{
	long n;
	ULONG viewmode;
	struct BitMap *bm;
	struct BitMapHeader *bmhd;
	long ncols;
	UBYTE *cmap;
	ULONG *cregs;
	ULONG *gregs;
	ULONG *ctab;
	ULONG *ctab2;
	ULONG *alloc;
	long w,h;
	long nalloc;
	static char name[80];

	n = GetDTAttrs (o,
		PDTA_ModeID, &viewmode,
		PDTA_BitMapHeader, &bmhd,
		PDTA_BitMap, &bm,
		PDTA_ColorRegisters, &cmap,
		PDTA_CRegs, &cregs,
		PDTA_GRegs, &gregs,
		PDTA_ColorTable, &ctab,
		PDTA_ColorTable2, &ctab2,
		PDTA_Allocated, &alloc,
		PDTA_NumColors, &ncols,
		PDTA_NumAlloc, &nalloc,
		DTA_NominalHoriz, &w,
		DTA_NominalVert, &h,
		TAG_END);

	printf("\nn = %d\n", n);
	printf("NominalHoriz   = %d\n", w);
	printf("NominalVert    = %d\n", h);
	printf("ModeID         = 0x%x\n", viewmode);
	if (NameMode(viewmode, name))
		printf("                 %s\n", name);
	printf("BitMapHeader   = 0x%x\n", bmhd);
	printf("                 Width  = %4d     Masking     = %4d     XAspect    = %4d\n",
			bmhd->bmh_Width, bmhd->bmh_Masking, bmhd->bmh_XAspect);
	printf("                 Height = %4d     Compression = %4d     YAspect    = %4d\n",
			bmhd->bmh_Height, bmhd->bmh_Compression, bmhd->bmh_YAspect);
	printf("                 Left   = %4d     Pad         = %4d     PageWidth  = %4d\n",
			bmhd->bmh_Left, bmhd->bmh_Pad, bmhd->bmh_PageWidth);
	printf("                 Top    = %4d     Transparent = %4d     PageHeight = %4d\n",
			bmhd->bmh_Top, bmhd->bmh_Transparent, bmhd->bmh_PageHeight);
	printf("                 Depth  = %4d\n",
			bmhd->bmh_Depth);
	printf("BitMap         = 0x%x\n", bm);
	if (bm)
	printf("                 BytesPerRow = %3d     Rows = %3d     Flags = 0x%x     Depth = %3d\n",
			bm->BytesPerRow, bm->Rows, bm->Flags, bm->Depth);
	printf("ColorRegisters = 0x%x\n",cmap);
	if (cmap)
	printf("                 %02x %02x %02x  %02x %02x %02x  %02x %02x %02x  %02x %02x %02x  %02x %02x %02x  %02x %02x %02x\n",cmap[0],cmap[1],cmap[2],cmap[3],cmap[4],cmap[5],cmap[6],cmap[7],cmap[8],cmap[9],cmap[10],cmap[11],cmap[12],cmap[13],cmap[14],cmap[15],cmap[16],cmap[17]);
	printf("CRegs          = 0x%x\n", cregs);
	if (cregs)
	printf("                 %08x %08x %08x %08x %08x %08x %08x %08x %08x\n",cregs[0],cregs[1],cregs[2],cregs[3],cregs[4],cregs[5],cregs[6],cregs[7],cregs[8]);
	printf("GRegs          = 0x%x\n", gregs);
	if (gregs)
	printf("                 %08x %08x %08x %08x %08x %08x %08x %08x %08x\n",gregs[0],gregs[1],gregs[2],gregs[3],gregs[4],gregs[5],gregs[6],gregs[7],gregs[8]);
	printf("ColorTable     = 0x%x\n", ctab);
	if (ctab)
	printf("                 %08x %08x %08x %08x %08x %08x %08x %08x %08x\n",ctab[0],ctab[1],ctab[2],ctab[3],ctab[4],ctab[5],ctab[6],ctab[7],ctab[8]);
	printf("ColorTable2    = 0x%x\n", ctab2);
	if (ctab2)
	printf("                 %08x %08x %08x %08x %08x %08x %08x %08x %08x\n",ctab2[0],ctab2[1],ctab2[2],ctab2[3],ctab2[4],ctab2[5],ctab2[6],ctab2[7],ctab2[8]);
	printf("Allocated      = 0x%x\n", alloc);
	if (alloc)
	printf("                 %08x %08x %08x %08x %08x %08x %08x %08x %08x\n",alloc[0],alloc[1],alloc[2],alloc[3],alloc[4],alloc[5],alloc[6],alloc[7],alloc[8]);
	printf("NumColors      = 0x%x\n", ncols);
	printf("NumAlloc       = 0x%x\n", nalloc);
}

/*--------------------------------------------------------------------------*/
/*                                                                          */
/*--------------------------------------------------------------------------*/

void show_pic(struct Picture *pic)
{
	Object *o;
	struct BitMapHeader *bmhd;
	struct BitMap *bm;
	struct BitMap *destbm;
	struct BitMap *dtbm;
	ULONG *cregs;
	UBYTE *cmap;
	struct Screen *scr;
	struct Window *win;
	struct RastPort *rp;
	struct MsgPort *port;
	struct IntuiMessage *mess;
	long weiter;
	long i;

	if (scr = LockPubScreen(NULL))
	{
		if (bm = copy_bitmap(pic->bm))
		{
			if (destbm = AllocBitMap(pic->w, pic->h, GetBitMapAttr(scr->RastPort.BitMap, BMA_DEPTH), BMF_CLEAR, NULL))
			{
				if (o = NewDTObject(NULL, DTA_SourceType, DTST_RAM, DTA_GroupID, GID_PICTURE,
						DTA_NominalHoriz, pic->w, DTA_NominalVert, pic->h, PDTA_ModeID, 0 /* 0x29000 */,
						PDTA_BitMap, bm, PDTA_NumColors, (LONG)pic->ncols,
						PDTA_DestBitMap, destbm, PDTA_Remap, TRUE,PDTA_Screen, scr, TAG_END))
				{
					GetDTAttrs(o, PDTA_BitMapHeader, &bmhd, PDTA_ColorRegisters, &cmap, PDTA_CRegs, &cregs, TAG_END);
					bmhd->bmh_Width  = pic->w;
					bmhd->bmh_Height = pic->h;
					bmhd->bmh_Depth  = pic->d;
					bmhd->bmh_PageWidth  = pic->w;
					bmhd->bmh_PageHeight = pic->h;
					bmhd->bmh_XAspect = 1;
					bmhd->bmh_YAspect = 1;
					memcpy(cregs, pic->cregs, 12*pic->ncols);
					for (i = pic->ncols*3-1; i >= 0; i--)
						cmap[i] = cregs[i] >> 24;

					i = DoMethod(o, DTM_PROCLAYOUT, NULL, 1);
					printf("PROCLAYOUT = %d\n",i);
					PrintFault(IoErr(),"layout");

					if (debug)
						print_dtattrs(o);

					i = GetDTAttrs(o, PDTA_DestBitMap, &dtbm, TAG_END);
					printf("GetDTAttrs = %d\n",i);

					if (!dtbm)
						printf("BitMap ist NULL !!\n");
					if (dtbm == bm)
						printf("BitMaps sind gleich !!\n");

					if (win = OpenWindowTags(NULL,
								WA_CustomScreen, scr,
								WA_Left, (scr->Width - (pic->w  + scr->WBorRight + scr->WBorLeft)) >> 1,
								WA_Top, (scr->Height - (pic->h + scr->WBorTop + scr->WBorBottom)) >> 1,
								WA_InnerWidth, pic->w,
								WA_InnerHeight, pic->h,
								WA_Flags, WFLG_CLOSEGADGET|WFLG_DRAGBAR|WFLG_DEPTHGADGET|WFLG_ACTIVATE|WFLG_GIMMEZEROZERO,
								WA_IDCMP, IDCMP_MOUSEBUTTONS|IDCMP_CLOSEWINDOW|IDCMP_VANILLAKEY,
								TAG_END))
					{
						port = win->UserPort;
						rp   = win->RPort;

						BltBitMapRastPort(dtbm ? dtbm : bm, 0, 0, rp, 0, 0, min(pic->w,win->GZZWidth), min(pic->h,win->GZZHeight), 0x00c0);

						weiter = 1;

						while (weiter)
						{
							WaitPort(port);
							while (mess = (struct IntuiMessage*)GetMsg(port))
							{
								switch (mess->Class)
								{
									case IDCMP_MOUSEBUTTONS:
									case IDCMP_CLOSEWINDOW:
									case IDCMP_VANILLAKEY:
										weiter = 0;
										break;
								}
								ReplyMsg((struct Message*)mess);
							}
						}
						CloseWindow(win);
					}
					DisposeDTObject(o);
					bm = NULL;
				}
				if (destbm)
					FreeBitMap(destbm);
			}
			if (bm)
				FreeBitMap(bm);
		}
		UnlockPubScreen(NULL, scr);
	}
}


/*--------------------------------------------------------------------------*/
/*                                                                          */
/*--------------------------------------------------------------------------*/

void show_clip(void)
{
	Object *o;
	struct BitMapHeader *bmhd;
	struct BitMap *dtbm;
	struct Screen *scr;
	struct Window *win;
	struct RastPort *rp;
	struct MsgPort *port;
	struct IntuiMessage *mess;
	long weiter;

	if (scr = LockPubScreen(NULL))
	{
		if (o = NewDTObject (0, DTA_SourceType, DTST_CLIPBOARD, DTA_GroupID, GID_PICTURE,
				PDTA_Remap, TRUE, PDTA_Screen, scr, TAG_END))
		{
			DoMethod(o, DTM_PROCLAYOUT, NULL, 1);
			GetDTAttrs(o, PDTA_BitMapHeader, &bmhd, PDTA_BitMap, &dtbm, TAG_END);

			if (debug)
				print_dtattrs(o);

			if (win = OpenWindowTags(NULL,
						WA_CustomScreen, scr,
						WA_Left, (scr->Width - (bmhd->bmh_Width  + scr->WBorRight + scr->WBorLeft)) >> 1,
						WA_Top, (scr->Height - (bmhd->bmh_Height + scr->WBorTop + scr->WBorBottom)) >> 1,
						WA_InnerWidth, bmhd->bmh_Width,
						WA_InnerHeight, bmhd->bmh_Height,
						WA_Flags, WFLG_CLOSEGADGET|WFLG_DRAGBAR|WFLG_DEPTHGADGET|WFLG_ACTIVATE|WFLG_GIMMEZEROZERO,
						WA_IDCMP, IDCMP_MOUSEBUTTONS|IDCMP_CLOSEWINDOW|IDCMP_VANILLAKEY,
						TAG_END))
			{
				port = win->UserPort;
				rp   = win->RPort;
				BltBitMapRastPort(dtbm, 0, 0, rp, 0, 0, min(bmhd->bmh_Width, win->GZZWidth), min(bmhd->bmh_Height, win->GZZHeight), 0x00c0);
				weiter = 1;
				while (weiter)
				{
					WaitPort(port);
					while (mess = (struct IntuiMessage*)GetMsg(port))
					{
						switch (mess->Class)
						{
							case IDCMP_MOUSEBUTTONS:
							case IDCMP_CLOSEWINDOW:
							case IDCMP_VANILLAKEY:
								weiter = 0;
								break;
						}
						ReplyMsg((struct Message*)mess);
					}
				}
				CloseWindow(win);
			}
			DisposeDTObject(o);
		}
		else
			PrintFault (IoErr(), NULL);
		UnlockPubScreen(NULL, scr);
	}
}

/*--------------------------------------------------------------------------*/
/*                                                                          */
/*--------------------------------------------------------------------------*/

void free_pic(struct Picture *pic)
{
	if (pic)
	{
		if (pic->bm)
			FreeBitMap(pic->bm);
		if (pic->cregs)
			FreeMem(pic->cregs, 12*pic->ncols);
		FreeMem(pic, sizeof(struct Picture));
	}
}

/*--------------------------------------------------------------------------*/
/* Hauptprogramm                                                            */
/*--------------------------------------------------------------------------*/

void main(int argc,char *argv[])
{
	struct RDArgs *rdargs;
	struct {
		char *from;
		char *to;
		long show;
		long clip;
		long showclip;
		long debug;
		} args = {NULL, NULL, 0, 0, 0, 0};
	struct Picture *pic;

	/*onbreak(chk_brk);*/

	if (rdargs = ReadArgs("FROM,TO,SHOW/S,CLIP/S,SHOWCLIP/S,DEBUG/S", (APTR)&args, NULL))
	{
		debug = args.debug;

		if (args.from)
		{
			printf("loading picture from %s\n", args.from);
			pic = load_pic(args.from);
		}
		else
		{
			printf("loading clipboard\n");
			pic = load_clip();
		}
		if (pic)
		{
			if (args.clip)
			{
				printf ("copying picture to clipboard\n");
				clip_pic(pic);
			}

			if (args.to)
			{
				printf("saving picture as %s\n", args.to);
				save_pic(pic, args.to);
			}

			if (args.showclip)
			{
				printf("showing clipboard\n");
				show_clip();
			}

			if (args.show)
			{
				printf("showing picture\n");
				show_pic(pic);
			}
			free_pic(pic);
		}
		else
			PrintFault(IoErr(), "cannot open picture");
		FreeArgs(rdargs);
	}
	else
		PrintFault(IoErr(),NULL);
	exit(0);
}

/*--------------------------------------------------------------------------*/
/* Ende des Quelltextes                                                     */
/*--------------------------------------------------------------------------*/
