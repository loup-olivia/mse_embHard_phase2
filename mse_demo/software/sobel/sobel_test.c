/*static inline short sobel_mac_all( unsigned char *pixels,
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

      sobel_x_result[index_array[4]] = -pixels[array_x_0[0]] + pixels[array_x_2[0]] - pixels[array_x_0[1]]<<1 + pixels[array_x_2[1]]<<1 -pixels[array_x_0[2]]+pixels[array_x_2[2]];
      sobel_y_result[index_array[4]] = pixels[array_y_0[0]] + pixels[array_y_0[1]]<<1 + pixels[array_y_0[2]] - pixels[array_y_2[0]] - pixels[array_y_2[1]]<<1 - pixels[array_y_2[2]];

      index_array[0] = index_array[1];
      index_array[1] = index_array[2];
      index_array[2] = index_array[2]+width;
   return result;
}*/
