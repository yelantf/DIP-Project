function [resdata,dwtimg] = DWTCompress(rawimg,wavetype,level,threshold)
%DWTCOMPRESS 此处显示有关此函数的摘要
%   此处显示详细说明

imgdata=double(rawimg);

[c,s]=dip2DFWT(imgdata,level,wavetype);
dwtimg=showDWT(c,s,false);

appEle=s(1,1)*s(1,2);
mask=c<threshold;
mask(1:appEle)=false;
c(mask)=0;

resdata=dip2DIFWT(c,s,wavetype);

end

