function [resImg] = dipOpen(rawImg,SE,center)
%DIPOPEN �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
if nargin<2||nargin>3||(nargin==3&&(numel(center)~=2 ||...
    center(1)>size(SE,1)||center(2)>size(SE,2)|| center(1)<=0 ||center(2)<=0))
    error('Wrong parameters!');
end
if nargin<3
    center=floor((size(SE)+1)/2);
end

resImg=dipErode(rawImg,SE,center);
resImg=dipDilate(resImg,SE,center);

end

