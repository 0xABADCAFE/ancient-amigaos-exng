/*
	simple tool to extract the data from the warpos voxelspace demo map
*/

#include <stdio.h>
#include <stdlib.h>

int main(int arg_n, char** argv)
{
	char* data = 0;
	char*	pal = 0;
	int	bytes = 0;
	FILE* source = 0;
	FILE*	dest = 0;

	if (!(pal = (char*)malloc(1024))) {
		puts("unable to allocate palette data");
		return 0;
	}

	if (source = fopen("colortable.bin", "rb")) {
		char buf[16];
		int n = 256;
		char* p = pal;
		puts("colour table opened ok");
		fread(buf, 1, 4, source);
		while (n--) {
			fread(buf, 1, 12, source);
			*p++ = buf[0];
			*p++ = buf[4];
			*p++ = buf[8];
			p++;
		}
		fclose(source);
	}
	else {
		puts("unable to open colour table");
		free(pal);
		return 0;
	}

	if (source = fopen("map.bin", "rb")) {
		puts("source file opened ok");
		if (data = (char*)malloc(1024*1024*2)) {
			puts("memory allocated ok");
			bytes = fread(data, 1, 1024*1024*2, source);
			if (bytes>2) {
				if (bytes!=(1024*1024*2))
					printf("warning, unexpected length %d\n", bytes);
				else
					puts("data read ok");
/*
				if (dest = fopen("map_z.pgm", "wb")) {
					int dBytes = bytes/2;
					char* p = data+1;
					fprintf(dest, "P5\n%d\n%d\n255\n",1024,1024);
					while (dBytes--) {
						fputc(*p, dest);
						p+=2;
					}
					fclose(dest);
					puts("wrote map_z.pgm");
				}
*/
				if (dest = fopen("map_rgb.ppm", "wb")) {
					int dBytes = bytes/2;
					char* p = data;
					fprintf(dest, "P6\n%d\n%d\n255\n",1024,1024);
					while (dBytes--) {
						int i = *p;
						fwrite(&pal[i<<2], 3, 1, dest);
						p+=2;
					}
					fclose(dest);
					puts("wrote map_rgb.ppm");
				}

			}
			free(data);
		}
		fclose(source);
	}
	free(pal);
	return 0;
}