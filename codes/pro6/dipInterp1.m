function [interpRes] = dipInterp1(imgData,newX,newY)
%DIPINTERP1 此处显示有关此函数的摘要
%   此处显示详细说明

imgData=double(imgData);
sz=size(imgData);

x0=floor(newX);y0=floor(newY);
x=newX-x0;y=newY-y0;

f00=imgData(sub2ind(sz,x0,y0));
f10=imgData(sub2ind(sz,x0,y0+1));
fx0=f00+y.*(f10-f00);
f01=imgData(sub2ind(sz,x0+1,y0));
f11=imgData(sub2ind(sz,x0+1,y0+1));
fx1=f01+y.*(f11-f01);
interpRes=fx0+x.*(fx1-fx0);

end

