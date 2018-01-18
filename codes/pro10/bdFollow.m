function [resImg,borderInds] = bdFollow(rawImg)
%BDFOLLOW 此处显示有关此函数的摘要
%   此处显示详细说明

imgdata=false(size(rawImg)+2);
if isa(rawImg,'logical')
    imgdata(2:end-1,2:end-1)=rawImg;
else
    imgdata(2:end-1,2:end-1)=imbinarize(rawImg);
end
[M,N]=size(imgdata);
resImg=false(M,N);

findFlag=false;
for k=2:M-1
    for m=2:N-1
        if imgdata(k,m)
            findFlag=true;
            break;
        end
    end
    if findFlag
        break;
    end
end
dirVec=[M,M-1,-1,-M-1,-M,-M+1,1,M+1];
b0=sub2ind([M,N],k,m);
inds=mod(4+(0:-1:-7),8)+1;
neighs=b0+dirVec(inds);
b1ind=find(imgdata(neighs),1);
b1=neighs(b1ind);c1=neighs(b1ind-1);
resImg(b0)=true;resImg(b1)=true;
b=b1;c=c1;
borderInds=[b0;b1];
while true
    curdir=getDir(b,c,M);
    inds=mod(curdir+(0:-1:-7),8)+1;
    neighs=b+dirVec(inds);
    newbind=find(imgdata(neighs),1);
    newb=neighs(newbind);newc=neighs(newbind-1);
    if newb==b1&&b==b0
        break;
    end
    resImg(newb)=true;
    b=newb;c=newc;
    borderInds=[borderInds;b];
end

resImg=resImg(2:end-1,2:end-1);
[rowind,colind]=ind2sub([M,N],borderInds);
borderInds=[rowind,colind]-1;

end

function dir=getDir(center,neighbor,M)
shiftind=neighbor-center;
switch shiftind
    case M
        dir=0;
    case M-1
        dir=1;
    case -1
        dir=2;
    case -M-1
        dir=3;
    case -M
        dir=4;
    case -M+1
        dir=5;
    case 1
        dir=6;
    case M+1
        dir=7;
end
end