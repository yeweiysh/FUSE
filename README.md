# FUSE
Wei Ye, Sebastian Goebl, Claudia Plant, Christian Böhm, FUSE: Full Spectral Clustering, SIGKDD Conference on Knowledge Discovery and Data Mining, 2016

This repository contains the code, synthetic data and real-world data used in the 2016 KDD paper "FUSE: Full Spectral Clustering". The code is written in matlab and tested successfully in Matlab 2015b. 

For all the synthetic data, pendigits, MNIST0127, deer, and elephant, I used the method proposed in ZP to compute the locally scaled affinity matrix. The code of ZP can be found at: http://www.vision.caltech.edu/lihi/Demos/SelfTuningClustering.html. I also include it in this repository (ZPclustering folder).

You can run the command [A_LS]=ZP(X,k) to get the locally-scaled affinity matrix, where the input X is data matrix, k denotes the cluster number, and the output A_LS is the locally-scaled affinity matrix.

If you have any questions, please contact Wei Ye (yew@tongji.edu.cn). Thanks for your interest.

