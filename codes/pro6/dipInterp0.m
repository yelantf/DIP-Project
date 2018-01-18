function [interpRes] = dipInterp0(imgData,newX,newY)
%DIPINTERP0 �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��

imgData=double(imgData);
sz=size(imgData);

xmask=newX-floor(newX)<=0.5;
newX(xmask)=floor(newX(xmask));
newX(~xmask)=ceil(newX(~xmask));
ymask=newY-floor(newY)<=0.5;
newY(ymask)=floor(newY(ymask));
newY(~ymask)=ceil(newY(~ymask));

interpRes=imgData(sub2ind(sz,newX,newY));

end

