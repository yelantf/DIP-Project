function [resImg,T,yita] = dipThresholding(rawImg,typename,bitnum)
%DIPTHRESHOLDING 此处显示有关此函数的摘要
%   此处显示详细说明

if nargin<2||nargin>3
    error('Wrong parameters!');
end
if nargin<3
    bitnum=8;
end
graylevel=2^bitnum;
imgData=double(rawImg);
[M,N]=size(imgData);
resImg=false(M,N);

[imghist,intensity]=dipHistogram(rawImg,bitnum);

imghist=imghist/(M*N);
avgInt=sum(imghist.*intensity);
sigmaG2=sum(((intensity-avgInt).^2).*imghist);
P1=zeros(1,graylevel);m=P1;
P1(1)=imghist(1);
m(1)=imghist(1)*intensity(1);
for k=2:graylevel-1
    P1(k)=P1(k-1)+imghist(k);
    m(k)=m(k-1)+imghist(k)*intensity(k);
end
sigmaB2=(avgInt*P1-m).^2./(P1.*(1-P1));

switch lower(typename)
    case 'basic'
        for k=2:graylevel-1
            if m(k)>avgInt/2
                break;
            end
        end
        if abs(m(k-1)-avgInt/2)<=abs(m(k)-avgInt/2)
            kstar=k-1;
        else
            kstar=k;
        end
        yita=sigmaB2(kstar)^2/sigmaG2^2;
        T=intensity(kstar);
    case 'otsu'
        [sigvals,inds]=sort(sigmaB2,'descend','MissingPlacement','last');
        mask=sigvals==sigvals(1);
        ks=inds(mask);
        kstar=sum(ks)/length(ks);
        if kstar~=fix(kstar)
            k1=ceil(kstar);k2=k1+1;
            yita1=sigmaB2(k1)^2/sigmaG2^2;
            yita2=sigmaB2(k2)^2/sigmaG2^2;
            if yita1>=yita2
                kstar=k1;
                yita=yita1;
            else
                kstar=k2;
                yita=yita2;
            end
        else
            yita=sigmaB2(kstar)^2/sigmaG2^2;
        end
        T=intensity(kstar);
    otherwise
        error('Unknown thresholding type!');
end

resImg(imgData>T)=true;

end

