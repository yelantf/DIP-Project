function [X,B,F] = dipBorderClr(I)
%DIPBORDERCLR �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��

if ~isa(I,'logical')
    I=imbinarize(I);
end

F=I;F(2:end-1,2:end-1)=false;
B=dipReconstruct(F,I);
X=logical(I-B);

end

