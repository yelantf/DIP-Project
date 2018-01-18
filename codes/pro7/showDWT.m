function [imgdata] = showDWT(c,s,plotflag)
%SHOWDWT 此处显示有关此函数的摘要
%   此处显示详细说明

%% Initialize parameters.
if nargin<2||nargin>3
    error('Wrong parameters!');
end
if nargin<3
    plotflag=true;
end
scale=4;
eleNum=prod(s,2);

%% Handle the approximation coefficients.
imgdata=reshape(mat2gray(c(1:eleNum(1))),s(1,:));
c(1:eleNum(1))=0;
maxVal=max(abs(c(:)))/scale;
c=mat2gray(c,[-maxVal,maxVal]);

%% Construct the target image to display.
N=numel(eleNum)-2;
rInd=eleNum(1);
for k=2:N+1
    lInd=rInd+1;rInd=rInd+3*eleNum(k);
    hvd=c(lInd:rInd);
    h=reshape(hvd(1:eleNum(k)),s(k,:));
    v=reshape(hvd(eleNum(k)+1:2*eleNum(k)),s(k,:));
    d=reshape(hvd(2*eleNum(k)+1:3*eleNum(k)),s(k,:));
    padNum=size(imgdata)-s(k,:);
    Lpad=round(padNum/2);Rpad=padNum-Lpad;
    h=padarray(h,Lpad,0.5,'pre');h=padarray(h,Rpad,0.5,'post');
    v=padarray(v,Lpad,0.5,'pre');v=padarray(v,Rpad,0.5,'post');
    d=padarray(d,Lpad,0.5,'pre');d=padarray(d,Rpad,0.5,'post');
    
    imgdata=padarray(imgdata,[1 1],1,'post');
    h=padarray(h,[1 0],1,'post');
    v=padarray(v,[0 1],1,'post');
    
    imgdata=[imgdata h;v d];
end

if plotflag
    imshow(imgdata);
end

end

