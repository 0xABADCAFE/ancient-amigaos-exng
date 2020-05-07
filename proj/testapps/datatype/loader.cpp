
#include <xbase.hpp>
#include <gfxlib/gfx.hpp>
#include <gfxlib/gfxutil.hpp>

/*
extern "C" {
  #include <string.h>
  #include <clib/alib_protos.h>
  #include <clib/dos_protos.h>
  #include <clib/datatypes_protos.h>
  #include <datatypes/pictureclass.h>
}
*/
////////////////////////////////////////////////////////////////////////////////

class GfxTestApp : public AppBase {
  public:
    static  char* formatNames[];
    sint32  runApplication();

  public:
    GfxTestApp() {}
    ~GfxTestApp() {}
};

////////////////////////////////////////////////////////////////////////////////

char* GfxTestApp::formatNames[] = {
  "8-bit INDEX8",
  "15-bit R5:G5:B5 Big",
  "15-bit B5:G5:R5 Big",
  "15-bit R5:G5:B5 Little",
  "15-bit B5:G5:R5 Little",
  "16-bit R5:G6:B5 Big",
  "16-bit B5:G6:R5 Big",
  "16-bit R5:G6:B5 Little",
  "16-bit B5:G6:R5 Little",
  "24-bit R8:G8:B8 Packed",
  "24-bit B8:G8:R8 Packed",
  "32-bit A8:R8:G8:B8 Big",
  "32-bit A8:B8:G8:R8 Big",
  "32-bit A8:R8:G8:B8 Little",
  "32-bit A8:B8:G8:R8 Little"
};

sint32 AppBase::init()
{
  return OK;
}

void AppBase::done()
{
}

AppBase* AppBase::createApplicationInstance()
{
  return new GfxTestApp;
}

void AppBase::destroyApplicationInstance(AppBase* app)
{
  delete app;
}

////////////////////////////////////////////////////////////////////////////////

sint32 GfxTestApp::runApplication()
{
  const char* name = 0;
  if (name = getString("image", false))
  {

    ImageBuffer *test = ImageLoader::loadImage(name);

    if (test)
    {
      printf ("Image '%s'\n\n", name);

      printf("Width      : %d\n", (sint32)test->getW());
      printf("Height     : %d\n", (sint32)test->getH());
      printf("Format     : %s\n", formatNames[test->getFormat()]);

      if (test->getFormat() == Pixel::INDEX8)
      {
        Palette* p = test->getPalette();
        if (p)
        {
          printf("Palette Use: %d\nPalette data\n\n", test->getPalSize());
          for (sint32 n=0; n<test->getPalSize(); n+=4)
          {
            printf("[%3d] 0x%08X 0x%08X 0x%08X 0x%08X\n", n,
            (uint32)((*p)[n]),
            (uint32)((*p)[n+1]),
            (uint32)((*p)[n+2]),
            (uint32)((*p)[n+3])
            );
          }
        }
      }

      delete test;
    }



/*
    Object* picture = 0;
    if (picture = NewDTObject((char*)name,
                              DTA_GroupID,      GID_PICTURE,
                              PDTA_Remap,        FALSE,
                              PDTA_DestMode,    PMODE_V43,
                              TAG_END))
    {
      uint32   numColours;
      uint32*  colours;
      DoMethod(picture, DTM_PROCLAYOUT, NULL, 1);
      BitMapHeader* picHeader;
      GetDTAttrs(picture,
                 PDTA_BitMapHeader,  &picHeader,
                 PDTA_NumColors,    &numColours,
                 PDTA_CRegs,        &colours,
                 TAG_END);
      printf("width   : %ld\n", (sint32)picHeader->bmh_Width);
      printf("height  : %ld\n", (sint32)picHeader->bmh_Height);
      printf("depth   : %ld\n", (sint32)picHeader->bmh_Depth);
      printf("colours : %lu\n", numColours);

      if (colours)
      {
        uint32* p = colours;
        printf ("Palette dump\n");
        for (sint32 n=0; n<numColours; n++, p+=3)
        {
          printf("[%3d] : 0x%08X 0x%08X 0x%08X\n", n, p[0], p[1], p[2]);
        }
      }

      void* data = Mem::alloc(picHeader->bmh_Width*picHeader->bmh_Height*4, true);
      if (data)
      {
        DoMethod(picture, PDTM_READPIXELARRAY,
                data, PBPAFMT_ARGB,
                picHeader->bmh_Width*4,
                0, 0,
                picHeader->bmh_Width, picHeader->bmh_Height);


        Mem::free(data);

      }

      DisposeDTObject(picture);
    }
    else
      PrintFault(IoErr(),0);
*/
  }

  return 0;
}

////////////////////////////////////////////////////////////////////////////////

