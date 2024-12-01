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
### unrolling loop in "mac_sobel()" V2
sobel x m2 3
sobel x def 3880036515
sobel y 3886779990
sobel threshold 4190725616
sobel conv grayscale in mode 4 : 4164613747
sobel x m2 3
sobel x def 3882815571
sobel y 3880064633
sobel threshold 4188247500
sobel conv grayscale in mode 4 : 4166982322

But seem have beug and crash after certain time (all value = 0)
and I have no line on LDC
### inline
<!-- sobel x m2 3
sobel x def 3608635862
sobel y 3605359010
sobel threshold 4190940188
sobel conv grayscale in mode 4 : 4188551113
sobel x m2 3
sobel x def 3605324534
sobel y 3605358935
sobel threshold 4190938205
sobel conv grayscale in mode 4 : 4165055237 -->
sobel x m2 3
sobel x def 3880460371
sobel y 3880377942
sobel threshold 4188022777
sobel conv grayscale in mode 4 : 4163821931
sobel x m2 3
sobel x def 3880321009
sobel y 3880346338
sobel threshold 4188201942
sobel conv grayscale in mode 4 : 4163308575