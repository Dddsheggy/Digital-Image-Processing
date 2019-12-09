my_mean_local.jpg、my_std_local.jpg、my_mask.jpg、my_enhance.jpg为我的程序在3*3邻域下运行输出的图片；
t_mean_local.jpg、t_std_local.jpg、t_mask.jpg、t_enhance.jpg为nlfilter在3*3邻域下运行输出的图片。

bsum.m和getLocalVar.m用于求得局部均值和方差，myLocalEnhance.m为主体程序，report.m用于生成对比图。