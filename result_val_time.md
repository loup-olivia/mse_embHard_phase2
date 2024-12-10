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
## In-lining
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
#### Inline v2 (correction)
sobel x m2 3
sobel x def 3880863466
sobel y 3880634456
sobel threshold 4188890045
sobel conv grayscale in mode 4 : 4163329161
sobel x m2 3
sobel x def 3880858055
sobel y 3880620639
sobel threshold 4189734122
sobel conv grayscale in mode 4 : 4163624897

### In on function
sobel x m2 3
sobel x def 3492517512
sobel y 3492517516
sobel threshold 4188996078
sobel conv grayscale in mode 4 : 4165844741
sobel x m2 3
sobel x def 3500285641
sobel y 3500285641
sobel threshold 4189048541
sobel conv grayscale in mode 4 : 4165314044

Il n'y a pas une vraie amélioration. Cela peut-être dûe au fait qu'on attend
dans les deux cas que les deux fontions tournent.
## 4 Code improvement
Dans les deux cas, si les variables "heigth" & "width" sont définis à la 
compilation. Il serait possible d'utiliser ```#pragma unroll``` pour dérouler 
les boucles for
### Other change in sobel.c
1. "sobel_mac" : do calcul of y in start of code (not in all calcul)
2. "sobel_mac" : pragma unroll (seulement en optimisation -02 ou -03)
3. "sobel_x_with_rgb" : absolue de ```result``` pour enlever le *if()else()*
4. "sobel_threshold" : enlever opération ternaire et utiliser la valeur absolue de ```value```
5. "sobel_x_with_rgb" : diminuer les multiplications

### Other change in grayscale.c
1. "conv_grayscale" : passer la divison */= 100* par un décalage $2^6$

### Result with 1, 4 of sobel.c and 1 on grayscale.c
#### correction diff
sobel x m2 4294967293
sobel x def 804586939
sobel y 804586939
sobel threshold 102904932
sobel conv grayscale in mode 4 : 99984593
sobel x m2 4294967293
sobel x def 805239257
sobel y 805239264
sobel threshold 104377258
sobel conv grayscale in mode 4 : 100033095
Sum : 1 812 063 403

#### diminuate multi
sobel x m2 4294967293
sobel x def 811 570 604
sobel y 811 570 602
sobel threshold 106 447 830
sobel conv grayscale in mode 4 : 102 971 917
sobel x m2 4294967293
sobel x def 811709063
sobel y 811709063
sobel threshold 106295870
sobel conv grayscale in mode 4 : 103046564
 sum 1er : 1 832 560 953
#### multi plus
sobel x def 810 707 964
sobel y 810 707 969
sobel threshold 99 741 874
sobel conv grayscale in mode 4 : 102 818 145
sobel x def 810576356
sobel y 810576351
sobel threshold 99871208
sobel conv grayscale in mode 4 : 102891592

#### change use fucntion
sobel x def 410721596
sobel y 410620863
sobel threshold 99224584
sobel conv grayscale in mode 4 : 98341149
sobel x def 410564706
sobel y 410782341
sobel threshold 99222795
sobel conv grayscale in mode 4 : 98414240

#### change gray scale
sobel x def 410588471
sobel y 410803970
sobel threshold 99123281
sobel conv grayscale in mode 4 : 109543861
sobel x def 410795096
sobel y 410683451
sobel threshold 99033452
sobel conv grayscale in mode 4 : 109 406 834

#### change val with calcul in grayscale
sobel x def 411 767 121
sobel y 411778682
sobel threshold 99518886
sobel conv grayscale in mode 4 : 97 536 186
sobel x def 409 76 390
sobel y 404 815 773
sobel threshold 97 812 434
sobel conv grayscale in mode 4 : 97 819 280
#### change grayscale calcul
Nr. of frames each second : 7
sobel x def 402 536 375
sobel y 402541240
sobel threshold 97 198 463
sobel conv grayscale in mode 4 : 94 821 025
sobel x def 402540541
sobel y 402352298
sobel threshold 97301044
sobel conv grayscale in mode 4 : 94992573
#### With only one function
sobel all 767350909
sobel threshold 96 142 387
sobel conv grayscale in mode 4 : 94 237 068
sobel x m2 767146379
sobel threshold 96352744
sobel conv grayscale in mode 4 : 94309310
#### optim cycles func
sobel x : 160k
sobel y : 160k
sobel threshold : 40k
sobel grayscale : 40k
#### result wanted
CPU Cycle/pixels = (sobel x +sobel y +sobel threshold +sobel conv)/76800
76800 = nbr pixels
With this, CPU Cycle/pixels : ~9216
objectif sum : 438 444 760

# Cache
chosisir ou placer
Savoir comment fontionne la cache (hit & miss)