function [X,B,F] = dipBorderClr(I)
%DIPBORDERCLR 此处显示有关此函数的摘要
%   此处显示详细说明

if ~isa(I,'logical')
    I=imbinarize(I);
end

F=I;F(2:end-1,2:end-1)=false;
B=dipReconstruct(F,I);
X=logical(I-B);

end

