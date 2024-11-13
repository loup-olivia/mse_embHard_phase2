# MSE-embHard part 2
 For the second part of the course, we are going to focus on optimization techniques for the
 Sobel algorithm implementation.
 In order to speed-up the development process and get focused into the optimization part, we
 provide you a working hardware-software system that you can download and test.
 This short tutorial will show you how to setup the complete system to get it ready to run.
 ## Topic and labo
 8. labo 4 : Complete system setup NOK

### Topic 8, labo 04
#### 4.1
Button doing system reset :\
- Pin of system reset : PIN E10
  - If we look old tcl file, PIN E10 was on BUTTONS[10] so sw9
Connection :
#### 4.2
Selection of 5 modes : The mode depend of dipswitch [3..1]\
```current_mode = DIPSW_get_value();```\
```mode = current_mode&(DIPSW_SW1_MASK|DIPSW_SW3_MASK|DIPSW_SW2_MASK);```

The modes are [4..0]:
- 0 : /SW1 & /SW2 & /SW3
- 1 : SW1 & /SW2 & /SW3 (simplest mode)
- 2 : /SW1 & SW2 & /SW3 
- 3 : SW1 & SW2 & /SW3
- Default : other 

Selection of VGA : If dispwitch 8 is high\
```current_mode&DIPSW_SW8_MASK```
#### 4.3
In vizualise :
- Mode 0 : normal camera
- Mode 1 : grayscale with rectangle when moove. Form an image if keep same 
  place a moment
- Mode 2 : filtrage
- Mode 3 : gradient
- Mode 4 : Filtre de sobel finition     
Mode 2-3 are really slow, I suppose mode 3 do more but the actions are 
difficult to see.\
In one mode, the systeme use :
- ```lcd_simple.c```
  - ```transfer_LCD_with_dma```
- ```dipswitch.c```
    - ```DIPSW_get_value()``` = 0xa84
- ```camera.c```
    - ```cam_get_xsize()``` 
    - ```cam_get_ysize()``` 
    - ```current_image_pointer``` : image = 0x1350e0
- ```vga.c```
  - ```vga_set_swap```
  - ```vga_set_pointer```
- ```grayscale.c```
    - ```get_grayscale()```
- ```dipswitch.h```
  - ```DIPSW_SW1_MASK```
  - ```DIPSW_SW2_MASK```
  - ```DIPSW_SW3_MASK```
  - ```DIPSW_SW8_MASK```
- ```vga.h```
  - - ```VGA_Grayscale```

When VGA in involed, at visualize, the difference not really relevant. Maybe 
the mode 2-3 are already to slow in normal state.