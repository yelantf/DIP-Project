function [resImg] = dipDilate(rawImg,SE,center)
%DIPDILATE 此处显示有关此函数的摘要
%   此处显示详细说明

if nargin<2||nargin>3||(nargin==3&&(numel(center)~=2 ||...
    center(1)>size(SE,1)||center(2)>size(SE,2)|| center(1)<=0 ||center(2)<=0))
    error('Wrong parameters!');
end
if nargin<3
    center=floor((size(SE)+1)/2);
end
if isa(rawImg,'logical')
    imgdata=rawImg;
else
    imgdata=imbinarize(rawImg);
end
[M,N]=size(imgdata);

padRow=size(SE,1)-1;padCol=size(SE,2)-1;
imgdata=padarray(imgdata,[padRow,padCol],0,'both');
resImg=false(size(imgdata));
SE_r=SE(end:-1:1,end:-1:1);
center(1)=size(SE,1)-center(1)+1;center(2)=size(SE,2)-center(2)+1;

for k=1:padRow+M
    for m=1:padCol+N
        resImg(k+center(1)-1,m+center(2)-1)=sum(sum(SE_r&imgdata(k:k+padRow,m:m+padCol)));
    end
end

resImg=resImg(padRow+1:padRow+M,padCol+1:padCol+N);

end

