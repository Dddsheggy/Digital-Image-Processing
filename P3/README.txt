文件说明：
*1.jpg, 2.jpg和3.jpg为原图
*empty.jpg和info.jpg为界面中用到的两张图

*slic.m和Aslic.m分别为SLIC算法和ASLIC算法的函数

*my_slic_result.m对比SLIC算法和ASLIC算法的结果，还对比了同种算法在k值不同时的用时

*processing_result.m显示一组参数下对一张图片做SLIC算法的三次中间结果

*interatc.fig和interact.m为GUI文件

*其余函数都是用来做形态学处理，目的是把SLIC算出的标记图L中的孤立区域标记值换为距其最近的非孤立区域的标记值，具体功能在代码中有注释，原理和过程图解在报告中有阐释

