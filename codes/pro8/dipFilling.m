function [H,I_c,F] = dipFilling(I)
%DIPFILLING 此处显示有关此函数的摘要
%   此处显示详细说明

if ~isa(I,'logical')
    I=imbinarize(I);
end

I_c=~I;F=I_c;F(2:end-1,2:end-1)=false;
H=~dipReconstruct(F,I_c);

end

