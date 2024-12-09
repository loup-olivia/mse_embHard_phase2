static inline short sobel_mac_all( unsigned char *pixels,
                 int x,
                 int y,
                 const char *filterX,
                 const char *filterY,
                 unsigned int width ) {
   short result = 0;
   int idy;

    array_x_0[0] = index_array[1]-1;
    array_x_2[0] = index_array[2]-1;
    
    array_x_0[1] = index_array[1];
    array_x_2[1] = index_array[2];

    array_x_0[2] = index_array[1]+1;
    array_x_2[2] = index_array[2]+1;
    // y index
    array_y_0[0] = index_array[0]-1;
    array_y_0[1] = index_array[1]-1;
    array_y_0[2] = index_array[2]-1;
    
    array_y_2[0] = index_array[0]+1;
    array_y_2[1] = index_array[1]+1;
    array_y_2[2] = index_array[2]+1;

    sobel_x_result[index_array[4]] = -pixels[array_x_0[0]] + pixels[array_x_2[0]] - 2*pixels[array_x_0[1]] + 2*pixels[array_x_2[1]] -pixels[array_x_0[2]]+pixels[array_x_2[2]];
    sobel_y_result[index_array[4]] = pixels[array_y_0[0]] + 2*pixels[array_y_0[1]] + pixels[array_y_0[2]] - pixels[array_y_2[0]] - 2*pixels[array_y_2[1]] - pixels[array_y_2[2]];
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