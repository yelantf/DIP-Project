function [code,start,diffcd,normcd,nstart,ndiffcd] = dipChainCode(gridInds,conn)
%DIPCHAINCODE 此处显示有关此函数的摘要
%   此处显示详细说明

if nargin<1||nargin>2
    error('Wrong parameters!');
end
if nargin<2
    conn=8;
end
curX=inf;curY=inf;kp=0;
for k=1:size(gridInds,1)
    if gridInds(k,1)<curX||(gridInds(k,1)==curX&&gridInds(k,2)<curY)
        curX=gridInds(k,1);
        curY=gridInds(k,2);
        kp=k;
    end
end
start=[curX,curY];
gridInds=[gridInds(kp:end,:);gridInds(1:kp-1,:)];
dirMat=[3,2,1;4,-1,0;5,6,7];
nextInds=[gridInds(2:end,:);gridInds(1,:)];
shifts=nextInds-gridInds+2;
code=dirMat(sub2ind([3,3],shifts(:,1),shifts(:,2)))';
if conn==4
    mask=code==1|code==3|code==5|code==7;
    if sum(mask)==0
        code=code/2;
    else
        error('4-connected code cannot be satisfied.');
    end
end
diffcd=getDiff(code,conn);
[normcd,nstart]=getNormCode(code,gridInds);
ndiffcd=getDiff(normcd,conn);
end

function cdiff=getDiff(cd,conn)
nextcd=[cd(2:end),cd(1)];
cdiff=mod(nextcd-cd,conn);
end

function [normcd,normstart]=getNormCode(cd,inds)
I=find(cd==min(cd));
M=length(I);N=length(cd)+2;
minHead=zeros(M,N);
for k=1:M
    minHead(k,:)=[cd(I(k):end),cd(1:I(k)-1),inds(I(k),:)];
end
tmp=inf(M,1);cur=(1:M)';
for k=2:N
    tmp(1:M,1)=inf;
    tmp(cur,1)=minHead(cur,k);
    cur=find(tmp==min(tmp));
    if length(cur)==1
        normcd=minHead(cur,1:end-2);
        normstart=minHead(cur,end-1:end);
        return;
    end
end
end