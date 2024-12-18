/*
 * grayscale.c
 *
 *  Created on: Aug 21, 2015
 *      Author: theo
 */

#include <stdlib.h>
#include <io.h>
#include <system.h>

unsigned char *grayscale_array;
int grayscale_width = 0;
int grayscape_height = 0;

void conv_grayscale(void *picture,
		            int width,
		            int height) {
	int x,y,gray,arrayY, arrayXY,r,g,b;
	unsigned short *pixels = (unsigned short *)picture , rgb;
	grayscale_width = width;
	grayscape_height = height;
	if (grayscale_array != NULL)
		free(grayscale_array);
	grayscale_array = (unsigned char *) malloc(width*height);
	for (y = 0 ; y < height ; y++) {
		arrayY = y*width;
		for (x = 0 ; x < width ; x++) {
			arrayXY= arrayY+x;
			rgb = pixels[arrayXY];
			r = ((rgb>>11)&0x1F)*21; // red part
			g = ((rgb>>5)&0x3F)*72; // green part
			b = (rgb&0x1F)*7; // blue part
			gray =(r+g+b)>> 8;// /= 100; / // do a decalage 2^6=64 depend result /= 100
			IOWR_8DIRECT(grayscale_array, arrayXY, gray);
		}
	}
}


int get_grayscale_width() {
	return grayscale_width;
}

int get_grayscale_height() {
	return grayscape_height;
}

unsigned char *get_grayscale_picture() {
	return grayscale_array;
}


