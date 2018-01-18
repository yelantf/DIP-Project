function [resImg] = dipReconstruct(F,G)
%DIPRECONSTRUCT 此处显示有关此函数的摘要
%   此处显示详细说明

F_t=F';G_t=G';que=[];
[M,N]=size(F);

k=1:numel(F_t);
n1=getUpNeighbor(k,M,N);
for k=1:numel(F_t)
    curNeigh=n1(:,k);
    F_t(k)=max(F_t(curNeigh))&&G_t(k);
end

k=1:numel(F_t);
n2=getDownNeighbor(k,M,N);
for k=numel(F_t):-1:1
    curNeigh=n2(:,k);
    F_t(k)=max(F_t(curNeigh))&&G_t(k);
    mask=F_t(curNeigh)<F_t(k)&F_t(curNeigh)<G_t(curNeigh);
    if sum(mask)>0
        que=[que k];
    end
end

n3=[n1(2:end,:);n2(2:end,:)];
while ~isempty(que)
    k=que(1);
    que(1)=[];
    curNeigh=n3(:,k);
    mask=F_t(curNeigh)<F_t(k)&F_t(curNeigh)~=G_t(curNeigh);
    targn=curNeigh(mask)';
    F_t(targn)=min([F_t(k)*ones(size(targn));G_t(targn)]);
    que=[que targn];
end

resImg=F_t';

end

function neighbors=getUpNeighbor(k,M,N)
    m=floor((k-1)/N)+1;
    n=k-(m-1)*N;
    neighbors=[k;getInd(m-1,n-1,M,N);getInd(m-1,n,M,N);getInd(m-1,n+1,M,N);....
        getInd(m,n-1,M,N)];
    mask=neighbors<=0;
    ks=repmat(k,5,1);
    neighbors(mask)=ks(mask);
end

function neighbors=getDownNeighbor(k,M,N)
    m=floor((k-1)/N)+1;
    n=k-(m-1)*N;
    neighbors=[k;getInd(m,n+1,M,N);getInd(m+1,n-1,M,N);getInd(m+1,n,M,N);....
        getInd(m+1,n+1,M,N)];
    mask=neighbors<=0;
    ks=repmat(k,5,1);
    neighbors(mask)=ks(mask);
end

function ind=getInd(m,n,M,N)
    mask=m<=0|m>M|n<=0|n>N;
    ind=(m-1)*N+n;
    ind(mask)=0;
end