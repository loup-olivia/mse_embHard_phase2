# Result time in cycle 
## 1
### -O1
sobel x m2 575815945
sobel x def 4164991363
sobel y 4165013458
sobel threshold 4261351391
sobel conv grayscale in mode 4 : 4249677245
sobel x m2 575815945
sobel x def 4164990274
sobel y 4165013600
sobel threshold 4261205951
sobel conv grayscale in mode 4 : 4250549851

### -O2
sobel x m2 4294966786
sobel x def 4163941979
sobel y 4163957587
sobel threshold 4256509671
sobel conv grayscale in mode 4 : 4245442129
sobel x m2 4294966786
sobel x def 4164268680
sobel y 4164269120
sobel threshold 4256567536
sobel conv grayscale in mode 4 : 4249800037
### -O3
sobel x m2 0
sobel x def 4265610867
sobel y 4267785761
sobel threshold 4263045741
sobel conv grayscale in mode 4 : 4250695232
sobel x m2 0
sobel x def 4265593001
sobel y 4267967168
sobel threshold 4263144296
sobel conv grayscale in mode 4 : 4250886083
## 2
### unrolling innerloop
sobel x m2 3
sobel x def 3566869407
sobel y 3563139885
sobel threshold 4189122510
sobel conv grayscale in mode 4 : 4181384688
sobel x m2 3
sobel x def 3562710178
sobel y 3571428698
sobel threshold 4191564118
sobel conv grayscale in mode 4 : 4163372769
### unrolling outerloop
sobel x m2 3
sobel x def 3537313655
sobel y 3540607309
sobel threshold 4191431981
sobel conv grayscale in mode 4 : 4164009408
sobel x m2 3
sobel x def 3536651518
sobel y 3538946862 
sobel threshold 4191641150
sobel conv grayscale in mode 4 : 4167009569
### inline
<!-- sobel x m2 3
sobel x def 3744589097
sobel y 3750543802
sobel threshold 4192105582
sobel conv grayscale in mode 4 : 4164591665
sobel x m2 3
sobel x def 3746271437
sobel y 3750328277
sobel threshold 4192334969
sobel conv grayscale in mode 4 : 4166140184
#### 2nd test modif mac_sobel()
sobel x m2 3
sobel x def 3743923758
sobel y 3750402916
sobel threshold 4192174130
sobel conv grayscale in mode 4 : 4165053014
sobel x m2 3
sobel x def 3744567064
sobel y 3750610301
sobel threshold 4192182994
sobel conv grayscale in mode 4 : 4166579488 -->
 sobel x m2 3
 sobel x def 3735036995
 sobel y 3741287169
 sobel threshold 4190434024
 sobel conv grayscale in mode 4 : 4164508002
 sobel x m2 3
 sobel x def 3735192301
 sobel y 3832226684
 sobel threshold 0
 sobel conv grayscale in mode 4 : 4164408571

