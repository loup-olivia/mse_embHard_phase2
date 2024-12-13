/*
 * sobel.c
 *
 *  Created on: Sep 12, 2015
 *      Author: theo
 */

#include <stdlib.h>
#include <stdio.h>
#include "io.h"

const char gx_array[3][3] = {{-1,0,1},
                             {-2,0,2},
                             {-1,0,1}};
const char gy_array[3][3] = { {1, 2, 1},
                              {0, 0, 0},
                             {-1,-2,-1}};

short *sobel_x_result;
short *sobel_y_result;
unsigned short *sobel_rgb565;
unsigned char *sobel_result;
int sobel_width;
int sobel_height;

void init_sobel_arrays(int width , int height) {
	int loop;
	sobel_width = width;
	sobel_height = height;
	int mult_size = width*height;

	if (sobel_x_result != NULL)
		free(sobel_x_result);
	sobel_x_result = (short *)malloc(mult_size*sizeof(short));
	if (sobel_y_result != NULL)
		free(sobel_y_result);
	sobel_y_result = (short *)malloc(mult_size*sizeof(short));
	if (sobel_result != NULL)
		free(sobel_result);
	sobel_result = (unsigned char *)malloc(mult_size*sizeof(unsigned char));
	if (sobel_rgb565 != NULL)
		free(sobel_rgb565);
	sobel_rgb565 = (unsigned short *)malloc(mult_size*sizeof(unsigned short));
	for (loop = 0 ; loop < mult_size ; loop++) {
		sobel_x_result[loop] = 0;
		sobel_y_result[loop] = 0;
		sobel_result[loop] = 0;
		sobel_rgb565[loop] = 0;
	}
}

static inline short sobel_mac( unsigned char *pixels,
                 int x,
                 int y,
                 const char *filter,
                 unsigned int width ) {
   short result = 0;
   int idy;
/* short dy,dx;
   #pragma unroll 1
   for (dy = -1 ; dy < 2 ; dy++) {
	  #pragma unroll 3
      for (dx = -1 ; dx < 2 ; dx++) {
         result += filter[(dy+1)*3+(dx+1)]*
                   pixels[(y+dy)*width+(x+dx)];
      }
   }*/
   //unrolling inner loop
   // unrolling all loops
   idy = (y-1)*width;
   result += filter[0]*
         pixels[idy+(x-1)];
   result += filter[1]*
         pixels[idy+(x)];
   result += filter[2]*
         pixels[idy+(x+1)];

   idy = y*width;
   result += filter[3]*
         pixels[idy+(x-1)];
   result += filter[4]*
         pixels[idy+(x)];
   result += filter[5]*
         pixels[idy+(x+1)];

   idy = (y+1)*width;
   result += filter[6]*
         pixels[idy+(x-1)];
   result += filter[7]*
         pixels[idy+(x)];
   result += filter[8]*
         pixels[idy+(x+1)];

   return result;
}
static inline short sobel_mac_all( unsigned char *pixels,
                 int x,
                 int y,
                 const char *filterX,
                 const char *filterY,
                 unsigned int width ) {
   short result = 0;
   int idy;
/* short dy,dx;
   #pragma unroll 1
   for (dy = -1 ; dy < 2 ; dy++) {
	  #pragma unroll 3
      for (dx = -1 ; dx < 2 ; dx++) {
         result += filter[(dy+1)*3+(dx+1)]*
                   pixels[(y+dy)*width+(x+dx)];
      }
   }*/
   //unrolling inner loop
   // unrolling all loops
   // x
   idy = (y-1)*width;
   result += filterX[0]*
         pixels[idy+(x-1)];
   result += filterX[1]*
         pixels[idy+(x)];
   result += filterX[2]*
         pixels[idy+(x+1)];

   idy = y*width;
   result += filterX[3]*
         pixels[idy+(x-1)];
   result += filterX[4]*
         pixels[idy+(x)];
   result += filterX[5]*
         pixels[idy+(x+1)];

   idy = (y+1)*width;
   result += filterX[6]*
         pixels[idy+(x-1)];
   result += filterX[7]*
         pixels[idy+(x)];
   result += filterX[8]*
         pixels[idy+(x+1)];

   // y
   idy = (y-1)*width;
   result += filterY[0]*
         pixels[idy+(x-1)];
   result += filterY[1]*
         pixels[idy+(x)];
   result += filterY[2]*
         pixels[idy+(x+1)];

   idy = y*width;
   result += filterY[3]*
         pixels[idy+(x-1)];
   result += filterY[4]*
         pixels[idy+(x)];
   result += filterY[5]*
         pixels[idy+(x+1)];

   idy = (y+1)*width;
   result += filterY[6]*
         pixels[idy+(x-1)];
   result += filterY[7]*
         pixels[idy+(x)];
   result += filterY[8]*
         pixels[idy+(x+1)];

   return result;
}
void sobel_complete_V2( unsigned char * source )
{
    int x,y;
    int index_array[4]= {0,0,0,0};
    int index_array_x_0[3]= {0,0,0};
    int index_array_x_2[3]= {0,0,0};
    index_array[1] = sobel_width;
    index_array[2] = sobel_width<<1;

   for (y = 1 ; y < (sobel_height-1) ; y++) {
	  index_array_x_0[0] = index_array[1]-1;
	  index_array_x_2[0] = index_array[2]-1;
	  index_array_x_0[1] = index_array[1];
	  index_array_x_2[1] = index_array[2];
	  index_array_x_0[2] = index_array[1]+1;
	  index_array_x_2[2] = index_array[2]+1;
	  for (x = 1 ; x < (sobel_width-1) ; x++) {
		index_array[4] = index_array[1]+ x;

		sobel_x_result[index_array[4]] = (source[index_array_x_0[1]])-(source[index_array_x_0[0]])-(source[index_array_x_0[2]] << 1)+(source[index_array_x_2[0]]<<2)-(source[index_array_x_2[1]]) + (source[index_array_x_2[2]]);
		sobel_y_result[index_array[4]] = (source[index_array_x_0[0]])+(source[index_array_x_0[1]]<<1)+(source[index_array_x_0[2]])-(source[index_array_x_2[0]])-(source[index_array_x_2[1]]<<2) - (source[index_array_x_2[2]]);

		index_array_x_0[0] = index_array_x_0[1];
		index_array_x_2[0] = index_array_x_2[1];
		index_array_x_0[1] = index_array_x_0[2];
		index_array_x_2[1] = index_array_x_2[2];
		index_array_x_0[2] = index_array_x_0[1]+1;
		index_array_x_2[2] = index_array_x_2[1]+1;
	  }
	  index_array[0] = index_array[1];
	  index_array[1] = index_array[2];
	  index_array[2] = index_array[1]+sobel_width;
   }

}
void sobel_complete( unsigned char *source ){
   int x,y;
   //inline call
   for (y = 1 ; y < (sobel_height-1) ; y++) {
	  for (x = 1 ; x < (sobel_width-1) ; x++) {
			  sobel_mac_all(source,x,y,gx_array,gy_array,sobel_width);
			  //sobel_mac(source,x,y,gy_array,sobel_width);
	  }
   }
}

void sobel_x( unsigned char *source ) {
   int x,y;
   //inline call
   for (y = 1 ; y < (sobel_height-1) ; y++) {
      for (x = 1 ; x < (sobel_width-1) ; x++) {
    	  	  sobel_mac(source,x,y,gx_array,sobel_width);
      }
   }
}

void sobel_x_with_rgb( unsigned char *source ) {
   int x,y;
   short result;
   int idy;
   for (y = 1 ; y < (sobel_height-1) ; y++) {
	   // because multi take more than add
	   idy = y*sobel_width;
      for (x = 1 ; x < (sobel_width-1) ; x++) {
    	  result = sobel_mac(source,x,y,gx_array,sobel_width);
          sobel_x_result[idy+x] = result;
          if (result < 0) {
        	  sobel_rgb565[idy+x] = ((-result)>>2)<<5;
          } else {
        	  sobel_rgb565[idy+x] = ((result>>3)&0x1F)<<11;
          }
      }
   }
}

void sobel_y( unsigned char *source ) {
   int x,y;
   for (y = 1 ; y < (sobel_height-1) ; y++) {
      for (x = 1 ; x < (sobel_width-1) ; x++) {
    	  	  sobel_mac(source,x,y,gy_array,sobel_width);
      }
   }
}

//change here,
void sobel_y_with_rgb( unsigned char *source ) {
   int x,y;
   short result;
   int idy;
   for (y = 1 ; y < (sobel_height-1) ; y++) {
	   idy = y*sobel_width;
      for (x = 1 ; x < (sobel_width-1) ; x++) {
    	  result = sobel_mac(source,x,y,gy_array,sobel_width);
         sobel_y_result[+x] = result;
         if (result < 0) {
       	  sobel_rgb565[idy+x] = ((-result)>>2)<<5;
         } else {
       	  sobel_rgb565[idy+x] = ((result>>3)&0x1F)<<11;
         }
      }
   }
}

void sobel_threshold(short threshold) {
	int x,y,arrayindex,arrayY;
	short sum,value;
   //unrolling loop
	for (y = 1 ; y < (sobel_height-1) ; y++) {
		arrayY = (y*sobel_width);
		for (x = 1 ; x < (sobel_width-1) ; x++) {
			arrayindex = arrayY+x;
			value = sobel_x_result[arrayindex];
			sum = abs(value);
			value = sobel_y_result[arrayindex];
			sum += abs(value);
			sobel_result[arrayindex] = (sum > threshold) ? 0xFF : 0;
		}
	}
}

unsigned short *GetSobel_rgb() {
	return sobel_rgb565;
}

unsigned char *GetSobelResult() {
	return sobel_result;
}
