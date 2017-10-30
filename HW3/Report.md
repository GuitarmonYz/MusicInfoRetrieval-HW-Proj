# Report

A.3

resolution = fs/num_bin = 43.07

No, we can't improve it without changing block size, the result can be improved by changing sampling rate or resolution, so without changing blocksize, we can't change the resolution, thereby can't improve result without changing blocksize

D.1

![f0_max](/Users/zhaoyan/workstuff/Matlab_workspace/6201_MIR/HW3/f0_max.jpg)

![err_max](/Users/zhaoyan/workstuff/Matlab_workspace/6201_MIR/HW3/err_max.jpg)

![f0_max_2048](/Users/zhaoyan/workstuff/Matlab_workspace/6201_MIR/HW3/f0_max_2048.jpg)

![err_f0_2048](/Users/zhaoyan/workstuff/Matlab_workspace/6201_MIR/HW3/err_f0_2048.jpg)

![err_f0_2048](/Users/zhaoyan/workstuff/Matlab_workspace/6201_MIR/HW3/f0_hps_1024.jpg)

![err_hps_1024](/Users/zhaoyan/workstuff/Matlab_workspace/6201_MIR/HW3/err_hps_1024.jpg)

the HPS only works for signal that has harmonics, missing harmonic will influence hps significatly, thus a sin wave that without harmonics will not work with HPS.

D.2

The result is improved by increasing blocksize (lower resolution);

D.3

By max

| Err_cent         | Pfp               | Pfn                 |
| ---------------- | ----------------- | ------------------- |
| 1916.35304702099 | 0.605671866447729 | 0.00370577171054318 |

By hps

| Err_cent         | Pfp  | Pfn  |
| ---------------- | ---- | ---- |
| 918.695480914711 | 1    | 0    |

D.4

Max_-20

| Err_cent         | Pfp                 | Pfn               |
| ---------------- | ------------------- | ----------------- |
| 1859.08045582467 | 0.00138888888888889 | 0.347964193088821 |

Max_-40

| Err_cent         | Pfp               | Pfn                 |
| ---------------- | ----------------- | ------------------- |
| 1913.61493948174 | 0.155067505929575 | 0.00812313307335579 |

Hps_-20

| Err_cent         | Pfp                 | Pfn               |
| ---------------- | ------------------- | ----------------- |
| 799.203437421478 | 0.00138888888888889 | 0.347964193088821 |

Hps_-40

| Err_cent         | Pfp               | Pfn                 |
| ---------------- | ----------------- | ------------------- |
| 303.003310915319 | 0.174559843094326 | 0.00672384734682049 |

Acf_-20

| Err_cent         | Pfp                 | Pfn               |
| ---------------- | ------------------- | ----------------- |
| 199.405567187889 | 0.00138888888888889 | 0.347964193088821 |

Acf_-40

| Err_cent         | Pfp               | Pfn                 |
| ---------------- | ----------------- | ------------------- |
| 890.715398324392 | 0.174559843094326 | 0.00672384734682049 |



Bonus

First use both acf and hps to get f0, then apply the voicing with threshold -40 on hps and -20 on act, replace voiced f0 from acf that greater than 570 with voiced f0 from hps.