function [y,x,A,Cy,ems,mx,Cx] = dipPC(imgData,cnum)
%DIPPC 此处显示有关此函数的摘要
%   此处显示详细说明

if nargin<1||nargin>2
    error('Wrong parameters!');
end

[M,N,n]=size(imgData);K=M*N;
if nargin<2
    cnum=n;
end
imgData=double(reshape(imgData,K,n))';

if K<2
    error('No enough sample vectors!');
else
    mx=sum(imgData,2)/K;
    shiftMat=imgData-mx;
    Cx=shiftMat*shiftMat'/(K-1);
end

[eigVec,eigVal]=eig(Cx);
eigVals=diag(eigVal);
[eigVals,inds]=sort(eigVals,'descend');
eigVec=eigVec(:,inds);
A=eigVec(:,1:cnum)';
y=A*shiftMat;
Cy=A*Cx*A';
x=A'*y+mx;
ems=sum(eigVals(cnum+1:end));

end

