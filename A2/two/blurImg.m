function [picblur, maskblur] = blurImg(pic, mask, K, m, n)
% use Gausskernels of different sizes 
% pixels far from focus get larger Gausskernels

onematrix = ones(m,n);
k1 = 0.05;
k2 = 0.2;
k3 = 0.3;
k4 = 0.31;
k5 = 0.315;
k6 = 0.32;
k7 = 0.325;
k8 = 0.33;
k9 = 0.335;
k10 = 0.34;
k11 = 0.345;
k12 = 0.35;
k13 = 0.355;
k14 = 0.36;
k15 = 0.365;
k16 = 0.37;
k17 = 0.38;
k18 = 0.39;
k19 = 0.4;

part1 = (K<=k1*onematrix) ;
part1 = part1 .* pic;
mask1 = part1 .* mask;

part2 = (K>=k1*onematrix)&(K<=k2*onematrix) ;
part2 = part2 .* pic;
mask2 = part2 .* mask;

part3 = (K>=k2*onematrix)&(K<=k3*onematrix)  ;
part3 = part3 .* pic;
mask3 = part3 .* mask;

part4 = (K>=k3*onematrix)&(K<=k4*onematrix)  ;
part4 = part4 .* pic;
mask4 = part4 .* mask;

part5 = (K>=k4*onematrix)&(K<=k5*onematrix) ;
part5 = part5 .* pic;
mask5 = part5 .* mask;

part6 = (K>=k5*onematrix)&(K<=k6*onematrix) ;
part6 = part6 .* pic;
mask6 = part6 .* mask;

part7 = (K>=k6*onematrix)&(K<=k7*onematrix) ;
part7 = part7 .* pic;
mask7 = part7 .* mask;

part8 = (K>=k7*onematrix)&(K<=k8*onematrix) ;
part8 = part8 .* pic;
mask8 = part8 .* mask;

part9 = (K>=k8*onematrix)&(K<=k9*onematrix) ;
part9 = part9 .* pic;
mask9 = part9 .* mask;

part10 = (K>=k9*onematrix)&(K<=k10*onematrix) ;
part10 = part10 .* pic;
mask10 = part10 .* mask;

part11 = (K>=k10*onematrix)&(K<=k11*onematrix) ;
part11 = part11 .* pic;
mask11 = part11 .* mask;

part12 = (K>=k11*onematrix)&(K<=k12*onematrix) ;
part12 = part12 .* pic;
mask12 = part12 .* mask;

part13 = (K>=k12*onematrix)&(K<=k13*onematrix) ;
part13 = part13 .* pic;
mask13 = part13 .* mask;

part14 = (K>=k13*onematrix)&(K<=k14*onematrix) ;
part14 = part14 .* pic;
mask14 = part14 .* mask;

part15 = (K>=k14*onematrix)&(K<=k15*onematrix) ;
part15 = part15 .* pic;
mask15 = part15 .* mask;

part16 = (K>=k15*onematrix)&(K<=k16*onematrix) ;
part16 = part16 .* pic;
mask16 = part16 .* mask;

part17 = (K>=k16*onematrix)&(K<=k17*onematrix) ;
part17 = part17 .* pic;
mask17 = part17 .* mask;

part18 = (K>=k17*onematrix)&(K<=k18*onematrix) ;
part18 = part18 .* pic;
mask18 = part18 .* mask;

part19 = (K>=k18*onematrix)&(K<=k19*onematrix) ;
part19 = part19 .* pic;
mask19 = part19 .* mask;

part20 = (K>=k19*onematrix);
part20 = part20 .* pic;
mask20 = part20 .* mask;


Gausskernel = getGausskernel(3,10);
part1=conv2(part1,Gausskernel,'same');
mask1=conv2(mask1,Gausskernel,'same');

Gausskernel = getGausskernel(9,10);
part2=conv2(part2,Gausskernel,'same');
mask2=conv2(mask2,Gausskernel,'same');

Gausskernel = getGausskernel(11,10);
part3=conv2(part3,Gausskernel,'same');
mask3=conv2(mask3,Gausskernel,'same');

Gausskernel = getGausskernel(11,10);
part4=conv2(part4,Gausskernel,'same');
mask4=conv2(mask4,Gausskernel,'same');

Gausskernel = getGausskernel(11,10);
part5=conv2(part5,Gausskernel,'same');
mask5=conv2(mask5,Gausskernel,'same');

Gausskernel = getGausskernel(13,10);
part6=conv2(part6,Gausskernel,'same');
mask6=conv2(mask6,Gausskernel,'same');

Gausskernel = getGausskernel(13,10);
part7=conv2(part7,Gausskernel,'same');
mask7=conv2(mask7,Gausskernel,'same');

Gausskernel = getGausskernel(13,10);
part8=conv2(part8,Gausskernel,'same');
mask8=conv2(mask8,Gausskernel,'same');

Gausskernel = getGausskernel(15,10);
part9=conv2(part9,Gausskernel,'same');
mask9=conv2(mask9,Gausskernel,'same');

Gausskernel = getGausskernel(15,10);
part10=conv2(part10,Gausskernel,'same');
mask10=conv2(mask10,Gausskernel,'same');

Gausskernel = getGausskernel(15,10);
part11=conv2(part11,Gausskernel,'same');
mask11=conv2(mask11,Gausskernel,'same');

Gausskernel = getGausskernel(17,10);
part12=conv2(part12,Gausskernel,'same');
mask12=conv2(mask12,Gausskernel,'same');

Gausskernel = getGausskernel(17,10);
part13=conv2(part13,Gausskernel,'same');
mask13=conv2(mask13,Gausskernel,'same');

Gausskernel = getGausskernel(17,10);
part14=conv2(part14,Gausskernel,'same');
mask14=conv2(mask14,Gausskernel,'same');

Gausskernel = getGausskernel(19,10);
part15=conv2(part15,Gausskernel,'same');
mask15=conv2(mask15,Gausskernel,'same');

Gausskernel = getGausskernel(19,10);
part16=conv2(part16,Gausskernel,'same');
mask16=conv2(mask16,Gausskernel,'same');

Gausskernel = getGausskernel(19,10);
part17=conv2(part17,Gausskernel,'same');
mask17=conv2(mask17,Gausskernel,'same');

Gausskernel = getGausskernel(21,10);
part18=conv2(part18,Gausskernel,'same');
mask18=conv2(mask18,Gausskernel,'same');

Gausskernel = getGausskernel(21,10);
part19=conv2(part19,Gausskernel,'same');
mask19=conv2(mask19,Gausskernel,'same');

Gausskernel = getGausskernel(21,10);
part20=conv2(part20,Gausskernel,'same');
mask20=conv2(mask20,Gausskernel,'same');


picblur = part1+part2+part3+part4+part5+part6+part7+part8+part9+part10;
picblur = picblur+part11+part12+part13+part14+part15+part16+part17+part18+part19+part20;

maskblur = mask1+mask2+mask3+mask4+mask5+mask6+mask7+mask8+mask9+mask10;
maskblur = maskblur+mask11+mask12+mask13+mask14+mask15+mask16+mask17+mask18+mask19+mask20;


end

