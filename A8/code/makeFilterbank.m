function fb = makeFilterbank
% Make filter bank. It is convinient to represent this as a [N N 8] array.
hsize=21;
% or 16
dim=8;
fb=zeros(hsize,hsize,dim);
for i=1:6
    tmp=ceil(i/2);
    tmp1=mod(i,2);
    sigma=tmp*sqrt(2);
    gaussian_f=fspecial('gaussian',hsize,sigma);
    prewitt_f=fspecial('prewitt');
    gaussian_de=conv2(gaussian_f,prewitt_f,'same');
    fb(:,:,i)=gaussian_de;
    if tmp1==1
        fb(:,:,i)=imrotate(fb(:,:,i),90,'bilinear','crop');
    end
end
sigma=2*sqrt(2);
gaussian_lap=fspecial('log',hsize,sigma);
fb(:,:,7)=gaussian_lap;
sigma=sigma/2;
gaussian_lap=fspecial('log',hsize,sigma);
fb(:,:,8)=gaussian_lap;
if dim==16
    for i=9:14
        tmp=ceil((i-8)/2);
        tmp1=mod((i-8),2);
        sigma=tmp*sqrt(2);
        gaussian_f=fspecial('gaussian',hsize,sigma);
        prewitt_f=fspecial('prewitt');
        gaussian_de=conv2(gaussian_f,prewitt_f,'same');
        gaussian_de2=conv2(gaussian_de,prewitt_f,'same');
        fb(:,:,i)=gaussian_de2;
        if tmp1==1
            fb(:,:,i)=imrotate(fb(:,:,i),90,'bilinear','crop');
        end
    end
    sigma=2*sqrt(2);
    gaussian=fspecial('gaussian',hsize,sigma);
    fb(:,:,15)=gaussian;
    sigma=sigma/2;
    gaussian=fspecial('gaussian',hsize,sigma);
    fb(:,:,16)=gaussian;
end


% Random filterbank. You should replace this with your implementation.
% fb = rand([10 10 8]); 