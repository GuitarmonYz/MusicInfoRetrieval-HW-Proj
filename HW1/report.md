Evaluation

1. The estimated f0 curve is:

   ![estimated pitch](/Users/zhaoyan/workstuff/Matlab_workspace/6201_MIR/HW1/estimate_pitch.jpg)

   the absolute error is:

   ![abs_error](/Users/zhaoyan/workstuff/Matlab_workspace/6201_MIR/HW1/abs_error.jpg)

   The error only happened on the last block, where the estimated lag is 1 unit smaller than previous estimated lags, because the last block is zero padded, and accidently, the last block and

2. The RMS error in cent for each of the training sample is:

   | training data  | RMS in cent |
   | :------------: | :---------: |
   | 01-D_amairena  |   206.47    |
   | 24-M1_Amairena |   452.83    |
   | 63-M2_Amairena |  364.4659   |

   The performance may be able to improved by adding low pass filter on calculated ACF value, which can smooth the acf sequence and remove glitch on the peaks. Increasing sampling rate may also help.

3. Bonus

   myCompAcfMod and myGetF0FromAcfMod are called within the myGetF0FromAcfMod function.

   In myCompAcfMod, I removed normalization option, since acf pitch tracking do not need normalization, and this removal save operation time.

   In myGetF0FromAcfMod, I modified the peak detection based on diff(), where I merge diff and find peak process on diff into one loop to save time. 

   In myGetF0FromAcfMod, I put the blocking and pitch finding into one loop, which saves time. And I add a moving average filter on calculated ACF to increase accuracy. I also make the peak detection on ACF start from 22th lag, which reduce the influence of some high peaks at beginning.